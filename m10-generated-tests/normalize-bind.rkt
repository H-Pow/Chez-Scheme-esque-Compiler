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
#; (check-by-interp
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
#;(check-by-interp
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
#;(check-by-interp
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
#;(check-by-interp
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
#;(check-by-interp
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
#;(check-by-interp
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
#;(check-by-interp
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