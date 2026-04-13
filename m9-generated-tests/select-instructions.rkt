#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
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
    (define L.cons.56.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.62 r15)
        (begin
          (set! c.57 rdi)
          (set! tmp.51 rsi)
          (set! tmp.52 rdx)
          (begin
            (begin
              (begin (set! tmp.60 (alloc 16)) (set! tmp.58 (+ tmp.60 1)))
              (begin
                (mset! tmp.58 -1 tmp.51)
                (mset! tmp.58 7 tmp.52)
                (begin (set! rax tmp.58) (jump tmp-ra.62 rbp rax))))))))
    (begin
      (set! tmp-ra.63 r15)
      (begin
        (begin
          (begin (set! tmp.61 (alloc 16)) (set! tmp.59 (+ tmp.61 2)))
          (begin
            (mset! tmp.59 -2 L.cons.56.7)
            (mset! tmp.59 6 16)
            (set! cons.56 tmp.59)))
        (begin
          (set! rdx 4008)
          (set! rsi 48)
          (set! rdi cons.56)
          (set! r15 tmp-ra.63)
          (jump L.cons.56.7 rbp r15 rdi rsi rdx))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.cons.56.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.62 r15)
        (begin
          (set! c.57 rdi)
          (set! tmp.51 rsi)
          (set! tmp.52 rdx)
          (begin
            (begin
              (begin (set! tmp.60 (alloc 16)) (set! tmp.58 (+ tmp.60 1)))
              (begin
                (mset! tmp.58 -1 tmp.51)
                (mset! tmp.58 7 tmp.52)
                (begin (set! rax tmp.58) (jump tmp-ra.62 rbp rax))))))))
    (begin
      (set! tmp-ra.63 r15)
      (begin
        (begin
          (begin (set! tmp.61 (alloc 16)) (set! tmp.59 (+ tmp.61 2)))
          (begin
            (mset! tmp.59 -2 L.cons.56.7)
            (mset! tmp.59 6 16)
            (set! cons.56 tmp.59)))
        (begin
          (set! rdx 4080)
          (set! rsi 336)
          (set! rdi cons.56)
          (set! r15 tmp-ra.63)
          (jump L.cons.56.7 rbp r15 rdi rsi rdx))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/error8439.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (begin
          (set! c.57 rdi)
          (begin (begin (set! rax 37950) (jump tmp-ra.60 rbp rax))))))
    (begin
      (set! tmp-ra.61 r15)
      (begin
        (begin
          (begin (set! tmp.59 (alloc 16)) (set! tmp.58 (+ tmp.59 2)))
          (begin
            (mset! tmp.58 -2 L.fun/error8439.4.7)
            (mset! tmp.58 6 0)
            (set! fun/error8439.4 tmp.58)))
        (begin
          (set! rdi fun/error8439.4)
          (set! r15 tmp-ra.61)
          (jump L.fun/error8439.4.7 rbp r15 rdi))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/error8442.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (begin
          (set! c.57 rdi)
          (begin (begin (set! rax 63294) (jump tmp-ra.60 rbp rax))))))
    (begin
      (set! tmp-ra.61 r15)
      (begin
        (begin
          (begin (set! tmp.59 (alloc 16)) (set! tmp.58 (+ tmp.59 2)))
          (begin
            (mset! tmp.58 -2 L.fun/error8442.4.7)
            (mset! tmp.58 6 0)
            (set! fun/error8442.4 tmp.58)))
        (begin
          (set! rdi fun/error8442.4)
          (set! r15 tmp-ra.61)
          (jump L.fun/error8442.4.7 rbp r15 rdi))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/error8445.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (begin
          (set! c.57 rdi)
          (begin (begin (set! rax 36158) (jump tmp-ra.60 rbp rax))))))
    (begin
      (set! tmp-ra.61 r15)
      (begin
        (begin
          (begin (set! tmp.59 (alloc 16)) (set! tmp.58 (+ tmp.59 2)))
          (begin
            (mset! tmp.58 -2 L.fun/error8445.4.7)
            (mset! tmp.58 6 0)
            (set! fun/error8445.4 tmp.58)))
        (begin
          (set! rdi fun/error8445.4)
          (set! r15 tmp-ra.61)
          (jump L.fun/error8445.4.7 rbp r15 rdi))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/pair8448.4.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.66 r15)
        (begin
          (set! c.59 rdi)
          (begin
            (set! cons.57 (mref c.59 14))
            (begin
              (set! rdx 2216)
              (set! rsi 1464)
              (set! rdi cons.57)
              (set! r15 tmp-ra.66)
              (jump L.cons.57.7 rbp r15 rdi rsi rdx))))))
    (define L.cons.57.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.67 r15)
        (begin
          (set! c.58 rdi)
          (set! tmp.52 rsi)
          (set! tmp.53 rdx)
          (begin
            (begin
              (begin (set! tmp.63 (alloc 16)) (set! tmp.60 (+ tmp.63 1)))
              (begin
                (mset! tmp.60 -1 tmp.52)
                (mset! tmp.60 7 tmp.53)
                (begin (set! rax tmp.60) (jump tmp-ra.67 rbp rax))))))))
    (begin
      (set! tmp-ra.68 r15)
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
          (begin
            (set! rdi fun/pair8448.4)
            (set! r15 tmp-ra.68)
            (jump L.fun/pair8448.4.8 rbp r15 rdi)))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (begin
      (set! tmp-ra.58 r15)
      (begin
        (set! ascii-char0.5 20014)
        (set! void1.4 30)
        (begin (set! rax 14) (jump tmp-ra.58 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames (())))
    (define L.lam.59.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.84 r15)
        (begin
          (set! c.63 rdi)
          (begin (begin (set! rax 576) (jump tmp-ra.84 rbp rax))))))
    (define L.make-vector.58.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (begin
          (set! c.62 rdi)
          (set! tmp.34 rsi)
          (begin
            (set! make-init-vector.1 (mref c.62 14))
            (if (begin
                  (if (begin (set! tmp.70 (bitwise-and tmp.34 7)) (= tmp.70 0))
                    (set! tmp.69 14)
                    (set! tmp.69 6))
                  (!= tmp.69 6))
              (begin
                (set! rsi tmp.34)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.85)
                (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.85 rbp rax)))))))
    (define L.make-init-vector.1.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (begin
          (set! c.61 rdi)
          (set! tmp.6 rsi)
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
              (begin
                (set! rcx tmp.7)
                (set! rdx 0)
                (set! rsi tmp.6)
                (set! rdi vector-init-loop.8)
                (set! r15 tmp-ra.86)
                (jump L.vector-init-loop.8.7 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.8.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (begin
          (set! c.60 rdi)
          (set! len.9 rsi)
          (set! i.11 rdx)
          (set! vec.10 rcx)
          (begin
            (set! vector-init-loop.8 (mref c.60 14))
            (if (begin
                  (if (= len.9 i.11) (set! tmp.75 14) (set! tmp.75 6))
                  (!= tmp.75 6))
              (begin (set! rax vec.10) (jump tmp-ra.87 rbp rax))
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
                  (begin
                    (set! rcx vec.10)
                    (set! rdx tmp.79)
                    (set! rsi len.9)
                    (set! rdi vector-init-loop.8)
                    (set! r15 tmp-ra.87)
                    (jump
                     L.vector-init-loop.8.7
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (begin
      (set! tmp-ra.88 r15)
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
            (begin
              (return-point L.rp.11
                (begin
                  (set! rsi 64)
                  (set! rdi make-vector.58)
                  (set! r15 L.rp.11)
                  (jump L.make-vector.58.9 rbp r15 rdi rsi)))
              (set! vector0.5 rax))
            (begin
              (begin
                (begin (set! tmp.83 (alloc 16)) (set! tmp.68 (+ tmp.83 2)))
                (begin
                  (mset! tmp.68 -2 L.lam.59.10)
                  (mset! tmp.68 6 0)
                  (set! lam.59 tmp.68)))
              (set! procedure1.4 lam.59))
            (begin (set! rax 22) (jump tmp-ra.88 rbp rax))))))))
(check-by-interp
 '(module
    ((new-frames (() ())))
    (define L.fun/empty8457.5.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.72 r15)
        (begin
          (set! c.62 rdi)
          (set! oprand0.6 rsi)
          (begin
            (set! fun/empty8458.4 (mref c.62 14))
            (begin
              (set! rdi fun/empty8458.4)
              (set! r15 tmp-ra.72)
              (jump L.fun/empty8458.4.8 rbp r15 rdi))))))
    (define L.fun/empty8458.4.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.73 r15)
        (begin
          (set! c.61 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.73 rbp rax))))))
    (define L.cons.59.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.74 r15)
        (begin
          (set! c.60 rdi)
          (set! tmp.54 rsi)
          (set! tmp.55 rdx)
          (begin
            (begin
              (begin (set! tmp.67 (alloc 16)) (set! tmp.63 (+ tmp.67 1)))
              (begin
                (mset! tmp.63 -1 tmp.54)
                (mset! tmp.63 7 tmp.55)
                (begin (set! rax tmp.63) (jump tmp-ra.74 rbp rax))))))))
    (begin
      (set! tmp-ra.75 r15)
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
              (begin
                (return-point L.rp.10
                  (begin
                    (set! rdx 3840)
                    (set! rsi 1576)
                    (set! rdi cons.59)
                    (set! r15 L.rp.10)
                    (jump L.cons.59.7 rbp r15 rdi rsi rdx)))
                (set! tmp.71 rax))
              (begin
                (return-point L.rp.11
                  (begin
                    (set! rdx 3368)
                    (set! rsi 376)
                    (set! rdi cons.59)
                    (set! r15 L.rp.11)
                    (jump L.cons.59.7 rbp r15 rdi rsi rdx)))
                (set! tmp.71 rax)))
            (begin
              (set! rsi tmp.71)
              (set! rdi fun/empty8457.5)
              (set! r15 tmp-ra.75)
              (jump L.fun/empty8457.5.9 rbp r15 rdi rsi))))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (begin
      (set! tmp-ra.56 r15)
      (if (!= 6 6)
        (begin (set! rax 30) (jump tmp-ra.56 rbp rax))
        (begin (set! rax 30) (jump tmp-ra.56 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.make-vector.56.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.78 r15)
        (begin
          (set! c.59 rdi)
          (set! tmp.32 rsi)
          (begin
            (set! make-init-vector.1 (mref c.59 14))
            (if (begin
                  (if (begin (set! tmp.65 (bitwise-and tmp.32 7)) (= tmp.65 0))
                    (set! tmp.64 14)
                    (set! tmp.64 6))
                  (!= tmp.64 6))
              (begin
                (set! rsi tmp.32)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.78)
                (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.78 rbp rax)))))))
    (define L.make-init-vector.1.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.79 r15)
        (begin
          (set! c.58 rdi)
          (set! tmp.4 rsi)
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
              (begin
                (set! rcx tmp.5)
                (set! rdx 0)
                (set! rsi tmp.4)
                (set! rdi vector-init-loop.6)
                (set! r15 tmp-ra.79)
                (jump L.vector-init-loop.6.7 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.6.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.80 r15)
        (begin
          (set! c.57 rdi)
          (set! len.7 rsi)
          (set! i.9 rdx)
          (set! vec.8 rcx)
          (begin
            (set! vector-init-loop.6 (mref c.57 14))
            (if (begin
                  (if (= len.7 i.9) (set! tmp.70 14) (set! tmp.70 6))
                  (!= tmp.70 6))
              (begin (set! rax vec.8) (jump tmp-ra.80 rbp rax))
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
                  (begin
                    (set! rcx vec.8)
                    (set! rdx tmp.74)
                    (set! rsi len.7)
                    (set! rdi vector-init-loop.6)
                    (set! r15 tmp-ra.80)
                    (jump
                     L.vector-init-loop.6.7
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (begin
      (set! tmp-ra.81 r15)
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
            (begin
              (set! rsi 64)
              (set! rdi make-vector.56)
              (set! r15 tmp-ra.81)
              (jump L.make-vector.56.9 rbp r15 rdi rsi))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.56)
              (set! r15 tmp-ra.81)
              (jump L.make-vector.56.9 rbp r15 rdi rsi))))))))
(check-by-interp
 '(module
    ((new-frames (() ())))
    (define L.fun/empty8466.6.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.78 r15)
        (begin
          (set! c.65 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.78 rbp rax))))))
    (define L.fun/empty8465.5.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.79 r15)
        (begin
          (set! c.64 rdi)
          (set! oprand0.8 rsi)
          (begin
            (set! fun/empty8466.6 (mref c.64 14))
            (begin
              (set! rdi fun/empty8466.6)
              (set! r15 tmp-ra.79)
              (jump L.fun/empty8466.6.10 rbp r15 rdi))))))
    (define L.fun/error8467.4.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.80 r15)
        (begin
          (set! c.63 rdi)
          (set! oprand0.7 rsi)
          (begin (begin (set! rax 44862) (jump tmp-ra.80 rbp rax))))))
    (define L.cons.61.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.81 r15)
        (begin
          (set! c.62 rdi)
          (set! tmp.56 rsi)
          (set! tmp.57 rdx)
          (begin
            (begin
              (begin (set! tmp.71 (alloc 16)) (set! tmp.66 (+ tmp.71 1)))
              (begin
                (mset! tmp.66 -1 tmp.56)
                (mset! tmp.66 7 tmp.57)
                (begin (set! rax tmp.66) (jump tmp-ra.81 rbp rax))))))))
    (begin
      (set! tmp-ra.82 r15)
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
              (begin
                (return-point L.rp.11
                  (begin
                    (set! rdx 4016)
                    (set! rsi 632)
                    (set! rdi cons.61)
                    (set! r15 L.rp.11)
                    (jump L.cons.61.7 rbp r15 rdi rsi rdx)))
                (set! tmp.77 rax))
              (begin
                (return-point L.rp.12
                  (begin
                    (set! rsi tmp.77)
                    (set! rdi fun/error8467.4)
                    (set! r15 L.rp.12)
                    (jump L.fun/error8467.4.8 rbp r15 rdi rsi)))
                (set! tmp.76 rax)))
            (begin
              (set! rsi tmp.76)
              (set! rdi fun/empty8465.5)
              (set! r15 tmp-ra.82)
              (jump L.fun/empty8465.5.9 rbp r15 rdi rsi))))))))
(check-by-interp
 '(module
    ((new-frames (() () ())))
    (define L.fun/void8483.6.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.84 r15)
        (begin
          (set! c.67 rdi)
          (set! oprand0.10 rsi)
          (set! oprand1.9 rdx)
          (begin
            (set! fun/void8484.4 (mref c.67 14))
            (begin
              (set! rdi fun/void8484.4)
              (set! r15 tmp-ra.84)
              (jump L.fun/void8484.4.8 rbp r15 rdi))))))
    (define L.fun/ascii-char8485.5.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (begin
          (set! c.66 rdi)
          (set! oprand0.8 rsi)
          (set! oprand1.7 rdx)
          (begin (begin (set! rax 16942) (jump tmp-ra.85 rbp rax))))))
    (define L.fun/void8484.4.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (begin
          (set! c.65 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.86 rbp rax))))))
    (define L.-.63.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (begin
          (set! c.64 rdi)
          (set! tmp.29 rsi)
          (set! tmp.30 rdx)
          (begin
            (if (begin
                  (if (begin (set! tmp.73 (bitwise-and tmp.30 7)) (= tmp.73 0))
                    (set! tmp.72 14)
                    (set! tmp.72 6))
                  (!= tmp.72 6))
              (if (begin
                    (if (begin
                          (set! tmp.75 (bitwise-and tmp.29 7))
                          (= tmp.75 0))
                      (set! tmp.74 14)
                      (set! tmp.74 6))
                    (!= tmp.74 6))
                (begin (set! rax (- tmp.29 tmp.30)) (jump tmp-ra.87 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.87 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.87 rbp rax)))))))
    (begin
      (set! tmp-ra.88 r15)
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
              (begin
                (return-point L.rp.11
                  (begin
                    (set! rdx 704)
                    (set! rsi 224)
                    (set! rdi |-.63|)
                    (set! r15 L.rp.11)
                    (jump L.-.63.7 rbp r15 rdi rsi rdx)))
                (set! tmp.81 rax))
              (begin
                (begin
                  (return-point L.rp.12
                    (begin
                      (set! rdx 17198)
                      (set! rsi 704)
                      (set! rdi fun/ascii-char8485.5)
                      (set! r15 L.rp.12)
                      (jump L.fun/ascii-char8485.5.9 rbp r15 rdi rsi rdx)))
                  (set! tmp.82 rax))
                (begin
                  (return-point L.rp.13
                    (begin
                      (set! rdx tmp.82)
                      (set! rsi tmp.81)
                      (set! rdi fun/ascii-char8485.5)
                      (set! r15 L.rp.13)
                      (jump L.fun/ascii-char8485.5.9 rbp r15 rdi rsi rdx)))
                  (set! tmp.80 rax))))
            (begin
              (if (!= 14 6) (set! tmp.83 960) (set! tmp.83 528))
              (begin
                (set! rdx tmp.83)
                (set! rsi tmp.80)
                (set! rdi fun/void8483.6)
                (set! r15 tmp-ra.88)
                (jump L.fun/void8483.6.10 rbp r15 rdi rsi rdx)))))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (begin
      (set! tmp-ra.59 r15)
      (if (if (!= 14 6) (!= 14 6) (!= 6 6))
        (if (!= 14 6)
          (begin (set! rax 4670) (jump tmp-ra.59 rbp rax))
          (begin (set! rax 26430) (jump tmp-ra.59 rbp rax)))
        (begin
          (set! ascii-char0.6 28718)
          (set! fixnum1.5 1608)
          (set! empty2.4 22)
          (begin (set! rax 5438) (jump tmp-ra.59 rbp rax)))))))
(check-by-interp
 '(module
    ((new-frames (() () () ())))
    (define L.fun/void8491.6.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.99 r15)
        (begin
          (set! c.70 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.99 rbp rax))))))
    (define L.fun/void8490.5.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.100 r15)
        (begin
          (set! c.69 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.100 rbp rax))))))
    (define L.fun/error8492.4.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.101 r15)
        (begin
          (set! c.68 rdi)
          (begin (begin (set! rax 19774) (jump tmp-ra.101 rbp rax))))))
    (define L.make-vector.62.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.102 r15)
        (begin
          (set! c.67 rdi)
          (set! tmp.38 rsi)
          (begin
            (set! make-init-vector.1 (mref c.67 14))
            (if (begin
                  (if (begin (set! tmp.80 (bitwise-and tmp.38 7)) (= tmp.80 0))
                    (set! tmp.79 14)
                    (set! tmp.79 6))
                  (!= tmp.79 6))
              (begin
                (set! rsi tmp.38)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.102)
                (jump L.make-init-vector.1.9 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.102 rbp rax)))))))
    (define L.make-init-vector.1.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.103 r15)
        (begin
          (set! c.66 rdi)
          (set! tmp.10 rsi)
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
              (begin
                (set! rcx tmp.11)
                (set! rdx 0)
                (set! rsi tmp.10)
                (set! rdi vector-init-loop.12)
                (set! r15 tmp-ra.103)
                (jump L.vector-init-loop.12.8 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.12.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.104 r15)
        (begin
          (set! c.65 rdi)
          (set! len.13 rsi)
          (set! i.15 rdx)
          (set! vec.14 rcx)
          (begin
            (set! vector-init-loop.12 (mref c.65 14))
            (if (begin
                  (if (= len.13 i.15) (set! tmp.85 14) (set! tmp.85 6))
                  (!= tmp.85 6))
              (begin (set! rax vec.14) (jump tmp-ra.104 rbp rax))
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
                  (begin
                    (set! rcx vec.14)
                    (set! rdx tmp.89)
                    (set! rsi len.13)
                    (set! rdi vector-init-loop.12)
                    (set! r15 tmp-ra.104)
                    (jump
                     L.vector-init-loop.12.8
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.vector?.63.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.105 r15)
        (begin
          (set! c.64 rdi)
          (set! tmp.54 rsi)
          (begin
            (if (begin (set! tmp.90 (bitwise-and tmp.54 7)) (= tmp.90 3))
              (begin (set! rax 14) (jump tmp-ra.105 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.105 rbp rax)))))))
    (begin
      (set! tmp-ra.106 r15)
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
            (begin
              (return-point L.rp.14
                (begin
                  (set! rdi fun/void8490.5)
                  (set! r15 L.rp.14)
                  (jump L.fun/void8490.5.12 rbp r15 rdi)))
              (set! void0.9 rax))
            (begin
              (return-point L.rp.15
                (begin
                  (set! rdi fun/void8491.6)
                  (set! r15 L.rp.15)
                  (jump L.fun/void8491.6.13 rbp r15 rdi)))
              (set! void1.8 rax))
            (begin
              (begin
                (return-point L.rp.16
                  (begin
                    (set! rsi 64)
                    (set! rdi make-vector.62)
                    (set! r15 L.rp.16)
                    (jump L.make-vector.62.10 rbp r15 rdi rsi)))
                (set! tmp.98 rax))
              (begin
                (return-point L.rp.17
                  (begin
                    (set! rsi tmp.98)
                    (set! rdi vector?.63)
                    (set! r15 L.rp.17)
                    (jump L.vector?.63.7 rbp r15 rdi rsi)))
                (set! boolean2.7 rax)))
            (begin
              (set! rdi fun/error8492.4)
              (set! r15 tmp-ra.106)
              (jump L.fun/error8492.4.11 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (())))
    (define L.fun/error8495.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (begin
          (set! c.63 rdi)
          (set! oprand0.6 rsi)
          (set! oprand1.5 rdx)
          (begin (begin (set! rax 17470) (jump tmp-ra.85 rbp rax))))))
    (define L.make-vector.59.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (begin
          (set! c.62 rdi)
          (set! tmp.35 rsi)
          (begin
            (set! make-init-vector.1 (mref c.62 14))
            (if (begin
                  (if (begin (set! tmp.70 (bitwise-and tmp.35 7)) (= tmp.70 0))
                    (set! tmp.69 14)
                    (set! tmp.69 6))
                  (!= tmp.69 6))
              (begin
                (set! rsi tmp.35)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.86)
                (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.86 rbp rax)))))))
    (define L.make-init-vector.1.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (begin
          (set! c.61 rdi)
          (set! tmp.7 rsi)
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
              (begin
                (set! rcx tmp.8)
                (set! rdx 0)
                (set! rsi tmp.7)
                (set! rdi vector-init-loop.9)
                (set! r15 tmp-ra.87)
                (jump L.vector-init-loop.9.7 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.9.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (begin
          (set! c.60 rdi)
          (set! len.10 rsi)
          (set! i.12 rdx)
          (set! vec.11 rcx)
          (begin
            (set! vector-init-loop.9 (mref c.60 14))
            (if (begin
                  (if (= len.10 i.12) (set! tmp.75 14) (set! tmp.75 6))
                  (!= tmp.75 6))
              (begin (set! rax vec.11) (jump tmp-ra.88 rbp rax))
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
                  (begin
                    (set! rcx vec.11)
                    (set! rdx tmp.79)
                    (set! rsi len.10)
                    (set! rdi vector-init-loop.9)
                    (set! r15 tmp-ra.88)
                    (jump
                     L.vector-init-loop.9.7
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (begin
      (set! tmp-ra.89 r15)
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
            (if (!= 14 6)
              (begin (set! rax 59198) (jump tmp-ra.89 rbp rax))
              (begin (set! rax 39998) (jump tmp-ra.89 rbp rax)))
            (begin
              (begin
                (return-point L.rp.11
                  (begin
                    (set! rsi 64)
                    (set! rdi make-vector.59)
                    (set! r15 L.rp.11)
                    (jump L.make-vector.59.9 rbp r15 rdi rsi)))
                (set! tmp.84 rax))
              (begin
                (set! rdx tmp.84)
                (set! rsi 25390)
                (set! rdi fun/error8495.4)
                (set! r15 tmp-ra.89)
                (jump L.fun/error8495.4.10 rbp r15 rdi rsi rdx)))))))))
(check-by-interp
 '(module
    ((new-frames (() () ())))
    (define L.fun/ascii-char8529.5.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.80 r15)
        (begin
          (set! c.66 rdi)
          (begin (begin (set! rax 22318) (jump tmp-ra.80 rbp rax))))))
    (define L.fun/error8528.4.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.81 r15)
        (begin
          (set! c.65 rdi)
          (begin (begin (set! rax 55102) (jump tmp-ra.81 rbp rax))))))
    (define L.empty?.61.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.82 r15)
        (begin
          (set! c.64 rdi)
          (set! tmp.48 rsi)
          (begin
            (if (begin (set! tmp.71 (bitwise-and tmp.48 255)) (= tmp.71 22))
              (begin (set! rax 14) (jump tmp-ra.82 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.82 rbp rax)))))))
    (define L.-.62.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.83 r15)
        (begin
          (set! c.63 rdi)
          (set! tmp.27 rsi)
          (set! tmp.28 rdx)
          (begin
            (if (begin
                  (if (begin (set! tmp.73 (bitwise-and tmp.28 7)) (= tmp.73 0))
                    (set! tmp.72 14)
                    (set! tmp.72 6))
                  (!= tmp.72 6))
              (if (begin
                    (if (begin
                          (set! tmp.75 (bitwise-and tmp.27 7))
                          (= tmp.75 0))
                      (set! tmp.74 14)
                      (set! tmp.74 6))
                    (!= tmp.74 6))
                (begin (set! rax (- tmp.27 tmp.28)) (jump tmp-ra.83 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))))))
    (begin
      (set! tmp-ra.84 r15)
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
          (begin
            (return-point L.rp.11
              (begin
                (set! rdi fun/error8528.4)
                (set! r15 L.rp.11)
                (jump L.fun/error8528.4.9 rbp r15 rdi)))
            (set! error0.8 rax))
          (begin
            (return-point L.rp.12
              (begin
                (set! rdi fun/ascii-char8529.5)
                (set! r15 L.rp.12)
                (jump L.fun/ascii-char8529.5.10 rbp r15 rdi)))
            (set! ascii-char1.7 rax))
          (begin
            (return-point L.rp.13
              (begin
                (set! rsi 18734)
                (set! rdi empty?.61)
                (set! r15 L.rp.13)
                (jump L.empty?.61.8 rbp r15 rdi rsi)))
            (set! boolean2.6 rax))
          (begin
            (set! rdx 1960)
            (set! rsi 1488)
            (set! rdi |-.62|)
            (set! r15 tmp-ra.84)
            (jump L.-.62.7 rbp r15 rdi rsi rdx)))))))
(check-by-interp
 '(module
    ((new-frames (())))
    (define L.fun/pair8538.5.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.75 r15)
        (begin
          (set! c.65 rdi)
          (set! oprand0.9 rsi)
          (set! oprand1.8 rdx)
          (begin
            (set! cons.62 (mref c.65 14))
            (begin
              (set! rdx 4080)
              (set! rsi 40)
              (set! rdi cons.62)
              (set! r15 tmp-ra.75)
              (jump L.cons.62.7 rbp r15 rdi rsi rdx))))))
    (define L.fun/pair8539.4.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.76 r15)
        (begin
          (set! c.64 rdi)
          (set! oprand0.7 rsi)
          (set! oprand1.6 rdx)
          (begin (begin (set! rax oprand1.6) (jump tmp-ra.76 rbp rax))))))
    (define L.cons.62.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.77 r15)
        (begin
          (set! c.63 rdi)
          (set! tmp.57 rsi)
          (set! tmp.58 rdx)
          (begin
            (begin
              (begin (set! tmp.70 (alloc 16)) (set! tmp.66 (+ tmp.70 1)))
              (begin
                (mset! tmp.66 -1 tmp.57)
                (mset! tmp.66 7 tmp.58)
                (begin (set! rax tmp.66) (jump tmp-ra.77 rbp rax))))))))
    (begin
      (set! tmp-ra.78 r15)
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
            (begin
              (set! rdx 6)
              (set! rsi 1976)
              (set! rdi fun/pair8538.5)
              (set! r15 tmp-ra.78)
              (jump L.fun/pair8538.5.9 rbp r15 rdi rsi rdx))
            (begin
              (begin
                (return-point L.rp.10
                  (begin
                    (set! rdx 2760)
                    (set! rsi 224)
                    (set! rdi cons.62)
                    (set! r15 L.rp.10)
                    (jump L.cons.62.7 rbp r15 rdi rsi rdx)))
                (set! tmp.74 rax))
              (begin
                (set! rdx tmp.74)
                (set! rsi 6)
                (set! rdi fun/pair8539.4)
                (set! r15 tmp-ra.78)
                (jump L.fun/pair8539.4.8 rbp r15 rdi rsi rdx)))))))))
(check-by-interp
 '(module
    ((new-frames (() () ())))
    (define L.fun/boolean8542.5.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.99 r15)
        (begin
          (set! c.69 rdi)
          (set! oprand0.9 rsi)
          (set! oprand1.8 rdx)
          (begin (begin (set! rax 14) (jump tmp-ra.99 rbp rax))))))
    (define L.fun/ascii-char8543.4.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.100 r15)
        (begin
          (set! c.68 rdi)
          (set! oprand0.7 rsi)
          (set! oprand1.6 rdx)
          (begin (begin (set! rax 30766) (jump tmp-ra.100 rbp rax))))))
    (define L.make-vector.62.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.101 r15)
        (begin
          (set! c.67 rdi)
          (set! tmp.38 rsi)
          (begin
            (set! make-init-vector.1 (mref c.67 14))
            (if (begin
                  (if (begin (set! tmp.79 (bitwise-and tmp.38 7)) (= tmp.79 0))
                    (set! tmp.78 14)
                    (set! tmp.78 6))
                  (!= tmp.78 6))
              (begin
                (set! rsi tmp.38)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.101)
                (jump L.make-init-vector.1.9 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.101 rbp rax)))))))
    (define L.make-init-vector.1.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.102 r15)
        (begin
          (set! c.66 rdi)
          (set! tmp.10 rsi)
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
              (begin
                (set! rcx tmp.11)
                (set! rdx 0)
                (set! rsi tmp.10)
                (set! rdi vector-init-loop.12)
                (set! r15 tmp-ra.102)
                (jump L.vector-init-loop.12.8 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.12.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.103 r15)
        (begin
          (set! c.65 rdi)
          (set! len.13 rsi)
          (set! i.15 rdx)
          (set! vec.14 rcx)
          (begin
            (set! vector-init-loop.12 (mref c.65 14))
            (if (begin
                  (if (= len.13 i.15) (set! tmp.84 14) (set! tmp.84 6))
                  (!= tmp.84 6))
              (begin (set! rax vec.14) (jump tmp-ra.103 rbp rax))
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
                  (begin
                    (set! rcx vec.14)
                    (set! rdx tmp.88)
                    (set! rsi len.13)
                    (set! rdi vector-init-loop.12)
                    (set! r15 tmp-ra.103)
                    (jump
                     L.vector-init-loop.12.8
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.cons.63.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.104 r15)
        (begin
          (set! c.64 rdi)
          (set! tmp.57 rsi)
          (set! tmp.58 rdx)
          (begin
            (begin
              (begin (set! tmp.89 (alloc 16)) (set! tmp.71 (+ tmp.89 1)))
              (begin
                (mset! tmp.71 -1 tmp.57)
                (mset! tmp.71 7 tmp.58)
                (begin (set! rax tmp.71) (jump tmp-ra.104 rbp rax))))))))
    (begin
      (set! tmp-ra.105 r15)
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
                  (begin
                    (return-point L.rp.13
                      (begin
                        (set! rsi 64)
                        (set! rdi make-vector.62)
                        (set! r15 L.rp.13)
                        (jump L.make-vector.62.10 rbp r15 rdi rsi)))
                    (set! tmp.97 rax))
                  (begin
                    (return-point L.rp.14
                      (begin
                        (set! rdx tmp.97)
                        (set! rsi 23854)
                        (set! rdi fun/boolean8542.5)
                        (set! r15 L.rp.14)
                        (jump L.fun/boolean8542.5.12 rbp r15 rdi rsi rdx)))
                    (set! tmp.96 rax)))
                (!= tmp.96 6))
            (begin
              (begin
                (return-point L.rp.15
                  (begin
                    (set! rdx 3056)
                    (set! rsi 1440)
                    (set! rdi cons.63)
                    (set! r15 L.rp.15)
                    (jump L.cons.63.7 rbp r15 rdi rsi rdx)))
                (set! tmp.98 rax))
              (begin
                (set! rdx 1832)
                (set! rsi tmp.98)
                (set! rdi fun/ascii-char8543.4)
                (set! r15 tmp-ra.105)
                (jump L.fun/ascii-char8543.4.11 rbp r15 rdi rsi rdx)))
            (if (!= 6 6)
              (begin (set! rax 24110) (jump tmp-ra.105 rbp rax))
              (begin (set! rax 26926) (jump tmp-ra.105 rbp rax)))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () ())))
    (define L.fun/ascii-char8590.6.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.123 r15)
        (begin
          (set! c.75 rdi)
          (begin (begin (set! rax 17454) (jump tmp-ra.123 rbp rax))))))
    (define L.fun/vector8589.5.14
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
    (define L.fun/empty8591.4.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.125 r15)
        (begin
          (set! c.73 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.125 rbp rax))))))
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
    (define L.-.64.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.129 r15)
        (begin
          (set! c.69 rdi)
          (set! tmp.29 rsi)
          (set! tmp.30 rdx)
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
                (begin (set! rax (- tmp.29 tmp.30)) (jump tmp-ra.129 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.129 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.129 rbp rax)))))))
    (define L.+.65.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.130 r15)
        (begin
          (set! c.68 rdi)
          (set! tmp.27 rsi)
          (set! tmp.28 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.102 (bitwise-and tmp.28 7))
                        (= tmp.102 0))
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
                (begin (set! rax (+ tmp.27 tmp.28)) (jump tmp-ra.130 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.130 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.130 rbp rax)))))))
    (define L.*.66.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.131 r15)
        (begin
          (set! c.67 rdi)
          (set! tmp.25 rsi)
          (set! tmp.26 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.106 (bitwise-and tmp.26 7))
                        (= tmp.106 0))
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
                  (begin
                    (set! rax (* tmp.25 tmp.109))
                    (jump tmp-ra.131 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.131 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.131 rbp rax)))))))
    (begin
      (set! tmp-ra.132 r15)
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
              (begin
                (return-point L.rp.16
                  (begin
                    (set! rdx 576)
                    (set! rsi 1720)
                    (set! rdi |-.64|)
                    (set! r15 L.rp.16)
                    (jump L.-.64.9 rbp r15 rdi rsi rdx)))
                (set! tmp.119 rax))
              (begin
                (begin
                  (return-point L.rp.17
                    (begin
                      (set! rdx 1384)
                      (set! rsi 1752)
                      (set! rdi |-.64|)
                      (set! r15 L.rp.17)
                      (jump L.-.64.9 rbp r15 rdi rsi rdx)))
                  (set! tmp.120 rax))
                (begin
                  (return-point L.rp.18
                    (begin
                      (set! rdx tmp.120)
                      (set! rsi tmp.119)
                      (set! rdi |-.64|)
                      (set! r15 L.rp.18)
                      (jump L.-.64.9 rbp r15 rdi rsi rdx)))
                  (set! fixnum0.10 rax))))
            (begin
              (return-point L.rp.19
                (begin
                  (set! rdi fun/vector8589.5)
                  (set! r15 L.rp.19)
                  (jump L.fun/vector8589.5.14 rbp r15 rdi)))
              (set! vector1.9 rax))
            (begin
              (begin
                (return-point L.rp.20
                  (begin
                    (set! rdx 1760)
                    (set! rsi 744)
                    (set! rdi |+.65|)
                    (set! r15 L.rp.20)
                    (jump L.+.65.8 rbp r15 rdi rsi rdx)))
                (set! tmp.121 rax))
              (begin
                (begin
                  (return-point L.rp.21
                    (begin
                      (set! rdx 1048)
                      (set! rsi 1360)
                      (set! rdi *.66)
                      (set! r15 L.rp.21)
                      (jump L.*.66.7 rbp r15 rdi rsi rdx)))
                  (set! tmp.122 rax))
                (begin
                  (return-point L.rp.22
                    (begin
                      (set! rdx tmp.122)
                      (set! rsi tmp.121)
                      (set! rdi |+.65|)
                      (set! r15 L.rp.22)
                      (jump L.+.65.8 rbp r15 rdi rsi rdx)))
                  (set! fixnum2.8 rax))))
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/ascii-char8590.6)
                  (set! r15 L.rp.23)
                  (jump L.fun/ascii-char8590.6.15 rbp r15 rdi)))
              (set! ascii-char3.7 rax))
            (begin
              (set! rdi fun/empty8591.4)
              (set! r15 tmp-ra.132)
              (jump L.fun/empty8591.4.13 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.cons.56.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.62 r15)
        (begin
          (set! c.57 rdi)
          (set! tmp.51 rsi)
          (set! tmp.52 rdx)
          (begin
            (begin
              (begin (set! tmp.60 (alloc 16)) (set! tmp.58 (+ tmp.60 1)))
              (begin
                (mset! tmp.58 -1 tmp.51)
                (mset! tmp.58 7 tmp.52)
                (begin (set! rax tmp.58) (jump tmp-ra.62 rbp rax))))))))
    (begin
      (set! tmp-ra.63 r15)
      (begin
        (begin
          (begin (set! tmp.61 (alloc 16)) (set! tmp.59 (+ tmp.61 2)))
          (begin
            (mset! tmp.59 -2 L.cons.56.7)
            (mset! tmp.59 6 16)
            (set! cons.56 tmp.59)))
        (if (if (!= 14 6) (!= 14 6) (!= 6 6))
          (if (!= 14 6)
            (begin
              (set! rdx 3360)
              (set! rsi 408)
              (set! rdi cons.56)
              (set! r15 tmp-ra.63)
              (jump L.cons.56.7 rbp r15 rdi rsi rdx))
            (begin
              (set! rdx 2912)
              (set! rsi 320)
              (set! rdi cons.56)
              (set! r15 tmp-ra.63)
              (jump L.cons.56.7 rbp r15 rdi rsi rdx)))
          (if (!= 14 6)
            (begin
              (set! rdx 2800)
              (set! rsi 1928)
              (set! rdi cons.56)
              (set! r15 tmp-ra.63)
              (jump L.cons.56.7 rbp r15 rdi rsi rdx))
            (begin
              (set! rdx 2760)
              (set! rsi 896)
              (set! rdi cons.56)
              (set! r15 tmp-ra.63)
              (jump L.cons.56.7 rbp r15 rdi rsi rdx))))))))
(check-by-interp
 '(module
    ((new-frames (() () ())))
    (define L.lam.65.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.84 r15)
        (begin
          (set! c.71 rdi)
          (begin
            (set! fun/error8691.5 (mref c.71 14))
            (begin
              (set! rdi fun/error8691.5)
              (set! r15 tmp-ra.84)
              (jump L.fun/error8691.5.8 rbp r15 rdi))))))
    (define L.fun/void8690.8.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (begin
          (set! c.70 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.85 rbp rax))))))
    (define L.fun/ascii-char8688.7.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (begin
          (set! c.69 rdi)
          (begin (begin (set! rax 27182) (jump tmp-ra.86 rbp rax))))))
    (define L.fun/empty8692.6.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (begin
          (set! c.68 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.87 rbp rax))))))
    (define L.fun/error8691.5.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (begin
          (set! c.67 rdi)
          (begin (begin (set! rax 31806) (jump tmp-ra.88 rbp rax))))))
    (define L.fun/ascii-char8689.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.89 r15)
        (begin
          (set! c.66 rdi)
          (begin (begin (set! rax 18734) (jump tmp-ra.89 rbp rax))))))
    (begin
      (set! tmp-ra.90 r15)
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
          (begin
            (return-point L.rp.13
              (begin
                (set! rdi fun/ascii-char8688.7)
                (set! r15 L.rp.13)
                (jump L.fun/ascii-char8688.7.10 rbp r15 rdi)))
            (set! ascii-char0.12 rax))
          (begin
            (return-point L.rp.14
              (begin
                (set! rdi fun/ascii-char8689.4)
                (set! r15 L.rp.14)
                (jump L.fun/ascii-char8689.4.7 rbp r15 rdi)))
            (set! ascii-char1.11 rax))
          (begin
            (return-point L.rp.15
              (begin
                (set! rdi fun/void8690.8)
                (set! r15 L.rp.15)
                (jump L.fun/void8690.8.11 rbp r15 rdi)))
            (set! void2.10 rax))
          (begin
            (begin
              (begin (set! tmp.83 (alloc 24)) (set! tmp.77 (+ tmp.83 2)))
              (begin
                (mset! tmp.77 -2 L.lam.65.12)
                (mset! tmp.77 6 0)
                (set! lam.65 tmp.77)))
            (begin
              (mset! lam.65 14 fun/error8691.5)
              (set! procedure3.9 lam.65)))
          (begin
            (set! rdi fun/empty8692.6)
            (set! r15 tmp-ra.90)
            (jump L.fun/empty8692.6.9 rbp r15 rdi)))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ())))
    (define L.fun/any8764.8.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.114 r15)
        (begin
          (set! c.77 rdi)
          (begin (begin (set! rax 14142) (jump tmp-ra.114 rbp rax))))))
    (define L.fun/void8763.7.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.115 r15)
        (begin
          (set! c.76 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.115 rbp rax))))))
    (define L.fun/any8762.6.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.116 r15)
        (begin
          (set! c.75 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.116 rbp rax))))))
    (define L.fun/ascii-char8761.5.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.117 r15)
        (begin
          (set! c.74 rdi)
          (begin (begin (set! rax 27438) (jump tmp-ra.117 rbp rax))))))
    (define L.fun/vector8765.4.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.118 r15)
        (begin
          (set! c.73 rdi)
          (begin
            (set! make-vector.65 (mref c.73 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.65)
              (set! r15 tmp-ra.118)
              (jump L.make-vector.65.11 rbp r15 rdi rsi))))))
    (define L.make-vector.65.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.119 r15)
        (begin
          (set! c.72 rdi)
          (set! tmp.41 rsi)
          (begin
            (set! make-init-vector.1 (mref c.72 14))
            (if (begin
                  (if (begin (set! tmp.90 (bitwise-and tmp.41 7)) (= tmp.90 0))
                    (set! tmp.89 14)
                    (set! tmp.89 6))
                  (!= tmp.89 6))
              (begin
                (set! rsi tmp.41)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.119)
                (jump L.make-init-vector.1.10 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.119 rbp rax)))))))
    (define L.make-init-vector.1.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.120 r15)
        (begin
          (set! c.71 rdi)
          (set! tmp.13 rsi)
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
              (begin
                (set! rcx tmp.14)
                (set! rdx 0)
                (set! rsi tmp.13)
                (set! rdi vector-init-loop.15)
                (set! r15 tmp-ra.120)
                (jump L.vector-init-loop.15.9 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.15.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.121 r15)
        (begin
          (set! c.70 rdi)
          (set! len.16 rsi)
          (set! i.18 rdx)
          (set! vec.17 rcx)
          (begin
            (set! vector-init-loop.15 (mref c.70 14))
            (if (begin
                  (if (= len.16 i.18) (set! tmp.95 14) (set! tmp.95 6))
                  (!= tmp.95 6))
              (begin (set! rax vec.17) (jump tmp-ra.121 rbp rax))
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
                  (begin
                    (set! rcx vec.17)
                    (set! rdx tmp.99)
                    (set! rsi len.16)
                    (set! rdi vector-init-loop.15)
                    (set! r15 tmp-ra.121)
                    (jump
                     L.vector-init-loop.15.9
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.vector?.66.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.122 r15)
        (begin
          (set! c.69 rdi)
          (set! tmp.57 rsi)
          (begin
            (if (begin (set! tmp.100 (bitwise-and tmp.57 7)) (= tmp.100 3))
              (begin (set! rax 14) (jump tmp-ra.122 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.122 rbp rax)))))))
    (define L.boolean?.67.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.123 r15)
        (begin
          (set! c.68 rdi)
          (set! tmp.51 rsi)
          (begin
            (if (begin (set! tmp.101 (bitwise-and tmp.51 247)) (= tmp.101 6))
              (begin (set! rax 14) (jump tmp-ra.123 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.123 rbp rax)))))))
    (begin
      (set! tmp-ra.124 r15)
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
            (begin
              (return-point L.rp.17
                (begin
                  (set! rdi fun/ascii-char8761.5)
                  (set! r15 L.rp.17)
                  (jump L.fun/ascii-char8761.5.13 rbp r15 rdi)))
              (set! ascii-char0.12 rax))
            (begin
              (begin
                (return-point L.rp.18
                  (begin
                    (set! rdi fun/any8762.6)
                    (set! r15 L.rp.18)
                    (jump L.fun/any8762.6.14 rbp r15 rdi)))
                (set! tmp.112 rax))
              (begin
                (return-point L.rp.19
                  (begin
                    (set! rsi tmp.112)
                    (set! rdi vector?.66)
                    (set! r15 L.rp.19)
                    (jump L.vector?.66.8 rbp r15 rdi rsi)))
                (set! boolean1.11 rax)))
            (begin
              (return-point L.rp.20
                (begin
                  (set! rdi fun/void8763.7)
                  (set! r15 L.rp.20)
                  (jump L.fun/void8763.7.15 rbp r15 rdi)))
              (set! void2.10 rax))
            (begin
              (begin
                (return-point L.rp.21
                  (begin
                    (set! rdi fun/any8764.8)
                    (set! r15 L.rp.21)
                    (jump L.fun/any8764.8.16 rbp r15 rdi)))
                (set! tmp.113 rax))
              (begin
                (return-point L.rp.22
                  (begin
                    (set! rsi tmp.113)
                    (set! rdi boolean?.67)
                    (set! r15 L.rp.22)
                    (jump L.boolean?.67.7 rbp r15 rdi rsi)))
                (set! boolean3.9 rax)))
            (begin
              (set! rdi fun/vector8765.4)
              (set! r15 tmp-ra.124)
              (jump L.fun/vector8765.4.12 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () () ())))
    (define L.lam.110.27
      ((new-frames ()))
      (begin
        (set! tmp-ra.220 r15)
        (begin
          (set! c.131 rdi)
          (begin (begin (set! rax 22574) (jump tmp-ra.220 rbp rax))))))
    (define L.fun/pair8798.16.26
      ((new-frames ()))
      (begin
        (set! tmp-ra.221 r15)
        (begin
          (set! c.130 rdi)
          (begin
            (set! cons.105 (mref c.130 14))
            (begin
              (set! rdx 2216)
              (set! rsi 192)
              (set! rdi cons.105)
              (set! r15 tmp-ra.221)
              (jump L.cons.105.13 rbp r15 rdi rsi rdx))))))
    (define L.fun/ascii-char8794.15.25
      ((new-frames ()))
      (begin
        (set! tmp-ra.222 r15)
        (begin
          (set! c.129 rdi)
          (set! oprand0.40 rsi)
          (set! oprand1.39 rdx)
          (set! oprand2.38 rcx)
          (begin
            (set! fun/ascii-char8795.12 (mref c.129 14))
            (begin
              (set! rdi fun/ascii-char8795.12)
              (set! r15 tmp-ra.222)
              (jump L.fun/ascii-char8795.12.22 rbp r15 rdi))))))
    (define L.fun/error8800.14.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.223 r15)
        (begin
          (set! c.128 rdi)
          (set! oprand0.37 rsi)
          (set! oprand1.36 rdx)
          (set! oprand2.35 rcx)
          (begin (begin (set! rax oprand2.35) (jump tmp-ra.223 rbp rax))))))
    (define L.fun/fixnum8792.13.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.224 r15)
        (begin
          (set! c.127 rdi)
          (begin (begin (set! rax 1480) (jump tmp-ra.224 rbp rax))))))
    (define L.fun/ascii-char8795.12.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.225 r15)
        (begin
          (set! c.126 rdi)
          (begin (begin (set! rax 19246) (jump tmp-ra.225 rbp rax))))))
    (define L.fun/fixnum8796.11.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.226 r15)
        (begin
          (set! c.125 rdi)
          (set! oprand0.34 rsi)
          (set! oprand1.33 rdx)
          (set! oprand2.32 rcx)
          (begin (begin (set! rax 2032) (jump tmp-ra.226 rbp rax))))))
    (define L.fun/pair8790.10.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.227 r15)
        (begin
          (set! c.124 rdi)
          (begin
            (set! cons.105 (mref c.124 14))
            (begin
              (set! rdx 3880)
              (set! rsi 200)
              (set! rdi cons.105)
              (set! r15 tmp-ra.227)
              (jump L.cons.105.13 rbp r15 rdi rsi rdx))))))
    (define L.fun/empty8793.9.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.228 r15)
        (begin
          (set! c.123 rdi)
          (set! oprand0.31 rsi)
          (set! oprand1.30 rdx)
          (set! oprand2.29 rcx)
          (begin (begin (set! rax 22) (jump tmp-ra.228 rbp rax))))))
    (define L.fun/pair8788.8.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.229 r15)
        (begin
          (set! c.122 rdi)
          (set! oprand0.28 rsi)
          (set! oprand1.27 rdx)
          (set! oprand2.26 rcx)
          (begin
            (set! fun/pair8789.7 (mref c.122 14))
            (begin
              (set! rdi fun/pair8789.7)
              (set! r15 tmp-ra.229)
              (jump L.fun/pair8789.7.17 rbp r15 rdi))))))
    (define L.fun/pair8789.7.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.230 r15)
        (begin
          (set! c.121 rdi)
          (begin
            (set! fun/pair8790.10 (mref c.121 14))
            (begin
              (set! rdi fun/pair8790.10)
              (set! r15 tmp-ra.230)
              (jump L.fun/pair8790.10.20 rbp r15 rdi))))))
    (define L.fun/error8799.6.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.231 r15)
        (begin
          (set! c.120 rdi)
          (set! oprand0.25 rsi)
          (set! oprand1.24 rdx)
          (set! oprand2.23 rcx)
          (begin (begin (set! rax 40510) (jump tmp-ra.231 rbp rax))))))
    (define L.fun/pair8797.5.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.232 r15)
        (begin
          (set! c.119 rdi)
          (set! oprand0.22 rsi)
          (set! oprand1.21 rdx)
          (set! oprand2.20 rcx)
          (begin
            (set! fun/pair8798.16 (mref c.119 14))
            (begin
              (set! rdi fun/pair8798.16)
              (set! r15 tmp-ra.232)
              (jump L.fun/pair8798.16.26 rbp r15 rdi))))))
    (define L.fun/fixnum8791.4.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.233 r15)
        (begin
          (set! c.118 rdi)
          (set! oprand0.19 rsi)
          (set! oprand1.18 rdx)
          (set! oprand2.17 rcx)
          (begin
            (set! fun/fixnum8792.13 (mref c.118 14))
            (begin
              (set! rdi fun/fixnum8792.13)
              (set! r15 tmp-ra.233)
              (jump L.fun/fixnum8792.13.23 rbp r15 rdi))))))
    (define L.cons.105.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.234 r15)
        (begin
          (set! c.117 rdi)
          (set! tmp.100 rsi)
          (set! tmp.101 rdx)
          (begin
            (begin
              (begin (set! tmp.155 (alloc 16)) (set! tmp.132 (+ tmp.155 1)))
              (begin
                (mset! tmp.132 -1 tmp.100)
                (mset! tmp.132 7 tmp.101)
                (begin (set! rax tmp.132) (jump tmp-ra.234 rbp rax))))))))
    (define L.make-vector.106.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.235 r15)
        (begin
          (set! c.116 rdi)
          (set! tmp.81 rsi)
          (begin
            (set! make-init-vector.1 (mref c.116 14))
            (if (begin
                  (if (begin
                        (set! tmp.157 (bitwise-and tmp.81 7))
                        (= tmp.157 0))
                    (set! tmp.156 14)
                    (set! tmp.156 6))
                  (!= tmp.156 6))
              (begin
                (set! rsi tmp.81)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.235)
                (jump L.make-init-vector.1.11 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.235 rbp rax)))))))
    (define L.make-init-vector.1.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.236 r15)
        (begin
          (set! c.115 rdi)
          (set! tmp.53 rsi)
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
              (begin
                (set! rcx tmp.54)
                (set! rdx 0)
                (set! rsi tmp.53)
                (set! rdi vector-init-loop.55)
                (set! r15 tmp-ra.236)
                (jump L.vector-init-loop.55.10 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.55.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.237 r15)
        (begin
          (set! c.114 rdi)
          (set! len.56 rsi)
          (set! i.58 rdx)
          (set! vec.57 rcx)
          (begin
            (set! vector-init-loop.55 (mref c.114 14))
            (if (begin
                  (if (= len.56 i.58) (set! tmp.162 14) (set! tmp.162 6))
                  (!= tmp.162 6))
              (begin (set! rax vec.57) (jump tmp-ra.237 rbp rax))
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
                  (begin
                    (set! rcx vec.57)
                    (set! rdx tmp.166)
                    (set! rsi len.56)
                    (set! rdi vector-init-loop.55)
                    (set! r15 tmp-ra.237)
                    (jump
                     L.vector-init-loop.55.10
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.ascii-char?.107.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.238 r15)
        (begin
          (set! c.113 rdi)
          (set! tmp.94 rsi)
          (begin
            (if (begin (set! tmp.167 (bitwise-and tmp.94 255)) (= tmp.167 46))
              (begin (set! rax 14) (jump tmp-ra.238 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.238 rbp rax)))))))
    (define L.>.108.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.239 r15)
        (begin
          (set! c.112 rdi)
          (set! tmp.77 rsi)
          (set! tmp.78 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.169 (bitwise-and tmp.78 7))
                        (= tmp.169 0))
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
                (if (> tmp.77 tmp.78)
                  (begin (set! rax 14) (jump tmp-ra.239 rbp rax))
                  (begin (set! rax 6) (jump tmp-ra.239 rbp rax)))
                (begin (set! rax 1598) (jump tmp-ra.239 rbp rax)))
              (begin (set! rax 1598) (jump tmp-ra.239 rbp rax)))))))
    (define L.*.109.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.240 r15)
        (begin
          (set! c.111 rdi)
          (set! tmp.67 rsi)
          (set! tmp.68 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.173 (bitwise-and tmp.68 7))
                        (= tmp.173 0))
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
                  (begin
                    (set! rax (* tmp.67 tmp.176))
                    (jump tmp-ra.240 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.240 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.240 rbp rax)))))))
    (begin
      (set! tmp-ra.241 r15)
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
                (begin
                  (return-point L.rp.28
                    (begin
                      (set! rcx 2878)
                      (set! rdx 14)
                      (set! rsi 2000)
                      (set! rdi fun/empty8793.9)
                      (set! r15 L.rp.28)
                      (jump L.fun/empty8793.9.19 rbp r15 rdi rsi rdx rcx)))
                  (set! tmp.199 rax))
                (begin
                  (if (!= 6 6) (set! tmp.200 22) (set! tmp.200 22))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.29
                          (begin
                            (set! rsi 64)
                            (set! rdi make-vector.106)
                            (set! r15 L.rp.29)
                            (jump L.make-vector.106.12 rbp r15 rdi rsi)))
                        (set! tmp.202 rax))
                      (begin
                        (return-point L.rp.30
                          (begin
                            (set! rsi tmp.202)
                            (set! rdi ascii-char?.107)
                            (set! r15 L.rp.30)
                            (jump L.ascii-char?.107.9 rbp r15 rdi rsi)))
                        (set! tmp.201 rax)))
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rcx tmp.201)
                          (set! rdx tmp.200)
                          (set! rsi tmp.199)
                          (set! rdi fun/fixnum8791.4)
                          (set! r15 L.rp.31)
                          (jump
                           L.fun/fixnum8791.4.14
                           rbp
                           r15
                           rdi
                           rsi
                           rdx
                           rcx)))
                      (set! tmp.198 rax)))))
              (begin
                (if (!= 14 6) (set! tmp.203 1456) (set! tmp.203 1672))
                (begin
                  (return-point L.rp.32
                    (begin
                      (set! rdx tmp.203)
                      (set! rsi tmp.198)
                      (set! rdi >.108)
                      (set! r15 L.rp.32)
                      (jump L.>.108.8 rbp r15 rdi rsi rdx)))
                  (set! tmp.197 rax))))
            (begin
              (begin
                (begin
                  (begin
                    (set! error0.44 54078)
                    (set! fixnum1.43 1792)
                    (begin
                      (return-point L.rp.33
                        (begin
                          (set! rsi 64)
                          (set! rdi make-vector.106)
                          (set! r15 L.rp.33)
                          (jump L.make-vector.106.12 rbp r15 rdi rsi)))
                      (set! vector2.42 rax))
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
                    (begin
                      (return-point L.rp.34
                        (begin
                          (set! rcx 30)
                          (set! rdx 57406)
                          (set! rsi 1392)
                          (set! rdi fun/fixnum8796.11)
                          (set! r15 L.rp.34)
                          (jump
                           L.fun/fixnum8796.11.21
                           rbp
                           r15
                           rdi
                           rsi
                           rdx
                           rcx)))
                      (set! tmp.208 rax))
                    (begin
                      (return-point L.rp.35
                        (begin
                          (set! rdx tmp.208)
                          (set! rsi tmp.206)
                          (set! rdi *.109)
                          (set! r15 L.rp.35)
                          (jump L.*.109.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.205 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.36
                        (begin
                          (set! rcx 30)
                          (set! rdx 48)
                          (set! rsi 22)
                          (set! rdi fun/error8799.6)
                          (set! r15 L.rp.36)
                          (jump L.fun/error8799.6.16 rbp r15 rdi rsi rdx rcx)))
                      (set! tmp.210 rax))
                    (begin
                      (if (!= 14 6) (set! tmp.211 30) (set! tmp.211 30))
                      (begin
                        (begin
                          (begin
                            (return-point L.rp.37
                              (begin
                                (set! rdx 2856)
                                (set! rsi 344)
                                (set! rdi cons.105)
                                (set! r15 L.rp.37)
                                (jump L.cons.105.13 rbp r15 rdi rsi rdx)))
                            (set! tmp.213 rax))
                          (begin
                            (begin
                              (return-point L.rp.38
                                (begin
                                  (set! rsi 64)
                                  (set! rdi make-vector.106)
                                  (set! r15 L.rp.38)
                                  (jump L.make-vector.106.12 rbp r15 rdi rsi)))
                              (set! tmp.214 rax))
                            (begin
                              (return-point L.rp.39
                                (begin
                                  (set! rcx tmp.214)
                                  (set! rdx tmp.213)
                                  (set! rsi 632)
                                  (set! rdi fun/ascii-char8794.15)
                                  (set! r15 L.rp.39)
                                  (jump
                                   L.fun/ascii-char8794.15.25
                                   rbp
                                   r15
                                   rdi
                                   rsi
                                   rdx
                                   rcx)))
                              (set! tmp.212 rax))))
                        (begin
                          (return-point L.rp.40
                            (begin
                              (set! rcx tmp.212)
                              (set! rdx tmp.211)
                              (set! rsi tmp.210)
                              (set! rdi fun/pair8797.5)
                              (set! r15 L.rp.40)
                              (jump
                               L.fun/pair8797.5.15
                               rbp
                               r15
                               rdi
                               rsi
                               rdx
                               rcx)))
                          (set! tmp.209 rax)))))
                  (begin
                    (if (!= 6 6)
                      (begin
                        (return-point L.rp.41
                          (begin
                            (set! rsi 64)
                            (set! rdi make-vector.106)
                            (set! r15 L.rp.41)
                            (jump L.make-vector.106.12 rbp r15 rdi rsi)))
                        (set! tmp.215 rax))
                      (begin
                        (return-point L.rp.42
                          (begin
                            (set! rsi 64)
                            (set! rdi make-vector.106)
                            (set! r15 L.rp.42)
                            (jump L.make-vector.106.12 rbp r15 rdi rsi)))
                        (set! tmp.215 rax)))
                    (begin
                      (return-point L.rp.43
                        (begin
                          (set! rcx tmp.215)
                          (set! rdx tmp.209)
                          (set! rsi tmp.205)
                          (set! rdi fun/ascii-char8794.15)
                          (set! r15 L.rp.43)
                          (jump
                           L.fun/ascii-char8794.15.25
                           rbp
                           r15
                           rdi
                           rsi
                           rdx
                           rcx)))
                      (set! tmp.204 rax)))))
              (begin
                (begin
                  (if (!= 14 6)
                    (begin
                      (return-point L.rp.44
                        (begin
                          (set! rsi 64)
                          (set! rdi make-vector.106)
                          (set! r15 L.rp.44)
                          (jump L.make-vector.106.12 rbp r15 rdi rsi)))
                      (set! tmp.217 rax))
                    (begin
                      (return-point L.rp.45
                        (begin
                          (set! rsi 64)
                          (set! rdi make-vector.106)
                          (set! r15 L.rp.45)
                          (jump L.make-vector.106.12 rbp r15 rdi rsi)))
                      (set! tmp.217 rax)))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.46
                          (begin
                            (set! rsi 64)
                            (set! rdi make-vector.106)
                            (set! r15 L.rp.46)
                            (jump L.make-vector.106.12 rbp r15 rdi rsi)))
                        (set! vector0.48 rax))
                      (begin
                        (return-point L.rp.47
                          (begin
                            (set! rsi 64)
                            (set! rdi make-vector.106)
                            (set! r15 L.rp.47)
                            (jump L.make-vector.106.12 rbp r15 rdi rsi)))
                        (set! vector1.47 rax))
                      (set! ascii-char2.46 23854)
                      (begin
                        (return-point L.rp.48
                          (begin
                            (set! rsi 64)
                            (set! rdi make-vector.106)
                            (set! r15 L.rp.48)
                            (jump L.make-vector.106.12 rbp r15 rdi rsi)))
                        (set! vector3.45 rax))
                      (set! tmp.218 30))
                    (begin
                      (begin
                        (set! boolean0.52 14)
                        (set! void1.51 30)
                        (set! boolean2.50 6)
                        (set! boolean3.49 6)
                        (set! tmp.219 56382))
                      (begin
                        (return-point L.rp.49
                          (begin
                            (set! rcx tmp.219)
                            (set! rdx tmp.218)
                            (set! rsi tmp.217)
                            (set! rdi fun/error8800.14)
                            (set! r15 L.rp.49)
                            (jump
                             L.fun/error8800.14.24
                             rbp
                             r15
                             rdi
                             rsi
                             rdx
                             rcx)))
                        (set! tmp.216 rax)))))
                (begin
                  (set! rcx tmp.216)
                  (set! rdx tmp.204)
                  (set! rsi tmp.197)
                  (set! rdi fun/pair8788.8)
                  (set! r15 tmp-ra.241)
                  (jump L.fun/pair8788.8.18 rbp r15 rdi rsi rdx rcx))))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () ())))
    (define L.fun/void8928.15.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.109 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.109 rbp rax))))))
    (define L.fun/error8924.14.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.110 r15)
        (begin
          (set! c.83 rdi)
          (begin (begin (set! rax 33342) (jump tmp-ra.110 rbp rax))))))
    (define L.fun/ascii-char8925.13.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.111 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/ascii-char8926.5 (mref c.82 14))
            (begin
              (set! rdi fun/ascii-char8926.5)
              (set! r15 tmp-ra.111)
              (jump L.fun/ascii-char8926.5.8 rbp r15 rdi))))))
    (define L.fun/error8920.12.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.112 r15)
        (begin
          (set! c.81 rdi)
          (begin (begin (set! rax 47422) (jump tmp-ra.112 rbp rax))))))
    (define L.fun/empty8930.11.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.113 r15)
        (begin
          (set! c.80 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.113 rbp rax))))))
    (define L.fun/ascii-char8922.10.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.114 r15)
        (begin
          (set! c.79 rdi)
          (begin (begin (set! rax 27438) (jump tmp-ra.114 rbp rax))))))
    (define L.fun/error8919.9.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.115 r15)
        (begin
          (set! c.78 rdi)
          (begin
            (set! fun/error8920.12 (mref c.78 14))
            (begin
              (set! rdi fun/error8920.12)
              (set! r15 tmp-ra.115)
              (jump L.fun/error8920.12.15 rbp r15 rdi))))))
    (define L.fun/ascii-char8921.8.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.116 r15)
        (begin
          (set! c.77 rdi)
          (begin
            (set! fun/ascii-char8922.10 (mref c.77 14))
            (begin
              (set! rdi fun/ascii-char8922.10)
              (set! r15 tmp-ra.116)
              (jump L.fun/ascii-char8922.10.13 rbp r15 rdi))))))
    (define L.fun/void8927.7.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.117 r15)
        (begin
          (set! c.76 rdi)
          (begin
            (set! fun/void8928.15 (mref c.76 14))
            (begin
              (set! rdi fun/void8928.15)
              (set! r15 tmp-ra.117)
              (jump L.fun/void8928.15.18 rbp r15 rdi))))))
    (define L.fun/empty8929.6.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.118 r15)
        (begin
          (set! c.75 rdi)
          (begin
            (set! fun/empty8930.11 (mref c.75 14))
            (begin
              (set! rdi fun/empty8930.11)
              (set! r15 tmp-ra.118)
              (jump L.fun/empty8930.11.14 rbp r15 rdi))))))
    (define L.fun/ascii-char8926.5.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.119 r15)
        (begin
          (set! c.74 rdi)
          (begin (begin (set! rax 30766) (jump tmp-ra.119 rbp rax))))))
    (define L.fun/error8923.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.120 r15)
        (begin
          (set! c.73 rdi)
          (begin
            (set! fun/error8924.14 (mref c.73 14))
            (begin
              (set! rdi fun/error8924.14)
              (set! r15 tmp-ra.120)
              (jump L.fun/error8924.14.17 rbp r15 rdi))))))
    (begin
      (set! tmp-ra.121 r15)
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
            (begin
              (return-point L.rp.19
                (begin
                  (set! rdi fun/error8919.9)
                  (set! r15 L.rp.19)
                  (jump L.fun/error8919.9.12 rbp r15 rdi)))
              (set! error0.20 rax))
            (begin
              (return-point L.rp.20
                (begin
                  (set! rdi fun/ascii-char8921.8)
                  (set! r15 L.rp.20)
                  (jump L.fun/ascii-char8921.8.11 rbp r15 rdi)))
              (set! ascii-char1.19 rax))
            (begin
              (return-point L.rp.21
                (begin
                  (set! rdi fun/error8923.4)
                  (set! r15 L.rp.21)
                  (jump L.fun/error8923.4.7 rbp r15 rdi)))
              (set! error2.18 rax))
            (begin
              (return-point L.rp.22
                (begin
                  (set! rdi fun/ascii-char8925.13)
                  (set! r15 L.rp.22)
                  (jump L.fun/ascii-char8925.13.16 rbp r15 rdi)))
              (set! ascii-char3.17 rax))
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/void8927.7)
                  (set! r15 L.rp.23)
                  (jump L.fun/void8927.7.10 rbp r15 rdi)))
              (set! void4.16 rax))
            (begin
              (set! rdi fun/empty8929.6)
              (set! r15 tmp-ra.121)
              (jump L.fun/empty8929.6.9 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () ())))
    (define L.lam.72.18
      ((new-frames (() () () () () ())))
      (begin
        (set! tmp-ra.148 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! |-.67| (mref c.84 14))
            (set! |+.69| (mref c.84 22))
            (set! <=.70 (mref c.84 30))
            (begin
              (begin
                (begin
                  (return-point L.rp.19
                    (begin
                      (set! rdx 912)
                      (set! rsi 808)
                      (set! rdi |+.69|)
                      (set! r15 L.rp.19)
                      (jump L.+.69.9 rbp r15 rdi rsi rdx)))
                  (set! tmp.98 rax))
                (begin
                  (begin
                    (return-point L.rp.20
                      (begin
                        (set! rdx 432)
                        (set! rsi 704)
                        (set! rdi |+.69|)
                        (set! r15 L.rp.20)
                        (jump L.+.69.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.99 rax))
                  (begin
                    (return-point L.rp.21
                      (begin
                        (set! rdx tmp.99)
                        (set! rsi tmp.98)
                        (set! rdi |+.69|)
                        (set! r15 L.rp.21)
                        (jump L.+.69.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.97 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.22
                      (begin
                        (set! rdx 16)
                        (set! rsi 472)
                        (set! rdi |+.69|)
                        (set! r15 L.rp.22)
                        (jump L.+.69.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.101 rax))
                  (begin
                    (begin
                      (return-point L.rp.23
                        (begin
                          (set! rdx 608)
                          (set! rsi 376)
                          (set! rdi |-.67|)
                          (set! r15 L.rp.23)
                          (jump L.-.67.11 rbp r15 rdi rsi rdx)))
                      (set! tmp.102 rax))
                    (begin
                      (return-point L.rp.24
                        (begin
                          (set! rdx tmp.102)
                          (set! rsi tmp.101)
                          (set! rdi |+.69|)
                          (set! r15 L.rp.24)
                          (jump L.+.69.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.100 rax))))
                (begin
                  (set! rdx tmp.100)
                  (set! rsi tmp.97)
                  (set! rdi <=.70)
                  (set! r15 tmp-ra.148)
                  (jump L.<=.70.8 rbp r15 rdi rsi rdx))))))))
    (define L.fun/void9118.9.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.149 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/void9119.7 (mref c.83 14))
            (begin
              (set! rdi fun/void9119.7)
              (set! r15 tmp-ra.149)
              (jump L.fun/void9119.7.15 rbp r15 rdi))))))
    (define L.fun/ascii-char9122.8.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.150 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/ascii-char9123.5 (mref c.82 14))
            (begin
              (set! rdi fun/ascii-char9123.5)
              (set! r15 tmp-ra.150)
              (jump L.fun/ascii-char9123.5.13 rbp r15 rdi))))))
    (define L.fun/void9119.7.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.151 r15)
        (begin
          (set! c.81 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.151 rbp rax))))))
    (define L.fun/empty9120.6.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.152 r15)
        (begin
          (set! c.80 rdi)
          (begin
            (set! fun/empty9121.4 (mref c.80 14))
            (begin
              (set! rdi fun/empty9121.4)
              (set! r15 tmp-ra.152)
              (jump L.fun/empty9121.4.12 rbp r15 rdi))))))
    (define L.fun/ascii-char9123.5.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.153 r15)
        (begin
          (set! c.79 rdi)
          (begin (begin (set! rax 29486) (jump tmp-ra.153 rbp rax))))))
    (define L.fun/empty9121.4.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.154 r15)
        (begin
          (set! c.78 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.154 rbp rax))))))
    (define L.-.67.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.155 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.33 rsi)
          (set! tmp.34 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.104 (bitwise-and tmp.34 7))
                        (= tmp.104 0))
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
                (begin (set! rax (- tmp.33 tmp.34)) (jump tmp-ra.155 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.155 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.155 rbp rax)))))))
    (define L.*.68.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.76 rdi)
          (set! tmp.29 rsi)
          (set! tmp.30 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.108 (bitwise-and tmp.30 7))
                        (= tmp.108 0))
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
                  (begin
                    (set! rax (* tmp.29 tmp.111))
                    (jump tmp-ra.156 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.156 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.156 rbp rax)))))))
    (define L.+.69.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.157 r15)
        (begin
          (set! c.75 rdi)
          (set! tmp.31 rsi)
          (set! tmp.32 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.113 (bitwise-and tmp.32 7))
                        (= tmp.113 0))
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
                (begin (set! rax (+ tmp.31 tmp.32)) (jump tmp-ra.157 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.157 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.157 rbp rax)))))))
    (define L.<=.70.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.74 rdi)
          (set! tmp.37 rsi)
          (set! tmp.38 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.117 (bitwise-and tmp.38 7))
                        (= tmp.117 0))
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
                (if (<= tmp.37 tmp.38)
                  (begin (set! rax 14) (jump tmp-ra.158 rbp rax))
                  (begin (set! rax 6) (jump tmp-ra.158 rbp rax)))
                (begin (set! rax 1342) (jump tmp-ra.158 rbp rax)))
              (begin (set! rax 1342) (jump tmp-ra.158 rbp rax)))))))
    (define L.>=.71.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.73 rdi)
          (set! tmp.41 rsi)
          (set! tmp.42 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.121 (bitwise-and tmp.42 7))
                        (= tmp.121 0))
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
                (if (>= tmp.41 tmp.42)
                  (begin (set! rax 14) (jump tmp-ra.159 rbp rax))
                  (begin (set! rax 6) (jump tmp-ra.159 rbp rax)))
                (begin (set! rax 1854) (jump tmp-ra.159 rbp rax)))
              (begin (set! rax 1854) (jump tmp-ra.159 rbp rax)))))))
    (begin
      (set! tmp-ra.160 r15)
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
            (begin
              (return-point L.rp.25
                (begin
                  (set! rdi fun/void9118.9)
                  (set! r15 L.rp.25)
                  (jump L.fun/void9118.9.17 rbp r15 rdi)))
              (set! void0.14 rax))
            (begin
              (begin
                (begin
                  (return-point L.rp.26
                    (begin
                      (set! rdx 1808)
                      (set! rsi 200)
                      (set! rdi |-.67|)
                      (set! r15 L.rp.26)
                      (jump L.-.67.11 rbp r15 rdi rsi rdx)))
                  (set! tmp.136 rax))
                (begin
                  (begin
                    (return-point L.rp.27
                      (begin
                        (set! rdx 448)
                        (set! rsi 1272)
                        (set! rdi |-.67|)
                        (set! r15 L.rp.27)
                        (jump L.-.67.11 rbp r15 rdi rsi rdx)))
                    (set! tmp.137 rax))
                  (begin
                    (return-point L.rp.28
                      (begin
                        (set! rdx tmp.137)
                        (set! rsi tmp.136)
                        (set! rdi *.68)
                        (set! r15 L.rp.28)
                        (jump L.*.68.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.135 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.29
                      (begin
                        (set! rdx 976)
                        (set! rsi 1536)
                        (set! rdi *.68)
                        (set! r15 L.rp.29)
                        (jump L.*.68.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.139 rax))
                  (begin
                    (begin
                      (return-point L.rp.30
                        (begin
                          (set! rdx 688)
                          (set! rsi 376)
                          (set! rdi |-.67|)
                          (set! r15 L.rp.30)
                          (jump L.-.67.11 rbp r15 rdi rsi rdx)))
                      (set! tmp.140 rax))
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx tmp.140)
                          (set! rsi tmp.139)
                          (set! rdi |-.67|)
                          (set! r15 L.rp.31)
                          (jump L.-.67.11 rbp r15 rdi rsi rdx)))
                      (set! tmp.138 rax))))
                (begin
                  (return-point L.rp.32
                    (begin
                      (set! rdx tmp.138)
                      (set! rsi tmp.135)
                      (set! rdi *.68)
                      (set! r15 L.rp.32)
                      (jump L.*.68.10 rbp r15 rdi rsi rdx)))
                  (set! fixnum1.13 rax))))
            (begin
              (return-point L.rp.33
                (begin
                  (set! rdi fun/empty9120.6)
                  (set! r15 L.rp.33)
                  (jump L.fun/empty9120.6.14 rbp r15 rdi)))
              (set! empty2.12 rax))
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
            (begin
              (return-point L.rp.34
                (begin
                  (set! rdi fun/ascii-char9122.8)
                  (set! r15 L.rp.34)
                  (jump L.fun/ascii-char9122.8.16 rbp r15 rdi)))
              (set! ascii-char4.10 rax))
            (begin
              (begin
                (begin
                  (return-point L.rp.35
                    (begin
                      (set! rdx 1336)
                      (set! rsi 544)
                      (set! rdi |+.69|)
                      (set! r15 L.rp.35)
                      (jump L.+.69.9 rbp r15 rdi rsi rdx)))
                  (set! tmp.143 rax))
                (begin
                  (begin
                    (return-point L.rp.36
                      (begin
                        (set! rdx 1256)
                        (set! rsi 1336)
                        (set! rdi |+.69|)
                        (set! r15 L.rp.36)
                        (jump L.+.69.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.144 rax))
                  (begin
                    (return-point L.rp.37
                      (begin
                        (set! rdx tmp.144)
                        (set! rsi tmp.143)
                        (set! rdi |-.67|)
                        (set! r15 L.rp.37)
                        (jump L.-.67.11 rbp r15 rdi rsi rdx)))
                    (set! tmp.142 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.38
                      (begin
                        (set! rdx 1240)
                        (set! rsi 240)
                        (set! rdi |-.67|)
                        (set! r15 L.rp.38)
                        (jump L.-.67.11 rbp r15 rdi rsi rdx)))
                    (set! tmp.146 rax))
                  (begin
                    (begin
                      (return-point L.rp.39
                        (begin
                          (set! rdx 808)
                          (set! rsi 224)
                          (set! rdi |+.69|)
                          (set! r15 L.rp.39)
                          (jump L.+.69.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.147 rax))
                    (begin
                      (return-point L.rp.40
                        (begin
                          (set! rdx tmp.147)
                          (set! rsi tmp.146)
                          (set! rdi |-.67|)
                          (set! r15 L.rp.40)
                          (jump L.-.67.11 rbp r15 rdi rsi rdx)))
                      (set! tmp.145 rax))))
                (begin
                  (set! rdx tmp.145)
                  (set! rsi tmp.142)
                  (set! rdi >=.71)
                  (set! r15 tmp-ra.160)
                  (jump L.>=.71.7 rbp r15 rdi rsi rdx))))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () ())))
    (define L.lam.80.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.97 rdi)
          (begin
            (set! fun/ascii-char9132.7 (mref c.97 14))
            (begin
              (set! rdi fun/ascii-char9132.7)
              (set! r15 tmp-ra.156)
              (jump L.fun/ascii-char9132.7.15 rbp r15 rdi))))))
    (define L.lam.79.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.157 r15)
        (begin
          (set! c.96 rdi)
          (begin
            (set! fun/void9126.12 (mref c.96 14))
            (begin
              (set! rdi fun/void9126.12)
              (set! r15 tmp-ra.157)
              (jump L.fun/void9126.12.20 rbp r15 rdi))))))
    (define L.fun/ascii-char9135.13.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.95 rdi)
          (begin (begin (set! rax 29998) (jump tmp-ra.158 rbp rax))))))
    (define L.fun/void9126.12.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.94 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.159 rbp rax))))))
    (define L.fun/vector9134.11.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.93 rdi)
          (begin
            (set! make-vector.76 (mref c.93 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.76)
              (set! r15 tmp-ra.160)
              (jump L.make-vector.76.11 rbp r15 rdi rsi))))))
    (define L.fun/ascii-char9129.10.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.92 rdi)
          (begin (begin (set! rax 20526) (jump tmp-ra.161 rbp rax))))))
    (define L.fun/vector9133.9.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! make-vector.76 (mref c.91 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.76)
              (set! r15 tmp-ra.162)
              (jump L.make-vector.76.11 rbp r15 rdi rsi))))))
    (define L.fun/ascii-char9130.8.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.90 rdi)
          (begin (begin (set! rax 28718) (jump tmp-ra.163 rbp rax))))))
    (define L.fun/ascii-char9132.7.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.164 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 28718) (jump tmp-ra.164 rbp rax))))))
    (define L.fun/empty9128.6.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.165 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.165 rbp rax))))))
    (define L.fun/ascii-char9131.5.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.166 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 28462) (jump tmp-ra.166 rbp rax))))))
    (define L.fun/error9127.4.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.167 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 42814) (jump tmp-ra.167 rbp rax))))))
    (define L.make-vector.76.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.168 r15)
        (begin
          (set! c.85 rdi)
          (set! tmp.52 rsi)
          (begin
            (set! make-init-vector.1 (mref c.85 14))
            (if (begin
                  (if (begin
                        (set! tmp.117 (bitwise-and tmp.52 7))
                        (= tmp.117 0))
                    (set! tmp.116 14)
                    (set! tmp.116 6))
                  (!= tmp.116 6))
              (begin
                (set! rsi tmp.52)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.168)
                (jump L.make-init-vector.1.10 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.168 rbp rax)))))))
    (define L.make-init-vector.1.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.169 r15)
        (begin
          (set! c.84 rdi)
          (set! tmp.24 rsi)
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
              (begin
                (set! rcx tmp.25)
                (set! rdx 0)
                (set! rsi tmp.24)
                (set! rdi vector-init-loop.26)
                (set! r15 tmp-ra.169)
                (jump L.vector-init-loop.26.9 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.26.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.170 r15)
        (begin
          (set! c.83 rdi)
          (set! len.27 rsi)
          (set! i.29 rdx)
          (set! vec.28 rcx)
          (begin
            (set! vector-init-loop.26 (mref c.83 14))
            (if (begin
                  (if (= len.27 i.29) (set! tmp.122 14) (set! tmp.122 6))
                  (!= tmp.122 6))
              (begin (set! rax vec.28) (jump tmp-ra.170 rbp rax))
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
                  (begin
                    (set! rcx vec.28)
                    (set! rdx tmp.126)
                    (set! rsi len.27)
                    (set! rdi vector-init-loop.26)
                    (set! r15 tmp-ra.170)
                    (jump
                     L.vector-init-loop.26.9
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.vector?.77.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.171 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.68 rsi)
          (begin
            (if (begin (set! tmp.127 (bitwise-and tmp.68 7)) (= tmp.127 3))
              (begin (set! rax 14) (jump tmp-ra.171 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.171 rbp rax)))))))
    (define L.<=.78.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.172 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.46 rsi)
          (set! tmp.47 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.129 (bitwise-and tmp.47 7))
                        (= tmp.129 0))
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
                (if (<= tmp.46 tmp.47)
                  (begin (set! rax 14) (jump tmp-ra.172 rbp rax))
                  (begin (set! rax 6) (jump tmp-ra.172 rbp rax)))
                (begin (set! rax 1342) (jump tmp-ra.172 rbp rax)))
              (begin (set! rax 1342) (jump tmp-ra.172 rbp rax)))))))
    (begin
      (set! tmp-ra.173 r15)
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
                  (begin
                    (return-point L.rp.24
                      (begin
                        (set! rsi tmp.148)
                        (set! rdi vector?.77)
                        (set! r15 L.rp.24)
                        (jump L.vector?.77.8 rbp r15 rdi rsi)))
                    (set! tmp.147 rax)))
                (!= tmp.147 6))
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.149 (alloc 24))
                    (set! tmp.114 (+ tmp.149 2)))
                  (begin
                    (mset! tmp.114 -2 L.lam.79.22)
                    (mset! tmp.114 6 0)
                    (set! lam.79 tmp.114)))
                (begin
                  (mset! lam.79 14 fun/void9126.12)
                  (set! procedure0.18 lam.79)))
              (begin
                (return-point L.rp.25
                  (begin
                    (set! rdi fun/error9127.4)
                    (set! r15 L.rp.25)
                    (jump L.fun/error9127.4.12 rbp r15 rdi)))
                (set! error1.17 rax))
              (begin
                (return-point L.rp.26
                  (begin
                    (set! rdi fun/empty9128.6)
                    (set! r15 L.rp.26)
                    (jump L.fun/empty9128.6.14 rbp r15 rdi)))
                (set! empty2.16 rax))
              (begin
                (return-point L.rp.27
                  (begin
                    (set! rdi fun/ascii-char9129.10)
                    (set! r15 L.rp.27)
                    (jump L.fun/ascii-char9129.10.18 rbp r15 rdi)))
                (set! ascii-char3.15 rax))
              (begin
                (return-point L.rp.28
                  (begin
                    (set! rdi fun/ascii-char9130.8)
                    (set! r15 L.rp.28)
                    (jump L.fun/ascii-char9130.8.16 rbp r15 rdi)))
                (set! ascii-char4.14 rax))
              (begin
                (set! rdi fun/ascii-char9131.5)
                (set! r15 tmp-ra.173)
                (jump L.fun/ascii-char9131.5.13 rbp r15 rdi)))
            (begin
              (begin
                (begin
                  (begin
                    (set! tmp.150 (alloc 24))
                    (set! tmp.115 (+ tmp.150 2)))
                  (begin
                    (mset! tmp.115 -2 L.lam.80.23)
                    (mset! tmp.115 6 0)
                    (set! lam.80 tmp.115)))
                (begin
                  (mset! lam.80 14 fun/ascii-char9132.7)
                  (set! procedure0.23 lam.80)))
              (begin
                (return-point L.rp.29
                  (begin
                    (set! rdi fun/vector9133.9)
                    (set! r15 L.rp.29)
                    (jump L.fun/vector9133.9.17 rbp r15 rdi)))
                (set! vector1.22 rax))
              (begin
                (return-point L.rp.30
                  (begin
                    (set! rdi fun/vector9134.11)
                    (set! r15 L.rp.30)
                    (jump L.fun/vector9134.11.19 rbp r15 rdi)))
                (set! vector2.21 rax))
              (begin
                (return-point L.rp.31
                  (begin
                    (set! rdi fun/ascii-char9135.13)
                    (set! r15 L.rp.31)
                    (jump L.fun/ascii-char9135.13.21 rbp r15 rdi)))
                (set! ascii-char3.20 rax))
              (begin
                (return-point L.rp.32
                  (begin
                    (set! rdx 1256)
                    (set! rsi 336)
                    (set! rdi <=.78)
                    (set! r15 L.rp.32)
                    (jump L.<=.78.7 rbp r15 rdi rsi rdx)))
                (set! boolean4.19 rax))
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
                    (begin
                      (set! rdi procedure0.23)
                      (set! r15 tmp-ra.173)
                      (jump tmp.155 rbp r15 rdi)))
                  (begin (set! rax 10814) (jump tmp-ra.173 rbp rax)))
                (begin (set! rax 11070) (jump tmp-ra.173 rbp rax))))))))))
(check-by-interp
 '(module
    ((new-frames (() () () ())))
    (define L.lam.73.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.113 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! fun/error9191.12 (mref c.86 14))
            (begin
              (set! rdi fun/error9191.12)
              (set! r15 tmp-ra.113)
              (jump L.fun/error9191.12.15 rbp r15 rdi))))))
    (define L.fun/void9201.15.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.114 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/void9202.11 (mref c.85 14))
            (begin
              (set! rdi fun/void9202.11)
              (set! r15 tmp-ra.114)
              (jump L.fun/void9202.11.14 rbp r15 rdi))))))
    (define L.fun/error9192.14.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.115 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 54590) (jump tmp-ra.115 rbp rax))))))
    (define L.fun/error9196.13.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.116 r15)
        (begin
          (set! c.83 rdi)
          (begin (begin (set! rax 50750) (jump tmp-ra.116 rbp rax))))))
    (define L.fun/error9191.12.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.117 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/error9192.14 (mref c.82 14))
            (begin
              (set! rdi fun/error9192.14)
              (set! r15 tmp-ra.117)
              (jump L.fun/error9192.14.17 rbp r15 rdi))))))
    (define L.fun/void9202.11.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.118 r15)
        (begin
          (set! c.81 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.118 rbp rax))))))
    (define L.fun/empty9200.10.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.119 r15)
        (begin
          (set! c.80 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.119 rbp rax))))))
    (define L.fun/ascii-char9193.9.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.120 r15)
        (begin
          (set! c.79 rdi)
          (begin
            (set! fun/ascii-char9194.4 (mref c.79 14))
            (begin
              (set! rdi fun/ascii-char9194.4)
              (set! r15 tmp-ra.120)
              (jump L.fun/ascii-char9194.4.7 rbp r15 rdi))))))
    (define L.fun/void9198.8.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.121 r15)
        (begin
          (set! c.78 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.121 rbp rax))))))
    (define L.fun/empty9199.7.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.122 r15)
        (begin
          (set! c.77 rdi)
          (begin
            (set! fun/empty9200.10 (mref c.77 14))
            (begin
              (set! rdi fun/empty9200.10)
              (set! r15 tmp-ra.122)
              (jump L.fun/empty9200.10.13 rbp r15 rdi))))))
    (define L.fun/error9195.6.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.123 r15)
        (begin
          (set! c.76 rdi)
          (begin
            (set! fun/error9196.13 (mref c.76 14))
            (begin
              (set! rdi fun/error9196.13)
              (set! r15 tmp-ra.123)
              (jump L.fun/error9196.13.16 rbp r15 rdi))))))
    (define L.fun/void9197.5.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.124 r15)
        (begin
          (set! c.75 rdi)
          (begin
            (set! fun/void9198.8 (mref c.75 14))
            (begin
              (set! rdi fun/void9198.8)
              (set! r15 tmp-ra.124)
              (jump L.fun/void9198.8.11 rbp r15 rdi))))))
    (define L.fun/ascii-char9194.4.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.125 r15)
        (begin
          (set! c.74 rdi)
          (begin (begin (set! rax 26158) (jump tmp-ra.125 rbp rax))))))
    (begin
      (set! tmp-ra.126 r15)
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
            (begin
              (return-point L.rp.20
                (begin
                  (set! rdi fun/ascii-char9193.9)
                  (set! r15 L.rp.20)
                  (jump L.fun/ascii-char9193.9.12 rbp r15 rdi)))
              (set! ascii-char1.19 rax))
            (begin
              (return-point L.rp.21
                (begin
                  (set! rdi fun/error9195.6)
                  (set! r15 L.rp.21)
                  (jump L.fun/error9195.6.9 rbp r15 rdi)))
              (set! error2.18 rax))
            (begin
              (return-point L.rp.22
                (begin
                  (set! rdi fun/void9197.5)
                  (set! r15 L.rp.22)
                  (jump L.fun/void9197.5.8 rbp r15 rdi)))
              (set! void3.17 rax))
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/empty9199.7)
                  (set! r15 L.rp.23)
                  (jump L.fun/empty9199.7.10 rbp r15 rdi)))
              (set! empty4.16 rax))
            (begin
              (set! rdi fun/void9201.15)
              (set! r15 tmp-ra.126)
              (jump L.fun/void9201.15.18 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () ())))
    (define L.lam.75.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.92 rdi)
          (begin
            (set! fun/vector9888.10 (mref c.92 14))
            (begin
              (set! rdi fun/vector9888.10)
              (set! r15 tmp-ra.158)
              (jump L.fun/vector9888.10.19 rbp r15 rdi))))))
    (define L.fun/vector9889.13.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! make-vector.71 (mref c.91 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.71)
              (set! r15 tmp-ra.159)
              (jump L.make-vector.71.12 rbp r15 rdi rsi))))))
    (define L.fun/void9885.12.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.90 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.160 rbp rax))))))
    (define L.fun/ascii-char9886.11.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/ascii-char9887.6 (mref c.89 14))
            (begin
              (set! rdi fun/ascii-char9887.6)
              (set! r15 tmp-ra.161)
              (jump L.fun/ascii-char9887.6.15 rbp r15 rdi))))))
    (define L.fun/vector9888.10.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! fun/vector9889.13 (mref c.88 14))
            (begin
              (set! rdi fun/vector9889.13)
              (set! r15 tmp-ra.162)
              (jump L.fun/vector9889.13.22 rbp r15 rdi))))))
    (define L.fun/void9891.9.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.163 rbp rax))))))
    (define L.fun/void9884.8.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.164 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! fun/void9885.12 (mref c.86 14))
            (begin
              (set! rdi fun/void9885.12)
              (set! r15 tmp-ra.164)
              (jump L.fun/void9885.12.21 rbp r15 rdi))))))
    (define L.fun/ascii-char9892.7.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.165 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/ascii-char9893.4 (mref c.85 14))
            (begin
              (set! rdi fun/ascii-char9893.4)
              (set! r15 tmp-ra.165)
              (jump L.fun/ascii-char9893.4.13 rbp r15 rdi))))))
    (define L.fun/ascii-char9887.6.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.166 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 23854) (jump tmp-ra.166 rbp rax))))))
    (define L.fun/void9890.5.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.167 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/void9891.9 (mref c.83 14))
            (begin
              (set! rdi fun/void9891.9)
              (set! r15 tmp-ra.167)
              (jump L.fun/void9891.9.18 rbp r15 rdi))))))
    (define L.fun/ascii-char9893.4.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.168 r15)
        (begin
          (set! c.82 rdi)
          (begin (begin (set! rax 20782) (jump tmp-ra.168 rbp rax))))))
    (define L.make-vector.71.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.169 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.47 rsi)
          (begin
            (set! make-init-vector.1 (mref c.81 14))
            (if (begin
                  (if (begin
                        (set! tmp.112 (bitwise-and tmp.47 7))
                        (= tmp.112 0))
                    (set! tmp.111 14)
                    (set! tmp.111 6))
                  (!= tmp.111 6))
              (begin
                (set! rsi tmp.47)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.169)
                (jump L.make-init-vector.1.11 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.169 rbp rax)))))))
    (define L.make-init-vector.1.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.170 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.19 rsi)
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
              (begin
                (set! rcx tmp.20)
                (set! rdx 0)
                (set! rsi tmp.19)
                (set! rdi vector-init-loop.21)
                (set! r15 tmp-ra.170)
                (jump L.vector-init-loop.21.10 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.21.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.171 r15)
        (begin
          (set! c.79 rdi)
          (set! len.22 rsi)
          (set! i.24 rdx)
          (set! vec.23 rcx)
          (begin
            (set! vector-init-loop.21 (mref c.79 14))
            (if (begin
                  (if (= len.22 i.24) (set! tmp.117 14) (set! tmp.117 6))
                  (!= tmp.117 6))
              (begin (set! rax vec.23) (jump tmp-ra.171 rbp rax))
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
                  (begin
                    (set! rcx vec.23)
                    (set! rdx tmp.121)
                    (set! rsi len.22)
                    (set! rdi vector-init-loop.21)
                    (set! r15 tmp-ra.171)
                    (jump
                     L.vector-init-loop.21.10
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.+.72.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.172 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.35 rsi)
          (set! tmp.36 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.123 (bitwise-and tmp.36 7))
                        (= tmp.123 0))
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
                (begin (set! rax (+ tmp.35 tmp.36)) (jump tmp-ra.172 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.172 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.172 rbp rax)))))))
    (define L.*.73.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.173 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.33 rsi)
          (set! tmp.34 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.127 (bitwise-and tmp.34 7))
                        (= tmp.127 0))
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
                  (begin
                    (set! rax (* tmp.33 tmp.130))
                    (jump tmp-ra.173 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.173 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.173 rbp rax)))))))
    (define L.-.74.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.174 r15)
        (begin
          (set! c.76 rdi)
          (set! tmp.37 rsi)
          (set! tmp.38 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.132 (bitwise-and tmp.38 7))
                        (= tmp.132 0))
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
                (begin (set! rax (- tmp.37 tmp.38)) (jump tmp-ra.174 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.174 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.174 rbp rax)))))))
    (begin
      (set! tmp-ra.175 r15)
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
            (begin
              (return-point L.rp.24
                (begin
                  (set! rdi fun/void9884.8)
                  (set! r15 L.rp.24)
                  (jump L.fun/void9884.8.17 rbp r15 rdi)))
              (set! void0.18 rax))
            (begin
              (return-point L.rp.25
                (begin
                  (set! rdi fun/ascii-char9886.11)
                  (set! r15 L.rp.25)
                  (jump L.fun/ascii-char9886.11.20 rbp r15 rdi)))
              (set! ascii-char1.17 rax))
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
            (begin
              (return-point L.rp.26
                (begin
                  (set! rdi fun/void9890.5)
                  (set! r15 L.rp.26)
                  (jump L.fun/void9890.5.14 rbp r15 rdi)))
              (set! void3.15 rax))
            (begin
              (begin
                (begin
                  (return-point L.rp.27
                    (begin
                      (set! rdx 192)
                      (set! rsi 1344)
                      (set! rdi |+.72|)
                      (set! r15 L.rp.27)
                      (jump L.+.72.9 rbp r15 rdi rsi rdx)))
                  (set! tmp.153 rax))
                (begin
                  (begin
                    (return-point L.rp.28
                      (begin
                        (set! rdx 992)
                        (set! rsi 1656)
                        (set! rdi *.73)
                        (set! r15 L.rp.28)
                        (jump L.*.73.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.154 rax))
                  (begin
                    (return-point L.rp.29
                      (begin
                        (set! rdx tmp.154)
                        (set! rsi tmp.153)
                        (set! rdi *.73)
                        (set! r15 L.rp.29)
                        (jump L.*.73.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.152 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.30
                      (begin
                        (set! rdx 1992)
                        (set! rsi 1016)
                        (set! rdi *.73)
                        (set! r15 L.rp.30)
                        (jump L.*.73.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.156 rax))
                  (begin
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx 1688)
                          (set! rsi 1568)
                          (set! rdi |-.74|)
                          (set! r15 L.rp.31)
                          (jump L.-.74.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.157 rax))
                    (begin
                      (return-point L.rp.32
                        (begin
                          (set! rdx tmp.157)
                          (set! rsi tmp.156)
                          (set! rdi *.73)
                          (set! r15 L.rp.32)
                          (jump L.*.73.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.155 rax))))
                (begin
                  (return-point L.rp.33
                    (begin
                      (set! rdx tmp.155)
                      (set! rsi tmp.152)
                      (set! rdi *.73)
                      (set! r15 L.rp.33)
                      (jump L.*.73.8 rbp r15 rdi rsi rdx)))
                  (set! fixnum4.14 rax))))
            (begin
              (set! rdi fun/ascii-char9892.7)
              (set! r15 tmp-ra.175)
              (jump L.fun/ascii-char9892.7.16 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () ())))
    (define L.lam.74.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.166 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/void10281.10 (mref c.90 14))
            (begin
              (set! rdi fun/void10281.10)
              (set! r15 tmp-ra.166)
              (jump L.fun/void10281.10.21 rbp r15 rdi))))))
    (define L.fun/void10281.10.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.167 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/void10282.4 (mref c.89 14))
            (begin
              (set! rdi fun/void10282.4)
              (set! r15 tmp-ra.167)
              (jump L.fun/void10282.4.15 rbp r15 rdi))))))
    (define L.fun/any10280.9.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.168 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 6) (jump tmp-ra.168 rbp rax))))))
    (define L.fun/vector10279.8.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.169 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! make-vector.68 (mref c.87 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.68)
              (set! r15 tmp-ra.169)
              (jump L.make-vector.68.14 rbp r15 rdi rsi))))))
    (define L.fun/empty10283.7.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.170 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! fun/empty10284.5 (mref c.86 14))
            (begin
              (set! rdi fun/empty10284.5)
              (set! r15 tmp-ra.170)
              (jump L.fun/empty10284.5.16 rbp r15 rdi))))))
    (define L.fun/vector10278.6.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.171 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/vector10279.8 (mref c.85 14))
            (begin
              (set! rdi fun/vector10279.8)
              (set! r15 tmp-ra.171)
              (jump L.fun/vector10279.8.19 rbp r15 rdi))))))
    (define L.fun/empty10284.5.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.172 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.172 rbp rax))))))
    (define L.fun/void10282.4.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.173 r15)
        (begin
          (set! c.83 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.173 rbp rax))))))
    (define L.make-vector.68.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.174 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.44 rsi)
          (begin
            (set! make-init-vector.1 (mref c.82 14))
            (if (begin
                  (if (begin
                        (set! tmp.109 (bitwise-and tmp.44 7))
                        (= tmp.109 0))
                    (set! tmp.108 14)
                    (set! tmp.108 6))
                  (!= tmp.108 6))
              (begin
                (set! rsi tmp.44)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.174)
                (jump L.make-init-vector.1.13 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.174 rbp rax)))))))
    (define L.make-init-vector.1.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.175 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.16 rsi)
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
              (begin
                (set! rcx tmp.17)
                (set! rdx 0)
                (set! rsi tmp.16)
                (set! rdi vector-init-loop.18)
                (set! r15 tmp-ra.175)
                (jump L.vector-init-loop.18.12 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.18.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.176 r15)
        (begin
          (set! c.80 rdi)
          (set! len.19 rsi)
          (set! i.21 rdx)
          (set! vec.20 rcx)
          (begin
            (set! vector-init-loop.18 (mref c.80 14))
            (if (begin
                  (if (= len.19 i.21) (set! tmp.114 14) (set! tmp.114 6))
                  (!= tmp.114 6))
              (begin (set! rax vec.20) (jump tmp-ra.176 rbp rax))
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
                  (begin
                    (set! rcx vec.20)
                    (set! rdx tmp.118)
                    (set! rsi len.19)
                    (set! rdi vector-init-loop.18)
                    (set! r15 tmp-ra.176)
                    (jump
                     L.vector-init-loop.18.12
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.void?.69.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.177 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.56 rsi)
          (begin
            (if (begin (set! tmp.119 (bitwise-and tmp.56 255)) (= tmp.119 30))
              (begin (set! rax 14) (jump tmp-ra.177 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.177 rbp rax)))))))
    (define L.+.70.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.178 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.32 rsi)
          (set! tmp.33 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.121 (bitwise-and tmp.33 7))
                        (= tmp.121 0))
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
                (begin (set! rax (+ tmp.32 tmp.33)) (jump tmp-ra.178 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.178 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.178 rbp rax)))))))
    (define L.-.71.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.179 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.34 rsi)
          (set! tmp.35 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.125 (bitwise-and tmp.35 7))
                        (= tmp.125 0))
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
                (begin (set! rax (- tmp.34 tmp.35)) (jump tmp-ra.179 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.179 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.179 rbp rax)))))))
    (define L.*.72.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.180 r15)
        (begin
          (set! c.76 rdi)
          (set! tmp.30 rsi)
          (set! tmp.31 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.129 (bitwise-and tmp.31 7))
                        (= tmp.129 0))
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
                  (begin
                    (set! rax (* tmp.30 tmp.132))
                    (jump tmp-ra.180 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.180 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.180 rbp rax)))))))
    (define L.<=.73.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.181 r15)
        (begin
          (set! c.75 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.134 (bitwise-and tmp.39 7))
                        (= tmp.134 0))
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
                (if (<= tmp.38 tmp.39)
                  (begin (set! rax 14) (jump tmp-ra.181 rbp rax))
                  (begin (set! rax 6) (jump tmp-ra.181 rbp rax)))
                (begin (set! rax 1342) (jump tmp-ra.181 rbp rax)))
              (begin (set! rax 1342) (jump tmp-ra.181 rbp rax)))))))
    (begin
      (set! tmp-ra.182 r15)
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
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/vector10278.6)
                  (set! r15 L.rp.23)
                  (jump L.fun/vector10278.6.17 rbp r15 rdi)))
              (set! vector0.15 rax))
            (begin
              (begin
                (return-point L.rp.24
                  (begin
                    (set! rdi fun/any10280.9)
                    (set! r15 L.rp.24)
                    (jump L.fun/any10280.9.20 rbp r15 rdi)))
                (set! tmp.152 rax))
              (begin
                (return-point L.rp.25
                  (begin
                    (set! rsi tmp.152)
                    (set! rdi void?.69)
                    (set! r15 L.rp.25)
                    (jump L.void?.69.11 rbp r15 rdi rsi)))
                (set! boolean1.14 rax)))
            (begin
              (begin
                (begin
                  (return-point L.rp.26
                    (begin
                      (set! rdx 1448)
                      (set! rsi 952)
                      (set! rdi |+.70|)
                      (set! r15 L.rp.26)
                      (jump L.+.70.10 rbp r15 rdi rsi rdx)))
                  (set! tmp.154 rax))
                (begin
                  (begin
                    (return-point L.rp.27
                      (begin
                        (set! rdx 840)
                        (set! rsi 576)
                        (set! rdi |+.70|)
                        (set! r15 L.rp.27)
                        (jump L.+.70.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.155 rax))
                  (begin
                    (return-point L.rp.28
                      (begin
                        (set! rdx tmp.155)
                        (set! rsi tmp.154)
                        (set! rdi |-.71|)
                        (set! r15 L.rp.28)
                        (jump L.-.71.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.153 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.29
                      (begin
                        (set! rdx 1232)
                        (set! rsi 648)
                        (set! rdi |+.70|)
                        (set! r15 L.rp.29)
                        (jump L.+.70.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.157 rax))
                  (begin
                    (begin
                      (return-point L.rp.30
                        (begin
                          (set! rdx 648)
                          (set! rsi 1128)
                          (set! rdi *.72)
                          (set! r15 L.rp.30)
                          (jump L.*.72.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.158 rax))
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx tmp.158)
                          (set! rsi tmp.157)
                          (set! rdi |-.71|)
                          (set! r15 L.rp.31)
                          (jump L.-.71.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.156 rax))))
                (begin
                  (return-point L.rp.32
                    (begin
                      (set! rdx tmp.156)
                      (set! rsi tmp.153)
                      (set! rdi |+.70|)
                      (set! r15 L.rp.32)
                      (jump L.+.70.10 rbp r15 rdi rsi rdx)))
                  (set! fixnum2.13 rax))))
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
                (begin
                  (return-point L.rp.33
                    (begin
                      (set! rdx 1016)
                      (set! rsi 1408)
                      (set! rdi |-.71|)
                      (set! r15 L.rp.33)
                      (jump L.-.71.9 rbp r15 rdi rsi rdx)))
                  (set! tmp.161 rax))
                (begin
                  (begin
                    (return-point L.rp.34
                      (begin
                        (set! rdx 1008)
                        (set! rsi 1488)
                        (set! rdi |+.70|)
                        (set! r15 L.rp.34)
                        (jump L.+.70.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.162 rax))
                  (begin
                    (return-point L.rp.35
                      (begin
                        (set! rdx tmp.162)
                        (set! rsi tmp.161)
                        (set! rdi *.72)
                        (set! r15 L.rp.35)
                        (jump L.*.72.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.160 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.36
                      (begin
                        (set! rdx 2024)
                        (set! rsi 600)
                        (set! rdi *.72)
                        (set! r15 L.rp.36)
                        (jump L.*.72.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.164 rax))
                  (begin
                    (begin
                      (return-point L.rp.37
                        (begin
                          (set! rdx 1656)
                          (set! rsi 1480)
                          (set! rdi |-.71|)
                          (set! r15 L.rp.37)
                          (jump L.-.71.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.165 rax))
                    (begin
                      (return-point L.rp.38
                        (begin
                          (set! rdx tmp.165)
                          (set! rsi tmp.164)
                          (set! rdi |-.71|)
                          (set! r15 L.rp.38)
                          (jump L.-.71.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.163 rax))))
                (begin
                  (return-point L.rp.39
                    (begin
                      (set! rdx tmp.163)
                      (set! rsi tmp.160)
                      (set! rdi <=.73)
                      (set! r15 L.rp.39)
                      (jump L.<=.73.7 rbp r15 rdi rsi rdx)))
                  (set! boolean4.11 rax))))
            (begin
              (set! rdi fun/empty10283.7)
              (set! r15 tmp-ra.182)
              (jump L.fun/empty10283.7.18 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () () () ())))
    (define L.fun/void10625.9.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.128 r15)
        (begin
          (set! c.78 rdi)
          (begin
            (set! fun/void10626.6 (mref c.78 14))
            (begin
              (set! rdi fun/void10626.6)
              (set! r15 tmp-ra.128)
              (jump L.fun/void10626.6.12 rbp r15 rdi))))))
    (define L.fun/void10628.8.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.129 r15)
        (begin
          (set! c.77 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.129 rbp rax))))))
    (define L.fun/void10627.7.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.130 r15)
        (begin
          (set! c.76 rdi)
          (begin
            (set! fun/void10628.8 (mref c.76 14))
            (begin
              (set! rdi fun/void10628.8)
              (set! r15 tmp-ra.130)
              (jump L.fun/void10628.8.14 rbp r15 rdi))))))
    (define L.fun/void10626.6.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.131 r15)
        (begin
          (set! c.75 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.131 rbp rax))))))
    (define L.fun/error10624.5.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.132 r15)
        (begin
          (set! c.74 rdi)
          (begin (begin (set! rax 19262) (jump tmp-ra.132 rbp rax))))))
    (define L.fun/error10623.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.133 r15)
        (begin
          (set! c.73 rdi)
          (begin
            (set! fun/error10624.5 (mref c.73 14))
            (begin
              (set! rdi fun/error10624.5)
              (set! r15 tmp-ra.133)
              (jump L.fun/error10624.5.11 rbp r15 rdi))))))
    (define L.+.67.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.134 r15)
        (begin
          (set! c.72 rdi)
          (set! tmp.31 rsi)
          (set! tmp.32 rdx)
          (begin
            (if (begin
                  (if (begin (set! tmp.89 (bitwise-and tmp.32 7)) (= tmp.89 0))
                    (set! tmp.88 14)
                    (set! tmp.88 6))
                  (!= tmp.88 6))
              (if (begin
                    (if (begin
                          (set! tmp.91 (bitwise-and tmp.31 7))
                          (= tmp.91 0))
                      (set! tmp.90 14)
                      (set! tmp.90 6))
                    (!= tmp.90 6))
                (begin (set! rax (+ tmp.31 tmp.32)) (jump tmp-ra.134 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.134 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.134 rbp rax)))))))
    (define L.-.68.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.135 r15)
        (begin
          (set! c.71 rdi)
          (set! tmp.33 rsi)
          (set! tmp.34 rdx)
          (begin
            (if (begin
                  (if (begin (set! tmp.93 (bitwise-and tmp.34 7)) (= tmp.93 0))
                    (set! tmp.92 14)
                    (set! tmp.92 6))
                  (!= tmp.92 6))
              (if (begin
                    (if (begin
                          (set! tmp.95 (bitwise-and tmp.33 7))
                          (= tmp.95 0))
                      (set! tmp.94 14)
                      (set! tmp.94 6))
                    (!= tmp.94 6))
                (begin (set! rax (- tmp.33 tmp.34)) (jump tmp-ra.135 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.135 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.135 rbp rax)))))))
    (define L.*.69.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.136 r15)
        (begin
          (set! c.70 rdi)
          (set! tmp.29 rsi)
          (set! tmp.30 rdx)
          (begin
            (if (begin
                  (if (begin (set! tmp.97 (bitwise-and tmp.30 7)) (= tmp.97 0))
                    (set! tmp.96 14)
                    (set! tmp.96 6))
                  (!= tmp.96 6))
              (if (begin
                    (if (begin
                          (set! tmp.99 (bitwise-and tmp.29 7))
                          (= tmp.99 0))
                      (set! tmp.98 14)
                      (set! tmp.98 6))
                    (!= tmp.98 6))
                (begin
                  (set! tmp.100 (arithmetic-shift-right tmp.30 3))
                  (begin
                    (set! rax (* tmp.29 tmp.100))
                    (jump tmp-ra.136 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.136 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.136 rbp rax)))))))
    (begin
      (set! tmp-ra.137 r15)
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
            (begin
              (return-point L.rp.16
                (begin
                  (set! rdi fun/error10623.4)
                  (set! r15 L.rp.16)
                  (jump L.fun/error10623.4.10 rbp r15 rdi)))
              (set! error0.14 rax))
            (begin
              (return-point L.rp.17
                (begin
                  (set! rdi fun/void10625.9)
                  (set! r15 L.rp.17)
                  (jump L.fun/void10625.9.15 rbp r15 rdi)))
              (set! void1.13 rax))
            (begin
              (begin
                (begin
                  (return-point L.rp.18
                    (begin
                      (set! rdx 768)
                      (set! rsi 1416)
                      (set! rdi |+.67|)
                      (set! r15 L.rp.18)
                      (jump L.+.67.9 rbp r15 rdi rsi rdx)))
                  (set! tmp.111 rax))
                (begin
                  (begin
                    (return-point L.rp.19
                      (begin
                        (set! rdx 1656)
                        (set! rsi 520)
                        (set! rdi |-.68|)
                        (set! r15 L.rp.19)
                        (jump L.-.68.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.112 rax))
                  (begin
                    (return-point L.rp.20
                      (begin
                        (set! rdx tmp.112)
                        (set! rsi tmp.111)
                        (set! rdi |+.67|)
                        (set! r15 L.rp.20)
                        (jump L.+.67.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.110 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.21
                      (begin
                        (set! rdx 88)
                        (set! rsi 1360)
                        (set! rdi |-.68|)
                        (set! r15 L.rp.21)
                        (jump L.-.68.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.114 rax))
                  (begin
                    (begin
                      (return-point L.rp.22
                        (begin
                          (set! rdx 1432)
                          (set! rsi 416)
                          (set! rdi *.69)
                          (set! r15 L.rp.22)
                          (jump L.*.69.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.115 rax))
                    (begin
                      (return-point L.rp.23
                        (begin
                          (set! rdx tmp.115)
                          (set! rsi tmp.114)
                          (set! rdi *.69)
                          (set! r15 L.rp.23)
                          (jump L.*.69.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.113 rax))))
                (begin
                  (return-point L.rp.24
                    (begin
                      (set! rdx tmp.113)
                      (set! rsi tmp.110)
                      (set! rdi |+.67|)
                      (set! r15 L.rp.24)
                      (jump L.+.67.9 rbp r15 rdi rsi rdx)))
                  (set! fixnum2.12 rax))))
            (begin
              (begin
                (begin
                  (return-point L.rp.25
                    (begin
                      (set! rdx 1624)
                      (set! rsi 576)
                      (set! rdi |-.68|)
                      (set! r15 L.rp.25)
                      (jump L.-.68.8 rbp r15 rdi rsi rdx)))
                  (set! tmp.117 rax))
                (begin
                  (begin
                    (return-point L.rp.26
                      (begin
                        (set! rdx 1944)
                        (set! rsi 1152)
                        (set! rdi |+.67|)
                        (set! r15 L.rp.26)
                        (jump L.+.67.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.118 rax))
                  (begin
                    (return-point L.rp.27
                      (begin
                        (set! rdx tmp.118)
                        (set! rsi tmp.117)
                        (set! rdi |+.67|)
                        (set! r15 L.rp.27)
                        (jump L.+.67.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.116 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.28
                      (begin
                        (set! rdx 2024)
                        (set! rsi 1432)
                        (set! rdi |-.68|)
                        (set! r15 L.rp.28)
                        (jump L.-.68.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.120 rax))
                  (begin
                    (begin
                      (return-point L.rp.29
                        (begin
                          (set! rdx 392)
                          (set! rsi 336)
                          (set! rdi *.69)
                          (set! r15 L.rp.29)
                          (jump L.*.69.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.121 rax))
                    (begin
                      (return-point L.rp.30
                        (begin
                          (set! rdx tmp.121)
                          (set! rsi tmp.120)
                          (set! rdi |-.68|)
                          (set! r15 L.rp.30)
                          (jump L.-.68.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.119 rax))))
                (begin
                  (return-point L.rp.31
                    (begin
                      (set! rdx tmp.119)
                      (set! rsi tmp.116)
                      (set! rdi *.69)
                      (set! r15 L.rp.31)
                      (jump L.*.69.7 rbp r15 rdi rsi rdx)))
                  (set! fixnum3.11 rax))))
            (begin
              (begin
                (begin
                  (return-point L.rp.32
                    (begin
                      (set! rdx 1808)
                      (set! rsi 376)
                      (set! rdi *.69)
                      (set! r15 L.rp.32)
                      (jump L.*.69.7 rbp r15 rdi rsi rdx)))
                  (set! tmp.123 rax))
                (begin
                  (begin
                    (return-point L.rp.33
                      (begin
                        (set! rdx 992)
                        (set! rsi 1664)
                        (set! rdi |-.68|)
                        (set! r15 L.rp.33)
                        (jump L.-.68.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.124 rax))
                  (begin
                    (return-point L.rp.34
                      (begin
                        (set! rdx tmp.124)
                        (set! rsi tmp.123)
                        (set! rdi |+.67|)
                        (set! r15 L.rp.34)
                        (jump L.+.67.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.122 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.35
                      (begin
                        (set! rdx 1216)
                        (set! rsi 1840)
                        (set! rdi |+.67|)
                        (set! r15 L.rp.35)
                        (jump L.+.67.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.126 rax))
                  (begin
                    (begin
                      (return-point L.rp.36
                        (begin
                          (set! rdx 1752)
                          (set! rsi 1712)
                          (set! rdi |+.67|)
                          (set! r15 L.rp.36)
                          (jump L.+.67.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.127 rax))
                    (begin
                      (return-point L.rp.37
                        (begin
                          (set! rdx tmp.127)
                          (set! rsi tmp.126)
                          (set! rdi |-.68|)
                          (set! r15 L.rp.37)
                          (jump L.-.68.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.125 rax))))
                (begin
                  (return-point L.rp.38
                    (begin
                      (set! rdx tmp.125)
                      (set! rsi tmp.122)
                      (set! rdi |-.68|)
                      (set! r15 L.rp.38)
                      (jump L.-.68.8 rbp r15 rdi rsi rdx)))
                  (set! fixnum4.10 rax))))
            (begin
              (set! rdi fun/void10627.7)
              (set! r15 tmp-ra.137)
              (jump L.fun/void10627.7.13 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () ())))
    (define L.lam.74.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.137 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/ascii-char10710.8 (mref c.90 14))
            (begin
              (set! rdi fun/ascii-char10710.8)
              (set! r15 tmp-ra.137)
              (jump L.fun/ascii-char10710.8.15 rbp r15 rdi))))))
    (define L.fun/void10716.14.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.138 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.138 rbp rax))))))
    (define L.fun/empty10709.13.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.139 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.139 rbp rax))))))
    (define L.fun/ascii-char10711.12.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.140 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 23342) (jump tmp-ra.140 rbp rax))))))
    (define L.fun/vector10713.11.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.141 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! make-vector.72 (mref c.86 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.72)
              (set! r15 tmp-ra.141)
              (jump L.make-vector.72.10 rbp r15 rdi rsi))))))
    (define L.fun/error10717.10.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.142 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/error10718.4 (mref c.85 14))
            (begin
              (set! rdi fun/error10718.4)
              (set! r15 tmp-ra.142)
              (jump L.fun/error10718.4.11 rbp r15 rdi))))))
    (define L.fun/empty10708.9.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.143 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! fun/empty10709.13 (mref c.84 14))
            (begin
              (set! rdi fun/empty10709.13)
              (set! r15 tmp-ra.143)
              (jump L.fun/empty10709.13.20 rbp r15 rdi))))))
    (define L.fun/ascii-char10710.8.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.144 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/ascii-char10711.12 (mref c.83 14))
            (begin
              (set! rdi fun/ascii-char10711.12)
              (set! r15 tmp-ra.144)
              (jump L.fun/ascii-char10711.12.19 rbp r15 rdi))))))
    (define L.fun/vector10712.7.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.145 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/vector10713.11 (mref c.82 14))
            (begin
              (set! rdi fun/vector10713.11)
              (set! r15 tmp-ra.145)
              (jump L.fun/vector10713.11.18 rbp r15 rdi))))))
    (define L.fun/void10715.6.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.146 r15)
        (begin
          (set! c.81 rdi)
          (begin
            (set! fun/void10716.14 (mref c.81 14))
            (begin
              (set! rdi fun/void10716.14)
              (set! r15 tmp-ra.146)
              (jump L.fun/void10716.14.21 rbp r15 rdi))))))
    (define L.fun/any10714.5.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.147 r15)
        (begin
          (set! c.80 rdi)
          (begin
            (set! make-vector.72 (mref c.80 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.72)
              (set! r15 tmp-ra.147)
              (jump L.make-vector.72.10 rbp r15 rdi rsi))))))
    (define L.fun/error10718.4.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.148 r15)
        (begin
          (set! c.79 rdi)
          (begin (begin (set! rax 46910) (jump tmp-ra.148 rbp rax))))))
    (define L.make-vector.72.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.149 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.48 rsi)
          (begin
            (set! make-init-vector.1 (mref c.78 14))
            (if (begin
                  (if (begin
                        (set! tmp.109 (bitwise-and tmp.48 7))
                        (= tmp.109 0))
                    (set! tmp.108 14)
                    (set! tmp.108 6))
                  (!= tmp.108 6))
              (begin
                (set! rsi tmp.48)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.149)
                (jump L.make-init-vector.1.9 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.149 rbp rax)))))))
    (define L.make-init-vector.1.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.150 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.20 rsi)
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
              (begin
                (set! rcx tmp.21)
                (set! rdx 0)
                (set! rsi tmp.20)
                (set! rdi vector-init-loop.22)
                (set! r15 tmp-ra.150)
                (jump L.vector-init-loop.22.8 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.22.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.151 r15)
        (begin
          (set! c.76 rdi)
          (set! len.23 rsi)
          (set! i.25 rdx)
          (set! vec.24 rcx)
          (begin
            (set! vector-init-loop.22 (mref c.76 14))
            (if (begin
                  (if (= len.23 i.25) (set! tmp.114 14) (set! tmp.114 6))
                  (!= tmp.114 6))
              (begin (set! rax vec.24) (jump tmp-ra.151 rbp rax))
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
                  (begin
                    (set! rcx vec.24)
                    (set! rdx tmp.118)
                    (set! rsi len.23)
                    (set! rdi vector-init-loop.22)
                    (set! r15 tmp-ra.151)
                    (jump
                     L.vector-init-loop.22.8
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.fixnum?.73.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.152 r15)
        (begin
          (set! c.75 rdi)
          (set! tmp.57 rsi)
          (begin
            (if (begin (set! tmp.119 (bitwise-and tmp.57 7)) (= tmp.119 0))
              (begin (set! rax 14) (jump tmp-ra.152 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.152 rbp rax)))))))
    (begin
      (set! tmp-ra.153 r15)
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
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/empty10708.9)
                  (set! r15 L.rp.23)
                  (jump L.fun/empty10708.9.16 rbp r15 rdi)))
              (set! empty0.19 rax))
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
            (begin
              (return-point L.rp.24
                (begin
                  (set! rdi fun/vector10712.7)
                  (set! r15 L.rp.24)
                  (jump L.fun/vector10712.7.14 rbp r15 rdi)))
              (set! vector2.17 rax))
            (begin
              (begin
                (return-point L.rp.25
                  (begin
                    (set! rdi fun/any10714.5)
                    (set! r15 L.rp.25)
                    (jump L.fun/any10714.5.12 rbp r15 rdi)))
                (set! tmp.136 rax))
              (begin
                (return-point L.rp.26
                  (begin
                    (set! rsi tmp.136)
                    (set! rdi fixnum?.73)
                    (set! r15 L.rp.26)
                    (jump L.fixnum?.73.7 rbp r15 rdi rsi)))
                (set! boolean3.16 rax)))
            (begin
              (return-point L.rp.27
                (begin
                  (set! rdi fun/void10715.6)
                  (set! r15 L.rp.27)
                  (jump L.fun/void10715.6.13 rbp r15 rdi)))
              (set! void4.15 rax))
            (begin
              (set! rdi fun/error10717.10)
              (set! r15 tmp-ra.153)
              (jump L.fun/error10717.10.17 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() ())))
    (define L.lam.75.24
      ((new-frames (() () () () () ())))
      (begin
        (set! tmp-ra.166 r15)
        (begin
          (set! c.93 rdi)
          (begin
            (set! |-.70| (mref c.93 14))
            (set! |+.71| (mref c.93 22))
            (begin
              (begin
                (begin
                  (return-point L.rp.25
                    (begin
                      (set! rdx 1008)
                      (set! rsi 720)
                      (set! rdi |-.70|)
                      (set! r15 L.rp.25)
                      (jump L.-.70.10 rbp r15 rdi rsi rdx)))
                  (set! tmp.114 rax))
                (begin
                  (begin
                    (return-point L.rp.26
                      (begin
                        (set! rdx 864)
                        (set! rsi 768)
                        (set! rdi |-.70|)
                        (set! r15 L.rp.26)
                        (jump L.-.70.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.115 rax))
                  (begin
                    (return-point L.rp.27
                      (begin
                        (set! rdx tmp.115)
                        (set! rsi tmp.114)
                        (set! rdi |-.70|)
                        (set! r15 L.rp.27)
                        (jump L.-.70.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.113 rax))))
              (begin
                (begin
                  (begin
                    (return-point L.rp.28
                      (begin
                        (set! rdx 840)
                        (set! rsi 808)
                        (set! rdi |+.71|)
                        (set! r15 L.rp.28)
                        (jump L.+.71.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.117 rax))
                  (begin
                    (begin
                      (return-point L.rp.29
                        (begin
                          (set! rdx 1512)
                          (set! rsi 1304)
                          (set! rdi |-.70|)
                          (set! r15 L.rp.29)
                          (jump L.-.70.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.118 rax))
                    (begin
                      (return-point L.rp.30
                        (begin
                          (set! rdx tmp.118)
                          (set! rsi tmp.117)
                          (set! rdi |+.71|)
                          (set! r15 L.rp.30)
                          (jump L.+.71.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.116 rax))))
                (begin
                  (set! rdx tmp.116)
                  (set! rsi tmp.113)
                  (set! rdi |+.71|)
                  (set! r15 tmp-ra.166)
                  (jump L.+.71.9 rbp r15 rdi rsi rdx))))))))
    (define L.lam.74.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.167 r15)
        (begin
          (set! c.92 rdi)
          (begin
            (set! fun/ascii-char10795.7 (mref c.92 14))
            (begin
              (set! rdi fun/ascii-char10795.7)
              (set! r15 tmp-ra.167)
              (jump L.fun/ascii-char10795.7.17 rbp r15 rdi))))))
    (define L.lam.73.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.168 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/void10791.4 (mref c.91 14))
            (begin
              (set! rdi fun/void10791.4)
              (set! r15 tmp-ra.168)
              (jump L.fun/void10791.4.14 rbp r15 rdi))))))
    (define L.fun/ascii-char10793.11.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.169 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/ascii-char10794.5 (mref c.90 14))
            (begin
              (set! rdi fun/ascii-char10794.5)
              (set! r15 tmp-ra.169)
              (jump L.fun/ascii-char10794.5.15 rbp r15 rdi))))))
    (define L.fun/void10792.10.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.170 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.170 rbp rax))))))
    (define L.fun/vector10790.9.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.171 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! make-vector.69 (mref c.88 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.69)
              (set! r15 tmp-ra.171)
              (jump L.make-vector.69.13 rbp r15 rdi rsi))))))
    (define L.fun/vector10789.8.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.172 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! fun/vector10790.9 (mref c.87 14))
            (begin
              (set! rdi fun/vector10790.9)
              (set! r15 tmp-ra.172)
              (jump L.fun/vector10790.9.19 rbp r15 rdi))))))
    (define L.fun/ascii-char10795.7.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.173 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! fun/ascii-char10796.6 (mref c.86 14))
            (begin
              (set! rdi fun/ascii-char10796.6)
              (set! r15 tmp-ra.173)
              (jump L.fun/ascii-char10796.6.16 rbp r15 rdi))))))
    (define L.fun/ascii-char10796.6.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.174 r15)
        (begin
          (set! c.85 rdi)
          (begin (begin (set! rax 27182) (jump tmp-ra.174 rbp rax))))))
    (define L.fun/ascii-char10794.5.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.175 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 17966) (jump tmp-ra.175 rbp rax))))))
    (define L.fun/void10791.4.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.176 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/void10792.10 (mref c.83 14))
            (begin
              (set! rdi fun/void10792.10)
              (set! r15 tmp-ra.176)
              (jump L.fun/void10792.10.20 rbp r15 rdi))))))
    (define L.make-vector.69.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.177 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.45 rsi)
          (begin
            (set! make-init-vector.1 (mref c.82 14))
            (if (begin
                  (if (begin
                        (set! tmp.120 (bitwise-and tmp.45 7))
                        (= tmp.120 0))
                    (set! tmp.119 14)
                    (set! tmp.119 6))
                  (!= tmp.119 6))
              (begin
                (set! rsi tmp.45)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.177)
                (jump L.make-init-vector.1.12 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.177 rbp rax)))))))
    (define L.make-init-vector.1.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.178 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.17 rsi)
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
              (begin
                (set! rcx tmp.18)
                (set! rdx 0)
                (set! rsi tmp.17)
                (set! rdi vector-init-loop.19)
                (set! r15 tmp-ra.178)
                (jump L.vector-init-loop.19.11 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.19.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.179 r15)
        (begin
          (set! c.80 rdi)
          (set! len.20 rsi)
          (set! i.22 rdx)
          (set! vec.21 rcx)
          (begin
            (set! vector-init-loop.19 (mref c.80 14))
            (if (begin
                  (if (= len.20 i.22) (set! tmp.125 14) (set! tmp.125 6))
                  (!= tmp.125 6))
              (begin (set! rax vec.21) (jump tmp-ra.179 rbp rax))
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
                  (begin
                    (set! rcx vec.21)
                    (set! rdx tmp.129)
                    (set! rsi len.20)
                    (set! rdi vector-init-loop.19)
                    (set! r15 tmp-ra.179)
                    (jump
                     L.vector-init-loop.19.11
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.-.70.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.180 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.35 rsi)
          (set! tmp.36 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.131 (bitwise-and tmp.36 7))
                        (= tmp.131 0))
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
                (begin (set! rax (- tmp.35 tmp.36)) (jump tmp-ra.180 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.180 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.180 rbp rax)))))))
    (define L.+.71.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.181 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.33 rsi)
          (set! tmp.34 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.135 (bitwise-and tmp.34 7))
                        (= tmp.135 0))
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
                (begin (set! rax (+ tmp.33 tmp.34)) (jump tmp-ra.181 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.181 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.181 rbp rax)))))))
    (define L.vector-ref.72.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.182 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.50 rsi)
          (set! tmp.51 rdx)
          (begin
            (set! unsafe-vector-ref.3 (mref c.77 14))
            (if (begin
                  (if (begin
                        (set! tmp.139 (bitwise-and tmp.51 7))
                        (= tmp.139 0))
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
                (begin
                  (set! rdx tmp.51)
                  (set! rsi tmp.50)
                  (set! rdi unsafe-vector-ref.3)
                  (set! r15 tmp-ra.182)
                  (jump L.unsafe-vector-ref.3.7 rbp r15 rdi rsi rdx))
                (begin (set! rax 2878) (jump tmp-ra.182 rbp rax)))
              (begin (set! rax 2878) (jump tmp-ra.182 rbp rax)))))))
    (define L.unsafe-vector-ref.3.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.183 r15)
        (begin
          (set! c.76 rdi)
          (set! tmp.28 rsi)
          (set! tmp.29 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.143 (mref tmp.28 -3))
                        (< tmp.29 tmp.143))
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
                  (begin
                    (set! rax (mref tmp.28 tmp.145))
                    (jump tmp-ra.183 rbp rax)))
                (begin (set! rax 2878) (jump tmp-ra.183 rbp rax)))
              (begin (set! rax 2878) (jump tmp-ra.183 rbp rax)))))))
    (begin
      (set! tmp-ra.184 r15)
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
            (begin
              (return-point L.rp.31
                (begin
                  (set! rdi fun/vector10789.8)
                  (set! r15 L.rp.31)
                  (jump L.fun/vector10789.8.18 rbp r15 rdi)))
              (set! vector0.16 rax))
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
            (begin
              (return-point L.rp.32
                (begin
                  (set! rdi fun/ascii-char10793.11)
                  (set! r15 L.rp.32)
                  (jump L.fun/ascii-char10793.11.21 rbp r15 rdi)))
              (set! ascii-char2.14 rax))
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
            (begin
              (set! rdx 8)
              (set! rsi vector0.16)
              (set! rdi vector-ref.72)
              (set! r15 tmp-ra.184)
              (jump L.vector-ref.72.8 rbp r15 rdi rsi rdx))))))))
(check-by-interp
 '(module
    ((new-frames (() () () ())))
    (define L.lam.77.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.151 r15)
        (begin
          (set! c.95 rdi)
          (begin
            (set! fun/pair11669.5 (mref c.95 14))
            (begin
              (set! rdi fun/pair11669.5)
              (set! r15 tmp-ra.151)
              (jump L.fun/pair11669.5.12 rbp r15 rdi))))))
    (define L.lam.76.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.152 r15)
        (begin
          (set! c.94 rdi)
          (begin
            (set! fun/empty11659.13 (mref c.94 14))
            (begin
              (set! rdi fun/empty11659.13)
              (set! r15 tmp-ra.152)
              (jump L.fun/empty11659.13.20 rbp r15 rdi))))))
    (define L.fun/empty11664.15.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.153 r15)
        (begin
          (set! c.93 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.153 rbp rax))))))
    (define L.fun/void11666.14.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.154 r15)
        (begin
          (set! c.92 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.154 rbp rax))))))
    (define L.fun/empty11659.13.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.155 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/empty11660.10 (mref c.91 14))
            (begin
              (set! rdi fun/empty11660.10)
              (set! r15 tmp-ra.155)
              (jump L.fun/empty11660.10.17 rbp r15 rdi))))))
    (define L.fun/error11661.12.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/error11662.8 (mref c.90 14))
            (begin
              (set! rdi fun/error11662.8)
              (set! r15 tmp-ra.156)
              (jump L.fun/error11662.8.15 rbp r15 rdi))))))
    (define L.fun/pair11670.11.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.157 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! cons.75 (mref c.89 14))
            (begin
              (set! rdx 3336)
              (set! rsi 1200)
              (set! rdi cons.75)
              (set! r15 tmp-ra.157)
              (jump L.cons.75.7 rbp r15 rdi rsi rdx))))))
    (define L.fun/empty11660.10.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.158 rbp rax))))))
    (define L.fun/vector11668.9.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! make-vector.74 (mref c.87 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.74)
              (set! r15 tmp-ra.159)
              (jump L.make-vector.74.10 rbp r15 rdi rsi))))))
    (define L.fun/error11662.8.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 36414) (jump tmp-ra.160 rbp rax))))))
    (define L.fun/empty11663.7.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/empty11664.15 (mref c.85 14))
            (begin
              (set! rdi fun/empty11664.15)
              (set! r15 tmp-ra.161)
              (jump L.fun/empty11664.15.22 rbp r15 rdi))))))
    (define L.fun/void11665.6.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! fun/void11666.14 (mref c.84 14))
            (begin
              (set! rdi fun/void11666.14)
              (set! r15 tmp-ra.162)
              (jump L.fun/void11666.14.21 rbp r15 rdi))))))
    (define L.fun/pair11669.5.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/pair11670.11 (mref c.83 14))
            (begin
              (set! rdi fun/pair11670.11)
              (set! r15 tmp-ra.163)
              (jump L.fun/pair11670.11.18 rbp r15 rdi))))))
    (define L.fun/vector11667.4.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.164 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/vector11668.9 (mref c.82 14))
            (begin
              (set! rdi fun/vector11668.9)
              (set! r15 tmp-ra.164)
              (jump L.fun/vector11668.9.16 rbp r15 rdi))))))
    (define L.make-vector.74.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.165 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.50 rsi)
          (begin
            (set! make-init-vector.1 (mref c.81 14))
            (if (begin
                  (if (begin
                        (set! tmp.117 (bitwise-and tmp.50 7))
                        (= tmp.117 0))
                    (set! tmp.116 14)
                    (set! tmp.116 6))
                  (!= tmp.116 6))
              (begin
                (set! rsi tmp.50)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.165)
                (jump L.make-init-vector.1.9 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.165 rbp rax)))))))
    (define L.make-init-vector.1.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.166 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.22 rsi)
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
              (begin
                (set! rcx tmp.23)
                (set! rdx 0)
                (set! rsi tmp.22)
                (set! rdi vector-init-loop.24)
                (set! r15 tmp-ra.166)
                (jump L.vector-init-loop.24.8 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.24.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.167 r15)
        (begin
          (set! c.79 rdi)
          (set! len.25 rsi)
          (set! i.27 rdx)
          (set! vec.26 rcx)
          (begin
            (set! vector-init-loop.24 (mref c.79 14))
            (if (begin
                  (if (= len.25 i.27) (set! tmp.122 14) (set! tmp.122 6))
                  (!= tmp.122 6))
              (begin (set! rax vec.26) (jump tmp-ra.167 rbp rax))
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
                  (begin
                    (set! rcx vec.26)
                    (set! rdx tmp.126)
                    (set! rsi len.25)
                    (set! rdi vector-init-loop.24)
                    (set! r15 tmp-ra.167)
                    (jump
                     L.vector-init-loop.24.8
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.cons.75.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.168 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.69 rsi)
          (set! tmp.70 rdx)
          (begin
            (begin
              (begin (set! tmp.127 (alloc 16)) (set! tmp.97 (+ tmp.127 1)))
              (begin
                (mset! tmp.97 -1 tmp.69)
                (mset! tmp.97 7 tmp.70)
                (begin (set! rax tmp.97) (jump tmp-ra.168 rbp rax))))))))
    (begin
      (set! tmp-ra.169 r15)
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
            (begin
              (return-point L.rp.25
                (begin
                  (set! rdi fun/error11661.12)
                  (set! r15 L.rp.25)
                  (jump L.fun/error11661.12.19 rbp r15 rdi)))
              (set! error1.20 rax))
            (begin
              (return-point L.rp.26
                (begin
                  (set! rdi fun/empty11663.7)
                  (set! r15 L.rp.26)
                  (jump L.fun/empty11663.7.14 rbp r15 rdi)))
              (set! empty2.19 rax))
            (begin
              (return-point L.rp.27
                (begin
                  (set! rdi fun/void11665.6)
                  (set! r15 L.rp.27)
                  (jump L.fun/void11665.6.13 rbp r15 rdi)))
              (set! void3.18 rax))
            (begin
              (return-point L.rp.28
                (begin
                  (set! rdi fun/vector11667.4)
                  (set! r15 L.rp.28)
                  (jump L.fun/vector11667.4.11 rbp r15 rdi)))
              (set! vector4.17 rax))
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
                  (begin
                    (set! rdi procedure0.21)
                    (set! r15 tmp-ra.169)
                    (jump tmp.150 rbp r15 rdi)))
                (begin (set! rax 10814) (jump tmp-ra.169 rbp rax)))
              (begin (set! rax 11070) (jump tmp-ra.169 rbp rax)))))))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () ())))
    (define L.fun/error12035.15.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.149 r15)
        (begin
          (set! c.91 rdi)
          (begin (begin (set! rax 9790) (jump tmp-ra.149 rbp rax))))))
    (define L.fun/ascii-char12031.14.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.150 r15)
        (begin
          (set! c.90 rdi)
          (begin (begin (set! rax 23854) (jump tmp-ra.150 rbp rax))))))
    (define L.fun/error12029.13.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.151 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 62526) (jump tmp-ra.151 rbp rax))))))
    (define L.fun/empty12027.12.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.152 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.152 rbp rax))))))
    (define L.fun/ascii-char12032.11.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.153 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! fun/ascii-char12033.10 (mref c.87 14))
            (begin
              (set! rdi fun/ascii-char12033.10)
              (set! r15 tmp-ra.153)
              (jump L.fun/ascii-char12033.10.16 rbp r15 rdi))))))
    (define L.fun/ascii-char12033.10.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.154 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 27438) (jump tmp-ra.154 rbp rax))))))
    (define L.fun/error12025.9.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.155 r15)
        (begin
          (set! c.85 rdi)
          (begin (begin (set! rax 48702) (jump tmp-ra.155 rbp rax))))))
    (define L.fun/error12028.8.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! fun/error12029.13 (mref c.84 14))
            (begin
              (set! rdi fun/error12029.13)
              (set! r15 tmp-ra.156)
              (jump L.fun/error12029.13.19 rbp r15 rdi))))))
    (define L.fun/error12034.7.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.157 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/error12035.15 (mref c.83 14))
            (begin
              (set! rdi fun/error12035.15)
              (set! r15 tmp-ra.157)
              (jump L.fun/error12035.15.21 rbp r15 rdi))))))
    (define L.fun/ascii-char12030.6.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/ascii-char12031.14 (mref c.82 14))
            (begin
              (set! rdi fun/ascii-char12031.14)
              (set! r15 tmp-ra.158)
              (jump L.fun/ascii-char12031.14.20 rbp r15 rdi))))))
    (define L.fun/error12024.5.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.81 rdi)
          (begin
            (set! fun/error12025.9 (mref c.81 14))
            (begin
              (set! rdi fun/error12025.9)
              (set! r15 tmp-ra.159)
              (jump L.fun/error12025.9.15 rbp r15 rdi))))))
    (define L.fun/empty12026.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.80 rdi)
          (begin
            (set! fun/empty12027.12 (mref c.80 14))
            (begin
              (set! rdi fun/empty12027.12)
              (set! r15 tmp-ra.160)
              (jump L.fun/empty12027.12.18 rbp r15 rdi))))))
    (define L.-.74.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.40 rsi)
          (set! tmp.41 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.108 (bitwise-and tmp.41 7))
                        (= tmp.108 0))
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
                (begin (set! rax (- tmp.40 tmp.41)) (jump tmp-ra.161 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.161 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.161 rbp rax)))))))
    (define L.*.75.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.112 (bitwise-and tmp.37 7))
                        (= tmp.112 0))
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
                  (begin
                    (set! rax (* tmp.36 tmp.115))
                    (jump tmp-ra.162 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.162 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.162 rbp rax)))))))
    (define L.+.76.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.117 (bitwise-and tmp.39 7))
                        (= tmp.117 0))
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
                (begin (set! rax (+ tmp.38 tmp.39)) (jump tmp-ra.163 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.163 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.163 rbp rax)))))))
    (begin
      (set! tmp-ra.164 r15)
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
                  (begin
                    (return-point L.rp.22
                      (begin
                        (set! rdx 1984)
                        (set! rsi 160)
                        (set! rdi |-.74|)
                        (set! r15 L.rp.22)
                        (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.137 rax))
                  (begin
                    (begin
                      (return-point L.rp.23
                        (begin
                          (set! rdx 1936)
                          (set! rsi 1648)
                          (set! rdi *.75)
                          (set! r15 L.rp.23)
                          (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.138 rax))
                    (begin
                      (return-point L.rp.24
                        (begin
                          (set! rdx tmp.138)
                          (set! rsi tmp.137)
                          (set! rdi |+.76|)
                          (set! r15 L.rp.24)
                          (jump L.+.76.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.136 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.25
                        (begin
                          (set! rdx 1992)
                          (set! rsi 1320)
                          (set! rdi |+.76|)
                          (set! r15 L.rp.25)
                          (jump L.+.76.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.140 rax))
                    (begin
                      (begin
                        (return-point L.rp.26
                          (begin
                            (set! rdx 792)
                            (set! rsi 1960)
                            (set! rdi *.75)
                            (set! r15 L.rp.26)
                            (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.141 rax))
                      (begin
                        (return-point L.rp.27
                          (begin
                            (set! rdx tmp.141)
                            (set! rsi tmp.140)
                            (set! rdi |-.74|)
                            (set! r15 L.rp.27)
                            (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.139 rax))))
                  (begin
                    (return-point L.rp.28
                      (begin
                        (set! rdx tmp.139)
                        (set! rsi tmp.136)
                        (set! rdi |-.74|)
                        (set! r15 L.rp.28)
                        (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.135 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.29
                        (begin
                          (set! rdx 272)
                          (set! rsi 1600)
                          (set! rdi *.75)
                          (set! r15 L.rp.29)
                          (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.144 rax))
                    (begin
                      (begin
                        (return-point L.rp.30
                          (begin
                            (set! rdx 1656)
                            (set! rsi 344)
                            (set! rdi |+.76|)
                            (set! r15 L.rp.30)
                            (jump L.+.76.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.145 rax))
                      (begin
                        (return-point L.rp.31
                          (begin
                            (set! rdx tmp.145)
                            (set! rsi tmp.144)
                            (set! rdi |-.74|)
                            (set! r15 L.rp.31)
                            (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.143 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.32
                          (begin
                            (set! rdx 744)
                            (set! rsi 1632)
                            (set! rdi |-.74|)
                            (set! r15 L.rp.32)
                            (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.147 rax))
                      (begin
                        (begin
                          (return-point L.rp.33
                            (begin
                              (set! rdx 728)
                              (set! rsi 440)
                              (set! rdi *.75)
                              (set! r15 L.rp.33)
                              (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                          (set! tmp.148 rax))
                        (begin
                          (return-point L.rp.34
                            (begin
                              (set! rdx tmp.148)
                              (set! rsi tmp.147)
                              (set! rdi *.75)
                              (set! r15 L.rp.34)
                              (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                          (set! tmp.146 rax))))
                    (begin
                      (return-point L.rp.35
                        (begin
                          (set! rdx tmp.146)
                          (set! rsi tmp.143)
                          (set! rdi *.75)
                          (set! r15 L.rp.35)
                          (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.142 rax))))
                (begin
                  (return-point L.rp.36
                    (begin
                      (set! rdx tmp.142)
                      (set! rsi tmp.135)
                      (set! rdi |+.76|)
                      (set! r15 L.rp.36)
                      (jump L.+.76.7 rbp r15 rdi rsi rdx)))
                  (set! fixnum0.21 rax))))
            (begin
              (return-point L.rp.37
                (begin
                  (set! rdi fun/error12024.5)
                  (set! r15 L.rp.37)
                  (jump L.fun/error12024.5.11 rbp r15 rdi)))
              (set! error1.20 rax))
            (begin
              (return-point L.rp.38
                (begin
                  (set! rdi fun/empty12026.4)
                  (set! r15 L.rp.38)
                  (jump L.fun/empty12026.4.10 rbp r15 rdi)))
              (set! empty2.19 rax))
            (begin
              (return-point L.rp.39
                (begin
                  (set! rdi fun/error12028.8)
                  (set! r15 L.rp.39)
                  (jump L.fun/error12028.8.14 rbp r15 rdi)))
              (set! error3.18 rax))
            (begin
              (return-point L.rp.40
                (begin
                  (set! rdi fun/ascii-char12030.6)
                  (set! r15 L.rp.40)
                  (jump L.fun/ascii-char12030.6.12 rbp r15 rdi)))
              (set! ascii-char4.17 rax))
            (begin
              (return-point L.rp.41
                (begin
                  (set! rdi fun/ascii-char12032.11)
                  (set! r15 L.rp.41)
                  (jump L.fun/ascii-char12032.11.17 rbp r15 rdi)))
              (set! ascii-char5.16 rax))
            (begin
              (set! rdi fun/error12034.7)
              (set! r15 tmp-ra.164)
              (jump L.fun/error12034.7.13 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () ())))
    (define L.lam.75.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.125 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/pair13985.9 (mref c.89 14))
            (begin
              (set! rdi fun/pair13985.9)
              (set! r15 tmp-ra.125)
              (jump L.fun/pair13985.9.13 rbp r15 rdi))))))
    (define L.fun/void13989.15.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.126 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! fun/void13990.8 (mref c.88 14))
            (begin
              (set! rdi fun/void13990.8)
              (set! r15 tmp-ra.126)
              (jump L.fun/void13990.8.12 rbp r15 rdi))))))
    (define L.fun/void13995.14.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.127 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! fun/void13996.7 (mref c.87 14))
            (begin
              (set! rdi fun/void13996.7)
              (set! r15 tmp-ra.127)
              (jump L.fun/void13996.7.11 rbp r15 rdi))))))
    (define L.fun/error13991.13.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.128 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! fun/error13992.4 (mref c.86 14))
            (begin
              (set! rdi fun/error13992.4)
              (set! r15 tmp-ra.128)
              (jump L.fun/error13992.4.8 rbp r15 rdi))))))
    (define L.fun/pair13986.12.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.129 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! cons.74 (mref c.85 14))
            (begin
              (set! rdx 3416)
              (set! rsi 896)
              (set! rdi cons.74)
              (set! r15 tmp-ra.129)
              (jump L.cons.74.7 rbp r15 rdi rsi rdx))))))
    (define L.fun/ascii-char13988.11.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.130 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 27182) (jump tmp-ra.130 rbp rax))))))
    (define L.fun/void13993.10.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.131 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/void13994.6 (mref c.83 14))
            (begin
              (set! rdi fun/void13994.6)
              (set! r15 tmp-ra.131)
              (jump L.fun/void13994.6.10 rbp r15 rdi))))))
    (define L.fun/pair13985.9.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.132 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/pair13986.12 (mref c.82 14))
            (begin
              (set! rdi fun/pair13986.12)
              (set! r15 tmp-ra.132)
              (jump L.fun/pair13986.12.16 rbp r15 rdi))))))
    (define L.fun/void13990.8.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.133 r15)
        (begin
          (set! c.81 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.133 rbp rax))))))
    (define L.fun/void13996.7.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.134 r15)
        (begin
          (set! c.80 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.134 rbp rax))))))
    (define L.fun/void13994.6.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.135 r15)
        (begin
          (set! c.79 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.135 rbp rax))))))
    (define L.fun/ascii-char13987.5.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.136 r15)
        (begin
          (set! c.78 rdi)
          (begin
            (set! fun/ascii-char13988.11 (mref c.78 14))
            (begin
              (set! rdi fun/ascii-char13988.11)
              (set! r15 tmp-ra.136)
              (jump L.fun/ascii-char13988.11.15 rbp r15 rdi))))))
    (define L.fun/error13992.4.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.137 r15)
        (begin
          (set! c.77 rdi)
          (begin (begin (set! rax 7486) (jump tmp-ra.137 rbp rax))))))
    (define L.cons.74.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.138 r15)
        (begin
          (set! c.76 rdi)
          (set! tmp.69 rsi)
          (set! tmp.70 rdx)
          (begin
            (begin
              (begin (set! tmp.105 (alloc 16)) (set! tmp.90 (+ tmp.105 1)))
              (begin
                (mset! tmp.90 -1 tmp.69)
                (mset! tmp.90 7 tmp.70)
                (begin (set! rax tmp.90) (jump tmp-ra.138 rbp rax))))))))
    (begin
      (set! tmp-ra.139 r15)
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
            (begin
              (return-point L.rp.21
                (begin
                  (set! rdi fun/ascii-char13987.5)
                  (set! r15 L.rp.21)
                  (jump L.fun/ascii-char13987.5.9 rbp r15 rdi)))
              (set! ascii-char1.20 rax))
            (begin
              (return-point L.rp.22
                (begin
                  (set! rdi fun/void13989.15)
                  (set! r15 L.rp.22)
                  (jump L.fun/void13989.15.19 rbp r15 rdi)))
              (set! void2.19 rax))
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/error13991.13)
                  (set! r15 L.rp.23)
                  (jump L.fun/error13991.13.17 rbp r15 rdi)))
              (set! error3.18 rax))
            (begin
              (return-point L.rp.24
                (begin
                  (set! rdi fun/void13993.10)
                  (set! r15 L.rp.24)
                  (jump L.fun/void13993.10.14 rbp r15 rdi)))
              (set! void4.17 rax))
            (begin
              (return-point L.rp.25
                (begin
                  (set! rdi fun/void13995.14)
                  (set! r15 L.rp.25)
                  (jump L.fun/void13995.14.18 rbp r15 rdi)))
              (set! void5.16 rax))
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
                  (begin
                    (set! rdi procedure0.21)
                    (set! r15 tmp-ra.139)
                    (jump tmp.124 rbp r15 rdi)))
                (begin (set! rax 10814) (jump tmp-ra.139 rbp rax)))
              (begin (set! rax 11070) (jump tmp-ra.139 rbp rax)))))))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () ())))
    (define L.lam.80.27
      ((new-frames (())))
      (begin
        (set! tmp-ra.187 r15)
        (begin
          (set! c.101 rdi)
          (begin
            (set! fun/any14746.10 (mref c.101 14))
            (set! ascii-char?.79 (mref c.101 22))
            (begin
              (begin
                (return-point L.rp.28
                  (begin
                    (set! rdi fun/any14746.10)
                    (set! r15 L.rp.28)
                    (jump L.fun/any14746.10.21 rbp r15 rdi)))
                (set! tmp.124 rax))
              (begin
                (set! rsi tmp.124)
                (set! rdi ascii-char?.79)
                (set! r15 tmp-ra.187)
                (jump L.ascii-char?.79.7 rbp r15 rdi rsi)))))))
    (define L.fun/vector14739.15.26
      ((new-frames ()))
      (begin
        (set! tmp-ra.188 r15)
        (begin
          (set! c.100 rdi)
          (begin
            (set! make-vector.74 (mref c.100 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.74)
              (set! r15 tmp-ra.188)
              (jump L.make-vector.74.14 rbp r15 rdi rsi))))))
    (define L.fun/ascii-char14749.14.25
      ((new-frames ()))
      (begin
        (set! tmp-ra.189 r15)
        (begin
          (set! c.99 rdi)
          (begin (begin (set! rax 31278) (jump tmp-ra.189 rbp rax))))))
    (define L.fun/ascii-char14743.13.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.190 r15)
        (begin
          (set! c.98 rdi)
          (begin (begin (set! rax 26158) (jump tmp-ra.190 rbp rax))))))
    (define L.fun/any14741.12.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.191 r15)
        (begin
          (set! c.97 rdi)
          (begin
            (set! make-vector.74 (mref c.97 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.74)
              (set! r15 tmp-ra.191)
              (jump L.make-vector.74.14 rbp r15 rdi rsi))))))
    (define L.fun/any14747.11.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.192 r15)
        (begin
          (set! c.96 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.192 rbp rax))))))
    (define L.fun/any14746.10.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.193 r15)
        (begin
          (set! c.95 rdi)
          (begin
            (set! fun/any14747.11 (mref c.95 14))
            (begin
              (set! rdi fun/any14747.11)
              (set! r15 tmp-ra.193)
              (jump L.fun/any14747.11.22 rbp r15 rdi))))))
    (define L.fun/ascii-char14742.9.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.194 r15)
        (begin
          (set! c.94 rdi)
          (begin
            (set! fun/ascii-char14743.13 (mref c.94 14))
            (begin
              (set! rdi fun/ascii-char14743.13)
              (set! r15 tmp-ra.194)
              (jump L.fun/ascii-char14743.13.24 rbp r15 rdi))))))
    (define L.fun/ascii-char14748.8.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.195 r15)
        (begin
          (set! c.93 rdi)
          (begin
            (set! fun/ascii-char14749.14 (mref c.93 14))
            (begin
              (set! rdi fun/ascii-char14749.14)
              (set! r15 tmp-ra.195)
              (jump L.fun/ascii-char14749.14.25 rbp r15 rdi))))))
    (define L.fun/any14740.7.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.196 r15)
        (begin
          (set! c.92 rdi)
          (begin
            (set! fun/any14741.12 (mref c.92 14))
            (begin
              (set! rdi fun/any14741.12)
              (set! r15 tmp-ra.196)
              (jump L.fun/any14741.12.23 rbp r15 rdi))))))
    (define L.fun/vector14744.6.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.197 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/vector14745.5 (mref c.91 14))
            (begin
              (set! rdi fun/vector14745.5)
              (set! r15 tmp-ra.197)
              (jump L.fun/vector14745.5.16 rbp r15 rdi))))))
    (define L.fun/vector14745.5.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.198 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! make-vector.74 (mref c.90 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.74)
              (set! r15 tmp-ra.198)
              (jump L.make-vector.74.14 rbp r15 rdi rsi))))))
    (define L.fun/vector14738.4.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.199 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/vector14739.15 (mref c.89 14))
            (begin
              (set! rdi fun/vector14739.15)
              (set! r15 tmp-ra.199)
              (jump L.fun/vector14739.15.26 rbp r15 rdi))))))
    (define L.make-vector.74.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.200 r15)
        (begin
          (set! c.88 rdi)
          (set! tmp.50 rsi)
          (begin
            (set! make-init-vector.1 (mref c.88 14))
            (if (begin
                  (if (begin
                        (set! tmp.126 (bitwise-and tmp.50 7))
                        (= tmp.126 0))
                    (set! tmp.125 14)
                    (set! tmp.125 6))
                  (!= tmp.125 6))
              (begin
                (set! rsi tmp.50)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.200)
                (jump L.make-init-vector.1.13 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.200 rbp rax)))))))
    (define L.make-init-vector.1.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.201 r15)
        (begin
          (set! c.87 rdi)
          (set! tmp.22 rsi)
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
              (begin
                (set! rcx tmp.23)
                (set! rdx 0)
                (set! rsi tmp.22)
                (set! rdi vector-init-loop.24)
                (set! r15 tmp-ra.201)
                (jump L.vector-init-loop.24.12 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.24.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.202 r15)
        (begin
          (set! c.86 rdi)
          (set! len.25 rsi)
          (set! i.27 rdx)
          (set! vec.26 rcx)
          (begin
            (set! vector-init-loop.24 (mref c.86 14))
            (if (begin
                  (if (= len.25 i.27) (set! tmp.131 14) (set! tmp.131 6))
                  (!= tmp.131 6))
              (begin (set! rax vec.26) (jump tmp-ra.202 rbp rax))
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
                  (begin
                    (set! rcx vec.26)
                    (set! rdx tmp.135)
                    (set! rsi len.25)
                    (set! rdi vector-init-loop.24)
                    (set! r15 tmp-ra.202)
                    (jump
                     L.vector-init-loop.24.12
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.-.75.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.203 r15)
        (begin
          (set! c.85 rdi)
          (set! tmp.40 rsi)
          (set! tmp.41 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.137 (bitwise-and tmp.41 7))
                        (= tmp.137 0))
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
                (begin (set! rax (- tmp.40 tmp.41)) (jump tmp-ra.203 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.203 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.203 rbp rax)))))))
    (define L.*.76.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.204 r15)
        (begin
          (set! c.84 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.141 (bitwise-and tmp.37 7))
                        (= tmp.141 0))
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
                  (begin
                    (set! rax (* tmp.36 tmp.144))
                    (jump tmp-ra.204 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.204 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.204 rbp rax)))))))
    (define L.+.77.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.205 r15)
        (begin
          (set! c.83 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.146 (bitwise-and tmp.39 7))
                        (= tmp.146 0))
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
                (begin (set! rax (+ tmp.38 tmp.39)) (jump tmp-ra.205 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.205 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.205 rbp rax)))))))
    (define L.fixnum?.78.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.206 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.59 rsi)
          (begin
            (if (begin (set! tmp.149 (bitwise-and tmp.59 7)) (= tmp.149 0))
              (begin (set! rax 14) (jump tmp-ra.206 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.206 rbp rax)))))))
    (define L.ascii-char?.79.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.207 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.63 rsi)
          (begin
            (if (begin (set! tmp.150 (bitwise-and tmp.63 255)) (= tmp.150 46))
              (begin (set! rax 14) (jump tmp-ra.207 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.207 rbp rax)))))))
    (begin
      (set! tmp-ra.208 r15)
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
            (begin
              (return-point L.rp.29
                (begin
                  (set! rdi fun/vector14738.4)
                  (set! r15 L.rp.29)
                  (jump L.fun/vector14738.4.15 rbp r15 rdi)))
              (set! vector0.21 rax))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.30
                      (begin
                        (set! rdx 1976)
                        (set! rsi 360)
                        (set! rdi |-.75|)
                        (set! r15 L.rp.30)
                        (jump L.-.75.11 rbp r15 rdi rsi rdx)))
                    (set! tmp.173 rax))
                  (begin
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx 1912)
                          (set! rsi 952)
                          (set! rdi |-.75|)
                          (set! r15 L.rp.31)
                          (jump L.-.75.11 rbp r15 rdi rsi rdx)))
                      (set! tmp.174 rax))
                    (begin
                      (return-point L.rp.32
                        (begin
                          (set! rdx tmp.174)
                          (set! rsi tmp.173)
                          (set! rdi *.76)
                          (set! r15 L.rp.32)
                          (jump L.*.76.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.172 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.33
                        (begin
                          (set! rdx 360)
                          (set! rsi 800)
                          (set! rdi |-.75|)
                          (set! r15 L.rp.33)
                          (jump L.-.75.11 rbp r15 rdi rsi rdx)))
                      (set! tmp.176 rax))
                    (begin
                      (begin
                        (return-point L.rp.34
                          (begin
                            (set! rdx 840)
                            (set! rsi 2008)
                            (set! rdi *.76)
                            (set! r15 L.rp.34)
                            (jump L.*.76.10 rbp r15 rdi rsi rdx)))
                        (set! tmp.177 rax))
                      (begin
                        (return-point L.rp.35
                          (begin
                            (set! rdx tmp.177)
                            (set! rsi tmp.176)
                            (set! rdi |+.77|)
                            (set! r15 L.rp.35)
                            (jump L.+.77.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.175 rax))))
                  (begin
                    (return-point L.rp.36
                      (begin
                        (set! rdx tmp.175)
                        (set! rsi tmp.172)
                        (set! rdi *.76)
                        (set! r15 L.rp.36)
                        (jump L.*.76.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.171 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.37
                        (begin
                          (set! rdx 1904)
                          (set! rsi 912)
                          (set! rdi *.76)
                          (set! r15 L.rp.37)
                          (jump L.*.76.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.180 rax))
                    (begin
                      (begin
                        (return-point L.rp.38
                          (begin
                            (set! rdx 704)
                            (set! rsi 1840)
                            (set! rdi *.76)
                            (set! r15 L.rp.38)
                            (jump L.*.76.10 rbp r15 rdi rsi rdx)))
                        (set! tmp.181 rax))
                      (begin
                        (return-point L.rp.39
                          (begin
                            (set! rdx tmp.181)
                            (set! rsi tmp.180)
                            (set! rdi |-.75|)
                            (set! r15 L.rp.39)
                            (jump L.-.75.11 rbp r15 rdi rsi rdx)))
                        (set! tmp.179 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.40
                          (begin
                            (set! rdx 1728)
                            (set! rsi 2000)
                            (set! rdi |+.77|)
                            (set! r15 L.rp.40)
                            (jump L.+.77.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.183 rax))
                      (begin
                        (begin
                          (return-point L.rp.41
                            (begin
                              (set! rdx 608)
                              (set! rsi 712)
                              (set! rdi |+.77|)
                              (set! r15 L.rp.41)
                              (jump L.+.77.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.184 rax))
                        (begin
                          (return-point L.rp.42
                            (begin
                              (set! rdx tmp.184)
                              (set! rsi tmp.183)
                              (set! rdi |-.75|)
                              (set! r15 L.rp.42)
                              (jump L.-.75.11 rbp r15 rdi rsi rdx)))
                          (set! tmp.182 rax))))
                    (begin
                      (return-point L.rp.43
                        (begin
                          (set! rdx tmp.182)
                          (set! rsi tmp.179)
                          (set! rdi *.76)
                          (set! r15 L.rp.43)
                          (jump L.*.76.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.178 rax))))
                (begin
                  (return-point L.rp.44
                    (begin
                      (set! rdx tmp.178)
                      (set! rsi tmp.171)
                      (set! rdi |+.77|)
                      (set! r15 L.rp.44)
                      (jump L.+.77.9 rbp r15 rdi rsi rdx)))
                  (set! fixnum1.20 rax))))
            (begin
              (begin
                (return-point L.rp.45
                  (begin
                    (set! rdi fun/any14740.7)
                    (set! r15 L.rp.45)
                    (jump L.fun/any14740.7.18 rbp r15 rdi)))
                (set! tmp.185 rax))
              (begin
                (return-point L.rp.46
                  (begin
                    (set! rsi tmp.185)
                    (set! rdi fixnum?.78)
                    (set! r15 L.rp.46)
                    (jump L.fixnum?.78.8 rbp r15 rdi rsi)))
                (set! boolean2.19 rax)))
            (begin
              (return-point L.rp.47
                (begin
                  (set! rdi fun/ascii-char14742.9)
                  (set! r15 L.rp.47)
                  (jump L.fun/ascii-char14742.9.20 rbp r15 rdi)))
              (set! ascii-char3.18 rax))
            (begin
              (return-point L.rp.48
                (begin
                  (set! rdi fun/vector14744.6)
                  (set! r15 L.rp.48)
                  (jump L.fun/vector14744.6.17 rbp r15 rdi)))
              (set! vector4.17 rax))
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
            (begin
              (set! rdi fun/ascii-char14748.8)
              (set! r15 tmp-ra.208)
              (jump L.fun/ascii-char14748.8.19 rbp r15 rdi))))))))
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
       ()
       ())))
    (define L.fun/any14774.13.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.183 r15)
        (begin
          (set! c.93 rdi)
          (begin
            (set! fun/any14775.7 (mref c.93 14))
            (begin
              (set! rdi fun/any14775.7)
              (set! r15 tmp-ra.183)
              (jump L.fun/any14775.7.17 rbp r15 rdi))))))
    (define L.fun/vector14776.12.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.184 r15)
        (begin
          (set! c.92 rdi)
          (begin
            (set! fun/vector14777.9 (mref c.92 14))
            (begin
              (set! rdi fun/vector14777.9)
              (set! r15 tmp-ra.184)
              (jump L.fun/vector14777.9.19 rbp r15 rdi))))))
    (define L.fun/ascii-char14781.11.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.185 r15)
        (begin
          (set! c.91 rdi)
          (begin (begin (set! rax 23086) (jump tmp-ra.185 rbp rax))))))
    (define L.fun/empty14778.10.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.186 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/empty14779.6 (mref c.90 14))
            (begin
              (set! rdi fun/empty14779.6)
              (set! r15 tmp-ra.186)
              (jump L.fun/empty14779.6.16 rbp r15 rdi))))))
    (define L.fun/vector14777.9.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.187 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! make-vector.72 (mref c.89 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.72)
              (set! r15 tmp-ra.187)
              (jump L.make-vector.72.13 rbp r15 rdi rsi))))))
    (define L.fun/vector14773.8.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.188 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! make-vector.72 (mref c.88 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.72)
              (set! r15 tmp-ra.188)
              (jump L.make-vector.72.13 rbp r15 rdi rsi))))))
    (define L.fun/any14775.7.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.189 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 1176) (jump tmp-ra.189 rbp rax))))))
    (define L.fun/empty14779.6.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.190 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.190 rbp rax))))))
    (define L.fun/vector14772.5.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.191 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/vector14773.8 (mref c.85 14))
            (begin
              (set! rdi fun/vector14773.8)
              (set! r15 tmp-ra.191)
              (jump L.fun/vector14773.8.18 rbp r15 rdi))))))
    (define L.fun/ascii-char14780.4.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.192 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! fun/ascii-char14781.11 (mref c.84 14))
            (begin
              (set! rdi fun/ascii-char14781.11)
              (set! r15 tmp-ra.192)
              (jump L.fun/ascii-char14781.11.21 rbp r15 rdi))))))
    (define L.make-vector.72.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.193 r15)
        (begin
          (set! c.83 rdi)
          (set! tmp.48 rsi)
          (begin
            (set! make-init-vector.1 (mref c.83 14))
            (if (begin
                  (if (begin
                        (set! tmp.113 (bitwise-and tmp.48 7))
                        (= tmp.113 0))
                    (set! tmp.112 14)
                    (set! tmp.112 6))
                  (!= tmp.112 6))
              (begin
                (set! rsi tmp.48)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.193)
                (jump L.make-init-vector.1.12 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.193 rbp rax)))))))
    (define L.make-init-vector.1.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.194 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.20 rsi)
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
              (begin
                (set! rcx tmp.21)
                (set! rdx 0)
                (set! rsi tmp.20)
                (set! rdi vector-init-loop.22)
                (set! r15 tmp-ra.194)
                (jump L.vector-init-loop.22.11 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.22.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.195 r15)
        (begin
          (set! c.81 rdi)
          (set! len.23 rsi)
          (set! i.25 rdx)
          (set! vec.24 rcx)
          (begin
            (set! vector-init-loop.22 (mref c.81 14))
            (if (begin
                  (if (= len.23 i.25) (set! tmp.118 14) (set! tmp.118 6))
                  (!= tmp.118 6))
              (begin (set! rax vec.24) (jump tmp-ra.195 rbp rax))
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
                  (begin
                    (set! rcx vec.24)
                    (set! rdx tmp.122)
                    (set! rsi len.23)
                    (set! rdi vector-init-loop.22)
                    (set! r15 tmp-ra.195)
                    (jump
                     L.vector-init-loop.22.11
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.+.73.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.196 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.124 (bitwise-and tmp.37 7))
                        (= tmp.124 0))
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
                (begin (set! rax (+ tmp.36 tmp.37)) (jump tmp-ra.196 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.196 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.196 rbp rax)))))))
    (define L.-.74.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.197 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.128 (bitwise-and tmp.39 7))
                        (= tmp.128 0))
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
                (begin (set! rax (- tmp.38 tmp.39)) (jump tmp-ra.197 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.197 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.197 rbp rax)))))))
    (define L.*.75.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.198 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.34 rsi)
          (set! tmp.35 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.132 (bitwise-and tmp.35 7))
                        (= tmp.132 0))
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
                  (begin
                    (set! rax (* tmp.34 tmp.135))
                    (jump tmp-ra.198 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.198 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.198 rbp rax)))))))
    (define L.procedure?.76.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.199 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.66 rsi)
          (begin
            (if (begin (set! tmp.136 (bitwise-and tmp.66 7)) (= tmp.136 2))
              (begin (set! rax 14) (jump tmp-ra.199 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.199 rbp rax)))))))
    (begin
      (set! tmp-ra.200 r15)
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
                  (begin
                    (return-point L.rp.24
                      (begin
                        (set! rdx 392)
                        (set! rsi 1824)
                        (set! rdi |+.73|)
                        (set! r15 L.rp.24)
                        (jump L.+.73.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.156 rax))
                  (begin
                    (begin
                      (return-point L.rp.25
                        (begin
                          (set! rdx 888)
                          (set! rsi 88)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.25)
                          (jump L.+.73.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.157 rax))
                    (begin
                      (return-point L.rp.26
                        (begin
                          (set! rdx tmp.157)
                          (set! rsi tmp.156)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.26)
                          (jump L.+.73.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.155 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.27
                        (begin
                          (set! rdx 752)
                          (set! rsi 136)
                          (set! rdi |-.74|)
                          (set! r15 L.rp.27)
                          (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.159 rax))
                    (begin
                      (begin
                        (return-point L.rp.28
                          (begin
                            (set! rdx 1824)
                            (set! rsi 664)
                            (set! rdi *.75)
                            (set! r15 L.rp.28)
                            (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.160 rax))
                      (begin
                        (return-point L.rp.29
                          (begin
                            (set! rdx tmp.160)
                            (set! rsi tmp.159)
                            (set! rdi |+.73|)
                            (set! r15 L.rp.29)
                            (jump L.+.73.10 rbp r15 rdi rsi rdx)))
                        (set! tmp.158 rax))))
                  (begin
                    (return-point L.rp.30
                      (begin
                        (set! rdx tmp.158)
                        (set! rsi tmp.155)
                        (set! rdi |-.74|)
                        (set! r15 L.rp.30)
                        (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.154 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx 240)
                          (set! rsi 608)
                          (set! rdi |-.74|)
                          (set! r15 L.rp.31)
                          (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.163 rax))
                    (begin
                      (begin
                        (return-point L.rp.32
                          (begin
                            (set! rdx 472)
                            (set! rsi 160)
                            (set! rdi |+.73|)
                            (set! r15 L.rp.32)
                            (jump L.+.73.10 rbp r15 rdi rsi rdx)))
                        (set! tmp.164 rax))
                      (begin
                        (return-point L.rp.33
                          (begin
                            (set! rdx tmp.164)
                            (set! rsi tmp.163)
                            (set! rdi *.75)
                            (set! r15 L.rp.33)
                            (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.162 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.34
                          (begin
                            (set! rdx 504)
                            (set! rsi 1984)
                            (set! rdi |-.74|)
                            (set! r15 L.rp.34)
                            (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.166 rax))
                      (begin
                        (begin
                          (return-point L.rp.35
                            (begin
                              (set! rdx 280)
                              (set! rsi 472)
                              (set! rdi *.75)
                              (set! r15 L.rp.35)
                              (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                          (set! tmp.167 rax))
                        (begin
                          (return-point L.rp.36
                            (begin
                              (set! rdx tmp.167)
                              (set! rsi tmp.166)
                              (set! rdi |-.74|)
                              (set! r15 L.rp.36)
                              (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.165 rax))))
                    (begin
                      (return-point L.rp.37
                        (begin
                          (set! rdx tmp.165)
                          (set! rsi tmp.162)
                          (set! rdi |-.74|)
                          (set! r15 L.rp.37)
                          (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.161 rax))))
                (begin
                  (return-point L.rp.38
                    (begin
                      (set! rdx tmp.161)
                      (set! rsi tmp.154)
                      (set! rdi *.75)
                      (set! r15 L.rp.38)
                      (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                  (set! fixnum0.19 rax))))
            (begin
              (return-point L.rp.39
                (begin
                  (set! rdi fun/vector14772.5)
                  (set! r15 L.rp.39)
                  (jump L.fun/vector14772.5.15 rbp r15 rdi)))
              (set! vector1.18 rax))
            (begin
              (begin
                (return-point L.rp.40
                  (begin
                    (set! rdi fun/any14774.13)
                    (set! r15 L.rp.40)
                    (jump L.fun/any14774.13.23 rbp r15 rdi)))
                (set! tmp.168 rax))
              (begin
                (return-point L.rp.41
                  (begin
                    (set! rsi tmp.168)
                    (set! rdi procedure?.76)
                    (set! r15 L.rp.41)
                    (jump L.procedure?.76.7 rbp r15 rdi rsi)))
                (set! boolean2.17 rax)))
            (begin
              (return-point L.rp.42
                (begin
                  (set! rdi fun/vector14776.12)
                  (set! r15 L.rp.42)
                  (jump L.fun/vector14776.12.22 rbp r15 rdi)))
              (set! vector3.16 rax))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.43
                      (begin
                        (set! rdx 424)
                        (set! rsi 280)
                        (set! rdi *.75)
                        (set! r15 L.rp.43)
                        (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.171 rax))
                  (begin
                    (begin
                      (return-point L.rp.44
                        (begin
                          (set! rdx 288)
                          (set! rsi 1216)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.44)
                          (jump L.+.73.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.172 rax))
                    (begin
                      (return-point L.rp.45
                        (begin
                          (set! rdx tmp.172)
                          (set! rsi tmp.171)
                          (set! rdi |-.74|)
                          (set! r15 L.rp.45)
                          (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.170 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.46
                        (begin
                          (set! rdx 888)
                          (set! rsi 1176)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.46)
                          (jump L.+.73.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.174 rax))
                    (begin
                      (begin
                        (return-point L.rp.47
                          (begin
                            (set! rdx 1664)
                            (set! rsi 2000)
                            (set! rdi |-.74|)
                            (set! r15 L.rp.47)
                            (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.175 rax))
                      (begin
                        (return-point L.rp.48
                          (begin
                            (set! rdx tmp.175)
                            (set! rsi tmp.174)
                            (set! rdi |-.74|)
                            (set! r15 L.rp.48)
                            (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.173 rax))))
                  (begin
                    (return-point L.rp.49
                      (begin
                        (set! rdx tmp.173)
                        (set! rsi tmp.170)
                        (set! rdi |-.74|)
                        (set! r15 L.rp.49)
                        (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.169 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.50
                        (begin
                          (set! rdx 912)
                          (set! rsi 1960)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.50)
                          (jump L.+.73.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.178 rax))
                    (begin
                      (begin
                        (return-point L.rp.51
                          (begin
                            (set! rdx 712)
                            (set! rsi 944)
                            (set! rdi *.75)
                            (set! r15 L.rp.51)
                            (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.179 rax))
                      (begin
                        (return-point L.rp.52
                          (begin
                            (set! rdx tmp.179)
                            (set! rsi tmp.178)
                            (set! rdi |+.73|)
                            (set! r15 L.rp.52)
                            (jump L.+.73.10 rbp r15 rdi rsi rdx)))
                        (set! tmp.177 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.53
                          (begin
                            (set! rdx 1936)
                            (set! rsi 1184)
                            (set! rdi *.75)
                            (set! r15 L.rp.53)
                            (jump L.*.75.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.181 rax))
                      (begin
                        (begin
                          (return-point L.rp.54
                            (begin
                              (set! rdx 600)
                              (set! rsi 1696)
                              (set! rdi |-.74|)
                              (set! r15 L.rp.54)
                              (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.182 rax))
                        (begin
                          (return-point L.rp.55
                            (begin
                              (set! rdx tmp.182)
                              (set! rsi tmp.181)
                              (set! rdi |-.74|)
                              (set! r15 L.rp.55)
                              (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.180 rax))))
                    (begin
                      (return-point L.rp.56
                        (begin
                          (set! rdx tmp.180)
                          (set! rsi tmp.177)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.56)
                          (jump L.+.73.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.176 rax))))
                (begin
                  (return-point L.rp.57
                    (begin
                      (set! rdx tmp.176)
                      (set! rsi tmp.169)
                      (set! rdi |-.74|)
                      (set! r15 L.rp.57)
                      (jump L.-.74.9 rbp r15 rdi rsi rdx)))
                  (set! fixnum4.15 rax))))
            (begin
              (return-point L.rp.58
                (begin
                  (set! rdi fun/empty14778.10)
                  (set! r15 L.rp.58)
                  (jump L.fun/empty14778.10.20 rbp r15 rdi)))
              (set! empty5.14 rax))
            (begin
              (set! rdi fun/ascii-char14780.4)
              (set! r15 tmp-ra.200)
              (jump L.fun/ascii-char14780.4.14 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () ())))
    (define L.fun/error15420.17.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.130 r15)
        (begin
          (set! c.93 rdi)
          (begin
            (set! fun/error15421.9 (mref c.93 14))
            (begin
              (set! rdi fun/error15421.9)
              (set! r15 tmp-ra.130)
              (jump L.fun/error15421.9.14 rbp r15 rdi))))))
    (define L.fun/error15416.16.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.131 r15)
        (begin
          (set! c.92 rdi)
          (begin
            (set! fun/error15417.4 (mref c.92 14))
            (begin
              (set! rdi fun/error15417.4)
              (set! r15 tmp-ra.131)
              (jump L.fun/error15417.4.9 rbp r15 rdi))))))
    (define L.fun/pair15427.15.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.132 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! cons.76 (mref c.91 14))
            (begin
              (set! rdx 4088)
              (set! rsi 1976)
              (set! rdi cons.76)
              (set! r15 tmp-ra.132)
              (jump L.cons.76.8 rbp r15 rdi rsi rdx))))))
    (define L.fun/any15414.14.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.133 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/any15415.5 (mref c.90 14))
            (begin
              (set! rdi fun/any15415.5)
              (set! r15 tmp-ra.133)
              (jump L.fun/any15415.5.10 rbp r15 rdi))))))
    (define L.fun/void15425.13.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.134 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.134 rbp rax))))))
    (define L.fun/error15422.12.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.135 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! fun/error15423.7 (mref c.88 14))
            (begin
              (set! rdi fun/error15423.7)
              (set! r15 tmp-ra.135)
              (jump L.fun/error15423.7.12 rbp r15 rdi))))))
    (define L.fun/error15419.11.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.136 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 58686) (jump tmp-ra.136 rbp rax))))))
    (define L.fun/error15418.10.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.137 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! fun/error15419.11 (mref c.86 14))
            (begin
              (set! rdi fun/error15419.11)
              (set! r15 tmp-ra.137)
              (jump L.fun/error15419.11.16 rbp r15 rdi))))))
    (define L.fun/error15421.9.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.138 r15)
        (begin
          (set! c.85 rdi)
          (begin (begin (set! rax 9534) (jump tmp-ra.138 rbp rax))))))
    (define L.fun/void15424.8.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.139 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! fun/void15425.13 (mref c.84 14))
            (begin
              (set! rdi fun/void15425.13)
              (set! r15 tmp-ra.139)
              (jump L.fun/void15425.13.18 rbp r15 rdi))))))
    (define L.fun/error15423.7.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.140 r15)
        (begin
          (set! c.83 rdi)
          (begin (begin (set! rax 22590) (jump tmp-ra.140 rbp rax))))))
    (define L.fun/pair15426.6.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.141 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/pair15427.15 (mref c.82 14))
            (begin
              (set! rdi fun/pair15427.15)
              (set! r15 tmp-ra.141)
              (jump L.fun/pair15427.15.20 rbp r15 rdi))))))
    (define L.fun/any15415.5.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.142 r15)
        (begin
          (set! c.81 rdi)
          (begin (begin (set! rax 6) (jump tmp-ra.142 rbp rax))))))
    (define L.fun/error15417.4.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.143 r15)
        (begin
          (set! c.80 rdi)
          (begin (begin (set! rax 6718) (jump tmp-ra.143 rbp rax))))))
    (define L.cons.76.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.144 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.71 rsi)
          (set! tmp.72 rdx)
          (begin
            (begin
              (begin (set! tmp.111 (alloc 16)) (set! tmp.94 (+ tmp.111 1)))
              (begin
                (mset! tmp.94 -1 tmp.71)
                (mset! tmp.94 7 tmp.72)
                (begin (set! rax tmp.94) (jump tmp-ra.144 rbp rax))))))))
    (define L.ascii-char?.77.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.145 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.65 rsi)
          (begin
            (if (begin (set! tmp.112 (bitwise-and tmp.65 255)) (= tmp.112 46))
              (begin (set! rax 14) (jump tmp-ra.145 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.145 rbp rax)))))))
    (begin
      (set! tmp-ra.146 r15)
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
              (begin
                (return-point L.rp.23
                  (begin
                    (set! rdi fun/any15414.14)
                    (set! r15 L.rp.23)
                    (jump L.fun/any15414.14.19 rbp r15 rdi)))
                (set! tmp.129 rax))
              (begin
                (return-point L.rp.24
                  (begin
                    (set! rsi tmp.129)
                    (set! rdi ascii-char?.77)
                    (set! r15 L.rp.24)
                    (jump L.ascii-char?.77.7 rbp r15 rdi rsi)))
                (set! boolean0.23 rax)))
            (begin
              (return-point L.rp.25
                (begin
                  (set! rdi fun/error15416.16)
                  (set! r15 L.rp.25)
                  (jump L.fun/error15416.16.21 rbp r15 rdi)))
              (set! error1.22 rax))
            (begin
              (return-point L.rp.26
                (begin
                  (set! rdi fun/error15418.10)
                  (set! r15 L.rp.26)
                  (jump L.fun/error15418.10.15 rbp r15 rdi)))
              (set! error2.21 rax))
            (begin
              (return-point L.rp.27
                (begin
                  (set! rdi fun/error15420.17)
                  (set! r15 L.rp.27)
                  (jump L.fun/error15420.17.22 rbp r15 rdi)))
              (set! error3.20 rax))
            (begin
              (return-point L.rp.28
                (begin
                  (set! rdi fun/error15422.12)
                  (set! r15 L.rp.28)
                  (jump L.fun/error15422.12.17 rbp r15 rdi)))
              (set! error4.19 rax))
            (begin
              (return-point L.rp.29
                (begin
                  (set! rdi fun/void15424.8)
                  (set! r15 L.rp.29)
                  (jump L.fun/void15424.8.13 rbp r15 rdi)))
              (set! void5.18 rax))
            (begin
              (set! rdi fun/pair15426.6)
              (set! r15 tmp-ra.146)
              (jump L.fun/pair15426.6.11 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () ())))
    (define L.fun/ascii-char16443.15.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.149 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/ascii-char16444.5 (mref c.91 14))
            (begin
              (set! rdi fun/ascii-char16444.5)
              (set! r15 tmp-ra.149)
              (jump L.fun/ascii-char16444.5.11 rbp r15 rdi))))))
    (define L.fun/void16440.14.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.150 r15)
        (begin
          (set! c.90 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.150 rbp rax))))))
    (define L.fun/error16434.13.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.151 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 61246) (jump tmp-ra.151 rbp rax))))))
    (define L.fun/ascii-char16441.12.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.152 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! fun/ascii-char16442.11 (mref c.88 14))
            (begin
              (set! rdi fun/ascii-char16442.11)
              (set! r15 tmp-ra.152)
              (jump L.fun/ascii-char16442.11.17 rbp r15 rdi))))))
    (define L.fun/ascii-char16442.11.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.153 r15)
        (begin
          (set! c.87 rdi)
          (begin (begin (set! rax 24622) (jump tmp-ra.153 rbp rax))))))
    (define L.fun/ascii-char16436.10.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.154 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 23342) (jump tmp-ra.154 rbp rax))))))
    (define L.fun/ascii-char16438.9.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.155 r15)
        (begin
          (set! c.85 rdi)
          (begin (begin (set! rax 18478) (jump tmp-ra.155 rbp rax))))))
    (define L.fun/error16433.8.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! fun/error16434.13 (mref c.84 14))
            (begin
              (set! rdi fun/error16434.13)
              (set! r15 tmp-ra.156)
              (jump L.fun/error16434.13.19 rbp r15 rdi))))))
    (define L.fun/ascii-char16437.7.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.157 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/ascii-char16438.9 (mref c.83 14))
            (begin
              (set! rdi fun/ascii-char16438.9)
              (set! r15 tmp-ra.157)
              (jump L.fun/ascii-char16438.9.15 rbp r15 rdi))))))
    (define L.fun/void16439.6.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.82 rdi)
          (begin
            (set! fun/void16440.14 (mref c.82 14))
            (begin
              (set! rdi fun/void16440.14)
              (set! r15 tmp-ra.158)
              (jump L.fun/void16440.14.20 rbp r15 rdi))))))
    (define L.fun/ascii-char16444.5.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.81 rdi)
          (begin (begin (set! rax 25902) (jump tmp-ra.159 rbp rax))))))
    (define L.fun/ascii-char16435.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.80 rdi)
          (begin
            (set! fun/ascii-char16436.10 (mref c.80 14))
            (begin
              (set! rdi fun/ascii-char16436.10)
              (set! r15 tmp-ra.160)
              (jump L.fun/ascii-char16436.10.16 rbp r15 rdi))))))
    (define L.*.74.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.108 (bitwise-and tmp.37 7))
                        (= tmp.108 0))
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
                  (begin
                    (set! rax (* tmp.36 tmp.111))
                    (jump tmp-ra.161 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.161 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.161 rbp rax)))))))
    (define L.-.75.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.40 rsi)
          (set! tmp.41 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.113 (bitwise-and tmp.41 7))
                        (= tmp.113 0))
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
                (begin (set! rax (- tmp.40 tmp.41)) (jump tmp-ra.162 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.162 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.162 rbp rax)))))))
    (define L.+.76.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.117 (bitwise-and tmp.39 7))
                        (= tmp.117 0))
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
                (begin (set! rax (+ tmp.38 tmp.39)) (jump tmp-ra.163 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.163 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.163 rbp rax)))))))
    (begin
      (set! tmp-ra.164 r15)
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
            (begin
              (return-point L.rp.22
                (begin
                  (set! rdi fun/error16433.8)
                  (set! r15 L.rp.22)
                  (jump L.fun/error16433.8.14 rbp r15 rdi)))
              (set! error0.21 rax))
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/ascii-char16435.4)
                  (set! r15 L.rp.23)
                  (jump L.fun/ascii-char16435.4.10 rbp r15 rdi)))
              (set! ascii-char1.20 rax))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.24
                      (begin
                        (set! rdx 368)
                        (set! rsi 1920)
                        (set! rdi *.74)
                        (set! r15 L.rp.24)
                        (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.137 rax))
                  (begin
                    (begin
                      (return-point L.rp.25
                        (begin
                          (set! rdx 896)
                          (set! rsi 1504)
                          (set! rdi |-.75|)
                          (set! r15 L.rp.25)
                          (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.138 rax))
                    (begin
                      (return-point L.rp.26
                        (begin
                          (set! rdx tmp.138)
                          (set! rsi tmp.137)
                          (set! rdi |-.75|)
                          (set! r15 L.rp.26)
                          (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.136 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.27
                        (begin
                          (set! rdx 1680)
                          (set! rsi 280)
                          (set! rdi *.74)
                          (set! r15 L.rp.27)
                          (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.140 rax))
                    (begin
                      (begin
                        (return-point L.rp.28
                          (begin
                            (set! rdx 2032)
                            (set! rsi 856)
                            (set! rdi |+.76|)
                            (set! r15 L.rp.28)
                            (jump L.+.76.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.141 rax))
                      (begin
                        (return-point L.rp.29
                          (begin
                            (set! rdx tmp.141)
                            (set! rsi tmp.140)
                            (set! rdi |-.75|)
                            (set! r15 L.rp.29)
                            (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.139 rax))))
                  (begin
                    (return-point L.rp.30
                      (begin
                        (set! rdx tmp.139)
                        (set! rsi tmp.136)
                        (set! rdi *.74)
                        (set! r15 L.rp.30)
                        (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.135 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx 1864)
                          (set! rsi 640)
                          (set! rdi |-.75|)
                          (set! r15 L.rp.31)
                          (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.144 rax))
                    (begin
                      (begin
                        (return-point L.rp.32
                          (begin
                            (set! rdx 1488)
                            (set! rsi 864)
                            (set! rdi *.74)
                            (set! r15 L.rp.32)
                            (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.145 rax))
                      (begin
                        (return-point L.rp.33
                          (begin
                            (set! rdx tmp.145)
                            (set! rsi tmp.144)
                            (set! rdi *.74)
                            (set! r15 L.rp.33)
                            (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.143 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.34
                          (begin
                            (set! rdx 1376)
                            (set! rsi 1872)
                            (set! rdi |-.75|)
                            (set! r15 L.rp.34)
                            (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.147 rax))
                      (begin
                        (begin
                          (return-point L.rp.35
                            (begin
                              (set! rdx 640)
                              (set! rsi 1432)
                              (set! rdi |+.76|)
                              (set! r15 L.rp.35)
                              (jump L.+.76.7 rbp r15 rdi rsi rdx)))
                          (set! tmp.148 rax))
                        (begin
                          (return-point L.rp.36
                            (begin
                              (set! rdx tmp.148)
                              (set! rsi tmp.147)
                              (set! rdi |-.75|)
                              (set! r15 L.rp.36)
                              (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                          (set! tmp.146 rax))))
                    (begin
                      (return-point L.rp.37
                        (begin
                          (set! rdx tmp.146)
                          (set! rsi tmp.143)
                          (set! rdi |-.75|)
                          (set! r15 L.rp.37)
                          (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.142 rax))))
                (begin
                  (return-point L.rp.38
                    (begin
                      (set! rdx tmp.142)
                      (set! rsi tmp.135)
                      (set! rdi |+.76|)
                      (set! r15 L.rp.38)
                      (jump L.+.76.7 rbp r15 rdi rsi rdx)))
                  (set! fixnum2.19 rax))))
            (begin
              (return-point L.rp.39
                (begin
                  (set! rdi fun/ascii-char16437.7)
                  (set! r15 L.rp.39)
                  (jump L.fun/ascii-char16437.7.13 rbp r15 rdi)))
              (set! ascii-char3.18 rax))
            (begin
              (return-point L.rp.40
                (begin
                  (set! rdi fun/void16439.6)
                  (set! r15 L.rp.40)
                  (jump L.fun/void16439.6.12 rbp r15 rdi)))
              (set! void4.17 rax))
            (begin
              (return-point L.rp.41
                (begin
                  (set! rdi fun/ascii-char16441.12)
                  (set! r15 L.rp.41)
                  (jump L.fun/ascii-char16441.12.18 rbp r15 rdi)))
              (set! ascii-char5.16 rax))
            (begin
              (set! rdi fun/ascii-char16443.15)
              (set! r15 tmp-ra.164)
              (jump L.fun/ascii-char16443.15.21 rbp r15 rdi))))))))
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
       ())))
    (define L.fun/error16486.12.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.190 r15)
        (begin
          (set! c.107 rdi)
          (begin (begin (set! rax 57662) (jump tmp-ra.190 rbp rax))))))
    (define L.fun/empty16490.11.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.191 r15)
        (begin
          (set! c.106 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.191 rbp rax))))))
    (define L.fun/error16485.10.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.192 r15)
        (begin
          (set! c.105 rdi)
          (begin (begin (set! rax 60734) (jump tmp-ra.192 rbp rax))))))
    (define L.fun/empty16489.9.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.193 r15)
        (begin
          (set! c.104 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.193 rbp rax))))))
    (define L.fun/any16488.8.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.194 r15)
        (begin
          (set! c.103 rdi)
          (begin (begin (set! rax 544) (jump tmp-ra.194 rbp rax))))))
    (define L.fun/empty16487.7.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.195 r15)
        (begin
          (set! c.102 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.195 rbp rax))))))
    (define L.fun/vector16484.6.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.196 r15)
        (begin
          (set! c.101 rdi)
          (begin
            (set! make-vector.83 (mref c.101 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.83)
              (set! r15 tmp-ra.196)
              (jump L.make-vector.83.15 rbp r15 rdi rsi))))))
    (define L.fun/empty16491.5.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.197 r15)
        (begin
          (set! c.100 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.197 rbp rax))))))
    (define L.fun/ascii-char16492.4.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.198 r15)
        (begin
          (set! c.99 rdi)
          (begin (begin (set! rax 26670) (jump tmp-ra.198 rbp rax))))))
    (define L.make-vector.83.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.199 r15)
        (begin
          (set! c.98 rdi)
          (set! tmp.59 rsi)
          (begin
            (set! make-init-vector.1 (mref c.98 14))
            (if (begin
                  (if (begin
                        (set! tmp.128 (bitwise-and tmp.59 7))
                        (= tmp.128 0))
                    (set! tmp.127 14)
                    (set! tmp.127 6))
                  (!= tmp.127 6))
              (begin
                (set! rsi tmp.59)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.199)
                (jump L.make-init-vector.1.14 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.199 rbp rax)))))))
    (define L.make-init-vector.1.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.200 r15)
        (begin
          (set! c.97 rdi)
          (set! tmp.31 rsi)
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
              (begin
                (set! rcx tmp.32)
                (set! rdx 0)
                (set! rsi tmp.31)
                (set! rdi vector-init-loop.33)
                (set! r15 tmp-ra.200)
                (jump L.vector-init-loop.33.13 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.33.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.201 r15)
        (begin
          (set! c.96 rdi)
          (set! len.34 rsi)
          (set! i.36 rdx)
          (set! vec.35 rcx)
          (begin
            (set! vector-init-loop.33 (mref c.96 14))
            (if (begin
                  (if (= len.34 i.36) (set! tmp.133 14) (set! tmp.133 6))
                  (!= tmp.133 6))
              (begin (set! rax vec.35) (jump tmp-ra.201 rbp rax))
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
                  (begin
                    (set! rcx vec.35)
                    (set! rdx tmp.137)
                    (set! rsi len.34)
                    (set! rdi vector-init-loop.33)
                    (set! r15 tmp-ra.201)
                    (jump
                     L.vector-init-loop.33.13
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.-.84.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.202 r15)
        (begin
          (set! c.95 rdi)
          (set! tmp.49 rsi)
          (set! tmp.50 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.139 (bitwise-and tmp.50 7))
                        (= tmp.139 0))
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
                (begin (set! rax (- tmp.49 tmp.50)) (jump tmp-ra.202 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.202 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.202 rbp rax)))))))
    (define L.+.85.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.203 r15)
        (begin
          (set! c.94 rdi)
          (set! tmp.47 rsi)
          (set! tmp.48 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.143 (bitwise-and tmp.48 7))
                        (= tmp.143 0))
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
                (begin (set! rax (+ tmp.47 tmp.48)) (jump tmp-ra.203 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.203 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.203 rbp rax)))))))
    (define L.<=.86.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.204 r15)
        (begin
          (set! c.93 rdi)
          (set! tmp.53 rsi)
          (set! tmp.54 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.147 (bitwise-and tmp.54 7))
                        (= tmp.147 0))
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
                (if (<= tmp.53 tmp.54)
                  (begin (set! rax 14) (jump tmp-ra.204 rbp rax))
                  (begin (set! rax 6) (jump tmp-ra.204 rbp rax)))
                (begin (set! rax 1342) (jump tmp-ra.204 rbp rax)))
              (begin (set! rax 1342) (jump tmp-ra.204 rbp rax)))))))
    (define L.boolean?.87.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.205 r15)
        (begin
          (set! c.92 rdi)
          (set! tmp.69 rsi)
          (begin
            (if (begin (set! tmp.150 (bitwise-and tmp.69 247)) (= tmp.150 6))
              (begin (set! rax 14) (jump tmp-ra.205 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.205 rbp rax)))))))
    (define L.*.88.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.206 r15)
        (begin
          (set! c.91 rdi)
          (set! tmp.45 rsi)
          (set! tmp.46 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.152 (bitwise-and tmp.46 7))
                        (= tmp.152 0))
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
                  (begin
                    (set! rax (* tmp.45 tmp.155))
                    (jump tmp-ra.206 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.206 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.206 rbp rax)))))))
    (define L.>.89.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.207 r15)
        (begin
          (set! c.90 rdi)
          (set! tmp.55 rsi)
          (set! tmp.56 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.157 (bitwise-and tmp.56 7))
                        (= tmp.157 0))
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
                (if (> tmp.55 tmp.56)
                  (begin (set! rax 14) (jump tmp-ra.207 rbp rax))
                  (begin (set! rax 6) (jump tmp-ra.207 rbp rax)))
                (begin (set! rax 1598) (jump tmp-ra.207 rbp rax)))
              (begin (set! rax 1598) (jump tmp-ra.207 rbp rax)))))))
    (begin
      (set! tmp-ra.208 r15)
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
                  (begin
                    (return-point L.rp.25
                      (begin
                        (set! rdx 1600)
                        (set! rsi 712)
                        (set! rdi |-.84|)
                        (set! r15 L.rp.25)
                        (jump L.-.84.12 rbp r15 rdi rsi rdx)))
                    (set! tmp.178 rax))
                  (begin
                    (begin
                      (return-point L.rp.26
                        (begin
                          (set! rdx 1928)
                          (set! rsi 304)
                          (set! rdi |+.85|)
                          (set! r15 L.rp.26)
                          (jump L.+.85.11 rbp r15 rdi rsi rdx)))
                      (set! tmp.179 rax))
                    (begin
                      (return-point L.rp.27
                        (begin
                          (set! rdx tmp.179)
                          (set! rsi tmp.178)
                          (set! rdi |-.84|)
                          (set! r15 L.rp.27)
                          (jump L.-.84.12 rbp r15 rdi rsi rdx)))
                      (set! fixnum0.18 rax))))
                (begin
                  (return-point L.rp.28
                    (begin
                      (set! rdi fun/vector16484.6)
                      (set! r15 L.rp.28)
                      (jump L.fun/vector16484.6.18 rbp r15 rdi)))
                  (set! vector1.17 rax))
                (begin
                  (return-point L.rp.29
                    (begin
                      (set! rdi fun/error16485.10)
                      (set! r15 L.rp.29)
                      (jump L.fun/error16485.10.22 rbp r15 rdi)))
                  (set! error2.16 rax))
                (begin
                  (return-point L.rp.30
                    (begin
                      (set! rdi fun/error16486.12)
                      (set! r15 L.rp.30)
                      (jump L.fun/error16486.12.24 rbp r15 rdi)))
                  (set! error3.15 rax))
                (begin
                  (return-point L.rp.31
                    (begin
                      (set! rdi fun/empty16487.7)
                      (set! r15 L.rp.31)
                      (jump L.fun/empty16487.7.19 rbp r15 rdi)))
                  (set! empty4.14 rax))
                (begin
                  (begin
                    (return-point L.rp.32
                      (begin
                        (set! rdx 1376)
                        (set! rsi 1480)
                        (set! rdi |-.84|)
                        (set! r15 L.rp.32)
                        (jump L.-.84.12 rbp r15 rdi rsi rdx)))
                    (set! tmp.180 rax))
                  (begin
                    (begin
                      (return-point L.rp.33
                        (begin
                          (set! rdx 1384)
                          (set! rsi 1088)
                          (set! rdi |+.85|)
                          (set! r15 L.rp.33)
                          (jump L.+.85.11 rbp r15 rdi rsi rdx)))
                      (set! tmp.181 rax))
                    (begin
                      (return-point L.rp.34
                        (begin
                          (set! rdx tmp.181)
                          (set! rsi tmp.180)
                          (set! rdi <=.86)
                          (set! r15 L.rp.34)
                          (jump L.<=.86.10 rbp r15 rdi rsi rdx)))
                      (set! boolean5.13 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.35
                        (begin
                          (set! rdi fun/any16488.8)
                          (set! r15 L.rp.35)
                          (jump L.fun/any16488.8.20 rbp r15 rdi)))
                      (set! tmp.183 rax))
                    (begin
                      (return-point L.rp.36
                        (begin
                          (set! rsi tmp.183)
                          (set! rdi boolean?.87)
                          (set! r15 L.rp.36)
                          (jump L.boolean?.87.9 rbp r15 rdi rsi)))
                      (set! tmp.182 rax)))
                  (!= tmp.182 6)))
            (if (if (!= 14 6) (!= 6 6) (!= 6 6))
              (begin
                (set! ascii-char0.24 24366)
                (set! ascii-char1.23 16686)
                (set! boolean2.22 6)
                (set! void3.21 30)
                (set! boolean4.20 6)
                (set! empty5.19 22)
                (begin (set! rax 21806) (jump tmp-ra.208 rbp rax)))
              (if (!= 14 6)
                (begin (set! rax 30254) (jump tmp-ra.208 rbp rax))
                (begin (set! rax 21806) (jump tmp-ra.208 rbp rax))))
            (begin
              (begin
                (return-point L.rp.37
                  (begin
                    (set! rdi fun/empty16489.9)
                    (set! r15 L.rp.37)
                    (jump L.fun/empty16489.9.21 rbp r15 rdi)))
                (set! empty0.30 rax))
              (begin
                (begin
                  (return-point L.rp.38
                    (begin
                      (set! rdx 1672)
                      (set! rsi 424)
                      (set! rdi *.88)
                      (set! r15 L.rp.38)
                      (jump L.*.88.8 rbp r15 rdi rsi rdx)))
                  (set! tmp.184 rax))
                (begin
                  (begin
                    (return-point L.rp.39
                      (begin
                        (set! rdx 920)
                        (set! rsi 16)
                        (set! rdi *.88)
                        (set! r15 L.rp.39)
                        (jump L.*.88.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.185 rax))
                  (begin
                    (return-point L.rp.40
                      (begin
                        (set! rdx tmp.185)
                        (set! rsi tmp.184)
                        (set! rdi |-.84|)
                        (set! r15 L.rp.40)
                        (jump L.-.84.12 rbp r15 rdi rsi rdx)))
                    (set! fixnum1.29 rax))))
              (begin
                (begin
                  (return-point L.rp.41
                    (begin
                      (set! rdx 176)
                      (set! rsi 752)
                      (set! rdi *.88)
                      (set! r15 L.rp.41)
                      (jump L.*.88.8 rbp r15 rdi rsi rdx)))
                  (set! tmp.186 rax))
                (begin
                  (begin
                    (return-point L.rp.42
                      (begin
                        (set! rdx 680)
                        (set! rsi 712)
                        (set! rdi |+.85|)
                        (set! r15 L.rp.42)
                        (jump L.+.85.11 rbp r15 rdi rsi rdx)))
                    (set! tmp.187 rax))
                  (begin
                    (return-point L.rp.43
                      (begin
                        (set! rdx tmp.187)
                        (set! rsi tmp.186)
                        (set! rdi >.89)
                        (set! r15 L.rp.43)
                        (jump L.>.89.7 rbp r15 rdi rsi rdx)))
                    (set! boolean2.28 rax))))
              (begin
                (return-point L.rp.44
                  (begin
                    (set! rdi fun/empty16490.11)
                    (set! r15 L.rp.44)
                    (jump L.fun/empty16490.11.23 rbp r15 rdi)))
                (set! empty3.27 rax))
              (begin
                (begin
                  (return-point L.rp.45
                    (begin
                      (set! rdx 504)
                      (set! rsi 136)
                      (set! rdi |-.84|)
                      (set! r15 L.rp.45)
                      (jump L.-.84.12 rbp r15 rdi rsi rdx)))
                  (set! tmp.188 rax))
                (begin
                  (begin
                    (return-point L.rp.46
                      (begin
                        (set! rdx 40)
                        (set! rsi 1176)
                        (set! rdi *.88)
                        (set! r15 L.rp.46)
                        (jump L.*.88.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.189 rax))
                  (begin
                    (return-point L.rp.47
                      (begin
                        (set! rdx tmp.189)
                        (set! rsi tmp.188)
                        (set! rdi |-.84|)
                        (set! r15 L.rp.47)
                        (jump L.-.84.12 rbp r15 rdi rsi rdx)))
                    (set! fixnum4.26 rax))))
              (begin
                (return-point L.rp.48
                  (begin
                    (set! rdi fun/empty16491.5)
                    (set! r15 L.rp.48)
                    (jump L.fun/empty16491.5.17 rbp r15 rdi)))
                (set! empty5.25 rax))
              (begin
                (set! rdi fun/ascii-char16492.4)
                (set! r15 tmp-ra.208)
                (jump L.fun/ascii-char16492.4.16 rbp r15 rdi)))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () ())))
    (define L.fun/vector16594.17.25
      ((new-frames ()))
      (begin
        (set! tmp-ra.152 r15)
        (begin
          (set! c.97 rdi)
          (begin
            (set! fun/vector16595.8 (mref c.97 14))
            (begin
              (set! rdi fun/vector16595.8)
              (set! r15 tmp-ra.152)
              (jump L.fun/vector16595.8.16 rbp r15 rdi))))))
    (define L.fun/void16600.16.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.153 r15)
        (begin
          (set! c.96 rdi)
          (begin
            (set! fun/void16601.9 (mref c.96 14))
            (begin
              (set! rdi fun/void16601.9)
              (set! r15 tmp-ra.153)
              (jump L.fun/void16601.9.17 rbp r15 rdi))))))
    (define L.fun/ascii-char16602.15.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.154 r15)
        (begin
          (set! c.95 rdi)
          (begin
            (set! fun/ascii-char16603.5 (mref c.95 14))
            (begin
              (set! rdi fun/ascii-char16603.5)
              (set! r15 tmp-ra.154)
              (jump L.fun/ascii-char16603.5.13 rbp r15 rdi))))))
    (define L.fun/ascii-char16596.14.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.155 r15)
        (begin
          (set! c.94 rdi)
          (begin
            (set! fun/ascii-char16597.10 (mref c.94 14))
            (begin
              (set! rdi fun/ascii-char16597.10)
              (set! r15 tmp-ra.155)
              (jump L.fun/ascii-char16597.10.18 rbp r15 rdi))))))
    (define L.fun/vector16593.13.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.93 rdi)
          (begin
            (set! make-vector.76 (mref c.93 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.76)
              (set! r15 tmp-ra.156)
              (jump L.make-vector.76.11 rbp r15 rdi rsi))))))
    (define L.fun/any16599.12.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.157 r15)
        (begin
          (set! c.92 rdi)
          (begin
            (set! cons.77 (mref c.92 14))
            (begin
              (set! rdx 4088)
              (set! rsi 1424)
              (set! rdi cons.77)
              (set! r15 tmp-ra.157)
              (jump L.cons.77.8 rbp r15 rdi rsi rdx))))))
    (define L.fun/vector16604.11.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/vector16605.7 (mref c.91 14))
            (begin
              (set! rdi fun/vector16605.7)
              (set! r15 tmp-ra.158)
              (jump L.fun/vector16605.7.15 rbp r15 rdi))))))
    (define L.fun/ascii-char16597.10.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.90 rdi)
          (begin (begin (set! rax 25390) (jump tmp-ra.159 rbp rax))))))
    (define L.fun/void16601.9.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.160 rbp rax))))))
    (define L.fun/vector16595.8.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! make-vector.76 (mref c.88 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.76)
              (set! r15 tmp-ra.161)
              (jump L.make-vector.76.11 rbp r15 rdi rsi))))))
    (define L.fun/vector16605.7.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! make-vector.76 (mref c.87 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.76)
              (set! r15 tmp-ra.162)
              (jump L.make-vector.76.11 rbp r15 rdi rsi))))))
    (define L.fun/vector16592.6.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.86 rdi)
          (begin
            (set! fun/vector16593.13 (mref c.86 14))
            (begin
              (set! rdi fun/vector16593.13)
              (set! r15 tmp-ra.163)
              (jump L.fun/vector16593.13.21 rbp r15 rdi))))))
    (define L.fun/ascii-char16603.5.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.164 r15)
        (begin
          (set! c.85 rdi)
          (begin (begin (set! rax 23854) (jump tmp-ra.164 rbp rax))))))
    (define L.fun/any16598.4.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.165 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! fun/any16599.12 (mref c.84 14))
            (begin
              (set! rdi fun/any16599.12)
              (set! r15 tmp-ra.165)
              (jump L.fun/any16599.12.20 rbp r15 rdi))))))
    (define L.make-vector.76.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.166 r15)
        (begin
          (set! c.83 rdi)
          (set! tmp.52 rsi)
          (begin
            (set! make-init-vector.1 (mref c.83 14))
            (if (begin
                  (if (begin
                        (set! tmp.120 (bitwise-and tmp.52 7))
                        (= tmp.120 0))
                    (set! tmp.119 14)
                    (set! tmp.119 6))
                  (!= tmp.119 6))
              (begin
                (set! rsi tmp.52)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.166)
                (jump L.make-init-vector.1.10 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.166 rbp rax)))))))
    (define L.make-init-vector.1.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.167 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.24 rsi)
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
              (begin
                (set! rcx tmp.25)
                (set! rdx 0)
                (set! rsi tmp.24)
                (set! rdi vector-init-loop.26)
                (set! r15 tmp-ra.167)
                (jump L.vector-init-loop.26.9 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.26.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.168 r15)
        (begin
          (set! c.81 rdi)
          (set! len.27 rsi)
          (set! i.29 rdx)
          (set! vec.28 rcx)
          (begin
            (set! vector-init-loop.26 (mref c.81 14))
            (if (begin
                  (if (= len.27 i.29) (set! tmp.125 14) (set! tmp.125 6))
                  (!= tmp.125 6))
              (begin (set! rax vec.28) (jump tmp-ra.168 rbp rax))
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
                  (begin
                    (set! rcx vec.28)
                    (set! rdx tmp.129)
                    (set! rsi len.27)
                    (set! rdi vector-init-loop.26)
                    (set! r15 tmp-ra.168)
                    (jump
                     L.vector-init-loop.26.9
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.cons.77.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.169 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.71 rsi)
          (set! tmp.72 rdx)
          (begin
            (begin
              (begin (set! tmp.130 (alloc 16)) (set! tmp.99 (+ tmp.130 1)))
              (begin
                (mset! tmp.99 -1 tmp.71)
                (mset! tmp.99 7 tmp.72)
                (begin (set! rax tmp.99) (jump tmp-ra.169 rbp rax))))))))
    (define L.procedure?.78.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.170 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.70 rsi)
          (begin
            (if (begin (set! tmp.131 (bitwise-and tmp.70 7)) (= tmp.131 2))
              (begin (set! rax 14) (jump tmp-ra.170 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.170 rbp rax)))))))
    (begin
      (set! tmp-ra.171 r15)
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
            (begin
              (return-point L.rp.26
                (begin
                  (set! rdi fun/vector16592.6)
                  (set! r15 L.rp.26)
                  (jump L.fun/vector16592.6.14 rbp r15 rdi)))
              (set! vector0.23 rax))
            (begin
              (return-point L.rp.27
                (begin
                  (set! rdi fun/vector16594.17)
                  (set! r15 L.rp.27)
                  (jump L.fun/vector16594.17.25 rbp r15 rdi)))
              (set! vector1.22 rax))
            (begin
              (return-point L.rp.28
                (begin
                  (set! rdi fun/ascii-char16596.14)
                  (set! r15 L.rp.28)
                  (jump L.fun/ascii-char16596.14.22 rbp r15 rdi)))
              (set! ascii-char2.21 rax))
            (begin
              (begin
                (return-point L.rp.29
                  (begin
                    (set! rdi fun/any16598.4)
                    (set! r15 L.rp.29)
                    (jump L.fun/any16598.4.12 rbp r15 rdi)))
                (set! tmp.151 rax))
              (begin
                (return-point L.rp.30
                  (begin
                    (set! rsi tmp.151)
                    (set! rdi procedure?.78)
                    (set! r15 L.rp.30)
                    (jump L.procedure?.78.7 rbp r15 rdi rsi)))
                (set! boolean3.20 rax)))
            (begin
              (return-point L.rp.31
                (begin
                  (set! rdi fun/void16600.16)
                  (set! r15 L.rp.31)
                  (jump L.fun/void16600.16.24 rbp r15 rdi)))
              (set! void4.19 rax))
            (begin
              (return-point L.rp.32
                (begin
                  (set! rdi fun/ascii-char16602.15)
                  (set! r15 L.rp.32)
                  (jump L.fun/ascii-char16602.15.23 rbp r15 rdi)))
              (set! ascii-char5.18 rax))
            (begin
              (set! rdi fun/vector16604.11)
              (set! r15 tmp-ra.171)
              (jump L.fun/vector16604.11.19 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () ())))
    (define L.lam.80.27
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.101 rdi)
          (begin
            (set! fun/empty17996.16 (mref c.101 14))
            (begin
              (set! rdi fun/empty17996.16)
              (set! r15 tmp-ra.162)
              (jump L.fun/empty17996.16.25 rbp r15 rdi))))))
    (define L.fun/ascii-char18009.17.26
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.100 rdi)
          (begin (begin (set! rax 18222) (jump tmp-ra.163 rbp rax))))))
    (define L.fun/empty17996.16.25
      ((new-frames ()))
      (begin
        (set! tmp-ra.164 r15)
        (begin
          (set! c.99 rdi)
          (begin
            (set! fun/empty17997.10 (mref c.99 14))
            (begin
              (set! rdi fun/empty17997.10)
              (set! r15 tmp-ra.164)
              (jump L.fun/empty17997.10.19 rbp r15 rdi))))))
    (define L.fun/vector18000.15.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.165 r15)
        (begin
          (set! c.98 rdi)
          (begin
            (set! fun/vector18001.4 (mref c.98 14))
            (begin
              (set! rdi fun/vector18001.4)
              (set! r15 tmp-ra.165)
              (jump L.fun/vector18001.4.13 rbp r15 rdi))))))
    (define L.fun/any18003.14.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.166 r15)
        (begin
          (set! c.97 rdi)
          (begin
            (set! cons.77 (mref c.97 14))
            (begin
              (set! rdx 2296)
              (set! rsi 784)
              (set! rdi cons.77)
              (set! r15 tmp-ra.166)
              (jump L.cons.77.9 rbp r15 rdi rsi rdx))))))
    (define L.fun/any18004.13.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.167 r15)
        (begin
          (set! c.96 rdi)
          (begin
            (set! fun/any18005.11 (mref c.96 14))
            (begin
              (set! rdi fun/any18005.11)
              (set! r15 tmp-ra.167)
              (jump L.fun/any18005.11.20 rbp r15 rdi))))))
    (define L.fun/void18007.12.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.168 r15)
        (begin
          (set! c.95 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.168 rbp rax))))))
    (define L.fun/any18005.11.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.169 r15)
        (begin
          (set! c.94 rdi)
          (begin (begin (set! rax 40510) (jump tmp-ra.169 rbp rax))))))
    (define L.fun/empty17997.10.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.170 r15)
        (begin
          (set! c.93 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.170 rbp rax))))))
    (define L.fun/any18002.9.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.171 r15)
        (begin
          (set! c.92 rdi)
          (begin
            (set! fun/any18003.14 (mref c.92 14))
            (begin
              (set! rdi fun/any18003.14)
              (set! r15 tmp-ra.171)
              (jump L.fun/any18003.14.23 rbp r15 rdi))))))
    (define L.fun/void18006.8.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.172 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/void18007.12 (mref c.91 14))
            (begin
              (set! rdi fun/void18007.12)
              (set! r15 tmp-ra.172)
              (jump L.fun/void18007.12.21 rbp r15 rdi))))))
    (define L.fun/ascii-char18008.7.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.173 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/ascii-char18009.17 (mref c.90 14))
            (begin
              (set! rdi fun/ascii-char18009.17)
              (set! r15 tmp-ra.173)
              (jump L.fun/ascii-char18009.17.26 rbp r15 rdi))))))
    (define L.fun/vector17998.6.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.174 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/vector17999.5 (mref c.89 14))
            (begin
              (set! rdi fun/vector17999.5)
              (set! r15 tmp-ra.174)
              (jump L.fun/vector17999.5.14 rbp r15 rdi))))))
    (define L.fun/vector17999.5.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.175 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! make-vector.76 (mref c.88 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.76)
              (set! r15 tmp-ra.175)
              (jump L.make-vector.76.12 rbp r15 rdi rsi))))))
    (define L.fun/vector18001.4.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.176 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! make-vector.76 (mref c.87 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.76)
              (set! r15 tmp-ra.176)
              (jump L.make-vector.76.12 rbp r15 rdi rsi))))))
    (define L.make-vector.76.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.177 r15)
        (begin
          (set! c.86 rdi)
          (set! tmp.52 rsi)
          (begin
            (set! make-init-vector.1 (mref c.86 14))
            (if (begin
                  (if (begin
                        (set! tmp.126 (bitwise-and tmp.52 7))
                        (= tmp.126 0))
                    (set! tmp.125 14)
                    (set! tmp.125 6))
                  (!= tmp.125 6))
              (begin
                (set! rsi tmp.52)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.177)
                (jump L.make-init-vector.1.11 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.177 rbp rax)))))))
    (define L.make-init-vector.1.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.178 r15)
        (begin
          (set! c.85 rdi)
          (set! tmp.24 rsi)
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
              (begin
                (set! rcx tmp.25)
                (set! rdx 0)
                (set! rsi tmp.24)
                (set! rdi vector-init-loop.26)
                (set! r15 tmp-ra.178)
                (jump L.vector-init-loop.26.10 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.26.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.179 r15)
        (begin
          (set! c.84 rdi)
          (set! len.27 rsi)
          (set! i.29 rdx)
          (set! vec.28 rcx)
          (begin
            (set! vector-init-loop.26 (mref c.84 14))
            (if (begin
                  (if (= len.27 i.29) (set! tmp.131 14) (set! tmp.131 6))
                  (!= tmp.131 6))
              (begin (set! rax vec.28) (jump tmp-ra.179 rbp rax))
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
                  (begin
                    (set! rcx vec.28)
                    (set! rdx tmp.135)
                    (set! rsi len.27)
                    (set! rdi vector-init-loop.26)
                    (set! r15 tmp-ra.179)
                    (jump
                     L.vector-init-loop.26.10
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.cons.77.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.180 r15)
        (begin
          (set! c.83 rdi)
          (set! tmp.71 rsi)
          (set! tmp.72 rdx)
          (begin
            (begin
              (begin (set! tmp.136 (alloc 16)) (set! tmp.103 (+ tmp.136 1)))
              (begin
                (mset! tmp.103 -1 tmp.71)
                (mset! tmp.103 7 tmp.72)
                (begin (set! rax tmp.103) (jump tmp-ra.180 rbp rax))))))))
    (define L.vector?.78.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.181 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.68 rsi)
          (begin
            (if (begin (set! tmp.137 (bitwise-and tmp.68 7)) (= tmp.137 3))
              (begin (set! rax 14) (jump tmp-ra.181 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.181 rbp rax)))))))
    (define L.void?.79.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.182 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.64 rsi)
          (begin
            (if (begin (set! tmp.138 (bitwise-and tmp.64 255)) (= tmp.138 30))
              (begin (set! rax 14) (jump tmp-ra.182 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.182 rbp rax)))))))
    (begin
      (set! tmp-ra.183 r15)
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
            (begin
              (return-point L.rp.28
                (begin
                  (set! rdi fun/vector17998.6)
                  (set! r15 L.rp.28)
                  (jump L.fun/vector17998.6.15 rbp r15 rdi)))
              (set! vector1.22 rax))
            (begin
              (return-point L.rp.29
                (begin
                  (set! rdi fun/vector18000.15)
                  (set! r15 L.rp.29)
                  (jump L.fun/vector18000.15.24 rbp r15 rdi)))
              (set! vector2.21 rax))
            (begin
              (begin
                (return-point L.rp.30
                  (begin
                    (set! rdi fun/any18002.9)
                    (set! r15 L.rp.30)
                    (jump L.fun/any18002.9.18 rbp r15 rdi)))
                (set! tmp.160 rax))
              (begin
                (return-point L.rp.31
                  (begin
                    (set! rsi tmp.160)
                    (set! rdi vector?.78)
                    (set! r15 L.rp.31)
                    (jump L.vector?.78.8 rbp r15 rdi rsi)))
                (set! boolean3.20 rax)))
            (begin
              (begin
                (return-point L.rp.32
                  (begin
                    (set! rdi fun/any18004.13)
                    (set! r15 L.rp.32)
                    (jump L.fun/any18004.13.22 rbp r15 rdi)))
                (set! tmp.161 rax))
              (begin
                (return-point L.rp.33
                  (begin
                    (set! rsi tmp.161)
                    (set! rdi void?.79)
                    (set! r15 L.rp.33)
                    (jump L.void?.79.7 rbp r15 rdi rsi)))
                (set! boolean4.19 rax)))
            (begin
              (return-point L.rp.34
                (begin
                  (set! rdi fun/void18006.8)
                  (set! r15 L.rp.34)
                  (jump L.fun/void18006.8.17 rbp r15 rdi)))
              (set! void5.18 rax))
            (begin
              (set! rdi fun/ascii-char18008.7)
              (set! r15 tmp-ra.183)
              (jump L.fun/ascii-char18008.7.16 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () ())))
    (define L.fun/void18495.15.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.149 r15)
        (begin
          (set! c.91 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.149 rbp rax))))))
    (define L.fun/void18488.14.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.150 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/void18489.10 (mref c.90 14))
            (begin
              (set! rdi fun/void18489.10)
              (set! r15 tmp-ra.150)
              (jump L.fun/void18489.10.16 rbp r15 rdi))))))
    (define L.fun/ascii-char18493.13.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.151 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 20782) (jump tmp-ra.151 rbp rax))))))
    (define L.fun/error18496.12.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.152 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! fun/error18497.6 (mref c.88 14))
            (begin
              (set! rdi fun/error18497.6)
              (set! r15 tmp-ra.152)
              (jump L.fun/error18497.6.12 rbp r15 rdi))))))
    (define L.fun/empty18498.11.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.153 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! fun/empty18499.5 (mref c.87 14))
            (begin
              (set! rdi fun/empty18499.5)
              (set! r15 tmp-ra.153)
              (jump L.fun/empty18499.5.11 rbp r15 rdi))))))
    (define L.fun/void18489.10.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.154 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.154 rbp rax))))))
    (define L.fun/void18494.9.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.155 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/void18495.15 (mref c.85 14))
            (begin
              (set! rdi fun/void18495.15)
              (set! r15 tmp-ra.155)
              (jump L.fun/void18495.15.21 rbp r15 rdi))))))
    (define L.fun/error18491.8.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.156 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 47678) (jump tmp-ra.156 rbp rax))))))
    (define L.fun/ascii-char18492.7.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.157 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! fun/ascii-char18493.13 (mref c.83 14))
            (begin
              (set! rdi fun/ascii-char18493.13)
              (set! r15 tmp-ra.157)
              (jump L.fun/ascii-char18493.13.19 rbp r15 rdi))))))
    (define L.fun/error18497.6.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.158 r15)
        (begin
          (set! c.82 rdi)
          (begin (begin (set! rax 25150) (jump tmp-ra.158 rbp rax))))))
    (define L.fun/empty18499.5.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.159 r15)
        (begin
          (set! c.81 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.159 rbp rax))))))
    (define L.fun/error18490.4.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.160 r15)
        (begin
          (set! c.80 rdi)
          (begin
            (set! fun/error18491.8 (mref c.80 14))
            (begin
              (set! rdi fun/error18491.8)
              (set! r15 tmp-ra.160)
              (jump L.fun/error18491.8.14 rbp r15 rdi))))))
    (define L.*.74.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.161 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.108 (bitwise-and tmp.37 7))
                        (= tmp.108 0))
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
                  (begin
                    (set! rax (* tmp.36 tmp.111))
                    (jump tmp-ra.161 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.161 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.161 rbp rax)))))))
    (define L.-.75.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.162 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.40 rsi)
          (set! tmp.41 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.113 (bitwise-and tmp.41 7))
                        (= tmp.113 0))
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
                (begin (set! rax (- tmp.40 tmp.41)) (jump tmp-ra.162 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.162 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.162 rbp rax)))))))
    (define L.+.76.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.163 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.117 (bitwise-and tmp.39 7))
                        (= tmp.117 0))
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
                (begin (set! rax (+ tmp.38 tmp.39)) (jump tmp-ra.163 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.163 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.163 rbp rax)))))))
    (begin
      (set! tmp-ra.164 r15)
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
            (begin
              (return-point L.rp.22
                (begin
                  (set! rdi fun/void18488.14)
                  (set! r15 L.rp.22)
                  (jump L.fun/void18488.14.20 rbp r15 rdi)))
              (set! void0.21 rax))
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/error18490.4)
                  (set! r15 L.rp.23)
                  (jump L.fun/error18490.4.10 rbp r15 rdi)))
              (set! error1.20 rax))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.24
                      (begin
                        (set! rdx 1000)
                        (set! rsi 704)
                        (set! rdi *.74)
                        (set! r15 L.rp.24)
                        (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.137 rax))
                  (begin
                    (begin
                      (return-point L.rp.25
                        (begin
                          (set! rdx 1240)
                          (set! rsi 1760)
                          (set! rdi |-.75|)
                          (set! r15 L.rp.25)
                          (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.138 rax))
                    (begin
                      (return-point L.rp.26
                        (begin
                          (set! rdx tmp.138)
                          (set! rsi tmp.137)
                          (set! rdi *.74)
                          (set! r15 L.rp.26)
                          (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.136 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.27
                        (begin
                          (set! rdx 1792)
                          (set! rsi 1152)
                          (set! rdi |-.75|)
                          (set! r15 L.rp.27)
                          (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.140 rax))
                    (begin
                      (begin
                        (return-point L.rp.28
                          (begin
                            (set! rdx 992)
                            (set! rsi 1488)
                            (set! rdi *.74)
                            (set! r15 L.rp.28)
                            (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.141 rax))
                      (begin
                        (return-point L.rp.29
                          (begin
                            (set! rdx tmp.141)
                            (set! rsi tmp.140)
                            (set! rdi |-.75|)
                            (set! r15 L.rp.29)
                            (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.139 rax))))
                  (begin
                    (return-point L.rp.30
                      (begin
                        (set! rdx tmp.139)
                        (set! rsi tmp.136)
                        (set! rdi |-.75|)
                        (set! r15 L.rp.30)
                        (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.135 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx 1520)
                          (set! rsi 776)
                          (set! rdi |-.75|)
                          (set! r15 L.rp.31)
                          (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.144 rax))
                    (begin
                      (begin
                        (return-point L.rp.32
                          (begin
                            (set! rdx 1176)
                            (set! rsi 1688)
                            (set! rdi *.74)
                            (set! r15 L.rp.32)
                            (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.145 rax))
                      (begin
                        (return-point L.rp.33
                          (begin
                            (set! rdx tmp.145)
                            (set! rsi tmp.144)
                            (set! rdi |-.75|)
                            (set! r15 L.rp.33)
                            (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.143 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.34
                          (begin
                            (set! rdx 1224)
                            (set! rsi 1400)
                            (set! rdi *.74)
                            (set! r15 L.rp.34)
                            (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.147 rax))
                      (begin
                        (begin
                          (return-point L.rp.35
                            (begin
                              (set! rdx 1272)
                              (set! rsi 1008)
                              (set! rdi *.74)
                              (set! r15 L.rp.35)
                              (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.148 rax))
                        (begin
                          (return-point L.rp.36
                            (begin
                              (set! rdx tmp.148)
                              (set! rsi tmp.147)
                              (set! rdi |+.76|)
                              (set! r15 L.rp.36)
                              (jump L.+.76.7 rbp r15 rdi rsi rdx)))
                          (set! tmp.146 rax))))
                    (begin
                      (return-point L.rp.37
                        (begin
                          (set! rdx tmp.146)
                          (set! rsi tmp.143)
                          (set! rdi |-.75|)
                          (set! r15 L.rp.37)
                          (jump L.-.75.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.142 rax))))
                (begin
                  (return-point L.rp.38
                    (begin
                      (set! rdx tmp.142)
                      (set! rsi tmp.135)
                      (set! rdi *.74)
                      (set! r15 L.rp.38)
                      (jump L.*.74.9 rbp r15 rdi rsi rdx)))
                  (set! fixnum2.19 rax))))
            (begin
              (return-point L.rp.39
                (begin
                  (set! rdi fun/ascii-char18492.7)
                  (set! r15 L.rp.39)
                  (jump L.fun/ascii-char18492.7.13 rbp r15 rdi)))
              (set! ascii-char3.18 rax))
            (begin
              (return-point L.rp.40
                (begin
                  (set! rdi fun/void18494.9)
                  (set! r15 L.rp.40)
                  (jump L.fun/void18494.9.15 rbp r15 rdi)))
              (set! void4.17 rax))
            (begin
              (return-point L.rp.41
                (begin
                  (set! rdi fun/error18496.12)
                  (set! r15 L.rp.41)
                  (jump L.fun/error18496.12.18 rbp r15 rdi)))
              (set! error5.16 rax))
            (begin
              (set! rdi fun/empty18498.11)
              (set! r15 tmp-ra.164)
              (jump L.fun/empty18498.11.17 rbp r15 rdi))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ())))
    (define L.fun/ascii-char22594.17.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.124 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/ascii-char22595.5 (mref c.91 14))
            (begin
              (set! rdi fun/ascii-char22595.5)
              (set! r15 tmp-ra.124)
              (jump L.fun/ascii-char22595.5.9 rbp r15 rdi))))))
    (define L.fun/empty22596.16.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.125 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/empty22597.10 (mref c.90 14))
            (begin
              (set! rdi fun/empty22597.10)
              (set! r15 tmp-ra.125)
              (jump L.fun/empty22597.10.14 rbp r15 rdi))))))
    (define L.fun/empty22598.15.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.126 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/empty22599.8 (mref c.89 14))
            (begin
              (set! rdi fun/empty22599.8)
              (set! r15 tmp-ra.126)
              (jump L.fun/empty22599.8.12 rbp r15 rdi))))))
    (define L.fun/error22592.14.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.127 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! fun/error22593.12 (mref c.88 14))
            (begin
              (set! rdi fun/error22593.12)
              (set! r15 tmp-ra.127)
              (jump L.fun/error22593.12.16 rbp r15 rdi))))))
    (define L.fun/pair22600.13.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.128 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! fun/pair22601.6 (mref c.87 14))
            (begin
              (set! rdi fun/pair22601.6)
              (set! r15 tmp-ra.128)
              (jump L.fun/pair22601.6.10 rbp r15 rdi))))))
    (define L.fun/error22593.12.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.129 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 5694) (jump tmp-ra.129 rbp rax))))))
    (define L.fun/ascii-char22588.11.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.130 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/ascii-char22589.7 (mref c.85 14))
            (begin
              (set! rdi fun/ascii-char22589.7)
              (set! r15 tmp-ra.130)
              (jump L.fun/ascii-char22589.7.11 rbp r15 rdi))))))
    (define L.fun/empty22597.10.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.131 r15)
        (begin
          (set! c.84 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.131 rbp rax))))))
    (define L.fun/empty22591.9.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.132 r15)
        (begin
          (set! c.83 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.132 rbp rax))))))
    (define L.fun/empty22599.8.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.133 r15)
        (begin
          (set! c.82 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.133 rbp rax))))))
    (define L.fun/ascii-char22589.7.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.134 r15)
        (begin
          (set! c.81 rdi)
          (begin (begin (set! rax 23342) (jump tmp-ra.134 rbp rax))))))
    (define L.fun/pair22601.6.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.135 r15)
        (begin
          (set! c.80 rdi)
          (begin
            (set! cons.76 (mref c.80 14))
            (begin
              (set! rdx 3704)
              (set! rsi 800)
              (set! rdi cons.76)
              (set! r15 tmp-ra.135)
              (jump L.cons.76.7 rbp r15 rdi rsi rdx))))))
    (define L.fun/ascii-char22595.5.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.136 r15)
        (begin
          (set! c.79 rdi)
          (begin (begin (set! rax 25134) (jump tmp-ra.136 rbp rax))))))
    (define L.fun/empty22590.4.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.137 r15)
        (begin
          (set! c.78 rdi)
          (begin
            (set! fun/empty22591.9 (mref c.78 14))
            (begin
              (set! rdi fun/empty22591.9)
              (set! r15 tmp-ra.137)
              (jump L.fun/empty22591.9.13 rbp r15 rdi))))))
    (define L.cons.76.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.138 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.71 rsi)
          (set! tmp.72 rdx)
          (begin
            (begin
              (begin (set! tmp.108 (alloc 16)) (set! tmp.92 (+ tmp.108 1)))
              (begin
                (mset! tmp.92 -1 tmp.71)
                (mset! tmp.92 7 tmp.72)
                (begin (set! rax tmp.92) (jump tmp-ra.138 rbp rax))))))))
    (begin
      (set! tmp-ra.139 r15)
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
            (begin
              (return-point L.rp.22
                (begin
                  (set! rdi fun/ascii-char22588.11)
                  (set! r15 L.rp.22)
                  (jump L.fun/ascii-char22588.11.15 rbp r15 rdi)))
              (set! ascii-char0.23 rax))
            (begin
              (return-point L.rp.23
                (begin
                  (set! rdi fun/empty22590.4)
                  (set! r15 L.rp.23)
                  (jump L.fun/empty22590.4.8 rbp r15 rdi)))
              (set! empty1.22 rax))
            (begin
              (return-point L.rp.24
                (begin
                  (set! rdi fun/error22592.14)
                  (set! r15 L.rp.24)
                  (jump L.fun/error22592.14.18 rbp r15 rdi)))
              (set! error2.21 rax))
            (begin
              (return-point L.rp.25
                (begin
                  (set! rdi fun/ascii-char22594.17)
                  (set! r15 L.rp.25)
                  (jump L.fun/ascii-char22594.17.21 rbp r15 rdi)))
              (set! ascii-char3.20 rax))
            (begin
              (return-point L.rp.26
                (begin
                  (set! rdi fun/empty22596.16)
                  (set! r15 L.rp.26)
                  (jump L.fun/empty22596.16.20 rbp r15 rdi)))
              (set! empty4.19 rax))
            (begin
              (return-point L.rp.27
                (begin
                  (set! rdi fun/empty22598.15)
                  (set! r15 L.rp.27)
                  (jump L.fun/empty22598.15.19 rbp r15 rdi)))
              (set! empty5.18 rax))
            (begin
              (set! rdi fun/pair22600.13)
              (set! r15 tmp-ra.139)
              (jump L.fun/pair22600.13.17 rbp r15 rdi))))))))
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
       ())))
    (define L.lam.76.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.187 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/void23352.11 (mref c.91 14))
            (begin
              (set! rdi fun/void23352.11)
              (set! r15 tmp-ra.187)
              (jump L.fun/void23352.11.19 rbp r15 rdi))))))
    (define L.lam.75.20
      ((new-frames (() () () () () () () () () () () () () ())))
      (begin
        (set! tmp-ra.188 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! *.74 (mref c.90 14))
            (set! |-.72| (mref c.90 22))
            (set! |+.73| (mref c.90 30))
            (begin
              (begin
                (begin
                  (begin
                    (return-point L.rp.22
                      (begin
                        (set! rdx 944)
                        (set! rsi 1912)
                        (set! rdi |-.72|)
                        (set! r15 L.rp.22)
                        (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.110 rax))
                  (begin
                    (begin
                      (return-point L.rp.23
                        (begin
                          (set! rdx 1224)
                          (set! rsi 304)
                          (set! rdi |-.72|)
                          (set! r15 L.rp.23)
                          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.111 rax))
                    (begin
                      (return-point L.rp.24
                        (begin
                          (set! rdx tmp.111)
                          (set! rsi tmp.110)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.24)
                          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.109 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.25
                        (begin
                          (set! rdx 1432)
                          (set! rsi 1024)
                          (set! rdi *.74)
                          (set! r15 L.rp.25)
                          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.113 rax))
                    (begin
                      (begin
                        (return-point L.rp.26
                          (begin
                            (set! rdx 1736)
                            (set! rsi 1664)
                            (set! rdi |-.72|)
                            (set! r15 L.rp.26)
                            (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.114 rax))
                      (begin
                        (return-point L.rp.27
                          (begin
                            (set! rdx tmp.114)
                            (set! rsi tmp.113)
                            (set! rdi |+.73|)
                            (set! r15 L.rp.27)
                            (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.112 rax))))
                  (begin
                    (return-point L.rp.28
                      (begin
                        (set! rdx tmp.112)
                        (set! rsi tmp.109)
                        (set! rdi |+.73|)
                        (set! r15 L.rp.28)
                        (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                    (set! tmp.108 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.29
                        (begin
                          (set! rdx 1216)
                          (set! rsi 968)
                          (set! rdi |-.72|)
                          (set! r15 L.rp.29)
                          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.117 rax))
                    (begin
                      (begin
                        (return-point L.rp.30
                          (begin
                            (set! rdx 64)
                            (set! rsi 1696)
                            (set! rdi *.74)
                            (set! r15 L.rp.30)
                            (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.118 rax))
                      (begin
                        (return-point L.rp.31
                          (begin
                            (set! rdx tmp.118)
                            (set! rsi tmp.117)
                            (set! rdi |+.73|)
                            (set! r15 L.rp.31)
                            (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.116 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.32
                          (begin
                            (set! rdx 656)
                            (set! rsi 1400)
                            (set! rdi *.74)
                            (set! r15 L.rp.32)
                            (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.120 rax))
                      (begin
                        (begin
                          (return-point L.rp.33
                            (begin
                              (set! rdx 1432)
                              (set! rsi 416)
                              (set! rdi |-.72|)
                              (set! r15 L.rp.33)
                              (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.121 rax))
                        (begin
                          (return-point L.rp.34
                            (begin
                              (set! rdx tmp.121)
                              (set! rsi tmp.120)
                              (set! rdi *.74)
                              (set! r15 L.rp.34)
                              (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                          (set! tmp.119 rax))))
                    (begin
                      (return-point L.rp.35
                        (begin
                          (set! rdx tmp.119)
                          (set! rsi tmp.116)
                          (set! rdi |-.72|)
                          (set! r15 L.rp.35)
                          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.115 rax))))
                (begin
                  (set! rdx tmp.115)
                  (set! rsi tmp.108)
                  (set! rdi |+.73|)
                  (set! r15 tmp-ra.188)
                  (jump L.+.73.8 rbp r15 rdi rsi rdx))))))))
    (define L.fun/void23352.11.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.189 r15)
        (begin
          (set! c.89 rdi)
          (begin
            (set! fun/void23353.10 (mref c.89 14))
            (begin
              (set! rdi fun/void23353.10)
              (set! r15 tmp-ra.189)
              (jump L.fun/void23353.10.18 rbp r15 rdi))))))
    (define L.fun/void23353.10.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.190 r15)
        (begin
          (set! c.88 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.190 rbp rax))))))
    (define L.fun/ascii-char23346.9.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.191 r15)
        (begin
          (set! c.87 rdi)
          (begin
            (set! fun/ascii-char23347.8 (mref c.87 14))
            (begin
              (set! rdi fun/ascii-char23347.8)
              (set! r15 tmp-ra.191)
              (jump L.fun/ascii-char23347.8.16 rbp r15 rdi))))))
    (define L.fun/ascii-char23347.8.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.192 r15)
        (begin
          (set! c.86 rdi)
          (begin (begin (set! rax 23598) (jump tmp-ra.192 rbp rax))))))
    (define L.fun/any23350.7.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.193 r15)
        (begin
          (set! c.85 rdi)
          (begin
            (set! fun/any23351.5 (mref c.85 14))
            (begin
              (set! rdi fun/any23351.5)
              (set! r15 tmp-ra.193)
              (jump L.fun/any23351.5.13 rbp r15 rdi))))))
    (define L.fun/void23348.6.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.194 r15)
        (begin
          (set! c.84 rdi)
          (begin
            (set! fun/void23349.4 (mref c.84 14))
            (begin
              (set! rdi fun/void23349.4)
              (set! r15 tmp-ra.194)
              (jump L.fun/void23349.4.12 rbp r15 rdi))))))
    (define L.fun/any23351.5.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.195 r15)
        (begin
          (set! c.83 rdi)
          (begin
            (set! cons.70 (mref c.83 14))
            (begin
              (set! rdx 3184)
              (set! rsi 1272)
              (set! rdi cons.70)
              (set! r15 tmp-ra.195)
              (jump L.cons.70.11 rbp r15 rdi rsi rdx))))))
    (define L.fun/void23349.4.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.196 r15)
        (begin
          (set! c.82 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.196 rbp rax))))))
    (define L.cons.70.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.197 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.65 rsi)
          (set! tmp.66 rdx)
          (begin
            (begin
              (begin (set! tmp.122 (alloc 16)) (set! tmp.92 (+ tmp.122 1)))
              (begin
                (mset! tmp.92 -1 tmp.65)
                (mset! tmp.92 7 tmp.66)
                (begin (set! rax tmp.92) (jump tmp-ra.197 rbp rax))))))))
    (define L.boolean?.71.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.198 r15)
        (begin
          (set! c.80 rdi)
          (set! tmp.56 rsi)
          (begin
            (if (begin (set! tmp.123 (bitwise-and tmp.56 247)) (= tmp.123 6))
              (begin (set! rax 14) (jump tmp-ra.198 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.198 rbp rax)))))))
    (define L.-.72.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.199 r15)
        (begin
          (set! c.79 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.125 (bitwise-and tmp.37 7))
                        (= tmp.125 0))
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
                (begin (set! rax (- tmp.36 tmp.37)) (jump tmp-ra.199 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.199 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.199 rbp rax)))))))
    (define L.+.73.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.200 r15)
        (begin
          (set! c.78 rdi)
          (set! tmp.34 rsi)
          (set! tmp.35 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.129 (bitwise-and tmp.35 7))
                        (= tmp.129 0))
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
                (begin (set! rax (+ tmp.34 tmp.35)) (jump tmp-ra.200 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.200 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.200 rbp rax)))))))
    (define L.*.74.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.201 r15)
        (begin
          (set! c.77 rdi)
          (set! tmp.32 rsi)
          (set! tmp.33 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.133 (bitwise-and tmp.33 7))
                        (= tmp.133 0))
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
                  (begin
                    (set! rax (* tmp.32 tmp.136))
                    (jump tmp-ra.201 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.201 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.201 rbp rax)))))))
    (begin
      (set! tmp-ra.202 r15)
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
            (begin
              (return-point L.rp.36
                (begin
                  (set! rdi fun/ascii-char23346.9)
                  (set! r15 L.rp.36)
                  (jump L.fun/ascii-char23346.9.17 rbp r15 rdi)))
              (set! ascii-char0.17 rax))
            (begin
              (return-point L.rp.37
                (begin
                  (set! rdi fun/void23348.6)
                  (set! r15 L.rp.37)
                  (jump L.fun/void23348.6.14 rbp r15 rdi)))
              (set! void1.16 rax))
            (begin
              (begin
                (return-point L.rp.38
                  (begin
                    (set! rdi fun/any23350.7)
                    (set! r15 L.rp.38)
                    (jump L.fun/any23350.7.15 rbp r15 rdi)))
                (set! tmp.150 rax))
              (begin
                (return-point L.rp.39
                  (begin
                    (set! rsi tmp.150)
                    (set! rdi boolean?.71)
                    (set! r15 L.rp.39)
                    (jump L.boolean?.71.10 rbp r15 rdi rsi)))
                (set! boolean2.15 rax)))
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
                  (begin
                    (return-point L.rp.40
                      (begin
                        (set! rdx 640)
                        (set! rsi 800)
                        (set! rdi |-.72|)
                        (set! r15 L.rp.40)
                        (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.154 rax))
                  (begin
                    (begin
                      (return-point L.rp.41
                        (begin
                          (set! rdx 744)
                          (set! rsi 320)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.41)
                          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.155 rax))
                    (begin
                      (return-point L.rp.42
                        (begin
                          (set! rdx tmp.155)
                          (set! rsi tmp.154)
                          (set! rdi *.74)
                          (set! r15 L.rp.42)
                          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.153 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.43
                        (begin
                          (set! rdx 736)
                          (set! rsi 1304)
                          (set! rdi |-.72|)
                          (set! r15 L.rp.43)
                          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.157 rax))
                    (begin
                      (begin
                        (return-point L.rp.44
                          (begin
                            (set! rdx 824)
                            (set! rsi 1840)
                            (set! rdi |-.72|)
                            (set! r15 L.rp.44)
                            (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.158 rax))
                      (begin
                        (return-point L.rp.45
                          (begin
                            (set! rdx tmp.158)
                            (set! rsi tmp.157)
                            (set! rdi |+.73|)
                            (set! r15 L.rp.45)
                            (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.156 rax))))
                  (begin
                    (return-point L.rp.46
                      (begin
                        (set! rdx tmp.156)
                        (set! rsi tmp.153)
                        (set! rdi |-.72|)
                        (set! r15 L.rp.46)
                        (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                    (set! tmp.152 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.47
                        (begin
                          (set! rdx 488)
                          (set! rsi 376)
                          (set! rdi |-.72|)
                          (set! r15 L.rp.47)
                          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.161 rax))
                    (begin
                      (begin
                        (return-point L.rp.48
                          (begin
                            (set! rdx 192)
                            (set! rsi 1112)
                            (set! rdi |-.72|)
                            (set! r15 L.rp.48)
                            (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.162 rax))
                      (begin
                        (return-point L.rp.49
                          (begin
                            (set! rdx tmp.162)
                            (set! rsi tmp.161)
                            (set! rdi |-.72|)
                            (set! r15 L.rp.49)
                            (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.160 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.50
                          (begin
                            (set! rdx 1056)
                            (set! rsi 824)
                            (set! rdi *.74)
                            (set! r15 L.rp.50)
                            (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.164 rax))
                      (begin
                        (begin
                          (return-point L.rp.51
                            (begin
                              (set! rdx 760)
                              (set! rsi 1120)
                              (set! rdi |+.73|)
                              (set! r15 L.rp.51)
                              (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                          (set! tmp.165 rax))
                        (begin
                          (return-point L.rp.52
                            (begin
                              (set! rdx tmp.165)
                              (set! rsi tmp.164)
                              (set! rdi |+.73|)
                              (set! r15 L.rp.52)
                              (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                          (set! tmp.163 rax))))
                    (begin
                      (return-point L.rp.53
                        (begin
                          (set! rdx tmp.163)
                          (set! rsi tmp.160)
                          (set! rdi |-.72|)
                          (set! r15 L.rp.53)
                          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.159 rax))))
                (begin
                  (return-point L.rp.54
                    (begin
                      (set! rdx tmp.159)
                      (set! rsi tmp.152)
                      (set! rdi *.74)
                      (set! r15 L.rp.54)
                      (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                  (set! fixnum4.13 rax))))
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
                      (begin
                        (return-point L.rp.55
                          (begin
                            (set! rdi procedure3.14)
                            (set! r15 L.rp.55)
                            (jump tmp.173 rbp r15 rdi)))
                        (set! tmp.168 rax)))
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
                        (begin
                          (return-point L.rp.56
                            (begin
                              (set! rdi procedure3.14)
                              (set! r15 L.rp.56)
                              (jump tmp.179 rbp r15 rdi)))
                          (set! tmp.174 rax)))
                      (set! tmp.174 10814))
                    (set! tmp.174 11070))
                  (begin
                    (return-point L.rp.57
                      (begin
                        (set! rdx tmp.174)
                        (set! rsi tmp.168)
                        (set! rdi *.74)
                        (set! r15 L.rp.57)
                        (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                    (set! tmp.167 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.58
                        (begin
                          (set! rdx 1808)
                          (set! rsi 840)
                          (set! rdi *.74)
                          (set! r15 L.rp.58)
                          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                      (set! tmp.182 rax))
                    (begin
                      (begin
                        (return-point L.rp.59
                          (begin
                            (set! rdx 648)
                            (set! rsi 344)
                            (set! rdi |+.73|)
                            (set! r15 L.rp.59)
                            (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.183 rax))
                      (begin
                        (return-point L.rp.60
                          (begin
                            (set! rdx tmp.183)
                            (set! rsi tmp.182)
                            (set! rdi *.74)
                            (set! r15 L.rp.60)
                            (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.181 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.61
                          (begin
                            (set! rdx 1160)
                            (set! rsi 1960)
                            (set! rdi *.74)
                            (set! r15 L.rp.61)
                            (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                        (set! tmp.185 rax))
                      (begin
                        (begin
                          (return-point L.rp.62
                            (begin
                              (set! rdx 1568)
                              (set! rsi 872)
                              (set! rdi *.74)
                              (set! r15 L.rp.62)
                              (jump L.*.74.7 rbp r15 rdi rsi rdx)))
                          (set! tmp.186 rax))
                        (begin
                          (return-point L.rp.63
                            (begin
                              (set! rdx tmp.186)
                              (set! rsi tmp.185)
                              (set! rdi |+.73|)
                              (set! r15 L.rp.63)
                              (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                          (set! tmp.184 rax))))
                    (begin
                      (return-point L.rp.64
                        (begin
                          (set! rdx tmp.184)
                          (set! rsi tmp.181)
                          (set! rdi |+.73|)
                          (set! r15 L.rp.64)
                          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
                      (set! tmp.180 rax))))
                (begin
                  (set! rdx tmp.180)
                  (set! rsi tmp.167)
                  (set! rdi |-.72|)
                  (set! r15 tmp-ra.202)
                  (jump L.-.72.9 rbp r15 rdi rsi rdx))))))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () () () ())))
    (define L.lam.80.27
      ((new-frames ()))
      (begin
        (set! tmp-ra.185 r15)
        (begin
          (set! c.101 rdi)
          (begin
            (set! fun/void24631.10 (mref c.101 14))
            (begin
              (set! rdi fun/void24631.10)
              (set! r15 tmp-ra.185)
              (jump L.fun/void24631.10.20 rbp r15 rdi))))))
    (define L.lam.79.26
      ((new-frames ()))
      (begin
        (set! tmp-ra.186 r15)
        (begin
          (set! c.100 rdi)
          (begin
            (set! fun/empty24629.7 (mref c.100 14))
            (begin
              (set! rdi fun/empty24629.7)
              (set! r15 tmp-ra.186)
              (jump L.fun/empty24629.7.17 rbp r15 rdi))))))
    (define L.fun/vector24626.15.25
      ((new-frames ()))
      (begin
        (set! tmp-ra.187 r15)
        (begin
          (set! c.99 rdi)
          (begin
            (set! make-vector.74 (mref c.99 14))
            (begin
              (set! rsi 64)
              (set! rdi make-vector.74)
              (set! r15 tmp-ra.187)
              (jump L.make-vector.74.13 rbp r15 rdi rsi))))))
    (define L.fun/any24627.14.24
      ((new-frames ()))
      (begin
        (set! tmp-ra.188 r15)
        (begin
          (set! c.98 rdi)
          (begin
            (set! fun/any24628.5 (mref c.98 14))
            (begin
              (set! rdi fun/any24628.5)
              (set! r15 tmp-ra.188)
              (jump L.fun/any24628.5.15 rbp r15 rdi))))))
    (define L.fun/error24635.13.23
      ((new-frames ()))
      (begin
        (set! tmp-ra.189 r15)
        (begin
          (set! c.97 rdi)
          (begin
            (set! fun/error24636.8 (mref c.97 14))
            (begin
              (set! rdi fun/error24636.8)
              (set! r15 tmp-ra.189)
              (jump L.fun/error24636.8.18 rbp r15 rdi))))))
    (define L.fun/error24634.12.22
      ((new-frames ()))
      (begin
        (set! tmp-ra.190 r15)
        (begin
          (set! c.96 rdi)
          (begin (begin (set! rax 19006) (jump tmp-ra.190 rbp rax))))))
    (define L.fun/empty24630.11.21
      ((new-frames ()))
      (begin
        (set! tmp-ra.191 r15)
        (begin
          (set! c.95 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.191 rbp rax))))))
    (define L.fun/void24631.10.20
      ((new-frames ()))
      (begin
        (set! tmp-ra.192 r15)
        (begin
          (set! c.94 rdi)
          (begin
            (set! fun/void24632.9 (mref c.94 14))
            (begin
              (set! rdi fun/void24632.9)
              (set! r15 tmp-ra.192)
              (jump L.fun/void24632.9.19 rbp r15 rdi))))))
    (define L.fun/void24632.9.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.193 r15)
        (begin
          (set! c.93 rdi)
          (begin (begin (set! rax 30) (jump tmp-ra.193 rbp rax))))))
    (define L.fun/error24636.8.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.194 r15)
        (begin
          (set! c.92 rdi)
          (begin (begin (set! rax 52542) (jump tmp-ra.194 rbp rax))))))
    (define L.fun/empty24629.7.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.195 r15)
        (begin
          (set! c.91 rdi)
          (begin
            (set! fun/empty24630.11 (mref c.91 14))
            (begin
              (set! rdi fun/empty24630.11)
              (set! r15 tmp-ra.195)
              (jump L.fun/empty24630.11.21 rbp r15 rdi))))))
    (define L.fun/error24633.6.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.196 r15)
        (begin
          (set! c.90 rdi)
          (begin
            (set! fun/error24634.12 (mref c.90 14))
            (begin
              (set! rdi fun/error24634.12)
              (set! r15 tmp-ra.196)
              (jump L.fun/error24634.12.22 rbp r15 rdi))))))
    (define L.fun/any24628.5.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.197 r15)
        (begin
          (set! c.89 rdi)
          (begin (begin (set! rax 22) (jump tmp-ra.197 rbp rax))))))
    (define L.fun/vector24625.4.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.198 r15)
        (begin
          (set! c.88 rdi)
          (begin
            (set! fun/vector24626.15 (mref c.88 14))
            (begin
              (set! rdi fun/vector24626.15)
              (set! r15 tmp-ra.198)
              (jump L.fun/vector24626.15.25 rbp r15 rdi))))))
    (define L.make-vector.74.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.199 r15)
        (begin
          (set! c.87 rdi)
          (set! tmp.50 rsi)
          (begin
            (set! make-init-vector.1 (mref c.87 14))
            (if (begin
                  (if (begin
                        (set! tmp.125 (bitwise-and tmp.50 7))
                        (= tmp.125 0))
                    (set! tmp.124 14)
                    (set! tmp.124 6))
                  (!= tmp.124 6))
              (begin
                (set! rsi tmp.50)
                (set! rdi make-init-vector.1)
                (set! r15 tmp-ra.199)
                (jump L.make-init-vector.1.12 rbp r15 rdi rsi))
              (begin (set! rax 2110) (jump tmp-ra.199 rbp rax)))))))
    (define L.make-init-vector.1.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.200 r15)
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
                        (set! tmp.129 (arithmetic-shift-right tmp.22 3))
                        (set! tmp.128 (+ 1 tmp.129)))
                      (set! tmp.127 (* tmp.128 8)))
                    (set! tmp.126 (alloc tmp.127)))
                  (set! tmp.102 (+ tmp.126 3)))
                (begin (mset! tmp.102 -3 tmp.22) (set! tmp.23 tmp.102)))
              (begin
                (set! rcx tmp.23)
                (set! rdx 0)
                (set! rsi tmp.22)
                (set! rdi vector-init-loop.24)
                (set! r15 tmp-ra.200)
                (jump L.vector-init-loop.24.11 rbp r15 rdi rsi rdx rcx)))))))
    (define L.vector-init-loop.24.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.201 r15)
        (begin
          (set! c.85 rdi)
          (set! len.25 rsi)
          (set! i.27 rdx)
          (set! vec.26 rcx)
          (begin
            (set! vector-init-loop.24 (mref c.85 14))
            (if (begin
                  (if (= len.25 i.27) (set! tmp.130 14) (set! tmp.130 6))
                  (!= tmp.130 6))
              (begin (set! rax vec.26) (jump tmp-ra.201 rbp rax))
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
                  (begin
                    (set! rcx vec.26)
                    (set! rdx tmp.134)
                    (set! rsi len.25)
                    (set! rdi vector-init-loop.24)
                    (set! r15 tmp-ra.201)
                    (jump
                     L.vector-init-loop.24.11
                     rbp
                     r15
                     rdi
                     rsi
                     rdx
                     rcx)))))))))
    (define L.*.75.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.202 r15)
        (begin
          (set! c.84 rdi)
          (set! tmp.36 rsi)
          (set! tmp.37 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.136 (bitwise-and tmp.37 7))
                        (= tmp.136 0))
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
                  (begin
                    (set! rax (* tmp.36 tmp.139))
                    (jump tmp-ra.202 rbp rax)))
                (begin (set! rax 318) (jump tmp-ra.202 rbp rax)))
              (begin (set! rax 318) (jump tmp-ra.202 rbp rax)))))))
    (define L.+.76.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.203 r15)
        (begin
          (set! c.83 rdi)
          (set! tmp.38 rsi)
          (set! tmp.39 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.141 (bitwise-and tmp.39 7))
                        (= tmp.141 0))
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
                (begin (set! rax (+ tmp.38 tmp.39)) (jump tmp-ra.203 rbp rax))
                (begin (set! rax 574) (jump tmp-ra.203 rbp rax)))
              (begin (set! rax 574) (jump tmp-ra.203 rbp rax)))))))
    (define L.-.77.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.204 r15)
        (begin
          (set! c.82 rdi)
          (set! tmp.40 rsi)
          (set! tmp.41 rdx)
          (begin
            (if (begin
                  (if (begin
                        (set! tmp.145 (bitwise-and tmp.41 7))
                        (= tmp.145 0))
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
                (begin (set! rax (- tmp.40 tmp.41)) (jump tmp-ra.204 rbp rax))
                (begin (set! rax 830) (jump tmp-ra.204 rbp rax)))
              (begin (set! rax 830) (jump tmp-ra.204 rbp rax)))))))
    (define L.empty?.78.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.205 r15)
        (begin
          (set! c.81 rdi)
          (set! tmp.61 rsi)
          (begin
            (if (begin (set! tmp.148 (bitwise-and tmp.61 255)) (= tmp.148 22))
              (begin (set! rax 14) (jump tmp-ra.205 rbp rax))
              (begin (set! rax 6) (jump tmp-ra.205 rbp rax)))))))
    (begin
      (set! tmp-ra.206 r15)
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
                  (begin
                    (return-point L.rp.28
                      (begin
                        (set! rdx 1160)
                        (set! rsi 1184)
                        (set! rdi *.75)
                        (set! r15 L.rp.28)
                        (jump L.*.75.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.170 rax))
                  (begin
                    (begin
                      (return-point L.rp.29
                        (begin
                          (set! rdx 352)
                          (set! rsi 1808)
                          (set! rdi *.75)
                          (set! r15 L.rp.29)
                          (jump L.*.75.10 rbp r15 rdi rsi rdx)))
                      (set! tmp.171 rax))
                    (begin
                      (return-point L.rp.30
                        (begin
                          (set! rdx tmp.171)
                          (set! rsi tmp.170)
                          (set! rdi |+.76|)
                          (set! r15 L.rp.30)
                          (jump L.+.76.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.169 rax))))
                (begin
                  (begin
                    (begin
                      (return-point L.rp.31
                        (begin
                          (set! rdx 1360)
                          (set! rsi 520)
                          (set! rdi |+.76|)
                          (set! r15 L.rp.31)
                          (jump L.+.76.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.173 rax))
                    (begin
                      (begin
                        (return-point L.rp.32
                          (begin
                            (set! rdx 1168)
                            (set! rsi 1032)
                            (set! rdi |-.77|)
                            (set! r15 L.rp.32)
                            (jump L.-.77.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.174 rax))
                      (begin
                        (return-point L.rp.33
                          (begin
                            (set! rdx tmp.174)
                            (set! rsi tmp.173)
                            (set! rdi *.75)
                            (set! r15 L.rp.33)
                            (jump L.*.75.10 rbp r15 rdi rsi rdx)))
                        (set! tmp.172 rax))))
                  (begin
                    (return-point L.rp.34
                      (begin
                        (set! rdx tmp.172)
                        (set! rsi tmp.169)
                        (set! rdi *.75)
                        (set! r15 L.rp.34)
                        (jump L.*.75.10 rbp r15 rdi rsi rdx)))
                    (set! tmp.168 rax))))
              (begin
                (begin
                  (begin
                    (begin
                      (return-point L.rp.35
                        (begin
                          (set! rdx 1512)
                          (set! rsi 192)
                          (set! rdi |+.76|)
                          (set! r15 L.rp.35)
                          (jump L.+.76.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.177 rax))
                    (begin
                      (begin
                        (return-point L.rp.36
                          (begin
                            (set! rdx 640)
                            (set! rsi 880)
                            (set! rdi |-.77|)
                            (set! r15 L.rp.36)
                            (jump L.-.77.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.178 rax))
                      (begin
                        (return-point L.rp.37
                          (begin
                            (set! rdx tmp.178)
                            (set! rsi tmp.177)
                            (set! rdi |+.76|)
                            (set! r15 L.rp.37)
                            (jump L.+.76.9 rbp r15 rdi rsi rdx)))
                        (set! tmp.176 rax))))
                  (begin
                    (begin
                      (begin
                        (return-point L.rp.38
                          (begin
                            (set! rdx 2008)
                            (set! rsi 1528)
                            (set! rdi |-.77|)
                            (set! r15 L.rp.38)
                            (jump L.-.77.8 rbp r15 rdi rsi rdx)))
                        (set! tmp.180 rax))
                      (begin
                        (begin
                          (return-point L.rp.39
                            (begin
                              (set! rdx 1656)
                              (set! rsi 624)
                              (set! rdi |-.77|)
                              (set! r15 L.rp.39)
                              (jump L.-.77.8 rbp r15 rdi rsi rdx)))
                          (set! tmp.181 rax))
                        (begin
                          (return-point L.rp.40
                            (begin
                              (set! rdx tmp.181)
                              (set! rsi tmp.180)
                              (set! rdi |+.76|)
                              (set! r15 L.rp.40)
                              (jump L.+.76.9 rbp r15 rdi rsi rdx)))
                          (set! tmp.179 rax))))
                    (begin
                      (return-point L.rp.41
                        (begin
                          (set! rdx tmp.179)
                          (set! rsi tmp.176)
                          (set! rdi |+.76|)
                          (set! r15 L.rp.41)
                          (jump L.+.76.9 rbp r15 rdi rsi rdx)))
                      (set! tmp.175 rax))))
                (begin
                  (return-point L.rp.42
                    (begin
                      (set! rdx tmp.175)
                      (set! rsi tmp.168)
                      (set! rdi |-.77|)
                      (set! r15 L.rp.42)
                      (jump L.-.77.8 rbp r15 rdi rsi rdx)))
                  (set! fixnum0.21 rax))))
            (begin
              (return-point L.rp.43
                (begin
                  (set! rdi fun/vector24625.4)
                  (set! r15 L.rp.43)
                  (jump L.fun/vector24625.4.14 rbp r15 rdi)))
              (set! vector1.20 rax))
            (begin
              (begin
                (return-point L.rp.44
                  (begin
                    (set! rdi fun/any24627.14)
                    (set! r15 L.rp.44)
                    (jump L.fun/any24627.14.24 rbp r15 rdi)))
                (set! tmp.182 rax))
              (begin
                (return-point L.rp.45
                  (begin
                    (set! rsi tmp.182)
                    (set! rdi empty?.78)
                    (set! r15 L.rp.45)
                    (jump L.empty?.78.7 rbp r15 rdi rsi)))
                (set! boolean2.19 rax)))
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
            (begin
              (return-point L.rp.46
                (begin
                  (set! rdi fun/error24633.6)
                  (set! r15 L.rp.46)
                  (jump L.fun/error24633.6.16 rbp r15 rdi)))
              (set! error5.16 rax))
            (begin
              (set! rdi fun/error24635.13)
              (set! r15 tmp-ra.206)
              (jump L.fun/error24635.13.23 rbp r15 rdi))))))))
