#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         "../select-instructions.rkt")
(define (fail-if-invalid p)
  (when (not (asm-alloc-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "asm-alloc-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-imp-cmf-lang-v8 p)
  (interp-asm-alloc-lang-v8 (fail-if-invalid (select-instructions p)))))

(check-by-interp
 '(module
    ((new-frames ()))
    (begin
      (set! tmp-ra.56 r15)
      (begin (set! rax 1384) (jump tmp-ra.56 rbp rax)))))
(check-by-interp
 '(module
    ((new-frames ()))
    (begin
      (set! tmp-ra.56 r15)
      (begin (set! rax 1912) (jump tmp-ra.56 rbp rax)))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/error8447.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (begin
          (set! c.57 rdi)
          (begin (begin (set! rax 59710) (jump tmp-ra.60 rbp rax))))))
    (begin
      (set! tmp-ra.61 r15)
      (begin
        (begin
          (begin (set! tmp.59 (alloc 16)) (set! tmp.58 (+ tmp.59 2)))
          (begin
            (mset! tmp.58 -2 L.fun/error8447.4.7)
            (mset! tmp.58 6 0)
            (set! fun/error8447.4 tmp.58)))
        (begin
          (set! rdi fun/error8447.4)
          (set! r15 tmp-ra.61)
          (jump L.fun/error8447.4.7 rbp r15 rdi))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/fixnum8450.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (begin
          (set! c.57 rdi)
          (begin (begin (set! rax 288) (jump tmp-ra.60 rbp rax))))))
    (begin
      (set! tmp-ra.61 r15)
      (begin
        (begin
          (begin (set! tmp.59 (alloc 16)) (set! tmp.58 (+ tmp.59 2)))
          (begin
            (mset! tmp.58 -2 L.fun/fixnum8450.4.7)
            (mset! tmp.58 6 0)
            (set! fun/fixnum8450.4 tmp.58)))
        (begin
          (set! rdi fun/fixnum8450.4)
          (set! r15 tmp-ra.61)
          (jump L.fun/fixnum8450.4.7 rbp r15 rdi))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/vector8453.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.82 r15)
        (begin
          (set! c.61 rdi)
          (begin
            (set! make-vector.57 (mref c.61 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.57)
              (set! r15 tmp-ra.82)
              (jump L.make-vector.57.9 rbp r15 rdi rsi))))))
    (define L.make-vector.57.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.83 r15)
        (begin
          (set! c.60 rdi)
          (set! tmp.33 rsi)
          (begin
            (set! make-init-vector.1 (mref c.60 14))
            (if (begin
                  (if (begin (set! tmp.68 (bitwise-and tmp.33 7)) (= tmp.68 0))
                    (set! tmp.67 14)
                    (set! tmp.67 6))
                  (!= tmp.67 6))
              (begin
                (set! rsi tmp.33)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.83)
                (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.83 rbp rax)))))))
    (define L.make-init-vector.1.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.84 r15)
        (begin
          (set! c.59 rdi)
          (set! tmp.5 rsi)
          (begin
            (set! vector-init-loop.7 (mref c.59 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.72 (arithmetic-shift-right tmp.5 3))
                        (set! tmp.71 (+ 1 tmp.72)))
                      (set! tmp.70 (* tmp.71 8)))
                    (set! tmp.69 (alloc tmp.70)))
                  (set! tmp.62 (+ tmp.69 3)))
                (begin (mset! tmp.62 -3 tmp.5) (set! tmp.6 tmp.62)))
              (begin
                (set! rcx tmp.6)
                (set! rdx 0)
                (set! rsi tmp.5)
                (set! rdi vector-init-loop.7)
                (set! r15 tmp-ra.84)
                (jump L.vector-init-loop.7.7 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.7.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (begin
          (set! c.58 rdi)
          (set! len.8 rsi)
          (set! i.10 rdx)
          (set! vec.9 rcx)
          (begin
            (set! vector-init-loop.7 (mref c.58 14))
            (if (begin
                  (if (= len.8 i.10) (set! tmp.73 14) (set! tmp.73 6))
                  (!= tmp.73 6))
              (begin (set! rax vec.9) (jump tmp-ra.85 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.76 (arithmetic-shift-right i.10 3))
                      (set! tmp.75 (* tmp.76 8)))
                    (set! tmp.74 (+ tmp.75 5)))
                  (mset! vec.9 tmp.74 0))
                (begin
                  (set! tmp.77 (+ i.10 8))
                  (begin
                    (set! rcx vec.9)
                    (set! rdx tmp.77)
                    (set! rsi len.8)
                    (set! rdi vector-init-loop.7)
                    (set! r15 tmp-ra.85)
                    (jump
                     L.vector-init-loop.7.7
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (begin
      (set! tmp-ra.86 r15)
      (begin
        (begin
          (begin (set! tmp.78 (alloc 24)) (set! tmp.63 (+ tmp.78 2)))
          (begin
            (mset! tmp.63 -2 L.vector-init-loop.7.7)
            (mset! tmp.63 6 24)
            (set! vector-init-loop.7 tmp.63)))
        (begin
          (begin (set! tmp.79 (alloc 24)) (set! tmp.64 (+ tmp.79 2)))
          (begin
            (mset! tmp.64 -2 L.make-init-vector.1.8)
            (mset! tmp.64 6 8)
            (set! make-init-vector.1 tmp.64)))
        (begin
          (begin (set! tmp.80 (alloc 24)) (set! tmp.65 (+ tmp.80 2)))
          (begin
            (mset! tmp.65 -2 L.make-vector.57.9)
            (mset! tmp.65 6 8)
            (set! make-vector.57 tmp.65)))
        (begin
          (begin (set! tmp.81 (alloc 24)) (set! tmp.66 (+ tmp.81 2)))
          (begin
            (mset! tmp.66 -2 L.fun/vector8453.4.10)
            (mset! tmp.66 6 0)
            (set! fun/vector8453.4 tmp.66)))
        (begin
          (mset! vector-init-loop.7 14 vector-init-loop.7)
          (mset! make-init-vector.1 14 vector-init-loop.7)
          (mset! make-vector.57 14 make-init-vector.1)
          (mset! fun/vector8453.4 14 make-vector.57)
          (begin
            (set! rdi fun/vector8453.4)
            (set! r15 tmp-ra.86)
            (jump L.fun/vector8453.4.10 rbp r15 rdi)))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/error8456.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (begin
          (set! c.57 rdi)
          (begin (begin (set! rax 61502) (jump tmp-ra.60 rbp rax))))))
    (begin
      (set! tmp-ra.61 r15)
      (begin
        (begin
          (begin (set! tmp.59 (alloc 16)) (set! tmp.58 (+ tmp.59 2)))
          (begin
            (mset! tmp.58 -2 L.fun/error8456.4.7)
            (mset! tmp.58 6 0)
            (set! fun/error8456.4 tmp.58)))
        (begin
          (set! rdi fun/error8456.4)
          (set! r15 tmp-ra.61)
          (jump L.fun/error8456.4.7 rbp r15 rdi))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (begin
      (set! tmp-ra.56 r15)
      (if (!= 14 6)
        (begin (set! rax 28478) (jump tmp-ra.56 rbp rax))
        (begin (set! rax 63038) (jump tmp-ra.56 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames (())))
    (define L.fun/error8471.5.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.90 r15)
        (begin
          (set! c.66 rdi)
          (begin (begin (set! rax 55614) (jump tmp-ra.90 rbp rax))))))
    (define L.fun/error8470.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (begin
          (set! c.65 rdi)
          (set! oprand0.6 rsi)
          (begin
            (set! fun/error8471.5 (mref c.65 14))
            (begin
              (set! rdi fun/error8471.5)
              (set! r15 tmp-ra.91)
              (jump L.fun/error8471.5.11 rbp r15 rdi))))))
    (define L.make-vector.61.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (begin
          (set! c.64 rdi)
          (set! tmp.37 rsi)
          (begin
            (set! make-init-vector.1 (mref c.64 14))
            (if (begin
                  (if (begin (set! tmp.74 (bitwise-and tmp.37 7)) (= tmp.74 0))
                    (set! tmp.73 14)
                    (set! tmp.73 6))
                  (!= tmp.73 6))
              (begin
                (set! rsi tmp.37)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.92)
                (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.92 rbp rax)))))))
    (define L.make-init-vector.1.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.93 r15)
        (begin
          (set! c.63 rdi)
          (set! tmp.9 rsi)
          (begin
            (set! vector-init-loop.11 (mref c.63 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.78 (arithmetic-shift-right tmp.9 3))
                        (set! tmp.77 (+ 1 tmp.78)))
                      (set! tmp.76 (* tmp.77 8)))
                    (set! tmp.75 (alloc tmp.76)))
                  (set! tmp.67 (+ tmp.75 3)))
                (begin (mset! tmp.67 -3 tmp.9) (set! tmp.10 tmp.67)))
              (begin
                (set! rcx tmp.10)
                (set! rdx 0)
                (set! rsi tmp.9)
                (set! rdi vector-init-loop.11)
                (set! r15 tmp-ra.93)
                (jump L.vector-init-loop.11.7 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.11.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (begin
          (set! c.62 rdi)
          (set! len.12 rsi)
          (set! i.14 rdx)
          (set! vec.13 rcx)
          (begin
            (set! vector-init-loop.11 (mref c.62 14))
            (if (begin
                  (if (= len.12 i.14) (set! tmp.79 14) (set! tmp.79 6))
                  (!= tmp.79 6))
              (begin (set! rax vec.13) (jump tmp-ra.94 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.82 (arithmetic-shift-right i.14 3))
                      (set! tmp.81 (* tmp.82 8)))
                    (set! tmp.80 (+ tmp.81 5)))
                  (mset! vec.13 tmp.80 0))
                (begin
                  (set! tmp.83 (+ i.14 8))
                  (begin
                    (set! rcx vec.13)
                    (set! rdx tmp.83)
                    (set! rsi len.12)
                    (set! rdi vector-init-loop.11)
                    (set! r15 tmp-ra.94)
                    (jump
                     L.vector-init-loop.11.7
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (begin
      (set! tmp-ra.95 r15)
      (begin
        (begin
          (begin (set! tmp.84 (alloc 24)) (set! tmp.68 (+ tmp.84 2)))
          (begin
            (mset! tmp.68 -2 L.vector-init-loop.11.7)
            (mset! tmp.68 6 24)
            (set! vector-init-loop.11 tmp.68)))
        (begin
          (begin (set! tmp.85 (alloc 24)) (set! tmp.69 (+ tmp.85 2)))
          (begin
            (mset! tmp.69 -2 L.make-init-vector.1.8)
            (mset! tmp.69 6 8)
            (set! make-init-vector.1 tmp.69)))
        (begin
          (begin (set! tmp.86 (alloc 24)) (set! tmp.70 (+ tmp.86 2)))
          (begin
            (mset! tmp.70 -2 L.make-vector.61.9)
            (mset! tmp.70 6 8)
            (set! make-vector.61 tmp.70)))
        (begin
          (begin (set! tmp.87 (alloc 24)) (set! tmp.71 (+ tmp.87 2)))
          (begin
            (mset! tmp.71 -2 L.fun/error8470.4.10)
            (mset! tmp.71 6 8)
            (set! fun/error8470.4 tmp.71)))
        (begin
          (begin (set! tmp.88 (alloc 16)) (set! tmp.72 (+ tmp.88 2)))
          (begin
            (mset! tmp.72 -2 L.fun/error8471.5.11)
            (mset! tmp.72 6 0)
            (set! fun/error8471.5 tmp.72)))
        (begin
          (mset! vector-init-loop.11 14 vector-init-loop.11)
          (mset! make-init-vector.1 14 vector-init-loop.11)
          (mset! make-vector.61 14 make-init-vector.1)
          (mset! fun/error8470.4 14 fun/error8471.5)
          (begin
            (begin
              (set! fixnum0.8 2000)
              (begin
                (return-point L.rp.12
                  (begin
                    (set! rsi 64)
                    (set! rdi make-vector.61)
                    (set! r15 L.rp.12)
                    (jump L.make-vector.61.9 rbp r15 rdi rsi)))
                (set! vector1.7 rax))
              (set! tmp.89 1088))
            (begin
              (set! rsi tmp.89)
              (set! rdi fun/error8470.4)
              (set! r15 tmp-ra.95)
              (jump L.fun/error8470.4.10 rbp r15 rdi rsi))))))))
(check-by-interp
 '(module
    ((new-frames (())))
    (define L.fun/void8475.5.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.67 r15)
        (begin
          (set! c.61 rdi)
          (set! oprand0.7 rsi)
          (begin (begin (set! rax 30) (jump tmp-ra.67 rbp rax))))))
    (define L.fun/ascii-char8474.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.68 r15)
        (begin
          (set! c.60 rdi)
          (set! oprand0.6 rsi)
          (begin (begin (set! rax 22062) (jump tmp-ra.68 rbp rax))))))
    (begin
      (set! tmp-ra.69 r15)
      (begin
        (begin
          (begin (set! tmp.64 (alloc 16)) (set! tmp.62 (+ tmp.64 2)))
          (begin
            (mset! tmp.62 -2 L.fun/ascii-char8474.4.7)
            (mset! tmp.62 6 8)
            (set! fun/ascii-char8474.4 tmp.62)))
        (begin
          (begin (set! tmp.65 (alloc 16)) (set! tmp.63 (+ tmp.65 2)))
          (begin
            (mset! tmp.63 -2 L.fun/void8475.5.8)
            (mset! tmp.63 6 8)
            (set! fun/void8475.5 tmp.63)))
        (begin
          (begin
            (return-point L.rp.9
              (begin
                (set! rsi 14)
                (set! rdi fun/void8475.5)
                (set! r15 L.rp.9)
                (jump L.fun/void8475.5.8 rbp r15 rdi rsi)))
            (set! tmp.66 rax))
          (begin
            (set! rsi tmp.66)
            (set! rdi fun/ascii-char8474.4)
            (set! r15 tmp-ra.69)
            (jump L.fun/ascii-char8474.4.7 rbp r15 rdi rsi)))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/empty8478.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.64 r15)
        (begin
          (set! c.60 rdi)
          (set! oprand0.5 rsi)
          (begin (begin (set! rax 22) (jump tmp-ra.64 rbp rax))))))
    (begin
      (set! tmp-ra.65 r15)
      (begin
        (begin
          (begin (set! tmp.62 (alloc 16)) (set! tmp.61 (+ tmp.62 2)))
          (begin
            (mset! tmp.61 -2 L.fun/empty8478.4.7)
            (mset! tmp.61 6 8)
            (set! fun/empty8478.4 tmp.61)))
        (begin
          (begin (set! error0.7 13630) (set! error1.6 50238) (set! tmp.63 22))
          (begin
            (set! rsi tmp.63)
            (set! rdi fun/empty8478.4)
            (set! r15 tmp-ra.65)
            (jump L.fun/empty8478.4.7 rbp r15 rdi rsi)))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/ascii-char8481.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.62 r15)
        (begin
          (set! c.58 rdi)
          (set! oprand0.5 rsi)
          (begin (begin (set! rax 23598) (jump tmp-ra.62 rbp rax))))))
    (begin
      (set! tmp-ra.63 r15)
      (begin
        (begin
          (begin (set! tmp.60 (alloc 16)) (set! tmp.59 (+ tmp.60 2)))
          (begin
            (mset! tmp.59 -2 L.fun/ascii-char8481.4.7)
            (mset! tmp.59 6 8)
            (set! fun/ascii-char8481.4 tmp.59)))
        (begin
          (if (!= 6 6) (set! tmp.61 22) (set! tmp.61 22))
          (begin
            (set! rsi tmp.61)
            (set! rdi fun/ascii-char8481.4)
            (set! r15 tmp-ra.63)
            (jump L.fun/ascii-char8481.4.7 rbp r15 rdi rsi)))))))
(check-by-interp
 '(module
    ((new-frames (() () ())))
    (define L.fun/pair8496.5.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (begin
          (set! c.70 rdi)
          (begin
            (set! cons.63 (mref c.70 14))
            (begin
              (set! rdx 3424)
              (set! rsi 264)
              (set! rdi cons.63)
              (set! r15 tmp-ra.94)
              (jump L.cons.63.9 rbp r15 rdi rsi rdx))))))
    (define L.fun/pair8495.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.95 r15)
        (begin
          (set! c.69 rdi)
          (set! oprand0.7 rsi)
          (set! oprand1.6 rdx)
          (begin
            (set! fun/pair8496.5 (mref c.69 14))
            (begin
              (set! rdi fun/pair8496.5)
              (set! r15 tmp-ra.95)
              (jump L.fun/pair8496.5.11 rbp r15 rdi))))))
    (define L.cons.63.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.96 r15)
        (begin
          (set! c.68 rdi)
          (set! tmp.58 rsi)
          (set! tmp.59 rdx)
          (begin
            (begin
              (begin (set! tmp.77 (alloc 16)) (set! tmp.71 (+ tmp.77 1)))
              (begin
                (mset! tmp.71 -1 tmp.58)
                (mset! tmp.71 7 tmp.59)
                (begin (set! rax tmp.71) (jump tmp-ra.96 rbp rax))))))))
    (define L.*.64.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.97 r15)
        (begin
          (set! c.67 rdi)
          (set! tmp.25 rsi)
          (set! tmp.26 rdx)
          (begin
            (if (begin
                  (if (begin (set! tmp.79 (bitwise-and tmp.26 7)) (= tmp.79 0))
                    (set! tmp.78 14)
                    (set! tmp.78 6))
                  (!= tmp.78 6))
              (if (begin
                    (if (begin
                          (set! tmp.81 (bitwise-and tmp.25 7))
                          (= tmp.81 0))
                      (set! tmp.80 14)
                      (set! tmp.80 6))
                    (!= tmp.80 6))
                (begin
                  (set! tmp.82 (arithmetic-shift-right tmp.26 3))
                  (begin
                    (set! rax (* tmp.25 tmp.82))
                    (jump tmp-ra.97 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.97 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.97 rbp rax)))))))
    (define L.ascii-char?.65.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.98 r15)
        (begin
          (set! c.66 rdi)
          (set! tmp.52 rsi)
          (begin
            (if (begin (set! tmp.83 (bitwise-and tmp.52 255)) (= tmp.83 46))
              (begin (set! rax 14) (jump tmp-ra.98 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.98 rbp rax)))))))
    (begin
      (set! tmp-ra.99 r15)
      (begin
        (begin
          (begin (set! tmp.84 (alloc 16)) (set! tmp.72 (+ tmp.84 2)))
          (begin
            (mset! tmp.72 -2 L.ascii-char?.65.7)
            (mset! tmp.72 6 8)
            (set! ascii-char?.65 tmp.72)))
        (begin
          (begin (set! tmp.85 (alloc 16)) (set! tmp.73 (+ tmp.85 2)))
          (begin
            (mset! tmp.73 -2 L.*.64.8)
            (mset! tmp.73 6 16)
            (set! *.64 tmp.73)))
        (begin
          (begin (set! tmp.86 (alloc 16)) (set! tmp.74 (+ tmp.86 2)))
          (begin
            (mset! tmp.74 -2 L.cons.63.9)
            (mset! tmp.74 6 16)
            (set! cons.63 tmp.74)))
        (begin
          (begin (set! tmp.87 (alloc 24)) (set! tmp.75 (+ tmp.87 2)))
          (begin
            (mset! tmp.75 -2 L.fun/pair8495.4.10)
            (mset! tmp.75 6 16)
            (set! fun/pair8495.4 tmp.75)))
        (begin
          (begin (set! tmp.88 (alloc 24)) (set! tmp.76 (+ tmp.88 2)))
          (begin
            (mset! tmp.76 -2 L.fun/pair8496.5.11)
            (mset! tmp.76 6 0)
            (set! fun/pair8496.5 tmp.76)))
        (begin
          (mset! fun/pair8495.4 14 fun/pair8496.5)
          (mset! fun/pair8496.5 14 cons.63)
          (begin
            (begin
              (begin
                (return-point L.rp.12
                  (begin
                    (set! rdx 800)
                    (set! rsi 960)
                    (set! rdi *.64)
                    (set! r15 L.rp.12)
                    (jump L.*.64.8 rbp r15 rdi rsi rdx)))
                (set! tmp.90 rax))
              (begin
                (begin
                  (set! ascii-char0.10 19758)
                  (set! boolean1.9 14)
                  (set! boolean2.8 14)
                  (set! tmp.91 1568))
                (begin
                  (return-point L.rp.13
                    (begin
                      (set! rdx tmp.91)
                      (set! rsi tmp.90)
                      (set! rdi *.64)
                      (set! r15 L.rp.13)
                      (jump L.*.64.8 rbp r15 rdi rsi rdx)))
                  (set! tmp.89 rax))))
            (begin
              (begin
                (if (!= 14 6) (set! tmp.93 24110) (set! tmp.93 30))
                (begin
                  (return-point L.rp.14
                    (begin
                      (set! rsi tmp.93)
                      (set! rdi ascii-char?.65)
                      (set! r15 L.rp.14)
                      (jump L.ascii-char?.65.7 rbp r15 rdi rsi)))
                  (set! tmp.92 rax)))
              (begin
                (set! rdx tmp.92)
                (set! rsi tmp.89)
                (set! rdi fun/pair8495.4)
                (set! r15 tmp-ra.99)
                (jump L.fun/pair8495.4.10 rbp r15 rdi rsi rdx)))))))))
(check-by-interp
 '(module
    ((new-frames (() () () ())))
    (define L.fun/void8506.9.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.123 r15)
        (begin
          (set! c.84 rdi)
          (set! oprand0.17 rsi)
          (set! oprand1.16 rdx)
          (begin
            (set! fun/void8507.7 (mref c.84 14))
            (begin
              (set! rdi fun/void8507.7)
              (set! r15 tmp-ra.123)
              (jump L.fun/void8507.7.14 rbp r15 rdi))))))
    (define L.fun/error8510.8.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.124 r15)
        (begin
          (set! c.83 rdi)
          (set! oprand0.15 rsi)
          (set! oprand1.14 rdx)
          (begin (begin (set! rax 39230) (jump tmp-ra.124 rbp rax))))))
    (define L.fun/void8507.7.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.125 r15)
        (begin
          (set! c.82 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.125 rbp rax))))))
    (define L.fun/empty8511.6.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.126 r15)
        (begin
          (set! c.81 rdi)
          (set! oprand0.13 rsi)
          (set! oprand1.12 rdx)
          (begin (begin (set! rax 22) (jump tmp-ra.126 rbp rax))))))
    (define L.fun/pair8509.5.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.127 r15)
        (begin
          (set! c.80 rdi)
          (begin
            (set! cons.73 (mref c.80 14))
            (begin
              (set! rdx 2752)
              (set! rsi 840)
              (set! rdi cons.73)
              (set! r15 tmp-ra.127)
              (jump L.cons.73.10 rbp r15 rdi rsi rdx))))))
    (define L.fun/pair8508.4.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.128 r15)
        (begin
          (set! c.79 rdi)
          (set! oprand0.11 rsi)
          (set! oprand1.10 rdx)
          (begin
            (set! fun/pair8509.5 (mref c.79 14))
            (begin
              (set! rdi fun/pair8509.5)
              (set! r15 tmp-ra.128)
              (jump L.fun/pair8509.5.12 rbp r15 rdi))))))
    (define L.cons.73.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.129 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.68 rsi)
          (set! tmp.69 rdx)
          (begin
            (begin
              (begin (set! tmp.97 (alloc 16)) (set! tmp.85 (+ tmp.97 1)))
              (begin
                (mset! tmp.85 -1 tmp.68)
                (mset! tmp.85 7 tmp.69)
                (begin (set! rax tmp.85) (jump tmp-ra.129 rbp rax))))))))
    (define L.make-vector.74.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.130 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.49 rsi)
          (begin
            (set! make-init-vector.1 (mref c.77 14))
            (if (begin
                  (if (begin (set! tmp.99 (bitwise-and tmp.49 7)) (= tmp.99 0))
                    (set! tmp.98 14)
                    (set! tmp.98 6))
                  (!= tmp.98 6))
              (begin
                (set! rsi tmp.49)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.130)
                (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.130 rbp rax)))))))
    (define L.make-init-vector.1.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.131 r15)
        (begin
          (set! c.76 rdi)
          (set! tmp.21 rsi)
          (begin
            (set! vector-init-loop.23 (mref c.76 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.103 (arithmetic-shift-right tmp.21 3))
                        (set! tmp.102 (+ 1 tmp.103)))
                      (set! tmp.101 (* tmp.102 8)))
                    (set! tmp.100 (alloc tmp.101)))
                  (set! tmp.86 (+ tmp.100 3)))
                (begin (mset! tmp.86 -3 tmp.21) (set! tmp.22 tmp.86)))
              (begin
                (set! rcx tmp.22)
                (set! rdx 0)
                (set! rsi tmp.21)
                (set! rdi vector-init-loop.23)
                (set! r15 tmp-ra.131)
                (jump L.vector-init-loop.23.7 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.23.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.132 r15)
        (begin
          (set! c.75 rdi)
          (set! len.24 rsi)
          (set! i.26 rdx)
          (set! vec.25 rcx)
          (begin
            (set! vector-init-loop.23 (mref c.75 14))
            (if (begin
                  (if (= len.24 i.26) (set! tmp.104 14) (set! tmp.104 6))
                  (!= tmp.104 6))
              (begin (set! rax vec.25) (jump tmp-ra.132 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.107 (arithmetic-shift-right i.26 3))
                      (set! tmp.106 (* tmp.107 8)))
                    (set! tmp.105 (+ tmp.106 5)))
                  (mset! vec.25 tmp.105 0))
                (begin
                  (set! tmp.108 (+ i.26 8))
                  (begin
                    (set! rcx vec.25)
                    (set! rdx tmp.108)
                    (set! rsi len.24)
                    (set! rdi vector-init-loop.23)
                    (set! r15 tmp-ra.132)
                    (jump
                     L.vector-init-loop.23.7
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (begin
      (set! tmp-ra.133 r15)
      (begin
        (begin
          (begin (set! tmp.109 (alloc 24)) (set! tmp.87 (+ tmp.109 2)))
          (begin
            (mset! tmp.87 -2 L.vector-init-loop.23.7)
            (mset! tmp.87 6 24)
            (set! vector-init-loop.23 tmp.87)))
        (begin
          (begin (set! tmp.110 (alloc 24)) (set! tmp.88 (+ tmp.110 2)))
          (begin
            (mset! tmp.88 -2 L.make-init-vector.1.8)
            (mset! tmp.88 6 8)
            (set! make-init-vector.1 tmp.88)))
        (begin
          (begin (set! tmp.111 (alloc 24)) (set! tmp.89 (+ tmp.111 2)))
          (begin
            (mset! tmp.89 -2 L.make-vector.74.9)
            (mset! tmp.89 6 8)
            (set! make-vector.74 tmp.89)))
        (begin
          (begin (set! tmp.112 (alloc 16)) (set! tmp.90 (+ tmp.112 2)))
          (begin
            (mset! tmp.90 -2 L.cons.73.10)
            (mset! tmp.90 6 16)
            (set! cons.73 tmp.90)))
        (begin
          (begin (set! tmp.113 (alloc 24)) (set! tmp.91 (+ tmp.113 2)))
          (begin
            (mset! tmp.91 -2 L.fun/pair8508.4.11)
            (mset! tmp.91 6 16)
            (set! fun/pair8508.4 tmp.91)))
        (begin
          (begin (set! tmp.114 (alloc 24)) (set! tmp.92 (+ tmp.114 2)))
          (begin
            (mset! tmp.92 -2 L.fun/pair8509.5.12)
            (mset! tmp.92 6 0)
            (set! fun/pair8509.5 tmp.92)))
        (begin
          (begin (set! tmp.115 (alloc 16)) (set! tmp.93 (+ tmp.115 2)))
          (begin
            (mset! tmp.93 -2 L.fun/empty8511.6.13)
            (mset! tmp.93 6 16)
            (set! fun/empty8511.6 tmp.93)))
        (begin
          (begin (set! tmp.116 (alloc 16)) (set! tmp.94 (+ tmp.116 2)))
          (begin
            (mset! tmp.94 -2 L.fun/void8507.7.14)
            (mset! tmp.94 6 0)
            (set! fun/void8507.7 tmp.94)))
        (begin
          (begin (set! tmp.117 (alloc 16)) (set! tmp.95 (+ tmp.117 2)))
          (begin
            (mset! tmp.95 -2 L.fun/error8510.8.15)
            (mset! tmp.95 6 16)
            (set! fun/error8510.8 tmp.95)))
        (begin
          (begin (set! tmp.118 (alloc 24)) (set! tmp.96 (+ tmp.118 2)))
          (begin
            (mset! tmp.96 -2 L.fun/void8506.9.16)
            (mset! tmp.96 6 16)
            (set! fun/void8506.9 tmp.96)))
        (begin
          (mset! vector-init-loop.23 14 vector-init-loop.23)
          (mset! make-init-vector.1 14 vector-init-loop.23)
          (mset! make-vector.74 14 make-init-vector.1)
          (mset! fun/pair8508.4 14 fun/pair8509.5)
          (mset! fun/pair8509.5 14 cons.73)
          (mset! fun/void8506.9 14 fun/void8507.7)
          (begin
            (begin
              (set! ascii-char0.20 27182)
              (begin
                (return-point L.rp.17
                  (begin
                    (set! rsi 64)
                    (set! rdi make-vector.74)
                    (set! r15 L.rp.17)
                    (jump L.make-vector.74.9 rbp r15 rdi rsi)))
                (set! vector1.19 rax))
              (set! boolean2.18 14)
              (set! tmp.119 37694))
            (begin
              (begin
                (begin
                  (return-point L.rp.18
                    (begin
                      (set! rdx 30)
                      (set! rsi 30)
                      (set! rdi fun/error8510.8)
                      (set! r15 L.rp.18)
                      (jump L.fun/error8510.8.15 rbp r15 rdi rsi rdx)))
                  (set! tmp.121 rax))
                (begin
                  (begin
                    (return-point L.rp.19
                      (begin
                        (set! rdx 17198)
                        (set! rsi 36414)
                        (set! rdi fun/empty8511.6)
                        (set! r15 L.rp.19)
                        (jump L.fun/empty8511.6.13 rbp r15 rdi rsi rdx)))
                    (set! tmp.122 rax))
                  (begin
                    (return-point L.rp.20
                      (begin
                        (set! rdx tmp.122)
                        (set! rsi tmp.121)
                        (set! rdi fun/pair8508.4)
                        (set! r15 L.rp.20)
                        (jump L.fun/pair8508.4.11 rbp r15 rdi rsi rdx)))
                    (set! tmp.120 rax))))
              (begin
                (set! rdx tmp.120)
                (set! rsi tmp.119)
                (set! rdi fun/void8506.9)
                (set! r15 tmp-ra.133)
                (jump L.fun/void8506.9.16 rbp r15 rdi rsi rdx)))))))))
(check-by-interp
 '(module
    ((new-frames (() () () ())))
    (define L.fun/vector8536.6.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.105 r15)
        (begin
          (set! c.72 rdi)
          (begin
            (set! make-vector.62 (mref c.72 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.62)
              (set! r15 tmp-ra.105)
              (jump L.make-vector.62.11 rbp r15 rdi rsi))))))
    (define L.fun/empty8537.5.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.106 r15)
        (begin
          (set! c.71 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.106 rbp rax))))))
    (define L.fun/empty8535.4.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.107 r15)
        (begin
          (set! c.70 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.107 rbp rax))))))
    (define L.make-vector.62.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.108 r15)
        (begin
          (set! c.69 rdi)
          (set! tmp.38 rsi)
          (begin
            (set! make-init-vector.1 (mref c.69 14))
            (if (begin
                  (if (begin (set! tmp.84 (bitwise-and tmp.38 7)) (= tmp.84 0))
                    (set! tmp.83 14)
                    (set! tmp.83 6))
                  (!= tmp.83 6))
              (begin
                (set! rsi tmp.38)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.108)
                (jump L.make-init-vector.1.10 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.108 rbp rax)))))))
    (define L.make-init-vector.1.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.109 r15)
        (begin
          (set! c.68 rdi)
          (set! tmp.10 rsi)
          (begin
            (set! vector-init-loop.12 (mref c.68 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.88 (arithmetic-shift-right tmp.10 3))
                        (set! tmp.87 (+ 1 tmp.88)))
                      (set! tmp.86 (* tmp.87 8)))
                    (set! tmp.85 (alloc tmp.86)))
                  (set! tmp.73 (+ tmp.85 3)))
                (begin (mset! tmp.73 -3 tmp.10) (set! tmp.11 tmp.73)))
              (begin
                (set! rcx tmp.11)
                (set! rdx 0)
                (set! rsi tmp.10)
                (set! rdi vector-init-loop.12)
                (set! r15 tmp-ra.109)
                (jump L.vector-init-loop.12.9 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.12.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.110 r15)
        (begin
          (set! c.67 rdi)
          (set! len.13 rsi)
          (set! i.15 rdx)
          (set! vec.14 rcx)
          (begin
            (set! vector-init-loop.12 (mref c.67 14))
            (if (begin
                  (if (= len.13 i.15) (set! tmp.89 14) (set! tmp.89 6))
                  (!= tmp.89 6))
              (begin (set! rax vec.14) (jump tmp-ra.110 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.92 (arithmetic-shift-right i.15 3))
                      (set! tmp.91 (* tmp.92 8)))
                    (set! tmp.90 (+ tmp.91 5)))
                  (mset! vec.14 tmp.90 0))
                (begin
                  (set! tmp.93 (+ i.15 8))
                  (begin
                    (set! rcx vec.14)
                    (set! rdx tmp.93)
                    (set! rsi len.13)
                    (set! rdi vector-init-loop.12)
                    (set! r15 tmp-ra.110)
                    (jump
                     L.vector-init-loop.12.9
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.cons.63.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.111 r15)
        (begin
          (set! c.66 rdi)
          (set! tmp.57 rsi)
          (set! tmp.58 rdx)
          (begin
            (begin
              (begin (set! tmp.94 (alloc 16)) (set! tmp.74 (+ tmp.94 1)))
              (begin
                (mset! tmp.74 -1 tmp.57)
                (mset! tmp.74 7 tmp.58)
                (begin (set! rax tmp.74) (jump tmp-ra.111 rbp rax))))))))
    (define L.boolean?.64.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.112 r15)
        (begin
          (set! c.65 rdi)
          (set! tmp.48 rsi)
          (begin
            (if (begin (set! tmp.95 (bitwise-and tmp.48 247)) (= tmp.95 6))
              (begin (set! rax 14) (jump tmp-ra.112 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.112 rbp rax)))))))
    (begin
      (set! tmp-ra.113 r15)
      (begin
        (begin
          (begin (set! tmp.96 (alloc 16)) (set! tmp.75 (+ tmp.96 2)))
          (begin
            (mset! tmp.75 -2 L.boolean?.64.7)
            (mset! tmp.75 6 8)
            (set! boolean?.64 tmp.75)))
        (begin
          (begin (set! tmp.97 (alloc 16)) (set! tmp.76 (+ tmp.97 2)))
          (begin
            (mset! tmp.76 -2 L.cons.63.8)
            (mset! tmp.76 6 16)
            (set! cons.63 tmp.76)))
        (begin
          (begin (set! tmp.98 (alloc 24)) (set! tmp.77 (+ tmp.98 2)))
          (begin
            (mset! tmp.77 -2 L.vector-init-loop.12.9)
            (mset! tmp.77 6 24)
            (set! vector-init-loop.12 tmp.77)))
        (begin
          (begin (set! tmp.99 (alloc 24)) (set! tmp.78 (+ tmp.99 2)))
          (begin
            (mset! tmp.78 -2 L.make-init-vector.1.10)
            (mset! tmp.78 6 8)
            (set! make-init-vector.1 tmp.78)))
        (begin
          (begin (set! tmp.100 (alloc 24)) (set! tmp.79 (+ tmp.100 2)))
          (begin
            (mset! tmp.79 -2 L.make-vector.62.11)
            (mset! tmp.79 6 8)
            (set! make-vector.62 tmp.79)))
        (begin
          (begin (set! tmp.101 (alloc 16)) (set! tmp.80 (+ tmp.101 2)))
          (begin
            (mset! tmp.80 -2 L.fun/empty8535.4.12)
            (mset! tmp.80 6 0)
            (set! fun/empty8535.4 tmp.80)))
        (begin
          (begin (set! tmp.102 (alloc 16)) (set! tmp.81 (+ tmp.102 2)))
          (begin
            (mset! tmp.81 -2 L.fun/empty8537.5.13)
            (mset! tmp.81 6 0)
            (set! fun/empty8537.5 tmp.81)))
        (begin
          (begin (set! tmp.103 (alloc 24)) (set! tmp.82 (+ tmp.103 2)))
          (begin
            (mset! tmp.82 -2 L.fun/vector8536.6.14)
            (mset! tmp.82 6 0)
            (set! fun/vector8536.6 tmp.82)))
        (begin
          (mset! vector-init-loop.12 14 vector-init-loop.12)
          (mset! make-init-vector.1 14 vector-init-loop.12)
          (mset! make-vector.62 14 make-init-vector.1)
          (mset! fun/vector8536.6 14 make-vector.62)
          (begin
            (begin
              (return-point L.rp.15
                (begin
                  (set! rdi fun/empty8535.4)
                  (set! r15 L.rp.15)
                  (jump L.fun/empty8535.4.12 rbp r15 rdi)))
              (set! empty0.9 rax))
            (begin
              (begin
                (return-point L.rp.16
                  (begin
                    (set! rdx 3312)
                    (set! rsi 640)
                    (set! rdi cons.63)
                    (set! r15 L.rp.16)
                    (jump L.cons.63.8 rbp r15 rdi rsi rdx)))
                (set! tmp.104 rax))
              (begin
                (return-point L.rp.17
                  (begin
                    (set! rsi tmp.104)
                    (set! rdi boolean?.64)
                    (set! r15 L.rp.17)
                    (jump L.boolean?.64.7 rbp r15 rdi rsi)))
                (set! boolean1.8 rax)))
            (begin
              (return-point L.rp.18
                (begin
                  (set! rdi fun/vector8536.6)
                  (set! r15 L.rp.18)
                  (jump L.fun/vector8536.6.14 rbp r15 rdi)))
              (set! vector2.7 rax))
            (begin
              (set! rdi fun/empty8537.5)
              (set! r15 tmp-ra.113)
              (jump L.fun/empty8537.5.13 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() ())))
    (define L.fun/empty8564.8.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (begin
          (set! c.73 rdi)
          (set! oprand0.14 rsi)
          (set! oprand1.13 rdx)
          (begin (begin (set! rax 22) (jump tmp-ra.92 rbp rax))))))
    (define L.fun/ascii-char8563.7.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.93 r15)
        (begin
          (set! c.72 rdi)
          (begin (begin (set! rax 29486) (jump tmp-ra.93 rbp rax))))))
    (define L.fun/pair8560.6.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (begin
          (set! c.71 rdi)
          (set! oprand0.12 rsi)
          (set! oprand1.11 rdx)
          (begin
            (set! fun/pair8561.4 (mref c.71 14))
            (begin
              (set! rdi fun/pair8561.4)
              (set! r15 tmp-ra.94)
              (jump L.fun/pair8561.4.8 rbp r15 rdi))))))
    (define L.fun/ascii-char8562.5.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.95 r15)
        (begin
          (set! c.70 rdi)
          (set! oprand0.10 rsi)
          (set! oprand1.9 rdx)
          (begin
            (set! fun/ascii-char8563.7 (mref c.70 14))
            (begin
              (set! rdi fun/ascii-char8563.7)
              (set! r15 tmp-ra.95)
              (jump L.fun/ascii-char8563.7.11 rbp r15 rdi))))))
    (define L.fun/pair8561.4.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.96 r15)
        (begin
          (set! c.69 rdi)
          (begin
            (set! cons.67 (mref c.69 14))
            (begin
              (set! rdx 3192)
              (set! rsi 2008)
              (set! rdi cons.67)
              (set! r15 tmp-ra.96)
              (jump L.cons.67.7 rbp r15 rdi rsi rdx))))))
    (define L.cons.67.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.97 r15)
        (begin
          (set! c.68 rdi)
          (set! tmp.62 rsi)
          (set! tmp.63 rdx)
          (begin
            (begin
              (begin (set! tmp.81 (alloc 16)) (set! tmp.74 (+ tmp.81 1)))
              (begin
                (mset! tmp.74 -1 tmp.62)
                (mset! tmp.74 7 tmp.63)
                (begin (set! rax tmp.74) (jump tmp-ra.97 rbp rax))))))))
    (begin
      (set! tmp-ra.98 r15)
      (begin
        (begin
          (begin (set! tmp.82 (alloc 16)) (set! tmp.75 (+ tmp.82 2)))
          (begin
            (mset! tmp.75 -2 L.cons.67.7)
            (mset! tmp.75 6 16)
            (set! cons.67 tmp.75)))
        (begin
          (begin (set! tmp.83 (alloc 24)) (set! tmp.76 (+ tmp.83 2)))
          (begin
            (mset! tmp.76 -2 L.fun/pair8561.4.8)
            (mset! tmp.76 6 0)
            (set! fun/pair8561.4 tmp.76)))
        (begin
          (begin (set! tmp.84 (alloc 24)) (set! tmp.77 (+ tmp.84 2)))
          (begin
            (mset! tmp.77 -2 L.fun/ascii-char8562.5.9)
            (mset! tmp.77 6 16)
            (set! fun/ascii-char8562.5 tmp.77)))
        (begin
          (begin (set! tmp.85 (alloc 24)) (set! tmp.78 (+ tmp.85 2)))
          (begin
            (mset! tmp.78 -2 L.fun/pair8560.6.10)
            (mset! tmp.78 6 16)
            (set! fun/pair8560.6 tmp.78)))
        (begin
          (begin (set! tmp.86 (alloc 16)) (set! tmp.79 (+ tmp.86 2)))
          (begin
            (mset! tmp.79 -2 L.fun/ascii-char8563.7.11)
            (mset! tmp.79 6 0)
            (set! fun/ascii-char8563.7 tmp.79)))
        (begin
          (begin (set! tmp.87 (alloc 16)) (set! tmp.80 (+ tmp.87 2)))
          (begin
            (mset! tmp.80 -2 L.fun/empty8564.8.12)
            (mset! tmp.80 6 16)
            (set! fun/empty8564.8 tmp.80)))
        (begin
          (mset! fun/pair8561.4 14 cons.67)
          (mset! fun/ascii-char8562.5 14 fun/ascii-char8563.7)
          (mset! fun/pair8560.6 14 fun/pair8561.4)
          (begin
            (if (!= 6 6) (set! tmp.88 488) (set! tmp.88 592))
            (begin
              (begin
                (begin
                  (return-point L.rp.13
                    (begin
                      (set! rdx 29230)
                      (set! rsi 22)
                      (set! rdi fun/empty8564.8)
                      (set! r15 L.rp.13)
                      (jump L.fun/empty8564.8.12 rbp r15 rdi rsi rdx)))
                  (set! tmp.90 rax))
                (begin
                  (if (!= 14 6) (set! tmp.91 14) (set! tmp.91 6))
                  (begin
                    (return-point L.rp.14
                      (begin
                        (set! rdx tmp.91)
                        (set! rsi tmp.90)
                        (set! rdi fun/ascii-char8562.5)
                        (set! r15 L.rp.14)
                        (jump L.fun/ascii-char8562.5.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.89 rax))))
              (begin
                (set! rdx tmp.89)
                (set! rsi tmp.88)
                (set! rdi fun/pair8560.6)
                (set! r15 tmp-ra.98)
                (jump L.fun/pair8560.6.10 rbp r15 rdi rsi rdx)))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ())))
    (define L.fun/void8611.7.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.125 r15)
        (begin
          (set! c.77 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.125 rbp rax))))))
    (define L.fun/ascii-char8614.6.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.126 r15)
        (begin
          (set! c.76 rdi)
          (begin (begin (set! rax 21294) (jump tmp-ra.126 rbp rax))))))
    (define L.fun/vector8612.5.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.127 r15)
        (begin
          (set! c.75 rdi)
          (begin
            (set! make-vector.64 (mref c.75 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.64)
              (set! r15 tmp-ra.127)
              (jump L.make-vector.64.12 rbp r15 rdi rsi))))))
    (define L.fun/ascii-char8613.4.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.128 r15)
        (begin
          (set! c.74 rdi)
          (begin (begin (set! rax 16942) (jump tmp-ra.128 rbp rax))))))
    (define L.make-vector.64.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.129 r15)
        (begin
          (set! c.73 rdi)
          (set! tmp.40 rsi)
          (begin
            (set! make-init-vector.1 (mref c.73 14))
            (if (begin
                  (if (begin (set! tmp.90 (bitwise-and tmp.40 7)) (= tmp.90 0))
                    (set! tmp.89 14)
                    (set! tmp.89 6))
                  (!= tmp.89 6))
              (begin
                (set! rsi tmp.40)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.129)
                (jump L.make-init-vector.1.11 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.129 rbp rax)))))))
    (define L.make-init-vector.1.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.130 r15)
        (begin
          (set! c.72 rdi)
          (set! tmp.12 rsi)
          (begin
            (set! vector-init-loop.14 (mref c.72 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.94 (arithmetic-shift-right tmp.12 3))
                        (set! tmp.93 (+ 1 tmp.94)))
                      (set! tmp.92 (* tmp.93 8)))
                    (set! tmp.91 (alloc tmp.92)))
                  (set! tmp.78 (+ tmp.91 3)))
                (begin (mset! tmp.78 -3 tmp.12) (set! tmp.13 tmp.78)))
              (begin
                (set! rcx tmp.13)
                (set! rdx 0)
                (set! rsi tmp.12)
                (set! rdi vector-init-loop.14)
                (set! r15 tmp-ra.130)
                (jump L.vector-init-loop.14.10 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.14.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.131 r15)
        (begin
          (set! c.71 rdi)
          (set! len.15 rsi)
          (set! i.17 rdx)
          (set! vec.16 rcx)
          (begin
            (set! vector-init-loop.14 (mref c.71 14))
            (if (begin
                  (if (= len.15 i.17) (set! tmp.95 14) (set! tmp.95 6))
                  (!= tmp.95 6))
              (begin (set! rax vec.16) (jump tmp-ra.131 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.98 (arithmetic-shift-right i.17 3))
                      (set! tmp.97 (* tmp.98 8)))
                    (set! tmp.96 (+ tmp.97 5)))
                  (mset! vec.16 tmp.96 0))
                (begin
                  (set! tmp.99 (+ i.17 8))
                  (begin
                    (set! rcx vec.16)
                    (set! rdx tmp.99)
                    (set! rsi len.15)
                    (set! rdi vector-init-loop.14)
                    (set! r15 tmp-ra.131)
                    (jump
                     L.vector-init-loop.14.10
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.*.65.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.132 r15)
        (begin
          (set! c.70 rdi)
          (set! tmp.26 rsi)
          (set! tmp.27 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.101 (bitwise-and tmp.27 7))
                        (= tmp.101 0))
                    (set! tmp.100 14)
                    (set! tmp.100 6))
                  (!= tmp.100 6))
              (if (begin
                    (if (begin
                          (set! tmp.103 (bitwise-and tmp.26 7))
                          (= tmp.103 0))
                      (set! tmp.102 14)
                      (set! tmp.102 6))
                    (!= tmp.102 6))
                (begin
                  (set! tmp.104 (arithmetic-shift-right tmp.27 3))
                  (begin
                    (set! rax (* tmp.26 tmp.104))
                    (jump tmp-ra.132 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.132 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.132 rbp rax)))))))
    (define L.-.66.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.133 r15)
        (begin
          (set! c.69 rdi)
          (set! tmp.30 rsi)
          (set! tmp.31 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.106 (bitwise-and tmp.31 7))
                        (= tmp.106 0))
                    (set! tmp.105 14)
                    (set! tmp.105 6))
                  (!= tmp.105 6))
              (if (begin
                    (if (begin
                          (set! tmp.108 (bitwise-and tmp.30 7))
                          (= tmp.108 0))
                      (set! tmp.107 14)
                      (set! tmp.107 6))
                    (!= tmp.107 6))
                (begin (set! rax (- tmp.30 tmp.31)) (jump tmp-ra.133 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.133 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.133 rbp rax)))))))
    (define L.+.67.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.134 r15)
        (begin
          (set! c.68 rdi)
          (set! tmp.28 rsi)
          (set! tmp.29 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.110 (bitwise-and tmp.29 7))
                        (= tmp.110 0))
                    (set! tmp.109 14)
                    (set! tmp.109 6))
                  (!= tmp.109 6))
              (if (begin
                    (if (begin
                          (set! tmp.112 (bitwise-and tmp.28 7))
                          (= tmp.112 0))
                      (set! tmp.111 14)
                      (set! tmp.111 6))
                    (!= tmp.111 6))
                (begin (set! rax (+ tmp.28 tmp.29)) (jump tmp-ra.134 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.134 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.134 rbp rax)))))))
    (begin
      (set! tmp-ra.135 r15)
      (begin
        (begin
          (begin (set! tmp.113 (alloc 16)) (set! tmp.79 (+ tmp.113 2)))
          (begin
            (mset! tmp.79 -2 L.+.67.7)
            (mset! tmp.79 6 16)
            (set! |+.67| tmp.79)))
        (begin
          (begin (set! tmp.114 (alloc 16)) (set! tmp.80 (+ tmp.114 2)))
          (begin
            (mset! tmp.80 -2 L.-.66.8)
            (mset! tmp.80 6 16)
            (set! |-.66| tmp.80)))
        (begin
          (begin (set! tmp.115 (alloc 16)) (set! tmp.81 (+ tmp.115 2)))
          (begin
            (mset! tmp.81 -2 L.*.65.9)
            (mset! tmp.81 6 16)
            (set! *.65 tmp.81)))
        (begin
          (begin (set! tmp.116 (alloc 24)) (set! tmp.82 (+ tmp.116 2)))
          (begin
            (mset! tmp.82 -2 L.vector-init-loop.14.10)
            (mset! tmp.82 6 24)
            (set! vector-init-loop.14 tmp.82)))
        (begin
          (begin (set! tmp.117 (alloc 24)) (set! tmp.83 (+ tmp.117 2)))
          (begin
            (mset! tmp.83 -2 L.make-init-vector.1.11)
            (mset! tmp.83 6 8)
            (set! make-init-vector.1 tmp.83)))
        (begin
          (begin (set! tmp.118 (alloc 24)) (set! tmp.84 (+ tmp.118 2)))
          (begin
            (mset! tmp.84 -2 L.make-vector.64.12)
            (mset! tmp.84 6 8)
            (set! make-vector.64 tmp.84)))
        (begin
          (begin (set! tmp.119 (alloc 16)) (set! tmp.85 (+ tmp.119 2)))
          (begin
            (mset! tmp.85 -2 L.fun/ascii-char8613.4.13)
            (mset! tmp.85 6 0)
            (set! fun/ascii-char8613.4 tmp.85)))
        (begin
          (begin (set! tmp.120 (alloc 24)) (set! tmp.86 (+ tmp.120 2)))
          (begin
            (mset! tmp.86 -2 L.fun/vector8612.5.14)
            (mset! tmp.86 6 0)
            (set! fun/vector8612.5 tmp.86)))
        (begin
          (begin (set! tmp.121 (alloc 16)) (set! tmp.87 (+ tmp.121 2)))
          (begin
            (mset! tmp.87 -2 L.fun/ascii-char8614.6.15)
            (mset! tmp.87 6 0)
            (set! fun/ascii-char8614.6 tmp.87)))
        (begin
          (begin (set! tmp.122 (alloc 16)) (set! tmp.88 (+ tmp.122 2)))
          (begin
            (mset! tmp.88 -2 L.fun/void8611.7.16)
            (mset! tmp.88 6 0)
            (set! fun/void8611.7 tmp.88)))
        (begin
          (mset! vector-init-loop.14 14 vector-init-loop.14)
          (mset! make-init-vector.1 14 vector-init-loop.14)
          (mset! make-vector.64 14 make-init-vector.1)
          (mset! fun/vector8612.5 14 make-vector.64)
          (begin
            (begin
              (begin
                (return-point L.rp.17
                  (begin
                    (set! rdx 1608)
                    (set! rsi 616)
                    (set! rdi *.65)
                    (set! r15 L.rp.17)
                    (jump L.*.65.9 rbp r15 rdi rsi rdx)))
                (set! tmp.123 rax))
              (begin
                (begin
                  (return-point L.rp.18
                    (begin
                      (set! rdx 320)
                      (set! rsi 424)
                      (set! rdi |-.66|)
                      (set! r15 L.rp.18)
                      (jump L.-.66.8 rbp r15 rdi rsi rdx)))
                  (set! tmp.124 rax))
                (begin
                  (return-point L.rp.19
                    (begin
                      (set! rdx tmp.124)
                      (set! rsi tmp.123)
                      (set! rdi |+.67|)
                      (set! r15 L.rp.19)
                      (jump L.+.67.7 rbp r15 rdi rsi rdx)))
                  (set! fixnum0.11 rax))))
            (begin
              (return-point L.rp.20
                (begin
                  (set! rdi fun/void8611.7)
                  (set! r15 L.rp.20)
                  (jump L.fun/void8611.7.16 rbp r15 rdi)))
              (set! void1.10 rax))
            (begin
              (return-point L.rp.21
                (begin
                  (set! rdi fun/vector8612.5)
                  (set! r15 L.rp.21)
                  (jump L.fun/vector8612.5.14 rbp r15 rdi)))
              (set! vector2.9 rax))
            (begin
              (return-point L.rp.22
                (begin
                  (set! rdi fun/ascii-char8613.4)
                  (set! r15 L.rp.22)
                  (jump L.fun/ascii-char8613.4.13 rbp r15 rdi)))
              (set! ascii-char3.8 rax))
            (begin
              (set! rdi fun/ascii-char8614.6)
              (set! r15 tmp-ra.135)
              (jump L.fun/ascii-char8614.6.15 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () ())))
    (define L.fun/void8618.6.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.123 r15)
        (begin
          (set! c.75 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.123 rbp rax))))))
    (define L.fun/vector8619.5.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.124 r15)
        (begin
          (set! c.74 rdi)
          (begin
            (set! make-vector.63 (mref c.74 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.63)
              (set! r15 tmp-ra.124)
              (jump L.make-vector.63.12 rbp r15 rdi rsi))))))
    (define L.fun/ascii-char8617.4.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.125 r15)
        (begin
          (set! c.73 rdi)
          (begin (begin (set! rax 22574) (jump tmp-ra.125 rbp rax))))))
    (define L.make-vector.63.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.126 r15)
        (begin
          (set! c.72 rdi)
          (set! tmp.39 rsi)
          (begin
            (set! make-init-vector.1 (mref c.72 14))
            (if (begin
                  (if (begin (set! tmp.87 (bitwise-and tmp.39 7)) (= tmp.87 0))
                    (set! tmp.86 14)
                    (set! tmp.86 6))
                  (!= tmp.86 6))
              (begin
                (set! rsi tmp.39)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.126)
                (jump L.make-init-vector.1.11 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.126 rbp rax)))))))
    (define L.make-init-vector.1.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.127 r15)
        (begin
          (set! c.71 rdi)
          (set! tmp.11 rsi)
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
              (begin
                (set! rcx tmp.12)
                (set! rdx 0)
                (set! rsi tmp.11)
                (set! rdi vector-init-loop.13)
                (set! r15 tmp-ra.127)
                (jump L.vector-init-loop.13.10 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.13.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.128 r15)
        (begin
          (set! c.70 rdi)
          (set! len.14 rsi)
          (set! i.16 rdx)
          (set! vec.15 rcx)
          (begin
            (set! vector-init-loop.13 (mref c.70 14))
            (if (begin
                  (if (= len.14 i.16) (set! tmp.92 14) (set! tmp.92 6))
                  (!= tmp.92 6))
              (begin (set! rax vec.15) (jump tmp-ra.128 rbp rax))
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
                  (begin
                    (set! rcx vec.15)
                    (set! rdx tmp.96)
                    (set! rsi len.14)
                    (set! rdi vector-init-loop.13)
                    (set! r15 tmp-ra.128)
                    (jump
                     L.vector-init-loop.13.10
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.+.64.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.129 r15)
        (begin
          (set! c.69 rdi)
          (set! tmp.27 rsi)
          (set! tmp.28 rdx)
          (begin
            (if (begin
                  (if (begin (set! tmp.98 (bitwise-and tmp.28 7)) (= tmp.98 0))
                    (set! tmp.97 14)
                    (set! tmp.97 6))
                  (!= tmp.97 6))
              (if (begin
                    (if (begin
                          (set! tmp.100 (bitwise-and tmp.27 7))
                          (= tmp.100 0))
                      (set! tmp.99 14)
                      (set! tmp.99 6))
                    (!= tmp.99 6))
                (begin (set! rax (+ tmp.27 tmp.28)) (jump tmp-ra.129 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.129 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.129 rbp rax)))))))
    (define L.*.65.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.130 r15)
        (begin
          (set! c.68 rdi)
          (set! tmp.25 rsi)
          (set! tmp.26 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.102 (bitwise-and tmp.26 7))
                        (= tmp.102 0))
                    (set! tmp.101 14)
                    (set! tmp.101 6))
                  (!= tmp.101 6))
              (if (begin
                    (if (begin
                          (set! tmp.104 (bitwise-and tmp.25 7))
                          (= tmp.104 0))
                      (set! tmp.103 14)
                      (set! tmp.103 6))
                    (!= tmp.103 6))
                (begin
                  (set! tmp.105 (arithmetic-shift-right tmp.26 3))
                  (begin
                    (set! rax (* tmp.25 tmp.105))
                    (jump tmp-ra.130 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.130 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.130 rbp rax)))))))
    (define L.-.66.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.131 r15)
        (begin
          (set! c.67 rdi)
          (set! tmp.29 rsi)
          (set! tmp.30 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.107 (bitwise-and tmp.30 7))
                        (= tmp.107 0))
                    (set! tmp.106 14)
                    (set! tmp.106 6))
                  (!= tmp.106 6))
              (if (begin
                    (if (begin
                          (set! tmp.109 (bitwise-and tmp.29 7))
                          (= tmp.109 0))
                      (set! tmp.108 14)
                      (set! tmp.108 6))
                    (!= tmp.108 6))
                (begin (set! rax (- tmp.29 tmp.30)) (jump tmp-ra.131 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.131 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.131 rbp rax)))))))
    (begin
      (set! tmp-ra.132 r15)
      (begin
        (begin
          (begin (set! tmp.110 (alloc 16)) (set! tmp.77 (+ tmp.110 2)))
          (begin
            (mset! tmp.77 -2 L.-.66.7)
            (mset! tmp.77 6 16)
            (set! |-.66| tmp.77)))
        (begin
          (begin (set! tmp.111 (alloc 16)) (set! tmp.78 (+ tmp.111 2)))
          (begin
            (mset! tmp.78 -2 L.*.65.8)
            (mset! tmp.78 6 16)
            (set! *.65 tmp.78)))
        (begin
          (begin (set! tmp.112 (alloc 16)) (set! tmp.79 (+ tmp.112 2)))
          (begin
            (mset! tmp.79 -2 L.+.64.9)
            (mset! tmp.79 6 16)
            (set! |+.64| tmp.79)))
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
            (mset! tmp.83 -2 L.fun/ascii-char8617.4.13)
            (mset! tmp.83 6 0)
            (set! fun/ascii-char8617.4 tmp.83)))
        (begin
          (begin (set! tmp.117 (alloc 24)) (set! tmp.84 (+ tmp.117 2)))
          (begin
            (mset! tmp.84 -2 L.fun/vector8619.5.14)
            (mset! tmp.84 6 0)
            (set! fun/vector8619.5 tmp.84)))
        (begin
          (begin (set! tmp.118 (alloc 16)) (set! tmp.85 (+ tmp.118 2)))
          (begin
            (mset! tmp.85 -2 L.fun/void8618.6.15)
            (mset! tmp.85 6 0)
            (set! fun/void8618.6 tmp.85)))
        (begin
          (mset! vector-init-loop.13 14 vector-init-loop.13)
          (mset! make-init-vector.1 14 vector-init-loop.13)
          (mset! make-vector.63 14 make-init-vector.1)
          (mset! fun/vector8619.5 14 make-vector.63)
          (begin
            (begin
              (begin
                (return-point L.rp.16
                  (begin
                    (set! rdx 976)
                    (set! rsi 1424)
                    (set! rdi |+.64|)
                    (set! r15 L.rp.16)
                    (jump L.+.64.9 rbp r15 rdi rsi rdx)))
                (set! tmp.119 rax))
              (begin
                (begin
                  (return-point L.rp.17
                    (begin
                      (set! rdx 696)
                      (set! rsi 456)
                      (set! rdi |+.64|)
                      (set! r15 L.rp.17)
                      (jump L.+.64.9 rbp r15 rdi rsi rdx)))
                  (set! tmp.120 rax))
                (begin
                  (return-point L.rp.18
                    (begin
                      (set! rdx tmp.120)
                      (set! rsi tmp.119)
                      (set! rdi *.65)
                      (set! r15 L.rp.18)
                      (jump L.*.65.8 rbp r15 rdi rsi rdx)))
                  (set! fixnum0.10 rax))))
            (begin
              (return-point L.rp.19
                (begin
                  (set! rdi fun/ascii-char8617.4)
                  (set! r15 L.rp.19)
                  (jump L.fun/ascii-char8617.4.13 rbp r15 rdi)))
              (set! ascii-char1.9 rax))
            (begin
              (begin
                (return-point L.rp.20
                  (begin
                    (set! rdx 16)
                    (set! rsi 216)
                    (set! rdi |-.66|)
                    (set! r15 L.rp.20)
                    (jump L.-.66.7 rbp r15 rdi rsi rdx)))
                (set! tmp.121 rax))
              (begin
                (begin
                  (return-point L.rp.21
                    (begin
                      (set! rdx 1256)
                      (set! rsi 256)
                      (set! rdi *.65)
                      (set! r15 L.rp.21)
                      (jump L.*.65.8 rbp r15 rdi rsi rdx)))
                  (set! tmp.122 rax))
                (begin
                  (return-point L.rp.22
                    (begin
                      (set! rdx tmp.122)
                      (set! rsi tmp.121)
                      (set! rdi |+.64|)
                      (set! r15 L.rp.22)
                      (jump L.+.64.9 rbp r15 rdi rsi rdx)))
                  (set! fixnum2.8 rax))))
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/void8618.6)
                  (set! r15 L.rp.23)
                  (jump L.fun/void8618.6.15 rbp r15 rdi)))
              (set! void3.7 rax))
            (begin
              (set! rdi fun/vector8619.5)
              (set! r15 tmp-ra.132)
              (jump L.fun/vector8619.5.14 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () ())))
    (define L.lam.68.17
      ((new-frames (())))
      (begin
        (set! tmp-ra.118 r15)
        (begin
          (set! c.79 rdi)
          (begin
            (set! fun/any8773.7 (mref c.79 14))
            (set! vector?.67 (mref c.79 22))
            (begin
              (begin
                (return-point L.rp.18
                  (begin
                    (set! rdi fun/any8773.7)
                    (set! r15 L.rp.18)
                    (jump L.fun/any8773.7.15 rbp r15 rdi)))
                (set! tmp.92 rax))
              (begin
                (set! rsi tmp.92)
                (set! rdi vector?.67)
                (set! r15 tmp-ra.118)
                (jump L.vector?.67.7 rbp r15 rdi rsi)))))))
    (define L.fun/vector8772.8.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.119 r15)
        (begin
          (set! c.78 rdi)
          (begin
            (set! make-vector.65 (mref c.78 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.65)
              (set! r15 tmp-ra.119)
              (jump L.make-vector.65.11 rbp r15 rdi rsi))))))
    (define L.fun/any8773.7.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.120 r15)
        (begin
          (set! c.77 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.120 rbp rax))))))
    (define L.fun/void8770.6.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.121 r15)
        (begin
          (set! c.76 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.121 rbp rax))))))
    (define L.fun/empty8774.5.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.122 r15)
        (begin
          (set! c.75 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.122 rbp rax))))))
    (define L.fun/any8771.4.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.123 r15)
        (begin
          (set! c.74 rdi)
          (begin
            (set! make-vector.65 (mref c.74 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.65)
              (set! r15 tmp-ra.123)
              (jump L.make-vector.65.11 rbp r15 rdi rsi))))))
    (define L.make-vector.65.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.124 r15)
        (begin
          (set! c.73 rdi)
          (set! tmp.41 rsi)
          (begin
            (set! make-init-vector.1 (mref c.73 14))
            (if (begin
                  (if (begin (set! tmp.94 (bitwise-and tmp.41 7)) (= tmp.94 0))
                    (set! tmp.93 14)
                    (set! tmp.93 6))
                  (!= tmp.93 6))
              (begin
                (set! rsi tmp.41)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.124)
                (jump L.make-init-vector.1.10 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.124 rbp rax)))))))
    (define L.make-init-vector.1.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.125 r15)
        (begin
          (set! c.72 rdi)
          (set! tmp.13 rsi)
          (begin
            (set! vector-init-loop.15 (mref c.72 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.98 (arithmetic-shift-right tmp.13 3))
                        (set! tmp.97 (+ 1 tmp.98)))
                      (set! tmp.96 (* tmp.97 8)))
                    (set! tmp.95 (alloc tmp.96)))
                  (set! tmp.80 (+ tmp.95 3)))
                (begin (mset! tmp.80 -3 tmp.13) (set! tmp.14 tmp.80)))
              (begin
                (set! rcx tmp.14)
                (set! rdx 0)
                (set! rsi tmp.13)
                (set! rdi vector-init-loop.15)
                (set! r15 tmp-ra.125)
                (jump L.vector-init-loop.15.9 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.15.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.126 r15)
        (begin
          (set! c.71 rdi)
          (set! len.16 rsi)
          (set! i.18 rdx)
          (set! vec.17 rcx)
          (begin
            (set! vector-init-loop.15 (mref c.71 14))
            (if (begin
                  (if (= len.16 i.18) (set! tmp.99 14) (set! tmp.99 6))
                  (!= tmp.99 6))
              (begin (set! rax vec.17) (jump tmp-ra.126 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.102 (arithmetic-shift-right i.18 3))
                      (set! tmp.101 (* tmp.102 8)))
                    (set! tmp.100 (+ tmp.101 5)))
                  (mset! vec.17 tmp.100 0))
                (begin
                  (set! tmp.103 (+ i.18 8))
                  (begin
                    (set! rcx vec.17)
                    (set! rdx tmp.103)
                    (set! rsi len.16)
                    (set! rdi vector-init-loop.15)
                    (set! r15 tmp-ra.126)
                    (jump
                     L.vector-init-loop.15.9
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.error?.66.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.127 r15)
        (begin
          (set! c.70 rdi)
          (set! tmp.55 rsi)
          (begin
            (if (begin (set! tmp.104 (bitwise-and tmp.55 255)) (= tmp.104 62))
              (begin (set! rax 14) (jump tmp-ra.127 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.127 rbp rax)))))))
    (define L.vector?.67.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.128 r15)
        (begin
          (set! c.69 rdi)
          (set! tmp.57 rsi)
          (begin
            (if (begin (set! tmp.105 (bitwise-and tmp.57 7)) (= tmp.105 3))
              (begin (set! rax 14) (jump tmp-ra.128 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.128 rbp rax)))))))
    (begin
      (set! tmp-ra.129 r15)
      (begin
        (begin
          (begin (set! tmp.106 (alloc 16)) (set! tmp.81 (+ tmp.106 2)))
          (begin
            (mset! tmp.81 -2 L.vector?.67.7)
            (mset! tmp.81 6 8)
            (set! vector?.67 tmp.81)))
        (begin
          (begin (set! tmp.107 (alloc 16)) (set! tmp.82 (+ tmp.107 2)))
          (begin
            (mset! tmp.82 -2 L.error?.66.8)
            (mset! tmp.82 6 8)
            (set! error?.66 tmp.82)))
        (begin
          (begin (set! tmp.108 (alloc 24)) (set! tmp.83 (+ tmp.108 2)))
          (begin
            (mset! tmp.83 -2 L.vector-init-loop.15.9)
            (mset! tmp.83 6 24)
            (set! vector-init-loop.15 tmp.83)))
        (begin
          (begin (set! tmp.109 (alloc 24)) (set! tmp.84 (+ tmp.109 2)))
          (begin
            (mset! tmp.84 -2 L.make-init-vector.1.10)
            (mset! tmp.84 6 8)
            (set! make-init-vector.1 tmp.84)))
        (begin
          (begin (set! tmp.110 (alloc 24)) (set! tmp.85 (+ tmp.110 2)))
          (begin
            (mset! tmp.85 -2 L.make-vector.65.11)
            (mset! tmp.85 6 8)
            (set! make-vector.65 tmp.85)))
        (begin
          (begin (set! tmp.111 (alloc 24)) (set! tmp.86 (+ tmp.111 2)))
          (begin
            (mset! tmp.86 -2 L.fun/any8771.4.12)
            (mset! tmp.86 6 0)
            (set! fun/any8771.4 tmp.86)))
        (begin
          (begin (set! tmp.112 (alloc 16)) (set! tmp.87 (+ tmp.112 2)))
          (begin
            (mset! tmp.87 -2 L.fun/empty8774.5.13)
            (mset! tmp.87 6 0)
            (set! fun/empty8774.5 tmp.87)))
        (begin
          (begin (set! tmp.113 (alloc 16)) (set! tmp.88 (+ tmp.113 2)))
          (begin
            (mset! tmp.88 -2 L.fun/void8770.6.14)
            (mset! tmp.88 6 0)
            (set! fun/void8770.6 tmp.88)))
        (begin
          (begin (set! tmp.114 (alloc 16)) (set! tmp.89 (+ tmp.114 2)))
          (begin
            (mset! tmp.89 -2 L.fun/any8773.7.15)
            (mset! tmp.89 6 0)
            (set! fun/any8773.7 tmp.89)))
        (begin
          (begin (set! tmp.115 (alloc 24)) (set! tmp.90 (+ tmp.115 2)))
          (begin
            (mset! tmp.90 -2 L.fun/vector8772.8.16)
            (mset! tmp.90 6 0)
            (set! fun/vector8772.8 tmp.90)))
        (begin
          (mset! vector-init-loop.15 14 vector-init-loop.15)
          (mset! make-init-vector.1 14 vector-init-loop.15)
          (mset! make-vector.65 14 make-init-vector.1)
          (mset! fun/any8771.4 14 make-vector.65)
          (mset! fun/vector8772.8 14 make-vector.65)
          (begin
            (begin
              (return-point L.rp.19
                (begin
                  (set! rdi fun/void8770.6)
                  (set! r15 L.rp.19)
                  (jump L.fun/void8770.6.14 rbp r15 rdi)))
              (set! void0.12 rax))
            (begin
              (begin
                (return-point L.rp.20
                  (begin
                    (set! rdi fun/any8771.4)
                    (set! r15 L.rp.20)
                    (jump L.fun/any8771.4.12 rbp r15 rdi)))
                (set! tmp.116 rax))
              (begin
                (return-point L.rp.21
                  (begin
                    (set! rsi tmp.116)
                    (set! rdi error?.66)
                    (set! r15 L.rp.21)
                    (jump L.error?.66.8 rbp r15 rdi rsi)))
                (set! boolean1.11 rax)))
            (begin
              (return-point L.rp.22
                (begin
                  (set! rdi fun/vector8772.8)
                  (set! r15 L.rp.22)
                  (jump L.fun/vector8772.8.16 rbp r15 rdi)))
              (set! vector2.10 rax))
            (begin
              (begin
                (begin (set! tmp.117 (alloc 32)) (set! tmp.91 (+ tmp.117 2)))
                (begin
                  (mset! tmp.91 -2 L.lam.68.17)
                  (mset! tmp.91 6 0)
                  (set! lam.68 tmp.91)))
              (begin
                (mset! lam.68 14 fun/any8773.7)
                (mset! lam.68 22 vector?.67)
                (set! procedure3.9 lam.68)))
            (begin
              (set! rdi fun/empty8774.5)
              (set! r15 tmp-ra.129)
              (jump L.fun/empty8774.5.13 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () ())))
    (define L.lam.77.25
      ((new-frames ()))
      (begin
        (set! tmp-ra.168 r15)
        (begin
          (set! c.96 rdi)
          (begin
            (set! fun/vector9404.8 (mref c.96 14))
            (begin
              (set! rdi fun/vector9404.8)
              (set! r15 tmp-ra.168)
              (jump L.fun/vector9404.8.18 rbp r15 rdi))))))
    (define L.lam.76.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.169 r15)
        (begin
          (set! c.95 rdi)
          (begin
            (set! fun/pair9400.7 (mref c.95 14))
            (begin
              (set! rdi fun/pair9400.7)
              (set! r15 tmp-ra.169)
              (jump L.fun/pair9400.7.17 rbp r15 rdi))))))
    (define L.fun/ascii-char9402.13.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.170 r15)
        (begin
          (set! c.94 rdi)
          (begin
            (set! fun/ascii-char9403.6 (mref c.94 14))
            (begin
              (set! rdi fun/ascii-char9403.6)
              (set! r15 tmp-ra.170)
              (jump L.fun/ascii-char9403.6.16 rbp r15 rdi))))))
    (define L.fun/pair9401.12.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.171 r15)
        (begin
          (set! c.93 rdi)
          (begin
            (set! cons.72 (mref c.93 14))
            (begin
              (set! rdx 3016)
              (set! rsi 1936)
              (set! rdi cons.72)
              (set! r15 tmp-ra.171)
              (jump L.cons.72.10 rbp r15 rdi rsi rdx))))))
    (define L.fun/vector9405.11.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.172 r15)
        (begin
          (set! c.92 rdi)
          (begin
            (set! make-vector.71 (mref c.92 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.71)
              (set! r15 tmp-ra.172)
              (jump L.make-vector.71.13 rbp r15 rdi rsi))))))
    (define L.fun/empty9406.10.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.173 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/empty9407.5 (mref c.91 14))
            (begin
              (set! rdi fun/empty9407.5)
              (set! r15 tmp-ra.173)
              (jump L.fun/empty9407.5.15 rbp r15 rdi))))))
    (define L.fun/void9399.9.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.174 r15)
        (begin
          (set! c.90 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.174 rbp rax))))))
    (define L.fun/vector9404.8.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.175 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/vector9405.11 (mref c.89 14))
            (begin
              (set! rdi fun/vector9405.11)
              (set! r15 tmp-ra.175)
              (jump L.fun/vector9405.11.21 rbp r15 rdi))))))
    (define L.fun/pair9400.7.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.176 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! fun/pair9401.12 (mref c.88 14))
            (begin
              (set! rdi fun/pair9401.12)
              (set! r15 tmp-ra.176)
              (jump L.fun/pair9401.12.22 rbp r15 rdi))))))
    (define L.fun/ascii-char9403.6.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.177 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 25646) (jump tmp-ra.177 rbp rax))))))
    (define L.fun/empty9407.5.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.178 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.178 rbp rax))))))
    (define L.fun/void9398.4.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.179 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/void9399.9 (mref c.85 14))
            (begin
              (set! rdi fun/void9399.9)
              (set! r15 tmp-ra.179)
              (jump L.fun/void9399.9.19 rbp r15 rdi))))))
    (define L.make-vector.71.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.180 r15)
        (begin
          (set! c.84 rdi)
          (set! tmp.47 rsi)
          (begin
            (set! make-init-vector.1 (mref c.84 14))
            (if (begin
                  (if (begin
                        (set! tmp.119 (bitwise-and tmp.47 7))
                        (= tmp.119 0))
                    (set! tmp.118 14)
                    (set! tmp.118 6))
                  (!= tmp.118 6))
              (begin
                (set! rsi tmp.47)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.180)
                (jump L.make-init-vector.1.12 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.180 rbp rax)))))))
    (define L.make-init-vector.1.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.181 r15)
        (begin
          (set! c.83 rdi)
          (set! tmp.19 rsi)
          (begin
            (set! vector-init-loop.21 (mref c.83 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.123 (arithmetic-shift-right tmp.19 3))
                        (set! tmp.122 (+ 1 tmp.123)))
                      (set! tmp.121 (* tmp.122 8)))
                    (set! tmp.120 (alloc tmp.121)))
                  (set! tmp.97 (+ tmp.120 3)))
                (begin (mset! tmp.97 -3 tmp.19) (set! tmp.20 tmp.97)))
              (begin
                (set! rcx tmp.20)
                (set! rdx 0)
                (set! rsi tmp.19)
                (set! rdi vector-init-loop.21)
                (set! r15 tmp-ra.181)
                (jump L.vector-init-loop.21.11 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.21.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.182 r15)
        (begin
          (set! c.82 rdi)
          (set! len.22 rsi)
          (set! i.24 rdx)
          (set! vec.23 rcx)
          (begin
            (set! vector-init-loop.21 (mref c.82 14))
            (if (begin
                  (if (= len.22 i.24) (set! tmp.124 14) (set! tmp.124 6))
                  (!= tmp.124 6))
              (begin (set! rax vec.23) (jump tmp-ra.182 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.127 (arithmetic-shift-right i.24 3))
                      (set! tmp.126 (* tmp.127 8)))
                    (set! tmp.125 (+ tmp.126 5)))
                  (mset! vec.23 tmp.125 0))
                (begin
                  (set! tmp.128 (+ i.24 8))
                  (begin
                    (set! rcx vec.23)
                    (set! rdx tmp.128)
                    (set! rsi len.22)
                    (set! rdi vector-init-loop.21)
                    (set! r15 tmp-ra.182)
                    (jump
                     L.vector-init-loop.21.11
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.cons.72.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.183 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.66 rsi)
          (set! tmp.67 rdx)
          (begin
            (begin
              (begin (set! tmp.129 (alloc 16)) (set! tmp.98 (+ tmp.129 1)))
              (begin
                (mset! tmp.98 -1 tmp.66)
                (mset! tmp.98 7 tmp.67)
                (begin (set! rax tmp.98) (jump tmp-ra.183 rbp rax))))))))
    (define L.*.73.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.184 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.33 rsi)
          (set! tmp.34 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.131 (bitwise-and tmp.34 7))
                        (= tmp.131 0))
                    (set! tmp.130 14)
                    (set! tmp.130 6))
                  (!= tmp.130 6))
              (if (begin
                    (if (begin
                          (set! tmp.133 (bitwise-and tmp.33 7))
                          (= tmp.133 0))
                      (set! tmp.132 14)
                      (set! tmp.132 6))
                    (!= tmp.132 6))
                (begin
                  (set! tmp.134 (arithmetic-shift-right tmp.34 3))
                  (begin
                    (set! rax (* tmp.33 tmp.134))
                    (jump tmp-ra.184 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.184 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.184 rbp rax)))))))
    (define L.-.74.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.185 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.37 rsi)
          (set! tmp.38 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.136 (bitwise-and tmp.38 7))
                        (= tmp.136 0))
                    (set! tmp.135 14)
                    (set! tmp.135 6))
                  (!= tmp.135 6))
              (if (begin
                    (if (begin
                          (set! tmp.138 (bitwise-and tmp.37 7))
                          (= tmp.138 0))
                      (set! tmp.137 14)
                      (set! tmp.137 6))
                    (!= tmp.137 6))
                (begin (set! rax (- tmp.37 tmp.38)) (jump tmp-ra.185 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.185 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.185 rbp rax)))))))
    (define L.+.75.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.186 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.35 rsi)
          (set! tmp.36 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.140 (bitwise-and tmp.36 7))
                        (= tmp.140 0))
                    (set! tmp.139 14)
                    (set! tmp.139 6))
                  (!= tmp.139 6))
              (if (begin
                    (if (begin
                          (set! tmp.142 (bitwise-and tmp.35 7))
                          (= tmp.142 0))
                      (set! tmp.141 14)
                      (set! tmp.141 6))
                    (!= tmp.141 6))
                (begin (set! rax (+ tmp.35 tmp.36)) (jump tmp-ra.186 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.186 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.186 rbp rax)))))))
    (begin
      (set! tmp-ra.187 r15)
      (begin
        (begin
          (begin (set! tmp.143 (alloc 16)) (set! tmp.99 (+ tmp.143 2)))
          (begin
            (mset! tmp.99 -2 L.+.75.7)
            (mset! tmp.99 6 16)
            (set! |+.75| tmp.99)))
        (begin
          (begin (set! tmp.144 (alloc 16)) (set! tmp.100 (+ tmp.144 2)))
          (begin
            (mset! tmp.100 -2 L.-.74.8)
            (mset! tmp.100 6 16)
            (set! |-.74| tmp.100)))
        (begin
          (begin (set! tmp.145 (alloc 16)) (set! tmp.101 (+ tmp.145 2)))
          (begin
            (mset! tmp.101 -2 L.*.73.9)
            (mset! tmp.101 6 16)
            (set! *.73 tmp.101)))
        (begin
          (begin (set! tmp.146 (alloc 16)) (set! tmp.102 (+ tmp.146 2)))
          (begin
            (mset! tmp.102 -2 L.cons.72.10)
            (mset! tmp.102 6 16)
            (set! cons.72 tmp.102)))
        (begin
          (begin (set! tmp.147 (alloc 24)) (set! tmp.103 (+ tmp.147 2)))
          (begin
            (mset! tmp.103 -2 L.vector-init-loop.21.11)
            (mset! tmp.103 6 24)
            (set! vector-init-loop.21 tmp.103)))
        (begin
          (begin (set! tmp.148 (alloc 24)) (set! tmp.104 (+ tmp.148 2)))
          (begin
            (mset! tmp.104 -2 L.make-init-vector.1.12)
            (mset! tmp.104 6 8)
            (set! make-init-vector.1 tmp.104)))
        (begin
          (begin (set! tmp.149 (alloc 24)) (set! tmp.105 (+ tmp.149 2)))
          (begin
            (mset! tmp.105 -2 L.make-vector.71.13)
            (mset! tmp.105 6 8)
            (set! make-vector.71 tmp.105)))
        (begin
          (begin (set! tmp.150 (alloc 24)) (set! tmp.106 (+ tmp.150 2)))
          (begin
            (mset! tmp.106 -2 L.fun/void9398.4.14)
            (mset! tmp.106 6 0)
            (set! fun/void9398.4 tmp.106)))
        (begin
          (begin (set! tmp.151 (alloc 16)) (set! tmp.107 (+ tmp.151 2)))
          (begin
            (mset! tmp.107 -2 L.fun/empty9407.5.15)
            (mset! tmp.107 6 0)
            (set! fun/empty9407.5 tmp.107)))
        (begin
          (begin (set! tmp.152 (alloc 16)) (set! tmp.108 (+ tmp.152 2)))
          (begin
            (mset! tmp.108 -2 L.fun/ascii-char9403.6.16)
            (mset! tmp.108 6 0)
            (set! fun/ascii-char9403.6 tmp.108)))
        (begin
          (begin (set! tmp.153 (alloc 24)) (set! tmp.109 (+ tmp.153 2)))
          (begin
            (mset! tmp.109 -2 L.fun/pair9400.7.17)
            (mset! tmp.109 6 0)
            (set! fun/pair9400.7 tmp.109)))
        (begin
          (begin (set! tmp.154 (alloc 24)) (set! tmp.110 (+ tmp.154 2)))
          (begin
            (mset! tmp.110 -2 L.fun/vector9404.8.18)
            (mset! tmp.110 6 0)
            (set! fun/vector9404.8 tmp.110)))
        (begin
          (begin (set! tmp.155 (alloc 16)) (set! tmp.111 (+ tmp.155 2)))
          (begin
            (mset! tmp.111 -2 L.fun/void9399.9.19)
            (mset! tmp.111 6 0)
            (set! fun/void9399.9 tmp.111)))
        (begin
          (begin (set! tmp.156 (alloc 24)) (set! tmp.112 (+ tmp.156 2)))
          (begin
            (mset! tmp.112 -2 L.fun/empty9406.10.20)
            (mset! tmp.112 6 0)
            (set! fun/empty9406.10 tmp.112)))
        (begin
          (begin (set! tmp.157 (alloc 24)) (set! tmp.113 (+ tmp.157 2)))
          (begin
            (mset! tmp.113 -2 L.fun/vector9405.11.21)
            (mset! tmp.113 6 0)
            (set! fun/vector9405.11 tmp.113)))
        (begin
          (begin (set! tmp.158 (alloc 24)) (set! tmp.114 (+ tmp.158 2)))
          (begin
            (mset! tmp.114 -2 L.fun/pair9401.12.22)
            (mset! tmp.114 6 0)
            (set! fun/pair9401.12 tmp.114)))
        (begin
          (begin (set! tmp.159 (alloc 24)) (set! tmp.115 (+ tmp.159 2)))
          (begin
            (mset! tmp.115 -2 L.fun/ascii-char9402.13.23)
            (mset! tmp.115 6 0)
            (set! fun/ascii-char9402.13 tmp.115)))
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
          (begin
            (begin
              (return-point L.rp.26
                (begin
                  (set! rdi fun/void9398.4)
                  (set! r15 L.rp.26)
                  (jump L.fun/void9398.4.14 rbp r15 rdi)))
              (set! void0.18 rax))
            (begin
              (begin
                (begin
                  (return-point L.rp.27
                    (begin
                      (set! rdx 752)
                      (set! rsi 1960)
                      (set! rdi *.73)
                      (set! r15 L.rp.27)
                      (jump L.*.73.9 rbp r15 rdi rsi rdx)))
                  (set! tmp.161 rax))
                (begin
                  (begin
                    (return-point L.rp.28
                      (begin
                        (set! rdx 1608)
                        (set! rsi 752)
                        (set! rdi |-.74|)
                        (set! r15 L.rp.28)
                        (jump L.-.74.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.162 rax))
                  (begin
                    (return-point L.rp.29
                      (begin
                        (set! rdx tmp.162)
                        (set! rsi tmp.161)
                        (set! rdi *.73)
                        (set! r15 L.rp.29)
                        (jump L.*.73.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.160 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.30
                      (begin
                        (set! rdx 128)
                        (set! rsi 1800)
                        (set! rdi |-.74|)
                        (set! r15 L.rp.30)
                        (jump L.-.74.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.164 rax))
                  (begin
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx 1392)
                          (set! rsi 368)
                          (set! rdi |+.75|)
                          (set! r15 L.rp.31)
                          (jump L.+.75.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.165 rax))
                    (begin
                      (return-point L.rp.32
                        (begin
                          (set! rdx tmp.165)
                          (set! rsi tmp.164)
                          (set! rdi |+.75|)
                          (set! r15 L.rp.32)
                          (jump L.+.75.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.163 rax))))
                (begin
                  (return-point L.rp.33
                    (begin
                      (set! rdx tmp.163)
                      (set! rsi tmp.160)
                      (set! rdi |-.74|)
                      (set! r15 L.rp.33)
                      (jump L.-.74.8 rbp r15 rdi rsi rdx)))
                  (set! fixnum1.17 rax))))
            (begin
              (begin
                (begin (set! tmp.166 (alloc 24)) (set! tmp.116 (+ tmp.166 2)))
                (begin
                  (mset! tmp.116 -2 L.lam.76.24)
                  (mset! tmp.116 6 0)
                  (set! lam.76 tmp.116)))
              (begin
                (mset! lam.76 14 fun/pair9400.7)
                (set! procedure2.16 lam.76)))
            (begin
              (return-point L.rp.34
                (begin
                  (set! rdi fun/ascii-char9402.13)
                  (set! r15 L.rp.34)
                  (jump L.fun/ascii-char9402.13.23 rbp r15 rdi)))
              (set! ascii-char3.15 rax))
            (begin
              (begin
                (begin (set! tmp.167 (alloc 24)) (set! tmp.117 (+ tmp.167 2)))
                (begin
                  (mset! tmp.117 -2 L.lam.77.25)
                  (mset! tmp.117 6 0)
                  (set! lam.77 tmp.117)))
              (begin
                (mset! lam.77 14 fun/vector9404.8)
                (set! procedure4.14 lam.77)))
            (begin
              (set! rdi fun/empty9406.10)
              (set! r15 tmp-ra.187)
              (jump L.fun/empty9406.10.20 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () ())))
    (define L.fun/pair13318.15.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.155 r15)
        (begin
          (set! c.93 rdi)
          (begin
            (set! fun/pair13319.9 (mref c.93 14))
            (begin
              (set! rdi fun/pair13319.9)
              (set! r15 tmp-ra.155)
              (jump L.fun/pair13319.9.16 rbp r15 rdi))))))
    (define L.fun/void13311.14.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.92 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.156 rbp rax))))))
    (define L.fun/ascii-char13314.13.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.157 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/ascii-char13315.5 (mref c.91 14))
            (begin
              (set! rdi fun/ascii-char13315.5)
              (set! r15 tmp-ra.157)
              (jump L.fun/ascii-char13315.5.12 rbp r15 rdi))))))
    (define L.fun/error13309.12.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.90 rdi)
          (begin (begin (set! rax 63550) (jump tmp-ra.158 rbp rax))))))
    (define L.fun/empty13317.11.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.159 rbp rax))))))
    (define L.fun/void13310.10.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! fun/void13311.14 (mref c.88 14))
            (begin
              (set! rdi fun/void13311.14)
              (set! r15 tmp-ra.160)
              (jump L.fun/void13311.14.21 rbp r15 rdi))))))
    (define L.fun/pair13319.9.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! cons.74 (mref c.87 14))
            (begin
              (set! rdx 3512)
              (set! rsi 1944)
              (set! rdi cons.74)
              (set! r15 tmp-ra.161)
              (jump L.cons.74.10 rbp r15 rdi rsi rdx))))))
    (define L.fun/error13312.8.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! fun/error13313.6 (mref c.86 14))
            (begin
              (set! rdi fun/error13313.6)
              (set! r15 tmp-ra.162)
              (jump L.fun/error13313.6.13 rbp r15 rdi))))))
    (define L.fun/error13308.7.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/error13309.12 (mref c.85 14))
            (begin
              (set! rdi fun/error13309.12)
              (set! r15 tmp-ra.163)
              (jump L.fun/error13309.12.19 rbp r15 rdi))))))
    (define L.fun/error13313.6.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.164 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 15678) (jump tmp-ra.164 rbp rax))))))
    (define L.fun/ascii-char13315.5.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.165 r15)
        (begin
          (set! c.83 rdi)
          (begin (begin (set! rax 25646) (jump tmp-ra.165 rbp rax))))))
    (define L.fun/empty13316.4.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.166 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/empty13317.11 (mref c.82 14))
            (begin
              (set! rdi fun/empty13317.11)
              (set! r15 tmp-ra.166)
              (jump L.fun/empty13317.11.18 rbp r15 rdi))))))
    (define L.cons.74.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.167 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.69 rsi)
          (set! tmp.70 rdx)
          (begin
            (begin
              (begin (set! tmp.111 (alloc 16)) (set! tmp.94 (+ tmp.111 1)))
              (begin
                (mset! tmp.94 -1 tmp.69)
                (mset! tmp.94 7 tmp.70)
                (begin (set! rax tmp.94) (jump tmp-ra.167 rbp rax))))))))
    (define L.+.75.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.168 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.113 (bitwise-and tmp.39 7))
                        (= tmp.113 0))
                    (set! tmp.112 14)
                    (set! tmp.112 6))
                  (!= tmp.112 6))
              (if (begin
                    (if (begin
                          (set! tmp.115 (bitwise-and tmp.38 7))
                          (= tmp.115 0))
                      (set! tmp.114 14)
                      (set! tmp.114 6))
                    (!= tmp.114 6))
                (begin (set! rax (+ tmp.38 tmp.39)) (jump tmp-ra.168 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.168 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.168 rbp rax)))))))
    (define L.*.76.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.169 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.117 (bitwise-and tmp.37 7))
                        (= tmp.117 0))
                    (set! tmp.116 14)
                    (set! tmp.116 6))
                  (!= tmp.116 6))
              (if (begin
                    (if (begin
                          (set! tmp.119 (bitwise-and tmp.36 7))
                          (= tmp.119 0))
                      (set! tmp.118 14)
                      (set! tmp.118 6))
                    (!= tmp.118 6))
                (begin
                  (set! tmp.120 (arithmetic-shift-right tmp.37 3))
                  (begin
                    (set! rax (* tmp.36 tmp.120))
                    (jump tmp-ra.169 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.169 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.169 rbp rax)))))))
    (define L.-.77.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.170 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.40 rsi)
          (set! tmp.41 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.122 (bitwise-and tmp.41 7))
                        (= tmp.122 0))
                    (set! tmp.121 14)
                    (set! tmp.121 6))
                  (!= tmp.121 6))
              (if (begin
                    (if (begin
                          (set! tmp.124 (bitwise-and tmp.40 7))
                          (= tmp.124 0))
                      (set! tmp.123 14)
                      (set! tmp.123 6))
                    (!= tmp.123 6))
                (begin (set! rax (- tmp.40 tmp.41)) (jump tmp-ra.170 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.170 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.170 rbp rax)))))))
    (begin
      (set! tmp-ra.171 r15)
      (begin
        (begin
          (begin (set! tmp.125 (alloc 16)) (set! tmp.95 (+ tmp.125 2)))
          (begin
            (mset! tmp.95 -2 L.-.77.7)
            (mset! tmp.95 6 16)
            (set! |-.77| tmp.95)))
        (begin
          (begin (set! tmp.126 (alloc 16)) (set! tmp.96 (+ tmp.126 2)))
          (begin
            (mset! tmp.96 -2 L.*.76.8)
            (mset! tmp.96 6 16)
            (set! *.76 tmp.96)))
        (begin
          (begin (set! tmp.127 (alloc 16)) (set! tmp.97 (+ tmp.127 2)))
          (begin
            (mset! tmp.97 -2 L.+.75.9)
            (mset! tmp.97 6 16)
            (set! |+.75| tmp.97)))
        (begin
          (begin (set! tmp.128 (alloc 16)) (set! tmp.98 (+ tmp.128 2)))
          (begin
            (mset! tmp.98 -2 L.cons.74.10)
            (mset! tmp.98 6 16)
            (set! cons.74 tmp.98)))
        (begin
          (begin (set! tmp.129 (alloc 24)) (set! tmp.99 (+ tmp.129 2)))
          (begin
            (mset! tmp.99 -2 L.fun/empty13316.4.11)
            (mset! tmp.99 6 0)
            (set! fun/empty13316.4 tmp.99)))
        (begin
          (begin (set! tmp.130 (alloc 16)) (set! tmp.100 (+ tmp.130 2)))
          (begin
            (mset! tmp.100 -2 L.fun/ascii-char13315.5.12)
            (mset! tmp.100 6 0)
            (set! fun/ascii-char13315.5 tmp.100)))
        (begin
          (begin (set! tmp.131 (alloc 16)) (set! tmp.101 (+ tmp.131 2)))
          (begin
            (mset! tmp.101 -2 L.fun/error13313.6.13)
            (mset! tmp.101 6 0)
            (set! fun/error13313.6 tmp.101)))
        (begin
          (begin (set! tmp.132 (alloc 24)) (set! tmp.102 (+ tmp.132 2)))
          (begin
            (mset! tmp.102 -2 L.fun/error13308.7.14)
            (mset! tmp.102 6 0)
            (set! fun/error13308.7 tmp.102)))
        (begin
          (begin (set! tmp.133 (alloc 24)) (set! tmp.103 (+ tmp.133 2)))
          (begin
            (mset! tmp.103 -2 L.fun/error13312.8.15)
            (mset! tmp.103 6 0)
            (set! fun/error13312.8 tmp.103)))
        (begin
          (begin (set! tmp.134 (alloc 24)) (set! tmp.104 (+ tmp.134 2)))
          (begin
            (mset! tmp.104 -2 L.fun/pair13319.9.16)
            (mset! tmp.104 6 0)
            (set! fun/pair13319.9 tmp.104)))
        (begin
          (begin (set! tmp.135 (alloc 24)) (set! tmp.105 (+ tmp.135 2)))
          (begin
            (mset! tmp.105 -2 L.fun/void13310.10.17)
            (mset! tmp.105 6 0)
            (set! fun/void13310.10 tmp.105)))
        (begin
          (begin (set! tmp.136 (alloc 16)) (set! tmp.106 (+ tmp.136 2)))
          (begin
            (mset! tmp.106 -2 L.fun/empty13317.11.18)
            (mset! tmp.106 6 0)
            (set! fun/empty13317.11 tmp.106)))
        (begin
          (begin (set! tmp.137 (alloc 16)) (set! tmp.107 (+ tmp.137 2)))
          (begin
            (mset! tmp.107 -2 L.fun/error13309.12.19)
            (mset! tmp.107 6 0)
            (set! fun/error13309.12 tmp.107)))
        (begin
          (begin (set! tmp.138 (alloc 24)) (set! tmp.108 (+ tmp.138 2)))
          (begin
            (mset! tmp.108 -2 L.fun/ascii-char13314.13.20)
            (mset! tmp.108 6 0)
            (set! fun/ascii-char13314.13 tmp.108)))
        (begin
          (begin (set! tmp.139 (alloc 16)) (set! tmp.109 (+ tmp.139 2)))
          (begin
            (mset! tmp.109 -2 L.fun/void13311.14.21)
            (mset! tmp.109 6 0)
            (set! fun/void13311.14 tmp.109)))
        (begin
          (begin (set! tmp.140 (alloc 24)) (set! tmp.110 (+ tmp.140 2)))
          (begin
            (mset! tmp.110 -2 L.fun/pair13318.15.22)
            (mset! tmp.110 6 0)
            (set! fun/pair13318.15 tmp.110)))
        (begin
          (mset! fun/empty13316.4 14 fun/empty13317.11)
          (mset! fun/error13308.7 14 fun/error13309.12)
          (mset! fun/error13312.8 14 fun/error13313.6)
          (mset! fun/pair13319.9 14 cons.74)
          (mset! fun/void13310.10 14 fun/void13311.14)
          (mset! fun/ascii-char13314.13 14 fun/ascii-char13315.5)
          (mset! fun/pair13318.15 14 fun/pair13319.9)
          (begin
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/error13308.7)
                  (set! r15 L.rp.23)
                  (jump L.fun/error13308.7.14 rbp r15 rdi)))
              (set! error0.21 rax))
            (begin
              (return-point L.rp.24
                (begin
                  (set! rdi fun/void13310.10)
                  (set! r15 L.rp.24)
                  (jump L.fun/void13310.10.17 rbp r15 rdi)))
              (set! void1.20 rax))
            (begin
              (return-point L.rp.25
                (begin
                  (set! rdi fun/error13312.8)
                  (set! r15 L.rp.25)
                  (jump L.fun/error13312.8.15 rbp r15 rdi)))
              (set! error2.19 rax))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.26
                      (begin
                        (set! rdx 2000)
                        (set! rsi 872)
                        (set! rdi |+.75|)
                        (set! r15 L.rp.26)
                        (jump L.+.75.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.143 rax))
                  (begin
                    (begin
                      (return-point L.rp.27
                        (begin
                          (set! rdx 1184)
                          (set! rsi 1816)
                          (set! rdi *.76)
                          (set! r15 L.rp.27)
                          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.144 rax))
                    (begin
                      (return-point L.rp.28
                        (begin
                          (set! rdx tmp.144)
                          (set! rsi tmp.143)
                          (set! rdi |+.75|)
                          (set! r15 L.rp.28)
                          (jump L.+.75.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.142 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.29
                        (begin
                          (set! rdx 1040)
                          (set! rsi 1720)
                          (set! rdi |-.77|)
                          (set! r15 L.rp.29)
                          (jump L.-.77.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.146 rax))
                    (begin
                      (begin
                        (return-point L.rp.30
                          (begin
                            (set! rdx 240)
                            (set! rsi 1784)
                            (set! rdi *.76)
                            (set! r15 L.rp.30)
                            (jump L.*.76.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.147 rax))
                      (begin
                        (return-point L.rp.31
                          (begin
                            (set! rdx tmp.147)
                            (set! rsi tmp.146)
                            (set! rdi *.76)
                            (set! r15 L.rp.31)
                            (jump L.*.76.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.145 rax))))
                  (begin
                    (return-point L.rp.32
                      (begin
                        (set! rdx tmp.145)
                        (set! rsi tmp.142)
                        (set! rdi |-.77|)
                        (set! r15 L.rp.32)
                        (jump L.-.77.7 rbp r15 rdi rsi rdx)))
                    (set! tmp.141 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.33
                        (begin
                          (set! rdx 8)
                          (set! rsi 1976)
                          (set! rdi *.76)
                          (set! r15 L.rp.33)
                          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.150 rax))
                    (begin
                      (begin
                        (return-point L.rp.34
                          (begin
                            (set! rdx 480)
                            (set! rsi 504)
                            (set! rdi *.76)
                            (set! r15 L.rp.34)
                            (jump L.*.76.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.151 rax))
                      (begin
                        (return-point L.rp.35
                          (begin
                            (set! rdx tmp.151)
                            (set! rsi tmp.150)
                            (set! rdi |-.77|)
                            (set! r15 L.rp.35)
                            (jump L.-.77.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.149 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.36
                          (begin
                            (set! rdx 1664)
                            (set! rsi 1664)
                            (set! rdi *.76)
                            (set! r15 L.rp.36)
                            (jump L.*.76.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.153 rax))
                      (begin
                        (begin
                          (return-point L.rp.37
                            (begin
                              (set! rdx 1024)
                              (set! rsi 1472)
                              (set! rdi |-.77|)
                              (set! r15 L.rp.37)
                              (jump L.-.77.7 rbp r15 rdi rsi rdx)))
                          (set! tmp.154 rax))
                        (begin
                          (return-point L.rp.38
                            (begin
                              (set! rdx tmp.154)
                              (set! rsi tmp.153)
                              (set! rdi |+.75|)
                              (set! r15 L.rp.38)
                              (jump L.+.75.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.152 rax))))
                    (begin
                      (return-point L.rp.39
                        (begin
                          (set! rdx tmp.152)
                          (set! rsi tmp.149)
                          (set! rdi *.76)
                          (set! r15 L.rp.39)
                          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.148 rax))))
                (begin
                  (return-point L.rp.40
                    (begin
                      (set! rdx tmp.148)
                      (set! rsi tmp.141)
                      (set! rdi |-.77|)
                      (set! r15 L.rp.40)
                      (jump L.-.77.7 rbp r15 rdi rsi rdx)))
                  (set! fixnum3.18 rax))))
            (begin
              (return-point L.rp.41
                (begin
                  (set! rdi fun/ascii-char13314.13)
                  (set! r15 L.rp.41)
                  (jump L.fun/ascii-char13314.13.20 rbp r15 rdi)))
              (set! ascii-char4.17 rax))
            (begin
              (return-point L.rp.42
                (begin
                  (set! rdi fun/empty13316.4)
                  (set! r15 L.rp.42)
                  (jump L.fun/empty13316.4.11 rbp r15 rdi)))
              (set! empty5.16 rax))
            (begin
              (set! rdi fun/pair13318.15)
              (set! r15 tmp-ra.171)
              (jump L.fun/pair13318.15.22 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames
      (()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ())))
    (define L.lam.74.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.178 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/vector13354.8 (mref c.89 14))
            (begin
              (set! rdi fun/vector13354.8)
              (set! r15 tmp-ra.178)
              (jump L.fun/vector13354.8.17 rbp r15 rdi))))))
    (define L.fun/ascii-char13353.11.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.179 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 18478) (jump tmp-ra.179 rbp rax))))))
    (define L.fun/error13359.10.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.180 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 1086) (jump tmp-ra.180 rbp rax))))))
    (define L.fun/vector13356.9.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.181 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! fun/vector13357.5 (mref c.86 14))
            (begin
              (set! rdi fun/vector13357.5)
              (set! r15 tmp-ra.181)
              (jump L.fun/vector13357.5.14 rbp r15 rdi))))))
    (define L.fun/vector13354.8.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.182 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/vector13355.6 (mref c.85 14))
            (begin
              (set! rdi fun/vector13355.6)
              (set! r15 tmp-ra.182)
              (jump L.fun/vector13355.6.15 rbp r15 rdi))))))
    (define L.fun/ascii-char13352.7.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.183 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! fun/ascii-char13353.11 (mref c.84 14))
            (begin
              (set! rdi fun/ascii-char13353.11)
              (set! r15 tmp-ra.183)
              (jump L.fun/ascii-char13353.11.20 rbp r15 rdi))))))
    (define L.fun/vector13355.6.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.184 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! make-vector.70 (mref c.83 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.70)
              (set! r15 tmp-ra.184)
              (jump L.make-vector.70.12 rbp r15 rdi rsi))))))
    (define L.fun/vector13357.5.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.185 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! make-vector.70 (mref c.82 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.70)
              (set! r15 tmp-ra.185)
              (jump L.make-vector.70.12 rbp r15 rdi rsi))))))
    (define L.fun/error13358.4.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.186 r15)
        (begin
          (set! c.81 rdi)
          (begin
            (set! fun/error13359.10 (mref c.81 14))
            (begin
              (set! rdi fun/error13359.10)
              (set! r15 tmp-ra.186)
              (jump L.fun/error13359.10.19 rbp r15 rdi))))))
    (define L.make-vector.70.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.187 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.46 rsi)
          (begin
            (set! make-init-vector.1 (mref c.80 14))
            (if (begin
                  (if (begin
                        (set! tmp.107 (bitwise-and tmp.46 7))
                        (= tmp.107 0))
                    (set! tmp.106 14)
                    (set! tmp.106 6))
                  (!= tmp.106 6))
              (begin
                (set! rsi tmp.46)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.187)
                (jump L.make-init-vector.1.11 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.187 rbp rax)))))))
    (define L.make-init-vector.1.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.188 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.18 rsi)
          (begin
            (set! vector-init-loop.20 (mref c.79 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.111 (arithmetic-shift-right tmp.18 3))
                        (set! tmp.110 (+ 1 tmp.111)))
                      (set! tmp.109 (* tmp.110 8)))
                    (set! tmp.108 (alloc tmp.109)))
                  (set! tmp.90 (+ tmp.108 3)))
                (begin (mset! tmp.90 -3 tmp.18) (set! tmp.19 tmp.90)))
              (begin
                (set! rcx tmp.19)
                (set! rdx 0)
                (set! rsi tmp.18)
                (set! rdi vector-init-loop.20)
                (set! r15 tmp-ra.188)
                (jump L.vector-init-loop.20.10 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.20.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.189 r15)
        (begin
          (set! c.78 rdi)
          (set! len.21 rsi)
          (set! i.23 rdx)
          (set! vec.22 rcx)
          (begin
            (set! vector-init-loop.20 (mref c.78 14))
            (if (begin
                  (if (= len.21 i.23) (set! tmp.112 14) (set! tmp.112 6))
                  (!= tmp.112 6))
              (begin (set! rax vec.22) (jump tmp-ra.189 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.115 (arithmetic-shift-right i.23 3))
                      (set! tmp.114 (* tmp.115 8)))
                    (set! tmp.113 (+ tmp.114 5)))
                  (mset! vec.22 tmp.113 0))
                (begin
                  (set! tmp.116 (+ i.23 8))
                  (begin
                    (set! rcx vec.22)
                    (set! rdx tmp.116)
                    (set! rsi len.21)
                    (set! rdi vector-init-loop.20)
                    (set! r15 tmp-ra.189)
                    (jump
                     L.vector-init-loop.20.10
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.*.71.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.190 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.32 rsi)
          (set! tmp.33 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.118 (bitwise-and tmp.33 7))
                        (= tmp.118 0))
                    (set! tmp.117 14)
                    (set! tmp.117 6))
                  (!= tmp.117 6))
              (if (begin
                    (if (begin
                          (set! tmp.120 (bitwise-and tmp.32 7))
                          (= tmp.120 0))
                      (set! tmp.119 14)
                      (set! tmp.119 6))
                    (!= tmp.119 6))
                (begin
                  (set! tmp.121 (arithmetic-shift-right tmp.33 3))
                  (begin
                    (set! rax (* tmp.32 tmp.121))
                    (jump tmp-ra.190 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.190 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.190 rbp rax)))))))
    (define L.+.72.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.191 r15)
        (begin
          (set! c.76 rdi)
          (set! tmp.34 rsi)
          (set! tmp.35 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.123 (bitwise-and tmp.35 7))
                        (= tmp.123 0))
                    (set! tmp.122 14)
                    (set! tmp.122 6))
                  (!= tmp.122 6))
              (if (begin
                    (if (begin
                          (set! tmp.125 (bitwise-and tmp.34 7))
                          (= tmp.125 0))
                      (set! tmp.124 14)
                      (set! tmp.124 6))
                    (!= tmp.124 6))
                (begin (set! rax (+ tmp.34 tmp.35)) (jump tmp-ra.191 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.191 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.191 rbp rax)))))))
    (define L.-.73.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.192 r15)
        (begin
          (set! c.75 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.127 (bitwise-and tmp.37 7))
                        (= tmp.127 0))
                    (set! tmp.126 14)
                    (set! tmp.126 6))
                  (!= tmp.126 6))
              (if (begin
                    (if (begin
                          (set! tmp.129 (bitwise-and tmp.36 7))
                          (= tmp.129 0))
                      (set! tmp.128 14)
                      (set! tmp.128 6))
                    (!= tmp.128 6))
                (begin (set! rax (- tmp.36 tmp.37)) (jump tmp-ra.192 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.192 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.192 rbp rax)))))))
    (begin
      (set! tmp-ra.193 r15)
      (begin
        (begin
          (begin (set! tmp.130 (alloc 16)) (set! tmp.91 (+ tmp.130 2)))
          (begin
            (mset! tmp.91 -2 L.-.73.7)
            (mset! tmp.91 6 16)
            (set! |-.73| tmp.91)))
        (begin
          (begin (set! tmp.131 (alloc 16)) (set! tmp.92 (+ tmp.131 2)))
          (begin
            (mset! tmp.92 -2 L.+.72.8)
            (mset! tmp.92 6 16)
            (set! |+.72| tmp.92)))
        (begin
          (begin (set! tmp.132 (alloc 16)) (set! tmp.93 (+ tmp.132 2)))
          (begin
            (mset! tmp.93 -2 L.*.71.9)
            (mset! tmp.93 6 16)
            (set! *.71 tmp.93)))
        (begin
          (begin (set! tmp.133 (alloc 24)) (set! tmp.94 (+ tmp.133 2)))
          (begin
            (mset! tmp.94 -2 L.vector-init-loop.20.10)
            (mset! tmp.94 6 24)
            (set! vector-init-loop.20 tmp.94)))
        (begin
          (begin (set! tmp.134 (alloc 24)) (set! tmp.95 (+ tmp.134 2)))
          (begin
            (mset! tmp.95 -2 L.make-init-vector.1.11)
            (mset! tmp.95 6 8)
            (set! make-init-vector.1 tmp.95)))
        (begin
          (begin (set! tmp.135 (alloc 24)) (set! tmp.96 (+ tmp.135 2)))
          (begin
            (mset! tmp.96 -2 L.make-vector.70.12)
            (mset! tmp.96 6 8)
            (set! make-vector.70 tmp.96)))
        (begin
          (begin (set! tmp.136 (alloc 24)) (set! tmp.97 (+ tmp.136 2)))
          (begin
            (mset! tmp.97 -2 L.fun/error13358.4.13)
            (mset! tmp.97 6 0)
            (set! fun/error13358.4 tmp.97)))
        (begin
          (begin (set! tmp.137 (alloc 24)) (set! tmp.98 (+ tmp.137 2)))
          (begin
            (mset! tmp.98 -2 L.fun/vector13357.5.14)
            (mset! tmp.98 6 0)
            (set! fun/vector13357.5 tmp.98)))
        (begin
          (begin (set! tmp.138 (alloc 24)) (set! tmp.99 (+ tmp.138 2)))
          (begin
            (mset! tmp.99 -2 L.fun/vector13355.6.15)
            (mset! tmp.99 6 0)
            (set! fun/vector13355.6 tmp.99)))
        (begin
          (begin (set! tmp.139 (alloc 24)) (set! tmp.100 (+ tmp.139 2)))
          (begin
            (mset! tmp.100 -2 L.fun/ascii-char13352.7.16)
            (mset! tmp.100 6 0)
            (set! fun/ascii-char13352.7 tmp.100)))
        (begin
          (begin (set! tmp.140 (alloc 24)) (set! tmp.101 (+ tmp.140 2)))
          (begin
            (mset! tmp.101 -2 L.fun/vector13354.8.17)
            (mset! tmp.101 6 0)
            (set! fun/vector13354.8 tmp.101)))
        (begin
          (begin (set! tmp.141 (alloc 24)) (set! tmp.102 (+ tmp.141 2)))
          (begin
            (mset! tmp.102 -2 L.fun/vector13356.9.18)
            (mset! tmp.102 6 0)
            (set! fun/vector13356.9 tmp.102)))
        (begin
          (begin (set! tmp.142 (alloc 16)) (set! tmp.103 (+ tmp.142 2)))
          (begin
            (mset! tmp.103 -2 L.fun/error13359.10.19)
            (mset! tmp.103 6 0)
            (set! fun/error13359.10 tmp.103)))
        (begin
          (begin (set! tmp.143 (alloc 16)) (set! tmp.104 (+ tmp.143 2)))
          (begin
            (mset! tmp.104 -2 L.fun/ascii-char13353.11.20)
            (mset! tmp.104 6 0)
            (set! fun/ascii-char13353.11 tmp.104)))
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
          (begin
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.22
                      (begin
                        (set! rdx 1608)
                        (set! rsi 488)
                        (set! rdi *.71)
                        (set! r15 L.rp.22)
                        (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.146 rax))
                  (begin
                    (begin
                      (return-point L.rp.23
                        (begin
                          (set! rdx 144)
                          (set! rsi 88)
                          (set! rdi *.71)
                          (set! r15 L.rp.23)
                          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.147 rax))
                    (begin
                      (return-point L.rp.24
                        (begin
                          (set! rdx tmp.147)
                          (set! rsi tmp.146)
                          (set! rdi |+.72|)
                          (set! r15 L.rp.24)
                          (jump L.+.72.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.145 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.25
                        (begin
                          (set! rdx 216)
                          (set! rsi 736)
                          (set! rdi |-.73|)
                          (set! r15 L.rp.25)
                          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.149 rax))
                    (begin
                      (begin
                        (return-point L.rp.26
                          (begin
                            (set! rdx 1816)
                            (set! rsi 792)
                            (set! rdi |+.72|)
                            (set! r15 L.rp.26)
                            (jump L.+.72.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.150 rax))
                      (begin
                        (return-point L.rp.27
                          (begin
                            (set! rdx tmp.150)
                            (set! rsi tmp.149)
                            (set! rdi |+.72|)
                            (set! r15 L.rp.27)
                            (jump L.+.72.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.148 rax))))
                  (begin
                    (return-point L.rp.28
                      (begin
                        (set! rdx tmp.148)
                        (set! rsi tmp.145)
                        (set! rdi |+.72|)
                        (set! r15 L.rp.28)
                        (jump L.+.72.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.144 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.29
                        (begin
                          (set! rdx 1752)
                          (set! rsi 624)
                          (set! rdi |-.73|)
                          (set! r15 L.rp.29)
                          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.153 rax))
                    (begin
                      (begin
                        (return-point L.rp.30
                          (begin
                            (set! rdx 632)
                            (set! rsi 1848)
                            (set! rdi |+.72|)
                            (set! r15 L.rp.30)
                            (jump L.+.72.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.154 rax))
                      (begin
                        (return-point L.rp.31
                          (begin
                            (set! rdx tmp.154)
                            (set! rsi tmp.153)
                            (set! rdi *.71)
                            (set! r15 L.rp.31)
                            (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.152 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.32
                          (begin
                            (set! rdx 744)
                            (set! rsi 320)
                            (set! rdi |-.73|)
                            (set! r15 L.rp.32)
                            (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.156 rax))
                      (begin
                        (begin
                          (return-point L.rp.33
                            (begin
                              (set! rdx 64)
                              (set! rsi 912)
                              (set! rdi *.71)
                              (set! r15 L.rp.33)
                              (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.157 rax))
                        (begin
                          (return-point L.rp.34
                            (begin
                              (set! rdx tmp.157)
                              (set! rsi tmp.156)
                              (set! rdi |+.72|)
                              (set! r15 L.rp.34)
                              (jump L.+.72.8 rbp r15 rdi rsi rdx)))
                          (set! tmp.155 rax))))
                    (begin
                      (return-point L.rp.35
                        (begin
                          (set! rdx tmp.155)
                          (set! rsi tmp.152)
                          (set! rdi |+.72|)
                          (set! r15 L.rp.35)
                          (jump L.+.72.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.151 rax))))
                (begin
                  (return-point L.rp.36
                    (begin
                      (set! rdx tmp.151)
                      (set! rsi tmp.144)
                      (set! rdi *.71)
                      (set! r15 L.rp.36)
                      (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                  (set! fixnum0.17 rax))))
            (begin
              (return-point L.rp.37
                (begin
                  (set! rdi fun/ascii-char13352.7)
                  (set! r15 L.rp.37)
                  (jump L.fun/ascii-char13352.7.16 rbp r15 rdi)))
              (set! ascii-char1.16 rax))
            (begin
              (begin
                (begin (set! tmp.158 (alloc 24)) (set! tmp.105 (+ tmp.158 2)))
                (begin
                  (mset! tmp.105 -2 L.lam.74.21)
                  (mset! tmp.105 6 0)
                  (set! lam.74 tmp.105)))
              (begin
                (mset! lam.74 14 fun/vector13354.8)
                (set! procedure2.15 lam.74)))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.38
                      (begin
                        (set! rdx 1496)
                        (set! rsi 1472)
                        (set! rdi |-.73|)
                        (set! r15 L.rp.38)
                        (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                    (set! tmp.161 rax))
                  (begin
                    (begin
                      (return-point L.rp.39
                        (begin
                          (set! rdx 664)
                          (set! rsi 1992)
                          (set! rdi |-.73|)
                          (set! r15 L.rp.39)
                          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.162 rax))
                    (begin
                      (return-point L.rp.40
                        (begin
                          (set! rdx tmp.162)
                          (set! rsi tmp.161)
                          (set! rdi |-.73|)
                          (set! r15 L.rp.40)
                          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.160 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.41
                        (begin
                          (set! rdx 1664)
                          (set! rsi 1984)
                          (set! rdi *.71)
                          (set! r15 L.rp.41)
                          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.164 rax))
                    (begin
                      (begin
                        (return-point L.rp.42
                          (begin
                            (set! rdx 1048)
                            (set! rsi 1592)
                            (set! rdi |+.72|)
                            (set! r15 L.rp.42)
                            (jump L.+.72.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.165 rax))
                      (begin
                        (return-point L.rp.43
                          (begin
                            (set! rdx tmp.165)
                            (set! rsi tmp.164)
                            (set! rdi |-.73|)
                            (set! r15 L.rp.43)
                            (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.163 rax))))
                  (begin
                    (return-point L.rp.44
                      (begin
                        (set! rdx tmp.163)
                        (set! rsi tmp.160)
                        (set! rdi *.71)
                        (set! r15 L.rp.44)
                        (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.159 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.45
                        (begin
                          (set! rdx 1896)
                          (set! rsi 128)
                          (set! rdi *.71)
                          (set! r15 L.rp.45)
                          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.168 rax))
                    (begin
                      (begin
                        (return-point L.rp.46
                          (begin
                            (set! rdx 1096)
                            (set! rsi 1472)
                            (set! rdi *.71)
                            (set! r15 L.rp.46)
                            (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.169 rax))
                      (begin
                        (return-point L.rp.47
                          (begin
                            (set! rdx tmp.169)
                            (set! rsi tmp.168)
                            (set! rdi *.71)
                            (set! r15 L.rp.47)
                            (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.167 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.48
                          (begin
                            (set! rdx 1528)
                            (set! rsi 608)
                            (set! rdi |-.73|)
                            (set! r15 L.rp.48)
                            (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.171 rax))
                      (begin
                        (begin
                          (return-point L.rp.49
                            (begin
                              (set! rdx 720)
                              (set! rsi 1480)
                              (set! rdi |-.73|)
                              (set! r15 L.rp.49)
                              (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                          (set! tmp.172 rax))
                        (begin
                          (return-point L.rp.50
                            (begin
                              (set! rdx tmp.172)
                              (set! rsi tmp.171)
                              (set! rdi *.71)
                              (set! r15 L.rp.50)
                              (jump L.*.71.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.170 rax))))
                    (begin
                      (return-point L.rp.51
                        (begin
                          (set! rdx tmp.170)
                          (set! rsi tmp.167)
                          (set! rdi |-.73|)
                          (set! r15 L.rp.51)
                          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.166 rax))))
                (begin
                  (return-point L.rp.52
                    (begin
                      (set! rdx tmp.166)
                      (set! rsi tmp.159)
                      (set! rdi |-.73|)
                      (set! r15 L.rp.52)
                      (jump L.-.73.7 rbp r15 rdi rsi rdx)))
                  (set! fixnum3.14 rax))))
            (begin
              (return-point L.rp.53
                (begin
                  (set! rdi fun/vector13356.9)
                  (set! r15 L.rp.53)
                  (jump L.fun/vector13356.9.18 rbp r15 rdi)))
              (set! vector4.13 rax))
            (begin
              (return-point L.rp.54
                (begin
                  (set! rdi fun/error13358.4)
                  (set! r15 L.rp.54)
                  (jump L.fun/error13358.4.13 rbp r15 rdi)))
              (set! error5.12 rax))
            (if (begin
                  (if (begin
                        (set! tmp.174 (bitwise-and procedure2.15 7))
                        (= tmp.174 2))
                    (set! tmp.173 14)
                    (set! tmp.173 6))
                  (!= tmp.173 6))
              (if (begin
                    (if (begin
                          (set! tmp.176 (mref procedure2.15 6))
                          (= tmp.176 0))
                      (set! tmp.175 14)
                      (set! tmp.175 6))
                    (!= tmp.175 6))
                (begin
                  (set! tmp.177 (mref procedure2.15 -2))
                  (begin
                    (set! rdi procedure2.15)
                    (set! r15 tmp-ra.193)
                    (jump tmp.177 rbp r15 rdi)))
                (begin (set! rax 10814) (jump tmp-ra.193 rbp rax)))
              (begin (set! rax 11070) (jump tmp-ra.193 rbp rax)))))))))
(check-by-interp
 '(module
    ((new-frames
      (()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ()
       ())))
    (define L.fun/empty14584.13.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.155 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! fun/empty14585.11 (mref c.87 14))
            (begin
              (set! rdi fun/empty14585.11)
              (set! r15 tmp-ra.155)
              (jump L.fun/empty14585.11.17 rbp r15 rdi))))))
    (define L.fun/void14589.12.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.156 rbp rax))))))
    (define L.fun/empty14585.11.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.157 r15)
        (begin
          (set! c.85 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.157 rbp rax))))))
    (define L.fun/ascii-char14587.10.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 21550) (jump tmp-ra.158 rbp rax))))))
    (define L.fun/void14592.9.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/void14593.4 (mref c.83 14))
            (begin
              (set! rdi fun/void14593.4)
              (set! r15 tmp-ra.159)
              (jump L.fun/void14593.4.10 rbp r15 rdi))))))
    (define L.fun/void14588.8.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/void14589.12 (mref c.82 14))
            (begin
              (set! rdi fun/void14589.12)
              (set! r15 tmp-ra.160)
              (jump L.fun/void14589.12.18 rbp r15 rdi))))))
    (define L.fun/ascii-char14586.7.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.81 rdi)
          (begin
            (set! fun/ascii-char14587.10 (mref c.81 14))
            (begin
              (set! rdi fun/ascii-char14587.10)
              (set! r15 tmp-ra.161)
              (jump L.fun/ascii-char14587.10.16 rbp r15 rdi))))))
    (define L.fun/void14590.6.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.80 rdi)
          (begin
            (set! fun/void14591.5 (mref c.80 14))
            (begin
              (set! rdi fun/void14591.5)
              (set! r15 tmp-ra.162)
              (jump L.fun/void14591.5.11 rbp r15 rdi))))))
    (define L.fun/void14591.5.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.79 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.163 rbp rax))))))
    (define L.fun/void14593.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.164 r15)
        (begin
          (set! c.78 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.164 rbp rax))))))
    (define L.-.72.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.165 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.102 (bitwise-and tmp.39 7))
                        (= tmp.102 0))
                    (set! tmp.101 14)
                    (set! tmp.101 6))
                  (!= tmp.101 6))
              (if (begin
                    (if (begin
                          (set! tmp.104 (bitwise-and tmp.38 7))
                          (= tmp.104 0))
                      (set! tmp.103 14)
                      (set! tmp.103 6))
                    (!= tmp.103 6))
                (begin (set! rax (- tmp.38 tmp.39)) (jump tmp-ra.165 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.165 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.165 rbp rax)))))))
    (define L.+.73.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.166 r15)
        (begin
          (set! c.76 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.106 (bitwise-and tmp.37 7))
                        (= tmp.106 0))
                    (set! tmp.105 14)
                    (set! tmp.105 6))
                  (!= tmp.105 6))
              (if (begin
                    (if (begin
                          (set! tmp.108 (bitwise-and tmp.36 7))
                          (= tmp.108 0))
                      (set! tmp.107 14)
                      (set! tmp.107 6))
                    (!= tmp.107 6))
                (begin (set! rax (+ tmp.36 tmp.37)) (jump tmp-ra.166 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.166 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.166 rbp rax)))))))
    (define L.*.74.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.167 r15)
        (begin
          (set! c.75 rdi)
          (set! tmp.34 rsi)
          (set! tmp.35 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.110 (bitwise-and tmp.35 7))
                        (= tmp.110 0))
                    (set! tmp.109 14)
                    (set! tmp.109 6))
                  (!= tmp.109 6))
              (if (begin
                    (if (begin
                          (set! tmp.112 (bitwise-and tmp.34 7))
                          (= tmp.112 0))
                      (set! tmp.111 14)
                      (set! tmp.111 6))
                    (!= tmp.111 6))
                (begin
                  (set! tmp.113 (arithmetic-shift-right tmp.35 3))
                  (begin
                    (set! rax (* tmp.34 tmp.113))
                    (jump tmp-ra.167 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.167 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.167 rbp rax)))))))
    (begin
      (set! tmp-ra.168 r15)
      (begin
        (begin
          (begin (set! tmp.114 (alloc 16)) (set! tmp.88 (+ tmp.114 2)))
          (begin
            (mset! tmp.88 -2 L.*.74.7)
            (mset! tmp.88 6 16)
            (set! *.74 tmp.88)))
        (begin
          (begin (set! tmp.115 (alloc 16)) (set! tmp.89 (+ tmp.115 2)))
          (begin
            (mset! tmp.89 -2 L.+.73.8)
            (mset! tmp.89 6 16)
            (set! |+.73| tmp.89)))
        (begin
          (begin (set! tmp.116 (alloc 16)) (set! tmp.90 (+ tmp.116 2)))
          (begin
            (mset! tmp.90 -2 L.-.72.9)
            (mset! tmp.90 6 16)
            (set! |-.72| tmp.90)))
        (begin
          (begin (set! tmp.117 (alloc 16)) (set! tmp.91 (+ tmp.117 2)))
          (begin
            (mset! tmp.91 -2 L.fun/void14593.4.10)
            (mset! tmp.91 6 0)
            (set! fun/void14593.4 tmp.91)))
        (begin
          (begin (set! tmp.118 (alloc 16)) (set! tmp.92 (+ tmp.118 2)))
          (begin
            (mset! tmp.92 -2 L.fun/void14591.5.11)
            (mset! tmp.92 6 0)
            (set! fun/void14591.5 tmp.92)))
        (begin
          (begin (set! tmp.119 (alloc 24)) (set! tmp.93 (+ tmp.119 2)))
          (begin
            (mset! tmp.93 -2 L.fun/void14590.6.12)
            (mset! tmp.93 6 0)
            (set! fun/void14590.6 tmp.93)))
        (begin
          (begin (set! tmp.120 (alloc 24)) (set! tmp.94 (+ tmp.120 2)))
          (begin
            (mset! tmp.94 -2 L.fun/ascii-char14586.7.13)
            (mset! tmp.94 6 0)
            (set! fun/ascii-char14586.7 tmp.94)))
        (begin
          (begin (set! tmp.121 (alloc 24)) (set! tmp.95 (+ tmp.121 2)))
          (begin
            (mset! tmp.95 -2 L.fun/void14588.8.14)
            (mset! tmp.95 6 0)
            (set! fun/void14588.8 tmp.95)))
        (begin
          (begin (set! tmp.122 (alloc 24)) (set! tmp.96 (+ tmp.122 2)))
          (begin
            (mset! tmp.96 -2 L.fun/void14592.9.15)
            (mset! tmp.96 6 0)
            (set! fun/void14592.9 tmp.96)))
        (begin
          (begin (set! tmp.123 (alloc 16)) (set! tmp.97 (+ tmp.123 2)))
          (begin
            (mset! tmp.97 -2 L.fun/ascii-char14587.10.16)
            (mset! tmp.97 6 0)
            (set! fun/ascii-char14587.10 tmp.97)))
        (begin
          (begin (set! tmp.124 (alloc 16)) (set! tmp.98 (+ tmp.124 2)))
          (begin
            (mset! tmp.98 -2 L.fun/empty14585.11.17)
            (mset! tmp.98 6 0)
            (set! fun/empty14585.11 tmp.98)))
        (begin
          (begin (set! tmp.125 (alloc 16)) (set! tmp.99 (+ tmp.125 2)))
          (begin
            (mset! tmp.99 -2 L.fun/void14589.12.18)
            (mset! tmp.99 6 0)
            (set! fun/void14589.12 tmp.99)))
        (begin
          (begin (set! tmp.126 (alloc 24)) (set! tmp.100 (+ tmp.126 2)))
          (begin
            (mset! tmp.100 -2 L.fun/empty14584.13.19)
            (mset! tmp.100 6 0)
            (set! fun/empty14584.13 tmp.100)))
        (begin
          (mset! fun/void14590.6 14 fun/void14591.5)
          (mset! fun/ascii-char14586.7 14 fun/ascii-char14587.10)
          (mset! fun/void14588.8 14 fun/void14589.12)
          (mset! fun/void14592.9 14 fun/void14593.4)
          (mset! fun/empty14584.13 14 fun/empty14585.11)
          (begin
            (begin
              (return-point L.rp.20
                (begin
                  (set! rdi fun/empty14584.13)
                  (set! r15 L.rp.20)
                  (jump L.fun/empty14584.13.19 rbp r15 rdi)))
              (set! empty0.19 rax))
            (begin
              (return-point L.rp.21
                (begin
                  (set! rdi fun/ascii-char14586.7)
                  (set! r15 L.rp.21)
                  (jump L.fun/ascii-char14586.7.13 rbp r15 rdi)))
              (set! ascii-char1.18 rax))
            (begin
              (return-point L.rp.22
                (begin
                  (set! rdi fun/void14588.8)
                  (set! r15 L.rp.22)
                  (jump L.fun/void14588.8.14 rbp r15 rdi)))
              (set! void2.17 rax))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.23
                      (begin
                        (set! rdx 904)
                        (set! rsi 1552)
                        (set! rdi |-.72|)
                        (set! r15 L.rp.23)
                        (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.129 rax))
                  (begin
                    (begin
                      (return-point L.rp.24
                        (begin
                          (set! rdx 1928)
                          (set! rsi 1480)
                          (set! rdi |-.72|)
                          (set! r15 L.rp.24)
                          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.130 rax))
                    (begin
                      (return-point L.rp.25
                        (begin
                          (set! rdx tmp.130)
                          (set! rsi tmp.129)
                          (set! rdi |-.72|)
                          (set! r15 L.rp.25)
                          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.128 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.26
                        (begin
                          (set! rdx 728)
                          (set! rsi 1296)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.26)
                          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.132 rax))
                    (begin
                      (begin
                        (return-point L.rp.27
                          (begin
                            (set! rdx 1576)
                            (set! rsi 1312)
                            (set! rdi |-.72|)
                            (set! r15 L.rp.27)
                            (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.133 rax))
                      (begin
                        (return-point L.rp.28
                          (begin
                            (set! rdx tmp.133)
                            (set! rsi tmp.132)
                            (set! rdi *.74)
                            (set! r15 L.rp.28)
                            (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.131 rax))))
                  (begin
                    (return-point L.rp.29
                      (begin
                        (set! rdx tmp.131)
                        (set! rsi tmp.128)
                        (set! rdi |+.73|)
                        (set! r15 L.rp.29)
                        (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.127 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.30
                        (begin
                          (set! rdx 1792)
                          (set! rsi 1992)
                          (set! rdi |-.72|)
                          (set! r15 L.rp.30)
                          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.136 rax))
                    (begin
                      (begin
                        (return-point L.rp.31
                          (begin
                            (set! rdx 1496)
                            (set! rsi 2000)
                            (set! rdi |-.72|)
                            (set! r15 L.rp.31)
                            (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.137 rax))
                      (begin
                        (return-point L.rp.32
                          (begin
                            (set! rdx tmp.137)
                            (set! rsi tmp.136)
                            (set! rdi *.74)
                            (set! r15 L.rp.32)
                            (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.135 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.33
                          (begin
                            (set! rdx 752)
                            (set! rsi 1712)
                            (set! rdi *.74)
                            (set! r15 L.rp.33)
                            (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.139 rax))
                      (begin
                        (begin
                          (return-point L.rp.34
                            (begin
                              (set! rdx 1528)
                              (set! rsi 1648)
                              (set! rdi *.74)
                              (set! r15 L.rp.34)
                              (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                          (set! tmp.140 rax))
                        (begin
                          (return-point L.rp.35
                            (begin
                              (set! rdx tmp.140)
                              (set! rsi tmp.139)
                              (set! rdi *.74)
                              (set! r15 L.rp.35)
                              (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                          (set! tmp.138 rax))))
                    (begin
                      (return-point L.rp.36
                        (begin
                          (set! rdx tmp.138)
                          (set! rsi tmp.135)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.36)
                          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.134 rax))))
                (begin
                  (return-point L.rp.37
                    (begin
                      (set! rdx tmp.134)
                      (set! rsi tmp.127)
                      (set! rdi |+.73|)
                      (set! r15 L.rp.37)
                      (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                  (set! fixnum3.16 rax))))
            (begin
              (return-point L.rp.38
                (begin
                  (set! rdi fun/void14590.6)
                  (set! r15 L.rp.38)
                  (jump L.fun/void14590.6.12 rbp r15 rdi)))
              (set! void4.15 rax))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.39
                      (begin
                        (set! rdx 296)
                        (set! rsi 1184)
                        (set! rdi |-.72|)
                        (set! r15 L.rp.39)
                        (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.143 rax))
                  (begin
                    (begin
                      (return-point L.rp.40
                        (begin
                          (set! rdx 88)
                          (set! rsi 880)
                          (set! rdi *.74)
                          (set! r15 L.rp.40)
                          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.144 rax))
                    (begin
                      (return-point L.rp.41
                        (begin
                          (set! rdx tmp.144)
                          (set! rsi tmp.143)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.41)
                          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.142 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.42
                        (begin
                          (set! rdx 616)
                          (set! rsi 40)
                          (set! rdi *.74)
                          (set! r15 L.rp.42)
                          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.146 rax))
                    (begin
                      (begin
                        (return-point L.rp.43
                          (begin
                            (set! rdx 1784)
                            (set! rsi 424)
                            (set! rdi |-.72|)
                            (set! r15 L.rp.43)
                            (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.147 rax))
                      (begin
                        (return-point L.rp.44
                          (begin
                            (set! rdx tmp.147)
                            (set! rsi tmp.146)
                            (set! rdi *.74)
                            (set! r15 L.rp.44)
                            (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.145 rax))))
                  (begin
                    (return-point L.rp.45
                      (begin
                        (set! rdx tmp.145)
                        (set! rsi tmp.142)
                        (set! rdi |-.72|)
                        (set! r15 L.rp.45)
                        (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.141 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.46
                        (begin
                          (set! rdx 688)
                          (set! rsi 512)
                          (set! rdi *.74)
                          (set! r15 L.rp.46)
                          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.150 rax))
                    (begin
                      (begin
                        (return-point L.rp.47
                          (begin
                            (set! rdx 968)
                            (set! rsi 1616)
                            (set! rdi |-.72|)
                            (set! r15 L.rp.47)
                            (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.151 rax))
                      (begin
                        (return-point L.rp.48
                          (begin
                            (set! rdx tmp.151)
                            (set! rsi tmp.150)
                            (set! rdi |-.72|)
                            (set! r15 L.rp.48)
                            (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.149 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.49
                          (begin
                            (set! rdx 208)
                            (set! rsi 608)
                            (set! rdi *.74)
                            (set! r15 L.rp.49)
                            (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.153 rax))
                      (begin
                        (begin
                          (return-point L.rp.50
                            (begin
                              (set! rdx 1832)
                              (set! rsi 296)
                              (set! rdi *.74)
                              (set! r15 L.rp.50)
                              (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                          (set! tmp.154 rax))
                        (begin
                          (return-point L.rp.51
                            (begin
                              (set! rdx tmp.154)
                              (set! rsi tmp.153)
                              (set! rdi *.74)
                              (set! r15 L.rp.51)
                              (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                          (set! tmp.152 rax))))
                    (begin
                      (return-point L.rp.52
                        (begin
                          (set! rdx tmp.152)
                          (set! rsi tmp.149)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.52)
                          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.148 rax))))
                (begin
                  (return-point L.rp.53
                    (begin
                      (set! rdx tmp.148)
                      (set! rsi tmp.141)
                      (set! rdi |+.73|)
                      (set! r15 L.rp.53)
                      (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                  (set! fixnum5.14 rax))))
            (begin
              (set! rdi fun/void14592.9)
              (set! r15 tmp-ra.168)
              (jump L.fun/void14592.9.15 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () ())))
    (define L.fun/ascii-char15136.15.26
      ((new-frames ()))
      (begin
        (set! tmp-ra.183 r15)
        (begin
          (set! c.99 rdi)
          (begin (begin (set! rax 20014) (jump tmp-ra.183 rbp rax))))))
    (define L.fun/void15141.14.25
      ((new-frames ()))
      (begin
        (set! tmp-ra.184 r15)
        (begin
          (set! c.98 rdi)
          (begin
            (set! fun/void15142.8 (mref c.98 14))
            (begin
              (set! rdi fun/void15142.8)
              (set! r15 tmp-ra.184)
              (jump L.fun/void15142.8.19 rbp r15 rdi))))))
    (define L.fun/empty15139.13.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.185 r15)
        (begin
          (set! c.97 rdi)
          (begin
            (set! fun/empty15140.4 (mref c.97 14))
            (begin
              (set! rdi fun/empty15140.4)
              (set! r15 tmp-ra.185)
              (jump L.fun/empty15140.4.15 rbp r15 rdi))))))
    (define L.fun/void15146.12.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.186 r15)
        (begin
          (set! c.96 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.186 rbp rax))))))
    (define L.fun/vector15137.11.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.187 r15)
        (begin
          (set! c.95 rdi)
          (begin
            (set! fun/vector15138.6 (mref c.95 14))
            (begin
              (set! rdi fun/vector15138.6)
              (set! r15 tmp-ra.187)
              (jump L.fun/vector15138.6.17 rbp r15 rdi))))))
    (define L.fun/any15143.10.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.188 r15)
        (begin
          (set! c.94 rdi)
          (begin
            (set! fun/any15144.9 (mref c.94 14))
            (begin
              (set! rdi fun/any15144.9)
              (set! r15 tmp-ra.188)
              (jump L.fun/any15144.9.20 rbp r15 rdi))))))
    (define L.fun/any15144.9.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.189 r15)
        (begin
          (set! c.93 rdi)
          (begin
            (set! cons.75 (mref c.93 14))
            (begin
              (set! rdx 3640)
              (set! rsi 720)
              (set! rdi cons.75)
              (set! r15 tmp-ra.189)
              (jump L.cons.75.11 rbp r15 rdi rsi rdx))))))
    (define L.fun/void15142.8.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.190 r15)
        (begin
          (set! c.92 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.190 rbp rax))))))
    (define L.fun/ascii-char15135.7.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.191 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/ascii-char15136.15 (mref c.91 14))
            (begin
              (set! rdi fun/ascii-char15136.15)
              (set! r15 tmp-ra.191)
              (jump L.fun/ascii-char15136.15.26 rbp r15 rdi))))))
    (define L.fun/vector15138.6.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.192 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! make-vector.74 (mref c.90 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.74)
              (set! r15 tmp-ra.192)
              (jump L.make-vector.74.14 rbp r15 rdi rsi))))))
    (define L.fun/void15145.5.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.193 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/void15146.12 (mref c.89 14))
            (begin
              (set! rdi fun/void15146.12)
              (set! r15 tmp-ra.193)
              (jump L.fun/void15146.12.23 rbp r15 rdi))))))
    (define L.fun/empty15140.4.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.194 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.194 rbp rax))))))
    (define L.make-vector.74.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.195 r15)
        (begin
          (set! c.87 rdi)
          (set! tmp.50 rsi)
          (begin
            (set! make-init-vector.1 (mref c.87 14))
            (if (begin
                  (if (begin
                        (set! tmp.123 (bitwise-and tmp.50 7))
                        (= tmp.123 0))
                    (set! tmp.122 14)
                    (set! tmp.122 6))
                  (!= tmp.122 6))
              (begin
                (set! rsi tmp.50)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.195)
                (jump L.make-init-vector.1.13 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.195 rbp rax)))))))
    (define L.make-init-vector.1.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.196 r15)
        (begin
          (set! c.86 rdi)
          (set! tmp.22 rsi)
          (begin
            (set! vector-init-loop.24 (mref c.86 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.127 (arithmetic-shift-right tmp.22 3))
                        (set! tmp.126 (+ 1 tmp.127)))
                      (set! tmp.125 (* tmp.126 8)))
                    (set! tmp.124 (alloc tmp.125)))
                  (set! tmp.100 (+ tmp.124 3)))
                (begin (mset! tmp.100 -3 tmp.22) (set! tmp.23 tmp.100)))
              (begin
                (set! rcx tmp.23)
                (set! rdx 0)
                (set! rsi tmp.22)
                (set! rdi vector-init-loop.24)
                (set! r15 tmp-ra.196)
                (jump L.vector-init-loop.24.12 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.24.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.197 r15)
        (begin
          (set! c.85 rdi)
          (set! len.25 rsi)
          (set! i.27 rdx)
          (set! vec.26 rcx)
          (begin
            (set! vector-init-loop.24 (mref c.85 14))
            (if (begin
                  (if (= len.25 i.27) (set! tmp.128 14) (set! tmp.128 6))
                  (!= tmp.128 6))
              (begin (set! rax vec.26) (jump tmp-ra.197 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.131 (arithmetic-shift-right i.27 3))
                      (set! tmp.130 (* tmp.131 8)))
                    (set! tmp.129 (+ tmp.130 5)))
                  (mset! vec.26 tmp.129 0))
                (begin
                  (set! tmp.132 (+ i.27 8))
                  (begin
                    (set! rcx vec.26)
                    (set! rdx tmp.132)
                    (set! rsi len.25)
                    (set! rdi vector-init-loop.24)
                    (set! r15 tmp-ra.197)
                    (jump
                     L.vector-init-loop.24.12
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.cons.75.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.198 r15)
        (begin
          (set! c.84 rdi)
          (set! tmp.69 rsi)
          (set! tmp.70 rdx)
          (begin
            (begin
              (begin (set! tmp.133 (alloc 16)) (set! tmp.101 (+ tmp.133 1)))
              (begin
                (mset! tmp.101 -1 tmp.69)
                (mset! tmp.101 7 tmp.70)
                (begin (set! rax tmp.101) (jump tmp-ra.198 rbp rax))))))))
    (define L.-.76.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.199 r15)
        (begin
          (set! c.83 rdi)
          (set! tmp.40 rsi)
          (set! tmp.41 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.135 (bitwise-and tmp.41 7))
                        (= tmp.135 0))
                    (set! tmp.134 14)
                    (set! tmp.134 6))
                  (!= tmp.134 6))
              (if (begin
                    (if (begin
                          (set! tmp.137 (bitwise-and tmp.40 7))
                          (= tmp.137 0))
                      (set! tmp.136 14)
                      (set! tmp.136 6))
                    (!= tmp.136 6))
                (begin (set! rax (- tmp.40 tmp.41)) (jump tmp-ra.199 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.199 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.199 rbp rax)))))))
    (define L.+.77.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.200 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.139 (bitwise-and tmp.39 7))
                        (= tmp.139 0))
                    (set! tmp.138 14)
                    (set! tmp.138 6))
                  (!= tmp.138 6))
              (if (begin
                    (if (begin
                          (set! tmp.141 (bitwise-and tmp.38 7))
                          (= tmp.141 0))
                      (set! tmp.140 14)
                      (set! tmp.140 6))
                    (!= tmp.140 6))
                (begin (set! rax (+ tmp.38 tmp.39)) (jump tmp-ra.200 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.200 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.200 rbp rax)))))))
    (define L.*.78.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.201 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.143 (bitwise-and tmp.37 7))
                        (= tmp.143 0))
                    (set! tmp.142 14)
                    (set! tmp.142 6))
                  (!= tmp.142 6))
              (if (begin
                    (if (begin
                          (set! tmp.145 (bitwise-and tmp.36 7))
                          (= tmp.145 0))
                      (set! tmp.144 14)
                      (set! tmp.144 6))
                    (!= tmp.144 6))
                (begin
                  (set! tmp.146 (arithmetic-shift-right tmp.37 3))
                  (begin
                    (set! rax (* tmp.36 tmp.146))
                    (jump tmp-ra.201 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.201 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.201 rbp rax)))))))
    (define L.empty?.79.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.202 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.61 rsi)
          (begin
            (if (begin (set! tmp.147 (bitwise-and tmp.61 255)) (= tmp.147 22))
              (begin (set! rax 14) (jump tmp-ra.202 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.202 rbp rax)))))))
    (begin
      (set! tmp-ra.203 r15)
      (begin
        (begin
          (begin (set! tmp.148 (alloc 16)) (set! tmp.102 (+ tmp.148 2)))
          (begin
            (mset! tmp.102 -2 L.empty?.79.7)
            (mset! tmp.102 6 8)
            (set! empty?.79 tmp.102)))
        (begin
          (begin (set! tmp.149 (alloc 16)) (set! tmp.103 (+ tmp.149 2)))
          (begin
            (mset! tmp.103 -2 L.*.78.8)
            (mset! tmp.103 6 16)
            (set! *.78 tmp.103)))
        (begin
          (begin (set! tmp.150 (alloc 16)) (set! tmp.104 (+ tmp.150 2)))
          (begin
            (mset! tmp.104 -2 L.+.77.9)
            (mset! tmp.104 6 16)
            (set! |+.77| tmp.104)))
        (begin
          (begin (set! tmp.151 (alloc 16)) (set! tmp.105 (+ tmp.151 2)))
          (begin
            (mset! tmp.105 -2 L.-.76.10)
            (mset! tmp.105 6 16)
            (set! |-.76| tmp.105)))
        (begin
          (begin (set! tmp.152 (alloc 16)) (set! tmp.106 (+ tmp.152 2)))
          (begin
            (mset! tmp.106 -2 L.cons.75.11)
            (mset! tmp.106 6 16)
            (set! cons.75 tmp.106)))
        (begin
          (begin (set! tmp.153 (alloc 24)) (set! tmp.107 (+ tmp.153 2)))
          (begin
            (mset! tmp.107 -2 L.vector-init-loop.24.12)
            (mset! tmp.107 6 24)
            (set! vector-init-loop.24 tmp.107)))
        (begin
          (begin (set! tmp.154 (alloc 24)) (set! tmp.108 (+ tmp.154 2)))
          (begin
            (mset! tmp.108 -2 L.make-init-vector.1.13)
            (mset! tmp.108 6 8)
            (set! make-init-vector.1 tmp.108)))
        (begin
          (begin (set! tmp.155 (alloc 24)) (set! tmp.109 (+ tmp.155 2)))
          (begin
            (mset! tmp.109 -2 L.make-vector.74.14)
            (mset! tmp.109 6 8)
            (set! make-vector.74 tmp.109)))
        (begin
          (begin (set! tmp.156 (alloc 16)) (set! tmp.110 (+ tmp.156 2)))
          (begin
            (mset! tmp.110 -2 L.fun/empty15140.4.15)
            (mset! tmp.110 6 0)
            (set! fun/empty15140.4 tmp.110)))
        (begin
          (begin (set! tmp.157 (alloc 24)) (set! tmp.111 (+ tmp.157 2)))
          (begin
            (mset! tmp.111 -2 L.fun/void15145.5.16)
            (mset! tmp.111 6 0)
            (set! fun/void15145.5 tmp.111)))
        (begin
          (begin (set! tmp.158 (alloc 24)) (set! tmp.112 (+ tmp.158 2)))
          (begin
            (mset! tmp.112 -2 L.fun/vector15138.6.17)
            (mset! tmp.112 6 0)
            (set! fun/vector15138.6 tmp.112)))
        (begin
          (begin (set! tmp.159 (alloc 24)) (set! tmp.113 (+ tmp.159 2)))
          (begin
            (mset! tmp.113 -2 L.fun/ascii-char15135.7.18)
            (mset! tmp.113 6 0)
            (set! fun/ascii-char15135.7 tmp.113)))
        (begin
          (begin (set! tmp.160 (alloc 16)) (set! tmp.114 (+ tmp.160 2)))
          (begin
            (mset! tmp.114 -2 L.fun/void15142.8.19)
            (mset! tmp.114 6 0)
            (set! fun/void15142.8 tmp.114)))
        (begin
          (begin (set! tmp.161 (alloc 24)) (set! tmp.115 (+ tmp.161 2)))
          (begin
            (mset! tmp.115 -2 L.fun/any15144.9.20)
            (mset! tmp.115 6 0)
            (set! fun/any15144.9 tmp.115)))
        (begin
          (begin (set! tmp.162 (alloc 24)) (set! tmp.116 (+ tmp.162 2)))
          (begin
            (mset! tmp.116 -2 L.fun/any15143.10.21)
            (mset! tmp.116 6 0)
            (set! fun/any15143.10 tmp.116)))
        (begin
          (begin (set! tmp.163 (alloc 24)) (set! tmp.117 (+ tmp.163 2)))
          (begin
            (mset! tmp.117 -2 L.fun/vector15137.11.22)
            (mset! tmp.117 6 0)
            (set! fun/vector15137.11 tmp.117)))
        (begin
          (begin (set! tmp.164 (alloc 16)) (set! tmp.118 (+ tmp.164 2)))
          (begin
            (mset! tmp.118 -2 L.fun/void15146.12.23)
            (mset! tmp.118 6 0)
            (set! fun/void15146.12 tmp.118)))
        (begin
          (begin (set! tmp.165 (alloc 24)) (set! tmp.119 (+ tmp.165 2)))
          (begin
            (mset! tmp.119 -2 L.fun/empty15139.13.24)
            (mset! tmp.119 6 0)
            (set! fun/empty15139.13 tmp.119)))
        (begin
          (begin (set! tmp.166 (alloc 24)) (set! tmp.120 (+ tmp.166 2)))
          (begin
            (mset! tmp.120 -2 L.fun/void15141.14.25)
            (mset! tmp.120 6 0)
            (set! fun/void15141.14 tmp.120)))
        (begin
          (begin (set! tmp.167 (alloc 16)) (set! tmp.121 (+ tmp.167 2)))
          (begin
            (mset! tmp.121 -2 L.fun/ascii-char15136.15.26)
            (mset! tmp.121 6 0)
            (set! fun/ascii-char15136.15 tmp.121)))
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
          (begin
            (begin
              (return-point L.rp.27
                (begin
                  (set! rdi fun/ascii-char15135.7)
                  (set! r15 L.rp.27)
                  (jump L.fun/ascii-char15135.7.18 rbp r15 rdi)))
              (set! ascii-char0.21 rax))
            (begin
              (return-point L.rp.28
                (begin
                  (set! rdi fun/vector15137.11)
                  (set! r15 L.rp.28)
                  (jump L.fun/vector15137.11.22 rbp r15 rdi)))
              (set! vector1.20 rax))
            (begin
              (return-point L.rp.29
                (begin
                  (set! rdi fun/empty15139.13)
                  (set! r15 L.rp.29)
                  (jump L.fun/empty15139.13.24 rbp r15 rdi)))
              (set! empty2.19 rax))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.30
                      (begin
                        (set! rdx 192)
                        (set! rsi 1376)
                        (set! rdi |-.76|)
                        (set! r15 L.rp.30)
                        (jump L.-.76.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.170 rax))
                  (begin
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx 1608)
                          (set! rsi 1984)
                          (set! rdi |-.76|)
                          (set! r15 L.rp.31)
                          (jump L.-.76.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.171 rax))
                    (begin
                      (return-point L.rp.32
                        (begin
                          (set! rdx tmp.171)
                          (set! rsi tmp.170)
                          (set! rdi |+.77|)
                          (set! r15 L.rp.32)
                          (jump L.+.77.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.169 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.33
                        (begin
                          (set! rdx 1840)
                          (set! rsi 296)
                          (set! rdi |+.77|)
                          (set! r15 L.rp.33)
                          (jump L.+.77.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.173 rax))
                    (begin
                      (begin
                        (return-point L.rp.34
                          (begin
                            (set! rdx 1720)
                            (set! rsi 488)
                            (set! rdi |-.76|)
                            (set! r15 L.rp.34)
                            (jump L.-.76.10 rbp r15 rdi rsi rdx)))
                        (set! tmp.174 rax))
                      (begin
                        (return-point L.rp.35
                          (begin
                            (set! rdx tmp.174)
                            (set! rsi tmp.173)
                            (set! rdi |+.77|)
                            (set! r15 L.rp.35)
                            (jump L.+.77.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.172 rax))))
                  (begin
                    (return-point L.rp.36
                      (begin
                        (set! rdx tmp.172)
                        (set! rsi tmp.169)
                        (set! rdi |-.76|)
                        (set! r15 L.rp.36)
                        (jump L.-.76.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.168 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.37
                        (begin
                          (set! rdx 776)
                          (set! rsi 1368)
                          (set! rdi *.78)
                          (set! r15 L.rp.37)
                          (jump L.*.78.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.177 rax))
                    (begin
                      (begin
                        (return-point L.rp.38
                          (begin
                            (set! rdx 64)
                            (set! rsi 864)
                            (set! rdi |-.76|)
                            (set! r15 L.rp.38)
                            (jump L.-.76.10 rbp r15 rdi rsi rdx)))
                        (set! tmp.178 rax))
                      (begin
                        (return-point L.rp.39
                          (begin
                            (set! rdx tmp.178)
                            (set! rsi tmp.177)
                            (set! rdi |+.77|)
                            (set! r15 L.rp.39)
                            (jump L.+.77.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.176 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.40
                          (begin
                            (set! rdx 584)
                            (set! rsi 392)
                            (set! rdi |-.76|)
                            (set! r15 L.rp.40)
                            (jump L.-.76.10 rbp r15 rdi rsi rdx)))
                        (set! tmp.180 rax))
                      (begin
                        (begin
                          (return-point L.rp.41
                            (begin
                              (set! rdx 1872)
                              (set! rsi 1440)
                              (set! rdi |+.77|)
                              (set! r15 L.rp.41)
                              (jump L.+.77.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.181 rax))
                        (begin
                          (return-point L.rp.42
                            (begin
                              (set! rdx tmp.181)
                              (set! rsi tmp.180)
                              (set! rdi |-.76|)
                              (set! r15 L.rp.42)
                              (jump L.-.76.10 rbp r15 rdi rsi rdx)))
                          (set! tmp.179 rax))))
                    (begin
                      (return-point L.rp.43
                        (begin
                          (set! rdx tmp.179)
                          (set! rsi tmp.176)
                          (set! rdi |-.76|)
                          (set! r15 L.rp.43)
                          (jump L.-.76.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.175 rax))))
                (begin
                  (return-point L.rp.44
                    (begin
                      (set! rdx tmp.175)
                      (set! rsi tmp.168)
                      (set! rdi |+.77|)
                      (set! r15 L.rp.44)
                      (jump L.+.77.9 rbp r15 rdi rsi rdx)))
                  (set! fixnum3.18 rax))))
            (begin
              (return-point L.rp.45
                (begin
                  (set! rdi fun/void15141.14)
                  (set! r15 L.rp.45)
                  (jump L.fun/void15141.14.25 rbp r15 rdi)))
              (set! void4.17 rax))
            (begin
              (begin
                (return-point L.rp.46
                  (begin
                    (set! rdi fun/any15143.10)
                    (set! r15 L.rp.46)
                    (jump L.fun/any15143.10.21 rbp r15 rdi)))
                (set! tmp.182 rax))
              (begin
                (return-point L.rp.47
                  (begin
                    (set! rsi tmp.182)
                    (set! rdi empty?.79)
                    (set! r15 L.rp.47)
                    (jump L.empty?.79.7 rbp r15 rdi rsi)))
                (set! boolean5.16 rax)))
            (begin
              (set! rdi fun/void15145.5)
              (set! r15 tmp-ra.203)
              (jump L.fun/void15145.5.16 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () ())))
    (define L.lam.77.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.144 r15)
        (begin
          (set! c.95 rdi)
          (begin
            (set! fun/empty15764.14 (mref c.95 14))
            (begin
              (set! rdi fun/empty15764.14)
              (set! r15 tmp-ra.144)
              (jump L.fun/empty15764.14.20 rbp r15 rdi))))))
    (define L.fun/ascii-char15768.17.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.145 r15)
        (begin
          (set! c.94 rdi)
          (begin
            (set! fun/ascii-char15769.10 (mref c.94 14))
            (begin
              (set! rdi fun/ascii-char15769.10)
              (set! r15 tmp-ra.145)
              (jump L.fun/ascii-char15769.10.16 rbp r15 rdi))))))
    (define L.fun/ascii-char15777.16.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.146 r15)
        (begin
          (set! c.93 rdi)
          (begin (begin (set! rax 19502) (jump tmp-ra.146 rbp rax))))))
    (define L.fun/void15775.15.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.147 r15)
        (begin
          (set! c.92 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.147 rbp rax))))))
    (define L.fun/empty15764.14.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.148 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/empty15765.5 (mref c.91 14))
            (begin
              (set! rdi fun/empty15765.5)
              (set! r15 tmp-ra.148)
              (jump L.fun/empty15765.5.11 rbp r15 rdi))))))
    (define L.fun/empty15766.13.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.149 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/empty15767.11 (mref c.90 14))
            (begin
              (set! rdi fun/empty15767.11)
              (set! r15 tmp-ra.149)
              (jump L.fun/empty15767.11.17 rbp r15 rdi))))))
    (define L.fun/ascii-char15776.12.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.150 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/ascii-char15777.16 (mref c.89 14))
            (begin
              (set! rdi fun/ascii-char15777.16)
              (set! r15 tmp-ra.150)
              (jump L.fun/ascii-char15777.16.22 rbp r15 rdi))))))
    (define L.fun/empty15767.11.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.151 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.151 rbp rax))))))
    (define L.fun/ascii-char15769.10.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.152 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 24366) (jump tmp-ra.152 rbp rax))))))
    (define L.fun/vector15771.9.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.153 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! make-vector.76 (mref c.86 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.76)
              (set! r15 tmp-ra.153)
              (jump L.make-vector.76.9 rbp r15 rdi rsi))))))
    (define L.fun/error15772.8.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.154 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/error15773.7 (mref c.85 14))
            (begin
              (set! rdi fun/error15773.7)
              (set! r15 tmp-ra.154)
              (jump L.fun/error15773.7.13 rbp r15 rdi))))))
    (define L.fun/error15773.7.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.155 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 4414) (jump tmp-ra.155 rbp rax))))))
    (define L.fun/void15774.6.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/void15775.15 (mref c.83 14))
            (begin
              (set! rdi fun/void15775.15)
              (set! r15 tmp-ra.156)
              (jump L.fun/void15775.15.21 rbp r15 rdi))))))
    (define L.fun/empty15765.5.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.157 r15)
        (begin
          (set! c.82 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.157 rbp rax))))))
    (define L.fun/vector15770.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.81 rdi)
          (begin
            (set! fun/vector15771.9 (mref c.81 14))
            (begin
              (set! rdi fun/vector15771.9)
              (set! r15 tmp-ra.158)
              (jump L.fun/vector15771.9.15 rbp r15 rdi))))))
    (define L.make-vector.76.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.52 rsi)
          (begin
            (set! make-init-vector.1 (mref c.80 14))
            (if (begin
                  (if (begin
                        (set! tmp.116 (bitwise-and tmp.52 7))
                        (= tmp.116 0))
                    (set! tmp.115 14)
                    (set! tmp.115 6))
                  (!= tmp.115 6))
              (begin
                (set! rsi tmp.52)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.159)
                (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.159 rbp rax)))))))
    (define L.make-init-vector.1.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.24 rsi)
          (begin
            (set! vector-init-loop.26 (mref c.79 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.120 (arithmetic-shift-right tmp.24 3))
                        (set! tmp.119 (+ 1 tmp.120)))
                      (set! tmp.118 (* tmp.119 8)))
                    (set! tmp.117 (alloc tmp.118)))
                  (set! tmp.96 (+ tmp.117 3)))
                (begin (mset! tmp.96 -3 tmp.24) (set! tmp.25 tmp.96)))
              (begin
                (set! rcx tmp.25)
                (set! rdx 0)
                (set! rsi tmp.24)
                (set! rdi vector-init-loop.26)
                (set! r15 tmp-ra.160)
                (jump L.vector-init-loop.26.7 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.26.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.78 rdi)
          (set! len.27 rsi)
          (set! i.29 rdx)
          (set! vec.28 rcx)
          (begin
            (set! vector-init-loop.26 (mref c.78 14))
            (if (begin
                  (if (= len.27 i.29) (set! tmp.121 14) (set! tmp.121 6))
                  (!= tmp.121 6))
              (begin (set! rax vec.28) (jump tmp-ra.161 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.124 (arithmetic-shift-right i.29 3))
                      (set! tmp.123 (* tmp.124 8)))
                    (set! tmp.122 (+ tmp.123 5)))
                  (mset! vec.28 tmp.122 0))
                (begin
                  (set! tmp.125 (+ i.29 8))
                  (begin
                    (set! rcx vec.28)
                    (set! rdx tmp.125)
                    (set! rsi len.27)
                    (set! rdi vector-init-loop.26)
                    (set! r15 tmp-ra.161)
                    (jump
                     L.vector-init-loop.26.7
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (begin
      (set! tmp-ra.162 r15)
      (begin
        (begin
          (begin (set! tmp.126 (alloc 24)) (set! tmp.97 (+ tmp.126 2)))
          (begin
            (mset! tmp.97 -2 L.vector-init-loop.26.7)
            (mset! tmp.97 6 24)
            (set! vector-init-loop.26 tmp.97)))
        (begin
          (begin (set! tmp.127 (alloc 24)) (set! tmp.98 (+ tmp.127 2)))
          (begin
            (mset! tmp.98 -2 L.make-init-vector.1.8)
            (mset! tmp.98 6 8)
            (set! make-init-vector.1 tmp.98)))
        (begin
          (begin (set! tmp.128 (alloc 24)) (set! tmp.99 (+ tmp.128 2)))
          (begin
            (mset! tmp.99 -2 L.make-vector.76.9)
            (mset! tmp.99 6 8)
            (set! make-vector.76 tmp.99)))
        (begin
          (begin (set! tmp.129 (alloc 24)) (set! tmp.100 (+ tmp.129 2)))
          (begin
            (mset! tmp.100 -2 L.fun/vector15770.4.10)
            (mset! tmp.100 6 0)
            (set! fun/vector15770.4 tmp.100)))
        (begin
          (begin (set! tmp.130 (alloc 16)) (set! tmp.101 (+ tmp.130 2)))
          (begin
            (mset! tmp.101 -2 L.fun/empty15765.5.11)
            (mset! tmp.101 6 0)
            (set! fun/empty15765.5 tmp.101)))
        (begin
          (begin (set! tmp.131 (alloc 24)) (set! tmp.102 (+ tmp.131 2)))
          (begin
            (mset! tmp.102 -2 L.fun/void15774.6.12)
            (mset! tmp.102 6 0)
            (set! fun/void15774.6 tmp.102)))
        (begin
          (begin (set! tmp.132 (alloc 16)) (set! tmp.103 (+ tmp.132 2)))
          (begin
            (mset! tmp.103 -2 L.fun/error15773.7.13)
            (mset! tmp.103 6 0)
            (set! fun/error15773.7 tmp.103)))
        (begin
          (begin (set! tmp.133 (alloc 24)) (set! tmp.104 (+ tmp.133 2)))
          (begin
            (mset! tmp.104 -2 L.fun/error15772.8.14)
            (mset! tmp.104 6 0)
            (set! fun/error15772.8 tmp.104)))
        (begin
          (begin (set! tmp.134 (alloc 24)) (set! tmp.105 (+ tmp.134 2)))
          (begin
            (mset! tmp.105 -2 L.fun/vector15771.9.15)
            (mset! tmp.105 6 0)
            (set! fun/vector15771.9 tmp.105)))
        (begin
          (begin (set! tmp.135 (alloc 16)) (set! tmp.106 (+ tmp.135 2)))
          (begin
            (mset! tmp.106 -2 L.fun/ascii-char15769.10.16)
            (mset! tmp.106 6 0)
            (set! fun/ascii-char15769.10 tmp.106)))
        (begin
          (begin (set! tmp.136 (alloc 16)) (set! tmp.107 (+ tmp.136 2)))
          (begin
            (mset! tmp.107 -2 L.fun/empty15767.11.17)
            (mset! tmp.107 6 0)
            (set! fun/empty15767.11 tmp.107)))
        (begin
          (begin (set! tmp.137 (alloc 24)) (set! tmp.108 (+ tmp.137 2)))
          (begin
            (mset! tmp.108 -2 L.fun/ascii-char15776.12.18)
            (mset! tmp.108 6 0)
            (set! fun/ascii-char15776.12 tmp.108)))
        (begin
          (begin (set! tmp.138 (alloc 24)) (set! tmp.109 (+ tmp.138 2)))
          (begin
            (mset! tmp.109 -2 L.fun/empty15766.13.19)
            (mset! tmp.109 6 0)
            (set! fun/empty15766.13 tmp.109)))
        (begin
          (begin (set! tmp.139 (alloc 24)) (set! tmp.110 (+ tmp.139 2)))
          (begin
            (mset! tmp.110 -2 L.fun/empty15764.14.20)
            (mset! tmp.110 6 0)
            (set! fun/empty15764.14 tmp.110)))
        (begin
          (begin (set! tmp.140 (alloc 16)) (set! tmp.111 (+ tmp.140 2)))
          (begin
            (mset! tmp.111 -2 L.fun/void15775.15.21)
            (mset! tmp.111 6 0)
            (set! fun/void15775.15 tmp.111)))
        (begin
          (begin (set! tmp.141 (alloc 16)) (set! tmp.112 (+ tmp.141 2)))
          (begin
            (mset! tmp.112 -2 L.fun/ascii-char15777.16.22)
            (mset! tmp.112 6 0)
            (set! fun/ascii-char15777.16 tmp.112)))
        (begin
          (begin (set! tmp.142 (alloc 24)) (set! tmp.113 (+ tmp.142 2)))
          (begin
            (mset! tmp.113 -2 L.fun/ascii-char15768.17.23)
            (mset! tmp.113 6 0)
            (set! fun/ascii-char15768.17 tmp.113)))
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
          (begin
            (begin
              (begin
                (begin (set! tmp.143 (alloc 24)) (set! tmp.114 (+ tmp.143 2)))
                (begin
                  (mset! tmp.114 -2 L.lam.77.24)
                  (mset! tmp.114 6 0)
                  (set! lam.77 tmp.114)))
              (begin
                (mset! lam.77 14 fun/empty15764.14)
                (set! procedure0.23 lam.77)))
            (begin
              (return-point L.rp.25
                (begin
                  (set! rdi fun/empty15766.13)
                  (set! r15 L.rp.25)
                  (jump L.fun/empty15766.13.19 rbp r15 rdi)))
              (set! empty1.22 rax))
            (begin
              (return-point L.rp.26
                (begin
                  (set! rdi fun/ascii-char15768.17)
                  (set! r15 L.rp.26)
                  (jump L.fun/ascii-char15768.17.23 rbp r15 rdi)))
              (set! ascii-char2.21 rax))
            (begin
              (return-point L.rp.27
                (begin
                  (set! rdi fun/vector15770.4)
                  (set! r15 L.rp.27)
                  (jump L.fun/vector15770.4.10 rbp r15 rdi)))
              (set! vector3.20 rax))
            (begin
              (return-point L.rp.28
                (begin
                  (set! rdi fun/error15772.8)
                  (set! r15 L.rp.28)
                  (jump L.fun/error15772.8.14 rbp r15 rdi)))
              (set! error4.19 rax))
            (begin
              (return-point L.rp.29
                (begin
                  (set! rdi fun/void15774.6)
                  (set! r15 L.rp.29)
                  (jump L.fun/void15774.6.12 rbp r15 rdi)))
              (set! void5.18 rax))
            (begin
              (set! rdi fun/ascii-char15776.12)
              (set! r15 tmp-ra.162)
              (jump L.fun/ascii-char15776.12.18 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () () () ())))
    (define L.lam.79.26
      ((new-frames ()))
      (begin
        (set! tmp-ra.181 r15)
        (begin
          (set! c.99 rdi)
          (begin
            (set! fun/pair21851.7 (mref c.99 14))
            (begin
              (set! rdi fun/pair21851.7)
              (set! r15 tmp-ra.181)
              (jump L.fun/pair21851.7.17 rbp r15 rdi))))))
    (define L.fun/void21847.15.25
      ((new-frames ()))
      (begin
        (set! tmp-ra.182 r15)
        (begin
          (set! c.98 rdi)
          (begin
            (set! fun/void21848.4 (mref c.98 14))
            (begin
              (set! rdi fun/void21848.4)
              (set! r15 tmp-ra.182)
              (jump L.fun/void21848.4.14 rbp r15 rdi))))))
    (define L.fun/ascii-char21853.14.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.183 r15)
        (begin
          (set! c.97 rdi)
          (begin
            (set! fun/ascii-char21854.5 (mref c.97 14))
            (begin
              (set! rdi fun/ascii-char21854.5)
              (set! r15 tmp-ra.183)
              (jump L.fun/ascii-char21854.5.15 rbp r15 rdi))))))
    (define L.fun/error21845.13.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.184 r15)
        (begin
          (set! c.96 rdi)
          (begin
            (set! fun/error21846.10 (mref c.96 14))
            (begin
              (set! rdi fun/error21846.10)
              (set! r15 tmp-ra.184)
              (jump L.fun/error21846.10.20 rbp r15 rdi))))))
    (define L.fun/pair21852.12.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.185 r15)
        (begin
          (set! c.95 rdi)
          (begin
            (set! cons.75 (mref c.95 14))
            (begin
              (set! rdx 2232)
              (set! rsi 624)
              (set! rdi cons.75)
              (set! r15 tmp-ra.185)
              (jump L.cons.75.10 rbp r15 rdi rsi rdx))))))
    (define L.fun/vector21855.11.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.186 r15)
        (begin
          (set! c.94 rdi)
          (begin
            (set! fun/vector21856.6 (mref c.94 14))
            (begin
              (set! rdi fun/vector21856.6)
              (set! r15 tmp-ra.186)
              (jump L.fun/vector21856.6.16 rbp r15 rdi))))))
    (define L.fun/error21846.10.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.187 r15)
        (begin
          (set! c.93 rdi)
          (begin (begin (set! rax 59198) (jump tmp-ra.187 rbp rax))))))
    (define L.fun/vector21850.9.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.188 r15)
        (begin
          (set! c.92 rdi)
          (begin
            (set! make-vector.74 (mref c.92 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.74)
              (set! r15 tmp-ra.188)
              (jump L.make-vector.74.13 rbp r15 rdi rsi))))))
    (define L.fun/vector21849.8.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.189 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/vector21850.9 (mref c.91 14))
            (begin
              (set! rdi fun/vector21850.9)
              (set! r15 tmp-ra.189)
              (jump L.fun/vector21850.9.19 rbp r15 rdi))))))
    (define L.fun/pair21851.7.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.190 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/pair21852.12 (mref c.90 14))
            (begin
              (set! rdi fun/pair21852.12)
              (set! r15 tmp-ra.190)
              (jump L.fun/pair21852.12.22 rbp r15 rdi))))))
    (define L.fun/vector21856.6.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.191 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! make-vector.74 (mref c.89 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.74)
              (set! r15 tmp-ra.191)
              (jump L.make-vector.74.13 rbp r15 rdi rsi))))))
    (define L.fun/ascii-char21854.5.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.192 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 26670) (jump tmp-ra.192 rbp rax))))))
    (define L.fun/void21848.4.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.193 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.193 rbp rax))))))
    (define L.make-vector.74.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.194 r15)
        (begin
          (set! c.86 rdi)
          (set! tmp.50 rsi)
          (begin
            (set! make-init-vector.1 (mref c.86 14))
            (if (begin
                  (if (begin
                        (set! tmp.123 (bitwise-and tmp.50 7))
                        (= tmp.123 0))
                    (set! tmp.122 14)
                    (set! tmp.122 6))
                  (!= tmp.122 6))
              (begin
                (set! rsi tmp.50)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.194)
                (jump L.make-init-vector.1.12 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.194 rbp rax)))))))
    (define L.make-init-vector.1.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.195 r15)
        (begin
          (set! c.85 rdi)
          (set! tmp.22 rsi)
          (begin
            (set! vector-init-loop.24 (mref c.85 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.127 (arithmetic-shift-right tmp.22 3))
                        (set! tmp.126 (+ 1 tmp.127)))
                      (set! tmp.125 (* tmp.126 8)))
                    (set! tmp.124 (alloc tmp.125)))
                  (set! tmp.100 (+ tmp.124 3)))
                (begin (mset! tmp.100 -3 tmp.22) (set! tmp.23 tmp.100)))
              (begin
                (set! rcx tmp.23)
                (set! rdx 0)
                (set! rsi tmp.22)
                (set! rdi vector-init-loop.24)
                (set! r15 tmp-ra.195)
                (jump L.vector-init-loop.24.11 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.24.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.196 r15)
        (begin
          (set! c.84 rdi)
          (set! len.25 rsi)
          (set! i.27 rdx)
          (set! vec.26 rcx)
          (begin
            (set! vector-init-loop.24 (mref c.84 14))
            (if (begin
                  (if (= len.25 i.27) (set! tmp.128 14) (set! tmp.128 6))
                  (!= tmp.128 6))
              (begin (set! rax vec.26) (jump tmp-ra.196 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.131 (arithmetic-shift-right i.27 3))
                      (set! tmp.130 (* tmp.131 8)))
                    (set! tmp.129 (+ tmp.130 5)))
                  (mset! vec.26 tmp.129 0))
                (begin
                  (set! tmp.132 (+ i.27 8))
                  (begin
                    (set! rcx vec.26)
                    (set! rdx tmp.132)
                    (set! rsi len.25)
                    (set! rdi vector-init-loop.24)
                    (set! r15 tmp-ra.196)
                    (jump
                     L.vector-init-loop.24.11
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.cons.75.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.197 r15)
        (begin
          (set! c.83 rdi)
          (set! tmp.69 rsi)
          (set! tmp.70 rdx)
          (begin
            (begin
              (begin (set! tmp.133 (alloc 16)) (set! tmp.101 (+ tmp.133 1)))
              (begin
                (mset! tmp.101 -1 tmp.69)
                (mset! tmp.101 7 tmp.70)
                (begin (set! rax tmp.101) (jump tmp-ra.197 rbp rax))))))))
    (define L.-.76.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.198 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.40 rsi)
          (set! tmp.41 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.135 (bitwise-and tmp.41 7))
                        (= tmp.135 0))
                    (set! tmp.134 14)
                    (set! tmp.134 6))
                  (!= tmp.134 6))
              (if (begin
                    (if (begin
                          (set! tmp.137 (bitwise-and tmp.40 7))
                          (= tmp.137 0))
                      (set! tmp.136 14)
                      (set! tmp.136 6))
                    (!= tmp.136 6))
                (begin (set! rax (- tmp.40 tmp.41)) (jump tmp-ra.198 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.198 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.198 rbp rax)))))))
    (define L.*.77.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.199 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.139 (bitwise-and tmp.37 7))
                        (= tmp.139 0))
                    (set! tmp.138 14)
                    (set! tmp.138 6))
                  (!= tmp.138 6))
              (if (begin
                    (if (begin
                          (set! tmp.141 (bitwise-and tmp.36 7))
                          (= tmp.141 0))
                      (set! tmp.140 14)
                      (set! tmp.140 6))
                    (!= tmp.140 6))
                (begin
                  (set! tmp.142 (arithmetic-shift-right tmp.37 3))
                  (begin
                    (set! rax (* tmp.36 tmp.142))
                    (jump tmp-ra.199 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.199 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.199 rbp rax)))))))
    (define L.+.78.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.200 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.144 (bitwise-and tmp.39 7))
                        (= tmp.144 0))
                    (set! tmp.143 14)
                    (set! tmp.143 6))
                  (!= tmp.143 6))
              (if (begin
                    (if (begin
                          (set! tmp.146 (bitwise-and tmp.38 7))
                          (= tmp.146 0))
                      (set! tmp.145 14)
                      (set! tmp.145 6))
                    (!= tmp.145 6))
                (begin (set! rax (+ tmp.38 tmp.39)) (jump tmp-ra.200 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.200 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.200 rbp rax)))))))
    (begin
      (set! tmp-ra.201 r15)
      (begin
        (begin
          (begin (set! tmp.147 (alloc 16)) (set! tmp.102 (+ tmp.147 2)))
          (begin
            (mset! tmp.102 -2 L.+.78.7)
            (mset! tmp.102 6 16)
            (set! |+.78| tmp.102)))
        (begin
          (begin (set! tmp.148 (alloc 16)) (set! tmp.103 (+ tmp.148 2)))
          (begin
            (mset! tmp.103 -2 L.*.77.8)
            (mset! tmp.103 6 16)
            (set! *.77 tmp.103)))
        (begin
          (begin (set! tmp.149 (alloc 16)) (set! tmp.104 (+ tmp.149 2)))
          (begin
            (mset! tmp.104 -2 L.-.76.9)
            (mset! tmp.104 6 16)
            (set! |-.76| tmp.104)))
        (begin
          (begin (set! tmp.150 (alloc 16)) (set! tmp.105 (+ tmp.150 2)))
          (begin
            (mset! tmp.105 -2 L.cons.75.10)
            (mset! tmp.105 6 16)
            (set! cons.75 tmp.105)))
        (begin
          (begin (set! tmp.151 (alloc 24)) (set! tmp.106 (+ tmp.151 2)))
          (begin
            (mset! tmp.106 -2 L.vector-init-loop.24.11)
            (mset! tmp.106 6 24)
            (set! vector-init-loop.24 tmp.106)))
        (begin
          (begin (set! tmp.152 (alloc 24)) (set! tmp.107 (+ tmp.152 2)))
          (begin
            (mset! tmp.107 -2 L.make-init-vector.1.12)
            (mset! tmp.107 6 8)
            (set! make-init-vector.1 tmp.107)))
        (begin
          (begin (set! tmp.153 (alloc 24)) (set! tmp.108 (+ tmp.153 2)))
          (begin
            (mset! tmp.108 -2 L.make-vector.74.13)
            (mset! tmp.108 6 8)
            (set! make-vector.74 tmp.108)))
        (begin
          (begin (set! tmp.154 (alloc 16)) (set! tmp.109 (+ tmp.154 2)))
          (begin
            (mset! tmp.109 -2 L.fun/void21848.4.14)
            (mset! tmp.109 6 0)
            (set! fun/void21848.4 tmp.109)))
        (begin
          (begin (set! tmp.155 (alloc 16)) (set! tmp.110 (+ tmp.155 2)))
          (begin
            (mset! tmp.110 -2 L.fun/ascii-char21854.5.15)
            (mset! tmp.110 6 0)
            (set! fun/ascii-char21854.5 tmp.110)))
        (begin
          (begin (set! tmp.156 (alloc 24)) (set! tmp.111 (+ tmp.156 2)))
          (begin
            (mset! tmp.111 -2 L.fun/vector21856.6.16)
            (mset! tmp.111 6 0)
            (set! fun/vector21856.6 tmp.111)))
        (begin
          (begin (set! tmp.157 (alloc 24)) (set! tmp.112 (+ tmp.157 2)))
          (begin
            (mset! tmp.112 -2 L.fun/pair21851.7.17)
            (mset! tmp.112 6 0)
            (set! fun/pair21851.7 tmp.112)))
        (begin
          (begin (set! tmp.158 (alloc 24)) (set! tmp.113 (+ tmp.158 2)))
          (begin
            (mset! tmp.113 -2 L.fun/vector21849.8.18)
            (mset! tmp.113 6 0)
            (set! fun/vector21849.8 tmp.113)))
        (begin
          (begin (set! tmp.159 (alloc 24)) (set! tmp.114 (+ tmp.159 2)))
          (begin
            (mset! tmp.114 -2 L.fun/vector21850.9.19)
            (mset! tmp.114 6 0)
            (set! fun/vector21850.9 tmp.114)))
        (begin
          (begin (set! tmp.160 (alloc 16)) (set! tmp.115 (+ tmp.160 2)))
          (begin
            (mset! tmp.115 -2 L.fun/error21846.10.20)
            (mset! tmp.115 6 0)
            (set! fun/error21846.10 tmp.115)))
        (begin
          (begin (set! tmp.161 (alloc 24)) (set! tmp.116 (+ tmp.161 2)))
          (begin
            (mset! tmp.116 -2 L.fun/vector21855.11.21)
            (mset! tmp.116 6 0)
            (set! fun/vector21855.11 tmp.116)))
        (begin
          (begin (set! tmp.162 (alloc 24)) (set! tmp.117 (+ tmp.162 2)))
          (begin
            (mset! tmp.117 -2 L.fun/pair21852.12.22)
            (mset! tmp.117 6 0)
            (set! fun/pair21852.12 tmp.117)))
        (begin
          (begin (set! tmp.163 (alloc 24)) (set! tmp.118 (+ tmp.163 2)))
          (begin
            (mset! tmp.118 -2 L.fun/error21845.13.23)
            (mset! tmp.118 6 0)
            (set! fun/error21845.13 tmp.118)))
        (begin
          (begin (set! tmp.164 (alloc 24)) (set! tmp.119 (+ tmp.164 2)))
          (begin
            (mset! tmp.119 -2 L.fun/ascii-char21853.14.24)
            (mset! tmp.119 6 0)
            (set! fun/ascii-char21853.14 tmp.119)))
        (begin
          (begin (set! tmp.165 (alloc 24)) (set! tmp.120 (+ tmp.165 2)))
          (begin
            (mset! tmp.120 -2 L.fun/void21847.15.25)
            (mset! tmp.120 6 0)
            (set! fun/void21847.15 tmp.120)))
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
          (begin
            (begin
              (return-point L.rp.27
                (begin
                  (set! rdi fun/error21845.13)
                  (set! r15 L.rp.27)
                  (jump L.fun/error21845.13.23 rbp r15 rdi)))
              (set! error0.21 rax))
            (begin
              (return-point L.rp.28
                (begin
                  (set! rdi fun/void21847.15)
                  (set! r15 L.rp.28)
                  (jump L.fun/void21847.15.25 rbp r15 rdi)))
              (set! void1.20 rax))
            (begin
              (return-point L.rp.29
                (begin
                  (set! rdi fun/vector21849.8)
                  (set! r15 L.rp.29)
                  (jump L.fun/vector21849.8.18 rbp r15 rdi)))
              (set! vector2.19 rax))
            (begin
              (begin
                (begin (set! tmp.166 (alloc 24)) (set! tmp.121 (+ tmp.166 2)))
                (begin
                  (mset! tmp.121 -2 L.lam.79.26)
                  (mset! tmp.121 6 0)
                  (set! lam.79 tmp.121)))
              (begin
                (mset! lam.79 14 fun/pair21851.7)
                (set! procedure3.18 lam.79)))
            (begin
              (return-point L.rp.30
                (begin
                  (set! rdi fun/ascii-char21853.14)
                  (set! r15 L.rp.30)
                  (jump L.fun/ascii-char21853.14.24 rbp r15 rdi)))
              (set! ascii-char4.17 rax))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.31
                      (begin
                        (set! rdx 528)
                        (set! rsi 656)
                        (set! rdi |-.76|)
                        (set! r15 L.rp.31)
                        (jump L.-.76.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.169 rax))
                  (begin
                    (begin
                      (return-point L.rp.32
                        (begin
                          (set! rdx 664)
                          (set! rsi 1168)
                          (set! rdi |-.76|)
                          (set! r15 L.rp.32)
                          (jump L.-.76.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.170 rax))
                    (begin
                      (return-point L.rp.33
                        (begin
                          (set! rdx tmp.170)
                          (set! rsi tmp.169)
                          (set! rdi *.77)
                          (set! r15 L.rp.33)
                          (jump L.*.77.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.168 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.34
                        (begin
                          (set! rdx 688)
                          (set! rsi 640)
                          (set! rdi |+.78|)
                          (set! r15 L.rp.34)
                          (jump L.+.78.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.172 rax))
                    (begin
                      (begin
                        (return-point L.rp.35
                          (begin
                            (set! rdx 344)
                            (set! rsi 664)
                            (set! rdi |-.76|)
                            (set! r15 L.rp.35)
                            (jump L.-.76.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.173 rax))
                      (begin
                        (return-point L.rp.36
                          (begin
                            (set! rdx tmp.173)
                            (set! rsi tmp.172)
                            (set! rdi |+.78|)
                            (set! r15 L.rp.36)
                            (jump L.+.78.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.171 rax))))
                  (begin
                    (return-point L.rp.37
                      (begin
                        (set! rdx tmp.171)
                        (set! rsi tmp.168)
                        (set! rdi *.77)
                        (set! r15 L.rp.37)
                        (jump L.*.77.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.167 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.38
                        (begin
                          (set! rdx 312)
                          (set! rsi 1408)
                          (set! rdi *.77)
                          (set! r15 L.rp.38)
                          (jump L.*.77.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.176 rax))
                    (begin
                      (begin
                        (return-point L.rp.39
                          (begin
                            (set! rdx 96)
                            (set! rsi 1896)
                            (set! rdi |-.76|)
                            (set! r15 L.rp.39)
                            (jump L.-.76.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.177 rax))
                      (begin
                        (return-point L.rp.40
                          (begin
                            (set! rdx tmp.177)
                            (set! rsi tmp.176)
                            (set! rdi |-.76|)
                            (set! r15 L.rp.40)
                            (jump L.-.76.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.175 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.41
                          (begin
                            (set! rdx 1776)
                            (set! rsi 1096)
                            (set! rdi *.77)
                            (set! r15 L.rp.41)
                            (jump L.*.77.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.179 rax))
                      (begin
                        (begin
                          (return-point L.rp.42
                            (begin
                              (set! rdx 856)
                              (set! rsi 1024)
                              (set! rdi |-.76|)
                              (set! r15 L.rp.42)
                              (jump L.-.76.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.180 rax))
                        (begin
                          (return-point L.rp.43
                            (begin
                              (set! rdx tmp.180)
                              (set! rsi tmp.179)
                              (set! rdi |-.76|)
                              (set! r15 L.rp.43)
                              (jump L.-.76.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.178 rax))))
                    (begin
                      (return-point L.rp.44
                        (begin
                          (set! rdx tmp.178)
                          (set! rsi tmp.175)
                          (set! rdi *.77)
                          (set! r15 L.rp.44)
                          (jump L.*.77.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.174 rax))))
                (begin
                  (return-point L.rp.45
                    (begin
                      (set! rdx tmp.174)
                      (set! rsi tmp.167)
                      (set! rdi *.77)
                      (set! r15 L.rp.45)
                      (jump L.*.77.8 rbp r15 rdi rsi rdx)))
                  (set! fixnum5.16 rax))))
            (begin
              (set! rdi fun/vector21855.11)
              (set! r15 tmp-ra.201)
              (jump L.fun/vector21855.11.21 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () ())))
    (define L.lam.75.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.141 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/vector10024.14 (mref c.91 14))
            (begin
              (set! rdi fun/vector10024.14)
              (set! r15 tmp-ra.141)
              (jump L.fun/vector10024.14.20 rbp r15 rdi))))))
    (define L.fun/void10032.15.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.142 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/void10033.5 (mref c.90 14))
            (begin
              (set! rdi fun/void10033.5)
              (set! r15 tmp-ra.142)
              (jump L.fun/void10033.5.11 rbp r15 rdi))))))
    (define L.fun/vector10024.14.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.143 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/vector10025.12 (mref c.89 14))
            (begin
              (set! rdi fun/vector10025.12)
              (set! r15 tmp-ra.143)
              (jump L.fun/vector10025.12.18 rbp r15 rdi))))))
    (define L.fun/empty10022.13.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.144 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! fun/empty10023.7 (mref c.88 14))
            (begin
              (set! rdi fun/empty10023.7)
              (set! r15 tmp-ra.144)
              (jump L.fun/empty10023.7.13 rbp r15 rdi))))))
    (define L.fun/vector10025.12.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.145 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! make-vector.74 (mref c.87 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.74)
              (set! r15 tmp-ra.145)
              (jump L.make-vector.74.9 rbp r15 rdi rsi))))))
    (define L.fun/empty10027.11.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.146 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.146 rbp rax))))))
    (define L.fun/void10028.10.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.147 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/void10029.8 (mref c.85 14))
            (begin
              (set! rdi fun/void10029.8)
              (set! r15 tmp-ra.147)
              (jump L.fun/void10029.8.14 rbp r15 rdi))))))
    (define L.fun/vector10031.9.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.148 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! make-vector.74 (mref c.84 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.74)
              (set! r15 tmp-ra.148)
              (jump L.make-vector.74.9 rbp r15 rdi rsi))))))
    (define L.fun/void10029.8.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.149 r15)
        (begin
          (set! c.83 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.149 rbp rax))))))
    (define L.fun/empty10023.7.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.150 r15)
        (begin
          (set! c.82 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.150 rbp rax))))))
    (define L.fun/vector10030.6.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.151 r15)
        (begin
          (set! c.81 rdi)
          (begin
            (set! fun/vector10031.9 (mref c.81 14))
            (begin
              (set! rdi fun/vector10031.9)
              (set! r15 tmp-ra.151)
              (jump L.fun/vector10031.9.15 rbp r15 rdi))))))
    (define L.fun/void10033.5.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.152 r15)
        (begin
          (set! c.80 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.152 rbp rax))))))
    (define L.fun/empty10026.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.153 r15)
        (begin
          (set! c.79 rdi)
          (begin
            (set! fun/empty10027.11 (mref c.79 14))
            (begin
              (set! rdi fun/empty10027.11)
              (set! r15 tmp-ra.153)
              (jump L.fun/empty10027.11.17 rbp r15 rdi))))))
    (define L.make-vector.74.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.154 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.50 rsi)
          (begin
            (set! make-init-vector.1 (mref c.78 14))
            (if (begin
                  (if (begin
                        (set! tmp.110 (bitwise-and tmp.50 7))
                        (= tmp.110 0))
                    (set! tmp.109 14)
                    (set! tmp.109 6))
                  (!= tmp.109 6))
              (begin
                (set! rsi tmp.50)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.154)
                (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.154 rbp rax)))))))
    (define L.make-init-vector.1.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.155 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.22 rsi)
          (begin
            (set! vector-init-loop.24 (mref c.77 14))
            (begin
              (begin
                (begin
                  (begin
                    (begin
                      (begin
                        (set! tmp.114 (arithmetic-shift-right tmp.22 3))
                        (set! tmp.113 (+ 1 tmp.114)))
                      (set! tmp.112 (* tmp.113 8)))
                    (set! tmp.111 (alloc tmp.112)))
                  (set! tmp.92 (+ tmp.111 3)))
                (begin (mset! tmp.92 -3 tmp.22) (set! tmp.23 tmp.92)))
              (begin
                (set! rcx tmp.23)
                (set! rdx 0)
                (set! rsi tmp.22)
                (set! rdi vector-init-loop.24)
                (set! r15 tmp-ra.155)
                (jump L.vector-init-loop.24.7 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.24.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.76 rdi)
          (set! len.25 rsi)
          (set! i.27 rdx)
          (set! vec.26 rcx)
          (begin
            (set! vector-init-loop.24 (mref c.76 14))
            (if (begin
                  (if (= len.25 i.27) (set! tmp.115 14) (set! tmp.115 6))
                  (!= tmp.115 6))
              (begin (set! rax vec.26) (jump tmp-ra.156 rbp rax))
              (begin
                (begin
                  (begin
                    (begin
                      (set! tmp.118 (arithmetic-shift-right i.27 3))
                      (set! tmp.117 (* tmp.118 8)))
                    (set! tmp.116 (+ tmp.117 5)))
                  (mset! vec.26 tmp.116 0))
                (begin
                  (set! tmp.119 (+ i.27 8))
                  (begin
                    (set! rcx vec.26)
                    (set! rdx tmp.119)
                    (set! rsi len.25)
                    (set! rdi vector-init-loop.24)
                    (set! r15 tmp-ra.156)
                    (jump
                     L.vector-init-loop.24.7
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (begin
      (set! tmp-ra.157 r15)
      (begin
        (begin
          (begin (set! tmp.120 (alloc 24)) (set! tmp.93 (+ tmp.120 2)))
          (begin
            (mset! tmp.93 -2 L.vector-init-loop.24.7)
            (mset! tmp.93 6 24)
            (set! vector-init-loop.24 tmp.93)))
        (begin
          (begin (set! tmp.121 (alloc 24)) (set! tmp.94 (+ tmp.121 2)))
          (begin
            (mset! tmp.94 -2 L.make-init-vector.1.8)
            (mset! tmp.94 6 8)
            (set! make-init-vector.1 tmp.94)))
        (begin
          (begin (set! tmp.122 (alloc 24)) (set! tmp.95 (+ tmp.122 2)))
          (begin
            (mset! tmp.95 -2 L.make-vector.74.9)
            (mset! tmp.95 6 8)
            (set! make-vector.74 tmp.95)))
        (begin
          (begin (set! tmp.123 (alloc 24)) (set! tmp.96 (+ tmp.123 2)))
          (begin
            (mset! tmp.96 -2 L.fun/empty10026.4.10)
            (mset! tmp.96 6 0)
            (set! fun/empty10026.4 tmp.96)))
        (begin
          (begin (set! tmp.124 (alloc 16)) (set! tmp.97 (+ tmp.124 2)))
          (begin
            (mset! tmp.97 -2 L.fun/void10033.5.11)
            (mset! tmp.97 6 0)
            (set! fun/void10033.5 tmp.97)))
        (begin
          (begin (set! tmp.125 (alloc 24)) (set! tmp.98 (+ tmp.125 2)))
          (begin
            (mset! tmp.98 -2 L.fun/vector10030.6.12)
            (mset! tmp.98 6 0)
            (set! fun/vector10030.6 tmp.98)))
        (begin
          (begin (set! tmp.126 (alloc 16)) (set! tmp.99 (+ tmp.126 2)))
          (begin
            (mset! tmp.99 -2 L.fun/empty10023.7.13)
            (mset! tmp.99 6 0)
            (set! fun/empty10023.7 tmp.99)))
        (begin
          (begin (set! tmp.127 (alloc 16)) (set! tmp.100 (+ tmp.127 2)))
          (begin
            (mset! tmp.100 -2 L.fun/void10029.8.14)
            (mset! tmp.100 6 0)
            (set! fun/void10029.8 tmp.100)))
        (begin
          (begin (set! tmp.128 (alloc 24)) (set! tmp.101 (+ tmp.128 2)))
          (begin
            (mset! tmp.101 -2 L.fun/vector10031.9.15)
            (mset! tmp.101 6 0)
            (set! fun/vector10031.9 tmp.101)))
        (begin
          (begin (set! tmp.129 (alloc 24)) (set! tmp.102 (+ tmp.129 2)))
          (begin
            (mset! tmp.102 -2 L.fun/void10028.10.16)
            (mset! tmp.102 6 0)
            (set! fun/void10028.10 tmp.102)))
        (begin
          (begin (set! tmp.130 (alloc 16)) (set! tmp.103 (+ tmp.130 2)))
          (begin
            (mset! tmp.103 -2 L.fun/empty10027.11.17)
            (mset! tmp.103 6 0)
            (set! fun/empty10027.11 tmp.103)))
        (begin
          (begin (set! tmp.131 (alloc 24)) (set! tmp.104 (+ tmp.131 2)))
          (begin
            (mset! tmp.104 -2 L.fun/vector10025.12.18)
            (mset! tmp.104 6 0)
            (set! fun/vector10025.12 tmp.104)))
        (begin
          (begin (set! tmp.132 (alloc 24)) (set! tmp.105 (+ tmp.132 2)))
          (begin
            (mset! tmp.105 -2 L.fun/empty10022.13.19)
            (mset! tmp.105 6 0)
            (set! fun/empty10022.13 tmp.105)))
        (begin
          (begin (set! tmp.133 (alloc 24)) (set! tmp.106 (+ tmp.133 2)))
          (begin
            (mset! tmp.106 -2 L.fun/vector10024.14.20)
            (mset! tmp.106 6 0)
            (set! fun/vector10024.14 tmp.106)))
        (begin
          (begin (set! tmp.134 (alloc 24)) (set! tmp.107 (+ tmp.134 2)))
          (begin
            (mset! tmp.107 -2 L.fun/void10032.15.21)
            (mset! tmp.107 6 0)
            (set! fun/void10032.15 tmp.107)))
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
          (begin
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/empty10022.13)
                  (set! r15 L.rp.23)
                  (jump L.fun/empty10022.13.19 rbp r15 rdi)))
              (set! empty0.21 rax))
            (begin
              (begin
                (begin (set! tmp.135 (alloc 24)) (set! tmp.108 (+ tmp.135 2)))
                (begin
                  (mset! tmp.108 -2 L.lam.75.22)
                  (mset! tmp.108 6 0)
                  (set! lam.75 tmp.108)))
              (begin
                (mset! lam.75 14 fun/vector10024.14)
                (set! procedure1.20 lam.75)))
            (begin
              (return-point L.rp.24
                (begin
                  (set! rdi fun/empty10026.4)
                  (set! r15 L.rp.24)
                  (jump L.fun/empty10026.4.10 rbp r15 rdi)))
              (set! empty2.19 rax))
            (begin
              (return-point L.rp.25
                (begin
                  (set! rdi fun/void10028.10)
                  (set! r15 L.rp.25)
                  (jump L.fun/void10028.10.16 rbp r15 rdi)))
              (set! void3.18 rax))
            (begin
              (return-point L.rp.26
                (begin
                  (set! rdi fun/vector10030.6)
                  (set! r15 L.rp.26)
                  (jump L.fun/vector10030.6.12 rbp r15 rdi)))
              (set! vector4.17 rax))
            (begin
              (return-point L.rp.27
                (begin
                  (set! rdi fun/void10032.15)
                  (set! r15 L.rp.27)
                  (jump L.fun/void10032.15.21 rbp r15 rdi)))
              (set! void5.16 rax))
            (if (begin
                  (if (begin
                        (set! tmp.137 (bitwise-and procedure1.20 7))
                        (= tmp.137 2))
                    (set! tmp.136 14)
                    (set! tmp.136 6))
                  (!= tmp.136 6))
              (if (begin
                    (if (begin
                          (set! tmp.139 (mref procedure1.20 6))
                          (= tmp.139 0))
                      (set! tmp.138 14)
                      (set! tmp.138 6))
                    (!= tmp.138 6))
                (begin
                  (set! tmp.140 (mref procedure1.20 -2))
                  (begin
                    (set! rdi procedure1.20)
                    (set! r15 tmp-ra.157)
                    (jump tmp.140 rbp r15 rdi)))
                (begin (set! rax 10814) (jump tmp-ra.157 rbp rax)))
              (begin (set! rax 11070) (jump tmp-ra.157 rbp rax)))))))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () ())))
    (define L.lam.78.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.95 rdi)
          (begin
            (set! fun/error12088.11 (mref c.95 14))
            (begin
              (set! rdi fun/error12088.11)
              (set! r15 tmp-ra.159)
              (jump L.fun/error12088.11.18 rbp r15 rdi))))))
    (define L.fun/void12098.15.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.94 rdi)
          (begin
            (set! fun/void12099.10 (mref c.94 14))
            (begin
              (set! rdi fun/void12099.10)
              (set! r15 tmp-ra.160)
              (jump L.fun/void12099.10.17 rbp r15 rdi))))))
    (define L.fun/error12094.14.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.93 rdi)
          (begin
            (set! fun/error12095.6 (mref c.93 14))
            (begin
              (set! rdi fun/error12095.6)
              (set! r15 tmp-ra.161)
              (jump L.fun/error12095.6.13 rbp r15 rdi))))))
    (define L.fun/error12089.13.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.92 rdi)
          (begin (begin (set! rax 29246) (jump tmp-ra.162 rbp rax))))))
    (define L.fun/empty12097.12.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.91 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.163 rbp rax))))))
    (define L.fun/error12088.11.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.164 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/error12089.13 (mref c.90 14))
            (begin
              (set! rdi fun/error12089.13)
              (set! r15 tmp-ra.164)
              (jump L.fun/error12089.13.20 rbp r15 rdi))))))
    (define L.fun/void12099.10.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.165 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.165 rbp rax))))))
    (define L.fun/any12093.9.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.166 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.166 rbp rax))))))
    (define L.fun/empty12091.8.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.167 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.167 rbp rax))))))
    (define L.fun/empty12096.7.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.168 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! fun/empty12097.12 (mref c.86 14))
            (begin
              (set! rdi fun/empty12097.12)
              (set! r15 tmp-ra.168)
              (jump L.fun/empty12097.12.19 rbp r15 rdi))))))
    (define L.fun/error12095.6.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.169 r15)
        (begin
          (set! c.85 rdi)
          (begin (begin (set! rax 11582) (jump tmp-ra.169 rbp rax))))))
    (define L.fun/empty12090.5.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.170 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! fun/empty12091.8 (mref c.84 14))
            (begin
              (set! rdi fun/empty12091.8)
              (set! r15 tmp-ra.170)
              (jump L.fun/empty12091.8.15 rbp r15 rdi))))))
    (define L.fun/any12092.4.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.171 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/any12093.9 (mref c.83 14))
            (begin
              (set! rdi fun/any12093.9)
              (set! r15 tmp-ra.171)
              (jump L.fun/any12093.9.16 rbp r15 rdi))))))
    (define L.-.74.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.172 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.40 rsi)
          (set! tmp.41 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.114 (bitwise-and tmp.41 7))
                        (= tmp.114 0))
                    (set! tmp.113 14)
                    (set! tmp.113 6))
                  (!= tmp.113 6))
              (if (begin
                    (if (begin
                          (set! tmp.116 (bitwise-and tmp.40 7))
                          (= tmp.116 0))
                      (set! tmp.115 14)
                      (set! tmp.115 6))
                    (!= tmp.115 6))
                (begin (set! rax (- tmp.40 tmp.41)) (jump tmp-ra.172 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.172 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.172 rbp rax)))))))
    (define L.+.75.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.173 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.118 (bitwise-and tmp.39 7))
                        (= tmp.118 0))
                    (set! tmp.117 14)
                    (set! tmp.117 6))
                  (!= tmp.117 6))
              (if (begin
                    (if (begin
                          (set! tmp.120 (bitwise-and tmp.38 7))
                          (= tmp.120 0))
                      (set! tmp.119 14)
                      (set! tmp.119 6))
                    (!= tmp.119 6))
                (begin (set! rax (+ tmp.38 tmp.39)) (jump tmp-ra.173 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.173 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.173 rbp rax)))))))
    (define L.*.76.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.174 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.122 (bitwise-and tmp.37 7))
                        (= tmp.122 0))
                    (set! tmp.121 14)
                    (set! tmp.121 6))
                  (!= tmp.121 6))
              (if (begin
                    (if (begin
                          (set! tmp.124 (bitwise-and tmp.36 7))
                          (= tmp.124 0))
                      (set! tmp.123 14)
                      (set! tmp.123 6))
                    (!= tmp.123 6))
                (begin
                  (set! tmp.125 (arithmetic-shift-right tmp.37 3))
                  (begin
                    (set! rax (* tmp.36 tmp.125))
                    (jump tmp-ra.174 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.174 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.174 rbp rax)))))))
    (define L.fixnum?.77.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.175 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.59 rsi)
          (begin
            (if (begin (set! tmp.126 (bitwise-and tmp.59 7)) (= tmp.126 0))
              (begin (set! rax 14) (jump tmp-ra.175 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.175 rbp rax)))))))
    (begin
      (set! tmp-ra.176 r15)
      (begin
        (begin
          (begin (set! tmp.127 (alloc 16)) (set! tmp.96 (+ tmp.127 2)))
          (begin
            (mset! tmp.96 -2 L.fixnum?.77.7)
            (mset! tmp.96 6 8)
            (set! fixnum?.77 tmp.96)))
        (begin
          (begin (set! tmp.128 (alloc 16)) (set! tmp.97 (+ tmp.128 2)))
          (begin
            (mset! tmp.97 -2 L.*.76.8)
            (mset! tmp.97 6 16)
            (set! *.76 tmp.97)))
        (begin
          (begin (set! tmp.129 (alloc 16)) (set! tmp.98 (+ tmp.129 2)))
          (begin
            (mset! tmp.98 -2 L.+.75.9)
            (mset! tmp.98 6 16)
            (set! |+.75| tmp.98)))
        (begin
          (begin (set! tmp.130 (alloc 16)) (set! tmp.99 (+ tmp.130 2)))
          (begin
            (mset! tmp.99 -2 L.-.74.10)
            (mset! tmp.99 6 16)
            (set! |-.74| tmp.99)))
        (begin
          (begin (set! tmp.131 (alloc 24)) (set! tmp.100 (+ tmp.131 2)))
          (begin
            (mset! tmp.100 -2 L.fun/any12092.4.11)
            (mset! tmp.100 6 0)
            (set! fun/any12092.4 tmp.100)))
        (begin
          (begin (set! tmp.132 (alloc 24)) (set! tmp.101 (+ tmp.132 2)))
          (begin
            (mset! tmp.101 -2 L.fun/empty12090.5.12)
            (mset! tmp.101 6 0)
            (set! fun/empty12090.5 tmp.101)))
        (begin
          (begin (set! tmp.133 (alloc 16)) (set! tmp.102 (+ tmp.133 2)))
          (begin
            (mset! tmp.102 -2 L.fun/error12095.6.13)
            (mset! tmp.102 6 0)
            (set! fun/error12095.6 tmp.102)))
        (begin
          (begin (set! tmp.134 (alloc 24)) (set! tmp.103 (+ tmp.134 2)))
          (begin
            (mset! tmp.103 -2 L.fun/empty12096.7.14)
            (mset! tmp.103 6 0)
            (set! fun/empty12096.7 tmp.103)))
        (begin
          (begin (set! tmp.135 (alloc 16)) (set! tmp.104 (+ tmp.135 2)))
          (begin
            (mset! tmp.104 -2 L.fun/empty12091.8.15)
            (mset! tmp.104 6 0)
            (set! fun/empty12091.8 tmp.104)))
        (begin
          (begin (set! tmp.136 (alloc 16)) (set! tmp.105 (+ tmp.136 2)))
          (begin
            (mset! tmp.105 -2 L.fun/any12093.9.16)
            (mset! tmp.105 6 0)
            (set! fun/any12093.9 tmp.105)))
        (begin
          (begin (set! tmp.137 (alloc 16)) (set! tmp.106 (+ tmp.137 2)))
          (begin
            (mset! tmp.106 -2 L.fun/void12099.10.17)
            (mset! tmp.106 6 0)
            (set! fun/void12099.10 tmp.106)))
        (begin
          (begin (set! tmp.138 (alloc 24)) (set! tmp.107 (+ tmp.138 2)))
          (begin
            (mset! tmp.107 -2 L.fun/error12088.11.18)
            (mset! tmp.107 6 0)
            (set! fun/error12088.11 tmp.107)))
        (begin
          (begin (set! tmp.139 (alloc 16)) (set! tmp.108 (+ tmp.139 2)))
          (begin
            (mset! tmp.108 -2 L.fun/empty12097.12.19)
            (mset! tmp.108 6 0)
            (set! fun/empty12097.12 tmp.108)))
        (begin
          (begin (set! tmp.140 (alloc 16)) (set! tmp.109 (+ tmp.140 2)))
          (begin
            (mset! tmp.109 -2 L.fun/error12089.13.20)
            (mset! tmp.109 6 0)
            (set! fun/error12089.13 tmp.109)))
        (begin
          (begin (set! tmp.141 (alloc 24)) (set! tmp.110 (+ tmp.141 2)))
          (begin
            (mset! tmp.110 -2 L.fun/error12094.14.21)
            (mset! tmp.110 6 0)
            (set! fun/error12094.14 tmp.110)))
        (begin
          (begin (set! tmp.142 (alloc 24)) (set! tmp.111 (+ tmp.142 2)))
          (begin
            (mset! tmp.111 -2 L.fun/void12098.15.22)
            (mset! tmp.111 6 0)
            (set! fun/void12098.15 tmp.111)))
        (begin
          (mset! fun/any12092.4 14 fun/any12093.9)
          (mset! fun/empty12090.5 14 fun/empty12091.8)
          (mset! fun/empty12096.7 14 fun/empty12097.12)
          (mset! fun/error12088.11 14 fun/error12089.13)
          (mset! fun/error12094.14 14 fun/error12095.6)
          (mset! fun/void12098.15 14 fun/void12099.10)
          (begin
            (begin
              (begin
                (begin (set! tmp.143 (alloc 24)) (set! tmp.112 (+ tmp.143 2)))
                (begin
                  (mset! tmp.112 -2 L.lam.78.23)
                  (mset! tmp.112 6 0)
                  (set! lam.78 tmp.112)))
              (begin
                (mset! lam.78 14 fun/error12088.11)
                (set! procedure0.21 lam.78)))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.24
                      (begin
                        (set! rdx 1328)
                        (set! rsi 432)
                        (set! rdi |-.74|)
                        (set! r15 L.rp.24)
                        (jump L.-.74.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.146 rax))
                  (begin
                    (begin
                      (return-point L.rp.25
                        (begin
                          (set! rdx 952)
                          (set! rsi 1168)
                          (set! rdi |+.75|)
                          (set! r15 L.rp.25)
                          (jump L.+.75.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.147 rax))
                    (begin
                      (return-point L.rp.26
                        (begin
                          (set! rdx tmp.147)
                          (set! rsi tmp.146)
                          (set! rdi |-.74|)
                          (set! r15 L.rp.26)
                          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.145 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.27
                        (begin
                          (set! rdx 168)
                          (set! rsi 1472)
                          (set! rdi |-.74|)
                          (set! r15 L.rp.27)
                          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.149 rax))
                    (begin
                      (begin
                        (return-point L.rp.28
                          (begin
                            (set! rdx 2024)
                            (set! rsi 64)
                            (set! rdi *.76)
                            (set! r15 L.rp.28)
                            (jump L.*.76.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.150 rax))
                      (begin
                        (return-point L.rp.29
                          (begin
                            (set! rdx tmp.150)
                            (set! rsi tmp.149)
                            (set! rdi |-.74|)
                            (set! r15 L.rp.29)
                            (jump L.-.74.10 rbp r15 rdi rsi rdx)))
                        (set! tmp.148 rax))))
                  (begin
                    (return-point L.rp.30
                      (begin
                        (set! rdx tmp.148)
                        (set! rsi tmp.145)
                        (set! rdi *.76)
                        (set! r15 L.rp.30)
                        (jump L.*.76.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.144 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx 760)
                          (set! rsi 1672)
                          (set! rdi |-.74|)
                          (set! r15 L.rp.31)
                          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.153 rax))
                    (begin
                      (begin
                        (return-point L.rp.32
                          (begin
                            (set! rdx 1968)
                            (set! rsi 240)
                            (set! rdi |+.75|)
                            (set! r15 L.rp.32)
                            (jump L.+.75.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.154 rax))
                      (begin
                        (return-point L.rp.33
                          (begin
                            (set! rdx tmp.154)
                            (set! rsi tmp.153)
                            (set! rdi |+.75|)
                            (set! r15 L.rp.33)
                            (jump L.+.75.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.152 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.34
                          (begin
                            (set! rdx 696)
                            (set! rsi 544)
                            (set! rdi |+.75|)
                            (set! r15 L.rp.34)
                            (jump L.+.75.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.156 rax))
                      (begin
                        (begin
                          (return-point L.rp.35
                            (begin
                              (set! rdx 1904)
                              (set! rsi 1528)
                              (set! rdi |-.74|)
                              (set! r15 L.rp.35)
                              (jump L.-.74.10 rbp r15 rdi rsi rdx)))
                          (set! tmp.157 rax))
                        (begin
                          (return-point L.rp.36
                            (begin
                              (set! rdx tmp.157)
                              (set! rsi tmp.156)
                              (set! rdi *.76)
                              (set! r15 L.rp.36)
                              (jump L.*.76.8 rbp r15 rdi rsi rdx)))
                          (set! tmp.155 rax))))
                    (begin
                      (return-point L.rp.37
                        (begin
                          (set! rdx tmp.155)
                          (set! rsi tmp.152)
                          (set! rdi |-.74|)
                          (set! r15 L.rp.37)
                          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.151 rax))))
                (begin
                  (return-point L.rp.38
                    (begin
                      (set! rdx tmp.151)
                      (set! rsi tmp.144)
                      (set! rdi |-.74|)
                      (set! r15 L.rp.38)
                      (jump L.-.74.10 rbp r15 rdi rsi rdx)))
                  (set! fixnum1.20 rax))))
            (begin
              (return-point L.rp.39
                (begin
                  (set! rdi fun/empty12090.5)
                  (set! r15 L.rp.39)
                  (jump L.fun/empty12090.5.12 rbp r15 rdi)))
              (set! empty2.19 rax))
            (begin
              (begin
                (return-point L.rp.40
                  (begin
                    (set! rdi fun/any12092.4)
                    (set! r15 L.rp.40)
                    (jump L.fun/any12092.4.11 rbp r15 rdi)))
                (set! tmp.158 rax))
              (begin
                (return-point L.rp.41
                  (begin
                    (set! rsi tmp.158)
                    (set! rdi fixnum?.77)
                    (set! r15 L.rp.41)
                    (jump L.fixnum?.77.7 rbp r15 rdi rsi)))
                (set! boolean3.18 rax)))
            (begin
              (return-point L.rp.42
                (begin
                  (set! rdi fun/error12094.14)
                  (set! r15 L.rp.42)
                  (jump L.fun/error12094.14.21 rbp r15 rdi)))
              (set! error4.17 rax))
            (begin
              (return-point L.rp.43
                (begin
                  (set! rdi fun/empty12096.7)
                  (set! r15 L.rp.43)
                  (jump L.fun/empty12096.7.14 rbp r15 rdi)))
              (set! empty5.16 rax))
            (begin
              (set! rdi fun/void12098.15)
              (set! r15 tmp-ra.176)
              (jump L.fun/void12098.15.22 rbp r15 rdi))))))))
