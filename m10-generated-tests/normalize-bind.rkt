#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         cpsc411/langs/v9
         cpsc411/langs/v11
         "../normalize-bind.rkt")
(define (fail-if-invalid p)
  (when (not (proc-imp-cmf-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "proc-imp-cmf-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-imp-mf-lang-v8 p)
  (interp-proc-imp-cmf-lang-v8 (fail-if-invalid (normalize-bind p)))))

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
      (set! fun/fixnum8485.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/fixnum8485.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
      (call L.fun/fixnum8485.7.10 fun/fixnum8485.7))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8488.7.10 (lambda (c.60) (begin 16686)))
    (begin
      (set! fun/ascii-char8488.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/ascii-char8488.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
      (call L.fun/ascii-char8488.7.10 fun/ascii-char8488.7))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8491.7.10 (lambda (c.60) (begin 23086)))
    (begin
      (set! fun/ascii-char8491.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/ascii-char8491.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
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
      (set! fun/empty8500.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/empty8500.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
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
                (set! tmp.102
                  (if (begin
                        (set! tmp.103 (bitwise-and tmp.57 7))
                        (= tmp.103 0))
                    14
                    6))
                (!= tmp.102 6))
            (call L.make-init-vector.4.13 make-init-vector.4 tmp.57)
            2110))))
    (define L.make-init-vector.4.13
      (lambda (c.87 tmp.29)
        (begin
          (set! vector-init-loop.31 (mref c.87 14))
          (begin
            (set! tmp.30
              (begin
                (set! tmp.92
                  (begin
                    (set! tmp.104
                      (begin
                        (set! tmp.105
                          (begin
                            (set! tmp.106
                              (begin
                                (set! tmp.107
                                  (arithmetic-shift-right tmp.29 3))
                                (+ 1 tmp.107)))
                            (* tmp.106 8)))
                        (alloc tmp.105)))
                    (+ tmp.104 3)))
                (begin (mset! tmp.92 -3 tmp.29) tmp.92)))
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
          (if (begin (set! tmp.108 (if (= len.32 i.34) 14 6)) (!= tmp.108 6))
            vec.33
            (begin
              (begin
                (set! tmp.109
                  (begin
                    (set! tmp.110
                      (begin
                        (set! tmp.111 (arithmetic-shift-right i.34 3))
                        (* tmp.111 8)))
                    (+ tmp.110 5)))
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
                (set! tmp.113
                  (if (begin
                        (set! tmp.114 (bitwise-and tmp.60 7))
                        (= tmp.114 0))
                    14
                    6))
                (!= tmp.113 6))
            (if (begin
                  (set! tmp.115
                    (if (begin
                          (set! tmp.116 (bitwise-and tmp.59 7))
                          (= tmp.116 3))
                      14
                      6))
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
                (set! tmp.117
                  (if (begin
                        (set! tmp.118 (mref tmp.35 -3))
                        (< tmp.36 tmp.118))
                    14
                    6))
                (!= tmp.117 6))
            (if (begin (set! tmp.119 (if (>= tmp.36 0) 14 6)) (!= tmp.119 6))
              (begin
                (begin
                  (set! tmp.120
                    (begin
                      (set! tmp.121
                        (begin
                          (set! tmp.122 (arithmetic-shift-right tmp.36 3))
                          (* tmp.122 8)))
                      (+ tmp.121 5)))
                  (mset! tmp.35 tmp.120 tmp.37))
                30)
              2622)
            2622))))
    (begin
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.93 (begin (set! tmp.123 (alloc 16)) (+ tmp.123 2)))
          (begin
            (mset! tmp.93 -2 L.unsafe-vector-set!.5.10)
            (mset! tmp.93 6 24)
            tmp.93)))
      (set! vector-set!.83
        (begin
          (set! tmp.94 (begin (set! tmp.124 (alloc 24)) (+ tmp.124 2)))
          (begin
            (mset! tmp.94 -2 L.vector-set!.83.11)
            (mset! tmp.94 6 24)
            tmp.94)))
      (set! vector-init-loop.31
        (begin
          (set! tmp.95 (begin (set! tmp.125 (alloc 24)) (+ tmp.125 2)))
          (begin
            (mset! tmp.95 -2 L.vector-init-loop.31.12)
            (mset! tmp.95 6 24)
            tmp.95)))
      (set! make-init-vector.4
        (begin
          (set! tmp.96 (begin (set! tmp.126 (alloc 24)) (+ tmp.126 2)))
          (begin
            (mset! tmp.96 -2 L.make-init-vector.4.13)
            (mset! tmp.96 6 8)
            tmp.96)))
      (set! make-vector.82
        (begin
          (set! tmp.97 (begin (set! tmp.127 (alloc 24)) (+ tmp.127 2)))
          (begin
            (mset! tmp.97 -2 L.make-vector.82.14)
            (mset! tmp.97 6 8)
            tmp.97)))
      (set! error?.81
        (begin
          (set! tmp.98 (begin (set! tmp.128 (alloc 16)) (+ tmp.128 2)))
          (begin (mset! tmp.98 -2 L.error?.81.15) (mset! tmp.98 6 8) tmp.98)))
      (set! fun/void8514.8
        (begin
          (set! tmp.99 (begin (set! tmp.129 (alloc 16)) (+ tmp.129 2)))
          (begin
            (mset! tmp.99 -2 L.fun/void8514.8.16)
            (mset! tmp.99 6 0)
            tmp.99)))
      (set! fun/void8513.9
        (begin
          (set! tmp.100 (begin (set! tmp.130 (alloc 16)) (+ tmp.130 2)))
          (begin
            (mset! tmp.100 -2 L.fun/void8513.9.17)
            (mset! tmp.100 6 0)
            tmp.100)))
      (begin
        (mset! vector-set!.83 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.31 14 vector-init-loop.31)
        (mset! make-init-vector.4 14 vector-init-loop.31)
        (mset! make-vector.82 14 make-init-vector.4)
        (begin
          (set! g42771912.10 (if (!= 6 6) 30 30))
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
                  (set! g42771914.12
                    (begin
                      (set! vector0.13
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
                                    (call
                                     L.error?.81.15
                                     error?.81
                                     g42771915.15))
                                  (!= tmp.133 6))
                              g42771915.15
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
                                  g42771916.16
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
                                      g42771917.17
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
                                          g42771918.18
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
                                              g42771919.19
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
                                                  g42771920.20
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
                                                      g42771921.21
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
                                                          g42771922.22
                                                          tmp.7.14))))))))))))))))))
                      30))
                  (if (begin
                        (set! tmp.141
                          (call L.error?.81.15 error?.81 g42771914.12))
                        (!= tmp.141 6))
                    g42771914.12
                    (begin
                      (set! g42771923.23
                        (begin
                          (set! g42771924.24 30)
                          (if (begin
                                (set! tmp.142
                                  (call L.error?.81.15 error?.81 g42771924.24))
                                (!= tmp.142 6))
                            g42771924.24
                            (begin
                              (set! g42771925.25 30)
                              (if (begin
                                    (set! tmp.143
                                      (call
                                       L.error?.81.15
                                       error?.81
                                       g42771925.25))
                                    (!= tmp.143 6))
                                g42771925.25
                                (begin
                                  (set! g42771926.26 30)
                                  (if (begin
                                        (set! tmp.144
                                          (call
                                           L.error?.81.15
                                           error?.81
                                           g42771926.26))
                                        (!= tmp.144 6))
                                    g42771926.26
                                    30)))))))
                      (if (begin
                            (set! tmp.145
                              (call L.error?.81.15 error?.81 g42771923.23))
                            (!= tmp.145 6))
                        g42771923.23
                        (begin
                          (set! g42771927.27 (begin 30))
                          (if (begin
                                (set! tmp.146
                                  (call L.error?.81.15 error?.81 g42771927.27))
                                (!= tmp.146 6))
                            g42771927.27
                            (begin
                              (set! g42771928.28 (begin 30))
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
      (set! fun/empty8524.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/empty8524.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
      (call L.fun/empty8524.7.10 fun/empty8524.7))))
(check-by-interp '(module (if (!= 14 6) 22 22)))
(check-by-interp '(module (begin (set! fixnum0.7 264) 14)))
(check-by-interp
 '(module
    (define L.fun/void8531.7.10 (lambda (c.60) (begin (if (!= 6 6) 30 30))))
    (begin
      (set! fun/void8531.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/void8531.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
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
      (set! error?.72
        (begin
          (set! tmp.78 (begin (set! tmp.83 (alloc 16)) (+ tmp.83 2)))
          (begin (mset! tmp.78 -2 L.error?.72.10) (mset! tmp.78 6 8) tmp.78)))
      (set! fun/error8534.11
        (begin
          (set! tmp.79 (begin (set! tmp.84 (alloc 16)) (+ tmp.84 2)))
          (begin
            (mset! tmp.79 -2 L.fun/error8534.11.11)
            (mset! tmp.79 6 0)
            tmp.79)))
      (set! fun/error8535.12
        (begin
          (set! tmp.80 (begin (set! tmp.85 (alloc 16)) (+ tmp.85 2)))
          (begin
            (mset! tmp.80 -2 L.fun/error8535.12.12)
            (mset! tmp.80 6 0)
            tmp.80)))
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
                      (set! procedure0.17
                        (begin
                          (set! lam.73
                            (begin
                              (set! tmp.81
                                (begin (set! tmp.88 (alloc 16)) (+ tmp.88 2)))
                              (begin
                                (mset! tmp.81 -2 L.lam.73.13)
                                (mset! tmp.81 6 0)
                                tmp.81)))
                          lam.73))
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
      (set! fun/void8538.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/void8538.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
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
      (set! fun/fixnum8543.7
        (begin
          (set! tmp.63 (begin (set! tmp.65 (alloc 24)) (+ tmp.65 2)))
          (begin
            (mset! tmp.63 -2 L.fun/fixnum8543.7.10)
            (mset! tmp.63 6 0)
            tmp.63)))
      (set! fun/fixnum8544.8
        (begin
          (set! tmp.64 (begin (set! tmp.66 (alloc 16)) (+ tmp.66 2)))
          (begin
            (mset! tmp.64 -2 L.fun/fixnum8544.8.11)
            (mset! tmp.64 6 0)
            tmp.64)))
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
      (set! fun/fixnum8551.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/fixnum8551.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
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
      (set! fun/error8558.7
        (begin
          (set! tmp.63 (begin (set! tmp.65 (alloc 24)) (+ tmp.65 2)))
          (begin
            (mset! tmp.63 -2 L.fun/error8558.7.10)
            (mset! tmp.63 6 0)
            tmp.63)))
      (set! fun/error8559.8
        (begin
          (set! tmp.64 (begin (set! tmp.66 (alloc 16)) (+ tmp.66 2)))
          (begin
            (mset! tmp.64 -2 L.fun/error8559.8.11)
            (mset! tmp.64 6 0)
            tmp.64)))
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
      (set! fun/void8562.7
        (begin
          (set! tmp.69 (begin (set! tmp.73 (alloc 24)) (+ tmp.73 2)))
          (begin
            (mset! tmp.69 -2 L.fun/void8562.7.10)
            (mset! tmp.69 6 0)
            tmp.69)))
      (set! fun/void8565.8
        (begin
          (set! tmp.70 (begin (set! tmp.74 (alloc 16)) (+ tmp.74 2)))
          (begin
            (mset! tmp.70 -2 L.fun/void8565.8.11)
            (mset! tmp.70 6 0)
            tmp.70)))
      (set! fun/void8564.9
        (begin
          (set! tmp.71 (begin (set! tmp.75 (alloc 24)) (+ tmp.75 2)))
          (begin
            (mset! tmp.71 -2 L.fun/void8564.9.12)
            (mset! tmp.71 6 0)
            tmp.71)))
      (set! fun/void8563.10
        (begin
          (set! tmp.72 (begin (set! tmp.76 (alloc 16)) (+ tmp.76 2)))
          (begin
            (mset! tmp.72 -2 L.fun/void8563.10.13)
            (mset! tmp.72 6 0)
            tmp.72)))
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
      (set! fun/ascii-char8568.7
        (begin
          (set! tmp.64 (begin (set! tmp.66 (alloc 24)) (+ tmp.66 2)))
          (begin
            (mset! tmp.64 -2 L.fun/ascii-char8568.7.10)
            (mset! tmp.64 6 8)
            tmp.64)))
      (set! fun/ascii-char8569.8
        (begin
          (set! tmp.65 (begin (set! tmp.67 (alloc 16)) (+ tmp.67 2)))
          (begin
            (mset! tmp.65 -2 L.fun/ascii-char8569.8.11)
            (mset! tmp.65 6 0)
            tmp.65)))
      (begin
        (mset! fun/ascii-char8568.7 14 fun/ascii-char8569.8)
        (begin
          (set! tmp.68 (if (!= 14 6) 520 1000))
          (call L.fun/ascii-char8568.7.10 fun/ascii-char8568.7 tmp.68))))))
(check-by-interp
 '(module
    (define L.lam.79.17 (lambda (c.87) (begin 7136)))
    (define L.make-vector.75.16
      (lambda (c.86 tmp.51)
        (begin
          (set! make-init-vector.4 (mref c.86 14))
          (if (begin
                (set! tmp.98
                  (if (begin (set! tmp.99 (bitwise-and tmp.51 7)) (= tmp.99 0))
                    14
                    6))
                (!= tmp.98 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.51)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.85 tmp.23)
        (begin
          (set! vector-init-loop.25 (mref c.85 14))
          (begin
            (set! tmp.24
              (begin
                (set! tmp.88
                  (begin
                    (set! tmp.100
                      (begin
                        (set! tmp.101
                          (begin
                            (set! tmp.102
                              (begin
                                (set! tmp.103
                                  (arithmetic-shift-right tmp.23 3))
                                (+ 1 tmp.103)))
                            (* tmp.102 8)))
                        (alloc tmp.101)))
                    (+ tmp.100 3)))
                (begin (mset! tmp.88 -3 tmp.23) tmp.88)))
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
          (if (begin (set! tmp.104 (if (= len.26 i.28) 14 6)) (!= tmp.104 6))
            vec.27
            (begin
              (begin
                (set! tmp.105
                  (begin
                    (set! tmp.106
                      (begin
                        (set! tmp.107 (arithmetic-shift-right i.28 3))
                        (* tmp.107 8)))
                    (+ tmp.106 5)))
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
                (set! tmp.109
                  (if (begin
                        (set! tmp.110 (bitwise-and tmp.54 7))
                        (= tmp.110 0))
                    14
                    6))
                (!= tmp.109 6))
            (if (begin
                  (set! tmp.111
                    (if (begin
                          (set! tmp.112 (bitwise-and tmp.53 7))
                          (= tmp.112 3))
                      14
                      6))
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
                (set! tmp.113
                  (if (begin
                        (set! tmp.114 (mref tmp.29 -3))
                        (< tmp.30 tmp.114))
                    14
                    6))
                (!= tmp.113 6))
            (if (begin (set! tmp.115 (if (>= tmp.30 0) 14 6)) (!= tmp.115 6))
              (begin
                (begin
                  (set! tmp.116
                    (begin
                      (set! tmp.117
                        (begin
                          (set! tmp.118 (arithmetic-shift-right tmp.30 3))
                          (* tmp.118 8)))
                      (+ tmp.117 5)))
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
            (set! tmp.89 (begin (set! tmp.120 (alloc 16)) (+ tmp.120 1)))
            (begin (mset! tmp.89 -1 tmp.70) (mset! tmp.89 7 tmp.71) tmp.89)))))
    (begin
      (set! cons.78
        (begin
          (set! tmp.90 (begin (set! tmp.121 (alloc 16)) (+ tmp.121 2)))
          (begin (mset! tmp.90 -2 L.cons.78.10) (mset! tmp.90 6 16) tmp.90)))
      (set! error?.77
        (begin
          (set! tmp.91 (begin (set! tmp.122 (alloc 16)) (+ tmp.122 2)))
          (begin (mset! tmp.91 -2 L.error?.77.11) (mset! tmp.91 6 8) tmp.91)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.92 (begin (set! tmp.123 (alloc 16)) (+ tmp.123 2)))
          (begin
            (mset! tmp.92 -2 L.unsafe-vector-set!.5.12)
            (mset! tmp.92 6 24)
            tmp.92)))
      (set! vector-set!.76
        (begin
          (set! tmp.93 (begin (set! tmp.124 (alloc 24)) (+ tmp.124 2)))
          (begin
            (mset! tmp.93 -2 L.vector-set!.76.13)
            (mset! tmp.93 6 24)
            tmp.93)))
      (set! vector-init-loop.25
        (begin
          (set! tmp.94 (begin (set! tmp.125 (alloc 24)) (+ tmp.125 2)))
          (begin
            (mset! tmp.94 -2 L.vector-init-loop.25.14)
            (mset! tmp.94 6 24)
            tmp.94)))
      (set! make-init-vector.4
        (begin
          (set! tmp.95 (begin (set! tmp.126 (alloc 24)) (+ tmp.126 2)))
          (begin
            (mset! tmp.95 -2 L.make-init-vector.4.15)
            (mset! tmp.95 6 8)
            tmp.95)))
      (set! make-vector.75
        (begin
          (set! tmp.96 (begin (set! tmp.127 (alloc 24)) (+ tmp.127 2)))
          (begin
            (mset! tmp.96 -2 L.make-vector.75.16)
            (mset! tmp.96 6 8)
            tmp.96)))
      (begin
        (mset! vector-set!.76 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.25 14 vector-init-loop.25)
        (mset! make-init-vector.4 14 vector-init-loop.25)
        (mset! make-vector.75 14 make-init-vector.4)
        (begin
          (set! vector0.9
            (begin
              (set! tmp.7.10 (call L.make-vector.75.16 make-vector.75 64))
              (begin
                (set! g42836815.11
                  (begin
                    (set! tmp.128 (call L.make-vector.75.16 make-vector.75 64))
                    (call
                     L.vector-set!.76.13
                     vector-set!.76
                     tmp.7.10
                     0
                     tmp.128)))
                (if (begin
                      (set! tmp.129
                        (call L.error?.77.11 error?.77 g42836815.11))
                      (!= tmp.129 6))
                  g42836815.11
                  (begin
                    (set! g42836816.12
                      (begin
                        (set! tmp.130
                          (begin
                            (set! tmp.131 (call L.cons.78.10 cons.78 3072 22))
                            (call L.cons.78.10 cons.78 1648 tmp.131)))
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
                      g42836816.12
                      (begin
                        (set! g42836817.13
                          (begin
                            (set! tmp.133
                              (begin
                                (set! tmp.134
                                  (call L.cons.78.10 cons.78 4040 22))
                                (call L.cons.78.10 cons.78 1504 tmp.134)))
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
                          g42836817.13
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
                                    (call
                                     L.error?.77.11
                                     error?.77
                                     g42836818.14))
                                  (!= tmp.136 6))
                              g42836818.14
                              (begin
                                (set! g42836819.15
                                  (begin
                                    (set! tmp.137
                                      (begin
                                        (set! tmp.138
                                          (call L.cons.78.10 cons.78 2256 22))
                                        (call
                                         L.cons.78.10
                                         cons.78
                                         1232
                                         tmp.138)))
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
                                  g42836819.15
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
                                      g42836820.16
                                      (begin
                                        (set! g42836821.17
                                          (begin
                                            (set! tmp.141
                                              (begin
                                                (set! lam.79
                                                  (begin
                                                    (set! tmp.97
                                                      (begin
                                                        (set! tmp.142
                                                          (alloc 16))
                                                        (+ tmp.142 2)))
                                                    (begin
                                                      (mset!
                                                       tmp.97
                                                       -2
                                                       L.lam.79.17)
                                                      (mset! tmp.97 6 0)
                                                      tmp.97)))
                                                lam.79))
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
                                          g42836821.17
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
                                              g42836822.18
                                              tmp.7.10))))))))))))))))))
          (set! void1.8
            (begin
              (set! g42836823.19 30)
              (if (begin
                    (set! tmp.145 (call L.error?.77.11 error?.77 g42836823.19))
                    (!= tmp.145 6))
                g42836823.19
                (begin
                  (set! g42836824.20 30)
                  (if (begin
                        (set! tmp.146
                          (call L.error?.77.11 error?.77 g42836824.20))
                        (!= tmp.146 6))
                    g42836824.20
                    (begin
                      (set! g42836825.21 30)
                      (if (begin
                            (set! tmp.147
                              (call L.error?.77.11 error?.77 g42836825.21))
                            (!= tmp.147 6))
                        g42836825.21
                        (begin
                          (set! g42836826.22 30)
                          (if (begin
                                (set! tmp.148
                                  (call L.error?.77.11 error?.77 g42836826.22))
                                (!= tmp.148 6))
                            g42836826.22
                            30)))))))))
          (begin 1360))))))
(check-by-interp
 '(module
    (define L.fun/boolean8574.7.14 (lambda (c.69 oprand0.8) (begin 6)))
    (define L.make-vector.63.13
      (lambda (c.68 tmp.39)
        (begin
          (set! make-init-vector.4 (mref c.68 14))
          (if (begin
                (set! tmp.77
                  (if (begin (set! tmp.78 (bitwise-and tmp.39 7)) (= tmp.78 0))
                    14
                    6))
                (!= tmp.77 6))
            (call L.make-init-vector.4.12 make-init-vector.4 tmp.39)
            2110))))
    (define L.make-init-vector.4.12
      (lambda (c.67 tmp.11)
        (begin
          (set! vector-init-loop.13 (mref c.67 14))
          (begin
            (set! tmp.12
              (begin
                (set! tmp.70
                  (begin
                    (set! tmp.79
                      (begin
                        (set! tmp.80
                          (begin
                            (set! tmp.81
                              (begin
                                (set! tmp.82 (arithmetic-shift-right tmp.11 3))
                                (+ 1 tmp.82)))
                            (* tmp.81 8)))
                        (alloc tmp.80)))
                    (+ tmp.79 3)))
                (begin (mset! tmp.70 -3 tmp.11) tmp.70)))
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
          (if (begin (set! tmp.83 (if (= len.14 i.16) 14 6)) (!= tmp.83 6))
            vec.15
            (begin
              (begin
                (set! tmp.84
                  (begin
                    (set! tmp.85
                      (begin
                        (set! tmp.86 (arithmetic-shift-right i.16 3))
                        (* tmp.86 8)))
                    (+ tmp.85 5)))
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
            (set! tmp.71 (begin (set! tmp.88 (alloc 16)) (+ tmp.88 1)))
            (begin (mset! tmp.71 -1 tmp.58) (mset! tmp.71 7 tmp.59) tmp.71)))))
    (begin
      (set! cons.64
        (begin
          (set! tmp.72 (begin (set! tmp.89 (alloc 16)) (+ tmp.89 2)))
          (begin (mset! tmp.72 -2 L.cons.64.10) (mset! tmp.72 6 16) tmp.72)))
      (set! vector-init-loop.13
        (begin
          (set! tmp.73 (begin (set! tmp.90 (alloc 24)) (+ tmp.90 2)))
          (begin
            (mset! tmp.73 -2 L.vector-init-loop.13.11)
            (mset! tmp.73 6 24)
            tmp.73)))
      (set! make-init-vector.4
        (begin
          (set! tmp.74 (begin (set! tmp.91 (alloc 24)) (+ tmp.91 2)))
          (begin
            (mset! tmp.74 -2 L.make-init-vector.4.12)
            (mset! tmp.74 6 8)
            tmp.74)))
      (set! make-vector.63
        (begin
          (set! tmp.75 (begin (set! tmp.92 (alloc 24)) (+ tmp.92 2)))
          (begin
            (mset! tmp.75 -2 L.make-vector.63.13)
            (mset! tmp.75 6 8)
            tmp.75)))
      (set! fun/boolean8574.7
        (begin
          (set! tmp.76 (begin (set! tmp.93 (alloc 16)) (+ tmp.93 2)))
          (begin
            (mset! tmp.76 -2 L.fun/boolean8574.7.14)
            (mset! tmp.76 6 8)
            tmp.76)))
      (begin
        (mset! vector-init-loop.13 14 vector-init-loop.13)
        (mset! make-init-vector.4 14 vector-init-loop.13)
        (mset! make-vector.63 14 make-init-vector.4)
        (if (begin
              (set! tmp.94
                (begin
                  (set! tmp.95 (call L.make-vector.63.13 make-vector.63 64))
                  (call L.fun/boolean8574.7.14 fun/boolean8574.7 tmp.95)))
              (!= tmp.94 6))
          (if (!= 14 6) 17198 23854)
          (begin
            (set! void0.10 30)
            (set! pair1.9
              (begin
                (set! tmp.96 (call L.cons.64.10 cons.64 3080 22))
                (call L.cons.64.10 cons.64 1472 tmp.96)))
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
      (set! fun/empty8578.7
        (begin
          (set! tmp.71 (begin (set! tmp.75 (alloc 24)) (+ tmp.75 2)))
          (begin
            (mset! tmp.71 -2 L.fun/empty8578.7.10)
            (mset! tmp.71 6 0)
            tmp.71)))
      (set! fun/empty8579.8
        (begin
          (set! tmp.72 (begin (set! tmp.76 (alloc 16)) (+ tmp.76 2)))
          (begin
            (mset! tmp.72 -2 L.fun/empty8579.8.11)
            (mset! tmp.72 6 0)
            tmp.72)))
      (set! fun/empty8577.9
        (begin
          (set! tmp.73 (begin (set! tmp.77 (alloc 16)) (+ tmp.77 2)))
          (begin
            (mset! tmp.73 -2 L.fun/empty8577.9.12)
            (mset! tmp.73 6 8)
            tmp.73)))
      (begin
        (mset! fun/empty8578.7 14 fun/empty8579.8)
        (if (begin (set! ascii-char0.11 24110) (!= 22 6))
          (if (begin
                (set! tmp.78
                  (begin
                    (set! tmp.79
                      (if (!= 22 6) (if (!= 22 6) (if (!= 22 6) 22 6) 6) 6))
                    (call L.fun/empty8577.9.12 fun/empty8577.9 tmp.79)))
                (!= tmp.78 6))
            (if (begin (!= 22 6))
              (if (begin
                    (set! procedure0.13
                      (begin
                        (set! lam.66
                          (begin
                            (set! tmp.74
                              (begin (set! tmp.80 (alloc 16)) (+ tmp.80 2)))
                            (begin
                              (mset! tmp.74 -2 L.lam.66.13)
                              (mset! tmp.74 6 0)
                              tmp.74)))
                        lam.66))
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
                (set! tmp.109
                  (if (begin
                        (set! tmp.110 (bitwise-and tmp.49 7))
                        (= tmp.110 0))
                    14
                    6))
                (!= tmp.109 6))
            (call L.make-init-vector.4.16 make-init-vector.4 tmp.49)
            2110))))
    (define L.make-init-vector.4.16
      (lambda (c.84 tmp.21)
        (begin
          (set! vector-init-loop.23 (mref c.84 14))
          (begin
            (set! tmp.22
              (begin
                (set! tmp.89
                  (begin
                    (set! tmp.111
                      (begin
                        (set! tmp.112
                          (begin
                            (set! tmp.113
                              (begin
                                (set! tmp.114
                                  (arithmetic-shift-right tmp.21 3))
                                (+ 1 tmp.114)))
                            (* tmp.113 8)))
                        (alloc tmp.112)))
                    (+ tmp.111 3)))
                (begin (mset! tmp.89 -3 tmp.21) tmp.89)))
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
          (if (begin (set! tmp.115 (if (= len.24 i.26) 14 6)) (!= tmp.115 6))
            vec.25
            (begin
              (begin
                (set! tmp.116
                  (begin
                    (set! tmp.117
                      (begin
                        (set! tmp.118 (arithmetic-shift-right i.26 3))
                        (* tmp.118 8)))
                    (+ tmp.117 5)))
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
                (set! tmp.120
                  (if (begin
                        (set! tmp.121 (bitwise-and tmp.52 7))
                        (= tmp.121 0))
                    14
                    6))
                (!= tmp.120 6))
            (if (begin
                  (set! tmp.122
                    (if (begin
                          (set! tmp.123 (bitwise-and tmp.51 7))
                          (= tmp.123 3))
                      14
                      6))
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
                (set! tmp.124
                  (if (begin
                        (set! tmp.125 (mref tmp.27 -3))
                        (< tmp.28 tmp.125))
                    14
                    6))
                (!= tmp.124 6))
            (if (begin (set! tmp.126 (if (>= tmp.28 0) 14 6)) (!= tmp.126 6))
              (begin
                (begin
                  (set! tmp.127
                    (begin
                      (set! tmp.128
                        (begin
                          (set! tmp.129 (arithmetic-shift-right tmp.28 3))
                          (* tmp.129 8)))
                      (+ tmp.128 5)))
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
                (set! tmp.131
                  (if (begin
                        (set! tmp.132 (bitwise-and tmp.36 7))
                        (= tmp.132 0))
                    14
                    6))
                (!= tmp.131 6))
            (if (begin
                  (set! tmp.133
                    (if (begin
                          (set! tmp.134 (bitwise-and tmp.35 7))
                          (= tmp.134 0))
                      14
                      6))
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
                (set! tmp.136
                  (if (begin
                        (set! tmp.137 (bitwise-and tmp.48 7))
                        (= tmp.137 0))
                    14
                    6))
                (!= tmp.136 6))
            (if (begin
                  (set! tmp.138
                    (if (begin
                          (set! tmp.139 (bitwise-and tmp.47 7))
                          (= tmp.139 0))
                      14
                      6))
                  (!= tmp.138 6))
              (if (>= tmp.47 tmp.48) 14 6)
              1854)
            1854))))
    (begin
      (set! >=.77
        (begin
          (set! tmp.90 (begin (set! tmp.140 (alloc 16)) (+ tmp.140 2)))
          (begin (mset! tmp.90 -2 L.>=.77.10) (mset! tmp.90 6 16) tmp.90)))
      (set! *.76
        (begin
          (set! tmp.91 (begin (set! tmp.141 (alloc 16)) (+ tmp.141 2)))
          (begin (mset! tmp.91 -2 L.*.76.11) (mset! tmp.91 6 16) tmp.91)))
      (set! error?.75
        (begin
          (set! tmp.92 (begin (set! tmp.142 (alloc 16)) (+ tmp.142 2)))
          (begin (mset! tmp.92 -2 L.error?.75.12) (mset! tmp.92 6 8) tmp.92)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.93 (begin (set! tmp.143 (alloc 16)) (+ tmp.143 2)))
          (begin
            (mset! tmp.93 -2 L.unsafe-vector-set!.5.13)
            (mset! tmp.93 6 24)
            tmp.93)))
      (set! vector-set!.74
        (begin
          (set! tmp.94 (begin (set! tmp.144 (alloc 24)) (+ tmp.144 2)))
          (begin
            (mset! tmp.94 -2 L.vector-set!.74.14)
            (mset! tmp.94 6 24)
            tmp.94)))
      (set! vector-init-loop.23
        (begin
          (set! tmp.95 (begin (set! tmp.145 (alloc 24)) (+ tmp.145 2)))
          (begin
            (mset! tmp.95 -2 L.vector-init-loop.23.15)
            (mset! tmp.95 6 24)
            tmp.95)))
      (set! make-init-vector.4
        (begin
          (set! tmp.96 (begin (set! tmp.146 (alloc 24)) (+ tmp.146 2)))
          (begin
            (mset! tmp.96 -2 L.make-init-vector.4.16)
            (mset! tmp.96 6 8)
            tmp.96)))
      (set! make-vector.73
        (begin
          (set! tmp.97 (begin (set! tmp.147 (alloc 24)) (+ tmp.147 2)))
          (begin
            (mset! tmp.97 -2 L.make-vector.73.17)
            (mset! tmp.97 6 8)
            tmp.97)))
      (set! fun/vector8584.8
        (begin
          (set! tmp.98 (begin (set! tmp.148 (alloc 40)) (+ tmp.148 2)))
          (begin
            (mset! tmp.98 -2 L.fun/vector8584.8.18)
            (mset! tmp.98 6 0)
            tmp.98)))
      (set! fun/fixnum8582.9
        (begin
          (set! tmp.99 (begin (set! tmp.149 (alloc 16)) (+ tmp.149 2)))
          (begin
            (mset! tmp.99 -2 L.fun/fixnum8582.9.19)
            (mset! tmp.99 6 0)
            tmp.99)))
      (set! fun/fixnum8583.10
        (begin
          (set! tmp.100 (begin (set! tmp.150 (alloc 16)) (+ tmp.150 2)))
          (begin
            (mset! tmp.100 -2 L.fun/fixnum8583.10.20)
            (mset! tmp.100 6 8)
            tmp.100)))
      (begin
        (mset! vector-set!.74 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.23 14 vector-init-loop.23)
        (mset! make-init-vector.4 14 vector-init-loop.23)
        (mset! make-vector.73 14 make-init-vector.4)
        (mset! fun/vector8584.8 14 vector-set!.74)
        (mset! fun/vector8584.8 22 error?.75)
        (mset! fun/vector8584.8 30 make-vector.73)
        (begin
          (set! tmp.151
            (begin
              (set! tmp.152 (begin 624))
              (begin
                (set! tmp.153 (call L.fun/fixnum8582.9.19 fun/fixnum8582.9))
                (call L.*.76.11 *.76 tmp.152 tmp.153))))
          (begin
            (set! tmp.154
              (begin
                (set! tmp.155 (call L.fun/vector8584.8.18 fun/vector8584.8))
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
      (set! error?.92
        (begin
          (set! tmp.96 (begin (set! tmp.100 (alloc 16)) (+ tmp.100 2)))
          (begin (mset! tmp.96 -2 L.error?.92.10) (mset! tmp.96 6 8) tmp.96)))
      (set! fun/empty8588.19
        (begin
          (set! tmp.97 (begin (set! tmp.101 (alloc 16)) (+ tmp.101 2)))
          (begin
            (mset! tmp.97 -2 L.fun/empty8588.19.11)
            (mset! tmp.97 6 8)
            tmp.97)))
      (set! fun/empty8587.20
        (begin
          (set! tmp.98 (begin (set! tmp.102 (alloc 16)) (+ tmp.102 2)))
          (begin
            (mset! tmp.98 -2 L.fun/empty8587.20.12)
            (mset! tmp.98 6 0)
            tmp.98)))
      (begin
        (set! tmp.7.22 (if (!= 6 6) 22 22))
        (if (!= tmp.7.22 6)
          tmp.7.22
          (begin
            (set! tmp.8.23 (if (!= 6 6) 22 22))
            (if (!= tmp.8.23 6)
              tmp.8.23
              (begin
                (set! tmp.9.24 (begin 22))
                (if (!= tmp.9.24 6)
                  tmp.9.24
                  (begin
                    (set! tmp.10.25 (if (!= 6 6) 22 22))
                    (if (!= tmp.10.25 6)
                      tmp.10.25
                      (begin
                        (set! tmp.11.26
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
                                                            (!=
                                                             22
                                                             6)))))))))))))
                                  (if (begin (!= 22 6))
                                    (if (begin
                                          (set! tmp.103
                                            (call
                                             L.fun/empty8587.20.12
                                             fun/empty8587.20))
                                          (!= tmp.103 6))
                                      (begin (set! fixnum0.34 880) 22)
                                      6)
                                    6)
                                  6)
                                6)
                              6)
                            6))
                        (if (!= tmp.11.26 6)
                          tmp.11.26
                          (begin
                            (set! tmp.18.35 (begin 22))
                            (if (!= tmp.18.35 6)
                              tmp.18.35
                              (begin
                                (set! tmp.104
                                  (begin
                                    (set! g42852100.36 1624)
                                    (if (begin
                                          (set! tmp.105
                                            (call
                                             L.error?.92.10
                                             error?.92
                                             g42852100.36))
                                          (!= tmp.105 6))
                                      g42852100.36
                                      (begin
                                        (set! g42852101.37 232)
                                        (if (begin
                                              (set! tmp.106
                                                (call
                                                 L.error?.92.10
                                                 error?.92
                                                 g42852101.37))
                                              (!= tmp.106 6))
                                          g42852101.37
                                          (begin
                                            (set! g42852102.38 592)
                                            (if (begin
                                                  (set! tmp.107
                                                    (call
                                                     L.error?.92.10
                                                     error?.92
                                                     g42852102.38))
                                                  (!= tmp.107 6))
                                              g42852102.38
                                              (begin
                                                (set! g42852103.39 1824)
                                                (if (begin
                                                      (set! tmp.108
                                                        (call
                                                         L.error?.92.10
                                                         error?.92
                                                         g42852103.39))
                                                      (!= tmp.108 6))
                                                  g42852103.39
                                                  1480)))))))))
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
            (set! tmp.98 (begin (set! tmp.106 (alloc 16)) (+ tmp.106 1)))
            (begin (mset! tmp.98 -1 tmp.84) (mset! tmp.98 7 tmp.85) tmp.98)))))
    (define L.error?.90.10
      (lambda (c.91 tmp.79)
        (begin
          (if (begin (set! tmp.107 (bitwise-and tmp.79 255)) (= tmp.107 62))
            14
            6))))
    (begin
      (set! error?.90
        (begin
          (set! tmp.99 (begin (set! tmp.108 (alloc 16)) (+ tmp.108 2)))
          (begin (mset! tmp.99 -2 L.error?.90.10) (mset! tmp.99 6 8) tmp.99)))
      (set! cons.89
        (begin
          (set! tmp.100 (begin (set! tmp.109 (alloc 16)) (+ tmp.109 2)))
          (begin
            (mset! tmp.100 -2 L.cons.89.11)
            (mset! tmp.100 6 16)
            tmp.100)))
      (set! fun/empty8592.11
        (begin
          (set! tmp.101 (begin (set! tmp.110 (alloc 16)) (+ tmp.110 2)))
          (begin
            (mset! tmp.101 -2 L.fun/empty8592.11.12)
            (mset! tmp.101 6 0)
            tmp.101)))
      (set! fun/empty8594.12
        (begin
          (set! tmp.102 (begin (set! tmp.111 (alloc 16)) (+ tmp.111 2)))
          (begin
            (mset! tmp.102 -2 L.fun/empty8594.12.13)
            (mset! tmp.102 6 8)
            tmp.102)))
      (set! fun/empty8593.13
        (begin
          (set! tmp.103 (begin (set! tmp.112 (alloc 16)) (+ tmp.112 2)))
          (begin
            (mset! tmp.103 -2 L.fun/empty8593.13.14)
            (mset! tmp.103 6 8)
            tmp.103)))
      (set! fun/empty8591.14
        (begin
          (set! tmp.104 (begin (set! tmp.113 (alloc 16)) (+ tmp.113 2)))
          (begin
            (mset! tmp.104 -2 L.fun/empty8591.14.15)
            (mset! tmp.104 6 8)
            tmp.104)))
      (set! fun/empty8595.15
        (begin
          (set! tmp.105 (begin (set! tmp.114 (alloc 16)) (+ tmp.114 2)))
          (begin
            (mset! tmp.105 -2 L.fun/empty8595.15.16)
            (mset! tmp.105 6 0)
            tmp.105)))
      (begin
        (set! g42855921.19
          (begin
            (set! pair0.21
              (begin
                (set! tmp.115 (call L.cons.89.11 cons.89 2864 22))
                (call L.cons.89.11 cons.89 2024 tmp.115)))
            (set! pair1.20
              (begin
                (set! tmp.116 (call L.cons.89.11 cons.89 2360 22))
                (call L.cons.89.11 cons.89 1352 tmp.116)))
            22))
        (if (begin
              (set! tmp.117 (call L.error?.90.10 error?.90 g42855921.19))
              (!= tmp.117 6))
          g42855921.19
          (begin
            (set! g42855922.22
              (begin
                (set! tmp.7.23 (if (!= 6 6) 22 22))
                (if (!= tmp.7.23 6)
                  tmp.7.23
                  (begin
                    (set! tmp.8.24 (if (!= 6 6) 22 22))
                    (if (!= tmp.8.24 6)
                      tmp.8.24
                      (begin
                        (set! tmp.9.25
                          (begin
                            (set! g42855923.26 22)
                            (if (begin
                                  (set! tmp.118
                                    (call
                                     L.error?.90.10
                                     error?.90
                                     g42855923.26))
                                  (!= tmp.118 6))
                              g42855923.26
                              (begin
                                (set! g42855924.27 22)
                                (if (begin
                                      (set! tmp.119
                                        (call
                                         L.error?.90.10
                                         error?.90
                                         g42855924.27))
                                      (!= tmp.119 6))
                                  g42855924.27
                                  (begin
                                    (set! g42855925.28 22)
                                    (if (begin
                                          (set! tmp.120
                                            (call
                                             L.error?.90.10
                                             error?.90
                                             g42855925.28))
                                          (!= tmp.120 6))
                                      g42855925.28
                                      (begin
                                        (set! g42855926.29 22)
                                        (if (begin
                                              (set! tmp.121
                                                (call
                                                 L.error?.90.10
                                                 error?.90
                                                 g42855926.29))
                                              (!= tmp.121 6))
                                          g42855926.29
                                          (begin
                                            (set! g42855927.30 22)
                                            (if (begin
                                                  (set! tmp.122
                                                    (call
                                                     L.error?.90.10
                                                     error?.90
                                                     g42855927.30))
                                                  (!= tmp.122 6))
                                              g42855927.30
                                              22)))))))))))
                        (if (!= tmp.9.25 6)
                          tmp.9.25
                          (begin
                            (set! tmp.10.31 (begin 22))
                            (if (!= tmp.10.31 6)
                              tmp.10.31
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
                    (set! g42855929.33
                      (begin
                        (set! tmp.125
                          (begin
                            (set! pair0.34
                              (begin
                                (set! tmp.126
                                  (call L.cons.89.11 cons.89 3616 22))
                                (call L.cons.89.11 cons.89 896 tmp.126)))
                            63550))
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
                            (set! g42855931.36 (begin 22))
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
      (set! error?.64
        (begin
          (set! tmp.68 (begin (set! tmp.72 (alloc 16)) (+ tmp.72 2)))
          (begin (mset! tmp.68 -2 L.error?.64.10) (mset! tmp.68 6 8) tmp.68)))
      (set! fun/fixnum8598.7
        (begin
          (set! tmp.69 (begin (set! tmp.73 (alloc 16)) (+ tmp.73 2)))
          (begin
            (mset! tmp.69 -2 L.fun/fixnum8598.7.11)
            (mset! tmp.69 6 0)
            tmp.69)))
      (set! fun/fixnum8599.8
        (begin
          (set! tmp.70 (begin (set! tmp.74 (alloc 16)) (+ tmp.74 2)))
          (begin
            (mset! tmp.70 -2 L.fun/fixnum8599.8.12)
            (mset! tmp.70 6 0)
            tmp.70)))
      (begin
        (set! g42859749.9 (call L.fun/fixnum8598.7.11 fun/fixnum8598.7))
        (if (begin
              (set! tmp.75 (call L.error?.64.10 error?.64 g42859749.9))
              (!= tmp.75 6))
          g42859749.9
          (begin
            (set! g42859750.10 (begin 856))
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
            (set! tmp.68 (begin (set! tmp.73 (alloc 16)) (+ tmp.73 1)))
            (begin (mset! tmp.68 -1 tmp.58) (mset! tmp.68 7 tmp.59) tmp.68)))))
    (begin
      (set! cons.63
        (begin
          (set! tmp.69 (begin (set! tmp.74 (alloc 16)) (+ tmp.74 2)))
          (begin (mset! tmp.69 -2 L.cons.63.10) (mset! tmp.69 6 16) tmp.69)))
      (set! fun/fixnum8602.7
        (begin
          (set! tmp.70 (begin (set! tmp.75 (alloc 24)) (+ tmp.75 2)))
          (begin
            (mset! tmp.70 -2 L.fun/fixnum8602.7.11)
            (mset! tmp.70 6 8)
            tmp.70)))
      (set! fun/fixnum8604.8
        (begin
          (set! tmp.71 (begin (set! tmp.76 (alloc 16)) (+ tmp.76 2)))
          (begin
            (mset! tmp.71 -2 L.fun/fixnum8604.8.12)
            (mset! tmp.71 6 0)
            tmp.71)))
      (set! fun/fixnum8603.9
        (begin
          (set! tmp.72 (begin (set! tmp.77 (alloc 24)) (+ tmp.77 2)))
          (begin
            (mset! tmp.72 -2 L.fun/fixnum8603.9.13)
            (mset! tmp.72 6 0)
            tmp.72)))
      (begin
        (mset! fun/fixnum8602.7 14 fun/fixnum8603.9)
        (mset! fun/fixnum8603.9 14 fun/fixnum8604.8)
        (begin
          (set! tmp.78
            (if (!= 14 6)
              (begin
                (set! tmp.79 (call L.cons.63.10 cons.63 2800 22))
                (call L.cons.63.10 cons.63 1128 tmp.79))
              (begin
                (set! tmp.80 (call L.cons.63.10 cons.63 2128 22))
                (call L.cons.63.10 cons.63 1856 tmp.80))))
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
      (set! error?.81
        (begin
          (set! tmp.86 (begin (set! tmp.91 (alloc 16)) (+ tmp.91 2)))
          (begin (mset! tmp.86 -2 L.error?.81.10) (mset! tmp.86 6 8) tmp.86)))
      (set! fun/error8609.14
        (begin
          (set! tmp.87 (begin (set! tmp.92 (alloc 16)) (+ tmp.92 2)))
          (begin
            (mset! tmp.87 -2 L.fun/error8609.14.11)
            (mset! tmp.87 6 0)
            tmp.87)))
      (set! fun/error8608.15
        (begin
          (set! tmp.88 (begin (set! tmp.93 (alloc 16)) (+ tmp.93 2)))
          (begin
            (mset! tmp.88 -2 L.fun/error8608.15.12)
            (mset! tmp.88 6 0)
            tmp.88)))
      (set! fun/error8607.16
        (begin
          (set! tmp.89 (begin (set! tmp.94 (alloc 16)) (+ tmp.94 2)))
          (begin
            (mset! tmp.89 -2 L.fun/error8607.16.13)
            (mset! tmp.89 6 8)
            tmp.89)))
      (begin
        (set! tmp.7.18
          (begin
            (set! tmp.8.19 (call L.fun/error8607.16.13 fun/error8607.16 56638))
            (if (!= tmp.8.19 6)
              tmp.8.19
              (begin
                (set! tmp.9.20 (call L.fun/error8608.15.12 fun/error8608.15))
                (if (!= tmp.9.20 6)
                  tmp.9.20
                  (begin
                    (set! tmp.10.21
                      (if (!= 9534 6)
                        (if (!= 10814 6)
                          (if (!= 25150 6)
                            (if (!= 318 6) (if (!= 42302 6) 38462 6) 6)
                            6)
                          6)
                        6))
                    (if (!= tmp.10.21 6)
                      tmp.10.21
                      (begin
                        (set! tmp.11.22 (if (!= 6 6) 23358 11070))
                        (if (!= tmp.11.22 6)
                          tmp.11.22
                          (begin
                            (set! tmp.12.23
                              (begin
                                (set! g42867385.24 43838)
                                (if (begin
                                      (set! tmp.95
                                        (call
                                         L.error?.81.10
                                         error?.81
                                         g42867385.24))
                                      (!= tmp.95 6))
                                  g42867385.24
                                  (begin
                                    (set! g42867386.25 39230)
                                    (if (begin
                                          (set! tmp.96
                                            (call
                                             L.error?.81.10
                                             error?.81
                                             g42867386.25))
                                          (!= tmp.96 6))
                                      g42867386.25
                                      (begin
                                        (set! g42867387.26 28478)
                                        (if (begin
                                              (set! tmp.97
                                                (call
                                                 L.error?.81.10
                                                 error?.81
                                                 g42867387.26))
                                              (!= tmp.97 6))
                                          g42867387.26
                                          (begin
                                            (set! g42867388.27 52798)
                                            (if (begin
                                                  (set! tmp.98
                                                    (call
                                                     L.error?.81.10
                                                     error?.81
                                                     g42867388.27))
                                                  (!= tmp.98 6))
                                              g42867388.27
                                              44350)))))))))
                            (if (!= tmp.12.23 6)
                              tmp.12.23
                              (call
                               L.fun/error8609.14.11
                               fun/error8609.14))))))))))))
        (if (!= tmp.7.18 6)
          tmp.7.18
          (begin
            (set! tmp.13.28 (if (!= 14 6) 63806 16958))
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
      (set! fun/fixnum8612.7
        (begin
          (set! tmp.65 (begin (set! tmp.68 (alloc 24)) (+ tmp.68 2)))
          (begin
            (mset! tmp.65 -2 L.fun/fixnum8612.7.10)
            (mset! tmp.65 6 0)
            tmp.65)))
      (set! fun/fixnum8614.8
        (begin
          (set! tmp.66 (begin (set! tmp.69 (alloc 16)) (+ tmp.69 2)))
          (begin
            (mset! tmp.66 -2 L.fun/fixnum8614.8.11)
            (mset! tmp.66 6 0)
            tmp.66)))
      (set! fun/fixnum8613.9
        (begin
          (set! tmp.67 (begin (set! tmp.70 (alloc 24)) (+ tmp.70 2)))
          (begin
            (mset! tmp.67 -2 L.fun/fixnum8613.9.12)
            (mset! tmp.67 6 0)
            tmp.67)))
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
                (set! tmp.147
                  (if (begin
                        (set! tmp.148 (bitwise-and tmp.81 7))
                        (= tmp.148 0))
                    14
                    6))
                (!= tmp.147 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.81)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.114 tmp.53)
        (begin
          (set! vector-init-loop.55 (mref c.114 14))
          (begin
            (set! tmp.54
              (begin
                (set! tmp.120
                  (begin
                    (set! tmp.149
                      (begin
                        (set! tmp.150
                          (begin
                            (set! tmp.151
                              (begin
                                (set! tmp.152
                                  (arithmetic-shift-right tmp.53 3))
                                (+ 1 tmp.152)))
                            (* tmp.151 8)))
                        (alloc tmp.150)))
                    (+ tmp.149 3)))
                (begin (mset! tmp.120 -3 tmp.53) tmp.120)))
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
          (if (begin (set! tmp.153 (if (= len.56 i.58) 14 6)) (!= tmp.153 6))
            vec.57
            (begin
              (begin
                (set! tmp.154
                  (begin
                    (set! tmp.155
                      (begin
                        (set! tmp.156 (arithmetic-shift-right i.58 3))
                        (* tmp.156 8)))
                    (+ tmp.155 5)))
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
                (set! tmp.158
                  (if (begin
                        (set! tmp.159 (bitwise-and tmp.84 7))
                        (= tmp.159 0))
                    14
                    6))
                (!= tmp.158 6))
            (if (begin
                  (set! tmp.160
                    (if (begin
                          (set! tmp.161 (bitwise-and tmp.83 7))
                          (= tmp.161 3))
                      14
                      6))
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
                (set! tmp.162
                  (if (begin
                        (set! tmp.163 (mref tmp.59 -3))
                        (< tmp.60 tmp.163))
                    14
                    6))
                (!= tmp.162 6))
            (if (begin (set! tmp.164 (if (>= tmp.60 0) 14 6)) (!= tmp.164 6))
              (begin
                (begin
                  (set! tmp.165
                    (begin
                      (set! tmp.166
                        (begin
                          (set! tmp.167 (arithmetic-shift-right tmp.60 3))
                          (* tmp.167 8)))
                      (+ tmp.166 5)))
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
      (set! error?.107
        (begin
          (set! tmp.121 (begin (set! tmp.169 (alloc 16)) (+ tmp.169 2)))
          (begin
            (mset! tmp.121 -2 L.error?.107.10)
            (mset! tmp.121 6 8)
            tmp.121)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.122 (begin (set! tmp.170 (alloc 16)) (+ tmp.170 2)))
          (begin
            (mset! tmp.122 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.122 6 24)
            tmp.122)))
      (set! vector-set!.106
        (begin
          (set! tmp.123 (begin (set! tmp.171 (alloc 24)) (+ tmp.171 2)))
          (begin
            (mset! tmp.123 -2 L.vector-set!.106.12)
            (mset! tmp.123 6 24)
            tmp.123)))
      (set! vector-init-loop.55
        (begin
          (set! tmp.124 (begin (set! tmp.172 (alloc 24)) (+ tmp.172 2)))
          (begin
            (mset! tmp.124 -2 L.vector-init-loop.55.13)
            (mset! tmp.124 6 24)
            tmp.124)))
      (set! make-init-vector.4
        (begin
          (set! tmp.125 (begin (set! tmp.173 (alloc 24)) (+ tmp.173 2)))
          (begin
            (mset! tmp.125 -2 L.make-init-vector.4.14)
            (mset! tmp.125 6 8)
            tmp.125)))
      (set! make-vector.105
        (begin
          (set! tmp.126 (begin (set! tmp.174 (alloc 24)) (+ tmp.174 2)))
          (begin
            (mset! tmp.126 -2 L.make-vector.105.15)
            (mset! tmp.126 6 8)
            tmp.126)))
      (set! fun/boolean8626.14
        (begin
          (set! tmp.127 (begin (set! tmp.175 (alloc 16)) (+ tmp.175 2)))
          (begin
            (mset! tmp.127 -2 L.fun/boolean8626.14.16)
            (mset! tmp.127 6 8)
            tmp.127)))
      (set! fun/boolean8625.15
        (begin
          (set! tmp.128 (begin (set! tmp.176 (alloc 16)) (+ tmp.176 2)))
          (begin
            (mset! tmp.128 -2 L.fun/boolean8625.15.17)
            (mset! tmp.128 6 8)
            tmp.128)))
      (begin
        (mset! vector-set!.106 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.55 14 vector-init-loop.55)
        (mset! make-init-vector.4 14 vector-init-loop.55)
        (mset! make-vector.105 14 make-init-vector.4)
        (begin
          (set! tmp.177
            (begin
              (set! tmp.7.18 (if (!= 6 6) 6 6))
              (if (!= tmp.7.18 6)
                tmp.7.18
                (begin
                  (set! tmp.8.19 (if (!= 6 6) 6 14))
                  (if (!= tmp.8.19 6)
                    tmp.8.19
                    (begin
                      (set! tmp.9.20
                        (begin
                          (set! tmp.178
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
                                  g42890275.22
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
                                      g42890276.23
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
                                          g42890277.24
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
                                              g42890278.25
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
                                                  g42890279.26
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
                                                      g42890280.27
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
                                                          g42890281.28
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
                                                                  (!=
                                                                   tmp.186
                                                                   6))
                                                              g42890282.29
                                                              tmp.10.21))))))))))))))))))
                          (call
                           L.fun/boolean8626.14.16
                           fun/boolean8626.14
                           tmp.178)))
                      (if (!= tmp.9.20 6)
                        tmp.9.20
                        (begin
                          (set! tmp.11.30
                            (begin
                              (set! procedure0.32
                                (begin
                                  (set! lam.108
                                    (begin
                                      (set! tmp.129
                                        (begin
                                          (set! tmp.187 (alloc 40))
                                          (+ tmp.187 2)))
                                      (begin
                                        (mset! tmp.129 -2 L.lam.108.18)
                                        (mset! tmp.129 6 0)
                                        tmp.129)))
                                  (begin
                                    (mset! lam.108 14 vector-set!.106)
                                    (mset! lam.108 22 error?.107)
                                    (mset! lam.108 30 make-vector.105)
                                    lam.108)))
                              (set! vector1.31
                                (call L.make-vector.105.15 make-vector.105 64))
                              14))
                          (if (!= tmp.11.30 6)
                            tmp.11.30
                            (begin
                              (set! ascii-char0.43 16942)
                              (set! procedure1.42
                                (begin
                                  (set! lam.109
                                    (begin
                                      (set! tmp.130
                                        (begin
                                          (set! tmp.188 (alloc 40))
                                          (+ tmp.188 2)))
                                      (begin
                                        (mset! tmp.130 -2 L.lam.109.19)
                                        (mset! tmp.130 6 0)
                                        tmp.130)))
                                  (begin
                                    (mset! lam.109 14 vector-set!.106)
                                    (mset! lam.109 22 error?.107)
                                    (mset! lam.109 30 make-vector.105)
                                    lam.109)))
                              14))))))))))
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
            (set! tmp.65 (begin (set! tmp.68 (alloc 16)) (+ tmp.68 1)))
            (begin (mset! tmp.65 -1 tmp.57) (mset! tmp.65 7 tmp.58) tmp.65)))))
    (begin
      (set! cons.62
        (begin
          (set! tmp.66 (begin (set! tmp.69 (alloc 16)) (+ tmp.69 2)))
          (begin (mset! tmp.66 -2 L.cons.62.10) (mset! tmp.66 6 16) tmp.66)))
      (set! fun/empty8631.7
        (begin
          (set! tmp.67 (begin (set! tmp.70 (alloc 16)) (+ tmp.70 2)))
          (begin
            (mset! tmp.67 -2 L.fun/empty8631.7.11)
            (mset! tmp.67 6 8)
            tmp.67)))
      (begin
        (set! tmp.71
          (begin
            (set! error0.9 44862)
            (begin
              (set! tmp.72 (call L.cons.62.10 cons.62 3440 22))
              (call L.cons.62.10 cons.62 1496 tmp.72))))
        (call L.fun/empty8631.7.11 fun/empty8631.7 tmp.71)))))
(check-by-interp
 '(module
    (define L.fun/empty8634.7.10 (lambda (c.60) (begin (if (!= 14 6) 22 22))))
    (begin
      (set! fun/empty8634.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/empty8634.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
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
                (set! tmp.107
                  (if (begin
                        (set! tmp.108 (bitwise-and tmp.50 7))
                        (= tmp.108 0))
                    14
                    6))
                (!= tmp.107 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.50)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.82 tmp.22)
        (begin
          (set! vector-init-loop.24 (mref c.82 14))
          (begin
            (set! tmp.23
              (begin
                (set! tmp.88
                  (begin
                    (set! tmp.109
                      (begin
                        (set! tmp.110
                          (begin
                            (set! tmp.111
                              (begin
                                (set! tmp.112
                                  (arithmetic-shift-right tmp.22 3))
                                (+ 1 tmp.112)))
                            (* tmp.111 8)))
                        (alloc tmp.110)))
                    (+ tmp.109 3)))
                (begin (mset! tmp.88 -3 tmp.22) tmp.88)))
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
          (if (begin (set! tmp.113 (if (= len.25 i.27) 14 6)) (!= tmp.113 6))
            vec.26
            (begin
              (begin
                (set! tmp.114
                  (begin
                    (set! tmp.115
                      (begin
                        (set! tmp.116 (arithmetic-shift-right i.27 3))
                        (* tmp.116 8)))
                    (+ tmp.115 5)))
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
                (set! tmp.118
                  (if (begin
                        (set! tmp.119 (bitwise-and tmp.53 7))
                        (= tmp.119 0))
                    14
                    6))
                (!= tmp.118 6))
            (if (begin
                  (set! tmp.120
                    (if (begin
                          (set! tmp.121 (bitwise-and tmp.52 7))
                          (= tmp.121 3))
                      14
                      6))
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
                (set! tmp.122
                  (if (begin
                        (set! tmp.123 (mref tmp.28 -3))
                        (< tmp.29 tmp.123))
                    14
                    6))
                (!= tmp.122 6))
            (if (begin (set! tmp.124 (if (>= tmp.29 0) 14 6)) (!= tmp.124 6))
              (begin
                (begin
                  (set! tmp.125
                    (begin
                      (set! tmp.126
                        (begin
                          (set! tmp.127 (arithmetic-shift-right tmp.29 3))
                          (* tmp.127 8)))
                      (+ tmp.126 5)))
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
      (set! error?.76
        (begin
          (set! tmp.89 (begin (set! tmp.129 (alloc 16)) (+ tmp.129 2)))
          (begin (mset! tmp.89 -2 L.error?.76.10) (mset! tmp.89 6 8) tmp.89)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.90 (begin (set! tmp.130 (alloc 16)) (+ tmp.130 2)))
          (begin
            (mset! tmp.90 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.90 6 24)
            tmp.90)))
      (set! vector-set!.75
        (begin
          (set! tmp.91 (begin (set! tmp.131 (alloc 24)) (+ tmp.131 2)))
          (begin
            (mset! tmp.91 -2 L.vector-set!.75.12)
            (mset! tmp.91 6 24)
            tmp.91)))
      (set! vector-init-loop.24
        (begin
          (set! tmp.92 (begin (set! tmp.132 (alloc 24)) (+ tmp.132 2)))
          (begin
            (mset! tmp.92 -2 L.vector-init-loop.24.13)
            (mset! tmp.92 6 24)
            tmp.92)))
      (set! make-init-vector.4
        (begin
          (set! tmp.93 (begin (set! tmp.133 (alloc 24)) (+ tmp.133 2)))
          (begin
            (mset! tmp.93 -2 L.make-init-vector.4.14)
            (mset! tmp.93 6 8)
            tmp.93)))
      (set! make-vector.74
        (begin
          (set! tmp.94 (begin (set! tmp.134 (alloc 24)) (+ tmp.134 2)))
          (begin
            (mset! tmp.94 -2 L.make-vector.74.15)
            (mset! tmp.94 6 8)
            tmp.94)))
      (set! fun/vector8638.8
        (begin
          (set! tmp.95 (begin (set! tmp.135 (alloc 40)) (+ tmp.135 2)))
          (begin
            (mset! tmp.95 -2 L.fun/vector8638.8.16)
            (mset! tmp.95 6 0)
            tmp.95)))
      (set! fun/void8637.9
        (begin
          (set! tmp.96 (begin (set! tmp.136 (alloc 16)) (+ tmp.136 2)))
          (begin
            (mset! tmp.96 -2 L.fun/void8637.9.17)
            (mset! tmp.96 6 0)
            tmp.96)))
      (set! fun/fixnum8639.10
        (begin
          (set! tmp.97 (begin (set! tmp.137 (alloc 16)) (+ tmp.137 2)))
          (begin
            (mset! tmp.97 -2 L.fun/fixnum8639.10.18)
            (mset! tmp.97 6 0)
            tmp.97)))
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
          (set! procedure1.20
            (begin
              (set! lam.77
                (begin
                  (set! tmp.98 (begin (set! tmp.138 (alloc 24)) (+ tmp.138 2)))
                  (begin
                    (mset! tmp.98 -2 L.lam.77.19)
                    (mset! tmp.98 6 0)
                    tmp.98)))
              (begin (mset! lam.77 14 fun/vector8638.8) lam.77)))
          (call L.fun/fixnum8639.10.18 fun/fixnum8639.10))))))
(check-by-interp
 '(module
    (define L.fun/fixnum8642.7.10 (lambda (c.60) (begin 1368)))
    (begin
      (set! fun/fixnum8642.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/fixnum8642.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
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
                (set! tmp.90
                  (if (begin (set! tmp.91 (bitwise-and tmp.47 7)) (= tmp.91 0))
                    14
                    6))
                (!= tmp.90 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.47)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.79 tmp.19)
        (begin
          (set! vector-init-loop.21 (mref c.79 14))
          (begin
            (set! tmp.20
              (begin
                (set! tmp.82
                  (begin
                    (set! tmp.92
                      (begin
                        (set! tmp.93
                          (begin
                            (set! tmp.94
                              (begin
                                (set! tmp.95 (arithmetic-shift-right tmp.19 3))
                                (+ 1 tmp.95)))
                            (* tmp.94 8)))
                        (alloc tmp.93)))
                    (+ tmp.92 3)))
                (begin (mset! tmp.82 -3 tmp.19) tmp.82)))
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
          (if (begin (set! tmp.96 (if (= len.22 i.24) 14 6)) (!= tmp.96 6))
            vec.23
            (begin
              (begin
                (set! tmp.97
                  (begin
                    (set! tmp.98
                      (begin
                        (set! tmp.99 (arithmetic-shift-right i.24 3))
                        (* tmp.99 8)))
                    (+ tmp.98 5)))
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
                (set! tmp.101
                  (if (begin
                        (set! tmp.102 (bitwise-and tmp.50 7))
                        (= tmp.102 0))
                    14
                    6))
                (!= tmp.101 6))
            (if (begin
                  (set! tmp.103
                    (if (begin
                          (set! tmp.104 (bitwise-and tmp.49 7))
                          (= tmp.104 3))
                      14
                      6))
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
                (set! tmp.105
                  (if (begin
                        (set! tmp.106 (mref tmp.25 -3))
                        (< tmp.26 tmp.106))
                    14
                    6))
                (!= tmp.105 6))
            (if (begin (set! tmp.107 (if (>= tmp.26 0) 14 6)) (!= tmp.107 6))
              (begin
                (begin
                  (set! tmp.108
                    (begin
                      (set! tmp.109
                        (begin
                          (set! tmp.110 (arithmetic-shift-right tmp.26 3))
                          (* tmp.110 8)))
                      (+ tmp.109 5)))
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
      (set! error?.73
        (begin
          (set! tmp.83 (begin (set! tmp.112 (alloc 16)) (+ tmp.112 2)))
          (begin (mset! tmp.83 -2 L.error?.73.10) (mset! tmp.83 6 8) tmp.83)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.84 (begin (set! tmp.113 (alloc 16)) (+ tmp.113 2)))
          (begin
            (mset! tmp.84 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.84 6 24)
            tmp.84)))
      (set! vector-set!.72
        (begin
          (set! tmp.85 (begin (set! tmp.114 (alloc 24)) (+ tmp.114 2)))
          (begin
            (mset! tmp.85 -2 L.vector-set!.72.12)
            (mset! tmp.85 6 24)
            tmp.85)))
      (set! vector-init-loop.21
        (begin
          (set! tmp.86 (begin (set! tmp.115 (alloc 24)) (+ tmp.115 2)))
          (begin
            (mset! tmp.86 -2 L.vector-init-loop.21.13)
            (mset! tmp.86 6 24)
            tmp.86)))
      (set! make-init-vector.4
        (begin
          (set! tmp.87 (begin (set! tmp.116 (alloc 24)) (+ tmp.116 2)))
          (begin
            (mset! tmp.87 -2 L.make-init-vector.4.14)
            (mset! tmp.87 6 8)
            tmp.87)))
      (set! make-vector.71
        (begin
          (set! tmp.88 (begin (set! tmp.117 (alloc 24)) (+ tmp.117 2)))
          (begin
            (mset! tmp.88 -2 L.make-vector.71.15)
            (mset! tmp.88 6 8)
            tmp.88)))
      (begin
        (mset! vector-set!.72 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.21 14 vector-init-loop.21)
        (mset! make-init-vector.4 14 vector-init-loop.21)
        (mset! make-vector.71 14 make-init-vector.4)
        (begin
          (set! vector0.8
            (begin
              (set! tmp.7.9 (call L.make-vector.71.15 make-vector.71 64))
              (begin
                (set! g42913205.10
                  (call L.vector-set!.72.12 vector-set!.72 tmp.7.9 0 896))
                (if (begin
                      (set! tmp.118
                        (call L.error?.73.10 error?.73 g42913205.10))
                      (!= tmp.118 6))
                  g42913205.10
                  (begin
                    (set! g42913206.11
                      (begin
                        (set! tmp.119
                          (begin
                            (set! lam.74
                              (begin
                                (set! tmp.89
                                  (begin
                                    (set! tmp.120 (alloc 16))
                                    (+ tmp.120 2)))
                                (begin
                                  (mset! tmp.89 -2 L.lam.74.16)
                                  (mset! tmp.89 6 0)
                                  tmp.89)))
                            lam.74))
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
                      g42913206.11
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
                          g42913207.12
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
                                    (call
                                     L.error?.73.10
                                     error?.73
                                     g42913208.13))
                                  (!= tmp.123 6))
                              g42913208.13
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
                                  g42913209.14
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
                                      g42913210.15
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
                                          g42913211.16
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
                                              g42913212.17
                                              tmp.7.9))))))))))))))))))
          (begin (set! ascii-char0.18 20526) 30))))))
(check-by-interp
 '(module
    (define L.lam.95.20 (lambda (c.106) (begin 46142)))
    (define L.lam.93.18
      (lambda (c.104)
        (begin
          (begin
            (set! lam.94
              (begin
                (set! tmp.107 (begin (set! tmp.119 (alloc 16)) (+ tmp.119 2)))
                (begin
                  (mset! tmp.107 -2 L.lam.94.19)
                  (mset! tmp.107 6 0)
                  tmp.107)))
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
            (set! vector0.16
              (begin
                (set! tmp.7.17 (call L.make-vector.90.15 make-vector.90 64))
                (begin
                  (set! g42917032.18
                    (call L.vector-set!.91.12 vector-set!.91 tmp.7.17 0 0))
                  (if (begin
                        (set! tmp.120
                          (call L.error?.92.10 error?.92 g42917032.18))
                        (!= tmp.120 6))
                    g42917032.18
                    (begin
                      (set! g42917033.19
                        (call L.vector-set!.91.12 vector-set!.91 tmp.7.17 8 8))
                      (if (begin
                            (set! tmp.121
                              (call L.error?.92.10 error?.92 g42917033.19))
                            (!= tmp.121 6))
                        g42917033.19
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
                            g42917034.20
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
                                g42917035.21
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
                                    g42917036.22
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
                                        g42917037.23
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
                                            g42917038.24
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
                                                g42917039.25
                                                tmp.7.17))))))))))))))))))
            23854))))
    (define L.make-vector.90.15
      (lambda (c.101 tmp.66)
        (begin
          (set! make-init-vector.4 (mref c.101 14))
          (if (begin
                (set! tmp.128
                  (if (begin
                        (set! tmp.129 (bitwise-and tmp.66 7))
                        (= tmp.129 0))
                    14
                    6))
                (!= tmp.128 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.66)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.100 tmp.38)
        (begin
          (set! vector-init-loop.40 (mref c.100 14))
          (begin
            (set! tmp.39
              (begin
                (set! tmp.108
                  (begin
                    (set! tmp.130
                      (begin
                        (set! tmp.131
                          (begin
                            (set! tmp.132
                              (begin
                                (set! tmp.133
                                  (arithmetic-shift-right tmp.38 3))
                                (+ 1 tmp.133)))
                            (* tmp.132 8)))
                        (alloc tmp.131)))
                    (+ tmp.130 3)))
                (begin (mset! tmp.108 -3 tmp.38) tmp.108)))
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
          (if (begin (set! tmp.134 (if (= len.41 i.43) 14 6)) (!= tmp.134 6))
            vec.42
            (begin
              (begin
                (set! tmp.135
                  (begin
                    (set! tmp.136
                      (begin
                        (set! tmp.137 (arithmetic-shift-right i.43 3))
                        (* tmp.137 8)))
                    (+ tmp.136 5)))
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
                (set! tmp.139
                  (if (begin
                        (set! tmp.140 (bitwise-and tmp.69 7))
                        (= tmp.140 0))
                    14
                    6))
                (!= tmp.139 6))
            (if (begin
                  (set! tmp.141
                    (if (begin
                          (set! tmp.142 (bitwise-and tmp.68 7))
                          (= tmp.142 3))
                      14
                      6))
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
                (set! tmp.143
                  (if (begin
                        (set! tmp.144 (mref tmp.44 -3))
                        (< tmp.45 tmp.144))
                    14
                    6))
                (!= tmp.143 6))
            (if (begin (set! tmp.145 (if (>= tmp.45 0) 14 6)) (!= tmp.145 6))
              (begin
                (begin
                  (set! tmp.146
                    (begin
                      (set! tmp.147
                        (begin
                          (set! tmp.148 (arithmetic-shift-right tmp.45 3))
                          (* tmp.148 8)))
                      (+ tmp.147 5)))
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
      (set! error?.92
        (begin
          (set! tmp.109 (begin (set! tmp.150 (alloc 16)) (+ tmp.150 2)))
          (begin
            (mset! tmp.109 -2 L.error?.92.10)
            (mset! tmp.109 6 8)
            tmp.109)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.110 (begin (set! tmp.151 (alloc 16)) (+ tmp.151 2)))
          (begin
            (mset! tmp.110 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.110 6 24)
            tmp.110)))
      (set! vector-set!.91
        (begin
          (set! tmp.111 (begin (set! tmp.152 (alloc 24)) (+ tmp.152 2)))
          (begin
            (mset! tmp.111 -2 L.vector-set!.91.12)
            (mset! tmp.111 6 24)
            tmp.111)))
      (set! vector-init-loop.40
        (begin
          (set! tmp.112 (begin (set! tmp.153 (alloc 24)) (+ tmp.153 2)))
          (begin
            (mset! tmp.112 -2 L.vector-init-loop.40.13)
            (mset! tmp.112 6 24)
            tmp.112)))
      (set! make-init-vector.4
        (begin
          (set! tmp.113 (begin (set! tmp.154 (alloc 24)) (+ tmp.154 2)))
          (begin
            (mset! tmp.113 -2 L.make-init-vector.4.14)
            (mset! tmp.113 6 8)
            tmp.113)))
      (set! make-vector.90
        (begin
          (set! tmp.114 (begin (set! tmp.155 (alloc 24)) (+ tmp.155 2)))
          (begin
            (mset! tmp.114 -2 L.make-vector.90.15)
            (mset! tmp.114 6 8)
            tmp.114)))
      (set! fun/ascii-char8647.14
        (begin
          (set! tmp.115 (begin (set! tmp.156 (alloc 40)) (+ tmp.156 2)))
          (begin
            (mset! tmp.115 -2 L.fun/ascii-char8647.14.16)
            (mset! tmp.115 6 0)
            tmp.115)))
      (set! fun/ascii-char8648.15
        (begin
          (set! tmp.116 (begin (set! tmp.157 (alloc 16)) (+ tmp.157 2)))
          (begin
            (mset! tmp.116 -2 L.fun/ascii-char8648.15.17)
            (mset! tmp.116 6 8)
            tmp.116)))
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
              (set! tmp.9.28
                (begin
                  (set! procedure0.29
                    (begin
                      (set! lam.93
                        (begin
                          (set! tmp.117
                            (begin (set! tmp.158 (alloc 16)) (+ tmp.158 2)))
                          (begin
                            (mset! tmp.117 -2 L.lam.93.18)
                            (mset! tmp.117 6 0)
                            tmp.117)))
                      lam.93))
                  29230))
              (if (!= tmp.9.28 6)
                tmp.9.28
                (begin
                  (set! tmp.10.30
                    (begin
                      (set! tmp.11.31
                        (call
                         L.fun/ascii-char8648.15.17
                         fun/ascii-char8648.15
                         1760))
                      (if (!= tmp.11.31 6)
                        tmp.11.31
                        (begin
                          (set! tmp.12.32
                            (begin
                              (set! procedure0.34
                                (begin
                                  (set! lam.95
                                    (begin
                                      (set! tmp.118
                                        (begin
                                          (set! tmp.159 (alloc 16))
                                          (+ tmp.159 2)))
                                      (begin
                                        (mset! tmp.118 -2 L.lam.95.20)
                                        (mset! tmp.118 6 0)
                                        tmp.118)))
                                  lam.95))
                              (set! error1.33 43582)
                              17198))
                          (if (!= tmp.12.32 6)
                            tmp.12.32
                            (begin
                              (set! g42917040.35 23598)
                              (if (begin
                                    (set! tmp.160
                                      (call
                                       L.error?.92.10
                                       error?.92
                                       g42917040.35))
                                    (!= tmp.160 6))
                                g42917040.35
                                24110)))))))
                  (if (!= tmp.10.30 6)
                    tmp.10.30
                    (begin
                      (set! tmp.13.36 (begin (set! error0.37 64830) 21038))
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
                (set! tmp.99
                  (if (begin
                        (set! tmp.100 (bitwise-and tmp.57 7))
                        (= tmp.100 0))
                    14
                    6))
                (!= tmp.99 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.57)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.88 tmp.29)
        (begin
          (set! vector-init-loop.31 (mref c.88 14))
          (begin
            (set! tmp.30
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.101
                      (begin
                        (set! tmp.102
                          (begin
                            (set! tmp.103
                              (begin
                                (set! tmp.104
                                  (arithmetic-shift-right tmp.29 3))
                                (+ 1 tmp.104)))
                            (* tmp.103 8)))
                        (alloc tmp.102)))
                    (+ tmp.101 3)))
                (begin (mset! tmp.91 -3 tmp.29) tmp.91)))
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
          (if (begin (set! tmp.105 (if (= len.32 i.34) 14 6)) (!= tmp.105 6))
            vec.33
            (begin
              (begin
                (set! tmp.106
                  (begin
                    (set! tmp.107
                      (begin
                        (set! tmp.108 (arithmetic-shift-right i.34 3))
                        (* tmp.108 8)))
                    (+ tmp.107 5)))
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
                (set! tmp.110
                  (if (begin
                        (set! tmp.111 (bitwise-and tmp.60 7))
                        (= tmp.111 0))
                    14
                    6))
                (!= tmp.110 6))
            (if (begin
                  (set! tmp.112
                    (if (begin
                          (set! tmp.113 (bitwise-and tmp.59 7))
                          (= tmp.113 3))
                      14
                      6))
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
                (set! tmp.114
                  (if (begin
                        (set! tmp.115 (mref tmp.35 -3))
                        (< tmp.36 tmp.115))
                    14
                    6))
                (!= tmp.114 6))
            (if (begin (set! tmp.116 (if (>= tmp.36 0) 14 6)) (!= tmp.116 6))
              (begin
                (begin
                  (set! tmp.117
                    (begin
                      (set! tmp.118
                        (begin
                          (set! tmp.119 (arithmetic-shift-right tmp.36 3))
                          (* tmp.119 8)))
                      (+ tmp.118 5)))
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
      (set! error?.83
        (begin
          (set! tmp.92 (begin (set! tmp.121 (alloc 16)) (+ tmp.121 2)))
          (begin (mset! tmp.92 -2 L.error?.83.10) (mset! tmp.92 6 8) tmp.92)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.93 (begin (set! tmp.122 (alloc 16)) (+ tmp.122 2)))
          (begin
            (mset! tmp.93 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.93 6 24)
            tmp.93)))
      (set! vector-set!.82
        (begin
          (set! tmp.94 (begin (set! tmp.123 (alloc 24)) (+ tmp.123 2)))
          (begin
            (mset! tmp.94 -2 L.vector-set!.82.12)
            (mset! tmp.94 6 24)
            tmp.94)))
      (set! vector-init-loop.31
        (begin
          (set! tmp.95 (begin (set! tmp.124 (alloc 24)) (+ tmp.124 2)))
          (begin
            (mset! tmp.95 -2 L.vector-init-loop.31.13)
            (mset! tmp.95 6 24)
            tmp.95)))
      (set! make-init-vector.4
        (begin
          (set! tmp.96 (begin (set! tmp.125 (alloc 24)) (+ tmp.125 2)))
          (begin
            (mset! tmp.96 -2 L.make-init-vector.4.14)
            (mset! tmp.96 6 8)
            tmp.96)))
      (set! make-vector.81
        (begin
          (set! tmp.97 (begin (set! tmp.126 (alloc 24)) (+ tmp.126 2)))
          (begin
            (mset! tmp.97 -2 L.make-vector.81.15)
            (mset! tmp.97 6 8)
            tmp.97)))
      (set! fun/void8651.9
        (begin
          (set! tmp.98 (begin (set! tmp.127 (alloc 16)) (+ tmp.127 2)))
          (begin
            (mset! tmp.98 -2 L.fun/void8651.9.16)
            (mset! tmp.98 6 0)
            tmp.98)))
      (begin
        (mset! vector-set!.82 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.31 14 vector-init-loop.31)
        (mset! make-init-vector.4 14 vector-init-loop.31)
        (mset! make-vector.81 14 make-init-vector.4)
        (begin
          (set! vector0.10
            (begin
              (set! tmp.7.11 (call L.make-vector.81.15 make-vector.81 64))
              (begin
                (set! g42920858.12
                  (call L.vector-set!.82.12 vector-set!.82 tmp.7.11 0 22))
                (if (begin
                      (set! tmp.128
                        (call L.error?.83.10 error?.83 g42920858.12))
                      (!= tmp.128 6))
                  g42920858.12
                  (begin
                    (set! g42920859.13
                      (begin
                        (set! tmp.129
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
                                      (call
                                       L.error?.83.10
                                       error?.83
                                       g42920860.15))
                                    (!= tmp.130 6))
                                g42920860.15
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
                                    g42920861.16
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
                                        g42920862.17
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
                                            g42920863.18
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
                                                g42920864.19
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
                                                    g42920865.20
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
                                                        g42920866.21
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
                                                            g42920867.22
                                                            tmp.8.14))))))))))))))))))
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
                      g42920859.13
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
                          g42920868.23
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
                                    (call
                                     L.error?.83.10
                                     error?.83
                                     g42920869.24))
                                  (!= tmp.140 6))
                              g42920869.24
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
                                  g42920870.25
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
                                      g42920871.26
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
                                          g42920872.27
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
                                              g42920873.28
                                              tmp.7.11))))))))))))))))))
          (call L.fun/void8651.9.16 fun/void8651.9))))))
(check-by-interp
 '(module
    (define L.lam.64.12 (lambda (c.67) (begin 7264)))
    (define L.lam.63.11 (lambda (c.66 oprand0.10) (begin 14)))
    (define L.fun/void8654.7.10
      (lambda (c.65 oprand0.8) (begin (if (!= 6 6) 30 30))))
    (begin
      (set! fun/void8654.7
        (begin
          (set! tmp.68 (begin (set! tmp.71 (alloc 16)) (+ tmp.71 2)))
          (begin
            (mset! tmp.68 -2 L.fun/void8654.7.10)
            (mset! tmp.68 6 8)
            tmp.68)))
      (begin
        (set! tmp.72
          (begin
            (set! procedure0.9
              (begin
                (set! lam.63
                  (begin
                    (set! tmp.69 (begin (set! tmp.73 (alloc 16)) (+ tmp.73 2)))
                    (begin
                      (mset! tmp.69 -2 L.lam.63.11)
                      (mset! tmp.69 6 8)
                      tmp.69)))
                lam.63))
            (begin
              (set! lam.64
                (begin
                  (set! tmp.70 (begin (set! tmp.74 (alloc 16)) (+ tmp.74 2)))
                  (begin
                    (mset! tmp.70 -2 L.lam.64.12)
                    (mset! tmp.70 6 0)
                    tmp.70)))
              lam.64)))
        (call L.fun/void8654.7.10 fun/void8654.7 tmp.72)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8657.7.10 (lambda (c.61 oprand0.8) (begin 24110)))
    (begin
      (set! fun/ascii-char8657.7
        (begin
          (set! tmp.62 (begin (set! tmp.63 (alloc 16)) (+ tmp.63 2)))
          (begin
            (mset! tmp.62 -2 L.fun/ascii-char8657.7.10)
            (mset! tmp.62 6 8)
            tmp.62)))
      (begin (call L.fun/ascii-char8657.7.10 fun/ascii-char8657.7 30)))))
(check-by-interp
 '(module
    (define L.fun/empty8660.8.11 (lambda (c.64) (begin 22)))
    (define L.fun/fixnum8661.7.10 (lambda (c.63) (begin 976)))
    (begin
      (set! fun/fixnum8661.7
        (begin
          (set! tmp.65 (begin (set! tmp.67 (alloc 16)) (+ tmp.67 2)))
          (begin
            (mset! tmp.65 -2 L.fun/fixnum8661.7.10)
            (mset! tmp.65 6 0)
            tmp.65)))
      (set! fun/empty8660.8
        (begin
          (set! tmp.66 (begin (set! tmp.68 (alloc 16)) (+ tmp.68 2)))
          (begin
            (mset! tmp.66 -2 L.fun/empty8660.8.11)
            (mset! tmp.66 6 0)
            tmp.66)))
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
            (set! tmp.70 (begin (set! tmp.75 (alloc 16)) (+ tmp.75 1)))
            (begin (mset! tmp.70 -1 tmp.60) (mset! tmp.70 7 tmp.61) tmp.70)))))
    (begin
      (set! cons.66
        (begin
          (set! tmp.71 (begin (set! tmp.76 (alloc 16)) (+ tmp.76 2)))
          (begin (mset! tmp.71 -2 L.cons.66.10) (mset! tmp.71 6 16) tmp.71)))
      (set! error?.65
        (begin
          (set! tmp.72 (begin (set! tmp.77 (alloc 16)) (+ tmp.77 2)))
          (begin (mset! tmp.72 -2 L.error?.65.11) (mset! tmp.72 6 8) tmp.72)))
      (set! fun/fixnum8664.7
        (begin
          (set! tmp.73 (begin (set! tmp.78 (alloc 16)) (+ tmp.78 2)))
          (begin
            (mset! tmp.73 -2 L.fun/fixnum8664.7.12)
            (mset! tmp.73 6 8)
            tmp.73)))
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
            (set! tmp.83
              (begin
                (set! tmp.84 (call L.cons.66.10 cons.66 3624 22))
                (call L.cons.66.10 cons.66 1640 tmp.84)))
            (call L.fun/fixnum8664.7.12 fun/fixnum8664.7 tmp.83))
          6)
        6))))
(check-by-interp
 '(module
    (define L.fun/error8667.7.10
      (lambda (c.61 oprand0.8) (begin (if (!= 14 6) 62270 46654))))
    (begin
      (set! fun/error8667.7
        (begin
          (set! tmp.62 (begin (set! tmp.63 (alloc 16)) (+ tmp.63 2)))
          (begin
            (mset! tmp.62 -2 L.fun/error8667.7.10)
            (mset! tmp.62 6 8)
            tmp.62)))
      (begin
        (set! tmp.64 (if (!= 6 6) 27438 27694))
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
      (set! error?.66
        (begin
          (set! tmp.70 (begin (set! tmp.74 (alloc 16)) (+ tmp.74 2)))
          (begin (mset! tmp.70 -2 L.error?.66.10) (mset! tmp.70 6 8) tmp.70)))
      (set! fun/empty8670.9
        (begin
          (set! tmp.71 (begin (set! tmp.75 (alloc 16)) (+ tmp.75 2)))
          (begin
            (mset! tmp.71 -2 L.fun/empty8670.9.11)
            (mset! tmp.71 6 0)
            tmp.71)))
      (set! fun/empty8671.10
        (begin
          (set! tmp.72 (begin (set! tmp.76 (alloc 16)) (+ tmp.76 2)))
          (begin
            (mset! tmp.72 -2 L.fun/empty8671.10.12)
            (mset! tmp.72 6 0)
            tmp.72)))
      (begin
        (set! g42943766.11
          (begin
            (set! tmp.7.12 (call L.fun/empty8670.9.11 fun/empty8670.9))
            (if (!= tmp.7.12 6)
              tmp.7.12
              (begin
                (set! tmp.8.13 (if (!= 6 6) 22 22))
                (if (!= tmp.8.13 6) tmp.8.13 22)))))
        (if (begin
              (set! tmp.77 (call L.error?.66.10 error?.66 g42943766.11))
              (!= tmp.77 6))
          g42943766.11
          (call L.fun/empty8671.10.12 fun/empty8671.10))))))
(check-by-interp
 '(module
    (define L.fun/void8674.7.10 (lambda (c.60) (begin 30)))
    (begin
      (set! fun/void8674.7
        (begin
          (set! tmp.61 (begin (set! tmp.62 (alloc 16)) (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/void8674.7.10)
            (mset! tmp.61 6 0)
            tmp.61)))
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
            (set! tmp.95 (begin (set! tmp.111 (alloc 16)) (+ tmp.111 1)))
            (begin (mset! tmp.95 -1 tmp.69) (mset! tmp.95 7 tmp.70) tmp.95)))))
    (define L.make-vector.76.15
      (lambda (c.87 tmp.50)
        (begin
          (set! make-init-vector.4 (mref c.87 14))
          (if (begin
                (set! tmp.112
                  (if (begin
                        (set! tmp.113 (bitwise-and tmp.50 7))
                        (= tmp.113 0))
                    14
                    6))
                (!= tmp.112 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.50)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.86 tmp.22)
        (begin
          (set! vector-init-loop.24 (mref c.86 14))
          (begin
            (set! tmp.23
              (begin
                (set! tmp.96
                  (begin
                    (set! tmp.114
                      (begin
                        (set! tmp.115
                          (begin
                            (set! tmp.116
                              (begin
                                (set! tmp.117
                                  (arithmetic-shift-right tmp.22 3))
                                (+ 1 tmp.117)))
                            (* tmp.116 8)))
                        (alloc tmp.115)))
                    (+ tmp.114 3)))
                (begin (mset! tmp.96 -3 tmp.22) tmp.96)))
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
          (if (begin (set! tmp.118 (if (= len.25 i.27) 14 6)) (!= tmp.118 6))
            vec.26
            (begin
              (begin
                (set! tmp.119
                  (begin
                    (set! tmp.120
                      (begin
                        (set! tmp.121 (arithmetic-shift-right i.27 3))
                        (* tmp.121 8)))
                    (+ tmp.120 5)))
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
                (set! tmp.123
                  (if (begin
                        (set! tmp.124 (bitwise-and tmp.53 7))
                        (= tmp.124 0))
                    14
                    6))
                (!= tmp.123 6))
            (if (begin
                  (set! tmp.125
                    (if (begin
                          (set! tmp.126 (bitwise-and tmp.52 7))
                          (= tmp.126 3))
                      14
                      6))
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
                (set! tmp.127
                  (if (begin
                        (set! tmp.128 (mref tmp.28 -3))
                        (< tmp.29 tmp.128))
                    14
                    6))
                (!= tmp.127 6))
            (if (begin (set! tmp.129 (if (>= tmp.29 0) 14 6)) (!= tmp.129 6))
              (begin
                (begin
                  (set! tmp.130
                    (begin
                      (set! tmp.131
                        (begin
                          (set! tmp.132 (arithmetic-shift-right tmp.29 3))
                          (* tmp.132 8)))
                      (+ tmp.131 5)))
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
      (set! error?.78
        (begin
          (set! tmp.97 (begin (set! tmp.134 (alloc 16)) (+ tmp.134 2)))
          (begin (mset! tmp.97 -2 L.error?.78.10) (mset! tmp.97 6 8) tmp.97)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.98 (begin (set! tmp.135 (alloc 16)) (+ tmp.135 2)))
          (begin
            (mset! tmp.98 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.98 6 24)
            tmp.98)))
      (set! vector-set!.77
        (begin
          (set! tmp.99 (begin (set! tmp.136 (alloc 24)) (+ tmp.136 2)))
          (begin
            (mset! tmp.99 -2 L.vector-set!.77.12)
            (mset! tmp.99 6 24)
            tmp.99)))
      (set! vector-init-loop.24
        (begin
          (set! tmp.100 (begin (set! tmp.137 (alloc 24)) (+ tmp.137 2)))
          (begin
            (mset! tmp.100 -2 L.vector-init-loop.24.13)
            (mset! tmp.100 6 24)
            tmp.100)))
      (set! make-init-vector.4
        (begin
          (set! tmp.101 (begin (set! tmp.138 (alloc 24)) (+ tmp.138 2)))
          (begin
            (mset! tmp.101 -2 L.make-init-vector.4.14)
            (mset! tmp.101 6 8)
            tmp.101)))
      (set! make-vector.76
        (begin
          (set! tmp.102 (begin (set! tmp.139 (alloc 24)) (+ tmp.139 2)))
          (begin
            (mset! tmp.102 -2 L.make-vector.76.15)
            (mset! tmp.102 6 8)
            tmp.102)))
      (set! cons.75
        (begin
          (set! tmp.103 (begin (set! tmp.140 (alloc 16)) (+ tmp.140 2)))
          (begin
            (mset! tmp.103 -2 L.cons.75.16)
            (mset! tmp.103 6 16)
            tmp.103)))
      (set! fixnum?.74
        (begin
          (set! tmp.104 (begin (set! tmp.141 (alloc 16)) (+ tmp.141 2)))
          (begin
            (mset! tmp.104 -2 L.fixnum?.74.17)
            (mset! tmp.104 6 8)
            tmp.104)))
      (set! fun/void8678.8
        (begin
          (set! tmp.105 (begin (set! tmp.142 (alloc 16)) (+ tmp.142 2)))
          (begin
            (mset! tmp.105 -2 L.fun/void8678.8.18)
            (mset! tmp.105 6 0)
            tmp.105)))
      (set! fun/any8677.9
        (begin
          (set! tmp.106 (begin (set! tmp.143 (alloc 16)) (+ tmp.143 2)))
          (begin
            (mset! tmp.106 -2 L.fun/any8677.9.19)
            (mset! tmp.106 6 0)
            tmp.106)))
      (begin
        (mset! vector-set!.77 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.4 14 vector-init-loop.24)
        (mset! make-vector.76 14 make-init-vector.4)
        (begin
          (set! boolean0.12
            (begin
              (set! tmp.144 (call L.fun/any8677.9.19 fun/any8677.9))
              (call L.fixnum?.74.17 fixnum?.74 tmp.144)))
          (set! pair1.11
            (begin
              (set! tmp.145
                (begin
                  (set! tmp.146
                    (begin
                      (set! tmp.147 (call L.cons.75.16 cons.75 2816 22))
                      (call L.cons.75.16 cons.75 480 tmp.147)))
                  (begin
                    (set! tmp.148
                      (begin
                        (set! tmp.149
                          (begin
                            (set! tmp.150
                              (begin
                                (set! tmp.151
                                  (begin
                                    (set! tmp.152
                                      (begin
                                        (set! tmp.153
                                          (call L.cons.75.16 cons.75 3560 22))
                                        (call
                                         L.cons.75.16
                                         cons.75
                                         1464
                                         tmp.153)))
                                    (begin
                                      (set! tmp.154
                                        (begin
                                          (set! tmp.155
                                            (call L.cons.75.16 cons.75 14 22))
                                          (call
                                           L.cons.75.16
                                           cons.75
                                           6
                                           tmp.155)))
                                      (call
                                       L.cons.75.16
                                       cons.75
                                       tmp.152
                                       tmp.154))))
                                (call L.cons.75.16 cons.75 26670 tmp.151)))
                            (call L.cons.75.16 cons.75 6 tmp.150)))
                        (call L.cons.75.16 cons.75 21806 tmp.149)))
                    (call L.cons.75.16 cons.75 tmp.146 tmp.148))))
              (call L.cons.75.16 cons.75 14 tmp.145)))
          (set! vector2.10
            (begin
              (set! tmp.7.13 (call L.make-vector.76.15 make-vector.76 64))
              (begin
                (set! g42951404.14
                  (begin
                    (set! tmp.156
                      (begin
                        (set! tmp.157 (call L.cons.75.16 cons.75 2120 22))
                        (call L.cons.75.16 cons.75 1680 tmp.157)))
                    (call
                     L.vector-set!.77.12
                     vector-set!.77
                     tmp.7.13
                     0
                     tmp.156)))
                (if (begin
                      (set! tmp.158
                        (call L.error?.78.10 error?.78 g42951404.14))
                      (!= tmp.158 6))
                  g42951404.14
                  (begin
                    (set! g42951405.15
                      (begin
                        (set! tmp.159 (begin 12606))
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
                      g42951405.15
                      (begin
                        (set! g42951406.16
                          (begin
                            (set! tmp.161
                              (begin
                                (begin
                                  (set! lam.79
                                    (begin
                                      (set! tmp.107
                                        (begin
                                          (set! tmp.162 (alloc 16))
                                          (+ tmp.162 2)))
                                      (begin
                                        (mset! tmp.107 -2 L.lam.79.20)
                                        (mset! tmp.107 6 0)
                                        tmp.107)))
                                  lam.79)))
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
                          g42951406.16
                          (begin
                            (set! g42951407.17
                              (begin
                                (set! tmp.164
                                  (call L.fun/void8678.8.18 fun/void8678.8))
                                (call
                                 L.vector-set!.77.12
                                 vector-set!.77
                                 tmp.7.13
                                 24
                                 tmp.164)))
                            (if (begin
                                  (set! tmp.165
                                    (call
                                     L.error?.78.10
                                     error?.78
                                     g42951407.17))
                                  (!= tmp.165 6))
                              g42951407.17
                              (begin
                                (set! g42951408.18
                                  (begin
                                    (set! tmp.166 (if (!= 6 6) 30 30))
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
                                  g42951408.18
                                  (begin
                                    (set! g42951409.19
                                      (begin
                                        (set! tmp.168 (begin 1432))
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
                                      g42951409.19
                                      (begin
                                        (set! g42951410.20
                                          (begin
                                            (set! tmp.170
                                              (if (!= 14 6)
                                                (begin
                                                  (set! lam.80
                                                    (begin
                                                      (set! tmp.108
                                                        (begin
                                                          (set! tmp.171
                                                            (alloc 16))
                                                          (+ tmp.171 2)))
                                                      (begin
                                                        (mset!
                                                         tmp.108
                                                         -2
                                                         L.lam.80.21)
                                                        (mset! tmp.108 6 0)
                                                        tmp.108)))
                                                  lam.80)
                                                (begin
                                                  (set! lam.81
                                                    (begin
                                                      (set! tmp.109
                                                        (begin
                                                          (set! tmp.172
                                                            (alloc 16))
                                                          (+ tmp.172 2)))
                                                      (begin
                                                        (mset!
                                                         tmp.109
                                                         -2
                                                         L.lam.81.22)
                                                        (mset! tmp.109 6 0)
                                                        tmp.109)))
                                                  lam.81)))
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
                                          g42951410.20
                                          (begin
                                            (set! g42951411.21
                                              (begin
                                                (set! tmp.174
                                                  (if (!= 1728 6)
                                                    (if (!= 808 6)
                                                      (if (!= 64 6)
                                                        (if (!= 624 6) 1872 6)
                                                        6)
                                                      6)
                                                    6))
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
                                              g42951411.21
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
            (set! tmp.113 (begin (set! tmp.136 (alloc 16)) (+ tmp.136 1)))
            (begin
              (mset! tmp.113 -1 tmp.89)
              (mset! tmp.113 7 tmp.90)
              tmp.113)))))
    (define L.make-vector.95.16
      (lambda (c.106 tmp.70)
        (begin
          (set! make-init-vector.4 (mref c.106 14))
          (if (begin
                (set! tmp.137
                  (if (begin
                        (set! tmp.138 (bitwise-and tmp.70 7))
                        (= tmp.138 0))
                    14
                    6))
                (!= tmp.137 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.70)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.105 tmp.42)
        (begin
          (set! vector-init-loop.44 (mref c.105 14))
          (begin
            (set! tmp.43
              (begin
                (set! tmp.114
                  (begin
                    (set! tmp.139
                      (begin
                        (set! tmp.140
                          (begin
                            (set! tmp.141
                              (begin
                                (set! tmp.142
                                  (arithmetic-shift-right tmp.42 3))
                                (+ 1 tmp.142)))
                            (* tmp.141 8)))
                        (alloc tmp.140)))
                    (+ tmp.139 3)))
                (begin (mset! tmp.114 -3 tmp.42) tmp.114)))
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
          (if (begin (set! tmp.143 (if (= len.45 i.47) 14 6)) (!= tmp.143 6))
            vec.46
            (begin
              (begin
                (set! tmp.144
                  (begin
                    (set! tmp.145
                      (begin
                        (set! tmp.146 (arithmetic-shift-right i.47 3))
                        (* tmp.146 8)))
                    (+ tmp.145 5)))
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
                (set! tmp.148
                  (if (begin
                        (set! tmp.149 (bitwise-and tmp.73 7))
                        (= tmp.149 0))
                    14
                    6))
                (!= tmp.148 6))
            (if (begin
                  (set! tmp.150
                    (if (begin
                          (set! tmp.151 (bitwise-and tmp.72 7))
                          (= tmp.151 3))
                      14
                      6))
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
                (set! tmp.152
                  (if (begin
                        (set! tmp.153 (mref tmp.48 -3))
                        (< tmp.49 tmp.153))
                    14
                    6))
                (!= tmp.152 6))
            (if (begin (set! tmp.154 (if (>= tmp.49 0) 14 6)) (!= tmp.154 6))
              (begin
                (begin
                  (set! tmp.155
                    (begin
                      (set! tmp.156
                        (begin
                          (set! tmp.157 (arithmetic-shift-right tmp.49 3))
                          (* tmp.157 8)))
                      (+ tmp.156 5)))
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
      (set! procedure?.98
        (begin
          (set! tmp.115 (begin (set! tmp.160 (alloc 16)) (+ tmp.160 2)))
          (begin
            (mset! tmp.115 -2 L.procedure?.98.10)
            (mset! tmp.115 6 8)
            tmp.115)))
      (set! error?.97
        (begin
          (set! tmp.116 (begin (set! tmp.161 (alloc 16)) (+ tmp.161 2)))
          (begin
            (mset! tmp.116 -2 L.error?.97.11)
            (mset! tmp.116 6 8)
            tmp.116)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.117 (begin (set! tmp.162 (alloc 16)) (+ tmp.162 2)))
          (begin
            (mset! tmp.117 -2 L.unsafe-vector-set!.5.12)
            (mset! tmp.117 6 24)
            tmp.117)))
      (set! vector-set!.96
        (begin
          (set! tmp.118 (begin (set! tmp.163 (alloc 24)) (+ tmp.163 2)))
          (begin
            (mset! tmp.118 -2 L.vector-set!.96.13)
            (mset! tmp.118 6 24)
            tmp.118)))
      (set! vector-init-loop.44
        (begin
          (set! tmp.119 (begin (set! tmp.164 (alloc 24)) (+ tmp.164 2)))
          (begin
            (mset! tmp.119 -2 L.vector-init-loop.44.14)
            (mset! tmp.119 6 24)
            tmp.119)))
      (set! make-init-vector.4
        (begin
          (set! tmp.120 (begin (set! tmp.165 (alloc 24)) (+ tmp.165 2)))
          (begin
            (mset! tmp.120 -2 L.make-init-vector.4.15)
            (mset! tmp.120 6 8)
            tmp.120)))
      (set! make-vector.95
        (begin
          (set! tmp.121 (begin (set! tmp.166 (alloc 24)) (+ tmp.166 2)))
          (begin
            (mset! tmp.121 -2 L.make-vector.95.16)
            (mset! tmp.121 6 8)
            tmp.121)))
      (set! cons.94
        (begin
          (set! tmp.122 (begin (set! tmp.167 (alloc 16)) (+ tmp.167 2)))
          (begin
            (mset! tmp.122 -2 L.cons.94.17)
            (mset! tmp.122 6 16)
            tmp.122)))
      (set! fun/error8682.16
        (begin
          (set! tmp.123 (begin (set! tmp.168 (alloc 16)) (+ tmp.168 2)))
          (begin
            (mset! tmp.123 -2 L.fun/error8682.16.18)
            (mset! tmp.123 6 0)
            tmp.123)))
      (set! fun/boolean8683.17
        (begin
          (set! tmp.124 (begin (set! tmp.169 (alloc 16)) (+ tmp.169 2)))
          (begin
            (mset! tmp.124 -2 L.fun/boolean8683.17.19)
            (mset! tmp.124 6 0)
            tmp.124)))
      (set! fun/error8681.18
        (begin
          (set! tmp.125 (begin (set! tmp.170 (alloc 24)) (+ tmp.170 2)))
          (begin
            (mset! tmp.125 -2 L.fun/error8681.18.20)
            (mset! tmp.125 6 0)
            tmp.125)))
      (set! fun/boolean8684.19
        (begin
          (set! tmp.126 (begin (set! tmp.171 (alloc 16)) (+ tmp.171 2)))
          (begin
            (mset! tmp.126 -2 L.fun/boolean8684.19.21)
            (mset! tmp.126 6 0)
            tmp.126)))
      (begin
        (mset! vector-set!.96 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.44 14 vector-init-loop.44)
        (mset! make-init-vector.4 14 vector-init-loop.44)
        (mset! make-vector.95 14 make-init-vector.4)
        (mset! fun/error8681.18 14 fun/error8682.16)
        (begin
          (set! pair0.22
            (begin
              (set! tmp.172
                (begin
                  (set! tmp.173 (call L.cons.94.17 cons.94 2168 22))
                  (call L.cons.94.17 cons.94 1744 tmp.173)))
              (begin
                (set! tmp.174
                  (begin
                    (set! tmp.175
                      (begin
                        (set! tmp.176
                          (begin
                            (set! tmp.177 (call L.cons.94.17 cons.94 4040 22))
                            (call L.cons.94.17 cons.94 1760 tmp.177)))
                        (begin
                          (set! tmp.178
                            (begin
                              (set! tmp.179
                                (begin
                                  (set! tmp.180
                                    (call L.cons.94.17 cons.94 2248 22))
                                  (call L.cons.94.17 cons.94 1968 tmp.180)))
                              (begin
                                (set! tmp.181
                                  (begin
                                    (set! tmp.182
                                      (begin
                                        (set! tmp.183
                                          (begin
                                            (set! tmp.184
                                              (begin
                                                (set! tmp.185
                                                  (call
                                                   L.cons.94.17
                                                   cons.94
                                                   2312
                                                   22))
                                                (call
                                                 L.cons.94.17
                                                 cons.94
                                                 1184
                                                 tmp.185)))
                                            (begin
                                              (set! tmp.186
                                                (call
                                                 L.cons.94.17
                                                 cons.94
                                                 25902
                                                 22))
                                              (call
                                               L.cons.94.17
                                               cons.94
                                               tmp.184
                                               tmp.186))))
                                        (call
                                         L.cons.94.17
                                         cons.94
                                         22
                                         tmp.183)))
                                    (call L.cons.94.17 cons.94 14 tmp.182)))
                                (call L.cons.94.17 cons.94 tmp.179 tmp.181))))
                          (call L.cons.94.17 cons.94 tmp.176 tmp.178))))
                    (call L.cons.94.17 cons.94 14 tmp.175)))
                (call L.cons.94.17 cons.94 tmp.172 tmp.174))))
          (set! error1.21 (call L.fun/error8681.18.20 fun/error8681.18))
          (set! procedure2.20
            (begin
              (set! lam.99
                (begin
                  (set! tmp.127
                    (begin (set! tmp.187 (alloc 40)) (+ tmp.187 2)))
                  (begin
                    (mset! tmp.127 -2 L.lam.99.22)
                    (mset! tmp.127 6 0)
                    tmp.127)))
              (begin
                (mset! lam.99 14 make-vector.95)
                (mset! lam.99 22 error?.97)
                (mset! lam.99 30 vector-set!.96)
                lam.99)))
          (begin
            (set! tmp.8.32 (if (!= 6 6) 6 14))
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
                            (set! tmp.12.36
                              (begin
                                (set! g42955234.37 6)
                                (if (begin
                                      (set! tmp.188
                                        (call
                                         L.error?.97.11
                                         error?.97
                                         g42955234.37))
                                      (!= tmp.188 6))
                                  g42955234.37
                                  (begin
                                    (set! g42955235.38 14)
                                    (if (begin
                                          (set! tmp.189
                                            (call
                                             L.error?.97.11
                                             error?.97
                                             g42955235.38))
                                          (!= tmp.189 6))
                                      g42955235.38
                                      14)))))
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
            (set! tmp.103 (begin (set! tmp.114 (alloc 16)) (+ tmp.114 1)))
            (begin
              (mset! tmp.103 -1 tmp.85)
              (mset! tmp.103 7 tmp.86)
              tmp.103)))))
    (define L.make-vector.91.15
      (lambda (c.99 tmp.66)
        (begin
          (set! make-init-vector.4 (mref c.99 14))
          (if (begin
                (set! tmp.115
                  (if (begin
                        (set! tmp.116 (bitwise-and tmp.66 7))
                        (= tmp.116 0))
                    14
                    6))
                (!= tmp.115 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.66)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.98 tmp.38)
        (begin
          (set! vector-init-loop.40 (mref c.98 14))
          (begin
            (set! tmp.39
              (begin
                (set! tmp.104
                  (begin
                    (set! tmp.117
                      (begin
                        (set! tmp.118
                          (begin
                            (set! tmp.119
                              (begin
                                (set! tmp.120
                                  (arithmetic-shift-right tmp.38 3))
                                (+ 1 tmp.120)))
                            (* tmp.119 8)))
                        (alloc tmp.118)))
                    (+ tmp.117 3)))
                (begin (mset! tmp.104 -3 tmp.38) tmp.104)))
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
          (if (begin (set! tmp.121 (if (= len.41 i.43) 14 6)) (!= tmp.121 6))
            vec.42
            (begin
              (begin
                (set! tmp.122
                  (begin
                    (set! tmp.123
                      (begin
                        (set! tmp.124 (arithmetic-shift-right i.43 3))
                        (* tmp.124 8)))
                    (+ tmp.123 5)))
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
                (set! tmp.126
                  (if (begin
                        (set! tmp.127 (bitwise-and tmp.69 7))
                        (= tmp.127 0))
                    14
                    6))
                (!= tmp.126 6))
            (if (begin
                  (set! tmp.128
                    (if (begin
                          (set! tmp.129 (bitwise-and tmp.68 7))
                          (= tmp.129 3))
                      14
                      6))
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
                (set! tmp.130
                  (if (begin
                        (set! tmp.131 (mref tmp.44 -3))
                        (< tmp.45 tmp.131))
                    14
                    6))
                (!= tmp.130 6))
            (if (begin (set! tmp.132 (if (>= tmp.45 0) 14 6)) (!= tmp.132 6))
              (begin
                (begin
                  (set! tmp.133
                    (begin
                      (set! tmp.134
                        (begin
                          (set! tmp.135 (arithmetic-shift-right tmp.45 3))
                          (* tmp.135 8)))
                      (+ tmp.134 5)))
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
      (set! error?.93
        (begin
          (set! tmp.105 (begin (set! tmp.137 (alloc 16)) (+ tmp.137 2)))
          (begin
            (mset! tmp.105 -2 L.error?.93.10)
            (mset! tmp.105 6 8)
            tmp.105)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.106 (begin (set! tmp.138 (alloc 16)) (+ tmp.138 2)))
          (begin
            (mset! tmp.106 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.106 6 24)
            tmp.106)))
      (set! vector-set!.92
        (begin
          (set! tmp.107 (begin (set! tmp.139 (alloc 24)) (+ tmp.139 2)))
          (begin
            (mset! tmp.107 -2 L.vector-set!.92.12)
            (mset! tmp.107 6 24)
            tmp.107)))
      (set! vector-init-loop.40
        (begin
          (set! tmp.108 (begin (set! tmp.140 (alloc 24)) (+ tmp.140 2)))
          (begin
            (mset! tmp.108 -2 L.vector-init-loop.40.13)
            (mset! tmp.108 6 24)
            tmp.108)))
      (set! make-init-vector.4
        (begin
          (set! tmp.109 (begin (set! tmp.141 (alloc 24)) (+ tmp.141 2)))
          (begin
            (mset! tmp.109 -2 L.make-init-vector.4.14)
            (mset! tmp.109 6 8)
            tmp.109)))
      (set! make-vector.91
        (begin
          (set! tmp.110 (begin (set! tmp.142 (alloc 24)) (+ tmp.142 2)))
          (begin
            (mset! tmp.110 -2 L.make-vector.91.15)
            (mset! tmp.110 6 8)
            tmp.110)))
      (set! cons.90
        (begin
          (set! tmp.111 (begin (set! tmp.143 (alloc 16)) (+ tmp.143 2)))
          (begin
            (mset! tmp.111 -2 L.cons.90.16)
            (mset! tmp.111 6 16)
            tmp.111)))
      (set! fun/error8688.15
        (begin
          (set! tmp.112 (begin (set! tmp.144 (alloc 16)) (+ tmp.144 2)))
          (begin
            (mset! tmp.112 -2 L.fun/error8688.15.17)
            (mset! tmp.112 6 0)
            tmp.112)))
      (set! fun/error8687.16
        (begin
          (set! tmp.113 (begin (set! tmp.145 (alloc 24)) (+ tmp.145 2)))
          (begin
            (mset! tmp.113 -2 L.fun/error8687.16.18)
            (mset! tmp.113 6 16)
            tmp.113)))
      (begin
        (mset! vector-set!.92 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.40 14 vector-init-loop.40)
        (mset! make-init-vector.4 14 vector-init-loop.40)
        (mset! make-vector.91 14 make-init-vector.4)
        (mset! fun/error8687.16 14 fun/error8688.15)
        (begin
          (set! tmp.7.19
            (begin
              (set! tmp.8.20 (begin (set! error0.21 59966) 45630))
              (if (!= tmp.8.20 6)
                tmp.8.20
                (begin
                  (set! tmp.9.22 (if (!= 14 6) 7998 54846))
                  (if (!= tmp.9.22 6) tmp.9.22 (if (!= 6 6) 43070 33854))))))
          (if (!= tmp.7.19 6)
            tmp.7.19
            (begin
              (set! tmp.10.23
                (begin
                  (set! pair0.24
                    (begin
                      (set! tmp.146 (call L.cons.90.16 cons.90 3936 22))
                      (call L.cons.90.16 cons.90 232 tmp.146)))
                  60222))
              (if (!= tmp.10.23 6)
                tmp.10.23
                (begin
                  (set! tmp.11.25 (if (!= 6 6) 56894 32574))
                  (if (!= tmp.11.25 6)
                    tmp.11.25
                    (begin
                      (set! tmp.12.26
                        (begin
                          (set! vector0.27
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
                                  g42959050.29
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
                                      g42959051.30
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
                                          g42959052.31
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
                                              g42959053.32
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
                                                  g42959054.33
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
                                                      g42959055.34
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
                                                          g42959056.35
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
                                                                  (!=
                                                                   tmp.154
                                                                   6))
                                                              g42959057.36
                                                              tmp.13.28))))))))))))))))))
                          55358))
                      (if (!= tmp.12.26 6)
                        tmp.12.26
                        (begin
                          (set! tmp.14.37 (begin 30014))
                          (if (!= tmp.14.37 6)
                            tmp.14.37
                            (begin
                              (set! tmp.155 (if (!= 6 6) 30 30))
                              (begin
                                (set! tmp.156 (if (!= 6 6) 22 22))
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
            (set! tmp.96 (begin (set! tmp.105 (alloc 16)) (+ tmp.105 1)))
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
      (set! error?.86
        (begin
          (set! tmp.97 (begin (set! tmp.108 (alloc 16)) (+ tmp.108 2)))
          (begin (mset! tmp.97 -2 L.error?.86.10) (mset! tmp.97 6 8) tmp.97)))
      (set! boolean?.85
        (begin
          (set! tmp.98 (begin (set! tmp.109 (alloc 16)) (+ tmp.109 2)))
          (begin
            (mset! tmp.98 -2 L.boolean?.85.11)
            (mset! tmp.98 6 8)
            tmp.98)))
      (set! cons.84
        (begin
          (set! tmp.99 (begin (set! tmp.110 (alloc 16)) (+ tmp.110 2)))
          (begin (mset! tmp.99 -2 L.cons.84.12) (mset! tmp.99 6 16) tmp.99)))
      (set! fun/void8692.11
        (begin
          (set! tmp.100 (begin (set! tmp.111 (alloc 16)) (+ tmp.111 2)))
          (begin
            (mset! tmp.100 -2 L.fun/void8692.11.13)
            (mset! tmp.100 6 16)
            tmp.100)))
      (set! fun/void8693.12
        (begin
          (set! tmp.101 (begin (set! tmp.112 (alloc 16)) (+ tmp.112 2)))
          (begin
            (mset! tmp.101 -2 L.fun/void8693.12.14)
            (mset! tmp.101 6 16)
            tmp.101)))
      (set! fun/boolean8691.13
        (begin
          (set! tmp.102 (begin (set! tmp.113 (alloc 16)) (+ tmp.113 2)))
          (begin
            (mset! tmp.102 -2 L.fun/boolean8691.13.15)
            (mset! tmp.102 6 0)
            tmp.102)))
      (set! fun/void8694.14
        (begin
          (set! tmp.103 (begin (set! tmp.114 (alloc 16)) (+ tmp.114 2)))
          (begin
            (mset! tmp.103 -2 L.fun/void8694.14.16)
            (mset! tmp.103 6 0)
            tmp.103)))
      (if (begin
            (set! tmp.7.19
              (begin
                (set! pair0.21
                  (begin
                    (set! tmp.115 (call L.cons.84.12 cons.84 2184 22))
                    (call L.cons.84.12 cons.84 1712 tmp.115)))
                (set! error1.20 3902)
                14))
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
              (set! procedure0.27
                (begin
                  (set! lam.87
                    (begin
                      (set! tmp.104
                        (begin (set! tmp.116 (alloc 16)) (+ tmp.116 2)))
                      (begin
                        (mset! tmp.104 -2 L.lam.87.17)
                        (mset! tmp.104 6 0)
                        tmp.104)))
                  lam.87))
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
          (set! tmp.118
            (begin
              (set! g42962877.28 208)
              (if (begin
                    (set! tmp.119 (call L.error?.86.10 error?.86 g42962877.28))
                    (!= tmp.119 6))
                g42962877.28
                (begin
                  (set! g42962878.29 168)
                  (if (begin
                        (set! tmp.120
                          (call L.error?.86.10 error?.86 g42962878.29))
                        (!= tmp.120 6))
                    g42962878.29
                    (begin
                      (set! g42962879.30 1296)
                      (if (begin
                            (set! tmp.121
                              (call L.error?.86.10 error?.86 g42962879.30))
                            (!= tmp.121 6))
                        g42962879.30
                        (begin
                          (set! g42962880.31 832)
                          (if (begin
                                (set! tmp.122
                                  (call L.error?.86.10 error?.86 g42962880.31))
                                (!= tmp.122 6))
                            g42962880.31
                            848)))))))))
          (begin
            (set! tmp.123 (call L.fun/void8694.14.16 fun/void8694.14))
            (call L.fun/void8693.12.14 fun/void8693.12 tmp.118 tmp.123)))))))
(check-by-interp
 '(module
    (define L.fun/error8697.7.10 (lambda (c.62) (begin (begin 39998))))
    (begin
      (set! fun/error8697.7
        (begin
          (set! tmp.63 (begin (set! tmp.64 (alloc 16)) (+ tmp.64 2)))
          (begin
            (mset! tmp.63 -2 L.fun/error8697.7.10)
            (mset! tmp.63 6 0)
            tmp.63)))
      (begin
        (set! error0.9 (call L.fun/error8697.7.10 fun/error8697.7))
        (set! error1.8 (begin 574))
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
      (set! fun/void8702.13
        (begin
          (set! tmp.80 (begin (set! tmp.83 (alloc 16)) (+ tmp.83 2)))
          (begin
            (mset! tmp.80 -2 L.fun/void8702.13.10)
            (mset! tmp.80 6 0)
            tmp.80)))
      (set! fun/void8701.14
        (begin
          (set! tmp.81 (begin (set! tmp.84 (alloc 24)) (+ tmp.84 2)))
          (begin
            (mset! tmp.81 -2 L.fun/void8701.14.11)
            (mset! tmp.81 6 0)
            tmp.81)))
      (set! fun/empty8700.15
        (begin
          (set! tmp.82 (begin (set! tmp.85 (alloc 16)) (+ tmp.85 2)))
          (begin
            (mset! tmp.82 -2 L.fun/empty8700.15.12)
            (mset! tmp.82 6 0)
            tmp.82)))
      (begin
        (mset! fun/void8701.14 14 fun/void8702.13)
        (begin
          (set! empty0.18
            (begin
              (set! tmp.7.19 (begin 22))
              (if (!= tmp.7.19 6)
                tmp.7.19
                (begin
                  (set! tmp.8.20 (if (!= 14 6) 22 22))
                  (if (!= tmp.8.20 6)
                    tmp.8.20
                    (begin
                      (set! tmp.9.21 (begin 22))
                      (if (!= tmp.9.21 6)
                        tmp.9.21
                        (begin
                          (set! tmp.10.22 (if (!= 22 6) (if (!= 22 6) 22 6) 6))
                          (if (!= tmp.10.22 6)
                            tmp.10.22
                            (begin
                              (set! tmp.11.23 (begin 22))
                              (if (!= tmp.11.23 6)
                                tmp.11.23
                                (begin
                                  (set! tmp.12.24
                                    (call
                                     L.fun/empty8700.15.12
                                     fun/empty8700.15))
                                  (if (!= tmp.12.24 6)
                                    tmp.12.24
                                    (if (!= 14 6) 22 22))))))))))))))
          (set! ascii-char1.17 (if (!= 6 6) 27950 17966))
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
                (set! tmp.192
                  (if (begin
                        (set! tmp.193 (bitwise-and tmp.126 7))
                        (= tmp.193 0))
                    14
                    6))
                (!= tmp.192 6))
            (if (begin
                  (set! tmp.194
                    (if (begin
                          (set! tmp.195 (bitwise-and tmp.125 7))
                          (= tmp.195 3))
                      14
                      6))
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
                (set! tmp.196
                  (if (begin
                        (set! tmp.197 (mref tmp.101 -3))
                        (< tmp.102 tmp.197))
                    14
                    6))
                (!= tmp.196 6))
            (if (begin (set! tmp.198 (if (>= tmp.102 0) 14 6)) (!= tmp.198 6))
              (begin
                (begin
                  (set! tmp.199
                    (begin
                      (set! tmp.200
                        (begin
                          (set! tmp.201 (arithmetic-shift-right tmp.102 3))
                          (* tmp.201 8)))
                      (+ tmp.200 5)))
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
                (set! tmp.203
                  (if (begin
                        (set! tmp.204 (bitwise-and tmp.123 7))
                        (= tmp.204 0))
                    14
                    6))
                (!= tmp.203 6))
            (call L.make-init-vector.4.12 make-init-vector.4 tmp.123)
            2110))))
    (define L.make-init-vector.4.12
      (lambda (c.154 tmp.95)
        (begin
          (set! vector-init-loop.97 (mref c.154 14))
          (begin
            (set! tmp.96
              (begin
                (set! tmp.171
                  (begin
                    (set! tmp.205
                      (begin
                        (set! tmp.206
                          (begin
                            (set! tmp.207
                              (begin
                                (set! tmp.208
                                  (arithmetic-shift-right tmp.95 3))
                                (+ 1 tmp.208)))
                            (* tmp.207 8)))
                        (alloc tmp.206)))
                    (+ tmp.205 3)))
                (begin (mset! tmp.171 -3 tmp.95) tmp.171)))
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
          (if (begin (set! tmp.209 (if (= len.98 i.100) 14 6)) (!= tmp.209 6))
            vec.99
            (begin
              (begin
                (set! tmp.210
                  (begin
                    (set! tmp.211
                      (begin
                        (set! tmp.212 (arithmetic-shift-right i.100 3))
                        (* tmp.212 8)))
                    (+ tmp.211 5)))
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
            (set! tmp.172 (begin (set! tmp.214 (alloc 16)) (+ tmp.214 1)))
            (begin
              (mset! tmp.172 -1 tmp.142)
              (mset! tmp.172 7 tmp.143)
              tmp.172)))))
    (begin
      (set! cons.150
        (begin
          (set! tmp.173 (begin (set! tmp.215 (alloc 16)) (+ tmp.215 2)))
          (begin
            (mset! tmp.173 -2 L.cons.150.10)
            (mset! tmp.173 6 16)
            tmp.173)))
      (set! vector-init-loop.97
        (begin
          (set! tmp.174 (begin (set! tmp.216 (alloc 24)) (+ tmp.216 2)))
          (begin
            (mset! tmp.174 -2 L.vector-init-loop.97.11)
            (mset! tmp.174 6 24)
            tmp.174)))
      (set! make-init-vector.4
        (begin
          (set! tmp.175 (begin (set! tmp.217 (alloc 24)) (+ tmp.217 2)))
          (begin
            (mset! tmp.175 -2 L.make-init-vector.4.12)
            (mset! tmp.175 6 8)
            tmp.175)))
      (set! make-vector.149
        (begin
          (set! tmp.176 (begin (set! tmp.218 (alloc 24)) (+ tmp.218 2)))
          (begin
            (mset! tmp.176 -2 L.make-vector.149.13)
            (mset! tmp.176 6 8)
            tmp.176)))
      (set! error?.148
        (begin
          (set! tmp.177 (begin (set! tmp.219 (alloc 16)) (+ tmp.219 2)))
          (begin
            (mset! tmp.177 -2 L.error?.148.14)
            (mset! tmp.177 6 8)
            tmp.177)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.178 (begin (set! tmp.220 (alloc 16)) (+ tmp.220 2)))
          (begin
            (mset! tmp.178 -2 L.unsafe-vector-set!.5.15)
            (mset! tmp.178 6 24)
            tmp.178)))
      (set! vector-set!.147
        (begin
          (set! tmp.179 (begin (set! tmp.221 (alloc 24)) (+ tmp.221 2)))
          (begin
            (mset! tmp.179 -2 L.vector-set!.147.16)
            (mset! tmp.179 6 24)
            tmp.179)))
      (set! fun/void8706.20
        (begin
          (set! tmp.180 (begin (set! tmp.222 (alloc 16)) (+ tmp.222 2)))
          (begin
            (mset! tmp.180 -2 L.fun/void8706.20.17)
            (mset! tmp.180 6 16)
            tmp.180)))
      (set! fun/void8714.21
        (begin
          (set! tmp.181 (begin (set! tmp.223 (alloc 24)) (+ tmp.223 2)))
          (begin
            (mset! tmp.181 -2 L.fun/void8714.21.18)
            (mset! tmp.181 6 0)
            tmp.181)))
      (set! fun/void8713.22
        (begin
          (set! tmp.182 (begin (set! tmp.224 (alloc 16)) (+ tmp.224 2)))
          (begin
            (mset! tmp.182 -2 L.fun/void8713.22.19)
            (mset! tmp.182 6 0)
            tmp.182)))
      (set! fun/void8705.23
        (begin
          (set! tmp.183 (begin (set! tmp.225 (alloc 16)) (+ tmp.225 2)))
          (begin
            (mset! tmp.183 -2 L.fun/void8705.23.20)
            (mset! tmp.183 6 0)
            tmp.183)))
      (set! fun/void8708.24
        (begin
          (set! tmp.184 (begin (set! tmp.226 (alloc 16)) (+ tmp.226 2)))
          (begin
            (mset! tmp.184 -2 L.fun/void8708.24.21)
            (mset! tmp.184 6 8)
            tmp.184)))
      (set! fun/void8709.25
        (begin
          (set! tmp.185 (begin (set! tmp.227 (alloc 16)) (+ tmp.227 2)))
          (begin
            (mset! tmp.185 -2 L.fun/void8709.25.22)
            (mset! tmp.185 6 0)
            tmp.185)))
      (set! fun/void8710.26
        (begin
          (set! tmp.186 (begin (set! tmp.228 (alloc 16)) (+ tmp.228 2)))
          (begin
            (mset! tmp.186 -2 L.fun/void8710.26.23)
            (mset! tmp.186 6 8)
            tmp.186)))
      (set! fun/boolean8712.27
        (begin
          (set! tmp.187 (begin (set! tmp.229 (alloc 16)) (+ tmp.229 2)))
          (begin
            (mset! tmp.187 -2 L.fun/boolean8712.27.24)
            (mset! tmp.187 6 0)
            tmp.187)))
      (set! fun/void8715.28
        (begin
          (set! tmp.188 (begin (set! tmp.230 (alloc 16)) (+ tmp.230 2)))
          (begin
            (mset! tmp.188 -2 L.fun/void8715.28.25)
            (mset! tmp.188 6 0)
            tmp.188)))
      (set! fun/void8711.29
        (begin
          (set! tmp.189 (begin (set! tmp.231 (alloc 24)) (+ tmp.231 2)))
          (begin
            (mset! tmp.189 -2 L.fun/void8711.29.26)
            (mset! tmp.189 6 16)
            tmp.189)))
      (set! fun/void8707.30
        (begin
          (set! tmp.190 (begin (set! tmp.232 (alloc 16)) (+ tmp.232 2)))
          (begin
            (mset! tmp.190 -2 L.fun/void8707.30.27)
            (mset! tmp.190 6 8)
            tmp.190)))
      (begin
        (mset! vector-init-loop.97 14 vector-init-loop.97)
        (mset! make-init-vector.4 14 vector-init-loop.97)
        (mset! make-vector.149 14 make-init-vector.4)
        (mset! vector-set!.147 14 unsafe-vector-set!.5)
        (mset! fun/void8714.21 14 fun/void8715.28)
        (mset! fun/void8711.29 14 vector-set!.147)
        (if (begin
              (set! empty0.38 (if (!= 6 6) 22 22))
              (if (!= 30 6)
                (if (!= 30 6)
                  (if (!= 30 6) (if (!= 30 6) (!= 30 6) (!= 6 6)) (!= 6 6))
                  (!= 6 6))
                (!= 6 6)))
          (if (if (if (!= 6 6) (!= 30 6) (!= 30 6))
                (if (begin
                      (set! tmp.7.39 (if (!= 30 6) 30 6))
                      (if (!= tmp.7.39 6)
                        (!= tmp.7.39 6)
                        (begin
                          (set! tmp.8.40 (if (!= 14 6) 30 30))
                          (if (!= tmp.8.40 6)
                            (!= tmp.8.40 6)
                            (begin
                              (set! tmp.9.41
                                (call L.fun/void8705.23.20 fun/void8705.23))
                              (if (!= tmp.9.41 6)
                                (!= tmp.9.41 6)
                                (begin
                                  (set! tmp.10.42 (if (!= 6 6) 30 30))
                                  (if (!= tmp.10.42 6)
                                    (!= tmp.10.42 6)
                                    (begin
                                      (set! tmp.11.43 (if (!= 6 6) 30 30))
                                      (if (!= tmp.11.43 6)
                                        (!= tmp.11.43 6)
                                        (begin
                                          (set! tmp.12.44 (begin 30))
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
                        (set! tmp.234
                          (begin
                            (set! tmp.235 (if (!= 14 6) 30 30))
                            (begin
                              (set! tmp.236 (if (!= 6 6) 30 30))
                              (call
                               L.fun/void8706.20.17
                               fun/void8706.20
                               tmp.235
                               tmp.236))))
                        (!= tmp.234 6))
                    (if (begin
                          (set! vector0.48
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
                                  g42974327.50
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
                                      g42974328.51
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
                                          g42974329.52
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
                                              g42974330.53
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
                                                  g42974331.54
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
                                                      g42974332.55
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
                                                          g42974333.56
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
                                                                  (!=
                                                                   tmp.244
                                                                   6))
                                                              g42974334.57
                                                              tmp.13.49))))))))))))))))))
                          (set! ascii-char1.47 28206)
                          (set! vector2.46
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
                                  g42974335.59
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
                                      g42974336.60
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
                                          g42974337.61
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
                                              g42974338.62
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
                                                  g42974339.63
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
                                                      g42974340.64
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
                                                          g42974341.65
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
                                                                  (!=
                                                                   tmp.252
                                                                   6))
                                                              g42974342.66
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
                      (set! tmp.257
                        (begin
                          (set! tmp.258
                            (begin
                              (set! lam.151
                                (begin
                                  (set! tmp.191
                                    (begin
                                      (set! tmp.259 (alloc 16))
                                      (+ tmp.259 2)))
                                  (begin
                                    (mset! tmp.191 -2 L.lam.151.28)
                                    (mset! tmp.191 6 0)
                                    tmp.191)))
                              lam.151))
                          (begin
                            (set! tmp.260
                              (begin
                                (set! tmp.16.70
                                  (call
                                   L.make-vector.149.13
                                   make-vector.149
                                   64))
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
                                    g42974343.71
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
                                        g42974344.72
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
                                            g42974345.73
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
                                                g42974346.74
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
                                                    g42974347.75
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
                                                        g42974348.76
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
                                                            g42974349.77
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
                                                                    (!=
                                                                     tmp.268
                                                                     6))
                                                                g42974350.78
                                                                tmp.16.70))))))))))))))))))
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
                        (set! pair0.81
                          (begin
                            (set! tmp.270
                              (call L.cons.150.10 cons.150 2248 22))
                            (call L.cons.150.10 cons.150 1312 tmp.270)))
                        (set! vector1.80
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
                                g42974351.83
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
                                    g42974352.84
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
                                        g42974353.85
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
                                            g42974354.86
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
                                                g42974355.87
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
                                                    g42974356.88
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
                                                        g42974357.89
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
                                                            g42974358.90
                                                            tmp.17.82))))))))))))))))))
                        (set! error2.79 22078)
                        (!= 30 6))
                      (begin
                        (set! tmp.279
                          (call L.fun/void8713.22.19 fun/void8713.22))
                        (!= tmp.279 6)))
                  (begin
                    (set! tmp.18.91 (if (!= 6 6) 30 30))
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
              (set! pair0.11
                (begin
                  (set! tmp.73 (call L.cons.64.10 cons.64 3392 22))
                  (call L.cons.64.10 cons.64 696 tmp.73)))
              (set! fixnum1.10 992)
              1056)))))
    (define L.fun/boolean8722.7.11 (lambda (c.66) (begin 14)))
    (define L.cons.64.10
      (lambda (c.65 tmp.59 tmp.60)
        (begin
          (begin
            (set! tmp.68 (begin (set! tmp.74 (alloc 16)) (+ tmp.74 1)))
            (begin (mset! tmp.68 -1 tmp.59) (mset! tmp.68 7 tmp.60) tmp.68)))))
    (begin
      (set! cons.64
        (begin
          (set! tmp.69 (begin (set! tmp.75 (alloc 16)) (+ tmp.75 2)))
          (begin (mset! tmp.69 -2 L.cons.64.10) (mset! tmp.69 6 16) tmp.69)))
      (set! fun/boolean8722.7
        (begin
          (set! tmp.70 (begin (set! tmp.76 (alloc 16)) (+ tmp.76 2)))
          (begin
            (mset! tmp.70 -2 L.fun/boolean8722.7.11)
            (mset! tmp.70 6 0)
            tmp.70)))
      (set! fun/fixnum8721.8
        (begin
          (set! tmp.71 (begin (set! tmp.77 (alloc 32)) (+ tmp.77 2)))
          (begin
            (mset! tmp.71 -2 L.fun/fixnum8721.8.12)
            (mset! tmp.71 6 0)
            tmp.71)))
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
                (set! tmp.105
                  (if (begin
                        (set! tmp.106 (bitwise-and tmp.52 7))
                        (= tmp.106 0))
                    14
                    6))
                (!= tmp.105 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.52)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.86 tmp.24)
        (begin
          (set! vector-init-loop.26 (mref c.86 14))
          (begin
            (set! tmp.25
              (begin
                (set! tmp.92
                  (begin
                    (set! tmp.107
                      (begin
                        (set! tmp.108
                          (begin
                            (set! tmp.109
                              (begin
                                (set! tmp.110
                                  (arithmetic-shift-right tmp.24 3))
                                (+ 1 tmp.110)))
                            (* tmp.109 8)))
                        (alloc tmp.108)))
                    (+ tmp.107 3)))
                (begin (mset! tmp.92 -3 tmp.24) tmp.92)))
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
          (if (begin (set! tmp.111 (if (= len.27 i.29) 14 6)) (!= tmp.111 6))
            vec.28
            (begin
              (begin
                (set! tmp.112
                  (begin
                    (set! tmp.113
                      (begin
                        (set! tmp.114 (arithmetic-shift-right i.29 3))
                        (* tmp.114 8)))
                    (+ tmp.113 5)))
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
                (set! tmp.116
                  (if (begin
                        (set! tmp.117 (bitwise-and tmp.55 7))
                        (= tmp.117 0))
                    14
                    6))
                (!= tmp.116 6))
            (if (begin
                  (set! tmp.118
                    (if (begin
                          (set! tmp.119 (bitwise-and tmp.54 7))
                          (= tmp.119 3))
                      14
                      6))
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
                (set! tmp.120
                  (if (begin
                        (set! tmp.121 (mref tmp.30 -3))
                        (< tmp.31 tmp.121))
                    14
                    6))
                (!= tmp.120 6))
            (if (begin (set! tmp.122 (if (>= tmp.31 0) 14 6)) (!= tmp.122 6))
              (begin
                (begin
                  (set! tmp.123
                    (begin
                      (set! tmp.124
                        (begin
                          (set! tmp.125 (arithmetic-shift-right tmp.31 3))
                          (* tmp.125 8)))
                      (+ tmp.124 5)))
                  (mset! tmp.30 tmp.123 tmp.32))
                30)
              2622)
            2622))))
    (define L.vector-ref.79.11
      (lambda (c.82 tmp.57 tmp.58)
        (begin
          (set! unsafe-vector-ref.6 (mref c.82 14))
          (if (begin
                (set! tmp.126
                  (if (begin
                        (set! tmp.127 (bitwise-and tmp.58 7))
                        (= tmp.127 0))
                    14
                    6))
                (!= tmp.126 6))
            (if (begin
                  (set! tmp.128
                    (if (begin
                          (set! tmp.129 (bitwise-and tmp.57 7))
                          (= tmp.129 3))
                      14
                      6))
                  (!= tmp.128 6))
              (call L.unsafe-vector-ref.6.10 unsafe-vector-ref.6 tmp.57 tmp.58)
              2878)
            2878))))
    (define L.unsafe-vector-ref.6.10
      (lambda (c.81 tmp.35 tmp.36)
        (begin
          (if (begin
                (set! tmp.130
                  (if (begin
                        (set! tmp.131 (mref tmp.35 -3))
                        (< tmp.36 tmp.131))
                    14
                    6))
                (!= tmp.130 6))
            (if (begin (set! tmp.132 (if (>= tmp.36 0) 14 6)) (!= tmp.132 6))
              (begin
                (set! tmp.133
                  (begin
                    (set! tmp.134
                      (begin
                        (set! tmp.135 (arithmetic-shift-right tmp.36 3))
                        (* tmp.135 8)))
                    (+ tmp.134 5)))
                (mref tmp.35 tmp.133))
              2878)
            2878))))
    (begin
      (set! unsafe-vector-ref.6
        (begin
          (set! tmp.93 (begin (set! tmp.136 (alloc 16)) (+ tmp.136 2)))
          (begin
            (mset! tmp.93 -2 L.unsafe-vector-ref.6.10)
            (mset! tmp.93 6 16)
            tmp.93)))
      (set! vector-ref.79
        (begin
          (set! tmp.94 (begin (set! tmp.137 (alloc 24)) (+ tmp.137 2)))
          (begin
            (mset! tmp.94 -2 L.vector-ref.79.11)
            (mset! tmp.94 6 16)
            tmp.94)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.95 (begin (set! tmp.138 (alloc 16)) (+ tmp.138 2)))
          (begin
            (mset! tmp.95 -2 L.unsafe-vector-set!.5.12)
            (mset! tmp.95 6 24)
            tmp.95)))
      (set! vector-set!.78
        (begin
          (set! tmp.96 (begin (set! tmp.139 (alloc 24)) (+ tmp.139 2)))
          (begin
            (mset! tmp.96 -2 L.vector-set!.78.13)
            (mset! tmp.96 6 24)
            tmp.96)))
      (set! vector-init-loop.26
        (begin
          (set! tmp.97 (begin (set! tmp.140 (alloc 24)) (+ tmp.140 2)))
          (begin
            (mset! tmp.97 -2 L.vector-init-loop.26.14)
            (mset! tmp.97 6 24)
            tmp.97)))
      (set! make-init-vector.4
        (begin
          (set! tmp.98 (begin (set! tmp.141 (alloc 24)) (+ tmp.141 2)))
          (begin
            (mset! tmp.98 -2 L.make-init-vector.4.15)
            (mset! tmp.98 6 8)
            tmp.98)))
      (set! make-vector.77
        (begin
          (set! tmp.99 (begin (set! tmp.142 (alloc 24)) (+ tmp.142 2)))
          (begin
            (mset! tmp.99 -2 L.make-vector.77.16)
            (mset! tmp.99 6 8)
            tmp.99)))
      (set! error?.76
        (begin
          (set! tmp.100 (begin (set! tmp.143 (alloc 16)) (+ tmp.143 2)))
          (begin
            (mset! tmp.100 -2 L.error?.76.17)
            (mset! tmp.100 6 8)
            tmp.100)))
      (set! fun/ascii-char8726.8
        (begin
          (set! tmp.101 (begin (set! tmp.144 (alloc 16)) (+ tmp.144 2)))
          (begin
            (mset! tmp.101 -2 L.fun/ascii-char8726.8.18)
            (mset! tmp.101 6 0)
            tmp.101)))
      (set! fun/ascii-char8725.9
        (begin
          (set! tmp.102 (begin (set! tmp.145 (alloc 16)) (+ tmp.145 2)))
          (begin
            (mset! tmp.102 -2 L.fun/ascii-char8725.9.19)
            (mset! tmp.102 6 0)
            tmp.102)))
      (begin
        (mset! vector-ref.79 14 unsafe-vector-ref.6)
        (mset! vector-set!.78 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.26 14 vector-init-loop.26)
        (mset! make-init-vector.4 14 vector-init-loop.26)
        (mset! make-vector.77 14 make-init-vector.4)
        (begin
          (set! g42981987.10
            (begin
              (set! g42981988.11
                (call L.fun/ascii-char8725.9.19 fun/ascii-char8725.9))
              (if (begin
                    (set! tmp.146 (call L.error?.76.17 error?.76 g42981988.11))
                    (!= tmp.146 6))
                g42981988.11
                (begin
                  (set! g42981989.12 (if (!= 6 6) 27438 26926))
                  (if (begin
                        (set! tmp.147
                          (call L.error?.76.17 error?.76 g42981989.12))
                        (!= tmp.147 6))
                    g42981989.12
                    (if (!= 14 6) 17198 17710))))))
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
                  (set! vector0.14
                    (begin
                      (set! tmp.7.15
                        (call L.make-vector.77.16 make-vector.77 64))
                      (begin
                        (set! g42981991.16
                          (begin
                            (set! tmp.150
                              (call L.make-vector.77.16 make-vector.77 64))
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
                          g42981991.16
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
                                    (call
                                     L.error?.76.17
                                     error?.76
                                     g42981992.17))
                                  (!= tmp.152 6))
                              g42981992.17
                              (begin
                                (set! g42981993.18
                                  (begin
                                    (set! tmp.153
                                      (begin
                                        (set! lam.80
                                          (begin
                                            (set! tmp.103
                                              (begin
                                                (set! tmp.154 (alloc 16))
                                                (+ tmp.154 2)))
                                            (begin
                                              (mset! tmp.103 -2 L.lam.80.20)
                                              (mset! tmp.103 6 0)
                                              tmp.103)))
                                        lam.80))
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
                                  g42981993.18
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
                                      g42981994.19
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
                                          g42981995.20
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
                                              g42981996.21
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
                                                  g42981997.22
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
                                                      g42981998.23
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
            (set! tmp.145 (begin (set! tmp.162 (alloc 16)) (+ tmp.162 1)))
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
                (set! tmp.164
                  (if (begin
                        (set! tmp.165 (bitwise-and tmp.101 7))
                        (= tmp.165 0))
                    14
                    6))
                (!= tmp.164 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.101)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.136 tmp.73)
        (begin
          (set! vector-init-loop.75 (mref c.136 14))
          (begin
            (set! tmp.74
              (begin
                (set! tmp.146
                  (begin
                    (set! tmp.166
                      (begin
                        (set! tmp.167
                          (begin
                            (set! tmp.168
                              (begin
                                (set! tmp.169
                                  (arithmetic-shift-right tmp.73 3))
                                (+ 1 tmp.169)))
                            (* tmp.168 8)))
                        (alloc tmp.167)))
                    (+ tmp.166 3)))
                (begin (mset! tmp.146 -3 tmp.73) tmp.146)))
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
          (if (begin (set! tmp.170 (if (= len.76 i.78) 14 6)) (!= tmp.170 6))
            vec.77
            (begin
              (begin
                (set! tmp.171
                  (begin
                    (set! tmp.172
                      (begin
                        (set! tmp.173 (arithmetic-shift-right i.78 3))
                        (* tmp.173 8)))
                    (+ tmp.172 5)))
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
                (set! tmp.175
                  (if (begin
                        (set! tmp.176 (bitwise-and tmp.104 7))
                        (= tmp.176 0))
                    14
                    6))
                (!= tmp.175 6))
            (if (begin
                  (set! tmp.177
                    (if (begin
                          (set! tmp.178 (bitwise-and tmp.103 7))
                          (= tmp.178 3))
                      14
                      6))
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
                (set! tmp.179
                  (if (begin
                        (set! tmp.180 (mref tmp.79 -3))
                        (< tmp.80 tmp.180))
                    14
                    6))
                (!= tmp.179 6))
            (if (begin (set! tmp.181 (if (>= tmp.80 0) 14 6)) (!= tmp.181 6))
              (begin
                (begin
                  (set! tmp.182
                    (begin
                      (set! tmp.183
                        (begin
                          (set! tmp.184 (arithmetic-shift-right tmp.80 3))
                          (* tmp.184 8)))
                      (+ tmp.183 5)))
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
      (set! pair?.129
        (begin
          (set! tmp.147 (begin (set! tmp.186 (alloc 16)) (+ tmp.186 2)))
          (begin
            (mset! tmp.147 -2 L.pair?.129.10)
            (mset! tmp.147 6 8)
            tmp.147)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.148 (begin (set! tmp.187 (alloc 16)) (+ tmp.187 2)))
          (begin
            (mset! tmp.148 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.148 6 24)
            tmp.148)))
      (set! vector-set!.128
        (begin
          (set! tmp.149 (begin (set! tmp.188 (alloc 24)) (+ tmp.188 2)))
          (begin
            (mset! tmp.149 -2 L.vector-set!.128.12)
            (mset! tmp.149 6 24)
            tmp.149)))
      (set! vector-init-loop.75
        (begin
          (set! tmp.150 (begin (set! tmp.189 (alloc 24)) (+ tmp.189 2)))
          (begin
            (mset! tmp.150 -2 L.vector-init-loop.75.13)
            (mset! tmp.150 6 24)
            tmp.150)))
      (set! make-init-vector.4
        (begin
          (set! tmp.151 (begin (set! tmp.190 (alloc 24)) (+ tmp.190 2)))
          (begin
            (mset! tmp.151 -2 L.make-init-vector.4.14)
            (mset! tmp.151 6 8)
            tmp.151)))
      (set! make-vector.127
        (begin
          (set! tmp.152 (begin (set! tmp.191 (alloc 24)) (+ tmp.191 2)))
          (begin
            (mset! tmp.152 -2 L.make-vector.127.15)
            (mset! tmp.152 6 8)
            tmp.152)))
      (set! error?.126
        (begin
          (set! tmp.153 (begin (set! tmp.192 (alloc 16)) (+ tmp.192 2)))
          (begin
            (mset! tmp.153 -2 L.error?.126.16)
            (mset! tmp.153 6 8)
            tmp.153)))
      (set! cons.125
        (begin
          (set! tmp.154 (begin (set! tmp.193 (alloc 16)) (+ tmp.193 2)))
          (begin
            (mset! tmp.154 -2 L.cons.125.17)
            (mset! tmp.154 6 16)
            tmp.154)))
      (set! fun/empty8731.21
        (begin
          (set! tmp.155 (begin (set! tmp.194 (alloc 16)) (+ tmp.194 2)))
          (begin
            (mset! tmp.155 -2 L.fun/empty8731.21.18)
            (mset! tmp.155 6 0)
            tmp.155)))
      (set! fun/pair8730.22
        (begin
          (set! tmp.156 (begin (set! tmp.195 (alloc 24)) (+ tmp.195 2)))
          (begin
            (mset! tmp.156 -2 L.fun/pair8730.22.19)
            (mset! tmp.156 6 0)
            tmp.156)))
      (set! fun/empty8729.23
        (begin
          (set! tmp.157 (begin (set! tmp.196 (alloc 16)) (+ tmp.196 2)))
          (begin
            (mset! tmp.157 -2 L.fun/empty8729.23.20)
            (mset! tmp.157 6 16)
            tmp.157)))
      (begin
        (mset! vector-set!.128 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.75 14 vector-init-loop.75)
        (mset! make-init-vector.4 14 vector-init-loop.75)
        (mset! make-vector.127 14 make-init-vector.4)
        (mset! fun/pair8730.22 14 cons.125)
        (begin
          (set! tmp.7.26
            (begin
              (begin
                (set! g42985819.27 22)
                (if (begin
                      (set! tmp.197
                        (call L.error?.126.16 error?.126 g42985819.27))
                      (!= tmp.197 6))
                  g42985819.27
                  22))))
          (if (!= tmp.7.26 6)
            tmp.7.26
            (begin
              (set! tmp.8.28
                (begin
                  (set! tmp.198 (call L.fun/pair8730.22.19 fun/pair8730.22))
                  (begin
                    (set! tmp.199 (begin 32830))
                    (call
                     L.fun/empty8729.23.20
                     fun/empty8729.23
                     tmp.198
                     tmp.199))))
              (if (!= tmp.8.28 6)
                tmp.8.28
                (begin
                  (set! tmp.9.29
                    (begin
                      (set! vector0.32
                        (begin
                          (set! tmp.10.33
                            (call L.make-vector.127.15 make-vector.127 64))
                          (begin
                            (set! g42985820.34
                              (begin
                                (set! tmp.200
                                  (begin
                                    (set! tmp.11.35
                                      (call
                                       L.make-vector.127.15
                                       make-vector.127
                                       64))
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
                                        g42985821.36
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
                                            g42985822.37
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
                                                g42985823.38
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
                                                    g42985824.39
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
                                                        g42985825.40
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
                                                            g42985826.41
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
                                                                    (!=
                                                                     tmp.207
                                                                     6))
                                                                g42985827.42
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
                                                                        (!=
                                                                         tmp.208
                                                                         6))
                                                                    g42985828.43
                                                                    tmp.11.35))))))))))))))))))
                                (call
                                 L.vector-set!.128.12
                                 vector-set!.128
                                 tmp.10.33
                                 0
                                 tmp.200)))
                            (if (begin
                                  (set! tmp.209
                                    (call
                                     L.error?.126.16
                                     error?.126
                                     g42985820.34))
                                  (!= tmp.209 6))
                              g42985820.34
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
                                  g42985829.44
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
                                      g42985830.45
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
                                          g42985831.46
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
                                              g42985832.47
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
                                                  g42985833.48
                                                  (begin
                                                    (set! g42985834.49
                                                      (begin
                                                        (set! tmp.215
                                                          (begin
                                                            (set! lam.130
                                                              (begin
                                                                (set! tmp.158
                                                                  (begin
                                                                    (set! tmp.216
                                                                      (alloc
                                                                       16))
                                                                    (+
                                                                     tmp.216
                                                                     2)))
                                                                (begin
                                                                  (mset!
                                                                   tmp.158
                                                                   -2
                                                                   L.lam.130.21)
                                                                  (mset!
                                                                   tmp.158
                                                                   6
                                                                   0)
                                                                  tmp.158)))
                                                            lam.130))
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
                                                      g42985834.49
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
                                                          g42985835.50
                                                          tmp.10.33))))))))))))))))))
                      (set! procedure1.31
                        (begin
                          (set! lam.131
                            (begin
                              (set! tmp.159
                                (begin
                                  (set! tmp.219 (alloc 16))
                                  (+ tmp.219 2)))
                              (begin
                                (mset! tmp.159 -2 L.lam.131.22)
                                (mset! tmp.159 6 0)
                                tmp.159)))
                          lam.131))
                      (set! empty2.30 (begin 22))
                      (call L.fun/empty8731.21.18 fun/empty8731.21)))
                  (if (!= tmp.9.29 6)
                    tmp.9.29
                    (begin
                      (set! tmp.12.51
                        (if (begin
                              (set! error0.54 10302)
                              (set! vector1.53
                                (begin
                                  (set! tmp.13.55
                                    (call
                                     L.make-vector.127.15
                                     make-vector.127
                                     64))
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
                                      g42985836.56
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
                                          g42985837.57
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
                                              g42985838.58
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
                                                  g42985839.59
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
                                                      g42985840.60
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
                                                          g42985841.61
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
                                                                  (!=
                                                                   tmp.226
                                                                   6))
                                                              g42985842.62
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
                                                                  g42985843.63
                                                                  tmp.13.55))))))))))))))))))
                              (set! boolean2.52 14)
                              (!= 14 6))
                          (begin
                            (set! tmp.14.64 22)
                            (if (!= tmp.14.64 6)
                              tmp.14.64
                              (begin
                                (set! tmp.15.65 22)
                                (if (!= tmp.15.65 6)
                                  tmp.15.65
                                  (begin
                                    (set! tmp.16.66 22)
                                    (if (!= tmp.16.66 6)
                                      tmp.16.66
                                      (begin
                                        (set! tmp.17.67 22)
                                        (if (!= tmp.17.67 6)
                                          tmp.17.67
                                          (begin
                                            (set! tmp.18.68 22)
                                            (if (!= tmp.18.68 6)
                                              tmp.18.68
                                              (begin
                                                (set! tmp.19.69 22)
                                                (if (!= tmp.19.69 6)
                                                  tmp.19.69
                                                  22))))))))))))
                          (begin
                            (set! g42985844.70 22)
                            (if (begin
                                  (set! tmp.228
                                    (call
                                     L.error?.126.16
                                     error?.126
                                     g42985844.70))
                                  (!= tmp.228 6))
                              g42985844.70
                              (begin
                                (set! g42985845.71 22)
                                (if (begin
                                      (set! tmp.229
                                        (call
                                         L.error?.126.16
                                         error?.126
                                         g42985845.71))
                                      (!= tmp.229 6))
                                  g42985845.71
                                  22))))))
                      (if (!= tmp.12.51 6)
                        tmp.12.51
                        (begin
                          (set! tmp.20.72
                            (if (begin
                                  (set! tmp.230
                                    (begin
                                      (set! tmp.231
                                        (begin
                                          (set! tmp.232
                                            (call
                                             L.cons.125.17
                                             cons.125
                                             3080
                                             22))
                                          (call
                                           L.cons.125.17
                                           cons.125
                                           488
                                           tmp.232)))
                                      (call L.pair?.129.10 pair?.129 tmp.231)))
                                  (!= tmp.230 6))
                              (if (!= 14 6) 22 22)
                              22))
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
      (set! fun/error8736.7
        (begin
          (set! tmp.72 (begin (set! tmp.77 (alloc 24)) (+ tmp.77 2)))
          (begin
            (mset! tmp.72 -2 L.fun/error8736.7.10)
            (mset! tmp.72 6 0)
            tmp.72)))
      (set! fun/boolean8735.8
        (begin
          (set! tmp.73 (begin (set! tmp.78 (alloc 16)) (+ tmp.78 2)))
          (begin
            (mset! tmp.73 -2 L.fun/boolean8735.8.11)
            (mset! tmp.73 6 0)
            tmp.73)))
      (set! fun/error8737.9
        (begin
          (set! tmp.74 (begin (set! tmp.79 (alloc 16)) (+ tmp.79 2)))
          (begin
            (mset! tmp.74 -2 L.fun/error8737.9.12)
            (mset! tmp.74 6 0)
            tmp.74)))
      (set! fun/boolean8734.10
        (begin
          (set! tmp.75 (begin (set! tmp.80 (alloc 24)) (+ tmp.80 2)))
          (begin
            (mset! tmp.75 -2 L.fun/boolean8734.10.13)
            (mset! tmp.75 6 0)
            tmp.75)))
      (begin
        (mset! fun/error8736.7 14 fun/error8737.9)
        (mset! fun/boolean8734.10 14 fun/boolean8735.8)
        (begin
          (set! procedure0.13
            (begin
              (set! lam.66
                (begin
                  (set! tmp.76 (begin (set! tmp.81 (alloc 16)) (+ tmp.81 2)))
                  (begin
                    (mset! tmp.76 -2 L.lam.66.14)
                    (mset! tmp.76 6 0)
                    tmp.76)))
              lam.66))
          (set! boolean1.12 (call L.fun/boolean8734.10.13 fun/boolean8734.10))
          (set! ascii-char2.11 (if (!= 14 6) 31278 29998))
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
      (set! error?.82
        (begin
          (set! tmp.86 (begin (set! tmp.90 (alloc 16)) (+ tmp.90 2)))
          (begin (mset! tmp.86 -2 L.error?.82.10) (mset! tmp.86 6 8) tmp.86)))
      (set! fun/void8741.11
        (begin
          (set! tmp.87 (begin (set! tmp.91 (alloc 16)) (+ tmp.91 2)))
          (begin
            (mset! tmp.87 -2 L.fun/void8741.11.11)
            (mset! tmp.87 6 0)
            tmp.87)))
      (set! fun/void8740.12
        (begin
          (set! tmp.88 (begin (set! tmp.92 (alloc 16)) (+ tmp.92 2)))
          (begin
            (mset! tmp.88 -2 L.fun/void8740.12.12)
            (mset! tmp.88 6 16)
            tmp.88)))
      (begin
        (begin
          (set! g42993474.15
            (call L.fun/void8740.12.12 fun/void8740.12 1528 576))
          (if (begin
                (set! tmp.93 (call L.error?.82.10 error?.82 g42993474.15))
                (!= tmp.93 6))
            g42993474.15
            (begin
              (set! g42993475.16
                (begin
                  (set! g42993476.17 30)
                  (if (begin
                        (set! tmp.94
                          (call L.error?.82.10 error?.82 g42993476.17))
                        (!= tmp.94 6))
                    g42993476.17
                    (begin
                      (set! g42993477.18 30)
                      (if (begin
                            (set! tmp.95
                              (call L.error?.82.10 error?.82 g42993477.18))
                            (!= tmp.95 6))
                        g42993477.18
                        (begin
                          (set! g42993478.19 30)
                          (if (begin
                                (set! tmp.96
                                  (call L.error?.82.10 error?.82 g42993478.19))
                                (!= tmp.96 6))
                            g42993478.19
                            (begin
                              (set! g42993479.20 30)
                              (if (begin
                                    (set! tmp.97
                                      (call
                                       L.error?.82.10
                                       error?.82
                                       g42993479.20))
                                    (!= tmp.97 6))
                                g42993479.20
                                (begin
                                  (set! g42993480.21 30)
                                  (if (begin
                                        (set! tmp.98
                                          (call
                                           L.error?.82.10
                                           error?.82
                                           g42993480.21))
                                        (!= tmp.98 6))
                                    g42993480.21
                                    30)))))))))))
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
                      (set! g42993482.23 (begin 30))
                      (if (begin
                            (set! tmp.101
                              (call L.error?.82.10 error?.82 g42993482.23))
                            (!= tmp.101 6))
                        g42993482.23
                        (begin
                          (set! g42993483.24
                            (begin
                              (set! tmp.7.25 30)
                              (if (!= tmp.7.25 6)
                                tmp.7.25
                                (begin
                                  (set! tmp.8.26 30)
                                  (if (!= tmp.8.26 6)
                                    tmp.8.26
                                    (begin
                                      (set! tmp.9.27 30)
                                      (if (!= tmp.9.27 6)
                                        tmp.9.27
                                        (begin
                                          (set! tmp.10.28 30)
                                          (if (!= tmp.10.28 6)
                                            tmp.10.28
                                            30)))))))))
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
                (set! tmp.114
                  (if (begin
                        (set! tmp.115 (bitwise-and tmp.53 7))
                        (= tmp.115 0))
                    14
                    6))
                (!= tmp.114 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.53)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.86 tmp.25)
        (begin
          (set! vector-init-loop.27 (mref c.86 14))
          (begin
            (set! tmp.26
              (begin
                (set! tmp.93
                  (begin
                    (set! tmp.116
                      (begin
                        (set! tmp.117
                          (begin
                            (set! tmp.118
                              (begin
                                (set! tmp.119
                                  (arithmetic-shift-right tmp.25 3))
                                (+ 1 tmp.119)))
                            (* tmp.118 8)))
                        (alloc tmp.117)))
                    (+ tmp.116 3)))
                (begin (mset! tmp.93 -3 tmp.25) tmp.93)))
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
          (if (begin (set! tmp.120 (if (= len.28 i.30) 14 6)) (!= tmp.120 6))
            vec.29
            (begin
              (begin
                (set! tmp.121
                  (begin
                    (set! tmp.122
                      (begin
                        (set! tmp.123 (arithmetic-shift-right i.30 3))
                        (* tmp.123 8)))
                    (+ tmp.122 5)))
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
                (set! tmp.125
                  (if (begin
                        (set! tmp.126 (bitwise-and tmp.56 7))
                        (= tmp.126 0))
                    14
                    6))
                (!= tmp.125 6))
            (if (begin
                  (set! tmp.127
                    (if (begin
                          (set! tmp.128 (bitwise-and tmp.55 7))
                          (= tmp.128 3))
                      14
                      6))
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
                (set! tmp.129
                  (if (begin
                        (set! tmp.130 (mref tmp.31 -3))
                        (< tmp.32 tmp.130))
                    14
                    6))
                (!= tmp.129 6))
            (if (begin (set! tmp.131 (if (>= tmp.32 0) 14 6)) (!= tmp.131 6))
              (begin
                (begin
                  (set! tmp.132
                    (begin
                      (set! tmp.133
                        (begin
                          (set! tmp.134 (arithmetic-shift-right tmp.32 3))
                          (* tmp.134 8)))
                      (+ tmp.133 5)))
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
                (set! tmp.136
                  (if (begin
                        (set! tmp.137 (bitwise-and tmp.42 7))
                        (= tmp.137 0))
                    14
                    6))
                (!= tmp.136 6))
            (if (begin
                  (set! tmp.138
                    (if (begin
                          (set! tmp.139 (bitwise-and tmp.41 7))
                          (= tmp.139 0))
                      14
                      6))
                  (!= tmp.138 6))
              (+ tmp.41 tmp.42)
              574)
            574))))
    (begin
      (set! |+.80|
        (begin
          (set! tmp.94 (begin (set! tmp.140 (alloc 16)) (+ tmp.140 2)))
          (begin (mset! tmp.94 -2 L.+.80.10) (mset! tmp.94 6 16) tmp.94)))
      (set! error?.79
        (begin
          (set! tmp.95 (begin (set! tmp.141 (alloc 16)) (+ tmp.141 2)))
          (begin (mset! tmp.95 -2 L.error?.79.11) (mset! tmp.95 6 8) tmp.95)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.96 (begin (set! tmp.142 (alloc 16)) (+ tmp.142 2)))
          (begin
            (mset! tmp.96 -2 L.unsafe-vector-set!.5.12)
            (mset! tmp.96 6 24)
            tmp.96)))
      (set! vector-set!.78
        (begin
          (set! tmp.97 (begin (set! tmp.143 (alloc 24)) (+ tmp.143 2)))
          (begin
            (mset! tmp.97 -2 L.vector-set!.78.13)
            (mset! tmp.97 6 24)
            tmp.97)))
      (set! vector-init-loop.27
        (begin
          (set! tmp.98 (begin (set! tmp.144 (alloc 24)) (+ tmp.144 2)))
          (begin
            (mset! tmp.98 -2 L.vector-init-loop.27.14)
            (mset! tmp.98 6 24)
            tmp.98)))
      (set! make-init-vector.4
        (begin
          (set! tmp.99 (begin (set! tmp.145 (alloc 24)) (+ tmp.145 2)))
          (begin
            (mset! tmp.99 -2 L.make-init-vector.4.15)
            (mset! tmp.99 6 8)
            tmp.99)))
      (set! make-vector.77
        (begin
          (set! tmp.100 (begin (set! tmp.146 (alloc 24)) (+ tmp.146 2)))
          (begin
            (mset! tmp.100 -2 L.make-vector.77.16)
            (mset! tmp.100 6 8)
            tmp.100)))
      (set! fun/empty8745.8
        (begin
          (set! tmp.101 (begin (set! tmp.147 (alloc 24)) (+ tmp.147 2)))
          (begin
            (mset! tmp.101 -2 L.fun/empty8745.8.17)
            (mset! tmp.101 6 0)
            tmp.101)))
      (set! fun/empty8744.9
        (begin
          (set! tmp.102 (begin (set! tmp.148 (alloc 24)) (+ tmp.148 2)))
          (begin
            (mset! tmp.102 -2 L.fun/empty8744.9.18)
            (mset! tmp.102 6 8)
            tmp.102)))
      (set! fun/vector8748.10
        (begin
          (set! tmp.103 (begin (set! tmp.149 (alloc 40)) (+ tmp.149 2)))
          (begin
            (mset! tmp.103 -2 L.fun/vector8748.10.19)
            (mset! tmp.103 6 0)
            tmp.103)))
      (set! fun/empty8746.11
        (begin
          (set! tmp.104 (begin (set! tmp.150 (alloc 24)) (+ tmp.150 2)))
          (begin
            (mset! tmp.104 -2 L.fun/empty8746.11.20)
            (mset! tmp.104 6 0)
            tmp.104)))
      (set! fun/empty8747.12
        (begin
          (set! tmp.105 (begin (set! tmp.151 (alloc 16)) (+ tmp.151 2)))
          (begin
            (mset! tmp.105 -2 L.fun/empty8747.12.21)
            (mset! tmp.105 6 0)
            tmp.105)))
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
          (set! tmp.152
            (begin
              (set! fixnum0.24 (call L.+.80.10 |+.80| 1672 1840))
              (set! fixnum1.23 (begin 1568))
              (call L.fun/vector8748.10.19 fun/vector8748.10)))
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
      (set! error?.80
        (begin
          (set! tmp.86 (begin (set! tmp.92 (alloc 16)) (+ tmp.92 2)))
          (begin (mset! tmp.86 -2 L.error?.80.10) (mset! tmp.86 6 8) tmp.86)))
      (set! ascii-char?.79
        (begin
          (set! tmp.87 (begin (set! tmp.93 (alloc 16)) (+ tmp.93 2)))
          (begin
            (mset! tmp.87 -2 L.ascii-char?.79.11)
            (mset! tmp.87 6 8)
            tmp.87)))
      (set! fun/boolean8753.10
        (begin
          (set! tmp.88 (begin (set! tmp.94 (alloc 16)) (+ tmp.94 2)))
          (begin
            (mset! tmp.88 -2 L.fun/boolean8753.10.12)
            (mset! tmp.88 6 8)
            tmp.88)))
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
          (set! tmp.7.18
            (begin
              (set! tmp.95
                (begin
                  (set! lam.81
                    (begin
                      (set! tmp.89
                        (begin (set! tmp.96 (alloc 16)) (+ tmp.96 2)))
                      (begin
                        (mset! tmp.89 -2 L.lam.81.13)
                        (mset! tmp.89 6 0)
                        tmp.89)))
                  lam.81))
              (call L.ascii-char?.79.11 ascii-char?.79 tmp.95)))
          (if (!= tmp.7.18 6)
            tmp.7.18
            (begin
              (set! tmp.8.19 (if (!= 6 6) 14 14))
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
                (set! tmp.99
                  (if (begin
                        (set! tmp.100 (bitwise-and tmp.52 7))
                        (= tmp.100 0))
                    14
                    6))
                (!= tmp.99 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.52)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.85 tmp.24)
        (begin
          (set! vector-init-loop.26 (mref c.85 14))
          (begin
            (set! tmp.25
              (begin
                (set! tmp.89
                  (begin
                    (set! tmp.101
                      (begin
                        (set! tmp.102
                          (begin
                            (set! tmp.103
                              (begin
                                (set! tmp.104
                                  (arithmetic-shift-right tmp.24 3))
                                (+ 1 tmp.104)))
                            (* tmp.103 8)))
                        (alloc tmp.102)))
                    (+ tmp.101 3)))
                (begin (mset! tmp.89 -3 tmp.24) tmp.89)))
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
          (if (begin (set! tmp.105 (if (= len.27 i.29) 14 6)) (!= tmp.105 6))
            vec.28
            (begin
              (begin
                (set! tmp.106
                  (begin
                    (set! tmp.107
                      (begin
                        (set! tmp.108 (arithmetic-shift-right i.29 3))
                        (* tmp.108 8)))
                    (+ tmp.107 5)))
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
                (set! tmp.110
                  (if (begin
                        (set! tmp.111 (bitwise-and tmp.55 7))
                        (= tmp.111 0))
                    14
                    6))
                (!= tmp.110 6))
            (if (begin
                  (set! tmp.112
                    (if (begin
                          (set! tmp.113 (bitwise-and tmp.54 7))
                          (= tmp.113 3))
                      14
                      6))
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
                (set! tmp.114
                  (if (begin
                        (set! tmp.115 (mref tmp.30 -3))
                        (< tmp.31 tmp.115))
                    14
                    6))
                (!= tmp.114 6))
            (if (begin (set! tmp.116 (if (>= tmp.31 0) 14 6)) (!= tmp.116 6))
              (begin
                (begin
                  (set! tmp.117
                    (begin
                      (set! tmp.118
                        (begin
                          (set! tmp.119 (arithmetic-shift-right tmp.31 3))
                          (* tmp.119 8)))
                      (+ tmp.118 5)))
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
                (set! tmp.121
                  (if (begin
                        (set! tmp.122 (bitwise-and tmp.51 7))
                        (= tmp.122 0))
                    14
                    6))
                (!= tmp.121 6))
            (if (begin
                  (set! tmp.123
                    (if (begin
                          (set! tmp.124 (bitwise-and tmp.50 7))
                          (= tmp.124 0))
                      14
                      6))
                  (!= tmp.123 6))
              (if (>= tmp.50 tmp.51) 14 6)
              1854)
            1854))))
    (begin
      (set! >=.79
        (begin
          (set! tmp.90 (begin (set! tmp.125 (alloc 16)) (+ tmp.125 2)))
          (begin (mset! tmp.90 -2 L.>=.79.10) (mset! tmp.90 6 16) tmp.90)))
      (set! error?.78
        (begin
          (set! tmp.91 (begin (set! tmp.126 (alloc 16)) (+ tmp.126 2)))
          (begin (mset! tmp.91 -2 L.error?.78.11) (mset! tmp.91 6 8) tmp.91)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.92 (begin (set! tmp.127 (alloc 16)) (+ tmp.127 2)))
          (begin
            (mset! tmp.92 -2 L.unsafe-vector-set!.5.12)
            (mset! tmp.92 6 24)
            tmp.92)))
      (set! vector-set!.77
        (begin
          (set! tmp.93 (begin (set! tmp.128 (alloc 24)) (+ tmp.128 2)))
          (begin
            (mset! tmp.93 -2 L.vector-set!.77.13)
            (mset! tmp.93 6 24)
            tmp.93)))
      (set! vector-init-loop.26
        (begin
          (set! tmp.94 (begin (set! tmp.129 (alloc 24)) (+ tmp.129 2)))
          (begin
            (mset! tmp.94 -2 L.vector-init-loop.26.14)
            (mset! tmp.94 6 24)
            tmp.94)))
      (set! make-init-vector.4
        (begin
          (set! tmp.95 (begin (set! tmp.130 (alloc 24)) (+ tmp.130 2)))
          (begin
            (mset! tmp.95 -2 L.make-init-vector.4.15)
            (mset! tmp.95 6 8)
            tmp.95)))
      (set! make-vector.76
        (begin
          (set! tmp.96 (begin (set! tmp.131 (alloc 24)) (+ tmp.131 2)))
          (begin
            (mset! tmp.96 -2 L.make-vector.76.16)
            (mset! tmp.96 6 8)
            tmp.96)))
      (set! fun/boolean8757.8
        (begin
          (set! tmp.97 (begin (set! tmp.132 (alloc 16)) (+ tmp.132 2)))
          (begin
            (mset! tmp.97 -2 L.fun/boolean8757.8.17)
            (mset! tmp.97 6 0)
            tmp.97)))
      (set! fun/boolean8756.9
        (begin
          (set! tmp.98 (begin (set! tmp.133 (alloc 24)) (+ tmp.133 2)))
          (begin
            (mset! tmp.98 -2 L.fun/boolean8756.9.18)
            (mset! tmp.98 6 16)
            tmp.98)))
      (begin
        (mset! vector-set!.77 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.26 14 vector-init-loop.26)
        (mset! make-init-vector.4 14 vector-init-loop.26)
        (mset! make-vector.76 14 make-init-vector.4)
        (mset! fun/boolean8756.9 14 fun/boolean8757.8)
        (if (begin
              (set! tmp.134
                (begin
                  (set! tmp.135
                    (begin
                      (set! void0.12 30)
                      (begin
                        (set! tmp.7.13
                          (call L.make-vector.76.16 make-vector.76 64))
                        (begin
                          (set! g43008758.14
                            (call
                             L.vector-set!.77.13
                             vector-set!.77
                             tmp.7.13
                             0
                             8))
                          (if (begin
                                (set! tmp.136
                                  (call L.error?.78.11 error?.78 g43008758.14))
                                (!= tmp.136 6))
                            g43008758.14
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
                                      (call
                                       L.error?.78.11
                                       error?.78
                                       g43008759.15))
                                    (!= tmp.137 6))
                                g43008759.15
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
                                    g43008760.16
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
                                        g43008761.17
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
                                            g43008762.18
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
                                                g43008763.19
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
                                                    g43008764.20
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
                                                        g43008765.21
                                                        tmp.7.13)))))))))))))))))))
                  (begin
                    (set! tmp.144 (call L.>=.79.10 >=.79 888 1704))
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
            (set! tmp.73 (begin (set! tmp.77 (alloc 16)) (+ tmp.77 1)))
            (begin (mset! tmp.73 -1 tmp.64) (mset! tmp.73 7 tmp.65) tmp.73)))))
    (begin
      (set! cons.69
        (begin
          (set! tmp.74 (begin (set! tmp.78 (alloc 16)) (+ tmp.78 2)))
          (begin (mset! tmp.74 -2 L.cons.69.10) (mset! tmp.74 6 16) tmp.74)))
      (set! fun/empty8761.9
        (begin
          (set! tmp.75 (begin (set! tmp.79 (alloc 16)) (+ tmp.79 2)))
          (begin
            (mset! tmp.75 -2 L.fun/empty8761.9.11)
            (mset! tmp.75 6 0)
            tmp.75)))
      (set! fun/empty8760.10
        (begin
          (set! tmp.76 (begin (set! tmp.80 (alloc 16)) (+ tmp.80 2)))
          (begin
            (mset! tmp.76 -2 L.fun/empty8760.10.12)
            (mset! tmp.76 6 0)
            tmp.76)))
      (begin
        (set! empty0.12
          (begin
            (set! tmp.7.13 (call L.fun/empty8760.10.12 fun/empty8760.10))
            (if (!= tmp.7.13 6)
              tmp.7.13
              (begin
                (set! tmp.8.14 (if (!= 14 6) 22 22))
                (if (!= tmp.8.14 6)
                  tmp.8.14
                  (call L.fun/empty8761.9.11 fun/empty8761.9))))))
        (set! empty1.11 (begin 22))
        (if (begin
              (set! pair0.15
                (begin
                  (set! tmp.81 (call L.cons.69.10 cons.69 2624 22))
                  (call L.cons.69.10 cons.69 1312 tmp.81)))
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
                (set! tmp.108
                  (if (begin
                        (set! tmp.109 (bitwise-and tmp.56 7))
                        (= tmp.109 0))
                    14
                    6))
                (!= tmp.108 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.56)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.89 tmp.28)
        (begin
          (set! vector-init-loop.30 (mref c.89 14))
          (begin
            (set! tmp.29
              (begin
                (set! tmp.96
                  (begin
                    (set! tmp.110
                      (begin
                        (set! tmp.111
                          (begin
                            (set! tmp.112
                              (begin
                                (set! tmp.113
                                  (arithmetic-shift-right tmp.28 3))
                                (+ 1 tmp.113)))
                            (* tmp.112 8)))
                        (alloc tmp.111)))
                    (+ tmp.110 3)))
                (begin (mset! tmp.96 -3 tmp.28) tmp.96)))
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
          (if (begin (set! tmp.114 (if (= len.31 i.33) 14 6)) (!= tmp.114 6))
            vec.32
            (begin
              (begin
                (set! tmp.115
                  (begin
                    (set! tmp.116
                      (begin
                        (set! tmp.117 (arithmetic-shift-right i.33 3))
                        (* tmp.117 8)))
                    (+ tmp.116 5)))
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
                (set! tmp.119
                  (if (begin
                        (set! tmp.120 (bitwise-and tmp.59 7))
                        (= tmp.120 0))
                    14
                    6))
                (!= tmp.119 6))
            (if (begin
                  (set! tmp.121
                    (if (begin
                          (set! tmp.122 (bitwise-and tmp.58 7))
                          (= tmp.122 3))
                      14
                      6))
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
                (set! tmp.123
                  (if (begin
                        (set! tmp.124 (mref tmp.34 -3))
                        (< tmp.35 tmp.124))
                    14
                    6))
                (!= tmp.123 6))
            (if (begin (set! tmp.125 (if (>= tmp.35 0) 14 6)) (!= tmp.125 6))
              (begin
                (begin
                  (set! tmp.126
                    (begin
                      (set! tmp.127
                        (begin
                          (set! tmp.128 (arithmetic-shift-right tmp.35 3))
                          (* tmp.128 8)))
                      (+ tmp.127 5)))
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
      (set! error?.82
        (begin
          (set! tmp.97 (begin (set! tmp.130 (alloc 16)) (+ tmp.130 2)))
          (begin (mset! tmp.97 -2 L.error?.82.10) (mset! tmp.97 6 8) tmp.97)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.98 (begin (set! tmp.131 (alloc 16)) (+ tmp.131 2)))
          (begin
            (mset! tmp.98 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.98 6 24)
            tmp.98)))
      (set! vector-set!.81
        (begin
          (set! tmp.99 (begin (set! tmp.132 (alloc 24)) (+ tmp.132 2)))
          (begin
            (mset! tmp.99 -2 L.vector-set!.81.12)
            (mset! tmp.99 6 24)
            tmp.99)))
      (set! vector-init-loop.30
        (begin
          (set! tmp.100 (begin (set! tmp.133 (alloc 24)) (+ tmp.133 2)))
          (begin
            (mset! tmp.100 -2 L.vector-init-loop.30.13)
            (mset! tmp.100 6 24)
            tmp.100)))
      (set! make-init-vector.4
        (begin
          (set! tmp.101 (begin (set! tmp.134 (alloc 24)) (+ tmp.134 2)))
          (begin
            (mset! tmp.101 -2 L.make-init-vector.4.14)
            (mset! tmp.101 6 8)
            tmp.101)))
      (set! make-vector.80
        (begin
          (set! tmp.102 (begin (set! tmp.135 (alloc 24)) (+ tmp.135 2)))
          (begin
            (mset! tmp.102 -2 L.make-vector.80.15)
            (mset! tmp.102 6 8)
            tmp.102)))
      (set! fun/fixnum8766.9
        (begin
          (set! tmp.103 (begin (set! tmp.136 (alloc 16)) (+ tmp.136 2)))
          (begin
            (mset! tmp.103 -2 L.fun/fixnum8766.9.16)
            (mset! tmp.103 6 8)
            tmp.103)))
      (set! fun/fixnum8765.10
        (begin
          (set! tmp.104 (begin (set! tmp.137 (alloc 24)) (+ tmp.137 2)))
          (begin
            (mset! tmp.104 -2 L.fun/fixnum8765.10.17)
            (mset! tmp.104 6 0)
            tmp.104)))
      (set! fun/boolean8764.11
        (begin
          (set! tmp.105 (begin (set! tmp.138 (alloc 16)) (+ tmp.138 2)))
          (begin
            (mset! tmp.105 -2 L.fun/boolean8764.11.18)
            (mset! tmp.105 6 16)
            tmp.105)))
      (begin
        (mset! vector-set!.81 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.30 14 vector-init-loop.30)
        (mset! make-init-vector.4 14 vector-init-loop.30)
        (mset! make-vector.80 14 make-init-vector.4)
        (mset! fun/fixnum8765.10 14 fun/fixnum8766.9)
        (if (begin
              (set! tmp.139
                (begin
                  (set! tmp.140
                    (begin
                      (set! tmp.7.15
                        (begin
                          (set! lam.83
                            (begin
                              (set! tmp.106
                                (begin
                                  (set! tmp.141 (alloc 16))
                                  (+ tmp.141 2)))
                              (begin
                                (mset! tmp.106 -2 L.lam.83.19)
                                (mset! tmp.106 6 0)
                                tmp.106)))
                          lam.83))
                      (if (!= tmp.7.15 6)
                        tmp.7.15
                        (begin
                          (set! lam.84
                            (begin
                              (set! tmp.107
                                (begin
                                  (set! tmp.142 (alloc 16))
                                  (+ tmp.142 2)))
                              (begin
                                (mset! tmp.107 -2 L.lam.84.20)
                                (mset! tmp.107 6 0)
                                tmp.107)))
                          lam.84))))
                  (begin
                    (set! tmp.143 (begin (set! ascii-char0.16 31278) 30))
                    (call
                     L.fun/boolean8764.11.18
                     fun/boolean8764.11
                     tmp.140
                     tmp.143))))
              (!= tmp.139 6))
          (begin
            (set! vector0.18
              (begin
                (set! tmp.8.19 (call L.make-vector.80.15 make-vector.80 64))
                (begin
                  (set! g43016397.20
                    (call L.vector-set!.81.12 vector-set!.81 tmp.8.19 0 8))
                  (if (begin
                        (set! tmp.144
                          (call L.error?.82.10 error?.82 g43016397.20))
                        (!= tmp.144 6))
                    g43016397.20
                    (begin
                      (set! g43016398.21
                        (call
                         L.vector-set!.81.12
                         vector-set!.81
                         tmp.8.19
                         8
                         16))
                      (if (begin
                            (set! tmp.145
                              (call L.error?.82.10 error?.82 g43016398.21))
                            (!= tmp.145 6))
                        g43016398.21
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
                            g43016399.22
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
                                g43016400.23
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
                                    g43016401.24
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
                                        g43016402.25
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
                                            g43016403.26
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
                                                g43016404.27
                                                tmp.8.19))))))))))))))))))
            (set! fixnum1.17 1688)
            184)
          (call L.fun/fixnum8765.10.17 fun/fixnum8765.10))))))
(check-by-interp
 '(module
    (begin
      (set! boolean0.7 (begin (set! fixnum0.8 1432) 14))
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
                (set! tmp.90
                  (if (begin (set! tmp.91 (bitwise-and tmp.33 7)) (= tmp.91 0))
                    14
                    6))
                (!= tmp.90 6))
            (if (begin
                  (set! tmp.92
                    (if (begin
                          (set! tmp.93 (bitwise-and tmp.32 7))
                          (= tmp.93 0))
                      14
                      6))
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
            (set! tmp.81 (begin (set! tmp.95 (alloc 16)) (+ tmp.95 1)))
            (begin (mset! tmp.81 -1 tmp.65) (mset! tmp.81 7 tmp.66) tmp.81)))))
    (define L.+.72.10
      (lambda (c.73 tmp.34 tmp.35)
        (begin
          (if (begin
                (set! tmp.96
                  (if (begin (set! tmp.97 (bitwise-and tmp.35 7)) (= tmp.97 0))
                    14
                    6))
                (!= tmp.96 6))
            (if (begin
                  (set! tmp.98
                    (if (begin
                          (set! tmp.99 (bitwise-and tmp.34 7))
                          (= tmp.99 0))
                      14
                      6))
                  (!= tmp.98 6))
              (+ tmp.34 tmp.35)
              574)
            574))))
    (begin
      (set! |+.72|
        (begin
          (set! tmp.82 (begin (set! tmp.100 (alloc 16)) (+ tmp.100 2)))
          (begin (mset! tmp.82 -2 L.+.72.10) (mset! tmp.82 6 16) tmp.82)))
      (set! cons.71
        (begin
          (set! tmp.83 (begin (set! tmp.101 (alloc 16)) (+ tmp.101 2)))
          (begin (mset! tmp.83 -2 L.cons.71.11) (mset! tmp.83 6 16) tmp.83)))
      (set! *.70
        (begin
          (set! tmp.84 (begin (set! tmp.102 (alloc 16)) (+ tmp.102 2)))
          (begin (mset! tmp.84 -2 L.*.70.12) (mset! tmp.84 6 16) tmp.84)))
      (set! fun/fixnum8773.7
        (begin
          (set! tmp.85 (begin (set! tmp.103 (alloc 24)) (+ tmp.103 2)))
          (begin
            (mset! tmp.85 -2 L.fun/fixnum8773.7.13)
            (mset! tmp.85 6 8)
            tmp.85)))
      (set! fun/fixnum8771.8
        (begin
          (set! tmp.86 (begin (set! tmp.104 (alloc 24)) (+ tmp.104 2)))
          (begin
            (mset! tmp.86 -2 L.fun/fixnum8771.8.14)
            (mset! tmp.86 6 0)
            tmp.86)))
      (set! fun/fixnum8775.9
        (begin
          (set! tmp.87 (begin (set! tmp.105 (alloc 16)) (+ tmp.105 2)))
          (begin
            (mset! tmp.87 -2 L.fun/fixnum8775.9.15)
            (mset! tmp.87 6 8)
            tmp.87)))
      (set! fun/fixnum8774.10
        (begin
          (set! tmp.88 (begin (set! tmp.106 (alloc 16)) (+ tmp.106 2)))
          (begin
            (mset! tmp.88 -2 L.fun/fixnum8774.10.16)
            (mset! tmp.88 6 0)
            tmp.88)))
      (set! fun/fixnum8772.11
        (begin
          (set! tmp.89 (begin (set! tmp.107 (alloc 16)) (+ tmp.107 2)))
          (begin
            (mset! tmp.89 -2 L.fun/fixnum8772.11.17)
            (mset! tmp.89 6 8)
            tmp.89)))
      (begin
        (mset! fun/fixnum8773.7 14 fun/fixnum8774.10)
        (mset! fun/fixnum8771.8 14 fun/fixnum8772.11)
        (begin
          (set! tmp.108
            (if (begin (!= 1704 6))
              (if (begin
                    (set! tmp.109
                      (call L.fun/fixnum8771.8.14 fun/fixnum8771.8))
                    (!= tmp.109 6))
                (if (if (!= 14 6) (!= 1752 6) (!= 96 6))
                  (if (if (!= 6 6) (!= 1096 6) (!= 1120 6))
                    (if (begin
                          (set! tmp.110
                            (begin
                              (set! tmp.111 (call L.*.70.12 *.70 1040 504))
                              (call
                               L.fun/fixnum8773.7.13
                               fun/fixnum8773.7
                               tmp.111)))
                          (!= tmp.110 6))
                      (begin 1248)
                      6)
                    6)
                  6)
                6)
              6))
          (begin
            (set! tmp.112
              (if (begin
                    (set! fixnum0.17 800)
                    (set! pair1.16
                      (begin
                        (set! tmp.113 (call L.cons.71.11 cons.71 3632 22))
                        (call L.cons.71.11 cons.71 152 tmp.113)))
                    (set! pair2.15
                      (begin
                        (set! tmp.114 (call L.cons.71.11 cons.71 3624 22))
                        (call L.cons.71.11 cons.71 40 tmp.114)))
                    (!= 6 6))
                (call L.+.72.10 |+.72| 992 256)
                (begin
                  (set! tmp.115
                    (begin
                      (set! tmp.116 (call L.cons.71.11 cons.71 3520 22))
                      (call L.cons.71.11 cons.71 888 tmp.116)))
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
            (set! tmp.85 (begin (set! tmp.96 (alloc 16)) (+ tmp.96 1)))
            (begin (mset! tmp.85 -1 tmp.68) (mset! tmp.85 7 tmp.69) tmp.85)))))
    (define L.make-vector.75.14
      (lambda (c.81 tmp.49)
        (begin
          (set! make-init-vector.4 (mref c.81 14))
          (if (begin
                (set! tmp.97
                  (if (begin (set! tmp.98 (bitwise-and tmp.49 7)) (= tmp.98 0))
                    14
                    6))
                (!= tmp.97 6))
            (call L.make-init-vector.4.13 make-init-vector.4 tmp.49)
            2110))))
    (define L.make-init-vector.4.13
      (lambda (c.80 tmp.21)
        (begin
          (set! vector-init-loop.23 (mref c.80 14))
          (begin
            (set! tmp.22
              (begin
                (set! tmp.86
                  (begin
                    (set! tmp.99
                      (begin
                        (set! tmp.100
                          (begin
                            (set! tmp.101
                              (begin
                                (set! tmp.102
                                  (arithmetic-shift-right tmp.21 3))
                                (+ 1 tmp.102)))
                            (* tmp.101 8)))
                        (alloc tmp.100)))
                    (+ tmp.99 3)))
                (begin (mset! tmp.86 -3 tmp.21) tmp.86)))
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
          (if (begin (set! tmp.103 (if (= len.24 i.26) 14 6)) (!= tmp.103 6))
            vec.25
            (begin
              (begin
                (set! tmp.104
                  (begin
                    (set! tmp.105
                      (begin
                        (set! tmp.106 (arithmetic-shift-right i.26 3))
                        (* tmp.106 8)))
                    (+ tmp.105 5)))
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
                (set! tmp.108
                  (if (begin
                        (set! tmp.109 (bitwise-and tmp.52 7))
                        (= tmp.109 0))
                    14
                    6))
                (!= tmp.108 6))
            (if (begin
                  (set! tmp.110
                    (if (begin
                          (set! tmp.111 (bitwise-and tmp.51 7))
                          (= tmp.111 3))
                      14
                      6))
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
                (set! tmp.112
                  (if (begin
                        (set! tmp.113 (mref tmp.27 -3))
                        (< tmp.28 tmp.113))
                    14
                    6))
                (!= tmp.112 6))
            (if (begin (set! tmp.114 (if (>= tmp.28 0) 14 6)) (!= tmp.114 6))
              (begin
                (begin
                  (set! tmp.115
                    (begin
                      (set! tmp.116
                        (begin
                          (set! tmp.117 (arithmetic-shift-right tmp.28 3))
                          (* tmp.117 8)))
                      (+ tmp.116 5)))
                  (mset! tmp.27 tmp.115 tmp.29))
                30)
              2622)
            2622))))
    (begin
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.87 (begin (set! tmp.118 (alloc 16)) (+ tmp.118 2)))
          (begin
            (mset! tmp.87 -2 L.unsafe-vector-set!.5.10)
            (mset! tmp.87 6 24)
            tmp.87)))
      (set! vector-set!.76
        (begin
          (set! tmp.88 (begin (set! tmp.119 (alloc 24)) (+ tmp.119 2)))
          (begin
            (mset! tmp.88 -2 L.vector-set!.76.11)
            (mset! tmp.88 6 24)
            tmp.88)))
      (set! vector-init-loop.23
        (begin
          (set! tmp.89 (begin (set! tmp.120 (alloc 24)) (+ tmp.120 2)))
          (begin
            (mset! tmp.89 -2 L.vector-init-loop.23.12)
            (mset! tmp.89 6 24)
            tmp.89)))
      (set! make-init-vector.4
        (begin
          (set! tmp.90 (begin (set! tmp.121 (alloc 24)) (+ tmp.121 2)))
          (begin
            (mset! tmp.90 -2 L.make-init-vector.4.13)
            (mset! tmp.90 6 8)
            tmp.90)))
      (set! make-vector.75
        (begin
          (set! tmp.91 (begin (set! tmp.122 (alloc 24)) (+ tmp.122 2)))
          (begin
            (mset! tmp.91 -2 L.make-vector.75.14)
            (mset! tmp.91 6 8)
            tmp.91)))
      (set! cons.74
        (begin
          (set! tmp.92 (begin (set! tmp.123 (alloc 16)) (+ tmp.123 2)))
          (begin (mset! tmp.92 -2 L.cons.74.15) (mset! tmp.92 6 16) tmp.92)))
      (set! error?.73
        (begin
          (set! tmp.93 (begin (set! tmp.124 (alloc 16)) (+ tmp.124 2)))
          (begin (mset! tmp.93 -2 L.error?.73.16) (mset! tmp.93 6 8) tmp.93)))
      (set! fun/empty8780.8
        (begin
          (set! tmp.94 (begin (set! tmp.125 (alloc 16)) (+ tmp.125 2)))
          (begin
            (mset! tmp.94 -2 L.fun/empty8780.8.17)
            (mset! tmp.94 6 0)
            tmp.94)))
      (begin
        (mset! vector-set!.76 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.23 14 vector-init-loop.23)
        (mset! make-init-vector.4 14 vector-init-loop.23)
        (mset! make-vector.75 14 make-init-vector.4)
        (if (begin
              (set! tmp.126
                (begin
                  (set! tmp.127 (if (!= 14 6) 14 25902))
                  (call L.error?.73.16 error?.73 tmp.127)))
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
                        (set! pair0.11
                          (begin
                            (set! tmp.129 (call L.cons.74.15 cons.74 3560 22))
                            (call L.cons.74.15 cons.74 144 tmp.129)))
                        (set! vector1.10
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
                                g43031664.13
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
                                    g43031665.14
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
                                        g43031666.15
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
                                            g43031667.16
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
                                                g43031668.17
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
                                                    g43031669.18
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
                                                        g43031670.19
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
                                                            g43031671.20
                                                            tmp.7.12))))))))))))))))))
                        (set! pair2.9
                          (begin
                            (set! tmp.138 (call L.cons.74.15 cons.74 2528 22))
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
                (set! tmp.129
                  (if (begin
                        (set! tmp.130 (bitwise-and tmp.70 7))
                        (= tmp.130 0))
                    14
                    6))
                (!= tmp.129 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.70)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.106 tmp.42)
        (begin
          (set! vector-init-loop.44 (mref c.106 14))
          (begin
            (set! tmp.43
              (begin
                (set! tmp.114
                  (begin
                    (set! tmp.131
                      (begin
                        (set! tmp.132
                          (begin
                            (set! tmp.133
                              (begin
                                (set! tmp.134
                                  (arithmetic-shift-right tmp.42 3))
                                (+ 1 tmp.134)))
                            (* tmp.133 8)))
                        (alloc tmp.132)))
                    (+ tmp.131 3)))
                (begin (mset! tmp.114 -3 tmp.42) tmp.114)))
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
          (if (begin (set! tmp.135 (if (= len.45 i.47) 14 6)) (!= tmp.135 6))
            vec.46
            (begin
              (begin
                (set! tmp.136
                  (begin
                    (set! tmp.137
                      (begin
                        (set! tmp.138 (arithmetic-shift-right i.47 3))
                        (* tmp.138 8)))
                    (+ tmp.137 5)))
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
                (set! tmp.140
                  (if (begin
                        (set! tmp.141 (bitwise-and tmp.73 7))
                        (= tmp.141 0))
                    14
                    6))
                (!= tmp.140 6))
            (if (begin
                  (set! tmp.142
                    (if (begin
                          (set! tmp.143 (bitwise-and tmp.72 7))
                          (= tmp.143 3))
                      14
                      6))
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
                (set! tmp.144
                  (if (begin
                        (set! tmp.145 (mref tmp.48 -3))
                        (< tmp.49 tmp.145))
                    14
                    6))
                (!= tmp.144 6))
            (if (begin (set! tmp.146 (if (>= tmp.49 0) 14 6)) (!= tmp.146 6))
              (begin
                (begin
                  (set! tmp.147
                    (begin
                      (set! tmp.148
                        (begin
                          (set! tmp.149 (arithmetic-shift-right tmp.49 3))
                          (* tmp.149 8)))
                      (+ tmp.148 5)))
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
            (set! tmp.115 (begin (set! tmp.151 (alloc 16)) (+ tmp.151 1)))
            (begin
              (mset! tmp.115 -1 tmp.89)
              (mset! tmp.115 7 tmp.90)
              tmp.115)))))
    (begin
      (set! cons.97
        (begin
          (set! tmp.116 (begin (set! tmp.152 (alloc 16)) (+ tmp.152 2)))
          (begin
            (mset! tmp.116 -2 L.cons.97.10)
            (mset! tmp.116 6 16)
            tmp.116)))
      (set! error?.96
        (begin
          (set! tmp.117 (begin (set! tmp.153 (alloc 16)) (+ tmp.153 2)))
          (begin
            (mset! tmp.117 -2 L.error?.96.11)
            (mset! tmp.117 6 8)
            tmp.117)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.118 (begin (set! tmp.154 (alloc 16)) (+ tmp.154 2)))
          (begin
            (mset! tmp.118 -2 L.unsafe-vector-set!.5.12)
            (mset! tmp.118 6 24)
            tmp.118)))
      (set! vector-set!.95
        (begin
          (set! tmp.119 (begin (set! tmp.155 (alloc 24)) (+ tmp.155 2)))
          (begin
            (mset! tmp.119 -2 L.vector-set!.95.13)
            (mset! tmp.119 6 24)
            tmp.119)))
      (set! vector-init-loop.44
        (begin
          (set! tmp.120 (begin (set! tmp.156 (alloc 24)) (+ tmp.156 2)))
          (begin
            (mset! tmp.120 -2 L.vector-init-loop.44.14)
            (mset! tmp.120 6 24)
            tmp.120)))
      (set! make-init-vector.4
        (begin
          (set! tmp.121 (begin (set! tmp.157 (alloc 24)) (+ tmp.157 2)))
          (begin
            (mset! tmp.121 -2 L.make-init-vector.4.15)
            (mset! tmp.121 6 8)
            tmp.121)))
      (set! make-vector.94
        (begin
          (set! tmp.122 (begin (set! tmp.158 (alloc 24)) (+ tmp.158 2)))
          (begin
            (mset! tmp.122 -2 L.make-vector.94.16)
            (mset! tmp.122 6 8)
            tmp.122)))
      (set! fun/empty8795.13
        (begin
          (set! tmp.123 (begin (set! tmp.159 (alloc 16)) (+ tmp.159 2)))
          (begin
            (mset! tmp.123 -2 L.fun/empty8795.13.17)
            (mset! tmp.123 6 16)
            tmp.123)))
      (set! fun/boolean8796.14
        (begin
          (set! tmp.124 (begin (set! tmp.160 (alloc 16)) (+ tmp.160 2)))
          (begin
            (mset! tmp.124 -2 L.fun/boolean8796.14.18)
            (mset! tmp.124 6 8)
            tmp.124)))
      (set! fun/empty8794.15
        (begin
          (set! tmp.125 (begin (set! tmp.161 (alloc 16)) (+ tmp.161 2)))
          (begin
            (mset! tmp.125 -2 L.fun/empty8794.15.19)
            (mset! tmp.125 6 8)
            tmp.125)))
      (begin
        (mset! vector-set!.95 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.44 14 vector-init-loop.44)
        (mset! make-init-vector.4 14 vector-init-loop.44)
        (mset! make-vector.94 14 make-init-vector.4)
        (begin
          (set! tmp.7.20
            (begin
              (set! boolean0.23 6)
              (set! boolean1.22 6)
              (set! empty2.21 22)
              22))
          (if (!= tmp.7.20 6)
            tmp.7.20
            (begin
              (set! tmp.8.24
                (if (begin (set! empty0.25 22) (!= 22 6))
                  (if (begin
                        (set! tmp.162
                          (begin
                            (set! tmp.163
                              (begin
                                (set! lam.98
                                  (begin
                                    (set! tmp.126
                                      (begin
                                        (set! tmp.164 (alloc 16))
                                        (+ tmp.164 2)))
                                    (begin
                                      (mset! tmp.126 -2 L.lam.98.20)
                                      (mset! tmp.126 6 0)
                                      tmp.126)))
                                lam.98))
                            (call
                             L.fun/empty8794.15.19
                             fun/empty8794.15
                             tmp.163)))
                        (!= tmp.162 6))
                    (begin 22)
                    6)
                  6))
              (if (!= tmp.8.24 6)
                tmp.8.24
                (begin
                  (set! tmp.9.26
                    (begin
                      (set! tmp.165
                        (begin
                          (set! tmp.166
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
                                        (call
                                         L.error?.96.11
                                         error?.96
                                         g43039358.28))
                                      (!= tmp.167 6))
                                  g43039358.28
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
                                      g43039359.29
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
                                          g43039360.30
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
                                              g43039361.31
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
                                                  g43039362.32
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
                                                      g43039363.33
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
                                                          g43039364.34
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
                                                                  (!=
                                                                   tmp.174
                                                                   6))
                                                              g43039365.35
                                                              tmp.10.27))))))))))))))))))
                          (call
                           L.fun/boolean8796.14.18
                           fun/boolean8796.14
                           tmp.166)))
                      (begin
                        (set! tmp.175
                          (if (!= 14 6)
                            (begin
                              (set! lam.99
                                (begin
                                  (set! tmp.127
                                    (begin
                                      (set! tmp.176 (alloc 16))
                                      (+ tmp.176 2)))
                                  (begin
                                    (mset! tmp.127 -2 L.lam.99.21)
                                    (mset! tmp.127 6 0)
                                    tmp.127)))
                              lam.99)
                            (begin
                              (set! lam.100
                                (begin
                                  (set! tmp.128
                                    (begin
                                      (set! tmp.177 (alloc 16))
                                      (+ tmp.177 2)))
                                  (begin
                                    (mset! tmp.128 -2 L.lam.100.22)
                                    (mset! tmp.128 6 0)
                                    tmp.128)))
                              lam.100)))
                        (call
                         L.fun/empty8795.13.17
                         fun/empty8795.13
                         tmp.165
                         tmp.175))))
                  (if (!= tmp.9.26 6)
                    tmp.9.26
                    (begin
                      (set! tmp.11.36 (if (!= 14 6) 22 22))
                      (if (!= tmp.11.36 6)
                        tmp.11.36
                        (begin
                          (set! tmp.12.37 (if (!= 6 6) 22 22))
                          (if (!= tmp.12.37 6)
                            tmp.12.37
                            (begin
                              (set! g43039366.38
                                (begin
                                  (set! error0.41 41790)
                                  (set! pair1.40
                                    (begin
                                      (set! tmp.178
                                        (call L.cons.97.10 cons.97 3552 22))
                                      (call
                                       L.cons.97.10
                                       cons.97
                                       1312
                                       tmp.178)))
                                  (set! ascii-char2.39 25646)
                                  22))
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
      (set! fun/void8801.7
        (begin
          (set! tmp.65 (begin (set! tmp.68 (alloc 16)) (+ tmp.68 2)))
          (begin
            (mset! tmp.65 -2 L.fun/void8801.7.10)
            (mset! tmp.65 6 0)
            tmp.65)))
      (set! fun/void8800.8
        (begin
          (set! tmp.66 (begin (set! tmp.69 (alloc 24)) (+ tmp.69 2)))
          (begin
            (mset! tmp.66 -2 L.fun/void8800.8.11)
            (mset! tmp.66 6 0)
            tmp.66)))
      (set! fun/void8799.9
        (begin
          (set! tmp.67 (begin (set! tmp.70 (alloc 24)) (+ tmp.70 2)))
          (begin
            (mset! tmp.67 -2 L.fun/void8799.9.12)
            (mset! tmp.67 6 0)
            tmp.67)))
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
                (set! tmp.102
                  (if (begin
                        (set! tmp.103 (bitwise-and tmp.53 7))
                        (= tmp.103 0))
                    14
                    6))
                (!= tmp.102 6))
            (call L.make-init-vector.4.15 make-init-vector.4 tmp.53)
            2110))))
    (define L.make-init-vector.4.15
      (lambda (c.87 tmp.25)
        (begin
          (set! vector-init-loop.27 (mref c.87 14))
          (begin
            (set! tmp.26
              (begin
                (set! tmp.91
                  (begin
                    (set! tmp.104
                      (begin
                        (set! tmp.105
                          (begin
                            (set! tmp.106
                              (begin
                                (set! tmp.107
                                  (arithmetic-shift-right tmp.25 3))
                                (+ 1 tmp.107)))
                            (* tmp.106 8)))
                        (alloc tmp.105)))
                    (+ tmp.104 3)))
                (begin (mset! tmp.91 -3 tmp.25) tmp.91)))
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
          (if (begin (set! tmp.108 (if (= len.28 i.30) 14 6)) (!= tmp.108 6))
            vec.29
            (begin
              (begin
                (set! tmp.109
                  (begin
                    (set! tmp.110
                      (begin
                        (set! tmp.111 (arithmetic-shift-right i.30 3))
                        (* tmp.111 8)))
                    (+ tmp.110 5)))
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
                (set! tmp.113
                  (if (begin
                        (set! tmp.114 (bitwise-and tmp.56 7))
                        (= tmp.114 0))
                    14
                    6))
                (!= tmp.113 6))
            (if (begin
                  (set! tmp.115
                    (if (begin
                          (set! tmp.116 (bitwise-and tmp.55 7))
                          (= tmp.116 3))
                      14
                      6))
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
                (set! tmp.117
                  (if (begin
                        (set! tmp.118 (mref tmp.31 -3))
                        (< tmp.32 tmp.118))
                    14
                    6))
                (!= tmp.117 6))
            (if (begin (set! tmp.119 (if (>= tmp.32 0) 14 6)) (!= tmp.119 6))
              (begin
                (begin
                  (set! tmp.120
                    (begin
                      (set! tmp.121
                        (begin
                          (set! tmp.122 (arithmetic-shift-right tmp.32 3))
                          (* tmp.122 8)))
                      (+ tmp.121 5)))
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
                (set! tmp.124
                  (if (begin
                        (set! tmp.125 (bitwise-and tmp.46 7))
                        (= tmp.125 0))
                    14
                    6))
                (!= tmp.124 6))
            (if (begin
                  (set! tmp.126
                    (if (begin
                          (set! tmp.127 (bitwise-and tmp.45 7))
                          (= tmp.127 0))
                      14
                      6))
                  (!= tmp.126 6))
              (if (< tmp.45 tmp.46) 14 6)
              1086)
            1086))))
    (begin
      (set! <.81
        (begin
          (set! tmp.92 (begin (set! tmp.128 (alloc 16)) (+ tmp.128 2)))
          (begin (mset! tmp.92 -2 L.<.81.10) (mset! tmp.92 6 16) tmp.92)))
      (set! error?.80
        (begin
          (set! tmp.93 (begin (set! tmp.129 (alloc 16)) (+ tmp.129 2)))
          (begin (mset! tmp.93 -2 L.error?.80.11) (mset! tmp.93 6 8) tmp.93)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.94 (begin (set! tmp.130 (alloc 16)) (+ tmp.130 2)))
          (begin
            (mset! tmp.94 -2 L.unsafe-vector-set!.5.12)
            (mset! tmp.94 6 24)
            tmp.94)))
      (set! vector-set!.79
        (begin
          (set! tmp.95 (begin (set! tmp.131 (alloc 24)) (+ tmp.131 2)))
          (begin
            (mset! tmp.95 -2 L.vector-set!.79.13)
            (mset! tmp.95 6 24)
            tmp.95)))
      (set! vector-init-loop.27
        (begin
          (set! tmp.96 (begin (set! tmp.132 (alloc 24)) (+ tmp.132 2)))
          (begin
            (mset! tmp.96 -2 L.vector-init-loop.27.14)
            (mset! tmp.96 6 24)
            tmp.96)))
      (set! make-init-vector.4
        (begin
          (set! tmp.97 (begin (set! tmp.133 (alloc 24)) (+ tmp.133 2)))
          (begin
            (mset! tmp.97 -2 L.make-init-vector.4.15)
            (mset! tmp.97 6 8)
            tmp.97)))
      (set! make-vector.78
        (begin
          (set! tmp.98 (begin (set! tmp.134 (alloc 24)) (+ tmp.134 2)))
          (begin
            (mset! tmp.98 -2 L.make-vector.78.16)
            (mset! tmp.98 6 8)
            tmp.98)))
      (set! fixnum?.77
        (begin
          (set! tmp.99 (begin (set! tmp.135 (alloc 16)) (+ tmp.135 2)))
          (begin (mset! tmp.99 -2 L.fixnum?.77.17) (mset! tmp.99 6 8) tmp.99)))
      (set! fun/any8804.8
        (begin
          (set! tmp.100 (begin (set! tmp.136 (alloc 16)) (+ tmp.136 2)))
          (begin
            (mset! tmp.100 -2 L.fun/any8804.8.18)
            (mset! tmp.100 6 16)
            tmp.100)))
      (begin
        (mset! vector-set!.79 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.27 14 vector-init-loop.27)
        (mset! make-init-vector.4 14 vector-init-loop.27)
        (mset! make-vector.78 14 make-init-vector.4)
        (if (begin
              (set! tmp.137
                (begin
                  (set! tmp.138 (call L.fun/any8804.8.18 fun/any8804.8 22 30))
                  (call L.fixnum?.77.17 fixnum?.77 tmp.138)))
              (!= tmp.137 6))
          (begin (set! boolean0.12 6) (set! boolean1.11 14) 14)
          (begin
            (set! tmp.139
              (if (!= 1232 6)
                (if (!= 448 6)
                  (if (!= 752 6) (if (!= 776 6) (if (!= 952 6) 168 6) 6) 6)
                  6)
                6))
            (begin
              (set! tmp.140
                (begin
                  (set! void0.15 30)
                  (set! vector1.14
                    (begin
                      (set! tmp.7.16
                        (call L.make-vector.78.16 make-vector.78 64))
                      (begin
                        (set! g43047001.17
                          (call
                           L.vector-set!.79.13
                           vector-set!.79
                           tmp.7.16
                           0
                           8))
                        (if (begin
                              (set! tmp.141
                                (call L.error?.80.11 error?.80 g43047001.17))
                              (!= tmp.141 6))
                          g43047001.17
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
                                    (call
                                     L.error?.80.11
                                     error?.80
                                     g43047002.18))
                                  (!= tmp.142 6))
                              g43047002.18
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
                                  g43047003.19
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
                                      g43047004.20
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
                                          g43047005.21
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
                                              g43047006.22
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
                                                  g43047007.23
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
                                                      g43047008.24
                                                      tmp.7.16))))))))))))))))))
                  (set! void2.13 30)
                  736))
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
            (set! tmp.64 (begin (set! tmp.67 (alloc 16)) (+ tmp.67 1)))
            (begin (mset! tmp.64 -1 tmp.56) (mset! tmp.64 7 tmp.57) tmp.64)))))
    (begin
      (set! cons.61
        (begin
          (set! tmp.65 (begin (set! tmp.68 (alloc 16)) (+ tmp.68 2)))
          (begin (mset! tmp.65 -2 L.cons.61.10) (mset! tmp.65 6 16) tmp.65)))
      (set! fun/fixnum8807.7
        (begin
          (set! tmp.66 (begin (set! tmp.69 (alloc 24)) (+ tmp.69 2)))
          (begin
            (mset! tmp.66 -2 L.fun/fixnum8807.7.11)
            (mset! tmp.66 6 0)
            tmp.66)))
      (begin
        (mset! fun/fixnum8807.7 14 cons.61)
        (begin (call L.fun/fixnum8807.7.11 fun/fixnum8807.7))))))
(check-by-interp
 '(module
    (begin
      (set! void0.7 (if (!= 14 6) 30 30))
      (begin (set! void0.9 30) (set! empty1.8 22) 30))))
(check-by-interp
 '(module
    (begin
      (set! empty0.7 (begin (set! fixnum0.9 864) (set! error1.8 29758) 22))
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
      (set! error?.70
        (begin
          (set! tmp.72 (begin (set! tmp.74 (alloc 16)) (+ tmp.74 2)))
          (begin (mset! tmp.72 -2 L.error?.70.10) (mset! tmp.72 6 8) tmp.72)))
      (begin
        (set! empty0.10
          (begin (set! tmp.7.11 22) (if (!= tmp.7.11 6) tmp.7.11 22)))
        (set! ascii-char1.9
          (begin
            (set! g43062278.12
              (begin
                (set! g43062279.13 24366)
                (if (begin
                      (set! tmp.75
                        (call L.error?.70.10 error?.70 g43062279.13))
                      (!= tmp.75 6))
                  g43062279.13
                  (begin
                    (set! g43062280.14 23086)
                    (if (begin
                          (set! tmp.76
                            (call L.error?.70.10 error?.70 g43062280.14))
                          (!= tmp.76 6))
                      g43062280.14
                      (begin
                        (set! g43062281.15 29998)
                        (if (begin
                              (set! tmp.77
                                (call L.error?.70.10 error?.70 g43062281.15))
                              (!= tmp.77 6))
                          g43062281.15
                          20782)))))))
            (if (begin
                  (set! tmp.78 (call L.error?.70.10 error?.70 g43062278.12))
                  (!= tmp.78 6))
              g43062278.12
              (begin
                (set! g43062282.16 (begin 24110))
                (if (begin
                      (set! tmp.79
                        (call L.error?.70.10 error?.70 g43062282.16))
                      (!= tmp.79 6))
                  g43062282.16
                  (begin
                    (set! g43062283.17 (begin 27694))
                    (if (begin
                          (set! tmp.80
                            (call L.error?.70.10 error?.70 g43062283.17))
                          (!= tmp.80 6))
                      g43062283.17
                      (begin 27950))))))))
        (set! error2.8 (begin 13374))
        (begin 144)))))
(check-by-interp
 '(module
    (define L.cons.60.11
      (lambda (c.63 tmp.55 tmp.56)
        (begin
          (begin
            (set! tmp.64 (begin (set! tmp.67 (alloc 16)) (+ tmp.67 1)))
            (begin (mset! tmp.64 -1 tmp.55) (mset! tmp.64 7 tmp.56) tmp.64)))))
    (define L.+.61.10
      (lambda (c.62 tmp.24 tmp.25)
        (begin
          (if (begin
                (set! tmp.68
                  (if (begin (set! tmp.69 (bitwise-and tmp.25 7)) (= tmp.69 0))
                    14
                    6))
                (!= tmp.68 6))
            (if (begin
                  (set! tmp.70
                    (if (begin
                          (set! tmp.71 (bitwise-and tmp.24 7))
                          (= tmp.71 0))
                      14
                      6))
                  (!= tmp.70 6))
              (+ tmp.24 tmp.25)
              574)
            574))))
    (begin
      (set! |+.61|
        (begin
          (set! tmp.65 (begin (set! tmp.72 (alloc 16)) (+ tmp.72 2)))
          (begin (mset! tmp.65 -2 L.+.61.10) (mset! tmp.65 6 16) tmp.65)))
      (set! cons.60
        (begin
          (set! tmp.66 (begin (set! tmp.73 (alloc 16)) (+ tmp.73 2)))
          (begin (mset! tmp.66 -2 L.cons.60.11) (mset! tmp.66 6 16) tmp.66)))
      (begin
        (set! tmp.74 (if (!= 14 6) 752 1288))
        (begin
          (set! tmp.75
            (begin
              (set! pair0.7
                (begin
                  (set! tmp.76
                    (begin
                      (set! tmp.77
                        (begin
                          (set! tmp.78
                            (begin
                              (set! tmp.79
                                (begin
                                  (set! tmp.80
                                    (call L.cons.60.11 cons.60 2064 22))
                                  (call L.cons.60.11 cons.60 272 tmp.80)))
                              (begin
                                (set! tmp.81
                                  (begin
                                    (set! tmp.82
                                      (begin
                                        (set! tmp.83
                                          (begin
                                            (set! tmp.84
                                              (call
                                               L.cons.60.11
                                               cons.60
                                               672
                                               22))
                                            (call
                                             L.cons.60.11
                                             cons.60
                                             6
                                             tmp.84)))
                                        (call L.cons.60.11 cons.60 22 tmp.83)))
                                    (call L.cons.60.11 cons.60 19502 tmp.82)))
                                (call L.cons.60.11 cons.60 tmp.79 tmp.81))))
                          (call L.cons.60.11 cons.60 6 tmp.78)))
                      (call L.cons.60.11 cons.60 1640 tmp.77)))
                  (call L.cons.60.11 cons.60 22 tmp.76)))
              (if (!= 6 6) 312 1328)))
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
                (set! tmp.76
                  (begin
                    (set! tmp.77
                      (begin
                        (set! tmp.78 (call L.cons.64.10 cons.64 2400 22))
                        (call L.cons.64.10 cons.64 896 tmp.78)))
                    (call L.fun/boolean8824.10.14 fun/boolean8824.10 tmp.77)))
                (!= tmp.76 6))
            (call L.fun/ascii-char8825.9.13 fun/ascii-char8825.9)
            (call L.fun/ascii-char8826.7.11 fun/ascii-char8826.7)))))
    (define L.fun/ascii-char8826.7.11 (lambda (c.66) (begin 27438)))
    (define L.cons.64.10
      (lambda (c.65 tmp.59 tmp.60)
        (begin
          (begin
            (set! tmp.70 (begin (set! tmp.79 (alloc 16)) (+ tmp.79 1)))
            (begin (mset! tmp.70 -1 tmp.59) (mset! tmp.70 7 tmp.60) tmp.70)))))
    (begin
      (set! cons.64
        (begin
          (set! tmp.71 (begin (set! tmp.80 (alloc 16)) (+ tmp.80 2)))
          (begin (mset! tmp.71 -2 L.cons.64.10) (mset! tmp.71 6 16) tmp.71)))
      (set! fun/ascii-char8826.7
        (begin
          (set! tmp.72 (begin (set! tmp.81 (alloc 16)) (+ tmp.81 2)))
          (begin
            (mset! tmp.72 -2 L.fun/ascii-char8826.7.11)
            (mset! tmp.72 6 0)
            tmp.72)))
      (set! fun/ascii-char8823.8
        (begin
          (set! tmp.73 (begin (set! tmp.82 (alloc 48)) (+ tmp.82 2)))
          (begin
            (mset! tmp.73 -2 L.fun/ascii-char8823.8.12)
            (mset! tmp.73 6 0)
            tmp.73)))
      (set! fun/ascii-char8825.9
        (begin
          (set! tmp.74 (begin (set! tmp.83 (alloc 16)) (+ tmp.83 2)))
          (begin
            (mset! tmp.74 -2 L.fun/ascii-char8825.9.13)
            (mset! tmp.74 6 0)
            tmp.74)))
      (set! fun/boolean8824.10
        (begin
          (set! tmp.75 (begin (set! tmp.84 (alloc 16)) (+ tmp.84 2)))
          (begin
            (mset! tmp.75 -2 L.fun/boolean8824.10.14)
            (mset! tmp.75 6 8)
            tmp.75)))
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
      (set! fun/boolean8831.7
        (begin
          (set! tmp.70 (begin (set! tmp.74 (alloc 24)) (+ tmp.74 2)))
          (begin
            (mset! tmp.70 -2 L.fun/boolean8831.7.10)
            (mset! tmp.70 6 0)
            tmp.70)))
      (set! fun/boolean8829.8
        (begin
          (set! tmp.71 (begin (set! tmp.75 (alloc 24)) (+ tmp.75 2)))
          (begin
            (mset! tmp.71 -2 L.fun/boolean8829.8.11)
            (mset! tmp.71 6 8)
            tmp.71)))
      (set! fun/boolean8832.9
        (begin
          (set! tmp.72 (begin (set! tmp.76 (alloc 16)) (+ tmp.76 2)))
          (begin
            (mset! tmp.72 -2 L.fun/boolean8832.9.12)
            (mset! tmp.72 6 0)
            tmp.72)))
      (set! fun/boolean8830.10
        (begin
          (set! tmp.73 (begin (set! tmp.77 (alloc 24)) (+ tmp.77 2)))
          (begin
            (mset! tmp.73 -2 L.fun/boolean8830.10.13)
            (mset! tmp.73 6 0)
            tmp.73)))
      (begin
        (mset! fun/boolean8831.7 14 fun/boolean8832.9)
        (mset! fun/boolean8829.8 14 fun/boolean8830.10)
        (mset! fun/boolean8830.10 14 fun/boolean8831.7)
        (begin
          (set! tmp.78
            (if (begin (set! void0.12 30) (!= 6 6))
              (if (!= 6 6) 22 22)
              (begin (set! void0.13 30) 22)))
          (call L.fun/boolean8829.8.11 fun/boolean8829.8 tmp.78))))))
(check-by-interp
 '(module
    (if (begin (set! void0.7 30) (!= 14 6))
      (begin (set! empty0.10 22) (set! empty1.9 22) (set! boolean2.8 14) 30510)
      (if (!= 14 6) 17966 30510))))
(check-by-interp '(module (begin (begin 64062))))
(check-by-interp
 '(module
    (define L.lam.88.16
      (lambda (c.96 oprand0.19)
        (begin
          (begin
            (set! lam.89
              (begin
                (set! tmp.98 (begin (set! tmp.107 (alloc 16)) (+ tmp.107 2)))
                (begin
                  (mset! tmp.98 -2 L.lam.89.17)
                  (mset! tmp.98 6 0)
                  tmp.98)))
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
            (set! tmp.99 (begin (set! tmp.108 (alloc 16)) (+ tmp.108 1)))
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
      (set! error?.87
        (begin
          (set! tmp.100 (begin (set! tmp.111 (alloc 16)) (+ tmp.111 2)))
          (begin
            (mset! tmp.100 -2 L.error?.87.10)
            (mset! tmp.100 6 8)
            tmp.100)))
      (set! ascii-char?.86
        (begin
          (set! tmp.101 (begin (set! tmp.112 (alloc 16)) (+ tmp.112 2)))
          (begin
            (mset! tmp.101 -2 L.ascii-char?.86.11)
            (mset! tmp.101 6 8)
            tmp.101)))
      (set! cons.85
        (begin
          (set! tmp.102 (begin (set! tmp.113 (alloc 16)) (+ tmp.113 2)))
          (begin
            (mset! tmp.102 -2 L.cons.85.12)
            (mset! tmp.102 6 16)
            tmp.102)))
      (set! fun/void8949.12
        (begin
          (set! tmp.103 (begin (set! tmp.114 (alloc 16)) (+ tmp.114 2)))
          (begin
            (mset! tmp.103 -2 L.fun/void8949.12.13)
            (mset! tmp.103 6 16)
            tmp.103)))
      (set! fun/void8950.13
        (begin
          (set! tmp.104 (begin (set! tmp.115 (alloc 16)) (+ tmp.115 2)))
          (begin
            (mset! tmp.104 -2 L.fun/void8950.13.14)
            (mset! tmp.104 6 0)
            tmp.104)))
      (set! fun/void8951.14
        (begin
          (set! tmp.105 (begin (set! tmp.116 (alloc 16)) (+ tmp.116 2)))
          (begin
            (mset! tmp.105 -2 L.fun/void8951.14.15)
            (mset! tmp.105 6 0)
            tmp.105)))
      (if (begin
            (set! tmp.117
              (begin
                (set! tmp.118
                  (begin
                    (set! procedure0.18
                      (begin
                        (set! lam.88
                          (begin
                            (set! tmp.106
                              (begin (set! tmp.119 (alloc 16)) (+ tmp.119 2)))
                            (begin
                              (mset! tmp.106 -2 L.lam.88.16)
                              (mset! tmp.106 6 8)
                              tmp.106)))
                        lam.88))
                    (set! pair1.17
                      (begin
                        (set! tmp.120 (call L.cons.85.12 cons.85 2664 22))
                        (call L.cons.85.12 cons.85 552 tmp.120)))
                    48446))
                (call L.ascii-char?.86.11 ascii-char?.86 tmp.118)))
            (!= tmp.117 6))
        (begin
          (set! tmp.121 (if (!= 14 6) 1808 144))
          (begin
            (set! tmp.122
              (begin
                (set! g43150205.20 22830)
                (if (begin
                      (set! tmp.123
                        (call L.error?.87.10 error?.87 g43150205.20))
                      (!= tmp.123 6))
                  g43150205.20
                  (begin
                    (set! g43150206.21 29742)
                    (if (begin
                          (set! tmp.124
                            (call L.error?.87.10 error?.87 g43150206.21))
                          (!= tmp.124 6))
                      g43150206.21
                      (begin
                        (set! g43150207.22 27694)
                        (if (begin
                              (set! tmp.125
                                (call L.error?.87.10 error?.87 g43150207.22))
                              (!= tmp.125 6))
                          g43150207.22
                          (begin
                            (set! g43150208.23 29486)
                            (if (begin
                                  (set! tmp.126
                                    (call
                                     L.error?.87.10
                                     error?.87
                                     g43150208.23))
                                  (!= tmp.126 6))
                              g43150208.23
                              (begin
                                (set! g43150209.24 26414)
                                (if (begin
                                      (set! tmp.127
                                        (call
                                         L.error?.87.10
                                         error?.87
                                         g43150209.24))
                                      (!= tmp.127 6))
                                  g43150209.24
                                  (begin
                                    (set! g43150210.25 22062)
                                    (if (begin
                                          (set! tmp.128
                                            (call
                                             L.error?.87.10
                                             error?.87
                                             g43150210.25))
                                          (!= tmp.128 6))
                                      g43150210.25
                                      16686)))))))))))))
            (call L.fun/void8949.12.13 fun/void8949.12 tmp.121 tmp.122)))
        (begin
          (set! tmp.7.26
            (begin
              (set! pair0.28
                (begin
                  (set! tmp.129 (call L.cons.85.12 cons.85 2568 22))
                  (call L.cons.85.12 cons.85 1616 tmp.129)))
              (set! pair1.27
                (begin
                  (set! tmp.130 (call L.cons.85.12 cons.85 3312 22))
                  (call L.cons.85.12 cons.85 1144 tmp.130)))
              30))
          (if (!= tmp.7.26 6)
            tmp.7.26
            (begin
              (set! tmp.8.29 (if (!= 14 6) 30 30))
              (if (!= tmp.8.29 6)
                tmp.8.29
                (begin
                  (set! tmp.9.30 (call L.fun/void8950.13.14 fun/void8950.13))
                  (if (!= tmp.9.30 6)
                    tmp.9.30
                    (begin
                      (set! tmp.10.31 (if (!= 14 6) 30 30))
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
      (set! fun/error8958.7
        (begin
          (set! tmp.65 (begin (set! tmp.68 (alloc 16)) (+ tmp.68 2)))
          (begin
            (mset! tmp.65 -2 L.fun/error8958.7.10)
            (mset! tmp.65 6 0)
            tmp.65)))
      (set! fun/error8956.8
        (begin
          (set! tmp.66 (begin (set! tmp.69 (alloc 24)) (+ tmp.69 2)))
          (begin
            (mset! tmp.66 -2 L.fun/error8956.8.11)
            (mset! tmp.66 6 0)
            tmp.66)))
      (set! fun/error8957.9
        (begin
          (set! tmp.67 (begin (set! tmp.70 (alloc 24)) (+ tmp.70 2)))
          (begin
            (mset! tmp.67 -2 L.fun/error8957.9.12)
            (mset! tmp.67 6 0)
            tmp.67)))
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
            (set! tmp.67 (begin (set! tmp.71 (alloc 16)) (+ tmp.71 1)))
            (begin (mset! tmp.67 -1 tmp.58) (mset! tmp.67 7 tmp.59) tmp.67)))))
    (begin
      (set! cons.63
        (begin
          (set! tmp.68 (begin (set! tmp.72 (alloc 16)) (+ tmp.72 2)))
          (begin (mset! tmp.68 -2 L.cons.63.10) (mset! tmp.68 6 16) tmp.68)))
      (set! fun/error8961.7
        (begin
          (set! tmp.69 (begin (set! tmp.73 (alloc 24)) (+ tmp.73 2)))
          (begin
            (mset! tmp.69 -2 L.fun/error8961.7.11)
            (mset! tmp.69 6 0)
            tmp.69)))
      (set! fun/error8962.8
        (begin
          (set! tmp.70 (begin (set! tmp.74 (alloc 16)) (+ tmp.74 2)))
          (begin
            (mset! tmp.70 -2 L.fun/error8962.8.12)
            (mset! tmp.70 6 0)
            tmp.70)))
      (begin
        (mset! fun/error8961.7 14 fun/error8962.8)
        (begin
          (set! pair0.10
            (begin
              (set! tmp.75
                (begin
                  (set! tmp.76 (call L.cons.63.10 cons.63 3800 22))
                  (call L.cons.63.10 cons.63 832 tmp.76)))
              (begin
                (set! tmp.77
                  (begin
                    (set! tmp.78
                      (begin
                        (set! tmp.79
                          (begin
                            (set! tmp.80
                              (begin
                                (set! tmp.81
                                  (begin
                                    (set! tmp.82
                                      (begin
                                        (set! tmp.83
                                          (call L.cons.63.10 cons.63 22 22))
                                        (call L.cons.63.10 cons.63 22 tmp.83)))
                                    (call L.cons.63.10 cons.63 14 tmp.82)))
                                (call L.cons.63.10 cons.63 1352 tmp.81)))
                            (call L.cons.63.10 cons.63 22 tmp.80)))
                        (call L.cons.63.10 cons.63 6 tmp.79)))
                    (call L.cons.63.10 cons.63 0 tmp.78)))
                (call L.cons.63.10 cons.63 tmp.75 tmp.77))))
          (set! boolean1.9 (begin 6))
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
                (set! tmp.111
                  (if (begin
                        (set! tmp.112 (bitwise-and tmp.67 7))
                        (= tmp.112 0))
                    14
                    6))
                (!= tmp.111 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.67)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.98 tmp.39)
        (begin
          (set! vector-init-loop.41 (mref c.98 14))
          (begin
            (set! tmp.40
              (begin
                (set! tmp.102
                  (begin
                    (set! tmp.113
                      (begin
                        (set! tmp.114
                          (begin
                            (set! tmp.115
                              (begin
                                (set! tmp.116
                                  (arithmetic-shift-right tmp.39 3))
                                (+ 1 tmp.116)))
                            (* tmp.115 8)))
                        (alloc tmp.114)))
                    (+ tmp.113 3)))
                (begin (mset! tmp.102 -3 tmp.39) tmp.102)))
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
          (if (begin (set! tmp.117 (if (= len.42 i.44) 14 6)) (!= tmp.117 6))
            vec.43
            (begin
              (begin
                (set! tmp.118
                  (begin
                    (set! tmp.119
                      (begin
                        (set! tmp.120 (arithmetic-shift-right i.44 3))
                        (* tmp.120 8)))
                    (+ tmp.119 5)))
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
                (set! tmp.122
                  (if (begin
                        (set! tmp.123 (bitwise-and tmp.70 7))
                        (= tmp.123 0))
                    14
                    6))
                (!= tmp.122 6))
            (if (begin
                  (set! tmp.124
                    (if (begin
                          (set! tmp.125 (bitwise-and tmp.69 7))
                          (= tmp.125 3))
                      14
                      6))
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
                (set! tmp.126
                  (if (begin
                        (set! tmp.127 (mref tmp.45 -3))
                        (< tmp.46 tmp.127))
                    14
                    6))
                (!= tmp.126 6))
            (if (begin (set! tmp.128 (if (>= tmp.46 0) 14 6)) (!= tmp.128 6))
              (begin
                (begin
                  (set! tmp.129
                    (begin
                      (set! tmp.130
                        (begin
                          (set! tmp.131 (arithmetic-shift-right tmp.46 3))
                          (* tmp.131 8)))
                      (+ tmp.130 5)))
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
      (set! error?.93
        (begin
          (set! tmp.103 (begin (set! tmp.133 (alloc 16)) (+ tmp.133 2)))
          (begin
            (mset! tmp.103 -2 L.error?.93.10)
            (mset! tmp.103 6 8)
            tmp.103)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.104 (begin (set! tmp.134 (alloc 16)) (+ tmp.134 2)))
          (begin
            (mset! tmp.104 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.104 6 24)
            tmp.104)))
      (set! vector-set!.92
        (begin
          (set! tmp.105 (begin (set! tmp.135 (alloc 24)) (+ tmp.135 2)))
          (begin
            (mset! tmp.105 -2 L.vector-set!.92.12)
            (mset! tmp.105 6 24)
            tmp.105)))
      (set! vector-init-loop.41
        (begin
          (set! tmp.106 (begin (set! tmp.136 (alloc 24)) (+ tmp.136 2)))
          (begin
            (mset! tmp.106 -2 L.vector-init-loop.41.13)
            (mset! tmp.106 6 24)
            tmp.106)))
      (set! make-init-vector.4
        (begin
          (set! tmp.107 (begin (set! tmp.137 (alloc 24)) (+ tmp.137 2)))
          (begin
            (mset! tmp.107 -2 L.make-init-vector.4.14)
            (mset! tmp.107 6 8)
            tmp.107)))
      (set! make-vector.91
        (begin
          (set! tmp.108 (begin (set! tmp.138 (alloc 24)) (+ tmp.138 2)))
          (begin
            (mset! tmp.108 -2 L.make-vector.91.15)
            (mset! tmp.108 6 8)
            tmp.108)))
      (set! fun/ascii-char8966.15
        (begin
          (set! tmp.109 (begin (set! tmp.139 (alloc 16)) (+ tmp.139 2)))
          (begin
            (mset! tmp.109 -2 L.fun/ascii-char8966.15.16)
            (mset! tmp.109 6 16)
            tmp.109)))
      (set! fun/ascii-char8965.16
        (begin
          (set! tmp.110 (begin (set! tmp.140 (alloc 16)) (+ tmp.140 2)))
          (begin
            (mset! tmp.110 -2 L.fun/ascii-char8965.16.17)
            (mset! tmp.110 6 16)
            tmp.110)))
      (begin
        (mset! vector-set!.92 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.41 14 vector-init-loop.41)
        (mset! make-init-vector.4 14 vector-init-loop.41)
        (mset! make-vector.91 14 make-init-vector.4)
        (if (if (!= 14 6) (!= 14 6) (!= 6 6))
          (begin
            (set! tmp.7.21 (if (!= 14 6) 29230 24622))
            (if (!= tmp.7.21 6)
              tmp.7.21
              (begin
                (set! tmp.8.22
                  (begin
                    (set! tmp.9.23 20782)
                    (if (!= tmp.9.23 6)
                      tmp.9.23
                      (begin
                        (set! tmp.10.24 17710)
                        (if (!= tmp.10.24 6) tmp.10.24 17710)))))
                (if (!= tmp.8.22 6)
                  tmp.8.22
                  (begin
                    (set! tmp.11.25 (if (!= 6 6) 27438 18990))
                    (if (!= tmp.11.25 6)
                      tmp.11.25
                      (begin
                        (set! tmp.12.26 (if (!= 6 6) 19758 30254))
                        (if (!= tmp.12.26 6)
                          tmp.12.26
                          (begin
                            (set! tmp.13.27
                              (begin
                                (set! tmp.141
                                  (call L.make-vector.91.15 make-vector.91 64))
                                (call
                                 L.fun/ascii-char8965.16.17
                                 fun/ascii-char8965.16
                                 6
                                 tmp.141)))
                            (if (!= tmp.13.27 6)
                              tmp.13.27
                              (begin
                                (set! tmp.142
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
                                        g43165470.29
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
                                            g43165471.30
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
                                                g43165472.31
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
                                                    g43165473.32
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
                                                        g43165474.33
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
                                                            g43165475.34
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
                                                                g43165476.35
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
                                                                    g43165477.36
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
                    (set! tmp.9.19 (if (!= 6 6) 30 30))
                    (if (!= tmp.9.19 6)
                      tmp.9.19
                      (begin
                        (set! tmp.10.20 (begin 30))
                        (if (!= tmp.10.20 6)
                          tmp.10.20
                          (begin
                            (set! tmp.11.21 (begin 30))
                            (if (!= tmp.11.21 6)
                              tmp.11.21
                              (begin
                                (set! tmp.12.22 (if (!= 6 6) 30 30))
                                (if (!= tmp.12.22 6)
                                  tmp.12.22
                                  (begin 30))))))))))))))))
    (define L.fun/void8969.13.10 (lambda (c.77) (begin 30)))
    (begin
      (set! fun/void8969.13
        (begin
          (set! tmp.80 (begin (set! tmp.83 (alloc 16)) (+ tmp.83 2)))
          (begin
            (mset! tmp.80 -2 L.fun/void8969.13.10)
            (mset! tmp.80 6 0)
            tmp.80)))
      (begin
        (set! ascii-char0.16 (if (!= 6 6) 24878 21294))
        (set! procedure1.15
          (begin
            (set! lam.75
              (begin
                (set! tmp.81 (begin (set! tmp.84 (alloc 24)) (+ tmp.84 2)))
                (begin
                  (mset! tmp.81 -2 L.lam.75.11)
                  (mset! tmp.81 6 0)
                  tmp.81)))
            (begin (mset! lam.75 14 fun/void8969.13) lam.75)))
        (set! procedure2.14
          (begin
            (set! lam.76
              (begin
                (set! tmp.82 (begin (set! tmp.85 (alloc 16)) (+ tmp.85 2)))
                (begin
                  (mset! tmp.82 -2 L.lam.76.12)
                  (mset! tmp.82 6 0)
                  tmp.82)))
            lam.76))
        (if (!= 14 6) 60734 574)))))
(check-by-interp
 '(module
    (define L.fun/boolean8972.9.12
      (lambda (c.67)
        (begin
          (set! fun/boolean8973.8 (mref c.67 14))
          (begin
            (set! tmp.75
              (if (!= 6 6)
                (begin
                  (set! lam.63
                    (begin
                      (set! tmp.70
                        (begin (set! tmp.76 (alloc 16)) (+ tmp.76 2)))
                      (begin
                        (mset! tmp.70 -2 L.lam.63.13)
                        (mset! tmp.70 6 0)
                        tmp.70)))
                  lam.63)
                (begin
                  (set! lam.64
                    (begin
                      (set! tmp.71
                        (begin (set! tmp.77 (alloc 16)) (+ tmp.77 2)))
                      (begin
                        (mset! tmp.71 -2 L.lam.64.14)
                        (mset! tmp.71 6 0)
                        tmp.71)))
                  lam.64)))
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
      (set! fun/boolean8974.7
        (begin
          (set! tmp.72 (begin (set! tmp.78 (alloc 16)) (+ tmp.78 2)))
          (begin
            (mset! tmp.72 -2 L.fun/boolean8974.7.10)
            (mset! tmp.72 6 0)
            tmp.72)))
      (set! fun/boolean8973.8
        (begin
          (set! tmp.73 (begin (set! tmp.79 (alloc 24)) (+ tmp.79 2)))
          (begin
            (mset! tmp.73 -2 L.fun/boolean8973.8.11)
            (mset! tmp.73 6 8)
            tmp.73)))
      (set! fun/boolean8972.9
        (begin
          (set! tmp.74 (begin (set! tmp.80 (alloc 24)) (+ tmp.80 2)))
          (begin
            (mset! tmp.74 -2 L.fun/boolean8972.9.12)
            (mset! tmp.74 6 0)
            tmp.74)))
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
              (set! lam.90
                (begin
                  (set! tmp.106
                    (begin (set! tmp.123 (alloc 16)) (+ tmp.123 2)))
                  (begin
                    (mset! tmp.106 -2 L.lam.90.24)
                    (mset! tmp.106 6 0)
                    tmp.106)))
              lam.90)))))
    (define L.lam.90.24 (lambda (c.101) (begin 6760)))
    (define L.fun/boolean8978.9.18 (lambda (c.99 oprand0.15) (begin 14)))
    (define L.cons.85.17
      (lambda (c.98 tmp.80 tmp.81)
        (begin
          (begin
            (set! tmp.107 (begin (set! tmp.124 (alloc 16)) (+ tmp.124 1)))
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
                (set! tmp.126
                  (if (begin
                        (set! tmp.127 (bitwise-and tmp.61 7))
                        (= tmp.127 0))
                    14
                    6))
                (!= tmp.126 6))
            (call L.make-init-vector.4.14 make-init-vector.4 tmp.61)
            2110))))
    (define L.make-init-vector.4.14
      (lambda (c.95 tmp.33)
        (begin
          (set! vector-init-loop.35 (mref c.95 14))
          (begin
            (set! tmp.34
              (begin
                (set! tmp.108
                  (begin
                    (set! tmp.128
                      (begin
                        (set! tmp.129
                          (begin
                            (set! tmp.130
                              (begin
                                (set! tmp.131
                                  (arithmetic-shift-right tmp.33 3))
                                (+ 1 tmp.131)))
                            (* tmp.130 8)))
                        (alloc tmp.129)))
                    (+ tmp.128 3)))
                (begin (mset! tmp.108 -3 tmp.33) tmp.108)))
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
          (if (begin (set! tmp.132 (if (= len.36 i.38) 14 6)) (!= tmp.132 6))
            vec.37
            (begin
              (begin
                (set! tmp.133
                  (begin
                    (set! tmp.134
                      (begin
                        (set! tmp.135 (arithmetic-shift-right i.38 3))
                        (* tmp.135 8)))
                    (+ tmp.134 5)))
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
                (set! tmp.137
                  (if (begin
                        (set! tmp.138 (bitwise-and tmp.64 7))
                        (= tmp.138 0))
                    14
                    6))
                (!= tmp.137 6))
            (if (begin
                  (set! tmp.139
                    (if (begin
                          (set! tmp.140 (bitwise-and tmp.63 7))
                          (= tmp.140 3))
                      14
                      6))
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
                (set! tmp.141
                  (if (begin
                        (set! tmp.142 (mref tmp.39 -3))
                        (< tmp.40 tmp.142))
                    14
                    6))
                (!= tmp.141 6))
            (if (begin (set! tmp.143 (if (>= tmp.40 0) 14 6)) (!= tmp.143 6))
              (begin
                (begin
                  (set! tmp.144
                    (begin
                      (set! tmp.145
                        (begin
                          (set! tmp.146 (arithmetic-shift-right tmp.40 3))
                          (* tmp.146 8)))
                      (+ tmp.145 5)))
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
      (set! error?.89
        (begin
          (set! tmp.109 (begin (set! tmp.148 (alloc 16)) (+ tmp.148 2)))
          (begin
            (mset! tmp.109 -2 L.error?.89.10)
            (mset! tmp.109 6 8)
            tmp.109)))
      (set! unsafe-vector-set!.5
        (begin
          (set! tmp.110 (begin (set! tmp.149 (alloc 16)) (+ tmp.149 2)))
          (begin
            (mset! tmp.110 -2 L.unsafe-vector-set!.5.11)
            (mset! tmp.110 6 24)
            tmp.110)))
      (set! vector-set!.88
        (begin
          (set! tmp.111 (begin (set! tmp.150 (alloc 24)) (+ tmp.150 2)))
          (begin
            (mset! tmp.111 -2 L.vector-set!.88.12)
            (mset! tmp.111 6 24)
            tmp.111)))
      (set! vector-init-loop.35
        (begin
          (set! tmp.112 (begin (set! tmp.151 (alloc 24)) (+ tmp.151 2)))
          (begin
            (mset! tmp.112 -2 L.vector-init-loop.35.13)
            (mset! tmp.112 6 24)
            tmp.112)))
      (set! make-init-vector.4
        (begin
          (set! tmp.113 (begin (set! tmp.152 (alloc 24)) (+ tmp.152 2)))
          (begin
            (mset! tmp.113 -2 L.make-init-vector.4.14)
            (mset! tmp.113 6 8)
            tmp.113)))
      (set! make-vector.87
        (begin
          (set! tmp.114 (begin (set! tmp.153 (alloc 24)) (+ tmp.153 2)))
          (begin
            (mset! tmp.114 -2 L.make-vector.87.15)
            (mset! tmp.114 6 8)
            tmp.114)))
      (set! pair?.86
        (begin
          (set! tmp.115 (begin (set! tmp.154 (alloc 16)) (+ tmp.154 2)))
          (begin
            (mset! tmp.115 -2 L.pair?.86.16)
            (mset! tmp.115 6 8)
            tmp.115)))
      (set! cons.85
        (begin
          (set! tmp.116 (begin (set! tmp.155 (alloc 16)) (+ tmp.155 2)))
          (begin
            (mset! tmp.116 -2 L.cons.85.17)
            (mset! tmp.116 6 16)
            tmp.116)))
      (set! fun/boolean8978.9
        (begin
          (set! tmp.117 (begin (set! tmp.156 (alloc 16)) (+ tmp.156 2)))
          (begin
            (mset! tmp.117 -2 L.fun/boolean8978.9.18)
            (mset! tmp.117 6 8)
            tmp.117)))
      (set! fun/procedure8982.10
        (begin
          (set! tmp.118 (begin (set! tmp.157 (alloc 16)) (+ tmp.157 2)))
          (begin
            (mset! tmp.118 -2 L.fun/procedure8982.10.19)
            (mset! tmp.118 6 0)
            tmp.118)))
      (set! fun/void8979.11
        (begin
          (set! tmp.119 (begin (set! tmp.158 (alloc 24)) (+ tmp.158 2)))
          (begin
            (mset! tmp.119 -2 L.fun/void8979.11.20)
            (mset! tmp.119 6 16)
            tmp.119)))
      (set! fun/void8977.12
        (begin
          (set! tmp.120 (begin (set! tmp.159 (alloc 16)) (+ tmp.159 2)))
          (begin
            (mset! tmp.120 -2 L.fun/void8977.12.21)
            (mset! tmp.120 6 0)
            tmp.120)))
      (set! fun/void8980.13
        (begin
          (set! tmp.121 (begin (set! tmp.160 (alloc 24)) (+ tmp.160 2)))
          (begin
            (mset! tmp.121 -2 L.fun/void8980.13.22)
            (mset! tmp.121 6 0)
            tmp.121)))
      (set! fun/void8981.14
        (begin
          (set! tmp.122 (begin (set! tmp.161 (alloc 16)) (+ tmp.161 2)))
          (begin
            (mset! tmp.122 -2 L.fun/void8981.14.23)
            (mset! tmp.122 6 0)
            tmp.122)))
      (begin
        (mset! vector-set!.88 14 unsafe-vector-set!.5)
        (mset! vector-init-loop.35 14 vector-init-loop.35)
        (mset! make-init-vector.4 14 vector-init-loop.35)
        (mset! make-vector.87 14 make-init-vector.4)
        (mset! fun/void8979.11 14 fun/void8980.13)
        (mset! fun/void8980.13 14 fun/void8981.14)
        (if (begin
              (set! void0.20 (call L.fun/void8977.12.21 fun/void8977.12))
              (set! boolean1.19
                (begin
                  (set! tmp.162
                    (begin
                      (set! tmp.163 (call L.cons.85.17 cons.85 4008 22))
                      (call L.cons.85.17 cons.85 560 tmp.163)))
                  (call L.pair?.86.16 pair?.86 tmp.162)))
              (set! empty2.18 (if (!= 14 6) 22 22))
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
              (set! tmp.165
                (begin
                  (set! fixnum0.23 512)
                  (set! empty1.22 22)
                  (begin
                    (set! tmp.8.24
                      (call L.make-vector.87.15 make-vector.87 64))
                    (begin
                      (set! g43176926.25
                        (call L.vector-set!.88.12 vector-set!.88 tmp.8.24 0 8))
                      (if (begin
                            (set! tmp.166
                              (call L.error?.89.10 error?.89 g43176926.25))
                            (!= tmp.166 6))
                        g43176926.25
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
                            g43176927.26
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
                                g43176928.27
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
                                    g43176929.28
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
                                        g43176930.29
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
                                            g43176931.30
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
                                                g43176932.31
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
                                                    g43176933.32
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
            (set! tmp.80 (begin (set! tmp.86 (alloc 16)) (+ tmp.86 1)))
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
                (set! tmp.88
                  (if (begin (set! tmp.89 (bitwise-and tmp.44 7)) (= tmp.89 0))
                    14
                    6))
                (!= tmp.88 6))
            (if (begin
                  (set! tmp.90
                    (if (begin
                          (set! tmp.91 (bitwise-and tmp.43 7))
                          (= tmp.91 0))
                      14
                      6))
                  (!= tmp.90 6))
              (if (> tmp.43 tmp.44) 14 6)
              1598)
            1598))))
    (begin
      (set! >.73
        (begin
          (set! tmp.81 (begin (set! tmp.92 (alloc 16)) (+ tmp.92 2)))
          (begin (mset! tmp.81 -2 L.>.73.10) (mset! tmp.81 6 16) tmp.81)))
      (set! error?.72
        (begin
          (set! tmp.82 (begin (set! tmp.93 (alloc 16)) (+ tmp.93 2)))
          (begin (mset! tmp.82 -2 L.error?.72.11) (mset! tmp.82 6 8) tmp.82)))
      (set! cons.71
        (begin
          (set! tmp.83 (begin (set! tmp.94 (alloc 16)) (+ tmp.94 2)))
          (begin (mset! tmp.83 -2 L.cons.71.12) (mset! tmp.83 6 16) tmp.83)))
      (set! fun/fixnum8985.7
        (begin
          (set! tmp.84 (begin (set! tmp.95 (alloc 16)) (+ tmp.95 2)))
          (begin
            (mset! tmp.84 -2 L.fun/fixnum8985.7.13)
            (mset! tmp.84 6 8)
            tmp.84)))
      (if (begin
            (set! tmp.96
              (begin
                (set! tmp.97
                  (begin
                    (set! tmp.98
                      (begin
                        (set! tmp.99 (call L.cons.71.12 cons.71 3184 22))
                        (call L.cons.71.12 cons.71 1400 tmp.99)))
                    (call L.fun/fixnum8985.7.13 fun/fixnum8985.7 tmp.98)))
                (begin
                  (set! tmp.100
                    (begin
                      (set! g43180749.9 168)
                      (if (begin
                            (set! tmp.101
                              (call L.error?.72.11 error?.72 g43180749.9))
                            (!= tmp.101 6))
                        g43180749.9
                        (begin
                          (set! g43180750.10 1944)
                          (if (begin
                                (set! tmp.102
                                  (call L.error?.72.11 error?.72 g43180750.10))
                                (!= tmp.102 6))
                            g43180750.10
                            (begin
                              (set! g43180751.11 1968)
                              (if (begin
                                    (set! tmp.103
                                      (call
                                       L.error?.72.11
                                       error?.72
                                       g43180751.11))
                                    (!= tmp.103 6))
                                g43180751.11
                                (begin
                                  (set! g43180752.12 1072)
                                  (if (begin
                                        (set! tmp.104
                                          (call
                                           L.error?.72.11
                                           error?.72
                                           g43180752.12))
                                        (!= tmp.104 6))
                                    g43180752.12
                                    (begin
                                      (set! g43180753.13 1144)
                                      (if (begin
                                            (set! tmp.105
                                              (call
                                               L.error?.72.11
                                               error?.72
                                               g43180753.13))
                                            (!= tmp.105 6))
                                        g43180753.13
                                        (begin
                                          (set! g43180754.14 1288)
                                          (if (begin
                                                (set! tmp.106
                                                  (call
                                                   L.error?.72.11
                                                   error?.72
                                                   g43180754.14))
                                                (!= tmp.106 6))
                                            g43180754.14
                                            296)))))))))))))
                  (call L.>.73.10 >.73 tmp.97 tmp.100))))
            (!= tmp.96 6))
        (begin
          (set! pair0.15
            (begin
              (set! tmp.107 (call L.cons.71.12 cons.71 4072 22))
              (call L.cons.71.12 cons.71 1048 tmp.107)))
          30)
        (begin
          (set! procedure0.18
            (begin
              (set! lam.74
                (begin
                  (set! tmp.85 (begin (set! tmp.108 (alloc 16)) (+ tmp.108 2)))
                  (begin
                    (mset! tmp.85 -2 L.lam.74.14)
                    (mset! tmp.85 6 0)
                    tmp.85)))
              lam.74))
          (set! fixnum1.17 1448)
          (set! pair2.16
            (begin
              (set! tmp.109 (call L.cons.71.12 cons.71 3200 22))
              (call L.cons.71.12 cons.71 304 tmp.109)))
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
                (set! tmp.74
                  (begin
                    (set! tmp.75
                      (begin
                        (set! tmp.76 (call L.cons.64.10 cons.64 2768 22))
                        (call L.cons.64.10 cons.64 1864 tmp.76)))
                    (call L.fun/boolean8989.8.12 fun/boolean8989.8 tmp.75)))
                (!= tmp.74 6))
            (call L.fun/void8990.9.13 fun/void8990.9 592)
            (if (!= 6 6) 30 30)))))
    (define L.cons.64.10
      (lambda (c.65 tmp.59 tmp.60)
        (begin
          (begin
            (set! tmp.69 (begin (set! tmp.77 (alloc 16)) (+ tmp.77 1)))
            (begin (mset! tmp.69 -1 tmp.59) (mset! tmp.69 7 tmp.60) tmp.69)))))
    (begin
      (set! cons.64
        (begin
          (set! tmp.70 (begin (set! tmp.78 (alloc 16)) (+ tmp.78 2)))
          (begin (mset! tmp.70 -2 L.cons.64.10) (mset! tmp.70 6 16) tmp.70)))
      (set! fun/void8988.7
        (begin
          (set! tmp.71 (begin (set! tmp.79 (alloc 40)) (+ tmp.79 2)))
          (begin
            (mset! tmp.71 -2 L.fun/void8988.7.11)
            (mset! tmp.71 6 0)
            tmp.71)))
      (set! fun/boolean8989.8
        (begin
          (set! tmp.72 (begin (set! tmp.80 (alloc 16)) (+ tmp.80 2)))
          (begin
            (mset! tmp.72 -2 L.fun/boolean8989.8.12)
            (mset! tmp.72 6 8)
            tmp.72)))
      (set! fun/void8990.9
        (begin
          (set! tmp.73 (begin (set! tmp.81 (alloc 16)) (+ tmp.81 2)))
          (begin
            (mset! tmp.73 -2 L.fun/void8990.9.13)
            (mset! tmp.73 6 8)
            tmp.73)))
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
      (set! fun/fixnum8993.7
        (begin
          (set! tmp.67 (begin (set! tmp.70 (alloc 24)) (+ tmp.70 2)))
          (begin
            (mset! tmp.67 -2 L.fun/fixnum8993.7.10)
            (mset! tmp.67 6 8)
            tmp.67)))
      (set! fun/fixnum8994.8
        (begin
          (set! tmp.68 (begin (set! tmp.71 (alloc 16)) (+ tmp.71 2)))
          (begin
            (mset! tmp.68 -2 L.fun/fixnum8994.8.11)
            (mset! tmp.68 6 0)
            tmp.68)))
      (begin
        (mset! fun/fixnum8993.7 14 fun/fixnum8994.8)
        (begin
          (set! tmp.72
            (begin
              (begin
                (set! empty0.10 22)
                (begin
                  (set! lam.63
                    (begin
                      (set! tmp.69
                        (begin (set! tmp.73 (alloc 16)) (+ tmp.73 2)))
                      (begin
                        (mset! tmp.69 -2 L.lam.63.12)
                        (mset! tmp.69 6 0)
                        tmp.69)))
                  lam.63))))
          (call L.fun/fixnum8993.7.10 fun/fixnum8993.7 tmp.72))))))
