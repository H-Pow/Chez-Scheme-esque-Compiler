#lang racket
(require rackunit
         cpsc411/langs/v7
         (only-in "../expose-basic-blocks.rkt" expose-basic-blocks))

(define (check-nested-asm-lang-v7 p)
  (if (nested-asm-lang-v7? p) p #f))

(define (check-block-pred-lang-v7 p)
  (if (block-pred-lang-v7? p) p #f))

(define-syntax-rule (check-by-interp p)
  (check-equal? (interp-nested-asm-lang-v7 (check-nested-asm-lang-v7 p))
                (interp-block-pred-lang-v7 (check-block-pred-lang-v7 (expose-basic-blocks p)))))

;;; Added by Trevor on 2026-03-19

(check-by-interp '(module (begin
                            (set! r15 r15)
                            (set! rax 0)
                            (jump r15))))
(check-by-interp '(module (begin
                            (set! r15 r15)
                            (set! rax 8)
                            (jump r15))))
(check-by-interp '(module (begin
                            (set! r15 r15)
                            (set! rax 6)
                            (jump r15))))
(check-by-interp '(module (begin
                            (set! r15 r15)
                            (set! rax 14)
                            (jump r15))))
(check-by-interp '(module (begin
                            (set! r15 r15)
                            (set! rax 13102)
                            (jump r15))))
(check-by-interp '(module (begin
                            (set! r15 r15)
                            (set! rax 18990)
                            (jump r15))))
(check-by-interp '(module (begin
                            (set! r15 r15)
                            (set! rax 30)
                            (jump r15))))
(check-by-interp '(module (define L.+.1
                            (begin
                              (set! r15 r15)
                              (set! r13 rdi)
                              (set! r14 rsi)
                              (if (begin
                                    (if (begin
                                          (begin
                                            (set! r9 r14)
                                            (set! r9 (bitwise-and r9 7))
                                            (set! r9 r9))
                                          (= r9 0))
                                        (set! r9 14)
                                        (set! r9 6))
                                    (!= r9 6))
                                  (if (begin
                                        (if (begin
                                              (begin
                                                (set! r9 r13)
                                                (set! r9 (bitwise-and r9 7))
                                                (set! r9 r9))
                                              (= r9 0))
                                            (set! r9 14)
                                            (set! r9 6))
                                        (!= r9 6))
                                      (begin
                                        (set! r13 r13)
                                        (set! r13 (+ r13 r14))
                                        (set! rax r13)
                                        (jump r15))
                                      (begin
                                        (set! rax 574)
                                        (jump r15)))
                                  (begin
                                    (set! rax 574)
                                    (jump r15)))))
                          (begin
                            (set! r15 r15)
                            (set! rsi 0)
                            (set! rdi 0)
                            (set! r15 r15)
                            (jump L.+.1))
                    ))
(check-by-interp '(module (define L.not.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (!= r14 6)
                                  (begin
                                    (set! rax 6)
                                    (jump r15))
                                  (begin
                                    (set! rax 14)
                                    (jump r15)))))
                          (begin
                            (set! r15 r15)
                            (set! rdi 6)
                            (set! r15 r15)
                            (jump L.not.1))
                    ))
(check-by-interp '(module (define L.not.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (!= r14 6)
                                  (begin
                                    (set! rax 6)
                                    (jump r15))
                                  (begin
                                    (set! rax 14)
                                    (jump r15)))))
                          (begin
                            (set! r15 r15)
                            (set! rdi 14)
                            (set! r15 r15)
                            (jump L.not.1))
                    ))
(check-by-interp '(module (begin
                            (set! r15 r15)
                            (if (begin
                                  (set! r14 6)
                                  (false))
                                (begin
                                  (set! rax 22)
                                  (jump r15))
                                (begin
                                  (set! rax 0)
                                  (jump r15))))))
(check-by-interp '(module (define L.fixnum?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 7))
                                      (set! r14 r14))
                                    (= r14 0))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
                          (begin
                            (set! r15 r15)
                            (set! rdi 14)
                            (set! r15 r15)
                            (jump L.fixnum?.1))
                    ))
(check-by-interp '(module (define L.error?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 62))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
                          (begin
                            (set! r15 r15)
                            (set! rdi 30)
                            (set! r15 r15)
                            (jump L.error?.1))
                    ))
(check-by-interp '(module (define L.fixnum?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 7))
                                      (set! r14 r14))
                                    (= r14 0))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
                          (begin
                            (set! r15 r15)
                            (set! rdi 22)
                            (set! r15 r15)
                            (jump L.fixnum?.1))
                    ))
(check-by-interp '(module (define L.ascii-char?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 46))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
                          (begin
                            (set! r15 r15)
                            (set! rdi 14)
                            (set! r15 r15)
                            (jump L.ascii-char?.1))
                    ))
(check-by-interp '(module (define L.boolean?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 247))
                                      (set! r14 r14))
                                    (= r14 6))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
                          (begin
                            (set! r15 r15)
                            (set! rdi 30)
                            (set! r15 r15)
                            (jump L.boolean?.1))
                    ))
(check-by-interp '(module (define L.ascii-char?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 46))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
                          (begin
                            (set! r15 r15)
                            (set! rdi 30)
                            (set! r15 r15)
                            (jump L.ascii-char?.1))
                    ))
(check-by-interp '(module (begin
                            (set! r15 r15)
                            (set! r14 6)
                            (set! rax r14)
                            (jump r15))))
(check-by-interp '(module (begin
                            (set! r15 r15)
                            (set! r14 25646)
                            (set! r13 28206)
                            (set! rax r14)
                            (jump r15))))
(check-by-interp '(module (define L.void?.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 30))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
                          (define L.proc.0.1
                            (begin
                              (set! r15 r15)
                              (set! rax 14)
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 8)
                      (set! r15 r15)
                      (jump L.void?.2))))
(check-by-interp '(module (define L.<=.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (if (begin
                                    (if (begin
                                          (begin
                                            (set! r9 r13)
                                            (set! r9 (bitwise-and r9 7))
                                            (set! r9 r9))
                                          (= r9 0))
                                        (set! r9 14)
                                        (set! r9 6))
                                    (!= r9 6))
                                  (if (begin
                                        (if (begin
                                              (begin
                                                (set! r9 r14)
                                                (set! r9 (bitwise-and r9 7))
                                                (set! r9 r9))
                                              (= r9 0))
                                            (set! r9 14)
                                            (set! r9 6))
                                        (!= r9 6))
                                      (if (<= r14 r13)
                                          (begin
                                            (set! rax 14)
                                            (jump r15))
                                          (begin
                                            (set! rax 6)
                                            (jump r15)))
                                      (begin
                                        (set! rax 1342)
                                        (jump r15)))
                                  (begin
                                    (set! rax 1342)
                                    (jump r15)))))
                          (define L.tmp.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! rax 14)
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rsi 0)
                      (set! rdi 0)
                      (set! r15 r15)
                      (jump L.<=.2))))
(check-by-interp '(module (begin
                            (set! r15 r15)
                            (set! r14 6)
                            (set! r14 22)
                            (set! r14 1086429096)
                            (set! rax 22)
                            (jump r15))))
(check-by-interp '(module (define L.x.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r14 r8)
                              (set! rax -3961536528)
                              (jump r15)))
                          (begin
                            (set! r15 r15)
                            (set! rax 14)
                            (jump r15))
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
                              (set! rax 8)
                              (jump r15)))
                          (begin
                            (set! r15 r15)
                            (set! rax 6)
                            (jump r15))
                    ))
(check-by-interp '(module (define L.fn.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! rax 30)
                              (jump r15)))
                          (define L.tmp.1.2
                            (begin
                              (set! r15 r15)
                              (set! rax 22)
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 19502)
                      (jump r15))))
(check-by-interp '(module (define L.func.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! rax 6)
                              (jump r15)))
                          (begin
                            (set! r15 r15)
                            (if (begin
                                  (set! r14 19246)
                                  (true))
                                (begin
                                  (set! rax 14)
                                  (jump r15))
                                (begin
                                  (set! rax 30)
                                  (jump r15))))
                    ))
(check-by-interp '(module (define L.eq?.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (if (= r14 r13)
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
                          (define L.proc.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r13 rdx)
                              (set! r13 rcx)
                              (set! rax r14)
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rsi 8)
                      (set! rdi 24878)
                      (set! r15 r15)
                      (jump L.eq?.2))))
(check-by-interp '(module (define L.*.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (if (begin
                                    (if (begin
                                          (begin
                                            (set! r9 r13)
                                            (set! r9 (bitwise-and r9 7))
                                            (set! r9 r9))
                                          (= r9 0))
                                        (set! r9 14)
                                        (set! r9 6))
                                    (!= r9 6))
                                  (if (begin
                                        (if (begin
                                              (begin
                                                (set! r9 r14)
                                                (set! r9 (bitwise-and r9 7))
                                                (set! r9 r9))
                                              (= r9 0))
                                            (set! r9 14)
                                            (set! r9 6))
                                        (!= r9 6))
                                      (begin
                                        (set! r13 r13)
                                        (set! r13 (arithmetic-shift-right r13 3))
                                        (set! r13 r13)
                                        (set! r14 r14)
                                        (set! r14 (* r14 r13))
                                        (set! rax r14)
                                        (jump r15))
                                      (begin
                                        (set! rax 318)
                                        (jump r15)))
                                  (begin
                                    (set! rax 318)
                                    (jump r15)))))
                          (define L.func.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r14 rdx)
                              (set! r14 rcx)
                              (set! r13 r8)
                              (set! rax r14)
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rsi 0)
                      (set! rdi 8)
                      (set! r15 r15)
                      (jump L.*.2))))
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
                              (set! rax r14)
                              (jump r15)))
                          (begin
                            (set! r15 r15)
                            (set! rax 22)
                            (jump r15))
                    ))
(check-by-interp '(module (define L.fn.0.1
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
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 14)
                      (jump r15))))
(check-by-interp '(module (define L.eq?.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (if (= r14 r13)
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rsi 1871355128)
                      (set! rdi 27950)
                      (set! r15 r15)
                      (jump L.eq?.2))))
(check-by-interp '(module (define L.x.0.1
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
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 30)
                      (jump r15))))
(check-by-interp '(module (define L.func.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! r13 rdx)
                              (set! rax r14)
                              (jump r15)))
                          (begin
                            (set! r15 r15)
                            (set! r14 6)
                            (set! r14 22)
                            (set! r14 22)
                            (set! rax 0)
                            (jump r15))
                    ))
(check-by-interp '(module (define L.func.0.1
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
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 6)
                      (jump r15))))
(check-by-interp '(module (define L.fn.0.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r14 rsi)
                              (set! rax r14)
                              (jump r15)))
                          (begin
                            (set! r15 r15)
                            (set! r14 30)
                            (set! r14 22)
                            (set! r14 0)
                            (set! r14 0)
                            (set! rax 14)
                            (jump r15))
                    ))
(check-by-interp '(module (define L.x.0.1
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
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 29230)
                      (jump r15))))
(check-by-interp '(module (define L.proc.0.1
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
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 22)
                      (jump r15))))
(check-by-interp '(module (define L.tmp.0.1
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
                    (begin
                      (set! r15 r15)
                      (if (begin
                            (set! r14 25902)
                            (true))
                          (begin
                            (set! rax 30)
                            (jump r15))
                          (begin
                            (set! rax 22)
                            (jump r15))))))
(check-by-interp '(module (define L.void?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 30))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 13102)
                      (set! r15 r15)
                      (jump L.void?.3))))
(check-by-interp '(module (define L.fn.0.1
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 14)
                      (jump r15))))
(check-by-interp '(module (define L.func.0.1
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
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 30)
                      (jump r15))))
(check-by-interp '(module (define L.boolean?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 247))
                                      (set! r14 r14))
                                    (= r14 6))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 22)
                      (set! r15 r15)
                      (jump L.boolean?.3))))
(check-by-interp '(module (define L.ascii-char?.2
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 46))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
                          (define L.eq?.1
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (if (= r14 r13)
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
                    (begin
                      (set! (rbp - 0) r15)
                      (begin
                        (set! rbp (- rbp 8))
                        (return-point L.rp.3
                                      (begin
                                        (set! rsi 0)
                                        (set! rdi 22)
                                        (set! r15 L.rp.3)
                                        (jump L.eq?.1)))
                        (set! rbp (+ rbp 8)))
                      (set! r15 rax)
                      (set! r14 6)
                      (set! r14 2031626432)
                      (if (begin
                            (set! r14 14)
                            (true))
                          (set! r15 30)
                          (set! r15 r15))
                      (set! rdi r15)
                      (set! r15 (rbp - 0))
                      (jump L.ascii-char?.2))))
(check-by-interp '(module (define L.fn.0.1
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
                    (begin
                      (set! r15 r15)
                      (if (begin
                            (set! r14 30)
                            (true))
                          (begin
                            (set! rax 30)
                            (jump r15))
                          (begin
                            (set! rax 29230)
                            (jump r15))))))
(check-by-interp '(module (define L.ascii-char?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 46))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 6)
                      (set! r15 r15)
                      (jump L.ascii-char?.3))))
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
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 6)
                      (jump r15))))
(check-by-interp '(module (define L.ascii-char?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 46))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 20526)
                      (set! r15 r15)
                      (jump L.ascii-char?.3))))
(check-by-interp '(module (define L.x.0.1
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
                              (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! r14 22)
                      (set! r14 6)
                      (set! rax 22)
                      (jump r15))))
(check-by-interp '(module (define L.boolean?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 247))
                                      (set! r14 r14))
                                    (= r14 6))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 30)
                      (set! r15 r15)
                      (jump L.boolean?.3))))
(check-by-interp '(module (define L.ascii-char?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 46))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 30)
                      (set! r15 r15)
                      (jump L.ascii-char?.3))))
(check-by-interp '(module (define L.*.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (if (begin
                                    (if (begin
                                          (begin
                                            (set! r9 r13)
                                            (set! r9 (bitwise-and r9 7))
                                            (set! r9 r9))
                                          (= r9 0))
                                        (set! r9 14)
                                        (set! r9 6))
                                    (!= r9 6))
                                  (if (begin
                                        (if (begin
                                              (begin
                                                (set! r9 r14)
                                                (set! r9 (bitwise-and r9 7))
                                                (set! r9 r9))
                                              (= r9 0))
                                            (set! r9 14)
                                            (set! r9 6))
                                        (!= r9 6))
                                      (begin
                                        (set! r13 r13)
                                        (set! r13 (arithmetic-shift-right r13 3))
                                        (set! r13 r13)
                                        (set! r14 r14)
                                        (set! r14 (* r14 r13))
                                        (set! rax r14)
                                        (jump r15))
                                      (begin
                                        (set! rax 318)
                                        (jump r15)))
                                  (begin
                                    (set! rax 318)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! r14 14)
                      (set! rsi 8)
                      (set! rdi 4105232688)
                      (set! r15 r15)
                      (jump L.*.4))))
(check-by-interp '(module (define L.proc.0.1
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 0)
                      (jump r15))))
(check-by-interp '(module (define L.fn.0.1
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rax 22)
                      (jump r15))))
(check-by-interp '(module (define L.empty?.3
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 22))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 8)
                      (set! r15 r15)
                      (jump L.empty?.3))))
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
                    (begin
                      (set! r15 r15)
                      (if (begin
                            (set! r14 6)
                            (false))
                          (begin
                            (set! rax 14)
                            (jump r15))
                          (begin
                            (set! rax 22)
                            (jump r15))))))
(check-by-interp '(module (define L.ascii-char?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 46))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 8)
                      (set! r15 r15)
                      (jump L.ascii-char?.4))))
(check-by-interp '(module (define L.boolean?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 247))
                                      (set! r14 r14))
                                    (= r14 6))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 6)
                      (set! r15 r15)
                      (jump L.boolean?.4))))
(check-by-interp '(module (define L.ascii-char?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 46))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 22)
                      (set! r15 r15)
                      (jump L.ascii-char?.4))))
(check-by-interp '(module (define L.<.5
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (if (begin
                                    (if (begin
                                          (begin
                                            (set! r9 r13)
                                            (set! r9 (bitwise-and r9 7))
                                            (set! r9 r9))
                                          (= r9 0))
                                        (set! r9 14)
                                        (set! r9 6))
                                    (!= r9 6))
                                  (if (begin
                                        (if (begin
                                              (begin
                                                (set! r9 r14)
                                                (set! r9 (bitwise-and r9 7))
                                                (set! r9 r9))
                                              (= r9 0))
                                            (set! r9 14)
                                            (set! r9 6))
                                        (!= r9 6))
                                      (if (< r14 r13)
                                          (begin
                                            (set! rax 14)
                                            (jump r15))
                                          (begin
                                            (set! rax 6)
                                            (jump r15)))
                                      (begin
                                        (set! rax 1086)
                                        (jump r15)))
                                  (begin
                                    (set! rax 1086)
                                    (jump r15)))))
                          (define L.eq?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (set! r13 rsi)
                              (if (= r14 r13)
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                    (begin
                      (set! (rbp - 0) r15)
                      (begin
                        (set! rbp (- rbp 8))
                        (return-point L.rp.6
                                      (begin
                                        (set! rsi 6)
                                        (set! rdi 8)
                                        (set! r15 L.rp.6)
                                        (jump L.eq?.4)))
                        (set! rbp (+ rbp 8)))
                      (set! r15 rax)
                      (set! rsi 8)
                      (set! rdi -2229142488)
                      (set! r15 (rbp - 0))
                      (jump L.<.5))))
(check-by-interp '(module (define L.empty?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 255))
                                      (set! r14 r14))
                                    (= r14 22))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                    (begin
                      (set! (rbp - 0) r15)
                      (if (begin
                            (set! r15 30)
                            (true))
                          (begin
                            (begin
                              (set! rbp (- rbp 8))
                              (return-point L.rp.5
                                            (begin
                                              (set! rdi 6)
                                              (set! r15 L.rp.5)
                                              (jump L.empty?.4)))
                              (set! rbp (+ rbp 8)))
                            (set! r15 rax)
                            (set! rax r15)
                            (jump (rbp - 0)))
                          (begin
                            (set! rax 8)
                            (jump (rbp - 0)))))))
(check-by-interp '(module (define L.fixnum?.4
                            (begin
                              (set! r15 r15)
                              (set! r14 rdi)
                              (if (begin
                                    (begin
                                      (set! r14 r14)
                                      (set! r14 (bitwise-and r14 7))
                                      (set! r14 r14))
                                    (= r14 0))
                                  (begin
                                    (set! rax 14)
                                    (jump r15))
                                  (begin
                                    (set! rax 6)
                                    (jump r15)))))
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! rdi 6)
                      (set! r15 r15)
                      (jump L.fixnum?.4))))
(check-by-interp '(module (define L.tmp.0.1
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! r14 22)
                      (set! r14 22)
                      (set! r14 19502)
                      (set! rax 29230)
                      (jump r15))))
(check-by-interp '(module (define L.fn.0.1
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
                        (jump r15)))
                    (begin
                      (set! r15 r15)
                      (set! r14 30)
                      (set! r14 21550)
                      (set! r14 22)
                      (set! r14 22)
                      (set! rax r14)
                      (jump r15))))
;;; Added by Trevor on 2026-03-19
