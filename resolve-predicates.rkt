#lang racket

(require cpsc411/compiler-lib)
(provide resolve-predicates)

;;
;   p	 	::=	 	(module b ... b)

;   b	 	::=	 	(define label tail)

;   pred	 	::=	 	(relop loc opand)
;  	 	|	 	(true)
;  	 	|	 	(false)
;  	 	|	 	(not pred)

;   tail	 	::=	 	(halt opand)
;  	 	|	 	(jump trg)
;  	 	|	 	(begin effect ... tail)
;  	 	|	 	(if -pred +(relop loc opand) (jump trg) (jump trg))

;   effect	 	::=	 	(set! loc triv)
;  	 	|	 	(set! loc_1 (binop loc_1 opand))

;   opand	 	::=	 	int64
;  	 	|	 	loc

;   loc	 	::=	 	reg
;  	 	|	 	fvar
;; block-pred-lang-v4 ->  block-asm-lang-v4
;; Compile the Block-pred-lang v4 to Block-asm-lang v4 by manipulating the branches of
;; if statements to resolve branches.
(define (resolve-predicates p)
  (match p
    [`(module ,b* ...
        ,b)
     `(module ,@(map resolve-b b*) ,(resolve-b b)
        )]))
(define (resolve-pred pred truecase falsecase)
  (match pred
    [`(,_ ,_ ,_) `(if ,pred ,truecase ,falsecase)]
    [`(true) truecase]
    [`(false) falsecase]
    [`(not ,pred) (resolve-pred pred falsecase truecase)]))
(define (resolve-tail tail)
  (match tail
    [`(halt ,_) tail]
    [`(jump ,_) tail]
    [`(begin
        ,fx* ...
        ,tail)
     `(begin
        ,@fx*
        ,(resolve-tail tail))]
    [`(if ,pred
          (jump ,trg1)
          (jump ,trg2))
     (resolve-pred pred `(jump ,trg1) `(jump ,trg2))]))
(define (resolve-b b)
  (match b
    [`(define ,(? label? label)
        ,tail)
     `(define ,label ,(resolve-tail tail))]))

(module+ test
  (require rackunit
           cpsc411/langs/v5)
  (define-syntax-rule (check func in expected)
    (check-equal? (func in) expected))
  (define-syntax-rule (check-resolve-predicates bpl4 expected)
    (check resolve-predicates bpl4 expected))
  (define-syntax-rule (check-by-interp bpl4)
    (check-equal? (interp-block-pred-lang-v5 bpl5)
                  (interp-block-asm-lang-v4 (resolve-predicates bpl5))))

  ;; !!! Added by Trevor on March 2nd 2026
  (check-by-interp '(module (define L.__main.7
                              (begin
                                (set! rdi -1860620182)
                                (jump L.L.tmp.1.2.5)))
                            (define L.L.func.0.1.4 (halt 0))
                      (define L.L.tmp.1.2.5
                        (begin
                          (set! r15 rdi)
                          (jump L.L.func.0.1.4)))
                      (define L.L.func.2.3.6
                        (begin
                          (set! r15 1)
                          (set! r15 r15)
                          (set! r14 1)
                          (if (true)
                              (jump L.tmp.8)
                              (jump L.tmp.9))))
                      (define L.tmp.8
                        (begin
                          (set! r15 156890122)
                          (jump L.tmp.10)))
                      (define L.tmp.9
                        (begin
                          (set! r15 r15)
                          (jump L.tmp.10)))
                      (define L.tmp.10 (halt 0))))
  (check-by-interp '(module (define L.__main.7
                              (begin
                                (set! r15 -9223372036854775808)
                                (set! r15 (* r15 -9223372036854775808))
                                (set! r15 r15)
                                (set! r15 r15)
                                (set! r15 (+ r15 0))
                                (set! r15 r15)
                                (halt 0)))
                            (define L.L.tmp.0.1.4
                              (begin
                                (set! r15 9223372036854775807)
                                (if (true)
                                    (jump L.__nested.8)
                                    (jump L.__nested.9))))
                      (define L.__nested.8 (jump L.L.x.2.3.6))
                      (define L.__nested.9
                        (begin
                          (set! r15 1)
                          (set! r15 (* r15 0))
                          (set! r15 r15)
                          (halt 0)))
                      (define L.L.func.1.2.5
                        (begin
                          (set! r14 -9223372036854775808)
                          (set! r15 9223372036854775807)
                          (if (true)
                              (jump L.__nested.11)
                              (jump L.__nested.10))))
                      (define L.__nested.10 (halt 1309557052))
                      (define L.__nested.11 (halt -9223372036854775808))
                      (define L.L.x.2.3.6
                        (begin
                          (set! r15 0)
                          (if (false)
                              (jump L.__nested.13)
                              (jump L.__nested.12))))
                      (define L.__nested.16 (halt 9223372036854775807))
                      (define L.__nested.17 (halt -260353756))
                      (define L.__nested.14
                        (begin
                          (set! r15 9223372036854775807)
                          (if (false)
                              (jump L.__nested.16)
                              (jump L.__nested.17))))
                      (define L.__nested.15
                        (begin
                          (set! r15 0)
                          (halt 0)))
                      (define L.__nested.18 (halt r15))
                      (define L.__nested.19 (halt -362331747))
                      (define L.tmp.20
                        (begin
                          (set! r15 9223372036854775807)
                          (jump L.tmp.22)))
                      (define L.tmp.21
                        (begin
                          (set! r15 102036653)
                          (jump L.tmp.22)))
                      (define L.tmp.22
                        (begin
                          (set! r14 0)
                          (if (= r14 r15)
                              (jump L.__nested.18)
                              (jump L.__nested.19))))
                      (define L.__nested.12
                        (begin
                          (set! r15 0)
                          (if (false)
                              (jump L.__nested.14)
                              (jump L.__nested.15))))
                      (define L.__nested.13
                        (begin
                          (set! r15 -302047143)
                          (if (true)
                              (jump L.tmp.20)
                              (jump L.tmp.21))))))
  (check-by-interp '(module (define L.__main.7
                              (begin
                                (set! rdi 1)
                                (jump L.L.proc.0.1.4)))
                            (define L.L.proc.0.1.4
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
                          (set! r15 -2033705372)
                          (if (true)
                              (jump L.tmp.8)
                              (jump L.tmp.9))))
                      (define L.tmp.8
                        (begin
                          (set! r15 -1853172774)
                          (jump L.tmp.10)))
                      (define L.tmp.9
                        (begin
                          (set! r15 1133506028)
                          (jump L.tmp.10)))
                      (define L.tmp.10
                        (begin
                          (set! r15 1)
                          (halt 1236904416)))))
  (check-by-interp '(module (define L.__main.2 (jump L.fn.0.1))
                            (define L.fn.0.1
                              (begin
                                (set! r15 1)
                                (set! r15 1)
                                (set! r14 9223372036854775807)
                                (if (true)
                                    (jump L.tmp.5)
                                    (jump L.tmp.6))))
                      (define L.tmp.5
                        (begin
                          (set! r14 -248968641)
                          (if (false)
                              (jump L.__nested.3)
                              (jump L.__nested.4))))
                      (define L.tmp.6
                        (if (true)
                            (jump L.__nested.3)
                            (jump L.__nested.4)))
                      (define L.__nested.3
                        (begin
                          (set! r15 r15)
                          (halt 1622965009)))
                      (define L.__nested.4
                        (begin
                          (set! r15 r15)
                          (halt 1)))))
  (check-by-interp '(module (define L.__main.1
                              (begin
                                (set! r15 -9223372036854775808)
                                (set! r15 (+ r15 -1465538260))
                                (set! r15 r15)
                                (halt 9223372035389237548)))))
  (check-by-interp '(module (define L.__main.3
                              (begin
                                (set! r15 1)
                                (set! r14 0)
                                (halt 1)))
                            (define L.fn.0.1
                              (begin
                                (set! r15 1)
                                (set! r15 (+ r15 9223372036854775807))
                                (set! r15 r15)
                                (set! r15 r15)
                                (set! r14 r15)
                                (halt -9223372036854775808)))
                      (define L.func.1.2
                        (begin
                          (set! r15 1)
                          (set! r14 1)
                          (if (false)
                              (jump L.tmp.4)
                              (jump L.tmp.5))))
                      (define L.tmp.4
                        (begin
                          (set! r15 406779451)
                          (set! r15 1200977699)
                          (jump L.tmp.6)))
                      (define L.tmp.5
                        (begin
                          (set! r15 0)
                          (set! r15 r15)
                          (jump L.tmp.6)))
                      (define L.tmp.6
                        (begin
                          (set! r15 r15)
                          (set! r15 (* r15 r15))
                          (set! r15 r15)
                          (halt r15)))))
  (check-by-interp '(module (define L.__main.6
                              (begin
                                (set! r15 0)
                                (if (true)
                                    (jump L.__nested.4)
                                    (jump L.__nested.5))))
                            (define L.x.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (jump L.tmp.1.2)))
                      (define L.tmp.1.2
                        (begin
                          (set! r15 -765445006)
                          (if (true)
                              (jump L.tmp.16)
                              (jump L.tmp.17))))
                      (define L.tmp.16
                        (begin
                          (set! r15 0)
                          (if (true)
                              (jump L.tmp.14)
                              (jump L.tmp.15))))
                      (define L.tmp.17
                        (begin
                          (set! r15 9223372036854775807)
                          (if (false)
                              (jump L.tmp.14)
                              (jump L.tmp.15))))
                      (define L.tmp.14
                        (if (false)
                            (jump L.__nested.7)
                            (jump L.__nested.8)))
                      (define L.tmp.15
                        (if (true)
                            (jump L.__nested.7)
                            (jump L.__nested.8)))
                      (define L.__nested.9 (halt 0))
                      (define L.__nested.10 (halt 9223372036854775807))
                      (define L.tmp.11
                        (begin
                          (set! r15 -9223372036854775808)
                          (jump L.tmp.13)))
                      (define L.tmp.12
                        (begin
                          (set! r15 -9223372036854775808)
                          (jump L.tmp.13)))
                      (define L.tmp.13
                        (begin
                          (set! r14 0)
                          (if (false)
                              (jump L.__nested.9)
                              (jump L.__nested.10))))
                      (define L.__nested.7
                        (begin
                          (set! r15 -9223372036854775808)
                          (set! r15 r15)
                          (halt -9223372036854775808)))
                      (define L.__nested.8
                        (begin
                          (set! r15 1)
                          (if (true)
                              (jump L.tmp.11)
                              (jump L.tmp.12))))
                      (define L.func.2.3
                        (begin
                          (set! r15 rdi)
                          (set! r15 rsi)
                          (jump L.tmp.1.2)))
                      (define L.__nested.4 (halt -1271132888))
                      (define L.__nested.5 (halt 2101306416))))
  (check-by-interp '(module (define L.__main.4
                              (begin
                                (set! r15 0)
                                (if (true)
                                    (jump L.__nested.2)
                                    (jump L.__nested.3))))
                            (define L.proc.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r14 -818241658)
                                (set! r14 r14)
                                (set! r13 -1769976594)
                                (set! r13 (* r13 r14))
                                (set! r14 r13)
                                (if (!= r15 r15)
                                    (jump L.__nested.5)
                                    (jump L.__nested.6))))
                      (define L.__nested.5 (halt 1))
                      (define L.__nested.6 (halt r15))
                      (define L.__nested.2 (halt 1764584349))
                      (define L.__nested.3 (halt -9223372036854775808))))
  (check-by-interp '(module (define L.__main.5
                              (begin
                                (set! r15 453798193)
                                (set! r14 r15)
                                (set! r15 9223372036854775807)
                                (if (true)
                                    (jump L.__nested.3)
                                    (jump L.__nested.4))))
                            (define L.proc.0.1
                              (begin
                                (set! r15 rdi)
                                (jump L.x.1.2)))
                      (define L.x.1.2 (halt 1))
                      (define L.__nested.3 (halt 0))
                      (define L.__nested.4 (halt -1617493587))))
  (check-by-interp '(module (define L.__main.3 (jump L.proc.1.2))
                            (define L.func.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r14 9223372036854775807)
                                (set! r14 (* r14 r15))
                                (set! r14 r14)
                                (if (true)
                                    (jump L.__nested.4)
                                    (jump L.__nested.5))))
                      (define L.__nested.6 (halt r15))
                      (define L.__nested.7 (halt r15))
                      (define L.__nested.4
                        (if (< r15 -9223372036854775808)
                            (jump L.__nested.6)
                            (jump L.__nested.7)))
                      (define L.__nested.5 (jump L.proc.1.2))
                      (define L.proc.1.2
                        (begin
                          (set! rdi 954069433)
                          (jump L.func.0.1)))))
  (check-by-interp '(module (define L.__main.5
                              (begin
                                (set! r15 1)
                                (if (false)
                                    (jump L.__nested.2)
                                    (jump L.__nested.1))))
                            (define L.__nested.3 (halt 9223372036854775807))
                      (define L.__nested.4 (halt 1))
                      (define L.__nested.1
                        (begin
                          (set! r15 1)
                          (if (false)
                              (jump L.__nested.3)
                              (jump L.__nested.4))))
                      (define L.__nested.2 (halt 1))))
  (check-by-interp '(module (define L.__main.2
                              (begin
                                (set! r8 0)
                                (set! rcx -9223372036854775808)
                                (set! rdx -808937821)
                                (set! rsi 1)
                                (set! rdi -9223372036854775808)
                                (jump L.func.0.1)))
                            (define L.func.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r15 rdx)
                                (set! r15 rcx)
                                (set! r15 r8)
                                (halt -1458025903)))
                      ))
  (check-by-interp '(module (define L.__main.2
                              (begin
                                (set! r15 0)
                                (halt 0)))
                            (define L.tmp.0.1
                              (begin
                                (set! r14 rdi)
                                (set! r15 rsi)
                                (set! r13 rdx)
                                (set! r13 rcx)
                                (set! r14 r14)
                                (set! r13 -9223372036854775808)
                                (if (<= r13 r15)
                                    (jump L.tmp.7)
                                    (jump L.tmp.8))))
                      (define L.tmp.7
                        (begin
                          (set! r13 -9223372036854775808)
                          (if (>= r13 r14)
                              (jump L.__nested.3)
                              (jump L.__nested.4))))
                      (define L.tmp.8
                        (if (>= r15 2025307007)
                            (jump L.__nested.3)
                            (jump L.__nested.4)))
                      (define L.__nested.5 (halt 9223372036854775807))
                      (define L.__nested.6 (halt 0))
                      (define L.__nested.3
                        (begin
                          (set! r15 r14)
                          (set! r15 (+ r15 9223372036854775807))
                          (set! r15 r15)
                          (halt r15)))
                      (define L.__nested.4
                        (if (<= r15 -9223372036854775808)
                            (jump L.__nested.5)
                            (jump L.__nested.6)))))
  (check-by-interp '(module (define L.__main.4
                              (begin
                                (set! rdi 1840464414)
                                (jump L.x.1.2)))
                            (define L.func.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r14 rsi)
                                (set! r13 0)
                                (if (= r13 r14)
                                    (jump L.__nested.5)
                                    (jump L.__nested.6))))
                      (define L.tmp.11
                        (if (<= r14 r14)
                            (jump L.__nested.7)
                            (jump L.__nested.8)))
                      (define L.tmp.12
                        (if (= r14 r15)
                            (jump L.__nested.7)
                            (jump L.__nested.8)))
                      (define L.__nested.9 (halt r15))
                      (define L.__nested.10 (halt r14))
                      (define L.__nested.7
                        (begin
                          (set! r15 r14)
                          (set! r15 (+ r15 r14))
                          (set! r15 r15)
                          (halt r15)))
                      (define L.__nested.8
                        (begin
                          (set! r13 1)
                          (if (= r13 r14)
                              (jump L.__nested.9)
                              (jump L.__nested.10))))
                      (define L.__nested.5
                        (begin
                          (set! r15 -9223372036854775808)
                          (set! r15 (+ r15 -9223372036854775808))
                          (set! r15 r15)
                          (halt 0)))
                      (define L.__nested.6
                        (if (< r15 r15)
                            (jump L.tmp.11)
                            (jump L.tmp.12)))
                      (define L.x.1.2
                        (begin
                          (set! r15 rdi)
                          (set! r14 1757280127)
                          (set! r14 r14)
                          (set! r14 1)
                          (set! r14 -1128483887)
                          (set! r15 r15)
                          (if (> r15 r15)
                              (jump L.__nested.13)
                              (jump L.__nested.14))))
                      (define L.__nested.13 (halt -1128483887))
                      (define L.__nested.14
                        (begin
                          (set! r14 r14)
                          (set! r14 (+ r14 r15))
                          (set! r15 r14)
                          (halt r15)))
                      (define L.fn.2.3
                        (begin
                          (set! r15 -9223372036854775808)
                          (set! r15 (+ r15 -1421853645))
                          (set! r15 r15)
                          (set! r15 0)
                          (if (true)
                              (jump L.__nested.16)
                              (jump L.__nested.15))))
                      (define L.__nested.15
                        (begin
                          (set! r15 -167927521)
                          (set! r15 (+ r15 1))
                          (set! r15 r15)
                          (halt -167927520)))
                      (define L.__nested.16
                        (begin
                          (set! r15 1041085683)
                          (set! r15 (* r15 9223372036854775807))
                          (set! r15 r15)
                          (set! r15 r15)
                          (halt 770292232)))))
  (check-by-interp '(module (define L.__main.3
                              (begin
                                (set! r15 -579691794)
                                (halt 953357957)))
                            (define L.proc.0.1
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
                          (jump L.proc.0.1)))))
  (check-by-interp '(module (define L.__main.1
                              (begin
                                (set! r15 9223372036854775807)
                                (set! r15 -546026276)
                                (halt 9223372036854775807)))))
  (check-by-interp '(module (define L.__main.4
                              (begin
                                (set! r15 9223372036854775807)
                                (if (false)
                                    (jump L.__nested.2)
                                    (jump L.__nested.3))))
                            (define L.func.0.1
                              (begin
                                (set! r14 rdi)
                                (set! r15 rsi)
                                (set! r14 r14)
                                (if (= r14 0)
                                    (jump L.__nested.6)
                                    (jump L.__nested.5))))
                      (define L.__nested.5
                        (begin
                          (set! r15 r14)
                          (set! r15 (+ r15 0))
                          (set! r15 r15)
                          (set! r15 0)
                          (set! r15 (* r15 9223372036854775807))
                          (set! r15 r15)
                          (halt 0)))
                      (define L.__nested.6
                        (begin
                          (set! r14 0)
                          (set! r14 (* r14 r15))
                          (set! r14 r14)
                          (halt r15)))
                      (define L.__nested.2 (halt 1))
                      (define L.__nested.3 (halt -9223372036854775808))))
  (check-by-interp '(module (define L.__main.4
                              (begin
                                (set! r15 979460199)
                                (set! r15 (+ r15 -1697959716))
                                (set! r15 r15)
                                (halt -718499517)))
                            (define L.fn.0.1
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
                                (set! r13 1)
                                (if (true)
                                    (jump L.__nested.5)
                                    (jump L.__nested.6))))
                      (define L.__nested.5 (halt 9223372036854775807))
                      (define L.__nested.6 (halt r15))
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
                          (halt 956544412)))))
  (check-by-interp '(module (define L.__main.2
                              (begin
                                (set! r9 9223372036854775807)
                                (set! r8 -1891086346)
                                (set! rcx -1371550930)
                                (set! rdx 0)
                                (set! rsi 9223372036854775807)
                                (set! rdi 0)
                                (jump L.proc.0.1)))
                            (define L.proc.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r15 rdx)
                                (set! r13 rcx)
                                (set! r14 r8)
                                (set! r9 r9)
                                (set! r8 -669410514)
                                (if (< r14 r14)
                                    (jump L.tmp.5)
                                    (jump L.tmp.6))))
                      (define L.__nested.3 (halt 9223372036854775807))
                      (define L.__nested.4 (halt r14))
                      (define L.tmp.5
                        (begin
                          (set! r9 r9)
                          (set! r9 (+ r9 r13))
                          (set! r9 r9)
                          (jump L.tmp.7)))
                      (define L.tmp.6
                        (begin
                          (set! r9 r15)
                          (jump L.tmp.7)))
                      (define L.tmp.7
                        (begin
                          (set! r13 r13)
                          (set! r13 1)
                          (if (<= r15 1)
                              (jump L.__nested.3)
                              (jump L.__nested.4))))))
  (check-by-interp '(module (define L.__main.4
                              (begin
                                (set! r15 1)
                                (halt 1)))
                            (define L.x.0.1
                              (begin
                                (set! r15 rdi)
                                (set! r15 rsi)
                                (set! r14 rdx)
                                (set! r13 rcx)
                                (set! r8 r8)
                                (set! r9 r9)
                                (set! rdi fv0)
                                (set! rdi 388494724)
                                (if (>= rdi r15)
                                    (jump L.tmp.9)
                                    (jump L.tmp.10))))
                      (define L.tmp.9
                        (if (> r13 -9223372036854775808)
                            (jump L.__nested.6)
                            (jump L.__nested.5)))
                      (define L.tmp.10
                        (if (< r14 r13)
                            (jump L.__nested.6)
                            (jump L.__nested.5)))
                      (define L.__nested.7 (halt 0))
                      (define L.__nested.8
                        (begin
                          (set! r15 r13)
                          (halt 1887946265)))
                      (define L.__nested.5
                        (if (<= r8 r9)
                            (jump L.__nested.7)
                            (jump L.__nested.8)))
                      (define L.__nested.6 (halt r14))
                      (define L.tmp.1.2
                        (begin
                          (set! r15 rdi)
                          (set! r15 rsi)
                          (set! r15 rdx)
                          (set! r14 rcx)
                          (set! r13 r8)
                          (set! r9 r9)
                          (set! r15 r14)
                          (set! r15 (* r15 9223372036854775807))
                          (set! r15 r15)
                          (halt r15)))
                      (define L.tmp.2.3
                        (begin
                          (set! r15 rdi)
                          (set! r15 rsi)
                          (set! r14 rdx)
                          (set! r13 rcx)
                          (set! r8 r8)
                          (set! r13 r9)
                          (set! r13 258314756)
                          (if (!= r8 0)
                              (jump L.tmp.15)
                              (jump L.tmp.16))))
                      (define L.__nested.13 (halt r8))
                      (define L.__nested.14 (halt r15))
                      (define L.__nested.11
                        (begin
                          (set! r9 1067478227)
                          (set! r8 -768559462)
                          (set! rcx r14)
                          (set! rdx -1256996529)
                          (set! rsi 1)
                          (set! rdi r13)
                          (jump L.tmp.1.2)))
                      (define L.__nested.12
                        (begin
                          (set! r14 389818959)
                          (if (false)
                              (jump L.__nested.13)
                              (jump L.__nested.14))))
                      (define L.tmp.15
                        (begin
                          (set! r13 r8)
                          (jump L.tmp.17)))
                      (define L.tmp.16
                        (begin
                          (set! r13 -1809848824)
                          (set! r13 9223372036854775807)
                          (jump L.tmp.17)))
                      (define L.tmp.17
                        (begin
                          (set! r9 1525021420)
                          (if (false)
                              (jump L.__nested.11)
                              (jump L.__nested.12))))))
  (check-by-interp '(module (define L.__main.4
                              (begin
                                (set! fv0 -9223372036854775808)
                                (set! r9 1)
                                (set! r8 -9223372036854775808)
                                (set! rcx 9223372036854775807)
                                (set! rdx -9223372036854775808)
                                (set! rsi -9223372036854775808)
                                (set! rdi -9223372036854775808)
                                (jump L.tmp.0.1)))
                            (define L.tmp.0.1
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
                              (jump L.tmp.5)
                              (jump L.tmp.6))))
                      (define L.tmp.8
                        (begin
                          (set! r14 r15)
                          (jump L.tmp.10)))
                      (define L.tmp.9
                        (begin
                          (set! r14 214741259)
                          (jump L.tmp.10)))
                      (define L.tmp.10 (jump L.tmp.7))
                      (define L.tmp.5
                        (if (= r13 r13)
                            (jump L.tmp.8)
                            (jump L.tmp.9)))
                      (define L.tmp.6
                        (begin
                          (set! r14 1683358713)
                          (set! r14 (+ r14 r15))
                          (set! r14 r14)
                          (jump L.tmp.7)))
                      (define L.tmp.7
                        (begin
                          (set! fv0 -2043460455)
                          (set! r9 r13)
                          (set! r8 9223372036854775807)
                          (set! rcx r13)
                          (set! rdx 0)
                          (set! rsi r15)
                          (set! rdi r14)
                          (jump L.tmp.0.1)))))
  (check-by-interp '(module (define L.__main.1
                              (begin
                                (set! r15 1)
                                (set! r15 (+ r15 -9223372036854775808))
                                (set! r15 r15)
                                (halt -9223372036854775807)))))
  (check-by-interp '(module (define L.__main.19
                              (begin
                                (set! r15 -9223372036854775808)
                                (if (true)
                                    (jump L.tmp.13)
                                    (jump L.tmp.14))))
                            (define L.x.0.1
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
                          (set! r15 -577997854)
                          (if (false)
                              (jump L.__nested.20)
                              (jump L.__nested.21))))
                      (define L.__nested.20 (halt -9223372036854775808))
                      (define L.__nested.21 (halt 9223372036854775807))
                      (define L.fn.2.3
                        (begin
                          (set! r15 1)
                          (set! r15 (+ r15 1))
                          (set! r15 r15)
                          (set! r15 r15)
                          (halt 1969054361)))
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
                          (set! r8 rdi)
                          (if (> r14 r15)
                              (jump L.__nested.22)
                              (jump L.__nested.23))))
                      (define L.__nested.22
                        (begin
                          (set! fv0 -1819248150)
                          (set! r9 r9)
                          (set! r8 r14)
                          (set! rcx r9)
                          (set! rdx r13)
                          (set! rsi 9223372036854775807)
                          (set! rdi -1863740769)
                          (jump L.x.0.1)))
                      (define L.__nested.23 (halt 1))
                      (define L.func.6.7
                        (begin
                          (set! r15 rdi)
                          (set! r14 rsi)
                          (set! r14 rdx)
                          (set! r14 rcx)
                          (set! r14 r8)
                          (set! r14 r9)
                          (set! r14 fv0)
                          (set! r15 r15)
                          (set! r14 -1497437069)
                          (if (true)
                              (jump L.__nested.24)
                              (jump L.__nested.25))))
                      (define L.__nested.24
                        (begin
                          (set! r15 r15)
                          (set! r15 (+ r15 r15))
                          (set! r15 r15)
                          (set! r15 0)
                          (halt 0)))
                      (define L.__nested.25 (halt 1))
                      (define L.fn.7.8
                        (begin
                          (set! r15 0)
                          (if (false)
                              (jump L.__nested.27)
                              (jump L.__nested.26))))
                      (define L.__nested.28 (halt 1))
                      (define L.__nested.29 (halt 0))
                      (define L.__nested.26
                        (begin
                          (set! r9 -1579752260)
                          (set! r8 0)
                          (set! rcx -1248542300)
                          (set! rdx 0)
                          (set! rsi 16140507)
                          (set! rdi -9223372036854775808)
                          (jump L.x.5.6)))
                      (define L.__nested.27
                        (begin
                          (set! r15 -9223372036854775808)
                          (if (false)
                              (jump L.__nested.28)
                              (jump L.__nested.29))))
                      (define L.tmp.16
                        (begin
                          (set! r15 -1444900091)
                          (jump L.tmp.18)))
                      (define L.tmp.17
                        (begin
                          (set! r15 -9223372036854775808)
                          (jump L.tmp.18)))
                      (define L.tmp.18
                        (begin
                          (set! r15 r15)
                          (jump L.tmp.15)))
                      (define L.tmp.13
                        (begin
                          (set! r15 9223372036854775807)
                          (if (true)
                              (jump L.tmp.16)
                              (jump L.tmp.17))))
                      (define L.tmp.14
                        (begin
                          (set! r15 9223372036854775807)
                          (set! r15 r15)
                          (jump L.tmp.15)))
                      (define L.tmp.15
                        (begin
                          (set! r15 0)
                          (if (true)
                              (jump L.__nested.9)
                              (jump L.__nested.10))))
                      (define L.__nested.11 (jump L.fn.2.3))
                      (define L.__nested.12 (jump L.fn.2.3))
                      (define L.__nested.9 (halt 1))
                      (define L.__nested.10
                        (begin
                          (set! r15 1)
                          (if (false)
                              (jump L.__nested.11)
                              (jump L.__nested.12))))))

  ;; !!!

  (check-resolve-predicates `(module (define L.start.1 (halt 5)))
                            `(module (define L.start.1 (halt 5))))

  (check-resolve-predicates `(module (define L.start.1 (halt 5)) (define L.start.2 (jump L.start.1))
                               )
                            `(module (define L.start.1 (halt 5)) (define L.start.2 (jump L.start.1))
                               ))

  (check-resolve-predicates `(module (define L.start.1 (halt 5)) (define L.start.2 (jump L.start.1))
                               (define L.start.3
                                 (if (not (true))
                                     (jump L.start.2)
                                     (jump L.start.1))))
                            `(module (define L.start.1 (halt 5)) (define L.start.2 (jump L.start.1))
                               (define L.start.3 (jump L.start.1))))
  (check-resolve-predicates `(module (define L.start.1 (halt 5)) (define L.start.2 (jump L.start.1))
                               (define L.start.3
                                 (if (true)
                                     (jump L.start.2)
                                     (jump L.start.1))))
                            `(module (define L.start.1 (halt 5)) (define L.start.2 (jump L.start.1))
                               (define L.start.3 (jump L.start.2))))
  (check-resolve-predicates `(module (define L.start.1 (halt 5)) (define L.start.2 (jump L.start.1))
                               (define L.start.3
                                 (if (false)
                                     (jump L.start.2)
                                     (jump L.start.1))))
                            `(module (define L.start.1 (halt 5)) (define L.start.2 (jump L.start.1))
                               (define L.start.3 (jump L.start.1))))

  (check-resolve-predicates `(module (define L.start.1 (halt 5))
                                     (define L.start.2
                                       (begin
                                         (set! rax 5)
                                         (jump L.start.1)))
                               (define L.start.3
                                 (if (> rax 2)
                                     (jump L.start.2)
                                     (jump L.start.1))))
                            `(module (define L.start.1 (halt 5))
                                     (define L.start.2
                                       (begin
                                         (set! rax 5)
                                         (jump L.start.1)))
                               (define L.start.3
                                 (if (> rax 2)
                                     (jump L.start.2)
                                     (jump L.start.1)))))
  (check-by-interp `(module (define L.start.1
                              (begin
                                (set! rax 1)
                                (set! rdi 5)
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
                                (if (true)
                                    (jump L.end.1)
                                    (jump L.end.2))))
                            (define L.end.1 (halt 0))
                      (define L.end.2 (halt 1))))

  (check-by-interp `(module (define L.start.1
                              (begin
                                (if (not (true))
                                    (jump L.end.1)
                                    (jump L.end.2))))
                            (define L.end.1 (halt 0))
                      (define L.end.2 (halt 1)))))
