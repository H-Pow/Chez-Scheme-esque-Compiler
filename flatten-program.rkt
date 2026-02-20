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
(define (binop? b) (or (eq? b '+)
                       (eq? b '*)))
;; block-asm-lang-v4 -> para-asm-lang-v4
;; Compile Block-asm-lang v4 to Para-asm-lang v4 by flattening basic blocks into labeled instructions.
(define (flatten-program bal4)
  (define flatten-opand identity)
  (define flatten-loc identity)
  (define flatten-triv identity)
  (define (flatten-effect fx)
    (match fx
      [`(set! ,(? loc? loc) ,(? triv? triv))
       (TODO loc triv)]
      [`(set! ,loc (,binop ,loc ,opand)) #:when (and (loc? loc)
                                                     (binop? binop)
                                                     (opand? opand))
                                                     (TODO loc binop opand)]))
  (define (flatten-tail tail)
    (match tail
      [`(halt ,opand) (TODO opand)]
      [`(jump ,trg) (TODO trg)]
      [`(begin ,fx* ... ,tail) (TODO fx* tail)]))
  (define (flatten-b b)
    (match b
      [`(define ,(? label? label) ,tail) (TODO label tail)]))
  (define (flatten-p p)
    (match p
      [`(module ,b* ... ,b) (TODO b* b)]))
  (flatten-p bal4))
(module+ test
  (require rackunit)
  )
