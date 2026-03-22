#lang racket

(require cpsc411/compiler-lib
         "common.rkt")

(provide implement-safe-primops)

(define ERROR-NOT-FIXNUM '(error 2))

;; BINOP-ENV is a mutable dict matching binop to (label or primop)
;; since we have already uniquify the functions we shouldn't have to worry about shadowing
(define BINOP-ENV (make-hasheq))
;; DEF-ENV is a mutable dict matching binop to either #f or a definition block in expr-unsafe
(define DEF-ENV (make-hasheq))
;; usage is (setof binop), a mutable state acculator storing
;;    which binop is actually used
(define usage (weak-seteq))

;; binop -> (values (#f or unsafe-def) (label or primop))
;; creates relevant definition for given binop and
;; ASSUMES that the order of the binop and binop/unsafe is the same
(define (binop->def bo)
  (if (eq? bo 'eq?)
      (values #f 'eq?)
      (let ([lab (fresh-label bo)]
            [aloc/a (fresh 'opand1)]
            [aloc/b (fresh 'opand2)]
            [unsafe-fx (list-ref binop/unsafe (index-of binop bo))])
        (values `(define ,lab
                   (lambda (,aloc/a ,aloc/b)
                     (if (fixnum? ,aloc/a)
                         (if (fixnum? ,aloc/b)
                             (,unsafe-fx ,aloc/a ,aloc/b)
                             ,ERROR-NOT-FIXNUM)
                         ,ERROR-NOT-FIXNUM)))
                lab))))

(for ([bo binop])
  (let-values ([(def label-or-primop) (binop->def bo)])
    (dict-set! BINOP-ENV bo label-or-primop)
    (dict-set! DEF-ENV bo def)))



;; exprs-unique-lang-v7 ->  exprs-unsafe-data-lang v7
;; Implement safe primitive operations by inserting procedure definitions
;;    for each primitive operation which perform dynamic tag checking, to ensure type safety.
(define (implement-safe-primops p)
  ;could just inline every prim-f instead of tracking usage... maybe
  ;  triv	 	::=	 	label
  ;  	 	|	 	aloc
  ;  	 	|	 	-prim-f
  ;  	 	|	 	fixnum
  ;  	 	|	 	#t
  ;  	 	|	 	#f
  ;  	 	|	 	empty
  ;  	 	|	 	(void)
  ;  	 	|	 	(error uint8)
  ;  	 	|	 	ascii-char-literal
  ;   triv -> (unsafe-triv or primop)
  ;; EFFECT: adds referenced binop to usage
  (define (implement-triv! triv)
    (match triv
      [(? (or/c label? aloc? int61? boolean? 'empty ascii-char-literal?)) triv]
      [`(error ,(? uint8?)) triv]
      ['(void) triv]
      [(? binop?) (set-add! usage triv)
                  (dict-ref BINOP-ENV triv)]
      [(? unop?) triv]))
  ; value	 	::=	 	triv
  ;  	|	 	+(primop value ...)
  ;  	|	 	(call value value ...)
  ;  	|	 	(let ([aloc value] ...) value)
  ;  	|	 	(if value value value)
  ;; value ((unsafe-triv or primop) -> unsafe-value) -> unsafe-value
  ;; EFFECT: adds referenced binop to usage
  (define (implement-value! value [k identity])
    (match value
      [`(if ,val0 ,val1 ,val2)
       `(if ,(implement-value! val0)
            ,(implement-value! val1 k)
            ,(implement-value! val2 k))]
      [`(let ([,aloc* ,val*] ...) ,val)
       `(let ,(map list aloc* (map implement-value! val*)) ,(implement-value! val k))]
      [`(call ,val0 ,opand* ...)
       (implement-value! val0 (λ(triv) (if (primop? triv)
                                           `(,triv ,@(map implement-value! opand*))
                                           `(call ,triv ,@(map implement-value! opand*)))))]
      [_ (k (implement-triv! value))]))
  ;   p	 	::=	 	(module (define label (lambda (aloc ...) value)) ... value)
  ;; EFFECT: adds referenced binop to usage
  (define (implement-def! def)
    (match def
      [`(define ,label (lambda (,aloc* ...) ,value))
       `(define ,label (lambda ,aloc* ,(implement-value! value)))]))
  (match p
    [`(module ,def* ... ,value)
     (define def/unsafe* (map implement-def! def*))
     (define value/unsafe (implement-value! value))
     (define binop-defs (filter-map (curry dict-ref DEF-ENV) (set->list usage)))
     `(module ,@binop-defs ,@def/unsafe* ,value/unsafe)]))

(module+ test
  (require rackunit
           cpsc411/langs/v7)
  (define-syntax-rule (check-by-interp p)
    (check-equal? (interp-exprs-unique-lang-v7 p)
                  (interp-exprs-unsafe-data-lang-v7 (implement-safe-primops p))))
  (check-by-interp `(module 1))
  (check-by-interp `(module #t))
  (check-by-interp `(module #f))
  (check-by-interp `(module #\a))

  (check-by-interp `(module (define L.fact.0 (lambda (x.0)
                                               (if (call <= x.0 1) 1
                                                   (call * x.0 (call L.fact.0 (call - x.0 1))))))
                      (call L.fact.0 5)
                      )
                   )

  (check-by-interp `(module (define L.fact.0 (lambda (x.0 a.0)
                                               (if (call <= x.0 1) a.0
                                                   (call L.fact.0 (call - x.0 1) (call * x.0 a.0)))))
                      (call L.fact.0 5 1)
                      ))

  (check-by-interp `(module (define L.fib.0 (lambda (x.0)
                                              (if (call <= x.0 1) x.0
                                                  (call +
                                                        (call L.fib.0 (call - x.0 1))
                                                        (call L.fib.0 (call - x.0 2))))))
                      (call L.fib.0 5)
                      ))
  )