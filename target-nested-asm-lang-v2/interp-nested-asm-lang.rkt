#lang racket
(require cpsc411/compiler-lib)
(provide interp-nested-asm-lang)

;  p	 	::=	 	tail	 	 	 	 
;   tail	 	::=	 	(halt triv)
;  	 	|	 	(begin effect ... tail)
;   effect	 	::=	 	(set! loc triv)
;  	 	|	 	(set! loc_1 (binop loc_1 triv))
;  	 	|	 	(begin effect ... effect)
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
;   int64	 	::=	 	int64?
;   fvar	 	::=	 	fvar?
(define (interp-nested-asm-lang p)
    (define env (make-hasheq))
    (define (register? r) (memq r '(rsp rbp rax rbx rcx rds rsi rdi r8 r9 r12 r13 r14 r15)))
    (define (binop? bo) (memq bo '(+ *)))
    (define (binop->fun bo)
        (match bo
            ['* x64-mul]
            ['+ x64-add]))
    (define loc? (or/c register? fvar?))
    (define triv? (or/c int64? loc?))
    (define (interp-triv triv)
        (match triv 
            [(? int64?) triv]
            [(? loc?) (dict-ref env triv)]))
    (define (interp-effect fx)
        (match fx 
            [`(set! ,(? loc? loc) (,(? binop? binop) ,loc ,(? triv? triv)))
                (dict-set! env loc ((binop->fun binop) (dict-ref env loc) (interp-triv triv)))]
            [`(set! ,(? loc? loc) ,(? triv? triv)) (dict-set! env loc (interp-triv triv))]
            [`(begin ,fxs ... ,fx) (for-each interp-effect fxs) (interp-effect fx)]))
    (define (interp-tail tail)
        (match tail
            [`(halt ,triv) (interp-triv triv)]
            [`(begin ,fxs ... ,tail) (for-each interp-effect fxs)
            (interp-tail tail)]))
    (interp-tail p))