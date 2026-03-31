#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         "../sequentialize-let.rkt")
(define (fail-if-invalid p)
  (when (not (imp-mf-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "imp-mf-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-values-bits-lang-v8 p)
  (interp-imp-mf-lang-v8 (fail-if-invalid (sequentialize-let p)))))

(check-by-interp '(module 1384))
(check-by-interp '(module 1912))
(check-by-interp
 '(module
    (define L.fun/error8447.4.7 (lambda (c.57) (let () 59710)))
    (let ((fun/error8447.4
           (let ((tmp.58 (let ((tmp.59 (alloc 16))) (+ tmp.59 2))))
             (begin
               (mset! tmp.58 -2 L.fun/error8447.4.7)
               (mset! tmp.58 6 0)
               tmp.58))))
      (call L.fun/error8447.4.7 fun/error8447.4))))
(check-by-interp
 '(module
    (define L.fun/fixnum8450.4.7 (lambda (c.57) (let () 288)))
    (let ((fun/fixnum8450.4
           (let ((tmp.58 (let ((tmp.59 (alloc 16))) (+ tmp.59 2))))
             (begin
               (mset! tmp.58 -2 L.fun/fixnum8450.4.7)
               (mset! tmp.58 6 0)
               tmp.58))))
      (call L.fun/fixnum8450.4.7 fun/fixnum8450.4))))
(check-by-interp
 '(module
    (define L.fun/vector8453.4.10
      (lambda (c.61)
        (let ((make-vector.57 (mref c.61 14)))
          (call L.make-vector.57.9 make-vector.57 64))))
    (define L.make-vector.57.9
      (lambda (c.60 tmp.33)
        (let ((make-init-vector.1 (mref c.60 14)))
          (if (let ((tmp.67
                     (if (let ((tmp.68 (bitwise-and tmp.33 7))) (= tmp.68 0))
                       14
                       6)))
                (!= tmp.67 6))
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.33)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.59 tmp.5)
        (let ((vector-init-loop.7 (mref c.59 14)))
          (let ((tmp.6
                 (let ((tmp.62
                        (let ((tmp.69
                               (let ((tmp.70
                                      (let ((tmp.71
                                             (let ((tmp.72
                                                    (arithmetic-shift-right
                                                     tmp.5
                                                     3)))
                                               (+ 1 tmp.72))))
                                        (* tmp.71 8))))
                                 (alloc tmp.70))))
                          (+ tmp.69 3))))
                   (begin (mset! tmp.62 -3 tmp.5) tmp.62))))
            (call L.vector-init-loop.7.7 vector-init-loop.7 tmp.5 0 tmp.6)))))
    (define L.vector-init-loop.7.7
      (lambda (c.58 len.8 i.10 vec.9)
        (let ((vector-init-loop.7 (mref c.58 14)))
          (if (let ((tmp.73 (if (= len.8 i.10) 14 6))) (!= tmp.73 6))
            vec.9
            (begin
              (let ((tmp.74
                     (let ((tmp.75
                            (let ((tmp.76 (arithmetic-shift-right i.10 3)))
                              (* tmp.76 8))))
                       (+ tmp.75 5))))
                (mset! vec.9 tmp.74 0))
              (let ((tmp.77 (+ i.10 8)))
                (call
                 L.vector-init-loop.7.7
                 vector-init-loop.7
                 len.8
                 tmp.77
                 vec.9)))))))
    (let ((vector-init-loop.7
           (let ((tmp.63 (let ((tmp.78 (alloc 24))) (+ tmp.78 2))))
             (begin
               (mset! tmp.63 -2 L.vector-init-loop.7.7)
               (mset! tmp.63 6 24)
               tmp.63)))
          (make-init-vector.1
           (let ((tmp.64 (let ((tmp.79 (alloc 24))) (+ tmp.79 2))))
             (begin
               (mset! tmp.64 -2 L.make-init-vector.1.8)
               (mset! tmp.64 6 8)
               tmp.64)))
          (make-vector.57
           (let ((tmp.65 (let ((tmp.80 (alloc 24))) (+ tmp.80 2))))
             (begin
               (mset! tmp.65 -2 L.make-vector.57.9)
               (mset! tmp.65 6 8)
               tmp.65)))
          (fun/vector8453.4
           (let ((tmp.66 (let ((tmp.81 (alloc 24))) (+ tmp.81 2))))
             (begin
               (mset! tmp.66 -2 L.fun/vector8453.4.10)
               (mset! tmp.66 6 0)
               tmp.66))))
      (begin
        (mset! vector-init-loop.7 14 vector-init-loop.7)
        (mset! make-init-vector.1 14 vector-init-loop.7)
        (mset! make-vector.57 14 make-init-vector.1)
        (mset! fun/vector8453.4 14 make-vector.57)
        (call L.fun/vector8453.4.10 fun/vector8453.4)))))
(check-by-interp
 '(module
    (define L.fun/error8456.4.7 (lambda (c.57) (let () 61502)))
    (let ((fun/error8456.4
           (let ((tmp.58 (let ((tmp.59 (alloc 16))) (+ tmp.59 2))))
             (begin
               (mset! tmp.58 -2 L.fun/error8456.4.7)
               (mset! tmp.58 6 0)
               tmp.58))))
      (call L.fun/error8456.4.7 fun/error8456.4))))
(check-by-interp '(module (if (!= 14 6) 28478 63038)))
(check-by-interp
 '(module
    (define L.fun/error8471.5.11 (lambda (c.66) (let () 55614)))
    (define L.fun/error8470.4.10
      (lambda (c.65 oprand0.6)
        (let ((fun/error8471.5 (mref c.65 14)))
          (call L.fun/error8471.5.11 fun/error8471.5))))
    (define L.make-vector.61.9
      (lambda (c.64 tmp.37)
        (let ((make-init-vector.1 (mref c.64 14)))
          (if (let ((tmp.73
                     (if (let ((tmp.74 (bitwise-and tmp.37 7))) (= tmp.74 0))
                       14
                       6)))
                (!= tmp.73 6))
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.37)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.63 tmp.9)
        (let ((vector-init-loop.11 (mref c.63 14)))
          (let ((tmp.10
                 (let ((tmp.67
                        (let ((tmp.75
                               (let ((tmp.76
                                      (let ((tmp.77
                                             (let ((tmp.78
                                                    (arithmetic-shift-right
                                                     tmp.9
                                                     3)))
                                               (+ 1 tmp.78))))
                                        (* tmp.77 8))))
                                 (alloc tmp.76))))
                          (+ tmp.75 3))))
                   (begin (mset! tmp.67 -3 tmp.9) tmp.67))))
            (call
             L.vector-init-loop.11.7
             vector-init-loop.11
             tmp.9
             0
             tmp.10)))))
    (define L.vector-init-loop.11.7
      (lambda (c.62 len.12 i.14 vec.13)
        (let ((vector-init-loop.11 (mref c.62 14)))
          (if (let ((tmp.79 (if (= len.12 i.14) 14 6))) (!= tmp.79 6))
            vec.13
            (begin
              (let ((tmp.80
                     (let ((tmp.81
                            (let ((tmp.82 (arithmetic-shift-right i.14 3)))
                              (* tmp.82 8))))
                       (+ tmp.81 5))))
                (mset! vec.13 tmp.80 0))
              (let ((tmp.83 (+ i.14 8)))
                (call
                 L.vector-init-loop.11.7
                 vector-init-loop.11
                 len.12
                 tmp.83
                 vec.13)))))))
    (let ((vector-init-loop.11
           (let ((tmp.68 (let ((tmp.84 (alloc 24))) (+ tmp.84 2))))
             (begin
               (mset! tmp.68 -2 L.vector-init-loop.11.7)
               (mset! tmp.68 6 24)
               tmp.68)))
          (make-init-vector.1
           (let ((tmp.69 (let ((tmp.85 (alloc 24))) (+ tmp.85 2))))
             (begin
               (mset! tmp.69 -2 L.make-init-vector.1.8)
               (mset! tmp.69 6 8)
               tmp.69)))
          (make-vector.61
           (let ((tmp.70 (let ((tmp.86 (alloc 24))) (+ tmp.86 2))))
             (begin
               (mset! tmp.70 -2 L.make-vector.61.9)
               (mset! tmp.70 6 8)
               tmp.70)))
          (fun/error8470.4
           (let ((tmp.71 (let ((tmp.87 (alloc 24))) (+ tmp.87 2))))
             (begin
               (mset! tmp.71 -2 L.fun/error8470.4.10)
               (mset! tmp.71 6 8)
               tmp.71)))
          (fun/error8471.5
           (let ((tmp.72 (let ((tmp.88 (alloc 16))) (+ tmp.88 2))))
             (begin
               (mset! tmp.72 -2 L.fun/error8471.5.11)
               (mset! tmp.72 6 0)
               tmp.72))))
      (begin
        (mset! vector-init-loop.11 14 vector-init-loop.11)
        (mset! make-init-vector.1 14 vector-init-loop.11)
        (mset! make-vector.61 14 make-init-vector.1)
        (mset! fun/error8470.4 14 fun/error8471.5)
        (let ((tmp.89
               (let ((fixnum0.8 2000)
                     (vector1.7 (call L.make-vector.61.9 make-vector.61 64)))
                 1088)))
          (call L.fun/error8470.4.10 fun/error8470.4 tmp.89))))))
(check-by-interp
 '(module
    (define L.fun/void8475.5.8 (lambda (c.61 oprand0.7) (let () 30)))
    (define L.fun/ascii-char8474.4.7 (lambda (c.60 oprand0.6) (let () 22062)))
    (let ((fun/ascii-char8474.4
           (let ((tmp.62 (let ((tmp.64 (alloc 16))) (+ tmp.64 2))))
             (begin
               (mset! tmp.62 -2 L.fun/ascii-char8474.4.7)
               (mset! tmp.62 6 8)
               tmp.62)))
          (fun/void8475.5
           (let ((tmp.63 (let ((tmp.65 (alloc 16))) (+ tmp.65 2))))
             (begin
               (mset! tmp.63 -2 L.fun/void8475.5.8)
               (mset! tmp.63 6 8)
               tmp.63))))
      (let ((tmp.66 (call L.fun/void8475.5.8 fun/void8475.5 14)))
        (call L.fun/ascii-char8474.4.7 fun/ascii-char8474.4 tmp.66)))))
(check-by-interp
 '(module
    (define L.fun/empty8478.4.7 (lambda (c.60 oprand0.5) (let () 22)))
    (let ((fun/empty8478.4
           (let ((tmp.61 (let ((tmp.62 (alloc 16))) (+ tmp.62 2))))
             (begin
               (mset! tmp.61 -2 L.fun/empty8478.4.7)
               (mset! tmp.61 6 8)
               tmp.61))))
      (let ((tmp.63 (let ((error0.7 13630) (error1.6 50238)) 22)))
        (call L.fun/empty8478.4.7 fun/empty8478.4 tmp.63)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8481.4.7 (lambda (c.58 oprand0.5) (let () 23598)))
    (let ((fun/ascii-char8481.4
           (let ((tmp.59 (let ((tmp.60 (alloc 16))) (+ tmp.60 2))))
             (begin
               (mset! tmp.59 -2 L.fun/ascii-char8481.4.7)
               (mset! tmp.59 6 8)
               tmp.59))))
      (let ((tmp.61 (if (!= 6 6) 22 22)))
        (call L.fun/ascii-char8481.4.7 fun/ascii-char8481.4 tmp.61)))))
(check-by-interp
 '(module
    (define L.fun/pair8496.5.11
      (lambda (c.70)
        (let ((cons.63 (mref c.70 14))) (call L.cons.63.9 cons.63 264 3424))))
    (define L.fun/pair8495.4.10
      (lambda (c.69 oprand0.7 oprand1.6)
        (let ((fun/pair8496.5 (mref c.69 14)))
          (call L.fun/pair8496.5.11 fun/pair8496.5))))
    (define L.cons.63.9
      (lambda (c.68 tmp.58 tmp.59)
        (let ()
          (let ((tmp.71 (let ((tmp.77 (alloc 16))) (+ tmp.77 1))))
            (begin (mset! tmp.71 -1 tmp.58) (mset! tmp.71 7 tmp.59) tmp.71)))))
    (define L.*.64.8
      (lambda (c.67 tmp.25 tmp.26)
        (let ()
          (if (let ((tmp.78
                     (if (let ((tmp.79 (bitwise-and tmp.26 7))) (= tmp.79 0))
                       14
                       6)))
                (!= tmp.78 6))
            (if (let ((tmp.80
                       (if (let ((tmp.81 (bitwise-and tmp.25 7))) (= tmp.81 0))
                         14
                         6)))
                  (!= tmp.80 6))
              (let ((tmp.82 (arithmetic-shift-right tmp.26 3)))
                (* tmp.25 tmp.82))
              318)
            318))))
    (define L.ascii-char?.65.7
      (lambda (c.66 tmp.52)
        (let ()
          (if (let ((tmp.83 (bitwise-and tmp.52 255))) (= tmp.83 46)) 14 6))))
    (let ((ascii-char?.65
           (let ((tmp.72 (let ((tmp.84 (alloc 16))) (+ tmp.84 2))))
             (begin
               (mset! tmp.72 -2 L.ascii-char?.65.7)
               (mset! tmp.72 6 8)
               tmp.72)))
          (*.64
           (let ((tmp.73 (let ((tmp.85 (alloc 16))) (+ tmp.85 2))))
             (begin (mset! tmp.73 -2 L.*.64.8) (mset! tmp.73 6 16) tmp.73)))
          (cons.63
           (let ((tmp.74 (let ((tmp.86 (alloc 16))) (+ tmp.86 2))))
             (begin (mset! tmp.74 -2 L.cons.63.9) (mset! tmp.74 6 16) tmp.74)))
          (fun/pair8495.4
           (let ((tmp.75 (let ((tmp.87 (alloc 24))) (+ tmp.87 2))))
             (begin
               (mset! tmp.75 -2 L.fun/pair8495.4.10)
               (mset! tmp.75 6 16)
               tmp.75)))
          (fun/pair8496.5
           (let ((tmp.76 (let ((tmp.88 (alloc 24))) (+ tmp.88 2))))
             (begin
               (mset! tmp.76 -2 L.fun/pair8496.5.11)
               (mset! tmp.76 6 0)
               tmp.76))))
      (begin
        (mset! fun/pair8495.4 14 fun/pair8496.5)
        (mset! fun/pair8496.5 14 cons.63)
        (let ((tmp.89
               (let ((tmp.90 (call L.*.64.8 *.64 960 800)))
                 (let ((tmp.91
                        (let ((ascii-char0.10 19758)
                              (boolean1.9 14)
                              (boolean2.8 14))
                          1568)))
                   (call L.*.64.8 *.64 tmp.90 tmp.91)))))
          (let ((tmp.92
                 (let ((tmp.93 (if (!= 14 6) 24110 30)))
                   (call L.ascii-char?.65.7 ascii-char?.65 tmp.93))))
            (call L.fun/pair8495.4.10 fun/pair8495.4 tmp.89 tmp.92)))))))
(check-by-interp
 '(module
    (define L.fun/void8506.9.16
      (lambda (c.84 oprand0.17 oprand1.16)
        (let ((fun/void8507.7 (mref c.84 14)))
          (call L.fun/void8507.7.14 fun/void8507.7))))
    (define L.fun/error8510.8.15
      (lambda (c.83 oprand0.15 oprand1.14) (let () 39230)))
    (define L.fun/void8507.7.14 (lambda (c.82) (let () 30)))
    (define L.fun/empty8511.6.13
      (lambda (c.81 oprand0.13 oprand1.12) (let () 22)))
    (define L.fun/pair8509.5.12
      (lambda (c.80)
        (let ((cons.73 (mref c.80 14))) (call L.cons.73.10 cons.73 840 2752))))
    (define L.fun/pair8508.4.11
      (lambda (c.79 oprand0.11 oprand1.10)
        (let ((fun/pair8509.5 (mref c.79 14)))
          (call L.fun/pair8509.5.12 fun/pair8509.5))))
    (define L.cons.73.10
      (lambda (c.78 tmp.68 tmp.69)
        (let ()
          (let ((tmp.85 (let ((tmp.97 (alloc 16))) (+ tmp.97 1))))
            (begin (mset! tmp.85 -1 tmp.68) (mset! tmp.85 7 tmp.69) tmp.85)))))
    (define L.make-vector.74.9
      (lambda (c.77 tmp.49)
        (let ((make-init-vector.1 (mref c.77 14)))
          (if (let ((tmp.98
                     (if (let ((tmp.99 (bitwise-and tmp.49 7))) (= tmp.99 0))
                       14
                       6)))
                (!= tmp.98 6))
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.49)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.76 tmp.21)
        (let ((vector-init-loop.23 (mref c.76 14)))
          (let ((tmp.22
                 (let ((tmp.86
                        (let ((tmp.100
                               (let ((tmp.101
                                      (let ((tmp.102
                                             (let ((tmp.103
                                                    (arithmetic-shift-right
                                                     tmp.21
                                                     3)))
                                               (+ 1 tmp.103))))
                                        (* tmp.102 8))))
                                 (alloc tmp.101))))
                          (+ tmp.100 3))))
                   (begin (mset! tmp.86 -3 tmp.21) tmp.86))))
            (call
             L.vector-init-loop.23.7
             vector-init-loop.23
             tmp.21
             0
             tmp.22)))))
    (define L.vector-init-loop.23.7
      (lambda (c.75 len.24 i.26 vec.25)
        (let ((vector-init-loop.23 (mref c.75 14)))
          (if (let ((tmp.104 (if (= len.24 i.26) 14 6))) (!= tmp.104 6))
            vec.25
            (begin
              (let ((tmp.105
                     (let ((tmp.106
                            (let ((tmp.107 (arithmetic-shift-right i.26 3)))
                              (* tmp.107 8))))
                       (+ tmp.106 5))))
                (mset! vec.25 tmp.105 0))
              (let ((tmp.108 (+ i.26 8)))
                (call
                 L.vector-init-loop.23.7
                 vector-init-loop.23
                 len.24
                 tmp.108
                 vec.25)))))))
    (let ((vector-init-loop.23
           (let ((tmp.87 (let ((tmp.109 (alloc 24))) (+ tmp.109 2))))
             (begin
               (mset! tmp.87 -2 L.vector-init-loop.23.7)
               (mset! tmp.87 6 24)
               tmp.87)))
          (make-init-vector.1
           (let ((tmp.88 (let ((tmp.110 (alloc 24))) (+ tmp.110 2))))
             (begin
               (mset! tmp.88 -2 L.make-init-vector.1.8)
               (mset! tmp.88 6 8)
               tmp.88)))
          (make-vector.74
           (let ((tmp.89 (let ((tmp.111 (alloc 24))) (+ tmp.111 2))))
             (begin
               (mset! tmp.89 -2 L.make-vector.74.9)
               (mset! tmp.89 6 8)
               tmp.89)))
          (cons.73
           (let ((tmp.90 (let ((tmp.112 (alloc 16))) (+ tmp.112 2))))
             (begin
               (mset! tmp.90 -2 L.cons.73.10)
               (mset! tmp.90 6 16)
               tmp.90)))
          (fun/pair8508.4
           (let ((tmp.91 (let ((tmp.113 (alloc 24))) (+ tmp.113 2))))
             (begin
               (mset! tmp.91 -2 L.fun/pair8508.4.11)
               (mset! tmp.91 6 16)
               tmp.91)))
          (fun/pair8509.5
           (let ((tmp.92 (let ((tmp.114 (alloc 24))) (+ tmp.114 2))))
             (begin
               (mset! tmp.92 -2 L.fun/pair8509.5.12)
               (mset! tmp.92 6 0)
               tmp.92)))
          (fun/empty8511.6
           (let ((tmp.93 (let ((tmp.115 (alloc 16))) (+ tmp.115 2))))
             (begin
               (mset! tmp.93 -2 L.fun/empty8511.6.13)
               (mset! tmp.93 6 16)
               tmp.93)))
          (fun/void8507.7
           (let ((tmp.94 (let ((tmp.116 (alloc 16))) (+ tmp.116 2))))
             (begin
               (mset! tmp.94 -2 L.fun/void8507.7.14)
               (mset! tmp.94 6 0)
               tmp.94)))
          (fun/error8510.8
           (let ((tmp.95 (let ((tmp.117 (alloc 16))) (+ tmp.117 2))))
             (begin
               (mset! tmp.95 -2 L.fun/error8510.8.15)
               (mset! tmp.95 6 16)
               tmp.95)))
          (fun/void8506.9
           (let ((tmp.96 (let ((tmp.118 (alloc 24))) (+ tmp.118 2))))
             (begin
               (mset! tmp.96 -2 L.fun/void8506.9.16)
               (mset! tmp.96 6 16)
               tmp.96))))
      (begin
        (mset! vector-init-loop.23 14 vector-init-loop.23)
        (mset! make-init-vector.1 14 vector-init-loop.23)
        (mset! make-vector.74 14 make-init-vector.1)
        (mset! fun/pair8508.4 14 fun/pair8509.5)
        (mset! fun/pair8509.5 14 cons.73)
        (mset! fun/void8506.9 14 fun/void8507.7)
        (let ((tmp.119
               (let ((ascii-char0.20 27182)
                     (vector1.19 (call L.make-vector.74.9 make-vector.74 64))
                     (boolean2.18 14))
                 37694)))
          (let ((tmp.120
                 (let ((tmp.121
                        (call L.fun/error8510.8.15 fun/error8510.8 30 30)))
                   (let ((tmp.122
                          (call
                           L.fun/empty8511.6.13
                           fun/empty8511.6
                           36414
                           17198)))
                     (call
                      L.fun/pair8508.4.11
                      fun/pair8508.4
                      tmp.121
                      tmp.122)))))
            (call L.fun/void8506.9.16 fun/void8506.9 tmp.119 tmp.120)))))))
(check-by-interp
 '(module
    (define L.fun/vector8536.6.14
      (lambda (c.72)
        (let ((make-vector.62 (mref c.72 14)))
          (call L.make-vector.62.11 make-vector.62 64))))
    (define L.fun/empty8537.5.13 (lambda (c.71) (let () 22)))
    (define L.fun/empty8535.4.12 (lambda (c.70) (let () 22)))
    (define L.make-vector.62.11
      (lambda (c.69 tmp.38)
        (let ((make-init-vector.1 (mref c.69 14)))
          (if (let ((tmp.83
                     (if (let ((tmp.84 (bitwise-and tmp.38 7))) (= tmp.84 0))
                       14
                       6)))
                (!= tmp.83 6))
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.38)
            2110))))
    (define L.make-init-vector.1.10
      (lambda (c.68 tmp.10)
        (let ((vector-init-loop.12 (mref c.68 14)))
          (let ((tmp.11
                 (let ((tmp.73
                        (let ((tmp.85
                               (let ((tmp.86
                                      (let ((tmp.87
                                             (let ((tmp.88
                                                    (arithmetic-shift-right
                                                     tmp.10
                                                     3)))
                                               (+ 1 tmp.88))))
                                        (* tmp.87 8))))
                                 (alloc tmp.86))))
                          (+ tmp.85 3))))
                   (begin (mset! tmp.73 -3 tmp.10) tmp.73))))
            (call
             L.vector-init-loop.12.9
             vector-init-loop.12
             tmp.10
             0
             tmp.11)))))
    (define L.vector-init-loop.12.9
      (lambda (c.67 len.13 i.15 vec.14)
        (let ((vector-init-loop.12 (mref c.67 14)))
          (if (let ((tmp.89 (if (= len.13 i.15) 14 6))) (!= tmp.89 6))
            vec.14
            (begin
              (let ((tmp.90
                     (let ((tmp.91
                            (let ((tmp.92 (arithmetic-shift-right i.15 3)))
                              (* tmp.92 8))))
                       (+ tmp.91 5))))
                (mset! vec.14 tmp.90 0))
              (let ((tmp.93 (+ i.15 8)))
                (call
                 L.vector-init-loop.12.9
                 vector-init-loop.12
                 len.13
                 tmp.93
                 vec.14)))))))
    (define L.cons.63.8
      (lambda (c.66 tmp.57 tmp.58)
        (let ()
          (let ((tmp.74 (let ((tmp.94 (alloc 16))) (+ tmp.94 1))))
            (begin (mset! tmp.74 -1 tmp.57) (mset! tmp.74 7 tmp.58) tmp.74)))))
    (define L.boolean?.64.7
      (lambda (c.65 tmp.48)
        (let ()
          (if (let ((tmp.95 (bitwise-and tmp.48 247))) (= tmp.95 6)) 14 6))))
    (let ((boolean?.64
           (let ((tmp.75 (let ((tmp.96 (alloc 16))) (+ tmp.96 2))))
             (begin
               (mset! tmp.75 -2 L.boolean?.64.7)
               (mset! tmp.75 6 8)
               tmp.75)))
          (cons.63
           (let ((tmp.76 (let ((tmp.97 (alloc 16))) (+ tmp.97 2))))
             (begin (mset! tmp.76 -2 L.cons.63.8) (mset! tmp.76 6 16) tmp.76)))
          (vector-init-loop.12
           (let ((tmp.77 (let ((tmp.98 (alloc 24))) (+ tmp.98 2))))
             (begin
               (mset! tmp.77 -2 L.vector-init-loop.12.9)
               (mset! tmp.77 6 24)
               tmp.77)))
          (make-init-vector.1
           (let ((tmp.78 (let ((tmp.99 (alloc 24))) (+ tmp.99 2))))
             (begin
               (mset! tmp.78 -2 L.make-init-vector.1.10)
               (mset! tmp.78 6 8)
               tmp.78)))
          (make-vector.62
           (let ((tmp.79 (let ((tmp.100 (alloc 24))) (+ tmp.100 2))))
             (begin
               (mset! tmp.79 -2 L.make-vector.62.11)
               (mset! tmp.79 6 8)
               tmp.79)))
          (fun/empty8535.4
           (let ((tmp.80 (let ((tmp.101 (alloc 16))) (+ tmp.101 2))))
             (begin
               (mset! tmp.80 -2 L.fun/empty8535.4.12)
               (mset! tmp.80 6 0)
               tmp.80)))
          (fun/empty8537.5
           (let ((tmp.81 (let ((tmp.102 (alloc 16))) (+ tmp.102 2))))
             (begin
               (mset! tmp.81 -2 L.fun/empty8537.5.13)
               (mset! tmp.81 6 0)
               tmp.81)))
          (fun/vector8536.6
           (let ((tmp.82 (let ((tmp.103 (alloc 24))) (+ tmp.103 2))))
             (begin
               (mset! tmp.82 -2 L.fun/vector8536.6.14)
               (mset! tmp.82 6 0)
               tmp.82))))
      (begin
        (mset! vector-init-loop.12 14 vector-init-loop.12)
        (mset! make-init-vector.1 14 vector-init-loop.12)
        (mset! make-vector.62 14 make-init-vector.1)
        (mset! fun/vector8536.6 14 make-vector.62)
        (let ((empty0.9 (call L.fun/empty8535.4.12 fun/empty8535.4))
              (boolean1.8
               (let ((tmp.104 (call L.cons.63.8 cons.63 640 3312)))
                 (call L.boolean?.64.7 boolean?.64 tmp.104)))
              (vector2.7 (call L.fun/vector8536.6.14 fun/vector8536.6)))
          (call L.fun/empty8537.5.13 fun/empty8537.5))))))
(check-by-interp
 '(module
    (define L.fun/empty8564.8.12
      (lambda (c.73 oprand0.14 oprand1.13) (let () 22)))
    (define L.fun/ascii-char8563.7.11 (lambda (c.72) (let () 29486)))
    (define L.fun/pair8560.6.10
      (lambda (c.71 oprand0.12 oprand1.11)
        (let ((fun/pair8561.4 (mref c.71 14)))
          (call L.fun/pair8561.4.8 fun/pair8561.4))))
    (define L.fun/ascii-char8562.5.9
      (lambda (c.70 oprand0.10 oprand1.9)
        (let ((fun/ascii-char8563.7 (mref c.70 14)))
          (call L.fun/ascii-char8563.7.11 fun/ascii-char8563.7))))
    (define L.fun/pair8561.4.8
      (lambda (c.69)
        (let ((cons.67 (mref c.69 14))) (call L.cons.67.7 cons.67 2008 3192))))
    (define L.cons.67.7
      (lambda (c.68 tmp.62 tmp.63)
        (let ()
          (let ((tmp.74 (let ((tmp.81 (alloc 16))) (+ tmp.81 1))))
            (begin (mset! tmp.74 -1 tmp.62) (mset! tmp.74 7 tmp.63) tmp.74)))))
    (let ((cons.67
           (let ((tmp.75 (let ((tmp.82 (alloc 16))) (+ tmp.82 2))))
             (begin (mset! tmp.75 -2 L.cons.67.7) (mset! tmp.75 6 16) tmp.75)))
          (fun/pair8561.4
           (let ((tmp.76 (let ((tmp.83 (alloc 24))) (+ tmp.83 2))))
             (begin
               (mset! tmp.76 -2 L.fun/pair8561.4.8)
               (mset! tmp.76 6 0)
               tmp.76)))
          (fun/ascii-char8562.5
           (let ((tmp.77 (let ((tmp.84 (alloc 24))) (+ tmp.84 2))))
             (begin
               (mset! tmp.77 -2 L.fun/ascii-char8562.5.9)
               (mset! tmp.77 6 16)
               tmp.77)))
          (fun/pair8560.6
           (let ((tmp.78 (let ((tmp.85 (alloc 24))) (+ tmp.85 2))))
             (begin
               (mset! tmp.78 -2 L.fun/pair8560.6.10)
               (mset! tmp.78 6 16)
               tmp.78)))
          (fun/ascii-char8563.7
           (let ((tmp.79 (let ((tmp.86 (alloc 16))) (+ tmp.86 2))))
             (begin
               (mset! tmp.79 -2 L.fun/ascii-char8563.7.11)
               (mset! tmp.79 6 0)
               tmp.79)))
          (fun/empty8564.8
           (let ((tmp.80 (let ((tmp.87 (alloc 16))) (+ tmp.87 2))))
             (begin
               (mset! tmp.80 -2 L.fun/empty8564.8.12)
               (mset! tmp.80 6 16)
               tmp.80))))
      (begin
        (mset! fun/pair8561.4 14 cons.67)
        (mset! fun/ascii-char8562.5 14 fun/ascii-char8563.7)
        (mset! fun/pair8560.6 14 fun/pair8561.4)
        (let ((tmp.88 (if (!= 6 6) 488 592)))
          (let ((tmp.89
                 (let ((tmp.90
                        (call L.fun/empty8564.8.12 fun/empty8564.8 22 29230)))
                   (let ((tmp.91 (if (!= 14 6) 14 6)))
                     (call
                      L.fun/ascii-char8562.5.9
                      fun/ascii-char8562.5
                      tmp.90
                      tmp.91)))))
            (call L.fun/pair8560.6.10 fun/pair8560.6 tmp.88 tmp.89)))))))
(check-by-interp
 '(module
    (define L.fun/void8611.7.16 (lambda (c.77) (let () 30)))
    (define L.fun/ascii-char8614.6.15 (lambda (c.76) (let () 21294)))
    (define L.fun/vector8612.5.14
      (lambda (c.75)
        (let ((make-vector.64 (mref c.75 14)))
          (call L.make-vector.64.12 make-vector.64 64))))
    (define L.fun/ascii-char8613.4.13 (lambda (c.74) (let () 16942)))
    (define L.make-vector.64.12
      (lambda (c.73 tmp.40)
        (let ((make-init-vector.1 (mref c.73 14)))
          (if (let ((tmp.89
                     (if (let ((tmp.90 (bitwise-and tmp.40 7))) (= tmp.90 0))
                       14
                       6)))
                (!= tmp.89 6))
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.40)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.72 tmp.12)
        (let ((vector-init-loop.14 (mref c.72 14)))
          (let ((tmp.13
                 (let ((tmp.78
                        (let ((tmp.91
                               (let ((tmp.92
                                      (let ((tmp.93
                                             (let ((tmp.94
                                                    (arithmetic-shift-right
                                                     tmp.12
                                                     3)))
                                               (+ 1 tmp.94))))
                                        (* tmp.93 8))))
                                 (alloc tmp.92))))
                          (+ tmp.91 3))))
                   (begin (mset! tmp.78 -3 tmp.12) tmp.78))))
            (call
             L.vector-init-loop.14.10
             vector-init-loop.14
             tmp.12
             0
             tmp.13)))))
    (define L.vector-init-loop.14.10
      (lambda (c.71 len.15 i.17 vec.16)
        (let ((vector-init-loop.14 (mref c.71 14)))
          (if (let ((tmp.95 (if (= len.15 i.17) 14 6))) (!= tmp.95 6))
            vec.16
            (begin
              (let ((tmp.96
                     (let ((tmp.97
                            (let ((tmp.98 (arithmetic-shift-right i.17 3)))
                              (* tmp.98 8))))
                       (+ tmp.97 5))))
                (mset! vec.16 tmp.96 0))
              (let ((tmp.99 (+ i.17 8)))
                (call
                 L.vector-init-loop.14.10
                 vector-init-loop.14
                 len.15
                 tmp.99
                 vec.16)))))))
    (define L.*.65.9
      (lambda (c.70 tmp.26 tmp.27)
        (let ()
          (if (let ((tmp.100
                     (if (let ((tmp.101 (bitwise-and tmp.27 7))) (= tmp.101 0))
                       14
                       6)))
                (!= tmp.100 6))
            (if (let ((tmp.102
                       (if (let ((tmp.103 (bitwise-and tmp.26 7)))
                             (= tmp.103 0))
                         14
                         6)))
                  (!= tmp.102 6))
              (let ((tmp.104 (arithmetic-shift-right tmp.27 3)))
                (* tmp.26 tmp.104))
              318)
            318))))
    (define L.-.66.8
      (lambda (c.69 tmp.30 tmp.31)
        (let ()
          (if (let ((tmp.105
                     (if (let ((tmp.106 (bitwise-and tmp.31 7))) (= tmp.106 0))
                       14
                       6)))
                (!= tmp.105 6))
            (if (let ((tmp.107
                       (if (let ((tmp.108 (bitwise-and tmp.30 7)))
                             (= tmp.108 0))
                         14
                         6)))
                  (!= tmp.107 6))
              (- tmp.30 tmp.31)
              830)
            830))))
    (define L.+.67.7
      (lambda (c.68 tmp.28 tmp.29)
        (let ()
          (if (let ((tmp.109
                     (if (let ((tmp.110 (bitwise-and tmp.29 7))) (= tmp.110 0))
                       14
                       6)))
                (!= tmp.109 6))
            (if (let ((tmp.111
                       (if (let ((tmp.112 (bitwise-and tmp.28 7)))
                             (= tmp.112 0))
                         14
                         6)))
                  (!= tmp.111 6))
              (+ tmp.28 tmp.29)
              574)
            574))))
    (let ((|+.67|
           (let ((tmp.79 (let ((tmp.113 (alloc 16))) (+ tmp.113 2))))
             (begin (mset! tmp.79 -2 L.+.67.7) (mset! tmp.79 6 16) tmp.79)))
          (|-.66|
           (let ((tmp.80 (let ((tmp.114 (alloc 16))) (+ tmp.114 2))))
             (begin (mset! tmp.80 -2 L.-.66.8) (mset! tmp.80 6 16) tmp.80)))
          (*.65
           (let ((tmp.81 (let ((tmp.115 (alloc 16))) (+ tmp.115 2))))
             (begin (mset! tmp.81 -2 L.*.65.9) (mset! tmp.81 6 16) tmp.81)))
          (vector-init-loop.14
           (let ((tmp.82 (let ((tmp.116 (alloc 24))) (+ tmp.116 2))))
             (begin
               (mset! tmp.82 -2 L.vector-init-loop.14.10)
               (mset! tmp.82 6 24)
               tmp.82)))
          (make-init-vector.1
           (let ((tmp.83 (let ((tmp.117 (alloc 24))) (+ tmp.117 2))))
             (begin
               (mset! tmp.83 -2 L.make-init-vector.1.11)
               (mset! tmp.83 6 8)
               tmp.83)))
          (make-vector.64
           (let ((tmp.84 (let ((tmp.118 (alloc 24))) (+ tmp.118 2))))
             (begin
               (mset! tmp.84 -2 L.make-vector.64.12)
               (mset! tmp.84 6 8)
               tmp.84)))
          (fun/ascii-char8613.4
           (let ((tmp.85 (let ((tmp.119 (alloc 16))) (+ tmp.119 2))))
             (begin
               (mset! tmp.85 -2 L.fun/ascii-char8613.4.13)
               (mset! tmp.85 6 0)
               tmp.85)))
          (fun/vector8612.5
           (let ((tmp.86 (let ((tmp.120 (alloc 24))) (+ tmp.120 2))))
             (begin
               (mset! tmp.86 -2 L.fun/vector8612.5.14)
               (mset! tmp.86 6 0)
               tmp.86)))
          (fun/ascii-char8614.6
           (let ((tmp.87 (let ((tmp.121 (alloc 16))) (+ tmp.121 2))))
             (begin
               (mset! tmp.87 -2 L.fun/ascii-char8614.6.15)
               (mset! tmp.87 6 0)
               tmp.87)))
          (fun/void8611.7
           (let ((tmp.88 (let ((tmp.122 (alloc 16))) (+ tmp.122 2))))
             (begin
               (mset! tmp.88 -2 L.fun/void8611.7.16)
               (mset! tmp.88 6 0)
               tmp.88))))
      (begin
        (mset! vector-init-loop.14 14 vector-init-loop.14)
        (mset! make-init-vector.1 14 vector-init-loop.14)
        (mset! make-vector.64 14 make-init-vector.1)
        (mset! fun/vector8612.5 14 make-vector.64)
        (let ((fixnum0.11
               (let ((tmp.123 (call L.*.65.9 *.65 616 1608)))
                 (let ((tmp.124 (call L.-.66.8 |-.66| 424 320)))
                   (call L.+.67.7 |+.67| tmp.123 tmp.124))))
              (void1.10 (call L.fun/void8611.7.16 fun/void8611.7))
              (vector2.9 (call L.fun/vector8612.5.14 fun/vector8612.5))
              (ascii-char3.8
               (call L.fun/ascii-char8613.4.13 fun/ascii-char8613.4)))
          (call L.fun/ascii-char8614.6.15 fun/ascii-char8614.6))))))
(check-by-interp
 '(module
    (define L.fun/void8618.6.15 (lambda (c.75) (let () 30)))
    (define L.fun/vector8619.5.14
      (lambda (c.74)
        (let ((make-vector.63 (mref c.74 14)))
          (call L.make-vector.63.12 make-vector.63 64))))
    (define L.fun/ascii-char8617.4.13 (lambda (c.73) (let () 22574)))
    (define L.make-vector.63.12
      (lambda (c.72 tmp.39)
        (let ((make-init-vector.1 (mref c.72 14)))
          (if (let ((tmp.86
                     (if (let ((tmp.87 (bitwise-and tmp.39 7))) (= tmp.87 0))
                       14
                       6)))
                (!= tmp.86 6))
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.39)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.71 tmp.11)
        (let ((vector-init-loop.13 (mref c.71 14)))
          (let ((tmp.12
                 (let ((tmp.76
                        (let ((tmp.88
                               (let ((tmp.89
                                      (let ((tmp.90
                                             (let ((tmp.91
                                                    (arithmetic-shift-right
                                                     tmp.11
                                                     3)))
                                               (+ 1 tmp.91))))
                                        (* tmp.90 8))))
                                 (alloc tmp.89))))
                          (+ tmp.88 3))))
                   (begin (mset! tmp.76 -3 tmp.11) tmp.76))))
            (call
             L.vector-init-loop.13.10
             vector-init-loop.13
             tmp.11
             0
             tmp.12)))))
    (define L.vector-init-loop.13.10
      (lambda (c.70 len.14 i.16 vec.15)
        (let ((vector-init-loop.13 (mref c.70 14)))
          (if (let ((tmp.92 (if (= len.14 i.16) 14 6))) (!= tmp.92 6))
            vec.15
            (begin
              (let ((tmp.93
                     (let ((tmp.94
                            (let ((tmp.95 (arithmetic-shift-right i.16 3)))
                              (* tmp.95 8))))
                       (+ tmp.94 5))))
                (mset! vec.15 tmp.93 0))
              (let ((tmp.96 (+ i.16 8)))
                (call
                 L.vector-init-loop.13.10
                 vector-init-loop.13
                 len.14
                 tmp.96
                 vec.15)))))))
    (define L.+.64.9
      (lambda (c.69 tmp.27 tmp.28)
        (let ()
          (if (let ((tmp.97
                     (if (let ((tmp.98 (bitwise-and tmp.28 7))) (= tmp.98 0))
                       14
                       6)))
                (!= tmp.97 6))
            (if (let ((tmp.99
                       (if (let ((tmp.100 (bitwise-and tmp.27 7)))
                             (= tmp.100 0))
                         14
                         6)))
                  (!= tmp.99 6))
              (+ tmp.27 tmp.28)
              574)
            574))))
    (define L.*.65.8
      (lambda (c.68 tmp.25 tmp.26)
        (let ()
          (if (let ((tmp.101
                     (if (let ((tmp.102 (bitwise-and tmp.26 7))) (= tmp.102 0))
                       14
                       6)))
                (!= tmp.101 6))
            (if (let ((tmp.103
                       (if (let ((tmp.104 (bitwise-and tmp.25 7)))
                             (= tmp.104 0))
                         14
                         6)))
                  (!= tmp.103 6))
              (let ((tmp.105 (arithmetic-shift-right tmp.26 3)))
                (* tmp.25 tmp.105))
              318)
            318))))
    (define L.-.66.7
      (lambda (c.67 tmp.29 tmp.30)
        (let ()
          (if (let ((tmp.106
                     (if (let ((tmp.107 (bitwise-and tmp.30 7))) (= tmp.107 0))
                       14
                       6)))
                (!= tmp.106 6))
            (if (let ((tmp.108
                       (if (let ((tmp.109 (bitwise-and tmp.29 7)))
                             (= tmp.109 0))
                         14
                         6)))
                  (!= tmp.108 6))
              (- tmp.29 tmp.30)
              830)
            830))))
    (let ((|-.66|
           (let ((tmp.77 (let ((tmp.110 (alloc 16))) (+ tmp.110 2))))
             (begin (mset! tmp.77 -2 L.-.66.7) (mset! tmp.77 6 16) tmp.77)))
          (*.65
           (let ((tmp.78 (let ((tmp.111 (alloc 16))) (+ tmp.111 2))))
             (begin (mset! tmp.78 -2 L.*.65.8) (mset! tmp.78 6 16) tmp.78)))
          (|+.64|
           (let ((tmp.79 (let ((tmp.112 (alloc 16))) (+ tmp.112 2))))
             (begin (mset! tmp.79 -2 L.+.64.9) (mset! tmp.79 6 16) tmp.79)))
          (vector-init-loop.13
           (let ((tmp.80 (let ((tmp.113 (alloc 24))) (+ tmp.113 2))))
             (begin
               (mset! tmp.80 -2 L.vector-init-loop.13.10)
               (mset! tmp.80 6 24)
               tmp.80)))
          (make-init-vector.1
           (let ((tmp.81 (let ((tmp.114 (alloc 24))) (+ tmp.114 2))))
             (begin
               (mset! tmp.81 -2 L.make-init-vector.1.11)
               (mset! tmp.81 6 8)
               tmp.81)))
          (make-vector.63
           (let ((tmp.82 (let ((tmp.115 (alloc 24))) (+ tmp.115 2))))
             (begin
               (mset! tmp.82 -2 L.make-vector.63.12)
               (mset! tmp.82 6 8)
               tmp.82)))
          (fun/ascii-char8617.4
           (let ((tmp.83 (let ((tmp.116 (alloc 16))) (+ tmp.116 2))))
             (begin
               (mset! tmp.83 -2 L.fun/ascii-char8617.4.13)
               (mset! tmp.83 6 0)
               tmp.83)))
          (fun/vector8619.5
           (let ((tmp.84 (let ((tmp.117 (alloc 24))) (+ tmp.117 2))))
             (begin
               (mset! tmp.84 -2 L.fun/vector8619.5.14)
               (mset! tmp.84 6 0)
               tmp.84)))
          (fun/void8618.6
           (let ((tmp.85 (let ((tmp.118 (alloc 16))) (+ tmp.118 2))))
             (begin
               (mset! tmp.85 -2 L.fun/void8618.6.15)
               (mset! tmp.85 6 0)
               tmp.85))))
      (begin
        (mset! vector-init-loop.13 14 vector-init-loop.13)
        (mset! make-init-vector.1 14 vector-init-loop.13)
        (mset! make-vector.63 14 make-init-vector.1)
        (mset! fun/vector8619.5 14 make-vector.63)
        (let ((fixnum0.10
               (let ((tmp.119 (call L.+.64.9 |+.64| 1424 976)))
                 (let ((tmp.120 (call L.+.64.9 |+.64| 456 696)))
                   (call L.*.65.8 *.65 tmp.119 tmp.120))))
              (ascii-char1.9
               (call L.fun/ascii-char8617.4.13 fun/ascii-char8617.4))
              (fixnum2.8
               (let ((tmp.121 (call L.-.66.7 |-.66| 216 16)))
                 (let ((tmp.122 (call L.*.65.8 *.65 256 1256)))
                   (call L.+.64.9 |+.64| tmp.121 tmp.122))))
              (void3.7 (call L.fun/void8618.6.15 fun/void8618.6)))
          (call L.fun/vector8619.5.14 fun/vector8619.5))))))
(check-by-interp
 '(module
    (define L.lam.68.17
      (lambda (c.79)
        (let ((fun/any8773.7 (mref c.79 14)) (vector?.67 (mref c.79 22)))
          (let ((tmp.92 (call L.fun/any8773.7.15 fun/any8773.7)))
            (call L.vector?.67.7 vector?.67 tmp.92)))))
    (define L.fun/vector8772.8.16
      (lambda (c.78)
        (let ((make-vector.65 (mref c.78 14)))
          (call L.make-vector.65.11 make-vector.65 64))))
    (define L.fun/any8773.7.15 (lambda (c.77) (let () 22)))
    (define L.fun/void8770.6.14 (lambda (c.76) (let () 30)))
    (define L.fun/empty8774.5.13 (lambda (c.75) (let () 22)))
    (define L.fun/any8771.4.12
      (lambda (c.74)
        (let ((make-vector.65 (mref c.74 14)))
          (call L.make-vector.65.11 make-vector.65 64))))
    (define L.make-vector.65.11
      (lambda (c.73 tmp.41)
        (let ((make-init-vector.1 (mref c.73 14)))
          (if (let ((tmp.93
                     (if (let ((tmp.94 (bitwise-and tmp.41 7))) (= tmp.94 0))
                       14
                       6)))
                (!= tmp.93 6))
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.41)
            2110))))
    (define L.make-init-vector.1.10
      (lambda (c.72 tmp.13)
        (let ((vector-init-loop.15 (mref c.72 14)))
          (let ((tmp.14
                 (let ((tmp.80
                        (let ((tmp.95
                               (let ((tmp.96
                                      (let ((tmp.97
                                             (let ((tmp.98
                                                    (arithmetic-shift-right
                                                     tmp.13
                                                     3)))
                                               (+ 1 tmp.98))))
                                        (* tmp.97 8))))
                                 (alloc tmp.96))))
                          (+ tmp.95 3))))
                   (begin (mset! tmp.80 -3 tmp.13) tmp.80))))
            (call
             L.vector-init-loop.15.9
             vector-init-loop.15
             tmp.13
             0
             tmp.14)))))
    (define L.vector-init-loop.15.9
      (lambda (c.71 len.16 i.18 vec.17)
        (let ((vector-init-loop.15 (mref c.71 14)))
          (if (let ((tmp.99 (if (= len.16 i.18) 14 6))) (!= tmp.99 6))
            vec.17
            (begin
              (let ((tmp.100
                     (let ((tmp.101
                            (let ((tmp.102 (arithmetic-shift-right i.18 3)))
                              (* tmp.102 8))))
                       (+ tmp.101 5))))
                (mset! vec.17 tmp.100 0))
              (let ((tmp.103 (+ i.18 8)))
                (call
                 L.vector-init-loop.15.9
                 vector-init-loop.15
                 len.16
                 tmp.103
                 vec.17)))))))
    (define L.error?.66.8
      (lambda (c.70 tmp.55)
        (let ()
          (if (let ((tmp.104 (bitwise-and tmp.55 255))) (= tmp.104 62))
            14
            6))))
    (define L.vector?.67.7
      (lambda (c.69 tmp.57)
        (let ()
          (if (let ((tmp.105 (bitwise-and tmp.57 7))) (= tmp.105 3)) 14 6))))
    (let ((vector?.67
           (let ((tmp.81 (let ((tmp.106 (alloc 16))) (+ tmp.106 2))))
             (begin
               (mset! tmp.81 -2 L.vector?.67.7)
               (mset! tmp.81 6 8)
               tmp.81)))
          (error?.66
           (let ((tmp.82 (let ((tmp.107 (alloc 16))) (+ tmp.107 2))))
             (begin
               (mset! tmp.82 -2 L.error?.66.8)
               (mset! tmp.82 6 8)
               tmp.82)))
          (vector-init-loop.15
           (let ((tmp.83 (let ((tmp.108 (alloc 24))) (+ tmp.108 2))))
             (begin
               (mset! tmp.83 -2 L.vector-init-loop.15.9)
               (mset! tmp.83 6 24)
               tmp.83)))
          (make-init-vector.1
           (let ((tmp.84 (let ((tmp.109 (alloc 24))) (+ tmp.109 2))))
             (begin
               (mset! tmp.84 -2 L.make-init-vector.1.10)
               (mset! tmp.84 6 8)
               tmp.84)))
          (make-vector.65
           (let ((tmp.85 (let ((tmp.110 (alloc 24))) (+ tmp.110 2))))
             (begin
               (mset! tmp.85 -2 L.make-vector.65.11)
               (mset! tmp.85 6 8)
               tmp.85)))
          (fun/any8771.4
           (let ((tmp.86 (let ((tmp.111 (alloc 24))) (+ tmp.111 2))))
             (begin
               (mset! tmp.86 -2 L.fun/any8771.4.12)
               (mset! tmp.86 6 0)
               tmp.86)))
          (fun/empty8774.5
           (let ((tmp.87 (let ((tmp.112 (alloc 16))) (+ tmp.112 2))))
             (begin
               (mset! tmp.87 -2 L.fun/empty8774.5.13)
               (mset! tmp.87 6 0)
               tmp.87)))
          (fun/void8770.6
           (let ((tmp.88 (let ((tmp.113 (alloc 16))) (+ tmp.113 2))))
             (begin
               (mset! tmp.88 -2 L.fun/void8770.6.14)
               (mset! tmp.88 6 0)
               tmp.88)))
          (fun/any8773.7
           (let ((tmp.89 (let ((tmp.114 (alloc 16))) (+ tmp.114 2))))
             (begin
               (mset! tmp.89 -2 L.fun/any8773.7.15)
               (mset! tmp.89 6 0)
               tmp.89)))
          (fun/vector8772.8
           (let ((tmp.90 (let ((tmp.115 (alloc 24))) (+ tmp.115 2))))
             (begin
               (mset! tmp.90 -2 L.fun/vector8772.8.16)
               (mset! tmp.90 6 0)
               tmp.90))))
      (begin
        (mset! vector-init-loop.15 14 vector-init-loop.15)
        (mset! make-init-vector.1 14 vector-init-loop.15)
        (mset! make-vector.65 14 make-init-vector.1)
        (mset! fun/any8771.4 14 make-vector.65)
        (mset! fun/vector8772.8 14 make-vector.65)
        (let ((void0.12 (call L.fun/void8770.6.14 fun/void8770.6))
              (boolean1.11
               (let ((tmp.116 (call L.fun/any8771.4.12 fun/any8771.4)))
                 (call L.error?.66.8 error?.66 tmp.116)))
              (vector2.10 (call L.fun/vector8772.8.16 fun/vector8772.8))
              (procedure3.9
               (let ((lam.68
                      (let ((tmp.91
                             (let ((tmp.117 (alloc 32))) (+ tmp.117 2))))
                        (begin
                          (mset! tmp.91 -2 L.lam.68.17)
                          (mset! tmp.91 6 0)
                          tmp.91))))
                 (begin
                   (mset! lam.68 14 fun/any8773.7)
                   (mset! lam.68 22 vector?.67)
                   lam.68))))
          (call L.fun/empty8774.5.13 fun/empty8774.5))))))
(check-by-interp
 '(module
    (define L.lam.77.25
      (lambda (c.96)
        (let ((fun/vector9404.8 (mref c.96 14)))
          (call L.fun/vector9404.8.18 fun/vector9404.8))))
    (define L.lam.76.24
      (lambda (c.95)
        (let ((fun/pair9400.7 (mref c.95 14)))
          (call L.fun/pair9400.7.17 fun/pair9400.7))))
    (define L.fun/ascii-char9402.13.23
      (lambda (c.94)
        (let ((fun/ascii-char9403.6 (mref c.94 14)))
          (call L.fun/ascii-char9403.6.16 fun/ascii-char9403.6))))
    (define L.fun/pair9401.12.22
      (lambda (c.93)
        (let ((cons.72 (mref c.93 14)))
          (call L.cons.72.10 cons.72 1936 3016))))
    (define L.fun/vector9405.11.21
      (lambda (c.92)
        (let ((make-vector.71 (mref c.92 14)))
          (call L.make-vector.71.13 make-vector.71 64))))
    (define L.fun/empty9406.10.20
      (lambda (c.91)
        (let ((fun/empty9407.5 (mref c.91 14)))
          (call L.fun/empty9407.5.15 fun/empty9407.5))))
    (define L.fun/void9399.9.19 (lambda (c.90) (let () 30)))
    (define L.fun/vector9404.8.18
      (lambda (c.89)
        (let ((fun/vector9405.11 (mref c.89 14)))
          (call L.fun/vector9405.11.21 fun/vector9405.11))))
    (define L.fun/pair9400.7.17
      (lambda (c.88)
        (let ((fun/pair9401.12 (mref c.88 14)))
          (call L.fun/pair9401.12.22 fun/pair9401.12))))
    (define L.fun/ascii-char9403.6.16 (lambda (c.87) (let () 25646)))
    (define L.fun/empty9407.5.15 (lambda (c.86) (let () 22)))
    (define L.fun/void9398.4.14
      (lambda (c.85)
        (let ((fun/void9399.9 (mref c.85 14)))
          (call L.fun/void9399.9.19 fun/void9399.9))))
    (define L.make-vector.71.13
      (lambda (c.84 tmp.47)
        (let ((make-init-vector.1 (mref c.84 14)))
          (if (let ((tmp.118
                     (if (let ((tmp.119 (bitwise-and tmp.47 7))) (= tmp.119 0))
                       14
                       6)))
                (!= tmp.118 6))
            (call L.make-init-vector.1.12 make-init-vector.1 tmp.47)
            2110))))
    (define L.make-init-vector.1.12
      (lambda (c.83 tmp.19)
        (let ((vector-init-loop.21 (mref c.83 14)))
          (let ((tmp.20
                 (let ((tmp.97
                        (let ((tmp.120
                               (let ((tmp.121
                                      (let ((tmp.122
                                             (let ((tmp.123
                                                    (arithmetic-shift-right
                                                     tmp.19
                                                     3)))
                                               (+ 1 tmp.123))))
                                        (* tmp.122 8))))
                                 (alloc tmp.121))))
                          (+ tmp.120 3))))
                   (begin (mset! tmp.97 -3 tmp.19) tmp.97))))
            (call
             L.vector-init-loop.21.11
             vector-init-loop.21
             tmp.19
             0
             tmp.20)))))
    (define L.vector-init-loop.21.11
      (lambda (c.82 len.22 i.24 vec.23)
        (let ((vector-init-loop.21 (mref c.82 14)))
          (if (let ((tmp.124 (if (= len.22 i.24) 14 6))) (!= tmp.124 6))
            vec.23
            (begin
              (let ((tmp.125
                     (let ((tmp.126
                            (let ((tmp.127 (arithmetic-shift-right i.24 3)))
                              (* tmp.127 8))))
                       (+ tmp.126 5))))
                (mset! vec.23 tmp.125 0))
              (let ((tmp.128 (+ i.24 8)))
                (call
                 L.vector-init-loop.21.11
                 vector-init-loop.21
                 len.22
                 tmp.128
                 vec.23)))))))
    (define L.cons.72.10
      (lambda (c.81 tmp.66 tmp.67)
        (let ()
          (let ((tmp.98 (let ((tmp.129 (alloc 16))) (+ tmp.129 1))))
            (begin (mset! tmp.98 -1 tmp.66) (mset! tmp.98 7 tmp.67) tmp.98)))))
    (define L.*.73.9
      (lambda (c.80 tmp.33 tmp.34)
        (let ()
          (if (let ((tmp.130
                     (if (let ((tmp.131 (bitwise-and tmp.34 7))) (= tmp.131 0))
                       14
                       6)))
                (!= tmp.130 6))
            (if (let ((tmp.132
                       (if (let ((tmp.133 (bitwise-and tmp.33 7)))
                             (= tmp.133 0))
                         14
                         6)))
                  (!= tmp.132 6))
              (let ((tmp.134 (arithmetic-shift-right tmp.34 3)))
                (* tmp.33 tmp.134))
              318)
            318))))
    (define L.-.74.8
      (lambda (c.79 tmp.37 tmp.38)
        (let ()
          (if (let ((tmp.135
                     (if (let ((tmp.136 (bitwise-and tmp.38 7))) (= tmp.136 0))
                       14
                       6)))
                (!= tmp.135 6))
            (if (let ((tmp.137
                       (if (let ((tmp.138 (bitwise-and tmp.37 7)))
                             (= tmp.138 0))
                         14
                         6)))
                  (!= tmp.137 6))
              (- tmp.37 tmp.38)
              830)
            830))))
    (define L.+.75.7
      (lambda (c.78 tmp.35 tmp.36)
        (let ()
          (if (let ((tmp.139
                     (if (let ((tmp.140 (bitwise-and tmp.36 7))) (= tmp.140 0))
                       14
                       6)))
                (!= tmp.139 6))
            (if (let ((tmp.141
                       (if (let ((tmp.142 (bitwise-and tmp.35 7)))
                             (= tmp.142 0))
                         14
                         6)))
                  (!= tmp.141 6))
              (+ tmp.35 tmp.36)
              574)
            574))))
    (let ((|+.75|
           (let ((tmp.99 (let ((tmp.143 (alloc 16))) (+ tmp.143 2))))
             (begin (mset! tmp.99 -2 L.+.75.7) (mset! tmp.99 6 16) tmp.99)))
          (|-.74|
           (let ((tmp.100 (let ((tmp.144 (alloc 16))) (+ tmp.144 2))))
             (begin (mset! tmp.100 -2 L.-.74.8) (mset! tmp.100 6 16) tmp.100)))
          (*.73
           (let ((tmp.101 (let ((tmp.145 (alloc 16))) (+ tmp.145 2))))
             (begin (mset! tmp.101 -2 L.*.73.9) (mset! tmp.101 6 16) tmp.101)))
          (cons.72
           (let ((tmp.102 (let ((tmp.146 (alloc 16))) (+ tmp.146 2))))
             (begin
               (mset! tmp.102 -2 L.cons.72.10)
               (mset! tmp.102 6 16)
               tmp.102)))
          (vector-init-loop.21
           (let ((tmp.103 (let ((tmp.147 (alloc 24))) (+ tmp.147 2))))
             (begin
               (mset! tmp.103 -2 L.vector-init-loop.21.11)
               (mset! tmp.103 6 24)
               tmp.103)))
          (make-init-vector.1
           (let ((tmp.104 (let ((tmp.148 (alloc 24))) (+ tmp.148 2))))
             (begin
               (mset! tmp.104 -2 L.make-init-vector.1.12)
               (mset! tmp.104 6 8)
               tmp.104)))
          (make-vector.71
           (let ((tmp.105 (let ((tmp.149 (alloc 24))) (+ tmp.149 2))))
             (begin
               (mset! tmp.105 -2 L.make-vector.71.13)
               (mset! tmp.105 6 8)
               tmp.105)))
          (fun/void9398.4
           (let ((tmp.106 (let ((tmp.150 (alloc 24))) (+ tmp.150 2))))
             (begin
               (mset! tmp.106 -2 L.fun/void9398.4.14)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/empty9407.5
           (let ((tmp.107 (let ((tmp.151 (alloc 16))) (+ tmp.151 2))))
             (begin
               (mset! tmp.107 -2 L.fun/empty9407.5.15)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/ascii-char9403.6
           (let ((tmp.108 (let ((tmp.152 (alloc 16))) (+ tmp.152 2))))
             (begin
               (mset! tmp.108 -2 L.fun/ascii-char9403.6.16)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/pair9400.7
           (let ((tmp.109 (let ((tmp.153 (alloc 24))) (+ tmp.153 2))))
             (begin
               (mset! tmp.109 -2 L.fun/pair9400.7.17)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/vector9404.8
           (let ((tmp.110 (let ((tmp.154 (alloc 24))) (+ tmp.154 2))))
             (begin
               (mset! tmp.110 -2 L.fun/vector9404.8.18)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/void9399.9
           (let ((tmp.111 (let ((tmp.155 (alloc 16))) (+ tmp.155 2))))
             (begin
               (mset! tmp.111 -2 L.fun/void9399.9.19)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/empty9406.10
           (let ((tmp.112 (let ((tmp.156 (alloc 24))) (+ tmp.156 2))))
             (begin
               (mset! tmp.112 -2 L.fun/empty9406.10.20)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/vector9405.11
           (let ((tmp.113 (let ((tmp.157 (alloc 24))) (+ tmp.157 2))))
             (begin
               (mset! tmp.113 -2 L.fun/vector9405.11.21)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/pair9401.12
           (let ((tmp.114 (let ((tmp.158 (alloc 24))) (+ tmp.158 2))))
             (begin
               (mset! tmp.114 -2 L.fun/pair9401.12.22)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/ascii-char9402.13
           (let ((tmp.115 (let ((tmp.159 (alloc 24))) (+ tmp.159 2))))
             (begin
               (mset! tmp.115 -2 L.fun/ascii-char9402.13.23)
               (mset! tmp.115 6 0)
               tmp.115))))
      (begin
        (mset! vector-init-loop.21 14 vector-init-loop.21)
        (mset! make-init-vector.1 14 vector-init-loop.21)
        (mset! make-vector.71 14 make-init-vector.1)
        (mset! fun/void9398.4 14 fun/void9399.9)
        (mset! fun/pair9400.7 14 fun/pair9401.12)
        (mset! fun/vector9404.8 14 fun/vector9405.11)
        (mset! fun/empty9406.10 14 fun/empty9407.5)
        (mset! fun/vector9405.11 14 make-vector.71)
        (mset! fun/pair9401.12 14 cons.72)
        (mset! fun/ascii-char9402.13 14 fun/ascii-char9403.6)
        (let ((void0.18 (call L.fun/void9398.4.14 fun/void9398.4))
              (fixnum1.17
               (let ((tmp.160
                      (let ((tmp.161 (call L.*.73.9 *.73 1960 752)))
                        (let ((tmp.162 (call L.-.74.8 |-.74| 752 1608)))
                          (call L.*.73.9 *.73 tmp.161 tmp.162)))))
                 (let ((tmp.163
                        (let ((tmp.164 (call L.-.74.8 |-.74| 1800 128)))
                          (let ((tmp.165 (call L.+.75.7 |+.75| 368 1392)))
                            (call L.+.75.7 |+.75| tmp.164 tmp.165)))))
                   (call L.-.74.8 |-.74| tmp.160 tmp.163))))
              (procedure2.16
               (let ((lam.76
                      (let ((tmp.116
                             (let ((tmp.166 (alloc 24))) (+ tmp.166 2))))
                        (begin
                          (mset! tmp.116 -2 L.lam.76.24)
                          (mset! tmp.116 6 0)
                          tmp.116))))
                 (begin (mset! lam.76 14 fun/pair9400.7) lam.76)))
              (ascii-char3.15
               (call L.fun/ascii-char9402.13.23 fun/ascii-char9402.13))
              (procedure4.14
               (let ((lam.77
                      (let ((tmp.117
                             (let ((tmp.167 (alloc 24))) (+ tmp.167 2))))
                        (begin
                          (mset! tmp.117 -2 L.lam.77.25)
                          (mset! tmp.117 6 0)
                          tmp.117))))
                 (begin (mset! lam.77 14 fun/vector9404.8) lam.77))))
          (call L.fun/empty9406.10.20 fun/empty9406.10))))))
(check-by-interp
 '(module
    (define L.fun/pair13318.15.22
      (lambda (c.93)
        (let ((fun/pair13319.9 (mref c.93 14)))
          (call L.fun/pair13319.9.16 fun/pair13319.9))))
    (define L.fun/void13311.14.21 (lambda (c.92) (let () 30)))
    (define L.fun/ascii-char13314.13.20
      (lambda (c.91)
        (let ((fun/ascii-char13315.5 (mref c.91 14)))
          (call L.fun/ascii-char13315.5.12 fun/ascii-char13315.5))))
    (define L.fun/error13309.12.19 (lambda (c.90) (let () 63550)))
    (define L.fun/empty13317.11.18 (lambda (c.89) (let () 22)))
    (define L.fun/void13310.10.17
      (lambda (c.88)
        (let ((fun/void13311.14 (mref c.88 14)))
          (call L.fun/void13311.14.21 fun/void13311.14))))
    (define L.fun/pair13319.9.16
      (lambda (c.87)
        (let ((cons.74 (mref c.87 14)))
          (call L.cons.74.10 cons.74 1944 3512))))
    (define L.fun/error13312.8.15
      (lambda (c.86)
        (let ((fun/error13313.6 (mref c.86 14)))
          (call L.fun/error13313.6.13 fun/error13313.6))))
    (define L.fun/error13308.7.14
      (lambda (c.85)
        (let ((fun/error13309.12 (mref c.85 14)))
          (call L.fun/error13309.12.19 fun/error13309.12))))
    (define L.fun/error13313.6.13 (lambda (c.84) (let () 15678)))
    (define L.fun/ascii-char13315.5.12 (lambda (c.83) (let () 25646)))
    (define L.fun/empty13316.4.11
      (lambda (c.82)
        (let ((fun/empty13317.11 (mref c.82 14)))
          (call L.fun/empty13317.11.18 fun/empty13317.11))))
    (define L.cons.74.10
      (lambda (c.81 tmp.69 tmp.70)
        (let ()
          (let ((tmp.94 (let ((tmp.111 (alloc 16))) (+ tmp.111 1))))
            (begin (mset! tmp.94 -1 tmp.69) (mset! tmp.94 7 tmp.70) tmp.94)))))
    (define L.+.75.9
      (lambda (c.80 tmp.38 tmp.39)
        (let ()
          (if (let ((tmp.112
                     (if (let ((tmp.113 (bitwise-and tmp.39 7))) (= tmp.113 0))
                       14
                       6)))
                (!= tmp.112 6))
            (if (let ((tmp.114
                       (if (let ((tmp.115 (bitwise-and tmp.38 7)))
                             (= tmp.115 0))
                         14
                         6)))
                  (!= tmp.114 6))
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.*.76.8
      (lambda (c.79 tmp.36 tmp.37)
        (let ()
          (if (let ((tmp.116
                     (if (let ((tmp.117 (bitwise-and tmp.37 7))) (= tmp.117 0))
                       14
                       6)))
                (!= tmp.116 6))
            (if (let ((tmp.118
                       (if (let ((tmp.119 (bitwise-and tmp.36 7)))
                             (= tmp.119 0))
                         14
                         6)))
                  (!= tmp.118 6))
              (let ((tmp.120 (arithmetic-shift-right tmp.37 3)))
                (* tmp.36 tmp.120))
              318)
            318))))
    (define L.-.77.7
      (lambda (c.78 tmp.40 tmp.41)
        (let ()
          (if (let ((tmp.121
                     (if (let ((tmp.122 (bitwise-and tmp.41 7))) (= tmp.122 0))
                       14
                       6)))
                (!= tmp.121 6))
            (if (let ((tmp.123
                       (if (let ((tmp.124 (bitwise-and tmp.40 7)))
                             (= tmp.124 0))
                         14
                         6)))
                  (!= tmp.123 6))
              (- tmp.40 tmp.41)
              830)
            830))))
    (let ((|-.77|
           (let ((tmp.95 (let ((tmp.125 (alloc 16))) (+ tmp.125 2))))
             (begin (mset! tmp.95 -2 L.-.77.7) (mset! tmp.95 6 16) tmp.95)))
          (*.76
           (let ((tmp.96 (let ((tmp.126 (alloc 16))) (+ tmp.126 2))))
             (begin (mset! tmp.96 -2 L.*.76.8) (mset! tmp.96 6 16) tmp.96)))
          (|+.75|
           (let ((tmp.97 (let ((tmp.127 (alloc 16))) (+ tmp.127 2))))
             (begin (mset! tmp.97 -2 L.+.75.9) (mset! tmp.97 6 16) tmp.97)))
          (cons.74
           (let ((tmp.98 (let ((tmp.128 (alloc 16))) (+ tmp.128 2))))
             (begin
               (mset! tmp.98 -2 L.cons.74.10)
               (mset! tmp.98 6 16)
               tmp.98)))
          (fun/empty13316.4
           (let ((tmp.99 (let ((tmp.129 (alloc 24))) (+ tmp.129 2))))
             (begin
               (mset! tmp.99 -2 L.fun/empty13316.4.11)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/ascii-char13315.5
           (let ((tmp.100 (let ((tmp.130 (alloc 16))) (+ tmp.130 2))))
             (begin
               (mset! tmp.100 -2 L.fun/ascii-char13315.5.12)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/error13313.6
           (let ((tmp.101 (let ((tmp.131 (alloc 16))) (+ tmp.131 2))))
             (begin
               (mset! tmp.101 -2 L.fun/error13313.6.13)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/error13308.7
           (let ((tmp.102 (let ((tmp.132 (alloc 24))) (+ tmp.132 2))))
             (begin
               (mset! tmp.102 -2 L.fun/error13308.7.14)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/error13312.8
           (let ((tmp.103 (let ((tmp.133 (alloc 24))) (+ tmp.133 2))))
             (begin
               (mset! tmp.103 -2 L.fun/error13312.8.15)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/pair13319.9
           (let ((tmp.104 (let ((tmp.134 (alloc 24))) (+ tmp.134 2))))
             (begin
               (mset! tmp.104 -2 L.fun/pair13319.9.16)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/void13310.10
           (let ((tmp.105 (let ((tmp.135 (alloc 24))) (+ tmp.135 2))))
             (begin
               (mset! tmp.105 -2 L.fun/void13310.10.17)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/empty13317.11
           (let ((tmp.106 (let ((tmp.136 (alloc 16))) (+ tmp.136 2))))
             (begin
               (mset! tmp.106 -2 L.fun/empty13317.11.18)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/error13309.12
           (let ((tmp.107 (let ((tmp.137 (alloc 16))) (+ tmp.137 2))))
             (begin
               (mset! tmp.107 -2 L.fun/error13309.12.19)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/ascii-char13314.13
           (let ((tmp.108 (let ((tmp.138 (alloc 24))) (+ tmp.138 2))))
             (begin
               (mset! tmp.108 -2 L.fun/ascii-char13314.13.20)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/void13311.14
           (let ((tmp.109 (let ((tmp.139 (alloc 16))) (+ tmp.139 2))))
             (begin
               (mset! tmp.109 -2 L.fun/void13311.14.21)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/pair13318.15
           (let ((tmp.110 (let ((tmp.140 (alloc 24))) (+ tmp.140 2))))
             (begin
               (mset! tmp.110 -2 L.fun/pair13318.15.22)
               (mset! tmp.110 6 0)
               tmp.110))))
      (begin
        (mset! fun/empty13316.4 14 fun/empty13317.11)
        (mset! fun/error13308.7 14 fun/error13309.12)
        (mset! fun/error13312.8 14 fun/error13313.6)
        (mset! fun/pair13319.9 14 cons.74)
        (mset! fun/void13310.10 14 fun/void13311.14)
        (mset! fun/ascii-char13314.13 14 fun/ascii-char13315.5)
        (mset! fun/pair13318.15 14 fun/pair13319.9)
        (let ((error0.21 (call L.fun/error13308.7.14 fun/error13308.7))
              (void1.20 (call L.fun/void13310.10.17 fun/void13310.10))
              (error2.19 (call L.fun/error13312.8.15 fun/error13312.8))
              (fixnum3.18
               (let ((tmp.141
                      (let ((tmp.142
                             (let ((tmp.143 (call L.+.75.9 |+.75| 872 2000)))
                               (let ((tmp.144 (call L.*.76.8 *.76 1816 1184)))
                                 (call L.+.75.9 |+.75| tmp.143 tmp.144)))))
                        (let ((tmp.145
                               (let ((tmp.146
                                      (call L.-.77.7 |-.77| 1720 1040)))
                                 (let ((tmp.147 (call L.*.76.8 *.76 1784 240)))
                                   (call L.*.76.8 *.76 tmp.146 tmp.147)))))
                          (call L.-.77.7 |-.77| tmp.142 tmp.145)))))
                 (let ((tmp.148
                        (let ((tmp.149
                               (let ((tmp.150 (call L.*.76.8 *.76 1976 8)))
                                 (let ((tmp.151 (call L.*.76.8 *.76 504 480)))
                                   (call L.-.77.7 |-.77| tmp.150 tmp.151)))))
                          (let ((tmp.152
                                 (let ((tmp.153
                                        (call L.*.76.8 *.76 1664 1664)))
                                   (let ((tmp.154
                                          (call L.-.77.7 |-.77| 1472 1024)))
                                     (call L.+.75.9 |+.75| tmp.153 tmp.154)))))
                            (call L.*.76.8 *.76 tmp.149 tmp.152)))))
                   (call L.-.77.7 |-.77| tmp.141 tmp.148))))
              (ascii-char4.17
               (call L.fun/ascii-char13314.13.20 fun/ascii-char13314.13))
              (empty5.16 (call L.fun/empty13316.4.11 fun/empty13316.4)))
          (call L.fun/pair13318.15.22 fun/pair13318.15))))))
(check-by-interp
 '(module
    (define L.lam.74.21
      (lambda (c.89)
        (let ((fun/vector13354.8 (mref c.89 14)))
          (call L.fun/vector13354.8.17 fun/vector13354.8))))
    (define L.fun/ascii-char13353.11.20 (lambda (c.88) (let () 18478)))
    (define L.fun/error13359.10.19 (lambda (c.87) (let () 1086)))
    (define L.fun/vector13356.9.18
      (lambda (c.86)
        (let ((fun/vector13357.5 (mref c.86 14)))
          (call L.fun/vector13357.5.14 fun/vector13357.5))))
    (define L.fun/vector13354.8.17
      (lambda (c.85)
        (let ((fun/vector13355.6 (mref c.85 14)))
          (call L.fun/vector13355.6.15 fun/vector13355.6))))
    (define L.fun/ascii-char13352.7.16
      (lambda (c.84)
        (let ((fun/ascii-char13353.11 (mref c.84 14)))
          (call L.fun/ascii-char13353.11.20 fun/ascii-char13353.11))))
    (define L.fun/vector13355.6.15
      (lambda (c.83)
        (let ((make-vector.70 (mref c.83 14)))
          (call L.make-vector.70.12 make-vector.70 64))))
    (define L.fun/vector13357.5.14
      (lambda (c.82)
        (let ((make-vector.70 (mref c.82 14)))
          (call L.make-vector.70.12 make-vector.70 64))))
    (define L.fun/error13358.4.13
      (lambda (c.81)
        (let ((fun/error13359.10 (mref c.81 14)))
          (call L.fun/error13359.10.19 fun/error13359.10))))
    (define L.make-vector.70.12
      (lambda (c.80 tmp.46)
        (let ((make-init-vector.1 (mref c.80 14)))
          (if (let ((tmp.106
                     (if (let ((tmp.107 (bitwise-and tmp.46 7))) (= tmp.107 0))
                       14
                       6)))
                (!= tmp.106 6))
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.46)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.79 tmp.18)
        (let ((vector-init-loop.20 (mref c.79 14)))
          (let ((tmp.19
                 (let ((tmp.90
                        (let ((tmp.108
                               (let ((tmp.109
                                      (let ((tmp.110
                                             (let ((tmp.111
                                                    (arithmetic-shift-right
                                                     tmp.18
                                                     3)))
                                               (+ 1 tmp.111))))
                                        (* tmp.110 8))))
                                 (alloc tmp.109))))
                          (+ tmp.108 3))))
                   (begin (mset! tmp.90 -3 tmp.18) tmp.90))))
            (call
             L.vector-init-loop.20.10
             vector-init-loop.20
             tmp.18
             0
             tmp.19)))))
    (define L.vector-init-loop.20.10
      (lambda (c.78 len.21 i.23 vec.22)
        (let ((vector-init-loop.20 (mref c.78 14)))
          (if (let ((tmp.112 (if (= len.21 i.23) 14 6))) (!= tmp.112 6))
            vec.22
            (begin
              (let ((tmp.113
                     (let ((tmp.114
                            (let ((tmp.115 (arithmetic-shift-right i.23 3)))
                              (* tmp.115 8))))
                       (+ tmp.114 5))))
                (mset! vec.22 tmp.113 0))
              (let ((tmp.116 (+ i.23 8)))
                (call
                 L.vector-init-loop.20.10
                 vector-init-loop.20
                 len.21
                 tmp.116
                 vec.22)))))))
    (define L.*.71.9
      (lambda (c.77 tmp.32 tmp.33)
        (let ()
          (if (let ((tmp.117
                     (if (let ((tmp.118 (bitwise-and tmp.33 7))) (= tmp.118 0))
                       14
                       6)))
                (!= tmp.117 6))
            (if (let ((tmp.119
                       (if (let ((tmp.120 (bitwise-and tmp.32 7)))
                             (= tmp.120 0))
                         14
                         6)))
                  (!= tmp.119 6))
              (let ((tmp.121 (arithmetic-shift-right tmp.33 3)))
                (* tmp.32 tmp.121))
              318)
            318))))
    (define L.+.72.8
      (lambda (c.76 tmp.34 tmp.35)
        (let ()
          (if (let ((tmp.122
                     (if (let ((tmp.123 (bitwise-and tmp.35 7))) (= tmp.123 0))
                       14
                       6)))
                (!= tmp.122 6))
            (if (let ((tmp.124
                       (if (let ((tmp.125 (bitwise-and tmp.34 7)))
                             (= tmp.125 0))
                         14
                         6)))
                  (!= tmp.124 6))
              (+ tmp.34 tmp.35)
              574)
            574))))
    (define L.-.73.7
      (lambda (c.75 tmp.36 tmp.37)
        (let ()
          (if (let ((tmp.126
                     (if (let ((tmp.127 (bitwise-and tmp.37 7))) (= tmp.127 0))
                       14
                       6)))
                (!= tmp.126 6))
            (if (let ((tmp.128
                       (if (let ((tmp.129 (bitwise-and tmp.36 7)))
                             (= tmp.129 0))
                         14
                         6)))
                  (!= tmp.128 6))
              (- tmp.36 tmp.37)
              830)
            830))))
    (let ((|-.73|
           (let ((tmp.91 (let ((tmp.130 (alloc 16))) (+ tmp.130 2))))
             (begin (mset! tmp.91 -2 L.-.73.7) (mset! tmp.91 6 16) tmp.91)))
          (|+.72|
           (let ((tmp.92 (let ((tmp.131 (alloc 16))) (+ tmp.131 2))))
             (begin (mset! tmp.92 -2 L.+.72.8) (mset! tmp.92 6 16) tmp.92)))
          (*.71
           (let ((tmp.93 (let ((tmp.132 (alloc 16))) (+ tmp.132 2))))
             (begin (mset! tmp.93 -2 L.*.71.9) (mset! tmp.93 6 16) tmp.93)))
          (vector-init-loop.20
           (let ((tmp.94 (let ((tmp.133 (alloc 24))) (+ tmp.133 2))))
             (begin
               (mset! tmp.94 -2 L.vector-init-loop.20.10)
               (mset! tmp.94 6 24)
               tmp.94)))
          (make-init-vector.1
           (let ((tmp.95 (let ((tmp.134 (alloc 24))) (+ tmp.134 2))))
             (begin
               (mset! tmp.95 -2 L.make-init-vector.1.11)
               (mset! tmp.95 6 8)
               tmp.95)))
          (make-vector.70
           (let ((tmp.96 (let ((tmp.135 (alloc 24))) (+ tmp.135 2))))
             (begin
               (mset! tmp.96 -2 L.make-vector.70.12)
               (mset! tmp.96 6 8)
               tmp.96)))
          (fun/error13358.4
           (let ((tmp.97 (let ((tmp.136 (alloc 24))) (+ tmp.136 2))))
             (begin
               (mset! tmp.97 -2 L.fun/error13358.4.13)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/vector13357.5
           (let ((tmp.98 (let ((tmp.137 (alloc 24))) (+ tmp.137 2))))
             (begin
               (mset! tmp.98 -2 L.fun/vector13357.5.14)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/vector13355.6
           (let ((tmp.99 (let ((tmp.138 (alloc 24))) (+ tmp.138 2))))
             (begin
               (mset! tmp.99 -2 L.fun/vector13355.6.15)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/ascii-char13352.7
           (let ((tmp.100 (let ((tmp.139 (alloc 24))) (+ tmp.139 2))))
             (begin
               (mset! tmp.100 -2 L.fun/ascii-char13352.7.16)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/vector13354.8
           (let ((tmp.101 (let ((tmp.140 (alloc 24))) (+ tmp.140 2))))
             (begin
               (mset! tmp.101 -2 L.fun/vector13354.8.17)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/vector13356.9
           (let ((tmp.102 (let ((tmp.141 (alloc 24))) (+ tmp.141 2))))
             (begin
               (mset! tmp.102 -2 L.fun/vector13356.9.18)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/error13359.10
           (let ((tmp.103 (let ((tmp.142 (alloc 16))) (+ tmp.142 2))))
             (begin
               (mset! tmp.103 -2 L.fun/error13359.10.19)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/ascii-char13353.11
           (let ((tmp.104 (let ((tmp.143 (alloc 16))) (+ tmp.143 2))))
             (begin
               (mset! tmp.104 -2 L.fun/ascii-char13353.11.20)
               (mset! tmp.104 6 0)
               tmp.104))))
      (begin
        (mset! vector-init-loop.20 14 vector-init-loop.20)
        (mset! make-init-vector.1 14 vector-init-loop.20)
        (mset! make-vector.70 14 make-init-vector.1)
        (mset! fun/error13358.4 14 fun/error13359.10)
        (mset! fun/vector13357.5 14 make-vector.70)
        (mset! fun/vector13355.6 14 make-vector.70)
        (mset! fun/ascii-char13352.7 14 fun/ascii-char13353.11)
        (mset! fun/vector13354.8 14 fun/vector13355.6)
        (mset! fun/vector13356.9 14 fun/vector13357.5)
        (let ((fixnum0.17
               (let ((tmp.144
                      (let ((tmp.145
                             (let ((tmp.146 (call L.*.71.9 *.71 488 1608)))
                               (let ((tmp.147 (call L.*.71.9 *.71 88 144)))
                                 (call L.+.72.8 |+.72| tmp.146 tmp.147)))))
                        (let ((tmp.148
                               (let ((tmp.149 (call L.-.73.7 |-.73| 736 216)))
                                 (let ((tmp.150
                                        (call L.+.72.8 |+.72| 792 1816)))
                                   (call L.+.72.8 |+.72| tmp.149 tmp.150)))))
                          (call L.+.72.8 |+.72| tmp.145 tmp.148)))))
                 (let ((tmp.151
                        (let ((tmp.152
                               (let ((tmp.153 (call L.-.73.7 |-.73| 624 1752)))
                                 (let ((tmp.154
                                        (call L.+.72.8 |+.72| 1848 632)))
                                   (call L.*.71.9 *.71 tmp.153 tmp.154)))))
                          (let ((tmp.155
                                 (let ((tmp.156
                                        (call L.-.73.7 |-.73| 320 744)))
                                   (let ((tmp.157 (call L.*.71.9 *.71 912 64)))
                                     (call L.+.72.8 |+.72| tmp.156 tmp.157)))))
                            (call L.+.72.8 |+.72| tmp.152 tmp.155)))))
                   (call L.*.71.9 *.71 tmp.144 tmp.151))))
              (ascii-char1.16
               (call L.fun/ascii-char13352.7.16 fun/ascii-char13352.7))
              (procedure2.15
               (let ((lam.74
                      (let ((tmp.105
                             (let ((tmp.158 (alloc 24))) (+ tmp.158 2))))
                        (begin
                          (mset! tmp.105 -2 L.lam.74.21)
                          (mset! tmp.105 6 0)
                          tmp.105))))
                 (begin (mset! lam.74 14 fun/vector13354.8) lam.74)))
              (fixnum3.14
               (let ((tmp.159
                      (let ((tmp.160
                             (let ((tmp.161 (call L.-.73.7 |-.73| 1472 1496)))
                               (let ((tmp.162 (call L.-.73.7 |-.73| 1992 664)))
                                 (call L.-.73.7 |-.73| tmp.161 tmp.162)))))
                        (let ((tmp.163
                               (let ((tmp.164 (call L.*.71.9 *.71 1984 1664)))
                                 (let ((tmp.165
                                        (call L.+.72.8 |+.72| 1592 1048)))
                                   (call L.-.73.7 |-.73| tmp.164 tmp.165)))))
                          (call L.*.71.9 *.71 tmp.160 tmp.163)))))
                 (let ((tmp.166
                        (let ((tmp.167
                               (let ((tmp.168 (call L.*.71.9 *.71 128 1896)))
                                 (let ((tmp.169
                                        (call L.*.71.9 *.71 1472 1096)))
                                   (call L.*.71.9 *.71 tmp.168 tmp.169)))))
                          (let ((tmp.170
                                 (let ((tmp.171
                                        (call L.-.73.7 |-.73| 608 1528)))
                                   (let ((tmp.172
                                          (call L.-.73.7 |-.73| 1480 720)))
                                     (call L.*.71.9 *.71 tmp.171 tmp.172)))))
                            (call L.-.73.7 |-.73| tmp.167 tmp.170)))))
                   (call L.-.73.7 |-.73| tmp.159 tmp.166))))
              (vector4.13 (call L.fun/vector13356.9.18 fun/vector13356.9))
              (error5.12 (call L.fun/error13358.4.13 fun/error13358.4)))
          (if (let ((tmp.173
                     (if (let ((tmp.174 (bitwise-and procedure2.15 7)))
                           (= tmp.174 2))
                       14
                       6)))
                (!= tmp.173 6))
            (if (let ((tmp.175
                       (if (let ((tmp.176 (mref procedure2.15 6)))
                             (= tmp.176 0))
                         14
                         6)))
                  (!= tmp.175 6))
              (let ((tmp.177 (mref procedure2.15 -2)))
                (call tmp.177 procedure2.15))
              10814)
            11070))))))
(check-by-interp
 '(module
    (define L.fun/empty14584.13.19
      (lambda (c.87)
        (let ((fun/empty14585.11 (mref c.87 14)))
          (call L.fun/empty14585.11.17 fun/empty14585.11))))
    (define L.fun/void14589.12.18 (lambda (c.86) (let () 30)))
    (define L.fun/empty14585.11.17 (lambda (c.85) (let () 22)))
    (define L.fun/ascii-char14587.10.16 (lambda (c.84) (let () 21550)))
    (define L.fun/void14592.9.15
      (lambda (c.83)
        (let ((fun/void14593.4 (mref c.83 14)))
          (call L.fun/void14593.4.10 fun/void14593.4))))
    (define L.fun/void14588.8.14
      (lambda (c.82)
        (let ((fun/void14589.12 (mref c.82 14)))
          (call L.fun/void14589.12.18 fun/void14589.12))))
    (define L.fun/ascii-char14586.7.13
      (lambda (c.81)
        (let ((fun/ascii-char14587.10 (mref c.81 14)))
          (call L.fun/ascii-char14587.10.16 fun/ascii-char14587.10))))
    (define L.fun/void14590.6.12
      (lambda (c.80)
        (let ((fun/void14591.5 (mref c.80 14)))
          (call L.fun/void14591.5.11 fun/void14591.5))))
    (define L.fun/void14591.5.11 (lambda (c.79) (let () 30)))
    (define L.fun/void14593.4.10 (lambda (c.78) (let () 30)))
    (define L.-.72.9
      (lambda (c.77 tmp.38 tmp.39)
        (let ()
          (if (let ((tmp.101
                     (if (let ((tmp.102 (bitwise-and tmp.39 7))) (= tmp.102 0))
                       14
                       6)))
                (!= tmp.101 6))
            (if (let ((tmp.103
                       (if (let ((tmp.104 (bitwise-and tmp.38 7)))
                             (= tmp.104 0))
                         14
                         6)))
                  (!= tmp.103 6))
              (- tmp.38 tmp.39)
              830)
            830))))
    (define L.+.73.8
      (lambda (c.76 tmp.36 tmp.37)
        (let ()
          (if (let ((tmp.105
                     (if (let ((tmp.106 (bitwise-and tmp.37 7))) (= tmp.106 0))
                       14
                       6)))
                (!= tmp.105 6))
            (if (let ((tmp.107
                       (if (let ((tmp.108 (bitwise-and tmp.36 7)))
                             (= tmp.108 0))
                         14
                         6)))
                  (!= tmp.107 6))
              (+ tmp.36 tmp.37)
              574)
            574))))
    (define L.*.74.7
      (lambda (c.75 tmp.34 tmp.35)
        (let ()
          (if (let ((tmp.109
                     (if (let ((tmp.110 (bitwise-and tmp.35 7))) (= tmp.110 0))
                       14
                       6)))
                (!= tmp.109 6))
            (if (let ((tmp.111
                       (if (let ((tmp.112 (bitwise-and tmp.34 7)))
                             (= tmp.112 0))
                         14
                         6)))
                  (!= tmp.111 6))
              (let ((tmp.113 (arithmetic-shift-right tmp.35 3)))
                (* tmp.34 tmp.113))
              318)
            318))))
    (let ((*.74
           (let ((tmp.88 (let ((tmp.114 (alloc 16))) (+ tmp.114 2))))
             (begin (mset! tmp.88 -2 L.*.74.7) (mset! tmp.88 6 16) tmp.88)))
          (|+.73|
           (let ((tmp.89 (let ((tmp.115 (alloc 16))) (+ tmp.115 2))))
             (begin (mset! tmp.89 -2 L.+.73.8) (mset! tmp.89 6 16) tmp.89)))
          (|-.72|
           (let ((tmp.90 (let ((tmp.116 (alloc 16))) (+ tmp.116 2))))
             (begin (mset! tmp.90 -2 L.-.72.9) (mset! tmp.90 6 16) tmp.90)))
          (fun/void14593.4
           (let ((tmp.91 (let ((tmp.117 (alloc 16))) (+ tmp.117 2))))
             (begin
               (mset! tmp.91 -2 L.fun/void14593.4.10)
               (mset! tmp.91 6 0)
               tmp.91)))
          (fun/void14591.5
           (let ((tmp.92 (let ((tmp.118 (alloc 16))) (+ tmp.118 2))))
             (begin
               (mset! tmp.92 -2 L.fun/void14591.5.11)
               (mset! tmp.92 6 0)
               tmp.92)))
          (fun/void14590.6
           (let ((tmp.93 (let ((tmp.119 (alloc 24))) (+ tmp.119 2))))
             (begin
               (mset! tmp.93 -2 L.fun/void14590.6.12)
               (mset! tmp.93 6 0)
               tmp.93)))
          (fun/ascii-char14586.7
           (let ((tmp.94 (let ((tmp.120 (alloc 24))) (+ tmp.120 2))))
             (begin
               (mset! tmp.94 -2 L.fun/ascii-char14586.7.13)
               (mset! tmp.94 6 0)
               tmp.94)))
          (fun/void14588.8
           (let ((tmp.95 (let ((tmp.121 (alloc 24))) (+ tmp.121 2))))
             (begin
               (mset! tmp.95 -2 L.fun/void14588.8.14)
               (mset! tmp.95 6 0)
               tmp.95)))
          (fun/void14592.9
           (let ((tmp.96 (let ((tmp.122 (alloc 24))) (+ tmp.122 2))))
             (begin
               (mset! tmp.96 -2 L.fun/void14592.9.15)
               (mset! tmp.96 6 0)
               tmp.96)))
          (fun/ascii-char14587.10
           (let ((tmp.97 (let ((tmp.123 (alloc 16))) (+ tmp.123 2))))
             (begin
               (mset! tmp.97 -2 L.fun/ascii-char14587.10.16)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/empty14585.11
           (let ((tmp.98 (let ((tmp.124 (alloc 16))) (+ tmp.124 2))))
             (begin
               (mset! tmp.98 -2 L.fun/empty14585.11.17)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/void14589.12
           (let ((tmp.99 (let ((tmp.125 (alloc 16))) (+ tmp.125 2))))
             (begin
               (mset! tmp.99 -2 L.fun/void14589.12.18)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/empty14584.13
           (let ((tmp.100 (let ((tmp.126 (alloc 24))) (+ tmp.126 2))))
             (begin
               (mset! tmp.100 -2 L.fun/empty14584.13.19)
               (mset! tmp.100 6 0)
               tmp.100))))
      (begin
        (mset! fun/void14590.6 14 fun/void14591.5)
        (mset! fun/ascii-char14586.7 14 fun/ascii-char14587.10)
        (mset! fun/void14588.8 14 fun/void14589.12)
        (mset! fun/void14592.9 14 fun/void14593.4)
        (mset! fun/empty14584.13 14 fun/empty14585.11)
        (let ((empty0.19 (call L.fun/empty14584.13.19 fun/empty14584.13))
              (ascii-char1.18
               (call L.fun/ascii-char14586.7.13 fun/ascii-char14586.7))
              (void2.17 (call L.fun/void14588.8.14 fun/void14588.8))
              (fixnum3.16
               (let ((tmp.127
                      (let ((tmp.128
                             (let ((tmp.129 (call L.-.72.9 |-.72| 1552 904)))
                               (let ((tmp.130
                                      (call L.-.72.9 |-.72| 1480 1928)))
                                 (call L.-.72.9 |-.72| tmp.129 tmp.130)))))
                        (let ((tmp.131
                               (let ((tmp.132 (call L.+.73.8 |+.73| 1296 728)))
                                 (let ((tmp.133
                                        (call L.-.72.9 |-.72| 1312 1576)))
                                   (call L.*.74.7 *.74 tmp.132 tmp.133)))))
                          (call L.+.73.8 |+.73| tmp.128 tmp.131)))))
                 (let ((tmp.134
                        (let ((tmp.135
                               (let ((tmp.136
                                      (call L.-.72.9 |-.72| 1992 1792)))
                                 (let ((tmp.137
                                        (call L.-.72.9 |-.72| 2000 1496)))
                                   (call L.*.74.7 *.74 tmp.136 tmp.137)))))
                          (let ((tmp.138
                                 (let ((tmp.139 (call L.*.74.7 *.74 1712 752)))
                                   (let ((tmp.140
                                          (call L.*.74.7 *.74 1648 1528)))
                                     (call L.*.74.7 *.74 tmp.139 tmp.140)))))
                            (call L.+.73.8 |+.73| tmp.135 tmp.138)))))
                   (call L.+.73.8 |+.73| tmp.127 tmp.134))))
              (void4.15 (call L.fun/void14590.6.12 fun/void14590.6))
              (fixnum5.14
               (let ((tmp.141
                      (let ((tmp.142
                             (let ((tmp.143 (call L.-.72.9 |-.72| 1184 296)))
                               (let ((tmp.144 (call L.*.74.7 *.74 880 88)))
                                 (call L.+.73.8 |+.73| tmp.143 tmp.144)))))
                        (let ((tmp.145
                               (let ((tmp.146 (call L.*.74.7 *.74 40 616)))
                                 (let ((tmp.147
                                        (call L.-.72.9 |-.72| 424 1784)))
                                   (call L.*.74.7 *.74 tmp.146 tmp.147)))))
                          (call L.-.72.9 |-.72| tmp.142 tmp.145)))))
                 (let ((tmp.148
                        (let ((tmp.149
                               (let ((tmp.150 (call L.*.74.7 *.74 512 688)))
                                 (let ((tmp.151
                                        (call L.-.72.9 |-.72| 1616 968)))
                                   (call L.-.72.9 |-.72| tmp.150 tmp.151)))))
                          (let ((tmp.152
                                 (let ((tmp.153 (call L.*.74.7 *.74 608 208)))
                                   (let ((tmp.154
                                          (call L.*.74.7 *.74 296 1832)))
                                     (call L.*.74.7 *.74 tmp.153 tmp.154)))))
                            (call L.+.73.8 |+.73| tmp.149 tmp.152)))))
                   (call L.+.73.8 |+.73| tmp.141 tmp.148)))))
          (call L.fun/void14592.9.15 fun/void14592.9))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char15136.15.26 (lambda (c.99) (let () 20014)))
    (define L.fun/void15141.14.25
      (lambda (c.98)
        (let ((fun/void15142.8 (mref c.98 14)))
          (call L.fun/void15142.8.19 fun/void15142.8))))
    (define L.fun/empty15139.13.24
      (lambda (c.97)
        (let ((fun/empty15140.4 (mref c.97 14)))
          (call L.fun/empty15140.4.15 fun/empty15140.4))))
    (define L.fun/void15146.12.23 (lambda (c.96) (let () 30)))
    (define L.fun/vector15137.11.22
      (lambda (c.95)
        (let ((fun/vector15138.6 (mref c.95 14)))
          (call L.fun/vector15138.6.17 fun/vector15138.6))))
    (define L.fun/any15143.10.21
      (lambda (c.94)
        (let ((fun/any15144.9 (mref c.94 14)))
          (call L.fun/any15144.9.20 fun/any15144.9))))
    (define L.fun/any15144.9.20
      (lambda (c.93)
        (let ((cons.75 (mref c.93 14))) (call L.cons.75.11 cons.75 720 3640))))
    (define L.fun/void15142.8.19 (lambda (c.92) (let () 30)))
    (define L.fun/ascii-char15135.7.18
      (lambda (c.91)
        (let ((fun/ascii-char15136.15 (mref c.91 14)))
          (call L.fun/ascii-char15136.15.26 fun/ascii-char15136.15))))
    (define L.fun/vector15138.6.17
      (lambda (c.90)
        (let ((make-vector.74 (mref c.90 14)))
          (call L.make-vector.74.14 make-vector.74 64))))
    (define L.fun/void15145.5.16
      (lambda (c.89)
        (let ((fun/void15146.12 (mref c.89 14)))
          (call L.fun/void15146.12.23 fun/void15146.12))))
    (define L.fun/empty15140.4.15 (lambda (c.88) (let () 22)))
    (define L.make-vector.74.14
      (lambda (c.87 tmp.50)
        (let ((make-init-vector.1 (mref c.87 14)))
          (if (let ((tmp.122
                     (if (let ((tmp.123 (bitwise-and tmp.50 7))) (= tmp.123 0))
                       14
                       6)))
                (!= tmp.122 6))
            (call L.make-init-vector.1.13 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.13
      (lambda (c.86 tmp.22)
        (let ((vector-init-loop.24 (mref c.86 14)))
          (let ((tmp.23
                 (let ((tmp.100
                        (let ((tmp.124
                               (let ((tmp.125
                                      (let ((tmp.126
                                             (let ((tmp.127
                                                    (arithmetic-shift-right
                                                     tmp.22
                                                     3)))
                                               (+ 1 tmp.127))))
                                        (* tmp.126 8))))
                                 (alloc tmp.125))))
                          (+ tmp.124 3))))
                   (begin (mset! tmp.100 -3 tmp.22) tmp.100))))
            (call
             L.vector-init-loop.24.12
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.12
      (lambda (c.85 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (mref c.85 14)))
          (if (let ((tmp.128 (if (= len.25 i.27) 14 6))) (!= tmp.128 6))
            vec.26
            (begin
              (let ((tmp.129
                     (let ((tmp.130
                            (let ((tmp.131 (arithmetic-shift-right i.27 3)))
                              (* tmp.131 8))))
                       (+ tmp.130 5))))
                (mset! vec.26 tmp.129 0))
              (let ((tmp.132 (+ i.27 8)))
                (call
                 L.vector-init-loop.24.12
                 vector-init-loop.24
                 len.25
                 tmp.132
                 vec.26)))))))
    (define L.cons.75.11
      (lambda (c.84 tmp.69 tmp.70)
        (let ()
          (let ((tmp.101 (let ((tmp.133 (alloc 16))) (+ tmp.133 1))))
            (begin
              (mset! tmp.101 -1 tmp.69)
              (mset! tmp.101 7 tmp.70)
              tmp.101)))))
    (define L.-.76.10
      (lambda (c.83 tmp.40 tmp.41)
        (let ()
          (if (let ((tmp.134
                     (if (let ((tmp.135 (bitwise-and tmp.41 7))) (= tmp.135 0))
                       14
                       6)))
                (!= tmp.134 6))
            (if (let ((tmp.136
                       (if (let ((tmp.137 (bitwise-and tmp.40 7)))
                             (= tmp.137 0))
                         14
                         6)))
                  (!= tmp.136 6))
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.+.77.9
      (lambda (c.82 tmp.38 tmp.39)
        (let ()
          (if (let ((tmp.138
                     (if (let ((tmp.139 (bitwise-and tmp.39 7))) (= tmp.139 0))
                       14
                       6)))
                (!= tmp.138 6))
            (if (let ((tmp.140
                       (if (let ((tmp.141 (bitwise-and tmp.38 7)))
                             (= tmp.141 0))
                         14
                         6)))
                  (!= tmp.140 6))
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.*.78.8
      (lambda (c.81 tmp.36 tmp.37)
        (let ()
          (if (let ((tmp.142
                     (if (let ((tmp.143 (bitwise-and tmp.37 7))) (= tmp.143 0))
                       14
                       6)))
                (!= tmp.142 6))
            (if (let ((tmp.144
                       (if (let ((tmp.145 (bitwise-and tmp.36 7)))
                             (= tmp.145 0))
                         14
                         6)))
                  (!= tmp.144 6))
              (let ((tmp.146 (arithmetic-shift-right tmp.37 3)))
                (* tmp.36 tmp.146))
              318)
            318))))
    (define L.empty?.79.7
      (lambda (c.80 tmp.61)
        (let ()
          (if (let ((tmp.147 (bitwise-and tmp.61 255))) (= tmp.147 22))
            14
            6))))
    (let ((empty?.79
           (let ((tmp.102 (let ((tmp.148 (alloc 16))) (+ tmp.148 2))))
             (begin
               (mset! tmp.102 -2 L.empty?.79.7)
               (mset! tmp.102 6 8)
               tmp.102)))
          (*.78
           (let ((tmp.103 (let ((tmp.149 (alloc 16))) (+ tmp.149 2))))
             (begin (mset! tmp.103 -2 L.*.78.8) (mset! tmp.103 6 16) tmp.103)))
          (|+.77|
           (let ((tmp.104 (let ((tmp.150 (alloc 16))) (+ tmp.150 2))))
             (begin (mset! tmp.104 -2 L.+.77.9) (mset! tmp.104 6 16) tmp.104)))
          (|-.76|
           (let ((tmp.105 (let ((tmp.151 (alloc 16))) (+ tmp.151 2))))
             (begin
               (mset! tmp.105 -2 L.-.76.10)
               (mset! tmp.105 6 16)
               tmp.105)))
          (cons.75
           (let ((tmp.106 (let ((tmp.152 (alloc 16))) (+ tmp.152 2))))
             (begin
               (mset! tmp.106 -2 L.cons.75.11)
               (mset! tmp.106 6 16)
               tmp.106)))
          (vector-init-loop.24
           (let ((tmp.107 (let ((tmp.153 (alloc 24))) (+ tmp.153 2))))
             (begin
               (mset! tmp.107 -2 L.vector-init-loop.24.12)
               (mset! tmp.107 6 24)
               tmp.107)))
          (make-init-vector.1
           (let ((tmp.108 (let ((tmp.154 (alloc 24))) (+ tmp.154 2))))
             (begin
               (mset! tmp.108 -2 L.make-init-vector.1.13)
               (mset! tmp.108 6 8)
               tmp.108)))
          (make-vector.74
           (let ((tmp.109 (let ((tmp.155 (alloc 24))) (+ tmp.155 2))))
             (begin
               (mset! tmp.109 -2 L.make-vector.74.14)
               (mset! tmp.109 6 8)
               tmp.109)))
          (fun/empty15140.4
           (let ((tmp.110 (let ((tmp.156 (alloc 16))) (+ tmp.156 2))))
             (begin
               (mset! tmp.110 -2 L.fun/empty15140.4.15)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/void15145.5
           (let ((tmp.111 (let ((tmp.157 (alloc 24))) (+ tmp.157 2))))
             (begin
               (mset! tmp.111 -2 L.fun/void15145.5.16)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/vector15138.6
           (let ((tmp.112 (let ((tmp.158 (alloc 24))) (+ tmp.158 2))))
             (begin
               (mset! tmp.112 -2 L.fun/vector15138.6.17)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/ascii-char15135.7
           (let ((tmp.113 (let ((tmp.159 (alloc 24))) (+ tmp.159 2))))
             (begin
               (mset! tmp.113 -2 L.fun/ascii-char15135.7.18)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/void15142.8
           (let ((tmp.114 (let ((tmp.160 (alloc 16))) (+ tmp.160 2))))
             (begin
               (mset! tmp.114 -2 L.fun/void15142.8.19)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/any15144.9
           (let ((tmp.115 (let ((tmp.161 (alloc 24))) (+ tmp.161 2))))
             (begin
               (mset! tmp.115 -2 L.fun/any15144.9.20)
               (mset! tmp.115 6 0)
               tmp.115)))
          (fun/any15143.10
           (let ((tmp.116 (let ((tmp.162 (alloc 24))) (+ tmp.162 2))))
             (begin
               (mset! tmp.116 -2 L.fun/any15143.10.21)
               (mset! tmp.116 6 0)
               tmp.116)))
          (fun/vector15137.11
           (let ((tmp.117 (let ((tmp.163 (alloc 24))) (+ tmp.163 2))))
             (begin
               (mset! tmp.117 -2 L.fun/vector15137.11.22)
               (mset! tmp.117 6 0)
               tmp.117)))
          (fun/void15146.12
           (let ((tmp.118 (let ((tmp.164 (alloc 16))) (+ tmp.164 2))))
             (begin
               (mset! tmp.118 -2 L.fun/void15146.12.23)
               (mset! tmp.118 6 0)
               tmp.118)))
          (fun/empty15139.13
           (let ((tmp.119 (let ((tmp.165 (alloc 24))) (+ tmp.165 2))))
             (begin
               (mset! tmp.119 -2 L.fun/empty15139.13.24)
               (mset! tmp.119 6 0)
               tmp.119)))
          (fun/void15141.14
           (let ((tmp.120 (let ((tmp.166 (alloc 24))) (+ tmp.166 2))))
             (begin
               (mset! tmp.120 -2 L.fun/void15141.14.25)
               (mset! tmp.120 6 0)
               tmp.120)))
          (fun/ascii-char15136.15
           (let ((tmp.121 (let ((tmp.167 (alloc 16))) (+ tmp.167 2))))
             (begin
               (mset! tmp.121 -2 L.fun/ascii-char15136.15.26)
               (mset! tmp.121 6 0)
               tmp.121))))
      (begin
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.1 14 vector-init-loop.24)
        (mset! make-vector.74 14 make-init-vector.1)
        (mset! fun/void15145.5 14 fun/void15146.12)
        (mset! fun/vector15138.6 14 make-vector.74)
        (mset! fun/ascii-char15135.7 14 fun/ascii-char15136.15)
        (mset! fun/any15144.9 14 cons.75)
        (mset! fun/any15143.10 14 fun/any15144.9)
        (mset! fun/vector15137.11 14 fun/vector15138.6)
        (mset! fun/empty15139.13 14 fun/empty15140.4)
        (mset! fun/void15141.14 14 fun/void15142.8)
        (let ((ascii-char0.21
               (call L.fun/ascii-char15135.7.18 fun/ascii-char15135.7))
              (vector1.20 (call L.fun/vector15137.11.22 fun/vector15137.11))
              (empty2.19 (call L.fun/empty15139.13.24 fun/empty15139.13))
              (fixnum3.18
               (let ((tmp.168
                      (let ((tmp.169
                             (let ((tmp.170 (call L.-.76.10 |-.76| 1376 192)))
                               (let ((tmp.171
                                      (call L.-.76.10 |-.76| 1984 1608)))
                                 (call L.+.77.9 |+.77| tmp.170 tmp.171)))))
                        (let ((tmp.172
                               (let ((tmp.173 (call L.+.77.9 |+.77| 296 1840)))
                                 (let ((tmp.174
                                        (call L.-.76.10 |-.76| 488 1720)))
                                   (call L.+.77.9 |+.77| tmp.173 tmp.174)))))
                          (call L.-.76.10 |-.76| tmp.169 tmp.172)))))
                 (let ((tmp.175
                        (let ((tmp.176
                               (let ((tmp.177 (call L.*.78.8 *.78 1368 776)))
                                 (let ((tmp.178
                                        (call L.-.76.10 |-.76| 864 64)))
                                   (call L.+.77.9 |+.77| tmp.177 tmp.178)))))
                          (let ((tmp.179
                                 (let ((tmp.180
                                        (call L.-.76.10 |-.76| 392 584)))
                                   (let ((tmp.181
                                          (call L.+.77.9 |+.77| 1440 1872)))
                                     (call
                                      L.-.76.10
                                      |-.76|
                                      tmp.180
                                      tmp.181)))))
                            (call L.-.76.10 |-.76| tmp.176 tmp.179)))))
                   (call L.+.77.9 |+.77| tmp.168 tmp.175))))
              (void4.17 (call L.fun/void15141.14.25 fun/void15141.14))
              (boolean5.16
               (let ((tmp.182 (call L.fun/any15143.10.21 fun/any15143.10)))
                 (call L.empty?.79.7 empty?.79 tmp.182))))
          (call L.fun/void15145.5.16 fun/void15145.5))))))
(check-by-interp
 '(module
    (define L.lam.77.24
      (lambda (c.95)
        (let ((fun/empty15764.14 (mref c.95 14)))
          (call L.fun/empty15764.14.20 fun/empty15764.14))))
    (define L.fun/ascii-char15768.17.23
      (lambda (c.94)
        (let ((fun/ascii-char15769.10 (mref c.94 14)))
          (call L.fun/ascii-char15769.10.16 fun/ascii-char15769.10))))
    (define L.fun/ascii-char15777.16.22 (lambda (c.93) (let () 19502)))
    (define L.fun/void15775.15.21 (lambda (c.92) (let () 30)))
    (define L.fun/empty15764.14.20
      (lambda (c.91)
        (let ((fun/empty15765.5 (mref c.91 14)))
          (call L.fun/empty15765.5.11 fun/empty15765.5))))
    (define L.fun/empty15766.13.19
      (lambda (c.90)
        (let ((fun/empty15767.11 (mref c.90 14)))
          (call L.fun/empty15767.11.17 fun/empty15767.11))))
    (define L.fun/ascii-char15776.12.18
      (lambda (c.89)
        (let ((fun/ascii-char15777.16 (mref c.89 14)))
          (call L.fun/ascii-char15777.16.22 fun/ascii-char15777.16))))
    (define L.fun/empty15767.11.17 (lambda (c.88) (let () 22)))
    (define L.fun/ascii-char15769.10.16 (lambda (c.87) (let () 24366)))
    (define L.fun/vector15771.9.15
      (lambda (c.86)
        (let ((make-vector.76 (mref c.86 14)))
          (call L.make-vector.76.9 make-vector.76 64))))
    (define L.fun/error15772.8.14
      (lambda (c.85)
        (let ((fun/error15773.7 (mref c.85 14)))
          (call L.fun/error15773.7.13 fun/error15773.7))))
    (define L.fun/error15773.7.13 (lambda (c.84) (let () 4414)))
    (define L.fun/void15774.6.12
      (lambda (c.83)
        (let ((fun/void15775.15 (mref c.83 14)))
          (call L.fun/void15775.15.21 fun/void15775.15))))
    (define L.fun/empty15765.5.11 (lambda (c.82) (let () 22)))
    (define L.fun/vector15770.4.10
      (lambda (c.81)
        (let ((fun/vector15771.9 (mref c.81 14)))
          (call L.fun/vector15771.9.15 fun/vector15771.9))))
    (define L.make-vector.76.9
      (lambda (c.80 tmp.52)
        (let ((make-init-vector.1 (mref c.80 14)))
          (if (let ((tmp.115
                     (if (let ((tmp.116 (bitwise-and tmp.52 7))) (= tmp.116 0))
                       14
                       6)))
                (!= tmp.115 6))
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.52)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.79 tmp.24)
        (let ((vector-init-loop.26 (mref c.79 14)))
          (let ((tmp.25
                 (let ((tmp.96
                        (let ((tmp.117
                               (let ((tmp.118
                                      (let ((tmp.119
                                             (let ((tmp.120
                                                    (arithmetic-shift-right
                                                     tmp.24
                                                     3)))
                                               (+ 1 tmp.120))))
                                        (* tmp.119 8))))
                                 (alloc tmp.118))))
                          (+ tmp.117 3))))
                   (begin (mset! tmp.96 -3 tmp.24) tmp.96))))
            (call
             L.vector-init-loop.26.7
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.7
      (lambda (c.78 len.27 i.29 vec.28)
        (let ((vector-init-loop.26 (mref c.78 14)))
          (if (let ((tmp.121 (if (= len.27 i.29) 14 6))) (!= tmp.121 6))
            vec.28
            (begin
              (let ((tmp.122
                     (let ((tmp.123
                            (let ((tmp.124 (arithmetic-shift-right i.29 3)))
                              (* tmp.124 8))))
                       (+ tmp.123 5))))
                (mset! vec.28 tmp.122 0))
              (let ((tmp.125 (+ i.29 8)))
                (call
                 L.vector-init-loop.26.7
                 vector-init-loop.26
                 len.27
                 tmp.125
                 vec.28)))))))
    (let ((vector-init-loop.26
           (let ((tmp.97 (let ((tmp.126 (alloc 24))) (+ tmp.126 2))))
             (begin
               (mset! tmp.97 -2 L.vector-init-loop.26.7)
               (mset! tmp.97 6 24)
               tmp.97)))
          (make-init-vector.1
           (let ((tmp.98 (let ((tmp.127 (alloc 24))) (+ tmp.127 2))))
             (begin
               (mset! tmp.98 -2 L.make-init-vector.1.8)
               (mset! tmp.98 6 8)
               tmp.98)))
          (make-vector.76
           (let ((tmp.99 (let ((tmp.128 (alloc 24))) (+ tmp.128 2))))
             (begin
               (mset! tmp.99 -2 L.make-vector.76.9)
               (mset! tmp.99 6 8)
               tmp.99)))
          (fun/vector15770.4
           (let ((tmp.100 (let ((tmp.129 (alloc 24))) (+ tmp.129 2))))
             (begin
               (mset! tmp.100 -2 L.fun/vector15770.4.10)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/empty15765.5
           (let ((tmp.101 (let ((tmp.130 (alloc 16))) (+ tmp.130 2))))
             (begin
               (mset! tmp.101 -2 L.fun/empty15765.5.11)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/void15774.6
           (let ((tmp.102 (let ((tmp.131 (alloc 24))) (+ tmp.131 2))))
             (begin
               (mset! tmp.102 -2 L.fun/void15774.6.12)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/error15773.7
           (let ((tmp.103 (let ((tmp.132 (alloc 16))) (+ tmp.132 2))))
             (begin
               (mset! tmp.103 -2 L.fun/error15773.7.13)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/error15772.8
           (let ((tmp.104 (let ((tmp.133 (alloc 24))) (+ tmp.133 2))))
             (begin
               (mset! tmp.104 -2 L.fun/error15772.8.14)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/vector15771.9
           (let ((tmp.105 (let ((tmp.134 (alloc 24))) (+ tmp.134 2))))
             (begin
               (mset! tmp.105 -2 L.fun/vector15771.9.15)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/ascii-char15769.10
           (let ((tmp.106 (let ((tmp.135 (alloc 16))) (+ tmp.135 2))))
             (begin
               (mset! tmp.106 -2 L.fun/ascii-char15769.10.16)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/empty15767.11
           (let ((tmp.107 (let ((tmp.136 (alloc 16))) (+ tmp.136 2))))
             (begin
               (mset! tmp.107 -2 L.fun/empty15767.11.17)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/ascii-char15776.12
           (let ((tmp.108 (let ((tmp.137 (alloc 24))) (+ tmp.137 2))))
             (begin
               (mset! tmp.108 -2 L.fun/ascii-char15776.12.18)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/empty15766.13
           (let ((tmp.109 (let ((tmp.138 (alloc 24))) (+ tmp.138 2))))
             (begin
               (mset! tmp.109 -2 L.fun/empty15766.13.19)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/empty15764.14
           (let ((tmp.110 (let ((tmp.139 (alloc 24))) (+ tmp.139 2))))
             (begin
               (mset! tmp.110 -2 L.fun/empty15764.14.20)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/void15775.15
           (let ((tmp.111 (let ((tmp.140 (alloc 16))) (+ tmp.140 2))))
             (begin
               (mset! tmp.111 -2 L.fun/void15775.15.21)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/ascii-char15777.16
           (let ((tmp.112 (let ((tmp.141 (alloc 16))) (+ tmp.141 2))))
             (begin
               (mset! tmp.112 -2 L.fun/ascii-char15777.16.22)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/ascii-char15768.17
           (let ((tmp.113 (let ((tmp.142 (alloc 24))) (+ tmp.142 2))))
             (begin
               (mset! tmp.113 -2 L.fun/ascii-char15768.17.23)
               (mset! tmp.113 6 0)
               tmp.113))))
      (begin
        (mset! vector-init-loop.26 14 vector-init-loop.26)
        (mset! make-init-vector.1 14 vector-init-loop.26)
        (mset! make-vector.76 14 make-init-vector.1)
        (mset! fun/vector15770.4 14 fun/vector15771.9)
        (mset! fun/void15774.6 14 fun/void15775.15)
        (mset! fun/error15772.8 14 fun/error15773.7)
        (mset! fun/vector15771.9 14 make-vector.76)
        (mset! fun/ascii-char15776.12 14 fun/ascii-char15777.16)
        (mset! fun/empty15766.13 14 fun/empty15767.11)
        (mset! fun/empty15764.14 14 fun/empty15765.5)
        (mset! fun/ascii-char15768.17 14 fun/ascii-char15769.10)
        (let ((procedure0.23
               (let ((lam.77
                      (let ((tmp.114
                             (let ((tmp.143 (alloc 24))) (+ tmp.143 2))))
                        (begin
                          (mset! tmp.114 -2 L.lam.77.24)
                          (mset! tmp.114 6 0)
                          tmp.114))))
                 (begin (mset! lam.77 14 fun/empty15764.14) lam.77)))
              (empty1.22 (call L.fun/empty15766.13.19 fun/empty15766.13))
              (ascii-char2.21
               (call L.fun/ascii-char15768.17.23 fun/ascii-char15768.17))
              (vector3.20 (call L.fun/vector15770.4.10 fun/vector15770.4))
              (error4.19 (call L.fun/error15772.8.14 fun/error15772.8))
              (void5.18 (call L.fun/void15774.6.12 fun/void15774.6)))
          (call L.fun/ascii-char15776.12.18 fun/ascii-char15776.12))))))
(check-by-interp
 '(module
    (define L.lam.79.26
      (lambda (c.99)
        (let ((fun/pair21851.7 (mref c.99 14)))
          (call L.fun/pair21851.7.17 fun/pair21851.7))))
    (define L.fun/void21847.15.25
      (lambda (c.98)
        (let ((fun/void21848.4 (mref c.98 14)))
          (call L.fun/void21848.4.14 fun/void21848.4))))
    (define L.fun/ascii-char21853.14.24
      (lambda (c.97)
        (let ((fun/ascii-char21854.5 (mref c.97 14)))
          (call L.fun/ascii-char21854.5.15 fun/ascii-char21854.5))))
    (define L.fun/error21845.13.23
      (lambda (c.96)
        (let ((fun/error21846.10 (mref c.96 14)))
          (call L.fun/error21846.10.20 fun/error21846.10))))
    (define L.fun/pair21852.12.22
      (lambda (c.95)
        (let ((cons.75 (mref c.95 14))) (call L.cons.75.10 cons.75 624 2232))))
    (define L.fun/vector21855.11.21
      (lambda (c.94)
        (let ((fun/vector21856.6 (mref c.94 14)))
          (call L.fun/vector21856.6.16 fun/vector21856.6))))
    (define L.fun/error21846.10.20 (lambda (c.93) (let () 59198)))
    (define L.fun/vector21850.9.19
      (lambda (c.92)
        (let ((make-vector.74 (mref c.92 14)))
          (call L.make-vector.74.13 make-vector.74 64))))
    (define L.fun/vector21849.8.18
      (lambda (c.91)
        (let ((fun/vector21850.9 (mref c.91 14)))
          (call L.fun/vector21850.9.19 fun/vector21850.9))))
    (define L.fun/pair21851.7.17
      (lambda (c.90)
        (let ((fun/pair21852.12 (mref c.90 14)))
          (call L.fun/pair21852.12.22 fun/pair21852.12))))
    (define L.fun/vector21856.6.16
      (lambda (c.89)
        (let ((make-vector.74 (mref c.89 14)))
          (call L.make-vector.74.13 make-vector.74 64))))
    (define L.fun/ascii-char21854.5.15 (lambda (c.88) (let () 26670)))
    (define L.fun/void21848.4.14 (lambda (c.87) (let () 30)))
    (define L.make-vector.74.13
      (lambda (c.86 tmp.50)
        (let ((make-init-vector.1 (mref c.86 14)))
          (if (let ((tmp.122
                     (if (let ((tmp.123 (bitwise-and tmp.50 7))) (= tmp.123 0))
                       14
                       6)))
                (!= tmp.122 6))
            (call L.make-init-vector.1.12 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.12
      (lambda (c.85 tmp.22)
        (let ((vector-init-loop.24 (mref c.85 14)))
          (let ((tmp.23
                 (let ((tmp.100
                        (let ((tmp.124
                               (let ((tmp.125
                                      (let ((tmp.126
                                             (let ((tmp.127
                                                    (arithmetic-shift-right
                                                     tmp.22
                                                     3)))
                                               (+ 1 tmp.127))))
                                        (* tmp.126 8))))
                                 (alloc tmp.125))))
                          (+ tmp.124 3))))
                   (begin (mset! tmp.100 -3 tmp.22) tmp.100))))
            (call
             L.vector-init-loop.24.11
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.11
      (lambda (c.84 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (mref c.84 14)))
          (if (let ((tmp.128 (if (= len.25 i.27) 14 6))) (!= tmp.128 6))
            vec.26
            (begin
              (let ((tmp.129
                     (let ((tmp.130
                            (let ((tmp.131 (arithmetic-shift-right i.27 3)))
                              (* tmp.131 8))))
                       (+ tmp.130 5))))
                (mset! vec.26 tmp.129 0))
              (let ((tmp.132 (+ i.27 8)))
                (call
                 L.vector-init-loop.24.11
                 vector-init-loop.24
                 len.25
                 tmp.132
                 vec.26)))))))
    (define L.cons.75.10
      (lambda (c.83 tmp.69 tmp.70)
        (let ()
          (let ((tmp.101 (let ((tmp.133 (alloc 16))) (+ tmp.133 1))))
            (begin
              (mset! tmp.101 -1 tmp.69)
              (mset! tmp.101 7 tmp.70)
              tmp.101)))))
    (define L.-.76.9
      (lambda (c.82 tmp.40 tmp.41)
        (let ()
          (if (let ((tmp.134
                     (if (let ((tmp.135 (bitwise-and tmp.41 7))) (= tmp.135 0))
                       14
                       6)))
                (!= tmp.134 6))
            (if (let ((tmp.136
                       (if (let ((tmp.137 (bitwise-and tmp.40 7)))
                             (= tmp.137 0))
                         14
                         6)))
                  (!= tmp.136 6))
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.*.77.8
      (lambda (c.81 tmp.36 tmp.37)
        (let ()
          (if (let ((tmp.138
                     (if (let ((tmp.139 (bitwise-and tmp.37 7))) (= tmp.139 0))
                       14
                       6)))
                (!= tmp.138 6))
            (if (let ((tmp.140
                       (if (let ((tmp.141 (bitwise-and tmp.36 7)))
                             (= tmp.141 0))
                         14
                         6)))
                  (!= tmp.140 6))
              (let ((tmp.142 (arithmetic-shift-right tmp.37 3)))
                (* tmp.36 tmp.142))
              318)
            318))))
    (define L.+.78.7
      (lambda (c.80 tmp.38 tmp.39)
        (let ()
          (if (let ((tmp.143
                     (if (let ((tmp.144 (bitwise-and tmp.39 7))) (= tmp.144 0))
                       14
                       6)))
                (!= tmp.143 6))
            (if (let ((tmp.145
                       (if (let ((tmp.146 (bitwise-and tmp.38 7)))
                             (= tmp.146 0))
                         14
                         6)))
                  (!= tmp.145 6))
              (+ tmp.38 tmp.39)
              574)
            574))))
    (let ((|+.78|
           (let ((tmp.102 (let ((tmp.147 (alloc 16))) (+ tmp.147 2))))
             (begin (mset! tmp.102 -2 L.+.78.7) (mset! tmp.102 6 16) tmp.102)))
          (*.77
           (let ((tmp.103 (let ((tmp.148 (alloc 16))) (+ tmp.148 2))))
             (begin (mset! tmp.103 -2 L.*.77.8) (mset! tmp.103 6 16) tmp.103)))
          (|-.76|
           (let ((tmp.104 (let ((tmp.149 (alloc 16))) (+ tmp.149 2))))
             (begin (mset! tmp.104 -2 L.-.76.9) (mset! tmp.104 6 16) tmp.104)))
          (cons.75
           (let ((tmp.105 (let ((tmp.150 (alloc 16))) (+ tmp.150 2))))
             (begin
               (mset! tmp.105 -2 L.cons.75.10)
               (mset! tmp.105 6 16)
               tmp.105)))
          (vector-init-loop.24
           (let ((tmp.106 (let ((tmp.151 (alloc 24))) (+ tmp.151 2))))
             (begin
               (mset! tmp.106 -2 L.vector-init-loop.24.11)
               (mset! tmp.106 6 24)
               tmp.106)))
          (make-init-vector.1
           (let ((tmp.107 (let ((tmp.152 (alloc 24))) (+ tmp.152 2))))
             (begin
               (mset! tmp.107 -2 L.make-init-vector.1.12)
               (mset! tmp.107 6 8)
               tmp.107)))
          (make-vector.74
           (let ((tmp.108 (let ((tmp.153 (alloc 24))) (+ tmp.153 2))))
             (begin
               (mset! tmp.108 -2 L.make-vector.74.13)
               (mset! tmp.108 6 8)
               tmp.108)))
          (fun/void21848.4
           (let ((tmp.109 (let ((tmp.154 (alloc 16))) (+ tmp.154 2))))
             (begin
               (mset! tmp.109 -2 L.fun/void21848.4.14)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/ascii-char21854.5
           (let ((tmp.110 (let ((tmp.155 (alloc 16))) (+ tmp.155 2))))
             (begin
               (mset! tmp.110 -2 L.fun/ascii-char21854.5.15)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/vector21856.6
           (let ((tmp.111 (let ((tmp.156 (alloc 24))) (+ tmp.156 2))))
             (begin
               (mset! tmp.111 -2 L.fun/vector21856.6.16)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/pair21851.7
           (let ((tmp.112 (let ((tmp.157 (alloc 24))) (+ tmp.157 2))))
             (begin
               (mset! tmp.112 -2 L.fun/pair21851.7.17)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/vector21849.8
           (let ((tmp.113 (let ((tmp.158 (alloc 24))) (+ tmp.158 2))))
             (begin
               (mset! tmp.113 -2 L.fun/vector21849.8.18)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/vector21850.9
           (let ((tmp.114 (let ((tmp.159 (alloc 24))) (+ tmp.159 2))))
             (begin
               (mset! tmp.114 -2 L.fun/vector21850.9.19)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/error21846.10
           (let ((tmp.115 (let ((tmp.160 (alloc 16))) (+ tmp.160 2))))
             (begin
               (mset! tmp.115 -2 L.fun/error21846.10.20)
               (mset! tmp.115 6 0)
               tmp.115)))
          (fun/vector21855.11
           (let ((tmp.116 (let ((tmp.161 (alloc 24))) (+ tmp.161 2))))
             (begin
               (mset! tmp.116 -2 L.fun/vector21855.11.21)
               (mset! tmp.116 6 0)
               tmp.116)))
          (fun/pair21852.12
           (let ((tmp.117 (let ((tmp.162 (alloc 24))) (+ tmp.162 2))))
             (begin
               (mset! tmp.117 -2 L.fun/pair21852.12.22)
               (mset! tmp.117 6 0)
               tmp.117)))
          (fun/error21845.13
           (let ((tmp.118 (let ((tmp.163 (alloc 24))) (+ tmp.163 2))))
             (begin
               (mset! tmp.118 -2 L.fun/error21845.13.23)
               (mset! tmp.118 6 0)
               tmp.118)))
          (fun/ascii-char21853.14
           (let ((tmp.119 (let ((tmp.164 (alloc 24))) (+ tmp.164 2))))
             (begin
               (mset! tmp.119 -2 L.fun/ascii-char21853.14.24)
               (mset! tmp.119 6 0)
               tmp.119)))
          (fun/void21847.15
           (let ((tmp.120 (let ((tmp.165 (alloc 24))) (+ tmp.165 2))))
             (begin
               (mset! tmp.120 -2 L.fun/void21847.15.25)
               (mset! tmp.120 6 0)
               tmp.120))))
      (begin
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.1 14 vector-init-loop.24)
        (mset! make-vector.74 14 make-init-vector.1)
        (mset! fun/vector21856.6 14 make-vector.74)
        (mset! fun/pair21851.7 14 fun/pair21852.12)
        (mset! fun/vector21849.8 14 fun/vector21850.9)
        (mset! fun/vector21850.9 14 make-vector.74)
        (mset! fun/vector21855.11 14 fun/vector21856.6)
        (mset! fun/pair21852.12 14 cons.75)
        (mset! fun/error21845.13 14 fun/error21846.10)
        (mset! fun/ascii-char21853.14 14 fun/ascii-char21854.5)
        (mset! fun/void21847.15 14 fun/void21848.4)
        (let ((error0.21 (call L.fun/error21845.13.23 fun/error21845.13))
              (void1.20 (call L.fun/void21847.15.25 fun/void21847.15))
              (vector2.19 (call L.fun/vector21849.8.18 fun/vector21849.8))
              (procedure3.18
               (let ((lam.79
                      (let ((tmp.121
                             (let ((tmp.166 (alloc 24))) (+ tmp.166 2))))
                        (begin
                          (mset! tmp.121 -2 L.lam.79.26)
                          (mset! tmp.121 6 0)
                          tmp.121))))
                 (begin (mset! lam.79 14 fun/pair21851.7) lam.79)))
              (ascii-char4.17
               (call L.fun/ascii-char21853.14.24 fun/ascii-char21853.14))
              (fixnum5.16
               (let ((tmp.167
                      (let ((tmp.168
                             (let ((tmp.169 (call L.-.76.9 |-.76| 656 528)))
                               (let ((tmp.170 (call L.-.76.9 |-.76| 1168 664)))
                                 (call L.*.77.8 *.77 tmp.169 tmp.170)))))
                        (let ((tmp.171
                               (let ((tmp.172 (call L.+.78.7 |+.78| 640 688)))
                                 (let ((tmp.173
                                        (call L.-.76.9 |-.76| 664 344)))
                                   (call L.+.78.7 |+.78| tmp.172 tmp.173)))))
                          (call L.*.77.8 *.77 tmp.168 tmp.171)))))
                 (let ((tmp.174
                        (let ((tmp.175
                               (let ((tmp.176 (call L.*.77.8 *.77 1408 312)))
                                 (let ((tmp.177
                                        (call L.-.76.9 |-.76| 1896 96)))
                                   (call L.-.76.9 |-.76| tmp.176 tmp.177)))))
                          (let ((tmp.178
                                 (let ((tmp.179
                                        (call L.*.77.8 *.77 1096 1776)))
                                   (let ((tmp.180
                                          (call L.-.76.9 |-.76| 1024 856)))
                                     (call L.-.76.9 |-.76| tmp.179 tmp.180)))))
                            (call L.*.77.8 *.77 tmp.175 tmp.178)))))
                   (call L.*.77.8 *.77 tmp.167 tmp.174)))))
          (call L.fun/vector21855.11.21 fun/vector21855.11))))))
(check-by-interp
 '(module
    (define L.lam.75.22
      (lambda (c.91)
        (let ((fun/vector10024.14 (mref c.91 14)))
          (call L.fun/vector10024.14.20 fun/vector10024.14))))
    (define L.fun/void10032.15.21
      (lambda (c.90)
        (let ((fun/void10033.5 (mref c.90 14)))
          (call L.fun/void10033.5.11 fun/void10033.5))))
    (define L.fun/vector10024.14.20
      (lambda (c.89)
        (let ((fun/vector10025.12 (mref c.89 14)))
          (call L.fun/vector10025.12.18 fun/vector10025.12))))
    (define L.fun/empty10022.13.19
      (lambda (c.88)
        (let ((fun/empty10023.7 (mref c.88 14)))
          (call L.fun/empty10023.7.13 fun/empty10023.7))))
    (define L.fun/vector10025.12.18
      (lambda (c.87)
        (let ((make-vector.74 (mref c.87 14)))
          (call L.make-vector.74.9 make-vector.74 64))))
    (define L.fun/empty10027.11.17 (lambda (c.86) (let () 22)))
    (define L.fun/void10028.10.16
      (lambda (c.85)
        (let ((fun/void10029.8 (mref c.85 14)))
          (call L.fun/void10029.8.14 fun/void10029.8))))
    (define L.fun/vector10031.9.15
      (lambda (c.84)
        (let ((make-vector.74 (mref c.84 14)))
          (call L.make-vector.74.9 make-vector.74 64))))
    (define L.fun/void10029.8.14 (lambda (c.83) (let () 30)))
    (define L.fun/empty10023.7.13 (lambda (c.82) (let () 22)))
    (define L.fun/vector10030.6.12
      (lambda (c.81)
        (let ((fun/vector10031.9 (mref c.81 14)))
          (call L.fun/vector10031.9.15 fun/vector10031.9))))
    (define L.fun/void10033.5.11 (lambda (c.80) (let () 30)))
    (define L.fun/empty10026.4.10
      (lambda (c.79)
        (let ((fun/empty10027.11 (mref c.79 14)))
          (call L.fun/empty10027.11.17 fun/empty10027.11))))
    (define L.make-vector.74.9
      (lambda (c.78 tmp.50)
        (let ((make-init-vector.1 (mref c.78 14)))
          (if (let ((tmp.109
                     (if (let ((tmp.110 (bitwise-and tmp.50 7))) (= tmp.110 0))
                       14
                       6)))
                (!= tmp.109 6))
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.77 tmp.22)
        (let ((vector-init-loop.24 (mref c.77 14)))
          (let ((tmp.23
                 (let ((tmp.92
                        (let ((tmp.111
                               (let ((tmp.112
                                      (let ((tmp.113
                                             (let ((tmp.114
                                                    (arithmetic-shift-right
                                                     tmp.22
                                                     3)))
                                               (+ 1 tmp.114))))
                                        (* tmp.113 8))))
                                 (alloc tmp.112))))
                          (+ tmp.111 3))))
                   (begin (mset! tmp.92 -3 tmp.22) tmp.92))))
            (call
             L.vector-init-loop.24.7
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.7
      (lambda (c.76 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (mref c.76 14)))
          (if (let ((tmp.115 (if (= len.25 i.27) 14 6))) (!= tmp.115 6))
            vec.26
            (begin
              (let ((tmp.116
                     (let ((tmp.117
                            (let ((tmp.118 (arithmetic-shift-right i.27 3)))
                              (* tmp.118 8))))
                       (+ tmp.117 5))))
                (mset! vec.26 tmp.116 0))
              (let ((tmp.119 (+ i.27 8)))
                (call
                 L.vector-init-loop.24.7
                 vector-init-loop.24
                 len.25
                 tmp.119
                 vec.26)))))))
    (let ((vector-init-loop.24
           (let ((tmp.93 (let ((tmp.120 (alloc 24))) (+ tmp.120 2))))
             (begin
               (mset! tmp.93 -2 L.vector-init-loop.24.7)
               (mset! tmp.93 6 24)
               tmp.93)))
          (make-init-vector.1
           (let ((tmp.94 (let ((tmp.121 (alloc 24))) (+ tmp.121 2))))
             (begin
               (mset! tmp.94 -2 L.make-init-vector.1.8)
               (mset! tmp.94 6 8)
               tmp.94)))
          (make-vector.74
           (let ((tmp.95 (let ((tmp.122 (alloc 24))) (+ tmp.122 2))))
             (begin
               (mset! tmp.95 -2 L.make-vector.74.9)
               (mset! tmp.95 6 8)
               tmp.95)))
          (fun/empty10026.4
           (let ((tmp.96 (let ((tmp.123 (alloc 24))) (+ tmp.123 2))))
             (begin
               (mset! tmp.96 -2 L.fun/empty10026.4.10)
               (mset! tmp.96 6 0)
               tmp.96)))
          (fun/void10033.5
           (let ((tmp.97 (let ((tmp.124 (alloc 16))) (+ tmp.124 2))))
             (begin
               (mset! tmp.97 -2 L.fun/void10033.5.11)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/vector10030.6
           (let ((tmp.98 (let ((tmp.125 (alloc 24))) (+ tmp.125 2))))
             (begin
               (mset! tmp.98 -2 L.fun/vector10030.6.12)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/empty10023.7
           (let ((tmp.99 (let ((tmp.126 (alloc 16))) (+ tmp.126 2))))
             (begin
               (mset! tmp.99 -2 L.fun/empty10023.7.13)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/void10029.8
           (let ((tmp.100 (let ((tmp.127 (alloc 16))) (+ tmp.127 2))))
             (begin
               (mset! tmp.100 -2 L.fun/void10029.8.14)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/vector10031.9
           (let ((tmp.101 (let ((tmp.128 (alloc 24))) (+ tmp.128 2))))
             (begin
               (mset! tmp.101 -2 L.fun/vector10031.9.15)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/void10028.10
           (let ((tmp.102 (let ((tmp.129 (alloc 24))) (+ tmp.129 2))))
             (begin
               (mset! tmp.102 -2 L.fun/void10028.10.16)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/empty10027.11
           (let ((tmp.103 (let ((tmp.130 (alloc 16))) (+ tmp.130 2))))
             (begin
               (mset! tmp.103 -2 L.fun/empty10027.11.17)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/vector10025.12
           (let ((tmp.104 (let ((tmp.131 (alloc 24))) (+ tmp.131 2))))
             (begin
               (mset! tmp.104 -2 L.fun/vector10025.12.18)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/empty10022.13
           (let ((tmp.105 (let ((tmp.132 (alloc 24))) (+ tmp.132 2))))
             (begin
               (mset! tmp.105 -2 L.fun/empty10022.13.19)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/vector10024.14
           (let ((tmp.106 (let ((tmp.133 (alloc 24))) (+ tmp.133 2))))
             (begin
               (mset! tmp.106 -2 L.fun/vector10024.14.20)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/void10032.15
           (let ((tmp.107 (let ((tmp.134 (alloc 24))) (+ tmp.134 2))))
             (begin
               (mset! tmp.107 -2 L.fun/void10032.15.21)
               (mset! tmp.107 6 0)
               tmp.107))))
      (begin
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.1 14 vector-init-loop.24)
        (mset! make-vector.74 14 make-init-vector.1)
        (mset! fun/empty10026.4 14 fun/empty10027.11)
        (mset! fun/vector10030.6 14 fun/vector10031.9)
        (mset! fun/vector10031.9 14 make-vector.74)
        (mset! fun/void10028.10 14 fun/void10029.8)
        (mset! fun/vector10025.12 14 make-vector.74)
        (mset! fun/empty10022.13 14 fun/empty10023.7)
        (mset! fun/vector10024.14 14 fun/vector10025.12)
        (mset! fun/void10032.15 14 fun/void10033.5)
        (let ((empty0.21 (call L.fun/empty10022.13.19 fun/empty10022.13))
              (procedure1.20
               (let ((lam.75
                      (let ((tmp.108
                             (let ((tmp.135 (alloc 24))) (+ tmp.135 2))))
                        (begin
                          (mset! tmp.108 -2 L.lam.75.22)
                          (mset! tmp.108 6 0)
                          tmp.108))))
                 (begin (mset! lam.75 14 fun/vector10024.14) lam.75)))
              (empty2.19 (call L.fun/empty10026.4.10 fun/empty10026.4))
              (void3.18 (call L.fun/void10028.10.16 fun/void10028.10))
              (vector4.17 (call L.fun/vector10030.6.12 fun/vector10030.6))
              (void5.16 (call L.fun/void10032.15.21 fun/void10032.15)))
          (if (let ((tmp.136
                     (if (let ((tmp.137 (bitwise-and procedure1.20 7)))
                           (= tmp.137 2))
                       14
                       6)))
                (!= tmp.136 6))
            (if (let ((tmp.138
                       (if (let ((tmp.139 (mref procedure1.20 6)))
                             (= tmp.139 0))
                         14
                         6)))
                  (!= tmp.138 6))
              (let ((tmp.140 (mref procedure1.20 -2)))
                (call tmp.140 procedure1.20))
              10814)
            11070))))))
(check-by-interp
 '(module
    (define L.lam.78.23
      (lambda (c.95)
        (let ((fun/error12088.11 (mref c.95 14)))
          (call L.fun/error12088.11.18 fun/error12088.11))))
    (define L.fun/void12098.15.22
      (lambda (c.94)
        (let ((fun/void12099.10 (mref c.94 14)))
          (call L.fun/void12099.10.17 fun/void12099.10))))
    (define L.fun/error12094.14.21
      (lambda (c.93)
        (let ((fun/error12095.6 (mref c.93 14)))
          (call L.fun/error12095.6.13 fun/error12095.6))))
    (define L.fun/error12089.13.20 (lambda (c.92) (let () 29246)))
    (define L.fun/empty12097.12.19 (lambda (c.91) (let () 22)))
    (define L.fun/error12088.11.18
      (lambda (c.90)
        (let ((fun/error12089.13 (mref c.90 14)))
          (call L.fun/error12089.13.20 fun/error12089.13))))
    (define L.fun/void12099.10.17 (lambda (c.89) (let () 30)))
    (define L.fun/any12093.9.16 (lambda (c.88) (let () 30)))
    (define L.fun/empty12091.8.15 (lambda (c.87) (let () 22)))
    (define L.fun/empty12096.7.14
      (lambda (c.86)
        (let ((fun/empty12097.12 (mref c.86 14)))
          (call L.fun/empty12097.12.19 fun/empty12097.12))))
    (define L.fun/error12095.6.13 (lambda (c.85) (let () 11582)))
    (define L.fun/empty12090.5.12
      (lambda (c.84)
        (let ((fun/empty12091.8 (mref c.84 14)))
          (call L.fun/empty12091.8.15 fun/empty12091.8))))
    (define L.fun/any12092.4.11
      (lambda (c.83)
        (let ((fun/any12093.9 (mref c.83 14)))
          (call L.fun/any12093.9.16 fun/any12093.9))))
    (define L.-.74.10
      (lambda (c.82 tmp.40 tmp.41)
        (let ()
          (if (let ((tmp.113
                     (if (let ((tmp.114 (bitwise-and tmp.41 7))) (= tmp.114 0))
                       14
                       6)))
                (!= tmp.113 6))
            (if (let ((tmp.115
                       (if (let ((tmp.116 (bitwise-and tmp.40 7)))
                             (= tmp.116 0))
                         14
                         6)))
                  (!= tmp.115 6))
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.+.75.9
      (lambda (c.81 tmp.38 tmp.39)
        (let ()
          (if (let ((tmp.117
                     (if (let ((tmp.118 (bitwise-and tmp.39 7))) (= tmp.118 0))
                       14
                       6)))
                (!= tmp.117 6))
            (if (let ((tmp.119
                       (if (let ((tmp.120 (bitwise-and tmp.38 7)))
                             (= tmp.120 0))
                         14
                         6)))
                  (!= tmp.119 6))
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.*.76.8
      (lambda (c.80 tmp.36 tmp.37)
        (let ()
          (if (let ((tmp.121
                     (if (let ((tmp.122 (bitwise-and tmp.37 7))) (= tmp.122 0))
                       14
                       6)))
                (!= tmp.121 6))
            (if (let ((tmp.123
                       (if (let ((tmp.124 (bitwise-and tmp.36 7)))
                             (= tmp.124 0))
                         14
                         6)))
                  (!= tmp.123 6))
              (let ((tmp.125 (arithmetic-shift-right tmp.37 3)))
                (* tmp.36 tmp.125))
              318)
            318))))
    (define L.fixnum?.77.7
      (lambda (c.79 tmp.59)
        (let ()
          (if (let ((tmp.126 (bitwise-and tmp.59 7))) (= tmp.126 0)) 14 6))))
    (let ((fixnum?.77
           (let ((tmp.96 (let ((tmp.127 (alloc 16))) (+ tmp.127 2))))
             (begin
               (mset! tmp.96 -2 L.fixnum?.77.7)
               (mset! tmp.96 6 8)
               tmp.96)))
          (*.76
           (let ((tmp.97 (let ((tmp.128 (alloc 16))) (+ tmp.128 2))))
             (begin (mset! tmp.97 -2 L.*.76.8) (mset! tmp.97 6 16) tmp.97)))
          (|+.75|
           (let ((tmp.98 (let ((tmp.129 (alloc 16))) (+ tmp.129 2))))
             (begin (mset! tmp.98 -2 L.+.75.9) (mset! tmp.98 6 16) tmp.98)))
          (|-.74|
           (let ((tmp.99 (let ((tmp.130 (alloc 16))) (+ tmp.130 2))))
             (begin (mset! tmp.99 -2 L.-.74.10) (mset! tmp.99 6 16) tmp.99)))
          (fun/any12092.4
           (let ((tmp.100 (let ((tmp.131 (alloc 24))) (+ tmp.131 2))))
             (begin
               (mset! tmp.100 -2 L.fun/any12092.4.11)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/empty12090.5
           (let ((tmp.101 (let ((tmp.132 (alloc 24))) (+ tmp.132 2))))
             (begin
               (mset! tmp.101 -2 L.fun/empty12090.5.12)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/error12095.6
           (let ((tmp.102 (let ((tmp.133 (alloc 16))) (+ tmp.133 2))))
             (begin
               (mset! tmp.102 -2 L.fun/error12095.6.13)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/empty12096.7
           (let ((tmp.103 (let ((tmp.134 (alloc 24))) (+ tmp.134 2))))
             (begin
               (mset! tmp.103 -2 L.fun/empty12096.7.14)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/empty12091.8
           (let ((tmp.104 (let ((tmp.135 (alloc 16))) (+ tmp.135 2))))
             (begin
               (mset! tmp.104 -2 L.fun/empty12091.8.15)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/any12093.9
           (let ((tmp.105 (let ((tmp.136 (alloc 16))) (+ tmp.136 2))))
             (begin
               (mset! tmp.105 -2 L.fun/any12093.9.16)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/void12099.10
           (let ((tmp.106 (let ((tmp.137 (alloc 16))) (+ tmp.137 2))))
             (begin
               (mset! tmp.106 -2 L.fun/void12099.10.17)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/error12088.11
           (let ((tmp.107 (let ((tmp.138 (alloc 24))) (+ tmp.138 2))))
             (begin
               (mset! tmp.107 -2 L.fun/error12088.11.18)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/empty12097.12
           (let ((tmp.108 (let ((tmp.139 (alloc 16))) (+ tmp.139 2))))
             (begin
               (mset! tmp.108 -2 L.fun/empty12097.12.19)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/error12089.13
           (let ((tmp.109 (let ((tmp.140 (alloc 16))) (+ tmp.140 2))))
             (begin
               (mset! tmp.109 -2 L.fun/error12089.13.20)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/error12094.14
           (let ((tmp.110 (let ((tmp.141 (alloc 24))) (+ tmp.141 2))))
             (begin
               (mset! tmp.110 -2 L.fun/error12094.14.21)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/void12098.15
           (let ((tmp.111 (let ((tmp.142 (alloc 24))) (+ tmp.142 2))))
             (begin
               (mset! tmp.111 -2 L.fun/void12098.15.22)
               (mset! tmp.111 6 0)
               tmp.111))))
      (begin
        (mset! fun/any12092.4 14 fun/any12093.9)
        (mset! fun/empty12090.5 14 fun/empty12091.8)
        (mset! fun/empty12096.7 14 fun/empty12097.12)
        (mset! fun/error12088.11 14 fun/error12089.13)
        (mset! fun/error12094.14 14 fun/error12095.6)
        (mset! fun/void12098.15 14 fun/void12099.10)
        (let ((procedure0.21
               (let ((lam.78
                      (let ((tmp.112
                             (let ((tmp.143 (alloc 24))) (+ tmp.143 2))))
                        (begin
                          (mset! tmp.112 -2 L.lam.78.23)
                          (mset! tmp.112 6 0)
                          tmp.112))))
                 (begin (mset! lam.78 14 fun/error12088.11) lam.78)))
              (fixnum1.20
               (let ((tmp.144
                      (let ((tmp.145
                             (let ((tmp.146 (call L.-.74.10 |-.74| 432 1328)))
                               (let ((tmp.147 (call L.+.75.9 |+.75| 1168 952)))
                                 (call L.-.74.10 |-.74| tmp.146 tmp.147)))))
                        (let ((tmp.148
                               (let ((tmp.149
                                      (call L.-.74.10 |-.74| 1472 168)))
                                 (let ((tmp.150 (call L.*.76.8 *.76 64 2024)))
                                   (call L.-.74.10 |-.74| tmp.149 tmp.150)))))
                          (call L.*.76.8 *.76 tmp.145 tmp.148)))))
                 (let ((tmp.151
                        (let ((tmp.152
                               (let ((tmp.153
                                      (call L.-.74.10 |-.74| 1672 760)))
                                 (let ((tmp.154
                                        (call L.+.75.9 |+.75| 240 1968)))
                                   (call L.+.75.9 |+.75| tmp.153 tmp.154)))))
                          (let ((tmp.155
                                 (let ((tmp.156
                                        (call L.+.75.9 |+.75| 544 696)))
                                   (let ((tmp.157
                                          (call L.-.74.10 |-.74| 1528 1904)))
                                     (call L.*.76.8 *.76 tmp.156 tmp.157)))))
                            (call L.-.74.10 |-.74| tmp.152 tmp.155)))))
                   (call L.-.74.10 |-.74| tmp.144 tmp.151))))
              (empty2.19 (call L.fun/empty12090.5.12 fun/empty12090.5))
              (boolean3.18
               (let ((tmp.158 (call L.fun/any12092.4.11 fun/any12092.4)))
                 (call L.fixnum?.77.7 fixnum?.77 tmp.158)))
              (error4.17 (call L.fun/error12094.14.21 fun/error12094.14))
              (empty5.16 (call L.fun/empty12096.7.14 fun/empty12096.7)))
          (call L.fun/void12098.15.22 fun/void12098.15))))))
