#lang racket
(require rackunit
         cpsc411/langs/v7
         (only-in "../sequentialize-let.rkt" sequentialize-let))

(define (check-values-bits-lang-v7 p)
  (if (values-bits-lang-v7? p) p #f))

(define (check-imp-mf-lang-v7 p)
  (if (imp-mf-lang-v7? p) p #f))

(define-syntax-rule (check-by-interp p)
  (check-equal? (interp-values-bits-lang-v7 (check-values-bits-lang-v7 p))
                (interp-imp-mf-lang-v7 (check-imp-mf-lang-v7 (sequentialize-let p)))))

;;; Added by Trevor on 2026-03-19

(check-by-interp '(module 0))
(check-by-interp '(module 8))
(check-by-interp '(module 6))
(check-by-interp '(module 14))
(check-by-interp '(module 13102))
(check-by-interp '(module 18990))
(check-by-interp '(module 30))
(check-by-interp
 '(module (define L.+.1
            (lambda (tmp.3 tmp.4)
              (if (let ([tmp.24 (if (let ([tmp.25 (bitwise-and tmp.4 7)]) (= tmp.25 0)) 14 6)])
                    (!= tmp.24 6))
                  (if (let ([tmp.26 (if (let ([tmp.27 (bitwise-and tmp.3 7)]) (= tmp.27 0)) 14 6)])
                        (!= tmp.26 6))
                      (+ tmp.3 tmp.4)
                      574)
                  574)))
          (call L.+.1 0 0)
    ))
(check-by-interp '(module (define L.not.1 (lambda (tmp.23) (if (!= tmp.23 6) 6 14))) (call L.not.1 6)
                    ))
(check-by-interp '(module (define L.not.1 (lambda (tmp.23) (if (!= tmp.23 6) 6 14))) (call L.not.1 14)
                    ))
(check-by-interp '(module (if (!= 6 6) 22 0)))
(check-by-interp '(module (define L.fixnum?.1
                            (lambda (tmp.17)
                              (if (let ([tmp.24 (bitwise-and tmp.17 7)]) (= tmp.24 0)) 14 6)))
                          (call L.fixnum?.1 14)
                    ))
(check-by-interp '(module (define L.error?.1
                            (lambda (tmp.22)
                              (if (let ([tmp.24 (bitwise-and tmp.22 255)]) (= tmp.24 62)) 14 6)))
                          (call L.error?.1 30)
                    ))
(check-by-interp '(module (define L.fixnum?.1
                            (lambda (tmp.17)
                              (if (let ([tmp.24 (bitwise-and tmp.17 7)]) (= tmp.24 0)) 14 6)))
                          (call L.fixnum?.1 22)
                    ))
(check-by-interp '(module (define L.ascii-char?.1
                            (lambda (tmp.21)
                              (if (let ([tmp.24 (bitwise-and tmp.21 255)]) (= tmp.24 46)) 14 6)))
                          (call L.ascii-char?.1 14)
                    ))
(check-by-interp '(module (define L.boolean?.1
                            (lambda (tmp.18)
                              (if (let ([tmp.24 (bitwise-and tmp.18 247)]) (= tmp.24 6)) 14 6)))
                          (call L.boolean?.1 30)
                    ))
(check-by-interp '(module (define L.ascii-char?.1
                            (lambda (tmp.21)
                              (if (let ([tmp.24 (bitwise-and tmp.21 255)]) (= tmp.24 46)) 14 6)))
                          (call L.ascii-char?.1 30)
                    ))
(check-by-interp '(module (let ([foobar.8.1 6]) foobar.8.1)))
(check-by-interp '(module (let ([foobar.2.2 25646]
                                [bat.1.1 28206])
                            foobar.2.2)))
(check-by-interp '(module (define L.void?.2
                            (lambda (tmp.20)
                              (if (let ([tmp.24 (bitwise-and tmp.20 255)]) (= tmp.24 30)) 14 6)))
                          (define L.proc.0.1 (lambda () 14))
                    (call L.void?.2 8)))
(check-by-interp
 '(module (define L.<=.2
            (lambda (tmp.10 tmp.11)
              (if (let ([tmp.25 (if (let ([tmp.26 (bitwise-and tmp.11 7)]) (= tmp.26 0)) 14 6)])
                    (!= tmp.25 6))
                  (if (let ([tmp.27 (if (let ([tmp.28 (bitwise-and tmp.10 7)]) (= tmp.28 0)) 14 6)])
                        (!= tmp.27 6))
                      (if (<= tmp.10 tmp.11) 14 6)
                      1342)
                  1342)))
          (define L.tmp.0.1 (lambda (foo.9.1) 14))
    (call L.<=.2 0 0)))
(check-by-interp '(module (let ([foobar.1.3 6]
                                [foo.2.2 22]
                                [foo.5.1 1086429096])
                            22)))
(check-by-interp
 '(module (define L.x.0.1 (lambda (foo.4.5 ball.9.4 foo.8.3 ball.3.2 ball.5.1) -3961536528)) 14
    ))
(check-by-interp
 '(module (define L.func.0.1 (lambda (foobar.2.6 foobar.9.5 bat.5.4 bar.8.3 ball.0.2 foo.1.1) 8)) 6
    ))
(check-by-interp '(module (define L.fn.0.1 (lambda (foo.5.1) 30)) (define L.tmp.1.2 (lambda () 22))
                    19502))
(check-by-interp '(module (define L.func.0.1 (lambda (bar.9.4 foobar.0.3 bar.7.2 ball.1.1) 6))
                          (if (!= 19246 6) 14 30)
                    ))
(check-by-interp '(module (define L.eq?.2 (lambda (tmp.19 tmp.20) (if (= tmp.19 tmp.20) 14 6)))
                          (define L.proc.0.1 (lambda (foobar.7.4 bar.4.3 bat.2.2 foo.8.1) bar.4.3))
                    (call L.eq?.2 24878 8)))
(check-by-interp
 '(module (define L.*.2
            (lambda (tmp.6 tmp.7)
              (if (let ([tmp.29 (if (let ([tmp.30 (bitwise-and tmp.7 7)]) (= tmp.30 0)) 14 6)])
                    (!= tmp.29 6))
                  (if (let ([tmp.31 (if (let ([tmp.32 (bitwise-and tmp.6 7)]) (= tmp.32 0)) 14 6)])
                        (!= tmp.31 6))
                      (let ([tmp.33 (arithmetic-shift-right tmp.7 3)]) (* tmp.6 tmp.33))
                      318)
                  318)))
          (define L.func.0.1 (lambda (bat.7.5 ball.3.4 bat.4.3 ball.0.2 bar.2.1) ball.0.2))
    (call L.*.2 8 0)))
(check-by-interp '(module (define L.proc.0.1
                            (lambda (bar.6.7 foo.7.6 foo.5.5 ball.1.4 foobar.8.3 bat.4.2 foobar.0.1)
                              foobar.0.1))
                          22
                    ))
(check-by-interp '(module (define L.fn.0.1 (lambda (bat.3.2 bar.9.1) 6))
                          (define L.func.1.2 (lambda (foobar.4.4 bar.8.3) bar.8.3))
                    14))
(check-by-interp '(module (define L.eq?.2 (lambda (tmp.21 tmp.22) (if (= tmp.21 tmp.22) 14 6)))
                          (define L.proc.0.1
                            (lambda (foobar.4.6 foo.8.5 bar.0.4 foobar.3.3 bar.9.2 bat.7.1) 14))
                    (call L.eq?.2 27950 1871355128)))
(check-by-interp '(module (define L.x.0.1 (lambda (bat.7.2 foobar.0.1) 8))
                          (define L.func.1.2 (lambda (bat.6.5 bar.1.4 foobar.2.3) 14))
                    30))
(check-by-interp '(module (define L.func.0.1 (lambda (foobar.0.3 ball.4.2 foo.8.1) ball.4.2))
                          (let ([bar.3.6 6]
                                [ball.4.5 22]
                                [foo.1.4 22])
                            0)
                    ))
(check-by-interp '(module (define L.func.0.1
                            (lambda (foobar.8.5 foo.9.4 foobar.2.3 bar.6.2 foobar.0.1) 6))
                          (define L.proc.1.2 (lambda (bar.6.6) bar.6.6))
                    6))
(check-by-interp '(module (define L.fn.0.1 (lambda (bat.7.2 foobar.4.1) foobar.4.1))
                          (let ([bar.3.6 30]
                                [bar.9.5 22]
                                [foobar.2.4 0]
                                [foo.5.3 0])
                            14)
                    ))
(check-by-interp '(module (define L.x.0.1 (lambda () 22))
                          (define L.proc.1.2
                            (lambda (bat.2.7 bat.4.6 ball.0.5 foobar.9.4 foo.3.3 ball.1.2 foobar.8.1)
                              14))
                    29230))
(check-by-interp '(module (define L.proc.0.1
                            (lambda (bat.3.5 bat.0.4 foobar.6.3 foobar.9.2 foobar.1.1) bat.0.4))
                          (define L.proc.1.2 (lambda (bar.7.7 bat.0.6) 6))
                    22))
(check-by-interp '(module (define L.tmp.0.1
                            (lambda (ball.2.5 foobar.3.4 foo.9.3 foo.6.2 bat.4.1) foobar.3.4))
                          (define L.x.1.2 (lambda (bat.8.6) 6))
                    (if (!= 25902 6) 30 22)))
(check-by-interp
 '(module (define L.void?.3
            (lambda (tmp.28) (if (let ([tmp.32 (bitwise-and tmp.28 255)]) (= tmp.32 30)) 14 6)))
          (define L.x.0.1 (lambda (ball.0.1) ball.0.1))
    (define L.tmp.1.2 (lambda (foo.1.8 bat.2.7 bat.9.6 foo.4.5 ball.5.4 bat.6.3 bat.7.2) 0))
    (call L.void?.3 13102)))
(check-by-interp '(module (define L.fn.0.1 (lambda () 30))
                          (define L.fn.1.2 (lambda (ball.8.4 foo.1.3 bar.7.2 foo.4.1) foo.4.1))
                    (define L.tmp.2.3 (lambda (bat.2.5) bat.2.5))
                    14))
(check-by-interp '(module (define L.func.0.1
                            (lambda (foobar.3.5 ball.2.4 ball.1.3 foobar.8.2 ball.9.1) 6))
                          (define L.func.1.2 (lambda (ball.0.8 foobar.8.7 ball.5.6) 22574))
                    30))
(check-by-interp '(module (define L.boolean?.3
                            (lambda (tmp.25)
                              (if (let ([tmp.31 (bitwise-and tmp.25 247)]) (= tmp.31 6)) 14 6)))
                          (define L.proc.0.1 (lambda (ball.8.2 ball.9.1) 27694))
                    (define L.fn.1.2 (lambda (bar.0.7 ball.3.6 ball.8.5 ball.9.4 foobar.5.3) 14))
                    (call L.boolean?.3 22)))
(check-by-interp '(module (define L.ascii-char?.2
                            (lambda (tmp.25)
                              (if (let ([tmp.28 (bitwise-and tmp.25 255)]) (= tmp.28 46)) 14 6)))
                          (define L.eq?.1 (lambda (tmp.19 tmp.20) (if (= tmp.19 tmp.20) 14 6)))
                    (let ([foo.4.3 (call L.eq?.1 22 0)]
                          [foobar.1.2 6]
                          [ball.5.1 2031626432])
                      (let ([ball.5.4 (if (!= 14 6) 30 foo.4.3)]) (call L.ascii-char?.2 ball.5.4)))))
(check-by-interp '(module (define L.fn.0.1 (lambda (foo.4.3 bat.8.2 bat.6.1) bat.8.2))
                          (define L.x.1.2 (lambda (foobar.3.4) 22))
                    (define L.func.2.3 (lambda () 6))
                    (if (!= 30 6) 30 29230)))
(check-by-interp
 '(module (define L.ascii-char?.3
            (lambda (tmp.28) (if (let ([tmp.31 (bitwise-and tmp.28 255)]) (= tmp.31 46)) 14 6)))
          (define L.func.0.1 (lambda (foobar.8.5 ball.0.4 foobar.2.3 foobar.6.2 bat.9.1) 6))
    (define L.func.1.2 (lambda (foobar.2.7 foo.1.6) foobar.2.7))
    (call L.ascii-char?.3 6)))
(check-by-interp
 '(module (define L.proc.0.1
            (lambda (ball.4.7 foobar.7.6 foo.6.5 bar.9.4 bat.3.3 foobar.0.2 ball.8.1) 14))
          (define L.x.1.2 (lambda (bat.3.12 bar.9.11 foo.1.10 ball.4.9 bar.5.8) foo.1.10))
    6))
(check-by-interp '(module (define L.ascii-char?.3
                            (lambda (tmp.30)
                              (if (let ([tmp.33 (bitwise-and tmp.30 255)]) (= tmp.33 46)) 14 6)))
                          (define L.func.0.1 (lambda (foobar.4.5 bar.8.4 bat.7.3 bar.1.2 foo.9.1) 14))
                    (define L.func.1.2 (lambda (foobar.3.9 foo.6.8 foobar.4.7 bar.1.6) 6))
                    (call L.ascii-char?.3 20526)))
(check-by-interp '(module (define L.x.0.1 (lambda (ball.3.1) 0))
                          (define L.proc.1.2
                            (lambda (bat.1.6 foobar.8.5 foobar.5.4 ball.3.3 bat.7.2) foobar.5.4))
                    (let ([bat.7.8 22]
                          [foobar.2.7 6])
                      22)))
(check-by-interp
 '(module (define L.boolean?.3
            (lambda (tmp.30) (if (let ([tmp.36 (bitwise-and tmp.30 247)]) (= tmp.36 6)) 14 6)))
          (define L.tmp.0.1 (lambda (ball.3.5 bat.8.4 foobar.7.3 bar.6.2 bar.5.1) bar.5.1))
    (define L.tmp.1.2 (lambda (bat.2.12 foobar.4.11 bar.6.10 foobar.7.9 bar.5.8 ball.3.7 foo.9.6) 0))
    (call L.boolean?.3 30)))
(check-by-interp
 '(module (define L.ascii-char?.3
            (lambda (tmp.32) (if (let ([tmp.35 (bitwise-and tmp.32 255)]) (= tmp.35 46)) 14 6)))
          (define L.x.0.1 (lambda (foo.8.4 foobar.6.3 bat.0.2 ball.7.1) ball.7.1))
    (define L.fn.1.2
      (lambda (bat.3.11 foobar.9.10 foobar.5.9 foo.8.8 bat.4.7 ball.7.6 foo.2.5) -3529966152))
    (call L.ascii-char?.3 30)))
(check-by-interp
 '(module (define L.*.4
            (lambda (tmp.9 tmp.10)
              (if (let ([tmp.32 (if (let ([tmp.33 (bitwise-and tmp.10 7)]) (= tmp.33 0)) 14 6)])
                    (!= tmp.32 6))
                  (if (let ([tmp.34 (if (let ([tmp.35 (bitwise-and tmp.9 7)]) (= tmp.35 0)) 14 6)])
                        (!= tmp.34 6))
                      (let ([tmp.36 (arithmetic-shift-right tmp.10 3)]) (* tmp.9 tmp.36))
                      318)
                  318)))
          (define L.proc.0.1 (lambda (foo.9.2 foo.0.1) 14))
    (define L.fn.1.2 (lambda (bat.3.5 bat.1.4 bat.7.3) bat.1.4))
    (define L.func.2.3 (lambda (foo.2.7 foo.9.6) 0))
    (let ([foo.9.8 14]) (call L.*.4 4105232688 8))))
(check-by-interp '(module (define L.proc.0.1 (lambda (foobar.1.5 foo.5.4 bat.4.3 foo.2.2 bat.0.1) 14))
                          (define L.tmp.1.2 (lambda (bat.0.6) 14))
                    (define L.x.2.3
                      (lambda (ball.9.13 bar.7.12 bat.4.11 foo.2.10 foobar.1.9 foo.3.8 foo.6.7) 6))
                    0))
(check-by-interp '(module (define L.fn.0.1
                            (lambda (foobar.4.6 foo.3.5 bar.0.4 foo.7.3 bar.8.2 foobar.2.1) 22))
                          (define L.proc.1.2 (lambda (foo.7.9 foo.3.8 bar.0.7) 14))
                    (define L.x.2.3 (lambda (foobar.2.11 bar.8.10) foobar.2.11))
                    22))
(check-by-interp
 '(module (define L.empty?.3
            (lambda (tmp.33) (if (let ([tmp.38 (bitwise-and tmp.33 255)]) (= tmp.38 22)) 14 6)))
          (define L.tmp.0.1
            (lambda (bar.2.7 foobar.0.6 foobar.9.5 ball.1.4 bat.3.3 bar.4.2 ball.8.1) foobar.0.6))
    (define L.x.1.2 (lambda (foobar.0.14 bar.2.13 bar.4.12 ball.6.11 ball.5.10 bat.3.9 foobar.9.8) 6))
    (call L.empty?.3 8)))
(check-by-interp '(module (define L.proc.0.1
                            (lambda (foobar.8.7 foobar.2.6 bat.9.5 bar.6.4 bar.3.3 foobar.0.2 bar.4.1)
                              8))
                          (define L.func.1.2 (lambda () 14))
                    (define L.fn.2.3 (lambda (foobar.7.10 ball.1.9 foobar.0.8) ball.1.9))
                    (if (!= 6 6) 14 22)))
(check-by-interp
 '(module (define L.ascii-char?.4
            (lambda (tmp.32) (if (let ([tmp.35 (bitwise-and tmp.32 255)]) (= tmp.35 46)) 14 6)))
          (define L.fn.0.1
            (lambda (foobar.3.7 bar.4.6 bat.6.5 foo.9.4 ball.0.3 foobar.5.2 foobar.8.1) bat.6.5))
    (define L.tmp.1.2 (lambda (ball.1.8) ball.1.8))
    (define L.tmp.2.3 (lambda (foobar.8.11 foobar.5.10 ball.0.9) 6))
    (call L.ascii-char?.4 8)))
(check-by-interp
 '(module (define L.boolean?.4
            (lambda (tmp.31) (if (let ([tmp.37 (bitwise-and tmp.31 247)]) (= tmp.37 6)) 14 6)))
          (define L.tmp.0.1 (lambda (foo.4.3 bar.6.2 foobar.0.1) bar.6.2))
    (define L.fn.1.2 (lambda (foo.1.7 ball.9.6 foobar.3.5 bat.2.4) foo.1.7))
    (define L.x.2.3 (lambda (bar.6.13 bat.2.12 foobar.7.11 foo.1.10 ball.9.9 foobar.0.8) 8))
    (call L.boolean?.4 6)))
(check-by-interp
 '(module (define L.ascii-char?.4
            (lambda (tmp.37) (if (let ([tmp.40 (bitwise-and tmp.37 255)]) (= tmp.40 46)) 14 6)))
          (define L.tmp.0.1
            (lambda (bat.9.7 bar.0.6 bat.4.5 bar.8.4 bar.2.3 bar.5.2 ball.3.1) bar.5.2))
    (define L.x.1.2 (lambda (ball.3.12 bar.0.11 foo.7.10 bar.8.9 bar.5.8) 0))
    (define L.func.2.3 (lambda (foo.7.16 bar.2.15 bar.8.14 foobar.1.13) 8))
    (call L.ascii-char?.4 22)))
(check-by-interp
 '(module (define L.<.5
            (lambda (tmp.20 tmp.21)
              (if (let ([tmp.37 (if (let ([tmp.38 (bitwise-and tmp.21 7)]) (= tmp.38 0)) 14 6)])
                    (!= tmp.37 6))
                  (if (let ([tmp.39 (if (let ([tmp.40 (bitwise-and tmp.20 7)]) (= tmp.40 0)) 14 6)])
                        (!= tmp.39 6))
                      (if (< tmp.20 tmp.21) 14 6)
                      1086)
                  1086)))
          (define L.eq?.4 (lambda (tmp.28 tmp.29) (if (= tmp.28 tmp.29) 14 6)))
    (define L.proc.0.1 (lambda (bat.2.4 ball.8.3 foobar.7.2 foo.1.1) 14))
    (define L.proc.1.2 (lambda (bat.5.9 foo.6.8 foobar.3.7 foobar.7.6 bat.0.5) 6))
    (define L.x.2.3 (lambda (bar.4.12 foobar.3.11 bar.9.10) 0))
    (let ([bat.5.13 (call L.eq?.4 8 6)]) (call L.<.5 -2229142488 8))))
(check-by-interp
 '(module (define L.empty?.4
            (lambda (tmp.35) (if (let ([tmp.40 (bitwise-and tmp.35 255)]) (= tmp.40 22)) 14 6)))
          (define L.proc.0.1 (lambda (foo.9.6 ball.5.5 ball.4.4 bar.8.3 ball.1.2 bat.7.1) 6))
    (define L.proc.1.2 (lambda (bar.0.8 foo.6.7) 6))
    (define L.fn.2.3 (lambda (ball.5.15 bar.8.14 foo.9.13 bat.7.12 ball.1.11 foo.6.10 bar.0.9) 14))
    (if (!= 30 6)
        (let ([ball.1.16 (call L.empty?.4 6)]) ball.1.16)
        8)))
(check-by-interp
 '(module (define L.fixnum?.4
            (lambda (tmp.37) (if (let ([tmp.44 (bitwise-and tmp.37 7)]) (= tmp.44 0)) 14 6)))
          (define L.x.0.1
            (lambda (bar.0.7 foobar.1.6 bat.4.5 foobar.5.4 foo.8.3 bat.9.2 bat.2.1) bar.0.7))
    (define L.tmp.1.2 (lambda (foobar.3.13 foobar.1.12 bat.9.11 foobar.5.10 bar.6.9 bat.4.8) 0))
    (define L.tmp.2.3
      (lambda (bat.2.20 foobar.3.19 bar.0.18 foobar.5.17 bar.6.16 ball.7.15 foo.8.14) 6))
    (call L.fixnum?.4 6)))
(check-by-interp
 '(module (define L.tmp.0.1 (lambda (foo.3.6 foo.0.5 ball.9.4 ball.1.3 ball.6.2 foobar.5.1) foo.3.6))
          (define L.x.1.2 (lambda (foobar.5.11 ball.7.10 foo.3.9 ball.1.8 ball.6.7) 2370093256))
    (define L.tmp.2.3 (lambda (ball.6.15 ball.7.14 foo.2.13 foobar.5.12) ball.6.15))
    (let ([foobar.8.18 22]
          [ball.6.17 22]
          [foo.0.16 19502])
      29230)))
(check-by-interp
 '(module (define L.fn.0.1 (lambda (ball.6.7 bar.9.6 bat.8.5 ball.7.4 bat.4.3 bar.1.2 foobar.5.1) 8))
          (define L.proc.1.2
            (lambda (foobar.5.14 bar.1.13 ball.7.12 bat.8.11 bat.4.10 ball.3.9 ball.6.8) ball.7.12))
    (define L.x.2.3 (lambda (ball.6.20 bar.9.19 ball.3.18 foobar.5.17 ball.7.16 bat.8.15) 6))
    (let ([ball.3.24 30]
          [foobar.5.23 21550]
          [foo.2.22 22]
          [ball.6.21 22])
      ball.6.21)))
;;; Added by Trevor on 2026-03-19
