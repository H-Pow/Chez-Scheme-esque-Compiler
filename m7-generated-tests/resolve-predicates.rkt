#lang racket
(require rackunit
         cpsc411/langs/v7
         (only-in "../resolve-predicates.rkt" resolve-predicates))

(define (check-block-pred-lang-v7 p)
  (if (block-pred-lang-v7? p) p #f))

(define (check-block-asm-lang-v7 p)
  (if (block-asm-lang-v7? p) p #f))

(define-syntax-rule (check-by-interp p)
  (check-equal? (interp-block-pred-lang-v7 (check-block-pred-lang-v7 p))
                (interp-block-asm-lang-v7 (check-block-asm-lang-v7 (resolve-predicates p)))))

;;; Added by Trevor on 2026-03-19

(check-by-interp '(module (define L.__main.1
                            (begin
                              (set! r15 r15)
                              (set! rax 0)
                              (jump r15)))))
(check-by-interp '(module (define L.__main.1
                            (begin
                              (set! r15 r15)
                              (set! rax 8)
                              (jump r15)))))
(check-by-interp '(module (define L.__main.1
                            (begin
                              (set! r15 r15)
                              (set! rax 6)
                              (jump r15)))))
(check-by-interp '(module (define L.__main.1
                            (begin
                              (set! r15 r15)
                              (set! rax 14)
                              (jump r15)))))
(check-by-interp '(module (define L.__main.1
                            (begin
                              (set! r15 r15)
                              (set! rax 13102)
                              (jump r15)))))
(check-by-interp '(module (define L.__main.1
                            (begin
                              (set! r15 r15)
                              (set! rax 18990)
                              (jump r15)))))
(check-by-interp '(module (define L.__main.1
                            (begin
                              (set! r15 r15)
                              (set! rax 30)
                              (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rsi 0)
                              (set! rdi 0)
                              (set! r15 r15)
                              (jump L.+.1)))
                          (define L.+.1
                            (begin
                              (set! r15 r15)
                              (set! r13 rdi)
                              (set! r14 rsi)
                              (set! r9 r14)
                              (set! r9 (bitwise-and r9 7))
                              (set! r9 r9)
                              (if (= r9 0)
                                  (jump L.tmp.10)
                                  (jump L.tmp.11))))
                    (define L.tmp.10
                      (begin
                        (set! r9 14)
                        (jump L.tmp.12)))
                    (define L.tmp.11
                      (begin
                        (set! r9 6)
                        (jump L.tmp.12)))
                    (define L.tmp.12
                      (if (!= r9 6)
                          (jump L.__nested.3)
                          (jump L.__nested.4)))
                    (define L.tmp.7
                      (begin
                        (set! r9 14)
                        (jump L.tmp.9)))
                    (define L.tmp.8
                      (begin
                        (set! r9 6)
                        (jump L.tmp.9)))
                    (define L.tmp.9
                      (if (!= r9 6)
                          (jump L.__nested.5)
                          (jump L.__nested.6)))
                    (define L.__nested.5
                      (begin
                        (set! r13 r13)
                        (set! r13 (+ r13 r14))
                        (set! rax r13)
                        (jump r15)))
                    (define L.__nested.6
                      (begin
                        (set! rax 574)
                        (jump r15)))
                    (define L.__nested.3
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9)
                        (if (= r9 0)
                            (jump L.tmp.7)
                            (jump L.tmp.8))))
                    (define L.__nested.4
                      (begin
                        (set! rax 574)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rdi 6)
                              (set! r15 r15)
                              (jump L.not.1)))
                          (define L.not.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (!= r14 6)
                                  (jump L.__nested.3)
                                  (jump L.__nested.4))))
                    (define L.__nested.3
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rdi 14)
                              (set! r15 r15)
                              (jump L.not.1)))
                          (define L.not.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (!= r14 6)
                                  (jump L.__nested.3)
                                  (jump L.__nested.4))))
                    (define L.__nested.3
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! r14 6)
                              (if (false)
                                  (jump L.__nested.1)
                                  (jump L.__nested.2))))
                          (define L.__nested.1
                            (begin
                              (set! rax 22)
                              (jump r15)))
                    (define L.__nested.2
                      (begin
                        (set! rax 0)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rdi 14)
                              (set! r15 r15)
                              (jump L.fixnum?.1)))
                          (define L.fixnum?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 7))
                              (set! r14 r14)
                              (if (= r14 0)
                                  (jump L.__nested.3)
                                  (jump L.__nested.4))))
                    (define L.__nested.3
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rdi 30)
                              (set! r15 r15)
                              (jump L.error?.1)))
                          (define L.error?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 62)
                                  (jump L.__nested.3)
                                  (jump L.__nested.4))))
                    (define L.__nested.3
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rdi 22)
                              (set! r15 r15)
                              (jump L.fixnum?.1)))
                          (define L.fixnum?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 7))
                              (set! r14 r14)
                              (if (= r14 0)
                                  (jump L.__nested.3)
                                  (jump L.__nested.4))))
                    (define L.__nested.3
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rdi 14)
                              (set! r15 r15)
                              (jump L.ascii-char?.1)))
                          (define L.ascii-char?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 46)
                                  (jump L.__nested.3)
                                  (jump L.__nested.4))))
                    (define L.__nested.3
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rdi 30)
                              (set! r15 r15)
                              (jump L.boolean?.1)))
                          (define L.boolean?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 247))
                              (set! r14 r14)
                              (if (= r14 6)
                                  (jump L.__nested.3)
                                  (jump L.__nested.4))))
                    (define L.__nested.3
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rdi 30)
                              (set! r15 r15)
                              (jump L.ascii-char?.1)))
                          (define L.ascii-char?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 46)
                                  (jump L.__nested.3)
                                  (jump L.__nested.4))))
                    (define L.__nested.3
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.1
                            (begin
                              (set! r15 r15)
                              (set! r14 6)
                              (set! rax r14)
                              (jump r15)))))
(check-by-interp '(module (define L.__main.1
                            (begin
                              (set! r15 r15)
                              (set! r14 25646)
                              (set! r13 28206)
                              (set! rax r14)
                              (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rdi 8)
                              (set! r15 r15)
                              (jump L.void?.2)))
                          (define L.void?.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 30)
                                  (jump L.__nested.4)
                                  (jump L.__nested.5))))
                    (define L.__nested.4
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.5
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.proc.0.1
                      (begin
                        (set! r15 r15)
                        (set! rax 14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rsi 0)
                              (set! rdi 0)
                              (set! r15 r15)
                              (jump L.<=.2)))
                          (define L.<=.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (set! r9 r13)
                              (set! r9 (bitwise-and r9 7))
                              (set! r9 r9)
                              (if (= r9 0)
                                  (jump L.tmp.13)
                                  (jump L.tmp.14))))
                    (define L.tmp.13
                      (begin
                        (set! r9 14)
                        (jump L.tmp.15)))
                    (define L.tmp.14
                      (begin
                        (set! r9 6)
                        (jump L.tmp.15)))
                    (define L.tmp.15
                      (if (!= r9 6)
                          (jump L.__nested.4)
                          (jump L.__nested.5)))
                    (define L.tmp.10
                      (begin
                        (set! r9 14)
                        (jump L.tmp.12)))
                    (define L.tmp.11
                      (begin
                        (set! r9 6)
                        (jump L.tmp.12)))
                    (define L.tmp.12
                      (if (!= r9 6)
                          (jump L.__nested.6)
                          (jump L.__nested.7)))
                    (define L.__nested.8
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.9
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.__nested.6
                      (if (<= r14 r13)
                          (jump L.__nested.8)
                          (jump L.__nested.9)))
                    (define L.__nested.7
                      (begin
                        (set! rax 1342)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9)
                        (if (= r9 0)
                            (jump L.tmp.10)
                            (jump L.tmp.11))))
                    (define L.__nested.5
                      (begin
                        (set! rax 1342)
                        (jump r15)))
                    (define L.tmp.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! rax 14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.1
                            (begin
                              (set! r15 r15)
                              (set! r14 6)
                              (set! r14 22)
                              (set! r14 1086429096)
                              (set! rax 22)
                              (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rax 14)
                              (jump r15)))
                          (define L.x.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! rax -3961536528)
                              (jump r15)))
                    ))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rax 6)
                              (jump r15)))
                          (define L.func.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! r14 r9)
                              (set! rax 8)
                              (jump r15)))
                    ))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rax 19502)
                              (jump r15)))
                          (define L.fn.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! rax 30)
                              (jump r15)))
                    (define L.tmp.1.2
                      (begin
                        (set! r15 r15)
                        (set! rax 22)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! r14 19246)
                              (if (true)
                                  (jump L.__nested.2)
                                  (jump L.__nested.3))))
                          (define L.func.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! rax 6)
                              (jump r15)))
                    (define L.__nested.2
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.3
                      (begin
                        (set! rax 30)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rsi 8)
                              (set! rdi 24878)
                              (set! r15 r15)
                              (jump L.eq?.2)))
                          (define L.eq?.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (if (= r14 r13)
                                  (jump L.__nested.4)
                                  (jump L.__nested.5))))
                    (define L.__nested.4
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.5
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.proc.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r13 rdx)
                        (set! r13 rcx)
                        (set! rax r14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rsi 0)
                              (set! rdi 8)
                              (set! r15 r15)
                              (jump L.*.2)))
                          (define L.*.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (set! r9 r13)
                              (set! r9 (bitwise-and r9 7))
                              (set! r9 r9)
                              (if (= r9 0)
                                  (jump L.tmp.11)
                                  (jump L.tmp.12))))
                    (define L.tmp.11
                      (begin
                        (set! r9 14)
                        (jump L.tmp.13)))
                    (define L.tmp.12
                      (begin
                        (set! r9 6)
                        (jump L.tmp.13)))
                    (define L.tmp.13
                      (if (!= r9 6)
                          (jump L.__nested.4)
                          (jump L.__nested.5)))
                    (define L.tmp.8
                      (begin
                        (set! r9 14)
                        (jump L.tmp.10)))
                    (define L.tmp.9
                      (begin
                        (set! r9 6)
                        (jump L.tmp.10)))
                    (define L.tmp.10
                      (if (!= r9 6)
                          (jump L.__nested.6)
                          (jump L.__nested.7)))
                    (define L.__nested.6
                      (begin
                        (set! r13 r13)
                        (set! r13 (arithmetic-shift-right r13 3))
                        (set! r13 r13)
                        (set! r14 r14)
                        (set! r14 (* r14 r13))
                        (set! rax r14)
                        (jump r15)))
                    (define L.__nested.7
                      (begin
                        (set! rax 318)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9)
                        (if (= r9 0)
                            (jump L.tmp.8)
                            (jump L.tmp.9))))
                    (define L.__nested.5
                      (begin
                        (set! rax 318)
                        (jump r15)))
                    (define L.func.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r13 r8)
                        (set! rax r14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! rax 22)
                              (jump r15)))
                          (define L.proc.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! r14 r9)
                              (set! r14 (rbp - 0))
                              (set! rax r14)
                              (jump r15)))
                    ))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rax 14)
                              (jump r15)))
                          (define L.fn.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! rax 6)
                              (jump r15)))
                    (define L.func.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! rax r14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rsi 1871355128)
                              (set! rdi 27950)
                              (set! r15 r15)
                              (jump L.eq?.2)))
                          (define L.eq?.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (if (= r14 r13)
                                  (jump L.__nested.4)
                                  (jump L.__nested.5))))
                    (define L.__nested.4
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.5
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.proc.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! rax 14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rax 30)
                              (jump r15)))
                          (define L.x.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! rax 8)
                              (jump r15)))
                    (define L.func.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! rax 14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! r14 6)
                              (set! r14 22)
                              (set! r14 22)
                              (set! rax 0)
                              (jump r15)))
                          (define L.func.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r13 rdx)
                              (set! rax r14)
                              (jump r15)))
                    ))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rax 6)
                              (jump r15)))
                          (define L.func.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! rax 6)
                              (jump r15)))
                    (define L.proc.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! rax r14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.2
                            (begin
                              (set! r15 r15)
                              (set! r14 30)
                              (set! r14 22)
                              (set! r14 0)
                              (set! r14 0)
                              (set! rax 14)
                              (jump r15)))
                          (define L.fn.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! rax r14)
                              (jump r15)))
                    ))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rax 29230)
                              (jump r15)))
                          (define L.x.0.1
                            (begin
                              (set! r15 r15)
                              (set! rax 22)
                              (jump r15)))
                    (define L.proc.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! r14 (rbp - 0))
                        (set! rax 14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rax 22)
                              (jump r15)))
                          (define L.proc.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r13 rdx)
                              (set! r13 rcx)
                              (set! r13 r8)
                              (set! rax r14)
                              (jump r15)))
                    (define L.proc.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.5
                            (begin
                              (set! r15 r15)
                              (set! r14 25902)
                              (if (true)
                                  (jump L.__nested.3)
                                  (jump L.__nested.4))))
                          (define L.tmp.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r13 rdx)
                              (set! r13 rcx)
                              (set! r13 r8)
                              (set! rax r14)
                              (jump r15)))
                    (define L.x.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! rax 6)
                        (jump r15)))
                    (define L.__nested.3
                      (begin
                        (set! rax 30)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 22)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! rdi 13102)
                              (set! r15 r15)
                              (jump L.void?.3)))
                          (define L.void?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 30)
                                  (jump L.__nested.5)
                                  (jump L.__nested.6))))
                    (define L.__nested.5
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.6
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.x.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! rax r14)
                        (jump r15)))
                    (define L.tmp.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! r14 (rbp - 0))
                        (set! rax 0)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! rax 14)
                              (jump r15)))
                          (define L.fn.0.1
                            (begin
                              (set! r15 r15)
                              (set! rax 30)
                              (jump r15)))
                    (define L.fn.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! rax r14)
                        (jump r15)))
                    (define L.tmp.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! rax r14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rax 30)
                              (jump r15)))
                          (define L.func.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! rax 6)
                              (jump r15)))
                    (define L.func.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! rax 22574)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! rdi 22)
                              (set! r15 r15)
                              (jump L.boolean?.3)))
                          (define L.boolean?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 247))
                              (set! r14 r14)
                              (if (= r14 6)
                                  (jump L.__nested.5)
                                  (jump L.__nested.6))))
                    (define L.__nested.5
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.6
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.proc.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! rax 27694)
                        (jump r15)))
                    (define L.fn.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! rax 14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.7
                            (begin
                              (set! (rbp - 0) r15)
                              (set! rbp (- rbp 8))
                              (set! rsi 0)
                              (set! rdi 22)
                              (set! r15 L.rp.3)
                              (jump L.eq?.1)))
                          (define L.ascii-char?.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 46)
                                  (jump L.__nested.8)
                                  (jump L.__nested.9))))
                    (define L.__nested.8
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.9
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.eq?.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r13 rsi)
                        (if (= r14 r13)
                            (jump L.__nested.10)
                            (jump L.__nested.11))))
                    (define L.__nested.10
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.11
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.rp.3
                      (begin
                        (set! rbp (+ rbp 8))
                        (set! r15 rax)
                        (set! r14 6)
                        (set! r14 2031626432)
                        (set! r14 14)
                        (if (true)
                            (jump L.tmp.4)
                            (jump L.tmp.5))))
                    (define L.tmp.4
                      (begin
                        (set! r15 30)
                        (jump L.tmp.6)))
                    (define L.tmp.5
                      (begin
                        (set! r15 r15)
                        (jump L.tmp.6)))
                    (define L.tmp.6
                      (begin
                        (set! rdi r15)
                        (set! r15 (rbp - 0))
                        (jump L.ascii-char?.2)))))
(check-by-interp '(module (define L.__main.6
                            (begin
                              (set! r15 r15)
                              (set! r14 30)
                              (if (true)
                                  (jump L.__nested.4)
                                  (jump L.__nested.5))))
                          (define L.fn.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r13 rdx)
                              (set! rax r14)
                              (jump r15)))
                    (define L.x.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! rax 22)
                        (jump r15)))
                    (define L.func.2.3
                      (begin
                        (set! r15 r15)
                        (set! rax 6)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 30)
                        (jump r15)))
                    (define L.__nested.5
                      (begin
                        (set! rax 29230)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! rdi 6)
                              (set! r15 r15)
                              (jump L.ascii-char?.3)))
                          (define L.ascii-char?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 46)
                                  (jump L.__nested.5)
                                  (jump L.__nested.6))))
                    (define L.__nested.5
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.6
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.func.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! rax 6)
                        (jump r15)))
                    (define L.func.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r13 rsi)
                        (set! rax r14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! rax 6)
                              (jump r15)))
                          (define L.proc.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! r14 r9)
                              (set! r14 (rbp - 0))
                              (set! rax 14)
                              (jump r15)))
                    (define L.x.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r13 rcx)
                        (set! r13 r8)
                        (set! rax r14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! rdi 20526)
                              (set! r15 r15)
                              (jump L.ascii-char?.3)))
                          (define L.ascii-char?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 46)
                                  (jump L.__nested.5)
                                  (jump L.__nested.6))))
                    (define L.__nested.5
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.6
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.func.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! rax 14)
                        (jump r15)))
                    (define L.func.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.3
                            (begin
                              (set! r15 r15)
                              (set! r14 22)
                              (set! r14 6)
                              (set! rax 22)
                              (jump r15)))
                          (define L.x.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! rax 0)
                              (jump r15)))
                    (define L.proc.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r13 rcx)
                        (set! r13 r8)
                        (set! rax r14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! rdi 30)
                              (set! r15 r15)
                              (jump L.boolean?.3)))
                          (define L.boolean?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 247))
                              (set! r14 r14)
                              (if (= r14 6)
                                  (jump L.__nested.5)
                                  (jump L.__nested.6))))
                    (define L.__nested.5
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.6
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.tmp.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! rax r14)
                        (jump r15)))
                    (define L.tmp.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! r14 (rbp - 0))
                        (set! rax 0)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! rdi 30)
                              (set! r15 r15)
                              (jump L.ascii-char?.3)))
                          (define L.ascii-char?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 46)
                                  (jump L.__nested.5)
                                  (jump L.__nested.6))))
                    (define L.__nested.5
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.6
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.x.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! rax r14)
                        (jump r15)))
                    (define L.fn.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! r14 (rbp - 0))
                        (set! rax -3529966152)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.5
                            (begin
                              (set! r15 r15)
                              (set! r14 14)
                              (set! rsi 8)
                              (set! rdi 4105232688)
                              (set! r15 r15)
                              (jump L.*.4)))
                          (define L.*.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (set! r9 r13)
                              (set! r9 (bitwise-and r9 7))
                              (set! r9 r9)
                              (if (= r9 0)
                                  (jump L.tmp.13)
                                  (jump L.tmp.14))))
                    (define L.tmp.13
                      (begin
                        (set! r9 14)
                        (jump L.tmp.15)))
                    (define L.tmp.14
                      (begin
                        (set! r9 6)
                        (jump L.tmp.15)))
                    (define L.tmp.15
                      (if (!= r9 6)
                          (jump L.__nested.6)
                          (jump L.__nested.7)))
                    (define L.tmp.10
                      (begin
                        (set! r9 14)
                        (jump L.tmp.12)))
                    (define L.tmp.11
                      (begin
                        (set! r9 6)
                        (jump L.tmp.12)))
                    (define L.tmp.12
                      (if (!= r9 6)
                          (jump L.__nested.8)
                          (jump L.__nested.9)))
                    (define L.__nested.8
                      (begin
                        (set! r13 r13)
                        (set! r13 (arithmetic-shift-right r13 3))
                        (set! r13 r13)
                        (set! r14 r14)
                        (set! r14 (* r14 r13))
                        (set! rax r14)
                        (jump r15)))
                    (define L.__nested.9
                      (begin
                        (set! rax 318)
                        (jump r15)))
                    (define L.__nested.6
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9)
                        (if (= r9 0)
                            (jump L.tmp.10)
                            (jump L.tmp.11))))
                    (define L.__nested.7
                      (begin
                        (set! rax 318)
                        (jump r15)))
                    (define L.proc.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! rax 14)
                        (jump r15)))
                    (define L.fn.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r13 rdx)
                        (set! rax r14)
                        (jump r15)))
                    (define L.func.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! rax 0)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! rax 0)
                              (jump r15)))
                          (define L.proc.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! rax 14)
                              (jump r15)))
                    (define L.tmp.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! rax 14)
                        (jump r15)))
                    (define L.x.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! r14 (rbp - 0))
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! rax 22)
                              (jump r15)))
                          (define L.fn.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! r14 r9)
                              (set! rax 22)
                              (jump r15)))
                    (define L.proc.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! rax 14)
                        (jump r15)))
                    (define L.x.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r13 rsi)
                        (set! rax r14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! rdi 8)
                              (set! r15 r15)
                              (jump L.empty?.3)))
                          (define L.empty?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 22)
                                  (jump L.__nested.5)
                                  (jump L.__nested.6))))
                    (define L.__nested.5
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.6
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.tmp.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r13 rdx)
                        (set! r13 rcx)
                        (set! r13 r8)
                        (set! r13 r9)
                        (set! r13 (rbp - 0))
                        (set! rax r14)
                        (jump r15)))
                    (define L.x.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! r14 (rbp - 0))
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.6
                            (begin
                              (set! r15 r15)
                              (set! r14 6)
                              (if (false)
                                  (jump L.__nested.4)
                                  (jump L.__nested.5))))
                          (define L.proc.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! r14 r9)
                              (set! r14 (rbp - 0))
                              (set! rax 8)
                              (jump r15)))
                    (define L.func.1.2
                      (begin
                        (set! r15 r15)
                        (set! rax 14)
                        (jump r15)))
                    (define L.fn.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r13 rdx)
                        (set! rax r14)
                        (jump r15)))
                    (define L.__nested.4
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.5
                      (begin
                        (set! rax 22)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.5
                            (begin
                              (set! r15 r15)
                              (set! rdi 8)
                              (set! r15 r15)
                              (jump L.ascii-char?.4)))
                          (define L.ascii-char?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 46)
                                  (jump L.__nested.6)
                                  (jump L.__nested.7))))
                    (define L.__nested.6
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.7
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.fn.0.1
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
                    (define L.tmp.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! rax r14)
                        (jump r15)))
                    (define L.tmp.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.5
                            (begin
                              (set! r15 r15)
                              (set! rdi 6)
                              (set! r15 r15)
                              (jump L.boolean?.4)))
                          (define L.boolean?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 247))
                              (set! r14 r14)
                              (if (= r14 6)
                                  (jump L.__nested.6)
                                  (jump L.__nested.7))))
                    (define L.__nested.6
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.7
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.tmp.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r13 rdx)
                        (set! rax r14)
                        (jump r15)))
                    (define L.fn.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r13 rsi)
                        (set! r13 rdx)
                        (set! r13 rcx)
                        (set! rax r14)
                        (jump r15)))
                    (define L.x.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! rax 8)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.5
                            (begin
                              (set! r15 r15)
                              (set! rdi 22)
                              (set! r15 r15)
                              (jump L.ascii-char?.4)))
                          (define L.ascii-char?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 46)
                                  (jump L.__nested.6)
                                  (jump L.__nested.7))))
                    (define L.__nested.6
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.7
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.tmp.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! r13 (rbp - 0))
                        (set! rax r14)
                        (jump r15)))
                    (define L.x.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! rax 0)
                        (jump r15)))
                    (define L.func.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! rax 8)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.7
                            (begin
                              (set! (rbp - 0) r15)
                              (set! rbp (- rbp 8))
                              (set! rsi 6)
                              (set! rdi 8)
                              (set! r15 L.rp.6)
                              (jump L.eq?.4)))
                          (define L.<.5
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (set! r9 r13)
                              (set! r9 (bitwise-and r9 7))
                              (set! r9 r9)
                              (if (= r9 0)
                                  (jump L.tmp.17)
                                  (jump L.tmp.18))))
                    (define L.tmp.17
                      (begin
                        (set! r9 14)
                        (jump L.tmp.19)))
                    (define L.tmp.18
                      (begin
                        (set! r9 6)
                        (jump L.tmp.19)))
                    (define L.tmp.19
                      (if (!= r9 6)
                          (jump L.__nested.8)
                          (jump L.__nested.9)))
                    (define L.tmp.14
                      (begin
                        (set! r9 14)
                        (jump L.tmp.16)))
                    (define L.tmp.15
                      (begin
                        (set! r9 6)
                        (jump L.tmp.16)))
                    (define L.tmp.16
                      (if (!= r9 6)
                          (jump L.__nested.10)
                          (jump L.__nested.11)))
                    (define L.__nested.12
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.13
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.__nested.10
                      (if (< r14 r13)
                          (jump L.__nested.12)
                          (jump L.__nested.13)))
                    (define L.__nested.11
                      (begin
                        (set! rax 1086)
                        (jump r15)))
                    (define L.__nested.8
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9)
                        (if (= r9 0)
                            (jump L.tmp.14)
                            (jump L.tmp.15))))
                    (define L.__nested.9
                      (begin
                        (set! rax 1086)
                        (jump r15)))
                    (define L.eq?.4
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r13 rsi)
                        (if (= r14 r13)
                            (jump L.__nested.20)
                            (jump L.__nested.21))))
                    (define L.__nested.20
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.21
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.proc.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! rax 14)
                        (jump r15)))
                    (define L.proc.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! rax 6)
                        (jump r15)))
                    (define L.x.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! rax 0)
                        (jump r15)))
                    (define L.rp.6
                      (begin
                        (set! rbp (+ rbp 8))
                        (set! r15 rax)
                        (set! rsi 8)
                        (set! rdi -2229142488)
                        (set! r15 (rbp - 0))
                        (jump L.<.5)))))
(check-by-interp '(module (define L.__main.8
                            (begin
                              (set! (rbp - 0) r15)
                              (set! r15 30)
                              (if (true)
                                  (jump L.__nested.6)
                                  (jump L.__nested.7))))
                          (define L.empty?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 255))
                              (set! r14 r14)
                              (if (= r14 22)
                                  (jump L.__nested.9)
                                  (jump L.__nested.10))))
                    (define L.__nested.9
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.10
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.proc.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! rax 6)
                        (jump r15)))
                    (define L.proc.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! rax 6)
                        (jump r15)))
                    (define L.fn.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! r14 (rbp - 0))
                        (set! rax 14)
                        (jump r15)))
                    (define L.rp.5
                      (begin
                        (set! rbp (+ rbp 8))
                        (set! r15 rax)
                        (set! rax r15)
                        (jump (rbp - 0))))
                    (define L.__nested.6
                      (begin
                        (set! rbp (- rbp 8))
                        (set! rdi 6)
                        (set! r15 L.rp.5)
                        (jump L.empty?.4)))
                    (define L.__nested.7
                      (begin
                        (set! rax 8)
                        (jump (rbp - 0))))))
(check-by-interp '(module (define L.__main.5
                            (begin
                              (set! r15 r15)
                              (set! rdi 6)
                              (set! r15 r15)
                              (jump L.fixnum?.4)))
                          (define L.fixnum?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 r14)
                              (set! r14 (bitwise-and r14 7))
                              (set! r14 r14)
                              (if (= r14 0)
                                  (jump L.__nested.6)
                                  (jump L.__nested.7))))
                    (define L.__nested.6
                      (begin
                        (set! rax 14)
                        (jump r15)))
                    (define L.__nested.7
                      (begin
                        (set! rax 6)
                        (jump r15)))
                    (define L.x.0.1
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r13 rsi)
                        (set! r13 rdx)
                        (set! r13 rcx)
                        (set! r13 r8)
                        (set! r13 r9)
                        (set! r13 (rbp - 0))
                        (set! rax r14)
                        (jump r15)))
                    (define L.tmp.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! rax 0)
                        (jump r15)))
                    (define L.tmp.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! r14 (rbp - 0))
                        (set! rax 6)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! r14 22)
                              (set! r14 22)
                              (set! r14 19502)
                              (set! rax 29230)
                              (jump r15)))
                          (define L.tmp.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (set! r13 rdx)
                              (set! r13 rcx)
                              (set! r13 r8)
                              (set! r13 r9)
                              (set! rax r14)
                              (jump r15)))
                    (define L.x.1.2
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! rax 2370093256)
                        (jump r15)))
                    (define L.tmp.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r13 rsi)
                        (set! r13 rdx)
                        (set! r13 rcx)
                        (set! rax r14)
                        (jump r15)))))
(check-by-interp '(module (define L.__main.4
                            (begin
                              (set! r15 r15)
                              (set! r14 30)
                              (set! r14 21550)
                              (set! r14 22)
                              (set! r14 22)
                              (set! rax r14)
                              (jump r15)))
                          (define L.fn.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! r14 r9)
                              (set! r14 (rbp - 0))
                              (set! rax 8)
                              (jump r15)))
                    (define L.proc.1.2
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
                    (define L.x.2.3
                      (begin
                        (set! r15 r15)
                        (set! r14 rdi)
                        (set! r14 rsi)
                        (set! r14 rdx)
                        (set! r14 rcx)
                        (set! r14 r8)
                        (set! r14 r9)
                        (set! rax 6)
                        (jump r15)))))
;;; Added by Trevor on 2026-03-19
