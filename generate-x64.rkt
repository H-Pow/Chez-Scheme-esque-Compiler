#lang racket

(require cpsc411/compiler-lib
         cpsc411/ptr-run-time
         "common.rkt")

(require rackunit)

(provide generate-x64)

(define-syntax-rule (TODO . stx)
  (error "Unfinished skeleton"))

; Paren-x64-v7:
;   p	 	::=	 	(begin s ...)

;   s	 	::=	 	(set! addr int32)
;  	 	|	 	(set! addr trg)
;  	 	|	 	(set! reg loc)
;  	 	|	 	(set! reg triv)
;  	 	|	 	(set! reg_1 (binop reg_1 int32))
;  	 	|	 	(set! reg_1 (binop reg_1 loc))
;  	 	|	 	(with-label label s)
;  	 	|	 	(jump trg)
;  	 	|	 	(compare reg opand)
;  	 	|	 	(jump-if relop label)

;   trg	 	::=	 	reg
;  	 	|	 	label

;   triv	 	::=	 	trg
;  	 	|	 	int64

;   opand	 	::=	 	int64
;  	 	|	 	reg

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
;  	 	|	 	r10
;  	 	|	 	r11
;  	 	|	 	r12
;  	 	|	 	r13
;  	 	|	 	r14
;  	 	|	 	r15

;   addr	 	::=	 	(fbp - dispoffset)

;   fbp	 	::=	 	frame-base-pointer-register?

;   binop	 	::=	 	*
;  	 	|	 	+
;  	 	|	 	-
;    	|	 	bitwise-and
;  	 	|	 	bitwise-ior
; 	 	|	 	bitwise-xor
 ;	 	|	 	arithmetic-shift-right

;   relop	 	::=	 	<
;  	 	|	 	<=
;  	 	|	 	=
;  	 	|	 	>=
;  	 	|	 	>
;  	 	|	 	!=

;   int64	 	::=	 	int64?

;   int32	 	::=	 	int32?

;   dispoffset	 	::=	 	dispoffset?

;   label	 	::=	 	label?

(define registers `(rax rbx rcx rdx rsi rdi r8 r9 r10 r11 r12 r13 r14 r15 rsp rbp))
; (define assoc/binops->fun (list (list '+ x64-add) (list '* x64-mul) (list '- x64-sub)))
; (define binops (map car assoc/binops->fun))

(define (relop? rl)
  (memq rl '(< <= = >= > !=)))

;; symbol -> boolean
;; reutrns true if addr is an address, false otherwise
(define (addr? addr)
  (match addr
    [`(,(? frame-base-pointer-register?) - ,(? dispoffset?)) #t]
    [_ #f]))

;; symbol -> boolean
;; returns true if provided symbol is a loc(reg or addr), false otherwise
(define loc? (or/c register? addr?))

;; paren-x64-v6 -> x64-instruction-sequence
;; Compiles a Paren-x64 v6 program into a x64 instruction sequence represented as a string.
(define (generate-x64 p)

  ;; is this how we supposed to do this?
  ;; edit nvm found the helper
  (define (fix-label l)
  #;
  (regexp-replace* #rx"-" (symbol->string l) "$2d$")
  (sanitize-label l))

  ;; paren-x64-v6-p -> x64-instruction-sequence
  ;; Compiles a Paren-x64-v6 begin-expression into a x64 instruction sequence represented as a string.
  (define (program->x64 p)
    (match p
      [`(begin
          ,s* ...)
       (string-join (map statement->x64 s*) "")]))

  ;; paren-x64-v6-loc -> x64-instruction-sequence
  (define (loc->ins loc)
    (match loc
      [(? register?) (~a loc)]
      [(? addr?)
       (match-let ([`(,reg - ,off) loc])
         (format "QWORD [~a - ~a]" reg off))]))
  ;; (or paren-x64-v6-loc int64) -> x64-instruction-sequence
  (define (val->ins val)
    (match val
      [(? int64?) val]
      [(? label?) (~a (fix-label val))]
      [_ (loc->ins val)]))

  ;; paren-x64-v6-trg -> x64-instruction-sequence
  (define (trg->ins trg)
    (match trg
      [(? register?) (~a trg)]
      [(? label?) (~a (fix-label trg))]))

  (define (opand->ins opand)
    (match opand
      [(? int64?) opand]
      [_ (~a opand)]))

  ;; paren-x64-v6-s -> x64-instruction-sequence
  ;; Compiles a Paren-x64 v4 set!-expression into a x64 instruction sequence represented as a string.
  (define (statement->x64 s)
    (match s
      [`(set! ,reg1 (,binop ,reg1 ,val))
       (format "~a ~a, ~a\n" (binop->ins binop) reg1 (val->ins val))]
      [`(set! ,loc ,label)
       #:when (label? label)
       (format "lea ~a, [rel ~a]\n" (loc->ins loc) (fix-label label))]
      [`(set! ,loc ,val) (format "mov ~a, ~a\n" (loc->ins loc) (val->ins val))]
      [`(with-label ,l ,s) (format "~a:\n~a" (fix-label l) (statement->x64 s))]
      [`(jump ,trg) (format "jmp ~a\n" (trg->ins trg))]
      [`(compare ,reg ,opand) (format "cmp ~a, ~a\n" reg (opand->ins opand))]
      [`(jump-if ,relop ,l) (format "~a ~a\n" (relop->ins relop) (fix-label l))]))

  (define (relop->ins relop)
    (match relop
      [`< "jl"]
      [`<= "jle"]
      [`= "je"]
      [`>= "jge"]
      [`> "jg"]
      [`!= "jne"]))

  ;; (paren-x64-v6 binop)-> x64-instruction
  ;; returns the corresponding x64 operator for the given binop
  (define (binop->ins b)
    (match b
      ['+ "add"]
      ['* "imul"]
      ['- "sub"]
      ['bitwise-and "and"]
      ['bitwise-ior "or"]
      ['bitwise-xor "xor"]
      ['arithmetic-shift-right "sar"]))
  (program->x64 p)) 
