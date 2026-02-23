#lang racket

(require cpsc411/compiler-lib)

(provide flatten-program)

;; block-asm-lang-v4
; p	 	::=	 	(module b ... b)
;   b	 	::=	 	(define label tail)
;   tail	 	::=	 	(halt opand)
;  	 	|	 	(jump trg)
;  	 	|	 	(begin effect ... tail)
;  	 	|	 	(if (relop loc opand) (jump trg) (jump trg))
;   effect	 	::=	 	(set! loc triv)
;  	 	|	 	(set! loc_1 (binop loc_1 opand))
;   triv	 	::=	 	opand
;  	 	|	 	label
;   opand	 	::=	 	int64
;  	 	|	 	loc
;   trg	 	::=	 	label
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
;   int64	 	::=	 	int64?
;   fvar	 	::=	 	fvar?
;   label	 	::=	 	label?
;; --------------------------
;; para-asm-lang-v4
; p	 	::=	 	(begin s ...)
;   s	 	::=	 	(halt opand)
;  	 	|	 	(set! loc triv)
;  	 	|	 	(set! loc_1 (binop loc_1 opand))
;  	 	|	 	(jump trg)
;  	 	|	 	(with-label label s)
;  	 	|	 	(compare loc opand)
;  	 	|	 	(jump-if relop trg)
;   triv	 	::=	 	opand
;  	 	|	 	label
;   opand	 	::=	 	int64
;  	 	|	 	loc
;   trg	 	::=	 	label
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
;   int64	 	::=	 	int64?
;   fvar	 	::=	 	fvar?
;   label	 	::=	 	label?

(define reg? register?)
(define loc? (or/c reg? fvar?))
(define opand? (or/c int64? loc?))
(define triv? (or/c opand? label?))
(define trg? (or/c label? loc?))
(define (binop? b)
  (or (eq? b '+) (eq? b '*)))
;; block-asm-lang-v4 -> para-asm-lang-v4
;; Compile Block-asm-lang v4 to Para-asm-lang v4 by flattening basic blocks into labeled instructions.
(define (flatten-program bal4)
  (define flatten-effect identity)

  (define (flatten-tail tail)
    (match tail
      [`(halt ,(? opand?)) (list tail)]
      [`(jump ,(? trg?)) (list tail)]
      [`(begin
          ,fx* ...
          ,tail)
       (append (map flatten-effect fx*) (flatten-tail tail))]
      [`(if (,relop ,loc ,opand)
            (jump ,trg)
            (jump ,trg2))
       `((compare ,loc ,opand) (jump-if ,relop ,trg) (jump ,trg2))]))
  (define (flatten-b b)
    (match b
      [`(define ,(? label? label)
          ,tail)
       (let ([s* (flatten-tail tail)]) `((with-label ,label ,(first s*)) ,@(rest s*)))]))
  (define (flatten-p p)
    (match p
      [`(module ,b* ...
          ,b)
       `(begin
          ,@(foldr append '() (map flatten-b b*))
          ,@(flatten-b b))]))
  (flatten-p bal4))
(module+ test
  (require rackunit
           cpsc411/langs/v4)
  (define-syntax-rule (check-flatten-program bal4 pal4)
    (check-equal? (flatten-program bal4) pal4))
  (define-syntax-rule (check-by-interp bal4)
    (check-equal? (interp-block-asm-lang-v4 bal4) (interp-para-asm-lang-v4 (flatten-program bal4))))

  (check-flatten-program `(module (define L.start.1 (halt 4)))
                         `(begin
                            (with-label L.start.1 (halt 4))))

  (check-flatten-program `(module (define L.start.1 (jump L.start.1)))
                         `(begin
                            (with-label L.start.1 (jump L.start.1))))
  (check-flatten-program `(module (define L.start.1
                                    (begin
                                      (set! rax L.start.1)
                                      (jump rax))))
                         `(begin
                            (with-label L.start.1 (set! rax L.start.1))
                            (jump rax)))
  (check-flatten-program `(module (define L.start.1
                                    (begin
                                      (set! rax L.start.1)
                                      (jump rax)))
                                  (define L.end.1 (halt 5))
                            )
                         `(begin
                            (with-label L.start.1 (set! rax L.start.1))
                            (jump rax)
                            (with-label L.end.1 (halt 5))))
  (check-flatten-program `(module (define L.start.1
                                    (begin
                                      (set! rax 5)
                                      (if (> rax 2)
                                          (jump L.start.1)
                                          (jump L.end.1))))
                                  (define L.end.1 (halt 5))
                            )
                         `(begin
                            (with-label L.start.1 (set! rax 5))
                            (compare rax 2)
                            (jump-if > L.start.1)
                            (jump L.end.1)
                            (with-label L.end.1 (halt 5))))
  (check-flatten-program `(module (define L.start.1
                                    (begin
                                      (set! rdi 5)
                                      (set! rax 1)
                                      (jump L.fact.1)))
                                  (define L.fact.1
                                    (begin
                                      (set! rax (* rax rdi))
                                      (set! rdi (+ rdi -1))
                                      (if (> rdi 0)
                                          (jump L.fact.1)
                                          (jump L.end.1))))
                            (define L.end.1 (halt rax)))
                         `(begin
                            (with-label L.start.1 (set! rdi 5))
                            (set! rax 1)
                            (jump L.fact.1)
                            (with-label L.fact.1 (set! rax (* rax rdi)))
                            (set! rdi (+ rdi -1))
                            (compare rdi 0)
                            (jump-if > L.fact.1)
                            (jump L.end.1)
                            (with-label L.end.1 (halt rax))))
  (check-by-interp `(module (define L.start.1
                              (begin
                                (set! rdi 5)
                                (set! rax 1)
                                (jump L.fact.1)))
                            (define L.fact.1
                              (begin
                                (set! rax (* rax rdi))
                                (set! rdi (+ rdi -1))
                                (if (> rdi 0)
                                    (jump L.fact.1)
                                    (jump L.end.1))))
                      (define L.end.1 (halt rax))))
  (check-by-interp `(module (define L.start.1
                              (begin
                                (set! rax 5)
                                (if (< rax 2)
                                    (jump L.start.1)
                                    (jump L.end.1))))
                            (define L.end.1 (halt 5))
                      ))
  (check-by-interp `(module (define L.end.1 (halt 5)))))
