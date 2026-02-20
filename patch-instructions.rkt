#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v4)
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

;; para-asm-lang-v4 -> paren-x64-fvars-v4
;; Compiles Para-asm-lang v4 to Paren-x64-fvars v4 by patching each instruction that has no x64
;; analogue into a sequence of instructions using auxilliary
;; register from current-patch-instruction-registers
(define (patch-instructions p)
  (define aux-reg current-patch-instructions-registers)
  (define first-reg (first (aux-reg)))
  (define second-reg (second (aux-reg)))

  (define (patch-set-reg s)
    (match s
      [`(set! ,reg1 (,binop ,reg1 ,triv))
       #:when (and (integer? triv) (not (int32? triv)))
       `((set! ,first-reg ,triv) (set! ,reg1 (,binop ,reg1 ,first-reg)))]
      [_ `(,s)]))

  (define (patch-set-fvar s)
    (match s
      [`(set! ,fvar1 (,binop ,fvar1 ,triv))
       `((set! ,first-reg ,triv) (set! ,first-reg (,binop ,first-reg ,fvar1))
                                 (set! ,fvar1 ,first-reg))]
      [`(set! ,fvar1 ,triv)
       #:when (or (fvar? triv) (and (integer? triv) (not (int32? triv))))
       `((set! ,first-reg ,triv) (set! ,fvar1 ,first-reg))]
      [_ `(,s)]))

  (define (patch-s s)
    (match s
      [`(set! ,loc ,rest)
       #:when (register? loc)
       (patch-set-reg s)]
      [`(set! ,loc ,rest) (patch-set-fvar s)]
      [`(with-label ,label ,s)
       #:when (> (length (patch-s s)) 1) ;; when more than 1 instruction is returned
       (define patched (patch-s s))
       `((with-label ,label ,(first patched)) ,@(rest patched))]
      [`(halt ,opand) `((set! ,(current-return-value-register) ,opand) (jump done))]
      [`(compare ,loc ,opand)
       `((set! ,first-reg ,loc) (set! ,second-reg ,opand) (compare ,first-reg ,second-reg))]
      [`(jump-if ,relop ,trg)
       #:when (or (fvar? trg) (register? trg))
       `((set! ,first-reg ,trg) (jump-if ,relop ,first-reg))]
      [`(jump ,relop ,trg)
       #:when (fvar? trg)
       `((set! ,first-reg ,trg) (jump ,relop ,first-reg))]
      [_ `(,s)]))

  (define (patch-p p)
    (match p
      [`(begin
          ,ss ...)
       `(begin
          ,@(apply append (map patch-s ss)))]))

  (patch-p p))

(module+ test
  (require rackunit)
  ;example outputs for patch-instructions
  (check-equal? (patch-instructions '(begin
                                       (set! rbx 42)
                                       (halt rbx)))
                '(begin
                   (set! rbx 42)
                   (set! rax rbx)
                   (jump done)))
  (check-equal? (patch-instructions '(begin
                                       (set! fv0 0)
                                       (set! fv1 42)
                                       (set! fv0 fv1)
                                       (halt fv0)))
                '(begin
                   (set! fv0 0)
                   (set! fv1 42)
                   (set! r10 fv1)
                   (set! fv0 r10)
                   (set! rax fv0)
                   (jump done)))
  (check-equal? (patch-instructions '(begin
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
                   (set! rax rbx)
                   (jump done)))
  ; patch-instructions: additional tests
  (check-equal? (patch-instructions `(begin
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
                   (set! rax rbx)
                   (jump done)))
  (check-equal? (patch-instructions `(begin
                                       (set! rbx 0)
                                       (set! rbx (+ rbx ,(max-int 64)))
                                       (halt rbx)))
                `(begin
                   (set! rbx 0)
                   (set! r10 ,(max-int 64))
                   (set! rbx (+ rbx r10))
                   (set! rax rbx)
                   (jump done)))
  (check-equal? (patch-instructions `(begin
                                       (set! fv0 0)
                                       (set! fv0 (+ fv0 ,(max-int 64)))
                                       (halt fv0)))
                `(begin
                   (set! fv0 0)
                   (set! r10 ,(max-int 64))
                   (set! r10 (+ r10 fv0))
                   (set! fv0 r10)
                   (set! rax fv0)
                   (jump done)))
  (check-eq? (interp-para-asm-lang-v4 '(begin
                                         (set! rbx 42)
                                         (halt rbx)))
             (interp-paren-x64-fvars-v4 (patch-instructions '(begin
                                                               (set! rbx 42)
                                                               (halt rbx)))))
  (check-eq? (interp-para-asm-lang-v4 '(begin
                                         (set! fv0 0)
                                         (set! fv1 42)
                                         (set! fv0 fv1)
                                         (halt fv0)))
             (interp-paren-x64-fvars-v4 (patch-instructions '(begin
                                                               (set! fv0 0)
                                                               (set! fv1 42)
                                                               (set! fv0 fv1)
                                                               (halt fv0)))))
  (check-eq? (interp-para-asm-lang-v4 '(begin
                                         (set! rbx 0)
                                         (set! rcx 0)
                                         (set! r9 42)
                                         (set! rbx rcx)
                                         (set! rbx (+ rbx r9))
                                         (halt rbx)))
             (interp-paren-x64-fvars-v4 (patch-instructions '(begin
                                                               (set! rbx 0)
                                                               (set! rcx 0)
                                                               (set! r9 42)
                                                               (set! rbx rcx)
                                                               (set! rbx (+ rbx r9))
                                                               (halt rbx)))))
  (check-eq? (interp-para-asm-lang-v4 `(begin
                                         (set! rbx 1)
                                         (set! rcx 0)
                                         (set! fv0 ,(max-int 64))
                                         (set! rbx rcx)
                                         (set! rbx (+ rbx fv0))
                                         (halt rbx)))
             (interp-paren-x64-fvars-v4 (patch-instructions `(begin
                                                               (set! rbx 1)
                                                               (set! rcx 0)
                                                               (set! fv0 ,(max-int 64))
                                                               (set! rbx rcx)
                                                               (set! rbx (+ rbx fv0))
                                                               (halt rbx)))))
  (check-eq? (interp-para-asm-lang-v4 `(begin
                                         (set! rbx 0)
                                         (set! rcx 0)
                                         (set! fv0 ,(max-int 64))
                                         (set! rbx rcx)
                                         (set! rbx (+ rbx rbx))
                                         (halt rbx)))
             (interp-paren-x64-fvars-v4 (patch-instructions `(begin
                                                               (set! rbx 0)
                                                               (set! rcx 0)
                                                               (set! fv0 ,(max-int 64))
                                                               (set! rbx rcx)
                                                               (set! rbx (+ rbx rbx))
                                                               (halt rbx)))))

  (check-eq? (interp-para-asm-lang-v4 `(begin
                                         (set! rbx 0)
                                         (set! rbx (+ rbx ,(max-int 64)))
                                         (halt rbx)))
             (interp-paren-x64-fvars-v4 (patch-instructions `(begin
                                                               (set! rbx 0)
                                                               (set! rbx (+ rbx ,(max-int 64)))
                                                               (halt rbx)))))

  (check-eq? (interp-para-asm-lang-v4 `(begin
                                         (set! fv0 0)
                                         (set! fv0 (+ fv0 ,(max-int 64)))
                                         (halt fv0)))
             (interp-paren-x64-fvars-v4 (patch-instructions `(begin
                                                               (set! fv0 0)
                                                               (set! fv0 (+ fv0 ,(max-int 64)))
                                                               (halt fv0)))))
  (check-eq? (interp-para-asm-lang-v4 `(begin
                                         (set! fv0 42)
                                         (halt fv0)))
             (interp-paren-x64-fvars-v4 `(begin
                                           (set! fv0 42)
                                           (halt fv0))))

  (check-eq? (interp-para-asm-lang-v4 `(begin
                                         (set! rbx 0)
                                         (with-label L.tmp.1 (halt rbx))))
             (interp-paren-x64-fvars-v4 (patch-instructions `(begin
                                                               (set! rbx 0)
                                                               (with-label L.tmp.1 (halt rbx))))))

  (check-eq? (interp-para-asm-lang-v4 `(begin
                                         (set! rcx -1)
                                         (with-label L.tmp.1 (set! rcx -2))
                                         (with-label L.tmp.2 (set! rcx (+ rcx 2)))
                                         (with-label L.tmp.3 (compare rcx 0))
                                         (with-label L.tmp.4 (jump-if = L.tmp.2))

                                         (halt rcx)))
             (interp-paren-x64-fvars-v4 `(begin
                                           (set! rcx -1)
                                           (with-label L.tmp.1 (set! rcx -2))
                                           (with-label L.tmp.2 (set! rcx (+ rcx 2)))
                                           (with-label L.tmp.3 (compare rcx 0))
                                           (with-label L.tmp.4 (jump-if = L.tmp.2))
                                           (halt rcx))))
  (check-eq? (interp-para-asm-lang-v4 `(begin
                                         (set! rdx -5)
                                         (set! rbx 0)
                                         (with-label L.tmp.5 (set! rdx rdx))
                                         (set! rdx (+ rdx 1))
                                         (set! rbx (+ rbx 1))
                                         (compare rdx -4)
                                         (jump-if < L.tmp.5)
                                         (halt rbx)))
             (interp-paren-x64-fvars-v4 `(begin
                                           (set! rdx -5)
                                           (set! rbx 0)
                                           (with-label L.tmp.5 (set! rdx rdx))
                                           (set! rdx (+ rdx 1))
                                           (set! rbx (+ rbx 1))
                                           (compare rdx -4)
                                           (jump-if < L.tmp.5)
                                           (halt rbx))))
  (check-eq? (interp-para-asm-lang-v4 `(begin
                                         (set! rax 0)
                                         (set! rbx 1)
                                         (with-label L.tmp.5 (set! rax -1))
                                         (set! rax (* rax -2))
                                         (set! ,(current-return-value-register) rax)
                                         (compare rax rbx)
                                         (jump-if > done)
                                         (halt 5)))
             (interp-paren-x64-fvars-v4 `(begin
                                           (set! rax 0)
                                           (set! rbx 1)
                                           (with-label L.tmp.5 (set! rax -1))
                                           (set! rax (* rax -2))
                                           (set! ,(current-return-value-register) rax)
                                           (compare rax rbx)
                                           (jump-if > done)
                                           (halt 5)))))
