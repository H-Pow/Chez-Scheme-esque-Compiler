#lang racket

(require cpsc411/compiler-lib
         "common.rkt")

(provide uniquify)

; exprs-lang-v7 -> exprs-unique-lang-v7
(define (uniquify p)
  ;; env is an immutable association list that maps x to label/aloc/prim-f
  (define DEFAULT-ENV (map cons prim-f prim-f))
  ;; triv env -> unique-triv
  ; triv	 	::=	 	+label
  ; |	 	+aloc
  ; |	 	+prim-f
  ; |	 	-x
  ; |	 	fixnum
  ; |	 	#t
  ; |	 	#f
  ; |	 	empty
  ; |	 	(void)
  ; |	 	(error uint8)
  ; |	 	ascii-char-literal
  (define (uniquify-triv triv env)
    (match triv
      [(? (or/c int61? #t #f 'empty ascii-char-literal?)) triv]
      ['(void) triv]
      [`(error (? uint8?)) triv]
      [(? (or/c name? prim-f?)) (dict-ref env triv)]))
  ;; value env -> unique-value
  ; value	 	::=	 	triv
  ;  	|	 	(let ([+aloc -x value] ...) value)
  ;  	|	 	(if value value value)
  ;  	|	 	(call value value ...)
  (define (uniquify-value value env)
    (match value
      [`(call ,val1 ,val* ...) `(call ,(uniquify-value val1 env)
                                      ,@(map (curryr uniquify-value env) val*))]
      [`(if ,val0 ,val1 ,val2) `(if ,(uniquify-value val0 env)
                                    ,(uniquify-value val1 env)
                                    ,(uniquify-value val2 env))]
      [`(let ([,x* ,val*] ...) ,val)
       (let-values ([(env/updated aloc* unique-val*)
                     (for/fold ([env/updated env]
                                [aloc* '()]
                                [unique-val* '()])
                               ([x x*]
                                [val val*])
                       (define aloc (fresh x))
                       (values (dict-set env/updated x aloc)
                               (cons aloc aloc*)
                               ;use original env, this is not let*
                               (cons (uniquify-value val env) unique-val*)))])
         `(let ,(map list aloc* unique-val*)
            ,(uniquify-value val env/updated)))]
      [_ (uniquify-triv value env)]))
  ;  p	 	::=	 	(module (define x (lambda (x ...) value)) ... value)
  ;; (define x (lambda (x ...) value)) env -> env
  ;; returns an updated env with the definition's x as a new label
  ;; this step is necessary for mutual recursion
  (define (mark-def def env)
    (match def
      [`(define ,x (lambda (,_ ...) ,_))
       (dict-set env x (fresh-label x))]))

  ;; (define x (lambda (x ...) value)) env -> (define label (lambda (aloc ...) unique-value))
  (define (uniquify-def def env)
    (match def
      [`(define ,x (lambda (,param* ...) ,value))
       (define param/aloc* (map fresh param*))
       `(define ,(dict-ref env x) (lambda ,param/aloc*
          ,(uniquify-value value (append (map cons param* param/aloc*) env))))]))
  (match p
    [`(module ,def* ... ,value)
     (define env (foldr mark-def DEFAULT-ENV def*))
     `(module ,@(map (curryr uniquify-def env) def*) ,(uniquify-value value env))]))

(module+ test
  (require rackunit
           cpsc411/langs/v7)
  (define-syntax-rule (check-by-interp p)
    (check-equal? (interp-expr-lang-v7 p) (interp-expr-unique-lang-v7 (uniquify p))))
  )