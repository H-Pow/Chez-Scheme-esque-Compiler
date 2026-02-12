#lang racket
(require cpsc411/compiler-lib)
(provide patch-instructions)
;para-asm-lang-v2
; p	 	::=	 	(begin effect ... (halt triv))
; effect	 	::=	 	(set! loc triv)
;  	|	 	(set! loc_1 (binop loc_1 triv))
; triv	 	::=	 	int64
;  	|	 	loc
; loc	 	::=	 	reg
;  	|	 	fvar
; reg	 	::=	 	rsp
;  	|	 	rbp
;  	|	 	rax
;  	|	 	rbx
;  	|	 	rcx
;  	|	 	rdx
;  	|	 	rsi
;  	|	 	rdi
;  	|	 	r8
;  	|	 	r9
;  	|	 	r12
;  	|	 	r13
;  	|	 	r14
;  	|	 	r15
; binop	 	::=	 	*
;  	|	 	+
; int64	 	::=	 	int64?
; fvar	 	::=	 	fvar?
; -----------------------
; paren-x64-fvars-v2
; p	 	::=	 	(begin s ...)

; s	 	::=	 	(set! fvar int32)
;  	|	 	(set! fvar reg)
;  	|	 	(set! reg loc)
;  	|	 	(set! reg triv)
;  	|	 	(set! reg_1 (binop reg_1 int32))
;  	|	 	(set! reg_1 (binop reg_1 loc))

; triv	 	::=	 	reg
;  	|	 	int64

; loc	 	::=	 	reg
;  	|	 	fvar

; reg	 	::=	 	rsp
;  	|	 	rbp
;  	|	 	rax
;  	|	 	rbx
;  	|	 	rcx
;  	|	 	rdx
;  	|	 	rsi
;  	|	 	rdi
;  	|	 	r8
;  	|	 	r9
;  	|	 	r10
;  	|	 	r11
;  	|	 	r12
;  	|	 	r13
;  	|	 	r14
;  	|	 	r15

; binop	 	::=	 	*
;  	|	 	+
;para-asm-lang-v2 -> paren-x64-fvars-v2
(define (patch-instructions pal2)
  (define aux-reg (current-patch-instructions-registers))
  (define loc? (or/c fvar? register?))

  ;    p	 	::=	 	(begin effect ... (halt triv))
  (define (patch-p p)
    (match p
      [`(begin ,fxs ... (halt ,triv))
       (patch-fx* fxs
                  (λ(fvar-s*)
                    `(begin ,@fvar-s*
                            (set! rax ,triv))))])
    )
  (define (patch-fx* fx* k)
    (if (empty? fx*)
        (k '())
        (patch-fx (first fx*)
                  (λ(fvar-s*)
                    (patch-fx* (rest fx*)
                               (λ(fvar-s*2)
                                 (k (append fvar-s* fvar-s*2))))))))
  ; s	 	::=	 	(set! fvar int32)
  ;  	|	 	(set! fvar reg)
  (define (patch-fx/fvar fx k)
    (match fx
      [`(set! ,fv (,binop ,fv ,val))
       (k `((set! ,(car aux-reg) ,val)
            (set! ,(car aux-reg) (,binop ,(car aux-reg) ,fv))
            (set! ,fv ,(car aux-reg))))]
      [`(set! ,_ ,(? (or/c int32? register?)))
       (k `(,fx))]
      [`(set! ,fv ,(? (or/c int64? fvar?) val))
       (k `((set! ,(car aux-reg) ,val)
            (set! ,fv ,(car aux-reg))))]))
  ;  	|	 	(set! reg loc)
  ;  	|	 	(set! reg triv)
  ;  	|	 	(set! reg_1 (binop reg_1 int32))
  ;  	|	 	(set! reg_1 (binop reg_1 loc))
  (define (patch-fx/reg fx k)
    (match fx
      [`(set! ,reg (,binop ,reg
                           ,(? (and/c (not/c int32?)
                                      int64?) i64)))
       (k `((set! ,(car aux-reg) ,i64)
            (set! ,reg (,binop ,reg ,(car aux-reg)))))]
      [_ (k `(,fx))]))
  (define (patch-fx fx k)
    (match fx
      [`(set! ,(? register?) ,_) (patch-fx/reg fx k)]
      [`(set! ,(? fvar?) ,_) (patch-fx/fvar fx k)]
      )
    )
  (patch-p pal2))

(module+ test
  (require rackunit)
  ;example outputs for patch-instructions
  (check-equal? (patch-instructions '(begin (set! rbx 42) (halt rbx)))
                '(begin (set! rbx 42) (set! rax rbx)))
  (check-equal? (patch-instructions
                 '(begin
                    (set! fv0 0)
                    (set! fv1 42)
                    (set! fv0 fv1)
                    (halt fv0)))
                '(begin
                   (set! fv0 0)
                   (set! fv1 42)
                   (set! r10 fv1)
                   (set! fv0 r10)
                   (set! rax fv0)))
  (check-equal? (patch-instructions
                 '(begin
                    (set! rbx 0)
                    (set! rcx 0)
                    (set! r9 42)
                    (set! rbx rcx)
                    (set! rbx (+ rbx r9))
                    (halt rbx)))
                '(begin
                   (set! rbx 0)
                   (set! rcx 0)
                   (set! r9 42)
                   (set! rbx rcx)
                   (set! rbx (+ rbx r9))
                   (set! rax rbx)))
  ; patch-instructions: additional tests
  (check-equal? (patch-instructions
                 `(begin
                    (set! rbx 0)
                    (set! rcx 0)
                    (set! fv0 ,(max-int 64))
                    (set! rbx rcx)
                    (set! rbx (+ rbx r9))
                    (halt rbx)))
                `(begin
                   (set! rbx 0)
                   (set! rcx 0)
                   (set! r10 ,(max-int 64))
                   (set! fv0 r10)
                   (set! rbx rcx)
                   (set! rbx (+ rbx r9))
                   (set! rax rbx)))
  (check-equal? (patch-instructions
                 `(begin
                    (set! rbx 0)
                    (set! rbx (+ rbx ,(max-int 64)))
                    (halt rbx)))
                `(begin
                   (set! rbx 0)
                   (set! r10 ,(max-int 64))
                   (set! rbx (+ rbx r10))
                   (set! rax rbx)))
  (check-equal? (patch-instructions
                 `(begin
                    (set! fv0 0)
                    (set! fv0 (+ fv0 ,(max-int 64)))
                    (halt fv0)))
                `(begin
                   (set! fv0 0)
                   (set! r10 ,(max-int 64))
                   (set! r10 (+ r10 fv0))
                   (set! fv0 r10)
                   (set! rax fv0)))
  )