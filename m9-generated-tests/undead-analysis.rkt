#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         "../undead-analysis.rkt")
(define (fail-if-invalid p)
  (when (not (asm-pred-lang-v8/undead? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "asm-pred-lang-v8/undead"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-asm-pred-lang-v8/locals p)
  (interp-asm-pred-lang-v8/undead (fail-if-invalid (undead-analysis p)))))

(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp-ra.56)))
    (begin (set! tmp-ra.56 r15) (set! rax 1384) (jump tmp-ra.56 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp-ra.56)))
    (begin (set! tmp-ra.56 r15) (set! rax 1912) (jump tmp-ra.56 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (fun/error8447.4 tmp.58 tmp.62 tmp.59 tmp-ra.61)))
    (define L.fun/error8447.4.7
      ((new-frames ()) (locals (c.57 tmp-ra.60)))
      (begin
        (set! tmp-ra.60 r15)
        (set! c.57 rdi)
        (set! rax 59710)
        (jump tmp-ra.60 rbp rax)))
    (begin
      (set! tmp-ra.61 r15)
      (begin (set! tmp.59 r12) (set! r12 (+ r12 16)))
      (set! tmp.62 tmp.59)
      (set! tmp.62 (+ tmp.62 2))
      (set! tmp.58 tmp.62)
      (mset! tmp.58 -2 L.fun/error8447.4.7)
      (mset! tmp.58 6 0)
      (set! fun/error8447.4 tmp.58)
      (set! rdi fun/error8447.4)
      (set! r15 tmp-ra.61)
      (jump L.fun/error8447.4.7 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals (fun/fixnum8450.4 tmp.58 tmp.62 tmp.59 tmp-ra.61)))
    (define L.fun/fixnum8450.4.7
      ((new-frames ()) (locals (c.57 tmp-ra.60)))
      (begin
        (set! tmp-ra.60 r15)
        (set! c.57 rdi)
        (set! rax 288)
        (jump tmp-ra.60 rbp rax)))
    (begin
      (set! tmp-ra.61 r15)
      (begin (set! tmp.59 r12) (set! r12 (+ r12 16)))
      (set! tmp.62 tmp.59)
      (set! tmp.62 (+ tmp.62 2))
      (set! tmp.58 tmp.62)
      (mset! tmp.58 -2 L.fun/fixnum8450.4.7)
      (mset! tmp.58 6 0)
      (set! fun/fixnum8450.4 tmp.58)
      (set! rdi fun/fixnum8450.4)
      (set! r15 tmp-ra.61)
      (jump L.fun/fixnum8450.4.7 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals
      (fun/vector8453.4
       tmp.66
       tmp.99
       tmp.81
       make-vector.57
       tmp.65
       tmp.98
       tmp.80
       make-init-vector.1
       tmp.64
       tmp.97
       tmp.79
       vector-init-loop.7
       tmp.63
       tmp.96
       tmp.78
       tmp-ra.86)))
    (define L.fun/vector8453.4.10
      ((new-frames ()) (locals (make-vector.57 c.61 tmp-ra.82)))
      (begin
        (set! tmp-ra.82 r15)
        (set! c.61 rdi)
        (set! make-vector.57 (mref c.61 14))
        (set! rsi 64)
        (set! rdi make-vector.57)
        (set! r15 tmp-ra.82)
        (jump L.make-vector.57.9 rbp r15 rdi rsi)))
    (define L.make-vector.57.9
      ((new-frames ())
       (locals
        (c.60 make-init-vector.1 tmp-ra.83 tmp.68 tmp.33 tmp.87 tmp.67)))
      (begin
        (set! tmp-ra.83 r15)
        (set! c.60 rdi)
        (set! tmp.33 rsi)
        (set! make-init-vector.1 (mref c.60 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.87 tmp.33)
                      (set! tmp.87 (bitwise-and tmp.87 7))
                      (set! tmp.68 tmp.87))
                    (= tmp.68 0))
                (set! tmp.67 14)
                (set! tmp.67 6))
              (!= tmp.67 6))
          (begin
            (set! rsi tmp.33)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.83)
            (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.83 rbp rax)))))
    (define L.make-init-vector.1.8
      ((new-frames ())
       (locals
        (tmp.6
         tmp.62
         tmp.91
         tmp.69
         tmp.70
         tmp.90
         tmp.71
         tmp.89
         tmp.72
         tmp.88
         vector-init-loop.7
         tmp.5
         c.59
         tmp-ra.84)))
      (begin
        (set! tmp-ra.84 r15)
        (set! c.59 rdi)
        (set! tmp.5 rsi)
        (set! vector-init-loop.7 (mref c.59 14))
        (set! tmp.88 tmp.5)
        (set! tmp.88 (arithmetic-shift-right tmp.88 3))
        (set! tmp.72 tmp.88)
        (set! tmp.89 1)
        (set! tmp.89 (+ tmp.89 tmp.72))
        (set! tmp.71 tmp.89)
        (set! tmp.90 tmp.71)
        (set! tmp.90 (* tmp.90 8))
        (set! tmp.70 tmp.90)
        (begin (set! tmp.69 r12) (set! r12 (+ r12 tmp.70)))
        (set! tmp.91 tmp.69)
        (set! tmp.91 (+ tmp.91 3))
        (set! tmp.62 tmp.91)
        (mset! tmp.62 -3 tmp.5)
        (set! tmp.6 tmp.62)
        (set! rcx tmp.6)
        (set! rdx 0)
        (set! rsi tmp.5)
        (set! rdi vector-init-loop.7)
        (set! r15 tmp-ra.84)
        (jump L.vector-init-loop.7.7 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.7.7
      ((new-frames ())
       (locals
        (c.58
         tmp.92
         tmp.76
         tmp.93
         tmp.75
         tmp.94
         tmp.74
         tmp.95
         tmp.77
         vector-init-loop.7
         tmp-ra.85
         vec.9
         len.8
         i.10
         tmp.73)))
      (begin
        (set! tmp-ra.85 r15)
        (set! c.58 rdi)
        (set! len.8 rsi)
        (set! i.10 rdx)
        (set! vec.9 rcx)
        (set! vector-init-loop.7 (mref c.58 14))
        (if (begin
              (if (= len.8 i.10) (set! tmp.73 14) (set! tmp.73 6))
              (!= tmp.73 6))
          (begin (set! rax vec.9) (jump tmp-ra.85 rbp rax))
          (begin
            (set! tmp.92 i.10)
            (set! tmp.92 (arithmetic-shift-right tmp.92 3))
            (set! tmp.76 tmp.92)
            (set! tmp.93 tmp.76)
            (set! tmp.93 (* tmp.93 8))
            (set! tmp.75 tmp.93)
            (set! tmp.94 tmp.75)
            (set! tmp.94 (+ tmp.94 5))
            (set! tmp.74 tmp.94)
            (mset! vec.9 tmp.74 0)
            (set! tmp.95 i.10)
            (set! tmp.95 (+ tmp.95 8))
            (set! tmp.77 tmp.95)
            (set! rcx vec.9)
            (set! rdx tmp.77)
            (set! rsi len.8)
            (set! rdi vector-init-loop.7)
            (set! r15 tmp-ra.85)
            (jump L.vector-init-loop.7.7 rbp r15 rdi rsi rdx rcx)))))
    (begin
      (set! tmp-ra.86 r15)
      (begin (set! tmp.78 r12) (set! r12 (+ r12 24)))
      (set! tmp.96 tmp.78)
      (set! tmp.96 (+ tmp.96 2))
      (set! tmp.63 tmp.96)
      (mset! tmp.63 -2 L.vector-init-loop.7.7)
      (mset! tmp.63 6 24)
      (set! vector-init-loop.7 tmp.63)
      (begin (set! tmp.79 r12) (set! r12 (+ r12 24)))
      (set! tmp.97 tmp.79)
      (set! tmp.97 (+ tmp.97 2))
      (set! tmp.64 tmp.97)
      (mset! tmp.64 -2 L.make-init-vector.1.8)
      (mset! tmp.64 6 8)
      (set! make-init-vector.1 tmp.64)
      (begin (set! tmp.80 r12) (set! r12 (+ r12 24)))
      (set! tmp.98 tmp.80)
      (set! tmp.98 (+ tmp.98 2))
      (set! tmp.65 tmp.98)
      (mset! tmp.65 -2 L.make-vector.57.9)
      (mset! tmp.65 6 8)
      (set! make-vector.57 tmp.65)
      (begin (set! tmp.81 r12) (set! r12 (+ r12 24)))
      (set! tmp.99 tmp.81)
      (set! tmp.99 (+ tmp.99 2))
      (set! tmp.66 tmp.99)
      (mset! tmp.66 -2 L.fun/vector8453.4.10)
      (mset! tmp.66 6 0)
      (set! fun/vector8453.4 tmp.66)
      (mset! vector-init-loop.7 14 vector-init-loop.7)
      (mset! make-init-vector.1 14 vector-init-loop.7)
      (mset! make-vector.57 14 make-init-vector.1)
      (mset! fun/vector8453.4 14 make-vector.57)
      (set! rdi fun/vector8453.4)
      (set! r15 tmp-ra.86)
      (jump L.fun/vector8453.4.10 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (fun/error8456.4 tmp.58 tmp.62 tmp.59 tmp-ra.61)))
    (define L.fun/error8456.4.7
      ((new-frames ()) (locals (c.57 tmp-ra.60)))
      (begin
        (set! tmp-ra.60 r15)
        (set! c.57 rdi)
        (set! rax 61502)
        (jump tmp-ra.60 rbp rax)))
    (begin
      (set! tmp-ra.61 r15)
      (begin (set! tmp.59 r12) (set! r12 (+ r12 16)))
      (set! tmp.62 tmp.59)
      (set! tmp.62 (+ tmp.62 2))
      (set! tmp.58 tmp.62)
      (mset! tmp.58 -2 L.fun/error8456.4.7)
      (mset! tmp.58 6 0)
      (set! fun/error8456.4 tmp.58)
      (set! rdi fun/error8456.4)
      (set! r15 tmp-ra.61)
      (jump L.fun/error8456.4.7 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp-ra.56 tmp.57)))
    (begin
      (set! tmp-ra.56 r15)
      (if (begin (set! tmp.57 14) (!= tmp.57 6))
        (begin (set! rax 28478) (jump tmp-ra.56 rbp rax))
        (begin (set! rax 63038) (jump tmp-ra.56 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames (()))
     (locals
      (tmp.89
       vector1.7
       fixnum0.8
       fun/error8471.5
       tmp.72
       tmp.109
       tmp.88
       fun/error8470.4
       tmp.71
       tmp.108
       tmp.87
       make-vector.61
       tmp.70
       tmp.107
       tmp.86
       make-init-vector.1
       tmp.69
       tmp.106
       tmp.85
       vector-init-loop.11
       tmp.68
       tmp.105
       tmp.84
       tmp-ra.95)))
    (define L.fun/error8471.5.11
      ((new-frames ()) (locals (c.66 tmp-ra.90)))
      (begin
        (set! tmp-ra.90 r15)
        (set! c.66 rdi)
        (set! rax 55614)
        (jump tmp-ra.90 rbp rax)))
    (define L.fun/error8470.4.10
      ((new-frames ()) (locals (fun/error8471.5 oprand0.6 c.65 tmp-ra.91)))
      (begin
        (set! tmp-ra.91 r15)
        (set! c.65 rdi)
        (set! oprand0.6 rsi)
        (set! fun/error8471.5 (mref c.65 14))
        (set! rdi fun/error8471.5)
        (set! r15 tmp-ra.91)
        (jump L.fun/error8471.5.11 rbp r15 rdi)))
    (define L.make-vector.61.9
      ((new-frames ())
       (locals
        (c.64 make-init-vector.1 tmp-ra.92 tmp.74 tmp.37 tmp.96 tmp.73)))
      (begin
        (set! tmp-ra.92 r15)
        (set! c.64 rdi)
        (set! tmp.37 rsi)
        (set! make-init-vector.1 (mref c.64 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.96 tmp.37)
                      (set! tmp.96 (bitwise-and tmp.96 7))
                      (set! tmp.74 tmp.96))
                    (= tmp.74 0))
                (set! tmp.73 14)
                (set! tmp.73 6))
              (!= tmp.73 6))
          (begin
            (set! rsi tmp.37)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.92)
            (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.92 rbp rax)))))
    (define L.make-init-vector.1.8
      ((new-frames ())
       (locals
        (tmp.10
         tmp.67
         tmp.100
         tmp.75
         tmp.76
         tmp.99
         tmp.77
         tmp.98
         tmp.78
         tmp.97
         vector-init-loop.11
         tmp.9
         c.63
         tmp-ra.93)))
      (begin
        (set! tmp-ra.93 r15)
        (set! c.63 rdi)
        (set! tmp.9 rsi)
        (set! vector-init-loop.11 (mref c.63 14))
        (set! tmp.97 tmp.9)
        (set! tmp.97 (arithmetic-shift-right tmp.97 3))
        (set! tmp.78 tmp.97)
        (set! tmp.98 1)
        (set! tmp.98 (+ tmp.98 tmp.78))
        (set! tmp.77 tmp.98)
        (set! tmp.99 tmp.77)
        (set! tmp.99 (* tmp.99 8))
        (set! tmp.76 tmp.99)
        (begin (set! tmp.75 r12) (set! r12 (+ r12 tmp.76)))
        (set! tmp.100 tmp.75)
        (set! tmp.100 (+ tmp.100 3))
        (set! tmp.67 tmp.100)
        (mset! tmp.67 -3 tmp.9)
        (set! tmp.10 tmp.67)
        (set! rcx tmp.10)
        (set! rdx 0)
        (set! rsi tmp.9)
        (set! rdi vector-init-loop.11)
        (set! r15 tmp-ra.93)
        (jump L.vector-init-loop.11.7 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.11.7
      ((new-frames ())
       (locals
        (c.62
         tmp.101
         tmp.82
         tmp.102
         tmp.81
         tmp.103
         tmp.80
         tmp.104
         tmp.83
         vector-init-loop.11
         tmp-ra.94
         vec.13
         len.12
         i.14
         tmp.79)))
      (begin
        (set! tmp-ra.94 r15)
        (set! c.62 rdi)
        (set! len.12 rsi)
        (set! i.14 rdx)
        (set! vec.13 rcx)
        (set! vector-init-loop.11 (mref c.62 14))
        (if (begin
              (if (= len.12 i.14) (set! tmp.79 14) (set! tmp.79 6))
              (!= tmp.79 6))
          (begin (set! rax vec.13) (jump tmp-ra.94 rbp rax))
          (begin
            (set! tmp.101 i.14)
            (set! tmp.101 (arithmetic-shift-right tmp.101 3))
            (set! tmp.82 tmp.101)
            (set! tmp.102 tmp.82)
            (set! tmp.102 (* tmp.102 8))
            (set! tmp.81 tmp.102)
            (set! tmp.103 tmp.81)
            (set! tmp.103 (+ tmp.103 5))
            (set! tmp.80 tmp.103)
            (mset! vec.13 tmp.80 0)
            (set! tmp.104 i.14)
            (set! tmp.104 (+ tmp.104 8))
            (set! tmp.83 tmp.104)
            (set! rcx vec.13)
            (set! rdx tmp.83)
            (set! rsi len.12)
            (set! rdi vector-init-loop.11)
            (set! r15 tmp-ra.94)
            (jump L.vector-init-loop.11.7 rbp r15 rdi rsi rdx rcx)))))
    (begin
      (set! tmp-ra.95 r15)
      (begin (set! tmp.84 r12) (set! r12 (+ r12 24)))
      (set! tmp.105 tmp.84)
      (set! tmp.105 (+ tmp.105 2))
      (set! tmp.68 tmp.105)
      (mset! tmp.68 -2 L.vector-init-loop.11.7)
      (mset! tmp.68 6 24)
      (set! vector-init-loop.11 tmp.68)
      (begin (set! tmp.85 r12) (set! r12 (+ r12 24)))
      (set! tmp.106 tmp.85)
      (set! tmp.106 (+ tmp.106 2))
      (set! tmp.69 tmp.106)
      (mset! tmp.69 -2 L.make-init-vector.1.8)
      (mset! tmp.69 6 8)
      (set! make-init-vector.1 tmp.69)
      (begin (set! tmp.86 r12) (set! r12 (+ r12 24)))
      (set! tmp.107 tmp.86)
      (set! tmp.107 (+ tmp.107 2))
      (set! tmp.70 tmp.107)
      (mset! tmp.70 -2 L.make-vector.61.9)
      (mset! tmp.70 6 8)
      (set! make-vector.61 tmp.70)
      (begin (set! tmp.87 r12) (set! r12 (+ r12 24)))
      (set! tmp.108 tmp.87)
      (set! tmp.108 (+ tmp.108 2))
      (set! tmp.71 tmp.108)
      (mset! tmp.71 -2 L.fun/error8470.4.10)
      (mset! tmp.71 6 8)
      (set! fun/error8470.4 tmp.71)
      (begin (set! tmp.88 r12) (set! r12 (+ r12 16)))
      (set! tmp.109 tmp.88)
      (set! tmp.109 (+ tmp.109 2))
      (set! tmp.72 tmp.109)
      (mset! tmp.72 -2 L.fun/error8471.5.11)
      (mset! tmp.72 6 0)
      (set! fun/error8471.5 tmp.72)
      (mset! vector-init-loop.11 14 vector-init-loop.11)
      (mset! make-init-vector.1 14 vector-init-loop.11)
      (mset! make-vector.61 14 make-init-vector.1)
      (mset! fun/error8470.4 14 fun/error8471.5)
      (set! fixnum0.8 2000)
      (return-point L.rp.12
        (begin
          (set! rsi 64)
          (set! rdi make-vector.61)
          (set! r15 L.rp.12)
          (jump L.make-vector.61.9 rbp r15 rdi rsi)))
      (set! vector1.7 rax)
      (set! tmp.89 1088)
      (set! rsi tmp.89)
      (set! rdi fun/error8470.4)
      (set! r15 tmp-ra.95)
      (jump L.fun/error8470.4.10 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (()))
     (locals
      (tmp.66
       fun/void8475.5
       tmp.63
       tmp.71
       tmp.65
       fun/ascii-char8474.4
       tmp.62
       tmp.70
       tmp.64
       tmp-ra.69)))
    (define L.fun/void8475.5.8
      ((new-frames ()) (locals (oprand0.7 c.61 tmp-ra.67)))
      (begin
        (set! tmp-ra.67 r15)
        (set! c.61 rdi)
        (set! oprand0.7 rsi)
        (set! rax 30)
        (jump tmp-ra.67 rbp rax)))
    (define L.fun/ascii-char8474.4.7
      ((new-frames ()) (locals (oprand0.6 c.60 tmp-ra.68)))
      (begin
        (set! tmp-ra.68 r15)
        (set! c.60 rdi)
        (set! oprand0.6 rsi)
        (set! rax 22062)
        (jump tmp-ra.68 rbp rax)))
    (begin
      (set! tmp-ra.69 r15)
      (begin (set! tmp.64 r12) (set! r12 (+ r12 16)))
      (set! tmp.70 tmp.64)
      (set! tmp.70 (+ tmp.70 2))
      (set! tmp.62 tmp.70)
      (mset! tmp.62 -2 L.fun/ascii-char8474.4.7)
      (mset! tmp.62 6 8)
      (set! fun/ascii-char8474.4 tmp.62)
      (begin (set! tmp.65 r12) (set! r12 (+ r12 16)))
      (set! tmp.71 tmp.65)
      (set! tmp.71 (+ tmp.71 2))
      (set! tmp.63 tmp.71)
      (mset! tmp.63 -2 L.fun/void8475.5.8)
      (mset! tmp.63 6 8)
      (set! fun/void8475.5 tmp.63)
      (return-point L.rp.9
        (begin
          (set! rsi 14)
          (set! rdi fun/void8475.5)
          (set! r15 L.rp.9)
          (jump L.fun/void8475.5.8 rbp r15 rdi rsi)))
      (set! tmp.66 rax)
      (set! rsi tmp.66)
      (set! rdi fun/ascii-char8474.4)
      (set! r15 tmp-ra.69)
      (jump L.fun/ascii-char8474.4.7 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals
      (tmp.63
       error1.6
       error0.7
       fun/empty8478.4
       tmp.61
       tmp.66
       tmp.62
       tmp-ra.65)))
    (define L.fun/empty8478.4.7
      ((new-frames ()) (locals (oprand0.5 c.60 tmp-ra.64)))
      (begin
        (set! tmp-ra.64 r15)
        (set! c.60 rdi)
        (set! oprand0.5 rsi)
        (set! rax 22)
        (jump tmp-ra.64 rbp rax)))
    (begin
      (set! tmp-ra.65 r15)
      (begin (set! tmp.62 r12) (set! r12 (+ r12 16)))
      (set! tmp.66 tmp.62)
      (set! tmp.66 (+ tmp.66 2))
      (set! tmp.61 tmp.66)
      (mset! tmp.61 -2 L.fun/empty8478.4.7)
      (mset! tmp.61 6 8)
      (set! fun/empty8478.4 tmp.61)
      (set! error0.7 13630)
      (set! error1.6 50238)
      (set! tmp.63 22)
      (set! rsi tmp.63)
      (set! rdi fun/empty8478.4)
      (set! r15 tmp-ra.65)
      (jump L.fun/empty8478.4.7 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals
      (tmp.65 tmp.61 fun/ascii-char8481.4 tmp.59 tmp.64 tmp.60 tmp-ra.63)))
    (define L.fun/ascii-char8481.4.7
      ((new-frames ()) (locals (oprand0.5 c.58 tmp-ra.62)))
      (begin
        (set! tmp-ra.62 r15)
        (set! c.58 rdi)
        (set! oprand0.5 rsi)
        (set! rax 23598)
        (jump tmp-ra.62 rbp rax)))
    (begin
      (set! tmp-ra.63 r15)
      (begin (set! tmp.60 r12) (set! r12 (+ r12 16)))
      (set! tmp.64 tmp.60)
      (set! tmp.64 (+ tmp.64 2))
      (set! tmp.59 tmp.64)
      (mset! tmp.59 -2 L.fun/ascii-char8481.4.7)
      (mset! tmp.59 6 8)
      (set! fun/ascii-char8481.4 tmp.59)
      (if (begin (set! tmp.65 6) (!= tmp.65 6))
        (set! tmp.61 22)
        (set! tmp.61 22))
      (set! rsi tmp.61)
      (set! rdi fun/ascii-char8481.4)
      (set! r15 tmp-ra.63)
      (jump L.fun/ascii-char8481.4.7 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () ()))
     (locals
      (tmp.92
       tmp.111
       tmp.93
       tmp.89
       tmp.91
       boolean2.8
       boolean1.9
       ascii-char0.10
       tmp.90
       fun/pair8496.5
       tmp.76
       tmp.110
       tmp.88
       fun/pair8495.4
       tmp.75
       tmp.109
       tmp.87
       cons.63
       tmp.74
       tmp.108
       tmp.86
       *.64
       tmp.73
       tmp.107
       tmp.85
       ascii-char?.65
       tmp.72
       tmp.106
       tmp.84
       tmp-ra.99)))
    (define L.fun/pair8496.5.11
      ((new-frames ()) (locals (cons.63 c.70 tmp-ra.94)))
      (begin
        (set! tmp-ra.94 r15)
        (set! c.70 rdi)
        (set! cons.63 (mref c.70 14))
        (set! rdx 3424)
        (set! rsi 264)
        (set! rdi cons.63)
        (set! r15 tmp-ra.94)
        (jump L.cons.63.9 rbp r15 rdi rsi rdx)))
    (define L.fun/pair8495.4.10
      ((new-frames ())
       (locals (fun/pair8496.5 oprand1.6 oprand0.7 c.69 tmp-ra.95)))
      (begin
        (set! tmp-ra.95 r15)
        (set! c.69 rdi)
        (set! oprand0.7 rsi)
        (set! oprand1.6 rdx)
        (set! fun/pair8496.5 (mref c.69 14))
        (set! rdi fun/pair8496.5)
        (set! r15 tmp-ra.95)
        (jump L.fun/pair8496.5.11 rbp r15 rdi)))
    (define L.cons.63.9
      ((new-frames ())
       (locals (tmp.71 tmp.100 tmp.77 tmp.59 tmp.58 c.68 tmp-ra.96)))
      (begin
        (set! tmp-ra.96 r15)
        (set! c.68 rdi)
        (set! tmp.58 rsi)
        (set! tmp.59 rdx)
        (begin (set! tmp.77 r12) (set! r12 (+ r12 16)))
        (set! tmp.100 tmp.77)
        (set! tmp.100 (+ tmp.100 1))
        (set! tmp.71 tmp.100)
        (mset! tmp.71 -1 tmp.58)
        (mset! tmp.71 7 tmp.59)
        (set! rax tmp.71)
        (jump tmp-ra.96 rbp rax)))
    (define L.*.64.8
      ((new-frames ())
       (locals
        (c.67
         tmp.80
         tmp.102
         tmp.25
         tmp.81
         tmp.104
         tmp.82
         tmp.103
         tmp-ra.97
         tmp.79
         tmp.26
         tmp.101
         tmp.78)))
      (begin
        (set! tmp-ra.97 r15)
        (set! c.67 rdi)
        (set! tmp.25 rsi)
        (set! tmp.26 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.101 tmp.26)
                      (set! tmp.101 (bitwise-and tmp.101 7))
                      (set! tmp.79 tmp.101))
                    (= tmp.79 0))
                (set! tmp.78 14)
                (set! tmp.78 6))
              (!= tmp.78 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.102 tmp.25)
                        (set! tmp.102 (bitwise-and tmp.102 7))
                        (set! tmp.81 tmp.102))
                      (= tmp.81 0))
                  (set! tmp.80 14)
                  (set! tmp.80 6))
                (!= tmp.80 6))
            (begin
              (set! tmp.103 tmp.26)
              (set! tmp.103 (arithmetic-shift-right tmp.103 3))
              (set! tmp.82 tmp.103)
              (set! tmp.104 tmp.25)
              (set! tmp.104 (* tmp.104 tmp.82))
              (set! rax tmp.104)
              (jump tmp-ra.97 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.97 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.97 rbp rax)))))
    (define L.ascii-char?.65.7
      ((new-frames ()) (locals (c.66 tmp-ra.98 tmp.105 tmp.52 tmp.83)))
      (begin
        (set! tmp-ra.98 r15)
        (set! c.66 rdi)
        (set! tmp.52 rsi)
        (if (begin
              (begin
                (set! tmp.105 tmp.52)
                (set! tmp.105 (bitwise-and tmp.105 255))
                (set! tmp.83 tmp.105))
              (= tmp.83 46))
          (begin (set! rax 14) (jump tmp-ra.98 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.98 rbp rax)))))
    (begin
      (set! tmp-ra.99 r15)
      (begin (set! tmp.84 r12) (set! r12 (+ r12 16)))
      (set! tmp.106 tmp.84)
      (set! tmp.106 (+ tmp.106 2))
      (set! tmp.72 tmp.106)
      (mset! tmp.72 -2 L.ascii-char?.65.7)
      (mset! tmp.72 6 8)
      (set! ascii-char?.65 tmp.72)
      (begin (set! tmp.85 r12) (set! r12 (+ r12 16)))
      (set! tmp.107 tmp.85)
      (set! tmp.107 (+ tmp.107 2))
      (set! tmp.73 tmp.107)
      (mset! tmp.73 -2 L.*.64.8)
      (mset! tmp.73 6 16)
      (set! *.64 tmp.73)
      (begin (set! tmp.86 r12) (set! r12 (+ r12 16)))
      (set! tmp.108 tmp.86)
      (set! tmp.108 (+ tmp.108 2))
      (set! tmp.74 tmp.108)
      (mset! tmp.74 -2 L.cons.63.9)
      (mset! tmp.74 6 16)
      (set! cons.63 tmp.74)
      (begin (set! tmp.87 r12) (set! r12 (+ r12 24)))
      (set! tmp.109 tmp.87)
      (set! tmp.109 (+ tmp.109 2))
      (set! tmp.75 tmp.109)
      (mset! tmp.75 -2 L.fun/pair8495.4.10)
      (mset! tmp.75 6 16)
      (set! fun/pair8495.4 tmp.75)
      (begin (set! tmp.88 r12) (set! r12 (+ r12 24)))
      (set! tmp.110 tmp.88)
      (set! tmp.110 (+ tmp.110 2))
      (set! tmp.76 tmp.110)
      (mset! tmp.76 -2 L.fun/pair8496.5.11)
      (mset! tmp.76 6 0)
      (set! fun/pair8496.5 tmp.76)
      (mset! fun/pair8495.4 14 fun/pair8496.5)
      (mset! fun/pair8496.5 14 cons.63)
      (return-point L.rp.12
        (begin
          (set! rdx 800)
          (set! rsi 960)
          (set! rdi *.64)
          (set! r15 L.rp.12)
          (jump L.*.64.8 rbp r15 rdi rsi rdx)))
      (set! tmp.90 rax)
      (set! ascii-char0.10 19758)
      (set! boolean1.9 14)
      (set! boolean2.8 14)
      (set! tmp.91 1568)
      (return-point L.rp.13
        (begin
          (set! rdx tmp.91)
          (set! rsi tmp.90)
          (set! rdi *.64)
          (set! r15 L.rp.13)
          (jump L.*.64.8 rbp r15 rdi rsi rdx)))
      (set! tmp.89 rax)
      (if (begin (set! tmp.111 14) (!= tmp.111 6))
        (set! tmp.93 24110)
        (set! tmp.93 30))
      (return-point L.rp.14
        (begin
          (set! rsi tmp.93)
          (set! rdi ascii-char?.65)
          (set! r15 L.rp.14)
          (jump L.ascii-char?.65.7 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (set! rdx tmp.92)
      (set! rsi tmp.89)
      (set! rdi fun/pair8495.4)
      (set! r15 tmp-ra.99)
      (jump L.fun/pair8495.4.10 rbp r15 rdi rsi rdx))))
(check-by-interp
 '(module
    ((new-frames (() () () ()))
     (locals
      (tmp.120
       tmp.122
       tmp.121
       tmp.119
       boolean2.18
       vector1.19
       ascii-char0.20
       fun/void8506.9
       tmp.96
       tmp.153
       tmp.118
       fun/error8510.8
       tmp.95
       tmp.152
       tmp.117
       fun/void8507.7
       tmp.94
       tmp.151
       tmp.116
       fun/empty8511.6
       tmp.93
       tmp.150
       tmp.115
       fun/pair8509.5
       tmp.92
       tmp.149
       tmp.114
       fun/pair8508.4
       tmp.91
       tmp.148
       tmp.113
       cons.73
       tmp.90
       tmp.147
       tmp.112
       make-vector.74
       tmp.89
       tmp.146
       tmp.111
       make-init-vector.1
       tmp.88
       tmp.145
       tmp.110
       vector-init-loop.23
       tmp.87
       tmp.144
       tmp.109
       tmp-ra.133)))
    (define L.fun/void8506.9.16
      ((new-frames ())
       (locals (fun/void8507.7 oprand1.16 oprand0.17 c.84 tmp-ra.123)))
      (begin
        (set! tmp-ra.123 r15)
        (set! c.84 rdi)
        (set! oprand0.17 rsi)
        (set! oprand1.16 rdx)
        (set! fun/void8507.7 (mref c.84 14))
        (set! rdi fun/void8507.7)
        (set! r15 tmp-ra.123)
        (jump L.fun/void8507.7.14 rbp r15 rdi)))
    (define L.fun/error8510.8.15
      ((new-frames ()) (locals (oprand1.14 oprand0.15 c.83 tmp-ra.124)))
      (begin
        (set! tmp-ra.124 r15)
        (set! c.83 rdi)
        (set! oprand0.15 rsi)
        (set! oprand1.14 rdx)
        (set! rax 39230)
        (jump tmp-ra.124 rbp rax)))
    (define L.fun/void8507.7.14
      ((new-frames ()) (locals (c.82 tmp-ra.125)))
      (begin
        (set! tmp-ra.125 r15)
        (set! c.82 rdi)
        (set! rax 30)
        (jump tmp-ra.125 rbp rax)))
    (define L.fun/empty8511.6.13
      ((new-frames ()) (locals (oprand1.12 oprand0.13 c.81 tmp-ra.126)))
      (begin
        (set! tmp-ra.126 r15)
        (set! c.81 rdi)
        (set! oprand0.13 rsi)
        (set! oprand1.12 rdx)
        (set! rax 22)
        (jump tmp-ra.126 rbp rax)))
    (define L.fun/pair8509.5.12
      ((new-frames ()) (locals (cons.73 c.80 tmp-ra.127)))
      (begin
        (set! tmp-ra.127 r15)
        (set! c.80 rdi)
        (set! cons.73 (mref c.80 14))
        (set! rdx 2752)
        (set! rsi 840)
        (set! rdi cons.73)
        (set! r15 tmp-ra.127)
        (jump L.cons.73.10 rbp r15 rdi rsi rdx)))
    (define L.fun/pair8508.4.11
      ((new-frames ())
       (locals (fun/pair8509.5 oprand1.10 oprand0.11 c.79 tmp-ra.128)))
      (begin
        (set! tmp-ra.128 r15)
        (set! c.79 rdi)
        (set! oprand0.11 rsi)
        (set! oprand1.10 rdx)
        (set! fun/pair8509.5 (mref c.79 14))
        (set! rdi fun/pair8509.5)
        (set! r15 tmp-ra.128)
        (jump L.fun/pair8509.5.12 rbp r15 rdi)))
    (define L.cons.73.10
      ((new-frames ())
       (locals (tmp.85 tmp.134 tmp.97 tmp.69 tmp.68 c.78 tmp-ra.129)))
      (begin
        (set! tmp-ra.129 r15)
        (set! c.78 rdi)
        (set! tmp.68 rsi)
        (set! tmp.69 rdx)
        (begin (set! tmp.97 r12) (set! r12 (+ r12 16)))
        (set! tmp.134 tmp.97)
        (set! tmp.134 (+ tmp.134 1))
        (set! tmp.85 tmp.134)
        (mset! tmp.85 -1 tmp.68)
        (mset! tmp.85 7 tmp.69)
        (set! rax tmp.85)
        (jump tmp-ra.129 rbp rax)))
    (define L.make-vector.74.9
      ((new-frames ())
       (locals
        (c.77 make-init-vector.1 tmp-ra.130 tmp.99 tmp.49 tmp.135 tmp.98)))
      (begin
        (set! tmp-ra.130 r15)
        (set! c.77 rdi)
        (set! tmp.49 rsi)
        (set! make-init-vector.1 (mref c.77 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.135 tmp.49)
                      (set! tmp.135 (bitwise-and tmp.135 7))
                      (set! tmp.99 tmp.135))
                    (= tmp.99 0))
                (set! tmp.98 14)
                (set! tmp.98 6))
              (!= tmp.98 6))
          (begin
            (set! rsi tmp.49)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.130)
            (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.130 rbp rax)))))
    (define L.make-init-vector.1.8
      ((new-frames ())
       (locals
        (tmp.22
         tmp.86
         tmp.139
         tmp.100
         tmp.101
         tmp.138
         tmp.102
         tmp.137
         tmp.103
         tmp.136
         vector-init-loop.23
         tmp.21
         c.76
         tmp-ra.131)))
      (begin
        (set! tmp-ra.131 r15)
        (set! c.76 rdi)
        (set! tmp.21 rsi)
        (set! vector-init-loop.23 (mref c.76 14))
        (set! tmp.136 tmp.21)
        (set! tmp.136 (arithmetic-shift-right tmp.136 3))
        (set! tmp.103 tmp.136)
        (set! tmp.137 1)
        (set! tmp.137 (+ tmp.137 tmp.103))
        (set! tmp.102 tmp.137)
        (set! tmp.138 tmp.102)
        (set! tmp.138 (* tmp.138 8))
        (set! tmp.101 tmp.138)
        (begin (set! tmp.100 r12) (set! r12 (+ r12 tmp.101)))
        (set! tmp.139 tmp.100)
        (set! tmp.139 (+ tmp.139 3))
        (set! tmp.86 tmp.139)
        (mset! tmp.86 -3 tmp.21)
        (set! tmp.22 tmp.86)
        (set! rcx tmp.22)
        (set! rdx 0)
        (set! rsi tmp.21)
        (set! rdi vector-init-loop.23)
        (set! r15 tmp-ra.131)
        (jump L.vector-init-loop.23.7 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.23.7
      ((new-frames ())
       (locals
        (c.75
         tmp.140
         tmp.107
         tmp.141
         tmp.106
         tmp.142
         tmp.105
         tmp.143
         tmp.108
         vector-init-loop.23
         tmp-ra.132
         vec.25
         len.24
         i.26
         tmp.104)))
      (begin
        (set! tmp-ra.132 r15)
        (set! c.75 rdi)
        (set! len.24 rsi)
        (set! i.26 rdx)
        (set! vec.25 rcx)
        (set! vector-init-loop.23 (mref c.75 14))
        (if (begin
              (if (= len.24 i.26) (set! tmp.104 14) (set! tmp.104 6))
              (!= tmp.104 6))
          (begin (set! rax vec.25) (jump tmp-ra.132 rbp rax))
          (begin
            (set! tmp.140 i.26)
            (set! tmp.140 (arithmetic-shift-right tmp.140 3))
            (set! tmp.107 tmp.140)
            (set! tmp.141 tmp.107)
            (set! tmp.141 (* tmp.141 8))
            (set! tmp.106 tmp.141)
            (set! tmp.142 tmp.106)
            (set! tmp.142 (+ tmp.142 5))
            (set! tmp.105 tmp.142)
            (mset! vec.25 tmp.105 0)
            (set! tmp.143 i.26)
            (set! tmp.143 (+ tmp.143 8))
            (set! tmp.108 tmp.143)
            (set! rcx vec.25)
            (set! rdx tmp.108)
            (set! rsi len.24)
            (set! rdi vector-init-loop.23)
            (set! r15 tmp-ra.132)
            (jump L.vector-init-loop.23.7 rbp r15 rdi rsi rdx rcx)))))
    (begin
      (set! tmp-ra.133 r15)
      (begin (set! tmp.109 r12) (set! r12 (+ r12 24)))
      (set! tmp.144 tmp.109)
      (set! tmp.144 (+ tmp.144 2))
      (set! tmp.87 tmp.144)
      (mset! tmp.87 -2 L.vector-init-loop.23.7)
      (mset! tmp.87 6 24)
      (set! vector-init-loop.23 tmp.87)
      (begin (set! tmp.110 r12) (set! r12 (+ r12 24)))
      (set! tmp.145 tmp.110)
      (set! tmp.145 (+ tmp.145 2))
      (set! tmp.88 tmp.145)
      (mset! tmp.88 -2 L.make-init-vector.1.8)
      (mset! tmp.88 6 8)
      (set! make-init-vector.1 tmp.88)
      (begin (set! tmp.111 r12) (set! r12 (+ r12 24)))
      (set! tmp.146 tmp.111)
      (set! tmp.146 (+ tmp.146 2))
      (set! tmp.89 tmp.146)
      (mset! tmp.89 -2 L.make-vector.74.9)
      (mset! tmp.89 6 8)
      (set! make-vector.74 tmp.89)
      (begin (set! tmp.112 r12) (set! r12 (+ r12 16)))
      (set! tmp.147 tmp.112)
      (set! tmp.147 (+ tmp.147 2))
      (set! tmp.90 tmp.147)
      (mset! tmp.90 -2 L.cons.73.10)
      (mset! tmp.90 6 16)
      (set! cons.73 tmp.90)
      (begin (set! tmp.113 r12) (set! r12 (+ r12 24)))
      (set! tmp.148 tmp.113)
      (set! tmp.148 (+ tmp.148 2))
      (set! tmp.91 tmp.148)
      (mset! tmp.91 -2 L.fun/pair8508.4.11)
      (mset! tmp.91 6 16)
      (set! fun/pair8508.4 tmp.91)
      (begin (set! tmp.114 r12) (set! r12 (+ r12 24)))
      (set! tmp.149 tmp.114)
      (set! tmp.149 (+ tmp.149 2))
      (set! tmp.92 tmp.149)
      (mset! tmp.92 -2 L.fun/pair8509.5.12)
      (mset! tmp.92 6 0)
      (set! fun/pair8509.5 tmp.92)
      (begin (set! tmp.115 r12) (set! r12 (+ r12 16)))
      (set! tmp.150 tmp.115)
      (set! tmp.150 (+ tmp.150 2))
      (set! tmp.93 tmp.150)
      (mset! tmp.93 -2 L.fun/empty8511.6.13)
      (mset! tmp.93 6 16)
      (set! fun/empty8511.6 tmp.93)
      (begin (set! tmp.116 r12) (set! r12 (+ r12 16)))
      (set! tmp.151 tmp.116)
      (set! tmp.151 (+ tmp.151 2))
      (set! tmp.94 tmp.151)
      (mset! tmp.94 -2 L.fun/void8507.7.14)
      (mset! tmp.94 6 0)
      (set! fun/void8507.7 tmp.94)
      (begin (set! tmp.117 r12) (set! r12 (+ r12 16)))
      (set! tmp.152 tmp.117)
      (set! tmp.152 (+ tmp.152 2))
      (set! tmp.95 tmp.152)
      (mset! tmp.95 -2 L.fun/error8510.8.15)
      (mset! tmp.95 6 16)
      (set! fun/error8510.8 tmp.95)
      (begin (set! tmp.118 r12) (set! r12 (+ r12 24)))
      (set! tmp.153 tmp.118)
      (set! tmp.153 (+ tmp.153 2))
      (set! tmp.96 tmp.153)
      (mset! tmp.96 -2 L.fun/void8506.9.16)
      (mset! tmp.96 6 16)
      (set! fun/void8506.9 tmp.96)
      (mset! vector-init-loop.23 14 vector-init-loop.23)
      (mset! make-init-vector.1 14 vector-init-loop.23)
      (mset! make-vector.74 14 make-init-vector.1)
      (mset! fun/pair8508.4 14 fun/pair8509.5)
      (mset! fun/pair8509.5 14 cons.73)
      (mset! fun/void8506.9 14 fun/void8507.7)
      (set! ascii-char0.20 27182)
      (return-point L.rp.17
        (begin
          (set! rsi 64)
          (set! rdi make-vector.74)
          (set! r15 L.rp.17)
          (jump L.make-vector.74.9 rbp r15 rdi rsi)))
      (set! vector1.19 rax)
      (set! boolean2.18 14)
      (set! tmp.119 37694)
      (return-point L.rp.18
        (begin
          (set! rdx 30)
          (set! rsi 30)
          (set! rdi fun/error8510.8)
          (set! r15 L.rp.18)
          (jump L.fun/error8510.8.15 rbp r15 rdi rsi rdx)))
      (set! tmp.121 rax)
      (return-point L.rp.19
        (begin
          (set! rdx 17198)
          (set! rsi 36414)
          (set! rdi fun/empty8511.6)
          (set! r15 L.rp.19)
          (jump L.fun/empty8511.6.13 rbp r15 rdi rsi rdx)))
      (set! tmp.122 rax)
      (return-point L.rp.20
        (begin
          (set! rdx tmp.122)
          (set! rsi tmp.121)
          (set! rdi fun/pair8508.4)
          (set! r15 L.rp.20)
          (jump L.fun/pair8508.4.11 rbp r15 rdi rsi rdx)))
      (set! tmp.120 rax)
      (set! rdx tmp.120)
      (set! rsi tmp.119)
      (set! rdi fun/void8506.9)
      (set! r15 tmp-ra.133)
      (jump L.fun/void8506.9.16 rbp r15 rdi rsi rdx))))
(check-by-interp
 '(module
    ((new-frames (() () () ()))
     (locals
      (vector2.7
       boolean1.8
       tmp.104
       empty0.9
       fun/vector8536.6
       tmp.82
       tmp.132
       tmp.103
       fun/empty8537.5
       tmp.81
       tmp.131
       tmp.102
       fun/empty8535.4
       tmp.80
       tmp.130
       tmp.101
       make-vector.62
       tmp.79
       tmp.129
       tmp.100
       make-init-vector.1
       tmp.78
       tmp.128
       tmp.99
       vector-init-loop.12
       tmp.77
       tmp.127
       tmp.98
       cons.63
       tmp.76
       tmp.126
       tmp.97
       boolean?.64
       tmp.75
       tmp.125
       tmp.96
       tmp-ra.113)))
    (define L.fun/vector8536.6.14
      ((new-frames ()) (locals (make-vector.62 c.72 tmp-ra.105)))
      (begin
        (set! tmp-ra.105 r15)
        (set! c.72 rdi)
        (set! make-vector.62 (mref c.72 14))
        (set! rsi 64)
        (set! rdi make-vector.62)
        (set! r15 tmp-ra.105)
        (jump L.make-vector.62.11 rbp r15 rdi rsi)))
    (define L.fun/empty8537.5.13
      ((new-frames ()) (locals (c.71 tmp-ra.106)))
      (begin
        (set! tmp-ra.106 r15)
        (set! c.71 rdi)
        (set! rax 22)
        (jump tmp-ra.106 rbp rax)))
    (define L.fun/empty8535.4.12
      ((new-frames ()) (locals (c.70 tmp-ra.107)))
      (begin
        (set! tmp-ra.107 r15)
        (set! c.70 rdi)
        (set! rax 22)
        (jump tmp-ra.107 rbp rax)))
    (define L.make-vector.62.11
      ((new-frames ())
       (locals
        (c.69 make-init-vector.1 tmp-ra.108 tmp.84 tmp.38 tmp.114 tmp.83)))
      (begin
        (set! tmp-ra.108 r15)
        (set! c.69 rdi)
        (set! tmp.38 rsi)
        (set! make-init-vector.1 (mref c.69 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.114 tmp.38)
                      (set! tmp.114 (bitwise-and tmp.114 7))
                      (set! tmp.84 tmp.114))
                    (= tmp.84 0))
                (set! tmp.83 14)
                (set! tmp.83 6))
              (!= tmp.83 6))
          (begin
            (set! rsi tmp.38)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.108)
            (jump L.make-init-vector.1.10 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.108 rbp rax)))))
    (define L.make-init-vector.1.10
      ((new-frames ())
       (locals
        (tmp.11
         tmp.73
         tmp.118
         tmp.85
         tmp.86
         tmp.117
         tmp.87
         tmp.116
         tmp.88
         tmp.115
         vector-init-loop.12
         tmp.10
         c.68
         tmp-ra.109)))
      (begin
        (set! tmp-ra.109 r15)
        (set! c.68 rdi)
        (set! tmp.10 rsi)
        (set! vector-init-loop.12 (mref c.68 14))
        (set! tmp.115 tmp.10)
        (set! tmp.115 (arithmetic-shift-right tmp.115 3))
        (set! tmp.88 tmp.115)
        (set! tmp.116 1)
        (set! tmp.116 (+ tmp.116 tmp.88))
        (set! tmp.87 tmp.116)
        (set! tmp.117 tmp.87)
        (set! tmp.117 (* tmp.117 8))
        (set! tmp.86 tmp.117)
        (begin (set! tmp.85 r12) (set! r12 (+ r12 tmp.86)))
        (set! tmp.118 tmp.85)
        (set! tmp.118 (+ tmp.118 3))
        (set! tmp.73 tmp.118)
        (mset! tmp.73 -3 tmp.10)
        (set! tmp.11 tmp.73)
        (set! rcx tmp.11)
        (set! rdx 0)
        (set! rsi tmp.10)
        (set! rdi vector-init-loop.12)
        (set! r15 tmp-ra.109)
        (jump L.vector-init-loop.12.9 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.12.9
      ((new-frames ())
       (locals
        (c.67
         tmp.119
         tmp.92
         tmp.120
         tmp.91
         tmp.121
         tmp.90
         tmp.122
         tmp.93
         vector-init-loop.12
         tmp-ra.110
         vec.14
         len.13
         i.15
         tmp.89)))
      (begin
        (set! tmp-ra.110 r15)
        (set! c.67 rdi)
        (set! len.13 rsi)
        (set! i.15 rdx)
        (set! vec.14 rcx)
        (set! vector-init-loop.12 (mref c.67 14))
        (if (begin
              (if (= len.13 i.15) (set! tmp.89 14) (set! tmp.89 6))
              (!= tmp.89 6))
          (begin (set! rax vec.14) (jump tmp-ra.110 rbp rax))
          (begin
            (set! tmp.119 i.15)
            (set! tmp.119 (arithmetic-shift-right tmp.119 3))
            (set! tmp.92 tmp.119)
            (set! tmp.120 tmp.92)
            (set! tmp.120 (* tmp.120 8))
            (set! tmp.91 tmp.120)
            (set! tmp.121 tmp.91)
            (set! tmp.121 (+ tmp.121 5))
            (set! tmp.90 tmp.121)
            (mset! vec.14 tmp.90 0)
            (set! tmp.122 i.15)
            (set! tmp.122 (+ tmp.122 8))
            (set! tmp.93 tmp.122)
            (set! rcx vec.14)
            (set! rdx tmp.93)
            (set! rsi len.13)
            (set! rdi vector-init-loop.12)
            (set! r15 tmp-ra.110)
            (jump L.vector-init-loop.12.9 rbp r15 rdi rsi rdx rcx)))))
    (define L.cons.63.8
      ((new-frames ())
       (locals (tmp.74 tmp.123 tmp.94 tmp.58 tmp.57 c.66 tmp-ra.111)))
      (begin
        (set! tmp-ra.111 r15)
        (set! c.66 rdi)
        (set! tmp.57 rsi)
        (set! tmp.58 rdx)
        (begin (set! tmp.94 r12) (set! r12 (+ r12 16)))
        (set! tmp.123 tmp.94)
        (set! tmp.123 (+ tmp.123 1))
        (set! tmp.74 tmp.123)
        (mset! tmp.74 -1 tmp.57)
        (mset! tmp.74 7 tmp.58)
        (set! rax tmp.74)
        (jump tmp-ra.111 rbp rax)))
    (define L.boolean?.64.7
      ((new-frames ()) (locals (c.65 tmp-ra.112 tmp.124 tmp.48 tmp.95)))
      (begin
        (set! tmp-ra.112 r15)
        (set! c.65 rdi)
        (set! tmp.48 rsi)
        (if (begin
              (begin
                (set! tmp.124 tmp.48)
                (set! tmp.124 (bitwise-and tmp.124 247))
                (set! tmp.95 tmp.124))
              (= tmp.95 6))
          (begin (set! rax 14) (jump tmp-ra.112 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.112 rbp rax)))))
    (begin
      (set! tmp-ra.113 r15)
      (begin (set! tmp.96 r12) (set! r12 (+ r12 16)))
      (set! tmp.125 tmp.96)
      (set! tmp.125 (+ tmp.125 2))
      (set! tmp.75 tmp.125)
      (mset! tmp.75 -2 L.boolean?.64.7)
      (mset! tmp.75 6 8)
      (set! boolean?.64 tmp.75)
      (begin (set! tmp.97 r12) (set! r12 (+ r12 16)))
      (set! tmp.126 tmp.97)
      (set! tmp.126 (+ tmp.126 2))
      (set! tmp.76 tmp.126)
      (mset! tmp.76 -2 L.cons.63.8)
      (mset! tmp.76 6 16)
      (set! cons.63 tmp.76)
      (begin (set! tmp.98 r12) (set! r12 (+ r12 24)))
      (set! tmp.127 tmp.98)
      (set! tmp.127 (+ tmp.127 2))
      (set! tmp.77 tmp.127)
      (mset! tmp.77 -2 L.vector-init-loop.12.9)
      (mset! tmp.77 6 24)
      (set! vector-init-loop.12 tmp.77)
      (begin (set! tmp.99 r12) (set! r12 (+ r12 24)))
      (set! tmp.128 tmp.99)
      (set! tmp.128 (+ tmp.128 2))
      (set! tmp.78 tmp.128)
      (mset! tmp.78 -2 L.make-init-vector.1.10)
      (mset! tmp.78 6 8)
      (set! make-init-vector.1 tmp.78)
      (begin (set! tmp.100 r12) (set! r12 (+ r12 24)))
      (set! tmp.129 tmp.100)
      (set! tmp.129 (+ tmp.129 2))
      (set! tmp.79 tmp.129)
      (mset! tmp.79 -2 L.make-vector.62.11)
      (mset! tmp.79 6 8)
      (set! make-vector.62 tmp.79)
      (begin (set! tmp.101 r12) (set! r12 (+ r12 16)))
      (set! tmp.130 tmp.101)
      (set! tmp.130 (+ tmp.130 2))
      (set! tmp.80 tmp.130)
      (mset! tmp.80 -2 L.fun/empty8535.4.12)
      (mset! tmp.80 6 0)
      (set! fun/empty8535.4 tmp.80)
      (begin (set! tmp.102 r12) (set! r12 (+ r12 16)))
      (set! tmp.131 tmp.102)
      (set! tmp.131 (+ tmp.131 2))
      (set! tmp.81 tmp.131)
      (mset! tmp.81 -2 L.fun/empty8537.5.13)
      (mset! tmp.81 6 0)
      (set! fun/empty8537.5 tmp.81)
      (begin (set! tmp.103 r12) (set! r12 (+ r12 24)))
      (set! tmp.132 tmp.103)
      (set! tmp.132 (+ tmp.132 2))
      (set! tmp.82 tmp.132)
      (mset! tmp.82 -2 L.fun/vector8536.6.14)
      (mset! tmp.82 6 0)
      (set! fun/vector8536.6 tmp.82)
      (mset! vector-init-loop.12 14 vector-init-loop.12)
      (mset! make-init-vector.1 14 vector-init-loop.12)
      (mset! make-vector.62 14 make-init-vector.1)
      (mset! fun/vector8536.6 14 make-vector.62)
      (return-point L.rp.15
        (begin
          (set! rdi fun/empty8535.4)
          (set! r15 L.rp.15)
          (jump L.fun/empty8535.4.12 rbp r15 rdi)))
      (set! empty0.9 rax)
      (return-point L.rp.16
        (begin
          (set! rdx 3312)
          (set! rsi 640)
          (set! rdi cons.63)
          (set! r15 L.rp.16)
          (jump L.cons.63.8 rbp r15 rdi rsi rdx)))
      (set! tmp.104 rax)
      (return-point L.rp.17
        (begin
          (set! rsi tmp.104)
          (set! rdi boolean?.64)
          (set! r15 L.rp.17)
          (jump L.boolean?.64.7 rbp r15 rdi rsi)))
      (set! boolean1.8 rax)
      (return-point L.rp.18
        (begin
          (set! rdi fun/vector8536.6)
          (set! r15 L.rp.18)
          (jump L.fun/vector8536.6.14 rbp r15 rdi)))
      (set! vector2.7 rax)
      (set! rdi fun/empty8537.5)
      (set! r15 tmp-ra.113)
      (jump L.fun/empty8537.5.13 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() ()))
     (locals
      (tmp.89
       tmp.107
       tmp.91
       tmp.90
       tmp.106
       tmp.88
       fun/empty8564.8
       tmp.80
       tmp.105
       tmp.87
       fun/ascii-char8563.7
       tmp.79
       tmp.104
       tmp.86
       fun/pair8560.6
       tmp.78
       tmp.103
       tmp.85
       fun/ascii-char8562.5
       tmp.77
       tmp.102
       tmp.84
       fun/pair8561.4
       tmp.76
       tmp.101
       tmp.83
       cons.67
       tmp.75
       tmp.100
       tmp.82
       tmp-ra.98)))
    (define L.fun/empty8564.8.12
      ((new-frames ()) (locals (oprand1.13 oprand0.14 c.73 tmp-ra.92)))
      (begin
        (set! tmp-ra.92 r15)
        (set! c.73 rdi)
        (set! oprand0.14 rsi)
        (set! oprand1.13 rdx)
        (set! rax 22)
        (jump tmp-ra.92 rbp rax)))
    (define L.fun/ascii-char8563.7.11
      ((new-frames ()) (locals (c.72 tmp-ra.93)))
      (begin
        (set! tmp-ra.93 r15)
        (set! c.72 rdi)
        (set! rax 29486)
        (jump tmp-ra.93 rbp rax)))
    (define L.fun/pair8560.6.10
      ((new-frames ())
       (locals (fun/pair8561.4 oprand1.11 oprand0.12 c.71 tmp-ra.94)))
      (begin
        (set! tmp-ra.94 r15)
        (set! c.71 rdi)
        (set! oprand0.12 rsi)
        (set! oprand1.11 rdx)
        (set! fun/pair8561.4 (mref c.71 14))
        (set! rdi fun/pair8561.4)
        (set! r15 tmp-ra.94)
        (jump L.fun/pair8561.4.8 rbp r15 rdi)))
    (define L.fun/ascii-char8562.5.9
      ((new-frames ())
       (locals (fun/ascii-char8563.7 oprand1.9 oprand0.10 c.70 tmp-ra.95)))
      (begin
        (set! tmp-ra.95 r15)
        (set! c.70 rdi)
        (set! oprand0.10 rsi)
        (set! oprand1.9 rdx)
        (set! fun/ascii-char8563.7 (mref c.70 14))
        (set! rdi fun/ascii-char8563.7)
        (set! r15 tmp-ra.95)
        (jump L.fun/ascii-char8563.7.11 rbp r15 rdi)))
    (define L.fun/pair8561.4.8
      ((new-frames ()) (locals (cons.67 c.69 tmp-ra.96)))
      (begin
        (set! tmp-ra.96 r15)
        (set! c.69 rdi)
        (set! cons.67 (mref c.69 14))
        (set! rdx 3192)
        (set! rsi 2008)
        (set! rdi cons.67)
        (set! r15 tmp-ra.96)
        (jump L.cons.67.7 rbp r15 rdi rsi rdx)))
    (define L.cons.67.7
      ((new-frames ())
       (locals (tmp.74 tmp.99 tmp.81 tmp.63 tmp.62 c.68 tmp-ra.97)))
      (begin
        (set! tmp-ra.97 r15)
        (set! c.68 rdi)
        (set! tmp.62 rsi)
        (set! tmp.63 rdx)
        (begin (set! tmp.81 r12) (set! r12 (+ r12 16)))
        (set! tmp.99 tmp.81)
        (set! tmp.99 (+ tmp.99 1))
        (set! tmp.74 tmp.99)
        (mset! tmp.74 -1 tmp.62)
        (mset! tmp.74 7 tmp.63)
        (set! rax tmp.74)
        (jump tmp-ra.97 rbp rax)))
    (begin
      (set! tmp-ra.98 r15)
      (begin (set! tmp.82 r12) (set! r12 (+ r12 16)))
      (set! tmp.100 tmp.82)
      (set! tmp.100 (+ tmp.100 2))
      (set! tmp.75 tmp.100)
      (mset! tmp.75 -2 L.cons.67.7)
      (mset! tmp.75 6 16)
      (set! cons.67 tmp.75)
      (begin (set! tmp.83 r12) (set! r12 (+ r12 24)))
      (set! tmp.101 tmp.83)
      (set! tmp.101 (+ tmp.101 2))
      (set! tmp.76 tmp.101)
      (mset! tmp.76 -2 L.fun/pair8561.4.8)
      (mset! tmp.76 6 0)
      (set! fun/pair8561.4 tmp.76)
      (begin (set! tmp.84 r12) (set! r12 (+ r12 24)))
      (set! tmp.102 tmp.84)
      (set! tmp.102 (+ tmp.102 2))
      (set! tmp.77 tmp.102)
      (mset! tmp.77 -2 L.fun/ascii-char8562.5.9)
      (mset! tmp.77 6 16)
      (set! fun/ascii-char8562.5 tmp.77)
      (begin (set! tmp.85 r12) (set! r12 (+ r12 24)))
      (set! tmp.103 tmp.85)
      (set! tmp.103 (+ tmp.103 2))
      (set! tmp.78 tmp.103)
      (mset! tmp.78 -2 L.fun/pair8560.6.10)
      (mset! tmp.78 6 16)
      (set! fun/pair8560.6 tmp.78)
      (begin (set! tmp.86 r12) (set! r12 (+ r12 16)))
      (set! tmp.104 tmp.86)
      (set! tmp.104 (+ tmp.104 2))
      (set! tmp.79 tmp.104)
      (mset! tmp.79 -2 L.fun/ascii-char8563.7.11)
      (mset! tmp.79 6 0)
      (set! fun/ascii-char8563.7 tmp.79)
      (begin (set! tmp.87 r12) (set! r12 (+ r12 16)))
      (set! tmp.105 tmp.87)
      (set! tmp.105 (+ tmp.105 2))
      (set! tmp.80 tmp.105)
      (mset! tmp.80 -2 L.fun/empty8564.8.12)
      (mset! tmp.80 6 16)
      (set! fun/empty8564.8 tmp.80)
      (mset! fun/pair8561.4 14 cons.67)
      (mset! fun/ascii-char8562.5 14 fun/ascii-char8563.7)
      (mset! fun/pair8560.6 14 fun/pair8561.4)
      (if (begin (set! tmp.106 6) (!= tmp.106 6))
        (set! tmp.88 488)
        (set! tmp.88 592))
      (return-point L.rp.13
        (begin
          (set! rdx 29230)
          (set! rsi 22)
          (set! rdi fun/empty8564.8)
          (set! r15 L.rp.13)
          (jump L.fun/empty8564.8.12 rbp r15 rdi rsi rdx)))
      (set! tmp.90 rax)
      (if (begin (set! tmp.107 14) (!= tmp.107 6))
        (set! tmp.91 14)
        (set! tmp.91 6))
      (return-point L.rp.14
        (begin
          (set! rdx tmp.91)
          (set! rsi tmp.90)
          (set! rdi fun/ascii-char8562.5)
          (set! r15 L.rp.14)
          (jump L.fun/ascii-char8562.5.9 rbp r15 rdi rsi rdx)))
      (set! tmp.89 rax)
      (set! rdx tmp.89)
      (set! rsi tmp.88)
      (set! rdi fun/pair8560.6)
      (set! r15 tmp-ra.98)
      (jump L.fun/pair8560.6.10 rbp r15 rdi rsi rdx))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ()))
     (locals
      (ascii-char3.8
       vector2.9
       void1.10
       fixnum0.11
       tmp.124
       tmp.123
       fun/void8611.7
       tmp.88
       tmp.164
       tmp.122
       fun/ascii-char8614.6
       tmp.87
       tmp.163
       tmp.121
       fun/vector8612.5
       tmp.86
       tmp.162
       tmp.120
       fun/ascii-char8613.4
       tmp.85
       tmp.161
       tmp.119
       make-vector.64
       tmp.84
       tmp.160
       tmp.118
       make-init-vector.1
       tmp.83
       tmp.159
       tmp.117
       vector-init-loop.14
       tmp.82
       tmp.158
       tmp.116
       *.65
       tmp.81
       tmp.157
       tmp.115
       |-.66|
       tmp.80
       tmp.156
       tmp.114
       |+.67|
       tmp.79
       tmp.155
       tmp.113
       tmp-ra.135)))
    (define L.fun/void8611.7.16
      ((new-frames ()) (locals (c.77 tmp-ra.125)))
      (begin
        (set! tmp-ra.125 r15)
        (set! c.77 rdi)
        (set! rax 30)
        (jump tmp-ra.125 rbp rax)))
    (define L.fun/ascii-char8614.6.15
      ((new-frames ()) (locals (c.76 tmp-ra.126)))
      (begin
        (set! tmp-ra.126 r15)
        (set! c.76 rdi)
        (set! rax 21294)
        (jump tmp-ra.126 rbp rax)))
    (define L.fun/vector8612.5.14
      ((new-frames ()) (locals (make-vector.64 c.75 tmp-ra.127)))
      (begin
        (set! tmp-ra.127 r15)
        (set! c.75 rdi)
        (set! make-vector.64 (mref c.75 14))
        (set! rsi 64)
        (set! rdi make-vector.64)
        (set! r15 tmp-ra.127)
        (jump L.make-vector.64.12 rbp r15 rdi rsi)))
    (define L.fun/ascii-char8613.4.13
      ((new-frames ()) (locals (c.74 tmp-ra.128)))
      (begin
        (set! tmp-ra.128 r15)
        (set! c.74 rdi)
        (set! rax 16942)
        (jump tmp-ra.128 rbp rax)))
    (define L.make-vector.64.12
      ((new-frames ())
       (locals
        (c.73 make-init-vector.1 tmp-ra.129 tmp.90 tmp.40 tmp.136 tmp.89)))
      (begin
        (set! tmp-ra.129 r15)
        (set! c.73 rdi)
        (set! tmp.40 rsi)
        (set! make-init-vector.1 (mref c.73 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.136 tmp.40)
                      (set! tmp.136 (bitwise-and tmp.136 7))
                      (set! tmp.90 tmp.136))
                    (= tmp.90 0))
                (set! tmp.89 14)
                (set! tmp.89 6))
              (!= tmp.89 6))
          (begin
            (set! rsi tmp.40)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.129)
            (jump L.make-init-vector.1.11 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.129 rbp rax)))))
    (define L.make-init-vector.1.11
      ((new-frames ())
       (locals
        (tmp.13
         tmp.78
         tmp.140
         tmp.91
         tmp.92
         tmp.139
         tmp.93
         tmp.138
         tmp.94
         tmp.137
         vector-init-loop.14
         tmp.12
         c.72
         tmp-ra.130)))
      (begin
        (set! tmp-ra.130 r15)
        (set! c.72 rdi)
        (set! tmp.12 rsi)
        (set! vector-init-loop.14 (mref c.72 14))
        (set! tmp.137 tmp.12)
        (set! tmp.137 (arithmetic-shift-right tmp.137 3))
        (set! tmp.94 tmp.137)
        (set! tmp.138 1)
        (set! tmp.138 (+ tmp.138 tmp.94))
        (set! tmp.93 tmp.138)
        (set! tmp.139 tmp.93)
        (set! tmp.139 (* tmp.139 8))
        (set! tmp.92 tmp.139)
        (begin (set! tmp.91 r12) (set! r12 (+ r12 tmp.92)))
        (set! tmp.140 tmp.91)
        (set! tmp.140 (+ tmp.140 3))
        (set! tmp.78 tmp.140)
        (mset! tmp.78 -3 tmp.12)
        (set! tmp.13 tmp.78)
        (set! rcx tmp.13)
        (set! rdx 0)
        (set! rsi tmp.12)
        (set! rdi vector-init-loop.14)
        (set! r15 tmp-ra.130)
        (jump L.vector-init-loop.14.10 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.14.10
      ((new-frames ())
       (locals
        (c.71
         tmp.141
         tmp.98
         tmp.142
         tmp.97
         tmp.143
         tmp.96
         tmp.144
         tmp.99
         vector-init-loop.14
         tmp-ra.131
         vec.16
         len.15
         i.17
         tmp.95)))
      (begin
        (set! tmp-ra.131 r15)
        (set! c.71 rdi)
        (set! len.15 rsi)
        (set! i.17 rdx)
        (set! vec.16 rcx)
        (set! vector-init-loop.14 (mref c.71 14))
        (if (begin
              (if (= len.15 i.17) (set! tmp.95 14) (set! tmp.95 6))
              (!= tmp.95 6))
          (begin (set! rax vec.16) (jump tmp-ra.131 rbp rax))
          (begin
            (set! tmp.141 i.17)
            (set! tmp.141 (arithmetic-shift-right tmp.141 3))
            (set! tmp.98 tmp.141)
            (set! tmp.142 tmp.98)
            (set! tmp.142 (* tmp.142 8))
            (set! tmp.97 tmp.142)
            (set! tmp.143 tmp.97)
            (set! tmp.143 (+ tmp.143 5))
            (set! tmp.96 tmp.143)
            (mset! vec.16 tmp.96 0)
            (set! tmp.144 i.17)
            (set! tmp.144 (+ tmp.144 8))
            (set! tmp.99 tmp.144)
            (set! rcx vec.16)
            (set! rdx tmp.99)
            (set! rsi len.15)
            (set! rdi vector-init-loop.14)
            (set! r15 tmp-ra.131)
            (jump L.vector-init-loop.14.10 rbp r15 rdi rsi rdx rcx)))))
    (define L.*.65.9
      ((new-frames ())
       (locals
        (c.70
         tmp.102
         tmp.146
         tmp.26
         tmp.103
         tmp.148
         tmp.104
         tmp.147
         tmp-ra.132
         tmp.101
         tmp.27
         tmp.145
         tmp.100)))
      (begin
        (set! tmp-ra.132 r15)
        (set! c.70 rdi)
        (set! tmp.26 rsi)
        (set! tmp.27 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.145 tmp.27)
                      (set! tmp.145 (bitwise-and tmp.145 7))
                      (set! tmp.101 tmp.145))
                    (= tmp.101 0))
                (set! tmp.100 14)
                (set! tmp.100 6))
              (!= tmp.100 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.146 tmp.26)
                        (set! tmp.146 (bitwise-and tmp.146 7))
                        (set! tmp.103 tmp.146))
                      (= tmp.103 0))
                  (set! tmp.102 14)
                  (set! tmp.102 6))
                (!= tmp.102 6))
            (begin
              (set! tmp.147 tmp.27)
              (set! tmp.147 (arithmetic-shift-right tmp.147 3))
              (set! tmp.104 tmp.147)
              (set! tmp.148 tmp.26)
              (set! tmp.148 (* tmp.148 tmp.104))
              (set! rax tmp.148)
              (jump tmp-ra.132 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.132 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.132 rbp rax)))))
    (define L.-.66.8
      ((new-frames ())
       (locals
        (c.69
         tmp.107
         tmp.150
         tmp.30
         tmp.108
         tmp.151
         tmp-ra.133
         tmp.106
         tmp.31
         tmp.149
         tmp.105)))
      (begin
        (set! tmp-ra.133 r15)
        (set! c.69 rdi)
        (set! tmp.30 rsi)
        (set! tmp.31 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.149 tmp.31)
                      (set! tmp.149 (bitwise-and tmp.149 7))
                      (set! tmp.106 tmp.149))
                    (= tmp.106 0))
                (set! tmp.105 14)
                (set! tmp.105 6))
              (!= tmp.105 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.150 tmp.30)
                        (set! tmp.150 (bitwise-and tmp.150 7))
                        (set! tmp.108 tmp.150))
                      (= tmp.108 0))
                  (set! tmp.107 14)
                  (set! tmp.107 6))
                (!= tmp.107 6))
            (begin
              (set! tmp.151 tmp.30)
              (set! tmp.151 (- tmp.151 tmp.31))
              (set! rax tmp.151)
              (jump tmp-ra.133 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.133 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.133 rbp rax)))))
    (define L.+.67.7
      ((new-frames ())
       (locals
        (c.68
         tmp.111
         tmp.153
         tmp.28
         tmp.112
         tmp.154
         tmp-ra.134
         tmp.110
         tmp.29
         tmp.152
         tmp.109)))
      (begin
        (set! tmp-ra.134 r15)
        (set! c.68 rdi)
        (set! tmp.28 rsi)
        (set! tmp.29 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.152 tmp.29)
                      (set! tmp.152 (bitwise-and tmp.152 7))
                      (set! tmp.110 tmp.152))
                    (= tmp.110 0))
                (set! tmp.109 14)
                (set! tmp.109 6))
              (!= tmp.109 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.153 tmp.28)
                        (set! tmp.153 (bitwise-and tmp.153 7))
                        (set! tmp.112 tmp.153))
                      (= tmp.112 0))
                  (set! tmp.111 14)
                  (set! tmp.111 6))
                (!= tmp.111 6))
            (begin
              (set! tmp.154 tmp.28)
              (set! tmp.154 (+ tmp.154 tmp.29))
              (set! rax tmp.154)
              (jump tmp-ra.134 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.134 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.134 rbp rax)))))
    (begin
      (set! tmp-ra.135 r15)
      (begin (set! tmp.113 r12) (set! r12 (+ r12 16)))
      (set! tmp.155 tmp.113)
      (set! tmp.155 (+ tmp.155 2))
      (set! tmp.79 tmp.155)
      (mset! tmp.79 -2 L.+.67.7)
      (mset! tmp.79 6 16)
      (set! |+.67| tmp.79)
      (begin (set! tmp.114 r12) (set! r12 (+ r12 16)))
      (set! tmp.156 tmp.114)
      (set! tmp.156 (+ tmp.156 2))
      (set! tmp.80 tmp.156)
      (mset! tmp.80 -2 L.-.66.8)
      (mset! tmp.80 6 16)
      (set! |-.66| tmp.80)
      (begin (set! tmp.115 r12) (set! r12 (+ r12 16)))
      (set! tmp.157 tmp.115)
      (set! tmp.157 (+ tmp.157 2))
      (set! tmp.81 tmp.157)
      (mset! tmp.81 -2 L.*.65.9)
      (mset! tmp.81 6 16)
      (set! *.65 tmp.81)
      (begin (set! tmp.116 r12) (set! r12 (+ r12 24)))
      (set! tmp.158 tmp.116)
      (set! tmp.158 (+ tmp.158 2))
      (set! tmp.82 tmp.158)
      (mset! tmp.82 -2 L.vector-init-loop.14.10)
      (mset! tmp.82 6 24)
      (set! vector-init-loop.14 tmp.82)
      (begin (set! tmp.117 r12) (set! r12 (+ r12 24)))
      (set! tmp.159 tmp.117)
      (set! tmp.159 (+ tmp.159 2))
      (set! tmp.83 tmp.159)
      (mset! tmp.83 -2 L.make-init-vector.1.11)
      (mset! tmp.83 6 8)
      (set! make-init-vector.1 tmp.83)
      (begin (set! tmp.118 r12) (set! r12 (+ r12 24)))
      (set! tmp.160 tmp.118)
      (set! tmp.160 (+ tmp.160 2))
      (set! tmp.84 tmp.160)
      (mset! tmp.84 -2 L.make-vector.64.12)
      (mset! tmp.84 6 8)
      (set! make-vector.64 tmp.84)
      (begin (set! tmp.119 r12) (set! r12 (+ r12 16)))
      (set! tmp.161 tmp.119)
      (set! tmp.161 (+ tmp.161 2))
      (set! tmp.85 tmp.161)
      (mset! tmp.85 -2 L.fun/ascii-char8613.4.13)
      (mset! tmp.85 6 0)
      (set! fun/ascii-char8613.4 tmp.85)
      (begin (set! tmp.120 r12) (set! r12 (+ r12 24)))
      (set! tmp.162 tmp.120)
      (set! tmp.162 (+ tmp.162 2))
      (set! tmp.86 tmp.162)
      (mset! tmp.86 -2 L.fun/vector8612.5.14)
      (mset! tmp.86 6 0)
      (set! fun/vector8612.5 tmp.86)
      (begin (set! tmp.121 r12) (set! r12 (+ r12 16)))
      (set! tmp.163 tmp.121)
      (set! tmp.163 (+ tmp.163 2))
      (set! tmp.87 tmp.163)
      (mset! tmp.87 -2 L.fun/ascii-char8614.6.15)
      (mset! tmp.87 6 0)
      (set! fun/ascii-char8614.6 tmp.87)
      (begin (set! tmp.122 r12) (set! r12 (+ r12 16)))
      (set! tmp.164 tmp.122)
      (set! tmp.164 (+ tmp.164 2))
      (set! tmp.88 tmp.164)
      (mset! tmp.88 -2 L.fun/void8611.7.16)
      (mset! tmp.88 6 0)
      (set! fun/void8611.7 tmp.88)
      (mset! vector-init-loop.14 14 vector-init-loop.14)
      (mset! make-init-vector.1 14 vector-init-loop.14)
      (mset! make-vector.64 14 make-init-vector.1)
      (mset! fun/vector8612.5 14 make-vector.64)
      (return-point L.rp.17
        (begin
          (set! rdx 1608)
          (set! rsi 616)
          (set! rdi *.65)
          (set! r15 L.rp.17)
          (jump L.*.65.9 rbp r15 rdi rsi rdx)))
      (set! tmp.123 rax)
      (return-point L.rp.18
        (begin
          (set! rdx 320)
          (set! rsi 424)
          (set! rdi |-.66|)
          (set! r15 L.rp.18)
          (jump L.-.66.8 rbp r15 rdi rsi rdx)))
      (set! tmp.124 rax)
      (return-point L.rp.19
        (begin
          (set! rdx tmp.124)
          (set! rsi tmp.123)
          (set! rdi |+.67|)
          (set! r15 L.rp.19)
          (jump L.+.67.7 rbp r15 rdi rsi rdx)))
      (set! fixnum0.11 rax)
      (return-point L.rp.20
        (begin
          (set! rdi fun/void8611.7)
          (set! r15 L.rp.20)
          (jump L.fun/void8611.7.16 rbp r15 rdi)))
      (set! void1.10 rax)
      (return-point L.rp.21
        (begin
          (set! rdi fun/vector8612.5)
          (set! r15 L.rp.21)
          (jump L.fun/vector8612.5.14 rbp r15 rdi)))
      (set! vector2.9 rax)
      (return-point L.rp.22
        (begin
          (set! rdi fun/ascii-char8613.4)
          (set! r15 L.rp.22)
          (jump L.fun/ascii-char8613.4.13 rbp r15 rdi)))
      (set! ascii-char3.8 rax)
      (set! rdi fun/ascii-char8614.6)
      (set! r15 tmp-ra.135)
      (jump L.fun/ascii-char8614.6.15 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () ()))
     (locals
      (void3.7
       fixnum2.8
       tmp.122
       tmp.121
       ascii-char1.9
       fixnum0.10
       tmp.120
       tmp.119
       fun/void8618.6
       tmp.85
       tmp.160
       tmp.118
       fun/vector8619.5
       tmp.84
       tmp.159
       tmp.117
       fun/ascii-char8617.4
       tmp.83
       tmp.158
       tmp.116
       make-vector.63
       tmp.82
       tmp.157
       tmp.115
       make-init-vector.1
       tmp.81
       tmp.156
       tmp.114
       vector-init-loop.13
       tmp.80
       tmp.155
       tmp.113
       |+.64|
       tmp.79
       tmp.154
       tmp.112
       *.65
       tmp.78
       tmp.153
       tmp.111
       |-.66|
       tmp.77
       tmp.152
       tmp.110
       tmp-ra.132)))
    (define L.fun/void8618.6.15
      ((new-frames ()) (locals (c.75 tmp-ra.123)))
      (begin
        (set! tmp-ra.123 r15)
        (set! c.75 rdi)
        (set! rax 30)
        (jump tmp-ra.123 rbp rax)))
    (define L.fun/vector8619.5.14
      ((new-frames ()) (locals (make-vector.63 c.74 tmp-ra.124)))
      (begin
        (set! tmp-ra.124 r15)
        (set! c.74 rdi)
        (set! make-vector.63 (mref c.74 14))
        (set! rsi 64)
        (set! rdi make-vector.63)
        (set! r15 tmp-ra.124)
        (jump L.make-vector.63.12 rbp r15 rdi rsi)))
    (define L.fun/ascii-char8617.4.13
      ((new-frames ()) (locals (c.73 tmp-ra.125)))
      (begin
        (set! tmp-ra.125 r15)
        (set! c.73 rdi)
        (set! rax 22574)
        (jump tmp-ra.125 rbp rax)))
    (define L.make-vector.63.12
      ((new-frames ())
       (locals
        (c.72 make-init-vector.1 tmp-ra.126 tmp.87 tmp.39 tmp.133 tmp.86)))
      (begin
        (set! tmp-ra.126 r15)
        (set! c.72 rdi)
        (set! tmp.39 rsi)
        (set! make-init-vector.1 (mref c.72 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.133 tmp.39)
                      (set! tmp.133 (bitwise-and tmp.133 7))
                      (set! tmp.87 tmp.133))
                    (= tmp.87 0))
                (set! tmp.86 14)
                (set! tmp.86 6))
              (!= tmp.86 6))
          (begin
            (set! rsi tmp.39)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.126)
            (jump L.make-init-vector.1.11 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.126 rbp rax)))))
    (define L.make-init-vector.1.11
      ((new-frames ())
       (locals
        (tmp.12
         tmp.76
         tmp.137
         tmp.88
         tmp.89
         tmp.136
         tmp.90
         tmp.135
         tmp.91
         tmp.134
         vector-init-loop.13
         tmp.11
         c.71
         tmp-ra.127)))
      (begin
        (set! tmp-ra.127 r15)
        (set! c.71 rdi)
        (set! tmp.11 rsi)
        (set! vector-init-loop.13 (mref c.71 14))
        (set! tmp.134 tmp.11)
        (set! tmp.134 (arithmetic-shift-right tmp.134 3))
        (set! tmp.91 tmp.134)
        (set! tmp.135 1)
        (set! tmp.135 (+ tmp.135 tmp.91))
        (set! tmp.90 tmp.135)
        (set! tmp.136 tmp.90)
        (set! tmp.136 (* tmp.136 8))
        (set! tmp.89 tmp.136)
        (begin (set! tmp.88 r12) (set! r12 (+ r12 tmp.89)))
        (set! tmp.137 tmp.88)
        (set! tmp.137 (+ tmp.137 3))
        (set! tmp.76 tmp.137)
        (mset! tmp.76 -3 tmp.11)
        (set! tmp.12 tmp.76)
        (set! rcx tmp.12)
        (set! rdx 0)
        (set! rsi tmp.11)
        (set! rdi vector-init-loop.13)
        (set! r15 tmp-ra.127)
        (jump L.vector-init-loop.13.10 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.13.10
      ((new-frames ())
       (locals
        (c.70
         tmp.138
         tmp.95
         tmp.139
         tmp.94
         tmp.140
         tmp.93
         tmp.141
         tmp.96
         vector-init-loop.13
         tmp-ra.128
         vec.15
         len.14
         i.16
         tmp.92)))
      (begin
        (set! tmp-ra.128 r15)
        (set! c.70 rdi)
        (set! len.14 rsi)
        (set! i.16 rdx)
        (set! vec.15 rcx)
        (set! vector-init-loop.13 (mref c.70 14))
        (if (begin
              (if (= len.14 i.16) (set! tmp.92 14) (set! tmp.92 6))
              (!= tmp.92 6))
          (begin (set! rax vec.15) (jump tmp-ra.128 rbp rax))
          (begin
            (set! tmp.138 i.16)
            (set! tmp.138 (arithmetic-shift-right tmp.138 3))
            (set! tmp.95 tmp.138)
            (set! tmp.139 tmp.95)
            (set! tmp.139 (* tmp.139 8))
            (set! tmp.94 tmp.139)
            (set! tmp.140 tmp.94)
            (set! tmp.140 (+ tmp.140 5))
            (set! tmp.93 tmp.140)
            (mset! vec.15 tmp.93 0)
            (set! tmp.141 i.16)
            (set! tmp.141 (+ tmp.141 8))
            (set! tmp.96 tmp.141)
            (set! rcx vec.15)
            (set! rdx tmp.96)
            (set! rsi len.14)
            (set! rdi vector-init-loop.13)
            (set! r15 tmp-ra.128)
            (jump L.vector-init-loop.13.10 rbp r15 rdi rsi rdx rcx)))))
    (define L.+.64.9
      ((new-frames ())
       (locals
        (c.69
         tmp.99
         tmp.143
         tmp.27
         tmp.100
         tmp.144
         tmp-ra.129
         tmp.98
         tmp.28
         tmp.142
         tmp.97)))
      (begin
        (set! tmp-ra.129 r15)
        (set! c.69 rdi)
        (set! tmp.27 rsi)
        (set! tmp.28 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.142 tmp.28)
                      (set! tmp.142 (bitwise-and tmp.142 7))
                      (set! tmp.98 tmp.142))
                    (= tmp.98 0))
                (set! tmp.97 14)
                (set! tmp.97 6))
              (!= tmp.97 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.143 tmp.27)
                        (set! tmp.143 (bitwise-and tmp.143 7))
                        (set! tmp.100 tmp.143))
                      (= tmp.100 0))
                  (set! tmp.99 14)
                  (set! tmp.99 6))
                (!= tmp.99 6))
            (begin
              (set! tmp.144 tmp.27)
              (set! tmp.144 (+ tmp.144 tmp.28))
              (set! rax tmp.144)
              (jump tmp-ra.129 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.129 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.129 rbp rax)))))
    (define L.*.65.8
      ((new-frames ())
       (locals
        (c.68
         tmp.103
         tmp.146
         tmp.25
         tmp.104
         tmp.148
         tmp.105
         tmp.147
         tmp-ra.130
         tmp.102
         tmp.26
         tmp.145
         tmp.101)))
      (begin
        (set! tmp-ra.130 r15)
        (set! c.68 rdi)
        (set! tmp.25 rsi)
        (set! tmp.26 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.145 tmp.26)
                      (set! tmp.145 (bitwise-and tmp.145 7))
                      (set! tmp.102 tmp.145))
                    (= tmp.102 0))
                (set! tmp.101 14)
                (set! tmp.101 6))
              (!= tmp.101 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.146 tmp.25)
                        (set! tmp.146 (bitwise-and tmp.146 7))
                        (set! tmp.104 tmp.146))
                      (= tmp.104 0))
                  (set! tmp.103 14)
                  (set! tmp.103 6))
                (!= tmp.103 6))
            (begin
              (set! tmp.147 tmp.26)
              (set! tmp.147 (arithmetic-shift-right tmp.147 3))
              (set! tmp.105 tmp.147)
              (set! tmp.148 tmp.25)
              (set! tmp.148 (* tmp.148 tmp.105))
              (set! rax tmp.148)
              (jump tmp-ra.130 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.130 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.130 rbp rax)))))
    (define L.-.66.7
      ((new-frames ())
       (locals
        (c.67
         tmp.108
         tmp.150
         tmp.29
         tmp.109
         tmp.151
         tmp-ra.131
         tmp.107
         tmp.30
         tmp.149
         tmp.106)))
      (begin
        (set! tmp-ra.131 r15)
        (set! c.67 rdi)
        (set! tmp.29 rsi)
        (set! tmp.30 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.149 tmp.30)
                      (set! tmp.149 (bitwise-and tmp.149 7))
                      (set! tmp.107 tmp.149))
                    (= tmp.107 0))
                (set! tmp.106 14)
                (set! tmp.106 6))
              (!= tmp.106 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.150 tmp.29)
                        (set! tmp.150 (bitwise-and tmp.150 7))
                        (set! tmp.109 tmp.150))
                      (= tmp.109 0))
                  (set! tmp.108 14)
                  (set! tmp.108 6))
                (!= tmp.108 6))
            (begin
              (set! tmp.151 tmp.29)
              (set! tmp.151 (- tmp.151 tmp.30))
              (set! rax tmp.151)
              (jump tmp-ra.131 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.131 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.131 rbp rax)))))
    (begin
      (set! tmp-ra.132 r15)
      (begin (set! tmp.110 r12) (set! r12 (+ r12 16)))
      (set! tmp.152 tmp.110)
      (set! tmp.152 (+ tmp.152 2))
      (set! tmp.77 tmp.152)
      (mset! tmp.77 -2 L.-.66.7)
      (mset! tmp.77 6 16)
      (set! |-.66| tmp.77)
      (begin (set! tmp.111 r12) (set! r12 (+ r12 16)))
      (set! tmp.153 tmp.111)
      (set! tmp.153 (+ tmp.153 2))
      (set! tmp.78 tmp.153)
      (mset! tmp.78 -2 L.*.65.8)
      (mset! tmp.78 6 16)
      (set! *.65 tmp.78)
      (begin (set! tmp.112 r12) (set! r12 (+ r12 16)))
      (set! tmp.154 tmp.112)
      (set! tmp.154 (+ tmp.154 2))
      (set! tmp.79 tmp.154)
      (mset! tmp.79 -2 L.+.64.9)
      (mset! tmp.79 6 16)
      (set! |+.64| tmp.79)
      (begin (set! tmp.113 r12) (set! r12 (+ r12 24)))
      (set! tmp.155 tmp.113)
      (set! tmp.155 (+ tmp.155 2))
      (set! tmp.80 tmp.155)
      (mset! tmp.80 -2 L.vector-init-loop.13.10)
      (mset! tmp.80 6 24)
      (set! vector-init-loop.13 tmp.80)
      (begin (set! tmp.114 r12) (set! r12 (+ r12 24)))
      (set! tmp.156 tmp.114)
      (set! tmp.156 (+ tmp.156 2))
      (set! tmp.81 tmp.156)
      (mset! tmp.81 -2 L.make-init-vector.1.11)
      (mset! tmp.81 6 8)
      (set! make-init-vector.1 tmp.81)
      (begin (set! tmp.115 r12) (set! r12 (+ r12 24)))
      (set! tmp.157 tmp.115)
      (set! tmp.157 (+ tmp.157 2))
      (set! tmp.82 tmp.157)
      (mset! tmp.82 -2 L.make-vector.63.12)
      (mset! tmp.82 6 8)
      (set! make-vector.63 tmp.82)
      (begin (set! tmp.116 r12) (set! r12 (+ r12 16)))
      (set! tmp.158 tmp.116)
      (set! tmp.158 (+ tmp.158 2))
      (set! tmp.83 tmp.158)
      (mset! tmp.83 -2 L.fun/ascii-char8617.4.13)
      (mset! tmp.83 6 0)
      (set! fun/ascii-char8617.4 tmp.83)
      (begin (set! tmp.117 r12) (set! r12 (+ r12 24)))
      (set! tmp.159 tmp.117)
      (set! tmp.159 (+ tmp.159 2))
      (set! tmp.84 tmp.159)
      (mset! tmp.84 -2 L.fun/vector8619.5.14)
      (mset! tmp.84 6 0)
      (set! fun/vector8619.5 tmp.84)
      (begin (set! tmp.118 r12) (set! r12 (+ r12 16)))
      (set! tmp.160 tmp.118)
      (set! tmp.160 (+ tmp.160 2))
      (set! tmp.85 tmp.160)
      (mset! tmp.85 -2 L.fun/void8618.6.15)
      (mset! tmp.85 6 0)
      (set! fun/void8618.6 tmp.85)
      (mset! vector-init-loop.13 14 vector-init-loop.13)
      (mset! make-init-vector.1 14 vector-init-loop.13)
      (mset! make-vector.63 14 make-init-vector.1)
      (mset! fun/vector8619.5 14 make-vector.63)
      (return-point L.rp.16
        (begin
          (set! rdx 976)
          (set! rsi 1424)
          (set! rdi |+.64|)
          (set! r15 L.rp.16)
          (jump L.+.64.9 rbp r15 rdi rsi rdx)))
      (set! tmp.119 rax)
      (return-point L.rp.17
        (begin
          (set! rdx 696)
          (set! rsi 456)
          (set! rdi |+.64|)
          (set! r15 L.rp.17)
          (jump L.+.64.9 rbp r15 rdi rsi rdx)))
      (set! tmp.120 rax)
      (return-point L.rp.18
        (begin
          (set! rdx tmp.120)
          (set! rsi tmp.119)
          (set! rdi *.65)
          (set! r15 L.rp.18)
          (jump L.*.65.8 rbp r15 rdi rsi rdx)))
      (set! fixnum0.10 rax)
      (return-point L.rp.19
        (begin
          (set! rdi fun/ascii-char8617.4)
          (set! r15 L.rp.19)
          (jump L.fun/ascii-char8617.4.13 rbp r15 rdi)))
      (set! ascii-char1.9 rax)
      (return-point L.rp.20
        (begin
          (set! rdx 16)
          (set! rsi 216)
          (set! rdi |-.66|)
          (set! r15 L.rp.20)
          (jump L.-.66.7 rbp r15 rdi rsi rdx)))
      (set! tmp.121 rax)
      (return-point L.rp.21
        (begin
          (set! rdx 1256)
          (set! rsi 256)
          (set! rdi *.65)
          (set! r15 L.rp.21)
          (jump L.*.65.8 rbp r15 rdi rsi rdx)))
      (set! tmp.122 rax)
      (return-point L.rp.22
        (begin
          (set! rdx tmp.122)
          (set! rsi tmp.121)
          (set! rdi |+.64|)
          (set! r15 L.rp.22)
          (jump L.+.64.9 rbp r15 rdi rsi rdx)))
      (set! fixnum2.8 rax)
      (return-point L.rp.23
        (begin
          (set! rdi fun/void8618.6)
          (set! r15 L.rp.23)
          (jump L.fun/void8618.6.15 rbp r15 rdi)))
      (set! void3.7 rax)
      (set! rdi fun/vector8619.5)
      (set! r15 tmp-ra.132)
      (jump L.fun/vector8619.5.14 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() () () ()))
     (locals
      (procedure3.9
       lam.68
       tmp.91
       tmp.151
       tmp.117
       vector2.10
       boolean1.11
       tmp.116
       void0.12
       fun/vector8772.8
       tmp.90
       tmp.150
       tmp.115
       fun/any8773.7
       tmp.89
       tmp.149
       tmp.114
       fun/void8770.6
       tmp.88
       tmp.148
       tmp.113
       fun/empty8774.5
       tmp.87
       tmp.147
       tmp.112
       fun/any8771.4
       tmp.86
       tmp.146
       tmp.111
       make-vector.65
       tmp.85
       tmp.145
       tmp.110
       make-init-vector.1
       tmp.84
       tmp.144
       tmp.109
       vector-init-loop.15
       tmp.83
       tmp.143
       tmp.108
       error?.66
       tmp.82
       tmp.142
       tmp.107
       vector?.67
       tmp.81
       tmp.141
       tmp.106
       tmp-ra.129)))
    (define L.lam.68.17
      ((new-frames (()))
       (locals (tmp.92 vector?.67 fun/any8773.7 c.79 tmp-ra.118)))
      (begin
        (set! tmp-ra.118 r15)
        (set! c.79 rdi)
        (set! fun/any8773.7 (mref c.79 14))
        (set! vector?.67 (mref c.79 22))
        (return-point L.rp.18
          (begin
            (set! rdi fun/any8773.7)
            (set! r15 L.rp.18)
            (jump L.fun/any8773.7.15 rbp r15 rdi)))
        (set! tmp.92 rax)
        (set! rsi tmp.92)
        (set! rdi vector?.67)
        (set! r15 tmp-ra.118)
        (jump L.vector?.67.7 rbp r15 rdi rsi)))
    (define L.fun/vector8772.8.16
      ((new-frames ()) (locals (make-vector.65 c.78 tmp-ra.119)))
      (begin
        (set! tmp-ra.119 r15)
        (set! c.78 rdi)
        (set! make-vector.65 (mref c.78 14))
        (set! rsi 64)
        (set! rdi make-vector.65)
        (set! r15 tmp-ra.119)
        (jump L.make-vector.65.11 rbp r15 rdi rsi)))
    (define L.fun/any8773.7.15
      ((new-frames ()) (locals (c.77 tmp-ra.120)))
      (begin
        (set! tmp-ra.120 r15)
        (set! c.77 rdi)
        (set! rax 22)
        (jump tmp-ra.120 rbp rax)))
    (define L.fun/void8770.6.14
      ((new-frames ()) (locals (c.76 tmp-ra.121)))
      (begin
        (set! tmp-ra.121 r15)
        (set! c.76 rdi)
        (set! rax 30)
        (jump tmp-ra.121 rbp rax)))
    (define L.fun/empty8774.5.13
      ((new-frames ()) (locals (c.75 tmp-ra.122)))
      (begin
        (set! tmp-ra.122 r15)
        (set! c.75 rdi)
        (set! rax 22)
        (jump tmp-ra.122 rbp rax)))
    (define L.fun/any8771.4.12
      ((new-frames ()) (locals (make-vector.65 c.74 tmp-ra.123)))
      (begin
        (set! tmp-ra.123 r15)
        (set! c.74 rdi)
        (set! make-vector.65 (mref c.74 14))
        (set! rsi 64)
        (set! rdi make-vector.65)
        (set! r15 tmp-ra.123)
        (jump L.make-vector.65.11 rbp r15 rdi rsi)))
    (define L.make-vector.65.11
      ((new-frames ())
       (locals
        (c.73 make-init-vector.1 tmp-ra.124 tmp.94 tmp.41 tmp.130 tmp.93)))
      (begin
        (set! tmp-ra.124 r15)
        (set! c.73 rdi)
        (set! tmp.41 rsi)
        (set! make-init-vector.1 (mref c.73 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.130 tmp.41)
                      (set! tmp.130 (bitwise-and tmp.130 7))
                      (set! tmp.94 tmp.130))
                    (= tmp.94 0))
                (set! tmp.93 14)
                (set! tmp.93 6))
              (!= tmp.93 6))
          (begin
            (set! rsi tmp.41)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.124)
            (jump L.make-init-vector.1.10 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.124 rbp rax)))))
    (define L.make-init-vector.1.10
      ((new-frames ())
       (locals
        (tmp.14
         tmp.80
         tmp.134
         tmp.95
         tmp.96
         tmp.133
         tmp.97
         tmp.132
         tmp.98
         tmp.131
         vector-init-loop.15
         tmp.13
         c.72
         tmp-ra.125)))
      (begin
        (set! tmp-ra.125 r15)
        (set! c.72 rdi)
        (set! tmp.13 rsi)
        (set! vector-init-loop.15 (mref c.72 14))
        (set! tmp.131 tmp.13)
        (set! tmp.131 (arithmetic-shift-right tmp.131 3))
        (set! tmp.98 tmp.131)
        (set! tmp.132 1)
        (set! tmp.132 (+ tmp.132 tmp.98))
        (set! tmp.97 tmp.132)
        (set! tmp.133 tmp.97)
        (set! tmp.133 (* tmp.133 8))
        (set! tmp.96 tmp.133)
        (begin (set! tmp.95 r12) (set! r12 (+ r12 tmp.96)))
        (set! tmp.134 tmp.95)
        (set! tmp.134 (+ tmp.134 3))
        (set! tmp.80 tmp.134)
        (mset! tmp.80 -3 tmp.13)
        (set! tmp.14 tmp.80)
        (set! rcx tmp.14)
        (set! rdx 0)
        (set! rsi tmp.13)
        (set! rdi vector-init-loop.15)
        (set! r15 tmp-ra.125)
        (jump L.vector-init-loop.15.9 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.15.9
      ((new-frames ())
       (locals
        (c.71
         tmp.135
         tmp.102
         tmp.136
         tmp.101
         tmp.137
         tmp.100
         tmp.138
         tmp.103
         vector-init-loop.15
         tmp-ra.126
         vec.17
         len.16
         i.18
         tmp.99)))
      (begin
        (set! tmp-ra.126 r15)
        (set! c.71 rdi)
        (set! len.16 rsi)
        (set! i.18 rdx)
        (set! vec.17 rcx)
        (set! vector-init-loop.15 (mref c.71 14))
        (if (begin
              (if (= len.16 i.18) (set! tmp.99 14) (set! tmp.99 6))
              (!= tmp.99 6))
          (begin (set! rax vec.17) (jump tmp-ra.126 rbp rax))
          (begin
            (set! tmp.135 i.18)
            (set! tmp.135 (arithmetic-shift-right tmp.135 3))
            (set! tmp.102 tmp.135)
            (set! tmp.136 tmp.102)
            (set! tmp.136 (* tmp.136 8))
            (set! tmp.101 tmp.136)
            (set! tmp.137 tmp.101)
            (set! tmp.137 (+ tmp.137 5))
            (set! tmp.100 tmp.137)
            (mset! vec.17 tmp.100 0)
            (set! tmp.138 i.18)
            (set! tmp.138 (+ tmp.138 8))
            (set! tmp.103 tmp.138)
            (set! rcx vec.17)
            (set! rdx tmp.103)
            (set! rsi len.16)
            (set! rdi vector-init-loop.15)
            (set! r15 tmp-ra.126)
            (jump L.vector-init-loop.15.9 rbp r15 rdi rsi rdx rcx)))))
    (define L.error?.66.8
      ((new-frames ()) (locals (c.70 tmp-ra.127 tmp.139 tmp.55 tmp.104)))
      (begin
        (set! tmp-ra.127 r15)
        (set! c.70 rdi)
        (set! tmp.55 rsi)
        (if (begin
              (begin
                (set! tmp.139 tmp.55)
                (set! tmp.139 (bitwise-and tmp.139 255))
                (set! tmp.104 tmp.139))
              (= tmp.104 62))
          (begin (set! rax 14) (jump tmp-ra.127 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.127 rbp rax)))))
    (define L.vector?.67.7
      ((new-frames ()) (locals (c.69 tmp-ra.128 tmp.140 tmp.57 tmp.105)))
      (begin
        (set! tmp-ra.128 r15)
        (set! c.69 rdi)
        (set! tmp.57 rsi)
        (if (begin
              (begin
                (set! tmp.140 tmp.57)
                (set! tmp.140 (bitwise-and tmp.140 7))
                (set! tmp.105 tmp.140))
              (= tmp.105 3))
          (begin (set! rax 14) (jump tmp-ra.128 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.128 rbp rax)))))
    (begin
      (set! tmp-ra.129 r15)
      (begin (set! tmp.106 r12) (set! r12 (+ r12 16)))
      (set! tmp.141 tmp.106)
      (set! tmp.141 (+ tmp.141 2))
      (set! tmp.81 tmp.141)
      (mset! tmp.81 -2 L.vector?.67.7)
      (mset! tmp.81 6 8)
      (set! vector?.67 tmp.81)
      (begin (set! tmp.107 r12) (set! r12 (+ r12 16)))
      (set! tmp.142 tmp.107)
      (set! tmp.142 (+ tmp.142 2))
      (set! tmp.82 tmp.142)
      (mset! tmp.82 -2 L.error?.66.8)
      (mset! tmp.82 6 8)
      (set! error?.66 tmp.82)
      (begin (set! tmp.108 r12) (set! r12 (+ r12 24)))
      (set! tmp.143 tmp.108)
      (set! tmp.143 (+ tmp.143 2))
      (set! tmp.83 tmp.143)
      (mset! tmp.83 -2 L.vector-init-loop.15.9)
      (mset! tmp.83 6 24)
      (set! vector-init-loop.15 tmp.83)
      (begin (set! tmp.109 r12) (set! r12 (+ r12 24)))
      (set! tmp.144 tmp.109)
      (set! tmp.144 (+ tmp.144 2))
      (set! tmp.84 tmp.144)
      (mset! tmp.84 -2 L.make-init-vector.1.10)
      (mset! tmp.84 6 8)
      (set! make-init-vector.1 tmp.84)
      (begin (set! tmp.110 r12) (set! r12 (+ r12 24)))
      (set! tmp.145 tmp.110)
      (set! tmp.145 (+ tmp.145 2))
      (set! tmp.85 tmp.145)
      (mset! tmp.85 -2 L.make-vector.65.11)
      (mset! tmp.85 6 8)
      (set! make-vector.65 tmp.85)
      (begin (set! tmp.111 r12) (set! r12 (+ r12 24)))
      (set! tmp.146 tmp.111)
      (set! tmp.146 (+ tmp.146 2))
      (set! tmp.86 tmp.146)
      (mset! tmp.86 -2 L.fun/any8771.4.12)
      (mset! tmp.86 6 0)
      (set! fun/any8771.4 tmp.86)
      (begin (set! tmp.112 r12) (set! r12 (+ r12 16)))
      (set! tmp.147 tmp.112)
      (set! tmp.147 (+ tmp.147 2))
      (set! tmp.87 tmp.147)
      (mset! tmp.87 -2 L.fun/empty8774.5.13)
      (mset! tmp.87 6 0)
      (set! fun/empty8774.5 tmp.87)
      (begin (set! tmp.113 r12) (set! r12 (+ r12 16)))
      (set! tmp.148 tmp.113)
      (set! tmp.148 (+ tmp.148 2))
      (set! tmp.88 tmp.148)
      (mset! tmp.88 -2 L.fun/void8770.6.14)
      (mset! tmp.88 6 0)
      (set! fun/void8770.6 tmp.88)
      (begin (set! tmp.114 r12) (set! r12 (+ r12 16)))
      (set! tmp.149 tmp.114)
      (set! tmp.149 (+ tmp.149 2))
      (set! tmp.89 tmp.149)
      (mset! tmp.89 -2 L.fun/any8773.7.15)
      (mset! tmp.89 6 0)
      (set! fun/any8773.7 tmp.89)
      (begin (set! tmp.115 r12) (set! r12 (+ r12 24)))
      (set! tmp.150 tmp.115)
      (set! tmp.150 (+ tmp.150 2))
      (set! tmp.90 tmp.150)
      (mset! tmp.90 -2 L.fun/vector8772.8.16)
      (mset! tmp.90 6 0)
      (set! fun/vector8772.8 tmp.90)
      (mset! vector-init-loop.15 14 vector-init-loop.15)
      (mset! make-init-vector.1 14 vector-init-loop.15)
      (mset! make-vector.65 14 make-init-vector.1)
      (mset! fun/any8771.4 14 make-vector.65)
      (mset! fun/vector8772.8 14 make-vector.65)
      (return-point L.rp.19
        (begin
          (set! rdi fun/void8770.6)
          (set! r15 L.rp.19)
          (jump L.fun/void8770.6.14 rbp r15 rdi)))
      (set! void0.12 rax)
      (return-point L.rp.20
        (begin
          (set! rdi fun/any8771.4)
          (set! r15 L.rp.20)
          (jump L.fun/any8771.4.12 rbp r15 rdi)))
      (set! tmp.116 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.116)
          (set! rdi error?.66)
          (set! r15 L.rp.21)
          (jump L.error?.66.8 rbp r15 rdi rsi)))
      (set! boolean1.11 rax)
      (return-point L.rp.22
        (begin
          (set! rdi fun/vector8772.8)
          (set! r15 L.rp.22)
          (jump L.fun/vector8772.8.16 rbp r15 rdi)))
      (set! vector2.10 rax)
      (begin (set! tmp.117 r12) (set! r12 (+ r12 32)))
      (set! tmp.151 tmp.117)
      (set! tmp.151 (+ tmp.151 2))
      (set! tmp.91 tmp.151)
      (mset! tmp.91 -2 L.lam.68.17)
      (mset! tmp.91 6 0)
      (set! lam.68 tmp.91)
      (mset! lam.68 14 fun/any8773.7)
      (mset! lam.68 22 vector?.67)
      (set! procedure3.9 lam.68)
      (set! rdi fun/empty8774.5)
      (set! r15 tmp-ra.129)
      (jump L.fun/empty8774.5.13 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () ()))
     (locals
      (procedure4.14
       lam.77
       tmp.117
       tmp.226
       tmp.167
       ascii-char3.15
       procedure2.16
       lam.76
       tmp.116
       tmp.225
       tmp.166
       fixnum1.17
       tmp.163
       tmp.165
       tmp.164
       tmp.160
       tmp.162
       tmp.161
       void0.18
       fun/ascii-char9402.13
       tmp.115
       tmp.224
       tmp.159
       fun/pair9401.12
       tmp.114
       tmp.223
       tmp.158
       fun/vector9405.11
       tmp.113
       tmp.222
       tmp.157
       fun/empty9406.10
       tmp.112
       tmp.221
       tmp.156
       fun/void9399.9
       tmp.111
       tmp.220
       tmp.155
       fun/vector9404.8
       tmp.110
       tmp.219
       tmp.154
       fun/pair9400.7
       tmp.109
       tmp.218
       tmp.153
       fun/ascii-char9403.6
       tmp.108
       tmp.217
       tmp.152
       fun/empty9407.5
       tmp.107
       tmp.216
       tmp.151
       fun/void9398.4
       tmp.106
       tmp.215
       tmp.150
       make-vector.71
       tmp.105
       tmp.214
       tmp.149
       make-init-vector.1
       tmp.104
       tmp.213
       tmp.148
       vector-init-loop.21
       tmp.103
       tmp.212
       tmp.147
       cons.72
       tmp.102
       tmp.211
       tmp.146
       *.73
       tmp.101
       tmp.210
       tmp.145
       |-.74|
       tmp.100
       tmp.209
       tmp.144
       |+.75|
       tmp.99
       tmp.208
       tmp.143
       tmp-ra.187)))
    (define L.lam.77.25
      ((new-frames ()) (locals (fun/vector9404.8 c.96 tmp-ra.168)))
      (begin
        (set! tmp-ra.168 r15)
        (set! c.96 rdi)
        (set! fun/vector9404.8 (mref c.96 14))
        (set! rdi fun/vector9404.8)
        (set! r15 tmp-ra.168)
        (jump L.fun/vector9404.8.18 rbp r15 rdi)))
    (define L.lam.76.24
      ((new-frames ()) (locals (fun/pair9400.7 c.95 tmp-ra.169)))
      (begin
        (set! tmp-ra.169 r15)
        (set! c.95 rdi)
        (set! fun/pair9400.7 (mref c.95 14))
        (set! rdi fun/pair9400.7)
        (set! r15 tmp-ra.169)
        (jump L.fun/pair9400.7.17 rbp r15 rdi)))
    (define L.fun/ascii-char9402.13.23
      ((new-frames ()) (locals (fun/ascii-char9403.6 c.94 tmp-ra.170)))
      (begin
        (set! tmp-ra.170 r15)
        (set! c.94 rdi)
        (set! fun/ascii-char9403.6 (mref c.94 14))
        (set! rdi fun/ascii-char9403.6)
        (set! r15 tmp-ra.170)
        (jump L.fun/ascii-char9403.6.16 rbp r15 rdi)))
    (define L.fun/pair9401.12.22
      ((new-frames ()) (locals (cons.72 c.93 tmp-ra.171)))
      (begin
        (set! tmp-ra.171 r15)
        (set! c.93 rdi)
        (set! cons.72 (mref c.93 14))
        (set! rdx 3016)
        (set! rsi 1936)
        (set! rdi cons.72)
        (set! r15 tmp-ra.171)
        (jump L.cons.72.10 rbp r15 rdi rsi rdx)))
    (define L.fun/vector9405.11.21
      ((new-frames ()) (locals (make-vector.71 c.92 tmp-ra.172)))
      (begin
        (set! tmp-ra.172 r15)
        (set! c.92 rdi)
        (set! make-vector.71 (mref c.92 14))
        (set! rsi 64)
        (set! rdi make-vector.71)
        (set! r15 tmp-ra.172)
        (jump L.make-vector.71.13 rbp r15 rdi rsi)))
    (define L.fun/empty9406.10.20
      ((new-frames ()) (locals (fun/empty9407.5 c.91 tmp-ra.173)))
      (begin
        (set! tmp-ra.173 r15)
        (set! c.91 rdi)
        (set! fun/empty9407.5 (mref c.91 14))
        (set! rdi fun/empty9407.5)
        (set! r15 tmp-ra.173)
        (jump L.fun/empty9407.5.15 rbp r15 rdi)))
    (define L.fun/void9399.9.19
      ((new-frames ()) (locals (c.90 tmp-ra.174)))
      (begin
        (set! tmp-ra.174 r15)
        (set! c.90 rdi)
        (set! rax 30)
        (jump tmp-ra.174 rbp rax)))
    (define L.fun/vector9404.8.18
      ((new-frames ()) (locals (fun/vector9405.11 c.89 tmp-ra.175)))
      (begin
        (set! tmp-ra.175 r15)
        (set! c.89 rdi)
        (set! fun/vector9405.11 (mref c.89 14))
        (set! rdi fun/vector9405.11)
        (set! r15 tmp-ra.175)
        (jump L.fun/vector9405.11.21 rbp r15 rdi)))
    (define L.fun/pair9400.7.17
      ((new-frames ()) (locals (fun/pair9401.12 c.88 tmp-ra.176)))
      (begin
        (set! tmp-ra.176 r15)
        (set! c.88 rdi)
        (set! fun/pair9401.12 (mref c.88 14))
        (set! rdi fun/pair9401.12)
        (set! r15 tmp-ra.176)
        (jump L.fun/pair9401.12.22 rbp r15 rdi)))
    (define L.fun/ascii-char9403.6.16
      ((new-frames ()) (locals (c.87 tmp-ra.177)))
      (begin
        (set! tmp-ra.177 r15)
        (set! c.87 rdi)
        (set! rax 25646)
        (jump tmp-ra.177 rbp rax)))
    (define L.fun/empty9407.5.15
      ((new-frames ()) (locals (c.86 tmp-ra.178)))
      (begin
        (set! tmp-ra.178 r15)
        (set! c.86 rdi)
        (set! rax 22)
        (jump tmp-ra.178 rbp rax)))
    (define L.fun/void9398.4.14
      ((new-frames ()) (locals (fun/void9399.9 c.85 tmp-ra.179)))
      (begin
        (set! tmp-ra.179 r15)
        (set! c.85 rdi)
        (set! fun/void9399.9 (mref c.85 14))
        (set! rdi fun/void9399.9)
        (set! r15 tmp-ra.179)
        (jump L.fun/void9399.9.19 rbp r15 rdi)))
    (define L.make-vector.71.13
      ((new-frames ())
       (locals
        (c.84 make-init-vector.1 tmp-ra.180 tmp.119 tmp.47 tmp.188 tmp.118)))
      (begin
        (set! tmp-ra.180 r15)
        (set! c.84 rdi)
        (set! tmp.47 rsi)
        (set! make-init-vector.1 (mref c.84 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.188 tmp.47)
                      (set! tmp.188 (bitwise-and tmp.188 7))
                      (set! tmp.119 tmp.188))
                    (= tmp.119 0))
                (set! tmp.118 14)
                (set! tmp.118 6))
              (!= tmp.118 6))
          (begin
            (set! rsi tmp.47)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.180)
            (jump L.make-init-vector.1.12 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.180 rbp rax)))))
    (define L.make-init-vector.1.12
      ((new-frames ())
       (locals
        (tmp.20
         tmp.97
         tmp.192
         tmp.120
         tmp.121
         tmp.191
         tmp.122
         tmp.190
         tmp.123
         tmp.189
         vector-init-loop.21
         tmp.19
         c.83
         tmp-ra.181)))
      (begin
        (set! tmp-ra.181 r15)
        (set! c.83 rdi)
        (set! tmp.19 rsi)
        (set! vector-init-loop.21 (mref c.83 14))
        (set! tmp.189 tmp.19)
        (set! tmp.189 (arithmetic-shift-right tmp.189 3))
        (set! tmp.123 tmp.189)
        (set! tmp.190 1)
        (set! tmp.190 (+ tmp.190 tmp.123))
        (set! tmp.122 tmp.190)
        (set! tmp.191 tmp.122)
        (set! tmp.191 (* tmp.191 8))
        (set! tmp.121 tmp.191)
        (begin (set! tmp.120 r12) (set! r12 (+ r12 tmp.121)))
        (set! tmp.192 tmp.120)
        (set! tmp.192 (+ tmp.192 3))
        (set! tmp.97 tmp.192)
        (mset! tmp.97 -3 tmp.19)
        (set! tmp.20 tmp.97)
        (set! rcx tmp.20)
        (set! rdx 0)
        (set! rsi tmp.19)
        (set! rdi vector-init-loop.21)
        (set! r15 tmp-ra.181)
        (jump L.vector-init-loop.21.11 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.21.11
      ((new-frames ())
       (locals
        (c.82
         tmp.193
         tmp.127
         tmp.194
         tmp.126
         tmp.195
         tmp.125
         tmp.196
         tmp.128
         vector-init-loop.21
         tmp-ra.182
         vec.23
         len.22
         i.24
         tmp.124)))
      (begin
        (set! tmp-ra.182 r15)
        (set! c.82 rdi)
        (set! len.22 rsi)
        (set! i.24 rdx)
        (set! vec.23 rcx)
        (set! vector-init-loop.21 (mref c.82 14))
        (if (begin
              (if (= len.22 i.24) (set! tmp.124 14) (set! tmp.124 6))
              (!= tmp.124 6))
          (begin (set! rax vec.23) (jump tmp-ra.182 rbp rax))
          (begin
            (set! tmp.193 i.24)
            (set! tmp.193 (arithmetic-shift-right tmp.193 3))
            (set! tmp.127 tmp.193)
            (set! tmp.194 tmp.127)
            (set! tmp.194 (* tmp.194 8))
            (set! tmp.126 tmp.194)
            (set! tmp.195 tmp.126)
            (set! tmp.195 (+ tmp.195 5))
            (set! tmp.125 tmp.195)
            (mset! vec.23 tmp.125 0)
            (set! tmp.196 i.24)
            (set! tmp.196 (+ tmp.196 8))
            (set! tmp.128 tmp.196)
            (set! rcx vec.23)
            (set! rdx tmp.128)
            (set! rsi len.22)
            (set! rdi vector-init-loop.21)
            (set! r15 tmp-ra.182)
            (jump L.vector-init-loop.21.11 rbp r15 rdi rsi rdx rcx)))))
    (define L.cons.72.10
      ((new-frames ())
       (locals (tmp.98 tmp.197 tmp.129 tmp.67 tmp.66 c.81 tmp-ra.183)))
      (begin
        (set! tmp-ra.183 r15)
        (set! c.81 rdi)
        (set! tmp.66 rsi)
        (set! tmp.67 rdx)
        (begin (set! tmp.129 r12) (set! r12 (+ r12 16)))
        (set! tmp.197 tmp.129)
        (set! tmp.197 (+ tmp.197 1))
        (set! tmp.98 tmp.197)
        (mset! tmp.98 -1 tmp.66)
        (mset! tmp.98 7 tmp.67)
        (set! rax tmp.98)
        (jump tmp-ra.183 rbp rax)))
    (define L.*.73.9
      ((new-frames ())
       (locals
        (c.80
         tmp.132
         tmp.199
         tmp.33
         tmp.133
         tmp.201
         tmp.134
         tmp.200
         tmp-ra.184
         tmp.131
         tmp.34
         tmp.198
         tmp.130)))
      (begin
        (set! tmp-ra.184 r15)
        (set! c.80 rdi)
        (set! tmp.33 rsi)
        (set! tmp.34 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.198 tmp.34)
                      (set! tmp.198 (bitwise-and tmp.198 7))
                      (set! tmp.131 tmp.198))
                    (= tmp.131 0))
                (set! tmp.130 14)
                (set! tmp.130 6))
              (!= tmp.130 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.199 tmp.33)
                        (set! tmp.199 (bitwise-and tmp.199 7))
                        (set! tmp.133 tmp.199))
                      (= tmp.133 0))
                  (set! tmp.132 14)
                  (set! tmp.132 6))
                (!= tmp.132 6))
            (begin
              (set! tmp.200 tmp.34)
              (set! tmp.200 (arithmetic-shift-right tmp.200 3))
              (set! tmp.134 tmp.200)
              (set! tmp.201 tmp.33)
              (set! tmp.201 (* tmp.201 tmp.134))
              (set! rax tmp.201)
              (jump tmp-ra.184 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.184 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.184 rbp rax)))))
    (define L.-.74.8
      ((new-frames ())
       (locals
        (c.79
         tmp.137
         tmp.203
         tmp.37
         tmp.138
         tmp.204
         tmp-ra.185
         tmp.136
         tmp.38
         tmp.202
         tmp.135)))
      (begin
        (set! tmp-ra.185 r15)
        (set! c.79 rdi)
        (set! tmp.37 rsi)
        (set! tmp.38 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.202 tmp.38)
                      (set! tmp.202 (bitwise-and tmp.202 7))
                      (set! tmp.136 tmp.202))
                    (= tmp.136 0))
                (set! tmp.135 14)
                (set! tmp.135 6))
              (!= tmp.135 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.203 tmp.37)
                        (set! tmp.203 (bitwise-and tmp.203 7))
                        (set! tmp.138 tmp.203))
                      (= tmp.138 0))
                  (set! tmp.137 14)
                  (set! tmp.137 6))
                (!= tmp.137 6))
            (begin
              (set! tmp.204 tmp.37)
              (set! tmp.204 (- tmp.204 tmp.38))
              (set! rax tmp.204)
              (jump tmp-ra.185 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.185 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.185 rbp rax)))))
    (define L.+.75.7
      ((new-frames ())
       (locals
        (c.78
         tmp.141
         tmp.206
         tmp.35
         tmp.142
         tmp.207
         tmp-ra.186
         tmp.140
         tmp.36
         tmp.205
         tmp.139)))
      (begin
        (set! tmp-ra.186 r15)
        (set! c.78 rdi)
        (set! tmp.35 rsi)
        (set! tmp.36 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.205 tmp.36)
                      (set! tmp.205 (bitwise-and tmp.205 7))
                      (set! tmp.140 tmp.205))
                    (= tmp.140 0))
                (set! tmp.139 14)
                (set! tmp.139 6))
              (!= tmp.139 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.206 tmp.35)
                        (set! tmp.206 (bitwise-and tmp.206 7))
                        (set! tmp.142 tmp.206))
                      (= tmp.142 0))
                  (set! tmp.141 14)
                  (set! tmp.141 6))
                (!= tmp.141 6))
            (begin
              (set! tmp.207 tmp.35)
              (set! tmp.207 (+ tmp.207 tmp.36))
              (set! rax tmp.207)
              (jump tmp-ra.186 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.186 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.186 rbp rax)))))
    (begin
      (set! tmp-ra.187 r15)
      (begin (set! tmp.143 r12) (set! r12 (+ r12 16)))
      (set! tmp.208 tmp.143)
      (set! tmp.208 (+ tmp.208 2))
      (set! tmp.99 tmp.208)
      (mset! tmp.99 -2 L.+.75.7)
      (mset! tmp.99 6 16)
      (set! |+.75| tmp.99)
      (begin (set! tmp.144 r12) (set! r12 (+ r12 16)))
      (set! tmp.209 tmp.144)
      (set! tmp.209 (+ tmp.209 2))
      (set! tmp.100 tmp.209)
      (mset! tmp.100 -2 L.-.74.8)
      (mset! tmp.100 6 16)
      (set! |-.74| tmp.100)
      (begin (set! tmp.145 r12) (set! r12 (+ r12 16)))
      (set! tmp.210 tmp.145)
      (set! tmp.210 (+ tmp.210 2))
      (set! tmp.101 tmp.210)
      (mset! tmp.101 -2 L.*.73.9)
      (mset! tmp.101 6 16)
      (set! *.73 tmp.101)
      (begin (set! tmp.146 r12) (set! r12 (+ r12 16)))
      (set! tmp.211 tmp.146)
      (set! tmp.211 (+ tmp.211 2))
      (set! tmp.102 tmp.211)
      (mset! tmp.102 -2 L.cons.72.10)
      (mset! tmp.102 6 16)
      (set! cons.72 tmp.102)
      (begin (set! tmp.147 r12) (set! r12 (+ r12 24)))
      (set! tmp.212 tmp.147)
      (set! tmp.212 (+ tmp.212 2))
      (set! tmp.103 tmp.212)
      (mset! tmp.103 -2 L.vector-init-loop.21.11)
      (mset! tmp.103 6 24)
      (set! vector-init-loop.21 tmp.103)
      (begin (set! tmp.148 r12) (set! r12 (+ r12 24)))
      (set! tmp.213 tmp.148)
      (set! tmp.213 (+ tmp.213 2))
      (set! tmp.104 tmp.213)
      (mset! tmp.104 -2 L.make-init-vector.1.12)
      (mset! tmp.104 6 8)
      (set! make-init-vector.1 tmp.104)
      (begin (set! tmp.149 r12) (set! r12 (+ r12 24)))
      (set! tmp.214 tmp.149)
      (set! tmp.214 (+ tmp.214 2))
      (set! tmp.105 tmp.214)
      (mset! tmp.105 -2 L.make-vector.71.13)
      (mset! tmp.105 6 8)
      (set! make-vector.71 tmp.105)
      (begin (set! tmp.150 r12) (set! r12 (+ r12 24)))
      (set! tmp.215 tmp.150)
      (set! tmp.215 (+ tmp.215 2))
      (set! tmp.106 tmp.215)
      (mset! tmp.106 -2 L.fun/void9398.4.14)
      (mset! tmp.106 6 0)
      (set! fun/void9398.4 tmp.106)
      (begin (set! tmp.151 r12) (set! r12 (+ r12 16)))
      (set! tmp.216 tmp.151)
      (set! tmp.216 (+ tmp.216 2))
      (set! tmp.107 tmp.216)
      (mset! tmp.107 -2 L.fun/empty9407.5.15)
      (mset! tmp.107 6 0)
      (set! fun/empty9407.5 tmp.107)
      (begin (set! tmp.152 r12) (set! r12 (+ r12 16)))
      (set! tmp.217 tmp.152)
      (set! tmp.217 (+ tmp.217 2))
      (set! tmp.108 tmp.217)
      (mset! tmp.108 -2 L.fun/ascii-char9403.6.16)
      (mset! tmp.108 6 0)
      (set! fun/ascii-char9403.6 tmp.108)
      (begin (set! tmp.153 r12) (set! r12 (+ r12 24)))
      (set! tmp.218 tmp.153)
      (set! tmp.218 (+ tmp.218 2))
      (set! tmp.109 tmp.218)
      (mset! tmp.109 -2 L.fun/pair9400.7.17)
      (mset! tmp.109 6 0)
      (set! fun/pair9400.7 tmp.109)
      (begin (set! tmp.154 r12) (set! r12 (+ r12 24)))
      (set! tmp.219 tmp.154)
      (set! tmp.219 (+ tmp.219 2))
      (set! tmp.110 tmp.219)
      (mset! tmp.110 -2 L.fun/vector9404.8.18)
      (mset! tmp.110 6 0)
      (set! fun/vector9404.8 tmp.110)
      (begin (set! tmp.155 r12) (set! r12 (+ r12 16)))
      (set! tmp.220 tmp.155)
      (set! tmp.220 (+ tmp.220 2))
      (set! tmp.111 tmp.220)
      (mset! tmp.111 -2 L.fun/void9399.9.19)
      (mset! tmp.111 6 0)
      (set! fun/void9399.9 tmp.111)
      (begin (set! tmp.156 r12) (set! r12 (+ r12 24)))
      (set! tmp.221 tmp.156)
      (set! tmp.221 (+ tmp.221 2))
      (set! tmp.112 tmp.221)
      (mset! tmp.112 -2 L.fun/empty9406.10.20)
      (mset! tmp.112 6 0)
      (set! fun/empty9406.10 tmp.112)
      (begin (set! tmp.157 r12) (set! r12 (+ r12 24)))
      (set! tmp.222 tmp.157)
      (set! tmp.222 (+ tmp.222 2))
      (set! tmp.113 tmp.222)
      (mset! tmp.113 -2 L.fun/vector9405.11.21)
      (mset! tmp.113 6 0)
      (set! fun/vector9405.11 tmp.113)
      (begin (set! tmp.158 r12) (set! r12 (+ r12 24)))
      (set! tmp.223 tmp.158)
      (set! tmp.223 (+ tmp.223 2))
      (set! tmp.114 tmp.223)
      (mset! tmp.114 -2 L.fun/pair9401.12.22)
      (mset! tmp.114 6 0)
      (set! fun/pair9401.12 tmp.114)
      (begin (set! tmp.159 r12) (set! r12 (+ r12 24)))
      (set! tmp.224 tmp.159)
      (set! tmp.224 (+ tmp.224 2))
      (set! tmp.115 tmp.224)
      (mset! tmp.115 -2 L.fun/ascii-char9402.13.23)
      (mset! tmp.115 6 0)
      (set! fun/ascii-char9402.13 tmp.115)
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
      (return-point L.rp.26
        (begin
          (set! rdi fun/void9398.4)
          (set! r15 L.rp.26)
          (jump L.fun/void9398.4.14 rbp r15 rdi)))
      (set! void0.18 rax)
      (return-point L.rp.27
        (begin
          (set! rdx 752)
          (set! rsi 1960)
          (set! rdi *.73)
          (set! r15 L.rp.27)
          (jump L.*.73.9 rbp r15 rdi rsi rdx)))
      (set! tmp.161 rax)
      (return-point L.rp.28
        (begin
          (set! rdx 1608)
          (set! rsi 752)
          (set! rdi |-.74|)
          (set! r15 L.rp.28)
          (jump L.-.74.8 rbp r15 rdi rsi rdx)))
      (set! tmp.162 rax)
      (return-point L.rp.29
        (begin
          (set! rdx tmp.162)
          (set! rsi tmp.161)
          (set! rdi *.73)
          (set! r15 L.rp.29)
          (jump L.*.73.9 rbp r15 rdi rsi rdx)))
      (set! tmp.160 rax)
      (return-point L.rp.30
        (begin
          (set! rdx 128)
          (set! rsi 1800)
          (set! rdi |-.74|)
          (set! r15 L.rp.30)
          (jump L.-.74.8 rbp r15 rdi rsi rdx)))
      (set! tmp.164 rax)
      (return-point L.rp.31
        (begin
          (set! rdx 1392)
          (set! rsi 368)
          (set! rdi |+.75|)
          (set! r15 L.rp.31)
          (jump L.+.75.7 rbp r15 rdi rsi rdx)))
      (set! tmp.165 rax)
      (return-point L.rp.32
        (begin
          (set! rdx tmp.165)
          (set! rsi tmp.164)
          (set! rdi |+.75|)
          (set! r15 L.rp.32)
          (jump L.+.75.7 rbp r15 rdi rsi rdx)))
      (set! tmp.163 rax)
      (return-point L.rp.33
        (begin
          (set! rdx tmp.163)
          (set! rsi tmp.160)
          (set! rdi |-.74|)
          (set! r15 L.rp.33)
          (jump L.-.74.8 rbp r15 rdi rsi rdx)))
      (set! fixnum1.17 rax)
      (begin (set! tmp.166 r12) (set! r12 (+ r12 24)))
      (set! tmp.225 tmp.166)
      (set! tmp.225 (+ tmp.225 2))
      (set! tmp.116 tmp.225)
      (mset! tmp.116 -2 L.lam.76.24)
      (mset! tmp.116 6 0)
      (set! lam.76 tmp.116)
      (mset! lam.76 14 fun/pair9400.7)
      (set! procedure2.16 lam.76)
      (return-point L.rp.34
        (begin
          (set! rdi fun/ascii-char9402.13)
          (set! r15 L.rp.34)
          (jump L.fun/ascii-char9402.13.23 rbp r15 rdi)))
      (set! ascii-char3.15 rax)
      (begin (set! tmp.167 r12) (set! r12 (+ r12 24)))
      (set! tmp.226 tmp.167)
      (set! tmp.226 (+ tmp.226 2))
      (set! tmp.117 tmp.226)
      (mset! tmp.117 -2 L.lam.77.25)
      (mset! tmp.117 6 0)
      (set! lam.77 tmp.117)
      (mset! lam.77 14 fun/vector9404.8)
      (set! procedure4.14 lam.77)
      (set! rdi fun/empty9406.10)
      (set! r15 tmp-ra.187)
      (jump L.fun/empty9406.10.20 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () () () () ()))
     (locals
      (empty5.16
       ascii-char4.17
       fixnum3.18
       tmp.148
       tmp.152
       tmp.154
       tmp.153
       tmp.149
       tmp.151
       tmp.150
       tmp.141
       tmp.145
       tmp.147
       tmp.146
       tmp.142
       tmp.144
       tmp.143
       error2.19
       void1.20
       error0.21
       fun/pair13318.15
       tmp.110
       tmp.198
       tmp.140
       fun/void13311.14
       tmp.109
       tmp.197
       tmp.139
       fun/ascii-char13314.13
       tmp.108
       tmp.196
       tmp.138
       fun/error13309.12
       tmp.107
       tmp.195
       tmp.137
       fun/empty13317.11
       tmp.106
       tmp.194
       tmp.136
       fun/void13310.10
       tmp.105
       tmp.193
       tmp.135
       fun/pair13319.9
       tmp.104
       tmp.192
       tmp.134
       fun/error13312.8
       tmp.103
       tmp.191
       tmp.133
       fun/error13308.7
       tmp.102
       tmp.190
       tmp.132
       fun/error13313.6
       tmp.101
       tmp.189
       tmp.131
       fun/ascii-char13315.5
       tmp.100
       tmp.188
       tmp.130
       fun/empty13316.4
       tmp.99
       tmp.187
       tmp.129
       cons.74
       tmp.98
       tmp.186
       tmp.128
       |+.75|
       tmp.97
       tmp.185
       tmp.127
       *.76
       tmp.96
       tmp.184
       tmp.126
       |-.77|
       tmp.95
       tmp.183
       tmp.125
       tmp-ra.171)))
    (define L.fun/pair13318.15.22
      ((new-frames ()) (locals (fun/pair13319.9 c.93 tmp-ra.155)))
      (begin
        (set! tmp-ra.155 r15)
        (set! c.93 rdi)
        (set! fun/pair13319.9 (mref c.93 14))
        (set! rdi fun/pair13319.9)
        (set! r15 tmp-ra.155)
        (jump L.fun/pair13319.9.16 rbp r15 rdi)))
    (define L.fun/void13311.14.21
      ((new-frames ()) (locals (c.92 tmp-ra.156)))
      (begin
        (set! tmp-ra.156 r15)
        (set! c.92 rdi)
        (set! rax 30)
        (jump tmp-ra.156 rbp rax)))
    (define L.fun/ascii-char13314.13.20
      ((new-frames ()) (locals (fun/ascii-char13315.5 c.91 tmp-ra.157)))
      (begin
        (set! tmp-ra.157 r15)
        (set! c.91 rdi)
        (set! fun/ascii-char13315.5 (mref c.91 14))
        (set! rdi fun/ascii-char13315.5)
        (set! r15 tmp-ra.157)
        (jump L.fun/ascii-char13315.5.12 rbp r15 rdi)))
    (define L.fun/error13309.12.19
      ((new-frames ()) (locals (c.90 tmp-ra.158)))
      (begin
        (set! tmp-ra.158 r15)
        (set! c.90 rdi)
        (set! rax 63550)
        (jump tmp-ra.158 rbp rax)))
    (define L.fun/empty13317.11.18
      ((new-frames ()) (locals (c.89 tmp-ra.159)))
      (begin
        (set! tmp-ra.159 r15)
        (set! c.89 rdi)
        (set! rax 22)
        (jump tmp-ra.159 rbp rax)))
    (define L.fun/void13310.10.17
      ((new-frames ()) (locals (fun/void13311.14 c.88 tmp-ra.160)))
      (begin
        (set! tmp-ra.160 r15)
        (set! c.88 rdi)
        (set! fun/void13311.14 (mref c.88 14))
        (set! rdi fun/void13311.14)
        (set! r15 tmp-ra.160)
        (jump L.fun/void13311.14.21 rbp r15 rdi)))
    (define L.fun/pair13319.9.16
      ((new-frames ()) (locals (cons.74 c.87 tmp-ra.161)))
      (begin
        (set! tmp-ra.161 r15)
        (set! c.87 rdi)
        (set! cons.74 (mref c.87 14))
        (set! rdx 3512)
        (set! rsi 1944)
        (set! rdi cons.74)
        (set! r15 tmp-ra.161)
        (jump L.cons.74.10 rbp r15 rdi rsi rdx)))
    (define L.fun/error13312.8.15
      ((new-frames ()) (locals (fun/error13313.6 c.86 tmp-ra.162)))
      (begin
        (set! tmp-ra.162 r15)
        (set! c.86 rdi)
        (set! fun/error13313.6 (mref c.86 14))
        (set! rdi fun/error13313.6)
        (set! r15 tmp-ra.162)
        (jump L.fun/error13313.6.13 rbp r15 rdi)))
    (define L.fun/error13308.7.14
      ((new-frames ()) (locals (fun/error13309.12 c.85 tmp-ra.163)))
      (begin
        (set! tmp-ra.163 r15)
        (set! c.85 rdi)
        (set! fun/error13309.12 (mref c.85 14))
        (set! rdi fun/error13309.12)
        (set! r15 tmp-ra.163)
        (jump L.fun/error13309.12.19 rbp r15 rdi)))
    (define L.fun/error13313.6.13
      ((new-frames ()) (locals (c.84 tmp-ra.164)))
      (begin
        (set! tmp-ra.164 r15)
        (set! c.84 rdi)
        (set! rax 15678)
        (jump tmp-ra.164 rbp rax)))
    (define L.fun/ascii-char13315.5.12
      ((new-frames ()) (locals (c.83 tmp-ra.165)))
      (begin
        (set! tmp-ra.165 r15)
        (set! c.83 rdi)
        (set! rax 25646)
        (jump tmp-ra.165 rbp rax)))
    (define L.fun/empty13316.4.11
      ((new-frames ()) (locals (fun/empty13317.11 c.82 tmp-ra.166)))
      (begin
        (set! tmp-ra.166 r15)
        (set! c.82 rdi)
        (set! fun/empty13317.11 (mref c.82 14))
        (set! rdi fun/empty13317.11)
        (set! r15 tmp-ra.166)
        (jump L.fun/empty13317.11.18 rbp r15 rdi)))
    (define L.cons.74.10
      ((new-frames ())
       (locals (tmp.94 tmp.172 tmp.111 tmp.70 tmp.69 c.81 tmp-ra.167)))
      (begin
        (set! tmp-ra.167 r15)
        (set! c.81 rdi)
        (set! tmp.69 rsi)
        (set! tmp.70 rdx)
        (begin (set! tmp.111 r12) (set! r12 (+ r12 16)))
        (set! tmp.172 tmp.111)
        (set! tmp.172 (+ tmp.172 1))
        (set! tmp.94 tmp.172)
        (mset! tmp.94 -1 tmp.69)
        (mset! tmp.94 7 tmp.70)
        (set! rax tmp.94)
        (jump tmp-ra.167 rbp rax)))
    (define L.+.75.9
      ((new-frames ())
       (locals
        (c.80
         tmp.114
         tmp.174
         tmp.38
         tmp.115
         tmp.175
         tmp-ra.168
         tmp.113
         tmp.39
         tmp.173
         tmp.112)))
      (begin
        (set! tmp-ra.168 r15)
        (set! c.80 rdi)
        (set! tmp.38 rsi)
        (set! tmp.39 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.173 tmp.39)
                      (set! tmp.173 (bitwise-and tmp.173 7))
                      (set! tmp.113 tmp.173))
                    (= tmp.113 0))
                (set! tmp.112 14)
                (set! tmp.112 6))
              (!= tmp.112 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.174 tmp.38)
                        (set! tmp.174 (bitwise-and tmp.174 7))
                        (set! tmp.115 tmp.174))
                      (= tmp.115 0))
                  (set! tmp.114 14)
                  (set! tmp.114 6))
                (!= tmp.114 6))
            (begin
              (set! tmp.175 tmp.38)
              (set! tmp.175 (+ tmp.175 tmp.39))
              (set! rax tmp.175)
              (jump tmp-ra.168 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.168 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.168 rbp rax)))))
    (define L.*.76.8
      ((new-frames ())
       (locals
        (c.79
         tmp.118
         tmp.177
         tmp.36
         tmp.119
         tmp.179
         tmp.120
         tmp.178
         tmp-ra.169
         tmp.117
         tmp.37
         tmp.176
         tmp.116)))
      (begin
        (set! tmp-ra.169 r15)
        (set! c.79 rdi)
        (set! tmp.36 rsi)
        (set! tmp.37 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.176 tmp.37)
                      (set! tmp.176 (bitwise-and tmp.176 7))
                      (set! tmp.117 tmp.176))
                    (= tmp.117 0))
                (set! tmp.116 14)
                (set! tmp.116 6))
              (!= tmp.116 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.177 tmp.36)
                        (set! tmp.177 (bitwise-and tmp.177 7))
                        (set! tmp.119 tmp.177))
                      (= tmp.119 0))
                  (set! tmp.118 14)
                  (set! tmp.118 6))
                (!= tmp.118 6))
            (begin
              (set! tmp.178 tmp.37)
              (set! tmp.178 (arithmetic-shift-right tmp.178 3))
              (set! tmp.120 tmp.178)
              (set! tmp.179 tmp.36)
              (set! tmp.179 (* tmp.179 tmp.120))
              (set! rax tmp.179)
              (jump tmp-ra.169 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.169 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.169 rbp rax)))))
    (define L.-.77.7
      ((new-frames ())
       (locals
        (c.78
         tmp.123
         tmp.181
         tmp.40
         tmp.124
         tmp.182
         tmp-ra.170
         tmp.122
         tmp.41
         tmp.180
         tmp.121)))
      (begin
        (set! tmp-ra.170 r15)
        (set! c.78 rdi)
        (set! tmp.40 rsi)
        (set! tmp.41 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.180 tmp.41)
                      (set! tmp.180 (bitwise-and tmp.180 7))
                      (set! tmp.122 tmp.180))
                    (= tmp.122 0))
                (set! tmp.121 14)
                (set! tmp.121 6))
              (!= tmp.121 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.181 tmp.40)
                        (set! tmp.181 (bitwise-and tmp.181 7))
                        (set! tmp.124 tmp.181))
                      (= tmp.124 0))
                  (set! tmp.123 14)
                  (set! tmp.123 6))
                (!= tmp.123 6))
            (begin
              (set! tmp.182 tmp.40)
              (set! tmp.182 (- tmp.182 tmp.41))
              (set! rax tmp.182)
              (jump tmp-ra.170 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.170 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.170 rbp rax)))))
    (begin
      (set! tmp-ra.171 r15)
      (begin (set! tmp.125 r12) (set! r12 (+ r12 16)))
      (set! tmp.183 tmp.125)
      (set! tmp.183 (+ tmp.183 2))
      (set! tmp.95 tmp.183)
      (mset! tmp.95 -2 L.-.77.7)
      (mset! tmp.95 6 16)
      (set! |-.77| tmp.95)
      (begin (set! tmp.126 r12) (set! r12 (+ r12 16)))
      (set! tmp.184 tmp.126)
      (set! tmp.184 (+ tmp.184 2))
      (set! tmp.96 tmp.184)
      (mset! tmp.96 -2 L.*.76.8)
      (mset! tmp.96 6 16)
      (set! *.76 tmp.96)
      (begin (set! tmp.127 r12) (set! r12 (+ r12 16)))
      (set! tmp.185 tmp.127)
      (set! tmp.185 (+ tmp.185 2))
      (set! tmp.97 tmp.185)
      (mset! tmp.97 -2 L.+.75.9)
      (mset! tmp.97 6 16)
      (set! |+.75| tmp.97)
      (begin (set! tmp.128 r12) (set! r12 (+ r12 16)))
      (set! tmp.186 tmp.128)
      (set! tmp.186 (+ tmp.186 2))
      (set! tmp.98 tmp.186)
      (mset! tmp.98 -2 L.cons.74.10)
      (mset! tmp.98 6 16)
      (set! cons.74 tmp.98)
      (begin (set! tmp.129 r12) (set! r12 (+ r12 24)))
      (set! tmp.187 tmp.129)
      (set! tmp.187 (+ tmp.187 2))
      (set! tmp.99 tmp.187)
      (mset! tmp.99 -2 L.fun/empty13316.4.11)
      (mset! tmp.99 6 0)
      (set! fun/empty13316.4 tmp.99)
      (begin (set! tmp.130 r12) (set! r12 (+ r12 16)))
      (set! tmp.188 tmp.130)
      (set! tmp.188 (+ tmp.188 2))
      (set! tmp.100 tmp.188)
      (mset! tmp.100 -2 L.fun/ascii-char13315.5.12)
      (mset! tmp.100 6 0)
      (set! fun/ascii-char13315.5 tmp.100)
      (begin (set! tmp.131 r12) (set! r12 (+ r12 16)))
      (set! tmp.189 tmp.131)
      (set! tmp.189 (+ tmp.189 2))
      (set! tmp.101 tmp.189)
      (mset! tmp.101 -2 L.fun/error13313.6.13)
      (mset! tmp.101 6 0)
      (set! fun/error13313.6 tmp.101)
      (begin (set! tmp.132 r12) (set! r12 (+ r12 24)))
      (set! tmp.190 tmp.132)
      (set! tmp.190 (+ tmp.190 2))
      (set! tmp.102 tmp.190)
      (mset! tmp.102 -2 L.fun/error13308.7.14)
      (mset! tmp.102 6 0)
      (set! fun/error13308.7 tmp.102)
      (begin (set! tmp.133 r12) (set! r12 (+ r12 24)))
      (set! tmp.191 tmp.133)
      (set! tmp.191 (+ tmp.191 2))
      (set! tmp.103 tmp.191)
      (mset! tmp.103 -2 L.fun/error13312.8.15)
      (mset! tmp.103 6 0)
      (set! fun/error13312.8 tmp.103)
      (begin (set! tmp.134 r12) (set! r12 (+ r12 24)))
      (set! tmp.192 tmp.134)
      (set! tmp.192 (+ tmp.192 2))
      (set! tmp.104 tmp.192)
      (mset! tmp.104 -2 L.fun/pair13319.9.16)
      (mset! tmp.104 6 0)
      (set! fun/pair13319.9 tmp.104)
      (begin (set! tmp.135 r12) (set! r12 (+ r12 24)))
      (set! tmp.193 tmp.135)
      (set! tmp.193 (+ tmp.193 2))
      (set! tmp.105 tmp.193)
      (mset! tmp.105 -2 L.fun/void13310.10.17)
      (mset! tmp.105 6 0)
      (set! fun/void13310.10 tmp.105)
      (begin (set! tmp.136 r12) (set! r12 (+ r12 16)))
      (set! tmp.194 tmp.136)
      (set! tmp.194 (+ tmp.194 2))
      (set! tmp.106 tmp.194)
      (mset! tmp.106 -2 L.fun/empty13317.11.18)
      (mset! tmp.106 6 0)
      (set! fun/empty13317.11 tmp.106)
      (begin (set! tmp.137 r12) (set! r12 (+ r12 16)))
      (set! tmp.195 tmp.137)
      (set! tmp.195 (+ tmp.195 2))
      (set! tmp.107 tmp.195)
      (mset! tmp.107 -2 L.fun/error13309.12.19)
      (mset! tmp.107 6 0)
      (set! fun/error13309.12 tmp.107)
      (begin (set! tmp.138 r12) (set! r12 (+ r12 24)))
      (set! tmp.196 tmp.138)
      (set! tmp.196 (+ tmp.196 2))
      (set! tmp.108 tmp.196)
      (mset! tmp.108 -2 L.fun/ascii-char13314.13.20)
      (mset! tmp.108 6 0)
      (set! fun/ascii-char13314.13 tmp.108)
      (begin (set! tmp.139 r12) (set! r12 (+ r12 16)))
      (set! tmp.197 tmp.139)
      (set! tmp.197 (+ tmp.197 2))
      (set! tmp.109 tmp.197)
      (mset! tmp.109 -2 L.fun/void13311.14.21)
      (mset! tmp.109 6 0)
      (set! fun/void13311.14 tmp.109)
      (begin (set! tmp.140 r12) (set! r12 (+ r12 24)))
      (set! tmp.198 tmp.140)
      (set! tmp.198 (+ tmp.198 2))
      (set! tmp.110 tmp.198)
      (mset! tmp.110 -2 L.fun/pair13318.15.22)
      (mset! tmp.110 6 0)
      (set! fun/pair13318.15 tmp.110)
      (mset! fun/empty13316.4 14 fun/empty13317.11)
      (mset! fun/error13308.7 14 fun/error13309.12)
      (mset! fun/error13312.8 14 fun/error13313.6)
      (mset! fun/pair13319.9 14 cons.74)
      (mset! fun/void13310.10 14 fun/void13311.14)
      (mset! fun/ascii-char13314.13 14 fun/ascii-char13315.5)
      (mset! fun/pair13318.15 14 fun/pair13319.9)
      (return-point L.rp.23
        (begin
          (set! rdi fun/error13308.7)
          (set! r15 L.rp.23)
          (jump L.fun/error13308.7.14 rbp r15 rdi)))
      (set! error0.21 rax)
      (return-point L.rp.24
        (begin
          (set! rdi fun/void13310.10)
          (set! r15 L.rp.24)
          (jump L.fun/void13310.10.17 rbp r15 rdi)))
      (set! void1.20 rax)
      (return-point L.rp.25
        (begin
          (set! rdi fun/error13312.8)
          (set! r15 L.rp.25)
          (jump L.fun/error13312.8.15 rbp r15 rdi)))
      (set! error2.19 rax)
      (return-point L.rp.26
        (begin
          (set! rdx 2000)
          (set! rsi 872)
          (set! rdi |+.75|)
          (set! r15 L.rp.26)
          (jump L.+.75.9 rbp r15 rdi rsi rdx)))
      (set! tmp.143 rax)
      (return-point L.rp.27
        (begin
          (set! rdx 1184)
          (set! rsi 1816)
          (set! rdi *.76)
          (set! r15 L.rp.27)
          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
      (set! tmp.144 rax)
      (return-point L.rp.28
        (begin
          (set! rdx tmp.144)
          (set! rsi tmp.143)
          (set! rdi |+.75|)
          (set! r15 L.rp.28)
          (jump L.+.75.9 rbp r15 rdi rsi rdx)))
      (set! tmp.142 rax)
      (return-point L.rp.29
        (begin
          (set! rdx 1040)
          (set! rsi 1720)
          (set! rdi |-.77|)
          (set! r15 L.rp.29)
          (jump L.-.77.7 rbp r15 rdi rsi rdx)))
      (set! tmp.146 rax)
      (return-point L.rp.30
        (begin
          (set! rdx 240)
          (set! rsi 1784)
          (set! rdi *.76)
          (set! r15 L.rp.30)
          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
      (set! tmp.147 rax)
      (return-point L.rp.31
        (begin
          (set! rdx tmp.147)
          (set! rsi tmp.146)
          (set! rdi *.76)
          (set! r15 L.rp.31)
          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
      (set! tmp.145 rax)
      (return-point L.rp.32
        (begin
          (set! rdx tmp.145)
          (set! rsi tmp.142)
          (set! rdi |-.77|)
          (set! r15 L.rp.32)
          (jump L.-.77.7 rbp r15 rdi rsi rdx)))
      (set! tmp.141 rax)
      (return-point L.rp.33
        (begin
          (set! rdx 8)
          (set! rsi 1976)
          (set! rdi *.76)
          (set! r15 L.rp.33)
          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
      (set! tmp.150 rax)
      (return-point L.rp.34
        (begin
          (set! rdx 480)
          (set! rsi 504)
          (set! rdi *.76)
          (set! r15 L.rp.34)
          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
      (set! tmp.151 rax)
      (return-point L.rp.35
        (begin
          (set! rdx tmp.151)
          (set! rsi tmp.150)
          (set! rdi |-.77|)
          (set! r15 L.rp.35)
          (jump L.-.77.7 rbp r15 rdi rsi rdx)))
      (set! tmp.149 rax)
      (return-point L.rp.36
        (begin
          (set! rdx 1664)
          (set! rsi 1664)
          (set! rdi *.76)
          (set! r15 L.rp.36)
          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
      (set! tmp.153 rax)
      (return-point L.rp.37
        (begin
          (set! rdx 1024)
          (set! rsi 1472)
          (set! rdi |-.77|)
          (set! r15 L.rp.37)
          (jump L.-.77.7 rbp r15 rdi rsi rdx)))
      (set! tmp.154 rax)
      (return-point L.rp.38
        (begin
          (set! rdx tmp.154)
          (set! rsi tmp.153)
          (set! rdi |+.75|)
          (set! r15 L.rp.38)
          (jump L.+.75.9 rbp r15 rdi rsi rdx)))
      (set! tmp.152 rax)
      (return-point L.rp.39
        (begin
          (set! rdx tmp.152)
          (set! rsi tmp.149)
          (set! rdi *.76)
          (set! r15 L.rp.39)
          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
      (set! tmp.148 rax)
      (return-point L.rp.40
        (begin
          (set! rdx tmp.148)
          (set! rsi tmp.141)
          (set! rdi |-.77|)
          (set! r15 L.rp.40)
          (jump L.-.77.7 rbp r15 rdi rsi rdx)))
      (set! fixnum3.18 rax)
      (return-point L.rp.41
        (begin
          (set! rdi fun/ascii-char13314.13)
          (set! r15 L.rp.41)
          (jump L.fun/ascii-char13314.13.20 rbp r15 rdi)))
      (set! ascii-char4.17 rax)
      (return-point L.rp.42
        (begin
          (set! rdi fun/empty13316.4)
          (set! r15 L.rp.42)
          (jump L.fun/empty13316.4.11 rbp r15 rdi)))
      (set! empty5.16 rax)
      (set! rdi fun/pair13318.15)
      (set! r15 tmp-ra.171)
      (jump L.fun/pair13318.15.22 rbp r15 rdi))))
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
       ()))
     (locals
      (error5.12
       vector4.13
       fixnum3.14
       tmp.166
       tmp.170
       tmp.172
       tmp.171
       tmp.167
       tmp.169
       tmp.168
       tmp.159
       tmp.163
       tmp.165
       tmp.164
       tmp.160
       tmp.162
       tmp.161
       lam.74
       tmp.105
       tmp.227
       tmp.158
       ascii-char1.16
       fixnum0.17
       tmp.151
       tmp.155
       tmp.157
       tmp.156
       tmp.152
       tmp.154
       tmp.153
       tmp.144
       tmp.148
       tmp.150
       tmp.149
       tmp.145
       tmp.147
       tmp.146
       fun/ascii-char13353.11
       tmp.104
       tmp.226
       tmp.143
       fun/error13359.10
       tmp.103
       tmp.225
       tmp.142
       fun/vector13356.9
       tmp.102
       tmp.224
       tmp.141
       fun/vector13354.8
       tmp.101
       tmp.223
       tmp.140
       fun/ascii-char13352.7
       tmp.100
       tmp.222
       tmp.139
       fun/vector13355.6
       tmp.99
       tmp.221
       tmp.138
       fun/vector13357.5
       tmp.98
       tmp.220
       tmp.137
       fun/error13358.4
       tmp.97
       tmp.219
       tmp.136
       make-vector.70
       tmp.96
       tmp.218
       tmp.135
       make-init-vector.1
       tmp.95
       tmp.217
       tmp.134
       vector-init-loop.20
       tmp.94
       tmp.216
       tmp.133
       *.71
       tmp.93
       tmp.215
       tmp.132
       |+.72|
       tmp.92
       tmp.214
       tmp.131
       |-.73|
       tmp.91
       tmp.213
       tmp.130
       tmp.175
       tmp.176
       tmp-ra.193
       tmp.177
       tmp.174
       procedure2.15
       tmp.228
       tmp.173)))
    (define L.lam.74.21
      ((new-frames ()) (locals (fun/vector13354.8 c.89 tmp-ra.178)))
      (begin
        (set! tmp-ra.178 r15)
        (set! c.89 rdi)
        (set! fun/vector13354.8 (mref c.89 14))
        (set! rdi fun/vector13354.8)
        (set! r15 tmp-ra.178)
        (jump L.fun/vector13354.8.17 rbp r15 rdi)))
    (define L.fun/ascii-char13353.11.20
      ((new-frames ()) (locals (c.88 tmp-ra.179)))
      (begin
        (set! tmp-ra.179 r15)
        (set! c.88 rdi)
        (set! rax 18478)
        (jump tmp-ra.179 rbp rax)))
    (define L.fun/error13359.10.19
      ((new-frames ()) (locals (c.87 tmp-ra.180)))
      (begin
        (set! tmp-ra.180 r15)
        (set! c.87 rdi)
        (set! rax 1086)
        (jump tmp-ra.180 rbp rax)))
    (define L.fun/vector13356.9.18
      ((new-frames ()) (locals (fun/vector13357.5 c.86 tmp-ra.181)))
      (begin
        (set! tmp-ra.181 r15)
        (set! c.86 rdi)
        (set! fun/vector13357.5 (mref c.86 14))
        (set! rdi fun/vector13357.5)
        (set! r15 tmp-ra.181)
        (jump L.fun/vector13357.5.14 rbp r15 rdi)))
    (define L.fun/vector13354.8.17
      ((new-frames ()) (locals (fun/vector13355.6 c.85 tmp-ra.182)))
      (begin
        (set! tmp-ra.182 r15)
        (set! c.85 rdi)
        (set! fun/vector13355.6 (mref c.85 14))
        (set! rdi fun/vector13355.6)
        (set! r15 tmp-ra.182)
        (jump L.fun/vector13355.6.15 rbp r15 rdi)))
    (define L.fun/ascii-char13352.7.16
      ((new-frames ()) (locals (fun/ascii-char13353.11 c.84 tmp-ra.183)))
      (begin
        (set! tmp-ra.183 r15)
        (set! c.84 rdi)
        (set! fun/ascii-char13353.11 (mref c.84 14))
        (set! rdi fun/ascii-char13353.11)
        (set! r15 tmp-ra.183)
        (jump L.fun/ascii-char13353.11.20 rbp r15 rdi)))
    (define L.fun/vector13355.6.15
      ((new-frames ()) (locals (make-vector.70 c.83 tmp-ra.184)))
      (begin
        (set! tmp-ra.184 r15)
        (set! c.83 rdi)
        (set! make-vector.70 (mref c.83 14))
        (set! rsi 64)
        (set! rdi make-vector.70)
        (set! r15 tmp-ra.184)
        (jump L.make-vector.70.12 rbp r15 rdi rsi)))
    (define L.fun/vector13357.5.14
      ((new-frames ()) (locals (make-vector.70 c.82 tmp-ra.185)))
      (begin
        (set! tmp-ra.185 r15)
        (set! c.82 rdi)
        (set! make-vector.70 (mref c.82 14))
        (set! rsi 64)
        (set! rdi make-vector.70)
        (set! r15 tmp-ra.185)
        (jump L.make-vector.70.12 rbp r15 rdi rsi)))
    (define L.fun/error13358.4.13
      ((new-frames ()) (locals (fun/error13359.10 c.81 tmp-ra.186)))
      (begin
        (set! tmp-ra.186 r15)
        (set! c.81 rdi)
        (set! fun/error13359.10 (mref c.81 14))
        (set! rdi fun/error13359.10)
        (set! r15 tmp-ra.186)
        (jump L.fun/error13359.10.19 rbp r15 rdi)))
    (define L.make-vector.70.12
      ((new-frames ())
       (locals
        (c.80 make-init-vector.1 tmp-ra.187 tmp.107 tmp.46 tmp.194 tmp.106)))
      (begin
        (set! tmp-ra.187 r15)
        (set! c.80 rdi)
        (set! tmp.46 rsi)
        (set! make-init-vector.1 (mref c.80 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.194 tmp.46)
                      (set! tmp.194 (bitwise-and tmp.194 7))
                      (set! tmp.107 tmp.194))
                    (= tmp.107 0))
                (set! tmp.106 14)
                (set! tmp.106 6))
              (!= tmp.106 6))
          (begin
            (set! rsi tmp.46)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.187)
            (jump L.make-init-vector.1.11 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.187 rbp rax)))))
    (define L.make-init-vector.1.11
      ((new-frames ())
       (locals
        (tmp.19
         tmp.90
         tmp.198
         tmp.108
         tmp.109
         tmp.197
         tmp.110
         tmp.196
         tmp.111
         tmp.195
         vector-init-loop.20
         tmp.18
         c.79
         tmp-ra.188)))
      (begin
        (set! tmp-ra.188 r15)
        (set! c.79 rdi)
        (set! tmp.18 rsi)
        (set! vector-init-loop.20 (mref c.79 14))
        (set! tmp.195 tmp.18)
        (set! tmp.195 (arithmetic-shift-right tmp.195 3))
        (set! tmp.111 tmp.195)
        (set! tmp.196 1)
        (set! tmp.196 (+ tmp.196 tmp.111))
        (set! tmp.110 tmp.196)
        (set! tmp.197 tmp.110)
        (set! tmp.197 (* tmp.197 8))
        (set! tmp.109 tmp.197)
        (begin (set! tmp.108 r12) (set! r12 (+ r12 tmp.109)))
        (set! tmp.198 tmp.108)
        (set! tmp.198 (+ tmp.198 3))
        (set! tmp.90 tmp.198)
        (mset! tmp.90 -3 tmp.18)
        (set! tmp.19 tmp.90)
        (set! rcx tmp.19)
        (set! rdx 0)
        (set! rsi tmp.18)
        (set! rdi vector-init-loop.20)
        (set! r15 tmp-ra.188)
        (jump L.vector-init-loop.20.10 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.20.10
      ((new-frames ())
       (locals
        (c.78
         tmp.199
         tmp.115
         tmp.200
         tmp.114
         tmp.201
         tmp.113
         tmp.202
         tmp.116
         vector-init-loop.20
         tmp-ra.189
         vec.22
         len.21
         i.23
         tmp.112)))
      (begin
        (set! tmp-ra.189 r15)
        (set! c.78 rdi)
        (set! len.21 rsi)
        (set! i.23 rdx)
        (set! vec.22 rcx)
        (set! vector-init-loop.20 (mref c.78 14))
        (if (begin
              (if (= len.21 i.23) (set! tmp.112 14) (set! tmp.112 6))
              (!= tmp.112 6))
          (begin (set! rax vec.22) (jump tmp-ra.189 rbp rax))
          (begin
            (set! tmp.199 i.23)
            (set! tmp.199 (arithmetic-shift-right tmp.199 3))
            (set! tmp.115 tmp.199)
            (set! tmp.200 tmp.115)
            (set! tmp.200 (* tmp.200 8))
            (set! tmp.114 tmp.200)
            (set! tmp.201 tmp.114)
            (set! tmp.201 (+ tmp.201 5))
            (set! tmp.113 tmp.201)
            (mset! vec.22 tmp.113 0)
            (set! tmp.202 i.23)
            (set! tmp.202 (+ tmp.202 8))
            (set! tmp.116 tmp.202)
            (set! rcx vec.22)
            (set! rdx tmp.116)
            (set! rsi len.21)
            (set! rdi vector-init-loop.20)
            (set! r15 tmp-ra.189)
            (jump L.vector-init-loop.20.10 rbp r15 rdi rsi rdx rcx)))))
    (define L.*.71.9
      ((new-frames ())
       (locals
        (c.77
         tmp.119
         tmp.204
         tmp.32
         tmp.120
         tmp.206
         tmp.121
         tmp.205
         tmp-ra.190
         tmp.118
         tmp.33
         tmp.203
         tmp.117)))
      (begin
        (set! tmp-ra.190 r15)
        (set! c.77 rdi)
        (set! tmp.32 rsi)
        (set! tmp.33 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.203 tmp.33)
                      (set! tmp.203 (bitwise-and tmp.203 7))
                      (set! tmp.118 tmp.203))
                    (= tmp.118 0))
                (set! tmp.117 14)
                (set! tmp.117 6))
              (!= tmp.117 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.204 tmp.32)
                        (set! tmp.204 (bitwise-and tmp.204 7))
                        (set! tmp.120 tmp.204))
                      (= tmp.120 0))
                  (set! tmp.119 14)
                  (set! tmp.119 6))
                (!= tmp.119 6))
            (begin
              (set! tmp.205 tmp.33)
              (set! tmp.205 (arithmetic-shift-right tmp.205 3))
              (set! tmp.121 tmp.205)
              (set! tmp.206 tmp.32)
              (set! tmp.206 (* tmp.206 tmp.121))
              (set! rax tmp.206)
              (jump tmp-ra.190 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.190 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.190 rbp rax)))))
    (define L.+.72.8
      ((new-frames ())
       (locals
        (c.76
         tmp.124
         tmp.208
         tmp.34
         tmp.125
         tmp.209
         tmp-ra.191
         tmp.123
         tmp.35
         tmp.207
         tmp.122)))
      (begin
        (set! tmp-ra.191 r15)
        (set! c.76 rdi)
        (set! tmp.34 rsi)
        (set! tmp.35 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.207 tmp.35)
                      (set! tmp.207 (bitwise-and tmp.207 7))
                      (set! tmp.123 tmp.207))
                    (= tmp.123 0))
                (set! tmp.122 14)
                (set! tmp.122 6))
              (!= tmp.122 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.208 tmp.34)
                        (set! tmp.208 (bitwise-and tmp.208 7))
                        (set! tmp.125 tmp.208))
                      (= tmp.125 0))
                  (set! tmp.124 14)
                  (set! tmp.124 6))
                (!= tmp.124 6))
            (begin
              (set! tmp.209 tmp.34)
              (set! tmp.209 (+ tmp.209 tmp.35))
              (set! rax tmp.209)
              (jump tmp-ra.191 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.191 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.191 rbp rax)))))
    (define L.-.73.7
      ((new-frames ())
       (locals
        (c.75
         tmp.128
         tmp.211
         tmp.36
         tmp.129
         tmp.212
         tmp-ra.192
         tmp.127
         tmp.37
         tmp.210
         tmp.126)))
      (begin
        (set! tmp-ra.192 r15)
        (set! c.75 rdi)
        (set! tmp.36 rsi)
        (set! tmp.37 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.210 tmp.37)
                      (set! tmp.210 (bitwise-and tmp.210 7))
                      (set! tmp.127 tmp.210))
                    (= tmp.127 0))
                (set! tmp.126 14)
                (set! tmp.126 6))
              (!= tmp.126 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.211 tmp.36)
                        (set! tmp.211 (bitwise-and tmp.211 7))
                        (set! tmp.129 tmp.211))
                      (= tmp.129 0))
                  (set! tmp.128 14)
                  (set! tmp.128 6))
                (!= tmp.128 6))
            (begin
              (set! tmp.212 tmp.36)
              (set! tmp.212 (- tmp.212 tmp.37))
              (set! rax tmp.212)
              (jump tmp-ra.192 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.192 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.192 rbp rax)))))
    (begin
      (set! tmp-ra.193 r15)
      (begin (set! tmp.130 r12) (set! r12 (+ r12 16)))
      (set! tmp.213 tmp.130)
      (set! tmp.213 (+ tmp.213 2))
      (set! tmp.91 tmp.213)
      (mset! tmp.91 -2 L.-.73.7)
      (mset! tmp.91 6 16)
      (set! |-.73| tmp.91)
      (begin (set! tmp.131 r12) (set! r12 (+ r12 16)))
      (set! tmp.214 tmp.131)
      (set! tmp.214 (+ tmp.214 2))
      (set! tmp.92 tmp.214)
      (mset! tmp.92 -2 L.+.72.8)
      (mset! tmp.92 6 16)
      (set! |+.72| tmp.92)
      (begin (set! tmp.132 r12) (set! r12 (+ r12 16)))
      (set! tmp.215 tmp.132)
      (set! tmp.215 (+ tmp.215 2))
      (set! tmp.93 tmp.215)
      (mset! tmp.93 -2 L.*.71.9)
      (mset! tmp.93 6 16)
      (set! *.71 tmp.93)
      (begin (set! tmp.133 r12) (set! r12 (+ r12 24)))
      (set! tmp.216 tmp.133)
      (set! tmp.216 (+ tmp.216 2))
      (set! tmp.94 tmp.216)
      (mset! tmp.94 -2 L.vector-init-loop.20.10)
      (mset! tmp.94 6 24)
      (set! vector-init-loop.20 tmp.94)
      (begin (set! tmp.134 r12) (set! r12 (+ r12 24)))
      (set! tmp.217 tmp.134)
      (set! tmp.217 (+ tmp.217 2))
      (set! tmp.95 tmp.217)
      (mset! tmp.95 -2 L.make-init-vector.1.11)
      (mset! tmp.95 6 8)
      (set! make-init-vector.1 tmp.95)
      (begin (set! tmp.135 r12) (set! r12 (+ r12 24)))
      (set! tmp.218 tmp.135)
      (set! tmp.218 (+ tmp.218 2))
      (set! tmp.96 tmp.218)
      (mset! tmp.96 -2 L.make-vector.70.12)
      (mset! tmp.96 6 8)
      (set! make-vector.70 tmp.96)
      (begin (set! tmp.136 r12) (set! r12 (+ r12 24)))
      (set! tmp.219 tmp.136)
      (set! tmp.219 (+ tmp.219 2))
      (set! tmp.97 tmp.219)
      (mset! tmp.97 -2 L.fun/error13358.4.13)
      (mset! tmp.97 6 0)
      (set! fun/error13358.4 tmp.97)
      (begin (set! tmp.137 r12) (set! r12 (+ r12 24)))
      (set! tmp.220 tmp.137)
      (set! tmp.220 (+ tmp.220 2))
      (set! tmp.98 tmp.220)
      (mset! tmp.98 -2 L.fun/vector13357.5.14)
      (mset! tmp.98 6 0)
      (set! fun/vector13357.5 tmp.98)
      (begin (set! tmp.138 r12) (set! r12 (+ r12 24)))
      (set! tmp.221 tmp.138)
      (set! tmp.221 (+ tmp.221 2))
      (set! tmp.99 tmp.221)
      (mset! tmp.99 -2 L.fun/vector13355.6.15)
      (mset! tmp.99 6 0)
      (set! fun/vector13355.6 tmp.99)
      (begin (set! tmp.139 r12) (set! r12 (+ r12 24)))
      (set! tmp.222 tmp.139)
      (set! tmp.222 (+ tmp.222 2))
      (set! tmp.100 tmp.222)
      (mset! tmp.100 -2 L.fun/ascii-char13352.7.16)
      (mset! tmp.100 6 0)
      (set! fun/ascii-char13352.7 tmp.100)
      (begin (set! tmp.140 r12) (set! r12 (+ r12 24)))
      (set! tmp.223 tmp.140)
      (set! tmp.223 (+ tmp.223 2))
      (set! tmp.101 tmp.223)
      (mset! tmp.101 -2 L.fun/vector13354.8.17)
      (mset! tmp.101 6 0)
      (set! fun/vector13354.8 tmp.101)
      (begin (set! tmp.141 r12) (set! r12 (+ r12 24)))
      (set! tmp.224 tmp.141)
      (set! tmp.224 (+ tmp.224 2))
      (set! tmp.102 tmp.224)
      (mset! tmp.102 -2 L.fun/vector13356.9.18)
      (mset! tmp.102 6 0)
      (set! fun/vector13356.9 tmp.102)
      (begin (set! tmp.142 r12) (set! r12 (+ r12 16)))
      (set! tmp.225 tmp.142)
      (set! tmp.225 (+ tmp.225 2))
      (set! tmp.103 tmp.225)
      (mset! tmp.103 -2 L.fun/error13359.10.19)
      (mset! tmp.103 6 0)
      (set! fun/error13359.10 tmp.103)
      (begin (set! tmp.143 r12) (set! r12 (+ r12 16)))
      (set! tmp.226 tmp.143)
      (set! tmp.226 (+ tmp.226 2))
      (set! tmp.104 tmp.226)
      (mset! tmp.104 -2 L.fun/ascii-char13353.11.20)
      (mset! tmp.104 6 0)
      (set! fun/ascii-char13353.11 tmp.104)
      (mset! vector-init-loop.20 14 vector-init-loop.20)
      (mset! make-init-vector.1 14 vector-init-loop.20)
      (mset! make-vector.70 14 make-init-vector.1)
      (mset! fun/error13358.4 14 fun/error13359.10)
      (mset! fun/vector13357.5 14 make-vector.70)
      (mset! fun/vector13355.6 14 make-vector.70)
      (mset! fun/ascii-char13352.7 14 fun/ascii-char13353.11)
      (mset! fun/vector13354.8 14 fun/vector13355.6)
      (mset! fun/vector13356.9 14 fun/vector13357.5)
      (return-point L.rp.22
        (begin
          (set! rdx 1608)
          (set! rsi 488)
          (set! rdi *.71)
          (set! r15 L.rp.22)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! tmp.146 rax)
      (return-point L.rp.23
        (begin
          (set! rdx 144)
          (set! rsi 88)
          (set! rdi *.71)
          (set! r15 L.rp.23)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! tmp.147 rax)
      (return-point L.rp.24
        (begin
          (set! rdx tmp.147)
          (set! rsi tmp.146)
          (set! rdi |+.72|)
          (set! r15 L.rp.24)
          (jump L.+.72.8 rbp r15 rdi rsi rdx)))
      (set! tmp.145 rax)
      (return-point L.rp.25
        (begin
          (set! rdx 216)
          (set! rsi 736)
          (set! rdi |-.73|)
          (set! r15 L.rp.25)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! tmp.149 rax)
      (return-point L.rp.26
        (begin
          (set! rdx 1816)
          (set! rsi 792)
          (set! rdi |+.72|)
          (set! r15 L.rp.26)
          (jump L.+.72.8 rbp r15 rdi rsi rdx)))
      (set! tmp.150 rax)
      (return-point L.rp.27
        (begin
          (set! rdx tmp.150)
          (set! rsi tmp.149)
          (set! rdi |+.72|)
          (set! r15 L.rp.27)
          (jump L.+.72.8 rbp r15 rdi rsi rdx)))
      (set! tmp.148 rax)
      (return-point L.rp.28
        (begin
          (set! rdx tmp.148)
          (set! rsi tmp.145)
          (set! rdi |+.72|)
          (set! r15 L.rp.28)
          (jump L.+.72.8 rbp r15 rdi rsi rdx)))
      (set! tmp.144 rax)
      (return-point L.rp.29
        (begin
          (set! rdx 1752)
          (set! rsi 624)
          (set! rdi |-.73|)
          (set! r15 L.rp.29)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! tmp.153 rax)
      (return-point L.rp.30
        (begin
          (set! rdx 632)
          (set! rsi 1848)
          (set! rdi |+.72|)
          (set! r15 L.rp.30)
          (jump L.+.72.8 rbp r15 rdi rsi rdx)))
      (set! tmp.154 rax)
      (return-point L.rp.31
        (begin
          (set! rdx tmp.154)
          (set! rsi tmp.153)
          (set! rdi *.71)
          (set! r15 L.rp.31)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! tmp.152 rax)
      (return-point L.rp.32
        (begin
          (set! rdx 744)
          (set! rsi 320)
          (set! rdi |-.73|)
          (set! r15 L.rp.32)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! tmp.156 rax)
      (return-point L.rp.33
        (begin
          (set! rdx 64)
          (set! rsi 912)
          (set! rdi *.71)
          (set! r15 L.rp.33)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! tmp.157 rax)
      (return-point L.rp.34
        (begin
          (set! rdx tmp.157)
          (set! rsi tmp.156)
          (set! rdi |+.72|)
          (set! r15 L.rp.34)
          (jump L.+.72.8 rbp r15 rdi rsi rdx)))
      (set! tmp.155 rax)
      (return-point L.rp.35
        (begin
          (set! rdx tmp.155)
          (set! rsi tmp.152)
          (set! rdi |+.72|)
          (set! r15 L.rp.35)
          (jump L.+.72.8 rbp r15 rdi rsi rdx)))
      (set! tmp.151 rax)
      (return-point L.rp.36
        (begin
          (set! rdx tmp.151)
          (set! rsi tmp.144)
          (set! rdi *.71)
          (set! r15 L.rp.36)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! fixnum0.17 rax)
      (return-point L.rp.37
        (begin
          (set! rdi fun/ascii-char13352.7)
          (set! r15 L.rp.37)
          (jump L.fun/ascii-char13352.7.16 rbp r15 rdi)))
      (set! ascii-char1.16 rax)
      (begin (set! tmp.158 r12) (set! r12 (+ r12 24)))
      (set! tmp.227 tmp.158)
      (set! tmp.227 (+ tmp.227 2))
      (set! tmp.105 tmp.227)
      (mset! tmp.105 -2 L.lam.74.21)
      (mset! tmp.105 6 0)
      (set! lam.74 tmp.105)
      (mset! lam.74 14 fun/vector13354.8)
      (set! procedure2.15 lam.74)
      (return-point L.rp.38
        (begin
          (set! rdx 1496)
          (set! rsi 1472)
          (set! rdi |-.73|)
          (set! r15 L.rp.38)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! tmp.161 rax)
      (return-point L.rp.39
        (begin
          (set! rdx 664)
          (set! rsi 1992)
          (set! rdi |-.73|)
          (set! r15 L.rp.39)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! tmp.162 rax)
      (return-point L.rp.40
        (begin
          (set! rdx tmp.162)
          (set! rsi tmp.161)
          (set! rdi |-.73|)
          (set! r15 L.rp.40)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! tmp.160 rax)
      (return-point L.rp.41
        (begin
          (set! rdx 1664)
          (set! rsi 1984)
          (set! rdi *.71)
          (set! r15 L.rp.41)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! tmp.164 rax)
      (return-point L.rp.42
        (begin
          (set! rdx 1048)
          (set! rsi 1592)
          (set! rdi |+.72|)
          (set! r15 L.rp.42)
          (jump L.+.72.8 rbp r15 rdi rsi rdx)))
      (set! tmp.165 rax)
      (return-point L.rp.43
        (begin
          (set! rdx tmp.165)
          (set! rsi tmp.164)
          (set! rdi |-.73|)
          (set! r15 L.rp.43)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! tmp.163 rax)
      (return-point L.rp.44
        (begin
          (set! rdx tmp.163)
          (set! rsi tmp.160)
          (set! rdi *.71)
          (set! r15 L.rp.44)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! tmp.159 rax)
      (return-point L.rp.45
        (begin
          (set! rdx 1896)
          (set! rsi 128)
          (set! rdi *.71)
          (set! r15 L.rp.45)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! tmp.168 rax)
      (return-point L.rp.46
        (begin
          (set! rdx 1096)
          (set! rsi 1472)
          (set! rdi *.71)
          (set! r15 L.rp.46)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! tmp.169 rax)
      (return-point L.rp.47
        (begin
          (set! rdx tmp.169)
          (set! rsi tmp.168)
          (set! rdi *.71)
          (set! r15 L.rp.47)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! tmp.167 rax)
      (return-point L.rp.48
        (begin
          (set! rdx 1528)
          (set! rsi 608)
          (set! rdi |-.73|)
          (set! r15 L.rp.48)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! tmp.171 rax)
      (return-point L.rp.49
        (begin
          (set! rdx 720)
          (set! rsi 1480)
          (set! rdi |-.73|)
          (set! r15 L.rp.49)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! tmp.172 rax)
      (return-point L.rp.50
        (begin
          (set! rdx tmp.172)
          (set! rsi tmp.171)
          (set! rdi *.71)
          (set! r15 L.rp.50)
          (jump L.*.71.9 rbp r15 rdi rsi rdx)))
      (set! tmp.170 rax)
      (return-point L.rp.51
        (begin
          (set! rdx tmp.170)
          (set! rsi tmp.167)
          (set! rdi |-.73|)
          (set! r15 L.rp.51)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! tmp.166 rax)
      (return-point L.rp.52
        (begin
          (set! rdx tmp.166)
          (set! rsi tmp.159)
          (set! rdi |-.73|)
          (set! r15 L.rp.52)
          (jump L.-.73.7 rbp r15 rdi rsi rdx)))
      (set! fixnum3.14 rax)
      (return-point L.rp.53
        (begin
          (set! rdi fun/vector13356.9)
          (set! r15 L.rp.53)
          (jump L.fun/vector13356.9.18 rbp r15 rdi)))
      (set! vector4.13 rax)
      (return-point L.rp.54
        (begin
          (set! rdi fun/error13358.4)
          (set! r15 L.rp.54)
          (jump L.fun/error13358.4.13 rbp r15 rdi)))
      (set! error5.12 rax)
      (if (begin
            (if (begin
                  (begin
                    (set! tmp.228 procedure2.15)
                    (set! tmp.228 (bitwise-and tmp.228 7))
                    (set! tmp.174 tmp.228))
                  (= tmp.174 2))
              (set! tmp.173 14)
              (set! tmp.173 6))
            (!= tmp.173 6))
        (if (begin
              (if (begin (set! tmp.176 (mref procedure2.15 6)) (= tmp.176 0))
                (set! tmp.175 14)
                (set! tmp.175 6))
              (!= tmp.175 6))
          (begin
            (set! tmp.177 (mref procedure2.15 -2))
            (set! rdi procedure2.15)
            (set! r15 tmp-ra.193)
            (jump tmp.177 rbp r15 rdi))
          (begin (set! rax 10814) (jump tmp-ra.193 rbp rax)))
        (begin (set! rax 11070) (jump tmp-ra.193 rbp rax))))))
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
       ()))
     (locals
      (fixnum5.14
       tmp.148
       tmp.152
       tmp.154
       tmp.153
       tmp.149
       tmp.151
       tmp.150
       tmp.141
       tmp.145
       tmp.147
       tmp.146
       tmp.142
       tmp.144
       tmp.143
       void4.15
       fixnum3.16
       tmp.134
       tmp.138
       tmp.140
       tmp.139
       tmp.135
       tmp.137
       tmp.136
       tmp.127
       tmp.131
       tmp.133
       tmp.132
       tmp.128
       tmp.130
       tmp.129
       void2.17
       ascii-char1.18
       empty0.19
       fun/empty14584.13
       tmp.100
       tmp.191
       tmp.126
       fun/void14589.12
       tmp.99
       tmp.190
       tmp.125
       fun/empty14585.11
       tmp.98
       tmp.189
       tmp.124
       fun/ascii-char14587.10
       tmp.97
       tmp.188
       tmp.123
       fun/void14592.9
       tmp.96
       tmp.187
       tmp.122
       fun/void14588.8
       tmp.95
       tmp.186
       tmp.121
       fun/ascii-char14586.7
       tmp.94
       tmp.185
       tmp.120
       fun/void14590.6
       tmp.93
       tmp.184
       tmp.119
       fun/void14591.5
       tmp.92
       tmp.183
       tmp.118
       fun/void14593.4
       tmp.91
       tmp.182
       tmp.117
       |-.72|
       tmp.90
       tmp.181
       tmp.116
       |+.73|
       tmp.89
       tmp.180
       tmp.115
       *.74
       tmp.88
       tmp.179
       tmp.114
       tmp-ra.168)))
    (define L.fun/empty14584.13.19
      ((new-frames ()) (locals (fun/empty14585.11 c.87 tmp-ra.155)))
      (begin
        (set! tmp-ra.155 r15)
        (set! c.87 rdi)
        (set! fun/empty14585.11 (mref c.87 14))
        (set! rdi fun/empty14585.11)
        (set! r15 tmp-ra.155)
        (jump L.fun/empty14585.11.17 rbp r15 rdi)))
    (define L.fun/void14589.12.18
      ((new-frames ()) (locals (c.86 tmp-ra.156)))
      (begin
        (set! tmp-ra.156 r15)
        (set! c.86 rdi)
        (set! rax 30)
        (jump tmp-ra.156 rbp rax)))
    (define L.fun/empty14585.11.17
      ((new-frames ()) (locals (c.85 tmp-ra.157)))
      (begin
        (set! tmp-ra.157 r15)
        (set! c.85 rdi)
        (set! rax 22)
        (jump tmp-ra.157 rbp rax)))
    (define L.fun/ascii-char14587.10.16
      ((new-frames ()) (locals (c.84 tmp-ra.158)))
      (begin
        (set! tmp-ra.158 r15)
        (set! c.84 rdi)
        (set! rax 21550)
        (jump tmp-ra.158 rbp rax)))
    (define L.fun/void14592.9.15
      ((new-frames ()) (locals (fun/void14593.4 c.83 tmp-ra.159)))
      (begin
        (set! tmp-ra.159 r15)
        (set! c.83 rdi)
        (set! fun/void14593.4 (mref c.83 14))
        (set! rdi fun/void14593.4)
        (set! r15 tmp-ra.159)
        (jump L.fun/void14593.4.10 rbp r15 rdi)))
    (define L.fun/void14588.8.14
      ((new-frames ()) (locals (fun/void14589.12 c.82 tmp-ra.160)))
      (begin
        (set! tmp-ra.160 r15)
        (set! c.82 rdi)
        (set! fun/void14589.12 (mref c.82 14))
        (set! rdi fun/void14589.12)
        (set! r15 tmp-ra.160)
        (jump L.fun/void14589.12.18 rbp r15 rdi)))
    (define L.fun/ascii-char14586.7.13
      ((new-frames ()) (locals (fun/ascii-char14587.10 c.81 tmp-ra.161)))
      (begin
        (set! tmp-ra.161 r15)
        (set! c.81 rdi)
        (set! fun/ascii-char14587.10 (mref c.81 14))
        (set! rdi fun/ascii-char14587.10)
        (set! r15 tmp-ra.161)
        (jump L.fun/ascii-char14587.10.16 rbp r15 rdi)))
    (define L.fun/void14590.6.12
      ((new-frames ()) (locals (fun/void14591.5 c.80 tmp-ra.162)))
      (begin
        (set! tmp-ra.162 r15)
        (set! c.80 rdi)
        (set! fun/void14591.5 (mref c.80 14))
        (set! rdi fun/void14591.5)
        (set! r15 tmp-ra.162)
        (jump L.fun/void14591.5.11 rbp r15 rdi)))
    (define L.fun/void14591.5.11
      ((new-frames ()) (locals (c.79 tmp-ra.163)))
      (begin
        (set! tmp-ra.163 r15)
        (set! c.79 rdi)
        (set! rax 30)
        (jump tmp-ra.163 rbp rax)))
    (define L.fun/void14593.4.10
      ((new-frames ()) (locals (c.78 tmp-ra.164)))
      (begin
        (set! tmp-ra.164 r15)
        (set! c.78 rdi)
        (set! rax 30)
        (jump tmp-ra.164 rbp rax)))
    (define L.-.72.9
      ((new-frames ())
       (locals
        (c.77
         tmp.103
         tmp.170
         tmp.38
         tmp.104
         tmp.171
         tmp-ra.165
         tmp.102
         tmp.39
         tmp.169
         tmp.101)))
      (begin
        (set! tmp-ra.165 r15)
        (set! c.77 rdi)
        (set! tmp.38 rsi)
        (set! tmp.39 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.169 tmp.39)
                      (set! tmp.169 (bitwise-and tmp.169 7))
                      (set! tmp.102 tmp.169))
                    (= tmp.102 0))
                (set! tmp.101 14)
                (set! tmp.101 6))
              (!= tmp.101 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.170 tmp.38)
                        (set! tmp.170 (bitwise-and tmp.170 7))
                        (set! tmp.104 tmp.170))
                      (= tmp.104 0))
                  (set! tmp.103 14)
                  (set! tmp.103 6))
                (!= tmp.103 6))
            (begin
              (set! tmp.171 tmp.38)
              (set! tmp.171 (- tmp.171 tmp.39))
              (set! rax tmp.171)
              (jump tmp-ra.165 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.165 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.165 rbp rax)))))
    (define L.+.73.8
      ((new-frames ())
       (locals
        (c.76
         tmp.107
         tmp.173
         tmp.36
         tmp.108
         tmp.174
         tmp-ra.166
         tmp.106
         tmp.37
         tmp.172
         tmp.105)))
      (begin
        (set! tmp-ra.166 r15)
        (set! c.76 rdi)
        (set! tmp.36 rsi)
        (set! tmp.37 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.172 tmp.37)
                      (set! tmp.172 (bitwise-and tmp.172 7))
                      (set! tmp.106 tmp.172))
                    (= tmp.106 0))
                (set! tmp.105 14)
                (set! tmp.105 6))
              (!= tmp.105 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.173 tmp.36)
                        (set! tmp.173 (bitwise-and tmp.173 7))
                        (set! tmp.108 tmp.173))
                      (= tmp.108 0))
                  (set! tmp.107 14)
                  (set! tmp.107 6))
                (!= tmp.107 6))
            (begin
              (set! tmp.174 tmp.36)
              (set! tmp.174 (+ tmp.174 tmp.37))
              (set! rax tmp.174)
              (jump tmp-ra.166 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.166 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.166 rbp rax)))))
    (define L.*.74.7
      ((new-frames ())
       (locals
        (c.75
         tmp.111
         tmp.176
         tmp.34
         tmp.112
         tmp.178
         tmp.113
         tmp.177
         tmp-ra.167
         tmp.110
         tmp.35
         tmp.175
         tmp.109)))
      (begin
        (set! tmp-ra.167 r15)
        (set! c.75 rdi)
        (set! tmp.34 rsi)
        (set! tmp.35 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.175 tmp.35)
                      (set! tmp.175 (bitwise-and tmp.175 7))
                      (set! tmp.110 tmp.175))
                    (= tmp.110 0))
                (set! tmp.109 14)
                (set! tmp.109 6))
              (!= tmp.109 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.176 tmp.34)
                        (set! tmp.176 (bitwise-and tmp.176 7))
                        (set! tmp.112 tmp.176))
                      (= tmp.112 0))
                  (set! tmp.111 14)
                  (set! tmp.111 6))
                (!= tmp.111 6))
            (begin
              (set! tmp.177 tmp.35)
              (set! tmp.177 (arithmetic-shift-right tmp.177 3))
              (set! tmp.113 tmp.177)
              (set! tmp.178 tmp.34)
              (set! tmp.178 (* tmp.178 tmp.113))
              (set! rax tmp.178)
              (jump tmp-ra.167 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.167 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.167 rbp rax)))))
    (begin
      (set! tmp-ra.168 r15)
      (begin (set! tmp.114 r12) (set! r12 (+ r12 16)))
      (set! tmp.179 tmp.114)
      (set! tmp.179 (+ tmp.179 2))
      (set! tmp.88 tmp.179)
      (mset! tmp.88 -2 L.*.74.7)
      (mset! tmp.88 6 16)
      (set! *.74 tmp.88)
      (begin (set! tmp.115 r12) (set! r12 (+ r12 16)))
      (set! tmp.180 tmp.115)
      (set! tmp.180 (+ tmp.180 2))
      (set! tmp.89 tmp.180)
      (mset! tmp.89 -2 L.+.73.8)
      (mset! tmp.89 6 16)
      (set! |+.73| tmp.89)
      (begin (set! tmp.116 r12) (set! r12 (+ r12 16)))
      (set! tmp.181 tmp.116)
      (set! tmp.181 (+ tmp.181 2))
      (set! tmp.90 tmp.181)
      (mset! tmp.90 -2 L.-.72.9)
      (mset! tmp.90 6 16)
      (set! |-.72| tmp.90)
      (begin (set! tmp.117 r12) (set! r12 (+ r12 16)))
      (set! tmp.182 tmp.117)
      (set! tmp.182 (+ tmp.182 2))
      (set! tmp.91 tmp.182)
      (mset! tmp.91 -2 L.fun/void14593.4.10)
      (mset! tmp.91 6 0)
      (set! fun/void14593.4 tmp.91)
      (begin (set! tmp.118 r12) (set! r12 (+ r12 16)))
      (set! tmp.183 tmp.118)
      (set! tmp.183 (+ tmp.183 2))
      (set! tmp.92 tmp.183)
      (mset! tmp.92 -2 L.fun/void14591.5.11)
      (mset! tmp.92 6 0)
      (set! fun/void14591.5 tmp.92)
      (begin (set! tmp.119 r12) (set! r12 (+ r12 24)))
      (set! tmp.184 tmp.119)
      (set! tmp.184 (+ tmp.184 2))
      (set! tmp.93 tmp.184)
      (mset! tmp.93 -2 L.fun/void14590.6.12)
      (mset! tmp.93 6 0)
      (set! fun/void14590.6 tmp.93)
      (begin (set! tmp.120 r12) (set! r12 (+ r12 24)))
      (set! tmp.185 tmp.120)
      (set! tmp.185 (+ tmp.185 2))
      (set! tmp.94 tmp.185)
      (mset! tmp.94 -2 L.fun/ascii-char14586.7.13)
      (mset! tmp.94 6 0)
      (set! fun/ascii-char14586.7 tmp.94)
      (begin (set! tmp.121 r12) (set! r12 (+ r12 24)))
      (set! tmp.186 tmp.121)
      (set! tmp.186 (+ tmp.186 2))
      (set! tmp.95 tmp.186)
      (mset! tmp.95 -2 L.fun/void14588.8.14)
      (mset! tmp.95 6 0)
      (set! fun/void14588.8 tmp.95)
      (begin (set! tmp.122 r12) (set! r12 (+ r12 24)))
      (set! tmp.187 tmp.122)
      (set! tmp.187 (+ tmp.187 2))
      (set! tmp.96 tmp.187)
      (mset! tmp.96 -2 L.fun/void14592.9.15)
      (mset! tmp.96 6 0)
      (set! fun/void14592.9 tmp.96)
      (begin (set! tmp.123 r12) (set! r12 (+ r12 16)))
      (set! tmp.188 tmp.123)
      (set! tmp.188 (+ tmp.188 2))
      (set! tmp.97 tmp.188)
      (mset! tmp.97 -2 L.fun/ascii-char14587.10.16)
      (mset! tmp.97 6 0)
      (set! fun/ascii-char14587.10 tmp.97)
      (begin (set! tmp.124 r12) (set! r12 (+ r12 16)))
      (set! tmp.189 tmp.124)
      (set! tmp.189 (+ tmp.189 2))
      (set! tmp.98 tmp.189)
      (mset! tmp.98 -2 L.fun/empty14585.11.17)
      (mset! tmp.98 6 0)
      (set! fun/empty14585.11 tmp.98)
      (begin (set! tmp.125 r12) (set! r12 (+ r12 16)))
      (set! tmp.190 tmp.125)
      (set! tmp.190 (+ tmp.190 2))
      (set! tmp.99 tmp.190)
      (mset! tmp.99 -2 L.fun/void14589.12.18)
      (mset! tmp.99 6 0)
      (set! fun/void14589.12 tmp.99)
      (begin (set! tmp.126 r12) (set! r12 (+ r12 24)))
      (set! tmp.191 tmp.126)
      (set! tmp.191 (+ tmp.191 2))
      (set! tmp.100 tmp.191)
      (mset! tmp.100 -2 L.fun/empty14584.13.19)
      (mset! tmp.100 6 0)
      (set! fun/empty14584.13 tmp.100)
      (mset! fun/void14590.6 14 fun/void14591.5)
      (mset! fun/ascii-char14586.7 14 fun/ascii-char14587.10)
      (mset! fun/void14588.8 14 fun/void14589.12)
      (mset! fun/void14592.9 14 fun/void14593.4)
      (mset! fun/empty14584.13 14 fun/empty14585.11)
      (return-point L.rp.20
        (begin
          (set! rdi fun/empty14584.13)
          (set! r15 L.rp.20)
          (jump L.fun/empty14584.13.19 rbp r15 rdi)))
      (set! empty0.19 rax)
      (return-point L.rp.21
        (begin
          (set! rdi fun/ascii-char14586.7)
          (set! r15 L.rp.21)
          (jump L.fun/ascii-char14586.7.13 rbp r15 rdi)))
      (set! ascii-char1.18 rax)
      (return-point L.rp.22
        (begin
          (set! rdi fun/void14588.8)
          (set! r15 L.rp.22)
          (jump L.fun/void14588.8.14 rbp r15 rdi)))
      (set! void2.17 rax)
      (return-point L.rp.23
        (begin
          (set! rdx 904)
          (set! rsi 1552)
          (set! rdi |-.72|)
          (set! r15 L.rp.23)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.129 rax)
      (return-point L.rp.24
        (begin
          (set! rdx 1928)
          (set! rsi 1480)
          (set! rdi |-.72|)
          (set! r15 L.rp.24)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.130 rax)
      (return-point L.rp.25
        (begin
          (set! rdx tmp.130)
          (set! rsi tmp.129)
          (set! rdi |-.72|)
          (set! r15 L.rp.25)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.128 rax)
      (return-point L.rp.26
        (begin
          (set! rdx 728)
          (set! rsi 1296)
          (set! rdi |+.73|)
          (set! r15 L.rp.26)
          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
      (set! tmp.132 rax)
      (return-point L.rp.27
        (begin
          (set! rdx 1576)
          (set! rsi 1312)
          (set! rdi |-.72|)
          (set! r15 L.rp.27)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.133 rax)
      (return-point L.rp.28
        (begin
          (set! rdx tmp.133)
          (set! rsi tmp.132)
          (set! rdi *.74)
          (set! r15 L.rp.28)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.131 rax)
      (return-point L.rp.29
        (begin
          (set! rdx tmp.131)
          (set! rsi tmp.128)
          (set! rdi |+.73|)
          (set! r15 L.rp.29)
          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
      (set! tmp.127 rax)
      (return-point L.rp.30
        (begin
          (set! rdx 1792)
          (set! rsi 1992)
          (set! rdi |-.72|)
          (set! r15 L.rp.30)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.136 rax)
      (return-point L.rp.31
        (begin
          (set! rdx 1496)
          (set! rsi 2000)
          (set! rdi |-.72|)
          (set! r15 L.rp.31)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.137 rax)
      (return-point L.rp.32
        (begin
          (set! rdx tmp.137)
          (set! rsi tmp.136)
          (set! rdi *.74)
          (set! r15 L.rp.32)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.135 rax)
      (return-point L.rp.33
        (begin
          (set! rdx 752)
          (set! rsi 1712)
          (set! rdi *.74)
          (set! r15 L.rp.33)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.139 rax)
      (return-point L.rp.34
        (begin
          (set! rdx 1528)
          (set! rsi 1648)
          (set! rdi *.74)
          (set! r15 L.rp.34)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.140 rax)
      (return-point L.rp.35
        (begin
          (set! rdx tmp.140)
          (set! rsi tmp.139)
          (set! rdi *.74)
          (set! r15 L.rp.35)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.138 rax)
      (return-point L.rp.36
        (begin
          (set! rdx tmp.138)
          (set! rsi tmp.135)
          (set! rdi |+.73|)
          (set! r15 L.rp.36)
          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
      (set! tmp.134 rax)
      (return-point L.rp.37
        (begin
          (set! rdx tmp.134)
          (set! rsi tmp.127)
          (set! rdi |+.73|)
          (set! r15 L.rp.37)
          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
      (set! fixnum3.16 rax)
      (return-point L.rp.38
        (begin
          (set! rdi fun/void14590.6)
          (set! r15 L.rp.38)
          (jump L.fun/void14590.6.12 rbp r15 rdi)))
      (set! void4.15 rax)
      (return-point L.rp.39
        (begin
          (set! rdx 296)
          (set! rsi 1184)
          (set! rdi |-.72|)
          (set! r15 L.rp.39)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.143 rax)
      (return-point L.rp.40
        (begin
          (set! rdx 88)
          (set! rsi 880)
          (set! rdi *.74)
          (set! r15 L.rp.40)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.144 rax)
      (return-point L.rp.41
        (begin
          (set! rdx tmp.144)
          (set! rsi tmp.143)
          (set! rdi |+.73|)
          (set! r15 L.rp.41)
          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
      (set! tmp.142 rax)
      (return-point L.rp.42
        (begin
          (set! rdx 616)
          (set! rsi 40)
          (set! rdi *.74)
          (set! r15 L.rp.42)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.146 rax)
      (return-point L.rp.43
        (begin
          (set! rdx 1784)
          (set! rsi 424)
          (set! rdi |-.72|)
          (set! r15 L.rp.43)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.147 rax)
      (return-point L.rp.44
        (begin
          (set! rdx tmp.147)
          (set! rsi tmp.146)
          (set! rdi *.74)
          (set! r15 L.rp.44)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.145 rax)
      (return-point L.rp.45
        (begin
          (set! rdx tmp.145)
          (set! rsi tmp.142)
          (set! rdi |-.72|)
          (set! r15 L.rp.45)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.141 rax)
      (return-point L.rp.46
        (begin
          (set! rdx 688)
          (set! rsi 512)
          (set! rdi *.74)
          (set! r15 L.rp.46)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.150 rax)
      (return-point L.rp.47
        (begin
          (set! rdx 968)
          (set! rsi 1616)
          (set! rdi |-.72|)
          (set! r15 L.rp.47)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.151 rax)
      (return-point L.rp.48
        (begin
          (set! rdx tmp.151)
          (set! rsi tmp.150)
          (set! rdi |-.72|)
          (set! r15 L.rp.48)
          (jump L.-.72.9 rbp r15 rdi rsi rdx)))
      (set! tmp.149 rax)
      (return-point L.rp.49
        (begin
          (set! rdx 208)
          (set! rsi 608)
          (set! rdi *.74)
          (set! r15 L.rp.49)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.153 rax)
      (return-point L.rp.50
        (begin
          (set! rdx 1832)
          (set! rsi 296)
          (set! rdi *.74)
          (set! r15 L.rp.50)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.154 rax)
      (return-point L.rp.51
        (begin
          (set! rdx tmp.154)
          (set! rsi tmp.153)
          (set! rdi *.74)
          (set! r15 L.rp.51)
          (jump L.*.74.7 rbp r15 rdi rsi rdx)))
      (set! tmp.152 rax)
      (return-point L.rp.52
        (begin
          (set! rdx tmp.152)
          (set! rsi tmp.149)
          (set! rdi |+.73|)
          (set! r15 L.rp.52)
          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
      (set! tmp.148 rax)
      (return-point L.rp.53
        (begin
          (set! rdx tmp.148)
          (set! rsi tmp.141)
          (set! rdi |+.73|)
          (set! r15 L.rp.53)
          (jump L.+.73.8 rbp r15 rdi rsi rdx)))
      (set! fixnum5.14 rax)
      (set! rdi fun/void14592.9)
      (set! r15 tmp-ra.168)
      (jump L.fun/void14592.9.15 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () ()))
     (locals
      (boolean5.16
       tmp.182
       void4.17
       fixnum3.18
       tmp.175
       tmp.179
       tmp.181
       tmp.180
       tmp.176
       tmp.178
       tmp.177
       tmp.168
       tmp.172
       tmp.174
       tmp.173
       tmp.169
       tmp.171
       tmp.170
       empty2.19
       vector1.20
       ascii-char0.21
       fun/ascii-char15136.15
       tmp.121
       tmp.244
       tmp.167
       fun/void15141.14
       tmp.120
       tmp.243
       tmp.166
       fun/empty15139.13
       tmp.119
       tmp.242
       tmp.165
       fun/void15146.12
       tmp.118
       tmp.241
       tmp.164
       fun/vector15137.11
       tmp.117
       tmp.240
       tmp.163
       fun/any15143.10
       tmp.116
       tmp.239
       tmp.162
       fun/any15144.9
       tmp.115
       tmp.238
       tmp.161
       fun/void15142.8
       tmp.114
       tmp.237
       tmp.160
       fun/ascii-char15135.7
       tmp.113
       tmp.236
       tmp.159
       fun/vector15138.6
       tmp.112
       tmp.235
       tmp.158
       fun/void15145.5
       tmp.111
       tmp.234
       tmp.157
       fun/empty15140.4
       tmp.110
       tmp.233
       tmp.156
       make-vector.74
       tmp.109
       tmp.232
       tmp.155
       make-init-vector.1
       tmp.108
       tmp.231
       tmp.154
       vector-init-loop.24
       tmp.107
       tmp.230
       tmp.153
       cons.75
       tmp.106
       tmp.229
       tmp.152
       |-.76|
       tmp.105
       tmp.228
       tmp.151
       |+.77|
       tmp.104
       tmp.227
       tmp.150
       *.78
       tmp.103
       tmp.226
       tmp.149
       empty?.79
       tmp.102
       tmp.225
       tmp.148
       tmp-ra.203)))
    (define L.fun/ascii-char15136.15.26
      ((new-frames ()) (locals (c.99 tmp-ra.183)))
      (begin
        (set! tmp-ra.183 r15)
        (set! c.99 rdi)
        (set! rax 20014)
        (jump tmp-ra.183 rbp rax)))
    (define L.fun/void15141.14.25
      ((new-frames ()) (locals (fun/void15142.8 c.98 tmp-ra.184)))
      (begin
        (set! tmp-ra.184 r15)
        (set! c.98 rdi)
        (set! fun/void15142.8 (mref c.98 14))
        (set! rdi fun/void15142.8)
        (set! r15 tmp-ra.184)
        (jump L.fun/void15142.8.19 rbp r15 rdi)))
    (define L.fun/empty15139.13.24
      ((new-frames ()) (locals (fun/empty15140.4 c.97 tmp-ra.185)))
      (begin
        (set! tmp-ra.185 r15)
        (set! c.97 rdi)
        (set! fun/empty15140.4 (mref c.97 14))
        (set! rdi fun/empty15140.4)
        (set! r15 tmp-ra.185)
        (jump L.fun/empty15140.4.15 rbp r15 rdi)))
    (define L.fun/void15146.12.23
      ((new-frames ()) (locals (c.96 tmp-ra.186)))
      (begin
        (set! tmp-ra.186 r15)
        (set! c.96 rdi)
        (set! rax 30)
        (jump tmp-ra.186 rbp rax)))
    (define L.fun/vector15137.11.22
      ((new-frames ()) (locals (fun/vector15138.6 c.95 tmp-ra.187)))
      (begin
        (set! tmp-ra.187 r15)
        (set! c.95 rdi)
        (set! fun/vector15138.6 (mref c.95 14))
        (set! rdi fun/vector15138.6)
        (set! r15 tmp-ra.187)
        (jump L.fun/vector15138.6.17 rbp r15 rdi)))
    (define L.fun/any15143.10.21
      ((new-frames ()) (locals (fun/any15144.9 c.94 tmp-ra.188)))
      (begin
        (set! tmp-ra.188 r15)
        (set! c.94 rdi)
        (set! fun/any15144.9 (mref c.94 14))
        (set! rdi fun/any15144.9)
        (set! r15 tmp-ra.188)
        (jump L.fun/any15144.9.20 rbp r15 rdi)))
    (define L.fun/any15144.9.20
      ((new-frames ()) (locals (cons.75 c.93 tmp-ra.189)))
      (begin
        (set! tmp-ra.189 r15)
        (set! c.93 rdi)
        (set! cons.75 (mref c.93 14))
        (set! rdx 3640)
        (set! rsi 720)
        (set! rdi cons.75)
        (set! r15 tmp-ra.189)
        (jump L.cons.75.11 rbp r15 rdi rsi rdx)))
    (define L.fun/void15142.8.19
      ((new-frames ()) (locals (c.92 tmp-ra.190)))
      (begin
        (set! tmp-ra.190 r15)
        (set! c.92 rdi)
        (set! rax 30)
        (jump tmp-ra.190 rbp rax)))
    (define L.fun/ascii-char15135.7.18
      ((new-frames ()) (locals (fun/ascii-char15136.15 c.91 tmp-ra.191)))
      (begin
        (set! tmp-ra.191 r15)
        (set! c.91 rdi)
        (set! fun/ascii-char15136.15 (mref c.91 14))
        (set! rdi fun/ascii-char15136.15)
        (set! r15 tmp-ra.191)
        (jump L.fun/ascii-char15136.15.26 rbp r15 rdi)))
    (define L.fun/vector15138.6.17
      ((new-frames ()) (locals (make-vector.74 c.90 tmp-ra.192)))
      (begin
        (set! tmp-ra.192 r15)
        (set! c.90 rdi)
        (set! make-vector.74 (mref c.90 14))
        (set! rsi 64)
        (set! rdi make-vector.74)
        (set! r15 tmp-ra.192)
        (jump L.make-vector.74.14 rbp r15 rdi rsi)))
    (define L.fun/void15145.5.16
      ((new-frames ()) (locals (fun/void15146.12 c.89 tmp-ra.193)))
      (begin
        (set! tmp-ra.193 r15)
        (set! c.89 rdi)
        (set! fun/void15146.12 (mref c.89 14))
        (set! rdi fun/void15146.12)
        (set! r15 tmp-ra.193)
        (jump L.fun/void15146.12.23 rbp r15 rdi)))
    (define L.fun/empty15140.4.15
      ((new-frames ()) (locals (c.88 tmp-ra.194)))
      (begin
        (set! tmp-ra.194 r15)
        (set! c.88 rdi)
        (set! rax 22)
        (jump tmp-ra.194 rbp rax)))
    (define L.make-vector.74.14
      ((new-frames ())
       (locals
        (c.87 make-init-vector.1 tmp-ra.195 tmp.123 tmp.50 tmp.204 tmp.122)))
      (begin
        (set! tmp-ra.195 r15)
        (set! c.87 rdi)
        (set! tmp.50 rsi)
        (set! make-init-vector.1 (mref c.87 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.204 tmp.50)
                      (set! tmp.204 (bitwise-and tmp.204 7))
                      (set! tmp.123 tmp.204))
                    (= tmp.123 0))
                (set! tmp.122 14)
                (set! tmp.122 6))
              (!= tmp.122 6))
          (begin
            (set! rsi tmp.50)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.195)
            (jump L.make-init-vector.1.13 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.195 rbp rax)))))
    (define L.make-init-vector.1.13
      ((new-frames ())
       (locals
        (tmp.23
         tmp.100
         tmp.208
         tmp.124
         tmp.125
         tmp.207
         tmp.126
         tmp.206
         tmp.127
         tmp.205
         vector-init-loop.24
         tmp.22
         c.86
         tmp-ra.196)))
      (begin
        (set! tmp-ra.196 r15)
        (set! c.86 rdi)
        (set! tmp.22 rsi)
        (set! vector-init-loop.24 (mref c.86 14))
        (set! tmp.205 tmp.22)
        (set! tmp.205 (arithmetic-shift-right tmp.205 3))
        (set! tmp.127 tmp.205)
        (set! tmp.206 1)
        (set! tmp.206 (+ tmp.206 tmp.127))
        (set! tmp.126 tmp.206)
        (set! tmp.207 tmp.126)
        (set! tmp.207 (* tmp.207 8))
        (set! tmp.125 tmp.207)
        (begin (set! tmp.124 r12) (set! r12 (+ r12 tmp.125)))
        (set! tmp.208 tmp.124)
        (set! tmp.208 (+ tmp.208 3))
        (set! tmp.100 tmp.208)
        (mset! tmp.100 -3 tmp.22)
        (set! tmp.23 tmp.100)
        (set! rcx tmp.23)
        (set! rdx 0)
        (set! rsi tmp.22)
        (set! rdi vector-init-loop.24)
        (set! r15 tmp-ra.196)
        (jump L.vector-init-loop.24.12 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.24.12
      ((new-frames ())
       (locals
        (c.85
         tmp.209
         tmp.131
         tmp.210
         tmp.130
         tmp.211
         tmp.129
         tmp.212
         tmp.132
         vector-init-loop.24
         tmp-ra.197
         vec.26
         len.25
         i.27
         tmp.128)))
      (begin
        (set! tmp-ra.197 r15)
        (set! c.85 rdi)
        (set! len.25 rsi)
        (set! i.27 rdx)
        (set! vec.26 rcx)
        (set! vector-init-loop.24 (mref c.85 14))
        (if (begin
              (if (= len.25 i.27) (set! tmp.128 14) (set! tmp.128 6))
              (!= tmp.128 6))
          (begin (set! rax vec.26) (jump tmp-ra.197 rbp rax))
          (begin
            (set! tmp.209 i.27)
            (set! tmp.209 (arithmetic-shift-right tmp.209 3))
            (set! tmp.131 tmp.209)
            (set! tmp.210 tmp.131)
            (set! tmp.210 (* tmp.210 8))
            (set! tmp.130 tmp.210)
            (set! tmp.211 tmp.130)
            (set! tmp.211 (+ tmp.211 5))
            (set! tmp.129 tmp.211)
            (mset! vec.26 tmp.129 0)
            (set! tmp.212 i.27)
            (set! tmp.212 (+ tmp.212 8))
            (set! tmp.132 tmp.212)
            (set! rcx vec.26)
            (set! rdx tmp.132)
            (set! rsi len.25)
            (set! rdi vector-init-loop.24)
            (set! r15 tmp-ra.197)
            (jump L.vector-init-loop.24.12 rbp r15 rdi rsi rdx rcx)))))
    (define L.cons.75.11
      ((new-frames ())
       (locals (tmp.101 tmp.213 tmp.133 tmp.70 tmp.69 c.84 tmp-ra.198)))
      (begin
        (set! tmp-ra.198 r15)
        (set! c.84 rdi)
        (set! tmp.69 rsi)
        (set! tmp.70 rdx)
        (begin (set! tmp.133 r12) (set! r12 (+ r12 16)))
        (set! tmp.213 tmp.133)
        (set! tmp.213 (+ tmp.213 1))
        (set! tmp.101 tmp.213)
        (mset! tmp.101 -1 tmp.69)
        (mset! tmp.101 7 tmp.70)
        (set! rax tmp.101)
        (jump tmp-ra.198 rbp rax)))
    (define L.-.76.10
      ((new-frames ())
       (locals
        (c.83
         tmp.136
         tmp.215
         tmp.40
         tmp.137
         tmp.216
         tmp-ra.199
         tmp.135
         tmp.41
         tmp.214
         tmp.134)))
      (begin
        (set! tmp-ra.199 r15)
        (set! c.83 rdi)
        (set! tmp.40 rsi)
        (set! tmp.41 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.214 tmp.41)
                      (set! tmp.214 (bitwise-and tmp.214 7))
                      (set! tmp.135 tmp.214))
                    (= tmp.135 0))
                (set! tmp.134 14)
                (set! tmp.134 6))
              (!= tmp.134 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.215 tmp.40)
                        (set! tmp.215 (bitwise-and tmp.215 7))
                        (set! tmp.137 tmp.215))
                      (= tmp.137 0))
                  (set! tmp.136 14)
                  (set! tmp.136 6))
                (!= tmp.136 6))
            (begin
              (set! tmp.216 tmp.40)
              (set! tmp.216 (- tmp.216 tmp.41))
              (set! rax tmp.216)
              (jump tmp-ra.199 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.199 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.199 rbp rax)))))
    (define L.+.77.9
      ((new-frames ())
       (locals
        (c.82
         tmp.140
         tmp.218
         tmp.38
         tmp.141
         tmp.219
         tmp-ra.200
         tmp.139
         tmp.39
         tmp.217
         tmp.138)))
      (begin
        (set! tmp-ra.200 r15)
        (set! c.82 rdi)
        (set! tmp.38 rsi)
        (set! tmp.39 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.217 tmp.39)
                      (set! tmp.217 (bitwise-and tmp.217 7))
                      (set! tmp.139 tmp.217))
                    (= tmp.139 0))
                (set! tmp.138 14)
                (set! tmp.138 6))
              (!= tmp.138 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.218 tmp.38)
                        (set! tmp.218 (bitwise-and tmp.218 7))
                        (set! tmp.141 tmp.218))
                      (= tmp.141 0))
                  (set! tmp.140 14)
                  (set! tmp.140 6))
                (!= tmp.140 6))
            (begin
              (set! tmp.219 tmp.38)
              (set! tmp.219 (+ tmp.219 tmp.39))
              (set! rax tmp.219)
              (jump tmp-ra.200 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.200 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.200 rbp rax)))))
    (define L.*.78.8
      ((new-frames ())
       (locals
        (c.81
         tmp.144
         tmp.221
         tmp.36
         tmp.145
         tmp.223
         tmp.146
         tmp.222
         tmp-ra.201
         tmp.143
         tmp.37
         tmp.220
         tmp.142)))
      (begin
        (set! tmp-ra.201 r15)
        (set! c.81 rdi)
        (set! tmp.36 rsi)
        (set! tmp.37 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.220 tmp.37)
                      (set! tmp.220 (bitwise-and tmp.220 7))
                      (set! tmp.143 tmp.220))
                    (= tmp.143 0))
                (set! tmp.142 14)
                (set! tmp.142 6))
              (!= tmp.142 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.221 tmp.36)
                        (set! tmp.221 (bitwise-and tmp.221 7))
                        (set! tmp.145 tmp.221))
                      (= tmp.145 0))
                  (set! tmp.144 14)
                  (set! tmp.144 6))
                (!= tmp.144 6))
            (begin
              (set! tmp.222 tmp.37)
              (set! tmp.222 (arithmetic-shift-right tmp.222 3))
              (set! tmp.146 tmp.222)
              (set! tmp.223 tmp.36)
              (set! tmp.223 (* tmp.223 tmp.146))
              (set! rax tmp.223)
              (jump tmp-ra.201 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.201 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.201 rbp rax)))))
    (define L.empty?.79.7
      ((new-frames ()) (locals (c.80 tmp-ra.202 tmp.224 tmp.61 tmp.147)))
      (begin
        (set! tmp-ra.202 r15)
        (set! c.80 rdi)
        (set! tmp.61 rsi)
        (if (begin
              (begin
                (set! tmp.224 tmp.61)
                (set! tmp.224 (bitwise-and tmp.224 255))
                (set! tmp.147 tmp.224))
              (= tmp.147 22))
          (begin (set! rax 14) (jump tmp-ra.202 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.202 rbp rax)))))
    (begin
      (set! tmp-ra.203 r15)
      (begin (set! tmp.148 r12) (set! r12 (+ r12 16)))
      (set! tmp.225 tmp.148)
      (set! tmp.225 (+ tmp.225 2))
      (set! tmp.102 tmp.225)
      (mset! tmp.102 -2 L.empty?.79.7)
      (mset! tmp.102 6 8)
      (set! empty?.79 tmp.102)
      (begin (set! tmp.149 r12) (set! r12 (+ r12 16)))
      (set! tmp.226 tmp.149)
      (set! tmp.226 (+ tmp.226 2))
      (set! tmp.103 tmp.226)
      (mset! tmp.103 -2 L.*.78.8)
      (mset! tmp.103 6 16)
      (set! *.78 tmp.103)
      (begin (set! tmp.150 r12) (set! r12 (+ r12 16)))
      (set! tmp.227 tmp.150)
      (set! tmp.227 (+ tmp.227 2))
      (set! tmp.104 tmp.227)
      (mset! tmp.104 -2 L.+.77.9)
      (mset! tmp.104 6 16)
      (set! |+.77| tmp.104)
      (begin (set! tmp.151 r12) (set! r12 (+ r12 16)))
      (set! tmp.228 tmp.151)
      (set! tmp.228 (+ tmp.228 2))
      (set! tmp.105 tmp.228)
      (mset! tmp.105 -2 L.-.76.10)
      (mset! tmp.105 6 16)
      (set! |-.76| tmp.105)
      (begin (set! tmp.152 r12) (set! r12 (+ r12 16)))
      (set! tmp.229 tmp.152)
      (set! tmp.229 (+ tmp.229 2))
      (set! tmp.106 tmp.229)
      (mset! tmp.106 -2 L.cons.75.11)
      (mset! tmp.106 6 16)
      (set! cons.75 tmp.106)
      (begin (set! tmp.153 r12) (set! r12 (+ r12 24)))
      (set! tmp.230 tmp.153)
      (set! tmp.230 (+ tmp.230 2))
      (set! tmp.107 tmp.230)
      (mset! tmp.107 -2 L.vector-init-loop.24.12)
      (mset! tmp.107 6 24)
      (set! vector-init-loop.24 tmp.107)
      (begin (set! tmp.154 r12) (set! r12 (+ r12 24)))
      (set! tmp.231 tmp.154)
      (set! tmp.231 (+ tmp.231 2))
      (set! tmp.108 tmp.231)
      (mset! tmp.108 -2 L.make-init-vector.1.13)
      (mset! tmp.108 6 8)
      (set! make-init-vector.1 tmp.108)
      (begin (set! tmp.155 r12) (set! r12 (+ r12 24)))
      (set! tmp.232 tmp.155)
      (set! tmp.232 (+ tmp.232 2))
      (set! tmp.109 tmp.232)
      (mset! tmp.109 -2 L.make-vector.74.14)
      (mset! tmp.109 6 8)
      (set! make-vector.74 tmp.109)
      (begin (set! tmp.156 r12) (set! r12 (+ r12 16)))
      (set! tmp.233 tmp.156)
      (set! tmp.233 (+ tmp.233 2))
      (set! tmp.110 tmp.233)
      (mset! tmp.110 -2 L.fun/empty15140.4.15)
      (mset! tmp.110 6 0)
      (set! fun/empty15140.4 tmp.110)
      (begin (set! tmp.157 r12) (set! r12 (+ r12 24)))
      (set! tmp.234 tmp.157)
      (set! tmp.234 (+ tmp.234 2))
      (set! tmp.111 tmp.234)
      (mset! tmp.111 -2 L.fun/void15145.5.16)
      (mset! tmp.111 6 0)
      (set! fun/void15145.5 tmp.111)
      (begin (set! tmp.158 r12) (set! r12 (+ r12 24)))
      (set! tmp.235 tmp.158)
      (set! tmp.235 (+ tmp.235 2))
      (set! tmp.112 tmp.235)
      (mset! tmp.112 -2 L.fun/vector15138.6.17)
      (mset! tmp.112 6 0)
      (set! fun/vector15138.6 tmp.112)
      (begin (set! tmp.159 r12) (set! r12 (+ r12 24)))
      (set! tmp.236 tmp.159)
      (set! tmp.236 (+ tmp.236 2))
      (set! tmp.113 tmp.236)
      (mset! tmp.113 -2 L.fun/ascii-char15135.7.18)
      (mset! tmp.113 6 0)
      (set! fun/ascii-char15135.7 tmp.113)
      (begin (set! tmp.160 r12) (set! r12 (+ r12 16)))
      (set! tmp.237 tmp.160)
      (set! tmp.237 (+ tmp.237 2))
      (set! tmp.114 tmp.237)
      (mset! tmp.114 -2 L.fun/void15142.8.19)
      (mset! tmp.114 6 0)
      (set! fun/void15142.8 tmp.114)
      (begin (set! tmp.161 r12) (set! r12 (+ r12 24)))
      (set! tmp.238 tmp.161)
      (set! tmp.238 (+ tmp.238 2))
      (set! tmp.115 tmp.238)
      (mset! tmp.115 -2 L.fun/any15144.9.20)
      (mset! tmp.115 6 0)
      (set! fun/any15144.9 tmp.115)
      (begin (set! tmp.162 r12) (set! r12 (+ r12 24)))
      (set! tmp.239 tmp.162)
      (set! tmp.239 (+ tmp.239 2))
      (set! tmp.116 tmp.239)
      (mset! tmp.116 -2 L.fun/any15143.10.21)
      (mset! tmp.116 6 0)
      (set! fun/any15143.10 tmp.116)
      (begin (set! tmp.163 r12) (set! r12 (+ r12 24)))
      (set! tmp.240 tmp.163)
      (set! tmp.240 (+ tmp.240 2))
      (set! tmp.117 tmp.240)
      (mset! tmp.117 -2 L.fun/vector15137.11.22)
      (mset! tmp.117 6 0)
      (set! fun/vector15137.11 tmp.117)
      (begin (set! tmp.164 r12) (set! r12 (+ r12 16)))
      (set! tmp.241 tmp.164)
      (set! tmp.241 (+ tmp.241 2))
      (set! tmp.118 tmp.241)
      (mset! tmp.118 -2 L.fun/void15146.12.23)
      (mset! tmp.118 6 0)
      (set! fun/void15146.12 tmp.118)
      (begin (set! tmp.165 r12) (set! r12 (+ r12 24)))
      (set! tmp.242 tmp.165)
      (set! tmp.242 (+ tmp.242 2))
      (set! tmp.119 tmp.242)
      (mset! tmp.119 -2 L.fun/empty15139.13.24)
      (mset! tmp.119 6 0)
      (set! fun/empty15139.13 tmp.119)
      (begin (set! tmp.166 r12) (set! r12 (+ r12 24)))
      (set! tmp.243 tmp.166)
      (set! tmp.243 (+ tmp.243 2))
      (set! tmp.120 tmp.243)
      (mset! tmp.120 -2 L.fun/void15141.14.25)
      (mset! tmp.120 6 0)
      (set! fun/void15141.14 tmp.120)
      (begin (set! tmp.167 r12) (set! r12 (+ r12 16)))
      (set! tmp.244 tmp.167)
      (set! tmp.244 (+ tmp.244 2))
      (set! tmp.121 tmp.244)
      (mset! tmp.121 -2 L.fun/ascii-char15136.15.26)
      (mset! tmp.121 6 0)
      (set! fun/ascii-char15136.15 tmp.121)
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
      (return-point L.rp.27
        (begin
          (set! rdi fun/ascii-char15135.7)
          (set! r15 L.rp.27)
          (jump L.fun/ascii-char15135.7.18 rbp r15 rdi)))
      (set! ascii-char0.21 rax)
      (return-point L.rp.28
        (begin
          (set! rdi fun/vector15137.11)
          (set! r15 L.rp.28)
          (jump L.fun/vector15137.11.22 rbp r15 rdi)))
      (set! vector1.20 rax)
      (return-point L.rp.29
        (begin
          (set! rdi fun/empty15139.13)
          (set! r15 L.rp.29)
          (jump L.fun/empty15139.13.24 rbp r15 rdi)))
      (set! empty2.19 rax)
      (return-point L.rp.30
        (begin
          (set! rdx 192)
          (set! rsi 1376)
          (set! rdi |-.76|)
          (set! r15 L.rp.30)
          (jump L.-.76.10 rbp r15 rdi rsi rdx)))
      (set! tmp.170 rax)
      (return-point L.rp.31
        (begin
          (set! rdx 1608)
          (set! rsi 1984)
          (set! rdi |-.76|)
          (set! r15 L.rp.31)
          (jump L.-.76.10 rbp r15 rdi rsi rdx)))
      (set! tmp.171 rax)
      (return-point L.rp.32
        (begin
          (set! rdx tmp.171)
          (set! rsi tmp.170)
          (set! rdi |+.77|)
          (set! r15 L.rp.32)
          (jump L.+.77.9 rbp r15 rdi rsi rdx)))
      (set! tmp.169 rax)
      (return-point L.rp.33
        (begin
          (set! rdx 1840)
          (set! rsi 296)
          (set! rdi |+.77|)
          (set! r15 L.rp.33)
          (jump L.+.77.9 rbp r15 rdi rsi rdx)))
      (set! tmp.173 rax)
      (return-point L.rp.34
        (begin
          (set! rdx 1720)
          (set! rsi 488)
          (set! rdi |-.76|)
          (set! r15 L.rp.34)
          (jump L.-.76.10 rbp r15 rdi rsi rdx)))
      (set! tmp.174 rax)
      (return-point L.rp.35
        (begin
          (set! rdx tmp.174)
          (set! rsi tmp.173)
          (set! rdi |+.77|)
          (set! r15 L.rp.35)
          (jump L.+.77.9 rbp r15 rdi rsi rdx)))
      (set! tmp.172 rax)
      (return-point L.rp.36
        (begin
          (set! rdx tmp.172)
          (set! rsi tmp.169)
          (set! rdi |-.76|)
          (set! r15 L.rp.36)
          (jump L.-.76.10 rbp r15 rdi rsi rdx)))
      (set! tmp.168 rax)
      (return-point L.rp.37
        (begin
          (set! rdx 776)
          (set! rsi 1368)
          (set! rdi *.78)
          (set! r15 L.rp.37)
          (jump L.*.78.8 rbp r15 rdi rsi rdx)))
      (set! tmp.177 rax)
      (return-point L.rp.38
        (begin
          (set! rdx 64)
          (set! rsi 864)
          (set! rdi |-.76|)
          (set! r15 L.rp.38)
          (jump L.-.76.10 rbp r15 rdi rsi rdx)))
      (set! tmp.178 rax)
      (return-point L.rp.39
        (begin
          (set! rdx tmp.178)
          (set! rsi tmp.177)
          (set! rdi |+.77|)
          (set! r15 L.rp.39)
          (jump L.+.77.9 rbp r15 rdi rsi rdx)))
      (set! tmp.176 rax)
      (return-point L.rp.40
        (begin
          (set! rdx 584)
          (set! rsi 392)
          (set! rdi |-.76|)
          (set! r15 L.rp.40)
          (jump L.-.76.10 rbp r15 rdi rsi rdx)))
      (set! tmp.180 rax)
      (return-point L.rp.41
        (begin
          (set! rdx 1872)
          (set! rsi 1440)
          (set! rdi |+.77|)
          (set! r15 L.rp.41)
          (jump L.+.77.9 rbp r15 rdi rsi rdx)))
      (set! tmp.181 rax)
      (return-point L.rp.42
        (begin
          (set! rdx tmp.181)
          (set! rsi tmp.180)
          (set! rdi |-.76|)
          (set! r15 L.rp.42)
          (jump L.-.76.10 rbp r15 rdi rsi rdx)))
      (set! tmp.179 rax)
      (return-point L.rp.43
        (begin
          (set! rdx tmp.179)
          (set! rsi tmp.176)
          (set! rdi |-.76|)
          (set! r15 L.rp.43)
          (jump L.-.76.10 rbp r15 rdi rsi rdx)))
      (set! tmp.175 rax)
      (return-point L.rp.44
        (begin
          (set! rdx tmp.175)
          (set! rsi tmp.168)
          (set! rdi |+.77|)
          (set! r15 L.rp.44)
          (jump L.+.77.9 rbp r15 rdi rsi rdx)))
      (set! fixnum3.18 rax)
      (return-point L.rp.45
        (begin
          (set! rdi fun/void15141.14)
          (set! r15 L.rp.45)
          (jump L.fun/void15141.14.25 rbp r15 rdi)))
      (set! void4.17 rax)
      (return-point L.rp.46
        (begin
          (set! rdi fun/any15143.10)
          (set! r15 L.rp.46)
          (jump L.fun/any15143.10.21 rbp r15 rdi)))
      (set! tmp.182 rax)
      (return-point L.rp.47
        (begin
          (set! rsi tmp.182)
          (set! rdi empty?.79)
          (set! r15 L.rp.47)
          (jump L.empty?.79.7 rbp r15 rdi rsi)))
      (set! boolean5.16 rax)
      (set! rdi fun/void15145.5)
      (set! r15 tmp-ra.203)
      (jump L.fun/void15145.5.16 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() () () () ()))
     (locals
      (void5.18
       error4.19
       vector3.20
       ascii-char2.21
       empty1.22
       procedure0.23
       lam.77
       tmp.114
       tmp.189
       tmp.143
       fun/ascii-char15768.17
       tmp.113
       tmp.188
       tmp.142
       fun/ascii-char15777.16
       tmp.112
       tmp.187
       tmp.141
       fun/void15775.15
       tmp.111
       tmp.186
       tmp.140
       fun/empty15764.14
       tmp.110
       tmp.185
       tmp.139
       fun/empty15766.13
       tmp.109
       tmp.184
       tmp.138
       fun/ascii-char15776.12
       tmp.108
       tmp.183
       tmp.137
       fun/empty15767.11
       tmp.107
       tmp.182
       tmp.136
       fun/ascii-char15769.10
       tmp.106
       tmp.181
       tmp.135
       fun/vector15771.9
       tmp.105
       tmp.180
       tmp.134
       fun/error15772.8
       tmp.104
       tmp.179
       tmp.133
       fun/error15773.7
       tmp.103
       tmp.178
       tmp.132
       fun/void15774.6
       tmp.102
       tmp.177
       tmp.131
       fun/empty15765.5
       tmp.101
       tmp.176
       tmp.130
       fun/vector15770.4
       tmp.100
       tmp.175
       tmp.129
       make-vector.76
       tmp.99
       tmp.174
       tmp.128
       make-init-vector.1
       tmp.98
       tmp.173
       tmp.127
       vector-init-loop.26
       tmp.97
       tmp.172
       tmp.126
       tmp-ra.162)))
    (define L.lam.77.24
      ((new-frames ()) (locals (fun/empty15764.14 c.95 tmp-ra.144)))
      (begin
        (set! tmp-ra.144 r15)
        (set! c.95 rdi)
        (set! fun/empty15764.14 (mref c.95 14))
        (set! rdi fun/empty15764.14)
        (set! r15 tmp-ra.144)
        (jump L.fun/empty15764.14.20 rbp r15 rdi)))
    (define L.fun/ascii-char15768.17.23
      ((new-frames ()) (locals (fun/ascii-char15769.10 c.94 tmp-ra.145)))
      (begin
        (set! tmp-ra.145 r15)
        (set! c.94 rdi)
        (set! fun/ascii-char15769.10 (mref c.94 14))
        (set! rdi fun/ascii-char15769.10)
        (set! r15 tmp-ra.145)
        (jump L.fun/ascii-char15769.10.16 rbp r15 rdi)))
    (define L.fun/ascii-char15777.16.22
      ((new-frames ()) (locals (c.93 tmp-ra.146)))
      (begin
        (set! tmp-ra.146 r15)
        (set! c.93 rdi)
        (set! rax 19502)
        (jump tmp-ra.146 rbp rax)))
    (define L.fun/void15775.15.21
      ((new-frames ()) (locals (c.92 tmp-ra.147)))
      (begin
        (set! tmp-ra.147 r15)
        (set! c.92 rdi)
        (set! rax 30)
        (jump tmp-ra.147 rbp rax)))
    (define L.fun/empty15764.14.20
      ((new-frames ()) (locals (fun/empty15765.5 c.91 tmp-ra.148)))
      (begin
        (set! tmp-ra.148 r15)
        (set! c.91 rdi)
        (set! fun/empty15765.5 (mref c.91 14))
        (set! rdi fun/empty15765.5)
        (set! r15 tmp-ra.148)
        (jump L.fun/empty15765.5.11 rbp r15 rdi)))
    (define L.fun/empty15766.13.19
      ((new-frames ()) (locals (fun/empty15767.11 c.90 tmp-ra.149)))
      (begin
        (set! tmp-ra.149 r15)
        (set! c.90 rdi)
        (set! fun/empty15767.11 (mref c.90 14))
        (set! rdi fun/empty15767.11)
        (set! r15 tmp-ra.149)
        (jump L.fun/empty15767.11.17 rbp r15 rdi)))
    (define L.fun/ascii-char15776.12.18
      ((new-frames ()) (locals (fun/ascii-char15777.16 c.89 tmp-ra.150)))
      (begin
        (set! tmp-ra.150 r15)
        (set! c.89 rdi)
        (set! fun/ascii-char15777.16 (mref c.89 14))
        (set! rdi fun/ascii-char15777.16)
        (set! r15 tmp-ra.150)
        (jump L.fun/ascii-char15777.16.22 rbp r15 rdi)))
    (define L.fun/empty15767.11.17
      ((new-frames ()) (locals (c.88 tmp-ra.151)))
      (begin
        (set! tmp-ra.151 r15)
        (set! c.88 rdi)
        (set! rax 22)
        (jump tmp-ra.151 rbp rax)))
    (define L.fun/ascii-char15769.10.16
      ((new-frames ()) (locals (c.87 tmp-ra.152)))
      (begin
        (set! tmp-ra.152 r15)
        (set! c.87 rdi)
        (set! rax 24366)
        (jump tmp-ra.152 rbp rax)))
    (define L.fun/vector15771.9.15
      ((new-frames ()) (locals (make-vector.76 c.86 tmp-ra.153)))
      (begin
        (set! tmp-ra.153 r15)
        (set! c.86 rdi)
        (set! make-vector.76 (mref c.86 14))
        (set! rsi 64)
        (set! rdi make-vector.76)
        (set! r15 tmp-ra.153)
        (jump L.make-vector.76.9 rbp r15 rdi rsi)))
    (define L.fun/error15772.8.14
      ((new-frames ()) (locals (fun/error15773.7 c.85 tmp-ra.154)))
      (begin
        (set! tmp-ra.154 r15)
        (set! c.85 rdi)
        (set! fun/error15773.7 (mref c.85 14))
        (set! rdi fun/error15773.7)
        (set! r15 tmp-ra.154)
        (jump L.fun/error15773.7.13 rbp r15 rdi)))
    (define L.fun/error15773.7.13
      ((new-frames ()) (locals (c.84 tmp-ra.155)))
      (begin
        (set! tmp-ra.155 r15)
        (set! c.84 rdi)
        (set! rax 4414)
        (jump tmp-ra.155 rbp rax)))
    (define L.fun/void15774.6.12
      ((new-frames ()) (locals (fun/void15775.15 c.83 tmp-ra.156)))
      (begin
        (set! tmp-ra.156 r15)
        (set! c.83 rdi)
        (set! fun/void15775.15 (mref c.83 14))
        (set! rdi fun/void15775.15)
        (set! r15 tmp-ra.156)
        (jump L.fun/void15775.15.21 rbp r15 rdi)))
    (define L.fun/empty15765.5.11
      ((new-frames ()) (locals (c.82 tmp-ra.157)))
      (begin
        (set! tmp-ra.157 r15)
        (set! c.82 rdi)
        (set! rax 22)
        (jump tmp-ra.157 rbp rax)))
    (define L.fun/vector15770.4.10
      ((new-frames ()) (locals (fun/vector15771.9 c.81 tmp-ra.158)))
      (begin
        (set! tmp-ra.158 r15)
        (set! c.81 rdi)
        (set! fun/vector15771.9 (mref c.81 14))
        (set! rdi fun/vector15771.9)
        (set! r15 tmp-ra.158)
        (jump L.fun/vector15771.9.15 rbp r15 rdi)))
    (define L.make-vector.76.9
      ((new-frames ())
       (locals
        (c.80 make-init-vector.1 tmp-ra.159 tmp.116 tmp.52 tmp.163 tmp.115)))
      (begin
        (set! tmp-ra.159 r15)
        (set! c.80 rdi)
        (set! tmp.52 rsi)
        (set! make-init-vector.1 (mref c.80 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.163 tmp.52)
                      (set! tmp.163 (bitwise-and tmp.163 7))
                      (set! tmp.116 tmp.163))
                    (= tmp.116 0))
                (set! tmp.115 14)
                (set! tmp.115 6))
              (!= tmp.115 6))
          (begin
            (set! rsi tmp.52)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.159)
            (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.159 rbp rax)))))
    (define L.make-init-vector.1.8
      ((new-frames ())
       (locals
        (tmp.25
         tmp.96
         tmp.167
         tmp.117
         tmp.118
         tmp.166
         tmp.119
         tmp.165
         tmp.120
         tmp.164
         vector-init-loop.26
         tmp.24
         c.79
         tmp-ra.160)))
      (begin
        (set! tmp-ra.160 r15)
        (set! c.79 rdi)
        (set! tmp.24 rsi)
        (set! vector-init-loop.26 (mref c.79 14))
        (set! tmp.164 tmp.24)
        (set! tmp.164 (arithmetic-shift-right tmp.164 3))
        (set! tmp.120 tmp.164)
        (set! tmp.165 1)
        (set! tmp.165 (+ tmp.165 tmp.120))
        (set! tmp.119 tmp.165)
        (set! tmp.166 tmp.119)
        (set! tmp.166 (* tmp.166 8))
        (set! tmp.118 tmp.166)
        (begin (set! tmp.117 r12) (set! r12 (+ r12 tmp.118)))
        (set! tmp.167 tmp.117)
        (set! tmp.167 (+ tmp.167 3))
        (set! tmp.96 tmp.167)
        (mset! tmp.96 -3 tmp.24)
        (set! tmp.25 tmp.96)
        (set! rcx tmp.25)
        (set! rdx 0)
        (set! rsi tmp.24)
        (set! rdi vector-init-loop.26)
        (set! r15 tmp-ra.160)
        (jump L.vector-init-loop.26.7 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.26.7
      ((new-frames ())
       (locals
        (c.78
         tmp.168
         tmp.124
         tmp.169
         tmp.123
         tmp.170
         tmp.122
         tmp.171
         tmp.125
         vector-init-loop.26
         tmp-ra.161
         vec.28
         len.27
         i.29
         tmp.121)))
      (begin
        (set! tmp-ra.161 r15)
        (set! c.78 rdi)
        (set! len.27 rsi)
        (set! i.29 rdx)
        (set! vec.28 rcx)
        (set! vector-init-loop.26 (mref c.78 14))
        (if (begin
              (if (= len.27 i.29) (set! tmp.121 14) (set! tmp.121 6))
              (!= tmp.121 6))
          (begin (set! rax vec.28) (jump tmp-ra.161 rbp rax))
          (begin
            (set! tmp.168 i.29)
            (set! tmp.168 (arithmetic-shift-right tmp.168 3))
            (set! tmp.124 tmp.168)
            (set! tmp.169 tmp.124)
            (set! tmp.169 (* tmp.169 8))
            (set! tmp.123 tmp.169)
            (set! tmp.170 tmp.123)
            (set! tmp.170 (+ tmp.170 5))
            (set! tmp.122 tmp.170)
            (mset! vec.28 tmp.122 0)
            (set! tmp.171 i.29)
            (set! tmp.171 (+ tmp.171 8))
            (set! tmp.125 tmp.171)
            (set! rcx vec.28)
            (set! rdx tmp.125)
            (set! rsi len.27)
            (set! rdi vector-init-loop.26)
            (set! r15 tmp-ra.161)
            (jump L.vector-init-loop.26.7 rbp r15 rdi rsi rdx rcx)))))
    (begin
      (set! tmp-ra.162 r15)
      (begin (set! tmp.126 r12) (set! r12 (+ r12 24)))
      (set! tmp.172 tmp.126)
      (set! tmp.172 (+ tmp.172 2))
      (set! tmp.97 tmp.172)
      (mset! tmp.97 -2 L.vector-init-loop.26.7)
      (mset! tmp.97 6 24)
      (set! vector-init-loop.26 tmp.97)
      (begin (set! tmp.127 r12) (set! r12 (+ r12 24)))
      (set! tmp.173 tmp.127)
      (set! tmp.173 (+ tmp.173 2))
      (set! tmp.98 tmp.173)
      (mset! tmp.98 -2 L.make-init-vector.1.8)
      (mset! tmp.98 6 8)
      (set! make-init-vector.1 tmp.98)
      (begin (set! tmp.128 r12) (set! r12 (+ r12 24)))
      (set! tmp.174 tmp.128)
      (set! tmp.174 (+ tmp.174 2))
      (set! tmp.99 tmp.174)
      (mset! tmp.99 -2 L.make-vector.76.9)
      (mset! tmp.99 6 8)
      (set! make-vector.76 tmp.99)
      (begin (set! tmp.129 r12) (set! r12 (+ r12 24)))
      (set! tmp.175 tmp.129)
      (set! tmp.175 (+ tmp.175 2))
      (set! tmp.100 tmp.175)
      (mset! tmp.100 -2 L.fun/vector15770.4.10)
      (mset! tmp.100 6 0)
      (set! fun/vector15770.4 tmp.100)
      (begin (set! tmp.130 r12) (set! r12 (+ r12 16)))
      (set! tmp.176 tmp.130)
      (set! tmp.176 (+ tmp.176 2))
      (set! tmp.101 tmp.176)
      (mset! tmp.101 -2 L.fun/empty15765.5.11)
      (mset! tmp.101 6 0)
      (set! fun/empty15765.5 tmp.101)
      (begin (set! tmp.131 r12) (set! r12 (+ r12 24)))
      (set! tmp.177 tmp.131)
      (set! tmp.177 (+ tmp.177 2))
      (set! tmp.102 tmp.177)
      (mset! tmp.102 -2 L.fun/void15774.6.12)
      (mset! tmp.102 6 0)
      (set! fun/void15774.6 tmp.102)
      (begin (set! tmp.132 r12) (set! r12 (+ r12 16)))
      (set! tmp.178 tmp.132)
      (set! tmp.178 (+ tmp.178 2))
      (set! tmp.103 tmp.178)
      (mset! tmp.103 -2 L.fun/error15773.7.13)
      (mset! tmp.103 6 0)
      (set! fun/error15773.7 tmp.103)
      (begin (set! tmp.133 r12) (set! r12 (+ r12 24)))
      (set! tmp.179 tmp.133)
      (set! tmp.179 (+ tmp.179 2))
      (set! tmp.104 tmp.179)
      (mset! tmp.104 -2 L.fun/error15772.8.14)
      (mset! tmp.104 6 0)
      (set! fun/error15772.8 tmp.104)
      (begin (set! tmp.134 r12) (set! r12 (+ r12 24)))
      (set! tmp.180 tmp.134)
      (set! tmp.180 (+ tmp.180 2))
      (set! tmp.105 tmp.180)
      (mset! tmp.105 -2 L.fun/vector15771.9.15)
      (mset! tmp.105 6 0)
      (set! fun/vector15771.9 tmp.105)
      (begin (set! tmp.135 r12) (set! r12 (+ r12 16)))
      (set! tmp.181 tmp.135)
      (set! tmp.181 (+ tmp.181 2))
      (set! tmp.106 tmp.181)
      (mset! tmp.106 -2 L.fun/ascii-char15769.10.16)
      (mset! tmp.106 6 0)
      (set! fun/ascii-char15769.10 tmp.106)
      (begin (set! tmp.136 r12) (set! r12 (+ r12 16)))
      (set! tmp.182 tmp.136)
      (set! tmp.182 (+ tmp.182 2))
      (set! tmp.107 tmp.182)
      (mset! tmp.107 -2 L.fun/empty15767.11.17)
      (mset! tmp.107 6 0)
      (set! fun/empty15767.11 tmp.107)
      (begin (set! tmp.137 r12) (set! r12 (+ r12 24)))
      (set! tmp.183 tmp.137)
      (set! tmp.183 (+ tmp.183 2))
      (set! tmp.108 tmp.183)
      (mset! tmp.108 -2 L.fun/ascii-char15776.12.18)
      (mset! tmp.108 6 0)
      (set! fun/ascii-char15776.12 tmp.108)
      (begin (set! tmp.138 r12) (set! r12 (+ r12 24)))
      (set! tmp.184 tmp.138)
      (set! tmp.184 (+ tmp.184 2))
      (set! tmp.109 tmp.184)
      (mset! tmp.109 -2 L.fun/empty15766.13.19)
      (mset! tmp.109 6 0)
      (set! fun/empty15766.13 tmp.109)
      (begin (set! tmp.139 r12) (set! r12 (+ r12 24)))
      (set! tmp.185 tmp.139)
      (set! tmp.185 (+ tmp.185 2))
      (set! tmp.110 tmp.185)
      (mset! tmp.110 -2 L.fun/empty15764.14.20)
      (mset! tmp.110 6 0)
      (set! fun/empty15764.14 tmp.110)
      (begin (set! tmp.140 r12) (set! r12 (+ r12 16)))
      (set! tmp.186 tmp.140)
      (set! tmp.186 (+ tmp.186 2))
      (set! tmp.111 tmp.186)
      (mset! tmp.111 -2 L.fun/void15775.15.21)
      (mset! tmp.111 6 0)
      (set! fun/void15775.15 tmp.111)
      (begin (set! tmp.141 r12) (set! r12 (+ r12 16)))
      (set! tmp.187 tmp.141)
      (set! tmp.187 (+ tmp.187 2))
      (set! tmp.112 tmp.187)
      (mset! tmp.112 -2 L.fun/ascii-char15777.16.22)
      (mset! tmp.112 6 0)
      (set! fun/ascii-char15777.16 tmp.112)
      (begin (set! tmp.142 r12) (set! r12 (+ r12 24)))
      (set! tmp.188 tmp.142)
      (set! tmp.188 (+ tmp.188 2))
      (set! tmp.113 tmp.188)
      (mset! tmp.113 -2 L.fun/ascii-char15768.17.23)
      (mset! tmp.113 6 0)
      (set! fun/ascii-char15768.17 tmp.113)
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
      (begin (set! tmp.143 r12) (set! r12 (+ r12 24)))
      (set! tmp.189 tmp.143)
      (set! tmp.189 (+ tmp.189 2))
      (set! tmp.114 tmp.189)
      (mset! tmp.114 -2 L.lam.77.24)
      (mset! tmp.114 6 0)
      (set! lam.77 tmp.114)
      (mset! lam.77 14 fun/empty15764.14)
      (set! procedure0.23 lam.77)
      (return-point L.rp.25
        (begin
          (set! rdi fun/empty15766.13)
          (set! r15 L.rp.25)
          (jump L.fun/empty15766.13.19 rbp r15 rdi)))
      (set! empty1.22 rax)
      (return-point L.rp.26
        (begin
          (set! rdi fun/ascii-char15768.17)
          (set! r15 L.rp.26)
          (jump L.fun/ascii-char15768.17.23 rbp r15 rdi)))
      (set! ascii-char2.21 rax)
      (return-point L.rp.27
        (begin
          (set! rdi fun/vector15770.4)
          (set! r15 L.rp.27)
          (jump L.fun/vector15770.4.10 rbp r15 rdi)))
      (set! vector3.20 rax)
      (return-point L.rp.28
        (begin
          (set! rdi fun/error15772.8)
          (set! r15 L.rp.28)
          (jump L.fun/error15772.8.14 rbp r15 rdi)))
      (set! error4.19 rax)
      (return-point L.rp.29
        (begin
          (set! rdi fun/void15774.6)
          (set! r15 L.rp.29)
          (jump L.fun/void15774.6.12 rbp r15 rdi)))
      (set! void5.18 rax)
      (set! rdi fun/ascii-char15776.12)
      (set! r15 tmp-ra.162)
      (jump L.fun/ascii-char15776.12.18 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () () () ()))
     (locals
      (fixnum5.16
       tmp.174
       tmp.178
       tmp.180
       tmp.179
       tmp.175
       tmp.177
       tmp.176
       tmp.167
       tmp.171
       tmp.173
       tmp.172
       tmp.168
       tmp.170
       tmp.169
       ascii-char4.17
       procedure3.18
       lam.79
       tmp.121
       tmp.241
       tmp.166
       vector2.19
       void1.20
       error0.21
       fun/void21847.15
       tmp.120
       tmp.240
       tmp.165
       fun/ascii-char21853.14
       tmp.119
       tmp.239
       tmp.164
       fun/error21845.13
       tmp.118
       tmp.238
       tmp.163
       fun/pair21852.12
       tmp.117
       tmp.237
       tmp.162
       fun/vector21855.11
       tmp.116
       tmp.236
       tmp.161
       fun/error21846.10
       tmp.115
       tmp.235
       tmp.160
       fun/vector21850.9
       tmp.114
       tmp.234
       tmp.159
       fun/vector21849.8
       tmp.113
       tmp.233
       tmp.158
       fun/pair21851.7
       tmp.112
       tmp.232
       tmp.157
       fun/vector21856.6
       tmp.111
       tmp.231
       tmp.156
       fun/ascii-char21854.5
       tmp.110
       tmp.230
       tmp.155
       fun/void21848.4
       tmp.109
       tmp.229
       tmp.154
       make-vector.74
       tmp.108
       tmp.228
       tmp.153
       make-init-vector.1
       tmp.107
       tmp.227
       tmp.152
       vector-init-loop.24
       tmp.106
       tmp.226
       tmp.151
       cons.75
       tmp.105
       tmp.225
       tmp.150
       |-.76|
       tmp.104
       tmp.224
       tmp.149
       *.77
       tmp.103
       tmp.223
       tmp.148
       |+.78|
       tmp.102
       tmp.222
       tmp.147
       tmp-ra.201)))
    (define L.lam.79.26
      ((new-frames ()) (locals (fun/pair21851.7 c.99 tmp-ra.181)))
      (begin
        (set! tmp-ra.181 r15)
        (set! c.99 rdi)
        (set! fun/pair21851.7 (mref c.99 14))
        (set! rdi fun/pair21851.7)
        (set! r15 tmp-ra.181)
        (jump L.fun/pair21851.7.17 rbp r15 rdi)))
    (define L.fun/void21847.15.25
      ((new-frames ()) (locals (fun/void21848.4 c.98 tmp-ra.182)))
      (begin
        (set! tmp-ra.182 r15)
        (set! c.98 rdi)
        (set! fun/void21848.4 (mref c.98 14))
        (set! rdi fun/void21848.4)
        (set! r15 tmp-ra.182)
        (jump L.fun/void21848.4.14 rbp r15 rdi)))
    (define L.fun/ascii-char21853.14.24
      ((new-frames ()) (locals (fun/ascii-char21854.5 c.97 tmp-ra.183)))
      (begin
        (set! tmp-ra.183 r15)
        (set! c.97 rdi)
        (set! fun/ascii-char21854.5 (mref c.97 14))
        (set! rdi fun/ascii-char21854.5)
        (set! r15 tmp-ra.183)
        (jump L.fun/ascii-char21854.5.15 rbp r15 rdi)))
    (define L.fun/error21845.13.23
      ((new-frames ()) (locals (fun/error21846.10 c.96 tmp-ra.184)))
      (begin
        (set! tmp-ra.184 r15)
        (set! c.96 rdi)
        (set! fun/error21846.10 (mref c.96 14))
        (set! rdi fun/error21846.10)
        (set! r15 tmp-ra.184)
        (jump L.fun/error21846.10.20 rbp r15 rdi)))
    (define L.fun/pair21852.12.22
      ((new-frames ()) (locals (cons.75 c.95 tmp-ra.185)))
      (begin
        (set! tmp-ra.185 r15)
        (set! c.95 rdi)
        (set! cons.75 (mref c.95 14))
        (set! rdx 2232)
        (set! rsi 624)
        (set! rdi cons.75)
        (set! r15 tmp-ra.185)
        (jump L.cons.75.10 rbp r15 rdi rsi rdx)))
    (define L.fun/vector21855.11.21
      ((new-frames ()) (locals (fun/vector21856.6 c.94 tmp-ra.186)))
      (begin
        (set! tmp-ra.186 r15)
        (set! c.94 rdi)
        (set! fun/vector21856.6 (mref c.94 14))
        (set! rdi fun/vector21856.6)
        (set! r15 tmp-ra.186)
        (jump L.fun/vector21856.6.16 rbp r15 rdi)))
    (define L.fun/error21846.10.20
      ((new-frames ()) (locals (c.93 tmp-ra.187)))
      (begin
        (set! tmp-ra.187 r15)
        (set! c.93 rdi)
        (set! rax 59198)
        (jump tmp-ra.187 rbp rax)))
    (define L.fun/vector21850.9.19
      ((new-frames ()) (locals (make-vector.74 c.92 tmp-ra.188)))
      (begin
        (set! tmp-ra.188 r15)
        (set! c.92 rdi)
        (set! make-vector.74 (mref c.92 14))
        (set! rsi 64)
        (set! rdi make-vector.74)
        (set! r15 tmp-ra.188)
        (jump L.make-vector.74.13 rbp r15 rdi rsi)))
    (define L.fun/vector21849.8.18
      ((new-frames ()) (locals (fun/vector21850.9 c.91 tmp-ra.189)))
      (begin
        (set! tmp-ra.189 r15)
        (set! c.91 rdi)
        (set! fun/vector21850.9 (mref c.91 14))
        (set! rdi fun/vector21850.9)
        (set! r15 tmp-ra.189)
        (jump L.fun/vector21850.9.19 rbp r15 rdi)))
    (define L.fun/pair21851.7.17
      ((new-frames ()) (locals (fun/pair21852.12 c.90 tmp-ra.190)))
      (begin
        (set! tmp-ra.190 r15)
        (set! c.90 rdi)
        (set! fun/pair21852.12 (mref c.90 14))
        (set! rdi fun/pair21852.12)
        (set! r15 tmp-ra.190)
        (jump L.fun/pair21852.12.22 rbp r15 rdi)))
    (define L.fun/vector21856.6.16
      ((new-frames ()) (locals (make-vector.74 c.89 tmp-ra.191)))
      (begin
        (set! tmp-ra.191 r15)
        (set! c.89 rdi)
        (set! make-vector.74 (mref c.89 14))
        (set! rsi 64)
        (set! rdi make-vector.74)
        (set! r15 tmp-ra.191)
        (jump L.make-vector.74.13 rbp r15 rdi rsi)))
    (define L.fun/ascii-char21854.5.15
      ((new-frames ()) (locals (c.88 tmp-ra.192)))
      (begin
        (set! tmp-ra.192 r15)
        (set! c.88 rdi)
        (set! rax 26670)
        (jump tmp-ra.192 rbp rax)))
    (define L.fun/void21848.4.14
      ((new-frames ()) (locals (c.87 tmp-ra.193)))
      (begin
        (set! tmp-ra.193 r15)
        (set! c.87 rdi)
        (set! rax 30)
        (jump tmp-ra.193 rbp rax)))
    (define L.make-vector.74.13
      ((new-frames ())
       (locals
        (c.86 make-init-vector.1 tmp-ra.194 tmp.123 tmp.50 tmp.202 tmp.122)))
      (begin
        (set! tmp-ra.194 r15)
        (set! c.86 rdi)
        (set! tmp.50 rsi)
        (set! make-init-vector.1 (mref c.86 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.202 tmp.50)
                      (set! tmp.202 (bitwise-and tmp.202 7))
                      (set! tmp.123 tmp.202))
                    (= tmp.123 0))
                (set! tmp.122 14)
                (set! tmp.122 6))
              (!= tmp.122 6))
          (begin
            (set! rsi tmp.50)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.194)
            (jump L.make-init-vector.1.12 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.194 rbp rax)))))
    (define L.make-init-vector.1.12
      ((new-frames ())
       (locals
        (tmp.23
         tmp.100
         tmp.206
         tmp.124
         tmp.125
         tmp.205
         tmp.126
         tmp.204
         tmp.127
         tmp.203
         vector-init-loop.24
         tmp.22
         c.85
         tmp-ra.195)))
      (begin
        (set! tmp-ra.195 r15)
        (set! c.85 rdi)
        (set! tmp.22 rsi)
        (set! vector-init-loop.24 (mref c.85 14))
        (set! tmp.203 tmp.22)
        (set! tmp.203 (arithmetic-shift-right tmp.203 3))
        (set! tmp.127 tmp.203)
        (set! tmp.204 1)
        (set! tmp.204 (+ tmp.204 tmp.127))
        (set! tmp.126 tmp.204)
        (set! tmp.205 tmp.126)
        (set! tmp.205 (* tmp.205 8))
        (set! tmp.125 tmp.205)
        (begin (set! tmp.124 r12) (set! r12 (+ r12 tmp.125)))
        (set! tmp.206 tmp.124)
        (set! tmp.206 (+ tmp.206 3))
        (set! tmp.100 tmp.206)
        (mset! tmp.100 -3 tmp.22)
        (set! tmp.23 tmp.100)
        (set! rcx tmp.23)
        (set! rdx 0)
        (set! rsi tmp.22)
        (set! rdi vector-init-loop.24)
        (set! r15 tmp-ra.195)
        (jump L.vector-init-loop.24.11 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.24.11
      ((new-frames ())
       (locals
        (c.84
         tmp.207
         tmp.131
         tmp.208
         tmp.130
         tmp.209
         tmp.129
         tmp.210
         tmp.132
         vector-init-loop.24
         tmp-ra.196
         vec.26
         len.25
         i.27
         tmp.128)))
      (begin
        (set! tmp-ra.196 r15)
        (set! c.84 rdi)
        (set! len.25 rsi)
        (set! i.27 rdx)
        (set! vec.26 rcx)
        (set! vector-init-loop.24 (mref c.84 14))
        (if (begin
              (if (= len.25 i.27) (set! tmp.128 14) (set! tmp.128 6))
              (!= tmp.128 6))
          (begin (set! rax vec.26) (jump tmp-ra.196 rbp rax))
          (begin
            (set! tmp.207 i.27)
            (set! tmp.207 (arithmetic-shift-right tmp.207 3))
            (set! tmp.131 tmp.207)
            (set! tmp.208 tmp.131)
            (set! tmp.208 (* tmp.208 8))
            (set! tmp.130 tmp.208)
            (set! tmp.209 tmp.130)
            (set! tmp.209 (+ tmp.209 5))
            (set! tmp.129 tmp.209)
            (mset! vec.26 tmp.129 0)
            (set! tmp.210 i.27)
            (set! tmp.210 (+ tmp.210 8))
            (set! tmp.132 tmp.210)
            (set! rcx vec.26)
            (set! rdx tmp.132)
            (set! rsi len.25)
            (set! rdi vector-init-loop.24)
            (set! r15 tmp-ra.196)
            (jump L.vector-init-loop.24.11 rbp r15 rdi rsi rdx rcx)))))
    (define L.cons.75.10
      ((new-frames ())
       (locals (tmp.101 tmp.211 tmp.133 tmp.70 tmp.69 c.83 tmp-ra.197)))
      (begin
        (set! tmp-ra.197 r15)
        (set! c.83 rdi)
        (set! tmp.69 rsi)
        (set! tmp.70 rdx)
        (begin (set! tmp.133 r12) (set! r12 (+ r12 16)))
        (set! tmp.211 tmp.133)
        (set! tmp.211 (+ tmp.211 1))
        (set! tmp.101 tmp.211)
        (mset! tmp.101 -1 tmp.69)
        (mset! tmp.101 7 tmp.70)
        (set! rax tmp.101)
        (jump tmp-ra.197 rbp rax)))
    (define L.-.76.9
      ((new-frames ())
       (locals
        (c.82
         tmp.136
         tmp.213
         tmp.40
         tmp.137
         tmp.214
         tmp-ra.198
         tmp.135
         tmp.41
         tmp.212
         tmp.134)))
      (begin
        (set! tmp-ra.198 r15)
        (set! c.82 rdi)
        (set! tmp.40 rsi)
        (set! tmp.41 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.212 tmp.41)
                      (set! tmp.212 (bitwise-and tmp.212 7))
                      (set! tmp.135 tmp.212))
                    (= tmp.135 0))
                (set! tmp.134 14)
                (set! tmp.134 6))
              (!= tmp.134 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.213 tmp.40)
                        (set! tmp.213 (bitwise-and tmp.213 7))
                        (set! tmp.137 tmp.213))
                      (= tmp.137 0))
                  (set! tmp.136 14)
                  (set! tmp.136 6))
                (!= tmp.136 6))
            (begin
              (set! tmp.214 tmp.40)
              (set! tmp.214 (- tmp.214 tmp.41))
              (set! rax tmp.214)
              (jump tmp-ra.198 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.198 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.198 rbp rax)))))
    (define L.*.77.8
      ((new-frames ())
       (locals
        (c.81
         tmp.140
         tmp.216
         tmp.36
         tmp.141
         tmp.218
         tmp.142
         tmp.217
         tmp-ra.199
         tmp.139
         tmp.37
         tmp.215
         tmp.138)))
      (begin
        (set! tmp-ra.199 r15)
        (set! c.81 rdi)
        (set! tmp.36 rsi)
        (set! tmp.37 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.215 tmp.37)
                      (set! tmp.215 (bitwise-and tmp.215 7))
                      (set! tmp.139 tmp.215))
                    (= tmp.139 0))
                (set! tmp.138 14)
                (set! tmp.138 6))
              (!= tmp.138 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.216 tmp.36)
                        (set! tmp.216 (bitwise-and tmp.216 7))
                        (set! tmp.141 tmp.216))
                      (= tmp.141 0))
                  (set! tmp.140 14)
                  (set! tmp.140 6))
                (!= tmp.140 6))
            (begin
              (set! tmp.217 tmp.37)
              (set! tmp.217 (arithmetic-shift-right tmp.217 3))
              (set! tmp.142 tmp.217)
              (set! tmp.218 tmp.36)
              (set! tmp.218 (* tmp.218 tmp.142))
              (set! rax tmp.218)
              (jump tmp-ra.199 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.199 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.199 rbp rax)))))
    (define L.+.78.7
      ((new-frames ())
       (locals
        (c.80
         tmp.145
         tmp.220
         tmp.38
         tmp.146
         tmp.221
         tmp-ra.200
         tmp.144
         tmp.39
         tmp.219
         tmp.143)))
      (begin
        (set! tmp-ra.200 r15)
        (set! c.80 rdi)
        (set! tmp.38 rsi)
        (set! tmp.39 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.219 tmp.39)
                      (set! tmp.219 (bitwise-and tmp.219 7))
                      (set! tmp.144 tmp.219))
                    (= tmp.144 0))
                (set! tmp.143 14)
                (set! tmp.143 6))
              (!= tmp.143 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.220 tmp.38)
                        (set! tmp.220 (bitwise-and tmp.220 7))
                        (set! tmp.146 tmp.220))
                      (= tmp.146 0))
                  (set! tmp.145 14)
                  (set! tmp.145 6))
                (!= tmp.145 6))
            (begin
              (set! tmp.221 tmp.38)
              (set! tmp.221 (+ tmp.221 tmp.39))
              (set! rax tmp.221)
              (jump tmp-ra.200 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.200 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.200 rbp rax)))))
    (begin
      (set! tmp-ra.201 r15)
      (begin (set! tmp.147 r12) (set! r12 (+ r12 16)))
      (set! tmp.222 tmp.147)
      (set! tmp.222 (+ tmp.222 2))
      (set! tmp.102 tmp.222)
      (mset! tmp.102 -2 L.+.78.7)
      (mset! tmp.102 6 16)
      (set! |+.78| tmp.102)
      (begin (set! tmp.148 r12) (set! r12 (+ r12 16)))
      (set! tmp.223 tmp.148)
      (set! tmp.223 (+ tmp.223 2))
      (set! tmp.103 tmp.223)
      (mset! tmp.103 -2 L.*.77.8)
      (mset! tmp.103 6 16)
      (set! *.77 tmp.103)
      (begin (set! tmp.149 r12) (set! r12 (+ r12 16)))
      (set! tmp.224 tmp.149)
      (set! tmp.224 (+ tmp.224 2))
      (set! tmp.104 tmp.224)
      (mset! tmp.104 -2 L.-.76.9)
      (mset! tmp.104 6 16)
      (set! |-.76| tmp.104)
      (begin (set! tmp.150 r12) (set! r12 (+ r12 16)))
      (set! tmp.225 tmp.150)
      (set! tmp.225 (+ tmp.225 2))
      (set! tmp.105 tmp.225)
      (mset! tmp.105 -2 L.cons.75.10)
      (mset! tmp.105 6 16)
      (set! cons.75 tmp.105)
      (begin (set! tmp.151 r12) (set! r12 (+ r12 24)))
      (set! tmp.226 tmp.151)
      (set! tmp.226 (+ tmp.226 2))
      (set! tmp.106 tmp.226)
      (mset! tmp.106 -2 L.vector-init-loop.24.11)
      (mset! tmp.106 6 24)
      (set! vector-init-loop.24 tmp.106)
      (begin (set! tmp.152 r12) (set! r12 (+ r12 24)))
      (set! tmp.227 tmp.152)
      (set! tmp.227 (+ tmp.227 2))
      (set! tmp.107 tmp.227)
      (mset! tmp.107 -2 L.make-init-vector.1.12)
      (mset! tmp.107 6 8)
      (set! make-init-vector.1 tmp.107)
      (begin (set! tmp.153 r12) (set! r12 (+ r12 24)))
      (set! tmp.228 tmp.153)
      (set! tmp.228 (+ tmp.228 2))
      (set! tmp.108 tmp.228)
      (mset! tmp.108 -2 L.make-vector.74.13)
      (mset! tmp.108 6 8)
      (set! make-vector.74 tmp.108)
      (begin (set! tmp.154 r12) (set! r12 (+ r12 16)))
      (set! tmp.229 tmp.154)
      (set! tmp.229 (+ tmp.229 2))
      (set! tmp.109 tmp.229)
      (mset! tmp.109 -2 L.fun/void21848.4.14)
      (mset! tmp.109 6 0)
      (set! fun/void21848.4 tmp.109)
      (begin (set! tmp.155 r12) (set! r12 (+ r12 16)))
      (set! tmp.230 tmp.155)
      (set! tmp.230 (+ tmp.230 2))
      (set! tmp.110 tmp.230)
      (mset! tmp.110 -2 L.fun/ascii-char21854.5.15)
      (mset! tmp.110 6 0)
      (set! fun/ascii-char21854.5 tmp.110)
      (begin (set! tmp.156 r12) (set! r12 (+ r12 24)))
      (set! tmp.231 tmp.156)
      (set! tmp.231 (+ tmp.231 2))
      (set! tmp.111 tmp.231)
      (mset! tmp.111 -2 L.fun/vector21856.6.16)
      (mset! tmp.111 6 0)
      (set! fun/vector21856.6 tmp.111)
      (begin (set! tmp.157 r12) (set! r12 (+ r12 24)))
      (set! tmp.232 tmp.157)
      (set! tmp.232 (+ tmp.232 2))
      (set! tmp.112 tmp.232)
      (mset! tmp.112 -2 L.fun/pair21851.7.17)
      (mset! tmp.112 6 0)
      (set! fun/pair21851.7 tmp.112)
      (begin (set! tmp.158 r12) (set! r12 (+ r12 24)))
      (set! tmp.233 tmp.158)
      (set! tmp.233 (+ tmp.233 2))
      (set! tmp.113 tmp.233)
      (mset! tmp.113 -2 L.fun/vector21849.8.18)
      (mset! tmp.113 6 0)
      (set! fun/vector21849.8 tmp.113)
      (begin (set! tmp.159 r12) (set! r12 (+ r12 24)))
      (set! tmp.234 tmp.159)
      (set! tmp.234 (+ tmp.234 2))
      (set! tmp.114 tmp.234)
      (mset! tmp.114 -2 L.fun/vector21850.9.19)
      (mset! tmp.114 6 0)
      (set! fun/vector21850.9 tmp.114)
      (begin (set! tmp.160 r12) (set! r12 (+ r12 16)))
      (set! tmp.235 tmp.160)
      (set! tmp.235 (+ tmp.235 2))
      (set! tmp.115 tmp.235)
      (mset! tmp.115 -2 L.fun/error21846.10.20)
      (mset! tmp.115 6 0)
      (set! fun/error21846.10 tmp.115)
      (begin (set! tmp.161 r12) (set! r12 (+ r12 24)))
      (set! tmp.236 tmp.161)
      (set! tmp.236 (+ tmp.236 2))
      (set! tmp.116 tmp.236)
      (mset! tmp.116 -2 L.fun/vector21855.11.21)
      (mset! tmp.116 6 0)
      (set! fun/vector21855.11 tmp.116)
      (begin (set! tmp.162 r12) (set! r12 (+ r12 24)))
      (set! tmp.237 tmp.162)
      (set! tmp.237 (+ tmp.237 2))
      (set! tmp.117 tmp.237)
      (mset! tmp.117 -2 L.fun/pair21852.12.22)
      (mset! tmp.117 6 0)
      (set! fun/pair21852.12 tmp.117)
      (begin (set! tmp.163 r12) (set! r12 (+ r12 24)))
      (set! tmp.238 tmp.163)
      (set! tmp.238 (+ tmp.238 2))
      (set! tmp.118 tmp.238)
      (mset! tmp.118 -2 L.fun/error21845.13.23)
      (mset! tmp.118 6 0)
      (set! fun/error21845.13 tmp.118)
      (begin (set! tmp.164 r12) (set! r12 (+ r12 24)))
      (set! tmp.239 tmp.164)
      (set! tmp.239 (+ tmp.239 2))
      (set! tmp.119 tmp.239)
      (mset! tmp.119 -2 L.fun/ascii-char21853.14.24)
      (mset! tmp.119 6 0)
      (set! fun/ascii-char21853.14 tmp.119)
      (begin (set! tmp.165 r12) (set! r12 (+ r12 24)))
      (set! tmp.240 tmp.165)
      (set! tmp.240 (+ tmp.240 2))
      (set! tmp.120 tmp.240)
      (mset! tmp.120 -2 L.fun/void21847.15.25)
      (mset! tmp.120 6 0)
      (set! fun/void21847.15 tmp.120)
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
      (return-point L.rp.27
        (begin
          (set! rdi fun/error21845.13)
          (set! r15 L.rp.27)
          (jump L.fun/error21845.13.23 rbp r15 rdi)))
      (set! error0.21 rax)
      (return-point L.rp.28
        (begin
          (set! rdi fun/void21847.15)
          (set! r15 L.rp.28)
          (jump L.fun/void21847.15.25 rbp r15 rdi)))
      (set! void1.20 rax)
      (return-point L.rp.29
        (begin
          (set! rdi fun/vector21849.8)
          (set! r15 L.rp.29)
          (jump L.fun/vector21849.8.18 rbp r15 rdi)))
      (set! vector2.19 rax)
      (begin (set! tmp.166 r12) (set! r12 (+ r12 24)))
      (set! tmp.241 tmp.166)
      (set! tmp.241 (+ tmp.241 2))
      (set! tmp.121 tmp.241)
      (mset! tmp.121 -2 L.lam.79.26)
      (mset! tmp.121 6 0)
      (set! lam.79 tmp.121)
      (mset! lam.79 14 fun/pair21851.7)
      (set! procedure3.18 lam.79)
      (return-point L.rp.30
        (begin
          (set! rdi fun/ascii-char21853.14)
          (set! r15 L.rp.30)
          (jump L.fun/ascii-char21853.14.24 rbp r15 rdi)))
      (set! ascii-char4.17 rax)
      (return-point L.rp.31
        (begin
          (set! rdx 528)
          (set! rsi 656)
          (set! rdi |-.76|)
          (set! r15 L.rp.31)
          (jump L.-.76.9 rbp r15 rdi rsi rdx)))
      (set! tmp.169 rax)
      (return-point L.rp.32
        (begin
          (set! rdx 664)
          (set! rsi 1168)
          (set! rdi |-.76|)
          (set! r15 L.rp.32)
          (jump L.-.76.9 rbp r15 rdi rsi rdx)))
      (set! tmp.170 rax)
      (return-point L.rp.33
        (begin
          (set! rdx tmp.170)
          (set! rsi tmp.169)
          (set! rdi *.77)
          (set! r15 L.rp.33)
          (jump L.*.77.8 rbp r15 rdi rsi rdx)))
      (set! tmp.168 rax)
      (return-point L.rp.34
        (begin
          (set! rdx 688)
          (set! rsi 640)
          (set! rdi |+.78|)
          (set! r15 L.rp.34)
          (jump L.+.78.7 rbp r15 rdi rsi rdx)))
      (set! tmp.172 rax)
      (return-point L.rp.35
        (begin
          (set! rdx 344)
          (set! rsi 664)
          (set! rdi |-.76|)
          (set! r15 L.rp.35)
          (jump L.-.76.9 rbp r15 rdi rsi rdx)))
      (set! tmp.173 rax)
      (return-point L.rp.36
        (begin
          (set! rdx tmp.173)
          (set! rsi tmp.172)
          (set! rdi |+.78|)
          (set! r15 L.rp.36)
          (jump L.+.78.7 rbp r15 rdi rsi rdx)))
      (set! tmp.171 rax)
      (return-point L.rp.37
        (begin
          (set! rdx tmp.171)
          (set! rsi tmp.168)
          (set! rdi *.77)
          (set! r15 L.rp.37)
          (jump L.*.77.8 rbp r15 rdi rsi rdx)))
      (set! tmp.167 rax)
      (return-point L.rp.38
        (begin
          (set! rdx 312)
          (set! rsi 1408)
          (set! rdi *.77)
          (set! r15 L.rp.38)
          (jump L.*.77.8 rbp r15 rdi rsi rdx)))
      (set! tmp.176 rax)
      (return-point L.rp.39
        (begin
          (set! rdx 96)
          (set! rsi 1896)
          (set! rdi |-.76|)
          (set! r15 L.rp.39)
          (jump L.-.76.9 rbp r15 rdi rsi rdx)))
      (set! tmp.177 rax)
      (return-point L.rp.40
        (begin
          (set! rdx tmp.177)
          (set! rsi tmp.176)
          (set! rdi |-.76|)
          (set! r15 L.rp.40)
          (jump L.-.76.9 rbp r15 rdi rsi rdx)))
      (set! tmp.175 rax)
      (return-point L.rp.41
        (begin
          (set! rdx 1776)
          (set! rsi 1096)
          (set! rdi *.77)
          (set! r15 L.rp.41)
          (jump L.*.77.8 rbp r15 rdi rsi rdx)))
      (set! tmp.179 rax)
      (return-point L.rp.42
        (begin
          (set! rdx 856)
          (set! rsi 1024)
          (set! rdi |-.76|)
          (set! r15 L.rp.42)
          (jump L.-.76.9 rbp r15 rdi rsi rdx)))
      (set! tmp.180 rax)
      (return-point L.rp.43
        (begin
          (set! rdx tmp.180)
          (set! rsi tmp.179)
          (set! rdi |-.76|)
          (set! r15 L.rp.43)
          (jump L.-.76.9 rbp r15 rdi rsi rdx)))
      (set! tmp.178 rax)
      (return-point L.rp.44
        (begin
          (set! rdx tmp.178)
          (set! rsi tmp.175)
          (set! rdi *.77)
          (set! r15 L.rp.44)
          (jump L.*.77.8 rbp r15 rdi rsi rdx)))
      (set! tmp.174 rax)
      (return-point L.rp.45
        (begin
          (set! rdx tmp.174)
          (set! rsi tmp.167)
          (set! rdi *.77)
          (set! r15 L.rp.45)
          (jump L.*.77.8 rbp r15 rdi rsi rdx)))
      (set! fixnum5.16 rax)
      (set! rdi fun/vector21855.11)
      (set! r15 tmp-ra.201)
      (jump L.fun/vector21855.11.21 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() () () () ()))
     (locals
      (void5.16
       vector4.17
       void3.18
       empty2.19
       lam.75
       tmp.108
       tmp.182
       tmp.135
       empty0.21
       fun/void10032.15
       tmp.107
       tmp.181
       tmp.134
       fun/vector10024.14
       tmp.106
       tmp.180
       tmp.133
       fun/empty10022.13
       tmp.105
       tmp.179
       tmp.132
       fun/vector10025.12
       tmp.104
       tmp.178
       tmp.131
       fun/empty10027.11
       tmp.103
       tmp.177
       tmp.130
       fun/void10028.10
       tmp.102
       tmp.176
       tmp.129
       fun/vector10031.9
       tmp.101
       tmp.175
       tmp.128
       fun/void10029.8
       tmp.100
       tmp.174
       tmp.127
       fun/empty10023.7
       tmp.99
       tmp.173
       tmp.126
       fun/vector10030.6
       tmp.98
       tmp.172
       tmp.125
       fun/void10033.5
       tmp.97
       tmp.171
       tmp.124
       fun/empty10026.4
       tmp.96
       tmp.170
       tmp.123
       make-vector.74
       tmp.95
       tmp.169
       tmp.122
       make-init-vector.1
       tmp.94
       tmp.168
       tmp.121
       vector-init-loop.24
       tmp.93
       tmp.167
       tmp.120
       tmp.138
       tmp.139
       tmp-ra.157
       tmp.140
       tmp.137
       procedure1.20
       tmp.183
       tmp.136)))
    (define L.lam.75.22
      ((new-frames ()) (locals (fun/vector10024.14 c.91 tmp-ra.141)))
      (begin
        (set! tmp-ra.141 r15)
        (set! c.91 rdi)
        (set! fun/vector10024.14 (mref c.91 14))
        (set! rdi fun/vector10024.14)
        (set! r15 tmp-ra.141)
        (jump L.fun/vector10024.14.20 rbp r15 rdi)))
    (define L.fun/void10032.15.21
      ((new-frames ()) (locals (fun/void10033.5 c.90 tmp-ra.142)))
      (begin
        (set! tmp-ra.142 r15)
        (set! c.90 rdi)
        (set! fun/void10033.5 (mref c.90 14))
        (set! rdi fun/void10033.5)
        (set! r15 tmp-ra.142)
        (jump L.fun/void10033.5.11 rbp r15 rdi)))
    (define L.fun/vector10024.14.20
      ((new-frames ()) (locals (fun/vector10025.12 c.89 tmp-ra.143)))
      (begin
        (set! tmp-ra.143 r15)
        (set! c.89 rdi)
        (set! fun/vector10025.12 (mref c.89 14))
        (set! rdi fun/vector10025.12)
        (set! r15 tmp-ra.143)
        (jump L.fun/vector10025.12.18 rbp r15 rdi)))
    (define L.fun/empty10022.13.19
      ((new-frames ()) (locals (fun/empty10023.7 c.88 tmp-ra.144)))
      (begin
        (set! tmp-ra.144 r15)
        (set! c.88 rdi)
        (set! fun/empty10023.7 (mref c.88 14))
        (set! rdi fun/empty10023.7)
        (set! r15 tmp-ra.144)
        (jump L.fun/empty10023.7.13 rbp r15 rdi)))
    (define L.fun/vector10025.12.18
      ((new-frames ()) (locals (make-vector.74 c.87 tmp-ra.145)))
      (begin
        (set! tmp-ra.145 r15)
        (set! c.87 rdi)
        (set! make-vector.74 (mref c.87 14))
        (set! rsi 64)
        (set! rdi make-vector.74)
        (set! r15 tmp-ra.145)
        (jump L.make-vector.74.9 rbp r15 rdi rsi)))
    (define L.fun/empty10027.11.17
      ((new-frames ()) (locals (c.86 tmp-ra.146)))
      (begin
        (set! tmp-ra.146 r15)
        (set! c.86 rdi)
        (set! rax 22)
        (jump tmp-ra.146 rbp rax)))
    (define L.fun/void10028.10.16
      ((new-frames ()) (locals (fun/void10029.8 c.85 tmp-ra.147)))
      (begin
        (set! tmp-ra.147 r15)
        (set! c.85 rdi)
        (set! fun/void10029.8 (mref c.85 14))
        (set! rdi fun/void10029.8)
        (set! r15 tmp-ra.147)
        (jump L.fun/void10029.8.14 rbp r15 rdi)))
    (define L.fun/vector10031.9.15
      ((new-frames ()) (locals (make-vector.74 c.84 tmp-ra.148)))
      (begin
        (set! tmp-ra.148 r15)
        (set! c.84 rdi)
        (set! make-vector.74 (mref c.84 14))
        (set! rsi 64)
        (set! rdi make-vector.74)
        (set! r15 tmp-ra.148)
        (jump L.make-vector.74.9 rbp r15 rdi rsi)))
    (define L.fun/void10029.8.14
      ((new-frames ()) (locals (c.83 tmp-ra.149)))
      (begin
        (set! tmp-ra.149 r15)
        (set! c.83 rdi)
        (set! rax 30)
        (jump tmp-ra.149 rbp rax)))
    (define L.fun/empty10023.7.13
      ((new-frames ()) (locals (c.82 tmp-ra.150)))
      (begin
        (set! tmp-ra.150 r15)
        (set! c.82 rdi)
        (set! rax 22)
        (jump tmp-ra.150 rbp rax)))
    (define L.fun/vector10030.6.12
      ((new-frames ()) (locals (fun/vector10031.9 c.81 tmp-ra.151)))
      (begin
        (set! tmp-ra.151 r15)
        (set! c.81 rdi)
        (set! fun/vector10031.9 (mref c.81 14))
        (set! rdi fun/vector10031.9)
        (set! r15 tmp-ra.151)
        (jump L.fun/vector10031.9.15 rbp r15 rdi)))
    (define L.fun/void10033.5.11
      ((new-frames ()) (locals (c.80 tmp-ra.152)))
      (begin
        (set! tmp-ra.152 r15)
        (set! c.80 rdi)
        (set! rax 30)
        (jump tmp-ra.152 rbp rax)))
    (define L.fun/empty10026.4.10
      ((new-frames ()) (locals (fun/empty10027.11 c.79 tmp-ra.153)))
      (begin
        (set! tmp-ra.153 r15)
        (set! c.79 rdi)
        (set! fun/empty10027.11 (mref c.79 14))
        (set! rdi fun/empty10027.11)
        (set! r15 tmp-ra.153)
        (jump L.fun/empty10027.11.17 rbp r15 rdi)))
    (define L.make-vector.74.9
      ((new-frames ())
       (locals
        (c.78 make-init-vector.1 tmp-ra.154 tmp.110 tmp.50 tmp.158 tmp.109)))
      (begin
        (set! tmp-ra.154 r15)
        (set! c.78 rdi)
        (set! tmp.50 rsi)
        (set! make-init-vector.1 (mref c.78 14))
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.158 tmp.50)
                      (set! tmp.158 (bitwise-and tmp.158 7))
                      (set! tmp.110 tmp.158))
                    (= tmp.110 0))
                (set! tmp.109 14)
                (set! tmp.109 6))
              (!= tmp.109 6))
          (begin
            (set! rsi tmp.50)
            (set! rdi make-init-vector.1)
            (set! r15 tmp-ra.154)
            (jump L.make-init-vector.1.8 rbp r15 rdi rsi))
          (begin (set! rax 2110) (jump tmp-ra.154 rbp rax)))))
    (define L.make-init-vector.1.8
      ((new-frames ())
       (locals
        (tmp.23
         tmp.92
         tmp.162
         tmp.111
         tmp.112
         tmp.161
         tmp.113
         tmp.160
         tmp.114
         tmp.159
         vector-init-loop.24
         tmp.22
         c.77
         tmp-ra.155)))
      (begin
        (set! tmp-ra.155 r15)
        (set! c.77 rdi)
        (set! tmp.22 rsi)
        (set! vector-init-loop.24 (mref c.77 14))
        (set! tmp.159 tmp.22)
        (set! tmp.159 (arithmetic-shift-right tmp.159 3))
        (set! tmp.114 tmp.159)
        (set! tmp.160 1)
        (set! tmp.160 (+ tmp.160 tmp.114))
        (set! tmp.113 tmp.160)
        (set! tmp.161 tmp.113)
        (set! tmp.161 (* tmp.161 8))
        (set! tmp.112 tmp.161)
        (begin (set! tmp.111 r12) (set! r12 (+ r12 tmp.112)))
        (set! tmp.162 tmp.111)
        (set! tmp.162 (+ tmp.162 3))
        (set! tmp.92 tmp.162)
        (mset! tmp.92 -3 tmp.22)
        (set! tmp.23 tmp.92)
        (set! rcx tmp.23)
        (set! rdx 0)
        (set! rsi tmp.22)
        (set! rdi vector-init-loop.24)
        (set! r15 tmp-ra.155)
        (jump L.vector-init-loop.24.7 rbp r15 rdi rsi rdx rcx)))
    (define L.vector-init-loop.24.7
      ((new-frames ())
       (locals
        (c.76
         tmp.163
         tmp.118
         tmp.164
         tmp.117
         tmp.165
         tmp.116
         tmp.166
         tmp.119
         vector-init-loop.24
         tmp-ra.156
         vec.26
         len.25
         i.27
         tmp.115)))
      (begin
        (set! tmp-ra.156 r15)
        (set! c.76 rdi)
        (set! len.25 rsi)
        (set! i.27 rdx)
        (set! vec.26 rcx)
        (set! vector-init-loop.24 (mref c.76 14))
        (if (begin
              (if (= len.25 i.27) (set! tmp.115 14) (set! tmp.115 6))
              (!= tmp.115 6))
          (begin (set! rax vec.26) (jump tmp-ra.156 rbp rax))
          (begin
            (set! tmp.163 i.27)
            (set! tmp.163 (arithmetic-shift-right tmp.163 3))
            (set! tmp.118 tmp.163)
            (set! tmp.164 tmp.118)
            (set! tmp.164 (* tmp.164 8))
            (set! tmp.117 tmp.164)
            (set! tmp.165 tmp.117)
            (set! tmp.165 (+ tmp.165 5))
            (set! tmp.116 tmp.165)
            (mset! vec.26 tmp.116 0)
            (set! tmp.166 i.27)
            (set! tmp.166 (+ tmp.166 8))
            (set! tmp.119 tmp.166)
            (set! rcx vec.26)
            (set! rdx tmp.119)
            (set! rsi len.25)
            (set! rdi vector-init-loop.24)
            (set! r15 tmp-ra.156)
            (jump L.vector-init-loop.24.7 rbp r15 rdi rsi rdx rcx)))))
    (begin
      (set! tmp-ra.157 r15)
      (begin (set! tmp.120 r12) (set! r12 (+ r12 24)))
      (set! tmp.167 tmp.120)
      (set! tmp.167 (+ tmp.167 2))
      (set! tmp.93 tmp.167)
      (mset! tmp.93 -2 L.vector-init-loop.24.7)
      (mset! tmp.93 6 24)
      (set! vector-init-loop.24 tmp.93)
      (begin (set! tmp.121 r12) (set! r12 (+ r12 24)))
      (set! tmp.168 tmp.121)
      (set! tmp.168 (+ tmp.168 2))
      (set! tmp.94 tmp.168)
      (mset! tmp.94 -2 L.make-init-vector.1.8)
      (mset! tmp.94 6 8)
      (set! make-init-vector.1 tmp.94)
      (begin (set! tmp.122 r12) (set! r12 (+ r12 24)))
      (set! tmp.169 tmp.122)
      (set! tmp.169 (+ tmp.169 2))
      (set! tmp.95 tmp.169)
      (mset! tmp.95 -2 L.make-vector.74.9)
      (mset! tmp.95 6 8)
      (set! make-vector.74 tmp.95)
      (begin (set! tmp.123 r12) (set! r12 (+ r12 24)))
      (set! tmp.170 tmp.123)
      (set! tmp.170 (+ tmp.170 2))
      (set! tmp.96 tmp.170)
      (mset! tmp.96 -2 L.fun/empty10026.4.10)
      (mset! tmp.96 6 0)
      (set! fun/empty10026.4 tmp.96)
      (begin (set! tmp.124 r12) (set! r12 (+ r12 16)))
      (set! tmp.171 tmp.124)
      (set! tmp.171 (+ tmp.171 2))
      (set! tmp.97 tmp.171)
      (mset! tmp.97 -2 L.fun/void10033.5.11)
      (mset! tmp.97 6 0)
      (set! fun/void10033.5 tmp.97)
      (begin (set! tmp.125 r12) (set! r12 (+ r12 24)))
      (set! tmp.172 tmp.125)
      (set! tmp.172 (+ tmp.172 2))
      (set! tmp.98 tmp.172)
      (mset! tmp.98 -2 L.fun/vector10030.6.12)
      (mset! tmp.98 6 0)
      (set! fun/vector10030.6 tmp.98)
      (begin (set! tmp.126 r12) (set! r12 (+ r12 16)))
      (set! tmp.173 tmp.126)
      (set! tmp.173 (+ tmp.173 2))
      (set! tmp.99 tmp.173)
      (mset! tmp.99 -2 L.fun/empty10023.7.13)
      (mset! tmp.99 6 0)
      (set! fun/empty10023.7 tmp.99)
      (begin (set! tmp.127 r12) (set! r12 (+ r12 16)))
      (set! tmp.174 tmp.127)
      (set! tmp.174 (+ tmp.174 2))
      (set! tmp.100 tmp.174)
      (mset! tmp.100 -2 L.fun/void10029.8.14)
      (mset! tmp.100 6 0)
      (set! fun/void10029.8 tmp.100)
      (begin (set! tmp.128 r12) (set! r12 (+ r12 24)))
      (set! tmp.175 tmp.128)
      (set! tmp.175 (+ tmp.175 2))
      (set! tmp.101 tmp.175)
      (mset! tmp.101 -2 L.fun/vector10031.9.15)
      (mset! tmp.101 6 0)
      (set! fun/vector10031.9 tmp.101)
      (begin (set! tmp.129 r12) (set! r12 (+ r12 24)))
      (set! tmp.176 tmp.129)
      (set! tmp.176 (+ tmp.176 2))
      (set! tmp.102 tmp.176)
      (mset! tmp.102 -2 L.fun/void10028.10.16)
      (mset! tmp.102 6 0)
      (set! fun/void10028.10 tmp.102)
      (begin (set! tmp.130 r12) (set! r12 (+ r12 16)))
      (set! tmp.177 tmp.130)
      (set! tmp.177 (+ tmp.177 2))
      (set! tmp.103 tmp.177)
      (mset! tmp.103 -2 L.fun/empty10027.11.17)
      (mset! tmp.103 6 0)
      (set! fun/empty10027.11 tmp.103)
      (begin (set! tmp.131 r12) (set! r12 (+ r12 24)))
      (set! tmp.178 tmp.131)
      (set! tmp.178 (+ tmp.178 2))
      (set! tmp.104 tmp.178)
      (mset! tmp.104 -2 L.fun/vector10025.12.18)
      (mset! tmp.104 6 0)
      (set! fun/vector10025.12 tmp.104)
      (begin (set! tmp.132 r12) (set! r12 (+ r12 24)))
      (set! tmp.179 tmp.132)
      (set! tmp.179 (+ tmp.179 2))
      (set! tmp.105 tmp.179)
      (mset! tmp.105 -2 L.fun/empty10022.13.19)
      (mset! tmp.105 6 0)
      (set! fun/empty10022.13 tmp.105)
      (begin (set! tmp.133 r12) (set! r12 (+ r12 24)))
      (set! tmp.180 tmp.133)
      (set! tmp.180 (+ tmp.180 2))
      (set! tmp.106 tmp.180)
      (mset! tmp.106 -2 L.fun/vector10024.14.20)
      (mset! tmp.106 6 0)
      (set! fun/vector10024.14 tmp.106)
      (begin (set! tmp.134 r12) (set! r12 (+ r12 24)))
      (set! tmp.181 tmp.134)
      (set! tmp.181 (+ tmp.181 2))
      (set! tmp.107 tmp.181)
      (mset! tmp.107 -2 L.fun/void10032.15.21)
      (mset! tmp.107 6 0)
      (set! fun/void10032.15 tmp.107)
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
      (return-point L.rp.23
        (begin
          (set! rdi fun/empty10022.13)
          (set! r15 L.rp.23)
          (jump L.fun/empty10022.13.19 rbp r15 rdi)))
      (set! empty0.21 rax)
      (begin (set! tmp.135 r12) (set! r12 (+ r12 24)))
      (set! tmp.182 tmp.135)
      (set! tmp.182 (+ tmp.182 2))
      (set! tmp.108 tmp.182)
      (mset! tmp.108 -2 L.lam.75.22)
      (mset! tmp.108 6 0)
      (set! lam.75 tmp.108)
      (mset! lam.75 14 fun/vector10024.14)
      (set! procedure1.20 lam.75)
      (return-point L.rp.24
        (begin
          (set! rdi fun/empty10026.4)
          (set! r15 L.rp.24)
          (jump L.fun/empty10026.4.10 rbp r15 rdi)))
      (set! empty2.19 rax)
      (return-point L.rp.25
        (begin
          (set! rdi fun/void10028.10)
          (set! r15 L.rp.25)
          (jump L.fun/void10028.10.16 rbp r15 rdi)))
      (set! void3.18 rax)
      (return-point L.rp.26
        (begin
          (set! rdi fun/vector10030.6)
          (set! r15 L.rp.26)
          (jump L.fun/vector10030.6.12 rbp r15 rdi)))
      (set! vector4.17 rax)
      (return-point L.rp.27
        (begin
          (set! rdi fun/void10032.15)
          (set! r15 L.rp.27)
          (jump L.fun/void10032.15.21 rbp r15 rdi)))
      (set! void5.16 rax)
      (if (begin
            (if (begin
                  (begin
                    (set! tmp.183 procedure1.20)
                    (set! tmp.183 (bitwise-and tmp.183 7))
                    (set! tmp.137 tmp.183))
                  (= tmp.137 2))
              (set! tmp.136 14)
              (set! tmp.136 6))
            (!= tmp.136 6))
        (if (begin
              (if (begin (set! tmp.139 (mref procedure1.20 6)) (= tmp.139 0))
                (set! tmp.138 14)
                (set! tmp.138 6))
              (!= tmp.138 6))
          (begin
            (set! tmp.140 (mref procedure1.20 -2))
            (set! rdi procedure1.20)
            (set! r15 tmp-ra.157)
            (jump tmp.140 rbp r15 rdi))
          (begin (set! rax 10814) (jump tmp-ra.157 rbp rax)))
        (begin (set! rax 11070) (jump tmp-ra.157 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () () () () ()))
     (locals
      (empty5.16
       error4.17
       boolean3.18
       tmp.158
       empty2.19
       fixnum1.20
       tmp.151
       tmp.155
       tmp.157
       tmp.156
       tmp.152
       tmp.154
       tmp.153
       tmp.144
       tmp.148
       tmp.150
       tmp.149
       tmp.145
       tmp.147
       tmp.146
       procedure0.21
       lam.78
       tmp.112
       tmp.204
       tmp.143
       fun/void12098.15
       tmp.111
       tmp.203
       tmp.142
       fun/error12094.14
       tmp.110
       tmp.202
       tmp.141
       fun/error12089.13
       tmp.109
       tmp.201
       tmp.140
       fun/empty12097.12
       tmp.108
       tmp.200
       tmp.139
       fun/error12088.11
       tmp.107
       tmp.199
       tmp.138
       fun/void12099.10
       tmp.106
       tmp.198
       tmp.137
       fun/any12093.9
       tmp.105
       tmp.197
       tmp.136
       fun/empty12091.8
       tmp.104
       tmp.196
       tmp.135
       fun/empty12096.7
       tmp.103
       tmp.195
       tmp.134
       fun/error12095.6
       tmp.102
       tmp.194
       tmp.133
       fun/empty12090.5
       tmp.101
       tmp.193
       tmp.132
       fun/any12092.4
       tmp.100
       tmp.192
       tmp.131
       |-.74|
       tmp.99
       tmp.191
       tmp.130
       |+.75|
       tmp.98
       tmp.190
       tmp.129
       *.76
       tmp.97
       tmp.189
       tmp.128
       fixnum?.77
       tmp.96
       tmp.188
       tmp.127
       tmp-ra.176)))
    (define L.lam.78.23
      ((new-frames ()) (locals (fun/error12088.11 c.95 tmp-ra.159)))
      (begin
        (set! tmp-ra.159 r15)
        (set! c.95 rdi)
        (set! fun/error12088.11 (mref c.95 14))
        (set! rdi fun/error12088.11)
        (set! r15 tmp-ra.159)
        (jump L.fun/error12088.11.18 rbp r15 rdi)))
    (define L.fun/void12098.15.22
      ((new-frames ()) (locals (fun/void12099.10 c.94 tmp-ra.160)))
      (begin
        (set! tmp-ra.160 r15)
        (set! c.94 rdi)
        (set! fun/void12099.10 (mref c.94 14))
        (set! rdi fun/void12099.10)
        (set! r15 tmp-ra.160)
        (jump L.fun/void12099.10.17 rbp r15 rdi)))
    (define L.fun/error12094.14.21
      ((new-frames ()) (locals (fun/error12095.6 c.93 tmp-ra.161)))
      (begin
        (set! tmp-ra.161 r15)
        (set! c.93 rdi)
        (set! fun/error12095.6 (mref c.93 14))
        (set! rdi fun/error12095.6)
        (set! r15 tmp-ra.161)
        (jump L.fun/error12095.6.13 rbp r15 rdi)))
    (define L.fun/error12089.13.20
      ((new-frames ()) (locals (c.92 tmp-ra.162)))
      (begin
        (set! tmp-ra.162 r15)
        (set! c.92 rdi)
        (set! rax 29246)
        (jump tmp-ra.162 rbp rax)))
    (define L.fun/empty12097.12.19
      ((new-frames ()) (locals (c.91 tmp-ra.163)))
      (begin
        (set! tmp-ra.163 r15)
        (set! c.91 rdi)
        (set! rax 22)
        (jump tmp-ra.163 rbp rax)))
    (define L.fun/error12088.11.18
      ((new-frames ()) (locals (fun/error12089.13 c.90 tmp-ra.164)))
      (begin
        (set! tmp-ra.164 r15)
        (set! c.90 rdi)
        (set! fun/error12089.13 (mref c.90 14))
        (set! rdi fun/error12089.13)
        (set! r15 tmp-ra.164)
        (jump L.fun/error12089.13.20 rbp r15 rdi)))
    (define L.fun/void12099.10.17
      ((new-frames ()) (locals (c.89 tmp-ra.165)))
      (begin
        (set! tmp-ra.165 r15)
        (set! c.89 rdi)
        (set! rax 30)
        (jump tmp-ra.165 rbp rax)))
    (define L.fun/any12093.9.16
      ((new-frames ()) (locals (c.88 tmp-ra.166)))
      (begin
        (set! tmp-ra.166 r15)
        (set! c.88 rdi)
        (set! rax 30)
        (jump tmp-ra.166 rbp rax)))
    (define L.fun/empty12091.8.15
      ((new-frames ()) (locals (c.87 tmp-ra.167)))
      (begin
        (set! tmp-ra.167 r15)
        (set! c.87 rdi)
        (set! rax 22)
        (jump tmp-ra.167 rbp rax)))
    (define L.fun/empty12096.7.14
      ((new-frames ()) (locals (fun/empty12097.12 c.86 tmp-ra.168)))
      (begin
        (set! tmp-ra.168 r15)
        (set! c.86 rdi)
        (set! fun/empty12097.12 (mref c.86 14))
        (set! rdi fun/empty12097.12)
        (set! r15 tmp-ra.168)
        (jump L.fun/empty12097.12.19 rbp r15 rdi)))
    (define L.fun/error12095.6.13
      ((new-frames ()) (locals (c.85 tmp-ra.169)))
      (begin
        (set! tmp-ra.169 r15)
        (set! c.85 rdi)
        (set! rax 11582)
        (jump tmp-ra.169 rbp rax)))
    (define L.fun/empty12090.5.12
      ((new-frames ()) (locals (fun/empty12091.8 c.84 tmp-ra.170)))
      (begin
        (set! tmp-ra.170 r15)
        (set! c.84 rdi)
        (set! fun/empty12091.8 (mref c.84 14))
        (set! rdi fun/empty12091.8)
        (set! r15 tmp-ra.170)
        (jump L.fun/empty12091.8.15 rbp r15 rdi)))
    (define L.fun/any12092.4.11
      ((new-frames ()) (locals (fun/any12093.9 c.83 tmp-ra.171)))
      (begin
        (set! tmp-ra.171 r15)
        (set! c.83 rdi)
        (set! fun/any12093.9 (mref c.83 14))
        (set! rdi fun/any12093.9)
        (set! r15 tmp-ra.171)
        (jump L.fun/any12093.9.16 rbp r15 rdi)))
    (define L.-.74.10
      ((new-frames ())
       (locals
        (c.82
         tmp.115
         tmp.178
         tmp.40
         tmp.116
         tmp.179
         tmp-ra.172
         tmp.114
         tmp.41
         tmp.177
         tmp.113)))
      (begin
        (set! tmp-ra.172 r15)
        (set! c.82 rdi)
        (set! tmp.40 rsi)
        (set! tmp.41 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.177 tmp.41)
                      (set! tmp.177 (bitwise-and tmp.177 7))
                      (set! tmp.114 tmp.177))
                    (= tmp.114 0))
                (set! tmp.113 14)
                (set! tmp.113 6))
              (!= tmp.113 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.178 tmp.40)
                        (set! tmp.178 (bitwise-and tmp.178 7))
                        (set! tmp.116 tmp.178))
                      (= tmp.116 0))
                  (set! tmp.115 14)
                  (set! tmp.115 6))
                (!= tmp.115 6))
            (begin
              (set! tmp.179 tmp.40)
              (set! tmp.179 (- tmp.179 tmp.41))
              (set! rax tmp.179)
              (jump tmp-ra.172 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.172 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.172 rbp rax)))))
    (define L.+.75.9
      ((new-frames ())
       (locals
        (c.81
         tmp.119
         tmp.181
         tmp.38
         tmp.120
         tmp.182
         tmp-ra.173
         tmp.118
         tmp.39
         tmp.180
         tmp.117)))
      (begin
        (set! tmp-ra.173 r15)
        (set! c.81 rdi)
        (set! tmp.38 rsi)
        (set! tmp.39 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.180 tmp.39)
                      (set! tmp.180 (bitwise-and tmp.180 7))
                      (set! tmp.118 tmp.180))
                    (= tmp.118 0))
                (set! tmp.117 14)
                (set! tmp.117 6))
              (!= tmp.117 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.181 tmp.38)
                        (set! tmp.181 (bitwise-and tmp.181 7))
                        (set! tmp.120 tmp.181))
                      (= tmp.120 0))
                  (set! tmp.119 14)
                  (set! tmp.119 6))
                (!= tmp.119 6))
            (begin
              (set! tmp.182 tmp.38)
              (set! tmp.182 (+ tmp.182 tmp.39))
              (set! rax tmp.182)
              (jump tmp-ra.173 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.173 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.173 rbp rax)))))
    (define L.*.76.8
      ((new-frames ())
       (locals
        (c.80
         tmp.123
         tmp.184
         tmp.36
         tmp.124
         tmp.186
         tmp.125
         tmp.185
         tmp-ra.174
         tmp.122
         tmp.37
         tmp.183
         tmp.121)))
      (begin
        (set! tmp-ra.174 r15)
        (set! c.80 rdi)
        (set! tmp.36 rsi)
        (set! tmp.37 rdx)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.183 tmp.37)
                      (set! tmp.183 (bitwise-and tmp.183 7))
                      (set! tmp.122 tmp.183))
                    (= tmp.122 0))
                (set! tmp.121 14)
                (set! tmp.121 6))
              (!= tmp.121 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.184 tmp.36)
                        (set! tmp.184 (bitwise-and tmp.184 7))
                        (set! tmp.124 tmp.184))
                      (= tmp.124 0))
                  (set! tmp.123 14)
                  (set! tmp.123 6))
                (!= tmp.123 6))
            (begin
              (set! tmp.185 tmp.37)
              (set! tmp.185 (arithmetic-shift-right tmp.185 3))
              (set! tmp.125 tmp.185)
              (set! tmp.186 tmp.36)
              (set! tmp.186 (* tmp.186 tmp.125))
              (set! rax tmp.186)
              (jump tmp-ra.174 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.174 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.174 rbp rax)))))
    (define L.fixnum?.77.7
      ((new-frames ()) (locals (c.79 tmp-ra.175 tmp.187 tmp.59 tmp.126)))
      (begin
        (set! tmp-ra.175 r15)
        (set! c.79 rdi)
        (set! tmp.59 rsi)
        (if (begin
              (begin
                (set! tmp.187 tmp.59)
                (set! tmp.187 (bitwise-and tmp.187 7))
                (set! tmp.126 tmp.187))
              (= tmp.126 0))
          (begin (set! rax 14) (jump tmp-ra.175 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.175 rbp rax)))))
    (begin
      (set! tmp-ra.176 r15)
      (begin (set! tmp.127 r12) (set! r12 (+ r12 16)))
      (set! tmp.188 tmp.127)
      (set! tmp.188 (+ tmp.188 2))
      (set! tmp.96 tmp.188)
      (mset! tmp.96 -2 L.fixnum?.77.7)
      (mset! tmp.96 6 8)
      (set! fixnum?.77 tmp.96)
      (begin (set! tmp.128 r12) (set! r12 (+ r12 16)))
      (set! tmp.189 tmp.128)
      (set! tmp.189 (+ tmp.189 2))
      (set! tmp.97 tmp.189)
      (mset! tmp.97 -2 L.*.76.8)
      (mset! tmp.97 6 16)
      (set! *.76 tmp.97)
      (begin (set! tmp.129 r12) (set! r12 (+ r12 16)))
      (set! tmp.190 tmp.129)
      (set! tmp.190 (+ tmp.190 2))
      (set! tmp.98 tmp.190)
      (mset! tmp.98 -2 L.+.75.9)
      (mset! tmp.98 6 16)
      (set! |+.75| tmp.98)
      (begin (set! tmp.130 r12) (set! r12 (+ r12 16)))
      (set! tmp.191 tmp.130)
      (set! tmp.191 (+ tmp.191 2))
      (set! tmp.99 tmp.191)
      (mset! tmp.99 -2 L.-.74.10)
      (mset! tmp.99 6 16)
      (set! |-.74| tmp.99)
      (begin (set! tmp.131 r12) (set! r12 (+ r12 24)))
      (set! tmp.192 tmp.131)
      (set! tmp.192 (+ tmp.192 2))
      (set! tmp.100 tmp.192)
      (mset! tmp.100 -2 L.fun/any12092.4.11)
      (mset! tmp.100 6 0)
      (set! fun/any12092.4 tmp.100)
      (begin (set! tmp.132 r12) (set! r12 (+ r12 24)))
      (set! tmp.193 tmp.132)
      (set! tmp.193 (+ tmp.193 2))
      (set! tmp.101 tmp.193)
      (mset! tmp.101 -2 L.fun/empty12090.5.12)
      (mset! tmp.101 6 0)
      (set! fun/empty12090.5 tmp.101)
      (begin (set! tmp.133 r12) (set! r12 (+ r12 16)))
      (set! tmp.194 tmp.133)
      (set! tmp.194 (+ tmp.194 2))
      (set! tmp.102 tmp.194)
      (mset! tmp.102 -2 L.fun/error12095.6.13)
      (mset! tmp.102 6 0)
      (set! fun/error12095.6 tmp.102)
      (begin (set! tmp.134 r12) (set! r12 (+ r12 24)))
      (set! tmp.195 tmp.134)
      (set! tmp.195 (+ tmp.195 2))
      (set! tmp.103 tmp.195)
      (mset! tmp.103 -2 L.fun/empty12096.7.14)
      (mset! tmp.103 6 0)
      (set! fun/empty12096.7 tmp.103)
      (begin (set! tmp.135 r12) (set! r12 (+ r12 16)))
      (set! tmp.196 tmp.135)
      (set! tmp.196 (+ tmp.196 2))
      (set! tmp.104 tmp.196)
      (mset! tmp.104 -2 L.fun/empty12091.8.15)
      (mset! tmp.104 6 0)
      (set! fun/empty12091.8 tmp.104)
      (begin (set! tmp.136 r12) (set! r12 (+ r12 16)))
      (set! tmp.197 tmp.136)
      (set! tmp.197 (+ tmp.197 2))
      (set! tmp.105 tmp.197)
      (mset! tmp.105 -2 L.fun/any12093.9.16)
      (mset! tmp.105 6 0)
      (set! fun/any12093.9 tmp.105)
      (begin (set! tmp.137 r12) (set! r12 (+ r12 16)))
      (set! tmp.198 tmp.137)
      (set! tmp.198 (+ tmp.198 2))
      (set! tmp.106 tmp.198)
      (mset! tmp.106 -2 L.fun/void12099.10.17)
      (mset! tmp.106 6 0)
      (set! fun/void12099.10 tmp.106)
      (begin (set! tmp.138 r12) (set! r12 (+ r12 24)))
      (set! tmp.199 tmp.138)
      (set! tmp.199 (+ tmp.199 2))
      (set! tmp.107 tmp.199)
      (mset! tmp.107 -2 L.fun/error12088.11.18)
      (mset! tmp.107 6 0)
      (set! fun/error12088.11 tmp.107)
      (begin (set! tmp.139 r12) (set! r12 (+ r12 16)))
      (set! tmp.200 tmp.139)
      (set! tmp.200 (+ tmp.200 2))
      (set! tmp.108 tmp.200)
      (mset! tmp.108 -2 L.fun/empty12097.12.19)
      (mset! tmp.108 6 0)
      (set! fun/empty12097.12 tmp.108)
      (begin (set! tmp.140 r12) (set! r12 (+ r12 16)))
      (set! tmp.201 tmp.140)
      (set! tmp.201 (+ tmp.201 2))
      (set! tmp.109 tmp.201)
      (mset! tmp.109 -2 L.fun/error12089.13.20)
      (mset! tmp.109 6 0)
      (set! fun/error12089.13 tmp.109)
      (begin (set! tmp.141 r12) (set! r12 (+ r12 24)))
      (set! tmp.202 tmp.141)
      (set! tmp.202 (+ tmp.202 2))
      (set! tmp.110 tmp.202)
      (mset! tmp.110 -2 L.fun/error12094.14.21)
      (mset! tmp.110 6 0)
      (set! fun/error12094.14 tmp.110)
      (begin (set! tmp.142 r12) (set! r12 (+ r12 24)))
      (set! tmp.203 tmp.142)
      (set! tmp.203 (+ tmp.203 2))
      (set! tmp.111 tmp.203)
      (mset! tmp.111 -2 L.fun/void12098.15.22)
      (mset! tmp.111 6 0)
      (set! fun/void12098.15 tmp.111)
      (mset! fun/any12092.4 14 fun/any12093.9)
      (mset! fun/empty12090.5 14 fun/empty12091.8)
      (mset! fun/empty12096.7 14 fun/empty12097.12)
      (mset! fun/error12088.11 14 fun/error12089.13)
      (mset! fun/error12094.14 14 fun/error12095.6)
      (mset! fun/void12098.15 14 fun/void12099.10)
      (begin (set! tmp.143 r12) (set! r12 (+ r12 24)))
      (set! tmp.204 tmp.143)
      (set! tmp.204 (+ tmp.204 2))
      (set! tmp.112 tmp.204)
      (mset! tmp.112 -2 L.lam.78.23)
      (mset! tmp.112 6 0)
      (set! lam.78 tmp.112)
      (mset! lam.78 14 fun/error12088.11)
      (set! procedure0.21 lam.78)
      (return-point L.rp.24
        (begin
          (set! rdx 1328)
          (set! rsi 432)
          (set! rdi |-.74|)
          (set! r15 L.rp.24)
          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
      (set! tmp.146 rax)
      (return-point L.rp.25
        (begin
          (set! rdx 952)
          (set! rsi 1168)
          (set! rdi |+.75|)
          (set! r15 L.rp.25)
          (jump L.+.75.9 rbp r15 rdi rsi rdx)))
      (set! tmp.147 rax)
      (return-point L.rp.26
        (begin
          (set! rdx tmp.147)
          (set! rsi tmp.146)
          (set! rdi |-.74|)
          (set! r15 L.rp.26)
          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
      (set! tmp.145 rax)
      (return-point L.rp.27
        (begin
          (set! rdx 168)
          (set! rsi 1472)
          (set! rdi |-.74|)
          (set! r15 L.rp.27)
          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
      (set! tmp.149 rax)
      (return-point L.rp.28
        (begin
          (set! rdx 2024)
          (set! rsi 64)
          (set! rdi *.76)
          (set! r15 L.rp.28)
          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
      (set! tmp.150 rax)
      (return-point L.rp.29
        (begin
          (set! rdx tmp.150)
          (set! rsi tmp.149)
          (set! rdi |-.74|)
          (set! r15 L.rp.29)
          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
      (set! tmp.148 rax)
      (return-point L.rp.30
        (begin
          (set! rdx tmp.148)
          (set! rsi tmp.145)
          (set! rdi *.76)
          (set! r15 L.rp.30)
          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
      (set! tmp.144 rax)
      (return-point L.rp.31
        (begin
          (set! rdx 760)
          (set! rsi 1672)
          (set! rdi |-.74|)
          (set! r15 L.rp.31)
          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
      (set! tmp.153 rax)
      (return-point L.rp.32
        (begin
          (set! rdx 1968)
          (set! rsi 240)
          (set! rdi |+.75|)
          (set! r15 L.rp.32)
          (jump L.+.75.9 rbp r15 rdi rsi rdx)))
      (set! tmp.154 rax)
      (return-point L.rp.33
        (begin
          (set! rdx tmp.154)
          (set! rsi tmp.153)
          (set! rdi |+.75|)
          (set! r15 L.rp.33)
          (jump L.+.75.9 rbp r15 rdi rsi rdx)))
      (set! tmp.152 rax)
      (return-point L.rp.34
        (begin
          (set! rdx 696)
          (set! rsi 544)
          (set! rdi |+.75|)
          (set! r15 L.rp.34)
          (jump L.+.75.9 rbp r15 rdi rsi rdx)))
      (set! tmp.156 rax)
      (return-point L.rp.35
        (begin
          (set! rdx 1904)
          (set! rsi 1528)
          (set! rdi |-.74|)
          (set! r15 L.rp.35)
          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
      (set! tmp.157 rax)
      (return-point L.rp.36
        (begin
          (set! rdx tmp.157)
          (set! rsi tmp.156)
          (set! rdi *.76)
          (set! r15 L.rp.36)
          (jump L.*.76.8 rbp r15 rdi rsi rdx)))
      (set! tmp.155 rax)
      (return-point L.rp.37
        (begin
          (set! rdx tmp.155)
          (set! rsi tmp.152)
          (set! rdi |-.74|)
          (set! r15 L.rp.37)
          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
      (set! tmp.151 rax)
      (return-point L.rp.38
        (begin
          (set! rdx tmp.151)
          (set! rsi tmp.144)
          (set! rdi |-.74|)
          (set! r15 L.rp.38)
          (jump L.-.74.10 rbp r15 rdi rsi rdx)))
      (set! fixnum1.20 rax)
      (return-point L.rp.39
        (begin
          (set! rdi fun/empty12090.5)
          (set! r15 L.rp.39)
          (jump L.fun/empty12090.5.12 rbp r15 rdi)))
      (set! empty2.19 rax)
      (return-point L.rp.40
        (begin
          (set! rdi fun/any12092.4)
          (set! r15 L.rp.40)
          (jump L.fun/any12092.4.11 rbp r15 rdi)))
      (set! tmp.158 rax)
      (return-point L.rp.41
        (begin
          (set! rsi tmp.158)
          (set! rdi fixnum?.77)
          (set! r15 L.rp.41)
          (jump L.fixnum?.77.7 rbp r15 rdi rsi)))
      (set! boolean3.18 rax)
      (return-point L.rp.42
        (begin
          (set! rdi fun/error12094.14)
          (set! r15 L.rp.42)
          (jump L.fun/error12094.14.21 rbp r15 rdi)))
      (set! error4.17 rax)
      (return-point L.rp.43
        (begin
          (set! rdi fun/empty12096.7)
          (set! r15 L.rp.43)
          (jump L.fun/empty12096.7.14 rbp r15 rdi)))
      (set! empty5.16 rax)
      (set! rdi fun/void12098.15)
      (set! r15 tmp-ra.176)
      (jump L.fun/void12098.15.22 rbp r15 rdi))))
