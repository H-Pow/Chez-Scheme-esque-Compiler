#lang racket

(require cpsc411/compiler-lib)

(provide expose-basic-blocks)

; nested-asm-lang-v6
;  p	 	::=	 	(module (define label tail) ... tail)

;   pred	 	::=	 	(relop loc opand)
;  	 	|	 	(true)
;  	 	|	 	(false)
;  	 	|	 	(not pred)
;  	 	|	 	(begin effect ... pred)
;  	 	|	 	(if pred pred pred)

;   tail	 	::=	 	(jump trg)
;  	 	|	 	(begin effect ... tail)
;  	 	|	 	(if pred tail tail)

;   effect	 	::=	 	(set! loc triv)
;  	 	|	 	(set! loc_1 (binop loc_1 opand))
;  	 	|	 	(begin effect ... effect)
;  	 	|	 	(if pred effect effect)
;  	 	|	 	(return-point label tail)

;   triv	 	::=	 	opand
;  	 	|	 	label

;   opand	 	::=	 	int64
;  	 	|	 	loc

;   trg	 	::=	 	label
;  	 	|	 	loc

;   loc	 	::=	 	reg
;  	 	|	 	addr

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
;  	 	|	 	-

;   relop	 	::=	 	<
;  	 	|	 	<=
;  	 	|	 	=
;  	 	|	 	>=
;  	 	|	 	>
;  	 	|	 	!=

;   int64	 	::=	 	int64?

;   addr	 	::=	 	(fbp - dispoffset)

;   fbp	 	::=	 	frame-base-pointer-register?

;   dispoffset	 	::=	 	dispoffset?

;   label	 	::=	 	label?
;;------------------------------
; Block-pred-lang v6
;    p	 	::=	 	(module b ... b)

;   b	 	::=	 	(define label tail)

;   pred	 	::=	 	(relop loc opand)
;  	 	|	 	(true)
;  	 	|	 	(false)
;  	 	|	 	(not pred)

;   tail	 	::=	 	(jump trg)
;  	 	|	 	(begin effect ... tail)
;  	 	|	 	(if pred (jump trg) (jump trg))

;   effect	 	::=	 	(set! loc triv)
;  	 	|	 	(set! loc_1 (binop loc_1 opand))

;   triv	 	::=	 	opand
;  	 	|	 	label

;   opand	 	::=	 	int64
;  	 	|	 	loc

;   trg	 	::=	 	label
;  	 	|	 	loc

;   loc	 	::=	 	reg
;  	 	|	 	addr

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
;  	 	|	 	-

;   relop	 	::=	 	<
;  	 	|	 	<=
;  	 	|	 	=
;  	 	|	 	>=
;  	 	|	 	>
;  	 	|	 	!=

;   int64	 	::=	 	int64?

;   addr	 	::=	 	(fbp - dispoffset)

;   fbp	 	::=	 	frame-base-pointer-register?

;   dispoffset	 	::=	 	dispoffset?

;   label	 	::=	 	label?

;;nested-asm-lang-v6 -> block-pred-lang-v6
;; Compile the Nested-asm-lang v6 to Block-pred-lang v6,
;;   eliminating all nested expressions by generating fresh basic blocks and jumps.
(define (expose-basic-blocks p)
  (define blocks '())
  (define (create-block! label tail)
    (set! blocks (cons `(define ,label ,tail) blocks))
    label)
  ;; nested-pred label label -> label
  ;; effect: creates a block with pred
  (define (expose-pred! pred truelab falselab)
    (define label (fresh-label 'pred))
    (match pred
      [`(not ,pred) (expose-pred! pred falselab truelab)]
      [`(begin
          ,fx* ...
          ,pred)
       (foldr expose-effect! (expose-pred! pred truelab falselab) fx*)]
      [`(if ,pred ,pred1 ,pred2)
       (expose-pred! pred
                     (expose-pred! pred1 truelab falselab)
                     (expose-pred! pred2 truelab falselab))]
      [`(,relop ,loc ,triv)
       (create-block! label
                      `(if ,pred
                           (jump ,truelab)
                           (jump ,falselab)))]
      [`(true)
       (create-block! label
                      `(if ,pred
                           (jump ,truelab)
                           (jump ,falselab)))]
      [`(false)
       (create-block! label
                      `(if ,pred
                           (jump ,truelab)
                           (jump ,falselab)))]))
  ;; nested-effect label -> label
  ;; effect: creates a block with the effect
  (define (expose-effect! fx next)
    (define label (fresh-label 'fx))
    (match fx
      [`(set! ,loc ,triv)
       (create-block! label
                      `(begin
                         ,fx
                         (jump ,next)))]
      [`(set! ,loc (,binop ,loc ,triv))
       (create-block! label
                      `(begin
                         ,fx
                         (jump ,next)))]
      [`(begin
          ,fx* ...
          ,fx)
       (foldr expose-effect! (expose-effect! fx next) fx*)]
      [`(if ,pred ,fx1 ,fx2)
       (expose-pred! pred (expose-effect! fx1 next) (expose-effect! fx2 next))]
      [`(return-point ,ret-label ,tail)
        (define ret-lab (create-block! ret-label `(jump ,next)))
        (define tail-lab (expose-tail! tail))
        tail-lab]))
  ;; nested-tail (block-tail -> X) -> X
  (define (nested-tail->block-tail& tail [k identity])
    (match tail
      ; [`(halt ,_) (k tail)] ;; removed in v6
      [`(jump ,_) (k tail)]
      [`(begin
          ,fx* ...
          ,tail)
       (k `(jump ,(foldr expose-effect! (expose-tail! tail) fx*)))]
      [`(if ,pred ,tail1 ,tail2)
       (k `(jump ,(expose-pred! pred (expose-tail! tail1) (expose-tail! tail2))))]))

  ;; nested-tail -> label
  ;; effect: creates a block
  (define (expose-tail! tail)
    ;;block-tail -> label
    (define (expose-block-label! tail)
      (define label (fresh-label 'tail))
      (match tail
        [`(jump ,trg) trg]
        [_ (create-block! label tail)]))
    (nested-tail->block-tail& tail expose-block-label!))
  (match p
    [`(module (define ,label* ,tail*) ...
        ,tail)
     (begin
       (for-each create-block! label* (map (λ (tail) `(jump ,(expose-tail! tail))) tail*))
       (nested-tail->block-tail& tail (λ (bt) (create-block! (fresh-label 'start) bt)))
       `(module ,@blocks))]))

(module+ test
  (require rackunit
           cpsc411/langs/v6)
  (define-syntax-rule (check-by-interp p)
    (check-equal? (interp-nested-asm-lang-v6 p) (interp-block-pred-lang-v6 (expose-basic-blocks p))))
  ;; M6 tests; Added by Trevor on March 6th 2026, at most one binding per let
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 -422317085)
                              (set! r14 r14)
                              (set! r14 r14)
                              (set! rax r14)
                              (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r14 r8)
                                (set! rax 9223372036854775807)
                                (jump r15)))
                            (define L.proc.1.2
                              (begin
                                (set! (rbp - 0) r15)
                                (set! (rbp - 8) rdi)
                                (set! r15 rsi)
                                (set! (rbp - 8) (rbp - 8))
                                (begin
                                  (set! rbp (- rbp 24))
                                  (return-point L.rp.3
                                                (begin
                                                  (set! rsi (rbp - -16))
                                                  (set! rdi (rbp - -16))
                                                  (set! r15 L.rp.3)
                                                  (jump L.proc.1.2)))
                                  (set! rbp (+ rbp 24)))
                                (set! r15 rax)
                                (if (begin
                                      (set! r15 -59730991)
                                      (= r15 (rbp - 8)))
                                    (begin
                                      (set! rax 0)
                                      (jump (rbp - 0)))
                                    (begin
                                      (set! rax (rbp - 8))
                                      (jump (rbp - 0))))))
                      (begin
                        (set! r15 r15)
                        (begin
                          (set! r14 1)
                          (set! r14 (* r14 -9223372036854775808))
                          (set! r14 r14))
                        (if (not (> r14 r14))
                            (begin
                              (set! r14 r14)
                              (set! rax -1510146984)
                              (jump r15))
                            (begin
                              (set! rsi r14)
                              (set! rdi -9223372036854775808)
                              (set! r15 r15)
                              (jump L.proc.1.2))))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 -1418594624)
                                    (false))
                                  (begin
                                    (if (begin
                                          (set! r14 -1123833745)
                                          (false))
                                        (set! r14 1)
                                        (set! r14 0))
                                    (set! r14 767736686)
                                    (set! r14 r14))
                                  (begin
                                    (set! r14 1942655457)
                                    (set! r14 r14)))
                              (set! r14 r14)
                              (set! r14 (- r14 r14))
                              (set! rax r14)
                              (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r14 rdx)
                                (set! (rbp - 16) rcx)
                                (set! (rbp - 8) r8)
                                (begin
                                  (set! rbp (- rbp 24))
                                  (return-point L.rp.2
                                                (begin
                                                  (set! r8 (rbp - -16))
                                                  (set! rcx (rbp - -8))
                                                  (set! rdx r15)
                                                  (set! rsi -9223372036854775808)
                                                  (set! rdi -1343541856)
                                                  (set! r15 L.rp.2)
                                                  (jump L.func.0.1)))
                                  (set! rbp (+ rbp 24)))
                                (set! r15 rax)
                                (if (begin
                                      (set! r15 0)
                                      (true))
                                    (if (begin
                                          (set! r15 1346978436)
                                          (= r15 (rbp - 8)))
                                        (begin
                                          (set! rax 0)
                                          (jump (rbp - 0)))
                                        (begin
                                          (set! rax (rbp - 8))
                                          (jump (rbp - 0))))
                                    (begin
                                      (set! r8 (rbp - 16))
                                      (set! rcx 9223372036854775807)
                                      (set! rdx 1)
                                      (set! rsi (rbp - 8))
                                      (set! rdi -1402588641)
                                      (set! r15 (rbp - 0))
                                      (jump L.func.0.1)))))
                            (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 824269768)
                                    (true))
                                  (set! r14 -9223372036854775808)
                                  (set! r14 709343632))
                              (set! rax r14)
                              (jump r15))
                      ))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 -356902212)
                              (set! r14 -979281755)
                              (set! r14 (+ r14 9223372036854775807))
                              (set! rax r14)
                              (jump r15))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! rdx r14)
                                (set! rsi 182548382)
                                (set! rdi 0)
                                (set! r15 r15)
                                (jump L.tmp.0.1)))
                            (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 1)
                                    (false))
                                  (begin
                                    (set! rax -9223372036854775808)
                                    (jump r15))
                                  (begin
                                    (set! rax 0)
                                    (jump r15))))
                      ))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (set! r15 rdi)
                                (set! (rbp - 16) rsi)
                                (set! (rbp - 8) rdx)
                                (set! r15 rcx)
                                (set! r14 r8)
                                (if (not (<= (rbp - 8) 9223372036854775807))
                                    (begin
                                      (set! r14 -18835826)
                                      (set! r14 r14)
                                      (if (>= (rbp - 8) r15)
                                          (begin
                                            (set! rax (rbp - 8))
                                            (jump (rbp - 0)))
                                          (begin
                                            (set! rax (rbp - 16))
                                            (jump (rbp - 0)))))
                                    (begin
                                      (begin
                                        (set! rbp (- rbp 24))
                                        (return-point L.rp.3
                                                      (begin
                                                        (set! r8 0)
                                                        (set! rcx r14)
                                                        (set! rdx (rbp - -16))
                                                        (set! rsi 9223372036854775807)
                                                        (set! rdi r14)
                                                        (set! r15 L.rp.3)
                                                        (jump L.x.0.1)))
                                        (set! rbp (+ rbp 24)))
                                      (set! r15 rax)
                                      (if (<= (rbp - 16) -186024487)
                                          (begin
                                            (set! rax r15)
                                            (jump (rbp - 0)))
                                          (begin
                                            (set! rax (rbp - 8))
                                            (jump (rbp - 0))))))))
                            (define L.func.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 -932453002)
                                (if (begin
                                      (set! r9 -1133252869)
                                      (false))
                                    (set! r14 479665611)
                                    (set! r14 r14))
                                (set! r14 r13)
                                (set! rax r13)
                                (jump r15)))
                      (begin
                        (set! r15 r15)
                        (if (begin
                              (set! r14 1588211020)
                              (true))
                            (begin
                              (set! rax 9223372036854775807)
                              (jump r15))
                            (begin
                              (set! rax -9223372036854775808)
                              (jump r15))))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 1)
                                (set! r13 (+ r13 r14))
                                (set! r14 r13)
                                (set! rdx 9223372036854775807)
                                (set! rsi r14)
                                (set! rdi 515658026)
                                (set! r15 r15)
                                (jump L.func.1.2)))
                            (define L.func.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r9 rdx)
                                (begin
                                  (set! rdx r13)
                                  (set! rsi r14)
                                  (set! rdi -508654129)
                                  (set! r15 r15)
                                  (jump L.func.1.2))))
                      (begin
                        (set! r15 r15)
                        (set! r14 0)
                        (set! r14 (* r14 -9223372036854775808))
                        (set! r14 r14)
                        (set! rdi -39871347)
                        (set! r15 r15)
                        (jump L.proc.0.1))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 1)
                                    (true))
                                  (begin
                                    (set! rax 234292566)
                                    (jump r15))
                                  (begin
                                    (set! rax -1579825632)
                                    (jump r15))))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! rsi rsi)
                                (set! r13 rdx)
                                (set! rdi rcx)
                                (set! rdx r8)
                                (set! r9 r9)
                                (if (not (not (begin
                                                (set! r9 9223372036854775807)
                                                (= r9 r14))))
                                    (begin
                                      (set! r9 9223372036854775807)
                                      (set! r8 -1679374410)
                                      (set! rcx 1)
                                      (set! rdx 1)
                                      (set! rsi 0)
                                      (set! rdi r14)
                                      (set! r15 r15)
                                      (jump L.x.0.1))
                                    (begin
                                      (set! r9 -9223372036854775808)
                                      (set! r8 rsi)
                                      (set! rcx rdx)
                                      (set! rdx -30425170)
                                      (set! rsi rdi)
                                      (set! rdi r13)
                                      (set! r15 r15)
                                      (jump L.x.0.1)))))
                            (begin
                              (set! r15 r15)
                              (set! r9 1)
                              (set! r8 -1659310511)
                              (set! rcx 671608402)
                              (set! rdx 1)
                              (set! rsi 0)
                              (set! rdi 158605610)
                              (set! r15 r15)
                              (jump L.x.0.1))
                      ))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! rax 1)
                              (jump r15))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r14 r14)
                                (set! r14 0)
                                (set! r14 (* r14 0))
                                (set! rax r14)
                                (jump r15)))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (if (begin
                                      (set! r14 -9223372036854775808)
                                      (false))
                                    (begin
                                      (set! rax -1098447432)
                                      (jump r15))
                                    (begin
                                      (set! r14 -9223372036854775808)
                                      (set! r14 (+ r14 -9223372036854775808))
                                      (set! r14 r14)
                                      (if (begin
                                            (set! r14 857729561)
                                            (true))
                                          (begin
                                            (set! rax 9223372036854775807)
                                            (jump r15))
                                          (begin
                                            (set! rax 1)
                                            (jump r15)))))))
                      (define L.fn.2.3
                        (begin
                          (set! r15 r15)
                          (set! r13 rdi)
                          (set! r14 rsi)
                          (set! rdi rdx)
                          (set! rdi rcx)
                          (set! r8 r8)
                          (set! r9 r9)
                          (set! r8 (rbp - 0))
                          (begin
                            (set! r14 r9)
                            (set! r14 (* r14 rdi))
                            (set! rax r14)
                            (jump r15))))
                      (begin
                        (set! r15 r15)
                        (if (begin
                              (begin
                                (set! r14 1)
                                (set! r14 -9223372036854775808)
                                (set! r14 r14)
                                (set! r14 9223372036854775807))
                              (begin
                                (set! r13 -1195644570)
                                (false)))
                            (begin
                              (set! (rbp - 0) 0)
                              (set! r9 9223372036854775807)
                              (set! r8 -2036437657)
                              (set! rcx 0)
                              (set! rdx 0)
                              (set! rsi -1663007716)
                              (set! rdi 1453047515)
                              (set! r15 r15)
                              (jump L.fn.2.3))
                            (begin
                              (set! rsi -1792916675)
                              (set! rdi 1)
                              (set! r15 r15)
                              (jump L.fn.0.1))))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 -9223372036854775808)
                                    (false))
                                  (begin
                                    (if (begin
                                          (set! r14 1)
                                          (true))
                                        (set! r14 9223372036854775807)
                                        (set! r14 463110926))
                                    (set! r14 0))
                                  (begin
                                    (set! r14 0)
                                    (set! r14 -1584028825)
                                    (set! r14 (- r14 -9223372036854775808))
                                    (set! r14 r14)))
                              (if (not (> r14 1))
                                  (if (begin
                                        (set! r13 -9223372036854775808)
                                        (true))
                                      (if (> r14 491128034)
                                          (begin
                                            (set! rax r14)
                                            (jump r15))
                                          (begin
                                            (set! rax 1)
                                            (jump r15)))
                                      (if (begin
                                            (set! r13 1050399943)
                                            (= r13 r14))
                                          (begin
                                            (set! rax -1604958676)
                                            (jump r15))
                                          (begin
                                            (set! rax r14)
                                            (jump r15))))
                                  (begin
                                    (set! rax r14)
                                    (jump r15))))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r14 r8)
                                (set! r13 r9)
                                (set! r14 (rbp - 0))
                                (set! (rbp - 0) r13)
                                (set! r9 -1130190811)
                                (set! r8 -9223372036854775808)
                                (set! rcx 1751496267)
                                (set! rdx r14)
                                (set! rsi 0)
                                (set! rdi -9223372036854775808)
                                (set! r15 r15)
                                (jump L.tmp.0.1)))
                            (begin
                              (set! r15 r15)
                              (set! (rbp - 0) 1)
                              (set! r9 9223372036854775807)
                              (set! r8 -9223372036854775808)
                              (set! rcx -522285902)
                              (set! rdx 754255570)
                              (set! rsi -1704260755)
                              (set! rdi 0)
                              (set! r15 r15)
                              (jump L.tmp.0.1))
                      ))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r9 rdx)
                                (set! r13 rcx)
                                (set! r8 r9)
                                (set! rcx 9223372036854775807)
                                (set! rdx r14)
                                (set! rsi r13)
                                (set! rdi 9223372036854775807)
                                (set! r15 r15)
                                (jump L.func.1.2)))
                            (define L.func.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! rdi rcx)
                                (set! r9 r8)
                                (set! (rbp - 0) -9223372036854775808)
                                (set! r9 r9)
                                (set! r8 rdi)
                                (set! rcx r13)
                                (set! rdx r14)
                                (set! rsi r13)
                                (set! rdi 9223372036854775807)
                                (set! r15 r15)
                                (jump L.tmp.2.3)))
                      (define L.tmp.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r14 rsi)
                          (set! r14 rdx)
                          (set! r13 rcx)
                          (set! r13 r8)
                          (set! r13 r9)
                          (set! r13 (rbp - 0))
                          (set! rax r14)
                          (jump r15)))
                      (begin
                        (set! r15 r15)
                        (begin
                          (set! (rbp - 0) 1)
                          (set! r9 9223372036854775807)
                          (set! r8 1)
                          (set! rcx -282402130)
                          (set! rdx -9223372036854775808)
                          (set! rsi 9223372036854775807)
                          (set! rdi 1)
                          (set! r15 r15)
                          (jump L.tmp.2.3)))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r13 r8)
                                (set! r13 r9)
                                (set! r13 (rbp - 0))
                                (set! rdx r14)
                                (set! rsi 946654223)
                                (set! rdi 9223372036854775807)
                                (set! r15 r15)
                                (jump L.func.1.2)))
                            (define L.func.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! rdx 9223372036854775807)
                                (set! rsi r13)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.func.1.2)))
                      (define L.fn.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r13 rsi)
                          (set! r9 rdx)
                          (set! r9 9223372036854775807)
                          (set! rdx r14)
                          (set! rsi 0)
                          (set! rdi r13)
                          (set! r15 r15)
                          (jump L.func.1.2)))
                      (begin
                        (set! r15 r15)
                        (set! r14 0)
                        (set! rax 1)
                        (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 rdx)
                                (set! r13 rcx)
                                (set! r13 r8)
                                (begin
                                  (set! rax 1)
                                  (jump r15))))
                            (begin
                              (set! r15 r15)
                              (set! r8 1653803490)
                              (set! rcx 1918330809)
                              (set! rdx 1)
                              (set! rsi 9223372036854775807)
                              (set! rdi -9223372036854775808)
                              (set! r15 r15)
                              (jump L.func.0.1))
                      ))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 r15)
                                (set! r13 rdi)
                                (set! r14 rsi)
                                (if (begin
                                      (set! r9 559317709)
                                      (not (= r9 r13)))
                                    (begin
                                      (set! rdx -675648818)
                                      (set! rsi -9223372036854775808)
                                      (set! rdi r14)
                                      (set! r15 r15)
                                      (jump L.func.1.2))
                                    (begin
                                      (set! r15 r15)
                                      (jump L.tmp.2.3)))))
                            (define L.func.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r15 r15)
                                (jump L.tmp.2.3)))
                      (define L.tmp.2.3
                        (begin
                          (set! r15 r15)
                          (set! r15 r15)
                          (jump L.tmp.2.3)))
                      (begin
                        (set! r15 r15)
                        (set! rax 1)
                        (jump r15))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r9 rdx)
                                (set! r9 rcx)
                                (if (= r13 r9)
                                    (set! r13 r13)
                                    (set! r13 -1012326174))
                                (set! r13 0)
                                (set! r13 r13)
                                (set! r14 r14)
                                (set! r14 (- r14 0))
                                (set! rax r14)
                                (jump r15)))
                            (begin
                              (set! r15 r15)
                              (set! rcx 1259250868)
                              (set! rdx 1097392993)
                              (set! rsi 0)
                              (set! rdi 1)
                              (set! r15 r15)
                              (jump L.x.0.1))
                      ))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r13 r8)
                                (set! r13 r9)
                                (set! r13 (rbp - 0))
                                (set! rsi 0)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.x.1.2)))
                            (define L.x.1.2
                              (begin
                                (set! (rbp - 0) r15)
                                (set! (rbp - 16) rdi)
                                (set! (rbp - 8) rsi)
                                (begin
                                  (set! rbp (- rbp 24))
                                  (return-point L.rp.3
                                                (begin
                                                  (set! (rbp - 0) (rbp - -16))
                                                  (set! r9 -9223372036854775808)
                                                  (set! r8 -9223372036854775808)
                                                  (set! rcx (rbp - -8))
                                                  (set! rdx (rbp - -16))
                                                  (set! rsi (rbp - -16))
                                                  (set! rdi (rbp - -8))
                                                  (set! r15 L.rp.3)
                                                  (jump L.func.0.1)))
                                  (set! rbp (+ rbp 24)))
                                (set! r15 rax)
                                (set! r14 (rbp - 16))
                                (set! r14 (+ r14 -841927304))
                                (set! r14 r14)
                                (if (begin
                                      (set! r14 -9223372036854775808)
                                      (= r14 (rbp - 8)))
                                    (begin
                                      (set! rax r15)
                                      (jump (rbp - 0)))
                                    (begin
                                      (set! rax -19487548)
                                      (jump (rbp - 0))))))
                      (begin
                        (set! r15 r15)
                        (set! rsi 169577204)
                        (set! rdi 1130382988)
                        (set! r15 r15)
                        (jump L.x.1.2))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! rdi r8)
                                (set! r9 r9)
                                (begin
                                  (set! r9 r13)
                                  (set! r8 -9223372036854775808)
                                  (set! rcx r13)
                                  (set! rdx rdi)
                                  (set! rsi rdi)
                                  (set! rdi 9223372036854775807)
                                  (set! r15 r15)
                                  (jump L.proc.0.1))))
                            (define L.func.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r9 rcx)
                                (set! rcx 1283566420)
                                (set! rdx r9)
                                (set! rsi r13)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.func.1.2)))
                      (begin
                        (set! r15 r15)
                        (if (begin
                              (begin
                                (set! r14 -9223372036854775808)
                                (set! r14 (- r14 9223372036854775807))
                                (set! r14 r14))
                              (false))
                            (begin
                              (set! rcx -9223372036854775808)
                              (set! rdx -481495635)
                              (set! rsi 0)
                              (set! rdi 9223372036854775807)
                              (set! r15 r15)
                              (jump L.func.1.2))
                            (begin
                              (set! r9 1)
                              (set! r8 -100459334)
                              (set! rcx -983869259)
                              (set! rdx -9223372036854775808)
                              (set! rsi -1938006617)
                              (set! rdi 1)
                              (set! r15 r15)
                              (jump L.proc.0.1))))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r8 r13)
                                (set! rcx 1)
                                (set! rdx r14)
                                (set! rsi -1620042780)
                                (set! rdi 0)
                                (set! r15 r15)
                                (jump L.x.1.2)))
                            (define L.x.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r13 r8)
                                (set! r13 9223372036854775807)
                                (set! r13 -9223372036854775808)
                                (set! r13 (+ r13 r14))
                                (set! rax r13)
                                (jump r15)))
                      (begin
                        (set! r15 r15)
                        (set! r8 0)
                        (set! rcx 1)
                        (set! rdx 9223372036854775807)
                        (set! rsi -913438169)
                        (set! rdi -1611188905)
                        (set! r15 r15)
                        (jump L.x.1.2))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! rcx -1370687846)
                                (set! rdx -9223372036854775808)
                                (set! rsi r14)
                                (set! rdi 346043157)
                                (set! r15 r15)
                                (jump L.x.1.2)))
                            (define L.x.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r13 rcx)
                                (set! rcx 1658781620)
                                (set! rdx 0)
                                (set! rsi r14)
                                (set! rdi -1950262775)
                                (set! r15 r15)
                                (jump L.x.1.2)))
                      (begin
                        (set! r15 r15)
                        (set! rcx 9223372036854775807)
                        (set! rdx -1844821605)
                        (set! rsi 1)
                        (set! rdi -139919863)
                        (set! r15 r15)
                        (jump L.x.1.2))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r9 rcx)
                                (set! rcx r13)
                                (set! rdx r13)
                                (set! rsi r13)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.tmp.0.1)))
                            (begin
                              (set! (rbp - 0) r15)
                              (begin
                                (set! r15 1326448876)
                                (set! r15 (- r15 360169641))
                                (set! rax r15)
                                (jump (rbp - 0))))
                      ))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 1)
                              (set! r14 r14)
                              (set! r14 r14)
                              (set! rax r14)
                              (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! (rbp - 8) rdx)
                                (set! r15 -529343887)
                                (set! r15 (* r15 -1285114971))
                                (set! r15 r15)
                                (begin
                                  (set! rbp (- rbp 16))
                                  (return-point L.rp.3
                                                (begin
                                                  (set! rdx (rbp - -8))
                                                  (set! rsi r15)
                                                  (set! rdi r15)
                                                  (set! r15 L.rp.3)
                                                  (jump L.func.0.1)))
                                  (set! rbp (+ rbp 16)))
                                (set! r15 rax)
                                (if (begin
                                      (set! r15 1981945067)
                                      (= r15 (rbp - 8)))
                                    (begin
                                      (set! rax -195961595)
                                      (jump (rbp - 0)))
                                    (begin
                                      (set! rax 9223372036854775807)
                                      (jump (rbp - 0))))))
                            (define L.fn.1.2
                              (begin
                                (set! (rbp - 0) r15)
                                (set! r15 rdi)
                                (set! r14 -73068505)
                                (set! r14 (+ r14 -9223372036854775808))
                                (set! r14 r14)
                                (if (<= r15 -9223372036854775808)
                                    (set! r14 r15)
                                    (set! r14 -241738702))
                                (begin
                                  (set! rbp (- rbp 8))
                                  (return-point L.rp.4
                                                (begin
                                                  (set! rdx 0)
                                                  (set! rsi 9223372036854775807)
                                                  (set! rdi r15)
                                                  (set! r15 L.rp.4)
                                                  (jump L.func.0.1)))
                                  (set! rbp (+ rbp 8)))
                                (set! r15 rax)
                                (set! r14 1)
                                (set! r14 (+ r14 r15))
                                (set! rax r14)
                                (jump (rbp - 0))))
                      (begin
                        (set! (rbp - 0) r15)
                        (begin
                          (set! rbp (- rbp 16))
                          (return-point L.rp.5
                                        (begin
                                          (set! rdx 9223372036854775807)
                                          (set! rsi 9223372036854775807)
                                          (set! rdi 0)
                                          (set! r15 L.rp.5)
                                          (jump L.func.0.1)))
                          (set! rbp (+ rbp 16)))
                        (set! (rbp - 8) rax)
                        (if (not (if (begin
                                       (set! r15 -9223372036854775808)
                                       (false))
                                     (begin
                                       (set! r15 -9223372036854775808)
                                       (< r15 (rbp - 8)))
                                     (= (rbp - 8) -9223372036854775808)))
                            (if (begin
                                  (set! r15 -9223372036854775808)
                                  (false))
                                (begin
                                  (set! r15 9223372036854775807)
                                  (set! r15 (- r15 (rbp - 8)))
                                  (set! rax r15)
                                  (jump (rbp - 0)))
                                (begin
                                  (set! r15 (rbp - 8))
                                  (set! rax r15)
                                  (jump (rbp - 0))))
                            (begin
                              (begin
                                (set! rbp (- rbp 16))
                                (return-point L.rp.6
                                              (begin
                                                (set! rdx 1)
                                                (set! rsi 9223372036854775807)
                                                (set! rdi 2001362815)
                                                (set! r15 L.rp.6)
                                                (jump L.func.0.1)))
                                (set! rbp (+ rbp 16)))
                              (set! r15 rax)
                              (set! r15 r15)
                              (set! r15 (* r15 (rbp - 8)))
                              (set! rax r15)
                              (jump (rbp - 0)))))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 r15)
                                (set! r8 1013001136)
                                (set! rcx 0)
                                (set! rdx 1)
                                (set! rsi -9223372036854775808)
                                (set! rdi -9223372036854775808)
                                (set! r15 r15)
                                (jump L.fn.2.3)))
                            (define L.tmp.1.2
                              (begin
                                (set! r15 r15)
                                (set! r13 rdi)
                                (set! rdi rsi)
                                (set! r14 rdx)
                                (set! rsi rcx)
                                (set! r8 r8)
                                (set! r9 r9)
                                (set! r8 (rbp - 0))
                                (if (begin
                                      (set! r13 r13)
                                      (< rdi 0))
                                    (begin
                                      (set! r13 rsi)
                                      (set! r13 -224488027))
                                    (if (= r8 r14)
                                        (set! r13 r8)
                                        (set! r13 r8)))
                                (set! r8 1)
                                (set! rcx r9)
                                (set! rdx -1015791473)
                                (set! rsi r14)
                                (set! rdi -9223372036854775808)
                                (set! r15 r15)
                                (jump L.fn.2.3)))
                      (define L.fn.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r14 rsi)
                          (set! r14 rdx)
                          (set! r14 rcx)
                          (set! r13 r8)
                          (set! r14 r14)
                          (set! r8 1)
                          (set! rcx 1459656882)
                          (set! rdx 0)
                          (set! rsi -9223372036854775808)
                          (set! rdi 0)
                          (set! r15 r15)
                          (jump L.fn.2.3)))
                      (begin
                        (set! r15 r15)
                        (set! r8 1)
                        (set! rcx 1648096326)
                        (set! rdx 9223372036854775807)
                        (set! rsi 1)
                        (set! rdi 9223372036854775807)
                        (set! r15 r15)
                        (jump L.fn.2.3))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 1903463490)
                                (set! r14 (* r14 -9223372036854775808))
                                (set! rax r14)
                                (jump r15)))
                            (define L.func.1.2
                              (begin
                                (set! r15 r15)
                                (set! r9 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r8 rcx)
                                (set! rdi -9223372036854775808)
                                (set! rdi (- rdi r9))
                                (set! rdi rdi)
                                (if (begin
                                      (set! r9 9223372036854775807)
                                      (> r9 r13))
                                    (if (< r14 r8)
                                        (begin
                                          (set! rax rdi)
                                          (jump r15))
                                        (begin
                                          (set! rax r14)
                                          (jump r15)))
                                    (if (>= r8 1408489810)
                                        (begin
                                          (set! rax rdi)
                                          (jump r15))
                                        (begin
                                          (set! rax r14)
                                          (jump r15))))))
                      (begin
                        (set! r15 r15)
                        (set! r14 977777990)
                        (set! r14 (* r14 900224161))
                        (set! rax r14)
                        (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (set! (rbp - 24) rdi)
                                (set! (rbp - 8) rsi)
                                (set! (rbp - 16) rdx)
                                (begin
                                  (set! rbp (- rbp 32))
                                  (return-point L.rp.2
                                                (begin
                                                  (set! rdx 9223372036854775807)
                                                  (set! rsi -1363029646)
                                                  (set! rdi 9223372036854775807)
                                                  (set! r15 L.rp.2)
                                                  (jump L.func.0.1)))
                                  (set! rbp (+ rbp 32)))
                                (set! r15 rax)
                                (if (begin
                                      (set! r15 9223372036854775807)
                                      (false))
                                    (begin
                                      (set! rdx (rbp - 8))
                                      (set! rsi (rbp - 8))
                                      (set! rdi 719591632)
                                      (set! r15 (rbp - 0))
                                      (jump L.func.0.1))
                                    (if (>= (rbp - 16) 1396041917)
                                        (begin
                                          (set! rax -1711968134)
                                          (jump (rbp - 0)))
                                        (begin
                                          (set! rax (rbp - 24))
                                          (jump (rbp - 0)))))))
                            (begin
                              (set! r15 r15)
                              (set! rdx 0)
                              (set! rsi 9223372036854775807)
                              (set! rdi -9223372036854775808)
                              (set! r15 r15)
                              (jump L.func.0.1))
                      ))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (if (begin
                                      (set! r15 0)
                                      (true))
                                    (begin
                                      (begin
                                        (set! rbp (- rbp 8))
                                        (return-point L.rp.4
                                                      (begin
                                                        (set! rdi 1456910402)
                                                        (set! r15 L.rp.4)
                                                        (jump L.tmp.2.3)))
                                        (set! rbp (+ rbp 8)))
                                      (set! r15 rax)
                                      (set! r15 -9223372036854775808)
                                      (set! rax 1)
                                      (jump (rbp - 0)))
                                    (begin
                                      (set! rdi -9223372036854775808)
                                      (set! r15 (rbp - 0))
                                      (jump L.tmp.2.3)))))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r13 rcx)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.tmp.2.3)))
                      (define L.tmp.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! rax r14)
                          (jump r15)))
                      (begin
                        (set! r15 r15)
                        (set! rdi 0)
                        (set! r15 r15)
                        (jump L.tmp.2.3))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 r15)
                                (set! r13 rdi)
                                (set! r14 rsi)
                                (set! r13 r13)
                                (set! r9 r13)
                                (set! r9 (+ r9 r13))
                                (set! r13 r9)
                                (set! rsi r14)
                                (set! rdi 0)
                                (set! r15 r15)
                                (jump L.fn.0.1)))
                            (define L.tmp.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r9 rsi)
                                (set! r13 rdx)
                                (set! rdi rcx)
                                (set! r8 r8)
                                (if (< r8 r14)
                                    (begin
                                      (if (begin
                                            (set! r9 167876306)
                                            (<= r9 r14))
                                          (set! r14 44784438)
                                          (set! r14 -874603706))
                                      (set! r8 r13)
                                      (set! rcx r13)
                                      (set! rdx 0)
                                      (set! rsi 696038140)
                                      (set! rdi -9223372036854775808)
                                      (set! r15 r15)
                                      (jump L.tmp.1.2))
                                    (if (begin
                                          (set! r8 r8)
                                          (= rdi 0))
                                        (if (< r13 r13)
                                            (begin
                                              (set! rax r9)
                                              (jump r15))
                                            (begin
                                              (set! rax -727094500)
                                              (jump r15)))
                                        (begin
                                          (set! rsi -9223372036854775808)
                                          (set! rdi r14)
                                          (set! r15 r15)
                                          (jump L.fn.0.1))))))
                      (begin
                        (set! r15 r15)
                        (if (begin
                              (set! r14 9223372036854775807)
                              (false))
                            (set! r14 0)
                            (set! r14 93609173))
                        (set! r14 r14)
                        (set! r14 r14)
                        (set! rax r14)
                        (jump r15))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 -9223372036854775808)
                              (set! r14 0)
                              (set! r13 r14)
                              (if (begin
                                    (set! r14 r13)
                                    (begin
                                      (set! r14 1)
                                      (false)))
                                  (begin
                                    (set! rax r13)
                                    (jump r15))
                                  (begin
                                    (set! r14 r13)
                                    (set! rax 1974766267)
                                    (jump r15))))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 rdx)
                                (set! rdx r14)
                                (set! rsi r14)
                                (set! rdi 0)
                                (set! r15 r15)
                                (jump L.x.0.1)))
                            (begin
                              (set! (rbp - 0) r15)
                              (if (begin
                                    (begin
                                      (begin
                                        (set! rbp (- rbp 8))
                                        (return-point L.rp.2
                                                      (begin
                                                        (set! rdx 0)
                                                        (set! rsi 9223372036854775807)
                                                        (set! rdi 1)
                                                        (set! r15 L.rp.2)
                                                        (jump L.x.0.1)))
                                        (set! rbp (+ rbp 8)))
                                      (set! r14 rax))
                                    (begin
                                      (set! r15 9223372036854775807)
                                      (< r15 r14)))
                                  (begin
                                    (set! rdx 1)
                                    (set! rsi -9223372036854775808)
                                    (set! rdi 1)
                                    (set! r15 (rbp - 0))
                                    (jump L.x.0.1))
                                  (begin
                                    (begin
                                      (set! rbp (- rbp 8))
                                      (return-point L.rp.3
                                                    (begin
                                                      (set! rdx -1530356459)
                                                      (set! rsi 9223372036854775807)
                                                      (set! rdi 9223372036854775807)
                                                      (set! r15 L.rp.3)
                                                      (jump L.x.0.1)))
                                      (set! rbp (+ rbp 8)))
                                    (set! r15 rax)
                                    (if (= r15 r15)
                                        (begin
                                          (set! rax 9223372036854775807)
                                          (jump (rbp - 0)))
                                        (begin
                                          (set! rax 9223372036854775807)
                                          (jump (rbp - 0)))))))
                      ))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r14 r8)
                                (set! r14 r9)
                                (set! r13 -951184591)
                                (begin
                                  (set! r13 310790521)
                                  (set! rax r14)
                                  (jump r15))))
                            (begin
                              (set! r15 r15)
                              (set! r14 -1379426851)
                              (set! rax 488563830)
                              (jump r15))
                      ))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r8 rdx)
                                (if (if (begin
                                          (set! r9 0)
                                          (= r9 r14))
                                        (false)
                                        (if (<= r8 -483103791)
                                            (= r13 r14)
                                            (= r14 r13)))
                                    (begin
                                      (set! rdx 1)
                                      (set! rsi 1)
                                      (set! rdi r13)
                                      (set! r15 r15)
                                      (jump L.func.0.1))
                                    (begin
                                      (set! r14 r14)
                                      (set! rax r14)
                                      (jump r15)))))
                            (begin
                              (set! r15 r15)
                              (set! r14 -1766715399)
                              (begin
                                (set! r14 0)
                                (set! r14 (* r14 0))
                                (set! rax r14)
                                (jump r15)))
                      ))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (set! r15 rdi)
                                (set! (rbp - 16) rsi)
                                (set! (rbp - 8) rdx)
                                (set! r15 1591590730)
                                (begin
                                  (set! rbp (- rbp 24))
                                  (return-point L.rp.2
                                                (begin
                                                  (set! rdx (rbp - -16))
                                                  (set! rsi (rbp - -16))
                                                  (set! rdi 1001483234)
                                                  (set! r15 L.rp.2)
                                                  (jump L.tmp.0.1)))
                                  (set! rbp (+ rbp 24)))
                                (set! r15 rax)
                                (set! rdx (rbp - 16))
                                (set! rsi (rbp - 8))
                                (set! rdi -9223372036854775808)
                                (set! r15 (rbp - 0))
                                (jump L.tmp.0.1)))
                            (begin
                              (set! (rbp - 0) r15)
                              (if (if (begin
                                        (set! r15 1)
                                        (true))
                                      (begin
                                        (set! r15 -9223372036854775808)
                                        (true))
                                      (begin
                                        (set! r15 0)
                                        (true)))
                                  (begin
                                    (begin
                                      (set! rbp (- rbp 8))
                                      (return-point L.rp.3
                                                    (begin
                                                      (set! rdx 1)
                                                      (set! rsi 1188321444)
                                                      (set! rdi -1860695803)
                                                      (set! r15 L.rp.3)
                                                      (jump L.tmp.0.1)))
                                      (set! rbp (+ rbp 8)))
                                    (set! r15 rax))
                                  (begin
                                    (set! r15 -9223372036854775808)
                                    (set! r15 (+ r15 -335192473))
                                    (set! r15 r15)))
                              (if (if (!= r15 r15)
                                      (< r15 r15)
                                      (begin
                                        (set! r14 -1823864705)
                                        (false)))
                                  (begin
                                    (set! rdx 1739531838)
                                    (set! rsi r15)
                                    (set! rdi r15)
                                    (set! r15 (rbp - 0))
                                    (jump L.tmp.0.1))
                                  (begin
                                    (set! rdx -1707829089)
                                    (set! rsi -2103046426)
                                    (set! rdi 0)
                                    (set! r15 (rbp - 0))
                                    (jump L.tmp.0.1))))
                      ))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! rdi 9223372036854775807)
                                (set! r15 r15)
                                (jump L.fn.1.2)))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (if (begin
                                      (set! r13 1)
                                      (false))
                                    (begin
                                      (set! rdx -9223372036854775808)
                                      (set! rsi -9223372036854775808)
                                      (set! rdi r14)
                                      (set! r15 r15)
                                      (jump L.x.2.3))
                                    (if (if (> r14 9223372036854775807)
                                            (<= r14 2069349298)
                                            (begin
                                              (set! r13 327435684)
                                              (= r13 r14)))
                                        (begin
                                          (set! rdx r14)
                                          (set! rsi r14)
                                          (set! rdi 937688474)
                                          (set! r15 r15)
                                          (jump L.x.2.3))
                                        (begin
                                          (set! rax -9223372036854775808)
                                          (jump r15))))))
                      (define L.x.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r13 rsi)
                          (set! r13 rdx)
                          (set! rdx r13)
                          (set! rsi -845528888)
                          (set! rdi r14)
                          (set! r15 r15)
                          (jump L.x.2.3)))
                      (begin
                        (set! r15 r15)
                        (set! r14 0)
                        (set! rax r14)
                        (jump r15))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 rdx)
                                (set! r9 rcx)
                                (set! r9 r8)
                                (if (begin
                                      (set! r14 -9223372036854775808)
                                      (true))
                                    (begin
                                      (set! rax 0)
                                      (jump r15))
                                    (begin
                                      (set! rax 849007740)
                                      (jump r15)))))
                            (define L.x.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 r13)
                                (set! r8 9223372036854775807)
                                (set! rcx 0)
                                (set! rdx r13)
                                (set! rsi 0)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.x.0.1)))
                      (define L.x.2.3
                        (begin
                          (set! (rbp - 0) r15)
                          (set! r15 rdi)
                          (set! r15 rsi)
                          (set! r15 rdx)
                          (set! r15 rcx)
                          (set! r15 r8)
                          (begin
                            (set! rbp (- rbp 8))
                            (return-point L.rp.4
                                          (begin
                                            (set! rsi r15)
                                            (set! rdi r15)
                                            (set! r15 L.rp.4)
                                            (jump L.x.1.2)))
                            (set! rbp (+ rbp 8)))
                          (set! r15 rax)
                          (set! rsi 1)
                          (set! rdi -1927041153)
                          (set! r15 (rbp - 0))
                          (jump L.x.1.2)))
                      (begin
                        (set! r15 r15)
                        (set! r14 1)
                        (set! r14 (* r14 -394936001))
                        (set! r14 r14)
                        (set! r8 r14)
                        (set! rcx -9223372036854775808)
                        (set! rdx 0)
                        (set! rsi r14)
                        (set! rdi r14)
                        (set! r15 r15)
                        (jump L.x.0.1))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! rcx 9223372036854775807)
                                (set! rdx r14)
                                (set! rsi r14)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.fn.1.2)))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r13 rcx)
                                (set! rsi r14)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.tmp.0.1)))
                      (begin
                        (set! r15 r15)
                        (set! rsi 698097472)
                        (set! rdi -880757424)
                        (set! r15 r15)
                        (jump L.tmp.0.1))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r14 r8)
                                (set! rax r14)
                                (jump r15)))
                            (begin
                              (set! (rbp - 0) r15)
                              (begin
                                (set! rbp (- rbp 8))
                                (return-point L.rp.2
                                              (begin
                                                (set! r8 -9223372036854775808)
                                                (set! rcx 1)
                                                (set! rdx 0)
                                                (set! rsi -9223372036854775808)
                                                (set! rdi 1)
                                                (set! r15 L.rp.2)
                                                (jump L.tmp.0.1)))
                                (set! rbp (+ rbp 8)))
                              (set! r14 rax)
                              (if (begin
                                    (set! r15 -9223372036854775808)
                                    (false))
                                  (begin
                                    (set! rax -1855219983)
                                    (jump (rbp - 0)))
                                  (begin
                                    (set! rax r14)
                                    (jump (rbp - 0)))))
                      ))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (if (begin
                                      (set! r13 1541307282)
                                      (begin
                                        (set! r13 9223372036854775807)
                                        (false)))
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (- r14 -1702731989))
                                      (set! r14 r14))
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 r14)))
                                (if (not (begin
                                           (set! r13 -9223372036854775808)
                                           (= r13 r14)))
                                    (begin
                                      (set! r13 1)
                                      (set! rax r14)
                                      (jump r15))
                                    (begin
                                      (set! rdi 0)
                                      (set! r15 r15)
                                      (jump L.proc.0.1)))))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 9223372036854775807)
                                (set! r14 (+ r14 1))
                                (set! rax r14)
                                (jump r15)))
                      (define L.fn.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r14 1)
                          (set! r14 (* r14 0))
                          (set! r14 r14)
                          (set! r15 r15)
                          (jump L.fn.1.2)))
                      (begin
                        (set! (rbp - 0) r15)
                        (begin
                          (begin
                            (set! rbp (- rbp 8))
                            (return-point L.rp.4
                                          (begin
                                            (set! rdi 1)
                                            (set! r15 L.rp.4)
                                            (jump L.fn.2.3)))
                            (set! rbp (+ rbp 8)))
                          (set! r15 rax)
                          (set! r15 r15)
                          (set! rax 1)
                          (jump (rbp - 0))))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r15 rdx)
                                (set! (rbp - 8) rcx)
                                (set! r14 r8)
                                (begin
                                  (set! rbp (- rbp 16))
                                  (return-point L.rp.4
                                                (begin
                                                  (set! r8 1)
                                                  (set! rcx r15)
                                                  (set! rdx r14)
                                                  (set! rsi r14)
                                                  (set! rdi 0)
                                                  (set! r15 L.rp.4)
                                                  (jump L.x.0.1)))
                                  (set! rbp (+ rbp 16)))
                                (set! r15 rax)
                                (set! r15 r15)
                                (set! r15 (- r15 r15))
                                (set! r15 r15)
                                (begin
                                  (set! r15 -9223372036854775808)
                                  (set! r15 (* r15 (rbp - 8)))
                                  (set! rax r15)
                                  (jump (rbp - 0)))))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r9 rcx)
                                (set! r8 r8)
                                (begin
                                  (set! r14 r13)
                                  (set! rax 1)
                                  (jump r15))))
                      (define L.tmp.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 1)
                          (set! r14 r14)
                          (if (if (begin
                                    (set! r13 9223372036854775807)
                                    (true))
                                  (false)
                                  (true))
                              (begin
                                (set! rax r14)
                                (jump r15))
                              (begin
                                (set! r8 9223372036854775807)
                                (set! rcx r14)
                                (set! rdx r14)
                                (set! rsi -126978532)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.x.0.1)))))
                      (begin
                        (set! r15 r15)
                        (set! r14 -1293429216)
                        (set! r14 (* r14 880066208))
                        (set! rax r14)
                        (jump r15))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! rdi rdx)
                                (set! rsi rcx)
                                (set! r8 r8)
                                (set! rdi r9)
                                (if (not (if (begin
                                               (set! r9 0)
                                               (false))
                                             (!= rsi 9223372036854775807)
                                             (< rdi rdi)))
                                    (if (begin
                                          (set! r13 1779018832)
                                          (= r13 rdi))
                                        (begin
                                          (set! rax -9223372036854775808)
                                          (jump r15))
                                        (begin
                                          (set! rax r14)
                                          (jump r15)))
                                    (begin
                                      (set! r9 r14)
                                      (set! r8 r8)
                                      (set! rcx rsi)
                                      (set! rdx 9223372036854775807)
                                      (set! rsi rdi)
                                      (set! rdi 1)
                                      (set! r15 r15)
                                      (jump L.proc.0.1)))))
                            (define L.proc.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r9 rdx)
                                (if (begin
                                      (set! r9 -408033154)
                                      (<= r9 r14))
                                    (begin
                                      (set! r9 r13)
                                      (set! r9 (+ r9 r14))
                                      (set! r9 r9))
                                    (begin
                                      (set! r13 r13)
                                      (set! r9 r13)))
                                (set! rdx r13)
                                (set! rsi r14)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.proc.1.2)))
                      (begin
                        (set! r15 r15)
                        (if (begin
                              (set! r14 1)
                              (true))
                            (set! r14 0)
                            (set! r14 0))
                        (set! r9 -9223372036854775808)
                        (set! r8 1792291800)
                        (set! rcx r14)
                        (set! rdx 1961997671)
                        (set! rsi r14)
                        (set! rdi r14)
                        (set! r15 r15)
                        (jump L.proc.0.1))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r9 rcx)
                                (if (begin
                                      (set! r9 r9)
                                      (begin
                                        (set! r9 -9223372036854775808)
                                        (true)))
                                    (begin
                                      (set! r9 1)
                                      (set! r13 r13))
                                    (set! r13 r13))
                                (begin
                                  (set! r14 r14)
                                  (set! rax r13)
                                  (jump r15))))
                            (begin
                              (set! r15 r15)
                              (set! r14 480297521)
                              (if (= r14 0)
                                  (begin
                                    (set! r14 r14)
                                    (set! r14 0)
                                    (set! rcx r14)
                                    (set! rdx 0)
                                    (set! rsi 9223372036854775807)
                                    (set! rdi 9223372036854775807)
                                    (set! r15 r15)
                                    (jump L.x.0.1))
                                  (if (begin
                                        (set! r13 1)
                                        (>= r14 1434817833))
                                      (begin
                                        (set! r14 -9223372036854775808)
                                        (set! r14 (* r14 -1655015632))
                                        (set! rax r14)
                                        (jump r15))
                                      (begin
                                        (set! r14 -9223372036854775808)
                                        (set! rax 1398310587)
                                        (jump r15)))))
                      ))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! rdi rcx)
                                (set! r8 r8)
                                (set! r9 r9)
                                (set! rsi (rbp - 0))
                                (if (begin
                                      (set! rsi 9223372036854775807)
                                      (true))
                                    (if (if (> r13 1)
                                            (> r9 -9223372036854775808)
                                            (!= r8 -847185955))
                                        (begin
                                          (set! (rbp - 0) -260761950)
                                          (set! r9 0)
                                          (set! r8 -9223372036854775808)
                                          (set! rcx rdi)
                                          (set! rdx r14)
                                          (set! rsi -144908363)
                                          (set! rdi 9223372036854775807)
                                          (set! r15 r15)
                                          (jump L.func.0.1))
                                        (if (> rdi rdi)
                                            (begin
                                              (set! rax 0)
                                              (jump r15))
                                            (begin
                                              (set! rax 1)
                                              (jump r15))))
                                    (begin
                                      (set! r13 9223372036854775807)
                                      (set! (rbp - 0) 0)
                                      (set! r9 r14)
                                      (set! r8 r14)
                                      (set! rcx 9223372036854775807)
                                      (set! rdx -9223372036854775808)
                                      (set! rsi -472335653)
                                      (set! rdi -9223372036854775808)
                                      (set! r15 r15)
                                      (jump L.func.0.1)))))
                            (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 1)
                                    (false))
                                  (begin
                                    (set! r14 1)
                                    (set! rax r14)
                                    (jump r15))
                                  (begin
                                    (set! rax -32529780)
                                    (jump r15))))
                      ))

  ;;

  ;; M6 tests; Added by Trevor on March 6th 2026, multiple bindings allowed per let
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r14 r8)
                                (set! r14 r9)
                                (set! r14 (rbp - 0))
                                (set! r15 r15)
                                (jump L.tmp.1.2)))
                            (define L.tmp.1.2
                              (begin
                                (set! r15 r15)
                                (set! rsi 0)
                                (set! rdi 0)
                                (set! r15 r15)
                                (jump L.proc.2.3)))
                      (define L.proc.2.3
                        (begin
                          (set! r15 r15)
                          (set! r13 rdi)
                          (set! r14 rsi)
                          (set! (rbp - 0) 1635273112)
                          (set! r9 r13)
                          (set! r8 r14)
                          (set! rcx r13)
                          (set! rdx 445965252)
                          (set! rsi r13)
                          (set! rdi r14)
                          (set! r15 r15)
                          (jump L.proc.0.1)))
                      (begin
                        (set! r15 r15)
                        (if (if (begin
                                  (set! r14 9223372036854775807)
                                  (false))
                                (begin
                                  (set! r14 692968731)
                                  (false))
                                (begin
                                  (set! r14 -1490931083)
                                  (true)))
                            (begin
                              (set! rax 1275113131)
                              (jump r15))
                            (if (begin
                                  (set! r14 -1702177019)
                                  (false))
                                (begin
                                  (set! rax 0)
                                  (jump r15))
                                (begin
                                  (set! rax 1843455920)
                                  (jump r15)))))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 rdx)
                                (set! rdi rcx)
                                (set! r13 r8)
                                (set! r13 r9)
                                (set! r9 (rbp - 0))
                                (set! (rbp - 0) r13)
                                (set! r9 rdi)
                                (set! r8 rdi)
                                (set! rcx 9223372036854775807)
                                (set! rdx r14)
                                (set! rsi -9223372036854775808)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.fn.0.1)))
                            (begin
                              (set! r15 r15)
                              (set! r14 9223372036854775807)
                              (set! r14 9223372036854775807)
                              (set! r13 9223372036854775807)
                              (set! rax r14)
                              (jump r15))
                      ))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (set! r14 rdi)
                                (set! r15 rsi)
                                (set! r15 rdx)
                                (set! r13 rcx)
                                (set! (rbp - 8) r8)
                                (begin
                                  (set! r14 r14)
                                  (begin
                                    (set! rbp (- rbp 16))
                                    (return-point L.rp.3
                                                  (begin
                                                    (set! rdx -1140169546)
                                                    (set! rsi r13)
                                                    (set! rdi r15)
                                                    (set! r15 L.rp.3)
                                                    (jump L.func.1.2)))
                                    (set! rbp (+ rbp 16)))
                                  (set! r15 rax)
                                  (set! r14 (rbp - 8))
                                  (set! r14 (+ r14 r15))
                                  (set! rax r14)
                                  (jump (rbp - 0)))))
                            (define L.func.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r8 rdx)
                                (if (begin
                                      (set! r9 9223372036854775807)
                                      (true))
                                    (begin
                                      (set! rdx r8)
                                      (set! rsi r8)
                                      (set! rdi r14)
                                      (set! r15 r15)
                                      (jump L.func.1.2))
                                    (begin
                                      (set! r14 -9223372036854775808)
                                      (set! r14 (+ r14 r13))
                                      (set! rax r14)
                                      (jump r15)))))
                      (begin
                        (set! r15 r15)
                        (if (begin
                              (set! r14 9223372036854775807)
                              (false))
                            (begin
                              (set! rax -877748660)
                              (jump r15))
                            (begin
                              (set! rax -9223372036854775808)
                              (jump r15))))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 -1640821439)
                              (set! r14 (+ r14 -406700566))
                              (set! rax r14)
                              (jump r15))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r9 r14)
                                (set! r8 r13)
                                (set! rcx -9223372036854775808)
                                (set! rdx r13)
                                (set! rsi r14)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.x.1.2)))
                            (define L.x.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r13 r8)
                                (set! r13 r9)
                                (set! r9 r14)
                                (set! r8 1)
                                (set! rcx -984231193)
                                (set! rdx r13)
                                (set! rsi r13)
                                (set! rdi 933807622)
                                (set! r15 r15)
                                (jump L.x.1.2)))
                      (begin
                        (set! r15 r15)
                        (set! r14 -477286222)
                        (set! r14 0)
                        (set! rax 643069821)
                        (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (if (!= r14 r14)
                                    (begin
                                      (set! rdi 2058053814)
                                      (set! r15 r15)
                                      (jump L.func.0.1))
                                    (begin
                                      (set! r13 r14)
                                      (set! r13 (- r13 r14))
                                      (set! r13 r13)
                                      (set! r14 r14)
                                      (set! r14 r14)
                                      (set! r14 r14)
                                      (set! r13 r14)
                                      (set! rdi r14)
                                      (set! r15 r15)
                                      (jump L.x.2.3)))))
                            (define L.tmp.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 rdx)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.x.2.3)))
                      (define L.x.2.3
                        (begin
                          (set! (rbp - 0) r15)
                          (set! r15 rdi)
                          (begin
                            (set! rbp (- rbp 8))
                            (return-point L.rp.4
                                          (begin
                                            (set! rdx -1942673900)
                                            (set! rsi r15)
                                            (set! rdi r15)
                                            (set! r15 L.rp.4)
                                            (jump L.tmp.1.2)))
                            (set! rbp (+ rbp 8)))
                          (set! r15 rax)
                          (if (begin
                                (set! r15 r15)
                                (set! r15 r15)
                                (set! r15 r15)
                                (= r15 r15))
                              (begin
                                (set! rdx -1386061378)
                                (set! rsi r15)
                                (set! rdi r15)
                                (set! r15 (rbp - 0))
                                (jump L.tmp.1.2))
                              (begin
                                (set! rdi r15)
                                (set! r15 (rbp - 0))
                                (jump L.func.0.1)))))
                      (begin
                        (set! r15 r15)
                        (begin
                          (set! r14 9223372036854775807)
                          (set! r14 (+ r14 -9223372036854775808))
                          (set! rax r14)
                          (jump r15)))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 1)
                                    (false))
                                  (begin
                                    (set! rax 2012039291)
                                    (jump r15))
                                  (begin
                                    (set! rax 9223372036854775807)
                                    (jump r15))))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 rdx)
                                (set! rdi rcx)
                                (set! r8 r8)
                                (set! r9 r9)
                                (set! r14 r14)
                                (set! r14 (- r14 r13))
                                (set! rax r14)
                                (jump r15)))
                            (define L.proc.1.2
                              (begin
                                (set! (rbp - 0) r15)
                                (set! r15 9223372036854775807)
                                (set! r15 (+ r15 1))
                                (set! (rbp - 8) r15)
                                (begin
                                  (set! rbp (- rbp 16))
                                  (return-point L.rp.4
                                                (begin
                                                  (set! r9 (rbp - -8))
                                                  (set! r8 (rbp - -8))
                                                  (set! rcx (rbp - -8))
                                                  (set! rdx (rbp - -8))
                                                  (set! rsi (rbp - -8))
                                                  (set! rdi 0)
                                                  (set! r15 L.rp.4)
                                                  (jump L.func.0.1)))
                                  (set! rbp (+ rbp 16)))
                                (set! r15 rax)
                                (set! r14 (rbp - 8))
                                (if (>= (rbp - 8) (rbp - 8))
                                    (set! r14 (rbp - 8))
                                    (set! r14 (rbp - 8)))
                                (set! r15 r15)
                                (set! r15 r15)
                                (set! r15 -9223372036854775808)
                                (set! rax 9223372036854775807)
                                (jump (rbp - 0))))
                      (define L.func.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r13 rsi)
                          (set! r9 rdx)
                          (set! r9 rcx)
                          (set! r13 r13)
                          (set! r9 r9)
                          (set! r9 r9)
                          (set! r8 r13)
                          (if (>= r13 r9)
                              (begin
                                (set! rax r13)
                                (jump r15))
                              (begin
                                (set! rax r14)
                                (jump r15)))))
                      (begin
                        (set! r15 r15)
                        (set! rcx 9223372036854775807)
                        (set! rdx -1735352110)
                        (set! rsi 9223372036854775807)
                        (set! rdi 0)
                        (set! r15 r15)
                        (jump L.func.2.3))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! (rbp - 8) r15)
                                (set! r15 rdi)
                                (set! (rbp - 24) rsi)
                                (set! r14 rdx)
                                (set! (rbp - 32) rcx)
                                (set! (rbp - 16) r8)
                                (set! r13 r9)
                                (set! r14 (rbp - 0))
                                (begin
                                  (set! rbp (- rbp 40))
                                  (return-point L.rp.3
                                                (begin
                                                  (set! (rbp - 0) r13)
                                                  (set! r9 r15)
                                                  (set! r8 r13)
                                                  (set! rcx 0)
                                                  (set! rdx r14)
                                                  (set! rsi (rbp - -8))
                                                  (set! rdi (rbp - -8))
                                                  (set! r15 L.rp.3)
                                                  (jump L.fn.1.2)))
                                  (set! rbp (+ rbp 40)))
                                (set! r15 rax)
                                (if (not (begin
                                           (set! r14 0)
                                           (false)))
                                    (begin
                                      (set! r14 (rbp - 16))
                                      (set! r14 (+ r14 r15))
                                      (set! rax r14)
                                      (jump (rbp - 8)))
                                    (if (<= (rbp - 32) 0)
                                        (begin
                                          (set! rax (rbp - 32))
                                          (jump (rbp - 8)))
                                        (begin
                                          (set! rax (rbp - 24))
                                          (jump (rbp - 8)))))))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r13 rcx)
                                (set! r8 r8)
                                (set! r8 r9)
                                (set! r9 (rbp - 0))
                                (set! (rbp - 0) 0)
                                (set! r9 r14)
                                (set! r8 r8)
                                (set! rcx -9223372036854775808)
                                (set! rdx r14)
                                (set! rsi r8)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.fn.1.2)))
                      (begin
                        (set! r15 r15)
                        (if (begin
                              (set! r14 -9223372036854775808)
                              (false))
                            (begin
                              (set! rax -9223372036854775808)
                              (jump r15))
                            (begin
                              (set! rax 0)
                              (jump r15))))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! rax 9223372036854775807)
                              (jump r15))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 rdx)
                                (set! rdi rcx)
                                (set! r13 r8)
                                (set! r9 r9)
                                (set! r9 rdi)
                                (set! r8 r14)
                                (set! rcx -635532414)
                                (set! rdx r13)
                                (set! rsi r13)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.proc.0.1)))
                            (define L.tmp.1.2
                              (begin
                                (set! (rbp - 8) r15)
                                (set! (rbp - 24) rdi)
                                (set! (rbp - 0) rsi)
                                (set! (rbp - 32) rdx)
                                (set! (rbp - 40) rcx)
                                (set! (rbp - 16) r8)
                                (begin
                                  (set! rbp (- rbp 56))
                                  (return-point L.rp.4
                                                (begin
                                                  (set! r8 (rbp - -40))
                                                  (set! rcx (rbp - -16))
                                                  (set! rdx (rbp - -32))
                                                  (set! rsi (rbp - -40))
                                                  (set! rdi (rbp - -16))
                                                  (set! r15 L.rp.4)
                                                  (jump L.tmp.1.2)))
                                  (set! rbp (+ rbp 56)))
                                (set! (rbp - 48) rax)
                                (begin
                                  (set! rbp (- rbp 56))
                                  (return-point L.rp.5
                                                (begin
                                                  (set! (rbp - 0) (rbp - -40))
                                                  (set! r9 (rbp - -24))
                                                  (set! r8 (rbp - -16))
                                                  (set! rcx -501684781)
                                                  (set! rdx (rbp - -40))
                                                  (set! rsi 9223372036854775807)
                                                  (set! rdi (rbp - -56))
                                                  (set! r15 L.rp.5)
                                                  (jump L.func.2.3)))
                                  (set! rbp (+ rbp 56)))
                                (set! r15 rax)
                                (set! r15 (rbp - 0))
                                (begin
                                  (set! rbp (- rbp 56))
                                  (return-point L.rp.6
                                                (begin
                                                  (set! (rbp - 0) (rbp - -32))
                                                  (set! r9 (rbp - -56))
                                                  (set! r8 (rbp - -24))
                                                  (set! rcx -9223372036854775808)
                                                  (set! rdx (rbp - -40))
                                                  (set! rsi 1644735104)
                                                  (set! rdi (rbp - -32))
                                                  (set! r15 L.rp.6)
                                                  (jump L.func.2.3)))
                                  (set! rbp (+ rbp 56)))
                                (set! r15 rax)
                                (set! r14 (rbp - 48))
                                (set! r14 (- r14 (rbp - 48)))
                                (set! r14 r14)
                                (if (= (rbp - 48) r15)
                                    (set! r14 r15)
                                    (set! r14 (rbp - 48)))
                                (set! (rbp - 0) r15)
                                (set! r9 -9223372036854775808)
                                (set! r8 (rbp - 24))
                                (set! rcx r14)
                                (set! rdx (rbp - 16))
                                (set! rsi (rbp - 16))
                                (set! rdi r15)
                                (set! r15 (rbp - 8))
                                (jump L.func.2.3)))
                      (define L.func.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r14 rsi)
                          (set! r14 rdx)
                          (set! r13 rcx)
                          (set! r14 r8)
                          (set! r9 r9)
                          (set! r8 (rbp - 0))
                          (set! (rbp - 0) 9223372036854775807)
                          (set! r9 r13)
                          (set! r8 r8)
                          (set! rcx r8)
                          (set! rdx r13)
                          (set! rsi -9223372036854775808)
                          (set! rdi r14)
                          (set! r15 r15)
                          (jump L.func.2.3)))
                      (begin
                        (set! r15 r15)
                        (set! r14 -9223372036854775808)
                        (set! r13 9223372036854775807)
                        (set! r13 9223372036854775807)
                        (set! rax r14)
                        (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (set! r15 rdi)
                                (set! (rbp - 16) rsi)
                                (set! (rbp - 24) rdx)
                                (set! (rbp - 32) rcx)
                                (set! (rbp - 8) r8)
                                (if (begin
                                      (set! r14 (rbp - 24))
                                      (if (<= (rbp - 32) (rbp - 8))
                                          (set! r14 (rbp - 32))
                                          (set! r14 (rbp - 8)))
                                      (begin
                                        (begin
                                          (set! rbp (- rbp 40))
                                          (return-point L.rp.3
                                                        (begin
                                                          (set! r8 (rbp - -32))
                                                          (set! rcx r15)
                                                          (set! rdx r15)
                                                          (set! rsi (rbp - -16))
                                                          (set! rdi 1)
                                                          (set! r15 L.rp.3)
                                                          (jump L.func.0.1)))
                                          (set! rbp (+ rbp 40)))
                                        (set! r15 rax))
                                      (false))
                                    (begin
                                      (set! r8 0)
                                      (set! rcx (rbp - 24))
                                      (set! rdx 1603961181)
                                      (set! rsi (rbp - 16))
                                      (set! rdi (rbp - 8))
                                      (set! r15 (rbp - 0))
                                      (jump L.func.0.1))
                                    (begin
                                      (set! r9 (rbp - 32))
                                      (set! r8 (rbp - 8))
                                      (set! rcx (rbp - 16))
                                      (set! rdx (rbp - 8))
                                      (set! rsi -9223372036854775808)
                                      (set! rdi (rbp - 16))
                                      (set! r15 (rbp - 0))
                                      (jump L.fn.1.2)))))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! rdi rsi)
                                (set! rsi rdx)
                                (set! rdx rcx)
                                (set! r13 r8)
                                (set! r9 r9)
                                (if (if (>= r13 r14)
                                        (> rdi -9223372036854775808)
                                        (>= rsi r13))
                                    (begin
                                      (set! r9 rdx)
                                      (set! r9 9223372036854775807)
                                      (set! r14 r14)
                                      (set! rax r13)
                                      (jump r15))
                                    (if (< r13 r14)
                                        (begin
                                          (set! rax rdx)
                                          (jump r15))
                                        (begin
                                          (set! rax rdi)
                                          (jump r15))))))
                      (begin
                        (set! r15 r15)
                        (set! r14 405359082)
                        (if (not (begin
                                   (set! r13 -915730633)
                                   (false)))
                            (begin
                              (set! r13 -532660031)
                              (set! r13 -248685178))
                            (set! r13 0))
                        (set! r9 1254220652)
                        (set! r9 r14)
                        (set! r8 r13)
                        (set! rcx 9223372036854775807)
                        (set! rdx r13)
                        (set! rsi r13)
                        (set! rdi -9223372036854775808)
                        (set! r15 r15)
                        (jump L.fn.1.2))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r13 rcx)
                                (set! r13 r8)
                                (set! r8 1)
                                (set! rcx -1754605622)
                                (set! rdx -675715652)
                                (set! rsi r14)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.proc.0.1)))
                            (define L.func.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r8 r13)
                                (set! rcx r13)
                                (set! rdx r14)
                                (set! rsi r14)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.proc.0.1)))
                      (define L.x.2.3
                        (begin
                          (set! (rbp - 8) r15)
                          (set! (rbp - 32) rdi)
                          (set! r14 rsi)
                          (set! r15 rdx)
                          (set! (rbp - 24) rcx)
                          (set! r13 r8)
                          (set! r9 r9)
                          (set! (rbp - 16) (rbp - 0))
                          (if (>= (rbp - 24) (rbp - 16))
                              (set! r15 r14)
                              (begin
                                (begin
                                  (set! rbp (- rbp 40))
                                  (return-point L.rp.4
                                                (begin
                                                  (set! (rbp - 0) 1783645727)
                                                  (set! r9 r9)
                                                  (set! r8 (rbp - -16))
                                                  (set! rcx r13)
                                                  (set! rdx 0)
                                                  (set! rsi r15)
                                                  (set! rdi 1)
                                                  (set! r15 L.rp.4)
                                                  (jump L.x.2.3)))
                                  (set! rbp (+ rbp 40)))
                                (set! r15 rax)))
                          (set! r15 (rbp - 24))
                          (set! r15 (* r15 (rbp - 24)))
                          (set! r15 r15)
                          (set! (rbp - 0) (rbp - 24))
                          (set! r9 (rbp - 32))
                          (set! r8 -922337918)
                          (set! rcx (rbp - 16))
                          (set! rdx (rbp - 16))
                          (set! rsi (rbp - 24))
                          (set! rdi (rbp - 16))
                          (set! r15 (rbp - 8))
                          (jump L.x.2.3)))
                      (begin
                        (set! r15 r15)
                        (set! r14 0)
                        (set! r13 1029279872)
                        (set! rax r14)
                        (jump r15))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (if (if (begin
                                        (set! r14 1)
                                        (set! r13 -1606724555)
                                        (true))
                                      (begin
                                        (set! r14 1)
                                        (set! r13 1)
                                        (set! r13 -9223372036854775808)
                                        (true))
                                      (begin
                                        (begin
                                          (set! r14 -1879829070)
                                          (true))))
                                  (begin
                                    (set! r14 -634246165)
                                    (set! r14 (- r14 -684848771))
                                    (set! rax r14)
                                    (jump r15))
                                  (begin
                                    (set! rax 0)
                                    (jump r15))))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 rdx)
                                (set! rdx r14)
                                (set! rsi -1803672217)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.proc.1.2)))
                            (define L.proc.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! rdx r13)
                                (set! rsi r14)
                                (set! rdi 1)
                                (set! r15 r15)
                                (jump L.proc.1.2)))
                      (begin
                        (set! r15 r15)
                        (set! r14 0)
                        (set! rax r14)
                        (jump r15))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 1550347185)
                              (set! r14 9223372036854775807)
                              (set! r13 -9223372036854775808)
                              (set! r14 r14)
                              (set! r14 r14)
                              (set! r13 9223372036854775807)
                              (set! r13 (- r13 r14))
                              (set! rax r13)
                              (jump r15))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (set! (rbp - 24) rdi)
                                (set! (rbp - 16) rsi)
                                (set! (rbp - 8) rdx)
                                (begin
                                  (set! rbp (- rbp 56))
                                  (return-point L.rp.2
                                                (begin
                                                  (set! rdx (rbp - -48))
                                                  (set! rsi (rbp - -48))
                                                  (set! rdi 9223372036854775807)
                                                  (set! r15 L.rp.2)
                                                  (jump L.proc.0.1)))
                                  (set! rbp (+ rbp 56)))
                                (set! (rbp - 40) rax)
                                (begin
                                  (set! rbp (- rbp 56))
                                  (return-point L.rp.3
                                                (begin
                                                  (set! rdx (rbp - -32))
                                                  (set! rsi (rbp - -48))
                                                  (set! rdi (rbp - -32))
                                                  (set! r15 L.rp.3)
                                                  (jump L.proc.0.1)))
                                  (set! rbp (+ rbp 56)))
                                (set! (rbp - 32) rax)
                                (begin
                                  (set! rbp (- rbp 56))
                                  (return-point L.rp.4
                                                (begin
                                                  (set! rdx (rbp - -32))
                                                  (set! rsi (rbp - -48))
                                                  (set! rdi (rbp - -48))
                                                  (set! r15 L.rp.4)
                                                  (jump L.proc.0.1)))
                                  (set! rbp (+ rbp 56)))
                                (set! (rbp - 24) rax)
                                (set! r15 (rbp - 16))
                                (begin
                                  (set! rbp (- rbp 56))
                                  (return-point L.rp.5
                                                (begin
                                                  (set! rdx (rbp - -40))
                                                  (set! rsi (rbp - -48))
                                                  (set! rdi (rbp - -48))
                                                  (set! r15 L.rp.5)
                                                  (jump L.proc.0.1)))
                                  (set! rbp (+ rbp 56)))
                                (set! r15 rax)
                                (begin
                                  (set! rbp (- rbp 56))
                                  (return-point L.rp.6
                                                (begin
                                                  (set! rdx (rbp - -32))
                                                  (set! rsi r15)
                                                  (set! rdi r15)
                                                  (set! r15 L.rp.6)
                                                  (jump L.proc.0.1)))
                                  (set! rbp (+ rbp 56)))
                                (set! r15 rax)
                                (if (> r15 (rbp - 8))
                                    (if (>= (rbp - 40) (rbp - 40))
                                        (begin
                                          (set! rax (rbp - 8))
                                          (jump (rbp - 0)))
                                        (begin
                                          (set! rax r15)
                                          (jump (rbp - 0))))
                                    (begin
                                      (set! r15 -2087609688)
                                      (set! r15 (rbp - 40))
                                      (set! rax (rbp - 32))
                                      (jump (rbp - 0))))))
                            (begin
                              (set! r15 r15)
                              (set! r14 1)
                              (set! r14 -9223372036854775808)
                              (set! rax r14)
                              (jump r15))
                      ))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (begin
                                  (set! rcx 2099518136)
                                  (set! rdx r14)
                                  (set! rsi r14)
                                  (set! rdi r14)
                                  (set! r15 r15)
                                  (jump L.func.2.3))))
                            (define L.tmp.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! rdi rdx)
                                (set! r13 rcx)
                                (set! r8 r8)
                                (set! r9 r9)
                                (set! r9 9223372036854775807)
                                (set! r9 rdi)
                                (set! r9 (+ r9 r14))
                                (set! r9 r9)
                                (set! r13 r13)
                                (set! r13 (+ r13 r14))
                                (set! r13 r13)
                                (set! r14 r14)
                                (set! rdi 0)
                                (set! r15 r15)
                                (jump L.fn.0.1)))
                      (define L.func.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r13 rsi)
                          (set! r8 rdx)
                          (set! r13 rcx)
                          (set! r9 9223372036854775807)
                          (set! r8 r8)
                          (set! rcx r14)
                          (set! rdx r13)
                          (set! rsi r13)
                          (set! rdi 1)
                          (set! r15 r15)
                          (jump L.tmp.1.2)))
                      (begin
                        (set! r15 r15)
                        (set! r14 1)
                        (set! r14 (+ r14 9223372036854775807))
                        (set! r14 r14)
                        (set! rax r14)
                        (jump r15))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 0)
                              (set! r14 1)
                              (set! rax r14)
                              (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r9 0)
                                (set! r8 1)
                                (set! rcx 9223372036854775807)
                                (set! rdx 9223372036854775807)
                                (set! rsi 1)
                                (set! rdi 38797657)
                                (set! r15 r15)
                                (jump L.x.1.2)))
                            (define L.x.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 rdx)
                                (set! rdi rcx)
                                (set! rsi r8)
                                (set! r8 r9)
                                (if (if (>= rsi rsi)
                                        (< r14 rdi)
                                        (< r8 812242710))
                                    (begin
                                      (set! r14 rsi)
                                      (set! r14 (- r14 rdi))
                                      (set! rax r14)
                                      (jump r15))
                                    (begin
                                      (set! r15 r15)
                                      (jump L.func.0.1)))))
                      (begin
                        (set! r15 r15)
                        (set! r9 -9223372036854775808)
                        (set! r8 0)
                        (set! rcx -9223372036854775808)
                        (set! rdx -9223372036854775808)
                        (set! rsi -2062025435)
                        (set! rdi 0)
                        (set! r15 r15)
                        (jump L.x.1.2))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r13 rdx)
                                (set! r9 rcx)
                                (set! rdx r13)
                                (set! rsi -9223372036854775808)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.proc.1.2)))
                            (define L.proc.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r14 r14)
                                (set! r14 (- r14 r13))
                                (set! rax r14)
                                (jump r15)))
                      (begin
                        (set! r15 r15)
                        (set! rax 1)
                        (jump r15))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 -550916464)
                              (set! r14 9223372036854775807)
                              (set! rax r14)
                              (jump r15))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (begin
                                (set! r14 9223372036854775807)
                                (set! r14 (- r14 1))
                                (set! rax r14)
                                (jump r15)))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! (rbp - 0) r15)
                                (set! (rbp - 16) rdi)
                                (set! (rbp - 8) rsi)
                                (set! r15 rdx)
                                (set! (rbp - 24) rcx)
                                (begin
                                  (set! rbp (- rbp 32))
                                  (return-point L.rp.3
                                                (begin
                                                  (set! rcx (rbp - -16))
                                                  (set! rdx (rbp - -8))
                                                  (set! rsi (rbp - -24))
                                                  (set! rdi (rbp - -24))
                                                  (set! r15 L.rp.3)
                                                  (jump L.tmp.0.1)))
                                  (set! rbp (+ rbp 32)))
                                (set! r15 rax)
                                (set! r15 (rbp - 8))
                                (set! r15 (- r15 (rbp - 24)))
                                (set! r15 r15)
                                (set! r15 (rbp - 8))
                                (set! r15 1)
                                (set! r15 (rbp - 24))
                                (set! r15 (rbp - 16))
                                (begin
                                  (set! rbp (- rbp 32))
                                  (return-point L.rp.4
                                                (begin
                                                  (set! rdx (rbp - -16))
                                                  (set! rsi 9223372036854775807)
                                                  (set! rdi (rbp - -8))
                                                  (set! r15 L.rp.4)
                                                  (jump L.x.1.2)))
                                  (set! rbp (+ rbp 32)))
                                (set! r15 rax)
                                (set! rdx (rbp - 8))
                                (set! rsi (rbp - 8))
                                (set! rdi -9223372036854775808)
                                (set! r15 (rbp - 0))
                                (jump L.x.1.2)))
                            (define L.x.1.2
                              (begin
                                (set! r15 r15)
                                (set! r9 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (begin
                                  (set! rdx r13)
                                  (set! rsi 580696126)
                                  (set! rdi r13)
                                  (set! r15 r15)
                                  (jump L.x.1.2))))
                      (begin
                        (set! r15 r15)
                        (if (begin
                              (set! r14 9223372036854775807)
                              (true))
                            (begin
                              (set! rax -1677147892)
                              (jump r15))
                            (begin
                              (set! rax 874915829)
                              (jump r15))))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! (rbp - 8) r15)
                                (set! (rbp - 40) rdi)
                                (set! (rbp - 24) rsi)
                                (set! (rbp - 48) rdx)
                                (set! r15 rcx)
                                (set! (rbp - 32) r8)
                                (set! (rbp - 16) r9)
                                (set! (rbp - 0) (rbp - 0))
                                (if (not (> (rbp - 0) -727829088))
                                    (begin
                                      (set! r14 (rbp - 40))
                                      (begin
                                        (set! rbp (- rbp 56))
                                        (return-point L.rp.4
                                                      (begin
                                                        (set! (rbp - 0) (rbp - -16))
                                                        (set! r9 (rbp - -16))
                                                        (set! r8 r15)
                                                        (set! rcx (rbp - -32))
                                                        (set! rdx (rbp - -8))
                                                        (set! rsi (rbp - -24))
                                                        (set! rdi (rbp - -32))
                                                        (set! r15 L.rp.4)
                                                        (jump L.proc.0.1)))
                                        (set! rbp (+ rbp 56)))
                                      (set! r15 rax)
                                      (begin
                                        (set! rbp (- rbp 56))
                                        (return-point L.rp.5
                                                      (begin
                                                        (set! r9 (rbp - -56))
                                                        (set! r8 -9223372036854775808)
                                                        (set! rcx (rbp - -24))
                                                        (set! rdx 1)
                                                        (set! rsi (rbp - -16))
                                                        (set! rdi (rbp - -8))
                                                        (set! r15 L.rp.5)
                                                        (jump L.fn.1.2)))
                                        (set! rbp (+ rbp 56)))
                                      (set! r15 rax)
                                      (set! r15 (rbp - 24))
                                      (set! rax (rbp - 16))
                                      (jump (rbp - 8)))
                                    (begin
                                      (set! rax -774243080)
                                      (jump (rbp - 8))))))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (set! rdi rdi)
                                (set! r14 rsi)
                                (set! rsi rdx)
                                (set! rbx rcx)
                                (set! r13 r8)
                                (set! r8 r9)
                                (if (if (if (< r13 rdi)
                                            (>= rdi rbx)
                                            (!= r14 r14))
                                        (if (>= r8 rbx)
                                            (< rdi rdi)
                                            (>= rsi r13))
                                        (not (> rbx r8)))
                                    (begin
                                      (set! r9 -1548357748)
                                      (set! r9 (- r9 r13))
                                      (set! r13 r9)
                                      (set! r9 r13)
                                      (set! r8 rsi)
                                      (set! rcx r14)
                                      (set! rdx rsi)
                                      (set! rsi 0)
                                      (set! rdi r13)
                                      (set! r15 r15)
                                      (jump L.fn.1.2))
                                    (begin
                                      (set! r9 rdi)
                                      (set! r8 r8)
                                      (set! rcx r8)
                                      (set! rdx r14)
                                      (set! rsi r13)
                                      (set! rdi rbx)
                                      (set! r15 r15)
                                      (jump L.fn.2.3)))))
                      (define L.fn.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r14 rsi)
                          (set! r14 rdx)
                          (set! r13 rcx)
                          (set! r14 r8)
                          (set! r9 r9)
                          (set! r9 0)
                          (set! r8 1)
                          (set! rcx r14)
                          (set! rdx r13)
                          (set! rsi -9223372036854775808)
                          (set! rdi r14)
                          (set! r15 r15)
                          (jump L.fn.2.3)))
                      (begin
                        (set! r15 r15)
                        (if (begin
                              (set! r14 -534391580)
                              (true))
                            (begin
                              (set! rax 0)
                              (jump r15))
                            (begin
                              (set! rax 0)
                              (jump r15))))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 -1762920629)
                              (set! r14 1)
                              (set! r14 9223372036854775807)
                              (set! rax 0)
                              (jump r15))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! rdi rdx)
                                (set! rdi rcx)
                                (set! r8 r8)
                                (set! r9 r9)
                                (set! r9 r13)
                                (set! r8 r13)
                                (set! rcx rdi)
                                (set! rdx r14)
                                (set! rsi 15882253)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.proc.0.1)))
                            (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 1038395452)
                                    (true))
                                  (begin
                                    (set! rax -9223372036854775808)
                                    (jump r15))
                                  (begin
                                    (set! rax 717010255)
                                    (jump r15))))
                      ))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (if (not (begin
                                         (set! r14 0)
                                         (false)))
                                  (if (begin
                                        (set! r14 -9223372036854775808)
                                        (false))
                                      (begin
                                        (set! rax 0)
                                        (jump r15))
                                      (begin
                                        (set! rax 9223372036854775807)
                                        (jump r15)))
                                  (if (begin
                                        (set! r14 -9223372036854775808)
                                        (true))
                                      (begin
                                        (set! rax 1)
                                        (jump r15))
                                      (begin
                                        (set! rax 9223372036854775807)
                                        (jump r15)))))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 0)
                                    (true))
                                  (begin
                                    (set! rax 1620518798)
                                    (jump r15))
                                  (if (begin
                                        (set! r14 0)
                                        (true))
                                      (begin
                                        (set! rax 0)
                                        (jump r15))
                                      (begin
                                        (set! rax -9223372036854775808)
                                        (jump r15)))))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! rdx 9223372036854775807)
                                (set! rsi r14)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.tmp.1.2)))
                            (define L.tmp.1.2
                              (begin
                                (set! r15 r15)
                                (set! r13 rdi)
                                (set! r14 rsi)
                                (set! r9 rdx)
                                (begin
                                  (set! rdx r13)
                                  (set! rsi 9223372036854775807)
                                  (set! rdi r14)
                                  (set! r15 r15)
                                  (jump L.tmp.1.2))))
                      (define L.tmp.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r13 rsi)
                          (set! rdi rdx)
                          (set! rdi rcx)
                          (set! r8 r8)
                          (set! r9 r9)
                          (set! r9 r13)
                          (set! r8 r8)
                          (set! rcx r14)
                          (set! rdx r8)
                          (set! rsi 1666412948)
                          (set! rdi 273235985)
                          (set! r15 r15)
                          (jump L.tmp.2.3)))
                      (begin
                        (set! r15 r15)
                        (if (begin
                              (set! r14 -9223372036854775808)
                              (false))
                            (begin
                              (set! rax 9223372036854775807)
                              (jump r15))
                            (begin
                              (set! rax 1)
                              (jump r15))))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r9 rdx)
                                (set! rdi rcx)
                                (set! r9 r8)
                                (set! r8 r14)
                                (set! rcx rdi)
                                (set! rdx r13)
                                (set! rsi r14)
                                (set! rdi r9)
                                (set! r15 r15)
                                (jump L.fn.0.1)))
                            (begin
                              (set! r15 r15)
                              (set! rax -167685894)
                              (jump r15))
                      ))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (set! r9 r13)
                                (set! r8 r13)
                                (set! rcx r14)
                                (set! rdx r13)
                                (set! rsi r14)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.fn.2.3)))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! rdi rsi)
                                (set! r13 rdx)
                                (set! r14 rcx)
                                (set! r9 r8)
                                (set! r9 r9)
                                (set! r8 r13)
                                (set! r8 (- r8 rdi))
                                (set! r8 r8)
                                (set! rdi r9)
                                (set! r8 r8)
                                (set! r13 r13)
                                (set! r14 r14)
                                (set! r8 r9)
                                (set! rcx r14)
                                (set! rdx r9)
                                (set! rsi -9223372036854775808)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.fn.1.2)))
                      (define L.fn.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r13 rsi)
                          (set! r13 rdx)
                          (set! r13 rcx)
                          (set! r8 r8)
                          (set! r9 r9)
                          (set! rsi r13)
                          (set! rdi r14)
                          (set! r15 r15)
                          (jump L.func.0.1)))
                      (begin
                        (set! r15 r15)
                        (set! r14 1962527269)
                        (set! r14 (+ r14 9223372036854775807))
                        (set! rax r14)
                        (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (if (not (> r14 r14))
                                    (if (= r14 r14)
                                        (begin
                                          (set! rax r14)
                                          (jump r15))
                                        (begin
                                          (set! rax r14)
                                          (jump r15)))
                                    (begin
                                      (set! rdi 9223372036854775807)
                                      (set! r15 r15)
                                      (jump L.func.0.1)))))
                            (begin
                              (set! r15 r15)
                              (set! rdi 733499244)
                              (set! r15 r15)
                              (jump L.func.0.1))
                      ))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r13 rcx)
                                (set! r8 r14)
                                (set! rcx 1)
                                (set! rdx 0)
                                (set! rsi -9223372036854775808)
                                (set! rdi 835392363)
                                (set! r15 r15)
                                (jump L.fn.1.2)))
                            (define L.fn.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! r13 rcx)
                                (set! r13 r8)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.x.2.3)))
                      (define L.x.2.3
                        (begin
                          (set! (rbp - 0) r15)
                          (set! (rbp - 8) rdi)
                          (begin
                            (set! rbp (- rbp 16))
                            (return-point L.rp.4
                                          (begin
                                            (set! rcx (rbp - -8))
                                            (set! rdx (rbp - -8))
                                            (set! rsi (rbp - -8))
                                            (set! rdi (rbp - -8))
                                            (set! r15 L.rp.4)
                                            (jump L.proc.0.1)))
                            (set! rbp (+ rbp 16)))
                          (set! r15 rax)
                          (set! r15 r15)
                          (set! r15 (- r15 r15))
                          (set! r15 r15)
                          (if (<= r15 (rbp - 8))
                              (set! r14 r15)
                              (set! r14 (rbp - 8)))
                          (set! r15 r15)
                          (set! r14 (rbp - 8))
                          (set! r14 r15)
                          (set! r15 r15)
                          (set! r15 (rbp - 8))
                          (set! rdi r15)
                          (set! r15 (rbp - 0))
                          (jump L.x.2.3)))
                      (begin
                        (set! r15 r15)
                        (set! r14 1830309714)
                        (set! r13 -9223372036854775808)
                        (set! r13 -9223372036854775808)
                        (set! rax r14)
                        (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r13 r8)
                                (set! rax r14)
                                (jump r15)))
                            (define L.func.1.2
                              (begin
                                (set! (rbp - 0) r15)
                                (set! r15 -620373304)
                                (set! r15 (- r15 -68719063))
                                (set! r15 r15)
                                (set! (rbp - 8) 0)
                                (begin
                                  (set! rbp (- rbp 16))
                                  (return-point L.rp.4
                                                (begin
                                                  (set! r15 L.rp.4)
                                                  (jump L.func.1.2)))
                                  (set! rbp (+ rbp 16)))
                                (set! r15 rax)
                                (set! rax (rbp - 8))
                                (jump (rbp - 0))))
                      (define L.x.2.3
                        (begin
                          (set! r15 r15)
                          (set! r14 rdi)
                          (set! r15 r15)
                          (jump L.func.1.2)))
                      (begin
                        (set! r15 r15)
                        (set! rax -575594324)
                        (jump r15))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r14 rcx)
                                (set! r13 r8)
                                (set! r13 r9)
                                (set! rsi 1)
                                (set! rdi r14)
                                (set! r15 r15)
                                (jump L.x.1.2)))
                            (define L.x.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r13 rsi)
                                (if (<= r13 -9223372036854775808)
                                    (begin
                                      (set! r9 r14)
                                      (set! r8 r13)
                                      (set! rcx r13)
                                      (set! rdx r13)
                                      (set! rsi r14)
                                      (set! rdi r14)
                                      (set! r15 r15)
                                      (jump L.x.0.1))
                                    (begin
                                      (set! rax r13)
                                      (jump r15)))))
                      (begin
                        (set! r15 r15)
                        (if (not (begin
                                   (set! r14 0)
                                   (false)))
                            (begin
                              (set! r14 996590913)
                              (set! r13 299367411)
                              (set! r13 -9223372036854775808)
                              (set! rax r14)
                              (jump r15))
                            (if (begin
                                  (set! r14 894536270)
                                  (false))
                                (begin
                                  (set! rax 1)
                                  (jump r15))
                                (begin
                                  (set! rax 1)
                                  (jump r15)))))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 r15)
                                (set! r13 rdi)
                                (set! rdi rsi)
                                (set! r14 rdx)
                                (set! rbx rcx)
                                (set! r9 r8)
                                (if (<= rdi 9223372036854775807)
                                    (begin
                                      (set! (rbp - 0) rbx)
                                      (set! r9 -9223372036854775808)
                                      (set! r8 1)
                                      (set! rcx r14)
                                      (set! rdx r13)
                                      (set! rsi r14)
                                      (set! rdi rbx)
                                      (set! r15 r15)
                                      (jump L.tmp.1.2))
                                    (begin
                                      (set! r9 r9)
                                      (set! r13 r13)
                                      (set! r14 r14)
                                      (set! rax r14)
                                      (jump r15)))))
                            (define L.tmp.1.2
                              (begin
                                (set! (rbp - 8) r15)
                                (set! r15 rdi)
                                (set! (rbp - 24) rsi)
                                (set! r15 rdx)
                                (set! r14 rcx)
                                (set! (rbp - 40) r8)
                                (set! (rbp - 16) r9)
                                (set! (rbp - 32) (rbp - 0))
                                (if (not (begin
                                           (set! r13 1242010444)
                                           (> r13 r15)))
                                    (begin
                                      (begin
                                        (set! rbp (- rbp 56))
                                        (return-point L.rp.3
                                                      (begin
                                                        (set! r8 (rbp - -40))
                                                        (set! rcx 1)
                                                        (set! rdx r14)
                                                        (set! rsi (rbp - -40))
                                                        (set! rdi (rbp - -16))
                                                        (set! r15 L.rp.3)
                                                        (jump L.tmp.0.1)))
                                        (set! rbp (+ rbp 56)))
                                      (set! (rbp - 48) rax))
                                    (begin
                                      (begin
                                        (set! rbp (- rbp 56))
                                        (return-point L.rp.4
                                                      (begin
                                                        (set! r8 r14)
                                                        (set! rcx r14)
                                                        (set! rdx (rbp - -32))
                                                        (set! rsi r15)
                                                        (set! rdi r15)
                                                        (set! r15 L.rp.4)
                                                        (jump L.tmp.0.1)))
                                        (set! rbp (+ rbp 56)))
                                      (set! (rbp - 48) rax)))
                                (set! r15 (rbp - 32))
                                (set! r15 (* r15 (rbp - 24)))
                                (set! r15 r15)
                                (begin
                                  (set! rbp (- rbp 56))
                                  (return-point L.rp.5
                                                (begin
                                                  (set! r8 (rbp - -16))
                                                  (set! rcx (rbp - -16))
                                                  (set! rdx 0)
                                                  (set! rsi (rbp - -32))
                                                  (set! rdi (rbp - -32))
                                                  (set! r15 L.rp.5)
                                                  (jump L.tmp.0.1)))
                                  (set! rbp (+ rbp 56)))
                                (set! r15 rax)
                                (set! (rbp - 0) (rbp - 16))
                                (set! r9 (rbp - 48))
                                (set! r8 (rbp - 32))
                                (set! rcx r15)
                                (set! rdx 1)
                                (set! rsi (rbp - 24))
                                (set! rdi (rbp - 16))
                                (set! r15 (rbp - 8))
                                (jump L.tmp.1.2)))
                      (begin
                        (set! r15 r15)
                        (if (not (begin
                                   (set! r14 1973720366)
                                   (false)))
                            (begin
                              (set! rax 9223372036854775807)
                              (jump r15))
                            (begin
                              (set! (rbp - 0) 379193781)
                              (set! r9 726597669)
                              (set! r8 -264137160)
                              (set! rcx -1022801227)
                              (set! rdx 501537014)
                              (set! rsi 9223372036854775807)
                              (set! rdi 9223372036854775807)
                              (set! r15 r15)
                              (jump L.tmp.1.2))))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r9 1521957632)
                              (set! r13 -9223372036854775808)
                              (set! r14 -9223372036854775808)
                              (begin
                                (set! rax 0)
                                (jump r15)))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 -9223372036854775808)
                              (set! r13 0)
                              (set! r14 r14)
                              (set! r14 r14)
                              (set! r13 r14)
                              (set! r14 r14)
                              (set! r14 r14)
                              (set! r13 r13)
                              (set! rax r14)
                              (jump r15))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 1)
                              (begin
                                (set! r14 r14)
                                (set! r14 r14)
                                (set! r14 r14)
                                (set! r14 r14))
                              (set! r13 r14)
                              (set! r13 r14)
                              (set! r13 (+ r13 r14))
                              (set! r13 r13)
                              (set! r13 r14)
                              (set! r13 1648274049)
                              (set! rax r14)
                              (jump r15))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! rsi r14)
                                (set! rdi 1)
                                (set! r15 r15)
                                (jump L.func.0.1)))
                            (begin
                              (set! r15 r15)
                              (set! rax 0)
                              (jump r15))
                      ))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 -9223372036854775808)
                                    (false))
                                  (begin
                                    (set! rax -9223372036854775808)
                                    (jump r15))
                                  (begin
                                    (set! rax 9223372036854775807)
                                    (jump r15))))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! r14 rsi)
                                (set! r13 rdx)
                                (set! rdi rcx)
                                (set! r13 r8)
                                (set! r9 r14)
                                (set! r8 rdi)
                                (set! rcx r13)
                                (set! rdx 1064830001)
                                (set! rsi r14)
                                (set! rdi r13)
                                (set! r15 r15)
                                (jump L.func.1.2)))
                            (define L.func.1.2
                              (begin
                                (set! r15 r15)
                                (set! r14 rdi)
                                (set! rsi rsi)
                                (set! rdi rdx)
                                (set! rdx rcx)
                                (set! r8 r8)
                                (set! r13 r9)
                                (if (if (if (< r8 r8)
                                            (= r14 r14)
                                            (!= rsi r8))
                                        (= r13 0)
                                        (if (begin
                                              (set! r9 0)
                                              (> r9 r13))
                                            (begin
                                              (set! r9 1)
                                              (<= r9 rdx))
                                            (begin
                                              (set! r9 529266316)
                                              (>= r9 r8))))
                                    (if (begin
                                          (set! r9 rdi)
                                          (<= rdx r9))
                                        (begin
                                          (set! r14 r13)
                                          (set! rax r13)
                                          (jump r15))
                                        (begin
                                          (set! r9 r13)
                                          (set! r8 rdi)
                                          (set! rcx rsi)
                                          (set! rdx rsi)
                                          (set! rsi r14)
                                          (set! rdi rdi)
                                          (set! r15 r15)
                                          (jump L.func.1.2)))
                                    (begin
                                      (set! r14 rdi)
                                      (set! r14 r14)
                                      (set! r9 rdi)
                                      (set! r8 r14)
                                      (set! rcx rdi)
                                      (set! rdx r13)
                                      (set! rsi r13)
                                      (set! rdi r14)
                                      (set! r15 r15)
                                      (jump L.func.1.2)))))
                      (begin
                        (set! r15 r15)
                        (set! r9 0)
                        (set! r8 0)
                        (set! rcx 1)
                        (set! rdx 1)
                        (set! rsi -1337458253)
                        (set! rdi 9223372036854775807)
                        (set! r15 r15)
                        (jump L.func.1.2))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (if (if (begin
                                        (set! r14 9223372036854775807)
                                        (true))
                                      (true)
                                      (not (begin
                                             (set! r14 9223372036854775807)
                                             (false))))
                                  (begin
                                    (set! r14 -9223372036854775808)
                                    (set! r14 -9223372036854775808)
                                    (set! r13 9223372036854775807)
                                    (set! r13 (* r13 -9223372036854775808))
                                    (set! r13 r13)
                                    (set! rax r14)
                                    (jump r15))
                                  (begin
                                    (set! r14 1865158198)
                                    (set! r14 (+ r14 1))
                                    (set! r14 r14)
                                    (begin
                                      (set! rax r14)
                                      (jump r15)))))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (if (begin
                                    (set! r14 1069510162)
                                    (true))
                                  (begin
                                    (set! rax 1)
                                    (jump r15))
                                  (begin
                                    (set! rax 323863587)
                                    (jump r15))))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 379335310)
                              (set! r14 (* r14 0))
                              (set! rax r14)
                              (jump r15))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! rax 0)
                              (jump r15))))
  (check-by-interp '(module (begin
                              (set! r15 r15)
                              (set! r14 -9223372036854775808)
                              (set! r14 (- r14 0))
                              (set! r13 r14)
                              (set! r14 -9223372036854775808)
                              (set! r9 1969620648)
                              (set! r13 r13)
                              (set! r14 r14)
                              (set! rax r13)
                              (jump r15))))

  ;;

  ;; !!! Added by Trevor on March 2nd 2026

  (check-by-interp '(module (define L.L.func.0.1.4 (halt 0))
                            (define L.L.tmp.1.2.5
                              (begin
                                (set! r15 rdi)
                                (jump L.L.func.0.1.4)))
                      (define L.L.func.2.3.6
                        (begin
                          (begin
                            (set! r15 1)
                            (set! r15 r15))
                          (if (begin
                                (set! r14 1)
                                (true))
                              (set! r15 156890122)
                              (set! r15 r15))
                          (halt 0)))
                      (begin
                        (set! rdi -1860620182)
                        (jump L.L.tmp.1.2.5))))
  (check-by-interp '(module (define L.L.tmp.0.1.4
                              (if (begin
                                    (set! r15 9223372036854775807)
                                    (true))
                                  (jump L.L.x.2.3.6)
                                  (begin
                                    (set! r15 1)
                                    (set! r15 (* r15 0))
                                    (set! r15 r15)
                                    (halt 0))))
                            (define L.L.func.1.2.5
                              (begin
                                (set! r14 -9223372036854775808)
                                (if (not (begin
                                           (set! r15 9223372036854775807)
                                           (true)))
                                    (halt 1309557052)
                                    (halt -9223372036854775808))))
                      (define L.L.x.2.3.6
                        (if (not (begin
                                   (set! r15 0)
                                   (false)))
                            (if (begin
                                  (set! r15 0)
                                  (false))
                                (if (begin
                                      (set! r15 9223372036854775807)
                                      (false))
                                    (halt 9223372036854775807)
                                    (halt -260353756))
                                (begin
                                  (set! r15 0)
                                  (halt 0)))
                            (begin
                              (if (begin
                                    (set! r15 -302047143)
                                    (true))
                                  (set! r15 9223372036854775807)
                                  (set! r15 102036653))
                              (if (begin
                                    (set! r14 0)
                                    (= r14 r15))
                                  (halt r15)
                                  (halt -362331747)))))
                      (begin
                        (set! r15 -9223372036854775808)
                        (set! r15 (* r15 -9223372036854775808))
                        (set! r15 r15)
                        (set! r15 r15)
                        (set! r15 (+ r15 0))
                        (set! r15 r15)
                        (halt 0))))
  (check-by-interp '(module (define L.L.proc.0.1.4
                              (begin
                                (set! r15 rdi)
                                (jump L.L.func.1.2.5)))
                            (define L.L.func.1.2.5
                              (begin
                                (set! r15 1)
                                (set! r15 (* r15 0))
                                (set! r15 r15)
                                (halt 0)))
                      (define L.L.fn.2.3.6
                        (begin
                          (set! r15 rdi)
                          (begin
                            (if (begin
                                  (set! r15 -2033705372)
                                  (true))
                                (set! r15 -1853172774)
                                (set! r15 1133506028))
                            (set! r15 1)
                            (halt 1236904416))))
                      (begin
                        (set! rdi 1)
                        (jump L.L.proc.0.1.4))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (begin
                                  (set! r15 1)
                                  (set! r15 1))
                                (if (if (begin
                                          (set! r14 9223372036854775807)
                                          (true))
                                        (begin
                                          (set! r14 -248968641)
                                          (false))
                                        (true))
                                    (begin
                                      (set! r15 r15)
                                      (halt 1622965009))
                                    (begin
                                      (set! r15 r15)
                                      (halt 1)))))
                            (jump L.fn.0.1)
                      ))
  (check-by-interp '(module (begin
                              (set! r15 -9223372036854775808)
                              (set! r15 (+ r15 -1465538260))
                              (set! r15 r15)
                              (halt 9223372035389237548))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 1)
                                (set! r15 (+ r15 9223372036854775807))
                                (set! r15 r15)
                                (set! r15 r15)
                                (set! r14 r15)
                                (halt -9223372036854775808)))
                            (define L.func.1.2
                              (begin
                                (if (begin
                                      (set! r15 1)
                                      (begin
                                        (set! r14 1)
                                        (false)))
                                    (begin
                                      (set! r15 406779451)
                                      (set! r15 1200977699))
                                    (begin
                                      (set! r15 0)
                                      (set! r15 r15)))
                                (set! r15 r15)
                                (set! r15 (* r15 r15))
                                (set! r15 r15)
                                (halt r15)))
                      (begin
                        (set! r15 1)
                        (set! r14 0)
                        (halt 1))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (jump L.tmp.1.2)))
                            (define L.tmp.1.2
                              (if (if (if (begin
                                            (set! r15 -765445006)
                                            (true))
                                          (begin
                                            (set! r15 0)
                                            (true))
                                          (begin
                                            (set! r15 9223372036854775807)
                                            (false)))
                                      (false)
                                      (true))
                                  (begin
                                    (set! r15 -9223372036854775808)
                                    (set! r15 r15)
                                    (halt -9223372036854775808))
                                  (begin
                                    (if (begin
                                          (set! r15 1)
                                          (true))
                                        (set! r15 -9223372036854775808)
                                        (set! r15 -9223372036854775808))
                                    (if (begin
                                          (set! r14 0)
                                          (false))
                                        (halt 0)
                                        (halt 9223372036854775807)))))
                      (define L.func.2.3
                        (begin
                          (set! r15 rdi)
                          (set! r15 rsi)
                          (jump L.tmp.1.2)))
                      (if (begin
                            (set! r15 0)
                            (true))
                          (halt -1271132888)
                          (halt 2101306416))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 rdi)
                                (begin
                                  (set! r14 -818241658)
                                  (set! r14 r14))
                                (set! r13 -1769976594)
                                (set! r13 (* r13 r14))
                                (set! r14 r13)
                                (if (!= r15 r15)
                                    (halt 1)
                                    (halt r15))))
                            (if (begin
                                  (set! r15 0)
                                  (true))
                                (halt 1764584349)
                                (halt -9223372036854775808))
                      ))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 rdi)
                                (jump L.x.1.2)))
                            (define L.x.1.2 (halt 1))
                      (begin
                        (set! r15 453798193)
                        (set! r14 r15)
                        (if (begin
                              (set! r15 9223372036854775807)
                              (true))
                            (halt 0)
                            (halt -1617493587)))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 rdi)
                                (if (begin
                                      (begin
                                        (set! r14 9223372036854775807)
                                        (set! r14 (* r14 r15))
                                        (set! r14 r14))
                                      (true))
                                    (if (< r15 -9223372036854775808)
                                        (halt r15)
                                        (halt r15))
                                    (jump L.proc.1.2))))
                            (define L.proc.1.2
                              (begin
                                (set! rdi 954069433)
                                (jump L.func.0.1)))
                      (jump L.proc.1.2)))
  (check-by-interp '(module (if (not (begin
                                       (set! r15 1)
                                       (false)))
                                (if (begin
                                      (set! r15 1)
                                      (false))
                                    (halt 9223372036854775807)
                                    (halt 1))
                                (halt 1))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r15 rdx)
                                (set! r15 rcx)
                                (set! r15 r8)
                                (halt -1458025903)))
                            (begin
                              (set! r8 0)
                              (set! rcx -9223372036854775808)
                              (set! rdx -808937821)
                              (set! rsi 1)
                              (set! rdi -9223372036854775808)
                              (jump L.func.0.1))
                      ))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r14 rdi)
                                (set! r15 rsi)
                                (set! r13 rdx)
                                (set! r13 rcx)
                                (set! r14 r14)
                                (if (if (begin
                                          (set! r13 -9223372036854775808)
                                          (<= r13 r15))
                                        (begin
                                          (set! r13 -9223372036854775808)
                                          (>= r13 r14))
                                        (>= r15 2025307007))
                                    (begin
                                      (set! r15 r14)
                                      (set! r15 (+ r15 9223372036854775807))
                                      (set! r15 r15)
                                      (halt r15))
                                    (if (<= r15 -9223372036854775808)
                                        (halt 9223372036854775807)
                                        (halt 0)))))
                            (begin
                              (set! r15 0)
                              (halt 0))
                      ))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r14 rsi)
                                (if (begin
                                      (set! r13 0)
                                      (= r13 r14))
                                    (begin
                                      (set! r15 -9223372036854775808)
                                      (set! r15 (+ r15 -9223372036854775808))
                                      (set! r15 r15)
                                      (halt 0))
                                    (if (if (< r15 r15)
                                            (<= r14 r14)
                                            (= r14 r15))
                                        (begin
                                          (set! r15 r14)
                                          (set! r15 (+ r15 r14))
                                          (set! r15 r15)
                                          (halt r15))
                                        (if (begin
                                              (set! r13 1)
                                              (= r13 r14))
                                            (halt r15)
                                            (halt r14))))))
                            (define L.x.1.2
                              (begin
                                (set! r15 rdi)
                                (set! r14 1757280127)
                                (set! r14 r14)
                                (set! r14 1)
                                (set! r14 -1128483887)
                                (if (begin
                                      (set! r15 r15)
                                      (> r15 r15))
                                    (halt -1128483887)
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (+ r14 r15))
                                      (set! r15 r14)
                                      (halt r15)))))
                      (define L.fn.2.3
                        (if (begin
                              (begin
                                (set! r15 -9223372036854775808)
                                (set! r15 (+ r15 -1421853645))
                                (set! r15 r15))
                              (not (begin
                                     (set! r15 0)
                                     (true))))
                            (begin
                              (set! r15 -167927521)
                              (set! r15 (+ r15 1))
                              (set! r15 r15)
                              (halt -167927520))
                            (begin
                              (set! r15 1041085683)
                              (set! r15 (* r15 9223372036854775807))
                              (set! r15 r15)
                              (set! r15 r15)
                              (halt 770292232))))
                      (begin
                        (set! rdi 1840464414)
                        (jump L.x.1.2))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r14 rdx)
                                (set! rdx r15)
                                (set! rsi r14)
                                (set! rdi 9223372036854775807)
                                (jump L.proc.0.1)))
                            (define L.func.1.2
                              (begin
                                (set! r15 rdi)
                                (set! r14 rsi)
                                (set! r14 rdx)
                                (set! r13 rcx)
                                (set! r13 r8)
                                (set! r13 r9)
                                (set! r14 r14)
                                (set! r15 r15)
                                (set! r15 -9223372036854775808)
                                (set! rdx r15)
                                (set! rsi -780648786)
                                (set! rdi r15)
                                (jump L.proc.0.1)))
                      (begin
                        (set! r15 -579691794)
                        (halt 953357957))))
  (check-by-interp '(module (begin
                              (set! r15 9223372036854775807)
                              (set! r15 -546026276)
                              (halt 9223372036854775807))))
  (check-by-interp '(module (define L.func.0.1
                              (begin
                                (set! r14 rdi)
                                (set! r15 rsi)
                                (if (not (begin
                                           (set! r14 r14)
                                           (= r14 0)))
                                    (begin
                                      (set! r15 r14)
                                      (set! r15 (+ r15 0))
                                      (set! r15 r15)
                                      (set! r15 0)
                                      (set! r15 (* r15 9223372036854775807))
                                      (set! r15 r15)
                                      (halt 0))
                                    (begin
                                      (set! r14 0)
                                      (set! r14 (* r14 r15))
                                      (set! r14 r14)
                                      (halt r15)))))
                            (if (begin
                                  (set! r15 9223372036854775807)
                                  (false))
                                (halt 1)
                                (halt -9223372036854775808))
                      ))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r14 1)
                                (set! r14 (* r14 9223372036854775807))
                                (set! r14 r14)
                                (set! r13 -9223372036854775808)
                                (set! r13 (+ r13 r14))
                                (set! r14 r13)
                                (set! r13 9223372036854775807)
                                (if (begin
                                      (set! r13 1)
                                      (true))
                                    (halt 9223372036854775807)
                                    (halt r15))))
                            (define L.x.1.2
                              (begin
                                (set! r15 rdi)
                                (set! r14 -1410706204)
                                (set! r14 (+ r14 r15))
                                (set! r15 r14)
                                (set! r15 1)
                                (set! r15 -9223372036854775808)
                                (set! r15 -152436426)
                                (set! r15 (* r15 0))
                                (set! r15 r15)
                                (halt 0)))
                      (define L.proc.2.3
                        (begin
                          (set! r15 rdi)
                          (set! r14 rsi)
                          (set! r14 rdx)
                          (set! r14 rcx)
                          (set! r15 r15)
                          (set! r15 956544411)
                          (set! r15 (+ r15 1))
                          (set! r15 r15)
                          (halt 956544412)))
                      (begin
                        (set! r15 979460199)
                        (set! r15 (+ r15 -1697959716))
                        (set! r15 r15)
                        (halt -718499517))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r15 rdx)
                                (set! r13 rcx)
                                (set! r14 r8)
                                (set! r9 r9)
                                (if (begin
                                      (set! r8 -669410514)
                                      (< r14 r14))
                                    (begin
                                      (set! r9 r9)
                                      (set! r9 (+ r9 r13))
                                      (set! r9 r9))
                                    (set! r9 r15))
                                (set! r13 r13)
                                (set! r13 1)
                                (if (<= r15 1)
                                    (halt 9223372036854775807)
                                    (halt r14))))
                            (begin
                              (set! r9 9223372036854775807)
                              (set! r8 -1891086346)
                              (set! rcx -1371550930)
                              (set! rdx 0)
                              (set! rsi 9223372036854775807)
                              (set! rdi 0)
                              (jump L.proc.0.1))
                      ))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r14 rdx)
                                (set! r13 rcx)
                                (set! r8 r8)
                                (set! r9 r9)
                                (set! rdi fv0)
                                (if (not (if (begin
                                               (set! rdi 388494724)
                                               (>= rdi r15))
                                             (> r13 -9223372036854775808)
                                             (< r14 r13)))
                                    (if (<= r8 r9)
                                        (halt 0)
                                        (begin
                                          (set! r15 r13)
                                          (halt 1887946265)))
                                    (halt r14))))
                            (define L.tmp.1.2
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r15 rdx)
                                (set! r14 rcx)
                                (set! r13 r8)
                                (set! r9 r9)
                                (begin
                                  (set! r15 r14)
                                  (set! r15 (* r15 9223372036854775807))
                                  (set! r15 r15)
                                  (halt r15))))
                      (define L.tmp.2.3
                        (begin
                          (set! r15 rdi)
                          (set! r15 rsi)
                          (set! r14 rdx)
                          (set! r13 rcx)
                          (set! r8 r8)
                          (set! r13 r9)
                          (if (begin
                                (set! r13 258314756)
                                (!= r8 0))
                              (set! r13 r8)
                              (begin
                                (set! r13 -1809848824)
                                (set! r13 9223372036854775807)))
                          (if (begin
                                (set! r9 1525021420)
                                (false))
                              (begin
                                (set! r9 1067478227)
                                (set! r8 -768559462)
                                (set! rcx r14)
                                (set! rdx -1256996529)
                                (set! rsi 1)
                                (set! rdi r13)
                                (jump L.tmp.1.2))
                              (if (begin
                                    (set! r14 389818959)
                                    (false))
                                  (halt r8)
                                  (halt r15)))))
                      (begin
                        (set! r15 1)
                        (halt 1))))
  (check-by-interp '(module (define L.tmp.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r15 rdx)
                                (set! r15 rcx)
                                (set! r14 r8)
                                (set! r14 r9)
                                (set! r13 fv0)
                                (set! r15 r15)
                                (set! r15 (* r15 r14))
                                (set! r15 r15)
                                (halt r15)))
                            (define L.func.1.2
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r15 rdx)
                                (set! r15 rcx)
                                (set! r15 r8)
                                (set! r15 1)
                                (halt 9223372036854775807)))
                      (define L.fn.2.3
                        (begin
                          (set! r13 rdi)
                          (set! r15 rsi)
                          (if (>= r13 1)
                              (if (= r13 r13)
                                  (set! r14 r15)
                                  (set! r14 214741259))
                              (begin
                                (set! r14 1683358713)
                                (set! r14 (+ r14 r15))
                                (set! r14 r14)))
                          (set! fv0 -2043460455)
                          (set! r9 r13)
                          (set! r8 9223372036854775807)
                          (set! rcx r13)
                          (set! rdx 0)
                          (set! rsi r15)
                          (set! rdi r14)
                          (jump L.tmp.0.1)))
                      (begin
                        (set! fv0 -9223372036854775808)
                        (set! r9 1)
                        (set! r8 -9223372036854775808)
                        (set! rcx 9223372036854775807)
                        (set! rdx -9223372036854775808)
                        (set! rsi -9223372036854775808)
                        (set! rdi -9223372036854775808)
                        (jump L.tmp.0.1))))
  (check-by-interp '(module (begin
                              (set! r15 1)
                              (set! r15 (+ r15 -9223372036854775808))
                              (set! r15 r15)
                              (halt -9223372036854775807))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r15 rdx)
                                (set! r15 rcx)
                                (set! r15 r8)
                                (set! r15 r9)
                                (set! r15 fv0)
                                (set! rdi 1)
                                (jump L.x.4.5)))
                            (define L.func.1.2
                              (begin
                                (set! r14 9223372036854775807)
                                (set! r14 r14)
                                (if (begin
                                      (set! r15 -577997854)
                                      (false))
                                    (halt -9223372036854775808)
                                    (halt 9223372036854775807))))
                      (define L.fn.2.3
                        (begin
                          (set! r15 1)
                          (set! r15 (+ r15 1))
                          (set! r15 r15)
                          (begin
                            (set! r15 r15)
                            (halt 1969054361))))
                      (define L.x.3.4
                        (begin
                          (set! r15 rdi)
                          (set! r14 rsi)
                          (set! r14 rdx)
                          (set! r14 rcx)
                          (set! r14 r8)
                          (set! r14 r9)
                          (set! r14 fv0)
                          (set! fv0 -9223372036854775808)
                          (set! r9 r15)
                          (set! r8 9223372036854775807)
                          (set! rcx 25911444)
                          (set! rdx 9223372036854775807)
                          (set! rsi -9223372036854775808)
                          (set! rdi 0)
                          (jump L.func.6.7)))
                      (define L.x.4.5
                        (begin
                          (set! r15 rdi)
                          (set! fv0 r15)
                          (set! r9 r15)
                          (set! r8 r15)
                          (set! rcx 1)
                          (set! rdx r15)
                          (set! rsi r15)
                          (set! rdi 0)
                          (jump L.x.3.4)))
                      (define L.x.5.6
                        (begin
                          (set! r15 rdi)
                          (set! r14 rsi)
                          (set! r13 rdx)
                          (set! rdi rcx)
                          (set! r8 r8)
                          (set! r9 r9)
                          (set! r9 rdi)
                          (set! r14 r14)
                          (set! r9 r9)
                          (if (begin
                                (set! r8 rdi)
                                (> r14 r15))
                              (begin
                                (set! fv0 -1819248150)
                                (set! r9 r9)
                                (set! r8 r14)
                                (set! rcx r9)
                                (set! rdx r13)
                                (set! rsi 9223372036854775807)
                                (set! rdi -1863740769)
                                (jump L.x.0.1))
                              (halt 1))))
                      (define L.func.6.7
                        (begin
                          (set! r15 rdi)
                          (set! r14 rsi)
                          (set! r14 rdx)
                          (set! r14 rcx)
                          (set! r14 r8)
                          (set! r14 r9)
                          (set! r14 fv0)
                          (if (begin
                                (set! r15 r15)
                                (begin
                                  (set! r14 -1497437069)
                                  (true)))
                              (begin
                                (set! r15 r15)
                                (set! r15 (+ r15 r15))
                                (set! r15 r15)
                                (set! r15 0)
                                (halt 0))
                              (halt 1))))
                      (define L.fn.7.8
                        (if (not (begin
                                   (set! r15 0)
                                   (false)))
                            (begin
                              (set! r9 -1579752260)
                              (set! r8 0)
                              (set! rcx -1248542300)
                              (set! rdx 0)
                              (set! rsi 16140507)
                              (set! rdi -9223372036854775808)
                              (jump L.x.5.6))
                            (if (begin
                                  (set! r15 -9223372036854775808)
                                  (false))
                                (halt 1)
                                (halt 0))))
                      (if (begin
                            (if (begin
                                  (set! r15 -9223372036854775808)
                                  (true))
                                (begin
                                  (if (begin
                                        (set! r15 9223372036854775807)
                                        (true))
                                      (set! r15 -1444900091)
                                      (set! r15 -9223372036854775808))
                                  (set! r15 r15))
                                (begin
                                  (set! r15 9223372036854775807)
                                  (set! r15 r15)))
                            (begin
                              (set! r15 0)
                              (true)))
                          (halt 1)
                          (if (begin
                                (set! r15 1)
                                (false))
                              (jump L.fn.2.3)
                              (jump L.fn.2.3)))))
  ;; !!!

  (check-by-interp `(module (halt 1)))
  (check-by-interp `(module (define L.a.0 (halt 1)) (define L.b.0 (halt 2))
                      (jump L.a.0)))
  (check-by-interp `(module (begin
                              (halt 1))))

  (check-by-interp `(module (define L.a.0
                              (begin
                                (halt 1)))
                            (define L.b.0
                              (begin
                                (jump L.a.0)))
                      (jump L.b.0)))
  (check-by-interp `(module (begin
                              (begin
                                (halt 1)))))

  (check-by-interp `(module (define L.end.0
                              (begin
                                (halt rax)))
                            (define L.fact.0
                              (if (> rdi 0)
                                  (begin
                                    (set! rax (* rax rdi))
                                    (set! rdi (+ rdi -1))
                                    (jump L.fact.0))
                                  (jump L.end.0)))
                      (begin
                        (set! rax 1)
                        (set! rdi 5)
                        (jump L.fact.0))))

  (check-by-interp `(module (begin
                              (set! rax 1)
                              (set! rdi 5)
                              (halt rdi))))
  (check-by-interp `(module (begin
                              (set! rax 1)
                              (set! rdi 5)
                              (if (> rax rdi)
                                  (halt rdi)
                                  (halt rax)))))
  (check-by-interp `(module (begin
                              (set! rax 1)
                              (begin
                                (set! rsp 5)
                                (set! rdi 5))
                              (if (> rax rdi)
                                  (halt rdi)
                                  (halt rax)))))
  (check-by-interp `(module (begin
                              (set! rax 1)
                              (if (begin
                                    (set! rdi 5)
                                    (> rax rdi))
                                  (halt rdi)
                                  (halt rax)))))
  (check-by-interp `(module (begin
                              (set! rax 1)
                              (set! rdi 5)
                              (set! rsp 9)
                              (if (if (< rsp rdi)
                                      (> rax rdi)
                                      (> rax rsp))
                                  (halt rdi)
                                  (halt rax))))))
