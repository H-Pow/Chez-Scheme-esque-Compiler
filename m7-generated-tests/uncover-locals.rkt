#lang racket
(require rackunit
         cpsc411/langs/v7
         (only-in "../uncover-locals.rkt" uncover-locals))

(define (check-asm-pred-lang-v7 p)
  (if (asm-pred-lang-v7? p) p #f))

(define (check-asm-pred-lang-v7/locals p)
  (if (asm-pred-lang-v7/locals? p) p #f))

(define-syntax-rule (check-by-interp p)
  (check-equal? (interp-asm-pred-lang-v7 (check-asm-pred-lang-v7 p))
                (interp-asm-pred-lang-v7/locals (check-asm-pred-lang-v7/locals (uncover-locals p)))))

;;; Added by Trevor on 2026-03-19

(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 0)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 8)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 6)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 14)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 13102)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 18990)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.24 r15)
                            (set! rax 30)
                            (jump tmp-ra.24 rbp rax))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (define L.+.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.28 r15)
                              (set! tmp.3 rdi)
                              (set! tmp.4 rsi)
                              (if (begin
                                    (if (begin
                                          (begin
                                            (set! tmp.30 tmp.4)
                                            (set! tmp.30 (bitwise-and tmp.30 7))
                                            (set! tmp.25 tmp.30))
                                          (= tmp.25 0))
                                        (set! tmp.24 14)
                                        (set! tmp.24 6))
                                    (!= tmp.24 6))
                                  (if (begin
                                        (if (begin
                                              (begin
                                                (set! tmp.31 tmp.3)
                                                (set! tmp.31 (bitwise-and tmp.31 7))
                                                (set! tmp.27 tmp.31))
                                              (= tmp.27 0))
                                            (set! tmp.26 14)
                                            (set! tmp.26 6))
                                        (!= tmp.26 6))
                                      (begin
                                        (set! tmp.32 tmp.3)
                                        (set! tmp.32 (+ tmp.32 tmp.4))
                                        (set! rax tmp.32)
                                        (jump tmp-ra.28 rbp rax))
                                      (begin
                                        (set! rax 574)
                                        (jump tmp-ra.28 rbp rax)))
                                  (begin
                                    (set! rax 574)
                                    (jump tmp-ra.28 rbp rax)))))
                    (begin
                      (set! tmp-ra.29 r15)
                      (set! rsi 0)
                      (set! rdi 0)
                      (set! r15 tmp-ra.29)
                      (jump L.+.1 rbp r15 rdi rsi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.not.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.24 r15)
                              (set! tmp.23 rdi)
                              (if (!= tmp.23 6)
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.24 rbp rax))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.24 rbp rax)))))
                    (begin
                      (set! tmp-ra.25 r15)
                      (set! rdi 6)
                      (set! r15 tmp-ra.25)
                      (jump L.not.1 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.not.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.24 r15)
                              (set! tmp.23 rdi)
                              (if (!= tmp.23 6)
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.24 rbp rax))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.24 rbp rax)))))
                    (begin
                      (set! tmp-ra.25 r15)
                      (set! rdi 14)
                      (set! r15 tmp-ra.25)
                      (jump L.not.1 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.24 r15)
                            (if (begin
                                  (set! tmp.25 6)
                                  (!= tmp.25 6))
                                (begin
                                  (set! rax 22)
                                  (jump tmp-ra.24 rbp rax))
                                (begin
                                  (set! rax 0)
                                  (jump tmp-ra.24 rbp rax))))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (define L.fixnum?.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.25 r15)
                              (set! tmp.17 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.27 tmp.17)
                                      (set! tmp.27 (bitwise-and tmp.27 7))
                                      (set! tmp.24 tmp.27))
                                    (= tmp.24 0))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.25 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.25 rbp rax)))))
                    (begin
                      (set! tmp-ra.26 r15)
                      (set! rdi 14)
                      (set! r15 tmp-ra.26)
                      (jump L.fixnum?.1 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.error?.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.25 r15)
                              (set! tmp.22 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.27 tmp.22)
                                      (set! tmp.27 (bitwise-and tmp.27 255))
                                      (set! tmp.24 tmp.27))
                                    (= tmp.24 62))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.25 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.25 rbp rax)))))
                    (begin
                      (set! tmp-ra.26 r15)
                      (set! rdi 30)
                      (set! r15 tmp-ra.26)
                      (jump L.error?.1 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.fixnum?.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.25 r15)
                              (set! tmp.17 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.27 tmp.17)
                                      (set! tmp.27 (bitwise-and tmp.27 7))
                                      (set! tmp.24 tmp.27))
                                    (= tmp.24 0))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.25 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.25 rbp rax)))))
                    (begin
                      (set! tmp-ra.26 r15)
                      (set! rdi 22)
                      (set! r15 tmp-ra.26)
                      (jump L.fixnum?.1 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.ascii-char?.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.25 r15)
                              (set! tmp.21 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.27 tmp.21)
                                      (set! tmp.27 (bitwise-and tmp.27 255))
                                      (set! tmp.24 tmp.27))
                                    (= tmp.24 46))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.25 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.25 rbp rax)))))
                    (begin
                      (set! tmp-ra.26 r15)
                      (set! rdi 14)
                      (set! r15 tmp-ra.26)
                      (jump L.ascii-char?.1 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.boolean?.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.25 r15)
                              (set! tmp.18 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.27 tmp.18)
                                      (set! tmp.27 (bitwise-and tmp.27 247))
                                      (set! tmp.24 tmp.27))
                                    (= tmp.24 6))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.25 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.25 rbp rax)))))
                    (begin
                      (set! tmp-ra.26 r15)
                      (set! rdi 30)
                      (set! r15 tmp-ra.26)
                      (jump L.boolean?.1 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.ascii-char?.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.25 r15)
                              (set! tmp.21 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.27 tmp.21)
                                      (set! tmp.27 (bitwise-and tmp.27 255))
                                      (set! tmp.24 tmp.27))
                                    (= tmp.24 46))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.25 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.25 rbp rax)))))
                    (begin
                      (set! tmp-ra.26 r15)
                      (set! rdi 30)
                      (set! r15 tmp-ra.26)
                      (jump L.ascii-char?.1 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.25 r15)
                            (set! foobar.8.1 6)
                            (set! rax foobar.8.1)
                            (jump tmp-ra.25 rbp rax))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.26 r15)
                            (set! foobar.2.2 25646)
                            (set! bat.1.1 28206)
                            (set! rax foobar.2.2)
                            (jump tmp-ra.26 rbp rax))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (define L.void?.2
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.25 r15)
                              (set! tmp.20 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.28 tmp.20)
                                      (set! tmp.28 (bitwise-and tmp.28 255))
                                      (set! tmp.24 tmp.28))
                                    (= tmp.24 30))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.25 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.25 rbp rax)))))
                    (define L.proc.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.26 r15)
                        (set! rax 14)
                        (jump tmp-ra.26 rbp rax)))
                    (begin
                      (set! tmp-ra.27 r15)
                      (set! rdi 8)
                      (set! r15 tmp-ra.27)
                      (jump L.void?.2 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.<=.2
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.29 r15)
                              (set! tmp.10 rdi)
                              (set! tmp.11 rsi)
                              (if (begin
                                    (if (begin
                                          (begin
                                            (set! tmp.32 tmp.11)
                                            (set! tmp.32 (bitwise-and tmp.32 7))
                                            (set! tmp.26 tmp.32))
                                          (= tmp.26 0))
                                        (set! tmp.25 14)
                                        (set! tmp.25 6))
                                    (!= tmp.25 6))
                                  (if (begin
                                        (if (begin
                                              (begin
                                                (set! tmp.33 tmp.10)
                                                (set! tmp.33 (bitwise-and tmp.33 7))
                                                (set! tmp.28 tmp.33))
                                              (= tmp.28 0))
                                            (set! tmp.27 14)
                                            (set! tmp.27 6))
                                        (!= tmp.27 6))
                                      (if (<= tmp.10 tmp.11)
                                          (begin
                                            (set! rax 14)
                                            (jump tmp-ra.29 rbp rax))
                                          (begin
                                            (set! rax 6)
                                            (jump tmp-ra.29 rbp rax)))
                                      (begin
                                        (set! rax 1342)
                                        (jump tmp-ra.29 rbp rax)))
                                  (begin
                                    (set! rax 1342)
                                    (jump tmp-ra.29 rbp rax)))))
                    (define L.tmp.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.30 r15)
                        (set! foo.9.1 rdi)
                        (set! rax 14)
                        (jump tmp-ra.30 rbp rax)))
                    (begin
                      (set! tmp-ra.31 r15)
                      (set! rsi 0)
                      (set! rdi 0)
                      (set! r15 tmp-ra.31)
                      (jump L.<=.2 rbp r15 rdi rsi))))
(check-by-interp '(module ((new-frames ()))
                          (begin
                            (set! tmp-ra.27 r15)
                            (set! foobar.1.3 6)
                            (set! foo.2.2 22)
                            (set! foo.5.1 1086429096)
                            (set! rax 22)
                            (jump tmp-ra.27 rbp rax))
                    ))
(check-by-interp '(module ((new-frames ()))
                          (define L.x.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.29 r15)
                              (set! foo.4.5 rdi)
                              (set! ball.9.4 rsi)
                              (set! foo.8.3 rdx)
                              (set! ball.3.2 rcx)
                              (set! ball.5.1 r8)
                              (set! rax -3961536528)
                              (jump tmp-ra.29 rbp rax)))
                    (begin
                      (set! tmp-ra.30 r15)
                      (set! rax 14)
                      (jump tmp-ra.30 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.func.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.30 r15)
                              (set! foobar.2.6 rdi)
                              (set! foobar.9.5 rsi)
                              (set! bat.5.4 rdx)
                              (set! bar.8.3 rcx)
                              (set! ball.0.2 r8)
                              (set! foo.1.1 r9)
                              (set! rax 8)
                              (jump tmp-ra.30 rbp rax)))
                    (begin
                      (set! tmp-ra.31 r15)
                      (set! rax 6)
                      (jump tmp-ra.31 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.fn.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.25 r15)
                              (set! foo.5.1 rdi)
                              (set! rax 30)
                              (jump tmp-ra.25 rbp rax)))
                    (define L.tmp.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.26 r15)
                        (set! rax 22)
                        (jump tmp-ra.26 rbp rax)))
                    (begin
                      (set! tmp-ra.27 r15)
                      (set! rax 19502)
                      (jump tmp-ra.27 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.func.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.28 r15)
                              (set! bar.9.4 rdi)
                              (set! foobar.0.3 rsi)
                              (set! bar.7.2 rdx)
                              (set! ball.1.1 rcx)
                              (set! rax 6)
                              (jump tmp-ra.28 rbp rax)))
                    (begin
                      (set! tmp-ra.29 r15)
                      (if (begin
                            (set! tmp.30 19246)
                            (!= tmp.30 6))
                          (begin
                            (set! rax 14)
                            (jump tmp-ra.29 rbp rax))
                          (begin
                            (set! rax 30)
                            (jump tmp-ra.29 rbp rax))))))
(check-by-interp '(module ((new-frames ()))
                          (define L.eq?.2
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.28 r15)
                              (set! tmp.19 rdi)
                              (set! tmp.20 rsi)
                              (if (= tmp.19 tmp.20)
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.28 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.28 rbp rax)))))
                    (define L.proc.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.29 r15)
                        (set! foobar.7.4 rdi)
                        (set! bar.4.3 rsi)
                        (set! bat.2.2 rdx)
                        (set! foo.8.1 rcx)
                        (set! rax bar.4.3)
                        (jump tmp-ra.29 rbp rax)))
                    (begin
                      (set! tmp-ra.30 r15)
                      (set! rsi 8)
                      (set! rdi 24878)
                      (set! r15 tmp-ra.30)
                      (jump L.eq?.2 rbp r15 rdi rsi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.*.2
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.34 r15)
                              (set! tmp.6 rdi)
                              (set! tmp.7 rsi)
                              (if (begin
                                    (if (begin
                                          (begin
                                            (set! tmp.37 tmp.7)
                                            (set! tmp.37 (bitwise-and tmp.37 7))
                                            (set! tmp.30 tmp.37))
                                          (= tmp.30 0))
                                        (set! tmp.29 14)
                                        (set! tmp.29 6))
                                    (!= tmp.29 6))
                                  (if (begin
                                        (if (begin
                                              (begin
                                                (set! tmp.38 tmp.6)
                                                (set! tmp.38 (bitwise-and tmp.38 7))
                                                (set! tmp.32 tmp.38))
                                              (= tmp.32 0))
                                            (set! tmp.31 14)
                                            (set! tmp.31 6))
                                        (!= tmp.31 6))
                                      (begin
                                        (set! tmp.39 tmp.7)
                                        (set! tmp.39 (arithmetic-shift-right tmp.39 3))
                                        (set! tmp.33 tmp.39)
                                        (set! tmp.40 tmp.6)
                                        (set! tmp.40 (* tmp.40 tmp.33))
                                        (set! rax tmp.40)
                                        (jump tmp-ra.34 rbp rax))
                                      (begin
                                        (set! rax 318)
                                        (jump tmp-ra.34 rbp rax)))
                                  (begin
                                    (set! rax 318)
                                    (jump tmp-ra.34 rbp rax)))))
                    (define L.func.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.35 r15)
                        (set! bat.7.5 rdi)
                        (set! ball.3.4 rsi)
                        (set! bat.4.3 rdx)
                        (set! ball.0.2 rcx)
                        (set! bar.2.1 r8)
                        (set! rax ball.0.2)
                        (jump tmp-ra.35 rbp rax)))
                    (begin
                      (set! tmp-ra.36 r15)
                      (set! rsi 0)
                      (set! rdi 8)
                      (set! r15 tmp-ra.36)
                      (jump L.*.2 rbp r15 rdi rsi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.proc.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.31 r15)
                              (set! bar.6.7 rdi)
                              (set! foo.7.6 rsi)
                              (set! foo.5.5 rdx)
                              (set! ball.1.4 rcx)
                              (set! foobar.8.3 r8)
                              (set! bat.4.2 r9)
                              (set! foobar.0.1 fv0)
                              (set! rax foobar.0.1)
                              (jump tmp-ra.31 rbp rax)))
                    (begin
                      (set! tmp-ra.32 r15)
                      (set! rax 22)
                      (jump tmp-ra.32 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.fn.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.28 r15)
                              (set! bat.3.2 rdi)
                              (set! bar.9.1 rsi)
                              (set! rax 6)
                              (jump tmp-ra.28 rbp rax)))
                    (define L.func.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.29 r15)
                        (set! foobar.4.4 rdi)
                        (set! bar.8.3 rsi)
                        (set! rax bar.8.3)
                        (jump tmp-ra.29 rbp rax)))
                    (begin
                      (set! tmp-ra.30 r15)
                      (set! rax 14)
                      (jump tmp-ra.30 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.eq?.2
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.30 r15)
                              (set! tmp.21 rdi)
                              (set! tmp.22 rsi)
                              (if (= tmp.21 tmp.22)
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.30 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.30 rbp rax)))))
                    (define L.proc.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.31 r15)
                        (set! foobar.4.6 rdi)
                        (set! foo.8.5 rsi)
                        (set! bar.0.4 rdx)
                        (set! foobar.3.3 rcx)
                        (set! bar.9.2 r8)
                        (set! bat.7.1 r9)
                        (set! rax 14)
                        (jump tmp-ra.31 rbp rax)))
                    (begin
                      (set! tmp-ra.32 r15)
                      (set! rsi 1871355128)
                      (set! rdi 27950)
                      (set! r15 tmp-ra.32)
                      (jump L.eq?.2 rbp r15 rdi rsi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.x.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.29 r15)
                              (set! bat.7.2 rdi)
                              (set! foobar.0.1 rsi)
                              (set! rax 8)
                              (jump tmp-ra.29 rbp rax)))
                    (define L.func.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.30 r15)
                        (set! bat.6.5 rdi)
                        (set! bar.1.4 rsi)
                        (set! foobar.2.3 rdx)
                        (set! rax 14)
                        (jump tmp-ra.30 rbp rax)))
                    (begin
                      (set! tmp-ra.31 r15)
                      (set! rax 30)
                      (jump tmp-ra.31 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.func.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.30 r15)
                              (set! foobar.0.3 rdi)
                              (set! ball.4.2 rsi)
                              (set! foo.8.1 rdx)
                              (set! rax ball.4.2)
                              (jump tmp-ra.30 rbp rax)))
                    (begin
                      (set! tmp-ra.31 r15)
                      (set! bar.3.6 6)
                      (set! ball.4.5 22)
                      (set! foo.1.4 22)
                      (set! rax 0)
                      (jump tmp-ra.31 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.func.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.30 r15)
                              (set! foobar.8.5 rdi)
                              (set! foo.9.4 rsi)
                              (set! foobar.2.3 rdx)
                              (set! bar.6.2 rcx)
                              (set! foobar.0.1 r8)
                              (set! rax 6)
                              (jump tmp-ra.30 rbp rax)))
                    (define L.proc.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.31 r15)
                        (set! bar.6.6 rdi)
                        (set! rax bar.6.6)
                        (jump tmp-ra.31 rbp rax)))
                    (begin
                      (set! tmp-ra.32 r15)
                      (set! rax 6)
                      (jump tmp-ra.32 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.fn.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.30 r15)
                              (set! bat.7.2 rdi)
                              (set! foobar.4.1 rsi)
                              (set! rax foobar.4.1)
                              (jump tmp-ra.30 rbp rax)))
                    (begin
                      (set! tmp-ra.31 r15)
                      (set! bar.3.6 30)
                      (set! bar.9.5 22)
                      (set! foobar.2.4 0)
                      (set! foo.5.3 0)
                      (set! rax 14)
                      (jump tmp-ra.31 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.x.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.31 r15)
                              (set! rax 22)
                              (jump tmp-ra.31 rbp rax)))
                    (define L.proc.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.32 r15)
                        (set! bat.2.7 rdi)
                        (set! bat.4.6 rsi)
                        (set! ball.0.5 rdx)
                        (set! foobar.9.4 rcx)
                        (set! foo.3.3 r8)
                        (set! ball.1.2 r9)
                        (set! foobar.8.1 fv0)
                        (set! rax 14)
                        (jump tmp-ra.32 rbp rax)))
                    (begin
                      (set! tmp-ra.33 r15)
                      (set! rax 29230)
                      (jump tmp-ra.33 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.proc.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.31 r15)
                              (set! bat.3.5 rdi)
                              (set! bat.0.4 rsi)
                              (set! foobar.6.3 rdx)
                              (set! foobar.9.2 rcx)
                              (set! foobar.1.1 r8)
                              (set! rax bat.0.4)
                              (jump tmp-ra.31 rbp rax)))
                    (define L.proc.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.32 r15)
                        (set! bar.7.7 rdi)
                        (set! bat.0.6 rsi)
                        (set! rax 6)
                        (jump tmp-ra.32 rbp rax)))
                    (begin
                      (set! tmp-ra.33 r15)
                      (set! rax 22)
                      (jump tmp-ra.33 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.tmp.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.30 r15)
                              (set! ball.2.5 rdi)
                              (set! foobar.3.4 rsi)
                              (set! foo.9.3 rdx)
                              (set! foo.6.2 rcx)
                              (set! bat.4.1 r8)
                              (set! rax foobar.3.4)
                              (jump tmp-ra.30 rbp rax)))
                    (define L.x.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.31 r15)
                        (set! bat.8.6 rdi)
                        (set! rax 6)
                        (jump tmp-ra.31 rbp rax)))
                    (begin
                      (set! tmp-ra.32 r15)
                      (if (begin
                            (set! tmp.33 25902)
                            (!= tmp.33 6))
                          (begin
                            (set! rax 30)
                            (jump tmp-ra.32 rbp rax))
                          (begin
                            (set! rax 22)
                            (jump tmp-ra.32 rbp rax))))))
(check-by-interp '(module ((new-frames ()))
                          (define L.void?.3
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.33 r15)
                              (set! tmp.28 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.37 tmp.28)
                                      (set! tmp.37 (bitwise-and tmp.37 255))
                                      (set! tmp.32 tmp.37))
                                    (= tmp.32 30))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.33 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.33 rbp rax)))))
                    (define L.x.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.34 r15)
                        (set! ball.0.1 rdi)
                        (set! rax ball.0.1)
                        (jump tmp-ra.34 rbp rax)))
                    (define L.tmp.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.35 r15)
                        (set! foo.1.8 rdi)
                        (set! bat.2.7 rsi)
                        (set! bat.9.6 rdx)
                        (set! foo.4.5 rcx)
                        (set! ball.5.4 r8)
                        (set! bat.6.3 r9)
                        (set! bat.7.2 fv0)
                        (set! rax 0)
                        (jump tmp-ra.35 rbp rax)))
                    (begin
                      (set! tmp-ra.36 r15)
                      (set! rdi 13102)
                      (set! r15 tmp-ra.36)
                      (jump L.void?.3 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.fn.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.29 r15)
                              (set! rax 30)
                              (jump tmp-ra.29 rbp rax)))
                    (define L.fn.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.30 r15)
                        (set! ball.8.4 rdi)
                        (set! foo.1.3 rsi)
                        (set! bar.7.2 rdx)
                        (set! foo.4.1 rcx)
                        (set! rax foo.4.1)
                        (jump tmp-ra.30 rbp rax)))
                    (define L.tmp.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.31 r15)
                        (set! bat.2.5 rdi)
                        (set! rax bat.2.5)
                        (jump tmp-ra.31 rbp rax)))
                    (begin
                      (set! tmp-ra.32 r15)
                      (set! rax 14)
                      (jump tmp-ra.32 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.func.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.32 r15)
                              (set! foobar.3.5 rdi)
                              (set! ball.2.4 rsi)
                              (set! ball.1.3 rdx)
                              (set! foobar.8.2 rcx)
                              (set! ball.9.1 r8)
                              (set! rax 6)
                              (jump tmp-ra.32 rbp rax)))
                    (define L.func.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.33 r15)
                        (set! ball.0.8 rdi)
                        (set! foobar.8.7 rsi)
                        (set! ball.5.6 rdx)
                        (set! rax 22574)
                        (jump tmp-ra.33 rbp rax)))
                    (begin
                      (set! tmp-ra.34 r15)
                      (set! rax 30)
                      (jump tmp-ra.34 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.boolean?.3
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.32 r15)
                              (set! tmp.25 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.36 tmp.25)
                                      (set! tmp.36 (bitwise-and tmp.36 247))
                                      (set! tmp.31 tmp.36))
                                    (= tmp.31 6))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.32 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.32 rbp rax)))))
                    (define L.proc.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.33 r15)
                        (set! ball.8.2 rdi)
                        (set! ball.9.1 rsi)
                        (set! rax 27694)
                        (jump tmp-ra.33 rbp rax)))
                    (define L.fn.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.34 r15)
                        (set! bar.0.7 rdi)
                        (set! ball.3.6 rsi)
                        (set! ball.8.5 rdx)
                        (set! ball.9.4 rcx)
                        (set! foobar.5.3 r8)
                        (set! rax 14)
                        (jump tmp-ra.34 rbp rax)))
                    (begin
                      (set! tmp-ra.35 r15)
                      (set! rdi 22)
                      (set! r15 tmp-ra.35)
                      (jump L.boolean?.3 rbp r15 rdi))))
(check-by-interp '(module ((new-frames (())))
                          (define L.ascii-char?.2
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.29 r15)
                              (set! tmp.25 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.32 tmp.25)
                                      (set! tmp.32 (bitwise-and tmp.32 255))
                                      (set! tmp.28 tmp.32))
                                    (= tmp.28 46))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.29 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.29 rbp rax)))))
                    (define L.eq?.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.30 r15)
                        (set! tmp.19 rdi)
                        (set! tmp.20 rsi)
                        (if (= tmp.19 tmp.20)
                            (begin
                              (set! rax 14)
                              (jump tmp-ra.30 rbp rax))
                            (begin
                              (set! rax 6)
                              (jump tmp-ra.30 rbp rax)))))
                    (begin
                      (set! tmp-ra.31 r15)
                      (return-point L.rp.3
                                    (begin
                                      (set! rsi 0)
                                      (set! rdi 22)
                                      (set! r15 L.rp.3)
                                      (jump L.eq?.1 rbp r15 rdi rsi)))
                      (set! foo.4.3 rax)
                      (set! foobar.1.2 6)
                      (set! ball.5.1 2031626432)
                      (if (begin
                            (set! tmp.33 14)
                            (!= tmp.33 6))
                          (set! ball.5.4 30)
                          (set! ball.5.4 foo.4.3))
                      (set! rdi ball.5.4)
                      (set! r15 tmp-ra.31)
                      (jump L.ascii-char?.2 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.fn.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.28 r15)
                              (set! foo.4.3 rdi)
                              (set! bat.8.2 rsi)
                              (set! bat.6.1 rdx)
                              (set! rax bat.8.2)
                              (jump tmp-ra.28 rbp rax)))
                    (define L.x.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.29 r15)
                        (set! foobar.3.4 rdi)
                        (set! rax 22)
                        (jump tmp-ra.29 rbp rax)))
                    (define L.func.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.30 r15)
                        (set! rax 6)
                        (jump tmp-ra.30 rbp rax)))
                    (begin
                      (set! tmp-ra.31 r15)
                      (if (begin
                            (set! tmp.32 30)
                            (!= tmp.32 6))
                          (begin
                            (set! rax 30)
                            (jump tmp-ra.31 rbp rax))
                          (begin
                            (set! rax 29230)
                            (jump tmp-ra.31 rbp rax))))))
(check-by-interp '(module ((new-frames ()))
                          (define L.ascii-char?.3
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.32 r15)
                              (set! tmp.28 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.36 tmp.28)
                                      (set! tmp.36 (bitwise-and tmp.36 255))
                                      (set! tmp.31 tmp.36))
                                    (= tmp.31 46))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.32 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.32 rbp rax)))))
                    (define L.func.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.33 r15)
                        (set! foobar.8.5 rdi)
                        (set! ball.0.4 rsi)
                        (set! foobar.2.3 rdx)
                        (set! foobar.6.2 rcx)
                        (set! bat.9.1 r8)
                        (set! rax 6)
                        (jump tmp-ra.33 rbp rax)))
                    (define L.func.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.34 r15)
                        (set! foobar.2.7 rdi)
                        (set! foo.1.6 rsi)
                        (set! rax foobar.2.7)
                        (jump tmp-ra.34 rbp rax)))
                    (begin
                      (set! tmp-ra.35 r15)
                      (set! rdi 6)
                      (set! r15 tmp-ra.35)
                      (jump L.ascii-char?.3 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.proc.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.36 r15)
                              (set! ball.4.7 rdi)
                              (set! foobar.7.6 rsi)
                              (set! foo.6.5 rdx)
                              (set! bar.9.4 rcx)
                              (set! bat.3.3 r8)
                              (set! foobar.0.2 r9)
                              (set! ball.8.1 fv0)
                              (set! rax 14)
                              (jump tmp-ra.36 rbp rax)))
                    (define L.x.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.37 r15)
                        (set! bat.3.12 rdi)
                        (set! bar.9.11 rsi)
                        (set! foo.1.10 rdx)
                        (set! ball.4.9 rcx)
                        (set! bar.5.8 r8)
                        (set! rax foo.1.10)
                        (jump tmp-ra.37 rbp rax)))
                    (begin
                      (set! tmp-ra.38 r15)
                      (set! rax 6)
                      (jump tmp-ra.38 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.ascii-char?.3
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.34 r15)
                              (set! tmp.30 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.38 tmp.30)
                                      (set! tmp.38 (bitwise-and tmp.38 255))
                                      (set! tmp.33 tmp.38))
                                    (= tmp.33 46))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.34 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.34 rbp rax)))))
                    (define L.func.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.35 r15)
                        (set! foobar.4.5 rdi)
                        (set! bar.8.4 rsi)
                        (set! bat.7.3 rdx)
                        (set! bar.1.2 rcx)
                        (set! foo.9.1 r8)
                        (set! rax 14)
                        (jump tmp-ra.35 rbp rax)))
                    (define L.func.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.36 r15)
                        (set! foobar.3.9 rdi)
                        (set! foo.6.8 rsi)
                        (set! foobar.4.7 rdx)
                        (set! bar.1.6 rcx)
                        (set! rax 6)
                        (jump tmp-ra.36 rbp rax)))
                    (begin
                      (set! tmp-ra.37 r15)
                      (set! rdi 20526)
                      (set! r15 tmp-ra.37)
                      (jump L.ascii-char?.3 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.x.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.32 r15)
                              (set! ball.3.1 rdi)
                              (set! rax 0)
                              (jump tmp-ra.32 rbp rax)))
                    (define L.proc.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.33 r15)
                        (set! bat.1.6 rdi)
                        (set! foobar.8.5 rsi)
                        (set! foobar.5.4 rdx)
                        (set! ball.3.3 rcx)
                        (set! bat.7.2 r8)
                        (set! rax foobar.5.4)
                        (jump tmp-ra.33 rbp rax)))
                    (begin
                      (set! tmp-ra.34 r15)
                      (set! bat.7.8 22)
                      (set! foobar.2.7 6)
                      (set! rax 22)
                      (jump tmp-ra.34 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.boolean?.3
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.37 r15)
                              (set! tmp.30 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.41 tmp.30)
                                      (set! tmp.41 (bitwise-and tmp.41 247))
                                      (set! tmp.36 tmp.41))
                                    (= tmp.36 6))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.37 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.37 rbp rax)))))
                    (define L.tmp.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.38 r15)
                        (set! ball.3.5 rdi)
                        (set! bat.8.4 rsi)
                        (set! foobar.7.3 rdx)
                        (set! bar.6.2 rcx)
                        (set! bar.5.1 r8)
                        (set! rax bar.5.1)
                        (jump tmp-ra.38 rbp rax)))
                    (define L.tmp.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.39 r15)
                        (set! bat.2.12 rdi)
                        (set! foobar.4.11 rsi)
                        (set! bar.6.10 rdx)
                        (set! foobar.7.9 rcx)
                        (set! bar.5.8 r8)
                        (set! ball.3.7 r9)
                        (set! foo.9.6 fv0)
                        (set! rax 0)
                        (jump tmp-ra.39 rbp rax)))
                    (begin
                      (set! tmp-ra.40 r15)
                      (set! rdi 30)
                      (set! r15 tmp-ra.40)
                      (jump L.boolean?.3 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.ascii-char?.3
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.36 r15)
                              (set! tmp.32 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.40 tmp.32)
                                      (set! tmp.40 (bitwise-and tmp.40 255))
                                      (set! tmp.35 tmp.40))
                                    (= tmp.35 46))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.36 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.36 rbp rax)))))
                    (define L.x.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.37 r15)
                        (set! foo.8.4 rdi)
                        (set! foobar.6.3 rsi)
                        (set! bat.0.2 rdx)
                        (set! ball.7.1 rcx)
                        (set! rax ball.7.1)
                        (jump tmp-ra.37 rbp rax)))
                    (define L.fn.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.38 r15)
                        (set! bat.3.11 rdi)
                        (set! foobar.9.10 rsi)
                        (set! foobar.5.9 rdx)
                        (set! foo.8.8 rcx)
                        (set! bat.4.7 r8)
                        (set! ball.7.6 r9)
                        (set! foo.2.5 fv0)
                        (set! rax -3529966152)
                        (jump tmp-ra.38 rbp rax)))
                    (begin
                      (set! tmp-ra.39 r15)
                      (set! rdi 30)
                      (set! r15 tmp-ra.39)
                      (jump L.ascii-char?.3 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.*.4
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.37 r15)
                              (set! tmp.9 rdi)
                              (set! tmp.10 rsi)
                              (if (begin
                                    (if (begin
                                          (begin
                                            (set! tmp.42 tmp.10)
                                            (set! tmp.42 (bitwise-and tmp.42 7))
                                            (set! tmp.33 tmp.42))
                                          (= tmp.33 0))
                                        (set! tmp.32 14)
                                        (set! tmp.32 6))
                                    (!= tmp.32 6))
                                  (if (begin
                                        (if (begin
                                              (begin
                                                (set! tmp.43 tmp.9)
                                                (set! tmp.43 (bitwise-and tmp.43 7))
                                                (set! tmp.35 tmp.43))
                                              (= tmp.35 0))
                                            (set! tmp.34 14)
                                            (set! tmp.34 6))
                                        (!= tmp.34 6))
                                      (begin
                                        (set! tmp.44 tmp.10)
                                        (set! tmp.44 (arithmetic-shift-right tmp.44 3))
                                        (set! tmp.36 tmp.44)
                                        (set! tmp.45 tmp.9)
                                        (set! tmp.45 (* tmp.45 tmp.36))
                                        (set! rax tmp.45)
                                        (jump tmp-ra.37 rbp rax))
                                      (begin
                                        (set! rax 318)
                                        (jump tmp-ra.37 rbp rax)))
                                  (begin
                                    (set! rax 318)
                                    (jump tmp-ra.37 rbp rax)))))
                    (define L.proc.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.38 r15)
                        (set! foo.9.2 rdi)
                        (set! foo.0.1 rsi)
                        (set! rax 14)
                        (jump tmp-ra.38 rbp rax)))
                    (define L.fn.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.39 r15)
                        (set! bat.3.5 rdi)
                        (set! bat.1.4 rsi)
                        (set! bat.7.3 rdx)
                        (set! rax bat.1.4)
                        (jump tmp-ra.39 rbp rax)))
                    (define L.func.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.40 r15)
                        (set! foo.2.7 rdi)
                        (set! foo.9.6 rsi)
                        (set! rax 0)
                        (jump tmp-ra.40 rbp rax)))
                    (begin
                      (set! tmp-ra.41 r15)
                      (set! foo.9.8 14)
                      (set! rsi 8)
                      (set! rdi 4105232688)
                      (set! r15 tmp-ra.41)
                      (jump L.*.4 rbp r15 rdi rsi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.proc.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.37 r15)
                              (set! foobar.1.5 rdi)
                              (set! foo.5.4 rsi)
                              (set! bat.4.3 rdx)
                              (set! foo.2.2 rcx)
                              (set! bat.0.1 r8)
                              (set! rax 14)
                              (jump tmp-ra.37 rbp rax)))
                    (define L.tmp.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.38 r15)
                        (set! bat.0.6 rdi)
                        (set! rax 14)
                        (jump tmp-ra.38 rbp rax)))
                    (define L.x.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.39 r15)
                        (set! ball.9.13 rdi)
                        (set! bar.7.12 rsi)
                        (set! bat.4.11 rdx)
                        (set! foo.2.10 rcx)
                        (set! foobar.1.9 r8)
                        (set! foo.3.8 r9)
                        (set! foo.6.7 fv0)
                        (set! rax 6)
                        (jump tmp-ra.39 rbp rax)))
                    (begin
                      (set! tmp-ra.40 r15)
                      (set! rax 0)
                      (jump tmp-ra.40 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.fn.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.35 r15)
                              (set! foobar.4.6 rdi)
                              (set! foo.3.5 rsi)
                              (set! bar.0.4 rdx)
                              (set! foo.7.3 rcx)
                              (set! bar.8.2 r8)
                              (set! foobar.2.1 r9)
                              (set! rax 22)
                              (jump tmp-ra.35 rbp rax)))
                    (define L.proc.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.36 r15)
                        (set! foo.7.9 rdi)
                        (set! foo.3.8 rsi)
                        (set! bar.0.7 rdx)
                        (set! rax 14)
                        (jump tmp-ra.36 rbp rax)))
                    (define L.x.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.37 r15)
                        (set! foobar.2.11 rdi)
                        (set! bar.8.10 rsi)
                        (set! rax foobar.2.11)
                        (jump tmp-ra.37 rbp rax)))
                    (begin
                      (set! tmp-ra.38 r15)
                      (set! rax 22)
                      (jump tmp-ra.38 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.empty?.3
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.39 r15)
                              (set! tmp.33 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.43 tmp.33)
                                      (set! tmp.43 (bitwise-and tmp.43 255))
                                      (set! tmp.38 tmp.43))
                                    (= tmp.38 22))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.39 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.39 rbp rax)))))
                    (define L.tmp.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.40 r15)
                        (set! bar.2.7 rdi)
                        (set! foobar.0.6 rsi)
                        (set! foobar.9.5 rdx)
                        (set! ball.1.4 rcx)
                        (set! bat.3.3 r8)
                        (set! bar.4.2 r9)
                        (set! ball.8.1 fv0)
                        (set! rax foobar.0.6)
                        (jump tmp-ra.40 rbp rax)))
                    (define L.x.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.41 r15)
                        (set! foobar.0.14 rdi)
                        (set! bar.2.13 rsi)
                        (set! bar.4.12 rdx)
                        (set! ball.6.11 rcx)
                        (set! ball.5.10 r8)
                        (set! bat.3.9 r9)
                        (set! foobar.9.8 fv0)
                        (set! rax 6)
                        (jump tmp-ra.41 rbp rax)))
                    (begin
                      (set! tmp-ra.42 r15)
                      (set! rdi 8)
                      (set! r15 tmp-ra.42)
                      (jump L.empty?.3 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.proc.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.34 r15)
                              (set! foobar.8.7 rdi)
                              (set! foobar.2.6 rsi)
                              (set! bat.9.5 rdx)
                              (set! bar.6.4 rcx)
                              (set! bar.3.3 r8)
                              (set! foobar.0.2 r9)
                              (set! bar.4.1 fv0)
                              (set! rax 8)
                              (jump tmp-ra.34 rbp rax)))
                    (define L.func.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.35 r15)
                        (set! rax 14)
                        (jump tmp-ra.35 rbp rax)))
                    (define L.fn.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.36 r15)
                        (set! foobar.7.10 rdi)
                        (set! ball.1.9 rsi)
                        (set! foobar.0.8 rdx)
                        (set! rax ball.1.9)
                        (jump tmp-ra.36 rbp rax)))
                    (begin
                      (set! tmp-ra.37 r15)
                      (if (begin
                            (set! tmp.38 6)
                            (!= tmp.38 6))
                          (begin
                            (set! rax 14)
                            (jump tmp-ra.37 rbp rax))
                          (begin
                            (set! rax 22)
                            (jump tmp-ra.37 rbp rax))))))
(check-by-interp '(module ((new-frames ()))
                          (define L.ascii-char?.4
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.36 r15)
                              (set! tmp.32 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.41 tmp.32)
                                      (set! tmp.41 (bitwise-and tmp.41 255))
                                      (set! tmp.35 tmp.41))
                                    (= tmp.35 46))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.36 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.36 rbp rax)))))
                    (define L.fn.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.37 r15)
                        (set! foobar.3.7 rdi)
                        (set! bar.4.6 rsi)
                        (set! bat.6.5 rdx)
                        (set! foo.9.4 rcx)
                        (set! ball.0.3 r8)
                        (set! foobar.5.2 r9)
                        (set! foobar.8.1 fv0)
                        (set! rax bat.6.5)
                        (jump tmp-ra.37 rbp rax)))
                    (define L.tmp.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.38 r15)
                        (set! ball.1.8 rdi)
                        (set! rax ball.1.8)
                        (jump tmp-ra.38 rbp rax)))
                    (define L.tmp.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.39 r15)
                        (set! foobar.8.11 rdi)
                        (set! foobar.5.10 rsi)
                        (set! ball.0.9 rdx)
                        (set! rax 6)
                        (jump tmp-ra.39 rbp rax)))
                    (begin
                      (set! tmp-ra.40 r15)
                      (set! rdi 8)
                      (set! r15 tmp-ra.40)
                      (jump L.ascii-char?.4 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.boolean?.4
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.38 r15)
                              (set! tmp.31 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.43 tmp.31)
                                      (set! tmp.43 (bitwise-and tmp.43 247))
                                      (set! tmp.37 tmp.43))
                                    (= tmp.37 6))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.38 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.38 rbp rax)))))
                    (define L.tmp.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.39 r15)
                        (set! foo.4.3 rdi)
                        (set! bar.6.2 rsi)
                        (set! foobar.0.1 rdx)
                        (set! rax bar.6.2)
                        (jump tmp-ra.39 rbp rax)))
                    (define L.fn.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.40 r15)
                        (set! foo.1.7 rdi)
                        (set! ball.9.6 rsi)
                        (set! foobar.3.5 rdx)
                        (set! bat.2.4 rcx)
                        (set! rax foo.1.7)
                        (jump tmp-ra.40 rbp rax)))
                    (define L.x.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.41 r15)
                        (set! bar.6.13 rdi)
                        (set! bat.2.12 rsi)
                        (set! foobar.7.11 rdx)
                        (set! foo.1.10 rcx)
                        (set! ball.9.9 r8)
                        (set! foobar.0.8 r9)
                        (set! rax 8)
                        (jump tmp-ra.41 rbp rax)))
                    (begin
                      (set! tmp-ra.42 r15)
                      (set! rdi 6)
                      (set! r15 tmp-ra.42)
                      (jump L.boolean?.4 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.ascii-char?.4
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.41 r15)
                              (set! tmp.37 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.46 tmp.37)
                                      (set! tmp.46 (bitwise-and tmp.46 255))
                                      (set! tmp.40 tmp.46))
                                    (= tmp.40 46))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.41 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.41 rbp rax)))))
                    (define L.tmp.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.42 r15)
                        (set! bat.9.7 rdi)
                        (set! bar.0.6 rsi)
                        (set! bat.4.5 rdx)
                        (set! bar.8.4 rcx)
                        (set! bar.2.3 r8)
                        (set! bar.5.2 r9)
                        (set! ball.3.1 fv0)
                        (set! rax bar.5.2)
                        (jump tmp-ra.42 rbp rax)))
                    (define L.x.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.43 r15)
                        (set! ball.3.12 rdi)
                        (set! bar.0.11 rsi)
                        (set! foo.7.10 rdx)
                        (set! bar.8.9 rcx)
                        (set! bar.5.8 r8)
                        (set! rax 0)
                        (jump tmp-ra.43 rbp rax)))
                    (define L.func.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.44 r15)
                        (set! foo.7.16 rdi)
                        (set! bar.2.15 rsi)
                        (set! bar.8.14 rdx)
                        (set! foobar.1.13 rcx)
                        (set! rax 8)
                        (jump tmp-ra.44 rbp rax)))
                    (begin
                      (set! tmp-ra.45 r15)
                      (set! rdi 22)
                      (set! r15 tmp-ra.45)
                      (jump L.ascii-char?.4 rbp r15 rdi))))
(check-by-interp '(module ((new-frames (())))
                          (define L.<.5
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.41 r15)
                              (set! tmp.20 rdi)
                              (set! tmp.21 rsi)
                              (if (begin
                                    (if (begin
                                          (begin
                                            (set! tmp.47 tmp.21)
                                            (set! tmp.47 (bitwise-and tmp.47 7))
                                            (set! tmp.38 tmp.47))
                                          (= tmp.38 0))
                                        (set! tmp.37 14)
                                        (set! tmp.37 6))
                                    (!= tmp.37 6))
                                  (if (begin
                                        (if (begin
                                              (begin
                                                (set! tmp.48 tmp.20)
                                                (set! tmp.48 (bitwise-and tmp.48 7))
                                                (set! tmp.40 tmp.48))
                                              (= tmp.40 0))
                                            (set! tmp.39 14)
                                            (set! tmp.39 6))
                                        (!= tmp.39 6))
                                      (if (< tmp.20 tmp.21)
                                          (begin
                                            (set! rax 14)
                                            (jump tmp-ra.41 rbp rax))
                                          (begin
                                            (set! rax 6)
                                            (jump tmp-ra.41 rbp rax)))
                                      (begin
                                        (set! rax 1086)
                                        (jump tmp-ra.41 rbp rax)))
                                  (begin
                                    (set! rax 1086)
                                    (jump tmp-ra.41 rbp rax)))))
                    (define L.eq?.4
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.42 r15)
                        (set! tmp.28 rdi)
                        (set! tmp.29 rsi)
                        (if (= tmp.28 tmp.29)
                            (begin
                              (set! rax 14)
                              (jump tmp-ra.42 rbp rax))
                            (begin
                              (set! rax 6)
                              (jump tmp-ra.42 rbp rax)))))
                    (define L.proc.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.43 r15)
                        (set! bat.2.4 rdi)
                        (set! ball.8.3 rsi)
                        (set! foobar.7.2 rdx)
                        (set! foo.1.1 rcx)
                        (set! rax 14)
                        (jump tmp-ra.43 rbp rax)))
                    (define L.proc.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.44 r15)
                        (set! bat.5.9 rdi)
                        (set! foo.6.8 rsi)
                        (set! foobar.3.7 rdx)
                        (set! foobar.7.6 rcx)
                        (set! bat.0.5 r8)
                        (set! rax 6)
                        (jump tmp-ra.44 rbp rax)))
                    (define L.x.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.45 r15)
                        (set! bar.4.12 rdi)
                        (set! foobar.3.11 rsi)
                        (set! bar.9.10 rdx)
                        (set! rax 0)
                        (jump tmp-ra.45 rbp rax)))
                    (begin
                      (set! tmp-ra.46 r15)
                      (return-point L.rp.6
                                    (begin
                                      (set! rsi 6)
                                      (set! rdi 8)
                                      (set! r15 L.rp.6)
                                      (jump L.eq?.4 rbp r15 rdi rsi)))
                      (set! bat.5.13 rax)
                      (set! rsi 8)
                      (set! rdi -2229142488)
                      (set! r15 tmp-ra.46)
                      (jump L.<.5 rbp r15 rdi rsi))))
(check-by-interp '(module ((new-frames (())))
                          (define L.empty?.4
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.41 r15)
                              (set! tmp.35 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.46 tmp.35)
                                      (set! tmp.46 (bitwise-and tmp.46 255))
                                      (set! tmp.40 tmp.46))
                                    (= tmp.40 22))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.41 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.41 rbp rax)))))
                    (define L.proc.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.42 r15)
                        (set! foo.9.6 rdi)
                        (set! ball.5.5 rsi)
                        (set! ball.4.4 rdx)
                        (set! bar.8.3 rcx)
                        (set! ball.1.2 r8)
                        (set! bat.7.1 r9)
                        (set! rax 6)
                        (jump tmp-ra.42 rbp rax)))
                    (define L.proc.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.43 r15)
                        (set! bar.0.8 rdi)
                        (set! foo.6.7 rsi)
                        (set! rax 6)
                        (jump tmp-ra.43 rbp rax)))
                    (define L.fn.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.44 r15)
                        (set! ball.5.15 rdi)
                        (set! bar.8.14 rsi)
                        (set! foo.9.13 rdx)
                        (set! bat.7.12 rcx)
                        (set! ball.1.11 r8)
                        (set! foo.6.10 r9)
                        (set! bar.0.9 fv0)
                        (set! rax 14)
                        (jump tmp-ra.44 rbp rax)))
                    (begin
                      (set! tmp-ra.45 r15)
                      (if (begin
                            (set! tmp.47 30)
                            (!= tmp.47 6))
                          (begin
                            (return-point L.rp.5
                                          (begin
                                            (set! rdi 6)
                                            (set! r15 L.rp.5)
                                            (jump L.empty?.4 rbp r15 rdi)))
                            (set! ball.1.16 rax)
                            (set! rax ball.1.16)
                            (jump tmp-ra.45 rbp rax))
                          (begin
                            (set! rax 8)
                            (jump tmp-ra.45 rbp rax))))))
(check-by-interp '(module ((new-frames ()))
                          (define L.fixnum?.4
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.45 r15)
                              (set! tmp.37 rdi)
                              (if (begin
                                    (begin
                                      (set! tmp.50 tmp.37)
                                      (set! tmp.50 (bitwise-and tmp.50 7))
                                      (set! tmp.44 tmp.50))
                                    (= tmp.44 0))
                                  (begin
                                    (set! rax 14)
                                    (jump tmp-ra.45 rbp rax))
                                  (begin
                                    (set! rax 6)
                                    (jump tmp-ra.45 rbp rax)))))
                    (define L.x.0.1
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.46 r15)
                        (set! bar.0.7 rdi)
                        (set! foobar.1.6 rsi)
                        (set! bat.4.5 rdx)
                        (set! foobar.5.4 rcx)
                        (set! foo.8.3 r8)
                        (set! bat.9.2 r9)
                        (set! bat.2.1 fv0)
                        (set! rax bar.0.7)
                        (jump tmp-ra.46 rbp rax)))
                    (define L.tmp.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.47 r15)
                        (set! foobar.3.13 rdi)
                        (set! foobar.1.12 rsi)
                        (set! bat.9.11 rdx)
                        (set! foobar.5.10 rcx)
                        (set! bar.6.9 r8)
                        (set! bat.4.8 r9)
                        (set! rax 0)
                        (jump tmp-ra.47 rbp rax)))
                    (define L.tmp.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.48 r15)
                        (set! bat.2.20 rdi)
                        (set! foobar.3.19 rsi)
                        (set! bar.0.18 rdx)
                        (set! foobar.5.17 rcx)
                        (set! bar.6.16 r8)
                        (set! ball.7.15 r9)
                        (set! foo.8.14 fv0)
                        (set! rax 6)
                        (jump tmp-ra.48 rbp rax)))
                    (begin
                      (set! tmp-ra.49 r15)
                      (set! rdi 6)
                      (set! r15 tmp-ra.49)
                      (jump L.fixnum?.4 rbp r15 rdi))))
(check-by-interp '(module ((new-frames ()))
                          (define L.tmp.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.42 r15)
                              (set! foo.3.6 rdi)
                              (set! foo.0.5 rsi)
                              (set! ball.9.4 rdx)
                              (set! ball.1.3 rcx)
                              (set! ball.6.2 r8)
                              (set! foobar.5.1 r9)
                              (set! rax foo.3.6)
                              (jump tmp-ra.42 rbp rax)))
                    (define L.x.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.43 r15)
                        (set! foobar.5.11 rdi)
                        (set! ball.7.10 rsi)
                        (set! foo.3.9 rdx)
                        (set! ball.1.8 rcx)
                        (set! ball.6.7 r8)
                        (set! rax 2370093256)
                        (jump tmp-ra.43 rbp rax)))
                    (define L.tmp.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.44 r15)
                        (set! ball.6.15 rdi)
                        (set! ball.7.14 rsi)
                        (set! foo.2.13 rdx)
                        (set! foobar.5.12 rcx)
                        (set! rax ball.6.15)
                        (jump tmp-ra.44 rbp rax)))
                    (begin
                      (set! tmp-ra.45 r15)
                      (set! foobar.8.18 22)
                      (set! ball.6.17 22)
                      (set! foo.0.16 19502)
                      (set! rax 29230)
                      (jump tmp-ra.45 rbp rax))))
(check-by-interp '(module ((new-frames ()))
                          (define L.fn.0.1
                            ((new-frames ()))
                            (begin
                              (set! tmp-ra.48 r15)
                              (set! ball.6.7 rdi)
                              (set! bar.9.6 rsi)
                              (set! bat.8.5 rdx)
                              (set! ball.7.4 rcx)
                              (set! bat.4.3 r8)
                              (set! bar.1.2 r9)
                              (set! foobar.5.1 fv0)
                              (set! rax 8)
                              (jump tmp-ra.48 rbp rax)))
                    (define L.proc.1.2
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.49 r15)
                        (set! foobar.5.14 rdi)
                        (set! bar.1.13 rsi)
                        (set! ball.7.12 rdx)
                        (set! bat.8.11 rcx)
                        (set! bat.4.10 r8)
                        (set! ball.3.9 r9)
                        (set! ball.6.8 fv0)
                        (set! rax ball.7.12)
                        (jump tmp-ra.49 rbp rax)))
                    (define L.x.2.3
                      ((new-frames ()))
                      (begin
                        (set! tmp-ra.50 r15)
                        (set! ball.6.20 rdi)
                        (set! bar.9.19 rsi)
                        (set! ball.3.18 rdx)
                        (set! foobar.5.17 rcx)
                        (set! ball.7.16 r8)
                        (set! bat.8.15 r9)
                        (set! rax 6)
                        (jump tmp-ra.50 rbp rax)))
                    (begin
                      (set! tmp-ra.51 r15)
                      (set! ball.3.24 30)
                      (set! foobar.5.23 21550)
                      (set! foo.2.22 22)
                      (set! ball.6.21 22)
                      (set! rax ball.6.21)
                      (jump tmp-ra.51 rbp rax))))
;;; Added by Trevor on 2026-03-19
