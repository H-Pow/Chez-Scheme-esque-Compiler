#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         cpsc411/langs/v9
         cpsc411/langs/v11
         "../impose-calling-conventions.rkt")
(define (fail-if-invalid p)
  (when (not (imp-cmf-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "imp-cmf-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-proc-imp-cmf-lang-v8 p)
  (interp-imp-cmf-lang-v8 (fail-if-invalid (impose-calling-conventions p)))))

(check-by-interp '(module 22))
(check-by-interp '(module 61502))
(check-by-interp '(module 22))
(check-by-interp '(module 30766))
(check-by-interp '(module (if (!= 22 6) 22 6)))
(check-by-interp '(module (begin 1696)))
(check-by-interp
 '(module
    (define L.fun/fixnum8485.7.10 (lambda (c.60) (begin 480)))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/fixnum8485.7.10)
          (mset! tmp.61 6 0)
          (set! fun/fixnum8485.7 tmp.61)))
      (call L.fun/fixnum8485.7.10 fun/fixnum8485.7))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8488.7.10 (lambda (c.60) (begin 16686)))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/ascii-char8488.7.10)
          (mset! tmp.61 6 0)
          (set! fun/ascii-char8488.7 tmp.61)))
      (call L.fun/ascii-char8488.7.10 fun/ascii-char8488.7))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8491.7.10 (lambda (c.60) (begin 23086)))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/ascii-char8491.7.10)
          (mset! tmp.61 6 0)
          (set! fun/ascii-char8491.7 tmp.61)))
      (call L.fun/ascii-char8491.7.10 fun/ascii-char8491.7))))
(check-by-interp
 '(module
    (begin
      (set! tmp.7.12 26670)
      (if (!= tmp.7.12 6)
        tmp.7.12
        (begin
          (set! tmp.8.13 27694)
          (if (!= tmp.8.13 6)
            tmp.8.13
            (begin
              (set! tmp.9.14 19246)
              (if (!= tmp.9.14 6)
                tmp.9.14
                (begin
                  (set! tmp.10.15 26926)
                  (if (!= tmp.10.15 6)
                    tmp.10.15
                    (begin
                      (set! tmp.11.16 27950)
                      (if (!= tmp.11.16 6) tmp.11.16 31022))))))))))))
(check-by-interp '(module (if (!= 14 6) 1752 808)))
(check-by-interp
 '(module
    (define L.fun/empty8500.7.10 (lambda (c.60) (begin 22)))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/empty8500.7.10)
          (mset! tmp.61 6 0)
          (set! fun/empty8500.7 tmp.61)))
      (call L.fun/empty8500.7.10 fun/empty8500.7))))
(check-by-interp
 '(module
    (if (begin (!= 22 6))
      (if (if (!= 22 6)
            (if (!= 22 6)
              (if (!= 22 6)
                (if (!= 22 6) (if (!= 22 6) (!= 22 6) (!= 6 6)) (!= 6 6))
                (!= 6 6))
              (!= 6 6))
            (!= 6 6))
        (if (!= 14 6) 22 22)
        6)
      6)))
(check-by-interp
 '(module
    (define L.fun/void8513.9.17 (lambda (c.91) (begin 30)))
    (define L.fun/void8514.8.16 (lambda (c.90) (begin 30)))
    (define L.error?.81.15
      (lambda (c.89 tmp.71)
        (begin
          (if (begin (set! tmp.101 (bitwise-and tmp.71 255)) (= tmp.101 62))
            14
            6))))
    (define L.make-vector.82.14
      (lambda (c.88 tmp.57)
        (begin
          (set! make-init-vector.4 (mref c.88 14))
          (if (begin
                (if (begin (set! tmp.103 (bitwise-and tmp.57 7)) (= tmp.103 0))
                  (set! tmp.102 14)
                  (set! tmp.102 6))
                (!= tmp.102 6))
            (call L.make-init-vector.4.13 make-init-vector.4 tmp.57)
            2110))))
    (define L.make-init-vector.4.13
      (lambda (c.87 tmp.29)
        (begin
          (set! vector-init-loop.31 (mref c.87 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.107 (arithmetic-shift-right tmp.29 3))
                      (set! tmp.106 (+ 1 tmp.107)))
                    (set! tmp.105 (* tmp.106 8)))
                  (set! tmp.104 (alloc tmp.105)))
                (set! tmp.92 (+ tmp.104 3)))
              (begin (mset! tmp.92 -3 tmp.29) (set! tmp.30 tmp.92)))
            (call
             L.vector-init-loop.31.12
             vector-init-loop.31
             tmp.29
             0
             tmp.30)))))
    (define L.vector-init-loop.31.12
      (lambda (c.86 len.32 i.34 vec.33)
        (begin
          (set! vector-init-loop.31 (mref c.86 14))
          (if (begin
                (if (= len.32 i.34) (set! tmp.108 14) (set! tmp.108 6))
                (!= tmp.108 6))
            vec.33
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.111 (arithmetic-shift-right i.34 3))
                    (set! tmp.110 (* tmp.111 8)))
                  (set! tmp.109 (+ tmp.110 5)))
                (mset! vec.33 tmp.109 0))
              (begin
                (set! tmp.112 (+ i.34 8))
                (call
                 L.vector-init-loop.31.12
                 vector-init-loop.31
                 len.32
                 tmp.112
                 vec.33)))))))
    (define L.vector-set!.83.11
      (lambda (c.85 tmp.59 tmp.60 tmp.61)
        (begin
          (set! unsafe-vector-set!.5 (mref c.85 14))
          (if (begin
                (if (begin (set! tmp.114 (bitwise-and tmp.60 7)) (= tmp.114 0))
                  (set! tmp.113 14)
                  (set! tmp.113 6))
                (!= tmp.113 6))
            (if (begin
                  (if (begin
                        (set! tmp.116 (bitwise-and tmp.59 7))
                        (= tmp.116 3))
                    (set! tmp.115 14)
                    (set! tmp.115 6))
                  (!= tmp.115 6))
              (call
               L.unsafe-vector-set!.5.10
               unsafe-vector-set!.5
               tmp.59
               tmp.60
               tmp.61)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.10
      (lambda (c.84 tmp.35 tmp.36 tmp.37)
        (begin
          (if (begin
                (if (begin (set! tmp.118 (mref tmp.35 -3)) (< tmp.36 tmp.118))
                  (set! tmp.117 14)
                  (set! tmp.117 6))
                (!= tmp.117 6))
            (if (begin
                  (if (>= tmp.36 0) (set! tmp.119 14) (set! tmp.119 6))
                  (!= tmp.119 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.122 (arithmetic-shift-right tmp.36 3))
                      (set! tmp.121 (* tmp.122 8)))
                    (set! tmp.120 (+ tmp.121 5)))
                  (mset! tmp.35 tmp.120 tmp.37))
                30)
              2622)
            2622))))
    (begin
      (begin
        (begin (set! tmp.123 (alloc 16)) (set! tmp.93 (+ tmp.123 2)))
        (begin
          (mset! tmp.93 -2 L.unsafe-vector-set!.5.10)
          (mset! tmp.93 6 24)
          (set! unsafe-vector-set!.5 tmp.93)))
      (begin
        (begin (set! tmp.124 (alloc 24)) (set! tmp.94 (+ tmp.124 2)))
        (begin
          (mset! tmp.94 -2 L.vector-set!.83.11)
          (mset! tmp.94 6 24)
          (set! vector-set!.83 tmp.94)))
      (begin
        (begin (set! tmp.125 (alloc 24)) (set! tmp.95 (+ tmp.125 2)))
        (begin
          (mset! tmp.95 -2 L.vector-init-loop.31.12)
          (mset! tmp.95 6 24)
          (set! vector-init-loop.31 tmp.95)))
      (begin
        (begin (set! tmp.126 (alloc 24)) (set! tmp.96 (+ tmp.126 2)))
        (begin
          (mset! tmp.96 -2 L.make-init-vector.4.13)
          (mset! tmp.96 6 8)
          (set! make-init-vector.4 tmp.96)))
      (begin
        (begin (set! tmp.127 (alloc 24)) (set! tmp.97 (+ tmp.127 2)))
        (begin
          (mset! tmp.97 -2 L.make-vector.82.14)
          (mset! tmp.97 6 8)
          (set! make-vector.82 tmp.97)))
      (begin
        (begin (set! tmp.128 (alloc 16)) (set! tmp.98 (+ tmp.128 2)))
        (begin
          (mset! tmp.98 -2 L.error?.81.15)
          (mset! tmp.98 6 8)
          (set! error?.81 tmp.98)))
      (begin
        (begin (set! tmp.129 (alloc 16)) (set! tmp.99 (+ tmp.129 2)))
        (begin
          (mset! tmp.99 -2 L.fun/void8514.8.16)
          (mset! tmp.99 6 0)
          (set! fun/void8514.8 tmp.99)))
      (begin
        (begin (set! tmp.130 (alloc 16)) (set! tmp.100 (+ tmp.130 2)))
        (begin
          (mset! tmp.100 -2 L.fun/void8513.9.17)
          (mset! tmp.100 6 0)
          (set! fun/void8513.9 tmp.100)))
      (begin
        (mset! vector-set!.83 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.31 14 vector-init-loop.31)
        (mset! make-init-vector.4 14 vector-init-loop.31)
        (mset! make-vector.82 14 make-init-vector.4)
        (begin
          (if (!= 6 6) (set! g42771912.10 30) (set! g42771912.10 30))
          (if (begin
                (set! tmp.131 (call L.error?.81.15 error?.81 g42771912.10))
                (!= tmp.131 6))
            g42771912.10
            (begin
              (set! g42771913.11 (call L.fun/void8513.9.17 fun/void8513.9))
              (if (begin
                    (set! tmp.132 (call L.error?.81.15 error?.81 g42771913.11))
                    (!= tmp.132 6))
                g42771913.11
                (begin
                  (begin
                    (begin
                      (set! tmp.7.14
                        (call L.make-vector.82.14 make-vector.82 64))
                      (begin
                        (set! g42771915.15
                          (call
                           L.vector-set!.83.11
                           vector-set!.83
                           tmp.7.14
                           0
                           0))
                        (if (begin
                              (set! tmp.133
                                (call L.error?.81.15 error?.81 g42771915.15))
                              (!= tmp.133 6))
                          (set! vector0.13 g42771915.15)
                          (begin
                            (set! g42771916.16
                              (call
                               L.vector-set!.83.11
                               vector-set!.83
                               tmp.7.14
                               8
                               8))
                            (if (begin
                                  (set! tmp.134
                                    (call
                                     L.error?.81.15
                                     error?.81
                                     g42771916.16))
                                  (!= tmp.134 6))
                              (set! vector0.13 g42771916.16)
                              (begin
                                (set! g42771917.17
                                  (call
                                   L.vector-set!.83.11
                                   vector-set!.83
                                   tmp.7.14
                                   16
                                   16))
                                (if (begin
                                      (set! tmp.135
                                        (call
                                         L.error?.81.15
                                         error?.81
                                         g42771917.17))
                                      (!= tmp.135 6))
                                  (set! vector0.13 g42771917.17)
                                  (begin
                                    (set! g42771918.18
                                      (call
                                       L.vector-set!.83.11
                                       vector-set!.83
                                       tmp.7.14
                                       24
                                       24))
                                    (if (begin
                                          (set! tmp.136
                                            (call
                                             L.error?.81.15
                                             error?.81
                                             g42771918.18))
                                          (!= tmp.136 6))
                                      (set! vector0.13 g42771918.18)
                                      (begin
                                        (set! g42771919.19
                                          (call
                                           L.vector-set!.83.11
                                           vector-set!.83
                                           tmp.7.14
                                           32
                                           32))
                                        (if (begin
                                              (set! tmp.137
                                                (call
                                                 L.error?.81.15
                                                 error?.81
                                                 g42771919.19))
                                              (!= tmp.137 6))
                                          (set! vector0.13 g42771919.19)
                                          (begin
                                            (set! g42771920.20
                                              (call
                                               L.vector-set!.83.11
                                               vector-set!.83
                                               tmp.7.14
                                               40
                                               40))
                                            (if (begin
                                                  (set! tmp.138
                                                    (call
                                                     L.error?.81.15
                                                     error?.81
                                                     g42771920.20))
                                                  (!= tmp.138 6))
                                              (set! vector0.13 g42771920.20)
                                              (begin
                                                (set! g42771921.21
                                                  (call
                                                   L.vector-set!.83.11
                                                   vector-set!.83
                                                   tmp.7.14
                                                   48
                                                   48))
                                                (if (begin
                                                      (set! tmp.139
                                                        (call
                                                         L.error?.81.15
                                                         error?.81
                                                         g42771921.21))
                                                      (!= tmp.139 6))
                                                  (set! vector0.13
                                                    g42771921.21)
                                                  (begin
                                                    (set! g42771922.22
                                                      (call
                                                       L.vector-set!.83.11
                                                       vector-set!.83
                                                       tmp.7.14
                                                       56
                                                       56))
                                                    (if (begin
                                                          (set! tmp.140
                                                            (call
                                                             L.error?.81.15
                                                             error?.81
                                                             g42771922.22))
                                                          (!= tmp.140 6))
                                                      (set! vector0.13
                                                        g42771922.22)
                                                      (set! vector0.13
                                                        tmp.7.14))))))))))))))))))
                    (set! g42771914.12 30))
                  (if (begin
                        (set! tmp.141
                          (call L.error?.81.15 error?.81 g42771914.12))
                        (!= tmp.141 6))
                    g42771914.12
                    (begin
                      (begin
                        (set! g42771924.24 30)
                        (if (begin
                              (set! tmp.142
                                (call L.error?.81.15 error?.81 g42771924.24))
                              (!= tmp.142 6))
                          (set! g42771923.23 g42771924.24)
                          (begin
                            (set! g42771925.25 30)
                            (if (begin
                                  (set! tmp.143
                                    (call
                                     L.error?.81.15
                                     error?.81
                                     g42771925.25))
                                  (!= tmp.143 6))
                              (set! g42771923.23 g42771925.25)
                              (begin
                                (set! g42771926.26 30)
                                (if (begin
                                      (set! tmp.144
                                        (call
                                         L.error?.81.15
                                         error?.81
                                         g42771926.26))
                                      (!= tmp.144 6))
                                  (set! g42771923.23 g42771926.26)
                                  (set! g42771923.23 30)))))))
                      (if (begin
                            (set! tmp.145
                              (call L.error?.81.15 error?.81 g42771923.23))
                            (!= tmp.145 6))
                        g42771923.23
                        (begin
                          (begin (set! g42771927.27 30))
                          (if (begin
                                (set! tmp.146
                                  (call L.error?.81.15 error?.81 g42771927.27))
                                (!= tmp.146 6))
                            g42771927.27
                            (begin
                              (begin (set! g42771928.28 30))
                              (if (begin
                                    (set! tmp.147
                                      (call
                                       L.error?.81.15
                                       error?.81
                                       g42771928.28))
                                    (!= tmp.147 6))
                                g42771928.28
                                (call
                                 L.fun/void8514.8.16
                                 fun/void8514.8)))))))))))))))))
(check-by-interp '(module (begin 22)))
(check-by-interp '(module (begin 22830)))
(check-by-interp
 '(module
    (define L.fun/empty8524.7.10 (lambda (c.60) (begin (if (!= 6 6) 22 22))))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/empty8524.7.10)
          (mset! tmp.61 6 0)
          (set! fun/empty8524.7 tmp.61)))
      (call L.fun/empty8524.7.10 fun/empty8524.7))))
(check-by-interp '(module (if (!= 14 6) 22 22)))
(check-by-interp '(module (begin (set! fixnum0.7 264) 14)))
(check-by-interp
 '(module
    (define L.fun/void8531.7.10 (lambda (c.60) (begin (if (!= 6 6) 30 30))))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/void8531.7.10)
          (mset! tmp.61 6 0)
          (set! fun/void8531.7 tmp.61)))
      (call L.fun/void8531.7.10 fun/void8531.7))))
(check-by-interp
 '(module
    (define L.lam.73.13 (lambda (c.77) (begin 27966)))
    (define L.fun/error8535.12.12 (lambda (c.76) (begin 15422)))
    (define L.fun/error8534.11.11 (lambda (c.75) (begin 21054)))
    (define L.error?.72.10
      (lambda (c.74 tmp.62)
        (begin
          (if (begin (set! tmp.82 (bitwise-and tmp.62 255)) (= tmp.82 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.83 (alloc 16)) (set! tmp.78 (+ tmp.83 2)))
        (begin
          (mset! tmp.78 -2 L.error?.72.10)
          (mset! tmp.78 6 8)
          (set! error?.72 tmp.78)))
      (begin
        (begin (set! tmp.84 (alloc 16)) (set! tmp.79 (+ tmp.84 2)))
        (begin
          (mset! tmp.79 -2 L.fun/error8534.11.11)
          (mset! tmp.79 6 0)
          (set! fun/error8534.11 tmp.79)))
      (begin
        (begin (set! tmp.85 (alloc 16)) (set! tmp.80 (+ tmp.85 2)))
        (begin
          (mset! tmp.80 -2 L.fun/error8535.12.12)
          (mset! tmp.80 6 0)
          (set! fun/error8535.12 tmp.80)))
      (if (begin
            (set! tmp.7.13 10046)
            (if (!= tmp.7.13 6)
              (!= tmp.7.13 6)
              (begin
                (set! tmp.8.14 49470)
                (if (!= tmp.8.14 6)
                  (!= tmp.8.14 6)
                  (begin
                    (set! tmp.9.15 31806)
                    (if (!= tmp.9.15 6)
                      (!= tmp.9.15 6)
                      (begin
                        (set! tmp.10.16 18750)
                        (if (!= tmp.10.16 6)
                          (!= tmp.10.16 6)
                          (!= 19262 6)))))))))
        (if (if (!= 6 6) (!= 31806 6) (!= 31806 6))
          (if (begin
                (set! tmp.86 (call L.fun/error8534.11.11 fun/error8534.11))
                (!= tmp.86 6))
            (if (begin
                  (set! tmp.87 (call L.fun/error8535.12.12 fun/error8535.12))
                  (!= tmp.87 6))
              (if (if (!= 6 6) (!= 37950 6) (!= 34878 6))
                (if (begin
                      (begin
                        (begin
                          (begin
                            (set! tmp.88 (alloc 16))
                            (set! tmp.81 (+ tmp.88 2)))
                          (begin
                            (mset! tmp.81 -2 L.lam.73.13)
                            (mset! tmp.81 6 0)
                            (set! lam.73 tmp.81)))
                        (set! procedure0.17 lam.73))
                      (!= 16446 6))
                  (begin
                    (set! g42798643.18 13886)
                    (if (begin
                          (set! tmp.89
                            (call L.error?.72.10 error?.72 g42798643.18))
                          (!= tmp.89 6))
                      g42798643.18
                      (begin
                        (set! g42798644.19 27966)
                        (if (begin
                              (set! tmp.90
                                (call L.error?.72.10 error?.72 g42798644.19))
                              (!= tmp.90 6))
                          g42798644.19
                          51262))))
                  6)
                6)
              6)
            6)
          6)
        6))))
(check-by-interp
 '(module
    (define L.fun/void8538.7.10 (lambda (c.60) (begin 30)))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/void8538.7.10)
          (mset! tmp.61 6 0)
          (set! fun/void8538.7 tmp.61)))
      (if (if (!= 30 6) (!= 30 6) (!= 6 6))
        (call L.fun/void8538.7.10 fun/void8538.7)
        6))))
(check-by-interp '(module (if (!= 6 6) 24366 26926)))
(check-by-interp
 '(module
    (define L.fun/fixnum8544.8.11 (lambda (c.62) (begin 936)))
    (define L.fun/fixnum8543.7.10
      (lambda (c.61)
        (begin
          (set! fun/fixnum8544.8 (mref c.61 14))
          (call L.fun/fixnum8544.8.11 fun/fixnum8544.8))))
    (begin
      (begin
        (begin (set! tmp.65 (alloc 24)) (set! tmp.63 (+ tmp.65 2)))
        (begin
          (mset! tmp.63 -2 L.fun/fixnum8543.7.10)
          (mset! tmp.63 6 0)
          (set! fun/fixnum8543.7 tmp.63)))
      (begin
        (begin (set! tmp.66 (alloc 16)) (set! tmp.64 (+ tmp.66 2)))
        (begin
          (mset! tmp.64 -2 L.fun/fixnum8544.8.11)
          (mset! tmp.64 6 0)
          (set! fun/fixnum8544.8 tmp.64)))
      (begin
        (mset! fun/fixnum8543.7 14 fun/fixnum8544.8)
        (call L.fun/fixnum8543.7.10 fun/fixnum8543.7)))))
(check-by-interp '(module (if (!= 6 6) 42046 47166)))
(check-by-interp '(module (begin 23086)))
(check-by-interp
 '(module
    (define L.fun/fixnum8551.7.10
      (lambda (c.60) (begin (if (!= 14 6) 536 1032))))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/fixnum8551.7.10)
          (mset! tmp.61 6 0)
          (set! fun/fixnum8551.7 tmp.61)))
      (call L.fun/fixnum8551.7.10 fun/fixnum8551.7))))
(check-by-interp
 '(module
    (define L.fun/error8559.8.11 (lambda (c.62) (begin 47678)))
    (define L.fun/error8558.7.10
      (lambda (c.61)
        (begin
          (set! fun/error8559.8 (mref c.61 14))
          (call L.fun/error8559.8.11 fun/error8559.8))))
    (begin
      (begin
        (begin (set! tmp.65 (alloc 24)) (set! tmp.63 (+ tmp.65 2)))
        (begin
          (mset! tmp.63 -2 L.fun/error8558.7.10)
          (mset! tmp.63 6 0)
          (set! fun/error8558.7 tmp.63)))
      (begin
        (begin (set! tmp.66 (alloc 16)) (set! tmp.64 (+ tmp.66 2)))
        (begin
          (mset! tmp.64 -2 L.fun/error8559.8.11)
          (mset! tmp.64 6 0)
          (set! fun/error8559.8 tmp.64)))
      (begin
        (mset! fun/error8558.7 14 fun/error8559.8)
        (call L.fun/error8558.7.10 fun/error8558.7)))))
(check-by-interp
 '(module
    (define L.fun/void8563.10.13 (lambda (c.68) (begin 30)))
    (define L.fun/void8564.9.12
      (lambda (c.67)
        (begin
          (set! fun/void8565.8 (mref c.67 14))
          (call L.fun/void8565.8.11 fun/void8565.8))))
    (define L.fun/void8565.8.11 (lambda (c.66) (begin 30)))
    (define L.fun/void8562.7.10
      (lambda (c.65)
        (begin
          (set! fun/void8563.10 (mref c.65 14))
          (call L.fun/void8563.10.13 fun/void8563.10))))
    (begin
      (begin
        (begin (set! tmp.73 (alloc 24)) (set! tmp.69 (+ tmp.73 2)))
        (begin
          (mset! tmp.69 -2 L.fun/void8562.7.10)
          (mset! tmp.69 6 0)
          (set! fun/void8562.7 tmp.69)))
      (begin
        (begin (set! tmp.74 (alloc 16)) (set! tmp.70 (+ tmp.74 2)))
        (begin
          (mset! tmp.70 -2 L.fun/void8565.8.11)
          (mset! tmp.70 6 0)
          (set! fun/void8565.8 tmp.70)))
      (begin
        (begin (set! tmp.75 (alloc 24)) (set! tmp.71 (+ tmp.75 2)))
        (begin
          (mset! tmp.71 -2 L.fun/void8564.9.12)
          (mset! tmp.71 6 0)
          (set! fun/void8564.9 tmp.71)))
      (begin
        (begin (set! tmp.76 (alloc 16)) (set! tmp.72 (+ tmp.76 2)))
        (begin
          (mset! tmp.72 -2 L.fun/void8563.10.13)
          (mset! tmp.72 6 0)
          (set! fun/void8563.10 tmp.72)))
      (begin
        (mset! fun/void8562.7 14 fun/void8563.10)
        (mset! fun/void8564.9 14 fun/void8565.8)
        (if (begin
              (set! tmp.77 (call L.fun/void8562.7.10 fun/void8562.7))
              (!= tmp.77 6))
          (if (begin (set! void0.12 30) (set! error1.11 50238) (!= 30 6))
            (call L.fun/void8564.9.12 fun/void8564.9)
            6)
          6)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8569.8.11 (lambda (c.63) (begin 22574)))
    (define L.fun/ascii-char8568.7.10
      (lambda (c.62 oprand0.9)
        (begin
          (set! fun/ascii-char8569.8 (mref c.62 14))
          (call L.fun/ascii-char8569.8.11 fun/ascii-char8569.8))))
    (begin
      (begin
        (begin (set! tmp.66 (alloc 24)) (set! tmp.64 (+ tmp.66 2)))
        (begin
          (mset! tmp.64 -2 L.fun/ascii-char8568.7.10)
          (mset! tmp.64 6 8)
          (set! fun/ascii-char8568.7 tmp.64)))
      (begin
        (begin (set! tmp.67 (alloc 16)) (set! tmp.65 (+ tmp.67 2)))
        (begin
          (mset! tmp.65 -2 L.fun/ascii-char8569.8.11)
          (mset! tmp.65 6 0)
          (set! fun/ascii-char8569.8 tmp.65)))
      (begin
        (mset! fun/ascii-char8568.7 14 fun/ascii-char8569.8)
        (begin
          (if (!= 14 6) (set! tmp.68 520) (set! tmp.68 1000))
          (call L.fun/ascii-char8568.7.10 fun/ascii-char8568.7 tmp.68))))))
(check-by-interp
 '(module
    (define L.lam.79.17 (lambda (c.87) (begin 7136)))
    (define L.make-vector.75.16
      (lambda (c.86 tmp.51)
        (begin
          (set! make-init-vector.4 (mref c.86 14))
          (if (begin
                (if (begin (set! tmp.99 (bitwise-and tmp.51 7)) (= tmp.99 0))
                  (set! tmp.98 14)
                  (set! tmp.98 6))
                (!= tmp.98 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.51)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.85 tmp.23)
        (begin
          (set! vector-init-loop.25 (mref c.85 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.103 (arithmetic-shift-right tmp.23 3))
                      (set! tmp.102 (+ 1 tmp.103)))
                    (set! tmp.101 (* tmp.102 8)))
                  (set! tmp.100 (alloc tmp.101)))
                (set! tmp.88 (+ tmp.100 3)))
              (begin (mset! tmp.88 -3 tmp.23) (set! tmp.24 tmp.88)))
            (call
             L.vector-init-loop.25.14
             vector-init-loop.25
             tmp.23
             0
             tmp.24)))))
    (define L.vector-init-loop.25.14
      (lambda (c.84 len.26 i.28 vec.27)
        (begin
          (set! vector-init-loop.25 (mref c.84 14))
          (if (begin
                (if (= len.26 i.28) (set! tmp.104 14) (set! tmp.104 6))
                (!= tmp.104 6))
            vec.27
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.107 (arithmetic-shift-right i.28 3))
                    (set! tmp.106 (* tmp.107 8)))
                  (set! tmp.105 (+ tmp.106 5)))
                (mset! vec.27 tmp.105 0))
              (begin
                (set! tmp.108 (+ i.28 8))
                (call
                 L.vector-init-loop.25.14
                 vector-init-loop.25
                 len.26
                 tmp.108
                 vec.27)))))))
    (define L.vector-set!.76.13
      (lambda (c.83 tmp.53 tmp.54 tmp.55)
        (begin
          (set! unsafe-vector-set!.5 (mref c.83 14))
          (if (begin
                (if (begin (set! tmp.110 (bitwise-and tmp.54 7)) (= tmp.110 0))
                  (set! tmp.109 14)
                  (set! tmp.109 6))
                (!= tmp.109 6))
            (if (begin
                  (if (begin
                        (set! tmp.112 (bitwise-and tmp.53 7))
                        (= tmp.112 3))
                    (set! tmp.111 14)
                    (set! tmp.111 6))
                  (!= tmp.111 6))
              (call
               L.unsafe-vector-set!.5.12
               unsafe-vector-set!.5
               tmp.53
               tmp.54
               tmp.55)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.12
      (lambda (c.82 tmp.29 tmp.30 tmp.31)
        (begin
          (if (begin
                (if (begin (set! tmp.114 (mref tmp.29 -3)) (< tmp.30 tmp.114))
                  (set! tmp.113 14)
                  (set! tmp.113 6))
                (!= tmp.113 6))
            (if (begin
                  (if (>= tmp.30 0) (set! tmp.115 14) (set! tmp.115 6))
                  (!= tmp.115 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.118 (arithmetic-shift-right tmp.30 3))
                      (set! tmp.117 (* tmp.118 8)))
                    (set! tmp.116 (+ tmp.117 5)))
                  (mset! tmp.29 tmp.116 tmp.31))
                30)
              2622)
            2622))))
    (define L.error?.77.11
      (lambda (c.81 tmp.65)
        (begin
          (if (begin (set! tmp.119 (bitwise-and tmp.65 255)) (= tmp.119 62))
            14
            6))))
    (define L.cons.78.10
      (lambda (c.80 tmp.70 tmp.71)
        (begin
          (begin
            (begin (set! tmp.120 (alloc 16)) (set! tmp.89 (+ tmp.120 1)))
            (begin (mset! tmp.89 -1 tmp.70) (mset! tmp.89 7 tmp.71) tmp.89)))))
    (begin
      (begin
        (begin (set! tmp.121 (alloc 16)) (set! tmp.90 (+ tmp.121 2)))
        (begin
          (mset! tmp.90 -2 L.cons.78.10)
          (mset! tmp.90 6 16)
          (set! cons.78 tmp.90)))
      (begin
        (begin (set! tmp.122 (alloc 16)) (set! tmp.91 (+ tmp.122 2)))
        (begin
          (mset! tmp.91 -2 L.error?.77.11)
          (mset! tmp.91 6 8)
          (set! error?.77 tmp.91)))
      (begin
        (begin (set! tmp.123 (alloc 16)) (set! tmp.92 (+ tmp.123 2)))
        (begin
          (mset! tmp.92 -2 L.unsafe-vector-set!.5.12)
          (mset! tmp.92 6 24)
          (set! unsafe-vector-set!.5 tmp.92)))
      (begin
        (begin (set! tmp.124 (alloc 24)) (set! tmp.93 (+ tmp.124 2)))
        (begin
          (mset! tmp.93 -2 L.vector-set!.76.13)
          (mset! tmp.93 6 24)
          (set! vector-set!.76 tmp.93)))
      (begin
        (begin (set! tmp.125 (alloc 24)) (set! tmp.94 (+ tmp.125 2)))
        (begin
          (mset! tmp.94 -2 L.vector-init-loop.25.14)
          (mset! tmp.94 6 24)
          (set! vector-init-loop.25 tmp.94)))
      (begin
        (begin (set! tmp.126 (alloc 24)) (set! tmp.95 (+ tmp.126 2)))
        (begin
          (mset! tmp.95 -2 L.make-init-vector.4.15)
          (mset! tmp.95 6 8)
          (set! make-init-vector.4 tmp.95)))
      (begin
        (begin (set! tmp.127 (alloc 24)) (set! tmp.96 (+ tmp.127 2)))
        (begin
          (mset! tmp.96 -2 L.make-vector.75.16)
          (mset! tmp.96 6 8)
          (set! make-vector.75 tmp.96)))
      (begin
        (mset! vector-set!.76 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.25 14 vector-init-loop.25)
        (mset! make-init-vector.4 14 vector-init-loop.25)
        (mset! make-vector.75 14 make-init-vector.4)
        (begin
          (begin
            (set! tmp.7.10 (call L.make-vector.75.16 make-vector.75 64))
            (begin
              (begin
                (set! tmp.128 (call L.make-vector.75.16 make-vector.75 64))
                (set! g42836815.11
                  (call
                   L.vector-set!.76.13
                   vector-set!.76
                   tmp.7.10
                   0
                   tmp.128)))
              (if (begin
                    (set! tmp.129 (call L.error?.77.11 error?.77 g42836815.11))
                    (!= tmp.129 6))
                (set! vector0.9 g42836815.11)
                (begin
                  (begin
                    (begin
                      (set! tmp.131 (call L.cons.78.10 cons.78 3072 22))
                      (set! tmp.130 (call L.cons.78.10 cons.78 1648 tmp.131)))
                    (set! g42836816.12
                      (call
                       L.vector-set!.76.13
                       vector-set!.76
                       tmp.7.10
                       8
                       tmp.130)))
                  (if (begin
                        (set! tmp.132
                          (call L.error?.77.11 error?.77 g42836816.12))
                        (!= tmp.132 6))
                    (set! vector0.9 g42836816.12)
                    (begin
                      (begin
                        (begin
                          (set! tmp.134 (call L.cons.78.10 cons.78 4040 22))
                          (set! tmp.133
                            (call L.cons.78.10 cons.78 1504 tmp.134)))
                        (set! g42836817.13
                          (call
                           L.vector-set!.76.13
                           vector-set!.76
                           tmp.7.10
                           16
                           tmp.133)))
                      (if (begin
                            (set! tmp.135
                              (call L.error?.77.11 error?.77 g42836817.13))
                            (!= tmp.135 6))
                        (set! vector0.9 g42836817.13)
                        (begin
                          (set! g42836818.14
                            (call
                             L.vector-set!.76.13
                             vector-set!.76
                             tmp.7.10
                             24
                             27694))
                          (if (begin
                                (set! tmp.136
                                  (call L.error?.77.11 error?.77 g42836818.14))
                                (!= tmp.136 6))
                            (set! vector0.9 g42836818.14)
                            (begin
                              (begin
                                (begin
                                  (set! tmp.138
                                    (call L.cons.78.10 cons.78 2256 22))
                                  (set! tmp.137
                                    (call L.cons.78.10 cons.78 1232 tmp.138)))
                                (set! g42836819.15
                                  (call
                                   L.vector-set!.76.13
                                   vector-set!.76
                                   tmp.7.10
                                   32
                                   tmp.137)))
                              (if (begin
                                    (set! tmp.139
                                      (call
                                       L.error?.77.11
                                       error?.77
                                       g42836819.15))
                                    (!= tmp.139 6))
                                (set! vector0.9 g42836819.15)
                                (begin
                                  (set! g42836820.16
                                    (call
                                     L.vector-set!.76.13
                                     vector-set!.76
                                     tmp.7.10
                                     40
                                     30))
                                  (if (begin
                                        (set! tmp.140
                                          (call
                                           L.error?.77.11
                                           error?.77
                                           g42836820.16))
                                        (!= tmp.140 6))
                                    (set! vector0.9 g42836820.16)
                                    (begin
                                      (begin
                                        (begin
                                          (begin
                                            (begin
                                              (set! tmp.142 (alloc 16))
                                              (set! tmp.97 (+ tmp.142 2)))
                                            (begin
                                              (mset! tmp.97 -2 L.lam.79.17)
                                              (mset! tmp.97 6 0)
                                              (set! lam.79 tmp.97)))
                                          (set! tmp.141 lam.79))
                                        (set! g42836821.17
                                          (call
                                           L.vector-set!.76.13
                                           vector-set!.76
                                           tmp.7.10
                                           48
                                           tmp.141)))
                                      (if (begin
                                            (set! tmp.143
                                              (call
                                               L.error?.77.11
                                               error?.77
                                               g42836821.17))
                                            (!= tmp.143 6))
                                        (set! vector0.9 g42836821.17)
                                        (begin
                                          (set! g42836822.18
                                            (call
                                             L.vector-set!.76.13
                                             vector-set!.76
                                             tmp.7.10
                                             56
                                             6))
                                          (if (begin
                                                (set! tmp.144
                                                  (call
                                                   L.error?.77.11
                                                   error?.77
                                                   g42836822.18))
                                                (!= tmp.144 6))
                                            (set! vector0.9 g42836822.18)
                                            (set! vector0.9
                                              tmp.7.10))))))))))))))))))
          (begin
            (set! g42836823.19 30)
            (if (begin
                  (set! tmp.145 (call L.error?.77.11 error?.77 g42836823.19))
                  (!= tmp.145 6))
              (set! void1.8 g42836823.19)
              (begin
                (set! g42836824.20 30)
                (if (begin
                      (set! tmp.146
                        (call L.error?.77.11 error?.77 g42836824.20))
                      (!= tmp.146 6))
                  (set! void1.8 g42836824.20)
                  (begin
                    (set! g42836825.21 30)
                    (if (begin
                          (set! tmp.147
                            (call L.error?.77.11 error?.77 g42836825.21))
                          (!= tmp.147 6))
                      (set! void1.8 g42836825.21)
                      (begin
                        (set! g42836826.22 30)
                        (if (begin
                              (set! tmp.148
                                (call L.error?.77.11 error?.77 g42836826.22))
                              (!= tmp.148 6))
                          (set! void1.8 g42836826.22)
                          (set! void1.8 30)))))))))
          (begin 1360))))))
(check-by-interp
 '(module
    (define L.fun/boolean8574.7.14 (lambda (c.69 oprand0.8) (begin 6)))
    (define L.make-vector.63.13
      (lambda (c.68 tmp.39)
        (begin
          (set! make-init-vector.4 (mref c.68 14))
          (if (begin
                (if (begin (set! tmp.78 (bitwise-and tmp.39 7)) (= tmp.78 0))
                  (set! tmp.77 14)
                  (set! tmp.77 6))
                (!= tmp.77 6))
            (call L.make-init-vector.4.12 make-init-vector.4 tmp.39)
            2110))))
    (define L.make-init-vector.4.12
      (lambda (c.67 tmp.11)
        (begin
          (set! vector-init-loop.13 (mref c.67 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.82 (arithmetic-shift-right tmp.11 3))
                      (set! tmp.81 (+ 1 tmp.82)))
                    (set! tmp.80 (* tmp.81 8)))
                  (set! tmp.79 (alloc tmp.80)))
                (set! tmp.70 (+ tmp.79 3)))
              (begin (mset! tmp.70 -3 tmp.11) (set! tmp.12 tmp.70)))
            (call
             L.vector-init-loop.13.11
             vector-init-loop.13
             tmp.11
             0
             tmp.12)))))
    (define L.vector-init-loop.13.11
      (lambda (c.66 len.14 i.16 vec.15)
        (begin
          (set! vector-init-loop.13 (mref c.66 14))
          (if (begin
                (if (= len.14 i.16) (set! tmp.83 14) (set! tmp.83 6))
                (!= tmp.83 6))
            vec.15
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.86 (arithmetic-shift-right i.16 3))
                    (set! tmp.85 (* tmp.86 8)))
                  (set! tmp.84 (+ tmp.85 5)))
                (mset! vec.15 tmp.84 0))
              (begin
                (set! tmp.87 (+ i.16 8))
                (call
                 L.vector-init-loop.13.11
                 vector-init-loop.13
                 len.14
                 tmp.87
                 vec.15)))))))
    (define L.cons.64.10
      (lambda (c.65 tmp.58 tmp.59)
        (begin
          (begin
            (begin (set! tmp.88 (alloc 16)) (set! tmp.71 (+ tmp.88 1)))
            (begin (mset! tmp.71 -1 tmp.58) (mset! tmp.71 7 tmp.59) tmp.71)))))
    (begin
      (begin
        (begin (set! tmp.89 (alloc 16)) (set! tmp.72 (+ tmp.89 2)))
        (begin
          (mset! tmp.72 -2 L.cons.64.10)
          (mset! tmp.72 6 16)
          (set! cons.64 tmp.72)))
      (begin
        (begin (set! tmp.90 (alloc 24)) (set! tmp.73 (+ tmp.90 2)))
        (begin
          (mset! tmp.73 -2 L.vector-init-loop.13.11)
          (mset! tmp.73 6 24)
          (set! vector-init-loop.13 tmp.73)))
      (begin
        (begin (set! tmp.91 (alloc 24)) (set! tmp.74 (+ tmp.91 2)))
        (begin
          (mset! tmp.74 -2 L.make-init-vector.4.12)
          (mset! tmp.74 6 8)
          (set! make-init-vector.4 tmp.74)))
      (begin
        (begin (set! tmp.92 (alloc 24)) (set! tmp.75 (+ tmp.92 2)))
        (begin
          (mset! tmp.75 -2 L.make-vector.63.13)
          (mset! tmp.75 6 8)
          (set! make-vector.63 tmp.75)))
      (begin
        (begin (set! tmp.93 (alloc 16)) (set! tmp.76 (+ tmp.93 2)))
        (begin
          (mset! tmp.76 -2 L.fun/boolean8574.7.14)
          (mset! tmp.76 6 8)
          (set! fun/boolean8574.7 tmp.76)))
      (begin
        (mset! vector-init-loop.13 14 vector-init-loop.13)
        (mset! make-init-vector.4 14 vector-init-loop.13)
        (mset! make-vector.63 14 make-init-vector.4)
        (if (begin
              (begin
                (set! tmp.95 (call L.make-vector.63.13 make-vector.63 64))
                (set! tmp.94
                  (call L.fun/boolean8574.7.14 fun/boolean8574.7 tmp.95)))
              (!= tmp.94 6))
          (if (!= 14 6) 17198 23854)
          (begin
            (set! void0.10 30)
            (begin
              (set! tmp.96 (call L.cons.64.10 cons.64 3080 22))
              (set! pair1.9 (call L.cons.64.10 cons.64 1472 tmp.96)))
            22830))))))
(check-by-interp
 '(module
    (define L.lam.66.13 (lambda (c.70) (begin 6)))
    (define L.fun/empty8577.9.12
      (lambda (c.69 oprand0.10) (begin (if (!= 6 6) 22 22))))
    (define L.fun/empty8579.8.11 (lambda (c.68) (begin 22)))
    (define L.fun/empty8578.7.10
      (lambda (c.67)
        (begin
          (set! fun/empty8579.8 (mref c.67 14))
          (call L.fun/empty8579.8.11 fun/empty8579.8))))
    (begin
      (begin
        (begin (set! tmp.75 (alloc 24)) (set! tmp.71 (+ tmp.75 2)))
        (begin
          (mset! tmp.71 -2 L.fun/empty8578.7.10)
          (mset! tmp.71 6 0)
          (set! fun/empty8578.7 tmp.71)))
      (begin
        (begin (set! tmp.76 (alloc 16)) (set! tmp.72 (+ tmp.76 2)))
        (begin
          (mset! tmp.72 -2 L.fun/empty8579.8.11)
          (mset! tmp.72 6 0)
          (set! fun/empty8579.8 tmp.72)))
      (begin
        (begin (set! tmp.77 (alloc 16)) (set! tmp.73 (+ tmp.77 2)))
        (begin
          (mset! tmp.73 -2 L.fun/empty8577.9.12)
          (mset! tmp.73 6 8)
          (set! fun/empty8577.9 tmp.73)))
      (begin
        (mset! fun/empty8578.7 14 fun/empty8579.8)
        (if (begin (set! ascii-char0.11 24110) (!= 22 6))
          (if (begin
                (begin
                  (if (!= 22 6)
                    (if (!= 22 6)
                      (if (!= 22 6) (set! tmp.79 22) (set! tmp.79 6))
                      (set! tmp.79 6))
                    (set! tmp.79 6))
                  (set! tmp.78
                    (call L.fun/empty8577.9.12 fun/empty8577.9 tmp.79)))
                (!= tmp.78 6))
            (if (begin (!= 22 6))
              (if (begin
                    (begin
                      (begin
                        (begin
                          (set! tmp.80 (alloc 16))
                          (set! tmp.74 (+ tmp.80 2)))
                        (begin
                          (mset! tmp.74 -2 L.lam.66.13)
                          (mset! tmp.74 6 0)
                          (set! lam.66 tmp.74)))
                      (set! procedure0.13 lam.66))
                    (set! fixnum1.12 1632)
                    (!= 22 6))
                (call L.fun/empty8578.7.10 fun/empty8578.7)
                6)
              6)
            6)
          6)))))
(check-by-interp
 '(module
    (define L.fun/fixnum8583.10.20
      (lambda (c.88 oprand0.20) (begin (if (!= 6 6) 560 616))))
    (define L.fun/fixnum8582.9.19 (lambda (c.87) (begin 1872)))
    (define L.fun/vector8584.8.18
      (lambda (c.86)
        (begin
          (set! vector-set!.74 (mref c.86 14))
          (set! error?.75 (mref c.86 22))
          (set! make-vector.73 (mref c.86 30))
          (begin
            (set! tmp.7.11 (call L.make-vector.73.17 make-vector.73 64))
            (begin
              (set! g42848275.12
                (call L.vector-set!.74.14 vector-set!.74 tmp.7.11 0 8))
              (if (begin
                    (set! tmp.101 (call L.error?.75.12 error?.75 g42848275.12))
                    (!= tmp.101 6))
                g42848275.12
                (begin
                  (set! g42848276.13
                    (call L.vector-set!.74.14 vector-set!.74 tmp.7.11 8 16))
                  (if (begin
                        (set! tmp.102
                          (call L.error?.75.12 error?.75 g42848276.13))
                        (!= tmp.102 6))
                    g42848276.13
                    (begin
                      (set! g42848277.14
                        (call
                         L.vector-set!.74.14
                         vector-set!.74
                         tmp.7.11
                         16
                         24))
                      (if (begin
                            (set! tmp.103
                              (call L.error?.75.12 error?.75 g42848277.14))
                            (!= tmp.103 6))
                        g42848277.14
                        (begin
                          (set! g42848278.15
                            (call
                             L.vector-set!.74.14
                             vector-set!.74
                             tmp.7.11
                             24
                             32))
                          (if (begin
                                (set! tmp.104
                                  (call L.error?.75.12 error?.75 g42848278.15))
                                (!= tmp.104 6))
                            g42848278.15
                            (begin
                              (set! g42848279.16
                                (call
                                 L.vector-set!.74.14
                                 vector-set!.74
                                 tmp.7.11
                                 32
                                 40))
                              (if (begin
                                    (set! tmp.105
                                      (call
                                       L.error?.75.12
                                       error?.75
                                       g42848279.16))
                                    (!= tmp.105 6))
                                g42848279.16
                                (begin
                                  (set! g42848280.17
                                    (call
                                     L.vector-set!.74.14
                                     vector-set!.74
                                     tmp.7.11
                                     40
                                     48))
                                  (if (begin
                                        (set! tmp.106
                                          (call
                                           L.error?.75.12
                                           error?.75
                                           g42848280.17))
                                        (!= tmp.106 6))
                                    g42848280.17
                                    (begin
                                      (set! g42848281.18
                                        (call
                                         L.vector-set!.74.14
                                         vector-set!.74
                                         tmp.7.11
                                         48
                                         56))
                                      (if (begin
                                            (set! tmp.107
                                              (call
                                               L.error?.75.12
                                               error?.75
                                               g42848281.18))
                                            (!= tmp.107 6))
                                        g42848281.18
                                        (begin
                                          (set! g42848282.19
                                            (call
                                             L.vector-set!.74.14
                                             vector-set!.74
                                             tmp.7.11
                                             56
                                             64))
                                          (if (begin
                                                (set! tmp.108
                                                  (call
                                                   L.error?.75.12
                                                   error?.75
                                                   g42848282.19))
                                                (!= tmp.108 6))
                                            g42848282.19
                                            tmp.7.11))))))))))))))))))))
    (define L.make-vector.73.17
      (lambda (c.85 tmp.49)
        (begin
          (set! make-init-vector.4 (mref c.85 14))
          (if (begin
                (if (begin (set! tmp.110 (bitwise-and tmp.49 7)) (= tmp.110 0))
                  (set! tmp.109 14)
                  (set! tmp.109 6))
                (!= tmp.109 6))
            (call L.make-init-vector.4.16 make-init-vector.4 tmp.49)
            2110))))
    (define L.make-init-vector.4.16
      (lambda (c.84 tmp.21)
        (begin
          (set! vector-init-loop.23 (mref c.84 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.114 (arithmetic-shift-right tmp.21 3))
                      (set! tmp.113 (+ 1 tmp.114)))
                    (set! tmp.112 (* tmp.113 8)))
                  (set! tmp.111 (alloc tmp.112)))
                (set! tmp.89 (+ tmp.111 3)))
              (begin (mset! tmp.89 -3 tmp.21) (set! tmp.22 tmp.89)))
            (call
             L.vector-init-loop.23.15
             vector-init-loop.23
             tmp.21
             0
             tmp.22)))))
    (define L.vector-init-loop.23.15
      (lambda (c.83 len.24 i.26 vec.25)
        (begin
          (set! vector-init-loop.23 (mref c.83 14))
          (if (begin
                (if (= len.24 i.26) (set! tmp.115 14) (set! tmp.115 6))
                (!= tmp.115 6))
            vec.25
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.118 (arithmetic-shift-right i.26 3))
                    (set! tmp.117 (* tmp.118 8)))
                  (set! tmp.116 (+ tmp.117 5)))
                (mset! vec.25 tmp.116 0))
              (begin
                (set! tmp.119 (+ i.26 8))
                (call
                 L.vector-init-loop.23.15
                 vector-init-loop.23
                 len.24
                 tmp.119
                 vec.25)))))))
    (define L.vector-set!.74.14
      (lambda (c.82 tmp.51 tmp.52 tmp.53)
        (begin
          (set! unsafe-vector-set!.5 (mref c.82 14))
          (if (begin
                (if (begin (set! tmp.121 (bitwise-and tmp.52 7)) (= tmp.121 0))
                  (set! tmp.120 14)
                  (set! tmp.120 6))
                (!= tmp.120 6))
            (if (begin
                  (if (begin
                        (set! tmp.123 (bitwise-and tmp.51 7))
                        (= tmp.123 3))
                    (set! tmp.122 14)
                    (set! tmp.122 6))
                  (!= tmp.122 6))
              (call
               L.unsafe-vector-set!.5.13
               unsafe-vector-set!.5
               tmp.51
               tmp.52
               tmp.53)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.13
      (lambda (c.81 tmp.27 tmp.28 tmp.29)
        (begin
          (if (begin
                (if (begin (set! tmp.125 (mref tmp.27 -3)) (< tmp.28 tmp.125))
                  (set! tmp.124 14)
                  (set! tmp.124 6))
                (!= tmp.124 6))
            (if (begin
                  (if (>= tmp.28 0) (set! tmp.126 14) (set! tmp.126 6))
                  (!= tmp.126 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.129 (arithmetic-shift-right tmp.28 3))
                      (set! tmp.128 (* tmp.129 8)))
                    (set! tmp.127 (+ tmp.128 5)))
                  (mset! tmp.27 tmp.127 tmp.29))
                30)
              2622)
            2622))))
    (define L.error?.75.12
      (lambda (c.80 tmp.63)
        (begin
          (if (begin (set! tmp.130 (bitwise-and tmp.63 255)) (= tmp.130 62))
            14
            6))))
    (define L.*.76.11
      (lambda (c.79 tmp.35 tmp.36)
        (begin
          (if (begin
                (if (begin (set! tmp.132 (bitwise-and tmp.36 7)) (= tmp.132 0))
                  (set! tmp.131 14)
                  (set! tmp.131 6))
                (!= tmp.131 6))
            (if (begin
                  (if (begin
                        (set! tmp.134 (bitwise-and tmp.35 7))
                        (= tmp.134 0))
                    (set! tmp.133 14)
                    (set! tmp.133 6))
                  (!= tmp.133 6))
              (begin
                (set! tmp.135 (arithmetic-shift-right tmp.36 3))
                (* tmp.35 tmp.135))
              318)
            318))))
    (define L.>=.77.10
      (lambda (c.78 tmp.47 tmp.48)
        (begin
          (if (begin
                (if (begin (set! tmp.137 (bitwise-and tmp.48 7)) (= tmp.137 0))
                  (set! tmp.136 14)
                  (set! tmp.136 6))
                (!= tmp.136 6))
            (if (begin
                  (if (begin
                        (set! tmp.139 (bitwise-and tmp.47 7))
                        (= tmp.139 0))
                    (set! tmp.138 14)
                    (set! tmp.138 6))
                  (!= tmp.138 6))
              (if (>= tmp.47 tmp.48) 14 6)
              1854)
            1854))))
    (begin
      (begin
        (begin (set! tmp.140 (alloc 16)) (set! tmp.90 (+ tmp.140 2)))
        (begin
          (mset! tmp.90 -2 L.>=.77.10)
          (mset! tmp.90 6 16)
          (set! >=.77 tmp.90)))
      (begin
        (begin (set! tmp.141 (alloc 16)) (set! tmp.91 (+ tmp.141 2)))
        (begin
          (mset! tmp.91 -2 L.*.76.11)
          (mset! tmp.91 6 16)
          (set! *.76 tmp.91)))
      (begin
        (begin (set! tmp.142 (alloc 16)) (set! tmp.92 (+ tmp.142 2)))
        (begin
          (mset! tmp.92 -2 L.error?.75.12)
          (mset! tmp.92 6 8)
          (set! error?.75 tmp.92)))
      (begin
        (begin (set! tmp.143 (alloc 16)) (set! tmp.93 (+ tmp.143 2)))
        (begin
          (mset! tmp.93 -2 L.unsafe-vector-set!.5.13)
          (mset! tmp.93 6 24)
          (set! unsafe-vector-set!.5 tmp.93)))
      (begin
        (begin (set! tmp.144 (alloc 24)) (set! tmp.94 (+ tmp.144 2)))
        (begin
          (mset! tmp.94 -2 L.vector-set!.74.14)
          (mset! tmp.94 6 24)
          (set! vector-set!.74 tmp.94)))
      (begin
        (begin (set! tmp.145 (alloc 24)) (set! tmp.95 (+ tmp.145 2)))
        (begin
          (mset! tmp.95 -2 L.vector-init-loop.23.15)
          (mset! tmp.95 6 24)
          (set! vector-init-loop.23 tmp.95)))
      (begin
        (begin (set! tmp.146 (alloc 24)) (set! tmp.96 (+ tmp.146 2)))
        (begin
          (mset! tmp.96 -2 L.make-init-vector.4.16)
          (mset! tmp.96 6 8)
          (set! make-init-vector.4 tmp.96)))
      (begin
        (begin (set! tmp.147 (alloc 24)) (set! tmp.97 (+ tmp.147 2)))
        (begin
          (mset! tmp.97 -2 L.make-vector.73.17)
          (mset! tmp.97 6 8)
          (set! make-vector.73 tmp.97)))
      (begin
        (begin (set! tmp.148 (alloc 40)) (set! tmp.98 (+ tmp.148 2)))
        (begin
          (mset! tmp.98 -2 L.fun/vector8584.8.18)
          (mset! tmp.98 6 0)
          (set! fun/vector8584.8 tmp.98)))
      (begin
        (begin (set! tmp.149 (alloc 16)) (set! tmp.99 (+ tmp.149 2)))
        (begin
          (mset! tmp.99 -2 L.fun/fixnum8582.9.19)
          (mset! tmp.99 6 0)
          (set! fun/fixnum8582.9 tmp.99)))
      (begin
        (begin (set! tmp.150 (alloc 16)) (set! tmp.100 (+ tmp.150 2)))
        (begin
          (mset! tmp.100 -2 L.fun/fixnum8583.10.20)
          (mset! tmp.100 6 8)
          (set! fun/fixnum8583.10 tmp.100)))
      (begin
        (mset! vector-set!.74 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.23 14 vector-init-loop.23)
        (mset! make-init-vector.4 14 vector-init-loop.23)
        (mset! make-vector.73 14 make-init-vector.4)
        (mset! fun/vector8584.8 14 vector-set!.74)
        (mset! fun/vector8584.8 22 error?.75)
        (mset! fun/vector8584.8 30 make-vector.73)
        (begin
          (begin
            (begin (set! tmp.152 624))
            (begin
              (set! tmp.153 (call L.fun/fixnum8582.9.19 fun/fixnum8582.9))
              (set! tmp.151 (call L.*.76.11 *.76 tmp.152 tmp.153))))
          (begin
            (begin
              (set! tmp.155 (call L.fun/vector8584.8.18 fun/vector8584.8))
              (set! tmp.154
                (call L.fun/fixnum8583.10.20 fun/fixnum8583.10 tmp.155)))
            (call L.>=.77.10 >=.77 tmp.151 tmp.154)))))))
(check-by-interp
 '(module
    (define L.fun/empty8587.20.12 (lambda (c.95) (begin 22)))
    (define L.fun/empty8588.19.11
      (lambda (c.94 oprand0.21) (begin (begin 22))))
    (define L.error?.92.10
      (lambda (c.93 tmp.82)
        (begin
          (if (begin (set! tmp.99 (bitwise-and tmp.82 255)) (= tmp.99 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.100 (alloc 16)) (set! tmp.96 (+ tmp.100 2)))
        (begin
          (mset! tmp.96 -2 L.error?.92.10)
          (mset! tmp.96 6 8)
          (set! error?.92 tmp.96)))
      (begin
        (begin (set! tmp.101 (alloc 16)) (set! tmp.97 (+ tmp.101 2)))
        (begin
          (mset! tmp.97 -2 L.fun/empty8588.19.11)
          (mset! tmp.97 6 8)
          (set! fun/empty8588.19 tmp.97)))
      (begin
        (begin (set! tmp.102 (alloc 16)) (set! tmp.98 (+ tmp.102 2)))
        (begin
          (mset! tmp.98 -2 L.fun/empty8587.20.12)
          (mset! tmp.98 6 0)
          (set! fun/empty8587.20 tmp.98)))
      (begin
        (if (!= 6 6) (set! tmp.7.22 22) (set! tmp.7.22 22))
        (if (!= tmp.7.22 6)
          tmp.7.22
          (begin
            (if (!= 6 6) (set! tmp.8.23 22) (set! tmp.8.23 22))
            (if (!= tmp.8.23 6)
              tmp.8.23
              (begin
                (begin (set! tmp.9.24 22))
                (if (!= tmp.9.24 6)
                  tmp.9.24
                  (begin
                    (if (!= 6 6) (set! tmp.10.25 22) (set! tmp.10.25 22))
                    (if (!= tmp.10.25 6)
                      tmp.10.25
                      (begin
                        (if (if (!= 14 6) (!= 22 6) (!= 22 6))
                          (if (begin (set! fixnum0.27 912) (!= 22 6))
                            (if (if (!= 14 6) (!= 22 6) (!= 22 6))
                              (if (begin
                                    (set! tmp.12.28 22)
                                    (if (!= tmp.12.28 6)
                                      (!= tmp.12.28 6)
                                      (begin
                                        (set! tmp.13.29 22)
                                        (if (!= tmp.13.29 6)
                                          (!= tmp.13.29 6)
                                          (begin
                                            (set! tmp.14.30 22)
                                            (if (!= tmp.14.30 6)
                                              (!= tmp.14.30 6)
                                              (begin
                                                (set! tmp.15.31 22)
                                                (if (!= tmp.15.31 6)
                                                  (!= tmp.15.31 6)
                                                  (begin
                                                    (set! tmp.16.32 22)
                                                    (if (!= tmp.16.32 6)
                                                      (!= tmp.16.32 6)
                                                      (begin
                                                        (set! tmp.17.33 22)
                                                        (if (!= tmp.17.33 6)
                                                          (!= tmp.17.33 6)
                                                          (!= 22 6)))))))))))))
                                (if (begin (!= 22 6))
                                  (if (begin
                                        (set! tmp.103
                                          (call
                                           L.fun/empty8587.20.12
                                           fun/empty8587.20))
                                        (!= tmp.103 6))
                                    (begin
                                      (set! fixnum0.34 880)
                                      (set! tmp.11.26 22))
                                    (set! tmp.11.26 6))
                                  (set! tmp.11.26 6))
                                (set! tmp.11.26 6))
                              (set! tmp.11.26 6))
                            (set! tmp.11.26 6))
                          (set! tmp.11.26 6))
                        (if (!= tmp.11.26 6)
                          tmp.11.26
                          (begin
                            (begin (set! tmp.18.35 22))
                            (if (!= tmp.18.35 6)
                              tmp.18.35
                              (begin
                                (begin
                                  (set! g42852100.36 1624)
                                  (if (begin
                                        (set! tmp.105
                                          (call
                                           L.error?.92.10
                                           error?.92
                                           g42852100.36))
                                        (!= tmp.105 6))
                                    (set! tmp.104 g42852100.36)
                                    (begin
                                      (set! g42852101.37 232)
                                      (if (begin
                                            (set! tmp.106
                                              (call
                                               L.error?.92.10
                                               error?.92
                                               g42852101.37))
                                            (!= tmp.106 6))
                                        (set! tmp.104 g42852101.37)
                                        (begin
                                          (set! g42852102.38 592)
                                          (if (begin
                                                (set! tmp.107
                                                  (call
                                                   L.error?.92.10
                                                   error?.92
                                                   g42852102.38))
                                                (!= tmp.107 6))
                                            (set! tmp.104 g42852102.38)
                                            (begin
                                              (set! g42852103.39 1824)
                                              (if (begin
                                                    (set! tmp.108
                                                      (call
                                                       L.error?.92.10
                                                       error?.92
                                                       g42852103.39))
                                                    (!= tmp.108 6))
                                                (set! tmp.104 g42852103.39)
                                                (set! tmp.104 1480)))))))))
                                (call
                                 L.fun/empty8588.19.11
                                 fun/empty8588.19
                                 tmp.104)))))))))))))))))
(check-by-interp
 '(module
    (define L.fun/empty8595.15.16 (lambda (c.97) (begin 22)))
    (define L.fun/empty8591.14.15 (lambda (c.96 oprand0.18) (begin 22)))
    (define L.fun/empty8593.13.14
      (lambda (c.95 oprand0.17) (begin (begin 22))))
    (define L.fun/empty8594.12.13
      (lambda (c.94 oprand0.16) (begin (if (!= 6 6) 22 22))))
    (define L.fun/empty8592.11.12 (lambda (c.93) (begin (if (!= 14 6) 22 22))))
    (define L.cons.89.11
      (lambda (c.92 tmp.84 tmp.85)
        (begin
          (begin
            (begin (set! tmp.106 (alloc 16)) (set! tmp.98 (+ tmp.106 1)))
            (begin (mset! tmp.98 -1 tmp.84) (mset! tmp.98 7 tmp.85) tmp.98)))))
    (define L.error?.90.10
      (lambda (c.91 tmp.79)
        (begin
          (if (begin (set! tmp.107 (bitwise-and tmp.79 255)) (= tmp.107 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.108 (alloc 16)) (set! tmp.99 (+ tmp.108 2)))
        (begin
          (mset! tmp.99 -2 L.error?.90.10)
          (mset! tmp.99 6 8)
          (set! error?.90 tmp.99)))
      (begin
        (begin (set! tmp.109 (alloc 16)) (set! tmp.100 (+ tmp.109 2)))
        (begin
          (mset! tmp.100 -2 L.cons.89.11)
          (mset! tmp.100 6 16)
          (set! cons.89 tmp.100)))
      (begin
        (begin (set! tmp.110 (alloc 16)) (set! tmp.101 (+ tmp.110 2)))
        (begin
          (mset! tmp.101 -2 L.fun/empty8592.11.12)
          (mset! tmp.101 6 0)
          (set! fun/empty8592.11 tmp.101)))
      (begin
        (begin (set! tmp.111 (alloc 16)) (set! tmp.102 (+ tmp.111 2)))
        (begin
          (mset! tmp.102 -2 L.fun/empty8594.12.13)
          (mset! tmp.102 6 8)
          (set! fun/empty8594.12 tmp.102)))
      (begin
        (begin (set! tmp.112 (alloc 16)) (set! tmp.103 (+ tmp.112 2)))
        (begin
          (mset! tmp.103 -2 L.fun/empty8593.13.14)
          (mset! tmp.103 6 8)
          (set! fun/empty8593.13 tmp.103)))
      (begin
        (begin (set! tmp.113 (alloc 16)) (set! tmp.104 (+ tmp.113 2)))
        (begin
          (mset! tmp.104 -2 L.fun/empty8591.14.15)
          (mset! tmp.104 6 8)
          (set! fun/empty8591.14 tmp.104)))
      (begin
        (begin (set! tmp.114 (alloc 16)) (set! tmp.105 (+ tmp.114 2)))
        (begin
          (mset! tmp.105 -2 L.fun/empty8595.15.16)
          (mset! tmp.105 6 0)
          (set! fun/empty8595.15 tmp.105)))
      (begin
        (begin
          (begin
            (set! tmp.115 (call L.cons.89.11 cons.89 2864 22))
            (set! pair0.21 (call L.cons.89.11 cons.89 2024 tmp.115)))
          (begin
            (set! tmp.116 (call L.cons.89.11 cons.89 2360 22))
            (set! pair1.20 (call L.cons.89.11 cons.89 1352 tmp.116)))
          (set! g42855921.19 22))
        (if (begin
              (set! tmp.117 (call L.error?.90.10 error?.90 g42855921.19))
              (!= tmp.117 6))
          g42855921.19
          (begin
            (begin
              (if (!= 6 6) (set! tmp.7.23 22) (set! tmp.7.23 22))
              (if (!= tmp.7.23 6)
                (set! g42855922.22 tmp.7.23)
                (begin
                  (if (!= 6 6) (set! tmp.8.24 22) (set! tmp.8.24 22))
                  (if (!= tmp.8.24 6)
                    (set! g42855922.22 tmp.8.24)
                    (begin
                      (begin
                        (set! g42855923.26 22)
                        (if (begin
                              (set! tmp.118
                                (call L.error?.90.10 error?.90 g42855923.26))
                              (!= tmp.118 6))
                          (set! tmp.9.25 g42855923.26)
                          (begin
                            (set! g42855924.27 22)
                            (if (begin
                                  (set! tmp.119
                                    (call
                                     L.error?.90.10
                                     error?.90
                                     g42855924.27))
                                  (!= tmp.119 6))
                              (set! tmp.9.25 g42855924.27)
                              (begin
                                (set! g42855925.28 22)
                                (if (begin
                                      (set! tmp.120
                                        (call
                                         L.error?.90.10
                                         error?.90
                                         g42855925.28))
                                      (!= tmp.120 6))
                                  (set! tmp.9.25 g42855925.28)
                                  (begin
                                    (set! g42855926.29 22)
                                    (if (begin
                                          (set! tmp.121
                                            (call
                                             L.error?.90.10
                                             error?.90
                                             g42855926.29))
                                          (!= tmp.121 6))
                                      (set! tmp.9.25 g42855926.29)
                                      (begin
                                        (set! g42855927.30 22)
                                        (if (begin
                                              (set! tmp.122
                                                (call
                                                 L.error?.90.10
                                                 error?.90
                                                 g42855927.30))
                                              (!= tmp.122 6))
                                          (set! tmp.9.25 g42855927.30)
                                          (set! tmp.9.25 22)))))))))))
                      (if (!= tmp.9.25 6)
                        (set! g42855922.22 tmp.9.25)
                        (begin
                          (begin (set! tmp.10.31 22))
                          (if (!= tmp.10.31 6)
                            (set! g42855922.22 tmp.10.31)
                            (set! g42855922.22
                              (call
                               L.fun/empty8591.14.15
                               fun/empty8591.14
                               1112))))))))))
            (if (begin
                  (set! tmp.123 (call L.error?.90.10 error?.90 g42855922.22))
                  (!= tmp.123 6))
              g42855922.22
              (begin
                (set! g42855928.32
                  (call L.fun/empty8592.11.12 fun/empty8592.11))
                (if (begin
                      (set! tmp.124
                        (call L.error?.90.10 error?.90 g42855928.32))
                      (!= tmp.124 6))
                  g42855928.32
                  (begin
                    (begin
                      (begin
                        (begin
                          (set! tmp.126 (call L.cons.89.11 cons.89 3616 22))
                          (set! pair0.34
                            (call L.cons.89.11 cons.89 896 tmp.126)))
                        (set! tmp.125 63550))
                      (set! g42855929.33
                        (call L.fun/empty8593.13.14 fun/empty8593.13 tmp.125)))
                    (if (begin
                          (set! tmp.127
                            (call L.error?.90.10 error?.90 g42855929.33))
                          (!= tmp.127 6))
                      g42855929.33
                      (begin
                        (set! g42855930.35
                          (call L.fun/empty8594.12.13 fun/empty8594.12 38206))
                        (if (begin
                              (set! tmp.128
                                (call L.error?.90.10 error?.90 g42855930.35))
                              (!= tmp.128 6))
                          g42855930.35
                          (begin
                            (begin (set! g42855931.36 22))
                            (if (begin
                                  (set! tmp.129
                                    (call
                                     L.error?.90.10
                                     error?.90
                                     g42855931.36))
                                  (!= tmp.129 6))
                              g42855931.36
                              (if (begin
                                    (set! tmp.130
                                      (call
                                       L.fun/empty8595.15.16
                                       fun/empty8595.15))
                                    (!= tmp.130 6))
                                (if (!= 14 6) 22 22)
                                6))))))))))))))))
(check-by-interp
 '(module
    (define L.fun/fixnum8599.8.12 (lambda (c.67) (begin 512)))
    (define L.fun/fixnum8598.7.11 (lambda (c.66) (begin 1624)))
    (define L.error?.64.10
      (lambda (c.65 tmp.54)
        (begin
          (if (begin (set! tmp.71 (bitwise-and tmp.54 255)) (= tmp.71 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.72 (alloc 16)) (set! tmp.68 (+ tmp.72 2)))
        (begin
          (mset! tmp.68 -2 L.error?.64.10)
          (mset! tmp.68 6 8)
          (set! error?.64 tmp.68)))
      (begin
        (begin (set! tmp.73 (alloc 16)) (set! tmp.69 (+ tmp.73 2)))
        (begin
          (mset! tmp.69 -2 L.fun/fixnum8598.7.11)
          (mset! tmp.69 6 0)
          (set! fun/fixnum8598.7 tmp.69)))
      (begin
        (begin (set! tmp.74 (alloc 16)) (set! tmp.70 (+ tmp.74 2)))
        (begin
          (mset! tmp.70 -2 L.fun/fixnum8599.8.12)
          (mset! tmp.70 6 0)
          (set! fun/fixnum8599.8 tmp.70)))
      (begin
        (set! g42859749.9 (call L.fun/fixnum8598.7.11 fun/fixnum8598.7))
        (if (begin
              (set! tmp.75 (call L.error?.64.10 error?.64 g42859749.9))
              (!= tmp.75 6))
          g42859749.9
          (begin
            (begin (set! g42859750.10 856))
            (if (begin
                  (set! tmp.76 (call L.error?.64.10 error?.64 g42859750.10))
                  (!= tmp.76 6))
              g42859750.10
              (begin
                (set! g42859751.11
                  (call L.fun/fixnum8599.8.12 fun/fixnum8599.8))
                (if (begin
                      (set! tmp.77
                        (call L.error?.64.10 error?.64 g42859751.11))
                      (!= tmp.77 6))
                  g42859751.11
                  (if (!= 14 6) 1536 120))))))))))
(check-by-interp
 '(module
    (define L.fun/fixnum8603.9.13
      (lambda (c.67)
        (begin
          (set! fun/fixnum8604.8 (mref c.67 14))
          (call L.fun/fixnum8604.8.12 fun/fixnum8604.8))))
    (define L.fun/fixnum8604.8.12 (lambda (c.66) (begin 392)))
    (define L.fun/fixnum8602.7.11
      (lambda (c.65 oprand0.10)
        (begin
          (set! fun/fixnum8603.9 (mref c.65 14))
          (call L.fun/fixnum8603.9.13 fun/fixnum8603.9))))
    (define L.cons.63.10
      (lambda (c.64 tmp.58 tmp.59)
        (begin
          (begin
            (begin (set! tmp.73 (alloc 16)) (set! tmp.68 (+ tmp.73 1)))
            (begin (mset! tmp.68 -1 tmp.58) (mset! tmp.68 7 tmp.59) tmp.68)))))
    (begin
      (begin
        (begin (set! tmp.74 (alloc 16)) (set! tmp.69 (+ tmp.74 2)))
        (begin
          (mset! tmp.69 -2 L.cons.63.10)
          (mset! tmp.69 6 16)
          (set! cons.63 tmp.69)))
      (begin
        (begin (set! tmp.75 (alloc 24)) (set! tmp.70 (+ tmp.75 2)))
        (begin
          (mset! tmp.70 -2 L.fun/fixnum8602.7.11)
          (mset! tmp.70 6 8)
          (set! fun/fixnum8602.7 tmp.70)))
      (begin
        (begin (set! tmp.76 (alloc 16)) (set! tmp.71 (+ tmp.76 2)))
        (begin
          (mset! tmp.71 -2 L.fun/fixnum8604.8.12)
          (mset! tmp.71 6 0)
          (set! fun/fixnum8604.8 tmp.71)))
      (begin
        (begin (set! tmp.77 (alloc 24)) (set! tmp.72 (+ tmp.77 2)))
        (begin
          (mset! tmp.72 -2 L.fun/fixnum8603.9.13)
          (mset! tmp.72 6 0)
          (set! fun/fixnum8603.9 tmp.72)))
      (begin
        (mset! fun/fixnum8602.7 14 fun/fixnum8603.9)
        (mset! fun/fixnum8603.9 14 fun/fixnum8604.8)
        (begin
          (if (!= 14 6)
            (begin
              (set! tmp.79 (call L.cons.63.10 cons.63 2800 22))
              (set! tmp.78 (call L.cons.63.10 cons.63 1128 tmp.79)))
            (begin
              (set! tmp.80 (call L.cons.63.10 cons.63 2128 22))
              (set! tmp.78 (call L.cons.63.10 cons.63 1856 tmp.80))))
          (call L.fun/fixnum8602.7.11 fun/fixnum8602.7 tmp.78))))))
(check-by-interp
 '(module
    (define L.fun/error8607.16.13
      (lambda (c.85 oprand0.17) (begin oprand0.17)))
    (define L.fun/error8608.15.12 (lambda (c.84) (begin 39742)))
    (define L.fun/error8609.14.11 (lambda (c.83) (begin 11070)))
    (define L.error?.81.10
      (lambda (c.82 tmp.71)
        (begin
          (if (begin (set! tmp.90 (bitwise-and tmp.71 255)) (= tmp.90 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.91 (alloc 16)) (set! tmp.86 (+ tmp.91 2)))
        (begin
          (mset! tmp.86 -2 L.error?.81.10)
          (mset! tmp.86 6 8)
          (set! error?.81 tmp.86)))
      (begin
        (begin (set! tmp.92 (alloc 16)) (set! tmp.87 (+ tmp.92 2)))
        (begin
          (mset! tmp.87 -2 L.fun/error8609.14.11)
          (mset! tmp.87 6 0)
          (set! fun/error8609.14 tmp.87)))
      (begin
        (begin (set! tmp.93 (alloc 16)) (set! tmp.88 (+ tmp.93 2)))
        (begin
          (mset! tmp.88 -2 L.fun/error8608.15.12)
          (mset! tmp.88 6 0)
          (set! fun/error8608.15 tmp.88)))
      (begin
        (begin (set! tmp.94 (alloc 16)) (set! tmp.89 (+ tmp.94 2)))
        (begin
          (mset! tmp.89 -2 L.fun/error8607.16.13)
          (mset! tmp.89 6 8)
          (set! fun/error8607.16 tmp.89)))
      (begin
        (begin
          (set! tmp.8.19 (call L.fun/error8607.16.13 fun/error8607.16 56638))
          (if (!= tmp.8.19 6)
            (set! tmp.7.18 tmp.8.19)
            (begin
              (set! tmp.9.20 (call L.fun/error8608.15.12 fun/error8608.15))
              (if (!= tmp.9.20 6)
                (set! tmp.7.18 tmp.9.20)
                (begin
                  (if (!= 9534 6)
                    (if (!= 10814 6)
                      (if (!= 25150 6)
                        (if (!= 318 6)
                          (if (!= 42302 6)
                            (set! tmp.10.21 38462)
                            (set! tmp.10.21 6))
                          (set! tmp.10.21 6))
                        (set! tmp.10.21 6))
                      (set! tmp.10.21 6))
                    (set! tmp.10.21 6))
                  (if (!= tmp.10.21 6)
                    (set! tmp.7.18 tmp.10.21)
                    (begin
                      (if (!= 6 6)
                        (set! tmp.11.22 23358)
                        (set! tmp.11.22 11070))
                      (if (!= tmp.11.22 6)
                        (set! tmp.7.18 tmp.11.22)
                        (begin
                          (begin
                            (set! g42867385.24 43838)
                            (if (begin
                                  (set! tmp.95
                                    (call
                                     L.error?.81.10
                                     error?.81
                                     g42867385.24))
                                  (!= tmp.95 6))
                              (set! tmp.12.23 g42867385.24)
                              (begin
                                (set! g42867386.25 39230)
                                (if (begin
                                      (set! tmp.96
                                        (call
                                         L.error?.81.10
                                         error?.81
                                         g42867386.25))
                                      (!= tmp.96 6))
                                  (set! tmp.12.23 g42867386.25)
                                  (begin
                                    (set! g42867387.26 28478)
                                    (if (begin
                                          (set! tmp.97
                                            (call
                                             L.error?.81.10
                                             error?.81
                                             g42867387.26))
                                          (!= tmp.97 6))
                                      (set! tmp.12.23 g42867387.26)
                                      (begin
                                        (set! g42867388.27 52798)
                                        (if (begin
                                              (set! tmp.98
                                                (call
                                                 L.error?.81.10
                                                 error?.81
                                                 g42867388.27))
                                              (!= tmp.98 6))
                                          (set! tmp.12.23 g42867388.27)
                                          (set! tmp.12.23 44350)))))))))
                          (if (!= tmp.12.23 6)
                            (set! tmp.7.18 tmp.12.23)
                            (set! tmp.7.18
                              (call
                               L.fun/error8609.14.11
                               fun/error8609.14))))))))))))
        (if (!= tmp.7.18 6)
          tmp.7.18
          (begin
            (if (!= 14 6) (set! tmp.13.28 63806) (set! tmp.13.28 16958))
            (if (!= tmp.13.28 6) tmp.13.28 (begin 42302))))))))
(check-by-interp
 '(module
    (define L.fun/fixnum8613.9.12
      (lambda (c.64)
        (begin
          (set! fun/fixnum8614.8 (mref c.64 14))
          (call L.fun/fixnum8614.8.11 fun/fixnum8614.8))))
    (define L.fun/fixnum8614.8.11 (lambda (c.63) (begin 368)))
    (define L.fun/fixnum8612.7.10
      (lambda (c.62)
        (begin
          (set! fun/fixnum8613.9 (mref c.62 14))
          (call L.fun/fixnum8613.9.12 fun/fixnum8613.9))))
    (begin
      (begin
        (begin (set! tmp.68 (alloc 24)) (set! tmp.65 (+ tmp.68 2)))
        (begin
          (mset! tmp.65 -2 L.fun/fixnum8612.7.10)
          (mset! tmp.65 6 0)
          (set! fun/fixnum8612.7 tmp.65)))
      (begin
        (begin (set! tmp.69 (alloc 16)) (set! tmp.66 (+ tmp.69 2)))
        (begin
          (mset! tmp.66 -2 L.fun/fixnum8614.8.11)
          (mset! tmp.66 6 0)
          (set! fun/fixnum8614.8 tmp.66)))
      (begin
        (begin (set! tmp.70 (alloc 24)) (set! tmp.67 (+ tmp.70 2)))
        (begin
          (mset! tmp.67 -2 L.fun/fixnum8613.9.12)
          (mset! tmp.67 6 0)
          (set! fun/fixnum8613.9 tmp.67)))
      (begin
        (mset! fun/fixnum8612.7 14 fun/fixnum8613.9)
        (mset! fun/fixnum8613.9 14 fun/fixnum8614.8)
        (call L.fun/fixnum8612.7.10 fun/fixnum8612.7)))))
(check-by-interp '(module (if (!= 6 6) 1152 1320)))
(check-by-interp
 '(module
    (if (if (!= 14 6) (!= 6 6) (!= 6 6))
      (if (!= 14 6) 30 30)
      (begin (set! tmp.7.8 30) (if (!= tmp.7.8 6) tmp.7.8 30)))))
(check-by-interp
 '(module
    (if (if (!= 6 6) (!= 14 6) (!= 14 6))
      (begin (set! tmp.7.8 23342) (if (!= tmp.7.8 6) tmp.7.8 17966))
      (if (!= 6 6) 18478 16942))))
(check-by-interp '(module (begin (if (!= 14 6) 22 22))))
(check-by-interp
 '(module
    (define L.lam.109.19
      (lambda (c.119)
        (begin
          (set! vector-set!.106 (mref c.119 14))
          (set! error?.107 (mref c.119 22))
          (set! make-vector.105 (mref c.119 30))
          (begin
            (set! tmp.13.44 (call L.make-vector.105.15 make-vector.105 64))
            (begin
              (set! g42890291.45
                (call L.vector-set!.106.12 vector-set!.106 tmp.13.44 0 8))
              (if (begin
                    (set! tmp.131
                      (call L.error?.107.10 error?.107 g42890291.45))
                    (!= tmp.131 6))
                g42890291.45
                (begin
                  (set! g42890292.46
                    (call L.vector-set!.106.12 vector-set!.106 tmp.13.44 8 16))
                  (if (begin
                        (set! tmp.132
                          (call L.error?.107.10 error?.107 g42890292.46))
                        (!= tmp.132 6))
                    g42890292.46
                    (begin
                      (set! g42890293.47
                        (call
                         L.vector-set!.106.12
                         vector-set!.106
                         tmp.13.44
                         16
                         24))
                      (if (begin
                            (set! tmp.133
                              (call L.error?.107.10 error?.107 g42890293.47))
                            (!= tmp.133 6))
                        g42890293.47
                        (begin
                          (set! g42890294.48
                            (call
                             L.vector-set!.106.12
                             vector-set!.106
                             tmp.13.44
                             24
                             32))
                          (if (begin
                                (set! tmp.134
                                  (call
                                   L.error?.107.10
                                   error?.107
                                   g42890294.48))
                                (!= tmp.134 6))
                            g42890294.48
                            (begin
                              (set! g42890295.49
                                (call
                                 L.vector-set!.106.12
                                 vector-set!.106
                                 tmp.13.44
                                 32
                                 40))
                              (if (begin
                                    (set! tmp.135
                                      (call
                                       L.error?.107.10
                                       error?.107
                                       g42890295.49))
                                    (!= tmp.135 6))
                                g42890295.49
                                (begin
                                  (set! g42890296.50
                                    (call
                                     L.vector-set!.106.12
                                     vector-set!.106
                                     tmp.13.44
                                     40
                                     48))
                                  (if (begin
                                        (set! tmp.136
                                          (call
                                           L.error?.107.10
                                           error?.107
                                           g42890296.50))
                                        (!= tmp.136 6))
                                    g42890296.50
                                    (begin
                                      (set! g42890297.51
                                        (call
                                         L.vector-set!.106.12
                                         vector-set!.106
                                         tmp.13.44
                                         48
                                         56))
                                      (if (begin
                                            (set! tmp.137
                                              (call
                                               L.error?.107.10
                                               error?.107
                                               g42890297.51))
                                            (!= tmp.137 6))
                                        g42890297.51
                                        (begin
                                          (set! g42890298.52
                                            (call
                                             L.vector-set!.106.12
                                             vector-set!.106
                                             tmp.13.44
                                             56
                                             64))
                                          (if (begin
                                                (set! tmp.138
                                                  (call
                                                   L.error?.107.10
                                                   error?.107
                                                   g42890298.52))
                                                (!= tmp.138 6))
                                            g42890298.52
                                            tmp.13.44))))))))))))))))))))
    (define L.lam.108.18
      (lambda (c.118)
        (begin
          (set! vector-set!.106 (mref c.118 14))
          (set! error?.107 (mref c.118 22))
          (set! make-vector.105 (mref c.118 30))
          (begin
            (set! tmp.12.33 (call L.make-vector.105.15 make-vector.105 64))
            (begin
              (set! g42890283.34
                (call L.vector-set!.106.12 vector-set!.106 tmp.12.33 0 0))
              (if (begin
                    (set! tmp.139
                      (call L.error?.107.10 error?.107 g42890283.34))
                    (!= tmp.139 6))
                g42890283.34
                (begin
                  (set! g42890284.35
                    (call L.vector-set!.106.12 vector-set!.106 tmp.12.33 8 8))
                  (if (begin
                        (set! tmp.140
                          (call L.error?.107.10 error?.107 g42890284.35))
                        (!= tmp.140 6))
                    g42890284.35
                    (begin
                      (set! g42890285.36
                        (call
                         L.vector-set!.106.12
                         vector-set!.106
                         tmp.12.33
                         16
                         16))
                      (if (begin
                            (set! tmp.141
                              (call L.error?.107.10 error?.107 g42890285.36))
                            (!= tmp.141 6))
                        g42890285.36
                        (begin
                          (set! g42890286.37
                            (call
                             L.vector-set!.106.12
                             vector-set!.106
                             tmp.12.33
                             24
                             24))
                          (if (begin
                                (set! tmp.142
                                  (call
                                   L.error?.107.10
                                   error?.107
                                   g42890286.37))
                                (!= tmp.142 6))
                            g42890286.37
                            (begin
                              (set! g42890287.38
                                (call
                                 L.vector-set!.106.12
                                 vector-set!.106
                                 tmp.12.33
                                 32
                                 32))
                              (if (begin
                                    (set! tmp.143
                                      (call
                                       L.error?.107.10
                                       error?.107
                                       g42890287.38))
                                    (!= tmp.143 6))
                                g42890287.38
                                (begin
                                  (set! g42890288.39
                                    (call
                                     L.vector-set!.106.12
                                     vector-set!.106
                                     tmp.12.33
                                     40
                                     40))
                                  (if (begin
                                        (set! tmp.144
                                          (call
                                           L.error?.107.10
                                           error?.107
                                           g42890288.39))
                                        (!= tmp.144 6))
                                    g42890288.39
                                    (begin
                                      (set! g42890289.40
                                        (call
                                         L.vector-set!.106.12
                                         vector-set!.106
                                         tmp.12.33
                                         48
                                         48))
                                      (if (begin
                                            (set! tmp.145
                                              (call
                                               L.error?.107.10
                                               error?.107
                                               g42890289.40))
                                            (!= tmp.145 6))
                                        g42890289.40
                                        (begin
                                          (set! g42890290.41
                                            (call
                                             L.vector-set!.106.12
                                             vector-set!.106
                                             tmp.12.33
                                             56
                                             56))
                                          (if (begin
                                                (set! tmp.146
                                                  (call
                                                   L.error?.107.10
                                                   error?.107
                                                   g42890290.41))
                                                (!= tmp.146 6))
                                            g42890290.41
                                            tmp.12.33))))))))))))))))))))
    (define L.fun/boolean8625.15.17
      (lambda (c.117 oprand0.17) (begin (if (!= 14 6) 14 6))))
    (define L.fun/boolean8626.14.16 (lambda (c.116 oprand0.16) (begin 6)))
    (define L.make-vector.105.15
      (lambda (c.115 tmp.81)
        (begin
          (set! make-init-vector.4 (mref c.115 14))
          (if (begin
                (if (begin (set! tmp.148 (bitwise-and tmp.81 7)) (= tmp.148 0))
                  (set! tmp.147 14)
                  (set! tmp.147 6))
                (!= tmp.147 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.81)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.114 tmp.53)
        (begin
          (set! vector-init-loop.55 (mref c.114 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.152 (arithmetic-shift-right tmp.53 3))
                      (set! tmp.151 (+ 1 tmp.152)))
                    (set! tmp.150 (* tmp.151 8)))
                  (set! tmp.149 (alloc tmp.150)))
                (set! tmp.120 (+ tmp.149 3)))
              (begin (mset! tmp.120 -3 tmp.53) (set! tmp.54 tmp.120)))
            (call
             L.vector-init-loop.55.13
             vector-init-loop.55
             tmp.53
             0
             tmp.54)))))
    (define L.vector-init-loop.55.13
      (lambda (c.113 len.56 i.58 vec.57)
        (begin
          (set! vector-init-loop.55 (mref c.113 14))
          (if (begin
                (if (= len.56 i.58) (set! tmp.153 14) (set! tmp.153 6))
                (!= tmp.153 6))
            vec.57
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.156 (arithmetic-shift-right i.58 3))
                    (set! tmp.155 (* tmp.156 8)))
                  (set! tmp.154 (+ tmp.155 5)))
                (mset! vec.57 tmp.154 0))
              (begin
                (set! tmp.157 (+ i.58 8))
                (call
                 L.vector-init-loop.55.13
                 vector-init-loop.55
                 len.56
                 tmp.157
                 vec.57)))))))
    (define L.vector-set!.106.12
      (lambda (c.112 tmp.83 tmp.84 tmp.85)
        (begin
          (set! unsafe-vector-set!.5 (mref c.112 14))
          (if (begin
                (if (begin (set! tmp.159 (bitwise-and tmp.84 7)) (= tmp.159 0))
                  (set! tmp.158 14)
                  (set! tmp.158 6))
                (!= tmp.158 6))
            (if (begin
                  (if (begin
                        (set! tmp.161 (bitwise-and tmp.83 7))
                        (= tmp.161 3))
                    (set! tmp.160 14)
                    (set! tmp.160 6))
                  (!= tmp.160 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.83
               tmp.84
               tmp.85)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.111 tmp.59 tmp.60 tmp.61)
        (begin
          (if (begin
                (if (begin (set! tmp.163 (mref tmp.59 -3)) (< tmp.60 tmp.163))
                  (set! tmp.162 14)
                  (set! tmp.162 6))
                (!= tmp.162 6))
            (if (begin
                  (if (>= tmp.60 0) (set! tmp.164 14) (set! tmp.164 6))
                  (!= tmp.164 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.167 (arithmetic-shift-right tmp.60 3))
                      (set! tmp.166 (* tmp.167 8)))
                    (set! tmp.165 (+ tmp.166 5)))
                  (mset! tmp.59 tmp.165 tmp.61))
                30)
              2622)
            2622))))
    (define L.error?.107.10
      (lambda (c.110 tmp.95)
        (begin
          (if (begin (set! tmp.168 (bitwise-and tmp.95 255)) (= tmp.168 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.169 (alloc 16)) (set! tmp.121 (+ tmp.169 2)))
        (begin
          (mset! tmp.121 -2 L.error?.107.10)
          (mset! tmp.121 6 8)
          (set! error?.107 tmp.121)))
      (begin
        (begin (set! tmp.170 (alloc 16)) (set! tmp.122 (+ tmp.170 2)))
        (begin
          (mset! tmp.122 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.122 6 24)
          (set! unsafe-vector-set!.5 tmp.122)))
      (begin
        (begin (set! tmp.171 (alloc 24)) (set! tmp.123 (+ tmp.171 2)))
        (begin
          (mset! tmp.123 -2 L.vector-set!.106.12)
          (mset! tmp.123 6 24)
          (set! vector-set!.106 tmp.123)))
      (begin
        (begin (set! tmp.172 (alloc 24)) (set! tmp.124 (+ tmp.172 2)))
        (begin
          (mset! tmp.124 -2 L.vector-init-loop.55.13)
          (mset! tmp.124 6 24)
          (set! vector-init-loop.55 tmp.124)))
      (begin
        (begin (set! tmp.173 (alloc 24)) (set! tmp.125 (+ tmp.173 2)))
        (begin
          (mset! tmp.125 -2 L.make-init-vector.4.14)
          (mset! tmp.125 6 8)
          (set! make-init-vector.4 tmp.125)))
      (begin
        (begin (set! tmp.174 (alloc 24)) (set! tmp.126 (+ tmp.174 2)))
        (begin
          (mset! tmp.126 -2 L.make-vector.105.15)
          (mset! tmp.126 6 8)
          (set! make-vector.105 tmp.126)))
      (begin
        (begin (set! tmp.175 (alloc 16)) (set! tmp.127 (+ tmp.175 2)))
        (begin
          (mset! tmp.127 -2 L.fun/boolean8626.14.16)
          (mset! tmp.127 6 8)
          (set! fun/boolean8626.14 tmp.127)))
      (begin
        (begin (set! tmp.176 (alloc 16)) (set! tmp.128 (+ tmp.176 2)))
        (begin
          (mset! tmp.128 -2 L.fun/boolean8625.15.17)
          (mset! tmp.128 6 8)
          (set! fun/boolean8625.15 tmp.128)))
      (begin
        (mset! vector-set!.106 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.55 14 vector-init-loop.55)
        (mset! make-init-vector.4 14 vector-init-loop.55)
        (mset! make-vector.105 14 make-init-vector.4)
        (begin
          (begin
            (if (!= 6 6) (set! tmp.7.18 6) (set! tmp.7.18 6))
            (if (!= tmp.7.18 6)
              (set! tmp.177 tmp.7.18)
              (begin
                (if (!= 6 6) (set! tmp.8.19 6) (set! tmp.8.19 14))
                (if (!= tmp.8.19 6)
                  (set! tmp.177 tmp.8.19)
                  (begin
                    (begin
                      (begin
                        (set! tmp.10.21
                          (call L.make-vector.105.15 make-vector.105 64))
                        (begin
                          (set! g42890275.22
                            (call
                             L.vector-set!.106.12
                             vector-set!.106
                             tmp.10.21
                             0
                             0))
                          (if (begin
                                (set! tmp.179
                                  (call
                                   L.error?.107.10
                                   error?.107
                                   g42890275.22))
                                (!= tmp.179 6))
                            (set! tmp.178 g42890275.22)
                            (begin
                              (set! g42890276.23
                                (call
                                 L.vector-set!.106.12
                                 vector-set!.106
                                 tmp.10.21
                                 8
                                 8))
                              (if (begin
                                    (set! tmp.180
                                      (call
                                       L.error?.107.10
                                       error?.107
                                       g42890276.23))
                                    (!= tmp.180 6))
                                (set! tmp.178 g42890276.23)
                                (begin
                                  (set! g42890277.24
                                    (call
                                     L.vector-set!.106.12
                                     vector-set!.106
                                     tmp.10.21
                                     16
                                     16))
                                  (if (begin
                                        (set! tmp.181
                                          (call
                                           L.error?.107.10
                                           error?.107
                                           g42890277.24))
                                        (!= tmp.181 6))
                                    (set! tmp.178 g42890277.24)
                                    (begin
                                      (set! g42890278.25
                                        (call
                                         L.vector-set!.106.12
                                         vector-set!.106
                                         tmp.10.21
                                         24
                                         24))
                                      (if (begin
                                            (set! tmp.182
                                              (call
                                               L.error?.107.10
                                               error?.107
                                               g42890278.25))
                                            (!= tmp.182 6))
                                        (set! tmp.178 g42890278.25)
                                        (begin
                                          (set! g42890279.26
                                            (call
                                             L.vector-set!.106.12
                                             vector-set!.106
                                             tmp.10.21
                                             32
                                             32))
                                          (if (begin
                                                (set! tmp.183
                                                  (call
                                                   L.error?.107.10
                                                   error?.107
                                                   g42890279.26))
                                                (!= tmp.183 6))
                                            (set! tmp.178 g42890279.26)
                                            (begin
                                              (set! g42890280.27
                                                (call
                                                 L.vector-set!.106.12
                                                 vector-set!.106
                                                 tmp.10.21
                                                 40
                                                 40))
                                              (if (begin
                                                    (set! tmp.184
                                                      (call
                                                       L.error?.107.10
                                                       error?.107
                                                       g42890280.27))
                                                    (!= tmp.184 6))
                                                (set! tmp.178 g42890280.27)
                                                (begin
                                                  (set! g42890281.28
                                                    (call
                                                     L.vector-set!.106.12
                                                     vector-set!.106
                                                     tmp.10.21
                                                     48
                                                     48))
                                                  (if (begin
                                                        (set! tmp.185
                                                          (call
                                                           L.error?.107.10
                                                           error?.107
                                                           g42890281.28))
                                                        (!= tmp.185 6))
                                                    (set! tmp.178 g42890281.28)
                                                    (begin
                                                      (set! g42890282.29
                                                        (call
                                                         L.vector-set!.106.12
                                                         vector-set!.106
                                                         tmp.10.21
                                                         56
                                                         56))
                                                      (if (begin
                                                            (set! tmp.186
                                                              (call
                                                               L.error?.107.10
                                                               error?.107
                                                               g42890282.29))
                                                            (!= tmp.186 6))
                                                        (set! tmp.178
                                                          g42890282.29)
                                                        (set! tmp.178
                                                          tmp.10.21))))))))))))))))))
                      (set! tmp.9.20
                        (call
                         L.fun/boolean8626.14.16
                         fun/boolean8626.14
                         tmp.178)))
                    (if (!= tmp.9.20 6)
                      (set! tmp.177 tmp.9.20)
                      (begin
                        (begin
                          (begin
                            (begin
                              (begin
                                (set! tmp.187 (alloc 40))
                                (set! tmp.129 (+ tmp.187 2)))
                              (begin
                                (mset! tmp.129 -2 L.lam.108.18)
                                (mset! tmp.129 6 0)
                                (set! lam.108 tmp.129)))
                            (begin
                              (mset! lam.108 14 vector-set!.106)
                              (mset! lam.108 22 error?.107)
                              (mset! lam.108 30 make-vector.105)
                              (set! procedure0.32 lam.108)))
                          (set! vector1.31
                            (call L.make-vector.105.15 make-vector.105 64))
                          (set! tmp.11.30 14))
                        (if (!= tmp.11.30 6)
                          (set! tmp.177 tmp.11.30)
                          (begin
                            (set! ascii-char0.43 16942)
                            (begin
                              (begin
                                (begin
                                  (set! tmp.188 (alloc 40))
                                  (set! tmp.130 (+ tmp.188 2)))
                                (begin
                                  (mset! tmp.130 -2 L.lam.109.19)
                                  (mset! tmp.130 6 0)
                                  (set! lam.109 tmp.130)))
                              (begin
                                (mset! lam.109 14 vector-set!.106)
                                (mset! lam.109 22 error?.107)
                                (mset! lam.109 30 make-vector.105)
                                (set! procedure1.42 lam.109)))
                            (set! tmp.177 14))))))))))
          (call L.fun/boolean8625.15.17 fun/boolean8625.15 tmp.177))))))
(check-by-interp '(module (begin (begin (set! void0.7 30) 30))))
(check-by-interp
 '(module
    (define L.fun/empty8631.7.11
      (lambda (c.64 oprand0.8) (begin (if (!= 14 6) 22 22))))
    (define L.cons.62.10
      (lambda (c.63 tmp.57 tmp.58)
        (begin
          (begin
            (begin (set! tmp.68 (alloc 16)) (set! tmp.65 (+ tmp.68 1)))
            (begin (mset! tmp.65 -1 tmp.57) (mset! tmp.65 7 tmp.58) tmp.65)))))
    (begin
      (begin
        (begin (set! tmp.69 (alloc 16)) (set! tmp.66 (+ tmp.69 2)))
        (begin
          (mset! tmp.66 -2 L.cons.62.10)
          (mset! tmp.66 6 16)
          (set! cons.62 tmp.66)))
      (begin
        (begin (set! tmp.70 (alloc 16)) (set! tmp.67 (+ tmp.70 2)))
        (begin
          (mset! tmp.67 -2 L.fun/empty8631.7.11)
          (mset! tmp.67 6 8)
          (set! fun/empty8631.7 tmp.67)))
      (begin
        (begin
          (set! error0.9 44862)
          (begin
            (set! tmp.72 (call L.cons.62.10 cons.62 3440 22))
            (set! tmp.71 (call L.cons.62.10 cons.62 1496 tmp.72))))
        (call L.fun/empty8631.7.11 fun/empty8631.7 tmp.71)))))
(check-by-interp
 '(module
    (define L.fun/empty8634.7.10 (lambda (c.60) (begin (if (!= 14 6) 22 22))))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/empty8634.7.10)
          (mset! tmp.61 6 0)
          (set! fun/empty8634.7 tmp.61)))
      (call L.fun/empty8634.7.10 fun/empty8634.7))))
(check-by-interp
 '(module
    (define L.lam.77.19
      (lambda (c.87)
        (begin
          (set! fun/vector8638.8 (mref c.87 14))
          (call L.fun/vector8638.8.16 fun/vector8638.8))))
    (define L.fun/fixnum8639.10.18 (lambda (c.86) (begin 184)))
    (define L.fun/void8637.9.17 (lambda (c.85) (begin 30)))
    (define L.fun/vector8638.8.16
      (lambda (c.84)
        (begin
          (set! vector-set!.75 (mref c.84 14))
          (set! error?.76 (mref c.84 22))
          (set! make-vector.74 (mref c.84 30))
          (begin
            (set! tmp.7.11 (call L.make-vector.74.15 make-vector.74 64))
            (begin
              (set! g42905563.12
                (call L.vector-set!.75.12 vector-set!.75 tmp.7.11 0 0))
              (if (begin
                    (set! tmp.99 (call L.error?.76.10 error?.76 g42905563.12))
                    (!= tmp.99 6))
                g42905563.12
                (begin
                  (set! g42905564.13
                    (call L.vector-set!.75.12 vector-set!.75 tmp.7.11 8 8))
                  (if (begin
                        (set! tmp.100
                          (call L.error?.76.10 error?.76 g42905564.13))
                        (!= tmp.100 6))
                    g42905564.13
                    (begin
                      (set! g42905565.14
                        (call
                         L.vector-set!.75.12
                         vector-set!.75
                         tmp.7.11
                         16
                         16))
                      (if (begin
                            (set! tmp.101
                              (call L.error?.76.10 error?.76 g42905565.14))
                            (!= tmp.101 6))
                        g42905565.14
                        (begin
                          (set! g42905566.15
                            (call
                             L.vector-set!.75.12
                             vector-set!.75
                             tmp.7.11
                             24
                             24))
                          (if (begin
                                (set! tmp.102
                                  (call L.error?.76.10 error?.76 g42905566.15))
                                (!= tmp.102 6))
                            g42905566.15
                            (begin
                              (set! g42905567.16
                                (call
                                 L.vector-set!.75.12
                                 vector-set!.75
                                 tmp.7.11
                                 32
                                 32))
                              (if (begin
                                    (set! tmp.103
                                      (call
                                       L.error?.76.10
                                       error?.76
                                       g42905567.16))
                                    (!= tmp.103 6))
                                g42905567.16
                                (begin
                                  (set! g42905568.17
                                    (call
                                     L.vector-set!.75.12
                                     vector-set!.75
                                     tmp.7.11
                                     40
                                     40))
                                  (if (begin
                                        (set! tmp.104
                                          (call
                                           L.error?.76.10
                                           error?.76
                                           g42905568.17))
                                        (!= tmp.104 6))
                                    g42905568.17
                                    (begin
                                      (set! g42905569.18
                                        (call
                                         L.vector-set!.75.12
                                         vector-set!.75
                                         tmp.7.11
                                         48
                                         48))
                                      (if (begin
                                            (set! tmp.105
                                              (call
                                               L.error?.76.10
                                               error?.76
                                               g42905569.18))
                                            (!= tmp.105 6))
                                        g42905569.18
                                        (begin
                                          (set! g42905570.19
                                            (call
                                             L.vector-set!.75.12
                                             vector-set!.75
                                             tmp.7.11
                                             56
                                             56))
                                          (if (begin
                                                (set! tmp.106
                                                  (call
                                                   L.error?.76.10
                                                   error?.76
                                                   g42905570.19))
                                                (!= tmp.106 6))
                                            g42905570.19
                                            tmp.7.11))))))))))))))))))))
    (define L.make-vector.74.15
      (lambda (c.83 tmp.50)
        (begin
          (set! make-init-vector.4 (mref c.83 14))
          (if (begin
                (if (begin (set! tmp.108 (bitwise-and tmp.50 7)) (= tmp.108 0))
                  (set! tmp.107 14)
                  (set! tmp.107 6))
                (!= tmp.107 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.50)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.82 tmp.22)
        (begin
          (set! vector-init-loop.24 (mref c.82 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.112 (arithmetic-shift-right tmp.22 3))
                      (set! tmp.111 (+ 1 tmp.112)))
                    (set! tmp.110 (* tmp.111 8)))
                  (set! tmp.109 (alloc tmp.110)))
                (set! tmp.88 (+ tmp.109 3)))
              (begin (mset! tmp.88 -3 tmp.22) (set! tmp.23 tmp.88)))
            (call
             L.vector-init-loop.24.13
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.13
      (lambda (c.81 len.25 i.27 vec.26)
        (begin
          (set! vector-init-loop.24 (mref c.81 14))
          (if (begin
                (if (= len.25 i.27) (set! tmp.113 14) (set! tmp.113 6))
                (!= tmp.113 6))
            vec.26
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.116 (arithmetic-shift-right i.27 3))
                    (set! tmp.115 (* tmp.116 8)))
                  (set! tmp.114 (+ tmp.115 5)))
                (mset! vec.26 tmp.114 0))
              (begin
                (set! tmp.117 (+ i.27 8))
                (call
                 L.vector-init-loop.24.13
                 vector-init-loop.24
                 len.25
                 tmp.117
                 vec.26)))))))
    (define L.vector-set!.75.12
      (lambda (c.80 tmp.52 tmp.53 tmp.54)
        (begin
          (set! unsafe-vector-set!.5 (mref c.80 14))
          (if (begin
                (if (begin (set! tmp.119 (bitwise-and tmp.53 7)) (= tmp.119 0))
                  (set! tmp.118 14)
                  (set! tmp.118 6))
                (!= tmp.118 6))
            (if (begin
                  (if (begin
                        (set! tmp.121 (bitwise-and tmp.52 7))
                        (= tmp.121 3))
                    (set! tmp.120 14)
                    (set! tmp.120 6))
                  (!= tmp.120 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.52
               tmp.53
               tmp.54)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.79 tmp.28 tmp.29 tmp.30)
        (begin
          (if (begin
                (if (begin (set! tmp.123 (mref tmp.28 -3)) (< tmp.29 tmp.123))
                  (set! tmp.122 14)
                  (set! tmp.122 6))
                (!= tmp.122 6))
            (if (begin
                  (if (>= tmp.29 0) (set! tmp.124 14) (set! tmp.124 6))
                  (!= tmp.124 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.127 (arithmetic-shift-right tmp.29 3))
                      (set! tmp.126 (* tmp.127 8)))
                    (set! tmp.125 (+ tmp.126 5)))
                  (mset! tmp.28 tmp.125 tmp.30))
                30)
              2622)
            2622))))
    (define L.error?.76.10
      (lambda (c.78 tmp.64)
        (begin
          (if (begin (set! tmp.128 (bitwise-and tmp.64 255)) (= tmp.128 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.129 (alloc 16)) (set! tmp.89 (+ tmp.129 2)))
        (begin
          (mset! tmp.89 -2 L.error?.76.10)
          (mset! tmp.89 6 8)
          (set! error?.76 tmp.89)))
      (begin
        (begin (set! tmp.130 (alloc 16)) (set! tmp.90 (+ tmp.130 2)))
        (begin
          (mset! tmp.90 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.90 6 24)
          (set! unsafe-vector-set!.5 tmp.90)))
      (begin
        (begin (set! tmp.131 (alloc 24)) (set! tmp.91 (+ tmp.131 2)))
        (begin
          (mset! tmp.91 -2 L.vector-set!.75.12)
          (mset! tmp.91 6 24)
          (set! vector-set!.75 tmp.91)))
      (begin
        (begin (set! tmp.132 (alloc 24)) (set! tmp.92 (+ tmp.132 2)))
        (begin
          (mset! tmp.92 -2 L.vector-init-loop.24.13)
          (mset! tmp.92 6 24)
          (set! vector-init-loop.24 tmp.92)))
      (begin
        (begin (set! tmp.133 (alloc 24)) (set! tmp.93 (+ tmp.133 2)))
        (begin
          (mset! tmp.93 -2 L.make-init-vector.4.14)
          (mset! tmp.93 6 8)
          (set! make-init-vector.4 tmp.93)))
      (begin
        (begin (set! tmp.134 (alloc 24)) (set! tmp.94 (+ tmp.134 2)))
        (begin
          (mset! tmp.94 -2 L.make-vector.74.15)
          (mset! tmp.94 6 8)
          (set! make-vector.74 tmp.94)))
      (begin
        (begin (set! tmp.135 (alloc 40)) (set! tmp.95 (+ tmp.135 2)))
        (begin
          (mset! tmp.95 -2 L.fun/vector8638.8.16)
          (mset! tmp.95 6 0)
          (set! fun/vector8638.8 tmp.95)))
      (begin
        (begin (set! tmp.136 (alloc 16)) (set! tmp.96 (+ tmp.136 2)))
        (begin
          (mset! tmp.96 -2 L.fun/void8637.9.17)
          (mset! tmp.96 6 0)
          (set! fun/void8637.9 tmp.96)))
      (begin
        (begin (set! tmp.137 (alloc 16)) (set! tmp.97 (+ tmp.137 2)))
        (begin
          (mset! tmp.97 -2 L.fun/fixnum8639.10.18)
          (mset! tmp.97 6 0)
          (set! fun/fixnum8639.10 tmp.97)))
      (begin
        (mset! vector-set!.75 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.4 14 vector-init-loop.24)
        (mset! make-vector.74 14 make-init-vector.4)
        (mset! fun/vector8638.8 14 vector-set!.75)
        (mset! fun/vector8638.8 22 error?.76)
        (mset! fun/vector8638.8 30 make-vector.74)
        (begin
          (set! void0.21 (call L.fun/void8637.9.17 fun/void8637.9))
          (begin
            (begin
              (begin (set! tmp.138 (alloc 24)) (set! tmp.98 (+ tmp.138 2)))
              (begin
                (mset! tmp.98 -2 L.lam.77.19)
                (mset! tmp.98 6 0)
                (set! lam.77 tmp.98)))
            (begin
              (mset! lam.77 14 fun/vector8638.8)
              (set! procedure1.20 lam.77)))
          (call L.fun/fixnum8639.10.18 fun/fixnum8639.10))))))
(check-by-interp
 '(module
    (define L.fun/fixnum8642.7.10 (lambda (c.60) (begin 1368)))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/fixnum8642.7.10)
          (mset! tmp.61 6 0)
          (set! fun/fixnum8642.7 tmp.61)))
      (if (begin (!= 6 6))
        (if (!= 6 6) 1256 832)
        (call L.fun/fixnum8642.7.10 fun/fixnum8642.7)))))
(check-by-interp
 '(module
    (define L.lam.74.16 (lambda (c.81) (begin 7424)))
    (define L.make-vector.71.15
      (lambda (c.80 tmp.47)
        (begin
          (set! make-init-vector.4 (mref c.80 14))
          (if (begin
                (if (begin (set! tmp.91 (bitwise-and tmp.47 7)) (= tmp.91 0))
                  (set! tmp.90 14)
                  (set! tmp.90 6))
                (!= tmp.90 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.47)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.79 tmp.19)
        (begin
          (set! vector-init-loop.21 (mref c.79 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.95 (arithmetic-shift-right tmp.19 3))
                      (set! tmp.94 (+ 1 tmp.95)))
                    (set! tmp.93 (* tmp.94 8)))
                  (set! tmp.92 (alloc tmp.93)))
                (set! tmp.82 (+ tmp.92 3)))
              (begin (mset! tmp.82 -3 tmp.19) (set! tmp.20 tmp.82)))
            (call
             L.vector-init-loop.21.13
             vector-init-loop.21
             tmp.19
             0
             tmp.20)))))
    (define L.vector-init-loop.21.13
      (lambda (c.78 len.22 i.24 vec.23)
        (begin
          (set! vector-init-loop.21 (mref c.78 14))
          (if (begin
                (if (= len.22 i.24) (set! tmp.96 14) (set! tmp.96 6))
                (!= tmp.96 6))
            vec.23
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.99 (arithmetic-shift-right i.24 3))
                    (set! tmp.98 (* tmp.99 8)))
                  (set! tmp.97 (+ tmp.98 5)))
                (mset! vec.23 tmp.97 0))
              (begin
                (set! tmp.100 (+ i.24 8))
                (call
                 L.vector-init-loop.21.13
                 vector-init-loop.21
                 len.22
                 tmp.100
                 vec.23)))))))
    (define L.vector-set!.72.12
      (lambda (c.77 tmp.49 tmp.50 tmp.51)
        (begin
          (set! unsafe-vector-set!.5 (mref c.77 14))
          (if (begin
                (if (begin (set! tmp.102 (bitwise-and tmp.50 7)) (= tmp.102 0))
                  (set! tmp.101 14)
                  (set! tmp.101 6))
                (!= tmp.101 6))
            (if (begin
                  (if (begin
                        (set! tmp.104 (bitwise-and tmp.49 7))
                        (= tmp.104 3))
                    (set! tmp.103 14)
                    (set! tmp.103 6))
                  (!= tmp.103 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.49
               tmp.50
               tmp.51)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.76 tmp.25 tmp.26 tmp.27)
        (begin
          (if (begin
                (if (begin (set! tmp.106 (mref tmp.25 -3)) (< tmp.26 tmp.106))
                  (set! tmp.105 14)
                  (set! tmp.105 6))
                (!= tmp.105 6))
            (if (begin
                  (if (>= tmp.26 0) (set! tmp.107 14) (set! tmp.107 6))
                  (!= tmp.107 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.110 (arithmetic-shift-right tmp.26 3))
                      (set! tmp.109 (* tmp.110 8)))
                    (set! tmp.108 (+ tmp.109 5)))
                  (mset! tmp.25 tmp.108 tmp.27))
                30)
              2622)
            2622))))
    (define L.error?.73.10
      (lambda (c.75 tmp.61)
        (begin
          (if (begin (set! tmp.111 (bitwise-and tmp.61 255)) (= tmp.111 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.112 (alloc 16)) (set! tmp.83 (+ tmp.112 2)))
        (begin
          (mset! tmp.83 -2 L.error?.73.10)
          (mset! tmp.83 6 8)
          (set! error?.73 tmp.83)))
      (begin
        (begin (set! tmp.113 (alloc 16)) (set! tmp.84 (+ tmp.113 2)))
        (begin
          (mset! tmp.84 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.84 6 24)
          (set! unsafe-vector-set!.5 tmp.84)))
      (begin
        (begin (set! tmp.114 (alloc 24)) (set! tmp.85 (+ tmp.114 2)))
        (begin
          (mset! tmp.85 -2 L.vector-set!.72.12)
          (mset! tmp.85 6 24)
          (set! vector-set!.72 tmp.85)))
      (begin
        (begin (set! tmp.115 (alloc 24)) (set! tmp.86 (+ tmp.115 2)))
        (begin
          (mset! tmp.86 -2 L.vector-init-loop.21.13)
          (mset! tmp.86 6 24)
          (set! vector-init-loop.21 tmp.86)))
      (begin
        (begin (set! tmp.116 (alloc 24)) (set! tmp.87 (+ tmp.116 2)))
        (begin
          (mset! tmp.87 -2 L.make-init-vector.4.14)
          (mset! tmp.87 6 8)
          (set! make-init-vector.4 tmp.87)))
      (begin
        (begin (set! tmp.117 (alloc 24)) (set! tmp.88 (+ tmp.117 2)))
        (begin
          (mset! tmp.88 -2 L.make-vector.71.15)
          (mset! tmp.88 6 8)
          (set! make-vector.71 tmp.88)))
      (begin
        (mset! vector-set!.72 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.21 14 vector-init-loop.21)
        (mset! make-init-vector.4 14 vector-init-loop.21)
        (mset! make-vector.71 14 make-init-vector.4)
        (begin
          (begin
            (set! tmp.7.9 (call L.make-vector.71.15 make-vector.71 64))
            (begin
              (set! g42913205.10
                (call L.vector-set!.72.12 vector-set!.72 tmp.7.9 0 896))
              (if (begin
                    (set! tmp.118 (call L.error?.73.10 error?.73 g42913205.10))
                    (!= tmp.118 6))
                (set! vector0.8 g42913205.10)
                (begin
                  (begin
                    (begin
                      (begin
                        (begin
                          (set! tmp.120 (alloc 16))
                          (set! tmp.89 (+ tmp.120 2)))
                        (begin
                          (mset! tmp.89 -2 L.lam.74.16)
                          (mset! tmp.89 6 0)
                          (set! lam.74 tmp.89)))
                      (set! tmp.119 lam.74))
                    (set! g42913206.11
                      (call
                       L.vector-set!.72.12
                       vector-set!.72
                       tmp.7.9
                       8
                       tmp.119)))
                  (if (begin
                        (set! tmp.121
                          (call L.error?.73.10 error?.73 g42913206.11))
                        (!= tmp.121 6))
                    (set! vector0.8 g42913206.11)
                    (begin
                      (set! g42913207.12
                        (call
                         L.vector-set!.72.12
                         vector-set!.72
                         tmp.7.9
                         16
                         22))
                      (if (begin
                            (set! tmp.122
                              (call L.error?.73.10 error?.73 g42913207.12))
                            (!= tmp.122 6))
                        (set! vector0.8 g42913207.12)
                        (begin
                          (set! g42913208.13
                            (call
                             L.vector-set!.72.12
                             vector-set!.72
                             tmp.7.9
                             24
                             6))
                          (if (begin
                                (set! tmp.123
                                  (call L.error?.73.10 error?.73 g42913208.13))
                                (!= tmp.123 6))
                            (set! vector0.8 g42913208.13)
                            (begin
                              (set! g42913209.14
                                (call
                                 L.vector-set!.72.12
                                 vector-set!.72
                                 tmp.7.9
                                 32
                                 30))
                              (if (begin
                                    (set! tmp.124
                                      (call
                                       L.error?.73.10
                                       error?.73
                                       g42913209.14))
                                    (!= tmp.124 6))
                                (set! vector0.8 g42913209.14)
                                (begin
                                  (set! g42913210.15
                                    (call
                                     L.vector-set!.72.12
                                     vector-set!.72
                                     tmp.7.9
                                     40
                                     29742))
                                  (if (begin
                                        (set! tmp.125
                                          (call
                                           L.error?.73.10
                                           error?.73
                                           g42913210.15))
                                        (!= tmp.125 6))
                                    (set! vector0.8 g42913210.15)
                                    (begin
                                      (set! g42913211.16
                                        (call
                                         L.vector-set!.72.12
                                         vector-set!.72
                                         tmp.7.9
                                         48
                                         22))
                                      (if (begin
                                            (set! tmp.126
                                              (call
                                               L.error?.73.10
                                               error?.73
                                               g42913211.16))
                                            (!= tmp.126 6))
                                        (set! vector0.8 g42913211.16)
                                        (begin
                                          (set! g42913212.17
                                            (call
                                             L.vector-set!.72.12
                                             vector-set!.72
                                             tmp.7.9
                                             56
                                             22))
                                          (if (begin
                                                (set! tmp.127
                                                  (call
                                                   L.error?.73.10
                                                   error?.73
                                                   g42913212.17))
                                                (!= tmp.127 6))
                                            (set! vector0.8 g42913212.17)
                                            (set! vector0.8
                                              tmp.7.9))))))))))))))))))
          (begin (set! ascii-char0.18 20526) 30))))))
(check-by-interp
 '(module
    (define L.lam.95.20 (lambda (c.106) (begin 46142)))
    (define L.lam.93.18
      (lambda (c.104)
        (begin
          (begin
            (begin
              (begin (set! tmp.119 (alloc 16)) (set! tmp.107 (+ tmp.119 2)))
              (begin
                (mset! tmp.107 -2 L.lam.94.19)
                (mset! tmp.107 6 0)
                (set! lam.94 tmp.107)))
            lam.94))))
    (define L.lam.94.19 (lambda (c.105) (begin 6504)))
    (define L.fun/ascii-char8648.15.17
      (lambda (c.103 oprand0.26) (begin 29998)))
    (define L.fun/ascii-char8647.14.16
      (lambda (c.102)
        (begin
          (set! make-vector.90 (mref c.102 14))
          (set! error?.92 (mref c.102 22))
          (set! vector-set!.91 (mref c.102 30))
          (begin
            (begin
              (set! tmp.7.17 (call L.make-vector.90.15 make-vector.90 64))
              (begin
                (set! g42917032.18
                  (call L.vector-set!.91.12 vector-set!.91 tmp.7.17 0 0))
                (if (begin
                      (set! tmp.120
                        (call L.error?.92.10 error?.92 g42917032.18))
                      (!= tmp.120 6))
                  (set! vector0.16 g42917032.18)
                  (begin
                    (set! g42917033.19
                      (call L.vector-set!.91.12 vector-set!.91 tmp.7.17 8 8))
                    (if (begin
                          (set! tmp.121
                            (call L.error?.92.10 error?.92 g42917033.19))
                          (!= tmp.121 6))
                      (set! vector0.16 g42917033.19)
                      (begin
                        (set! g42917034.20
                          (call
                           L.vector-set!.91.12
                           vector-set!.91
                           tmp.7.17
                           16
                           16))
                        (if (begin
                              (set! tmp.122
                                (call L.error?.92.10 error?.92 g42917034.20))
                              (!= tmp.122 6))
                          (set! vector0.16 g42917034.20)
                          (begin
                            (set! g42917035.21
                              (call
                               L.vector-set!.91.12
                               vector-set!.91
                               tmp.7.17
                               24
                               24))
                            (if (begin
                                  (set! tmp.123
                                    (call
                                     L.error?.92.10
                                     error?.92
                                     g42917035.21))
                                  (!= tmp.123 6))
                              (set! vector0.16 g42917035.21)
                              (begin
                                (set! g42917036.22
                                  (call
                                   L.vector-set!.91.12
                                   vector-set!.91
                                   tmp.7.17
                                   32
                                   32))
                                (if (begin
                                      (set! tmp.124
                                        (call
                                         L.error?.92.10
                                         error?.92
                                         g42917036.22))
                                      (!= tmp.124 6))
                                  (set! vector0.16 g42917036.22)
                                  (begin
                                    (set! g42917037.23
                                      (call
                                       L.vector-set!.91.12
                                       vector-set!.91
                                       tmp.7.17
                                       40
                                       40))
                                    (if (begin
                                          (set! tmp.125
                                            (call
                                             L.error?.92.10
                                             error?.92
                                             g42917037.23))
                                          (!= tmp.125 6))
                                      (set! vector0.16 g42917037.23)
                                      (begin
                                        (set! g42917038.24
                                          (call
                                           L.vector-set!.91.12
                                           vector-set!.91
                                           tmp.7.17
                                           48
                                           48))
                                        (if (begin
                                              (set! tmp.126
                                                (call
                                                 L.error?.92.10
                                                 error?.92
                                                 g42917038.24))
                                              (!= tmp.126 6))
                                          (set! vector0.16 g42917038.24)
                                          (begin
                                            (set! g42917039.25
                                              (call
                                               L.vector-set!.91.12
                                               vector-set!.91
                                               tmp.7.17
                                               56
                                               56))
                                            (if (begin
                                                  (set! tmp.127
                                                    (call
                                                     L.error?.92.10
                                                     error?.92
                                                     g42917039.25))
                                                  (!= tmp.127 6))
                                              (set! vector0.16 g42917039.25)
                                              (set! vector0.16
                                                tmp.7.17))))))))))))))))))
            23854))))
    (define L.make-vector.90.15
      (lambda (c.101 tmp.66)
        (begin
          (set! make-init-vector.4 (mref c.101 14))
          (if (begin
                (if (begin (set! tmp.129 (bitwise-and tmp.66 7)) (= tmp.129 0))
                  (set! tmp.128 14)
                  (set! tmp.128 6))
                (!= tmp.128 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.66)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.100 tmp.38)
        (begin
          (set! vector-init-loop.40 (mref c.100 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.133 (arithmetic-shift-right tmp.38 3))
                      (set! tmp.132 (+ 1 tmp.133)))
                    (set! tmp.131 (* tmp.132 8)))
                  (set! tmp.130 (alloc tmp.131)))
                (set! tmp.108 (+ tmp.130 3)))
              (begin (mset! tmp.108 -3 tmp.38) (set! tmp.39 tmp.108)))
            (call
             L.vector-init-loop.40.13
             vector-init-loop.40
             tmp.38
             0
             tmp.39)))))
    (define L.vector-init-loop.40.13
      (lambda (c.99 len.41 i.43 vec.42)
        (begin
          (set! vector-init-loop.40 (mref c.99 14))
          (if (begin
                (if (= len.41 i.43) (set! tmp.134 14) (set! tmp.134 6))
                (!= tmp.134 6))
            vec.42
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.137 (arithmetic-shift-right i.43 3))
                    (set! tmp.136 (* tmp.137 8)))
                  (set! tmp.135 (+ tmp.136 5)))
                (mset! vec.42 tmp.135 0))
              (begin
                (set! tmp.138 (+ i.43 8))
                (call
                 L.vector-init-loop.40.13
                 vector-init-loop.40
                 len.41
                 tmp.138
                 vec.42)))))))
    (define L.vector-set!.91.12
      (lambda (c.98 tmp.68 tmp.69 tmp.70)
        (begin
          (set! unsafe-vector-set!.5 (mref c.98 14))
          (if (begin
                (if (begin (set! tmp.140 (bitwise-and tmp.69 7)) (= tmp.140 0))
                  (set! tmp.139 14)
                  (set! tmp.139 6))
                (!= tmp.139 6))
            (if (begin
                  (if (begin
                        (set! tmp.142 (bitwise-and tmp.68 7))
                        (= tmp.142 3))
                    (set! tmp.141 14)
                    (set! tmp.141 6))
                  (!= tmp.141 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.68
               tmp.69
               tmp.70)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.97 tmp.44 tmp.45 tmp.46)
        (begin
          (if (begin
                (if (begin (set! tmp.144 (mref tmp.44 -3)) (< tmp.45 tmp.144))
                  (set! tmp.143 14)
                  (set! tmp.143 6))
                (!= tmp.143 6))
            (if (begin
                  (if (>= tmp.45 0) (set! tmp.145 14) (set! tmp.145 6))
                  (!= tmp.145 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.148 (arithmetic-shift-right tmp.45 3))
                      (set! tmp.147 (* tmp.148 8)))
                    (set! tmp.146 (+ tmp.147 5)))
                  (mset! tmp.44 tmp.146 tmp.46))
                30)
              2622)
            2622))))
    (define L.error?.92.10
      (lambda (c.96 tmp.80)
        (begin
          (if (begin (set! tmp.149 (bitwise-and tmp.80 255)) (= tmp.149 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.150 (alloc 16)) (set! tmp.109 (+ tmp.150 2)))
        (begin
          (mset! tmp.109 -2 L.error?.92.10)
          (mset! tmp.109 6 8)
          (set! error?.92 tmp.109)))
      (begin
        (begin (set! tmp.151 (alloc 16)) (set! tmp.110 (+ tmp.151 2)))
        (begin
          (mset! tmp.110 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.110 6 24)
          (set! unsafe-vector-set!.5 tmp.110)))
      (begin
        (begin (set! tmp.152 (alloc 24)) (set! tmp.111 (+ tmp.152 2)))
        (begin
          (mset! tmp.111 -2 L.vector-set!.91.12)
          (mset! tmp.111 6 24)
          (set! vector-set!.91 tmp.111)))
      (begin
        (begin (set! tmp.153 (alloc 24)) (set! tmp.112 (+ tmp.153 2)))
        (begin
          (mset! tmp.112 -2 L.vector-init-loop.40.13)
          (mset! tmp.112 6 24)
          (set! vector-init-loop.40 tmp.112)))
      (begin
        (begin (set! tmp.154 (alloc 24)) (set! tmp.113 (+ tmp.154 2)))
        (begin
          (mset! tmp.113 -2 L.make-init-vector.4.14)
          (mset! tmp.113 6 8)
          (set! make-init-vector.4 tmp.113)))
      (begin
        (begin (set! tmp.155 (alloc 24)) (set! tmp.114 (+ tmp.155 2)))
        (begin
          (mset! tmp.114 -2 L.make-vector.90.15)
          (mset! tmp.114 6 8)
          (set! make-vector.90 tmp.114)))
      (begin
        (begin (set! tmp.156 (alloc 40)) (set! tmp.115 (+ tmp.156 2)))
        (begin
          (mset! tmp.115 -2 L.fun/ascii-char8647.14.16)
          (mset! tmp.115 6 0)
          (set! fun/ascii-char8647.14 tmp.115)))
      (begin
        (begin (set! tmp.157 (alloc 16)) (set! tmp.116 (+ tmp.157 2)))
        (begin
          (mset! tmp.116 -2 L.fun/ascii-char8648.15.17)
          (mset! tmp.116 6 8)
          (set! fun/ascii-char8648.15 tmp.116)))
      (begin
        (mset! vector-set!.91 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.40 14 vector-init-loop.40)
        (mset! make-init-vector.4 14 vector-init-loop.40)
        (mset! make-vector.90 14 make-init-vector.4)
        (mset! fun/ascii-char8647.14 14 make-vector.90)
        (mset! fun/ascii-char8647.14 22 error?.92)
        (mset! fun/ascii-char8647.14 30 vector-set!.91)
        (begin
          (set! tmp.8.27
            (call L.fun/ascii-char8647.14.16 fun/ascii-char8647.14))
          (if (!= tmp.8.27 6)
            tmp.8.27
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.158 (alloc 16))
                      (set! tmp.117 (+ tmp.158 2)))
                    (begin
                      (mset! tmp.117 -2 L.lam.93.18)
                      (mset! tmp.117 6 0)
                      (set! lam.93 tmp.117)))
                  (set! procedure0.29 lam.93))
                (set! tmp.9.28 29230))
              (if (!= tmp.9.28 6)
                tmp.9.28
                (begin
                  (begin
                    (set! tmp.11.31
                      (call
                       L.fun/ascii-char8648.15.17
                       fun/ascii-char8648.15
                       1760))
                    (if (!= tmp.11.31 6)
                      (set! tmp.10.30 tmp.11.31)
                      (begin
                        (begin
                          (begin
                            (begin
                              (begin
                                (set! tmp.159 (alloc 16))
                                (set! tmp.118 (+ tmp.159 2)))
                              (begin
                                (mset! tmp.118 -2 L.lam.95.20)
                                (mset! tmp.118 6 0)
                                (set! lam.95 tmp.118)))
                            (set! procedure0.34 lam.95))
                          (set! error1.33 43582)
                          (set! tmp.12.32 17198))
                        (if (!= tmp.12.32 6)
                          (set! tmp.10.30 tmp.12.32)
                          (begin
                            (set! g42917040.35 23598)
                            (if (begin
                                  (set! tmp.160
                                    (call
                                     L.error?.92.10
                                     error?.92
                                     g42917040.35))
                                  (!= tmp.160 6))
                              (set! tmp.10.30 g42917040.35)
                              (set! tmp.10.30 24110)))))))
                  (if (!= tmp.10.30 6)
                    tmp.10.30
                    (begin
                      (begin (set! error0.37 64830) (set! tmp.13.36 21038))
                      (if (!= tmp.13.36 6)
                        tmp.13.36
                        (if (!= 6 6) 19246 27950)))))))))))))
(check-by-interp
 '(module
    (define L.fun/void8651.9.16 (lambda (c.90) (begin 30)))
    (define L.make-vector.81.15
      (lambda (c.89 tmp.57)
        (begin
          (set! make-init-vector.4 (mref c.89 14))
          (if (begin
                (if (begin (set! tmp.100 (bitwise-and tmp.57 7)) (= tmp.100 0))
                  (set! tmp.99 14)
                  (set! tmp.99 6))
                (!= tmp.99 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.57)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.88 tmp.29)
        (begin
          (set! vector-init-loop.31 (mref c.88 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.104 (arithmetic-shift-right tmp.29 3))
                      (set! tmp.103 (+ 1 tmp.104)))
                    (set! tmp.102 (* tmp.103 8)))
                  (set! tmp.101 (alloc tmp.102)))
                (set! tmp.91 (+ tmp.101 3)))
              (begin (mset! tmp.91 -3 tmp.29) (set! tmp.30 tmp.91)))
            (call
             L.vector-init-loop.31.13
             vector-init-loop.31
             tmp.29
             0
             tmp.30)))))
    (define L.vector-init-loop.31.13
      (lambda (c.87 len.32 i.34 vec.33)
        (begin
          (set! vector-init-loop.31 (mref c.87 14))
          (if (begin
                (if (= len.32 i.34) (set! tmp.105 14) (set! tmp.105 6))
                (!= tmp.105 6))
            vec.33
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.108 (arithmetic-shift-right i.34 3))
                    (set! tmp.107 (* tmp.108 8)))
                  (set! tmp.106 (+ tmp.107 5)))
                (mset! vec.33 tmp.106 0))
              (begin
                (set! tmp.109 (+ i.34 8))
                (call
                 L.vector-init-loop.31.13
                 vector-init-loop.31
                 len.32
                 tmp.109
                 vec.33)))))))
    (define L.vector-set!.82.12
      (lambda (c.86 tmp.59 tmp.60 tmp.61)
        (begin
          (set! unsafe-vector-set!.5 (mref c.86 14))
          (if (begin
                (if (begin (set! tmp.111 (bitwise-and tmp.60 7)) (= tmp.111 0))
                  (set! tmp.110 14)
                  (set! tmp.110 6))
                (!= tmp.110 6))
            (if (begin
                  (if (begin
                        (set! tmp.113 (bitwise-and tmp.59 7))
                        (= tmp.113 3))
                    (set! tmp.112 14)
                    (set! tmp.112 6))
                  (!= tmp.112 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.59
               tmp.60
               tmp.61)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.85 tmp.35 tmp.36 tmp.37)
        (begin
          (if (begin
                (if (begin (set! tmp.115 (mref tmp.35 -3)) (< tmp.36 tmp.115))
                  (set! tmp.114 14)
                  (set! tmp.114 6))
                (!= tmp.114 6))
            (if (begin
                  (if (>= tmp.36 0) (set! tmp.116 14) (set! tmp.116 6))
                  (!= tmp.116 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.119 (arithmetic-shift-right tmp.36 3))
                      (set! tmp.118 (* tmp.119 8)))
                    (set! tmp.117 (+ tmp.118 5)))
                  (mset! tmp.35 tmp.117 tmp.37))
                30)
              2622)
            2622))))
    (define L.error?.83.10
      (lambda (c.84 tmp.71)
        (begin
          (if (begin (set! tmp.120 (bitwise-and tmp.71 255)) (= tmp.120 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.121 (alloc 16)) (set! tmp.92 (+ tmp.121 2)))
        (begin
          (mset! tmp.92 -2 L.error?.83.10)
          (mset! tmp.92 6 8)
          (set! error?.83 tmp.92)))
      (begin
        (begin (set! tmp.122 (alloc 16)) (set! tmp.93 (+ tmp.122 2)))
        (begin
          (mset! tmp.93 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.93 6 24)
          (set! unsafe-vector-set!.5 tmp.93)))
      (begin
        (begin (set! tmp.123 (alloc 24)) (set! tmp.94 (+ tmp.123 2)))
        (begin
          (mset! tmp.94 -2 L.vector-set!.82.12)
          (mset! tmp.94 6 24)
          (set! vector-set!.82 tmp.94)))
      (begin
        (begin (set! tmp.124 (alloc 24)) (set! tmp.95 (+ tmp.124 2)))
        (begin
          (mset! tmp.95 -2 L.vector-init-loop.31.13)
          (mset! tmp.95 6 24)
          (set! vector-init-loop.31 tmp.95)))
      (begin
        (begin (set! tmp.125 (alloc 24)) (set! tmp.96 (+ tmp.125 2)))
        (begin
          (mset! tmp.96 -2 L.make-init-vector.4.14)
          (mset! tmp.96 6 8)
          (set! make-init-vector.4 tmp.96)))
      (begin
        (begin (set! tmp.126 (alloc 24)) (set! tmp.97 (+ tmp.126 2)))
        (begin
          (mset! tmp.97 -2 L.make-vector.81.15)
          (mset! tmp.97 6 8)
          (set! make-vector.81 tmp.97)))
      (begin
        (begin (set! tmp.127 (alloc 16)) (set! tmp.98 (+ tmp.127 2)))
        (begin
          (mset! tmp.98 -2 L.fun/void8651.9.16)
          (mset! tmp.98 6 0)
          (set! fun/void8651.9 tmp.98)))
      (begin
        (mset! vector-set!.82 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.31 14 vector-init-loop.31)
        (mset! make-init-vector.4 14 vector-init-loop.31)
        (mset! make-vector.81 14 make-init-vector.4)
        (begin
          (begin
            (set! tmp.7.11 (call L.make-vector.81.15 make-vector.81 64))
            (begin
              (set! g42920858.12
                (call L.vector-set!.82.12 vector-set!.82 tmp.7.11 0 22))
              (if (begin
                    (set! tmp.128 (call L.error?.83.10 error?.83 g42920858.12))
                    (!= tmp.128 6))
                (set! vector0.10 g42920858.12)
                (begin
                  (begin
                    (begin
                      (set! tmp.8.14
                        (call L.make-vector.81.15 make-vector.81 64))
                      (begin
                        (set! g42920860.15
                          (call
                           L.vector-set!.82.12
                           vector-set!.82
                           tmp.8.14
                           0
                           8))
                        (if (begin
                              (set! tmp.130
                                (call L.error?.83.10 error?.83 g42920860.15))
                              (!= tmp.130 6))
                          (set! tmp.129 g42920860.15)
                          (begin
                            (set! g42920861.16
                              (call
                               L.vector-set!.82.12
                               vector-set!.82
                               tmp.8.14
                               8
                               16))
                            (if (begin
                                  (set! tmp.131
                                    (call
                                     L.error?.83.10
                                     error?.83
                                     g42920861.16))
                                  (!= tmp.131 6))
                              (set! tmp.129 g42920861.16)
                              (begin
                                (set! g42920862.17
                                  (call
                                   L.vector-set!.82.12
                                   vector-set!.82
                                   tmp.8.14
                                   16
                                   24))
                                (if (begin
                                      (set! tmp.132
                                        (call
                                         L.error?.83.10
                                         error?.83
                                         g42920862.17))
                                      (!= tmp.132 6))
                                  (set! tmp.129 g42920862.17)
                                  (begin
                                    (set! g42920863.18
                                      (call
                                       L.vector-set!.82.12
                                       vector-set!.82
                                       tmp.8.14
                                       24
                                       32))
                                    (if (begin
                                          (set! tmp.133
                                            (call
                                             L.error?.83.10
                                             error?.83
                                             g42920863.18))
                                          (!= tmp.133 6))
                                      (set! tmp.129 g42920863.18)
                                      (begin
                                        (set! g42920864.19
                                          (call
                                           L.vector-set!.82.12
                                           vector-set!.82
                                           tmp.8.14
                                           32
                                           40))
                                        (if (begin
                                              (set! tmp.134
                                                (call
                                                 L.error?.83.10
                                                 error?.83
                                                 g42920864.19))
                                              (!= tmp.134 6))
                                          (set! tmp.129 g42920864.19)
                                          (begin
                                            (set! g42920865.20
                                              (call
                                               L.vector-set!.82.12
                                               vector-set!.82
                                               tmp.8.14
                                               40
                                               48))
                                            (if (begin
                                                  (set! tmp.135
                                                    (call
                                                     L.error?.83.10
                                                     error?.83
                                                     g42920865.20))
                                                  (!= tmp.135 6))
                                              (set! tmp.129 g42920865.20)
                                              (begin
                                                (set! g42920866.21
                                                  (call
                                                   L.vector-set!.82.12
                                                   vector-set!.82
                                                   tmp.8.14
                                                   48
                                                   56))
                                                (if (begin
                                                      (set! tmp.136
                                                        (call
                                                         L.error?.83.10
                                                         error?.83
                                                         g42920866.21))
                                                      (!= tmp.136 6))
                                                  (set! tmp.129 g42920866.21)
                                                  (begin
                                                    (set! g42920867.22
                                                      (call
                                                       L.vector-set!.82.12
                                                       vector-set!.82
                                                       tmp.8.14
                                                       56
                                                       64))
                                                    (if (begin
                                                          (set! tmp.137
                                                            (call
                                                             L.error?.83.10
                                                             error?.83
                                                             g42920867.22))
                                                          (!= tmp.137 6))
                                                      (set! tmp.129
                                                        g42920867.22)
                                                      (set! tmp.129
                                                        tmp.8.14))))))))))))))))))
                    (set! g42920859.13
                      (call
                       L.vector-set!.82.12
                       vector-set!.82
                       tmp.7.11
                       8
                       tmp.129)))
                  (if (begin
                        (set! tmp.138
                          (call L.error?.83.10 error?.83 g42920859.13))
                        (!= tmp.138 6))
                    (set! vector0.10 g42920859.13)
                    (begin
                      (set! g42920868.23
                        (call
                         L.vector-set!.82.12
                         vector-set!.82
                         tmp.7.11
                         16
                         30))
                      (if (begin
                            (set! tmp.139
                              (call L.error?.83.10 error?.83 g42920868.23))
                            (!= tmp.139 6))
                        (set! vector0.10 g42920868.23)
                        (begin
                          (set! g42920869.24
                            (call
                             L.vector-set!.82.12
                             vector-set!.82
                             tmp.7.11
                             24
                             47934))
                          (if (begin
                                (set! tmp.140
                                  (call L.error?.83.10 error?.83 g42920869.24))
                                (!= tmp.140 6))
                            (set! vector0.10 g42920869.24)
                            (begin
                              (set! g42920870.25
                                (call
                                 L.vector-set!.82.12
                                 vector-set!.82
                                 tmp.7.11
                                 32
                                 14))
                              (if (begin
                                    (set! tmp.141
                                      (call
                                       L.error?.83.10
                                       error?.83
                                       g42920870.25))
                                    (!= tmp.141 6))
                                (set! vector0.10 g42920870.25)
                                (begin
                                  (set! g42920871.26
                                    (call
                                     L.vector-set!.82.12
                                     vector-set!.82
                                     tmp.7.11
                                     40
                                     62))
                                  (if (begin
                                        (set! tmp.142
                                          (call
                                           L.error?.83.10
                                           error?.83
                                           g42920871.26))
                                        (!= tmp.142 6))
                                    (set! vector0.10 g42920871.26)
                                    (begin
                                      (set! g42920872.27
                                        (call
                                         L.vector-set!.82.12
                                         vector-set!.82
                                         tmp.7.11
                                         48
                                         16686))
                                      (if (begin
                                            (set! tmp.143
                                              (call
                                               L.error?.83.10
                                               error?.83
                                               g42920872.27))
                                            (!= tmp.143 6))
                                        (set! vector0.10 g42920872.27)
                                        (begin
                                          (set! g42920873.28
                                            (call
                                             L.vector-set!.82.12
                                             vector-set!.82
                                             tmp.7.11
                                             56
                                             880))
                                          (if (begin
                                                (set! tmp.144
                                                  (call
                                                   L.error?.83.10
                                                   error?.83
                                                   g42920873.28))
                                                (!= tmp.144 6))
                                            (set! vector0.10 g42920873.28)
                                            (set! vector0.10
                                              tmp.7.11))))))))))))))))))
          (call L.fun/void8651.9.16 fun/void8651.9))))))
(check-by-interp
 '(module
    (define L.lam.64.12 (lambda (c.67) (begin 7264)))
    (define L.lam.63.11 (lambda (c.66 oprand0.10) (begin 14)))
    (define L.fun/void8654.7.10
      (lambda (c.65 oprand0.8) (begin (if (!= 6 6) 30 30))))
    (begin
      (begin
        (begin (set! tmp.71 (alloc 16)) (set! tmp.68 (+ tmp.71 2)))
        (begin
          (mset! tmp.68 -2 L.fun/void8654.7.10)
          (mset! tmp.68 6 8)
          (set! fun/void8654.7 tmp.68)))
      (begin
        (begin
          (begin
            (begin
              (begin (set! tmp.73 (alloc 16)) (set! tmp.69 (+ tmp.73 2)))
              (begin
                (mset! tmp.69 -2 L.lam.63.11)
                (mset! tmp.69 6 8)
                (set! lam.63 tmp.69)))
            (set! procedure0.9 lam.63))
          (begin
            (begin
              (begin (set! tmp.74 (alloc 16)) (set! tmp.70 (+ tmp.74 2)))
              (begin
                (mset! tmp.70 -2 L.lam.64.12)
                (mset! tmp.70 6 0)
                (set! lam.64 tmp.70)))
            (set! tmp.72 lam.64)))
        (call L.fun/void8654.7.10 fun/void8654.7 tmp.72)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8657.7.10 (lambda (c.61 oprand0.8) (begin 24110)))
    (begin
      (begin
        (begin (set! tmp.63 (alloc 16)) (set! tmp.62 (+ tmp.63 2)))
        (begin
          (mset! tmp.62 -2 L.fun/ascii-char8657.7.10)
          (mset! tmp.62 6 8)
          (set! fun/ascii-char8657.7 tmp.62)))
      (begin (call L.fun/ascii-char8657.7.10 fun/ascii-char8657.7 30)))))
(check-by-interp
 '(module
    (define L.fun/empty8660.8.11 (lambda (c.64) (begin 22)))
    (define L.fun/fixnum8661.7.10 (lambda (c.63) (begin 976)))
    (begin
      (begin
        (begin (set! tmp.67 (alloc 16)) (set! tmp.65 (+ tmp.67 2)))
        (begin
          (mset! tmp.65 -2 L.fun/fixnum8661.7.10)
          (mset! tmp.65 6 0)
          (set! fun/fixnum8661.7 tmp.65)))
      (begin
        (begin (set! tmp.68 (alloc 16)) (set! tmp.66 (+ tmp.68 2)))
        (begin
          (mset! tmp.66 -2 L.fun/empty8660.8.11)
          (mset! tmp.66 6 0)
          (set! fun/empty8660.8 tmp.66)))
      (begin
        (set! empty0.10 (call L.fun/empty8660.8.11 fun/empty8660.8))
        (set! boolean1.9 6)
        (call L.fun/fixnum8661.7.10 fun/fixnum8661.7)))))
(check-by-interp
 '(module
    (define L.fun/fixnum8664.7.12 (lambda (c.69 oprand0.8) (begin 320)))
    (define L.error?.65.11
      (lambda (c.68 tmp.55)
        (begin
          (if (begin (set! tmp.74 (bitwise-and tmp.55 255)) (= tmp.74 62))
            14
            6))))
    (define L.cons.66.10
      (lambda (c.67 tmp.60 tmp.61)
        (begin
          (begin
            (begin (set! tmp.75 (alloc 16)) (set! tmp.70 (+ tmp.75 1)))
            (begin (mset! tmp.70 -1 tmp.60) (mset! tmp.70 7 tmp.61) tmp.70)))))
    (begin
      (begin
        (begin (set! tmp.76 (alloc 16)) (set! tmp.71 (+ tmp.76 2)))
        (begin
          (mset! tmp.71 -2 L.cons.66.10)
          (mset! tmp.71 6 16)
          (set! cons.66 tmp.71)))
      (begin
        (begin (set! tmp.77 (alloc 16)) (set! tmp.72 (+ tmp.77 2)))
        (begin
          (mset! tmp.72 -2 L.error?.65.11)
          (mset! tmp.72 6 8)
          (set! error?.65 tmp.72)))
      (begin
        (begin (set! tmp.78 (alloc 16)) (set! tmp.73 (+ tmp.78 2)))
        (begin
          (mset! tmp.73 -2 L.fun/fixnum8664.7.12)
          (mset! tmp.73 6 8)
          (set! fun/fixnum8664.7 tmp.73)))
      (if (if (!= 14 6) (!= 600 6) (!= 1048 6))
        (if (begin
              (set! g42936134.9 1752)
              (if (begin
                    (set! tmp.79 (call L.error?.65.11 error?.65 g42936134.9))
                    (!= tmp.79 6))
                (!= g42936134.9 6)
                (begin
                  (set! g42936135.10 232)
                  (if (begin
                        (set! tmp.80
                          (call L.error?.65.11 error?.65 g42936135.10))
                        (!= tmp.80 6))
                    (!= g42936135.10 6)
                    (begin
                      (set! g42936136.11 1592)
                      (if (begin
                            (set! tmp.81
                              (call L.error?.65.11 error?.65 g42936136.11))
                            (!= tmp.81 6))
                        (!= g42936136.11 6)
                        (begin
                          (set! g42936137.12 1624)
                          (if (begin
                                (set! tmp.82
                                  (call L.error?.65.11 error?.65 g42936137.12))
                                (!= tmp.82 6))
                            (!= g42936137.12 6)
                            (!= 1304 6)))))))))
          (begin
            (begin
              (set! tmp.84 (call L.cons.66.10 cons.66 3624 22))
              (set! tmp.83 (call L.cons.66.10 cons.66 1640 tmp.84)))
            (call L.fun/fixnum8664.7.12 fun/fixnum8664.7 tmp.83))
          6)
        6))))
(check-by-interp
 '(module
    (define L.fun/error8667.7.10
      (lambda (c.61 oprand0.8) (begin (if (!= 14 6) 62270 46654))))
    (begin
      (begin
        (begin (set! tmp.63 (alloc 16)) (set! tmp.62 (+ tmp.63 2)))
        (begin
          (mset! tmp.62 -2 L.fun/error8667.7.10)
          (mset! tmp.62 6 8)
          (set! fun/error8667.7 tmp.62)))
      (begin
        (if (!= 6 6) (set! tmp.64 27438) (set! tmp.64 27694))
        (call L.fun/error8667.7.10 fun/error8667.7 tmp.64)))))
(check-by-interp
 '(module
    (define L.fun/empty8671.10.12 (lambda (c.69) (begin (if (!= 6 6) 22 22))))
    (define L.fun/empty8670.9.11 (lambda (c.68) (begin 22)))
    (define L.error?.66.10
      (lambda (c.67 tmp.56)
        (begin
          (if (begin (set! tmp.73 (bitwise-and tmp.56 255)) (= tmp.73 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.74 (alloc 16)) (set! tmp.70 (+ tmp.74 2)))
        (begin
          (mset! tmp.70 -2 L.error?.66.10)
          (mset! tmp.70 6 8)
          (set! error?.66 tmp.70)))
      (begin
        (begin (set! tmp.75 (alloc 16)) (set! tmp.71 (+ tmp.75 2)))
        (begin
          (mset! tmp.71 -2 L.fun/empty8670.9.11)
          (mset! tmp.71 6 0)
          (set! fun/empty8670.9 tmp.71)))
      (begin
        (begin (set! tmp.76 (alloc 16)) (set! tmp.72 (+ tmp.76 2)))
        (begin
          (mset! tmp.72 -2 L.fun/empty8671.10.12)
          (mset! tmp.72 6 0)
          (set! fun/empty8671.10 tmp.72)))
      (begin
        (begin
          (set! tmp.7.12 (call L.fun/empty8670.9.11 fun/empty8670.9))
          (if (!= tmp.7.12 6)
            (set! g42943766.11 tmp.7.12)
            (begin
              (if (!= 6 6) (set! tmp.8.13 22) (set! tmp.8.13 22))
              (if (!= tmp.8.13 6)
                (set! g42943766.11 tmp.8.13)
                (set! g42943766.11 22)))))
        (if (begin
              (set! tmp.77 (call L.error?.66.10 error?.66 g42943766.11))
              (!= tmp.77 6))
          g42943766.11
          (call L.fun/empty8671.10.12 fun/empty8671.10))))))
(check-by-interp
 '(module
    (define L.fun/void8674.7.10 (lambda (c.60) (begin 30)))
    (begin
      (begin
        (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
        (begin
          (mset! tmp.61 -2 L.fun/void8674.7.10)
          (mset! tmp.61 6 0)
          (set! fun/void8674.7 tmp.61)))
      (begin (call L.fun/void8674.7.10 fun/void8674.7)))))
(check-by-interp
 '(module
    (define L.lam.81.22 (lambda (c.94) (begin 5528)))
    (define L.lam.80.21 (lambda (c.93) (begin 5496)))
    (define L.lam.79.20 (lambda (c.92) (begin 4856)))
    (define L.fun/any8677.9.19 (lambda (c.91) (begin 1656)))
    (define L.fun/void8678.8.18 (lambda (c.90) (begin 30)))
    (define L.fixnum?.74.17
      (lambda (c.89 tmp.59)
        (begin
          (if (begin (set! tmp.110 (bitwise-and tmp.59 7)) (= tmp.110 0))
            14
            6))))
    (define L.cons.75.16
      (lambda (c.88 tmp.69 tmp.70)
        (begin
          (begin
            (begin (set! tmp.111 (alloc 16)) (set! tmp.95 (+ tmp.111 1)))
            (begin (mset! tmp.95 -1 tmp.69) (mset! tmp.95 7 tmp.70) tmp.95)))))
    (define L.make-vector.76.15
      (lambda (c.87 tmp.50)
        (begin
          (set! make-init-vector.4 (mref c.87 14))
          (if (begin
                (if (begin (set! tmp.113 (bitwise-and tmp.50 7)) (= tmp.113 0))
                  (set! tmp.112 14)
                  (set! tmp.112 6))
                (!= tmp.112 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.50)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.86 tmp.22)
        (begin
          (set! vector-init-loop.24 (mref c.86 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.117 (arithmetic-shift-right tmp.22 3))
                      (set! tmp.116 (+ 1 tmp.117)))
                    (set! tmp.115 (* tmp.116 8)))
                  (set! tmp.114 (alloc tmp.115)))
                (set! tmp.96 (+ tmp.114 3)))
              (begin (mset! tmp.96 -3 tmp.22) (set! tmp.23 tmp.96)))
            (call
             L.vector-init-loop.24.13
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.13
      (lambda (c.85 len.25 i.27 vec.26)
        (begin
          (set! vector-init-loop.24 (mref c.85 14))
          (if (begin
                (if (= len.25 i.27) (set! tmp.118 14) (set! tmp.118 6))
                (!= tmp.118 6))
            vec.26
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.121 (arithmetic-shift-right i.27 3))
                    (set! tmp.120 (* tmp.121 8)))
                  (set! tmp.119 (+ tmp.120 5)))
                (mset! vec.26 tmp.119 0))
              (begin
                (set! tmp.122 (+ i.27 8))
                (call
                 L.vector-init-loop.24.13
                 vector-init-loop.24
                 len.25
                 tmp.122
                 vec.26)))))))
    (define L.vector-set!.77.12
      (lambda (c.84 tmp.52 tmp.53 tmp.54)
        (begin
          (set! unsafe-vector-set!.5 (mref c.84 14))
          (if (begin
                (if (begin (set! tmp.124 (bitwise-and tmp.53 7)) (= tmp.124 0))
                  (set! tmp.123 14)
                  (set! tmp.123 6))
                (!= tmp.123 6))
            (if (begin
                  (if (begin
                        (set! tmp.126 (bitwise-and tmp.52 7))
                        (= tmp.126 3))
                    (set! tmp.125 14)
                    (set! tmp.125 6))
                  (!= tmp.125 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.52
               tmp.53
               tmp.54)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.83 tmp.28 tmp.29 tmp.30)
        (begin
          (if (begin
                (if (begin (set! tmp.128 (mref tmp.28 -3)) (< tmp.29 tmp.128))
                  (set! tmp.127 14)
                  (set! tmp.127 6))
                (!= tmp.127 6))
            (if (begin
                  (if (>= tmp.29 0) (set! tmp.129 14) (set! tmp.129 6))
                  (!= tmp.129 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.132 (arithmetic-shift-right tmp.29 3))
                      (set! tmp.131 (* tmp.132 8)))
                    (set! tmp.130 (+ tmp.131 5)))
                  (mset! tmp.28 tmp.130 tmp.30))
                30)
              2622)
            2622))))
    (define L.error?.78.10
      (lambda (c.82 tmp.64)
        (begin
          (if (begin (set! tmp.133 (bitwise-and tmp.64 255)) (= tmp.133 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.134 (alloc 16)) (set! tmp.97 (+ tmp.134 2)))
        (begin
          (mset! tmp.97 -2 L.error?.78.10)
          (mset! tmp.97 6 8)
          (set! error?.78 tmp.97)))
      (begin
        (begin (set! tmp.135 (alloc 16)) (set! tmp.98 (+ tmp.135 2)))
        (begin
          (mset! tmp.98 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.98 6 24)
          (set! unsafe-vector-set!.5 tmp.98)))
      (begin
        (begin (set! tmp.136 (alloc 24)) (set! tmp.99 (+ tmp.136 2)))
        (begin
          (mset! tmp.99 -2 L.vector-set!.77.12)
          (mset! tmp.99 6 24)
          (set! vector-set!.77 tmp.99)))
      (begin
        (begin (set! tmp.137 (alloc 24)) (set! tmp.100 (+ tmp.137 2)))
        (begin
          (mset! tmp.100 -2 L.vector-init-loop.24.13)
          (mset! tmp.100 6 24)
          (set! vector-init-loop.24 tmp.100)))
      (begin
        (begin (set! tmp.138 (alloc 24)) (set! tmp.101 (+ tmp.138 2)))
        (begin
          (mset! tmp.101 -2 L.make-init-vector.4.14)
          (mset! tmp.101 6 8)
          (set! make-init-vector.4 tmp.101)))
      (begin
        (begin (set! tmp.139 (alloc 24)) (set! tmp.102 (+ tmp.139 2)))
        (begin
          (mset! tmp.102 -2 L.make-vector.76.15)
          (mset! tmp.102 6 8)
          (set! make-vector.76 tmp.102)))
      (begin
        (begin (set! tmp.140 (alloc 16)) (set! tmp.103 (+ tmp.140 2)))
        (begin
          (mset! tmp.103 -2 L.cons.75.16)
          (mset! tmp.103 6 16)
          (set! cons.75 tmp.103)))
      (begin
        (begin (set! tmp.141 (alloc 16)) (set! tmp.104 (+ tmp.141 2)))
        (begin
          (mset! tmp.104 -2 L.fixnum?.74.17)
          (mset! tmp.104 6 8)
          (set! fixnum?.74 tmp.104)))
      (begin
        (begin (set! tmp.142 (alloc 16)) (set! tmp.105 (+ tmp.142 2)))
        (begin
          (mset! tmp.105 -2 L.fun/void8678.8.18)
          (mset! tmp.105 6 0)
          (set! fun/void8678.8 tmp.105)))
      (begin
        (begin (set! tmp.143 (alloc 16)) (set! tmp.106 (+ tmp.143 2)))
        (begin
          (mset! tmp.106 -2 L.fun/any8677.9.19)
          (mset! tmp.106 6 0)
          (set! fun/any8677.9 tmp.106)))
      (begin
        (mset! vector-set!.77 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.4 14 vector-init-loop.24)
        (mset! make-vector.76 14 make-init-vector.4)
        (begin
          (begin
            (set! tmp.144 (call L.fun/any8677.9.19 fun/any8677.9))
            (set! boolean0.12 (call L.fixnum?.74.17 fixnum?.74 tmp.144)))
          (begin
            (begin
              (begin
                (set! tmp.147 (call L.cons.75.16 cons.75 2816 22))
                (set! tmp.146 (call L.cons.75.16 cons.75 480 tmp.147)))
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (begin
                          (set! tmp.153 (call L.cons.75.16 cons.75 3560 22))
                          (set! tmp.152
                            (call L.cons.75.16 cons.75 1464 tmp.153)))
                        (begin
                          (begin
                            (set! tmp.155 (call L.cons.75.16 cons.75 14 22))
                            (set! tmp.154
                              (call L.cons.75.16 cons.75 6 tmp.155)))
                          (set! tmp.151
                            (call L.cons.75.16 cons.75 tmp.152 tmp.154))))
                      (set! tmp.150 (call L.cons.75.16 cons.75 26670 tmp.151)))
                    (set! tmp.149 (call L.cons.75.16 cons.75 6 tmp.150)))
                  (set! tmp.148 (call L.cons.75.16 cons.75 21806 tmp.149)))
                (set! tmp.145 (call L.cons.75.16 cons.75 tmp.146 tmp.148))))
            (set! pair1.11 (call L.cons.75.16 cons.75 14 tmp.145)))
          (begin
            (set! tmp.7.13 (call L.make-vector.76.15 make-vector.76 64))
            (begin
              (begin
                (begin
                  (set! tmp.157 (call L.cons.75.16 cons.75 2120 22))
                  (set! tmp.156 (call L.cons.75.16 cons.75 1680 tmp.157)))
                (set! g42951404.14
                  (call
                   L.vector-set!.77.12
                   vector-set!.77
                   tmp.7.13
                   0
                   tmp.156)))
              (if (begin
                    (set! tmp.158 (call L.error?.78.10 error?.78 g42951404.14))
                    (!= tmp.158 6))
                (set! vector2.10 g42951404.14)
                (begin
                  (begin
                    (begin (set! tmp.159 12606))
                    (set! g42951405.15
                      (call
                       L.vector-set!.77.12
                       vector-set!.77
                       tmp.7.13
                       8
                       tmp.159)))
                  (if (begin
                        (set! tmp.160
                          (call L.error?.78.10 error?.78 g42951405.15))
                        (!= tmp.160 6))
                    (set! vector2.10 g42951405.15)
                    (begin
                      (begin
                        (begin
                          (begin
                            (begin
                              (begin
                                (set! tmp.162 (alloc 16))
                                (set! tmp.107 (+ tmp.162 2)))
                              (begin
                                (mset! tmp.107 -2 L.lam.79.20)
                                (mset! tmp.107 6 0)
                                (set! lam.79 tmp.107)))
                            (set! tmp.161 lam.79)))
                        (set! g42951406.16
                          (call
                           L.vector-set!.77.12
                           vector-set!.77
                           tmp.7.13
                           16
                           tmp.161)))
                      (if (begin
                            (set! tmp.163
                              (call L.error?.78.10 error?.78 g42951406.16))
                            (!= tmp.163 6))
                        (set! vector2.10 g42951406.16)
                        (begin
                          (begin
                            (set! tmp.164
                              (call L.fun/void8678.8.18 fun/void8678.8))
                            (set! g42951407.17
                              (call
                               L.vector-set!.77.12
                               vector-set!.77
                               tmp.7.13
                               24
                               tmp.164)))
                          (if (begin
                                (set! tmp.165
                                  (call L.error?.78.10 error?.78 g42951407.17))
                                (!= tmp.165 6))
                            (set! vector2.10 g42951407.17)
                            (begin
                              (begin
                                (if (!= 6 6)
                                  (set! tmp.166 30)
                                  (set! tmp.166 30))
                                (set! g42951408.18
                                  (call
                                   L.vector-set!.77.12
                                   vector-set!.77
                                   tmp.7.13
                                   32
                                   tmp.166)))
                              (if (begin
                                    (set! tmp.167
                                      (call
                                       L.error?.78.10
                                       error?.78
                                       g42951408.18))
                                    (!= tmp.167 6))
                                (set! vector2.10 g42951408.18)
                                (begin
                                  (begin
                                    (begin (set! tmp.168 1432))
                                    (set! g42951409.19
                                      (call
                                       L.vector-set!.77.12
                                       vector-set!.77
                                       tmp.7.13
                                       40
                                       tmp.168)))
                                  (if (begin
                                        (set! tmp.169
                                          (call
                                           L.error?.78.10
                                           error?.78
                                           g42951409.19))
                                        (!= tmp.169 6))
                                    (set! vector2.10 g42951409.19)
                                    (begin
                                      (begin
                                        (if (!= 14 6)
                                          (begin
                                            (begin
                                              (begin
                                                (set! tmp.171 (alloc 16))
                                                (set! tmp.108 (+ tmp.171 2)))
                                              (begin
                                                (mset! tmp.108 -2 L.lam.80.21)
                                                (mset! tmp.108 6 0)
                                                (set! lam.80 tmp.108)))
                                            (set! tmp.170 lam.80))
                                          (begin
                                            (begin
                                              (begin
                                                (set! tmp.172 (alloc 16))
                                                (set! tmp.109 (+ tmp.172 2)))
                                              (begin
                                                (mset! tmp.109 -2 L.lam.81.22)
                                                (mset! tmp.109 6 0)
                                                (set! lam.81 tmp.109)))
                                            (set! tmp.170 lam.81)))
                                        (set! g42951410.20
                                          (call
                                           L.vector-set!.77.12
                                           vector-set!.77
                                           tmp.7.13
                                           48
                                           tmp.170)))
                                      (if (begin
                                            (set! tmp.173
                                              (call
                                               L.error?.78.10
                                               error?.78
                                               g42951410.20))
                                            (!= tmp.173 6))
                                        (set! vector2.10 g42951410.20)
                                        (begin
                                          (begin
                                            (if (!= 1728 6)
                                              (if (!= 808 6)
                                                (if (!= 64 6)
                                                  (if (!= 624 6)
                                                    (set! tmp.174 1872)
                                                    (set! tmp.174 6))
                                                  (set! tmp.174 6))
                                                (set! tmp.174 6))
                                              (set! tmp.174 6))
                                            (set! g42951411.21
                                              (call
                                               L.vector-set!.77.12
                                               vector-set!.77
                                               tmp.7.13
                                               56
                                               tmp.174)))
                                          (if (begin
                                                (set! tmp.175
                                                  (call
                                                   L.error?.78.10
                                                   error?.78
                                                   g42951411.21))
                                                (!= tmp.175 6))
                                            (set! vector2.10 g42951411.21)
                                            (set! vector2.10
                                              tmp.7.13))))))))))))))))))
          (begin 30))))))
(check-by-interp
 '(module
    (define L.lam.99.22
      (lambda (c.112)
        (begin
          (set! make-vector.95 (mref c.112 14))
          (set! error?.97 (mref c.112 22))
          (set! vector-set!.96 (mref c.112 30))
          (begin
            (begin
              (set! tmp.7.23 (call L.make-vector.95.16 make-vector.95 64))
              (begin
                (set! g42955226.24
                  (call L.vector-set!.96.13 vector-set!.96 tmp.7.23 0 0))
                (if (begin
                      (set! tmp.128
                        (call L.error?.97.11 error?.97 g42955226.24))
                      (!= tmp.128 6))
                  g42955226.24
                  (begin
                    (set! g42955227.25
                      (call L.vector-set!.96.13 vector-set!.96 tmp.7.23 8 8))
                    (if (begin
                          (set! tmp.129
                            (call L.error?.97.11 error?.97 g42955227.25))
                          (!= tmp.129 6))
                      g42955227.25
                      (begin
                        (set! g42955228.26
                          (call
                           L.vector-set!.96.13
                           vector-set!.96
                           tmp.7.23
                           16
                           16))
                        (if (begin
                              (set! tmp.130
                                (call L.error?.97.11 error?.97 g42955228.26))
                              (!= tmp.130 6))
                          g42955228.26
                          (begin
                            (set! g42955229.27
                              (call
                               L.vector-set!.96.13
                               vector-set!.96
                               tmp.7.23
                               24
                               24))
                            (if (begin
                                  (set! tmp.131
                                    (call
                                     L.error?.97.11
                                     error?.97
                                     g42955229.27))
                                  (!= tmp.131 6))
                              g42955229.27
                              (begin
                                (set! g42955230.28
                                  (call
                                   L.vector-set!.96.13
                                   vector-set!.96
                                   tmp.7.23
                                   32
                                   32))
                                (if (begin
                                      (set! tmp.132
                                        (call
                                         L.error?.97.11
                                         error?.97
                                         g42955230.28))
                                      (!= tmp.132 6))
                                  g42955230.28
                                  (begin
                                    (set! g42955231.29
                                      (call
                                       L.vector-set!.96.13
                                       vector-set!.96
                                       tmp.7.23
                                       40
                                       40))
                                    (if (begin
                                          (set! tmp.133
                                            (call
                                             L.error?.97.11
                                             error?.97
                                             g42955231.29))
                                          (!= tmp.133 6))
                                      g42955231.29
                                      (begin
                                        (set! g42955232.30
                                          (call
                                           L.vector-set!.96.13
                                           vector-set!.96
                                           tmp.7.23
                                           48
                                           48))
                                        (if (begin
                                              (set! tmp.134
                                                (call
                                                 L.error?.97.11
                                                 error?.97
                                                 g42955232.30))
                                              (!= tmp.134 6))
                                          g42955232.30
                                          (begin
                                            (set! g42955233.31
                                              (call
                                               L.vector-set!.96.13
                                               vector-set!.96
                                               tmp.7.23
                                               56
                                               56))
                                            (if (begin
                                                  (set! tmp.135
                                                    (call
                                                     L.error?.97.11
                                                     error?.97
                                                     g42955233.31))
                                                  (!= tmp.135 6))
                                              g42955233.31
                                              tmp.7.23)))))))))))))))))))))
    (define L.fun/boolean8684.19.21 (lambda (c.111) (begin 14)))
    (define L.fun/error8681.18.20
      (lambda (c.110)
        (begin
          (set! fun/error8682.16 (mref c.110 14))
          (call L.fun/error8682.16.18 fun/error8682.16))))
    (define L.fun/boolean8683.17.19 (lambda (c.109) (begin 6)))
    (define L.fun/error8682.16.18 (lambda (c.108) (begin 1854)))
    (define L.cons.94.17
      (lambda (c.107 tmp.89 tmp.90)
        (begin
          (begin
            (begin (set! tmp.136 (alloc 16)) (set! tmp.113 (+ tmp.136 1)))
            (begin
              (mset! tmp.113 -1 tmp.89)
              (mset! tmp.113 7 tmp.90)
              tmp.113)))))
    (define L.make-vector.95.16
      (lambda (c.106 tmp.70)
        (begin
          (set! make-init-vector.4 (mref c.106 14))
          (if (begin
                (if (begin (set! tmp.138 (bitwise-and tmp.70 7)) (= tmp.138 0))
                  (set! tmp.137 14)
                  (set! tmp.137 6))
                (!= tmp.137 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.70)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.105 tmp.42)
        (begin
          (set! vector-init-loop.44 (mref c.105 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.142 (arithmetic-shift-right tmp.42 3))
                      (set! tmp.141 (+ 1 tmp.142)))
                    (set! tmp.140 (* tmp.141 8)))
                  (set! tmp.139 (alloc tmp.140)))
                (set! tmp.114 (+ tmp.139 3)))
              (begin (mset! tmp.114 -3 tmp.42) (set! tmp.43 tmp.114)))
            (call
             L.vector-init-loop.44.14
             vector-init-loop.44
             tmp.42
             0
             tmp.43)))))
    (define L.vector-init-loop.44.14
      (lambda (c.104 len.45 i.47 vec.46)
        (begin
          (set! vector-init-loop.44 (mref c.104 14))
          (if (begin
                (if (= len.45 i.47) (set! tmp.143 14) (set! tmp.143 6))
                (!= tmp.143 6))
            vec.46
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.146 (arithmetic-shift-right i.47 3))
                    (set! tmp.145 (* tmp.146 8)))
                  (set! tmp.144 (+ tmp.145 5)))
                (mset! vec.46 tmp.144 0))
              (begin
                (set! tmp.147 (+ i.47 8))
                (call
                 L.vector-init-loop.44.14
                 vector-init-loop.44
                 len.45
                 tmp.147
                 vec.46)))))))
    (define L.vector-set!.96.13
      (lambda (c.103 tmp.72 tmp.73 tmp.74)
        (begin
          (set! unsafe-vector-set!.5 (mref c.103 14))
          (if (begin
                (if (begin (set! tmp.149 (bitwise-and tmp.73 7)) (= tmp.149 0))
                  (set! tmp.148 14)
                  (set! tmp.148 6))
                (!= tmp.148 6))
            (if (begin
                  (if (begin
                        (set! tmp.151 (bitwise-and tmp.72 7))
                        (= tmp.151 3))
                    (set! tmp.150 14)
                    (set! tmp.150 6))
                  (!= tmp.150 6))
              (call
               L.unsafe-vector-set!.5.12
               unsafe-vector-set!.5
               tmp.72
               tmp.73
               tmp.74)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.12
      (lambda (c.102 tmp.48 tmp.49 tmp.50)
        (begin
          (if (begin
                (if (begin (set! tmp.153 (mref tmp.48 -3)) (< tmp.49 tmp.153))
                  (set! tmp.152 14)
                  (set! tmp.152 6))
                (!= tmp.152 6))
            (if (begin
                  (if (>= tmp.49 0) (set! tmp.154 14) (set! tmp.154 6))
                  (!= tmp.154 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.157 (arithmetic-shift-right tmp.49 3))
                      (set! tmp.156 (* tmp.157 8)))
                    (set! tmp.155 (+ tmp.156 5)))
                  (mset! tmp.48 tmp.155 tmp.50))
                30)
              2622)
            2622))))
    (define L.error?.97.11
      (lambda (c.101 tmp.84)
        (begin
          (if (begin (set! tmp.158 (bitwise-and tmp.84 255)) (= tmp.158 62))
            14
            6))))
    (define L.procedure?.98.10
      (lambda (c.100 tmp.88)
        (begin
          (if (begin (set! tmp.159 (bitwise-and tmp.88 7)) (= tmp.159 2))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.160 (alloc 16)) (set! tmp.115 (+ tmp.160 2)))
        (begin
          (mset! tmp.115 -2 L.procedure?.98.10)
          (mset! tmp.115 6 8)
          (set! procedure?.98 tmp.115)))
      (begin
        (begin (set! tmp.161 (alloc 16)) (set! tmp.116 (+ tmp.161 2)))
        (begin
          (mset! tmp.116 -2 L.error?.97.11)
          (mset! tmp.116 6 8)
          (set! error?.97 tmp.116)))
      (begin
        (begin (set! tmp.162 (alloc 16)) (set! tmp.117 (+ tmp.162 2)))
        (begin
          (mset! tmp.117 -2 L.unsafe-vector-set!.5.12)
          (mset! tmp.117 6 24)
          (set! unsafe-vector-set!.5 tmp.117)))
      (begin
        (begin (set! tmp.163 (alloc 24)) (set! tmp.118 (+ tmp.163 2)))
        (begin
          (mset! tmp.118 -2 L.vector-set!.96.13)
          (mset! tmp.118 6 24)
          (set! vector-set!.96 tmp.118)))
      (begin
        (begin (set! tmp.164 (alloc 24)) (set! tmp.119 (+ tmp.164 2)))
        (begin
          (mset! tmp.119 -2 L.vector-init-loop.44.14)
          (mset! tmp.119 6 24)
          (set! vector-init-loop.44 tmp.119)))
      (begin
        (begin (set! tmp.165 (alloc 24)) (set! tmp.120 (+ tmp.165 2)))
        (begin
          (mset! tmp.120 -2 L.make-init-vector.4.15)
          (mset! tmp.120 6 8)
          (set! make-init-vector.4 tmp.120)))
      (begin
        (begin (set! tmp.166 (alloc 24)) (set! tmp.121 (+ tmp.166 2)))
        (begin
          (mset! tmp.121 -2 L.make-vector.95.16)
          (mset! tmp.121 6 8)
          (set! make-vector.95 tmp.121)))
      (begin
        (begin (set! tmp.167 (alloc 16)) (set! tmp.122 (+ tmp.167 2)))
        (begin
          (mset! tmp.122 -2 L.cons.94.17)
          (mset! tmp.122 6 16)
          (set! cons.94 tmp.122)))
      (begin
        (begin (set! tmp.168 (alloc 16)) (set! tmp.123 (+ tmp.168 2)))
        (begin
          (mset! tmp.123 -2 L.fun/error8682.16.18)
          (mset! tmp.123 6 0)
          (set! fun/error8682.16 tmp.123)))
      (begin
        (begin (set! tmp.169 (alloc 16)) (set! tmp.124 (+ tmp.169 2)))
        (begin
          (mset! tmp.124 -2 L.fun/boolean8683.17.19)
          (mset! tmp.124 6 0)
          (set! fun/boolean8683.17 tmp.124)))
      (begin
        (begin (set! tmp.170 (alloc 24)) (set! tmp.125 (+ tmp.170 2)))
        (begin
          (mset! tmp.125 -2 L.fun/error8681.18.20)
          (mset! tmp.125 6 0)
          (set! fun/error8681.18 tmp.125)))
      (begin
        (begin (set! tmp.171 (alloc 16)) (set! tmp.126 (+ tmp.171 2)))
        (begin
          (mset! tmp.126 -2 L.fun/boolean8684.19.21)
          (mset! tmp.126 6 0)
          (set! fun/boolean8684.19 tmp.126)))
      (begin
        (mset! vector-set!.96 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.44 14 vector-init-loop.44)
        (mset! make-init-vector.4 14 vector-init-loop.44)
        (mset! make-vector.95 14 make-init-vector.4)
        (mset! fun/error8681.18 14 fun/error8682.16)
        (begin
          (begin
            (begin
              (set! tmp.173 (call L.cons.94.17 cons.94 2168 22))
              (set! tmp.172 (call L.cons.94.17 cons.94 1744 tmp.173)))
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.177 (call L.cons.94.17 cons.94 4040 22))
                    (set! tmp.176 (call L.cons.94.17 cons.94 1760 tmp.177)))
                  (begin
                    (begin
                      (begin
                        (set! tmp.180 (call L.cons.94.17 cons.94 2248 22))
                        (set! tmp.179
                          (call L.cons.94.17 cons.94 1968 tmp.180)))
                      (begin
                        (begin
                          (begin
                            (begin
                              (begin
                                (set! tmp.185
                                  (call L.cons.94.17 cons.94 2312 22))
                                (set! tmp.184
                                  (call L.cons.94.17 cons.94 1184 tmp.185)))
                              (begin
                                (set! tmp.186
                                  (call L.cons.94.17 cons.94 25902 22))
                                (set! tmp.183
                                  (call
                                   L.cons.94.17
                                   cons.94
                                   tmp.184
                                   tmp.186))))
                            (set! tmp.182
                              (call L.cons.94.17 cons.94 22 tmp.183)))
                          (set! tmp.181
                            (call L.cons.94.17 cons.94 14 tmp.182)))
                        (set! tmp.178
                          (call L.cons.94.17 cons.94 tmp.179 tmp.181))))
                    (set! tmp.175
                      (call L.cons.94.17 cons.94 tmp.176 tmp.178))))
                (set! tmp.174 (call L.cons.94.17 cons.94 14 tmp.175)))
              (set! pair0.22 (call L.cons.94.17 cons.94 tmp.172 tmp.174))))
          (set! error1.21 (call L.fun/error8681.18.20 fun/error8681.18))
          (begin
            (begin
              (begin (set! tmp.187 (alloc 40)) (set! tmp.127 (+ tmp.187 2)))
              (begin
                (mset! tmp.127 -2 L.lam.99.22)
                (mset! tmp.127 6 0)
                (set! lam.99 tmp.127)))
            (begin
              (mset! lam.99 14 make-vector.95)
              (mset! lam.99 22 error?.97)
              (mset! lam.99 30 vector-set!.96)
              (set! procedure2.20 lam.99)))
          (begin
            (if (!= 6 6) (set! tmp.8.32 6) (set! tmp.8.32 14))
            (if (!= tmp.8.32 6)
              tmp.8.32
              (begin
                (set! tmp.9.33 (call L.procedure?.98.10 procedure?.98 14910))
                (if (!= tmp.9.33 6)
                  tmp.9.33
                  (begin
                    (set! tmp.10.34
                      (call L.fun/boolean8683.17.19 fun/boolean8683.17))
                    (if (!= tmp.10.34 6)
                      tmp.10.34
                      (begin
                        (set! tmp.11.35
                          (call L.fun/boolean8684.19.21 fun/boolean8684.19))
                        (if (!= tmp.11.35 6)
                          tmp.11.35
                          (begin
                            (begin
                              (set! g42955234.37 6)
                              (if (begin
                                    (set! tmp.188
                                      (call
                                       L.error?.97.11
                                       error?.97
                                       g42955234.37))
                                    (!= tmp.188 6))
                                (set! tmp.12.36 g42955234.37)
                                (begin
                                  (set! g42955235.38 14)
                                  (if (begin
                                        (set! tmp.189
                                          (call
                                           L.error?.97.11
                                           error?.97
                                           g42955235.38))
                                        (!= tmp.189 6))
                                    (set! tmp.12.36 g42955235.38)
                                    (set! tmp.12.36 14)))))
                            (if (!= tmp.12.36 6)
                              tmp.12.36
                              (begin
                                (set! tmp.13.39 6)
                                (if (!= tmp.13.39 6)
                                  tmp.13.39
                                  (begin
                                    (set! tmp.14.40 6)
                                    (if (!= tmp.14.40 6)
                                      tmp.14.40
                                      (begin
                                        (set! tmp.15.41 14)
                                        (if (!= tmp.15.41 6)
                                          tmp.15.41
                                          6)))))))))))))))))))))
(check-by-interp
 '(module
    (define L.fun/error8687.16.18
      (lambda (c.102 oprand0.18 oprand1.17)
        (begin
          (set! fun/error8688.15 (mref c.102 14))
          (call L.fun/error8688.15.17 fun/error8688.15))))
    (define L.fun/error8688.15.17 (lambda (c.101) (begin 39998)))
    (define L.cons.90.16
      (lambda (c.100 tmp.85 tmp.86)
        (begin
          (begin
            (begin (set! tmp.114 (alloc 16)) (set! tmp.103 (+ tmp.114 1)))
            (begin
              (mset! tmp.103 -1 tmp.85)
              (mset! tmp.103 7 tmp.86)
              tmp.103)))))
    (define L.make-vector.91.15
      (lambda (c.99 tmp.66)
        (begin
          (set! make-init-vector.4 (mref c.99 14))
          (if (begin
                (if (begin (set! tmp.116 (bitwise-and tmp.66 7)) (= tmp.116 0))
                  (set! tmp.115 14)
                  (set! tmp.115 6))
                (!= tmp.115 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.66)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.98 tmp.38)
        (begin
          (set! vector-init-loop.40 (mref c.98 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.120 (arithmetic-shift-right tmp.38 3))
                      (set! tmp.119 (+ 1 tmp.120)))
                    (set! tmp.118 (* tmp.119 8)))
                  (set! tmp.117 (alloc tmp.118)))
                (set! tmp.104 (+ tmp.117 3)))
              (begin (mset! tmp.104 -3 tmp.38) (set! tmp.39 tmp.104)))
            (call
             L.vector-init-loop.40.13
             vector-init-loop.40
             tmp.38
             0
             tmp.39)))))
    (define L.vector-init-loop.40.13
      (lambda (c.97 len.41 i.43 vec.42)
        (begin
          (set! vector-init-loop.40 (mref c.97 14))
          (if (begin
                (if (= len.41 i.43) (set! tmp.121 14) (set! tmp.121 6))
                (!= tmp.121 6))
            vec.42
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.124 (arithmetic-shift-right i.43 3))
                    (set! tmp.123 (* tmp.124 8)))
                  (set! tmp.122 (+ tmp.123 5)))
                (mset! vec.42 tmp.122 0))
              (begin
                (set! tmp.125 (+ i.43 8))
                (call
                 L.vector-init-loop.40.13
                 vector-init-loop.40
                 len.41
                 tmp.125
                 vec.42)))))))
    (define L.vector-set!.92.12
      (lambda (c.96 tmp.68 tmp.69 tmp.70)
        (begin
          (set! unsafe-vector-set!.5 (mref c.96 14))
          (if (begin
                (if (begin (set! tmp.127 (bitwise-and tmp.69 7)) (= tmp.127 0))
                  (set! tmp.126 14)
                  (set! tmp.126 6))
                (!= tmp.126 6))
            (if (begin
                  (if (begin
                        (set! tmp.129 (bitwise-and tmp.68 7))
                        (= tmp.129 3))
                    (set! tmp.128 14)
                    (set! tmp.128 6))
                  (!= tmp.128 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.68
               tmp.69
               tmp.70)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.95 tmp.44 tmp.45 tmp.46)
        (begin
          (if (begin
                (if (begin (set! tmp.131 (mref tmp.44 -3)) (< tmp.45 tmp.131))
                  (set! tmp.130 14)
                  (set! tmp.130 6))
                (!= tmp.130 6))
            (if (begin
                  (if (>= tmp.45 0) (set! tmp.132 14) (set! tmp.132 6))
                  (!= tmp.132 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.135 (arithmetic-shift-right tmp.45 3))
                      (set! tmp.134 (* tmp.135 8)))
                    (set! tmp.133 (+ tmp.134 5)))
                  (mset! tmp.44 tmp.133 tmp.46))
                30)
              2622)
            2622))))
    (define L.error?.93.10
      (lambda (c.94 tmp.80)
        (begin
          (if (begin (set! tmp.136 (bitwise-and tmp.80 255)) (= tmp.136 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.137 (alloc 16)) (set! tmp.105 (+ tmp.137 2)))
        (begin
          (mset! tmp.105 -2 L.error?.93.10)
          (mset! tmp.105 6 8)
          (set! error?.93 tmp.105)))
      (begin
        (begin (set! tmp.138 (alloc 16)) (set! tmp.106 (+ tmp.138 2)))
        (begin
          (mset! tmp.106 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.106 6 24)
          (set! unsafe-vector-set!.5 tmp.106)))
      (begin
        (begin (set! tmp.139 (alloc 24)) (set! tmp.107 (+ tmp.139 2)))
        (begin
          (mset! tmp.107 -2 L.vector-set!.92.12)
          (mset! tmp.107 6 24)
          (set! vector-set!.92 tmp.107)))
      (begin
        (begin (set! tmp.140 (alloc 24)) (set! tmp.108 (+ tmp.140 2)))
        (begin
          (mset! tmp.108 -2 L.vector-init-loop.40.13)
          (mset! tmp.108 6 24)
          (set! vector-init-loop.40 tmp.108)))
      (begin
        (begin (set! tmp.141 (alloc 24)) (set! tmp.109 (+ tmp.141 2)))
        (begin
          (mset! tmp.109 -2 L.make-init-vector.4.14)
          (mset! tmp.109 6 8)
          (set! make-init-vector.4 tmp.109)))
      (begin
        (begin (set! tmp.142 (alloc 24)) (set! tmp.110 (+ tmp.142 2)))
        (begin
          (mset! tmp.110 -2 L.make-vector.91.15)
          (mset! tmp.110 6 8)
          (set! make-vector.91 tmp.110)))
      (begin
        (begin (set! tmp.143 (alloc 16)) (set! tmp.111 (+ tmp.143 2)))
        (begin
          (mset! tmp.111 -2 L.cons.90.16)
          (mset! tmp.111 6 16)
          (set! cons.90 tmp.111)))
      (begin
        (begin (set! tmp.144 (alloc 16)) (set! tmp.112 (+ tmp.144 2)))
        (begin
          (mset! tmp.112 -2 L.fun/error8688.15.17)
          (mset! tmp.112 6 0)
          (set! fun/error8688.15 tmp.112)))
      (begin
        (begin (set! tmp.145 (alloc 24)) (set! tmp.113 (+ tmp.145 2)))
        (begin
          (mset! tmp.113 -2 L.fun/error8687.16.18)
          (mset! tmp.113 6 16)
          (set! fun/error8687.16 tmp.113)))
      (begin
        (mset! vector-set!.92 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.40 14 vector-init-loop.40)
        (mset! make-init-vector.4 14 vector-init-loop.40)
        (mset! make-vector.91 14 make-init-vector.4)
        (mset! fun/error8687.16 14 fun/error8688.15)
        (begin
          (begin
            (begin (set! error0.21 59966) (set! tmp.8.20 45630))
            (if (!= tmp.8.20 6)
              (set! tmp.7.19 tmp.8.20)
              (begin
                (if (!= 14 6) (set! tmp.9.22 7998) (set! tmp.9.22 54846))
                (if (!= tmp.9.22 6)
                  (set! tmp.7.19 tmp.9.22)
                  (if (!= 6 6) (set! tmp.7.19 43070) (set! tmp.7.19 33854))))))
          (if (!= tmp.7.19 6)
            tmp.7.19
            (begin
              (begin
                (begin
                  (set! tmp.146 (call L.cons.90.16 cons.90 3936 22))
                  (set! pair0.24 (call L.cons.90.16 cons.90 232 tmp.146)))
                (set! tmp.10.23 60222))
              (if (!= tmp.10.23 6)
                tmp.10.23
                (begin
                  (if (!= 6 6) (set! tmp.11.25 56894) (set! tmp.11.25 32574))
                  (if (!= tmp.11.25 6)
                    tmp.11.25
                    (begin
                      (begin
                        (begin
                          (set! tmp.13.28
                            (call L.make-vector.91.15 make-vector.91 64))
                          (begin
                            (set! g42959050.29
                              (call
                               L.vector-set!.92.12
                               vector-set!.92
                               tmp.13.28
                               0
                               8))
                            (if (begin
                                  (set! tmp.147
                                    (call
                                     L.error?.93.10
                                     error?.93
                                     g42959050.29))
                                  (!= tmp.147 6))
                              (set! vector0.27 g42959050.29)
                              (begin
                                (set! g42959051.30
                                  (call
                                   L.vector-set!.92.12
                                   vector-set!.92
                                   tmp.13.28
                                   8
                                   16))
                                (if (begin
                                      (set! tmp.148
                                        (call
                                         L.error?.93.10
                                         error?.93
                                         g42959051.30))
                                      (!= tmp.148 6))
                                  (set! vector0.27 g42959051.30)
                                  (begin
                                    (set! g42959052.31
                                      (call
                                       L.vector-set!.92.12
                                       vector-set!.92
                                       tmp.13.28
                                       16
                                       24))
                                    (if (begin
                                          (set! tmp.149
                                            (call
                                             L.error?.93.10
                                             error?.93
                                             g42959052.31))
                                          (!= tmp.149 6))
                                      (set! vector0.27 g42959052.31)
                                      (begin
                                        (set! g42959053.32
                                          (call
                                           L.vector-set!.92.12
                                           vector-set!.92
                                           tmp.13.28
                                           24
                                           32))
                                        (if (begin
                                              (set! tmp.150
                                                (call
                                                 L.error?.93.10
                                                 error?.93
                                                 g42959053.32))
                                              (!= tmp.150 6))
                                          (set! vector0.27 g42959053.32)
                                          (begin
                                            (set! g42959054.33
                                              (call
                                               L.vector-set!.92.12
                                               vector-set!.92
                                               tmp.13.28
                                               32
                                               40))
                                            (if (begin
                                                  (set! tmp.151
                                                    (call
                                                     L.error?.93.10
                                                     error?.93
                                                     g42959054.33))
                                                  (!= tmp.151 6))
                                              (set! vector0.27 g42959054.33)
                                              (begin
                                                (set! g42959055.34
                                                  (call
                                                   L.vector-set!.92.12
                                                   vector-set!.92
                                                   tmp.13.28
                                                   40
                                                   48))
                                                (if (begin
                                                      (set! tmp.152
                                                        (call
                                                         L.error?.93.10
                                                         error?.93
                                                         g42959055.34))
                                                      (!= tmp.152 6))
                                                  (set! vector0.27
                                                    g42959055.34)
                                                  (begin
                                                    (set! g42959056.35
                                                      (call
                                                       L.vector-set!.92.12
                                                       vector-set!.92
                                                       tmp.13.28
                                                       48
                                                       56))
                                                    (if (begin
                                                          (set! tmp.153
                                                            (call
                                                             L.error?.93.10
                                                             error?.93
                                                             g42959056.35))
                                                          (!= tmp.153 6))
                                                      (set! vector0.27
                                                        g42959056.35)
                                                      (begin
                                                        (set! g42959057.36
                                                          (call
                                                           L.vector-set!.92.12
                                                           vector-set!.92
                                                           tmp.13.28
                                                           56
                                                           64))
                                                        (if (begin
                                                              (set! tmp.154
                                                                (call
                                                                 L.error?.93.10
                                                                 error?.93
                                                                 g42959057.36))
                                                              (!= tmp.154 6))
                                                          (set! vector0.27
                                                            g42959057.36)
                                                          (set! vector0.27
                                                            tmp.13.28))))))))))))))))))
                        (set! tmp.12.26 55358))
                      (if (!= tmp.12.26 6)
                        tmp.12.26
                        (begin
                          (begin (set! tmp.14.37 30014))
                          (if (!= tmp.14.37 6)
                            tmp.14.37
                            (begin
                              (if (!= 6 6) (set! tmp.155 30) (set! tmp.155 30))
                              (begin
                                (if (!= 6 6)
                                  (set! tmp.156 22)
                                  (set! tmp.156 22))
                                (call
                                 L.fun/error8687.16.18
                                 fun/error8687.16
                                 tmp.155
                                 tmp.156)))))))))))))))))
(check-by-interp
 '(module
    (define L.lam.87.17 (lambda (c.95) (begin 9790)))
    (define L.fun/void8694.14.16 (lambda (c.94) (begin 30)))
    (define L.fun/boolean8691.13.15 (lambda (c.93) (begin 6)))
    (define L.fun/void8693.12.14
      (lambda (c.92 oprand0.18 oprand1.17) (begin (begin 30))))
    (define L.fun/void8692.11.13
      (lambda (c.91 oprand0.16 oprand1.15) (begin 30)))
    (define L.cons.84.12
      (lambda (c.90 tmp.79 tmp.80)
        (begin
          (begin
            (begin (set! tmp.105 (alloc 16)) (set! tmp.96 (+ tmp.105 1)))
            (begin (mset! tmp.96 -1 tmp.79) (mset! tmp.96 7 tmp.80) tmp.96)))))
    (define L.boolean?.85.11
      (lambda (c.89 tmp.70)
        (begin
          (if (begin (set! tmp.106 (bitwise-and tmp.70 247)) (= tmp.106 6))
            14
            6))))
    (define L.error?.86.10
      (lambda (c.88 tmp.74)
        (begin
          (if (begin (set! tmp.107 (bitwise-and tmp.74 255)) (= tmp.107 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.108 (alloc 16)) (set! tmp.97 (+ tmp.108 2)))
        (begin
          (mset! tmp.97 -2 L.error?.86.10)
          (mset! tmp.97 6 8)
          (set! error?.86 tmp.97)))
      (begin
        (begin (set! tmp.109 (alloc 16)) (set! tmp.98 (+ tmp.109 2)))
        (begin
          (mset! tmp.98 -2 L.boolean?.85.11)
          (mset! tmp.98 6 8)
          (set! boolean?.85 tmp.98)))
      (begin
        (begin (set! tmp.110 (alloc 16)) (set! tmp.99 (+ tmp.110 2)))
        (begin
          (mset! tmp.99 -2 L.cons.84.12)
          (mset! tmp.99 6 16)
          (set! cons.84 tmp.99)))
      (begin
        (begin (set! tmp.111 (alloc 16)) (set! tmp.100 (+ tmp.111 2)))
        (begin
          (mset! tmp.100 -2 L.fun/void8692.11.13)
          (mset! tmp.100 6 16)
          (set! fun/void8692.11 tmp.100)))
      (begin
        (begin (set! tmp.112 (alloc 16)) (set! tmp.101 (+ tmp.112 2)))
        (begin
          (mset! tmp.101 -2 L.fun/void8693.12.14)
          (mset! tmp.101 6 16)
          (set! fun/void8693.12 tmp.101)))
      (begin
        (begin (set! tmp.113 (alloc 16)) (set! tmp.102 (+ tmp.113 2)))
        (begin
          (mset! tmp.102 -2 L.fun/boolean8691.13.15)
          (mset! tmp.102 6 0)
          (set! fun/boolean8691.13 tmp.102)))
      (begin
        (begin (set! tmp.114 (alloc 16)) (set! tmp.103 (+ tmp.114 2)))
        (begin
          (mset! tmp.103 -2 L.fun/void8694.14.16)
          (mset! tmp.103 6 0)
          (set! fun/void8694.14 tmp.103)))
      (if (begin
            (begin
              (begin
                (set! tmp.115 (call L.cons.84.12 cons.84 2184 22))
                (set! pair0.21 (call L.cons.84.12 cons.84 1712 tmp.115)))
              (set! error1.20 3902)
              (set! tmp.7.19 14))
            (if (!= tmp.7.19 6)
              (!= tmp.7.19 6)
              (begin
                (set! tmp.8.22 (call L.boolean?.85.11 boolean?.85 24110))
                (if (!= tmp.8.22 6)
                  (!= tmp.8.22 6)
                  (begin
                    (set! tmp.9.23
                      (call L.fun/boolean8691.13.15 fun/boolean8691.13))
                    (if (!= tmp.9.23 6)
                      (!= tmp.9.23 6)
                      (begin
                        (set! tmp.10.24 (call L.error?.86.10 error?.86 6))
                        (if (!= tmp.10.24 6)
                          (!= tmp.10.24 6)
                          (if (!= 14 6) (!= 6 6) (!= 6 6))))))))))
        (if (begin
              (begin
                (begin
                  (begin
                    (set! tmp.116 (alloc 16))
                    (set! tmp.104 (+ tmp.116 2)))
                  (begin
                    (mset! tmp.104 -2 L.lam.87.17)
                    (mset! tmp.104 6 0)
                    (set! lam.87 tmp.104)))
                (set! procedure0.27 lam.87))
              (set! error1.26 25406)
              (set! empty2.25 22)
              (!= 30 6))
          (if (begin (!= 30 6))
            (if (if (!= 14 6) (!= 30 6) (!= 30 6))
              (if (begin
                    (set! tmp.117
                      (call L.fun/void8692.11.13 fun/void8692.11 29742 41278))
                    (!= tmp.117 6))
                (if (if (!= 30 6) (if (!= 30 6) (!= 30 6) (!= 6 6)) (!= 6 6))
                  (if (!= 30 6) (if (!= 30 6) (if (!= 30 6) 30 6) 6) 6)
                  6)
                6)
              6)
            6)
          6)
        (begin
          (begin
            (set! g42962877.28 208)
            (if (begin
                  (set! tmp.119 (call L.error?.86.10 error?.86 g42962877.28))
                  (!= tmp.119 6))
              (set! tmp.118 g42962877.28)
              (begin
                (set! g42962878.29 168)
                (if (begin
                      (set! tmp.120
                        (call L.error?.86.10 error?.86 g42962878.29))
                      (!= tmp.120 6))
                  (set! tmp.118 g42962878.29)
                  (begin
                    (set! g42962879.30 1296)
                    (if (begin
                          (set! tmp.121
                            (call L.error?.86.10 error?.86 g42962879.30))
                          (!= tmp.121 6))
                      (set! tmp.118 g42962879.30)
                      (begin
                        (set! g42962880.31 832)
                        (if (begin
                              (set! tmp.122
                                (call L.error?.86.10 error?.86 g42962880.31))
                              (!= tmp.122 6))
                          (set! tmp.118 g42962880.31)
                          (set! tmp.118 848)))))))))
          (begin
            (set! tmp.123 (call L.fun/void8694.14.16 fun/void8694.14))
            (call L.fun/void8693.12.14 fun/void8693.12 tmp.118 tmp.123)))))))
(check-by-interp
 '(module
    (define L.fun/error8697.7.10 (lambda (c.62) (begin (begin 39998))))
    (begin
      (begin
        (begin (set! tmp.64 (alloc 16)) (set! tmp.63 (+ tmp.64 2)))
        (begin
          (mset! tmp.63 -2 L.fun/error8697.7.10)
          (mset! tmp.63 6 0)
          (set! fun/error8697.7 tmp.63)))
      (begin
        (set! error0.9 (call L.fun/error8697.7.10 fun/error8697.7))
        (begin (set! error1.8 574))
        (if (!= 14 6) 48958 19774)))))
(check-by-interp
 '(module
    (define L.fun/empty8700.15.12 (lambda (c.79) (begin 22)))
    (define L.fun/void8701.14.11
      (lambda (c.78)
        (begin
          (set! fun/void8702.13 (mref c.78 14))
          (call L.fun/void8702.13.10 fun/void8702.13))))
    (define L.fun/void8702.13.10 (lambda (c.77) (begin 30)))
    (begin
      (begin
        (begin (set! tmp.83 (alloc 16)) (set! tmp.80 (+ tmp.83 2)))
        (begin
          (mset! tmp.80 -2 L.fun/void8702.13.10)
          (mset! tmp.80 6 0)
          (set! fun/void8702.13 tmp.80)))
      (begin
        (begin (set! tmp.84 (alloc 24)) (set! tmp.81 (+ tmp.84 2)))
        (begin
          (mset! tmp.81 -2 L.fun/void8701.14.11)
          (mset! tmp.81 6 0)
          (set! fun/void8701.14 tmp.81)))
      (begin
        (begin (set! tmp.85 (alloc 16)) (set! tmp.82 (+ tmp.85 2)))
        (begin
          (mset! tmp.82 -2 L.fun/empty8700.15.12)
          (mset! tmp.82 6 0)
          (set! fun/empty8700.15 tmp.82)))
      (begin
        (mset! fun/void8701.14 14 fun/void8702.13)
        (begin
          (begin
            (begin (set! tmp.7.19 22))
            (if (!= tmp.7.19 6)
              (set! empty0.18 tmp.7.19)
              (begin
                (if (!= 14 6) (set! tmp.8.20 22) (set! tmp.8.20 22))
                (if (!= tmp.8.20 6)
                  (set! empty0.18 tmp.8.20)
                  (begin
                    (begin (set! tmp.9.21 22))
                    (if (!= tmp.9.21 6)
                      (set! empty0.18 tmp.9.21)
                      (begin
                        (if (!= 22 6)
                          (if (!= 22 6) (set! tmp.10.22 22) (set! tmp.10.22 6))
                          (set! tmp.10.22 6))
                        (if (!= tmp.10.22 6)
                          (set! empty0.18 tmp.10.22)
                          (begin
                            (begin (set! tmp.11.23 22))
                            (if (!= tmp.11.23 6)
                              (set! empty0.18 tmp.11.23)
                              (begin
                                (set! tmp.12.24
                                  (call
                                   L.fun/empty8700.15.12
                                   fun/empty8700.15))
                                (if (!= tmp.12.24 6)
                                  (set! empty0.18 tmp.12.24)
                                  (if (!= 14 6)
                                    (set! empty0.18 22)
                                    (set! empty0.18 22))))))))))))))
          (if (!= 6 6) (set! ascii-char1.17 27950) (set! ascii-char1.17 17966))
          (set! void2.16 (call L.fun/void8701.14.11 fun/void8701.14))
          (if (!= 6 6) 14 14))))))
(check-by-interp
 '(module
    (define L.lam.151.28 (lambda (c.170) (begin 8096)))
    (define L.fun/void8707.30.27
      (lambda (c.169 oprand0.37) (begin oprand0.37)))
    (define L.fun/void8711.29.26
      (lambda (c.168 oprand0.36 oprand1.35)
        (begin
          (set! vector-set!.147 (mref c.168 14))
          (call
           L.vector-set!.147.16
           vector-set!.147
           oprand1.35
           40
           oprand0.36))))
    (define L.fun/void8715.28.25 (lambda (c.167) (begin 30)))
    (define L.fun/boolean8712.27.24 (lambda (c.166) (begin 6)))
    (define L.fun/void8710.26.23 (lambda (c.165 oprand0.34) (begin 30)))
    (define L.fun/void8709.25.22 (lambda (c.164) (begin 30)))
    (define L.fun/void8708.24.21 (lambda (c.163 oprand0.33) (begin 30)))
    (define L.fun/void8705.23.20 (lambda (c.162) (begin 30)))
    (define L.fun/void8713.22.19 (lambda (c.161) (begin 30)))
    (define L.fun/void8714.21.18
      (lambda (c.160)
        (begin
          (set! fun/void8715.28 (mref c.160 14))
          (call L.fun/void8715.28.25 fun/void8715.28))))
    (define L.fun/void8706.20.17
      (lambda (c.159 oprand0.32 oprand1.31) (begin (begin oprand1.31))))
    (define L.vector-set!.147.16
      (lambda (c.158 tmp.125 tmp.126 tmp.127)
        (begin
          (set! unsafe-vector-set!.5 (mref c.158 14))
          (if (begin
                (if (begin
                      (set! tmp.193 (bitwise-and tmp.126 7))
                      (= tmp.193 0))
                  (set! tmp.192 14)
                  (set! tmp.192 6))
                (!= tmp.192 6))
            (if (begin
                  (if (begin
                        (set! tmp.195 (bitwise-and tmp.125 7))
                        (= tmp.195 3))
                    (set! tmp.194 14)
                    (set! tmp.194 6))
                  (!= tmp.194 6))
              (call
               L.unsafe-vector-set!.5.15
               unsafe-vector-set!.5
               tmp.125
               tmp.126
               tmp.127)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.15
      (lambda (c.157 tmp.101 tmp.102 tmp.103)
        (begin
          (if (begin
                (if (begin
                      (set! tmp.197 (mref tmp.101 -3))
                      (< tmp.102 tmp.197))
                  (set! tmp.196 14)
                  (set! tmp.196 6))
                (!= tmp.196 6))
            (if (begin
                  (if (>= tmp.102 0) (set! tmp.198 14) (set! tmp.198 6))
                  (!= tmp.198 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.201 (arithmetic-shift-right tmp.102 3))
                      (set! tmp.200 (* tmp.201 8)))
                    (set! tmp.199 (+ tmp.200 5)))
                  (mset! tmp.101 tmp.199 tmp.103))
                30)
              2622)
            2622))))
    (define L.error?.148.14
      (lambda (c.156 tmp.137)
        (begin
          (if (begin (set! tmp.202 (bitwise-and tmp.137 255)) (= tmp.202 62))
            14
            6))))
    (define L.make-vector.149.13
      (lambda (c.155 tmp.123)
        (begin
          (set! make-init-vector.4 (mref c.155 14))
          (if (begin
                (if (begin
                      (set! tmp.204 (bitwise-and tmp.123 7))
                      (= tmp.204 0))
                  (set! tmp.203 14)
                  (set! tmp.203 6))
                (!= tmp.203 6))
            (call L.make-init-vector.4.12 make-init-vector.4 tmp.123)
            2110))))
    (define L.make-init-vector.4.12
      (lambda (c.154 tmp.95)
        (begin
          (set! vector-init-loop.97 (mref c.154 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.208 (arithmetic-shift-right tmp.95 3))
                      (set! tmp.207 (+ 1 tmp.208)))
                    (set! tmp.206 (* tmp.207 8)))
                  (set! tmp.205 (alloc tmp.206)))
                (set! tmp.171 (+ tmp.205 3)))
              (begin (mset! tmp.171 -3 tmp.95) (set! tmp.96 tmp.171)))
            (call
             L.vector-init-loop.97.11
             vector-init-loop.97
             tmp.95
             0
             tmp.96)))))
    (define L.vector-init-loop.97.11
      (lambda (c.153 len.98 i.100 vec.99)
        (begin
          (set! vector-init-loop.97 (mref c.153 14))
          (if (begin
                (if (= len.98 i.100) (set! tmp.209 14) (set! tmp.209 6))
                (!= tmp.209 6))
            vec.99
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.212 (arithmetic-shift-right i.100 3))
                    (set! tmp.211 (* tmp.212 8)))
                  (set! tmp.210 (+ tmp.211 5)))
                (mset! vec.99 tmp.210 0))
              (begin
                (set! tmp.213 (+ i.100 8))
                (call
                 L.vector-init-loop.97.11
                 vector-init-loop.97
                 len.98
                 tmp.213
                 vec.99)))))))
    (define L.cons.150.10
      (lambda (c.152 tmp.142 tmp.143)
        (begin
          (begin
            (begin (set! tmp.214 (alloc 16)) (set! tmp.172 (+ tmp.214 1)))
            (begin
              (mset! tmp.172 -1 tmp.142)
              (mset! tmp.172 7 tmp.143)
              tmp.172)))))
    (begin
      (begin
        (begin (set! tmp.215 (alloc 16)) (set! tmp.173 (+ tmp.215 2)))
        (begin
          (mset! tmp.173 -2 L.cons.150.10)
          (mset! tmp.173 6 16)
          (set! cons.150 tmp.173)))
      (begin
        (begin (set! tmp.216 (alloc 24)) (set! tmp.174 (+ tmp.216 2)))
        (begin
          (mset! tmp.174 -2 L.vector-init-loop.97.11)
          (mset! tmp.174 6 24)
          (set! vector-init-loop.97 tmp.174)))
      (begin
        (begin (set! tmp.217 (alloc 24)) (set! tmp.175 (+ tmp.217 2)))
        (begin
          (mset! tmp.175 -2 L.make-init-vector.4.12)
          (mset! tmp.175 6 8)
          (set! make-init-vector.4 tmp.175)))
      (begin
        (begin (set! tmp.218 (alloc 24)) (set! tmp.176 (+ tmp.218 2)))
        (begin
          (mset! tmp.176 -2 L.make-vector.149.13)
          (mset! tmp.176 6 8)
          (set! make-vector.149 tmp.176)))
      (begin
        (begin (set! tmp.219 (alloc 16)) (set! tmp.177 (+ tmp.219 2)))
        (begin
          (mset! tmp.177 -2 L.error?.148.14)
          (mset! tmp.177 6 8)
          (set! error?.148 tmp.177)))
      (begin
        (begin (set! tmp.220 (alloc 16)) (set! tmp.178 (+ tmp.220 2)))
        (begin
          (mset! tmp.178 -2 L.unsafe-vector-set!.5.15)
          (mset! tmp.178 6 24)
          (set! unsafe-vector-set!.5 tmp.178)))
      (begin
        (begin (set! tmp.221 (alloc 24)) (set! tmp.179 (+ tmp.221 2)))
        (begin
          (mset! tmp.179 -2 L.vector-set!.147.16)
          (mset! tmp.179 6 24)
          (set! vector-set!.147 tmp.179)))
      (begin
        (begin (set! tmp.222 (alloc 16)) (set! tmp.180 (+ tmp.222 2)))
        (begin
          (mset! tmp.180 -2 L.fun/void8706.20.17)
          (mset! tmp.180 6 16)
          (set! fun/void8706.20 tmp.180)))
      (begin
        (begin (set! tmp.223 (alloc 24)) (set! tmp.181 (+ tmp.223 2)))
        (begin
          (mset! tmp.181 -2 L.fun/void8714.21.18)
          (mset! tmp.181 6 0)
          (set! fun/void8714.21 tmp.181)))
      (begin
        (begin (set! tmp.224 (alloc 16)) (set! tmp.182 (+ tmp.224 2)))
        (begin
          (mset! tmp.182 -2 L.fun/void8713.22.19)
          (mset! tmp.182 6 0)
          (set! fun/void8713.22 tmp.182)))
      (begin
        (begin (set! tmp.225 (alloc 16)) (set! tmp.183 (+ tmp.225 2)))
        (begin
          (mset! tmp.183 -2 L.fun/void8705.23.20)
          (mset! tmp.183 6 0)
          (set! fun/void8705.23 tmp.183)))
      (begin
        (begin (set! tmp.226 (alloc 16)) (set! tmp.184 (+ tmp.226 2)))
        (begin
          (mset! tmp.184 -2 L.fun/void8708.24.21)
          (mset! tmp.184 6 8)
          (set! fun/void8708.24 tmp.184)))
      (begin
        (begin (set! tmp.227 (alloc 16)) (set! tmp.185 (+ tmp.227 2)))
        (begin
          (mset! tmp.185 -2 L.fun/void8709.25.22)
          (mset! tmp.185 6 0)
          (set! fun/void8709.25 tmp.185)))
      (begin
        (begin (set! tmp.228 (alloc 16)) (set! tmp.186 (+ tmp.228 2)))
        (begin
          (mset! tmp.186 -2 L.fun/void8710.26.23)
          (mset! tmp.186 6 8)
          (set! fun/void8710.26 tmp.186)))
      (begin
        (begin (set! tmp.229 (alloc 16)) (set! tmp.187 (+ tmp.229 2)))
        (begin
          (mset! tmp.187 -2 L.fun/boolean8712.27.24)
          (mset! tmp.187 6 0)
          (set! fun/boolean8712.27 tmp.187)))
      (begin
        (begin (set! tmp.230 (alloc 16)) (set! tmp.188 (+ tmp.230 2)))
        (begin
          (mset! tmp.188 -2 L.fun/void8715.28.25)
          (mset! tmp.188 6 0)
          (set! fun/void8715.28 tmp.188)))
      (begin
        (begin (set! tmp.231 (alloc 24)) (set! tmp.189 (+ tmp.231 2)))
        (begin
          (mset! tmp.189 -2 L.fun/void8711.29.26)
          (mset! tmp.189 6 16)
          (set! fun/void8711.29 tmp.189)))
      (begin
        (begin (set! tmp.232 (alloc 16)) (set! tmp.190 (+ tmp.232 2)))
        (begin
          (mset! tmp.190 -2 L.fun/void8707.30.27)
          (mset! tmp.190 6 8)
          (set! fun/void8707.30 tmp.190)))
      (begin
        (mset! vector-init-loop.97 14 vector-init-loop.97)
        (mset! make-init-vector.4 14 vector-init-loop.97)
        (mset! make-vector.149 14 make-init-vector.4)
        (mset! vector-set!.147 14 unsafe-vector-set!.5)
        (mset! fun/void8714.21 14 fun/void8715.28)
        (mset! fun/void8711.29 14 vector-set!.147)
        (if (begin
              (if (!= 6 6) (set! empty0.38 22) (set! empty0.38 22))
              (if (!= 30 6)
                (if (!= 30 6)
                  (if (!= 30 6) (if (!= 30 6) (!= 30 6) (!= 6 6)) (!= 6 6))
                  (!= 6 6))
                (!= 6 6)))
          (if (if (if (!= 6 6) (!= 30 6) (!= 30 6))
                (if (begin
                      (if (!= 30 6) (set! tmp.7.39 30) (set! tmp.7.39 6))
                      (if (!= tmp.7.39 6)
                        (!= tmp.7.39 6)
                        (begin
                          (if (!= 14 6) (set! tmp.8.40 30) (set! tmp.8.40 30))
                          (if (!= tmp.8.40 6)
                            (!= tmp.8.40 6)
                            (begin
                              (set! tmp.9.41
                                (call L.fun/void8705.23.20 fun/void8705.23))
                              (if (!= tmp.9.41 6)
                                (!= tmp.9.41 6)
                                (begin
                                  (if (!= 6 6)
                                    (set! tmp.10.42 30)
                                    (set! tmp.10.42 30))
                                  (if (!= tmp.10.42 6)
                                    (!= tmp.10.42 6)
                                    (begin
                                      (if (!= 6 6)
                                        (set! tmp.11.43 30)
                                        (set! tmp.11.43 30))
                                      (if (!= tmp.11.43 6)
                                        (!= tmp.11.43 6)
                                        (begin
                                          (begin (set! tmp.12.44 30))
                                          (if (!= tmp.12.44 6)
                                            (!= tmp.12.44 6)
                                            (begin
                                              (set! g42974326.45 30)
                                              (if (begin
                                                    (set! tmp.233
                                                      (call
                                                       L.error?.148.14
                                                       error?.148
                                                       g42974326.45))
                                                    (!= tmp.233 6))
                                                (!= g42974326.45 6)
                                                (!= 30 6)))))))))))))))
                  (if (begin
                        (begin
                          (if (!= 14 6) (set! tmp.235 30) (set! tmp.235 30))
                          (begin
                            (if (!= 6 6) (set! tmp.236 30) (set! tmp.236 30))
                            (set! tmp.234
                              (call
                               L.fun/void8706.20.17
                               fun/void8706.20
                               tmp.235
                               tmp.236))))
                        (!= tmp.234 6))
                    (if (begin
                          (begin
                            (set! tmp.13.49
                              (call L.make-vector.149.13 make-vector.149 64))
                            (begin
                              (set! g42974327.50
                                (call
                                 L.vector-set!.147.16
                                 vector-set!.147
                                 tmp.13.49
                                 0
                                 0))
                              (if (begin
                                    (set! tmp.237
                                      (call
                                       L.error?.148.14
                                       error?.148
                                       g42974327.50))
                                    (!= tmp.237 6))
                                (set! vector0.48 g42974327.50)
                                (begin
                                  (set! g42974328.51
                                    (call
                                     L.vector-set!.147.16
                                     vector-set!.147
                                     tmp.13.49
                                     8
                                     8))
                                  (if (begin
                                        (set! tmp.238
                                          (call
                                           L.error?.148.14
                                           error?.148
                                           g42974328.51))
                                        (!= tmp.238 6))
                                    (set! vector0.48 g42974328.51)
                                    (begin
                                      (set! g42974329.52
                                        (call
                                         L.vector-set!.147.16
                                         vector-set!.147
                                         tmp.13.49
                                         16
                                         16))
                                      (if (begin
                                            (set! tmp.239
                                              (call
                                               L.error?.148.14
                                               error?.148
                                               g42974329.52))
                                            (!= tmp.239 6))
                                        (set! vector0.48 g42974329.52)
                                        (begin
                                          (set! g42974330.53
                                            (call
                                             L.vector-set!.147.16
                                             vector-set!.147
                                             tmp.13.49
                                             24
                                             24))
                                          (if (begin
                                                (set! tmp.240
                                                  (call
                                                   L.error?.148.14
                                                   error?.148
                                                   g42974330.53))
                                                (!= tmp.240 6))
                                            (set! vector0.48 g42974330.53)
                                            (begin
                                              (set! g42974331.54
                                                (call
                                                 L.vector-set!.147.16
                                                 vector-set!.147
                                                 tmp.13.49
                                                 32
                                                 32))
                                              (if (begin
                                                    (set! tmp.241
                                                      (call
                                                       L.error?.148.14
                                                       error?.148
                                                       g42974331.54))
                                                    (!= tmp.241 6))
                                                (set! vector0.48 g42974331.54)
                                                (begin
                                                  (set! g42974332.55
                                                    (call
                                                     L.vector-set!.147.16
                                                     vector-set!.147
                                                     tmp.13.49
                                                     40
                                                     40))
                                                  (if (begin
                                                        (set! tmp.242
                                                          (call
                                                           L.error?.148.14
                                                           error?.148
                                                           g42974332.55))
                                                        (!= tmp.242 6))
                                                    (set! vector0.48
                                                      g42974332.55)
                                                    (begin
                                                      (set! g42974333.56
                                                        (call
                                                         L.vector-set!.147.16
                                                         vector-set!.147
                                                         tmp.13.49
                                                         48
                                                         48))
                                                      (if (begin
                                                            (set! tmp.243
                                                              (call
                                                               L.error?.148.14
                                                               error?.148
                                                               g42974333.56))
                                                            (!= tmp.243 6))
                                                        (set! vector0.48
                                                          g42974333.56)
                                                        (begin
                                                          (set! g42974334.57
                                                            (call
                                                             L.vector-set!.147.16
                                                             vector-set!.147
                                                             tmp.13.49
                                                             56
                                                             56))
                                                          (if (begin
                                                                (set! tmp.244
                                                                  (call
                                                                   L.error?.148.14
                                                                   error?.148
                                                                   g42974334.57))
                                                                (!= tmp.244 6))
                                                            (set! vector0.48
                                                              g42974334.57)
                                                            (set! vector0.48
                                                              tmp.13.49))))))))))))))))))
                          (set! ascii-char1.47 28206)
                          (begin
                            (set! tmp.14.58
                              (call L.make-vector.149.13 make-vector.149 64))
                            (begin
                              (set! g42974335.59
                                (call
                                 L.vector-set!.147.16
                                 vector-set!.147
                                 tmp.14.58
                                 0
                                 0))
                              (if (begin
                                    (set! tmp.245
                                      (call
                                       L.error?.148.14
                                       error?.148
                                       g42974335.59))
                                    (!= tmp.245 6))
                                (set! vector2.46 g42974335.59)
                                (begin
                                  (set! g42974336.60
                                    (call
                                     L.vector-set!.147.16
                                     vector-set!.147
                                     tmp.14.58
                                     8
                                     8))
                                  (if (begin
                                        (set! tmp.246
                                          (call
                                           L.error?.148.14
                                           error?.148
                                           g42974336.60))
                                        (!= tmp.246 6))
                                    (set! vector2.46 g42974336.60)
                                    (begin
                                      (set! g42974337.61
                                        (call
                                         L.vector-set!.147.16
                                         vector-set!.147
                                         tmp.14.58
                                         16
                                         16))
                                      (if (begin
                                            (set! tmp.247
                                              (call
                                               L.error?.148.14
                                               error?.148
                                               g42974337.61))
                                            (!= tmp.247 6))
                                        (set! vector2.46 g42974337.61)
                                        (begin
                                          (set! g42974338.62
                                            (call
                                             L.vector-set!.147.16
                                             vector-set!.147
                                             tmp.14.58
                                             24
                                             24))
                                          (if (begin
                                                (set! tmp.248
                                                  (call
                                                   L.error?.148.14
                                                   error?.148
                                                   g42974338.62))
                                                (!= tmp.248 6))
                                            (set! vector2.46 g42974338.62)
                                            (begin
                                              (set! g42974339.63
                                                (call
                                                 L.vector-set!.147.16
                                                 vector-set!.147
                                                 tmp.14.58
                                                 32
                                                 32))
                                              (if (begin
                                                    (set! tmp.249
                                                      (call
                                                       L.error?.148.14
                                                       error?.148
                                                       g42974339.63))
                                                    (!= tmp.249 6))
                                                (set! vector2.46 g42974339.63)
                                                (begin
                                                  (set! g42974340.64
                                                    (call
                                                     L.vector-set!.147.16
                                                     vector-set!.147
                                                     tmp.14.58
                                                     40
                                                     40))
                                                  (if (begin
                                                        (set! tmp.250
                                                          (call
                                                           L.error?.148.14
                                                           error?.148
                                                           g42974340.64))
                                                        (!= tmp.250 6))
                                                    (set! vector2.46
                                                      g42974340.64)
                                                    (begin
                                                      (set! g42974341.65
                                                        (call
                                                         L.vector-set!.147.16
                                                         vector-set!.147
                                                         tmp.14.58
                                                         48
                                                         48))
                                                      (if (begin
                                                            (set! tmp.251
                                                              (call
                                                               L.error?.148.14
                                                               error?.148
                                                               g42974341.65))
                                                            (!= tmp.251 6))
                                                        (set! vector2.46
                                                          g42974341.65)
                                                        (begin
                                                          (set! g42974342.66
                                                            (call
                                                             L.vector-set!.147.16
                                                             vector-set!.147
                                                             tmp.14.58
                                                             56
                                                             56))
                                                          (if (begin
                                                                (set! tmp.252
                                                                  (call
                                                                   L.error?.148.14
                                                                   error?.148
                                                                   g42974342.66))
                                                                (!= tmp.252 6))
                                                            (set! vector2.46
                                                              g42974342.66)
                                                            (set! vector2.46
                                                              tmp.14.58))))))))))))))))))
                          (!= 30 6))
                      (if (begin
                            (set! tmp.15.67 30)
                            (if (!= tmp.15.67 6) (!= tmp.15.67 6) (!= 30 6)))
                        (if (begin
                              (set! tmp.253
                                (call L.fun/void8707.30.27 fun/void8707.30 30))
                              (!= tmp.253 6))
                          (if (if (!= 14 6) (!= 30 6) (!= 30 6))
                            (if (if (!= 14 6) (!= 30 6) (!= 30 6))
                              (if (begin
                                    (set! tmp.254
                                      (call
                                       L.fun/void8708.24.21
                                       fun/void8708.24
                                       25646))
                                    (!= tmp.254 6))
                                (begin (set! error0.68 54590) (!= 30 6))
                                (!= 6 6))
                              (!= 6 6))
                            (!= 6 6))
                          (!= 6 6))
                        (!= 6 6))
                      (!= 6 6))
                    (!= 6 6))
                  (!= 6 6))
                (!= 6 6))
            (if (if (begin (set! boolean0.69 6) (!= 14 6))
                  (begin
                    (set! tmp.255 (call L.fun/void8709.25.22 fun/void8709.25))
                    (!= tmp.255 6))
                  (begin
                    (set! tmp.256
                      (call L.fun/void8710.26.23 fun/void8710.26 22))
                    (!= tmp.256 6)))
              (if (begin
                    (begin
                      (begin
                        (begin
                          (begin
                            (begin
                              (set! tmp.259 (alloc 16))
                              (set! tmp.191 (+ tmp.259 2)))
                            (begin
                              (mset! tmp.191 -2 L.lam.151.28)
                              (mset! tmp.191 6 0)
                              (set! lam.151 tmp.191)))
                          (set! tmp.258 lam.151))
                        (begin
                          (begin
                            (set! tmp.16.70
                              (call L.make-vector.149.13 make-vector.149 64))
                            (begin
                              (set! g42974343.71
                                (call
                                 L.vector-set!.147.16
                                 vector-set!.147
                                 tmp.16.70
                                 0
                                 8))
                              (if (begin
                                    (set! tmp.261
                                      (call
                                       L.error?.148.14
                                       error?.148
                                       g42974343.71))
                                    (!= tmp.261 6))
                                (set! tmp.260 g42974343.71)
                                (begin
                                  (set! g42974344.72
                                    (call
                                     L.vector-set!.147.16
                                     vector-set!.147
                                     tmp.16.70
                                     8
                                     16))
                                  (if (begin
                                        (set! tmp.262
                                          (call
                                           L.error?.148.14
                                           error?.148
                                           g42974344.72))
                                        (!= tmp.262 6))
                                    (set! tmp.260 g42974344.72)
                                    (begin
                                      (set! g42974345.73
                                        (call
                                         L.vector-set!.147.16
                                         vector-set!.147
                                         tmp.16.70
                                         16
                                         24))
                                      (if (begin
                                            (set! tmp.263
                                              (call
                                               L.error?.148.14
                                               error?.148
                                               g42974345.73))
                                            (!= tmp.263 6))
                                        (set! tmp.260 g42974345.73)
                                        (begin
                                          (set! g42974346.74
                                            (call
                                             L.vector-set!.147.16
                                             vector-set!.147
                                             tmp.16.70
                                             24
                                             32))
                                          (if (begin
                                                (set! tmp.264
                                                  (call
                                                   L.error?.148.14
                                                   error?.148
                                                   g42974346.74))
                                                (!= tmp.264 6))
                                            (set! tmp.260 g42974346.74)
                                            (begin
                                              (set! g42974347.75
                                                (call
                                                 L.vector-set!.147.16
                                                 vector-set!.147
                                                 tmp.16.70
                                                 32
                                                 40))
                                              (if (begin
                                                    (set! tmp.265
                                                      (call
                                                       L.error?.148.14
                                                       error?.148
                                                       g42974347.75))
                                                    (!= tmp.265 6))
                                                (set! tmp.260 g42974347.75)
                                                (begin
                                                  (set! g42974348.76
                                                    (call
                                                     L.vector-set!.147.16
                                                     vector-set!.147
                                                     tmp.16.70
                                                     40
                                                     48))
                                                  (if (begin
                                                        (set! tmp.266
                                                          (call
                                                           L.error?.148.14
                                                           error?.148
                                                           g42974348.76))
                                                        (!= tmp.266 6))
                                                    (set! tmp.260 g42974348.76)
                                                    (begin
                                                      (set! g42974349.77
                                                        (call
                                                         L.vector-set!.147.16
                                                         vector-set!.147
                                                         tmp.16.70
                                                         48
                                                         56))
                                                      (if (begin
                                                            (set! tmp.267
                                                              (call
                                                               L.error?.148.14
                                                               error?.148
                                                               g42974349.77))
                                                            (!= tmp.267 6))
                                                        (set! tmp.260
                                                          g42974349.77)
                                                        (begin
                                                          (set! g42974350.78
                                                            (call
                                                             L.vector-set!.147.16
                                                             vector-set!.147
                                                             tmp.16.70
                                                             56
                                                             64))
                                                          (if (begin
                                                                (set! tmp.268
                                                                  (call
                                                                   L.error?.148.14
                                                                   error?.148
                                                                   g42974350.78))
                                                                (!= tmp.268 6))
                                                            (set! tmp.260
                                                              g42974350.78)
                                                            (set! tmp.260
                                                              tmp.16.70))))))))))))))))))
                          (set! tmp.257
                            (call
                             L.fun/void8711.29.26
                             fun/void8711.29
                             tmp.258
                             tmp.260))))
                      (!= tmp.257 6)))
                (if (if (begin
                          (set! tmp.269
                            (call L.fun/boolean8712.27.24 fun/boolean8712.27))
                          (!= tmp.269 6))
                      (begin
                        (begin
                          (set! tmp.270 (call L.cons.150.10 cons.150 2248 22))
                          (set! pair0.81
                            (call L.cons.150.10 cons.150 1312 tmp.270)))
                        (begin
                          (set! tmp.17.82
                            (call L.make-vector.149.13 make-vector.149 64))
                          (begin
                            (set! g42974351.83
                              (call
                               L.vector-set!.147.16
                               vector-set!.147
                               tmp.17.82
                               0
                               8))
                            (if (begin
                                  (set! tmp.271
                                    (call
                                     L.error?.148.14
                                     error?.148
                                     g42974351.83))
                                  (!= tmp.271 6))
                              (set! vector1.80 g42974351.83)
                              (begin
                                (set! g42974352.84
                                  (call
                                   L.vector-set!.147.16
                                   vector-set!.147
                                   tmp.17.82
                                   8
                                   16))
                                (if (begin
                                      (set! tmp.272
                                        (call
                                         L.error?.148.14
                                         error?.148
                                         g42974352.84))
                                      (!= tmp.272 6))
                                  (set! vector1.80 g42974352.84)
                                  (begin
                                    (set! g42974353.85
                                      (call
                                       L.vector-set!.147.16
                                       vector-set!.147
                                       tmp.17.82
                                       16
                                       24))
                                    (if (begin
                                          (set! tmp.273
                                            (call
                                             L.error?.148.14
                                             error?.148
                                             g42974353.85))
                                          (!= tmp.273 6))
                                      (set! vector1.80 g42974353.85)
                                      (begin
                                        (set! g42974354.86
                                          (call
                                           L.vector-set!.147.16
                                           vector-set!.147
                                           tmp.17.82
                                           24
                                           32))
                                        (if (begin
                                              (set! tmp.274
                                                (call
                                                 L.error?.148.14
                                                 error?.148
                                                 g42974354.86))
                                              (!= tmp.274 6))
                                          (set! vector1.80 g42974354.86)
                                          (begin
                                            (set! g42974355.87
                                              (call
                                               L.vector-set!.147.16
                                               vector-set!.147
                                               tmp.17.82
                                               32
                                               40))
                                            (if (begin
                                                  (set! tmp.275
                                                    (call
                                                     L.error?.148.14
                                                     error?.148
                                                     g42974355.87))
                                                  (!= tmp.275 6))
                                              (set! vector1.80 g42974355.87)
                                              (begin
                                                (set! g42974356.88
                                                  (call
                                                   L.vector-set!.147.16
                                                   vector-set!.147
                                                   tmp.17.82
                                                   40
                                                   48))
                                                (if (begin
                                                      (set! tmp.276
                                                        (call
                                                         L.error?.148.14
                                                         error?.148
                                                         g42974356.88))
                                                      (!= tmp.276 6))
                                                  (set! vector1.80
                                                    g42974356.88)
                                                  (begin
                                                    (set! g42974357.89
                                                      (call
                                                       L.vector-set!.147.16
                                                       vector-set!.147
                                                       tmp.17.82
                                                       48
                                                       56))
                                                    (if (begin
                                                          (set! tmp.277
                                                            (call
                                                             L.error?.148.14
                                                             error?.148
                                                             g42974357.89))
                                                          (!= tmp.277 6))
                                                      (set! vector1.80
                                                        g42974357.89)
                                                      (begin
                                                        (set! g42974358.90
                                                          (call
                                                           L.vector-set!.147.16
                                                           vector-set!.147
                                                           tmp.17.82
                                                           56
                                                           64))
                                                        (if (begin
                                                              (set! tmp.278
                                                                (call
                                                                 L.error?.148.14
                                                                 error?.148
                                                                 g42974358.90))
                                                              (!= tmp.278 6))
                                                          (set! vector1.80
                                                            g42974358.90)
                                                          (set! vector1.80
                                                            tmp.17.82))))))))))))))))))
                        (set! error2.79 22078)
                        (!= 30 6))
                      (begin
                        (set! tmp.279
                          (call L.fun/void8713.22.19 fun/void8713.22))
                        (!= tmp.279 6)))
                  (begin
                    (if (!= 6 6) (set! tmp.18.91 30) (set! tmp.18.91 30))
                    (if (!= tmp.18.91 6)
                      tmp.18.91
                      (begin
                        (set! tmp.19.92
                          (call L.fun/void8714.21.18 fun/void8714.21))
                        (if (!= tmp.19.92 6)
                          tmp.19.92
                          (begin
                            (set! fixnum0.94 1616)
                            (set! error1.93 22078)
                            30)))))
                  6)
                6)
              6)
            6)
          6)))))
(check-by-interp
 '(module
    (define L.fun/fixnum8721.8.12
      (lambda (c.67)
        (begin
          (set! cons.64 (mref c.67 14))
          (set! fun/boolean8722.7 (mref c.67 22))
          (if (begin
                (set! tmp.72 (call L.fun/boolean8722.7.11 fun/boolean8722.7))
                (!= tmp.72 6))
            (begin (set! empty0.9 22) 1936)
            (begin
              (begin
                (set! tmp.73 (call L.cons.64.10 cons.64 3392 22))
                (set! pair0.11 (call L.cons.64.10 cons.64 696 tmp.73)))
              (set! fixnum1.10 992)
              1056)))))
    (define L.fun/boolean8722.7.11 (lambda (c.66) (begin 14)))
    (define L.cons.64.10
      (lambda (c.65 tmp.59 tmp.60)
        (begin
          (begin
            (begin (set! tmp.74 (alloc 16)) (set! tmp.68 (+ tmp.74 1)))
            (begin (mset! tmp.68 -1 tmp.59) (mset! tmp.68 7 tmp.60) tmp.68)))))
    (begin
      (begin
        (begin (set! tmp.75 (alloc 16)) (set! tmp.69 (+ tmp.75 2)))
        (begin
          (mset! tmp.69 -2 L.cons.64.10)
          (mset! tmp.69 6 16)
          (set! cons.64 tmp.69)))
      (begin
        (begin (set! tmp.76 (alloc 16)) (set! tmp.70 (+ tmp.76 2)))
        (begin
          (mset! tmp.70 -2 L.fun/boolean8722.7.11)
          (mset! tmp.70 6 0)
          (set! fun/boolean8722.7 tmp.70)))
      (begin
        (begin (set! tmp.77 (alloc 32)) (set! tmp.71 (+ tmp.77 2)))
        (begin
          (mset! tmp.71 -2 L.fun/fixnum8721.8.12)
          (mset! tmp.71 6 0)
          (set! fun/fixnum8721.8 tmp.71)))
      (begin
        (mset! fun/fixnum8721.8 14 cons.64)
        (mset! fun/fixnum8721.8 22 fun/boolean8722.7)
        (call L.fun/fixnum8721.8.12 fun/fixnum8721.8)))))
(check-by-interp
 '(module
    (define L.lam.80.20 (lambda (c.91) (begin 8160)))
    (define L.fun/ascii-char8725.9.19 (lambda (c.90) (begin 29486)))
    (define L.fun/ascii-char8726.8.18
      (lambda (c.89) (begin (if (!= 14 6) 18478 24878))))
    (define L.error?.76.17
      (lambda (c.88 tmp.66)
        (begin
          (if (begin (set! tmp.104 (bitwise-and tmp.66 255)) (= tmp.104 62))
            14
            6))))
    (define L.make-vector.77.16
      (lambda (c.87 tmp.52)
        (begin
          (set! make-init-vector.4 (mref c.87 14))
          (if (begin
                (if (begin (set! tmp.106 (bitwise-and tmp.52 7)) (= tmp.106 0))
                  (set! tmp.105 14)
                  (set! tmp.105 6))
                (!= tmp.105 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.52)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.86 tmp.24)
        (begin
          (set! vector-init-loop.26 (mref c.86 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.110 (arithmetic-shift-right tmp.24 3))
                      (set! tmp.109 (+ 1 tmp.110)))
                    (set! tmp.108 (* tmp.109 8)))
                  (set! tmp.107 (alloc tmp.108)))
                (set! tmp.92 (+ tmp.107 3)))
              (begin (mset! tmp.92 -3 tmp.24) (set! tmp.25 tmp.92)))
            (call
             L.vector-init-loop.26.14
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.14
      (lambda (c.85 len.27 i.29 vec.28)
        (begin
          (set! vector-init-loop.26 (mref c.85 14))
          (if (begin
                (if (= len.27 i.29) (set! tmp.111 14) (set! tmp.111 6))
                (!= tmp.111 6))
            vec.28
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.114 (arithmetic-shift-right i.29 3))
                    (set! tmp.113 (* tmp.114 8)))
                  (set! tmp.112 (+ tmp.113 5)))
                (mset! vec.28 tmp.112 0))
              (begin
                (set! tmp.115 (+ i.29 8))
                (call
                 L.vector-init-loop.26.14
                 vector-init-loop.26
                 len.27
                 tmp.115
                 vec.28)))))))
    (define L.vector-set!.78.13
      (lambda (c.84 tmp.54 tmp.55 tmp.56)
        (begin
          (set! unsafe-vector-set!.5 (mref c.84 14))
          (if (begin
                (if (begin (set! tmp.117 (bitwise-and tmp.55 7)) (= tmp.117 0))
                  (set! tmp.116 14)
                  (set! tmp.116 6))
                (!= tmp.116 6))
            (if (begin
                  (if (begin
                        (set! tmp.119 (bitwise-and tmp.54 7))
                        (= tmp.119 3))
                    (set! tmp.118 14)
                    (set! tmp.118 6))
                  (!= tmp.118 6))
              (call
               L.unsafe-vector-set!.5.12
               unsafe-vector-set!.5
               tmp.54
               tmp.55
               tmp.56)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.12
      (lambda (c.83 tmp.30 tmp.31 tmp.32)
        (begin
          (if (begin
                (if (begin (set! tmp.121 (mref tmp.30 -3)) (< tmp.31 tmp.121))
                  (set! tmp.120 14)
                  (set! tmp.120 6))
                (!= tmp.120 6))
            (if (begin
                  (if (>= tmp.31 0) (set! tmp.122 14) (set! tmp.122 6))
                  (!= tmp.122 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.125 (arithmetic-shift-right tmp.31 3))
                      (set! tmp.124 (* tmp.125 8)))
                    (set! tmp.123 (+ tmp.124 5)))
                  (mset! tmp.30 tmp.123 tmp.32))
                30)
              2622)
            2622))))
    (define L.vector-ref.79.11
      (lambda (c.82 tmp.57 tmp.58)
        (begin
          (set! unsafe-vector-ref.6 (mref c.82 14))
          (if (begin
                (if (begin (set! tmp.127 (bitwise-and tmp.58 7)) (= tmp.127 0))
                  (set! tmp.126 14)
                  (set! tmp.126 6))
                (!= tmp.126 6))
            (if (begin
                  (if (begin
                        (set! tmp.129 (bitwise-and tmp.57 7))
                        (= tmp.129 3))
                    (set! tmp.128 14)
                    (set! tmp.128 6))
                  (!= tmp.128 6))
              (call L.unsafe-vector-ref.6.10 unsafe-vector-ref.6 tmp.57 tmp.58)
              2878)
            2878))))
    (define L.unsafe-vector-ref.6.10
      (lambda (c.81 tmp.35 tmp.36)
        (begin
          (if (begin
                (if (begin (set! tmp.131 (mref tmp.35 -3)) (< tmp.36 tmp.131))
                  (set! tmp.130 14)
                  (set! tmp.130 6))
                (!= tmp.130 6))
            (if (begin
                  (if (>= tmp.36 0) (set! tmp.132 14) (set! tmp.132 6))
                  (!= tmp.132 6))
              (begin
                (begin
                  (begin
                    (set! tmp.135 (arithmetic-shift-right tmp.36 3))
                    (set! tmp.134 (* tmp.135 8)))
                  (set! tmp.133 (+ tmp.134 5)))
                (mref tmp.35 tmp.133))
              2878)
            2878))))
    (begin
      (begin
        (begin (set! tmp.136 (alloc 16)) (set! tmp.93 (+ tmp.136 2)))
        (begin
          (mset! tmp.93 -2 L.unsafe-vector-ref.6.10)
          (mset! tmp.93 6 16)
          (set! unsafe-vector-ref.6 tmp.93)))
      (begin
        (begin (set! tmp.137 (alloc 24)) (set! tmp.94 (+ tmp.137 2)))
        (begin
          (mset! tmp.94 -2 L.vector-ref.79.11)
          (mset! tmp.94 6 16)
          (set! vector-ref.79 tmp.94)))
      (begin
        (begin (set! tmp.138 (alloc 16)) (set! tmp.95 (+ tmp.138 2)))
        (begin
          (mset! tmp.95 -2 L.unsafe-vector-set!.5.12)
          (mset! tmp.95 6 24)
          (set! unsafe-vector-set!.5 tmp.95)))
      (begin
        (begin (set! tmp.139 (alloc 24)) (set! tmp.96 (+ tmp.139 2)))
        (begin
          (mset! tmp.96 -2 L.vector-set!.78.13)
          (mset! tmp.96 6 24)
          (set! vector-set!.78 tmp.96)))
      (begin
        (begin (set! tmp.140 (alloc 24)) (set! tmp.97 (+ tmp.140 2)))
        (begin
          (mset! tmp.97 -2 L.vector-init-loop.26.14)
          (mset! tmp.97 6 24)
          (set! vector-init-loop.26 tmp.97)))
      (begin
        (begin (set! tmp.141 (alloc 24)) (set! tmp.98 (+ tmp.141 2)))
        (begin
          (mset! tmp.98 -2 L.make-init-vector.4.15)
          (mset! tmp.98 6 8)
          (set! make-init-vector.4 tmp.98)))
      (begin
        (begin (set! tmp.142 (alloc 24)) (set! tmp.99 (+ tmp.142 2)))
        (begin
          (mset! tmp.99 -2 L.make-vector.77.16)
          (mset! tmp.99 6 8)
          (set! make-vector.77 tmp.99)))
      (begin
        (begin (set! tmp.143 (alloc 16)) (set! tmp.100 (+ tmp.143 2)))
        (begin
          (mset! tmp.100 -2 L.error?.76.17)
          (mset! tmp.100 6 8)
          (set! error?.76 tmp.100)))
      (begin
        (begin (set! tmp.144 (alloc 16)) (set! tmp.101 (+ tmp.144 2)))
        (begin
          (mset! tmp.101 -2 L.fun/ascii-char8726.8.18)
          (mset! tmp.101 6 0)
          (set! fun/ascii-char8726.8 tmp.101)))
      (begin
        (begin (set! tmp.145 (alloc 16)) (set! tmp.102 (+ tmp.145 2)))
        (begin
          (mset! tmp.102 -2 L.fun/ascii-char8725.9.19)
          (mset! tmp.102 6 0)
          (set! fun/ascii-char8725.9 tmp.102)))
      (begin
        (mset! vector-ref.79 14 unsafe-vector-ref.6)
        (mset! vector-set!.78 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.26 14 vector-init-loop.26)
        (mset! make-init-vector.4 14 vector-init-loop.26)
        (mset! make-vector.77 14 make-init-vector.4)
        (begin
          (begin
            (set! g42981988.11
              (call L.fun/ascii-char8725.9.19 fun/ascii-char8725.9))
            (if (begin
                  (set! tmp.146 (call L.error?.76.17 error?.76 g42981988.11))
                  (!= tmp.146 6))
              (set! g42981987.10 g42981988.11)
              (begin
                (if (!= 6 6)
                  (set! g42981989.12 27438)
                  (set! g42981989.12 26926))
                (if (begin
                      (set! tmp.147
                        (call L.error?.76.17 error?.76 g42981989.12))
                      (!= tmp.147 6))
                  (set! g42981987.10 g42981989.12)
                  (if (!= 14 6)
                    (set! g42981987.10 17198)
                    (set! g42981987.10 17710))))))
          (if (begin
                (set! tmp.148 (call L.error?.76.17 error?.76 g42981987.10))
                (!= tmp.148 6))
            g42981987.10
            (begin
              (set! g42981990.13
                (call L.fun/ascii-char8726.8.18 fun/ascii-char8726.8))
              (if (begin
                    (set! tmp.149 (call L.error?.76.17 error?.76 g42981990.13))
                    (!= tmp.149 6))
                g42981990.13
                (begin
                  (begin
                    (set! tmp.7.15
                      (call L.make-vector.77.16 make-vector.77 64))
                    (begin
                      (begin
                        (set! tmp.150
                          (call L.make-vector.77.16 make-vector.77 64))
                        (set! g42981991.16
                          (call
                           L.vector-set!.78.13
                           vector-set!.78
                           tmp.7.15
                           0
                           tmp.150)))
                      (if (begin
                            (set! tmp.151
                              (call L.error?.76.17 error?.76 g42981991.16))
                            (!= tmp.151 6))
                        (set! vector0.14 g42981991.16)
                        (begin
                          (set! g42981992.17
                            (call
                             L.vector-set!.78.13
                             vector-set!.78
                             tmp.7.15
                             8
                             23598))
                          (if (begin
                                (set! tmp.152
                                  (call L.error?.76.17 error?.76 g42981992.17))
                                (!= tmp.152 6))
                            (set! vector0.14 g42981992.17)
                            (begin
                              (begin
                                (begin
                                  (begin
                                    (begin
                                      (set! tmp.154 (alloc 16))
                                      (set! tmp.103 (+ tmp.154 2)))
                                    (begin
                                      (mset! tmp.103 -2 L.lam.80.20)
                                      (mset! tmp.103 6 0)
                                      (set! lam.80 tmp.103)))
                                  (set! tmp.153 lam.80))
                                (set! g42981993.18
                                  (call
                                   L.vector-set!.78.13
                                   vector-set!.78
                                   tmp.7.15
                                   16
                                   tmp.153)))
                              (if (begin
                                    (set! tmp.155
                                      (call
                                       L.error?.76.17
                                       error?.76
                                       g42981993.18))
                                    (!= tmp.155 6))
                                (set! vector0.14 g42981993.18)
                                (begin
                                  (set! g42981994.19
                                    (call
                                     L.vector-set!.78.13
                                     vector-set!.78
                                     tmp.7.15
                                     24
                                     1848))
                                  (if (begin
                                        (set! tmp.156
                                          (call
                                           L.error?.76.17
                                           error?.76
                                           g42981994.19))
                                        (!= tmp.156 6))
                                    (set! vector0.14 g42981994.19)
                                    (begin
                                      (set! g42981995.20
                                        (call
                                         L.vector-set!.78.13
                                         vector-set!.78
                                         tmp.7.15
                                         32
                                         30))
                                      (if (begin
                                            (set! tmp.157
                                              (call
                                               L.error?.76.17
                                               error?.76
                                               g42981995.20))
                                            (!= tmp.157 6))
                                        (set! vector0.14 g42981995.20)
                                        (begin
                                          (set! g42981996.21
                                            (call
                                             L.vector-set!.78.13
                                             vector-set!.78
                                             tmp.7.15
                                             40
                                             28462))
                                          (if (begin
                                                (set! tmp.158
                                                  (call
                                                   L.error?.76.17
                                                   error?.76
                                                   g42981996.21))
                                                (!= tmp.158 6))
                                            (set! vector0.14 g42981996.21)
                                            (begin
                                              (set! g42981997.22
                                                (call
                                                 L.vector-set!.78.13
                                                 vector-set!.78
                                                 tmp.7.15
                                                 48
                                                 1696))
                                              (if (begin
                                                    (set! tmp.159
                                                      (call
                                                       L.error?.76.17
                                                       error?.76
                                                       g42981997.22))
                                                    (!= tmp.159 6))
                                                (set! vector0.14 g42981997.22)
                                                (begin
                                                  (set! g42981998.23
                                                    (call
                                                     L.vector-set!.78.13
                                                     vector-set!.78
                                                     tmp.7.15
                                                     56
                                                     20286))
                                                  (if (begin
                                                        (set! tmp.160
                                                          (call
                                                           L.error?.76.17
                                                           error?.76
                                                           g42981998.23))
                                                        (!= tmp.160 6))
                                                    (set! vector0.14
                                                      g42981998.23)
                                                    (set! vector0.14
                                                      tmp.7.15))))))))))))))))))
                  (call
                   L.vector-ref.79.11
                   vector-ref.79
                   vector0.14
                   40))))))))))
(check-by-interp
 '(module
    (define L.lam.131.22 (lambda (c.144) (begin (begin 22))))
    (define L.lam.130.21 (lambda (c.143) (begin 6184)))
    (define L.fun/empty8729.23.20
      (lambda (c.142 oprand0.25 oprand1.24) (begin (if (!= 6 6) 22 22))))
    (define L.fun/pair8730.22.19
      (lambda (c.141)
        (begin
          (set! cons.125 (mref c.141 14))
          (if (!= 14 6)
            (begin
              (set! tmp.160 (call L.cons.125.17 cons.125 3176 22))
              (call L.cons.125.17 cons.125 1760 tmp.160))
            (begin
              (set! tmp.161 (call L.cons.125.17 cons.125 3664 22))
              (call L.cons.125.17 cons.125 1824 tmp.161))))))
    (define L.fun/empty8731.21.18 (lambda (c.140) (begin 22)))
    (define L.cons.125.17
      (lambda (c.139 tmp.120 tmp.121)
        (begin
          (begin
            (begin (set! tmp.162 (alloc 16)) (set! tmp.145 (+ tmp.162 1)))
            (begin
              (mset! tmp.145 -1 tmp.120)
              (mset! tmp.145 7 tmp.121)
              tmp.145)))))
    (define L.error?.126.16
      (lambda (c.138 tmp.115)
        (begin
          (if (begin (set! tmp.163 (bitwise-and tmp.115 255)) (= tmp.163 62))
            14
            6))))
    (define L.make-vector.127.15
      (lambda (c.137 tmp.101)
        (begin
          (set! make-init-vector.4 (mref c.137 14))
          (if (begin
                (if (begin
                      (set! tmp.165 (bitwise-and tmp.101 7))
                      (= tmp.165 0))
                  (set! tmp.164 14)
                  (set! tmp.164 6))
                (!= tmp.164 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.101)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.136 tmp.73)
        (begin
          (set! vector-init-loop.75 (mref c.136 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.169 (arithmetic-shift-right tmp.73 3))
                      (set! tmp.168 (+ 1 tmp.169)))
                    (set! tmp.167 (* tmp.168 8)))
                  (set! tmp.166 (alloc tmp.167)))
                (set! tmp.146 (+ tmp.166 3)))
              (begin (mset! tmp.146 -3 tmp.73) (set! tmp.74 tmp.146)))
            (call
             L.vector-init-loop.75.13
             vector-init-loop.75
             tmp.73
             0
             tmp.74)))))
    (define L.vector-init-loop.75.13
      (lambda (c.135 len.76 i.78 vec.77)
        (begin
          (set! vector-init-loop.75 (mref c.135 14))
          (if (begin
                (if (= len.76 i.78) (set! tmp.170 14) (set! tmp.170 6))
                (!= tmp.170 6))
            vec.77
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.173 (arithmetic-shift-right i.78 3))
                    (set! tmp.172 (* tmp.173 8)))
                  (set! tmp.171 (+ tmp.172 5)))
                (mset! vec.77 tmp.171 0))
              (begin
                (set! tmp.174 (+ i.78 8))
                (call
                 L.vector-init-loop.75.13
                 vector-init-loop.75
                 len.76
                 tmp.174
                 vec.77)))))))
    (define L.vector-set!.128.12
      (lambda (c.134 tmp.103 tmp.104 tmp.105)
        (begin
          (set! unsafe-vector-set!.5 (mref c.134 14))
          (if (begin
                (if (begin
                      (set! tmp.176 (bitwise-and tmp.104 7))
                      (= tmp.176 0))
                  (set! tmp.175 14)
                  (set! tmp.175 6))
                (!= tmp.175 6))
            (if (begin
                  (if (begin
                        (set! tmp.178 (bitwise-and tmp.103 7))
                        (= tmp.178 3))
                    (set! tmp.177 14)
                    (set! tmp.177 6))
                  (!= tmp.177 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.103
               tmp.104
               tmp.105)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.133 tmp.79 tmp.80 tmp.81)
        (begin
          (if (begin
                (if (begin (set! tmp.180 (mref tmp.79 -3)) (< tmp.80 tmp.180))
                  (set! tmp.179 14)
                  (set! tmp.179 6))
                (!= tmp.179 6))
            (if (begin
                  (if (>= tmp.80 0) (set! tmp.181 14) (set! tmp.181 6))
                  (!= tmp.181 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.184 (arithmetic-shift-right tmp.80 3))
                      (set! tmp.183 (* tmp.184 8)))
                    (set! tmp.182 (+ tmp.183 5)))
                  (mset! tmp.79 tmp.182 tmp.81))
                30)
              2622)
            2622))))
    (define L.pair?.129.10
      (lambda (c.132 tmp.116)
        (begin
          (if (begin (set! tmp.185 (bitwise-and tmp.116 7)) (= tmp.185 1))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.186 (alloc 16)) (set! tmp.147 (+ tmp.186 2)))
        (begin
          (mset! tmp.147 -2 L.pair?.129.10)
          (mset! tmp.147 6 8)
          (set! pair?.129 tmp.147)))
      (begin
        (begin (set! tmp.187 (alloc 16)) (set! tmp.148 (+ tmp.187 2)))
        (begin
          (mset! tmp.148 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.148 6 24)
          (set! unsafe-vector-set!.5 tmp.148)))
      (begin
        (begin (set! tmp.188 (alloc 24)) (set! tmp.149 (+ tmp.188 2)))
        (begin
          (mset! tmp.149 -2 L.vector-set!.128.12)
          (mset! tmp.149 6 24)
          (set! vector-set!.128 tmp.149)))
      (begin
        (begin (set! tmp.189 (alloc 24)) (set! tmp.150 (+ tmp.189 2)))
        (begin
          (mset! tmp.150 -2 L.vector-init-loop.75.13)
          (mset! tmp.150 6 24)
          (set! vector-init-loop.75 tmp.150)))
      (begin
        (begin (set! tmp.190 (alloc 24)) (set! tmp.151 (+ tmp.190 2)))
        (begin
          (mset! tmp.151 -2 L.make-init-vector.4.14)
          (mset! tmp.151 6 8)
          (set! make-init-vector.4 tmp.151)))
      (begin
        (begin (set! tmp.191 (alloc 24)) (set! tmp.152 (+ tmp.191 2)))
        (begin
          (mset! tmp.152 -2 L.make-vector.127.15)
          (mset! tmp.152 6 8)
          (set! make-vector.127 tmp.152)))
      (begin
        (begin (set! tmp.192 (alloc 16)) (set! tmp.153 (+ tmp.192 2)))
        (begin
          (mset! tmp.153 -2 L.error?.126.16)
          (mset! tmp.153 6 8)
          (set! error?.126 tmp.153)))
      (begin
        (begin (set! tmp.193 (alloc 16)) (set! tmp.154 (+ tmp.193 2)))
        (begin
          (mset! tmp.154 -2 L.cons.125.17)
          (mset! tmp.154 6 16)
          (set! cons.125 tmp.154)))
      (begin
        (begin (set! tmp.194 (alloc 16)) (set! tmp.155 (+ tmp.194 2)))
        (begin
          (mset! tmp.155 -2 L.fun/empty8731.21.18)
          (mset! tmp.155 6 0)
          (set! fun/empty8731.21 tmp.155)))
      (begin
        (begin (set! tmp.195 (alloc 24)) (set! tmp.156 (+ tmp.195 2)))
        (begin
          (mset! tmp.156 -2 L.fun/pair8730.22.19)
          (mset! tmp.156 6 0)
          (set! fun/pair8730.22 tmp.156)))
      (begin
        (begin (set! tmp.196 (alloc 16)) (set! tmp.157 (+ tmp.196 2)))
        (begin
          (mset! tmp.157 -2 L.fun/empty8729.23.20)
          (mset! tmp.157 6 16)
          (set! fun/empty8729.23 tmp.157)))
      (begin
        (mset! vector-set!.128 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.75 14 vector-init-loop.75)
        (mset! make-init-vector.4 14 vector-init-loop.75)
        (mset! make-vector.127 14 make-init-vector.4)
        (mset! fun/pair8730.22 14 cons.125)
        (begin
          (begin
            (begin
              (set! g42985819.27 22)
              (if (begin
                    (set! tmp.197
                      (call L.error?.126.16 error?.126 g42985819.27))
                    (!= tmp.197 6))
                (set! tmp.7.26 g42985819.27)
                (set! tmp.7.26 22))))
          (if (!= tmp.7.26 6)
            tmp.7.26
            (begin
              (begin
                (set! tmp.198 (call L.fun/pair8730.22.19 fun/pair8730.22))
                (begin
                  (begin (set! tmp.199 32830))
                  (set! tmp.8.28
                    (call
                     L.fun/empty8729.23.20
                     fun/empty8729.23
                     tmp.198
                     tmp.199))))
              (if (!= tmp.8.28 6)
                tmp.8.28
                (begin
                  (begin
                    (begin
                      (set! tmp.10.33
                        (call L.make-vector.127.15 make-vector.127 64))
                      (begin
                        (begin
                          (begin
                            (set! tmp.11.35
                              (call L.make-vector.127.15 make-vector.127 64))
                            (begin
                              (set! g42985821.36
                                (call
                                 L.vector-set!.128.12
                                 vector-set!.128
                                 tmp.11.35
                                 0
                                 8))
                              (if (begin
                                    (set! tmp.201
                                      (call
                                       L.error?.126.16
                                       error?.126
                                       g42985821.36))
                                    (!= tmp.201 6))
                                (set! tmp.200 g42985821.36)
                                (begin
                                  (set! g42985822.37
                                    (call
                                     L.vector-set!.128.12
                                     vector-set!.128
                                     tmp.11.35
                                     8
                                     16))
                                  (if (begin
                                        (set! tmp.202
                                          (call
                                           L.error?.126.16
                                           error?.126
                                           g42985822.37))
                                        (!= tmp.202 6))
                                    (set! tmp.200 g42985822.37)
                                    (begin
                                      (set! g42985823.38
                                        (call
                                         L.vector-set!.128.12
                                         vector-set!.128
                                         tmp.11.35
                                         16
                                         24))
                                      (if (begin
                                            (set! tmp.203
                                              (call
                                               L.error?.126.16
                                               error?.126
                                               g42985823.38))
                                            (!= tmp.203 6))
                                        (set! tmp.200 g42985823.38)
                                        (begin
                                          (set! g42985824.39
                                            (call
                                             L.vector-set!.128.12
                                             vector-set!.128
                                             tmp.11.35
                                             24
                                             32))
                                          (if (begin
                                                (set! tmp.204
                                                  (call
                                                   L.error?.126.16
                                                   error?.126
                                                   g42985824.39))
                                                (!= tmp.204 6))
                                            (set! tmp.200 g42985824.39)
                                            (begin
                                              (set! g42985825.40
                                                (call
                                                 L.vector-set!.128.12
                                                 vector-set!.128
                                                 tmp.11.35
                                                 32
                                                 40))
                                              (if (begin
                                                    (set! tmp.205
                                                      (call
                                                       L.error?.126.16
                                                       error?.126
                                                       g42985825.40))
                                                    (!= tmp.205 6))
                                                (set! tmp.200 g42985825.40)
                                                (begin
                                                  (set! g42985826.41
                                                    (call
                                                     L.vector-set!.128.12
                                                     vector-set!.128
                                                     tmp.11.35
                                                     40
                                                     48))
                                                  (if (begin
                                                        (set! tmp.206
                                                          (call
                                                           L.error?.126.16
                                                           error?.126
                                                           g42985826.41))
                                                        (!= tmp.206 6))
                                                    (set! tmp.200 g42985826.41)
                                                    (begin
                                                      (set! g42985827.42
                                                        (call
                                                         L.vector-set!.128.12
                                                         vector-set!.128
                                                         tmp.11.35
                                                         48
                                                         56))
                                                      (if (begin
                                                            (set! tmp.207
                                                              (call
                                                               L.error?.126.16
                                                               error?.126
                                                               g42985827.42))
                                                            (!= tmp.207 6))
                                                        (set! tmp.200
                                                          g42985827.42)
                                                        (begin
                                                          (set! g42985828.43
                                                            (call
                                                             L.vector-set!.128.12
                                                             vector-set!.128
                                                             tmp.11.35
                                                             56
                                                             64))
                                                          (if (begin
                                                                (set! tmp.208
                                                                  (call
                                                                   L.error?.126.16
                                                                   error?.126
                                                                   g42985828.43))
                                                                (!= tmp.208 6))
                                                            (set! tmp.200
                                                              g42985828.43)
                                                            (set! tmp.200
                                                              tmp.11.35))))))))))))))))))
                          (set! g42985820.34
                            (call
                             L.vector-set!.128.12
                             vector-set!.128
                             tmp.10.33
                             0
                             tmp.200)))
                        (if (begin
                              (set! tmp.209
                                (call L.error?.126.16 error?.126 g42985820.34))
                              (!= tmp.209 6))
                          (set! vector0.32 g42985820.34)
                          (begin
                            (set! g42985829.44
                              (call
                               L.vector-set!.128.12
                               vector-set!.128
                               tmp.10.33
                               8
                               14))
                            (if (begin
                                  (set! tmp.210
                                    (call
                                     L.error?.126.16
                                     error?.126
                                     g42985829.44))
                                  (!= tmp.210 6))
                              (set! vector0.32 g42985829.44)
                              (begin
                                (set! g42985830.45
                                  (call
                                   L.vector-set!.128.12
                                   vector-set!.128
                                   tmp.10.33
                                   16
                                   43326))
                                (if (begin
                                      (set! tmp.211
                                        (call
                                         L.error?.126.16
                                         error?.126
                                         g42985830.45))
                                      (!= tmp.211 6))
                                  (set! vector0.32 g42985830.45)
                                  (begin
                                    (set! g42985831.46
                                      (call
                                       L.vector-set!.128.12
                                       vector-set!.128
                                       tmp.10.33
                                       24
                                       30))
                                    (if (begin
                                          (set! tmp.212
                                            (call
                                             L.error?.126.16
                                             error?.126
                                             g42985831.46))
                                          (!= tmp.212 6))
                                      (set! vector0.32 g42985831.46)
                                      (begin
                                        (set! g42985832.47
                                          (call
                                           L.vector-set!.128.12
                                           vector-set!.128
                                           tmp.10.33
                                           32
                                           248))
                                        (if (begin
                                              (set! tmp.213
                                                (call
                                                 L.error?.126.16
                                                 error?.126
                                                 g42985832.47))
                                              (!= tmp.213 6))
                                          (set! vector0.32 g42985832.47)
                                          (begin
                                            (set! g42985833.48
                                              (call
                                               L.vector-set!.128.12
                                               vector-set!.128
                                               tmp.10.33
                                               40
                                               30526))
                                            (if (begin
                                                  (set! tmp.214
                                                    (call
                                                     L.error?.126.16
                                                     error?.126
                                                     g42985833.48))
                                                  (!= tmp.214 6))
                                              (set! vector0.32 g42985833.48)
                                              (begin
                                                (begin
                                                  (begin
                                                    (begin
                                                      (begin
                                                        (set! tmp.216
                                                          (alloc 16))
                                                        (set! tmp.158
                                                          (+ tmp.216 2)))
                                                      (begin
                                                        (mset!
                                                         tmp.158
                                                         -2
                                                         L.lam.130.21)
                                                        (mset! tmp.158 6 0)
                                                        (set! lam.130
                                                          tmp.158)))
                                                    (set! tmp.215 lam.130))
                                                  (set! g42985834.49
                                                    (call
                                                     L.vector-set!.128.12
                                                     vector-set!.128
                                                     tmp.10.33
                                                     48
                                                     tmp.215)))
                                                (if (begin
                                                      (set! tmp.217
                                                        (call
                                                         L.error?.126.16
                                                         error?.126
                                                         g42985834.49))
                                                      (!= tmp.217 6))
                                                  (set! vector0.32
                                                    g42985834.49)
                                                  (begin
                                                    (set! g42985835.50
                                                      (call
                                                       L.vector-set!.128.12
                                                       vector-set!.128
                                                       tmp.10.33
                                                       56
                                                       30))
                                                    (if (begin
                                                          (set! tmp.218
                                                            (call
                                                             L.error?.126.16
                                                             error?.126
                                                             g42985835.50))
                                                          (!= tmp.218 6))
                                                      (set! vector0.32
                                                        g42985835.50)
                                                      (set! vector0.32
                                                        tmp.10.33))))))))))))))))))
                    (begin
                      (begin
                        (begin
                          (set! tmp.219 (alloc 16))
                          (set! tmp.159 (+ tmp.219 2)))
                        (begin
                          (mset! tmp.159 -2 L.lam.131.22)
                          (mset! tmp.159 6 0)
                          (set! lam.131 tmp.159)))
                      (set! procedure1.31 lam.131))
                    (begin (set! empty2.30 22))
                    (set! tmp.9.29
                      (call L.fun/empty8731.21.18 fun/empty8731.21)))
                  (if (!= tmp.9.29 6)
                    tmp.9.29
                    (begin
                      (if (begin
                            (set! error0.54 10302)
                            (begin
                              (set! tmp.13.55
                                (call L.make-vector.127.15 make-vector.127 64))
                              (begin
                                (set! g42985836.56
                                  (call
                                   L.vector-set!.128.12
                                   vector-set!.128
                                   tmp.13.55
                                   0
                                   8))
                                (if (begin
                                      (set! tmp.220
                                        (call
                                         L.error?.126.16
                                         error?.126
                                         g42985836.56))
                                      (!= tmp.220 6))
                                  (set! vector1.53 g42985836.56)
                                  (begin
                                    (set! g42985837.57
                                      (call
                                       L.vector-set!.128.12
                                       vector-set!.128
                                       tmp.13.55
                                       8
                                       16))
                                    (if (begin
                                          (set! tmp.221
                                            (call
                                             L.error?.126.16
                                             error?.126
                                             g42985837.57))
                                          (!= tmp.221 6))
                                      (set! vector1.53 g42985837.57)
                                      (begin
                                        (set! g42985838.58
                                          (call
                                           L.vector-set!.128.12
                                           vector-set!.128
                                           tmp.13.55
                                           16
                                           24))
                                        (if (begin
                                              (set! tmp.222
                                                (call
                                                 L.error?.126.16
                                                 error?.126
                                                 g42985838.58))
                                              (!= tmp.222 6))
                                          (set! vector1.53 g42985838.58)
                                          (begin
                                            (set! g42985839.59
                                              (call
                                               L.vector-set!.128.12
                                               vector-set!.128
                                               tmp.13.55
                                               24
                                               32))
                                            (if (begin
                                                  (set! tmp.223
                                                    (call
                                                     L.error?.126.16
                                                     error?.126
                                                     g42985839.59))
                                                  (!= tmp.223 6))
                                              (set! vector1.53 g42985839.59)
                                              (begin
                                                (set! g42985840.60
                                                  (call
                                                   L.vector-set!.128.12
                                                   vector-set!.128
                                                   tmp.13.55
                                                   32
                                                   40))
                                                (if (begin
                                                      (set! tmp.224
                                                        (call
                                                         L.error?.126.16
                                                         error?.126
                                                         g42985840.60))
                                                      (!= tmp.224 6))
                                                  (set! vector1.53
                                                    g42985840.60)
                                                  (begin
                                                    (set! g42985841.61
                                                      (call
                                                       L.vector-set!.128.12
                                                       vector-set!.128
                                                       tmp.13.55
                                                       40
                                                       48))
                                                    (if (begin
                                                          (set! tmp.225
                                                            (call
                                                             L.error?.126.16
                                                             error?.126
                                                             g42985841.61))
                                                          (!= tmp.225 6))
                                                      (set! vector1.53
                                                        g42985841.61)
                                                      (begin
                                                        (set! g42985842.62
                                                          (call
                                                           L.vector-set!.128.12
                                                           vector-set!.128
                                                           tmp.13.55
                                                           48
                                                           56))
                                                        (if (begin
                                                              (set! tmp.226
                                                                (call
                                                                 L.error?.126.16
                                                                 error?.126
                                                                 g42985842.62))
                                                              (!= tmp.226 6))
                                                          (set! vector1.53
                                                            g42985842.62)
                                                          (begin
                                                            (set! g42985843.63
                                                              (call
                                                               L.vector-set!.128.12
                                                               vector-set!.128
                                                               tmp.13.55
                                                               56
                                                               64))
                                                            (if (begin
                                                                  (set! tmp.227
                                                                    (call
                                                                     L.error?.126.16
                                                                     error?.126
                                                                     g42985843.63))
                                                                  (!=
                                                                   tmp.227
                                                                   6))
                                                              (set! vector1.53
                                                                g42985843.63)
                                                              (set! vector1.53
                                                                tmp.13.55))))))))))))))))))
                            (set! boolean2.52 14)
                            (!= 14 6))
                        (begin
                          (set! tmp.14.64 22)
                          (if (!= tmp.14.64 6)
                            (set! tmp.12.51 tmp.14.64)
                            (begin
                              (set! tmp.15.65 22)
                              (if (!= tmp.15.65 6)
                                (set! tmp.12.51 tmp.15.65)
                                (begin
                                  (set! tmp.16.66 22)
                                  (if (!= tmp.16.66 6)
                                    (set! tmp.12.51 tmp.16.66)
                                    (begin
                                      (set! tmp.17.67 22)
                                      (if (!= tmp.17.67 6)
                                        (set! tmp.12.51 tmp.17.67)
                                        (begin
                                          (set! tmp.18.68 22)
                                          (if (!= tmp.18.68 6)
                                            (set! tmp.12.51 tmp.18.68)
                                            (begin
                                              (set! tmp.19.69 22)
                                              (if (!= tmp.19.69 6)
                                                (set! tmp.12.51 tmp.19.69)
                                                (set! tmp.12.51 22)))))))))))))
                        (begin
                          (set! g42985844.70 22)
                          (if (begin
                                (set! tmp.228
                                  (call
                                   L.error?.126.16
                                   error?.126
                                   g42985844.70))
                                (!= tmp.228 6))
                            (set! tmp.12.51 g42985844.70)
                            (begin
                              (set! g42985845.71 22)
                              (if (begin
                                    (set! tmp.229
                                      (call
                                       L.error?.126.16
                                       error?.126
                                       g42985845.71))
                                    (!= tmp.229 6))
                                (set! tmp.12.51 g42985845.71)
                                (set! tmp.12.51 22))))))
                      (if (!= tmp.12.51 6)
                        tmp.12.51
                        (begin
                          (if (begin
                                (begin
                                  (begin
                                    (set! tmp.232
                                      (call L.cons.125.17 cons.125 3080 22))
                                    (set! tmp.231
                                      (call
                                       L.cons.125.17
                                       cons.125
                                       488
                                       tmp.232)))
                                  (set! tmp.230
                                    (call L.pair?.129.10 pair?.129 tmp.231)))
                                (!= tmp.230 6))
                            (if (!= 14 6)
                              (set! tmp.20.72 22)
                              (set! tmp.20.72 22))
                            (set! tmp.20.72 22))
                          (if (!= tmp.20.72 6)
                            tmp.20.72
                            (begin (if (!= 6 6) 22 22))))))))))))))))
(check-by-interp
 '(module
    (define L.lam.66.14 (lambda (c.71) (begin (begin 14))))
    (define L.fun/boolean8734.10.13
      (lambda (c.70)
        (begin
          (set! fun/boolean8735.8 (mref c.70 14))
          (call L.fun/boolean8735.8.11 fun/boolean8735.8))))
    (define L.fun/error8737.9.12 (lambda (c.69) (begin 62014)))
    (define L.fun/boolean8735.8.11 (lambda (c.68) (begin 6)))
    (define L.fun/error8736.7.10
      (lambda (c.67)
        (begin
          (set! fun/error8737.9 (mref c.67 14))
          (call L.fun/error8737.9.12 fun/error8737.9))))
    (begin
      (begin
        (begin (set! tmp.77 (alloc 24)) (set! tmp.72 (+ tmp.77 2)))
        (begin
          (mset! tmp.72 -2 L.fun/error8736.7.10)
          (mset! tmp.72 6 0)
          (set! fun/error8736.7 tmp.72)))
      (begin
        (begin (set! tmp.78 (alloc 16)) (set! tmp.73 (+ tmp.78 2)))
        (begin
          (mset! tmp.73 -2 L.fun/boolean8735.8.11)
          (mset! tmp.73 6 0)
          (set! fun/boolean8735.8 tmp.73)))
      (begin
        (begin (set! tmp.79 (alloc 16)) (set! tmp.74 (+ tmp.79 2)))
        (begin
          (mset! tmp.74 -2 L.fun/error8737.9.12)
          (mset! tmp.74 6 0)
          (set! fun/error8737.9 tmp.74)))
      (begin
        (begin (set! tmp.80 (alloc 24)) (set! tmp.75 (+ tmp.80 2)))
        (begin
          (mset! tmp.75 -2 L.fun/boolean8734.10.13)
          (mset! tmp.75 6 0)
          (set! fun/boolean8734.10 tmp.75)))
      (begin
        (mset! fun/error8736.7 14 fun/error8737.9)
        (mset! fun/boolean8734.10 14 fun/boolean8735.8)
        (begin
          (begin
            (begin
              (begin (set! tmp.81 (alloc 16)) (set! tmp.76 (+ tmp.81 2)))
              (begin
                (mset! tmp.76 -2 L.lam.66.14)
                (mset! tmp.76 6 0)
                (set! lam.66 tmp.76)))
            (set! procedure0.13 lam.66))
          (set! boolean1.12 (call L.fun/boolean8734.10.13 fun/boolean8734.10))
          (if (!= 14 6)
            (set! ascii-char2.11 31278)
            (set! ascii-char2.11 29998))
          (call L.fun/error8736.7.10 fun/error8736.7))))))
(check-by-interp
 '(module
    (define L.fun/void8740.12.12
      (lambda (c.85 oprand0.14 oprand1.13) (begin 30)))
    (define L.fun/void8741.11.11 (lambda (c.84) (begin 30)))
    (define L.error?.82.10
      (lambda (c.83 tmp.72)
        (begin
          (if (begin (set! tmp.89 (bitwise-and tmp.72 255)) (= tmp.89 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.90 (alloc 16)) (set! tmp.86 (+ tmp.90 2)))
        (begin
          (mset! tmp.86 -2 L.error?.82.10)
          (mset! tmp.86 6 8)
          (set! error?.82 tmp.86)))
      (begin
        (begin (set! tmp.91 (alloc 16)) (set! tmp.87 (+ tmp.91 2)))
        (begin
          (mset! tmp.87 -2 L.fun/void8741.11.11)
          (mset! tmp.87 6 0)
          (set! fun/void8741.11 tmp.87)))
      (begin
        (begin (set! tmp.92 (alloc 16)) (set! tmp.88 (+ tmp.92 2)))
        (begin
          (mset! tmp.88 -2 L.fun/void8740.12.12)
          (mset! tmp.88 6 16)
          (set! fun/void8740.12 tmp.88)))
      (begin
        (begin
          (set! g42993474.15
            (call L.fun/void8740.12.12 fun/void8740.12 1528 576))
          (if (begin
                (set! tmp.93 (call L.error?.82.10 error?.82 g42993474.15))
                (!= tmp.93 6))
            g42993474.15
            (begin
              (begin
                (set! g42993476.17 30)
                (if (begin
                      (set! tmp.94
                        (call L.error?.82.10 error?.82 g42993476.17))
                      (!= tmp.94 6))
                  (set! g42993475.16 g42993476.17)
                  (begin
                    (set! g42993477.18 30)
                    (if (begin
                          (set! tmp.95
                            (call L.error?.82.10 error?.82 g42993477.18))
                          (!= tmp.95 6))
                      (set! g42993475.16 g42993477.18)
                      (begin
                        (set! g42993478.19 30)
                        (if (begin
                              (set! tmp.96
                                (call L.error?.82.10 error?.82 g42993478.19))
                              (!= tmp.96 6))
                          (set! g42993475.16 g42993478.19)
                          (begin
                            (set! g42993479.20 30)
                            (if (begin
                                  (set! tmp.97
                                    (call
                                     L.error?.82.10
                                     error?.82
                                     g42993479.20))
                                  (!= tmp.97 6))
                              (set! g42993475.16 g42993479.20)
                              (begin
                                (set! g42993480.21 30)
                                (if (begin
                                      (set! tmp.98
                                        (call
                                         L.error?.82.10
                                         error?.82
                                         g42993480.21))
                                      (!= tmp.98 6))
                                  (set! g42993475.16 g42993480.21)
                                  (set! g42993475.16 30)))))))))))
              (if (begin
                    (set! tmp.99 (call L.error?.82.10 error?.82 g42993475.16))
                    (!= tmp.99 6))
                g42993475.16
                (begin
                  (set! g42993481.22
                    (call L.fun/void8741.11.11 fun/void8741.11))
                  (if (begin
                        (set! tmp.100
                          (call L.error?.82.10 error?.82 g42993481.22))
                        (!= tmp.100 6))
                    g42993481.22
                    (begin
                      (begin (set! g42993482.23 30))
                      (if (begin
                            (set! tmp.101
                              (call L.error?.82.10 error?.82 g42993482.23))
                            (!= tmp.101 6))
                        g42993482.23
                        (begin
                          (begin
                            (set! tmp.7.25 30)
                            (if (!= tmp.7.25 6)
                              (set! g42993483.24 tmp.7.25)
                              (begin
                                (set! tmp.8.26 30)
                                (if (!= tmp.8.26 6)
                                  (set! g42993483.24 tmp.8.26)
                                  (begin
                                    (set! tmp.9.27 30)
                                    (if (!= tmp.9.27 6)
                                      (set! g42993483.24 tmp.9.27)
                                      (begin
                                        (set! tmp.10.28 30)
                                        (if (!= tmp.10.28 6)
                                          (set! g42993483.24 tmp.10.28)
                                          (set! g42993483.24 30)))))))))
                          (if (begin
                                (set! tmp.102
                                  (call L.error?.82.10 error?.82 g42993483.24))
                                (!= tmp.102 6))
                            g42993483.24
                            (begin (set! fixnum0.29 1512) 30)))))))))))))))
(check-by-interp
 '(module
    (define L.fun/empty8747.12.21 (lambda (c.92) (begin 22)))
    (define L.fun/empty8746.11.20
      (lambda (c.91)
        (begin
          (set! fun/empty8747.12 (mref c.91 14))
          (call L.fun/empty8747.12.21 fun/empty8747.12))))
    (define L.fun/vector8748.10.19
      (lambda (c.90)
        (begin
          (set! vector-set!.78 (mref c.90 14))
          (set! error?.79 (mref c.90 22))
          (set! make-vector.77 (mref c.90 30))
          (begin
            (set! tmp.7.14 (call L.make-vector.77.16 make-vector.77 64))
            (begin
              (set! g42997298.15
                (call L.vector-set!.78.13 vector-set!.78 tmp.7.14 0 0))
              (if (begin
                    (set! tmp.106 (call L.error?.79.11 error?.79 g42997298.15))
                    (!= tmp.106 6))
                g42997298.15
                (begin
                  (set! g42997299.16
                    (call L.vector-set!.78.13 vector-set!.78 tmp.7.14 8 8))
                  (if (begin
                        (set! tmp.107
                          (call L.error?.79.11 error?.79 g42997299.16))
                        (!= tmp.107 6))
                    g42997299.16
                    (begin
                      (set! g42997300.17
                        (call
                         L.vector-set!.78.13
                         vector-set!.78
                         tmp.7.14
                         16
                         16))
                      (if (begin
                            (set! tmp.108
                              (call L.error?.79.11 error?.79 g42997300.17))
                            (!= tmp.108 6))
                        g42997300.17
                        (begin
                          (set! g42997301.18
                            (call
                             L.vector-set!.78.13
                             vector-set!.78
                             tmp.7.14
                             24
                             24))
                          (if (begin
                                (set! tmp.109
                                  (call L.error?.79.11 error?.79 g42997301.18))
                                (!= tmp.109 6))
                            g42997301.18
                            (begin
                              (set! g42997302.19
                                (call
                                 L.vector-set!.78.13
                                 vector-set!.78
                                 tmp.7.14
                                 32
                                 32))
                              (if (begin
                                    (set! tmp.110
                                      (call
                                       L.error?.79.11
                                       error?.79
                                       g42997302.19))
                                    (!= tmp.110 6))
                                g42997302.19
                                (begin
                                  (set! g42997303.20
                                    (call
                                     L.vector-set!.78.13
                                     vector-set!.78
                                     tmp.7.14
                                     40
                                     40))
                                  (if (begin
                                        (set! tmp.111
                                          (call
                                           L.error?.79.11
                                           error?.79
                                           g42997303.20))
                                        (!= tmp.111 6))
                                    g42997303.20
                                    (begin
                                      (set! g42997304.21
                                        (call
                                         L.vector-set!.78.13
                                         vector-set!.78
                                         tmp.7.14
                                         48
                                         48))
                                      (if (begin
                                            (set! tmp.112
                                              (call
                                               L.error?.79.11
                                               error?.79
                                               g42997304.21))
                                            (!= tmp.112 6))
                                        g42997304.21
                                        (begin
                                          (set! g42997305.22
                                            (call
                                             L.vector-set!.78.13
                                             vector-set!.78
                                             tmp.7.14
                                             56
                                             56))
                                          (if (begin
                                                (set! tmp.113
                                                  (call
                                                   L.error?.79.11
                                                   error?.79
                                                   g42997305.22))
                                                (!= tmp.113 6))
                                            g42997305.22
                                            tmp.7.14))))))))))))))))))))
    (define L.fun/empty8744.9.18
      (lambda (c.89 oprand0.13)
        (begin
          (set! fun/empty8745.8 (mref c.89 14))
          (call L.fun/empty8745.8.17 fun/empty8745.8))))
    (define L.fun/empty8745.8.17
      (lambda (c.88)
        (begin
          (set! fun/empty8746.11 (mref c.88 14))
          (call L.fun/empty8746.11.20 fun/empty8746.11))))
    (define L.make-vector.77.16
      (lambda (c.87 tmp.53)
        (begin
          (set! make-init-vector.4 (mref c.87 14))
          (if (begin
                (if (begin (set! tmp.115 (bitwise-and tmp.53 7)) (= tmp.115 0))
                  (set! tmp.114 14)
                  (set! tmp.114 6))
                (!= tmp.114 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.53)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.86 tmp.25)
        (begin
          (set! vector-init-loop.27 (mref c.86 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.119 (arithmetic-shift-right tmp.25 3))
                      (set! tmp.118 (+ 1 tmp.119)))
                    (set! tmp.117 (* tmp.118 8)))
                  (set! tmp.116 (alloc tmp.117)))
                (set! tmp.93 (+ tmp.116 3)))
              (begin (mset! tmp.93 -3 tmp.25) (set! tmp.26 tmp.93)))
            (call
             L.vector-init-loop.27.14
             vector-init-loop.27
             tmp.25
             0
             tmp.26)))))
    (define L.vector-init-loop.27.14
      (lambda (c.85 len.28 i.30 vec.29)
        (begin
          (set! vector-init-loop.27 (mref c.85 14))
          (if (begin
                (if (= len.28 i.30) (set! tmp.120 14) (set! tmp.120 6))
                (!= tmp.120 6))
            vec.29
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.123 (arithmetic-shift-right i.30 3))
                    (set! tmp.122 (* tmp.123 8)))
                  (set! tmp.121 (+ tmp.122 5)))
                (mset! vec.29 tmp.121 0))
              (begin
                (set! tmp.124 (+ i.30 8))
                (call
                 L.vector-init-loop.27.14
                 vector-init-loop.27
                 len.28
                 tmp.124
                 vec.29)))))))
    (define L.vector-set!.78.13
      (lambda (c.84 tmp.55 tmp.56 tmp.57)
        (begin
          (set! unsafe-vector-set!.5 (mref c.84 14))
          (if (begin
                (if (begin (set! tmp.126 (bitwise-and tmp.56 7)) (= tmp.126 0))
                  (set! tmp.125 14)
                  (set! tmp.125 6))
                (!= tmp.125 6))
            (if (begin
                  (if (begin
                        (set! tmp.128 (bitwise-and tmp.55 7))
                        (= tmp.128 3))
                    (set! tmp.127 14)
                    (set! tmp.127 6))
                  (!= tmp.127 6))
              (call
               L.unsafe-vector-set!.5.12
               unsafe-vector-set!.5
               tmp.55
               tmp.56
               tmp.57)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.12
      (lambda (c.83 tmp.31 tmp.32 tmp.33)
        (begin
          (if (begin
                (if (begin (set! tmp.130 (mref tmp.31 -3)) (< tmp.32 tmp.130))
                  (set! tmp.129 14)
                  (set! tmp.129 6))
                (!= tmp.129 6))
            (if (begin
                  (if (>= tmp.32 0) (set! tmp.131 14) (set! tmp.131 6))
                  (!= tmp.131 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.134 (arithmetic-shift-right tmp.32 3))
                      (set! tmp.133 (* tmp.134 8)))
                    (set! tmp.132 (+ tmp.133 5)))
                  (mset! tmp.31 tmp.132 tmp.33))
                30)
              2622)
            2622))))
    (define L.error?.79.11
      (lambda (c.82 tmp.67)
        (begin
          (if (begin (set! tmp.135 (bitwise-and tmp.67 255)) (= tmp.135 62))
            14
            6))))
    (define L.+.80.10
      (lambda (c.81 tmp.41 tmp.42)
        (begin
          (if (begin
                (if (begin (set! tmp.137 (bitwise-and tmp.42 7)) (= tmp.137 0))
                  (set! tmp.136 14)
                  (set! tmp.136 6))
                (!= tmp.136 6))
            (if (begin
                  (if (begin
                        (set! tmp.139 (bitwise-and tmp.41 7))
                        (= tmp.139 0))
                    (set! tmp.138 14)
                    (set! tmp.138 6))
                  (!= tmp.138 6))
              (+ tmp.41 tmp.42)
              574)
            574))))
    (begin
      (begin
        (begin (set! tmp.140 (alloc 16)) (set! tmp.94 (+ tmp.140 2)))
        (begin
          (mset! tmp.94 -2 L.+.80.10)
          (mset! tmp.94 6 16)
          (set! |+.80| tmp.94)))
      (begin
        (begin (set! tmp.141 (alloc 16)) (set! tmp.95 (+ tmp.141 2)))
        (begin
          (mset! tmp.95 -2 L.error?.79.11)
          (mset! tmp.95 6 8)
          (set! error?.79 tmp.95)))
      (begin
        (begin (set! tmp.142 (alloc 16)) (set! tmp.96 (+ tmp.142 2)))
        (begin
          (mset! tmp.96 -2 L.unsafe-vector-set!.5.12)
          (mset! tmp.96 6 24)
          (set! unsafe-vector-set!.5 tmp.96)))
      (begin
        (begin (set! tmp.143 (alloc 24)) (set! tmp.97 (+ tmp.143 2)))
        (begin
          (mset! tmp.97 -2 L.vector-set!.78.13)
          (mset! tmp.97 6 24)
          (set! vector-set!.78 tmp.97)))
      (begin
        (begin (set! tmp.144 (alloc 24)) (set! tmp.98 (+ tmp.144 2)))
        (begin
          (mset! tmp.98 -2 L.vector-init-loop.27.14)
          (mset! tmp.98 6 24)
          (set! vector-init-loop.27 tmp.98)))
      (begin
        (begin (set! tmp.145 (alloc 24)) (set! tmp.99 (+ tmp.145 2)))
        (begin
          (mset! tmp.99 -2 L.make-init-vector.4.15)
          (mset! tmp.99 6 8)
          (set! make-init-vector.4 tmp.99)))
      (begin
        (begin (set! tmp.146 (alloc 24)) (set! tmp.100 (+ tmp.146 2)))
        (begin
          (mset! tmp.100 -2 L.make-vector.77.16)
          (mset! tmp.100 6 8)
          (set! make-vector.77 tmp.100)))
      (begin
        (begin (set! tmp.147 (alloc 24)) (set! tmp.101 (+ tmp.147 2)))
        (begin
          (mset! tmp.101 -2 L.fun/empty8745.8.17)
          (mset! tmp.101 6 0)
          (set! fun/empty8745.8 tmp.101)))
      (begin
        (begin (set! tmp.148 (alloc 24)) (set! tmp.102 (+ tmp.148 2)))
        (begin
          (mset! tmp.102 -2 L.fun/empty8744.9.18)
          (mset! tmp.102 6 8)
          (set! fun/empty8744.9 tmp.102)))
      (begin
        (begin (set! tmp.149 (alloc 40)) (set! tmp.103 (+ tmp.149 2)))
        (begin
          (mset! tmp.103 -2 L.fun/vector8748.10.19)
          (mset! tmp.103 6 0)
          (set! fun/vector8748.10 tmp.103)))
      (begin
        (begin (set! tmp.150 (alloc 24)) (set! tmp.104 (+ tmp.150 2)))
        (begin
          (mset! tmp.104 -2 L.fun/empty8746.11.20)
          (mset! tmp.104 6 0)
          (set! fun/empty8746.11 tmp.104)))
      (begin
        (begin (set! tmp.151 (alloc 16)) (set! tmp.105 (+ tmp.151 2)))
        (begin
          (mset! tmp.105 -2 L.fun/empty8747.12.21)
          (mset! tmp.105 6 0)
          (set! fun/empty8747.12 tmp.105)))
      (begin
        (mset! vector-set!.78 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.27 14 vector-init-loop.27)
        (mset! make-init-vector.4 14 vector-init-loop.27)
        (mset! make-vector.77 14 make-init-vector.4)
        (mset! fun/empty8745.8 14 fun/empty8746.11)
        (mset! fun/empty8744.9 14 fun/empty8745.8)
        (mset! fun/vector8748.10 14 vector-set!.78)
        (mset! fun/vector8748.10 22 error?.79)
        (mset! fun/vector8748.10 30 make-vector.77)
        (mset! fun/empty8746.11 14 fun/empty8747.12)
        (begin
          (begin
            (set! fixnum0.24 (call L.+.80.10 |+.80| 1672 1840))
            (begin (set! fixnum1.23 1568))
            (set! tmp.152 (call L.fun/vector8748.10.19 fun/vector8748.10)))
          (call L.fun/empty8744.9.18 fun/empty8744.9 tmp.152))))))
(check-by-interp '(module (begin (if (!= 6 6) 30 30))))
(check-by-interp
 '(module
    (define L.lam.81.13 (lambda (c.85) (begin 4208)))
    (define L.fun/boolean8753.10.12 (lambda (c.84 oprand0.11) (begin 14)))
    (define L.ascii-char?.79.11
      (lambda (c.83 tmp.68)
        (begin
          (if (begin (set! tmp.90 (bitwise-and tmp.68 255)) (= tmp.90 46))
            14
            6))))
    (define L.error?.80.10
      (lambda (c.82 tmp.69)
        (begin
          (if (begin (set! tmp.91 (bitwise-and tmp.69 255)) (= tmp.91 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.92 (alloc 16)) (set! tmp.86 (+ tmp.92 2)))
        (begin
          (mset! tmp.86 -2 L.error?.80.10)
          (mset! tmp.86 6 8)
          (set! error?.80 tmp.86)))
      (begin
        (begin (set! tmp.93 (alloc 16)) (set! tmp.87 (+ tmp.93 2)))
        (begin
          (mset! tmp.87 -2 L.ascii-char?.79.11)
          (mset! tmp.87 6 8)
          (set! ascii-char?.79 tmp.87)))
      (begin
        (begin (set! tmp.94 (alloc 16)) (set! tmp.88 (+ tmp.94 2)))
        (begin
          (mset! tmp.88 -2 L.fun/boolean8753.10.12)
          (mset! tmp.88 6 8)
          (set! fun/boolean8753.10 tmp.88)))
      (if (begin
            (set! ascii-char0.14 28974)
            (set! void1.13 30)
            (set! boolean2.12 14)
            (!= 14 6))
        (begin
          (set! empty0.17 22)
          (set! fixnum1.16 152)
          (set! boolean2.15 6)
          14)
        (begin
          (begin
            (begin
              (begin
                (begin (set! tmp.96 (alloc 16)) (set! tmp.89 (+ tmp.96 2)))
                (begin
                  (mset! tmp.89 -2 L.lam.81.13)
                  (mset! tmp.89 6 0)
                  (set! lam.81 tmp.89)))
              (set! tmp.95 lam.81))
            (set! tmp.7.18 (call L.ascii-char?.79.11 ascii-char?.79 tmp.95)))
          (if (!= tmp.7.18 6)
            tmp.7.18
            (begin
              (if (!= 6 6) (set! tmp.8.19 14) (set! tmp.8.19 14))
              (if (!= tmp.8.19 6)
                tmp.8.19
                (begin
                  (set! tmp.9.20
                    (call L.fun/boolean8753.10.12 fun/boolean8753.10 1560))
                  (if (!= tmp.9.20 6)
                    tmp.9.20
                    (begin
                      (set! g43004938.21 6)
                      (if (begin
                            (set! tmp.97
                              (call L.error?.80.10 error?.80 g43004938.21))
                            (!= tmp.97 6))
                        g43004938.21
                        (begin
                          (set! g43004939.22 6)
                          (if (begin
                                (set! tmp.98
                                  (call L.error?.80.10 error?.80 g43004939.22))
                                (!= tmp.98 6))
                            g43004939.22
                            (begin
                              (set! g43004940.23 14)
                              (if (begin
                                    (set! tmp.99
                                      (call
                                       L.error?.80.10
                                       error?.80
                                       g43004940.23))
                                    (!= tmp.99 6))
                                g43004940.23
                                (begin
                                  (set! g43004941.24 14)
                                  (if (begin
                                        (set! tmp.100
                                          (call
                                           L.error?.80.10
                                           error?.80
                                           g43004941.24))
                                        (!= tmp.100 6))
                                    g43004941.24
                                    (begin
                                      (set! g43004942.25 14)
                                      (if (begin
                                            (set! tmp.101
                                              (call
                                               L.error?.80.10
                                               error?.80
                                               g43004942.25))
                                            (!= tmp.101 6))
                                        g43004942.25
                                        (begin
                                          (set! g43004943.26 14)
                                          (if (begin
                                                (set! tmp.102
                                                  (call
                                                   L.error?.80.10
                                                   error?.80
                                                   g43004943.26))
                                                (!= tmp.102 6))
                                            g43004943.26
                                            6))))))))))))))))))))))
(check-by-interp
 '(module
    (define L.fun/boolean8756.9.18
      (lambda (c.88 oprand0.11 oprand1.10)
        (begin
          (set! fun/boolean8757.8 (mref c.88 14))
          (call L.fun/boolean8757.8.17 fun/boolean8757.8))))
    (define L.fun/boolean8757.8.17 (lambda (c.87) (begin 6)))
    (define L.make-vector.76.16
      (lambda (c.86 tmp.52)
        (begin
          (set! make-init-vector.4 (mref c.86 14))
          (if (begin
                (if (begin (set! tmp.100 (bitwise-and tmp.52 7)) (= tmp.100 0))
                  (set! tmp.99 14)
                  (set! tmp.99 6))
                (!= tmp.99 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.52)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.85 tmp.24)
        (begin
          (set! vector-init-loop.26 (mref c.85 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.104 (arithmetic-shift-right tmp.24 3))
                      (set! tmp.103 (+ 1 tmp.104)))
                    (set! tmp.102 (* tmp.103 8)))
                  (set! tmp.101 (alloc tmp.102)))
                (set! tmp.89 (+ tmp.101 3)))
              (begin (mset! tmp.89 -3 tmp.24) (set! tmp.25 tmp.89)))
            (call
             L.vector-init-loop.26.14
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.14
      (lambda (c.84 len.27 i.29 vec.28)
        (begin
          (set! vector-init-loop.26 (mref c.84 14))
          (if (begin
                (if (= len.27 i.29) (set! tmp.105 14) (set! tmp.105 6))
                (!= tmp.105 6))
            vec.28
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.108 (arithmetic-shift-right i.29 3))
                    (set! tmp.107 (* tmp.108 8)))
                  (set! tmp.106 (+ tmp.107 5)))
                (mset! vec.28 tmp.106 0))
              (begin
                (set! tmp.109 (+ i.29 8))
                (call
                 L.vector-init-loop.26.14
                 vector-init-loop.26
                 len.27
                 tmp.109
                 vec.28)))))))
    (define L.vector-set!.77.13
      (lambda (c.83 tmp.54 tmp.55 tmp.56)
        (begin
          (set! unsafe-vector-set!.5 (mref c.83 14))
          (if (begin
                (if (begin (set! tmp.111 (bitwise-and tmp.55 7)) (= tmp.111 0))
                  (set! tmp.110 14)
                  (set! tmp.110 6))
                (!= tmp.110 6))
            (if (begin
                  (if (begin
                        (set! tmp.113 (bitwise-and tmp.54 7))
                        (= tmp.113 3))
                    (set! tmp.112 14)
                    (set! tmp.112 6))
                  (!= tmp.112 6))
              (call
               L.unsafe-vector-set!.5.12
               unsafe-vector-set!.5
               tmp.54
               tmp.55
               tmp.56)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.12
      (lambda (c.82 tmp.30 tmp.31 tmp.32)
        (begin
          (if (begin
                (if (begin (set! tmp.115 (mref tmp.30 -3)) (< tmp.31 tmp.115))
                  (set! tmp.114 14)
                  (set! tmp.114 6))
                (!= tmp.114 6))
            (if (begin
                  (if (>= tmp.31 0) (set! tmp.116 14) (set! tmp.116 6))
                  (!= tmp.116 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.119 (arithmetic-shift-right tmp.31 3))
                      (set! tmp.118 (* tmp.119 8)))
                    (set! tmp.117 (+ tmp.118 5)))
                  (mset! tmp.30 tmp.117 tmp.32))
                30)
              2622)
            2622))))
    (define L.error?.78.11
      (lambda (c.81 tmp.66)
        (begin
          (if (begin (set! tmp.120 (bitwise-and tmp.66 255)) (= tmp.120 62))
            14
            6))))
    (define L.>=.79.10
      (lambda (c.80 tmp.50 tmp.51)
        (begin
          (if (begin
                (if (begin (set! tmp.122 (bitwise-and tmp.51 7)) (= tmp.122 0))
                  (set! tmp.121 14)
                  (set! tmp.121 6))
                (!= tmp.121 6))
            (if (begin
                  (if (begin
                        (set! tmp.124 (bitwise-and tmp.50 7))
                        (= tmp.124 0))
                    (set! tmp.123 14)
                    (set! tmp.123 6))
                  (!= tmp.123 6))
              (if (>= tmp.50 tmp.51) 14 6)
              1854)
            1854))))
    (begin
      (begin
        (begin (set! tmp.125 (alloc 16)) (set! tmp.90 (+ tmp.125 2)))
        (begin
          (mset! tmp.90 -2 L.>=.79.10)
          (mset! tmp.90 6 16)
          (set! >=.79 tmp.90)))
      (begin
        (begin (set! tmp.126 (alloc 16)) (set! tmp.91 (+ tmp.126 2)))
        (begin
          (mset! tmp.91 -2 L.error?.78.11)
          (mset! tmp.91 6 8)
          (set! error?.78 tmp.91)))
      (begin
        (begin (set! tmp.127 (alloc 16)) (set! tmp.92 (+ tmp.127 2)))
        (begin
          (mset! tmp.92 -2 L.unsafe-vector-set!.5.12)
          (mset! tmp.92 6 24)
          (set! unsafe-vector-set!.5 tmp.92)))
      (begin
        (begin (set! tmp.128 (alloc 24)) (set! tmp.93 (+ tmp.128 2)))
        (begin
          (mset! tmp.93 -2 L.vector-set!.77.13)
          (mset! tmp.93 6 24)
          (set! vector-set!.77 tmp.93)))
      (begin
        (begin (set! tmp.129 (alloc 24)) (set! tmp.94 (+ tmp.129 2)))
        (begin
          (mset! tmp.94 -2 L.vector-init-loop.26.14)
          (mset! tmp.94 6 24)
          (set! vector-init-loop.26 tmp.94)))
      (begin
        (begin (set! tmp.130 (alloc 24)) (set! tmp.95 (+ tmp.130 2)))
        (begin
          (mset! tmp.95 -2 L.make-init-vector.4.15)
          (mset! tmp.95 6 8)
          (set! make-init-vector.4 tmp.95)))
      (begin
        (begin (set! tmp.131 (alloc 24)) (set! tmp.96 (+ tmp.131 2)))
        (begin
          (mset! tmp.96 -2 L.make-vector.76.16)
          (mset! tmp.96 6 8)
          (set! make-vector.76 tmp.96)))
      (begin
        (begin (set! tmp.132 (alloc 16)) (set! tmp.97 (+ tmp.132 2)))
        (begin
          (mset! tmp.97 -2 L.fun/boolean8757.8.17)
          (mset! tmp.97 6 0)
          (set! fun/boolean8757.8 tmp.97)))
      (begin
        (begin (set! tmp.133 (alloc 24)) (set! tmp.98 (+ tmp.133 2)))
        (begin
          (mset! tmp.98 -2 L.fun/boolean8756.9.18)
          (mset! tmp.98 6 16)
          (set! fun/boolean8756.9 tmp.98)))
      (begin
        (mset! vector-set!.77 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.26 14 vector-init-loop.26)
        (mset! make-init-vector.4 14 vector-init-loop.26)
        (mset! make-vector.76 14 make-init-vector.4)
        (mset! fun/boolean8756.9 14 fun/boolean8757.8)
        (if (begin
              (begin
                (begin
                  (set! void0.12 30)
                  (begin
                    (set! tmp.7.13
                      (call L.make-vector.76.16 make-vector.76 64))
                    (begin
                      (set! g43008758.14
                        (call L.vector-set!.77.13 vector-set!.77 tmp.7.13 0 8))
                      (if (begin
                            (set! tmp.136
                              (call L.error?.78.11 error?.78 g43008758.14))
                            (!= tmp.136 6))
                        (set! tmp.135 g43008758.14)
                        (begin
                          (set! g43008759.15
                            (call
                             L.vector-set!.77.13
                             vector-set!.77
                             tmp.7.13
                             8
                             16))
                          (if (begin
                                (set! tmp.137
                                  (call L.error?.78.11 error?.78 g43008759.15))
                                (!= tmp.137 6))
                            (set! tmp.135 g43008759.15)
                            (begin
                              (set! g43008760.16
                                (call
                                 L.vector-set!.77.13
                                 vector-set!.77
                                 tmp.7.13
                                 16
                                 24))
                              (if (begin
                                    (set! tmp.138
                                      (call
                                       L.error?.78.11
                                       error?.78
                                       g43008760.16))
                                    (!= tmp.138 6))
                                (set! tmp.135 g43008760.16)
                                (begin
                                  (set! g43008761.17
                                    (call
                                     L.vector-set!.77.13
                                     vector-set!.77
                                     tmp.7.13
                                     24
                                     32))
                                  (if (begin
                                        (set! tmp.139
                                          (call
                                           L.error?.78.11
                                           error?.78
                                           g43008761.17))
                                        (!= tmp.139 6))
                                    (set! tmp.135 g43008761.17)
                                    (begin
                                      (set! g43008762.18
                                        (call
                                         L.vector-set!.77.13
                                         vector-set!.77
                                         tmp.7.13
                                         32
                                         40))
                                      (if (begin
                                            (set! tmp.140
                                              (call
                                               L.error?.78.11
                                               error?.78
                                               g43008762.18))
                                            (!= tmp.140 6))
                                        (set! tmp.135 g43008762.18)
                                        (begin
                                          (set! g43008763.19
                                            (call
                                             L.vector-set!.77.13
                                             vector-set!.77
                                             tmp.7.13
                                             40
                                             48))
                                          (if (begin
                                                (set! tmp.141
                                                  (call
                                                   L.error?.78.11
                                                   error?.78
                                                   g43008763.19))
                                                (!= tmp.141 6))
                                            (set! tmp.135 g43008763.19)
                                            (begin
                                              (set! g43008764.20
                                                (call
                                                 L.vector-set!.77.13
                                                 vector-set!.77
                                                 tmp.7.13
                                                 48
                                                 56))
                                              (if (begin
                                                    (set! tmp.142
                                                      (call
                                                       L.error?.78.11
                                                       error?.78
                                                       g43008764.20))
                                                    (!= tmp.142 6))
                                                (set! tmp.135 g43008764.20)
                                                (begin
                                                  (set! g43008765.21
                                                    (call
                                                     L.vector-set!.77.13
                                                     vector-set!.77
                                                     tmp.7.13
                                                     56
                                                     64))
                                                  (if (begin
                                                        (set! tmp.143
                                                          (call
                                                           L.error?.78.11
                                                           error?.78
                                                           g43008765.21))
                                                        (!= tmp.143 6))
                                                    (set! tmp.135 g43008765.21)
                                                    (set! tmp.135
                                                      tmp.7.13)))))))))))))))))))
                (begin
                  (set! tmp.144 (call L.>=.79.10 >=.79 888 1704))
                  (set! tmp.134
                    (call
                     L.fun/boolean8756.9.18
                     fun/boolean8756.9
                     tmp.135
                     tmp.144))))
              (!= tmp.134 6))
          (if (!= 14 6) 20782 28718)
          (begin (set! empty0.23 22) (set! fixnum1.22 752) 27694))))))
(check-by-interp
 '(module
    (define L.fun/empty8760.10.12 (lambda (c.72) (begin 22)))
    (define L.fun/empty8761.9.11 (lambda (c.71) (begin 22)))
    (define L.cons.69.10
      (lambda (c.70 tmp.64 tmp.65)
        (begin
          (begin
            (begin (set! tmp.77 (alloc 16)) (set! tmp.73 (+ tmp.77 1)))
            (begin (mset! tmp.73 -1 tmp.64) (mset! tmp.73 7 tmp.65) tmp.73)))))
    (begin
      (begin
        (begin (set! tmp.78 (alloc 16)) (set! tmp.74 (+ tmp.78 2)))
        (begin
          (mset! tmp.74 -2 L.cons.69.10)
          (mset! tmp.74 6 16)
          (set! cons.69 tmp.74)))
      (begin
        (begin (set! tmp.79 (alloc 16)) (set! tmp.75 (+ tmp.79 2)))
        (begin
          (mset! tmp.75 -2 L.fun/empty8761.9.11)
          (mset! tmp.75 6 0)
          (set! fun/empty8761.9 tmp.75)))
      (begin
        (begin (set! tmp.80 (alloc 16)) (set! tmp.76 (+ tmp.80 2)))
        (begin
          (mset! tmp.76 -2 L.fun/empty8760.10.12)
          (mset! tmp.76 6 0)
          (set! fun/empty8760.10 tmp.76)))
      (begin
        (begin
          (set! tmp.7.13 (call L.fun/empty8760.10.12 fun/empty8760.10))
          (if (!= tmp.7.13 6)
            (set! empty0.12 tmp.7.13)
            (begin
              (if (!= 14 6) (set! tmp.8.14 22) (set! tmp.8.14 22))
              (if (!= tmp.8.14 6)
                (set! empty0.12 tmp.8.14)
                (set! empty0.12
                  (call L.fun/empty8761.9.11 fun/empty8761.9))))))
        (begin (set! empty1.11 22))
        (if (begin
              (begin
                (set! tmp.81 (call L.cons.69.10 cons.69 2624 22))
                (set! pair0.15 (call L.cons.69.10 cons.69 1312 tmp.81)))
              (!= 23086 6))
          (if (if (!= 29230 6)
                (if (!= 23086 6)
                  (if (!= 27182 6)
                    (if (!= 27182 6) (!= 24110 6) (!= 6 6))
                    (!= 6 6))
                  (!= 6 6))
                (!= 6 6))
            (if (if (!= 14 6) (!= 22062 6) (!= 21038 6))
              (begin (set! fixnum0.16 784) 22574)
              6)
            6)
          6)))))
(check-by-interp
 '(module
    (define L.lam.84.20 (lambda (c.95) (begin 5296)))
    (define L.lam.83.19 (lambda (c.94) (begin 4176)))
    (define L.fun/boolean8764.11.18
      (lambda (c.93 oprand0.14 oprand1.13) (begin (begin 6))))
    (define L.fun/fixnum8765.10.17
      (lambda (c.92)
        (begin
          (set! fun/fixnum8766.9 (mref c.92 14))
          (call L.fun/fixnum8766.9.16 fun/fixnum8766.9 22))))
    (define L.fun/fixnum8766.9.16 (lambda (c.91 oprand0.12) (begin 528)))
    (define L.make-vector.80.15
      (lambda (c.90 tmp.56)
        (begin
          (set! make-init-vector.4 (mref c.90 14))
          (if (begin
                (if (begin (set! tmp.109 (bitwise-and tmp.56 7)) (= tmp.109 0))
                  (set! tmp.108 14)
                  (set! tmp.108 6))
                (!= tmp.108 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.56)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.89 tmp.28)
        (begin
          (set! vector-init-loop.30 (mref c.89 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.113 (arithmetic-shift-right tmp.28 3))
                      (set! tmp.112 (+ 1 tmp.113)))
                    (set! tmp.111 (* tmp.112 8)))
                  (set! tmp.110 (alloc tmp.111)))
                (set! tmp.96 (+ tmp.110 3)))
              (begin (mset! tmp.96 -3 tmp.28) (set! tmp.29 tmp.96)))
            (call
             L.vector-init-loop.30.13
             vector-init-loop.30
             tmp.28
             0
             tmp.29)))))
    (define L.vector-init-loop.30.13
      (lambda (c.88 len.31 i.33 vec.32)
        (begin
          (set! vector-init-loop.30 (mref c.88 14))
          (if (begin
                (if (= len.31 i.33) (set! tmp.114 14) (set! tmp.114 6))
                (!= tmp.114 6))
            vec.32
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.117 (arithmetic-shift-right i.33 3))
                    (set! tmp.116 (* tmp.117 8)))
                  (set! tmp.115 (+ tmp.116 5)))
                (mset! vec.32 tmp.115 0))
              (begin
                (set! tmp.118 (+ i.33 8))
                (call
                 L.vector-init-loop.30.13
                 vector-init-loop.30
                 len.31
                 tmp.118
                 vec.32)))))))
    (define L.vector-set!.81.12
      (lambda (c.87 tmp.58 tmp.59 tmp.60)
        (begin
          (set! unsafe-vector-set!.5 (mref c.87 14))
          (if (begin
                (if (begin (set! tmp.120 (bitwise-and tmp.59 7)) (= tmp.120 0))
                  (set! tmp.119 14)
                  (set! tmp.119 6))
                (!= tmp.119 6))
            (if (begin
                  (if (begin
                        (set! tmp.122 (bitwise-and tmp.58 7))
                        (= tmp.122 3))
                    (set! tmp.121 14)
                    (set! tmp.121 6))
                  (!= tmp.121 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.58
               tmp.59
               tmp.60)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.86 tmp.34 tmp.35 tmp.36)
        (begin
          (if (begin
                (if (begin (set! tmp.124 (mref tmp.34 -3)) (< tmp.35 tmp.124))
                  (set! tmp.123 14)
                  (set! tmp.123 6))
                (!= tmp.123 6))
            (if (begin
                  (if (>= tmp.35 0) (set! tmp.125 14) (set! tmp.125 6))
                  (!= tmp.125 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.128 (arithmetic-shift-right tmp.35 3))
                      (set! tmp.127 (* tmp.128 8)))
                    (set! tmp.126 (+ tmp.127 5)))
                  (mset! tmp.34 tmp.126 tmp.36))
                30)
              2622)
            2622))))
    (define L.error?.82.10
      (lambda (c.85 tmp.70)
        (begin
          (if (begin (set! tmp.129 (bitwise-and tmp.70 255)) (= tmp.129 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.130 (alloc 16)) (set! tmp.97 (+ tmp.130 2)))
        (begin
          (mset! tmp.97 -2 L.error?.82.10)
          (mset! tmp.97 6 8)
          (set! error?.82 tmp.97)))
      (begin
        (begin (set! tmp.131 (alloc 16)) (set! tmp.98 (+ tmp.131 2)))
        (begin
          (mset! tmp.98 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.98 6 24)
          (set! unsafe-vector-set!.5 tmp.98)))
      (begin
        (begin (set! tmp.132 (alloc 24)) (set! tmp.99 (+ tmp.132 2)))
        (begin
          (mset! tmp.99 -2 L.vector-set!.81.12)
          (mset! tmp.99 6 24)
          (set! vector-set!.81 tmp.99)))
      (begin
        (begin (set! tmp.133 (alloc 24)) (set! tmp.100 (+ tmp.133 2)))
        (begin
          (mset! tmp.100 -2 L.vector-init-loop.30.13)
          (mset! tmp.100 6 24)
          (set! vector-init-loop.30 tmp.100)))
      (begin
        (begin (set! tmp.134 (alloc 24)) (set! tmp.101 (+ tmp.134 2)))
        (begin
          (mset! tmp.101 -2 L.make-init-vector.4.14)
          (mset! tmp.101 6 8)
          (set! make-init-vector.4 tmp.101)))
      (begin
        (begin (set! tmp.135 (alloc 24)) (set! tmp.102 (+ tmp.135 2)))
        (begin
          (mset! tmp.102 -2 L.make-vector.80.15)
          (mset! tmp.102 6 8)
          (set! make-vector.80 tmp.102)))
      (begin
        (begin (set! tmp.136 (alloc 16)) (set! tmp.103 (+ tmp.136 2)))
        (begin
          (mset! tmp.103 -2 L.fun/fixnum8766.9.16)
          (mset! tmp.103 6 8)
          (set! fun/fixnum8766.9 tmp.103)))
      (begin
        (begin (set! tmp.137 (alloc 24)) (set! tmp.104 (+ tmp.137 2)))
        (begin
          (mset! tmp.104 -2 L.fun/fixnum8765.10.17)
          (mset! tmp.104 6 0)
          (set! fun/fixnum8765.10 tmp.104)))
      (begin
        (begin (set! tmp.138 (alloc 16)) (set! tmp.105 (+ tmp.138 2)))
        (begin
          (mset! tmp.105 -2 L.fun/boolean8764.11.18)
          (mset! tmp.105 6 16)
          (set! fun/boolean8764.11 tmp.105)))
      (begin
        (mset! vector-set!.81 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.30 14 vector-init-loop.30)
        (mset! make-init-vector.4 14 vector-init-loop.30)
        (mset! make-vector.80 14 make-init-vector.4)
        (mset! fun/fixnum8765.10 14 fun/fixnum8766.9)
        (if (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.141 (alloc 16))
                        (set! tmp.106 (+ tmp.141 2)))
                      (begin
                        (mset! tmp.106 -2 L.lam.83.19)
                        (mset! tmp.106 6 0)
                        (set! lam.83 tmp.106)))
                    (set! tmp.7.15 lam.83))
                  (if (!= tmp.7.15 6)
                    (set! tmp.140 tmp.7.15)
                    (begin
                      (begin
                        (begin
                          (set! tmp.142 (alloc 16))
                          (set! tmp.107 (+ tmp.142 2)))
                        (begin
                          (mset! tmp.107 -2 L.lam.84.20)
                          (mset! tmp.107 6 0)
                          (set! lam.84 tmp.107)))
                      (set! tmp.140 lam.84))))
                (begin
                  (begin (set! ascii-char0.16 31278) (set! tmp.143 30))
                  (set! tmp.139
                    (call
                     L.fun/boolean8764.11.18
                     fun/boolean8764.11
                     tmp.140
                     tmp.143))))
              (!= tmp.139 6))
          (begin
            (begin
              (set! tmp.8.19 (call L.make-vector.80.15 make-vector.80 64))
              (begin
                (set! g43016397.20
                  (call L.vector-set!.81.12 vector-set!.81 tmp.8.19 0 8))
                (if (begin
                      (set! tmp.144
                        (call L.error?.82.10 error?.82 g43016397.20))
                      (!= tmp.144 6))
                  (set! vector0.18 g43016397.20)
                  (begin
                    (set! g43016398.21
                      (call L.vector-set!.81.12 vector-set!.81 tmp.8.19 8 16))
                    (if (begin
                          (set! tmp.145
                            (call L.error?.82.10 error?.82 g43016398.21))
                          (!= tmp.145 6))
                      (set! vector0.18 g43016398.21)
                      (begin
                        (set! g43016399.22
                          (call
                           L.vector-set!.81.12
                           vector-set!.81
                           tmp.8.19
                           16
                           24))
                        (if (begin
                              (set! tmp.146
                                (call L.error?.82.10 error?.82 g43016399.22))
                              (!= tmp.146 6))
                          (set! vector0.18 g43016399.22)
                          (begin
                            (set! g43016400.23
                              (call
                               L.vector-set!.81.12
                               vector-set!.81
                               tmp.8.19
                               24
                               32))
                            (if (begin
                                  (set! tmp.147
                                    (call
                                     L.error?.82.10
                                     error?.82
                                     g43016400.23))
                                  (!= tmp.147 6))
                              (set! vector0.18 g43016400.23)
                              (begin
                                (set! g43016401.24
                                  (call
                                   L.vector-set!.81.12
                                   vector-set!.81
                                   tmp.8.19
                                   32
                                   40))
                                (if (begin
                                      (set! tmp.148
                                        (call
                                         L.error?.82.10
                                         error?.82
                                         g43016401.24))
                                      (!= tmp.148 6))
                                  (set! vector0.18 g43016401.24)
                                  (begin
                                    (set! g43016402.25
                                      (call
                                       L.vector-set!.81.12
                                       vector-set!.81
                                       tmp.8.19
                                       40
                                       48))
                                    (if (begin
                                          (set! tmp.149
                                            (call
                                             L.error?.82.10
                                             error?.82
                                             g43016402.25))
                                          (!= tmp.149 6))
                                      (set! vector0.18 g43016402.25)
                                      (begin
                                        (set! g43016403.26
                                          (call
                                           L.vector-set!.81.12
                                           vector-set!.81
                                           tmp.8.19
                                           48
                                           56))
                                        (if (begin
                                              (set! tmp.150
                                                (call
                                                 L.error?.82.10
                                                 error?.82
                                                 g43016403.26))
                                              (!= tmp.150 6))
                                          (set! vector0.18 g43016403.26)
                                          (begin
                                            (set! g43016404.27
                                              (call
                                               L.vector-set!.81.12
                                               vector-set!.81
                                               tmp.8.19
                                               56
                                               64))
                                            (if (begin
                                                  (set! tmp.151
                                                    (call
                                                     L.error?.82.10
                                                     error?.82
                                                     g43016404.27))
                                                  (!= tmp.151 6))
                                              (set! vector0.18 g43016404.27)
                                              (set! vector0.18
                                                tmp.8.19))))))))))))))))))
            (set! fixnum1.17 1688)
            184)
          (call L.fun/fixnum8765.10.17 fun/fixnum8765.10))))))
(check-by-interp
 '(module
    (begin
      (begin (set! fixnum0.8 1432) (set! boolean0.7 14))
      (if (!= 6 6) 22 22))))
(check-by-interp
 '(module
    (define L.fun/fixnum8772.11.17 (lambda (c.80 oprand0.14) (begin 696)))
    (define L.fun/fixnum8774.10.16 (lambda (c.79) (begin 1008)))
    (define L.fun/fixnum8775.9.15 (lambda (c.78 oprand0.13) (begin 936)))
    (define L.fun/fixnum8771.8.14
      (lambda (c.77)
        (begin
          (set! fun/fixnum8772.11 (mref c.77 14))
          (call L.fun/fixnum8772.11.17 fun/fixnum8772.11 6))))
    (define L.fun/fixnum8773.7.13
      (lambda (c.76 oprand0.12)
        (begin
          (set! fun/fixnum8774.10 (mref c.76 14))
          (call L.fun/fixnum8774.10.16 fun/fixnum8774.10))))
    (define L.*.70.12
      (lambda (c.75 tmp.32 tmp.33)
        (begin
          (if (begin
                (if (begin (set! tmp.91 (bitwise-and tmp.33 7)) (= tmp.91 0))
                  (set! tmp.90 14)
                  (set! tmp.90 6))
                (!= tmp.90 6))
            (if (begin
                  (if (begin (set! tmp.93 (bitwise-and tmp.32 7)) (= tmp.93 0))
                    (set! tmp.92 14)
                    (set! tmp.92 6))
                  (!= tmp.92 6))
              (begin
                (set! tmp.94 (arithmetic-shift-right tmp.33 3))
                (* tmp.32 tmp.94))
              318)
            318))))
    (define L.cons.71.11
      (lambda (c.74 tmp.65 tmp.66)
        (begin
          (begin
            (begin (set! tmp.95 (alloc 16)) (set! tmp.81 (+ tmp.95 1)))
            (begin (mset! tmp.81 -1 tmp.65) (mset! tmp.81 7 tmp.66) tmp.81)))))
    (define L.+.72.10
      (lambda (c.73 tmp.34 tmp.35)
        (begin
          (if (begin
                (if (begin (set! tmp.97 (bitwise-and tmp.35 7)) (= tmp.97 0))
                  (set! tmp.96 14)
                  (set! tmp.96 6))
                (!= tmp.96 6))
            (if (begin
                  (if (begin (set! tmp.99 (bitwise-and tmp.34 7)) (= tmp.99 0))
                    (set! tmp.98 14)
                    (set! tmp.98 6))
                  (!= tmp.98 6))
              (+ tmp.34 tmp.35)
              574)
            574))))
    (begin
      (begin
        (begin (set! tmp.100 (alloc 16)) (set! tmp.82 (+ tmp.100 2)))
        (begin
          (mset! tmp.82 -2 L.+.72.10)
          (mset! tmp.82 6 16)
          (set! |+.72| tmp.82)))
      (begin
        (begin (set! tmp.101 (alloc 16)) (set! tmp.83 (+ tmp.101 2)))
        (begin
          (mset! tmp.83 -2 L.cons.71.11)
          (mset! tmp.83 6 16)
          (set! cons.71 tmp.83)))
      (begin
        (begin (set! tmp.102 (alloc 16)) (set! tmp.84 (+ tmp.102 2)))
        (begin
          (mset! tmp.84 -2 L.*.70.12)
          (mset! tmp.84 6 16)
          (set! *.70 tmp.84)))
      (begin
        (begin (set! tmp.103 (alloc 24)) (set! tmp.85 (+ tmp.103 2)))
        (begin
          (mset! tmp.85 -2 L.fun/fixnum8773.7.13)
          (mset! tmp.85 6 8)
          (set! fun/fixnum8773.7 tmp.85)))
      (begin
        (begin (set! tmp.104 (alloc 24)) (set! tmp.86 (+ tmp.104 2)))
        (begin
          (mset! tmp.86 -2 L.fun/fixnum8771.8.14)
          (mset! tmp.86 6 0)
          (set! fun/fixnum8771.8 tmp.86)))
      (begin
        (begin (set! tmp.105 (alloc 16)) (set! tmp.87 (+ tmp.105 2)))
        (begin
          (mset! tmp.87 -2 L.fun/fixnum8775.9.15)
          (mset! tmp.87 6 8)
          (set! fun/fixnum8775.9 tmp.87)))
      (begin
        (begin (set! tmp.106 (alloc 16)) (set! tmp.88 (+ tmp.106 2)))
        (begin
          (mset! tmp.88 -2 L.fun/fixnum8774.10.16)
          (mset! tmp.88 6 0)
          (set! fun/fixnum8774.10 tmp.88)))
      (begin
        (begin (set! tmp.107 (alloc 16)) (set! tmp.89 (+ tmp.107 2)))
        (begin
          (mset! tmp.89 -2 L.fun/fixnum8772.11.17)
          (mset! tmp.89 6 8)
          (set! fun/fixnum8772.11 tmp.89)))
      (begin
        (mset! fun/fixnum8773.7 14 fun/fixnum8774.10)
        (mset! fun/fixnum8771.8 14 fun/fixnum8772.11)
        (begin
          (if (begin (!= 1704 6))
            (if (begin
                  (set! tmp.109 (call L.fun/fixnum8771.8.14 fun/fixnum8771.8))
                  (!= tmp.109 6))
              (if (if (!= 14 6) (!= 1752 6) (!= 96 6))
                (if (if (!= 6 6) (!= 1096 6) (!= 1120 6))
                  (if (begin
                        (begin
                          (set! tmp.111 (call L.*.70.12 *.70 1040 504))
                          (set! tmp.110
                            (call
                             L.fun/fixnum8773.7.13
                             fun/fixnum8773.7
                             tmp.111)))
                        (!= tmp.110 6))
                    (begin (set! tmp.108 1248))
                    (set! tmp.108 6))
                  (set! tmp.108 6))
                (set! tmp.108 6))
              (set! tmp.108 6))
            (set! tmp.108 6))
          (begin
            (if (begin
                  (set! fixnum0.17 800)
                  (begin
                    (set! tmp.113 (call L.cons.71.11 cons.71 3632 22))
                    (set! pair1.16 (call L.cons.71.11 cons.71 152 tmp.113)))
                  (begin
                    (set! tmp.114 (call L.cons.71.11 cons.71 3624 22))
                    (set! pair2.15 (call L.cons.71.11 cons.71 40 tmp.114)))
                  (!= 6 6))
              (set! tmp.112 (call L.+.72.10 |+.72| 992 256))
              (begin
                (begin
                  (set! tmp.116 (call L.cons.71.11 cons.71 3520 22))
                  (set! tmp.115 (call L.cons.71.11 cons.71 888 tmp.116)))
                (set! tmp.112
                  (call L.fun/fixnum8775.9.15 fun/fixnum8775.9 tmp.115))))
            (call L.+.72.10 |+.72| tmp.108 tmp.112)))))))
(check-by-interp '(module (begin (if (!= 14 6) 14 14))))
(check-by-interp
 '(module
    (define L.fun/empty8780.8.17 (lambda (c.84) (begin 22)))
    (define L.error?.73.16
      (lambda (c.83 tmp.63)
        (begin
          (if (begin (set! tmp.95 (bitwise-and tmp.63 255)) (= tmp.95 62))
            14
            6))))
    (define L.cons.74.15
      (lambda (c.82 tmp.68 tmp.69)
        (begin
          (begin
            (begin (set! tmp.96 (alloc 16)) (set! tmp.85 (+ tmp.96 1)))
            (begin (mset! tmp.85 -1 tmp.68) (mset! tmp.85 7 tmp.69) tmp.85)))))
    (define L.make-vector.75.14
      (lambda (c.81 tmp.49)
        (begin
          (set! make-init-vector.4 (mref c.81 14))
          (if (begin
                (if (begin (set! tmp.98 (bitwise-and tmp.49 7)) (= tmp.98 0))
                  (set! tmp.97 14)
                  (set! tmp.97 6))
                (!= tmp.97 6))
            (call L.make-init-vector.4.13 make-init-vector.4 tmp.49)
            2110))))
    (define L.make-init-vector.4.13
      (lambda (c.80 tmp.21)
        (begin
          (set! vector-init-loop.23 (mref c.80 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.102 (arithmetic-shift-right tmp.21 3))
                      (set! tmp.101 (+ 1 tmp.102)))
                    (set! tmp.100 (* tmp.101 8)))
                  (set! tmp.99 (alloc tmp.100)))
                (set! tmp.86 (+ tmp.99 3)))
              (begin (mset! tmp.86 -3 tmp.21) (set! tmp.22 tmp.86)))
            (call
             L.vector-init-loop.23.12
             vector-init-loop.23
             tmp.21
             0
             tmp.22)))))
    (define L.vector-init-loop.23.12
      (lambda (c.79 len.24 i.26 vec.25)
        (begin
          (set! vector-init-loop.23 (mref c.79 14))
          (if (begin
                (if (= len.24 i.26) (set! tmp.103 14) (set! tmp.103 6))
                (!= tmp.103 6))
            vec.25
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.106 (arithmetic-shift-right i.26 3))
                    (set! tmp.105 (* tmp.106 8)))
                  (set! tmp.104 (+ tmp.105 5)))
                (mset! vec.25 tmp.104 0))
              (begin
                (set! tmp.107 (+ i.26 8))
                (call
                 L.vector-init-loop.23.12
                 vector-init-loop.23
                 len.24
                 tmp.107
                 vec.25)))))))
    (define L.vector-set!.76.11
      (lambda (c.78 tmp.51 tmp.52 tmp.53)
        (begin
          (set! unsafe-vector-set!.5 (mref c.78 14))
          (if (begin
                (if (begin (set! tmp.109 (bitwise-and tmp.52 7)) (= tmp.109 0))
                  (set! tmp.108 14)
                  (set! tmp.108 6))
                (!= tmp.108 6))
            (if (begin
                  (if (begin
                        (set! tmp.111 (bitwise-and tmp.51 7))
                        (= tmp.111 3))
                    (set! tmp.110 14)
                    (set! tmp.110 6))
                  (!= tmp.110 6))
              (call
               L.unsafe-vector-set!.5.10
               unsafe-vector-set!.5
               tmp.51
               tmp.52
               tmp.53)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.10
      (lambda (c.77 tmp.27 tmp.28 tmp.29)
        (begin
          (if (begin
                (if (begin (set! tmp.113 (mref tmp.27 -3)) (< tmp.28 tmp.113))
                  (set! tmp.112 14)
                  (set! tmp.112 6))
                (!= tmp.112 6))
            (if (begin
                  (if (>= tmp.28 0) (set! tmp.114 14) (set! tmp.114 6))
                  (!= tmp.114 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.117 (arithmetic-shift-right tmp.28 3))
                      (set! tmp.116 (* tmp.117 8)))
                    (set! tmp.115 (+ tmp.116 5)))
                  (mset! tmp.27 tmp.115 tmp.29))
                30)
              2622)
            2622))))
    (begin
      (begin
        (begin (set! tmp.118 (alloc 16)) (set! tmp.87 (+ tmp.118 2)))
        (begin
          (mset! tmp.87 -2 L.unsafe-vector-set!.5.10)
          (mset! tmp.87 6 24)
          (set! unsafe-vector-set!.5 tmp.87)))
      (begin
        (begin (set! tmp.119 (alloc 24)) (set! tmp.88 (+ tmp.119 2)))
        (begin
          (mset! tmp.88 -2 L.vector-set!.76.11)
          (mset! tmp.88 6 24)
          (set! vector-set!.76 tmp.88)))
      (begin
        (begin (set! tmp.120 (alloc 24)) (set! tmp.89 (+ tmp.120 2)))
        (begin
          (mset! tmp.89 -2 L.vector-init-loop.23.12)
          (mset! tmp.89 6 24)
          (set! vector-init-loop.23 tmp.89)))
      (begin
        (begin (set! tmp.121 (alloc 24)) (set! tmp.90 (+ tmp.121 2)))
        (begin
          (mset! tmp.90 -2 L.make-init-vector.4.13)
          (mset! tmp.90 6 8)
          (set! make-init-vector.4 tmp.90)))
      (begin
        (begin (set! tmp.122 (alloc 24)) (set! tmp.91 (+ tmp.122 2)))
        (begin
          (mset! tmp.91 -2 L.make-vector.75.14)
          (mset! tmp.91 6 8)
          (set! make-vector.75 tmp.91)))
      (begin
        (begin (set! tmp.123 (alloc 16)) (set! tmp.92 (+ tmp.123 2)))
        (begin
          (mset! tmp.92 -2 L.cons.74.15)
          (mset! tmp.92 6 16)
          (set! cons.74 tmp.92)))
      (begin
        (begin (set! tmp.124 (alloc 16)) (set! tmp.93 (+ tmp.124 2)))
        (begin
          (mset! tmp.93 -2 L.error?.73.16)
          (mset! tmp.93 6 8)
          (set! error?.73 tmp.93)))
      (begin
        (begin (set! tmp.125 (alloc 16)) (set! tmp.94 (+ tmp.125 2)))
        (begin
          (mset! tmp.94 -2 L.fun/empty8780.8.17)
          (mset! tmp.94 6 0)
          (set! fun/empty8780.8 tmp.94)))
      (begin
        (mset! vector-set!.76 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.23 14 vector-init-loop.23)
        (mset! make-init-vector.4 14 vector-init-loop.23)
        (mset! make-vector.75 14 make-init-vector.4)
        (if (begin
              (begin
                (if (!= 14 6) (set! tmp.127 14) (set! tmp.127 25902))
                (set! tmp.126 (call L.error?.73.16 error?.73 tmp.127)))
              (!= tmp.126 6))
          (if (if (!= 22 6)
                (if (!= 22 6)
                  (if (!= 22 6) (if (!= 22 6) (!= 22 6) (!= 6 6)) (!= 6 6))
                  (!= 6 6))
                (!= 6 6))
            (if (if (!= 14 6) (!= 22 6) (!= 22 6))
              (if (if (!= 14 6) (!= 22 6) (!= 22 6))
                (if (begin
                      (set! tmp.128
                        (call L.fun/empty8780.8.17 fun/empty8780.8))
                      (!= tmp.128 6))
                  (if (begin
                        (begin
                          (set! tmp.129 (call L.cons.74.15 cons.74 3560 22))
                          (set! pair0.11
                            (call L.cons.74.15 cons.74 144 tmp.129)))
                        (begin
                          (set! tmp.7.12
                            (call L.make-vector.75.14 make-vector.75 64))
                          (begin
                            (set! g43031664.13
                              (call
                               L.vector-set!.76.11
                               vector-set!.76
                               tmp.7.12
                               0
                               8))
                            (if (begin
                                  (set! tmp.130
                                    (call
                                     L.error?.73.16
                                     error?.73
                                     g43031664.13))
                                  (!= tmp.130 6))
                              (set! vector1.10 g43031664.13)
                              (begin
                                (set! g43031665.14
                                  (call
                                   L.vector-set!.76.11
                                   vector-set!.76
                                   tmp.7.12
                                   8
                                   16))
                                (if (begin
                                      (set! tmp.131
                                        (call
                                         L.error?.73.16
                                         error?.73
                                         g43031665.14))
                                      (!= tmp.131 6))
                                  (set! vector1.10 g43031665.14)
                                  (begin
                                    (set! g43031666.15
                                      (call
                                       L.vector-set!.76.11
                                       vector-set!.76
                                       tmp.7.12
                                       16
                                       24))
                                    (if (begin
                                          (set! tmp.132
                                            (call
                                             L.error?.73.16
                                             error?.73
                                             g43031666.15))
                                          (!= tmp.132 6))
                                      (set! vector1.10 g43031666.15)
                                      (begin
                                        (set! g43031667.16
                                          (call
                                           L.vector-set!.76.11
                                           vector-set!.76
                                           tmp.7.12
                                           24
                                           32))
                                        (if (begin
                                              (set! tmp.133
                                                (call
                                                 L.error?.73.16
                                                 error?.73
                                                 g43031667.16))
                                              (!= tmp.133 6))
                                          (set! vector1.10 g43031667.16)
                                          (begin
                                            (set! g43031668.17
                                              (call
                                               L.vector-set!.76.11
                                               vector-set!.76
                                               tmp.7.12
                                               32
                                               40))
                                            (if (begin
                                                  (set! tmp.134
                                                    (call
                                                     L.error?.73.16
                                                     error?.73
                                                     g43031668.17))
                                                  (!= tmp.134 6))
                                              (set! vector1.10 g43031668.17)
                                              (begin
                                                (set! g43031669.18
                                                  (call
                                                   L.vector-set!.76.11
                                                   vector-set!.76
                                                   tmp.7.12
                                                   40
                                                   48))
                                                (if (begin
                                                      (set! tmp.135
                                                        (call
                                                         L.error?.73.16
                                                         error?.73
                                                         g43031669.18))
                                                      (!= tmp.135 6))
                                                  (set! vector1.10
                                                    g43031669.18)
                                                  (begin
                                                    (set! g43031670.19
                                                      (call
                                                       L.vector-set!.76.11
                                                       vector-set!.76
                                                       tmp.7.12
                                                       48
                                                       56))
                                                    (if (begin
                                                          (set! tmp.136
                                                            (call
                                                             L.error?.73.16
                                                             error?.73
                                                             g43031670.19))
                                                          (!= tmp.136 6))
                                                      (set! vector1.10
                                                        g43031670.19)
                                                      (begin
                                                        (set! g43031671.20
                                                          (call
                                                           L.vector-set!.76.11
                                                           vector-set!.76
                                                           tmp.7.12
                                                           56
                                                           64))
                                                        (if (begin
                                                              (set! tmp.137
                                                                (call
                                                                 L.error?.73.16
                                                                 error?.73
                                                                 g43031671.20))
                                                              (!= tmp.137 6))
                                                          (set! vector1.10
                                                            g43031671.20)
                                                          (set! vector1.10
                                                            tmp.7.12))))))))))))))))))
                        (begin
                          (set! tmp.138 (call L.cons.74.15 cons.74 2528 22))
                          (set! pair2.9
                            (call L.cons.74.15 cons.74 1552 tmp.138)))
                        (!= 22 6))
                    (if (!= 14 6) 22 22)
                    6)
                  6)
                6)
              6)
            6)
          (if (!= 6 6) 22 22))))))
(check-by-interp
 '(module
    (define L.lam.164.26 (lambda (c.181) (begin 6336)))
    (define L.fun/ascii-char8784.29.25
      (lambda (c.180)
        (begin
          (set! fun/ascii-char8785.26 (mref c.180 14))
          (call L.fun/ascii-char8785.26.22 fun/ascii-char8785.26))))
    (define L.fun/void8787.28.24
      (lambda (c.179 oprand0.36)
        (begin
          (set! cons.160 (mref c.179 14))
          (set! vector-set!.161 (mref c.179 22))
          (begin
            (begin
              (set! tmp.202 (call L.cons.160.16 cons.160 3528 22))
              (set! tmp.201 (call L.cons.160.16 cons.160 448 tmp.202)))
            (call
             L.vector-set!.161.15
             vector-set!.161
             oprand0.36
             8
             tmp.201)))))
    (define L.fun/ascii-char8783.27.23
      (lambda (c.178 oprand0.35 oprand1.34)
        (begin
          (set! fun/ascii-char8784.29 (mref c.178 14))
          (call L.fun/ascii-char8784.29.25 fun/ascii-char8784.29))))
    (define L.fun/ascii-char8785.26.22 (lambda (c.177) (begin 27438)))
    (define L.fun/void8786.25.21 (lambda (c.176) (begin 30)))
    (define L.fun/void8788.24.20 (lambda (c.175) (begin 30)))
    (define L.fun/ascii-char8791.23.19
      (lambda (c.174 oprand0.33) (begin (if (!= 14 6) 27950 24622))))
    (define L.fun/boolean8790.22.18
      (lambda (c.173 oprand0.32 oprand1.31) (begin 14)))
    (define L.fun/boolean8789.21.17 (lambda (c.172 oprand0.30) (begin 14)))
    (define L.cons.160.16
      (lambda (c.171 tmp.155 tmp.156)
        (begin
          (begin
            (begin (set! tmp.203 (alloc 16)) (set! tmp.182 (+ tmp.203 1)))
            (begin
              (mset! tmp.182 -1 tmp.155)
              (mset! tmp.182 7 tmp.156)
              tmp.182)))))
    (define L.vector-set!.161.15
      (lambda (c.170 tmp.138 tmp.139 tmp.140)
        (begin
          (set! unsafe-vector-set!.5 (mref c.170 14))
          (if (begin
                (if (begin
                      (set! tmp.205 (bitwise-and tmp.139 7))
                      (= tmp.205 0))
                  (set! tmp.204 14)
                  (set! tmp.204 6))
                (!= tmp.204 6))
            (if (begin
                  (if (begin
                        (set! tmp.207 (bitwise-and tmp.138 7))
                        (= tmp.207 3))
                    (set! tmp.206 14)
                    (set! tmp.206 6))
                  (!= tmp.206 6))
              (call
               L.unsafe-vector-set!.5.14
               unsafe-vector-set!.5
               tmp.138
               tmp.139
               tmp.140)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.14
      (lambda (c.169 tmp.114 tmp.115 tmp.116)
        (begin
          (if (begin
                (if (begin
                      (set! tmp.209 (mref tmp.114 -3))
                      (< tmp.115 tmp.209))
                  (set! tmp.208 14)
                  (set! tmp.208 6))
                (!= tmp.208 6))
            (if (begin
                  (if (>= tmp.115 0) (set! tmp.210 14) (set! tmp.210 6))
                  (!= tmp.210 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.213 (arithmetic-shift-right tmp.115 3))
                      (set! tmp.212 (* tmp.213 8)))
                    (set! tmp.211 (+ tmp.212 5)))
                  (mset! tmp.114 tmp.211 tmp.116))
                30)
              2622)
            2622))))
    (define L.error?.162.13
      (lambda (c.168 tmp.150)
        (begin
          (if (begin (set! tmp.214 (bitwise-and tmp.150 255)) (= tmp.214 62))
            14
            6))))
    (define L.make-vector.163.12
      (lambda (c.167 tmp.136)
        (begin
          (set! make-init-vector.4 (mref c.167 14))
          (if (begin
                (if (begin
                      (set! tmp.216 (bitwise-and tmp.136 7))
                      (= tmp.216 0))
                  (set! tmp.215 14)
                  (set! tmp.215 6))
                (!= tmp.215 6))
            (call L.make-init-vector.4.11 make-init-vector.4 tmp.136)
            2110))))
    (define L.make-init-vector.4.11
      (lambda (c.166 tmp.108)
        (begin
          (set! vector-init-loop.110 (mref c.166 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.220 (arithmetic-shift-right tmp.108 3))
                      (set! tmp.219 (+ 1 tmp.220)))
                    (set! tmp.218 (* tmp.219 8)))
                  (set! tmp.217 (alloc tmp.218)))
                (set! tmp.183 (+ tmp.217 3)))
              (begin (mset! tmp.183 -3 tmp.108) (set! tmp.109 tmp.183)))
            (call
             L.vector-init-loop.110.10
             vector-init-loop.110
             tmp.108
             0
             tmp.109)))))
    (define L.vector-init-loop.110.10
      (lambda (c.165 len.111 i.113 vec.112)
        (begin
          (set! vector-init-loop.110 (mref c.165 14))
          (if (begin
                (if (= len.111 i.113) (set! tmp.221 14) (set! tmp.221 6))
                (!= tmp.221 6))
            vec.112
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.224 (arithmetic-shift-right i.113 3))
                    (set! tmp.223 (* tmp.224 8)))
                  (set! tmp.222 (+ tmp.223 5)))
                (mset! vec.112 tmp.222 0))
              (begin
                (set! tmp.225 (+ i.113 8))
                (call
                 L.vector-init-loop.110.10
                 vector-init-loop.110
                 len.111
                 tmp.225
                 vec.112)))))))
    (begin
      (begin
        (begin (set! tmp.226 (alloc 24)) (set! tmp.184 (+ tmp.226 2)))
        (begin
          (mset! tmp.184 -2 L.vector-init-loop.110.10)
          (mset! tmp.184 6 24)
          (set! vector-init-loop.110 tmp.184)))
      (begin
        (begin (set! tmp.227 (alloc 24)) (set! tmp.185 (+ tmp.227 2)))
        (begin
          (mset! tmp.185 -2 L.make-init-vector.4.11)
          (mset! tmp.185 6 8)
          (set! make-init-vector.4 tmp.185)))
      (begin
        (begin (set! tmp.228 (alloc 24)) (set! tmp.186 (+ tmp.228 2)))
        (begin
          (mset! tmp.186 -2 L.make-vector.163.12)
          (mset! tmp.186 6 8)
          (set! make-vector.163 tmp.186)))
      (begin
        (begin (set! tmp.229 (alloc 16)) (set! tmp.187 (+ tmp.229 2)))
        (begin
          (mset! tmp.187 -2 L.error?.162.13)
          (mset! tmp.187 6 8)
          (set! error?.162 tmp.187)))
      (begin
        (begin (set! tmp.230 (alloc 16)) (set! tmp.188 (+ tmp.230 2)))
        (begin
          (mset! tmp.188 -2 L.unsafe-vector-set!.5.14)
          (mset! tmp.188 6 24)
          (set! unsafe-vector-set!.5 tmp.188)))
      (begin
        (begin (set! tmp.231 (alloc 24)) (set! tmp.189 (+ tmp.231 2)))
        (begin
          (mset! tmp.189 -2 L.vector-set!.161.15)
          (mset! tmp.189 6 24)
          (set! vector-set!.161 tmp.189)))
      (begin
        (begin (set! tmp.232 (alloc 16)) (set! tmp.190 (+ tmp.232 2)))
        (begin
          (mset! tmp.190 -2 L.cons.160.16)
          (mset! tmp.190 6 16)
          (set! cons.160 tmp.190)))
      (begin
        (begin (set! tmp.233 (alloc 16)) (set! tmp.191 (+ tmp.233 2)))
        (begin
          (mset! tmp.191 -2 L.fun/boolean8789.21.17)
          (mset! tmp.191 6 8)
          (set! fun/boolean8789.21 tmp.191)))
      (begin
        (begin (set! tmp.234 (alloc 16)) (set! tmp.192 (+ tmp.234 2)))
        (begin
          (mset! tmp.192 -2 L.fun/boolean8790.22.18)
          (mset! tmp.192 6 16)
          (set! fun/boolean8790.22 tmp.192)))
      (begin
        (begin (set! tmp.235 (alloc 16)) (set! tmp.193 (+ tmp.235 2)))
        (begin
          (mset! tmp.193 -2 L.fun/ascii-char8791.23.19)
          (mset! tmp.193 6 8)
          (set! fun/ascii-char8791.23 tmp.193)))
      (begin
        (begin (set! tmp.236 (alloc 16)) (set! tmp.194 (+ tmp.236 2)))
        (begin
          (mset! tmp.194 -2 L.fun/void8788.24.20)
          (mset! tmp.194 6 0)
          (set! fun/void8788.24 tmp.194)))
      (begin
        (begin (set! tmp.237 (alloc 16)) (set! tmp.195 (+ tmp.237 2)))
        (begin
          (mset! tmp.195 -2 L.fun/void8786.25.21)
          (mset! tmp.195 6 0)
          (set! fun/void8786.25 tmp.195)))
      (begin
        (begin (set! tmp.238 (alloc 16)) (set! tmp.196 (+ tmp.238 2)))
        (begin
          (mset! tmp.196 -2 L.fun/ascii-char8785.26.22)
          (mset! tmp.196 6 0)
          (set! fun/ascii-char8785.26 tmp.196)))
      (begin
        (begin (set! tmp.239 (alloc 24)) (set! tmp.197 (+ tmp.239 2)))
        (begin
          (mset! tmp.197 -2 L.fun/ascii-char8783.27.23)
          (mset! tmp.197 6 16)
          (set! fun/ascii-char8783.27 tmp.197)))
      (begin
        (begin (set! tmp.240 (alloc 32)) (set! tmp.198 (+ tmp.240 2)))
        (begin
          (mset! tmp.198 -2 L.fun/void8787.28.24)
          (mset! tmp.198 6 8)
          (set! fun/void8787.28 tmp.198)))
      (begin
        (begin (set! tmp.241 (alloc 24)) (set! tmp.199 (+ tmp.241 2)))
        (begin
          (mset! tmp.199 -2 L.fun/ascii-char8784.29.25)
          (mset! tmp.199 6 0)
          (set! fun/ascii-char8784.29 tmp.199)))
      (begin
        (mset! vector-init-loop.110 14 vector-init-loop.110)
        (mset! make-init-vector.4 14 vector-init-loop.110)
        (mset! make-vector.163 14 make-init-vector.4)
        (mset! vector-set!.161 14 unsafe-vector-set!.5)
        (mset! fun/ascii-char8783.27 14 fun/ascii-char8784.29)
        (mset! fun/void8787.28 14 cons.160)
        (mset! fun/void8787.28 22 vector-set!.161)
        (mset! fun/ascii-char8784.29 14 fun/ascii-char8785.26)
        (begin
          (begin
            (begin
              (begin (set! g43035489.38 30))
              (if (begin
                    (set! tmp.243
                      (call L.error?.162.13 error?.162 g43035489.38))
                    (!= tmp.243 6))
                (set! tmp.242 g43035489.38)
                (begin
                  (if (!= 30 6)
                    (if (!= 30 6)
                      (if (!= 30 6)
                        (if (!= 30 6)
                          (if (!= 30 6)
                            (set! g43035490.39 30)
                            (set! g43035490.39 6))
                          (set! g43035490.39 6))
                        (set! g43035490.39 6))
                      (set! g43035490.39 6))
                    (set! g43035490.39 6))
                  (if (begin
                        (set! tmp.244
                          (call L.error?.162.13 error?.162 g43035490.39))
                        (!= tmp.244 6))
                    (set! tmp.242 g43035490.39)
                    (begin
                      (set! g43035491.40 30)
                      (if (begin
                            (set! tmp.245
                              (call L.error?.162.13 error?.162 g43035491.40))
                            (!= tmp.245 6))
                        (set! tmp.242 g43035491.40)
                        (begin
                          (begin
                            (set! g43035493.42 30)
                            (if (begin
                                  (set! tmp.246
                                    (call
                                     L.error?.162.13
                                     error?.162
                                     g43035493.42))
                                  (!= tmp.246 6))
                              (set! g43035492.41 g43035493.42)
                              (set! g43035492.41 30)))
                          (if (begin
                                (set! tmp.247
                                  (call
                                   L.error?.162.13
                                   error?.162
                                   g43035492.41))
                                (!= tmp.247 6))
                            (set! tmp.242 g43035492.41)
                            (begin
                              (set! g43035494.43
                                (call L.fun/void8786.25.21 fun/void8786.25))
                              (if (begin
                                    (set! tmp.248
                                      (call
                                       L.error?.162.13
                                       error?.162
                                       g43035494.43))
                                    (!= tmp.248 6))
                                (set! tmp.242 g43035494.43)
                                (begin
                                  (begin
                                    (begin
                                      (set! tmp.8.45
                                        (call
                                         L.make-vector.163.12
                                         make-vector.163
                                         64))
                                      (begin
                                        (set! g43035496.46
                                          (call
                                           L.vector-set!.161.15
                                           vector-set!.161
                                           tmp.8.45
                                           0
                                           8))
                                        (if (begin
                                              (set! tmp.250
                                                (call
                                                 L.error?.162.13
                                                 error?.162
                                                 g43035496.46))
                                              (!= tmp.250 6))
                                          (set! tmp.249 g43035496.46)
                                          (begin
                                            (set! g43035497.47
                                              (call
                                               L.vector-set!.161.15
                                               vector-set!.161
                                               tmp.8.45
                                               8
                                               16))
                                            (if (begin
                                                  (set! tmp.251
                                                    (call
                                                     L.error?.162.13
                                                     error?.162
                                                     g43035497.47))
                                                  (!= tmp.251 6))
                                              (set! tmp.249 g43035497.47)
                                              (begin
                                                (set! g43035498.48
                                                  (call
                                                   L.vector-set!.161.15
                                                   vector-set!.161
                                                   tmp.8.45
                                                   16
                                                   24))
                                                (if (begin
                                                      (set! tmp.252
                                                        (call
                                                         L.error?.162.13
                                                         error?.162
                                                         g43035498.48))
                                                      (!= tmp.252 6))
                                                  (set! tmp.249 g43035498.48)
                                                  (begin
                                                    (set! g43035499.49
                                                      (call
                                                       L.vector-set!.161.15
                                                       vector-set!.161
                                                       tmp.8.45
                                                       24
                                                       32))
                                                    (if (begin
                                                          (set! tmp.253
                                                            (call
                                                             L.error?.162.13
                                                             error?.162
                                                             g43035499.49))
                                                          (!= tmp.253 6))
                                                      (set! tmp.249
                                                        g43035499.49)
                                                      (begin
                                                        (set! g43035500.50
                                                          (call
                                                           L.vector-set!.161.15
                                                           vector-set!.161
                                                           tmp.8.45
                                                           32
                                                           40))
                                                        (if (begin
                                                              (set! tmp.254
                                                                (call
                                                                 L.error?.162.13
                                                                 error?.162
                                                                 g43035500.50))
                                                              (!= tmp.254 6))
                                                          (set! tmp.249
                                                            g43035500.50)
                                                          (begin
                                                            (set! g43035501.51
                                                              (call
                                                               L.vector-set!.161.15
                                                               vector-set!.161
                                                               tmp.8.45
                                                               40
                                                               48))
                                                            (if (begin
                                                                  (set! tmp.255
                                                                    (call
                                                                     L.error?.162.13
                                                                     error?.162
                                                                     g43035501.51))
                                                                  (!=
                                                                   tmp.255
                                                                   6))
                                                              (set! tmp.249
                                                                g43035501.51)
                                                              (begin
                                                                (set! g43035502.52
                                                                  (call
                                                                   L.vector-set!.161.15
                                                                   vector-set!.161
                                                                   tmp.8.45
                                                                   48
                                                                   56))
                                                                (if (begin
                                                                      (set! tmp.256
                                                                        (call
                                                                         L.error?.162.13
                                                                         error?.162
                                                                         g43035502.52))
                                                                      (!=
                                                                       tmp.256
                                                                       6))
                                                                  (set! tmp.249
                                                                    g43035502.52)
                                                                  (begin
                                                                    (set! g43035503.53
                                                                      (call
                                                                       L.vector-set!.161.15
                                                                       vector-set!.161
                                                                       tmp.8.45
                                                                       56
                                                                       64))
                                                                    (if (begin
                                                                          (set! tmp.257
                                                                            (call
                                                                             L.error?.162.13
                                                                             error?.162
                                                                             g43035503.53))
                                                                          (!=
                                                                           tmp.257
                                                                           6))
                                                                      (set! tmp.249
                                                                        g43035503.53)
                                                                      (set! tmp.249
                                                                        tmp.8.45))))))))))))))))))
                                    (set! g43035495.44
                                      (call
                                       L.fun/void8787.28.24
                                       fun/void8787.28
                                       tmp.249)))
                                  (if (begin
                                        (set! tmp.258
                                          (call
                                           L.error?.162.13
                                           error?.162
                                           g43035495.44))
                                        (!= tmp.258 6))
                                    (set! tmp.242 g43035495.44)
                                    (set! tmp.242
                                      (call
                                       L.fun/void8788.24.20
                                       fun/void8788.24))))))))))))))
            (begin
              (begin (set! error0.54 38206) (set! tmp.259 50750))
              (set! tmp.7.37
                (call
                 L.fun/ascii-char8783.27.23
                 fun/ascii-char8783.27
                 tmp.242
                 tmp.259))))
          (if (!= tmp.7.37 6)
            tmp.7.37
            (begin
              (begin
                (begin
                  (set! tmp.10.57
                    (call L.make-vector.163.12 make-vector.163 64))
                  (begin
                    (set! g43035504.58
                      (call
                       L.vector-set!.161.15
                       vector-set!.161
                       tmp.10.57
                       0
                       22))
                    (if (begin
                          (set! tmp.260
                            (call L.error?.162.13 error?.162 g43035504.58))
                          (!= tmp.260 6))
                      (set! vector0.56 g43035504.58)
                      (begin
                        (set! g43035505.59
                          (call
                           L.vector-set!.161.15
                           vector-set!.161
                           tmp.10.57
                           8
                           22830))
                        (if (begin
                              (set! tmp.261
                                (call L.error?.162.13 error?.162 g43035505.59))
                              (!= tmp.261 6))
                          (set! vector0.56 g43035505.59)
                          (begin
                            (set! g43035506.60
                              (call
                               L.vector-set!.161.15
                               vector-set!.161
                               tmp.10.57
                               16
                               1688))
                            (if (begin
                                  (set! tmp.262
                                    (call
                                     L.error?.162.13
                                     error?.162
                                     g43035506.60))
                                  (!= tmp.262 6))
                              (set! vector0.56 g43035506.60)
                              (begin
                                (begin
                                  (begin
                                    (set! tmp.264
                                      (call L.cons.160.16 cons.160 3928 22))
                                    (set! tmp.263
                                      (call
                                       L.cons.160.16
                                       cons.160
                                       152
                                       tmp.264)))
                                  (set! g43035507.61
                                    (call
                                     L.vector-set!.161.15
                                     vector-set!.161
                                     tmp.10.57
                                     24
                                     tmp.263)))
                                (if (begin
                                      (set! tmp.265
                                        (call
                                         L.error?.162.13
                                         error?.162
                                         g43035507.61))
                                      (!= tmp.265 6))
                                  (set! vector0.56 g43035507.61)
                                  (begin
                                    (set! g43035508.62
                                      (call
                                       L.vector-set!.161.15
                                       vector-set!.161
                                       tmp.10.57
                                       32
                                       21806))
                                    (if (begin
                                          (set! tmp.266
                                            (call
                                             L.error?.162.13
                                             error?.162
                                             g43035508.62))
                                          (!= tmp.266 6))
                                      (set! vector0.56 g43035508.62)
                                      (begin
                                        (begin
                                          (begin
                                            (set! tmp.268
                                              (call
                                               L.cons.160.16
                                               cons.160
                                               2864
                                               22))
                                            (set! tmp.267
                                              (call
                                               L.cons.160.16
                                               cons.160
                                               1912
                                               tmp.268)))
                                          (set! g43035509.63
                                            (call
                                             L.vector-set!.161.15
                                             vector-set!.161
                                             tmp.10.57
                                             40
                                             tmp.267)))
                                        (if (begin
                                              (set! tmp.269
                                                (call
                                                 L.error?.162.13
                                                 error?.162
                                                 g43035509.63))
                                              (!= tmp.269 6))
                                          (set! vector0.56 g43035509.63)
                                          (begin
                                            (set! g43035510.64
                                              (call
                                               L.vector-set!.161.15
                                               vector-set!.161
                                               tmp.10.57
                                               48
                                               560))
                                            (if (begin
                                                  (set! tmp.270
                                                    (call
                                                     L.error?.162.13
                                                     error?.162
                                                     g43035510.64))
                                                  (!= tmp.270 6))
                                              (set! vector0.56 g43035510.64)
                                              (begin
                                                (set! g43035511.65
                                                  (call
                                                   L.vector-set!.161.15
                                                   vector-set!.161
                                                   tmp.10.57
                                                   56
                                                   38462))
                                                (if (begin
                                                      (set! tmp.271
                                                        (call
                                                         L.error?.162.13
                                                         error?.162
                                                         g43035511.65))
                                                      (!= tmp.271 6))
                                                  (set! vector0.56
                                                    g43035511.65)
                                                  (set! vector0.56
                                                    tmp.10.57))))))))))))))))))
                (if (!= 6 6) (set! tmp.9.55 24110) (set! tmp.9.55 22318)))
              (if (!= tmp.9.55 6)
                tmp.9.55
                (begin
                  (if (begin
                        (begin
                          (begin
                            (begin
                              (begin
                                (set! tmp.274 (alloc 16))
                                (set! tmp.200 (+ tmp.274 2)))
                              (begin
                                (mset! tmp.200 -2 L.lam.164.26)
                                (mset! tmp.200 6 0)
                                (set! lam.164 tmp.200)))
                            (set! tmp.273 lam.164))
                          (set! tmp.272
                            (call
                             L.fun/boolean8789.21.17
                             fun/boolean8789.21
                             tmp.273)))
                        (!= tmp.272 6))
                    (begin
                      (set! tmp.12.67 23342)
                      (if (!= tmp.12.67 6)
                        (set! tmp.11.66 tmp.12.67)
                        (begin
                          (set! tmp.13.68 22318)
                          (if (!= tmp.13.68 6)
                            (set! tmp.11.66 tmp.13.68)
                            (begin
                              (set! tmp.14.69 21038)
                              (if (!= tmp.14.69 6)
                                (set! tmp.11.66 tmp.14.69)
                                (set! tmp.11.66 22830)))))))
                    (if (!= 14 6)
                      (set! tmp.11.66 24878)
                      (set! tmp.11.66 24110)))
                  (if (!= tmp.11.66 6)
                    tmp.11.66
                    (begin
                      (if (begin
                            (set! tmp.275
                              (call
                               L.fun/boolean8790.22.18
                               fun/boolean8790.22
                               22
                               1920))
                            (!= tmp.275 6))
                        (if (!= 14 6)
                          (set! tmp.15.70 30254)
                          (set! tmp.15.70 25646))
                        (if (!= 27182 6)
                          (if (!= 18478 6)
                            (if (!= 24878 6)
                              (if (!= 17710 6)
                                (if (!= 26670 6)
                                  (set! tmp.15.70 19246)
                                  (set! tmp.15.70 6))
                                (set! tmp.15.70 6))
                              (set! tmp.15.70 6))
                            (set! tmp.15.70 6))
                          (set! tmp.15.70 6)))
                      (if (!= tmp.15.70 6)
                        tmp.15.70
                        (begin
                          (begin
                            (if (!= 14 6)
                              (set! tmp.16.71
                                (call L.make-vector.163.12 make-vector.163 64))
                              (begin
                                (set! tmp.17.72
                                  (call
                                   L.make-vector.163.12
                                   make-vector.163
                                   64))
                                (begin
                                  (set! g43035512.73
                                    (call
                                     L.vector-set!.161.15
                                     vector-set!.161
                                     tmp.17.72
                                     0
                                     8))
                                  (if (begin
                                        (set! tmp.277
                                          (call
                                           L.error?.162.13
                                           error?.162
                                           g43035512.73))
                                        (!= tmp.277 6))
                                    (set! tmp.16.71 g43035512.73)
                                    (begin
                                      (set! g43035513.74
                                        (call
                                         L.vector-set!.161.15
                                         vector-set!.161
                                         tmp.17.72
                                         8
                                         16))
                                      (if (begin
                                            (set! tmp.278
                                              (call
                                               L.error?.162.13
                                               error?.162
                                               g43035513.74))
                                            (!= tmp.278 6))
                                        (set! tmp.16.71 g43035513.74)
                                        (begin
                                          (set! g43035514.75
                                            (call
                                             L.vector-set!.161.15
                                             vector-set!.161
                                             tmp.17.72
                                             16
                                             24))
                                          (if (begin
                                                (set! tmp.279
                                                  (call
                                                   L.error?.162.13
                                                   error?.162
                                                   g43035514.75))
                                                (!= tmp.279 6))
                                            (set! tmp.16.71 g43035514.75)
                                            (begin
                                              (set! g43035515.76
                                                (call
                                                 L.vector-set!.161.15
                                                 vector-set!.161
                                                 tmp.17.72
                                                 24
                                                 32))
                                              (if (begin
                                                    (set! tmp.280
                                                      (call
                                                       L.error?.162.13
                                                       error?.162
                                                       g43035515.76))
                                                    (!= tmp.280 6))
                                                (set! tmp.16.71 g43035515.76)
                                                (begin
                                                  (set! g43035516.77
                                                    (call
                                                     L.vector-set!.161.15
                                                     vector-set!.161
                                                     tmp.17.72
                                                     32
                                                     40))
                                                  (if (begin
                                                        (set! tmp.281
                                                          (call
                                                           L.error?.162.13
                                                           error?.162
                                                           g43035516.77))
                                                        (!= tmp.281 6))
                                                    (set! tmp.16.71
                                                      g43035516.77)
                                                    (begin
                                                      (set! g43035517.78
                                                        (call
                                                         L.vector-set!.161.15
                                                         vector-set!.161
                                                         tmp.17.72
                                                         40
                                                         48))
                                                      (if (begin
                                                            (set! tmp.282
                                                              (call
                                                               L.error?.162.13
                                                               error?.162
                                                               g43035517.78))
                                                            (!= tmp.282 6))
                                                        (set! tmp.16.71
                                                          g43035517.78)
                                                        (begin
                                                          (set! g43035518.79
                                                            (call
                                                             L.vector-set!.161.15
                                                             vector-set!.161
                                                             tmp.17.72
                                                             48
                                                             56))
                                                          (if (begin
                                                                (set! tmp.283
                                                                  (call
                                                                   L.error?.162.13
                                                                   error?.162
                                                                   g43035518.79))
                                                                (!= tmp.283 6))
                                                            (set! tmp.16.71
                                                              g43035518.79)
                                                            (begin
                                                              (set! g43035519.80
                                                                (call
                                                                 L.vector-set!.161.15
                                                                 vector-set!.161
                                                                 tmp.17.72
                                                                 56
                                                                 64))
                                                              (if (begin
                                                                    (set! tmp.284
                                                                      (call
                                                                       L.error?.162.13
                                                                       error?.162
                                                                       g43035519.80))
                                                                    (!=
                                                                     tmp.284
                                                                     6))
                                                                (set! tmp.16.71
                                                                  g43035519.80)
                                                                (set! tmp.16.71
                                                                  tmp.17.72)))))))))))))))))))
                            (if (!= tmp.16.71 6)
                              (set! tmp.276 tmp.16.71)
                              (if (begin
                                    (set! tmp.18.81
                                      (call
                                       L.make-vector.163.12
                                       make-vector.163
                                       64))
                                    (begin
                                      (set! g43035520.82
                                        (call
                                         L.vector-set!.161.15
                                         vector-set!.161
                                         tmp.18.81
                                         0
                                         8))
                                      (if (begin
                                            (set! tmp.285
                                              (call
                                               L.error?.162.13
                                               error?.162
                                               g43035520.82))
                                            (!= tmp.285 6))
                                        (!= g43035520.82 6)
                                        (begin
                                          (set! g43035521.83
                                            (call
                                             L.vector-set!.161.15
                                             vector-set!.161
                                             tmp.18.81
                                             8
                                             16))
                                          (if (begin
                                                (set! tmp.286
                                                  (call
                                                   L.error?.162.13
                                                   error?.162
                                                   g43035521.83))
                                                (!= tmp.286 6))
                                            (!= g43035521.83 6)
                                            (begin
                                              (set! g43035522.84
                                                (call
                                                 L.vector-set!.161.15
                                                 vector-set!.161
                                                 tmp.18.81
                                                 16
                                                 24))
                                              (if (begin
                                                    (set! tmp.287
                                                      (call
                                                       L.error?.162.13
                                                       error?.162
                                                       g43035522.84))
                                                    (!= tmp.287 6))
                                                (!= g43035522.84 6)
                                                (begin
                                                  (set! g43035523.85
                                                    (call
                                                     L.vector-set!.161.15
                                                     vector-set!.161
                                                     tmp.18.81
                                                     24
                                                     32))
                                                  (if (begin
                                                        (set! tmp.288
                                                          (call
                                                           L.error?.162.13
                                                           error?.162
                                                           g43035523.85))
                                                        (!= tmp.288 6))
                                                    (!= g43035523.85 6)
                                                    (begin
                                                      (set! g43035524.86
                                                        (call
                                                         L.vector-set!.161.15
                                                         vector-set!.161
                                                         tmp.18.81
                                                         32
                                                         40))
                                                      (if (begin
                                                            (set! tmp.289
                                                              (call
                                                               L.error?.162.13
                                                               error?.162
                                                               g43035524.86))
                                                            (!= tmp.289 6))
                                                        (!= g43035524.86 6)
                                                        (begin
                                                          (set! g43035525.87
                                                            (call
                                                             L.vector-set!.161.15
                                                             vector-set!.161
                                                             tmp.18.81
                                                             40
                                                             48))
                                                          (if (begin
                                                                (set! tmp.290
                                                                  (call
                                                                   L.error?.162.13
                                                                   error?.162
                                                                   g43035525.87))
                                                                (!= tmp.290 6))
                                                            (!= g43035525.87 6)
                                                            (begin
                                                              (set! g43035526.88
                                                                (call
                                                                 L.vector-set!.161.15
                                                                 vector-set!.161
                                                                 tmp.18.81
                                                                 48
                                                                 56))
                                                              (if (begin
                                                                    (set! tmp.291
                                                                      (call
                                                                       L.error?.162.13
                                                                       error?.162
                                                                       g43035526.88))
                                                                    (!=
                                                                     tmp.291
                                                                     6))
                                                                (!=
                                                                 g43035526.88
                                                                 6)
                                                                (begin
                                                                  (set! g43035527.89
                                                                    (call
                                                                     L.vector-set!.161.15
                                                                     vector-set!.161
                                                                     tmp.18.81
                                                                     56
                                                                     64))
                                                                  (if (begin
                                                                        (set! tmp.292
                                                                          (call
                                                                           L.error?.162.13
                                                                           error?.162
                                                                           g43035527.89))
                                                                        (!=
                                                                         tmp.292
                                                                         6))
                                                                    (!=
                                                                     g43035527.89
                                                                     6)
                                                                    (!=
                                                                     tmp.18.81
                                                                     6))))))))))))))))))
                                (if (begin
                                      (set! tmp.19.90
                                        (call
                                         L.make-vector.163.12
                                         make-vector.163
                                         64))
                                      (begin
                                        (set! g43035528.91
                                          (call
                                           L.vector-set!.161.15
                                           vector-set!.161
                                           tmp.19.90
                                           0
                                           8))
                                        (if (begin
                                              (set! tmp.293
                                                (call
                                                 L.error?.162.13
                                                 error?.162
                                                 g43035528.91))
                                              (!= tmp.293 6))
                                          (!= g43035528.91 6)
                                          (begin
                                            (set! g43035529.92
                                              (call
                                               L.vector-set!.161.15
                                               vector-set!.161
                                               tmp.19.90
                                               8
                                               16))
                                            (if (begin
                                                  (set! tmp.294
                                                    (call
                                                     L.error?.162.13
                                                     error?.162
                                                     g43035529.92))
                                                  (!= tmp.294 6))
                                              (!= g43035529.92 6)
                                              (begin
                                                (set! g43035530.93
                                                  (call
                                                   L.vector-set!.161.15
                                                   vector-set!.161
                                                   tmp.19.90
                                                   16
                                                   24))
                                                (if (begin
                                                      (set! tmp.295
                                                        (call
                                                         L.error?.162.13
                                                         error?.162
                                                         g43035530.93))
                                                      (!= tmp.295 6))
                                                  (!= g43035530.93 6)
                                                  (begin
                                                    (set! g43035531.94
                                                      (call
                                                       L.vector-set!.161.15
                                                       vector-set!.161
                                                       tmp.19.90
                                                       24
                                                       32))
                                                    (if (begin
                                                          (set! tmp.296
                                                            (call
                                                             L.error?.162.13
                                                             error?.162
                                                             g43035531.94))
                                                          (!= tmp.296 6))
                                                      (!= g43035531.94 6)
                                                      (begin
                                                        (set! g43035532.95
                                                          (call
                                                           L.vector-set!.161.15
                                                           vector-set!.161
                                                           tmp.19.90
                                                           32
                                                           40))
                                                        (if (begin
                                                              (set! tmp.297
                                                                (call
                                                                 L.error?.162.13
                                                                 error?.162
                                                                 g43035532.95))
                                                              (!= tmp.297 6))
                                                          (!= g43035532.95 6)
                                                          (begin
                                                            (set! g43035533.96
                                                              (call
                                                               L.vector-set!.161.15
                                                               vector-set!.161
                                                               tmp.19.90
                                                               40
                                                               48))
                                                            (if (begin
                                                                  (set! tmp.298
                                                                    (call
                                                                     L.error?.162.13
                                                                     error?.162
                                                                     g43035533.96))
                                                                  (!=
                                                                   tmp.298
                                                                   6))
                                                              (!=
                                                               g43035533.96
                                                               6)
                                                              (begin
                                                                (set! g43035534.97
                                                                  (call
                                                                   L.vector-set!.161.15
                                                                   vector-set!.161
                                                                   tmp.19.90
                                                                   48
                                                                   56))
                                                                (if (begin
                                                                      (set! tmp.299
                                                                        (call
                                                                         L.error?.162.13
                                                                         error?.162
                                                                         g43035534.97))
                                                                      (!=
                                                                       tmp.299
                                                                       6))
                                                                  (!=
                                                                   g43035534.97
                                                                   6)
                                                                  (begin
                                                                    (set! g43035535.98
                                                                      (call
                                                                       L.vector-set!.161.15
                                                                       vector-set!.161
                                                                       tmp.19.90
                                                                       56
                                                                       64))
                                                                    (if (begin
                                                                          (set! tmp.300
                                                                            (call
                                                                             L.error?.162.13
                                                                             error?.162
                                                                             g43035535.98))
                                                                          (!=
                                                                           tmp.300
                                                                           6))
                                                                      (!=
                                                                       g43035535.98
                                                                       6)
                                                                      (!=
                                                                       tmp.19.90
                                                                       6))))))))))))))))))
                                  (begin
                                    (set! tmp.20.99
                                      (call
                                       L.make-vector.163.12
                                       make-vector.163
                                       64))
                                    (begin
                                      (set! g43035536.100
                                        (call
                                         L.vector-set!.161.15
                                         vector-set!.161
                                         tmp.20.99
                                         0
                                         8))
                                      (if (begin
                                            (set! tmp.301
                                              (call
                                               L.error?.162.13
                                               error?.162
                                               g43035536.100))
                                            (!= tmp.301 6))
                                        (set! tmp.276 g43035536.100)
                                        (begin
                                          (set! g43035537.101
                                            (call
                                             L.vector-set!.161.15
                                             vector-set!.161
                                             tmp.20.99
                                             8
                                             16))
                                          (if (begin
                                                (set! tmp.302
                                                  (call
                                                   L.error?.162.13
                                                   error?.162
                                                   g43035537.101))
                                                (!= tmp.302 6))
                                            (set! tmp.276 g43035537.101)
                                            (begin
                                              (set! g43035538.102
                                                (call
                                                 L.vector-set!.161.15
                                                 vector-set!.161
                                                 tmp.20.99
                                                 16
                                                 24))
                                              (if (begin
                                                    (set! tmp.303
                                                      (call
                                                       L.error?.162.13
                                                       error?.162
                                                       g43035538.102))
                                                    (!= tmp.303 6))
                                                (set! tmp.276 g43035538.102)
                                                (begin
                                                  (set! g43035539.103
                                                    (call
                                                     L.vector-set!.161.15
                                                     vector-set!.161
                                                     tmp.20.99
                                                     24
                                                     32))
                                                  (if (begin
                                                        (set! tmp.304
                                                          (call
                                                           L.error?.162.13
                                                           error?.162
                                                           g43035539.103))
                                                        (!= tmp.304 6))
                                                    (set! tmp.276
                                                      g43035539.103)
                                                    (begin
                                                      (set! g43035540.104
                                                        (call
                                                         L.vector-set!.161.15
                                                         vector-set!.161
                                                         tmp.20.99
                                                         32
                                                         40))
                                                      (if (begin
                                                            (set! tmp.305
                                                              (call
                                                               L.error?.162.13
                                                               error?.162
                                                               g43035540.104))
                                                            (!= tmp.305 6))
                                                        (set! tmp.276
                                                          g43035540.104)
                                                        (begin
                                                          (set! g43035541.105
                                                            (call
                                                             L.vector-set!.161.15
                                                             vector-set!.161
                                                             tmp.20.99
                                                             40
                                                             48))
                                                          (if (begin
                                                                (set! tmp.306
                                                                  (call
                                                                   L.error?.162.13
                                                                   error?.162
                                                                   g43035541.105))
                                                                (!= tmp.306 6))
                                                            (set! tmp.276
                                                              g43035541.105)
                                                            (begin
                                                              (set! g43035542.106
                                                                (call
                                                                 L.vector-set!.161.15
                                                                 vector-set!.161
                                                                 tmp.20.99
                                                                 48
                                                                 56))
                                                              (if (begin
                                                                    (set! tmp.307
                                                                      (call
                                                                       L.error?.162.13
                                                                       error?.162
                                                                       g43035542.106))
                                                                    (!=
                                                                     tmp.307
                                                                     6))
                                                                (set! tmp.276
                                                                  g43035542.106)
                                                                (begin
                                                                  (set! g43035543.107
                                                                    (call
                                                                     L.vector-set!.161.15
                                                                     vector-set!.161
                                                                     tmp.20.99
                                                                     56
                                                                     64))
                                                                  (if (begin
                                                                        (set! tmp.308
                                                                          (call
                                                                           L.error?.162.13
                                                                           error?.162
                                                                           g43035543.107))
                                                                        (!=
                                                                         tmp.308
                                                                         6))
                                                                    (set! tmp.276
                                                                      g43035543.107)
                                                                    (set! tmp.276
                                                                      tmp.20.99))))))))))))))))))
                                  (set! tmp.276 6))
                                (set! tmp.276 6))))
                          (call
                           L.fun/ascii-char8791.23.19
                           fun/ascii-char8791.23
                           tmp.276))))))))))))))
(check-by-interp
 '(module
    (define L.lam.100.22 (lambda (c.113) (begin 6376)))
    (define L.lam.99.21 (lambda (c.112) (begin 4448)))
    (define L.lam.98.20 (lambda (c.111) (begin 7592)))
    (define L.fun/empty8794.15.19 (lambda (c.110 oprand0.19) (begin 22)))
    (define L.fun/boolean8796.14.18 (lambda (c.109 oprand0.18) (begin 14)))
    (define L.fun/empty8795.13.17
      (lambda (c.108 oprand0.17 oprand1.16) (begin (begin 22))))
    (define L.make-vector.94.16
      (lambda (c.107 tmp.70)
        (begin
          (set! make-init-vector.4 (mref c.107 14))
          (if (begin
                (if (begin (set! tmp.130 (bitwise-and tmp.70 7)) (= tmp.130 0))
                  (set! tmp.129 14)
                  (set! tmp.129 6))
                (!= tmp.129 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.70)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.106 tmp.42)
        (begin
          (set! vector-init-loop.44 (mref c.106 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.134 (arithmetic-shift-right tmp.42 3))
                      (set! tmp.133 (+ 1 tmp.134)))
                    (set! tmp.132 (* tmp.133 8)))
                  (set! tmp.131 (alloc tmp.132)))
                (set! tmp.114 (+ tmp.131 3)))
              (begin (mset! tmp.114 -3 tmp.42) (set! tmp.43 tmp.114)))
            (call
             L.vector-init-loop.44.14
             vector-init-loop.44
             tmp.42
             0
             tmp.43)))))
    (define L.vector-init-loop.44.14
      (lambda (c.105 len.45 i.47 vec.46)
        (begin
          (set! vector-init-loop.44 (mref c.105 14))
          (if (begin
                (if (= len.45 i.47) (set! tmp.135 14) (set! tmp.135 6))
                (!= tmp.135 6))
            vec.46
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.138 (arithmetic-shift-right i.47 3))
                    (set! tmp.137 (* tmp.138 8)))
                  (set! tmp.136 (+ tmp.137 5)))
                (mset! vec.46 tmp.136 0))
              (begin
                (set! tmp.139 (+ i.47 8))
                (call
                 L.vector-init-loop.44.14
                 vector-init-loop.44
                 len.45
                 tmp.139
                 vec.46)))))))
    (define L.vector-set!.95.13
      (lambda (c.104 tmp.72 tmp.73 tmp.74)
        (begin
          (set! unsafe-vector-set!.5 (mref c.104 14))
          (if (begin
                (if (begin (set! tmp.141 (bitwise-and tmp.73 7)) (= tmp.141 0))
                  (set! tmp.140 14)
                  (set! tmp.140 6))
                (!= tmp.140 6))
            (if (begin
                  (if (begin
                        (set! tmp.143 (bitwise-and tmp.72 7))
                        (= tmp.143 3))
                    (set! tmp.142 14)
                    (set! tmp.142 6))
                  (!= tmp.142 6))
              (call
               L.unsafe-vector-set!.5.12
               unsafe-vector-set!.5
               tmp.72
               tmp.73
               tmp.74)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.12
      (lambda (c.103 tmp.48 tmp.49 tmp.50)
        (begin
          (if (begin
                (if (begin (set! tmp.145 (mref tmp.48 -3)) (< tmp.49 tmp.145))
                  (set! tmp.144 14)
                  (set! tmp.144 6))
                (!= tmp.144 6))
            (if (begin
                  (if (>= tmp.49 0) (set! tmp.146 14) (set! tmp.146 6))
                  (!= tmp.146 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.149 (arithmetic-shift-right tmp.49 3))
                      (set! tmp.148 (* tmp.149 8)))
                    (set! tmp.147 (+ tmp.148 5)))
                  (mset! tmp.48 tmp.147 tmp.50))
                30)
              2622)
            2622))))
    (define L.error?.96.11
      (lambda (c.102 tmp.84)
        (begin
          (if (begin (set! tmp.150 (bitwise-and tmp.84 255)) (= tmp.150 62))
            14
            6))))
    (define L.cons.97.10
      (lambda (c.101 tmp.89 tmp.90)
        (begin
          (begin
            (begin (set! tmp.151 (alloc 16)) (set! tmp.115 (+ tmp.151 1)))
            (begin
              (mset! tmp.115 -1 tmp.89)
              (mset! tmp.115 7 tmp.90)
              tmp.115)))))
    (begin
      (begin
        (begin (set! tmp.152 (alloc 16)) (set! tmp.116 (+ tmp.152 2)))
        (begin
          (mset! tmp.116 -2 L.cons.97.10)
          (mset! tmp.116 6 16)
          (set! cons.97 tmp.116)))
      (begin
        (begin (set! tmp.153 (alloc 16)) (set! tmp.117 (+ tmp.153 2)))
        (begin
          (mset! tmp.117 -2 L.error?.96.11)
          (mset! tmp.117 6 8)
          (set! error?.96 tmp.117)))
      (begin
        (begin (set! tmp.154 (alloc 16)) (set! tmp.118 (+ tmp.154 2)))
        (begin
          (mset! tmp.118 -2 L.unsafe-vector-set!.5.12)
          (mset! tmp.118 6 24)
          (set! unsafe-vector-set!.5 tmp.118)))
      (begin
        (begin (set! tmp.155 (alloc 24)) (set! tmp.119 (+ tmp.155 2)))
        (begin
          (mset! tmp.119 -2 L.vector-set!.95.13)
          (mset! tmp.119 6 24)
          (set! vector-set!.95 tmp.119)))
      (begin
        (begin (set! tmp.156 (alloc 24)) (set! tmp.120 (+ tmp.156 2)))
        (begin
          (mset! tmp.120 -2 L.vector-init-loop.44.14)
          (mset! tmp.120 6 24)
          (set! vector-init-loop.44 tmp.120)))
      (begin
        (begin (set! tmp.157 (alloc 24)) (set! tmp.121 (+ tmp.157 2)))
        (begin
          (mset! tmp.121 -2 L.make-init-vector.4.15)
          (mset! tmp.121 6 8)
          (set! make-init-vector.4 tmp.121)))
      (begin
        (begin (set! tmp.158 (alloc 24)) (set! tmp.122 (+ tmp.158 2)))
        (begin
          (mset! tmp.122 -2 L.make-vector.94.16)
          (mset! tmp.122 6 8)
          (set! make-vector.94 tmp.122)))
      (begin
        (begin (set! tmp.159 (alloc 16)) (set! tmp.123 (+ tmp.159 2)))
        (begin
          (mset! tmp.123 -2 L.fun/empty8795.13.17)
          (mset! tmp.123 6 16)
          (set! fun/empty8795.13 tmp.123)))
      (begin
        (begin (set! tmp.160 (alloc 16)) (set! tmp.124 (+ tmp.160 2)))
        (begin
          (mset! tmp.124 -2 L.fun/boolean8796.14.18)
          (mset! tmp.124 6 8)
          (set! fun/boolean8796.14 tmp.124)))
      (begin
        (begin (set! tmp.161 (alloc 16)) (set! tmp.125 (+ tmp.161 2)))
        (begin
          (mset! tmp.125 -2 L.fun/empty8794.15.19)
          (mset! tmp.125 6 8)
          (set! fun/empty8794.15 tmp.125)))
      (begin
        (mset! vector-set!.95 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.44 14 vector-init-loop.44)
        (mset! make-init-vector.4 14 vector-init-loop.44)
        (mset! make-vector.94 14 make-init-vector.4)
        (begin
          (begin
            (set! boolean0.23 6)
            (set! boolean1.22 6)
            (set! empty2.21 22)
            (set! tmp.7.20 22))
          (if (!= tmp.7.20 6)
            tmp.7.20
            (begin
              (if (begin (set! empty0.25 22) (!= 22 6))
                (if (begin
                      (begin
                        (begin
                          (begin
                            (begin
                              (set! tmp.164 (alloc 16))
                              (set! tmp.126 (+ tmp.164 2)))
                            (begin
                              (mset! tmp.126 -2 L.lam.98.20)
                              (mset! tmp.126 6 0)
                              (set! lam.98 tmp.126)))
                          (set! tmp.163 lam.98))
                        (set! tmp.162
                          (call
                           L.fun/empty8794.15.19
                           fun/empty8794.15
                           tmp.163)))
                      (!= tmp.162 6))
                  (begin (set! tmp.8.24 22))
                  (set! tmp.8.24 6))
                (set! tmp.8.24 6))
              (if (!= tmp.8.24 6)
                tmp.8.24
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.10.27
                          (call L.make-vector.94.16 make-vector.94 64))
                        (begin
                          (set! g43039358.28
                            (call
                             L.vector-set!.95.13
                             vector-set!.95
                             tmp.10.27
                             0
                             0))
                          (if (begin
                                (set! tmp.167
                                  (call L.error?.96.11 error?.96 g43039358.28))
                                (!= tmp.167 6))
                            (set! tmp.166 g43039358.28)
                            (begin
                              (set! g43039359.29
                                (call
                                 L.vector-set!.95.13
                                 vector-set!.95
                                 tmp.10.27
                                 8
                                 8))
                              (if (begin
                                    (set! tmp.168
                                      (call
                                       L.error?.96.11
                                       error?.96
                                       g43039359.29))
                                    (!= tmp.168 6))
                                (set! tmp.166 g43039359.29)
                                (begin
                                  (set! g43039360.30
                                    (call
                                     L.vector-set!.95.13
                                     vector-set!.95
                                     tmp.10.27
                                     16
                                     16))
                                  (if (begin
                                        (set! tmp.169
                                          (call
                                           L.error?.96.11
                                           error?.96
                                           g43039360.30))
                                        (!= tmp.169 6))
                                    (set! tmp.166 g43039360.30)
                                    (begin
                                      (set! g43039361.31
                                        (call
                                         L.vector-set!.95.13
                                         vector-set!.95
                                         tmp.10.27
                                         24
                                         24))
                                      (if (begin
                                            (set! tmp.170
                                              (call
                                               L.error?.96.11
                                               error?.96
                                               g43039361.31))
                                            (!= tmp.170 6))
                                        (set! tmp.166 g43039361.31)
                                        (begin
                                          (set! g43039362.32
                                            (call
                                             L.vector-set!.95.13
                                             vector-set!.95
                                             tmp.10.27
                                             32
                                             32))
                                          (if (begin
                                                (set! tmp.171
                                                  (call
                                                   L.error?.96.11
                                                   error?.96
                                                   g43039362.32))
                                                (!= tmp.171 6))
                                            (set! tmp.166 g43039362.32)
                                            (begin
                                              (set! g43039363.33
                                                (call
                                                 L.vector-set!.95.13
                                                 vector-set!.95
                                                 tmp.10.27
                                                 40
                                                 40))
                                              (if (begin
                                                    (set! tmp.172
                                                      (call
                                                       L.error?.96.11
                                                       error?.96
                                                       g43039363.33))
                                                    (!= tmp.172 6))
                                                (set! tmp.166 g43039363.33)
                                                (begin
                                                  (set! g43039364.34
                                                    (call
                                                     L.vector-set!.95.13
                                                     vector-set!.95
                                                     tmp.10.27
                                                     48
                                                     48))
                                                  (if (begin
                                                        (set! tmp.173
                                                          (call
                                                           L.error?.96.11
                                                           error?.96
                                                           g43039364.34))
                                                        (!= tmp.173 6))
                                                    (set! tmp.166 g43039364.34)
                                                    (begin
                                                      (set! g43039365.35
                                                        (call
                                                         L.vector-set!.95.13
                                                         vector-set!.95
                                                         tmp.10.27
                                                         56
                                                         56))
                                                      (if (begin
                                                            (set! tmp.174
                                                              (call
                                                               L.error?.96.11
                                                               error?.96
                                                               g43039365.35))
                                                            (!= tmp.174 6))
                                                        (set! tmp.166
                                                          g43039365.35)
                                                        (set! tmp.166
                                                          tmp.10.27))))))))))))))))))
                      (set! tmp.165
                        (call
                         L.fun/boolean8796.14.18
                         fun/boolean8796.14
                         tmp.166)))
                    (begin
                      (if (!= 14 6)
                        (begin
                          (begin
                            (begin
                              (set! tmp.176 (alloc 16))
                              (set! tmp.127 (+ tmp.176 2)))
                            (begin
                              (mset! tmp.127 -2 L.lam.99.21)
                              (mset! tmp.127 6 0)
                              (set! lam.99 tmp.127)))
                          (set! tmp.175 lam.99))
                        (begin
                          (begin
                            (begin
                              (set! tmp.177 (alloc 16))
                              (set! tmp.128 (+ tmp.177 2)))
                            (begin
                              (mset! tmp.128 -2 L.lam.100.22)
                              (mset! tmp.128 6 0)
                              (set! lam.100 tmp.128)))
                          (set! tmp.175 lam.100)))
                      (set! tmp.9.26
                        (call
                         L.fun/empty8795.13.17
                         fun/empty8795.13
                         tmp.165
                         tmp.175))))
                  (if (!= tmp.9.26 6)
                    tmp.9.26
                    (begin
                      (if (!= 14 6) (set! tmp.11.36 22) (set! tmp.11.36 22))
                      (if (!= tmp.11.36 6)
                        tmp.11.36
                        (begin
                          (if (!= 6 6) (set! tmp.12.37 22) (set! tmp.12.37 22))
                          (if (!= tmp.12.37 6)
                            tmp.12.37
                            (begin
                              (begin
                                (set! error0.41 41790)
                                (begin
                                  (set! tmp.178
                                    (call L.cons.97.10 cons.97 3552 22))
                                  (set! pair1.40
                                    (call L.cons.97.10 cons.97 1312 tmp.178)))
                                (set! ascii-char2.39 25646)
                                (set! g43039366.38 22))
                              (if (begin
                                    (set! tmp.179
                                      (call
                                       L.error?.96.11
                                       error?.96
                                       g43039366.38))
                                    (!= tmp.179 6))
                                g43039366.38
                                (if (!= 14 6) 22 22)))))))))))))))))
(check-by-interp
 '(module
    (define L.fun/void8799.9.12
      (lambda (c.64)
        (begin
          (set! fun/void8800.8 (mref c.64 14))
          (call L.fun/void8800.8.11 fun/void8800.8))))
    (define L.fun/void8800.8.11
      (lambda (c.63)
        (begin
          (set! fun/void8801.7 (mref c.63 14))
          (call L.fun/void8801.7.10 fun/void8801.7))))
    (define L.fun/void8801.7.10 (lambda (c.62) (begin 30)))
    (begin
      (begin
        (begin (set! tmp.68 (alloc 16)) (set! tmp.65 (+ tmp.68 2)))
        (begin
          (mset! tmp.65 -2 L.fun/void8801.7.10)
          (mset! tmp.65 6 0)
          (set! fun/void8801.7 tmp.65)))
      (begin
        (begin (set! tmp.69 (alloc 24)) (set! tmp.66 (+ tmp.69 2)))
        (begin
          (mset! tmp.66 -2 L.fun/void8800.8.11)
          (mset! tmp.66 6 0)
          (set! fun/void8800.8 tmp.66)))
      (begin
        (begin (set! tmp.70 (alloc 24)) (set! tmp.67 (+ tmp.70 2)))
        (begin
          (mset! tmp.67 -2 L.fun/void8799.9.12)
          (mset! tmp.67 6 0)
          (set! fun/void8799.9 tmp.67)))
      (begin
        (mset! fun/void8800.8 14 fun/void8801.7)
        (mset! fun/void8799.9 14 fun/void8800.8)
        (call L.fun/void8799.9.12 fun/void8799.9)))))
(check-by-interp
 '(module
    (define L.fun/any8804.8.18
      (lambda (c.90 oprand0.10 oprand1.9) (begin 27710)))
    (define L.fixnum?.77.17
      (lambda (c.89 tmp.62)
        (begin
          (if (begin (set! tmp.101 (bitwise-and tmp.62 7)) (= tmp.101 0))
            14
            6))))
    (define L.make-vector.78.16
      (lambda (c.88 tmp.53)
        (begin
          (set! make-init-vector.4 (mref c.88 14))
          (if (begin
                (if (begin (set! tmp.103 (bitwise-and tmp.53 7)) (= tmp.103 0))
                  (set! tmp.102 14)
                  (set! tmp.102 6))
                (!= tmp.102 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.53)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.87 tmp.25)
        (begin
          (set! vector-init-loop.27 (mref c.87 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.107 (arithmetic-shift-right tmp.25 3))
                      (set! tmp.106 (+ 1 tmp.107)))
                    (set! tmp.105 (* tmp.106 8)))
                  (set! tmp.104 (alloc tmp.105)))
                (set! tmp.91 (+ tmp.104 3)))
              (begin (mset! tmp.91 -3 tmp.25) (set! tmp.26 tmp.91)))
            (call
             L.vector-init-loop.27.14
             vector-init-loop.27
             tmp.25
             0
             tmp.26)))))
    (define L.vector-init-loop.27.14
      (lambda (c.86 len.28 i.30 vec.29)
        (begin
          (set! vector-init-loop.27 (mref c.86 14))
          (if (begin
                (if (= len.28 i.30) (set! tmp.108 14) (set! tmp.108 6))
                (!= tmp.108 6))
            vec.29
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.111 (arithmetic-shift-right i.30 3))
                    (set! tmp.110 (* tmp.111 8)))
                  (set! tmp.109 (+ tmp.110 5)))
                (mset! vec.29 tmp.109 0))
              (begin
                (set! tmp.112 (+ i.30 8))
                (call
                 L.vector-init-loop.27.14
                 vector-init-loop.27
                 len.28
                 tmp.112
                 vec.29)))))))
    (define L.vector-set!.79.13
      (lambda (c.85 tmp.55 tmp.56 tmp.57)
        (begin
          (set! unsafe-vector-set!.5 (mref c.85 14))
          (if (begin
                (if (begin (set! tmp.114 (bitwise-and tmp.56 7)) (= tmp.114 0))
                  (set! tmp.113 14)
                  (set! tmp.113 6))
                (!= tmp.113 6))
            (if (begin
                  (if (begin
                        (set! tmp.116 (bitwise-and tmp.55 7))
                        (= tmp.116 3))
                    (set! tmp.115 14)
                    (set! tmp.115 6))
                  (!= tmp.115 6))
              (call
               L.unsafe-vector-set!.5.12
               unsafe-vector-set!.5
               tmp.55
               tmp.56
               tmp.57)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.12
      (lambda (c.84 tmp.31 tmp.32 tmp.33)
        (begin
          (if (begin
                (if (begin (set! tmp.118 (mref tmp.31 -3)) (< tmp.32 tmp.118))
                  (set! tmp.117 14)
                  (set! tmp.117 6))
                (!= tmp.117 6))
            (if (begin
                  (if (>= tmp.32 0) (set! tmp.119 14) (set! tmp.119 6))
                  (!= tmp.119 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.122 (arithmetic-shift-right tmp.32 3))
                      (set! tmp.121 (* tmp.122 8)))
                    (set! tmp.120 (+ tmp.121 5)))
                  (mset! tmp.31 tmp.120 tmp.33))
                30)
              2622)
            2622))))
    (define L.error?.80.11
      (lambda (c.83 tmp.67)
        (begin
          (if (begin (set! tmp.123 (bitwise-and tmp.67 255)) (= tmp.123 62))
            14
            6))))
    (define L.<.81.10
      (lambda (c.82 tmp.45 tmp.46)
        (begin
          (if (begin
                (if (begin (set! tmp.125 (bitwise-and tmp.46 7)) (= tmp.125 0))
                  (set! tmp.124 14)
                  (set! tmp.124 6))
                (!= tmp.124 6))
            (if (begin
                  (if (begin
                        (set! tmp.127 (bitwise-and tmp.45 7))
                        (= tmp.127 0))
                    (set! tmp.126 14)
                    (set! tmp.126 6))
                  (!= tmp.126 6))
              (if (< tmp.45 tmp.46) 14 6)
              1086)
            1086))))
    (begin
      (begin
        (begin (set! tmp.128 (alloc 16)) (set! tmp.92 (+ tmp.128 2)))
        (begin
          (mset! tmp.92 -2 L.<.81.10)
          (mset! tmp.92 6 16)
          (set! <.81 tmp.92)))
      (begin
        (begin (set! tmp.129 (alloc 16)) (set! tmp.93 (+ tmp.129 2)))
        (begin
          (mset! tmp.93 -2 L.error?.80.11)
          (mset! tmp.93 6 8)
          (set! error?.80 tmp.93)))
      (begin
        (begin (set! tmp.130 (alloc 16)) (set! tmp.94 (+ tmp.130 2)))
        (begin
          (mset! tmp.94 -2 L.unsafe-vector-set!.5.12)
          (mset! tmp.94 6 24)
          (set! unsafe-vector-set!.5 tmp.94)))
      (begin
        (begin (set! tmp.131 (alloc 24)) (set! tmp.95 (+ tmp.131 2)))
        (begin
          (mset! tmp.95 -2 L.vector-set!.79.13)
          (mset! tmp.95 6 24)
          (set! vector-set!.79 tmp.95)))
      (begin
        (begin (set! tmp.132 (alloc 24)) (set! tmp.96 (+ tmp.132 2)))
        (begin
          (mset! tmp.96 -2 L.vector-init-loop.27.14)
          (mset! tmp.96 6 24)
          (set! vector-init-loop.27 tmp.96)))
      (begin
        (begin (set! tmp.133 (alloc 24)) (set! tmp.97 (+ tmp.133 2)))
        (begin
          (mset! tmp.97 -2 L.make-init-vector.4.15)
          (mset! tmp.97 6 8)
          (set! make-init-vector.4 tmp.97)))
      (begin
        (begin (set! tmp.134 (alloc 24)) (set! tmp.98 (+ tmp.134 2)))
        (begin
          (mset! tmp.98 -2 L.make-vector.78.16)
          (mset! tmp.98 6 8)
          (set! make-vector.78 tmp.98)))
      (begin
        (begin (set! tmp.135 (alloc 16)) (set! tmp.99 (+ tmp.135 2)))
        (begin
          (mset! tmp.99 -2 L.fixnum?.77.17)
          (mset! tmp.99 6 8)
          (set! fixnum?.77 tmp.99)))
      (begin
        (begin (set! tmp.136 (alloc 16)) (set! tmp.100 (+ tmp.136 2)))
        (begin
          (mset! tmp.100 -2 L.fun/any8804.8.18)
          (mset! tmp.100 6 16)
          (set! fun/any8804.8 tmp.100)))
      (begin
        (mset! vector-set!.79 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.27 14 vector-init-loop.27)
        (mset! make-init-vector.4 14 vector-init-loop.27)
        (mset! make-vector.78 14 make-init-vector.4)
        (if (begin
              (begin
                (set! tmp.138 (call L.fun/any8804.8.18 fun/any8804.8 22 30))
                (set! tmp.137 (call L.fixnum?.77.17 fixnum?.77 tmp.138)))
              (!= tmp.137 6))
          (begin (set! boolean0.12 6) (set! boolean1.11 14) 14)
          (begin
            (if (!= 1232 6)
              (if (!= 448 6)
                (if (!= 752 6)
                  (if (!= 776 6)
                    (if (!= 952 6) (set! tmp.139 168) (set! tmp.139 6))
                    (set! tmp.139 6))
                  (set! tmp.139 6))
                (set! tmp.139 6))
              (set! tmp.139 6))
            (begin
              (begin
                (set! void0.15 30)
                (begin
                  (set! tmp.7.16 (call L.make-vector.78.16 make-vector.78 64))
                  (begin
                    (set! g43047001.17
                      (call L.vector-set!.79.13 vector-set!.79 tmp.7.16 0 8))
                    (if (begin
                          (set! tmp.141
                            (call L.error?.80.11 error?.80 g43047001.17))
                          (!= tmp.141 6))
                      (set! vector1.14 g43047001.17)
                      (begin
                        (set! g43047002.18
                          (call
                           L.vector-set!.79.13
                           vector-set!.79
                           tmp.7.16
                           8
                           16))
                        (if (begin
                              (set! tmp.142
                                (call L.error?.80.11 error?.80 g43047002.18))
                              (!= tmp.142 6))
                          (set! vector1.14 g43047002.18)
                          (begin
                            (set! g43047003.19
                              (call
                               L.vector-set!.79.13
                               vector-set!.79
                               tmp.7.16
                               16
                               24))
                            (if (begin
                                  (set! tmp.143
                                    (call
                                     L.error?.80.11
                                     error?.80
                                     g43047003.19))
                                  (!= tmp.143 6))
                              (set! vector1.14 g43047003.19)
                              (begin
                                (set! g43047004.20
                                  (call
                                   L.vector-set!.79.13
                                   vector-set!.79
                                   tmp.7.16
                                   24
                                   32))
                                (if (begin
                                      (set! tmp.144
                                        (call
                                         L.error?.80.11
                                         error?.80
                                         g43047004.20))
                                      (!= tmp.144 6))
                                  (set! vector1.14 g43047004.20)
                                  (begin
                                    (set! g43047005.21
                                      (call
                                       L.vector-set!.79.13
                                       vector-set!.79
                                       tmp.7.16
                                       32
                                       40))
                                    (if (begin
                                          (set! tmp.145
                                            (call
                                             L.error?.80.11
                                             error?.80
                                             g43047005.21))
                                          (!= tmp.145 6))
                                      (set! vector1.14 g43047005.21)
                                      (begin
                                        (set! g43047006.22
                                          (call
                                           L.vector-set!.79.13
                                           vector-set!.79
                                           tmp.7.16
                                           40
                                           48))
                                        (if (begin
                                              (set! tmp.146
                                                (call
                                                 L.error?.80.11
                                                 error?.80
                                                 g43047006.22))
                                              (!= tmp.146 6))
                                          (set! vector1.14 g43047006.22)
                                          (begin
                                            (set! g43047007.23
                                              (call
                                               L.vector-set!.79.13
                                               vector-set!.79
                                               tmp.7.16
                                               48
                                               56))
                                            (if (begin
                                                  (set! tmp.147
                                                    (call
                                                     L.error?.80.11
                                                     error?.80
                                                     g43047007.23))
                                                  (!= tmp.147 6))
                                              (set! vector1.14 g43047007.23)
                                              (begin
                                                (set! g43047008.24
                                                  (call
                                                   L.vector-set!.79.13
                                                   vector-set!.79
                                                   tmp.7.16
                                                   56
                                                   64))
                                                (if (begin
                                                      (set! tmp.148
                                                        (call
                                                         L.error?.80.11
                                                         error?.80
                                                         g43047008.24))
                                                      (!= tmp.148 6))
                                                  (set! vector1.14
                                                    g43047008.24)
                                                  (set! vector1.14
                                                    tmp.7.16))))))))))))))))))
                (set! void2.13 30)
                (set! tmp.140 736))
              (call L.<.81.10 <.81 tmp.139 tmp.140))))))))
(check-by-interp
 '(module
    (define L.fun/fixnum8807.7.11
      (lambda (c.63)
        (begin
          (set! cons.61 (mref c.63 14))
          (begin (set! pair0.8 (call L.cons.61.10 cons.61 27182 16190)) 296))))
    (define L.cons.61.10
      (lambda (c.62 tmp.56 tmp.57)
        (begin
          (begin
            (begin (set! tmp.67 (alloc 16)) (set! tmp.64 (+ tmp.67 1)))
            (begin (mset! tmp.64 -1 tmp.56) (mset! tmp.64 7 tmp.57) tmp.64)))))
    (begin
      (begin
        (begin (set! tmp.68 (alloc 16)) (set! tmp.65 (+ tmp.68 2)))
        (begin
          (mset! tmp.65 -2 L.cons.61.10)
          (mset! tmp.65 6 16)
          (set! cons.61 tmp.65)))
      (begin
        (begin (set! tmp.69 (alloc 24)) (set! tmp.66 (+ tmp.69 2)))
        (begin
          (mset! tmp.66 -2 L.fun/fixnum8807.7.11)
          (mset! tmp.66 6 0)
          (set! fun/fixnum8807.7 tmp.66)))
      (begin
        (mset! fun/fixnum8807.7 14 cons.61)
        (begin (call L.fun/fixnum8807.7.11 fun/fixnum8807.7))))))
(check-by-interp
 '(module
    (begin
      (if (!= 14 6) (set! void0.7 30) (set! void0.7 30))
      (begin (set! void0.9 30) (set! empty1.8 22) 30))))
(check-by-interp
 '(module
    (begin
      (begin (set! fixnum0.9 864) (set! error1.8 29758) (set! empty0.7 22))
      (if (!= 6 6) 22 22))))
(check-by-interp
 '(module
    (define L.error?.70.10
      (lambda (c.71 tmp.60)
        (begin
          (if (begin (set! tmp.73 (bitwise-and tmp.60 255)) (= tmp.73 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.74 (alloc 16)) (set! tmp.72 (+ tmp.74 2)))
        (begin
          (mset! tmp.72 -2 L.error?.70.10)
          (mset! tmp.72 6 8)
          (set! error?.70 tmp.72)))
      (begin
        (begin
          (set! tmp.7.11 22)
          (if (!= tmp.7.11 6) (set! empty0.10 tmp.7.11) (set! empty0.10 22)))
        (begin
          (begin
            (set! g43062279.13 24366)
            (if (begin
                  (set! tmp.75 (call L.error?.70.10 error?.70 g43062279.13))
                  (!= tmp.75 6))
              (set! g43062278.12 g43062279.13)
              (begin
                (set! g43062280.14 23086)
                (if (begin
                      (set! tmp.76
                        (call L.error?.70.10 error?.70 g43062280.14))
                      (!= tmp.76 6))
                  (set! g43062278.12 g43062280.14)
                  (begin
                    (set! g43062281.15 29998)
                    (if (begin
                          (set! tmp.77
                            (call L.error?.70.10 error?.70 g43062281.15))
                          (!= tmp.77 6))
                      (set! g43062278.12 g43062281.15)
                      (set! g43062278.12 20782)))))))
          (if (begin
                (set! tmp.78 (call L.error?.70.10 error?.70 g43062278.12))
                (!= tmp.78 6))
            (set! ascii-char1.9 g43062278.12)
            (begin
              (begin (set! g43062282.16 24110))
              (if (begin
                    (set! tmp.79 (call L.error?.70.10 error?.70 g43062282.16))
                    (!= tmp.79 6))
                (set! ascii-char1.9 g43062282.16)
                (begin
                  (begin (set! g43062283.17 27694))
                  (if (begin
                        (set! tmp.80
                          (call L.error?.70.10 error?.70 g43062283.17))
                        (!= tmp.80 6))
                    (set! ascii-char1.9 g43062283.17)
                    (begin (set! ascii-char1.9 27950))))))))
        (begin (set! error2.8 13374))
        (begin 144)))))
(check-by-interp
 '(module
    (define L.cons.60.11
      (lambda (c.63 tmp.55 tmp.56)
        (begin
          (begin
            (begin (set! tmp.67 (alloc 16)) (set! tmp.64 (+ tmp.67 1)))
            (begin (mset! tmp.64 -1 tmp.55) (mset! tmp.64 7 tmp.56) tmp.64)))))
    (define L.+.61.10
      (lambda (c.62 tmp.24 tmp.25)
        (begin
          (if (begin
                (if (begin (set! tmp.69 (bitwise-and tmp.25 7)) (= tmp.69 0))
                  (set! tmp.68 14)
                  (set! tmp.68 6))
                (!= tmp.68 6))
            (if (begin
                  (if (begin (set! tmp.71 (bitwise-and tmp.24 7)) (= tmp.71 0))
                    (set! tmp.70 14)
                    (set! tmp.70 6))
                  (!= tmp.70 6))
              (+ tmp.24 tmp.25)
              574)
            574))))
    (begin
      (begin
        (begin (set! tmp.72 (alloc 16)) (set! tmp.65 (+ tmp.72 2)))
        (begin
          (mset! tmp.65 -2 L.+.61.10)
          (mset! tmp.65 6 16)
          (set! |+.61| tmp.65)))
      (begin
        (begin (set! tmp.73 (alloc 16)) (set! tmp.66 (+ tmp.73 2)))
        (begin
          (mset! tmp.66 -2 L.cons.60.11)
          (mset! tmp.66 6 16)
          (set! cons.60 tmp.66)))
      (begin
        (if (!= 14 6) (set! tmp.74 752) (set! tmp.74 1288))
        (begin
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.80 (call L.cons.60.11 cons.60 2064 22))
                      (set! tmp.79 (call L.cons.60.11 cons.60 272 tmp.80)))
                    (begin
                      (begin
                        (begin
                          (begin
                            (set! tmp.84 (call L.cons.60.11 cons.60 672 22))
                            (set! tmp.83 (call L.cons.60.11 cons.60 6 tmp.84)))
                          (set! tmp.82 (call L.cons.60.11 cons.60 22 tmp.83)))
                        (set! tmp.81 (call L.cons.60.11 cons.60 19502 tmp.82)))
                      (set! tmp.78 (call L.cons.60.11 cons.60 tmp.79 tmp.81))))
                  (set! tmp.77 (call L.cons.60.11 cons.60 6 tmp.78)))
                (set! tmp.76 (call L.cons.60.11 cons.60 1640 tmp.77)))
              (set! pair0.7 (call L.cons.60.11 cons.60 22 tmp.76)))
            (if (!= 6 6) (set! tmp.75 312) (set! tmp.75 1328)))
          (call L.+.61.10 |+.61| tmp.74 tmp.75))))))
(check-by-interp
 '(module
    (define L.fun/boolean8824.10.14 (lambda (c.69 oprand0.11) (begin 6)))
    (define L.fun/ascii-char8825.9.13 (lambda (c.68) (begin 29230)))
    (define L.fun/ascii-char8823.8.12
      (lambda (c.67)
        (begin
          (set! fun/ascii-char8826.7 (mref c.67 14))
          (set! fun/ascii-char8825.9 (mref c.67 22))
          (set! cons.64 (mref c.67 30))
          (set! fun/boolean8824.10 (mref c.67 38))
          (if (begin
                (begin
                  (begin
                    (set! tmp.78 (call L.cons.64.10 cons.64 2400 22))
                    (set! tmp.77 (call L.cons.64.10 cons.64 896 tmp.78)))
                  (set! tmp.76
                    (call L.fun/boolean8824.10.14 fun/boolean8824.10 tmp.77)))
                (!= tmp.76 6))
            (call L.fun/ascii-char8825.9.13 fun/ascii-char8825.9)
            (call L.fun/ascii-char8826.7.11 fun/ascii-char8826.7)))))
    (define L.fun/ascii-char8826.7.11 (lambda (c.66) (begin 27438)))
    (define L.cons.64.10
      (lambda (c.65 tmp.59 tmp.60)
        (begin
          (begin
            (begin (set! tmp.79 (alloc 16)) (set! tmp.70 (+ tmp.79 1)))
            (begin (mset! tmp.70 -1 tmp.59) (mset! tmp.70 7 tmp.60) tmp.70)))))
    (begin
      (begin
        (begin (set! tmp.80 (alloc 16)) (set! tmp.71 (+ tmp.80 2)))
        (begin
          (mset! tmp.71 -2 L.cons.64.10)
          (mset! tmp.71 6 16)
          (set! cons.64 tmp.71)))
      (begin
        (begin (set! tmp.81 (alloc 16)) (set! tmp.72 (+ tmp.81 2)))
        (begin
          (mset! tmp.72 -2 L.fun/ascii-char8826.7.11)
          (mset! tmp.72 6 0)
          (set! fun/ascii-char8826.7 tmp.72)))
      (begin
        (begin (set! tmp.82 (alloc 48)) (set! tmp.73 (+ tmp.82 2)))
        (begin
          (mset! tmp.73 -2 L.fun/ascii-char8823.8.12)
          (mset! tmp.73 6 0)
          (set! fun/ascii-char8823.8 tmp.73)))
      (begin
        (begin (set! tmp.83 (alloc 16)) (set! tmp.74 (+ tmp.83 2)))
        (begin
          (mset! tmp.74 -2 L.fun/ascii-char8825.9.13)
          (mset! tmp.74 6 0)
          (set! fun/ascii-char8825.9 tmp.74)))
      (begin
        (begin (set! tmp.84 (alloc 16)) (set! tmp.75 (+ tmp.84 2)))
        (begin
          (mset! tmp.75 -2 L.fun/boolean8824.10.14)
          (mset! tmp.75 6 8)
          (set! fun/boolean8824.10 tmp.75)))
      (begin
        (mset! fun/ascii-char8823.8 14 fun/ascii-char8826.7)
        (mset! fun/ascii-char8823.8 22 fun/ascii-char8825.9)
        (mset! fun/ascii-char8823.8 30 cons.64)
        (mset! fun/ascii-char8823.8 38 fun/boolean8824.10)
        (call L.fun/ascii-char8823.8.12 fun/ascii-char8823.8)))))
(check-by-interp
 '(module
    (define L.fun/boolean8830.10.13
      (lambda (c.69)
        (begin
          (set! fun/boolean8831.7 (mref c.69 14))
          (call L.fun/boolean8831.7.10 fun/boolean8831.7))))
    (define L.fun/boolean8832.9.12 (lambda (c.68) (begin 14)))
    (define L.fun/boolean8829.8.11
      (lambda (c.67 oprand0.11)
        (begin
          (set! fun/boolean8830.10 (mref c.67 14))
          (call L.fun/boolean8830.10.13 fun/boolean8830.10))))
    (define L.fun/boolean8831.7.10
      (lambda (c.66)
        (begin
          (set! fun/boolean8832.9 (mref c.66 14))
          (call L.fun/boolean8832.9.12 fun/boolean8832.9))))
    (begin
      (begin
        (begin (set! tmp.74 (alloc 24)) (set! tmp.70 (+ tmp.74 2)))
        (begin
          (mset! tmp.70 -2 L.fun/boolean8831.7.10)
          (mset! tmp.70 6 0)
          (set! fun/boolean8831.7 tmp.70)))
      (begin
        (begin (set! tmp.75 (alloc 24)) (set! tmp.71 (+ tmp.75 2)))
        (begin
          (mset! tmp.71 -2 L.fun/boolean8829.8.11)
          (mset! tmp.71 6 8)
          (set! fun/boolean8829.8 tmp.71)))
      (begin
        (begin (set! tmp.76 (alloc 16)) (set! tmp.72 (+ tmp.76 2)))
        (begin
          (mset! tmp.72 -2 L.fun/boolean8832.9.12)
          (mset! tmp.72 6 0)
          (set! fun/boolean8832.9 tmp.72)))
      (begin
        (begin (set! tmp.77 (alloc 24)) (set! tmp.73 (+ tmp.77 2)))
        (begin
          (mset! tmp.73 -2 L.fun/boolean8830.10.13)
          (mset! tmp.73 6 0)
          (set! fun/boolean8830.10 tmp.73)))
      (begin
        (mset! fun/boolean8831.7 14 fun/boolean8832.9)
        (mset! fun/boolean8829.8 14 fun/boolean8830.10)
        (mset! fun/boolean8830.10 14 fun/boolean8831.7)
        (begin
          (if (begin (set! void0.12 30) (!= 6 6))
            (if (!= 6 6) (set! tmp.78 22) (set! tmp.78 22))
            (begin (set! void0.13 30) (set! tmp.78 22)))
          (call L.fun/boolean8829.8.11 fun/boolean8829.8 tmp.78))))))
(check-by-interp
 '(module
    (define L.error?.79.15
      (lambda (c.87 tmp.69)
        (begin
          (if (begin (set! tmp.95 (bitwise-and tmp.69 255)) (= tmp.95 62))
            14
            6))))
    (define L.make-vector.80.14
      (lambda (c.86 tmp.55)
        (begin
          (set! make-init-vector.4 (mref c.86 14))
          (if (begin
                (if (begin (set! tmp.97 (bitwise-and tmp.55 7)) (= tmp.97 0))
                  (set! tmp.96 14)
                  (set! tmp.96 6))
                (!= tmp.96 6))
            (call L.make-init-vector.4.13 make-init-vector.4 tmp.55)
            2110))))
    (define L.make-init-vector.4.13
      (lambda (c.85 tmp.27)
        (begin
          (set! vector-init-loop.29 (mref c.85 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.101 (arithmetic-shift-right tmp.27 3))
                      (set! tmp.100 (+ 1 tmp.101)))
                    (set! tmp.99 (* tmp.100 8)))
                  (set! tmp.98 (alloc tmp.99)))
                (set! tmp.88 (+ tmp.98 3)))
              (begin (mset! tmp.88 -3 tmp.27) (set! tmp.28 tmp.88)))
            (call
             L.vector-init-loop.29.12
             vector-init-loop.29
             tmp.27
             0
             tmp.28)))))
    (define L.vector-init-loop.29.12
      (lambda (c.84 len.30 i.32 vec.31)
        (begin
          (set! vector-init-loop.29 (mref c.84 14))
          (if (begin
                (if (= len.30 i.32) (set! tmp.102 14) (set! tmp.102 6))
                (!= tmp.102 6))
            vec.31
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.105 (arithmetic-shift-right i.32 3))
                    (set! tmp.104 (* tmp.105 8)))
                  (set! tmp.103 (+ tmp.104 5)))
                (mset! vec.31 tmp.103 0))
              (begin
                (set! tmp.106 (+ i.32 8))
                (call
                 L.vector-init-loop.29.12
                 vector-init-loop.29
                 len.30
                 tmp.106
                 vec.31)))))))
    (define L.vector-set!.81.11
      (lambda (c.83 tmp.57 tmp.58 tmp.59)
        (begin
          (set! unsafe-vector-set!.5 (mref c.83 14))
          (if (begin
                (if (begin (set! tmp.108 (bitwise-and tmp.58 7)) (= tmp.108 0))
                  (set! tmp.107 14)
                  (set! tmp.107 6))
                (!= tmp.107 6))
            (if (begin
                  (if (begin
                        (set! tmp.110 (bitwise-and tmp.57 7))
                        (= tmp.110 3))
                    (set! tmp.109 14)
                    (set! tmp.109 6))
                  (!= tmp.109 6))
              (call
               L.unsafe-vector-set!.5.10
               unsafe-vector-set!.5
               tmp.57
               tmp.58
               tmp.59)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.10
      (lambda (c.82 tmp.33 tmp.34 tmp.35)
        (begin
          (if (begin
                (if (begin (set! tmp.112 (mref tmp.33 -3)) (< tmp.34 tmp.112))
                  (set! tmp.111 14)
                  (set! tmp.111 6))
                (!= tmp.111 6))
            (if (begin
                  (if (>= tmp.34 0) (set! tmp.113 14) (set! tmp.113 6))
                  (!= tmp.113 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.116 (arithmetic-shift-right tmp.34 3))
                      (set! tmp.115 (* tmp.116 8)))
                    (set! tmp.114 (+ tmp.115 5)))
                  (mset! tmp.33 tmp.114 tmp.35))
                30)
              2622)
            2622))))
    (begin
      (begin
        (begin (set! tmp.117 (alloc 16)) (set! tmp.89 (+ tmp.117 2)))
        (begin
          (mset! tmp.89 -2 L.unsafe-vector-set!.5.10)
          (mset! tmp.89 6 24)
          (set! unsafe-vector-set!.5 tmp.89)))
      (begin
        (begin (set! tmp.118 (alloc 24)) (set! tmp.90 (+ tmp.118 2)))
        (begin
          (mset! tmp.90 -2 L.vector-set!.81.11)
          (mset! tmp.90 6 24)
          (set! vector-set!.81 tmp.90)))
      (begin
        (begin (set! tmp.119 (alloc 24)) (set! tmp.91 (+ tmp.119 2)))
        (begin
          (mset! tmp.91 -2 L.vector-init-loop.29.12)
          (mset! tmp.91 6 24)
          (set! vector-init-loop.29 tmp.91)))
      (begin
        (begin (set! tmp.120 (alloc 24)) (set! tmp.92 (+ tmp.120 2)))
        (begin
          (mset! tmp.92 -2 L.make-init-vector.4.13)
          (mset! tmp.92 6 8)
          (set! make-init-vector.4 tmp.92)))
      (begin
        (begin (set! tmp.121 (alloc 24)) (set! tmp.93 (+ tmp.121 2)))
        (begin
          (mset! tmp.93 -2 L.make-vector.80.14)
          (mset! tmp.93 6 8)
          (set! make-vector.80 tmp.93)))
      (begin
        (begin (set! tmp.122 (alloc 16)) (set! tmp.94 (+ tmp.122 2)))
        (begin
          (mset! tmp.94 -2 L.error?.79.15)
          (mset! tmp.94 6 8)
          (set! error?.79 tmp.94)))
      (begin
        (mset! vector-set!.81 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.29 14 vector-init-loop.29)
        (mset! make-init-vector.4 14 vector-init-loop.29)
        (mset! make-vector.80 14 make-init-vector.4)
        (if (begin
              (begin (set! g43077547.8 14))
              (if (begin
                    (set! tmp.123 (call L.error?.79.15 error?.79 g43077547.8))
                    (!= tmp.123 6))
                (!= g43077547.8 6)
                (begin
                  (if (!= 14 6)
                    (if (!= 6 6)
                      (if (!= 6 6)
                        (if (!= 14 6)
                          (if (!= 14 6)
                            (if (!= 14 6)
                              (set! g43077548.9 14)
                              (set! g43077548.9 6))
                            (set! g43077548.9 6))
                          (set! g43077548.9 6))
                        (set! g43077548.9 6))
                      (set! g43077548.9 6))
                    (set! g43077548.9 6))
                  (if (begin
                        (set! tmp.124
                          (call L.error?.79.15 error?.79 g43077548.9))
                        (!= tmp.124 6))
                    (!= g43077548.9 6)
                    (begin
                      (if (!= 14 6)
                        (set! g43077549.10 6)
                        (set! g43077549.10 6))
                      (if (begin
                            (set! tmp.125
                              (call L.error?.79.15 error?.79 g43077549.10))
                            (!= tmp.125 6))
                        (!= g43077549.10 6)
                        (begin
                          (if (!= 6 6)
                            (set! g43077550.11 6)
                            (set! g43077550.11 14))
                          (if (begin
                                (set! tmp.126
                                  (call L.error?.79.15 error?.79 g43077550.11))
                                (!= tmp.126 6))
                            (!= g43077550.11 6)
                            (begin (!= 6 6))))))))))
          (begin
            (set! error0.14 54078)
            (set! boolean1.13 6)
            (set! boolean2.12 14)
            30)
          (begin
            (set! ascii-char0.17 17966)
            (begin
              (set! tmp.7.18 (call L.make-vector.80.14 make-vector.80 64))
              (begin
                (set! g43077551.19
                  (call L.vector-set!.81.11 vector-set!.81 tmp.7.18 0 8))
                (if (begin
                      (set! tmp.127
                        (call L.error?.79.15 error?.79 g43077551.19))
                      (!= tmp.127 6))
                  (set! vector1.16 g43077551.19)
                  (begin
                    (set! g43077552.20
                      (call L.vector-set!.81.11 vector-set!.81 tmp.7.18 8 16))
                    (if (begin
                          (set! tmp.128
                            (call L.error?.79.15 error?.79 g43077552.20))
                          (!= tmp.128 6))
                      (set! vector1.16 g43077552.20)
                      (begin
                        (set! g43077553.21
                          (call
                           L.vector-set!.81.11
                           vector-set!.81
                           tmp.7.18
                           16
                           24))
                        (if (begin
                              (set! tmp.129
                                (call L.error?.79.15 error?.79 g43077553.21))
                              (!= tmp.129 6))
                          (set! vector1.16 g43077553.21)
                          (begin
                            (set! g43077554.22
                              (call
                               L.vector-set!.81.11
                               vector-set!.81
                               tmp.7.18
                               24
                               32))
                            (if (begin
                                  (set! tmp.130
                                    (call
                                     L.error?.79.15
                                     error?.79
                                     g43077554.22))
                                  (!= tmp.130 6))
                              (set! vector1.16 g43077554.22)
                              (begin
                                (set! g43077555.23
                                  (call
                                   L.vector-set!.81.11
                                   vector-set!.81
                                   tmp.7.18
                                   32
                                   40))
                                (if (begin
                                      (set! tmp.131
                                        (call
                                         L.error?.79.15
                                         error?.79
                                         g43077555.23))
                                      (!= tmp.131 6))
                                  (set! vector1.16 g43077555.23)
                                  (begin
                                    (set! g43077556.24
                                      (call
                                       L.vector-set!.81.11
                                       vector-set!.81
                                       tmp.7.18
                                       40
                                       48))
                                    (if (begin
                                          (set! tmp.132
                                            (call
                                             L.error?.79.15
                                             error?.79
                                             g43077556.24))
                                          (!= tmp.132 6))
                                      (set! vector1.16 g43077556.24)
                                      (begin
                                        (set! g43077557.25
                                          (call
                                           L.vector-set!.81.11
                                           vector-set!.81
                                           tmp.7.18
                                           48
                                           56))
                                        (if (begin
                                              (set! tmp.133
                                                (call
                                                 L.error?.79.15
                                                 error?.79
                                                 g43077557.25))
                                              (!= tmp.133 6))
                                          (set! vector1.16 g43077557.25)
                                          (begin
                                            (set! g43077558.26
                                              (call
                                               L.vector-set!.81.11
                                               vector-set!.81
                                               tmp.7.18
                                               56
                                               64))
                                            (if (begin
                                                  (set! tmp.134
                                                    (call
                                                     L.error?.79.15
                                                     error?.79
                                                     g43077558.26))
                                                  (!= tmp.134 6))
                                              (set! vector1.16 g43077558.26)
                                              (set! vector1.16
                                                tmp.7.18))))))))))))))))))
            (set! ascii-char2.15 19502)
            30))))))
(check-by-interp
 '(module
    (define L.lam.139.22 (lambda (c.152) (begin 30)))
    (define L.fun/boolean8838.17.21 (lambda (c.151) (begin 6)))
    (define L.fun/boolean8837.16.20
      (lambda (c.150 oprand0.25 oprand1.24)
        (begin
          (set! fun/boolean8838.17 (mref c.150 14))
          (call L.fun/boolean8838.17.21 fun/boolean8838.17))))
    (define L.fun/ascii-char8841.15.19
      (lambda (c.149 oprand0.23 oprand1.22) (begin 28718)))
    (define L.fun/ascii-char8839.14.18
      (lambda (c.148 oprand0.21 oprand1.20) (begin 28974)))
    (define L.fun/ascii-char8840.13.17
      (lambda (c.147 oprand0.19 oprand1.18) (begin 19758)))
    (define L.error?.135.16
      (lambda (c.146 tmp.125)
        (begin
          (if (begin (set! tmp.168 (bitwise-and tmp.125 255)) (= tmp.168 62))
            14
            6))))
    (define L.make-vector.136.15
      (lambda (c.145 tmp.111)
        (begin
          (set! make-init-vector.4 (mref c.145 14))
          (if (begin
                (if (begin
                      (set! tmp.170 (bitwise-and tmp.111 7))
                      (= tmp.170 0))
                  (set! tmp.169 14)
                  (set! tmp.169 6))
                (!= tmp.169 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.111)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.144 tmp.83)
        (begin
          (set! vector-init-loop.85 (mref c.144 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.174 (arithmetic-shift-right tmp.83 3))
                      (set! tmp.173 (+ 1 tmp.174)))
                    (set! tmp.172 (* tmp.173 8)))
                  (set! tmp.171 (alloc tmp.172)))
                (set! tmp.153 (+ tmp.171 3)))
              (begin (mset! tmp.153 -3 tmp.83) (set! tmp.84 tmp.153)))
            (call
             L.vector-init-loop.85.13
             vector-init-loop.85
             tmp.83
             0
             tmp.84)))))
    (define L.vector-init-loop.85.13
      (lambda (c.143 len.86 i.88 vec.87)
        (begin
          (set! vector-init-loop.85 (mref c.143 14))
          (if (begin
                (if (= len.86 i.88) (set! tmp.175 14) (set! tmp.175 6))
                (!= tmp.175 6))
            vec.87
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.178 (arithmetic-shift-right i.88 3))
                    (set! tmp.177 (* tmp.178 8)))
                  (set! tmp.176 (+ tmp.177 5)))
                (mset! vec.87 tmp.176 0))
              (begin
                (set! tmp.179 (+ i.88 8))
                (call
                 L.vector-init-loop.85.13
                 vector-init-loop.85
                 len.86
                 tmp.179
                 vec.87)))))))
    (define L.vector-set!.137.12
      (lambda (c.142 tmp.113 tmp.114 tmp.115)
        (begin
          (set! unsafe-vector-set!.5 (mref c.142 14))
          (if (begin
                (if (begin
                      (set! tmp.181 (bitwise-and tmp.114 7))
                      (= tmp.181 0))
                  (set! tmp.180 14)
                  (set! tmp.180 6))
                (!= tmp.180 6))
            (if (begin
                  (if (begin
                        (set! tmp.183 (bitwise-and tmp.113 7))
                        (= tmp.183 3))
                    (set! tmp.182 14)
                    (set! tmp.182 6))
                  (!= tmp.182 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.113
               tmp.114
               tmp.115)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.141 tmp.89 tmp.90 tmp.91)
        (begin
          (if (begin
                (if (begin (set! tmp.185 (mref tmp.89 -3)) (< tmp.90 tmp.185))
                  (set! tmp.184 14)
                  (set! tmp.184 6))
                (!= tmp.184 6))
            (if (begin
                  (if (>= tmp.90 0) (set! tmp.186 14) (set! tmp.186 6))
                  (!= tmp.186 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.189 (arithmetic-shift-right tmp.90 3))
                      (set! tmp.188 (* tmp.189 8)))
                    (set! tmp.187 (+ tmp.188 5)))
                  (mset! tmp.89 tmp.187 tmp.91))
                30)
              2622)
            2622))))
    (define L.cons.138.10
      (lambda (c.140 tmp.130 tmp.131)
        (begin
          (begin
            (begin (set! tmp.190 (alloc 16)) (set! tmp.154 (+ tmp.190 1)))
            (begin
              (mset! tmp.154 -1 tmp.130)
              (mset! tmp.154 7 tmp.131)
              tmp.154)))))
    (begin
      (begin
        (begin (set! tmp.191 (alloc 16)) (set! tmp.155 (+ tmp.191 2)))
        (begin
          (mset! tmp.155 -2 L.cons.138.10)
          (mset! tmp.155 6 16)
          (set! cons.138 tmp.155)))
      (begin
        (begin (set! tmp.192 (alloc 16)) (set! tmp.156 (+ tmp.192 2)))
        (begin
          (mset! tmp.156 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.156 6 24)
          (set! unsafe-vector-set!.5 tmp.156)))
      (begin
        (begin (set! tmp.193 (alloc 24)) (set! tmp.157 (+ tmp.193 2)))
        (begin
          (mset! tmp.157 -2 L.vector-set!.137.12)
          (mset! tmp.157 6 24)
          (set! vector-set!.137 tmp.157)))
      (begin
        (begin (set! tmp.194 (alloc 24)) (set! tmp.158 (+ tmp.194 2)))
        (begin
          (mset! tmp.158 -2 L.vector-init-loop.85.13)
          (mset! tmp.158 6 24)
          (set! vector-init-loop.85 tmp.158)))
      (begin
        (begin (set! tmp.195 (alloc 24)) (set! tmp.159 (+ tmp.195 2)))
        (begin
          (mset! tmp.159 -2 L.make-init-vector.4.14)
          (mset! tmp.159 6 8)
          (set! make-init-vector.4 tmp.159)))
      (begin
        (begin (set! tmp.196 (alloc 24)) (set! tmp.160 (+ tmp.196 2)))
        (begin
          (mset! tmp.160 -2 L.make-vector.136.15)
          (mset! tmp.160 6 8)
          (set! make-vector.136 tmp.160)))
      (begin
        (begin (set! tmp.197 (alloc 16)) (set! tmp.161 (+ tmp.197 2)))
        (begin
          (mset! tmp.161 -2 L.error?.135.16)
          (mset! tmp.161 6 8)
          (set! error?.135 tmp.161)))
      (begin
        (begin (set! tmp.198 (alloc 16)) (set! tmp.162 (+ tmp.198 2)))
        (begin
          (mset! tmp.162 -2 L.fun/ascii-char8840.13.17)
          (mset! tmp.162 6 16)
          (set! fun/ascii-char8840.13 tmp.162)))
      (begin
        (begin (set! tmp.199 (alloc 16)) (set! tmp.163 (+ tmp.199 2)))
        (begin
          (mset! tmp.163 -2 L.fun/ascii-char8839.14.18)
          (mset! tmp.163 6 16)
          (set! fun/ascii-char8839.14 tmp.163)))
      (begin
        (begin (set! tmp.200 (alloc 16)) (set! tmp.164 (+ tmp.200 2)))
        (begin
          (mset! tmp.164 -2 L.fun/ascii-char8841.15.19)
          (mset! tmp.164 6 16)
          (set! fun/ascii-char8841.15 tmp.164)))
      (begin
        (begin (set! tmp.201 (alloc 24)) (set! tmp.165 (+ tmp.201 2)))
        (begin
          (mset! tmp.165 -2 L.fun/boolean8837.16.20)
          (mset! tmp.165 6 16)
          (set! fun/boolean8837.16 tmp.165)))
      (begin
        (begin (set! tmp.202 (alloc 16)) (set! tmp.166 (+ tmp.202 2)))
        (begin
          (mset! tmp.166 -2 L.fun/boolean8838.17.21)
          (mset! tmp.166 6 0)
          (set! fun/boolean8838.17 tmp.166)))
      (begin
        (mset! vector-set!.137 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.85 14 vector-init-loop.85)
        (mset! make-init-vector.4 14 vector-init-loop.85)
        (mset! make-vector.136 14 make-init-vector.4)
        (mset! fun/boolean8837.16 14 fun/boolean8838.17)
        (if (begin
              (begin
                (begin
                  (set! g43081376.26 2366)
                  (if (begin
                        (set! tmp.205
                          (call L.error?.135.16 error?.135 g43081376.26))
                        (!= tmp.205 6))
                    (set! tmp.204 g43081376.26)
                    (begin
                      (set! g43081377.27 25150)
                      (if (begin
                            (set! tmp.206
                              (call L.error?.135.16 error?.135 g43081377.27))
                            (!= tmp.206 6))
                        (set! tmp.204 g43081377.27)
                        (begin
                          (set! g43081378.28 4414)
                          (if (begin
                                (set! tmp.207
                                  (call
                                   L.error?.135.16
                                   error?.135
                                   g43081378.28))
                                (!= tmp.207 6))
                            (set! tmp.204 g43081378.28)
                            (set! tmp.204 5694)))))))
                (begin
                  (begin
                    (begin
                      (set! tmp.7.30
                        (call L.make-vector.136.15 make-vector.136 64))
                      (begin
                        (set! g43081380.31
                          (call
                           L.vector-set!.137.12
                           vector-set!.137
                           tmp.7.30
                           0
                           0))
                        (if (begin
                              (set! tmp.209
                                (call L.error?.135.16 error?.135 g43081380.31))
                              (!= tmp.209 6))
                          (set! g43081379.29 g43081380.31)
                          (begin
                            (set! g43081381.32
                              (call
                               L.vector-set!.137.12
                               vector-set!.137
                               tmp.7.30
                               8
                               8))
                            (if (begin
                                  (set! tmp.210
                                    (call
                                     L.error?.135.16
                                     error?.135
                                     g43081381.32))
                                  (!= tmp.210 6))
                              (set! g43081379.29 g43081381.32)
                              (begin
                                (set! g43081382.33
                                  (call
                                   L.vector-set!.137.12
                                   vector-set!.137
                                   tmp.7.30
                                   16
                                   16))
                                (if (begin
                                      (set! tmp.211
                                        (call
                                         L.error?.135.16
                                         error?.135
                                         g43081382.33))
                                      (!= tmp.211 6))
                                  (set! g43081379.29 g43081382.33)
                                  (begin
                                    (set! g43081383.34
                                      (call
                                       L.vector-set!.137.12
                                       vector-set!.137
                                       tmp.7.30
                                       24
                                       24))
                                    (if (begin
                                          (set! tmp.212
                                            (call
                                             L.error?.135.16
                                             error?.135
                                             g43081383.34))
                                          (!= tmp.212 6))
                                      (set! g43081379.29 g43081383.34)
                                      (begin
                                        (set! g43081384.35
                                          (call
                                           L.vector-set!.137.12
                                           vector-set!.137
                                           tmp.7.30
                                           32
                                           32))
                                        (if (begin
                                              (set! tmp.213
                                                (call
                                                 L.error?.135.16
                                                 error?.135
                                                 g43081384.35))
                                              (!= tmp.213 6))
                                          (set! g43081379.29 g43081384.35)
                                          (begin
                                            (set! g43081385.36
                                              (call
                                               L.vector-set!.137.12
                                               vector-set!.137
                                               tmp.7.30
                                               40
                                               40))
                                            (if (begin
                                                  (set! tmp.214
                                                    (call
                                                     L.error?.135.16
                                                     error?.135
                                                     g43081385.36))
                                                  (!= tmp.214 6))
                                              (set! g43081379.29 g43081385.36)
                                              (begin
                                                (set! g43081386.37
                                                  (call
                                                   L.vector-set!.137.12
                                                   vector-set!.137
                                                   tmp.7.30
                                                   48
                                                   48))
                                                (if (begin
                                                      (set! tmp.215
                                                        (call
                                                         L.error?.135.16
                                                         error?.135
                                                         g43081386.37))
                                                      (!= tmp.215 6))
                                                  (set! g43081379.29
                                                    g43081386.37)
                                                  (begin
                                                    (set! g43081387.38
                                                      (call
                                                       L.vector-set!.137.12
                                                       vector-set!.137
                                                       tmp.7.30
                                                       56
                                                       56))
                                                    (if (begin
                                                          (set! tmp.216
                                                            (call
                                                             L.error?.135.16
                                                             error?.135
                                                             g43081387.38))
                                                          (!= tmp.216 6))
                                                      (set! g43081379.29
                                                        g43081387.38)
                                                      (set! g43081379.29
                                                        tmp.7.30))))))))))))))))))
                    (if (begin
                          (set! tmp.217
                            (call L.error?.135.16 error?.135 g43081379.29))
                          (!= tmp.217 6))
                      (set! tmp.208 g43081379.29)
                      (begin
                        (begin
                          (set! tmp.8.40
                            (call L.make-vector.136.15 make-vector.136 64))
                          (begin
                            (set! g43081389.41
                              (call
                               L.vector-set!.137.12
                               vector-set!.137
                               tmp.8.40
                               0
                               8))
                            (if (begin
                                  (set! tmp.218
                                    (call
                                     L.error?.135.16
                                     error?.135
                                     g43081389.41))
                                  (!= tmp.218 6))
                              (set! g43081388.39 g43081389.41)
                              (begin
                                (set! g43081390.42
                                  (call
                                   L.vector-set!.137.12
                                   vector-set!.137
                                   tmp.8.40
                                   8
                                   16))
                                (if (begin
                                      (set! tmp.219
                                        (call
                                         L.error?.135.16
                                         error?.135
                                         g43081390.42))
                                      (!= tmp.219 6))
                                  (set! g43081388.39 g43081390.42)
                                  (begin
                                    (set! g43081391.43
                                      (call
                                       L.vector-set!.137.12
                                       vector-set!.137
                                       tmp.8.40
                                       16
                                       24))
                                    (if (begin
                                          (set! tmp.220
                                            (call
                                             L.error?.135.16
                                             error?.135
                                             g43081391.43))
                                          (!= tmp.220 6))
                                      (set! g43081388.39 g43081391.43)
                                      (begin
                                        (set! g43081392.44
                                          (call
                                           L.vector-set!.137.12
                                           vector-set!.137
                                           tmp.8.40
                                           24
                                           32))
                                        (if (begin
                                              (set! tmp.221
                                                (call
                                                 L.error?.135.16
                                                 error?.135
                                                 g43081392.44))
                                              (!= tmp.221 6))
                                          (set! g43081388.39 g43081392.44)
                                          (begin
                                            (set! g43081393.45
                                              (call
                                               L.vector-set!.137.12
                                               vector-set!.137
                                               tmp.8.40
                                               32
                                               40))
                                            (if (begin
                                                  (set! tmp.222
                                                    (call
                                                     L.error?.135.16
                                                     error?.135
                                                     g43081393.45))
                                                  (!= tmp.222 6))
                                              (set! g43081388.39 g43081393.45)
                                              (begin
                                                (set! g43081394.46
                                                  (call
                                                   L.vector-set!.137.12
                                                   vector-set!.137
                                                   tmp.8.40
                                                   40
                                                   48))
                                                (if (begin
                                                      (set! tmp.223
                                                        (call
                                                         L.error?.135.16
                                                         error?.135
                                                         g43081394.46))
                                                      (!= tmp.223 6))
                                                  (set! g43081388.39
                                                    g43081394.46)
                                                  (begin
                                                    (set! g43081395.47
                                                      (call
                                                       L.vector-set!.137.12
                                                       vector-set!.137
                                                       tmp.8.40
                                                       48
                                                       56))
                                                    (if (begin
                                                          (set! tmp.224
                                                            (call
                                                             L.error?.135.16
                                                             error?.135
                                                             g43081395.47))
                                                          (!= tmp.224 6))
                                                      (set! g43081388.39
                                                        g43081395.47)
                                                      (begin
                                                        (set! g43081396.48
                                                          (call
                                                           L.vector-set!.137.12
                                                           vector-set!.137
                                                           tmp.8.40
                                                           56
                                                           64))
                                                        (if (begin
                                                              (set! tmp.225
                                                                (call
                                                                 L.error?.135.16
                                                                 error?.135
                                                                 g43081396.48))
                                                              (!= tmp.225 6))
                                                          (set! g43081388.39
                                                            g43081396.48)
                                                          (set! g43081388.39
                                                            tmp.8.40))))))))))))))))))
                        (if (begin
                              (set! tmp.226
                                (call L.error?.135.16 error?.135 g43081388.39))
                              (!= tmp.226 6))
                          (set! tmp.208 g43081388.39)
                          (begin
                            (set! tmp.9.49
                              (call L.make-vector.136.15 make-vector.136 64))
                            (begin
                              (set! g43081397.50
                                (call
                                 L.vector-set!.137.12
                                 vector-set!.137
                                 tmp.9.49
                                 0
                                 8))
                              (if (begin
                                    (set! tmp.227
                                      (call
                                       L.error?.135.16
                                       error?.135
                                       g43081397.50))
                                    (!= tmp.227 6))
                                (set! tmp.208 g43081397.50)
                                (begin
                                  (set! g43081398.51
                                    (call
                                     L.vector-set!.137.12
                                     vector-set!.137
                                     tmp.9.49
                                     8
                                     16))
                                  (if (begin
                                        (set! tmp.228
                                          (call
                                           L.error?.135.16
                                           error?.135
                                           g43081398.51))
                                        (!= tmp.228 6))
                                    (set! tmp.208 g43081398.51)
                                    (begin
                                      (set! g43081399.52
                                        (call
                                         L.vector-set!.137.12
                                         vector-set!.137
                                         tmp.9.49
                                         16
                                         24))
                                      (if (begin
                                            (set! tmp.229
                                              (call
                                               L.error?.135.16
                                               error?.135
                                               g43081399.52))
                                            (!= tmp.229 6))
                                        (set! tmp.208 g43081399.52)
                                        (begin
                                          (set! g43081400.53
                                            (call
                                             L.vector-set!.137.12
                                             vector-set!.137
                                             tmp.9.49
                                             24
                                             32))
                                          (if (begin
                                                (set! tmp.230
                                                  (call
                                                   L.error?.135.16
                                                   error?.135
                                                   g43081400.53))
                                                (!= tmp.230 6))
                                            (set! tmp.208 g43081400.53)
                                            (begin
                                              (set! g43081401.54
                                                (call
                                                 L.vector-set!.137.12
                                                 vector-set!.137
                                                 tmp.9.49
                                                 32
                                                 40))
                                              (if (begin
                                                    (set! tmp.231
                                                      (call
                                                       L.error?.135.16
                                                       error?.135
                                                       g43081401.54))
                                                    (!= tmp.231 6))
                                                (set! tmp.208 g43081401.54)
                                                (begin
                                                  (set! g43081402.55
                                                    (call
                                                     L.vector-set!.137.12
                                                     vector-set!.137
                                                     tmp.9.49
                                                     40
                                                     48))
                                                  (if (begin
                                                        (set! tmp.232
                                                          (call
                                                           L.error?.135.16
                                                           error?.135
                                                           g43081402.55))
                                                        (!= tmp.232 6))
                                                    (set! tmp.208 g43081402.55)
                                                    (begin
                                                      (set! g43081403.56
                                                        (call
                                                         L.vector-set!.137.12
                                                         vector-set!.137
                                                         tmp.9.49
                                                         48
                                                         56))
                                                      (if (begin
                                                            (set! tmp.233
                                                              (call
                                                               L.error?.135.16
                                                               error?.135
                                                               g43081403.56))
                                                            (!= tmp.233 6))
                                                        (set! tmp.208
                                                          g43081403.56)
                                                        (begin
                                                          (set! g43081404.57
                                                            (call
                                                             L.vector-set!.137.12
                                                             vector-set!.137
                                                             tmp.9.49
                                                             56
                                                             64))
                                                          (if (begin
                                                                (set! tmp.234
                                                                  (call
                                                                   L.error?.135.16
                                                                   error?.135
                                                                   g43081404.57))
                                                                (!= tmp.234 6))
                                                            (set! tmp.208
                                                              g43081404.57)
                                                            (set! tmp.208
                                                              tmp.9.49))))))))))))))))))))))
                  (set! tmp.203
                    (call
                     L.fun/boolean8837.16.20
                     fun/boolean8837.16
                     tmp.204
                     tmp.208))))
              (!= tmp.203 6))
          (if (if (!= 14 6) (!= 17454 6) (!= 21038 6))
            (if (begin
                  (set! g43081405.58 22574)
                  (if (begin
                        (set! tmp.235
                          (call L.error?.135.16 error?.135 g43081405.58))
                        (!= tmp.235 6))
                    (!= g43081405.58 6)
                    (begin
                      (set! g43081406.59 25134)
                      (if (begin
                            (set! tmp.236
                              (call L.error?.135.16 error?.135 g43081406.59))
                            (!= tmp.236 6))
                        (!= g43081406.59 6)
                        (begin
                          (set! g43081407.60 16942)
                          (if (begin
                                (set! tmp.237
                                  (call
                                   L.error?.135.16
                                   error?.135
                                   g43081407.60))
                                (!= tmp.237 6))
                            (!= g43081407.60 6)
                            (begin
                              (set! g43081408.61 28462)
                              (if (begin
                                    (set! tmp.238
                                      (call
                                       L.error?.135.16
                                       error?.135
                                       g43081408.61))
                                    (!= tmp.238 6))
                                (!= g43081408.61 6)
                                (!= 29742 6)))))))))
              (if (begin
                    (begin
                      (set! tmp.240
                        (call L.make-vector.136.15 make-vector.136 64))
                      (set! tmp.239
                        (call
                         L.fun/ascii-char8839.14.18
                         fun/ascii-char8839.14
                         22
                         tmp.240)))
                    (!= tmp.239 6))
                (if (if (!= 6 6) (!= 16942 6) (!= 21038 6))
                  (if (begin
                        (set! tmp.241
                          (call
                           L.fun/ascii-char8840.13.17
                           fun/ascii-char8840.13
                           30
                           6))
                        (!= tmp.241 6))
                    (begin
                      (begin
                        (set! tmp.242 (call L.cons.138.10 cons.138 3512 22))
                        (set! pair0.63
                          (call L.cons.138.10 cons.138 480 tmp.242)))
                      (set! empty1.62 22)
                      17966)
                    6)
                  6)
                6)
              6)
            6)
          (begin
            (if (!= 20014 6)
              (if (!= 22062 6)
                (if (!= 31022 6)
                  (set! g43081409.64 25646)
                  (set! g43081409.64 6))
                (set! g43081409.64 6))
              (set! g43081409.64 6))
            (if (begin
                  (set! tmp.243 (call L.error?.135.16 error?.135 g43081409.64))
                  (!= tmp.243 6))
              g43081409.64
              (begin
                (if (!= 6 6)
                  (set! g43081410.65 19758)
                  (set! g43081410.65 21550))
                (if (begin
                      (set! tmp.244
                        (call L.error?.135.16 error?.135 g43081410.65))
                      (!= tmp.244 6))
                  g43081410.65
                  (begin
                    (begin
                      (set! g43081412.67 29486)
                      (if (begin
                            (set! tmp.245
                              (call L.error?.135.16 error?.135 g43081412.67))
                            (!= tmp.245 6))
                        (set! g43081411.66 g43081412.67)
                        (begin
                          (set! g43081413.68 29742)
                          (if (begin
                                (set! tmp.246
                                  (call
                                   L.error?.135.16
                                   error?.135
                                   g43081413.68))
                                (!= tmp.246 6))
                            (set! g43081411.66 g43081413.68)
                            (begin
                              (set! g43081414.69 29230)
                              (if (begin
                                    (set! tmp.247
                                      (call
                                       L.error?.135.16
                                       error?.135
                                       g43081414.69))
                                    (!= tmp.247 6))
                                (set! g43081411.66 g43081414.69)
                                (set! g43081411.66 22318)))))))
                    (if (begin
                          (set! tmp.248
                            (call L.error?.135.16 error?.135 g43081411.66))
                          (!= tmp.248 6))
                      g43081411.66
                      (begin
                        (begin
                          (begin
                            (begin
                              (begin
                                (set! tmp.249 (alloc 16))
                                (set! tmp.167 (+ tmp.249 2)))
                              (begin
                                (mset! tmp.167 -2 L.lam.139.22)
                                (mset! tmp.167 6 0)
                                (set! lam.139 tmp.167)))
                            (set! procedure0.73 lam.139))
                          (set! empty1.72 22)
                          (set! error2.71 13374)
                          (set! g43081415.70 21550))
                        (if (begin
                              (set! tmp.250
                                (call L.error?.135.16 error?.135 g43081415.70))
                              (!= tmp.250 6))
                          g43081415.70
                          (begin
                            (begin
                              (set! tmp.10.75 25646)
                              (if (!= tmp.10.75 6)
                                (set! g43081416.74 tmp.10.75)
                                (begin
                                  (set! tmp.11.76 30510)
                                  (if (!= tmp.11.76 6)
                                    (set! g43081416.74 tmp.11.76)
                                    (begin
                                      (set! tmp.12.77 27694)
                                      (if (!= tmp.12.77 6)
                                        (set! g43081416.74 tmp.12.77)
                                        (set! g43081416.74 22318)))))))
                            (if (begin
                                  (set! tmp.251
                                    (call
                                     L.error?.135.16
                                     error?.135
                                     g43081416.74))
                                  (!= tmp.251 6))
                              g43081416.74
                              (begin
                                (begin
                                  (set! g43081418.79 19502)
                                  (if (begin
                                        (set! tmp.252
                                          (call
                                           L.error?.135.16
                                           error?.135
                                           g43081418.79))
                                        (!= tmp.252 6))
                                    (set! g43081417.78 g43081418.79)
                                    (begin
                                      (set! g43081419.80 19246)
                                      (if (begin
                                            (set! tmp.253
                                              (call
                                               L.error?.135.16
                                               error?.135
                                               g43081419.80))
                                            (!= tmp.253 6))
                                        (set! g43081417.78 g43081419.80)
                                        (begin
                                          (set! g43081420.81 21294)
                                          (if (begin
                                                (set! tmp.254
                                                  (call
                                                   L.error?.135.16
                                                   error?.135
                                                   g43081420.81))
                                                (!= tmp.254 6))
                                            (set! g43081417.78 g43081420.81)
                                            (begin
                                              (set! g43081421.82 22318)
                                              (if (begin
                                                    (set! tmp.255
                                                      (call
                                                       L.error?.135.16
                                                       error?.135
                                                       g43081421.82))
                                                    (!= tmp.255 6))
                                                (set! g43081417.78
                                                  g43081421.82)
                                                (set! g43081417.78
                                                  22318)))))))))
                                (if (begin
                                      (set! tmp.256
                                        (call
                                         L.error?.135.16
                                         error?.135
                                         g43081417.78))
                                      (!= tmp.256 6))
                                  g43081417.78
                                  (call
                                   L.fun/ascii-char8841.15.19
                                   fun/ascii-char8841.15
                                   22
                                   944))))))))))))))))))
(check-by-interp
 '(module
    (begin
      (begin
        (set! ascii-char0.9 21806)
        (set! error1.8 51006)
        (set! boolean0.7 6))
      (begin (set! boolean0.10 6) 19246))))
(check-by-interp
 '(module
    (define L.lam.129.30
      (lambda (c.150 oprand0.68)
        (begin (begin (set! tmp.15.69 6) (if (!= tmp.15.69 6) tmp.15.69 14)))))
    (define L.lam.128.29 (lambda (c.149) (begin 6456)))
    (define L.lam.127.28 (lambda (c.148) (begin 5848)))
    (define L.fun/error8855.25.27 (lambda (c.147) (begin 16190)))
    (define L.fun/error8854.24.26
      (lambda (c.146) (begin (if (!= 6 6) 21054 36926))))
    (define L.fun/error8853.23.25 (lambda (c.145) (begin 13118)))
    (define L.fun/error8848.22.24 (lambda (c.144) (begin 51262)))
    (define L.fun/error8852.21.23
      (lambda (c.143)
        (begin
          (set! fun/error8853.23 (mref c.143 14))
          (call L.fun/error8853.23.25 fun/error8853.23))))
    (define L.fun/fixnum8850.20.22 (lambda (c.142 oprand0.30) (begin 248)))
    (define L.fun/fixnum8851.19.21 (lambda (c.141 oprand0.29) (begin 1888)))
    (define L.fun/pair8849.18.20
      (lambda (c.140 oprand0.28)
        (begin
          (set! cons.122 (mref c.140 14))
          (begin
            (set! tmp.174 (call L.cons.122.17 cons.122 3368 22))
            (call L.cons.122.17 cons.122 1600 tmp.174)))))
    (define L.fun/error8846.17.19
      (lambda (c.139 oprand0.27 oprand1.26)
        (begin
          (set! fun/error8847.16 (mref c.139 14))
          (call L.fun/error8847.16.18 fun/error8847.16))))
    (define L.fun/error8847.16.18
      (lambda (c.138)
        (begin
          (set! fun/error8848.22 (mref c.138 14))
          (call L.fun/error8848.22.24 fun/error8848.22))))
    (define L.cons.122.17
      (lambda (c.137 tmp.117 tmp.118)
        (begin
          (begin
            (begin (set! tmp.175 (alloc 16)) (set! tmp.151 (+ tmp.175 1)))
            (begin
              (mset! tmp.151 -1 tmp.117)
              (mset! tmp.151 7 tmp.118)
              tmp.151)))))
    (define L.error?.123.16
      (lambda (c.136 tmp.112)
        (begin
          (if (begin (set! tmp.176 (bitwise-and tmp.112 255)) (= tmp.176 62))
            14
            6))))
    (define L.*.124.15
      (lambda (c.135 tmp.84 tmp.85)
        (begin
          (if (begin
                (if (begin (set! tmp.178 (bitwise-and tmp.85 7)) (= tmp.178 0))
                  (set! tmp.177 14)
                  (set! tmp.177 6))
                (!= tmp.177 6))
            (if (begin
                  (if (begin
                        (set! tmp.180 (bitwise-and tmp.84 7))
                        (= tmp.180 0))
                    (set! tmp.179 14)
                    (set! tmp.179 6))
                  (!= tmp.179 6))
              (begin
                (set! tmp.181 (arithmetic-shift-right tmp.85 3))
                (* tmp.84 tmp.181))
              318)
            318))))
    (define L.make-vector.125.14
      (lambda (c.134 tmp.98)
        (begin
          (set! make-init-vector.4 (mref c.134 14))
          (if (begin
                (if (begin (set! tmp.183 (bitwise-and tmp.98 7)) (= tmp.183 0))
                  (set! tmp.182 14)
                  (set! tmp.182 6))
                (!= tmp.182 6))
            (call L.make-init-vector.4.13 make-init-vector.4 tmp.98)
            2110))))
    (define L.make-init-vector.4.13
      (lambda (c.133 tmp.70)
        (begin
          (set! vector-init-loop.72 (mref c.133 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.187 (arithmetic-shift-right tmp.70 3))
                      (set! tmp.186 (+ 1 tmp.187)))
                    (set! tmp.185 (* tmp.186 8)))
                  (set! tmp.184 (alloc tmp.185)))
                (set! tmp.152 (+ tmp.184 3)))
              (begin (mset! tmp.152 -3 tmp.70) (set! tmp.71 tmp.152)))
            (call
             L.vector-init-loop.72.12
             vector-init-loop.72
             tmp.70
             0
             tmp.71)))))
    (define L.vector-init-loop.72.12
      (lambda (c.132 len.73 i.75 vec.74)
        (begin
          (set! vector-init-loop.72 (mref c.132 14))
          (if (begin
                (if (= len.73 i.75) (set! tmp.188 14) (set! tmp.188 6))
                (!= tmp.188 6))
            vec.74
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.191 (arithmetic-shift-right i.75 3))
                    (set! tmp.190 (* tmp.191 8)))
                  (set! tmp.189 (+ tmp.190 5)))
                (mset! vec.74 tmp.189 0))
              (begin
                (set! tmp.192 (+ i.75 8))
                (call
                 L.vector-init-loop.72.12
                 vector-init-loop.72
                 len.73
                 tmp.192
                 vec.74)))))))
    (define L.vector-set!.126.11
      (lambda (c.131 tmp.100 tmp.101 tmp.102)
        (begin
          (set! unsafe-vector-set!.5 (mref c.131 14))
          (if (begin
                (if (begin
                      (set! tmp.194 (bitwise-and tmp.101 7))
                      (= tmp.194 0))
                  (set! tmp.193 14)
                  (set! tmp.193 6))
                (!= tmp.193 6))
            (if (begin
                  (if (begin
                        (set! tmp.196 (bitwise-and tmp.100 7))
                        (= tmp.196 3))
                    (set! tmp.195 14)
                    (set! tmp.195 6))
                  (!= tmp.195 6))
              (call
               L.unsafe-vector-set!.5.10
               unsafe-vector-set!.5
               tmp.100
               tmp.101
               tmp.102)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.10
      (lambda (c.130 tmp.76 tmp.77 tmp.78)
        (begin
          (if (begin
                (if (begin (set! tmp.198 (mref tmp.76 -3)) (< tmp.77 tmp.198))
                  (set! tmp.197 14)
                  (set! tmp.197 6))
                (!= tmp.197 6))
            (if (begin
                  (if (>= tmp.77 0) (set! tmp.199 14) (set! tmp.199 6))
                  (!= tmp.199 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.202 (arithmetic-shift-right tmp.77 3))
                      (set! tmp.201 (* tmp.202 8)))
                    (set! tmp.200 (+ tmp.201 5)))
                  (mset! tmp.76 tmp.200 tmp.78))
                30)
              2622)
            2622))))
    (begin
      (begin
        (begin (set! tmp.203 (alloc 16)) (set! tmp.153 (+ tmp.203 2)))
        (begin
          (mset! tmp.153 -2 L.unsafe-vector-set!.5.10)
          (mset! tmp.153 6 24)
          (set! unsafe-vector-set!.5 tmp.153)))
      (begin
        (begin (set! tmp.204 (alloc 24)) (set! tmp.154 (+ tmp.204 2)))
        (begin
          (mset! tmp.154 -2 L.vector-set!.126.11)
          (mset! tmp.154 6 24)
          (set! vector-set!.126 tmp.154)))
      (begin
        (begin (set! tmp.205 (alloc 24)) (set! tmp.155 (+ tmp.205 2)))
        (begin
          (mset! tmp.155 -2 L.vector-init-loop.72.12)
          (mset! tmp.155 6 24)
          (set! vector-init-loop.72 tmp.155)))
      (begin
        (begin (set! tmp.206 (alloc 24)) (set! tmp.156 (+ tmp.206 2)))
        (begin
          (mset! tmp.156 -2 L.make-init-vector.4.13)
          (mset! tmp.156 6 8)
          (set! make-init-vector.4 tmp.156)))
      (begin
        (begin (set! tmp.207 (alloc 24)) (set! tmp.157 (+ tmp.207 2)))
        (begin
          (mset! tmp.157 -2 L.make-vector.125.14)
          (mset! tmp.157 6 8)
          (set! make-vector.125 tmp.157)))
      (begin
        (begin (set! tmp.208 (alloc 16)) (set! tmp.158 (+ tmp.208 2)))
        (begin
          (mset! tmp.158 -2 L.*.124.15)
          (mset! tmp.158 6 16)
          (set! *.124 tmp.158)))
      (begin
        (begin (set! tmp.209 (alloc 16)) (set! tmp.159 (+ tmp.209 2)))
        (begin
          (mset! tmp.159 -2 L.error?.123.16)
          (mset! tmp.159 6 8)
          (set! error?.123 tmp.159)))
      (begin
        (begin (set! tmp.210 (alloc 16)) (set! tmp.160 (+ tmp.210 2)))
        (begin
          (mset! tmp.160 -2 L.cons.122.17)
          (mset! tmp.160 6 16)
          (set! cons.122 tmp.160)))
      (begin
        (begin (set! tmp.211 (alloc 24)) (set! tmp.161 (+ tmp.211 2)))
        (begin
          (mset! tmp.161 -2 L.fun/error8847.16.18)
          (mset! tmp.161 6 0)
          (set! fun/error8847.16 tmp.161)))
      (begin
        (begin (set! tmp.212 (alloc 24)) (set! tmp.162 (+ tmp.212 2)))
        (begin
          (mset! tmp.162 -2 L.fun/error8846.17.19)
          (mset! tmp.162 6 16)
          (set! fun/error8846.17 tmp.162)))
      (begin
        (begin (set! tmp.213 (alloc 24)) (set! tmp.163 (+ tmp.213 2)))
        (begin
          (mset! tmp.163 -2 L.fun/pair8849.18.20)
          (mset! tmp.163 6 8)
          (set! fun/pair8849.18 tmp.163)))
      (begin
        (begin (set! tmp.214 (alloc 16)) (set! tmp.164 (+ tmp.214 2)))
        (begin
          (mset! tmp.164 -2 L.fun/fixnum8851.19.21)
          (mset! tmp.164 6 8)
          (set! fun/fixnum8851.19 tmp.164)))
      (begin
        (begin (set! tmp.215 (alloc 16)) (set! tmp.165 (+ tmp.215 2)))
        (begin
          (mset! tmp.165 -2 L.fun/fixnum8850.20.22)
          (mset! tmp.165 6 8)
          (set! fun/fixnum8850.20 tmp.165)))
      (begin
        (begin (set! tmp.216 (alloc 24)) (set! tmp.166 (+ tmp.216 2)))
        (begin
          (mset! tmp.166 -2 L.fun/error8852.21.23)
          (mset! tmp.166 6 0)
          (set! fun/error8852.21 tmp.166)))
      (begin
        (begin (set! tmp.217 (alloc 16)) (set! tmp.167 (+ tmp.217 2)))
        (begin
          (mset! tmp.167 -2 L.fun/error8848.22.24)
          (mset! tmp.167 6 0)
          (set! fun/error8848.22 tmp.167)))
      (begin
        (begin (set! tmp.218 (alloc 16)) (set! tmp.168 (+ tmp.218 2)))
        (begin
          (mset! tmp.168 -2 L.fun/error8853.23.25)
          (mset! tmp.168 6 0)
          (set! fun/error8853.23 tmp.168)))
      (begin
        (begin (set! tmp.219 (alloc 16)) (set! tmp.169 (+ tmp.219 2)))
        (begin
          (mset! tmp.169 -2 L.fun/error8854.24.26)
          (mset! tmp.169 6 0)
          (set! fun/error8854.24 tmp.169)))
      (begin
        (begin (set! tmp.220 (alloc 16)) (set! tmp.170 (+ tmp.220 2)))
        (begin
          (mset! tmp.170 -2 L.fun/error8855.25.27)
          (mset! tmp.170 6 0)
          (set! fun/error8855.25 tmp.170)))
      (begin
        (mset! vector-set!.126 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.72 14 vector-init-loop.72)
        (mset! make-init-vector.4 14 vector-init-loop.72)
        (mset! make-vector.125 14 make-init-vector.4)
        (mset! fun/error8847.16 14 fun/error8848.22)
        (mset! fun/error8846.17 14 fun/error8847.16)
        (mset! fun/pair8849.18 14 cons.122)
        (mset! fun/error8852.21 14 fun/error8853.23)
        (begin
          (begin
            (begin
              (begin
                (begin
                  (set! tmp.222 (call L.cons.122.17 cons.122 3408 22))
                  (set! g43089054.33
                    (call L.cons.122.17 cons.122 928 tmp.222)))
                (if (begin
                      (set! tmp.223
                        (call L.error?.123.16 error?.123 g43089054.33))
                      (!= tmp.223 6))
                  (set! g43089053.32 g43089054.33)
                  (begin
                    (set! tmp.224 (call L.cons.122.17 cons.122 3456 22))
                    (set! g43089053.32
                      (call L.cons.122.17 cons.122 1992 tmp.224)))))
              (if (begin
                    (set! tmp.225
                      (call L.error?.123.16 error?.123 g43089053.32))
                    (!= tmp.225 6))
                (set! tmp.221 g43089053.32)
                (set! tmp.221 (call L.fun/pair8849.18.20 fun/pair8849.18 6))))
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.229 (call L.cons.122.17 cons.122 2312 22))
                    (set! tmp.228 (call L.cons.122.17 cons.122 848 tmp.229)))
                  (set! tmp.227
                    (call L.fun/fixnum8850.20.22 fun/fixnum8850.20 tmp.228)))
                (begin
                  (set! tmp.230
                    (call L.fun/fixnum8851.19.21 fun/fixnum8851.19 30))
                  (set! tmp.226 (call L.*.124.15 *.124 tmp.227 tmp.230))))
              (set! tmp.7.31
                (call
                 L.fun/error8846.17.19
                 fun/error8846.17
                 tmp.221
                 tmp.226))))
          (if (!= tmp.7.31 6)
            tmp.7.31
            (begin
              (begin
                (if (!= 6 6) (set! tmp.9.35 7230) (set! tmp.9.35 17214))
                (if (!= tmp.9.35 6)
                  (set! tmp.8.34 tmp.9.35)
                  (begin
                    (set! tmp.10.36
                      (call L.fun/error8852.21.23 fun/error8852.21))
                    (if (!= tmp.10.36 6)
                      (set! tmp.8.34 tmp.10.36)
                      (if (begin
                            (set! boolean0.39 6)
                            (begin
                              (set! tmp.11.40
                                (call L.make-vector.125.14 make-vector.125 64))
                              (begin
                                (set! g43089055.41
                                  (call
                                   L.vector-set!.126.11
                                   vector-set!.126
                                   tmp.11.40
                                   0
                                   0))
                                (if (begin
                                      (set! tmp.231
                                        (call
                                         L.error?.123.16
                                         error?.123
                                         g43089055.41))
                                      (!= tmp.231 6))
                                  (set! vector1.38 g43089055.41)
                                  (begin
                                    (set! g43089056.42
                                      (call
                                       L.vector-set!.126.11
                                       vector-set!.126
                                       tmp.11.40
                                       8
                                       8))
                                    (if (begin
                                          (set! tmp.232
                                            (call
                                             L.error?.123.16
                                             error?.123
                                             g43089056.42))
                                          (!= tmp.232 6))
                                      (set! vector1.38 g43089056.42)
                                      (begin
                                        (set! g43089057.43
                                          (call
                                           L.vector-set!.126.11
                                           vector-set!.126
                                           tmp.11.40
                                           16
                                           16))
                                        (if (begin
                                              (set! tmp.233
                                                (call
                                                 L.error?.123.16
                                                 error?.123
                                                 g43089057.43))
                                              (!= tmp.233 6))
                                          (set! vector1.38 g43089057.43)
                                          (begin
                                            (set! g43089058.44
                                              (call
                                               L.vector-set!.126.11
                                               vector-set!.126
                                               tmp.11.40
                                               24
                                               24))
                                            (if (begin
                                                  (set! tmp.234
                                                    (call
                                                     L.error?.123.16
                                                     error?.123
                                                     g43089058.44))
                                                  (!= tmp.234 6))
                                              (set! vector1.38 g43089058.44)
                                              (begin
                                                (set! g43089059.45
                                                  (call
                                                   L.vector-set!.126.11
                                                   vector-set!.126
                                                   tmp.11.40
                                                   32
                                                   32))
                                                (if (begin
                                                      (set! tmp.235
                                                        (call
                                                         L.error?.123.16
                                                         error?.123
                                                         g43089059.45))
                                                      (!= tmp.235 6))
                                                  (set! vector1.38
                                                    g43089059.45)
                                                  (begin
                                                    (set! g43089060.46
                                                      (call
                                                       L.vector-set!.126.11
                                                       vector-set!.126
                                                       tmp.11.40
                                                       40
                                                       40))
                                                    (if (begin
                                                          (set! tmp.236
                                                            (call
                                                             L.error?.123.16
                                                             error?.123
                                                             g43089060.46))
                                                          (!= tmp.236 6))
                                                      (set! vector1.38
                                                        g43089060.46)
                                                      (begin
                                                        (set! g43089061.47
                                                          (call
                                                           L.vector-set!.126.11
                                                           vector-set!.126
                                                           tmp.11.40
                                                           48
                                                           48))
                                                        (if (begin
                                                              (set! tmp.237
                                                                (call
                                                                 L.error?.123.16
                                                                 error?.123
                                                                 g43089061.47))
                                                              (!= tmp.237 6))
                                                          (set! vector1.38
                                                            g43089061.47)
                                                          (begin
                                                            (set! g43089062.48
                                                              (call
                                                               L.vector-set!.126.11
                                                               vector-set!.126
                                                               tmp.11.40
                                                               56
                                                               56))
                                                            (if (begin
                                                                  (set! tmp.238
                                                                    (call
                                                                     L.error?.123.16
                                                                     error?.123
                                                                     g43089062.48))
                                                                  (!=
                                                                   tmp.238
                                                                   6))
                                                              (set! vector1.38
                                                                g43089062.48)
                                                              (set! vector1.38
                                                                tmp.11.40))))))))))))))))))
                            (begin
                              (set! tmp.239
                                (call L.cons.122.17 cons.122 2840 22))
                              (set! pair2.37
                                (call L.cons.122.17 cons.122 1784 tmp.239)))
                            (!= 47422 6))
                        (if (begin (set! ascii-char0.49 21038) (!= 30782 6))
                          (if (if (!= 6 6) (!= 21054 6) (!= 52030 6))
                            (if (if (!= 14 6) (!= 18494 6) (!= 4670 6))
                              (if (begin
                                    (set! fixnum0.52 1688)
                                    (set! ascii-char1.51 20270)
                                    (set! void2.50 30)
                                    (!= 51518 6))
                                (if (!= 14 6)
                                  (set! tmp.8.34 52286)
                                  (set! tmp.8.34 38206))
                                (set! tmp.8.34 6))
                              (set! tmp.8.34 6))
                            (set! tmp.8.34 6))
                          (set! tmp.8.34 6))
                        (set! tmp.8.34 6))))))
              (if (!= tmp.8.34 6)
                tmp.8.34
                (begin
                  (set! tmp.12.53
                    (call L.fun/error8854.24.26 fun/error8854.24))
                  (if (!= tmp.12.53 6)
                    tmp.12.53
                    (begin
                      (begin
                        (set! error0.57
                          (call L.fun/error8855.25.27 fun/error8855.25))
                        (begin
                          (set! tmp.14.58
                            (call L.make-vector.125.14 make-vector.125 64))
                          (begin
                            (set! g43089063.59
                              (call
                               L.vector-set!.126.11
                               vector-set!.126
                               tmp.14.58
                               0
                               20526))
                            (if (begin
                                  (set! tmp.240
                                    (call
                                     L.error?.123.16
                                     error?.123
                                     g43089063.59))
                                  (!= tmp.240 6))
                              (set! vector1.56 g43089063.59)
                              (begin
                                (set! g43089064.60
                                  (call
                                   L.vector-set!.126.11
                                   vector-set!.126
                                   tmp.14.58
                                   8
                                   14))
                                (if (begin
                                      (set! tmp.241
                                        (call
                                         L.error?.123.16
                                         error?.123
                                         g43089064.60))
                                      (!= tmp.241 6))
                                  (set! vector1.56 g43089064.60)
                                  (begin
                                    (set! g43089065.61
                                      (call
                                       L.vector-set!.126.11
                                       vector-set!.126
                                       tmp.14.58
                                       16
                                       14))
                                    (if (begin
                                          (set! tmp.242
                                            (call
                                             L.error?.123.16
                                             error?.123
                                             g43089065.61))
                                          (!= tmp.242 6))
                                      (set! vector1.56 g43089065.61)
                                      (begin
                                        (begin
                                          (begin
                                            (begin
                                              (begin
                                                (set! tmp.244 (alloc 16))
                                                (set! tmp.171 (+ tmp.244 2)))
                                              (begin
                                                (mset! tmp.171 -2 L.lam.127.28)
                                                (mset! tmp.171 6 0)
                                                (set! lam.127 tmp.171)))
                                            (set! tmp.243 lam.127))
                                          (set! g43089066.62
                                            (call
                                             L.vector-set!.126.11
                                             vector-set!.126
                                             tmp.14.58
                                             24
                                             tmp.243)))
                                        (if (begin
                                              (set! tmp.245
                                                (call
                                                 L.error?.123.16
                                                 error?.123
                                                 g43089066.62))
                                              (!= tmp.245 6))
                                          (set! vector1.56 g43089066.62)
                                          (begin
                                            (set! g43089067.63
                                              (call
                                               L.vector-set!.126.11
                                               vector-set!.126
                                               tmp.14.58
                                               32
                                               28222))
                                            (if (begin
                                                  (set! tmp.246
                                                    (call
                                                     L.error?.123.16
                                                     error?.123
                                                     g43089067.63))
                                                  (!= tmp.246 6))
                                              (set! vector1.56 g43089067.63)
                                              (begin
                                                (set! g43089068.64
                                                  (call
                                                   L.vector-set!.126.11
                                                   vector-set!.126
                                                   tmp.14.58
                                                   40
                                                   30782))
                                                (if (begin
                                                      (set! tmp.247
                                                        (call
                                                         L.error?.123.16
                                                         error?.123
                                                         g43089068.64))
                                                      (!= tmp.247 6))
                                                  (set! vector1.56
                                                    g43089068.64)
                                                  (begin
                                                    (set! g43089069.65
                                                      (call
                                                       L.vector-set!.126.11
                                                       vector-set!.126
                                                       tmp.14.58
                                                       48
                                                       63806))
                                                    (if (begin
                                                          (set! tmp.248
                                                            (call
                                                             L.error?.123.16
                                                             error?.123
                                                             g43089069.65))
                                                          (!= tmp.248 6))
                                                      (set! vector1.56
                                                        g43089069.65)
                                                      (begin
                                                        (begin
                                                          (begin
                                                            (begin
                                                              (begin
                                                                (set! tmp.250
                                                                  (alloc 16))
                                                                (set! tmp.172
                                                                  (+
                                                                   tmp.250
                                                                   2)))
                                                              (begin
                                                                (mset!
                                                                 tmp.172
                                                                 -2
                                                                 L.lam.128.29)
                                                                (mset!
                                                                 tmp.172
                                                                 6
                                                                 0)
                                                                (set! lam.128
                                                                  tmp.172)))
                                                            (set! tmp.249
                                                              lam.128))
                                                          (set! g43089070.66
                                                            (call
                                                             L.vector-set!.126.11
                                                             vector-set!.126
                                                             tmp.14.58
                                                             56
                                                             tmp.249)))
                                                        (if (begin
                                                              (set! tmp.251
                                                                (call
                                                                 L.error?.123.16
                                                                 error?.123
                                                                 g43089070.66))
                                                              (!= tmp.251 6))
                                                          (set! vector1.56
                                                            g43089070.66)
                                                          (set! vector1.56
                                                            tmp.14.58))))))))))))))))))
                        (begin (set! void2.55 30))
                        (begin (set! tmp.13.54 2878)))
                      (if (!= tmp.13.54 6)
                        tmp.13.54
                        (begin
                          (begin
                            (begin
                              (begin
                                (set! tmp.252 (alloc 16))
                                (set! tmp.173 (+ tmp.252 2)))
                              (begin
                                (mset! tmp.173 -2 L.lam.129.30)
                                (mset! tmp.173 6 8)
                                (set! lam.129 tmp.173)))
                            (set! procedure0.67 lam.129))
                          (begin 64574))))))))))))))
(check-by-interp
 '(module
    (define L.lam.116.27 (lambda (c.134) (begin 7808)))
    (define L.lam.115.26 (lambda (c.133) (begin 22062)))
    (define L.fun/empty8862.18.25 (lambda (c.132 oprand0.25) (begin 22)))
    (define L.fun/fixnum8860.17.24
      (lambda (c.131 oprand0.24 oprand1.23) (begin (begin 1520))))
    (define L.fun/fixnum8858.16.23
      (lambda (c.130) (begin (if (!= 6 6) 1784 912))))
    (define L.fun/error8865.15.22 (lambda (c.129 oprand0.22) (begin 53822)))
    (define L.fun/void8861.14.21
      (lambda (c.128 oprand0.21 oprand1.20)
        (begin
          (set! vector-set!.110 (mref c.128 14))
          (begin
            (set! tmp.155
              (call
               L.vector-set!.110.17
               vector-set!.110
               oprand1.20
               24
               oprand0.21))
            (call
             L.vector-set!.110.17
             vector-set!.110
             oprand1.20
             40
             tmp.155)))))
    (define L.fun/fixnum8864.13.20
      (lambda (c.127 oprand0.19) (begin (begin 1968))))
    (define L.fun/fixnum8863.12.19 (lambda (c.126) (begin 1512)))
    (define L.fun/fixnum8859.11.18 (lambda (c.125) (begin 1920)))
    (define L.vector-set!.110.17
      (lambda (c.124 tmp.88 tmp.89 tmp.90)
        (begin
          (set! unsafe-vector-set!.5 (mref c.124 14))
          (if (begin
                (if (begin (set! tmp.157 (bitwise-and tmp.89 7)) (= tmp.157 0))
                  (set! tmp.156 14)
                  (set! tmp.156 6))
                (!= tmp.156 6))
            (if (begin
                  (if (begin
                        (set! tmp.159 (bitwise-and tmp.88 7))
                        (= tmp.159 3))
                    (set! tmp.158 14)
                    (set! tmp.158 6))
                  (!= tmp.158 6))
              (call
               L.unsafe-vector-set!.5.16
               unsafe-vector-set!.5
               tmp.88
               tmp.89
               tmp.90)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.16
      (lambda (c.123 tmp.64 tmp.65 tmp.66)
        (begin
          (if (begin
                (if (begin (set! tmp.161 (mref tmp.64 -3)) (< tmp.65 tmp.161))
                  (set! tmp.160 14)
                  (set! tmp.160 6))
                (!= tmp.160 6))
            (if (begin
                  (if (>= tmp.65 0) (set! tmp.162 14) (set! tmp.162 6))
                  (!= tmp.162 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.165 (arithmetic-shift-right tmp.65 3))
                      (set! tmp.164 (* tmp.165 8)))
                    (set! tmp.163 (+ tmp.164 5)))
                  (mset! tmp.64 tmp.163 tmp.66))
                30)
              2622)
            2622))))
    (define L.error?.111.15
      (lambda (c.122 tmp.100)
        (begin
          (if (begin (set! tmp.166 (bitwise-and tmp.100 255)) (= tmp.166 62))
            14
            6))))
    (define L.cons.112.14
      (lambda (c.121 tmp.105 tmp.106)
        (begin
          (begin
            (begin (set! tmp.167 (alloc 16)) (set! tmp.135 (+ tmp.167 1)))
            (begin
              (mset! tmp.135 -1 tmp.105)
              (mset! tmp.135 7 tmp.106)
              tmp.135)))))
    (define L.make-vector.113.13
      (lambda (c.120 tmp.86)
        (begin
          (set! make-init-vector.4 (mref c.120 14))
          (if (begin
                (if (begin (set! tmp.169 (bitwise-and tmp.86 7)) (= tmp.169 0))
                  (set! tmp.168 14)
                  (set! tmp.168 6))
                (!= tmp.168 6))
            (call L.make-init-vector.4.12 make-init-vector.4 tmp.86)
            2110))))
    (define L.make-init-vector.4.12
      (lambda (c.119 tmp.58)
        (begin
          (set! vector-init-loop.60 (mref c.119 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.173 (arithmetic-shift-right tmp.58 3))
                      (set! tmp.172 (+ 1 tmp.173)))
                    (set! tmp.171 (* tmp.172 8)))
                  (set! tmp.170 (alloc tmp.171)))
                (set! tmp.136 (+ tmp.170 3)))
              (begin (mset! tmp.136 -3 tmp.58) (set! tmp.59 tmp.136)))
            (call
             L.vector-init-loop.60.11
             vector-init-loop.60
             tmp.58
             0
             tmp.59)))))
    (define L.vector-init-loop.60.11
      (lambda (c.118 len.61 i.63 vec.62)
        (begin
          (set! vector-init-loop.60 (mref c.118 14))
          (if (begin
                (if (= len.61 i.63) (set! tmp.174 14) (set! tmp.174 6))
                (!= tmp.174 6))
            vec.62
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.177 (arithmetic-shift-right i.63 3))
                    (set! tmp.176 (* tmp.177 8)))
                  (set! tmp.175 (+ tmp.176 5)))
                (mset! vec.62 tmp.175 0))
              (begin
                (set! tmp.178 (+ i.63 8))
                (call
                 L.vector-init-loop.60.11
                 vector-init-loop.60
                 len.61
                 tmp.178
                 vec.62)))))))
    (define L.-.114.10
      (lambda (c.117 tmp.76 tmp.77)
        (begin
          (if (begin
                (if (begin (set! tmp.180 (bitwise-and tmp.77 7)) (= tmp.180 0))
                  (set! tmp.179 14)
                  (set! tmp.179 6))
                (!= tmp.179 6))
            (if (begin
                  (if (begin
                        (set! tmp.182 (bitwise-and tmp.76 7))
                        (= tmp.182 0))
                    (set! tmp.181 14)
                    (set! tmp.181 6))
                  (!= tmp.181 6))
              (- tmp.76 tmp.77)
              830)
            830))))
    (begin
      (begin
        (begin (set! tmp.183 (alloc 16)) (set! tmp.137 (+ tmp.183 2)))
        (begin
          (mset! tmp.137 -2 L.-.114.10)
          (mset! tmp.137 6 16)
          (set! |-.114| tmp.137)))
      (begin
        (begin (set! tmp.184 (alloc 24)) (set! tmp.138 (+ tmp.184 2)))
        (begin
          (mset! tmp.138 -2 L.vector-init-loop.60.11)
          (mset! tmp.138 6 24)
          (set! vector-init-loop.60 tmp.138)))
      (begin
        (begin (set! tmp.185 (alloc 24)) (set! tmp.139 (+ tmp.185 2)))
        (begin
          (mset! tmp.139 -2 L.make-init-vector.4.12)
          (mset! tmp.139 6 8)
          (set! make-init-vector.4 tmp.139)))
      (begin
        (begin (set! tmp.186 (alloc 24)) (set! tmp.140 (+ tmp.186 2)))
        (begin
          (mset! tmp.140 -2 L.make-vector.113.13)
          (mset! tmp.140 6 8)
          (set! make-vector.113 tmp.140)))
      (begin
        (begin (set! tmp.187 (alloc 16)) (set! tmp.141 (+ tmp.187 2)))
        (begin
          (mset! tmp.141 -2 L.cons.112.14)
          (mset! tmp.141 6 16)
          (set! cons.112 tmp.141)))
      (begin
        (begin (set! tmp.188 (alloc 16)) (set! tmp.142 (+ tmp.188 2)))
        (begin
          (mset! tmp.142 -2 L.error?.111.15)
          (mset! tmp.142 6 8)
          (set! error?.111 tmp.142)))
      (begin
        (begin (set! tmp.189 (alloc 16)) (set! tmp.143 (+ tmp.189 2)))
        (begin
          (mset! tmp.143 -2 L.unsafe-vector-set!.5.16)
          (mset! tmp.143 6 24)
          (set! unsafe-vector-set!.5 tmp.143)))
      (begin
        (begin (set! tmp.190 (alloc 24)) (set! tmp.144 (+ tmp.190 2)))
        (begin
          (mset! tmp.144 -2 L.vector-set!.110.17)
          (mset! tmp.144 6 24)
          (set! vector-set!.110 tmp.144)))
      (begin
        (begin (set! tmp.191 (alloc 16)) (set! tmp.145 (+ tmp.191 2)))
        (begin
          (mset! tmp.145 -2 L.fun/fixnum8859.11.18)
          (mset! tmp.145 6 0)
          (set! fun/fixnum8859.11 tmp.145)))
      (begin
        (begin (set! tmp.192 (alloc 16)) (set! tmp.146 (+ tmp.192 2)))
        (begin
          (mset! tmp.146 -2 L.fun/fixnum8863.12.19)
          (mset! tmp.146 6 0)
          (set! fun/fixnum8863.12 tmp.146)))
      (begin
        (begin (set! tmp.193 (alloc 16)) (set! tmp.147 (+ tmp.193 2)))
        (begin
          (mset! tmp.147 -2 L.fun/fixnum8864.13.20)
          (mset! tmp.147 6 8)
          (set! fun/fixnum8864.13 tmp.147)))
      (begin
        (begin (set! tmp.194 (alloc 24)) (set! tmp.148 (+ tmp.194 2)))
        (begin
          (mset! tmp.148 -2 L.fun/void8861.14.21)
          (mset! tmp.148 6 16)
          (set! fun/void8861.14 tmp.148)))
      (begin
        (begin (set! tmp.195 (alloc 16)) (set! tmp.149 (+ tmp.195 2)))
        (begin
          (mset! tmp.149 -2 L.fun/error8865.15.22)
          (mset! tmp.149 6 8)
          (set! fun/error8865.15 tmp.149)))
      (begin
        (begin (set! tmp.196 (alloc 16)) (set! tmp.150 (+ tmp.196 2)))
        (begin
          (mset! tmp.150 -2 L.fun/fixnum8858.16.23)
          (mset! tmp.150 6 0)
          (set! fun/fixnum8858.16 tmp.150)))
      (begin
        (begin (set! tmp.197 (alloc 16)) (set! tmp.151 (+ tmp.197 2)))
        (begin
          (mset! tmp.151 -2 L.fun/fixnum8860.17.24)
          (mset! tmp.151 6 16)
          (set! fun/fixnum8860.17 tmp.151)))
      (begin
        (begin (set! tmp.198 (alloc 16)) (set! tmp.152 (+ tmp.198 2)))
        (begin
          (mset! tmp.152 -2 L.fun/empty8862.18.25)
          (mset! tmp.152 6 8)
          (set! fun/empty8862.18 tmp.152)))
      (begin
        (mset! vector-init-loop.60 14 vector-init-loop.60)
        (mset! make-init-vector.4 14 vector-init-loop.60)
        (mset! make-vector.113 14 make-init-vector.4)
        (mset! vector-set!.110 14 unsafe-vector-set!.5)
        (mset! fun/void8861.14 14 vector-set!.110)
        (begin
          (begin
            (if (!= 14 6) (set! tmp.7.27 584) (set! tmp.7.27 1720))
            (if (!= tmp.7.27 6)
              (set! g43092885.26 tmp.7.27)
              (begin
                (set! tmp.8.28 (call L.fun/fixnum8858.16.23 fun/fixnum8858.16))
                (if (!= tmp.8.28 6)
                  (set! g43092885.26 tmp.8.28)
                  (begin
                    (begin
                      (begin
                        (begin
                          (set! tmp.199 (alloc 16))
                          (set! tmp.153 (+ tmp.199 2)))
                        (begin
                          (mset! tmp.153 -2 L.lam.115.26)
                          (mset! tmp.153 6 0)
                          (set! lam.115 tmp.153)))
                      (set! procedure0.31 lam.115))
                    (set! error1.30 36670)
                    (set! void2.29 30)
                    (set! g43092885.26 1328))))))
          (if (begin
                (set! tmp.200 (call L.error?.111.15 error?.111 g43092885.26))
                (!= tmp.200 6))
            g43092885.26
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (begin
                          (begin
                            (begin
                              (begin
                                (set! tmp.208
                                  (call L.cons.112.14 cons.112 3608 22))
                                (set! tmp.207
                                  (call L.cons.112.14 cons.112 352 tmp.208)))
                              (begin
                                (set! tmp.209
                                  (call L.cons.112.14 cons.112 18478 22))
                                (set! tmp.206
                                  (call
                                   L.cons.112.14
                                   cons.112
                                   tmp.207
                                   tmp.209))))
                            (set! tmp.205
                              (call L.cons.112.14 cons.112 28462 tmp.206)))
                          (set! tmp.204
                            (call L.cons.112.14 cons.112 1416 tmp.205)))
                        (set! tmp.203
                          (call L.cons.112.14 cons.112 22 tmp.204)))
                      (set! tmp.202
                        (call L.cons.112.14 cons.112 1312 tmp.203)))
                    (set! tmp.201 (call L.cons.112.14 cons.112 29742 tmp.202)))
                  (set! pair0.34 (call L.cons.112.14 cons.112 22 tmp.201)))
                (set! fixnum1.33
                  (call L.fun/fixnum8859.11.18 fun/fixnum8859.11))
                (if (!= 14 6)
                  (set! g43092886.32 336)
                  (set! g43092886.32 1584)))
              (if (begin
                    (set! tmp.210
                      (call L.error?.111.15 error?.111 g43092886.32))
                    (!= tmp.210 6))
                g43092886.32
                (begin
                  (begin
                    (begin
                      (begin
                        (begin
                          (set! tmp.9.37
                            (call L.make-vector.113.13 make-vector.113 64))
                          (begin
                            (set! g43092889.38
                              (call
                               L.vector-set!.110.17
                               vector-set!.110
                               tmp.9.37
                               0
                               8))
                            (if (begin
                                  (set! tmp.213
                                    (call
                                     L.error?.111.15
                                     error?.111
                                     g43092889.38))
                                  (!= tmp.213 6))
                              (set! tmp.212 g43092889.38)
                              (begin
                                (set! g43092890.39
                                  (call
                                   L.vector-set!.110.17
                                   vector-set!.110
                                   tmp.9.37
                                   8
                                   16))
                                (if (begin
                                      (set! tmp.214
                                        (call
                                         L.error?.111.15
                                         error?.111
                                         g43092890.39))
                                      (!= tmp.214 6))
                                  (set! tmp.212 g43092890.39)
                                  (begin
                                    (set! g43092891.40
                                      (call
                                       L.vector-set!.110.17
                                       vector-set!.110
                                       tmp.9.37
                                       16
                                       24))
                                    (if (begin
                                          (set! tmp.215
                                            (call
                                             L.error?.111.15
                                             error?.111
                                             g43092891.40))
                                          (!= tmp.215 6))
                                      (set! tmp.212 g43092891.40)
                                      (begin
                                        (set! g43092892.41
                                          (call
                                           L.vector-set!.110.17
                                           vector-set!.110
                                           tmp.9.37
                                           24
                                           32))
                                        (if (begin
                                              (set! tmp.216
                                                (call
                                                 L.error?.111.15
                                                 error?.111
                                                 g43092892.41))
                                              (!= tmp.216 6))
                                          (set! tmp.212 g43092892.41)
                                          (begin
                                            (set! g43092893.42
                                              (call
                                               L.vector-set!.110.17
                                               vector-set!.110
                                               tmp.9.37
                                               32
                                               40))
                                            (if (begin
                                                  (set! tmp.217
                                                    (call
                                                     L.error?.111.15
                                                     error?.111
                                                     g43092893.42))
                                                  (!= tmp.217 6))
                                              (set! tmp.212 g43092893.42)
                                              (begin
                                                (set! g43092894.43
                                                  (call
                                                   L.vector-set!.110.17
                                                   vector-set!.110
                                                   tmp.9.37
                                                   40
                                                   48))
                                                (if (begin
                                                      (set! tmp.218
                                                        (call
                                                         L.error?.111.15
                                                         error?.111
                                                         g43092894.43))
                                                      (!= tmp.218 6))
                                                  (set! tmp.212 g43092894.43)
                                                  (begin
                                                    (set! g43092895.44
                                                      (call
                                                       L.vector-set!.110.17
                                                       vector-set!.110
                                                       tmp.9.37
                                                       48
                                                       56))
                                                    (if (begin
                                                          (set! tmp.219
                                                            (call
                                                             L.error?.111.15
                                                             error?.111
                                                             g43092895.44))
                                                          (!= tmp.219 6))
                                                      (set! tmp.212
                                                        g43092895.44)
                                                      (begin
                                                        (set! g43092896.45
                                                          (call
                                                           L.vector-set!.110.17
                                                           vector-set!.110
                                                           tmp.9.37
                                                           56
                                                           64))
                                                        (if (begin
                                                              (set! tmp.220
                                                                (call
                                                                 L.error?.111.15
                                                                 error?.111
                                                                 g43092896.45))
                                                              (!= tmp.220 6))
                                                          (set! tmp.212
                                                            g43092896.45)
                                                          (set! tmp.212
                                                            tmp.9.37))))))))))))))))))
                        (set! tmp.211
                          (call
                           L.fun/void8861.14.21
                           fun/void8861.14
                           18990
                           tmp.212)))
                      (begin
                        (set! tmp.221
                          (call L.fun/empty8862.18.25 fun/empty8862.18 1488))
                        (set! g43092888.36
                          (call
                           L.fun/fixnum8860.17.24
                           fun/fixnum8860.17
                           tmp.211
                           tmp.221))))
                    (if (begin
                          (set! tmp.222
                            (call L.error?.111.15 error?.111 g43092888.36))
                          (!= tmp.222 6))
                      (set! g43092887.35 g43092888.36)
                      (begin
                        (begin
                          (if (!= 6 6) (set! tmp.223 256) (set! tmp.223 1360))
                          (begin
                            (set! tmp.224
                              (call L.fun/fixnum8863.12.19 fun/fixnum8863.12))
                            (set! g43092897.46
                              (call L.-.114.10 |-.114| tmp.223 tmp.224))))
                        (if (begin
                              (set! tmp.225
                                (call L.error?.111.15 error?.111 g43092897.46))
                              (!= tmp.225 6))
                          (set! g43092887.35 g43092897.46)
                          (begin
                            (begin
                              (set! fixnum0.49 1664)
                              (set! fixnum1.48 928)
                              (set! g43092898.47 368))
                            (if (begin
                                  (set! tmp.226
                                    (call
                                     L.error?.111.15
                                     error?.111
                                     g43092898.47))
                                  (!= tmp.226 6))
                              (set! g43092887.35 g43092898.47)
                              (begin
                                (begin
                                  (set! empty0.52 22)
                                  (set! boolean1.51 6)
                                  (set! g43092899.50 520))
                                (if (begin
                                      (set! tmp.227
                                        (call
                                         L.error?.111.15
                                         error?.111
                                         g43092899.50))
                                      (!= tmp.227 6))
                                  (set! g43092887.35 g43092899.50)
                                  (begin
                                    (if (!= 6 6)
                                      (set! g43092900.53 568)
                                      (set! g43092900.53 1568))
                                    (if (begin
                                          (set! tmp.228
                                            (call
                                             L.error?.111.15
                                             error?.111
                                             g43092900.53))
                                          (!= tmp.228 6))
                                      (set! g43092887.35 g43092900.53)
                                      (begin
                                        (set! void0.56 30)
                                        (set! error1.55 29502)
                                        (begin
                                          (set! tmp.229
                                            (call
                                             L.cons.112.14
                                             cons.112
                                             2208
                                             22))
                                          (set! pair2.54
                                            (call
                                             L.cons.112.14
                                             cons.112
                                             2024
                                             tmp.229)))
                                        (set! g43092887.35 56))))))))))))
                  (if (begin
                        (set! tmp.230
                          (call L.error?.111.15 error?.111 g43092887.35))
                        (!= tmp.230 6))
                    g43092887.35
                    (begin
                      (begin
                        (set! tmp.10.57 15934)
                        (if (!= tmp.10.57 6)
                          (set! tmp.231 tmp.10.57)
                          (begin
                            (begin
                              (begin
                                (begin
                                  (set! tmp.233 (alloc 16))
                                  (set! tmp.154 (+ tmp.233 2)))
                                (begin
                                  (mset! tmp.154 -2 L.lam.116.27)
                                  (mset! tmp.154 6 0)
                                  (set! lam.116 tmp.154)))
                              (set! tmp.232 lam.116))
                            (set! tmp.231
                              (call
                               L.fun/error8865.15.22
                               fun/error8865.15
                               tmp.232)))))
                      (call
                       L.fun/fixnum8864.13.20
                       fun/fixnum8864.13
                       tmp.231))))))))))))
(check-by-interp
 '(module
    (define L.lam.93.19
      (lambda (c.103)
        (begin
          (set! cons.92 (mref c.103 14))
          (begin
            (set! tmp.116 (call L.cons.92.10 cons.92 2464 22))
            (call L.cons.92.10 cons.92 1184 tmp.116)))))
    (define L.fun/fixnum8868.15.18
      (lambda (c.102 oprand0.17 oprand1.16)
        (begin
          (set! fun/fixnum8869.14 (mref c.102 14))
          (call L.fun/fixnum8869.14.17 fun/fixnum8869.14))))
    (define L.fun/fixnum8869.14.17 (lambda (c.101) (begin 1152)))
    (define L.make-vector.89.16
      (lambda (c.100 tmp.65)
        (begin
          (set! make-init-vector.4 (mref c.100 14))
          (if (begin
                (if (begin (set! tmp.118 (bitwise-and tmp.65 7)) (= tmp.118 0))
                  (set! tmp.117 14)
                  (set! tmp.117 6))
                (!= tmp.117 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.65)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.99 tmp.37)
        (begin
          (set! vector-init-loop.39 (mref c.99 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.122 (arithmetic-shift-right tmp.37 3))
                      (set! tmp.121 (+ 1 tmp.122)))
                    (set! tmp.120 (* tmp.121 8)))
                  (set! tmp.119 (alloc tmp.120)))
                (set! tmp.104 (+ tmp.119 3)))
              (begin (mset! tmp.104 -3 tmp.37) (set! tmp.38 tmp.104)))
            (call
             L.vector-init-loop.39.14
             vector-init-loop.39
             tmp.37
             0
             tmp.38)))))
    (define L.vector-init-loop.39.14
      (lambda (c.98 len.40 i.42 vec.41)
        (begin
          (set! vector-init-loop.39 (mref c.98 14))
          (if (begin
                (if (= len.40 i.42) (set! tmp.123 14) (set! tmp.123 6))
                (!= tmp.123 6))
            vec.41
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.126 (arithmetic-shift-right i.42 3))
                    (set! tmp.125 (* tmp.126 8)))
                  (set! tmp.124 (+ tmp.125 5)))
                (mset! vec.41 tmp.124 0))
              (begin
                (set! tmp.127 (+ i.42 8))
                (call
                 L.vector-init-loop.39.14
                 vector-init-loop.39
                 len.40
                 tmp.127
                 vec.41)))))))
    (define L.vector-set!.90.13
      (lambda (c.97 tmp.67 tmp.68 tmp.69)
        (begin
          (set! unsafe-vector-set!.5 (mref c.97 14))
          (if (begin
                (if (begin (set! tmp.129 (bitwise-and tmp.68 7)) (= tmp.129 0))
                  (set! tmp.128 14)
                  (set! tmp.128 6))
                (!= tmp.128 6))
            (if (begin
                  (if (begin
                        (set! tmp.131 (bitwise-and tmp.67 7))
                        (= tmp.131 3))
                    (set! tmp.130 14)
                    (set! tmp.130 6))
                  (!= tmp.130 6))
              (call
               L.unsafe-vector-set!.5.12
               unsafe-vector-set!.5
               tmp.67
               tmp.68
               tmp.69)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.12
      (lambda (c.96 tmp.43 tmp.44 tmp.45)
        (begin
          (if (begin
                (if (begin (set! tmp.133 (mref tmp.43 -3)) (< tmp.44 tmp.133))
                  (set! tmp.132 14)
                  (set! tmp.132 6))
                (!= tmp.132 6))
            (if (begin
                  (if (>= tmp.44 0) (set! tmp.134 14) (set! tmp.134 6))
                  (!= tmp.134 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.137 (arithmetic-shift-right tmp.44 3))
                      (set! tmp.136 (* tmp.137 8)))
                    (set! tmp.135 (+ tmp.136 5)))
                  (mset! tmp.43 tmp.135 tmp.45))
                30)
              2622)
            2622))))
    (define L.error?.91.11
      (lambda (c.95 tmp.79)
        (begin
          (if (begin (set! tmp.138 (bitwise-and tmp.79 255)) (= tmp.138 62))
            14
            6))))
    (define L.cons.92.10
      (lambda (c.94 tmp.84 tmp.85)
        (begin
          (begin
            (begin (set! tmp.139 (alloc 16)) (set! tmp.105 (+ tmp.139 1)))
            (begin
              (mset! tmp.105 -1 tmp.84)
              (mset! tmp.105 7 tmp.85)
              tmp.105)))))
    (begin
      (begin
        (begin (set! tmp.140 (alloc 16)) (set! tmp.106 (+ tmp.140 2)))
        (begin
          (mset! tmp.106 -2 L.cons.92.10)
          (mset! tmp.106 6 16)
          (set! cons.92 tmp.106)))
      (begin
        (begin (set! tmp.141 (alloc 16)) (set! tmp.107 (+ tmp.141 2)))
        (begin
          (mset! tmp.107 -2 L.error?.91.11)
          (mset! tmp.107 6 8)
          (set! error?.91 tmp.107)))
      (begin
        (begin (set! tmp.142 (alloc 16)) (set! tmp.108 (+ tmp.142 2)))
        (begin
          (mset! tmp.108 -2 L.unsafe-vector-set!.5.12)
          (mset! tmp.108 6 24)
          (set! unsafe-vector-set!.5 tmp.108)))
      (begin
        (begin (set! tmp.143 (alloc 24)) (set! tmp.109 (+ tmp.143 2)))
        (begin
          (mset! tmp.109 -2 L.vector-set!.90.13)
          (mset! tmp.109 6 24)
          (set! vector-set!.90 tmp.109)))
      (begin
        (begin (set! tmp.144 (alloc 24)) (set! tmp.110 (+ tmp.144 2)))
        (begin
          (mset! tmp.110 -2 L.vector-init-loop.39.14)
          (mset! tmp.110 6 24)
          (set! vector-init-loop.39 tmp.110)))
      (begin
        (begin (set! tmp.145 (alloc 24)) (set! tmp.111 (+ tmp.145 2)))
        (begin
          (mset! tmp.111 -2 L.make-init-vector.4.15)
          (mset! tmp.111 6 8)
          (set! make-init-vector.4 tmp.111)))
      (begin
        (begin (set! tmp.146 (alloc 24)) (set! tmp.112 (+ tmp.146 2)))
        (begin
          (mset! tmp.112 -2 L.make-vector.89.16)
          (mset! tmp.112 6 8)
          (set! make-vector.89 tmp.112)))
      (begin
        (begin (set! tmp.147 (alloc 16)) (set! tmp.113 (+ tmp.147 2)))
        (begin
          (mset! tmp.113 -2 L.fun/fixnum8869.14.17)
          (mset! tmp.113 6 0)
          (set! fun/fixnum8869.14 tmp.113)))
      (begin
        (begin (set! tmp.148 (alloc 24)) (set! tmp.114 (+ tmp.148 2)))
        (begin
          (mset! tmp.114 -2 L.fun/fixnum8868.15.18)
          (mset! tmp.114 6 16)
          (set! fun/fixnum8868.15 tmp.114)))
      (begin
        (mset! vector-set!.90 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.39 14 vector-init-loop.39)
        (mset! make-init-vector.4 14 vector-init-loop.39)
        (mset! make-vector.89 14 make-init-vector.4)
        (mset! fun/fixnum8868.15 14 fun/fixnum8869.14)
        (if (begin
              (set! empty0.20 22)
              (begin
                (set! tmp.7.21 (call L.make-vector.89.16 make-vector.89 64))
                (begin
                  (set! g43096720.22
                    (call L.vector-set!.90.13 vector-set!.90 tmp.7.21 0 8))
                  (if (begin
                        (set! tmp.149
                          (call L.error?.91.11 error?.91 g43096720.22))
                        (!= tmp.149 6))
                    (set! vector1.19 g43096720.22)
                    (begin
                      (set! g43096721.23
                        (call
                         L.vector-set!.90.13
                         vector-set!.90
                         tmp.7.21
                         8
                         16))
                      (if (begin
                            (set! tmp.150
                              (call L.error?.91.11 error?.91 g43096721.23))
                            (!= tmp.150 6))
                        (set! vector1.19 g43096721.23)
                        (begin
                          (set! g43096722.24
                            (call
                             L.vector-set!.90.13
                             vector-set!.90
                             tmp.7.21
                             16
                             24))
                          (if (begin
                                (set! tmp.151
                                  (call L.error?.91.11 error?.91 g43096722.24))
                                (!= tmp.151 6))
                            (set! vector1.19 g43096722.24)
                            (begin
                              (set! g43096723.25
                                (call
                                 L.vector-set!.90.13
                                 vector-set!.90
                                 tmp.7.21
                                 24
                                 32))
                              (if (begin
                                    (set! tmp.152
                                      (call
                                       L.error?.91.11
                                       error?.91
                                       g43096723.25))
                                    (!= tmp.152 6))
                                (set! vector1.19 g43096723.25)
                                (begin
                                  (set! g43096724.26
                                    (call
                                     L.vector-set!.90.13
                                     vector-set!.90
                                     tmp.7.21
                                     32
                                     40))
                                  (if (begin
                                        (set! tmp.153
                                          (call
                                           L.error?.91.11
                                           error?.91
                                           g43096724.26))
                                        (!= tmp.153 6))
                                    (set! vector1.19 g43096724.26)
                                    (begin
                                      (set! g43096725.27
                                        (call
                                         L.vector-set!.90.13
                                         vector-set!.90
                                         tmp.7.21
                                         40
                                         48))
                                      (if (begin
                                            (set! tmp.154
                                              (call
                                               L.error?.91.11
                                               error?.91
                                               g43096725.27))
                                            (!= tmp.154 6))
                                        (set! vector1.19 g43096725.27)
                                        (begin
                                          (set! g43096726.28
                                            (call
                                             L.vector-set!.90.13
                                             vector-set!.90
                                             tmp.7.21
                                             48
                                             56))
                                          (if (begin
                                                (set! tmp.155
                                                  (call
                                                   L.error?.91.11
                                                   error?.91
                                                   g43096726.28))
                                                (!= tmp.155 6))
                                            (set! vector1.19 g43096726.28)
                                            (begin
                                              (set! g43096727.29
                                                (call
                                                 L.vector-set!.90.13
                                                 vector-set!.90
                                                 tmp.7.21
                                                 56
                                                 64))
                                              (if (begin
                                                    (set! tmp.156
                                                      (call
                                                       L.error?.91.11
                                                       error?.91
                                                       g43096727.29))
                                                    (!= tmp.156 6))
                                                (set! vector1.19 g43096727.29)
                                                (set! vector1.19
                                                  tmp.7.21))))))))))))))))))
              (begin
                (begin
                  (begin
                    (set! tmp.157 (alloc 24))
                    (set! tmp.115 (+ tmp.157 2)))
                  (begin
                    (mset! tmp.115 -2 L.lam.93.19)
                    (mset! tmp.115 6 0)
                    (set! lam.93 tmp.115)))
                (begin (mset! lam.93 14 cons.92) (set! procedure2.18 lam.93)))
              (!= 6 6))
          (if (!= 6 6) 408 1568)
          (begin
            (begin
              (set! tmp.8.30 30)
              (if (!= tmp.8.30 6)
                (set! tmp.158 tmp.8.30)
                (begin
                  (set! tmp.9.31 30)
                  (if (!= tmp.9.31 6)
                    (set! tmp.158 tmp.9.31)
                    (begin
                      (set! tmp.10.32 30)
                      (if (!= tmp.10.32 6)
                        (set! tmp.158 tmp.10.32)
                        (begin
                          (set! tmp.11.33 30)
                          (if (!= tmp.11.33 6)
                            (set! tmp.158 tmp.11.33)
                            (begin
                              (set! tmp.12.34 30)
                              (if (!= tmp.12.34 6)
                                (set! tmp.158 tmp.12.34)
                                (begin
                                  (set! tmp.13.35 30)
                                  (if (!= tmp.13.35 6)
                                    (set! tmp.158 tmp.13.35)
                                    (set! tmp.158 30)))))))))))))
            (begin
              (begin
                (set! g43096728.36 6)
                (if (begin
                      (set! tmp.160
                        (call L.error?.91.11 error?.91 g43096728.36))
                      (!= tmp.160 6))
                  (set! tmp.159 g43096728.36)
                  (set! tmp.159 14)))
              (call
               L.fun/fixnum8868.15.18
               fun/fixnum8868.15
               tmp.158
               tmp.159))))))))
(check-by-interp
 '(module
    (define L.fun/pair8877.12.16
      (lambda (c.75 oprand0.15)
        (begin
          (set! cons.68 (mref c.75 14))
          (begin
            (set! tmp.84 (call L.cons.68.10 cons.68 3080 22))
            (call L.cons.68.10 cons.68 224 tmp.84)))))
    (define L.fun/fixnum8876.11.15 (lambda (c.74) (begin 1624)))
    (define L.fun/fixnum8872.10.14
      (lambda (c.73 oprand0.14)
        (begin
          (set! fun/fixnum8873.8 (mref c.73 14))
          (call L.fun/fixnum8873.8.12 fun/fixnum8873.8))))
    (define L.fun/fixnum8874.9.13
      (lambda (c.72)
        (begin
          (set! fun/pair8877.12 (mref c.72 14))
          (set! fun/fixnum8875.7 (mref c.72 22))
          (begin
            (set! tmp.85 (call L.fun/pair8877.12.16 fun/pair8877.12 20014))
            (call L.fun/fixnum8875.7.11 fun/fixnum8875.7 tmp.85)))))
    (define L.fun/fixnum8873.8.12 (lambda (c.71) (begin (begin 1240))))
    (define L.fun/fixnum8875.7.11
      (lambda (c.70 oprand0.13)
        (begin
          (set! fun/fixnum8876.11 (mref c.70 14))
          (call L.fun/fixnum8876.11.15 fun/fixnum8876.11))))
    (define L.cons.68.10
      (lambda (c.69 tmp.63 tmp.64)
        (begin
          (begin
            (begin (set! tmp.86 (alloc 16)) (set! tmp.76 (+ tmp.86 1)))
            (begin (mset! tmp.76 -1 tmp.63) (mset! tmp.76 7 tmp.64) tmp.76)))))
    (begin
      (begin
        (begin (set! tmp.87 (alloc 16)) (set! tmp.77 (+ tmp.87 2)))
        (begin
          (mset! tmp.77 -2 L.cons.68.10)
          (mset! tmp.77 6 16)
          (set! cons.68 tmp.77)))
      (begin
        (begin (set! tmp.88 (alloc 24)) (set! tmp.78 (+ tmp.88 2)))
        (begin
          (mset! tmp.78 -2 L.fun/fixnum8875.7.11)
          (mset! tmp.78 6 8)
          (set! fun/fixnum8875.7 tmp.78)))
      (begin
        (begin (set! tmp.89 (alloc 16)) (set! tmp.79 (+ tmp.89 2)))
        (begin
          (mset! tmp.79 -2 L.fun/fixnum8873.8.12)
          (mset! tmp.79 6 0)
          (set! fun/fixnum8873.8 tmp.79)))
      (begin
        (begin (set! tmp.90 (alloc 32)) (set! tmp.80 (+ tmp.90 2)))
        (begin
          (mset! tmp.80 -2 L.fun/fixnum8874.9.13)
          (mset! tmp.80 6 0)
          (set! fun/fixnum8874.9 tmp.80)))
      (begin
        (begin (set! tmp.91 (alloc 24)) (set! tmp.81 (+ tmp.91 2)))
        (begin
          (mset! tmp.81 -2 L.fun/fixnum8872.10.14)
          (mset! tmp.81 6 8)
          (set! fun/fixnum8872.10 tmp.81)))
      (begin
        (begin (set! tmp.92 (alloc 16)) (set! tmp.82 (+ tmp.92 2)))
        (begin
          (mset! tmp.82 -2 L.fun/fixnum8876.11.15)
          (mset! tmp.82 6 0)
          (set! fun/fixnum8876.11 tmp.82)))
      (begin
        (begin (set! tmp.93 (alloc 24)) (set! tmp.83 (+ tmp.93 2)))
        (begin
          (mset! tmp.83 -2 L.fun/pair8877.12.16)
          (mset! tmp.83 6 8)
          (set! fun/pair8877.12 tmp.83)))
      (begin
        (mset! fun/fixnum8875.7 14 fun/fixnum8876.11)
        (mset! fun/fixnum8874.9 14 fun/pair8877.12)
        (mset! fun/fixnum8874.9 22 fun/fixnum8875.7)
        (mset! fun/fixnum8872.10 14 fun/fixnum8873.8)
        (mset! fun/pair8877.12 14 cons.68)
        (begin
          (set! tmp.94 (call L.fun/fixnum8874.9.13 fun/fixnum8874.9))
          (call L.fun/fixnum8872.10.14 fun/fixnum8872.10 tmp.94))))))
(check-by-interp
 '(module
    (if (begin (set! void0.7 30) (!= 14 6))
      (begin (set! empty0.10 22) (set! empty1.9 22) (set! boolean2.8 14) 30510)
      (if (!= 14 6) 17966 30510))))
(check-by-interp
 '(module
    (define L.lam.99.21
      (lambda (c.111)
        (begin
          (set! vector-set!.97 (mref c.111 14))
          (set! error?.98 (mref c.111 22))
          (set! make-vector.96 (mref c.111 30))
          (begin
            (set! tmp.7.23 (call L.make-vector.96.15 make-vector.96 64))
            (begin
              (set! g43108180.24
                (call L.vector-set!.97.12 vector-set!.97 tmp.7.23 0 0))
              (if (begin
                    (set! tmp.126 (call L.error?.98.10 error?.98 g43108180.24))
                    (!= tmp.126 6))
                g43108180.24
                (begin
                  (set! g43108181.25
                    (call L.vector-set!.97.12 vector-set!.97 tmp.7.23 8 8))
                  (if (begin
                        (set! tmp.127
                          (call L.error?.98.10 error?.98 g43108181.25))
                        (!= tmp.127 6))
                    g43108181.25
                    (begin
                      (set! g43108182.26
                        (call
                         L.vector-set!.97.12
                         vector-set!.97
                         tmp.7.23
                         16
                         16))
                      (if (begin
                            (set! tmp.128
                              (call L.error?.98.10 error?.98 g43108182.26))
                            (!= tmp.128 6))
                        g43108182.26
                        (begin
                          (set! g43108183.27
                            (call
                             L.vector-set!.97.12
                             vector-set!.97
                             tmp.7.23
                             24
                             24))
                          (if (begin
                                (set! tmp.129
                                  (call L.error?.98.10 error?.98 g43108183.27))
                                (!= tmp.129 6))
                            g43108183.27
                            (begin
                              (set! g43108184.28
                                (call
                                 L.vector-set!.97.12
                                 vector-set!.97
                                 tmp.7.23
                                 32
                                 32))
                              (if (begin
                                    (set! tmp.130
                                      (call
                                       L.error?.98.10
                                       error?.98
                                       g43108184.28))
                                    (!= tmp.130 6))
                                g43108184.28
                                (begin
                                  (set! g43108185.29
                                    (call
                                     L.vector-set!.97.12
                                     vector-set!.97
                                     tmp.7.23
                                     40
                                     40))
                                  (if (begin
                                        (set! tmp.131
                                          (call
                                           L.error?.98.10
                                           error?.98
                                           g43108185.29))
                                        (!= tmp.131 6))
                                    g43108185.29
                                    (begin
                                      (set! g43108186.30
                                        (call
                                         L.vector-set!.97.12
                                         vector-set!.97
                                         tmp.7.23
                                         48
                                         48))
                                      (if (begin
                                            (set! tmp.132
                                              (call
                                               L.error?.98.10
                                               error?.98
                                               g43108186.30))
                                            (!= tmp.132 6))
                                        g43108186.30
                                        (begin
                                          (set! g43108187.31
                                            (call
                                             L.vector-set!.97.12
                                             vector-set!.97
                                             tmp.7.23
                                             56
                                             56))
                                          (if (begin
                                                (set! tmp.133
                                                  (call
                                                   L.error?.98.10
                                                   error?.98
                                                   g43108187.31))
                                                (!= tmp.133 6))
                                            g43108187.31
                                            tmp.7.23))))))))))))))))))))
    (define L.fun/empty8884.17.20 (lambda (c.110) (begin 22)))
    (define L.fun/empty8883.16.19 (lambda (c.109 oprand0.20) (begin 22)))
    (define L.fun/empty8885.15.18
      (lambda (c.108 oprand0.19 oprand1.18) (begin 22)))
    (define L.fun/empty8882.14.17
      (lambda (c.107)
        (begin
          (set! fun/empty8883.16 (mref c.107 14))
          (call L.fun/empty8883.16.19 fun/empty8883.16 30))))
    (define L.cons.95.16
      (lambda (c.106 tmp.90 tmp.91)
        (begin
          (begin
            (begin (set! tmp.134 (alloc 16)) (set! tmp.112 (+ tmp.134 1)))
            (begin
              (mset! tmp.112 -1 tmp.90)
              (mset! tmp.112 7 tmp.91)
              tmp.112)))))
    (define L.make-vector.96.15
      (lambda (c.105 tmp.71)
        (begin
          (set! make-init-vector.4 (mref c.105 14))
          (if (begin
                (if (begin (set! tmp.136 (bitwise-and tmp.71 7)) (= tmp.136 0))
                  (set! tmp.135 14)
                  (set! tmp.135 6))
                (!= tmp.135 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.71)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.104 tmp.43)
        (begin
          (set! vector-init-loop.45 (mref c.104 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.140 (arithmetic-shift-right tmp.43 3))
                      (set! tmp.139 (+ 1 tmp.140)))
                    (set! tmp.138 (* tmp.139 8)))
                  (set! tmp.137 (alloc tmp.138)))
                (set! tmp.113 (+ tmp.137 3)))
              (begin (mset! tmp.113 -3 tmp.43) (set! tmp.44 tmp.113)))
            (call
             L.vector-init-loop.45.13
             vector-init-loop.45
             tmp.43
             0
             tmp.44)))))
    (define L.vector-init-loop.45.13
      (lambda (c.103 len.46 i.48 vec.47)
        (begin
          (set! vector-init-loop.45 (mref c.103 14))
          (if (begin
                (if (= len.46 i.48) (set! tmp.141 14) (set! tmp.141 6))
                (!= tmp.141 6))
            vec.47
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.144 (arithmetic-shift-right i.48 3))
                    (set! tmp.143 (* tmp.144 8)))
                  (set! tmp.142 (+ tmp.143 5)))
                (mset! vec.47 tmp.142 0))
              (begin
                (set! tmp.145 (+ i.48 8))
                (call
                 L.vector-init-loop.45.13
                 vector-init-loop.45
                 len.46
                 tmp.145
                 vec.47)))))))
    (define L.vector-set!.97.12
      (lambda (c.102 tmp.73 tmp.74 tmp.75)
        (begin
          (set! unsafe-vector-set!.5 (mref c.102 14))
          (if (begin
                (if (begin (set! tmp.147 (bitwise-and tmp.74 7)) (= tmp.147 0))
                  (set! tmp.146 14)
                  (set! tmp.146 6))
                (!= tmp.146 6))
            (if (begin
                  (if (begin
                        (set! tmp.149 (bitwise-and tmp.73 7))
                        (= tmp.149 3))
                    (set! tmp.148 14)
                    (set! tmp.148 6))
                  (!= tmp.148 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.73
               tmp.74
               tmp.75)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.101 tmp.49 tmp.50 tmp.51)
        (begin
          (if (begin
                (if (begin (set! tmp.151 (mref tmp.49 -3)) (< tmp.50 tmp.151))
                  (set! tmp.150 14)
                  (set! tmp.150 6))
                (!= tmp.150 6))
            (if (begin
                  (if (>= tmp.50 0) (set! tmp.152 14) (set! tmp.152 6))
                  (!= tmp.152 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.155 (arithmetic-shift-right tmp.50 3))
                      (set! tmp.154 (* tmp.155 8)))
                    (set! tmp.153 (+ tmp.154 5)))
                  (mset! tmp.49 tmp.153 tmp.51))
                30)
              2622)
            2622))))
    (define L.error?.98.10
      (lambda (c.100 tmp.85)
        (begin
          (if (begin (set! tmp.156 (bitwise-and tmp.85 255)) (= tmp.156 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.157 (alloc 16)) (set! tmp.114 (+ tmp.157 2)))
        (begin
          (mset! tmp.114 -2 L.error?.98.10)
          (mset! tmp.114 6 8)
          (set! error?.98 tmp.114)))
      (begin
        (begin (set! tmp.158 (alloc 16)) (set! tmp.115 (+ tmp.158 2)))
        (begin
          (mset! tmp.115 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.115 6 24)
          (set! unsafe-vector-set!.5 tmp.115)))
      (begin
        (begin (set! tmp.159 (alloc 24)) (set! tmp.116 (+ tmp.159 2)))
        (begin
          (mset! tmp.116 -2 L.vector-set!.97.12)
          (mset! tmp.116 6 24)
          (set! vector-set!.97 tmp.116)))
      (begin
        (begin (set! tmp.160 (alloc 24)) (set! tmp.117 (+ tmp.160 2)))
        (begin
          (mset! tmp.117 -2 L.vector-init-loop.45.13)
          (mset! tmp.117 6 24)
          (set! vector-init-loop.45 tmp.117)))
      (begin
        (begin (set! tmp.161 (alloc 24)) (set! tmp.118 (+ tmp.161 2)))
        (begin
          (mset! tmp.118 -2 L.make-init-vector.4.14)
          (mset! tmp.118 6 8)
          (set! make-init-vector.4 tmp.118)))
      (begin
        (begin (set! tmp.162 (alloc 24)) (set! tmp.119 (+ tmp.162 2)))
        (begin
          (mset! tmp.119 -2 L.make-vector.96.15)
          (mset! tmp.119 6 8)
          (set! make-vector.96 tmp.119)))
      (begin
        (begin (set! tmp.163 (alloc 16)) (set! tmp.120 (+ tmp.163 2)))
        (begin
          (mset! tmp.120 -2 L.cons.95.16)
          (mset! tmp.120 6 16)
          (set! cons.95 tmp.120)))
      (begin
        (begin (set! tmp.164 (alloc 24)) (set! tmp.121 (+ tmp.164 2)))
        (begin
          (mset! tmp.121 -2 L.fun/empty8882.14.17)
          (mset! tmp.121 6 0)
          (set! fun/empty8882.14 tmp.121)))
      (begin
        (begin (set! tmp.165 (alloc 16)) (set! tmp.122 (+ tmp.165 2)))
        (begin
          (mset! tmp.122 -2 L.fun/empty8885.15.18)
          (mset! tmp.122 6 16)
          (set! fun/empty8885.15 tmp.122)))
      (begin
        (begin (set! tmp.166 (alloc 16)) (set! tmp.123 (+ tmp.166 2)))
        (begin
          (mset! tmp.123 -2 L.fun/empty8883.16.19)
          (mset! tmp.123 6 8)
          (set! fun/empty8883.16 tmp.123)))
      (begin
        (begin (set! tmp.167 (alloc 16)) (set! tmp.124 (+ tmp.167 2)))
        (begin
          (mset! tmp.124 -2 L.fun/empty8884.17.20)
          (mset! tmp.124 6 0)
          (set! fun/empty8884.17 tmp.124)))
      (begin
        (mset! vector-set!.97 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.45 14 vector-init-loop.45)
        (mset! make-init-vector.4 14 vector-init-loop.45)
        (mset! make-vector.96 14 make-init-vector.4)
        (mset! fun/empty8882.14 14 fun/empty8883.16)
        (if (if (!= 14 6) (!= 14 6) (!= 14 6))
          (call L.fun/empty8882.14.17 fun/empty8882.14)
          (if (begin
                (set! tmp.168 (call L.fun/empty8884.17.20 fun/empty8884.17))
                (!= tmp.168 6))
            (if (!= 22 6)
              (if (begin
                    (begin
                      (begin
                        (set! tmp.171 (call L.cons.95.16 cons.95 2784 22))
                        (set! tmp.170 (call L.cons.95.16 cons.95 792 tmp.171)))
                      (set! tmp.169
                        (call
                         L.fun/empty8885.15.18
                         fun/empty8885.15
                         16190
                         tmp.170)))
                    (!= tmp.169 6))
                (if (begin
                      (begin
                        (set! tmp.172 (call L.cons.95.16 cons.95 2280 22))
                        (set! pair0.22
                          (call L.cons.95.16 cons.95 696 tmp.172)))
                      (begin
                        (begin
                          (begin
                            (set! tmp.173 (alloc 40))
                            (set! tmp.125 (+ tmp.173 2)))
                          (begin
                            (mset! tmp.125 -2 L.lam.99.21)
                            (mset! tmp.125 6 0)
                            (set! lam.99 tmp.125)))
                        (begin
                          (mset! lam.99 14 vector-set!.97)
                          (mset! lam.99 22 error?.98)
                          (mset! lam.99 30 make-vector.96)
                          (set! procedure1.21 lam.99)))
                      (!= 22 6))
                  (if (begin
                        (set! tmp.8.32 22)
                        (if (!= tmp.8.32 6)
                          (!= tmp.8.32 6)
                          (begin
                            (set! tmp.9.33 22)
                            (if (!= tmp.9.33 6)
                              (!= tmp.9.33 6)
                              (begin
                                (set! tmp.10.34 22)
                                (if (!= tmp.10.34 6)
                                  (!= tmp.10.34 6)
                                  (begin
                                    (set! tmp.11.35 22)
                                    (if (!= tmp.11.35 6)
                                      (!= tmp.11.35 6)
                                      (begin
                                        (set! tmp.12.36 22)
                                        (if (!= tmp.12.36 6)
                                          (!= tmp.12.36 6)
                                          (begin
                                            (set! tmp.13.37 22)
                                            (if (!= tmp.13.37 6)
                                              (!= tmp.13.37 6)
                                              (!= 22 6)))))))))))))
                    (if (begin (set! error0.38 48190) (!= 22 6))
                      (begin
                        (set! g43108188.39 22)
                        (if (begin
                              (set! tmp.174
                                (call L.error?.98.10 error?.98 g43108188.39))
                              (!= tmp.174 6))
                          g43108188.39
                          (begin
                            (set! g43108189.40 22)
                            (if (begin
                                  (set! tmp.175
                                    (call
                                     L.error?.98.10
                                     error?.98
                                     g43108189.40))
                                  (!= tmp.175 6))
                              g43108189.40
                              (begin
                                (set! g43108190.41 22)
                                (if (begin
                                      (set! tmp.176
                                        (call
                                         L.error?.98.10
                                         error?.98
                                         g43108190.41))
                                      (!= tmp.176 6))
                                  g43108190.41
                                  (begin
                                    (set! g43108191.42 22)
                                    (if (begin
                                          (set! tmp.177
                                            (call
                                             L.error?.98.10
                                             error?.98
                                             g43108191.42))
                                          (!= tmp.177 6))
                                      g43108191.42
                                      22))))))))
                      6)
                    6)
                  6)
                6)
              6)
            6))))))
(check-by-interp
 '(module
    (define L.cons.61.10
      (lambda (c.62 tmp.56 tmp.57)
        (begin
          (begin
            (begin (set! tmp.65 (alloc 16)) (set! tmp.63 (+ tmp.65 1)))
            (begin (mset! tmp.63 -1 tmp.56) (mset! tmp.63 7 tmp.57) tmp.63)))))
    (begin
      (begin
        (begin (set! tmp.66 (alloc 16)) (set! tmp.64 (+ tmp.66 2)))
        (begin
          (mset! tmp.64 -2 L.cons.61.10)
          (mset! tmp.64 6 16)
          (set! cons.61 tmp.64)))
      (begin
        (begin
          (begin
            (begin
              (begin
                (begin
                  (set! tmp.71 (call L.cons.61.10 cons.61 4064 22))
                  (set! tmp.70 (call L.cons.61.10 cons.61 336 tmp.71)))
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.75 (call L.cons.61.10 cons.61 3440 22))
                        (set! tmp.74 (call L.cons.61.10 cons.61 1712 tmp.75)))
                      (begin
                        (begin
                          (begin
                            (begin
                              (set! tmp.79 (call L.cons.61.10 cons.61 2632 22))
                              (set! tmp.78
                                (call L.cons.61.10 cons.61 184 tmp.79)))
                            (set! tmp.77
                              (call L.cons.61.10 cons.61 tmp.78 22)))
                          (set! tmp.76
                            (call L.cons.61.10 cons.61 19502 tmp.77)))
                        (set! tmp.73
                          (call L.cons.61.10 cons.61 tmp.74 tmp.76))))
                    (set! tmp.72 (call L.cons.61.10 cons.61 1120 tmp.73)))
                  (set! tmp.69 (call L.cons.61.10 cons.61 tmp.70 tmp.72))))
              (set! tmp.68 (call L.cons.61.10 cons.61 31278 tmp.69)))
            (set! tmp.67 (call L.cons.61.10 cons.61 14 tmp.68)))
          (set! pair0.7 (call L.cons.61.10 cons.61 27182 tmp.67)))
        (begin (set! error0.8 32062) 34622)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8894.10.13
      (lambda (c.68)
        (begin
          (set! fun/ascii-char8895.7 (mref c.68 14))
          (call L.fun/ascii-char8895.7.10 fun/ascii-char8895.7))))
    (define L.fun/boolean8893.9.12 (lambda (c.67) (begin 6)))
    (define L.fun/boolean8892.8.11
      (lambda (c.66 oprand0.12 oprand1.11)
        (begin
          (set! fun/boolean8893.9 (mref c.66 14))
          (call L.fun/boolean8893.9.12 fun/boolean8893.9))))
    (define L.fun/ascii-char8895.7.10 (lambda (c.65) (begin 18734)))
    (begin
      (begin
        (begin (set! tmp.73 (alloc 16)) (set! tmp.69 (+ tmp.73 2)))
        (begin
          (mset! tmp.69 -2 L.fun/ascii-char8895.7.10)
          (mset! tmp.69 6 0)
          (set! fun/ascii-char8895.7 tmp.69)))
      (begin
        (begin (set! tmp.74 (alloc 24)) (set! tmp.70 (+ tmp.74 2)))
        (begin
          (mset! tmp.70 -2 L.fun/boolean8892.8.11)
          (mset! tmp.70 6 16)
          (set! fun/boolean8892.8 tmp.70)))
      (begin
        (begin (set! tmp.75 (alloc 16)) (set! tmp.71 (+ tmp.75 2)))
        (begin
          (mset! tmp.71 -2 L.fun/boolean8893.9.12)
          (mset! tmp.71 6 0)
          (set! fun/boolean8893.9 tmp.71)))
      (begin
        (begin (set! tmp.76 (alloc 24)) (set! tmp.72 (+ tmp.76 2)))
        (begin
          (mset! tmp.72 -2 L.fun/ascii-char8894.10.13)
          (mset! tmp.72 6 0)
          (set! fun/ascii-char8894.10 tmp.72)))
      (begin
        (mset! fun/boolean8892.8 14 fun/boolean8893.9)
        (mset! fun/ascii-char8894.10 14 fun/ascii-char8895.7)
        (if (begin
              (begin
                (if (!= 1488 6)
                  (if (!= 136 6)
                    (if (!= 560 6)
                      (if (!= 576 6)
                        (if (!= 1528 6) (set! tmp.78 304) (set! tmp.78 6))
                        (set! tmp.78 6))
                      (set! tmp.78 6))
                    (set! tmp.78 6))
                  (set! tmp.78 6))
                (begin
                  (if (!= 30 6) (set! tmp.79 30) (set! tmp.79 6))
                  (set! tmp.77
                    (call
                     L.fun/boolean8892.8.11
                     fun/boolean8892.8
                     tmp.78
                     tmp.79))))
              (!= tmp.77 6))
          (call L.fun/ascii-char8894.10.13 fun/ascii-char8894.10)
          (if (!= 14 6) 29998 19758))))))
(check-by-interp
 '(module
    (define L.fun/empty8901.11.14 (lambda (c.70) (begin 22)))
    (define L.fun/empty8898.10.13
      (lambda (c.69)
        (begin
          (set! fun/error8902.8 (mref c.69 14))
          (set! fun/empty8899.7 (mref c.69 22))
          (begin
            (begin
              (if (!= 14 6) (set! tmp.77 17198) (set! tmp.77 18734))
              (set! tmp.76 (call L.fun/error8902.8.11 fun/error8902.8 tmp.77)))
            (call L.fun/empty8899.7.10 fun/empty8899.7 tmp.76)))))
    (define L.fun/empty8900.9.12
      (lambda (c.68)
        (begin
          (set! fun/empty8901.11 (mref c.68 14))
          (call L.fun/empty8901.11.14 fun/empty8901.11))))
    (define L.fun/error8902.8.11
      (lambda (c.67 oprand0.13) (begin (begin 35390))))
    (define L.fun/empty8899.7.10
      (lambda (c.66 oprand0.12)
        (begin
          (set! fun/empty8900.9 (mref c.66 14))
          (call L.fun/empty8900.9.12 fun/empty8900.9))))
    (begin
      (begin
        (begin (set! tmp.78 (alloc 24)) (set! tmp.71 (+ tmp.78 2)))
        (begin
          (mset! tmp.71 -2 L.fun/empty8899.7.10)
          (mset! tmp.71 6 8)
          (set! fun/empty8899.7 tmp.71)))
      (begin
        (begin (set! tmp.79 (alloc 16)) (set! tmp.72 (+ tmp.79 2)))
        (begin
          (mset! tmp.72 -2 L.fun/error8902.8.11)
          (mset! tmp.72 6 8)
          (set! fun/error8902.8 tmp.72)))
      (begin
        (begin (set! tmp.80 (alloc 24)) (set! tmp.73 (+ tmp.80 2)))
        (begin
          (mset! tmp.73 -2 L.fun/empty8900.9.12)
          (mset! tmp.73 6 0)
          (set! fun/empty8900.9 tmp.73)))
      (begin
        (begin (set! tmp.81 (alloc 32)) (set! tmp.74 (+ tmp.81 2)))
        (begin
          (mset! tmp.74 -2 L.fun/empty8898.10.13)
          (mset! tmp.74 6 0)
          (set! fun/empty8898.10 tmp.74)))
      (begin
        (begin (set! tmp.82 (alloc 16)) (set! tmp.75 (+ tmp.82 2)))
        (begin
          (mset! tmp.75 -2 L.fun/empty8901.11.14)
          (mset! tmp.75 6 0)
          (set! fun/empty8901.11 tmp.75)))
      (begin
        (mset! fun/empty8899.7 14 fun/empty8900.9)
        (mset! fun/empty8900.9 14 fun/empty8901.11)
        (mset! fun/empty8898.10 14 fun/error8902.8)
        (mset! fun/empty8898.10 22 fun/empty8899.7)
        (call L.fun/empty8898.10.13 fun/empty8898.10)))))
(check-by-interp
 '(module
    (define L.lam.65.12 (lambda (c.68) (begin 22318)))
    (define L.fun/empty8905.7.11 (lambda (c.67 oprand0.8) (begin (begin 22))))
    (define L.cons.64.10
      (lambda (c.66 tmp.59 tmp.60)
        (begin
          (begin
            (begin (set! tmp.73 (alloc 16)) (set! tmp.69 (+ tmp.73 1)))
            (begin (mset! tmp.69 -1 tmp.59) (mset! tmp.69 7 tmp.60) tmp.69)))))
    (begin
      (begin
        (begin (set! tmp.74 (alloc 16)) (set! tmp.70 (+ tmp.74 2)))
        (begin
          (mset! tmp.70 -2 L.cons.64.10)
          (mset! tmp.70 6 16)
          (set! cons.64 tmp.70)))
      (begin
        (begin (set! tmp.75 (alloc 16)) (set! tmp.71 (+ tmp.75 2)))
        (begin
          (mset! tmp.71 -2 L.fun/empty8905.7.11)
          (mset! tmp.71 6 8)
          (set! fun/empty8905.7 tmp.71)))
      (begin
        (begin
          (begin
            (set! void0.11 30)
            (begin
              (begin
                (begin (set! tmp.77 (alloc 16)) (set! tmp.72 (+ tmp.77 2)))
                (begin
                  (mset! tmp.72 -2 L.lam.65.12)
                  (mset! tmp.72 6 0)
                  (set! lam.65 tmp.72)))
              (set! procedure1.10 lam.65))
            (set! fixnum2.9 1760)
            (begin
              (set! tmp.78 (call L.cons.64.10 cons.64 3376 22))
              (set! tmp.76 (call L.cons.64.10 cons.64 1128 tmp.78))))
          (call L.fun/empty8905.7.11 fun/empty8905.7 tmp.76))))))
(check-by-interp
 '(module
    (define L.fun/empty8910.11.15 (lambda (c.77) (begin 22)))
    (define L.fun/boolean8909.10.14 (lambda (c.76) (begin 6)))
    (define L.fun/empty8908.9.13
      (lambda (c.75 oprand0.16)
        (begin
          (set! fun/empty8910.11 (mref c.75 14))
          (set! fun/boolean8909.10 (mref c.75 22))
          (if (begin
                (set! tmp.84 (call L.fun/boolean8909.10.14 fun/boolean8909.10))
                (!= tmp.84 6))
            (begin 22)
            (call L.fun/empty8910.11.15 fun/empty8910.11)))))
    (define L.fun/error8911.8.12
      (lambda (c.74 oprand0.15 oprand1.14) (begin (if (!= 6 6) 58174 23614))))
    (define L.fun/fixnum8912.7.11
      (lambda (c.73 oprand0.13 oprand1.12) (begin oprand0.13)))
    (define L.error?.71.10
      (lambda (c.72 tmp.61)
        (begin
          (if (begin (set! tmp.85 (bitwise-and tmp.61 255)) (= tmp.85 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.86 (alloc 16)) (set! tmp.78 (+ tmp.86 2)))
        (begin
          (mset! tmp.78 -2 L.error?.71.10)
          (mset! tmp.78 6 8)
          (set! error?.71 tmp.78)))
      (begin
        (begin (set! tmp.87 (alloc 16)) (set! tmp.79 (+ tmp.87 2)))
        (begin
          (mset! tmp.79 -2 L.fun/fixnum8912.7.11)
          (mset! tmp.79 6 16)
          (set! fun/fixnum8912.7 tmp.79)))
      (begin
        (begin (set! tmp.88 (alloc 16)) (set! tmp.80 (+ tmp.88 2)))
        (begin
          (mset! tmp.80 -2 L.fun/error8911.8.12)
          (mset! tmp.80 6 16)
          (set! fun/error8911.8 tmp.80)))
      (begin
        (begin (set! tmp.89 (alloc 32)) (set! tmp.81 (+ tmp.89 2)))
        (begin
          (mset! tmp.81 -2 L.fun/empty8908.9.13)
          (mset! tmp.81 6 8)
          (set! fun/empty8908.9 tmp.81)))
      (begin
        (begin (set! tmp.90 (alloc 16)) (set! tmp.82 (+ tmp.90 2)))
        (begin
          (mset! tmp.82 -2 L.fun/boolean8909.10.14)
          (mset! tmp.82 6 0)
          (set! fun/boolean8909.10 tmp.82)))
      (begin
        (begin (set! tmp.91 (alloc 16)) (set! tmp.83 (+ tmp.91 2)))
        (begin
          (mset! tmp.83 -2 L.fun/empty8910.11.15)
          (mset! tmp.83 6 0)
          (set! fun/empty8910.11 tmp.83)))
      (begin
        (mset! fun/empty8908.9 14 fun/empty8910.11)
        (mset! fun/empty8908.9 22 fun/boolean8909.10)
        (begin
          (begin
            (begin
              (begin
                (set! g43127270.17 1544)
                (if (begin
                      (set! tmp.95
                        (call L.error?.71.10 error?.71 g43127270.17))
                      (!= tmp.95 6))
                  (set! tmp.94 g43127270.17)
                  (begin
                    (set! g43127271.18 1984)
                    (if (begin
                          (set! tmp.96
                            (call L.error?.71.10 error?.71 g43127271.18))
                          (!= tmp.96 6))
                      (set! tmp.94 g43127271.18)
                      (set! tmp.94 1112)))))
              (begin
                (if (!= 6 6) (set! tmp.97 6) (set! tmp.97 14))
                (set! tmp.93
                  (call
                   L.fun/fixnum8912.7.11
                   fun/fixnum8912.7
                   tmp.94
                   tmp.97))))
            (begin
              (if (!= 6 6) (set! tmp.98 1376) (set! tmp.98 1496))
              (set! tmp.92
                (call L.fun/error8911.8.12 fun/error8911.8 tmp.93 tmp.98))))
          (call L.fun/empty8908.9.13 fun/empty8908.9 tmp.92))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8917.9.12 (lambda (c.66 oprand0.11) (begin 29742)))
    (define L.fun/empty8916.8.11
      (lambda (c.65 oprand0.10) (begin (if (!= 14 6) 22 22))))
    (define L.fun/empty8915.7.10
      (lambda (c.64)
        (begin
          (set! fun/ascii-char8917.9 (mref c.64 14))
          (set! fun/empty8916.8 (mref c.64 22))
          (begin
            (begin
              (if (!= 14 6) (set! tmp.71 14) (set! tmp.71 6))
              (set! tmp.70
                (call L.fun/ascii-char8917.9.12 fun/ascii-char8917.9 tmp.71)))
            (call L.fun/empty8916.8.11 fun/empty8916.8 tmp.70)))))
    (begin
      (begin
        (begin (set! tmp.72 (alloc 32)) (set! tmp.67 (+ tmp.72 2)))
        (begin
          (mset! tmp.67 -2 L.fun/empty8915.7.10)
          (mset! tmp.67 6 0)
          (set! fun/empty8915.7 tmp.67)))
      (begin
        (begin (set! tmp.73 (alloc 16)) (set! tmp.68 (+ tmp.73 2)))
        (begin
          (mset! tmp.68 -2 L.fun/empty8916.8.11)
          (mset! tmp.68 6 8)
          (set! fun/empty8916.8 tmp.68)))
      (begin
        (begin (set! tmp.74 (alloc 16)) (set! tmp.69 (+ tmp.74 2)))
        (begin
          (mset! tmp.69 -2 L.fun/ascii-char8917.9.12)
          (mset! tmp.69 6 8)
          (set! fun/ascii-char8917.9 tmp.69)))
      (begin
        (mset! fun/empty8915.7 14 fun/ascii-char8917.9)
        (mset! fun/empty8915.7 22 fun/empty8916.8)
        (call L.fun/empty8915.7.10 fun/empty8915.7)))))
(check-by-interp
 '(module
    (define L.lam.139.26
      (lambda (c.157)
        (begin
          (begin
            (begin
              (begin (set! tmp.179 (alloc 16)) (set! tmp.159 (+ tmp.179 2)))
              (begin
                (mset! tmp.159 -2 L.lam.140.27)
                (mset! tmp.159 6 0)
                (set! lam.140 tmp.159)))
            lam.140))))
    (define L.lam.140.27 (lambda (c.158) (begin 5904)))
    (define L.fun/void8927.22.25
      (lambda (c.156)
        (begin
          (set! make-vector.137 (mref c.156 14))
          (set! error?.138 (mref c.156 22))
          (set! vector-set!.136 (mref c.156 30))
          (begin
            (begin
              (set! tmp.7.31 (call L.make-vector.137.13 make-vector.137 64))
              (begin
                (set! g43134900.32
                  (call L.vector-set!.136.15 vector-set!.136 tmp.7.31 0 8))
                (if (begin
                      (set! tmp.180
                        (call L.error?.138.10 error?.138 g43134900.32))
                      (!= tmp.180 6))
                  (set! vector0.30 g43134900.32)
                  (begin
                    (set! g43134901.33
                      (call
                       L.vector-set!.136.15
                       vector-set!.136
                       tmp.7.31
                       8
                       16))
                    (if (begin
                          (set! tmp.181
                            (call L.error?.138.10 error?.138 g43134901.33))
                          (!= tmp.181 6))
                      (set! vector0.30 g43134901.33)
                      (begin
                        (set! g43134902.34
                          (call
                           L.vector-set!.136.15
                           vector-set!.136
                           tmp.7.31
                           16
                           24))
                        (if (begin
                              (set! tmp.182
                                (call L.error?.138.10 error?.138 g43134902.34))
                              (!= tmp.182 6))
                          (set! vector0.30 g43134902.34)
                          (begin
                            (set! g43134903.35
                              (call
                               L.vector-set!.136.15
                               vector-set!.136
                               tmp.7.31
                               24
                               32))
                            (if (begin
                                  (set! tmp.183
                                    (call
                                     L.error?.138.10
                                     error?.138
                                     g43134903.35))
                                  (!= tmp.183 6))
                              (set! vector0.30 g43134903.35)
                              (begin
                                (set! g43134904.36
                                  (call
                                   L.vector-set!.136.15
                                   vector-set!.136
                                   tmp.7.31
                                   32
                                   40))
                                (if (begin
                                      (set! tmp.184
                                        (call
                                         L.error?.138.10
                                         error?.138
                                         g43134904.36))
                                      (!= tmp.184 6))
                                  (set! vector0.30 g43134904.36)
                                  (begin
                                    (set! g43134905.37
                                      (call
                                       L.vector-set!.136.15
                                       vector-set!.136
                                       tmp.7.31
                                       40
                                       48))
                                    (if (begin
                                          (set! tmp.185
                                            (call
                                             L.error?.138.10
                                             error?.138
                                             g43134905.37))
                                          (!= tmp.185 6))
                                      (set! vector0.30 g43134905.37)
                                      (begin
                                        (set! g43134906.38
                                          (call
                                           L.vector-set!.136.15
                                           vector-set!.136
                                           tmp.7.31
                                           48
                                           56))
                                        (if (begin
                                              (set! tmp.186
                                                (call
                                                 L.error?.138.10
                                                 error?.138
                                                 g43134906.38))
                                              (!= tmp.186 6))
                                          (set! vector0.30 g43134906.38)
                                          (begin
                                            (set! g43134907.39
                                              (call
                                               L.vector-set!.136.15
                                               vector-set!.136
                                               tmp.7.31
                                               56
                                               64))
                                            (if (begin
                                                  (set! tmp.187
                                                    (call
                                                     L.error?.138.10
                                                     error?.138
                                                     g43134907.39))
                                                  (!= tmp.187 6))
                                              (set! vector0.30 g43134907.39)
                                              (set! vector0.30
                                                tmp.7.31))))))))))))))))))
            30))))
    (define L.fun/void8926.21.24 (lambda (c.155) (begin 30)))
    (define L.fun/void8923.20.23
      (lambda (c.154 oprand0.29)
        (begin
          (set! vector-set!.136 (mref c.154 14))
          (set! cons.135 (mref c.154 22))
          (begin
            (begin
              (begin
                (begin
                  (set! tmp.190 (call L.cons.135.16 cons.135 3336 22))
                  (set! tmp.189 (call L.cons.135.16 cons.135 1184 tmp.190)))
                (set! tmp.188
                  (call
                   L.vector-set!.136.15
                   vector-set!.136
                   oprand0.29
                   32
                   tmp.189)))
              (call
               L.vector-set!.136.15
               vector-set!.136
               oprand0.29
               24
               tmp.188))))))
    (define L.fun/void8924.19.22 (lambda (c.153) (begin 30)))
    (define L.fun/fixnum8920.18.21
      (lambda (c.152 oprand0.28 oprand1.27)
        (begin
          (set! fun/fixnum8921.17 (mref c.152 14))
          (call L.fun/fixnum8921.17.20 fun/fixnum8921.17))))
    (define L.fun/fixnum8921.17.20
      (lambda (c.151)
        (begin
          (set! fun/fixnum8922.15 (mref c.151 14))
          (call L.fun/fixnum8922.15.18 fun/fixnum8922.15))))
    (define L.fun/void8928.16.19
      (lambda (c.150 oprand0.26 oprand1.25) (begin (begin 30))))
    (define L.fun/fixnum8922.15.18 (lambda (c.149) (begin 256)))
    (define L.fun/void8925.14.17
      (lambda (c.148 oprand0.24 oprand1.23) (begin oprand0.24)))
    (define L.cons.135.16
      (lambda (c.147 tmp.130 tmp.131)
        (begin
          (begin
            (begin (set! tmp.191 (alloc 16)) (set! tmp.160 (+ tmp.191 1)))
            (begin
              (mset! tmp.160 -1 tmp.130)
              (mset! tmp.160 7 tmp.131)
              tmp.160)))))
    (define L.vector-set!.136.15
      (lambda (c.146 tmp.113 tmp.114 tmp.115)
        (begin
          (set! unsafe-vector-set!.5 (mref c.146 14))
          (if (begin
                (if (begin
                      (set! tmp.193 (bitwise-and tmp.114 7))
                      (= tmp.193 0))
                  (set! tmp.192 14)
                  (set! tmp.192 6))
                (!= tmp.192 6))
            (if (begin
                  (if (begin
                        (set! tmp.195 (bitwise-and tmp.113 7))
                        (= tmp.195 3))
                    (set! tmp.194 14)
                    (set! tmp.194 6))
                  (!= tmp.194 6))
              (call
               L.unsafe-vector-set!.5.14
               unsafe-vector-set!.5
               tmp.113
               tmp.114
               tmp.115)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.14
      (lambda (c.145 tmp.89 tmp.90 tmp.91)
        (begin
          (if (begin
                (if (begin (set! tmp.197 (mref tmp.89 -3)) (< tmp.90 tmp.197))
                  (set! tmp.196 14)
                  (set! tmp.196 6))
                (!= tmp.196 6))
            (if (begin
                  (if (>= tmp.90 0) (set! tmp.198 14) (set! tmp.198 6))
                  (!= tmp.198 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.201 (arithmetic-shift-right tmp.90 3))
                      (set! tmp.200 (* tmp.201 8)))
                    (set! tmp.199 (+ tmp.200 5)))
                  (mset! tmp.89 tmp.199 tmp.91))
                30)
              2622)
            2622))))
    (define L.make-vector.137.13
      (lambda (c.144 tmp.111)
        (begin
          (set! make-init-vector.4 (mref c.144 14))
          (if (begin
                (if (begin
                      (set! tmp.203 (bitwise-and tmp.111 7))
                      (= tmp.203 0))
                  (set! tmp.202 14)
                  (set! tmp.202 6))
                (!= tmp.202 6))
            (call L.make-init-vector.4.12 make-init-vector.4 tmp.111)
            2110))))
    (define L.make-init-vector.4.12
      (lambda (c.143 tmp.83)
        (begin
          (set! vector-init-loop.85 (mref c.143 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.207 (arithmetic-shift-right tmp.83 3))
                      (set! tmp.206 (+ 1 tmp.207)))
                    (set! tmp.205 (* tmp.206 8)))
                  (set! tmp.204 (alloc tmp.205)))
                (set! tmp.161 (+ tmp.204 3)))
              (begin (mset! tmp.161 -3 tmp.83) (set! tmp.84 tmp.161)))
            (call
             L.vector-init-loop.85.11
             vector-init-loop.85
             tmp.83
             0
             tmp.84)))))
    (define L.vector-init-loop.85.11
      (lambda (c.142 len.86 i.88 vec.87)
        (begin
          (set! vector-init-loop.85 (mref c.142 14))
          (if (begin
                (if (= len.86 i.88) (set! tmp.208 14) (set! tmp.208 6))
                (!= tmp.208 6))
            vec.87
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.211 (arithmetic-shift-right i.88 3))
                    (set! tmp.210 (* tmp.211 8)))
                  (set! tmp.209 (+ tmp.210 5)))
                (mset! vec.87 tmp.209 0))
              (begin
                (set! tmp.212 (+ i.88 8))
                (call
                 L.vector-init-loop.85.11
                 vector-init-loop.85
                 len.86
                 tmp.212
                 vec.87)))))))
    (define L.error?.138.10
      (lambda (c.141 tmp.125)
        (begin
          (if (begin (set! tmp.213 (bitwise-and tmp.125 255)) (= tmp.213 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.214 (alloc 16)) (set! tmp.162 (+ tmp.214 2)))
        (begin
          (mset! tmp.162 -2 L.error?.138.10)
          (mset! tmp.162 6 8)
          (set! error?.138 tmp.162)))
      (begin
        (begin (set! tmp.215 (alloc 24)) (set! tmp.163 (+ tmp.215 2)))
        (begin
          (mset! tmp.163 -2 L.vector-init-loop.85.11)
          (mset! tmp.163 6 24)
          (set! vector-init-loop.85 tmp.163)))
      (begin
        (begin (set! tmp.216 (alloc 24)) (set! tmp.164 (+ tmp.216 2)))
        (begin
          (mset! tmp.164 -2 L.make-init-vector.4.12)
          (mset! tmp.164 6 8)
          (set! make-init-vector.4 tmp.164)))
      (begin
        (begin (set! tmp.217 (alloc 24)) (set! tmp.165 (+ tmp.217 2)))
        (begin
          (mset! tmp.165 -2 L.make-vector.137.13)
          (mset! tmp.165 6 8)
          (set! make-vector.137 tmp.165)))
      (begin
        (begin (set! tmp.218 (alloc 16)) (set! tmp.166 (+ tmp.218 2)))
        (begin
          (mset! tmp.166 -2 L.unsafe-vector-set!.5.14)
          (mset! tmp.166 6 24)
          (set! unsafe-vector-set!.5 tmp.166)))
      (begin
        (begin (set! tmp.219 (alloc 24)) (set! tmp.167 (+ tmp.219 2)))
        (begin
          (mset! tmp.167 -2 L.vector-set!.136.15)
          (mset! tmp.167 6 24)
          (set! vector-set!.136 tmp.167)))
      (begin
        (begin (set! tmp.220 (alloc 16)) (set! tmp.168 (+ tmp.220 2)))
        (begin
          (mset! tmp.168 -2 L.cons.135.16)
          (mset! tmp.168 6 16)
          (set! cons.135 tmp.168)))
      (begin
        (begin (set! tmp.221 (alloc 16)) (set! tmp.169 (+ tmp.221 2)))
        (begin
          (mset! tmp.169 -2 L.fun/void8925.14.17)
          (mset! tmp.169 6 16)
          (set! fun/void8925.14 tmp.169)))
      (begin
        (begin (set! tmp.222 (alloc 16)) (set! tmp.170 (+ tmp.222 2)))
        (begin
          (mset! tmp.170 -2 L.fun/fixnum8922.15.18)
          (mset! tmp.170 6 0)
          (set! fun/fixnum8922.15 tmp.170)))
      (begin
        (begin (set! tmp.223 (alloc 16)) (set! tmp.171 (+ tmp.223 2)))
        (begin
          (mset! tmp.171 -2 L.fun/void8928.16.19)
          (mset! tmp.171 6 16)
          (set! fun/void8928.16 tmp.171)))
      (begin
        (begin (set! tmp.224 (alloc 24)) (set! tmp.172 (+ tmp.224 2)))
        (begin
          (mset! tmp.172 -2 L.fun/fixnum8921.17.20)
          (mset! tmp.172 6 0)
          (set! fun/fixnum8921.17 tmp.172)))
      (begin
        (begin (set! tmp.225 (alloc 24)) (set! tmp.173 (+ tmp.225 2)))
        (begin
          (mset! tmp.173 -2 L.fun/fixnum8920.18.21)
          (mset! tmp.173 6 16)
          (set! fun/fixnum8920.18 tmp.173)))
      (begin
        (begin (set! tmp.226 (alloc 16)) (set! tmp.174 (+ tmp.226 2)))
        (begin
          (mset! tmp.174 -2 L.fun/void8924.19.22)
          (mset! tmp.174 6 0)
          (set! fun/void8924.19 tmp.174)))
      (begin
        (begin (set! tmp.227 (alloc 32)) (set! tmp.175 (+ tmp.227 2)))
        (begin
          (mset! tmp.175 -2 L.fun/void8923.20.23)
          (mset! tmp.175 6 8)
          (set! fun/void8923.20 tmp.175)))
      (begin
        (begin (set! tmp.228 (alloc 16)) (set! tmp.176 (+ tmp.228 2)))
        (begin
          (mset! tmp.176 -2 L.fun/void8926.21.24)
          (mset! tmp.176 6 0)
          (set! fun/void8926.21 tmp.176)))
      (begin
        (begin (set! tmp.229 (alloc 40)) (set! tmp.177 (+ tmp.229 2)))
        (begin
          (mset! tmp.177 -2 L.fun/void8927.22.25)
          (mset! tmp.177 6 0)
          (set! fun/void8927.22 tmp.177)))
      (begin
        (mset! vector-init-loop.85 14 vector-init-loop.85)
        (mset! make-init-vector.4 14 vector-init-loop.85)
        (mset! make-vector.137 14 make-init-vector.4)
        (mset! vector-set!.136 14 unsafe-vector-set!.5)
        (mset! fun/fixnum8921.17 14 fun/fixnum8922.15)
        (mset! fun/fixnum8920.18 14 fun/fixnum8921.17)
        (mset! fun/void8923.20 14 vector-set!.136)
        (mset! fun/void8923.20 22 cons.135)
        (mset! fun/void8927.22 14 make-vector.137)
        (mset! fun/void8927.22 22 error?.138)
        (mset! fun/void8927.22 30 vector-set!.136)
        (begin
          (begin
            (if (!= 14 6)
              (begin
                (set! tmp.8.40 (call L.make-vector.137.13 make-vector.137 64))
                (begin
                  (set! g43134908.41
                    (call L.vector-set!.136.15 vector-set!.136 tmp.8.40 0 8))
                  (if (begin
                        (set! tmp.232
                          (call L.error?.138.10 error?.138 g43134908.41))
                        (!= tmp.232 6))
                    (set! tmp.231 g43134908.41)
                    (begin
                      (set! g43134909.42
                        (call
                         L.vector-set!.136.15
                         vector-set!.136
                         tmp.8.40
                         8
                         16))
                      (if (begin
                            (set! tmp.233
                              (call L.error?.138.10 error?.138 g43134909.42))
                            (!= tmp.233 6))
                        (set! tmp.231 g43134909.42)
                        (begin
                          (set! g43134910.43
                            (call
                             L.vector-set!.136.15
                             vector-set!.136
                             tmp.8.40
                             16
                             24))
                          (if (begin
                                (set! tmp.234
                                  (call
                                   L.error?.138.10
                                   error?.138
                                   g43134910.43))
                                (!= tmp.234 6))
                            (set! tmp.231 g43134910.43)
                            (begin
                              (set! g43134911.44
                                (call
                                 L.vector-set!.136.15
                                 vector-set!.136
                                 tmp.8.40
                                 24
                                 32))
                              (if (begin
                                    (set! tmp.235
                                      (call
                                       L.error?.138.10
                                       error?.138
                                       g43134911.44))
                                    (!= tmp.235 6))
                                (set! tmp.231 g43134911.44)
                                (begin
                                  (set! g43134912.45
                                    (call
                                     L.vector-set!.136.15
                                     vector-set!.136
                                     tmp.8.40
                                     32
                                     40))
                                  (if (begin
                                        (set! tmp.236
                                          (call
                                           L.error?.138.10
                                           error?.138
                                           g43134912.45))
                                        (!= tmp.236 6))
                                    (set! tmp.231 g43134912.45)
                                    (begin
                                      (set! g43134913.46
                                        (call
                                         L.vector-set!.136.15
                                         vector-set!.136
                                         tmp.8.40
                                         40
                                         48))
                                      (if (begin
                                            (set! tmp.237
                                              (call
                                               L.error?.138.10
                                               error?.138
                                               g43134913.46))
                                            (!= tmp.237 6))
                                        (set! tmp.231 g43134913.46)
                                        (begin
                                          (set! g43134914.47
                                            (call
                                             L.vector-set!.136.15
                                             vector-set!.136
                                             tmp.8.40
                                             48
                                             56))
                                          (if (begin
                                                (set! tmp.238
                                                  (call
                                                   L.error?.138.10
                                                   error?.138
                                                   g43134914.47))
                                                (!= tmp.238 6))
                                            (set! tmp.231 g43134914.47)
                                            (begin
                                              (set! g43134915.48
                                                (call
                                                 L.vector-set!.136.15
                                                 vector-set!.136
                                                 tmp.8.40
                                                 56
                                                 64))
                                              (if (begin
                                                    (set! tmp.239
                                                      (call
                                                       L.error?.138.10
                                                       error?.138
                                                       g43134915.48))
                                                    (!= tmp.239 6))
                                                (set! tmp.231 g43134915.48)
                                                (set! tmp.231
                                                  tmp.8.40))))))))))))))))))
              (begin
                (set! tmp.9.49 (call L.make-vector.137.13 make-vector.137 64))
                (begin
                  (set! g43134916.50
                    (call L.vector-set!.136.15 vector-set!.136 tmp.9.49 0 0))
                  (if (begin
                        (set! tmp.240
                          (call L.error?.138.10 error?.138 g43134916.50))
                        (!= tmp.240 6))
                    (set! tmp.231 g43134916.50)
                    (begin
                      (set! g43134917.51
                        (call
                         L.vector-set!.136.15
                         vector-set!.136
                         tmp.9.49
                         8
                         8))
                      (if (begin
                            (set! tmp.241
                              (call L.error?.138.10 error?.138 g43134917.51))
                            (!= tmp.241 6))
                        (set! tmp.231 g43134917.51)
                        (begin
                          (set! g43134918.52
                            (call
                             L.vector-set!.136.15
                             vector-set!.136
                             tmp.9.49
                             16
                             16))
                          (if (begin
                                (set! tmp.242
                                  (call
                                   L.error?.138.10
                                   error?.138
                                   g43134918.52))
                                (!= tmp.242 6))
                            (set! tmp.231 g43134918.52)
                            (begin
                              (set! g43134919.53
                                (call
                                 L.vector-set!.136.15
                                 vector-set!.136
                                 tmp.9.49
                                 24
                                 24))
                              (if (begin
                                    (set! tmp.243
                                      (call
                                       L.error?.138.10
                                       error?.138
                                       g43134919.53))
                                    (!= tmp.243 6))
                                (set! tmp.231 g43134919.53)
                                (begin
                                  (set! g43134920.54
                                    (call
                                     L.vector-set!.136.15
                                     vector-set!.136
                                     tmp.9.49
                                     32
                                     32))
                                  (if (begin
                                        (set! tmp.244
                                          (call
                                           L.error?.138.10
                                           error?.138
                                           g43134920.54))
                                        (!= tmp.244 6))
                                    (set! tmp.231 g43134920.54)
                                    (begin
                                      (set! g43134921.55
                                        (call
                                         L.vector-set!.136.15
                                         vector-set!.136
                                         tmp.9.49
                                         40
                                         40))
                                      (if (begin
                                            (set! tmp.245
                                              (call
                                               L.error?.138.10
                                               error?.138
                                               g43134921.55))
                                            (!= tmp.245 6))
                                        (set! tmp.231 g43134921.55)
                                        (begin
                                          (set! g43134922.56
                                            (call
                                             L.vector-set!.136.15
                                             vector-set!.136
                                             tmp.9.49
                                             48
                                             48))
                                          (if (begin
                                                (set! tmp.246
                                                  (call
                                                   L.error?.138.10
                                                   error?.138
                                                   g43134922.56))
                                                (!= tmp.246 6))
                                            (set! tmp.231 g43134922.56)
                                            (begin
                                              (set! g43134923.57
                                                (call
                                                 L.vector-set!.136.15
                                                 vector-set!.136
                                                 tmp.9.49
                                                 56
                                                 56))
                                              (if (begin
                                                    (set! tmp.247
                                                      (call
                                                       L.error?.138.10
                                                       error?.138
                                                       g43134923.57))
                                                    (!= tmp.247 6))
                                                (set! tmp.231 g43134923.57)
                                                (set! tmp.231
                                                  tmp.9.49)))))))))))))))))))
            (set! tmp.230 (call L.fun/void8923.20.23 fun/void8923.20 tmp.231)))
          (begin
            (begin
              (begin
                (set! g43134924.59 (call L.fun/void8924.19.22 fun/void8924.19))
                (if (begin
                      (set! tmp.249
                        (call L.error?.138.10 error?.138 g43134924.59))
                      (!= tmp.249 6))
                  (set! tmp.10.58 g43134924.59)
                  (begin
                    (if (!= 30 6)
                      (if (!= 30 6)
                        (if (!= 30 6)
                          (if (!= 30 6)
                            (if (!= 30 6)
                              (set! g43134925.60 30)
                              (set! g43134925.60 6))
                            (set! g43134925.60 6))
                          (set! g43134925.60 6))
                        (set! g43134925.60 6))
                      (set! g43134925.60 6))
                    (if (begin
                          (set! tmp.250
                            (call L.error?.138.10 error?.138 g43134925.60))
                          (!= tmp.250 6))
                      (set! tmp.10.58 g43134925.60)
                      (begin
                        (begin
                          (begin
                            (set! tmp.251
                              (call L.cons.135.16 cons.135 3264 22))
                            (set! pair0.64
                              (call L.cons.135.16 cons.135 184 tmp.251)))
                          (begin
                            (set! tmp.11.65
                              (call L.make-vector.137.13 make-vector.137 64))
                            (begin
                              (set! g43134927.66
                                (call
                                 L.vector-set!.136.15
                                 vector-set!.136
                                 tmp.11.65
                                 0
                                 8))
                              (if (begin
                                    (set! tmp.252
                                      (call
                                       L.error?.138.10
                                       error?.138
                                       g43134927.66))
                                    (!= tmp.252 6))
                                (set! vector1.63 g43134927.66)
                                (begin
                                  (set! g43134928.67
                                    (call
                                     L.vector-set!.136.15
                                     vector-set!.136
                                     tmp.11.65
                                     8
                                     16))
                                  (if (begin
                                        (set! tmp.253
                                          (call
                                           L.error?.138.10
                                           error?.138
                                           g43134928.67))
                                        (!= tmp.253 6))
                                    (set! vector1.63 g43134928.67)
                                    (begin
                                      (set! g43134929.68
                                        (call
                                         L.vector-set!.136.15
                                         vector-set!.136
                                         tmp.11.65
                                         16
                                         24))
                                      (if (begin
                                            (set! tmp.254
                                              (call
                                               L.error?.138.10
                                               error?.138
                                               g43134929.68))
                                            (!= tmp.254 6))
                                        (set! vector1.63 g43134929.68)
                                        (begin
                                          (set! g43134930.69
                                            (call
                                             L.vector-set!.136.15
                                             vector-set!.136
                                             tmp.11.65
                                             24
                                             32))
                                          (if (begin
                                                (set! tmp.255
                                                  (call
                                                   L.error?.138.10
                                                   error?.138
                                                   g43134930.69))
                                                (!= tmp.255 6))
                                            (set! vector1.63 g43134930.69)
                                            (begin
                                              (set! g43134931.70
                                                (call
                                                 L.vector-set!.136.15
                                                 vector-set!.136
                                                 tmp.11.65
                                                 32
                                                 40))
                                              (if (begin
                                                    (set! tmp.256
                                                      (call
                                                       L.error?.138.10
                                                       error?.138
                                                       g43134931.70))
                                                    (!= tmp.256 6))
                                                (set! vector1.63 g43134931.70)
                                                (begin
                                                  (set! g43134932.71
                                                    (call
                                                     L.vector-set!.136.15
                                                     vector-set!.136
                                                     tmp.11.65
                                                     40
                                                     48))
                                                  (if (begin
                                                        (set! tmp.257
                                                          (call
                                                           L.error?.138.10
                                                           error?.138
                                                           g43134932.71))
                                                        (!= tmp.257 6))
                                                    (set! vector1.63
                                                      g43134932.71)
                                                    (begin
                                                      (set! g43134933.72
                                                        (call
                                                         L.vector-set!.136.15
                                                         vector-set!.136
                                                         tmp.11.65
                                                         48
                                                         56))
                                                      (if (begin
                                                            (set! tmp.258
                                                              (call
                                                               L.error?.138.10
                                                               error?.138
                                                               g43134933.72))
                                                            (!= tmp.258 6))
                                                        (set! vector1.63
                                                          g43134933.72)
                                                        (begin
                                                          (set! g43134934.73
                                                            (call
                                                             L.vector-set!.136.15
                                                             vector-set!.136
                                                             tmp.11.65
                                                             56
                                                             64))
                                                          (if (begin
                                                                (set! tmp.259
                                                                  (call
                                                                   L.error?.138.10
                                                                   error?.138
                                                                   g43134934.73))
                                                                (!= tmp.259 6))
                                                            (set! vector1.63
                                                              g43134934.73)
                                                            (set! vector1.63
                                                              tmp.11.65))))))))))))))))))
                          (begin
                            (begin
                              (begin
                                (set! tmp.260 (alloc 16))
                                (set! tmp.178 (+ tmp.260 2)))
                              (begin
                                (mset! tmp.178 -2 L.lam.139.26)
                                (mset! tmp.178 6 0)
                                (set! lam.139 tmp.178)))
                            (set! procedure2.62 lam.139))
                          (set! g43134926.61 30))
                        (if (begin
                              (set! tmp.261
                                (call L.error?.138.10 error?.138 g43134926.61))
                              (!= tmp.261 6))
                          (set! tmp.10.58 g43134926.61)
                          (begin
                            (set! g43134935.74
                              (call
                               L.fun/void8925.14.17
                               fun/void8925.14
                               30
                               22))
                            (if (begin
                                  (set! tmp.262
                                    (call
                                     L.error?.138.10
                                     error?.138
                                     g43134935.74))
                                  (!= tmp.262 6))
                              (set! tmp.10.58 g43134935.74)
                              (begin
                                (begin
                                  (set! ascii-char0.77 28718)
                                  (set! error1.76 32574)
                                  (set! g43134936.75 30))
                                (if (begin
                                      (set! tmp.263
                                        (call
                                         L.error?.138.10
                                         error?.138
                                         g43134936.75))
                                      (!= tmp.263 6))
                                  (set! tmp.10.58 g43134936.75)
                                  (set! tmp.10.58
                                    (call
                                     L.fun/void8926.21.24
                                     fun/void8926.21))))))))))))
              (if (!= tmp.10.58 6)
                (set! tmp.248 tmp.10.58)
                (begin
                  (set! tmp.12.78 (call L.fun/void8927.22.25 fun/void8927.22))
                  (if (!= tmp.12.78 6)
                    (set! tmp.248 tmp.12.78)
                    (begin
                      (begin
                        (begin
                          (set! error0.82 54846)
                          (set! fixnum1.81 1760)
                          (set! fixnum2.80 1712)
                          (begin
                            (set! tmp.265
                              (call L.cons.135.16 cons.135 3032 22))
                            (set! tmp.264
                              (call L.cons.135.16 cons.135 1960 tmp.265))))
                        (begin
                          (if (!= 14 6)
                            (begin
                              (set! tmp.267
                                (call L.cons.135.16 cons.135 4064 22))
                              (set! tmp.266
                                (call L.cons.135.16 cons.135 1832 tmp.267)))
                            (begin
                              (set! tmp.268
                                (call L.cons.135.16 cons.135 3392 22))
                              (set! tmp.266
                                (call L.cons.135.16 cons.135 1080 tmp.268))))
                          (set! tmp.13.79
                            (call
                             L.fun/void8928.16.19
                             fun/void8928.16
                             tmp.264
                             tmp.266))))
                      (if (!= tmp.13.79 6)
                        (set! tmp.248 tmp.13.79)
                        (if (!= 14 6)
                          (set! tmp.248 30)
                          (set! tmp.248 30))))))))
            (call
             L.fun/fixnum8920.18.21
             fun/fixnum8920.18
             tmp.230
             tmp.248)))))))
(check-by-interp
 '(module
    (define L.error?.63.10
      (lambda (c.64 tmp.53)
        (begin
          (if (begin (set! tmp.66 (bitwise-and tmp.53 255)) (= tmp.66 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.67 (alloc 16)) (set! tmp.65 (+ tmp.67 2)))
        (begin
          (mset! tmp.65 -2 L.error?.63.10)
          (mset! tmp.65 6 8)
          (set! error?.63 tmp.65)))
      (if (begin
            (set! g43138756.7 6)
            (if (begin
                  (set! tmp.68 (call L.error?.63.10 error?.63 g43138756.7))
                  (!= tmp.68 6))
              (!= g43138756.7 6)
              (begin
                (set! g43138757.8 6)
                (if (begin
                      (set! tmp.69 (call L.error?.63.10 error?.63 g43138757.8))
                      (!= tmp.69 6))
                  (!= g43138757.8 6)
                  (begin
                    (set! g43138758.9 6)
                    (if (begin
                          (set! tmp.70
                            (call L.error?.63.10 error?.63 g43138758.9))
                          (!= tmp.70 6))
                      (!= g43138758.9 6)
                      (begin
                        (set! g43138759.10 6)
                        (if (begin
                              (set! tmp.71
                                (call L.error?.63.10 error?.63 g43138759.10))
                              (!= tmp.71 6))
                          (!= g43138759.10 6)
                          (!= 14 6)))))))))
        30
        (if (!= 14 6) 30 30)))))
(check-by-interp
 '(module
    (define L.fun/fixnum8933.8.11
      (lambda (c.62)
        (begin
          (set! fun/boolean8934.7 (mref c.62 14))
          (if (begin
                (set! tmp.65 (call L.fun/boolean8934.7.10 fun/boolean8934.7))
                (!= tmp.65 6))
            (if (!= 14 6) 1440 1136)
            (begin 272)))))
    (define L.fun/boolean8934.7.10 (lambda (c.61) (begin 14)))
    (begin
      (begin
        (begin (set! tmp.66 (alloc 16)) (set! tmp.63 (+ tmp.66 2)))
        (begin
          (mset! tmp.63 -2 L.fun/boolean8934.7.10)
          (mset! tmp.63 6 0)
          (set! fun/boolean8934.7 tmp.63)))
      (begin
        (begin (set! tmp.67 (alloc 24)) (set! tmp.64 (+ tmp.67 2)))
        (begin
          (mset! tmp.64 -2 L.fun/fixnum8933.8.11)
          (mset! tmp.64 6 0)
          (set! fun/fixnum8933.8 tmp.64)))
      (begin
        (mset! fun/fixnum8933.8 14 fun/boolean8934.7)
        (call L.fun/fixnum8933.8.11 fun/fixnum8933.8)))))
(check-by-interp '(module (begin (begin 64062))))
(check-by-interp
 '(module
    (define L.lam.88.16
      (lambda (c.96 oprand0.19)
        (begin
          (begin
            (begin
              (begin (set! tmp.107 (alloc 16)) (set! tmp.98 (+ tmp.107 2)))
              (begin
                (mset! tmp.98 -2 L.lam.89.17)
                (mset! tmp.98 6 0)
                (set! lam.89 tmp.98)))
            lam.89))))
    (define L.lam.89.17 (lambda (c.97) (begin 8152)))
    (define L.fun/void8951.14.15 (lambda (c.95) (begin 30)))
    (define L.fun/void8950.13.14 (lambda (c.94) (begin 30)))
    (define L.fun/void8949.12.13
      (lambda (c.93 oprand0.16 oprand1.15) (begin (begin 30))))
    (define L.cons.85.12
      (lambda (c.92 tmp.80 tmp.81)
        (begin
          (begin
            (begin (set! tmp.108 (alloc 16)) (set! tmp.99 (+ tmp.108 1)))
            (begin (mset! tmp.99 -1 tmp.80) (mset! tmp.99 7 tmp.81) tmp.99)))))
    (define L.ascii-char?.86.11
      (lambda (c.91 tmp.74)
        (begin
          (if (begin (set! tmp.109 (bitwise-and tmp.74 255)) (= tmp.109 46))
            14
            6))))
    (define L.error?.87.10
      (lambda (c.90 tmp.75)
        (begin
          (if (begin (set! tmp.110 (bitwise-and tmp.75 255)) (= tmp.110 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.111 (alloc 16)) (set! tmp.100 (+ tmp.111 2)))
        (begin
          (mset! tmp.100 -2 L.error?.87.10)
          (mset! tmp.100 6 8)
          (set! error?.87 tmp.100)))
      (begin
        (begin (set! tmp.112 (alloc 16)) (set! tmp.101 (+ tmp.112 2)))
        (begin
          (mset! tmp.101 -2 L.ascii-char?.86.11)
          (mset! tmp.101 6 8)
          (set! ascii-char?.86 tmp.101)))
      (begin
        (begin (set! tmp.113 (alloc 16)) (set! tmp.102 (+ tmp.113 2)))
        (begin
          (mset! tmp.102 -2 L.cons.85.12)
          (mset! tmp.102 6 16)
          (set! cons.85 tmp.102)))
      (begin
        (begin (set! tmp.114 (alloc 16)) (set! tmp.103 (+ tmp.114 2)))
        (begin
          (mset! tmp.103 -2 L.fun/void8949.12.13)
          (mset! tmp.103 6 16)
          (set! fun/void8949.12 tmp.103)))
      (begin
        (begin (set! tmp.115 (alloc 16)) (set! tmp.104 (+ tmp.115 2)))
        (begin
          (mset! tmp.104 -2 L.fun/void8950.13.14)
          (mset! tmp.104 6 0)
          (set! fun/void8950.13 tmp.104)))
      (begin
        (begin (set! tmp.116 (alloc 16)) (set! tmp.105 (+ tmp.116 2)))
        (begin
          (mset! tmp.105 -2 L.fun/void8951.14.15)
          (mset! tmp.105 6 0)
          (set! fun/void8951.14 tmp.105)))
      (if (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.119 (alloc 16))
                      (set! tmp.106 (+ tmp.119 2)))
                    (begin
                      (mset! tmp.106 -2 L.lam.88.16)
                      (mset! tmp.106 6 8)
                      (set! lam.88 tmp.106)))
                  (set! procedure0.18 lam.88))
                (begin
                  (set! tmp.120 (call L.cons.85.12 cons.85 2664 22))
                  (set! pair1.17 (call L.cons.85.12 cons.85 552 tmp.120)))
                (set! tmp.118 48446))
              (set! tmp.117 (call L.ascii-char?.86.11 ascii-char?.86 tmp.118)))
            (!= tmp.117 6))
        (begin
          (if (!= 14 6) (set! tmp.121 1808) (set! tmp.121 144))
          (begin
            (begin
              (set! g43150205.20 22830)
              (if (begin
                    (set! tmp.123 (call L.error?.87.10 error?.87 g43150205.20))
                    (!= tmp.123 6))
                (set! tmp.122 g43150205.20)
                (begin
                  (set! g43150206.21 29742)
                  (if (begin
                        (set! tmp.124
                          (call L.error?.87.10 error?.87 g43150206.21))
                        (!= tmp.124 6))
                    (set! tmp.122 g43150206.21)
                    (begin
                      (set! g43150207.22 27694)
                      (if (begin
                            (set! tmp.125
                              (call L.error?.87.10 error?.87 g43150207.22))
                            (!= tmp.125 6))
                        (set! tmp.122 g43150207.22)
                        (begin
                          (set! g43150208.23 29486)
                          (if (begin
                                (set! tmp.126
                                  (call L.error?.87.10 error?.87 g43150208.23))
                                (!= tmp.126 6))
                            (set! tmp.122 g43150208.23)
                            (begin
                              (set! g43150209.24 26414)
                              (if (begin
                                    (set! tmp.127
                                      (call
                                       L.error?.87.10
                                       error?.87
                                       g43150209.24))
                                    (!= tmp.127 6))
                                (set! tmp.122 g43150209.24)
                                (begin
                                  (set! g43150210.25 22062)
                                  (if (begin
                                        (set! tmp.128
                                          (call
                                           L.error?.87.10
                                           error?.87
                                           g43150210.25))
                                        (!= tmp.128 6))
                                    (set! tmp.122 g43150210.25)
                                    (set! tmp.122 16686)))))))))))))
            (call L.fun/void8949.12.13 fun/void8949.12 tmp.121 tmp.122)))
        (begin
          (begin
            (begin
              (set! tmp.129 (call L.cons.85.12 cons.85 2568 22))
              (set! pair0.28 (call L.cons.85.12 cons.85 1616 tmp.129)))
            (begin
              (set! tmp.130 (call L.cons.85.12 cons.85 3312 22))
              (set! pair1.27 (call L.cons.85.12 cons.85 1144 tmp.130)))
            (set! tmp.7.26 30))
          (if (!= tmp.7.26 6)
            tmp.7.26
            (begin
              (if (!= 14 6) (set! tmp.8.29 30) (set! tmp.8.29 30))
              (if (!= tmp.8.29 6)
                tmp.8.29
                (begin
                  (set! tmp.9.30 (call L.fun/void8950.13.14 fun/void8950.13))
                  (if (!= tmp.9.30 6)
                    tmp.9.30
                    (begin
                      (if (!= 14 6) (set! tmp.10.31 30) (set! tmp.10.31 30))
                      (if (!= tmp.10.31 6)
                        tmp.10.31
                        (begin
                          (set! tmp.11.32 30)
                          (if (!= tmp.11.32 6)
                            tmp.11.32
                            (call
                             L.fun/void8951.14.15
                             fun/void8951.14)))))))))))))))
(check-by-interp '(module (begin (set! boolean0.8 6) (set! empty1.7 22) 30)))
(check-by-interp
 '(module
    (define L.fun/error8957.9.12
      (lambda (c.64)
        (begin
          (set! fun/error8958.7 (mref c.64 14))
          (call L.fun/error8958.7.10 fun/error8958.7))))
    (define L.fun/error8956.8.11
      (lambda (c.63)
        (begin
          (set! fun/error8957.9 (mref c.63 14))
          (call L.fun/error8957.9.12 fun/error8957.9))))
    (define L.fun/error8958.7.10
      (lambda (c.62) (begin (if (!= 14 6) 55358 28222))))
    (begin
      (begin
        (begin (set! tmp.68 (alloc 16)) (set! tmp.65 (+ tmp.68 2)))
        (begin
          (mset! tmp.65 -2 L.fun/error8958.7.10)
          (mset! tmp.65 6 0)
          (set! fun/error8958.7 tmp.65)))
      (begin
        (begin (set! tmp.69 (alloc 24)) (set! tmp.66 (+ tmp.69 2)))
        (begin
          (mset! tmp.66 -2 L.fun/error8956.8.11)
          (mset! tmp.66 6 0)
          (set! fun/error8956.8 tmp.66)))
      (begin
        (begin (set! tmp.70 (alloc 24)) (set! tmp.67 (+ tmp.70 2)))
        (begin
          (mset! tmp.67 -2 L.fun/error8957.9.12)
          (mset! tmp.67 6 0)
          (set! fun/error8957.9 tmp.67)))
      (begin
        (mset! fun/error8956.8 14 fun/error8957.9)
        (mset! fun/error8957.9 14 fun/error8958.7)
        (call L.fun/error8956.8.11 fun/error8956.8)))))
(check-by-interp
 '(module
    (define L.fun/error8962.8.12 (lambda (c.66) (begin 18750)))
    (define L.fun/error8961.7.11
      (lambda (c.65)
        (begin
          (set! fun/error8962.8 (mref c.65 14))
          (call L.fun/error8962.8.12 fun/error8962.8))))
    (define L.cons.63.10
      (lambda (c.64 tmp.58 tmp.59)
        (begin
          (begin
            (begin (set! tmp.71 (alloc 16)) (set! tmp.67 (+ tmp.71 1)))
            (begin (mset! tmp.67 -1 tmp.58) (mset! tmp.67 7 tmp.59) tmp.67)))))
    (begin
      (begin
        (begin (set! tmp.72 (alloc 16)) (set! tmp.68 (+ tmp.72 2)))
        (begin
          (mset! tmp.68 -2 L.cons.63.10)
          (mset! tmp.68 6 16)
          (set! cons.63 tmp.68)))
      (begin
        (begin (set! tmp.73 (alloc 24)) (set! tmp.69 (+ tmp.73 2)))
        (begin
          (mset! tmp.69 -2 L.fun/error8961.7.11)
          (mset! tmp.69 6 0)
          (set! fun/error8961.7 tmp.69)))
      (begin
        (begin (set! tmp.74 (alloc 16)) (set! tmp.70 (+ tmp.74 2)))
        (begin
          (mset! tmp.70 -2 L.fun/error8962.8.12)
          (mset! tmp.70 6 0)
          (set! fun/error8962.8 tmp.70)))
      (begin
        (mset! fun/error8961.7 14 fun/error8962.8)
        (begin
          (begin
            (begin
              (set! tmp.76 (call L.cons.63.10 cons.63 3800 22))
              (set! tmp.75 (call L.cons.63.10 cons.63 832 tmp.76)))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (begin
                          (set! tmp.83 (call L.cons.63.10 cons.63 22 22))
                          (set! tmp.82 (call L.cons.63.10 cons.63 22 tmp.83)))
                        (set! tmp.81 (call L.cons.63.10 cons.63 14 tmp.82)))
                      (set! tmp.80 (call L.cons.63.10 cons.63 1352 tmp.81)))
                    (set! tmp.79 (call L.cons.63.10 cons.63 22 tmp.80)))
                  (set! tmp.78 (call L.cons.63.10 cons.63 6 tmp.79)))
                (set! tmp.77 (call L.cons.63.10 cons.63 0 tmp.78)))
              (set! pair0.10 (call L.cons.63.10 cons.63 tmp.75 tmp.77))))
          (begin (set! boolean1.9 6))
          (call L.fun/error8961.7.11 fun/error8961.7))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8965.16.17
      (lambda (c.101 oprand0.20 oprand1.19) (begin 26414)))
    (define L.fun/ascii-char8966.15.16
      (lambda (c.100 oprand0.18 oprand1.17) (begin 27182)))
    (define L.make-vector.91.15
      (lambda (c.99 tmp.67)
        (begin
          (set! make-init-vector.4 (mref c.99 14))
          (if (begin
                (if (begin (set! tmp.112 (bitwise-and tmp.67 7)) (= tmp.112 0))
                  (set! tmp.111 14)
                  (set! tmp.111 6))
                (!= tmp.111 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.67)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.98 tmp.39)
        (begin
          (set! vector-init-loop.41 (mref c.98 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.116 (arithmetic-shift-right tmp.39 3))
                      (set! tmp.115 (+ 1 tmp.116)))
                    (set! tmp.114 (* tmp.115 8)))
                  (set! tmp.113 (alloc tmp.114)))
                (set! tmp.102 (+ tmp.113 3)))
              (begin (mset! tmp.102 -3 tmp.39) (set! tmp.40 tmp.102)))
            (call
             L.vector-init-loop.41.13
             vector-init-loop.41
             tmp.39
             0
             tmp.40)))))
    (define L.vector-init-loop.41.13
      (lambda (c.97 len.42 i.44 vec.43)
        (begin
          (set! vector-init-loop.41 (mref c.97 14))
          (if (begin
                (if (= len.42 i.44) (set! tmp.117 14) (set! tmp.117 6))
                (!= tmp.117 6))
            vec.43
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.120 (arithmetic-shift-right i.44 3))
                    (set! tmp.119 (* tmp.120 8)))
                  (set! tmp.118 (+ tmp.119 5)))
                (mset! vec.43 tmp.118 0))
              (begin
                (set! tmp.121 (+ i.44 8))
                (call
                 L.vector-init-loop.41.13
                 vector-init-loop.41
                 len.42
                 tmp.121
                 vec.43)))))))
    (define L.vector-set!.92.12
      (lambda (c.96 tmp.69 tmp.70 tmp.71)
        (begin
          (set! unsafe-vector-set!.5 (mref c.96 14))
          (if (begin
                (if (begin (set! tmp.123 (bitwise-and tmp.70 7)) (= tmp.123 0))
                  (set! tmp.122 14)
                  (set! tmp.122 6))
                (!= tmp.122 6))
            (if (begin
                  (if (begin
                        (set! tmp.125 (bitwise-and tmp.69 7))
                        (= tmp.125 3))
                    (set! tmp.124 14)
                    (set! tmp.124 6))
                  (!= tmp.124 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.69
               tmp.70
               tmp.71)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.95 tmp.45 tmp.46 tmp.47)
        (begin
          (if (begin
                (if (begin (set! tmp.127 (mref tmp.45 -3)) (< tmp.46 tmp.127))
                  (set! tmp.126 14)
                  (set! tmp.126 6))
                (!= tmp.126 6))
            (if (begin
                  (if (>= tmp.46 0) (set! tmp.128 14) (set! tmp.128 6))
                  (!= tmp.128 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.131 (arithmetic-shift-right tmp.46 3))
                      (set! tmp.130 (* tmp.131 8)))
                    (set! tmp.129 (+ tmp.130 5)))
                  (mset! tmp.45 tmp.129 tmp.47))
                30)
              2622)
            2622))))
    (define L.error?.93.10
      (lambda (c.94 tmp.81)
        (begin
          (if (begin (set! tmp.132 (bitwise-and tmp.81 255)) (= tmp.132 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.133 (alloc 16)) (set! tmp.103 (+ tmp.133 2)))
        (begin
          (mset! tmp.103 -2 L.error?.93.10)
          (mset! tmp.103 6 8)
          (set! error?.93 tmp.103)))
      (begin
        (begin (set! tmp.134 (alloc 16)) (set! tmp.104 (+ tmp.134 2)))
        (begin
          (mset! tmp.104 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.104 6 24)
          (set! unsafe-vector-set!.5 tmp.104)))
      (begin
        (begin (set! tmp.135 (alloc 24)) (set! tmp.105 (+ tmp.135 2)))
        (begin
          (mset! tmp.105 -2 L.vector-set!.92.12)
          (mset! tmp.105 6 24)
          (set! vector-set!.92 tmp.105)))
      (begin
        (begin (set! tmp.136 (alloc 24)) (set! tmp.106 (+ tmp.136 2)))
        (begin
          (mset! tmp.106 -2 L.vector-init-loop.41.13)
          (mset! tmp.106 6 24)
          (set! vector-init-loop.41 tmp.106)))
      (begin
        (begin (set! tmp.137 (alloc 24)) (set! tmp.107 (+ tmp.137 2)))
        (begin
          (mset! tmp.107 -2 L.make-init-vector.4.14)
          (mset! tmp.107 6 8)
          (set! make-init-vector.4 tmp.107)))
      (begin
        (begin (set! tmp.138 (alloc 24)) (set! tmp.108 (+ tmp.138 2)))
        (begin
          (mset! tmp.108 -2 L.make-vector.91.15)
          (mset! tmp.108 6 8)
          (set! make-vector.91 tmp.108)))
      (begin
        (begin (set! tmp.139 (alloc 16)) (set! tmp.109 (+ tmp.139 2)))
        (begin
          (mset! tmp.109 -2 L.fun/ascii-char8966.15.16)
          (mset! tmp.109 6 16)
          (set! fun/ascii-char8966.15 tmp.109)))
      (begin
        (begin (set! tmp.140 (alloc 16)) (set! tmp.110 (+ tmp.140 2)))
        (begin
          (mset! tmp.110 -2 L.fun/ascii-char8965.16.17)
          (mset! tmp.110 6 16)
          (set! fun/ascii-char8965.16 tmp.110)))
      (begin
        (mset! vector-set!.92 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.41 14 vector-init-loop.41)
        (mset! make-init-vector.4 14 vector-init-loop.41)
        (mset! make-vector.91 14 make-init-vector.4)
        (if (if (!= 14 6) (!= 14 6) (!= 6 6))
          (begin
            (if (!= 14 6) (set! tmp.7.21 29230) (set! tmp.7.21 24622))
            (if (!= tmp.7.21 6)
              tmp.7.21
              (begin
                (begin
                  (set! tmp.9.23 20782)
                  (if (!= tmp.9.23 6)
                    (set! tmp.8.22 tmp.9.23)
                    (begin
                      (set! tmp.10.24 17710)
                      (if (!= tmp.10.24 6)
                        (set! tmp.8.22 tmp.10.24)
                        (set! tmp.8.22 17710)))))
                (if (!= tmp.8.22 6)
                  tmp.8.22
                  (begin
                    (if (!= 6 6) (set! tmp.11.25 27438) (set! tmp.11.25 18990))
                    (if (!= tmp.11.25 6)
                      tmp.11.25
                      (begin
                        (if (!= 6 6)
                          (set! tmp.12.26 19758)
                          (set! tmp.12.26 30254))
                        (if (!= tmp.12.26 6)
                          tmp.12.26
                          (begin
                            (begin
                              (set! tmp.141
                                (call L.make-vector.91.15 make-vector.91 64))
                              (set! tmp.13.27
                                (call
                                 L.fun/ascii-char8965.16.17
                                 fun/ascii-char8965.16
                                 6
                                 tmp.141)))
                            (if (!= tmp.13.27 6)
                              tmp.13.27
                              (begin
                                (begin
                                  (set! tmp.14.28
                                    (call
                                     L.make-vector.91.15
                                     make-vector.91
                                     64))
                                  (begin
                                    (set! g43165470.29
                                      (call
                                       L.vector-set!.92.12
                                       vector-set!.92
                                       tmp.14.28
                                       0
                                       0))
                                    (if (begin
                                          (set! tmp.143
                                            (call
                                             L.error?.93.10
                                             error?.93
                                             g43165470.29))
                                          (!= tmp.143 6))
                                      (set! tmp.142 g43165470.29)
                                      (begin
                                        (set! g43165471.30
                                          (call
                                           L.vector-set!.92.12
                                           vector-set!.92
                                           tmp.14.28
                                           8
                                           8))
                                        (if (begin
                                              (set! tmp.144
                                                (call
                                                 L.error?.93.10
                                                 error?.93
                                                 g43165471.30))
                                              (!= tmp.144 6))
                                          (set! tmp.142 g43165471.30)
                                          (begin
                                            (set! g43165472.31
                                              (call
                                               L.vector-set!.92.12
                                               vector-set!.92
                                               tmp.14.28
                                               16
                                               16))
                                            (if (begin
                                                  (set! tmp.145
                                                    (call
                                                     L.error?.93.10
                                                     error?.93
                                                     g43165472.31))
                                                  (!= tmp.145 6))
                                              (set! tmp.142 g43165472.31)
                                              (begin
                                                (set! g43165473.32
                                                  (call
                                                   L.vector-set!.92.12
                                                   vector-set!.92
                                                   tmp.14.28
                                                   24
                                                   24))
                                                (if (begin
                                                      (set! tmp.146
                                                        (call
                                                         L.error?.93.10
                                                         error?.93
                                                         g43165473.32))
                                                      (!= tmp.146 6))
                                                  (set! tmp.142 g43165473.32)
                                                  (begin
                                                    (set! g43165474.33
                                                      (call
                                                       L.vector-set!.92.12
                                                       vector-set!.92
                                                       tmp.14.28
                                                       32
                                                       32))
                                                    (if (begin
                                                          (set! tmp.147
                                                            (call
                                                             L.error?.93.10
                                                             error?.93
                                                             g43165474.33))
                                                          (!= tmp.147 6))
                                                      (set! tmp.142
                                                        g43165474.33)
                                                      (begin
                                                        (set! g43165475.34
                                                          (call
                                                           L.vector-set!.92.12
                                                           vector-set!.92
                                                           tmp.14.28
                                                           40
                                                           40))
                                                        (if (begin
                                                              (set! tmp.148
                                                                (call
                                                                 L.error?.93.10
                                                                 error?.93
                                                                 g43165475.34))
                                                              (!= tmp.148 6))
                                                          (set! tmp.142
                                                            g43165475.34)
                                                          (begin
                                                            (set! g43165476.35
                                                              (call
                                                               L.vector-set!.92.12
                                                               vector-set!.92
                                                               tmp.14.28
                                                               48
                                                               48))
                                                            (if (begin
                                                                  (set! tmp.149
                                                                    (call
                                                                     L.error?.93.10
                                                                     error?.93
                                                                     g43165476.35))
                                                                  (!=
                                                                   tmp.149
                                                                   6))
                                                              (set! tmp.142
                                                                g43165476.35)
                                                              (begin
                                                                (set! g43165477.36
                                                                  (call
                                                                   L.vector-set!.92.12
                                                                   vector-set!.92
                                                                   tmp.14.28
                                                                   56
                                                                   56))
                                                                (if (begin
                                                                      (set! tmp.150
                                                                        (call
                                                                         L.error?.93.10
                                                                         error?.93
                                                                         g43165477.36))
                                                                      (!=
                                                                       tmp.150
                                                                       6))
                                                                  (set! tmp.142
                                                                    g43165477.36)
                                                                  (set! tmp.142
                                                                    tmp.14.28))))))))))))))))))
                                (call
                                 L.fun/ascii-char8966.15.16
                                 fun/ascii-char8966.15
                                 tmp.142
                                 1880))))))))))))
          (begin
            (set! ascii-char0.38 28206)
            (set! ascii-char1.37 16942)
            20270))))))
(check-by-interp
 '(module
    (define L.lam.76.12 (lambda (c.79) (begin (begin 6))))
    (define L.lam.75.11
      (lambda (c.78)
        (begin
          (set! fun/void8969.13 (mref c.78 14))
          (begin
            (set! tmp.7.17 30)
            (if (!= tmp.7.17 6)
              tmp.7.17
              (begin
                (set! tmp.8.18 (call L.fun/void8969.13.10 fun/void8969.13))
                (if (!= tmp.8.18 6)
                  tmp.8.18
                  (begin
                    (if (!= 6 6) (set! tmp.9.19 30) (set! tmp.9.19 30))
                    (if (!= tmp.9.19 6)
                      tmp.9.19
                      (begin
                        (begin (set! tmp.10.20 30))
                        (if (!= tmp.10.20 6)
                          tmp.10.20
                          (begin
                            (begin (set! tmp.11.21 30))
                            (if (!= tmp.11.21 6)
                              tmp.11.21
                              (begin
                                (if (!= 6 6)
                                  (set! tmp.12.22 30)
                                  (set! tmp.12.22 30))
                                (if (!= tmp.12.22 6)
                                  tmp.12.22
                                  (begin 30))))))))))))))))
    (define L.fun/void8969.13.10 (lambda (c.77) (begin 30)))
    (begin
      (begin
        (begin (set! tmp.83 (alloc 16)) (set! tmp.80 (+ tmp.83 2)))
        (begin
          (mset! tmp.80 -2 L.fun/void8969.13.10)
          (mset! tmp.80 6 0)
          (set! fun/void8969.13 tmp.80)))
      (begin
        (if (!= 6 6) (set! ascii-char0.16 24878) (set! ascii-char0.16 21294))
        (begin
          (begin
            (begin (set! tmp.84 (alloc 24)) (set! tmp.81 (+ tmp.84 2)))
            (begin
              (mset! tmp.81 -2 L.lam.75.11)
              (mset! tmp.81 6 0)
              (set! lam.75 tmp.81)))
          (begin
            (mset! lam.75 14 fun/void8969.13)
            (set! procedure1.15 lam.75)))
        (begin
          (begin
            (begin (set! tmp.85 (alloc 16)) (set! tmp.82 (+ tmp.85 2)))
            (begin
              (mset! tmp.82 -2 L.lam.76.12)
              (mset! tmp.82 6 0)
              (set! lam.76 tmp.82)))
          (set! procedure2.14 lam.76))
        (if (!= 14 6) 60734 574)))))
(check-by-interp
 '(module
    (define L.fun/boolean8972.9.12
      (lambda (c.67)
        (begin
          (set! fun/boolean8973.8 (mref c.67 14))
          (begin
            (if (!= 6 6)
              (begin
                (begin
                  (begin (set! tmp.76 (alloc 16)) (set! tmp.70 (+ tmp.76 2)))
                  (begin
                    (mset! tmp.70 -2 L.lam.63.13)
                    (mset! tmp.70 6 0)
                    (set! lam.63 tmp.70)))
                (set! tmp.75 lam.63))
              (begin
                (begin
                  (begin (set! tmp.77 (alloc 16)) (set! tmp.71 (+ tmp.77 2)))
                  (begin
                    (mset! tmp.71 -2 L.lam.64.14)
                    (mset! tmp.71 6 0)
                    (set! lam.64 tmp.71)))
                (set! tmp.75 lam.64)))
            (call L.fun/boolean8973.8.11 fun/boolean8973.8 tmp.75)))))
    (define L.lam.64.14 (lambda (c.69) (begin 7736)))
    (define L.lam.63.13 (lambda (c.68) (begin 4552)))
    (define L.fun/boolean8973.8.11
      (lambda (c.66 oprand0.10)
        (begin
          (set! fun/boolean8974.7 (mref c.66 14))
          (call L.fun/boolean8974.7.10 fun/boolean8974.7))))
    (define L.fun/boolean8974.7.10 (lambda (c.65) (begin 14)))
    (begin
      (begin
        (begin (set! tmp.78 (alloc 16)) (set! tmp.72 (+ tmp.78 2)))
        (begin
          (mset! tmp.72 -2 L.fun/boolean8974.7.10)
          (mset! tmp.72 6 0)
          (set! fun/boolean8974.7 tmp.72)))
      (begin
        (begin (set! tmp.79 (alloc 24)) (set! tmp.73 (+ tmp.79 2)))
        (begin
          (mset! tmp.73 -2 L.fun/boolean8973.8.11)
          (mset! tmp.73 6 8)
          (set! fun/boolean8973.8 tmp.73)))
      (begin
        (begin (set! tmp.80 (alloc 24)) (set! tmp.74 (+ tmp.80 2)))
        (begin
          (mset! tmp.74 -2 L.fun/boolean8972.9.12)
          (mset! tmp.74 6 0)
          (set! fun/boolean8972.9 tmp.74)))
      (begin
        (mset! fun/boolean8973.8 14 fun/boolean8974.7)
        (mset! fun/boolean8972.9 14 fun/boolean8973.8)
        (call L.fun/boolean8972.9.12 fun/boolean8972.9)))))
(check-by-interp
 '(module
    (define L.fun/void8981.14.23 (lambda (c.105) (begin 30)))
    (define L.fun/void8980.13.22
      (lambda (c.104)
        (begin
          (set! fun/void8981.14 (mref c.104 14))
          (call L.fun/void8981.14.23 fun/void8981.14))))
    (define L.fun/void8977.12.21 (lambda (c.103) (begin 30)))
    (define L.fun/void8979.11.20
      (lambda (c.102 oprand0.17 oprand1.16)
        (begin
          (set! fun/void8980.13 (mref c.102 14))
          (call L.fun/void8980.13.22 fun/void8980.13))))
    (define L.fun/procedure8982.10.19
      (lambda (c.100)
        (begin
          (begin
            (begin
              (begin
                (begin (set! tmp.123 (alloc 16)) (set! tmp.106 (+ tmp.123 2)))
                (begin
                  (mset! tmp.106 -2 L.lam.90.24)
                  (mset! tmp.106 6 0)
                  (set! lam.90 tmp.106)))
              lam.90)))))
    (define L.lam.90.24 (lambda (c.101) (begin 6760)))
    (define L.fun/boolean8978.9.18 (lambda (c.99 oprand0.15) (begin 14)))
    (define L.cons.85.17
      (lambda (c.98 tmp.80 tmp.81)
        (begin
          (begin
            (begin (set! tmp.124 (alloc 16)) (set! tmp.107 (+ tmp.124 1)))
            (begin
              (mset! tmp.107 -1 tmp.80)
              (mset! tmp.107 7 tmp.81)
              tmp.107)))))
    (define L.pair?.86.16
      (lambda (c.97 tmp.76)
        (begin
          (if (begin (set! tmp.125 (bitwise-and tmp.76 7)) (= tmp.125 1))
            14
            6))))
    (define L.make-vector.87.15
      (lambda (c.96 tmp.61)
        (begin
          (set! make-init-vector.4 (mref c.96 14))
          (if (begin
                (if (begin (set! tmp.127 (bitwise-and tmp.61 7)) (= tmp.127 0))
                  (set! tmp.126 14)
                  (set! tmp.126 6))
                (!= tmp.126 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.61)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.95 tmp.33)
        (begin
          (set! vector-init-loop.35 (mref c.95 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.131 (arithmetic-shift-right tmp.33 3))
                      (set! tmp.130 (+ 1 tmp.131)))
                    (set! tmp.129 (* tmp.130 8)))
                  (set! tmp.128 (alloc tmp.129)))
                (set! tmp.108 (+ tmp.128 3)))
              (begin (mset! tmp.108 -3 tmp.33) (set! tmp.34 tmp.108)))
            (call
             L.vector-init-loop.35.13
             vector-init-loop.35
             tmp.33
             0
             tmp.34)))))
    (define L.vector-init-loop.35.13
      (lambda (c.94 len.36 i.38 vec.37)
        (begin
          (set! vector-init-loop.35 (mref c.94 14))
          (if (begin
                (if (= len.36 i.38) (set! tmp.132 14) (set! tmp.132 6))
                (!= tmp.132 6))
            vec.37
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.135 (arithmetic-shift-right i.38 3))
                    (set! tmp.134 (* tmp.135 8)))
                  (set! tmp.133 (+ tmp.134 5)))
                (mset! vec.37 tmp.133 0))
              (begin
                (set! tmp.136 (+ i.38 8))
                (call
                 L.vector-init-loop.35.13
                 vector-init-loop.35
                 len.36
                 tmp.136
                 vec.37)))))))
    (define L.vector-set!.88.12
      (lambda (c.93 tmp.63 tmp.64 tmp.65)
        (begin
          (set! unsafe-vector-set!.5 (mref c.93 14))
          (if (begin
                (if (begin (set! tmp.138 (bitwise-and tmp.64 7)) (= tmp.138 0))
                  (set! tmp.137 14)
                  (set! tmp.137 6))
                (!= tmp.137 6))
            (if (begin
                  (if (begin
                        (set! tmp.140 (bitwise-and tmp.63 7))
                        (= tmp.140 3))
                    (set! tmp.139 14)
                    (set! tmp.139 6))
                  (!= tmp.139 6))
              (call
               L.unsafe-vector-set!.5.11
               unsafe-vector-set!.5
               tmp.63
               tmp.64
               tmp.65)
              2622)
            2622))))
    (define L.unsafe-vector-set!.5.11
      (lambda (c.92 tmp.39 tmp.40 tmp.41)
        (begin
          (if (begin
                (if (begin (set! tmp.142 (mref tmp.39 -3)) (< tmp.40 tmp.142))
                  (set! tmp.141 14)
                  (set! tmp.141 6))
                (!= tmp.141 6))
            (if (begin
                  (if (>= tmp.40 0) (set! tmp.143 14) (set! tmp.143 6))
                  (!= tmp.143 6))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.146 (arithmetic-shift-right tmp.40 3))
                      (set! tmp.145 (* tmp.146 8)))
                    (set! tmp.144 (+ tmp.145 5)))
                  (mset! tmp.39 tmp.144 tmp.41))
                30)
              2622)
            2622))))
    (define L.error?.89.10
      (lambda (c.91 tmp.75)
        (begin
          (if (begin (set! tmp.147 (bitwise-and tmp.75 255)) (= tmp.147 62))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.148 (alloc 16)) (set! tmp.109 (+ tmp.148 2)))
        (begin
          (mset! tmp.109 -2 L.error?.89.10)
          (mset! tmp.109 6 8)
          (set! error?.89 tmp.109)))
      (begin
        (begin (set! tmp.149 (alloc 16)) (set! tmp.110 (+ tmp.149 2)))
        (begin
          (mset! tmp.110 -2 L.unsafe-vector-set!.5.11)
          (mset! tmp.110 6 24)
          (set! unsafe-vector-set!.5 tmp.110)))
      (begin
        (begin (set! tmp.150 (alloc 24)) (set! tmp.111 (+ tmp.150 2)))
        (begin
          (mset! tmp.111 -2 L.vector-set!.88.12)
          (mset! tmp.111 6 24)
          (set! vector-set!.88 tmp.111)))
      (begin
        (begin (set! tmp.151 (alloc 24)) (set! tmp.112 (+ tmp.151 2)))
        (begin
          (mset! tmp.112 -2 L.vector-init-loop.35.13)
          (mset! tmp.112 6 24)
          (set! vector-init-loop.35 tmp.112)))
      (begin
        (begin (set! tmp.152 (alloc 24)) (set! tmp.113 (+ tmp.152 2)))
        (begin
          (mset! tmp.113 -2 L.make-init-vector.4.14)
          (mset! tmp.113 6 8)
          (set! make-init-vector.4 tmp.113)))
      (begin
        (begin (set! tmp.153 (alloc 24)) (set! tmp.114 (+ tmp.153 2)))
        (begin
          (mset! tmp.114 -2 L.make-vector.87.15)
          (mset! tmp.114 6 8)
          (set! make-vector.87 tmp.114)))
      (begin
        (begin (set! tmp.154 (alloc 16)) (set! tmp.115 (+ tmp.154 2)))
        (begin
          (mset! tmp.115 -2 L.pair?.86.16)
          (mset! tmp.115 6 8)
          (set! pair?.86 tmp.115)))
      (begin
        (begin (set! tmp.155 (alloc 16)) (set! tmp.116 (+ tmp.155 2)))
        (begin
          (mset! tmp.116 -2 L.cons.85.17)
          (mset! tmp.116 6 16)
          (set! cons.85 tmp.116)))
      (begin
        (begin (set! tmp.156 (alloc 16)) (set! tmp.117 (+ tmp.156 2)))
        (begin
          (mset! tmp.117 -2 L.fun/boolean8978.9.18)
          (mset! tmp.117 6 8)
          (set! fun/boolean8978.9 tmp.117)))
      (begin
        (begin (set! tmp.157 (alloc 16)) (set! tmp.118 (+ tmp.157 2)))
        (begin
          (mset! tmp.118 -2 L.fun/procedure8982.10.19)
          (mset! tmp.118 6 0)
          (set! fun/procedure8982.10 tmp.118)))
      (begin
        (begin (set! tmp.158 (alloc 24)) (set! tmp.119 (+ tmp.158 2)))
        (begin
          (mset! tmp.119 -2 L.fun/void8979.11.20)
          (mset! tmp.119 6 16)
          (set! fun/void8979.11 tmp.119)))
      (begin
        (begin (set! tmp.159 (alloc 16)) (set! tmp.120 (+ tmp.159 2)))
        (begin
          (mset! tmp.120 -2 L.fun/void8977.12.21)
          (mset! tmp.120 6 0)
          (set! fun/void8977.12 tmp.120)))
      (begin
        (begin (set! tmp.160 (alloc 24)) (set! tmp.121 (+ tmp.160 2)))
        (begin
          (mset! tmp.121 -2 L.fun/void8980.13.22)
          (mset! tmp.121 6 0)
          (set! fun/void8980.13 tmp.121)))
      (begin
        (begin (set! tmp.161 (alloc 16)) (set! tmp.122 (+ tmp.161 2)))
        (begin
          (mset! tmp.122 -2 L.fun/void8981.14.23)
          (mset! tmp.122 6 0)
          (set! fun/void8981.14 tmp.122)))
      (begin
        (mset! vector-set!.88 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.35 14 vector-init-loop.35)
        (mset! make-init-vector.4 14 vector-init-loop.35)
        (mset! make-vector.87 14 make-init-vector.4)
        (mset! fun/void8979.11 14 fun/void8980.13)
        (mset! fun/void8980.13 14 fun/void8981.14)
        (if (begin
              (set! void0.20 (call L.fun/void8977.12.21 fun/void8977.12))
              (begin
                (begin
                  (set! tmp.163 (call L.cons.85.17 cons.85 4008 22))
                  (set! tmp.162 (call L.cons.85.17 cons.85 560 tmp.163)))
                (set! boolean1.19 (call L.pair?.86.16 pair?.86 tmp.162)))
              (if (!= 14 6) (set! empty2.18 22) (set! empty2.18 22))
              (if (!= 14 6) (!= 30 6) (!= 30 6)))
          (if (if (begin
                    (set! tmp.164
                      (call L.fun/boolean8978.9.18 fun/boolean8978.9 20526))
                    (!= tmp.164 6))
                (if (!= 6 6) (!= 30 6) (!= 30 6))
                (begin
                  (set! tmp.7.21 30)
                  (if (!= tmp.7.21 6) (!= tmp.7.21 6) (!= 30 6))))
            (begin
              (begin
                (set! fixnum0.23 512)
                (set! empty1.22 22)
                (begin
                  (set! tmp.8.24 (call L.make-vector.87.15 make-vector.87 64))
                  (begin
                    (set! g43176926.25
                      (call L.vector-set!.88.12 vector-set!.88 tmp.8.24 0 8))
                    (if (begin
                          (set! tmp.166
                            (call L.error?.89.10 error?.89 g43176926.25))
                          (!= tmp.166 6))
                      (set! tmp.165 g43176926.25)
                      (begin
                        (set! g43176927.26
                          (call
                           L.vector-set!.88.12
                           vector-set!.88
                           tmp.8.24
                           8
                           16))
                        (if (begin
                              (set! tmp.167
                                (call L.error?.89.10 error?.89 g43176927.26))
                              (!= tmp.167 6))
                          (set! tmp.165 g43176927.26)
                          (begin
                            (set! g43176928.27
                              (call
                               L.vector-set!.88.12
                               vector-set!.88
                               tmp.8.24
                               16
                               24))
                            (if (begin
                                  (set! tmp.168
                                    (call
                                     L.error?.89.10
                                     error?.89
                                     g43176928.27))
                                  (!= tmp.168 6))
                              (set! tmp.165 g43176928.27)
                              (begin
                                (set! g43176929.28
                                  (call
                                   L.vector-set!.88.12
                                   vector-set!.88
                                   tmp.8.24
                                   24
                                   32))
                                (if (begin
                                      (set! tmp.169
                                        (call
                                         L.error?.89.10
                                         error?.89
                                         g43176929.28))
                                      (!= tmp.169 6))
                                  (set! tmp.165 g43176929.28)
                                  (begin
                                    (set! g43176930.29
                                      (call
                                       L.vector-set!.88.12
                                       vector-set!.88
                                       tmp.8.24
                                       32
                                       40))
                                    (if (begin
                                          (set! tmp.170
                                            (call
                                             L.error?.89.10
                                             error?.89
                                             g43176930.29))
                                          (!= tmp.170 6))
                                      (set! tmp.165 g43176930.29)
                                      (begin
                                        (set! g43176931.30
                                          (call
                                           L.vector-set!.88.12
                                           vector-set!.88
                                           tmp.8.24
                                           40
                                           48))
                                        (if (begin
                                              (set! tmp.171
                                                (call
                                                 L.error?.89.10
                                                 error?.89
                                                 g43176931.30))
                                              (!= tmp.171 6))
                                          (set! tmp.165 g43176931.30)
                                          (begin
                                            (set! g43176932.31
                                              (call
                                               L.vector-set!.88.12
                                               vector-set!.88
                                               tmp.8.24
                                               48
                                               56))
                                            (if (begin
                                                  (set! tmp.172
                                                    (call
                                                     L.error?.89.10
                                                     error?.89
                                                     g43176932.31))
                                                  (!= tmp.172 6))
                                              (set! tmp.165 g43176932.31)
                                              (begin
                                                (set! g43176933.32
                                                  (call
                                                   L.vector-set!.88.12
                                                   vector-set!.88
                                                   tmp.8.24
                                                   56
                                                   64))
                                                (if (begin
                                                      (set! tmp.173
                                                        (call
                                                         L.error?.89.10
                                                         error?.89
                                                         g43176933.32))
                                                      (!= tmp.173 6))
                                                  (set! tmp.165 g43176933.32)
                                                  (set! tmp.165
                                                    tmp.8.24)))))))))))))))))))
              (begin
                (set! tmp.174
                  (call L.fun/procedure8982.10.19 fun/procedure8982.10))
                (call L.fun/void8979.11.20 fun/void8979.11 tmp.165 tmp.174)))
            6)
          6)))))
(check-by-interp
 '(module
    (define L.lam.74.14 (lambda (c.79) (begin 30254)))
    (define L.fun/fixnum8985.7.13 (lambda (c.78 oprand0.8) (begin 184)))
    (define L.cons.71.12
      (lambda (c.77 tmp.66 tmp.67)
        (begin
          (begin
            (begin (set! tmp.86 (alloc 16)) (set! tmp.80 (+ tmp.86 1)))
            (begin (mset! tmp.80 -1 tmp.66) (mset! tmp.80 7 tmp.67) tmp.80)))))
    (define L.error?.72.11
      (lambda (c.76 tmp.61)
        (begin
          (if (begin (set! tmp.87 (bitwise-and tmp.61 255)) (= tmp.87 62))
            14
            6))))
    (define L.>.73.10
      (lambda (c.75 tmp.43 tmp.44)
        (begin
          (if (begin
                (if (begin (set! tmp.89 (bitwise-and tmp.44 7)) (= tmp.89 0))
                  (set! tmp.88 14)
                  (set! tmp.88 6))
                (!= tmp.88 6))
            (if (begin
                  (if (begin (set! tmp.91 (bitwise-and tmp.43 7)) (= tmp.91 0))
                    (set! tmp.90 14)
                    (set! tmp.90 6))
                  (!= tmp.90 6))
              (if (> tmp.43 tmp.44) 14 6)
              1598)
            1598))))
    (begin
      (begin
        (begin (set! tmp.92 (alloc 16)) (set! tmp.81 (+ tmp.92 2)))
        (begin
          (mset! tmp.81 -2 L.>.73.10)
          (mset! tmp.81 6 16)
          (set! >.73 tmp.81)))
      (begin
        (begin (set! tmp.93 (alloc 16)) (set! tmp.82 (+ tmp.93 2)))
        (begin
          (mset! tmp.82 -2 L.error?.72.11)
          (mset! tmp.82 6 8)
          (set! error?.72 tmp.82)))
      (begin
        (begin (set! tmp.94 (alloc 16)) (set! tmp.83 (+ tmp.94 2)))
        (begin
          (mset! tmp.83 -2 L.cons.71.12)
          (mset! tmp.83 6 16)
          (set! cons.71 tmp.83)))
      (begin
        (begin (set! tmp.95 (alloc 16)) (set! tmp.84 (+ tmp.95 2)))
        (begin
          (mset! tmp.84 -2 L.fun/fixnum8985.7.13)
          (mset! tmp.84 6 8)
          (set! fun/fixnum8985.7 tmp.84)))
      (if (begin
            (begin
              (begin
                (begin
                  (set! tmp.99 (call L.cons.71.12 cons.71 3184 22))
                  (set! tmp.98 (call L.cons.71.12 cons.71 1400 tmp.99)))
                (set! tmp.97
                  (call L.fun/fixnum8985.7.13 fun/fixnum8985.7 tmp.98)))
              (begin
                (begin
                  (set! g43180749.9 168)
                  (if (begin
                        (set! tmp.101
                          (call L.error?.72.11 error?.72 g43180749.9))
                        (!= tmp.101 6))
                    (set! tmp.100 g43180749.9)
                    (begin
                      (set! g43180750.10 1944)
                      (if (begin
                            (set! tmp.102
                              (call L.error?.72.11 error?.72 g43180750.10))
                            (!= tmp.102 6))
                        (set! tmp.100 g43180750.10)
                        (begin
                          (set! g43180751.11 1968)
                          (if (begin
                                (set! tmp.103
                                  (call L.error?.72.11 error?.72 g43180751.11))
                                (!= tmp.103 6))
                            (set! tmp.100 g43180751.11)
                            (begin
                              (set! g43180752.12 1072)
                              (if (begin
                                    (set! tmp.104
                                      (call
                                       L.error?.72.11
                                       error?.72
                                       g43180752.12))
                                    (!= tmp.104 6))
                                (set! tmp.100 g43180752.12)
                                (begin
                                  (set! g43180753.13 1144)
                                  (if (begin
                                        (set! tmp.105
                                          (call
                                           L.error?.72.11
                                           error?.72
                                           g43180753.13))
                                        (!= tmp.105 6))
                                    (set! tmp.100 g43180753.13)
                                    (begin
                                      (set! g43180754.14 1288)
                                      (if (begin
                                            (set! tmp.106
                                              (call
                                               L.error?.72.11
                                               error?.72
                                               g43180754.14))
                                            (!= tmp.106 6))
                                        (set! tmp.100 g43180754.14)
                                        (set! tmp.100 296)))))))))))))
                (set! tmp.96 (call L.>.73.10 >.73 tmp.97 tmp.100))))
            (!= tmp.96 6))
        (begin
          (begin
            (set! tmp.107 (call L.cons.71.12 cons.71 4072 22))
            (set! pair0.15 (call L.cons.71.12 cons.71 1048 tmp.107)))
          30)
        (begin
          (begin
            (begin
              (begin (set! tmp.108 (alloc 16)) (set! tmp.85 (+ tmp.108 2)))
              (begin
                (mset! tmp.85 -2 L.lam.74.14)
                (mset! tmp.85 6 0)
                (set! lam.74 tmp.85)))
            (set! procedure0.18 lam.74))
          (set! fixnum1.17 1448)
          (begin
            (set! tmp.109 (call L.cons.71.12 cons.71 3200 22))
            (set! pair2.16 (call L.cons.71.12 cons.71 304 tmp.109)))
          30)))))
(check-by-interp
 '(module
    (define L.fun/void8990.9.13 (lambda (c.68 oprand0.11) (begin 30)))
    (define L.fun/boolean8989.8.12 (lambda (c.67 oprand0.10) (begin 6)))
    (define L.fun/void8988.7.11
      (lambda (c.66)
        (begin
          (set! fun/void8990.9 (mref c.66 14))
          (set! cons.64 (mref c.66 22))
          (set! fun/boolean8989.8 (mref c.66 30))
          (if (begin
                (begin
                  (begin
                    (set! tmp.76 (call L.cons.64.10 cons.64 2768 22))
                    (set! tmp.75 (call L.cons.64.10 cons.64 1864 tmp.76)))
                  (set! tmp.74
                    (call L.fun/boolean8989.8.12 fun/boolean8989.8 tmp.75)))
                (!= tmp.74 6))
            (call L.fun/void8990.9.13 fun/void8990.9 592)
            (if (!= 6 6) 30 30)))))
    (define L.cons.64.10
      (lambda (c.65 tmp.59 tmp.60)
        (begin
          (begin
            (begin (set! tmp.77 (alloc 16)) (set! tmp.69 (+ tmp.77 1)))
            (begin (mset! tmp.69 -1 tmp.59) (mset! tmp.69 7 tmp.60) tmp.69)))))
    (begin
      (begin
        (begin (set! tmp.78 (alloc 16)) (set! tmp.70 (+ tmp.78 2)))
        (begin
          (mset! tmp.70 -2 L.cons.64.10)
          (mset! tmp.70 6 16)
          (set! cons.64 tmp.70)))
      (begin
        (begin (set! tmp.79 (alloc 40)) (set! tmp.71 (+ tmp.79 2)))
        (begin
          (mset! tmp.71 -2 L.fun/void8988.7.11)
          (mset! tmp.71 6 0)
          (set! fun/void8988.7 tmp.71)))
      (begin
        (begin (set! tmp.80 (alloc 16)) (set! tmp.72 (+ tmp.80 2)))
        (begin
          (mset! tmp.72 -2 L.fun/boolean8989.8.12)
          (mset! tmp.72 6 8)
          (set! fun/boolean8989.8 tmp.72)))
      (begin
        (begin (set! tmp.81 (alloc 16)) (set! tmp.73 (+ tmp.81 2)))
        (begin
          (mset! tmp.73 -2 L.fun/void8990.9.13)
          (mset! tmp.73 6 8)
          (set! fun/void8990.9 tmp.73)))
      (begin
        (mset! fun/void8988.7 14 fun/void8990.9)
        (mset! fun/void8988.7 22 cons.64)
        (mset! fun/void8988.7 30 fun/boolean8989.8)
        (call L.fun/void8988.7.11 fun/void8988.7)))))
(check-by-interp
 '(module
    (define L.lam.63.12 (lambda (c.66) (begin 4496)))
    (define L.fun/fixnum8994.8.11
      (lambda (c.65) (begin (if (!= 6 6) 656 1680))))
    (define L.fun/fixnum8993.7.10
      (lambda (c.64 oprand0.9)
        (begin
          (set! fun/fixnum8994.8 (mref c.64 14))
          (call L.fun/fixnum8994.8.11 fun/fixnum8994.8))))
    (begin
      (begin
        (begin (set! tmp.70 (alloc 24)) (set! tmp.67 (+ tmp.70 2)))
        (begin
          (mset! tmp.67 -2 L.fun/fixnum8993.7.10)
          (mset! tmp.67 6 8)
          (set! fun/fixnum8993.7 tmp.67)))
      (begin
        (begin (set! tmp.71 (alloc 16)) (set! tmp.68 (+ tmp.71 2)))
        (begin
          (mset! tmp.68 -2 L.fun/fixnum8994.8.11)
          (mset! tmp.68 6 0)
          (set! fun/fixnum8994.8 tmp.68)))
      (begin
        (mset! fun/fixnum8993.7 14 fun/fixnum8994.8)
        (begin
          (begin
            (begin
              (set! empty0.10 22)
              (begin
                (begin
                  (begin (set! tmp.73 (alloc 16)) (set! tmp.69 (+ tmp.73 2)))
                  (begin
                    (mset! tmp.69 -2 L.lam.63.12)
                    (mset! tmp.69 6 0)
                    (set! lam.63 tmp.69)))
                (set! tmp.72 lam.63))))
          (call L.fun/fixnum8993.7.10 fun/fixnum8993.7 tmp.72))))))
(check-by-interp
 '(module
    (define L.fun/procedure9000.12.15
      (lambda (c.74 oprand0.14)
        (begin
          (if (!= oprand0.14 6)
            (begin
              (begin
                (begin (set! tmp.85 (alloc 16)) (set! tmp.77 (+ tmp.85 2)))
                (begin
                  (mset! tmp.77 -2 L.lam.67.16)
                  (mset! tmp.77 6 0)
                  (set! lam.67 tmp.77)))
              lam.67)
            (begin
              (begin
                (begin (set! tmp.86 (alloc 16)) (set! tmp.78 (+ tmp.86 2)))
                (begin
                  (mset! tmp.78 -2 L.lam.68.17)
                  (mset! tmp.78 6 0)
                  (set! lam.68 tmp.78)))
              lam.68)))))
    (define L.lam.68.17 (lambda (c.76) (begin 4200)))
    (define L.lam.67.16 (lambda (c.75) (begin 4864)))
    (define L.fun/boolean9001.11.14
      (lambda (c.73)
        (begin
          (set! fun/boolean9002.9 (mref c.73 14))
          (call L.fun/boolean9002.9.12 fun/boolean9002.9))))
    (define L.fun/error8997.10.13
      (lambda (c.72 oprand0.13)
        (begin
          (set! fun/error8998.7 (mref c.72 14))
          (call L.fun/error8998.7.10 fun/error8998.7))))
    (define L.fun/boolean9002.9.12 (lambda (c.71) (begin 14)))
    (define L.fun/error8999.8.11 (lambda (c.70) (begin 22334)))
    (define L.fun/error8998.7.10
      (lambda (c.69)
        (begin
          (set! fun/error8999.8 (mref c.69 14))
          (call L.fun/error8999.8.11 fun/error8999.8))))
    (begin
      (begin
        (begin (set! tmp.87 (alloc 24)) (set! tmp.79 (+ tmp.87 2)))
        (begin
          (mset! tmp.79 -2 L.fun/error8998.7.10)
          (mset! tmp.79 6 0)
          (set! fun/error8998.7 tmp.79)))
      (begin
        (begin (set! tmp.88 (alloc 16)) (set! tmp.80 (+ tmp.88 2)))
        (begin
          (mset! tmp.80 -2 L.fun/error8999.8.11)
          (mset! tmp.80 6 0)
          (set! fun/error8999.8 tmp.80)))
      (begin
        (begin (set! tmp.89 (alloc 16)) (set! tmp.81 (+ tmp.89 2)))
        (begin
          (mset! tmp.81 -2 L.fun/boolean9002.9.12)
          (mset! tmp.81 6 0)
          (set! fun/boolean9002.9 tmp.81)))
      (begin
        (begin (set! tmp.90 (alloc 24)) (set! tmp.82 (+ tmp.90 2)))
        (begin
          (mset! tmp.82 -2 L.fun/error8997.10.13)
          (mset! tmp.82 6 8)
          (set! fun/error8997.10 tmp.82)))
      (begin
        (begin (set! tmp.91 (alloc 24)) (set! tmp.83 (+ tmp.91 2)))
        (begin
          (mset! tmp.83 -2 L.fun/boolean9001.11.14)
          (mset! tmp.83 6 0)
          (set! fun/boolean9001.11 tmp.83)))
      (begin
        (begin (set! tmp.92 (alloc 16)) (set! tmp.84 (+ tmp.92 2)))
        (begin
          (mset! tmp.84 -2 L.fun/procedure9000.12.15)
          (mset! tmp.84 6 8)
          (set! fun/procedure9000.12 tmp.84)))
      (begin
        (mset! fun/error8998.7 14 fun/error8999.8)
        (mset! fun/error8997.10 14 fun/error8998.7)
        (mset! fun/boolean9001.11 14 fun/boolean9002.9)
        (begin
          (begin
            (set! tmp.94 (call L.fun/boolean9001.11.14 fun/boolean9001.11))
            (set! tmp.93
              (call L.fun/procedure9000.12.15 fun/procedure9000.12 tmp.94)))
          (call L.fun/error8997.10.13 fun/error8997.10 tmp.93))))))
