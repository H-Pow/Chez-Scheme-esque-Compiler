#lang racket

(require cpsc411/compiler-lib
         cpsc411/langs/v4
         "assign-homes.rkt")

(provide optimize-predicates
         nested-asm-lang-progs)

;; nested-asm-lang-fvars-v6
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

;   opand	 	::=	 	int64
;  	 	|	 	loc

;   triv	 	::=	 	opand
;  	 	|	 	label

;   loc	 	::=	 	reg
;  	 	|	 	fvar

;   trg	 	::=	 	label
;  	 	|	 	loc

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

;   fvar	 	::=	 	fvar?

;   label	 	::=	 	label?

;; (nested-asm-lang-fvars-v6 p) -> (nested-asm-lang-fvars-v6 p)
;; Optimizes Nested-asm-lang-v4 programs by analyzing and simplifying predicates
(define (optimize-predicates p)

  ;; (nested-asm-lang-fvars-v6?) -> boolean
  ;; wrapper for int64?, may change implementation if optimize-predicates implementation changes
  ;; to statically evaluate a wider array of expressions.
  (define (concrete? val)
    (int64? val))

  ;; ((nested-asm-lang-fvars-v6 opand) (list (loc . (triv | 'unknown)))) ->
  ;;                                                              (nested-asm-lang-fvars-v6 triv) | 'unknown
  ;; Tries to make opand concrete using env, returns 'unknown if this is not possible
  (define (abstract-opand opand env)
    (if (int64? opand)
        opand
        (hash-ref env opand 'unknown)))

  ;; ((nested-asm-lang-fvars-v6 binop opand opand) (list (loc . (triv | 'unknown))))
  ;;      -> 'unknown | int64
  (define (abstract-binop op v1 v2 env)
    (define v1 (abstract-opand v1 env))
    (define v2 (abstract-opand v2 env))
    (match* (v1 v2)
      [((? int64?) (? int64?)) (op v1 v2)]
      [(_ _) 'unknown]))

  ;; ('relop) -> (nested-asm-lang-fvars-v6 relop)
  ;; Returns the function which op symbolizes.
  (define (patch-relop op)
    (match op
      ['> >]
      ['< <]
      ['= =]
      ['>= >=]
      ['<= <=]
      ['!= (λ (x y) (not (= x y)))]))

  ;; (nested-asm-lang-fvars-v6 relop loc opand (list (loc . (triv | 'unknown)))
  ;;                                          -> '(true) | '(false) | 'unknown
  ;; Attempts to resolve (relop v1 v2), using static information stored in env. Returns 'unknown
  ;; if there is not enough static information available.
  (define (abstract-relop relop loc opand env)
    (define v1 (abstract-opand loc env))
    (define v2 (abstract-opand opand env))
    (match* (v1 v2)
      [((? concrete?) (? concrete?))
       (if ((patch-relop relop) v1 v2)
           '(true)
           '(false))]
      [(_ _) `(,relop ,loc ,opand)]))

  ;; ((nested-asm-lang-fvars-v6 effect) ((and/c hash? (not/c immutable?)))) -> ('unknown | triv)
  (define (update-env effect env)
    (match effect
      [`(set! ,loc ,triv)
       (if (int64? triv)
           (hash-set! env loc triv)
           (hash-set! env loc (hash-ref env triv 'unknown)))]
      [`(set! ,loc1 (,op ,loc1 ,opand))
       (define cur-val (hash-ref env loc1 'unknown))
       (if (int64? cur-val)
           (hash-set! env loc1 (abstract-binop op cur-val opand env))
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
      [`(,relop ,loc ,opand) (abstract-relop relop loc opand env)]
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

  ;; (nested-asm-lang-fvars-v6) -> (nested-asm-lang-fvars-v6)
  ;; Optimizes an individual nested-asm-lang-fvars-v6 procedure definition
  (define (optimize-def def)
    (match def
      [`(define ,label ,tail) `(define ,label ,(optimize-tail tail (make-hash)))]))

  ;; (nested-asm-lang-fvars-v6 p) -> (nested-asm-lang-fvars-v6 p)
  (define (optimize-p p)
    (match p
      [`(module ,defs ...
          ,tail)
       `(module ,@(map optimize-def defs) ,(optimize-tail tail (make-hash))
          )]))

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
  (require rackunit
           cpsc411/langs/v6)

  (define-syntax-rule (check-by-interp p)
    (check-equal? (interp-nested-asm-lang-v5 p) (interp-nested-asm-lang-v5 (optimize-predicates p))))
  (define-syntax-rule (check-by-interp-v6 p)
    (check-equal? (interp-nested-asm-lang-fvars-v6 p)
                  (interp-nested-asm-lang-fvars-v6 (allocate-frames p))))

  ;; M6 tests; Added by Trevor on March 6th 2026, at most one binding per let
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 -422317085)
                                       (set! r14 r14)
                                       (set! r14 r14)
                                       (set! rax r14)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (define L.func.0.1
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
                                         (set! fv0 r15)
                                         (set! fv1 rdi)
                                         (set! r15 rsi)
                                         (set! fv1 fv1)
                                         (begin
                                           (set! rbp (- rbp 24))
                                           (return-point L.rp.3
                                                         (begin
                                                           (set! rsi fv1)
                                                           (set! rdi fv1)
                                                           (set! r15 L.rp.3)
                                                           (jump L.proc.1.2)))
                                           (set! rbp (+ rbp 24)))
                                         (set! r15 rax)
                                         (if (begin
                                               (set! r15 -59730991)
                                               (= r15 fv1))
                                             (begin
                                               (set! rax 0)
                                               (jump fv0))
                                             (begin
                                               (set! rax fv1)
                                               (jump fv0)))))
                               (begin
                                 (set! r15 r15)
                                 (if (false)
                                     (set! r14 9223372036854775807)
                                     (begin
                                       (set! r14 1)
                                       (set! r14 (* r14 -9223372036854775808))
                                       (set! r14 r14)))
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
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (begin
                                             (set! r14 -1418594624)
                                             (false))
                                           (begin
                                             (if (begin
                                                   (set! r14 -1123833745)
                                                   (> r14 1))
                                                 (set! r14 1)
                                                 (set! r14 0))
                                             (set! r14 767736686)
                                             (set! r14 r14))
                                           (if (true)
                                               (begin
                                                 (set! r14 1942655457)
                                                 (set! r14 r14))
                                               (begin
                                                 (set! r14 -9223372036854775808)
                                                 (set! r14 (+ r14 1))
                                                 (set! r14 r14))))
                                       (set! r14 r14)
                                       (set! r14 (- r14 r14))
                                       (set! rax r14)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (define L.func.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (set! r15 rdi)
                                         (set! r15 rsi)
                                         (set! r14 rdx)
                                         (set! fv2 rcx)
                                         (set! fv1 r8)
                                         (begin
                                           (set! rbp (- rbp 24))
                                           (return-point L.rp.2
                                                         (begin
                                                           (set! r8 fv1)
                                                           (set! rcx fv2)
                                                           (set! rdx r15)
                                                           (set! rsi -9223372036854775808)
                                                           (set! rdi -1343541856)
                                                           (set! r15 L.rp.2)
                                                           (jump L.func.0.1)))
                                           (set! rbp (+ rbp 24)))
                                         (set! r15 rax)
                                         (if (begin
                                               (set! r15 0)
                                               (!= r15 9223372036854775807))
                                             (if (begin
                                                   (set! r15 1346978436)
                                                   (= r15 fv1))
                                                 (begin
                                                   (set! rax 0)
                                                   (jump fv0))
                                                 (begin
                                                   (set! rax fv1)
                                                   (jump fv0)))
                                             (begin
                                               (set! r8 fv2)
                                               (set! rcx 9223372036854775807)
                                               (set! rdx 1)
                                               (set! rsi fv1)
                                               (set! rdi -1402588641)
                                               (set! r15 fv0)
                                               (jump L.func.0.1)))))
                                     (begin
                                       (set! r15 r15)
                                       (if (begin
                                             (set! r14 824269768)
                                             (< r14 9223372036854775807))
                                           (set! r14 -9223372036854775808)
                                           (set! r14 709343632))
                                       (set! rax r14)
                                       (jump r15))
                               ))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 -356902212)
                                       (set! r14 -979281755)
                                       (set! r14 (+ r14 9223372036854775807))
                                       (set! rax r14)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (define L.tmp.0.1
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
                                             (= r14 -444572554))
                                           (begin
                                             (set! rax -9223372036854775808)
                                             (jump r15))
                                           (begin
                                             (set! rax 0)
                                             (jump r15))))
                               ))
  (replace-with-syntax-rule '(module (define L.x.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (set! r15 rdi)
                                         (set! fv2 rsi)
                                         (set! fv1 rdx)
                                         (set! r15 rcx)
                                         (set! r14 r8)
                                         (if (not (<= fv1 9223372036854775807))
                                             (begin
                                               (set! r14 -18835826)
                                               (set! r14 r14)
                                               (if (>= fv1 r15)
                                                   (begin
                                                     (set! rax fv1)
                                                     (jump fv0))
                                                   (begin
                                                     (set! rax fv2)
                                                     (jump fv0))))
                                             (begin
                                               (begin
                                                 (set! rbp (- rbp 24))
                                                 (return-point L.rp.3
                                                               (begin
                                                                 (set! r8 0)
                                                                 (set! rcx r14)
                                                                 (set! rdx fv1)
                                                                 (set! rsi 9223372036854775807)
                                                                 (set! rdi r14)
                                                                 (set! r15 L.rp.3)
                                                                 (jump L.x.0.1)))
                                                 (set! rbp (+ rbp 24)))
                                               (set! r15 rax)
                                               (if (<= fv2 -186024487)
                                                   (begin
                                                     (set! rax r15)
                                                     (jump fv0))
                                                   (begin
                                                     (set! rax fv1)
                                                     (jump fv0)))))))
                                     (define L.func.1.2
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r13 rsi)
                                         (set! r13 -932453002)
                                         (if (begin
                                               (set! r9 -1133252869)
                                               (>= r9 9223372036854775807))
                                             (set! r14 479665611)
                                             (set! r14 r14))
                                         (set! r14 r13)
                                         (set! rax r13)
                                         (jump r15)))
                               (begin
                                 (set! r15 r15)
                                 (if (begin
                                       (set! r14 1588211020)
                                       (>= r14 1))
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump r15))
                                     (begin
                                       (set! rax -9223372036854775808)
                                       (jump r15))))))
  (replace-with-syntax-rule '(module (define L.proc.0.1
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
                                         (if (true)
                                             (begin
                                               (set! rdx r13)
                                               (set! rsi r14)
                                               (set! rdi -508654129)
                                               (set! r15 r15)
                                               (jump L.func.1.2))
                                             (begin
                                               (set! rdx r13)
                                               (set! rsi 9223372036854775807)
                                               (set! rdi 1)
                                               (set! r15 r15)
                                               (jump L.func.1.2)))))
                               (begin
                                 (set! r15 r15)
                                 (set! r14 0)
                                 (set! r14 (* r14 -9223372036854775808))
                                 (set! r14 r14)
                                 (set! rdi -39871347)
                                 (set! r15 r15)
                                 (jump L.proc.0.1))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (begin
                                             (set! r14 1)
                                             (>= r14 -9223372036854775808))
                                           (begin
                                             (set! rax 234292566)
                                             (jump r15))
                                           (begin
                                             (set! rax -1579825632)
                                             (jump r15))))))
  (replace-with-syntax-rule '(module (define L.x.0.1
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
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! rax 1)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (define L.fn.0.1
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
                                               (>= r14 9223372036854775807))
                                             (begin
                                               (set! rax -1098447432)
                                               (jump r15))
                                             (begin
                                               (set! r14 -9223372036854775808)
                                               (set! r14 (+ r14 -9223372036854775808))
                                               (set! r14 r14)
                                               (if (begin
                                                     (set! r14 857729561)
                                                     (< r14 9223372036854775807))
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
                                   (set! r8 fv0)
                                   (if (not (true))
                                       (begin
                                         (if (>= rdi -9223372036854775808)
                                             (set! r13 1)
                                             (set! r13 1))
                                         (set! rsi r13)
                                         (set! rdi r14)
                                         (set! r15 r15)
                                         (jump L.fn.0.1))
                                       (if (true)
                                           (begin
                                             (set! r14 r9)
                                             (set! r14 (* r14 rdi))
                                             (set! rax r14)
                                             (jump r15))
                                           (begin
                                             (set! r14 r13)
                                             (set! rax 674342291)
                                             (jump r15))))))
                               (begin
                                 (set! r15 r15)
                                 (if (begin
                                       (begin
                                         (set! r14 1)
                                         (set! r14 -9223372036854775808)
                                         (set! r14 r14)
                                         (set! r14 9223372036854775807))
                                       (if (true)
                                           (if (= r14 r14)
                                               (begin
                                                 (set! r13 -1195644570)
                                                 (>= r13 r14))
                                               (= r14 r14))
                                           (if (> r14 r14)
                                               (>= r14 r14)
                                               (begin
                                                 (set! r13 0)
                                                 (= r13 r14)))))
                                     (begin
                                       (set! fv0 0)
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
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (begin
                                             (set! r14 -9223372036854775808)
                                             (> r14 9223372036854775807))
                                           (begin
                                             (if (begin
                                                   (set! r14 1)
                                                   (!= r14 9223372036854775807))
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
                                                 (>= r13 r13))
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
  (replace-with-syntax-rule '(module (define L.tmp.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r14 rsi)
                                         (set! r14 rdx)
                                         (set! r14 rcx)
                                         (set! r14 r8)
                                         (set! r13 r9)
                                         (set! r14 fv0)
                                         (set! fv0 r13)
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
                                       (set! fv0 1)
                                       (set! r9 9223372036854775807)
                                       (set! r8 -9223372036854775808)
                                       (set! rcx -522285902)
                                       (set! rdx 754255570)
                                       (set! rsi -1704260755)
                                       (set! rdi 0)
                                       (set! r15 r15)
                                       (jump L.tmp.0.1))
                               ))
  (replace-with-syntax-rule '(module (define L.proc.0.1
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
                                         (set! fv0 -9223372036854775808)
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
                                   (set! r13 fv0)
                                   (set! rax r14)
                                   (jump r15)))
                               (begin
                                 (set! r15 r15)
                                 (if (false)
                                     (begin
                                       (set! r14 1281469771)
                                       (set! rax 0)
                                       (jump r15))
                                     (begin
                                       (set! fv0 1)
                                       (set! r9 9223372036854775807)
                                       (set! r8 1)
                                       (set! rcx -282402130)
                                       (set! rdx -9223372036854775808)
                                       (set! rsi 9223372036854775807)
                                       (set! rdi 1)
                                       (set! r15 r15)
                                       (jump L.tmp.2.3))))))
  (replace-with-syntax-rule '(module (define L.tmp.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r14 rsi)
                                         (set! r14 rdx)
                                         (set! r14 rcx)
                                         (set! r13 r8)
                                         (set! r13 r9)
                                         (set! r13 fv0)
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
  (replace-with-syntax-rule '(module (define L.func.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r13 rsi)
                                         (set! r13 rdx)
                                         (set! r13 rcx)
                                         (set! r13 r8)
                                         (if (false)
                                             (begin
                                               (if (begin
                                                     (set! r13 -9223372036854775808)
                                                     (!= r13 0))
                                                   (set! r14 1)
                                                   (set! r14 r14))
                                               (set! r14 9223372036854775807)
                                               (set! rax 9223372036854775807)
                                               (jump r15))
                                             (begin
                                               (set! rax 1)
                                               (jump r15)))))
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
  (replace-with-syntax-rule '(module (define L.fn.0.1
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
  (replace-with-syntax-rule '(module (define L.x.0.1
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
  (replace-with-syntax-rule '(module (define L.func.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r14 rsi)
                                         (set! r14 rdx)
                                         (set! r14 rcx)
                                         (set! r13 r8)
                                         (set! r13 r9)
                                         (set! r13 fv0)
                                         (set! rsi 0)
                                         (set! rdi r14)
                                         (set! r15 r15)
                                         (jump L.x.1.2)))
                                     (define L.x.1.2
                                       (begin
                                         (set! fv0 r15)
                                         (set! fv2 rdi)
                                         (set! fv1 rsi)
                                         (begin
                                           (set! rbp (- rbp 24))
                                           (return-point L.rp.3
                                                         (begin
                                                           (set! fv3 fv1)
                                                           (set! r9 -9223372036854775808)
                                                           (set! r8 -9223372036854775808)
                                                           (set! rcx fv2)
                                                           (set! rdx fv1)
                                                           (set! rsi fv1)
                                                           (set! rdi fv2)
                                                           (set! r15 L.rp.3)
                                                           (jump L.func.0.1)))
                                           (set! rbp (+ rbp 24)))
                                         (set! r15 rax)
                                         (set! r14 fv2)
                                         (set! r14 (+ r14 -841927304))
                                         (set! r14 r14)
                                         (if (begin
                                               (set! r14 -9223372036854775808)
                                               (= r14 fv1))
                                             (begin
                                               (set! rax r15)
                                               (jump fv0))
                                             (begin
                                               (set! rax -19487548)
                                               (jump fv0)))))
                               (begin
                                 (set! r15 r15)
                                 (set! rsi 169577204)
                                 (set! rdi 1130382988)
                                 (set! r15 r15)
                                 (jump L.x.1.2))))
  (replace-with-syntax-rule '(module (define L.proc.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r13 rsi)
                                         (set! r14 rdx)
                                         (set! r14 rcx)
                                         (set! rdi r8)
                                         (set! r9 r9)
                                         (if (false)
                                             (begin
                                               (set! r13 1763789232)
                                               (set! r13 (+ r13 0))
                                               (set! r13 r13)
                                               (set! r13 9223372036854775807)
                                               (set! rax r14)
                                               (jump r15))
                                             (begin
                                               (set! r9 r13)
                                               (set! r8 -9223372036854775808)
                                               (set! rcx r13)
                                               (set! rdx rdi)
                                               (set! rsi rdi)
                                               (set! rdi 9223372036854775807)
                                               (set! r15 r15)
                                               (jump L.proc.0.1)))))
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
                                     (if (true)
                                         (if (true)
                                             (begin
                                               (set! rcx -9223372036854775808)
                                               (set! rdx -481495635)
                                               (set! rsi 0)
                                               (set! rdi 9223372036854775807)
                                               (set! r15 r15)
                                               (jump L.func.1.2))
                                             (begin
                                               (set! r14 1)
                                               (set! rax 1)
                                               (jump r15)))
                                         (if (not (begin
                                                    (set! r14 -2094891483)
                                                    (<= r14 -9223372036854775808)))
                                             (if (begin
                                                   (set! r14 -9223372036854775808)
                                                   (>= r14 -753552692))
                                                 (begin
                                                   (set! rax 1)
                                                   (jump r15))
                                                 (begin
                                                   (set! rax 9223372036854775807)
                                                   (jump r15)))
                                             (begin
                                               (set! r9 -1972468042)
                                               (set! r8 9223372036854775807)
                                               (set! rcx 1598924696)
                                               (set! rdx 0)
                                               (set! rsi 1)
                                               (set! rdi 1)
                                               (set! r15 r15)
                                               (jump L.proc.0.1))))
                                     (if (false)
                                         (begin
                                           (set! r9 1)
                                           (set! r8 716409514)
                                           (set! rcx 0)
                                           (set! rdx 0)
                                           (set! rsi 9223372036854775807)
                                           (set! rdi 9223372036854775807)
                                           (set! r15 r15)
                                           (jump L.proc.0.1))
                                         (begin
                                           (set! r9 1)
                                           (set! r8 -100459334)
                                           (set! rcx -983869259)
                                           (set! rdx -9223372036854775808)
                                           (set! rsi -1938006617)
                                           (set! rdi 1)
                                           (set! r15 r15)
                                           (jump L.proc.0.1)))))))
  (replace-with-syntax-rule '(module (define L.tmp.0.1
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
  (replace-with-syntax-rule '(module (define L.x.0.1
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
  (replace-with-syntax-rule '(module (define L.tmp.0.1
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
                                       (set! fv0 r15)
                                       (if (false)
                                           (begin
                                             (if (if (begin
                                                       (set! r15 9223372036854775807)
                                                       (> r15 1428972274))
                                                     (begin
                                                       (set! r15 0)
                                                       (!= r15 479631559))
                                                     (begin
                                                       (set! r15 0)
                                                       (>= r15 1284385619)))
                                                 (begin
                                                   (begin
                                                     (set! rbp (- rbp 8))
                                                     (return-point L.rp.2
                                                                   (begin
                                                                     (set! rcx 1)
                                                                     (set! rdx 0)
                                                                     (set! rsi -1164071576)
                                                                     (set! rdi 1550080702)
                                                                     (set! r15 L.rp.2)
                                                                     (jump L.tmp.0.1)))
                                                     (set! rbp (+ rbp 8)))
                                                   (set! r15 rax))
                                                 (set! r15 -9223372036854775808))
                                             (if (if (begin
                                                       (set! r14 0)
                                                       (<= r14 r15))
                                                     (!= r15 2009350954)
                                                     (begin
                                                       (set! r14 1170635915)
                                                       (!= r14 r15)))
                                                 (begin
                                                   (set! r15 r15)
                                                   (set! rax 0)
                                                   (jump fv0))
                                                 (begin
                                                   (set! r14 -378459323)
                                                   (set! rax r15)
                                                   (jump fv0))))
                                           (if (false)
                                               (begin
                                                 (set! rax 0)
                                                 (jump fv0))
                                               (begin
                                                 (set! r15 1326448876)
                                                 (set! r15 (- r15 360169641))
                                                 (set! rax r15)
                                                 (jump fv0)))))
                               ))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 1)
                                       (set! r14 r14)
                                       (set! r14 r14)
                                       (set! rax r14)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (define L.func.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (set! r15 rdi)
                                         (set! r15 rsi)
                                         (set! fv1 rdx)
                                         (set! r15 -529343887)
                                         (set! r15 (* r15 -1285114971))
                                         (set! r15 r15)
                                         (begin
                                           (set! rbp (- rbp 16))
                                           (return-point L.rp.3
                                                         (begin
                                                           (set! rdx fv1)
                                                           (set! rsi r15)
                                                           (set! rdi r15)
                                                           (set! r15 L.rp.3)
                                                           (jump L.func.0.1)))
                                           (set! rbp (+ rbp 16)))
                                         (set! r15 rax)
                                         (if (begin
                                               (set! r15 1981945067)
                                               (= r15 fv1))
                                             (begin
                                               (set! rax -195961595)
                                               (jump fv0))
                                             (begin
                                               (set! rax 9223372036854775807)
                                               (jump fv0)))))
                                     (define L.fn.1.2
                                       (begin
                                         (set! fv0 r15)
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
                                         (jump fv0)))
                               (begin
                                 (set! fv0 r15)
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
                                 (set! fv1 rax)
                                 (if (not (if (begin
                                                (set! r15 -9223372036854775808)
                                                (= r15 649827574))
                                              (begin
                                                (set! r15 -9223372036854775808)
                                                (< r15 fv1))
                                              (= fv1 -9223372036854775808)))
                                     (if (begin
                                           (set! r15 -9223372036854775808)
                                           (< r15 -9223372036854775808))
                                         (begin
                                           (set! r15 9223372036854775807)
                                           (set! r15 (- r15 fv1))
                                           (set! rax r15)
                                           (jump fv0))
                                         (begin
                                           (set! r15 fv1)
                                           (set! rax r15)
                                           (jump fv0)))
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
                                       (set! r15 (* r15 fv1))
                                       (set! rax r15)
                                       (jump fv0))))))
  (replace-with-syntax-rule '(module (define L.tmp.0.1
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
                                         (set! r8 fv0)
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
  (replace-with-syntax-rule '(module (define L.func.0.1
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
  (replace-with-syntax-rule '(module (define L.func.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (set! fv3 rdi)
                                         (set! fv1 rsi)
                                         (set! fv2 rdx)
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
                                               (= r15 0))
                                             (begin
                                               (set! rdx fv1)
                                               (set! rsi fv1)
                                               (set! rdi 719591632)
                                               (set! r15 fv0)
                                               (jump L.func.0.1))
                                             (if (>= fv2 1396041917)
                                                 (begin
                                                   (set! rax -1711968134)
                                                   (jump fv0))
                                                 (begin
                                                   (set! rax fv3)
                                                   (jump fv0))))))
                                     (begin
                                       (set! r15 r15)
                                       (set! rdx 0)
                                       (set! rsi 9223372036854775807)
                                       (set! rdi -9223372036854775808)
                                       (set! r15 r15)
                                       (jump L.func.0.1))
                               ))
  (replace-with-syntax-rule '(module (define L.x.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (if (begin
                                               (set! r15 0)
                                               (<= r15 1773437967))
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
                                               (jump fv0))
                                             (begin
                                               (set! rdi -9223372036854775808)
                                               (set! r15 fv0)
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
  (replace-with-syntax-rule '(module (define L.fn.0.1
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
                                         (if (if (true)
                                                 (< r8 r14)
                                                 (begin
                                                   (set! r14 r14)
                                                   (begin
                                                     (set! rsi 0)
                                                     (<= rsi -508327908))))
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
                                       (<= r14 0))
                                     (set! r14 0)
                                     (set! r14 93609173))
                                 (set! r14 r14)
                                 (set! r14 r14)
                                 (set! rax r14)
                                 (jump r15))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 -9223372036854775808)
                                       (set! r14 0)
                                       (set! r13 r14)
                                       (if (begin
                                             (set! r14 r13)
                                             (begin
                                               (set! r14 1)
                                               (<= r14 -9223372036854775808)))
                                           (begin
                                             (set! rax r13)
                                             (jump r15))
                                           (begin
                                             (set! r14 r13)
                                             (set! rax 1974766267)
                                             (jump r15))))))
  (replace-with-syntax-rule '(module (define L.x.0.1
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
                                       (set! fv0 r15)
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
                                             (set! r15 fv0)
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
                                                   (jump fv0))
                                                 (begin
                                                   (set! rax 9223372036854775807)
                                                   (jump fv0))))))
                               ))
  (replace-with-syntax-rule '(module (define L.func.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r14 rsi)
                                         (set! r14 rdx)
                                         (set! r14 rcx)
                                         (set! r14 r8)
                                         (set! r14 r9)
                                         (set! r13 -951184591)
                                         (if (false)
                                             (begin
                                               (set! r14 -9223372036854775808)
                                               (set! rax r14)
                                               (jump r15))
                                             (begin
                                               (set! r13 310790521)
                                               (set! rax r14)
                                               (jump r15)))))
                                     (begin
                                       (set! r15 r15)
                                       (set! r14 -1379426851)
                                       (set! rax 488563830)
                                       (jump r15))
                               ))
  (replace-with-syntax-rule '(module (define L.func.0.1
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
                                             (if (true)
                                                 (begin
                                                   (set! r14 r14)
                                                   (set! rax r14)
                                                   (jump r15))
                                                 (begin
                                                   (set! rdx 1)
                                                   (set! rsi r13)
                                                   (set! rdi r13)
                                                   (set! r15 r15)
                                                   (jump L.func.0.1))))))
                                     (begin
                                       (set! r15 r15)
                                       (set! r14 -1766715399)
                                       (if (not (not (< r14 r14)))
                                           (begin
                                             (if (< r14 0)
                                                 (set! r14 9223372036854775807)
                                                 (set! r14 r14))
                                             (set! rax -1170116362)
                                             (jump r15))
                                           (begin
                                             (set! r14 0)
                                             (set! r14 (* r14 0))
                                             (set! rax r14)
                                             (jump r15))))
                               ))
  (replace-with-syntax-rule '(module (define L.tmp.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (set! r15 rdi)
                                         (set! fv2 rsi)
                                         (set! fv1 rdx)
                                         (set! r15 1591590730)
                                         (begin
                                           (set! rbp (- rbp 24))
                                           (return-point L.rp.2
                                                         (begin
                                                           (set! rdx fv1)
                                                           (set! rsi fv1)
                                                           (set! rdi 1001483234)
                                                           (set! r15 L.rp.2)
                                                           (jump L.tmp.0.1)))
                                           (set! rbp (+ rbp 24)))
                                         (set! r15 rax)
                                         (set! rdx fv2)
                                         (set! rsi fv1)
                                         (set! rdi -9223372036854775808)
                                         (set! r15 fv0)
                                         (jump L.tmp.0.1)))
                                     (begin
                                       (set! fv0 r15)
                                       (if (if (begin
                                                 (set! r15 1)
                                                 (!= r15 0))
                                               (begin
                                                 (set! r15 -9223372036854775808)
                                                 (<= r15 9223372036854775807))
                                               (begin
                                                 (set! r15 0)
                                                 (= r15 0)))
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
                                                 (= r14 -2078605817)))
                                           (begin
                                             (set! rdx 1739531838)
                                             (set! rsi r15)
                                             (set! rdi r15)
                                             (set! r15 fv0)
                                             (jump L.tmp.0.1))
                                           (begin
                                             (set! rdx -1707829089)
                                             (set! rsi -2103046426)
                                             (set! rdi 0)
                                             (set! r15 fv0)
                                             (jump L.tmp.0.1))))
                               ))
  (replace-with-syntax-rule '(module (define L.tmp.0.1
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
                                               (> r13 1))
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
  (replace-with-syntax-rule '(module (define L.x.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r13 rsi)
                                         (set! r13 rdx)
                                         (set! r9 rcx)
                                         (set! r9 r8)
                                         (if (false)
                                             (if (begin
                                                   (set! r13 r13)
                                                   (begin
                                                     (set! r8 0)
                                                     (< r8 r13)))
                                                 (begin
                                                   (set! rsi -9223372036854775808)
                                                   (set! rdi 0)
                                                   (set! r15 r15)
                                                   (jump L.x.1.2))
                                                 (begin
                                                   (set! r13 r9)
                                                   (set! rax r14)
                                                   (jump r15)))
                                             (if (true)
                                                 (if (begin
                                                       (set! r14 -9223372036854775808)
                                                       (!= r14 1))
                                                     (begin
                                                       (set! rax 0)
                                                       (jump r15))
                                                     (begin
                                                       (set! rax 849007740)
                                                       (jump r15)))
                                                 (begin
                                                   (set! rax r14)
                                                   (jump r15))))))
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
                                   (set! fv0 r15)
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
                                   (set! r15 fv0)
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
  (replace-with-syntax-rule '(module (define L.tmp.0.1
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
  (replace-with-syntax-rule '(module (define L.tmp.0.1
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
                                       (set! fv0 r15)
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
                                             (= r15 175566669))
                                           (begin
                                             (set! rax -1855219983)
                                             (jump fv0))
                                           (begin
                                             (set! rax r14)
                                             (jump fv0))))
                               ))
  (replace-with-syntax-rule '(module (define L.proc.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (if (begin
                                               (set! r13 1541307282)
                                               (begin
                                                 (set! r13 9223372036854775807)
                                                 (= r13 -194099637)))
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
                                 (set! fv0 r15)
                                 (if (true)
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
                                       (jump fv0))
                                     (begin
                                       (set! r15 -1579827217)
                                       (set! rdi r15)
                                       (set! r15 fv0)
                                       (jump L.fn.2.3))))))
  (replace-with-syntax-rule '(module (define L.x.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (set! r15 rdi)
                                         (set! r15 rsi)
                                         (set! r15 rdx)
                                         (set! fv1 rcx)
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
                                         (if (true)
                                             (begin
                                               (set! r15 -9223372036854775808)
                                               (set! r15 (* r15 fv1))
                                               (set! rax r15)
                                               (jump fv0))
                                             (if (begin
                                                   (set! r14 -9223372036854775808)
                                                   (!= r14 r15))
                                                 (begin
                                                   (set! rax fv1)
                                                   (jump fv0))
                                                 (begin
                                                   (set! rax 0)
                                                   (jump fv0))))))
                                     (define L.fn.1.2
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r14 rsi)
                                         (set! r13 rdx)
                                         (set! r9 rcx)
                                         (set! r8 r8)
                                         (if (false)
                                             (begin
                                               (if (begin
                                                     (set! r13 -1658461695)
                                                     (!= r13 9223372036854775807))
                                                   (set! r14 -9223372036854775808)
                                                   (set! r14 r14))
                                               (set! rax 9223372036854775807)
                                               (jump r15))
                                             (if (false)
                                                 (if (= r13 1)
                                                     (begin
                                                       (set! rax r9)
                                                       (jump r15))
                                                     (begin
                                                       (set! rax 9223372036854775807)
                                                       (jump r15)))
                                                 (begin
                                                   (set! r14 r13)
                                                   (set! rax 1)
                                                   (jump r15))))))
                               (define L.tmp.2.3
                                 (begin
                                   (set! r15 r15)
                                   (set! r14 1)
                                   (set! r14 r14)
                                   (if (if (begin
                                             (set! r13 9223372036854775807)
                                             (> r13 r14))
                                           (>= r14 9223372036854775807)
                                           (<= r14 r14))
                                       (if (> r14 r14)
                                           (begin
                                             (set! rax 1)
                                             (jump r15))
                                           (begin
                                             (set! rax r14)
                                             (jump r15)))
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
  (replace-with-syntax-rule '(module (define L.proc.0.1
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
                                                        (> r9 701262944))
                                                      (!= rsi 9223372036854775807)
                                                      (< rdi rdi)))
                                             (if (true)
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
                                                   (set! r14 rsi)
                                                   (set! rax r13)
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
                                       (<= r14 899234556))
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
  (replace-with-syntax-rule '(module (define L.x.0.1
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
                                                 (<= r9 -1549190542)))
                                             (begin
                                               (set! r9 1)
                                               (set! r13 r13))
                                             (set! r13 r13))
                                         (if (true)
                                             (begin
                                               (set! r14 r14)
                                               (set! rax r13)
                                               (jump r15))
                                             (begin
                                               (set! rcx r14)
                                               (set! rdx -9223372036854775808)
                                               (set! rsi r13)
                                               (set! rdi r13)
                                               (set! r15 r15)
                                               (jump L.x.0.1)))))
                                     (begin
                                       (set! r15 r15)
                                       (if (true)
                                           (set! r14 480297521)
                                           (begin
                                             (set! r14 1)
                                             (set! r14 (- r14 0))
                                             (set! r14 r14)))
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
  (replace-with-syntax-rule '(module (define L.func.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r14 rsi)
                                         (set! r13 rdx)
                                         (set! rdi rcx)
                                         (set! r8 r8)
                                         (set! r9 r9)
                                         (set! rsi fv0)
                                         (if (begin
                                               (set! rsi 9223372036854775807)
                                               (> rsi -1225978347))
                                             (if (if (> r13 1)
                                                     (> r9 -9223372036854775808)
                                                     (!= r8 -847185955))
                                                 (begin
                                                   (set! fv0 -260761950)
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
                                               (set! fv0 0)
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
                                             (>= r14 9223372036854775807))
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
  (replace-with-syntax-rule '(module (define L.proc.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r14 rsi)
                                         (set! r14 rdx)
                                         (set! r14 rcx)
                                         (set! r14 r8)
                                         (set! r14 r9)
                                         (set! r14 fv0)
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
                                   (set! fv0 1635273112)
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
                                           (<= r14 -9223372036854775808))
                                         (begin
                                           (set! r14 692968731)
                                           (< r14 0))
                                         (begin
                                           (set! r14 -1490931083)
                                           (<= r14 -14809197)))
                                     (begin
                                       (set! rax 1275113131)
                                       (jump r15))
                                     (if (begin
                                           (set! r14 -1702177019)
                                           (<= r14 -9223372036854775808))
                                         (begin
                                           (set! rax 0)
                                           (jump r15))
                                         (begin
                                           (set! rax 1843455920)
                                           (jump r15)))))))
  (replace-with-syntax-rule '(module (define L.fn.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r13 rsi)
                                         (set! r13 rdx)
                                         (set! rdi rcx)
                                         (set! r13 r8)
                                         (set! r13 r9)
                                         (set! r9 fv0)
                                         (set! fv0 r13)
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
  (replace-with-syntax-rule '(module (define L.func.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (set! r14 rdi)
                                         (set! r15 rsi)
                                         (set! r15 rdx)
                                         (set! r13 rcx)
                                         (set! fv1 r8)
                                         (if (true)
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
                                               (set! r14 fv1)
                                               (set! r14 (+ r14 r15))
                                               (set! rax r14)
                                               (jump fv0))
                                             (begin
                                               (set! rdx 9223372036854775807)
                                               (set! rsi r13)
                                               (set! rdi fv1)
                                               (set! r15 fv0)
                                               (jump L.func.1.2)))))
                                     (define L.func.1.2
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r13 rsi)
                                         (set! r8 rdx)
                                         (if (begin
                                               (set! r9 9223372036854775807)
                                               (!= r9 -47909185))
                                             (if (false)
                                                 (if (< r8 r8)
                                                     (begin
                                                       (set! rax r14)
                                                       (jump r15))
                                                     (begin
                                                       (set! rax -9223372036854775808)
                                                       (jump r15)))
                                                 (begin
                                                   (set! rdx r8)
                                                   (set! rsi r8)
                                                   (set! rdi r14)
                                                   (set! r15 r15)
                                                   (jump L.func.1.2)))
                                             (begin
                                               (set! r14 -9223372036854775808)
                                               (set! r14 (+ r14 r13))
                                               (set! rax r14)
                                               (jump r15)))))
                               (begin
                                 (set! r15 r15)
                                 (if (begin
                                       (set! r14 9223372036854775807)
                                       (> r14 9223372036854775807))
                                     (begin
                                       (set! rax -877748660)
                                       (jump r15))
                                     (begin
                                       (set! rax -9223372036854775808)
                                       (jump r15))))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 -1640821439)
                                       (set! r14 (+ r14 -406700566))
                                       (set! rax r14)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (define L.fn.0.1
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
  (replace-with-syntax-rule '(module (define L.func.0.1
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
                                   (set! fv0 r15)
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
                                         (set! r15 fv0)
                                         (jump L.tmp.1.2))
                                       (begin
                                         (set! rdi r15)
                                         (set! r15 fv0)
                                         (jump L.func.0.1)))))
                               (begin
                                 (set! r15 r15)
                                 (if (true)
                                     (begin
                                       (set! r14 9223372036854775807)
                                       (set! r14 (+ r14 -9223372036854775808))
                                       (set! rax r14)
                                       (jump r15))
                                     (begin
                                       (set! rdi -2107846344)
                                       (set! r15 r15)
                                       (jump L.func.0.1))))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (begin
                                             (set! r14 1)
                                             (<= r14 -9223372036854775808))
                                           (if (false)
                                               (begin
                                                 (set! rax -9223372036854775808)
                                                 (jump r15))
                                               (begin
                                                 (set! rax 2012039291)
                                                 (jump r15)))
                                           (begin
                                             (set! rax 9223372036854775807)
                                             (jump r15))))))
  (replace-with-syntax-rule '(module (define L.func.0.1
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
                                         (set! fv0 r15)
                                         (set! r15 9223372036854775807)
                                         (set! r15 (+ r15 1))
                                         (set! fv1 r15)
                                         (begin
                                           (set! rbp (- rbp 16))
                                           (return-point L.rp.4
                                                         (begin
                                                           (set! r9 fv1)
                                                           (set! r8 fv1)
                                                           (set! rcx fv1)
                                                           (set! rdx fv1)
                                                           (set! rsi fv1)
                                                           (set! rdi 0)
                                                           (set! r15 L.rp.4)
                                                           (jump L.func.0.1)))
                                           (set! rbp (+ rbp 16)))
                                         (set! r15 rax)
                                         (set! r14 fv1)
                                         (if (>= fv1 fv1)
                                             (set! r14 fv1)
                                             (set! r14 fv1))
                                         (set! r15 r15)
                                         (set! r15 r15)
                                         (set! r15 -9223372036854775808)
                                         (set! rax 9223372036854775807)
                                         (jump fv0)))
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
  (replace-with-syntax-rule '(module (define L.x.0.1
                                       (begin
                                         (set! fv1 r15)
                                         (set! r15 rdi)
                                         (set! fv3 rsi)
                                         (set! r14 rdx)
                                         (set! fv4 rcx)
                                         (set! fv2 r8)
                                         (set! r13 r9)
                                         (set! r14 fv0)
                                         (begin
                                           (set! rbp (- rbp 40))
                                           (return-point L.rp.3
                                                         (begin
                                                           (set! fv5 r13)
                                                           (set! r9 r15)
                                                           (set! r8 r13)
                                                           (set! rcx 0)
                                                           (set! rdx r14)
                                                           (set! rsi fv4)
                                                           (set! rdi fv4)
                                                           (set! r15 L.rp.3)
                                                           (jump L.fn.1.2)))
                                           (set! rbp (+ rbp 40)))
                                         (set! r15 rax)
                                         (if (not (begin
                                                    (set! r14 0)
                                                    (< r14 -9223372036854775808)))
                                             (begin
                                               (set! r14 fv2)
                                               (set! r14 (+ r14 r15))
                                               (set! rax r14)
                                               (jump fv1))
                                             (if (<= fv4 0)
                                                 (begin
                                                   (set! rax fv4)
                                                   (jump fv1))
                                                 (begin
                                                   (set! rax fv3)
                                                   (jump fv1))))))
                                     (define L.fn.1.2
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (set! r14 rsi)
                                         (set! r13 rdx)
                                         (set! r13 rcx)
                                         (set! r8 r8)
                                         (set! r8 r9)
                                         (set! r9 fv0)
                                         (set! fv0 0)
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
                                       (>= r14 -637253177))
                                     (begin
                                       (set! rax -9223372036854775808)
                                       (jump r15))
                                     (begin
                                       (set! rax 0)
                                       (jump r15))))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! rax 9223372036854775807)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (define L.proc.0.1
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
                                         (set! fv1 r15)
                                         (set! fv3 rdi)
                                         (set! fv0 rsi)
                                         (set! fv4 rdx)
                                         (set! fv5 rcx)
                                         (set! fv2 r8)
                                         (begin
                                           (set! rbp (- rbp 56))
                                           (return-point L.rp.4
                                                         (begin
                                                           (set! r8 fv2)
                                                           (set! rcx fv5)
                                                           (set! rdx fv3)
                                                           (set! rsi fv2)
                                                           (set! rdi fv5)
                                                           (set! r15 L.rp.4)
                                                           (jump L.tmp.1.2)))
                                           (set! rbp (+ rbp 56)))
                                         (set! fv6 rax)
                                         (begin
                                           (set! rbp (- rbp 56))
                                           (return-point L.rp.5
                                                         (begin
                                                           (set! fv7 fv2)
                                                           (set! r9 fv4)
                                                           (set! r8 fv5)
                                                           (set! rcx -501684781)
                                                           (set! rdx fv2)
                                                           (set! rsi 9223372036854775807)
                                                           (set! rdi fv0)
                                                           (set! r15 L.rp.5)
                                                           (jump L.func.2.3)))
                                           (set! rbp (+ rbp 56)))
                                         (set! r15 rax)
                                         (set! r15 fv0)
                                         (begin
                                           (set! rbp (- rbp 56))
                                           (return-point L.rp.6
                                                         (begin
                                                           (set! fv7 fv3)
                                                           (set! r9 fv0)
                                                           (set! r8 fv4)
                                                           (set! rcx -9223372036854775808)
                                                           (set! rdx fv2)
                                                           (set! rsi 1644735104)
                                                           (set! rdi fv3)
                                                           (set! r15 L.rp.6)
                                                           (jump L.func.2.3)))
                                           (set! rbp (+ rbp 56)))
                                         (set! r15 rax)
                                         (set! r14 fv6)
                                         (set! r14 (- r14 fv6))
                                         (set! r14 r14)
                                         (if (= fv6 r15)
                                             (set! r14 r15)
                                             (set! r14 fv6))
                                         (set! fv0 r15)
                                         (set! r9 -9223372036854775808)
                                         (set! r8 fv3)
                                         (set! rcx r14)
                                         (set! rdx fv2)
                                         (set! rsi fv2)
                                         (set! rdi r15)
                                         (set! r15 fv1)
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
                                   (set! r8 fv0)
                                   (set! fv0 9223372036854775807)
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
  (replace-with-syntax-rule '(module (define L.func.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (set! r15 rdi)
                                         (set! fv2 rsi)
                                         (set! fv3 rdx)
                                         (set! fv4 rcx)
                                         (set! fv1 r8)
                                         (if (begin
                                               (set! r14 fv3)
                                               (if (<= fv4 fv1)
                                                   (set! r14 fv4)
                                                   (set! r14 fv1))
                                               (begin
                                                 (begin
                                                   (set! rbp (- rbp 40))
                                                   (return-point L.rp.3
                                                                 (begin
                                                                   (set! r8 fv1)
                                                                   (set! rcx r15)
                                                                   (set! rdx r15)
                                                                   (set! rsi fv3)
                                                                   (set! rdi 1)
                                                                   (set! r15 L.rp.3)
                                                                   (jump L.func.0.1)))
                                                   (set! rbp (+ rbp 40)))
                                                 (set! r15 rax))
                                               (false))
                                             (begin
                                               (set! r8 0)
                                               (set! rcx fv3)
                                               (set! rdx 1603961181)
                                               (set! rsi fv2)
                                               (set! rdi fv1)
                                               (set! r15 fv0)
                                               (jump L.func.0.1))
                                             (begin
                                               (set! r9 fv4)
                                               (set! r8 fv1)
                                               (set! rcx fv2)
                                               (set! rdx fv1)
                                               (set! rsi -9223372036854775808)
                                               (set! rdi fv2)
                                               (set! r15 fv0)
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
                                            (>= r13 0)))
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
  (replace-with-syntax-rule '(module (define L.proc.0.1
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
                                   (set! fv1 r15)
                                   (set! fv4 rdi)
                                   (set! r14 rsi)
                                   (set! r15 rdx)
                                   (set! fv3 rcx)
                                   (set! r13 r8)
                                   (set! r9 r9)
                                   (set! fv2 fv0)
                                   (if (>= fv3 fv2)
                                       (set! r15 r14)
                                       (begin
                                         (begin
                                           (set! rbp (- rbp 40))
                                           (return-point L.rp.4
                                                         (begin
                                                           (set! fv5 1783645727)
                                                           (set! r9 r9)
                                                           (set! r8 fv3)
                                                           (set! rcx r13)
                                                           (set! rdx 0)
                                                           (set! rsi r15)
                                                           (set! rdi 1)
                                                           (set! r15 L.rp.4)
                                                           (jump L.x.2.3)))
                                           (set! rbp (+ rbp 40)))
                                         (set! r15 rax)))
                                   (set! r15 fv3)
                                   (set! r15 (* r15 fv3))
                                   (set! r15 r15)
                                   (set! fv0 fv3)
                                   (set! r9 fv4)
                                   (set! r8 -922337918)
                                   (set! rcx fv2)
                                   (set! rdx fv2)
                                   (set! rsi fv3)
                                   (set! rdi fv2)
                                   (set! r15 fv1)
                                   (jump L.x.2.3)))
                               (begin
                                 (set! r15 r15)
                                 (set! r14 0)
                                 (set! r13 1029279872)
                                 (set! rax r14)
                                 (jump r15))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (if (begin
                                                 (set! r14 1)
                                                 (set! r13 -1606724555)
                                                 (= r14 r14))
                                               (begin
                                                 (set! r14 1)
                                                 (set! r13 1)
                                                 (set! r13 -9223372036854775808)
                                                 (<= r14 r14))
                                               (begin
                                                 (begin
                                                   (set! r14 -1879829070)
                                                   (!= r14 1981475003))))
                                           (begin
                                             (set! r14 -634246165)
                                             (set! r14 (- r14 -684848771))
                                             (set! rax r14)
                                             (jump r15))
                                           (begin
                                             (set! rax 0)
                                             (jump r15))))))
  (replace-with-syntax-rule '(module (define L.func.0.1
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
  (replace-with-syntax-rule '(module (begin
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
  (replace-with-syntax-rule '(module (define L.proc.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (set! fv3 rdi)
                                         (set! fv2 rsi)
                                         (set! fv1 rdx)
                                         (begin
                                           (set! rbp (- rbp 56))
                                           (return-point L.rp.2
                                                         (begin
                                                           (set! rdx fv1)
                                                           (set! rsi fv1)
                                                           (set! rdi 9223372036854775807)
                                                           (set! r15 L.rp.2)
                                                           (jump L.proc.0.1)))
                                           (set! rbp (+ rbp 56)))
                                         (set! fv5 rax)
                                         (begin
                                           (set! rbp (- rbp 56))
                                           (return-point L.rp.3
                                                         (begin
                                                           (set! rdx fv3)
                                                           (set! rsi fv1)
                                                           (set! rdi fv3)
                                                           (set! r15 L.rp.3)
                                                           (jump L.proc.0.1)))
                                           (set! rbp (+ rbp 56)))
                                         (set! fv4 rax)
                                         (begin
                                           (set! rbp (- rbp 56))
                                           (return-point L.rp.4
                                                         (begin
                                                           (set! rdx fv3)
                                                           (set! rsi fv1)
                                                           (set! rdi fv1)
                                                           (set! r15 L.rp.4)
                                                           (jump L.proc.0.1)))
                                           (set! rbp (+ rbp 56)))
                                         (set! fv3 rax)
                                         (set! r15 fv2)
                                         (begin
                                           (set! rbp (- rbp 56))
                                           (return-point L.rp.5
                                                         (begin
                                                           (set! rdx fv2)
                                                           (set! rsi fv1)
                                                           (set! rdi fv1)
                                                           (set! r15 L.rp.5)
                                                           (jump L.proc.0.1)))
                                           (set! rbp (+ rbp 56)))
                                         (set! r15 rax)
                                         (begin
                                           (set! rbp (- rbp 56))
                                           (return-point L.rp.6
                                                         (begin
                                                           (set! rdx fv3)
                                                           (set! rsi r15)
                                                           (set! rdi r15)
                                                           (set! r15 L.rp.6)
                                                           (jump L.proc.0.1)))
                                           (set! rbp (+ rbp 56)))
                                         (set! r15 rax)
                                         (if (> r15 fv1)
                                             (if (>= fv5 fv5)
                                                 (begin
                                                   (set! rax fv1)
                                                   (jump fv0))
                                                 (begin
                                                   (set! rax r15)
                                                   (jump fv0)))
                                             (begin
                                               (set! r15 -2087609688)
                                               (set! r15 fv5)
                                               (set! rax fv4)
                                               (jump fv0)))))
                                     (begin
                                       (set! r15 r15)
                                       (set! r14 1)
                                       (set! r14 -9223372036854775808)
                                       (set! rax r14)
                                       (jump r15))
                               ))
  (replace-with-syntax-rule '(module (define L.fn.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (if (true)
                                             (begin
                                               (set! rcx 2099518136)
                                               (set! rdx r14)
                                               (set! rsi r14)
                                               (set! rdi r14)
                                               (set! r15 r15)
                                               (jump L.func.2.3))
                                             (begin
                                               (set! rcx r14)
                                               (set! rdx r14)
                                               (set! rsi r14)
                                               (set! rdi r14)
                                               (set! r15 r15)
                                               (jump L.func.2.3)))))
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
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 0)
                                       (set! r14 1)
                                       (set! rax r14)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (define L.func.0.1
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
                                         (if (true)
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
                                                   (jump L.func.0.1)))
                                             (begin
                                               (set! r9 rdi)
                                               (set! r8 r8)
                                               (set! rcx r8)
                                               (set! rdx rdi)
                                               (set! rsi rsi)
                                               (set! rdi r13)
                                               (set! r15 r15)
                                               (jump L.x.1.2)))))
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
  (replace-with-syntax-rule '(module (define L.func.0.1
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
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 -550916464)
                                       (set! r14 9223372036854775807)
                                       (set! rax r14)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (false)
                                           (if (if (begin
                                                     (set! r14 9223372036854775807)
                                                     (< r14 1646335033))
                                                   (begin
                                                     (set! r14 9223372036854775807)
                                                     (>= r14 1))
                                                   (begin
                                                     (set! r14 9223372036854775807)
                                                     (!= r14 1)))
                                               (if (begin
                                                     (set! r14 -9223372036854775808)
                                                     (!= r14 -9223372036854775808))
                                                   (begin
                                                     (set! rax -9223372036854775808)
                                                     (jump r15))
                                                   (begin
                                                     (set! rax 1282320164)
                                                     (jump r15)))
                                               (begin
                                                 (set! r14 -9223372036854775808)
                                                 (set! rax r14)
                                                 (jump r15)))
                                           (begin
                                             (set! r14 9223372036854775807)
                                             (set! r14 (- r14 1))
                                             (set! rax r14)
                                             (jump r15))))))
  (replace-with-syntax-rule '(module (define L.tmp.0.1
                                       (begin
                                         (set! fv0 r15)
                                         (set! fv2 rdi)
                                         (set! fv1 rsi)
                                         (set! r15 rdx)
                                         (set! fv3 rcx)
                                         (begin
                                           (set! rbp (- rbp 32))
                                           (return-point L.rp.3
                                                         (begin
                                                           (set! rcx fv2)
                                                           (set! rdx fv3)
                                                           (set! rsi fv1)
                                                           (set! rdi fv1)
                                                           (set! r15 L.rp.3)
                                                           (jump L.tmp.0.1)))
                                           (set! rbp (+ rbp 32)))
                                         (set! r15 rax)
                                         (set! r15 fv1)
                                         (set! r15 (- r15 fv3))
                                         (set! r15 r15)
                                         (set! r15 fv1)
                                         (set! r15 1)
                                         (set! r15 fv3)
                                         (set! r15 fv2)
                                         (begin
                                           (set! rbp (- rbp 32))
                                           (return-point L.rp.4
                                                         (begin
                                                           (set! rdx fv2)
                                                           (set! rsi 9223372036854775807)
                                                           (set! rdi fv3)
                                                           (set! r15 L.rp.4)
                                                           (jump L.x.1.2)))
                                           (set! rbp (+ rbp 32)))
                                         (set! r15 rax)
                                         (set! rdx fv1)
                                         (set! rsi fv1)
                                         (set! rdi -9223372036854775808)
                                         (set! r15 fv0)
                                         (jump L.x.1.2)))
                                     (define L.x.1.2
                                       (begin
                                         (set! r15 r15)
                                         (set! r9 rdi)
                                         (set! r14 rsi)
                                         (set! r13 rdx)
                                         (if (false)
                                             (begin
                                               (set! rdx r14)
                                               (set! rsi r13)
                                               (set! rdi 9223372036854775807)
                                               (set! r15 r15)
                                               (jump L.x.1.2))
                                             (if (false)
                                                 (begin
                                                   (set! rcx r9)
                                                   (set! rdx r14)
                                                   (set! rsi r9)
                                                   (set! rdi r14)
                                                   (set! r15 r15)
                                                   (jump L.tmp.0.1))
                                                 (begin
                                                   (set! rdx r13)
                                                   (set! rsi 580696126)
                                                   (set! rdi r13)
                                                   (set! r15 r15)
                                                   (jump L.x.1.2))))))
                               (begin
                                 (set! r15 r15)
                                 (if (begin
                                       (set! r14 9223372036854775807)
                                       (<= r14 9223372036854775807))
                                     (begin
                                       (set! rax -1677147892)
                                       (jump r15))
                                     (begin
                                       (set! rax 874915829)
                                       (jump r15))))))
  (replace-with-syntax-rule '(module (define L.proc.0.1
                                       (begin
                                         (set! fv1 r15)
                                         (set! fv5 rdi)
                                         (set! fv3 rsi)
                                         (set! fv6 rdx)
                                         (set! r15 rcx)
                                         (set! fv4 r8)
                                         (set! fv2 r9)
                                         (set! fv0 fv0)
                                         (if (not (> fv0 -727829088))
                                             (begin
                                               (set! r14 fv5)
                                               (begin
                                                 (set! rbp (- rbp 56))
                                                 (return-point L.rp.4
                                                               (begin
                                                                 (set! fv7 fv5)
                                                                 (set! r9 fv5)
                                                                 (set! r8 r15)
                                                                 (set! rcx fv3)
                                                                 (set! rdx fv6)
                                                                 (set! rsi fv4)
                                                                 (set! rdi fv3)
                                                                 (set! r15 L.rp.4)
                                                                 (jump L.proc.0.1)))
                                                 (set! rbp (+ rbp 56)))
                                               (set! r15 rax)
                                               (begin
                                                 (set! rbp (- rbp 56))
                                                 (return-point L.rp.5
                                                               (begin
                                                                 (set! r9 fv0)
                                                                 (set! r8 -9223372036854775808)
                                                                 (set! rcx fv4)
                                                                 (set! rdx 1)
                                                                 (set! rsi fv5)
                                                                 (set! rdi fv6)
                                                                 (set! r15 L.rp.5)
                                                                 (jump L.fn.1.2)))
                                                 (set! rbp (+ rbp 56)))
                                               (set! r15 rax)
                                               (set! r15 fv3)
                                               (set! rax fv2)
                                               (jump fv1))
                                             (begin
                                               (set! rax -774243080)
                                               (jump fv1)))))
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
                                       (< r14 9223372036854775807))
                                     (begin
                                       (set! rax 0)
                                       (jump r15))
                                     (begin
                                       (set! rax 0)
                                       (jump r15))))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 -1762920629)
                                       (set! r14 1)
                                       (set! r14 9223372036854775807)
                                       (set! rax 0)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (define L.proc.0.1
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
                                             (!= r14 1))
                                           (begin
                                             (set! rax -9223372036854775808)
                                             (jump r15))
                                           (begin
                                             (set! rax 717010255)
                                             (jump r15))))
                               ))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (true)
                                           (if (not (begin
                                                      (set! r14 0)
                                                      (= r14 1)))
                                               (if (begin
                                                     (set! r14 -9223372036854775808)
                                                     (>= r14 -1744096882))
                                                   (begin
                                                     (set! rax 0)
                                                     (jump r15))
                                                   (begin
                                                     (set! rax 9223372036854775807)
                                                     (jump r15)))
                                               (if (begin
                                                     (set! r14 -9223372036854775808)
                                                     (< r14 0))
                                                   (begin
                                                     (set! rax 1)
                                                     (jump r15))
                                                   (begin
                                                     (set! rax 9223372036854775807)
                                                     (jump r15))))
                                           (if (false)
                                               (begin
                                                 (set! r14 1032709229)
                                                 (set! r13 1)
                                                 (set! rax r14)
                                                 (jump r15))
                                               (begin
                                                 (set! r14 9223372036854775807)
                                                 (set! rax r14)
                                                 (jump r15)))))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (begin
                                             (set! r14 0)
                                             (< r14 9223372036854775807))
                                           (begin
                                             (set! rax 1620518798)
                                             (jump r15))
                                           (if (begin
                                                 (set! r14 0)
                                                 (!= r14 9223372036854775807))
                                               (begin
                                                 (set! rax 0)
                                                 (jump r15))
                                               (begin
                                                 (set! rax -9223372036854775808)
                                                 (jump r15)))))))
  (replace-with-syntax-rule '(module (define L.func.0.1
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
                                         (if (false)
                                             (begin
                                               (set! r9 r9)
                                               (set! r8 r13)
                                               (set! rcx 0)
                                               (set! rdx r14)
                                               (set! rsi r14)
                                               (set! rdi r13)
                                               (set! r15 r15)
                                               (jump L.tmp.2.3))
                                             (begin
                                               (set! rdx r13)
                                               (set! rsi 9223372036854775807)
                                               (set! rdi r14)
                                               (set! r15 r15)
                                               (jump L.tmp.1.2)))))
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
                                       (= r14 9223372036854775807))
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump r15))
                                     (begin
                                       (set! rax 1)
                                       (jump r15))))))
  (replace-with-syntax-rule '(module (define L.fn.0.1
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
  (replace-with-syntax-rule '(module (define L.func.0.1
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
  (replace-with-syntax-rule '(module (define L.func.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r14 rdi)
                                         (if (if (true)
                                                 (not (> r14 r14))
                                                 (begin
                                                   (set! r13 2020417677)
                                                   (>= r13 -9223372036854775808)))
                                             (if (true)
                                                 (if (= r14 r14)
                                                     (begin
                                                       (set! rax r14)
                                                       (jump r15))
                                                     (begin
                                                       (set! rax r14)
                                                       (jump r15)))
                                                 (begin
                                                   (set! rdi r14)
                                                   (set! r15 r15)
                                                   (jump L.func.0.1)))
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
  (replace-with-syntax-rule '(module (define L.proc.0.1
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
                                   (set! fv0 r15)
                                   (set! fv1 rdi)
                                   (begin
                                     (set! rbp (- rbp 16))
                                     (return-point L.rp.4
                                                   (begin
                                                     (set! rcx fv1)
                                                     (set! rdx fv1)
                                                     (set! rsi fv1)
                                                     (set! rdi fv1)
                                                     (set! r15 L.rp.4)
                                                     (jump L.proc.0.1)))
                                     (set! rbp (+ rbp 16)))
                                   (set! r15 rax)
                                   (set! r15 r15)
                                   (set! r15 (- r15 r15))
                                   (set! r15 r15)
                                   (if (<= r15 fv1)
                                       (set! r14 r15)
                                       (set! r14 fv1))
                                   (set! r15 r15)
                                   (set! r14 fv1)
                                   (set! r14 r15)
                                   (set! r15 r15)
                                   (set! r15 fv1)
                                   (set! rdi r15)
                                   (set! r15 fv0)
                                   (jump L.x.2.3)))
                               (begin
                                 (set! r15 r15)
                                 (set! r14 1830309714)
                                 (set! r13 -9223372036854775808)
                                 (set! r13 -9223372036854775808)
                                 (set! rax r14)
                                 (jump r15))))
  (replace-with-syntax-rule '(module (define L.func.0.1
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
                                         (set! fv0 r15)
                                         (set! r15 -620373304)
                                         (set! r15 (- r15 -68719063))
                                         (set! r15 r15)
                                         (set! fv1 0)
                                         (begin
                                           (set! rbp (- rbp 16))
                                           (return-point L.rp.4
                                                         (begin
                                                           (set! r15 L.rp.4)
                                                           (jump L.func.1.2)))
                                           (set! rbp (+ rbp 16)))
                                         (set! r15 rax)
                                         (set! rax fv1)
                                         (jump fv0)))
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
  (replace-with-syntax-rule '(module (define L.x.0.1
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
                                            (= r14 -844906965)))
                                     (begin
                                       (set! r14 996590913)
                                       (set! r13 299367411)
                                       (set! r13 -9223372036854775808)
                                       (set! rax r14)
                                       (jump r15))
                                     (if (begin
                                           (set! r14 894536270)
                                           (> r14 1910216157))
                                         (begin
                                           (set! rax 1)
                                           (jump r15))
                                         (begin
                                           (set! rax 1)
                                           (jump r15)))))))
  (replace-with-syntax-rule '(module (define L.tmp.0.1
                                       (begin
                                         (set! r15 r15)
                                         (set! r13 rdi)
                                         (set! rdi rsi)
                                         (set! r14 rdx)
                                         (set! rbx rcx)
                                         (set! r9 r8)
                                         (if (<= rdi 9223372036854775807)
                                             (if (true)
                                                 (begin
                                                   (set! fv0 rbx)
                                                   (set! r9 -9223372036854775808)
                                                   (set! r8 1)
                                                   (set! rcx r14)
                                                   (set! rdx r13)
                                                   (set! rsi r14)
                                                   (set! rdi rbx)
                                                   (set! r15 r15)
                                                   (jump L.tmp.1.2))
                                                 (begin
                                                   (set! fv0 r13)
                                                   (set! r9 r9)
                                                   (set! r8 rbx)
                                                   (set! rcx rbx)
                                                   (set! rdx rdi)
                                                   (set! rsi r14)
                                                   (set! rdi rdi)
                                                   (set! r15 r15)
                                                   (jump L.tmp.1.2)))
                                             (begin
                                               (set! r9 r9)
                                               (set! r13 r13)
                                               (set! r14 r14)
                                               (set! rax r14)
                                               (jump r15)))))
                                     (define L.tmp.1.2
                                       (begin
                                         (set! fv1 r15)
                                         (set! r15 rdi)
                                         (set! fv3 rsi)
                                         (set! r15 rdx)
                                         (set! r14 rcx)
                                         (set! fv5 r8)
                                         (set! fv2 r9)
                                         (set! fv4 fv0)
                                         (if (not (begin
                                                    (set! r13 1242010444)
                                                    (> r13 r15)))
                                             (begin
                                               (begin
                                                 (set! rbp (- rbp 56))
                                                 (return-point L.rp.3
                                                               (begin
                                                                 (set! r8 fv2)
                                                                 (set! rcx 1)
                                                                 (set! rdx r14)
                                                                 (set! rsi fv2)
                                                                 (set! rdi fv5)
                                                                 (set! r15 L.rp.3)
                                                                 (jump L.tmp.0.1)))
                                                 (set! rbp (+ rbp 56)))
                                               (set! fv6 rax))
                                             (begin
                                               (begin
                                                 (set! rbp (- rbp 56))
                                                 (return-point L.rp.4
                                                               (begin
                                                                 (set! r8 r14)
                                                                 (set! rcx r14)
                                                                 (set! rdx fv3)
                                                                 (set! rsi r15)
                                                                 (set! rdi r15)
                                                                 (set! r15 L.rp.4)
                                                                 (jump L.tmp.0.1)))
                                                 (set! rbp (+ rbp 56)))
                                               (set! fv6 rax)))
                                         (set! r15 fv4)
                                         (set! r15 (* r15 fv3))
                                         (set! r15 r15)
                                         (begin
                                           (set! rbp (- rbp 56))
                                           (return-point L.rp.5
                                                         (begin
                                                           (set! r8 fv5)
                                                           (set! rcx fv5)
                                                           (set! rdx 0)
                                                           (set! rsi fv3)
                                                           (set! rdi fv3)
                                                           (set! r15 L.rp.5)
                                                           (jump L.tmp.0.1)))
                                           (set! rbp (+ rbp 56)))
                                         (set! r15 rax)
                                         (set! fv0 fv2)
                                         (set! r9 fv6)
                                         (set! r8 fv4)
                                         (set! rcx r15)
                                         (set! rdx 1)
                                         (set! rsi fv3)
                                         (set! rdi fv2)
                                         (set! r15 fv1)
                                         (jump L.tmp.1.2)))
                               (begin
                                 (set! r15 r15)
                                 (if (not (begin
                                            (set! r14 1973720366)
                                            (< r14 1864083813)))
                                     (begin
                                       (set! rax 9223372036854775807)
                                       (jump r15))
                                     (begin
                                       (set! fv0 379193781)
                                       (set! r9 726597669)
                                       (set! r8 -264137160)
                                       (set! rcx -1022801227)
                                       (set! rdx 501537014)
                                       (set! rsi 9223372036854775807)
                                       (set! rdi 9223372036854775807)
                                       (set! r15 r15)
                                       (jump L.tmp.1.2))))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r9 1521957632)
                                       (set! r13 -9223372036854775808)
                                       (set! r14 -9223372036854775808)
                                       (if (false)
                                           (if (!= r13 r13)
                                               (begin
                                                 (set! rax r14)
                                                 (jump r15))
                                               (begin
                                                 (set! rax r13)
                                                 (jump r15)))
                                           (if (> r9 -755834168)
                                               (begin
                                                 (set! rax 0)
                                                 (jump r15))
                                               (begin
                                                 (set! rax r13)
                                                 (jump r15)))))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 -9223372036854775808)
                                       (set! r13 0)
                                       (set! r14 r14)
                                       (set! r14 r14)
                                       (set! r13 r14)
                                       (set! r14 r14)
                                       (if (> r14 r14)
                                           (set! r14 r14)
                                           (set! r14 r14))
                                       (set! r13 r13)
                                       (set! rax r14)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 1)
                                       (if (= r14 r14)
                                           (begin
                                             (set! r14 r14)
                                             (set! r14 r14)
                                             (set! r14 r14)
                                             (set! r14 r14))
                                           (begin
                                             (set! r14 r14)
                                             (set! r14 r14)
                                             (set! r14 r14)))
                                       (set! r13 r14)
                                       (set! r13 r14)
                                       (set! r13 (+ r13 r14))
                                       (set! r13 r13)
                                       (set! r13 r14)
                                       (set! r13 1648274049)
                                       (set! rax r14)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (define L.func.0.1
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
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (begin
                                             (set! r14 -9223372036854775808)
                                             (> r14 526950868))
                                           (begin
                                             (set! rax -9223372036854775808)
                                             (jump r15))
                                           (begin
                                             (set! rax 9223372036854775807)
                                             (jump r15))))))
  (replace-with-syntax-rule '(module (define L.fn.0.1
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
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (if (begin
                                                 (set! r14 9223372036854775807)
                                                 (!= r14 2124101395))
                                               (true)
                                               (not (begin
                                                      (set! r14 9223372036854775807)
                                                      (<= r14 0))))
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
                                             (if (> r14 r14)
                                                 (begin
                                                   (set! rax r14)
                                                   (jump r15))
                                                 (begin
                                                   (set! rax r14)
                                                   (jump r15))))))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (if (begin
                                             (set! r14 1069510162)
                                             (>= r14 -9223372036854775808))
                                           (begin
                                             (set! rax 1)
                                             (jump r15))
                                           (begin
                                             (set! rax 323863587)
                                             (jump r15))))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! r14 379335310)
                                       (set! r14 (* r14 0))
                                       (set! rax r14)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (begin
                                       (set! r15 r15)
                                       (set! rax 0)
                                       (jump r15))))
  (replace-with-syntax-rule '(module (begin
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
                          (if (true)
                              (begin
                                (set! r15 1)
                                (set! r15 r15))
                              (begin
                                (set! r15 -9223372036854775808)
                                (set! r15 (* r15 1806293504))
                                (set! r15 r15)))
                          (if (begin
                                (set! r14 1)
                                (> r14 0))
                              (set! r15 156890122)
                              (set! r15 r15))
                          (halt 0)))
                      (begin
                        (set! rdi -1860620182)
                        (jump L.L.tmp.1.2.5))))
  (check-by-interp '(module (define L.L.tmp.0.1.4
                              (if (begin
                                    (set! r15 9223372036854775807)
                                    (>= r15 -1020514810))
                                  (jump L.L.x.2.3.6)
                                  (begin
                                    (set! r15 1)
                                    (set! r15 (* r15 0))
                                    (set! r15 r15)
                                    (halt r15))))
                            (define L.L.func.1.2.5
                              (begin
                                (set! r14 -9223372036854775808)
                                (if (not (begin
                                           (set! r15 9223372036854775807)
                                           (> r15 0)))
                                    (halt 1309557052)
                                    (halt r14))))
                      (define L.L.x.2.3.6
                        (if (if (true)
                                (not (begin
                                       (set! r15 0)
                                       (> r15 1)))
                                (true))
                            (if (begin
                                  (set! r15 0)
                                  (> r15 0))
                                (if (begin
                                      (set! r15 9223372036854775807)
                                      (< r15 9223372036854775807))
                                    (halt 9223372036854775807)
                                    (halt -260353756))
                                (begin
                                  (set! r15 0)
                                  (halt r15)))
                            (begin
                              (if (begin
                                    (set! r15 -302047143)
                                    (!= r15 0))
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
                        (halt r15))))
  (check-by-interp '(module (define L.L.proc.0.1.4
                              (begin
                                (set! r15 rdi)
                                (jump L.L.func.1.2.5)))
                            (define L.L.func.1.2.5
                              (begin
                                (set! r15 1)
                                (set! r15 (* r15 0))
                                (set! r15 r15)
                                (halt r15)))
                      (define L.L.fn.2.3.6
                        (begin
                          (set! r15 rdi)
                          (if (true)
                              (begin
                                (if (begin
                                      (set! r15 -2033705372)
                                      (<= r15 965540822))
                                    (set! r15 -1853172774)
                                    (set! r15 1133506028))
                                (set! r15 1)
                                (halt 1236904416))
                              (jump L.L.func.1.2.5))))
                      (begin
                        (set! rdi 1)
                        (jump L.L.proc.0.1.4))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (if (false)
                                    (set! r15 1)
                                    (begin
                                      (set! r15 1)
                                      (set! r15 1)))
                                (if (if (begin
                                          (set! r14 9223372036854775807)
                                          (>= r14 -9223372036854775808))
                                        (begin
                                          (set! r14 -248968641)
                                          (= r14 9223372036854775807))
                                        (!= r15 -9223372036854775808))
                                    (begin
                                      (set! r15 r15)
                                      (halt 1622965009))
                                    (begin
                                      (set! r15 r15)
                                      (halt r15)))))
                            (if (false)
                                (if (begin
                                      (set! r15 995853130)
                                      (>= r15 1))
                                    (halt 1)
                                    (halt -9223372036854775808))
                                (jump L.fn.0.1))
                      ))
  (check-by-interp '(module (begin
                              (set! r15 -9223372036854775808)
                              (set! r15 (+ r15 -1465538260))
                              (set! r15 r15)
                              (halt r15))))
  (check-by-interp '(module (define L.fn.0.1
                              (begin
                                (set! r15 1)
                                (set! r15 (+ r15 9223372036854775807))
                                (set! r15 r15)
                                (set! r15 r15)
                                (set! r14 r15)
                                (halt r15)))
                            (define L.func.1.2
                              (begin
                                (if (begin
                                      (set! r15 1)
                                      (begin
                                        (set! r14 1)
                                        (< r14 r15)))
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
                        (halt r15))))
  (check-by-interp '(module (define L.x.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (jump L.tmp.1.2)))
                            (define L.tmp.1.2
                              (if (if (if (begin
                                            (set! r15 -765445006)
                                            (<= r15 0))
                                          (begin
                                            (set! r15 0)
                                            (!= r15 -7399083))
                                          (begin
                                            (set! r15 9223372036854775807)
                                            (<= r15 1)))
                                      (false)
                                      (true))
                                  (begin
                                    (set! r15 -9223372036854775808)
                                    (set! r15 r15)
                                    (if (> r15 r15)
                                        (halt -9223372036854775808)
                                        (halt r15)))
                                  (begin
                                    (if (begin
                                          (set! r15 1)
                                          (>= r15 0))
                                        (set! r15 -9223372036854775808)
                                        (set! r15 -9223372036854775808))
                                    (if (begin
                                          (set! r14 0)
                                          (= r14 r15))
                                        (halt 0)
                                        (halt 9223372036854775807)))))
                      (define L.func.2.3
                        (begin
                          (set! r15 rdi)
                          (set! r15 rsi)
                          (jump L.tmp.1.2)))
                      (if (begin
                            (set! r15 0)
                            (<= r15 1))
                          (halt -1271132888)
                          (halt 2101306416))))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 rdi)
                                (if (false)
                                    (begin
                                      (set! r15 r15)
                                      (set! r14 1733388107))
                                    (begin
                                      (set! r14 -818241658)
                                      (set! r14 r14)))
                                (set! r13 -1769976594)
                                (set! r13 (* r13 r14))
                                (set! r14 r13)
                                (if (!= r15 r15)
                                    (halt 1)
                                    (halt r15))))
                            (if (begin
                                  (set! r15 0)
                                  (<= r15 0))
                                (halt 1764584349)
                                (halt -9223372036854775808))
                      ))
  (check-by-interp '(module (define L.proc.0.1
                              (begin
                                (set! r15 rdi)
                                (if (not (false))
                                    (jump L.x.1.2)
                                    (begin
                                      (set! r15 r15)
                                      (set! r14 9223372036854775807)
                                      (set! r14 -9223372036854775808)
                                      (set! r14 (+ r14 r15))
                                      (set! r15 r14)
                                      (halt r15)))))
                            (define L.x.1.2 (halt 1))
                      (begin
                        (set! r15 453798193)
                        (set! r14 r15)
                        (if (begin
                              (set! r15 9223372036854775807)
                              (>= r15 r14))
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
                                    (if (true)
                                        (if (< r15 -9223372036854775808)
                                            (halt r15)
                                            (halt r15))
                                        (if (begin
                                              (set! r14 -9223372036854775808)
                                              (= r14 r15))
                                            (halt r15)
                                            (halt r15)))
                                    (jump L.proc.1.2))))
                            (define L.proc.1.2
                              (begin
                                (set! rdi 954069433)
                                (jump L.func.0.1)))
                      (if (false)
                          (begin
                            (set! r15 1337690701)
                            (set! r15 (* r15 9223372036854775807))
                            (set! r15 r15)
                            (halt r15))
                          (jump L.proc.1.2))))
  (check-by-interp '(module (if (not (begin
                                       (set! r15 1)
                                       (> r15 9223372036854775807)))
                                (if (begin
                                      (set! r15 1)
                                      (>= r15 1197468889))
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
                              (halt r15))
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
                                      (halt r15))
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
                                    (halt r14)
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
                                     (>= r15 -1400373009))))
                            (begin
                              (set! r15 -167927521)
                              (set! r15 (+ r15 1))
                              (set! r15 r15)
                              (halt r15))
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
                              (if (!= r15 1)
                                  (halt 9223372036854775807)
                                  (halt 2063023986)))))
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
                                      (halt r15))
                                    (begin
                                      (set! r14 0)
                                      (set! r14 (* r14 r15))
                                      (set! r14 r14)
                                      (if (!= r14 -9223372036854775808)
                                          (halt r15)
                                          (halt 0))))))
                            (if (begin
                                  (set! r15 9223372036854775807)
                                  (= r15 -315897602))
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
                                      (!= r13 r14))
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
                                (halt r15)))
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
                          (halt r15)))
                      (begin
                        (set! r15 979460199)
                        (set! r15 (+ r15 -1697959716))
                        (set! r15 r15)
                        (halt r15))))
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
                                (if (true)
                                    (begin
                                      (set! r15 r14)
                                      (set! r15 (* r15 9223372036854775807))
                                      (set! r15 r15)
                                      (halt r15))
                                    (if (begin
                                          (set! r14 1)
                                          (<= r13 r15))
                                        (begin
                                          (set! r15 -9223372036854775808)
                                          (halt r15))
                                        (begin
                                          (set! r15 1)
                                          (halt 1))))))
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
                                (< r9 1))
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
                                    (> r14 882297114))
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
  (check-by-interp '(module (if (true)
                                (begin
                                  (set! r15 1)
                                  (set! r15 (+ r15 -9223372036854775808))
                                  (set! r15 r15)
                                  (halt r15))
                                (if (begin
                                      (set! r15 1383245321)
                                      (> r15 0))
                                    (halt 0)
                                    (halt 1)))))
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
                                      (>= r15 r14))
                                    (halt -9223372036854775808)
                                    (halt r14))))
                      (define L.fn.2.3
                        (begin
                          (set! r15 1)
                          (set! r15 (+ r15 1))
                          (set! r15 r15)
                          (if (false)
                              (halt r15)
                              (begin
                                (set! r15 r15)
                                (halt 1969054361)))))
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
                          (if (if (true)
                                  (begin
                                    (set! r15 r15)
                                    (begin
                                      (set! r14 -1497437069)
                                      (> r14 -9223372036854775808)))
                                  (not (begin
                                         (set! r14 -1101838227)
                                         (!= r14 -1416967818))))
                              (begin
                                (set! r15 r15)
                                (set! r15 (+ r15 r15))
                                (set! r15 r15)
                                (set! r15 0)
                                (halt r15))
                              (halt 1))))
                      (define L.fn.7.8
                        (if (true)
                            (if (not (begin
                                       (set! r15 0)
                                       (> r15 100011461)))
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
                                      (= r15 471889533))
                                    (halt 1)
                                    (halt 0)))
                            (if (if (begin
                                      (set! r15 1)
                                      (>= r15 0))
                                    (begin
                                      (set! r15 0)
                                      (>= r15 -9223372036854775808))
                                    (begin
                                      (set! r15 9223372036854775807)
                                      (> r15 0)))
                                (jump L.fn.7.8)
                                (if (begin
                                      (set! r15 1)
                                      (> r15 1))
                                    (halt -444155079)
                                    (halt 9223372036854775807)))))
                      (if (begin
                            (if (begin
                                  (set! r15 -9223372036854775808)
                                  (true))
                                (begin
                                  (if (begin
                                        (set! r15 9223372036854775807)
                                        (> r15 0))
                                      (set! r15 -1444900091)
                                      (set! r15 -9223372036854775808))
                                  (set! r15 r15))
                                (if (true)
                                    (begin
                                      (set! r15 9223372036854775807)
                                      (set! r15 r15))
                                    (if (begin
                                          (set! r15 -9223372036854775808)
                                          (= r15 1173781558))
                                        (set! r15 0)
                                        (set! r15 1))))
                            (if (true)
                                (begin
                                  (set! r15 0)
                                  (true))
                                (begin
                                  (set! r14 858519747)
                                  (< r14 r15))))
                          (halt 1)
                          (if (begin
                                (set! r15 1)
                                (< r15 -1323259230))
                              (jump L.fn.2.3)
                              (jump L.fn.2.3)))))
  ;; !!!

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
                               (halt 0))))))
