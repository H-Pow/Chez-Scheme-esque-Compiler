#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v8
         "../expose-allocation-pointer.rkt")
(define (fail-if-invalid p)
  (when (not (asm-pred-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "asm-pred-lang-v8"
      " program")))
  p)
(define (check-by-interp p)
  (interp-asm-alloc-lang-v8 p)
  (interp-asm-pred-lang-v8 (fail-if-invalid (expose-allocation-pointer p))))

(check-by-interp
 '(module
    ((new-frames ()))
    (begin (set! tmp-ra.50 r15) (set! rax 25390) (jump tmp-ra.50 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()))
    (begin (set! tmp-ra.50 r15) (set! rax 48958) (jump tmp-ra.50 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/ascii-char8383.4
      ((new-frames ()))
      (begin (set! tmp-ra.50 r15) (set! rax 25390) (jump tmp-ra.50 rbp rax)))
    (begin
      (set! tmp-ra.51 r15)
      (set! r15 tmp-ra.51)
      (jump L.fun/ascii-char8383.4 rbp r15))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/error8386.4
      ((new-frames ()))
      (begin (set! tmp-ra.50 r15) (set! rax 20030) (jump tmp-ra.50 rbp rax)))
    (begin
      (set! tmp-ra.51 r15)
      (set! r15 tmp-ra.51)
      (jump L.fun/error8386.4 rbp r15))))
(check-by-interp
 '(module
    ((new-frames ()))
    (begin
      (set! tmp-ra.51 r15)
      (set! empty0.1 22)
      (set! rax 30)
      (jump tmp-ra.51 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 6) (!= tmp.51 6))
        (begin (set! rax 50494) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 57662) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.fun/boolean8393.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.52 r15)
        (set! oprand0.1 rdi)
        (set! rax 14)
        (jump tmp-ra.52 rbp rax)))
    (begin
      (set! tmp-ra.53 r15)
      (if (begin (set! tmp.54 14) (!= tmp.54 6))
        (set! tmp.51 928)
        (set! tmp.51 1456))
      (set! rdi tmp.51)
      (set! r15 tmp-ra.53)
      (jump L.fun/boolean8393.4 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (())))
    (define L.+.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! tmp.17 rdi)
        (set! tmp.18 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.60 tmp.18)
                      (set! tmp.60 (bitwise-and tmp.60 7))
                      (set! tmp.52 tmp.60))
                    (= tmp.52 0))
                (set! tmp.51 14)
                (set! tmp.51 6))
              (!= tmp.51 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.61 tmp.17)
                        (set! tmp.61 (bitwise-and tmp.61 7))
                        (set! tmp.54 tmp.61))
                      (= tmp.54 0))
                  (set! tmp.53 14)
                  (set! tmp.53 6))
                (!= tmp.53 6))
            (begin
              (set! tmp.62 tmp.17)
              (set! tmp.62 (+ tmp.62 tmp.18))
              (set! rax tmp.62)
              (jump tmp-ra.57 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.57 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.57 rbp rax)))))
    (define L.fun/fixnum8396.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! oprand0.1 rdi)
        (set! rax 1928)
        (jump tmp-ra.58 rbp rax)))
    (begin
      (set! tmp-ra.59 r15)
      (if (begin (set! tmp.63 14) (!= tmp.63 6))
        (set! tmp.55 592)
        (set! tmp.55 776))
      (return-point L.rp.7
        (begin
          (set! rdi 30)
          (set! r15 L.rp.7)
          (jump L.fun/fixnum8396.4 rbp r15 rdi)))
      (set! tmp.56 rax)
      (set! rsi tmp.56)
      (set! rdi tmp.55)
      (set! r15 tmp-ra.59)
      (jump L.+.6 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (())))
    (define L.*.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! tmp.15 rdi)
        (set! tmp.16 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.60 tmp.16)
                      (set! tmp.60 (bitwise-and tmp.60 7))
                      (set! tmp.52 tmp.60))
                    (= tmp.52 0))
                (set! tmp.51 14)
                (set! tmp.51 6))
              (!= tmp.51 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.61 tmp.15)
                        (set! tmp.61 (bitwise-and tmp.61 7))
                        (set! tmp.54 tmp.61))
                      (= tmp.54 0))
                  (set! tmp.53 14)
                  (set! tmp.53 6))
                (!= tmp.53 6))
            (begin
              (set! tmp.62 tmp.16)
              (set! tmp.62 (arithmetic-shift-right tmp.62 3))
              (set! tmp.55 tmp.62)
              (set! tmp.63 tmp.15)
              (set! tmp.63 (* tmp.63 tmp.55))
              (set! rax tmp.63)
              (jump tmp-ra.57 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.57 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.57 rbp rax)))))
    (define L.fun/void8399.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! oprand0.1 rdi)
        (set! rax 30)
        (jump tmp-ra.58 rbp rax)))
    (begin
      (set! tmp-ra.59 r15)
      (return-point L.rp.7
        (begin
          (set! rsi 1200)
          (set! rdi 1080)
          (set! r15 L.rp.7)
          (jump L.*.6 rbp r15 rdi rsi)))
      (set! tmp.56 rax)
      (set! rdi tmp.56)
      (set! r15 tmp-ra.59)
      (jump L.fun/void8399.4 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames ()))
    (begin
      (set! tmp-ra.52 r15)
      (set! empty0.2 22)
      (set! empty1.1 22)
      (set! rax 30)
      (jump tmp-ra.52 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 6) (!= tmp.51 6))
        (begin (set! rax 48) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 1600) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames (())))
    (define L.fun/error8463.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.62 r15)
        (set! oprand0.2 rdi)
        (set! oprand1.1 rsi)
        (set! rax oprand1.1)
        (jump tmp-ra.62 rbp rax)))
    (begin
      (set! tmp-ra.63 r15)
      (set! ascii-char0.5 25390)
      (set! ascii-char1.4 25390)
      (set! error2.3 62782)
      (set! tmp.58 error2.3)
      (set! ascii-char0.8 25390)
      (set! boolean1.7 6)
      (set! void2.6 30)
      (set! tmp.60 56894)
      (if (begin (set! tmp.64 6) (!= tmp.64 6))
        (set! tmp.61 318)
        (set! tmp.61 37182))
      (return-point L.rp.6
        (begin
          (set! rsi tmp.61)
          (set! rdi tmp.60)
          (set! r15 L.rp.6)
          (jump L.fun/error8463.4 rbp r15 rdi rsi)))
      (set! tmp.59 rax)
      (set! rsi tmp.59)
      (set! rdi tmp.58)
      (set! r15 tmp-ra.63)
      (jump L.fun/error8463.4 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (())))
    (define L.*.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (set! tmp.18 rdi)
        (set! tmp.19 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.64 tmp.19)
                      (set! tmp.64 (bitwise-and tmp.64 7))
                      (set! tmp.55 tmp.64))
                    (= tmp.55 0))
                (set! tmp.54 14)
                (set! tmp.54 6))
              (!= tmp.54 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.65 tmp.18)
                        (set! tmp.65 (bitwise-and tmp.65 7))
                        (set! tmp.57 tmp.65))
                      (= tmp.57 0))
                  (set! tmp.56 14)
                  (set! tmp.56 6))
                (!= tmp.56 6))
            (begin
              (set! tmp.66 tmp.19)
              (set! tmp.66 (arithmetic-shift-right tmp.66 3))
              (set! tmp.58 tmp.66)
              (set! tmp.67 tmp.18)
              (set! tmp.67 (* tmp.67 tmp.58))
              (set! rax tmp.67)
              (jump tmp-ra.60 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.60 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.60 rbp rax)))))
    (define L.fun/fixnum8490.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.61 r15)
        (set! oprand0.2 rdi)
        (set! oprand1.1 rsi)
        (set! rax 168)
        (jump tmp-ra.61 rbp rax)))
    (define L.fun/boolean8489.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.62 r15)
        (set! oprand0.4 rdi)
        (set! oprand1.3 rsi)
        (set! rax 6)
        (jump tmp-ra.62 rbp rax)))
    (begin
      (set! tmp-ra.63 r15)
      (if (begin
            (begin
              (return-point L.rp.8
                (begin
                  (set! rsi 608)
                  (set! rdi 63550)
                  (set! r15 L.rp.8)
                  (jump L.fun/boolean8489.5 rbp r15 rdi rsi)))
              (set! tmp.59 rax))
            (!= tmp.59 6))
        (begin
          (set! rsi 14)
          (set! rdi 30)
          (set! r15 tmp-ra.63)
          (jump L.fun/fixnum8490.4 rbp r15 rdi rsi))
        (begin
          (set! rsi 2008)
          (set! rdi 1712)
          (set! r15 tmp-ra.63)
          (jump L.*.7 rbp r15 rdi rsi))))))
(check-by-interp
 '(module
    ((new-frames (() () ())))
    (define L.fun/empty8497.4
      ((new-frames ()))
      (begin (set! tmp-ra.53 r15) (set! rax 22) (jump tmp-ra.53 rbp rax)))
    (define L.fun/void8496.5
      ((new-frames ()))
      (begin (set! tmp-ra.54 r15) (set! rax 30) (jump tmp-ra.54 rbp rax)))
    (define L.fun/ascii-char8498.6
      ((new-frames ()))
      (begin (set! tmp-ra.55 r15) (set! rax 25390) (jump tmp-ra.55 rbp rax)))
    (begin
      (set! tmp-ra.56 r15)
      (return-point L.rp.8
        (begin (set! r15 L.rp.8) (jump L.fun/void8496.5 rbp r15)))
      (set! void0.3 rax)
      (return-point L.rp.9
        (begin (set! r15 L.rp.9) (jump L.fun/empty8497.4 rbp r15)))
      (set! empty1.2 rax)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/ascii-char8498.6 rbp r15)))
      (set! ascii-char2.1 rax)
      (set! rax void0.3)
      (jump tmp-ra.56 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.*.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.63 tmp.20)
                      (set! tmp.63 (bitwise-and tmp.63 7))
                      (set! tmp.56 tmp.63))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.64 tmp.19)
                        (set! tmp.64 (bitwise-and tmp.64 7))
                        (set! tmp.58 tmp.64))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.65 tmp.20)
              (set! tmp.65 (arithmetic-shift-right tmp.65 3))
              (set! tmp.59 tmp.65)
              (set! tmp.66 tmp.19)
              (set! tmp.66 (* tmp.66 tmp.59))
              (set! rax tmp.66)
              (jump tmp-ra.60 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.60 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.60 rbp rax)))))
    (define L.fun/fixnum8501.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.61 r15)
        (set! oprand0.2 rdi)
        (set! oprand1.1 rsi)
        (set! rax 184)
        (jump tmp-ra.61 rbp rax)))
    (begin
      (set! tmp-ra.62 r15)
      (if (begin
            (set! void0.5 30)
            (set! error1.4 41534)
            (set! empty2.3 22)
            (begin (set! tmp.67 14) (!= tmp.67 6)))
        (begin
          (set! rsi 984)
          (set! rdi 208)
          (set! r15 tmp-ra.62)
          (jump L.*.6 rbp r15 rdi rsi))
        (begin
          (set! rsi 30)
          (set! rdi 14)
          (set! r15 tmp-ra.62)
          (jump L.fun/fixnum8501.4 rbp r15 rdi rsi))))))
(check-by-interp
 '(module
    ((new-frames ()))
    (define L.+.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.59 tmp.20)
                      (set! tmp.59 (bitwise-and tmp.59 7))
                      (set! tmp.54 tmp.59))
                    (= tmp.54 0))
                (set! tmp.53 14)
                (set! tmp.53 6))
              (!= tmp.53 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.60 tmp.19)
                        (set! tmp.60 (bitwise-and tmp.60 7))
                        (set! tmp.56 tmp.60))
                      (= tmp.56 0))
                  (set! tmp.55 14)
                  (set! tmp.55 6))
                (!= tmp.55 6))
            (begin
              (set! tmp.61 tmp.19)
              (set! tmp.61 (+ tmp.61 tmp.20))
              (set! rax tmp.61)
              (jump tmp-ra.57 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.57 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.57 rbp rax)))))
    (begin
      (set! tmp-ra.58 r15)
      (if (begin
            (set! void0.3 30)
            (set! ascii-char1.2 25390)
            (set! fixnum2.1 1616)
            (begin (set! tmp.62 14) (!= tmp.62 6)))
        (begin
          (set! rsi 1640)
          (set! rdi 520)
          (set! r15 tmp-ra.58)
          (jump L.+.5 rbp r15 rdi rsi))
        (begin
          (set! rsi 392)
          (set! rdi 24)
          (set! r15 tmp-ra.58)
          (jump L.+.5 rbp r15 rdi rsi))))))
(check-by-interp
 '(module
    ((new-frames (() () ())))
    (define L.+.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.63 tmp.20)
                      (set! tmp.63 (bitwise-and tmp.63 7))
                      (set! tmp.54 tmp.63))
                    (= tmp.54 0))
                (set! tmp.53 14)
                (set! tmp.53 6))
              (!= tmp.53 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.64 tmp.19)
                        (set! tmp.64 (bitwise-and tmp.64 7))
                        (set! tmp.56 tmp.64))
                      (= tmp.56 0))
                  (set! tmp.55 14)
                  (set! tmp.55 6))
                (!= tmp.55 6))
            (begin
              (set! tmp.65 tmp.19)
              (set! tmp.65 (+ tmp.65 tmp.20))
              (set! rax tmp.65)
              (jump tmp-ra.58 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.58 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.58 rbp rax)))))
    (define L.pair?.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.66 tmp.46)
                (set! tmp.66 (bitwise-and tmp.66 7))
                (set! tmp.57 tmp.66))
              (= tmp.57 1))
          (begin (set! rax 14) (jump tmp-ra.59 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.59 rbp rax)))))
    (define L.fun/ascii-char8555.4
      ((new-frames ()))
      (begin (set! tmp-ra.60 r15) (set! rax 25390) (jump tmp-ra.60 rbp rax)))
    (define L.fun/void8554.5
      ((new-frames ()))
      (begin (set! tmp-ra.61 r15) (set! rax 30) (jump tmp-ra.61 rbp rax)))
    (begin
      (set! tmp-ra.62 r15)
      (return-point L.rp.9
        (begin
          (set! rdi 12606)
          (set! r15 L.rp.9)
          (jump L.pair?.7 rbp r15 rdi)))
      (set! boolean0.3 rax)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/void8554.5 rbp r15)))
      (set! void1.2 rax)
      (return-point L.rp.11
        (begin
          (set! rsi 1552)
          (set! rdi 736)
          (set! r15 L.rp.11)
          (jump L.+.8 rbp r15 rdi rsi)))
      (set! fixnum2.1 rax)
      (set! r15 tmp-ra.62)
      (jump L.fun/ascii-char8555.4 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () ())))
    (define L.+.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.62 tmp.20)
                      (set! tmp.62 (bitwise-and tmp.62 7))
                      (set! tmp.54 tmp.62))
                    (= tmp.54 0))
                (set! tmp.53 14)
                (set! tmp.53 6))
              (!= tmp.53 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.63 tmp.19)
                        (set! tmp.63 (bitwise-and tmp.63 7))
                        (set! tmp.56 tmp.63))
                      (= tmp.56 0))
                  (set! tmp.55 14)
                  (set! tmp.55 6))
                (!= tmp.55 6))
            (begin
              (set! tmp.64 tmp.19)
              (set! tmp.64 (+ tmp.64 tmp.20))
              (set! rax tmp.64)
              (jump tmp-ra.58 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.58 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.58 rbp rax)))))
    (define L.error?.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! tmp.45 rdi)
        (if (begin
              (begin
                (set! tmp.65 tmp.45)
                (set! tmp.65 (bitwise-and tmp.65 255))
                (set! tmp.57 tmp.65))
              (= tmp.57 62))
          (begin (set! rax 14) (jump tmp-ra.59 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.59 rbp rax)))))
    (define L.fun/empty8590.4
      ((new-frames ()))
      (begin (set! tmp-ra.60 r15) (set! rax 22) (jump tmp-ra.60 rbp rax)))
    (begin
      (set! tmp-ra.61 r15)
      (return-point L.rp.8
        (begin (set! r15 L.rp.8) (jump L.fun/empty8590.4 rbp r15)))
      (set! empty0.3 rax)
      (return-point L.rp.9
        (begin (set! rdi 30) (set! r15 L.rp.9) (jump L.error?.6 rbp r15 rdi)))
      (set! boolean1.2 rax)
      (return-point L.rp.10
        (begin
          (set! rsi 1496)
          (set! rdi 1392)
          (set! r15 L.rp.10)
          (jump L.+.7 rbp r15 rdi rsi)))
      (set! fixnum2.1 rax)
      (set! rax fixnum2.1)
      (jump tmp-ra.61 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ())))
    (define L.*.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.65 r15)
        (set! tmp.18 rdi)
        (set! tmp.19 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.71 tmp.19)
                      (set! tmp.71 (bitwise-and tmp.71 7))
                      (set! tmp.55 tmp.71))
                    (= tmp.55 0))
                (set! tmp.54 14)
                (set! tmp.54 6))
              (!= tmp.54 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.72 tmp.18)
                        (set! tmp.72 (bitwise-and tmp.72 7))
                        (set! tmp.57 tmp.72))
                      (= tmp.57 0))
                  (set! tmp.56 14)
                  (set! tmp.56 6))
                (!= tmp.56 6))
            (begin
              (set! tmp.73 tmp.19)
              (set! tmp.73 (arithmetic-shift-right tmp.73 3))
              (set! tmp.58 tmp.73)
              (set! tmp.74 tmp.18)
              (set! tmp.74 (* tmp.74 tmp.58))
              (set! rax tmp.74)
              (jump tmp-ra.65 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.65 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.65 rbp rax)))))
    (define L.-.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.66 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.75 tmp.23)
                      (set! tmp.75 (bitwise-and tmp.75 7))
                      (set! tmp.60 tmp.75))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.76 tmp.22)
                        (set! tmp.76 (bitwise-and tmp.76 7))
                        (set! tmp.62 tmp.76))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.77 tmp.22)
              (set! tmp.77 (- tmp.77 tmp.23))
              (set! rax tmp.77)
              (jump tmp-ra.66 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.66 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.66 rbp rax)))))
    (define L.fun/void8641.4
      ((new-frames ()))
      (begin (set! tmp-ra.67 r15) (set! rax 30) (jump tmp-ra.67 rbp rax)))
    (define L.fun/empty8642.5
      ((new-frames ()))
      (begin (set! tmp-ra.68 r15) (set! rax 22) (jump tmp-ra.68 rbp rax)))
    (define L.fun/void8643.6
      ((new-frames ()))
      (begin (set! tmp-ra.69 r15) (set! rax 30) (jump tmp-ra.69 rbp rax)))
    (begin
      (set! tmp-ra.70 r15)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/void8641.4 rbp r15)))
      (set! void0.4 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/empty8642.5 rbp r15)))
      (set! empty1.3 rax)
      (return-point L.rp.12
        (begin
          (set! rsi 1936)
          (set! rdi 1640)
          (set! r15 L.rp.12)
          (jump L.-.8 rbp r15 rdi rsi)))
      (set! tmp.63 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 904)
          (set! rdi 1640)
          (set! r15 L.rp.13)
          (jump L.*.9 rbp r15 rdi rsi)))
      (set! tmp.64 rax)
      (return-point L.rp.14
        (begin
          (set! rsi tmp.64)
          (set! rdi tmp.63)
          (set! r15 L.rp.14)
          (jump L.-.8 rbp r15 rdi rsi)))
      (set! fixnum2.2 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/void8643.6 rbp r15)))
      (set! void3.1 rax)
      (set! rax void3.1)
      (jump tmp-ra.70 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ())))
    (define L.-.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.65 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.72 tmp.23)
                      (set! tmp.72 (bitwise-and tmp.72 7))
                      (set! tmp.55 tmp.72))
                    (= tmp.55 0))
                (set! tmp.54 14)
                (set! tmp.54 6))
              (!= tmp.54 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.73 tmp.22)
                        (set! tmp.73 (bitwise-and tmp.73 7))
                        (set! tmp.57 tmp.73))
                      (= tmp.57 0))
                  (set! tmp.56 14)
                  (set! tmp.56 6))
                (!= tmp.56 6))
            (begin
              (set! tmp.74 tmp.22)
              (set! tmp.74 (- tmp.74 tmp.23))
              (set! rax tmp.74)
              (jump tmp-ra.65 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.65 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.65 rbp rax)))))
    (define L.*.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.66 r15)
        (set! tmp.18 rdi)
        (set! tmp.19 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.75 tmp.19)
                      (set! tmp.75 (bitwise-and tmp.75 7))
                      (set! tmp.59 tmp.75))
                    (= tmp.59 0))
                (set! tmp.58 14)
                (set! tmp.58 6))
              (!= tmp.58 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.76 tmp.18)
                        (set! tmp.76 (bitwise-and tmp.76 7))
                        (set! tmp.61 tmp.76))
                      (= tmp.61 0))
                  (set! tmp.60 14)
                  (set! tmp.60 6))
                (!= tmp.60 6))
            (begin
              (set! tmp.77 tmp.19)
              (set! tmp.77 (arithmetic-shift-right tmp.77 3))
              (set! tmp.62 tmp.77)
              (set! tmp.78 tmp.18)
              (set! tmp.78 (* tmp.78 tmp.62))
              (set! rax tmp.78)
              (jump tmp-ra.66 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.66 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.66 rbp rax)))))
    (define L.fun/error9361.4
      ((new-frames ()))
      (begin (set! tmp-ra.67 r15) (set! rax 14142) (jump tmp-ra.67 rbp rax)))
    (define L.fun/empty9358.5
      ((new-frames ()))
      (begin (set! tmp-ra.68 r15) (set! rax 22) (jump tmp-ra.68 rbp rax)))
    (define L.fun/void9360.6
      ((new-frames ()))
      (begin (set! tmp-ra.69 r15) (set! rax 30) (jump tmp-ra.69 rbp rax)))
    (define L.fun/empty9359.7
      ((new-frames ()))
      (begin (set! tmp-ra.70 r15) (set! rax 22) (jump tmp-ra.70 rbp rax)))
    (begin
      (set! tmp-ra.71 r15)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/empty9358.5 rbp r15)))
      (set! empty0.4 rax)
      (return-point L.rp.12
        (begin
          (set! rsi 1320)
          (set! rdi 1456)
          (set! r15 L.rp.12)
          (jump L.*.9 rbp r15 rdi rsi)))
      (set! tmp.63 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 8)
          (set! rdi 104)
          (set! r15 L.rp.13)
          (jump L.*.9 rbp r15 rdi rsi)))
      (set! tmp.64 rax)
      (return-point L.rp.14
        (begin
          (set! rsi tmp.64)
          (set! rdi tmp.63)
          (set! r15 L.rp.14)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! fixnum1.3 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/empty9359.7 rbp r15)))
      (set! empty2.2 rax)
      (return-point L.rp.16
        (begin (set! r15 L.rp.16) (jump L.fun/void9360.6 rbp r15)))
      (set! void3.1 rax)
      (set! r15 tmp-ra.71)
      (jump L.fun/error9361.4 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () ())))
    (define L.-.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! tmp.39 rdi)
        (set! tmp.40 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.101 tmp.40)
                      (set! tmp.101 (bitwise-and tmp.101 7))
                      (set! tmp.72 tmp.101))
                    (= tmp.72 0))
                (set! tmp.71 14)
                (set! tmp.71 6))
              (!= tmp.71 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.102 tmp.39)
                        (set! tmp.102 (bitwise-and tmp.102 7))
                        (set! tmp.74 tmp.102))
                      (= tmp.74 0))
                  (set! tmp.73 14)
                  (set! tmp.73 6))
                (!= tmp.73 6))
            (begin
              (set! tmp.103 tmp.39)
              (set! tmp.103 (- tmp.103 tmp.40))
              (set! rax tmp.103)
              (jump tmp-ra.94 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.94 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.94 rbp rax)))))
    (define L.+.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! tmp.37 rdi)
        (set! tmp.38 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.38)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.76 tmp.104))
                    (= tmp.76 0))
                (set! tmp.75 14)
                (set! tmp.75 6))
              (!= tmp.75 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.37)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.78 tmp.105))
                      (= tmp.78 0))
                  (set! tmp.77 14)
                  (set! tmp.77 6))
                (!= tmp.77 6))
            (begin
              (set! tmp.106 tmp.37)
              (set! tmp.106 (+ tmp.106 tmp.38))
              (set! rax tmp.106)
              (jump tmp-ra.95 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.95 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.95 rbp rax)))))
    (define L.*.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.96 r15)
        (set! tmp.35 rdi)
        (set! tmp.36 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.107 tmp.36)
                      (set! tmp.107 (bitwise-and tmp.107 7))
                      (set! tmp.80 tmp.107))
                    (= tmp.80 0))
                (set! tmp.79 14)
                (set! tmp.79 6))
              (!= tmp.79 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.108 tmp.35)
                        (set! tmp.108 (bitwise-and tmp.108 7))
                        (set! tmp.82 tmp.108))
                      (= tmp.82 0))
                  (set! tmp.81 14)
                  (set! tmp.81 6))
                (!= tmp.81 6))
            (begin
              (set! tmp.109 tmp.36)
              (set! tmp.109 (arithmetic-shift-right tmp.109 3))
              (set! tmp.83 tmp.109)
              (set! tmp.110 tmp.35)
              (set! tmp.110 (* tmp.110 tmp.83))
              (set! rax tmp.110)
              (jump tmp-ra.96 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.96 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.96 rbp rax)))))
    (define L.fun/void10119.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.97 r15)
        (set! oprand0.3 rdi)
        (set! oprand1.2 rsi)
        (set! oprand2.1 rdx)
        (set! rax 30)
        (jump tmp-ra.97 rbp rax)))
    (define L.fun/fixnum10117.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.98 r15)
        (set! oprand0.6 rdi)
        (set! oprand1.5 rsi)
        (set! oprand2.4 rdx)
        (set! rax oprand1.5)
        (jump tmp-ra.98 rbp rax)))
    (define L.fun/fixnum10118.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.99 r15)
        (set! oprand0.9 rdi)
        (set! oprand1.8 rsi)
        (set! oprand2.7 rdx)
        (set! rax 1640)
        (jump tmp-ra.99 rbp rax)))
    (begin
      (set! tmp-ra.100 r15)
      (if (begin (set! tmp.111 14) (!= tmp.111 6))
        (set! tmp.85 27710)
        (set! tmp.85 36158))
      (set! void0.13 30)
      (set! fixnum1.12 232)
      (set! boolean2.11 14)
      (set! fixnum3.10 128)
      (set! tmp.86 fixnum1.12)
      (set! empty0.17 22)
      (set! boolean1.16 6)
      (set! void2.15 30)
      (set! void3.14 30)
      (set! tmp.87 30)
      (return-point L.rp.11
        (begin
          (set! rdx tmp.87)
          (set! rsi tmp.86)
          (set! rdi tmp.85)
          (set! r15 L.rp.11)
          (jump L.fun/fixnum10117.5 rbp r15 rdi rsi rdx)))
      (set! tmp.84 rax)
      (if (begin (set! tmp.112 6) (!= tmp.112 6))
        (set! tmp.89 760)
        (set! tmp.89 424))
      (return-point L.rp.12
        (begin
          (set! rdx 22)
          (set! rsi 25390)
          (set! rdi 6)
          (set! r15 L.rp.12)
          (jump L.fun/void10119.4 rbp r15 rdi rsi rdx)))
      (set! tmp.91 rax)
      (set! boolean0.21 14)
      (set! empty1.20 22)
      (set! boolean2.19 14)
      (set! boolean3.18 14)
      (set! tmp.92 26942)
      (return-point L.rp.13
        (begin
          (set! rsi 1496)
          (set! rdi 296)
          (set! r15 L.rp.13)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.14
        (begin
          (set! rdx tmp.93)
          (set! rsi tmp.92)
          (set! rdi tmp.91)
          (set! r15 L.rp.14)
          (jump L.fun/fixnum10118.6 rbp r15 rdi rsi rdx)))
      (set! tmp.90 rax)
      (return-point L.rp.15
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.89)
          (set! r15 L.rp.15)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (set! rsi tmp.88)
      (set! rdi tmp.84)
      (set! r15 tmp-ra.100)
      (jump L.-.10 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () ())))
    (define L.+.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.71 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.77 tmp.21)
                      (set! tmp.77 (bitwise-and tmp.77 7))
                      (set! tmp.55 tmp.77))
                    (= tmp.55 0))
                (set! tmp.54 14)
                (set! tmp.54 6))
              (!= tmp.54 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.78 tmp.20)
                        (set! tmp.78 (bitwise-and tmp.78 7))
                        (set! tmp.57 tmp.78))
                      (= tmp.57 0))
                  (set! tmp.56 14)
                  (set! tmp.56 6))
                (!= tmp.56 6))
            (begin
              (set! tmp.79 tmp.20)
              (set! tmp.79 (+ tmp.79 tmp.21))
              (set! rax tmp.79)
              (jump tmp-ra.71 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.71 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.71 rbp rax)))))
    (define L.*.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.72 r15)
        (set! tmp.18 rdi)
        (set! tmp.19 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.80 tmp.19)
                      (set! tmp.80 (bitwise-and tmp.80 7))
                      (set! tmp.59 tmp.80))
                    (= tmp.59 0))
                (set! tmp.58 14)
                (set! tmp.58 6))
              (!= tmp.58 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.81 tmp.18)
                        (set! tmp.81 (bitwise-and tmp.81 7))
                        (set! tmp.61 tmp.81))
                      (= tmp.61 0))
                  (set! tmp.60 14)
                  (set! tmp.60 6))
                (!= tmp.60 6))
            (begin
              (set! tmp.82 tmp.19)
              (set! tmp.82 (arithmetic-shift-right tmp.82 3))
              (set! tmp.62 tmp.82)
              (set! tmp.83 tmp.18)
              (set! tmp.83 (* tmp.83 tmp.62))
              (set! rax tmp.83)
              (jump tmp-ra.72 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.72 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.72 rbp rax)))))
    (define L.-.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.73 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.84 tmp.23)
                      (set! tmp.84 (bitwise-and tmp.84 7))
                      (set! tmp.64 tmp.84))
                    (= tmp.64 0))
                (set! tmp.63 14)
                (set! tmp.63 6))
              (!= tmp.63 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.85 tmp.22)
                        (set! tmp.85 (bitwise-and tmp.85 7))
                        (set! tmp.66 tmp.85))
                      (= tmp.66 0))
                  (set! tmp.65 14)
                  (set! tmp.65 6))
                (!= tmp.65 6))
            (begin
              (set! tmp.86 tmp.22)
              (set! tmp.86 (- tmp.86 tmp.23))
              (set! rax tmp.86)
              (jump tmp-ra.73 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.73 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.73 rbp rax)))))
    (define L.fun/error10153.4
      ((new-frames ()))
      (begin (set! tmp-ra.74 r15) (set! rax 3134) (jump tmp-ra.74 rbp rax)))
    (define L.fun/error10154.5
      ((new-frames ()))
      (begin (set! tmp-ra.75 r15) (set! rax 4926) (jump tmp-ra.75 rbp rax)))
    (begin
      (set! tmp-ra.76 r15)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/error10153.4 rbp r15)))
      (set! error0.4 rax)
      (return-point L.rp.11
        (begin
          (set! rsi 1480)
          (set! rdi 1080)
          (set! r15 L.rp.11)
          (jump L.-.7 rbp r15 rdi rsi)))
      (set! tmp.67 rax)
      (return-point L.rp.12
        (begin
          (set! rsi 1336)
          (set! rdi 1896)
          (set! r15 L.rp.12)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.13
        (begin
          (set! rsi tmp.68)
          (set! rdi tmp.67)
          (set! r15 L.rp.13)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! fixnum1.3 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/error10154.5 rbp r15)))
      (set! error2.2 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 392)
          (set! rdi 1968)
          (set! r15 L.rp.15)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 1208)
          (set! rdi 1408)
          (set! r15 L.rp.16)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.17
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.17)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! fixnum3.1 rax)
      (set! rax error2.2)
      (jump tmp-ra.76 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () ())))
    (define L.fun/ascii-char11508.4
      ((new-frames ()))
      (begin (set! tmp-ra.55 r15) (set! rax 25390) (jump tmp-ra.55 rbp rax)))
    (define L.fun/void11512.5
      ((new-frames ()))
      (begin (set! tmp-ra.56 r15) (set! rax 30) (jump tmp-ra.56 rbp rax)))
    (define L.fun/ascii-char11511.6
      ((new-frames ()))
      (begin (set! tmp-ra.57 r15) (set! rax 25390) (jump tmp-ra.57 rbp rax)))
    (define L.fun/empty11507.7
      ((new-frames ()))
      (begin (set! tmp-ra.58 r15) (set! rax 22) (jump tmp-ra.58 rbp rax)))
    (define L.fun/empty11509.8
      ((new-frames ()))
      (begin (set! tmp-ra.59 r15) (set! rax 22) (jump tmp-ra.59 rbp rax)))
    (define L.fun/error11510.9
      ((new-frames ()))
      (begin (set! tmp-ra.60 r15) (set! rax 31294) (jump tmp-ra.60 rbp rax)))
    (begin
      (set! tmp-ra.61 r15)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/empty11507.7 rbp r15)))
      (set! empty0.5 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/ascii-char11508.4 rbp r15)))
      (set! ascii-char1.4 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/empty11509.8 rbp r15)))
      (set! empty2.3 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/error11510.9 rbp r15)))
      (set! error3.2 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/ascii-char11511.6 rbp r15)))
      (set! ascii-char4.1 rax)
      (set! r15 tmp-ra.61)
      (jump L.fun/void11512.5 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ())))
    (define L.boolean?.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! tmp.43 rdi)
        (if (begin
              (begin
                (set! tmp.65 tmp.43)
                (set! tmp.65 (bitwise-and tmp.65 247))
                (set! tmp.55 tmp.65))
              (= tmp.55 6))
          (begin (set! rax 14) (jump tmp-ra.57 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.57 rbp rax)))))
    (define L.fun/any11902.4
      ((new-frames ()))
      (begin (set! tmp-ra.58 r15) (set! rax 6) (jump tmp-ra.58 rbp rax)))
    (define L.fun/ascii-char11900.5
      ((new-frames ()))
      (begin (set! tmp-ra.59 r15) (set! rax 25390) (jump tmp-ra.59 rbp rax)))
    (define L.fun/ascii-char11901.6
      ((new-frames ()))
      (begin (set! tmp-ra.60 r15) (set! rax 25390) (jump tmp-ra.60 rbp rax)))
    (define L.fun/ascii-char11903.7
      ((new-frames ()))
      (begin (set! tmp-ra.61 r15) (set! rax 25390) (jump tmp-ra.61 rbp rax)))
    (define L.fun/void11904.8
      ((new-frames ()))
      (begin (set! tmp-ra.62 r15) (set! rax 30) (jump tmp-ra.62 rbp rax)))
    (define L.fun/empty11899.9
      ((new-frames ()))
      (begin (set! tmp-ra.63 r15) (set! rax 22) (jump tmp-ra.63 rbp rax)))
    (begin
      (set! tmp-ra.64 r15)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/empty11899.9 rbp r15)))
      (set! empty0.5 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/ascii-char11900.5 rbp r15)))
      (set! ascii-char1.4 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/ascii-char11901.6 rbp r15)))
      (set! ascii-char2.3 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/any11902.4 rbp r15)))
      (set! tmp.56 rax)
      (return-point L.rp.16
        (begin
          (set! rdi tmp.56)
          (set! r15 L.rp.16)
          (jump L.boolean?.11 rbp r15 rdi)))
      (set! boolean3.2 rax)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/ascii-char11903.7 rbp r15)))
      (set! ascii-char4.1 rax)
      (set! r15 tmp-ra.64)
      (jump L.fun/void11904.8 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () ())))
    (define L.-.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.80 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.87 tmp.24)
                      (set! tmp.87 (bitwise-and tmp.87 7))
                      (set! tmp.56 tmp.87))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.88 tmp.23)
                        (set! tmp.88 (bitwise-and tmp.88 7))
                        (set! tmp.58 tmp.88))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.89 tmp.23)
              (set! tmp.89 (- tmp.89 tmp.24))
              (set! rax tmp.89)
              (jump tmp-ra.80 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.80 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.80 rbp rax)))))
    (define L.*.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.81 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.90 tmp.20)
                      (set! tmp.90 (bitwise-and tmp.90 7))
                      (set! tmp.60 tmp.90))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.91 tmp.19)
                        (set! tmp.91 (bitwise-and tmp.91 7))
                        (set! tmp.62 tmp.91))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.92 tmp.20)
              (set! tmp.92 (arithmetic-shift-right tmp.92 3))
              (set! tmp.63 tmp.92)
              (set! tmp.93 tmp.19)
              (set! tmp.93 (* tmp.93 tmp.63))
              (set! rax tmp.93)
              (jump tmp-ra.81 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.81 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.81 rbp rax)))))
    (define L.+.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.82 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.94 tmp.22)
                      (set! tmp.94 (bitwise-and tmp.94 7))
                      (set! tmp.65 tmp.94))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.95 tmp.21)
                        (set! tmp.95 (bitwise-and tmp.95 7))
                        (set! tmp.67 tmp.95))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.96 tmp.21)
              (set! tmp.96 (+ tmp.96 tmp.22))
              (set! rax tmp.96)
              (jump tmp-ra.82 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.82 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.82 rbp rax)))))
    (define L.fun/void11995.4
      ((new-frames ()))
      (begin (set! tmp-ra.83 r15) (set! rax 30) (jump tmp-ra.83 rbp rax)))
    (define L.fun/ascii-char11994.5
      ((new-frames ()))
      (begin (set! tmp-ra.84 r15) (set! rax 25390) (jump tmp-ra.84 rbp rax)))
    (define L.fun/void11996.6
      ((new-frames ()))
      (begin (set! tmp-ra.85 r15) (set! rax 30) (jump tmp-ra.85 rbp rax)))
    (begin
      (set! tmp-ra.86 r15)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/ascii-char11994.5 rbp r15)))
      (set! ascii-char0.5 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/void11995.4 rbp r15)))
      (set! void1.4 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/void11996.6 rbp r15)))
      (set! void2.3 rax)
      (return-point L.rp.14
        (begin
          (set! rsi 40)
          (set! rdi 2000)
          (set! r15 L.rp.14)
          (jump L.+.8 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 128)
          (set! rdi 752)
          (set! r15 L.rp.15)
          (jump L.*.9 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.16
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.16)
          (jump L.+.8 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1888)
          (set! rdi 304)
          (set! r15 L.rp.17)
          (jump L.+.8 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 368)
          (set! rdi 1440)
          (set! r15 L.rp.18)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.19
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.19)
          (jump L.+.8 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.71)
          (set! rdi tmp.68)
          (set! r15 L.rp.20)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! fixnum3.2 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 1800)
          (set! rdi 1384)
          (set! r15 L.rp.21)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1096)
          (set! rdi 96)
          (set! r15 L.rp.22)
          (jump L.*.9 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.23)
          (jump L.*.9 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 360)
          (set! rdi 1112)
          (set! r15 L.rp.24)
          (jump L.+.8 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1272)
          (set! rdi 1344)
          (set! r15 L.rp.25)
          (jump L.*.9 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.26
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.26)
          (jump L.+.8 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.74)
          (set! r15 L.rp.27)
          (jump L.*.9 rbp r15 rdi rsi)))
      (set! fixnum4.1 rax)
      (set! rsi fixnum3.2)
      (set! rdi fixnum4.1)
      (set! r15 tmp-ra.86)
      (jump L.+.8 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () () () ())))
    (define L.+.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.92 tmp.22)
                      (set! tmp.92 (bitwise-and tmp.92 7))
                      (set! tmp.56 tmp.92))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.93 tmp.21)
                        (set! tmp.93 (bitwise-and tmp.93 7))
                        (set! tmp.58 tmp.93))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.94 tmp.21)
              (set! tmp.94 (+ tmp.94 tmp.22))
              (set! rax tmp.94)
              (jump tmp-ra.86 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.86 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.86 rbp rax)))))
    (define L.-.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.95 tmp.24)
                      (set! tmp.95 (bitwise-and tmp.95 7))
                      (set! tmp.60 tmp.95))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.96 tmp.23)
                        (set! tmp.96 (bitwise-and tmp.96 7))
                        (set! tmp.62 tmp.96))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.97 tmp.23)
              (set! tmp.97 (- tmp.97 tmp.24))
              (set! rax tmp.97)
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.87 rbp rax)))))
    (define L.*.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.98 tmp.20)
                      (set! tmp.98 (bitwise-and tmp.98 7))
                      (set! tmp.64 tmp.98))
                    (= tmp.64 0))
                (set! tmp.63 14)
                (set! tmp.63 6))
              (!= tmp.63 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.99 tmp.19)
                        (set! tmp.99 (bitwise-and tmp.99 7))
                        (set! tmp.66 tmp.99))
                      (= tmp.66 0))
                  (set! tmp.65 14)
                  (set! tmp.65 6))
                (!= tmp.65 6))
            (begin
              (set! tmp.100 tmp.20)
              (set! tmp.100 (arithmetic-shift-right tmp.100 3))
              (set! tmp.67 tmp.100)
              (set! tmp.101 tmp.19)
              (set! tmp.101 (* tmp.101 tmp.67))
              (set! rax tmp.101)
              (jump tmp-ra.88 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.88 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.88 rbp rax)))))
    (define L.fun/void11999.4
      ((new-frames ()))
      (begin (set! tmp-ra.89 r15) (set! rax 30) (jump tmp-ra.89 rbp rax)))
    (define L.fun/ascii-char12000.5
      ((new-frames ()))
      (begin (set! tmp-ra.90 r15) (set! rax 25390) (jump tmp-ra.90 rbp rax)))
    (begin
      (set! tmp-ra.91 r15)
      (return-point L.rp.10
        (begin
          (set! rsi 448)
          (set! rdi 1984)
          (set! r15 L.rp.10)
          (jump L.*.7 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.11
        (begin
          (set! rsi 656)
          (set! rdi 1248)
          (set! r15 L.rp.11)
          (jump L.-.8 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.12
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.12)
          (jump L.*.7 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 1400)
          (set! rdi 456)
          (set! r15 L.rp.13)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.14
        (begin
          (set! rsi 1120)
          (set! rdi 1048)
          (set! r15 L.rp.14)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.15
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.15)
          (jump L.-.8 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.16
        (begin
          (set! rsi tmp.71)
          (set! rdi tmp.68)
          (set! r15 L.rp.16)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! fixnum0.5 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1576)
          (set! rdi 360)
          (set! r15 L.rp.17)
          (jump L.-.8 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 1448)
          (set! rdi 1768)
          (set! r15 L.rp.18)
          (jump L.*.7 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.19
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.19)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 1936)
          (set! rdi 1120)
          (set! r15 L.rp.20)
          (jump L.*.7 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 1048)
          (set! rdi 1416)
          (set! r15 L.rp.21)
          (jump L.*.7 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.22)
          (jump L.*.7 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.74)
          (set! r15 L.rp.23)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! fixnum1.4 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/void11999.4 rbp r15)))
      (set! void2.3 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1680)
          (set! rdi 680)
          (set! r15 L.rp.25)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1904)
          (set! rdi 784)
          (set! r15 L.rp.26)
          (jump L.*.7 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.27)
          (jump L.*.7 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1672)
          (set! rdi 1624)
          (set! r15 L.rp.28)
          (jump L.*.7 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 1032)
          (set! rdi 2008)
          (set! r15 L.rp.29)
          (jump L.*.7 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.85)
          (set! rdi tmp.84)
          (set! r15 L.rp.30)
          (jump L.-.8 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.80)
          (set! r15 L.rp.31)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! fixnum3.2 rax)
      (return-point L.rp.32
        (begin (set! r15 L.rp.32) (jump L.fun/ascii-char12000.5 rbp r15)))
      (set! ascii-char4.1 rax)
      (set! rax ascii-char4.1)
      (jump tmp-ra.91 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () ())))
    (define L.fun/empty12004.4
      ((new-frames ()))
      (begin (set! tmp-ra.55 r15) (set! rax 22) (jump tmp-ra.55 rbp rax)))
    (define L.fun/void12007.5
      ((new-frames ()))
      (begin (set! tmp-ra.56 r15) (set! rax 30) (jump tmp-ra.56 rbp rax)))
    (define L.fun/empty12006.6
      ((new-frames ()))
      (begin (set! tmp-ra.57 r15) (set! rax 22) (jump tmp-ra.57 rbp rax)))
    (define L.fun/ascii-char12003.7
      ((new-frames ()))
      (begin (set! tmp-ra.58 r15) (set! rax 25390) (jump tmp-ra.58 rbp rax)))
    (define L.fun/void12005.8
      ((new-frames ()))
      (begin (set! tmp-ra.59 r15) (set! rax 30) (jump tmp-ra.59 rbp rax)))
    (begin
      (set! tmp-ra.60 r15)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/ascii-char12003.7 rbp r15)))
      (set! ascii-char0.5 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/empty12004.4 rbp r15)))
      (set! empty1.4 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/void12005.8 rbp r15)))
      (set! void2.3 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/empty12006.6 rbp r15)))
      (set! empty3.2 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/void12007.5 rbp r15)))
      (set! void4.1 rax)
      (set! rax void4.1)
      (jump tmp-ra.60 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () ())))
    (define L.fun/ascii-char12857.4
      ((new-frames ()))
      (begin (set! tmp-ra.55 r15) (set! rax 25390) (jump tmp-ra.55 rbp rax)))
    (define L.fun/void12858.5
      ((new-frames ()))
      (begin (set! tmp-ra.56 r15) (set! rax 30) (jump tmp-ra.56 rbp rax)))
    (define L.fun/error12860.6
      ((new-frames ()))
      (begin (set! tmp-ra.57 r15) (set! rax 36926) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error12859.7
      ((new-frames ()))
      (begin (set! tmp-ra.58 r15) (set! rax 30526) (jump tmp-ra.58 rbp rax)))
    (define L.fun/empty12861.8
      ((new-frames ()))
      (begin (set! tmp-ra.59 r15) (set! rax 22) (jump tmp-ra.59 rbp rax)))
    (begin
      (set! tmp-ra.60 r15)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/ascii-char12857.4 rbp r15)))
      (set! ascii-char0.5 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/void12858.5 rbp r15)))
      (set! void1.4 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/error12859.7 rbp r15)))
      (set! error2.3 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/error12860.6 rbp r15)))
      (set! error3.2 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/empty12861.8 rbp r15)))
      (set! empty4.1 rax)
      (set! rax empty4.1)
      (jump tmp-ra.60 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () ())))
    (define L.+.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.80 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.87 tmp.22)
                      (set! tmp.87 (bitwise-and tmp.87 7))
                      (set! tmp.56 tmp.87))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.88 tmp.21)
                        (set! tmp.88 (bitwise-and tmp.88 7))
                        (set! tmp.58 tmp.88))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.89 tmp.21)
              (set! tmp.89 (+ tmp.89 tmp.22))
              (set! rax tmp.89)
              (jump tmp-ra.80 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.80 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.80 rbp rax)))))
    (define L.-.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.81 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.90 tmp.24)
                      (set! tmp.90 (bitwise-and tmp.90 7))
                      (set! tmp.60 tmp.90))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.91 tmp.23)
                        (set! tmp.91 (bitwise-and tmp.91 7))
                        (set! tmp.62 tmp.91))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.92 tmp.23)
              (set! tmp.92 (- tmp.92 tmp.24))
              (set! rax tmp.92)
              (jump tmp-ra.81 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.81 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.81 rbp rax)))))
    (define L.*.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.82 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.93 tmp.20)
                      (set! tmp.93 (bitwise-and tmp.93 7))
                      (set! tmp.64 tmp.93))
                    (= tmp.64 0))
                (set! tmp.63 14)
                (set! tmp.63 6))
              (!= tmp.63 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.94 tmp.19)
                        (set! tmp.94 (bitwise-and tmp.94 7))
                        (set! tmp.66 tmp.94))
                      (= tmp.66 0))
                  (set! tmp.65 14)
                  (set! tmp.65 6))
                (!= tmp.65 6))
            (begin
              (set! tmp.95 tmp.20)
              (set! tmp.95 (arithmetic-shift-right tmp.95 3))
              (set! tmp.67 tmp.95)
              (set! tmp.96 tmp.19)
              (set! tmp.96 (* tmp.96 tmp.67))
              (set! rax tmp.96)
              (jump tmp-ra.82 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.82 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.82 rbp rax)))))
    (define L.fun/ascii-char14008.4
      ((new-frames ()))
      (begin (set! tmp-ra.83 r15) (set! rax 25390) (jump tmp-ra.83 rbp rax)))
    (define L.fun/error14007.5
      ((new-frames ()))
      (begin (set! tmp-ra.84 r15) (set! rax 32830) (jump tmp-ra.84 rbp rax)))
    (define L.fun/void14006.6
      ((new-frames ()))
      (begin (set! tmp-ra.85 r15) (set! rax 30) (jump tmp-ra.85 rbp rax)))
    (begin
      (set! tmp-ra.86 r15)
      (return-point L.rp.11
        (begin
          (set! rsi 712)
          (set! rdi 1536)
          (set! r15 L.rp.11)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.12
        (begin
          (set! rsi 160)
          (set! rdi 1672)
          (set! r15 L.rp.12)
          (jump L.-.9 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.13
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.13)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.14
        (begin
          (set! rsi 1824)
          (set! rdi 240)
          (set! r15 L.rp.14)
          (jump L.-.9 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 1720)
          (set! rdi 1440)
          (set! r15 L.rp.15)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.16
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.16)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.17
        (begin
          (set! rsi tmp.71)
          (set! rdi tmp.68)
          (set! r15 L.rp.17)
          (jump L.-.9 rbp r15 rdi rsi)))
      (set! fixnum0.5 rax)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/void14006.6 rbp r15)))
      (set! void1.4 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 592)
          (set! rdi 280)
          (set! r15 L.rp.19)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 536)
          (set! rdi 440)
          (set! r15 L.rp.20)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.21)
          (jump L.-.9 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 744)
          (set! rdi 400)
          (set! r15 L.rp.22)
          (jump L.-.9 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 1080)
          (set! rdi 1592)
          (set! r15 L.rp.23)
          (jump L.-.9 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.24)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.74)
          (set! r15 L.rp.25)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! fixnum2.3 rax)
      (return-point L.rp.26
        (begin (set! r15 L.rp.26) (jump L.fun/error14007.5 rbp r15)))
      (set! error3.2 rax)
      (return-point L.rp.27
        (begin (set! r15 L.rp.27) (jump L.fun/ascii-char14008.4 rbp r15)))
      (set! ascii-char4.1 rax)
      (set! rsi fixnum0.5)
      (set! rdi fixnum0.5)
      (set! r15 tmp-ra.86)
      (jump L.*.8 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () () () ())))
    (define L.fun/void15239.4
      ((new-frames ()))
      (begin (set! tmp-ra.55 r15) (set! rax 30) (jump tmp-ra.55 rbp rax)))
    (define L.fun/ascii-char15242.5
      ((new-frames ()))
      (begin (set! tmp-ra.56 r15) (set! rax 25390) (jump tmp-ra.56 rbp rax)))
    (define L.fun/error15237.6
      ((new-frames ()))
      (begin (set! tmp-ra.57 r15) (set! rax 11070) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error15240.7
      ((new-frames ()))
      (begin (set! tmp-ra.58 r15) (set! rax 4158) (jump tmp-ra.58 rbp rax)))
    (define L.fun/error15238.8
      ((new-frames ()))
      (begin (set! tmp-ra.59 r15) (set! rax 57406) (jump tmp-ra.59 rbp rax)))
    (define L.fun/empty15241.9
      ((new-frames ()))
      (begin (set! tmp-ra.60 r15) (set! rax 22) (jump tmp-ra.60 rbp rax)))
    (begin
      (set! tmp-ra.61 r15)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/error15237.6 rbp r15)))
      (set! error0.5 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/error15238.8 rbp r15)))
      (set! error1.4 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/void15239.4 rbp r15)))
      (set! void2.3 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/error15240.7 rbp r15)))
      (set! error3.2 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/empty15241.9 rbp r15)))
      (set! empty4.1 rax)
      (set! r15 tmp-ra.61)
      (jump L.fun/ascii-char15242.5 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () ())))
    (define L.-.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.74 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.82 tmp.24)
                      (set! tmp.82 (bitwise-and tmp.82 7))
                      (set! tmp.56 tmp.82))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.83 tmp.23)
                        (set! tmp.83 (bitwise-and tmp.83 7))
                        (set! tmp.58 tmp.83))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.84 tmp.23)
              (set! tmp.84 (- tmp.84 tmp.24))
              (set! rax tmp.84)
              (jump tmp-ra.74 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.74 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.74 rbp rax)))))
    (define L.*.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.85 tmp.20)
                      (set! tmp.85 (bitwise-and tmp.85 7))
                      (set! tmp.60 tmp.85))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.86 tmp.19)
                        (set! tmp.86 (bitwise-and tmp.86 7))
                        (set! tmp.62 tmp.86))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.87 tmp.20)
              (set! tmp.87 (arithmetic-shift-right tmp.87 3))
              (set! tmp.63 tmp.87)
              (set! tmp.88 tmp.19)
              (set! tmp.88 (* tmp.88 tmp.63))
              (set! rax tmp.88)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.75 rbp rax)))))
    (define L.+.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.89 tmp.22)
                      (set! tmp.89 (bitwise-and tmp.89 7))
                      (set! tmp.65 tmp.89))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.90 tmp.21)
                        (set! tmp.90 (bitwise-and tmp.90 7))
                        (set! tmp.67 tmp.90))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.91 tmp.21)
              (set! tmp.91 (+ tmp.91 tmp.22))
              (set! rax tmp.91)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.76 rbp rax)))))
    (define L.fun/void15268.4
      ((new-frames ()))
      (begin (set! tmp-ra.77 r15) (set! rax 30) (jump tmp-ra.77 rbp rax)))
    (define L.fun/void15269.5
      ((new-frames ()))
      (begin (set! tmp-ra.78 r15) (set! rax 30) (jump tmp-ra.78 rbp rax)))
    (define L.fun/empty15270.6
      ((new-frames ()))
      (begin (set! tmp-ra.79 r15) (set! rax 22) (jump tmp-ra.79 rbp rax)))
    (define L.fun/void15267.7
      ((new-frames ()))
      (begin (set! tmp-ra.80 r15) (set! rax 30) (jump tmp-ra.80 rbp rax)))
    (begin
      (set! tmp-ra.81 r15)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/void15267.7 rbp r15)))
      (set! void0.5 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/void15268.4 rbp r15)))
      (set! void1.4 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/void15269.5 rbp r15)))
      (set! void2.3 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/empty15270.6 rbp r15)))
      (set! empty3.2 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 1256)
          (set! rdi 880)
          (set! r15 L.rp.16)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1568)
          (set! rdi 1136)
          (set! r15 L.rp.17)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.18)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1176)
          (set! rdi 280)
          (set! r15 L.rp.19)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 1232)
          (set! rdi 1208)
          (set! r15 L.rp.20)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.21)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.71)
          (set! rdi tmp.68)
          (set! r15 L.rp.22)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! fixnum4.1 rax)
      (set! rax void0.5)
      (jump tmp-ra.81 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () ())))
    (define L.-.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.85 tmp.24)
                      (set! tmp.85 (bitwise-and tmp.85 7))
                      (set! tmp.56 tmp.85))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.86 tmp.23)
                        (set! tmp.86 (bitwise-and tmp.86 7))
                        (set! tmp.58 tmp.86))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.87 tmp.23)
              (set! tmp.87 (- tmp.87 tmp.24))
              (set! rax tmp.87)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.76 rbp rax)))))
    (define L.*.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.77 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.88 tmp.20)
                      (set! tmp.88 (bitwise-and tmp.88 7))
                      (set! tmp.60 tmp.88))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.89 tmp.19)
                        (set! tmp.89 (bitwise-and tmp.89 7))
                        (set! tmp.62 tmp.89))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.90 tmp.20)
              (set! tmp.90 (arithmetic-shift-right tmp.90 3))
              (set! tmp.63 tmp.90)
              (set! tmp.91 tmp.19)
              (set! tmp.91 (* tmp.91 tmp.63))
              (set! rax tmp.91)
              (jump tmp-ra.77 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.77 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.77 rbp rax)))))
    (define L.+.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.78 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.92 tmp.22)
                      (set! tmp.92 (bitwise-and tmp.92 7))
                      (set! tmp.65 tmp.92))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.93 tmp.21)
                        (set! tmp.93 (bitwise-and tmp.93 7))
                        (set! tmp.67 tmp.93))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.94 tmp.21)
              (set! tmp.94 (+ tmp.94 tmp.22))
              (set! rax tmp.94)
              (jump tmp-ra.78 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.78 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.78 rbp rax)))))
    (define L.ascii-char?.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.79 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.95 tmp.46)
                (set! tmp.95 (bitwise-and tmp.95 255))
                (set! tmp.68 tmp.95))
              (= tmp.68 46))
          (begin (set! rax 14) (jump tmp-ra.79 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.79 rbp rax)))))
    (define L.fun/ascii-char15482.4
      ((new-frames ()))
      (begin (set! tmp-ra.80 r15) (set! rax 25390) (jump tmp-ra.80 rbp rax)))
    (define L.fun/void15483.5
      ((new-frames ()))
      (begin (set! tmp-ra.81 r15) (set! rax 30) (jump tmp-ra.81 rbp rax)))
    (define L.fun/any15480.6
      ((new-frames ()))
      (begin (set! tmp-ra.82 r15) (set! rax 22) (jump tmp-ra.82 rbp rax)))
    (define L.fun/void15481.7
      ((new-frames ()))
      (begin (set! tmp-ra.83 r15) (set! rax 30) (jump tmp-ra.83 rbp rax)))
    (begin
      (set! tmp-ra.84 r15)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/any15480.6 rbp r15)))
      (set! tmp.69 rax)
      (return-point L.rp.14
        (begin
          (set! rdi tmp.69)
          (set! r15 L.rp.14)
          (jump L.ascii-char?.9 rbp r15 rdi)))
      (set! boolean0.5 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/void15481.7 rbp r15)))
      (set! void1.4 rax)
      (return-point L.rp.16
        (begin (set! r15 L.rp.16) (jump L.fun/ascii-char15482.4 rbp r15)))
      (set! ascii-char2.3 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1976)
          (set! rdi 1136)
          (set! r15 L.rp.17)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 1296)
          (set! rdi 96)
          (set! r15 L.rp.18)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.19
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.19)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 1192)
          (set! rdi 680)
          (set! r15 L.rp.20)
          (jump L.*.11 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 632)
          (set! rdi 608)
          (set! r15 L.rp.21)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.22)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.23)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! fixnum3.2 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/void15483.5 rbp r15)))
      (set! void4.1 rax)
      (set! rax void4.1)
      (jump tmp-ra.84 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () ())))
    (define L.vector?.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.74 r15)
        (set! tmp.49 rdi)
        (if (begin
              (begin
                (set! tmp.83 tmp.49)
                (set! tmp.83 (bitwise-and tmp.83 7))
                (set! tmp.55 tmp.83))
              (= tmp.55 3))
          (begin (set! rax 14) (jump tmp-ra.74 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.74 rbp rax)))))
    (define L.-.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.84 tmp.24)
                      (set! tmp.84 (bitwise-and tmp.84 7))
                      (set! tmp.57 tmp.84))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.85 tmp.23)
                        (set! tmp.85 (bitwise-and tmp.85 7))
                        (set! tmp.59 tmp.85))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.86 tmp.23)
              (set! tmp.86 (- tmp.86 tmp.24))
              (set! rax tmp.86)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.75 rbp rax)))))
    (define L.*.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.87 tmp.20)
                      (set! tmp.87 (bitwise-and tmp.87 7))
                      (set! tmp.61 tmp.87))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.88 tmp.19)
                        (set! tmp.88 (bitwise-and tmp.88 7))
                        (set! tmp.63 tmp.88))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.89 tmp.20)
              (set! tmp.89 (arithmetic-shift-right tmp.89 3))
              (set! tmp.64 tmp.89)
              (set! tmp.90 tmp.19)
              (set! tmp.90 (* tmp.90 tmp.64))
              (set! rax tmp.90)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))))
    (define L.empty?.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.77 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.91 tmp.44)
                (set! tmp.91 (bitwise-and tmp.91 255))
                (set! tmp.65 tmp.91))
              (= tmp.65 22))
          (begin (set! rax 14) (jump tmp-ra.77 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.77 rbp rax)))))
    (define L.fun/any17793.4
      ((new-frames ()))
      (begin (set! tmp-ra.78 r15) (set! rax 25390) (jump tmp-ra.78 rbp rax)))
    (define L.fun/error17796.5
      ((new-frames ()))
      (begin (set! tmp-ra.79 r15) (set! rax 19518) (jump tmp-ra.79 rbp rax)))
    (define L.fun/any17795.6
      ((new-frames ()))
      (begin (set! tmp-ra.80 r15) (set! rax 46910) (jump tmp-ra.80 rbp rax)))
    (define L.fun/empty17794.7
      ((new-frames ()))
      (begin (set! tmp-ra.81 r15) (set! rax 22) (jump tmp-ra.81 rbp rax)))
    (begin
      (set! tmp-ra.82 r15)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/any17793.4 rbp r15)))
      (set! tmp.66 rax)
      (return-point L.rp.14
        (begin
          (set! rdi tmp.66)
          (set! r15 L.rp.14)
          (jump L.empty?.9 rbp r15 rdi)))
      (set! boolean0.5 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/empty17794.7 rbp r15)))
      (set! empty1.4 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 1936)
          (set! rdi 1952)
          (set! r15 L.rp.16)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1120)
          (set! rdi 16)
          (set! r15 L.rp.17)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.69)
          (set! rdi tmp.68)
          (set! r15 L.rp.18)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.67 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1520)
          (set! rdi 1544)
          (set! r15 L.rp.19)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 1568)
          (set! rdi 1768)
          (set! r15 L.rp.20)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.21)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.67)
          (set! r15 L.rp.22)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! fixnum2.3 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/any17795.6 rbp r15)))
      (set! tmp.73 rax)
      (return-point L.rp.24
        (begin
          (set! rdi tmp.73)
          (set! r15 L.rp.24)
          (jump L.vector?.12 rbp r15 rdi)))
      (set! boolean3.2 rax)
      (return-point L.rp.25
        (begin (set! r15 L.rp.25) (jump L.fun/error17796.5 rbp r15)))
      (set! error4.1 rax)
      (set! rax error4.1)
      (jump tmp-ra.82 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () ())))
    (define L.boolean?.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.74 r15)
        (set! tmp.43 rdi)
        (if (begin
              (begin
                (set! tmp.84 tmp.43)
                (set! tmp.84 (bitwise-and tmp.84 247))
                (set! tmp.55 tmp.84))
              (= tmp.55 6))
          (begin (set! rax 14) (jump tmp-ra.74 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.74 rbp rax)))))
    (define L.*.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.85 tmp.20)
                      (set! tmp.85 (bitwise-and tmp.85 7))
                      (set! tmp.57 tmp.85))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.86 tmp.19)
                        (set! tmp.86 (bitwise-and tmp.86 7))
                        (set! tmp.59 tmp.86))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.87 tmp.20)
              (set! tmp.87 (arithmetic-shift-right tmp.87 3))
              (set! tmp.60 tmp.87)
              (set! tmp.88 tmp.19)
              (set! tmp.88 (* tmp.88 tmp.60))
              (set! rax tmp.88)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.75 rbp rax)))))
    (define L.-.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.89 tmp.24)
                      (set! tmp.89 (bitwise-and tmp.89 7))
                      (set! tmp.62 tmp.89))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.90 tmp.23)
                        (set! tmp.90 (bitwise-and tmp.90 7))
                        (set! tmp.64 tmp.90))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.91 tmp.23)
              (set! tmp.91 (- tmp.91 tmp.24))
              (set! rax tmp.91)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.76 rbp rax)))))
    (define L.fixnum?.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.77 r15)
        (set! tmp.42 rdi)
        (if (begin
              (begin
                (set! tmp.92 tmp.42)
                (set! tmp.92 (bitwise-and tmp.92 7))
                (set! tmp.65 tmp.92))
              (= tmp.65 0))
          (begin (set! rax 14) (jump tmp-ra.77 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.77 rbp rax)))))
    (define L.fun/any20781.4
      ((new-frames ()))
      (begin (set! tmp-ra.78 r15) (set! rax 30) (jump tmp-ra.78 rbp rax)))
    (define L.fun/error20783.5
      ((new-frames ()))
      (begin (set! tmp-ra.79 r15) (set! rax 45374) (jump tmp-ra.79 rbp rax)))
    (define L.fun/empty20785.6
      ((new-frames ()))
      (begin (set! tmp-ra.80 r15) (set! rax 22) (jump tmp-ra.80 rbp rax)))
    (define L.fun/error20782.7
      ((new-frames ()))
      (begin (set! tmp-ra.81 r15) (set! rax 42046) (jump tmp-ra.81 rbp rax)))
    (define L.fun/any20784.8
      ((new-frames ()))
      (begin (set! tmp-ra.82 r15) (set! rax 14) (jump tmp-ra.82 rbp rax)))
    (begin
      (set! tmp-ra.83 r15)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/any20781.4 rbp r15)))
      (set! tmp.66 rax)
      (return-point L.rp.15
        (begin
          (set! rdi tmp.66)
          (set! r15 L.rp.15)
          (jump L.fixnum?.10 rbp r15 rdi)))
      (set! boolean0.5 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 1976)
          (set! rdi 1808)
          (set! r15 L.rp.16)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1104)
          (set! rdi 1992)
          (set! r15 L.rp.17)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.69)
          (set! rdi tmp.68)
          (set! r15 L.rp.18)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.67 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 392)
          (set! rdi 1536)
          (set! r15 L.rp.19)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 1576)
          (set! rdi 552)
          (set! r15 L.rp.20)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.21)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.67)
          (set! r15 L.rp.22)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! fixnum1.4 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/error20782.7 rbp r15)))
      (set! error2.3 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/error20783.5 rbp r15)))
      (set! error3.2 rax)
      (return-point L.rp.25
        (begin (set! r15 L.rp.25) (jump L.fun/any20784.8 rbp r15)))
      (set! tmp.73 rax)
      (return-point L.rp.26
        (begin
          (set! rdi tmp.73)
          (set! r15 L.rp.26)
          (jump L.boolean?.13 rbp r15 rdi)))
      (set! boolean4.1 rax)
      (set! r15 tmp-ra.83)
      (jump L.fun/empty20785.6 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () ())))
    (define L.-.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.69 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.76 tmp.24)
                      (set! tmp.76 (bitwise-and tmp.76 7))
                      (set! tmp.56 tmp.76))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.77 tmp.23)
                        (set! tmp.77 (bitwise-and tmp.77 7))
                        (set! tmp.58 tmp.77))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.78 tmp.23)
              (set! tmp.78 (- tmp.78 tmp.24))
              (set! rax tmp.78)
              (jump tmp-ra.69 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.69 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.69 rbp rax)))))
    (define L.+.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.70 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.79 tmp.22)
                      (set! tmp.79 (bitwise-and tmp.79 7))
                      (set! tmp.60 tmp.79))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.80 tmp.21)
                        (set! tmp.80 (bitwise-and tmp.80 7))
                        (set! tmp.62 tmp.80))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.81 tmp.21)
              (set! tmp.81 (+ tmp.81 tmp.22))
              (set! rax tmp.81)
              (jump tmp-ra.70 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.70 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.70 rbp rax)))))
    (define L.fun/ascii-char22127.4
      ((new-frames ()))
      (begin (set! tmp-ra.71 r15) (set! rax 25390) (jump tmp-ra.71 rbp rax)))
    (define L.fun/error22124.5
      ((new-frames ()))
      (begin (set! tmp-ra.72 r15) (set! rax 41022) (jump tmp-ra.72 rbp rax)))
    (define L.fun/error22126.6
      ((new-frames ()))
      (begin (set! tmp-ra.73 r15) (set! rax 2622) (jump tmp-ra.73 rbp rax)))
    (define L.fun/void22125.7
      ((new-frames ()))
      (begin (set! tmp-ra.74 r15) (set! rax 30) (jump tmp-ra.74 rbp rax)))
    (begin
      (set! tmp-ra.75 r15)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/error22124.5 rbp r15)))
      (set! error0.5 rax)
      (return-point L.rp.12
        (begin
          (set! rsi 184)
          (set! rdi 528)
          (set! r15 L.rp.12)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.64 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 152)
          (set! rdi 1232)
          (set! r15 L.rp.13)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.65 rax)
      (return-point L.rp.14
        (begin
          (set! rsi tmp.65)
          (set! rdi tmp.64)
          (set! r15 L.rp.14)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.63 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 640)
          (set! rdi 448)
          (set! r15 L.rp.15)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.67 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 232)
          (set! rdi 744)
          (set! r15 L.rp.16)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.17
        (begin
          (set! rsi tmp.68)
          (set! rdi tmp.67)
          (set! r15 L.rp.17)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.66 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.66)
          (set! rdi tmp.63)
          (set! r15 L.rp.18)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! fixnum1.4 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/void22125.7 rbp r15)))
      (set! void2.3 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/error22126.6 rbp r15)))
      (set! error3.2 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/ascii-char22127.4 rbp r15)))
      (set! ascii-char4.1 rax)
      (set! rax void2.3)
      (jump tmp-ra.75 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () ())))
    (define L.ascii-char?.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.67 tmp.46)
                (set! tmp.67 (bitwise-and tmp.67 255))
                (set! tmp.55 tmp.67))
              (= tmp.55 46))
          (begin (set! rax 14) (jump tmp-ra.59 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.59 rbp rax)))))
    (define L.void?.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (set! tmp.45 rdi)
        (if (begin
              (begin
                (set! tmp.68 tmp.45)
                (set! tmp.68 (bitwise-and tmp.68 255))
                (set! tmp.56 tmp.68))
              (= tmp.56 30))
          (begin (set! rax 14) (jump tmp-ra.60 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.60 rbp rax)))))
    (define L.fun/any22156.4
      ((new-frames ()))
      (begin (set! tmp-ra.61 r15) (set! rax 30) (jump tmp-ra.61 rbp rax)))
    (define L.fun/ascii-char22153.5
      ((new-frames ()))
      (begin (set! tmp-ra.62 r15) (set! rax 25390) (jump tmp-ra.62 rbp rax)))
    (define L.fun/ascii-char22152.6
      ((new-frames ()))
      (begin (set! tmp-ra.63 r15) (set! rax 25390) (jump tmp-ra.63 rbp rax)))
    (define L.fun/void22154.7
      ((new-frames ()))
      (begin (set! tmp-ra.64 r15) (set! rax 30) (jump tmp-ra.64 rbp rax)))
    (define L.fun/any22155.8
      ((new-frames ()))
      (begin (set! tmp-ra.65 r15) (set! rax 30) (jump tmp-ra.65 rbp rax)))
    (begin
      (set! tmp-ra.66 r15)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/ascii-char22152.6 rbp r15)))
      (set! ascii-char0.5 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/ascii-char22153.5 rbp r15)))
      (set! ascii-char1.4 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/void22154.7 rbp r15)))
      (set! void2.3 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/any22155.8 rbp r15)))
      (set! tmp.57 rax)
      (return-point L.rp.16
        (begin
          (set! rdi tmp.57)
          (set! r15 L.rp.16)
          (jump L.void?.10 rbp r15 rdi)))
      (set! boolean3.2 rax)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/any22156.4 rbp r15)))
      (set! tmp.58 rax)
      (return-point L.rp.18
        (begin
          (set! rdi tmp.58)
          (set! r15 L.rp.18)
          (jump L.ascii-char?.11 rbp r15 rdi)))
      (set! boolean4.1 rax)
      (set! rax ascii-char1.4)
      (jump tmp-ra.66 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () ())))
    (define L.*.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.74 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.83 tmp.20)
                      (set! tmp.83 (bitwise-and tmp.83 7))
                      (set! tmp.56 tmp.83))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.84 tmp.19)
                        (set! tmp.84 (bitwise-and tmp.84 7))
                        (set! tmp.58 tmp.84))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.85 tmp.20)
              (set! tmp.85 (arithmetic-shift-right tmp.85 3))
              (set! tmp.59 tmp.85)
              (set! tmp.86 tmp.19)
              (set! tmp.86 (* tmp.86 tmp.59))
              (set! rax tmp.86)
              (jump tmp-ra.74 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.74 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.74 rbp rax)))))
    (define L.-.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.87 tmp.24)
                      (set! tmp.87 (bitwise-and tmp.87 7))
                      (set! tmp.61 tmp.87))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.88 tmp.23)
                        (set! tmp.88 (bitwise-and tmp.88 7))
                        (set! tmp.63 tmp.88))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.89 tmp.23)
              (set! tmp.89 (- tmp.89 tmp.24))
              (set! rax tmp.89)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.75 rbp rax)))))
    (define L.+.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.90 tmp.22)
                      (set! tmp.90 (bitwise-and tmp.90 7))
                      (set! tmp.65 tmp.90))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.91 tmp.21)
                        (set! tmp.91 (bitwise-and tmp.91 7))
                        (set! tmp.67 tmp.91))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.92 tmp.21)
              (set! tmp.92 (+ tmp.92 tmp.22))
              (set! rax tmp.92)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.76 rbp rax)))))
    (define L.fun/error22341.4
      ((new-frames ()))
      (begin (set! tmp-ra.77 r15) (set! rax 39998) (jump tmp-ra.77 rbp rax)))
    (define L.fun/void22343.5
      ((new-frames ()))
      (begin (set! tmp-ra.78 r15) (set! rax 30) (jump tmp-ra.78 rbp rax)))
    (define L.fun/empty22340.6
      ((new-frames ()))
      (begin (set! tmp-ra.79 r15) (set! rax 22) (jump tmp-ra.79 rbp rax)))
    (define L.fun/empty22342.7
      ((new-frames ()))
      (begin (set! tmp-ra.80 r15) (set! rax 22) (jump tmp-ra.80 rbp rax)))
    (define L.fun/void22344.8
      ((new-frames ()))
      (begin (set! tmp-ra.81 r15) (set! rax 30) (jump tmp-ra.81 rbp rax)))
    (begin
      (set! tmp-ra.82 r15)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/empty22340.6 rbp r15)))
      (set! empty0.5 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/error22341.4 rbp r15)))
      (set! error1.4 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/empty22342.7 rbp r15)))
      (set! empty2.3 rax)
      (return-point L.rp.16
        (begin (set! r15 L.rp.16) (jump L.fun/void22343.5 rbp r15)))
      (set! void3.2 rax)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/void22344.8 rbp r15)))
      (set! void4.1 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 1696)
          (set! rdi 1896)
          (set! r15 L.rp.18)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1152)
          (set! rdi 544)
          (set! r15 L.rp.19)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.20)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 384)
          (set! rdi 1576)
          (set! r15 L.rp.21)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1816)
          (set! rdi 1272)
          (set! r15 L.rp.22)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.23)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (set! rsi tmp.71)
      (set! rdi tmp.68)
      (set! r15 tmp-ra.82)
      (jump L.+.10 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () ())))
    (define L.empty?.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.77 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.87 tmp.44)
                (set! tmp.87 (bitwise-and tmp.87 255))
                (set! tmp.55 tmp.87))
              (= tmp.55 22))
          (begin (set! rax 14) (jump tmp-ra.77 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.77 rbp rax)))))
    (define L.-.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.78 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.88 tmp.24)
                      (set! tmp.88 (bitwise-and tmp.88 7))
                      (set! tmp.57 tmp.88))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.89 tmp.23)
                        (set! tmp.89 (bitwise-and tmp.89 7))
                        (set! tmp.59 tmp.89))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.90 tmp.23)
              (set! tmp.90 (- tmp.90 tmp.24))
              (set! rax tmp.90)
              (jump tmp-ra.78 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.78 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.78 rbp rax)))))
    (define L.*.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.79 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.91 tmp.20)
                      (set! tmp.91 (bitwise-and tmp.91 7))
                      (set! tmp.61 tmp.91))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.92 tmp.19)
                        (set! tmp.92 (bitwise-and tmp.92 7))
                        (set! tmp.63 tmp.92))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.93 tmp.20)
              (set! tmp.93 (arithmetic-shift-right tmp.93 3))
              (set! tmp.64 tmp.93)
              (set! tmp.94 tmp.19)
              (set! tmp.94 (* tmp.94 tmp.64))
              (set! rax tmp.94)
              (jump tmp-ra.79 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.79 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.79 rbp rax)))))
    (define L.+.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.80 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.95 tmp.22)
                      (set! tmp.95 (bitwise-and tmp.95 7))
                      (set! tmp.66 tmp.95))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.96 tmp.21)
                        (set! tmp.96 (bitwise-and tmp.96 7))
                        (set! tmp.68 tmp.96))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.97 tmp.21)
              (set! tmp.97 (+ tmp.97 tmp.22))
              (set! rax tmp.97)
              (jump tmp-ra.80 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.80 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.80 rbp rax)))))
    (define L.fun/ascii-char22583.4
      ((new-frames ()))
      (begin (set! tmp-ra.81 r15) (set! rax 25390) (jump tmp-ra.81 rbp rax)))
    (define L.fun/any22584.5
      ((new-frames ()))
      (begin (set! tmp-ra.82 r15) (set! rax 22) (jump tmp-ra.82 rbp rax)))
    (define L.fun/any22585.6
      ((new-frames ()))
      (begin (set! tmp-ra.83 r15) (set! rax 22) (jump tmp-ra.83 rbp rax)))
    (define L.fun/empty22581.7
      ((new-frames ()))
      (begin (set! tmp-ra.84 r15) (set! rax 22) (jump tmp-ra.84 rbp rax)))
    (define L.fun/ascii-char22582.8
      ((new-frames ()))
      (begin (set! tmp-ra.85 r15) (set! rax 25390) (jump tmp-ra.85 rbp rax)))
    (begin
      (set! tmp-ra.86 r15)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/empty22581.7 rbp r15)))
      (set! empty0.5 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 368)
          (set! rdi 800)
          (set! r15 L.rp.15)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 176)
          (set! rdi 1096)
          (set! r15 L.rp.16)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.17
        (begin
          (set! rsi tmp.71)
          (set! rdi tmp.70)
          (set! r15 L.rp.17)
          (jump L.*.11 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 1328)
          (set! rdi 1480)
          (set! r15 L.rp.18)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 792)
          (set! rdi 1552)
          (set! r15 L.rp.19)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.73)
          (set! r15 L.rp.20)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.69)
          (set! r15 L.rp.21)
          (jump L.*.11 rbp r15 rdi rsi)))
      (set! fixnum1.4 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/ascii-char22582.8 rbp r15)))
      (set! ascii-char2.3 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/ascii-char22583.4 rbp r15)))
      (set! ascii-char3.2 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/any22584.5 rbp r15)))
      (set! tmp.75 rax)
      (return-point L.rp.25
        (begin
          (set! rdi tmp.75)
          (set! r15 L.rp.25)
          (jump L.empty?.13 rbp r15 rdi)))
      (set! boolean4.1 rax)
      (return-point L.rp.26
        (begin (set! r15 L.rp.26) (jump L.fun/any22585.6 rbp r15)))
      (set! tmp.76 rax)
      (set! rdi tmp.76)
      (set! r15 tmp-ra.86)
      (jump L.empty?.13 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () () ())))
    (define L.-.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.82 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.90 tmp.24)
                      (set! tmp.90 (bitwise-and tmp.90 7))
                      (set! tmp.56 tmp.90))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.91 tmp.23)
                        (set! tmp.91 (bitwise-and tmp.91 7))
                        (set! tmp.58 tmp.91))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.92 tmp.23)
              (set! tmp.92 (- tmp.92 tmp.24))
              (set! rax tmp.92)
              (jump tmp-ra.82 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.82 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.82 rbp rax)))))
    (define L.*.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.93 tmp.20)
                      (set! tmp.93 (bitwise-and tmp.93 7))
                      (set! tmp.60 tmp.93))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.94 tmp.19)
                        (set! tmp.94 (bitwise-and tmp.94 7))
                        (set! tmp.62 tmp.94))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.95 tmp.20)
              (set! tmp.95 (arithmetic-shift-right tmp.95 3))
              (set! tmp.63 tmp.95)
              (set! tmp.96 tmp.19)
              (set! tmp.96 (* tmp.96 tmp.63))
              (set! rax tmp.96)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.83 rbp rax)))))
    (define L.+.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.22)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.65 tmp.97))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.21)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.67 tmp.98))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.99 tmp.21)
              (set! tmp.99 (+ tmp.99 tmp.22))
              (set! rax tmp.99)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.84 rbp rax)))))
    (define L.empty?.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.100 tmp.44)
                (set! tmp.100 (bitwise-and tmp.100 255))
                (set! tmp.68 tmp.100))
              (= tmp.68 22))
          (begin (set! rax 14) (jump tmp-ra.85 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/void22702.4
      ((new-frames ()))
      (begin (set! tmp-ra.86 r15) (set! rax 30) (jump tmp-ra.86 rbp rax)))
    (define L.fun/error22701.5
      ((new-frames ()))
      (begin (set! tmp-ra.87 r15) (set! rax 32062) (jump tmp-ra.87 rbp rax)))
    (define L.fun/any22703.6
      ((new-frames ()))
      (begin (set! tmp-ra.88 r15) (set! rax 22) (jump tmp-ra.88 rbp rax)))
    (begin
      (set! tmp-ra.89 r15)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/error22701.5 rbp r15)))
      (set! error0.5 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/void22702.4 rbp r15)))
      (set! void1.4 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/any22703.6 rbp r15)))
      (set! tmp.69 rax)
      (return-point L.rp.15
        (begin
          (set! rdi tmp.69)
          (set! r15 L.rp.15)
          (jump L.empty?.8 rbp r15 rdi)))
      (set! boolean2.3 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 1776)
          (set! rdi 392)
          (set! r15 L.rp.16)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1216)
          (set! rdi 1080)
          (set! r15 L.rp.17)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.18)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1112)
          (set! rdi 232)
          (set! r15 L.rp.19)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 1680)
          (set! rdi 1536)
          (set! r15 L.rp.20)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.21)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.22)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! fixnum3.2 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 1376)
          (set! rdi 336)
          (set! r15 L.rp.23)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 200)
          (set! rdi 528)
          (set! r15 L.rp.24)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.78)
          (set! rdi tmp.77)
          (set! r15 L.rp.25)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 584)
          (set! rdi 128)
          (set! r15 L.rp.26)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 176)
          (set! rdi 648)
          (set! r15 L.rp.27)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.80)
          (set! r15 L.rp.28)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.76)
          (set! r15 L.rp.29)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! fixnum4.1 rax)
      (set! rax void1.4)
      (jump tmp-ra.89 rbp rax))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () ())))
    (define L.-.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.25)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.57 tmp.97))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.24)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.59 tmp.98))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.99 tmp.24)
              (set! tmp.99 (- tmp.99 tmp.25))
              (set! rax tmp.99)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))))
    (define L.*.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.100 tmp.21)
                      (set! tmp.100 (bitwise-and tmp.100 7))
                      (set! tmp.61 tmp.100))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.101 tmp.20)
                        (set! tmp.101 (bitwise-and tmp.101 7))
                        (set! tmp.63 tmp.101))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.102 tmp.21)
              (set! tmp.102 (arithmetic-shift-right tmp.102 3))
              (set! tmp.64 tmp.102)
              (set! tmp.103 tmp.20)
              (set! tmp.103 (* tmp.103 tmp.64))
              (set! rax tmp.103)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.84 rbp rax)))))
    (define L.+.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.23)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.66 tmp.104))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.22)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.68 tmp.105))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.106 tmp.22)
              (set! tmp.106 (+ tmp.106 tmp.23))
              (set! rax tmp.106)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/ascii-char23153.4
      ((new-frames ()))
      (begin (set! tmp-ra.86 r15) (set! rax 25390) (jump tmp-ra.86 rbp rax)))
    (define L.fun/error23159.5
      ((new-frames ()))
      (begin (set! tmp-ra.87 r15) (set! rax 44862) (jump tmp-ra.87 rbp rax)))
    (define L.fun/ascii-char23157.6
      ((new-frames ()))
      (begin (set! tmp-ra.88 r15) (set! rax 25390) (jump tmp-ra.88 rbp rax)))
    (define L.fun/void23154.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/void23155.10 rbp r15)))
    (define L.fun/error23151.8
      ((new-frames ()))
      (begin (set! tmp-ra.90 r15) (set! rax 22846) (jump tmp-ra.90 rbp rax)))
    (define L.fun/ascii-char23156.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/ascii-char23157.6 rbp r15)))
    (define L.fun/void23155.10
      ((new-frames ()))
      (begin (set! tmp-ra.92 r15) (set! rax 30) (jump tmp-ra.92 rbp rax)))
    (define L.fun/error23150.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/error23151.8 rbp r15)))
    (define L.fun/error23158.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error23159.5 rbp r15)))
    (define L.fun/ascii-char23152.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/ascii-char23153.4 rbp r15)))
    (begin
      (set! tmp-ra.96 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/error23150.11 rbp r15)))
      (set! error0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/ascii-char23152.13 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/void23154.7 rbp r15)))
      (set! void2.4 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 528)
          (set! rdi 1552)
          (set! r15 L.rp.21)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1856)
          (set! rdi 2008)
          (set! r15 L.rp.22)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.23)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 920)
          (set! rdi 864)
          (set! r15 L.rp.24)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1752)
          (set! rdi 184)
          (set! r15 L.rp.25)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.26
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.26)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.27)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 584)
          (set! rdi 1104)
          (set! r15 L.rp.28)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 1432)
          (set! rdi 16)
          (set! r15 L.rp.29)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.30)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 1120)
          (set! rdi 736)
          (set! r15 L.rp.31)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 1008)
          (set! rdi 1952)
          (set! r15 L.rp.32)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.33)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.34)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.35
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.35)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! fixnum3.3 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/ascii-char23156.9 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/error23158.12 rbp r15)))
      (set! error5.1 rax)
      (set! rax error5.1)
      (jump tmp-ra.96 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () ())))
    (define L.empty?.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (set! tmp.45 rdi)
        (if (begin
              (begin
                (set! tmp.75 tmp.45)
                (set! tmp.75 (bitwise-and tmp.75 255))
                (set! tmp.56 tmp.75))
              (= tmp.56 22))
          (begin (set! rax 14) (jump tmp-ra.60 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.60 rbp rax)))))
    (define L.ascii-char?.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.61 r15)
        (set! tmp.47 rdi)
        (if (begin
              (begin
                (set! tmp.76 tmp.47)
                (set! tmp.76 (bitwise-and tmp.76 255))
                (set! tmp.57 tmp.76))
              (= tmp.57 46))
          (begin (set! rax 14) (jump tmp-ra.61 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.61 rbp rax)))))
    (define L.fun/empty24557.4
      ((new-frames ()))
      (begin (set! tmp-ra.62 r15) (set! rax 22) (jump tmp-ra.62 rbp rax)))
    (define L.fun/any24558.5
      ((new-frames ()))
      (begin (set! tmp-ra.63 r15) (set! rax 14) (jump tmp-ra.63 rbp rax)))
    (define L.fun/error24555.6
      ((new-frames ()))
      (begin (set! tmp-ra.64 r15) (set! rax 56894) (jump tmp-ra.64 rbp rax)))
    (define L.fun/ascii-char24562.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/ascii-char24563.13 rbp r15)))
    (define L.fun/empty24560.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.66 r15)
        (set! r15 tmp-ra.66)
        (jump L.fun/empty24561.9 rbp r15)))
    (define L.fun/empty24561.9
      ((new-frames ()))
      (begin (set! tmp-ra.67 r15) (set! rax 22) (jump tmp-ra.67 rbp rax)))
    (define L.fun/empty24556.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.68 r15)
        (set! r15 tmp-ra.68)
        (jump L.fun/empty24557.4 rbp r15)))
    (define L.fun/any24559.11
      ((new-frames ()))
      (begin (set! tmp-ra.69 r15) (set! rax 30) (jump tmp-ra.69 rbp rax)))
    (define L.fun/error24552.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.70 r15)
        (set! r15 tmp-ra.70)
        (jump L.fun/error24553.14 rbp r15)))
    (define L.fun/ascii-char24563.13
      ((new-frames ()))
      (begin (set! tmp-ra.71 r15) (set! rax 25390) (jump tmp-ra.71 rbp rax)))
    (define L.fun/error24553.14
      ((new-frames ()))
      (begin (set! tmp-ra.72 r15) (set! rax 52030) (jump tmp-ra.72 rbp rax)))
    (define L.fun/error24554.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.73 r15)
        (set! r15 tmp-ra.73)
        (jump L.fun/error24555.6 rbp r15)))
    (begin
      (set! tmp-ra.74 r15)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/error24552.12 rbp r15)))
      (set! error0.6 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/error24554.15 rbp r15)))
      (set! error1.5 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/empty24556.10 rbp r15)))
      (set! empty2.4 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/any24558.5 rbp r15)))
      (set! tmp.58 rax)
      (return-point L.rp.23
        (begin
          (set! rdi tmp.58)
          (set! r15 L.rp.23)
          (jump L.ascii-char?.17 rbp r15 rdi)))
      (set! boolean3.3 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/any24559.11 rbp r15)))
      (set! tmp.59 rax)
      (return-point L.rp.25
        (begin
          (set! rdi tmp.59)
          (set! r15 L.rp.25)
          (jump L.empty?.18 rbp r15 rdi)))
      (set! boolean4.2 rax)
      (return-point L.rp.26
        (begin (set! r15 L.rp.26) (jump L.fun/empty24560.8 rbp r15)))
      (set! empty5.1 rax)
      (set! r15 tmp-ra.74)
      (jump L.fun/ascii-char24562.7 rbp r15))))
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
       ()
       ()
       ()
       ()
       ()
       ())))
    (define L.*.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.103 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.115 tmp.21)
                      (set! tmp.115 (bitwise-and tmp.115 7))
                      (set! tmp.57 tmp.115))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.116 tmp.20)
                        (set! tmp.116 (bitwise-and tmp.116 7))
                        (set! tmp.59 tmp.116))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.117 tmp.21)
              (set! tmp.117 (arithmetic-shift-right tmp.117 3))
              (set! tmp.60 tmp.117)
              (set! tmp.118 tmp.20)
              (set! tmp.118 (* tmp.118 tmp.60))
              (set! rax tmp.118)
              (jump tmp-ra.103 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.103 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.103 rbp rax)))))
    (define L.-.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.104 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.119 tmp.25)
                      (set! tmp.119 (bitwise-and tmp.119 7))
                      (set! tmp.62 tmp.119))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.120 tmp.24)
                        (set! tmp.120 (bitwise-and tmp.120 7))
                        (set! tmp.64 tmp.120))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.121 tmp.24)
              (set! tmp.121 (- tmp.121 tmp.25))
              (set! rax tmp.121)
              (jump tmp-ra.104 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.104 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.104 rbp rax)))))
    (define L.+.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.105 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.122 tmp.23)
                      (set! tmp.122 (bitwise-and tmp.122 7))
                      (set! tmp.66 tmp.122))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.123 tmp.22)
                        (set! tmp.123 (bitwise-and tmp.123 7))
                        (set! tmp.68 tmp.123))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.124 tmp.22)
              (set! tmp.124 (+ tmp.124 tmp.23))
              (set! rax tmp.124)
              (jump tmp-ra.105 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.105 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.105 rbp rax)))))
    (define L.fun/ascii-char29402.4
      ((new-frames ()))
      (begin (set! tmp-ra.106 r15) (set! rax 25390) (jump tmp-ra.106 rbp rax)))
    (define L.fun/empty29399.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.107 r15)
        (set! r15 tmp-ra.107)
        (jump L.fun/empty29400.10 rbp r15)))
    (define L.fun/ascii-char29401.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.108 r15)
        (set! r15 tmp-ra.108)
        (jump L.fun/ascii-char29402.4 rbp r15)))
    (define L.fun/empty29404.7
      ((new-frames ()))
      (begin (set! tmp-ra.109 r15) (set! rax 22) (jump tmp-ra.109 rbp rax)))
    (define L.fun/ascii-char29406.8
      ((new-frames ()))
      (begin (set! tmp-ra.110 r15) (set! rax 25390) (jump tmp-ra.110 rbp rax)))
    (define L.fun/ascii-char29405.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.111 r15)
        (set! r15 tmp-ra.111)
        (jump L.fun/ascii-char29406.8 rbp r15)))
    (define L.fun/empty29400.10
      ((new-frames ()))
      (begin (set! tmp-ra.112 r15) (set! rax 22) (jump tmp-ra.112 rbp rax)))
    (define L.fun/empty29403.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.113 r15)
        (set! r15 tmp-ra.113)
        (jump L.fun/empty29404.7 rbp r15)))
    (begin
      (set! tmp-ra.114 r15)
      (return-point L.rp.16
        (begin (set! r15 L.rp.16) (jump L.fun/empty29399.5 rbp r15)))
      (set! empty0.6 rax)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/ascii-char29401.6 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/empty29403.11 rbp r15)))
      (set! empty2.4 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1096)
          (set! rdi 1888)
          (set! r15 L.rp.19)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 216)
          (set! rdi 1056)
          (set! r15 L.rp.20)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.21)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 184)
          (set! rdi 888)
          (set! r15 L.rp.22)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 960)
          (set! rdi 0)
          (set! r15 L.rp.23)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.24)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.25)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 856)
          (set! rdi 1976)
          (set! r15 L.rp.26)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 1960)
          (set! rdi 1616)
          (set! r15 L.rp.27)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.28)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 392)
          (set! rdi 1592)
          (set! r15 L.rp.29)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 416)
          (set! rdi 1152)
          (set! r15 L.rp.30)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.31)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.32)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.33)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! fixnum3.3 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 784)
          (set! rdi 1160)
          (set! r15 L.rp.34)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 288)
          (set! rdi 400)
          (set! r15 L.rp.35)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.86)
          (set! rdi tmp.85)
          (set! r15 L.rp.36)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.37
        (begin
          (set! rsi 360)
          (set! rdi 640)
          (set! r15 L.rp.37)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 1856)
          (set! rdi 912)
          (set! r15 L.rp.38)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.89 rax)
      (return-point L.rp.39
        (begin
          (set! rsi tmp.89)
          (set! rdi tmp.88)
          (set! r15 L.rp.39)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.40
        (begin
          (set! rsi tmp.87)
          (set! rdi tmp.84)
          (set! r15 L.rp.40)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 1936)
          (set! rdi 360)
          (set! r15 L.rp.41)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.42
        (begin
          (set! rsi 296)
          (set! rdi 512)
          (set! r15 L.rp.42)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.93)
          (set! rdi tmp.92)
          (set! r15 L.rp.43)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.44
        (begin
          (set! rsi 704)
          (set! rdi 120)
          (set! r15 L.rp.44)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.95 rax)
      (return-point L.rp.45
        (begin
          (set! rsi 936)
          (set! rdi 328)
          (set! r15 L.rp.45)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.96 rax)
      (return-point L.rp.46
        (begin
          (set! rsi tmp.96)
          (set! rdi tmp.95)
          (set! r15 L.rp.46)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.94 rax)
      (return-point L.rp.47
        (begin
          (set! rsi tmp.94)
          (set! rdi tmp.91)
          (set! r15 L.rp.47)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (return-point L.rp.48
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.83)
          (set! r15 L.rp.48)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! fixnum4.2 rax)
      (return-point L.rp.49
        (begin (set! r15 L.rp.49) (jump L.fun/ascii-char29405.9 rbp r15)))
      (set! ascii-char5.1 rax)
      (return-point L.rp.50
        (begin
          (set! rsi fixnum3.3)
          (set! rdi fixnum4.2)
          (set! r15 L.rp.50)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.99 rax)
      (return-point L.rp.51
        (begin
          (set! rsi fixnum3.3)
          (set! rdi tmp.99)
          (set! r15 L.rp.51)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.98 rax)
      (return-point L.rp.52
        (begin
          (set! rsi fixnum3.3)
          (set! rdi tmp.98)
          (set! r15 L.rp.52)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.97 rax)
      (return-point L.rp.53
        (begin
          (set! rsi fixnum4.2)
          (set! rdi 344)
          (set! r15 L.rp.53)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.102 rax)
      (return-point L.rp.54
        (begin
          (set! rsi tmp.102)
          (set! rdi fixnum4.2)
          (set! r15 L.rp.54)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.101 rax)
      (return-point L.rp.55
        (begin
          (set! rsi tmp.101)
          (set! rdi fixnum4.2)
          (set! r15 L.rp.55)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.100 rax)
      (set! rsi tmp.100)
      (set! rdi tmp.97)
      (set! r15 tmp-ra.114)
      (jump L.*.15 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () ())))
    (define L.empty?.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.45 rdi)
        (if (begin
              (begin
                (set! tmp.99 tmp.45)
                (set! tmp.99 (bitwise-and tmp.99 255))
                (set! tmp.56 tmp.99))
              (= tmp.56 22))
          (begin (set! rax 14) (jump tmp-ra.85 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.85 rbp rax)))))
    (define L.+.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.100 tmp.23)
                      (set! tmp.100 (bitwise-and tmp.100 7))
                      (set! tmp.58 tmp.100))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.101 tmp.22)
                        (set! tmp.101 (bitwise-and tmp.101 7))
                        (set! tmp.60 tmp.101))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.102 tmp.22)
              (set! tmp.102 (+ tmp.102 tmp.23))
              (set! rax tmp.102)
              (jump tmp-ra.86 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.86 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.86 rbp rax)))))
    (define L.*.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.103 tmp.21)
                      (set! tmp.103 (bitwise-and tmp.103 7))
                      (set! tmp.62 tmp.103))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.104 tmp.20)
                        (set! tmp.104 (bitwise-and tmp.104 7))
                        (set! tmp.64 tmp.104))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.105 tmp.21)
              (set! tmp.105 (arithmetic-shift-right tmp.105 3))
              (set! tmp.65 tmp.105)
              (set! tmp.106 tmp.20)
              (set! tmp.106 (* tmp.106 tmp.65))
              (set! rax tmp.106)
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.87 rbp rax)))))
    (define L.-.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.107 tmp.25)
                      (set! tmp.107 (bitwise-and tmp.107 7))
                      (set! tmp.67 tmp.107))
                    (= tmp.67 0))
                (set! tmp.66 14)
                (set! tmp.66 6))
              (!= tmp.66 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.108 tmp.24)
                        (set! tmp.108 (bitwise-and tmp.108 7))
                        (set! tmp.69 tmp.108))
                      (= tmp.69 0))
                  (set! tmp.68 14)
                  (set! tmp.68 6))
                (!= tmp.68 6))
            (begin
              (set! tmp.109 tmp.24)
              (set! tmp.109 (- tmp.109 tmp.25))
              (set! rax tmp.109)
              (jump tmp-ra.88 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.88 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.88 rbp rax)))))
    (define L.fun/void31691.4
      ((new-frames ()))
      (begin (set! tmp-ra.89 r15) (set! rax 30) (jump tmp-ra.89 rbp rax)))
    (define L.fun/void31695.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/void31696.11 rbp r15)))
    (define L.fun/any31694.6
      ((new-frames ()))
      (begin (set! tmp-ra.91 r15) (set! rax 25390) (jump tmp-ra.91 rbp rax)))
    (define L.fun/empty31692.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/empty31693.9 rbp r15)))
    (define L.fun/void31690.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void31691.4 rbp r15)))
    (define L.fun/empty31693.9
      ((new-frames ()))
      (begin (set! tmp-ra.94 r15) (set! rax 22) (jump tmp-ra.94 rbp rax)))
    (define L.fun/empty31688.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/empty31689.12 rbp r15)))
    (define L.fun/void31696.11
      ((new-frames ()))
      (begin (set! tmp-ra.96 r15) (set! rax 30) (jump tmp-ra.96 rbp rax)))
    (define L.fun/empty31689.12
      ((new-frames ()))
      (begin (set! tmp-ra.97 r15) (set! rax 22) (jump tmp-ra.97 rbp rax)))
    (begin
      (set! tmp-ra.98 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/empty31688.10 rbp r15)))
      (set! empty0.6 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 624)
          (set! rdi 272)
          (set! r15 L.rp.19)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 920)
          (set! rdi 264)
          (set! r15 L.rp.20)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.21)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 24)
          (set! rdi 904)
          (set! r15 L.rp.22)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 1768)
          (set! rdi 1856)
          (set! r15 L.rp.23)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.24)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.71)
          (set! r15 L.rp.25)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1680)
          (set! rdi 1264)
          (set! r15 L.rp.26)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 104)
          (set! rdi 704)
          (set! r15 L.rp.27)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.79)
          (set! r15 L.rp.28)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 752)
          (set! rdi 1456)
          (set! r15 L.rp.29)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 2024)
          (set! rdi 640)
          (set! r15 L.rp.30)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.82)
          (set! r15 L.rp.31)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.78)
          (set! r15 L.rp.32)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.70)
          (set! r15 L.rp.33)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! fixnum1.5 rax)
      (return-point L.rp.34
        (begin (set! r15 L.rp.34) (jump L.fun/void31690.8 rbp r15)))
      (set! void2.4 rax)
      (return-point L.rp.35
        (begin (set! r15 L.rp.35) (jump L.fun/empty31692.7 rbp r15)))
      (set! empty3.3 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/any31694.6 rbp r15)))
      (set! tmp.84 rax)
      (return-point L.rp.37
        (begin
          (set! rdi tmp.84)
          (set! r15 L.rp.37)
          (jump L.empty?.17 rbp r15 rdi)))
      (set! boolean4.2 rax)
      (return-point L.rp.38
        (begin (set! r15 L.rp.38) (jump L.fun/void31695.5 rbp r15)))
      (set! void5.1 rax)
      (set! rax empty0.6)
      (jump tmp-ra.98 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ())))
    (define L.fun/error41241.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.56 r15)
        (set! r15 tmp-ra.56)
        (jump L.fun/error41242.12 rbp r15)))
    (define L.fun/void41237.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! r15 tmp-ra.57)
        (jump L.fun/void41238.13 rbp r15)))
    (define L.fun/error41233.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! r15 tmp-ra.58)
        (jump L.fun/error41234.9 rbp r15)))
    (define L.fun/void41232.7
      ((new-frames ()))
      (begin (set! tmp-ra.59 r15) (set! rax 30) (jump tmp-ra.59 rbp rax)))
    (define L.fun/error41236.8
      ((new-frames ()))
      (begin (set! tmp-ra.60 r15) (set! rax 574) (jump tmp-ra.60 rbp rax)))
    (define L.fun/error41234.9
      ((new-frames ()))
      (begin (set! tmp-ra.61 r15) (set! rax 8510) (jump tmp-ra.61 rbp rax)))
    (define L.fun/ascii-char41240.10
      ((new-frames ()))
      (begin (set! tmp-ra.62 r15) (set! rax 25390) (jump tmp-ra.62 rbp rax)))
    (define L.fun/void41231.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/void41232.7 rbp r15)))
    (define L.fun/error41242.12
      ((new-frames ()))
      (begin (set! tmp-ra.64 r15) (set! rax 28222) (jump tmp-ra.64 rbp rax)))
    (define L.fun/void41238.13
      ((new-frames ()))
      (begin (set! tmp-ra.65 r15) (set! rax 30) (jump tmp-ra.65 rbp rax)))
    (define L.fun/empty41244.14
      ((new-frames ()))
      (begin (set! tmp-ra.66 r15) (set! rax 22) (jump tmp-ra.66 rbp rax)))
    (define L.fun/error41235.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.67 r15)
        (set! r15 tmp-ra.67)
        (jump L.fun/error41236.8 rbp r15)))
    (define L.fun/empty41243.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.68 r15)
        (set! r15 tmp-ra.68)
        (jump L.fun/empty41244.14 rbp r15)))
    (define L.fun/ascii-char41239.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.69 r15)
        (set! r15 tmp-ra.69)
        (jump L.fun/ascii-char41240.10 rbp r15)))
    (begin
      (set! tmp-ra.70 r15)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/void41231.11 rbp r15)))
      (set! void0.6 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/error41233.6 rbp r15)))
      (set! error1.5 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/error41235.15 rbp r15)))
      (set! error2.4 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/void41237.5 rbp r15)))
      (set! void3.3 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/ascii-char41239.17 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/error41241.4 rbp r15)))
      (set! error5.1 rax)
      (set! r15 tmp-ra.70)
      (jump L.fun/empty41243.16 rbp r15))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () () ())))
    (define L.void?.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.101 tmp.46)
                (set! tmp.101 (bitwise-and tmp.101 255))
                (set! tmp.56 tmp.101))
              (= tmp.56 30))
          (begin (set! rax 14) (jump tmp-ra.87 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.87 rbp rax)))))
    (define L.fixnum?.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.43 rdi)
        (if (begin
              (begin
                (set! tmp.102 tmp.43)
                (set! tmp.102 (bitwise-and tmp.102 7))
                (set! tmp.57 tmp.102))
              (= tmp.57 0))
          (begin (set! rax 14) (jump tmp-ra.88 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.88 rbp rax)))))
    (define L.+.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.103 tmp.23)
                      (set! tmp.103 (bitwise-and tmp.103 7))
                      (set! tmp.59 tmp.103))
                    (= tmp.59 0))
                (set! tmp.58 14)
                (set! tmp.58 6))
              (!= tmp.58 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.104 tmp.22)
                        (set! tmp.104 (bitwise-and tmp.104 7))
                        (set! tmp.61 tmp.104))
                      (= tmp.61 0))
                  (set! tmp.60 14)
                  (set! tmp.60 6))
                (!= tmp.60 6))
            (begin
              (set! tmp.105 tmp.22)
              (set! tmp.105 (+ tmp.105 tmp.23))
              (set! rax tmp.105)
              (jump tmp-ra.89 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.89 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.89 rbp rax)))))
    (define L.*.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.106 tmp.21)
                      (set! tmp.106 (bitwise-and tmp.106 7))
                      (set! tmp.63 tmp.106))
                    (= tmp.63 0))
                (set! tmp.62 14)
                (set! tmp.62 6))
              (!= tmp.62 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.107 tmp.20)
                        (set! tmp.107 (bitwise-and tmp.107 7))
                        (set! tmp.65 tmp.107))
                      (= tmp.65 0))
                  (set! tmp.64 14)
                  (set! tmp.64 6))
                (!= tmp.64 6))
            (begin
              (set! tmp.108 tmp.21)
              (set! tmp.108 (arithmetic-shift-right tmp.108 3))
              (set! tmp.66 tmp.108)
              (set! tmp.109 tmp.20)
              (set! tmp.109 (* tmp.109 tmp.66))
              (set! rax tmp.109)
              (jump tmp-ra.90 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.90 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.90 rbp rax)))))
    (define L.-.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.110 tmp.25)
                      (set! tmp.110 (bitwise-and tmp.110 7))
                      (set! tmp.68 tmp.110))
                    (= tmp.68 0))
                (set! tmp.67 14)
                (set! tmp.67 6))
              (!= tmp.67 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.111 tmp.24)
                        (set! tmp.111 (bitwise-and tmp.111 7))
                        (set! tmp.70 tmp.111))
                      (= tmp.70 0))
                  (set! tmp.69 14)
                  (set! tmp.69 6))
                (!= tmp.69 6))
            (begin
              (set! tmp.112 tmp.24)
              (set! tmp.112 (- tmp.112 tmp.25))
              (set! rax tmp.112)
              (jump tmp-ra.91 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.91 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.91 rbp rax)))))
    (define L.fun/void44609.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/void44610.9 rbp r15)))
    (define L.fun/error44607.5
      ((new-frames ()))
      (begin (set! tmp-ra.93 r15) (set! rax 64830) (jump tmp-ra.93 rbp rax)))
    (define L.fun/any44605.6
      ((new-frames ()))
      (begin (set! tmp-ra.94 r15) (set! rax 22) (jump tmp-ra.94 rbp rax)))
    (define L.fun/error44606.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/error44607.5 rbp r15)))
    (define L.fun/any44608.8
      ((new-frames ()))
      (begin (set! tmp-ra.96 r15) (set! rax 30) (jump tmp-ra.96 rbp rax)))
    (define L.fun/void44610.9
      ((new-frames ()))
      (begin (set! tmp-ra.97 r15) (set! rax 30) (jump tmp-ra.97 rbp rax)))
    (define L.fun/ascii-char44603.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/ascii-char44604.11 rbp r15)))
    (define L.fun/ascii-char44604.11
      ((new-frames ()))
      (begin (set! tmp-ra.99 r15) (set! rax 25390) (jump tmp-ra.99 rbp rax)))
    (begin
      (set! tmp-ra.100 r15)
      (return-point L.rp.18
        (begin
          (set! rsi 824)
          (set! rdi 1640)
          (set! r15 L.rp.18)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 16)
          (set! rdi 1256)
          (set! r15 L.rp.19)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.73)
          (set! r15 L.rp.20)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 1552)
          (set! rdi 768)
          (set! r15 L.rp.21)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1336)
          (set! rdi 1352)
          (set! r15 L.rp.22)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.76)
          (set! r15 L.rp.23)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.72)
          (set! r15 L.rp.24)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1032)
          (set! rdi 1408)
          (set! r15 L.rp.25)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 160)
          (set! rdi 944)
          (set! r15 L.rp.26)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.80)
          (set! r15 L.rp.27)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 736)
          (set! rdi 1280)
          (set! r15 L.rp.28)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 848)
          (set! rdi 648)
          (set! r15 L.rp.29)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.84)
          (set! rdi tmp.83)
          (set! r15 L.rp.30)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.79)
          (set! r15 L.rp.31)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.78)
          (set! rdi tmp.71)
          (set! r15 L.rp.32)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.33
        (begin (set! r15 L.rp.33) (jump L.fun/ascii-char44603.10 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.34
        (begin (set! r15 L.rp.34) (jump L.fun/any44605.6 rbp r15)))
      (set! tmp.85 rax)
      (return-point L.rp.35
        (begin
          (set! rdi tmp.85)
          (set! r15 L.rp.35)
          (jump L.fixnum?.16 rbp r15 rdi)))
      (set! boolean2.4 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/error44606.7 rbp r15)))
      (set! error3.3 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/any44608.8 rbp r15)))
      (set! tmp.86 rax)
      (return-point L.rp.38
        (begin
          (set! rdi tmp.86)
          (set! r15 L.rp.38)
          (jump L.void?.17 rbp r15 rdi)))
      (set! boolean4.2 rax)
      (return-point L.rp.39
        (begin (set! r15 L.rp.39) (jump L.fun/void44609.4 rbp r15)))
      (set! void5.1 rax)
      (set! rax void5.1)
      (jump tmp-ra.100 rbp rax))))
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
    (define L.+.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.97 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.111 tmp.23)
                      (set! tmp.111 (bitwise-and tmp.111 7))
                      (set! tmp.57 tmp.111))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.112 tmp.22)
                        (set! tmp.112 (bitwise-and tmp.112 7))
                        (set! tmp.59 tmp.112))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.113 tmp.22)
              (set! tmp.113 (+ tmp.113 tmp.23))
              (set! rax tmp.113)
              (jump tmp-ra.97 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.97 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.97 rbp rax)))))
    (define L.-.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.98 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.114 tmp.25)
                      (set! tmp.114 (bitwise-and tmp.114 7))
                      (set! tmp.61 tmp.114))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.115 tmp.24)
                        (set! tmp.115 (bitwise-and tmp.115 7))
                        (set! tmp.63 tmp.115))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.116 tmp.24)
              (set! tmp.116 (- tmp.116 tmp.25))
              (set! rax tmp.116)
              (jump tmp-ra.98 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.98 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.98 rbp rax)))))
    (define L.*.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.99 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.117 tmp.21)
                      (set! tmp.117 (bitwise-and tmp.117 7))
                      (set! tmp.65 tmp.117))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.118 tmp.20)
                        (set! tmp.118 (bitwise-and tmp.118 7))
                        (set! tmp.67 tmp.118))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.119 tmp.21)
              (set! tmp.119 (arithmetic-shift-right tmp.119 3))
              (set! tmp.68 tmp.119)
              (set! tmp.120 tmp.20)
              (set! tmp.120 (* tmp.120 tmp.68))
              (set! rax tmp.120)
              (jump tmp-ra.99 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.99 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.99 rbp rax)))))
    (define L.fun/error47015.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.100 r15)
        (set! r15 tmp-ra.100)
        (jump L.fun/error47016.10 rbp r15)))
    (define L.fun/empty47018.5
      ((new-frames ()))
      (begin (set! tmp-ra.101 r15) (set! rax 22) (jump tmp-ra.101 rbp rax)))
    (define L.fun/void47024.6
      ((new-frames ()))
      (begin (set! tmp-ra.102 r15) (set! rax 30) (jump tmp-ra.102 rbp rax)))
    (define L.fun/void47023.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.103 r15)
        (set! r15 tmp-ra.103)
        (jump L.fun/void47024.6 rbp r15)))
    (define L.fun/empty47020.8
      ((new-frames ()))
      (begin (set! tmp-ra.104 r15) (set! rax 22) (jump tmp-ra.104 rbp rax)))
    (define L.fun/empty47017.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.105 r15)
        (set! r15 tmp-ra.105)
        (jump L.fun/empty47018.5 rbp r15)))
    (define L.fun/error47016.10
      ((new-frames ()))
      (begin (set! tmp-ra.106 r15) (set! rax 30270) (jump tmp-ra.106 rbp rax)))
    (define L.fun/ascii-char47022.11
      ((new-frames ()))
      (begin (set! tmp-ra.107 r15) (set! rax 25390) (jump tmp-ra.107 rbp rax)))
    (define L.fun/ascii-char47021.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.108 r15)
        (set! r15 tmp-ra.108)
        (jump L.fun/ascii-char47022.11 rbp r15)))
    (define L.fun/empty47019.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.109 r15)
        (set! r15 tmp-ra.109)
        (jump L.fun/empty47020.8 rbp r15)))
    (begin
      (set! tmp-ra.110 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/error47015.4 rbp r15)))
      (set! error0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/empty47017.9 rbp r15)))
      (set! empty1.5 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/empty47019.13 rbp r15)))
      (set! empty2.4 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/ascii-char47021.12 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1632)
          (set! rdi 1032)
          (set! r15 L.rp.22)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 264)
          (set! rdi 48)
          (set! r15 L.rp.23)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.24)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1320)
          (set! rdi 664)
          (set! r15 L.rp.25)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1736)
          (set! rdi 1672)
          (set! r15 L.rp.26)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.27)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.28)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 704)
          (set! rdi 1344)
          (set! r15 L.rp.29)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 1992)
          (set! rdi 1584)
          (set! r15 L.rp.30)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.31)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 1016)
          (set! rdi 1248)
          (set! r15 L.rp.32)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.33
        (begin
          (set! rsi 1552)
          (set! rdi 656)
          (set! r15 L.rp.33)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.34)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.35
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.35)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.36)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! fixnum4.2 rax)
      (return-point L.rp.37
        (begin
          (set! rsi 592)
          (set! rdi 1864)
          (set! r15 L.rp.37)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 2016)
          (set! rdi 392)
          (set! r15 L.rp.38)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.39
        (begin
          (set! rsi tmp.86)
          (set! rdi tmp.85)
          (set! r15 L.rp.39)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.40
        (begin
          (set! rsi 496)
          (set! rdi 1408)
          (set! r15 L.rp.40)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 1344)
          (set! rdi 96)
          (set! r15 L.rp.41)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.89 rax)
      (return-point L.rp.42
        (begin
          (set! rsi tmp.89)
          (set! rdi tmp.88)
          (set! r15 L.rp.42)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.87)
          (set! rdi tmp.84)
          (set! r15 L.rp.43)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.44
        (begin
          (set! rsi 464)
          (set! rdi 1096)
          (set! r15 L.rp.44)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.45
        (begin
          (set! rsi 1896)
          (set! rdi 1792)
          (set! r15 L.rp.45)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.46
        (begin
          (set! rsi tmp.93)
          (set! rdi tmp.92)
          (set! r15 L.rp.46)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.47
        (begin
          (set! rsi 160)
          (set! rdi 480)
          (set! r15 L.rp.47)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.95 rax)
      (return-point L.rp.48
        (begin
          (set! rsi 600)
          (set! rdi 496)
          (set! r15 L.rp.48)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.96 rax)
      (return-point L.rp.49
        (begin
          (set! rsi tmp.96)
          (set! rdi tmp.95)
          (set! r15 L.rp.49)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.94 rax)
      (return-point L.rp.50
        (begin
          (set! rsi tmp.94)
          (set! rdi tmp.91)
          (set! r15 L.rp.50)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (return-point L.rp.51
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.83)
          (set! r15 L.rp.51)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! fixnum5.1 rax)
      (set! r15 tmp-ra.110)
      (jump L.fun/void47023.7 rbp r15))))
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
    (define L.void?.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.99 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.111 tmp.46)
                (set! tmp.111 (bitwise-and tmp.111 255))
                (set! tmp.56 tmp.111))
              (= tmp.56 30))
          (begin (set! rax 14) (jump tmp-ra.99 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.99 rbp rax)))))
    (define L.*.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.100 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.112 tmp.21)
                      (set! tmp.112 (bitwise-and tmp.112 7))
                      (set! tmp.58 tmp.112))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.113 tmp.20)
                        (set! tmp.113 (bitwise-and tmp.113 7))
                        (set! tmp.60 tmp.113))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.114 tmp.21)
              (set! tmp.114 (arithmetic-shift-right tmp.114 3))
              (set! tmp.61 tmp.114)
              (set! tmp.115 tmp.20)
              (set! tmp.115 (* tmp.115 tmp.61))
              (set! rax tmp.115)
              (jump tmp-ra.100 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.100 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.100 rbp rax)))))
    (define L.+.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.101 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.116 tmp.23)
                      (set! tmp.116 (bitwise-and tmp.116 7))
                      (set! tmp.63 tmp.116))
                    (= tmp.63 0))
                (set! tmp.62 14)
                (set! tmp.62 6))
              (!= tmp.62 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.117 tmp.22)
                        (set! tmp.117 (bitwise-and tmp.117 7))
                        (set! tmp.65 tmp.117))
                      (= tmp.65 0))
                  (set! tmp.64 14)
                  (set! tmp.64 6))
                (!= tmp.64 6))
            (begin
              (set! tmp.118 tmp.22)
              (set! tmp.118 (+ tmp.118 tmp.23))
              (set! rax tmp.118)
              (jump tmp-ra.101 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.101 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.101 rbp rax)))))
    (define L.-.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.102 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.119 tmp.25)
                      (set! tmp.119 (bitwise-and tmp.119 7))
                      (set! tmp.67 tmp.119))
                    (= tmp.67 0))
                (set! tmp.66 14)
                (set! tmp.66 6))
              (!= tmp.66 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.120 tmp.24)
                        (set! tmp.120 (bitwise-and tmp.120 7))
                        (set! tmp.69 tmp.120))
                      (= tmp.69 0))
                  (set! tmp.68 14)
                  (set! tmp.68 6))
                (!= tmp.68 6))
            (begin
              (set! tmp.121 tmp.24)
              (set! tmp.121 (- tmp.121 tmp.25))
              (set! rax tmp.121)
              (jump tmp-ra.102 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.102 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.102 rbp rax)))))
    (define L.fun/error48429.4
      ((new-frames ()))
      (begin (set! tmp-ra.103 r15) (set! rax 31550) (jump tmp-ra.103 rbp rax)))
    (define L.fun/void48432.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.104 r15)
        (set! r15 tmp-ra.104)
        (jump L.fun/void48433.10 rbp r15)))
    (define L.fun/empty48430.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.105 r15)
        (set! r15 tmp-ra.105)
        (jump L.fun/empty48431.7 rbp r15)))
    (define L.fun/empty48431.7
      ((new-frames ()))
      (begin (set! tmp-ra.106 r15) (set! rax 22) (jump tmp-ra.106 rbp rax)))
    (define L.fun/any48434.8
      ((new-frames ()))
      (begin (set! tmp-ra.107 r15) (set! rax 22) (jump tmp-ra.107 rbp rax)))
    (define L.fun/error48428.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.108 r15)
        (set! r15 tmp-ra.108)
        (jump L.fun/error48429.4 rbp r15)))
    (define L.fun/void48433.10
      ((new-frames ()))
      (begin (set! tmp-ra.109 r15) (set! rax 30) (jump tmp-ra.109 rbp rax)))
    (begin
      (set! tmp-ra.110 r15)
      (return-point L.rp.16
        (begin
          (set! rsi 2016)
          (set! rdi 1920)
          (set! r15 L.rp.16)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1296)
          (set! rdi 1576)
          (set! r15 L.rp.17)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.18)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1384)
          (set! rdi 1344)
          (set! r15 L.rp.19)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 376)
          (set! rdi 1360)
          (set! r15 L.rp.20)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.21)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.71)
          (set! r15 L.rp.22)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 1448)
          (set! rdi 8)
          (set! r15 L.rp.23)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 1976)
          (set! rdi 1912)
          (set! r15 L.rp.24)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.79)
          (set! r15 L.rp.25)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1176)
          (set! rdi 1376)
          (set! r15 L.rp.26)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 392)
          (set! rdi 64)
          (set! r15 L.rp.27)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.82)
          (set! r15 L.rp.28)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.78)
          (set! r15 L.rp.29)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.70)
          (set! r15 L.rp.30)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 1584)
          (set! rdi 520)
          (set! r15 L.rp.31)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 1912)
          (set! rdi 1424)
          (set! r15 L.rp.32)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.87)
          (set! rdi tmp.86)
          (set! r15 L.rp.33)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 56)
          (set! rdi 1416)
          (set! r15 L.rp.34)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.89 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 496)
          (set! rdi 1928)
          (set! r15 L.rp.35)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.89)
          (set! r15 L.rp.36)
          (jump L.+.13 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.37
        (begin
          (set! rsi tmp.88)
          (set! rdi tmp.85)
          (set! r15 L.rp.37)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 1336)
          (set! rdi 1672)
          (set! r15 L.rp.38)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.39
        (begin
          (set! rsi 1496)
          (set! rdi 432)
          (set! r15 L.rp.39)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.94 rax)
      (return-point L.rp.40
        (begin
          (set! rsi tmp.94)
          (set! rdi tmp.93)
          (set! r15 L.rp.40)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 2008)
          (set! rdi 1000)
          (set! r15 L.rp.41)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.96 rax)
      (return-point L.rp.42
        (begin
          (set! rsi 1552)
          (set! rdi 1152)
          (set! r15 L.rp.42)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.97 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.97)
          (set! rdi tmp.96)
          (set! r15 L.rp.43)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.95 rax)
      (return-point L.rp.44
        (begin
          (set! rsi tmp.95)
          (set! rdi tmp.92)
          (set! r15 L.rp.44)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.45
        (begin
          (set! rsi tmp.91)
          (set! rdi tmp.84)
          (set! r15 L.rp.45)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! fixnum1.5 rax)
      (return-point L.rp.46
        (begin (set! r15 L.rp.46) (jump L.fun/error48428.9 rbp r15)))
      (set! error2.4 rax)
      (return-point L.rp.47
        (begin (set! r15 L.rp.47) (jump L.fun/empty48430.6 rbp r15)))
      (set! empty3.3 rax)
      (return-point L.rp.48
        (begin (set! r15 L.rp.48) (jump L.fun/void48432.5 rbp r15)))
      (set! void4.2 rax)
      (return-point L.rp.49
        (begin (set! r15 L.rp.49) (jump L.fun/any48434.8 rbp r15)))
      (set! tmp.98 rax)
      (return-point L.rp.50
        (begin
          (set! rdi tmp.98)
          (set! r15 L.rp.50)
          (jump L.void?.15 rbp r15 rdi)))
      (set! boolean5.1 rax)
      (set! rax fixnum0.6)
      (jump tmp-ra.110 rbp rax))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () ())))
    (define L.+.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.99 tmp.23)
                      (set! tmp.99 (bitwise-and tmp.99 7))
                      (set! tmp.57 tmp.99))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.100 tmp.22)
                        (set! tmp.100 (bitwise-and tmp.100 7))
                        (set! tmp.59 tmp.100))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.101 tmp.22)
              (set! tmp.101 (+ tmp.101 tmp.23))
              (set! rax tmp.101)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.83 rbp rax)))))
    (define L.-.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.102 tmp.25)
                      (set! tmp.102 (bitwise-and tmp.102 7))
                      (set! tmp.61 tmp.102))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.103 tmp.24)
                        (set! tmp.103 (bitwise-and tmp.103 7))
                        (set! tmp.63 tmp.103))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.104 tmp.24)
              (set! tmp.104 (- tmp.104 tmp.25))
              (set! rax tmp.104)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.84 rbp rax)))))
    (define L.*.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.105 tmp.21)
                      (set! tmp.105 (bitwise-and tmp.105 7))
                      (set! tmp.65 tmp.105))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.106 tmp.20)
                        (set! tmp.106 (bitwise-and tmp.106 7))
                        (set! tmp.67 tmp.106))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.107 tmp.21)
              (set! tmp.107 (arithmetic-shift-right tmp.107 3))
              (set! tmp.68 tmp.107)
              (set! tmp.108 tmp.20)
              (set! tmp.108 (* tmp.108 tmp.68))
              (set! rax tmp.108)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/ascii-char52445.4
      ((new-frames ()))
      (begin (set! tmp-ra.86 r15) (set! rax 25390) (jump tmp-ra.86 rbp rax)))
    (define L.fun/void52451.5
      ((new-frames ()))
      (begin (set! tmp-ra.87 r15) (set! rax 30) (jump tmp-ra.87 rbp rax)))
    (define L.fun/ascii-char52442.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/ascii-char52443.14 rbp r15)))
    (define L.fun/error52440.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/error52441.15 rbp r15)))
    (define L.fun/ascii-char52449.8
      ((new-frames ()))
      (begin (set! tmp-ra.90 r15) (set! rax 25390) (jump tmp-ra.90 rbp rax)))
    (define L.fun/ascii-char52448.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/ascii-char52449.8 rbp r15)))
    (define L.fun/void52450.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/void52451.5 rbp r15)))
    (define L.fun/empty52447.11
      ((new-frames ()))
      (begin (set! tmp-ra.93 r15) (set! rax 22) (jump tmp-ra.93 rbp rax)))
    (define L.fun/empty52446.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/empty52447.11 rbp r15)))
    (define L.fun/ascii-char52444.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/ascii-char52445.4 rbp r15)))
    (define L.fun/ascii-char52443.14
      ((new-frames ()))
      (begin (set! tmp-ra.96 r15) (set! rax 25390) (jump tmp-ra.96 rbp rax)))
    (define L.fun/error52441.15
      ((new-frames ()))
      (begin (set! tmp-ra.97 r15) (set! rax 62782) (jump tmp-ra.97 rbp rax)))
    (begin
      (set! tmp-ra.98 r15)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/error52440.7 rbp r15)))
      (set! error0.6 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/ascii-char52442.6 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/ascii-char52444.13 rbp r15)))
      (set! ascii-char2.4 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/empty52446.12 rbp r15)))
      (set! empty3.3 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/ascii-char52448.9 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1200)
          (set! rdi 1688)
          (set! r15 L.rp.25)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1136)
          (set! rdi 936)
          (set! r15 L.rp.26)
          (jump L.-.18 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.27)
          (jump L.-.18 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1344)
          (set! rdi 648)
          (set! r15 L.rp.28)
          (jump L.+.19 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 696)
          (set! rdi 1760)
          (set! r15 L.rp.29)
          (jump L.-.18 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.30)
          (jump L.+.19 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.31)
          (jump L.-.18 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 1136)
          (set! rdi 440)
          (set! r15 L.rp.32)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.33
        (begin
          (set! rsi 1608)
          (set! rdi 1032)
          (set! r15 L.rp.33)
          (jump L.+.19 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.34)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 8)
          (set! rdi 1032)
          (set! r15 L.rp.35)
          (jump L.-.18 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.36
        (begin
          (set! rsi 1704)
          (set! rdi 0)
          (set! r15 L.rp.36)
          (jump L.-.18 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.37
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.37)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.38
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.38)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.39
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.39)
          (jump L.+.19 rbp r15 rdi rsi)))
      (set! fixnum5.1 rax)
      (set! r15 tmp-ra.98)
      (jump L.fun/void52450.10 rbp r15))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () ())))
    (define L.-.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.99 tmp.25)
                      (set! tmp.99 (bitwise-and tmp.99 7))
                      (set! tmp.57 tmp.99))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.100 tmp.24)
                        (set! tmp.100 (bitwise-and tmp.100 7))
                        (set! tmp.59 tmp.100))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.101 tmp.24)
              (set! tmp.101 (- tmp.101 tmp.25))
              (set! rax tmp.101)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))))
    (define L.+.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.102 tmp.23)
                      (set! tmp.102 (bitwise-and tmp.102 7))
                      (set! tmp.61 tmp.102))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.103 tmp.22)
                        (set! tmp.103 (bitwise-and tmp.103 7))
                        (set! tmp.63 tmp.103))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.104 tmp.22)
              (set! tmp.104 (+ tmp.104 tmp.23))
              (set! rax tmp.104)
              (jump tmp-ra.86 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.86 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.86 rbp rax)))))
    (define L.*.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.105 tmp.21)
                      (set! tmp.105 (bitwise-and tmp.105 7))
                      (set! tmp.65 tmp.105))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.106 tmp.20)
                        (set! tmp.106 (bitwise-and tmp.106 7))
                        (set! tmp.67 tmp.106))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.107 tmp.21)
              (set! tmp.107 (arithmetic-shift-right tmp.107 3))
              (set! tmp.68 tmp.107)
              (set! tmp.108 tmp.20)
              (set! tmp.108 (* tmp.108 tmp.68))
              (set! rax tmp.108)
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.87 rbp rax)))))
    (define L.boolean?.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.109 tmp.44)
                (set! tmp.109 (bitwise-and tmp.109 247))
                (set! tmp.69 tmp.109))
              (= tmp.69 6))
          (begin (set! rax 14) (jump tmp-ra.88 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.88 rbp rax)))))
    (define L.fun/ascii-char59064.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/ascii-char59065.9 rbp r15)))
    (define L.fun/ascii-char59068.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/ascii-char59069.12 rbp r15)))
    (define L.fun/any59063.6
      ((new-frames ()))
      (begin (set! tmp-ra.91 r15) (set! rax 30) (jump tmp-ra.91 rbp rax)))
    (define L.fun/ascii-char59070.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/ascii-char59071.11 rbp r15)))
    (define L.fun/empty59066.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/empty59067.10 rbp r15)))
    (define L.fun/ascii-char59065.9
      ((new-frames ()))
      (begin (set! tmp-ra.94 r15) (set! rax 25390) (jump tmp-ra.94 rbp rax)))
    (define L.fun/empty59067.10
      ((new-frames ()))
      (begin (set! tmp-ra.95 r15) (set! rax 22) (jump tmp-ra.95 rbp rax)))
    (define L.fun/ascii-char59071.11
      ((new-frames ()))
      (begin (set! tmp-ra.96 r15) (set! rax 25390) (jump tmp-ra.96 rbp rax)))
    (define L.fun/ascii-char59069.12
      ((new-frames ()))
      (begin (set! tmp-ra.97 r15) (set! rax 25390) (jump tmp-ra.97 rbp rax)))
    (begin
      (set! tmp-ra.98 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/any59063.6 rbp r15)))
      (set! tmp.70 rax)
      (return-point L.rp.19
        (begin
          (set! rdi tmp.70)
          (set! r15 L.rp.19)
          (jump L.boolean?.14 rbp r15 rdi)))
      (set! boolean0.6 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 48)
          (set! rdi 168)
          (set! r15 L.rp.20)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 352)
          (set! rdi 1464)
          (set! r15 L.rp.21)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.73)
          (set! r15 L.rp.22)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 1888)
          (set! rdi 504)
          (set! r15 L.rp.23)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 544)
          (set! rdi 368)
          (set! r15 L.rp.24)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.76)
          (set! r15 L.rp.25)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.26
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.72)
          (set! r15 L.rp.26)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 1952)
          (set! rdi 1848)
          (set! r15 L.rp.27)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1568)
          (set! rdi 1928)
          (set! r15 L.rp.28)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.80)
          (set! r15 L.rp.29)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 720)
          (set! rdi 504)
          (set! r15 L.rp.30)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 8)
          (set! rdi 1264)
          (set! r15 L.rp.31)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.84)
          (set! rdi tmp.83)
          (set! r15 L.rp.32)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.79)
          (set! r15 L.rp.33)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.78)
          (set! rdi tmp.71)
          (set! r15 L.rp.34)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! fixnum1.5 rax)
      (return-point L.rp.35
        (begin (set! r15 L.rp.35) (jump L.fun/ascii-char59064.4 rbp r15)))
      (set! ascii-char2.4 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/empty59066.8 rbp r15)))
      (set! empty3.3 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/ascii-char59068.5 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.38
        (begin (set! r15 L.rp.38) (jump L.fun/ascii-char59070.7 rbp r15)))
      (set! ascii-char5.1 rax)
      (set! rax fixnum1.5)
      (jump tmp-ra.98 rbp rax))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () ())))
    (define L.-.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.25)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.57 tmp.97))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.24)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.59 tmp.98))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.99 tmp.24)
              (set! tmp.99 (- tmp.99 tmp.25))
              (set! rax tmp.99)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))))
    (define L.+.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.100 tmp.23)
                      (set! tmp.100 (bitwise-and tmp.100 7))
                      (set! tmp.61 tmp.100))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.101 tmp.22)
                        (set! tmp.101 (bitwise-and tmp.101 7))
                        (set! tmp.63 tmp.101))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.102 tmp.22)
              (set! tmp.102 (+ tmp.102 tmp.23))
              (set! rax tmp.102)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.84 rbp rax)))))
    (define L.*.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.103 tmp.21)
                      (set! tmp.103 (bitwise-and tmp.103 7))
                      (set! tmp.65 tmp.103))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.104 tmp.20)
                        (set! tmp.104 (bitwise-and tmp.104 7))
                        (set! tmp.67 tmp.104))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.105 tmp.21)
              (set! tmp.105 (arithmetic-shift-right tmp.105 3))
              (set! tmp.68 tmp.105)
              (set! tmp.106 tmp.20)
              (set! tmp.106 (* tmp.106 tmp.68))
              (set! rax tmp.106)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/empty59449.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (set! r15 tmp-ra.86)
        (jump L.fun/empty59450.8 rbp r15)))
    (define L.fun/ascii-char59447.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/ascii-char59448.13 rbp r15)))
    (define L.fun/error59452.6
      ((new-frames ()))
      (begin (set! tmp-ra.88 r15) (set! rax 6718) (jump tmp-ra.88 rbp rax)))
    (define L.fun/void59454.7
      ((new-frames ()))
      (begin (set! tmp-ra.89 r15) (set! rax 30) (jump tmp-ra.89 rbp rax)))
    (define L.fun/empty59450.8
      ((new-frames ()))
      (begin (set! tmp-ra.90 r15) (set! rax 22) (jump tmp-ra.90 rbp rax)))
    (define L.fun/ascii-char59445.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/ascii-char59446.10 rbp r15)))
    (define L.fun/ascii-char59446.10
      ((new-frames ()))
      (begin (set! tmp-ra.92 r15) (set! rax 25390) (jump tmp-ra.92 rbp rax)))
    (define L.fun/void59453.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void59454.7 rbp r15)))
    (define L.fun/error59451.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error59452.6 rbp r15)))
    (define L.fun/ascii-char59448.13
      ((new-frames ()))
      (begin (set! tmp-ra.95 r15) (set! rax 25390) (jump tmp-ra.95 rbp rax)))
    (begin
      (set! tmp-ra.96 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/ascii-char59445.9 rbp r15)))
      (set! ascii-char0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/ascii-char59447.5 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/empty59449.4 rbp r15)))
      (set! empty2.4 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/error59451.12 rbp r15)))
      (set! error3.3 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1688)
          (set! rdi 976)
          (set! r15 L.rp.22)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 648)
          (set! rdi 880)
          (set! r15 L.rp.23)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.24)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 760)
          (set! rdi 2024)
          (set! r15 L.rp.25)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 248)
          (set! rdi 432)
          (set! r15 L.rp.26)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.27)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.28)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 1456)
          (set! rdi 256)
          (set! r15 L.rp.29)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 408)
          (set! rdi 880)
          (set! r15 L.rp.30)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.31)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 640)
          (set! rdi 832)
          (set! r15 L.rp.32)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.33
        (begin
          (set! rsi 1232)
          (set! rdi 0)
          (set! r15 L.rp.33)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.34)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.35
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.35)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.36)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! fixnum4.2 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/void59453.11 rbp r15)))
      (set! void5.1 rax)
      (set! rax error3.3)
      (jump tmp-ra.96 rbp rax))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () () ())))
    (define L.*.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.101 tmp.21)
                      (set! tmp.101 (bitwise-and tmp.101 7))
                      (set! tmp.57 tmp.101))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.102 tmp.20)
                        (set! tmp.102 (bitwise-and tmp.102 7))
                        (set! tmp.59 tmp.102))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.103 tmp.21)
              (set! tmp.103 (arithmetic-shift-right tmp.103 3))
              (set! tmp.60 tmp.103)
              (set! tmp.104 tmp.20)
              (set! tmp.104 (* tmp.104 tmp.60))
              (set! rax tmp.104)
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.87 rbp rax)))))
    (define L.+.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.105 tmp.23)
                      (set! tmp.105 (bitwise-and tmp.105 7))
                      (set! tmp.62 tmp.105))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.106 tmp.22)
                        (set! tmp.106 (bitwise-and tmp.106 7))
                        (set! tmp.64 tmp.106))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.107 tmp.22)
              (set! tmp.107 (+ tmp.107 tmp.23))
              (set! rax tmp.107)
              (jump tmp-ra.88 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.88 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.88 rbp rax)))))
    (define L.-.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.108 tmp.25)
                      (set! tmp.108 (bitwise-and tmp.108 7))
                      (set! tmp.66 tmp.108))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.109 tmp.24)
                        (set! tmp.109 (bitwise-and tmp.109 7))
                        (set! tmp.68 tmp.109))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.110 tmp.24)
              (set! tmp.110 (- tmp.110 tmp.25))
              (set! rax tmp.110)
              (jump tmp-ra.89 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.89 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.89 rbp rax)))))
    (define L.boolean?.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.111 tmp.44)
                (set! tmp.111 (bitwise-and tmp.111 247))
                (set! tmp.69 tmp.111))
              (= tmp.69 6))
          (begin (set! rax 14) (jump tmp-ra.90 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.90 rbp rax)))))
    (define L.void?.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.112 tmp.46)
                (set! tmp.112 (bitwise-and tmp.112 255))
                (set! tmp.70 tmp.112))
              (= tmp.70 30))
          (begin (set! rax 14) (jump tmp-ra.91 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.91 rbp rax)))))
    (define L.fun/ascii-char72180.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/ascii-char72181.7 rbp r15)))
    (define L.fun/ascii-char72175.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/ascii-char72176.11 rbp r15)))
    (define L.fun/void72177.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/void72178.8 rbp r15)))
    (define L.fun/ascii-char72181.7
      ((new-frames ()))
      (begin (set! tmp-ra.95 r15) (set! rax 25390) (jump tmp-ra.95 rbp rax)))
    (define L.fun/void72178.8
      ((new-frames ()))
      (begin (set! tmp-ra.96 r15) (set! rax 30) (jump tmp-ra.96 rbp rax)))
    (define L.fun/any72179.9
      ((new-frames ()))
      (begin (set! tmp-ra.97 r15) (set! rax 25390) (jump tmp-ra.97 rbp rax)))
    (define L.fun/any72182.10
      ((new-frames ()))
      (begin (set! tmp-ra.98 r15) (set! rax 19774) (jump tmp-ra.98 rbp rax)))
    (define L.fun/ascii-char72176.11
      ((new-frames ()))
      (begin (set! tmp-ra.99 r15) (set! rax 25390) (jump tmp-ra.99 rbp rax)))
    (begin
      (set! tmp-ra.100 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/ascii-char72175.5 rbp r15)))
      (set! ascii-char0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/void72177.6 rbp r15)))
      (set! void1.5 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/any72179.9 rbp r15)))
      (set! tmp.71 rax)
      (return-point L.rp.21
        (begin
          (set! rdi tmp.71)
          (set! r15 L.rp.21)
          (jump L.void?.13 rbp r15 rdi)))
      (set! boolean2.4 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/ascii-char72180.4 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/any72182.10 rbp r15)))
      (set! tmp.72 rax)
      (return-point L.rp.24
        (begin
          (set! rdi tmp.72)
          (set! r15 L.rp.24)
          (jump L.boolean?.14 rbp r15 rdi)))
      (set! boolean4.2 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 264)
          (set! rdi 256)
          (set! r15 L.rp.25)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1384)
          (set! rdi 968)
          (set! r15 L.rp.26)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.27)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1272)
          (set! rdi 1672)
          (set! r15 L.rp.28)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 1896)
          (set! rdi 1976)
          (set! r15 L.rp.29)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.30)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.74)
          (set! r15 L.rp.31)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 1272)
          (set! rdi 1976)
          (set! r15 L.rp.32)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.33
        (begin
          (set! rsi 872)
          (set! rdi 112)
          (set! r15 L.rp.33)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.82)
          (set! r15 L.rp.34)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 1464)
          (set! rdi 304)
          (set! r15 L.rp.35)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.36
        (begin
          (set! rsi 1920)
          (set! rdi 1424)
          (set! r15 L.rp.36)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.37
        (begin
          (set! rsi tmp.86)
          (set! rdi tmp.85)
          (set! r15 L.rp.37)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.38
        (begin
          (set! rsi tmp.84)
          (set! rdi tmp.81)
          (set! r15 L.rp.38)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.39
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.73)
          (set! r15 L.rp.39)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! fixnum5.1 rax)
      (set! rax ascii-char3.3)
      (jump tmp-ra.100 rbp rax))))
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
       ())))
    (define L.+.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.103 tmp.23)
                      (set! tmp.103 (bitwise-and tmp.103 7))
                      (set! tmp.57 tmp.103))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.104 tmp.22)
                        (set! tmp.104 (bitwise-and tmp.104 7))
                        (set! tmp.59 tmp.104))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.105 tmp.22)
              (set! tmp.105 (+ tmp.105 tmp.23))
              (set! rax tmp.105)
              (jump tmp-ra.89 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.89 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.89 rbp rax)))))
    (define L.*.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.106 tmp.21)
                      (set! tmp.106 (bitwise-and tmp.106 7))
                      (set! tmp.61 tmp.106))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.107 tmp.20)
                        (set! tmp.107 (bitwise-and tmp.107 7))
                        (set! tmp.63 tmp.107))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.108 tmp.21)
              (set! tmp.108 (arithmetic-shift-right tmp.108 3))
              (set! tmp.64 tmp.108)
              (set! tmp.109 tmp.20)
              (set! tmp.109 (* tmp.109 tmp.64))
              (set! rax tmp.109)
              (jump tmp-ra.90 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.90 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.90 rbp rax)))))
    (define L.-.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.110 tmp.25)
                      (set! tmp.110 (bitwise-and tmp.110 7))
                      (set! tmp.66 tmp.110))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.111 tmp.24)
                        (set! tmp.111 (bitwise-and tmp.111 7))
                        (set! tmp.68 tmp.111))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.112 tmp.24)
              (set! tmp.112 (- tmp.112 tmp.25))
              (set! rax tmp.112)
              (jump tmp-ra.91 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.91 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.91 rbp rax)))))
    (define L.fun/empty76147.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/empty76148.12 rbp r15)))
    (define L.fun/empty76144.5
      ((new-frames ()))
      (begin (set! tmp-ra.93 r15) (set! rax 22) (jump tmp-ra.93 rbp rax)))
    (define L.fun/ascii-char76150.6
      ((new-frames ()))
      (begin (set! tmp-ra.94 r15) (set! rax 25390) (jump tmp-ra.94 rbp rax)))
    (define L.fun/void76152.7
      ((new-frames ()))
      (begin (set! tmp-ra.95 r15) (set! rax 30) (jump tmp-ra.95 rbp rax)))
    (define L.fun/void76145.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.96 r15)
        (set! r15 tmp-ra.96)
        (jump L.fun/void76146.11 rbp r15)))
    (define L.fun/ascii-char76149.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/ascii-char76150.6 rbp r15)))
    (define L.fun/empty76143.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/empty76144.5 rbp r15)))
    (define L.fun/void76146.11
      ((new-frames ()))
      (begin (set! tmp-ra.99 r15) (set! rax 30) (jump tmp-ra.99 rbp rax)))
    (define L.fun/empty76148.12
      ((new-frames ()))
      (begin (set! tmp-ra.100 r15) (set! rax 22) (jump tmp-ra.100 rbp rax)))
    (define L.fun/void76151.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.101 r15)
        (set! r15 tmp-ra.101)
        (jump L.fun/void76152.7 rbp r15)))
    (begin
      (set! tmp-ra.102 r15)
      (return-point L.rp.18
        (begin
          (set! rsi 1880)
          (set! rdi 1240)
          (set! r15 L.rp.18)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 864)
          (set! rdi 760)
          (set! r15 L.rp.19)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.20)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 1384)
          (set! rdi 224)
          (set! r15 L.rp.21)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 232)
          (set! rdi 1824)
          (set! r15 L.rp.22)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.23)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.24)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 744)
          (set! rdi 536)
          (set! r15 L.rp.25)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 128)
          (set! rdi 1920)
          (set! r15 L.rp.26)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.27)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 688)
          (set! rdi 512)
          (set! r15 L.rp.28)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 1176)
          (set! rdi 408)
          (set! r15 L.rp.29)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.30)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.31)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.32)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.33
        (begin (set! r15 L.rp.33) (jump L.fun/empty76143.10 rbp r15)))
      (set! empty1.5 rax)
      (return-point L.rp.34
        (begin (set! r15 L.rp.34) (jump L.fun/void76145.8 rbp r15)))
      (set! void2.4 rax)
      (return-point L.rp.35
        (begin (set! r15 L.rp.35) (jump L.fun/empty76147.4 rbp r15)))
      (set! empty3.3 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/ascii-char76149.9 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/void76151.13 rbp r15)))
      (set! void5.1 rax)
      (return-point L.rp.38
        (begin
          (set! rsi fixnum0.6)
          (set! rdi fixnum0.6)
          (set! r15 L.rp.38)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.39
        (begin
          (set! rsi fixnum0.6)
          (set! rdi fixnum0.6)
          (set! r15 L.rp.39)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.40
        (begin
          (set! rsi fixnum0.6)
          (set! rdi tmp.86)
          (set! r15 L.rp.40)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.41
        (begin
          (set! rsi fixnum0.6)
          (set! rdi 688)
          (set! r15 L.rp.41)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.42
        (begin
          (set! rsi tmp.88)
          (set! rdi fixnum0.6)
          (set! r15 L.rp.42)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.87)
          (set! rdi tmp.85)
          (set! r15 L.rp.43)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (set! rsi tmp.84)
      (set! rdi tmp.83)
      (set! r15 tmp-ra.102)
      (jump L.*.16 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ())))
    (define L.fun/empty82623.4
      ((new-frames ()))
      (begin (set! tmp-ra.56 r15) (set! rax 22) (jump tmp-ra.56 rbp rax)))
    (define L.fun/void82617.5
      ((new-frames ()))
      (begin (set! tmp-ra.57 r15) (set! rax 30) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error82624.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! r15 tmp-ra.58)
        (jump L.fun/error82625.7 rbp r15)))
    (define L.fun/error82625.7
      ((new-frames ()))
      (begin (set! tmp-ra.59 r15) (set! rax 59454) (jump tmp-ra.59 rbp rax)))
    (define L.fun/ascii-char82621.8
      ((new-frames ()))
      (begin (set! tmp-ra.60 r15) (set! rax 25390) (jump tmp-ra.60 rbp rax)))
    (define L.fun/error82619.9
      ((new-frames ()))
      (begin (set! tmp-ra.61 r15) (set! rax 39998) (jump tmp-ra.61 rbp rax)))
    (define L.fun/error82618.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.62 r15)
        (set! r15 tmp-ra.62)
        (jump L.fun/error82619.9 rbp r15)))
    (define L.fun/ascii-char82627.11
      ((new-frames ()))
      (begin (set! tmp-ra.63 r15) (set! rax 25390) (jump tmp-ra.63 rbp rax)))
    (define L.fun/empty82622.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.64 r15)
        (set! r15 tmp-ra.64)
        (jump L.fun/empty82623.4 rbp r15)))
    (define L.fun/ascii-char82620.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/ascii-char82621.8 rbp r15)))
    (define L.fun/ascii-char82626.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.66 r15)
        (set! r15 tmp-ra.66)
        (jump L.fun/ascii-char82627.11 rbp r15)))
    (define L.fun/void82616.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.67 r15)
        (set! r15 tmp-ra.67)
        (jump L.fun/void82617.5 rbp r15)))
    (begin
      (set! tmp-ra.68 r15)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/void82616.15 rbp r15)))
      (set! void0.6 rax)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/error82618.10 rbp r15)))
      (set! error1.5 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/ascii-char82620.13 rbp r15)))
      (set! ascii-char2.4 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/empty82622.12 rbp r15)))
      (set! empty3.3 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/error82624.6 rbp r15)))
      (set! error4.2 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/ascii-char82626.14 rbp r15)))
      (set! ascii-char5.1 rax)
      (set! rax empty3.3)
      (jump tmp-ra.68 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ())))
    (define L.fun/empty86209.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.56 r15)
        (set! r15 tmp-ra.56)
        (jump L.fun/empty86210.13 rbp r15)))
    (define L.fun/void86206.5
      ((new-frames ()))
      (begin (set! tmp-ra.57 r15) (set! rax 30) (jump tmp-ra.57 rbp rax)))
    (define L.fun/ascii-char86207.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! r15 tmp-ra.58)
        (jump L.fun/ascii-char86208.15 rbp r15)))
    (define L.fun/empty86211.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! r15 tmp-ra.59)
        (jump L.fun/empty86212.16 rbp r15)))
    (define L.fun/empty86201.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (set! r15 tmp-ra.60)
        (jump L.fun/empty86202.12 rbp r15)))
    (define L.fun/error86214.9
      ((new-frames ()))
      (begin (set! tmp-ra.61 r15) (set! rax 21310) (jump tmp-ra.61 rbp rax)))
    (define L.fun/void86205.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.62 r15)
        (set! r15 tmp-ra.62)
        (jump L.fun/void86206.5 rbp r15)))
    (define L.fun/empty86203.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/empty86204.14 rbp r15)))
    (define L.fun/empty86202.12
      ((new-frames ()))
      (begin (set! tmp-ra.64 r15) (set! rax 22) (jump tmp-ra.64 rbp rax)))
    (define L.fun/empty86210.13
      ((new-frames ()))
      (begin (set! tmp-ra.65 r15) (set! rax 22) (jump tmp-ra.65 rbp rax)))
    (define L.fun/empty86204.14
      ((new-frames ()))
      (begin (set! tmp-ra.66 r15) (set! rax 22) (jump tmp-ra.66 rbp rax)))
    (define L.fun/ascii-char86208.15
      ((new-frames ()))
      (begin (set! tmp-ra.67 r15) (set! rax 25390) (jump tmp-ra.67 rbp rax)))
    (define L.fun/empty86212.16
      ((new-frames ()))
      (begin (set! tmp-ra.68 r15) (set! rax 22) (jump tmp-ra.68 rbp rax)))
    (define L.fun/error86213.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.69 r15)
        (set! r15 tmp-ra.69)
        (jump L.fun/error86214.9 rbp r15)))
    (begin
      (set! tmp-ra.70 r15)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/empty86201.8 rbp r15)))
      (set! empty0.6 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/empty86203.11 rbp r15)))
      (set! empty1.5 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/void86205.10 rbp r15)))
      (set! void2.4 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/ascii-char86207.6 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/empty86209.4 rbp r15)))
      (set! empty4.2 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/empty86211.7 rbp r15)))
      (set! empty5.1 rax)
      (set! r15 tmp-ra.70)
      (jump L.fun/error86213.17 rbp r15))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () ())))
    (define L.-.19
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.101 tmp.25)
                      (set! tmp.101 (bitwise-and tmp.101 7))
                      (set! tmp.57 tmp.101))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.102 tmp.24)
                        (set! tmp.102 (bitwise-and tmp.102 7))
                        (set! tmp.59 tmp.102))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.103 tmp.24)
              (set! tmp.103 (- tmp.103 tmp.25))
              (set! rax tmp.103)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))))
    (define L.+.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.23)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.61 tmp.104))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.22)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.63 tmp.105))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.106 tmp.22)
              (set! tmp.106 (+ tmp.106 tmp.23))
              (set! rax tmp.106)
              (jump tmp-ra.86 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.86 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.86 rbp rax)))))
    (define L.*.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.107 tmp.21)
                      (set! tmp.107 (bitwise-and tmp.107 7))
                      (set! tmp.65 tmp.107))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.108 tmp.20)
                        (set! tmp.108 (bitwise-and tmp.108 7))
                        (set! tmp.67 tmp.108))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.109 tmp.21)
              (set! tmp.109 (arithmetic-shift-right tmp.109 3))
              (set! tmp.68 tmp.109)
              (set! tmp.110 tmp.20)
              (set! tmp.110 (* tmp.110 tmp.68))
              (set! rax tmp.110)
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.87 rbp rax)))))
    (define L.empty?.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.45 rdi)
        (if (begin
              (begin
                (set! tmp.111 tmp.45)
                (set! tmp.111 (bitwise-and tmp.111 255))
                (set! tmp.69 tmp.111))
              (= tmp.69 22))
          (begin (set! rax 14) (jump tmp-ra.88 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.88 rbp rax)))))
    (define L.fun/any89588.4
      ((new-frames ()))
      (begin (set! tmp-ra.89 r15) (set! rax 1840) (jump tmp-ra.89 rbp rax)))
    (define L.fun/void89590.5
      ((new-frames ()))
      (begin (set! tmp-ra.90 r15) (set! rax 30) (jump tmp-ra.90 rbp rax)))
    (define L.fun/void89587.6
      ((new-frames ()))
      (begin (set! tmp-ra.91 r15) (set! rax 30) (jump tmp-ra.91 rbp rax)))
    (define L.fun/error89592.7
      ((new-frames ()))
      (begin (set! tmp-ra.92 r15) (set! rax 5438) (jump tmp-ra.92 rbp rax)))
    (define L.fun/void89594.8
      ((new-frames ()))
      (begin (set! tmp-ra.93 r15) (set! rax 30) (jump tmp-ra.93 rbp rax)))
    (define L.fun/void89595.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/void89596.11 rbp r15)))
    (define L.fun/void89586.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/void89587.6 rbp r15)))
    (define L.fun/void89596.11
      ((new-frames ()))
      (begin (set! tmp-ra.96 r15) (set! rax 30) (jump tmp-ra.96 rbp rax)))
    (define L.fun/error89591.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/error89592.7 rbp r15)))
    (define L.fun/void89593.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/void89594.8 rbp r15)))
    (define L.fun/void89589.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.99 r15)
        (set! r15 tmp-ra.99)
        (jump L.fun/void89590.5 rbp r15)))
    (begin
      (set! tmp-ra.100 r15)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/void89586.10 rbp r15)))
      (set! void0.6 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/any89588.4 rbp r15)))
      (set! tmp.70 rax)
      (return-point L.rp.22
        (begin
          (set! rdi tmp.70)
          (set! r15 L.rp.22)
          (jump L.empty?.16 rbp r15 rdi)))
      (set! boolean1.5 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/void89589.14 rbp r15)))
      (set! void2.4 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/error89591.12 rbp r15)))
      (set! error3.3 rax)
      (return-point L.rp.25
        (begin (set! r15 L.rp.25) (jump L.fun/void89593.13 rbp r15)))
      (set! void4.2 rax)
      (return-point L.rp.26
        (begin (set! r15 L.rp.26) (jump L.fun/void89595.9 rbp r15)))
      (set! void5.1 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 1632)
          (set! rdi 144)
          (set! r15 L.rp.27)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1416)
          (set! rdi 1464)
          (set! r15 L.rp.28)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.73)
          (set! r15 L.rp.29)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 1064)
          (set! rdi 1152)
          (set! r15 L.rp.30)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 832)
          (set! rdi 1096)
          (set! r15 L.rp.31)
          (jump L.-.19 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.76)
          (set! r15 L.rp.32)
          (jump L.-.19 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.72)
          (set! r15 L.rp.33)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 248)
          (set! rdi 688)
          (set! r15 L.rp.34)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 240)
          (set! rdi 2000)
          (set! r15 L.rp.35)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.80)
          (set! r15 L.rp.36)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.37
        (begin
          (set! rsi 1040)
          (set! rdi 800)
          (set! r15 L.rp.37)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 312)
          (set! rdi 1224)
          (set! r15 L.rp.38)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.39
        (begin
          (set! rsi tmp.84)
          (set! rdi tmp.83)
          (set! r15 L.rp.39)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.40
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.79)
          (set! r15 L.rp.40)
          (jump L.*.17 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (set! rsi tmp.78)
      (set! rdi tmp.71)
      (set! r15 tmp-ra.100)
      (jump L.*.17 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ())))
    (define L.fun/ascii-char91899.4
      ((new-frames ()))
      (begin (set! tmp-ra.56 r15) (set! rax 25390) (jump tmp-ra.56 rbp rax)))
    (define L.fun/ascii-char91896.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! r15 tmp-ra.57)
        (jump L.fun/ascii-char91897.12 rbp r15)))
    (define L.fun/empty91891.6
      ((new-frames ()))
      (begin (set! tmp-ra.58 r15) (set! rax 22) (jump tmp-ra.58 rbp rax)))
    (define L.fun/empty91890.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! r15 tmp-ra.59)
        (jump L.fun/empty91891.6 rbp r15)))
    (define L.fun/ascii-char91892.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (set! r15 tmp-ra.60)
        (jump L.fun/ascii-char91893.15 rbp r15)))
    (define L.fun/ascii-char91898.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.61 r15)
        (set! r15 tmp-ra.61)
        (jump L.fun/ascii-char91899.4 rbp r15)))
    (define L.fun/ascii-char91894.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.62 r15)
        (set! r15 tmp-ra.62)
        (jump L.fun/ascii-char91895.14 rbp r15)))
    (define L.fun/error91900.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/error91901.13 rbp r15)))
    (define L.fun/ascii-char91897.12
      ((new-frames ()))
      (begin (set! tmp-ra.64 r15) (set! rax 25390) (jump tmp-ra.64 rbp rax)))
    (define L.fun/error91901.13
      ((new-frames ()))
      (begin (set! tmp-ra.65 r15) (set! rax 33086) (jump tmp-ra.65 rbp rax)))
    (define L.fun/ascii-char91895.14
      ((new-frames ()))
      (begin (set! tmp-ra.66 r15) (set! rax 25390) (jump tmp-ra.66 rbp rax)))
    (define L.fun/ascii-char91893.15
      ((new-frames ()))
      (begin (set! tmp-ra.67 r15) (set! rax 25390) (jump tmp-ra.67 rbp rax)))
    (begin
      (set! tmp-ra.68 r15)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/empty91890.7 rbp r15)))
      (set! empty0.6 rax)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/ascii-char91892.8 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/ascii-char91894.10 rbp r15)))
      (set! ascii-char2.4 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/ascii-char91896.5 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/ascii-char91898.9 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/error91900.11 rbp r15)))
      (set! error5.1 rax)
      (set! rax empty0.6)
      (jump tmp-ra.68 rbp rax))))
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
       ())))
    (define L.+.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.103 tmp.23)
                      (set! tmp.103 (bitwise-and tmp.103 7))
                      (set! tmp.57 tmp.103))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.104 tmp.22)
                        (set! tmp.104 (bitwise-and tmp.104 7))
                        (set! tmp.59 tmp.104))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.105 tmp.22)
              (set! tmp.105 (+ tmp.105 tmp.23))
              (set! rax tmp.105)
              (jump tmp-ra.89 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.89 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.89 rbp rax)))))
    (define L.-.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.106 tmp.25)
                      (set! tmp.106 (bitwise-and tmp.106 7))
                      (set! tmp.61 tmp.106))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.107 tmp.24)
                        (set! tmp.107 (bitwise-and tmp.107 7))
                        (set! tmp.63 tmp.107))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.108 tmp.24)
              (set! tmp.108 (- tmp.108 tmp.25))
              (set! rax tmp.108)
              (jump tmp-ra.90 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.90 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.90 rbp rax)))))
    (define L.*.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.109 tmp.21)
                      (set! tmp.109 (bitwise-and tmp.109 7))
                      (set! tmp.65 tmp.109))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.110 tmp.20)
                        (set! tmp.110 (bitwise-and tmp.110 7))
                        (set! tmp.67 tmp.110))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.111 tmp.21)
              (set! tmp.111 (arithmetic-shift-right tmp.111 3))
              (set! tmp.68 tmp.111)
              (set! tmp.112 tmp.20)
              (set! tmp.112 (* tmp.112 tmp.68))
              (set! rax tmp.112)
              (jump tmp-ra.91 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.91 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.91 rbp rax)))))
    (define L.fun/empty93185.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/empty93186.9 rbp r15)))
    (define L.fun/void93187.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void93188.11 rbp r15)))
    (define L.fun/error93189.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error93190.7 rbp r15)))
    (define L.fun/error93190.7
      ((new-frames ()))
      (begin (set! tmp-ra.95 r15) (set! rax 9790) (jump tmp-ra.95 rbp rax)))
    (define L.fun/void93193.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.96 r15)
        (set! r15 tmp-ra.96)
        (jump L.fun/void93194.12 rbp r15)))
    (define L.fun/empty93186.9
      ((new-frames ()))
      (begin (set! tmp-ra.97 r15) (set! rax 22) (jump tmp-ra.97 rbp rax)))
    (define L.fun/error93192.10
      ((new-frames ()))
      (begin (set! tmp-ra.98 r15) (set! rax 19774) (jump tmp-ra.98 rbp rax)))
    (define L.fun/void93188.11
      ((new-frames ()))
      (begin (set! tmp-ra.99 r15) (set! rax 30) (jump tmp-ra.99 rbp rax)))
    (define L.fun/void93194.12
      ((new-frames ()))
      (begin (set! tmp-ra.100 r15) (set! rax 30) (jump tmp-ra.100 rbp rax)))
    (define L.fun/error93191.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.101 r15)
        (set! r15 tmp-ra.101)
        (jump L.fun/error93192.10 rbp r15)))
    (begin
      (set! tmp-ra.102 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/empty93185.4 rbp r15)))
      (set! empty0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/void93187.5 rbp r15)))
      (set! void1.5 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 1640)
          (set! rdi 1832)
          (set! r15 L.rp.20)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 208)
          (set! rdi 1376)
          (set! r15 L.rp.21)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.22)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 40)
          (set! rdi 816)
          (set! r15 L.rp.23)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 1448)
          (set! rdi 1728)
          (set! r15 L.rp.24)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.25)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.26
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.26)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 1096)
          (set! rdi 752)
          (set! r15 L.rp.27)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1592)
          (set! rdi 592)
          (set! r15 L.rp.28)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.29)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 2000)
          (set! rdi 200)
          (set! r15 L.rp.30)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 192)
          (set! rdi 1136)
          (set! r15 L.rp.31)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.32)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.33)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.34)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! fixnum2.4 rax)
      (return-point L.rp.35
        (begin (set! r15 L.rp.35) (jump L.fun/error93189.6 rbp r15)))
      (set! error3.3 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/error93191.13 rbp r15)))
      (set! error4.2 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/void93193.8 rbp r15)))
      (set! void5.1 rax)
      (return-point L.rp.38
        (begin
          (set! rsi fixnum2.4)
          (set! rdi fixnum2.4)
          (set! r15 L.rp.38)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.39
        (begin
          (set! rsi 1464)
          (set! rdi fixnum2.4)
          (set! r15 L.rp.39)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.40
        (begin
          (set! rsi 1752)
          (set! rdi fixnum2.4)
          (set! r15 L.rp.40)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.41
        (begin
          (set! rsi tmp.87)
          (set! rdi tmp.86)
          (set! r15 L.rp.41)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.42
        (begin
          (set! rsi tmp.85)
          (set! rdi tmp.84)
          (set! r15 L.rp.42)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.43
        (begin
          (set! rsi fixnum2.4)
          (set! rdi fixnum2.4)
          (set! r15 L.rp.43)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (set! rsi tmp.88)
      (set! rdi tmp.83)
      (set! r15 tmp-ra.102)
      (jump L.+.17 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () ())))
    (define L.vector?.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.50 rdi)
        (if (begin
              (begin
                (set! tmp.99 tmp.50)
                (set! tmp.99 (bitwise-and tmp.99 7))
                (set! tmp.56 tmp.99))
              (= tmp.56 3))
          (begin (set! rax 14) (jump tmp-ra.85 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.85 rbp rax)))))
    (define L.-.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.100 tmp.25)
                      (set! tmp.100 (bitwise-and tmp.100 7))
                      (set! tmp.58 tmp.100))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.101 tmp.24)
                        (set! tmp.101 (bitwise-and tmp.101 7))
                        (set! tmp.60 tmp.101))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.102 tmp.24)
              (set! tmp.102 (- tmp.102 tmp.25))
              (set! rax tmp.102)
              (jump tmp-ra.86 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.86 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.86 rbp rax)))))
    (define L.+.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.103 tmp.23)
                      (set! tmp.103 (bitwise-and tmp.103 7))
                      (set! tmp.62 tmp.103))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.104 tmp.22)
                        (set! tmp.104 (bitwise-and tmp.104 7))
                        (set! tmp.64 tmp.104))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.105 tmp.22)
              (set! tmp.105 (+ tmp.105 tmp.23))
              (set! rax tmp.105)
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.87 rbp rax)))))
    (define L.*.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.106 tmp.21)
                      (set! tmp.106 (bitwise-and tmp.106 7))
                      (set! tmp.66 tmp.106))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.107 tmp.20)
                        (set! tmp.107 (bitwise-and tmp.107 7))
                        (set! tmp.68 tmp.107))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.108 tmp.21)
              (set! tmp.108 (arithmetic-shift-right tmp.108 3))
              (set! tmp.69 tmp.108)
              (set! tmp.109 tmp.20)
              (set! tmp.109 (* tmp.109 tmp.69))
              (set! rax tmp.109)
              (jump tmp-ra.88 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.88 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.88 rbp rax)))))
    (define L.fun/ascii-char103343.4
      ((new-frames ()))
      (begin (set! tmp-ra.89 r15) (set! rax 25390) (jump tmp-ra.89 rbp rax)))
    (define L.fun/error103339.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/error103340.7 rbp r15)))
    (define L.fun/ascii-char103337.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/ascii-char103338.12 rbp r15)))
    (define L.fun/error103340.7
      ((new-frames ()))
      (begin (set! tmp-ra.92 r15) (set! rax 41534) (jump tmp-ra.92 rbp rax)))
    (define L.fun/ascii-char103342.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/ascii-char103343.4 rbp r15)))
    (define L.fun/empty103336.9
      ((new-frames ()))
      (begin (set! tmp-ra.94 r15) (set! rax 22) (jump tmp-ra.94 rbp rax)))
    (define L.fun/any103341.10
      ((new-frames ()))
      (begin (set! tmp-ra.95 r15) (set! rax 14) (jump tmp-ra.95 rbp rax)))
    (define L.fun/empty103335.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.96 r15)
        (set! r15 tmp-ra.96)
        (jump L.fun/empty103336.9 rbp r15)))
    (define L.fun/ascii-char103338.12
      ((new-frames ()))
      (begin (set! tmp-ra.97 r15) (set! rax 25390) (jump tmp-ra.97 rbp rax)))
    (begin
      (set! tmp-ra.98 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/empty103335.11 rbp r15)))
      (set! empty0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/ascii-char103337.6 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 168)
          (set! rdi 1880)
          (set! r15 L.rp.20)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 136)
          (set! rdi 104)
          (set! r15 L.rp.21)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.22)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 744)
          (set! rdi 352)
          (set! r15 L.rp.23)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 1920)
          (set! rdi 456)
          (set! r15 L.rp.24)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.25)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.26
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.71)
          (set! r15 L.rp.26)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 168)
          (set! rdi 1888)
          (set! r15 L.rp.27)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 64)
          (set! rdi 464)
          (set! r15 L.rp.28)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.79)
          (set! r15 L.rp.29)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 160)
          (set! rdi 352)
          (set! r15 L.rp.30)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 1512)
          (set! rdi 1152)
          (set! r15 L.rp.31)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.82)
          (set! r15 L.rp.32)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.78)
          (set! r15 L.rp.33)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.70)
          (set! r15 L.rp.34)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! fixnum2.4 rax)
      (return-point L.rp.35
        (begin (set! r15 L.rp.35) (jump L.fun/error103339.5 rbp r15)))
      (set! error3.3 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/any103341.10 rbp r15)))
      (set! tmp.84 rax)
      (return-point L.rp.37
        (begin
          (set! rdi tmp.84)
          (set! r15 L.rp.37)
          (jump L.vector?.17 rbp r15 rdi)))
      (set! boolean4.2 rax)
      (return-point L.rp.38
        (begin (set! r15 L.rp.38) (jump L.fun/ascii-char103342.8 rbp r15)))
      (set! ascii-char5.1 rax)
      (set! rax error3.3)
      (jump tmp-ra.98 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () ())))
    (define L.fixnum?.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.43 rdi)
        (if (begin
              (begin
                (set! tmp.71 tmp.43)
                (set! tmp.71 (bitwise-and tmp.71 7))
                (set! tmp.56 tmp.71))
              (= tmp.56 0))
          (begin (set! rax 14) (jump tmp-ra.58 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.58 rbp rax)))))
    (define L.fun/void111249.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! r15 tmp-ra.59)
        (jump L.fun/void111250.14 rbp r15)))
    (define L.fun/error111259.5
      ((new-frames ()))
      (begin (set! tmp-ra.60 r15) (set! rax 36670) (jump tmp-ra.60 rbp rax)))
    (define L.fun/error111258.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.61 r15)
        (set! r15 tmp-ra.61)
        (jump L.fun/error111259.5 rbp r15)))
    (define L.fun/any111257.7
      ((new-frames ()))
      (begin (set! tmp-ra.62 r15) (set! rax 22) (jump tmp-ra.62 rbp rax)))
    (define L.fun/ascii-char111255.8
      ((new-frames ()))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/ascii-char111256.12 rbp r15)))
    (define L.fun/error111254.9
      ((new-frames ()))
      (begin (set! tmp-ra.64 r15) (set! rax 58430) (jump tmp-ra.64 rbp rax)))
    (define L.fun/error111253.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/error111254.9 rbp r15)))
    (define L.fun/ascii-char111251.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.66 r15)
        (set! r15 tmp-ra.66)
        (jump L.fun/ascii-char111252.13 rbp r15)))
    (define L.fun/ascii-char111256.12
      ((new-frames ()))
      (begin (set! tmp-ra.67 r15) (set! rax 25390) (jump tmp-ra.67 rbp rax)))
    (define L.fun/ascii-char111252.13
      ((new-frames ()))
      (begin (set! tmp-ra.68 r15) (set! rax 25390) (jump tmp-ra.68 rbp rax)))
    (define L.fun/void111250.14
      ((new-frames ()))
      (begin (set! tmp-ra.69 r15) (set! rax 30) (jump tmp-ra.69 rbp rax)))
    (begin
      (set! tmp-ra.70 r15)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/void111249.4 rbp r15)))
      (set! void0.6 rax)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/ascii-char111251.11 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/error111253.10 rbp r15)))
      (set! error2.4 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/ascii-char111255.8 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/any111257.7 rbp r15)))
      (set! tmp.57 rax)
      (return-point L.rp.22
        (begin
          (set! rdi tmp.57)
          (set! r15 L.rp.22)
          (jump L.fixnum?.16 rbp r15 rdi)))
      (set! boolean4.2 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/error111258.6 rbp r15)))
      (set! error5.1 rax)
      (set! rax error2.4)
      (jump tmp-ra.70 rbp rax))))
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
       ())))
    (define L.+.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.103 tmp.23)
                      (set! tmp.103 (bitwise-and tmp.103 7))
                      (set! tmp.57 tmp.103))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.104 tmp.22)
                        (set! tmp.104 (bitwise-and tmp.104 7))
                        (set! tmp.59 tmp.104))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.105 tmp.22)
              (set! tmp.105 (+ tmp.105 tmp.23))
              (set! rax tmp.105)
              (jump tmp-ra.89 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.89 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.89 rbp rax)))))
    (define L.-.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.106 tmp.25)
                      (set! tmp.106 (bitwise-and tmp.106 7))
                      (set! tmp.61 tmp.106))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.107 tmp.24)
                        (set! tmp.107 (bitwise-and tmp.107 7))
                        (set! tmp.63 tmp.107))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.108 tmp.24)
              (set! tmp.108 (- tmp.108 tmp.25))
              (set! rax tmp.108)
              (jump tmp-ra.90 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.90 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.90 rbp rax)))))
    (define L.*.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.109 tmp.21)
                      (set! tmp.109 (bitwise-and tmp.109 7))
                      (set! tmp.65 tmp.109))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.110 tmp.20)
                        (set! tmp.110 (bitwise-and tmp.110 7))
                        (set! tmp.67 tmp.110))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.111 tmp.21)
              (set! tmp.111 (arithmetic-shift-right tmp.111 3))
              (set! tmp.68 tmp.111)
              (set! tmp.112 tmp.20)
              (set! tmp.112 (* tmp.112 tmp.68))
              (set! rax tmp.112)
              (jump tmp-ra.91 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.91 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.91 rbp rax)))))
    (define L.fun/void112730.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/void112731.8 rbp r15)))
    (define L.fun/ascii-char112724.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/ascii-char112725.9 rbp r15)))
    (define L.fun/void112726.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/void112727.13 rbp r15)))
    (define L.fun/empty112733.7
      ((new-frames ()))
      (begin (set! tmp-ra.95 r15) (set! rax 22) (jump tmp-ra.95 rbp rax)))
    (define L.fun/void112731.8
      ((new-frames ()))
      (begin (set! tmp-ra.96 r15) (set! rax 30) (jump tmp-ra.96 rbp rax)))
    (define L.fun/ascii-char112725.9
      ((new-frames ()))
      (begin (set! tmp-ra.97 r15) (set! rax 25390) (jump tmp-ra.97 rbp rax)))
    (define L.fun/void112728.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/void112729.12 rbp r15)))
    (define L.fun/empty112732.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.99 r15)
        (set! r15 tmp-ra.99)
        (jump L.fun/empty112733.7 rbp r15)))
    (define L.fun/void112729.12
      ((new-frames ()))
      (begin (set! tmp-ra.100 r15) (set! rax 30) (jump tmp-ra.100 rbp rax)))
    (define L.fun/void112727.13
      ((new-frames ()))
      (begin (set! tmp-ra.101 r15) (set! rax 30) (jump tmp-ra.101 rbp rax)))
    (begin
      (set! tmp-ra.102 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/ascii-char112724.5 rbp r15)))
      (set! ascii-char0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/void112726.6 rbp r15)))
      (set! void1.5 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/void112728.10 rbp r15)))
      (set! void2.4 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 328)
          (set! rdi 984)
          (set! r15 L.rp.21)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 888)
          (set! rdi 728)
          (set! r15 L.rp.22)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.23)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 1776)
          (set! rdi 600)
          (set! r15 L.rp.24)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1456)
          (set! rdi 1904)
          (set! r15 L.rp.25)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.26
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.26)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.27)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1536)
          (set! rdi 1272)
          (set! r15 L.rp.28)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 912)
          (set! rdi 1056)
          (set! r15 L.rp.29)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.30)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 1496)
          (set! rdi 1448)
          (set! r15 L.rp.31)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 344)
          (set! rdi 568)
          (set! r15 L.rp.32)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.33)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.34)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.35
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.35)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! fixnum3.3 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/void112730.4 rbp r15)))
      (set! void4.2 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/empty112732.11 rbp r15)))
      (set! empty5.1 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 1192)
          (set! rdi fixnum3.3)
          (set! r15 L.rp.38)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.39
        (begin
          (set! rsi tmp.85)
          (set! rdi fixnum3.3)
          (set! r15 L.rp.39)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.40
        (begin
          (set! rsi fixnum3.3)
          (set! rdi tmp.84)
          (set! r15 L.rp.40)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 312)
          (set! rdi fixnum3.3)
          (set! r15 L.rp.41)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.42
        (begin
          (set! rsi fixnum3.3)
          (set! rdi tmp.88)
          (set! r15 L.rp.42)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.87)
          (set! rdi fixnum3.3)
          (set! r15 L.rp.43)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (set! rsi tmp.86)
      (set! rdi tmp.83)
      (set! r15 tmp-ra.102)
      (jump L.+.17 rbp r15 rdi rsi))))
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
    (define L.-.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.111 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.121 tmp.25)
                      (set! tmp.121 (bitwise-and tmp.121 7))
                      (set! tmp.57 tmp.121))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.122 tmp.24)
                        (set! tmp.122 (bitwise-and tmp.122 7))
                        (set! tmp.59 tmp.122))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.123 tmp.24)
              (set! tmp.123 (- tmp.123 tmp.25))
              (set! rax tmp.123)
              (jump tmp-ra.111 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.111 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.111 rbp rax)))))
    (define L.*.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.112 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.124 tmp.21)
                      (set! tmp.124 (bitwise-and tmp.124 7))
                      (set! tmp.61 tmp.124))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.125 tmp.20)
                        (set! tmp.125 (bitwise-and tmp.125 7))
                        (set! tmp.63 tmp.125))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.126 tmp.21)
              (set! tmp.126 (arithmetic-shift-right tmp.126 3))
              (set! tmp.64 tmp.126)
              (set! tmp.127 tmp.20)
              (set! tmp.127 (* tmp.127 tmp.64))
              (set! rax tmp.127)
              (jump tmp-ra.112 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.112 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.112 rbp rax)))))
    (define L.+.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.113 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.128 tmp.23)
                      (set! tmp.128 (bitwise-and tmp.128 7))
                      (set! tmp.66 tmp.128))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.129 tmp.22)
                        (set! tmp.129 (bitwise-and tmp.129 7))
                        (set! tmp.68 tmp.129))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.130 tmp.22)
              (set! tmp.130 (+ tmp.130 tmp.23))
              (set! rax tmp.130)
              (jump tmp-ra.113 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.113 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.113 rbp rax)))))
    (define L.fun/ascii-char117132.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.114 r15)
        (set! r15 tmp-ra.114)
        (jump L.fun/ascii-char117133.9 rbp r15)))
    (define L.fun/ascii-char117129.5
      ((new-frames ()))
      (begin (set! tmp-ra.115 r15) (set! rax 25390) (jump tmp-ra.115 rbp rax)))
    (define L.fun/ascii-char117130.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.116 r15)
        (set! r15 tmp-ra.116)
        (jump L.fun/ascii-char117131.8 rbp r15)))
    (define L.fun/ascii-char117128.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.117 r15)
        (set! r15 tmp-ra.117)
        (jump L.fun/ascii-char117129.5 rbp r15)))
    (define L.fun/ascii-char117131.8
      ((new-frames ()))
      (begin (set! tmp-ra.118 r15) (set! rax 25390) (jump tmp-ra.118 rbp rax)))
    (define L.fun/ascii-char117133.9
      ((new-frames ()))
      (begin (set! tmp-ra.119 r15) (set! rax 25390) (jump tmp-ra.119 rbp rax)))
    (begin
      (set! tmp-ra.120 r15)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/ascii-char117128.7 rbp r15)))
      (set! ascii-char0.6 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 552)
          (set! rdi 176)
          (set! r15 L.rp.15)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 144)
          (set! rdi 1824)
          (set! r15 L.rp.16)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.17
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.17)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 1264)
          (set! rdi 984)
          (set! r15 L.rp.18)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1280)
          (set! rdi 32)
          (set! r15 L.rp.19)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.20)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.21)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1416)
          (set! rdi 1536)
          (set! r15 L.rp.22)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 616)
          (set! rdi 1072)
          (set! r15 L.rp.23)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.24)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1976)
          (set! rdi 384)
          (set! r15 L.rp.25)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1288)
          (set! rdi 400)
          (set! r15 L.rp.26)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.27)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.28)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.29)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! fixnum1.5 rax)
      (return-point L.rp.30
        (begin (set! r15 L.rp.30) (jump L.fun/ascii-char117130.6 rbp r15)))
      (set! ascii-char2.4 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 1344)
          (set! rdi 576)
          (set! r15 L.rp.31)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 1816)
          (set! rdi 528)
          (set! r15 L.rp.32)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.86)
          (set! rdi tmp.85)
          (set! r15 L.rp.33)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 864)
          (set! rdi 1160)
          (set! r15 L.rp.34)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 96)
          (set! rdi 1360)
          (set! r15 L.rp.35)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.89 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.89)
          (set! rdi tmp.88)
          (set! r15 L.rp.36)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.37
        (begin
          (set! rsi tmp.87)
          (set! rdi tmp.84)
          (set! r15 L.rp.37)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 344)
          (set! rdi 240)
          (set! r15 L.rp.38)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.39
        (begin
          (set! rsi 1080)
          (set! rdi 1928)
          (set! r15 L.rp.39)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.40
        (begin
          (set! rsi tmp.93)
          (set! rdi tmp.92)
          (set! r15 L.rp.40)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 448)
          (set! rdi 808)
          (set! r15 L.rp.41)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.95 rax)
      (return-point L.rp.42
        (begin
          (set! rsi 2000)
          (set! rdi 1296)
          (set! r15 L.rp.42)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.96 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.96)
          (set! rdi tmp.95)
          (set! r15 L.rp.43)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.94 rax)
      (return-point L.rp.44
        (begin
          (set! rsi tmp.94)
          (set! rdi tmp.91)
          (set! r15 L.rp.44)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (return-point L.rp.45
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.83)
          (set! r15 L.rp.45)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! fixnum3.3 rax)
      (return-point L.rp.46
        (begin (set! r15 L.rp.46) (jump L.fun/ascii-char117132.4 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.47
        (begin
          (set! rsi 1456)
          (set! rdi 1672)
          (set! r15 L.rp.47)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.99 rax)
      (return-point L.rp.48
        (begin
          (set! rsi 480)
          (set! rdi 1696)
          (set! r15 L.rp.48)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.100 rax)
      (return-point L.rp.49
        (begin
          (set! rsi tmp.100)
          (set! rdi tmp.99)
          (set! r15 L.rp.49)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.98 rax)
      (return-point L.rp.50
        (begin
          (set! rsi 616)
          (set! rdi 320)
          (set! r15 L.rp.50)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.102 rax)
      (return-point L.rp.51
        (begin
          (set! rsi 1056)
          (set! rdi 1016)
          (set! r15 L.rp.51)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.103 rax)
      (return-point L.rp.52
        (begin
          (set! rsi tmp.103)
          (set! rdi tmp.102)
          (set! r15 L.rp.52)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.101 rax)
      (return-point L.rp.53
        (begin
          (set! rsi tmp.101)
          (set! rdi tmp.98)
          (set! r15 L.rp.53)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.97 rax)
      (return-point L.rp.54
        (begin
          (set! rsi 1176)
          (set! rdi 832)
          (set! r15 L.rp.54)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.106 rax)
      (return-point L.rp.55
        (begin
          (set! rsi 328)
          (set! rdi 248)
          (set! r15 L.rp.55)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.107 rax)
      (return-point L.rp.56
        (begin
          (set! rsi tmp.107)
          (set! rdi tmp.106)
          (set! r15 L.rp.56)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.105 rax)
      (return-point L.rp.57
        (begin
          (set! rsi 1952)
          (set! rdi 920)
          (set! r15 L.rp.57)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.109 rax)
      (return-point L.rp.58
        (begin
          (set! rsi 1000)
          (set! rdi 320)
          (set! r15 L.rp.58)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.110 rax)
      (return-point L.rp.59
        (begin
          (set! rsi tmp.110)
          (set! rdi tmp.109)
          (set! r15 L.rp.59)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.108 rax)
      (return-point L.rp.60
        (begin
          (set! rsi tmp.108)
          (set! rdi tmp.105)
          (set! r15 L.rp.60)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.104 rax)
      (return-point L.rp.61
        (begin
          (set! rsi tmp.104)
          (set! rdi tmp.97)
          (set! r15 L.rp.61)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! fixnum5.1 rax)
      (set! rax ascii-char0.6)
      (jump tmp-ra.120 rbp rax))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () ())))
    (define L.empty?.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.45 rdi)
        (if (begin
              (begin
                (set! tmp.99 tmp.45)
                (set! tmp.99 (bitwise-and tmp.99 255))
                (set! tmp.56 tmp.99))
              (= tmp.56 22))
          (begin (set! rax 14) (jump tmp-ra.85 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.85 rbp rax)))))
    (define L.*.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.100 tmp.21)
                      (set! tmp.100 (bitwise-and tmp.100 7))
                      (set! tmp.58 tmp.100))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.101 tmp.20)
                        (set! tmp.101 (bitwise-and tmp.101 7))
                        (set! tmp.60 tmp.101))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.102 tmp.21)
              (set! tmp.102 (arithmetic-shift-right tmp.102 3))
              (set! tmp.61 tmp.102)
              (set! tmp.103 tmp.20)
              (set! tmp.103 (* tmp.103 tmp.61))
              (set! rax tmp.103)
              (jump tmp-ra.86 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.86 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.86 rbp rax)))))
    (define L.-.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.25)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.63 tmp.104))
                    (= tmp.63 0))
                (set! tmp.62 14)
                (set! tmp.62 6))
              (!= tmp.62 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.24)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.65 tmp.105))
                      (= tmp.65 0))
                  (set! tmp.64 14)
                  (set! tmp.64 6))
                (!= tmp.64 6))
            (begin
              (set! tmp.106 tmp.24)
              (set! tmp.106 (- tmp.106 tmp.25))
              (set! rax tmp.106)
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.87 rbp rax)))))
    (define L.+.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.107 tmp.23)
                      (set! tmp.107 (bitwise-and tmp.107 7))
                      (set! tmp.67 tmp.107))
                    (= tmp.67 0))
                (set! tmp.66 14)
                (set! tmp.66 6))
              (!= tmp.66 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.108 tmp.22)
                        (set! tmp.108 (bitwise-and tmp.108 7))
                        (set! tmp.69 tmp.108))
                      (= tmp.69 0))
                  (set! tmp.68 14)
                  (set! tmp.68 6))
                (!= tmp.68 6))
            (begin
              (set! tmp.109 tmp.22)
              (set! tmp.109 (+ tmp.109 tmp.23))
              (set! rax tmp.109)
              (jump tmp-ra.88 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.88 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.88 rbp rax)))))
    (define L.fun/void117486.4
      ((new-frames ()))
      (begin (set! tmp-ra.89 r15) (set! rax 30) (jump tmp-ra.89 rbp rax)))
    (define L.fun/any117487.5
      ((new-frames ()))
      (begin (set! tmp-ra.90 r15) (set! rax 6) (jump tmp-ra.90 rbp rax)))
    (define L.fun/void117490.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/void117491.11 rbp r15)))
    (define L.fun/error117483.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/error117484.12 rbp r15)))
    (define L.fun/empty117489.8
      ((new-frames ()))
      (begin (set! tmp-ra.93 r15) (set! rax 22) (jump tmp-ra.93 rbp rax)))
    (define L.fun/void117485.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/void117486.4 rbp r15)))
    (define L.fun/empty117488.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/empty117489.8 rbp r15)))
    (define L.fun/void117491.11
      ((new-frames ()))
      (begin (set! tmp-ra.96 r15) (set! rax 30) (jump tmp-ra.96 rbp rax)))
    (define L.fun/error117484.12
      ((new-frames ()))
      (begin (set! tmp-ra.97 r15) (set! rax 5182) (jump tmp-ra.97 rbp rax)))
    (begin
      (set! tmp-ra.98 r15)
      (return-point L.rp.18
        (begin
          (set! rsi 1440)
          (set! rdi 984)
          (set! r15 L.rp.18)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 592)
          (set! rdi 608)
          (set! r15 L.rp.19)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.20)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 1672)
          (set! rdi 256)
          (set! r15 L.rp.21)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 648)
          (set! rdi 1728)
          (set! r15 L.rp.22)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.23)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.71)
          (set! r15 L.rp.24)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1552)
          (set! rdi 320)
          (set! r15 L.rp.25)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1760)
          (set! rdi 1760)
          (set! r15 L.rp.26)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.79)
          (set! r15 L.rp.27)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1384)
          (set! rdi 1272)
          (set! r15 L.rp.28)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 1192)
          (set! rdi 1856)
          (set! r15 L.rp.29)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.82)
          (set! r15 L.rp.30)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.78)
          (set! r15 L.rp.31)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.70)
          (set! r15 L.rp.32)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.33
        (begin (set! r15 L.rp.33) (jump L.fun/error117483.7 rbp r15)))
      (set! error1.5 rax)
      (return-point L.rp.34
        (begin (set! r15 L.rp.34) (jump L.fun/void117485.9 rbp r15)))
      (set! void2.4 rax)
      (return-point L.rp.35
        (begin (set! r15 L.rp.35) (jump L.fun/any117487.5 rbp r15)))
      (set! tmp.84 rax)
      (return-point L.rp.36
        (begin
          (set! rdi tmp.84)
          (set! r15 L.rp.36)
          (jump L.empty?.17 rbp r15 rdi)))
      (set! boolean3.3 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/empty117488.10 rbp r15)))
      (set! empty4.2 rax)
      (return-point L.rp.38
        (begin (set! r15 L.rp.38) (jump L.fun/void117490.6 rbp r15)))
      (set! void5.1 rax)
      (set! rax empty4.2)
      (jump tmp-ra.98 rbp rax))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () ())))
    (define L.-.17
      ((new-frames ()))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.25)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.57 tmp.97))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.24)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.59 tmp.98))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.99 tmp.24)
              (set! tmp.99 (- tmp.99 tmp.25))
              (set! rax tmp.99)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))))
    (define L.*.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.100 tmp.21)
                      (set! tmp.100 (bitwise-and tmp.100 7))
                      (set! tmp.61 tmp.100))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.101 tmp.20)
                        (set! tmp.101 (bitwise-and tmp.101 7))
                        (set! tmp.63 tmp.101))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.102 tmp.21)
              (set! tmp.102 (arithmetic-shift-right tmp.102 3))
              (set! tmp.64 tmp.102)
              (set! tmp.103 tmp.20)
              (set! tmp.103 (* tmp.103 tmp.64))
              (set! rax tmp.103)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.84 rbp rax)))))
    (define L.+.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.23)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.66 tmp.104))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.22)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.68 tmp.105))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.106 tmp.22)
              (set! tmp.106 (+ tmp.106 tmp.23))
              (set! rax tmp.106)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/void118048.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.86 r15)
        (set! r15 tmp-ra.86)
        (jump L.fun/void118049.8 rbp r15)))
    (define L.fun/ascii-char118051.5
      ((new-frames ()))
      (begin (set! tmp-ra.87 r15) (set! rax 25390) (jump tmp-ra.87 rbp rax)))
    (define L.fun/void118045.6
      ((new-frames ()))
      (begin (set! tmp-ra.88 r15) (set! rax 30) (jump tmp-ra.88 rbp rax)))
    (define L.fun/error118053.7
      ((new-frames ()))
      (begin (set! tmp-ra.89 r15) (set! rax 47678) (jump tmp-ra.89 rbp rax)))
    (define L.fun/void118049.8
      ((new-frames ()))
      (begin (set! tmp-ra.90 r15) (set! rax 30) (jump tmp-ra.90 rbp rax)))
    (define L.fun/void118046.9
      ((new-frames ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/void118047.11 rbp r15)))
    (define L.fun/void118044.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/void118045.6 rbp r15)))
    (define L.fun/void118047.11
      ((new-frames ()))
      (begin (set! tmp-ra.93 r15) (set! rax 30) (jump tmp-ra.93 rbp rax)))
    (define L.fun/error118052.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error118053.7 rbp r15)))
    (define L.fun/ascii-char118050.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/ascii-char118051.5 rbp r15)))
    (begin
      (set! tmp-ra.96 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/void118044.10 rbp r15)))
      (set! void0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/void118046.9 rbp r15)))
      (set! void1.5 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/void118048.4 rbp r15)))
      (set! void2.4 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/ascii-char118050.13 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/error118052.12 rbp r15)))
      (set! error4.2 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 1240)
          (set! rdi 528)
          (set! r15 L.rp.23)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 1304)
          (set! rdi 1216)
          (set! r15 L.rp.24)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.25)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 936)
          (set! rdi 1552)
          (set! r15 L.rp.26)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 760)
          (set! rdi 1888)
          (set! r15 L.rp.27)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.28)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.29)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 776)
          (set! rdi 384)
          (set! r15 L.rp.30)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 800)
          (set! rdi 1824)
          (set! r15 L.rp.31)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.32)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.33
        (begin
          (set! rsi 1200)
          (set! rdi 976)
          (set! r15 L.rp.33)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 1864)
          (set! rdi 1504)
          (set! r15 L.rp.34)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.35
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.35)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.36)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.37
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.37)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! fixnum5.1 rax)
      (set! rax ascii-char3.3)
      (jump tmp-ra.96 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () ())))
    (define L.pair?.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.49 rdi)
        (if (begin
              (begin
                (set! tmp.73 tmp.49)
                (set! tmp.73 (bitwise-and tmp.73 7))
                (set! tmp.56 tmp.73))
              (= tmp.56 1))
          (begin (set! rax 14) (jump tmp-ra.58 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.58 rbp rax)))))
    (define L.fun/void123827.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! r15 tmp-ra.59)
        (jump L.fun/void123828.8 rbp r15)))
    (define L.fun/empty123825.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.60 r15)
        (set! r15 tmp-ra.60)
        (jump L.fun/empty123826.10 rbp r15)))
    (define L.fun/empty123831.6
      ((new-frames ()))
      (begin
        (set! tmp-ra.61 r15)
        (set! r15 tmp-ra.61)
        (jump L.fun/empty123832.14 rbp r15)))
    (define L.fun/error123823.7
      ((new-frames ()))
      (begin
        (set! tmp-ra.62 r15)
        (set! r15 tmp-ra.62)
        (jump L.fun/error123824.15 rbp r15)))
    (define L.fun/void123828.8
      ((new-frames ()))
      (begin (set! tmp-ra.63 r15) (set! rax 30) (jump tmp-ra.63 rbp rax)))
    (define L.fun/any123822.9
      ((new-frames ()))
      (begin (set! tmp-ra.64 r15) (set! rax 25390) (jump tmp-ra.64 rbp rax)))
    (define L.fun/empty123826.10
      ((new-frames ()))
      (begin (set! tmp-ra.65 r15) (set! rax 22) (jump tmp-ra.65 rbp rax)))
    (define L.fun/error123830.11
      ((new-frames ()))
      (begin (set! tmp-ra.66 r15) (set! rax 42814) (jump tmp-ra.66 rbp rax)))
    (define L.fun/error123829.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.67 r15)
        (set! r15 tmp-ra.67)
        (jump L.fun/error123830.11 rbp r15)))
    (define L.fun/ascii-char123833.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.68 r15)
        (set! r15 tmp-ra.68)
        (jump L.fun/ascii-char123834.16 rbp r15)))
    (define L.fun/empty123832.14
      ((new-frames ()))
      (begin (set! tmp-ra.69 r15) (set! rax 22) (jump tmp-ra.69 rbp rax)))
    (define L.fun/error123824.15
      ((new-frames ()))
      (begin (set! tmp-ra.70 r15) (set! rax 32062) (jump tmp-ra.70 rbp rax)))
    (define L.fun/ascii-char123834.16
      ((new-frames ()))
      (begin (set! tmp-ra.71 r15) (set! rax 25390) (jump tmp-ra.71 rbp rax)))
    (begin
      (set! tmp-ra.72 r15)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/any123822.9 rbp r15)))
      (set! tmp.57 rax)
      (return-point L.rp.20
        (begin
          (set! rdi tmp.57)
          (set! r15 L.rp.20)
          (jump L.pair?.18 rbp r15 rdi)))
      (set! boolean0.6 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/error123823.7 rbp r15)))
      (set! error1.5 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/empty123825.5 rbp r15)))
      (set! empty2.4 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/void123827.4 rbp r15)))
      (set! void3.3 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/error123829.12 rbp r15)))
      (set! error4.2 rax)
      (return-point L.rp.25
        (begin (set! r15 L.rp.25) (jump L.fun/empty123831.6 rbp r15)))
      (set! empty5.1 rax)
      (set! r15 tmp-ra.72)
      (jump L.fun/ascii-char123833.13 rbp r15))))
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
       ()
       ()
       ()
       ()
       ())))
    (define L.error?.15
      ((new-frames ()))
      (begin
        (set! tmp-ra.105 r15)
        (set! tmp.48 rdi)
        (if (begin
              (begin
                (set! tmp.117 tmp.48)
                (set! tmp.117 (bitwise-and tmp.117 255))
                (set! tmp.56 tmp.117))
              (= tmp.56 62))
          (begin (set! rax 14) (jump tmp-ra.105 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.105 rbp rax)))))
    (define L.boolean?.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.106 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.118 tmp.44)
                (set! tmp.118 (bitwise-and tmp.118 247))
                (set! tmp.57 tmp.118))
              (= tmp.57 6))
          (begin (set! rax 14) (jump tmp-ra.106 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.106 rbp rax)))))
    (define L.void?.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.107 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.119 tmp.46)
                (set! tmp.119 (bitwise-and tmp.119 255))
                (set! tmp.58 tmp.119))
              (= tmp.58 30))
          (begin (set! rax 14) (jump tmp-ra.107 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.107 rbp rax)))))
    (define L.*.12
      ((new-frames ()))
      (begin
        (set! tmp-ra.108 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.120 tmp.21)
                      (set! tmp.120 (bitwise-and tmp.120 7))
                      (set! tmp.60 tmp.120))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.121 tmp.20)
                        (set! tmp.121 (bitwise-and tmp.121 7))
                        (set! tmp.62 tmp.121))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.122 tmp.21)
              (set! tmp.122 (arithmetic-shift-right tmp.122 3))
              (set! tmp.63 tmp.122)
              (set! tmp.123 tmp.20)
              (set! tmp.123 (* tmp.123 tmp.63))
              (set! rax tmp.123)
              (jump tmp-ra.108 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.108 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.108 rbp rax)))))
    (define L.+.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.109 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.124 tmp.23)
                      (set! tmp.124 (bitwise-and tmp.124 7))
                      (set! tmp.65 tmp.124))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.125 tmp.22)
                        (set! tmp.125 (bitwise-and tmp.125 7))
                        (set! tmp.67 tmp.125))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.126 tmp.22)
              (set! tmp.126 (+ tmp.126 tmp.23))
              (set! rax tmp.126)
              (jump tmp-ra.109 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.109 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.109 rbp rax)))))
    (define L.-.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.110 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.127 tmp.25)
                      (set! tmp.127 (bitwise-and tmp.127 7))
                      (set! tmp.69 tmp.127))
                    (= tmp.69 0))
                (set! tmp.68 14)
                (set! tmp.68 6))
              (!= tmp.68 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.128 tmp.24)
                        (set! tmp.128 (bitwise-and tmp.128 7))
                        (set! tmp.71 tmp.128))
                      (= tmp.71 0))
                  (set! tmp.70 14)
                  (set! tmp.70 6))
                (!= tmp.70 6))
            (begin
              (set! tmp.129 tmp.24)
              (set! tmp.129 (- tmp.129 tmp.25))
              (set! rax tmp.129)
              (jump tmp-ra.110 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.110 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.110 rbp rax)))))
    (define L.fun/empty126710.4
      ((new-frames ()))
      (begin (set! tmp-ra.111 r15) (set! rax 22) (jump tmp-ra.111 rbp rax)))
    (define L.fun/empty126709.5
      ((new-frames ()))
      (begin
        (set! tmp-ra.112 r15)
        (set! r15 tmp-ra.112)
        (jump L.fun/empty126710.4 rbp r15)))
    (define L.fun/any126713.6
      ((new-frames ()))
      (begin (set! tmp-ra.113 r15) (set! rax 25390) (jump tmp-ra.113 rbp rax)))
    (define L.fun/any126711.7
      ((new-frames ()))
      (begin (set! tmp-ra.114 r15) (set! rax 1184) (jump tmp-ra.114 rbp rax)))
    (define L.fun/any126712.8
      ((new-frames ()))
      (begin (set! tmp-ra.115 r15) (set! rax 30) (jump tmp-ra.115 rbp rax)))
    (begin
      (set! tmp-ra.116 r15)
      (return-point L.rp.16
        (begin
          (set! rsi 1152)
          (set! rdi 464)
          (set! r15 L.rp.16)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 56)
          (set! rdi 1752)
          (set! r15 L.rp.17)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.18)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 904)
          (set! rdi 992)
          (set! r15 L.rp.19)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 488)
          (set! rdi 128)
          (set! r15 L.rp.20)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.78)
          (set! rdi tmp.77)
          (set! r15 L.rp.21)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.73)
          (set! r15 L.rp.22)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 856)
          (set! rdi 1744)
          (set! r15 L.rp.23)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 736)
          (set! rdi 648)
          (set! r15 L.rp.24)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.25)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 712)
          (set! rdi 104)
          (set! r15 L.rp.26)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 1896)
          (set! rdi 264)
          (set! r15 L.rp.27)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.85)
          (set! rdi tmp.84)
          (set! r15 L.rp.28)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.80)
          (set! r15 L.rp.29)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.72)
          (set! r15 L.rp.30)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.31
        (begin (set! r15 L.rp.31) (jump L.fun/empty126709.5 rbp r15)))
      (set! empty1.5 rax)
      (return-point L.rp.32
        (begin (set! r15 L.rp.32) (jump L.fun/any126711.7 rbp r15)))
      (set! tmp.86 rax)
      (return-point L.rp.33
        (begin
          (set! rdi tmp.86)
          (set! r15 L.rp.33)
          (jump L.void?.13 rbp r15 rdi)))
      (set! boolean2.4 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 904)
          (set! rdi 72)
          (set! r15 L.rp.34)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.89 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 448)
          (set! rdi 816)
          (set! r15 L.rp.35)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.89)
          (set! r15 L.rp.36)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.37
        (begin
          (set! rsi 848)
          (set! rdi 136)
          (set! r15 L.rp.37)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 1872)
          (set! rdi 1088)
          (set! r15 L.rp.38)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.39
        (begin
          (set! rsi tmp.93)
          (set! rdi tmp.92)
          (set! r15 L.rp.39)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.40
        (begin
          (set! rsi tmp.91)
          (set! rdi tmp.88)
          (set! r15 L.rp.40)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 976)
          (set! rdi 376)
          (set! r15 L.rp.41)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.96 rax)
      (return-point L.rp.42
        (begin
          (set! rsi 304)
          (set! rdi 1784)
          (set! r15 L.rp.42)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.97 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.97)
          (set! rdi tmp.96)
          (set! r15 L.rp.43)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.95 rax)
      (return-point L.rp.44
        (begin
          (set! rsi 368)
          (set! rdi 1416)
          (set! r15 L.rp.44)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.99 rax)
      (return-point L.rp.45
        (begin
          (set! rsi 1720)
          (set! rdi 1784)
          (set! r15 L.rp.45)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.100 rax)
      (return-point L.rp.46
        (begin
          (set! rsi tmp.100)
          (set! rdi tmp.99)
          (set! r15 L.rp.46)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.98 rax)
      (return-point L.rp.47
        (begin
          (set! rsi tmp.98)
          (set! rdi tmp.95)
          (set! r15 L.rp.47)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.94 rax)
      (return-point L.rp.48
        (begin
          (set! rsi tmp.94)
          (set! rdi tmp.87)
          (set! r15 L.rp.48)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! fixnum3.3 rax)
      (return-point L.rp.49
        (begin (set! r15 L.rp.49) (jump L.fun/any126712.8 rbp r15)))
      (set! tmp.101 rax)
      (return-point L.rp.50
        (begin
          (set! rdi tmp.101)
          (set! r15 L.rp.50)
          (jump L.boolean?.14 rbp r15 rdi)))
      (set! boolean4.2 rax)
      (return-point L.rp.51
        (begin (set! r15 L.rp.51) (jump L.fun/any126713.6 rbp r15)))
      (set! tmp.102 rax)
      (return-point L.rp.52
        (begin
          (set! rdi tmp.102)
          (set! r15 L.rp.52)
          (jump L.error?.15 rbp r15 rdi)))
      (set! boolean5.1 rax)
      (return-point L.rp.53
        (begin
          (set! rsi fixnum3.3)
          (set! rdi fixnum0.6)
          (set! r15 L.rp.53)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.104 rax)
      (return-point L.rp.54
        (begin
          (set! rsi fixnum0.6)
          (set! rdi tmp.104)
          (set! r15 L.rp.54)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.103 rax)
      (set! rsi tmp.103)
      (set! rdi fixnum3.3)
      (set! r15 tmp-ra.116)
      (jump L.-.10 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () ())))
    (define L.vector?.18
      ((new-frames ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.50 rdi)
        (if (begin
              (begin
                (set! tmp.73 tmp.50)
                (set! tmp.73 (bitwise-and tmp.73 7))
                (set! tmp.56 tmp.73))
              (= tmp.56 3))
          (begin (set! rax 14) (jump tmp-ra.58 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.58 rbp rax)))))
    (define L.fun/error129841.4
      ((new-frames ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! r15 tmp-ra.59)
        (jump L.fun/error129842.9 rbp r15)))
    (define L.fun/ascii-char129834.5
      ((new-frames ()))
      (begin (set! tmp-ra.60 r15) (set! rax 25390) (jump tmp-ra.60 rbp rax)))
    (define L.fun/ascii-char129832.6
      ((new-frames ()))
      (begin (set! tmp-ra.61 r15) (set! rax 25390) (jump tmp-ra.61 rbp rax)))
    (define L.fun/empty129840.7
      ((new-frames ()))
      (begin (set! tmp-ra.62 r15) (set! rax 22) (jump tmp-ra.62 rbp rax)))
    (define L.fun/empty129836.8
      ((new-frames ()))
      (begin (set! tmp-ra.63 r15) (set! rax 22) (jump tmp-ra.63 rbp rax)))
    (define L.fun/error129842.9
      ((new-frames ()))
      (begin (set! tmp-ra.64 r15) (set! rax 41278) (jump tmp-ra.64 rbp rax)))
    (define L.fun/ascii-char129831.10
      ((new-frames ()))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/ascii-char129832.6 rbp r15)))
    (define L.fun/empty129835.11
      ((new-frames ()))
      (begin
        (set! tmp-ra.66 r15)
        (set! r15 tmp-ra.66)
        (jump L.fun/empty129836.8 rbp r15)))
    (define L.fun/any129830.12
      ((new-frames ()))
      (begin (set! tmp-ra.67 r15) (set! rax 30) (jump tmp-ra.67 rbp rax)))
    (define L.fun/ascii-char129833.13
      ((new-frames ()))
      (begin
        (set! tmp-ra.68 r15)
        (set! r15 tmp-ra.68)
        (jump L.fun/ascii-char129834.5 rbp r15)))
    (define L.fun/empty129837.14
      ((new-frames ()))
      (begin
        (set! tmp-ra.69 r15)
        (set! r15 tmp-ra.69)
        (jump L.fun/empty129838.15 rbp r15)))
    (define L.fun/empty129838.15
      ((new-frames ()))
      (begin (set! tmp-ra.70 r15) (set! rax 22) (jump tmp-ra.70 rbp rax)))
    (define L.fun/empty129839.16
      ((new-frames ()))
      (begin
        (set! tmp-ra.71 r15)
        (set! r15 tmp-ra.71)
        (jump L.fun/empty129840.7 rbp r15)))
    (begin
      (set! tmp-ra.72 r15)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/any129830.12 rbp r15)))
      (set! tmp.57 rax)
      (return-point L.rp.20
        (begin
          (set! rdi tmp.57)
          (set! r15 L.rp.20)
          (jump L.vector?.18 rbp r15 rdi)))
      (set! boolean0.6 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/ascii-char129831.10 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/ascii-char129833.13 rbp r15)))
      (set! ascii-char2.4 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/empty129835.11 rbp r15)))
      (set! empty3.3 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/empty129837.14 rbp r15)))
      (set! empty4.2 rax)
      (return-point L.rp.25
        (begin (set! r15 L.rp.25) (jump L.fun/empty129839.16 rbp r15)))
      (set! empty5.1 rax)
      (set! r15 tmp-ra.72)
      (jump L.fun/error129841.4 rbp r15))))
