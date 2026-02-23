#lang racket

(require cpsc411/compiler-lib
         cpsc411/langs/v4
         "assign-homes.rkt")

(provide optimize-predicates
         nested-asm-lang-progs)

;  p	 	::=	 	(module tail)

;   pred	 	::=	 	(relop loc triv)
;  	 	|	 	(true)
;  	 	|	 	(false)
;  	 	|	 	(not pred)
;  	 	|	 	(begin effect ... pred)
;  	 	|	 	(if pred pred pred)

;   tail	 	::=	 	(halt triv)
;  	 	|	 	(begin effect ... tail)
;  	 	|	 	(if pred tail tail)

;   effect	 	::=	 	(set! loc triv)
;  	 	|	 	(set! loc_1 (binop loc_1 triv))
;  	 	|	 	(begin effect ... effect)
;  	 	|	 	(if pred effect effect)

;   triv	 	::=	 	int64
;  	 	|	 	loc

;   loc	 	::=	 	reg
;  	 	|	 	fvar

;   reg	 	::=	 	rsp
;  	 	|	 	rbp
;  	 	|	 	rax
;  	 	|	 	rbx
;  	 	|	 	rcx
;  	 	|	 	rdx
;  	 	|	 	rsi
;  	 	|	 	rdi
;  	 	|	 	r8
;  	 	|	 	r9
;  	 	|	 	r12
;  	 	|	 	r13
;  	 	|	 	r14
;  	 	|	 	r15

;   binop	 	::=	 	*
;  	 	|	 	+

;   relop	 	::=	 	<
;  	 	|	 	<=
;  	 	|	 	=
;  	 	|	 	>=
;  	 	|	 	>
;  	 	|	 	!=

;   fvar	 	::=	 	fvar?

;   int64	 	::=	 	int64?

;; (nested-asm-lang-v4 p) -> (nested-asm-lang-v4 p)
;; Optimizes Nested-asm-lang-v4 programs by analyzing and simplifying predicates
(define (optimize-predicates p)

  ;; (nested-asm-lang-v4?) -> boolean
  ;; wrapper for int64?, may change implementation if optimize-predicates implementation changes
  ;; to statically evaluate a wider array of expressions.
  (define (concrete? val)
    (int64? val))

  (define (abstract-triv triv env)
    (if (int64? triv)
        triv
        (hash-ref env triv 'unknown)))

  (define (abstract-binop op v1 v2 env)
    (define v1 (abstract-triv v1 env))
    (define v2 (abstract-triv v2 env))
    (match* (v1 v2)
      [((? int64?) (? int64?)) (op v1 v2)]
      [(_ _) 'unknown]))

(define (patch-relop op)
  (match op
    ['> >]           
    ['< <]
    ['= =]
    ['>= >=]
    ['<= <=]
    ['!= (λ (x y) (not (= x y)))]))

  ;; (nested-asm-lang-v4 relop loc triv (list (loc . (triv | 'unknown)))
  ;;                                          -> '(true) | '(false) | 'unknown
  ;; Attempts to resolve (relop v1 v2), using static information stored in env. Returns 'unknown
  ;; if there is not enough static information available.
  (define (abstract-relop relop loc triv env)
    (define v1 (abstract-triv loc env))
    (define v2 (abstract-triv triv env))
    (match* (v1 v2)
      [((? concrete?) (? concrete?))
       (if ((patch-relop relop) v1 v2)
           '(true)
           '(false))]
      [(_ _) `(,relop ,loc ,triv)]))

  (define (update-env effect env)
    (match effect
      [`(set! ,loc ,triv)
       (if (int64? triv)
           (hash-set! env loc triv)
           (hash-set! env loc (hash-ref env triv 'unknown)))]
      [`(set! ,loc1 (,op ,loc1 ,triv))
       (define cur-val (hash-ref env loc1 'unknown))
       (if (int64? cur-val)
           (hash-set! env loc1 (abstract-binop op cur-val triv env))
           (hash-set! env loc1 'unknown))]))

  (define (optimize-pred pred env)
    (match pred
      [`(if (not ,pred) ,pred2 ,pred3) (optimize-pred `(if ,pred ,pred3 ,pred2) env)]
      [`(if ,cond ,then ,else)
       (define optimized-cond (optimize-pred cond env))
       (define env-then (hash-copy env))
       (define env-else (hash-copy env))
       (cond
         [(equal? optimized-cond '(true)) (optimize-pred then env-then)]
         [(equal? optimized-cond '(false)) (optimize-pred else env-else)]
         [else
          `(if ,optimized-cond
               ,(optimize-pred then env-then)
               ,(optimize-pred else env-else))])]
      [`(begin
          ,effects ...
          ,pred)
       `(begin
          ,@(for/list ([e effects])
              (optimize-effect e env))
          ,(optimize-pred pred env))]
      [`(,relop ,loc ,triv) (abstract-relop relop loc triv env)]
      [_ pred]))

  (define (optimize-effect effect env)
    (match effect
      [`(set! ,loc ,rest)
       (begin
         (update-env effect env)
         effect)]
      [`(begin
          ,effects ...)
       `(begin
          ,@(for/list ([effect effects])
              (optimize-effect effect env)))]
      [`(if (not ,cond) ,then ,else) (optimize-effect `(if ,cond ,else ,then) env)]
      [`(if ,cond ,then ,else)
       (define optimized-cond (optimize-pred cond env))
       (define env-then (hash-copy env))
       (define env-else (hash-copy env))
       (cond
         [(equal? optimized-cond '(true)) (optimize-effect then env-then)]
         [(equal? optimized-cond '(false)) (optimize-effect else env-else)]
         [else
          `(if ,optimized-cond
               ,(optimize-effect then env-then)
               ,(optimize-effect else env-else))])]))

  (define (optimize-tail tail env)
    (match tail
      [`(begin
          ,effects ...
          tail)
       `(begin
          ,@(for/list ([effect effects])
              (optimize-effect effect env))
          ,(optimize-tail tail env))]
      [`(if (not ,pred) ,t1 ,t2) (optimize-tail `(if ,pred ,t2 ,t1) env)]
      [`(if ,pred ,t1 ,t2)
       (define optimized-cond (optimize-pred pred env))
       (define env-then (hash-copy env))
       (define env-else (hash-copy env))
       (cond
         [(equal? optimized-cond '(true)) (optimize-tail t1 env-then)]
         [(equal? optimized-cond '(false)) (optimize-tail t2 env-else)]
         [else
          `(if ,optimized-cond
               ,(optimize-tail t1 env-then)
               ,(optimize-tail t2 env-else))])]
      [_ tail]))

  (define (optimize-p p)
    (match p
      [`(module ,tail) `(module ,(optimize-tail tail (make-hash)))]))

  (optimize-p p))

(define nested-asm-lang-progs
  '((module (true)) (module (false))
                    (module (not (true)))
                    (module (not (false)))
                    (module (if (true)))))

(define asm-lang-progs
  '((module () (halt 1)
      )
    (module ()
            (begin
              (halt 1))
      )
    (module ()
            (begin
              (begin
                (set! x.1 1))
              (halt x.1))
      )
    (module ()
            (begin
              (begin
                (set! x.1 1)
                (set! x.1 (+ x.1 1)))
              (halt x.1))
      )
    (module ()
            (begin
              (begin
                (set! x.1 1)
                (set! x.1 (+ x.1 1)))
              (set! x.1 1)
              (halt x.1))
      )
    (module ()
            (begin
              (set! x.1 1)
              (set! x.2 2)
              (set! x.3 3)
              (halt x.3))
      )))

(module+ test
  (require rackunit)
  ;; TODO: When we add more tests for assign-home-opt, use those to generate input
  ;; for tests here.
  (define-syntax-rule (check-by-interp p)
    (check-equal? (interp-nested-asm-lang-v4 p) (interp-nested-asm-lang-v4 (optimize-predicates p))))

;   (check-by-interp (assign-homes-opt '(module ()
;                                               (begin
;                                                 (set! x.1 2)
;                                                 (set! x.2 2)
;                                                 (set! tmp.2 x.1)
;                                                 (set! tmp.2 (+ tmp.2 x.2))
;                                                 (halt tmp.2))
;                                         )))
;     (define inputs (map assign-homes-opt asm-lang-progs))
    
;   (for-each check-equal?
;             (map (compose interp-nested-asm-lang-v4 assign-homes-opt) asm-lang-progs)
;             (map (compose interp-nested-asm-lang-v4 optimize-predicates assign-homes-opt)
;                  asm-lang-progs))
; (for-each
;  (λ (prog)
;    (define input (assign-homes-opt prog))
;    (check-equal? (interp-nested-asm-lang-v4 input)
;                  (interp-nested-asm-lang-v4 (optimize-predicates input))))
;  asm-lang-progs)

  (check-equal? (optimize-predicates `(module (begin
                                                (true))))
                `(module (begin
                           (true))))
  (check-equal? (optimize-predicates `(module (begin
                                                (false))))
                `(module (begin
                           (false))))
  (check-equal? (optimize-predicates `(module (begin
                                                (false))))
                `(module (begin
                           (false))))

  (check-equal? (optimize-predicates `(module (if (true)
                                                  (true)
                                                  (false))))
                `(module (true)))
  (check-equal? (optimize-predicates `(module (if (true)
                                                  (false)
                                                  (true))))
                `(module (false)))
  (check-equal? (optimize-predicates `(module (if (false)
                                                  (false)
                                                  (true))))
                `(module (true)))
  (check-equal? (optimize-predicates `(module (if (false)
                                                  (begin
                                                    (set! rax 1)
                                                    (false))
                                                  (begin
                                                    (set! rax -1)
                                                    (true)))))
                `(module (begin
                           (set! rax -1)
                           (true))))
  (check-equal? (optimize-predicates `(module (if (true)
                                                  (begin
                                                    (set! rax 1)
                                                    (false))
                                                  (begin
                                                    (set! rax -1)
                                                    (true)))))
                `(module (begin
                           (set! rax 1)
                           (false))))
  (check-equal? (optimize-predicates `(module (if (> 1 0)
                                                  (begin
                                                    (set! rax 1)
                                                    (false))
                                                  (begin
                                                    (set! rax -1)
                                                    (true)))))
                `(module (begin
                           (set! rax 1)
                           (false))))
  (check-equal? (optimize-predicates `(module (if (not (> 1 0))
                                                  (begin
                                                    (set! rax 1)
                                                    (false))
                                                  (begin
                                                    (set! rax -1)
                                                    (true)))))
                `(module (begin
                           (set! rax -1)
                           (true))))
  (check-equal? (optimize-predicates `(module (if (!= 2 42)
                                                  (begin
                                                    (set! rax 1)
                                                    (false))
                                                  (begin
                                                    (set! rax -1)
                                                    (true)))))
                `(module (begin
                           (set! rax 1)
                                                    (false))))
  (check-equal? (optimize-predicates `(module (begin
                                                (set! rax ,(max-int 64))
                                                (set! rbx ,(min-int 64))
                                                (set! rax (+ rax rbx))
                                                (set! rdi rax) ;; r[rdi] = -1
                                                (if (< rdi 0)
                                                    (halt 1)
                                                    (halt 0)))))
                `(module (begin
                           (set! rax ,(max-int 64))
                           (set! rbx ,(min-int 64))
                           (set! rax (+ rax rbx))
                           (set! rdi rax) ;; r[rdi] = -1
                           (if (< rdi 0)
                               (halt 1)
                               (halt 0)))))
                               
                               
                               )
