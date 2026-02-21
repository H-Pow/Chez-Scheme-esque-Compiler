#lang racket

(require cpsc411/compiler-lib)

(provide expose-basic-blocks)

; nested-asm-lang-v4
; p	 	::=	 	(module tail)
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
;;------------------------------
; Block-pred-lang v4
;   p	 	::=	 	(module b ... b)
;   b	 	::=	 	(define label tail)
;   pred	 	::=	 	(relop loc opand)
;  	 	|	 	(true)
;  	 	|	 	(false)
;  	 	|	 	(not pred)
;   tail	 	::=	 	(halt opand)
;  	 	|	 	(jump trg)
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

;;nested-asm-lang-v4 -> block-pred-lang-v4
;; Compile the Nested-asm-lang v4 to Block-pred-lang v4,
;;   eliminating all nested expressions by generating fresh basic blocks and jumps.
(define (expose-basic-blocks p)
  (define blocks '())
  (define (create-block! label tail)
    (append blocks `((define ,label ,tail)))
    label)
  ;; nested-pred label label -> label
  ;; effect: creates a block with pred
  (define (expose-pred! pred truelab falselab)
    (define label (fresh-label))
    (match pred
      [`(,relop ,loc ,triv)
       (create-block! label `(if ,pred
                                 (jump ,truelab)
                                 (jump ,falselab)))]
      [`(true) (create-block! label `(if ,pred
                                         (jump ,truelab)
                                         (jump ,falselab)))]
      [`(false) (create-block! label `(if ,pred
                                          (jump ,truelab)
                                          (jump ,falselab)))]
      [`(not ,pred) (expose-pred! pred falselab truelab)]
      [`(begin ,fx* ... ,pred)
       (create-block! label
                      `(jump ,(foldr
                               expose-effect!
                               (expose-pred! pred)
                               fx* )))]
      [`(if ,pred ,pred1 ,pred2)
       (expose-pred! pred
                     (expose-pred! pred1 truelab falselab)
                     (expose-pred! pred2 truelab falselab))]))
  ;; nested-effect label -> label
  ;; effect: creates a block with the effect
  (define (expose-effect! fx next)
    (define label (fresh-label))
    (match fx
      [`(set! ,loc ,triv) (create-block!
                           label
                           `(begin ,fx
                                   (jump ,next)))]
      [`(set! ,loc (,binop ,loc ,triv))
       (create-block! label
                      `(begin ,fx
                              (jump ,next)))]
      [`(if ,pred ,fx1 ,fx2)
       (expose-pred! pred (expose-effect! fx1 next)
                     (expose-effect! fx2 next))]))
  ;; nested-tail -> label
  ;; effect: creates a block
  (define (expose-tail! tail)
    (define label (fresh-label))
    (match tail
      [`(halt ,_) (create-block! label tail)]
      [`(begin ,fx* ... ,tail)
       (create-block! label
                      `(jump ,(foldr expose-effect!
                                     (expose-tail! tail)
                                     fx*)))]
      [`(if ,pred ,tail1 ,tail2)
       `(if ,(TODO pred) ,(expose-tail! tail1)
            ,(expose-tail! tail2))]))
  (match p
    [`(module ,tail) (begin
                       (expose-tail! tail)
                       `(module ,@blocks))]))

(module+ test
  (require rackunit))