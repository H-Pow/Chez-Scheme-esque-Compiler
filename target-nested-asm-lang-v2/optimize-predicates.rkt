#lang racket

(require cpsc411/compiler-lib
         cpsc411/langs/v4
         assign-homes-opt
         asm-lang-progs)

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
  )

(define nested-asm-lang-progs
  '((module (true)) (module (false))
                    (module (not (true)))
                    (module (not (false)))
                    (module (if (true)))))

(module+ test
  (require rackunit)
  ;; TODO: When we add more tests for assign-home-opt, use those to generate input
  ;; for tests here.
  (define-syntax-rule (check-by-interp p)
    )
  (check-equal? (interp-nested-asm-lang-v4 p) (interp-nested-asm-lang-v4 (optimize-predicates p)))

  (check-by-interp `(module halt 0
                      ))
  (check-by-interp (assign-homes-opt '(module ()
                                              (begin
                                                (set! x.1 2)
                                                (set! x.2 2)
                                                (set! tmp.2 x.1)
                                                (set! tmp.2 (+ tmp.2 x.2))
                                                (halt tmp.2))
                                        )))
  (for-each check-by-interp (map (compose interp-nested-asm-lang assign-homes-opt) asm-lang-progs))

  (check-by-interp `(module))
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
                                                  (set! rax 1)
                                                  (set! rax -1))))
                `(module (set! rax -1)))
  (check-equal? (optimize-predicates `(module (if (true)
                                                  (set! rax 1)
                                                  (set! rax -1))))
                `(module (set! rax 1))))
