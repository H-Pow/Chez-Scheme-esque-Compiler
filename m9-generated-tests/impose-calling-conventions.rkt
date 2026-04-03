#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
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

(check-by-interp
 '(module
    (define L.cons.56.7
      (lambda (c.57 tmp.51 tmp.52)
        (begin
          (begin
            (begin (set! tmp.60 (alloc 16)) (set! tmp.58 (+ tmp.60 1)))
            (begin (mset! tmp.58 -1 tmp.51) (mset! tmp.58 7 tmp.52) tmp.58)))))
    (begin
      (begin
        (begin (set! tmp.61 (alloc 16)) (set! tmp.59 (+ tmp.61 2)))
        (begin
          (mset! tmp.59 -2 L.cons.56.7)
          (mset! tmp.59 6 16)
          (set! cons.56 tmp.59)))
      (call L.cons.56.7 cons.56 48 4008))))
(check-by-interp
 '(module
    (define L.cons.56.7
      (lambda (c.57 tmp.51 tmp.52)
        (begin
          (begin
            (begin (set! tmp.60 (alloc 16)) (set! tmp.58 (+ tmp.60 1)))
            (begin (mset! tmp.58 -1 tmp.51) (mset! tmp.58 7 tmp.52) tmp.58)))))
    (begin
      (begin
        (begin (set! tmp.61 (alloc 16)) (set! tmp.59 (+ tmp.61 2)))
        (begin
          (mset! tmp.59 -2 L.cons.56.7)
          (mset! tmp.59 6 16)
          (set! cons.56 tmp.59)))
      (call L.cons.56.7 cons.56 336 4080))))
(check-by-interp
 '(module
    (define L.fun/error8439.4.7 (lambda (c.57) (begin 37950)))
    (begin
      (begin
        (begin (set! tmp.59 (alloc 16)) (set! tmp.58 (+ tmp.59 2)))
        (begin
          (mset! tmp.58 -2 L.fun/error8439.4.7)
          (mset! tmp.58 6 0)
          (set! fun/error8439.4 tmp.58)))
      (call L.fun/error8439.4.7 fun/error8439.4))))
(check-by-interp
 '(module
    (define L.fun/error8442.4.7 (lambda (c.57) (begin 63294)))
    (begin
      (begin
        (begin (set! tmp.59 (alloc 16)) (set! tmp.58 (+ tmp.59 2)))
        (begin
          (mset! tmp.58 -2 L.fun/error8442.4.7)
          (mset! tmp.58 6 0)
          (set! fun/error8442.4 tmp.58)))
      (call L.fun/error8442.4.7 fun/error8442.4))))
(check-by-interp
 '(module
    (define L.fun/error8445.4.7 (lambda (c.57) (begin 36158)))
    (begin
      (begin
        (begin (set! tmp.59 (alloc 16)) (set! tmp.58 (+ tmp.59 2)))
        (begin
          (mset! tmp.58 -2 L.fun/error8445.4.7)
          (mset! tmp.58 6 0)
          (set! fun/error8445.4 tmp.58)))
      (call L.fun/error8445.4.7 fun/error8445.4))))
(check-by-interp
 '(module
    (define L.fun/pair8448.4.8
      (lambda (c.59)
        (begin
          (set! cons.57 (mref c.59 14))
          (call L.cons.57.7 cons.57 1464 2216))))
    (define L.cons.57.7
      (lambda (c.58 tmp.52 tmp.53)
        (begin
          (begin
            (begin (set! tmp.63 (alloc 16)) (set! tmp.60 (+ tmp.63 1)))
            (begin (mset! tmp.60 -1 tmp.52) (mset! tmp.60 7 tmp.53) tmp.60)))))
    (begin
      (begin
        (begin (set! tmp.64 (alloc 16)) (set! tmp.61 (+ tmp.64 2)))
        (begin
          (mset! tmp.61 -2 L.cons.57.7)
          (mset! tmp.61 6 16)
          (set! cons.57 tmp.61)))
      (begin
        (begin (set! tmp.65 (alloc 24)) (set! tmp.62 (+ tmp.65 2)))
        (begin
          (mset! tmp.62 -2 L.fun/pair8448.4.8)
          (mset! tmp.62 6 0)
          (set! fun/pair8448.4 tmp.62)))
      (begin
        (mset! fun/pair8448.4 14 cons.57)
        (call L.fun/pair8448.4.8 fun/pair8448.4)))))
(check-by-interp
 '(module (begin (set! ascii-char0.5 20014) (set! void1.4 30) 14)))
(check-by-interp
 '(module
    (define L.lam.59.10 (lambda (c.63) (begin 576)))
    (define L.make-vector.58.9
      (lambda (c.62 tmp.34)
        (begin
          (set! make-init-vector.1 (mref c.62 14))
          (if (begin
                (if (begin (set! tmp.70 (bitwise-and tmp.34 7)) (= tmp.70 0))
                  (set! tmp.69 14)
                  (set! tmp.69 6))
                (!= tmp.69 6))
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.34)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.61 tmp.6)
        (begin
          (set! vector-init-loop.8 (mref c.61 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.74 (arithmetic-shift-right tmp.6 3))
                      (set! tmp.73 (+ 1 tmp.74)))
                    (set! tmp.72 (* tmp.73 8)))
                  (set! tmp.71 (alloc tmp.72)))
                (set! tmp.64 (+ tmp.71 3)))
              (begin (mset! tmp.64 -3 tmp.6) (set! tmp.7 tmp.64)))
            (call L.vector-init-loop.8.7 vector-init-loop.8 tmp.6 0 tmp.7)))))
    (define L.vector-init-loop.8.7
      (lambda (c.60 len.9 i.11 vec.10)
        (begin
          (set! vector-init-loop.8 (mref c.60 14))
          (if (begin
                (if (= len.9 i.11) (set! tmp.75 14) (set! tmp.75 6))
                (!= tmp.75 6))
            vec.10
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.78 (arithmetic-shift-right i.11 3))
                    (set! tmp.77 (* tmp.78 8)))
                  (set! tmp.76 (+ tmp.77 5)))
                (mset! vec.10 tmp.76 0))
              (begin
                (set! tmp.79 (+ i.11 8))
                (call
                 L.vector-init-loop.8.7
                 vector-init-loop.8
                 len.9
                 tmp.79
                 vec.10)))))))
    (begin
      (begin
        (begin (set! tmp.80 (alloc 24)) (set! tmp.65 (+ tmp.80 2)))
        (begin
          (mset! tmp.65 -2 L.vector-init-loop.8.7)
          (mset! tmp.65 6 24)
          (set! vector-init-loop.8 tmp.65)))
      (begin
        (begin (set! tmp.81 (alloc 24)) (set! tmp.66 (+ tmp.81 2)))
        (begin
          (mset! tmp.66 -2 L.make-init-vector.1.8)
          (mset! tmp.66 6 8)
          (set! make-init-vector.1 tmp.66)))
      (begin
        (begin (set! tmp.82 (alloc 24)) (set! tmp.67 (+ tmp.82 2)))
        (begin
          (mset! tmp.67 -2 L.make-vector.58.9)
          (mset! tmp.67 6 8)
          (set! make-vector.58 tmp.67)))
      (begin
        (mset! vector-init-loop.8 14 vector-init-loop.8)
        (mset! make-init-vector.1 14 vector-init-loop.8)
        (mset! make-vector.58 14 make-init-vector.1)
        (begin
          (set! vector0.5 (call L.make-vector.58.9 make-vector.58 64))
          (begin
            (begin
              (begin (set! tmp.83 (alloc 16)) (set! tmp.68 (+ tmp.83 2)))
              (begin
                (mset! tmp.68 -2 L.lam.59.10)
                (mset! tmp.68 6 0)
                (set! lam.59 tmp.68)))
            (set! procedure1.4 lam.59))
          22)))))
(check-by-interp
 '(module
    (define L.fun/empty8457.5.9
      (lambda (c.62 oprand0.6)
        (begin
          (set! fun/empty8458.4 (mref c.62 14))
          (call L.fun/empty8458.4.8 fun/empty8458.4))))
    (define L.fun/empty8458.4.8 (lambda (c.61) (begin 22)))
    (define L.cons.59.7
      (lambda (c.60 tmp.54 tmp.55)
        (begin
          (begin
            (begin (set! tmp.67 (alloc 16)) (set! tmp.63 (+ tmp.67 1)))
            (begin (mset! tmp.63 -1 tmp.54) (mset! tmp.63 7 tmp.55) tmp.63)))))
    (begin
      (begin
        (begin (set! tmp.68 (alloc 16)) (set! tmp.64 (+ tmp.68 2)))
        (begin
          (mset! tmp.64 -2 L.cons.59.7)
          (mset! tmp.64 6 16)
          (set! cons.59 tmp.64)))
      (begin
        (begin (set! tmp.69 (alloc 16)) (set! tmp.65 (+ tmp.69 2)))
        (begin
          (mset! tmp.65 -2 L.fun/empty8458.4.8)
          (mset! tmp.65 6 0)
          (set! fun/empty8458.4 tmp.65)))
      (begin
        (begin (set! tmp.70 (alloc 24)) (set! tmp.66 (+ tmp.70 2)))
        (begin
          (mset! tmp.66 -2 L.fun/empty8457.5.9)
          (mset! tmp.66 6 8)
          (set! fun/empty8457.5 tmp.66)))
      (begin
        (mset! fun/empty8457.5 14 fun/empty8458.4)
        (begin
          (if (!= 6 6)
            (set! tmp.71 (call L.cons.59.7 cons.59 1576 3840))
            (set! tmp.71 (call L.cons.59.7 cons.59 376 3368)))
          (call L.fun/empty8457.5.9 fun/empty8457.5 tmp.71))))))
(check-by-interp '(module (if (!= 6 6) 30 30)))
(check-by-interp
 '(module
    (define L.make-vector.56.9
      (lambda (c.59 tmp.32)
        (begin
          (set! make-init-vector.1 (mref c.59 14))
          (if (begin
                (if (begin (set! tmp.65 (bitwise-and tmp.32 7)) (= tmp.65 0))
                  (set! tmp.64 14)
                  (set! tmp.64 6))
                (!= tmp.64 6))
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.32)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.58 tmp.4)
        (begin
          (set! vector-init-loop.6 (mref c.58 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.69 (arithmetic-shift-right tmp.4 3))
                      (set! tmp.68 (+ 1 tmp.69)))
                    (set! tmp.67 (* tmp.68 8)))
                  (set! tmp.66 (alloc tmp.67)))
                (set! tmp.60 (+ tmp.66 3)))
              (begin (mset! tmp.60 -3 tmp.4) (set! tmp.5 tmp.60)))
            (call L.vector-init-loop.6.7 vector-init-loop.6 tmp.4 0 tmp.5)))))
    (define L.vector-init-loop.6.7
      (lambda (c.57 len.7 i.9 vec.8)
        (begin
          (set! vector-init-loop.6 (mref c.57 14))
          (if (begin
                (if (= len.7 i.9) (set! tmp.70 14) (set! tmp.70 6))
                (!= tmp.70 6))
            vec.8
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.73 (arithmetic-shift-right i.9 3))
                    (set! tmp.72 (* tmp.73 8)))
                  (set! tmp.71 (+ tmp.72 5)))
                (mset! vec.8 tmp.71 0))
              (begin
                (set! tmp.74 (+ i.9 8))
                (call
                 L.vector-init-loop.6.7
                 vector-init-loop.6
                 len.7
                 tmp.74
                 vec.8)))))))
    (begin
      (begin
        (begin (set! tmp.75 (alloc 24)) (set! tmp.61 (+ tmp.75 2)))
        (begin
          (mset! tmp.61 -2 L.vector-init-loop.6.7)
          (mset! tmp.61 6 24)
          (set! vector-init-loop.6 tmp.61)))
      (begin
        (begin (set! tmp.76 (alloc 24)) (set! tmp.62 (+ tmp.76 2)))
        (begin
          (mset! tmp.62 -2 L.make-init-vector.1.8)
          (mset! tmp.62 6 8)
          (set! make-init-vector.1 tmp.62)))
      (begin
        (begin (set! tmp.77 (alloc 24)) (set! tmp.63 (+ tmp.77 2)))
        (begin
          (mset! tmp.63 -2 L.make-vector.56.9)
          (mset! tmp.63 6 8)
          (set! make-vector.56 tmp.63)))
      (begin
        (mset! vector-init-loop.6 14 vector-init-loop.6)
        (mset! make-init-vector.1 14 vector-init-loop.6)
        (mset! make-vector.56 14 make-init-vector.1)
        (if (!= 6 6)
          (call L.make-vector.56.9 make-vector.56 64)
          (call L.make-vector.56.9 make-vector.56 64))))))
(check-by-interp
 '(module
    (define L.fun/empty8466.6.10 (lambda (c.65) (begin 22)))
    (define L.fun/empty8465.5.9
      (lambda (c.64 oprand0.8)
        (begin
          (set! fun/empty8466.6 (mref c.64 14))
          (call L.fun/empty8466.6.10 fun/empty8466.6))))
    (define L.fun/error8467.4.8 (lambda (c.63 oprand0.7) (begin 44862)))
    (define L.cons.61.7
      (lambda (c.62 tmp.56 tmp.57)
        (begin
          (begin
            (begin (set! tmp.71 (alloc 16)) (set! tmp.66 (+ tmp.71 1)))
            (begin (mset! tmp.66 -1 tmp.56) (mset! tmp.66 7 tmp.57) tmp.66)))))
    (begin
      (begin
        (begin (set! tmp.72 (alloc 16)) (set! tmp.67 (+ tmp.72 2)))
        (begin
          (mset! tmp.67 -2 L.cons.61.7)
          (mset! tmp.67 6 16)
          (set! cons.61 tmp.67)))
      (begin
        (begin (set! tmp.73 (alloc 16)) (set! tmp.68 (+ tmp.73 2)))
        (begin
          (mset! tmp.68 -2 L.fun/error8467.4.8)
          (mset! tmp.68 6 8)
          (set! fun/error8467.4 tmp.68)))
      (begin
        (begin (set! tmp.74 (alloc 24)) (set! tmp.69 (+ tmp.74 2)))
        (begin
          (mset! tmp.69 -2 L.fun/empty8465.5.9)
          (mset! tmp.69 6 8)
          (set! fun/empty8465.5 tmp.69)))
      (begin
        (begin (set! tmp.75 (alloc 16)) (set! tmp.70 (+ tmp.75 2)))
        (begin
          (mset! tmp.70 -2 L.fun/empty8466.6.10)
          (mset! tmp.70 6 0)
          (set! fun/empty8466.6 tmp.70)))
      (begin
        (mset! fun/empty8465.5 14 fun/empty8466.6)
        (begin
          (begin
            (set! tmp.77 (call L.cons.61.7 cons.61 632 4016))
            (set! tmp.76 (call L.fun/error8467.4.8 fun/error8467.4 tmp.77)))
          (call L.fun/empty8465.5.9 fun/empty8465.5 tmp.76))))))
(check-by-interp
 '(module
    (define L.fun/void8483.6.10
      (lambda (c.67 oprand0.10 oprand1.9)
        (begin
          (set! fun/void8484.4 (mref c.67 14))
          (call L.fun/void8484.4.8 fun/void8484.4))))
    (define L.fun/ascii-char8485.5.9
      (lambda (c.66 oprand0.8 oprand1.7) (begin 16942)))
    (define L.fun/void8484.4.8 (lambda (c.65) (begin 30)))
    (define L.-.63.7
      (lambda (c.64 tmp.29 tmp.30)
        (begin
          (if (begin
                (if (begin (set! tmp.73 (bitwise-and tmp.30 7)) (= tmp.73 0))
                  (set! tmp.72 14)
                  (set! tmp.72 6))
                (!= tmp.72 6))
            (if (begin
                  (if (begin (set! tmp.75 (bitwise-and tmp.29 7)) (= tmp.75 0))
                    (set! tmp.74 14)
                    (set! tmp.74 6))
                  (!= tmp.74 6))
              (- tmp.29 tmp.30)
              830)
            830))))
    (begin
      (begin
        (begin (set! tmp.76 (alloc 16)) (set! tmp.68 (+ tmp.76 2)))
        (begin
          (mset! tmp.68 -2 L.-.63.7)
          (mset! tmp.68 6 16)
          (set! |-.63| tmp.68)))
      (begin
        (begin (set! tmp.77 (alloc 16)) (set! tmp.69 (+ tmp.77 2)))
        (begin
          (mset! tmp.69 -2 L.fun/void8484.4.8)
          (mset! tmp.69 6 0)
          (set! fun/void8484.4 tmp.69)))
      (begin
        (begin (set! tmp.78 (alloc 16)) (set! tmp.70 (+ tmp.78 2)))
        (begin
          (mset! tmp.70 -2 L.fun/ascii-char8485.5.9)
          (mset! tmp.70 6 16)
          (set! fun/ascii-char8485.5 tmp.70)))
      (begin
        (begin (set! tmp.79 (alloc 24)) (set! tmp.71 (+ tmp.79 2)))
        (begin
          (mset! tmp.71 -2 L.fun/void8483.6.10)
          (mset! tmp.71 6 16)
          (set! fun/void8483.6 tmp.71)))
      (begin
        (mset! fun/void8483.6 14 fun/void8484.4)
        (begin
          (begin
            (set! tmp.81 (call L.-.63.7 |-.63| 224 704))
            (begin
              (set! tmp.82
                (call L.fun/ascii-char8485.5.9 fun/ascii-char8485.5 704 17198))
              (set! tmp.80
                (call
                 L.fun/ascii-char8485.5.9
                 fun/ascii-char8485.5
                 tmp.81
                 tmp.82))))
          (begin
            (if (!= 14 6) (set! tmp.83 960) (set! tmp.83 528))
            (call L.fun/void8483.6.10 fun/void8483.6 tmp.80 tmp.83)))))))
(check-by-interp
 '(module
    (if (if (!= 14 6) (!= 14 6) (!= 6 6))
      (if (!= 14 6) 4670 26430)
      (begin
        (set! ascii-char0.6 28718)
        (set! fixnum1.5 1608)
        (set! empty2.4 22)
        5438))))
(check-by-interp
 '(module
    (define L.fun/void8491.6.13 (lambda (c.70) (begin 30)))
    (define L.fun/void8490.5.12 (lambda (c.69) (begin 30)))
    (define L.fun/error8492.4.11 (lambda (c.68) (begin 19774)))
    (define L.make-vector.62.10
      (lambda (c.67 tmp.38)
        (begin
          (set! make-init-vector.1 (mref c.67 14))
          (if (begin
                (if (begin (set! tmp.80 (bitwise-and tmp.38 7)) (= tmp.80 0))
                  (set! tmp.79 14)
                  (set! tmp.79 6))
                (!= tmp.79 6))
            (call L.make-init-vector.1.9 make-init-vector.1 tmp.38)
            2110))))
    (define L.make-init-vector.1.9
      (lambda (c.66 tmp.10)
        (begin
          (set! vector-init-loop.12 (mref c.66 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.84 (arithmetic-shift-right tmp.10 3))
                      (set! tmp.83 (+ 1 tmp.84)))
                    (set! tmp.82 (* tmp.83 8)))
                  (set! tmp.81 (alloc tmp.82)))
                (set! tmp.71 (+ tmp.81 3)))
              (begin (mset! tmp.71 -3 tmp.10) (set! tmp.11 tmp.71)))
            (call
             L.vector-init-loop.12.8
             vector-init-loop.12
             tmp.10
             0
             tmp.11)))))
    (define L.vector-init-loop.12.8
      (lambda (c.65 len.13 i.15 vec.14)
        (begin
          (set! vector-init-loop.12 (mref c.65 14))
          (if (begin
                (if (= len.13 i.15) (set! tmp.85 14) (set! tmp.85 6))
                (!= tmp.85 6))
            vec.14
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.88 (arithmetic-shift-right i.15 3))
                    (set! tmp.87 (* tmp.88 8)))
                  (set! tmp.86 (+ tmp.87 5)))
                (mset! vec.14 tmp.86 0))
              (begin
                (set! tmp.89 (+ i.15 8))
                (call
                 L.vector-init-loop.12.8
                 vector-init-loop.12
                 len.13
                 tmp.89
                 vec.14)))))))
    (define L.vector?.63.7
      (lambda (c.64 tmp.54)
        (begin
          (if (begin (set! tmp.90 (bitwise-and tmp.54 7)) (= tmp.90 3))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.91 (alloc 16)) (set! tmp.72 (+ tmp.91 2)))
        (begin
          (mset! tmp.72 -2 L.vector?.63.7)
          (mset! tmp.72 6 8)
          (set! vector?.63 tmp.72)))
      (begin
        (begin (set! tmp.92 (alloc 24)) (set! tmp.73 (+ tmp.92 2)))
        (begin
          (mset! tmp.73 -2 L.vector-init-loop.12.8)
          (mset! tmp.73 6 24)
          (set! vector-init-loop.12 tmp.73)))
      (begin
        (begin (set! tmp.93 (alloc 24)) (set! tmp.74 (+ tmp.93 2)))
        (begin
          (mset! tmp.74 -2 L.make-init-vector.1.9)
          (mset! tmp.74 6 8)
          (set! make-init-vector.1 tmp.74)))
      (begin
        (begin (set! tmp.94 (alloc 24)) (set! tmp.75 (+ tmp.94 2)))
        (begin
          (mset! tmp.75 -2 L.make-vector.62.10)
          (mset! tmp.75 6 8)
          (set! make-vector.62 tmp.75)))
      (begin
        (begin (set! tmp.95 (alloc 16)) (set! tmp.76 (+ tmp.95 2)))
        (begin
          (mset! tmp.76 -2 L.fun/error8492.4.11)
          (mset! tmp.76 6 0)
          (set! fun/error8492.4 tmp.76)))
      (begin
        (begin (set! tmp.96 (alloc 16)) (set! tmp.77 (+ tmp.96 2)))
        (begin
          (mset! tmp.77 -2 L.fun/void8490.5.12)
          (mset! tmp.77 6 0)
          (set! fun/void8490.5 tmp.77)))
      (begin
        (begin (set! tmp.97 (alloc 16)) (set! tmp.78 (+ tmp.97 2)))
        (begin
          (mset! tmp.78 -2 L.fun/void8491.6.13)
          (mset! tmp.78 6 0)
          (set! fun/void8491.6 tmp.78)))
      (begin
        (mset! vector-init-loop.12 14 vector-init-loop.12)
        (mset! make-init-vector.1 14 vector-init-loop.12)
        (mset! make-vector.62 14 make-init-vector.1)
        (begin
          (set! void0.9 (call L.fun/void8490.5.12 fun/void8490.5))
          (set! void1.8 (call L.fun/void8491.6.13 fun/void8491.6))
          (begin
            (set! tmp.98 (call L.make-vector.62.10 make-vector.62 64))
            (set! boolean2.7 (call L.vector?.63.7 vector?.63 tmp.98)))
          (call L.fun/error8492.4.11 fun/error8492.4))))))
(check-by-interp
 '(module
    (define L.fun/error8495.4.10
      (lambda (c.63 oprand0.6 oprand1.5) (begin 17470)))
    (define L.make-vector.59.9
      (lambda (c.62 tmp.35)
        (begin
          (set! make-init-vector.1 (mref c.62 14))
          (if (begin
                (if (begin (set! tmp.70 (bitwise-and tmp.35 7)) (= tmp.70 0))
                  (set! tmp.69 14)
                  (set! tmp.69 6))
                (!= tmp.69 6))
            (call L.make-init-vector.1.8 make-init-vector.1 tmp.35)
            2110))))
    (define L.make-init-vector.1.8
      (lambda (c.61 tmp.7)
        (begin
          (set! vector-init-loop.9 (mref c.61 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.74 (arithmetic-shift-right tmp.7 3))
                      (set! tmp.73 (+ 1 tmp.74)))
                    (set! tmp.72 (* tmp.73 8)))
                  (set! tmp.71 (alloc tmp.72)))
                (set! tmp.64 (+ tmp.71 3)))
              (begin (mset! tmp.64 -3 tmp.7) (set! tmp.8 tmp.64)))
            (call L.vector-init-loop.9.7 vector-init-loop.9 tmp.7 0 tmp.8)))))
    (define L.vector-init-loop.9.7
      (lambda (c.60 len.10 i.12 vec.11)
        (begin
          (set! vector-init-loop.9 (mref c.60 14))
          (if (begin
                (if (= len.10 i.12) (set! tmp.75 14) (set! tmp.75 6))
                (!= tmp.75 6))
            vec.11
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.78 (arithmetic-shift-right i.12 3))
                    (set! tmp.77 (* tmp.78 8)))
                  (set! tmp.76 (+ tmp.77 5)))
                (mset! vec.11 tmp.76 0))
              (begin
                (set! tmp.79 (+ i.12 8))
                (call
                 L.vector-init-loop.9.7
                 vector-init-loop.9
                 len.10
                 tmp.79
                 vec.11)))))))
    (begin
      (begin
        (begin (set! tmp.80 (alloc 24)) (set! tmp.65 (+ tmp.80 2)))
        (begin
          (mset! tmp.65 -2 L.vector-init-loop.9.7)
          (mset! tmp.65 6 24)
          (set! vector-init-loop.9 tmp.65)))
      (begin
        (begin (set! tmp.81 (alloc 24)) (set! tmp.66 (+ tmp.81 2)))
        (begin
          (mset! tmp.66 -2 L.make-init-vector.1.8)
          (mset! tmp.66 6 8)
          (set! make-init-vector.1 tmp.66)))
      (begin
        (begin (set! tmp.82 (alloc 24)) (set! tmp.67 (+ tmp.82 2)))
        (begin
          (mset! tmp.67 -2 L.make-vector.59.9)
          (mset! tmp.67 6 8)
          (set! make-vector.59 tmp.67)))
      (begin
        (begin (set! tmp.83 (alloc 16)) (set! tmp.68 (+ tmp.83 2)))
        (begin
          (mset! tmp.68 -2 L.fun/error8495.4.10)
          (mset! tmp.68 6 16)
          (set! fun/error8495.4 tmp.68)))
      (begin
        (mset! vector-init-loop.9 14 vector-init-loop.9)
        (mset! make-init-vector.1 14 vector-init-loop.9)
        (mset! make-vector.59 14 make-init-vector.1)
        (if (if (!= 14 6) (!= 14 6) (!= 6 6))
          (if (!= 14 6) 59198 39998)
          (begin
            (set! tmp.84 (call L.make-vector.59.9 make-vector.59 64))
            (call L.fun/error8495.4.10 fun/error8495.4 25390 tmp.84)))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8529.5.10 (lambda (c.66) (begin 22318)))
    (define L.fun/error8528.4.9 (lambda (c.65) (begin 55102)))
    (define L.empty?.61.8
      (lambda (c.64 tmp.48)
        (begin
          (if (begin (set! tmp.71 (bitwise-and tmp.48 255)) (= tmp.71 22))
            14
            6))))
    (define L.-.62.7
      (lambda (c.63 tmp.27 tmp.28)
        (begin
          (if (begin
                (if (begin (set! tmp.73 (bitwise-and tmp.28 7)) (= tmp.73 0))
                  (set! tmp.72 14)
                  (set! tmp.72 6))
                (!= tmp.72 6))
            (if (begin
                  (if (begin (set! tmp.75 (bitwise-and tmp.27 7)) (= tmp.75 0))
                    (set! tmp.74 14)
                    (set! tmp.74 6))
                  (!= tmp.74 6))
              (- tmp.27 tmp.28)
              830)
            830))))
    (begin
      (begin
        (begin (set! tmp.76 (alloc 16)) (set! tmp.67 (+ tmp.76 2)))
        (begin
          (mset! tmp.67 -2 L.-.62.7)
          (mset! tmp.67 6 16)
          (set! |-.62| tmp.67)))
      (begin
        (begin (set! tmp.77 (alloc 16)) (set! tmp.68 (+ tmp.77 2)))
        (begin
          (mset! tmp.68 -2 L.empty?.61.8)
          (mset! tmp.68 6 8)
          (set! empty?.61 tmp.68)))
      (begin
        (begin (set! tmp.78 (alloc 16)) (set! tmp.69 (+ tmp.78 2)))
        (begin
          (mset! tmp.69 -2 L.fun/error8528.4.9)
          (mset! tmp.69 6 0)
          (set! fun/error8528.4 tmp.69)))
      (begin
        (begin (set! tmp.79 (alloc 16)) (set! tmp.70 (+ tmp.79 2)))
        (begin
          (mset! tmp.70 -2 L.fun/ascii-char8529.5.10)
          (mset! tmp.70 6 0)
          (set! fun/ascii-char8529.5 tmp.70)))
      (begin
        (set! error0.8 (call L.fun/error8528.4.9 fun/error8528.4))
        (set! ascii-char1.7
          (call L.fun/ascii-char8529.5.10 fun/ascii-char8529.5))
        (set! boolean2.6 (call L.empty?.61.8 empty?.61 18734))
        (call L.-.62.7 |-.62| 1488 1960)))))
(check-by-interp
 '(module
    (define L.fun/pair8538.5.9
      (lambda (c.65 oprand0.9 oprand1.8)
        (begin
          (set! cons.62 (mref c.65 14))
          (call L.cons.62.7 cons.62 40 4080))))
    (define L.fun/pair8539.4.8
      (lambda (c.64 oprand0.7 oprand1.6) (begin oprand1.6)))
    (define L.cons.62.7
      (lambda (c.63 tmp.57 tmp.58)
        (begin
          (begin
            (begin (set! tmp.70 (alloc 16)) (set! tmp.66 (+ tmp.70 1)))
            (begin (mset! tmp.66 -1 tmp.57) (mset! tmp.66 7 tmp.58) tmp.66)))))
    (begin
      (begin
        (begin (set! tmp.71 (alloc 16)) (set! tmp.67 (+ tmp.71 2)))
        (begin
          (mset! tmp.67 -2 L.cons.62.7)
          (mset! tmp.67 6 16)
          (set! cons.62 tmp.67)))
      (begin
        (begin (set! tmp.72 (alloc 16)) (set! tmp.68 (+ tmp.72 2)))
        (begin
          (mset! tmp.68 -2 L.fun/pair8539.4.8)
          (mset! tmp.68 6 16)
          (set! fun/pair8539.4 tmp.68)))
      (begin
        (begin (set! tmp.73 (alloc 24)) (set! tmp.69 (+ tmp.73 2)))
        (begin
          (mset! tmp.69 -2 L.fun/pair8538.5.9)
          (mset! tmp.69 6 16)
          (set! fun/pair8538.5 tmp.69)))
      (begin
        (mset! fun/pair8538.5 14 cons.62)
        (if (if (!= 14 6) (!= 6 6) (!= 6 6))
          (call L.fun/pair8538.5.9 fun/pair8538.5 1976 6)
          (begin
            (set! tmp.74 (call L.cons.62.7 cons.62 224 2760))
            (call L.fun/pair8539.4.8 fun/pair8539.4 6 tmp.74)))))))
(check-by-interp
 '(module
    (define L.fun/boolean8542.5.12
      (lambda (c.69 oprand0.9 oprand1.8) (begin 14)))
    (define L.fun/ascii-char8543.4.11
      (lambda (c.68 oprand0.7 oprand1.6) (begin 30766)))
    (define L.make-vector.62.10
      (lambda (c.67 tmp.38)
        (begin
          (set! make-init-vector.1 (mref c.67 14))
          (if (begin
                (if (begin (set! tmp.79 (bitwise-and tmp.38 7)) (= tmp.79 0))
                  (set! tmp.78 14)
                  (set! tmp.78 6))
                (!= tmp.78 6))
            (call L.make-init-vector.1.9 make-init-vector.1 tmp.38)
            2110))))
    (define L.make-init-vector.1.9
      (lambda (c.66 tmp.10)
        (begin
          (set! vector-init-loop.12 (mref c.66 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.83 (arithmetic-shift-right tmp.10 3))
                      (set! tmp.82 (+ 1 tmp.83)))
                    (set! tmp.81 (* tmp.82 8)))
                  (set! tmp.80 (alloc tmp.81)))
                (set! tmp.70 (+ tmp.80 3)))
              (begin (mset! tmp.70 -3 tmp.10) (set! tmp.11 tmp.70)))
            (call
             L.vector-init-loop.12.8
             vector-init-loop.12
             tmp.10
             0
             tmp.11)))))
    (define L.vector-init-loop.12.8
      (lambda (c.65 len.13 i.15 vec.14)
        (begin
          (set! vector-init-loop.12 (mref c.65 14))
          (if (begin
                (if (= len.13 i.15) (set! tmp.84 14) (set! tmp.84 6))
                (!= tmp.84 6))
            vec.14
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.87 (arithmetic-shift-right i.15 3))
                    (set! tmp.86 (* tmp.87 8)))
                  (set! tmp.85 (+ tmp.86 5)))
                (mset! vec.14 tmp.85 0))
              (begin
                (set! tmp.88 (+ i.15 8))
                (call
                 L.vector-init-loop.12.8
                 vector-init-loop.12
                 len.13
                 tmp.88
                 vec.14)))))))
    (define L.cons.63.7
      (lambda (c.64 tmp.57 tmp.58)
        (begin
          (begin
            (begin (set! tmp.89 (alloc 16)) (set! tmp.71 (+ tmp.89 1)))
            (begin (mset! tmp.71 -1 tmp.57) (mset! tmp.71 7 tmp.58) tmp.71)))))
    (begin
      (begin
        (begin (set! tmp.90 (alloc 16)) (set! tmp.72 (+ tmp.90 2)))
        (begin
          (mset! tmp.72 -2 L.cons.63.7)
          (mset! tmp.72 6 16)
          (set! cons.63 tmp.72)))
      (begin
        (begin (set! tmp.91 (alloc 24)) (set! tmp.73 (+ tmp.91 2)))
        (begin
          (mset! tmp.73 -2 L.vector-init-loop.12.8)
          (mset! tmp.73 6 24)
          (set! vector-init-loop.12 tmp.73)))
      (begin
        (begin (set! tmp.92 (alloc 24)) (set! tmp.74 (+ tmp.92 2)))
        (begin
          (mset! tmp.74 -2 L.make-init-vector.1.9)
          (mset! tmp.74 6 8)
          (set! make-init-vector.1 tmp.74)))
      (begin
        (begin (set! tmp.93 (alloc 24)) (set! tmp.75 (+ tmp.93 2)))
        (begin
          (mset! tmp.75 -2 L.make-vector.62.10)
          (mset! tmp.75 6 8)
          (set! make-vector.62 tmp.75)))
      (begin
        (begin (set! tmp.94 (alloc 16)) (set! tmp.76 (+ tmp.94 2)))
        (begin
          (mset! tmp.76 -2 L.fun/ascii-char8543.4.11)
          (mset! tmp.76 6 16)
          (set! fun/ascii-char8543.4 tmp.76)))
      (begin
        (begin (set! tmp.95 (alloc 16)) (set! tmp.77 (+ tmp.95 2)))
        (begin
          (mset! tmp.77 -2 L.fun/boolean8542.5.12)
          (mset! tmp.77 6 16)
          (set! fun/boolean8542.5 tmp.77)))
      (begin
        (mset! vector-init-loop.12 14 vector-init-loop.12)
        (mset! make-init-vector.1 14 vector-init-loop.12)
        (mset! make-vector.62 14 make-init-vector.1)
        (if (begin
              (begin
                (set! tmp.97 (call L.make-vector.62.10 make-vector.62 64))
                (set! tmp.96
                  (call
                   L.fun/boolean8542.5.12
                   fun/boolean8542.5
                   23854
                   tmp.97)))
              (!= tmp.96 6))
          (begin
            (set! tmp.98 (call L.cons.63.7 cons.63 1440 3056))
            (call L.fun/ascii-char8543.4.11 fun/ascii-char8543.4 tmp.98 1832))
          (if (!= 6 6) 24110 26926))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8590.6.15 (lambda (c.75) (begin 17454)))
    (define L.fun/vector8589.5.14
      (lambda (c.74)
        (begin
          (set! make-vector.63 (mref c.74 14))
          (call L.make-vector.63.12 make-vector.63 64))))
    (define L.fun/empty8591.4.13 (lambda (c.73) (begin 22)))
    (define L.make-vector.63.12
      (lambda (c.72 tmp.39)
        (begin
          (set! make-init-vector.1 (mref c.72 14))
          (if (begin
                (if (begin (set! tmp.87 (bitwise-and tmp.39 7)) (= tmp.87 0))
                  (set! tmp.86 14)
                  (set! tmp.86 6))
                (!= tmp.86 6))
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.39)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.71 tmp.11)
        (begin
          (set! vector-init-loop.13 (mref c.71 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.91 (arithmetic-shift-right tmp.11 3))
                      (set! tmp.90 (+ 1 tmp.91)))
                    (set! tmp.89 (* tmp.90 8)))
                  (set! tmp.88 (alloc tmp.89)))
                (set! tmp.76 (+ tmp.88 3)))
              (begin (mset! tmp.76 -3 tmp.11) (set! tmp.12 tmp.76)))
            (call
             L.vector-init-loop.13.10
             vector-init-loop.13
             tmp.11
             0
             tmp.12)))))
    (define L.vector-init-loop.13.10
      (lambda (c.70 len.14 i.16 vec.15)
        (begin
          (set! vector-init-loop.13 (mref c.70 14))
          (if (begin
                (if (= len.14 i.16) (set! tmp.92 14) (set! tmp.92 6))
                (!= tmp.92 6))
            vec.15
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.95 (arithmetic-shift-right i.16 3))
                    (set! tmp.94 (* tmp.95 8)))
                  (set! tmp.93 (+ tmp.94 5)))
                (mset! vec.15 tmp.93 0))
              (begin
                (set! tmp.96 (+ i.16 8))
                (call
                 L.vector-init-loop.13.10
                 vector-init-loop.13
                 len.14
                 tmp.96
                 vec.15)))))))
    (define L.-.64.9
      (lambda (c.69 tmp.29 tmp.30)
        (begin
          (if (begin
                (if (begin (set! tmp.98 (bitwise-and tmp.30 7)) (= tmp.98 0))
                  (set! tmp.97 14)
                  (set! tmp.97 6))
                (!= tmp.97 6))
            (if (begin
                  (if (begin
                        (set! tmp.100 (bitwise-and tmp.29 7))
                        (= tmp.100 0))
                    (set! tmp.99 14)
                    (set! tmp.99 6))
                  (!= tmp.99 6))
              (- tmp.29 tmp.30)
              830)
            830))))
    (define L.+.65.8
      (lambda (c.68 tmp.27 tmp.28)
        (begin
          (if (begin
                (if (begin (set! tmp.102 (bitwise-and tmp.28 7)) (= tmp.102 0))
                  (set! tmp.101 14)
                  (set! tmp.101 6))
                (!= tmp.101 6))
            (if (begin
                  (if (begin
                        (set! tmp.104 (bitwise-and tmp.27 7))
                        (= tmp.104 0))
                    (set! tmp.103 14)
                    (set! tmp.103 6))
                  (!= tmp.103 6))
              (+ tmp.27 tmp.28)
              574)
            574))))
    (define L.*.66.7
      (lambda (c.67 tmp.25 tmp.26)
        (begin
          (if (begin
                (if (begin (set! tmp.106 (bitwise-and tmp.26 7)) (= tmp.106 0))
                  (set! tmp.105 14)
                  (set! tmp.105 6))
                (!= tmp.105 6))
            (if (begin
                  (if (begin
                        (set! tmp.108 (bitwise-and tmp.25 7))
                        (= tmp.108 0))
                    (set! tmp.107 14)
                    (set! tmp.107 6))
                  (!= tmp.107 6))
              (begin
                (set! tmp.109 (arithmetic-shift-right tmp.26 3))
                (* tmp.25 tmp.109))
              318)
            318))))
    (begin
      (begin
        (begin (set! tmp.110 (alloc 16)) (set! tmp.77 (+ tmp.110 2)))
        (begin
          (mset! tmp.77 -2 L.*.66.7)
          (mset! tmp.77 6 16)
          (set! *.66 tmp.77)))
      (begin
        (begin (set! tmp.111 (alloc 16)) (set! tmp.78 (+ tmp.111 2)))
        (begin
          (mset! tmp.78 -2 L.+.65.8)
          (mset! tmp.78 6 16)
          (set! |+.65| tmp.78)))
      (begin
        (begin (set! tmp.112 (alloc 16)) (set! tmp.79 (+ tmp.112 2)))
        (begin
          (mset! tmp.79 -2 L.-.64.9)
          (mset! tmp.79 6 16)
          (set! |-.64| tmp.79)))
      (begin
        (begin (set! tmp.113 (alloc 24)) (set! tmp.80 (+ tmp.113 2)))
        (begin
          (mset! tmp.80 -2 L.vector-init-loop.13.10)
          (mset! tmp.80 6 24)
          (set! vector-init-loop.13 tmp.80)))
      (begin
        (begin (set! tmp.114 (alloc 24)) (set! tmp.81 (+ tmp.114 2)))
        (begin
          (mset! tmp.81 -2 L.make-init-vector.1.11)
          (mset! tmp.81 6 8)
          (set! make-init-vector.1 tmp.81)))
      (begin
        (begin (set! tmp.115 (alloc 24)) (set! tmp.82 (+ tmp.115 2)))
        (begin
          (mset! tmp.82 -2 L.make-vector.63.12)
          (mset! tmp.82 6 8)
          (set! make-vector.63 tmp.82)))
      (begin
        (begin (set! tmp.116 (alloc 16)) (set! tmp.83 (+ tmp.116 2)))
        (begin
          (mset! tmp.83 -2 L.fun/empty8591.4.13)
          (mset! tmp.83 6 0)
          (set! fun/empty8591.4 tmp.83)))
      (begin
        (begin (set! tmp.117 (alloc 24)) (set! tmp.84 (+ tmp.117 2)))
        (begin
          (mset! tmp.84 -2 L.fun/vector8589.5.14)
          (mset! tmp.84 6 0)
          (set! fun/vector8589.5 tmp.84)))
      (begin
        (begin (set! tmp.118 (alloc 16)) (set! tmp.85 (+ tmp.118 2)))
        (begin
          (mset! tmp.85 -2 L.fun/ascii-char8590.6.15)
          (mset! tmp.85 6 0)
          (set! fun/ascii-char8590.6 tmp.85)))
      (begin
        (mset! vector-init-loop.13 14 vector-init-loop.13)
        (mset! make-init-vector.1 14 vector-init-loop.13)
        (mset! make-vector.63 14 make-init-vector.1)
        (mset! fun/vector8589.5 14 make-vector.63)
        (begin
          (begin
            (set! tmp.119 (call L.-.64.9 |-.64| 1720 576))
            (begin
              (set! tmp.120 (call L.-.64.9 |-.64| 1752 1384))
              (set! fixnum0.10 (call L.-.64.9 |-.64| tmp.119 tmp.120))))
          (set! vector1.9 (call L.fun/vector8589.5.14 fun/vector8589.5))
          (begin
            (set! tmp.121 (call L.+.65.8 |+.65| 744 1760))
            (begin
              (set! tmp.122 (call L.*.66.7 *.66 1360 1048))
              (set! fixnum2.8 (call L.+.65.8 |+.65| tmp.121 tmp.122))))
          (set! ascii-char3.7
            (call L.fun/ascii-char8590.6.15 fun/ascii-char8590.6))
          (call L.fun/empty8591.4.13 fun/empty8591.4))))))
(check-by-interp
 '(module
    (define L.cons.56.7
      (lambda (c.57 tmp.51 tmp.52)
        (begin
          (begin
            (begin (set! tmp.60 (alloc 16)) (set! tmp.58 (+ tmp.60 1)))
            (begin (mset! tmp.58 -1 tmp.51) (mset! tmp.58 7 tmp.52) tmp.58)))))
    (begin
      (begin
        (begin (set! tmp.61 (alloc 16)) (set! tmp.59 (+ tmp.61 2)))
        (begin
          (mset! tmp.59 -2 L.cons.56.7)
          (mset! tmp.59 6 16)
          (set! cons.56 tmp.59)))
      (if (if (!= 14 6) (!= 14 6) (!= 6 6))
        (if (!= 14 6)
          (call L.cons.56.7 cons.56 408 3360)
          (call L.cons.56.7 cons.56 320 2912))
        (if (!= 14 6)
          (call L.cons.56.7 cons.56 1928 2800)
          (call L.cons.56.7 cons.56 896 2760))))))
(check-by-interp
 '(module
    (define L.lam.65.12
      (lambda (c.71)
        (begin
          (set! fun/error8691.5 (mref c.71 14))
          (call L.fun/error8691.5.8 fun/error8691.5))))
    (define L.fun/void8690.8.11 (lambda (c.70) (begin 30)))
    (define L.fun/ascii-char8688.7.10 (lambda (c.69) (begin 27182)))
    (define L.fun/empty8692.6.9 (lambda (c.68) (begin 22)))
    (define L.fun/error8691.5.8 (lambda (c.67) (begin 31806)))
    (define L.fun/ascii-char8689.4.7 (lambda (c.66) (begin 18734)))
    (begin
      (begin
        (begin (set! tmp.78 (alloc 16)) (set! tmp.72 (+ tmp.78 2)))
        (begin
          (mset! tmp.72 -2 L.fun/ascii-char8689.4.7)
          (mset! tmp.72 6 0)
          (set! fun/ascii-char8689.4 tmp.72)))
      (begin
        (begin (set! tmp.79 (alloc 16)) (set! tmp.73 (+ tmp.79 2)))
        (begin
          (mset! tmp.73 -2 L.fun/error8691.5.8)
          (mset! tmp.73 6 0)
          (set! fun/error8691.5 tmp.73)))
      (begin
        (begin (set! tmp.80 (alloc 16)) (set! tmp.74 (+ tmp.80 2)))
        (begin
          (mset! tmp.74 -2 L.fun/empty8692.6.9)
          (mset! tmp.74 6 0)
          (set! fun/empty8692.6 tmp.74)))
      (begin
        (begin (set! tmp.81 (alloc 16)) (set! tmp.75 (+ tmp.81 2)))
        (begin
          (mset! tmp.75 -2 L.fun/ascii-char8688.7.10)
          (mset! tmp.75 6 0)
          (set! fun/ascii-char8688.7 tmp.75)))
      (begin
        (begin (set! tmp.82 (alloc 16)) (set! tmp.76 (+ tmp.82 2)))
        (begin
          (mset! tmp.76 -2 L.fun/void8690.8.11)
          (mset! tmp.76 6 0)
          (set! fun/void8690.8 tmp.76)))
      (begin
        (set! ascii-char0.12
          (call L.fun/ascii-char8688.7.10 fun/ascii-char8688.7))
        (set! ascii-char1.11
          (call L.fun/ascii-char8689.4.7 fun/ascii-char8689.4))
        (set! void2.10 (call L.fun/void8690.8.11 fun/void8690.8))
        (begin
          (begin
            (begin (set! tmp.83 (alloc 24)) (set! tmp.77 (+ tmp.83 2)))
            (begin
              (mset! tmp.77 -2 L.lam.65.12)
              (mset! tmp.77 6 0)
              (set! lam.65 tmp.77)))
          (begin (mset! lam.65 14 fun/error8691.5) (set! procedure3.9 lam.65)))
        (call L.fun/empty8692.6.9 fun/empty8692.6)))))
(check-by-interp
 '(module
    (define L.fun/any8764.8.16 (lambda (c.77) (begin 14142)))
    (define L.fun/void8763.7.15 (lambda (c.76) (begin 30)))
    (define L.fun/any8762.6.14 (lambda (c.75) (begin 30)))
    (define L.fun/ascii-char8761.5.13 (lambda (c.74) (begin 27438)))
    (define L.fun/vector8765.4.12
      (lambda (c.73)
        (begin
          (set! make-vector.65 (mref c.73 14))
          (call L.make-vector.65.11 make-vector.65 64))))
    (define L.make-vector.65.11
      (lambda (c.72 tmp.41)
        (begin
          (set! make-init-vector.1 (mref c.72 14))
          (if (begin
                (if (begin (set! tmp.90 (bitwise-and tmp.41 7)) (= tmp.90 0))
                  (set! tmp.89 14)
                  (set! tmp.89 6))
                (!= tmp.89 6))
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.41)
            2110))))
    (define L.make-init-vector.1.10
      (lambda (c.71 tmp.13)
        (begin
          (set! vector-init-loop.15 (mref c.71 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.94 (arithmetic-shift-right tmp.13 3))
                      (set! tmp.93 (+ 1 tmp.94)))
                    (set! tmp.92 (* tmp.93 8)))
                  (set! tmp.91 (alloc tmp.92)))
                (set! tmp.78 (+ tmp.91 3)))
              (begin (mset! tmp.78 -3 tmp.13) (set! tmp.14 tmp.78)))
            (call
             L.vector-init-loop.15.9
             vector-init-loop.15
             tmp.13
             0
             tmp.14)))))
    (define L.vector-init-loop.15.9
      (lambda (c.70 len.16 i.18 vec.17)
        (begin
          (set! vector-init-loop.15 (mref c.70 14))
          (if (begin
                (if (= len.16 i.18) (set! tmp.95 14) (set! tmp.95 6))
                (!= tmp.95 6))
            vec.17
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.98 (arithmetic-shift-right i.18 3))
                    (set! tmp.97 (* tmp.98 8)))
                  (set! tmp.96 (+ tmp.97 5)))
                (mset! vec.17 tmp.96 0))
              (begin
                (set! tmp.99 (+ i.18 8))
                (call
                 L.vector-init-loop.15.9
                 vector-init-loop.15
                 len.16
                 tmp.99
                 vec.17)))))))
    (define L.vector?.66.8
      (lambda (c.69 tmp.57)
        (begin
          (if (begin (set! tmp.100 (bitwise-and tmp.57 7)) (= tmp.100 3))
            14
            6))))
    (define L.boolean?.67.7
      (lambda (c.68 tmp.51)
        (begin
          (if (begin (set! tmp.101 (bitwise-and tmp.51 247)) (= tmp.101 6))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.102 (alloc 16)) (set! tmp.79 (+ tmp.102 2)))
        (begin
          (mset! tmp.79 -2 L.boolean?.67.7)
          (mset! tmp.79 6 8)
          (set! boolean?.67 tmp.79)))
      (begin
        (begin (set! tmp.103 (alloc 16)) (set! tmp.80 (+ tmp.103 2)))
        (begin
          (mset! tmp.80 -2 L.vector?.66.8)
          (mset! tmp.80 6 8)
          (set! vector?.66 tmp.80)))
      (begin
        (begin (set! tmp.104 (alloc 24)) (set! tmp.81 (+ tmp.104 2)))
        (begin
          (mset! tmp.81 -2 L.vector-init-loop.15.9)
          (mset! tmp.81 6 24)
          (set! vector-init-loop.15 tmp.81)))
      (begin
        (begin (set! tmp.105 (alloc 24)) (set! tmp.82 (+ tmp.105 2)))
        (begin
          (mset! tmp.82 -2 L.make-init-vector.1.10)
          (mset! tmp.82 6 8)
          (set! make-init-vector.1 tmp.82)))
      (begin
        (begin (set! tmp.106 (alloc 24)) (set! tmp.83 (+ tmp.106 2)))
        (begin
          (mset! tmp.83 -2 L.make-vector.65.11)
          (mset! tmp.83 6 8)
          (set! make-vector.65 tmp.83)))
      (begin
        (begin (set! tmp.107 (alloc 24)) (set! tmp.84 (+ tmp.107 2)))
        (begin
          (mset! tmp.84 -2 L.fun/vector8765.4.12)
          (mset! tmp.84 6 0)
          (set! fun/vector8765.4 tmp.84)))
      (begin
        (begin (set! tmp.108 (alloc 16)) (set! tmp.85 (+ tmp.108 2)))
        (begin
          (mset! tmp.85 -2 L.fun/ascii-char8761.5.13)
          (mset! tmp.85 6 0)
          (set! fun/ascii-char8761.5 tmp.85)))
      (begin
        (begin (set! tmp.109 (alloc 16)) (set! tmp.86 (+ tmp.109 2)))
        (begin
          (mset! tmp.86 -2 L.fun/any8762.6.14)
          (mset! tmp.86 6 0)
          (set! fun/any8762.6 tmp.86)))
      (begin
        (begin (set! tmp.110 (alloc 16)) (set! tmp.87 (+ tmp.110 2)))
        (begin
          (mset! tmp.87 -2 L.fun/void8763.7.15)
          (mset! tmp.87 6 0)
          (set! fun/void8763.7 tmp.87)))
      (begin
        (begin (set! tmp.111 (alloc 16)) (set! tmp.88 (+ tmp.111 2)))
        (begin
          (mset! tmp.88 -2 L.fun/any8764.8.16)
          (mset! tmp.88 6 0)
          (set! fun/any8764.8 tmp.88)))
      (begin
        (mset! vector-init-loop.15 14 vector-init-loop.15)
        (mset! make-init-vector.1 14 vector-init-loop.15)
        (mset! make-vector.65 14 make-init-vector.1)
        (mset! fun/vector8765.4 14 make-vector.65)
        (begin
          (set! ascii-char0.12
            (call L.fun/ascii-char8761.5.13 fun/ascii-char8761.5))
          (begin
            (set! tmp.112 (call L.fun/any8762.6.14 fun/any8762.6))
            (set! boolean1.11 (call L.vector?.66.8 vector?.66 tmp.112)))
          (set! void2.10 (call L.fun/void8763.7.15 fun/void8763.7))
          (begin
            (set! tmp.113 (call L.fun/any8764.8.16 fun/any8764.8))
            (set! boolean3.9 (call L.boolean?.67.7 boolean?.67 tmp.113)))
          (call L.fun/vector8765.4.12 fun/vector8765.4))))))
(check-by-interp
 '(module
    (define L.lam.110.27 (lambda (c.131) (begin 22574)))
    (define L.fun/pair8798.16.26
      (lambda (c.130)
        (begin
          (set! cons.105 (mref c.130 14))
          (call L.cons.105.13 cons.105 192 2216))))
    (define L.fun/ascii-char8794.15.25
      (lambda (c.129 oprand0.40 oprand1.39 oprand2.38)
        (begin
          (set! fun/ascii-char8795.12 (mref c.129 14))
          (call L.fun/ascii-char8795.12.22 fun/ascii-char8795.12))))
    (define L.fun/error8800.14.24
      (lambda (c.128 oprand0.37 oprand1.36 oprand2.35) (begin oprand2.35)))
    (define L.fun/fixnum8792.13.23 (lambda (c.127) (begin 1480)))
    (define L.fun/ascii-char8795.12.22 (lambda (c.126) (begin 19246)))
    (define L.fun/fixnum8796.11.21
      (lambda (c.125 oprand0.34 oprand1.33 oprand2.32) (begin 2032)))
    (define L.fun/pair8790.10.20
      (lambda (c.124)
        (begin
          (set! cons.105 (mref c.124 14))
          (call L.cons.105.13 cons.105 200 3880))))
    (define L.fun/empty8793.9.19
      (lambda (c.123 oprand0.31 oprand1.30 oprand2.29) (begin 22)))
    (define L.fun/pair8788.8.18
      (lambda (c.122 oprand0.28 oprand1.27 oprand2.26)
        (begin
          (set! fun/pair8789.7 (mref c.122 14))
          (call L.fun/pair8789.7.17 fun/pair8789.7))))
    (define L.fun/pair8789.7.17
      (lambda (c.121)
        (begin
          (set! fun/pair8790.10 (mref c.121 14))
          (call L.fun/pair8790.10.20 fun/pair8790.10))))
    (define L.fun/error8799.6.16
      (lambda (c.120 oprand0.25 oprand1.24 oprand2.23) (begin 40510)))
    (define L.fun/pair8797.5.15
      (lambda (c.119 oprand0.22 oprand1.21 oprand2.20)
        (begin
          (set! fun/pair8798.16 (mref c.119 14))
          (call L.fun/pair8798.16.26 fun/pair8798.16))))
    (define L.fun/fixnum8791.4.14
      (lambda (c.118 oprand0.19 oprand1.18 oprand2.17)
        (begin
          (set! fun/fixnum8792.13 (mref c.118 14))
          (call L.fun/fixnum8792.13.23 fun/fixnum8792.13))))
    (define L.cons.105.13
      (lambda (c.117 tmp.100 tmp.101)
        (begin
          (begin
            (begin (set! tmp.155 (alloc 16)) (set! tmp.132 (+ tmp.155 1)))
            (begin
              (mset! tmp.132 -1 tmp.100)
              (mset! tmp.132 7 tmp.101)
              tmp.132)))))
    (define L.make-vector.106.12
      (lambda (c.116 tmp.81)
        (begin
          (set! make-init-vector.1 (mref c.116 14))
          (if (begin
                (if (begin (set! tmp.157 (bitwise-and tmp.81 7)) (= tmp.157 0))
                  (set! tmp.156 14)
                  (set! tmp.156 6))
                (!= tmp.156 6))
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.81)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.115 tmp.53)
        (begin
          (set! vector-init-loop.55 (mref c.115 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.161 (arithmetic-shift-right tmp.53 3))
                      (set! tmp.160 (+ 1 tmp.161)))
                    (set! tmp.159 (* tmp.160 8)))
                  (set! tmp.158 (alloc tmp.159)))
                (set! tmp.133 (+ tmp.158 3)))
              (begin (mset! tmp.133 -3 tmp.53) (set! tmp.54 tmp.133)))
            (call
             L.vector-init-loop.55.10
             vector-init-loop.55
             tmp.53
             0
             tmp.54)))))
    (define L.vector-init-loop.55.10
      (lambda (c.114 len.56 i.58 vec.57)
        (begin
          (set! vector-init-loop.55 (mref c.114 14))
          (if (begin
                (if (= len.56 i.58) (set! tmp.162 14) (set! tmp.162 6))
                (!= tmp.162 6))
            vec.57
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.165 (arithmetic-shift-right i.58 3))
                    (set! tmp.164 (* tmp.165 8)))
                  (set! tmp.163 (+ tmp.164 5)))
                (mset! vec.57 tmp.163 0))
              (begin
                (set! tmp.166 (+ i.58 8))
                (call
                 L.vector-init-loop.55.10
                 vector-init-loop.55
                 len.56
                 tmp.166
                 vec.57)))))))
    (define L.ascii-char?.107.9
      (lambda (c.113 tmp.94)
        (begin
          (if (begin (set! tmp.167 (bitwise-and tmp.94 255)) (= tmp.167 46))
            14
            6))))
    (define L.>.108.8
      (lambda (c.112 tmp.77 tmp.78)
        (begin
          (if (begin
                (if (begin (set! tmp.169 (bitwise-and tmp.78 7)) (= tmp.169 0))
                  (set! tmp.168 14)
                  (set! tmp.168 6))
                (!= tmp.168 6))
            (if (begin
                  (if (begin
                        (set! tmp.171 (bitwise-and tmp.77 7))
                        (= tmp.171 0))
                    (set! tmp.170 14)
                    (set! tmp.170 6))
                  (!= tmp.170 6))
              (if (> tmp.77 tmp.78) 14 6)
              1598)
            1598))))
    (define L.*.109.7
      (lambda (c.111 tmp.67 tmp.68)
        (begin
          (if (begin
                (if (begin (set! tmp.173 (bitwise-and tmp.68 7)) (= tmp.173 0))
                  (set! tmp.172 14)
                  (set! tmp.172 6))
                (!= tmp.172 6))
            (if (begin
                  (if (begin
                        (set! tmp.175 (bitwise-and tmp.67 7))
                        (= tmp.175 0))
                    (set! tmp.174 14)
                    (set! tmp.174 6))
                  (!= tmp.174 6))
              (begin
                (set! tmp.176 (arithmetic-shift-right tmp.68 3))
                (* tmp.67 tmp.176))
              318)
            318))))
    (begin
      (begin
        (begin (set! tmp.177 (alloc 16)) (set! tmp.134 (+ tmp.177 2)))
        (begin
          (mset! tmp.134 -2 L.*.109.7)
          (mset! tmp.134 6 16)
          (set! *.109 tmp.134)))
      (begin
        (begin (set! tmp.178 (alloc 16)) (set! tmp.135 (+ tmp.178 2)))
        (begin
          (mset! tmp.135 -2 L.>.108.8)
          (mset! tmp.135 6 16)
          (set! >.108 tmp.135)))
      (begin
        (begin (set! tmp.179 (alloc 16)) (set! tmp.136 (+ tmp.179 2)))
        (begin
          (mset! tmp.136 -2 L.ascii-char?.107.9)
          (mset! tmp.136 6 8)
          (set! ascii-char?.107 tmp.136)))
      (begin
        (begin (set! tmp.180 (alloc 24)) (set! tmp.137 (+ tmp.180 2)))
        (begin
          (mset! tmp.137 -2 L.vector-init-loop.55.10)
          (mset! tmp.137 6 24)
          (set! vector-init-loop.55 tmp.137)))
      (begin
        (begin (set! tmp.181 (alloc 24)) (set! tmp.138 (+ tmp.181 2)))
        (begin
          (mset! tmp.138 -2 L.make-init-vector.1.11)
          (mset! tmp.138 6 8)
          (set! make-init-vector.1 tmp.138)))
      (begin
        (begin (set! tmp.182 (alloc 24)) (set! tmp.139 (+ tmp.182 2)))
        (begin
          (mset! tmp.139 -2 L.make-vector.106.12)
          (mset! tmp.139 6 8)
          (set! make-vector.106 tmp.139)))
      (begin
        (begin (set! tmp.183 (alloc 16)) (set! tmp.140 (+ tmp.183 2)))
        (begin
          (mset! tmp.140 -2 L.cons.105.13)
          (mset! tmp.140 6 16)
          (set! cons.105 tmp.140)))
      (begin
        (begin (set! tmp.184 (alloc 24)) (set! tmp.141 (+ tmp.184 2)))
        (begin
          (mset! tmp.141 -2 L.fun/fixnum8791.4.14)
          (mset! tmp.141 6 24)
          (set! fun/fixnum8791.4 tmp.141)))
      (begin
        (begin (set! tmp.185 (alloc 24)) (set! tmp.142 (+ tmp.185 2)))
        (begin
          (mset! tmp.142 -2 L.fun/pair8797.5.15)
          (mset! tmp.142 6 24)
          (set! fun/pair8797.5 tmp.142)))
      (begin
        (begin (set! tmp.186 (alloc 16)) (set! tmp.143 (+ tmp.186 2)))
        (begin
          (mset! tmp.143 -2 L.fun/error8799.6.16)
          (mset! tmp.143 6 24)
          (set! fun/error8799.6 tmp.143)))
      (begin
        (begin (set! tmp.187 (alloc 24)) (set! tmp.144 (+ tmp.187 2)))
        (begin
          (mset! tmp.144 -2 L.fun/pair8789.7.17)
          (mset! tmp.144 6 0)
          (set! fun/pair8789.7 tmp.144)))
      (begin
        (begin (set! tmp.188 (alloc 24)) (set! tmp.145 (+ tmp.188 2)))
        (begin
          (mset! tmp.145 -2 L.fun/pair8788.8.18)
          (mset! tmp.145 6 24)
          (set! fun/pair8788.8 tmp.145)))
      (begin
        (begin (set! tmp.189 (alloc 16)) (set! tmp.146 (+ tmp.189 2)))
        (begin
          (mset! tmp.146 -2 L.fun/empty8793.9.19)
          (mset! tmp.146 6 24)
          (set! fun/empty8793.9 tmp.146)))
      (begin
        (begin (set! tmp.190 (alloc 24)) (set! tmp.147 (+ tmp.190 2)))
        (begin
          (mset! tmp.147 -2 L.fun/pair8790.10.20)
          (mset! tmp.147 6 0)
          (set! fun/pair8790.10 tmp.147)))
      (begin
        (begin (set! tmp.191 (alloc 16)) (set! tmp.148 (+ tmp.191 2)))
        (begin
          (mset! tmp.148 -2 L.fun/fixnum8796.11.21)
          (mset! tmp.148 6 24)
          (set! fun/fixnum8796.11 tmp.148)))
      (begin
        (begin (set! tmp.192 (alloc 16)) (set! tmp.149 (+ tmp.192 2)))
        (begin
          (mset! tmp.149 -2 L.fun/ascii-char8795.12.22)
          (mset! tmp.149 6 0)
          (set! fun/ascii-char8795.12 tmp.149)))
      (begin
        (begin (set! tmp.193 (alloc 16)) (set! tmp.150 (+ tmp.193 2)))
        (begin
          (mset! tmp.150 -2 L.fun/fixnum8792.13.23)
          (mset! tmp.150 6 0)
          (set! fun/fixnum8792.13 tmp.150)))
      (begin
        (begin (set! tmp.194 (alloc 16)) (set! tmp.151 (+ tmp.194 2)))
        (begin
          (mset! tmp.151 -2 L.fun/error8800.14.24)
          (mset! tmp.151 6 24)
          (set! fun/error8800.14 tmp.151)))
      (begin
        (begin (set! tmp.195 (alloc 24)) (set! tmp.152 (+ tmp.195 2)))
        (begin
          (mset! tmp.152 -2 L.fun/ascii-char8794.15.25)
          (mset! tmp.152 6 24)
          (set! fun/ascii-char8794.15 tmp.152)))
      (begin
        (begin (set! tmp.196 (alloc 24)) (set! tmp.153 (+ tmp.196 2)))
        (begin
          (mset! tmp.153 -2 L.fun/pair8798.16.26)
          (mset! tmp.153 6 0)
          (set! fun/pair8798.16 tmp.153)))
      (begin
        (mset! vector-init-loop.55 14 vector-init-loop.55)
        (mset! make-init-vector.1 14 vector-init-loop.55)
        (mset! make-vector.106 14 make-init-vector.1)
        (mset! fun/fixnum8791.4 14 fun/fixnum8792.13)
        (mset! fun/pair8797.5 14 fun/pair8798.16)
        (mset! fun/pair8789.7 14 fun/pair8790.10)
        (mset! fun/pair8788.8 14 fun/pair8789.7)
        (mset! fun/pair8790.10 14 cons.105)
        (mset! fun/ascii-char8794.15 14 fun/ascii-char8795.12)
        (mset! fun/pair8798.16 14 cons.105)
        (begin
          (begin
            (begin
              (set! tmp.199
                (call L.fun/empty8793.9.19 fun/empty8793.9 2000 14 2878))
              (begin
                (if (!= 6 6) (set! tmp.200 22) (set! tmp.200 22))
                (begin
                  (begin
                    (set! tmp.202
                      (call L.make-vector.106.12 make-vector.106 64))
                    (set! tmp.201
                      (call L.ascii-char?.107.9 ascii-char?.107 tmp.202)))
                  (set! tmp.198
                    (call
                     L.fun/fixnum8791.4.14
                     fun/fixnum8791.4
                     tmp.199
                     tmp.200
                     tmp.201)))))
            (begin
              (if (!= 14 6) (set! tmp.203 1456) (set! tmp.203 1672))
              (set! tmp.197 (call L.>.108.8 >.108 tmp.198 tmp.203))))
          (begin
            (begin
              (begin
                (begin
                  (set! error0.44 54078)
                  (set! fixnum1.43 1792)
                  (set! vector2.42
                    (call L.make-vector.106.12 make-vector.106 64))
                  (begin
                    (begin
                      (begin
                        (set! tmp.207 (alloc 16))
                        (set! tmp.154 (+ tmp.207 2)))
                      (begin
                        (mset! tmp.154 -2 L.lam.110.27)
                        (mset! tmp.154 6 0)
                        (set! lam.110 tmp.154)))
                    (set! procedure3.41 lam.110))
                  (set! tmp.206 1808))
                (begin
                  (set! tmp.208
                    (call
                     L.fun/fixnum8796.11.21
                     fun/fixnum8796.11
                     1392
                     57406
                     30))
                  (set! tmp.205 (call L.*.109.7 *.109 tmp.206 tmp.208))))
              (begin
                (begin
                  (set! tmp.210
                    (call L.fun/error8799.6.16 fun/error8799.6 22 48 30))
                  (begin
                    (if (!= 14 6) (set! tmp.211 30) (set! tmp.211 30))
                    (begin
                      (begin
                        (set! tmp.213 (call L.cons.105.13 cons.105 344 2856))
                        (begin
                          (set! tmp.214
                            (call L.make-vector.106.12 make-vector.106 64))
                          (set! tmp.212
                            (call
                             L.fun/ascii-char8794.15.25
                             fun/ascii-char8794.15
                             632
                             tmp.213
                             tmp.214))))
                      (set! tmp.209
                        (call
                         L.fun/pair8797.5.15
                         fun/pair8797.5
                         tmp.210
                         tmp.211
                         tmp.212)))))
                (begin
                  (if (!= 6 6)
                    (set! tmp.215
                      (call L.make-vector.106.12 make-vector.106 64))
                    (set! tmp.215
                      (call L.make-vector.106.12 make-vector.106 64)))
                  (set! tmp.204
                    (call
                     L.fun/ascii-char8794.15.25
                     fun/ascii-char8794.15
                     tmp.205
                     tmp.209
                     tmp.215)))))
            (begin
              (begin
                (if (!= 14 6)
                  (set! tmp.217 (call L.make-vector.106.12 make-vector.106 64))
                  (set! tmp.217
                    (call L.make-vector.106.12 make-vector.106 64)))
                (begin
                  (begin
                    (set! vector0.48
                      (call L.make-vector.106.12 make-vector.106 64))
                    (set! vector1.47
                      (call L.make-vector.106.12 make-vector.106 64))
                    (set! ascii-char2.46 23854)
                    (set! vector3.45
                      (call L.make-vector.106.12 make-vector.106 64))
                    (set! tmp.218 30))
                  (begin
                    (begin
                      (set! boolean0.52 14)
                      (set! void1.51 30)
                      (set! boolean2.50 6)
                      (set! boolean3.49 6)
                      (set! tmp.219 56382))
                    (set! tmp.216
                      (call
                       L.fun/error8800.14.24
                       fun/error8800.14
                       tmp.217
                       tmp.218
                       tmp.219)))))
              (call
               L.fun/pair8788.8.18
               fun/pair8788.8
               tmp.197
               tmp.204
               tmp.216))))))))
(check-by-interp
 '(module
    (define L.fun/void8928.15.18 (lambda (c.84) (begin 30)))
    (define L.fun/error8924.14.17 (lambda (c.83) (begin 33342)))
    (define L.fun/ascii-char8925.13.16
      (lambda (c.82)
        (begin
          (set! fun/ascii-char8926.5 (mref c.82 14))
          (call L.fun/ascii-char8926.5.8 fun/ascii-char8926.5))))
    (define L.fun/error8920.12.15 (lambda (c.81) (begin 47422)))
    (define L.fun/empty8930.11.14 (lambda (c.80) (begin 22)))
    (define L.fun/ascii-char8922.10.13 (lambda (c.79) (begin 27438)))
    (define L.fun/error8919.9.12
      (lambda (c.78)
        (begin
          (set! fun/error8920.12 (mref c.78 14))
          (call L.fun/error8920.12.15 fun/error8920.12))))
    (define L.fun/ascii-char8921.8.11
      (lambda (c.77)
        (begin
          (set! fun/ascii-char8922.10 (mref c.77 14))
          (call L.fun/ascii-char8922.10.13 fun/ascii-char8922.10))))
    (define L.fun/void8927.7.10
      (lambda (c.76)
        (begin
          (set! fun/void8928.15 (mref c.76 14))
          (call L.fun/void8928.15.18 fun/void8928.15))))
    (define L.fun/empty8929.6.9
      (lambda (c.75)
        (begin
          (set! fun/empty8930.11 (mref c.75 14))
          (call L.fun/empty8930.11.14 fun/empty8930.11))))
    (define L.fun/ascii-char8926.5.8 (lambda (c.74) (begin 30766)))
    (define L.fun/error8923.4.7
      (lambda (c.73)
        (begin
          (set! fun/error8924.14 (mref c.73 14))
          (call L.fun/error8924.14.17 fun/error8924.14))))
    (begin
      (begin
        (begin (set! tmp.97 (alloc 24)) (set! tmp.85 (+ tmp.97 2)))
        (begin
          (mset! tmp.85 -2 L.fun/error8923.4.7)
          (mset! tmp.85 6 0)
          (set! fun/error8923.4 tmp.85)))
      (begin
        (begin (set! tmp.98 (alloc 16)) (set! tmp.86 (+ tmp.98 2)))
        (begin
          (mset! tmp.86 -2 L.fun/ascii-char8926.5.8)
          (mset! tmp.86 6 0)
          (set! fun/ascii-char8926.5 tmp.86)))
      (begin
        (begin (set! tmp.99 (alloc 24)) (set! tmp.87 (+ tmp.99 2)))
        (begin
          (mset! tmp.87 -2 L.fun/empty8929.6.9)
          (mset! tmp.87 6 0)
          (set! fun/empty8929.6 tmp.87)))
      (begin
        (begin (set! tmp.100 (alloc 24)) (set! tmp.88 (+ tmp.100 2)))
        (begin
          (mset! tmp.88 -2 L.fun/void8927.7.10)
          (mset! tmp.88 6 0)
          (set! fun/void8927.7 tmp.88)))
      (begin
        (begin (set! tmp.101 (alloc 24)) (set! tmp.89 (+ tmp.101 2)))
        (begin
          (mset! tmp.89 -2 L.fun/ascii-char8921.8.11)
          (mset! tmp.89 6 0)
          (set! fun/ascii-char8921.8 tmp.89)))
      (begin
        (begin (set! tmp.102 (alloc 24)) (set! tmp.90 (+ tmp.102 2)))
        (begin
          (mset! tmp.90 -2 L.fun/error8919.9.12)
          (mset! tmp.90 6 0)
          (set! fun/error8919.9 tmp.90)))
      (begin
        (begin (set! tmp.103 (alloc 16)) (set! tmp.91 (+ tmp.103 2)))
        (begin
          (mset! tmp.91 -2 L.fun/ascii-char8922.10.13)
          (mset! tmp.91 6 0)
          (set! fun/ascii-char8922.10 tmp.91)))
      (begin
        (begin (set! tmp.104 (alloc 16)) (set! tmp.92 (+ tmp.104 2)))
        (begin
          (mset! tmp.92 -2 L.fun/empty8930.11.14)
          (mset! tmp.92 6 0)
          (set! fun/empty8930.11 tmp.92)))
      (begin
        (begin (set! tmp.105 (alloc 16)) (set! tmp.93 (+ tmp.105 2)))
        (begin
          (mset! tmp.93 -2 L.fun/error8920.12.15)
          (mset! tmp.93 6 0)
          (set! fun/error8920.12 tmp.93)))
      (begin
        (begin (set! tmp.106 (alloc 24)) (set! tmp.94 (+ tmp.106 2)))
        (begin
          (mset! tmp.94 -2 L.fun/ascii-char8925.13.16)
          (mset! tmp.94 6 0)
          (set! fun/ascii-char8925.13 tmp.94)))
      (begin
        (begin (set! tmp.107 (alloc 16)) (set! tmp.95 (+ tmp.107 2)))
        (begin
          (mset! tmp.95 -2 L.fun/error8924.14.17)
          (mset! tmp.95 6 0)
          (set! fun/error8924.14 tmp.95)))
      (begin
        (begin (set! tmp.108 (alloc 16)) (set! tmp.96 (+ tmp.108 2)))
        (begin
          (mset! tmp.96 -2 L.fun/void8928.15.18)
          (mset! tmp.96 6 0)
          (set! fun/void8928.15 tmp.96)))
      (begin
        (mset! fun/error8923.4 14 fun/error8924.14)
        (mset! fun/empty8929.6 14 fun/empty8930.11)
        (mset! fun/void8927.7 14 fun/void8928.15)
        (mset! fun/ascii-char8921.8 14 fun/ascii-char8922.10)
        (mset! fun/error8919.9 14 fun/error8920.12)
        (mset! fun/ascii-char8925.13 14 fun/ascii-char8926.5)
        (begin
          (set! error0.20 (call L.fun/error8919.9.12 fun/error8919.9))
          (set! ascii-char1.19
            (call L.fun/ascii-char8921.8.11 fun/ascii-char8921.8))
          (set! error2.18 (call L.fun/error8923.4.7 fun/error8923.4))
          (set! ascii-char3.17
            (call L.fun/ascii-char8925.13.16 fun/ascii-char8925.13))
          (set! void4.16 (call L.fun/void8927.7.10 fun/void8927.7))
          (call L.fun/empty8929.6.9 fun/empty8929.6))))))
(check-by-interp
 '(module
    (define L.lam.72.18
      (lambda (c.84)
        (begin
          (set! |-.67| (mref c.84 14))
          (set! |+.69| (mref c.84 22))
          (set! <=.70 (mref c.84 30))
          (begin
            (begin
              (set! tmp.98 (call L.+.69.9 |+.69| 808 912))
              (begin
                (set! tmp.99 (call L.+.69.9 |+.69| 704 432))
                (set! tmp.97 (call L.+.69.9 |+.69| tmp.98 tmp.99))))
            (begin
              (begin
                (set! tmp.101 (call L.+.69.9 |+.69| 472 16))
                (begin
                  (set! tmp.102 (call L.-.67.11 |-.67| 376 608))
                  (set! tmp.100 (call L.+.69.9 |+.69| tmp.101 tmp.102))))
              (call L.<=.70.8 <=.70 tmp.97 tmp.100))))))
    (define L.fun/void9118.9.17
      (lambda (c.83)
        (begin
          (set! fun/void9119.7 (mref c.83 14))
          (call L.fun/void9119.7.15 fun/void9119.7))))
    (define L.fun/ascii-char9122.8.16
      (lambda (c.82)
        (begin
          (set! fun/ascii-char9123.5 (mref c.82 14))
          (call L.fun/ascii-char9123.5.13 fun/ascii-char9123.5))))
    (define L.fun/void9119.7.15 (lambda (c.81) (begin 30)))
    (define L.fun/empty9120.6.14
      (lambda (c.80)
        (begin
          (set! fun/empty9121.4 (mref c.80 14))
          (call L.fun/empty9121.4.12 fun/empty9121.4))))
    (define L.fun/ascii-char9123.5.13 (lambda (c.79) (begin 29486)))
    (define L.fun/empty9121.4.12 (lambda (c.78) (begin 22)))
    (define L.-.67.11
      (lambda (c.77 tmp.33 tmp.34)
        (begin
          (if (begin
                (if (begin (set! tmp.104 (bitwise-and tmp.34 7)) (= tmp.104 0))
                  (set! tmp.103 14)
                  (set! tmp.103 6))
                (!= tmp.103 6))
            (if (begin
                  (if (begin
                        (set! tmp.106 (bitwise-and tmp.33 7))
                        (= tmp.106 0))
                    (set! tmp.105 14)
                    (set! tmp.105 6))
                  (!= tmp.105 6))
              (- tmp.33 tmp.34)
              830)
            830))))
    (define L.*.68.10
      (lambda (c.76 tmp.29 tmp.30)
        (begin
          (if (begin
                (if (begin (set! tmp.108 (bitwise-and tmp.30 7)) (= tmp.108 0))
                  (set! tmp.107 14)
                  (set! tmp.107 6))
                (!= tmp.107 6))
            (if (begin
                  (if (begin
                        (set! tmp.110 (bitwise-and tmp.29 7))
                        (= tmp.110 0))
                    (set! tmp.109 14)
                    (set! tmp.109 6))
                  (!= tmp.109 6))
              (begin
                (set! tmp.111 (arithmetic-shift-right tmp.30 3))
                (* tmp.29 tmp.111))
              318)
            318))))
    (define L.+.69.9
      (lambda (c.75 tmp.31 tmp.32)
        (begin
          (if (begin
                (if (begin (set! tmp.113 (bitwise-and tmp.32 7)) (= tmp.113 0))
                  (set! tmp.112 14)
                  (set! tmp.112 6))
                (!= tmp.112 6))
            (if (begin
                  (if (begin
                        (set! tmp.115 (bitwise-and tmp.31 7))
                        (= tmp.115 0))
                    (set! tmp.114 14)
                    (set! tmp.114 6))
                  (!= tmp.114 6))
              (+ tmp.31 tmp.32)
              574)
            574))))
    (define L.<=.70.8
      (lambda (c.74 tmp.37 tmp.38)
        (begin
          (if (begin
                (if (begin (set! tmp.117 (bitwise-and tmp.38 7)) (= tmp.117 0))
                  (set! tmp.116 14)
                  (set! tmp.116 6))
                (!= tmp.116 6))
            (if (begin
                  (if (begin
                        (set! tmp.119 (bitwise-and tmp.37 7))
                        (= tmp.119 0))
                    (set! tmp.118 14)
                    (set! tmp.118 6))
                  (!= tmp.118 6))
              (if (<= tmp.37 tmp.38) 14 6)
              1342)
            1342))))
    (define L.>=.71.7
      (lambda (c.73 tmp.41 tmp.42)
        (begin
          (if (begin
                (if (begin (set! tmp.121 (bitwise-and tmp.42 7)) (= tmp.121 0))
                  (set! tmp.120 14)
                  (set! tmp.120 6))
                (!= tmp.120 6))
            (if (begin
                  (if (begin
                        (set! tmp.123 (bitwise-and tmp.41 7))
                        (= tmp.123 0))
                    (set! tmp.122 14)
                    (set! tmp.122 6))
                  (!= tmp.122 6))
              (if (>= tmp.41 tmp.42) 14 6)
              1854)
            1854))))
    (begin
      (begin
        (begin (set! tmp.124 (alloc 16)) (set! tmp.85 (+ tmp.124 2)))
        (begin
          (mset! tmp.85 -2 L.>=.71.7)
          (mset! tmp.85 6 16)
          (set! >=.71 tmp.85)))
      (begin
        (begin (set! tmp.125 (alloc 16)) (set! tmp.86 (+ tmp.125 2)))
        (begin
          (mset! tmp.86 -2 L.<=.70.8)
          (mset! tmp.86 6 16)
          (set! <=.70 tmp.86)))
      (begin
        (begin (set! tmp.126 (alloc 16)) (set! tmp.87 (+ tmp.126 2)))
        (begin
          (mset! tmp.87 -2 L.+.69.9)
          (mset! tmp.87 6 16)
          (set! |+.69| tmp.87)))
      (begin
        (begin (set! tmp.127 (alloc 16)) (set! tmp.88 (+ tmp.127 2)))
        (begin
          (mset! tmp.88 -2 L.*.68.10)
          (mset! tmp.88 6 16)
          (set! *.68 tmp.88)))
      (begin
        (begin (set! tmp.128 (alloc 16)) (set! tmp.89 (+ tmp.128 2)))
        (begin
          (mset! tmp.89 -2 L.-.67.11)
          (mset! tmp.89 6 16)
          (set! |-.67| tmp.89)))
      (begin
        (begin (set! tmp.129 (alloc 16)) (set! tmp.90 (+ tmp.129 2)))
        (begin
          (mset! tmp.90 -2 L.fun/empty9121.4.12)
          (mset! tmp.90 6 0)
          (set! fun/empty9121.4 tmp.90)))
      (begin
        (begin (set! tmp.130 (alloc 16)) (set! tmp.91 (+ tmp.130 2)))
        (begin
          (mset! tmp.91 -2 L.fun/ascii-char9123.5.13)
          (mset! tmp.91 6 0)
          (set! fun/ascii-char9123.5 tmp.91)))
      (begin
        (begin (set! tmp.131 (alloc 24)) (set! tmp.92 (+ tmp.131 2)))
        (begin
          (mset! tmp.92 -2 L.fun/empty9120.6.14)
          (mset! tmp.92 6 0)
          (set! fun/empty9120.6 tmp.92)))
      (begin
        (begin (set! tmp.132 (alloc 16)) (set! tmp.93 (+ tmp.132 2)))
        (begin
          (mset! tmp.93 -2 L.fun/void9119.7.15)
          (mset! tmp.93 6 0)
          (set! fun/void9119.7 tmp.93)))
      (begin
        (begin (set! tmp.133 (alloc 24)) (set! tmp.94 (+ tmp.133 2)))
        (begin
          (mset! tmp.94 -2 L.fun/ascii-char9122.8.16)
          (mset! tmp.94 6 0)
          (set! fun/ascii-char9122.8 tmp.94)))
      (begin
        (begin (set! tmp.134 (alloc 24)) (set! tmp.95 (+ tmp.134 2)))
        (begin
          (mset! tmp.95 -2 L.fun/void9118.9.17)
          (mset! tmp.95 6 0)
          (set! fun/void9118.9 tmp.95)))
      (begin
        (mset! fun/empty9120.6 14 fun/empty9121.4)
        (mset! fun/ascii-char9122.8 14 fun/ascii-char9123.5)
        (mset! fun/void9118.9 14 fun/void9119.7)
        (begin
          (set! void0.14 (call L.fun/void9118.9.17 fun/void9118.9))
          (begin
            (begin
              (set! tmp.136 (call L.-.67.11 |-.67| 200 1808))
              (begin
                (set! tmp.137 (call L.-.67.11 |-.67| 1272 448))
                (set! tmp.135 (call L.*.68.10 *.68 tmp.136 tmp.137))))
            (begin
              (begin
                (set! tmp.139 (call L.*.68.10 *.68 1536 976))
                (begin
                  (set! tmp.140 (call L.-.67.11 |-.67| 376 688))
                  (set! tmp.138 (call L.-.67.11 |-.67| tmp.139 tmp.140))))
              (set! fixnum1.13 (call L.*.68.10 *.68 tmp.135 tmp.138))))
          (set! empty2.12 (call L.fun/empty9120.6.14 fun/empty9120.6))
          (begin
            (begin
              (begin (set! tmp.141 (alloc 40)) (set! tmp.96 (+ tmp.141 2)))
              (begin
                (mset! tmp.96 -2 L.lam.72.18)
                (mset! tmp.96 6 0)
                (set! lam.72 tmp.96)))
            (begin
              (mset! lam.72 14 |-.67|)
              (mset! lam.72 22 |+.69|)
              (mset! lam.72 30 <=.70)
              (set! procedure3.11 lam.72)))
          (set! ascii-char4.10
            (call L.fun/ascii-char9122.8.16 fun/ascii-char9122.8))
          (begin
            (begin
              (set! tmp.143 (call L.+.69.9 |+.69| 544 1336))
              (begin
                (set! tmp.144 (call L.+.69.9 |+.69| 1336 1256))
                (set! tmp.142 (call L.-.67.11 |-.67| tmp.143 tmp.144))))
            (begin
              (begin
                (set! tmp.146 (call L.-.67.11 |-.67| 240 1240))
                (begin
                  (set! tmp.147 (call L.+.69.9 |+.69| 224 808))
                  (set! tmp.145 (call L.-.67.11 |-.67| tmp.146 tmp.147))))
              (call L.>=.71.7 >=.71 tmp.142 tmp.145))))))))
(check-by-interp
 '(module
    (define L.lam.80.23
      (lambda (c.97)
        (begin
          (set! fun/ascii-char9132.7 (mref c.97 14))
          (call L.fun/ascii-char9132.7.15 fun/ascii-char9132.7))))
    (define L.lam.79.22
      (lambda (c.96)
        (begin
          (set! fun/void9126.12 (mref c.96 14))
          (call L.fun/void9126.12.20 fun/void9126.12))))
    (define L.fun/ascii-char9135.13.21 (lambda (c.95) (begin 29998)))
    (define L.fun/void9126.12.20 (lambda (c.94) (begin 30)))
    (define L.fun/vector9134.11.19
      (lambda (c.93)
        (begin
          (set! make-vector.76 (mref c.93 14))
          (call L.make-vector.76.11 make-vector.76 64))))
    (define L.fun/ascii-char9129.10.18 (lambda (c.92) (begin 20526)))
    (define L.fun/vector9133.9.17
      (lambda (c.91)
        (begin
          (set! make-vector.76 (mref c.91 14))
          (call L.make-vector.76.11 make-vector.76 64))))
    (define L.fun/ascii-char9130.8.16 (lambda (c.90) (begin 28718)))
    (define L.fun/ascii-char9132.7.15 (lambda (c.89) (begin 28718)))
    (define L.fun/empty9128.6.14 (lambda (c.88) (begin 22)))
    (define L.fun/ascii-char9131.5.13 (lambda (c.87) (begin 28462)))
    (define L.fun/error9127.4.12 (lambda (c.86) (begin 42814)))
    (define L.make-vector.76.11
      (lambda (c.85 tmp.52)
        (begin
          (set! make-init-vector.1 (mref c.85 14))
          (if (begin
                (if (begin (set! tmp.117 (bitwise-and tmp.52 7)) (= tmp.117 0))
                  (set! tmp.116 14)
                  (set! tmp.116 6))
                (!= tmp.116 6))
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.52)
            2110))))
    (define L.make-init-vector.1.10
      (lambda (c.84 tmp.24)
        (begin
          (set! vector-init-loop.26 (mref c.84 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.121 (arithmetic-shift-right tmp.24 3))
                      (set! tmp.120 (+ 1 tmp.121)))
                    (set! tmp.119 (* tmp.120 8)))
                  (set! tmp.118 (alloc tmp.119)))
                (set! tmp.98 (+ tmp.118 3)))
              (begin (mset! tmp.98 -3 tmp.24) (set! tmp.25 tmp.98)))
            (call
             L.vector-init-loop.26.9
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.9
      (lambda (c.83 len.27 i.29 vec.28)
        (begin
          (set! vector-init-loop.26 (mref c.83 14))
          (if (begin
                (if (= len.27 i.29) (set! tmp.122 14) (set! tmp.122 6))
                (!= tmp.122 6))
            vec.28
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.125 (arithmetic-shift-right i.29 3))
                    (set! tmp.124 (* tmp.125 8)))
                  (set! tmp.123 (+ tmp.124 5)))
                (mset! vec.28 tmp.123 0))
              (begin
                (set! tmp.126 (+ i.29 8))
                (call
                 L.vector-init-loop.26.9
                 vector-init-loop.26
                 len.27
                 tmp.126
                 vec.28)))))))
    (define L.vector?.77.8
      (lambda (c.82 tmp.68)
        (begin
          (if (begin (set! tmp.127 (bitwise-and tmp.68 7)) (= tmp.127 3))
            14
            6))))
    (define L.<=.78.7
      (lambda (c.81 tmp.46 tmp.47)
        (begin
          (if (begin
                (if (begin (set! tmp.129 (bitwise-and tmp.47 7)) (= tmp.129 0))
                  (set! tmp.128 14)
                  (set! tmp.128 6))
                (!= tmp.128 6))
            (if (begin
                  (if (begin
                        (set! tmp.131 (bitwise-and tmp.46 7))
                        (= tmp.131 0))
                    (set! tmp.130 14)
                    (set! tmp.130 6))
                  (!= tmp.130 6))
              (if (<= tmp.46 tmp.47) 14 6)
              1342)
            1342))))
    (begin
      (begin
        (begin (set! tmp.132 (alloc 16)) (set! tmp.99 (+ tmp.132 2)))
        (begin
          (mset! tmp.99 -2 L.<=.78.7)
          (mset! tmp.99 6 16)
          (set! <=.78 tmp.99)))
      (begin
        (begin (set! tmp.133 (alloc 16)) (set! tmp.100 (+ tmp.133 2)))
        (begin
          (mset! tmp.100 -2 L.vector?.77.8)
          (mset! tmp.100 6 8)
          (set! vector?.77 tmp.100)))
      (begin
        (begin (set! tmp.134 (alloc 24)) (set! tmp.101 (+ tmp.134 2)))
        (begin
          (mset! tmp.101 -2 L.vector-init-loop.26.9)
          (mset! tmp.101 6 24)
          (set! vector-init-loop.26 tmp.101)))
      (begin
        (begin (set! tmp.135 (alloc 24)) (set! tmp.102 (+ tmp.135 2)))
        (begin
          (mset! tmp.102 -2 L.make-init-vector.1.10)
          (mset! tmp.102 6 8)
          (set! make-init-vector.1 tmp.102)))
      (begin
        (begin (set! tmp.136 (alloc 24)) (set! tmp.103 (+ tmp.136 2)))
        (begin
          (mset! tmp.103 -2 L.make-vector.76.11)
          (mset! tmp.103 6 8)
          (set! make-vector.76 tmp.103)))
      (begin
        (begin (set! tmp.137 (alloc 16)) (set! tmp.104 (+ tmp.137 2)))
        (begin
          (mset! tmp.104 -2 L.fun/error9127.4.12)
          (mset! tmp.104 6 0)
          (set! fun/error9127.4 tmp.104)))
      (begin
        (begin (set! tmp.138 (alloc 16)) (set! tmp.105 (+ tmp.138 2)))
        (begin
          (mset! tmp.105 -2 L.fun/ascii-char9131.5.13)
          (mset! tmp.105 6 0)
          (set! fun/ascii-char9131.5 tmp.105)))
      (begin
        (begin (set! tmp.139 (alloc 16)) (set! tmp.106 (+ tmp.139 2)))
        (begin
          (mset! tmp.106 -2 L.fun/empty9128.6.14)
          (mset! tmp.106 6 0)
          (set! fun/empty9128.6 tmp.106)))
      (begin
        (begin (set! tmp.140 (alloc 16)) (set! tmp.107 (+ tmp.140 2)))
        (begin
          (mset! tmp.107 -2 L.fun/ascii-char9132.7.15)
          (mset! tmp.107 6 0)
          (set! fun/ascii-char9132.7 tmp.107)))
      (begin
        (begin (set! tmp.141 (alloc 16)) (set! tmp.108 (+ tmp.141 2)))
        (begin
          (mset! tmp.108 -2 L.fun/ascii-char9130.8.16)
          (mset! tmp.108 6 0)
          (set! fun/ascii-char9130.8 tmp.108)))
      (begin
        (begin (set! tmp.142 (alloc 24)) (set! tmp.109 (+ tmp.142 2)))
        (begin
          (mset! tmp.109 -2 L.fun/vector9133.9.17)
          (mset! tmp.109 6 0)
          (set! fun/vector9133.9 tmp.109)))
      (begin
        (begin (set! tmp.143 (alloc 16)) (set! tmp.110 (+ tmp.143 2)))
        (begin
          (mset! tmp.110 -2 L.fun/ascii-char9129.10.18)
          (mset! tmp.110 6 0)
          (set! fun/ascii-char9129.10 tmp.110)))
      (begin
        (begin (set! tmp.144 (alloc 24)) (set! tmp.111 (+ tmp.144 2)))
        (begin
          (mset! tmp.111 -2 L.fun/vector9134.11.19)
          (mset! tmp.111 6 0)
          (set! fun/vector9134.11 tmp.111)))
      (begin
        (begin (set! tmp.145 (alloc 16)) (set! tmp.112 (+ tmp.145 2)))
        (begin
          (mset! tmp.112 -2 L.fun/void9126.12.20)
          (mset! tmp.112 6 0)
          (set! fun/void9126.12 tmp.112)))
      (begin
        (begin (set! tmp.146 (alloc 16)) (set! tmp.113 (+ tmp.146 2)))
        (begin
          (mset! tmp.113 -2 L.fun/ascii-char9135.13.21)
          (mset! tmp.113 6 0)
          (set! fun/ascii-char9135.13 tmp.113)))
      (begin
        (mset! vector-init-loop.26 14 vector-init-loop.26)
        (mset! make-init-vector.1 14 vector-init-loop.26)
        (mset! make-vector.76 14 make-init-vector.1)
        (mset! fun/vector9133.9 14 make-vector.76)
        (mset! fun/vector9134.11 14 make-vector.76)
        (if (begin
              (begin
                (if (!= 6 6) (set! tmp.148 22) (set! tmp.148 30))
                (set! tmp.147 (call L.vector?.77.8 vector?.77 tmp.148)))
              (!= tmp.147 6))
          (begin
            (begin
              (begin
                (begin (set! tmp.149 (alloc 24)) (set! tmp.114 (+ tmp.149 2)))
                (begin
                  (mset! tmp.114 -2 L.lam.79.22)
                  (mset! tmp.114 6 0)
                  (set! lam.79 tmp.114)))
              (begin
                (mset! lam.79 14 fun/void9126.12)
                (set! procedure0.18 lam.79)))
            (set! error1.17 (call L.fun/error9127.4.12 fun/error9127.4))
            (set! empty2.16 (call L.fun/empty9128.6.14 fun/empty9128.6))
            (set! ascii-char3.15
              (call L.fun/ascii-char9129.10.18 fun/ascii-char9129.10))
            (set! ascii-char4.14
              (call L.fun/ascii-char9130.8.16 fun/ascii-char9130.8))
            (call L.fun/ascii-char9131.5.13 fun/ascii-char9131.5))
          (begin
            (begin
              (begin
                (begin (set! tmp.150 (alloc 24)) (set! tmp.115 (+ tmp.150 2)))
                (begin
                  (mset! tmp.115 -2 L.lam.80.23)
                  (mset! tmp.115 6 0)
                  (set! lam.80 tmp.115)))
              (begin
                (mset! lam.80 14 fun/ascii-char9132.7)
                (set! procedure0.23 lam.80)))
            (set! vector1.22 (call L.fun/vector9133.9.17 fun/vector9133.9))
            (set! vector2.21 (call L.fun/vector9134.11.19 fun/vector9134.11))
            (set! ascii-char3.20
              (call L.fun/ascii-char9135.13.21 fun/ascii-char9135.13))
            (set! boolean4.19 (call L.<=.78.7 <=.78 336 1256))
            (if (begin
                  (if (begin
                        (set! tmp.152 (bitwise-and procedure0.23 7))
                        (= tmp.152 2))
                    (set! tmp.151 14)
                    (set! tmp.151 6))
                  (!= tmp.151 6))
              (if (begin
                    (if (begin
                          (set! tmp.154 (mref procedure0.23 6))
                          (= tmp.154 0))
                      (set! tmp.153 14)
                      (set! tmp.153 6))
                    (!= tmp.153 6))
                (begin
                  (set! tmp.155 (mref procedure0.23 -2))
                  (call tmp.155 procedure0.23))
                10814)
              11070)))))))
(check-by-interp
 '(module
    (define L.lam.73.19
      (lambda (c.86)
        (begin
          (set! fun/error9191.12 (mref c.86 14))
          (call L.fun/error9191.12.15 fun/error9191.12))))
    (define L.fun/void9201.15.18
      (lambda (c.85)
        (begin
          (set! fun/void9202.11 (mref c.85 14))
          (call L.fun/void9202.11.14 fun/void9202.11))))
    (define L.fun/error9192.14.17 (lambda (c.84) (begin 54590)))
    (define L.fun/error9196.13.16 (lambda (c.83) (begin 50750)))
    (define L.fun/error9191.12.15
      (lambda (c.82)
        (begin
          (set! fun/error9192.14 (mref c.82 14))
          (call L.fun/error9192.14.17 fun/error9192.14))))
    (define L.fun/void9202.11.14 (lambda (c.81) (begin 30)))
    (define L.fun/empty9200.10.13 (lambda (c.80) (begin 22)))
    (define L.fun/ascii-char9193.9.12
      (lambda (c.79)
        (begin
          (set! fun/ascii-char9194.4 (mref c.79 14))
          (call L.fun/ascii-char9194.4.7 fun/ascii-char9194.4))))
    (define L.fun/void9198.8.11 (lambda (c.78) (begin 30)))
    (define L.fun/empty9199.7.10
      (lambda (c.77)
        (begin
          (set! fun/empty9200.10 (mref c.77 14))
          (call L.fun/empty9200.10.13 fun/empty9200.10))))
    (define L.fun/error9195.6.9
      (lambda (c.76)
        (begin
          (set! fun/error9196.13 (mref c.76 14))
          (call L.fun/error9196.13.16 fun/error9196.13))))
    (define L.fun/void9197.5.8
      (lambda (c.75)
        (begin
          (set! fun/void9198.8 (mref c.75 14))
          (call L.fun/void9198.8.11 fun/void9198.8))))
    (define L.fun/ascii-char9194.4.7 (lambda (c.74) (begin 26158)))
    (begin
      (begin
        (begin (set! tmp.100 (alloc 16)) (set! tmp.87 (+ tmp.100 2)))
        (begin
          (mset! tmp.87 -2 L.fun/ascii-char9194.4.7)
          (mset! tmp.87 6 0)
          (set! fun/ascii-char9194.4 tmp.87)))
      (begin
        (begin (set! tmp.101 (alloc 24)) (set! tmp.88 (+ tmp.101 2)))
        (begin
          (mset! tmp.88 -2 L.fun/void9197.5.8)
          (mset! tmp.88 6 0)
          (set! fun/void9197.5 tmp.88)))
      (begin
        (begin (set! tmp.102 (alloc 24)) (set! tmp.89 (+ tmp.102 2)))
        (begin
          (mset! tmp.89 -2 L.fun/error9195.6.9)
          (mset! tmp.89 6 0)
          (set! fun/error9195.6 tmp.89)))
      (begin
        (begin (set! tmp.103 (alloc 24)) (set! tmp.90 (+ tmp.103 2)))
        (begin
          (mset! tmp.90 -2 L.fun/empty9199.7.10)
          (mset! tmp.90 6 0)
          (set! fun/empty9199.7 tmp.90)))
      (begin
        (begin (set! tmp.104 (alloc 16)) (set! tmp.91 (+ tmp.104 2)))
        (begin
          (mset! tmp.91 -2 L.fun/void9198.8.11)
          (mset! tmp.91 6 0)
          (set! fun/void9198.8 tmp.91)))
      (begin
        (begin (set! tmp.105 (alloc 24)) (set! tmp.92 (+ tmp.105 2)))
        (begin
          (mset! tmp.92 -2 L.fun/ascii-char9193.9.12)
          (mset! tmp.92 6 0)
          (set! fun/ascii-char9193.9 tmp.92)))
      (begin
        (begin (set! tmp.106 (alloc 16)) (set! tmp.93 (+ tmp.106 2)))
        (begin
          (mset! tmp.93 -2 L.fun/empty9200.10.13)
          (mset! tmp.93 6 0)
          (set! fun/empty9200.10 tmp.93)))
      (begin
        (begin (set! tmp.107 (alloc 16)) (set! tmp.94 (+ tmp.107 2)))
        (begin
          (mset! tmp.94 -2 L.fun/void9202.11.14)
          (mset! tmp.94 6 0)
          (set! fun/void9202.11 tmp.94)))
      (begin
        (begin (set! tmp.108 (alloc 24)) (set! tmp.95 (+ tmp.108 2)))
        (begin
          (mset! tmp.95 -2 L.fun/error9191.12.15)
          (mset! tmp.95 6 0)
          (set! fun/error9191.12 tmp.95)))
      (begin
        (begin (set! tmp.109 (alloc 16)) (set! tmp.96 (+ tmp.109 2)))
        (begin
          (mset! tmp.96 -2 L.fun/error9196.13.16)
          (mset! tmp.96 6 0)
          (set! fun/error9196.13 tmp.96)))
      (begin
        (begin (set! tmp.110 (alloc 16)) (set! tmp.97 (+ tmp.110 2)))
        (begin
          (mset! tmp.97 -2 L.fun/error9192.14.17)
          (mset! tmp.97 6 0)
          (set! fun/error9192.14 tmp.97)))
      (begin
        (begin (set! tmp.111 (alloc 24)) (set! tmp.98 (+ tmp.111 2)))
        (begin
          (mset! tmp.98 -2 L.fun/void9201.15.18)
          (mset! tmp.98 6 0)
          (set! fun/void9201.15 tmp.98)))
      (begin
        (mset! fun/void9197.5 14 fun/void9198.8)
        (mset! fun/error9195.6 14 fun/error9196.13)
        (mset! fun/empty9199.7 14 fun/empty9200.10)
        (mset! fun/ascii-char9193.9 14 fun/ascii-char9194.4)
        (mset! fun/error9191.12 14 fun/error9192.14)
        (mset! fun/void9201.15 14 fun/void9202.11)
        (begin
          (begin
            (begin
              (begin (set! tmp.112 (alloc 24)) (set! tmp.99 (+ tmp.112 2)))
              (begin
                (mset! tmp.99 -2 L.lam.73.19)
                (mset! tmp.99 6 0)
                (set! lam.73 tmp.99)))
            (begin
              (mset! lam.73 14 fun/error9191.12)
              (set! procedure0.20 lam.73)))
          (set! ascii-char1.19
            (call L.fun/ascii-char9193.9.12 fun/ascii-char9193.9))
          (set! error2.18 (call L.fun/error9195.6.9 fun/error9195.6))
          (set! void3.17 (call L.fun/void9197.5.8 fun/void9197.5))
          (set! empty4.16 (call L.fun/empty9199.7.10 fun/empty9199.7))
          (call L.fun/void9201.15.18 fun/void9201.15))))))
(check-by-interp
 '(module
    (define L.lam.75.23
      (lambda (c.92)
        (begin
          (set! fun/vector9888.10 (mref c.92 14))
          (call L.fun/vector9888.10.19 fun/vector9888.10))))
    (define L.fun/vector9889.13.22
      (lambda (c.91)
        (begin
          (set! make-vector.71 (mref c.91 14))
          (call L.make-vector.71.12 make-vector.71 64))))
    (define L.fun/void9885.12.21 (lambda (c.90) (begin 30)))
    (define L.fun/ascii-char9886.11.20
      (lambda (c.89)
        (begin
          (set! fun/ascii-char9887.6 (mref c.89 14))
          (call L.fun/ascii-char9887.6.15 fun/ascii-char9887.6))))
    (define L.fun/vector9888.10.19
      (lambda (c.88)
        (begin
          (set! fun/vector9889.13 (mref c.88 14))
          (call L.fun/vector9889.13.22 fun/vector9889.13))))
    (define L.fun/void9891.9.18 (lambda (c.87) (begin 30)))
    (define L.fun/void9884.8.17
      (lambda (c.86)
        (begin
          (set! fun/void9885.12 (mref c.86 14))
          (call L.fun/void9885.12.21 fun/void9885.12))))
    (define L.fun/ascii-char9892.7.16
      (lambda (c.85)
        (begin
          (set! fun/ascii-char9893.4 (mref c.85 14))
          (call L.fun/ascii-char9893.4.13 fun/ascii-char9893.4))))
    (define L.fun/ascii-char9887.6.15 (lambda (c.84) (begin 23854)))
    (define L.fun/void9890.5.14
      (lambda (c.83)
        (begin
          (set! fun/void9891.9 (mref c.83 14))
          (call L.fun/void9891.9.18 fun/void9891.9))))
    (define L.fun/ascii-char9893.4.13 (lambda (c.82) (begin 20782)))
    (define L.make-vector.71.12
      (lambda (c.81 tmp.47)
        (begin
          (set! make-init-vector.1 (mref c.81 14))
          (if (begin
                (if (begin (set! tmp.112 (bitwise-and tmp.47 7)) (= tmp.112 0))
                  (set! tmp.111 14)
                  (set! tmp.111 6))
                (!= tmp.111 6))
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.47)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.80 tmp.19)
        (begin
          (set! vector-init-loop.21 (mref c.80 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.116 (arithmetic-shift-right tmp.19 3))
                      (set! tmp.115 (+ 1 tmp.116)))
                    (set! tmp.114 (* tmp.115 8)))
                  (set! tmp.113 (alloc tmp.114)))
                (set! tmp.93 (+ tmp.113 3)))
              (begin (mset! tmp.93 -3 tmp.19) (set! tmp.20 tmp.93)))
            (call
             L.vector-init-loop.21.10
             vector-init-loop.21
             tmp.19
             0
             tmp.20)))))
    (define L.vector-init-loop.21.10
      (lambda (c.79 len.22 i.24 vec.23)
        (begin
          (set! vector-init-loop.21 (mref c.79 14))
          (if (begin
                (if (= len.22 i.24) (set! tmp.117 14) (set! tmp.117 6))
                (!= tmp.117 6))
            vec.23
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.120 (arithmetic-shift-right i.24 3))
                    (set! tmp.119 (* tmp.120 8)))
                  (set! tmp.118 (+ tmp.119 5)))
                (mset! vec.23 tmp.118 0))
              (begin
                (set! tmp.121 (+ i.24 8))
                (call
                 L.vector-init-loop.21.10
                 vector-init-loop.21
                 len.22
                 tmp.121
                 vec.23)))))))
    (define L.+.72.9
      (lambda (c.78 tmp.35 tmp.36)
        (begin
          (if (begin
                (if (begin (set! tmp.123 (bitwise-and tmp.36 7)) (= tmp.123 0))
                  (set! tmp.122 14)
                  (set! tmp.122 6))
                (!= tmp.122 6))
            (if (begin
                  (if (begin
                        (set! tmp.125 (bitwise-and tmp.35 7))
                        (= tmp.125 0))
                    (set! tmp.124 14)
                    (set! tmp.124 6))
                  (!= tmp.124 6))
              (+ tmp.35 tmp.36)
              574)
            574))))
    (define L.*.73.8
      (lambda (c.77 tmp.33 tmp.34)
        (begin
          (if (begin
                (if (begin (set! tmp.127 (bitwise-and tmp.34 7)) (= tmp.127 0))
                  (set! tmp.126 14)
                  (set! tmp.126 6))
                (!= tmp.126 6))
            (if (begin
                  (if (begin
                        (set! tmp.129 (bitwise-and tmp.33 7))
                        (= tmp.129 0))
                    (set! tmp.128 14)
                    (set! tmp.128 6))
                  (!= tmp.128 6))
              (begin
                (set! tmp.130 (arithmetic-shift-right tmp.34 3))
                (* tmp.33 tmp.130))
              318)
            318))))
    (define L.-.74.7
      (lambda (c.76 tmp.37 tmp.38)
        (begin
          (if (begin
                (if (begin (set! tmp.132 (bitwise-and tmp.38 7)) (= tmp.132 0))
                  (set! tmp.131 14)
                  (set! tmp.131 6))
                (!= tmp.131 6))
            (if (begin
                  (if (begin
                        (set! tmp.134 (bitwise-and tmp.37 7))
                        (= tmp.134 0))
                    (set! tmp.133 14)
                    (set! tmp.133 6))
                  (!= tmp.133 6))
              (- tmp.37 tmp.38)
              830)
            830))))
    (begin
      (begin
        (begin (set! tmp.135 (alloc 16)) (set! tmp.94 (+ tmp.135 2)))
        (begin
          (mset! tmp.94 -2 L.-.74.7)
          (mset! tmp.94 6 16)
          (set! |-.74| tmp.94)))
      (begin
        (begin (set! tmp.136 (alloc 16)) (set! tmp.95 (+ tmp.136 2)))
        (begin
          (mset! tmp.95 -2 L.*.73.8)
          (mset! tmp.95 6 16)
          (set! *.73 tmp.95)))
      (begin
        (begin (set! tmp.137 (alloc 16)) (set! tmp.96 (+ tmp.137 2)))
        (begin
          (mset! tmp.96 -2 L.+.72.9)
          (mset! tmp.96 6 16)
          (set! |+.72| tmp.96)))
      (begin
        (begin (set! tmp.138 (alloc 24)) (set! tmp.97 (+ tmp.138 2)))
        (begin
          (mset! tmp.97 -2 L.vector-init-loop.21.10)
          (mset! tmp.97 6 24)
          (set! vector-init-loop.21 tmp.97)))
      (begin
        (begin (set! tmp.139 (alloc 24)) (set! tmp.98 (+ tmp.139 2)))
        (begin
          (mset! tmp.98 -2 L.make-init-vector.1.11)
          (mset! tmp.98 6 8)
          (set! make-init-vector.1 tmp.98)))
      (begin
        (begin (set! tmp.140 (alloc 24)) (set! tmp.99 (+ tmp.140 2)))
        (begin
          (mset! tmp.99 -2 L.make-vector.71.12)
          (mset! tmp.99 6 8)
          (set! make-vector.71 tmp.99)))
      (begin
        (begin (set! tmp.141 (alloc 16)) (set! tmp.100 (+ tmp.141 2)))
        (begin
          (mset! tmp.100 -2 L.fun/ascii-char9893.4.13)
          (mset! tmp.100 6 0)
          (set! fun/ascii-char9893.4 tmp.100)))
      (begin
        (begin (set! tmp.142 (alloc 24)) (set! tmp.101 (+ tmp.142 2)))
        (begin
          (mset! tmp.101 -2 L.fun/void9890.5.14)
          (mset! tmp.101 6 0)
          (set! fun/void9890.5 tmp.101)))
      (begin
        (begin (set! tmp.143 (alloc 16)) (set! tmp.102 (+ tmp.143 2)))
        (begin
          (mset! tmp.102 -2 L.fun/ascii-char9887.6.15)
          (mset! tmp.102 6 0)
          (set! fun/ascii-char9887.6 tmp.102)))
      (begin
        (begin (set! tmp.144 (alloc 24)) (set! tmp.103 (+ tmp.144 2)))
        (begin
          (mset! tmp.103 -2 L.fun/ascii-char9892.7.16)
          (mset! tmp.103 6 0)
          (set! fun/ascii-char9892.7 tmp.103)))
      (begin
        (begin (set! tmp.145 (alloc 24)) (set! tmp.104 (+ tmp.145 2)))
        (begin
          (mset! tmp.104 -2 L.fun/void9884.8.17)
          (mset! tmp.104 6 0)
          (set! fun/void9884.8 tmp.104)))
      (begin
        (begin (set! tmp.146 (alloc 16)) (set! tmp.105 (+ tmp.146 2)))
        (begin
          (mset! tmp.105 -2 L.fun/void9891.9.18)
          (mset! tmp.105 6 0)
          (set! fun/void9891.9 tmp.105)))
      (begin
        (begin (set! tmp.147 (alloc 24)) (set! tmp.106 (+ tmp.147 2)))
        (begin
          (mset! tmp.106 -2 L.fun/vector9888.10.19)
          (mset! tmp.106 6 0)
          (set! fun/vector9888.10 tmp.106)))
      (begin
        (begin (set! tmp.148 (alloc 24)) (set! tmp.107 (+ tmp.148 2)))
        (begin
          (mset! tmp.107 -2 L.fun/ascii-char9886.11.20)
          (mset! tmp.107 6 0)
          (set! fun/ascii-char9886.11 tmp.107)))
      (begin
        (begin (set! tmp.149 (alloc 16)) (set! tmp.108 (+ tmp.149 2)))
        (begin
          (mset! tmp.108 -2 L.fun/void9885.12.21)
          (mset! tmp.108 6 0)
          (set! fun/void9885.12 tmp.108)))
      (begin
        (begin (set! tmp.150 (alloc 24)) (set! tmp.109 (+ tmp.150 2)))
        (begin
          (mset! tmp.109 -2 L.fun/vector9889.13.22)
          (mset! tmp.109 6 0)
          (set! fun/vector9889.13 tmp.109)))
      (begin
        (mset! vector-init-loop.21 14 vector-init-loop.21)
        (mset! make-init-vector.1 14 vector-init-loop.21)
        (mset! make-vector.71 14 make-init-vector.1)
        (mset! fun/void9890.5 14 fun/void9891.9)
        (mset! fun/ascii-char9892.7 14 fun/ascii-char9893.4)
        (mset! fun/void9884.8 14 fun/void9885.12)
        (mset! fun/vector9888.10 14 fun/vector9889.13)
        (mset! fun/ascii-char9886.11 14 fun/ascii-char9887.6)
        (mset! fun/vector9889.13 14 make-vector.71)
        (begin
          (set! void0.18 (call L.fun/void9884.8.17 fun/void9884.8))
          (set! ascii-char1.17
            (call L.fun/ascii-char9886.11.20 fun/ascii-char9886.11))
          (begin
            (begin
              (begin (set! tmp.151 (alloc 24)) (set! tmp.110 (+ tmp.151 2)))
              (begin
                (mset! tmp.110 -2 L.lam.75.23)
                (mset! tmp.110 6 0)
                (set! lam.75 tmp.110)))
            (begin
              (mset! lam.75 14 fun/vector9888.10)
              (set! procedure2.16 lam.75)))
          (set! void3.15 (call L.fun/void9890.5.14 fun/void9890.5))
          (begin
            (begin
              (set! tmp.153 (call L.+.72.9 |+.72| 1344 192))
              (begin
                (set! tmp.154 (call L.*.73.8 *.73 1656 992))
                (set! tmp.152 (call L.*.73.8 *.73 tmp.153 tmp.154))))
            (begin
              (begin
                (set! tmp.156 (call L.*.73.8 *.73 1016 1992))
                (begin
                  (set! tmp.157 (call L.-.74.7 |-.74| 1568 1688))
                  (set! tmp.155 (call L.*.73.8 *.73 tmp.156 tmp.157))))
              (set! fixnum4.14 (call L.*.73.8 *.73 tmp.152 tmp.155))))
          (call L.fun/ascii-char9892.7.16 fun/ascii-char9892.7))))))
(check-by-interp
 '(module
    (define L.lam.74.22
      (lambda (c.90)
        (begin
          (set! fun/void10281.10 (mref c.90 14))
          (call L.fun/void10281.10.21 fun/void10281.10))))
    (define L.fun/void10281.10.21
      (lambda (c.89)
        (begin
          (set! fun/void10282.4 (mref c.89 14))
          (call L.fun/void10282.4.15 fun/void10282.4))))
    (define L.fun/any10280.9.20 (lambda (c.88) (begin 6)))
    (define L.fun/vector10279.8.19
      (lambda (c.87)
        (begin
          (set! make-vector.68 (mref c.87 14))
          (call L.make-vector.68.14 make-vector.68 64))))
    (define L.fun/empty10283.7.18
      (lambda (c.86)
        (begin
          (set! fun/empty10284.5 (mref c.86 14))
          (call L.fun/empty10284.5.16 fun/empty10284.5))))
    (define L.fun/vector10278.6.17
      (lambda (c.85)
        (begin
          (set! fun/vector10279.8 (mref c.85 14))
          (call L.fun/vector10279.8.19 fun/vector10279.8))))
    (define L.fun/empty10284.5.16 (lambda (c.84) (begin 22)))
    (define L.fun/void10282.4.15 (lambda (c.83) (begin 30)))
    (define L.make-vector.68.14
      (lambda (c.82 tmp.44)
        (begin
          (set! make-init-vector.1 (mref c.82 14))
          (if (begin
                (if (begin (set! tmp.109 (bitwise-and tmp.44 7)) (= tmp.109 0))
                  (set! tmp.108 14)
                  (set! tmp.108 6))
                (!= tmp.108 6))
            (call L.make-init-vector.1.13 make-init-vector.1 tmp.44)
            2110))))
    (define L.make-init-vector.1.13
      (lambda (c.81 tmp.16)
        (begin
          (set! vector-init-loop.18 (mref c.81 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.113 (arithmetic-shift-right tmp.16 3))
                      (set! tmp.112 (+ 1 tmp.113)))
                    (set! tmp.111 (* tmp.112 8)))
                  (set! tmp.110 (alloc tmp.111)))
                (set! tmp.91 (+ tmp.110 3)))
              (begin (mset! tmp.91 -3 tmp.16) (set! tmp.17 tmp.91)))
            (call
             L.vector-init-loop.18.12
             vector-init-loop.18
             tmp.16
             0
             tmp.17)))))
    (define L.vector-init-loop.18.12
      (lambda (c.80 len.19 i.21 vec.20)
        (begin
          (set! vector-init-loop.18 (mref c.80 14))
          (if (begin
                (if (= len.19 i.21) (set! tmp.114 14) (set! tmp.114 6))
                (!= tmp.114 6))
            vec.20
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.117 (arithmetic-shift-right i.21 3))
                    (set! tmp.116 (* tmp.117 8)))
                  (set! tmp.115 (+ tmp.116 5)))
                (mset! vec.20 tmp.115 0))
              (begin
                (set! tmp.118 (+ i.21 8))
                (call
                 L.vector-init-loop.18.12
                 vector-init-loop.18
                 len.19
                 tmp.118
                 vec.20)))))))
    (define L.void?.69.11
      (lambda (c.79 tmp.56)
        (begin
          (if (begin (set! tmp.119 (bitwise-and tmp.56 255)) (= tmp.119 30))
            14
            6))))
    (define L.+.70.10
      (lambda (c.78 tmp.32 tmp.33)
        (begin
          (if (begin
                (if (begin (set! tmp.121 (bitwise-and tmp.33 7)) (= tmp.121 0))
                  (set! tmp.120 14)
                  (set! tmp.120 6))
                (!= tmp.120 6))
            (if (begin
                  (if (begin
                        (set! tmp.123 (bitwise-and tmp.32 7))
                        (= tmp.123 0))
                    (set! tmp.122 14)
                    (set! tmp.122 6))
                  (!= tmp.122 6))
              (+ tmp.32 tmp.33)
              574)
            574))))
    (define L.-.71.9
      (lambda (c.77 tmp.34 tmp.35)
        (begin
          (if (begin
                (if (begin (set! tmp.125 (bitwise-and tmp.35 7)) (= tmp.125 0))
                  (set! tmp.124 14)
                  (set! tmp.124 6))
                (!= tmp.124 6))
            (if (begin
                  (if (begin
                        (set! tmp.127 (bitwise-and tmp.34 7))
                        (= tmp.127 0))
                    (set! tmp.126 14)
                    (set! tmp.126 6))
                  (!= tmp.126 6))
              (- tmp.34 tmp.35)
              830)
            830))))
    (define L.*.72.8
      (lambda (c.76 tmp.30 tmp.31)
        (begin
          (if (begin
                (if (begin (set! tmp.129 (bitwise-and tmp.31 7)) (= tmp.129 0))
                  (set! tmp.128 14)
                  (set! tmp.128 6))
                (!= tmp.128 6))
            (if (begin
                  (if (begin
                        (set! tmp.131 (bitwise-and tmp.30 7))
                        (= tmp.131 0))
                    (set! tmp.130 14)
                    (set! tmp.130 6))
                  (!= tmp.130 6))
              (begin
                (set! tmp.132 (arithmetic-shift-right tmp.31 3))
                (* tmp.30 tmp.132))
              318)
            318))))
    (define L.<=.73.7
      (lambda (c.75 tmp.38 tmp.39)
        (begin
          (if (begin
                (if (begin (set! tmp.134 (bitwise-and tmp.39 7)) (= tmp.134 0))
                  (set! tmp.133 14)
                  (set! tmp.133 6))
                (!= tmp.133 6))
            (if (begin
                  (if (begin
                        (set! tmp.136 (bitwise-and tmp.38 7))
                        (= tmp.136 0))
                    (set! tmp.135 14)
                    (set! tmp.135 6))
                  (!= tmp.135 6))
              (if (<= tmp.38 tmp.39) 14 6)
              1342)
            1342))))
    (begin
      (begin
        (begin (set! tmp.137 (alloc 16)) (set! tmp.92 (+ tmp.137 2)))
        (begin
          (mset! tmp.92 -2 L.<=.73.7)
          (mset! tmp.92 6 16)
          (set! <=.73 tmp.92)))
      (begin
        (begin (set! tmp.138 (alloc 16)) (set! tmp.93 (+ tmp.138 2)))
        (begin
          (mset! tmp.93 -2 L.*.72.8)
          (mset! tmp.93 6 16)
          (set! *.72 tmp.93)))
      (begin
        (begin (set! tmp.139 (alloc 16)) (set! tmp.94 (+ tmp.139 2)))
        (begin
          (mset! tmp.94 -2 L.-.71.9)
          (mset! tmp.94 6 16)
          (set! |-.71| tmp.94)))
      (begin
        (begin (set! tmp.140 (alloc 16)) (set! tmp.95 (+ tmp.140 2)))
        (begin
          (mset! tmp.95 -2 L.+.70.10)
          (mset! tmp.95 6 16)
          (set! |+.70| tmp.95)))
      (begin
        (begin (set! tmp.141 (alloc 16)) (set! tmp.96 (+ tmp.141 2)))
        (begin
          (mset! tmp.96 -2 L.void?.69.11)
          (mset! tmp.96 6 8)
          (set! void?.69 tmp.96)))
      (begin
        (begin (set! tmp.142 (alloc 24)) (set! tmp.97 (+ tmp.142 2)))
        (begin
          (mset! tmp.97 -2 L.vector-init-loop.18.12)
          (mset! tmp.97 6 24)
          (set! vector-init-loop.18 tmp.97)))
      (begin
        (begin (set! tmp.143 (alloc 24)) (set! tmp.98 (+ tmp.143 2)))
        (begin
          (mset! tmp.98 -2 L.make-init-vector.1.13)
          (mset! tmp.98 6 8)
          (set! make-init-vector.1 tmp.98)))
      (begin
        (begin (set! tmp.144 (alloc 24)) (set! tmp.99 (+ tmp.144 2)))
        (begin
          (mset! tmp.99 -2 L.make-vector.68.14)
          (mset! tmp.99 6 8)
          (set! make-vector.68 tmp.99)))
      (begin
        (begin (set! tmp.145 (alloc 16)) (set! tmp.100 (+ tmp.145 2)))
        (begin
          (mset! tmp.100 -2 L.fun/void10282.4.15)
          (mset! tmp.100 6 0)
          (set! fun/void10282.4 tmp.100)))
      (begin
        (begin (set! tmp.146 (alloc 16)) (set! tmp.101 (+ tmp.146 2)))
        (begin
          (mset! tmp.101 -2 L.fun/empty10284.5.16)
          (mset! tmp.101 6 0)
          (set! fun/empty10284.5 tmp.101)))
      (begin
        (begin (set! tmp.147 (alloc 24)) (set! tmp.102 (+ tmp.147 2)))
        (begin
          (mset! tmp.102 -2 L.fun/vector10278.6.17)
          (mset! tmp.102 6 0)
          (set! fun/vector10278.6 tmp.102)))
      (begin
        (begin (set! tmp.148 (alloc 24)) (set! tmp.103 (+ tmp.148 2)))
        (begin
          (mset! tmp.103 -2 L.fun/empty10283.7.18)
          (mset! tmp.103 6 0)
          (set! fun/empty10283.7 tmp.103)))
      (begin
        (begin (set! tmp.149 (alloc 24)) (set! tmp.104 (+ tmp.149 2)))
        (begin
          (mset! tmp.104 -2 L.fun/vector10279.8.19)
          (mset! tmp.104 6 0)
          (set! fun/vector10279.8 tmp.104)))
      (begin
        (begin (set! tmp.150 (alloc 16)) (set! tmp.105 (+ tmp.150 2)))
        (begin
          (mset! tmp.105 -2 L.fun/any10280.9.20)
          (mset! tmp.105 6 0)
          (set! fun/any10280.9 tmp.105)))
      (begin
        (begin (set! tmp.151 (alloc 24)) (set! tmp.106 (+ tmp.151 2)))
        (begin
          (mset! tmp.106 -2 L.fun/void10281.10.21)
          (mset! tmp.106 6 0)
          (set! fun/void10281.10 tmp.106)))
      (begin
        (mset! vector-init-loop.18 14 vector-init-loop.18)
        (mset! make-init-vector.1 14 vector-init-loop.18)
        (mset! make-vector.68 14 make-init-vector.1)
        (mset! fun/vector10278.6 14 fun/vector10279.8)
        (mset! fun/empty10283.7 14 fun/empty10284.5)
        (mset! fun/vector10279.8 14 make-vector.68)
        (mset! fun/void10281.10 14 fun/void10282.4)
        (begin
          (set! vector0.15 (call L.fun/vector10278.6.17 fun/vector10278.6))
          (begin
            (set! tmp.152 (call L.fun/any10280.9.20 fun/any10280.9))
            (set! boolean1.14 (call L.void?.69.11 void?.69 tmp.152)))
          (begin
            (begin
              (set! tmp.154 (call L.+.70.10 |+.70| 952 1448))
              (begin
                (set! tmp.155 (call L.+.70.10 |+.70| 576 840))
                (set! tmp.153 (call L.-.71.9 |-.71| tmp.154 tmp.155))))
            (begin
              (begin
                (set! tmp.157 (call L.+.70.10 |+.70| 648 1232))
                (begin
                  (set! tmp.158 (call L.*.72.8 *.72 1128 648))
                  (set! tmp.156 (call L.-.71.9 |-.71| tmp.157 tmp.158))))
              (set! fixnum2.13 (call L.+.70.10 |+.70| tmp.153 tmp.156))))
          (begin
            (begin
              (begin (set! tmp.159 (alloc 24)) (set! tmp.107 (+ tmp.159 2)))
              (begin
                (mset! tmp.107 -2 L.lam.74.22)
                (mset! tmp.107 6 0)
                (set! lam.74 tmp.107)))
            (begin
              (mset! lam.74 14 fun/void10281.10)
              (set! procedure3.12 lam.74)))
          (begin
            (begin
              (set! tmp.161 (call L.-.71.9 |-.71| 1408 1016))
              (begin
                (set! tmp.162 (call L.+.70.10 |+.70| 1488 1008))
                (set! tmp.160 (call L.*.72.8 *.72 tmp.161 tmp.162))))
            (begin
              (begin
                (set! tmp.164 (call L.*.72.8 *.72 600 2024))
                (begin
                  (set! tmp.165 (call L.-.71.9 |-.71| 1480 1656))
                  (set! tmp.163 (call L.-.71.9 |-.71| tmp.164 tmp.165))))
              (set! boolean4.11 (call L.<=.73.7 <=.73 tmp.160 tmp.163))))
          (call L.fun/empty10283.7.18 fun/empty10283.7))))))
(check-by-interp
 '(module
    (define L.fun/void10625.9.15
      (lambda (c.78)
        (begin
          (set! fun/void10626.6 (mref c.78 14))
          (call L.fun/void10626.6.12 fun/void10626.6))))
    (define L.fun/void10628.8.14 (lambda (c.77) (begin 30)))
    (define L.fun/void10627.7.13
      (lambda (c.76)
        (begin
          (set! fun/void10628.8 (mref c.76 14))
          (call L.fun/void10628.8.14 fun/void10628.8))))
    (define L.fun/void10626.6.12 (lambda (c.75) (begin 30)))
    (define L.fun/error10624.5.11 (lambda (c.74) (begin 19262)))
    (define L.fun/error10623.4.10
      (lambda (c.73)
        (begin
          (set! fun/error10624.5 (mref c.73 14))
          (call L.fun/error10624.5.11 fun/error10624.5))))
    (define L.+.67.9
      (lambda (c.72 tmp.31 tmp.32)
        (begin
          (if (begin
                (if (begin (set! tmp.89 (bitwise-and tmp.32 7)) (= tmp.89 0))
                  (set! tmp.88 14)
                  (set! tmp.88 6))
                (!= tmp.88 6))
            (if (begin
                  (if (begin (set! tmp.91 (bitwise-and tmp.31 7)) (= tmp.91 0))
                    (set! tmp.90 14)
                    (set! tmp.90 6))
                  (!= tmp.90 6))
              (+ tmp.31 tmp.32)
              574)
            574))))
    (define L.-.68.8
      (lambda (c.71 tmp.33 tmp.34)
        (begin
          (if (begin
                (if (begin (set! tmp.93 (bitwise-and tmp.34 7)) (= tmp.93 0))
                  (set! tmp.92 14)
                  (set! tmp.92 6))
                (!= tmp.92 6))
            (if (begin
                  (if (begin (set! tmp.95 (bitwise-and tmp.33 7)) (= tmp.95 0))
                    (set! tmp.94 14)
                    (set! tmp.94 6))
                  (!= tmp.94 6))
              (- tmp.33 tmp.34)
              830)
            830))))
    (define L.*.69.7
      (lambda (c.70 tmp.29 tmp.30)
        (begin
          (if (begin
                (if (begin (set! tmp.97 (bitwise-and tmp.30 7)) (= tmp.97 0))
                  (set! tmp.96 14)
                  (set! tmp.96 6))
                (!= tmp.96 6))
            (if (begin
                  (if (begin (set! tmp.99 (bitwise-and tmp.29 7)) (= tmp.99 0))
                    (set! tmp.98 14)
                    (set! tmp.98 6))
                  (!= tmp.98 6))
              (begin
                (set! tmp.100 (arithmetic-shift-right tmp.30 3))
                (* tmp.29 tmp.100))
              318)
            318))))
    (begin
      (begin
        (begin (set! tmp.101 (alloc 16)) (set! tmp.79 (+ tmp.101 2)))
        (begin
          (mset! tmp.79 -2 L.*.69.7)
          (mset! tmp.79 6 16)
          (set! *.69 tmp.79)))
      (begin
        (begin (set! tmp.102 (alloc 16)) (set! tmp.80 (+ tmp.102 2)))
        (begin
          (mset! tmp.80 -2 L.-.68.8)
          (mset! tmp.80 6 16)
          (set! |-.68| tmp.80)))
      (begin
        (begin (set! tmp.103 (alloc 16)) (set! tmp.81 (+ tmp.103 2)))
        (begin
          (mset! tmp.81 -2 L.+.67.9)
          (mset! tmp.81 6 16)
          (set! |+.67| tmp.81)))
      (begin
        (begin (set! tmp.104 (alloc 24)) (set! tmp.82 (+ tmp.104 2)))
        (begin
          (mset! tmp.82 -2 L.fun/error10623.4.10)
          (mset! tmp.82 6 0)
          (set! fun/error10623.4 tmp.82)))
      (begin
        (begin (set! tmp.105 (alloc 16)) (set! tmp.83 (+ tmp.105 2)))
        (begin
          (mset! tmp.83 -2 L.fun/error10624.5.11)
          (mset! tmp.83 6 0)
          (set! fun/error10624.5 tmp.83)))
      (begin
        (begin (set! tmp.106 (alloc 16)) (set! tmp.84 (+ tmp.106 2)))
        (begin
          (mset! tmp.84 -2 L.fun/void10626.6.12)
          (mset! tmp.84 6 0)
          (set! fun/void10626.6 tmp.84)))
      (begin
        (begin (set! tmp.107 (alloc 24)) (set! tmp.85 (+ tmp.107 2)))
        (begin
          (mset! tmp.85 -2 L.fun/void10627.7.13)
          (mset! tmp.85 6 0)
          (set! fun/void10627.7 tmp.85)))
      (begin
        (begin (set! tmp.108 (alloc 16)) (set! tmp.86 (+ tmp.108 2)))
        (begin
          (mset! tmp.86 -2 L.fun/void10628.8.14)
          (mset! tmp.86 6 0)
          (set! fun/void10628.8 tmp.86)))
      (begin
        (begin (set! tmp.109 (alloc 24)) (set! tmp.87 (+ tmp.109 2)))
        (begin
          (mset! tmp.87 -2 L.fun/void10625.9.15)
          (mset! tmp.87 6 0)
          (set! fun/void10625.9 tmp.87)))
      (begin
        (mset! fun/error10623.4 14 fun/error10624.5)
        (mset! fun/void10627.7 14 fun/void10628.8)
        (mset! fun/void10625.9 14 fun/void10626.6)
        (begin
          (set! error0.14 (call L.fun/error10623.4.10 fun/error10623.4))
          (set! void1.13 (call L.fun/void10625.9.15 fun/void10625.9))
          (begin
            (begin
              (set! tmp.111 (call L.+.67.9 |+.67| 1416 768))
              (begin
                (set! tmp.112 (call L.-.68.8 |-.68| 520 1656))
                (set! tmp.110 (call L.+.67.9 |+.67| tmp.111 tmp.112))))
            (begin
              (begin
                (set! tmp.114 (call L.-.68.8 |-.68| 1360 88))
                (begin
                  (set! tmp.115 (call L.*.69.7 *.69 416 1432))
                  (set! tmp.113 (call L.*.69.7 *.69 tmp.114 tmp.115))))
              (set! fixnum2.12 (call L.+.67.9 |+.67| tmp.110 tmp.113))))
          (begin
            (begin
              (set! tmp.117 (call L.-.68.8 |-.68| 576 1624))
              (begin
                (set! tmp.118 (call L.+.67.9 |+.67| 1152 1944))
                (set! tmp.116 (call L.+.67.9 |+.67| tmp.117 tmp.118))))
            (begin
              (begin
                (set! tmp.120 (call L.-.68.8 |-.68| 1432 2024))
                (begin
                  (set! tmp.121 (call L.*.69.7 *.69 336 392))
                  (set! tmp.119 (call L.-.68.8 |-.68| tmp.120 tmp.121))))
              (set! fixnum3.11 (call L.*.69.7 *.69 tmp.116 tmp.119))))
          (begin
            (begin
              (set! tmp.123 (call L.*.69.7 *.69 376 1808))
              (begin
                (set! tmp.124 (call L.-.68.8 |-.68| 1664 992))
                (set! tmp.122 (call L.+.67.9 |+.67| tmp.123 tmp.124))))
            (begin
              (begin
                (set! tmp.126 (call L.+.67.9 |+.67| 1840 1216))
                (begin
                  (set! tmp.127 (call L.+.67.9 |+.67| 1712 1752))
                  (set! tmp.125 (call L.-.68.8 |-.68| tmp.126 tmp.127))))
              (set! fixnum4.10 (call L.-.68.8 |-.68| tmp.122 tmp.125))))
          (call L.fun/void10627.7.13 fun/void10627.7))))))
(check-by-interp
 '(module
    (define L.lam.74.22
      (lambda (c.90)
        (begin
          (set! fun/ascii-char10710.8 (mref c.90 14))
          (call L.fun/ascii-char10710.8.15 fun/ascii-char10710.8))))
    (define L.fun/void10716.14.21 (lambda (c.89) (begin 30)))
    (define L.fun/empty10709.13.20 (lambda (c.88) (begin 22)))
    (define L.fun/ascii-char10711.12.19 (lambda (c.87) (begin 23342)))
    (define L.fun/vector10713.11.18
      (lambda (c.86)
        (begin
          (set! make-vector.72 (mref c.86 14))
          (call L.make-vector.72.10 make-vector.72 64))))
    (define L.fun/error10717.10.17
      (lambda (c.85)
        (begin
          (set! fun/error10718.4 (mref c.85 14))
          (call L.fun/error10718.4.11 fun/error10718.4))))
    (define L.fun/empty10708.9.16
      (lambda (c.84)
        (begin
          (set! fun/empty10709.13 (mref c.84 14))
          (call L.fun/empty10709.13.20 fun/empty10709.13))))
    (define L.fun/ascii-char10710.8.15
      (lambda (c.83)
        (begin
          (set! fun/ascii-char10711.12 (mref c.83 14))
          (call L.fun/ascii-char10711.12.19 fun/ascii-char10711.12))))
    (define L.fun/vector10712.7.14
      (lambda (c.82)
        (begin
          (set! fun/vector10713.11 (mref c.82 14))
          (call L.fun/vector10713.11.18 fun/vector10713.11))))
    (define L.fun/void10715.6.13
      (lambda (c.81)
        (begin
          (set! fun/void10716.14 (mref c.81 14))
          (call L.fun/void10716.14.21 fun/void10716.14))))
    (define L.fun/any10714.5.12
      (lambda (c.80)
        (begin
          (set! make-vector.72 (mref c.80 14))
          (call L.make-vector.72.10 make-vector.72 64))))
    (define L.fun/error10718.4.11 (lambda (c.79) (begin 46910)))
    (define L.make-vector.72.10
      (lambda (c.78 tmp.48)
        (begin
          (set! make-init-vector.1 (mref c.78 14))
          (if (begin
                (if (begin (set! tmp.109 (bitwise-and tmp.48 7)) (= tmp.109 0))
                  (set! tmp.108 14)
                  (set! tmp.108 6))
                (!= tmp.108 6))
            (call L.make-init-vector.1.9 make-init-vector.1 tmp.48)
            2110))))
    (define L.make-init-vector.1.9
      (lambda (c.77 tmp.20)
        (begin
          (set! vector-init-loop.22 (mref c.77 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.113 (arithmetic-shift-right tmp.20 3))
                      (set! tmp.112 (+ 1 tmp.113)))
                    (set! tmp.111 (* tmp.112 8)))
                  (set! tmp.110 (alloc tmp.111)))
                (set! tmp.91 (+ tmp.110 3)))
              (begin (mset! tmp.91 -3 tmp.20) (set! tmp.21 tmp.91)))
            (call
             L.vector-init-loop.22.8
             vector-init-loop.22
             tmp.20
             0
             tmp.21)))))
    (define L.vector-init-loop.22.8
      (lambda (c.76 len.23 i.25 vec.24)
        (begin
          (set! vector-init-loop.22 (mref c.76 14))
          (if (begin
                (if (= len.23 i.25) (set! tmp.114 14) (set! tmp.114 6))
                (!= tmp.114 6))
            vec.24
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.117 (arithmetic-shift-right i.25 3))
                    (set! tmp.116 (* tmp.117 8)))
                  (set! tmp.115 (+ tmp.116 5)))
                (mset! vec.24 tmp.115 0))
              (begin
                (set! tmp.118 (+ i.25 8))
                (call
                 L.vector-init-loop.22.8
                 vector-init-loop.22
                 len.23
                 tmp.118
                 vec.24)))))))
    (define L.fixnum?.73.7
      (lambda (c.75 tmp.57)
        (begin
          (if (begin (set! tmp.119 (bitwise-and tmp.57 7)) (= tmp.119 0))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.120 (alloc 16)) (set! tmp.92 (+ tmp.120 2)))
        (begin
          (mset! tmp.92 -2 L.fixnum?.73.7)
          (mset! tmp.92 6 8)
          (set! fixnum?.73 tmp.92)))
      (begin
        (begin (set! tmp.121 (alloc 24)) (set! tmp.93 (+ tmp.121 2)))
        (begin
          (mset! tmp.93 -2 L.vector-init-loop.22.8)
          (mset! tmp.93 6 24)
          (set! vector-init-loop.22 tmp.93)))
      (begin
        (begin (set! tmp.122 (alloc 24)) (set! tmp.94 (+ tmp.122 2)))
        (begin
          (mset! tmp.94 -2 L.make-init-vector.1.9)
          (mset! tmp.94 6 8)
          (set! make-init-vector.1 tmp.94)))
      (begin
        (begin (set! tmp.123 (alloc 24)) (set! tmp.95 (+ tmp.123 2)))
        (begin
          (mset! tmp.95 -2 L.make-vector.72.10)
          (mset! tmp.95 6 8)
          (set! make-vector.72 tmp.95)))
      (begin
        (begin (set! tmp.124 (alloc 16)) (set! tmp.96 (+ tmp.124 2)))
        (begin
          (mset! tmp.96 -2 L.fun/error10718.4.11)
          (mset! tmp.96 6 0)
          (set! fun/error10718.4 tmp.96)))
      (begin
        (begin (set! tmp.125 (alloc 24)) (set! tmp.97 (+ tmp.125 2)))
        (begin
          (mset! tmp.97 -2 L.fun/any10714.5.12)
          (mset! tmp.97 6 0)
          (set! fun/any10714.5 tmp.97)))
      (begin
        (begin (set! tmp.126 (alloc 24)) (set! tmp.98 (+ tmp.126 2)))
        (begin
          (mset! tmp.98 -2 L.fun/void10715.6.13)
          (mset! tmp.98 6 0)
          (set! fun/void10715.6 tmp.98)))
      (begin
        (begin (set! tmp.127 (alloc 24)) (set! tmp.99 (+ tmp.127 2)))
        (begin
          (mset! tmp.99 -2 L.fun/vector10712.7.14)
          (mset! tmp.99 6 0)
          (set! fun/vector10712.7 tmp.99)))
      (begin
        (begin (set! tmp.128 (alloc 24)) (set! tmp.100 (+ tmp.128 2)))
        (begin
          (mset! tmp.100 -2 L.fun/ascii-char10710.8.15)
          (mset! tmp.100 6 0)
          (set! fun/ascii-char10710.8 tmp.100)))
      (begin
        (begin (set! tmp.129 (alloc 24)) (set! tmp.101 (+ tmp.129 2)))
        (begin
          (mset! tmp.101 -2 L.fun/empty10708.9.16)
          (mset! tmp.101 6 0)
          (set! fun/empty10708.9 tmp.101)))
      (begin
        (begin (set! tmp.130 (alloc 24)) (set! tmp.102 (+ tmp.130 2)))
        (begin
          (mset! tmp.102 -2 L.fun/error10717.10.17)
          (mset! tmp.102 6 0)
          (set! fun/error10717.10 tmp.102)))
      (begin
        (begin (set! tmp.131 (alloc 24)) (set! tmp.103 (+ tmp.131 2)))
        (begin
          (mset! tmp.103 -2 L.fun/vector10713.11.18)
          (mset! tmp.103 6 0)
          (set! fun/vector10713.11 tmp.103)))
      (begin
        (begin (set! tmp.132 (alloc 16)) (set! tmp.104 (+ tmp.132 2)))
        (begin
          (mset! tmp.104 -2 L.fun/ascii-char10711.12.19)
          (mset! tmp.104 6 0)
          (set! fun/ascii-char10711.12 tmp.104)))
      (begin
        (begin (set! tmp.133 (alloc 16)) (set! tmp.105 (+ tmp.133 2)))
        (begin
          (mset! tmp.105 -2 L.fun/empty10709.13.20)
          (mset! tmp.105 6 0)
          (set! fun/empty10709.13 tmp.105)))
      (begin
        (begin (set! tmp.134 (alloc 16)) (set! tmp.106 (+ tmp.134 2)))
        (begin
          (mset! tmp.106 -2 L.fun/void10716.14.21)
          (mset! tmp.106 6 0)
          (set! fun/void10716.14 tmp.106)))
      (begin
        (mset! vector-init-loop.22 14 vector-init-loop.22)
        (mset! make-init-vector.1 14 vector-init-loop.22)
        (mset! make-vector.72 14 make-init-vector.1)
        (mset! fun/any10714.5 14 make-vector.72)
        (mset! fun/void10715.6 14 fun/void10716.14)
        (mset! fun/vector10712.7 14 fun/vector10713.11)
        (mset! fun/ascii-char10710.8 14 fun/ascii-char10711.12)
        (mset! fun/empty10708.9 14 fun/empty10709.13)
        (mset! fun/error10717.10 14 fun/error10718.4)
        (mset! fun/vector10713.11 14 make-vector.72)
        (begin
          (set! empty0.19 (call L.fun/empty10708.9.16 fun/empty10708.9))
          (begin
            (begin
              (begin (set! tmp.135 (alloc 24)) (set! tmp.107 (+ tmp.135 2)))
              (begin
                (mset! tmp.107 -2 L.lam.74.22)
                (mset! tmp.107 6 0)
                (set! lam.74 tmp.107)))
            (begin
              (mset! lam.74 14 fun/ascii-char10710.8)
              (set! procedure1.18 lam.74)))
          (set! vector2.17 (call L.fun/vector10712.7.14 fun/vector10712.7))
          (begin
            (set! tmp.136 (call L.fun/any10714.5.12 fun/any10714.5))
            (set! boolean3.16 (call L.fixnum?.73.7 fixnum?.73 tmp.136)))
          (set! void4.15 (call L.fun/void10715.6.13 fun/void10715.6))
          (call L.fun/error10717.10.17 fun/error10717.10))))))
(check-by-interp
 '(module
    (define L.lam.75.24
      (lambda (c.93)
        (begin
          (set! |-.70| (mref c.93 14))
          (set! |+.71| (mref c.93 22))
          (begin
            (begin
              (set! tmp.114 (call L.-.70.10 |-.70| 720 1008))
              (begin
                (set! tmp.115 (call L.-.70.10 |-.70| 768 864))
                (set! tmp.113 (call L.-.70.10 |-.70| tmp.114 tmp.115))))
            (begin
              (begin
                (set! tmp.117 (call L.+.71.9 |+.71| 808 840))
                (begin
                  (set! tmp.118 (call L.-.70.10 |-.70| 1304 1512))
                  (set! tmp.116 (call L.+.71.9 |+.71| tmp.117 tmp.118))))
              (call L.+.71.9 |+.71| tmp.113 tmp.116))))))
    (define L.lam.74.23
      (lambda (c.92)
        (begin
          (set! fun/ascii-char10795.7 (mref c.92 14))
          (call L.fun/ascii-char10795.7.17 fun/ascii-char10795.7))))
    (define L.lam.73.22
      (lambda (c.91)
        (begin
          (set! fun/void10791.4 (mref c.91 14))
          (call L.fun/void10791.4.14 fun/void10791.4))))
    (define L.fun/ascii-char10793.11.21
      (lambda (c.90)
        (begin
          (set! fun/ascii-char10794.5 (mref c.90 14))
          (call L.fun/ascii-char10794.5.15 fun/ascii-char10794.5))))
    (define L.fun/void10792.10.20 (lambda (c.89) (begin 30)))
    (define L.fun/vector10790.9.19
      (lambda (c.88)
        (begin
          (set! make-vector.69 (mref c.88 14))
          (call L.make-vector.69.13 make-vector.69 64))))
    (define L.fun/vector10789.8.18
      (lambda (c.87)
        (begin
          (set! fun/vector10790.9 (mref c.87 14))
          (call L.fun/vector10790.9.19 fun/vector10790.9))))
    (define L.fun/ascii-char10795.7.17
      (lambda (c.86)
        (begin
          (set! fun/ascii-char10796.6 (mref c.86 14))
          (call L.fun/ascii-char10796.6.16 fun/ascii-char10796.6))))
    (define L.fun/ascii-char10796.6.16 (lambda (c.85) (begin 27182)))
    (define L.fun/ascii-char10794.5.15 (lambda (c.84) (begin 17966)))
    (define L.fun/void10791.4.14
      (lambda (c.83)
        (begin
          (set! fun/void10792.10 (mref c.83 14))
          (call L.fun/void10792.10.20 fun/void10792.10))))
    (define L.make-vector.69.13
      (lambda (c.82 tmp.45)
        (begin
          (set! make-init-vector.1 (mref c.82 14))
          (if (begin
                (if (begin (set! tmp.120 (bitwise-and tmp.45 7)) (= tmp.120 0))
                  (set! tmp.119 14)
                  (set! tmp.119 6))
                (!= tmp.119 6))
            (call L.make-init-vector.1.12 make-init-vector.1 tmp.45)
            2110))))
    (define L.make-init-vector.1.12
      (lambda (c.81 tmp.17)
        (begin
          (set! vector-init-loop.19 (mref c.81 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.124 (arithmetic-shift-right tmp.17 3))
                      (set! tmp.123 (+ 1 tmp.124)))
                    (set! tmp.122 (* tmp.123 8)))
                  (set! tmp.121 (alloc tmp.122)))
                (set! tmp.94 (+ tmp.121 3)))
              (begin (mset! tmp.94 -3 tmp.17) (set! tmp.18 tmp.94)))
            (call
             L.vector-init-loop.19.11
             vector-init-loop.19
             tmp.17
             0
             tmp.18)))))
    (define L.vector-init-loop.19.11
      (lambda (c.80 len.20 i.22 vec.21)
        (begin
          (set! vector-init-loop.19 (mref c.80 14))
          (if (begin
                (if (= len.20 i.22) (set! tmp.125 14) (set! tmp.125 6))
                (!= tmp.125 6))
            vec.21
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.128 (arithmetic-shift-right i.22 3))
                    (set! tmp.127 (* tmp.128 8)))
                  (set! tmp.126 (+ tmp.127 5)))
                (mset! vec.21 tmp.126 0))
              (begin
                (set! tmp.129 (+ i.22 8))
                (call
                 L.vector-init-loop.19.11
                 vector-init-loop.19
                 len.20
                 tmp.129
                 vec.21)))))))
    (define L.-.70.10
      (lambda (c.79 tmp.35 tmp.36)
        (begin
          (if (begin
                (if (begin (set! tmp.131 (bitwise-and tmp.36 7)) (= tmp.131 0))
                  (set! tmp.130 14)
                  (set! tmp.130 6))
                (!= tmp.130 6))
            (if (begin
                  (if (begin
                        (set! tmp.133 (bitwise-and tmp.35 7))
                        (= tmp.133 0))
                    (set! tmp.132 14)
                    (set! tmp.132 6))
                  (!= tmp.132 6))
              (- tmp.35 tmp.36)
              830)
            830))))
    (define L.+.71.9
      (lambda (c.78 tmp.33 tmp.34)
        (begin
          (if (begin
                (if (begin (set! tmp.135 (bitwise-and tmp.34 7)) (= tmp.135 0))
                  (set! tmp.134 14)
                  (set! tmp.134 6))
                (!= tmp.134 6))
            (if (begin
                  (if (begin
                        (set! tmp.137 (bitwise-and tmp.33 7))
                        (= tmp.137 0))
                    (set! tmp.136 14)
                    (set! tmp.136 6))
                  (!= tmp.136 6))
              (+ tmp.33 tmp.34)
              574)
            574))))
    (define L.vector-ref.72.8
      (lambda (c.77 tmp.50 tmp.51)
        (begin
          (set! unsafe-vector-ref.3 (mref c.77 14))
          (if (begin
                (if (begin (set! tmp.139 (bitwise-and tmp.51 7)) (= tmp.139 0))
                  (set! tmp.138 14)
                  (set! tmp.138 6))
                (!= tmp.138 6))
            (if (begin
                  (if (begin
                        (set! tmp.141 (bitwise-and tmp.50 7))
                        (= tmp.141 3))
                    (set! tmp.140 14)
                    (set! tmp.140 6))
                  (!= tmp.140 6))
              (call L.unsafe-vector-ref.3.7 unsafe-vector-ref.3 tmp.50 tmp.51)
              2878)
            2878))))
    (define L.unsafe-vector-ref.3.7
      (lambda (c.76 tmp.28 tmp.29)
        (begin
          (if (begin
                (if (begin (set! tmp.143 (mref tmp.28 -3)) (< tmp.29 tmp.143))
                  (set! tmp.142 14)
                  (set! tmp.142 6))
                (!= tmp.142 6))
            (if (begin
                  (if (>= tmp.29 0) (set! tmp.144 14) (set! tmp.144 6))
                  (!= tmp.144 6))
              (begin
                (begin
                  (begin
                    (set! tmp.147 (arithmetic-shift-right tmp.29 3))
                    (set! tmp.146 (* tmp.147 8)))
                  (set! tmp.145 (+ tmp.146 5)))
                (mref tmp.28 tmp.145))
              2878)
            2878))))
    (begin
      (begin
        (begin (set! tmp.148 (alloc 16)) (set! tmp.95 (+ tmp.148 2)))
        (begin
          (mset! tmp.95 -2 L.unsafe-vector-ref.3.7)
          (mset! tmp.95 6 16)
          (set! unsafe-vector-ref.3 tmp.95)))
      (begin
        (begin (set! tmp.149 (alloc 24)) (set! tmp.96 (+ tmp.149 2)))
        (begin
          (mset! tmp.96 -2 L.vector-ref.72.8)
          (mset! tmp.96 6 16)
          (set! vector-ref.72 tmp.96)))
      (begin
        (begin (set! tmp.150 (alloc 16)) (set! tmp.97 (+ tmp.150 2)))
        (begin
          (mset! tmp.97 -2 L.+.71.9)
          (mset! tmp.97 6 16)
          (set! |+.71| tmp.97)))
      (begin
        (begin (set! tmp.151 (alloc 16)) (set! tmp.98 (+ tmp.151 2)))
        (begin
          (mset! tmp.98 -2 L.-.70.10)
          (mset! tmp.98 6 16)
          (set! |-.70| tmp.98)))
      (begin
        (begin (set! tmp.152 (alloc 24)) (set! tmp.99 (+ tmp.152 2)))
        (begin
          (mset! tmp.99 -2 L.vector-init-loop.19.11)
          (mset! tmp.99 6 24)
          (set! vector-init-loop.19 tmp.99)))
      (begin
        (begin (set! tmp.153 (alloc 24)) (set! tmp.100 (+ tmp.153 2)))
        (begin
          (mset! tmp.100 -2 L.make-init-vector.1.12)
          (mset! tmp.100 6 8)
          (set! make-init-vector.1 tmp.100)))
      (begin
        (begin (set! tmp.154 (alloc 24)) (set! tmp.101 (+ tmp.154 2)))
        (begin
          (mset! tmp.101 -2 L.make-vector.69.13)
          (mset! tmp.101 6 8)
          (set! make-vector.69 tmp.101)))
      (begin
        (begin (set! tmp.155 (alloc 24)) (set! tmp.102 (+ tmp.155 2)))
        (begin
          (mset! tmp.102 -2 L.fun/void10791.4.14)
          (mset! tmp.102 6 0)
          (set! fun/void10791.4 tmp.102)))
      (begin
        (begin (set! tmp.156 (alloc 16)) (set! tmp.103 (+ tmp.156 2)))
        (begin
          (mset! tmp.103 -2 L.fun/ascii-char10794.5.15)
          (mset! tmp.103 6 0)
          (set! fun/ascii-char10794.5 tmp.103)))
      (begin
        (begin (set! tmp.157 (alloc 16)) (set! tmp.104 (+ tmp.157 2)))
        (begin
          (mset! tmp.104 -2 L.fun/ascii-char10796.6.16)
          (mset! tmp.104 6 0)
          (set! fun/ascii-char10796.6 tmp.104)))
      (begin
        (begin (set! tmp.158 (alloc 24)) (set! tmp.105 (+ tmp.158 2)))
        (begin
          (mset! tmp.105 -2 L.fun/ascii-char10795.7.17)
          (mset! tmp.105 6 0)
          (set! fun/ascii-char10795.7 tmp.105)))
      (begin
        (begin (set! tmp.159 (alloc 24)) (set! tmp.106 (+ tmp.159 2)))
        (begin
          (mset! tmp.106 -2 L.fun/vector10789.8.18)
          (mset! tmp.106 6 0)
          (set! fun/vector10789.8 tmp.106)))
      (begin
        (begin (set! tmp.160 (alloc 24)) (set! tmp.107 (+ tmp.160 2)))
        (begin
          (mset! tmp.107 -2 L.fun/vector10790.9.19)
          (mset! tmp.107 6 0)
          (set! fun/vector10790.9 tmp.107)))
      (begin
        (begin (set! tmp.161 (alloc 16)) (set! tmp.108 (+ tmp.161 2)))
        (begin
          (mset! tmp.108 -2 L.fun/void10792.10.20)
          (mset! tmp.108 6 0)
          (set! fun/void10792.10 tmp.108)))
      (begin
        (begin (set! tmp.162 (alloc 24)) (set! tmp.109 (+ tmp.162 2)))
        (begin
          (mset! tmp.109 -2 L.fun/ascii-char10793.11.21)
          (mset! tmp.109 6 0)
          (set! fun/ascii-char10793.11 tmp.109)))
      (begin
        (mset! vector-ref.72 14 unsafe-vector-ref.3)
        (mset! vector-init-loop.19 14 vector-init-loop.19)
        (mset! make-init-vector.1 14 vector-init-loop.19)
        (mset! make-vector.69 14 make-init-vector.1)
        (mset! fun/void10791.4 14 fun/void10792.10)
        (mset! fun/ascii-char10795.7 14 fun/ascii-char10796.6)
        (mset! fun/vector10789.8 14 fun/vector10790.9)
        (mset! fun/vector10790.9 14 make-vector.69)
        (mset! fun/ascii-char10793.11 14 fun/ascii-char10794.5)
        (begin
          (set! vector0.16 (call L.fun/vector10789.8.18 fun/vector10789.8))
          (begin
            (begin
              (begin (set! tmp.163 (alloc 24)) (set! tmp.110 (+ tmp.163 2)))
              (begin
                (mset! tmp.110 -2 L.lam.73.22)
                (mset! tmp.110 6 0)
                (set! lam.73 tmp.110)))
            (begin
              (mset! lam.73 14 fun/void10791.4)
              (set! procedure1.15 lam.73)))
          (set! ascii-char2.14
            (call L.fun/ascii-char10793.11.21 fun/ascii-char10793.11))
          (begin
            (begin
              (begin (set! tmp.164 (alloc 24)) (set! tmp.111 (+ tmp.164 2)))
              (begin
                (mset! tmp.111 -2 L.lam.74.23)
                (mset! tmp.111 6 0)
                (set! lam.74 tmp.111)))
            (begin
              (mset! lam.74 14 fun/ascii-char10795.7)
              (set! procedure3.13 lam.74)))
          (begin
            (begin
              (begin (set! tmp.165 (alloc 32)) (set! tmp.112 (+ tmp.165 2)))
              (begin
                (mset! tmp.112 -2 L.lam.75.24)
                (mset! tmp.112 6 0)
                (set! lam.75 tmp.112)))
            (begin
              (mset! lam.75 14 |-.70|)
              (mset! lam.75 22 |+.71|)
              (set! procedure4.12 lam.75)))
          (call L.vector-ref.72.8 vector-ref.72 vector0.16 8))))))
(check-by-interp
 '(module
    (define L.lam.77.24
      (lambda (c.95)
        (begin
          (set! fun/pair11669.5 (mref c.95 14))
          (call L.fun/pair11669.5.12 fun/pair11669.5))))
    (define L.lam.76.23
      (lambda (c.94)
        (begin
          (set! fun/empty11659.13 (mref c.94 14))
          (call L.fun/empty11659.13.20 fun/empty11659.13))))
    (define L.fun/empty11664.15.22 (lambda (c.93) (begin 22)))
    (define L.fun/void11666.14.21 (lambda (c.92) (begin 30)))
    (define L.fun/empty11659.13.20
      (lambda (c.91)
        (begin
          (set! fun/empty11660.10 (mref c.91 14))
          (call L.fun/empty11660.10.17 fun/empty11660.10))))
    (define L.fun/error11661.12.19
      (lambda (c.90)
        (begin
          (set! fun/error11662.8 (mref c.90 14))
          (call L.fun/error11662.8.15 fun/error11662.8))))
    (define L.fun/pair11670.11.18
      (lambda (c.89)
        (begin
          (set! cons.75 (mref c.89 14))
          (call L.cons.75.7 cons.75 1200 3336))))
    (define L.fun/empty11660.10.17 (lambda (c.88) (begin 22)))
    (define L.fun/vector11668.9.16
      (lambda (c.87)
        (begin
          (set! make-vector.74 (mref c.87 14))
          (call L.make-vector.74.10 make-vector.74 64))))
    (define L.fun/error11662.8.15 (lambda (c.86) (begin 36414)))
    (define L.fun/empty11663.7.14
      (lambda (c.85)
        (begin
          (set! fun/empty11664.15 (mref c.85 14))
          (call L.fun/empty11664.15.22 fun/empty11664.15))))
    (define L.fun/void11665.6.13
      (lambda (c.84)
        (begin
          (set! fun/void11666.14 (mref c.84 14))
          (call L.fun/void11666.14.21 fun/void11666.14))))
    (define L.fun/pair11669.5.12
      (lambda (c.83)
        (begin
          (set! fun/pair11670.11 (mref c.83 14))
          (call L.fun/pair11670.11.18 fun/pair11670.11))))
    (define L.fun/vector11667.4.11
      (lambda (c.82)
        (begin
          (set! fun/vector11668.9 (mref c.82 14))
          (call L.fun/vector11668.9.16 fun/vector11668.9))))
    (define L.make-vector.74.10
      (lambda (c.81 tmp.50)
        (begin
          (set! make-init-vector.1 (mref c.81 14))
          (if (begin
                (if (begin (set! tmp.117 (bitwise-and tmp.50 7)) (= tmp.117 0))
                  (set! tmp.116 14)
                  (set! tmp.116 6))
                (!= tmp.116 6))
            (call L.make-init-vector.1.9 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.9
      (lambda (c.80 tmp.22)
        (begin
          (set! vector-init-loop.24 (mref c.80 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.121 (arithmetic-shift-right tmp.22 3))
                      (set! tmp.120 (+ 1 tmp.121)))
                    (set! tmp.119 (* tmp.120 8)))
                  (set! tmp.118 (alloc tmp.119)))
                (set! tmp.96 (+ tmp.118 3)))
              (begin (mset! tmp.96 -3 tmp.22) (set! tmp.23 tmp.96)))
            (call
             L.vector-init-loop.24.8
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.8
      (lambda (c.79 len.25 i.27 vec.26)
        (begin
          (set! vector-init-loop.24 (mref c.79 14))
          (if (begin
                (if (= len.25 i.27) (set! tmp.122 14) (set! tmp.122 6))
                (!= tmp.122 6))
            vec.26
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.125 (arithmetic-shift-right i.27 3))
                    (set! tmp.124 (* tmp.125 8)))
                  (set! tmp.123 (+ tmp.124 5)))
                (mset! vec.26 tmp.123 0))
              (begin
                (set! tmp.126 (+ i.27 8))
                (call
                 L.vector-init-loop.24.8
                 vector-init-loop.24
                 len.25
                 tmp.126
                 vec.26)))))))
    (define L.cons.75.7
      (lambda (c.78 tmp.69 tmp.70)
        (begin
          (begin
            (begin (set! tmp.127 (alloc 16)) (set! tmp.97 (+ tmp.127 1)))
            (begin (mset! tmp.97 -1 tmp.69) (mset! tmp.97 7 tmp.70) tmp.97)))))
    (begin
      (begin
        (begin (set! tmp.128 (alloc 16)) (set! tmp.98 (+ tmp.128 2)))
        (begin
          (mset! tmp.98 -2 L.cons.75.7)
          (mset! tmp.98 6 16)
          (set! cons.75 tmp.98)))
      (begin
        (begin (set! tmp.129 (alloc 24)) (set! tmp.99 (+ tmp.129 2)))
        (begin
          (mset! tmp.99 -2 L.vector-init-loop.24.8)
          (mset! tmp.99 6 24)
          (set! vector-init-loop.24 tmp.99)))
      (begin
        (begin (set! tmp.130 (alloc 24)) (set! tmp.100 (+ tmp.130 2)))
        (begin
          (mset! tmp.100 -2 L.make-init-vector.1.9)
          (mset! tmp.100 6 8)
          (set! make-init-vector.1 tmp.100)))
      (begin
        (begin (set! tmp.131 (alloc 24)) (set! tmp.101 (+ tmp.131 2)))
        (begin
          (mset! tmp.101 -2 L.make-vector.74.10)
          (mset! tmp.101 6 8)
          (set! make-vector.74 tmp.101)))
      (begin
        (begin (set! tmp.132 (alloc 24)) (set! tmp.102 (+ tmp.132 2)))
        (begin
          (mset! tmp.102 -2 L.fun/vector11667.4.11)
          (mset! tmp.102 6 0)
          (set! fun/vector11667.4 tmp.102)))
      (begin
        (begin (set! tmp.133 (alloc 24)) (set! tmp.103 (+ tmp.133 2)))
        (begin
          (mset! tmp.103 -2 L.fun/pair11669.5.12)
          (mset! tmp.103 6 0)
          (set! fun/pair11669.5 tmp.103)))
      (begin
        (begin (set! tmp.134 (alloc 24)) (set! tmp.104 (+ tmp.134 2)))
        (begin
          (mset! tmp.104 -2 L.fun/void11665.6.13)
          (mset! tmp.104 6 0)
          (set! fun/void11665.6 tmp.104)))
      (begin
        (begin (set! tmp.135 (alloc 24)) (set! tmp.105 (+ tmp.135 2)))
        (begin
          (mset! tmp.105 -2 L.fun/empty11663.7.14)
          (mset! tmp.105 6 0)
          (set! fun/empty11663.7 tmp.105)))
      (begin
        (begin (set! tmp.136 (alloc 16)) (set! tmp.106 (+ tmp.136 2)))
        (begin
          (mset! tmp.106 -2 L.fun/error11662.8.15)
          (mset! tmp.106 6 0)
          (set! fun/error11662.8 tmp.106)))
      (begin
        (begin (set! tmp.137 (alloc 24)) (set! tmp.107 (+ tmp.137 2)))
        (begin
          (mset! tmp.107 -2 L.fun/vector11668.9.16)
          (mset! tmp.107 6 0)
          (set! fun/vector11668.9 tmp.107)))
      (begin
        (begin (set! tmp.138 (alloc 16)) (set! tmp.108 (+ tmp.138 2)))
        (begin
          (mset! tmp.108 -2 L.fun/empty11660.10.17)
          (mset! tmp.108 6 0)
          (set! fun/empty11660.10 tmp.108)))
      (begin
        (begin (set! tmp.139 (alloc 24)) (set! tmp.109 (+ tmp.139 2)))
        (begin
          (mset! tmp.109 -2 L.fun/pair11670.11.18)
          (mset! tmp.109 6 0)
          (set! fun/pair11670.11 tmp.109)))
      (begin
        (begin (set! tmp.140 (alloc 24)) (set! tmp.110 (+ tmp.140 2)))
        (begin
          (mset! tmp.110 -2 L.fun/error11661.12.19)
          (mset! tmp.110 6 0)
          (set! fun/error11661.12 tmp.110)))
      (begin
        (begin (set! tmp.141 (alloc 24)) (set! tmp.111 (+ tmp.141 2)))
        (begin
          (mset! tmp.111 -2 L.fun/empty11659.13.20)
          (mset! tmp.111 6 0)
          (set! fun/empty11659.13 tmp.111)))
      (begin
        (begin (set! tmp.142 (alloc 16)) (set! tmp.112 (+ tmp.142 2)))
        (begin
          (mset! tmp.112 -2 L.fun/void11666.14.21)
          (mset! tmp.112 6 0)
          (set! fun/void11666.14 tmp.112)))
      (begin
        (begin (set! tmp.143 (alloc 16)) (set! tmp.113 (+ tmp.143 2)))
        (begin
          (mset! tmp.113 -2 L.fun/empty11664.15.22)
          (mset! tmp.113 6 0)
          (set! fun/empty11664.15 tmp.113)))
      (begin
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.1 14 vector-init-loop.24)
        (mset! make-vector.74 14 make-init-vector.1)
        (mset! fun/vector11667.4 14 fun/vector11668.9)
        (mset! fun/pair11669.5 14 fun/pair11670.11)
        (mset! fun/void11665.6 14 fun/void11666.14)
        (mset! fun/empty11663.7 14 fun/empty11664.15)
        (mset! fun/vector11668.9 14 make-vector.74)
        (mset! fun/pair11670.11 14 cons.75)
        (mset! fun/error11661.12 14 fun/error11662.8)
        (mset! fun/empty11659.13 14 fun/empty11660.10)
        (begin
          (begin
            (begin
              (begin (set! tmp.144 (alloc 24)) (set! tmp.114 (+ tmp.144 2)))
              (begin
                (mset! tmp.114 -2 L.lam.76.23)
                (mset! tmp.114 6 0)
                (set! lam.76 tmp.114)))
            (begin
              (mset! lam.76 14 fun/empty11659.13)
              (set! procedure0.21 lam.76)))
          (set! error1.20 (call L.fun/error11661.12.19 fun/error11661.12))
          (set! empty2.19 (call L.fun/empty11663.7.14 fun/empty11663.7))
          (set! void3.18 (call L.fun/void11665.6.13 fun/void11665.6))
          (set! vector4.17 (call L.fun/vector11667.4.11 fun/vector11667.4))
          (begin
            (begin
              (begin (set! tmp.145 (alloc 24)) (set! tmp.115 (+ tmp.145 2)))
              (begin
                (mset! tmp.115 -2 L.lam.77.24)
                (mset! tmp.115 6 0)
                (set! lam.77 tmp.115)))
            (begin
              (mset! lam.77 14 fun/pair11669.5)
              (set! procedure5.16 lam.77)))
          (if (begin
                (if (begin
                      (set! tmp.147 (bitwise-and procedure0.21 7))
                      (= tmp.147 2))
                  (set! tmp.146 14)
                  (set! tmp.146 6))
                (!= tmp.146 6))
            (if (begin
                  (if (begin
                        (set! tmp.149 (mref procedure0.21 6))
                        (= tmp.149 0))
                    (set! tmp.148 14)
                    (set! tmp.148 6))
                  (!= tmp.148 6))
              (begin
                (set! tmp.150 (mref procedure0.21 -2))
                (call tmp.150 procedure0.21))
              10814)
            11070))))))
(check-by-interp
 '(module
    (define L.fun/error12035.15.21 (lambda (c.91) (begin 9790)))
    (define L.fun/ascii-char12031.14.20 (lambda (c.90) (begin 23854)))
    (define L.fun/error12029.13.19 (lambda (c.89) (begin 62526)))
    (define L.fun/empty12027.12.18 (lambda (c.88) (begin 22)))
    (define L.fun/ascii-char12032.11.17
      (lambda (c.87)
        (begin
          (set! fun/ascii-char12033.10 (mref c.87 14))
          (call L.fun/ascii-char12033.10.16 fun/ascii-char12033.10))))
    (define L.fun/ascii-char12033.10.16 (lambda (c.86) (begin 27438)))
    (define L.fun/error12025.9.15 (lambda (c.85) (begin 48702)))
    (define L.fun/error12028.8.14
      (lambda (c.84)
        (begin
          (set! fun/error12029.13 (mref c.84 14))
          (call L.fun/error12029.13.19 fun/error12029.13))))
    (define L.fun/error12034.7.13
      (lambda (c.83)
        (begin
          (set! fun/error12035.15 (mref c.83 14))
          (call L.fun/error12035.15.21 fun/error12035.15))))
    (define L.fun/ascii-char12030.6.12
      (lambda (c.82)
        (begin
          (set! fun/ascii-char12031.14 (mref c.82 14))
          (call L.fun/ascii-char12031.14.20 fun/ascii-char12031.14))))
    (define L.fun/error12024.5.11
      (lambda (c.81)
        (begin
          (set! fun/error12025.9 (mref c.81 14))
          (call L.fun/error12025.9.15 fun/error12025.9))))
    (define L.fun/empty12026.4.10
      (lambda (c.80)
        (begin
          (set! fun/empty12027.12 (mref c.80 14))
          (call L.fun/empty12027.12.18 fun/empty12027.12))))
    (define L.-.74.9
      (lambda (c.79 tmp.40 tmp.41)
        (begin
          (if (begin
                (if (begin (set! tmp.108 (bitwise-and tmp.41 7)) (= tmp.108 0))
                  (set! tmp.107 14)
                  (set! tmp.107 6))
                (!= tmp.107 6))
            (if (begin
                  (if (begin
                        (set! tmp.110 (bitwise-and tmp.40 7))
                        (= tmp.110 0))
                    (set! tmp.109 14)
                    (set! tmp.109 6))
                  (!= tmp.109 6))
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.*.75.8
      (lambda (c.78 tmp.36 tmp.37)
        (begin
          (if (begin
                (if (begin (set! tmp.112 (bitwise-and tmp.37 7)) (= tmp.112 0))
                  (set! tmp.111 14)
                  (set! tmp.111 6))
                (!= tmp.111 6))
            (if (begin
                  (if (begin
                        (set! tmp.114 (bitwise-and tmp.36 7))
                        (= tmp.114 0))
                    (set! tmp.113 14)
                    (set! tmp.113 6))
                  (!= tmp.113 6))
              (begin
                (set! tmp.115 (arithmetic-shift-right tmp.37 3))
                (* tmp.36 tmp.115))
              318)
            318))))
    (define L.+.76.7
      (lambda (c.77 tmp.38 tmp.39)
        (begin
          (if (begin
                (if (begin (set! tmp.117 (bitwise-and tmp.39 7)) (= tmp.117 0))
                  (set! tmp.116 14)
                  (set! tmp.116 6))
                (!= tmp.116 6))
            (if (begin
                  (if (begin
                        (set! tmp.119 (bitwise-and tmp.38 7))
                        (= tmp.119 0))
                    (set! tmp.118 14)
                    (set! tmp.118 6))
                  (!= tmp.118 6))
              (+ tmp.38 tmp.39)
              574)
            574))))
    (begin
      (begin
        (begin (set! tmp.120 (alloc 16)) (set! tmp.92 (+ tmp.120 2)))
        (begin
          (mset! tmp.92 -2 L.+.76.7)
          (mset! tmp.92 6 16)
          (set! |+.76| tmp.92)))
      (begin
        (begin (set! tmp.121 (alloc 16)) (set! tmp.93 (+ tmp.121 2)))
        (begin
          (mset! tmp.93 -2 L.*.75.8)
          (mset! tmp.93 6 16)
          (set! *.75 tmp.93)))
      (begin
        (begin (set! tmp.122 (alloc 16)) (set! tmp.94 (+ tmp.122 2)))
        (begin
          (mset! tmp.94 -2 L.-.74.9)
          (mset! tmp.94 6 16)
          (set! |-.74| tmp.94)))
      (begin
        (begin (set! tmp.123 (alloc 24)) (set! tmp.95 (+ tmp.123 2)))
        (begin
          (mset! tmp.95 -2 L.fun/empty12026.4.10)
          (mset! tmp.95 6 0)
          (set! fun/empty12026.4 tmp.95)))
      (begin
        (begin (set! tmp.124 (alloc 24)) (set! tmp.96 (+ tmp.124 2)))
        (begin
          (mset! tmp.96 -2 L.fun/error12024.5.11)
          (mset! tmp.96 6 0)
          (set! fun/error12024.5 tmp.96)))
      (begin
        (begin (set! tmp.125 (alloc 24)) (set! tmp.97 (+ tmp.125 2)))
        (begin
          (mset! tmp.97 -2 L.fun/ascii-char12030.6.12)
          (mset! tmp.97 6 0)
          (set! fun/ascii-char12030.6 tmp.97)))
      (begin
        (begin (set! tmp.126 (alloc 24)) (set! tmp.98 (+ tmp.126 2)))
        (begin
          (mset! tmp.98 -2 L.fun/error12034.7.13)
          (mset! tmp.98 6 0)
          (set! fun/error12034.7 tmp.98)))
      (begin
        (begin (set! tmp.127 (alloc 24)) (set! tmp.99 (+ tmp.127 2)))
        (begin
          (mset! tmp.99 -2 L.fun/error12028.8.14)
          (mset! tmp.99 6 0)
          (set! fun/error12028.8 tmp.99)))
      (begin
        (begin (set! tmp.128 (alloc 16)) (set! tmp.100 (+ tmp.128 2)))
        (begin
          (mset! tmp.100 -2 L.fun/error12025.9.15)
          (mset! tmp.100 6 0)
          (set! fun/error12025.9 tmp.100)))
      (begin
        (begin (set! tmp.129 (alloc 16)) (set! tmp.101 (+ tmp.129 2)))
        (begin
          (mset! tmp.101 -2 L.fun/ascii-char12033.10.16)
          (mset! tmp.101 6 0)
          (set! fun/ascii-char12033.10 tmp.101)))
      (begin
        (begin (set! tmp.130 (alloc 24)) (set! tmp.102 (+ tmp.130 2)))
        (begin
          (mset! tmp.102 -2 L.fun/ascii-char12032.11.17)
          (mset! tmp.102 6 0)
          (set! fun/ascii-char12032.11 tmp.102)))
      (begin
        (begin (set! tmp.131 (alloc 16)) (set! tmp.103 (+ tmp.131 2)))
        (begin
          (mset! tmp.103 -2 L.fun/empty12027.12.18)
          (mset! tmp.103 6 0)
          (set! fun/empty12027.12 tmp.103)))
      (begin
        (begin (set! tmp.132 (alloc 16)) (set! tmp.104 (+ tmp.132 2)))
        (begin
          (mset! tmp.104 -2 L.fun/error12029.13.19)
          (mset! tmp.104 6 0)
          (set! fun/error12029.13 tmp.104)))
      (begin
        (begin (set! tmp.133 (alloc 16)) (set! tmp.105 (+ tmp.133 2)))
        (begin
          (mset! tmp.105 -2 L.fun/ascii-char12031.14.20)
          (mset! tmp.105 6 0)
          (set! fun/ascii-char12031.14 tmp.105)))
      (begin
        (begin (set! tmp.134 (alloc 16)) (set! tmp.106 (+ tmp.134 2)))
        (begin
          (mset! tmp.106 -2 L.fun/error12035.15.21)
          (mset! tmp.106 6 0)
          (set! fun/error12035.15 tmp.106)))
      (begin
        (mset! fun/empty12026.4 14 fun/empty12027.12)
        (mset! fun/error12024.5 14 fun/error12025.9)
        (mset! fun/ascii-char12030.6 14 fun/ascii-char12031.14)
        (mset! fun/error12034.7 14 fun/error12035.15)
        (mset! fun/error12028.8 14 fun/error12029.13)
        (mset! fun/ascii-char12032.11 14 fun/ascii-char12033.10)
        (begin
          (begin
            (begin
              (begin
                (set! tmp.137 (call L.-.74.9 |-.74| 160 1984))
                (begin
                  (set! tmp.138 (call L.*.75.8 *.75 1648 1936))
                  (set! tmp.136 (call L.+.76.7 |+.76| tmp.137 tmp.138))))
              (begin
                (begin
                  (set! tmp.140 (call L.+.76.7 |+.76| 1320 1992))
                  (begin
                    (set! tmp.141 (call L.*.75.8 *.75 1960 792))
                    (set! tmp.139 (call L.-.74.9 |-.74| tmp.140 tmp.141))))
                (set! tmp.135 (call L.-.74.9 |-.74| tmp.136 tmp.139))))
            (begin
              (begin
                (begin
                  (set! tmp.144 (call L.*.75.8 *.75 1600 272))
                  (begin
                    (set! tmp.145 (call L.+.76.7 |+.76| 344 1656))
                    (set! tmp.143 (call L.-.74.9 |-.74| tmp.144 tmp.145))))
                (begin
                  (begin
                    (set! tmp.147 (call L.-.74.9 |-.74| 1632 744))
                    (begin
                      (set! tmp.148 (call L.*.75.8 *.75 440 728))
                      (set! tmp.146 (call L.*.75.8 *.75 tmp.147 tmp.148))))
                  (set! tmp.142 (call L.*.75.8 *.75 tmp.143 tmp.146))))
              (set! fixnum0.21 (call L.+.76.7 |+.76| tmp.135 tmp.142))))
          (set! error1.20 (call L.fun/error12024.5.11 fun/error12024.5))
          (set! empty2.19 (call L.fun/empty12026.4.10 fun/empty12026.4))
          (set! error3.18 (call L.fun/error12028.8.14 fun/error12028.8))
          (set! ascii-char4.17
            (call L.fun/ascii-char12030.6.12 fun/ascii-char12030.6))
          (set! ascii-char5.16
            (call L.fun/ascii-char12032.11.17 fun/ascii-char12032.11))
          (call L.fun/error12034.7.13 fun/error12034.7))))))
(check-by-interp
 '(module
    (define L.lam.75.20
      (lambda (c.89)
        (begin
          (set! fun/pair13985.9 (mref c.89 14))
          (call L.fun/pair13985.9.13 fun/pair13985.9))))
    (define L.fun/void13989.15.19
      (lambda (c.88)
        (begin
          (set! fun/void13990.8 (mref c.88 14))
          (call L.fun/void13990.8.12 fun/void13990.8))))
    (define L.fun/void13995.14.18
      (lambda (c.87)
        (begin
          (set! fun/void13996.7 (mref c.87 14))
          (call L.fun/void13996.7.11 fun/void13996.7))))
    (define L.fun/error13991.13.17
      (lambda (c.86)
        (begin
          (set! fun/error13992.4 (mref c.86 14))
          (call L.fun/error13992.4.8 fun/error13992.4))))
    (define L.fun/pair13986.12.16
      (lambda (c.85)
        (begin
          (set! cons.74 (mref c.85 14))
          (call L.cons.74.7 cons.74 896 3416))))
    (define L.fun/ascii-char13988.11.15 (lambda (c.84) (begin 27182)))
    (define L.fun/void13993.10.14
      (lambda (c.83)
        (begin
          (set! fun/void13994.6 (mref c.83 14))
          (call L.fun/void13994.6.10 fun/void13994.6))))
    (define L.fun/pair13985.9.13
      (lambda (c.82)
        (begin
          (set! fun/pair13986.12 (mref c.82 14))
          (call L.fun/pair13986.12.16 fun/pair13986.12))))
    (define L.fun/void13990.8.12 (lambda (c.81) (begin 30)))
    (define L.fun/void13996.7.11 (lambda (c.80) (begin 30)))
    (define L.fun/void13994.6.10 (lambda (c.79) (begin 30)))
    (define L.fun/ascii-char13987.5.9
      (lambda (c.78)
        (begin
          (set! fun/ascii-char13988.11 (mref c.78 14))
          (call L.fun/ascii-char13988.11.15 fun/ascii-char13988.11))))
    (define L.fun/error13992.4.8 (lambda (c.77) (begin 7486)))
    (define L.cons.74.7
      (lambda (c.76 tmp.69 tmp.70)
        (begin
          (begin
            (begin (set! tmp.105 (alloc 16)) (set! tmp.90 (+ tmp.105 1)))
            (begin (mset! tmp.90 -1 tmp.69) (mset! tmp.90 7 tmp.70) tmp.90)))))
    (begin
      (begin
        (begin (set! tmp.106 (alloc 16)) (set! tmp.91 (+ tmp.106 2)))
        (begin
          (mset! tmp.91 -2 L.cons.74.7)
          (mset! tmp.91 6 16)
          (set! cons.74 tmp.91)))
      (begin
        (begin (set! tmp.107 (alloc 16)) (set! tmp.92 (+ tmp.107 2)))
        (begin
          (mset! tmp.92 -2 L.fun/error13992.4.8)
          (mset! tmp.92 6 0)
          (set! fun/error13992.4 tmp.92)))
      (begin
        (begin (set! tmp.108 (alloc 24)) (set! tmp.93 (+ tmp.108 2)))
        (begin
          (mset! tmp.93 -2 L.fun/ascii-char13987.5.9)
          (mset! tmp.93 6 0)
          (set! fun/ascii-char13987.5 tmp.93)))
      (begin
        (begin (set! tmp.109 (alloc 16)) (set! tmp.94 (+ tmp.109 2)))
        (begin
          (mset! tmp.94 -2 L.fun/void13994.6.10)
          (mset! tmp.94 6 0)
          (set! fun/void13994.6 tmp.94)))
      (begin
        (begin (set! tmp.110 (alloc 16)) (set! tmp.95 (+ tmp.110 2)))
        (begin
          (mset! tmp.95 -2 L.fun/void13996.7.11)
          (mset! tmp.95 6 0)
          (set! fun/void13996.7 tmp.95)))
      (begin
        (begin (set! tmp.111 (alloc 16)) (set! tmp.96 (+ tmp.111 2)))
        (begin
          (mset! tmp.96 -2 L.fun/void13990.8.12)
          (mset! tmp.96 6 0)
          (set! fun/void13990.8 tmp.96)))
      (begin
        (begin (set! tmp.112 (alloc 24)) (set! tmp.97 (+ tmp.112 2)))
        (begin
          (mset! tmp.97 -2 L.fun/pair13985.9.13)
          (mset! tmp.97 6 0)
          (set! fun/pair13985.9 tmp.97)))
      (begin
        (begin (set! tmp.113 (alloc 24)) (set! tmp.98 (+ tmp.113 2)))
        (begin
          (mset! tmp.98 -2 L.fun/void13993.10.14)
          (mset! tmp.98 6 0)
          (set! fun/void13993.10 tmp.98)))
      (begin
        (begin (set! tmp.114 (alloc 16)) (set! tmp.99 (+ tmp.114 2)))
        (begin
          (mset! tmp.99 -2 L.fun/ascii-char13988.11.15)
          (mset! tmp.99 6 0)
          (set! fun/ascii-char13988.11 tmp.99)))
      (begin
        (begin (set! tmp.115 (alloc 24)) (set! tmp.100 (+ tmp.115 2)))
        (begin
          (mset! tmp.100 -2 L.fun/pair13986.12.16)
          (mset! tmp.100 6 0)
          (set! fun/pair13986.12 tmp.100)))
      (begin
        (begin (set! tmp.116 (alloc 24)) (set! tmp.101 (+ tmp.116 2)))
        (begin
          (mset! tmp.101 -2 L.fun/error13991.13.17)
          (mset! tmp.101 6 0)
          (set! fun/error13991.13 tmp.101)))
      (begin
        (begin (set! tmp.117 (alloc 24)) (set! tmp.102 (+ tmp.117 2)))
        (begin
          (mset! tmp.102 -2 L.fun/void13995.14.18)
          (mset! tmp.102 6 0)
          (set! fun/void13995.14 tmp.102)))
      (begin
        (begin (set! tmp.118 (alloc 24)) (set! tmp.103 (+ tmp.118 2)))
        (begin
          (mset! tmp.103 -2 L.fun/void13989.15.19)
          (mset! tmp.103 6 0)
          (set! fun/void13989.15 tmp.103)))
      (begin
        (mset! fun/ascii-char13987.5 14 fun/ascii-char13988.11)
        (mset! fun/pair13985.9 14 fun/pair13986.12)
        (mset! fun/void13993.10 14 fun/void13994.6)
        (mset! fun/pair13986.12 14 cons.74)
        (mset! fun/error13991.13 14 fun/error13992.4)
        (mset! fun/void13995.14 14 fun/void13996.7)
        (mset! fun/void13989.15 14 fun/void13990.8)
        (begin
          (begin
            (begin
              (begin (set! tmp.119 (alloc 24)) (set! tmp.104 (+ tmp.119 2)))
              (begin
                (mset! tmp.104 -2 L.lam.75.20)
                (mset! tmp.104 6 0)
                (set! lam.75 tmp.104)))
            (begin
              (mset! lam.75 14 fun/pair13985.9)
              (set! procedure0.21 lam.75)))
          (set! ascii-char1.20
            (call L.fun/ascii-char13987.5.9 fun/ascii-char13987.5))
          (set! void2.19 (call L.fun/void13989.15.19 fun/void13989.15))
          (set! error3.18 (call L.fun/error13991.13.17 fun/error13991.13))
          (set! void4.17 (call L.fun/void13993.10.14 fun/void13993.10))
          (set! void5.16 (call L.fun/void13995.14.18 fun/void13995.14))
          (if (begin
                (if (begin
                      (set! tmp.121 (bitwise-and procedure0.21 7))
                      (= tmp.121 2))
                  (set! tmp.120 14)
                  (set! tmp.120 6))
                (!= tmp.120 6))
            (if (begin
                  (if (begin
                        (set! tmp.123 (mref procedure0.21 6))
                        (= tmp.123 0))
                    (set! tmp.122 14)
                    (set! tmp.122 6))
                  (!= tmp.122 6))
              (begin
                (set! tmp.124 (mref procedure0.21 -2))
                (call tmp.124 procedure0.21))
              10814)
            11070))))))
(check-by-interp
 '(module
    (define L.lam.80.27
      (lambda (c.101)
        (begin
          (set! fun/any14746.10 (mref c.101 14))
          (set! ascii-char?.79 (mref c.101 22))
          (begin
            (set! tmp.124 (call L.fun/any14746.10.21 fun/any14746.10))
            (call L.ascii-char?.79.7 ascii-char?.79 tmp.124)))))
    (define L.fun/vector14739.15.26
      (lambda (c.100)
        (begin
          (set! make-vector.74 (mref c.100 14))
          (call L.make-vector.74.14 make-vector.74 64))))
    (define L.fun/ascii-char14749.14.25 (lambda (c.99) (begin 31278)))
    (define L.fun/ascii-char14743.13.24 (lambda (c.98) (begin 26158)))
    (define L.fun/any14741.12.23
      (lambda (c.97)
        (begin
          (set! make-vector.74 (mref c.97 14))
          (call L.make-vector.74.14 make-vector.74 64))))
    (define L.fun/any14747.11.22 (lambda (c.96) (begin 22)))
    (define L.fun/any14746.10.21
      (lambda (c.95)
        (begin
          (set! fun/any14747.11 (mref c.95 14))
          (call L.fun/any14747.11.22 fun/any14747.11))))
    (define L.fun/ascii-char14742.9.20
      (lambda (c.94)
        (begin
          (set! fun/ascii-char14743.13 (mref c.94 14))
          (call L.fun/ascii-char14743.13.24 fun/ascii-char14743.13))))
    (define L.fun/ascii-char14748.8.19
      (lambda (c.93)
        (begin
          (set! fun/ascii-char14749.14 (mref c.93 14))
          (call L.fun/ascii-char14749.14.25 fun/ascii-char14749.14))))
    (define L.fun/any14740.7.18
      (lambda (c.92)
        (begin
          (set! fun/any14741.12 (mref c.92 14))
          (call L.fun/any14741.12.23 fun/any14741.12))))
    (define L.fun/vector14744.6.17
      (lambda (c.91)
        (begin
          (set! fun/vector14745.5 (mref c.91 14))
          (call L.fun/vector14745.5.16 fun/vector14745.5))))
    (define L.fun/vector14745.5.16
      (lambda (c.90)
        (begin
          (set! make-vector.74 (mref c.90 14))
          (call L.make-vector.74.14 make-vector.74 64))))
    (define L.fun/vector14738.4.15
      (lambda (c.89)
        (begin
          (set! fun/vector14739.15 (mref c.89 14))
          (call L.fun/vector14739.15.26 fun/vector14739.15))))
    (define L.make-vector.74.14
      (lambda (c.88 tmp.50)
        (begin
          (set! make-init-vector.1 (mref c.88 14))
          (if (begin
                (if (begin (set! tmp.126 (bitwise-and tmp.50 7)) (= tmp.126 0))
                  (set! tmp.125 14)
                  (set! tmp.125 6))
                (!= tmp.125 6))
            (call L.make-init-vector.1.13 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.13
      (lambda (c.87 tmp.22)
        (begin
          (set! vector-init-loop.24 (mref c.87 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.130 (arithmetic-shift-right tmp.22 3))
                      (set! tmp.129 (+ 1 tmp.130)))
                    (set! tmp.128 (* tmp.129 8)))
                  (set! tmp.127 (alloc tmp.128)))
                (set! tmp.102 (+ tmp.127 3)))
              (begin (mset! tmp.102 -3 tmp.22) (set! tmp.23 tmp.102)))
            (call
             L.vector-init-loop.24.12
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.12
      (lambda (c.86 len.25 i.27 vec.26)
        (begin
          (set! vector-init-loop.24 (mref c.86 14))
          (if (begin
                (if (= len.25 i.27) (set! tmp.131 14) (set! tmp.131 6))
                (!= tmp.131 6))
            vec.26
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.134 (arithmetic-shift-right i.27 3))
                    (set! tmp.133 (* tmp.134 8)))
                  (set! tmp.132 (+ tmp.133 5)))
                (mset! vec.26 tmp.132 0))
              (begin
                (set! tmp.135 (+ i.27 8))
                (call
                 L.vector-init-loop.24.12
                 vector-init-loop.24
                 len.25
                 tmp.135
                 vec.26)))))))
    (define L.-.75.11
      (lambda (c.85 tmp.40 tmp.41)
        (begin
          (if (begin
                (if (begin (set! tmp.137 (bitwise-and tmp.41 7)) (= tmp.137 0))
                  (set! tmp.136 14)
                  (set! tmp.136 6))
                (!= tmp.136 6))
            (if (begin
                  (if (begin
                        (set! tmp.139 (bitwise-and tmp.40 7))
                        (= tmp.139 0))
                    (set! tmp.138 14)
                    (set! tmp.138 6))
                  (!= tmp.138 6))
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.*.76.10
      (lambda (c.84 tmp.36 tmp.37)
        (begin
          (if (begin
                (if (begin (set! tmp.141 (bitwise-and tmp.37 7)) (= tmp.141 0))
                  (set! tmp.140 14)
                  (set! tmp.140 6))
                (!= tmp.140 6))
            (if (begin
                  (if (begin
                        (set! tmp.143 (bitwise-and tmp.36 7))
                        (= tmp.143 0))
                    (set! tmp.142 14)
                    (set! tmp.142 6))
                  (!= tmp.142 6))
              (begin
                (set! tmp.144 (arithmetic-shift-right tmp.37 3))
                (* tmp.36 tmp.144))
              318)
            318))))
    (define L.+.77.9
      (lambda (c.83 tmp.38 tmp.39)
        (begin
          (if (begin
                (if (begin (set! tmp.146 (bitwise-and tmp.39 7)) (= tmp.146 0))
                  (set! tmp.145 14)
                  (set! tmp.145 6))
                (!= tmp.145 6))
            (if (begin
                  (if (begin
                        (set! tmp.148 (bitwise-and tmp.38 7))
                        (= tmp.148 0))
                    (set! tmp.147 14)
                    (set! tmp.147 6))
                  (!= tmp.147 6))
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.fixnum?.78.8
      (lambda (c.82 tmp.59)
        (begin
          (if (begin (set! tmp.149 (bitwise-and tmp.59 7)) (= tmp.149 0))
            14
            6))))
    (define L.ascii-char?.79.7
      (lambda (c.81 tmp.63)
        (begin
          (if (begin (set! tmp.150 (bitwise-and tmp.63 255)) (= tmp.150 46))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.151 (alloc 16)) (set! tmp.103 (+ tmp.151 2)))
        (begin
          (mset! tmp.103 -2 L.ascii-char?.79.7)
          (mset! tmp.103 6 8)
          (set! ascii-char?.79 tmp.103)))
      (begin
        (begin (set! tmp.152 (alloc 16)) (set! tmp.104 (+ tmp.152 2)))
        (begin
          (mset! tmp.104 -2 L.fixnum?.78.8)
          (mset! tmp.104 6 8)
          (set! fixnum?.78 tmp.104)))
      (begin
        (begin (set! tmp.153 (alloc 16)) (set! tmp.105 (+ tmp.153 2)))
        (begin
          (mset! tmp.105 -2 L.+.77.9)
          (mset! tmp.105 6 16)
          (set! |+.77| tmp.105)))
      (begin
        (begin (set! tmp.154 (alloc 16)) (set! tmp.106 (+ tmp.154 2)))
        (begin
          (mset! tmp.106 -2 L.*.76.10)
          (mset! tmp.106 6 16)
          (set! *.76 tmp.106)))
      (begin
        (begin (set! tmp.155 (alloc 16)) (set! tmp.107 (+ tmp.155 2)))
        (begin
          (mset! tmp.107 -2 L.-.75.11)
          (mset! tmp.107 6 16)
          (set! |-.75| tmp.107)))
      (begin
        (begin (set! tmp.156 (alloc 24)) (set! tmp.108 (+ tmp.156 2)))
        (begin
          (mset! tmp.108 -2 L.vector-init-loop.24.12)
          (mset! tmp.108 6 24)
          (set! vector-init-loop.24 tmp.108)))
      (begin
        (begin (set! tmp.157 (alloc 24)) (set! tmp.109 (+ tmp.157 2)))
        (begin
          (mset! tmp.109 -2 L.make-init-vector.1.13)
          (mset! tmp.109 6 8)
          (set! make-init-vector.1 tmp.109)))
      (begin
        (begin (set! tmp.158 (alloc 24)) (set! tmp.110 (+ tmp.158 2)))
        (begin
          (mset! tmp.110 -2 L.make-vector.74.14)
          (mset! tmp.110 6 8)
          (set! make-vector.74 tmp.110)))
      (begin
        (begin (set! tmp.159 (alloc 24)) (set! tmp.111 (+ tmp.159 2)))
        (begin
          (mset! tmp.111 -2 L.fun/vector14738.4.15)
          (mset! tmp.111 6 0)
          (set! fun/vector14738.4 tmp.111)))
      (begin
        (begin (set! tmp.160 (alloc 24)) (set! tmp.112 (+ tmp.160 2)))
        (begin
          (mset! tmp.112 -2 L.fun/vector14745.5.16)
          (mset! tmp.112 6 0)
          (set! fun/vector14745.5 tmp.112)))
      (begin
        (begin (set! tmp.161 (alloc 24)) (set! tmp.113 (+ tmp.161 2)))
        (begin
          (mset! tmp.113 -2 L.fun/vector14744.6.17)
          (mset! tmp.113 6 0)
          (set! fun/vector14744.6 tmp.113)))
      (begin
        (begin (set! tmp.162 (alloc 24)) (set! tmp.114 (+ tmp.162 2)))
        (begin
          (mset! tmp.114 -2 L.fun/any14740.7.18)
          (mset! tmp.114 6 0)
          (set! fun/any14740.7 tmp.114)))
      (begin
        (begin (set! tmp.163 (alloc 24)) (set! tmp.115 (+ tmp.163 2)))
        (begin
          (mset! tmp.115 -2 L.fun/ascii-char14748.8.19)
          (mset! tmp.115 6 0)
          (set! fun/ascii-char14748.8 tmp.115)))
      (begin
        (begin (set! tmp.164 (alloc 24)) (set! tmp.116 (+ tmp.164 2)))
        (begin
          (mset! tmp.116 -2 L.fun/ascii-char14742.9.20)
          (mset! tmp.116 6 0)
          (set! fun/ascii-char14742.9 tmp.116)))
      (begin
        (begin (set! tmp.165 (alloc 24)) (set! tmp.117 (+ tmp.165 2)))
        (begin
          (mset! tmp.117 -2 L.fun/any14746.10.21)
          (mset! tmp.117 6 0)
          (set! fun/any14746.10 tmp.117)))
      (begin
        (begin (set! tmp.166 (alloc 16)) (set! tmp.118 (+ tmp.166 2)))
        (begin
          (mset! tmp.118 -2 L.fun/any14747.11.22)
          (mset! tmp.118 6 0)
          (set! fun/any14747.11 tmp.118)))
      (begin
        (begin (set! tmp.167 (alloc 24)) (set! tmp.119 (+ tmp.167 2)))
        (begin
          (mset! tmp.119 -2 L.fun/any14741.12.23)
          (mset! tmp.119 6 0)
          (set! fun/any14741.12 tmp.119)))
      (begin
        (begin (set! tmp.168 (alloc 16)) (set! tmp.120 (+ tmp.168 2)))
        (begin
          (mset! tmp.120 -2 L.fun/ascii-char14743.13.24)
          (mset! tmp.120 6 0)
          (set! fun/ascii-char14743.13 tmp.120)))
      (begin
        (begin (set! tmp.169 (alloc 16)) (set! tmp.121 (+ tmp.169 2)))
        (begin
          (mset! tmp.121 -2 L.fun/ascii-char14749.14.25)
          (mset! tmp.121 6 0)
          (set! fun/ascii-char14749.14 tmp.121)))
      (begin
        (begin (set! tmp.170 (alloc 24)) (set! tmp.122 (+ tmp.170 2)))
        (begin
          (mset! tmp.122 -2 L.fun/vector14739.15.26)
          (mset! tmp.122 6 0)
          (set! fun/vector14739.15 tmp.122)))
      (begin
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.1 14 vector-init-loop.24)
        (mset! make-vector.74 14 make-init-vector.1)
        (mset! fun/vector14738.4 14 fun/vector14739.15)
        (mset! fun/vector14745.5 14 make-vector.74)
        (mset! fun/vector14744.6 14 fun/vector14745.5)
        (mset! fun/any14740.7 14 fun/any14741.12)
        (mset! fun/ascii-char14748.8 14 fun/ascii-char14749.14)
        (mset! fun/ascii-char14742.9 14 fun/ascii-char14743.13)
        (mset! fun/any14746.10 14 fun/any14747.11)
        (mset! fun/any14741.12 14 make-vector.74)
        (mset! fun/vector14739.15 14 make-vector.74)
        (begin
          (set! vector0.21 (call L.fun/vector14738.4.15 fun/vector14738.4))
          (begin
            (begin
              (begin
                (set! tmp.173 (call L.-.75.11 |-.75| 360 1976))
                (begin
                  (set! tmp.174 (call L.-.75.11 |-.75| 952 1912))
                  (set! tmp.172 (call L.*.76.10 *.76 tmp.173 tmp.174))))
              (begin
                (begin
                  (set! tmp.176 (call L.-.75.11 |-.75| 800 360))
                  (begin
                    (set! tmp.177 (call L.*.76.10 *.76 2008 840))
                    (set! tmp.175 (call L.+.77.9 |+.77| tmp.176 tmp.177))))
                (set! tmp.171 (call L.*.76.10 *.76 tmp.172 tmp.175))))
            (begin
              (begin
                (begin
                  (set! tmp.180 (call L.*.76.10 *.76 912 1904))
                  (begin
                    (set! tmp.181 (call L.*.76.10 *.76 1840 704))
                    (set! tmp.179 (call L.-.75.11 |-.75| tmp.180 tmp.181))))
                (begin
                  (begin
                    (set! tmp.183 (call L.+.77.9 |+.77| 2000 1728))
                    (begin
                      (set! tmp.184 (call L.+.77.9 |+.77| 712 608))
                      (set! tmp.182 (call L.-.75.11 |-.75| tmp.183 tmp.184))))
                  (set! tmp.178 (call L.*.76.10 *.76 tmp.179 tmp.182))))
              (set! fixnum1.20 (call L.+.77.9 |+.77| tmp.171 tmp.178))))
          (begin
            (set! tmp.185 (call L.fun/any14740.7.18 fun/any14740.7))
            (set! boolean2.19 (call L.fixnum?.78.8 fixnum?.78 tmp.185)))
          (set! ascii-char3.18
            (call L.fun/ascii-char14742.9.20 fun/ascii-char14742.9))
          (set! vector4.17 (call L.fun/vector14744.6.17 fun/vector14744.6))
          (begin
            (begin
              (begin (set! tmp.186 (alloc 32)) (set! tmp.123 (+ tmp.186 2)))
              (begin
                (mset! tmp.123 -2 L.lam.80.27)
                (mset! tmp.123 6 0)
                (set! lam.80 tmp.123)))
            (begin
              (mset! lam.80 14 fun/any14746.10)
              (mset! lam.80 22 ascii-char?.79)
              (set! procedure5.16 lam.80)))
          (call L.fun/ascii-char14748.8.19 fun/ascii-char14748.8))))))
(check-by-interp
 '(module
    (define L.fun/any14774.13.23
      (lambda (c.93)
        (begin
          (set! fun/any14775.7 (mref c.93 14))
          (call L.fun/any14775.7.17 fun/any14775.7))))
    (define L.fun/vector14776.12.22
      (lambda (c.92)
        (begin
          (set! fun/vector14777.9 (mref c.92 14))
          (call L.fun/vector14777.9.19 fun/vector14777.9))))
    (define L.fun/ascii-char14781.11.21 (lambda (c.91) (begin 23086)))
    (define L.fun/empty14778.10.20
      (lambda (c.90)
        (begin
          (set! fun/empty14779.6 (mref c.90 14))
          (call L.fun/empty14779.6.16 fun/empty14779.6))))
    (define L.fun/vector14777.9.19
      (lambda (c.89)
        (begin
          (set! make-vector.72 (mref c.89 14))
          (call L.make-vector.72.13 make-vector.72 64))))
    (define L.fun/vector14773.8.18
      (lambda (c.88)
        (begin
          (set! make-vector.72 (mref c.88 14))
          (call L.make-vector.72.13 make-vector.72 64))))
    (define L.fun/any14775.7.17 (lambda (c.87) (begin 1176)))
    (define L.fun/empty14779.6.16 (lambda (c.86) (begin 22)))
    (define L.fun/vector14772.5.15
      (lambda (c.85)
        (begin
          (set! fun/vector14773.8 (mref c.85 14))
          (call L.fun/vector14773.8.18 fun/vector14773.8))))
    (define L.fun/ascii-char14780.4.14
      (lambda (c.84)
        (begin
          (set! fun/ascii-char14781.11 (mref c.84 14))
          (call L.fun/ascii-char14781.11.21 fun/ascii-char14781.11))))
    (define L.make-vector.72.13
      (lambda (c.83 tmp.48)
        (begin
          (set! make-init-vector.1 (mref c.83 14))
          (if (begin
                (if (begin (set! tmp.113 (bitwise-and tmp.48 7)) (= tmp.113 0))
                  (set! tmp.112 14)
                  (set! tmp.112 6))
                (!= tmp.112 6))
            (call L.make-init-vector.1.12 make-init-vector.1 tmp.48)
            2110))))
    (define L.make-init-vector.1.12
      (lambda (c.82 tmp.20)
        (begin
          (set! vector-init-loop.22 (mref c.82 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.117 (arithmetic-shift-right tmp.20 3))
                      (set! tmp.116 (+ 1 tmp.117)))
                    (set! tmp.115 (* tmp.116 8)))
                  (set! tmp.114 (alloc tmp.115)))
                (set! tmp.94 (+ tmp.114 3)))
              (begin (mset! tmp.94 -3 tmp.20) (set! tmp.21 tmp.94)))
            (call
             L.vector-init-loop.22.11
             vector-init-loop.22
             tmp.20
             0
             tmp.21)))))
    (define L.vector-init-loop.22.11
      (lambda (c.81 len.23 i.25 vec.24)
        (begin
          (set! vector-init-loop.22 (mref c.81 14))
          (if (begin
                (if (= len.23 i.25) (set! tmp.118 14) (set! tmp.118 6))
                (!= tmp.118 6))
            vec.24
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.121 (arithmetic-shift-right i.25 3))
                    (set! tmp.120 (* tmp.121 8)))
                  (set! tmp.119 (+ tmp.120 5)))
                (mset! vec.24 tmp.119 0))
              (begin
                (set! tmp.122 (+ i.25 8))
                (call
                 L.vector-init-loop.22.11
                 vector-init-loop.22
                 len.23
                 tmp.122
                 vec.24)))))))
    (define L.+.73.10
      (lambda (c.80 tmp.36 tmp.37)
        (begin
          (if (begin
                (if (begin (set! tmp.124 (bitwise-and tmp.37 7)) (= tmp.124 0))
                  (set! tmp.123 14)
                  (set! tmp.123 6))
                (!= tmp.123 6))
            (if (begin
                  (if (begin
                        (set! tmp.126 (bitwise-and tmp.36 7))
                        (= tmp.126 0))
                    (set! tmp.125 14)
                    (set! tmp.125 6))
                  (!= tmp.125 6))
              (+ tmp.36 tmp.37)
              574)
            574))))
    (define L.-.74.9
      (lambda (c.79 tmp.38 tmp.39)
        (begin
          (if (begin
                (if (begin (set! tmp.128 (bitwise-and tmp.39 7)) (= tmp.128 0))
                  (set! tmp.127 14)
                  (set! tmp.127 6))
                (!= tmp.127 6))
            (if (begin
                  (if (begin
                        (set! tmp.130 (bitwise-and tmp.38 7))
                        (= tmp.130 0))
                    (set! tmp.129 14)
                    (set! tmp.129 6))
                  (!= tmp.129 6))
              (- tmp.38 tmp.39)
              830)
            830))))
    (define L.*.75.8
      (lambda (c.78 tmp.34 tmp.35)
        (begin
          (if (begin
                (if (begin (set! tmp.132 (bitwise-and tmp.35 7)) (= tmp.132 0))
                  (set! tmp.131 14)
                  (set! tmp.131 6))
                (!= tmp.131 6))
            (if (begin
                  (if (begin
                        (set! tmp.134 (bitwise-and tmp.34 7))
                        (= tmp.134 0))
                    (set! tmp.133 14)
                    (set! tmp.133 6))
                  (!= tmp.133 6))
              (begin
                (set! tmp.135 (arithmetic-shift-right tmp.35 3))
                (* tmp.34 tmp.135))
              318)
            318))))
    (define L.procedure?.76.7
      (lambda (c.77 tmp.66)
        (begin
          (if (begin (set! tmp.136 (bitwise-and tmp.66 7)) (= tmp.136 2))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.137 (alloc 16)) (set! tmp.95 (+ tmp.137 2)))
        (begin
          (mset! tmp.95 -2 L.procedure?.76.7)
          (mset! tmp.95 6 8)
          (set! procedure?.76 tmp.95)))
      (begin
        (begin (set! tmp.138 (alloc 16)) (set! tmp.96 (+ tmp.138 2)))
        (begin
          (mset! tmp.96 -2 L.*.75.8)
          (mset! tmp.96 6 16)
          (set! *.75 tmp.96)))
      (begin
        (begin (set! tmp.139 (alloc 16)) (set! tmp.97 (+ tmp.139 2)))
        (begin
          (mset! tmp.97 -2 L.-.74.9)
          (mset! tmp.97 6 16)
          (set! |-.74| tmp.97)))
      (begin
        (begin (set! tmp.140 (alloc 16)) (set! tmp.98 (+ tmp.140 2)))
        (begin
          (mset! tmp.98 -2 L.+.73.10)
          (mset! tmp.98 6 16)
          (set! |+.73| tmp.98)))
      (begin
        (begin (set! tmp.141 (alloc 24)) (set! tmp.99 (+ tmp.141 2)))
        (begin
          (mset! tmp.99 -2 L.vector-init-loop.22.11)
          (mset! tmp.99 6 24)
          (set! vector-init-loop.22 tmp.99)))
      (begin
        (begin (set! tmp.142 (alloc 24)) (set! tmp.100 (+ tmp.142 2)))
        (begin
          (mset! tmp.100 -2 L.make-init-vector.1.12)
          (mset! tmp.100 6 8)
          (set! make-init-vector.1 tmp.100)))
      (begin
        (begin (set! tmp.143 (alloc 24)) (set! tmp.101 (+ tmp.143 2)))
        (begin
          (mset! tmp.101 -2 L.make-vector.72.13)
          (mset! tmp.101 6 8)
          (set! make-vector.72 tmp.101)))
      (begin
        (begin (set! tmp.144 (alloc 24)) (set! tmp.102 (+ tmp.144 2)))
        (begin
          (mset! tmp.102 -2 L.fun/ascii-char14780.4.14)
          (mset! tmp.102 6 0)
          (set! fun/ascii-char14780.4 tmp.102)))
      (begin
        (begin (set! tmp.145 (alloc 24)) (set! tmp.103 (+ tmp.145 2)))
        (begin
          (mset! tmp.103 -2 L.fun/vector14772.5.15)
          (mset! tmp.103 6 0)
          (set! fun/vector14772.5 tmp.103)))
      (begin
        (begin (set! tmp.146 (alloc 16)) (set! tmp.104 (+ tmp.146 2)))
        (begin
          (mset! tmp.104 -2 L.fun/empty14779.6.16)
          (mset! tmp.104 6 0)
          (set! fun/empty14779.6 tmp.104)))
      (begin
        (begin (set! tmp.147 (alloc 16)) (set! tmp.105 (+ tmp.147 2)))
        (begin
          (mset! tmp.105 -2 L.fun/any14775.7.17)
          (mset! tmp.105 6 0)
          (set! fun/any14775.7 tmp.105)))
      (begin
        (begin (set! tmp.148 (alloc 24)) (set! tmp.106 (+ tmp.148 2)))
        (begin
          (mset! tmp.106 -2 L.fun/vector14773.8.18)
          (mset! tmp.106 6 0)
          (set! fun/vector14773.8 tmp.106)))
      (begin
        (begin (set! tmp.149 (alloc 24)) (set! tmp.107 (+ tmp.149 2)))
        (begin
          (mset! tmp.107 -2 L.fun/vector14777.9.19)
          (mset! tmp.107 6 0)
          (set! fun/vector14777.9 tmp.107)))
      (begin
        (begin (set! tmp.150 (alloc 24)) (set! tmp.108 (+ tmp.150 2)))
        (begin
          (mset! tmp.108 -2 L.fun/empty14778.10.20)
          (mset! tmp.108 6 0)
          (set! fun/empty14778.10 tmp.108)))
      (begin
        (begin (set! tmp.151 (alloc 16)) (set! tmp.109 (+ tmp.151 2)))
        (begin
          (mset! tmp.109 -2 L.fun/ascii-char14781.11.21)
          (mset! tmp.109 6 0)
          (set! fun/ascii-char14781.11 tmp.109)))
      (begin
        (begin (set! tmp.152 (alloc 24)) (set! tmp.110 (+ tmp.152 2)))
        (begin
          (mset! tmp.110 -2 L.fun/vector14776.12.22)
          (mset! tmp.110 6 0)
          (set! fun/vector14776.12 tmp.110)))
      (begin
        (begin (set! tmp.153 (alloc 24)) (set! tmp.111 (+ tmp.153 2)))
        (begin
          (mset! tmp.111 -2 L.fun/any14774.13.23)
          (mset! tmp.111 6 0)
          (set! fun/any14774.13 tmp.111)))
      (begin
        (mset! vector-init-loop.22 14 vector-init-loop.22)
        (mset! make-init-vector.1 14 vector-init-loop.22)
        (mset! make-vector.72 14 make-init-vector.1)
        (mset! fun/ascii-char14780.4 14 fun/ascii-char14781.11)
        (mset! fun/vector14772.5 14 fun/vector14773.8)
        (mset! fun/vector14773.8 14 make-vector.72)
        (mset! fun/vector14777.9 14 make-vector.72)
        (mset! fun/empty14778.10 14 fun/empty14779.6)
        (mset! fun/vector14776.12 14 fun/vector14777.9)
        (mset! fun/any14774.13 14 fun/any14775.7)
        (begin
          (begin
            (begin
              (begin
                (set! tmp.156 (call L.+.73.10 |+.73| 1824 392))
                (begin
                  (set! tmp.157 (call L.+.73.10 |+.73| 88 888))
                  (set! tmp.155 (call L.+.73.10 |+.73| tmp.156 tmp.157))))
              (begin
                (begin
                  (set! tmp.159 (call L.-.74.9 |-.74| 136 752))
                  (begin
                    (set! tmp.160 (call L.*.75.8 *.75 664 1824))
                    (set! tmp.158 (call L.+.73.10 |+.73| tmp.159 tmp.160))))
                (set! tmp.154 (call L.-.74.9 |-.74| tmp.155 tmp.158))))
            (begin
              (begin
                (begin
                  (set! tmp.163 (call L.-.74.9 |-.74| 608 240))
                  (begin
                    (set! tmp.164 (call L.+.73.10 |+.73| 160 472))
                    (set! tmp.162 (call L.*.75.8 *.75 tmp.163 tmp.164))))
                (begin
                  (begin
                    (set! tmp.166 (call L.-.74.9 |-.74| 1984 504))
                    (begin
                      (set! tmp.167 (call L.*.75.8 *.75 472 280))
                      (set! tmp.165 (call L.-.74.9 |-.74| tmp.166 tmp.167))))
                  (set! tmp.161 (call L.-.74.9 |-.74| tmp.162 tmp.165))))
              (set! fixnum0.19 (call L.*.75.8 *.75 tmp.154 tmp.161))))
          (set! vector1.18 (call L.fun/vector14772.5.15 fun/vector14772.5))
          (begin
            (set! tmp.168 (call L.fun/any14774.13.23 fun/any14774.13))
            (set! boolean2.17 (call L.procedure?.76.7 procedure?.76 tmp.168)))
          (set! vector3.16 (call L.fun/vector14776.12.22 fun/vector14776.12))
          (begin
            (begin
              (begin
                (set! tmp.171 (call L.*.75.8 *.75 280 424))
                (begin
                  (set! tmp.172 (call L.+.73.10 |+.73| 1216 288))
                  (set! tmp.170 (call L.-.74.9 |-.74| tmp.171 tmp.172))))
              (begin
                (begin
                  (set! tmp.174 (call L.+.73.10 |+.73| 1176 888))
                  (begin
                    (set! tmp.175 (call L.-.74.9 |-.74| 2000 1664))
                    (set! tmp.173 (call L.-.74.9 |-.74| tmp.174 tmp.175))))
                (set! tmp.169 (call L.-.74.9 |-.74| tmp.170 tmp.173))))
            (begin
              (begin
                (begin
                  (set! tmp.178 (call L.+.73.10 |+.73| 1960 912))
                  (begin
                    (set! tmp.179 (call L.*.75.8 *.75 944 712))
                    (set! tmp.177 (call L.+.73.10 |+.73| tmp.178 tmp.179))))
                (begin
                  (begin
                    (set! tmp.181 (call L.*.75.8 *.75 1184 1936))
                    (begin
                      (set! tmp.182 (call L.-.74.9 |-.74| 1696 600))
                      (set! tmp.180 (call L.-.74.9 |-.74| tmp.181 tmp.182))))
                  (set! tmp.176 (call L.+.73.10 |+.73| tmp.177 tmp.180))))
              (set! fixnum4.15 (call L.-.74.9 |-.74| tmp.169 tmp.176))))
          (set! empty5.14 (call L.fun/empty14778.10.20 fun/empty14778.10))
          (call L.fun/ascii-char14780.4.14 fun/ascii-char14780.4))))))
(check-by-interp
 '(module
    (define L.fun/error15420.17.22
      (lambda (c.93)
        (begin
          (set! fun/error15421.9 (mref c.93 14))
          (call L.fun/error15421.9.14 fun/error15421.9))))
    (define L.fun/error15416.16.21
      (lambda (c.92)
        (begin
          (set! fun/error15417.4 (mref c.92 14))
          (call L.fun/error15417.4.9 fun/error15417.4))))
    (define L.fun/pair15427.15.20
      (lambda (c.91)
        (begin
          (set! cons.76 (mref c.91 14))
          (call L.cons.76.8 cons.76 1976 4088))))
    (define L.fun/any15414.14.19
      (lambda (c.90)
        (begin
          (set! fun/any15415.5 (mref c.90 14))
          (call L.fun/any15415.5.10 fun/any15415.5))))
    (define L.fun/void15425.13.18 (lambda (c.89) (begin 30)))
    (define L.fun/error15422.12.17
      (lambda (c.88)
        (begin
          (set! fun/error15423.7 (mref c.88 14))
          (call L.fun/error15423.7.12 fun/error15423.7))))
    (define L.fun/error15419.11.16 (lambda (c.87) (begin 58686)))
    (define L.fun/error15418.10.15
      (lambda (c.86)
        (begin
          (set! fun/error15419.11 (mref c.86 14))
          (call L.fun/error15419.11.16 fun/error15419.11))))
    (define L.fun/error15421.9.14 (lambda (c.85) (begin 9534)))
    (define L.fun/void15424.8.13
      (lambda (c.84)
        (begin
          (set! fun/void15425.13 (mref c.84 14))
          (call L.fun/void15425.13.18 fun/void15425.13))))
    (define L.fun/error15423.7.12 (lambda (c.83) (begin 22590)))
    (define L.fun/pair15426.6.11
      (lambda (c.82)
        (begin
          (set! fun/pair15427.15 (mref c.82 14))
          (call L.fun/pair15427.15.20 fun/pair15427.15))))
    (define L.fun/any15415.5.10 (lambda (c.81) (begin 6)))
    (define L.fun/error15417.4.9 (lambda (c.80) (begin 6718)))
    (define L.cons.76.8
      (lambda (c.79 tmp.71 tmp.72)
        (begin
          (begin
            (begin (set! tmp.111 (alloc 16)) (set! tmp.94 (+ tmp.111 1)))
            (begin (mset! tmp.94 -1 tmp.71) (mset! tmp.94 7 tmp.72) tmp.94)))))
    (define L.ascii-char?.77.7
      (lambda (c.78 tmp.65)
        (begin
          (if (begin (set! tmp.112 (bitwise-and tmp.65 255)) (= tmp.112 46))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.113 (alloc 16)) (set! tmp.95 (+ tmp.113 2)))
        (begin
          (mset! tmp.95 -2 L.ascii-char?.77.7)
          (mset! tmp.95 6 8)
          (set! ascii-char?.77 tmp.95)))
      (begin
        (begin (set! tmp.114 (alloc 16)) (set! tmp.96 (+ tmp.114 2)))
        (begin
          (mset! tmp.96 -2 L.cons.76.8)
          (mset! tmp.96 6 16)
          (set! cons.76 tmp.96)))
      (begin
        (begin (set! tmp.115 (alloc 16)) (set! tmp.97 (+ tmp.115 2)))
        (begin
          (mset! tmp.97 -2 L.fun/error15417.4.9)
          (mset! tmp.97 6 0)
          (set! fun/error15417.4 tmp.97)))
      (begin
        (begin (set! tmp.116 (alloc 16)) (set! tmp.98 (+ tmp.116 2)))
        (begin
          (mset! tmp.98 -2 L.fun/any15415.5.10)
          (mset! tmp.98 6 0)
          (set! fun/any15415.5 tmp.98)))
      (begin
        (begin (set! tmp.117 (alloc 24)) (set! tmp.99 (+ tmp.117 2)))
        (begin
          (mset! tmp.99 -2 L.fun/pair15426.6.11)
          (mset! tmp.99 6 0)
          (set! fun/pair15426.6 tmp.99)))
      (begin
        (begin (set! tmp.118 (alloc 16)) (set! tmp.100 (+ tmp.118 2)))
        (begin
          (mset! tmp.100 -2 L.fun/error15423.7.12)
          (mset! tmp.100 6 0)
          (set! fun/error15423.7 tmp.100)))
      (begin
        (begin (set! tmp.119 (alloc 24)) (set! tmp.101 (+ tmp.119 2)))
        (begin
          (mset! tmp.101 -2 L.fun/void15424.8.13)
          (mset! tmp.101 6 0)
          (set! fun/void15424.8 tmp.101)))
      (begin
        (begin (set! tmp.120 (alloc 16)) (set! tmp.102 (+ tmp.120 2)))
        (begin
          (mset! tmp.102 -2 L.fun/error15421.9.14)
          (mset! tmp.102 6 0)
          (set! fun/error15421.9 tmp.102)))
      (begin
        (begin (set! tmp.121 (alloc 24)) (set! tmp.103 (+ tmp.121 2)))
        (begin
          (mset! tmp.103 -2 L.fun/error15418.10.15)
          (mset! tmp.103 6 0)
          (set! fun/error15418.10 tmp.103)))
      (begin
        (begin (set! tmp.122 (alloc 16)) (set! tmp.104 (+ tmp.122 2)))
        (begin
          (mset! tmp.104 -2 L.fun/error15419.11.16)
          (mset! tmp.104 6 0)
          (set! fun/error15419.11 tmp.104)))
      (begin
        (begin (set! tmp.123 (alloc 24)) (set! tmp.105 (+ tmp.123 2)))
        (begin
          (mset! tmp.105 -2 L.fun/error15422.12.17)
          (mset! tmp.105 6 0)
          (set! fun/error15422.12 tmp.105)))
      (begin
        (begin (set! tmp.124 (alloc 16)) (set! tmp.106 (+ tmp.124 2)))
        (begin
          (mset! tmp.106 -2 L.fun/void15425.13.18)
          (mset! tmp.106 6 0)
          (set! fun/void15425.13 tmp.106)))
      (begin
        (begin (set! tmp.125 (alloc 24)) (set! tmp.107 (+ tmp.125 2)))
        (begin
          (mset! tmp.107 -2 L.fun/any15414.14.19)
          (mset! tmp.107 6 0)
          (set! fun/any15414.14 tmp.107)))
      (begin
        (begin (set! tmp.126 (alloc 24)) (set! tmp.108 (+ tmp.126 2)))
        (begin
          (mset! tmp.108 -2 L.fun/pair15427.15.20)
          (mset! tmp.108 6 0)
          (set! fun/pair15427.15 tmp.108)))
      (begin
        (begin (set! tmp.127 (alloc 24)) (set! tmp.109 (+ tmp.127 2)))
        (begin
          (mset! tmp.109 -2 L.fun/error15416.16.21)
          (mset! tmp.109 6 0)
          (set! fun/error15416.16 tmp.109)))
      (begin
        (begin (set! tmp.128 (alloc 24)) (set! tmp.110 (+ tmp.128 2)))
        (begin
          (mset! tmp.110 -2 L.fun/error15420.17.22)
          (mset! tmp.110 6 0)
          (set! fun/error15420.17 tmp.110)))
      (begin
        (mset! fun/pair15426.6 14 fun/pair15427.15)
        (mset! fun/void15424.8 14 fun/void15425.13)
        (mset! fun/error15418.10 14 fun/error15419.11)
        (mset! fun/error15422.12 14 fun/error15423.7)
        (mset! fun/any15414.14 14 fun/any15415.5)
        (mset! fun/pair15427.15 14 cons.76)
        (mset! fun/error15416.16 14 fun/error15417.4)
        (mset! fun/error15420.17 14 fun/error15421.9)
        (begin
          (begin
            (set! tmp.129 (call L.fun/any15414.14.19 fun/any15414.14))
            (set! boolean0.23
              (call L.ascii-char?.77.7 ascii-char?.77 tmp.129)))
          (set! error1.22 (call L.fun/error15416.16.21 fun/error15416.16))
          (set! error2.21 (call L.fun/error15418.10.15 fun/error15418.10))
          (set! error3.20 (call L.fun/error15420.17.22 fun/error15420.17))
          (set! error4.19 (call L.fun/error15422.12.17 fun/error15422.12))
          (set! void5.18 (call L.fun/void15424.8.13 fun/void15424.8))
          (call L.fun/pair15426.6.11 fun/pair15426.6))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char16443.15.21
      (lambda (c.91)
        (begin
          (set! fun/ascii-char16444.5 (mref c.91 14))
          (call L.fun/ascii-char16444.5.11 fun/ascii-char16444.5))))
    (define L.fun/void16440.14.20 (lambda (c.90) (begin 30)))
    (define L.fun/error16434.13.19 (lambda (c.89) (begin 61246)))
    (define L.fun/ascii-char16441.12.18
      (lambda (c.88)
        (begin
          (set! fun/ascii-char16442.11 (mref c.88 14))
          (call L.fun/ascii-char16442.11.17 fun/ascii-char16442.11))))
    (define L.fun/ascii-char16442.11.17 (lambda (c.87) (begin 24622)))
    (define L.fun/ascii-char16436.10.16 (lambda (c.86) (begin 23342)))
    (define L.fun/ascii-char16438.9.15 (lambda (c.85) (begin 18478)))
    (define L.fun/error16433.8.14
      (lambda (c.84)
        (begin
          (set! fun/error16434.13 (mref c.84 14))
          (call L.fun/error16434.13.19 fun/error16434.13))))
    (define L.fun/ascii-char16437.7.13
      (lambda (c.83)
        (begin
          (set! fun/ascii-char16438.9 (mref c.83 14))
          (call L.fun/ascii-char16438.9.15 fun/ascii-char16438.9))))
    (define L.fun/void16439.6.12
      (lambda (c.82)
        (begin
          (set! fun/void16440.14 (mref c.82 14))
          (call L.fun/void16440.14.20 fun/void16440.14))))
    (define L.fun/ascii-char16444.5.11 (lambda (c.81) (begin 25902)))
    (define L.fun/ascii-char16435.4.10
      (lambda (c.80)
        (begin
          (set! fun/ascii-char16436.10 (mref c.80 14))
          (call L.fun/ascii-char16436.10.16 fun/ascii-char16436.10))))
    (define L.*.74.9
      (lambda (c.79 tmp.36 tmp.37)
        (begin
          (if (begin
                (if (begin (set! tmp.108 (bitwise-and tmp.37 7)) (= tmp.108 0))
                  (set! tmp.107 14)
                  (set! tmp.107 6))
                (!= tmp.107 6))
            (if (begin
                  (if (begin
                        (set! tmp.110 (bitwise-and tmp.36 7))
                        (= tmp.110 0))
                    (set! tmp.109 14)
                    (set! tmp.109 6))
                  (!= tmp.109 6))
              (begin
                (set! tmp.111 (arithmetic-shift-right tmp.37 3))
                (* tmp.36 tmp.111))
              318)
            318))))
    (define L.-.75.8
      (lambda (c.78 tmp.40 tmp.41)
        (begin
          (if (begin
                (if (begin (set! tmp.113 (bitwise-and tmp.41 7)) (= tmp.113 0))
                  (set! tmp.112 14)
                  (set! tmp.112 6))
                (!= tmp.112 6))
            (if (begin
                  (if (begin
                        (set! tmp.115 (bitwise-and tmp.40 7))
                        (= tmp.115 0))
                    (set! tmp.114 14)
                    (set! tmp.114 6))
                  (!= tmp.114 6))
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.+.76.7
      (lambda (c.77 tmp.38 tmp.39)
        (begin
          (if (begin
                (if (begin (set! tmp.117 (bitwise-and tmp.39 7)) (= tmp.117 0))
                  (set! tmp.116 14)
                  (set! tmp.116 6))
                (!= tmp.116 6))
            (if (begin
                  (if (begin
                        (set! tmp.119 (bitwise-and tmp.38 7))
                        (= tmp.119 0))
                    (set! tmp.118 14)
                    (set! tmp.118 6))
                  (!= tmp.118 6))
              (+ tmp.38 tmp.39)
              574)
            574))))
    (begin
      (begin
        (begin (set! tmp.120 (alloc 16)) (set! tmp.92 (+ tmp.120 2)))
        (begin
          (mset! tmp.92 -2 L.+.76.7)
          (mset! tmp.92 6 16)
          (set! |+.76| tmp.92)))
      (begin
        (begin (set! tmp.121 (alloc 16)) (set! tmp.93 (+ tmp.121 2)))
        (begin
          (mset! tmp.93 -2 L.-.75.8)
          (mset! tmp.93 6 16)
          (set! |-.75| tmp.93)))
      (begin
        (begin (set! tmp.122 (alloc 16)) (set! tmp.94 (+ tmp.122 2)))
        (begin
          (mset! tmp.94 -2 L.*.74.9)
          (mset! tmp.94 6 16)
          (set! *.74 tmp.94)))
      (begin
        (begin (set! tmp.123 (alloc 24)) (set! tmp.95 (+ tmp.123 2)))
        (begin
          (mset! tmp.95 -2 L.fun/ascii-char16435.4.10)
          (mset! tmp.95 6 0)
          (set! fun/ascii-char16435.4 tmp.95)))
      (begin
        (begin (set! tmp.124 (alloc 16)) (set! tmp.96 (+ tmp.124 2)))
        (begin
          (mset! tmp.96 -2 L.fun/ascii-char16444.5.11)
          (mset! tmp.96 6 0)
          (set! fun/ascii-char16444.5 tmp.96)))
      (begin
        (begin (set! tmp.125 (alloc 24)) (set! tmp.97 (+ tmp.125 2)))
        (begin
          (mset! tmp.97 -2 L.fun/void16439.6.12)
          (mset! tmp.97 6 0)
          (set! fun/void16439.6 tmp.97)))
      (begin
        (begin (set! tmp.126 (alloc 24)) (set! tmp.98 (+ tmp.126 2)))
        (begin
          (mset! tmp.98 -2 L.fun/ascii-char16437.7.13)
          (mset! tmp.98 6 0)
          (set! fun/ascii-char16437.7 tmp.98)))
      (begin
        (begin (set! tmp.127 (alloc 24)) (set! tmp.99 (+ tmp.127 2)))
        (begin
          (mset! tmp.99 -2 L.fun/error16433.8.14)
          (mset! tmp.99 6 0)
          (set! fun/error16433.8 tmp.99)))
      (begin
        (begin (set! tmp.128 (alloc 16)) (set! tmp.100 (+ tmp.128 2)))
        (begin
          (mset! tmp.100 -2 L.fun/ascii-char16438.9.15)
          (mset! tmp.100 6 0)
          (set! fun/ascii-char16438.9 tmp.100)))
      (begin
        (begin (set! tmp.129 (alloc 16)) (set! tmp.101 (+ tmp.129 2)))
        (begin
          (mset! tmp.101 -2 L.fun/ascii-char16436.10.16)
          (mset! tmp.101 6 0)
          (set! fun/ascii-char16436.10 tmp.101)))
      (begin
        (begin (set! tmp.130 (alloc 16)) (set! tmp.102 (+ tmp.130 2)))
        (begin
          (mset! tmp.102 -2 L.fun/ascii-char16442.11.17)
          (mset! tmp.102 6 0)
          (set! fun/ascii-char16442.11 tmp.102)))
      (begin
        (begin (set! tmp.131 (alloc 24)) (set! tmp.103 (+ tmp.131 2)))
        (begin
          (mset! tmp.103 -2 L.fun/ascii-char16441.12.18)
          (mset! tmp.103 6 0)
          (set! fun/ascii-char16441.12 tmp.103)))
      (begin
        (begin (set! tmp.132 (alloc 16)) (set! tmp.104 (+ tmp.132 2)))
        (begin
          (mset! tmp.104 -2 L.fun/error16434.13.19)
          (mset! tmp.104 6 0)
          (set! fun/error16434.13 tmp.104)))
      (begin
        (begin (set! tmp.133 (alloc 16)) (set! tmp.105 (+ tmp.133 2)))
        (begin
          (mset! tmp.105 -2 L.fun/void16440.14.20)
          (mset! tmp.105 6 0)
          (set! fun/void16440.14 tmp.105)))
      (begin
        (begin (set! tmp.134 (alloc 24)) (set! tmp.106 (+ tmp.134 2)))
        (begin
          (mset! tmp.106 -2 L.fun/ascii-char16443.15.21)
          (mset! tmp.106 6 0)
          (set! fun/ascii-char16443.15 tmp.106)))
      (begin
        (mset! fun/ascii-char16435.4 14 fun/ascii-char16436.10)
        (mset! fun/void16439.6 14 fun/void16440.14)
        (mset! fun/ascii-char16437.7 14 fun/ascii-char16438.9)
        (mset! fun/error16433.8 14 fun/error16434.13)
        (mset! fun/ascii-char16441.12 14 fun/ascii-char16442.11)
        (mset! fun/ascii-char16443.15 14 fun/ascii-char16444.5)
        (begin
          (set! error0.21 (call L.fun/error16433.8.14 fun/error16433.8))
          (set! ascii-char1.20
            (call L.fun/ascii-char16435.4.10 fun/ascii-char16435.4))
          (begin
            (begin
              (begin
                (set! tmp.137 (call L.*.74.9 *.74 1920 368))
                (begin
                  (set! tmp.138 (call L.-.75.8 |-.75| 1504 896))
                  (set! tmp.136 (call L.-.75.8 |-.75| tmp.137 tmp.138))))
              (begin
                (begin
                  (set! tmp.140 (call L.*.74.9 *.74 280 1680))
                  (begin
                    (set! tmp.141 (call L.+.76.7 |+.76| 856 2032))
                    (set! tmp.139 (call L.-.75.8 |-.75| tmp.140 tmp.141))))
                (set! tmp.135 (call L.*.74.9 *.74 tmp.136 tmp.139))))
            (begin
              (begin
                (begin
                  (set! tmp.144 (call L.-.75.8 |-.75| 640 1864))
                  (begin
                    (set! tmp.145 (call L.*.74.9 *.74 864 1488))
                    (set! tmp.143 (call L.*.74.9 *.74 tmp.144 tmp.145))))
                (begin
                  (begin
                    (set! tmp.147 (call L.-.75.8 |-.75| 1872 1376))
                    (begin
                      (set! tmp.148 (call L.+.76.7 |+.76| 1432 640))
                      (set! tmp.146 (call L.-.75.8 |-.75| tmp.147 tmp.148))))
                  (set! tmp.142 (call L.-.75.8 |-.75| tmp.143 tmp.146))))
              (set! fixnum2.19 (call L.+.76.7 |+.76| tmp.135 tmp.142))))
          (set! ascii-char3.18
            (call L.fun/ascii-char16437.7.13 fun/ascii-char16437.7))
          (set! void4.17 (call L.fun/void16439.6.12 fun/void16439.6))
          (set! ascii-char5.16
            (call L.fun/ascii-char16441.12.18 fun/ascii-char16441.12))
          (call L.fun/ascii-char16443.15.21 fun/ascii-char16443.15))))))
(check-by-interp
 '(module
    (define L.fun/error16486.12.24 (lambda (c.107) (begin 57662)))
    (define L.fun/empty16490.11.23 (lambda (c.106) (begin 22)))
    (define L.fun/error16485.10.22 (lambda (c.105) (begin 60734)))
    (define L.fun/empty16489.9.21 (lambda (c.104) (begin 22)))
    (define L.fun/any16488.8.20 (lambda (c.103) (begin 544)))
    (define L.fun/empty16487.7.19 (lambda (c.102) (begin 22)))
    (define L.fun/vector16484.6.18
      (lambda (c.101)
        (begin
          (set! make-vector.83 (mref c.101 14))
          (call L.make-vector.83.15 make-vector.83 64))))
    (define L.fun/empty16491.5.17 (lambda (c.100) (begin 22)))
    (define L.fun/ascii-char16492.4.16 (lambda (c.99) (begin 26670)))
    (define L.make-vector.83.15
      (lambda (c.98 tmp.59)
        (begin
          (set! make-init-vector.1 (mref c.98 14))
          (if (begin
                (if (begin (set! tmp.128 (bitwise-and tmp.59 7)) (= tmp.128 0))
                  (set! tmp.127 14)
                  (set! tmp.127 6))
                (!= tmp.127 6))
            (call L.make-init-vector.1.14 make-init-vector.1 tmp.59)
            2110))))
    (define L.make-init-vector.1.14
      (lambda (c.97 tmp.31)
        (begin
          (set! vector-init-loop.33 (mref c.97 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.132 (arithmetic-shift-right tmp.31 3))
                      (set! tmp.131 (+ 1 tmp.132)))
                    (set! tmp.130 (* tmp.131 8)))
                  (set! tmp.129 (alloc tmp.130)))
                (set! tmp.108 (+ tmp.129 3)))
              (begin (mset! tmp.108 -3 tmp.31) (set! tmp.32 tmp.108)))
            (call
             L.vector-init-loop.33.13
             vector-init-loop.33
             tmp.31
             0
             tmp.32)))))
    (define L.vector-init-loop.33.13
      (lambda (c.96 len.34 i.36 vec.35)
        (begin
          (set! vector-init-loop.33 (mref c.96 14))
          (if (begin
                (if (= len.34 i.36) (set! tmp.133 14) (set! tmp.133 6))
                (!= tmp.133 6))
            vec.35
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.136 (arithmetic-shift-right i.36 3))
                    (set! tmp.135 (* tmp.136 8)))
                  (set! tmp.134 (+ tmp.135 5)))
                (mset! vec.35 tmp.134 0))
              (begin
                (set! tmp.137 (+ i.36 8))
                (call
                 L.vector-init-loop.33.13
                 vector-init-loop.33
                 len.34
                 tmp.137
                 vec.35)))))))
    (define L.-.84.12
      (lambda (c.95 tmp.49 tmp.50)
        (begin
          (if (begin
                (if (begin (set! tmp.139 (bitwise-and tmp.50 7)) (= tmp.139 0))
                  (set! tmp.138 14)
                  (set! tmp.138 6))
                (!= tmp.138 6))
            (if (begin
                  (if (begin
                        (set! tmp.141 (bitwise-and tmp.49 7))
                        (= tmp.141 0))
                    (set! tmp.140 14)
                    (set! tmp.140 6))
                  (!= tmp.140 6))
              (- tmp.49 tmp.50)
              830)
            830))))
    (define L.+.85.11
      (lambda (c.94 tmp.47 tmp.48)
        (begin
          (if (begin
                (if (begin (set! tmp.143 (bitwise-and tmp.48 7)) (= tmp.143 0))
                  (set! tmp.142 14)
                  (set! tmp.142 6))
                (!= tmp.142 6))
            (if (begin
                  (if (begin
                        (set! tmp.145 (bitwise-and tmp.47 7))
                        (= tmp.145 0))
                    (set! tmp.144 14)
                    (set! tmp.144 6))
                  (!= tmp.144 6))
              (+ tmp.47 tmp.48)
              574)
            574))))
    (define L.<=.86.10
      (lambda (c.93 tmp.53 tmp.54)
        (begin
          (if (begin
                (if (begin (set! tmp.147 (bitwise-and tmp.54 7)) (= tmp.147 0))
                  (set! tmp.146 14)
                  (set! tmp.146 6))
                (!= tmp.146 6))
            (if (begin
                  (if (begin
                        (set! tmp.149 (bitwise-and tmp.53 7))
                        (= tmp.149 0))
                    (set! tmp.148 14)
                    (set! tmp.148 6))
                  (!= tmp.148 6))
              (if (<= tmp.53 tmp.54) 14 6)
              1342)
            1342))))
    (define L.boolean?.87.9
      (lambda (c.92 tmp.69)
        (begin
          (if (begin (set! tmp.150 (bitwise-and tmp.69 247)) (= tmp.150 6))
            14
            6))))
    (define L.*.88.8
      (lambda (c.91 tmp.45 tmp.46)
        (begin
          (if (begin
                (if (begin (set! tmp.152 (bitwise-and tmp.46 7)) (= tmp.152 0))
                  (set! tmp.151 14)
                  (set! tmp.151 6))
                (!= tmp.151 6))
            (if (begin
                  (if (begin
                        (set! tmp.154 (bitwise-and tmp.45 7))
                        (= tmp.154 0))
                    (set! tmp.153 14)
                    (set! tmp.153 6))
                  (!= tmp.153 6))
              (begin
                (set! tmp.155 (arithmetic-shift-right tmp.46 3))
                (* tmp.45 tmp.155))
              318)
            318))))
    (define L.>.89.7
      (lambda (c.90 tmp.55 tmp.56)
        (begin
          (if (begin
                (if (begin (set! tmp.157 (bitwise-and tmp.56 7)) (= tmp.157 0))
                  (set! tmp.156 14)
                  (set! tmp.156 6))
                (!= tmp.156 6))
            (if (begin
                  (if (begin
                        (set! tmp.159 (bitwise-and tmp.55 7))
                        (= tmp.159 0))
                    (set! tmp.158 14)
                    (set! tmp.158 6))
                  (!= tmp.158 6))
              (if (> tmp.55 tmp.56) 14 6)
              1598)
            1598))))
    (begin
      (begin
        (begin (set! tmp.160 (alloc 16)) (set! tmp.109 (+ tmp.160 2)))
        (begin
          (mset! tmp.109 -2 L.>.89.7)
          (mset! tmp.109 6 16)
          (set! >.89 tmp.109)))
      (begin
        (begin (set! tmp.161 (alloc 16)) (set! tmp.110 (+ tmp.161 2)))
        (begin
          (mset! tmp.110 -2 L.*.88.8)
          (mset! tmp.110 6 16)
          (set! *.88 tmp.110)))
      (begin
        (begin (set! tmp.162 (alloc 16)) (set! tmp.111 (+ tmp.162 2)))
        (begin
          (mset! tmp.111 -2 L.boolean?.87.9)
          (mset! tmp.111 6 8)
          (set! boolean?.87 tmp.111)))
      (begin
        (begin (set! tmp.163 (alloc 16)) (set! tmp.112 (+ tmp.163 2)))
        (begin
          (mset! tmp.112 -2 L.<=.86.10)
          (mset! tmp.112 6 16)
          (set! <=.86 tmp.112)))
      (begin
        (begin (set! tmp.164 (alloc 16)) (set! tmp.113 (+ tmp.164 2)))
        (begin
          (mset! tmp.113 -2 L.+.85.11)
          (mset! tmp.113 6 16)
          (set! |+.85| tmp.113)))
      (begin
        (begin (set! tmp.165 (alloc 16)) (set! tmp.114 (+ tmp.165 2)))
        (begin
          (mset! tmp.114 -2 L.-.84.12)
          (mset! tmp.114 6 16)
          (set! |-.84| tmp.114)))
      (begin
        (begin (set! tmp.166 (alloc 24)) (set! tmp.115 (+ tmp.166 2)))
        (begin
          (mset! tmp.115 -2 L.vector-init-loop.33.13)
          (mset! tmp.115 6 24)
          (set! vector-init-loop.33 tmp.115)))
      (begin
        (begin (set! tmp.167 (alloc 24)) (set! tmp.116 (+ tmp.167 2)))
        (begin
          (mset! tmp.116 -2 L.make-init-vector.1.14)
          (mset! tmp.116 6 8)
          (set! make-init-vector.1 tmp.116)))
      (begin
        (begin (set! tmp.168 (alloc 24)) (set! tmp.117 (+ tmp.168 2)))
        (begin
          (mset! tmp.117 -2 L.make-vector.83.15)
          (mset! tmp.117 6 8)
          (set! make-vector.83 tmp.117)))
      (begin
        (begin (set! tmp.169 (alloc 16)) (set! tmp.118 (+ tmp.169 2)))
        (begin
          (mset! tmp.118 -2 L.fun/ascii-char16492.4.16)
          (mset! tmp.118 6 0)
          (set! fun/ascii-char16492.4 tmp.118)))
      (begin
        (begin (set! tmp.170 (alloc 16)) (set! tmp.119 (+ tmp.170 2)))
        (begin
          (mset! tmp.119 -2 L.fun/empty16491.5.17)
          (mset! tmp.119 6 0)
          (set! fun/empty16491.5 tmp.119)))
      (begin
        (begin (set! tmp.171 (alloc 24)) (set! tmp.120 (+ tmp.171 2)))
        (begin
          (mset! tmp.120 -2 L.fun/vector16484.6.18)
          (mset! tmp.120 6 0)
          (set! fun/vector16484.6 tmp.120)))
      (begin
        (begin (set! tmp.172 (alloc 16)) (set! tmp.121 (+ tmp.172 2)))
        (begin
          (mset! tmp.121 -2 L.fun/empty16487.7.19)
          (mset! tmp.121 6 0)
          (set! fun/empty16487.7 tmp.121)))
      (begin
        (begin (set! tmp.173 (alloc 16)) (set! tmp.122 (+ tmp.173 2)))
        (begin
          (mset! tmp.122 -2 L.fun/any16488.8.20)
          (mset! tmp.122 6 0)
          (set! fun/any16488.8 tmp.122)))
      (begin
        (begin (set! tmp.174 (alloc 16)) (set! tmp.123 (+ tmp.174 2)))
        (begin
          (mset! tmp.123 -2 L.fun/empty16489.9.21)
          (mset! tmp.123 6 0)
          (set! fun/empty16489.9 tmp.123)))
      (begin
        (begin (set! tmp.175 (alloc 16)) (set! tmp.124 (+ tmp.175 2)))
        (begin
          (mset! tmp.124 -2 L.fun/error16485.10.22)
          (mset! tmp.124 6 0)
          (set! fun/error16485.10 tmp.124)))
      (begin
        (begin (set! tmp.176 (alloc 16)) (set! tmp.125 (+ tmp.176 2)))
        (begin
          (mset! tmp.125 -2 L.fun/empty16490.11.23)
          (mset! tmp.125 6 0)
          (set! fun/empty16490.11 tmp.125)))
      (begin
        (begin (set! tmp.177 (alloc 16)) (set! tmp.126 (+ tmp.177 2)))
        (begin
          (mset! tmp.126 -2 L.fun/error16486.12.24)
          (mset! tmp.126 6 0)
          (set! fun/error16486.12 tmp.126)))
      (begin
        (mset! vector-init-loop.33 14 vector-init-loop.33)
        (mset! make-init-vector.1 14 vector-init-loop.33)
        (mset! make-vector.83 14 make-init-vector.1)
        (mset! fun/vector16484.6 14 make-vector.83)
        (if (begin
              (begin
                (set! tmp.178 (call L.-.84.12 |-.84| 712 1600))
                (begin
                  (set! tmp.179 (call L.+.85.11 |+.85| 304 1928))
                  (set! fixnum0.18 (call L.-.84.12 |-.84| tmp.178 tmp.179))))
              (set! vector1.17 (call L.fun/vector16484.6.18 fun/vector16484.6))
              (set! error2.16 (call L.fun/error16485.10.22 fun/error16485.10))
              (set! error3.15 (call L.fun/error16486.12.24 fun/error16486.12))
              (set! empty4.14 (call L.fun/empty16487.7.19 fun/empty16487.7))
              (begin
                (set! tmp.180 (call L.-.84.12 |-.84| 1480 1376))
                (begin
                  (set! tmp.181 (call L.+.85.11 |+.85| 1088 1384))
                  (set! boolean5.13 (call L.<=.86.10 <=.86 tmp.180 tmp.181))))
              (begin
                (begin
                  (set! tmp.183 (call L.fun/any16488.8.20 fun/any16488.8))
                  (set! tmp.182 (call L.boolean?.87.9 boolean?.87 tmp.183)))
                (!= tmp.182 6)))
          (if (if (!= 14 6) (!= 6 6) (!= 6 6))
            (begin
              (set! ascii-char0.24 24366)
              (set! ascii-char1.23 16686)
              (set! boolean2.22 6)
              (set! void3.21 30)
              (set! boolean4.20 6)
              (set! empty5.19 22)
              21806)
            (if (!= 14 6) 30254 21806))
          (begin
            (set! empty0.30 (call L.fun/empty16489.9.21 fun/empty16489.9))
            (begin
              (set! tmp.184 (call L.*.88.8 *.88 424 1672))
              (begin
                (set! tmp.185 (call L.*.88.8 *.88 16 920))
                (set! fixnum1.29 (call L.-.84.12 |-.84| tmp.184 tmp.185))))
            (begin
              (set! tmp.186 (call L.*.88.8 *.88 752 176))
              (begin
                (set! tmp.187 (call L.+.85.11 |+.85| 712 680))
                (set! boolean2.28 (call L.>.89.7 >.89 tmp.186 tmp.187))))
            (set! empty3.27 (call L.fun/empty16490.11.23 fun/empty16490.11))
            (begin
              (set! tmp.188 (call L.-.84.12 |-.84| 136 504))
              (begin
                (set! tmp.189 (call L.*.88.8 *.88 1176 40))
                (set! fixnum4.26 (call L.-.84.12 |-.84| tmp.188 tmp.189))))
            (set! empty5.25 (call L.fun/empty16491.5.17 fun/empty16491.5))
            (call L.fun/ascii-char16492.4.16 fun/ascii-char16492.4)))))))
(check-by-interp
 '(module
    (define L.fun/vector16594.17.25
      (lambda (c.97)
        (begin
          (set! fun/vector16595.8 (mref c.97 14))
          (call L.fun/vector16595.8.16 fun/vector16595.8))))
    (define L.fun/void16600.16.24
      (lambda (c.96)
        (begin
          (set! fun/void16601.9 (mref c.96 14))
          (call L.fun/void16601.9.17 fun/void16601.9))))
    (define L.fun/ascii-char16602.15.23
      (lambda (c.95)
        (begin
          (set! fun/ascii-char16603.5 (mref c.95 14))
          (call L.fun/ascii-char16603.5.13 fun/ascii-char16603.5))))
    (define L.fun/ascii-char16596.14.22
      (lambda (c.94)
        (begin
          (set! fun/ascii-char16597.10 (mref c.94 14))
          (call L.fun/ascii-char16597.10.18 fun/ascii-char16597.10))))
    (define L.fun/vector16593.13.21
      (lambda (c.93)
        (begin
          (set! make-vector.76 (mref c.93 14))
          (call L.make-vector.76.11 make-vector.76 64))))
    (define L.fun/any16599.12.20
      (lambda (c.92)
        (begin
          (set! cons.77 (mref c.92 14))
          (call L.cons.77.8 cons.77 1424 4088))))
    (define L.fun/vector16604.11.19
      (lambda (c.91)
        (begin
          (set! fun/vector16605.7 (mref c.91 14))
          (call L.fun/vector16605.7.15 fun/vector16605.7))))
    (define L.fun/ascii-char16597.10.18 (lambda (c.90) (begin 25390)))
    (define L.fun/void16601.9.17 (lambda (c.89) (begin 30)))
    (define L.fun/vector16595.8.16
      (lambda (c.88)
        (begin
          (set! make-vector.76 (mref c.88 14))
          (call L.make-vector.76.11 make-vector.76 64))))
    (define L.fun/vector16605.7.15
      (lambda (c.87)
        (begin
          (set! make-vector.76 (mref c.87 14))
          (call L.make-vector.76.11 make-vector.76 64))))
    (define L.fun/vector16592.6.14
      (lambda (c.86)
        (begin
          (set! fun/vector16593.13 (mref c.86 14))
          (call L.fun/vector16593.13.21 fun/vector16593.13))))
    (define L.fun/ascii-char16603.5.13 (lambda (c.85) (begin 23854)))
    (define L.fun/any16598.4.12
      (lambda (c.84)
        (begin
          (set! fun/any16599.12 (mref c.84 14))
          (call L.fun/any16599.12.20 fun/any16599.12))))
    (define L.make-vector.76.11
      (lambda (c.83 tmp.52)
        (begin
          (set! make-init-vector.1 (mref c.83 14))
          (if (begin
                (if (begin (set! tmp.120 (bitwise-and tmp.52 7)) (= tmp.120 0))
                  (set! tmp.119 14)
                  (set! tmp.119 6))
                (!= tmp.119 6))
            (call L.make-init-vector.1.10 make-init-vector.1 tmp.52)
            2110))))
    (define L.make-init-vector.1.10
      (lambda (c.82 tmp.24)
        (begin
          (set! vector-init-loop.26 (mref c.82 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.124 (arithmetic-shift-right tmp.24 3))
                      (set! tmp.123 (+ 1 tmp.124)))
                    (set! tmp.122 (* tmp.123 8)))
                  (set! tmp.121 (alloc tmp.122)))
                (set! tmp.98 (+ tmp.121 3)))
              (begin (mset! tmp.98 -3 tmp.24) (set! tmp.25 tmp.98)))
            (call
             L.vector-init-loop.26.9
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.9
      (lambda (c.81 len.27 i.29 vec.28)
        (begin
          (set! vector-init-loop.26 (mref c.81 14))
          (if (begin
                (if (= len.27 i.29) (set! tmp.125 14) (set! tmp.125 6))
                (!= tmp.125 6))
            vec.28
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.128 (arithmetic-shift-right i.29 3))
                    (set! tmp.127 (* tmp.128 8)))
                  (set! tmp.126 (+ tmp.127 5)))
                (mset! vec.28 tmp.126 0))
              (begin
                (set! tmp.129 (+ i.29 8))
                (call
                 L.vector-init-loop.26.9
                 vector-init-loop.26
                 len.27
                 tmp.129
                 vec.28)))))))
    (define L.cons.77.8
      (lambda (c.80 tmp.71 tmp.72)
        (begin
          (begin
            (begin (set! tmp.130 (alloc 16)) (set! tmp.99 (+ tmp.130 1)))
            (begin (mset! tmp.99 -1 tmp.71) (mset! tmp.99 7 tmp.72) tmp.99)))))
    (define L.procedure?.78.7
      (lambda (c.79 tmp.70)
        (begin
          (if (begin (set! tmp.131 (bitwise-and tmp.70 7)) (= tmp.131 2))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.132 (alloc 16)) (set! tmp.100 (+ tmp.132 2)))
        (begin
          (mset! tmp.100 -2 L.procedure?.78.7)
          (mset! tmp.100 6 8)
          (set! procedure?.78 tmp.100)))
      (begin
        (begin (set! tmp.133 (alloc 16)) (set! tmp.101 (+ tmp.133 2)))
        (begin
          (mset! tmp.101 -2 L.cons.77.8)
          (mset! tmp.101 6 16)
          (set! cons.77 tmp.101)))
      (begin
        (begin (set! tmp.134 (alloc 24)) (set! tmp.102 (+ tmp.134 2)))
        (begin
          (mset! tmp.102 -2 L.vector-init-loop.26.9)
          (mset! tmp.102 6 24)
          (set! vector-init-loop.26 tmp.102)))
      (begin
        (begin (set! tmp.135 (alloc 24)) (set! tmp.103 (+ tmp.135 2)))
        (begin
          (mset! tmp.103 -2 L.make-init-vector.1.10)
          (mset! tmp.103 6 8)
          (set! make-init-vector.1 tmp.103)))
      (begin
        (begin (set! tmp.136 (alloc 24)) (set! tmp.104 (+ tmp.136 2)))
        (begin
          (mset! tmp.104 -2 L.make-vector.76.11)
          (mset! tmp.104 6 8)
          (set! make-vector.76 tmp.104)))
      (begin
        (begin (set! tmp.137 (alloc 24)) (set! tmp.105 (+ tmp.137 2)))
        (begin
          (mset! tmp.105 -2 L.fun/any16598.4.12)
          (mset! tmp.105 6 0)
          (set! fun/any16598.4 tmp.105)))
      (begin
        (begin (set! tmp.138 (alloc 16)) (set! tmp.106 (+ tmp.138 2)))
        (begin
          (mset! tmp.106 -2 L.fun/ascii-char16603.5.13)
          (mset! tmp.106 6 0)
          (set! fun/ascii-char16603.5 tmp.106)))
      (begin
        (begin (set! tmp.139 (alloc 24)) (set! tmp.107 (+ tmp.139 2)))
        (begin
          (mset! tmp.107 -2 L.fun/vector16592.6.14)
          (mset! tmp.107 6 0)
          (set! fun/vector16592.6 tmp.107)))
      (begin
        (begin (set! tmp.140 (alloc 24)) (set! tmp.108 (+ tmp.140 2)))
        (begin
          (mset! tmp.108 -2 L.fun/vector16605.7.15)
          (mset! tmp.108 6 0)
          (set! fun/vector16605.7 tmp.108)))
      (begin
        (begin (set! tmp.141 (alloc 24)) (set! tmp.109 (+ tmp.141 2)))
        (begin
          (mset! tmp.109 -2 L.fun/vector16595.8.16)
          (mset! tmp.109 6 0)
          (set! fun/vector16595.8 tmp.109)))
      (begin
        (begin (set! tmp.142 (alloc 16)) (set! tmp.110 (+ tmp.142 2)))
        (begin
          (mset! tmp.110 -2 L.fun/void16601.9.17)
          (mset! tmp.110 6 0)
          (set! fun/void16601.9 tmp.110)))
      (begin
        (begin (set! tmp.143 (alloc 16)) (set! tmp.111 (+ tmp.143 2)))
        (begin
          (mset! tmp.111 -2 L.fun/ascii-char16597.10.18)
          (mset! tmp.111 6 0)
          (set! fun/ascii-char16597.10 tmp.111)))
      (begin
        (begin (set! tmp.144 (alloc 24)) (set! tmp.112 (+ tmp.144 2)))
        (begin
          (mset! tmp.112 -2 L.fun/vector16604.11.19)
          (mset! tmp.112 6 0)
          (set! fun/vector16604.11 tmp.112)))
      (begin
        (begin (set! tmp.145 (alloc 24)) (set! tmp.113 (+ tmp.145 2)))
        (begin
          (mset! tmp.113 -2 L.fun/any16599.12.20)
          (mset! tmp.113 6 0)
          (set! fun/any16599.12 tmp.113)))
      (begin
        (begin (set! tmp.146 (alloc 24)) (set! tmp.114 (+ tmp.146 2)))
        (begin
          (mset! tmp.114 -2 L.fun/vector16593.13.21)
          (mset! tmp.114 6 0)
          (set! fun/vector16593.13 tmp.114)))
      (begin
        (begin (set! tmp.147 (alloc 24)) (set! tmp.115 (+ tmp.147 2)))
        (begin
          (mset! tmp.115 -2 L.fun/ascii-char16596.14.22)
          (mset! tmp.115 6 0)
          (set! fun/ascii-char16596.14 tmp.115)))
      (begin
        (begin (set! tmp.148 (alloc 24)) (set! tmp.116 (+ tmp.148 2)))
        (begin
          (mset! tmp.116 -2 L.fun/ascii-char16602.15.23)
          (mset! tmp.116 6 0)
          (set! fun/ascii-char16602.15 tmp.116)))
      (begin
        (begin (set! tmp.149 (alloc 24)) (set! tmp.117 (+ tmp.149 2)))
        (begin
          (mset! tmp.117 -2 L.fun/void16600.16.24)
          (mset! tmp.117 6 0)
          (set! fun/void16600.16 tmp.117)))
      (begin
        (begin (set! tmp.150 (alloc 24)) (set! tmp.118 (+ tmp.150 2)))
        (begin
          (mset! tmp.118 -2 L.fun/vector16594.17.25)
          (mset! tmp.118 6 0)
          (set! fun/vector16594.17 tmp.118)))
      (begin
        (mset! vector-init-loop.26 14 vector-init-loop.26)
        (mset! make-init-vector.1 14 vector-init-loop.26)
        (mset! make-vector.76 14 make-init-vector.1)
        (mset! fun/any16598.4 14 fun/any16599.12)
        (mset! fun/vector16592.6 14 fun/vector16593.13)
        (mset! fun/vector16605.7 14 make-vector.76)
        (mset! fun/vector16595.8 14 make-vector.76)
        (mset! fun/vector16604.11 14 fun/vector16605.7)
        (mset! fun/any16599.12 14 cons.77)
        (mset! fun/vector16593.13 14 make-vector.76)
        (mset! fun/ascii-char16596.14 14 fun/ascii-char16597.10)
        (mset! fun/ascii-char16602.15 14 fun/ascii-char16603.5)
        (mset! fun/void16600.16 14 fun/void16601.9)
        (mset! fun/vector16594.17 14 fun/vector16595.8)
        (begin
          (set! vector0.23 (call L.fun/vector16592.6.14 fun/vector16592.6))
          (set! vector1.22 (call L.fun/vector16594.17.25 fun/vector16594.17))
          (set! ascii-char2.21
            (call L.fun/ascii-char16596.14.22 fun/ascii-char16596.14))
          (begin
            (set! tmp.151 (call L.fun/any16598.4.12 fun/any16598.4))
            (set! boolean3.20 (call L.procedure?.78.7 procedure?.78 tmp.151)))
          (set! void4.19 (call L.fun/void16600.16.24 fun/void16600.16))
          (set! ascii-char5.18
            (call L.fun/ascii-char16602.15.23 fun/ascii-char16602.15))
          (call L.fun/vector16604.11.19 fun/vector16604.11))))))
(check-by-interp
 '(module
    (define L.lam.80.27
      (lambda (c.101)
        (begin
          (set! fun/empty17996.16 (mref c.101 14))
          (call L.fun/empty17996.16.25 fun/empty17996.16))))
    (define L.fun/ascii-char18009.17.26 (lambda (c.100) (begin 18222)))
    (define L.fun/empty17996.16.25
      (lambda (c.99)
        (begin
          (set! fun/empty17997.10 (mref c.99 14))
          (call L.fun/empty17997.10.19 fun/empty17997.10))))
    (define L.fun/vector18000.15.24
      (lambda (c.98)
        (begin
          (set! fun/vector18001.4 (mref c.98 14))
          (call L.fun/vector18001.4.13 fun/vector18001.4))))
    (define L.fun/any18003.14.23
      (lambda (c.97)
        (begin
          (set! cons.77 (mref c.97 14))
          (call L.cons.77.9 cons.77 784 2296))))
    (define L.fun/any18004.13.22
      (lambda (c.96)
        (begin
          (set! fun/any18005.11 (mref c.96 14))
          (call L.fun/any18005.11.20 fun/any18005.11))))
    (define L.fun/void18007.12.21 (lambda (c.95) (begin 30)))
    (define L.fun/any18005.11.20 (lambda (c.94) (begin 40510)))
    (define L.fun/empty17997.10.19 (lambda (c.93) (begin 22)))
    (define L.fun/any18002.9.18
      (lambda (c.92)
        (begin
          (set! fun/any18003.14 (mref c.92 14))
          (call L.fun/any18003.14.23 fun/any18003.14))))
    (define L.fun/void18006.8.17
      (lambda (c.91)
        (begin
          (set! fun/void18007.12 (mref c.91 14))
          (call L.fun/void18007.12.21 fun/void18007.12))))
    (define L.fun/ascii-char18008.7.16
      (lambda (c.90)
        (begin
          (set! fun/ascii-char18009.17 (mref c.90 14))
          (call L.fun/ascii-char18009.17.26 fun/ascii-char18009.17))))
    (define L.fun/vector17998.6.15
      (lambda (c.89)
        (begin
          (set! fun/vector17999.5 (mref c.89 14))
          (call L.fun/vector17999.5.14 fun/vector17999.5))))
    (define L.fun/vector17999.5.14
      (lambda (c.88)
        (begin
          (set! make-vector.76 (mref c.88 14))
          (call L.make-vector.76.12 make-vector.76 64))))
    (define L.fun/vector18001.4.13
      (lambda (c.87)
        (begin
          (set! make-vector.76 (mref c.87 14))
          (call L.make-vector.76.12 make-vector.76 64))))
    (define L.make-vector.76.12
      (lambda (c.86 tmp.52)
        (begin
          (set! make-init-vector.1 (mref c.86 14))
          (if (begin
                (if (begin (set! tmp.126 (bitwise-and tmp.52 7)) (= tmp.126 0))
                  (set! tmp.125 14)
                  (set! tmp.125 6))
                (!= tmp.125 6))
            (call L.make-init-vector.1.11 make-init-vector.1 tmp.52)
            2110))))
    (define L.make-init-vector.1.11
      (lambda (c.85 tmp.24)
        (begin
          (set! vector-init-loop.26 (mref c.85 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.130 (arithmetic-shift-right tmp.24 3))
                      (set! tmp.129 (+ 1 tmp.130)))
                    (set! tmp.128 (* tmp.129 8)))
                  (set! tmp.127 (alloc tmp.128)))
                (set! tmp.102 (+ tmp.127 3)))
              (begin (mset! tmp.102 -3 tmp.24) (set! tmp.25 tmp.102)))
            (call
             L.vector-init-loop.26.10
             vector-init-loop.26
             tmp.24
             0
             tmp.25)))))
    (define L.vector-init-loop.26.10
      (lambda (c.84 len.27 i.29 vec.28)
        (begin
          (set! vector-init-loop.26 (mref c.84 14))
          (if (begin
                (if (= len.27 i.29) (set! tmp.131 14) (set! tmp.131 6))
                (!= tmp.131 6))
            vec.28
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.134 (arithmetic-shift-right i.29 3))
                    (set! tmp.133 (* tmp.134 8)))
                  (set! tmp.132 (+ tmp.133 5)))
                (mset! vec.28 tmp.132 0))
              (begin
                (set! tmp.135 (+ i.29 8))
                (call
                 L.vector-init-loop.26.10
                 vector-init-loop.26
                 len.27
                 tmp.135
                 vec.28)))))))
    (define L.cons.77.9
      (lambda (c.83 tmp.71 tmp.72)
        (begin
          (begin
            (begin (set! tmp.136 (alloc 16)) (set! tmp.103 (+ tmp.136 1)))
            (begin
              (mset! tmp.103 -1 tmp.71)
              (mset! tmp.103 7 tmp.72)
              tmp.103)))))
    (define L.vector?.78.8
      (lambda (c.82 tmp.68)
        (begin
          (if (begin (set! tmp.137 (bitwise-and tmp.68 7)) (= tmp.137 3))
            14
            6))))
    (define L.void?.79.7
      (lambda (c.81 tmp.64)
        (begin
          (if (begin (set! tmp.138 (bitwise-and tmp.64 255)) (= tmp.138 30))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.139 (alloc 16)) (set! tmp.104 (+ tmp.139 2)))
        (begin
          (mset! tmp.104 -2 L.void?.79.7)
          (mset! tmp.104 6 8)
          (set! void?.79 tmp.104)))
      (begin
        (begin (set! tmp.140 (alloc 16)) (set! tmp.105 (+ tmp.140 2)))
        (begin
          (mset! tmp.105 -2 L.vector?.78.8)
          (mset! tmp.105 6 8)
          (set! vector?.78 tmp.105)))
      (begin
        (begin (set! tmp.141 (alloc 16)) (set! tmp.106 (+ tmp.141 2)))
        (begin
          (mset! tmp.106 -2 L.cons.77.9)
          (mset! tmp.106 6 16)
          (set! cons.77 tmp.106)))
      (begin
        (begin (set! tmp.142 (alloc 24)) (set! tmp.107 (+ tmp.142 2)))
        (begin
          (mset! tmp.107 -2 L.vector-init-loop.26.10)
          (mset! tmp.107 6 24)
          (set! vector-init-loop.26 tmp.107)))
      (begin
        (begin (set! tmp.143 (alloc 24)) (set! tmp.108 (+ tmp.143 2)))
        (begin
          (mset! tmp.108 -2 L.make-init-vector.1.11)
          (mset! tmp.108 6 8)
          (set! make-init-vector.1 tmp.108)))
      (begin
        (begin (set! tmp.144 (alloc 24)) (set! tmp.109 (+ tmp.144 2)))
        (begin
          (mset! tmp.109 -2 L.make-vector.76.12)
          (mset! tmp.109 6 8)
          (set! make-vector.76 tmp.109)))
      (begin
        (begin (set! tmp.145 (alloc 24)) (set! tmp.110 (+ tmp.145 2)))
        (begin
          (mset! tmp.110 -2 L.fun/vector18001.4.13)
          (mset! tmp.110 6 0)
          (set! fun/vector18001.4 tmp.110)))
      (begin
        (begin (set! tmp.146 (alloc 24)) (set! tmp.111 (+ tmp.146 2)))
        (begin
          (mset! tmp.111 -2 L.fun/vector17999.5.14)
          (mset! tmp.111 6 0)
          (set! fun/vector17999.5 tmp.111)))
      (begin
        (begin (set! tmp.147 (alloc 24)) (set! tmp.112 (+ tmp.147 2)))
        (begin
          (mset! tmp.112 -2 L.fun/vector17998.6.15)
          (mset! tmp.112 6 0)
          (set! fun/vector17998.6 tmp.112)))
      (begin
        (begin (set! tmp.148 (alloc 24)) (set! tmp.113 (+ tmp.148 2)))
        (begin
          (mset! tmp.113 -2 L.fun/ascii-char18008.7.16)
          (mset! tmp.113 6 0)
          (set! fun/ascii-char18008.7 tmp.113)))
      (begin
        (begin (set! tmp.149 (alloc 24)) (set! tmp.114 (+ tmp.149 2)))
        (begin
          (mset! tmp.114 -2 L.fun/void18006.8.17)
          (mset! tmp.114 6 0)
          (set! fun/void18006.8 tmp.114)))
      (begin
        (begin (set! tmp.150 (alloc 24)) (set! tmp.115 (+ tmp.150 2)))
        (begin
          (mset! tmp.115 -2 L.fun/any18002.9.18)
          (mset! tmp.115 6 0)
          (set! fun/any18002.9 tmp.115)))
      (begin
        (begin (set! tmp.151 (alloc 16)) (set! tmp.116 (+ tmp.151 2)))
        (begin
          (mset! tmp.116 -2 L.fun/empty17997.10.19)
          (mset! tmp.116 6 0)
          (set! fun/empty17997.10 tmp.116)))
      (begin
        (begin (set! tmp.152 (alloc 16)) (set! tmp.117 (+ tmp.152 2)))
        (begin
          (mset! tmp.117 -2 L.fun/any18005.11.20)
          (mset! tmp.117 6 0)
          (set! fun/any18005.11 tmp.117)))
      (begin
        (begin (set! tmp.153 (alloc 16)) (set! tmp.118 (+ tmp.153 2)))
        (begin
          (mset! tmp.118 -2 L.fun/void18007.12.21)
          (mset! tmp.118 6 0)
          (set! fun/void18007.12 tmp.118)))
      (begin
        (begin (set! tmp.154 (alloc 24)) (set! tmp.119 (+ tmp.154 2)))
        (begin
          (mset! tmp.119 -2 L.fun/any18004.13.22)
          (mset! tmp.119 6 0)
          (set! fun/any18004.13 tmp.119)))
      (begin
        (begin (set! tmp.155 (alloc 24)) (set! tmp.120 (+ tmp.155 2)))
        (begin
          (mset! tmp.120 -2 L.fun/any18003.14.23)
          (mset! tmp.120 6 0)
          (set! fun/any18003.14 tmp.120)))
      (begin
        (begin (set! tmp.156 (alloc 24)) (set! tmp.121 (+ tmp.156 2)))
        (begin
          (mset! tmp.121 -2 L.fun/vector18000.15.24)
          (mset! tmp.121 6 0)
          (set! fun/vector18000.15 tmp.121)))
      (begin
        (begin (set! tmp.157 (alloc 24)) (set! tmp.122 (+ tmp.157 2)))
        (begin
          (mset! tmp.122 -2 L.fun/empty17996.16.25)
          (mset! tmp.122 6 0)
          (set! fun/empty17996.16 tmp.122)))
      (begin
        (begin (set! tmp.158 (alloc 16)) (set! tmp.123 (+ tmp.158 2)))
        (begin
          (mset! tmp.123 -2 L.fun/ascii-char18009.17.26)
          (mset! tmp.123 6 0)
          (set! fun/ascii-char18009.17 tmp.123)))
      (begin
        (mset! vector-init-loop.26 14 vector-init-loop.26)
        (mset! make-init-vector.1 14 vector-init-loop.26)
        (mset! make-vector.76 14 make-init-vector.1)
        (mset! fun/vector18001.4 14 make-vector.76)
        (mset! fun/vector17999.5 14 make-vector.76)
        (mset! fun/vector17998.6 14 fun/vector17999.5)
        (mset! fun/ascii-char18008.7 14 fun/ascii-char18009.17)
        (mset! fun/void18006.8 14 fun/void18007.12)
        (mset! fun/any18002.9 14 fun/any18003.14)
        (mset! fun/any18004.13 14 fun/any18005.11)
        (mset! fun/any18003.14 14 cons.77)
        (mset! fun/vector18000.15 14 fun/vector18001.4)
        (mset! fun/empty17996.16 14 fun/empty17997.10)
        (begin
          (begin
            (begin
              (begin (set! tmp.159 (alloc 24)) (set! tmp.124 (+ tmp.159 2)))
              (begin
                (mset! tmp.124 -2 L.lam.80.27)
                (mset! tmp.124 6 0)
                (set! lam.80 tmp.124)))
            (begin
              (mset! lam.80 14 fun/empty17996.16)
              (set! procedure0.23 lam.80)))
          (set! vector1.22 (call L.fun/vector17998.6.15 fun/vector17998.6))
          (set! vector2.21 (call L.fun/vector18000.15.24 fun/vector18000.15))
          (begin
            (set! tmp.160 (call L.fun/any18002.9.18 fun/any18002.9))
            (set! boolean3.20 (call L.vector?.78.8 vector?.78 tmp.160)))
          (begin
            (set! tmp.161 (call L.fun/any18004.13.22 fun/any18004.13))
            (set! boolean4.19 (call L.void?.79.7 void?.79 tmp.161)))
          (set! void5.18 (call L.fun/void18006.8.17 fun/void18006.8))
          (call L.fun/ascii-char18008.7.16 fun/ascii-char18008.7))))))
(check-by-interp
 '(module
    (define L.fun/void18495.15.21 (lambda (c.91) (begin 30)))
    (define L.fun/void18488.14.20
      (lambda (c.90)
        (begin
          (set! fun/void18489.10 (mref c.90 14))
          (call L.fun/void18489.10.16 fun/void18489.10))))
    (define L.fun/ascii-char18493.13.19 (lambda (c.89) (begin 20782)))
    (define L.fun/error18496.12.18
      (lambda (c.88)
        (begin
          (set! fun/error18497.6 (mref c.88 14))
          (call L.fun/error18497.6.12 fun/error18497.6))))
    (define L.fun/empty18498.11.17
      (lambda (c.87)
        (begin
          (set! fun/empty18499.5 (mref c.87 14))
          (call L.fun/empty18499.5.11 fun/empty18499.5))))
    (define L.fun/void18489.10.16 (lambda (c.86) (begin 30)))
    (define L.fun/void18494.9.15
      (lambda (c.85)
        (begin
          (set! fun/void18495.15 (mref c.85 14))
          (call L.fun/void18495.15.21 fun/void18495.15))))
    (define L.fun/error18491.8.14 (lambda (c.84) (begin 47678)))
    (define L.fun/ascii-char18492.7.13
      (lambda (c.83)
        (begin
          (set! fun/ascii-char18493.13 (mref c.83 14))
          (call L.fun/ascii-char18493.13.19 fun/ascii-char18493.13))))
    (define L.fun/error18497.6.12 (lambda (c.82) (begin 25150)))
    (define L.fun/empty18499.5.11 (lambda (c.81) (begin 22)))
    (define L.fun/error18490.4.10
      (lambda (c.80)
        (begin
          (set! fun/error18491.8 (mref c.80 14))
          (call L.fun/error18491.8.14 fun/error18491.8))))
    (define L.*.74.9
      (lambda (c.79 tmp.36 tmp.37)
        (begin
          (if (begin
                (if (begin (set! tmp.108 (bitwise-and tmp.37 7)) (= tmp.108 0))
                  (set! tmp.107 14)
                  (set! tmp.107 6))
                (!= tmp.107 6))
            (if (begin
                  (if (begin
                        (set! tmp.110 (bitwise-and tmp.36 7))
                        (= tmp.110 0))
                    (set! tmp.109 14)
                    (set! tmp.109 6))
                  (!= tmp.109 6))
              (begin
                (set! tmp.111 (arithmetic-shift-right tmp.37 3))
                (* tmp.36 tmp.111))
              318)
            318))))
    (define L.-.75.8
      (lambda (c.78 tmp.40 tmp.41)
        (begin
          (if (begin
                (if (begin (set! tmp.113 (bitwise-and tmp.41 7)) (= tmp.113 0))
                  (set! tmp.112 14)
                  (set! tmp.112 6))
                (!= tmp.112 6))
            (if (begin
                  (if (begin
                        (set! tmp.115 (bitwise-and tmp.40 7))
                        (= tmp.115 0))
                    (set! tmp.114 14)
                    (set! tmp.114 6))
                  (!= tmp.114 6))
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.+.76.7
      (lambda (c.77 tmp.38 tmp.39)
        (begin
          (if (begin
                (if (begin (set! tmp.117 (bitwise-and tmp.39 7)) (= tmp.117 0))
                  (set! tmp.116 14)
                  (set! tmp.116 6))
                (!= tmp.116 6))
            (if (begin
                  (if (begin
                        (set! tmp.119 (bitwise-and tmp.38 7))
                        (= tmp.119 0))
                    (set! tmp.118 14)
                    (set! tmp.118 6))
                  (!= tmp.118 6))
              (+ tmp.38 tmp.39)
              574)
            574))))
    (begin
      (begin
        (begin (set! tmp.120 (alloc 16)) (set! tmp.92 (+ tmp.120 2)))
        (begin
          (mset! tmp.92 -2 L.+.76.7)
          (mset! tmp.92 6 16)
          (set! |+.76| tmp.92)))
      (begin
        (begin (set! tmp.121 (alloc 16)) (set! tmp.93 (+ tmp.121 2)))
        (begin
          (mset! tmp.93 -2 L.-.75.8)
          (mset! tmp.93 6 16)
          (set! |-.75| tmp.93)))
      (begin
        (begin (set! tmp.122 (alloc 16)) (set! tmp.94 (+ tmp.122 2)))
        (begin
          (mset! tmp.94 -2 L.*.74.9)
          (mset! tmp.94 6 16)
          (set! *.74 tmp.94)))
      (begin
        (begin (set! tmp.123 (alloc 24)) (set! tmp.95 (+ tmp.123 2)))
        (begin
          (mset! tmp.95 -2 L.fun/error18490.4.10)
          (mset! tmp.95 6 0)
          (set! fun/error18490.4 tmp.95)))
      (begin
        (begin (set! tmp.124 (alloc 16)) (set! tmp.96 (+ tmp.124 2)))
        (begin
          (mset! tmp.96 -2 L.fun/empty18499.5.11)
          (mset! tmp.96 6 0)
          (set! fun/empty18499.5 tmp.96)))
      (begin
        (begin (set! tmp.125 (alloc 16)) (set! tmp.97 (+ tmp.125 2)))
        (begin
          (mset! tmp.97 -2 L.fun/error18497.6.12)
          (mset! tmp.97 6 0)
          (set! fun/error18497.6 tmp.97)))
      (begin
        (begin (set! tmp.126 (alloc 24)) (set! tmp.98 (+ tmp.126 2)))
        (begin
          (mset! tmp.98 -2 L.fun/ascii-char18492.7.13)
          (mset! tmp.98 6 0)
          (set! fun/ascii-char18492.7 tmp.98)))
      (begin
        (begin (set! tmp.127 (alloc 16)) (set! tmp.99 (+ tmp.127 2)))
        (begin
          (mset! tmp.99 -2 L.fun/error18491.8.14)
          (mset! tmp.99 6 0)
          (set! fun/error18491.8 tmp.99)))
      (begin
        (begin (set! tmp.128 (alloc 24)) (set! tmp.100 (+ tmp.128 2)))
        (begin
          (mset! tmp.100 -2 L.fun/void18494.9.15)
          (mset! tmp.100 6 0)
          (set! fun/void18494.9 tmp.100)))
      (begin
        (begin (set! tmp.129 (alloc 16)) (set! tmp.101 (+ tmp.129 2)))
        (begin
          (mset! tmp.101 -2 L.fun/void18489.10.16)
          (mset! tmp.101 6 0)
          (set! fun/void18489.10 tmp.101)))
      (begin
        (begin (set! tmp.130 (alloc 24)) (set! tmp.102 (+ tmp.130 2)))
        (begin
          (mset! tmp.102 -2 L.fun/empty18498.11.17)
          (mset! tmp.102 6 0)
          (set! fun/empty18498.11 tmp.102)))
      (begin
        (begin (set! tmp.131 (alloc 24)) (set! tmp.103 (+ tmp.131 2)))
        (begin
          (mset! tmp.103 -2 L.fun/error18496.12.18)
          (mset! tmp.103 6 0)
          (set! fun/error18496.12 tmp.103)))
      (begin
        (begin (set! tmp.132 (alloc 16)) (set! tmp.104 (+ tmp.132 2)))
        (begin
          (mset! tmp.104 -2 L.fun/ascii-char18493.13.19)
          (mset! tmp.104 6 0)
          (set! fun/ascii-char18493.13 tmp.104)))
      (begin
        (begin (set! tmp.133 (alloc 24)) (set! tmp.105 (+ tmp.133 2)))
        (begin
          (mset! tmp.105 -2 L.fun/void18488.14.20)
          (mset! tmp.105 6 0)
          (set! fun/void18488.14 tmp.105)))
      (begin
        (begin (set! tmp.134 (alloc 16)) (set! tmp.106 (+ tmp.134 2)))
        (begin
          (mset! tmp.106 -2 L.fun/void18495.15.21)
          (mset! tmp.106 6 0)
          (set! fun/void18495.15 tmp.106)))
      (begin
        (mset! fun/error18490.4 14 fun/error18491.8)
        (mset! fun/ascii-char18492.7 14 fun/ascii-char18493.13)
        (mset! fun/void18494.9 14 fun/void18495.15)
        (mset! fun/empty18498.11 14 fun/empty18499.5)
        (mset! fun/error18496.12 14 fun/error18497.6)
        (mset! fun/void18488.14 14 fun/void18489.10)
        (begin
          (set! void0.21 (call L.fun/void18488.14.20 fun/void18488.14))
          (set! error1.20 (call L.fun/error18490.4.10 fun/error18490.4))
          (begin
            (begin
              (begin
                (set! tmp.137 (call L.*.74.9 *.74 704 1000))
                (begin
                  (set! tmp.138 (call L.-.75.8 |-.75| 1760 1240))
                  (set! tmp.136 (call L.*.74.9 *.74 tmp.137 tmp.138))))
              (begin
                (begin
                  (set! tmp.140 (call L.-.75.8 |-.75| 1152 1792))
                  (begin
                    (set! tmp.141 (call L.*.74.9 *.74 1488 992))
                    (set! tmp.139 (call L.-.75.8 |-.75| tmp.140 tmp.141))))
                (set! tmp.135 (call L.-.75.8 |-.75| tmp.136 tmp.139))))
            (begin
              (begin
                (begin
                  (set! tmp.144 (call L.-.75.8 |-.75| 776 1520))
                  (begin
                    (set! tmp.145 (call L.*.74.9 *.74 1688 1176))
                    (set! tmp.143 (call L.-.75.8 |-.75| tmp.144 tmp.145))))
                (begin
                  (begin
                    (set! tmp.147 (call L.*.74.9 *.74 1400 1224))
                    (begin
                      (set! tmp.148 (call L.*.74.9 *.74 1008 1272))
                      (set! tmp.146 (call L.+.76.7 |+.76| tmp.147 tmp.148))))
                  (set! tmp.142 (call L.-.75.8 |-.75| tmp.143 tmp.146))))
              (set! fixnum2.19 (call L.*.74.9 *.74 tmp.135 tmp.142))))
          (set! ascii-char3.18
            (call L.fun/ascii-char18492.7.13 fun/ascii-char18492.7))
          (set! void4.17 (call L.fun/void18494.9.15 fun/void18494.9))
          (set! error5.16 (call L.fun/error18496.12.18 fun/error18496.12))
          (call L.fun/empty18498.11.17 fun/empty18498.11))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char22594.17.21
      (lambda (c.91)
        (begin
          (set! fun/ascii-char22595.5 (mref c.91 14))
          (call L.fun/ascii-char22595.5.9 fun/ascii-char22595.5))))
    (define L.fun/empty22596.16.20
      (lambda (c.90)
        (begin
          (set! fun/empty22597.10 (mref c.90 14))
          (call L.fun/empty22597.10.14 fun/empty22597.10))))
    (define L.fun/empty22598.15.19
      (lambda (c.89)
        (begin
          (set! fun/empty22599.8 (mref c.89 14))
          (call L.fun/empty22599.8.12 fun/empty22599.8))))
    (define L.fun/error22592.14.18
      (lambda (c.88)
        (begin
          (set! fun/error22593.12 (mref c.88 14))
          (call L.fun/error22593.12.16 fun/error22593.12))))
    (define L.fun/pair22600.13.17
      (lambda (c.87)
        (begin
          (set! fun/pair22601.6 (mref c.87 14))
          (call L.fun/pair22601.6.10 fun/pair22601.6))))
    (define L.fun/error22593.12.16 (lambda (c.86) (begin 5694)))
    (define L.fun/ascii-char22588.11.15
      (lambda (c.85)
        (begin
          (set! fun/ascii-char22589.7 (mref c.85 14))
          (call L.fun/ascii-char22589.7.11 fun/ascii-char22589.7))))
    (define L.fun/empty22597.10.14 (lambda (c.84) (begin 22)))
    (define L.fun/empty22591.9.13 (lambda (c.83) (begin 22)))
    (define L.fun/empty22599.8.12 (lambda (c.82) (begin 22)))
    (define L.fun/ascii-char22589.7.11 (lambda (c.81) (begin 23342)))
    (define L.fun/pair22601.6.10
      (lambda (c.80)
        (begin
          (set! cons.76 (mref c.80 14))
          (call L.cons.76.7 cons.76 800 3704))))
    (define L.fun/ascii-char22595.5.9 (lambda (c.79) (begin 25134)))
    (define L.fun/empty22590.4.8
      (lambda (c.78)
        (begin
          (set! fun/empty22591.9 (mref c.78 14))
          (call L.fun/empty22591.9.13 fun/empty22591.9))))
    (define L.cons.76.7
      (lambda (c.77 tmp.71 tmp.72)
        (begin
          (begin
            (begin (set! tmp.108 (alloc 16)) (set! tmp.92 (+ tmp.108 1)))
            (begin (mset! tmp.92 -1 tmp.71) (mset! tmp.92 7 tmp.72) tmp.92)))))
    (begin
      (begin
        (begin (set! tmp.109 (alloc 16)) (set! tmp.93 (+ tmp.109 2)))
        (begin
          (mset! tmp.93 -2 L.cons.76.7)
          (mset! tmp.93 6 16)
          (set! cons.76 tmp.93)))
      (begin
        (begin (set! tmp.110 (alloc 24)) (set! tmp.94 (+ tmp.110 2)))
        (begin
          (mset! tmp.94 -2 L.fun/empty22590.4.8)
          (mset! tmp.94 6 0)
          (set! fun/empty22590.4 tmp.94)))
      (begin
        (begin (set! tmp.111 (alloc 16)) (set! tmp.95 (+ tmp.111 2)))
        (begin
          (mset! tmp.95 -2 L.fun/ascii-char22595.5.9)
          (mset! tmp.95 6 0)
          (set! fun/ascii-char22595.5 tmp.95)))
      (begin
        (begin (set! tmp.112 (alloc 24)) (set! tmp.96 (+ tmp.112 2)))
        (begin
          (mset! tmp.96 -2 L.fun/pair22601.6.10)
          (mset! tmp.96 6 0)
          (set! fun/pair22601.6 tmp.96)))
      (begin
        (begin (set! tmp.113 (alloc 16)) (set! tmp.97 (+ tmp.113 2)))
        (begin
          (mset! tmp.97 -2 L.fun/ascii-char22589.7.11)
          (mset! tmp.97 6 0)
          (set! fun/ascii-char22589.7 tmp.97)))
      (begin
        (begin (set! tmp.114 (alloc 16)) (set! tmp.98 (+ tmp.114 2)))
        (begin
          (mset! tmp.98 -2 L.fun/empty22599.8.12)
          (mset! tmp.98 6 0)
          (set! fun/empty22599.8 tmp.98)))
      (begin
        (begin (set! tmp.115 (alloc 16)) (set! tmp.99 (+ tmp.115 2)))
        (begin
          (mset! tmp.99 -2 L.fun/empty22591.9.13)
          (mset! tmp.99 6 0)
          (set! fun/empty22591.9 tmp.99)))
      (begin
        (begin (set! tmp.116 (alloc 16)) (set! tmp.100 (+ tmp.116 2)))
        (begin
          (mset! tmp.100 -2 L.fun/empty22597.10.14)
          (mset! tmp.100 6 0)
          (set! fun/empty22597.10 tmp.100)))
      (begin
        (begin (set! tmp.117 (alloc 24)) (set! tmp.101 (+ tmp.117 2)))
        (begin
          (mset! tmp.101 -2 L.fun/ascii-char22588.11.15)
          (mset! tmp.101 6 0)
          (set! fun/ascii-char22588.11 tmp.101)))
      (begin
        (begin (set! tmp.118 (alloc 16)) (set! tmp.102 (+ tmp.118 2)))
        (begin
          (mset! tmp.102 -2 L.fun/error22593.12.16)
          (mset! tmp.102 6 0)
          (set! fun/error22593.12 tmp.102)))
      (begin
        (begin (set! tmp.119 (alloc 24)) (set! tmp.103 (+ tmp.119 2)))
        (begin
          (mset! tmp.103 -2 L.fun/pair22600.13.17)
          (mset! tmp.103 6 0)
          (set! fun/pair22600.13 tmp.103)))
      (begin
        (begin (set! tmp.120 (alloc 24)) (set! tmp.104 (+ tmp.120 2)))
        (begin
          (mset! tmp.104 -2 L.fun/error22592.14.18)
          (mset! tmp.104 6 0)
          (set! fun/error22592.14 tmp.104)))
      (begin
        (begin (set! tmp.121 (alloc 24)) (set! tmp.105 (+ tmp.121 2)))
        (begin
          (mset! tmp.105 -2 L.fun/empty22598.15.19)
          (mset! tmp.105 6 0)
          (set! fun/empty22598.15 tmp.105)))
      (begin
        (begin (set! tmp.122 (alloc 24)) (set! tmp.106 (+ tmp.122 2)))
        (begin
          (mset! tmp.106 -2 L.fun/empty22596.16.20)
          (mset! tmp.106 6 0)
          (set! fun/empty22596.16 tmp.106)))
      (begin
        (begin (set! tmp.123 (alloc 24)) (set! tmp.107 (+ tmp.123 2)))
        (begin
          (mset! tmp.107 -2 L.fun/ascii-char22594.17.21)
          (mset! tmp.107 6 0)
          (set! fun/ascii-char22594.17 tmp.107)))
      (begin
        (mset! fun/empty22590.4 14 fun/empty22591.9)
        (mset! fun/pair22601.6 14 cons.76)
        (mset! fun/ascii-char22588.11 14 fun/ascii-char22589.7)
        (mset! fun/pair22600.13 14 fun/pair22601.6)
        (mset! fun/error22592.14 14 fun/error22593.12)
        (mset! fun/empty22598.15 14 fun/empty22599.8)
        (mset! fun/empty22596.16 14 fun/empty22597.10)
        (mset! fun/ascii-char22594.17 14 fun/ascii-char22595.5)
        (begin
          (set! ascii-char0.23
            (call L.fun/ascii-char22588.11.15 fun/ascii-char22588.11))
          (set! empty1.22 (call L.fun/empty22590.4.8 fun/empty22590.4))
          (set! error2.21 (call L.fun/error22592.14.18 fun/error22592.14))
          (set! ascii-char3.20
            (call L.fun/ascii-char22594.17.21 fun/ascii-char22594.17))
          (set! empty4.19 (call L.fun/empty22596.16.20 fun/empty22596.16))
          (set! empty5.18 (call L.fun/empty22598.15.19 fun/empty22598.15))
          (call L.fun/pair22600.13.17 fun/pair22600.13))))))
(check-by-interp
 '(module
    (define L.lam.76.21
      (lambda (c.91)
        (begin
          (set! fun/void23352.11 (mref c.91 14))
          (call L.fun/void23352.11.19 fun/void23352.11))))
    (define L.lam.75.20
      (lambda (c.90)
        (begin
          (set! *.74 (mref c.90 14))
          (set! |-.72| (mref c.90 22))
          (set! |+.73| (mref c.90 30))
          (begin
            (begin
              (begin
                (set! tmp.110 (call L.-.72.9 |-.72| 1912 944))
                (begin
                  (set! tmp.111 (call L.-.72.9 |-.72| 304 1224))
                  (set! tmp.109 (call L.+.73.8 |+.73| tmp.110 tmp.111))))
              (begin
                (begin
                  (set! tmp.113 (call L.*.74.7 *.74 1024 1432))
                  (begin
                    (set! tmp.114 (call L.-.72.9 |-.72| 1664 1736))
                    (set! tmp.112 (call L.+.73.8 |+.73| tmp.113 tmp.114))))
                (set! tmp.108 (call L.+.73.8 |+.73| tmp.109 tmp.112))))
            (begin
              (begin
                (begin
                  (set! tmp.117 (call L.-.72.9 |-.72| 968 1216))
                  (begin
                    (set! tmp.118 (call L.*.74.7 *.74 1696 64))
                    (set! tmp.116 (call L.+.73.8 |+.73| tmp.117 tmp.118))))
                (begin
                  (begin
                    (set! tmp.120 (call L.*.74.7 *.74 1400 656))
                    (begin
                      (set! tmp.121 (call L.-.72.9 |-.72| 416 1432))
                      (set! tmp.119 (call L.*.74.7 *.74 tmp.120 tmp.121))))
                  (set! tmp.115 (call L.-.72.9 |-.72| tmp.116 tmp.119))))
              (call L.+.73.8 |+.73| tmp.108 tmp.115))))))
    (define L.fun/void23352.11.19
      (lambda (c.89)
        (begin
          (set! fun/void23353.10 (mref c.89 14))
          (call L.fun/void23353.10.18 fun/void23353.10))))
    (define L.fun/void23353.10.18 (lambda (c.88) (begin 30)))
    (define L.fun/ascii-char23346.9.17
      (lambda (c.87)
        (begin
          (set! fun/ascii-char23347.8 (mref c.87 14))
          (call L.fun/ascii-char23347.8.16 fun/ascii-char23347.8))))
    (define L.fun/ascii-char23347.8.16 (lambda (c.86) (begin 23598)))
    (define L.fun/any23350.7.15
      (lambda (c.85)
        (begin
          (set! fun/any23351.5 (mref c.85 14))
          (call L.fun/any23351.5.13 fun/any23351.5))))
    (define L.fun/void23348.6.14
      (lambda (c.84)
        (begin
          (set! fun/void23349.4 (mref c.84 14))
          (call L.fun/void23349.4.12 fun/void23349.4))))
    (define L.fun/any23351.5.13
      (lambda (c.83)
        (begin
          (set! cons.70 (mref c.83 14))
          (call L.cons.70.11 cons.70 1272 3184))))
    (define L.fun/void23349.4.12 (lambda (c.82) (begin 30)))
    (define L.cons.70.11
      (lambda (c.81 tmp.65 tmp.66)
        (begin
          (begin
            (begin (set! tmp.122 (alloc 16)) (set! tmp.92 (+ tmp.122 1)))
            (begin (mset! tmp.92 -1 tmp.65) (mset! tmp.92 7 tmp.66) tmp.92)))))
    (define L.boolean?.71.10
      (lambda (c.80 tmp.56)
        (begin
          (if (begin (set! tmp.123 (bitwise-and tmp.56 247)) (= tmp.123 6))
            14
            6))))
    (define L.-.72.9
      (lambda (c.79 tmp.36 tmp.37)
        (begin
          (if (begin
                (if (begin (set! tmp.125 (bitwise-and tmp.37 7)) (= tmp.125 0))
                  (set! tmp.124 14)
                  (set! tmp.124 6))
                (!= tmp.124 6))
            (if (begin
                  (if (begin
                        (set! tmp.127 (bitwise-and tmp.36 7))
                        (= tmp.127 0))
                    (set! tmp.126 14)
                    (set! tmp.126 6))
                  (!= tmp.126 6))
              (- tmp.36 tmp.37)
              830)
            830))))
    (define L.+.73.8
      (lambda (c.78 tmp.34 tmp.35)
        (begin
          (if (begin
                (if (begin (set! tmp.129 (bitwise-and tmp.35 7)) (= tmp.129 0))
                  (set! tmp.128 14)
                  (set! tmp.128 6))
                (!= tmp.128 6))
            (if (begin
                  (if (begin
                        (set! tmp.131 (bitwise-and tmp.34 7))
                        (= tmp.131 0))
                    (set! tmp.130 14)
                    (set! tmp.130 6))
                  (!= tmp.130 6))
              (+ tmp.34 tmp.35)
              574)
            574))))
    (define L.*.74.7
      (lambda (c.77 tmp.32 tmp.33)
        (begin
          (if (begin
                (if (begin (set! tmp.133 (bitwise-and tmp.33 7)) (= tmp.133 0))
                  (set! tmp.132 14)
                  (set! tmp.132 6))
                (!= tmp.132 6))
            (if (begin
                  (if (begin
                        (set! tmp.135 (bitwise-and tmp.32 7))
                        (= tmp.135 0))
                    (set! tmp.134 14)
                    (set! tmp.134 6))
                  (!= tmp.134 6))
              (begin
                (set! tmp.136 (arithmetic-shift-right tmp.33 3))
                (* tmp.32 tmp.136))
              318)
            318))))
    (begin
      (begin
        (begin (set! tmp.137 (alloc 16)) (set! tmp.93 (+ tmp.137 2)))
        (begin
          (mset! tmp.93 -2 L.*.74.7)
          (mset! tmp.93 6 16)
          (set! *.74 tmp.93)))
      (begin
        (begin (set! tmp.138 (alloc 16)) (set! tmp.94 (+ tmp.138 2)))
        (begin
          (mset! tmp.94 -2 L.+.73.8)
          (mset! tmp.94 6 16)
          (set! |+.73| tmp.94)))
      (begin
        (begin (set! tmp.139 (alloc 16)) (set! tmp.95 (+ tmp.139 2)))
        (begin
          (mset! tmp.95 -2 L.-.72.9)
          (mset! tmp.95 6 16)
          (set! |-.72| tmp.95)))
      (begin
        (begin (set! tmp.140 (alloc 16)) (set! tmp.96 (+ tmp.140 2)))
        (begin
          (mset! tmp.96 -2 L.boolean?.71.10)
          (mset! tmp.96 6 8)
          (set! boolean?.71 tmp.96)))
      (begin
        (begin (set! tmp.141 (alloc 16)) (set! tmp.97 (+ tmp.141 2)))
        (begin
          (mset! tmp.97 -2 L.cons.70.11)
          (mset! tmp.97 6 16)
          (set! cons.70 tmp.97)))
      (begin
        (begin (set! tmp.142 (alloc 16)) (set! tmp.98 (+ tmp.142 2)))
        (begin
          (mset! tmp.98 -2 L.fun/void23349.4.12)
          (mset! tmp.98 6 0)
          (set! fun/void23349.4 tmp.98)))
      (begin
        (begin (set! tmp.143 (alloc 24)) (set! tmp.99 (+ tmp.143 2)))
        (begin
          (mset! tmp.99 -2 L.fun/any23351.5.13)
          (mset! tmp.99 6 0)
          (set! fun/any23351.5 tmp.99)))
      (begin
        (begin (set! tmp.144 (alloc 24)) (set! tmp.100 (+ tmp.144 2)))
        (begin
          (mset! tmp.100 -2 L.fun/void23348.6.14)
          (mset! tmp.100 6 0)
          (set! fun/void23348.6 tmp.100)))
      (begin
        (begin (set! tmp.145 (alloc 24)) (set! tmp.101 (+ tmp.145 2)))
        (begin
          (mset! tmp.101 -2 L.fun/any23350.7.15)
          (mset! tmp.101 6 0)
          (set! fun/any23350.7 tmp.101)))
      (begin
        (begin (set! tmp.146 (alloc 16)) (set! tmp.102 (+ tmp.146 2)))
        (begin
          (mset! tmp.102 -2 L.fun/ascii-char23347.8.16)
          (mset! tmp.102 6 0)
          (set! fun/ascii-char23347.8 tmp.102)))
      (begin
        (begin (set! tmp.147 (alloc 24)) (set! tmp.103 (+ tmp.147 2)))
        (begin
          (mset! tmp.103 -2 L.fun/ascii-char23346.9.17)
          (mset! tmp.103 6 0)
          (set! fun/ascii-char23346.9 tmp.103)))
      (begin
        (begin (set! tmp.148 (alloc 16)) (set! tmp.104 (+ tmp.148 2)))
        (begin
          (mset! tmp.104 -2 L.fun/void23353.10.18)
          (mset! tmp.104 6 0)
          (set! fun/void23353.10 tmp.104)))
      (begin
        (begin (set! tmp.149 (alloc 24)) (set! tmp.105 (+ tmp.149 2)))
        (begin
          (mset! tmp.105 -2 L.fun/void23352.11.19)
          (mset! tmp.105 6 0)
          (set! fun/void23352.11 tmp.105)))
      (begin
        (mset! fun/any23351.5 14 cons.70)
        (mset! fun/void23348.6 14 fun/void23349.4)
        (mset! fun/any23350.7 14 fun/any23351.5)
        (mset! fun/ascii-char23346.9 14 fun/ascii-char23347.8)
        (mset! fun/void23352.11 14 fun/void23353.10)
        (begin
          (set! ascii-char0.17
            (call L.fun/ascii-char23346.9.17 fun/ascii-char23346.9))
          (set! void1.16 (call L.fun/void23348.6.14 fun/void23348.6))
          (begin
            (set! tmp.150 (call L.fun/any23350.7.15 fun/any23350.7))
            (set! boolean2.15 (call L.boolean?.71.10 boolean?.71 tmp.150)))
          (begin
            (begin
              (begin (set! tmp.151 (alloc 40)) (set! tmp.106 (+ tmp.151 2)))
              (begin
                (mset! tmp.106 -2 L.lam.75.20)
                (mset! tmp.106 6 0)
                (set! lam.75 tmp.106)))
            (begin
              (mset! lam.75 14 *.74)
              (mset! lam.75 22 |-.72|)
              (mset! lam.75 30 |+.73|)
              (set! procedure3.14 lam.75)))
          (begin
            (begin
              (begin
                (set! tmp.154 (call L.-.72.9 |-.72| 800 640))
                (begin
                  (set! tmp.155 (call L.+.73.8 |+.73| 320 744))
                  (set! tmp.153 (call L.*.74.7 *.74 tmp.154 tmp.155))))
              (begin
                (begin
                  (set! tmp.157 (call L.-.72.9 |-.72| 1304 736))
                  (begin
                    (set! tmp.158 (call L.-.72.9 |-.72| 1840 824))
                    (set! tmp.156 (call L.+.73.8 |+.73| tmp.157 tmp.158))))
                (set! tmp.152 (call L.-.72.9 |-.72| tmp.153 tmp.156))))
            (begin
              (begin
                (begin
                  (set! tmp.161 (call L.-.72.9 |-.72| 376 488))
                  (begin
                    (set! tmp.162 (call L.-.72.9 |-.72| 1112 192))
                    (set! tmp.160 (call L.-.72.9 |-.72| tmp.161 tmp.162))))
                (begin
                  (begin
                    (set! tmp.164 (call L.*.74.7 *.74 824 1056))
                    (begin
                      (set! tmp.165 (call L.+.73.8 |+.73| 1120 760))
                      (set! tmp.163 (call L.+.73.8 |+.73| tmp.164 tmp.165))))
                  (set! tmp.159 (call L.-.72.9 |-.72| tmp.160 tmp.163))))
              (set! fixnum4.13 (call L.*.74.7 *.74 tmp.152 tmp.159))))
          (begin
            (begin
              (begin (set! tmp.166 (alloc 24)) (set! tmp.107 (+ tmp.166 2)))
              (begin
                (mset! tmp.107 -2 L.lam.76.21)
                (mset! tmp.107 6 0)
                (set! lam.76 tmp.107)))
            (begin
              (mset! lam.76 14 fun/void23352.11)
              (set! procedure5.12 lam.76)))
          (begin
            (begin
              (if (begin
                    (if (begin
                          (set! tmp.170 (bitwise-and procedure3.14 7))
                          (= tmp.170 2))
                      (set! tmp.169 14)
                      (set! tmp.169 6))
                    (!= tmp.169 6))
                (if (begin
                      (if (begin
                            (set! tmp.172 (mref procedure3.14 6))
                            (= tmp.172 0))
                        (set! tmp.171 14)
                        (set! tmp.171 6))
                      (!= tmp.171 6))
                  (begin
                    (set! tmp.173 (mref procedure3.14 -2))
                    (set! tmp.168 (call tmp.173 procedure3.14)))
                  (set! tmp.168 10814))
                (set! tmp.168 11070))
              (begin
                (if (begin
                      (if (begin
                            (set! tmp.176 (bitwise-and procedure3.14 7))
                            (= tmp.176 2))
                        (set! tmp.175 14)
                        (set! tmp.175 6))
                      (!= tmp.175 6))
                  (if (begin
                        (if (begin
                              (set! tmp.178 (mref procedure3.14 6))
                              (= tmp.178 0))
                          (set! tmp.177 14)
                          (set! tmp.177 6))
                        (!= tmp.177 6))
                    (begin
                      (set! tmp.179 (mref procedure3.14 -2))
                      (set! tmp.174 (call tmp.179 procedure3.14)))
                    (set! tmp.174 10814))
                  (set! tmp.174 11070))
                (set! tmp.167 (call L.*.74.7 *.74 tmp.168 tmp.174))))
            (begin
              (begin
                (begin
                  (set! tmp.182 (call L.*.74.7 *.74 840 1808))
                  (begin
                    (set! tmp.183 (call L.+.73.8 |+.73| 344 648))
                    (set! tmp.181 (call L.*.74.7 *.74 tmp.182 tmp.183))))
                (begin
                  (begin
                    (set! tmp.185 (call L.*.74.7 *.74 1960 1160))
                    (begin
                      (set! tmp.186 (call L.*.74.7 *.74 872 1568))
                      (set! tmp.184 (call L.+.73.8 |+.73| tmp.185 tmp.186))))
                  (set! tmp.180 (call L.+.73.8 |+.73| tmp.181 tmp.184))))
              (call L.-.72.9 |-.72| tmp.167 tmp.180))))))))
(check-by-interp
 '(module
    (define L.lam.80.27
      (lambda (c.101)
        (begin
          (set! fun/void24631.10 (mref c.101 14))
          (call L.fun/void24631.10.20 fun/void24631.10))))
    (define L.lam.79.26
      (lambda (c.100)
        (begin
          (set! fun/empty24629.7 (mref c.100 14))
          (call L.fun/empty24629.7.17 fun/empty24629.7))))
    (define L.fun/vector24626.15.25
      (lambda (c.99)
        (begin
          (set! make-vector.74 (mref c.99 14))
          (call L.make-vector.74.13 make-vector.74 64))))
    (define L.fun/any24627.14.24
      (lambda (c.98)
        (begin
          (set! fun/any24628.5 (mref c.98 14))
          (call L.fun/any24628.5.15 fun/any24628.5))))
    (define L.fun/error24635.13.23
      (lambda (c.97)
        (begin
          (set! fun/error24636.8 (mref c.97 14))
          (call L.fun/error24636.8.18 fun/error24636.8))))
    (define L.fun/error24634.12.22 (lambda (c.96) (begin 19006)))
    (define L.fun/empty24630.11.21 (lambda (c.95) (begin 22)))
    (define L.fun/void24631.10.20
      (lambda (c.94)
        (begin
          (set! fun/void24632.9 (mref c.94 14))
          (call L.fun/void24632.9.19 fun/void24632.9))))
    (define L.fun/void24632.9.19 (lambda (c.93) (begin 30)))
    (define L.fun/error24636.8.18 (lambda (c.92) (begin 52542)))
    (define L.fun/empty24629.7.17
      (lambda (c.91)
        (begin
          (set! fun/empty24630.11 (mref c.91 14))
          (call L.fun/empty24630.11.21 fun/empty24630.11))))
    (define L.fun/error24633.6.16
      (lambda (c.90)
        (begin
          (set! fun/error24634.12 (mref c.90 14))
          (call L.fun/error24634.12.22 fun/error24634.12))))
    (define L.fun/any24628.5.15 (lambda (c.89) (begin 22)))
    (define L.fun/vector24625.4.14
      (lambda (c.88)
        (begin
          (set! fun/vector24626.15 (mref c.88 14))
          (call L.fun/vector24626.15.25 fun/vector24626.15))))
    (define L.make-vector.74.13
      (lambda (c.87 tmp.50)
        (begin
          (set! make-init-vector.1 (mref c.87 14))
          (if (begin
                (if (begin (set! tmp.125 (bitwise-and tmp.50 7)) (= tmp.125 0))
                  (set! tmp.124 14)
                  (set! tmp.124 6))
                (!= tmp.124 6))
            (call L.make-init-vector.1.12 make-init-vector.1 tmp.50)
            2110))))
    (define L.make-init-vector.1.12
      (lambda (c.86 tmp.22)
        (begin
          (set! vector-init-loop.24 (mref c.86 14))
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.129 (arithmetic-shift-right tmp.22 3))
                      (set! tmp.128 (+ 1 tmp.129)))
                    (set! tmp.127 (* tmp.128 8)))
                  (set! tmp.126 (alloc tmp.127)))
                (set! tmp.102 (+ tmp.126 3)))
              (begin (mset! tmp.102 -3 tmp.22) (set! tmp.23 tmp.102)))
            (call
             L.vector-init-loop.24.11
             vector-init-loop.24
             tmp.22
             0
             tmp.23)))))
    (define L.vector-init-loop.24.11
      (lambda (c.85 len.25 i.27 vec.26)
        (begin
          (set! vector-init-loop.24 (mref c.85 14))
          (if (begin
                (if (= len.25 i.27) (set! tmp.130 14) (set! tmp.130 6))
                (!= tmp.130 6))
            vec.26
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.133 (arithmetic-shift-right i.27 3))
                    (set! tmp.132 (* tmp.133 8)))
                  (set! tmp.131 (+ tmp.132 5)))
                (mset! vec.26 tmp.131 0))
              (begin
                (set! tmp.134 (+ i.27 8))
                (call
                 L.vector-init-loop.24.11
                 vector-init-loop.24
                 len.25
                 tmp.134
                 vec.26)))))))
    (define L.*.75.10
      (lambda (c.84 tmp.36 tmp.37)
        (begin
          (if (begin
                (if (begin (set! tmp.136 (bitwise-and tmp.37 7)) (= tmp.136 0))
                  (set! tmp.135 14)
                  (set! tmp.135 6))
                (!= tmp.135 6))
            (if (begin
                  (if (begin
                        (set! tmp.138 (bitwise-and tmp.36 7))
                        (= tmp.138 0))
                    (set! tmp.137 14)
                    (set! tmp.137 6))
                  (!= tmp.137 6))
              (begin
                (set! tmp.139 (arithmetic-shift-right tmp.37 3))
                (* tmp.36 tmp.139))
              318)
            318))))
    (define L.+.76.9
      (lambda (c.83 tmp.38 tmp.39)
        (begin
          (if (begin
                (if (begin (set! tmp.141 (bitwise-and tmp.39 7)) (= tmp.141 0))
                  (set! tmp.140 14)
                  (set! tmp.140 6))
                (!= tmp.140 6))
            (if (begin
                  (if (begin
                        (set! tmp.143 (bitwise-and tmp.38 7))
                        (= tmp.143 0))
                    (set! tmp.142 14)
                    (set! tmp.142 6))
                  (!= tmp.142 6))
              (+ tmp.38 tmp.39)
              574)
            574))))
    (define L.-.77.8
      (lambda (c.82 tmp.40 tmp.41)
        (begin
          (if (begin
                (if (begin (set! tmp.145 (bitwise-and tmp.41 7)) (= tmp.145 0))
                  (set! tmp.144 14)
                  (set! tmp.144 6))
                (!= tmp.144 6))
            (if (begin
                  (if (begin
                        (set! tmp.147 (bitwise-and tmp.40 7))
                        (= tmp.147 0))
                    (set! tmp.146 14)
                    (set! tmp.146 6))
                  (!= tmp.146 6))
              (- tmp.40 tmp.41)
              830)
            830))))
    (define L.empty?.78.7
      (lambda (c.81 tmp.61)
        (begin
          (if (begin (set! tmp.148 (bitwise-and tmp.61 255)) (= tmp.148 22))
            14
            6))))
    (begin
      (begin
        (begin (set! tmp.149 (alloc 16)) (set! tmp.103 (+ tmp.149 2)))
        (begin
          (mset! tmp.103 -2 L.empty?.78.7)
          (mset! tmp.103 6 8)
          (set! empty?.78 tmp.103)))
      (begin
        (begin (set! tmp.150 (alloc 16)) (set! tmp.104 (+ tmp.150 2)))
        (begin
          (mset! tmp.104 -2 L.-.77.8)
          (mset! tmp.104 6 16)
          (set! |-.77| tmp.104)))
      (begin
        (begin (set! tmp.151 (alloc 16)) (set! tmp.105 (+ tmp.151 2)))
        (begin
          (mset! tmp.105 -2 L.+.76.9)
          (mset! tmp.105 6 16)
          (set! |+.76| tmp.105)))
      (begin
        (begin (set! tmp.152 (alloc 16)) (set! tmp.106 (+ tmp.152 2)))
        (begin
          (mset! tmp.106 -2 L.*.75.10)
          (mset! tmp.106 6 16)
          (set! *.75 tmp.106)))
      (begin
        (begin (set! tmp.153 (alloc 24)) (set! tmp.107 (+ tmp.153 2)))
        (begin
          (mset! tmp.107 -2 L.vector-init-loop.24.11)
          (mset! tmp.107 6 24)
          (set! vector-init-loop.24 tmp.107)))
      (begin
        (begin (set! tmp.154 (alloc 24)) (set! tmp.108 (+ tmp.154 2)))
        (begin
          (mset! tmp.108 -2 L.make-init-vector.1.12)
          (mset! tmp.108 6 8)
          (set! make-init-vector.1 tmp.108)))
      (begin
        (begin (set! tmp.155 (alloc 24)) (set! tmp.109 (+ tmp.155 2)))
        (begin
          (mset! tmp.109 -2 L.make-vector.74.13)
          (mset! tmp.109 6 8)
          (set! make-vector.74 tmp.109)))
      (begin
        (begin (set! tmp.156 (alloc 24)) (set! tmp.110 (+ tmp.156 2)))
        (begin
          (mset! tmp.110 -2 L.fun/vector24625.4.14)
          (mset! tmp.110 6 0)
          (set! fun/vector24625.4 tmp.110)))
      (begin
        (begin (set! tmp.157 (alloc 16)) (set! tmp.111 (+ tmp.157 2)))
        (begin
          (mset! tmp.111 -2 L.fun/any24628.5.15)
          (mset! tmp.111 6 0)
          (set! fun/any24628.5 tmp.111)))
      (begin
        (begin (set! tmp.158 (alloc 24)) (set! tmp.112 (+ tmp.158 2)))
        (begin
          (mset! tmp.112 -2 L.fun/error24633.6.16)
          (mset! tmp.112 6 0)
          (set! fun/error24633.6 tmp.112)))
      (begin
        (begin (set! tmp.159 (alloc 24)) (set! tmp.113 (+ tmp.159 2)))
        (begin
          (mset! tmp.113 -2 L.fun/empty24629.7.17)
          (mset! tmp.113 6 0)
          (set! fun/empty24629.7 tmp.113)))
      (begin
        (begin (set! tmp.160 (alloc 16)) (set! tmp.114 (+ tmp.160 2)))
        (begin
          (mset! tmp.114 -2 L.fun/error24636.8.18)
          (mset! tmp.114 6 0)
          (set! fun/error24636.8 tmp.114)))
      (begin
        (begin (set! tmp.161 (alloc 16)) (set! tmp.115 (+ tmp.161 2)))
        (begin
          (mset! tmp.115 -2 L.fun/void24632.9.19)
          (mset! tmp.115 6 0)
          (set! fun/void24632.9 tmp.115)))
      (begin
        (begin (set! tmp.162 (alloc 24)) (set! tmp.116 (+ tmp.162 2)))
        (begin
          (mset! tmp.116 -2 L.fun/void24631.10.20)
          (mset! tmp.116 6 0)
          (set! fun/void24631.10 tmp.116)))
      (begin
        (begin (set! tmp.163 (alloc 16)) (set! tmp.117 (+ tmp.163 2)))
        (begin
          (mset! tmp.117 -2 L.fun/empty24630.11.21)
          (mset! tmp.117 6 0)
          (set! fun/empty24630.11 tmp.117)))
      (begin
        (begin (set! tmp.164 (alloc 16)) (set! tmp.118 (+ tmp.164 2)))
        (begin
          (mset! tmp.118 -2 L.fun/error24634.12.22)
          (mset! tmp.118 6 0)
          (set! fun/error24634.12 tmp.118)))
      (begin
        (begin (set! tmp.165 (alloc 24)) (set! tmp.119 (+ tmp.165 2)))
        (begin
          (mset! tmp.119 -2 L.fun/error24635.13.23)
          (mset! tmp.119 6 0)
          (set! fun/error24635.13 tmp.119)))
      (begin
        (begin (set! tmp.166 (alloc 24)) (set! tmp.120 (+ tmp.166 2)))
        (begin
          (mset! tmp.120 -2 L.fun/any24627.14.24)
          (mset! tmp.120 6 0)
          (set! fun/any24627.14 tmp.120)))
      (begin
        (begin (set! tmp.167 (alloc 24)) (set! tmp.121 (+ tmp.167 2)))
        (begin
          (mset! tmp.121 -2 L.fun/vector24626.15.25)
          (mset! tmp.121 6 0)
          (set! fun/vector24626.15 tmp.121)))
      (begin
        (mset! vector-init-loop.24 14 vector-init-loop.24)
        (mset! make-init-vector.1 14 vector-init-loop.24)
        (mset! make-vector.74 14 make-init-vector.1)
        (mset! fun/vector24625.4 14 fun/vector24626.15)
        (mset! fun/error24633.6 14 fun/error24634.12)
        (mset! fun/empty24629.7 14 fun/empty24630.11)
        (mset! fun/void24631.10 14 fun/void24632.9)
        (mset! fun/error24635.13 14 fun/error24636.8)
        (mset! fun/any24627.14 14 fun/any24628.5)
        (mset! fun/vector24626.15 14 make-vector.74)
        (begin
          (begin
            (begin
              (begin
                (set! tmp.170 (call L.*.75.10 *.75 1184 1160))
                (begin
                  (set! tmp.171 (call L.*.75.10 *.75 1808 352))
                  (set! tmp.169 (call L.+.76.9 |+.76| tmp.170 tmp.171))))
              (begin
                (begin
                  (set! tmp.173 (call L.+.76.9 |+.76| 520 1360))
                  (begin
                    (set! tmp.174 (call L.-.77.8 |-.77| 1032 1168))
                    (set! tmp.172 (call L.*.75.10 *.75 tmp.173 tmp.174))))
                (set! tmp.168 (call L.*.75.10 *.75 tmp.169 tmp.172))))
            (begin
              (begin
                (begin
                  (set! tmp.177 (call L.+.76.9 |+.76| 192 1512))
                  (begin
                    (set! tmp.178 (call L.-.77.8 |-.77| 880 640))
                    (set! tmp.176 (call L.+.76.9 |+.76| tmp.177 tmp.178))))
                (begin
                  (begin
                    (set! tmp.180 (call L.-.77.8 |-.77| 1528 2008))
                    (begin
                      (set! tmp.181 (call L.-.77.8 |-.77| 624 1656))
                      (set! tmp.179 (call L.+.76.9 |+.76| tmp.180 tmp.181))))
                  (set! tmp.175 (call L.+.76.9 |+.76| tmp.176 tmp.179))))
              (set! fixnum0.21 (call L.-.77.8 |-.77| tmp.168 tmp.175))))
          (set! vector1.20 (call L.fun/vector24625.4.14 fun/vector24625.4))
          (begin
            (set! tmp.182 (call L.fun/any24627.14.24 fun/any24627.14))
            (set! boolean2.19 (call L.empty?.78.7 empty?.78 tmp.182)))
          (begin
            (begin
              (begin (set! tmp.183 (alloc 24)) (set! tmp.122 (+ tmp.183 2)))
              (begin
                (mset! tmp.122 -2 L.lam.79.26)
                (mset! tmp.122 6 0)
                (set! lam.79 tmp.122)))
            (begin
              (mset! lam.79 14 fun/empty24629.7)
              (set! procedure3.18 lam.79)))
          (begin
            (begin
              (begin (set! tmp.184 (alloc 24)) (set! tmp.123 (+ tmp.184 2)))
              (begin
                (mset! tmp.123 -2 L.lam.80.27)
                (mset! tmp.123 6 0)
                (set! lam.80 tmp.123)))
            (begin
              (mset! lam.80 14 fun/void24631.10)
              (set! procedure4.17 lam.80)))
          (set! error5.16 (call L.fun/error24633.6.16 fun/error24633.6))
          (call L.fun/error24635.13.23 fun/error24635.13))))))
