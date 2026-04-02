#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         "../remove-complex-opera*.rkt")
(define (fail-if-invalid p)
  (when (not (values-bits-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "values-bits-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-exprs-bits-lang-v8 p)
  (interp-values-bits-lang-v8 (fail-if-invalid (remove-complex-opera* p)))))

(check-by-interp '(module 1384))
(check-by-interp '(module 1912))
(check-by-interp
 '(module
    (define L.fun/error8447.4.7 (lambda (c.57) (let () 59710)))
    (let ((fun/error8447.4
           (let ((tmp.58 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.58 -2 L.fun/error8447.4.7)
               (mset! tmp.58 6 0)
               tmp.58))))
      (call L.fun/error8447.4.7 fun/error8447.4))))
(check-by-interp
 '(module
    (define L.fun/fixnum8450.4.7 (lambda (c.57) (let () 288)))
    (let ((fun/fixnum8450.4
           (let ((tmp.58 (+ (alloc 16) 2)))
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
          (if (!= (if (= (bitwise-and tmp.33 7) 0) 14 6) 6)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.33)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.59 tmp.5)
        (let ((vector-init-loop.7 (mref c.59 14)))
          (let ((tmp.6
                 (let ((tmp.62
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.5 3)) 8))
                         3)))
                   (begin (mset! tmp.62 -3 tmp.5) tmp.62))))
            (call L.vector-init-loop.7.7 vector-init-loop.7 tmp.5 0 tmp.6)))))
    (define L.vector-init-loop.7.7
      (lambda (c.58 len.8 i.10 vec.9)
        (let ((vector-init-loop.7 (mref c.58 14)))
          (if (!= (if (= len.8 i.10) 14 6) 6)
            vec.9
            (begin
              (mset! vec.9 (+ (* (arithmetic-shift-right i.10 3) 8) 5) 0)
              (call
               L.vector-init-loop.7.7
               vector-init-loop.7
               len.8
               (+ i.10 8)
               vec.9))))))
    (let ((vector-init-loop.7
           (let ((tmp.63 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.63 -2 L.vector-init-loop.7.7)
               (mset! tmp.63 6 24)
               tmp.63)))
          (make-init-vector.1
           (let ((tmp.64 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.64 -2 L.make-init-vector.1.8)
               (mset! tmp.64 6 8)
               tmp.64)))
          (make-vector.57
           (let ((tmp.65 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.65 -2 L.make-vector.57.9)
               (mset! tmp.65 6 8)
               tmp.65)))
          (fun/vector8453.4
           (let ((tmp.66 (+ (alloc 24) 2)))
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
           (let ((tmp.58 (+ (alloc 16) 2)))
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
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.37)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.63 tmp.9)
        (let ((vector-init-loop.11 (mref c.63 14)))
          (let ((tmp.10
                 (let ((tmp.67
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.9 3)) 8))
                         3)))
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
          (if (!= (if (= len.12 i.14) 14 6) 6)
            vec.13
            (begin
              (mset! vec.13 (+ (* (arithmetic-shift-right i.14 3) 8) 5) 0)
              (call
               L.vector-init-loop.11.7
               vector-init-loop.11
               len.12
               (+ i.14 8)
               vec.13))))))
    (let ((vector-init-loop.11
           (let ((tmp.68 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.68 -2 L.vector-init-loop.11.7)
               (mset! tmp.68 6 24)
               tmp.68)))
          (make-init-vector.1
           (let ((tmp.69 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.69 -2 L.make-init-vector.1.8)
               (mset! tmp.69 6 8)
               tmp.69)))
          (make-vector.61
           (let ((tmp.70 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.70 -2 L.make-vector.61.9)
               (mset! tmp.70 6 8)
               tmp.70)))
          (fun/error8470.4
           (let ((tmp.71 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.71 -2 L.fun/error8470.4.10)
               (mset! tmp.71 6 8)
               tmp.71)))
          (fun/error8471.5
           (let ((tmp.72 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.72 -2 L.fun/error8471.5.11)
               (mset! tmp.72 6 0)
               tmp.72))))
      (begin
        (mset! vector-init-loop.11 14 vector-init-loop.11)
        (mset! make-init-vector.1 14 vector-init-loop.11)
        (mset! make-vector.61 14 make-init-vector.1)
        (mset! fun/error8470.4 14 fun/error8471.5)
        (call
         L.fun/error8470.4.10
         fun/error8470.4
         (let ((fixnum0.8 2000)
               (vector1.7 (call L.make-vector.61.9 make-vector.61 64)))
           1088))))))
(check-by-interp
 '(module
    (define L.fun/void8475.5.8 (lambda (c.61 oprand0.7) (let () 30)))
    (define L.fun/ascii-char8474.4.7 (lambda (c.60 oprand0.6) (let () 22062)))
    (let ((fun/ascii-char8474.4
           (let ((tmp.62 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.62 -2 L.fun/ascii-char8474.4.7)
               (mset! tmp.62 6 8)
               tmp.62)))
          (fun/void8475.5
           (let ((tmp.63 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.63 -2 L.fun/void8475.5.8)
               (mset! tmp.63 6 8)
               tmp.63))))
      (call
       L.fun/ascii-char8474.4.7
       fun/ascii-char8474.4
       (call L.fun/void8475.5.8 fun/void8475.5 14)))))
(check-by-interp
 '(module
    (define L.fun/empty8478.4.7 (lambda (c.60 oprand0.5) (let () 22)))
    (let ((fun/empty8478.4
           (let ((tmp.61 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.61 -2 L.fun/empty8478.4.7)
               (mset! tmp.61 6 8)
               tmp.61))))
      (call
       L.fun/empty8478.4.7
       fun/empty8478.4
       (let ((error0.7 13630) (error1.6 50238)) 22)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8481.4.7 (lambda (c.58 oprand0.5) (let () 23598)))
    (let ((fun/ascii-char8481.4
           (let ((tmp.59 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.59 -2 L.fun/ascii-char8481.4.7)
               (mset! tmp.59 6 8)
               tmp.59))))
      (call
       L.fun/ascii-char8481.4.7
       fun/ascii-char8481.4
       (if (!= 6 6) 22 22)))))
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
          (let ((tmp.71 (+ (alloc 16) 1)))
            (begin (mset! tmp.71 -1 tmp.58) (mset! tmp.71 7 tmp.59) tmp.71)))))
    (define L.*.64.8
      (lambda (c.67 tmp.25 tmp.26)
        (let ()
          (if (!= (if (= (bitwise-and tmp.26 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
              (* tmp.25 (arithmetic-shift-right tmp.26 3))
              318)
            318))))
    (define L.ascii-char?.65.7
      (lambda (c.66 tmp.52)
        (let () (if (= (bitwise-and tmp.52 255) 46) 14 6))))
    (let ((ascii-char?.65
           (let ((tmp.72 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.72 -2 L.ascii-char?.65.7)
               (mset! tmp.72 6 8)
               tmp.72)))
          (*.64
           (let ((tmp.73 (+ (alloc 16) 2)))
             (begin (mset! tmp.73 -2 L.*.64.8) (mset! tmp.73 6 16) tmp.73)))
          (cons.63
           (let ((tmp.74 (+ (alloc 16) 2)))
             (begin (mset! tmp.74 -2 L.cons.63.9) (mset! tmp.74 6 16) tmp.74)))
          (fun/pair8495.4
           (let ((tmp.75 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.75 -2 L.fun/pair8495.4.10)
               (mset! tmp.75 6 16)
               tmp.75)))
          (fun/pair8496.5
           (let ((tmp.76 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.76 -2 L.fun/pair8496.5.11)
               (mset! tmp.76 6 0)
               tmp.76))))
      (begin
        (mset! fun/pair8495.4 14 fun/pair8496.5)
        (mset! fun/pair8496.5 14 cons.63)
        (call
         L.fun/pair8495.4.10
         fun/pair8495.4
         (call
          L.*.64.8
          *.64
          (call L.*.64.8 *.64 960 800)
          (let ((ascii-char0.10 19758) (boolean1.9 14) (boolean2.8 14)) 1568))
         (call L.ascii-char?.65.7 ascii-char?.65 (if (!= 14 6) 24110 30)))))))
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
          (let ((tmp.85 (+ (alloc 16) 1)))
            (begin (mset! tmp.85 -1 tmp.68) (mset! tmp.85 7 tmp.69) tmp.85)))))
    (define L.make-vector.74.9
      (lambda (c.77 tmp.49)
        (let ((make-init-vector.1 (mref c.77 14)))
          (if (!= (if (= (bitwise-and tmp.49 7) 0) 14 6) 6)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.49)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.76 tmp.21)
        (let ((vector-init-loop.23 (mref c.76 14)))
          (let ((tmp.22
                 (let ((tmp.86
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.21 3)) 8))
                         3)))
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
          (if (!= (if (= len.24 i.26) 14 6) 6)
            vec.25
            (begin
              (mset! vec.25 (+ (* (arithmetic-shift-right i.26 3) 8) 5) 0)
              (call
               L.vector-init-loop.23.7
               vector-init-loop.23
               len.24
               (+ i.26 8)
               vec.25))))))
    (let ((vector-init-loop.23
           (let ((tmp.87 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.87 -2 L.vector-init-loop.23.7)
               (mset! tmp.87 6 24)
               tmp.87)))
          (make-init-vector.1
           (let ((tmp.88 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.88 -2 L.make-init-vector.1.8)
               (mset! tmp.88 6 8)
               tmp.88)))
          (make-vector.74
           (let ((tmp.89 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.89 -2 L.make-vector.74.9)
               (mset! tmp.89 6 8)
               tmp.89)))
          (cons.73
           (let ((tmp.90 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.90 -2 L.cons.73.10)
               (mset! tmp.90 6 16)
               tmp.90)))
          (fun/pair8508.4
           (let ((tmp.91 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.91 -2 L.fun/pair8508.4.11)
               (mset! tmp.91 6 16)
               tmp.91)))
          (fun/pair8509.5
           (let ((tmp.92 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.92 -2 L.fun/pair8509.5.12)
               (mset! tmp.92 6 0)
               tmp.92)))
          (fun/empty8511.6
           (let ((tmp.93 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.93 -2 L.fun/empty8511.6.13)
               (mset! tmp.93 6 16)
               tmp.93)))
          (fun/void8507.7
           (let ((tmp.94 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.94 -2 L.fun/void8507.7.14)
               (mset! tmp.94 6 0)
               tmp.94)))
          (fun/error8510.8
           (let ((tmp.95 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.95 -2 L.fun/error8510.8.15)
               (mset! tmp.95 6 16)
               tmp.95)))
          (fun/void8506.9
           (let ((tmp.96 (+ (alloc 24) 2)))
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
        (call
         L.fun/void8506.9.16
         fun/void8506.9
         (let ((ascii-char0.20 27182)
               (vector1.19 (call L.make-vector.74.9 make-vector.74 64))
               (boolean2.18 14))
           37694)
         (call
          L.fun/pair8508.4.11
          fun/pair8508.4
          (call L.fun/error8510.8.15 fun/error8510.8 30 30)
          (call L.fun/empty8511.6.13 fun/empty8511.6 36414 17198)))))))
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
          (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.38)
            2110))))
    (define L.make-init-vector.1.10
      (lambda (c.68 tmp.10)
        (let ((vector-init-loop.12 (mref c.68 14)))
          (let ((tmp.11
                 (let ((tmp.73
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.10 3)) 8))
                         3)))
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
          (if (!= (if (= len.13 i.15) 14 6) 6)
            vec.14
            (begin
              (mset! vec.14 (+ (* (arithmetic-shift-right i.15 3) 8) 5) 0)
              (call
               L.vector-init-loop.12.9
               vector-init-loop.12
               len.13
               (+ i.15 8)
               vec.14))))))
    (define L.cons.63.8
      (lambda (c.66 tmp.57 tmp.58)
        (let ()
          (let ((tmp.74 (+ (alloc 16) 1)))
            (begin (mset! tmp.74 -1 tmp.57) (mset! tmp.74 7 tmp.58) tmp.74)))))
    (define L.boolean?.64.7
      (lambda (c.65 tmp.48) (let () (if (= (bitwise-and tmp.48 247) 6) 14 6))))
    (let ((boolean?.64
           (let ((tmp.75 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.75 -2 L.boolean?.64.7)
               (mset! tmp.75 6 8)
               tmp.75)))
          (cons.63
           (let ((tmp.76 (+ (alloc 16) 2)))
             (begin (mset! tmp.76 -2 L.cons.63.8) (mset! tmp.76 6 16) tmp.76)))
          (vector-init-loop.12
           (let ((tmp.77 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.77 -2 L.vector-init-loop.12.9)
               (mset! tmp.77 6 24)
               tmp.77)))
          (make-init-vector.1
           (let ((tmp.78 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.78 -2 L.make-init-vector.1.10)
               (mset! tmp.78 6 8)
               tmp.78)))
          (make-vector.62
           (let ((tmp.79 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.79 -2 L.make-vector.62.11)
               (mset! tmp.79 6 8)
               tmp.79)))
          (fun/empty8535.4
           (let ((tmp.80 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.80 -2 L.fun/empty8535.4.12)
               (mset! tmp.80 6 0)
               tmp.80)))
          (fun/empty8537.5
           (let ((tmp.81 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.81 -2 L.fun/empty8537.5.13)
               (mset! tmp.81 6 0)
               tmp.81)))
          (fun/vector8536.6
           (let ((tmp.82 (+ (alloc 24) 2)))
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
               (call
                L.boolean?.64.7
                boolean?.64
                (call L.cons.63.8 cons.63 640 3312)))
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
          (let ((tmp.74 (+ (alloc 16) 1)))
            (begin (mset! tmp.74 -1 tmp.62) (mset! tmp.74 7 tmp.63) tmp.74)))))
    (let ((cons.67
           (let ((tmp.75 (+ (alloc 16) 2)))
             (begin (mset! tmp.75 -2 L.cons.67.7) (mset! tmp.75 6 16) tmp.75)))
          (fun/pair8561.4
           (let ((tmp.76 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.76 -2 L.fun/pair8561.4.8)
               (mset! tmp.76 6 0)
               tmp.76)))
          (fun/ascii-char8562.5
           (let ((tmp.77 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.77 -2 L.fun/ascii-char8562.5.9)
               (mset! tmp.77 6 16)
               tmp.77)))
          (fun/pair8560.6
           (let ((tmp.78 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.78 -2 L.fun/pair8560.6.10)
               (mset! tmp.78 6 16)
               tmp.78)))
          (fun/ascii-char8563.7
           (let ((tmp.79 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.79 -2 L.fun/ascii-char8563.7.11)
               (mset! tmp.79 6 0)
               tmp.79)))
          (fun/empty8564.8
           (let ((tmp.80 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.80 -2 L.fun/empty8564.8.12)
               (mset! tmp.80 6 16)
               tmp.80))))
      (begin
        (mset! fun/pair8561.4 14 cons.67)
        (mset! fun/ascii-char8562.5 14 fun/ascii-char8563.7)
        (mset! fun/pair8560.6 14 fun/pair8561.4)
        (call
         L.fun/pair8560.6.10
         fun/pair8560.6
         (if (!= 6 6) 488 592)
         (call
          L.fun/ascii-char8562.5.9
          fun/ascii-char8562.5
          (call L.fun/empty8564.8.12 fun/empty8564.8 22 29230)
          (if (!= 14 6) 14 6)))))))
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
          (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.40)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.72 tmp.12)
        (let ((vector-init-loop.14 (mref c.72 14)))
          (let ((tmp.13
                 (let ((tmp.78
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.12 3)) 8))
                         3)))
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
          (if (!= (if (= len.15 i.17) 14 6) 6)
            vec.16
            (begin
              (mset! vec.16 (+ (* (arithmetic-shift-right i.17 3) 8) 5) 0)
              (call
               L.vector-init-loop.14.10
               vector-init-loop.14
               len.15
               (+ i.17 8)
               vec.16))))))
    (define L.*.65.9
      (lambda (c.70 tmp.26 tmp.27)
        (let ()
          (if (!= (if (= (bitwise-and tmp.27 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.26 7) 0) 14 6) 6)
              (* tmp.26 (arithmetic-shift-right tmp.27 3))
              318)
            318))))
    (define L.-.66.8
      (lambda (c.69 tmp.30 tmp.31)
        (let ()
          (if (!= (if (= (bitwise-and tmp.31 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.30 7) 0) 14 6) 6)
              (- tmp.30 tmp.31)
              830)
            830))))
    (define L.+.67.7
      (lambda (c.68 tmp.28 tmp.29)
        (let ()
          (if (!= (if (= (bitwise-and tmp.29 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.28 7) 0) 14 6) 6)
              (+ tmp.28 tmp.29)
              574)
            574))))
    (let ((|+.67|
           (let ((tmp.79 (+ (alloc 16) 2)))
             (begin (mset! tmp.79 -2 L.+.67.7) (mset! tmp.79 6 16) tmp.79)))
          (|-.66|
           (let ((tmp.80 (+ (alloc 16) 2)))
             (begin (mset! tmp.80 -2 L.-.66.8) (mset! tmp.80 6 16) tmp.80)))
          (*.65
           (let ((tmp.81 (+ (alloc 16) 2)))
             (begin (mset! tmp.81 -2 L.*.65.9) (mset! tmp.81 6 16) tmp.81)))
          (vector-init-loop.14
           (let ((tmp.82 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.82 -2 L.vector-init-loop.14.10)
               (mset! tmp.82 6 24)
               tmp.82)))
          (make-init-vector.1
           (let ((tmp.83 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.83 -2 L.make-init-vector.1.11)
               (mset! tmp.83 6 8)
               tmp.83)))
          (make-vector.64
           (let ((tmp.84 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.84 -2 L.make-vector.64.12)
               (mset! tmp.84 6 8)
               tmp.84)))
          (fun/ascii-char8613.4
           (let ((tmp.85 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.85 -2 L.fun/ascii-char8613.4.13)
               (mset! tmp.85 6 0)
               tmp.85)))
          (fun/vector8612.5
           (let ((tmp.86 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.86 -2 L.fun/vector8612.5.14)
               (mset! tmp.86 6 0)
               tmp.86)))
          (fun/ascii-char8614.6
           (let ((tmp.87 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.87 -2 L.fun/ascii-char8614.6.15)
               (mset! tmp.87 6 0)
               tmp.87)))
          (fun/void8611.7
           (let ((tmp.88 (+ (alloc 16) 2)))
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
               (call
                L.+.67.7
                |+.67|
                (call L.*.65.9 *.65 616 1608)
                (call L.-.66.8 |-.66| 424 320)))
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
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.39)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.71 tmp.11)
        (let ((vector-init-loop.13 (mref c.71 14)))
          (let ((tmp.12
                 (let ((tmp.76
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.11 3)) 8))
                         3)))
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
          (if (!= (if (= len.14 i.16) 14 6) 6)
            vec.15
            (begin
              (mset! vec.15 (+ (* (arithmetic-shift-right i.16 3) 8) 5) 0)
              (call
               L.vector-init-loop.13.10
               vector-init-loop.13
               len.14
               (+ i.16 8)
               vec.15))))))
    (define L.+.64.9
      (lambda (c.69 tmp.27 tmp.28)
        (let ()
          (if (!= (if (= (bitwise-and tmp.28 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.27 7) 0) 14 6) 6)
              (+ tmp.27 tmp.28)
              574)
            574))))
    (define L.*.65.8
      (lambda (c.68 tmp.25 tmp.26)
        (let ()
          (if (!= (if (= (bitwise-and tmp.26 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.25 7) 0) 14 6) 6)
              (* tmp.25 (arithmetic-shift-right tmp.26 3))
              318)
            318))))
    (define L.-.66.7
      (lambda (c.67 tmp.29 tmp.30)
        (let ()
          (if (!= (if (= (bitwise-and tmp.30 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.29 7) 0) 14 6) 6)
              (- tmp.29 tmp.30)
              830)
            830))))
    (let ((|-.66|
           (let ((tmp.77 (+ (alloc 16) 2)))
             (begin (mset! tmp.77 -2 L.-.66.7) (mset! tmp.77 6 16) tmp.77)))
          (*.65
           (let ((tmp.78 (+ (alloc 16) 2)))
             (begin (mset! tmp.78 -2 L.*.65.8) (mset! tmp.78 6 16) tmp.78)))
          (|+.64|
           (let ((tmp.79 (+ (alloc 16) 2)))
             (begin (mset! tmp.79 -2 L.+.64.9) (mset! tmp.79 6 16) tmp.79)))
          (vector-init-loop.13
           (let ((tmp.80 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.80 -2 L.vector-init-loop.13.10)
               (mset! tmp.80 6 24)
               tmp.80)))
          (make-init-vector.1
           (let ((tmp.81 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.81 -2 L.make-init-vector.1.11)
               (mset! tmp.81 6 8)
               tmp.81)))
          (make-vector.63
           (let ((tmp.82 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.82 -2 L.make-vector.63.12)
               (mset! tmp.82 6 8)
               tmp.82)))
          (fun/ascii-char8617.4
           (let ((tmp.83 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.83 -2 L.fun/ascii-char8617.4.13)
               (mset! tmp.83 6 0)
               tmp.83)))
          (fun/vector8619.5
           (let ((tmp.84 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.84 -2 L.fun/vector8619.5.14)
               (mset! tmp.84 6 0)
               tmp.84)))
          (fun/void8618.6
           (let ((tmp.85 (+ (alloc 16) 2)))
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
               (call
                L.*.65.8
                *.65
                (call L.+.64.9 |+.64| 1424 976)
                (call L.+.64.9 |+.64| 456 696)))
              (ascii-char1.9
               (call L.fun/ascii-char8617.4.13 fun/ascii-char8617.4))
              (fixnum2.8
               (call
                L.+.64.9
                |+.64|
                (call L.-.66.7 |-.66| 216 16)
                (call L.*.65.8 *.65 256 1256)))
              (void3.7 (call L.fun/void8618.6.15 fun/void8618.6)))
          (call L.fun/vector8619.5.14 fun/vector8619.5))))))
(check-by-interp
 '(module
    (define L.lam.68.17
      (lambda (c.79)
        (let ((fun/any8773.7 (mref c.79 14)) (vector?.67 (mref c.79 22)))
          (call
           L.vector?.67.7
           vector?.67
           (call L.fun/any8773.7.15 fun/any8773.7)))))
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
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.41)
            2110))))
    (define L.make-init-vector.1.10
      (lambda (c.72 tmp.13)
        (let ((vector-init-loop.15 (mref c.72 14)))
          (let ((tmp.14
                 (let ((tmp.80
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.13 3)) 8))
                         3)))
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
          (if (!= (if (= len.16 i.18) 14 6) 6)
            vec.17
            (begin
              (mset! vec.17 (+ (* (arithmetic-shift-right i.18 3) 8) 5) 0)
              (call
               L.vector-init-loop.15.9
               vector-init-loop.15
               len.16
               (+ i.18 8)
               vec.17))))))
    (define L.error?.66.8
      (lambda (c.70 tmp.55)
        (let () (if (= (bitwise-and tmp.55 255) 62) 14 6))))
    (define L.vector?.67.7
      (lambda (c.69 tmp.57) (let () (if (= (bitwise-and tmp.57 7) 3) 14 6))))
    (let ((vector?.67
           (let ((tmp.81 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.81 -2 L.vector?.67.7)
               (mset! tmp.81 6 8)
               tmp.81)))
          (error?.66
           (let ((tmp.82 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.82 -2 L.error?.66.8)
               (mset! tmp.82 6 8)
               tmp.82)))
          (vector-init-loop.15
           (let ((tmp.83 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.83 -2 L.vector-init-loop.15.9)
               (mset! tmp.83 6 24)
               tmp.83)))
          (make-init-vector.1
           (let ((tmp.84 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.84 -2 L.make-init-vector.1.10)
               (mset! tmp.84 6 8)
               tmp.84)))
          (make-vector.65
           (let ((tmp.85 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.85 -2 L.make-vector.65.11)
               (mset! tmp.85 6 8)
               tmp.85)))
          (fun/any8771.4
           (let ((tmp.86 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.86 -2 L.fun/any8771.4.12)
               (mset! tmp.86 6 0)
               tmp.86)))
          (fun/empty8774.5
           (let ((tmp.87 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.87 -2 L.fun/empty8774.5.13)
               (mset! tmp.87 6 0)
               tmp.87)))
          (fun/void8770.6
           (let ((tmp.88 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.88 -2 L.fun/void8770.6.14)
               (mset! tmp.88 6 0)
               tmp.88)))
          (fun/any8773.7
           (let ((tmp.89 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.89 -2 L.fun/any8773.7.15)
               (mset! tmp.89 6 0)
               tmp.89)))
          (fun/vector8772.8
           (let ((tmp.90 (+ (alloc 24) 2)))
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
               (call
                L.error?.66.8
                error?.66
                (call L.fun/any8771.4.12 fun/any8771.4)))
              (vector2.10 (call L.fun/vector8772.8.16 fun/vector8772.8))
              (procedure3.9
               (let ((lam.68
                      (let ((tmp.91 (+ (alloc 32) 2)))
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
          (if (!= (if (= (bitwise-and tmp.47 7) 0) 14 6) 6)
            (call L.make-init-vector.1.12 make-init-vector.1 tmp.47)
            2110))))
    (define L.make-init-vector.1.12
      (lambda (c.83 tmp.19)
        (let ((vector-init-loop.21 (mref c.83 14)))
          (let ((tmp.20
                 (let ((tmp.97
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.19 3)) 8))
                         3)))
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
          (if (!= (if (= len.22 i.24) 14 6) 6)
            vec.23
            (begin
              (mset! vec.23 (+ (* (arithmetic-shift-right i.24 3) 8) 5) 0)
              (call
               L.vector-init-loop.21.11
               vector-init-loop.21
               len.22
               (+ i.24 8)
               vec.23))))))
    (define L.cons.72.10
      (lambda (c.81 tmp.66 tmp.67)
        (let ()
          (let ((tmp.98 (+ (alloc 16) 1)))
            (begin (mset! tmp.98 -1 tmp.66) (mset! tmp.98 7 tmp.67) tmp.98)))))
    (define L.*.73.9
      (lambda (c.80 tmp.33 tmp.34)
        (let ()
          (if (!= (if (= (bitwise-and tmp.34 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.33 7) 0) 14 6) 6)
              (* tmp.33 (arithmetic-shift-right tmp.34 3))
              318)
            318))))
    (define L.-.74.8
      (lambda (c.79 tmp.37 tmp.38)
        (let ()
          (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
              (- tmp.37 tmp.38)
              830)
            830))))
    (define L.+.75.7
      (lambda (c.78 tmp.35 tmp.36)
        (let ()
          (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.35 7) 0) 14 6) 6)
              (+ tmp.35 tmp.36)
              574)
            574))))
    (let ((|+.75|
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin (mset! tmp.99 -2 L.+.75.7) (mset! tmp.99 6 16) tmp.99)))
          (|-.74|
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin (mset! tmp.100 -2 L.-.74.8) (mset! tmp.100 6 16) tmp.100)))
          (*.73
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin (mset! tmp.101 -2 L.*.73.9) (mset! tmp.101 6 16) tmp.101)))
          (cons.72
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.102 -2 L.cons.72.10)
               (mset! tmp.102 6 16)
               tmp.102)))
          (vector-init-loop.21
           (let ((tmp.103 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.103 -2 L.vector-init-loop.21.11)
               (mset! tmp.103 6 24)
               tmp.103)))
          (make-init-vector.1
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.make-init-vector.1.12)
               (mset! tmp.104 6 8)
               tmp.104)))
          (make-vector.71
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.make-vector.71.13)
               (mset! tmp.105 6 8)
               tmp.105)))
          (fun/void9398.4
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/void9398.4.14)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/empty9407.5
           (let ((tmp.107 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/empty9407.5.15)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/ascii-char9403.6
           (let ((tmp.108 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/ascii-char9403.6.16)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/pair9400.7
           (let ((tmp.109 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/pair9400.7.17)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/vector9404.8
           (let ((tmp.110 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/vector9404.8.18)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/void9399.9
           (let ((tmp.111 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/void9399.9.19)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/empty9406.10
           (let ((tmp.112 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.112 -2 L.fun/empty9406.10.20)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/vector9405.11
           (let ((tmp.113 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.113 -2 L.fun/vector9405.11.21)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/pair9401.12
           (let ((tmp.114 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.114 -2 L.fun/pair9401.12.22)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/ascii-char9402.13
           (let ((tmp.115 (+ (alloc 24) 2)))
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
               (call
                L.-.74.8
                |-.74|
                (call
                 L.*.73.9
                 *.73
                 (call L.*.73.9 *.73 1960 752)
                 (call L.-.74.8 |-.74| 752 1608))
                (call
                 L.+.75.7
                 |+.75|
                 (call L.-.74.8 |-.74| 1800 128)
                 (call L.+.75.7 |+.75| 368 1392))))
              (procedure2.16
               (let ((lam.76
                      (let ((tmp.116 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.116 -2 L.lam.76.24)
                          (mset! tmp.116 6 0)
                          tmp.116))))
                 (begin (mset! lam.76 14 fun/pair9400.7) lam.76)))
              (ascii-char3.15
               (call L.fun/ascii-char9402.13.23 fun/ascii-char9402.13))
              (procedure4.14
               (let ((lam.77
                      (let ((tmp.117 (+ (alloc 24) 2)))
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
          (let ((tmp.94 (+ (alloc 16) 1)))
            (begin (mset! tmp.94 -1 tmp.69) (mset! tmp.94 7 tmp.70) tmp.94)))))
    (define L.+.75.9
      (lambda (c.80 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.*.76.8
      (lambda (c.79 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (* tmp.36 (arithmetic-shift-right tmp.37 3))
              318)
            318))))
    (define L.-.77.7
      (lambda (c.78 tmp.40 tmp.41)
        (let ()
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
              (- tmp.40 tmp.41)
              830)
            830))))
    (let ((|-.77|
           (let ((tmp.95 (+ (alloc 16) 2)))
             (begin (mset! tmp.95 -2 L.-.77.7) (mset! tmp.95 6 16) tmp.95)))
          (*.76
           (let ((tmp.96 (+ (alloc 16) 2)))
             (begin (mset! tmp.96 -2 L.*.76.8) (mset! tmp.96 6 16) tmp.96)))
          (|+.75|
           (let ((tmp.97 (+ (alloc 16) 2)))
             (begin (mset! tmp.97 -2 L.+.75.9) (mset! tmp.97 6 16) tmp.97)))
          (cons.74
           (let ((tmp.98 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.98 -2 L.cons.74.10)
               (mset! tmp.98 6 16)
               tmp.98)))
          (fun/empty13316.4
           (let ((tmp.99 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/empty13316.4.11)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/ascii-char13315.5
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/ascii-char13315.5.12)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/error13313.6
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/error13313.6.13)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/error13308.7
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/error13308.7.14)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/error13312.8
           (let ((tmp.103 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/error13312.8.15)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/pair13319.9
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/pair13319.9.16)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/void13310.10
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/void13310.10.17)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/empty13317.11
           (let ((tmp.106 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/empty13317.11.18)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/error13309.12
           (let ((tmp.107 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/error13309.12.19)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/ascii-char13314.13
           (let ((tmp.108 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/ascii-char13314.13.20)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/void13311.14
           (let ((tmp.109 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/void13311.14.21)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/pair13318.15
           (let ((tmp.110 (+ (alloc 24) 2)))
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
               (call
                L.-.77.7
                |-.77|
                (call
                 L.-.77.7
                 |-.77|
                 (call
                  L.+.75.9
                  |+.75|
                  (call L.+.75.9 |+.75| 872 2000)
                  (call L.*.76.8 *.76 1816 1184))
                 (call
                  L.*.76.8
                  *.76
                  (call L.-.77.7 |-.77| 1720 1040)
                  (call L.*.76.8 *.76 1784 240)))
                (call
                 L.*.76.8
                 *.76
                 (call
                  L.-.77.7
                  |-.77|
                  (call L.*.76.8 *.76 1976 8)
                  (call L.*.76.8 *.76 504 480))
                 (call
                  L.+.75.9
                  |+.75|
                  (call L.*.76.8 *.76 1664 1664)
                  (call L.-.77.7 |-.77| 1472 1024)))))
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
          (if (!= (if (= (bitwise-and tmp.46 7) 0) 14 6) 6)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.46)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.79 tmp.18)
        (let ((vector-init-loop.20 (mref c.79 14)))
          (let ((tmp.19
                 (let ((tmp.90
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.18 3)) 8))
                         3)))
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
          (if (!= (if (= len.21 i.23) 14 6) 6)
            vec.22
            (begin
              (mset! vec.22 (+ (* (arithmetic-shift-right i.23 3) 8) 5) 0)
              (call
               L.vector-init-loop.20.10
               vector-init-loop.20
               len.21
               (+ i.23 8)
               vec.22))))))
    (define L.*.71.9
      (lambda (c.77 tmp.32 tmp.33)
        (let ()
          (if (!= (if (= (bitwise-and tmp.33 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.32 7) 0) 14 6) 6)
              (* tmp.32 (arithmetic-shift-right tmp.33 3))
              318)
            318))))
    (define L.+.72.8
      (lambda (c.76 tmp.34 tmp.35)
        (let ()
          (if (!= (if (= (bitwise-and tmp.35 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.34 7) 0) 14 6) 6)
              (+ tmp.34 tmp.35)
              574)
            574))))
    (define L.-.73.7
      (lambda (c.75 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (- tmp.36 tmp.37)
              830)
            830))))
    (let ((|-.73|
           (let ((tmp.91 (+ (alloc 16) 2)))
             (begin (mset! tmp.91 -2 L.-.73.7) (mset! tmp.91 6 16) tmp.91)))
          (|+.72|
           (let ((tmp.92 (+ (alloc 16) 2)))
             (begin (mset! tmp.92 -2 L.+.72.8) (mset! tmp.92 6 16) tmp.92)))
          (*.71
           (let ((tmp.93 (+ (alloc 16) 2)))
             (begin (mset! tmp.93 -2 L.*.71.9) (mset! tmp.93 6 16) tmp.93)))
          (vector-init-loop.20
           (let ((tmp.94 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.94 -2 L.vector-init-loop.20.10)
               (mset! tmp.94 6 24)
               tmp.94)))
          (make-init-vector.1
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.make-init-vector.1.11)
               (mset! tmp.95 6 8)
               tmp.95)))
          (make-vector.70
           (let ((tmp.96 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.96 -2 L.make-vector.70.12)
               (mset! tmp.96 6 8)
               tmp.96)))
          (fun/error13358.4
           (let ((tmp.97 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/error13358.4.13)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/vector13357.5
           (let ((tmp.98 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/vector13357.5.14)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/vector13355.6
           (let ((tmp.99 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/vector13355.6.15)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/ascii-char13352.7
           (let ((tmp.100 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/ascii-char13352.7.16)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/vector13354.8
           (let ((tmp.101 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/vector13354.8.17)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/vector13356.9
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/vector13356.9.18)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/error13359.10
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/error13359.10.19)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/ascii-char13353.11
           (let ((tmp.104 (+ (alloc 16) 2)))
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
               (call
                L.*.71.9
                *.71
                (call
                 L.+.72.8
                 |+.72|
                 (call
                  L.+.72.8
                  |+.72|
                  (call L.*.71.9 *.71 488 1608)
                  (call L.*.71.9 *.71 88 144))
                 (call
                  L.+.72.8
                  |+.72|
                  (call L.-.73.7 |-.73| 736 216)
                  (call L.+.72.8 |+.72| 792 1816)))
                (call
                 L.+.72.8
                 |+.72|
                 (call
                  L.*.71.9
                  *.71
                  (call L.-.73.7 |-.73| 624 1752)
                  (call L.+.72.8 |+.72| 1848 632))
                 (call
                  L.+.72.8
                  |+.72|
                  (call L.-.73.7 |-.73| 320 744)
                  (call L.*.71.9 *.71 912 64)))))
              (ascii-char1.16
               (call L.fun/ascii-char13352.7.16 fun/ascii-char13352.7))
              (procedure2.15
               (let ((lam.74
                      (let ((tmp.105 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.105 -2 L.lam.74.21)
                          (mset! tmp.105 6 0)
                          tmp.105))))
                 (begin (mset! lam.74 14 fun/vector13354.8) lam.74)))
              (fixnum3.14
               (call
                L.-.73.7
                |-.73|
                (call
                 L.*.71.9
                 *.71
                 (call
                  L.-.73.7
                  |-.73|
                  (call L.-.73.7 |-.73| 1472 1496)
                  (call L.-.73.7 |-.73| 1992 664))
                 (call
                  L.-.73.7
                  |-.73|
                  (call L.*.71.9 *.71 1984 1664)
                  (call L.+.72.8 |+.72| 1592 1048)))
                (call
                 L.-.73.7
                 |-.73|
                 (call
                  L.*.71.9
                  *.71
                  (call L.*.71.9 *.71 128 1896)
                  (call L.*.71.9 *.71 1472 1096))
                 (call
                  L.*.71.9
                  *.71
                  (call L.-.73.7 |-.73| 608 1528)
                  (call L.-.73.7 |-.73| 1480 720)))))
              (vector4.13 (call L.fun/vector13356.9.18 fun/vector13356.9))
              (error5.12 (call L.fun/error13358.4.13 fun/error13358.4)))
          (if (!= (if (= (bitwise-and procedure2.15 7) 2) 14 6) 6)
            (if (!= (if (= (mref procedure2.15 6) 0) 14 6) 6)
              (call (mref procedure2.15 -2) procedure2.15)
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
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (- tmp.38 tmp.39)
              830)
            830))))
    (define L.+.73.8
      (lambda (c.76 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (+ tmp.36 tmp.37)
              574)
            574))))
    (define L.*.74.7
      (lambda (c.75 tmp.34 tmp.35)
        (let ()
          (if (!= (if (= (bitwise-and tmp.35 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.34 7) 0) 14 6) 6)
              (* tmp.34 (arithmetic-shift-right tmp.35 3))
              318)
            318))))
    (let ((*.74
           (let ((tmp.88 (+ (alloc 16) 2)))
             (begin (mset! tmp.88 -2 L.*.74.7) (mset! tmp.88 6 16) tmp.88)))
          (|+.73|
           (let ((tmp.89 (+ (alloc 16) 2)))
             (begin (mset! tmp.89 -2 L.+.73.8) (mset! tmp.89 6 16) tmp.89)))
          (|-.72|
           (let ((tmp.90 (+ (alloc 16) 2)))
             (begin (mset! tmp.90 -2 L.-.72.9) (mset! tmp.90 6 16) tmp.90)))
          (fun/void14593.4
           (let ((tmp.91 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.91 -2 L.fun/void14593.4.10)
               (mset! tmp.91 6 0)
               tmp.91)))
          (fun/void14591.5
           (let ((tmp.92 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.92 -2 L.fun/void14591.5.11)
               (mset! tmp.92 6 0)
               tmp.92)))
          (fun/void14590.6
           (let ((tmp.93 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.93 -2 L.fun/void14590.6.12)
               (mset! tmp.93 6 0)
               tmp.93)))
          (fun/ascii-char14586.7
           (let ((tmp.94 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.94 -2 L.fun/ascii-char14586.7.13)
               (mset! tmp.94 6 0)
               tmp.94)))
          (fun/void14588.8
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.fun/void14588.8.14)
               (mset! tmp.95 6 0)
               tmp.95)))
          (fun/void14592.9
           (let ((tmp.96 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.96 -2 L.fun/void14592.9.15)
               (mset! tmp.96 6 0)
               tmp.96)))
          (fun/ascii-char14587.10
           (let ((tmp.97 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/ascii-char14587.10.16)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/empty14585.11
           (let ((tmp.98 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/empty14585.11.17)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/void14589.12
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/void14589.12.18)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/empty14584.13
           (let ((tmp.100 (+ (alloc 24) 2)))
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
               (call
                L.+.73.8
                |+.73|
                (call
                 L.+.73.8
                 |+.73|
                 (call
                  L.-.72.9
                  |-.72|
                  (call L.-.72.9 |-.72| 1552 904)
                  (call L.-.72.9 |-.72| 1480 1928))
                 (call
                  L.*.74.7
                  *.74
                  (call L.+.73.8 |+.73| 1296 728)
                  (call L.-.72.9 |-.72| 1312 1576)))
                (call
                 L.+.73.8
                 |+.73|
                 (call
                  L.*.74.7
                  *.74
                  (call L.-.72.9 |-.72| 1992 1792)
                  (call L.-.72.9 |-.72| 2000 1496))
                 (call
                  L.*.74.7
                  *.74
                  (call L.*.74.7 *.74 1712 752)
                  (call L.*.74.7 *.74 1648 1528)))))
              (void4.15 (call L.fun/void14590.6.12 fun/void14590.6))
              (fixnum5.14
               (call
                L.+.73.8
                |+.73|
                (call
                 L.-.72.9
                 |-.72|
                 (call
                  L.+.73.8
                  |+.73|
                  (call L.-.72.9 |-.72| 1184 296)
                  (call L.*.74.7 *.74 880 88))
                 (call
                  L.*.74.7
                  *.74
                  (call L.*.74.7 *.74 40 616)
                  (call L.-.72.9 |-.72| 424 1784)))
                (call
                 L.+.73.8
                 |+.73|
                 (call
                  L.-.72.9
                  |-.72|
                  (call L.*.74.7 *.74 512 688)
                  (call L.-.72.9 |-.72| 1616 968))
                 (call
                  L.*.74.7
                  *.74
                  (call L.*.74.7 *.74 608 208)
                  (call L.*.74.7 *.74 296 1832))))))
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
          (if (!= (if (= (bitwise-and tmp.50 7) 0) 14 6) 6)
            (call L.make-init-vector.1.13 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.13
      (lambda (c.86 tmp.22)
        (let ((vector-init-loop.24 (mref c.86 14)))
          (let ((tmp.23
                 (let ((tmp.100
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.22 3)) 8))
                         3)))
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
          (if (!= (if (= len.25 i.27) 14 6) 6)
            vec.26
            (begin
              (mset! vec.26 (+ (* (arithmetic-shift-right i.27 3) 8) 5) 0)
              (call
               L.vector-init-loop.24.12
               vector-init-loop.24
               len.25
               (+ i.27 8)
               vec.26))))))
    (define L.cons.75.11
      (lambda (c.84 tmp.69 tmp.70)
        (let ()
          (let ((tmp.101 (+ (alloc 16) 1)))
            (begin
              (mset! tmp.101 -1 tmp.69)
              (mset! tmp.101 7 tmp.70)
              tmp.101)))))
    (define L.-.76.10
      (lambda (c.83 tmp.40 tmp.41)
        (let ()
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.+.77.9
      (lambda (c.82 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.*.78.8
      (lambda (c.81 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (* tmp.36 (arithmetic-shift-right tmp.37 3))
              318)
            318))))
    (define L.empty?.79.7
      (lambda (c.80 tmp.61)
        (let () (if (= (bitwise-and tmp.61 255) 22) 14 6))))
    (let ((empty?.79
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.102 -2 L.empty?.79.7)
               (mset! tmp.102 6 8)
               tmp.102)))
          (*.78
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin (mset! tmp.103 -2 L.*.78.8) (mset! tmp.103 6 16) tmp.103)))
          (|+.77|
           (let ((tmp.104 (+ (alloc 16) 2)))
             (begin (mset! tmp.104 -2 L.+.77.9) (mset! tmp.104 6 16) tmp.104)))
          (|-.76|
           (let ((tmp.105 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.105 -2 L.-.76.10)
               (mset! tmp.105 6 16)
               tmp.105)))
          (cons.75
           (let ((tmp.106 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.106 -2 L.cons.75.11)
               (mset! tmp.106 6 16)
               tmp.106)))
          (vector-init-loop.24
           (let ((tmp.107 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.107 -2 L.vector-init-loop.24.12)
               (mset! tmp.107 6 24)
               tmp.107)))
          (make-init-vector.1
           (let ((tmp.108 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.108 -2 L.make-init-vector.1.13)
               (mset! tmp.108 6 8)
               tmp.108)))
          (make-vector.74
           (let ((tmp.109 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.109 -2 L.make-vector.74.14)
               (mset! tmp.109 6 8)
               tmp.109)))
          (fun/empty15140.4
           (let ((tmp.110 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/empty15140.4.15)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/void15145.5
           (let ((tmp.111 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/void15145.5.16)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/vector15138.6
           (let ((tmp.112 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.112 -2 L.fun/vector15138.6.17)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/ascii-char15135.7
           (let ((tmp.113 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.113 -2 L.fun/ascii-char15135.7.18)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/void15142.8
           (let ((tmp.114 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.114 -2 L.fun/void15142.8.19)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/any15144.9
           (let ((tmp.115 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.115 -2 L.fun/any15144.9.20)
               (mset! tmp.115 6 0)
               tmp.115)))
          (fun/any15143.10
           (let ((tmp.116 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.116 -2 L.fun/any15143.10.21)
               (mset! tmp.116 6 0)
               tmp.116)))
          (fun/vector15137.11
           (let ((tmp.117 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.117 -2 L.fun/vector15137.11.22)
               (mset! tmp.117 6 0)
               tmp.117)))
          (fun/void15146.12
           (let ((tmp.118 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.118 -2 L.fun/void15146.12.23)
               (mset! tmp.118 6 0)
               tmp.118)))
          (fun/empty15139.13
           (let ((tmp.119 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.119 -2 L.fun/empty15139.13.24)
               (mset! tmp.119 6 0)
               tmp.119)))
          (fun/void15141.14
           (let ((tmp.120 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.120 -2 L.fun/void15141.14.25)
               (mset! tmp.120 6 0)
               tmp.120)))
          (fun/ascii-char15136.15
           (let ((tmp.121 (+ (alloc 16) 2)))
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
               (call
                L.+.77.9
                |+.77|
                (call
                 L.-.76.10
                 |-.76|
                 (call
                  L.+.77.9
                  |+.77|
                  (call L.-.76.10 |-.76| 1376 192)
                  (call L.-.76.10 |-.76| 1984 1608))
                 (call
                  L.+.77.9
                  |+.77|
                  (call L.+.77.9 |+.77| 296 1840)
                  (call L.-.76.10 |-.76| 488 1720)))
                (call
                 L.-.76.10
                 |-.76|
                 (call
                  L.+.77.9
                  |+.77|
                  (call L.*.78.8 *.78 1368 776)
                  (call L.-.76.10 |-.76| 864 64))
                 (call
                  L.-.76.10
                  |-.76|
                  (call L.-.76.10 |-.76| 392 584)
                  (call L.+.77.9 |+.77| 1440 1872)))))
              (void4.17 (call L.fun/void15141.14.25 fun/void15141.14))
              (boolean5.16
               (call
                L.empty?.79.7
                empty?.79
                (call L.fun/any15143.10.21 fun/any15143.10))))
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
          (if (!= (if (= (bitwise-and tmp.52 7) 0) 14 6) 6)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.52)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.79 tmp.24)
        (let ((vector-init-loop.26 (mref c.79 14)))
          (let ((tmp.25
                 (let ((tmp.96
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.24 3)) 8))
                         3)))
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
          (if (!= (if (= len.27 i.29) 14 6) 6)
            vec.28
            (begin
              (mset! vec.28 (+ (* (arithmetic-shift-right i.29 3) 8) 5) 0)
              (call
               L.vector-init-loop.26.7
               vector-init-loop.26
               len.27
               (+ i.29 8)
               vec.28))))))
    (let ((vector-init-loop.26
           (let ((tmp.97 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.97 -2 L.vector-init-loop.26.7)
               (mset! tmp.97 6 24)
               tmp.97)))
          (make-init-vector.1
           (let ((tmp.98 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.98 -2 L.make-init-vector.1.8)
               (mset! tmp.98 6 8)
               tmp.98)))
          (make-vector.76
           (let ((tmp.99 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.99 -2 L.make-vector.76.9)
               (mset! tmp.99 6 8)
               tmp.99)))
          (fun/vector15770.4
           (let ((tmp.100 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/vector15770.4.10)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/empty15765.5
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/empty15765.5.11)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/void15774.6
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/void15774.6.12)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/error15773.7
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/error15773.7.13)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/error15772.8
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/error15772.8.14)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/vector15771.9
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/vector15771.9.15)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/ascii-char15769.10
           (let ((tmp.106 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/ascii-char15769.10.16)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/empty15767.11
           (let ((tmp.107 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/empty15767.11.17)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/ascii-char15776.12
           (let ((tmp.108 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/ascii-char15776.12.18)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/empty15766.13
           (let ((tmp.109 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/empty15766.13.19)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/empty15764.14
           (let ((tmp.110 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/empty15764.14.20)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/void15775.15
           (let ((tmp.111 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/void15775.15.21)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/ascii-char15777.16
           (let ((tmp.112 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.112 -2 L.fun/ascii-char15777.16.22)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/ascii-char15768.17
           (let ((tmp.113 (+ (alloc 24) 2)))
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
                      (let ((tmp.114 (+ (alloc 24) 2)))
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
          (if (!= (if (= (bitwise-and tmp.50 7) 0) 14 6) 6)
            (call L.make-init-vector.1.12 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.12
      (lambda (c.85 tmp.22)
        (let ((vector-init-loop.24 (mref c.85 14)))
          (let ((tmp.23
                 (let ((tmp.100
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.22 3)) 8))
                         3)))
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
          (if (!= (if (= len.25 i.27) 14 6) 6)
            vec.26
            (begin
              (mset! vec.26 (+ (* (arithmetic-shift-right i.27 3) 8) 5) 0)
              (call
               L.vector-init-loop.24.11
               vector-init-loop.24
               len.25
               (+ i.27 8)
               vec.26))))))
    (define L.cons.75.10
      (lambda (c.83 tmp.69 tmp.70)
        (let ()
          (let ((tmp.101 (+ (alloc 16) 1)))
            (begin
              (mset! tmp.101 -1 tmp.69)
              (mset! tmp.101 7 tmp.70)
              tmp.101)))))
    (define L.-.76.9
      (lambda (c.82 tmp.40 tmp.41)
        (let ()
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.*.77.8
      (lambda (c.81 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (* tmp.36 (arithmetic-shift-right tmp.37 3))
              318)
            318))))
    (define L.+.78.7
      (lambda (c.80 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (+ tmp.38 tmp.39)
              574)
            574))))
    (let ((|+.78|
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin (mset! tmp.102 -2 L.+.78.7) (mset! tmp.102 6 16) tmp.102)))
          (*.77
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin (mset! tmp.103 -2 L.*.77.8) (mset! tmp.103 6 16) tmp.103)))
          (|-.76|
           (let ((tmp.104 (+ (alloc 16) 2)))
             (begin (mset! tmp.104 -2 L.-.76.9) (mset! tmp.104 6 16) tmp.104)))
          (cons.75
           (let ((tmp.105 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.105 -2 L.cons.75.10)
               (mset! tmp.105 6 16)
               tmp.105)))
          (vector-init-loop.24
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.vector-init-loop.24.11)
               (mset! tmp.106 6 24)
               tmp.106)))
          (make-init-vector.1
           (let ((tmp.107 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.107 -2 L.make-init-vector.1.12)
               (mset! tmp.107 6 8)
               tmp.107)))
          (make-vector.74
           (let ((tmp.108 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.108 -2 L.make-vector.74.13)
               (mset! tmp.108 6 8)
               tmp.108)))
          (fun/void21848.4
           (let ((tmp.109 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/void21848.4.14)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/ascii-char21854.5
           (let ((tmp.110 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/ascii-char21854.5.15)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/vector21856.6
           (let ((tmp.111 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/vector21856.6.16)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/pair21851.7
           (let ((tmp.112 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.112 -2 L.fun/pair21851.7.17)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/vector21849.8
           (let ((tmp.113 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.113 -2 L.fun/vector21849.8.18)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/vector21850.9
           (let ((tmp.114 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.114 -2 L.fun/vector21850.9.19)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/error21846.10
           (let ((tmp.115 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.115 -2 L.fun/error21846.10.20)
               (mset! tmp.115 6 0)
               tmp.115)))
          (fun/vector21855.11
           (let ((tmp.116 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.116 -2 L.fun/vector21855.11.21)
               (mset! tmp.116 6 0)
               tmp.116)))
          (fun/pair21852.12
           (let ((tmp.117 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.117 -2 L.fun/pair21852.12.22)
               (mset! tmp.117 6 0)
               tmp.117)))
          (fun/error21845.13
           (let ((tmp.118 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.118 -2 L.fun/error21845.13.23)
               (mset! tmp.118 6 0)
               tmp.118)))
          (fun/ascii-char21853.14
           (let ((tmp.119 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.119 -2 L.fun/ascii-char21853.14.24)
               (mset! tmp.119 6 0)
               tmp.119)))
          (fun/void21847.15
           (let ((tmp.120 (+ (alloc 24) 2)))
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
                      (let ((tmp.121 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.121 -2 L.lam.79.26)
                          (mset! tmp.121 6 0)
                          tmp.121))))
                 (begin (mset! lam.79 14 fun/pair21851.7) lam.79)))
              (ascii-char4.17
               (call L.fun/ascii-char21853.14.24 fun/ascii-char21853.14))
              (fixnum5.16
               (call
                L.*.77.8
                *.77
                (call
                 L.*.77.8
                 *.77
                 (call
                  L.*.77.8
                  *.77
                  (call L.-.76.9 |-.76| 656 528)
                  (call L.-.76.9 |-.76| 1168 664))
                 (call
                  L.+.78.7
                  |+.78|
                  (call L.+.78.7 |+.78| 640 688)
                  (call L.-.76.9 |-.76| 664 344)))
                (call
                 L.*.77.8
                 *.77
                 (call
                  L.-.76.9
                  |-.76|
                  (call L.*.77.8 *.77 1408 312)
                  (call L.-.76.9 |-.76| 1896 96))
                 (call
                  L.-.76.9
                  |-.76|
                  (call L.*.77.8 *.77 1096 1776)
                  (call L.-.76.9 |-.76| 1024 856))))))
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
          (if (!= (if (= (bitwise-and tmp.50 7) 0) 14 6) 6)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.77 tmp.22)
        (let ((vector-init-loop.24 (mref c.77 14)))
          (let ((tmp.23
                 (let ((tmp.92
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.22 3)) 8))
                         3)))
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
          (if (!= (if (= len.25 i.27) 14 6) 6)
            vec.26
            (begin
              (mset! vec.26 (+ (* (arithmetic-shift-right i.27 3) 8) 5) 0)
              (call
               L.vector-init-loop.24.7
               vector-init-loop.24
               len.25
               (+ i.27 8)
               vec.26))))))
    (let ((vector-init-loop.24
           (let ((tmp.93 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.93 -2 L.vector-init-loop.24.7)
               (mset! tmp.93 6 24)
               tmp.93)))
          (make-init-vector.1
           (let ((tmp.94 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.94 -2 L.make-init-vector.1.8)
               (mset! tmp.94 6 8)
               tmp.94)))
          (make-vector.74
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.make-vector.74.9)
               (mset! tmp.95 6 8)
               tmp.95)))
          (fun/empty10026.4
           (let ((tmp.96 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.96 -2 L.fun/empty10026.4.10)
               (mset! tmp.96 6 0)
               tmp.96)))
          (fun/void10033.5
           (let ((tmp.97 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/void10033.5.11)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/vector10030.6
           (let ((tmp.98 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/vector10030.6.12)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/empty10023.7
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/empty10023.7.13)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/void10029.8
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/void10029.8.14)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/vector10031.9
           (let ((tmp.101 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/vector10031.9.15)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/void10028.10
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/void10028.10.16)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/empty10027.11
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/empty10027.11.17)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/vector10025.12
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/vector10025.12.18)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/empty10022.13
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/empty10022.13.19)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/vector10024.14
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/vector10024.14.20)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/void10032.15
           (let ((tmp.107 (+ (alloc 24) 2)))
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
                      (let ((tmp.108 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.108 -2 L.lam.75.22)
                          (mset! tmp.108 6 0)
                          tmp.108))))
                 (begin (mset! lam.75 14 fun/vector10024.14) lam.75)))
              (empty2.19 (call L.fun/empty10026.4.10 fun/empty10026.4))
              (void3.18 (call L.fun/void10028.10.16 fun/void10028.10))
              (vector4.17 (call L.fun/vector10030.6.12 fun/vector10030.6))
              (void5.16 (call L.fun/void10032.15.21 fun/void10032.15)))
          (if (!= (if (= (bitwise-and procedure1.20 7) 2) 14 6) 6)
            (if (!= (if (= (mref procedure1.20 6) 0) 14 6) 6)
              (call (mref procedure1.20 -2) procedure1.20)
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
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.+.75.9
      (lambda (c.81 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.*.76.8
      (lambda (c.80 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (* tmp.36 (arithmetic-shift-right tmp.37 3))
              318)
            318))))
    (define L.fixnum?.77.7
      (lambda (c.79 tmp.59) (let () (if (= (bitwise-and tmp.59 7) 0) 14 6))))
    (let ((fixnum?.77
           (let ((tmp.96 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.96 -2 L.fixnum?.77.7)
               (mset! tmp.96 6 8)
               tmp.96)))
          (*.76
           (let ((tmp.97 (+ (alloc 16) 2)))
             (begin (mset! tmp.97 -2 L.*.76.8) (mset! tmp.97 6 16) tmp.97)))
          (|+.75|
           (let ((tmp.98 (+ (alloc 16) 2)))
             (begin (mset! tmp.98 -2 L.+.75.9) (mset! tmp.98 6 16) tmp.98)))
          (|-.74|
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin (mset! tmp.99 -2 L.-.74.10) (mset! tmp.99 6 16) tmp.99)))
          (fun/any12092.4
           (let ((tmp.100 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/any12092.4.11)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/empty12090.5
           (let ((tmp.101 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/empty12090.5.12)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/error12095.6
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/error12095.6.13)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/empty12096.7
           (let ((tmp.103 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/empty12096.7.14)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/empty12091.8
           (let ((tmp.104 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/empty12091.8.15)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/any12093.9
           (let ((tmp.105 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/any12093.9.16)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/void12099.10
           (let ((tmp.106 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/void12099.10.17)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/error12088.11
           (let ((tmp.107 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/error12088.11.18)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/empty12097.12
           (let ((tmp.108 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/empty12097.12.19)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/error12089.13
           (let ((tmp.109 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/error12089.13.20)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/error12094.14
           (let ((tmp.110 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/error12094.14.21)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/void12098.15
           (let ((tmp.111 (+ (alloc 24) 2)))
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
                      (let ((tmp.112 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.112 -2 L.lam.78.23)
                          (mset! tmp.112 6 0)
                          tmp.112))))
                 (begin (mset! lam.78 14 fun/error12088.11) lam.78)))
              (fixnum1.20
               (call
                L.-.74.10
                |-.74|
                (call
                 L.*.76.8
                 *.76
                 (call
                  L.-.74.10
                  |-.74|
                  (call L.-.74.10 |-.74| 432 1328)
                  (call L.+.75.9 |+.75| 1168 952))
                 (call
                  L.-.74.10
                  |-.74|
                  (call L.-.74.10 |-.74| 1472 168)
                  (call L.*.76.8 *.76 64 2024)))
                (call
                 L.-.74.10
                 |-.74|
                 (call
                  L.+.75.9
                  |+.75|
                  (call L.-.74.10 |-.74| 1672 760)
                  (call L.+.75.9 |+.75| 240 1968))
                 (call
                  L.*.76.8
                  *.76
                  (call L.+.75.9 |+.75| 544 696)
                  (call L.-.74.10 |-.74| 1528 1904)))))
              (empty2.19 (call L.fun/empty12090.5.12 fun/empty12090.5))
              (boolean3.18
               (call
                L.fixnum?.77.7
                fixnum?.77
                (call L.fun/any12092.4.11 fun/any12092.4)))
              (error4.17 (call L.fun/error12094.14.21 fun/error12094.14))
              (empty5.16 (call L.fun/empty12096.7.14 fun/empty12096.7)))
          (call L.fun/void12098.15.22 fun/void12098.15))))))
(check-by-interp
 '(module
    (define L.fun/void8620.8.12 (lambda (c.71) (let () 30)))
    (define L.fun/any8618.7.11 (lambda (c.70) (let () 19758)))
    (define L.fun/ascii-char8619.6.10 (lambda (c.69) (let () 26414)))
    (define L.fun/void8621.5.9 (lambda (c.68) (let () 30)))
    (define L.fun/void8617.4.8 (lambda (c.67) (let () 30)))
    (define L.pair?.65.7
      (lambda (c.66 tmp.56) (let () (if (= (bitwise-and tmp.56 7) 1) 14 6))))
    (let ((pair?.65
           (let ((tmp.72 (+ (alloc 16) 2)))
             (begin (mset! tmp.72 -2 L.pair?.65.7) (mset! tmp.72 6 8) tmp.72)))
          (fun/void8617.4
           (let ((tmp.73 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.73 -2 L.fun/void8617.4.8)
               (mset! tmp.73 6 0)
               tmp.73)))
          (fun/void8621.5
           (let ((tmp.74 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.74 -2 L.fun/void8621.5.9)
               (mset! tmp.74 6 0)
               tmp.74)))
          (fun/ascii-char8619.6
           (let ((tmp.75 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.75 -2 L.fun/ascii-char8619.6.10)
               (mset! tmp.75 6 0)
               tmp.75)))
          (fun/any8618.7
           (let ((tmp.76 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.76 -2 L.fun/any8618.7.11)
               (mset! tmp.76 6 0)
               tmp.76)))
          (fun/void8620.8
           (let ((tmp.77 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.77 -2 L.fun/void8620.8.12)
               (mset! tmp.77 6 0)
               tmp.77))))
      (let ((void0.12 (call L.fun/void8617.4.8 fun/void8617.4))
            (boolean1.11
             (call
              L.pair?.65.7
              pair?.65
              (call L.fun/any8618.7.11 fun/any8618.7)))
            (ascii-char2.10
             (call L.fun/ascii-char8619.6.10 fun/ascii-char8619.6))
            (void3.9 (call L.fun/void8620.8.12 fun/void8620.8)))
        (call L.fun/void8621.5.9 fun/void8621.5)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char9293.13.22
      (lambda (c.90)
        (let ((fun/ascii-char9294.12 (mref c.90 14)))
          (call L.fun/ascii-char9294.12.21 fun/ascii-char9294.12))))
    (define L.fun/ascii-char9294.12.21 (lambda (c.89) (let () 22062)))
    (define L.fun/vector9291.11.20
      (lambda (c.88)
        (let ((fun/vector9292.8 (mref c.88 14)))
          (call L.fun/vector9292.8.17 fun/vector9292.8))))
    (define L.fun/empty9295.10.19
      (lambda (c.87)
        (let ((fun/empty9296.9 (mref c.87 14)))
          (call L.fun/empty9296.9.18 fun/empty9296.9))))
    (define L.fun/empty9296.9.18 (lambda (c.86) (let () 22)))
    (define L.fun/vector9292.8.17
      (lambda (c.85)
        (let ((make-vector.71 (mref c.85 14)))
          (call L.make-vector.71.12 make-vector.71 64))))
    (define L.fun/error9288.7.16 (lambda (c.84) (let () 60990)))
    (define L.fun/vector9290.6.15
      (lambda (c.83)
        (let ((make-vector.71 (mref c.83 14)))
          (call L.make-vector.71.12 make-vector.71 64))))
    (define L.fun/error9287.5.14
      (lambda (c.82)
        (let ((fun/error9288.7 (mref c.82 14)))
          (call L.fun/error9288.7.16 fun/error9288.7))))
    (define L.fun/vector9289.4.13
      (lambda (c.81)
        (let ((fun/vector9290.6 (mref c.81 14)))
          (call L.fun/vector9290.6.15 fun/vector9290.6))))
    (define L.make-vector.71.12
      (lambda (c.80 tmp.47)
        (let ((make-init-vector.1 (mref c.80 14)))
          (if (!= (if (= (bitwise-and tmp.47 7) 0) 14 6) 6)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.47)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.79 tmp.19)
        (let ((vector-init-loop.21 (mref c.79 14)))
          (let ((tmp.20
                 (let ((tmp.91
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.19 3)) 8))
                         3)))
                   (begin (mset! tmp.91 -3 tmp.19) tmp.91))))
            (call
             L.vector-init-loop.21.10
             vector-init-loop.21
             tmp.19
             0
             tmp.20)))))
    (define L.vector-init-loop.21.10
      (lambda (c.78 len.22 i.24 vec.23)
        (let ((vector-init-loop.21 (mref c.78 14)))
          (if (!= (if (= len.22 i.24) 14 6) 6)
            vec.23
            (begin
              (mset! vec.23 (+ (* (arithmetic-shift-right i.24 3) 8) 5) 0)
              (call
               L.vector-init-loop.21.10
               vector-init-loop.21
               len.22
               (+ i.24 8)
               vec.23))))))
    (define L.-.72.9
      (lambda (c.77 tmp.37 tmp.38)
        (let ()
          (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
              (- tmp.37 tmp.38)
              830)
            830))))
    (define L.*.73.8
      (lambda (c.76 tmp.33 tmp.34)
        (let ()
          (if (!= (if (= (bitwise-and tmp.34 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.33 7) 0) 14 6) 6)
              (* tmp.33 (arithmetic-shift-right tmp.34 3))
              318)
            318))))
    (define L.+.74.7
      (lambda (c.75 tmp.35 tmp.36)
        (let ()
          (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.35 7) 0) 14 6) 6)
              (+ tmp.35 tmp.36)
              574)
            574))))
    (let ((|+.74|
           (let ((tmp.92 (+ (alloc 16) 2)))
             (begin (mset! tmp.92 -2 L.+.74.7) (mset! tmp.92 6 16) tmp.92)))
          (*.73
           (let ((tmp.93 (+ (alloc 16) 2)))
             (begin (mset! tmp.93 -2 L.*.73.8) (mset! tmp.93 6 16) tmp.93)))
          (|-.72|
           (let ((tmp.94 (+ (alloc 16) 2)))
             (begin (mset! tmp.94 -2 L.-.72.9) (mset! tmp.94 6 16) tmp.94)))
          (vector-init-loop.21
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.vector-init-loop.21.10)
               (mset! tmp.95 6 24)
               tmp.95)))
          (make-init-vector.1
           (let ((tmp.96 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.96 -2 L.make-init-vector.1.11)
               (mset! tmp.96 6 8)
               tmp.96)))
          (make-vector.71
           (let ((tmp.97 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.97 -2 L.make-vector.71.12)
               (mset! tmp.97 6 8)
               tmp.97)))
          (fun/vector9289.4
           (let ((tmp.98 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/vector9289.4.13)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/error9287.5
           (let ((tmp.99 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/error9287.5.14)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/vector9290.6
           (let ((tmp.100 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/vector9290.6.15)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/error9288.7
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/error9288.7.16)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/vector9292.8
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/vector9292.8.17)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/empty9296.9
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/empty9296.9.18)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/empty9295.10
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/empty9295.10.19)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/vector9291.11
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/vector9291.11.20)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/ascii-char9294.12
           (let ((tmp.106 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/ascii-char9294.12.21)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/ascii-char9293.13
           (let ((tmp.107 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/ascii-char9293.13.22)
               (mset! tmp.107 6 0)
               tmp.107))))
      (begin
        (mset! vector-init-loop.21 14 vector-init-loop.21)
        (mset! make-init-vector.1 14 vector-init-loop.21)
        (mset! make-vector.71 14 make-init-vector.1)
        (mset! fun/vector9289.4 14 fun/vector9290.6)
        (mset! fun/error9287.5 14 fun/error9288.7)
        (mset! fun/vector9290.6 14 make-vector.71)
        (mset! fun/vector9292.8 14 make-vector.71)
        (mset! fun/empty9295.10 14 fun/empty9296.9)
        (mset! fun/vector9291.11 14 fun/vector9292.8)
        (mset! fun/ascii-char9293.13 14 fun/ascii-char9294.12)
        (let ((error0.18 (call L.fun/error9287.5.14 fun/error9287.5))
              (fixnum1.17
               (call
                L.*.73.8
                *.73
                (call
                 L.+.74.7
                 |+.74|
                 (call L.-.72.9 |-.72| 80 1456)
                 (call L.*.73.8 *.73 1808 1976))
                (call
                 L.*.73.8
                 *.73
                 (call L.+.74.7 |+.74| 280 1096)
                 (call L.+.74.7 |+.74| 1328 424))))
              (vector2.16 (call L.fun/vector9289.4.13 fun/vector9289.4))
              (vector3.15 (call L.fun/vector9291.11.20 fun/vector9291.11))
              (ascii-char4.14
               (call L.fun/ascii-char9293.13.22 fun/ascii-char9293.13)))
          (call L.fun/empty9295.10.19 fun/empty9295.10))))))
(check-by-interp
 '(module
    (define L.fun/empty9343.14.18 (lambda (c.84) (let () 22)))
    (define L.fun/ascii-char9346.13.17
      (lambda (c.83)
        (let ((fun/ascii-char9347.12 (mref c.83 14)))
          (call L.fun/ascii-char9347.12.16 fun/ascii-char9347.12))))
    (define L.fun/ascii-char9347.12.16 (lambda (c.82) (let () 26414)))
    (define L.fun/void9338.11.15 (lambda (c.81) (let () 30)))
    (define L.fun/void9344.10.14
      (lambda (c.80)
        (let ((fun/void9345.7 (mref c.80 14)))
          (call L.fun/void9345.7.11 fun/void9345.7))))
    (define L.fun/ascii-char9341.9.13 (lambda (c.79) (let () 22574)))
    (define L.fun/empty9342.8.12
      (lambda (c.78)
        (let ((fun/empty9343.14 (mref c.78 14)))
          (call L.fun/empty9343.14.18 fun/empty9343.14))))
    (define L.fun/void9345.7.11 (lambda (c.77) (let () 30)))
    (define L.fun/ascii-char9340.6.10
      (lambda (c.76)
        (let ((fun/ascii-char9341.9 (mref c.76 14)))
          (call L.fun/ascii-char9341.9.13 fun/ascii-char9341.9))))
    (define L.fun/any9339.5.9 (lambda (c.75) (let () 8)))
    (define L.fun/void9337.4.8
      (lambda (c.74)
        (let ((fun/void9338.11 (mref c.74 14)))
          (call L.fun/void9338.11.15 fun/void9338.11))))
    (define L.vector?.72.7
      (lambda (c.73 tmp.64) (let () (if (= (bitwise-and tmp.64 7) 3) 14 6))))
    (let ((vector?.72
           (let ((tmp.85 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.85 -2 L.vector?.72.7)
               (mset! tmp.85 6 8)
               tmp.85)))
          (fun/void9337.4
           (let ((tmp.86 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.86 -2 L.fun/void9337.4.8)
               (mset! tmp.86 6 0)
               tmp.86)))
          (fun/any9339.5
           (let ((tmp.87 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.87 -2 L.fun/any9339.5.9)
               (mset! tmp.87 6 0)
               tmp.87)))
          (fun/ascii-char9340.6
           (let ((tmp.88 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.88 -2 L.fun/ascii-char9340.6.10)
               (mset! tmp.88 6 0)
               tmp.88)))
          (fun/void9345.7
           (let ((tmp.89 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.89 -2 L.fun/void9345.7.11)
               (mset! tmp.89 6 0)
               tmp.89)))
          (fun/empty9342.8
           (let ((tmp.90 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.90 -2 L.fun/empty9342.8.12)
               (mset! tmp.90 6 0)
               tmp.90)))
          (fun/ascii-char9341.9
           (let ((tmp.91 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.91 -2 L.fun/ascii-char9341.9.13)
               (mset! tmp.91 6 0)
               tmp.91)))
          (fun/void9344.10
           (let ((tmp.92 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.92 -2 L.fun/void9344.10.14)
               (mset! tmp.92 6 0)
               tmp.92)))
          (fun/void9338.11
           (let ((tmp.93 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.93 -2 L.fun/void9338.11.15)
               (mset! tmp.93 6 0)
               tmp.93)))
          (fun/ascii-char9347.12
           (let ((tmp.94 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.94 -2 L.fun/ascii-char9347.12.16)
               (mset! tmp.94 6 0)
               tmp.94)))
          (fun/ascii-char9346.13
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.fun/ascii-char9346.13.17)
               (mset! tmp.95 6 0)
               tmp.95)))
          (fun/empty9343.14
           (let ((tmp.96 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.96 -2 L.fun/empty9343.14.18)
               (mset! tmp.96 6 0)
               tmp.96))))
      (begin
        (mset! fun/void9337.4 14 fun/void9338.11)
        (mset! fun/ascii-char9340.6 14 fun/ascii-char9341.9)
        (mset! fun/empty9342.8 14 fun/empty9343.14)
        (mset! fun/void9344.10 14 fun/void9345.7)
        (mset! fun/ascii-char9346.13 14 fun/ascii-char9347.12)
        (let ((void0.19 (call L.fun/void9337.4.8 fun/void9337.4))
              (boolean1.18
               (call
                L.vector?.72.7
                vector?.72
                (call L.fun/any9339.5.9 fun/any9339.5)))
              (ascii-char2.17
               (call L.fun/ascii-char9340.6.10 fun/ascii-char9340.6))
              (empty3.16 (call L.fun/empty9342.8.12 fun/empty9342.8))
              (void4.15 (call L.fun/void9344.10.14 fun/void9344.10)))
          (call L.fun/ascii-char9346.13.17 fun/ascii-char9346.13))))))
(check-by-interp
 '(module
    (define L.lam.74.22
      (lambda (c.90)
        (let ((fun/any10243.13 (mref c.90 14)) (vector?.73 (mref c.90 22)))
          (call
           L.vector?.73.7
           vector?.73
           (call L.fun/any10243.13.21 fun/any10243.13)))))
    (define L.fun/any10243.13.21 (lambda (c.89) (let () 14)))
    (define L.fun/any10242.12.20 (lambda (c.88) (let () 28222)))
    (define L.fun/error10244.11.19
      (lambda (c.87)
        (let ((fun/error10245.9 (mref c.87 14)))
          (call L.fun/error10245.9.17 fun/error10245.9))))
    (define L.fun/empty10249.10.18 (lambda (c.86) (let () 22)))
    (define L.fun/error10245.9.17 (lambda (c.85) (let () 13630)))
    (define L.fun/empty10248.8.16
      (lambda (c.84)
        (let ((fun/empty10249.10 (mref c.84 14)))
          (call L.fun/empty10249.10.18 fun/empty10249.10))))
    (define L.fun/empty10246.7.15
      (lambda (c.83)
        (let ((fun/empty10247.4 (mref c.83 14)))
          (call L.fun/empty10247.4.12 fun/empty10247.4))))
    (define L.fun/vector10250.6.14
      (lambda (c.82)
        (let ((fun/vector10251.5 (mref c.82 14)))
          (call L.fun/vector10251.5.13 fun/vector10251.5))))
    (define L.fun/vector10251.5.13
      (lambda (c.81)
        (let ((make-vector.71 (mref c.81 14)))
          (call L.make-vector.71.11 make-vector.71 64))))
    (define L.fun/empty10247.4.12 (lambda (c.80) (let () 22)))
    (define L.make-vector.71.11
      (lambda (c.79 tmp.47)
        (let ((make-init-vector.1 (mref c.79 14)))
          (if (!= (if (= (bitwise-and tmp.47 7) 0) 14 6) 6)
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.47)
            2110))))
    (define L.make-init-vector.1.10
      (lambda (c.78 tmp.19)
        (let ((vector-init-loop.21 (mref c.78 14)))
          (let ((tmp.20
                 (let ((tmp.91
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.19 3)) 8))
                         3)))
                   (begin (mset! tmp.91 -3 tmp.19) tmp.91))))
            (call
             L.vector-init-loop.21.9
             vector-init-loop.21
             tmp.19
             0
             tmp.20)))))
    (define L.vector-init-loop.21.9
      (lambda (c.77 len.22 i.24 vec.23)
        (let ((vector-init-loop.21 (mref c.77 14)))
          (if (!= (if (= len.22 i.24) 14 6) 6)
            vec.23
            (begin
              (mset! vec.23 (+ (* (arithmetic-shift-right i.24 3) 8) 5) 0)
              (call
               L.vector-init-loop.21.9
               vector-init-loop.21
               len.22
               (+ i.24 8)
               vec.23))))))
    (define L.void?.72.8
      (lambda (c.76 tmp.59)
        (let () (if (= (bitwise-and tmp.59 255) 30) 14 6))))
    (define L.vector?.73.7
      (lambda (c.75 tmp.63) (let () (if (= (bitwise-and tmp.63 7) 3) 14 6))))
    (let ((vector?.73
           (let ((tmp.92 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.92 -2 L.vector?.73.7)
               (mset! tmp.92 6 8)
               tmp.92)))
          (void?.72
           (let ((tmp.93 (+ (alloc 16) 2)))
             (begin (mset! tmp.93 -2 L.void?.72.8) (mset! tmp.93 6 8) tmp.93)))
          (vector-init-loop.21
           (let ((tmp.94 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.94 -2 L.vector-init-loop.21.9)
               (mset! tmp.94 6 24)
               tmp.94)))
          (make-init-vector.1
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.make-init-vector.1.10)
               (mset! tmp.95 6 8)
               tmp.95)))
          (make-vector.71
           (let ((tmp.96 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.96 -2 L.make-vector.71.11)
               (mset! tmp.96 6 8)
               tmp.96)))
          (fun/empty10247.4
           (let ((tmp.97 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/empty10247.4.12)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/vector10251.5
           (let ((tmp.98 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/vector10251.5.13)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/vector10250.6
           (let ((tmp.99 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/vector10250.6.14)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/empty10246.7
           (let ((tmp.100 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/empty10246.7.15)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/empty10248.8
           (let ((tmp.101 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/empty10248.8.16)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/error10245.9
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/error10245.9.17)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/empty10249.10
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/empty10249.10.18)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/error10244.11
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/error10244.11.19)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/any10242.12
           (let ((tmp.105 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/any10242.12.20)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/any10243.13
           (let ((tmp.106 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/any10243.13.21)
               (mset! tmp.106 6 0)
               tmp.106))))
      (begin
        (mset! vector-init-loop.21 14 vector-init-loop.21)
        (mset! make-init-vector.1 14 vector-init-loop.21)
        (mset! make-vector.71 14 make-init-vector.1)
        (mset! fun/vector10251.5 14 make-vector.71)
        (mset! fun/vector10250.6 14 fun/vector10251.5)
        (mset! fun/empty10246.7 14 fun/empty10247.4)
        (mset! fun/empty10248.8 14 fun/empty10249.10)
        (mset! fun/error10244.11 14 fun/error10245.9)
        (let ((boolean0.18
               (call
                L.void?.72.8
                void?.72
                (call L.fun/any10242.12.20 fun/any10242.12)))
              (procedure1.17
               (let ((lam.74
                      (let ((tmp.107 (+ (alloc 32) 2)))
                        (begin
                          (mset! tmp.107 -2 L.lam.74.22)
                          (mset! tmp.107 6 0)
                          tmp.107))))
                 (begin
                   (mset! lam.74 14 fun/any10243.13)
                   (mset! lam.74 22 vector?.73)
                   lam.74)))
              (error2.16 (call L.fun/error10244.11.19 fun/error10244.11))
              (empty3.15 (call L.fun/empty10246.7.15 fun/empty10246.7))
              (empty4.14 (call L.fun/empty10248.8.16 fun/empty10248.8)))
          (call L.fun/vector10250.6.14 fun/vector10250.6))))))
(check-by-interp
 '(module
    (define L.fun/vector10780.15.21
      (lambda (c.88)
        (let ((fun/vector10781.14 (mref c.88 14)))
          (call L.fun/vector10781.14.20 fun/vector10781.14))))
    (define L.fun/vector10781.14.20
      (lambda (c.87)
        (let ((make-vector.73 (mref c.87 14)))
          (call L.make-vector.73.9 make-vector.73 64))))
    (define L.fun/ascii-char10779.13.19 (lambda (c.86) (let () 25390)))
    (define L.fun/ascii-char10778.12.18
      (lambda (c.85)
        (let ((fun/ascii-char10779.13 (mref c.85 14)))
          (call L.fun/ascii-char10779.13.19 fun/ascii-char10779.13))))
    (define L.fun/void10774.11.17
      (lambda (c.84)
        (let ((fun/void10775.8 (mref c.84 14)))
          (call L.fun/void10775.8.14 fun/void10775.8))))
    (define L.fun/void10771.10.16 (lambda (c.83) (let () 30)))
    (define L.fun/void10773.9.15 (lambda (c.82) (let () 30)))
    (define L.fun/void10775.8.14 (lambda (c.81) (let () 30)))
    (define L.fun/void10772.7.13
      (lambda (c.80)
        (let ((fun/void10773.9 (mref c.80 14)))
          (call L.fun/void10773.9.15 fun/void10773.9))))
    (define L.fun/void10776.6.12
      (lambda (c.79)
        (let ((fun/void10777.5 (mref c.79 14)))
          (call L.fun/void10777.5.11 fun/void10777.5))))
    (define L.fun/void10777.5.11 (lambda (c.78) (let () 30)))
    (define L.fun/void10770.4.10
      (lambda (c.77)
        (let ((fun/void10771.10 (mref c.77 14)))
          (call L.fun/void10771.10.16 fun/void10771.10))))
    (define L.make-vector.73.9
      (lambda (c.76 tmp.49)
        (let ((make-init-vector.1 (mref c.76 14)))
          (if (!= (if (= (bitwise-and tmp.49 7) 0) 14 6) 6)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.49)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.75 tmp.21)
        (let ((vector-init-loop.23 (mref c.75 14)))
          (let ((tmp.22
                 (let ((tmp.89
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.21 3)) 8))
                         3)))
                   (begin (mset! tmp.89 -3 tmp.21) tmp.89))))
            (call
             L.vector-init-loop.23.7
             vector-init-loop.23
             tmp.21
             0
             tmp.22)))))
    (define L.vector-init-loop.23.7
      (lambda (c.74 len.24 i.26 vec.25)
        (let ((vector-init-loop.23 (mref c.74 14)))
          (if (!= (if (= len.24 i.26) 14 6) 6)
            vec.25
            (begin
              (mset! vec.25 (+ (* (arithmetic-shift-right i.26 3) 8) 5) 0)
              (call
               L.vector-init-loop.23.7
               vector-init-loop.23
               len.24
               (+ i.26 8)
               vec.25))))))
    (let ((vector-init-loop.23
           (let ((tmp.90 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.90 -2 L.vector-init-loop.23.7)
               (mset! tmp.90 6 24)
               tmp.90)))
          (make-init-vector.1
           (let ((tmp.91 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.91 -2 L.make-init-vector.1.8)
               (mset! tmp.91 6 8)
               tmp.91)))
          (make-vector.73
           (let ((tmp.92 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.92 -2 L.make-vector.73.9)
               (mset! tmp.92 6 8)
               tmp.92)))
          (fun/void10770.4
           (let ((tmp.93 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.93 -2 L.fun/void10770.4.10)
               (mset! tmp.93 6 0)
               tmp.93)))
          (fun/void10777.5
           (let ((tmp.94 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.94 -2 L.fun/void10777.5.11)
               (mset! tmp.94 6 0)
               tmp.94)))
          (fun/void10776.6
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.fun/void10776.6.12)
               (mset! tmp.95 6 0)
               tmp.95)))
          (fun/void10772.7
           (let ((tmp.96 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.96 -2 L.fun/void10772.7.13)
               (mset! tmp.96 6 0)
               tmp.96)))
          (fun/void10775.8
           (let ((tmp.97 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/void10775.8.14)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/void10773.9
           (let ((tmp.98 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/void10773.9.15)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/void10771.10
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/void10771.10.16)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/void10774.11
           (let ((tmp.100 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/void10774.11.17)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/ascii-char10778.12
           (let ((tmp.101 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/ascii-char10778.12.18)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/ascii-char10779.13
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/ascii-char10779.13.19)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/vector10781.14
           (let ((tmp.103 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/vector10781.14.20)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/vector10780.15
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/vector10780.15.21)
               (mset! tmp.104 6 0)
               tmp.104))))
      (begin
        (mset! vector-init-loop.23 14 vector-init-loop.23)
        (mset! make-init-vector.1 14 vector-init-loop.23)
        (mset! make-vector.73 14 make-init-vector.1)
        (mset! fun/void10770.4 14 fun/void10771.10)
        (mset! fun/void10776.6 14 fun/void10777.5)
        (mset! fun/void10772.7 14 fun/void10773.9)
        (mset! fun/void10774.11 14 fun/void10775.8)
        (mset! fun/ascii-char10778.12 14 fun/ascii-char10779.13)
        (mset! fun/vector10781.14 14 make-vector.73)
        (mset! fun/vector10780.15 14 fun/vector10781.14)
        (let ((void0.20 (call L.fun/void10770.4.10 fun/void10770.4))
              (void1.19 (call L.fun/void10772.7.13 fun/void10772.7))
              (void2.18 (call L.fun/void10774.11.17 fun/void10774.11))
              (void3.17 (call L.fun/void10776.6.12 fun/void10776.6))
              (ascii-char4.16
               (call L.fun/ascii-char10778.12.18 fun/ascii-char10778.12)))
          (call L.fun/vector10780.15.21 fun/vector10780.15))))))
(check-by-interp
 '(module
    (define L.lam.77.22
      (lambda (c.93)
        (let ((fun/error11008.12 (mref c.93 14)))
          (call L.fun/error11008.12.18 fun/error11008.12))))
    (define L.fun/ascii-char11012.15.21
      (lambda (c.92)
        (let ((fun/ascii-char11013.14 (mref c.92 14)))
          (call L.fun/ascii-char11013.14.20 fun/ascii-char11013.14))))
    (define L.fun/ascii-char11013.14.20 (lambda (c.91) (let () 27438)))
    (define L.fun/void11015.13.19 (lambda (c.90) (let () 30)))
    (define L.fun/error11008.12.18
      (lambda (c.89)
        (let ((fun/error11009.10 (mref c.89 14)))
          (call L.fun/error11009.10.16 fun/error11009.10))))
    (define L.fun/void11014.11.17
      (lambda (c.88)
        (let ((fun/void11015.13 (mref c.88 14)))
          (call L.fun/void11015.13.19 fun/void11015.13))))
    (define L.fun/error11009.10.16 (lambda (c.87) (let () 62014)))
    (define L.fun/empty11016.9.15
      (lambda (c.86)
        (let ((fun/empty11017.7 (mref c.86 14)))
          (call L.fun/empty11017.7.13 fun/empty11017.7))))
    (define L.fun/void11011.8.14 (lambda (c.85) (let () 30)))
    (define L.fun/empty11017.7.13 (lambda (c.84) (let () 22)))
    (define L.fun/void11007.6.12 (lambda (c.83) (let () 30)))
    (define L.fun/void11010.5.11
      (lambda (c.82)
        (let ((fun/void11011.8 (mref c.82 14)))
          (call L.fun/void11011.8.14 fun/void11011.8))))
    (define L.fun/void11006.4.10
      (lambda (c.81)
        (let ((fun/void11007.6 (mref c.81 14)))
          (call L.fun/void11007.6.12 fun/void11007.6))))
    (define L.-.74.9
      (lambda (c.80 tmp.40 tmp.41)
        (let ()
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.+.75.8
      (lambda (c.79 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.*.76.7
      (lambda (c.78 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (* tmp.36 (arithmetic-shift-right tmp.37 3))
              318)
            318))))
    (let ((*.76
           (let ((tmp.94 (+ (alloc 16) 2)))
             (begin (mset! tmp.94 -2 L.*.76.7) (mset! tmp.94 6 16) tmp.94)))
          (|+.75|
           (let ((tmp.95 (+ (alloc 16) 2)))
             (begin (mset! tmp.95 -2 L.+.75.8) (mset! tmp.95 6 16) tmp.95)))
          (|-.74|
           (let ((tmp.96 (+ (alloc 16) 2)))
             (begin (mset! tmp.96 -2 L.-.74.9) (mset! tmp.96 6 16) tmp.96)))
          (fun/void11006.4
           (let ((tmp.97 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/void11006.4.10)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/void11010.5
           (let ((tmp.98 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/void11010.5.11)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/void11007.6
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/void11007.6.12)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/empty11017.7
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/empty11017.7.13)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/void11011.8
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/void11011.8.14)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/empty11016.9
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/empty11016.9.15)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/error11009.10
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/error11009.10.16)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/void11014.11
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/void11014.11.17)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/error11008.12
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/error11008.12.18)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/void11015.13
           (let ((tmp.106 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/void11015.13.19)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/ascii-char11013.14
           (let ((tmp.107 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/ascii-char11013.14.20)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/ascii-char11012.15
           (let ((tmp.108 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/ascii-char11012.15.21)
               (mset! tmp.108 6 0)
               tmp.108))))
      (begin
        (mset! fun/void11006.4 14 fun/void11007.6)
        (mset! fun/void11010.5 14 fun/void11011.8)
        (mset! fun/empty11016.9 14 fun/empty11017.7)
        (mset! fun/void11014.11 14 fun/void11015.13)
        (mset! fun/error11008.12 14 fun/error11009.10)
        (mset! fun/ascii-char11012.15 14 fun/ascii-char11013.14)
        (let ((fixnum0.21
               (call
                L.+.75.8
                |+.75|
                (call
                 L.-.74.9
                 |-.74|
                 (call
                  L.-.74.9
                  |-.74|
                  (call L.-.74.9 |-.74| 1352 32)
                  (call L.+.75.8 |+.75| 1704 736))
                 (call
                  L.-.74.9
                  |-.74|
                  (call L.*.76.7 *.76 1440 104)
                  (call L.*.76.7 *.76 1664 1712)))
                (call
                 L.+.75.8
                 |+.75|
                 (call
                  L.-.74.9
                  |-.74|
                  (call L.*.76.7 *.76 0 1528)
                  (call L.+.75.8 |+.75| 1648 928))
                 (call
                  L.*.76.7
                  *.76
                  (call L.-.74.9 |-.74| 1592 1080)
                  (call L.-.74.9 |-.74| 128 760)))))
              (void1.20 (call L.fun/void11006.4.10 fun/void11006.4))
              (procedure2.19
               (let ((lam.77
                      (let ((tmp.109 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.109 -2 L.lam.77.22)
                          (mset! tmp.109 6 0)
                          tmp.109))))
                 (begin (mset! lam.77 14 fun/error11008.12) lam.77)))
              (void3.18 (call L.fun/void11010.5.11 fun/void11010.5))
              (ascii-char4.17
               (call L.fun/ascii-char11012.15.21 fun/ascii-char11012.15))
              (void5.16 (call L.fun/void11014.11.17 fun/void11014.11)))
          (call L.fun/empty11016.9.15 fun/empty11016.9))))))
(check-by-interp
 '(module
    (define L.lam.75.20
      (lambda (c.89)
        (let ((|-.72| (mref c.89 14))
              (|+.74| (mref c.89 22))
              (*.73 (mref c.89 30)))
          (call
           L.*.73.8
           *.73
           (call
            L.+.74.7
            |+.74|
            (call
             L.*.73.8
             *.73
             (call L.-.72.9 |-.72| 1200 328)
             (call L.-.72.9 |-.72| 1384 800))
            (call
             L.+.74.7
             |+.74|
             (call L.+.74.7 |+.74| 1704 736)
             (call L.+.74.7 |+.74| 328 480)))
           (call
            L.*.73.8
            *.73
            (call
             L.+.74.7
             |+.74|
             (call L.+.74.7 |+.74| 16 32)
             (call L.+.74.7 |+.74| 624 1912))
            (call
             L.-.72.9
             |-.72|
             (call L.*.73.8 *.73 1824 1352)
             (call L.+.74.7 |+.74| 1584 344)))))))
    (define L.fun/ascii-char11875.13.19
      (lambda (c.88)
        (let ((fun/ascii-char11876.6 (mref c.88 14)))
          (call L.fun/ascii-char11876.6.12 fun/ascii-char11876.6))))
    (define L.fun/void11871.12.18
      (lambda (c.87)
        (let ((fun/void11872.11 (mref c.87 14)))
          (call L.fun/void11872.11.17 fun/void11872.11))))
    (define L.fun/void11872.11.17 (lambda (c.86) (let () 30)))
    (define L.fun/error11877.10.16
      (lambda (c.85)
        (let ((fun/error11878.4 (mref c.85 14)))
          (call L.fun/error11878.4.10 fun/error11878.4))))
    (define L.fun/ascii-char11874.9.15 (lambda (c.84) (let () 29230)))
    (define L.fun/ascii-char11873.8.14
      (lambda (c.83)
        (let ((fun/ascii-char11874.9 (mref c.83 14)))
          (call L.fun/ascii-char11874.9.15 fun/ascii-char11874.9))))
    (define L.fun/error11880.7.13 (lambda (c.82) (let () 43070)))
    (define L.fun/ascii-char11876.6.12 (lambda (c.81) (let () 27950)))
    (define L.fun/error11879.5.11
      (lambda (c.80)
        (let ((fun/error11880.7 (mref c.80 14)))
          (call L.fun/error11880.7.13 fun/error11880.7))))
    (define L.fun/error11878.4.10 (lambda (c.79) (let () 16446)))
    (define L.-.72.9
      (lambda (c.78 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (- tmp.38 tmp.39)
              830)
            830))))
    (define L.*.73.8
      (lambda (c.77 tmp.34 tmp.35)
        (let ()
          (if (!= (if (= (bitwise-and tmp.35 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.34 7) 0) 14 6) 6)
              (* tmp.34 (arithmetic-shift-right tmp.35 3))
              318)
            318))))
    (define L.+.74.7
      (lambda (c.76 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (+ tmp.36 tmp.37)
              574)
            574))))
    (let ((|+.74|
           (let ((tmp.90 (+ (alloc 16) 2)))
             (begin (mset! tmp.90 -2 L.+.74.7) (mset! tmp.90 6 16) tmp.90)))
          (*.73
           (let ((tmp.91 (+ (alloc 16) 2)))
             (begin (mset! tmp.91 -2 L.*.73.8) (mset! tmp.91 6 16) tmp.91)))
          (|-.72|
           (let ((tmp.92 (+ (alloc 16) 2)))
             (begin (mset! tmp.92 -2 L.-.72.9) (mset! tmp.92 6 16) tmp.92)))
          (fun/error11878.4
           (let ((tmp.93 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.93 -2 L.fun/error11878.4.10)
               (mset! tmp.93 6 0)
               tmp.93)))
          (fun/error11879.5
           (let ((tmp.94 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.94 -2 L.fun/error11879.5.11)
               (mset! tmp.94 6 0)
               tmp.94)))
          (fun/ascii-char11876.6
           (let ((tmp.95 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.95 -2 L.fun/ascii-char11876.6.12)
               (mset! tmp.95 6 0)
               tmp.95)))
          (fun/error11880.7
           (let ((tmp.96 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.96 -2 L.fun/error11880.7.13)
               (mset! tmp.96 6 0)
               tmp.96)))
          (fun/ascii-char11873.8
           (let ((tmp.97 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/ascii-char11873.8.14)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/ascii-char11874.9
           (let ((tmp.98 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/ascii-char11874.9.15)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/error11877.10
           (let ((tmp.99 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/error11877.10.16)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/void11872.11
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/void11872.11.17)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/void11871.12
           (let ((tmp.101 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/void11871.12.18)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/ascii-char11875.13
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/ascii-char11875.13.19)
               (mset! tmp.102 6 0)
               tmp.102))))
      (begin
        (mset! fun/error11879.5 14 fun/error11880.7)
        (mset! fun/ascii-char11873.8 14 fun/ascii-char11874.9)
        (mset! fun/error11877.10 14 fun/error11878.4)
        (mset! fun/void11871.12 14 fun/void11872.11)
        (mset! fun/ascii-char11875.13 14 fun/ascii-char11876.6)
        (let ((procedure0.19
               (let ((lam.75
                      (let ((tmp.103 (+ (alloc 40) 2)))
                        (begin
                          (mset! tmp.103 -2 L.lam.75.20)
                          (mset! tmp.103 6 0)
                          tmp.103))))
                 (begin
                   (mset! lam.75 14 |-.72|)
                   (mset! lam.75 22 |+.74|)
                   (mset! lam.75 30 *.73)
                   lam.75)))
              (void1.18 (call L.fun/void11871.12.18 fun/void11871.12))
              (ascii-char2.17
               (call L.fun/ascii-char11873.8.14 fun/ascii-char11873.8))
              (ascii-char3.16
               (call L.fun/ascii-char11875.13.19 fun/ascii-char11875.13))
              (error4.15 (call L.fun/error11877.10.16 fun/error11877.10))
              (error5.14 (call L.fun/error11879.5.11 fun/error11879.5)))
          (call
           L.*.73.8
           *.73
           (call
            L.-.72.9
            |-.72|
            (call
             L.+.74.7
             |+.74|
             (call L.-.72.9 |-.72| 568 240)
             (if (!= (if (= (bitwise-and procedure0.19 7) 2) 14 6) 6)
               (if (!= (if (= (mref procedure0.19 6) 0) 14 6) 6)
                 (call (mref procedure0.19 -2) procedure0.19)
                 10814)
               11070))
            (if (!= (if (= (bitwise-and procedure0.19 7) 2) 14 6) 6)
              (if (!= (if (= (mref procedure0.19 6) 0) 14 6) 6)
                (call (mref procedure0.19 -2) procedure0.19)
                10814)
              11070))
           (if (!= (if (= (bitwise-and procedure0.19 7) 2) 14 6) 6)
             (if (!= (if (= (mref procedure0.19 6) 0) 14 6) 6)
               (call (mref procedure0.19 -2) procedure0.19)
               10814)
             11070)))))))
(check-by-interp
 '(module
    (define L.fun/empty12694.17.22
      (lambda (c.93)
        (let ((fun/empty12695.15 (mref c.93 14)))
          (call L.fun/empty12695.15.20 fun/empty12695.15))))
    (define L.fun/ascii-char12704.16.21
      (lambda (c.92)
        (let ((fun/ascii-char12705.14 (mref c.92 14)))
          (call L.fun/ascii-char12705.14.19 fun/ascii-char12705.14))))
    (define L.fun/empty12695.15.20 (lambda (c.91) (let () 22)))
    (define L.fun/ascii-char12705.14.19 (lambda (c.90) (let () 23854)))
    (define L.fun/empty12693.13.18 (lambda (c.89) (let () 22)))
    (define L.fun/void12700.12.17
      (lambda (c.88)
        (let ((fun/void12701.9 (mref c.88 14)))
          (call L.fun/void12701.9.14 fun/void12701.9))))
    (define L.fun/any12702.11.16
      (lambda (c.87)
        (let ((fun/any12703.6 (mref c.87 14)))
          (call L.fun/any12703.6.11 fun/any12703.6))))
    (define L.fun/error12697.10.15 (lambda (c.86) (let () 24382)))
    (define L.fun/void12701.9.14 (lambda (c.85) (let () 30)))
    (define L.fun/error12696.8.13
      (lambda (c.84)
        (let ((fun/error12697.10 (mref c.84 14)))
          (call L.fun/error12697.10.15 fun/error12697.10))))
    (define L.fun/empty12692.7.12
      (lambda (c.83)
        (let ((fun/empty12693.13 (mref c.83 14)))
          (call L.fun/empty12693.13.18 fun/empty12693.13))))
    (define L.fun/any12703.6.11
      (lambda (c.82)
        (let ((cons.76 (mref c.82 14))) (call L.cons.76.8 cons.76 1112 3104))))
    (define L.fun/ascii-char12699.5.10 (lambda (c.81) (let () 23342)))
    (define L.fun/ascii-char12698.4.9
      (lambda (c.80)
        (let ((fun/ascii-char12699.5 (mref c.80 14)))
          (call L.fun/ascii-char12699.5.10 fun/ascii-char12699.5))))
    (define L.cons.76.8
      (lambda (c.79 tmp.71 tmp.72)
        (let ()
          (let ((tmp.94 (+ (alloc 16) 1)))
            (begin (mset! tmp.94 -1 tmp.71) (mset! tmp.94 7 tmp.72) tmp.94)))))
    (define L.empty?.77.7
      (lambda (c.78 tmp.63)
        (let () (if (= (bitwise-and tmp.63 255) 22) 14 6))))
    (let ((empty?.77
           (let ((tmp.95 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.95 -2 L.empty?.77.7)
               (mset! tmp.95 6 8)
               tmp.95)))
          (cons.76
           (let ((tmp.96 (+ (alloc 16) 2)))
             (begin (mset! tmp.96 -2 L.cons.76.8) (mset! tmp.96 6 16) tmp.96)))
          (fun/ascii-char12698.4
           (let ((tmp.97 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/ascii-char12698.4.9)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/ascii-char12699.5
           (let ((tmp.98 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/ascii-char12699.5.10)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/any12703.6
           (let ((tmp.99 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/any12703.6.11)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/empty12692.7
           (let ((tmp.100 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/empty12692.7.12)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/error12696.8
           (let ((tmp.101 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/error12696.8.13)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/void12701.9
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/void12701.9.14)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/error12697.10
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/error12697.10.15)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/any12702.11
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/any12702.11.16)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/void12700.12
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/void12700.12.17)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/empty12693.13
           (let ((tmp.106 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/empty12693.13.18)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/ascii-char12705.14
           (let ((tmp.107 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/ascii-char12705.14.19)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/empty12695.15
           (let ((tmp.108 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/empty12695.15.20)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/ascii-char12704.16
           (let ((tmp.109 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/ascii-char12704.16.21)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/empty12694.17
           (let ((tmp.110 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/empty12694.17.22)
               (mset! tmp.110 6 0)
               tmp.110))))
      (begin
        (mset! fun/ascii-char12698.4 14 fun/ascii-char12699.5)
        (mset! fun/any12703.6 14 cons.76)
        (mset! fun/empty12692.7 14 fun/empty12693.13)
        (mset! fun/error12696.8 14 fun/error12697.10)
        (mset! fun/any12702.11 14 fun/any12703.6)
        (mset! fun/void12700.12 14 fun/void12701.9)
        (mset! fun/ascii-char12704.16 14 fun/ascii-char12705.14)
        (mset! fun/empty12694.17 14 fun/empty12695.15)
        (let ((empty0.23 (call L.fun/empty12692.7.12 fun/empty12692.7))
              (empty1.22 (call L.fun/empty12694.17.22 fun/empty12694.17))
              (error2.21 (call L.fun/error12696.8.13 fun/error12696.8))
              (ascii-char3.20
               (call L.fun/ascii-char12698.4.9 fun/ascii-char12698.4))
              (void4.19 (call L.fun/void12700.12.17 fun/void12700.12))
              (boolean5.18
               (call
                L.empty?.77.7
                empty?.77
                (call L.fun/any12702.11.16 fun/any12702.11))))
          (call L.fun/ascii-char12704.16.21 fun/ascii-char12704.16))))))
(check-by-interp
 '(module
    (define L.lam.77.22
      (lambda (c.93)
        (let ((*.75 (mref c.93 14))
              (|+.76| (mref c.93 22))
              (|-.74| (mref c.93 30)))
          (call
           L.-.74.9
           |-.74|
           (call
            L.+.76.7
            |+.76|
            (call
             L.*.75.8
             *.75
             (call L.-.74.9 |-.74| 1360 864)
             (call L.*.75.8 *.75 992 728))
            (call
             L.-.74.9
             |-.74|
             (call L.+.76.7 |+.76| 1568 992)
             (call L.-.74.9 |-.74| 232 1656)))
           (call
            L.*.75.8
            *.75
            (call
             L.+.76.7
             |+.76|
             (call L.-.74.9 |-.74| 592 200)
             (call L.*.75.8 *.75 320 1800))
            (call
             L.-.74.9
             |-.74|
             (call L.+.76.7 |+.76| 736 1392)
             (call L.*.75.8 *.75 1768 1576)))))))
    (define L.fun/error12708.15.21
      (lambda (c.92)
        (let ((fun/error12709.10 (mref c.92 14)))
          (call L.fun/error12709.10.16 fun/error12709.10))))
    (define L.fun/ascii-char12711.14.20 (lambda (c.91) (let () 29998)))
    (define L.fun/ascii-char12712.13.19
      (lambda (c.90)
        (let ((fun/ascii-char12713.6 (mref c.90 14)))
          (call L.fun/ascii-char12713.6.12 fun/ascii-char12713.6))))
    (define L.fun/ascii-char12718.12.18
      (lambda (c.89)
        (let ((fun/ascii-char12719.11 (mref c.89 14)))
          (call L.fun/ascii-char12719.11.17 fun/ascii-char12719.11))))
    (define L.fun/ascii-char12719.11.17 (lambda (c.88) (let () 23342)))
    (define L.fun/error12709.10.16 (lambda (c.87) (let () 17214)))
    (define L.fun/error12716.9.15
      (lambda (c.86)
        (let ((fun/error12717.8 (mref c.86 14)))
          (call L.fun/error12717.8.14 fun/error12717.8))))
    (define L.fun/error12717.8.14 (lambda (c.85) (let () 33086)))
    (define L.fun/ascii-char12710.7.13
      (lambda (c.84)
        (let ((fun/ascii-char12711.14 (mref c.84 14)))
          (call L.fun/ascii-char12711.14.20 fun/ascii-char12711.14))))
    (define L.fun/ascii-char12713.6.12 (lambda (c.83) (let () 17710)))
    (define L.fun/ascii-char12714.5.11
      (lambda (c.82)
        (let ((fun/ascii-char12715.4 (mref c.82 14)))
          (call L.fun/ascii-char12715.4.10 fun/ascii-char12715.4))))
    (define L.fun/ascii-char12715.4.10 (lambda (c.81) (let () 26926)))
    (define L.-.74.9
      (lambda (c.80 tmp.40 tmp.41)
        (let ()
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.*.75.8
      (lambda (c.79 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (* tmp.36 (arithmetic-shift-right tmp.37 3))
              318)
            318))))
    (define L.+.76.7
      (lambda (c.78 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (+ tmp.38 tmp.39)
              574)
            574))))
    (let ((|+.76|
           (let ((tmp.94 (+ (alloc 16) 2)))
             (begin (mset! tmp.94 -2 L.+.76.7) (mset! tmp.94 6 16) tmp.94)))
          (*.75
           (let ((tmp.95 (+ (alloc 16) 2)))
             (begin (mset! tmp.95 -2 L.*.75.8) (mset! tmp.95 6 16) tmp.95)))
          (|-.74|
           (let ((tmp.96 (+ (alloc 16) 2)))
             (begin (mset! tmp.96 -2 L.-.74.9) (mset! tmp.96 6 16) tmp.96)))
          (fun/ascii-char12715.4
           (let ((tmp.97 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/ascii-char12715.4.10)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/ascii-char12714.5
           (let ((tmp.98 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/ascii-char12714.5.11)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/ascii-char12713.6
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/ascii-char12713.6.12)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/ascii-char12710.7
           (let ((tmp.100 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/ascii-char12710.7.13)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/error12717.8
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/error12717.8.14)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/error12716.9
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/error12716.9.15)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/error12709.10
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/error12709.10.16)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/ascii-char12719.11
           (let ((tmp.104 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/ascii-char12719.11.17)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/ascii-char12718.12
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/ascii-char12718.12.18)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/ascii-char12712.13
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/ascii-char12712.13.19)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/ascii-char12711.14
           (let ((tmp.107 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/ascii-char12711.14.20)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/error12708.15
           (let ((tmp.108 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/error12708.15.21)
               (mset! tmp.108 6 0)
               tmp.108))))
      (begin
        (mset! fun/ascii-char12714.5 14 fun/ascii-char12715.4)
        (mset! fun/ascii-char12710.7 14 fun/ascii-char12711.14)
        (mset! fun/error12716.9 14 fun/error12717.8)
        (mset! fun/ascii-char12718.12 14 fun/ascii-char12719.11)
        (mset! fun/ascii-char12712.13 14 fun/ascii-char12713.6)
        (mset! fun/error12708.15 14 fun/error12709.10)
        (let ((error0.21 (call L.fun/error12708.15.21 fun/error12708.15))
              (procedure1.20
               (let ((lam.77
                      (let ((tmp.109 (+ (alloc 40) 2)))
                        (begin
                          (mset! tmp.109 -2 L.lam.77.22)
                          (mset! tmp.109 6 0)
                          tmp.109))))
                 (begin
                   (mset! lam.77 14 *.75)
                   (mset! lam.77 22 |+.76|)
                   (mset! lam.77 30 |-.74|)
                   lam.77)))
              (ascii-char2.19
               (call L.fun/ascii-char12710.7.13 fun/ascii-char12710.7))
              (ascii-char3.18
               (call L.fun/ascii-char12712.13.19 fun/ascii-char12712.13))
              (ascii-char4.17
               (call L.fun/ascii-char12714.5.11 fun/ascii-char12714.5))
              (error5.16 (call L.fun/error12716.9.15 fun/error12716.9)))
          (call L.fun/ascii-char12718.12.18 fun/ascii-char12718.12))))))
(check-by-interp
 '(module
    (define L.fun/error14513.13.19 (lambda (c.87) (let () 4926)))
    (define L.fun/error14512.12.18
      (lambda (c.86)
        (let ((fun/error14513.13 (mref c.86 14)))
          (call L.fun/error14513.13.19 fun/error14513.13))))
    (define L.fun/error14509.11.17 (lambda (c.85) (let () 48958)))
    (define L.fun/error14508.10.16
      (lambda (c.84)
        (let ((fun/error14509.11 (mref c.84 14)))
          (call L.fun/error14509.11.17 fun/error14509.11))))
    (define L.fun/ascii-char14517.9.15 (lambda (c.83) (let () 25390)))
    (define L.fun/ascii-char14510.8.14
      (lambda (c.82)
        (let ((fun/ascii-char14511.4 (mref c.82 14)))
          (call L.fun/ascii-char14511.4.10 fun/ascii-char14511.4))))
    (define L.fun/error14515.7.13 (lambda (c.81) (let () 55870)))
    (define L.fun/error14514.6.12
      (lambda (c.80)
        (let ((fun/error14515.7 (mref c.80 14)))
          (call L.fun/error14515.7.13 fun/error14515.7))))
    (define L.fun/ascii-char14516.5.11
      (lambda (c.79)
        (let ((fun/ascii-char14517.9 (mref c.79 14)))
          (call L.fun/ascii-char14517.9.15 fun/ascii-char14517.9))))
    (define L.fun/ascii-char14511.4.10 (lambda (c.78) (let () 17710)))
    (define L.*.72.9
      (lambda (c.77 tmp.34 tmp.35)
        (let ()
          (if (!= (if (= (bitwise-and tmp.35 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.34 7) 0) 14 6) 6)
              (* tmp.34 (arithmetic-shift-right tmp.35 3))
              318)
            318))))
    (define L.-.73.8
      (lambda (c.76 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (- tmp.38 tmp.39)
              830)
            830))))
    (define L.+.74.7
      (lambda (c.75 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (+ tmp.36 tmp.37)
              574)
            574))))
    (let ((|+.74|
           (let ((tmp.88 (+ (alloc 16) 2)))
             (begin (mset! tmp.88 -2 L.+.74.7) (mset! tmp.88 6 16) tmp.88)))
          (|-.73|
           (let ((tmp.89 (+ (alloc 16) 2)))
             (begin (mset! tmp.89 -2 L.-.73.8) (mset! tmp.89 6 16) tmp.89)))
          (*.72
           (let ((tmp.90 (+ (alloc 16) 2)))
             (begin (mset! tmp.90 -2 L.*.72.9) (mset! tmp.90 6 16) tmp.90)))
          (fun/ascii-char14511.4
           (let ((tmp.91 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.91 -2 L.fun/ascii-char14511.4.10)
               (mset! tmp.91 6 0)
               tmp.91)))
          (fun/ascii-char14516.5
           (let ((tmp.92 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.92 -2 L.fun/ascii-char14516.5.11)
               (mset! tmp.92 6 0)
               tmp.92)))
          (fun/error14514.6
           (let ((tmp.93 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.93 -2 L.fun/error14514.6.12)
               (mset! tmp.93 6 0)
               tmp.93)))
          (fun/error14515.7
           (let ((tmp.94 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.94 -2 L.fun/error14515.7.13)
               (mset! tmp.94 6 0)
               tmp.94)))
          (fun/ascii-char14510.8
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.fun/ascii-char14510.8.14)
               (mset! tmp.95 6 0)
               tmp.95)))
          (fun/ascii-char14517.9
           (let ((tmp.96 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.96 -2 L.fun/ascii-char14517.9.15)
               (mset! tmp.96 6 0)
               tmp.96)))
          (fun/error14508.10
           (let ((tmp.97 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/error14508.10.16)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/error14509.11
           (let ((tmp.98 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/error14509.11.17)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/error14512.12
           (let ((tmp.99 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/error14512.12.18)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/error14513.13
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/error14513.13.19)
               (mset! tmp.100 6 0)
               tmp.100))))
      (begin
        (mset! fun/ascii-char14516.5 14 fun/ascii-char14517.9)
        (mset! fun/error14514.6 14 fun/error14515.7)
        (mset! fun/ascii-char14510.8 14 fun/ascii-char14511.4)
        (mset! fun/error14508.10 14 fun/error14509.11)
        (mset! fun/error14512.12 14 fun/error14513.13)
        (let ((error0.19 (call L.fun/error14508.10.16 fun/error14508.10))
              (fixnum1.18
               (call
                L.+.74.7
                |+.74|
                (call
                 L.+.74.7
                 |+.74|
                 (call
                  L.+.74.7
                  |+.74|
                  (call L.*.72.9 *.72 1960 824)
                  (call L.-.73.8 |-.73| 112 728))
                 (call
                  L.*.72.9
                  *.72
                  (call L.*.72.9 *.72 976 520)
                  (call L.*.72.9 *.72 472 392)))
                (call
                 L.-.73.8
                 |-.73|
                 (call
                  L.*.72.9
                  *.72
                  (call L.+.74.7 |+.74| 1360 1944)
                  (call L.+.74.7 |+.74| 1816 496))
                 (call
                  L.-.73.8
                  |-.73|
                  (call L.*.72.9 *.72 1320 1216)
                  (call L.*.72.9 *.72 272 1872)))))
              (fixnum2.17
               (call
                L.-.73.8
                |-.73|
                (call
                 L.-.73.8
                 |-.73|
                 (call
                  L.*.72.9
                  *.72
                  (call L.-.73.8 |-.73| 224 1744)
                  (call L.+.74.7 |+.74| 1752 1304))
                 (call
                  L.*.72.9
                  *.72
                  (call L.-.73.8 |-.73| 264 344)
                  (call L.*.72.9 *.72 1872 1848)))
                (call
                 L.+.74.7
                 |+.74|
                 (call
                  L.-.73.8
                  |-.73|
                  (call L.-.73.8 |-.73| 496 1696)
                  (call L.-.73.8 |-.73| 1312 1736))
                 (call
                  L.-.73.8
                  |-.73|
                  (call L.*.72.9 *.72 1672 304)
                  (call L.-.73.8 |-.73| 1792 1864)))))
              (ascii-char3.16
               (call L.fun/ascii-char14510.8.14 fun/ascii-char14510.8))
              (error4.15 (call L.fun/error14512.12.18 fun/error14512.12))
              (error5.14 (call L.fun/error14514.6.12 fun/error14514.6)))
          (call L.fun/ascii-char14516.5.11 fun/ascii-char14516.5))))))
(check-by-interp
 '(module
    (define L.lam.74.19
      (lambda (c.87)
        (let ((fun/error14882.7 (mref c.87 14)))
          (call L.fun/error14882.7.10 fun/error14882.7))))
    (define L.fun/empty14877.15.18 (lambda (c.86) (let () 22)))
    (define L.fun/error14878.14.17
      (lambda (c.85)
        (let ((fun/error14879.9 (mref c.85 14)))
          (call L.fun/error14879.9.12 fun/error14879.9))))
    (define L.fun/empty14876.13.16
      (lambda (c.84)
        (let ((fun/empty14877.15 (mref c.84 14)))
          (call L.fun/empty14877.15.18 fun/empty14877.15))))
    (define L.fun/ascii-char14885.12.15 (lambda (c.83) (let () 25134)))
    (define L.fun/ascii-char14884.11.14
      (lambda (c.82)
        (let ((fun/ascii-char14885.12 (mref c.82 14)))
          (call L.fun/ascii-char14885.12.15 fun/ascii-char14885.12))))
    (define L.fun/empty14887.10.13 (lambda (c.81) (let () 22)))
    (define L.fun/error14879.9.12 (lambda (c.80) (let () 29246)))
    (define L.fun/error14881.8.11 (lambda (c.79) (let () 11326)))
    (define L.fun/error14882.7.10
      (lambda (c.78)
        (let ((fun/error14883.4 (mref c.78 14)))
          (call L.fun/error14883.4.7 fun/error14883.4))))
    (define L.fun/empty14886.6.9
      (lambda (c.77)
        (let ((fun/empty14887.10 (mref c.77 14)))
          (call L.fun/empty14887.10.13 fun/empty14887.10))))
    (define L.fun/error14880.5.8
      (lambda (c.76)
        (let ((fun/error14881.8 (mref c.76 14)))
          (call L.fun/error14881.8.11 fun/error14881.8))))
    (define L.fun/error14883.4.7 (lambda (c.75) (let () 37438)))
    (let ((fun/error14883.4
           (let ((tmp.88 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.88 -2 L.fun/error14883.4.7)
               (mset! tmp.88 6 0)
               tmp.88)))
          (fun/error14880.5
           (let ((tmp.89 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.89 -2 L.fun/error14880.5.8)
               (mset! tmp.89 6 0)
               tmp.89)))
          (fun/empty14886.6
           (let ((tmp.90 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.90 -2 L.fun/empty14886.6.9)
               (mset! tmp.90 6 0)
               tmp.90)))
          (fun/error14882.7
           (let ((tmp.91 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.91 -2 L.fun/error14882.7.10)
               (mset! tmp.91 6 0)
               tmp.91)))
          (fun/error14881.8
           (let ((tmp.92 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.92 -2 L.fun/error14881.8.11)
               (mset! tmp.92 6 0)
               tmp.92)))
          (fun/error14879.9
           (let ((tmp.93 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.93 -2 L.fun/error14879.9.12)
               (mset! tmp.93 6 0)
               tmp.93)))
          (fun/empty14887.10
           (let ((tmp.94 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.94 -2 L.fun/empty14887.10.13)
               (mset! tmp.94 6 0)
               tmp.94)))
          (fun/ascii-char14884.11
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.fun/ascii-char14884.11.14)
               (mset! tmp.95 6 0)
               tmp.95)))
          (fun/ascii-char14885.12
           (let ((tmp.96 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.96 -2 L.fun/ascii-char14885.12.15)
               (mset! tmp.96 6 0)
               tmp.96)))
          (fun/empty14876.13
           (let ((tmp.97 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/empty14876.13.16)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/error14878.14
           (let ((tmp.98 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/error14878.14.17)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/empty14877.15
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/empty14877.15.18)
               (mset! tmp.99 6 0)
               tmp.99))))
      (begin
        (mset! fun/error14880.5 14 fun/error14881.8)
        (mset! fun/empty14886.6 14 fun/empty14887.10)
        (mset! fun/error14882.7 14 fun/error14883.4)
        (mset! fun/ascii-char14884.11 14 fun/ascii-char14885.12)
        (mset! fun/empty14876.13 14 fun/empty14877.15)
        (mset! fun/error14878.14 14 fun/error14879.9)
        (let ((empty0.21 (call L.fun/empty14876.13.16 fun/empty14876.13))
              (error1.20 (call L.fun/error14878.14.17 fun/error14878.14))
              (error2.19 (call L.fun/error14880.5.8 fun/error14880.5))
              (procedure3.18
               (let ((lam.74
                      (let ((tmp.100 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.100 -2 L.lam.74.19)
                          (mset! tmp.100 6 0)
                          tmp.100))))
                 (begin (mset! lam.74 14 fun/error14882.7) lam.74)))
              (ascii-char4.17
               (call L.fun/ascii-char14884.11.14 fun/ascii-char14884.11))
              (empty5.16 (call L.fun/empty14886.6.9 fun/empty14886.6)))
          (if (!= (if (= (bitwise-and procedure3.18 7) 2) 14 6) 6)
            (if (!= (if (= (mref procedure3.18 6) 0) 14 6) 6)
              (call (mref procedure3.18 -2) procedure3.18)
              10814)
            11070))))))
(check-by-interp
 '(module
    (define L.lam.79.26
      (lambda (c.99)
        (let ((fun/any15198.16 (mref c.99 14)) (ascii-char?.77 (mref c.99 22)))
          (call
           L.ascii-char?.77.7
           ascii-char?.77
           (call L.fun/any15198.16.23 fun/any15198.16)))))
    (define L.lam.78.25
      (lambda (c.98)
        (let ((fun/empty15196.4 (mref c.98 14)))
          (call L.fun/empty15196.4.11 fun/empty15196.4))))
    (define L.fun/empty15205.17.24 (lambda (c.97) (let () 22)))
    (define L.fun/any15198.16.23
      (lambda (c.96)
        (let ((fun/any15199.14 (mref c.96 14)))
          (call L.fun/any15199.14.21 fun/any15199.14))))
    (define L.fun/error15201.15.22 (lambda (c.95) (let () 52286)))
    (define L.fun/any15199.14.21 (lambda (c.94) (let () 30)))
    (define L.fun/error15200.13.20
      (lambda (c.93)
        (let ((fun/error15201.15 (mref c.93 14)))
          (call L.fun/error15201.15.22 fun/error15201.15))))
    (define L.fun/empty15204.12.19
      (lambda (c.92)
        (let ((fun/empty15205.17 (mref c.92 14)))
          (call L.fun/empty15205.17.24 fun/empty15205.17))))
    (define L.fun/vector15209.11.18
      (lambda (c.91)
        (let ((make-vector.76 (mref c.91 14)))
          (call L.make-vector.76.10 make-vector.76 64))))
    (define L.fun/empty15197.10.17 (lambda (c.90) (let () 22)))
    (define L.fun/ascii-char15203.9.16 (lambda (c.89) (let () 29230)))
    (define L.fun/vector15208.8.15
      (lambda (c.88)
        (let ((fun/vector15209.11 (mref c.88 14)))
          (call L.fun/vector15209.11.18 fun/vector15209.11))))
    (define L.fun/empty15207.7.14 (lambda (c.87) (let () 22)))
    (define L.fun/ascii-char15202.6.13
      (lambda (c.86)
        (let ((fun/ascii-char15203.9 (mref c.86 14)))
          (call L.fun/ascii-char15203.9.16 fun/ascii-char15203.9))))
    (define L.fun/empty15206.5.12
      (lambda (c.85)
        (let ((fun/empty15207.7 (mref c.85 14)))
          (call L.fun/empty15207.7.14 fun/empty15207.7))))
    (define L.fun/empty15196.4.11
      (lambda (c.84)
        (let ((fun/empty15197.10 (mref c.84 14)))
          (call L.fun/empty15197.10.17 fun/empty15197.10))))
    (define L.make-vector.76.10
      (lambda (c.83 tmp.52)
        (let ((make-init-vector.1 (mref c.83 14)))
          (if (!= (if (= (bitwise-and tmp.52 7) 0) 14 6) 6)
            (call L.make-init-vector.1.9 make-init-vector.1 tmp.52)
            2110))))
    (define L.make-init-vector.1.9
      (lambda (c.82 tmp.24)
        (let ((vector-init-loop.26 (mref c.82 14)))
          (let ((tmp.25
                 (let ((tmp.100
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.24 3)) 8))
                         3)))
                   (begin (mset! tmp.100 -3 tmp.24) tmp.100))))
            (call
             L.vector-init-loop.26.8
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.8
      (lambda (c.81 len.27 i.29 vec.28)
        (let ((vector-init-loop.26 (mref c.81 14)))
          (if (!= (if (= len.27 i.29) 14 6) 6)
            vec.28
            (begin
              (mset! vec.28 (+ (* (arithmetic-shift-right i.29 3) 8) 5) 0)
              (call
               L.vector-init-loop.26.8
               vector-init-loop.26
               len.27
               (+ i.29 8)
               vec.28))))))
    (define L.ascii-char?.77.7
      (lambda (c.80 tmp.65)
        (let () (if (= (bitwise-and tmp.65 255) 46) 14 6))))
    (let ((ascii-char?.77
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.101 -2 L.ascii-char?.77.7)
               (mset! tmp.101 6 8)
               tmp.101)))
          (vector-init-loop.26
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.vector-init-loop.26.8)
               (mset! tmp.102 6 24)
               tmp.102)))
          (make-init-vector.1
           (let ((tmp.103 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.103 -2 L.make-init-vector.1.9)
               (mset! tmp.103 6 8)
               tmp.103)))
          (make-vector.76
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.make-vector.76.10)
               (mset! tmp.104 6 8)
               tmp.104)))
          (fun/empty15196.4
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/empty15196.4.11)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/empty15206.5
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/empty15206.5.12)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/ascii-char15202.6
           (let ((tmp.107 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/ascii-char15202.6.13)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/empty15207.7
           (let ((tmp.108 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/empty15207.7.14)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/vector15208.8
           (let ((tmp.109 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/vector15208.8.15)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/ascii-char15203.9
           (let ((tmp.110 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/ascii-char15203.9.16)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/empty15197.10
           (let ((tmp.111 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/empty15197.10.17)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/vector15209.11
           (let ((tmp.112 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.112 -2 L.fun/vector15209.11.18)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/empty15204.12
           (let ((tmp.113 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.113 -2 L.fun/empty15204.12.19)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/error15200.13
           (let ((tmp.114 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.114 -2 L.fun/error15200.13.20)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/any15199.14
           (let ((tmp.115 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.115 -2 L.fun/any15199.14.21)
               (mset! tmp.115 6 0)
               tmp.115)))
          (fun/error15201.15
           (let ((tmp.116 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.116 -2 L.fun/error15201.15.22)
               (mset! tmp.116 6 0)
               tmp.116)))
          (fun/any15198.16
           (let ((tmp.117 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.117 -2 L.fun/any15198.16.23)
               (mset! tmp.117 6 0)
               tmp.117)))
          (fun/empty15205.17
           (let ((tmp.118 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.118 -2 L.fun/empty15205.17.24)
               (mset! tmp.118 6 0)
               tmp.118))))
      (begin
        (mset! vector-init-loop.26 14 vector-init-loop.26)
        (mset! make-init-vector.1 14 vector-init-loop.26)
        (mset! make-vector.76 14 make-init-vector.1)
        (mset! fun/empty15196.4 14 fun/empty15197.10)
        (mset! fun/empty15206.5 14 fun/empty15207.7)
        (mset! fun/ascii-char15202.6 14 fun/ascii-char15203.9)
        (mset! fun/vector15208.8 14 fun/vector15209.11)
        (mset! fun/vector15209.11 14 make-vector.76)
        (mset! fun/empty15204.12 14 fun/empty15205.17)
        (mset! fun/error15200.13 14 fun/error15201.15)
        (mset! fun/any15198.16 14 fun/any15199.14)
        (let ((procedure0.23
               (let ((lam.78
                      (let ((tmp.119 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.119 -2 L.lam.78.25)
                          (mset! tmp.119 6 0)
                          tmp.119))))
                 (begin (mset! lam.78 14 fun/empty15196.4) lam.78)))
              (procedure1.22
               (let ((lam.79
                      (let ((tmp.120 (+ (alloc 32) 2)))
                        (begin
                          (mset! tmp.120 -2 L.lam.79.26)
                          (mset! tmp.120 6 0)
                          tmp.120))))
                 (begin
                   (mset! lam.79 14 fun/any15198.16)
                   (mset! lam.79 22 ascii-char?.77)
                   lam.79)))
              (error2.21 (call L.fun/error15200.13.20 fun/error15200.13))
              (ascii-char3.20
               (call L.fun/ascii-char15202.6.13 fun/ascii-char15202.6))
              (empty4.19 (call L.fun/empty15204.12.19 fun/empty15204.12))
              (empty5.18 (call L.fun/empty15206.5.12 fun/empty15206.5)))
          (call L.fun/vector15208.8.15 fun/vector15208.8))))))
(check-by-interp
 '(module
    (define L.fun/void17417.17.23 (lambda (c.93) (let () 30)))
    (define L.fun/error17406.16.22
      (lambda (c.92)
        (let ((fun/error17407.14 (mref c.92 14)))
          (call L.fun/error17407.14.20 fun/error17407.14))))
    (define L.fun/error17411.15.21 (lambda (c.91) (let () 10814)))
    (define L.fun/error17407.14.20 (lambda (c.90) (let () 54078)))
    (define L.fun/error17412.13.19
      (lambda (c.89)
        (let ((fun/error17413.11 (mref c.89 14)))
          (call L.fun/error17413.11.17 fun/error17413.11))))
    (define L.fun/ascii-char17414.12.18
      (lambda (c.88)
        (let ((fun/ascii-char17415.6 (mref c.88 14)))
          (call L.fun/ascii-char17415.6.12 fun/ascii-char17415.6))))
    (define L.fun/error17413.11.17 (lambda (c.87) (let () 13886)))
    (define L.fun/void17416.10.16
      (lambda (c.86)
        (let ((fun/void17417.17 (mref c.86 14)))
          (call L.fun/void17417.17.23 fun/void17417.17))))
    (define L.fun/vector17409.9.15
      (lambda (c.85)
        (let ((make-vector.76 (mref c.85 14)))
          (call L.make-vector.76.9 make-vector.76 64))))
    (define L.fun/error17410.8.14
      (lambda (c.84)
        (let ((fun/error17411.15 (mref c.84 14)))
          (call L.fun/error17411.15.21 fun/error17411.15))))
    (define L.fun/vector17419.7.13
      (lambda (c.83)
        (let ((make-vector.76 (mref c.83 14)))
          (call L.make-vector.76.9 make-vector.76 64))))
    (define L.fun/ascii-char17415.6.12 (lambda (c.82) (let () 25902)))
    (define L.fun/vector17418.5.11
      (lambda (c.81)
        (let ((fun/vector17419.7 (mref c.81 14)))
          (call L.fun/vector17419.7.13 fun/vector17419.7))))
    (define L.fun/vector17408.4.10
      (lambda (c.80)
        (let ((fun/vector17409.9 (mref c.80 14)))
          (call L.fun/vector17409.9.15 fun/vector17409.9))))
    (define L.make-vector.76.9
      (lambda (c.79 tmp.52)
        (let ((make-init-vector.1 (mref c.79 14)))
          (if (!= (if (= (bitwise-and tmp.52 7) 0) 14 6) 6)
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.52)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.78 tmp.24)
        (let ((vector-init-loop.26 (mref c.78 14)))
          (let ((tmp.25
                 (let ((tmp.94
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.24 3)) 8))
                         3)))
                   (begin (mset! tmp.94 -3 tmp.24) tmp.94))))
            (call
             L.vector-init-loop.26.7
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.7
      (lambda (c.77 len.27 i.29 vec.28)
        (let ((vector-init-loop.26 (mref c.77 14)))
          (if (!= (if (= len.27 i.29) 14 6) 6)
            vec.28
            (begin
              (mset! vec.28 (+ (* (arithmetic-shift-right i.29 3) 8) 5) 0)
              (call
               L.vector-init-loop.26.7
               vector-init-loop.26
               len.27
               (+ i.29 8)
               vec.28))))))
    (let ((vector-init-loop.26
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.vector-init-loop.26.7)
               (mset! tmp.95 6 24)
               tmp.95)))
          (make-init-vector.1
           (let ((tmp.96 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.96 -2 L.make-init-vector.1.8)
               (mset! tmp.96 6 8)
               tmp.96)))
          (make-vector.76
           (let ((tmp.97 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.97 -2 L.make-vector.76.9)
               (mset! tmp.97 6 8)
               tmp.97)))
          (fun/vector17408.4
           (let ((tmp.98 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/vector17408.4.10)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/vector17418.5
           (let ((tmp.99 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/vector17418.5.11)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/ascii-char17415.6
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/ascii-char17415.6.12)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/vector17419.7
           (let ((tmp.101 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/vector17419.7.13)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/error17410.8
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/error17410.8.14)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/vector17409.9
           (let ((tmp.103 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/vector17409.9.15)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/void17416.10
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/void17416.10.16)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/error17413.11
           (let ((tmp.105 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/error17413.11.17)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/ascii-char17414.12
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/ascii-char17414.12.18)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/error17412.13
           (let ((tmp.107 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/error17412.13.19)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/error17407.14
           (let ((tmp.108 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/error17407.14.20)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/error17411.15
           (let ((tmp.109 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/error17411.15.21)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/error17406.16
           (let ((tmp.110 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/error17406.16.22)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/void17417.17
           (let ((tmp.111 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/void17417.17.23)
               (mset! tmp.111 6 0)
               tmp.111))))
      (begin
        (mset! vector-init-loop.26 14 vector-init-loop.26)
        (mset! make-init-vector.1 14 vector-init-loop.26)
        (mset! make-vector.76 14 make-init-vector.1)
        (mset! fun/vector17408.4 14 fun/vector17409.9)
        (mset! fun/vector17418.5 14 fun/vector17419.7)
        (mset! fun/vector17419.7 14 make-vector.76)
        (mset! fun/error17410.8 14 fun/error17411.15)
        (mset! fun/vector17409.9 14 make-vector.76)
        (mset! fun/void17416.10 14 fun/void17417.17)
        (mset! fun/ascii-char17414.12 14 fun/ascii-char17415.6)
        (mset! fun/error17412.13 14 fun/error17413.11)
        (mset! fun/error17406.16 14 fun/error17407.14)
        (let ((error0.23 (call L.fun/error17406.16.22 fun/error17406.16))
              (vector1.22 (call L.fun/vector17408.4.10 fun/vector17408.4))
              (error2.21 (call L.fun/error17410.8.14 fun/error17410.8))
              (error3.20 (call L.fun/error17412.13.19 fun/error17412.13))
              (ascii-char4.19
               (call L.fun/ascii-char17414.12.18 fun/ascii-char17414.12))
              (void5.18 (call L.fun/void17416.10.16 fun/void17416.10)))
          (call L.fun/vector17418.5.11 fun/vector17418.5))))))
(check-by-interp
 '(module
    (define L.lam.78.25
      (lambda (c.97)
        (let ((fun/empty18589.13 (mref c.97 14)))
          (call L.fun/empty18589.13.22 fun/empty18589.13))))
    (define L.fun/ascii-char18591.15.24
      (lambda (c.96)
        (let ((fun/ascii-char18592.14 (mref c.96 14)))
          (call L.fun/ascii-char18592.14.23 fun/ascii-char18592.14))))
    (define L.fun/ascii-char18592.14.23 (lambda (c.95) (let () 26414)))
    (define L.fun/empty18589.13.22
      (lambda (c.94)
        (let ((fun/empty18590.10 (mref c.94 14)))
          (call L.fun/empty18590.10.19 fun/empty18590.10))))
    (define L.fun/error18585.12.21
      (lambda (c.93)
        (let ((fun/error18586.11 (mref c.93 14)))
          (call L.fun/error18586.11.20 fun/error18586.11))))
    (define L.fun/error18586.11.20 (lambda (c.92) (let () 7998)))
    (define L.fun/empty18590.10.19 (lambda (c.91) (let () 22)))
    (define L.fun/vector18595.9.18
      (lambda (c.90)
        (let ((fun/vector18596.8 (mref c.90 14)))
          (call L.fun/vector18596.8.17 fun/vector18596.8))))
    (define L.fun/vector18596.8.17
      (lambda (c.89)
        (let ((make-vector.74 (mref c.89 14)))
          (call L.make-vector.74.12 make-vector.74 64))))
    (define L.fun/empty18593.7.16
      (lambda (c.88)
        (let ((fun/empty18594.4 (mref c.88 14)))
          (call L.fun/empty18594.4.13 fun/empty18594.4))))
    (define L.fun/error18588.6.15 (lambda (c.87) (let () 28990)))
    (define L.fun/error18587.5.14
      (lambda (c.86)
        (let ((fun/error18588.6 (mref c.86 14)))
          (call L.fun/error18588.6.15 fun/error18588.6))))
    (define L.fun/empty18594.4.13 (lambda (c.85) (let () 22)))
    (define L.make-vector.74.12
      (lambda (c.84 tmp.50)
        (let ((make-init-vector.1 (mref c.84 14)))
          (if (!= (if (= (bitwise-and tmp.50 7) 0) 14 6) 6)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.83 tmp.22)
        (let ((vector-init-loop.24 (mref c.83 14)))
          (let ((tmp.23
                 (let ((tmp.98
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.22 3)) 8))
                         3)))
                   (begin (mset! tmp.98 -3 tmp.22) tmp.98))))
            (call
             L.vector-init-loop.24.10
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.10
      (lambda (c.82 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (mref c.82 14)))
          (if (!= (if (= len.25 i.27) 14 6) 6)
            vec.26
            (begin
              (mset! vec.26 (+ (* (arithmetic-shift-right i.27 3) 8) 5) 0)
              (call
               L.vector-init-loop.24.10
               vector-init-loop.24
               len.25
               (+ i.27 8)
               vec.26))))))
    (define L.-.75.9
      (lambda (c.81 tmp.40 tmp.41)
        (let ()
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.+.76.8
      (lambda (c.80 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.*.77.7
      (lambda (c.79 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (* tmp.36 (arithmetic-shift-right tmp.37 3))
              318)
            318))))
    (let ((*.77
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin (mset! tmp.99 -2 L.*.77.7) (mset! tmp.99 6 16) tmp.99)))
          (|+.76|
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin (mset! tmp.100 -2 L.+.76.8) (mset! tmp.100 6 16) tmp.100)))
          (|-.75|
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin (mset! tmp.101 -2 L.-.75.9) (mset! tmp.101 6 16) tmp.101)))
          (vector-init-loop.24
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.vector-init-loop.24.10)
               (mset! tmp.102 6 24)
               tmp.102)))
          (make-init-vector.1
           (let ((tmp.103 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.103 -2 L.make-init-vector.1.11)
               (mset! tmp.103 6 8)
               tmp.103)))
          (make-vector.74
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.make-vector.74.12)
               (mset! tmp.104 6 8)
               tmp.104)))
          (fun/empty18594.4
           (let ((tmp.105 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/empty18594.4.13)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/error18587.5
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/error18587.5.14)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/error18588.6
           (let ((tmp.107 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/error18588.6.15)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/empty18593.7
           (let ((tmp.108 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/empty18593.7.16)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/vector18596.8
           (let ((tmp.109 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/vector18596.8.17)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/vector18595.9
           (let ((tmp.110 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/vector18595.9.18)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/empty18590.10
           (let ((tmp.111 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/empty18590.10.19)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/error18586.11
           (let ((tmp.112 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.112 -2 L.fun/error18586.11.20)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/error18585.12
           (let ((tmp.113 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.113 -2 L.fun/error18585.12.21)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/empty18589.13
           (let ((tmp.114 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.114 -2 L.fun/empty18589.13.22)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/ascii-char18592.14
           (let ((tmp.115 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.115 -2 L.fun/ascii-char18592.14.23)
               (mset! tmp.115 6 0)
               tmp.115)))
          (fun/ascii-char18591.15
           (let ((tmp.116 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.116 -2 L.fun/ascii-char18591.15.24)
               (mset! tmp.116 6 0)
               tmp.116))))
      (begin
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.1 14 vector-init-loop.24)
        (mset! make-vector.74 14 make-init-vector.1)
        (mset! fun/error18587.5 14 fun/error18588.6)
        (mset! fun/empty18593.7 14 fun/empty18594.4)
        (mset! fun/vector18596.8 14 make-vector.74)
        (mset! fun/vector18595.9 14 fun/vector18596.8)
        (mset! fun/error18585.12 14 fun/error18586.11)
        (mset! fun/empty18589.13 14 fun/empty18590.10)
        (mset! fun/ascii-char18591.15 14 fun/ascii-char18592.14)
        (let ((error0.21 (call L.fun/error18585.12.21 fun/error18585.12))
              (error1.20 (call L.fun/error18587.5.14 fun/error18587.5))
              (procedure2.19
               (let ((lam.78
                      (let ((tmp.117 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.117 -2 L.lam.78.25)
                          (mset! tmp.117 6 0)
                          tmp.117))))
                 (begin (mset! lam.78 14 fun/empty18589.13) lam.78)))
              (fixnum3.18
               (call
                L.*.77.7
                *.77
                (call
                 L.-.75.9
                 |-.75|
                 (call
                  L.+.76.8
                  |+.76|
                  (call L.-.75.9 |-.75| 1032 224)
                  (call L.-.75.9 |-.75| 960 832))
                 (call
                  L.-.75.9
                  |-.75|
                  (call L.*.77.7 *.77 1416 1208)
                  (call L.+.76.8 |+.76| 16 912)))
                (call
                 L.+.76.8
                 |+.76|
                 (call
                  L.-.75.9
                  |-.75|
                  (call L.-.75.9 |-.75| 1264 1408)
                  (call L.-.75.9 |-.75| 304 1072))
                 (call
                  L.+.76.8
                  |+.76|
                  (call L.+.76.8 |+.76| 952 808)
                  (call L.+.76.8 |+.76| 416 1232)))))
              (ascii-char4.17
               (call L.fun/ascii-char18591.15.24 fun/ascii-char18591.15))
              (empty5.16 (call L.fun/empty18593.7.16 fun/empty18593.7)))
          (call L.fun/vector18595.9.18 fun/vector18595.9))))))
(check-by-interp
 '(module
    (define L.lam.78.25
      (lambda (c.97)
        (let ((fun/vector19107.5 (mref c.97 14)))
          (call L.fun/vector19107.5.14 fun/vector19107.5))))
    (define L.fun/vector19108.15.24
      (lambda (c.96)
        (let ((make-vector.74 (mref c.96 14)))
          (call L.make-vector.74.12 make-vector.74 64))))
    (define L.fun/ascii-char19112.14.23 (lambda (c.95) (let () 28718)))
    (define L.fun/ascii-char19109.13.22
      (lambda (c.94)
        (let ((fun/ascii-char19110.9 (mref c.94 14)))
          (call L.fun/ascii-char19110.9.18 fun/ascii-char19110.9))))
    (define L.fun/error19114.12.21 (lambda (c.93) (let () 2366)))
    (define L.fun/error19113.11.20
      (lambda (c.92)
        (let ((fun/error19114.12 (mref c.92 14)))
          (call L.fun/error19114.12.21 fun/error19114.12))))
    (define L.fun/ascii-char19111.10.19
      (lambda (c.91)
        (let ((fun/ascii-char19112.14 (mref c.91 14)))
          (call L.fun/ascii-char19112.14.23 fun/ascii-char19112.14))))
    (define L.fun/ascii-char19110.9.18 (lambda (c.90) (let () 23086)))
    (define L.fun/void19115.8.17
      (lambda (c.89)
        (let ((fun/void19116.6 (mref c.89 14)))
          (call L.fun/void19116.6.15 fun/void19116.6))))
    (define L.fun/empty19105.7.16
      (lambda (c.88)
        (let ((fun/empty19106.4 (mref c.88 14)))
          (call L.fun/empty19106.4.13 fun/empty19106.4))))
    (define L.fun/void19116.6.15 (lambda (c.87) (let () 30)))
    (define L.fun/vector19107.5.14
      (lambda (c.86)
        (let ((fun/vector19108.15 (mref c.86 14)))
          (call L.fun/vector19108.15.24 fun/vector19108.15))))
    (define L.fun/empty19106.4.13 (lambda (c.85) (let () 22)))
    (define L.make-vector.74.12
      (lambda (c.84 tmp.50)
        (let ((make-init-vector.1 (mref c.84 14)))
          (if (!= (if (= (bitwise-and tmp.50 7) 0) 14 6) 6)
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.83 tmp.22)
        (let ((vector-init-loop.24 (mref c.83 14)))
          (let ((tmp.23
                 (let ((tmp.98
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.22 3)) 8))
                         3)))
                   (begin (mset! tmp.98 -3 tmp.22) tmp.98))))
            (call
             L.vector-init-loop.24.10
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.10
      (lambda (c.82 len.25 i.27 vec.26)
        (let ((vector-init-loop.24 (mref c.82 14)))
          (if (!= (if (= len.25 i.27) 14 6) 6)
            vec.26
            (begin
              (mset! vec.26 (+ (* (arithmetic-shift-right i.27 3) 8) 5) 0)
              (call
               L.vector-init-loop.24.10
               vector-init-loop.24
               len.25
               (+ i.27 8)
               vec.26))))))
    (define L.-.75.9
      (lambda (c.81 tmp.40 tmp.41)
        (let ()
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.+.76.8
      (lambda (c.80 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.*.77.7
      (lambda (c.79 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (* tmp.36 (arithmetic-shift-right tmp.37 3))
              318)
            318))))
    (let ((*.77
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin (mset! tmp.99 -2 L.*.77.7) (mset! tmp.99 6 16) tmp.99)))
          (|+.76|
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin (mset! tmp.100 -2 L.+.76.8) (mset! tmp.100 6 16) tmp.100)))
          (|-.75|
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin (mset! tmp.101 -2 L.-.75.9) (mset! tmp.101 6 16) tmp.101)))
          (vector-init-loop.24
           (let ((tmp.102 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.102 -2 L.vector-init-loop.24.10)
               (mset! tmp.102 6 24)
               tmp.102)))
          (make-init-vector.1
           (let ((tmp.103 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.103 -2 L.make-init-vector.1.11)
               (mset! tmp.103 6 8)
               tmp.103)))
          (make-vector.74
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.make-vector.74.12)
               (mset! tmp.104 6 8)
               tmp.104)))
          (fun/empty19106.4
           (let ((tmp.105 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/empty19106.4.13)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/vector19107.5
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/vector19107.5.14)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/void19116.6
           (let ((tmp.107 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/void19116.6.15)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/empty19105.7
           (let ((tmp.108 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/empty19105.7.16)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/void19115.8
           (let ((tmp.109 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/void19115.8.17)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/ascii-char19110.9
           (let ((tmp.110 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/ascii-char19110.9.18)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/ascii-char19111.10
           (let ((tmp.111 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/ascii-char19111.10.19)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/error19113.11
           (let ((tmp.112 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.112 -2 L.fun/error19113.11.20)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/error19114.12
           (let ((tmp.113 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.113 -2 L.fun/error19114.12.21)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/ascii-char19109.13
           (let ((tmp.114 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.114 -2 L.fun/ascii-char19109.13.22)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/ascii-char19112.14
           (let ((tmp.115 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.115 -2 L.fun/ascii-char19112.14.23)
               (mset! tmp.115 6 0)
               tmp.115)))
          (fun/vector19108.15
           (let ((tmp.116 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.116 -2 L.fun/vector19108.15.24)
               (mset! tmp.116 6 0)
               tmp.116))))
      (begin
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.1 14 vector-init-loop.24)
        (mset! make-vector.74 14 make-init-vector.1)
        (mset! fun/vector19107.5 14 fun/vector19108.15)
        (mset! fun/empty19105.7 14 fun/empty19106.4)
        (mset! fun/void19115.8 14 fun/void19116.6)
        (mset! fun/ascii-char19111.10 14 fun/ascii-char19112.14)
        (mset! fun/error19113.11 14 fun/error19114.12)
        (mset! fun/ascii-char19109.13 14 fun/ascii-char19110.9)
        (mset! fun/vector19108.15 14 make-vector.74)
        (let ((empty0.21 (call L.fun/empty19105.7.16 fun/empty19105.7))
              (fixnum1.20
               (call
                L.*.77.7
                *.77
                (call
                 L.+.76.8
                 |+.76|
                 (call
                  L.-.75.9
                  |-.75|
                  (call L.-.75.9 |-.75| 8 888)
                  (call L.-.75.9 |-.75| 944 1120))
                 (call
                  L.*.77.7
                  *.77
                  (call L.-.75.9 |-.75| 1264 616)
                  (call L.+.76.8 |+.76| 1776 1232)))
                (call
                 L.+.76.8
                 |+.76|
                 (call
                  L.-.75.9
                  |-.75|
                  (call L.+.76.8 |+.76| 512 1584)
                  (call L.*.77.7 *.77 1576 1704))
                 (call
                  L.*.77.7
                  *.77
                  (call L.*.77.7 *.77 1648 1840)
                  (call L.+.76.8 |+.76| 936 1512)))))
              (procedure2.19
               (let ((lam.78
                      (let ((tmp.117 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.117 -2 L.lam.78.25)
                          (mset! tmp.117 6 0)
                          tmp.117))))
                 (begin (mset! lam.78 14 fun/vector19107.5) lam.78)))
              (ascii-char3.18
               (call L.fun/ascii-char19109.13.22 fun/ascii-char19109.13))
              (ascii-char4.17
               (call L.fun/ascii-char19111.10.19 fun/ascii-char19111.10))
              (error5.16 (call L.fun/error19113.11.20 fun/error19113.11)))
          (call L.fun/void19115.8.17 fun/void19115.8))))))
(check-by-interp
 '(module
    (define L.lam.77.22
      (lambda (c.93)
        (let ((fun/void20270.7 (mref c.93 14)))
          (call L.fun/void20270.7.11 fun/void20270.7))))
    (define L.fun/void20281.17.21 (lambda (c.92) (let () 30)))
    (define L.fun/ascii-char20274.16.20
      (lambda (c.91)
        (let ((fun/ascii-char20275.14 (mref c.91 14)))
          (call L.fun/ascii-char20275.14.18 fun/ascii-char20275.14))))
    (define L.fun/empty20272.15.19
      (lambda (c.90)
        (let ((fun/empty20273.9 (mref c.90 14)))
          (call L.fun/empty20273.9.13 fun/empty20273.9))))
    (define L.fun/ascii-char20275.14.18 (lambda (c.89) (let () 23086)))
    (define L.fun/error20276.13.17
      (lambda (c.88)
        (let ((fun/error20277.12 (mref c.88 14)))
          (call L.fun/error20277.12.16 fun/error20277.12))))
    (define L.fun/error20277.12.16 (lambda (c.87) (let () 28222)))
    (define L.fun/empty20279.11.15 (lambda (c.86) (let () 22)))
    (define L.fun/void20280.10.14
      (lambda (c.85)
        (let ((fun/void20281.17 (mref c.85 14)))
          (call L.fun/void20281.17.21 fun/void20281.17))))
    (define L.fun/empty20273.9.13 (lambda (c.84) (let () 22)))
    (define L.fun/empty20278.8.12
      (lambda (c.83)
        (let ((fun/empty20279.11 (mref c.83 14)))
          (call L.fun/empty20279.11.15 fun/empty20279.11))))
    (define L.fun/void20270.7.11
      (lambda (c.82)
        (let ((fun/void20271.5 (mref c.82 14)))
          (call L.fun/void20271.5.9 fun/void20271.5))))
    (define L.fun/any20283.6.10 (lambda (c.81) (let () 41790)))
    (define L.fun/void20271.5.9 (lambda (c.80) (let () 30)))
    (define L.fun/any20282.4.8
      (lambda (c.79)
        (let ((fun/any20283.6 (mref c.79 14)))
          (call L.fun/any20283.6.10 fun/any20283.6))))
    (define L.pair?.76.7
      (lambda (c.78 tmp.67) (let () (if (= (bitwise-and tmp.67 7) 1) 14 6))))
    (let ((pair?.76
           (let ((tmp.94 (+ (alloc 16) 2)))
             (begin (mset! tmp.94 -2 L.pair?.76.7) (mset! tmp.94 6 8) tmp.94)))
          (fun/any20282.4
           (let ((tmp.95 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.95 -2 L.fun/any20282.4.8)
               (mset! tmp.95 6 0)
               tmp.95)))
          (fun/void20271.5
           (let ((tmp.96 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.96 -2 L.fun/void20271.5.9)
               (mset! tmp.96 6 0)
               tmp.96)))
          (fun/any20283.6
           (let ((tmp.97 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.97 -2 L.fun/any20283.6.10)
               (mset! tmp.97 6 0)
               tmp.97)))
          (fun/void20270.7
           (let ((tmp.98 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.98 -2 L.fun/void20270.7.11)
               (mset! tmp.98 6 0)
               tmp.98)))
          (fun/empty20278.8
           (let ((tmp.99 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.99 -2 L.fun/empty20278.8.12)
               (mset! tmp.99 6 0)
               tmp.99)))
          (fun/empty20273.9
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.100 -2 L.fun/empty20273.9.13)
               (mset! tmp.100 6 0)
               tmp.100)))
          (fun/void20280.10
           (let ((tmp.101 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.101 -2 L.fun/void20280.10.14)
               (mset! tmp.101 6 0)
               tmp.101)))
          (fun/empty20279.11
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.102 -2 L.fun/empty20279.11.15)
               (mset! tmp.102 6 0)
               tmp.102)))
          (fun/error20277.12
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/error20277.12.16)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/error20276.13
           (let ((tmp.104 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/error20276.13.17)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/ascii-char20275.14
           (let ((tmp.105 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/ascii-char20275.14.18)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/empty20272.15
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/empty20272.15.19)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/ascii-char20274.16
           (let ((tmp.107 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/ascii-char20274.16.20)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/void20281.17
           (let ((tmp.108 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/void20281.17.21)
               (mset! tmp.108 6 0)
               tmp.108))))
      (begin
        (mset! fun/any20282.4 14 fun/any20283.6)
        (mset! fun/void20270.7 14 fun/void20271.5)
        (mset! fun/empty20278.8 14 fun/empty20279.11)
        (mset! fun/void20280.10 14 fun/void20281.17)
        (mset! fun/error20276.13 14 fun/error20277.12)
        (mset! fun/empty20272.15 14 fun/empty20273.9)
        (mset! fun/ascii-char20274.16 14 fun/ascii-char20275.14)
        (let ((procedure0.23
               (let ((lam.77
                      (let ((tmp.109 (+ (alloc 24) 2)))
                        (begin
                          (mset! tmp.109 -2 L.lam.77.22)
                          (mset! tmp.109 6 0)
                          tmp.109))))
                 (begin (mset! lam.77 14 fun/void20270.7) lam.77)))
              (empty1.22 (call L.fun/empty20272.15.19 fun/empty20272.15))
              (ascii-char2.21
               (call L.fun/ascii-char20274.16.20 fun/ascii-char20274.16))
              (error3.20 (call L.fun/error20276.13.17 fun/error20276.13))
              (empty4.19 (call L.fun/empty20278.8.12 fun/empty20278.8))
              (void5.18 (call L.fun/void20280.10.14 fun/void20280.10)))
          (call
           L.pair?.76.7
           pair?.76
           (call L.fun/any20282.4.8 fun/any20282.4)))))))
(check-by-interp
 '(module
    (define L.fun/any21160.15.26
      (lambda (c.99)
        (let ((fun/any21161.5 (mref c.99 14)))
          (call L.fun/any21161.5.16 fun/any21161.5))))
    (define L.fun/error21157.14.25 (lambda (c.98) (let () 26430)))
    (define L.fun/vector21158.13.24
      (lambda (c.97)
        (let ((fun/vector21159.11 (mref c.97 14)))
          (call L.fun/vector21159.11.22 fun/vector21159.11))))
    (define L.fun/void21167.12.23 (lambda (c.96) (let () 30)))
    (define L.fun/vector21159.11.22
      (lambda (c.95)
        (let ((make-vector.74 (mref c.95 14)))
          (call L.make-vector.74.14 make-vector.74 64))))
    (define L.fun/error21156.10.21
      (lambda (c.94)
        (let ((fun/error21157.14 (mref c.94 14)))
          (call L.fun/error21157.14.25 fun/error21157.14))))
    (define L.fun/void21166.9.20
      (lambda (c.93)
        (let ((fun/void21167.12 (mref c.93 14)))
          (call L.fun/void21167.12.23 fun/void21167.12))))
    (define L.fun/empty21162.8.19
      (lambda (c.92)
        (let ((fun/empty21163.4 (mref c.92 14)))
          (call L.fun/empty21163.4.15 fun/empty21163.4))))
    (define L.fun/any21164.7.18
      (lambda (c.91)
        (let ((fun/any21165.6 (mref c.91 14)))
          (call L.fun/any21165.6.17 fun/any21165.6))))
    (define L.fun/any21165.6.17
      (lambda (c.90)
        (let ((make-vector.74 (mref c.90 14)))
          (call L.make-vector.74.14 make-vector.74 64))))
    (define L.fun/any21161.5.16 (lambda (c.89) (let () 1488)))
    (define L.fun/empty21163.4.15 (lambda (c.88) (let () 22)))
    (define L.make-vector.74.14
      (lambda (c.87 tmp.50)
        (let ((make-init-vector.1 (mref c.87 14)))
          (if (!= (if (= (bitwise-and tmp.50 7) 0) 14 6) 6)
            (call L.make-init-vector.1.13 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.13
      (lambda (c.86 tmp.22)
        (let ((vector-init-loop.24 (mref c.86 14)))
          (let ((tmp.23
                 (let ((tmp.100
                        (+
                         (alloc (* (+ 1 (arithmetic-shift-right tmp.22 3)) 8))
                         3)))
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
          (if (!= (if (= len.25 i.27) 14 6) 6)
            vec.26
            (begin
              (mset! vec.26 (+ (* (arithmetic-shift-right i.27 3) 8) 5) 0)
              (call
               L.vector-init-loop.24.12
               vector-init-loop.24
               len.25
               (+ i.27 8)
               vec.26))))))
    (define L.empty?.75.11
      (lambda (c.84 tmp.61)
        (let () (if (= (bitwise-and tmp.61 255) 22) 14 6))))
    (define L.-.76.10
      (lambda (c.83 tmp.40 tmp.41)
        (let ()
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.*.77.9
      (lambda (c.82 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (* tmp.36 (arithmetic-shift-right tmp.37 3))
              318)
            318))))
    (define L.+.78.8
      (lambda (c.81 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.vector?.79.7
      (lambda (c.80 tmp.66) (let () (if (= (bitwise-and tmp.66 7) 3) 14 6))))
    (let ((vector?.79
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.101 -2 L.vector?.79.7)
               (mset! tmp.101 6 8)
               tmp.101)))
          (|+.78|
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin (mset! tmp.102 -2 L.+.78.8) (mset! tmp.102 6 16) tmp.102)))
          (*.77
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin (mset! tmp.103 -2 L.*.77.9) (mset! tmp.103 6 16) tmp.103)))
          (|-.76|
           (let ((tmp.104 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.104 -2 L.-.76.10)
               (mset! tmp.104 6 16)
               tmp.104)))
          (empty?.75
           (let ((tmp.105 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.105 -2 L.empty?.75.11)
               (mset! tmp.105 6 8)
               tmp.105)))
          (vector-init-loop.24
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.vector-init-loop.24.12)
               (mset! tmp.106 6 24)
               tmp.106)))
          (make-init-vector.1
           (let ((tmp.107 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.107 -2 L.make-init-vector.1.13)
               (mset! tmp.107 6 8)
               tmp.107)))
          (make-vector.74
           (let ((tmp.108 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.108 -2 L.make-vector.74.14)
               (mset! tmp.108 6 8)
               tmp.108)))
          (fun/empty21163.4
           (let ((tmp.109 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/empty21163.4.15)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/any21161.5
           (let ((tmp.110 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/any21161.5.16)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/any21165.6
           (let ((tmp.111 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/any21165.6.17)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/any21164.7
           (let ((tmp.112 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.112 -2 L.fun/any21164.7.18)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/empty21162.8
           (let ((tmp.113 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.113 -2 L.fun/empty21162.8.19)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/void21166.9
           (let ((tmp.114 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.114 -2 L.fun/void21166.9.20)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/error21156.10
           (let ((tmp.115 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.115 -2 L.fun/error21156.10.21)
               (mset! tmp.115 6 0)
               tmp.115)))
          (fun/vector21159.11
           (let ((tmp.116 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.116 -2 L.fun/vector21159.11.22)
               (mset! tmp.116 6 0)
               tmp.116)))
          (fun/void21167.12
           (let ((tmp.117 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.117 -2 L.fun/void21167.12.23)
               (mset! tmp.117 6 0)
               tmp.117)))
          (fun/vector21158.13
           (let ((tmp.118 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.118 -2 L.fun/vector21158.13.24)
               (mset! tmp.118 6 0)
               tmp.118)))
          (fun/error21157.14
           (let ((tmp.119 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.119 -2 L.fun/error21157.14.25)
               (mset! tmp.119 6 0)
               tmp.119)))
          (fun/any21160.15
           (let ((tmp.120 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.120 -2 L.fun/any21160.15.26)
               (mset! tmp.120 6 0)
               tmp.120))))
      (begin
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.1 14 vector-init-loop.24)
        (mset! make-vector.74 14 make-init-vector.1)
        (mset! fun/any21165.6 14 make-vector.74)
        (mset! fun/any21164.7 14 fun/any21165.6)
        (mset! fun/empty21162.8 14 fun/empty21163.4)
        (mset! fun/void21166.9 14 fun/void21167.12)
        (mset! fun/error21156.10 14 fun/error21157.14)
        (mset! fun/vector21159.11 14 make-vector.74)
        (mset! fun/vector21158.13 14 fun/vector21159.11)
        (mset! fun/any21160.15 14 fun/any21161.5)
        (let ((error0.21 (call L.fun/error21156.10.21 fun/error21156.10))
              (vector1.20 (call L.fun/vector21158.13.24 fun/vector21158.13))
              (boolean2.19
               (call
                L.empty?.75.11
                empty?.75
                (call L.fun/any21160.15.26 fun/any21160.15)))
              (fixnum3.18
               (call
                L.*.77.9
                *.77
                (call
                 L.+.78.8
                 |+.78|
                 (call
                  L.*.77.9
                  *.77
                  (call L.-.76.10 |-.76| 208 416)
                  (call L.-.76.10 |-.76| 1088 512))
                 (call
                  L.*.77.9
                  *.77
                  (call L.-.76.10 |-.76| 296 1080)
                  (call L.*.77.9 *.77 168 1416)))
                (call
                 L.+.78.8
                 |+.78|
                 (call
                  L.-.76.10
                  |-.76|
                  (call L.-.76.10 |-.76| 448 88)
                  (call L.*.77.9 *.77 1416 1616))
                 (call
                  L.+.78.8
                  |+.78|
                  (call L.-.76.10 |-.76| 984 200)
                  (call L.-.76.10 |-.76| 1776 1048)))))
              (empty4.17 (call L.fun/empty21162.8.19 fun/empty21162.8))
              (boolean5.16
               (call
                L.vector?.79.7
                vector?.79
                (call L.fun/any21164.7.18 fun/any21164.7))))
          (call L.fun/void21166.9.20 fun/void21166.9))))))
(check-by-interp
 '(module
    (define L.fun/any23215.15.24
      (lambda (c.97)
        (let ((fun/any23216.11 (mref c.97 14)))
          (call L.fun/any23216.11.20 fun/any23216.11))))
    (define L.fun/ascii-char23226.14.23 (lambda (c.96) (let () 22830)))
    (define L.fun/error23217.13.22
      (lambda (c.95)
        (let ((fun/error23218.5 (mref c.95 14)))
          (call L.fun/error23218.5.14 fun/error23218.5))))
    (define L.fun/ascii-char23225.12.21
      (lambda (c.94)
        (let ((fun/ascii-char23226.14 (mref c.94 14)))
          (call L.fun/ascii-char23226.14.23 fun/ascii-char23226.14))))
    (define L.fun/any23216.11.20
      (lambda (c.93)
        (let ((cons.74 (mref c.93 14))) (call L.cons.74.12 cons.74 816 2720))))
    (define L.fun/void23219.10.19
      (lambda (c.92)
        (let ((fun/void23220.8 (mref c.92 14)))
          (call L.fun/void23220.8.17 fun/void23220.8))))
    (define L.fun/any23221.9.18
      (lambda (c.91)
        (let ((fun/any23222.4 (mref c.91 14)))
          (call L.fun/any23222.4.13 fun/any23222.4))))
    (define L.fun/void23220.8.17 (lambda (c.90) (let () 30)))
    (define L.fun/void23224.7.16 (lambda (c.89) (let () 30)))
    (define L.fun/void23223.6.15
      (lambda (c.88)
        (let ((fun/void23224.7 (mref c.88 14)))
          (call L.fun/void23224.7.16 fun/void23224.7))))
    (define L.fun/error23218.5.14 (lambda (c.87) (let () 46654)))
    (define L.fun/any23222.4.13
      (lambda (c.86)
        (let ((cons.74 (mref c.86 14))) (call L.cons.74.12 cons.74 320 3496))))
    (define L.cons.74.12
      (lambda (c.85 tmp.69 tmp.70)
        (let ()
          (let ((tmp.98 (+ (alloc 16) 1)))
            (begin (mset! tmp.98 -1 tmp.69) (mset! tmp.98 7 tmp.70) tmp.98)))))
    (define L.pair?.75.11
      (lambda (c.84 tmp.65) (let () (if (= (bitwise-and tmp.65 7) 1) 14 6))))
    (define L.boolean?.76.10
      (lambda (c.83 tmp.60) (let () (if (= (bitwise-and tmp.60 247) 6) 14 6))))
    (define L.+.77.9
      (lambda (c.82 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.*.78.8
      (lambda (c.81 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (* tmp.36 (arithmetic-shift-right tmp.37 3))
              318)
            318))))
    (define L.-.79.7
      (lambda (c.80 tmp.40 tmp.41)
        (let ()
          (if (!= (if (= (bitwise-and tmp.41 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.40 7) 0) 14 6) 6)
              (- tmp.40 tmp.41)
              830)
            830))))
    (let ((|-.79|
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin (mset! tmp.99 -2 L.-.79.7) (mset! tmp.99 6 16) tmp.99)))
          (*.78
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin (mset! tmp.100 -2 L.*.78.8) (mset! tmp.100 6 16) tmp.100)))
          (|+.77|
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin (mset! tmp.101 -2 L.+.77.9) (mset! tmp.101 6 16) tmp.101)))
          (boolean?.76
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.102 -2 L.boolean?.76.10)
               (mset! tmp.102 6 8)
               tmp.102)))
          (pair?.75
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.pair?.75.11)
               (mset! tmp.103 6 8)
               tmp.103)))
          (cons.74
           (let ((tmp.104 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.104 -2 L.cons.74.12)
               (mset! tmp.104 6 16)
               tmp.104)))
          (fun/any23222.4
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/any23222.4.13)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/error23218.5
           (let ((tmp.106 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/error23218.5.14)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/void23223.6
           (let ((tmp.107 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/void23223.6.15)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/void23224.7
           (let ((tmp.108 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/void23224.7.16)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/void23220.8
           (let ((tmp.109 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/void23220.8.17)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/any23221.9
           (let ((tmp.110 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/any23221.9.18)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/void23219.10
           (let ((tmp.111 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/void23219.10.19)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/any23216.11
           (let ((tmp.112 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.112 -2 L.fun/any23216.11.20)
               (mset! tmp.112 6 0)
               tmp.112)))
          (fun/ascii-char23225.12
           (let ((tmp.113 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.113 -2 L.fun/ascii-char23225.12.21)
               (mset! tmp.113 6 0)
               tmp.113)))
          (fun/error23217.13
           (let ((tmp.114 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.114 -2 L.fun/error23217.13.22)
               (mset! tmp.114 6 0)
               tmp.114)))
          (fun/ascii-char23226.14
           (let ((tmp.115 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.115 -2 L.fun/ascii-char23226.14.23)
               (mset! tmp.115 6 0)
               tmp.115)))
          (fun/any23215.15
           (let ((tmp.116 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.116 -2 L.fun/any23215.15.24)
               (mset! tmp.116 6 0)
               tmp.116))))
      (begin
        (mset! fun/any23222.4 14 cons.74)
        (mset! fun/void23223.6 14 fun/void23224.7)
        (mset! fun/any23221.9 14 fun/any23222.4)
        (mset! fun/void23219.10 14 fun/void23220.8)
        (mset! fun/any23216.11 14 cons.74)
        (mset! fun/ascii-char23225.12 14 fun/ascii-char23226.14)
        (mset! fun/error23217.13 14 fun/error23218.5)
        (mset! fun/any23215.15 14 fun/any23216.11)
        (let ((boolean0.21
               (call
                L.pair?.75.11
                pair?.75
                (call L.fun/any23215.15.24 fun/any23215.15)))
              (error1.20 (call L.fun/error23217.13.22 fun/error23217.13))
              (void2.19 (call L.fun/void23219.10.19 fun/void23219.10))
              (boolean3.18
               (call
                L.boolean?.76.10
                boolean?.76
                (call L.fun/any23221.9.18 fun/any23221.9)))
              (fixnum4.17
               (call
                L.*.78.8
                *.78
                (call
                 L.*.78.8
                 *.78
                 (call
                  L.*.78.8
                  *.78
                  (call L.+.77.9 |+.77| 1720 344)
                  (call L.*.78.8 *.78 1304 728))
                 (call
                  L.+.77.9
                  |+.77|
                  (call L.+.77.9 |+.77| 344 1728)
                  (call L.+.77.9 |+.77| 96 904)))
                (call
                 L.-.79.7
                 |-.79|
                 (call
                  L.-.79.7
                  |-.79|
                  (call L.*.78.8 *.78 1472 32)
                  (call L.+.77.9 |+.77| 1312 360))
                 (call
                  L.-.79.7
                  |-.79|
                  (call L.+.77.9 |+.77| 1296 928)
                  (call L.-.79.7 |-.79| 1640 1760)))))
              (void5.16 (call L.fun/void23223.6.15 fun/void23223.6)))
          (call L.fun/ascii-char23225.12.21 fun/ascii-char23225.12))))))
(check-by-interp
 '(module
    (define L.lam.78.23
      (lambda (c.95)
        (let ((fun/any24030.9 (mref c.95 14)) (procedure?.73 (mref c.95 22)))
          (call
           L.procedure?.73.11
           procedure?.73
           (call L.fun/any24030.9.18 fun/any24030.9)))))
    (define L.fun/empty24034.13.22
      (lambda (c.94)
        (let ((fun/empty24035.4 (mref c.94 14)))
          (call L.fun/empty24035.4.13 fun/empty24035.4))))
    (define L.fun/any24032.12.21
      (lambda (c.93)
        (let ((fun/any24033.10 (mref c.93 14)))
          (call L.fun/any24033.10.19 fun/any24033.10))))
    (define L.fun/pair24036.11.20
      (lambda (c.92)
        (let ((fun/pair24037.7 (mref c.92 14)))
          (call L.fun/pair24037.7.16 fun/pair24037.7))))
    (define L.fun/any24033.10.19 (lambda (c.91) (let () 22574)))
    (define L.fun/any24030.9.18
      (lambda (c.90)
        (let ((fun/any24031.8 (mref c.90 14)))
          (call L.fun/any24031.8.17 fun/any24031.8))))
    (define L.fun/any24031.8.17 (lambda (c.89) (let () 6)))
    (define L.fun/pair24037.7.16
      (lambda (c.88)
        (let ((cons.72 (mref c.88 14))) (call L.cons.72.12 cons.72 400 2408))))
    (define L.fun/empty24028.6.15
      (lambda (c.87)
        (let ((fun/empty24029.5 (mref c.87 14)))
          (call L.fun/empty24029.5.14 fun/empty24029.5))))
    (define L.fun/empty24029.5.14 (lambda (c.86) (let () 22)))
    (define L.fun/empty24035.4.13 (lambda (c.85) (let () 22)))
    (define L.cons.72.12
      (lambda (c.84 tmp.67 tmp.68)
        (let ()
          (let ((tmp.96 (+ (alloc 16) 1)))
            (begin (mset! tmp.96 -1 tmp.67) (mset! tmp.96 7 tmp.68) tmp.96)))))
    (define L.procedure?.73.11
      (lambda (c.83 tmp.66) (let () (if (= (bitwise-and tmp.66 7) 2) 14 6))))
    (define L.-.74.10
      (lambda (c.82 tmp.38 tmp.39)
        (let ()
          (if (!= (if (= (bitwise-and tmp.39 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.38 7) 0) 14 6) 6)
              (- tmp.38 tmp.39)
              830)
            830))))
    (define L.*.75.9
      (lambda (c.81 tmp.34 tmp.35)
        (let ()
          (if (!= (if (= (bitwise-and tmp.35 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.34 7) 0) 14 6) 6)
              (* tmp.34 (arithmetic-shift-right tmp.35 3))
              318)
            318))))
    (define L.+.76.8
      (lambda (c.80 tmp.36 tmp.37)
        (let ()
          (if (!= (if (= (bitwise-and tmp.37 7) 0) 14 6) 6)
            (if (!= (if (= (bitwise-and tmp.36 7) 0) 14 6) 6)
              (+ tmp.36 tmp.37)
              574)
            574))))
    (define L.empty?.77.7
      (lambda (c.79 tmp.59)
        (let () (if (= (bitwise-and tmp.59 255) 22) 14 6))))
    (let ((empty?.77
           (let ((tmp.97 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.97 -2 L.empty?.77.7)
               (mset! tmp.97 6 8)
               tmp.97)))
          (|+.76|
           (let ((tmp.98 (+ (alloc 16) 2)))
             (begin (mset! tmp.98 -2 L.+.76.8) (mset! tmp.98 6 16) tmp.98)))
          (*.75
           (let ((tmp.99 (+ (alloc 16) 2)))
             (begin (mset! tmp.99 -2 L.*.75.9) (mset! tmp.99 6 16) tmp.99)))
          (|-.74|
           (let ((tmp.100 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.100 -2 L.-.74.10)
               (mset! tmp.100 6 16)
               tmp.100)))
          (procedure?.73
           (let ((tmp.101 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.101 -2 L.procedure?.73.11)
               (mset! tmp.101 6 8)
               tmp.101)))
          (cons.72
           (let ((tmp.102 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.102 -2 L.cons.72.12)
               (mset! tmp.102 6 16)
               tmp.102)))
          (fun/empty24035.4
           (let ((tmp.103 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.103 -2 L.fun/empty24035.4.13)
               (mset! tmp.103 6 0)
               tmp.103)))
          (fun/empty24029.5
           (let ((tmp.104 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.104 -2 L.fun/empty24029.5.14)
               (mset! tmp.104 6 0)
               tmp.104)))
          (fun/empty24028.6
           (let ((tmp.105 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.105 -2 L.fun/empty24028.6.15)
               (mset! tmp.105 6 0)
               tmp.105)))
          (fun/pair24037.7
           (let ((tmp.106 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.106 -2 L.fun/pair24037.7.16)
               (mset! tmp.106 6 0)
               tmp.106)))
          (fun/any24031.8
           (let ((tmp.107 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.107 -2 L.fun/any24031.8.17)
               (mset! tmp.107 6 0)
               tmp.107)))
          (fun/any24030.9
           (let ((tmp.108 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.108 -2 L.fun/any24030.9.18)
               (mset! tmp.108 6 0)
               tmp.108)))
          (fun/any24033.10
           (let ((tmp.109 (+ (alloc 16) 2)))
             (begin
               (mset! tmp.109 -2 L.fun/any24033.10.19)
               (mset! tmp.109 6 0)
               tmp.109)))
          (fun/pair24036.11
           (let ((tmp.110 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.110 -2 L.fun/pair24036.11.20)
               (mset! tmp.110 6 0)
               tmp.110)))
          (fun/any24032.12
           (let ((tmp.111 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.111 -2 L.fun/any24032.12.21)
               (mset! tmp.111 6 0)
               tmp.111)))
          (fun/empty24034.13
           (let ((tmp.112 (+ (alloc 24) 2)))
             (begin
               (mset! tmp.112 -2 L.fun/empty24034.13.22)
               (mset! tmp.112 6 0)
               tmp.112))))
      (begin
        (mset! fun/empty24028.6 14 fun/empty24029.5)
        (mset! fun/pair24037.7 14 cons.72)
        (mset! fun/any24030.9 14 fun/any24031.8)
        (mset! fun/pair24036.11 14 fun/pair24037.7)
        (mset! fun/any24032.12 14 fun/any24033.10)
        (mset! fun/empty24034.13 14 fun/empty24035.4)
        (let ((empty0.19 (call L.fun/empty24028.6.15 fun/empty24028.6))
              (procedure1.18
               (let ((lam.78
                      (let ((tmp.113 (+ (alloc 32) 2)))
                        (begin
                          (mset! tmp.113 -2 L.lam.78.23)
                          (mset! tmp.113 6 0)
                          tmp.113))))
                 (begin
                   (mset! lam.78 14 fun/any24030.9)
                   (mset! lam.78 22 procedure?.73)
                   lam.78)))
              (fixnum2.17
               (call
                L.*.75.9
                *.75
                (call
                 L.+.76.8
                 |+.76|
                 (call
                  L.*.75.9
                  *.75
                  (call L.-.74.10 |-.74| 1112 912)
                  (call L.*.75.9 *.75 1808 704))
                 (call
                  L.+.76.8
                  |+.76|
                  (call L.+.76.8 |+.76| 752 360)
                  (call L.*.75.9 *.75 272 1632)))
                (call
                 L.-.74.10
                 |-.74|
                 (call
                  L.+.76.8
                  |+.76|
                  (call L.-.74.10 |-.74| 320 384)
                  (call L.+.76.8 |+.76| 536 352))
                 (call
                  L.*.75.9
                  *.75
                  (call L.-.74.10 |-.74| 968 368)
                  (call L.+.76.8 |+.76| 40 1216)))))
              (fixnum3.16
               (call
                L.*.75.9
                *.75
                (call
                 L.-.74.10
                 |-.74|
                 (call
                  L.+.76.8
                  |+.76|
                  (call L.*.75.9 *.75 2000 336)
                  (call L.+.76.8 |+.76| 320 1488))
                 (call
                  L.-.74.10
                  |-.74|
                  (call L.+.76.8 |+.76| 352 1240)
                  (call L.*.75.9 *.75 984 320)))
                (call
                 L.*.75.9
                 *.75
                 (call
                  L.+.76.8
                  |+.76|
                  (call L.-.74.10 |-.74| 1624 848)
                  (call L.*.75.9 *.75 304 48))
                 (call
                  L.*.75.9
                  *.75
                  (call L.+.76.8 |+.76| 616 800)
                  (call L.-.74.10 |-.74| 528 464)))))
              (boolean4.15
               (call
                L.empty?.77.7
                empty?.77
                (call L.fun/any24032.12.21 fun/any24032.12)))
              (empty5.14 (call L.fun/empty24034.13.22 fun/empty24034.13)))
          (call L.fun/pair24036.11.20 fun/pair24036.11))))))
