#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         cpsc411/langs/v9
         "../specify-representation.rkt")

(require cpsc411/test-suite/utils)
(define (fail-if-invalid-output p)
  (when (not (exprs-bits-lang-v8? p))
    (error (~a (pretty-format p) "\n is not a semantically valid " "output" " program")))
  p)

(define (fail-if-invalid-input p)
  (when (not (proc-exposed-lang-v9? p))
    (error (~a (pretty-format p) "\n is not a semantically valid " "input" " program"))))
(define-syntax-rule (check-by-interp p)
  (check-equal? (ptr->v (interp-proc-exposed-lang-v9 (fail-if-invalid-input p)))
                 (interp-exprs-bits-lang-v8
                         (fail-if-invalid-output (specify-representation p)))))

(check-by-interp '(module (if #f
                              (void)
                              (void))))
(check-by-interp
 '(module (define L.make-vector.56.9
            (lambda (c.59 tmp.32)
              (let ([make-init-vector.1 (unsafe-procedure-ref c.59 0)])
                (if (fixnum? tmp.32)
                    (call L.make-init-vector.1.8 make-init-vector.1 tmp.32)
                    (error 8)))))
          (define L.make-init-vector.1.8
            (lambda (c.58 tmp.4)
              (let ([vector-init-loop.6 (unsafe-procedure-ref c.58 0)])
                (let ([tmp.5 (unsafe-make-vector tmp.4)])
                  (call L.vector-init-loop.6.7 vector-init-loop.6 tmp.4 0 tmp.5)))))
    (define L.vector-init-loop.6.7
      (lambda (c.57 len.7 i.9 vec.8)
        (let ([vector-init-loop.6 (unsafe-procedure-ref c.57 0)])
          (if (eq? len.7 i.9)
              vec.8
              (begin
                (unsafe-vector-set! vec.8 i.9 0)
                (call L.vector-init-loop.6.7 vector-init-loop.6 len.7 (unsafe-fx+ i.9 1) vec.8))))))
    (let ([vector-init-loop.6 (make-procedure L.vector-init-loop.6.7 3 1)]
          [make-init-vector.1 (make-procedure L.make-init-vector.1.8 1 1)]
          [make-vector.56 (make-procedure L.make-vector.56.9 1 1)])
      (begin
        (unsafe-procedure-set! vector-init-loop.6 0 vector-init-loop.6)
        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.6)
        (unsafe-procedure-set! make-vector.56 0 make-init-vector.1)
        (if #f
            (call L.make-vector.56.9 make-vector.56 8)
            (call L.make-vector.56.9 make-vector.56 8))))))
(check-by-interp '(module (if (if #t #t #f)
                              (if #t
                                  (error 18)
                                  (error 103))
                              (let ([ascii-char0.6 #\p]
                                    [fixnum1.5 201]
                                    [empty2.4 empty])
                                (error 21)))))
(check-by-interp '(module (define L.fun/void8491.6.13 (lambda (c.70) (let () (void))))
                          (define L.fun/void8490.5.12 (lambda (c.69) (let () (void))))
                    (define L.fun/error8492.4.11 (lambda (c.68) (let () (error 77))))
                    (define L.make-vector.62.10
                      (lambda (c.67 tmp.38)
                        (let ([make-init-vector.1 (unsafe-procedure-ref c.67 0)])
                          (if (fixnum? tmp.38)
                              (call L.make-init-vector.1.9 make-init-vector.1 tmp.38)
                              (error 8)))))
                    (define L.make-init-vector.1.9
                      (lambda (c.66 tmp.10)
                        (let ([vector-init-loop.12 (unsafe-procedure-ref c.66 0)])
                          (let ([tmp.11 (unsafe-make-vector tmp.10)])
                            (call L.vector-init-loop.12.8 vector-init-loop.12 tmp.10 0 tmp.11)))))
                    (define L.vector-init-loop.12.8
                      (lambda (c.65 len.13 i.15 vec.14)
                        (let ([vector-init-loop.12 (unsafe-procedure-ref c.65 0)])
                          (if (eq? len.13 i.15)
                              vec.14
                              (begin
                                (unsafe-vector-set! vec.14 i.15 0)
                                (call L.vector-init-loop.12.8
                                      vector-init-loop.12
                                      len.13
                                      (unsafe-fx+ i.15 1)
                                      vec.14))))))
                    (define L.vector?.63.7 (lambda (c.64 tmp.54) (let () (vector? tmp.54))))
                    (let ([vector?.63 (make-procedure L.vector?.63.7 1 0)]
                          [vector-init-loop.12 (make-procedure L.vector-init-loop.12.8 3 1)]
                          [make-init-vector.1 (make-procedure L.make-init-vector.1.9 1 1)]
                          [make-vector.62 (make-procedure L.make-vector.62.10 1 1)]
                          [fun/error8492.4 (make-procedure L.fun/error8492.4.11 0 0)]
                          [fun/void8490.5 (make-procedure L.fun/void8490.5.12 0 0)]
                          [fun/void8491.6 (make-procedure L.fun/void8491.6.13 0 0)])
                      (begin
                        (unsafe-procedure-set! vector-init-loop.12 0 vector-init-loop.12)
                        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.12)
                        (unsafe-procedure-set! make-vector.62 0 make-init-vector.1)
                        (let ([void0.9 (call L.fun/void8490.5.12 fun/void8490.5)]
                              [void1.8 (call L.fun/void8491.6.13 fun/void8491.6)]
                              [boolean2.7 (call L.vector?.63.7
                                                vector?.63
                                                (call L.make-vector.62.10 make-vector.62 8))])
                          (call L.fun/error8492.4.11 fun/error8492.4))))))
(check-by-interp '(module (define L.fun/error8495.4.10
                            (lambda (c.63 oprand0.6 oprand1.5) (let () (error 68))))
                          (define L.make-vector.59.9
                            (lambda (c.62 tmp.35)
                              (let ([make-init-vector.1 (unsafe-procedure-ref c.62 0)])
                                (if (fixnum? tmp.35)
                                    (call L.make-init-vector.1.8 make-init-vector.1 tmp.35)
                                    (error 8)))))
                    (define L.make-init-vector.1.8
                      (lambda (c.61 tmp.7)
                        (let ([vector-init-loop.9 (unsafe-procedure-ref c.61 0)])
                          (let ([tmp.8 (unsafe-make-vector tmp.7)])
                            (call L.vector-init-loop.9.7 vector-init-loop.9 tmp.7 0 tmp.8)))))
                    (define L.vector-init-loop.9.7
                      (lambda (c.60 len.10 i.12 vec.11)
                        (let ([vector-init-loop.9 (unsafe-procedure-ref c.60 0)])
                          (if (eq? len.10 i.12)
                              vec.11
                              (begin
                                (unsafe-vector-set! vec.11 i.12 0)
                                (call L.vector-init-loop.9.7
                                      vector-init-loop.9
                                      len.10
                                      (unsafe-fx+ i.12 1)
                                      vec.11))))))
                    (let ([vector-init-loop.9 (make-procedure L.vector-init-loop.9.7 3 1)]
                          [make-init-vector.1 (make-procedure L.make-init-vector.1.8 1 1)]
                          [make-vector.59 (make-procedure L.make-vector.59.9 1 1)]
                          [fun/error8495.4 (make-procedure L.fun/error8495.4.10 2 0)])
                      (begin
                        (unsafe-procedure-set! vector-init-loop.9 0 vector-init-loop.9)
                        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.9)
                        (unsafe-procedure-set! make-vector.59 0 make-init-vector.1)
                        (if (if #t #t #f)
                            (if #t
                                (error 231)
                                (error 156))
                            (call L.fun/error8495.4.10
                                  fun/error8495.4
                                  #\c
                                  (call L.make-vector.59.9 make-vector.59 8)))))))
(check-by-interp
 '(module (define L.fun/boolean8542.5.12 (lambda (c.69 oprand0.9 oprand1.8) (let () #t)))
          (define L.fun/ascii-char8543.4.11 (lambda (c.68 oprand0.7 oprand1.6) (let () #\x)))
    (define L.make-vector.62.10
      (lambda (c.67 tmp.38)
        (let ([make-init-vector.1 (unsafe-procedure-ref c.67 0)])
          (if (fixnum? tmp.38)
              (call L.make-init-vector.1.9 make-init-vector.1 tmp.38)
              (error 8)))))
    (define L.make-init-vector.1.9
      (lambda (c.66 tmp.10)
        (let ([vector-init-loop.12 (unsafe-procedure-ref c.66 0)])
          (let ([tmp.11 (unsafe-make-vector tmp.10)])
            (call L.vector-init-loop.12.8 vector-init-loop.12 tmp.10 0 tmp.11)))))
    (define L.vector-init-loop.12.8
      (lambda (c.65 len.13 i.15 vec.14)
        (let ([vector-init-loop.12 (unsafe-procedure-ref c.65 0)])
          (if (eq? len.13 i.15)
              vec.14
              (begin
                (unsafe-vector-set! vec.14 i.15 0)
                (call L.vector-init-loop.12.8
                      vector-init-loop.12
                      len.13
                      (unsafe-fx+ i.15 1)
                      vec.14))))))
    (define L.cons.63.7 (lambda (c.64 tmp.57 tmp.58) (let () (cons tmp.57 tmp.58))))
    (let ([cons.63 (make-procedure L.cons.63.7 2 0)]
          [vector-init-loop.12 (make-procedure L.vector-init-loop.12.8 3 1)]
          [make-init-vector.1 (make-procedure L.make-init-vector.1.9 1 1)]
          [make-vector.62 (make-procedure L.make-vector.62.10 1 1)]
          [fun/ascii-char8543.4 (make-procedure L.fun/ascii-char8543.4.11 2 0)]
          [fun/boolean8542.5 (make-procedure L.fun/boolean8542.5.12 2 0)])
      (begin
        (unsafe-procedure-set! vector-init-loop.12 0 vector-init-loop.12)
        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.12)
        (unsafe-procedure-set! make-vector.62 0 make-init-vector.1)
        (if (call L.fun/boolean8542.5.12
                  fun/boolean8542.5
                  #\]
                  (call L.make-vector.62.10 make-vector.62 8))
            (call L.fun/ascii-char8543.4.11
                  fun/ascii-char8543.4
                  (call L.cons.63.7 cons.63 180 382)
                  229)
            (if #f #\^ #\i))))))
(check-by-interp
 '(module (define L.fun/ascii-char8590.6.15 (lambda (c.75) (let () #\D)))
          (define L.fun/vector8589.5.14
            (lambda (c.74)
              (let ([make-vector.63 (unsafe-procedure-ref c.74 0)])
                (call L.make-vector.63.12 make-vector.63 8))))
    (define L.fun/empty8591.4.13 (lambda (c.73) (let () empty)))
    (define L.make-vector.63.12
      (lambda (c.72 tmp.39)
        (let ([make-init-vector.1 (unsafe-procedure-ref c.72 0)])
          (if (fixnum? tmp.39)
              (call L.make-init-vector.1.11 make-init-vector.1 tmp.39)
              (error 8)))))
    (define L.make-init-vector.1.11
      (lambda (c.71 tmp.11)
        (let ([vector-init-loop.13 (unsafe-procedure-ref c.71 0)])
          (let ([tmp.12 (unsafe-make-vector tmp.11)])
            (call L.vector-init-loop.13.10 vector-init-loop.13 tmp.11 0 tmp.12)))))
    (define L.vector-init-loop.13.10
      (lambda (c.70 len.14 i.16 vec.15)
        (let ([vector-init-loop.13 (unsafe-procedure-ref c.70 0)])
          (if (eq? len.14 i.16)
              vec.15
              (begin
                (unsafe-vector-set! vec.15 i.16 0)
                (call L.vector-init-loop.13.10
                      vector-init-loop.13
                      len.14
                      (unsafe-fx+ i.16 1)
                      vec.15))))))
    (define L.-.64.9
      (lambda (c.69 tmp.29 tmp.30)
        (let ()
          (if (fixnum? tmp.30)
              (if (fixnum? tmp.29)
                  (unsafe-fx- tmp.29 tmp.30)
                  (error 3))
              (error 3)))))
    (define L.+.65.8
      (lambda (c.68 tmp.27 tmp.28)
        (let ()
          (if (fixnum? tmp.28)
              (if (fixnum? tmp.27)
                  (unsafe-fx+ tmp.27 tmp.28)
                  (error 2))
              (error 2)))))
    (define L.*.66.7
      (lambda (c.67 tmp.25 tmp.26)
        (let ()
          (if (fixnum? tmp.26)
              (if (fixnum? tmp.25)
                  (unsafe-fx* tmp.25 tmp.26)
                  (error 1))
              (error 1)))))
    (let ([*.66 (make-procedure L.*.66.7 2 0)]
          [|+.65| (make-procedure L.+.65.8 2 0)]
          [|-.64| (make-procedure L.-.64.9 2 0)]
          [vector-init-loop.13 (make-procedure L.vector-init-loop.13.10 3 1)]
          [make-init-vector.1 (make-procedure L.make-init-vector.1.11 1 1)]
          [make-vector.63 (make-procedure L.make-vector.63.12 1 1)]
          [fun/empty8591.4 (make-procedure L.fun/empty8591.4.13 0 0)]
          [fun/vector8589.5 (make-procedure L.fun/vector8589.5.14 0 1)]
          [fun/ascii-char8590.6 (make-procedure L.fun/ascii-char8590.6.15 0 0)])
      (begin
        (unsafe-procedure-set! vector-init-loop.13 0 vector-init-loop.13)
        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.13)
        (unsafe-procedure-set! make-vector.63 0 make-init-vector.1)
        (unsafe-procedure-set! fun/vector8589.5 0 make-vector.63)
        (let ([fixnum0.10
               (call L.-.64.9 |-.64| (call L.-.64.9 |-.64| 215 72) (call L.-.64.9 |-.64| 219 173))]
              [vector1.9 (call L.fun/vector8589.5.14 fun/vector8589.5)]
              [fixnum2.8
               (call L.+.65.8 |+.65| (call L.+.65.8 |+.65| 93 220) (call L.*.66.7 *.66 170 131))]
              [ascii-char3.7 (call L.fun/ascii-char8590.6.15 fun/ascii-char8590.6)])
          (call L.fun/empty8591.4.13 fun/empty8591.4))))))
(check-by-interp
 '(module (define L.fun/any8764.8.16 (lambda (c.77) (let () (error 55))))
          (define L.fun/void8763.7.15 (lambda (c.76) (let () (void))))
    (define L.fun/any8762.6.14 (lambda (c.75) (let () (void))))
    (define L.fun/ascii-char8761.5.13 (lambda (c.74) (let () #\k)))
    (define L.fun/vector8765.4.12
      (lambda (c.73)
        (let ([make-vector.65 (unsafe-procedure-ref c.73 0)])
          (call L.make-vector.65.11 make-vector.65 8))))
    (define L.make-vector.65.11
      (lambda (c.72 tmp.41)
        (let ([make-init-vector.1 (unsafe-procedure-ref c.72 0)])
          (if (fixnum? tmp.41)
              (call L.make-init-vector.1.10 make-init-vector.1 tmp.41)
              (error 8)))))
    (define L.make-init-vector.1.10
      (lambda (c.71 tmp.13)
        (let ([vector-init-loop.15 (unsafe-procedure-ref c.71 0)])
          (let ([tmp.14 (unsafe-make-vector tmp.13)])
            (call L.vector-init-loop.15.9 vector-init-loop.15 tmp.13 0 tmp.14)))))
    (define L.vector-init-loop.15.9
      (lambda (c.70 len.16 i.18 vec.17)
        (let ([vector-init-loop.15 (unsafe-procedure-ref c.70 0)])
          (if (eq? len.16 i.18)
              vec.17
              (begin
                (unsafe-vector-set! vec.17 i.18 0)
                (call L.vector-init-loop.15.9
                      vector-init-loop.15
                      len.16
                      (unsafe-fx+ i.18 1)
                      vec.17))))))
    (define L.vector?.66.8 (lambda (c.69 tmp.57) (let () (vector? tmp.57))))
    (define L.boolean?.67.7 (lambda (c.68 tmp.51) (let () (boolean? tmp.51))))
    (let ([boolean?.67 (make-procedure L.boolean?.67.7 1 0)]
          [vector?.66 (make-procedure L.vector?.66.8 1 0)]
          [vector-init-loop.15 (make-procedure L.vector-init-loop.15.9 3 1)]
          [make-init-vector.1 (make-procedure L.make-init-vector.1.10 1 1)]
          [make-vector.65 (make-procedure L.make-vector.65.11 1 1)]
          [fun/vector8765.4 (make-procedure L.fun/vector8765.4.12 0 1)]
          [fun/ascii-char8761.5 (make-procedure L.fun/ascii-char8761.5.13 0 0)]
          [fun/any8762.6 (make-procedure L.fun/any8762.6.14 0 0)]
          [fun/void8763.7 (make-procedure L.fun/void8763.7.15 0 0)]
          [fun/any8764.8 (make-procedure L.fun/any8764.8.16 0 0)])
      (begin
        (unsafe-procedure-set! vector-init-loop.15 0 vector-init-loop.15)
        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.15)
        (unsafe-procedure-set! make-vector.65 0 make-init-vector.1)
        (unsafe-procedure-set! fun/vector8765.4 0 make-vector.65)
        (let ([ascii-char0.12 (call L.fun/ascii-char8761.5.13 fun/ascii-char8761.5)]
              [boolean1.11 (call L.vector?.66.8 vector?.66 (call L.fun/any8762.6.14 fun/any8762.6))]
              [void2.10 (call L.fun/void8763.7.15 fun/void8763.7)]
              [boolean3.9 (call L.boolean?.67.7 boolean?.67 (call L.fun/any8764.8.16 fun/any8764.8))])
          (call L.fun/vector8765.4.12 fun/vector8765.4))))))
(check-by-interp
 '(module (define L.lam.110.27 (lambda (c.131) (let () #\X)))
          (define L.fun/pair8798.16.26
            (lambda (c.130)
              (let ([cons.105 (unsafe-procedure-ref c.130 0)]) (call L.cons.105.13 cons.105 24 277))))
    (define L.fun/ascii-char8794.15.25
      (lambda (c.129 oprand0.40 oprand1.39 oprand2.38)
        (let ([fun/ascii-char8795.12 (unsafe-procedure-ref c.129 0)])
          (call L.fun/ascii-char8795.12.22 fun/ascii-char8795.12))))
    (define L.fun/error8800.14.24
      (lambda (c.128 oprand0.37 oprand1.36 oprand2.35) (let () oprand2.35)))
    (define L.fun/fixnum8792.13.23 (lambda (c.127) (let () 185)))
    (define L.fun/ascii-char8795.12.22 (lambda (c.126) (let () #\K)))
    (define L.fun/fixnum8796.11.21 (lambda (c.125 oprand0.34 oprand1.33 oprand2.32) (let () 254)))
    (define L.fun/pair8790.10.20
      (lambda (c.124)
        (let ([cons.105 (unsafe-procedure-ref c.124 0)]) (call L.cons.105.13 cons.105 25 485))))
    (define L.fun/empty8793.9.19 (lambda (c.123 oprand0.31 oprand1.30 oprand2.29) (let () empty)))
    (define L.fun/pair8788.8.18
      (lambda (c.122 oprand0.28 oprand1.27 oprand2.26)
        (let ([fun/pair8789.7 (unsafe-procedure-ref c.122 0)])
          (call L.fun/pair8789.7.17 fun/pair8789.7))))
    (define L.fun/pair8789.7.17
      (lambda (c.121)
        (let ([fun/pair8790.10 (unsafe-procedure-ref c.121 0)])
          (call L.fun/pair8790.10.20 fun/pair8790.10))))
    (define L.fun/error8799.6.16
      (lambda (c.120 oprand0.25 oprand1.24 oprand2.23) (let () (error 158))))
    (define L.fun/pair8797.5.15
      (lambda (c.119 oprand0.22 oprand1.21 oprand2.20)
        (let ([fun/pair8798.16 (unsafe-procedure-ref c.119 0)])
          (call L.fun/pair8798.16.26 fun/pair8798.16))))
    (define L.fun/fixnum8791.4.14
      (lambda (c.118 oprand0.19 oprand1.18 oprand2.17)
        (let ([fun/fixnum8792.13 (unsafe-procedure-ref c.118 0)])
          (call L.fun/fixnum8792.13.23 fun/fixnum8792.13))))
    (define L.cons.105.13 (lambda (c.117 tmp.100 tmp.101) (let () (cons tmp.100 tmp.101))))
    (define L.make-vector.106.12
      (lambda (c.116 tmp.81)
        (let ([make-init-vector.1 (unsafe-procedure-ref c.116 0)])
          (if (fixnum? tmp.81)
              (call L.make-init-vector.1.11 make-init-vector.1 tmp.81)
              (error 8)))))
    (define L.make-init-vector.1.11
      (lambda (c.115 tmp.53)
        (let ([vector-init-loop.55 (unsafe-procedure-ref c.115 0)])
          (let ([tmp.54 (unsafe-make-vector tmp.53)])
            (call L.vector-init-loop.55.10 vector-init-loop.55 tmp.53 0 tmp.54)))))
    (define L.vector-init-loop.55.10
      (lambda (c.114 len.56 i.58 vec.57)
        (let ([vector-init-loop.55 (unsafe-procedure-ref c.114 0)])
          (if (eq? len.56 i.58)
              vec.57
              (begin
                (unsafe-vector-set! vec.57 i.58 0)
                (call L.vector-init-loop.55.10
                      vector-init-loop.55
                      len.56
                      (unsafe-fx+ i.58 1)
                      vec.57))))))
    (define L.ascii-char?.107.9 (lambda (c.113 tmp.94) (let () (ascii-char? tmp.94))))
    (define L.>.108.8
      (lambda (c.112 tmp.77 tmp.78)
        (let ()
          (if (fixnum? tmp.78)
              (if (fixnum? tmp.77)
                  (unsafe-fx> tmp.77 tmp.78)
                  (error 6))
              (error 6)))))
    (define L.*.109.7
      (lambda (c.111 tmp.67 tmp.68)
        (let ()
          (if (fixnum? tmp.68)
              (if (fixnum? tmp.67)
                  (unsafe-fx* tmp.67 tmp.68)
                  (error 1))
              (error 1)))))
    (let ([*.109 (make-procedure L.*.109.7 2 0)]
          [>.108 (make-procedure L.>.108.8 2 0)]
          [ascii-char?.107 (make-procedure L.ascii-char?.107.9 1 0)]
          [vector-init-loop.55 (make-procedure L.vector-init-loop.55.10 3 1)]
          [make-init-vector.1 (make-procedure L.make-init-vector.1.11 1 1)]
          [make-vector.106 (make-procedure L.make-vector.106.12 1 1)]
          [cons.105 (make-procedure L.cons.105.13 2 0)]
          [fun/fixnum8791.4 (make-procedure L.fun/fixnum8791.4.14 3 1)]
          [fun/pair8797.5 (make-procedure L.fun/pair8797.5.15 3 1)]
          [fun/error8799.6 (make-procedure L.fun/error8799.6.16 3 0)]
          [fun/pair8789.7 (make-procedure L.fun/pair8789.7.17 0 1)]
          [fun/pair8788.8 (make-procedure L.fun/pair8788.8.18 3 1)]
          [fun/empty8793.9 (make-procedure L.fun/empty8793.9.19 3 0)]
          [fun/pair8790.10 (make-procedure L.fun/pair8790.10.20 0 1)]
          [fun/fixnum8796.11 (make-procedure L.fun/fixnum8796.11.21 3 0)]
          [fun/ascii-char8795.12 (make-procedure L.fun/ascii-char8795.12.22 0 0)]
          [fun/fixnum8792.13 (make-procedure L.fun/fixnum8792.13.23 0 0)]
          [fun/error8800.14 (make-procedure L.fun/error8800.14.24 3 0)]
          [fun/ascii-char8794.15 (make-procedure L.fun/ascii-char8794.15.25 3 1)]
          [fun/pair8798.16 (make-procedure L.fun/pair8798.16.26 0 1)])
      (begin
        (unsafe-procedure-set! vector-init-loop.55 0 vector-init-loop.55)
        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.55)
        (unsafe-procedure-set! make-vector.106 0 make-init-vector.1)
        (unsafe-procedure-set! fun/fixnum8791.4 0 fun/fixnum8792.13)
        (unsafe-procedure-set! fun/pair8797.5 0 fun/pair8798.16)
        (unsafe-procedure-set! fun/pair8789.7 0 fun/pair8790.10)
        (unsafe-procedure-set! fun/pair8788.8 0 fun/pair8789.7)
        (unsafe-procedure-set! fun/pair8790.10 0 cons.105)
        (unsafe-procedure-set! fun/ascii-char8794.15 0 fun/ascii-char8795.12)
        (unsafe-procedure-set! fun/pair8798.16 0 cons.105)
        (call L.fun/pair8788.8.18
              fun/pair8788.8
              (call L.>.108.8
                    >.108
                    (call L.fun/fixnum8791.4.14
                          fun/fixnum8791.4
                          (call L.fun/empty8793.9.19 fun/empty8793.9 250 #t (error 11))
                          (if #f empty empty)
                          (call L.ascii-char?.107.9
                                ascii-char?.107
                                (call L.make-vector.106.12 make-vector.106 8)))
                    (if #t 182 209))
              (call L.fun/ascii-char8794.15.25
                    fun/ascii-char8794.15
                    (call L.*.109.7
                          *.109
                          (let ([error0.44 (error 211)]
                                [fixnum1.43 224]
                                [vector2.42 (call L.make-vector.106.12 make-vector.106 8)]
                                [procedure3.41 (let ([lam.110 (make-procedure L.lam.110.27 0 0)])
                                                 lam.110)])
                            226)
                          (call L.fun/fixnum8796.11.21 fun/fixnum8796.11 174 (error 224) (void)))
                    (call L.fun/pair8797.5.15
                          fun/pair8797.5
                          (call L.fun/error8799.6.16 fun/error8799.6 empty 6 (void))
                          (if #t
                              (void)
                              (void))
                          (call L.fun/ascii-char8794.15.25
                                fun/ascii-char8794.15
                                79
                                (call L.cons.105.13 cons.105 43 357)
                                (call L.make-vector.106.12 make-vector.106 8)))
                    (if #f
                        (call L.make-vector.106.12 make-vector.106 8)
                        (call L.make-vector.106.12 make-vector.106 8)))
              (call L.fun/error8800.14.24
                    fun/error8800.14
                    (if #t
                        (call L.make-vector.106.12 make-vector.106 8)
                        (call L.make-vector.106.12 make-vector.106 8))
                    (let ([vector0.48 (call L.make-vector.106.12 make-vector.106 8)]
                          [vector1.47 (call L.make-vector.106.12 make-vector.106 8)]
                          [ascii-char2.46 #\]]
                          [vector3.45 (call L.make-vector.106.12 make-vector.106 8)])
                      (void))
                    (let ([boolean0.52 #t]
                          [void1.51 (void)]
                          [boolean2.50 #f]
                          [boolean3.49 #f])
                      (error 220))))))))
(check-by-interp
 '(module (define L.lam.80.23
            (lambda (c.97)
              (let ([fun/ascii-char9132.7 (unsafe-procedure-ref c.97 0)])
                (call L.fun/ascii-char9132.7.15 fun/ascii-char9132.7))))
          (define L.lam.79.22
            (lambda (c.96)
              (let ([fun/void9126.12 (unsafe-procedure-ref c.96 0)])
                (call L.fun/void9126.12.20 fun/void9126.12))))
    (define L.fun/ascii-char9135.13.21 (lambda (c.95) (let () #\u)))
    (define L.fun/void9126.12.20 (lambda (c.94) (let () (void))))
    (define L.fun/vector9134.11.19
      (lambda (c.93)
        (let ([make-vector.76 (unsafe-procedure-ref c.93 0)])
          (call L.make-vector.76.11 make-vector.76 8))))
    (define L.fun/ascii-char9129.10.18 (lambda (c.92) (let () #\P)))
    (define L.fun/vector9133.9.17
      (lambda (c.91)
        (let ([make-vector.76 (unsafe-procedure-ref c.91 0)])
          (call L.make-vector.76.11 make-vector.76 8))))
    (define L.fun/ascii-char9130.8.16 (lambda (c.90) (let () #\p)))
    (define L.fun/ascii-char9132.7.15 (lambda (c.89) (let () #\p)))
    (define L.fun/empty9128.6.14 (lambda (c.88) (let () empty)))
    (define L.fun/ascii-char9131.5.13 (lambda (c.87) (let () #\o)))
    (define L.fun/error9127.4.12 (lambda (c.86) (let () (error 167))))
    (define L.make-vector.76.11
      (lambda (c.85 tmp.52)
        (let ([make-init-vector.1 (unsafe-procedure-ref c.85 0)])
          (if (fixnum? tmp.52)
              (call L.make-init-vector.1.10 make-init-vector.1 tmp.52)
              (error 8)))))
    (define L.make-init-vector.1.10
      (lambda (c.84 tmp.24)
        (let ([vector-init-loop.26 (unsafe-procedure-ref c.84 0)])
          (let ([tmp.25 (unsafe-make-vector tmp.24)])
            (call L.vector-init-loop.26.9 vector-init-loop.26 tmp.24 0 tmp.25)))))
    (define L.vector-init-loop.26.9
      (lambda (c.83 len.27 i.29 vec.28)
        (let ([vector-init-loop.26 (unsafe-procedure-ref c.83 0)])
          (if (eq? len.27 i.29)
              vec.28
              (begin
                (unsafe-vector-set! vec.28 i.29 0)
                (call L.vector-init-loop.26.9
                      vector-init-loop.26
                      len.27
                      (unsafe-fx+ i.29 1)
                      vec.28))))))
    (define L.vector?.77.8 (lambda (c.82 tmp.68) (let () (vector? tmp.68))))
    (define L.<=.78.7
      (lambda (c.81 tmp.46 tmp.47)
        (let ()
          (if (fixnum? tmp.47)
              (if (fixnum? tmp.46)
                  (unsafe-fx<= tmp.46 tmp.47)
                  (error 5))
              (error 5)))))
    (let ([<=.78 (make-procedure L.<=.78.7 2 0)]
          [vector?.77 (make-procedure L.vector?.77.8 1 0)]
          [vector-init-loop.26 (make-procedure L.vector-init-loop.26.9 3 1)]
          [make-init-vector.1 (make-procedure L.make-init-vector.1.10 1 1)]
          [make-vector.76 (make-procedure L.make-vector.76.11 1 1)]
          [fun/error9127.4 (make-procedure L.fun/error9127.4.12 0 0)]
          [fun/ascii-char9131.5 (make-procedure L.fun/ascii-char9131.5.13 0 0)]
          [fun/empty9128.6 (make-procedure L.fun/empty9128.6.14 0 0)]
          [fun/ascii-char9132.7 (make-procedure L.fun/ascii-char9132.7.15 0 0)]
          [fun/ascii-char9130.8 (make-procedure L.fun/ascii-char9130.8.16 0 0)]
          [fun/vector9133.9 (make-procedure L.fun/vector9133.9.17 0 1)]
          [fun/ascii-char9129.10 (make-procedure L.fun/ascii-char9129.10.18 0 0)]
          [fun/vector9134.11 (make-procedure L.fun/vector9134.11.19 0 1)]
          [fun/void9126.12 (make-procedure L.fun/void9126.12.20 0 0)]
          [fun/ascii-char9135.13 (make-procedure L.fun/ascii-char9135.13.21 0 0)])
      (begin
        (unsafe-procedure-set! vector-init-loop.26 0 vector-init-loop.26)
        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.26)
        (unsafe-procedure-set! make-vector.76 0 make-init-vector.1)
        (unsafe-procedure-set! fun/vector9133.9 0 make-vector.76)
        (unsafe-procedure-set! fun/vector9134.11 0 make-vector.76)
        (if (call L.vector?.77.8
                  vector?.77
                  (if #f
                      empty
                      (void)))
            (let ([procedure0.18 (let ([lam.79 (make-procedure L.lam.79.22 0 1)])
                                   (begin
                                     (unsafe-procedure-set! lam.79 0 fun/void9126.12)
                                     lam.79))]
                  [error1.17 (call L.fun/error9127.4.12 fun/error9127.4)]
                  [empty2.16 (call L.fun/empty9128.6.14 fun/empty9128.6)]
                  [ascii-char3.15 (call L.fun/ascii-char9129.10.18 fun/ascii-char9129.10)]
                  [ascii-char4.14 (call L.fun/ascii-char9130.8.16 fun/ascii-char9130.8)])
              (call L.fun/ascii-char9131.5.13 fun/ascii-char9131.5))
            (let ([procedure0.23 (let ([lam.80 (make-procedure L.lam.80.23 0 1)])
                                   (begin
                                     (unsafe-procedure-set! lam.80 0 fun/ascii-char9132.7)
                                     lam.80))]
                  [vector1.22 (call L.fun/vector9133.9.17 fun/vector9133.9)]
                  [vector2.21 (call L.fun/vector9134.11.19 fun/vector9134.11)]
                  [ascii-char3.20 (call L.fun/ascii-char9135.13.21 fun/ascii-char9135.13)]
                  [boolean4.19 (call L.<=.78.7 <=.78 42 157)])
              (if (procedure? procedure0.23)
                  (if (eq? (unsafe-procedure-arity procedure0.23) 0)
                      (call (unsafe-procedure-label procedure0.23) procedure0.23)
                      (error 42))
                  (error 43))))))))
(check-by-interp
 '(module (define L.lam.75.23
            (lambda (c.92)
              (let ([fun/vector9888.10 (unsafe-procedure-ref c.92 0)])
                (call L.fun/vector9888.10.19 fun/vector9888.10))))
          (define L.fun/vector9889.13.22
            (lambda (c.91)
              (let ([make-vector.71 (unsafe-procedure-ref c.91 0)])
                (call L.make-vector.71.12 make-vector.71 8))))
    (define L.fun/void9885.12.21 (lambda (c.90) (let () (void))))
    (define L.fun/ascii-char9886.11.20
      (lambda (c.89)
        (let ([fun/ascii-char9887.6 (unsafe-procedure-ref c.89 0)])
          (call L.fun/ascii-char9887.6.15 fun/ascii-char9887.6))))
    (define L.fun/vector9888.10.19
      (lambda (c.88)
        (let ([fun/vector9889.13 (unsafe-procedure-ref c.88 0)])
          (call L.fun/vector9889.13.22 fun/vector9889.13))))
    (define L.fun/void9891.9.18 (lambda (c.87) (let () (void))))
    (define L.fun/void9884.8.17
      (lambda (c.86)
        (let ([fun/void9885.12 (unsafe-procedure-ref c.86 0)])
          (call L.fun/void9885.12.21 fun/void9885.12))))
    (define L.fun/ascii-char9892.7.16
      (lambda (c.85)
        (let ([fun/ascii-char9893.4 (unsafe-procedure-ref c.85 0)])
          (call L.fun/ascii-char9893.4.13 fun/ascii-char9893.4))))
    (define L.fun/ascii-char9887.6.15 (lambda (c.84) (let () #\])))
    (define L.fun/void9890.5.14
      (lambda (c.83)
        (let ([fun/void9891.9 (unsafe-procedure-ref c.83 0)])
          (call L.fun/void9891.9.18 fun/void9891.9))))
    (define L.fun/ascii-char9893.4.13 (lambda (c.82) (let () #\Q)))
    (define L.make-vector.71.12
      (lambda (c.81 tmp.47)
        (let ([make-init-vector.1 (unsafe-procedure-ref c.81 0)])
          (if (fixnum? tmp.47)
              (call L.make-init-vector.1.11 make-init-vector.1 tmp.47)
              (error 8)))))
    (define L.make-init-vector.1.11
      (lambda (c.80 tmp.19)
        (let ([vector-init-loop.21 (unsafe-procedure-ref c.80 0)])
          (let ([tmp.20 (unsafe-make-vector tmp.19)])
            (call L.vector-init-loop.21.10 vector-init-loop.21 tmp.19 0 tmp.20)))))
    (define L.vector-init-loop.21.10
      (lambda (c.79 len.22 i.24 vec.23)
        (let ([vector-init-loop.21 (unsafe-procedure-ref c.79 0)])
          (if (eq? len.22 i.24)
              vec.23
              (begin
                (unsafe-vector-set! vec.23 i.24 0)
                (call L.vector-init-loop.21.10
                      vector-init-loop.21
                      len.22
                      (unsafe-fx+ i.24 1)
                      vec.23))))))
    (define L.+.72.9
      (lambda (c.78 tmp.35 tmp.36)
        (let ()
          (if (fixnum? tmp.36)
              (if (fixnum? tmp.35)
                  (unsafe-fx+ tmp.35 tmp.36)
                  (error 2))
              (error 2)))))
    (define L.*.73.8
      (lambda (c.77 tmp.33 tmp.34)
        (let ()
          (if (fixnum? tmp.34)
              (if (fixnum? tmp.33)
                  (unsafe-fx* tmp.33 tmp.34)
                  (error 1))
              (error 1)))))
    (define L.-.74.7
      (lambda (c.76 tmp.37 tmp.38)
        (let ()
          (if (fixnum? tmp.38)
              (if (fixnum? tmp.37)
                  (unsafe-fx- tmp.37 tmp.38)
                  (error 3))
              (error 3)))))
    (let ([|-.74| (make-procedure L.-.74.7 2 0)]
          [*.73 (make-procedure L.*.73.8 2 0)]
          [|+.72| (make-procedure L.+.72.9 2 0)]
          [vector-init-loop.21 (make-procedure L.vector-init-loop.21.10 3 1)]
          [make-init-vector.1 (make-procedure L.make-init-vector.1.11 1 1)]
          [make-vector.71 (make-procedure L.make-vector.71.12 1 1)]
          [fun/ascii-char9893.4 (make-procedure L.fun/ascii-char9893.4.13 0 0)]
          [fun/void9890.5 (make-procedure L.fun/void9890.5.14 0 1)]
          [fun/ascii-char9887.6 (make-procedure L.fun/ascii-char9887.6.15 0 0)]
          [fun/ascii-char9892.7 (make-procedure L.fun/ascii-char9892.7.16 0 1)]
          [fun/void9884.8 (make-procedure L.fun/void9884.8.17 0 1)]
          [fun/void9891.9 (make-procedure L.fun/void9891.9.18 0 0)]
          [fun/vector9888.10 (make-procedure L.fun/vector9888.10.19 0 1)]
          [fun/ascii-char9886.11 (make-procedure L.fun/ascii-char9886.11.20 0 1)]
          [fun/void9885.12 (make-procedure L.fun/void9885.12.21 0 0)]
          [fun/vector9889.13 (make-procedure L.fun/vector9889.13.22 0 1)])
      (begin
        (unsafe-procedure-set! vector-init-loop.21 0 vector-init-loop.21)
        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.21)
        (unsafe-procedure-set! make-vector.71 0 make-init-vector.1)
        (unsafe-procedure-set! fun/void9890.5 0 fun/void9891.9)
        (unsafe-procedure-set! fun/ascii-char9892.7 0 fun/ascii-char9893.4)
        (unsafe-procedure-set! fun/void9884.8 0 fun/void9885.12)
        (unsafe-procedure-set! fun/vector9888.10 0 fun/vector9889.13)
        (unsafe-procedure-set! fun/ascii-char9886.11 0 fun/ascii-char9887.6)
        (unsafe-procedure-set! fun/vector9889.13 0 make-vector.71)
        (let ([void0.18 (call L.fun/void9884.8.17 fun/void9884.8)]
              [ascii-char1.17 (call L.fun/ascii-char9886.11.20 fun/ascii-char9886.11)]
              [procedure2.16 (let ([lam.75 (make-procedure L.lam.75.23 0 1)])
                               (begin
                                 (unsafe-procedure-set! lam.75 0 fun/vector9888.10)
                                 lam.75))]
              [void3.15 (call L.fun/void9890.5.14 fun/void9890.5)]
              [fixnum4.14
               (call
                L.*.73.8
                *.73
                (call L.*.73.8 *.73 (call L.+.72.9 |+.72| 168 24) (call L.*.73.8 *.73 207 124))
                (call L.*.73.8 *.73 (call L.*.73.8 *.73 127 249) (call L.-.74.7 |-.74| 196 211)))])
          (call L.fun/ascii-char9892.7.16 fun/ascii-char9892.7))))))
(check-by-interp
 '(module (define L.lam.74.22
            (lambda (c.90)
              (let ([fun/ascii-char10710.8 (unsafe-procedure-ref c.90 0)])
                (call L.fun/ascii-char10710.8.15 fun/ascii-char10710.8))))
          (define L.fun/void10716.14.21 (lambda (c.89) (let () (void))))
    (define L.fun/empty10709.13.20 (lambda (c.88) (let () empty)))
    (define L.fun/ascii-char10711.12.19 (lambda (c.87) (let () #\[)))
    (define L.fun/vector10713.11.18
      (lambda (c.86)
        (let ([make-vector.72 (unsafe-procedure-ref c.86 0)])
          (call L.make-vector.72.10 make-vector.72 8))))
    (define L.fun/error10717.10.17
      (lambda (c.85)
        (let ([fun/error10718.4 (unsafe-procedure-ref c.85 0)])
          (call L.fun/error10718.4.11 fun/error10718.4))))
    (define L.fun/empty10708.9.16
      (lambda (c.84)
        (let ([fun/empty10709.13 (unsafe-procedure-ref c.84 0)])
          (call L.fun/empty10709.13.20 fun/empty10709.13))))
    (define L.fun/ascii-char10710.8.15
      (lambda (c.83)
        (let ([fun/ascii-char10711.12 (unsafe-procedure-ref c.83 0)])
          (call L.fun/ascii-char10711.12.19 fun/ascii-char10711.12))))
    (define L.fun/vector10712.7.14
      (lambda (c.82)
        (let ([fun/vector10713.11 (unsafe-procedure-ref c.82 0)])
          (call L.fun/vector10713.11.18 fun/vector10713.11))))
    (define L.fun/void10715.6.13
      (lambda (c.81)
        (let ([fun/void10716.14 (unsafe-procedure-ref c.81 0)])
          (call L.fun/void10716.14.21 fun/void10716.14))))
    (define L.fun/any10714.5.12
      (lambda (c.80)
        (let ([make-vector.72 (unsafe-procedure-ref c.80 0)])
          (call L.make-vector.72.10 make-vector.72 8))))
    (define L.fun/error10718.4.11 (lambda (c.79) (let () (error 183))))
    (define L.make-vector.72.10
      (lambda (c.78 tmp.48)
        (let ([make-init-vector.1 (unsafe-procedure-ref c.78 0)])
          (if (fixnum? tmp.48)
              (call L.make-init-vector.1.9 make-init-vector.1 tmp.48)
              (error 8)))))
    (define L.make-init-vector.1.9
      (lambda (c.77 tmp.20)
        (let ([vector-init-loop.22 (unsafe-procedure-ref c.77 0)])
          (let ([tmp.21 (unsafe-make-vector tmp.20)])
            (call L.vector-init-loop.22.8 vector-init-loop.22 tmp.20 0 tmp.21)))))
    (define L.vector-init-loop.22.8
      (lambda (c.76 len.23 i.25 vec.24)
        (let ([vector-init-loop.22 (unsafe-procedure-ref c.76 0)])
          (if (eq? len.23 i.25)
              vec.24
              (begin
                (unsafe-vector-set! vec.24 i.25 0)
                (call L.vector-init-loop.22.8
                      vector-init-loop.22
                      len.23
                      (unsafe-fx+ i.25 1)
                      vec.24))))))
    (define L.fixnum?.73.7 (lambda (c.75 tmp.57) (let () (fixnum? tmp.57))))
    (let ([fixnum?.73 (make-procedure L.fixnum?.73.7 1 0)]
          [vector-init-loop.22 (make-procedure L.vector-init-loop.22.8 3 1)]
          [make-init-vector.1 (make-procedure L.make-init-vector.1.9 1 1)]
          [make-vector.72 (make-procedure L.make-vector.72.10 1 1)]
          [fun/error10718.4 (make-procedure L.fun/error10718.4.11 0 0)]
          [fun/any10714.5 (make-procedure L.fun/any10714.5.12 0 1)]
          [fun/void10715.6 (make-procedure L.fun/void10715.6.13 0 1)]
          [fun/vector10712.7 (make-procedure L.fun/vector10712.7.14 0 1)]
          [fun/ascii-char10710.8 (make-procedure L.fun/ascii-char10710.8.15 0 1)]
          [fun/empty10708.9 (make-procedure L.fun/empty10708.9.16 0 1)]
          [fun/error10717.10 (make-procedure L.fun/error10717.10.17 0 1)]
          [fun/vector10713.11 (make-procedure L.fun/vector10713.11.18 0 1)]
          [fun/ascii-char10711.12 (make-procedure L.fun/ascii-char10711.12.19 0 0)]
          [fun/empty10709.13 (make-procedure L.fun/empty10709.13.20 0 0)]
          [fun/void10716.14 (make-procedure L.fun/void10716.14.21 0 0)])
      (begin
        (unsafe-procedure-set! vector-init-loop.22 0 vector-init-loop.22)
        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.22)
        (unsafe-procedure-set! make-vector.72 0 make-init-vector.1)
        (unsafe-procedure-set! fun/any10714.5 0 make-vector.72)
        (unsafe-procedure-set! fun/void10715.6 0 fun/void10716.14)
        (unsafe-procedure-set! fun/vector10712.7 0 fun/vector10713.11)
        (unsafe-procedure-set! fun/ascii-char10710.8 0 fun/ascii-char10711.12)
        (unsafe-procedure-set! fun/empty10708.9 0 fun/empty10709.13)
        (unsafe-procedure-set! fun/error10717.10 0 fun/error10718.4)
        (unsafe-procedure-set! fun/vector10713.11 0 make-vector.72)
        (let ([empty0.19 (call L.fun/empty10708.9.16 fun/empty10708.9)]
              [procedure1.18 (let ([lam.74 (make-procedure L.lam.74.22 0 1)])
                               (begin
                                 (unsafe-procedure-set! lam.74 0 fun/ascii-char10710.8)
                                 lam.74))]
              [vector2.17 (call L.fun/vector10712.7.14 fun/vector10712.7)]
              [boolean3.16 (call L.fixnum?.73.7 fixnum?.73 (call L.fun/any10714.5.12 fun/any10714.5))]
              [void4.15 (call L.fun/void10715.6.13 fun/void10715.6)])
          (call L.fun/error10717.10.17 fun/error10717.10))))))
(check-by-interp
 '(module (define L.lam.75.24
            (lambda (c.93)
              (let ([|-.70| (unsafe-procedure-ref c.93 0)]
                    [|+.71| (unsafe-procedure-ref c.93 1)])
                (call
                 L.+.71.9
                 |+.71|
                 (call L.-.70.10 |-.70| (call L.-.70.10 |-.70| 90 126) (call L.-.70.10 |-.70| 96 108))
                 (call L.+.71.9
                       |+.71|
                       (call L.+.71.9 |+.71| 101 105)
                       (call L.-.70.10 |-.70| 163 189))))))
          (define L.lam.74.23
            (lambda (c.92)
              (let ([fun/ascii-char10795.7 (unsafe-procedure-ref c.92 0)])
                (call L.fun/ascii-char10795.7.17 fun/ascii-char10795.7))))
    (define L.lam.73.22
      (lambda (c.91)
        (let ([fun/void10791.4 (unsafe-procedure-ref c.91 0)])
          (call L.fun/void10791.4.14 fun/void10791.4))))
    (define L.fun/ascii-char10793.11.21
      (lambda (c.90)
        (let ([fun/ascii-char10794.5 (unsafe-procedure-ref c.90 0)])
          (call L.fun/ascii-char10794.5.15 fun/ascii-char10794.5))))
    (define L.fun/void10792.10.20 (lambda (c.89) (let () (void))))
    (define L.fun/vector10790.9.19
      (lambda (c.88)
        (let ([make-vector.69 (unsafe-procedure-ref c.88 0)])
          (call L.make-vector.69.13 make-vector.69 8))))
    (define L.fun/vector10789.8.18
      (lambda (c.87)
        (let ([fun/vector10790.9 (unsafe-procedure-ref c.87 0)])
          (call L.fun/vector10790.9.19 fun/vector10790.9))))
    (define L.fun/ascii-char10795.7.17
      (lambda (c.86)
        (let ([fun/ascii-char10796.6 (unsafe-procedure-ref c.86 0)])
          (call L.fun/ascii-char10796.6.16 fun/ascii-char10796.6))))
    (define L.fun/ascii-char10796.6.16 (lambda (c.85) (let () #\j)))
    (define L.fun/ascii-char10794.5.15 (lambda (c.84) (let () #\F)))
    (define L.fun/void10791.4.14
      (lambda (c.83)
        (let ([fun/void10792.10 (unsafe-procedure-ref c.83 0)])
          (call L.fun/void10792.10.20 fun/void10792.10))))
    (define L.make-vector.69.13
      (lambda (c.82 tmp.45)
        (let ([make-init-vector.1 (unsafe-procedure-ref c.82 0)])
          (if (fixnum? tmp.45)
              (call L.make-init-vector.1.12 make-init-vector.1 tmp.45)
              (error 8)))))
    (define L.make-init-vector.1.12
      (lambda (c.81 tmp.17)
        (let ([vector-init-loop.19 (unsafe-procedure-ref c.81 0)])
          (let ([tmp.18 (unsafe-make-vector tmp.17)])
            (call L.vector-init-loop.19.11 vector-init-loop.19 tmp.17 0 tmp.18)))))
    (define L.vector-init-loop.19.11
      (lambda (c.80 len.20 i.22 vec.21)
        (let ([vector-init-loop.19 (unsafe-procedure-ref c.80 0)])
          (if (eq? len.20 i.22)
              vec.21
              (begin
                (unsafe-vector-set! vec.21 i.22 0)
                (call L.vector-init-loop.19.11
                      vector-init-loop.19
                      len.20
                      (unsafe-fx+ i.22 1)
                      vec.21))))))
    (define L.-.70.10
      (lambda (c.79 tmp.35 tmp.36)
        (let ()
          (if (fixnum? tmp.36)
              (if (fixnum? tmp.35)
                  (unsafe-fx- tmp.35 tmp.36)
                  (error 3))
              (error 3)))))
    (define L.+.71.9
      (lambda (c.78 tmp.33 tmp.34)
        (let ()
          (if (fixnum? tmp.34)
              (if (fixnum? tmp.33)
                  (unsafe-fx+ tmp.33 tmp.34)
                  (error 2))
              (error 2)))))
    (define L.vector-ref.72.8
      (lambda (c.77 tmp.50 tmp.51)
        (let ([unsafe-vector-ref.3 (unsafe-procedure-ref c.77 0)])
          (if (fixnum? tmp.51)
              (if (vector? tmp.50)
                  (call L.unsafe-vector-ref.3.7 unsafe-vector-ref.3 tmp.50 tmp.51)
                  (error 11))
              (error 11)))))
    (define L.unsafe-vector-ref.3.7
      (lambda (c.76 tmp.28 tmp.29)
        (let ()
          (if (unsafe-fx< tmp.29 (unsafe-vector-length tmp.28))
              (if (unsafe-fx>= tmp.29 0)
                  (unsafe-vector-ref tmp.28 tmp.29)
                  (error 11))
              (error 11)))))
    (let ([unsafe-vector-ref.3 (make-procedure L.unsafe-vector-ref.3.7 2 0)]
          [vector-ref.72 (make-procedure L.vector-ref.72.8 2 1)]
          [|+.71| (make-procedure L.+.71.9 2 0)]
          [|-.70| (make-procedure L.-.70.10 2 0)]
          [vector-init-loop.19 (make-procedure L.vector-init-loop.19.11 3 1)]
          [make-init-vector.1 (make-procedure L.make-init-vector.1.12 1 1)]
          [make-vector.69 (make-procedure L.make-vector.69.13 1 1)]
          [fun/void10791.4 (make-procedure L.fun/void10791.4.14 0 1)]
          [fun/ascii-char10794.5 (make-procedure L.fun/ascii-char10794.5.15 0 0)]
          [fun/ascii-char10796.6 (make-procedure L.fun/ascii-char10796.6.16 0 0)]
          [fun/ascii-char10795.7 (make-procedure L.fun/ascii-char10795.7.17 0 1)]
          [fun/vector10789.8 (make-procedure L.fun/vector10789.8.18 0 1)]
          [fun/vector10790.9 (make-procedure L.fun/vector10790.9.19 0 1)]
          [fun/void10792.10 (make-procedure L.fun/void10792.10.20 0 0)]
          [fun/ascii-char10793.11 (make-procedure L.fun/ascii-char10793.11.21 0 1)])
      (begin
        (unsafe-procedure-set! vector-ref.72 0 unsafe-vector-ref.3)
        (unsafe-procedure-set! vector-init-loop.19 0 vector-init-loop.19)
        (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.19)
        (unsafe-procedure-set! make-vector.69 0 make-init-vector.1)
        (unsafe-procedure-set! fun/void10791.4 0 fun/void10792.10)
        (unsafe-procedure-set! fun/ascii-char10795.7 0 fun/ascii-char10796.6)
        (unsafe-procedure-set! fun/vector10789.8 0 fun/vector10790.9)
        (unsafe-procedure-set! fun/vector10790.9 0 make-vector.69)
        (unsafe-procedure-set! fun/ascii-char10793.11 0 fun/ascii-char10794.5)
        (let ([vector0.16 (call L.fun/vector10789.8.18 fun/vector10789.8)]
              [procedure1.15 (let ([lam.73 (make-procedure L.lam.73.22 0 1)])
                               (begin
                                 (unsafe-procedure-set! lam.73 0 fun/void10791.4)
                                 lam.73))]
              [ascii-char2.14 (call L.fun/ascii-char10793.11.21 fun/ascii-char10793.11)]
              [procedure3.13 (let ([lam.74 (make-procedure L.lam.74.23 0 1)])
                               (begin
                                 (unsafe-procedure-set! lam.74 0 fun/ascii-char10795.7)
                                 lam.74))]
              [procedure4.12 (let ([lam.75 (make-procedure L.lam.75.24 0 2)])
                               (begin
                                 (unsafe-procedure-set! lam.75 0 |-.70|)
                                 (unsafe-procedure-set! lam.75 1 |+.71|)
                                 lam.75))])
          (call L.vector-ref.72.8 vector-ref.72 vector0.16 1))))))
; (check-by-interp
;  '(module
;     (define L.lam.77.24
;       (lambda (c.95)
;         (let ((fun/pair11669.5 (unsafe-procedure-ref c.95 0)))
;           (call L.fun/pair11669.5.12 fun/pair11669.5))))
;     (define L.lam.76.23
;       (lambda (c.94)
;         (let ((fun/empty11659.13 (unsafe-procedure-ref c.94 0)))
;           (call L.fun/empty11659.13.20 fun/empty11659.13))))
;     (define L.fun/empty11664.15.22 (lambda (c.93) (let () empty)))
;     (define L.fun/void11666.14.21 (lambda (c.92) (let () (void))))
;     (define L.fun/empty11659.13.20
;       (lambda (c.91)
;         (let ((fun/empty11660.10 (unsafe-procedure-ref c.91 0)))
;           (call L.fun/empty11660.10.17 fun/empty11660.10))))
;     (define L.fun/error11661.12.19
;       (lambda (c.90)
;         (let ((fun/error11662.8 (unsafe-procedure-ref c.90 0)))
;           (call L.fun/error11662.8.15 fun/error11662.8))))
;     (define L.fun/pair11670.11.18
;       (lambda (c.89)
;         (let ((cons.75 (unsafe-procedure-ref c.89 0)))
;           (call L.cons.75.7 cons.75 150 417))))
;     (define L.fun/empty11660.10.17 (lambda (c.88) (let () empty)))
;     (define L.fun/vector11668.9.16
;       (lambda (c.87)
;         (let ((make-vector.74 (unsafe-procedure-ref c.87 0)))
;           (call L.make-vector.74.10 make-vector.74 8))))
;     (define L.fun/error11662.8.15 (lambda (c.86) (let () (error 142))))
;     (define L.fun/empty11663.7.14
;       (lambda (c.85)
;         (let ((fun/empty11664.15 (unsafe-procedure-ref c.85 0)))
;           (call L.fun/empty11664.15.22 fun/empty11664.15))))
;     (define L.fun/void11665.6.13
;       (lambda (c.84)
;         (let ((fun/void11666.14 (unsafe-procedure-ref c.84 0)))
;           (call L.fun/void11666.14.21 fun/void11666.14))))
;     (define L.fun/pair11669.5.12
;       (lambda (c.83)
;         (let ((fun/pair11670.11 (unsafe-procedure-ref c.83 0)))
;           (call L.fun/pair11670.11.18 fun/pair11670.11))))
;     (define L.fun/vector11667.4.11
;       (lambda (c.82)
;         (let ((fun/vector11668.9 (unsafe-procedure-ref c.82 0)))
;           (call L.fun/vector11668.9.16 fun/vector11668.9))))
;     (define L.make-vector.74.10
;       (lambda (c.81 tmp.50)
;         (let ((make-init-vector.1 (unsafe-procedure-ref c.81 0)))
;           (if (fixnum? tmp.50)
;             (call L.make-init-vector.1.9 make-init-vector.1 tmp.50)
;             (error 8)))))
;     (define L.make-init-vector.1.9
;       (lambda (c.80 tmp.22)
;         (let ((vector-init-loop.24 (unsafe-procedure-ref c.80 0)))
;           (let ((tmp.23 (unsafe-make-vector tmp.22)))
;             (call
;              L.vector-init-loop.24.8
;              vector-init-loop.24
;              tmp.22
;              0
;              tmp.23)))))
;     (define L.vector-init-loop.24.8
;       (lambda (c.79 len.25 i.27 vec.26)
;         (let ((vector-init-loop.24 (unsafe-procedure-ref c.79 0)))
;           (if (eq? len.25 i.27)
;             vec.26
;             (begin
;               (unsafe-vector-set! vec.26 i.27 0)
;               (call
;                L.vector-init-loop.24.8
;                vector-init-loop.24
;                len.25
;                (unsafe-fx+ i.27 1)
;                vec.26))))))
;     (define L.cons.75.7
;       (lambda (c.78 tmp.69 tmp.70) (let () (cons tmp.69 tmp.70))))
;     (let ((cons.75 (make-procedure L.cons.75.7 2 0))
;           (vector-init-loop.24 (make-procedure L.vector-init-loop.24.8 3 1))
;           (make-init-vector.1 (make-procedure L.make-init-vector.1.9 1 1))
;           (make-vector.74 (make-procedure L.make-vector.74.10 1 1))
;           (fun/vector11667.4 (make-procedure L.fun/vector11667.4.11 0 1))
;           (fun/pair11669.5 (make-procedure L.fun/pair11669.5.12 0 1))
;           (fun/void11665.6 (make-procedure L.fun/void11665.6.13 0 1))
;           (fun/empty11663.7 (make-procedure L.fun/empty11663.7.14 0 1))
;           (fun/error11662.8 (make-procedure L.fun/error11662.8.15 0 0))
;           (fun/vector11668.9 (make-procedure L.fun/vector11668.9.16 0 1))
;           (fun/empty11660.10 (make-procedure L.fun/empty11660.10.17 0 0))
;           (fun/pair11670.11 (make-procedure L.fun/pair11670.11.18 0 1))
;           (fun/error11661.12 (make-procedure L.fun/error11661.12.19 0 1))
;           (fun/empty11659.13 (make-procedure L.fun/empty11659.13.20 0 1))
;           (fun/void11666.14 (make-procedure L.fun/void11666.14.21 0 0))
;           (fun/empty11664.15 (make-procedure L.fun/empty11664.15.22 0 0)))
;       (begin
;         (unsafe-procedure-set! vector-init-loop.24 0 vector-init-loop.24)
;         (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.24)
;         (unsafe-procedure-set! make-vector.74 0 make-init-vector.1)
;         (unsafe-procedure-set! fun/vector11667.4 0 fun/vector11668.9)
;         (unsafe-procedure-set! fun/pair11669.5 0 fun/pair11670.11)
;         (unsafe-procedure-set! fun/void11665.6 0 fun/void11666.14)
;         (unsafe-procedure-set! fun/empty11663.7 0 fun/empty11664.15)
;         (unsafe-procedure-set! fun/vector11668.9 0 make-vector.74)
;         (unsafe-procedure-set! fun/pair11670.11 0 cons.75)
;         (unsafe-procedure-set! fun/error11661.12 0 fun/error11662.8)
;         (unsafe-procedure-set! fun/empty11659.13 0 fun/empty11660.10)
;         (let ((procedure0.21
;                (let ((lam.76 (make-procedure L.lam.76.23 0 1)))
;                  (begin
;                    (unsafe-procedure-set! lam.76 0 fun/empty11659.13)
;                    lam.76)))
;               (error1.20 (call L.fun/error11661.12.19 fun/error11661.12))
;               (empty2.19 (call L.fun/empty11663.7.14 fun/empty11663.7))
;               (void3.18 (call L.fun/void11665.6.13 fun/void11665.6))
;               (vector4.17 (call L.fun/vector11667.4.11 fun/vector11667.4))
;               (procedure5.16
;                (let ((lam.77 (make-procedure L.lam.77.24 0 1)))
;                  (begin
;                    (unsafe-procedure-set! lam.77 0 fun/pair11669.5)
;                    lam.77))))
;           (if (procedure? procedure0.21)
;             (if (eq? (unsafe-procedure-arity procedure0.21) 0)
;               (call (unsafe-procedure-label procedure0.21) procedure0.21)
;               (error 42))
;             (error 43)))))))
; (check-by-interp
;  '(module
;     (define L.fun/error12035.15.21 (lambda (c.91) (let () (error 38))))
;     (define L.fun/ascii-char12031.14.20 (lambda (c.90) (let () #\])))
;     (define L.fun/error12029.13.19 (lambda (c.89) (let () (error 244))))
;     (define L.fun/empty12027.12.18 (lambda (c.88) (let () empty)))
;     (define L.fun/ascii-char12032.11.17
;       (lambda (c.87)
;         (let ((fun/ascii-char12033.10 (unsafe-procedure-ref c.87 0)))
;           (call L.fun/ascii-char12033.10.16 fun/ascii-char12033.10))))
;     (define L.fun/ascii-char12033.10.16 (lambda (c.86) (let () #\k)))
;     (define L.fun/error12025.9.15 (lambda (c.85) (let () (error 190))))
;     (define L.fun/error12028.8.14
;       (lambda (c.84)
;         (let ((fun/error12029.13 (unsafe-procedure-ref c.84 0)))
;           (call L.fun/error12029.13.19 fun/error12029.13))))
;     (define L.fun/error12034.7.13
;       (lambda (c.83)
;         (let ((fun/error12035.15 (unsafe-procedure-ref c.83 0)))
;           (call L.fun/error12035.15.21 fun/error12035.15))))
;     (define L.fun/ascii-char12030.6.12
;       (lambda (c.82)
;         (let ((fun/ascii-char12031.14 (unsafe-procedure-ref c.82 0)))
;           (call L.fun/ascii-char12031.14.20 fun/ascii-char12031.14))))
;     (define L.fun/error12024.5.11
;       (lambda (c.81)
;         (let ((fun/error12025.9 (unsafe-procedure-ref c.81 0)))
;           (call L.fun/error12025.9.15 fun/error12025.9))))
;     (define L.fun/empty12026.4.10
;       (lambda (c.80)
;         (let ((fun/empty12027.12 (unsafe-procedure-ref c.80 0)))
;           (call L.fun/empty12027.12.18 fun/empty12027.12))))
;     (define L.-.74.9
;       (lambda (c.79 tmp.40 tmp.41)
;         (let ()
;           (if (fixnum? tmp.41)
;             (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
;             (error 3)))))
;     (define L.*.75.8
;       (lambda (c.78 tmp.36 tmp.37)
;         (let ()
;           (if (fixnum? tmp.37)
;             (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
;             (error 1)))))
;     (define L.+.76.7
;       (lambda (c.77 tmp.38 tmp.39)
;         (let ()
;           (if (fixnum? tmp.39)
;             (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
;             (error 2)))))
;     (let ((|+.76| (make-procedure L.+.76.7 2 0))
;           (*.75 (make-procedure L.*.75.8 2 0))
;           (|-.74| (make-procedure L.-.74.9 2 0))
;           (fun/empty12026.4 (make-procedure L.fun/empty12026.4.10 0 1))
;           (fun/error12024.5 (make-procedure L.fun/error12024.5.11 0 1))
;           (fun/ascii-char12030.6
;            (make-procedure L.fun/ascii-char12030.6.12 0 1))
;           (fun/error12034.7 (make-procedure L.fun/error12034.7.13 0 1))
;           (fun/error12028.8 (make-procedure L.fun/error12028.8.14 0 1))
;           (fun/error12025.9 (make-procedure L.fun/error12025.9.15 0 0))
;           (fun/ascii-char12033.10
;            (make-procedure L.fun/ascii-char12033.10.16 0 0))
;           (fun/ascii-char12032.11
;            (make-procedure L.fun/ascii-char12032.11.17 0 1))
;           (fun/empty12027.12 (make-procedure L.fun/empty12027.12.18 0 0))
;           (fun/error12029.13 (make-procedure L.fun/error12029.13.19 0 0))
;           (fun/ascii-char12031.14
;            (make-procedure L.fun/ascii-char12031.14.20 0 0))
;           (fun/error12035.15 (make-procedure L.fun/error12035.15.21 0 0)))
;       (begin
;         (unsafe-procedure-set! fun/empty12026.4 0 fun/empty12027.12)
;         (unsafe-procedure-set! fun/error12024.5 0 fun/error12025.9)
;         (unsafe-procedure-set! fun/ascii-char12030.6 0 fun/ascii-char12031.14)
;         (unsafe-procedure-set! fun/error12034.7 0 fun/error12035.15)
;         (unsafe-procedure-set! fun/error12028.8 0 fun/error12029.13)
;         (unsafe-procedure-set! fun/ascii-char12032.11 0 fun/ascii-char12033.10)
;         (let ((fixnum0.21
;                (call
;                 L.+.76.7
;                 |+.76|
;                 (call
;                  L.-.74.9
;                  |-.74|
;                  (call
;                   L.+.76.7
;                   |+.76|
;                   (call L.-.74.9 |-.74| 20 248)
;                   (call L.*.75.8 *.75 206 242))
;                  (call
;                   L.-.74.9
;                   |-.74|
;                   (call L.+.76.7 |+.76| 165 249)
;                   (call L.*.75.8 *.75 245 99)))
;                 (call
;                  L.*.75.8
;                  *.75
;                  (call
;                   L.-.74.9
;                   |-.74|
;                   (call L.*.75.8 *.75 200 34)
;                   (call L.+.76.7 |+.76| 43 207))
;                  (call
;                   L.*.75.8
;                   *.75
;                   (call L.-.74.9 |-.74| 204 93)
;                   (call L.*.75.8 *.75 55 91)))))
;               (error1.20 (call L.fun/error12024.5.11 fun/error12024.5))
;               (empty2.19 (call L.fun/empty12026.4.10 fun/empty12026.4))
;               (error3.18 (call L.fun/error12028.8.14 fun/error12028.8))
;               (ascii-char4.17
;                (call L.fun/ascii-char12030.6.12 fun/ascii-char12030.6))
;               (ascii-char5.16
;                (call L.fun/ascii-char12032.11.17 fun/ascii-char12032.11)))
;           (call L.fun/error12034.7.13 fun/error12034.7))))))
; (check-by-interp
;  '(module
;     (define L.lam.75.20
;       (lambda (c.89)
;         (let ((fun/pair13985.9 (unsafe-procedure-ref c.89 0)))
;           (call L.fun/pair13985.9.13 fun/pair13985.9))))
;     (define L.fun/void13989.15.19
;       (lambda (c.88)
;         (let ((fun/void13990.8 (unsafe-procedure-ref c.88 0)))
;           (call L.fun/void13990.8.12 fun/void13990.8))))
;     (define L.fun/void13995.14.18
;       (lambda (c.87)
;         (let ((fun/void13996.7 (unsafe-procedure-ref c.87 0)))
;           (call L.fun/void13996.7.11 fun/void13996.7))))
;     (define L.fun/error13991.13.17
;       (lambda (c.86)
;         (let ((fun/error13992.4 (unsafe-procedure-ref c.86 0)))
;           (call L.fun/error13992.4.8 fun/error13992.4))))
;     (define L.fun/pair13986.12.16
;       (lambda (c.85)
;         (let ((cons.74 (unsafe-procedure-ref c.85 0)))
;           (call L.cons.74.7 cons.74 112 427))))
;     (define L.fun/ascii-char13988.11.15 (lambda (c.84) (let () #\j)))
;     (define L.fun/void13993.10.14
;       (lambda (c.83)
;         (let ((fun/void13994.6 (unsafe-procedure-ref c.83 0)))
;           (call L.fun/void13994.6.10 fun/void13994.6))))
;     (define L.fun/pair13985.9.13
;       (lambda (c.82)
;         (let ((fun/pair13986.12 (unsafe-procedure-ref c.82 0)))
;           (call L.fun/pair13986.12.16 fun/pair13986.12))))
;     (define L.fun/void13990.8.12 (lambda (c.81) (let () (void))))
;     (define L.fun/void13996.7.11 (lambda (c.80) (let () (void))))
;     (define L.fun/void13994.6.10 (lambda (c.79) (let () (void))))
;     (define L.fun/ascii-char13987.5.9
;       (lambda (c.78)
;         (let ((fun/ascii-char13988.11 (unsafe-procedure-ref c.78 0)))
;           (call L.fun/ascii-char13988.11.15 fun/ascii-char13988.11))))
;     (define L.fun/error13992.4.8 (lambda (c.77) (let () (error 29))))
;     (define L.cons.74.7
;       (lambda (c.76 tmp.69 tmp.70) (let () (cons tmp.69 tmp.70))))
;     (let ((cons.74 (make-procedure L.cons.74.7 2 0))
;           (fun/error13992.4 (make-procedure L.fun/error13992.4.8 0 0))
;           (fun/ascii-char13987.5
;            (make-procedure L.fun/ascii-char13987.5.9 0 1))
;           (fun/void13994.6 (make-procedure L.fun/void13994.6.10 0 0))
;           (fun/void13996.7 (make-procedure L.fun/void13996.7.11 0 0))
;           (fun/void13990.8 (make-procedure L.fun/void13990.8.12 0 0))
;           (fun/pair13985.9 (make-procedure L.fun/pair13985.9.13 0 1))
;           (fun/void13993.10 (make-procedure L.fun/void13993.10.14 0 1))
;           (fun/ascii-char13988.11
;            (make-procedure L.fun/ascii-char13988.11.15 0 0))
;           (fun/pair13986.12 (make-procedure L.fun/pair13986.12.16 0 1))
;           (fun/error13991.13 (make-procedure L.fun/error13991.13.17 0 1))
;           (fun/void13995.14 (make-procedure L.fun/void13995.14.18 0 1))
;           (fun/void13989.15 (make-procedure L.fun/void13989.15.19 0 1)))
;       (begin
;         (unsafe-procedure-set! fun/ascii-char13987.5 0 fun/ascii-char13988.11)
;         (unsafe-procedure-set! fun/pair13985.9 0 fun/pair13986.12)
;         (unsafe-procedure-set! fun/void13993.10 0 fun/void13994.6)
;         (unsafe-procedure-set! fun/pair13986.12 0 cons.74)
;         (unsafe-procedure-set! fun/error13991.13 0 fun/error13992.4)
;         (unsafe-procedure-set! fun/void13995.14 0 fun/void13996.7)
;         (unsafe-procedure-set! fun/void13989.15 0 fun/void13990.8)
;         (let ((procedure0.21
;                (let ((lam.75 (make-procedure L.lam.75.20 0 1)))
;                  (begin
;                    (unsafe-procedure-set! lam.75 0 fun/pair13985.9)
;                    lam.75)))
;               (ascii-char1.20
;                (call L.fun/ascii-char13987.5.9 fun/ascii-char13987.5))
;               (void2.19 (call L.fun/void13989.15.19 fun/void13989.15))
;               (error3.18 (call L.fun/error13991.13.17 fun/error13991.13))
;               (void4.17 (call L.fun/void13993.10.14 fun/void13993.10))
;               (void5.16 (call L.fun/void13995.14.18 fun/void13995.14)))
;           (if (procedure? procedure0.21)
;             (if (eq? (unsafe-procedure-arity procedure0.21) 0)
;               (call (unsafe-procedure-label procedure0.21) procedure0.21)
;               (error 42))
;             (error 43)))))))
; (check-by-interp
;  '(module
;     (define L.lam.80.27
;       (lambda (c.101)
;         (let ((fun/any14746.10 (unsafe-procedure-ref c.101 0))
;               (ascii-char?.79 (unsafe-procedure-ref c.101 1)))
;           (call
;            L.ascii-char?.79.7
;            ascii-char?.79
;            (call L.fun/any14746.10.21 fun/any14746.10)))))
;     (define L.fun/vector14739.15.26
;       (lambda (c.100)
;         (let ((make-vector.74 (unsafe-procedure-ref c.100 0)))
;           (call L.make-vector.74.14 make-vector.74 8))))
;     (define L.fun/ascii-char14749.14.25 (lambda (c.99) (let () #\z)))
;     (define L.fun/ascii-char14743.13.24 (lambda (c.98) (let () #\f)))
;     (define L.fun/any14741.12.23
;       (lambda (c.97)
;         (let ((make-vector.74 (unsafe-procedure-ref c.97 0)))
;           (call L.make-vector.74.14 make-vector.74 8))))
;     (define L.fun/any14747.11.22 (lambda (c.96) (let () empty)))
;     (define L.fun/any14746.10.21
;       (lambda (c.95)
;         (let ((fun/any14747.11 (unsafe-procedure-ref c.95 0)))
;           (call L.fun/any14747.11.22 fun/any14747.11))))
;     (define L.fun/ascii-char14742.9.20
;       (lambda (c.94)
;         (let ((fun/ascii-char14743.13 (unsafe-procedure-ref c.94 0)))
;           (call L.fun/ascii-char14743.13.24 fun/ascii-char14743.13))))
;     (define L.fun/ascii-char14748.8.19
;       (lambda (c.93)
;         (let ((fun/ascii-char14749.14 (unsafe-procedure-ref c.93 0)))
;           (call L.fun/ascii-char14749.14.25 fun/ascii-char14749.14))))
;     (define L.fun/any14740.7.18
;       (lambda (c.92)
;         (let ((fun/any14741.12 (unsafe-procedure-ref c.92 0)))
;           (call L.fun/any14741.12.23 fun/any14741.12))))
;     (define L.fun/vector14744.6.17
;       (lambda (c.91)
;         (let ((fun/vector14745.5 (unsafe-procedure-ref c.91 0)))
;           (call L.fun/vector14745.5.16 fun/vector14745.5))))
;     (define L.fun/vector14745.5.16
;       (lambda (c.90)
;         (let ((make-vector.74 (unsafe-procedure-ref c.90 0)))
;           (call L.make-vector.74.14 make-vector.74 8))))
;     (define L.fun/vector14738.4.15
;       (lambda (c.89)
;         (let ((fun/vector14739.15 (unsafe-procedure-ref c.89 0)))
;           (call L.fun/vector14739.15.26 fun/vector14739.15))))
;     (define L.make-vector.74.14
;       (lambda (c.88 tmp.50)
;         (let ((make-init-vector.1 (unsafe-procedure-ref c.88 0)))
;           (if (fixnum? tmp.50)
;             (call L.make-init-vector.1.13 make-init-vector.1 tmp.50)
;             (error 8)))))
;     (define L.make-init-vector.1.13
;       (lambda (c.87 tmp.22)
;         (let ((vector-init-loop.24 (unsafe-procedure-ref c.87 0)))
;           (let ((tmp.23 (unsafe-make-vector tmp.22)))
;             (call
;              L.vector-init-loop.24.12
;              vector-init-loop.24
;              tmp.22
;              0
;              tmp.23)))))
;     (define L.vector-init-loop.24.12
;       (lambda (c.86 len.25 i.27 vec.26)
;         (let ((vector-init-loop.24 (unsafe-procedure-ref c.86 0)))
;           (if (eq? len.25 i.27)
;             vec.26
;             (begin
;               (unsafe-vector-set! vec.26 i.27 0)
;               (call
;                L.vector-init-loop.24.12
;                vector-init-loop.24
;                len.25
;                (unsafe-fx+ i.27 1)
;                vec.26))))))
;     (define L.-.75.11
;       (lambda (c.85 tmp.40 tmp.41)
;         (let ()
;           (if (fixnum? tmp.41)
;             (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
;             (error 3)))))
;     (define L.*.76.10
;       (lambda (c.84 tmp.36 tmp.37)
;         (let ()
;           (if (fixnum? tmp.37)
;             (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
;             (error 1)))))
;     (define L.+.77.9
;       (lambda (c.83 tmp.38 tmp.39)
;         (let ()
;           (if (fixnum? tmp.39)
;             (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
;             (error 2)))))
;     (define L.fixnum?.78.8 (lambda (c.82 tmp.59) (let () (fixnum? tmp.59))))
;     (define L.ascii-char?.79.7
;       (lambda (c.81 tmp.63) (let () (ascii-char? tmp.63))))
;     (let ((ascii-char?.79 (make-procedure L.ascii-char?.79.7 1 0))
;           (fixnum?.78 (make-procedure L.fixnum?.78.8 1 0))
;           (|+.77| (make-procedure L.+.77.9 2 0))
;           (*.76 (make-procedure L.*.76.10 2 0))
;           (|-.75| (make-procedure L.-.75.11 2 0))
;           (vector-init-loop.24 (make-procedure L.vector-init-loop.24.12 3 1))
;           (make-init-vector.1 (make-procedure L.make-init-vector.1.13 1 1))
;           (make-vector.74 (make-procedure L.make-vector.74.14 1 1))
;           (fun/vector14738.4 (make-procedure L.fun/vector14738.4.15 0 1))
;           (fun/vector14745.5 (make-procedure L.fun/vector14745.5.16 0 1))
;           (fun/vector14744.6 (make-procedure L.fun/vector14744.6.17 0 1))
;           (fun/any14740.7 (make-procedure L.fun/any14740.7.18 0 1))
;           (fun/ascii-char14748.8
;            (make-procedure L.fun/ascii-char14748.8.19 0 1))
;           (fun/ascii-char14742.9
;            (make-procedure L.fun/ascii-char14742.9.20 0 1))
;           (fun/any14746.10 (make-procedure L.fun/any14746.10.21 0 1))
;           (fun/any14747.11 (make-procedure L.fun/any14747.11.22 0 0))
;           (fun/any14741.12 (make-procedure L.fun/any14741.12.23 0 1))
;           (fun/ascii-char14743.13
;            (make-procedure L.fun/ascii-char14743.13.24 0 0))
;           (fun/ascii-char14749.14
;            (make-procedure L.fun/ascii-char14749.14.25 0 0))
;           (fun/vector14739.15 (make-procedure L.fun/vector14739.15.26 0 1)))
;       (begin
;         (unsafe-procedure-set! vector-init-loop.24 0 vector-init-loop.24)
;         (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.24)
;         (unsafe-procedure-set! make-vector.74 0 make-init-vector.1)
;         (unsafe-procedure-set! fun/vector14738.4 0 fun/vector14739.15)
;         (unsafe-procedure-set! fun/vector14745.5 0 make-vector.74)
;         (unsafe-procedure-set! fun/vector14744.6 0 fun/vector14745.5)
;         (unsafe-procedure-set! fun/any14740.7 0 fun/any14741.12)
;         (unsafe-procedure-set! fun/ascii-char14748.8 0 fun/ascii-char14749.14)
;         (unsafe-procedure-set! fun/ascii-char14742.9 0 fun/ascii-char14743.13)
;         (unsafe-procedure-set! fun/any14746.10 0 fun/any14747.11)
;         (unsafe-procedure-set! fun/any14741.12 0 make-vector.74)
;         (unsafe-procedure-set! fun/vector14739.15 0 make-vector.74)
;         (let ((vector0.21 (call L.fun/vector14738.4.15 fun/vector14738.4))
;               (fixnum1.20
;                (call
;                 L.+.77.9
;                 |+.77|
;                 (call
;                  L.*.76.10
;                  *.76
;                  (call
;                   L.*.76.10
;                   *.76
;                   (call L.-.75.11 |-.75| 45 247)
;                   (call L.-.75.11 |-.75| 119 239))
;                  (call
;                   L.+.77.9
;                   |+.77|
;                   (call L.-.75.11 |-.75| 100 45)
;                   (call L.*.76.10 *.76 251 105)))
;                 (call
;                  L.*.76.10
;                  *.76
;                  (call
;                   L.-.75.11
;                   |-.75|
;                   (call L.*.76.10 *.76 114 238)
;                   (call L.*.76.10 *.76 230 88))
;                  (call
;                   L.-.75.11
;                   |-.75|
;                   (call L.+.77.9 |+.77| 250 216)
;                   (call L.+.77.9 |+.77| 89 76)))))
;               (boolean2.19
;                (call
;                 L.fixnum?.78.8
;                 fixnum?.78
;                 (call L.fun/any14740.7.18 fun/any14740.7)))
;               (ascii-char3.18
;                (call L.fun/ascii-char14742.9.20 fun/ascii-char14742.9))
;               (vector4.17 (call L.fun/vector14744.6.17 fun/vector14744.6))
;               (procedure5.16
;                (let ((lam.80 (make-procedure L.lam.80.27 0 2)))
;                  (begin
;                    (unsafe-procedure-set! lam.80 0 fun/any14746.10)
;                    (unsafe-procedure-set! lam.80 1 ascii-char?.79)
;                    lam.80))))
;           (call L.fun/ascii-char14748.8.19 fun/ascii-char14748.8))))))
; (check-by-interp
;  '(module
;     (define L.fun/any14774.13.23
;       (lambda (c.93)
;         (let ((fun/any14775.7 (unsafe-procedure-ref c.93 0)))
;           (call L.fun/any14775.7.17 fun/any14775.7))))
;     (define L.fun/vector14776.12.22
;       (lambda (c.92)
;         (let ((fun/vector14777.9 (unsafe-procedure-ref c.92 0)))
;           (call L.fun/vector14777.9.19 fun/vector14777.9))))
;     (define L.fun/ascii-char14781.11.21 (lambda (c.91) (let () #\Z)))
;     (define L.fun/empty14778.10.20
;       (lambda (c.90)
;         (let ((fun/empty14779.6 (unsafe-procedure-ref c.90 0)))
;           (call L.fun/empty14779.6.16 fun/empty14779.6))))
;     (define L.fun/vector14777.9.19
;       (lambda (c.89)
;         (let ((make-vector.72 (unsafe-procedure-ref c.89 0)))
;           (call L.make-vector.72.13 make-vector.72 8))))
;     (define L.fun/vector14773.8.18
;       (lambda (c.88)
;         (let ((make-vector.72 (unsafe-procedure-ref c.88 0)))
;           (call L.make-vector.72.13 make-vector.72 8))))
;     (define L.fun/any14775.7.17 (lambda (c.87) (let () 147)))
;     (define L.fun/empty14779.6.16 (lambda (c.86) (let () empty)))
;     (define L.fun/vector14772.5.15
;       (lambda (c.85)
;         (let ((fun/vector14773.8 (unsafe-procedure-ref c.85 0)))
;           (call L.fun/vector14773.8.18 fun/vector14773.8))))
;     (define L.fun/ascii-char14780.4.14
;       (lambda (c.84)
;         (let ((fun/ascii-char14781.11 (unsafe-procedure-ref c.84 0)))
;           (call L.fun/ascii-char14781.11.21 fun/ascii-char14781.11))))
;     (define L.make-vector.72.13
;       (lambda (c.83 tmp.48)
;         (let ((make-init-vector.1 (unsafe-procedure-ref c.83 0)))
;           (if (fixnum? tmp.48)
;             (call L.make-init-vector.1.12 make-init-vector.1 tmp.48)
;             (error 8)))))
;     (define L.make-init-vector.1.12
;       (lambda (c.82 tmp.20)
;         (let ((vector-init-loop.22 (unsafe-procedure-ref c.82 0)))
;           (let ((tmp.21 (unsafe-make-vector tmp.20)))
;             (call
;              L.vector-init-loop.22.11
;              vector-init-loop.22
;              tmp.20
;              0
;              tmp.21)))))
;     (define L.vector-init-loop.22.11
;       (lambda (c.81 len.23 i.25 vec.24)
;         (let ((vector-init-loop.22 (unsafe-procedure-ref c.81 0)))
;           (if (eq? len.23 i.25)
;             vec.24
;             (begin
;               (unsafe-vector-set! vec.24 i.25 0)
;               (call
;                L.vector-init-loop.22.11
;                vector-init-loop.22
;                len.23
;                (unsafe-fx+ i.25 1)
;                vec.24))))))
;     (define L.+.73.10
;       (lambda (c.80 tmp.36 tmp.37)
;         (let ()
;           (if (fixnum? tmp.37)
;             (if (fixnum? tmp.36) (unsafe-fx+ tmp.36 tmp.37) (error 2))
;             (error 2)))))
;     (define L.-.74.9
;       (lambda (c.79 tmp.38 tmp.39)
;         (let ()
;           (if (fixnum? tmp.39)
;             (if (fixnum? tmp.38) (unsafe-fx- tmp.38 tmp.39) (error 3))
;             (error 3)))))
;     (define L.*.75.8
;       (lambda (c.78 tmp.34 tmp.35)
;         (let ()
;           (if (fixnum? tmp.35)
;             (if (fixnum? tmp.34) (unsafe-fx* tmp.34 tmp.35) (error 1))
;             (error 1)))))
;     (define L.procedure?.76.7
;       (lambda (c.77 tmp.66) (let () (procedure? tmp.66))))
;     (let ((procedure?.76 (make-procedure L.procedure?.76.7 1 0))
;           (*.75 (make-procedure L.*.75.8 2 0))
;           (|-.74| (make-procedure L.-.74.9 2 0))
;           (|+.73| (make-procedure L.+.73.10 2 0))
;           (vector-init-loop.22 (make-procedure L.vector-init-loop.22.11 3 1))
;           (make-init-vector.1 (make-procedure L.make-init-vector.1.12 1 1))
;           (make-vector.72 (make-procedure L.make-vector.72.13 1 1))
;           (fun/ascii-char14780.4
;            (make-procedure L.fun/ascii-char14780.4.14 0 1))
;           (fun/vector14772.5 (make-procedure L.fun/vector14772.5.15 0 1))
;           (fun/empty14779.6 (make-procedure L.fun/empty14779.6.16 0 0))
;           (fun/any14775.7 (make-procedure L.fun/any14775.7.17 0 0))
;           (fun/vector14773.8 (make-procedure L.fun/vector14773.8.18 0 1))
;           (fun/vector14777.9 (make-procedure L.fun/vector14777.9.19 0 1))
;           (fun/empty14778.10 (make-procedure L.fun/empty14778.10.20 0 1))
;           (fun/ascii-char14781.11
;            (make-procedure L.fun/ascii-char14781.11.21 0 0))
;           (fun/vector14776.12 (make-procedure L.fun/vector14776.12.22 0 1))
;           (fun/any14774.13 (make-procedure L.fun/any14774.13.23 0 1)))
;       (begin
;         (unsafe-procedure-set! vector-init-loop.22 0 vector-init-loop.22)
;         (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.22)
;         (unsafe-procedure-set! make-vector.72 0 make-init-vector.1)
;         (unsafe-procedure-set! fun/ascii-char14780.4 0 fun/ascii-char14781.11)
;         (unsafe-procedure-set! fun/vector14772.5 0 fun/vector14773.8)
;         (unsafe-procedure-set! fun/vector14773.8 0 make-vector.72)
;         (unsafe-procedure-set! fun/vector14777.9 0 make-vector.72)
;         (unsafe-procedure-set! fun/empty14778.10 0 fun/empty14779.6)
;         (unsafe-procedure-set! fun/vector14776.12 0 fun/vector14777.9)
;         (unsafe-procedure-set! fun/any14774.13 0 fun/any14775.7)
;         (let ((fixnum0.19
;                (call
;                 L.*.75.8
;                 *.75
;                 (call
;                  L.-.74.9
;                  |-.74|
;                  (call
;                   L.+.73.10
;                   |+.73|
;                   (call L.+.73.10 |+.73| 228 49)
;                   (call L.+.73.10 |+.73| 11 111))
;                  (call
;                   L.+.73.10
;                   |+.73|
;                   (call L.-.74.9 |-.74| 17 94)
;                   (call L.*.75.8 *.75 83 228)))
;                 (call
;                  L.-.74.9
;                  |-.74|
;                  (call
;                   L.*.75.8
;                   *.75
;                   (call L.-.74.9 |-.74| 76 30)
;                   (call L.+.73.10 |+.73| 20 59))
;                  (call
;                   L.-.74.9
;                   |-.74|
;                   (call L.-.74.9 |-.74| 248 63)
;                   (call L.*.75.8 *.75 59 35)))))
;               (vector1.18 (call L.fun/vector14772.5.15 fun/vector14772.5))
;               (boolean2.17
;                (call
;                 L.procedure?.76.7
;                 procedure?.76
;                 (call L.fun/any14774.13.23 fun/any14774.13)))
;               (vector3.16 (call L.fun/vector14776.12.22 fun/vector14776.12))
;               (fixnum4.15
;                (call
;                 L.-.74.9
;                 |-.74|
;                 (call
;                  L.-.74.9
;                  |-.74|
;                  (call
;                   L.-.74.9
;                   |-.74|
;                   (call L.*.75.8 *.75 35 53)
;                   (call L.+.73.10 |+.73| 152 36))
;                  (call
;                   L.-.74.9
;                   |-.74|
;                   (call L.+.73.10 |+.73| 147 111)
;                   (call L.-.74.9 |-.74| 250 208)))
;                 (call
;                  L.+.73.10
;                  |+.73|
;                  (call
;                   L.+.73.10
;                   |+.73|
;                   (call L.+.73.10 |+.73| 245 114)
;                   (call L.*.75.8 *.75 118 89))
;                  (call
;                   L.-.74.9
;                   |-.74|
;                   (call L.*.75.8 *.75 148 242)
;                   (call L.-.74.9 |-.74| 212 75)))))
;               (empty5.14 (call L.fun/empty14778.10.20 fun/empty14778.10)))
;           (call L.fun/ascii-char14780.4.14 fun/ascii-char14780.4))))))
; (check-by-interp
;  '(module
;     (define L.fun/error15420.17.22
;       (lambda (c.93)
;         (let ((fun/error15421.9 (unsafe-procedure-ref c.93 0)))
;           (call L.fun/error15421.9.14 fun/error15421.9))))
;     (define L.fun/error15416.16.21
;       (lambda (c.92)
;         (let ((fun/error15417.4 (unsafe-procedure-ref c.92 0)))
;           (call L.fun/error15417.4.9 fun/error15417.4))))
;     (define L.fun/pair15427.15.20
;       (lambda (c.91)
;         (let ((cons.76 (unsafe-procedure-ref c.91 0)))
;           (call L.cons.76.8 cons.76 247 511))))
;     (define L.fun/any15414.14.19
;       (lambda (c.90)
;         (let ((fun/any15415.5 (unsafe-procedure-ref c.90 0)))
;           (call L.fun/any15415.5.10 fun/any15415.5))))
;     (define L.fun/void15425.13.18 (lambda (c.89) (let () (void))))
;     (define L.fun/error15422.12.17
;       (lambda (c.88)
;         (let ((fun/error15423.7 (unsafe-procedure-ref c.88 0)))
;           (call L.fun/error15423.7.12 fun/error15423.7))))
;     (define L.fun/error15419.11.16 (lambda (c.87) (let () (error 229))))
;     (define L.fun/error15418.10.15
;       (lambda (c.86)
;         (let ((fun/error15419.11 (unsafe-procedure-ref c.86 0)))
;           (call L.fun/error15419.11.16 fun/error15419.11))))
;     (define L.fun/error15421.9.14 (lambda (c.85) (let () (error 37))))
;     (define L.fun/void15424.8.13
;       (lambda (c.84)
;         (let ((fun/void15425.13 (unsafe-procedure-ref c.84 0)))
;           (call L.fun/void15425.13.18 fun/void15425.13))))
;     (define L.fun/error15423.7.12 (lambda (c.83) (let () (error 88))))
;     (define L.fun/pair15426.6.11
;       (lambda (c.82)
;         (let ((fun/pair15427.15 (unsafe-procedure-ref c.82 0)))
;           (call L.fun/pair15427.15.20 fun/pair15427.15))))
;     (define L.fun/any15415.5.10 (lambda (c.81) (let () #f)))
;     (define L.fun/error15417.4.9 (lambda (c.80) (let () (error 26))))
;     (define L.cons.76.8
;       (lambda (c.79 tmp.71 tmp.72) (let () (cons tmp.71 tmp.72))))
;     (define L.ascii-char?.77.7
;       (lambda (c.78 tmp.65) (let () (ascii-char? tmp.65))))
;     (let ((ascii-char?.77 (make-procedure L.ascii-char?.77.7 1 0))
;           (cons.76 (make-procedure L.cons.76.8 2 0))
;           (fun/error15417.4 (make-procedure L.fun/error15417.4.9 0 0))
;           (fun/any15415.5 (make-procedure L.fun/any15415.5.10 0 0))
;           (fun/pair15426.6 (make-procedure L.fun/pair15426.6.11 0 1))
;           (fun/error15423.7 (make-procedure L.fun/error15423.7.12 0 0))
;           (fun/void15424.8 (make-procedure L.fun/void15424.8.13 0 1))
;           (fun/error15421.9 (make-procedure L.fun/error15421.9.14 0 0))
;           (fun/error15418.10 (make-procedure L.fun/error15418.10.15 0 1))
;           (fun/error15419.11 (make-procedure L.fun/error15419.11.16 0 0))
;           (fun/error15422.12 (make-procedure L.fun/error15422.12.17 0 1))
;           (fun/void15425.13 (make-procedure L.fun/void15425.13.18 0 0))
;           (fun/any15414.14 (make-procedure L.fun/any15414.14.19 0 1))
;           (fun/pair15427.15 (make-procedure L.fun/pair15427.15.20 0 1))
;           (fun/error15416.16 (make-procedure L.fun/error15416.16.21 0 1))
;           (fun/error15420.17 (make-procedure L.fun/error15420.17.22 0 1)))
;       (begin
;         (unsafe-procedure-set! fun/pair15426.6 0 fun/pair15427.15)
;         (unsafe-procedure-set! fun/void15424.8 0 fun/void15425.13)
;         (unsafe-procedure-set! fun/error15418.10 0 fun/error15419.11)
;         (unsafe-procedure-set! fun/error15422.12 0 fun/error15423.7)
;         (unsafe-procedure-set! fun/any15414.14 0 fun/any15415.5)
;         (unsafe-procedure-set! fun/pair15427.15 0 cons.76)
;         (unsafe-procedure-set! fun/error15416.16 0 fun/error15417.4)
;         (unsafe-procedure-set! fun/error15420.17 0 fun/error15421.9)
;         (let ((boolean0.23
;                (call
;                 L.ascii-char?.77.7
;                 ascii-char?.77
;                 (call L.fun/any15414.14.19 fun/any15414.14)))
;               (error1.22 (call L.fun/error15416.16.21 fun/error15416.16))
;               (error2.21 (call L.fun/error15418.10.15 fun/error15418.10))
;               (error3.20 (call L.fun/error15420.17.22 fun/error15420.17))
;               (error4.19 (call L.fun/error15422.12.17 fun/error15422.12))
;               (void5.18 (call L.fun/void15424.8.13 fun/void15424.8)))
;           (call L.fun/pair15426.6.11 fun/pair15426.6))))))
; (check-by-interp
;  '(module
;     (define L.fun/ascii-char16443.15.21
;       (lambda (c.91)
;         (let ((fun/ascii-char16444.5 (unsafe-procedure-ref c.91 0)))
;           (call L.fun/ascii-char16444.5.11 fun/ascii-char16444.5))))
;     (define L.fun/void16440.14.20 (lambda (c.90) (let () (void))))
;     (define L.fun/error16434.13.19 (lambda (c.89) (let () (error 239))))
;     (define L.fun/ascii-char16441.12.18
;       (lambda (c.88)
;         (let ((fun/ascii-char16442.11 (unsafe-procedure-ref c.88 0)))
;           (call L.fun/ascii-char16442.11.17 fun/ascii-char16442.11))))
;     (define L.fun/ascii-char16442.11.17 (lambda (c.87) (let () #\`)))
;     (define L.fun/ascii-char16436.10.16 (lambda (c.86) (let () #\[)))
;     (define L.fun/ascii-char16438.9.15 (lambda (c.85) (let () #\H)))
;     (define L.fun/error16433.8.14
;       (lambda (c.84)
;         (let ((fun/error16434.13 (unsafe-procedure-ref c.84 0)))
;           (call L.fun/error16434.13.19 fun/error16434.13))))
;     (define L.fun/ascii-char16437.7.13
;       (lambda (c.83)
;         (let ((fun/ascii-char16438.9 (unsafe-procedure-ref c.83 0)))
;           (call L.fun/ascii-char16438.9.15 fun/ascii-char16438.9))))
;     (define L.fun/void16439.6.12
;       (lambda (c.82)
;         (let ((fun/void16440.14 (unsafe-procedure-ref c.82 0)))
;           (call L.fun/void16440.14.20 fun/void16440.14))))
;     (define L.fun/ascii-char16444.5.11 (lambda (c.81) (let () #\e)))
;     (define L.fun/ascii-char16435.4.10
;       (lambda (c.80)
;         (let ((fun/ascii-char16436.10 (unsafe-procedure-ref c.80 0)))
;           (call L.fun/ascii-char16436.10.16 fun/ascii-char16436.10))))
;     (define L.*.74.9
;       (lambda (c.79 tmp.36 tmp.37)
;         (let ()
;           (if (fixnum? tmp.37)
;             (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
;             (error 1)))))
;     (define L.-.75.8
;       (lambda (c.78 tmp.40 tmp.41)
;         (let ()
;           (if (fixnum? tmp.41)
;             (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
;             (error 3)))))
;     (define L.+.76.7
;       (lambda (c.77 tmp.38 tmp.39)
;         (let ()
;           (if (fixnum? tmp.39)
;             (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
;             (error 2)))))
;     (let ((|+.76| (make-procedure L.+.76.7 2 0))
;           (|-.75| (make-procedure L.-.75.8 2 0))
;           (*.74 (make-procedure L.*.74.9 2 0))
;           (fun/ascii-char16435.4
;            (make-procedure L.fun/ascii-char16435.4.10 0 1))
;           (fun/ascii-char16444.5
;            (make-procedure L.fun/ascii-char16444.5.11 0 0))
;           (fun/void16439.6 (make-procedure L.fun/void16439.6.12 0 1))
;           (fun/ascii-char16437.7
;            (make-procedure L.fun/ascii-char16437.7.13 0 1))
;           (fun/error16433.8 (make-procedure L.fun/error16433.8.14 0 1))
;           (fun/ascii-char16438.9
;            (make-procedure L.fun/ascii-char16438.9.15 0 0))
;           (fun/ascii-char16436.10
;            (make-procedure L.fun/ascii-char16436.10.16 0 0))
;           (fun/ascii-char16442.11
;            (make-procedure L.fun/ascii-char16442.11.17 0 0))
;           (fun/ascii-char16441.12
;            (make-procedure L.fun/ascii-char16441.12.18 0 1))
;           (fun/error16434.13 (make-procedure L.fun/error16434.13.19 0 0))
;           (fun/void16440.14 (make-procedure L.fun/void16440.14.20 0 0))
;           (fun/ascii-char16443.15
;            (make-procedure L.fun/ascii-char16443.15.21 0 1)))
;       (begin
;         (unsafe-procedure-set! fun/ascii-char16435.4 0 fun/ascii-char16436.10)
;         (unsafe-procedure-set! fun/void16439.6 0 fun/void16440.14)
;         (unsafe-procedure-set! fun/ascii-char16437.7 0 fun/ascii-char16438.9)
;         (unsafe-procedure-set! fun/error16433.8 0 fun/error16434.13)
;         (unsafe-procedure-set! fun/ascii-char16441.12 0 fun/ascii-char16442.11)
;         (unsafe-procedure-set! fun/ascii-char16443.15 0 fun/ascii-char16444.5)
;         (let ((error0.21 (call L.fun/error16433.8.14 fun/error16433.8))
;               (ascii-char1.20
;                (call L.fun/ascii-char16435.4.10 fun/ascii-char16435.4))
;               (fixnum2.19
;                (call
;                 L.+.76.7
;                 |+.76|
;                 (call
;                  L.*.74.9
;                  *.74
;                  (call
;                   L.-.75.8
;                   |-.75|
;                   (call L.*.74.9 *.74 240 46)
;                   (call L.-.75.8 |-.75| 188 112))
;                  (call
;                   L.-.75.8
;                   |-.75|
;                   (call L.*.74.9 *.74 35 210)
;                   (call L.+.76.7 |+.76| 107 254)))
;                 (call
;                  L.-.75.8
;                  |-.75|
;                  (call
;                   L.*.74.9
;                   *.74
;                   (call L.-.75.8 |-.75| 80 233)
;                   (call L.*.74.9 *.74 108 186))
;                  (call
;                   L.-.75.8
;                   |-.75|
;                   (call L.-.75.8 |-.75| 234 172)
;                   (call L.+.76.7 |+.76| 179 80)))))
;               (ascii-char3.18
;                (call L.fun/ascii-char16437.7.13 fun/ascii-char16437.7))
;               (void4.17 (call L.fun/void16439.6.12 fun/void16439.6))
;               (ascii-char5.16
;                (call L.fun/ascii-char16441.12.18 fun/ascii-char16441.12)))
;           (call L.fun/ascii-char16443.15.21 fun/ascii-char16443.15))))))
; (check-by-interp
;  '(module
;     (define L.fun/error16486.12.24 (lambda (c.107) (let () (error 225))))
;     (define L.fun/empty16490.11.23 (lambda (c.106) (let () empty)))
;     (define L.fun/error16485.10.22 (lambda (c.105) (let () (error 237))))
;     (define L.fun/empty16489.9.21 (lambda (c.104) (let () empty)))
;     (define L.fun/any16488.8.20 (lambda (c.103) (let () 68)))
;     (define L.fun/empty16487.7.19 (lambda (c.102) (let () empty)))
;     (define L.fun/vector16484.6.18
;       (lambda (c.101)
;         (let ((make-vector.83 (unsafe-procedure-ref c.101 0)))
;           (call L.make-vector.83.15 make-vector.83 8))))
;     (define L.fun/empty16491.5.17 (lambda (c.100) (let () empty)))
;     (define L.fun/ascii-char16492.4.16 (lambda (c.99) (let () #\h)))
;     (define L.make-vector.83.15
;       (lambda (c.98 tmp.59)
;         (let ((make-init-vector.1 (unsafe-procedure-ref c.98 0)))
;           (if (fixnum? tmp.59)
;             (call L.make-init-vector.1.14 make-init-vector.1 tmp.59)
;             (error 8)))))
;     (define L.make-init-vector.1.14
;       (lambda (c.97 tmp.31)
;         (let ((vector-init-loop.33 (unsafe-procedure-ref c.97 0)))
;           (let ((tmp.32 (unsafe-make-vector tmp.31)))
;             (call
;              L.vector-init-loop.33.13
;              vector-init-loop.33
;              tmp.31
;              0
;              tmp.32)))))
;     (define L.vector-init-loop.33.13
;       (lambda (c.96 len.34 i.36 vec.35)
;         (let ((vector-init-loop.33 (unsafe-procedure-ref c.96 0)))
;           (if (eq? len.34 i.36)
;             vec.35
;             (begin
;               (unsafe-vector-set! vec.35 i.36 0)
;               (call
;                L.vector-init-loop.33.13
;                vector-init-loop.33
;                len.34
;                (unsafe-fx+ i.36 1)
;                vec.35))))))
;     (define L.-.84.12
;       (lambda (c.95 tmp.49 tmp.50)
;         (let ()
;           (if (fixnum? tmp.50)
;             (if (fixnum? tmp.49) (unsafe-fx- tmp.49 tmp.50) (error 3))
;             (error 3)))))
;     (define L.+.85.11
;       (lambda (c.94 tmp.47 tmp.48)
;         (let ()
;           (if (fixnum? tmp.48)
;             (if (fixnum? tmp.47) (unsafe-fx+ tmp.47 tmp.48) (error 2))
;             (error 2)))))
;     (define L.<=.86.10
;       (lambda (c.93 tmp.53 tmp.54)
;         (let ()
;           (if (fixnum? tmp.54)
;             (if (fixnum? tmp.53) (unsafe-fx<= tmp.53 tmp.54) (error 5))
;             (error 5)))))
;     (define L.boolean?.87.9 (lambda (c.92 tmp.69) (let () (boolean? tmp.69))))
;     (define L.*.88.8
;       (lambda (c.91 tmp.45 tmp.46)
;         (let ()
;           (if (fixnum? tmp.46)
;             (if (fixnum? tmp.45) (unsafe-fx* tmp.45 tmp.46) (error 1))
;             (error 1)))))
;     (define L.>.89.7
;       (lambda (c.90 tmp.55 tmp.56)
;         (let ()
;           (if (fixnum? tmp.56)
;             (if (fixnum? tmp.55) (unsafe-fx> tmp.55 tmp.56) (error 6))
;             (error 6)))))
;     (let ((>.89 (make-procedure L.>.89.7 2 0))
;           (*.88 (make-procedure L.*.88.8 2 0))
;           (boolean?.87 (make-procedure L.boolean?.87.9 1 0))
;           (<=.86 (make-procedure L.<=.86.10 2 0))
;           (|+.85| (make-procedure L.+.85.11 2 0))
;           (|-.84| (make-procedure L.-.84.12 2 0))
;           (vector-init-loop.33 (make-procedure L.vector-init-loop.33.13 3 1))
;           (make-init-vector.1 (make-procedure L.make-init-vector.1.14 1 1))
;           (make-vector.83 (make-procedure L.make-vector.83.15 1 1))
;           (fun/ascii-char16492.4
;            (make-procedure L.fun/ascii-char16492.4.16 0 0))
;           (fun/empty16491.5 (make-procedure L.fun/empty16491.5.17 0 0))
;           (fun/vector16484.6 (make-procedure L.fun/vector16484.6.18 0 1))
;           (fun/empty16487.7 (make-procedure L.fun/empty16487.7.19 0 0))
;           (fun/any16488.8 (make-procedure L.fun/any16488.8.20 0 0))
;           (fun/empty16489.9 (make-procedure L.fun/empty16489.9.21 0 0))
;           (fun/error16485.10 (make-procedure L.fun/error16485.10.22 0 0))
;           (fun/empty16490.11 (make-procedure L.fun/empty16490.11.23 0 0))
;           (fun/error16486.12 (make-procedure L.fun/error16486.12.24 0 0)))
;       (begin
;         (unsafe-procedure-set! vector-init-loop.33 0 vector-init-loop.33)
;         (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.33)
;         (unsafe-procedure-set! make-vector.83 0 make-init-vector.1)
;         (unsafe-procedure-set! fun/vector16484.6 0 make-vector.83)
;         (if (let ((fixnum0.18
;                    (call
;                     L.-.84.12
;                     |-.84|
;                     (call L.-.84.12 |-.84| 89 200)
;                     (call L.+.85.11 |+.85| 38 241)))
;                   (vector1.17 (call L.fun/vector16484.6.18 fun/vector16484.6))
;                   (error2.16 (call L.fun/error16485.10.22 fun/error16485.10))
;                   (error3.15 (call L.fun/error16486.12.24 fun/error16486.12))
;                   (empty4.14 (call L.fun/empty16487.7.19 fun/empty16487.7))
;                   (boolean5.13
;                    (call
;                     L.<=.86.10
;                     <=.86
;                     (call L.-.84.12 |-.84| 185 172)
;                     (call L.+.85.11 |+.85| 136 173))))
;               (call
;                L.boolean?.87.9
;                boolean?.87
;                (call L.fun/any16488.8.20 fun/any16488.8)))
;           (if (if #t #f #f)
;             (let ((ascii-char0.24 #\_)
;                   (ascii-char1.23 #\A)
;                   (boolean2.22 #f)
;                   (void3.21 (void))
;                   (boolean4.20 #f)
;                   (empty5.19 empty))
;               #\U)
;             (if #t #\v #\U))
;           (let ((empty0.30 (call L.fun/empty16489.9.21 fun/empty16489.9))
;                 (fixnum1.29
;                  (call
;                   L.-.84.12
;                   |-.84|
;                   (call L.*.88.8 *.88 53 209)
;                   (call L.*.88.8 *.88 2 115)))
;                 (boolean2.28
;                  (call
;                   L.>.89.7
;                   >.89
;                   (call L.*.88.8 *.88 94 22)
;                   (call L.+.85.11 |+.85| 89 85)))
;                 (empty3.27 (call L.fun/empty16490.11.23 fun/empty16490.11))
;                 (fixnum4.26
;                  (call
;                   L.-.84.12
;                   |-.84|
;                   (call L.-.84.12 |-.84| 17 63)
;                   (call L.*.88.8 *.88 147 5)))
;                 (empty5.25 (call L.fun/empty16491.5.17 fun/empty16491.5)))
;             (call L.fun/ascii-char16492.4.16 fun/ascii-char16492.4)))))))
; (check-by-interp
;  '(module
;     (define L.fun/vector16594.17.25
;       (lambda (c.97)
;         (let ((fun/vector16595.8 (unsafe-procedure-ref c.97 0)))
;           (call L.fun/vector16595.8.16 fun/vector16595.8))))
;     (define L.fun/void16600.16.24
;       (lambda (c.96)
;         (let ((fun/void16601.9 (unsafe-procedure-ref c.96 0)))
;           (call L.fun/void16601.9.17 fun/void16601.9))))
;     (define L.fun/ascii-char16602.15.23
;       (lambda (c.95)
;         (let ((fun/ascii-char16603.5 (unsafe-procedure-ref c.95 0)))
;           (call L.fun/ascii-char16603.5.13 fun/ascii-char16603.5))))
;     (define L.fun/ascii-char16596.14.22
;       (lambda (c.94)
;         (let ((fun/ascii-char16597.10 (unsafe-procedure-ref c.94 0)))
;           (call L.fun/ascii-char16597.10.18 fun/ascii-char16597.10))))
;     (define L.fun/vector16593.13.21
;       (lambda (c.93)
;         (let ((make-vector.76 (unsafe-procedure-ref c.93 0)))
;           (call L.make-vector.76.11 make-vector.76 8))))
;     (define L.fun/any16599.12.20
;       (lambda (c.92)
;         (let ((cons.77 (unsafe-procedure-ref c.92 0)))
;           (call L.cons.77.8 cons.77 178 511))))
;     (define L.fun/vector16604.11.19
;       (lambda (c.91)
;         (let ((fun/vector16605.7 (unsafe-procedure-ref c.91 0)))
;           (call L.fun/vector16605.7.15 fun/vector16605.7))))
;     (define L.fun/ascii-char16597.10.18 (lambda (c.90) (let () #\c)))
;     (define L.fun/void16601.9.17 (lambda (c.89) (let () (void))))
;     (define L.fun/vector16595.8.16
;       (lambda (c.88)
;         (let ((make-vector.76 (unsafe-procedure-ref c.88 0)))
;           (call L.make-vector.76.11 make-vector.76 8))))
;     (define L.fun/vector16605.7.15
;       (lambda (c.87)
;         (let ((make-vector.76 (unsafe-procedure-ref c.87 0)))
;           (call L.make-vector.76.11 make-vector.76 8))))
;     (define L.fun/vector16592.6.14
;       (lambda (c.86)
;         (let ((fun/vector16593.13 (unsafe-procedure-ref c.86 0)))
;           (call L.fun/vector16593.13.21 fun/vector16593.13))))
;     (define L.fun/ascii-char16603.5.13 (lambda (c.85) (let () #\])))
;     (define L.fun/any16598.4.12
;       (lambda (c.84)
;         (let ((fun/any16599.12 (unsafe-procedure-ref c.84 0)))
;           (call L.fun/any16599.12.20 fun/any16599.12))))
;     (define L.make-vector.76.11
;       (lambda (c.83 tmp.52)
;         (let ((make-init-vector.1 (unsafe-procedure-ref c.83 0)))
;           (if (fixnum? tmp.52)
;             (call L.make-init-vector.1.10 make-init-vector.1 tmp.52)
;             (error 8)))))
;     (define L.make-init-vector.1.10
;       (lambda (c.82 tmp.24)
;         (let ((vector-init-loop.26 (unsafe-procedure-ref c.82 0)))
;           (let ((tmp.25 (unsafe-make-vector tmp.24)))
;             (call
;              L.vector-init-loop.26.9
;              vector-init-loop.26
;              tmp.24
;              0
;              tmp.25)))))
;     (define L.vector-init-loop.26.9
;       (lambda (c.81 len.27 i.29 vec.28)
;         (let ((vector-init-loop.26 (unsafe-procedure-ref c.81 0)))
;           (if (eq? len.27 i.29)
;             vec.28
;             (begin
;               (unsafe-vector-set! vec.28 i.29 0)
;               (call
;                L.vector-init-loop.26.9
;                vector-init-loop.26
;                len.27
;                (unsafe-fx+ i.29 1)
;                vec.28))))))
;     (define L.cons.77.8
;       (lambda (c.80 tmp.71 tmp.72) (let () (cons tmp.71 tmp.72))))
;     (define L.procedure?.78.7
;       (lambda (c.79 tmp.70) (let () (procedure? tmp.70))))
;     (let ((procedure?.78 (make-procedure L.procedure?.78.7 1 0))
;           (cons.77 (make-procedure L.cons.77.8 2 0))
;           (vector-init-loop.26 (make-procedure L.vector-init-loop.26.9 3 1))
;           (make-init-vector.1 (make-procedure L.make-init-vector.1.10 1 1))
;           (make-vector.76 (make-procedure L.make-vector.76.11 1 1))
;           (fun/any16598.4 (make-procedure L.fun/any16598.4.12 0 1))
;           (fun/ascii-char16603.5
;            (make-procedure L.fun/ascii-char16603.5.13 0 0))
;           (fun/vector16592.6 (make-procedure L.fun/vector16592.6.14 0 1))
;           (fun/vector16605.7 (make-procedure L.fun/vector16605.7.15 0 1))
;           (fun/vector16595.8 (make-procedure L.fun/vector16595.8.16 0 1))
;           (fun/void16601.9 (make-procedure L.fun/void16601.9.17 0 0))
;           (fun/ascii-char16597.10
;            (make-procedure L.fun/ascii-char16597.10.18 0 0))
;           (fun/vector16604.11 (make-procedure L.fun/vector16604.11.19 0 1))
;           (fun/any16599.12 (make-procedure L.fun/any16599.12.20 0 1))
;           (fun/vector16593.13 (make-procedure L.fun/vector16593.13.21 0 1))
;           (fun/ascii-char16596.14
;            (make-procedure L.fun/ascii-char16596.14.22 0 1))
;           (fun/ascii-char16602.15
;            (make-procedure L.fun/ascii-char16602.15.23 0 1))
;           (fun/void16600.16 (make-procedure L.fun/void16600.16.24 0 1))
;           (fun/vector16594.17 (make-procedure L.fun/vector16594.17.25 0 1)))
;       (begin
;         (unsafe-procedure-set! vector-init-loop.26 0 vector-init-loop.26)
;         (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.26)
;         (unsafe-procedure-set! make-vector.76 0 make-init-vector.1)
;         (unsafe-procedure-set! fun/any16598.4 0 fun/any16599.12)
;         (unsafe-procedure-set! fun/vector16592.6 0 fun/vector16593.13)
;         (unsafe-procedure-set! fun/vector16605.7 0 make-vector.76)
;         (unsafe-procedure-set! fun/vector16595.8 0 make-vector.76)
;         (unsafe-procedure-set! fun/vector16604.11 0 fun/vector16605.7)
;         (unsafe-procedure-set! fun/any16599.12 0 cons.77)
;         (unsafe-procedure-set! fun/vector16593.13 0 make-vector.76)
;         (unsafe-procedure-set! fun/ascii-char16596.14 0 fun/ascii-char16597.10)
;         (unsafe-procedure-set! fun/ascii-char16602.15 0 fun/ascii-char16603.5)
;         (unsafe-procedure-set! fun/void16600.16 0 fun/void16601.9)
;         (unsafe-procedure-set! fun/vector16594.17 0 fun/vector16595.8)
;         (let ((vector0.23 (call L.fun/vector16592.6.14 fun/vector16592.6))
;               (vector1.22 (call L.fun/vector16594.17.25 fun/vector16594.17))
;               (ascii-char2.21
;                (call L.fun/ascii-char16596.14.22 fun/ascii-char16596.14))
;               (boolean3.20
;                (call
;                 L.procedure?.78.7
;                 procedure?.78
;                 (call L.fun/any16598.4.12 fun/any16598.4)))
;               (void4.19 (call L.fun/void16600.16.24 fun/void16600.16))
;               (ascii-char5.18
;                (call L.fun/ascii-char16602.15.23 fun/ascii-char16602.15)))
;           (call L.fun/vector16604.11.19 fun/vector16604.11))))))
; (check-by-interp
;  '(module
;     (define L.lam.80.27
;       (lambda (c.101)
;         (let ((fun/empty17996.16 (unsafe-procedure-ref c.101 0)))
;           (call L.fun/empty17996.16.25 fun/empty17996.16))))
;     (define L.fun/ascii-char18009.17.26 (lambda (c.100) (let () #\G)))
;     (define L.fun/empty17996.16.25
;       (lambda (c.99)
;         (let ((fun/empty17997.10 (unsafe-procedure-ref c.99 0)))
;           (call L.fun/empty17997.10.19 fun/empty17997.10))))
;     (define L.fun/vector18000.15.24
;       (lambda (c.98)
;         (let ((fun/vector18001.4 (unsafe-procedure-ref c.98 0)))
;           (call L.fun/vector18001.4.13 fun/vector18001.4))))
;     (define L.fun/any18003.14.23
;       (lambda (c.97)
;         (let ((cons.77 (unsafe-procedure-ref c.97 0)))
;           (call L.cons.77.9 cons.77 98 287))))
;     (define L.fun/any18004.13.22
;       (lambda (c.96)
;         (let ((fun/any18005.11 (unsafe-procedure-ref c.96 0)))
;           (call L.fun/any18005.11.20 fun/any18005.11))))
;     (define L.fun/void18007.12.21 (lambda (c.95) (let () (void))))
;     (define L.fun/any18005.11.20 (lambda (c.94) (let () (error 158))))
;     (define L.fun/empty17997.10.19 (lambda (c.93) (let () empty)))
;     (define L.fun/any18002.9.18
;       (lambda (c.92)
;         (let ((fun/any18003.14 (unsafe-procedure-ref c.92 0)))
;           (call L.fun/any18003.14.23 fun/any18003.14))))
;     (define L.fun/void18006.8.17
;       (lambda (c.91)
;         (let ((fun/void18007.12 (unsafe-procedure-ref c.91 0)))
;           (call L.fun/void18007.12.21 fun/void18007.12))))
;     (define L.fun/ascii-char18008.7.16
;       (lambda (c.90)
;         (let ((fun/ascii-char18009.17 (unsafe-procedure-ref c.90 0)))
;           (call L.fun/ascii-char18009.17.26 fun/ascii-char18009.17))))
;     (define L.fun/vector17998.6.15
;       (lambda (c.89)
;         (let ((fun/vector17999.5 (unsafe-procedure-ref c.89 0)))
;           (call L.fun/vector17999.5.14 fun/vector17999.5))))
;     (define L.fun/vector17999.5.14
;       (lambda (c.88)
;         (let ((make-vector.76 (unsafe-procedure-ref c.88 0)))
;           (call L.make-vector.76.12 make-vector.76 8))))
;     (define L.fun/vector18001.4.13
;       (lambda (c.87)
;         (let ((make-vector.76 (unsafe-procedure-ref c.87 0)))
;           (call L.make-vector.76.12 make-vector.76 8))))
;     (define L.make-vector.76.12
;       (lambda (c.86 tmp.52)
;         (let ((make-init-vector.1 (unsafe-procedure-ref c.86 0)))
;           (if (fixnum? tmp.52)
;             (call L.make-init-vector.1.11 make-init-vector.1 tmp.52)
;             (error 8)))))
;     (define L.make-init-vector.1.11
;       (lambda (c.85 tmp.24)
;         (let ((vector-init-loop.26 (unsafe-procedure-ref c.85 0)))
;           (let ((tmp.25 (unsafe-make-vector tmp.24)))
;             (call
;              L.vector-init-loop.26.10
;              vector-init-loop.26
;              tmp.24
;              0
;              tmp.25)))))
;     (define L.vector-init-loop.26.10
;       (lambda (c.84 len.27 i.29 vec.28)
;         (let ((vector-init-loop.26 (unsafe-procedure-ref c.84 0)))
;           (if (eq? len.27 i.29)
;             vec.28
;             (begin
;               (unsafe-vector-set! vec.28 i.29 0)
;               (call
;                L.vector-init-loop.26.10
;                vector-init-loop.26
;                len.27
;                (unsafe-fx+ i.29 1)
;                vec.28))))))
;     (define L.cons.77.9
;       (lambda (c.83 tmp.71 tmp.72) (let () (cons tmp.71 tmp.72))))
;     (define L.vector?.78.8 (lambda (c.82 tmp.68) (let () (vector? tmp.68))))
;     (define L.void?.79.7 (lambda (c.81 tmp.64) (let () (void? tmp.64))))
;     (let ((void?.79 (make-procedure L.void?.79.7 1 0))
;           (vector?.78 (make-procedure L.vector?.78.8 1 0))
;           (cons.77 (make-procedure L.cons.77.9 2 0))
;           (vector-init-loop.26 (make-procedure L.vector-init-loop.26.10 3 1))
;           (make-init-vector.1 (make-procedure L.make-init-vector.1.11 1 1))
;           (make-vector.76 (make-procedure L.make-vector.76.12 1 1))
;           (fun/vector18001.4 (make-procedure L.fun/vector18001.4.13 0 1))
;           (fun/vector17999.5 (make-procedure L.fun/vector17999.5.14 0 1))
;           (fun/vector17998.6 (make-procedure L.fun/vector17998.6.15 0 1))
;           (fun/ascii-char18008.7
;            (make-procedure L.fun/ascii-char18008.7.16 0 1))
;           (fun/void18006.8 (make-procedure L.fun/void18006.8.17 0 1))
;           (fun/any18002.9 (make-procedure L.fun/any18002.9.18 0 1))
;           (fun/empty17997.10 (make-procedure L.fun/empty17997.10.19 0 0))
;           (fun/any18005.11 (make-procedure L.fun/any18005.11.20 0 0))
;           (fun/void18007.12 (make-procedure L.fun/void18007.12.21 0 0))
;           (fun/any18004.13 (make-procedure L.fun/any18004.13.22 0 1))
;           (fun/any18003.14 (make-procedure L.fun/any18003.14.23 0 1))
;           (fun/vector18000.15 (make-procedure L.fun/vector18000.15.24 0 1))
;           (fun/empty17996.16 (make-procedure L.fun/empty17996.16.25 0 1))
;           (fun/ascii-char18009.17
;            (make-procedure L.fun/ascii-char18009.17.26 0 0)))
;       (begin
;         (unsafe-procedure-set! vector-init-loop.26 0 vector-init-loop.26)
;         (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.26)
;         (unsafe-procedure-set! make-vector.76 0 make-init-vector.1)
;         (unsafe-procedure-set! fun/vector18001.4 0 make-vector.76)
;         (unsafe-procedure-set! fun/vector17999.5 0 make-vector.76)
;         (unsafe-procedure-set! fun/vector17998.6 0 fun/vector17999.5)
;         (unsafe-procedure-set! fun/ascii-char18008.7 0 fun/ascii-char18009.17)
;         (unsafe-procedure-set! fun/void18006.8 0 fun/void18007.12)
;         (unsafe-procedure-set! fun/any18002.9 0 fun/any18003.14)
;         (unsafe-procedure-set! fun/any18004.13 0 fun/any18005.11)
;         (unsafe-procedure-set! fun/any18003.14 0 cons.77)
;         (unsafe-procedure-set! fun/vector18000.15 0 fun/vector18001.4)
;         (unsafe-procedure-set! fun/empty17996.16 0 fun/empty17997.10)
;         (let ((procedure0.23
;                (let ((lam.80 (make-procedure L.lam.80.27 0 1)))
;                  (begin
;                    (unsafe-procedure-set! lam.80 0 fun/empty17996.16)
;                    lam.80)))
;               (vector1.22 (call L.fun/vector17998.6.15 fun/vector17998.6))
;               (vector2.21 (call L.fun/vector18000.15.24 fun/vector18000.15))
;               (boolean3.20
;                (call
;                 L.vector?.78.8
;                 vector?.78
;                 (call L.fun/any18002.9.18 fun/any18002.9)))
;               (boolean4.19
;                (call
;                 L.void?.79.7
;                 void?.79
;                 (call L.fun/any18004.13.22 fun/any18004.13)))
;               (void5.18 (call L.fun/void18006.8.17 fun/void18006.8)))
;           (call L.fun/ascii-char18008.7.16 fun/ascii-char18008.7))))))
; (check-by-interp
;  '(module
;     (define L.fun/void18495.15.21 (lambda (c.91) (let () (void))))
;     (define L.fun/void18488.14.20
;       (lambda (c.90)
;         (let ((fun/void18489.10 (unsafe-procedure-ref c.90 0)))
;           (call L.fun/void18489.10.16 fun/void18489.10))))
;     (define L.fun/ascii-char18493.13.19 (lambda (c.89) (let () #\Q)))
;     (define L.fun/error18496.12.18
;       (lambda (c.88)
;         (let ((fun/error18497.6 (unsafe-procedure-ref c.88 0)))
;           (call L.fun/error18497.6.12 fun/error18497.6))))
;     (define L.fun/empty18498.11.17
;       (lambda (c.87)
;         (let ((fun/empty18499.5 (unsafe-procedure-ref c.87 0)))
;           (call L.fun/empty18499.5.11 fun/empty18499.5))))
;     (define L.fun/void18489.10.16 (lambda (c.86) (let () (void))))
;     (define L.fun/void18494.9.15
;       (lambda (c.85)
;         (let ((fun/void18495.15 (unsafe-procedure-ref c.85 0)))
;           (call L.fun/void18495.15.21 fun/void18495.15))))
;     (define L.fun/error18491.8.14 (lambda (c.84) (let () (error 186))))
;     (define L.fun/ascii-char18492.7.13
;       (lambda (c.83)
;         (let ((fun/ascii-char18493.13 (unsafe-procedure-ref c.83 0)))
;           (call L.fun/ascii-char18493.13.19 fun/ascii-char18493.13))))
;     (define L.fun/error18497.6.12 (lambda (c.82) (let () (error 98))))
;     (define L.fun/empty18499.5.11 (lambda (c.81) (let () empty)))
;     (define L.fun/error18490.4.10
;       (lambda (c.80)
;         (let ((fun/error18491.8 (unsafe-procedure-ref c.80 0)))
;           (call L.fun/error18491.8.14 fun/error18491.8))))
;     (define L.*.74.9
;       (lambda (c.79 tmp.36 tmp.37)
;         (let ()
;           (if (fixnum? tmp.37)
;             (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
;             (error 1)))))
;     (define L.-.75.8
;       (lambda (c.78 tmp.40 tmp.41)
;         (let ()
;           (if (fixnum? tmp.41)
;             (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
;             (error 3)))))
;     (define L.+.76.7
;       (lambda (c.77 tmp.38 tmp.39)
;         (let ()
;           (if (fixnum? tmp.39)
;             (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
;             (error 2)))))
;     (let ((|+.76| (make-procedure L.+.76.7 2 0))
;           (|-.75| (make-procedure L.-.75.8 2 0))
;           (*.74 (make-procedure L.*.74.9 2 0))
;           (fun/error18490.4 (make-procedure L.fun/error18490.4.10 0 1))
;           (fun/empty18499.5 (make-procedure L.fun/empty18499.5.11 0 0))
;           (fun/error18497.6 (make-procedure L.fun/error18497.6.12 0 0))
;           (fun/ascii-char18492.7
;            (make-procedure L.fun/ascii-char18492.7.13 0 1))
;           (fun/error18491.8 (make-procedure L.fun/error18491.8.14 0 0))
;           (fun/void18494.9 (make-procedure L.fun/void18494.9.15 0 1))
;           (fun/void18489.10 (make-procedure L.fun/void18489.10.16 0 0))
;           (fun/empty18498.11 (make-procedure L.fun/empty18498.11.17 0 1))
;           (fun/error18496.12 (make-procedure L.fun/error18496.12.18 0 1))
;           (fun/ascii-char18493.13
;            (make-procedure L.fun/ascii-char18493.13.19 0 0))
;           (fun/void18488.14 (make-procedure L.fun/void18488.14.20 0 1))
;           (fun/void18495.15 (make-procedure L.fun/void18495.15.21 0 0)))
;       (begin
;         (unsafe-procedure-set! fun/error18490.4 0 fun/error18491.8)
;         (unsafe-procedure-set! fun/ascii-char18492.7 0 fun/ascii-char18493.13)
;         (unsafe-procedure-set! fun/void18494.9 0 fun/void18495.15)
;         (unsafe-procedure-set! fun/empty18498.11 0 fun/empty18499.5)
;         (unsafe-procedure-set! fun/error18496.12 0 fun/error18497.6)
;         (unsafe-procedure-set! fun/void18488.14 0 fun/void18489.10)
;         (let ((void0.21 (call L.fun/void18488.14.20 fun/void18488.14))
;               (error1.20 (call L.fun/error18490.4.10 fun/error18490.4))
;               (fixnum2.19
;                (call
;                 L.*.74.9
;                 *.74
;                 (call
;                  L.-.75.8
;                  |-.75|
;                  (call
;                   L.*.74.9
;                   *.74
;                   (call L.*.74.9 *.74 88 125)
;                   (call L.-.75.8 |-.75| 220 155))
;                  (call
;                   L.-.75.8
;                   |-.75|
;                   (call L.-.75.8 |-.75| 144 224)
;                   (call L.*.74.9 *.74 186 124)))
;                 (call
;                  L.-.75.8
;                  |-.75|
;                  (call
;                   L.-.75.8
;                   |-.75|
;                   (call L.-.75.8 |-.75| 97 190)
;                   (call L.*.74.9 *.74 211 147))
;                  (call
;                   L.+.76.7
;                   |+.76|
;                   (call L.*.74.9 *.74 175 153)
;                   (call L.*.74.9 *.74 126 159)))))
;               (ascii-char3.18
;                (call L.fun/ascii-char18492.7.13 fun/ascii-char18492.7))
;               (void4.17 (call L.fun/void18494.9.15 fun/void18494.9))
;               (error5.16 (call L.fun/error18496.12.18 fun/error18496.12)))
;           (call L.fun/empty18498.11.17 fun/empty18498.11))))))
; (check-by-interp
;  '(module
;     (define L.fun/ascii-char22594.17.21
;       (lambda (c.91)
;         (let ((fun/ascii-char22595.5 (unsafe-procedure-ref c.91 0)))
;           (call L.fun/ascii-char22595.5.9 fun/ascii-char22595.5))))
;     (define L.fun/empty22596.16.20
;       (lambda (c.90)
;         (let ((fun/empty22597.10 (unsafe-procedure-ref c.90 0)))
;           (call L.fun/empty22597.10.14 fun/empty22597.10))))
;     (define L.fun/empty22598.15.19
;       (lambda (c.89)
;         (let ((fun/empty22599.8 (unsafe-procedure-ref c.89 0)))
;           (call L.fun/empty22599.8.12 fun/empty22599.8))))
;     (define L.fun/error22592.14.18
;       (lambda (c.88)
;         (let ((fun/error22593.12 (unsafe-procedure-ref c.88 0)))
;           (call L.fun/error22593.12.16 fun/error22593.12))))
;     (define L.fun/pair22600.13.17
;       (lambda (c.87)
;         (let ((fun/pair22601.6 (unsafe-procedure-ref c.87 0)))
;           (call L.fun/pair22601.6.10 fun/pair22601.6))))
;     (define L.fun/error22593.12.16 (lambda (c.86) (let () (error 22))))
;     (define L.fun/ascii-char22588.11.15
;       (lambda (c.85)
;         (let ((fun/ascii-char22589.7 (unsafe-procedure-ref c.85 0)))
;           (call L.fun/ascii-char22589.7.11 fun/ascii-char22589.7))))
;     (define L.fun/empty22597.10.14 (lambda (c.84) (let () empty)))
;     (define L.fun/empty22591.9.13 (lambda (c.83) (let () empty)))
;     (define L.fun/empty22599.8.12 (lambda (c.82) (let () empty)))
;     (define L.fun/ascii-char22589.7.11 (lambda (c.81) (let () #\[)))
;     (define L.fun/pair22601.6.10
;       (lambda (c.80)
;         (let ((cons.76 (unsafe-procedure-ref c.80 0)))
;           (call L.cons.76.7 cons.76 100 463))))
;     (define L.fun/ascii-char22595.5.9 (lambda (c.79) (let () #\b)))
;     (define L.fun/empty22590.4.8
;       (lambda (c.78)
;         (let ((fun/empty22591.9 (unsafe-procedure-ref c.78 0)))
;           (call L.fun/empty22591.9.13 fun/empty22591.9))))
;     (define L.cons.76.7
;       (lambda (c.77 tmp.71 tmp.72) (let () (cons tmp.71 tmp.72))))
;     (let ((cons.76 (make-procedure L.cons.76.7 2 0))
;           (fun/empty22590.4 (make-procedure L.fun/empty22590.4.8 0 1))
;           (fun/ascii-char22595.5
;            (make-procedure L.fun/ascii-char22595.5.9 0 0))
;           (fun/pair22601.6 (make-procedure L.fun/pair22601.6.10 0 1))
;           (fun/ascii-char22589.7
;            (make-procedure L.fun/ascii-char22589.7.11 0 0))
;           (fun/empty22599.8 (make-procedure L.fun/empty22599.8.12 0 0))
;           (fun/empty22591.9 (make-procedure L.fun/empty22591.9.13 0 0))
;           (fun/empty22597.10 (make-procedure L.fun/empty22597.10.14 0 0))
;           (fun/ascii-char22588.11
;            (make-procedure L.fun/ascii-char22588.11.15 0 1))
;           (fun/error22593.12 (make-procedure L.fun/error22593.12.16 0 0))
;           (fun/pair22600.13 (make-procedure L.fun/pair22600.13.17 0 1))
;           (fun/error22592.14 (make-procedure L.fun/error22592.14.18 0 1))
;           (fun/empty22598.15 (make-procedure L.fun/empty22598.15.19 0 1))
;           (fun/empty22596.16 (make-procedure L.fun/empty22596.16.20 0 1))
;           (fun/ascii-char22594.17
;            (make-procedure L.fun/ascii-char22594.17.21 0 1)))
;       (begin
;         (unsafe-procedure-set! fun/empty22590.4 0 fun/empty22591.9)
;         (unsafe-procedure-set! fun/pair22601.6 0 cons.76)
;         (unsafe-procedure-set! fun/ascii-char22588.11 0 fun/ascii-char22589.7)
;         (unsafe-procedure-set! fun/pair22600.13 0 fun/pair22601.6)
;         (unsafe-procedure-set! fun/error22592.14 0 fun/error22593.12)
;         (unsafe-procedure-set! fun/empty22598.15 0 fun/empty22599.8)
;         (unsafe-procedure-set! fun/empty22596.16 0 fun/empty22597.10)
;         (unsafe-procedure-set! fun/ascii-char22594.17 0 fun/ascii-char22595.5)
;         (let ((ascii-char0.23
;                (call L.fun/ascii-char22588.11.15 fun/ascii-char22588.11))
;               (empty1.22 (call L.fun/empty22590.4.8 fun/empty22590.4))
;               (error2.21 (call L.fun/error22592.14.18 fun/error22592.14))
;               (ascii-char3.20
;                (call L.fun/ascii-char22594.17.21 fun/ascii-char22594.17))
;               (empty4.19 (call L.fun/empty22596.16.20 fun/empty22596.16))
;               (empty5.18 (call L.fun/empty22598.15.19 fun/empty22598.15)))
;           (call L.fun/pair22600.13.17 fun/pair22600.13))))))
; (check-by-interp
;  '(module
;     (define L.lam.76.21
;       (lambda (c.91)
;         (let ((fun/void23352.11 (unsafe-procedure-ref c.91 0)))
;           (call L.fun/void23352.11.19 fun/void23352.11))))
;     (define L.lam.75.20
;       (lambda (c.90)
;         (let ((*.74 (unsafe-procedure-ref c.90 0))
;               (|-.72| (unsafe-procedure-ref c.90 1))
;               (|+.73| (unsafe-procedure-ref c.90 2)))
;           (call
;            L.+.73.8
;            |+.73|
;            (call
;             L.+.73.8
;             |+.73|
;             (call
;              L.+.73.8
;              |+.73|
;              (call L.-.72.9 |-.72| 239 118)
;              (call L.-.72.9 |-.72| 38 153))
;             (call
;              L.+.73.8
;              |+.73|
;              (call L.*.74.7 *.74 128 179)
;              (call L.-.72.9 |-.72| 208 217)))
;            (call
;             L.-.72.9
;             |-.72|
;             (call
;              L.+.73.8
;              |+.73|
;              (call L.-.72.9 |-.72| 121 152)
;              (call L.*.74.7 *.74 212 8))
;             (call
;              L.*.74.7
;              *.74
;              (call L.*.74.7 *.74 175 82)
;              (call L.-.72.9 |-.72| 52 179)))))))
;     (define L.fun/void23352.11.19
;       (lambda (c.89)
;         (let ((fun/void23353.10 (unsafe-procedure-ref c.89 0)))
;           (call L.fun/void23353.10.18 fun/void23353.10))))
;     (define L.fun/void23353.10.18 (lambda (c.88) (let () (void))))
;     (define L.fun/ascii-char23346.9.17
;       (lambda (c.87)
;         (let ((fun/ascii-char23347.8 (unsafe-procedure-ref c.87 0)))
;           (call L.fun/ascii-char23347.8.16 fun/ascii-char23347.8))))
;     (define L.fun/ascii-char23347.8.16 (lambda (c.86) (let () #\\)))
;     (define L.fun/any23350.7.15
;       (lambda (c.85)
;         (let ((fun/any23351.5 (unsafe-procedure-ref c.85 0)))
;           (call L.fun/any23351.5.13 fun/any23351.5))))
;     (define L.fun/void23348.6.14
;       (lambda (c.84)
;         (let ((fun/void23349.4 (unsafe-procedure-ref c.84 0)))
;           (call L.fun/void23349.4.12 fun/void23349.4))))
;     (define L.fun/any23351.5.13
;       (lambda (c.83)
;         (let ((cons.70 (unsafe-procedure-ref c.83 0)))
;           (call L.cons.70.11 cons.70 159 398))))
;     (define L.fun/void23349.4.12 (lambda (c.82) (let () (void))))
;     (define L.cons.70.11
;       (lambda (c.81 tmp.65 tmp.66) (let () (cons tmp.65 tmp.66))))
;     (define L.boolean?.71.10 (lambda (c.80 tmp.56) (let () (boolean? tmp.56))))
;     (define L.-.72.9
;       (lambda (c.79 tmp.36 tmp.37)
;         (let ()
;           (if (fixnum? tmp.37)
;             (if (fixnum? tmp.36) (unsafe-fx- tmp.36 tmp.37) (error 3))
;             (error 3)))))
;     (define L.+.73.8
;       (lambda (c.78 tmp.34 tmp.35)
;         (let ()
;           (if (fixnum? tmp.35)
;             (if (fixnum? tmp.34) (unsafe-fx+ tmp.34 tmp.35) (error 2))
;             (error 2)))))
;     (define L.*.74.7
;       (lambda (c.77 tmp.32 tmp.33)
;         (let ()
;           (if (fixnum? tmp.33)
;             (if (fixnum? tmp.32) (unsafe-fx* tmp.32 tmp.33) (error 1))
;             (error 1)))))
;     (let ((*.74 (make-procedure L.*.74.7 2 0))
;           (|+.73| (make-procedure L.+.73.8 2 0))
;           (|-.72| (make-procedure L.-.72.9 2 0))
;           (boolean?.71 (make-procedure L.boolean?.71.10 1 0))
;           (cons.70 (make-procedure L.cons.70.11 2 0))
;           (fun/void23349.4 (make-procedure L.fun/void23349.4.12 0 0))
;           (fun/any23351.5 (make-procedure L.fun/any23351.5.13 0 1))
;           (fun/void23348.6 (make-procedure L.fun/void23348.6.14 0 1))
;           (fun/any23350.7 (make-procedure L.fun/any23350.7.15 0 1))
;           (fun/ascii-char23347.8
;            (make-procedure L.fun/ascii-char23347.8.16 0 0))
;           (fun/ascii-char23346.9
;            (make-procedure L.fun/ascii-char23346.9.17 0 1))
;           (fun/void23353.10 (make-procedure L.fun/void23353.10.18 0 0))
;           (fun/void23352.11 (make-procedure L.fun/void23352.11.19 0 1)))
;       (begin
;         (unsafe-procedure-set! fun/any23351.5 0 cons.70)
;         (unsafe-procedure-set! fun/void23348.6 0 fun/void23349.4)
;         (unsafe-procedure-set! fun/any23350.7 0 fun/any23351.5)
;         (unsafe-procedure-set! fun/ascii-char23346.9 0 fun/ascii-char23347.8)
;         (unsafe-procedure-set! fun/void23352.11 0 fun/void23353.10)
;         (let ((ascii-char0.17
;                (call L.fun/ascii-char23346.9.17 fun/ascii-char23346.9))
;               (void1.16 (call L.fun/void23348.6.14 fun/void23348.6))
;               (boolean2.15
;                (call
;                 L.boolean?.71.10
;                 boolean?.71
;                 (call L.fun/any23350.7.15 fun/any23350.7)))
;               (procedure3.14
;                (let ((lam.75 (make-procedure L.lam.75.20 0 3)))
;                  (begin
;                    (unsafe-procedure-set! lam.75 0 *.74)
;                    (unsafe-procedure-set! lam.75 1 |-.72|)
;                    (unsafe-procedure-set! lam.75 2 |+.73|)
;                    lam.75)))
;               (fixnum4.13
;                (call
;                 L.*.74.7
;                 *.74
;                 (call
;                  L.-.72.9
;                  |-.72|
;                  (call
;                   L.*.74.7
;                   *.74
;                   (call L.-.72.9 |-.72| 100 80)
;                   (call L.+.73.8 |+.73| 40 93))
;                  (call
;                   L.+.73.8
;                   |+.73|
;                   (call L.-.72.9 |-.72| 163 92)
;                   (call L.-.72.9 |-.72| 230 103)))
;                 (call
;                  L.-.72.9
;                  |-.72|
;                  (call
;                   L.-.72.9
;                   |-.72|
;                   (call L.-.72.9 |-.72| 47 61)
;                   (call L.-.72.9 |-.72| 139 24))
;                  (call
;                   L.+.73.8
;                   |+.73|
;                   (call L.*.74.7 *.74 103 132)
;                   (call L.+.73.8 |+.73| 140 95)))))
;               (procedure5.12
;                (let ((lam.76 (make-procedure L.lam.76.21 0 1)))
;                  (begin
;                    (unsafe-procedure-set! lam.76 0 fun/void23352.11)
;                    lam.76))))
;           (call
;            L.-.72.9
;            |-.72|
;            (call
;             L.*.74.7
;             *.74
;             (if (procedure? procedure3.14)
;               (if (eq? (unsafe-procedure-arity procedure3.14) 0)
;                 (call (unsafe-procedure-label procedure3.14) procedure3.14)
;                 (error 42))
;               (error 43))
;             (if (procedure? procedure3.14)
;               (if (eq? (unsafe-procedure-arity procedure3.14) 0)
;                 (call (unsafe-procedure-label procedure3.14) procedure3.14)
;                 (error 42))
;               (error 43)))
;            (call
;             L.+.73.8
;             |+.73|
;             (call
;              L.*.74.7
;              *.74
;              (call L.*.74.7 *.74 105 226)
;              (call L.+.73.8 |+.73| 43 81))
;             (call
;              L.+.73.8
;              |+.73|
;              (call L.*.74.7 *.74 245 145)
;              (call L.*.74.7 *.74 109 196)))))))))
; (check-by-interp
;  '(module
;     (define L.lam.80.27
;       (lambda (c.101)
;         (let ((fun/void24631.10 (unsafe-procedure-ref c.101 0)))
;           (call L.fun/void24631.10.20 fun/void24631.10))))
;     (define L.lam.79.26
;       (lambda (c.100)
;         (let ((fun/empty24629.7 (unsafe-procedure-ref c.100 0)))
;           (call L.fun/empty24629.7.17 fun/empty24629.7))))
;     (define L.fun/vector24626.15.25
;       (lambda (c.99)
;         (let ((make-vector.74 (unsafe-procedure-ref c.99 0)))
;           (call L.make-vector.74.13 make-vector.74 8))))
;     (define L.fun/any24627.14.24
;       (lambda (c.98)
;         (let ((fun/any24628.5 (unsafe-procedure-ref c.98 0)))
;           (call L.fun/any24628.5.15 fun/any24628.5))))
;     (define L.fun/error24635.13.23
;       (lambda (c.97)
;         (let ((fun/error24636.8 (unsafe-procedure-ref c.97 0)))
;           (call L.fun/error24636.8.18 fun/error24636.8))))
;     (define L.fun/error24634.12.22 (lambda (c.96) (let () (error 74))))
;     (define L.fun/empty24630.11.21 (lambda (c.95) (let () empty)))
;     (define L.fun/void24631.10.20
;       (lambda (c.94)
;         (let ((fun/void24632.9 (unsafe-procedure-ref c.94 0)))
;           (call L.fun/void24632.9.19 fun/void24632.9))))
;     (define L.fun/void24632.9.19 (lambda (c.93) (let () (void))))
;     (define L.fun/error24636.8.18 (lambda (c.92) (let () (error 205))))
;     (define L.fun/empty24629.7.17
;       (lambda (c.91)
;         (let ((fun/empty24630.11 (unsafe-procedure-ref c.91 0)))
;           (call L.fun/empty24630.11.21 fun/empty24630.11))))
;     (define L.fun/error24633.6.16
;       (lambda (c.90)
;         (let ((fun/error24634.12 (unsafe-procedure-ref c.90 0)))
;           (call L.fun/error24634.12.22 fun/error24634.12))))
;     (define L.fun/any24628.5.15 (lambda (c.89) (let () empty)))
;     (define L.fun/vector24625.4.14
;       (lambda (c.88)
;         (let ((fun/vector24626.15 (unsafe-procedure-ref c.88 0)))
;           (call L.fun/vector24626.15.25 fun/vector24626.15))))
;     (define L.make-vector.74.13
;       (lambda (c.87 tmp.50)
;         (let ((make-init-vector.1 (unsafe-procedure-ref c.87 0)))
;           (if (fixnum? tmp.50)
;             (call L.make-init-vector.1.12 make-init-vector.1 tmp.50)
;             (error 8)))))
;     (define L.make-init-vector.1.12
;       (lambda (c.86 tmp.22)
;         (let ((vector-init-loop.24 (unsafe-procedure-ref c.86 0)))
;           (let ((tmp.23 (unsafe-make-vector tmp.22)))
;             (call
;              L.vector-init-loop.24.11
;              vector-init-loop.24
;              tmp.22
;              0
;              tmp.23)))))
;     (define L.vector-init-loop.24.11
;       (lambda (c.85 len.25 i.27 vec.26)
;         (let ((vector-init-loop.24 (unsafe-procedure-ref c.85 0)))
;           (if (eq? len.25 i.27)
;             vec.26
;             (begin
;               (unsafe-vector-set! vec.26 i.27 0)
;               (call
;                L.vector-init-loop.24.11
;                vector-init-loop.24
;                len.25
;                (unsafe-fx+ i.27 1)
;                vec.26))))))
;     (define L.*.75.10
;       (lambda (c.84 tmp.36 tmp.37)
;         (let ()
;           (if (fixnum? tmp.37)
;             (if (fixnum? tmp.36) (unsafe-fx* tmp.36 tmp.37) (error 1))
;             (error 1)))))
;     (define L.+.76.9
;       (lambda (c.83 tmp.38 tmp.39)
;         (let ()
;           (if (fixnum? tmp.39)
;             (if (fixnum? tmp.38) (unsafe-fx+ tmp.38 tmp.39) (error 2))
;             (error 2)))))
;     (define L.-.77.8
;       (lambda (c.82 tmp.40 tmp.41)
;         (let ()
;           (if (fixnum? tmp.41)
;             (if (fixnum? tmp.40) (unsafe-fx- tmp.40 tmp.41) (error 3))
;             (error 3)))))
;     (define L.empty?.78.7 (lambda (c.81 tmp.61) (let () (empty? tmp.61))))
;     (let ((empty?.78 (make-procedure L.empty?.78.7 1 0))
;           (|-.77| (make-procedure L.-.77.8 2 0))
;           (|+.76| (make-procedure L.+.76.9 2 0))
;           (*.75 (make-procedure L.*.75.10 2 0))
;           (vector-init-loop.24 (make-procedure L.vector-init-loop.24.11 3 1))
;           (make-init-vector.1 (make-procedure L.make-init-vector.1.12 1 1))
;           (make-vector.74 (make-procedure L.make-vector.74.13 1 1))
;           (fun/vector24625.4 (make-procedure L.fun/vector24625.4.14 0 1))
;           (fun/any24628.5 (make-procedure L.fun/any24628.5.15 0 0))
;           (fun/error24633.6 (make-procedure L.fun/error24633.6.16 0 1))
;           (fun/empty24629.7 (make-procedure L.fun/empty24629.7.17 0 1))
;           (fun/error24636.8 (make-procedure L.fun/error24636.8.18 0 0))
;           (fun/void24632.9 (make-procedure L.fun/void24632.9.19 0 0))
;           (fun/void24631.10 (make-procedure L.fun/void24631.10.20 0 1))
;           (fun/empty24630.11 (make-procedure L.fun/empty24630.11.21 0 0))
;           (fun/error24634.12 (make-procedure L.fun/error24634.12.22 0 0))
;           (fun/error24635.13 (make-procedure L.fun/error24635.13.23 0 1))
;           (fun/any24627.14 (make-procedure L.fun/any24627.14.24 0 1))
;           (fun/vector24626.15 (make-procedure L.fun/vector24626.15.25 0 1)))
;       (begin
;         (unsafe-procedure-set! vector-init-loop.24 0 vector-init-loop.24)
;         (unsafe-procedure-set! make-init-vector.1 0 vector-init-loop.24)
;         (unsafe-procedure-set! make-vector.74 0 make-init-vector.1)
;         (unsafe-procedure-set! fun/vector24625.4 0 fun/vector24626.15)
;         (unsafe-procedure-set! fun/error24633.6 0 fun/error24634.12)
;         (unsafe-procedure-set! fun/empty24629.7 0 fun/empty24630.11)
;         (unsafe-procedure-set! fun/void24631.10 0 fun/void24632.9)
;         (unsafe-procedure-set! fun/error24635.13 0 fun/error24636.8)
;         (unsafe-procedure-set! fun/any24627.14 0 fun/any24628.5)
;         (unsafe-procedure-set! fun/vector24626.15 0 make-vector.74)
;         (let ((fixnum0.21
;                (call
;                 L.-.77.8
;                 |-.77|
;                 (call
;                  L.*.75.10
;                  *.75
;                  (call
;                   L.+.76.9
;                   |+.76|
;                   (call L.*.75.10 *.75 148 145)
;                   (call L.*.75.10 *.75 226 44))
;                  (call
;                   L.*.75.10
;                   *.75
;                   (call L.+.76.9 |+.76| 65 170)
;                   (call L.-.77.8 |-.77| 129 146)))
;                 (call
;                  L.+.76.9
;                  |+.76|
;                  (call
;                   L.+.76.9
;                   |+.76|
;                   (call L.+.76.9 |+.76| 24 189)
;                   (call L.-.77.8 |-.77| 110 80))
;                  (call
;                   L.+.76.9
;                   |+.76|
;                   (call L.-.77.8 |-.77| 191 251)
;                   (call L.-.77.8 |-.77| 78 207)))))
;               (vector1.20 (call L.fun/vector24625.4.14 fun/vector24625.4))
;               (boolean2.19
;                (call
;                 L.empty?.78.7
;                 empty?.78
;                 (call L.fun/any24627.14.24 fun/any24627.14)))
;               (procedure3.18
;                (let ((lam.79 (make-procedure L.lam.79.26 0 1)))
;                  (begin
;                    (unsafe-procedure-set! lam.79 0 fun/empty24629.7)
;                    lam.79)))
;               (procedure4.17
;                (let ((lam.80 (make-procedure L.lam.80.27 0 1)))
;                  (begin
;                    (unsafe-procedure-set! lam.80 0 fun/void24631.10)
;                    lam.80)))
;               (error5.16 (call L.fun/error24633.6.16 fun/error24633.6)))
;           (call L.fun/error24635.13.23 fun/error24635.13))))))
