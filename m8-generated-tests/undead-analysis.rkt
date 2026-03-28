#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v8
         (only-in "../undead-analysis.rkt"))
(define (fail-if-invalid p)
  (when (not (asm-pred-lang-v8/undead? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "asm-pred-lang-v8/undead"
      " program")))
  p)
(define (check-by-interp p)
  (interp-asm-pred-lang-v8/locals p)
  (interp-asm-pred-lang-v8/undead (fail-if-invalid (undead-analysis p))))

(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp-ra.50)))
    (begin (set! tmp-ra.50 r15) (set! rax 24894) (jump tmp-ra.50 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp-ra.50)))
    (begin (set! tmp-ra.50 r15) (set! rax 22) (jump tmp-ra.50 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp-ra.51)))
    (define L.fun/void8390.4
      ((new-frames ()) (locals (tmp-ra.50)))
      (begin (set! tmp-ra.50 r15) (set! rax 30) (jump tmp-ra.50 rbp rax)))
    (begin
      (set! tmp-ra.51 r15)
      (set! r15 tmp-ra.51)
      (jump L.fun/void8390.4 rbp r15))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (empty0.1 tmp-ra.51)))
    (begin
      (set! tmp-ra.51 r15)
      (set! empty0.1 22)
      (set! rax 21310)
      (jump tmp-ra.51 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (ascii-char1.1 void0.2 tmp-ra.52)))
    (begin
      (set! tmp-ra.52 r15)
      (set! void0.2 30)
      (set! ascii-char1.1 25390)
      (set! rax 576)
      (jump tmp-ra.52 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp.53 boolean1.2 ascii-char0.3 tmp-ra.55)))
    (define L.fun/void8397.4
      ((new-frames ()) (locals (oprand0.1 tmp-ra.54)))
      (begin
        (set! tmp-ra.54 r15)
        (set! oprand0.1 rdi)
        (set! rax 30)
        (jump tmp-ra.54 rbp rax)))
    (begin
      (set! tmp-ra.55 r15)
      (set! ascii-char0.3 25390)
      (set! boolean1.2 6)
      (set! tmp.53 14)
      (set! rdi tmp.53)
      (set! r15 tmp-ra.55)
      (jump L.fun/void8397.4 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp-ra.50 tmp.51)))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 14) (!= tmp.51 6))
        (begin (set! rax 18494) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 57406) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp-ra.50 tmp.51)))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 6) (!= tmp.51 6))
        (begin (set! rax 25390) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 25390) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp-ra.50 tmp.51)))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 14) (!= tmp.51 6))
        (begin (set! rax 240) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 224) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (ascii-char1.1 empty0.2 tmp-ra.52)))
    (begin
      (set! tmp-ra.52 r15)
      (set! empty0.2 22)
      (set! ascii-char1.1 25390)
      (set! rax 30)
      (jump tmp-ra.52 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp.53 error1.2 void0.3 tmp-ra.55)))
    (define L.fun/error8412.4
      ((new-frames ()) (locals (oprand0.1 tmp-ra.54)))
      (begin
        (set! tmp-ra.54 r15)
        (set! oprand0.1 rdi)
        (set! rax 29758)
        (jump tmp-ra.54 rbp rax)))
    (begin
      (set! tmp-ra.55 r15)
      (set! void0.3 30)
      (set! error1.2 38974)
      (set! tmp.53 error1.2)
      (set! rdi tmp.53)
      (set! r15 tmp-ra.55)
      (jump L.fun/error8412.4 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames ()) (locals (tmp.53 error1.2 ascii-char0.3 tmp-ra.55)))
    (define L.fun/ascii-char8415.4
      ((new-frames ()) (locals (oprand0.1 tmp-ra.54)))
      (begin
        (set! tmp-ra.54 r15)
        (set! oprand0.1 rdi)
        (set! rax 25390)
        (jump tmp-ra.54 rbp rax)))
    (begin
      (set! tmp-ra.55 r15)
      (set! ascii-char0.3 25390)
      (set! error1.2 29502)
      (set! tmp.53 25390)
      (set! rdi tmp.53)
      (set! r15 tmp-ra.55)
      (jump L.fun/ascii-char8415.4 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() () ())) (locals (empty2.1 fixnum1.2 fixnum0.3 tmp-ra.65)))
    (define L.-.8
      ((new-frames ())
       (locals
        (tmp.55
         tmp.67
         tmp.21
         tmp.56
         tmp.68
         tmp-ra.61
         tmp.54
         tmp.22
         tmp.66
         tmp.53)))
      (begin
        (set! tmp-ra.61 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.66 tmp.22)
                      (set! tmp.66 (bitwise-and tmp.66 7))
                      (set! tmp.54 tmp.66))
                    (= tmp.54 0))
                (set! tmp.53 14)
                (set! tmp.53 6))
              (!= tmp.53 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.67 tmp.21)
                        (set! tmp.67 (bitwise-and tmp.67 7))
                        (set! tmp.56 tmp.67))
                      (= tmp.56 0))
                  (set! tmp.55 14)
                  (set! tmp.55 6))
                (!= tmp.55 6))
            (begin
              (set! tmp.68 tmp.21)
              (set! tmp.68 (- tmp.68 tmp.22))
              (set! rax tmp.68)
              (jump tmp-ra.61 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.61 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.61 rbp rax)))))
    (define L.+.7
      ((new-frames ())
       (locals
        (tmp.59
         tmp.70
         tmp.19
         tmp.60
         tmp.71
         tmp-ra.62
         tmp.58
         tmp.20
         tmp.69
         tmp.57)))
      (begin
        (set! tmp-ra.62 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.69 tmp.20)
                      (set! tmp.69 (bitwise-and tmp.69 7))
                      (set! tmp.58 tmp.69))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.70 tmp.19)
                        (set! tmp.70 (bitwise-and tmp.70 7))
                        (set! tmp.60 tmp.70))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.71 tmp.19)
              (set! tmp.71 (+ tmp.71 tmp.20))
              (set! rax tmp.71)
              (jump tmp-ra.62 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.62 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.62 rbp rax)))))
    (define L.fun/empty8418.4
      ((new-frames ()) (locals (tmp-ra.63)))
      (begin (set! tmp-ra.63 r15) (set! rax 22) (jump tmp-ra.63 rbp rax)))
    (define L.fun/ascii-char8419.5
      ((new-frames ()) (locals (tmp-ra.64)))
      (begin (set! tmp-ra.64 r15) (set! rax 25390) (jump tmp-ra.64 rbp rax)))
    (begin
      (set! tmp-ra.65 r15)
      (return-point L.rp.9
        (begin
          (set! rsi 912)
          (set! rdi 760)
          (set! r15 L.rp.9)
          (jump L.+.7 rbp r15 rdi rsi)))
      (set! fixnum0.3 rax)
      (return-point L.rp.10
        (begin
          (set! rsi 1664)
          (set! rdi 384)
          (set! r15 L.rp.10)
          (jump L.-.8 rbp r15 rdi rsi)))
      (set! fixnum1.2 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/empty8418.4 rbp r15)))
      (set! empty2.1 rax)
      (set! r15 tmp-ra.65)
      (jump L.fun/ascii-char8419.5 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() ()))
     (locals
      (tmp.60
       tmp.67
       tmp.62
       tmp.61
       tmp.59
       error2.7
       empty1.8
       ascii-char0.9
       tmp-ra.66)))
    (define L.fun/ascii-char8467.4
      ((new-frames ()) (locals (oprand1.1 oprand0.2 tmp-ra.63)))
      (begin
        (set! tmp-ra.63 r15)
        (set! oprand0.2 rdi)
        (set! oprand1.1 rsi)
        (set! rax oprand0.2)
        (jump tmp-ra.63 rbp rax)))
    (define L.fun/void8469.5
      ((new-frames ()) (locals (oprand1.3 oprand0.4 tmp-ra.64)))
      (begin
        (set! tmp-ra.64 r15)
        (set! oprand0.4 rdi)
        (set! oprand1.3 rsi)
        (set! rax 30)
        (jump tmp-ra.64 rbp rax)))
    (define L.fun/empty8468.6
      ((new-frames ()) (locals (oprand1.5 oprand0.6 tmp-ra.65)))
      (begin
        (set! tmp-ra.65 r15)
        (set! oprand0.6 rdi)
        (set! oprand1.5 rsi)
        (set! rax 22)
        (jump tmp-ra.65 rbp rax)))
    (begin
      (set! tmp-ra.66 r15)
      (set! ascii-char0.9 25390)
      (set! empty1.8 22)
      (set! error2.7 15166)
      (set! tmp.59 25390)
      (return-point L.rp.8
        (begin
          (set! rsi 6)
          (set! rdi 30)
          (set! r15 L.rp.8)
          (jump L.fun/void8469.5 rbp r15 rdi rsi)))
      (set! tmp.61 rax)
      (if (begin (set! tmp.67 6) (!= tmp.67 6))
        (set! tmp.62 43582)
        (set! tmp.62 65086))
      (return-point L.rp.9
        (begin
          (set! rsi tmp.62)
          (set! rdi tmp.61)
          (set! r15 L.rp.9)
          (jump L.fun/empty8468.6 rbp r15 rdi rsi)))
      (set! tmp.60 rax)
      (set! rsi tmp.60)
      (set! rdi tmp.59)
      (set! r15 tmp-ra.66)
      (jump L.fun/ascii-char8467.4 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() ()))
     (locals
      (tmp.65
       tmp.67
       empty2.1
       error1.2
       ascii-char0.3
       tmp.80
       tmp.66
       tmp.62
       tmp.79
       tmp.64
       tmp.78
       tmp.63
       tmp-ra.70)))
    (define L.*.6
      ((new-frames ())
       (locals
        (tmp.55
         tmp.72
         tmp.17
         tmp.56
         tmp.74
         tmp.57
         tmp.73
         tmp-ra.68
         tmp.54
         tmp.18
         tmp.71
         tmp.53)))
      (begin
        (set! tmp-ra.68 r15)
        (set! tmp.17 rdi)
        (set! tmp.18 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.71 tmp.18)
                      (set! tmp.71 (bitwise-and tmp.71 7))
                      (set! tmp.54 tmp.71))
                    (= tmp.54 0))
                (set! tmp.53 14)
                (set! tmp.53 6))
              (!= tmp.53 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.72 tmp.17)
                        (set! tmp.72 (bitwise-and tmp.72 7))
                        (set! tmp.56 tmp.72))
                      (= tmp.56 0))
                  (set! tmp.55 14)
                  (set! tmp.55 6))
                (!= tmp.55 6))
            (begin
              (set! tmp.73 tmp.18)
              (set! tmp.73 (arithmetic-shift-right tmp.73 3))
              (set! tmp.57 tmp.73)
              (set! tmp.74 tmp.17)
              (set! tmp.74 (* tmp.74 tmp.57))
              (set! rax tmp.74)
              (jump tmp-ra.68 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.68 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.68 rbp rax)))))
    (define L.-.5
      ((new-frames ())
       (locals
        (tmp.60
         tmp.76
         tmp.21
         tmp.61
         tmp.77
         tmp-ra.69
         tmp.59
         tmp.22
         tmp.75
         tmp.58)))
      (begin
        (set! tmp-ra.69 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.75 tmp.22)
                      (set! tmp.75 (bitwise-and tmp.75 7))
                      (set! tmp.59 tmp.75))
                    (= tmp.59 0))
                (set! tmp.58 14)
                (set! tmp.58 6))
              (!= tmp.58 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.76 tmp.21)
                        (set! tmp.76 (bitwise-and tmp.76 7))
                        (set! tmp.61 tmp.76))
                      (= tmp.61 0))
                  (set! tmp.60 14)
                  (set! tmp.60 6))
                (!= tmp.60 6))
            (begin
              (set! tmp.77 tmp.21)
              (set! tmp.77 (- tmp.77 tmp.22))
              (set! rax tmp.77)
              (jump tmp-ra.69 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.69 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.69 rbp rax)))))
    (begin
      (set! tmp-ra.70 r15)
      (if (begin (set! tmp.78 6) (!= tmp.78 6))
        (set! tmp.63 1712)
        (set! tmp.63 688))
      (if (begin (set! tmp.79 14) (!= tmp.79 6))
        (set! tmp.64 1480)
        (set! tmp.64 128))
      (return-point L.rp.7
        (begin
          (set! rsi tmp.64)
          (set! rdi tmp.63)
          (set! r15 L.rp.7)
          (jump L.-.5 rbp r15 rdi rsi)))
      (set! tmp.62 rax)
      (if (begin (set! tmp.80 6) (!= tmp.80 6))
        (set! tmp.66 352)
        (set! tmp.66 264))
      (set! ascii-char0.3 25390)
      (set! error1.2 13118)
      (set! empty2.1 22)
      (set! tmp.67 608)
      (return-point L.rp.8
        (begin
          (set! rsi tmp.67)
          (set! rdi tmp.66)
          (set! r15 L.rp.8)
          (jump L.-.5 rbp r15 rdi rsi)))
      (set! tmp.65 rax)
      (set! rsi tmp.65)
      (set! rdi tmp.62)
      (set! r15 tmp-ra.70)
      (jump L.*.6 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () ()))
     (locals (tmp.81 tmp.65 tmp.66 tmp.80 tmp-ra.71 tmp.64 tmp.63)))
    (define L.*.8
      ((new-frames ())
       (locals
        (tmp.55
         tmp.73
         tmp.17
         tmp.56
         tmp.75
         tmp.57
         tmp.74
         tmp-ra.67
         tmp.54
         tmp.18
         tmp.72
         tmp.53)))
      (begin
        (set! tmp-ra.67 r15)
        (set! tmp.17 rdi)
        (set! tmp.18 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.72 tmp.18)
                      (set! tmp.72 (bitwise-and tmp.72 7))
                      (set! tmp.54 tmp.72))
                    (= tmp.54 0))
                (set! tmp.53 14)
                (set! tmp.53 6))
              (!= tmp.53 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.73 tmp.17)
                        (set! tmp.73 (bitwise-and tmp.73 7))
                        (set! tmp.56 tmp.73))
                      (= tmp.56 0))
                  (set! tmp.55 14)
                  (set! tmp.55 6))
                (!= tmp.55 6))
            (begin
              (set! tmp.74 tmp.18)
              (set! tmp.74 (arithmetic-shift-right tmp.74 3))
              (set! tmp.57 tmp.74)
              (set! tmp.75 tmp.17)
              (set! tmp.75 (* tmp.75 tmp.57))
              (set! rax tmp.75)
              (jump tmp-ra.67 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.67 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.67 rbp rax)))))
    (define L.-.7
      ((new-frames ())
       (locals
        (tmp.60
         tmp.77
         tmp.21
         tmp.61
         tmp.78
         tmp-ra.68
         tmp.59
         tmp.22
         tmp.76
         tmp.58)))
      (begin
        (set! tmp-ra.68 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.76 tmp.22)
                      (set! tmp.76 (bitwise-and tmp.76 7))
                      (set! tmp.59 tmp.76))
                    (= tmp.59 0))
                (set! tmp.58 14)
                (set! tmp.58 6))
              (!= tmp.58 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.77 tmp.21)
                        (set! tmp.77 (bitwise-and tmp.77 7))
                        (set! tmp.61 tmp.77))
                      (= tmp.61 0))
                  (set! tmp.60 14)
                  (set! tmp.60 6))
                (!= tmp.60 6))
            (begin
              (set! tmp.78 tmp.21)
              (set! tmp.78 (- tmp.78 tmp.22))
              (set! rax tmp.78)
              (jump tmp-ra.68 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.68 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.68 rbp rax)))))
    (define L.vector?.6
      ((new-frames ()) (locals (tmp-ra.69 tmp.79 tmp.47 tmp.62)))
      (begin
        (set! tmp-ra.69 r15)
        (set! tmp.47 rdi)
        (if (begin
              (begin
                (set! tmp.79 tmp.47)
                (set! tmp.79 (bitwise-and tmp.79 7))
                (set! tmp.62 tmp.79))
              (= tmp.62 3))
          (begin (set! rax 14) (jump tmp-ra.69 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.69 rbp rax)))))
    (define L.fun/any8734.4
      ((new-frames ()) (locals (oprand2.1 oprand1.2 oprand0.3 tmp-ra.70)))
      (begin
        (set! tmp-ra.70 r15)
        (set! oprand0.3 rdi)
        (set! oprand1.2 rsi)
        (set! oprand2.1 rdx)
        (set! rax 41278)
        (jump tmp-ra.70 rbp rax)))
    (begin
      (set! tmp-ra.71 r15)
      (if (begin
            (begin
              (return-point L.rp.9
                (begin
                  (set! rdx 25390)
                  (set! rsi 22)
                  (set! rdi 5950)
                  (set! r15 L.rp.9)
                  (jump L.fun/any8734.4 rbp r15 rdi rsi rdx)))
              (set! tmp.64 rax)
              (return-point L.rp.10
                (begin
                  (set! rdi tmp.64)
                  (set! r15 L.rp.10)
                  (jump L.vector?.6 rbp r15 rdi)))
              (set! tmp.63 rax))
            (!= tmp.63 6))
        (begin
          (return-point L.rp.11
            (begin
              (set! rsi 528)
              (set! rdi 1480)
              (set! r15 L.rp.11)
              (jump L.-.7 rbp r15 rdi rsi)))
          (set! tmp.65 rax)
          (if (begin (set! tmp.80 14) (!= tmp.80 6))
            (set! tmp.66 1488)
            (set! tmp.66 1392))
          (set! rsi tmp.66)
          (set! rdi tmp.65)
          (set! r15 tmp-ra.71)
          (jump L.*.8 rbp r15 rdi rsi))
        (if (begin (set! tmp.81 14) (!= tmp.81 6))
          (begin (set! rax 1552) (jump tmp-ra.71 rbp rax))
          (begin (set! rax 1376) (jump tmp-ra.71 rbp rax)))))))
(check-by-interp
 '(module
    ((new-frames (() () () ()))
     (locals (ascii-char3.1 void2.2 void1.3 void0.4 tmp-ra.59)))
    (define L.fun/void8780.4
      ((new-frames ()) (locals (tmp-ra.54)))
      (begin (set! tmp-ra.54 r15) (set! rax 30) (jump tmp-ra.54 rbp rax)))
    (define L.fun/ascii-char8782.5
      ((new-frames ()) (locals (tmp-ra.55)))
      (begin (set! tmp-ra.55 r15) (set! rax 25390) (jump tmp-ra.55 rbp rax)))
    (define L.fun/void8781.6
      ((new-frames ()) (locals (tmp-ra.56)))
      (begin (set! tmp-ra.56 r15) (set! rax 30) (jump tmp-ra.56 rbp rax)))
    (define L.fun/error8783.7
      ((new-frames ()) (locals (tmp-ra.57)))
      (begin (set! tmp-ra.57 r15) (set! rax 35646) (jump tmp-ra.57 rbp rax)))
    (define L.fun/void8779.8
      ((new-frames ()) (locals (tmp-ra.58)))
      (begin (set! tmp-ra.58 r15) (set! rax 30) (jump tmp-ra.58 rbp rax)))
    (begin
      (set! tmp-ra.59 r15)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/void8779.8 rbp r15)))
      (set! void0.4 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/void8780.4 rbp r15)))
      (set! void1.3 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/void8781.6 rbp r15)))
      (set! void2.2 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/ascii-char8782.5 rbp r15)))
      (set! ascii-char3.1 rax)
      (set! r15 tmp-ra.59)
      (jump L.fun/error8783.7 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () ()))
     (locals
      (void3.1
       fixnum2.2
       tmp.70
       tmp.69
       fixnum1.3
       tmp.68
       tmp.67
       empty0.4
       tmp-ra.77)))
    (define L.*.10
      ((new-frames ())
       (locals
        (tmp.56
         tmp.79
         tmp.18
         tmp.57
         tmp.81
         tmp.58
         tmp.80
         tmp-ra.71
         tmp.55
         tmp.19
         tmp.78
         tmp.54)))
      (begin
        (set! tmp-ra.71 r15)
        (set! tmp.18 rdi)
        (set! tmp.19 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.78 tmp.19)
                      (set! tmp.78 (bitwise-and tmp.78 7))
                      (set! tmp.55 tmp.78))
                    (= tmp.55 0))
                (set! tmp.54 14)
                (set! tmp.54 6))
              (!= tmp.54 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.79 tmp.18)
                        (set! tmp.79 (bitwise-and tmp.79 7))
                        (set! tmp.57 tmp.79))
                      (= tmp.57 0))
                  (set! tmp.56 14)
                  (set! tmp.56 6))
                (!= tmp.56 6))
            (begin
              (set! tmp.80 tmp.19)
              (set! tmp.80 (arithmetic-shift-right tmp.80 3))
              (set! tmp.58 tmp.80)
              (set! tmp.81 tmp.18)
              (set! tmp.81 (* tmp.81 tmp.58))
              (set! rax tmp.81)
              (jump tmp-ra.71 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.71 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.71 rbp rax)))))
    (define L.+.9
      ((new-frames ())
       (locals
        (tmp.61
         tmp.83
         tmp.20
         tmp.62
         tmp.84
         tmp-ra.72
         tmp.60
         tmp.21
         tmp.82
         tmp.59)))
      (begin
        (set! tmp-ra.72 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.82 tmp.21)
                      (set! tmp.82 (bitwise-and tmp.82 7))
                      (set! tmp.60 tmp.82))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.83 tmp.20)
                        (set! tmp.83 (bitwise-and tmp.83 7))
                        (set! tmp.62 tmp.83))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.84 tmp.20)
              (set! tmp.84 (+ tmp.84 tmp.21))
              (set! rax tmp.84)
              (jump tmp-ra.72 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.72 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.72 rbp rax)))))
    (define L.-.8
      ((new-frames ())
       (locals
        (tmp.65
         tmp.86
         tmp.22
         tmp.66
         tmp.87
         tmp-ra.73
         tmp.64
         tmp.23
         tmp.85
         tmp.63)))
      (begin
        (set! tmp-ra.73 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.85 tmp.23)
                      (set! tmp.85 (bitwise-and tmp.85 7))
                      (set! tmp.64 tmp.85))
                    (= tmp.64 0))
                (set! tmp.63 14)
                (set! tmp.63 6))
              (!= tmp.63 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.86 tmp.22)
                        (set! tmp.86 (bitwise-and tmp.86 7))
                        (set! tmp.66 tmp.86))
                      (= tmp.66 0))
                  (set! tmp.65 14)
                  (set! tmp.65 6))
                (!= tmp.65 6))
            (begin
              (set! tmp.87 tmp.22)
              (set! tmp.87 (- tmp.87 tmp.23))
              (set! rax tmp.87)
              (jump tmp-ra.73 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.73 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.73 rbp rax)))))
    (define L.fun/empty8806.4
      ((new-frames ()) (locals (tmp-ra.74)))
      (begin (set! tmp-ra.74 r15) (set! rax 22) (jump tmp-ra.74 rbp rax)))
    (define L.fun/void8807.5
      ((new-frames ()) (locals (tmp-ra.75)))
      (begin (set! tmp-ra.75 r15) (set! rax 30) (jump tmp-ra.75 rbp rax)))
    (define L.fun/ascii-char8808.6
      ((new-frames ()) (locals (tmp-ra.76)))
      (begin (set! tmp-ra.76 r15) (set! rax 25390) (jump tmp-ra.76 rbp rax)))
    (begin
      (set! tmp-ra.77 r15)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/empty8806.4 rbp r15)))
      (set! empty0.4 rax)
      (return-point L.rp.12
        (begin
          (set! rsi 864)
          (set! rdi 1608)
          (set! r15 L.rp.12)
          (jump L.-.8 rbp r15 rdi rsi)))
      (set! tmp.67 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 352)
          (set! rdi 328)
          (set! r15 L.rp.13)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.14
        (begin
          (set! rsi tmp.68)
          (set! rdi tmp.67)
          (set! r15 L.rp.14)
          (jump L.-.8 rbp r15 rdi rsi)))
      (set! fixnum1.3 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 1048)
          (set! rdi 320)
          (set! r15 L.rp.15)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 968)
          (set! rdi 1096)
          (set! r15 L.rp.16)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.17
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.17)
          (jump L.-.8 rbp r15 rdi rsi)))
      (set! fixnum2.2 rax)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/void8807.5 rbp r15)))
      (set! void3.1 rax)
      (set! r15 tmp-ra.77)
      (jump L.fun/ascii-char8808.6 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () ()))
     (locals
      (tmp.77
       empty3.14
       ascii-char2.15
       void1.16
       ascii-char0.17
       tmp.76
       error3.10
       error2.11
       fixnum1.12
       boolean0.13
       tmp.75
       tmp.74
       tmp.97
       tmp-ra.90)))
    (define L.error?.16
      ((new-frames ()) (locals (tmp-ra.78 tmp.91 tmp.59 tmp.67)))
      (begin
        (set! tmp-ra.78 r15)
        (set! tmp.59 rdi)
        (if (begin
              (begin
                (set! tmp.91 tmp.59)
                (set! tmp.91 (bitwise-and tmp.91 255))
                (set! tmp.67 tmp.91))
              (= tmp.67 62))
          (begin (set! rax 14) (jump tmp-ra.78 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.78 rbp rax)))))
    (define L.fixnum?.15
      ((new-frames ()) (locals (tmp-ra.79 tmp.92 tmp.54 tmp.68)))
      (begin
        (set! tmp-ra.79 r15)
        (set! tmp.54 rdi)
        (if (begin
              (begin
                (set! tmp.92 tmp.54)
                (set! tmp.92 (bitwise-and tmp.92 7))
                (set! tmp.68 tmp.92))
              (= tmp.68 0))
          (begin (set! rax 14) (jump tmp-ra.79 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.79 rbp rax)))))
    (define L.+.14
      ((new-frames ())
       (locals
        (tmp.71
         tmp.94
         tmp.33
         tmp.72
         tmp.95
         tmp-ra.80
         tmp.70
         tmp.34
         tmp.93
         tmp.69)))
      (begin
        (set! tmp-ra.80 r15)
        (set! tmp.33 rdi)
        (set! tmp.34 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.93 tmp.34)
                      (set! tmp.93 (bitwise-and tmp.93 7))
                      (set! tmp.70 tmp.93))
                    (= tmp.70 0))
                (set! tmp.69 14)
                (set! tmp.69 6))
              (!= tmp.69 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.94 tmp.33)
                        (set! tmp.94 (bitwise-and tmp.94 7))
                        (set! tmp.72 tmp.94))
                      (= tmp.72 0))
                  (set! tmp.71 14)
                  (set! tmp.71 6))
                (!= tmp.71 6))
            (begin
              (set! tmp.95 tmp.33)
              (set! tmp.95 (+ tmp.95 tmp.34))
              (set! rax tmp.95)
              (jump tmp-ra.80 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.80 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.80 rbp rax)))))
    (define L.vector?.13
      ((new-frames ()) (locals (tmp-ra.81 tmp.96 tmp.61 tmp.73)))
      (begin
        (set! tmp-ra.81 r15)
        (set! tmp.61 rdi)
        (if (begin
              (begin
                (set! tmp.96 tmp.61)
                (set! tmp.96 (bitwise-and tmp.96 7))
                (set! tmp.73 tmp.96))
              (= tmp.73 3))
          (begin (set! rax 14) (jump tmp-ra.81 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.81 rbp rax)))))
    (define L.fun/empty9034.4
      ((new-frames ()) (locals (oprand2.1 oprand1.2 oprand0.3 tmp-ra.82)))
      (begin
        (set! tmp-ra.82 r15)
        (set! oprand0.3 rdi)
        (set! oprand1.2 rsi)
        (set! oprand2.1 rdx)
        (set! rax 22)
        (jump tmp-ra.82 rbp rax)))
    (define L.fun/error9036.5
      ((new-frames ()) (locals (tmp-ra.83)))
      (begin (set! tmp-ra.83 r15) (set! rax 47166) (jump tmp-ra.83 rbp rax)))
    (define L.fun/error9035.6
      ((new-frames ()) (locals (tmp-ra.84)))
      (begin (set! tmp-ra.84 r15) (set! rax 36414) (jump tmp-ra.84 rbp rax)))
    (define L.fun/void9037.7
      ((new-frames ()) (locals (tmp-ra.85)))
      (begin (set! tmp-ra.85 r15) (set! rax 30) (jump tmp-ra.85 rbp rax)))
    (define L.fun/ascii-char9032.8
      ((new-frames ()) (locals (tmp-ra.86)))
      (begin (set! tmp-ra.86 r15) (set! rax 25390) (jump tmp-ra.86 rbp rax)))
    (define L.fun/empty9038.9
      ((new-frames ()) (locals (tmp-ra.87)))
      (begin (set! tmp-ra.87 r15) (set! rax 22) (jump tmp-ra.87 rbp rax)))
    (define L.fun/ascii-char9031.10
      ((new-frames ()) (locals (oprand2.4 oprand1.5 oprand0.6 tmp-ra.88)))
      (begin
        (set! tmp-ra.88 r15)
        (set! oprand0.6 rdi)
        (set! oprand1.5 rsi)
        (set! oprand2.4 rdx)
        (set! r15 tmp-ra.88)
        (jump L.fun/ascii-char9032.8 rbp r15)))
    (define L.fun/boolean9033.11
      ((new-frames ()) (locals (oprand2.7 oprand1.8 oprand0.9 tmp-ra.89)))
      (begin
        (set! tmp-ra.89 r15)
        (set! oprand0.9 rdi)
        (set! oprand1.8 rsi)
        (set! oprand2.7 rdx)
        (set! rax 14)
        (jump tmp-ra.89 rbp rax)))
    (begin
      (set! tmp-ra.90 r15)
      (if (begin
            (begin
              (return-point L.rp.17
                (begin
                  (set! rdx 25390)
                  (set! rsi 44094)
                  (set! rdi 25390)
                  (set! r15 L.rp.17)
                  (jump L.fun/boolean9033.11 rbp r15 rdi rsi rdx)))
              (set! tmp.75 rax))
            (!= tmp.75 6))
        (if (begin (set! tmp.97 6) (!= tmp.97 6))
          (set! tmp.74 22)
          (set! tmp.74 22))
        (begin
          (return-point L.rp.18
            (begin
              (set! rdx 14)
              (set! rsi 59454)
              (set! rdi 4158)
              (set! r15 L.rp.18)
              (jump L.fun/empty9034.4 rbp r15 rdi rsi rdx)))
          (set! tmp.74 rax)))
      (return-point L.rp.19
        (begin
          (set! rdi 25390)
          (set! r15 L.rp.19)
          (jump L.vector?.13 rbp r15 rdi)))
      (set! boolean0.13 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 192)
          (set! rdi 224)
          (set! r15 L.rp.20)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! fixnum1.12 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/error9035.6 rbp r15)))
      (set! error2.11 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/error9036.5 rbp r15)))
      (set! error3.10 rax)
      (return-point L.rp.23
        (begin
          (set! rdi 30)
          (set! r15 L.rp.23)
          (jump L.fixnum?.15 rbp r15 rdi)))
      (set! tmp.76 rax)
      (return-point L.rp.24
        (begin
          (set! rdx 14)
          (set! rsi 6)
          (set! rdi 22)
          (set! r15 L.rp.24)
          (jump L.fun/ascii-char9031.10 rbp r15 rdi rsi rdx)))
      (set! ascii-char0.17 rax)
      (return-point L.rp.25
        (begin (set! r15 L.rp.25) (jump L.fun/void9037.7 rbp r15)))
      (set! void1.16 rax)
      (return-point L.rp.26
        (begin
          (set! rdx 6)
          (set! rsi 14)
          (set! rdi 22)
          (set! r15 L.rp.26)
          (jump L.fun/ascii-char9031.10 rbp r15 rdi rsi rdx)))
      (set! ascii-char2.15 rax)
      (return-point L.rp.27
        (begin (set! r15 L.rp.27) (jump L.fun/empty9038.9 rbp r15)))
      (set! empty3.14 rax)
      (return-point L.rp.28
        (begin
          (set! rdi 30)
          (set! r15 L.rp.28)
          (jump L.error?.16 rbp r15 rdi)))
      (set! tmp.77 rax)
      (set! rdx tmp.77)
      (set! rsi tmp.76)
      (set! rdi tmp.74)
      (set! r15 tmp-ra.90)
      (jump L.fun/ascii-char9031.10 rbp r15 rdi rsi rdx))))
(check-by-interp
 '(module
    ((new-frames (() () () ()))
     (locals (ascii-char3.1 empty2.2 void1.3 error0.4 tmp-ra.58)))
    (define L.fun/void9076.4
      ((new-frames ()) (locals (tmp-ra.54)))
      (begin (set! tmp-ra.54 r15) (set! rax 30) (jump tmp-ra.54 rbp rax)))
    (define L.fun/ascii-char9078.5
      ((new-frames ()) (locals (tmp-ra.55)))
      (begin (set! tmp-ra.55 r15) (set! rax 25390) (jump tmp-ra.55 rbp rax)))
    (define L.fun/error9075.6
      ((new-frames ()) (locals (tmp-ra.56)))
      (begin (set! tmp-ra.56 r15) (set! rax 57662) (jump tmp-ra.56 rbp rax)))
    (define L.fun/empty9077.7
      ((new-frames ()) (locals (tmp-ra.57)))
      (begin (set! tmp-ra.57 r15) (set! rax 22) (jump tmp-ra.57 rbp rax)))
    (begin
      (set! tmp-ra.58 r15)
      (return-point L.rp.9
        (begin (set! r15 L.rp.9) (jump L.fun/error9075.6 rbp r15)))
      (set! error0.4 rax)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/void9076.4 rbp r15)))
      (set! void1.3 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/empty9077.7 rbp r15)))
      (set! empty2.2 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/ascii-char9078.5 rbp r15)))
      (set! ascii-char3.1 rax)
      (set! rax empty2.2)
      (jump tmp-ra.58 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals
      (tmp.58
       tmp-ra.54
       fixnum0.4
       fixnum1.3
       void2.2
       ascii-char3.1
       tmp.57
       tmp.56
       tmp.55)))
    (begin
      (set! tmp-ra.54 r15)
      (if (if (begin (set! tmp.55 6) (!= tmp.55 6))
            (begin (set! tmp.56 14) (!= tmp.56 6))
            (begin (set! tmp.57 14) (!= tmp.57 6)))
        (begin
          (set! fixnum0.4 1720)
          (set! fixnum1.3 984)
          (set! void2.2 30)
          (set! ascii-char3.1 25390)
          (set! rax fixnum0.4)
          (jump tmp-ra.54 rbp rax))
        (if (begin (set! tmp.58 6) (!= tmp.58 6))
          (begin (set! rax 1448) (jump tmp-ra.54 rbp rax))
          (begin (set! rax 1416) (jump tmp-ra.54 rbp rax)))))))
(check-by-interp
 '(module
    ((new-frames (() () () () ()))
     (locals (tmp.55 error3.1 error2.2 error1.3 empty0.4 tmp-ra.62)))
    (define L.boolean?.10
      ((new-frames ()) (locals (tmp-ra.56 tmp.63 tmp.42 tmp.54)))
      (begin
        (set! tmp-ra.56 r15)
        (set! tmp.42 rdi)
        (if (begin
              (begin
                (set! tmp.63 tmp.42)
                (set! tmp.63 (bitwise-and tmp.63 247))
                (set! tmp.54 tmp.63))
              (= tmp.54 6))
          (begin (set! rax 14) (jump tmp-ra.56 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.56 rbp rax)))))
    (define L.fun/error9365.4
      ((new-frames ()) (locals (tmp-ra.57)))
      (begin (set! tmp-ra.57 r15) (set! rax 62014) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error9364.5
      ((new-frames ()) (locals (tmp-ra.58)))
      (begin (set! tmp-ra.58 r15) (set! rax 63806) (jump tmp-ra.58 rbp rax)))
    (define L.fun/any9366.6
      ((new-frames ()) (locals (tmp-ra.59)))
      (begin (set! tmp-ra.59 r15) (set! rax 14) (jump tmp-ra.59 rbp rax)))
    (define L.fun/error9363.7
      ((new-frames ()) (locals (tmp-ra.60)))
      (begin (set! tmp-ra.60 r15) (set! rax 60990) (jump tmp-ra.60 rbp rax)))
    (define L.fun/empty9362.8
      ((new-frames ()) (locals (tmp-ra.61)))
      (begin (set! tmp-ra.61 r15) (set! rax 22) (jump tmp-ra.61 rbp rax)))
    (begin
      (set! tmp-ra.62 r15)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/empty9362.8 rbp r15)))
      (set! empty0.4 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/error9363.7 rbp r15)))
      (set! error1.3 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/error9364.5 rbp r15)))
      (set! error2.2 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/error9365.4 rbp r15)))
      (set! error3.1 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/any9366.6 rbp r15)))
      (set! tmp.55 rax)
      (set! rdi tmp.55)
      (set! r15 tmp-ra.62)
      (jump L.boolean?.10 rbp r15 rdi))))
(check-by-interp
 '(module
    ((new-frames (() () () ()))
     (locals (void3.1 ascii-char2.2 void1.3 empty0.4 tmp-ra.58)))
    (define L.fun/ascii-char9574.4
      ((new-frames ()) (locals (tmp-ra.54)))
      (begin (set! tmp-ra.54 r15) (set! rax 25390) (jump tmp-ra.54 rbp rax)))
    (define L.fun/void9575.5
      ((new-frames ()) (locals (tmp-ra.55)))
      (begin (set! tmp-ra.55 r15) (set! rax 30) (jump tmp-ra.55 rbp rax)))
    (define L.fun/void9573.6
      ((new-frames ()) (locals (tmp-ra.56)))
      (begin (set! tmp-ra.56 r15) (set! rax 30) (jump tmp-ra.56 rbp rax)))
    (define L.fun/empty9572.7
      ((new-frames ()) (locals (tmp-ra.57)))
      (begin (set! tmp-ra.57 r15) (set! rax 22) (jump tmp-ra.57 rbp rax)))
    (begin
      (set! tmp-ra.58 r15)
      (return-point L.rp.9
        (begin (set! r15 L.rp.9) (jump L.fun/empty9572.7 rbp r15)))
      (set! empty0.4 rax)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/void9573.6 rbp r15)))
      (set! void1.3 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/ascii-char9574.4 rbp r15)))
      (set! ascii-char2.2 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/void9575.5 rbp r15)))
      (set! void3.1 rax)
      (set! rax void1.3)
      (jump tmp-ra.58 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals
      (empty0.8
       error1.7
       void2.6
       fixnum3.5
       tmp.60
       tmp-ra.58
       fixnum3.1
       void2.2
       fixnum1.3
       empty0.4
       tmp.59)))
    (begin
      (set! tmp-ra.58 r15)
      (if (begin
            (set! empty0.4 22)
            (set! fixnum1.3 968)
            (set! void2.2 30)
            (set! fixnum3.1 896)
            (begin (set! tmp.59 6) (!= tmp.59 6)))
        (if (begin (set! tmp.60 14) (!= tmp.60 6))
          (begin (set! rax 22) (jump tmp-ra.58 rbp rax))
          (begin (set! rax 22) (jump tmp-ra.58 rbp rax)))
        (begin
          (set! empty0.8 22)
          (set! error1.7 42302)
          (set! void2.6 30)
          (set! fixnum3.5 992)
          (set! rax 22)
          (jump tmp-ra.58 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ()))
     (locals
      (ascii-char3.1 fixnum2.2 tmp.64 tmp.63 ascii-char1.3 void0.4 tmp-ra.70)))
    (define L.-.9
      ((new-frames ())
       (locals
        (tmp.56
         tmp.72
         tmp.22
         tmp.57
         tmp.73
         tmp-ra.65
         tmp.55
         tmp.23
         tmp.71
         tmp.54)))
      (begin
        (set! tmp-ra.65 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.71 tmp.23)
                      (set! tmp.71 (bitwise-and tmp.71 7))
                      (set! tmp.55 tmp.71))
                    (= tmp.55 0))
                (set! tmp.54 14)
                (set! tmp.54 6))
              (!= tmp.54 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.72 tmp.22)
                        (set! tmp.72 (bitwise-and tmp.72 7))
                        (set! tmp.57 tmp.72))
                      (= tmp.57 0))
                  (set! tmp.56 14)
                  (set! tmp.56 6))
                (!= tmp.56 6))
            (begin
              (set! tmp.73 tmp.22)
              (set! tmp.73 (- tmp.73 tmp.23))
              (set! rax tmp.73)
              (jump tmp-ra.65 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.65 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.65 rbp rax)))))
    (define L.*.8
      ((new-frames ())
       (locals
        (tmp.60
         tmp.75
         tmp.18
         tmp.61
         tmp.77
         tmp.62
         tmp.76
         tmp-ra.66
         tmp.59
         tmp.19
         tmp.74
         tmp.58)))
      (begin
        (set! tmp-ra.66 r15)
        (set! tmp.18 rdi)
        (set! tmp.19 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.74 tmp.19)
                      (set! tmp.74 (bitwise-and tmp.74 7))
                      (set! tmp.59 tmp.74))
                    (= tmp.59 0))
                (set! tmp.58 14)
                (set! tmp.58 6))
              (!= tmp.58 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.75 tmp.18)
                        (set! tmp.75 (bitwise-and tmp.75 7))
                        (set! tmp.61 tmp.75))
                      (= tmp.61 0))
                  (set! tmp.60 14)
                  (set! tmp.60 6))
                (!= tmp.60 6))
            (begin
              (set! tmp.76 tmp.19)
              (set! tmp.76 (arithmetic-shift-right tmp.76 3))
              (set! tmp.62 tmp.76)
              (set! tmp.77 tmp.18)
              (set! tmp.77 (* tmp.77 tmp.62))
              (set! rax tmp.77)
              (jump tmp-ra.66 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.66 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.66 rbp rax)))))
    (define L.fun/ascii-char9904.4
      ((new-frames ()) (locals (tmp-ra.67)))
      (begin (set! tmp-ra.67 r15) (set! rax 25390) (jump tmp-ra.67 rbp rax)))
    (define L.fun/void9902.5
      ((new-frames ()) (locals (tmp-ra.68)))
      (begin (set! tmp-ra.68 r15) (set! rax 30) (jump tmp-ra.68 rbp rax)))
    (define L.fun/ascii-char9903.6
      ((new-frames ()) (locals (tmp-ra.69)))
      (begin (set! tmp-ra.69 r15) (set! rax 25390) (jump tmp-ra.69 rbp rax)))
    (begin
      (set! tmp-ra.70 r15)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/void9902.5 rbp r15)))
      (set! void0.4 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/ascii-char9903.6 rbp r15)))
      (set! ascii-char1.3 rax)
      (return-point L.rp.12
        (begin
          (set! rsi 1592)
          (set! rdi 504)
          (set! r15 L.rp.12)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.63 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 1320)
          (set! rdi 552)
          (set! r15 L.rp.13)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.64 rax)
      (return-point L.rp.14
        (begin
          (set! rsi tmp.64)
          (set! rdi tmp.63)
          (set! r15 L.rp.14)
          (jump L.-.9 rbp r15 rdi rsi)))
      (set! fixnum2.2 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/ascii-char9904.4 rbp r15)))
      (set! ascii-char3.1 rax)
      (set! rax void0.4)
      (jump tmp-ra.70 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () ()))
     (locals
      (fixnum4.1
       tmp.77
       tmp.79
       tmp.78
       tmp.74
       tmp.76
       tmp.75
       void3.2
       empty2.3
       void1.4
       fixnum0.5
       tmp.71
       tmp.73
       tmp.72
       tmp.68
       tmp.70
       tmp.69
       tmp-ra.87)))
    (define L.*.11
      ((new-frames ())
       (locals
        (tmp.57
         tmp.89
         tmp.19
         tmp.58
         tmp.91
         tmp.59
         tmp.90
         tmp-ra.80
         tmp.56
         tmp.20
         tmp.88
         tmp.55)))
      (begin
        (set! tmp-ra.80 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.88 tmp.20)
                      (set! tmp.88 (bitwise-and tmp.88 7))
                      (set! tmp.56 tmp.88))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.89 tmp.19)
                        (set! tmp.89 (bitwise-and tmp.89 7))
                        (set! tmp.58 tmp.89))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.90 tmp.20)
              (set! tmp.90 (arithmetic-shift-right tmp.90 3))
              (set! tmp.59 tmp.90)
              (set! tmp.91 tmp.19)
              (set! tmp.91 (* tmp.91 tmp.59))
              (set! rax tmp.91)
              (jump tmp-ra.80 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.80 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.80 rbp rax)))))
    (define L.-.10
      ((new-frames ())
       (locals
        (tmp.62
         tmp.93
         tmp.23
         tmp.63
         tmp.94
         tmp-ra.81
         tmp.61
         tmp.24
         tmp.92
         tmp.60)))
      (begin
        (set! tmp-ra.81 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.92 tmp.24)
                      (set! tmp.92 (bitwise-and tmp.92 7))
                      (set! tmp.61 tmp.92))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.93 tmp.23)
                        (set! tmp.93 (bitwise-and tmp.93 7))
                        (set! tmp.63 tmp.93))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.94 tmp.23)
              (set! tmp.94 (- tmp.94 tmp.24))
              (set! rax tmp.94)
              (jump tmp-ra.81 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.81 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.81 rbp rax)))))
    (define L.+.9
      ((new-frames ())
       (locals
        (tmp.66
         tmp.96
         tmp.21
         tmp.67
         tmp.97
         tmp-ra.82
         tmp.65
         tmp.22
         tmp.95
         tmp.64)))
      (begin
        (set! tmp-ra.82 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.95 tmp.22)
                      (set! tmp.95 (bitwise-and tmp.95 7))
                      (set! tmp.65 tmp.95))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.96 tmp.21)
                        (set! tmp.96 (bitwise-and tmp.96 7))
                        (set! tmp.67 tmp.96))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.97 tmp.21)
              (set! tmp.97 (+ tmp.97 tmp.22))
              (set! rax tmp.97)
              (jump tmp-ra.82 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.82 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.82 rbp rax)))))
    (define L.fun/void10674.4
      ((new-frames ()) (locals (tmp-ra.83)))
      (begin (set! tmp-ra.83 r15) (set! rax 30) (jump tmp-ra.83 rbp rax)))
    (define L.fun/error10675.5
      ((new-frames ()) (locals (tmp-ra.84)))
      (begin (set! tmp-ra.84 r15) (set! rax 64318) (jump tmp-ra.84 rbp rax)))
    (define L.fun/void10672.6
      ((new-frames ()) (locals (tmp-ra.85)))
      (begin (set! tmp-ra.85 r15) (set! rax 30) (jump tmp-ra.85 rbp rax)))
    (define L.fun/empty10673.7
      ((new-frames ()) (locals (tmp-ra.86)))
      (begin (set! tmp-ra.86 r15) (set! rax 22) (jump tmp-ra.86 rbp rax)))
    (begin
      (set! tmp-ra.87 r15)
      (return-point L.rp.12
        (begin
          (set! rsi 1560)
          (set! rdi 1112)
          (set! r15 L.rp.12)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 704)
          (set! rdi 904)
          (set! r15 L.rp.13)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.14
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.14)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 744)
          (set! rdi 216)
          (set! r15 L.rp.15)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 1952)
          (set! rdi 1832)
          (set! r15 L.rp.16)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.17
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.17)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.71)
          (set! rdi tmp.68)
          (set! r15 L.rp.18)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! fixnum0.5 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/void10672.6 rbp r15)))
      (set! void1.4 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/empty10673.7 rbp r15)))
      (set! empty2.3 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/void10674.4 rbp r15)))
      (set! void3.2 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1024)
          (set! rdi 760)
          (set! r15 L.rp.22)
          (jump L.*.11 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 160)
          (set! rdi 1344)
          (set! r15 L.rp.23)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.24)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 648)
          (set! rdi 1136)
          (set! r15 L.rp.25)
          (jump L.*.11 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 224)
          (set! rdi 736)
          (set! r15 L.rp.26)
          (jump L.*.11 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.27)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.74)
          (set! r15 L.rp.28)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! fixnum4.1 rax)
      (set! r15 tmp-ra.87)
      (jump L.fun/error10675.5 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () ()))
     (locals
      (void4.1
       fixnum3.2
       tmp.68
       tmp.70
       tmp.69
       tmp.65
       tmp.67
       tmp.66
       empty2.3
       boolean1.4
       tmp.64
       ascii-char0.5
       tmp-ra.78)))
    (define L.-.11
      ((new-frames ())
       (locals
        (tmp.57
         tmp.80
         tmp.23
         tmp.58
         tmp.81
         tmp-ra.71
         tmp.56
         tmp.24
         tmp.79
         tmp.55)))
      (begin
        (set! tmp-ra.71 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.79 tmp.24)
                      (set! tmp.79 (bitwise-and tmp.79 7))
                      (set! tmp.56 tmp.79))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.80 tmp.23)
                        (set! tmp.80 (bitwise-and tmp.80 7))
                        (set! tmp.58 tmp.80))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.81 tmp.23)
              (set! tmp.81 (- tmp.81 tmp.24))
              (set! rax tmp.81)
              (jump tmp-ra.71 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.71 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.71 rbp rax)))))
    (define L.+.10
      ((new-frames ())
       (locals
        (tmp.61
         tmp.83
         tmp.21
         tmp.62
         tmp.84
         tmp-ra.72
         tmp.60
         tmp.22
         tmp.82
         tmp.59)))
      (begin
        (set! tmp-ra.72 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.82 tmp.22)
                      (set! tmp.82 (bitwise-and tmp.82 7))
                      (set! tmp.60 tmp.82))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.83 tmp.21)
                        (set! tmp.83 (bitwise-and tmp.83 7))
                        (set! tmp.62 tmp.83))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.84 tmp.21)
              (set! tmp.84 (+ tmp.84 tmp.22))
              (set! rax tmp.84)
              (jump tmp-ra.72 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.72 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.72 rbp rax)))))
    (define L.ascii-char?.9
      ((new-frames ()) (locals (tmp-ra.73 tmp.85 tmp.46 tmp.63)))
      (begin
        (set! tmp-ra.73 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.85 tmp.46)
                (set! tmp.85 (bitwise-and tmp.85 255))
                (set! tmp.63 tmp.85))
              (= tmp.63 46))
          (begin (set! rax 14) (jump tmp-ra.73 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.73 rbp rax)))))
    (define L.fun/any10855.4
      ((new-frames ()) (locals (tmp-ra.74)))
      (begin (set! tmp-ra.74 r15) (set! rax 25390) (jump tmp-ra.74 rbp rax)))
    (define L.fun/ascii-char10854.5
      ((new-frames ()) (locals (tmp-ra.75)))
      (begin (set! tmp-ra.75 r15) (set! rax 25390) (jump tmp-ra.75 rbp rax)))
    (define L.fun/empty10856.6
      ((new-frames ()) (locals (tmp-ra.76)))
      (begin (set! tmp-ra.76 r15) (set! rax 22) (jump tmp-ra.76 rbp rax)))
    (define L.fun/void10857.7
      ((new-frames ()) (locals (tmp-ra.77)))
      (begin (set! tmp-ra.77 r15) (set! rax 30) (jump tmp-ra.77 rbp rax)))
    (begin
      (set! tmp-ra.78 r15)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/ascii-char10854.5 rbp r15)))
      (set! ascii-char0.5 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/any10855.4 rbp r15)))
      (set! tmp.64 rax)
      (return-point L.rp.14
        (begin
          (set! rdi tmp.64)
          (set! r15 L.rp.14)
          (jump L.ascii-char?.9 rbp r15 rdi)))
      (set! boolean1.4 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/empty10856.6 rbp r15)))
      (set! empty2.3 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 784)
          (set! rdi 1352)
          (set! r15 L.rp.16)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.66 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1792)
          (set! rdi 8)
          (set! r15 L.rp.17)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.67 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.67)
          (set! rdi tmp.66)
          (set! r15 L.rp.18)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.65 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 992)
          (set! rdi 112)
          (set! r15 L.rp.19)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 48)
          (set! rdi 1104)
          (set! r15 L.rp.20)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.21)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.68)
          (set! rdi tmp.65)
          (set! r15 L.rp.22)
          (jump L.+.10 rbp r15 rdi rsi)))
      (set! fixnum3.2 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/void10857.7 rbp r15)))
      (set! void4.1 rax)
      (set! rax empty2.3)
      (jump tmp-ra.78 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () ()))
     (locals
      (ascii-char4.1 void3.2 error2.3 ascii-char1.4 ascii-char0.5 tmp-ra.60)))
    (define L.fun/void11402.4
      ((new-frames ()) (locals (tmp-ra.55)))
      (begin (set! tmp-ra.55 r15) (set! rax 30) (jump tmp-ra.55 rbp rax)))
    (define L.fun/ascii-char11403.5
      ((new-frames ()) (locals (tmp-ra.56)))
      (begin (set! tmp-ra.56 r15) (set! rax 25390) (jump tmp-ra.56 rbp rax)))
    (define L.fun/ascii-char11400.6
      ((new-frames ()) (locals (tmp-ra.57)))
      (begin (set! tmp-ra.57 r15) (set! rax 25390) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error11401.7
      ((new-frames ()) (locals (tmp-ra.58)))
      (begin (set! tmp-ra.58 r15) (set! rax 15166) (jump tmp-ra.58 rbp rax)))
    (define L.fun/ascii-char11399.8
      ((new-frames ()) (locals (tmp-ra.59)))
      (begin (set! tmp-ra.59 r15) (set! rax 25390) (jump tmp-ra.59 rbp rax)))
    (begin
      (set! tmp-ra.60 r15)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/ascii-char11399.8 rbp r15)))
      (set! ascii-char0.5 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/ascii-char11400.6 rbp r15)))
      (set! ascii-char1.4 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/error11401.7 rbp r15)))
      (set! error2.3 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/void11402.4 rbp r15)))
      (set! void3.2 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/ascii-char11403.5 rbp r15)))
      (set! ascii-char4.1 rax)
      (set! rax void3.2)
      (jump tmp-ra.60 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () ()))
     (locals (error4.1 void3.2 ascii-char2.3 void1.4 error0.5 tmp-ra.61)))
    (define L.fun/void13621.4
      ((new-frames ()) (locals (tmp-ra.55)))
      (begin (set! tmp-ra.55 r15) (set! rax 30) (jump tmp-ra.55 rbp rax)))
    (define L.fun/ascii-char13620.5
      ((new-frames ()) (locals (tmp-ra.56)))
      (begin (set! tmp-ra.56 r15) (set! rax 25390) (jump tmp-ra.56 rbp rax)))
    (define L.fun/empty13623.6
      ((new-frames ()) (locals (tmp-ra.57)))
      (begin (set! tmp-ra.57 r15) (set! rax 22) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error13618.7
      ((new-frames ()) (locals (tmp-ra.58)))
      (begin (set! tmp-ra.58 r15) (set! rax 22846) (jump tmp-ra.58 rbp rax)))
    (define L.fun/void13619.8
      ((new-frames ()) (locals (tmp-ra.59)))
      (begin (set! tmp-ra.59 r15) (set! rax 30) (jump tmp-ra.59 rbp rax)))
    (define L.fun/error13622.9
      ((new-frames ()) (locals (tmp-ra.60)))
      (begin (set! tmp-ra.60 r15) (set! rax 25150) (jump tmp-ra.60 rbp rax)))
    (begin
      (set! tmp-ra.61 r15)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/error13618.7 rbp r15)))
      (set! error0.5 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/void13619.8 rbp r15)))
      (set! void1.4 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/ascii-char13620.5 rbp r15)))
      (set! ascii-char2.3 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/void13621.4 rbp r15)))
      (set! void3.2 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/error13622.9 rbp r15)))
      (set! error4.1 rax)
      (set! r15 tmp-ra.61)
      (jump L.fun/empty13623.6 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () ()))
     (locals
      (empty4.1
       void3.2
       fixnum2.3
       tmp.77
       tmp.79
       tmp.78
       tmp.74
       tmp.76
       tmp.75
       ascii-char1.4
       fixnum0.5
       tmp.71
       tmp.73
       tmp.72
       tmp.68
       tmp.70
       tmp.69
       tmp-ra.86)))
    (define L.-.10
      ((new-frames ())
       (locals
        (tmp.57
         tmp.88
         tmp.23
         tmp.58
         tmp.89
         tmp-ra.80
         tmp.56
         tmp.24
         tmp.87
         tmp.55)))
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
    (define L.+.9
      ((new-frames ())
       (locals
        (tmp.61
         tmp.91
         tmp.21
         tmp.62
         tmp.92
         tmp-ra.81
         tmp.60
         tmp.22
         tmp.90
         tmp.59)))
      (begin
        (set! tmp-ra.81 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.90 tmp.22)
                      (set! tmp.90 (bitwise-and tmp.90 7))
                      (set! tmp.60 tmp.90))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.91 tmp.21)
                        (set! tmp.91 (bitwise-and tmp.91 7))
                        (set! tmp.62 tmp.91))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.92 tmp.21)
              (set! tmp.92 (+ tmp.92 tmp.22))
              (set! rax tmp.92)
              (jump tmp-ra.81 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.81 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.81 rbp rax)))))
    (define L.*.8
      ((new-frames ())
       (locals
        (tmp.65
         tmp.94
         tmp.19
         tmp.66
         tmp.96
         tmp.67
         tmp.95
         tmp-ra.82
         tmp.64
         tmp.20
         tmp.93
         tmp.63)))
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
    (define L.fun/void14228.4
      ((new-frames ()) (locals (tmp-ra.83)))
      (begin (set! tmp-ra.83 r15) (set! rax 30) (jump tmp-ra.83 rbp rax)))
    (define L.fun/empty14229.5
      ((new-frames ()) (locals (tmp-ra.84)))
      (begin (set! tmp-ra.84 r15) (set! rax 22) (jump tmp-ra.84 rbp rax)))
    (define L.fun/ascii-char14227.6
      ((new-frames ()) (locals (tmp-ra.85)))
      (begin (set! tmp-ra.85 r15) (set! rax 25390) (jump tmp-ra.85 rbp rax)))
    (begin
      (set! tmp-ra.86 r15)
      (return-point L.rp.11
        (begin
          (set! rsi 1328)
          (set! rdi 1512)
          (set! r15 L.rp.11)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.12
        (begin
          (set! rsi 1096)
          (set! rdi 1088)
          (set! r15 L.rp.12)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.13
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.13)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.14
        (begin
          (set! rsi 832)
          (set! rdi 1528)
          (set! r15 L.rp.14)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 1744)
          (set! rdi 192)
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
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! fixnum0.5 rax)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/ascii-char14227.6 rbp r15)))
      (set! ascii-char1.4 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1440)
          (set! rdi 880)
          (set! r15 L.rp.19)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 320)
          (set! rdi 632)
          (set! r15 L.rp.20)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.21)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 360)
          (set! rdi 1688)
          (set! r15 L.rp.22)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 1952)
          (set! rdi 1800)
          (set! r15 L.rp.23)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.24)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.74)
          (set! r15 L.rp.25)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! fixnum2.3 rax)
      (return-point L.rp.26
        (begin (set! r15 L.rp.26) (jump L.fun/void14228.4 rbp r15)))
      (set! void3.2 rax)
      (return-point L.rp.27
        (begin (set! r15 L.rp.27) (jump L.fun/empty14229.5 rbp r15)))
      (set! empty4.1 rax)
      (set! rax empty4.1)
      (jump tmp-ra.86 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () ()))
     (locals
      (error4.1
       void3.2
       fixnum2.3
       tmp.71
       tmp.73
       tmp.72
       tmp.68
       tmp.70
       tmp.69
       empty1.4
       error0.5
       tmp-ra.82)))
    (define L.-.12
      ((new-frames ())
       (locals
        (tmp.57
         tmp.84
         tmp.23
         tmp.58
         tmp.85
         tmp-ra.74
         tmp.56
         tmp.24
         tmp.83
         tmp.55)))
      (begin
        (set! tmp-ra.74 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.83 tmp.24)
                      (set! tmp.83 (bitwise-and tmp.83 7))
                      (set! tmp.56 tmp.83))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.84 tmp.23)
                        (set! tmp.84 (bitwise-and tmp.84 7))
                        (set! tmp.58 tmp.84))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.85 tmp.23)
              (set! tmp.85 (- tmp.85 tmp.24))
              (set! rax tmp.85)
              (jump tmp-ra.74 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.74 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.74 rbp rax)))))
    (define L.+.11
      ((new-frames ())
       (locals
        (tmp.61
         tmp.87
         tmp.21
         tmp.62
         tmp.88
         tmp-ra.75
         tmp.60
         tmp.22
         tmp.86
         tmp.59)))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.86 tmp.22)
                      (set! tmp.86 (bitwise-and tmp.86 7))
                      (set! tmp.60 tmp.86))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.87 tmp.21)
                        (set! tmp.87 (bitwise-and tmp.87 7))
                        (set! tmp.62 tmp.87))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.88 tmp.21)
              (set! tmp.88 (+ tmp.88 tmp.22))
              (set! rax tmp.88)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.75 rbp rax)))))
    (define L.*.10
      ((new-frames ())
       (locals
        (tmp.65
         tmp.90
         tmp.19
         tmp.66
         tmp.92
         tmp.67
         tmp.91
         tmp-ra.76
         tmp.64
         tmp.20
         tmp.89
         tmp.63)))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.89 tmp.20)
                      (set! tmp.89 (bitwise-and tmp.89 7))
                      (set! tmp.64 tmp.89))
                    (= tmp.64 0))
                (set! tmp.63 14)
                (set! tmp.63 6))
              (!= tmp.63 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.90 tmp.19)
                        (set! tmp.90 (bitwise-and tmp.90 7))
                        (set! tmp.66 tmp.90))
                      (= tmp.66 0))
                  (set! tmp.65 14)
                  (set! tmp.65 6))
                (!= tmp.65 6))
            (begin
              (set! tmp.91 tmp.20)
              (set! tmp.91 (arithmetic-shift-right tmp.91 3))
              (set! tmp.67 tmp.91)
              (set! tmp.92 tmp.19)
              (set! tmp.92 (* tmp.92 tmp.67))
              (set! rax tmp.92)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))))
    (define L.fun/void14544.4
      ((new-frames ()) (locals (tmp-ra.77)))
      (begin (set! tmp-ra.77 r15) (set! rax 30) (jump tmp-ra.77 rbp rax)))
    (define L.fun/empty14543.5
      ((new-frames ()) (locals (tmp-ra.78)))
      (begin (set! tmp-ra.78 r15) (set! rax 22) (jump tmp-ra.78 rbp rax)))
    (define L.fun/ascii-char14546.6
      ((new-frames ()) (locals (tmp-ra.79)))
      (begin (set! tmp-ra.79 r15) (set! rax 25390) (jump tmp-ra.79 rbp rax)))
    (define L.fun/error14545.7
      ((new-frames ()) (locals (tmp-ra.80)))
      (begin (set! tmp-ra.80 r15) (set! rax 62) (jump tmp-ra.80 rbp rax)))
    (define L.fun/error14542.8
      ((new-frames ()) (locals (tmp-ra.81)))
      (begin (set! tmp-ra.81 r15) (set! rax 38462) (jump tmp-ra.81 rbp rax)))
    (begin
      (set! tmp-ra.82 r15)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/error14542.8 rbp r15)))
      (set! error0.5 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/empty14543.5 rbp r15)))
      (set! empty1.4 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 288)
          (set! rdi 1248)
          (set! r15 L.rp.15)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 552)
          (set! rdi 856)
          (set! r15 L.rp.16)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.17
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.17)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 1056)
          (set! rdi 824)
          (set! r15 L.rp.18)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1720)
          (set! rdi 608)
          (set! r15 L.rp.19)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.20)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.71)
          (set! rdi tmp.68)
          (set! r15 L.rp.21)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! fixnum2.3 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/void14544.4 rbp r15)))
      (set! void3.2 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/error14545.7 rbp r15)))
      (set! error4.1 rax)
      (set! r15 tmp-ra.82)
      (jump L.fun/ascii-char14546.6 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () ()))
     (locals
      (error4.1
       void3.2
       empty2.3
       empty1.4
       fixnum0.5
       tmp.67
       tmp.69
       tmp.68
       tmp.64
       tmp.66
       tmp.65
       tmp-ra.77)))
    (define L.-.11
      ((new-frames ())
       (locals
        (tmp.57
         tmp.79
         tmp.23
         tmp.58
         tmp.80
         tmp-ra.70
         tmp.56
         tmp.24
         tmp.78
         tmp.55)))
      (begin
        (set! tmp-ra.70 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.78 tmp.24)
                      (set! tmp.78 (bitwise-and tmp.78 7))
                      (set! tmp.56 tmp.78))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.79 tmp.23)
                        (set! tmp.79 (bitwise-and tmp.79 7))
                        (set! tmp.58 tmp.79))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.80 tmp.23)
              (set! tmp.80 (- tmp.80 tmp.24))
              (set! rax tmp.80)
              (jump tmp-ra.70 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.70 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.70 rbp rax)))))
    (define L.*.10
      ((new-frames ())
       (locals
        (tmp.61
         tmp.82
         tmp.19
         tmp.62
         tmp.84
         tmp.63
         tmp.83
         tmp-ra.71
         tmp.60
         tmp.20
         tmp.81
         tmp.59)))
      (begin
        (set! tmp-ra.71 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.81 tmp.20)
                      (set! tmp.81 (bitwise-and tmp.81 7))
                      (set! tmp.60 tmp.81))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.82 tmp.19)
                        (set! tmp.82 (bitwise-and tmp.82 7))
                        (set! tmp.62 tmp.82))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.83 tmp.20)
              (set! tmp.83 (arithmetic-shift-right tmp.83 3))
              (set! tmp.63 tmp.83)
              (set! tmp.84 tmp.19)
              (set! tmp.84 (* tmp.84 tmp.63))
              (set! rax tmp.84)
              (jump tmp-ra.71 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.71 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.71 rbp rax)))))
    (define L.fun/empty15112.4
      ((new-frames ()) (locals (tmp-ra.72)))
      (begin (set! tmp-ra.72 r15) (set! rax 22) (jump tmp-ra.72 rbp rax)))
    (define L.fun/error15114.5
      ((new-frames ()) (locals (tmp-ra.73)))
      (begin (set! tmp-ra.73 r15) (set! rax 11326) (jump tmp-ra.73 rbp rax)))
    (define L.fun/empty15111.6
      ((new-frames ()) (locals (tmp-ra.74)))
      (begin (set! tmp-ra.74 r15) (set! rax 22) (jump tmp-ra.74 rbp rax)))
    (define L.fun/ascii-char15115.7
      ((new-frames ()) (locals (tmp-ra.75)))
      (begin (set! tmp-ra.75 r15) (set! rax 25390) (jump tmp-ra.75 rbp rax)))
    (define L.fun/void15113.8
      ((new-frames ()) (locals (tmp-ra.76)))
      (begin (set! tmp-ra.76 r15) (set! rax 30) (jump tmp-ra.76 rbp rax)))
    (begin
      (set! tmp-ra.77 r15)
      (return-point L.rp.12
        (begin
          (set! rsi 1392)
          (set! rdi 1304)
          (set! r15 L.rp.12)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.65 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 368)
          (set! rdi 1800)
          (set! r15 L.rp.13)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.66 rax)
      (return-point L.rp.14
        (begin
          (set! rsi tmp.66)
          (set! rdi tmp.65)
          (set! r15 L.rp.14)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.64 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 1944)
          (set! rdi 1672)
          (set! r15 L.rp.15)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 1864)
          (set! rdi 1184)
          (set! r15 L.rp.16)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.17
        (begin
          (set! rsi tmp.69)
          (set! rdi tmp.68)
          (set! r15 L.rp.17)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.67 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.67)
          (set! rdi tmp.64)
          (set! r15 L.rp.18)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! fixnum0.5 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/empty15111.6 rbp r15)))
      (set! empty1.4 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/empty15112.4 rbp r15)))
      (set! empty2.3 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/void15113.8 rbp r15)))
      (set! void3.2 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/error15114.5 rbp r15)))
      (set! error4.1 rax)
      (set! r15 tmp-ra.77)
      (jump L.fun/ascii-char15115.7 rbp r15))))
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
       ()))
     (locals
      (boolean4.1
       tmp.87
       fixnum3.2
       tmp.84
       tmp.86
       tmp.85
       tmp.81
       tmp.83
       tmp.82
       fixnum2.3
       tmp.78
       tmp.80
       tmp.79
       tmp.75
       tmp.77
       tmp.76
       fixnum1.4
       tmp.72
       tmp.74
       tmp.73
       tmp.69
       tmp.71
       tmp.70
       empty0.5
       tmp-ra.95)))
    (define L.fixnum?.11
      ((new-frames ()) (locals (tmp-ra.88 tmp.96 tmp.42 tmp.55)))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.42 rdi)
        (if (begin
              (begin
                (set! tmp.96 tmp.42)
                (set! tmp.96 (bitwise-and tmp.96 7))
                (set! tmp.55 tmp.96))
              (= tmp.55 0))
          (begin (set! rax 14) (jump tmp-ra.88 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.88 rbp rax)))))
    (define L.-.10
      ((new-frames ())
       (locals
        (tmp.58
         tmp.98
         tmp.23
         tmp.59
         tmp.99
         tmp-ra.89
         tmp.57
         tmp.24
         tmp.97
         tmp.56)))
      (begin
        (set! tmp-ra.89 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.24)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.57 tmp.97))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.23)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.59 tmp.98))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.99 tmp.23)
              (set! tmp.99 (- tmp.99 tmp.24))
              (set! rax tmp.99)
              (jump tmp-ra.89 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.89 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.89 rbp rax)))))
    (define L.+.9
      ((new-frames ())
       (locals
        (tmp.62
         tmp.101
         tmp.21
         tmp.63
         tmp.102
         tmp-ra.90
         tmp.61
         tmp.22
         tmp.100
         tmp.60)))
      (begin
        (set! tmp-ra.90 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.100 tmp.22)
                      (set! tmp.100 (bitwise-and tmp.100 7))
                      (set! tmp.61 tmp.100))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.101 tmp.21)
                        (set! tmp.101 (bitwise-and tmp.101 7))
                        (set! tmp.63 tmp.101))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.102 tmp.21)
              (set! tmp.102 (+ tmp.102 tmp.22))
              (set! rax tmp.102)
              (jump tmp-ra.90 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.90 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.90 rbp rax)))))
    (define L.*.8
      ((new-frames ())
       (locals
        (tmp.66
         tmp.104
         tmp.19
         tmp.67
         tmp.106
         tmp.68
         tmp.105
         tmp-ra.91
         tmp.65
         tmp.20
         tmp.103
         tmp.64)))
      (begin
        (set! tmp-ra.91 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.103 tmp.20)
                      (set! tmp.103 (bitwise-and tmp.103 7))
                      (set! tmp.65 tmp.103))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.104 tmp.19)
                        (set! tmp.104 (bitwise-and tmp.104 7))
                        (set! tmp.67 tmp.104))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.105 tmp.20)
              (set! tmp.105 (arithmetic-shift-right tmp.105 3))
              (set! tmp.68 tmp.105)
              (set! tmp.106 tmp.19)
              (set! tmp.106 (* tmp.106 tmp.68))
              (set! rax tmp.106)
              (jump tmp-ra.91 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.91 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.91 rbp rax)))))
    (define L.fun/empty16025.4
      ((new-frames ()) (locals (tmp-ra.92)))
      (begin (set! tmp-ra.92 r15) (set! rax 22) (jump tmp-ra.92 rbp rax)))
    (define L.fun/ascii-char16027.5
      ((new-frames ()) (locals (tmp-ra.93)))
      (begin (set! tmp-ra.93 r15) (set! rax 25390) (jump tmp-ra.93 rbp rax)))
    (define L.fun/any16026.6
      ((new-frames ()) (locals (tmp-ra.94)))
      (begin (set! tmp-ra.94 r15) (set! rax 30) (jump tmp-ra.94 rbp rax)))
    (begin
      (set! tmp-ra.95 r15)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/empty16025.4 rbp r15)))
      (set! empty0.5 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 224)
          (set! rdi 56)
          (set! r15 L.rp.13)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.14
        (begin
          (set! rsi 384)
          (set! rdi 336)
          (set! r15 L.rp.14)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.15
        (begin
          (set! rsi tmp.71)
          (set! rdi tmp.70)
          (set! r15 L.rp.15)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 672)
          (set! rdi 1936)
          (set! r15 L.rp.16)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1760)
          (set! rdi 1096)
          (set! r15 L.rp.17)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.73)
          (set! r15 L.rp.18)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.19
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.69)
          (set! r15 L.rp.19)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! fixnum1.4 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 1408)
          (set! rdi 56)
          (set! r15 L.rp.20)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 528)
          (set! rdi 8)
          (set! r15 L.rp.21)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.76)
          (set! r15 L.rp.22)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 376)
          (set! rdi 472)
          (set! r15 L.rp.23)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 656)
          (set! rdi 1000)
          (set! r15 L.rp.24)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.79)
          (set! r15 L.rp.25)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.26
        (begin
          (set! rsi tmp.78)
          (set! rdi tmp.75)
          (set! r15 L.rp.26)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! fixnum2.3 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 464)
          (set! rdi 1064)
          (set! r15 L.rp.27)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1504)
          (set! rdi 1088)
          (set! r15 L.rp.28)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.82)
          (set! r15 L.rp.29)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 1048)
          (set! rdi 1328)
          (set! r15 L.rp.30)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 560)
          (set! rdi 1832)
          (set! r15 L.rp.31)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.86)
          (set! rdi tmp.85)
          (set! r15 L.rp.32)
          (jump L.*.8 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.84)
          (set! rdi tmp.81)
          (set! r15 L.rp.33)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! fixnum3.2 rax)
      (return-point L.rp.34
        (begin (set! r15 L.rp.34) (jump L.fun/any16026.6 rbp r15)))
      (set! tmp.87 rax)
      (return-point L.rp.35
        (begin
          (set! rdi tmp.87)
          (set! r15 L.rp.35)
          (jump L.fixnum?.11 rbp r15 rdi)))
      (set! boolean4.1 rax)
      (set! r15 tmp-ra.95)
      (jump L.fun/ascii-char16027.5 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () ()))
     (locals
      (tmp.71
       tmp.73
       tmp.72
       tmp.68
       tmp.70
       tmp.69
       error4.1
       error3.2
       ascii-char2.3
       ascii-char1.4
       void0.5
       tmp-ra.82)))
    (define L.*.12
      ((new-frames ())
       (locals
        (tmp.57
         tmp.84
         tmp.19
         tmp.58
         tmp.86
         tmp.59
         tmp.85
         tmp-ra.74
         tmp.56
         tmp.20
         tmp.83
         tmp.55)))
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
    (define L.+.11
      ((new-frames ())
       (locals
        (tmp.62
         tmp.88
         tmp.21
         tmp.63
         tmp.89
         tmp-ra.75
         tmp.61
         tmp.22
         tmp.87
         tmp.60)))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.87 tmp.22)
                      (set! tmp.87 (bitwise-and tmp.87 7))
                      (set! tmp.61 tmp.87))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.88 tmp.21)
                        (set! tmp.88 (bitwise-and tmp.88 7))
                        (set! tmp.63 tmp.88))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.89 tmp.21)
              (set! tmp.89 (+ tmp.89 tmp.22))
              (set! rax tmp.89)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.75 rbp rax)))))
    (define L.-.10
      ((new-frames ())
       (locals
        (tmp.66
         tmp.91
         tmp.23
         tmp.67
         tmp.92
         tmp-ra.76
         tmp.65
         tmp.24
         tmp.90
         tmp.64)))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.90 tmp.24)
                      (set! tmp.90 (bitwise-and tmp.90 7))
                      (set! tmp.65 tmp.90))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.91 tmp.23)
                        (set! tmp.91 (bitwise-and tmp.91 7))
                        (set! tmp.67 tmp.91))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.92 tmp.23)
              (set! tmp.92 (- tmp.92 tmp.24))
              (set! rax tmp.92)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.76 rbp rax)))))
    (define L.fun/ascii-char19237.4
      ((new-frames ()) (locals (tmp-ra.77)))
      (begin (set! tmp-ra.77 r15) (set! rax 25390) (jump tmp-ra.77 rbp rax)))
    (define L.fun/ascii-char19236.5
      ((new-frames ()) (locals (tmp-ra.78)))
      (begin (set! tmp-ra.78 r15) (set! rax 25390) (jump tmp-ra.78 rbp rax)))
    (define L.fun/error19239.6
      ((new-frames ()) (locals (tmp-ra.79)))
      (begin (set! tmp-ra.79 r15) (set! rax 55358) (jump tmp-ra.79 rbp rax)))
    (define L.fun/void19235.7
      ((new-frames ()) (locals (tmp-ra.80)))
      (begin (set! tmp-ra.80 r15) (set! rax 30) (jump tmp-ra.80 rbp rax)))
    (define L.fun/error19238.8
      ((new-frames ()) (locals (tmp-ra.81)))
      (begin (set! tmp-ra.81 r15) (set! rax 21566) (jump tmp-ra.81 rbp rax)))
    (begin
      (set! tmp-ra.82 r15)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/void19235.7 rbp r15)))
      (set! void0.5 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/ascii-char19236.5 rbp r15)))
      (set! ascii-char1.4 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/ascii-char19237.4 rbp r15)))
      (set! ascii-char2.3 rax)
      (return-point L.rp.16
        (begin (set! r15 L.rp.16) (jump L.fun/error19238.8 rbp r15)))
      (set! error3.2 rax)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/error19239.6 rbp r15)))
      (set! error4.1 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 160)
          (set! rdi 1752)
          (set! r15 L.rp.18)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1232)
          (set! rdi 456)
          (set! r15 L.rp.19)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.20)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 1432)
          (set! rdi 792)
          (set! r15 L.rp.21)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1552)
          (set! rdi 1848)
          (set! r15 L.rp.22)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.23)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (set! rsi tmp.71)
      (set! rdi tmp.68)
      (set! r15 tmp-ra.82)
      (jump L.-.10 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () ()))
     (locals
      (tmp.71
       tmp.73
       tmp.72
       tmp.68
       tmp.70
       tmp.69
       ascii-char4.1
       ascii-char3.2
       error2.3
       empty1.4
       empty0.5
       tmp-ra.82)))
    (define L.*.12
      ((new-frames ())
       (locals
        (tmp.57
         tmp.84
         tmp.19
         tmp.58
         tmp.86
         tmp.59
         tmp.85
         tmp-ra.74
         tmp.56
         tmp.20
         tmp.83
         tmp.55)))
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
    (define L.+.11
      ((new-frames ())
       (locals
        (tmp.62
         tmp.88
         tmp.21
         tmp.63
         tmp.89
         tmp-ra.75
         tmp.61
         tmp.22
         tmp.87
         tmp.60)))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.87 tmp.22)
                      (set! tmp.87 (bitwise-and tmp.87 7))
                      (set! tmp.61 tmp.87))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.88 tmp.21)
                        (set! tmp.88 (bitwise-and tmp.88 7))
                        (set! tmp.63 tmp.88))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.89 tmp.21)
              (set! tmp.89 (+ tmp.89 tmp.22))
              (set! rax tmp.89)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.75 rbp rax)))))
    (define L.-.10
      ((new-frames ())
       (locals
        (tmp.66
         tmp.91
         tmp.23
         tmp.67
         tmp.92
         tmp-ra.76
         tmp.65
         tmp.24
         tmp.90
         tmp.64)))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.90 tmp.24)
                      (set! tmp.90 (bitwise-and tmp.90 7))
                      (set! tmp.65 tmp.90))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.91 tmp.23)
                        (set! tmp.91 (bitwise-and tmp.91 7))
                        (set! tmp.67 tmp.91))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.92 tmp.23)
              (set! tmp.92 (- tmp.92 tmp.24))
              (set! rax tmp.92)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.76 rbp rax)))))
    (define L.fun/empty20765.4
      ((new-frames ()) (locals (tmp-ra.77)))
      (begin (set! tmp-ra.77 r15) (set! rax 22) (jump tmp-ra.77 rbp rax)))
    (define L.fun/ascii-char20767.5
      ((new-frames ()) (locals (tmp-ra.78)))
      (begin (set! tmp-ra.78 r15) (set! rax 25390) (jump tmp-ra.78 rbp rax)))
    (define L.fun/ascii-char20768.6
      ((new-frames ()) (locals (tmp-ra.79)))
      (begin (set! tmp-ra.79 r15) (set! rax 25390) (jump tmp-ra.79 rbp rax)))
    (define L.fun/empty20764.7
      ((new-frames ()) (locals (tmp-ra.80)))
      (begin (set! tmp-ra.80 r15) (set! rax 22) (jump tmp-ra.80 rbp rax)))
    (define L.fun/error20766.8
      ((new-frames ()) (locals (tmp-ra.81)))
      (begin (set! tmp-ra.81 r15) (set! rax 64574) (jump tmp-ra.81 rbp rax)))
    (begin
      (set! tmp-ra.82 r15)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/empty20764.7 rbp r15)))
      (set! empty0.5 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/empty20765.4 rbp r15)))
      (set! empty1.4 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/error20766.8 rbp r15)))
      (set! error2.3 rax)
      (return-point L.rp.16
        (begin (set! r15 L.rp.16) (jump L.fun/ascii-char20767.5 rbp r15)))
      (set! ascii-char3.2 rax)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/ascii-char20768.6 rbp r15)))
      (set! ascii-char4.1 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 1184)
          (set! rdi 1504)
          (set! r15 L.rp.18)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1296)
          (set! rdi 1616)
          (set! r15 L.rp.19)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.20)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 1272)
          (set! rdi 8)
          (set! r15 L.rp.21)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 528)
          (set! rdi 888)
          (set! r15 L.rp.22)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.23)
          (jump L.*.12 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (set! rsi tmp.71)
      (set! rdi tmp.68)
      (set! r15 tmp-ra.82)
      (jump L.*.12 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () ()))
     (locals
      (fixnum4.1
       tmp.77
       tmp.79
       tmp.78
       tmp.74
       tmp.76
       tmp.75
       ascii-char3.2
       ascii-char2.3
       fixnum1.4
       tmp.71
       tmp.73
       tmp.72
       tmp.68
       tmp.70
       tmp.69
       ascii-char0.5
       tmp-ra.87)))
    (define L.-.11
      ((new-frames ())
       (locals
        (tmp.57
         tmp.89
         tmp.23
         tmp.58
         tmp.90
         tmp-ra.80
         tmp.56
         tmp.24
         tmp.88
         tmp.55)))
      (begin
        (set! tmp-ra.80 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.88 tmp.24)
                      (set! tmp.88 (bitwise-and tmp.88 7))
                      (set! tmp.56 tmp.88))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.89 tmp.23)
                        (set! tmp.89 (bitwise-and tmp.89 7))
                        (set! tmp.58 tmp.89))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.90 tmp.23)
              (set! tmp.90 (- tmp.90 tmp.24))
              (set! rax tmp.90)
              (jump tmp-ra.80 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.80 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.80 rbp rax)))))
    (define L.*.10
      ((new-frames ())
       (locals
        (tmp.61
         tmp.92
         tmp.19
         tmp.62
         tmp.94
         tmp.63
         tmp.93
         tmp-ra.81
         tmp.60
         tmp.20
         tmp.91
         tmp.59)))
      (begin
        (set! tmp-ra.81 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.91 tmp.20)
                      (set! tmp.91 (bitwise-and tmp.91 7))
                      (set! tmp.60 tmp.91))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.92 tmp.19)
                        (set! tmp.92 (bitwise-and tmp.92 7))
                        (set! tmp.62 tmp.92))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.93 tmp.20)
              (set! tmp.93 (arithmetic-shift-right tmp.93 3))
              (set! tmp.63 tmp.93)
              (set! tmp.94 tmp.19)
              (set! tmp.94 (* tmp.94 tmp.63))
              (set! rax tmp.94)
              (jump tmp-ra.81 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.81 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.81 rbp rax)))))
    (define L.+.9
      ((new-frames ())
       (locals
        (tmp.66
         tmp.96
         tmp.21
         tmp.67
         tmp.97
         tmp-ra.82
         tmp.65
         tmp.22
         tmp.95
         tmp.64)))
      (begin
        (set! tmp-ra.82 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.95 tmp.22)
                      (set! tmp.95 (bitwise-and tmp.95 7))
                      (set! tmp.65 tmp.95))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.96 tmp.21)
                        (set! tmp.96 (bitwise-and tmp.96 7))
                        (set! tmp.67 tmp.96))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.97 tmp.21)
              (set! tmp.97 (+ tmp.97 tmp.22))
              (set! rax tmp.97)
              (jump tmp-ra.82 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.82 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.82 rbp rax)))))
    (define L.fun/ascii-char21096.4
      ((new-frames ()) (locals (tmp-ra.83)))
      (begin (set! tmp-ra.83 r15) (set! rax 25390) (jump tmp-ra.83 rbp rax)))
    (define L.fun/ascii-char21098.5
      ((new-frames ()) (locals (tmp-ra.84)))
      (begin (set! tmp-ra.84 r15) (set! rax 25390) (jump tmp-ra.84 rbp rax)))
    (define L.fun/error21099.6
      ((new-frames ()) (locals (tmp-ra.85)))
      (begin (set! tmp-ra.85 r15) (set! rax 33086) (jump tmp-ra.85 rbp rax)))
    (define L.fun/ascii-char21097.7
      ((new-frames ()) (locals (tmp-ra.86)))
      (begin (set! tmp-ra.86 r15) (set! rax 25390) (jump tmp-ra.86 rbp rax)))
    (begin
      (set! tmp-ra.87 r15)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/ascii-char21096.4 rbp r15)))
      (set! ascii-char0.5 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 1976)
          (set! rdi 1208)
          (set! r15 L.rp.13)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.14
        (begin
          (set! rsi 32)
          (set! rdi 1432)
          (set! r15 L.rp.14)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.15
        (begin
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 L.rp.15)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 456)
          (set! rdi 1400)
          (set! r15 L.rp.16)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1672)
          (set! rdi 888)
          (set! r15 L.rp.17)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.18)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.19
        (begin
          (set! rsi tmp.71)
          (set! rdi tmp.68)
          (set! r15 L.rp.19)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! fixnum1.4 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/ascii-char21097.7 rbp r15)))
      (set! ascii-char2.3 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/ascii-char21098.5 rbp r15)))
      (set! ascii-char3.2 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1800)
          (set! rdi 1032)
          (set! r15 L.rp.22)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 560)
          (set! rdi 552)
          (set! r15 L.rp.23)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.24)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 368)
          (set! rdi 1424)
          (set! r15 L.rp.25)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 296)
          (set! rdi 864)
          (set! r15 L.rp.26)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.27)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.74)
          (set! r15 L.rp.28)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! fixnum4.1 rax)
      (set! r15 tmp-ra.87)
      (jump L.fun/error21099.6 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () ()))
     (locals
      (void4.1
       void3.2
       fixnum2.3
       tmp.66
       tmp.68
       tmp.67
       tmp.63
       tmp.65
       tmp.64
       void1.4
       ascii-char0.5
       tmp-ra.75)))
    (define L.-.10
      ((new-frames ())
       (locals
        (tmp.57
         tmp.77
         tmp.23
         tmp.58
         tmp.78
         tmp-ra.69
         tmp.56
         tmp.24
         tmp.76
         tmp.55)))
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
      ((new-frames ())
       (locals
        (tmp.61
         tmp.80
         tmp.21
         tmp.62
         tmp.81
         tmp-ra.70
         tmp.60
         tmp.22
         tmp.79
         tmp.59)))
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
    (define L.fun/void21257.4
      ((new-frames ()) (locals (tmp-ra.71)))
      (begin (set! tmp-ra.71 r15) (set! rax 30) (jump tmp-ra.71 rbp rax)))
    (define L.fun/void21255.5
      ((new-frames ()) (locals (tmp-ra.72)))
      (begin (set! tmp-ra.72 r15) (set! rax 30) (jump tmp-ra.72 rbp rax)))
    (define L.fun/void21256.6
      ((new-frames ()) (locals (tmp-ra.73)))
      (begin (set! tmp-ra.73 r15) (set! rax 30) (jump tmp-ra.73 rbp rax)))
    (define L.fun/ascii-char21254.7
      ((new-frames ()) (locals (tmp-ra.74)))
      (begin (set! tmp-ra.74 r15) (set! rax 25390) (jump tmp-ra.74 rbp rax)))
    (begin
      (set! tmp-ra.75 r15)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/ascii-char21254.7 rbp r15)))
      (set! ascii-char0.5 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/void21255.5 rbp r15)))
      (set! void1.4 rax)
      (return-point L.rp.13
        (begin
          (set! rsi 736)
          (set! rdi 1728)
          (set! r15 L.rp.13)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.64 rax)
      (return-point L.rp.14
        (begin
          (set! rsi 192)
          (set! rdi 1624)
          (set! r15 L.rp.14)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.65 rax)
      (return-point L.rp.15
        (begin
          (set! rsi tmp.65)
          (set! rdi tmp.64)
          (set! r15 L.rp.15)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.63 rax)
      (return-point L.rp.16
        (begin
          (set! rsi 888)
          (set! rdi 160)
          (set! r15 L.rp.16)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.67 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1920)
          (set! rdi 1968)
          (set! r15 L.rp.17)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! tmp.68 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.68)
          (set! rdi tmp.67)
          (set! r15 L.rp.18)
          (jump L.+.9 rbp r15 rdi rsi)))
      (set! tmp.66 rax)
      (return-point L.rp.19
        (begin
          (set! rsi tmp.66)
          (set! rdi tmp.63)
          (set! r15 L.rp.19)
          (jump L.-.10 rbp r15 rdi rsi)))
      (set! fixnum2.3 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/void21256.6 rbp r15)))
      (set! void3.2 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/void21257.4 rbp r15)))
      (set! void4.1 rax)
      (set! rax void1.4)
      (jump tmp-ra.75 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () ()))
     (locals (empty4.1 error3.2 empty2.3 empty1.4 error0.5 tmp-ra.60)))
    (define L.fun/error21502.4
      ((new-frames ()) (locals (tmp-ra.55)))
      (begin (set! tmp-ra.55 r15) (set! rax 12606) (jump tmp-ra.55 rbp rax)))
    (define L.fun/empty21506.5
      ((new-frames ()) (locals (tmp-ra.56)))
      (begin (set! tmp-ra.56 r15) (set! rax 22) (jump tmp-ra.56 rbp rax)))
    (define L.fun/empty21503.6
      ((new-frames ()) (locals (tmp-ra.57)))
      (begin (set! tmp-ra.57 r15) (set! rax 22) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error21505.7
      ((new-frames ()) (locals (tmp-ra.58)))
      (begin (set! tmp-ra.58 r15) (set! rax 45630) (jump tmp-ra.58 rbp rax)))
    (define L.fun/empty21504.8
      ((new-frames ()) (locals (tmp-ra.59)))
      (begin (set! tmp-ra.59 r15) (set! rax 22) (jump tmp-ra.59 rbp rax)))
    (begin
      (set! tmp-ra.60 r15)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/error21502.4 rbp r15)))
      (set! error0.5 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/empty21503.6 rbp r15)))
      (set! empty1.4 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/empty21504.8 rbp r15)))
      (set! empty2.3 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/error21505.7 rbp r15)))
      (set! error3.2 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/empty21506.5 rbp r15)))
      (set! empty4.1 rax)
      (set! rax error0.5)
      (jump tmp-ra.60 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () ()))
     (locals
      (tmp.71
       tmp.73
       tmp.72
       tmp.68
       tmp.70
       tmp.69
       void4.1
       ascii-char3.2
       void2.3
       void1.4
       empty0.5
       tmp-ra.82)))
    (define L.+.12
      ((new-frames ())
       (locals
        (tmp.57
         tmp.84
         tmp.21
         tmp.58
         tmp.85
         tmp-ra.74
         tmp.56
         tmp.22
         tmp.83
         tmp.55)))
      (begin
        (set! tmp-ra.74 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.83 tmp.22)
                      (set! tmp.83 (bitwise-and tmp.83 7))
                      (set! tmp.56 tmp.83))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.84 tmp.21)
                        (set! tmp.84 (bitwise-and tmp.84 7))
                        (set! tmp.58 tmp.84))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.85 tmp.21)
              (set! tmp.85 (+ tmp.85 tmp.22))
              (set! rax tmp.85)
              (jump tmp-ra.74 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.74 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.74 rbp rax)))))
    (define L.-.11
      ((new-frames ())
       (locals
        (tmp.61
         tmp.87
         tmp.23
         tmp.62
         tmp.88
         tmp-ra.75
         tmp.60
         tmp.24
         tmp.86
         tmp.59)))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.86 tmp.24)
                      (set! tmp.86 (bitwise-and tmp.86 7))
                      (set! tmp.60 tmp.86))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.87 tmp.23)
                        (set! tmp.87 (bitwise-and tmp.87 7))
                        (set! tmp.62 tmp.87))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.88 tmp.23)
              (set! tmp.88 (- tmp.88 tmp.24))
              (set! rax tmp.88)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.75 rbp rax)))))
    (define L.*.10
      ((new-frames ())
       (locals
        (tmp.65
         tmp.90
         tmp.19
         tmp.66
         tmp.92
         tmp.67
         tmp.91
         tmp-ra.76
         tmp.64
         tmp.20
         tmp.89
         tmp.63)))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.89 tmp.20)
                      (set! tmp.89 (bitwise-and tmp.89 7))
                      (set! tmp.64 tmp.89))
                    (= tmp.64 0))
                (set! tmp.63 14)
                (set! tmp.63 6))
              (!= tmp.63 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.90 tmp.19)
                        (set! tmp.90 (bitwise-and tmp.90 7))
                        (set! tmp.66 tmp.90))
                      (= tmp.66 0))
                  (set! tmp.65 14)
                  (set! tmp.65 6))
                (!= tmp.65 6))
            (begin
              (set! tmp.91 tmp.20)
              (set! tmp.91 (arithmetic-shift-right tmp.91 3))
              (set! tmp.67 tmp.91)
              (set! tmp.92 tmp.19)
              (set! tmp.92 (* tmp.92 tmp.67))
              (set! rax tmp.92)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))))
    (define L.fun/empty21523.4
      ((new-frames ()) (locals (tmp-ra.77)))
      (begin (set! tmp-ra.77 r15) (set! rax 22) (jump tmp-ra.77 rbp rax)))
    (define L.fun/void21525.5
      ((new-frames ()) (locals (tmp-ra.78)))
      (begin (set! tmp-ra.78 r15) (set! rax 30) (jump tmp-ra.78 rbp rax)))
    (define L.fun/void21524.6
      ((new-frames ()) (locals (tmp-ra.79)))
      (begin (set! tmp-ra.79 r15) (set! rax 30) (jump tmp-ra.79 rbp rax)))
    (define L.fun/void21527.7
      ((new-frames ()) (locals (tmp-ra.80)))
      (begin (set! tmp-ra.80 r15) (set! rax 30) (jump tmp-ra.80 rbp rax)))
    (define L.fun/ascii-char21526.8
      ((new-frames ()) (locals (tmp-ra.81)))
      (begin (set! tmp-ra.81 r15) (set! rax 25390) (jump tmp-ra.81 rbp rax)))
    (begin
      (set! tmp-ra.82 r15)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/empty21523.4 rbp r15)))
      (set! empty0.5 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/void21524.6 rbp r15)))
      (set! void1.4 rax)
      (return-point L.rp.15
        (begin (set! r15 L.rp.15) (jump L.fun/void21525.5 rbp r15)))
      (set! void2.3 rax)
      (return-point L.rp.16
        (begin (set! r15 L.rp.16) (jump L.fun/ascii-char21526.8 rbp r15)))
      (set! ascii-char3.2 rax)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/void21527.7 rbp r15)))
      (set! void4.1 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 1448)
          (set! rdi 1072)
          (set! r15 L.rp.18)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1416)
          (set! rdi 496)
          (set! r15 L.rp.19)
          (jump L.-.11 rbp r15 rdi rsi)))
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
          (set! rsi 1208)
          (set! rdi 80)
          (set! r15 L.rp.21)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1032)
          (set! rdi 888)
          (set! r15 L.rp.22)
          (jump L.-.11 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.23)
          (jump L.+.12 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (set! rsi tmp.71)
      (set! rdi tmp.68)
      (set! r15 tmp-ra.82)
      (jump L.+.12 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((new-frames (() () () () ()))
     (locals (ascii-char4.1 void3.2 void2.3 empty1.4 void0.5 tmp-ra.60)))
    (define L.fun/void22132.4
      ((new-frames ()) (locals (tmp-ra.55)))
      (begin (set! tmp-ra.55 r15) (set! rax 30) (jump tmp-ra.55 rbp rax)))
    (define L.fun/void22129.5
      ((new-frames ()) (locals (tmp-ra.56)))
      (begin (set! tmp-ra.56 r15) (set! rax 30) (jump tmp-ra.56 rbp rax)))
    (define L.fun/void22131.6
      ((new-frames ()) (locals (tmp-ra.57)))
      (begin (set! tmp-ra.57 r15) (set! rax 30) (jump tmp-ra.57 rbp rax)))
    (define L.fun/empty22130.7
      ((new-frames ()) (locals (tmp-ra.58)))
      (begin (set! tmp-ra.58 r15) (set! rax 22) (jump tmp-ra.58 rbp rax)))
    (define L.fun/ascii-char22133.8
      ((new-frames ()) (locals (tmp-ra.59)))
      (begin (set! tmp-ra.59 r15) (set! rax 25390) (jump tmp-ra.59 rbp rax)))
    (begin
      (set! tmp-ra.60 r15)
      (return-point L.rp.10
        (begin (set! r15 L.rp.10) (jump L.fun/void22129.5 rbp r15)))
      (set! void0.5 rax)
      (return-point L.rp.11
        (begin (set! r15 L.rp.11) (jump L.fun/empty22130.7 rbp r15)))
      (set! empty1.4 rax)
      (return-point L.rp.12
        (begin (set! r15 L.rp.12) (jump L.fun/void22131.6 rbp r15)))
      (set! void2.3 rax)
      (return-point L.rp.13
        (begin (set! r15 L.rp.13) (jump L.fun/void22132.4 rbp r15)))
      (set! void3.2 rax)
      (return-point L.rp.14
        (begin (set! r15 L.rp.14) (jump L.fun/ascii-char22133.8 rbp r15)))
      (set! ascii-char4.1 rax)
      (set! rax ascii-char4.1)
      (jump tmp-ra.60 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () () () () ()))
     (locals
      (void5.1
       fixnum4.2
       tmp.76
       tmp.80
       tmp.82
       tmp.81
       tmp.77
       tmp.79
       tmp.78
       tmp.69
       tmp.73
       tmp.75
       tmp.74
       tmp.70
       tmp.72
       tmp.71
       error3.3
       empty2.4
       ascii-char1.5
       ascii-char0.6
       tmp-ra.96)))
    (define L.-.17
      ((new-frames ())
       (locals
        (tmp.58
         tmp.98
         tmp.24
         tmp.59
         tmp.99
         tmp-ra.83
         tmp.57
         tmp.25
         tmp.97
         tmp.56)))
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
      ((new-frames ())
       (locals
        (tmp.62
         tmp.101
         tmp.22
         tmp.63
         tmp.102
         tmp-ra.84
         tmp.61
         tmp.23
         tmp.100
         tmp.60)))
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
      ((new-frames ())
       (locals
        (tmp.66
         tmp.104
         tmp.20
         tmp.67
         tmp.106
         tmp.68
         tmp.105
         tmp-ra.85
         tmp.65
         tmp.21
         tmp.103
         tmp.64)))
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
    (define L.fun/ascii-char35206.4
      ((new-frames ()) (locals (tmp-ra.86)))
      (begin
        (set! tmp-ra.86 r15)
        (set! r15 tmp-ra.86)
        (jump L.fun/ascii-char35207.9 rbp r15)))
    (define L.fun/ascii-char35208.5
      ((new-frames ()) (locals (tmp-ra.87)))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/ascii-char35209.10 rbp r15)))
    (define L.fun/empty35210.6
      ((new-frames ()) (locals (tmp-ra.88)))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/empty35211.13 rbp r15)))
    (define L.fun/error35213.7
      ((new-frames ()) (locals (tmp-ra.89)))
      (begin (set! tmp-ra.89 r15) (set! rax 36414) (jump tmp-ra.89 rbp rax)))
    (define L.fun/void35214.8
      ((new-frames ()) (locals (tmp-ra.90)))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/void35215.11 rbp r15)))
    (define L.fun/ascii-char35207.9
      ((new-frames ()) (locals (tmp-ra.91)))
      (begin (set! tmp-ra.91 r15) (set! rax 25390) (jump tmp-ra.91 rbp rax)))
    (define L.fun/ascii-char35209.10
      ((new-frames ()) (locals (tmp-ra.92)))
      (begin (set! tmp-ra.92 r15) (set! rax 25390) (jump tmp-ra.92 rbp rax)))
    (define L.fun/void35215.11
      ((new-frames ()) (locals (tmp-ra.93)))
      (begin (set! tmp-ra.93 r15) (set! rax 30) (jump tmp-ra.93 rbp rax)))
    (define L.fun/error35212.12
      ((new-frames ()) (locals (tmp-ra.94)))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error35213.7 rbp r15)))
    (define L.fun/empty35211.13
      ((new-frames ()) (locals (tmp-ra.95)))
      (begin (set! tmp-ra.95 r15) (set! rax 22) (jump tmp-ra.95 rbp rax)))
    (begin
      (set! tmp-ra.96 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/ascii-char35206.4 rbp r15)))
      (set! ascii-char0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/ascii-char35208.5 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/empty35210.6 rbp r15)))
      (set! empty2.4 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/error35212.12 rbp r15)))
      (set! error3.3 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 112)
          (set! rdi 24)
          (set! r15 L.rp.22)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 808)
          (set! rdi 1176)
          (set! r15 L.rp.23)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.24)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1560)
          (set! rdi 1752)
          (set! r15 L.rp.25)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1400)
          (set! rdi 40)
          (set! r15 L.rp.26)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.27)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.28)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 1136)
          (set! rdi 680)
          (set! r15 L.rp.29)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 1040)
          (set! rdi 1016)
          (set! r15 L.rp.30)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.31)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 288)
          (set! rdi 256)
          (set! r15 L.rp.32)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.33
        (begin
          (set! rsi 1544)
          (set! rdi 280)
          (set! r15 L.rp.33)
          (jump L.+.16 rbp r15 rdi rsi)))
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
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.36)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! fixnum4.2 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/void35214.8 rbp r15)))
      (set! void5.1 rax)
      (set! rax ascii-char1.5)
      (jump tmp-ra.96 rbp rax))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () () ()))
     (locals
      (boolean5.1
       tmp.86
       empty4.2
       fixnum3.3
       tmp.79
       tmp.83
       tmp.85
       tmp.84
       tmp.80
       tmp.82
       tmp.81
       tmp.72
       tmp.76
       tmp.78
       tmp.77
       tmp.73
       tmp.75
       tmp.74
       boolean2.4
       tmp.71
       empty1.5
       empty0.6
       tmp-ra.102)))
    (define L.error?.19
      ((new-frames ()) (locals (tmp-ra.87 tmp.103 tmp.48 tmp.56)))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.48 rdi)
        (if (begin
              (begin
                (set! tmp.103 tmp.48)
                (set! tmp.103 (bitwise-and tmp.103 255))
                (set! tmp.56 tmp.103))
              (= tmp.56 62))
          (begin (set! rax 14) (jump tmp-ra.87 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.87 rbp rax)))))
    (define L.+.18
      ((new-frames ())
       (locals
        (tmp.59
         tmp.105
         tmp.22
         tmp.60
         tmp.106
         tmp-ra.88
         tmp.58
         tmp.23
         tmp.104
         tmp.57)))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.23)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.58 tmp.104))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.22)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.60 tmp.105))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.106 tmp.22)
              (set! tmp.106 (+ tmp.106 tmp.23))
              (set! rax tmp.106)
              (jump tmp-ra.88 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.88 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.88 rbp rax)))))
    (define L.-.17
      ((new-frames ())
       (locals
        (tmp.63
         tmp.108
         tmp.24
         tmp.64
         tmp.109
         tmp-ra.89
         tmp.62
         tmp.25
         tmp.107
         tmp.61)))
      (begin
        (set! tmp-ra.89 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.107 tmp.25)
                      (set! tmp.107 (bitwise-and tmp.107 7))
                      (set! tmp.62 tmp.107))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.108 tmp.24)
                        (set! tmp.108 (bitwise-and tmp.108 7))
                        (set! tmp.64 tmp.108))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.109 tmp.24)
              (set! tmp.109 (- tmp.109 tmp.25))
              (set! rax tmp.109)
              (jump tmp-ra.89 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.89 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.89 rbp rax)))))
    (define L.*.16
      ((new-frames ())
       (locals
        (tmp.67
         tmp.111
         tmp.20
         tmp.68
         tmp.113
         tmp.69
         tmp.112
         tmp-ra.90
         tmp.66
         tmp.21
         tmp.110
         tmp.65)))
      (begin
        (set! tmp-ra.90 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.110 tmp.21)
                      (set! tmp.110 (bitwise-and tmp.110 7))
                      (set! tmp.66 tmp.110))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.111 tmp.20)
                        (set! tmp.111 (bitwise-and tmp.111 7))
                        (set! tmp.68 tmp.111))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.112 tmp.21)
              (set! tmp.112 (arithmetic-shift-right tmp.112 3))
              (set! tmp.69 tmp.112)
              (set! tmp.113 tmp.20)
              (set! tmp.113 (* tmp.113 tmp.69))
              (set! rax tmp.113)
              (jump tmp-ra.90 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.90 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.90 rbp rax)))))
    (define L.void?.15
      ((new-frames ()) (locals (tmp-ra.91 tmp.114 tmp.46 tmp.70)))
      (begin
        (set! tmp-ra.91 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.114 tmp.46)
                (set! tmp.114 (bitwise-and tmp.114 255))
                (set! tmp.70 tmp.114))
              (= tmp.70 30))
          (begin (set! rax 14) (jump tmp-ra.91 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.91 rbp rax)))))
    (define L.fun/void43341.4
      ((new-frames ()) (locals (tmp-ra.92)))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/void43342.11 rbp r15)))
    (define L.fun/empty43339.5
      ((new-frames ()) (locals (tmp-ra.93)))
      (begin (set! tmp-ra.93 r15) (set! rax 22) (jump tmp-ra.93 rbp rax)))
    (define L.fun/any43337.6
      ((new-frames ()) (locals (tmp-ra.94)))
      (begin (set! tmp-ra.94 r15) (set! rax 13630) (jump tmp-ra.94 rbp rax)))
    (define L.fun/any43340.7
      ((new-frames ()) (locals (tmp-ra.95)))
      (begin (set! tmp-ra.95 r15) (set! rax 480) (jump tmp-ra.95 rbp rax)))
    (define L.fun/empty43335.8
      ((new-frames ()) (locals (tmp-ra.96)))
      (begin
        (set! tmp-ra.96 r15)
        (set! r15 tmp-ra.96)
        (jump L.fun/empty43336.13 rbp r15)))
    (define L.fun/empty43333.9
      ((new-frames ()) (locals (tmp-ra.97)))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/empty43334.12 rbp r15)))
    (define L.fun/empty43338.10
      ((new-frames ()) (locals (tmp-ra.98)))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/empty43339.5 rbp r15)))
    (define L.fun/void43342.11
      ((new-frames ()) (locals (tmp-ra.99)))
      (begin (set! tmp-ra.99 r15) (set! rax 30) (jump tmp-ra.99 rbp rax)))
    (define L.fun/empty43334.12
      ((new-frames ()) (locals (tmp-ra.100)))
      (begin (set! tmp-ra.100 r15) (set! rax 22) (jump tmp-ra.100 rbp rax)))
    (define L.fun/empty43336.13
      ((new-frames ()) (locals (tmp-ra.101)))
      (begin (set! tmp-ra.101 r15) (set! rax 22) (jump tmp-ra.101 rbp rax)))
    (begin
      (set! tmp-ra.102 r15)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/empty43333.9 rbp r15)))
      (set! empty0.6 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/empty43335.8 rbp r15)))
      (set! empty1.5 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/any43337.6 rbp r15)))
      (set! tmp.71 rax)
      (return-point L.rp.23
        (begin
          (set! rdi tmp.71)
          (set! r15 L.rp.23)
          (jump L.void?.15 rbp r15 rdi)))
      (set! boolean2.4 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 704)
          (set! rdi 832)
          (set! r15 L.rp.24)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1832)
          (set! rdi 1040)
          (set! r15 L.rp.25)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.26
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.26)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 568)
          (set! rdi 952)
          (set! r15 L.rp.27)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1880)
          (set! rdi 1392)
          (set! r15 L.rp.28)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.78)
          (set! rdi tmp.77)
          (set! r15 L.rp.29)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.73)
          (set! r15 L.rp.30)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 456)
          (set! rdi 616)
          (set! r15 L.rp.31)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 432)
          (set! rdi 1928)
          (set! r15 L.rp.32)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.33)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 1376)
          (set! rdi 400)
          (set! r15 L.rp.34)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 1920)
          (set! rdi 576)
          (set! r15 L.rp.35)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.85)
          (set! rdi tmp.84)
          (set! r15 L.rp.36)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.37
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.80)
          (set! r15 L.rp.37)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.38
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.72)
          (set! r15 L.rp.38)
          (jump L.+.18 rbp r15 rdi rsi)))
      (set! fixnum3.3 rax)
      (return-point L.rp.39
        (begin (set! r15 L.rp.39) (jump L.fun/empty43338.10 rbp r15)))
      (set! empty4.2 rax)
      (return-point L.rp.40
        (begin (set! r15 L.rp.40) (jump L.fun/any43340.7 rbp r15)))
      (set! tmp.86 rax)
      (return-point L.rp.41
        (begin
          (set! rdi tmp.86)
          (set! r15 L.rp.41)
          (jump L.error?.19 rbp r15 rdi)))
      (set! boolean5.1 rax)
      (set! r15 tmp-ra.102)
      (jump L.fun/void43341.4 rbp r15))))
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
       ()))
     (locals
      (tmp.90
       tmp.91
       tmp.92
       tmp.83
       tmp.87
       tmp.89
       tmp.88
       tmp.84
       tmp.86
       tmp.85
       ascii-char5.1
       fixnum4.2
       tmp.76
       tmp.80
       tmp.82
       tmp.81
       tmp.77
       tmp.79
       tmp.78
       tmp.69
       tmp.73
       tmp.75
       tmp.74
       tmp.70
       tmp.72
       tmp.71
       void3.3
       ascii-char2.4
       ascii-char1.5
       empty0.6
       tmp-ra.106)))
    (define L.-.17
      ((new-frames ())
       (locals
        (tmp.58
         tmp.108
         tmp.24
         tmp.59
         tmp.109
         tmp-ra.93
         tmp.57
         tmp.25
         tmp.107
         tmp.56)))
      (begin
        (set! tmp-ra.93 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.107 tmp.25)
                      (set! tmp.107 (bitwise-and tmp.107 7))
                      (set! tmp.57 tmp.107))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.108 tmp.24)
                        (set! tmp.108 (bitwise-and tmp.108 7))
                        (set! tmp.59 tmp.108))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.109 tmp.24)
              (set! tmp.109 (- tmp.109 tmp.25))
              (set! rax tmp.109)
              (jump tmp-ra.93 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.93 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.93 rbp rax)))))
    (define L.+.16
      ((new-frames ())
       (locals
        (tmp.62
         tmp.111
         tmp.22
         tmp.63
         tmp.112
         tmp-ra.94
         tmp.61
         tmp.23
         tmp.110
         tmp.60)))
      (begin
        (set! tmp-ra.94 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.110 tmp.23)
                      (set! tmp.110 (bitwise-and tmp.110 7))
                      (set! tmp.61 tmp.110))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.111 tmp.22)
                        (set! tmp.111 (bitwise-and tmp.111 7))
                        (set! tmp.63 tmp.111))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.112 tmp.22)
              (set! tmp.112 (+ tmp.112 tmp.23))
              (set! rax tmp.112)
              (jump tmp-ra.94 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.94 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.94 rbp rax)))))
    (define L.*.15
      ((new-frames ())
       (locals
        (tmp.66
         tmp.114
         tmp.20
         tmp.67
         tmp.116
         tmp.68
         tmp.115
         tmp-ra.95
         tmp.65
         tmp.21
         tmp.113
         tmp.64)))
      (begin
        (set! tmp-ra.95 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.113 tmp.21)
                      (set! tmp.113 (bitwise-and tmp.113 7))
                      (set! tmp.65 tmp.113))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.114 tmp.20)
                        (set! tmp.114 (bitwise-and tmp.114 7))
                        (set! tmp.67 tmp.114))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.115 tmp.21)
              (set! tmp.115 (arithmetic-shift-right tmp.115 3))
              (set! tmp.68 tmp.115)
              (set! tmp.116 tmp.20)
              (set! tmp.116 (* tmp.116 tmp.68))
              (set! rax tmp.116)
              (jump tmp-ra.95 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.95 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.95 rbp rax)))))
    (define L.fun/ascii-char44115.4
      ((new-frames ()) (locals (tmp-ra.96)))
      (begin
        (set! tmp-ra.96 r15)
        (set! r15 tmp-ra.96)
        (jump L.fun/ascii-char44116.11 rbp r15)))
    (define L.fun/ascii-char44119.5
      ((new-frames ()) (locals (tmp-ra.97)))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/ascii-char44120.10 rbp r15)))
    (define L.fun/empty44111.6
      ((new-frames ()) (locals (tmp-ra.98)))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/empty44112.13 rbp r15)))
    (define L.fun/void44117.7
      ((new-frames ()) (locals (tmp-ra.99)))
      (begin
        (set! tmp-ra.99 r15)
        (set! r15 tmp-ra.99)
        (jump L.fun/void44118.9 rbp r15)))
    (define L.fun/ascii-char44114.8
      ((new-frames ()) (locals (tmp-ra.100)))
      (begin (set! tmp-ra.100 r15) (set! rax 25390) (jump tmp-ra.100 rbp rax)))
    (define L.fun/void44118.9
      ((new-frames ()) (locals (tmp-ra.101)))
      (begin (set! tmp-ra.101 r15) (set! rax 30) (jump tmp-ra.101 rbp rax)))
    (define L.fun/ascii-char44120.10
      ((new-frames ()) (locals (tmp-ra.102)))
      (begin (set! tmp-ra.102 r15) (set! rax 25390) (jump tmp-ra.102 rbp rax)))
    (define L.fun/ascii-char44116.11
      ((new-frames ()) (locals (tmp-ra.103)))
      (begin (set! tmp-ra.103 r15) (set! rax 25390) (jump tmp-ra.103 rbp rax)))
    (define L.fun/ascii-char44113.12
      ((new-frames ()) (locals (tmp-ra.104)))
      (begin
        (set! tmp-ra.104 r15)
        (set! r15 tmp-ra.104)
        (jump L.fun/ascii-char44114.8 rbp r15)))
    (define L.fun/empty44112.13
      ((new-frames ()) (locals (tmp-ra.105)))
      (begin (set! tmp-ra.105 r15) (set! rax 22) (jump tmp-ra.105 rbp rax)))
    (begin
      (set! tmp-ra.106 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/empty44111.6 rbp r15)))
      (set! empty0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/ascii-char44113.12 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/ascii-char44115.4 rbp r15)))
      (set! ascii-char2.4 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/void44117.7 rbp r15)))
      (set! void3.3 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1768)
          (set! rdi 488)
          (set! r15 L.rp.22)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 1968)
          (set! rdi 992)
          (set! r15 L.rp.23)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.24)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 120)
          (set! rdi 1304)
          (set! r15 L.rp.25)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 336)
          (set! rdi 296)
          (set! r15 L.rp.26)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.27)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.28)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 136)
          (set! rdi 200)
          (set! r15 L.rp.29)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 1016)
          (set! rdi 544)
          (set! r15 L.rp.30)
          (jump L.*.15 rbp r15 rdi rsi)))
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
          (set! rsi 712)
          (set! rdi 1440)
          (set! r15 L.rp.32)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.33
        (begin
          (set! rsi 1408)
          (set! rdi 1984)
          (set! r15 L.rp.33)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.34)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.35
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.35)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.36)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! fixnum4.2 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/ascii-char44119.5 rbp r15)))
      (set! ascii-char5.1 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 736)
          (set! rdi 416)
          (set! r15 L.rp.38)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.39
        (begin
          (set! rsi 136)
          (set! rdi fixnum4.2)
          (set! r15 L.rp.39)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.40
        (begin
          (set! rsi tmp.86)
          (set! rdi tmp.85)
          (set! r15 L.rp.40)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 192)
          (set! rdi 520)
          (set! r15 L.rp.41)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.42
        (begin
          (set! rsi fixnum4.2)
          (set! rdi fixnum4.2)
          (set! r15 L.rp.42)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.89 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.89)
          (set! rdi tmp.88)
          (set! r15 L.rp.43)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.44
        (begin
          (set! rsi tmp.87)
          (set! rdi tmp.84)
          (set! r15 L.rp.44)
          (jump L.+.16 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.45
        (begin
          (set! rsi fixnum4.2)
          (set! rdi 440)
          (set! r15 L.rp.45)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.46
        (begin
          (set! rsi tmp.92)
          (set! rdi fixnum4.2)
          (set! r15 L.rp.46)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.47
        (begin
          (set! rsi tmp.91)
          (set! rdi fixnum4.2)
          (set! r15 L.rp.47)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (set! rsi tmp.90)
      (set! rdi tmp.83)
      (set! r15 tmp-ra.106)
      (jump L.-.17 rbp r15 rdi rsi))))
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
       ()))
     (locals
      (boolean5.1
       tmp.98
       ascii-char4.2
       empty3.3
       error2.4
       fixnum1.5
       tmp.91
       tmp.95
       tmp.97
       tmp.96
       tmp.92
       tmp.94
       tmp.93
       tmp.84
       tmp.88
       tmp.90
       tmp.89
       tmp.85
       tmp.87
       tmp.86
       fixnum0.6
       tmp.77
       tmp.81
       tmp.83
       tmp.82
       tmp.78
       tmp.80
       tmp.79
       tmp.70
       tmp.74
       tmp.76
       tmp.75
       tmp.71
       tmp.73
       tmp.72
       tmp-ra.110)))
    (define L.fixnum?.15
      ((new-frames ()) (locals (tmp-ra.99 tmp.111 tmp.43 tmp.56)))
      (begin
        (set! tmp-ra.99 r15)
        (set! tmp.43 rdi)
        (if (begin
              (begin
                (set! tmp.111 tmp.43)
                (set! tmp.111 (bitwise-and tmp.111 7))
                (set! tmp.56 tmp.111))
              (= tmp.56 0))
          (begin (set! rax 14) (jump tmp-ra.99 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.99 rbp rax)))))
    (define L.+.14
      ((new-frames ())
       (locals
        (tmp.59
         tmp.113
         tmp.22
         tmp.60
         tmp.114
         tmp-ra.100
         tmp.58
         tmp.23
         tmp.112
         tmp.57)))
      (begin
        (set! tmp-ra.100 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.112 tmp.23)
                      (set! tmp.112 (bitwise-and tmp.112 7))
                      (set! tmp.58 tmp.112))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.113 tmp.22)
                        (set! tmp.113 (bitwise-and tmp.113 7))
                        (set! tmp.60 tmp.113))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.114 tmp.22)
              (set! tmp.114 (+ tmp.114 tmp.23))
              (set! rax tmp.114)
              (jump tmp-ra.100 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.100 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.100 rbp rax)))))
    (define L.*.13
      ((new-frames ())
       (locals
        (tmp.63
         tmp.116
         tmp.20
         tmp.64
         tmp.118
         tmp.65
         tmp.117
         tmp-ra.101
         tmp.62
         tmp.21
         tmp.115
         tmp.61)))
      (begin
        (set! tmp-ra.101 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.115 tmp.21)
                      (set! tmp.115 (bitwise-and tmp.115 7))
                      (set! tmp.62 tmp.115))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.116 tmp.20)
                        (set! tmp.116 (bitwise-and tmp.116 7))
                        (set! tmp.64 tmp.116))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.117 tmp.21)
              (set! tmp.117 (arithmetic-shift-right tmp.117 3))
              (set! tmp.65 tmp.117)
              (set! tmp.118 tmp.20)
              (set! tmp.118 (* tmp.118 tmp.65))
              (set! rax tmp.118)
              (jump tmp-ra.101 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.101 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.101 rbp rax)))))
    (define L.-.12
      ((new-frames ())
       (locals
        (tmp.68
         tmp.120
         tmp.24
         tmp.69
         tmp.121
         tmp-ra.102
         tmp.67
         tmp.25
         tmp.119
         tmp.66)))
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
    (define L.fun/empty58877.4
      ((new-frames ()) (locals (tmp-ra.103)))
      (begin (set! tmp-ra.103 r15) (set! rax 22) (jump tmp-ra.103 rbp rax)))
    (define L.fun/error58875.5
      ((new-frames ()) (locals (tmp-ra.104)))
      (begin (set! tmp-ra.104 r15) (set! rax 38462) (jump tmp-ra.104 rbp rax)))
    (define L.fun/ascii-char58879.6
      ((new-frames ()) (locals (tmp-ra.105)))
      (begin (set! tmp-ra.105 r15) (set! rax 25390) (jump tmp-ra.105 rbp rax)))
    (define L.fun/any58880.7
      ((new-frames ()) (locals (tmp-ra.106)))
      (begin (set! tmp-ra.106 r15) (set! rax 6) (jump tmp-ra.106 rbp rax)))
    (define L.fun/empty58876.8
      ((new-frames ()) (locals (tmp-ra.107)))
      (begin
        (set! tmp-ra.107 r15)
        (set! r15 tmp-ra.107)
        (jump L.fun/empty58877.4 rbp r15)))
    (define L.fun/ascii-char58878.9
      ((new-frames ()) (locals (tmp-ra.108)))
      (begin
        (set! tmp-ra.108 r15)
        (set! r15 tmp-ra.108)
        (jump L.fun/ascii-char58879.6 rbp r15)))
    (define L.fun/error58874.10
      ((new-frames ()) (locals (tmp-ra.109)))
      (begin
        (set! tmp-ra.109 r15)
        (set! r15 tmp-ra.109)
        (jump L.fun/error58875.5 rbp r15)))
    (begin
      (set! tmp-ra.110 r15)
      (return-point L.rp.16
        (begin
          (set! rsi 1192)
          (set! rdi 2024)
          (set! r15 L.rp.16)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1848)
          (set! rdi 472)
          (set! r15 L.rp.17)
          (jump L.*.13 rbp r15 rdi rsi)))
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
          (set! rsi 200)
          (set! rdi 1496)
          (set! r15 L.rp.19)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 400)
          (set! rdi 936)
          (set! r15 L.rp.20)
          (jump L.*.13 rbp r15 rdi rsi)))
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
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 512)
          (set! rdi 1400)
          (set! r15 L.rp.23)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 568)
          (set! rdi 304)
          (set! r15 L.rp.24)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.79)
          (set! r15 L.rp.25)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1904)
          (set! rdi 1000)
          (set! r15 L.rp.26)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 448)
          (set! rdi 528)
          (set! r15 L.rp.27)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.82)
          (set! r15 L.rp.28)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.78)
          (set! r15 L.rp.29)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.70)
          (set! r15 L.rp.30)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 8)
          (set! rdi 888)
          (set! r15 L.rp.31)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 1296)
          (set! rdi 1576)
          (set! r15 L.rp.32)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.87)
          (set! rdi tmp.86)
          (set! r15 L.rp.33)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 2000)
          (set! rdi 1288)
          (set! r15 L.rp.34)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.89 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 1088)
          (set! rdi 488)
          (set! r15 L.rp.35)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.89)
          (set! r15 L.rp.36)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.37
        (begin
          (set! rsi tmp.88)
          (set! rdi tmp.85)
          (set! r15 L.rp.37)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 1032)
          (set! rdi 1392)
          (set! r15 L.rp.38)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.39
        (begin
          (set! rsi 536)
          (set! rdi 1776)
          (set! r15 L.rp.39)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.94 rax)
      (return-point L.rp.40
        (begin
          (set! rsi tmp.94)
          (set! rdi tmp.93)
          (set! r15 L.rp.40)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 2016)
          (set! rdi 1016)
          (set! r15 L.rp.41)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.96 rax)
      (return-point L.rp.42
        (begin
          (set! rsi 1736)
          (set! rdi 1680)
          (set! r15 L.rp.42)
          (jump L.-.12 rbp r15 rdi rsi)))
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
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.45
        (begin
          (set! rsi tmp.91)
          (set! rdi tmp.84)
          (set! r15 L.rp.45)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! fixnum1.5 rax)
      (return-point L.rp.46
        (begin (set! r15 L.rp.46) (jump L.fun/error58874.10 rbp r15)))
      (set! error2.4 rax)
      (return-point L.rp.47
        (begin (set! r15 L.rp.47) (jump L.fun/empty58876.8 rbp r15)))
      (set! empty3.3 rax)
      (return-point L.rp.48
        (begin (set! r15 L.rp.48) (jump L.fun/ascii-char58878.9 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.49
        (begin (set! r15 L.rp.49) (jump L.fun/any58880.7 rbp r15)))
      (set! tmp.98 rax)
      (return-point L.rp.50
        (begin
          (set! rdi tmp.98)
          (set! r15 L.rp.50)
          (jump L.fixnum?.15 rbp r15 rdi)))
      (set! boolean5.1 rax)
      (set! rax ascii-char4.2)
      (jump tmp-ra.110 rbp rax))))
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
       ()
       ()))
     (locals
      (error5.1
       boolean4.2
       tmp.112
       fixnum3.3
       tmp.105
       tmp.109
       tmp.111
       tmp.110
       tmp.106
       tmp.108
       tmp.107
       tmp.98
       tmp.102
       tmp.104
       tmp.103
       tmp.99
       tmp.101
       tmp.100
       fixnum2.4
       tmp.91
       tmp.95
       tmp.97
       tmp.96
       tmp.92
       tmp.94
       tmp.93
       tmp.84
       tmp.88
       tmp.90
       tmp.89
       tmp.85
       tmp.87
       tmp.86
       ascii-char1.5
       fixnum0.6
       tmp.77
       tmp.81
       tmp.83
       tmp.82
       tmp.78
       tmp.80
       tmp.79
       tmp.70
       tmp.74
       tmp.76
       tmp.75
       tmp.71
       tmp.73
       tmp.72
       tmp-ra.122)))
    (define L.void?.13
      ((new-frames ()) (locals (tmp-ra.113 tmp.123 tmp.46 tmp.56)))
      (begin
        (set! tmp-ra.113 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.123 tmp.46)
                (set! tmp.123 (bitwise-and tmp.123 255))
                (set! tmp.56 tmp.123))
              (= tmp.56 30))
          (begin (set! rax 14) (jump tmp-ra.113 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.113 rbp rax)))))
    (define L.-.12
      ((new-frames ())
       (locals
        (tmp.59
         tmp.125
         tmp.24
         tmp.60
         tmp.126
         tmp-ra.114
         tmp.58
         tmp.25
         tmp.124
         tmp.57)))
      (begin
        (set! tmp-ra.114 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.124 tmp.25)
                      (set! tmp.124 (bitwise-and tmp.124 7))
                      (set! tmp.58 tmp.124))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.125 tmp.24)
                        (set! tmp.125 (bitwise-and tmp.125 7))
                        (set! tmp.60 tmp.125))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.126 tmp.24)
              (set! tmp.126 (- tmp.126 tmp.25))
              (set! rax tmp.126)
              (jump tmp-ra.114 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.114 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.114 rbp rax)))))
    (define L.+.11
      ((new-frames ())
       (locals
        (tmp.63
         tmp.128
         tmp.22
         tmp.64
         tmp.129
         tmp-ra.115
         tmp.62
         tmp.23
         tmp.127
         tmp.61)))
      (begin
        (set! tmp-ra.115 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.127 tmp.23)
                      (set! tmp.127 (bitwise-and tmp.127 7))
                      (set! tmp.62 tmp.127))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.128 tmp.22)
                        (set! tmp.128 (bitwise-and tmp.128 7))
                        (set! tmp.64 tmp.128))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.129 tmp.22)
              (set! tmp.129 (+ tmp.129 tmp.23))
              (set! rax tmp.129)
              (jump tmp-ra.115 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.115 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.115 rbp rax)))))
    (define L.*.10
      ((new-frames ())
       (locals
        (tmp.67
         tmp.131
         tmp.20
         tmp.68
         tmp.133
         tmp.69
         tmp.132
         tmp-ra.116
         tmp.66
         tmp.21
         tmp.130
         tmp.65)))
      (begin
        (set! tmp-ra.116 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.130 tmp.21)
                      (set! tmp.130 (bitwise-and tmp.130 7))
                      (set! tmp.66 tmp.130))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.131 tmp.20)
                        (set! tmp.131 (bitwise-and tmp.131 7))
                        (set! tmp.68 tmp.131))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.132 tmp.21)
              (set! tmp.132 (arithmetic-shift-right tmp.132 3))
              (set! tmp.69 tmp.132)
              (set! tmp.133 tmp.20)
              (set! tmp.133 (* tmp.133 tmp.69))
              (set! rax tmp.133)
              (jump tmp-ra.116 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.116 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.116 rbp rax)))))
    (define L.fun/ascii-char63953.4
      ((new-frames ()) (locals (tmp-ra.117)))
      (begin (set! tmp-ra.117 r15) (set! rax 25390) (jump tmp-ra.117 rbp rax)))
    (define L.fun/error63956.5
      ((new-frames ()) (locals (tmp-ra.118)))
      (begin (set! tmp-ra.118 r15) (set! rax 20030) (jump tmp-ra.118 rbp rax)))
    (define L.fun/ascii-char63952.6
      ((new-frames ()) (locals (tmp-ra.119)))
      (begin
        (set! tmp-ra.119 r15)
        (set! r15 tmp-ra.119)
        (jump L.fun/ascii-char63953.4 rbp r15)))
    (define L.fun/error63955.7
      ((new-frames ()) (locals (tmp-ra.120)))
      (begin
        (set! tmp-ra.120 r15)
        (set! r15 tmp-ra.120)
        (jump L.fun/error63956.5 rbp r15)))
    (define L.fun/any63954.8
      ((new-frames ()) (locals (tmp-ra.121)))
      (begin (set! tmp-ra.121 r15) (set! rax 1784) (jump tmp-ra.121 rbp rax)))
    (begin
      (set! tmp-ra.122 r15)
      (return-point L.rp.14
        (begin
          (set! rsi 2024)
          (set! rdi 224)
          (set! r15 L.rp.14)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.15
        (begin
          (set! rsi 1720)
          (set! rdi 1520)
          (set! r15 L.rp.15)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.16
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.16)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 680)
          (set! rdi 1768)
          (set! r15 L.rp.17)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.18
        (begin
          (set! rsi 840)
          (set! rdi 1488)
          (set! r15 L.rp.18)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.19
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.19)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.71)
          (set! r15 L.rp.20)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 1392)
          (set! rdi 1920)
          (set! r15 L.rp.21)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1024)
          (set! rdi 1632)
          (set! r15 L.rp.22)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.79)
          (set! r15 L.rp.23)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 1008)
          (set! rdi 1096)
          (set! r15 L.rp.24)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 416)
          (set! rdi 416)
          (set! r15 L.rp.25)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.26
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.82)
          (set! r15 L.rp.26)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.78)
          (set! r15 L.rp.27)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.70)
          (set! r15 L.rp.28)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.29
        (begin (set! r15 L.rp.29) (jump L.fun/ascii-char63952.6 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 120)
          (set! rdi 424)
          (set! r15 L.rp.30)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 64)
          (set! rdi 792)
          (set! r15 L.rp.31)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.87)
          (set! rdi tmp.86)
          (set! r15 L.rp.32)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.33
        (begin
          (set! rsi 240)
          (set! rdi 936)
          (set! r15 L.rp.33)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.89 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 376)
          (set! rdi 1192)
          (set! r15 L.rp.34)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (return-point L.rp.35
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.89)
          (set! r15 L.rp.35)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.88)
          (set! rdi tmp.85)
          (set! r15 L.rp.36)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.37
        (begin
          (set! rsi 1872)
          (set! rdi 1392)
          (set! r15 L.rp.37)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 304)
          (set! rdi 1024)
          (set! r15 L.rp.38)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.94 rax)
      (return-point L.rp.39
        (begin
          (set! rsi tmp.94)
          (set! rdi tmp.93)
          (set! r15 L.rp.39)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.40
        (begin
          (set! rsi 688)
          (set! rdi 1776)
          (set! r15 L.rp.40)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.96 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 1240)
          (set! rdi 552)
          (set! r15 L.rp.41)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.97 rax)
      (return-point L.rp.42
        (begin
          (set! rsi tmp.97)
          (set! rdi tmp.96)
          (set! r15 L.rp.42)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.95 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.95)
          (set! rdi tmp.92)
          (set! r15 L.rp.43)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.44
        (begin
          (set! rsi tmp.91)
          (set! rdi tmp.84)
          (set! r15 L.rp.44)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! fixnum2.4 rax)
      (return-point L.rp.45
        (begin
          (set! rsi 1848)
          (set! rdi 872)
          (set! r15 L.rp.45)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.100 rax)
      (return-point L.rp.46
        (begin
          (set! rsi 1936)
          (set! rdi 128)
          (set! r15 L.rp.46)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.101 rax)
      (return-point L.rp.47
        (begin
          (set! rsi tmp.101)
          (set! rdi tmp.100)
          (set! r15 L.rp.47)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.99 rax)
      (return-point L.rp.48
        (begin
          (set! rsi 256)
          (set! rdi 1336)
          (set! r15 L.rp.48)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! tmp.103 rax)
      (return-point L.rp.49
        (begin
          (set! rsi 1576)
          (set! rdi 2000)
          (set! r15 L.rp.49)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.104 rax)
      (return-point L.rp.50
        (begin
          (set! rsi tmp.104)
          (set! rdi tmp.103)
          (set! r15 L.rp.50)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.102 rax)
      (return-point L.rp.51
        (begin
          (set! rsi tmp.102)
          (set! rdi tmp.99)
          (set! r15 L.rp.51)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.98 rax)
      (return-point L.rp.52
        (begin
          (set! rsi 1152)
          (set! rdi 1528)
          (set! r15 L.rp.52)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.107 rax)
      (return-point L.rp.53
        (begin
          (set! rsi 816)
          (set! rdi 1792)
          (set! r15 L.rp.53)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.108 rax)
      (return-point L.rp.54
        (begin
          (set! rsi tmp.108)
          (set! rdi tmp.107)
          (set! r15 L.rp.54)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.106 rax)
      (return-point L.rp.55
        (begin
          (set! rsi 2032)
          (set! rdi 512)
          (set! r15 L.rp.55)
          (jump L.+.11 rbp r15 rdi rsi)))
      (set! tmp.110 rax)
      (return-point L.rp.56
        (begin
          (set! rsi 360)
          (set! rdi 1032)
          (set! r15 L.rp.56)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.111 rax)
      (return-point L.rp.57
        (begin
          (set! rsi tmp.111)
          (set! rdi tmp.110)
          (set! r15 L.rp.57)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.109 rax)
      (return-point L.rp.58
        (begin
          (set! rsi tmp.109)
          (set! rdi tmp.106)
          (set! r15 L.rp.58)
          (jump L.*.10 rbp r15 rdi rsi)))
      (set! tmp.105 rax)
      (return-point L.rp.59
        (begin
          (set! rsi tmp.105)
          (set! rdi tmp.98)
          (set! r15 L.rp.59)
          (jump L.-.12 rbp r15 rdi rsi)))
      (set! fixnum3.3 rax)
      (return-point L.rp.60
        (begin (set! r15 L.rp.60) (jump L.fun/any63954.8 rbp r15)))
      (set! tmp.112 rax)
      (return-point L.rp.61
        (begin
          (set! rdi tmp.112)
          (set! r15 L.rp.61)
          (jump L.void?.13 rbp r15 rdi)))
      (set! boolean4.2 rax)
      (return-point L.rp.62
        (begin (set! r15 L.rp.62) (jump L.fun/error63955.7 rbp r15)))
      (set! error5.1 rax)
      (set! rax ascii-char1.5)
      (jump tmp-ra.122 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () () () () ()))
     (locals
      (void5.1
       ascii-char4.2
       ascii-char3.3
       ascii-char2.4
       empty1.5
       fixnum0.6
       tmp.76
       tmp.80
       tmp.82
       tmp.81
       tmp.77
       tmp.79
       tmp.78
       tmp.69
       tmp.73
       tmp.75
       tmp.74
       tmp.70
       tmp.72
       tmp.71
       tmp-ra.96)))
    (define L.-.17
      ((new-frames ())
       (locals
        (tmp.58
         tmp.98
         tmp.24
         tmp.59
         tmp.99
         tmp-ra.83
         tmp.57
         tmp.25
         tmp.97
         tmp.56)))
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
      ((new-frames ())
       (locals
        (tmp.62
         tmp.101
         tmp.20
         tmp.63
         tmp.103
         tmp.64
         tmp.102
         tmp-ra.84
         tmp.61
         tmp.21
         tmp.100
         tmp.60)))
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
      ((new-frames ())
       (locals
        (tmp.67
         tmp.105
         tmp.22
         tmp.68
         tmp.106
         tmp-ra.85
         tmp.66
         tmp.23
         tmp.104
         tmp.65)))
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
    (define L.fun/ascii-char71274.4
      ((new-frames ()) (locals (tmp-ra.86)))
      (begin (set! tmp-ra.86 r15) (set! rax 25390) (jump tmp-ra.86 rbp rax)))
    (define L.fun/void71278.5
      ((new-frames ()) (locals (tmp-ra.87)))
      (begin (set! tmp-ra.87 r15) (set! rax 30) (jump tmp-ra.87 rbp rax)))
    (define L.fun/ascii-char71271.6
      ((new-frames ()) (locals (tmp-ra.88)))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/ascii-char71272.9 rbp r15)))
    (define L.fun/ascii-char71273.7
      ((new-frames ()) (locals (tmp-ra.89)))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/ascii-char71274.4 rbp r15)))
    (define L.fun/empty71270.8
      ((new-frames ()) (locals (tmp-ra.90)))
      (begin (set! tmp-ra.90 r15) (set! rax 22) (jump tmp-ra.90 rbp rax)))
    (define L.fun/ascii-char71272.9
      ((new-frames ()) (locals (tmp-ra.91)))
      (begin (set! tmp-ra.91 r15) (set! rax 25390) (jump tmp-ra.91 rbp rax)))
    (define L.fun/ascii-char71275.10
      ((new-frames ()) (locals (tmp-ra.92)))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/ascii-char71276.13 rbp r15)))
    (define L.fun/void71277.11
      ((new-frames ()) (locals (tmp-ra.93)))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void71278.5 rbp r15)))
    (define L.fun/empty71269.12
      ((new-frames ()) (locals (tmp-ra.94)))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/empty71270.8 rbp r15)))
    (define L.fun/ascii-char71276.13
      ((new-frames ()) (locals (tmp-ra.95)))
      (begin (set! tmp-ra.95 r15) (set! rax 25390) (jump tmp-ra.95 rbp rax)))
    (begin
      (set! tmp-ra.96 r15)
      (return-point L.rp.18
        (begin
          (set! rsi 336)
          (set! rdi 104)
          (set! r15 L.rp.18)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 1800)
          (set! rdi 888)
          (set! r15 L.rp.19)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.20)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 1344)
          (set! rdi 872)
          (set! r15 L.rp.21)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 680)
          (set! rdi 1360)
          (set! r15 L.rp.22)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.23)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.24)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1248)
          (set! rdi 72)
          (set! r15 L.rp.25)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1360)
          (set! rdi 896)
          (set! r15 L.rp.26)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.27)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 152)
          (set! rdi 680)
          (set! r15 L.rp.28)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 1392)
          (set! rdi 1104)
          (set! r15 L.rp.29)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.30)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.31)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.32)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.33
        (begin (set! r15 L.rp.33) (jump L.fun/empty71269.12 rbp r15)))
      (set! empty1.5 rax)
      (return-point L.rp.34
        (begin (set! r15 L.rp.34) (jump L.fun/ascii-char71271.6 rbp r15)))
      (set! ascii-char2.4 rax)
      (return-point L.rp.35
        (begin (set! r15 L.rp.35) (jump L.fun/ascii-char71273.7 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/ascii-char71275.10 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/void71277.11 rbp r15)))
      (set! void5.1 rax)
      (set! rax empty1.5)
      (jump tmp-ra.96 rbp rax))))
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
      (empty5.1
       fixnum4.2
       tmp.90
       tmp.94
       tmp.96
       tmp.95
       tmp.91
       tmp.93
       tmp.92
       tmp.83
       tmp.87
       tmp.89
       tmp.88
       tmp.84
       tmp.86
       tmp.85
       error3.3
       ascii-char2.4
       empty1.5
       fixnum0.6
       tmp.76
       tmp.80
       tmp.82
       tmp.81
       tmp.77
       tmp.79
       tmp.78
       tmp.69
       tmp.73
       tmp.75
       tmp.74
       tmp.70
       tmp.72
       tmp.71
       tmp-ra.108)))
    (define L.+.15
      ((new-frames ())
       (locals
        (tmp.58
         tmp.110
         tmp.22
         tmp.59
         tmp.111
         tmp-ra.97
         tmp.57
         tmp.23
         tmp.109
         tmp.56)))
      (begin
        (set! tmp-ra.97 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.109 tmp.23)
                      (set! tmp.109 (bitwise-and tmp.109 7))
                      (set! tmp.57 tmp.109))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.110 tmp.22)
                        (set! tmp.110 (bitwise-and tmp.110 7))
                        (set! tmp.59 tmp.110))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.111 tmp.22)
              (set! tmp.111 (+ tmp.111 tmp.23))
              (set! rax tmp.111)
              (jump tmp-ra.97 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.97 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.97 rbp rax)))))
    (define L.-.14
      ((new-frames ())
       (locals
        (tmp.62
         tmp.113
         tmp.24
         tmp.63
         tmp.114
         tmp-ra.98
         tmp.61
         tmp.25
         tmp.112
         tmp.60)))
      (begin
        (set! tmp-ra.98 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.112 tmp.25)
                      (set! tmp.112 (bitwise-and tmp.112 7))
                      (set! tmp.61 tmp.112))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.113 tmp.24)
                        (set! tmp.113 (bitwise-and tmp.113 7))
                        (set! tmp.63 tmp.113))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.114 tmp.24)
              (set! tmp.114 (- tmp.114 tmp.25))
              (set! rax tmp.114)
              (jump tmp-ra.98 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.98 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.98 rbp rax)))))
    (define L.*.13
      ((new-frames ())
       (locals
        (tmp.66
         tmp.116
         tmp.20
         tmp.67
         tmp.118
         tmp.68
         tmp.117
         tmp-ra.99
         tmp.65
         tmp.21
         tmp.115
         tmp.64)))
      (begin
        (set! tmp-ra.99 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.115 tmp.21)
                      (set! tmp.115 (bitwise-and tmp.115 7))
                      (set! tmp.65 tmp.115))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.116 tmp.20)
                        (set! tmp.116 (bitwise-and tmp.116 7))
                        (set! tmp.67 tmp.116))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.117 tmp.21)
              (set! tmp.117 (arithmetic-shift-right tmp.117 3))
              (set! tmp.68 tmp.117)
              (set! tmp.118 tmp.20)
              (set! tmp.118 (* tmp.118 tmp.68))
              (set! rax tmp.118)
              (jump tmp-ra.99 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.99 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.99 rbp rax)))))
    (define L.fun/empty73456.4
      ((new-frames ()) (locals (tmp-ra.100)))
      (begin
        (set! tmp-ra.100 r15)
        (set! r15 tmp-ra.100)
        (jump L.fun/empty73457.8 rbp r15)))
    (define L.fun/ascii-char73458.5
      ((new-frames ()) (locals (tmp-ra.101)))
      (begin
        (set! tmp-ra.101 r15)
        (set! r15 tmp-ra.101)
        (jump L.fun/ascii-char73459.10 rbp r15)))
    (define L.fun/empty73463.6
      ((new-frames ()) (locals (tmp-ra.102)))
      (begin (set! tmp-ra.102 r15) (set! rax 22) (jump tmp-ra.102 rbp rax)))
    (define L.fun/error73460.7
      ((new-frames ()) (locals (tmp-ra.103)))
      (begin
        (set! tmp-ra.103 r15)
        (set! r15 tmp-ra.103)
        (jump L.fun/error73461.9 rbp r15)))
    (define L.fun/empty73457.8
      ((new-frames ()) (locals (tmp-ra.104)))
      (begin (set! tmp-ra.104 r15) (set! rax 22) (jump tmp-ra.104 rbp rax)))
    (define L.fun/error73461.9
      ((new-frames ()) (locals (tmp-ra.105)))
      (begin (set! tmp-ra.105 r15) (set! rax 20542) (jump tmp-ra.105 rbp rax)))
    (define L.fun/ascii-char73459.10
      ((new-frames ()) (locals (tmp-ra.106)))
      (begin (set! tmp-ra.106 r15) (set! rax 25390) (jump tmp-ra.106 rbp rax)))
    (define L.fun/empty73462.11
      ((new-frames ()) (locals (tmp-ra.107)))
      (begin
        (set! tmp-ra.107 r15)
        (set! r15 tmp-ra.107)
        (jump L.fun/empty73463.6 rbp r15)))
    (begin
      (set! tmp-ra.108 r15)
      (return-point L.rp.16
        (begin
          (set! rsi 2024)
          (set! rdi 1888)
          (set! r15 L.rp.16)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1464)
          (set! rdi 696)
          (set! r15 L.rp.17)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.18)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 416)
          (set! rdi 1344)
          (set! r15 L.rp.19)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 88)
          (set! rdi 464)
          (set! r15 L.rp.20)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.21)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.22)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 1760)
          (set! rdi 40)
          (set! r15 L.rp.23)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 1688)
          (set! rdi 104)
          (set! r15 L.rp.24)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.25)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 952)
          (set! rdi 1952)
          (set! r15 L.rp.26)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 584)
          (set! rdi 1264)
          (set! r15 L.rp.27)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.28)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.29)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.30)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.31
        (begin (set! r15 L.rp.31) (jump L.fun/empty73456.4 rbp r15)))
      (set! empty1.5 rax)
      (return-point L.rp.32
        (begin (set! r15 L.rp.32) (jump L.fun/ascii-char73458.5 rbp r15)))
      (set! ascii-char2.4 rax)
      (return-point L.rp.33
        (begin (set! r15 L.rp.33) (jump L.fun/error73460.7 rbp r15)))
      (set! error3.3 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 1504)
          (set! rdi 2008)
          (set! r15 L.rp.34)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 1856)
          (set! rdi 1768)
          (set! r15 L.rp.35)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.86)
          (set! rdi tmp.85)
          (set! r15 L.rp.36)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.37
        (begin
          (set! rsi 1728)
          (set! rdi 880)
          (set! r15 L.rp.37)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 152)
          (set! rdi 1992)
          (set! r15 L.rp.38)
          (jump L.*.13 rbp r15 rdi rsi)))
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
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 672)
          (set! rdi 840)
          (set! r15 L.rp.41)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.42
        (begin
          (set! rsi 368)
          (set! rdi 1704)
          (set! r15 L.rp.42)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.93)
          (set! rdi tmp.92)
          (set! r15 L.rp.43)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.44
        (begin
          (set! rsi 1992)
          (set! rdi 624)
          (set! r15 L.rp.44)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.95 rax)
      (return-point L.rp.45
        (begin
          (set! rsi 920)
          (set! rdi 1976)
          (set! r15 L.rp.45)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.96 rax)
      (return-point L.rp.46
        (begin
          (set! rsi tmp.96)
          (set! rdi tmp.95)
          (set! r15 L.rp.46)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.94 rax)
      (return-point L.rp.47
        (begin
          (set! rsi tmp.94)
          (set! rdi tmp.91)
          (set! r15 L.rp.47)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (return-point L.rp.48
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.83)
          (set! r15 L.rp.48)
          (jump L.-.14 rbp r15 rdi rsi)))
      (set! fixnum4.2 rax)
      (return-point L.rp.49
        (begin (set! r15 L.rp.49) (jump L.fun/empty73462.11 rbp r15)))
      (set! empty5.1 rax)
      (set! rax error3.3)
      (jump tmp-ra.108 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () () () () ()))
     (locals
      (error5.1
       error4.2
       void3.3
       empty2.4
       fixnum1.5
       tmp.76
       tmp.80
       tmp.82
       tmp.81
       tmp.77
       tmp.79
       tmp.78
       tmp.69
       tmp.73
       tmp.75
       tmp.74
       tmp.70
       tmp.72
       tmp.71
       void0.6
       tmp-ra.96)))
    (define L.+.17
      ((new-frames ())
       (locals
        (tmp.58
         tmp.98
         tmp.22
         tmp.59
         tmp.99
         tmp-ra.83
         tmp.57
         tmp.23
         tmp.97
         tmp.56)))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.23)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.57 tmp.97))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.22)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.59 tmp.98))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.99 tmp.22)
              (set! tmp.99 (+ tmp.99 tmp.23))
              (set! rax tmp.99)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.83 rbp rax)))))
    (define L.-.16
      ((new-frames ())
       (locals
        (tmp.62
         tmp.101
         tmp.24
         tmp.63
         tmp.102
         tmp-ra.84
         tmp.61
         tmp.25
         tmp.100
         tmp.60)))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.100 tmp.25)
                      (set! tmp.100 (bitwise-and tmp.100 7))
                      (set! tmp.61 tmp.100))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.101 tmp.24)
                        (set! tmp.101 (bitwise-and tmp.101 7))
                        (set! tmp.63 tmp.101))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.102 tmp.24)
              (set! tmp.102 (- tmp.102 tmp.25))
              (set! rax tmp.102)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.84 rbp rax)))))
    (define L.*.15
      ((new-frames ())
       (locals
        (tmp.66
         tmp.104
         tmp.20
         tmp.67
         tmp.106
         tmp.68
         tmp.105
         tmp-ra.85
         tmp.65
         tmp.21
         tmp.103
         tmp.64)))
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
    (define L.fun/void77842.4
      ((new-frames ()) (locals (tmp-ra.86)))
      (begin
        (set! tmp-ra.86 r15)
        (set! r15 tmp-ra.86)
        (jump L.fun/void77843.9 rbp r15)))
    (define L.fun/void77838.5
      ((new-frames ()) (locals (tmp-ra.87)))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/void77839.10 rbp r15)))
    (define L.fun/error77846.6
      ((new-frames ()) (locals (tmp-ra.88)))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/error77847.13 rbp r15)))
    (define L.fun/error77845.7
      ((new-frames ()) (locals (tmp-ra.89)))
      (begin (set! tmp-ra.89 r15) (set! rax 62014) (jump tmp-ra.89 rbp rax)))
    (define L.fun/empty77840.8
      ((new-frames ()) (locals (tmp-ra.90)))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/empty77841.11 rbp r15)))
    (define L.fun/void77843.9
      ((new-frames ()) (locals (tmp-ra.91)))
      (begin (set! tmp-ra.91 r15) (set! rax 30) (jump tmp-ra.91 rbp rax)))
    (define L.fun/void77839.10
      ((new-frames ()) (locals (tmp-ra.92)))
      (begin (set! tmp-ra.92 r15) (set! rax 30) (jump tmp-ra.92 rbp rax)))
    (define L.fun/empty77841.11
      ((new-frames ()) (locals (tmp-ra.93)))
      (begin (set! tmp-ra.93 r15) (set! rax 22) (jump tmp-ra.93 rbp rax)))
    (define L.fun/error77844.12
      ((new-frames ()) (locals (tmp-ra.94)))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error77845.7 rbp r15)))
    (define L.fun/error77847.13
      ((new-frames ()) (locals (tmp-ra.95)))
      (begin (set! tmp-ra.95 r15) (set! rax 48702) (jump tmp-ra.95 rbp rax)))
    (begin
      (set! tmp-ra.96 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/void77838.5 rbp r15)))
      (set! void0.6 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 800)
          (set! rdi 1560)
          (set! r15 L.rp.19)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 1936)
          (set! rdi 1880)
          (set! r15 L.rp.20)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.21)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 752)
          (set! rdi 216)
          (set! r15 L.rp.22)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 800)
          (set! rdi 1208)
          (set! r15 L.rp.23)
          (jump L.-.16 rbp r15 rdi rsi)))
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
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 752)
          (set! rdi 8)
          (set! r15 L.rp.26)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 1208)
          (set! rdi 1448)
          (set! r15 L.rp.27)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.28)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 1784)
          (set! rdi 1232)
          (set! r15 L.rp.29)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 1256)
          (set! rdi 1288)
          (set! r15 L.rp.30)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.31)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.32)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.33)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! fixnum1.5 rax)
      (return-point L.rp.34
        (begin (set! r15 L.rp.34) (jump L.fun/empty77840.8 rbp r15)))
      (set! empty2.4 rax)
      (return-point L.rp.35
        (begin (set! r15 L.rp.35) (jump L.fun/void77842.4 rbp r15)))
      (set! void3.3 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/error77844.12 rbp r15)))
      (set! error4.2 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/error77846.6 rbp r15)))
      (set! error5.1 rax)
      (set! rax empty2.4)
      (jump tmp-ra.96 rbp rax))))
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
       ()))
     (locals
      (error5.1
       fixnum4.2
       tmp.94
       tmp.98
       tmp.100
       tmp.99
       tmp.95
       tmp.97
       tmp.96
       tmp.87
       tmp.91
       tmp.93
       tmp.92
       tmp.88
       tmp.90
       tmp.89
       boolean3.3
       tmp.86
       boolean2.4
       tmp.85
       fixnum1.5
       tmp.78
       tmp.82
       tmp.84
       tmp.83
       tmp.79
       tmp.81
       tmp.80
       tmp.71
       tmp.75
       tmp.77
       tmp.76
       tmp.72
       tmp.74
       tmp.73
       error0.6
       tmp-ra.114)))
    (define L.ascii-char?.17
      ((new-frames ()) (locals (tmp-ra.101 tmp.115 tmp.47 tmp.56)))
      (begin
        (set! tmp-ra.101 r15)
        (set! tmp.47 rdi)
        (if (begin
              (begin
                (set! tmp.115 tmp.47)
                (set! tmp.115 (bitwise-and tmp.115 255))
                (set! tmp.56 tmp.115))
              (= tmp.56 46))
          (begin (set! rax 14) (jump tmp-ra.101 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.101 rbp rax)))))
    (define L.boolean?.16
      ((new-frames ()) (locals (tmp-ra.102 tmp.116 tmp.44 tmp.57)))
      (begin
        (set! tmp-ra.102 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.116 tmp.44)
                (set! tmp.116 (bitwise-and tmp.116 247))
                (set! tmp.57 tmp.116))
              (= tmp.57 6))
          (begin (set! rax 14) (jump tmp-ra.102 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.102 rbp rax)))))
    (define L.+.15
      ((new-frames ())
       (locals
        (tmp.60
         tmp.118
         tmp.22
         tmp.61
         tmp.119
         tmp-ra.103
         tmp.59
         tmp.23
         tmp.117
         tmp.58)))
      (begin
        (set! tmp-ra.103 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.117 tmp.23)
                      (set! tmp.117 (bitwise-and tmp.117 7))
                      (set! tmp.59 tmp.117))
                    (= tmp.59 0))
                (set! tmp.58 14)
                (set! tmp.58 6))
              (!= tmp.58 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.118 tmp.22)
                        (set! tmp.118 (bitwise-and tmp.118 7))
                        (set! tmp.61 tmp.118))
                      (= tmp.61 0))
                  (set! tmp.60 14)
                  (set! tmp.60 6))
                (!= tmp.60 6))
            (begin
              (set! tmp.119 tmp.22)
              (set! tmp.119 (+ tmp.119 tmp.23))
              (set! rax tmp.119)
              (jump tmp-ra.103 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.103 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.103 rbp rax)))))
    (define L.*.14
      ((new-frames ())
       (locals
        (tmp.64
         tmp.121
         tmp.20
         tmp.65
         tmp.123
         tmp.66
         tmp.122
         tmp-ra.104
         tmp.63
         tmp.21
         tmp.120
         tmp.62)))
      (begin
        (set! tmp-ra.104 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.120 tmp.21)
                      (set! tmp.120 (bitwise-and tmp.120 7))
                      (set! tmp.63 tmp.120))
                    (= tmp.63 0))
                (set! tmp.62 14)
                (set! tmp.62 6))
              (!= tmp.62 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.121 tmp.20)
                        (set! tmp.121 (bitwise-and tmp.121 7))
                        (set! tmp.65 tmp.121))
                      (= tmp.65 0))
                  (set! tmp.64 14)
                  (set! tmp.64 6))
                (!= tmp.64 6))
            (begin
              (set! tmp.122 tmp.21)
              (set! tmp.122 (arithmetic-shift-right tmp.122 3))
              (set! tmp.66 tmp.122)
              (set! tmp.123 tmp.20)
              (set! tmp.123 (* tmp.123 tmp.66))
              (set! rax tmp.123)
              (jump tmp-ra.104 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.104 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.104 rbp rax)))))
    (define L.-.13
      ((new-frames ())
       (locals
        (tmp.69
         tmp.125
         tmp.24
         tmp.70
         tmp.126
         tmp-ra.105
         tmp.68
         tmp.25
         tmp.124
         tmp.67)))
      (begin
        (set! tmp-ra.105 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.124 tmp.25)
                      (set! tmp.124 (bitwise-and tmp.124 7))
                      (set! tmp.68 tmp.124))
                    (= tmp.68 0))
                (set! tmp.67 14)
                (set! tmp.67 6))
              (!= tmp.67 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.125 tmp.24)
                        (set! tmp.125 (bitwise-and tmp.125 7))
                        (set! tmp.70 tmp.125))
                      (= tmp.70 0))
                  (set! tmp.69 14)
                  (set! tmp.69 6))
                (!= tmp.69 6))
            (begin
              (set! tmp.126 tmp.24)
              (set! tmp.126 (- tmp.126 tmp.25))
              (set! rax tmp.126)
              (jump tmp-ra.105 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.105 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.105 rbp rax)))))
    (define L.fun/any78095.4
      ((new-frames ()) (locals (tmp-ra.106)))
      (begin (set! tmp-ra.106 r15) (set! rax 6) (jump tmp-ra.106 rbp rax)))
    (define L.fun/void78099.5
      ((new-frames ()) (locals (tmp-ra.107)))
      (begin (set! tmp-ra.107 r15) (set! rax 30) (jump tmp-ra.107 rbp rax)))
    (define L.fun/error78092.6
      ((new-frames ()) (locals (tmp-ra.108)))
      (begin
        (set! tmp-ra.108 r15)
        (set! r15 tmp-ra.108)
        (jump L.fun/error78093.9 rbp r15)))
    (define L.fun/any78094.7
      ((new-frames ()) (locals (tmp-ra.109)))
      (begin (set! tmp-ra.109 r15) (set! rax 6) (jump tmp-ra.109 rbp rax)))
    (define L.fun/error78097.8
      ((new-frames ()) (locals (tmp-ra.110)))
      (begin (set! tmp-ra.110 r15) (set! rax 36670) (jump tmp-ra.110 rbp rax)))
    (define L.fun/error78093.9
      ((new-frames ()) (locals (tmp-ra.111)))
      (begin (set! tmp-ra.111 r15) (set! rax 24126) (jump tmp-ra.111 rbp rax)))
    (define L.fun/error78096.10
      ((new-frames ()) (locals (tmp-ra.112)))
      (begin
        (set! tmp-ra.112 r15)
        (set! r15 tmp-ra.112)
        (jump L.fun/error78097.8 rbp r15)))
    (define L.fun/void78098.11
      ((new-frames ()) (locals (tmp-ra.113)))
      (begin
        (set! tmp-ra.113 r15)
        (set! r15 tmp-ra.113)
        (jump L.fun/void78099.5 rbp r15)))
    (begin
      (set! tmp-ra.114 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/error78092.6 rbp r15)))
      (set! error0.6 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 480)
          (set! rdi 1192)
          (set! r15 L.rp.19)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 56)
          (set! rdi 1584)
          (set! r15 L.rp.20)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.73)
          (set! r15 L.rp.21)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 128)
          (set! rdi 1488)
          (set! r15 L.rp.22)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 1720)
          (set! rdi 488)
          (set! r15 L.rp.23)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.76)
          (set! r15 L.rp.24)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.72)
          (set! r15 L.rp.25)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1640)
          (set! rdi 1312)
          (set! r15 L.rp.26)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 864)
          (set! rdi 1184)
          (set! r15 L.rp.27)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.80)
          (set! r15 L.rp.28)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 296)
          (set! rdi 208)
          (set! r15 L.rp.29)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 32)
          (set! rdi 800)
          (set! r15 L.rp.30)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.84)
          (set! rdi tmp.83)
          (set! r15 L.rp.31)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.79)
          (set! r15 L.rp.32)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.78)
          (set! rdi tmp.71)
          (set! r15 L.rp.33)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! fixnum1.5 rax)
      (return-point L.rp.34
        (begin (set! r15 L.rp.34) (jump L.fun/any78094.7 rbp r15)))
      (set! tmp.85 rax)
      (return-point L.rp.35
        (begin
          (set! rdi tmp.85)
          (set! r15 L.rp.35)
          (jump L.boolean?.16 rbp r15 rdi)))
      (set! boolean2.4 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/any78095.4 rbp r15)))
      (set! tmp.86 rax)
      (return-point L.rp.37
        (begin
          (set! rdi tmp.86)
          (set! r15 L.rp.37)
          (jump L.ascii-char?.17 rbp r15 rdi)))
      (set! boolean3.3 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 1384)
          (set! rdi 136)
          (set! r15 L.rp.38)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.89 rax)
      (return-point L.rp.39
        (begin
          (set! rsi 592)
          (set! rdi 1784)
          (set! r15 L.rp.39)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (return-point L.rp.40
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.89)
          (set! r15 L.rp.40)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 584)
          (set! rdi 1536)
          (set! r15 L.rp.41)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.42
        (begin
          (set! rsi 1504)
          (set! rdi 1528)
          (set! r15 L.rp.42)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.93)
          (set! rdi tmp.92)
          (set! r15 L.rp.43)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.44
        (begin
          (set! rsi tmp.91)
          (set! rdi tmp.88)
          (set! r15 L.rp.44)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.45
        (begin
          (set! rsi 1824)
          (set! rdi 1536)
          (set! r15 L.rp.45)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.96 rax)
      (return-point L.rp.46
        (begin
          (set! rsi 840)
          (set! rdi 1760)
          (set! r15 L.rp.46)
          (jump L.*.14 rbp r15 rdi rsi)))
      (set! tmp.97 rax)
      (return-point L.rp.47
        (begin
          (set! rsi tmp.97)
          (set! rdi tmp.96)
          (set! r15 L.rp.47)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.95 rax)
      (return-point L.rp.48
        (begin
          (set! rsi 1032)
          (set! rdi 1864)
          (set! r15 L.rp.48)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.99 rax)
      (return-point L.rp.49
        (begin
          (set! rsi 688)
          (set! rdi 88)
          (set! r15 L.rp.49)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.100 rax)
      (return-point L.rp.50
        (begin
          (set! rsi tmp.100)
          (set! rdi tmp.99)
          (set! r15 L.rp.50)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! tmp.98 rax)
      (return-point L.rp.51
        (begin
          (set! rsi tmp.98)
          (set! rdi tmp.95)
          (set! r15 L.rp.51)
          (jump L.+.15 rbp r15 rdi rsi)))
      (set! tmp.94 rax)
      (return-point L.rp.52
        (begin
          (set! rsi tmp.94)
          (set! rdi tmp.87)
          (set! r15 L.rp.52)
          (jump L.-.13 rbp r15 rdi rsi)))
      (set! fixnum4.2 rax)
      (return-point L.rp.53
        (begin (set! r15 L.rp.53) (jump L.fun/error78096.10 rbp r15)))
      (set! error5.1 rax)
      (set! r15 tmp-ra.114)
      (jump L.fun/void78098.11 rbp r15))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () ()))
     (locals
      (void5.1
       empty4.2
       ascii-char3.3
       void2.4
       boolean1.5
       tmp.84
       fixnum0.6
       tmp.77
       tmp.81
       tmp.83
       tmp.82
       tmp.78
       tmp.80
       tmp.79
       tmp.70
       tmp.74
       tmp.76
       tmp.75
       tmp.71
       tmp.73
       tmp.72
       tmp-ra.98)))
    (define L.boolean?.17
      ((new-frames ()) (locals (tmp-ra.85 tmp.99 tmp.44 tmp.56)))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.99 tmp.44)
                (set! tmp.99 (bitwise-and tmp.99 247))
                (set! tmp.56 tmp.99))
              (= tmp.56 6))
          (begin (set! rax 14) (jump tmp-ra.85 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.85 rbp rax)))))
    (define L.-.16
      ((new-frames ())
       (locals
        (tmp.59
         tmp.101
         tmp.24
         tmp.60
         tmp.102
         tmp-ra.86
         tmp.58
         tmp.25
         tmp.100
         tmp.57)))
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
    (define L.*.15
      ((new-frames ())
       (locals
        (tmp.63
         tmp.104
         tmp.20
         tmp.64
         tmp.106
         tmp.65
         tmp.105
         tmp-ra.87
         tmp.62
         tmp.21
         tmp.103
         tmp.61)))
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
    (define L.+.14
      ((new-frames ())
       (locals
        (tmp.68
         tmp.108
         tmp.22
         tmp.69
         tmp.109
         tmp-ra.88
         tmp.67
         tmp.23
         tmp.107
         tmp.66)))
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
    (define L.fun/void101999.4
      ((new-frames ()) (locals (tmp-ra.89)))
      (begin (set! tmp-ra.89 r15) (set! rax 30) (jump tmp-ra.89 rbp rax)))
    (define L.fun/empty101997.5
      ((new-frames ()) (locals (tmp-ra.90)))
      (begin (set! tmp-ra.90 r15) (set! rax 22) (jump tmp-ra.90 rbp rax)))
    (define L.fun/ascii-char101994.6
      ((new-frames ()) (locals (tmp-ra.91)))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/ascii-char101995.11 rbp r15)))
    (define L.fun/void101992.7
      ((new-frames ()) (locals (tmp-ra.92)))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/void101993.12 rbp r15)))
    (define L.fun/void101998.8
      ((new-frames ()) (locals (tmp-ra.93)))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void101999.4 rbp r15)))
    (define L.fun/empty101996.9
      ((new-frames ()) (locals (tmp-ra.94)))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/empty101997.5 rbp r15)))
    (define L.fun/any101991.10
      ((new-frames ()) (locals (tmp-ra.95)))
      (begin (set! tmp-ra.95 r15) (set! rax 30) (jump tmp-ra.95 rbp rax)))
    (define L.fun/ascii-char101995.11
      ((new-frames ()) (locals (tmp-ra.96)))
      (begin (set! tmp-ra.96 r15) (set! rax 25390) (jump tmp-ra.96 rbp rax)))
    (define L.fun/void101993.12
      ((new-frames ()) (locals (tmp-ra.97)))
      (begin (set! tmp-ra.97 r15) (set! rax 30) (jump tmp-ra.97 rbp rax)))
    (begin
      (set! tmp-ra.98 r15)
      (return-point L.rp.18
        (begin
          (set! rsi 248)
          (set! rdi 1216)
          (set! r15 L.rp.18)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 528)
          (set! rdi 1128)
          (set! r15 L.rp.19)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.20
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.72)
          (set! r15 L.rp.20)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 1032)
          (set! rdi 176)
          (set! r15 L.rp.21)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 1320)
          (set! rdi 968)
          (set! r15 L.rp.22)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.75)
          (set! r15 L.rp.23)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.24
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.71)
          (set! r15 L.rp.24)
          (jump L.*.15 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 1872)
          (set! rdi 424)
          (set! r15 L.rp.25)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 1288)
          (set! rdi 480)
          (set! r15 L.rp.26)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.79)
          (set! r15 L.rp.27)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1400)
          (set! rdi 1368)
          (set! r15 L.rp.28)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 544)
          (set! rdi 704)
          (set! r15 L.rp.29)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.83)
          (set! rdi tmp.82)
          (set! r15 L.rp.30)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.78)
          (set! r15 L.rp.31)
          (jump L.-.16 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.70)
          (set! r15 L.rp.32)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.33
        (begin (set! r15 L.rp.33) (jump L.fun/any101991.10 rbp r15)))
      (set! tmp.84 rax)
      (return-point L.rp.34
        (begin
          (set! rdi tmp.84)
          (set! r15 L.rp.34)
          (jump L.boolean?.17 rbp r15 rdi)))
      (set! boolean1.5 rax)
      (return-point L.rp.35
        (begin (set! r15 L.rp.35) (jump L.fun/void101992.7 rbp r15)))
      (set! void2.4 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/ascii-char101994.6 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/empty101996.9 rbp r15)))
      (set! empty4.2 rax)
      (return-point L.rp.38
        (begin (set! r15 L.rp.38) (jump L.fun/void101998.8 rbp r15)))
      (set! void5.1 rax)
      (set! rax empty4.2)
      (jump tmp-ra.98 rbp rax))))
(check-by-interp
 '(module
    ((new-frames (() () () () () ()))
     (locals (void5.1 void4.2 void3.3 empty2.4 error1.5 void0.6 tmp-ra.68)))
    (define L.fun/void102362.4
      ((new-frames ()) (locals (tmp-ra.56)))
      (begin
        (set! tmp-ra.56 r15)
        (set! r15 tmp-ra.56)
        (jump L.fun/void102363.9 rbp r15)))
    (define L.fun/empty102356.5
      ((new-frames ()) (locals (tmp-ra.57)))
      (begin
        (set! tmp-ra.57 r15)
        (set! r15 tmp-ra.57)
        (jump L.fun/empty102357.12 rbp r15)))
    (define L.fun/error102354.6
      ((new-frames ()) (locals (tmp-ra.58)))
      (begin
        (set! tmp-ra.58 r15)
        (set! r15 tmp-ra.58)
        (jump L.fun/error102355.10 rbp r15)))
    (define L.fun/void102358.7
      ((new-frames ()) (locals (tmp-ra.59)))
      (begin
        (set! tmp-ra.59 r15)
        (set! r15 tmp-ra.59)
        (jump L.fun/void102359.13 rbp r15)))
    (define L.fun/void102353.8
      ((new-frames ()) (locals (tmp-ra.60)))
      (begin (set! tmp-ra.60 r15) (set! rax 30) (jump tmp-ra.60 rbp rax)))
    (define L.fun/void102363.9
      ((new-frames ()) (locals (tmp-ra.61)))
      (begin (set! tmp-ra.61 r15) (set! rax 30) (jump tmp-ra.61 rbp rax)))
    (define L.fun/error102355.10
      ((new-frames ()) (locals (tmp-ra.62)))
      (begin (set! tmp-ra.62 r15) (set! rax 37694) (jump tmp-ra.62 rbp rax)))
    (define L.fun/void102352.11
      ((new-frames ()) (locals (tmp-ra.63)))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/void102353.8 rbp r15)))
    (define L.fun/empty102357.12
      ((new-frames ()) (locals (tmp-ra.64)))
      (begin (set! tmp-ra.64 r15) (set! rax 22) (jump tmp-ra.64 rbp rax)))
    (define L.fun/void102359.13
      ((new-frames ()) (locals (tmp-ra.65)))
      (begin (set! tmp-ra.65 r15) (set! rax 30) (jump tmp-ra.65 rbp rax)))
    (define L.fun/void102360.14
      ((new-frames ()) (locals (tmp-ra.66)))
      (begin
        (set! tmp-ra.66 r15)
        (set! r15 tmp-ra.66)
        (jump L.fun/void102361.15 rbp r15)))
    (define L.fun/void102361.15
      ((new-frames ()) (locals (tmp-ra.67)))
      (begin (set! tmp-ra.67 r15) (set! rax 30) (jump tmp-ra.67 rbp rax)))
    (begin
      (set! tmp-ra.68 r15)
      (return-point L.rp.17
        (begin (set! r15 L.rp.17) (jump L.fun/void102352.11 rbp r15)))
      (set! void0.6 rax)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/error102354.6 rbp r15)))
      (set! error1.5 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/empty102356.5 rbp r15)))
      (set! empty2.4 rax)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/void102358.7 rbp r15)))
      (set! void3.3 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/void102360.14 rbp r15)))
      (set! void4.2 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/void102362.4 rbp r15)))
      (set! void5.1 rax)
      (set! rax error1.5)
      (jump tmp-ra.68 rbp rax))))
(check-by-interp
 '(module
    ((new-frames
      (() () () () () () () () () () () () () () () () () () () () ()))
     (locals
      (void5.1
       ascii-char4.2
       ascii-char3.3
       fixnum2.4
       tmp.78
       tmp.82
       tmp.84
       tmp.83
       tmp.79
       tmp.81
       tmp.80
       tmp.71
       tmp.75
       tmp.77
       tmp.76
       tmp.72
       tmp.74
       tmp.73
       empty1.5
       boolean0.6
       tmp.70
       tmp-ra.100)))
    (define L.+.19
      ((new-frames ())
       (locals
        (tmp.58
         tmp.102
         tmp.22
         tmp.59
         tmp.103
         tmp-ra.85
         tmp.57
         tmp.23
         tmp.101
         tmp.56)))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.101 tmp.23)
                      (set! tmp.101 (bitwise-and tmp.101 7))
                      (set! tmp.57 tmp.101))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.102 tmp.22)
                        (set! tmp.102 (bitwise-and tmp.102 7))
                        (set! tmp.59 tmp.102))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.103 tmp.22)
              (set! tmp.103 (+ tmp.103 tmp.23))
              (set! rax tmp.103)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.85 rbp rax)))))
    (define L.*.18
      ((new-frames ())
       (locals
        (tmp.62
         tmp.105
         tmp.20
         tmp.63
         tmp.107
         tmp.64
         tmp.106
         tmp-ra.86
         tmp.61
         tmp.21
         tmp.104
         tmp.60)))
      (begin
        (set! tmp-ra.86 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.21)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.61 tmp.104))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.20)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.63 tmp.105))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.106 tmp.21)
              (set! tmp.106 (arithmetic-shift-right tmp.106 3))
              (set! tmp.64 tmp.106)
              (set! tmp.107 tmp.20)
              (set! tmp.107 (* tmp.107 tmp.64))
              (set! rax tmp.107)
              (jump tmp-ra.86 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.86 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.86 rbp rax)))))
    (define L.-.17
      ((new-frames ())
       (locals
        (tmp.67
         tmp.109
         tmp.24
         tmp.68
         tmp.110
         tmp-ra.87
         tmp.66
         tmp.25
         tmp.108
         tmp.65)))
      (begin
        (set! tmp-ra.87 r15)
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
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.87 rbp rax)))))
    (define L.boolean?.16
      ((new-frames ()) (locals (tmp-ra.88 tmp.111 tmp.44 tmp.69)))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.111 tmp.44)
                (set! tmp.111 (bitwise-and tmp.111 247))
                (set! tmp.69 tmp.111))
              (= tmp.69 6))
          (begin (set! rax 14) (jump tmp-ra.88 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.88 rbp rax)))))
    (define L.fun/void122163.4
      ((new-frames ()) (locals (tmp-ra.89)))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/void122164.13 rbp r15)))
    (define L.fun/ascii-char122159.5
      ((new-frames ()) (locals (tmp-ra.90)))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/ascii-char122160.6 rbp r15)))
    (define L.fun/ascii-char122160.6
      ((new-frames ()) (locals (tmp-ra.91)))
      (begin (set! tmp-ra.91 r15) (set! rax 25390) (jump tmp-ra.91 rbp rax)))
    (define L.fun/ascii-char122162.7
      ((new-frames ()) (locals (tmp-ra.92)))
      (begin (set! tmp-ra.92 r15) (set! rax 25390) (jump tmp-ra.92 rbp rax)))
    (define L.fun/empty122158.8
      ((new-frames ()) (locals (tmp-ra.93)))
      (begin (set! tmp-ra.93 r15) (set! rax 22) (jump tmp-ra.93 rbp rax)))
    (define L.fun/error122165.9
      ((new-frames ()) (locals (tmp-ra.94)))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error122166.10 rbp r15)))
    (define L.fun/error122166.10
      ((new-frames ()) (locals (tmp-ra.95)))
      (begin (set! tmp-ra.95 r15) (set! rax 46910) (jump tmp-ra.95 rbp rax)))
    (define L.fun/any122156.11
      ((new-frames ()) (locals (tmp-ra.96)))
      (begin (set! tmp-ra.96 r15) (set! rax 22) (jump tmp-ra.96 rbp rax)))
    (define L.fun/empty122157.12
      ((new-frames ()) (locals (tmp-ra.97)))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/empty122158.8 rbp r15)))
    (define L.fun/void122164.13
      ((new-frames ()) (locals (tmp-ra.98)))
      (begin (set! tmp-ra.98 r15) (set! rax 30) (jump tmp-ra.98 rbp rax)))
    (define L.fun/ascii-char122161.14
      ((new-frames ()) (locals (tmp-ra.99)))
      (begin
        (set! tmp-ra.99 r15)
        (set! r15 tmp-ra.99)
        (jump L.fun/ascii-char122162.7 rbp r15)))
    (begin
      (set! tmp-ra.100 r15)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/any122156.11 rbp r15)))
      (set! tmp.70 rax)
      (return-point L.rp.21
        (begin
          (set! rdi tmp.70)
          (set! r15 L.rp.21)
          (jump L.boolean?.16 rbp r15 rdi)))
      (set! boolean0.6 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/empty122157.12 rbp r15)))
      (set! empty1.5 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 96)
          (set! rdi 1368)
          (set! r15 L.rp.23)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 448)
          (set! rdi 1560)
          (set! r15 L.rp.24)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.73)
          (set! r15 L.rp.25)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 224)
          (set! rdi 952)
          (set! r15 L.rp.26)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 1680)
          (set! rdi 1856)
          (set! r15 L.rp.27)
          (jump L.*.18 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.76)
          (set! r15 L.rp.28)
          (jump L.+.19 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.72)
          (set! r15 L.rp.29)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.30
        (begin
          (set! rsi 304)
          (set! rdi 104)
          (set! r15 L.rp.30)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 1296)
          (set! rdi 1432)
          (set! r15 L.rp.31)
          (jump L.*.18 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.32
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.80)
          (set! r15 L.rp.32)
          (jump L.+.19 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.33
        (begin
          (set! rsi 1160)
          (set! rdi 728)
          (set! r15 L.rp.33)
          (jump L.+.19 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 464)
          (set! rdi 416)
          (set! r15 L.rp.34)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.35
        (begin
          (set! rsi tmp.84)
          (set! rdi tmp.83)
          (set! r15 L.rp.35)
          (jump L.*.18 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.79)
          (set! r15 L.rp.36)
          (jump L.+.19 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.37
        (begin
          (set! rsi tmp.78)
          (set! rdi tmp.71)
          (set! r15 L.rp.37)
          (jump L.-.17 rbp r15 rdi rsi)))
      (set! fixnum2.4 rax)
      (return-point L.rp.38
        (begin (set! r15 L.rp.38) (jump L.fun/ascii-char122159.5 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.39
        (begin (set! r15 L.rp.39) (jump L.fun/ascii-char122161.14 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.40
        (begin (set! r15 L.rp.40) (jump L.fun/void122163.4 rbp r15)))
      (set! void5.1 rax)
      (set! r15 tmp-ra.100)
      (jump L.fun/error122165.9 rbp r15))))
(check-by-interp
 '(module
    ((new-frames (() () () () () () () () () () () () () () () () () () () ()))
     (locals
      (fixnum5.1
       tmp.76
       tmp.80
       tmp.82
       tmp.81
       tmp.77
       tmp.79
       tmp.78
       tmp.69
       tmp.73
       tmp.75
       tmp.74
       tmp.70
       tmp.72
       tmp.71
       error4.2
       ascii-char3.3
       error2.4
       ascii-char1.5
       error0.6
       tmp-ra.98)))
    (define L.-.19
      ((new-frames ())
       (locals
        (tmp.58
         tmp.100
         tmp.24
         tmp.59
         tmp.101
         tmp-ra.83
         tmp.57
         tmp.25
         tmp.99
         tmp.56)))
      (begin
        (set! tmp-ra.83 r15)
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
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))))
    (define L.*.18
      ((new-frames ())
       (locals
        (tmp.62
         tmp.103
         tmp.20
         tmp.63
         tmp.105
         tmp.64
         tmp.104
         tmp-ra.84
         tmp.61
         tmp.21
         tmp.102
         tmp.60)))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.102 tmp.21)
                      (set! tmp.102 (bitwise-and tmp.102 7))
                      (set! tmp.61 tmp.102))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.103 tmp.20)
                        (set! tmp.103 (bitwise-and tmp.103 7))
                        (set! tmp.63 tmp.103))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.104 tmp.21)
              (set! tmp.104 (arithmetic-shift-right tmp.104 3))
              (set! tmp.64 tmp.104)
              (set! tmp.105 tmp.20)
              (set! tmp.105 (* tmp.105 tmp.64))
              (set! rax tmp.105)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.84 rbp rax)))))
    (define L.+.17
      ((new-frames ())
       (locals
        (tmp.67
         tmp.107
         tmp.22
         tmp.68
         tmp.108
         tmp-ra.85
         tmp.66
         tmp.23
         tmp.106
         tmp.65)))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.106 tmp.23)
                      (set! tmp.106 (bitwise-and tmp.106 7))
                      (set! tmp.66 tmp.106))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.107 tmp.22)
                        (set! tmp.107 (bitwise-and tmp.107 7))
                        (set! tmp.68 tmp.107))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.108 tmp.22)
              (set! tmp.108 (+ tmp.108 tmp.23))
              (set! rax tmp.108)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/void124216.4
      ((new-frames ()) (locals (tmp-ra.86)))
      (begin (set! tmp-ra.86 r15) (set! rax 30) (jump tmp-ra.86 rbp rax)))
    (define L.fun/ascii-char124211.5
      ((new-frames ()) (locals (tmp-ra.87)))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/ascii-char124212.10 rbp r15)))
    (define L.fun/error124206.6
      ((new-frames ()) (locals (tmp-ra.88)))
      (begin (set! tmp-ra.88 r15) (set! rax 8766) (jump tmp-ra.88 rbp rax)))
    (define L.fun/error124213.7
      ((new-frames ()) (locals (tmp-ra.89)))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/error124214.11 rbp r15)))
    (define L.fun/ascii-char124207.8
      ((new-frames ()) (locals (tmp-ra.90)))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/ascii-char124208.14 rbp r15)))
    (define L.fun/void124215.9
      ((new-frames ()) (locals (tmp-ra.91)))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/void124216.4 rbp r15)))
    (define L.fun/ascii-char124212.10
      ((new-frames ()) (locals (tmp-ra.92)))
      (begin (set! tmp-ra.92 r15) (set! rax 25390) (jump tmp-ra.92 rbp rax)))
    (define L.fun/error124214.11
      ((new-frames ()) (locals (tmp-ra.93)))
      (begin (set! tmp-ra.93 r15) (set! rax 1598) (jump tmp-ra.93 rbp rax)))
    (define L.fun/error124209.12
      ((new-frames ()) (locals (tmp-ra.94)))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error124210.13 rbp r15)))
    (define L.fun/error124210.13
      ((new-frames ()) (locals (tmp-ra.95)))
      (begin (set! tmp-ra.95 r15) (set! rax 830) (jump tmp-ra.95 rbp rax)))
    (define L.fun/ascii-char124208.14
      ((new-frames ()) (locals (tmp-ra.96)))
      (begin (set! tmp-ra.96 r15) (set! rax 25390) (jump tmp-ra.96 rbp rax)))
    (define L.fun/error124205.15
      ((new-frames ()) (locals (tmp-ra.97)))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/error124206.6 rbp r15)))
    (begin
      (set! tmp-ra.98 r15)
      (return-point L.rp.20
        (begin (set! r15 L.rp.20) (jump L.fun/error124205.15 rbp r15)))
      (set! error0.6 rax)
      (return-point L.rp.21
        (begin (set! r15 L.rp.21) (jump L.fun/ascii-char124207.8 rbp r15)))
      (set! ascii-char1.5 rax)
      (return-point L.rp.22
        (begin (set! r15 L.rp.22) (jump L.fun/error124209.12 rbp r15)))
      (set! error2.4 rax)
      (return-point L.rp.23
        (begin (set! r15 L.rp.23) (jump L.fun/ascii-char124211.5 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.24
        (begin (set! r15 L.rp.24) (jump L.fun/error124213.7 rbp r15)))
      (set! error4.2 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 16)
          (set! rdi 1640)
          (set! r15 L.rp.25)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 120)
          (set! rdi 1384)
          (set! r15 L.rp.26)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.27)
          (jump L.*.18 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1400)
          (set! rdi 712)
          (set! r15 L.rp.28)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 912)
          (set! rdi 936)
          (set! r15 L.rp.29)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.30)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.31
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.31)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 952)
          (set! rdi 1344)
          (set! r15 L.rp.32)
          (jump L.*.18 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.33
        (begin
          (set! rsi 264)
          (set! rdi 648)
          (set! r15 L.rp.33)
          (jump L.-.19 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.34)
          (jump L.*.18 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 1552)
          (set! rdi 560)
          (set! r15 L.rp.35)
          (jump L.-.19 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.36
        (begin
          (set! rsi 952)
          (set! rdi 592)
          (set! r15 L.rp.36)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.37
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.37)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.38
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.38)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.39
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.39)
          (jump L.*.18 rbp r15 rdi rsi)))
      (set! fixnum5.1 rax)
      (set! r15 tmp-ra.98)
      (jump L.fun/void124215.9 rbp r15))))
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
       ()))
     (locals
      (tmp.85
       tmp.86
       tmp.88
       tmp.87
       void5.1
       ascii-char4.2
       ascii-char3.3
       fixnum2.4
       tmp.78
       tmp.82
       tmp.84
       tmp.83
       tmp.79
       tmp.81
       tmp.80
       tmp.71
       tmp.75
       tmp.77
       tmp.76
       tmp.72
       tmp.74
       tmp.73
       boolean1.5
       tmp.70
       void0.6
       tmp-ra.102)))
    (define L.+.17
      ((new-frames ())
       (locals
        (tmp.58
         tmp.104
         tmp.22
         tmp.59
         tmp.105
         tmp-ra.89
         tmp.57
         tmp.23
         tmp.103
         tmp.56)))
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
      ((new-frames ())
       (locals
        (tmp.62
         tmp.107
         tmp.20
         tmp.63
         tmp.109
         tmp.64
         tmp.108
         tmp-ra.90
         tmp.61
         tmp.21
         tmp.106
         tmp.60)))
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
      ((new-frames ())
       (locals
        (tmp.67
         tmp.111
         tmp.24
         tmp.68
         tmp.112
         tmp-ra.91
         tmp.66
         tmp.25
         tmp.110
         tmp.65)))
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
    (define L.pair?.14
      ((new-frames ()) (locals (tmp-ra.92 tmp.113 tmp.49 tmp.69)))
      (begin
        (set! tmp-ra.92 r15)
        (set! tmp.49 rdi)
        (if (begin
              (begin
                (set! tmp.113 tmp.49)
                (set! tmp.113 (bitwise-and tmp.113 7))
                (set! tmp.69 tmp.113))
              (= tmp.69 1))
          (begin (set! rax 14) (jump tmp-ra.92 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.92 rbp rax)))))
    (define L.fun/ascii-char156382.4
      ((new-frames ()) (locals (tmp-ra.93)))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/ascii-char156383.11 rbp r15)))
    (define L.fun/void156379.5
      ((new-frames ()) (locals (tmp-ra.94)))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/void156380.6 rbp r15)))
    (define L.fun/void156380.6
      ((new-frames ()) (locals (tmp-ra.95)))
      (begin (set! tmp-ra.95 r15) (set! rax 30) (jump tmp-ra.95 rbp rax)))
    (define L.fun/void156387.7
      ((new-frames ()) (locals (tmp-ra.96)))
      (begin (set! tmp-ra.96 r15) (set! rax 30) (jump tmp-ra.96 rbp rax)))
    (define L.fun/any156381.8
      ((new-frames ()) (locals (tmp-ra.97)))
      (begin (set! tmp-ra.97 r15) (set! rax 11326) (jump tmp-ra.97 rbp rax)))
    (define L.fun/void156386.9
      ((new-frames ()) (locals (tmp-ra.98)))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/void156387.7 rbp r15)))
    (define L.fun/ascii-char156384.10
      ((new-frames ()) (locals (tmp-ra.99)))
      (begin
        (set! tmp-ra.99 r15)
        (set! r15 tmp-ra.99)
        (jump L.fun/ascii-char156385.12 rbp r15)))
    (define L.fun/ascii-char156383.11
      ((new-frames ()) (locals (tmp-ra.100)))
      (begin (set! tmp-ra.100 r15) (set! rax 25390) (jump tmp-ra.100 rbp rax)))
    (define L.fun/ascii-char156385.12
      ((new-frames ()) (locals (tmp-ra.101)))
      (begin (set! tmp-ra.101 r15) (set! rax 25390) (jump tmp-ra.101 rbp rax)))
    (begin
      (set! tmp-ra.102 r15)
      (return-point L.rp.18
        (begin (set! r15 L.rp.18) (jump L.fun/void156379.5 rbp r15)))
      (set! void0.6 rax)
      (return-point L.rp.19
        (begin (set! r15 L.rp.19) (jump L.fun/any156381.8 rbp r15)))
      (set! tmp.70 rax)
      (return-point L.rp.20
        (begin
          (set! rdi tmp.70)
          (set! r15 L.rp.20)
          (jump L.pair?.14 rbp r15 rdi)))
      (set! boolean1.5 rax)
      (return-point L.rp.21
        (begin
          (set! rsi 2016)
          (set! rdi 232)
          (set! r15 L.rp.21)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.22
        (begin
          (set! rsi 304)
          (set! rdi 504)
          (set! r15 L.rp.22)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.23
        (begin
          (set! rsi tmp.74)
          (set! rdi tmp.73)
          (set! r15 L.rp.23)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 1152)
          (set! rdi 368)
          (set! r15 L.rp.24)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.25
        (begin
          (set! rsi 424)
          (set! rdi 1752)
          (set! r15 L.rp.25)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.26
        (begin
          (set! rsi tmp.77)
          (set! rdi tmp.76)
          (set! r15 L.rp.26)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.27
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.72)
          (set! r15 L.rp.27)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.28
        (begin
          (set! rsi 1616)
          (set! rdi 1736)
          (set! r15 L.rp.28)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.29
        (begin
          (set! rsi 568)
          (set! rdi 320)
          (set! r15 L.rp.29)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.81)
          (set! rdi tmp.80)
          (set! r15 L.rp.30)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 1224)
          (set! rdi 192)
          (set! r15 L.rp.31)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 2016)
          (set! rdi 1976)
          (set! r15 L.rp.32)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.84)
          (set! rdi tmp.83)
          (set! r15 L.rp.33)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.34
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.79)
          (set! r15 L.rp.34)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.35
        (begin
          (set! rsi tmp.78)
          (set! rdi tmp.71)
          (set! r15 L.rp.35)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! fixnum2.4 rax)
      (return-point L.rp.36
        (begin (set! r15 L.rp.36) (jump L.fun/ascii-char156382.4 rbp r15)))
      (set! ascii-char3.3 rax)
      (return-point L.rp.37
        (begin (set! r15 L.rp.37) (jump L.fun/ascii-char156384.10 rbp r15)))
      (set! ascii-char4.2 rax)
      (return-point L.rp.38
        (begin (set! r15 L.rp.38) (jump L.fun/void156386.9 rbp r15)))
      (set! void5.1 rax)
      (return-point L.rp.39
        (begin
          (set! rsi 1944)
          (set! rdi 912)
          (set! r15 L.rp.39)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.40
        (begin
          (set! rsi fixnum2.4)
          (set! rdi 1896)
          (set! r15 L.rp.40)
          (jump L.+.17 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.41
        (begin
          (set! rsi tmp.88)
          (set! rdi tmp.87)
          (set! r15 L.rp.41)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.42
        (begin
          (set! rsi tmp.86)
          (set! rdi fixnum2.4)
          (set! r15 L.rp.42)
          (jump L.*.16 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (set! rsi tmp.85)
      (set! rdi fixnum2.4)
      (set! r15 tmp-ra.102)
      (jump L.-.15 rbp r15 rdi rsi))))
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
      (void5.1
       void4.2
       empty3.3
       ascii-char2.4
       fixnum1.5
       tmp.90
       tmp.94
       tmp.96
       tmp.95
       tmp.91
       tmp.93
       tmp.92
       tmp.83
       tmp.87
       tmp.89
       tmp.88
       tmp.84
       tmp.86
       tmp.85
       fixnum0.6
       tmp.76
       tmp.80
       tmp.82
       tmp.81
       tmp.77
       tmp.79
       tmp.78
       tmp.69
       tmp.73
       tmp.75
       tmp.74
       tmp.70
       tmp.72
       tmp.71
       tmp-ra.108)))
    (define L.-.15
      ((new-frames ())
       (locals
        (tmp.58
         tmp.110
         tmp.24
         tmp.59
         tmp.111
         tmp-ra.97
         tmp.57
         tmp.25
         tmp.109
         tmp.56)))
      (begin
        (set! tmp-ra.97 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.109 tmp.25)
                      (set! tmp.109 (bitwise-and tmp.109 7))
                      (set! tmp.57 tmp.109))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.110 tmp.24)
                        (set! tmp.110 (bitwise-and tmp.110 7))
                        (set! tmp.59 tmp.110))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.111 tmp.24)
              (set! tmp.111 (- tmp.111 tmp.25))
              (set! rax tmp.111)
              (jump tmp-ra.97 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.97 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.97 rbp rax)))))
    (define L.+.14
      ((new-frames ())
       (locals
        (tmp.62
         tmp.113
         tmp.22
         tmp.63
         tmp.114
         tmp-ra.98
         tmp.61
         tmp.23
         tmp.112
         tmp.60)))
      (begin
        (set! tmp-ra.98 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.112 tmp.23)
                      (set! tmp.112 (bitwise-and tmp.112 7))
                      (set! tmp.61 tmp.112))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.113 tmp.22)
                        (set! tmp.113 (bitwise-and tmp.113 7))
                        (set! tmp.63 tmp.113))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.114 tmp.22)
              (set! tmp.114 (+ tmp.114 tmp.23))
              (set! rax tmp.114)
              (jump tmp-ra.98 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.98 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.98 rbp rax)))))
    (define L.*.13
      ((new-frames ())
       (locals
        (tmp.66
         tmp.116
         tmp.20
         tmp.67
         tmp.118
         tmp.68
         tmp.117
         tmp-ra.99
         tmp.65
         tmp.21
         tmp.115
         tmp.64)))
      (begin
        (set! tmp-ra.99 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.115 tmp.21)
                      (set! tmp.115 (bitwise-and tmp.115 7))
                      (set! tmp.65 tmp.115))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.116 tmp.20)
                        (set! tmp.116 (bitwise-and tmp.116 7))
                        (set! tmp.67 tmp.116))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.117 tmp.21)
              (set! tmp.117 (arithmetic-shift-right tmp.117 3))
              (set! tmp.68 tmp.117)
              (set! tmp.118 tmp.20)
              (set! tmp.118 (* tmp.118 tmp.68))
              (set! rax tmp.118)
              (jump tmp-ra.99 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.99 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.99 rbp rax)))))
    (define L.fun/empty171686.4
      ((new-frames ()) (locals (tmp-ra.100)))
      (begin
        (set! tmp-ra.100 r15)
        (set! r15 tmp-ra.100)
        (jump L.fun/empty171687.10 rbp r15)))
    (define L.fun/void171689.5
      ((new-frames ()) (locals (tmp-ra.101)))
      (begin (set! tmp-ra.101 r15) (set! rax 30) (jump tmp-ra.101 rbp rax)))
    (define L.fun/ascii-char171684.6
      ((new-frames ()) (locals (tmp-ra.102)))
      (begin
        (set! tmp-ra.102 r15)
        (set! r15 tmp-ra.102)
        (jump L.fun/ascii-char171685.9 rbp r15)))
    (define L.fun/void171688.7
      ((new-frames ()) (locals (tmp-ra.103)))
      (begin
        (set! tmp-ra.103 r15)
        (set! r15 tmp-ra.103)
        (jump L.fun/void171689.5 rbp r15)))
    (define L.fun/void171691.8
      ((new-frames ()) (locals (tmp-ra.104)))
      (begin (set! tmp-ra.104 r15) (set! rax 30) (jump tmp-ra.104 rbp rax)))
    (define L.fun/ascii-char171685.9
      ((new-frames ()) (locals (tmp-ra.105)))
      (begin (set! tmp-ra.105 r15) (set! rax 25390) (jump tmp-ra.105 rbp rax)))
    (define L.fun/empty171687.10
      ((new-frames ()) (locals (tmp-ra.106)))
      (begin (set! tmp-ra.106 r15) (set! rax 22) (jump tmp-ra.106 rbp rax)))
    (define L.fun/void171690.11
      ((new-frames ()) (locals (tmp-ra.107)))
      (begin
        (set! tmp-ra.107 r15)
        (set! r15 tmp-ra.107)
        (jump L.fun/void171691.8 rbp r15)))
    (begin
      (set! tmp-ra.108 r15)
      (return-point L.rp.16
        (begin
          (set! rsi 1576)
          (set! rdi 2008)
          (set! r15 L.rp.16)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.71 rax)
      (return-point L.rp.17
        (begin
          (set! rsi 1128)
          (set! rdi 1088)
          (set! r15 L.rp.17)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.72 rax)
      (return-point L.rp.18
        (begin
          (set! rsi tmp.72)
          (set! rdi tmp.71)
          (set! r15 L.rp.18)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.70 rax)
      (return-point L.rp.19
        (begin
          (set! rsi 48)
          (set! rdi 1968)
          (set! r15 L.rp.19)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.74 rax)
      (return-point L.rp.20
        (begin
          (set! rsi 624)
          (set! rdi 592)
          (set! r15 L.rp.20)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.75 rax)
      (return-point L.rp.21
        (begin
          (set! rsi tmp.75)
          (set! rdi tmp.74)
          (set! r15 L.rp.21)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.73 rax)
      (return-point L.rp.22
        (begin
          (set! rsi tmp.73)
          (set! rdi tmp.70)
          (set! r15 L.rp.22)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.69 rax)
      (return-point L.rp.23
        (begin
          (set! rsi 672)
          (set! rdi 1184)
          (set! r15 L.rp.23)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.78 rax)
      (return-point L.rp.24
        (begin
          (set! rsi 1584)
          (set! rdi 1320)
          (set! r15 L.rp.24)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.79 rax)
      (return-point L.rp.25
        (begin
          (set! rsi tmp.79)
          (set! rdi tmp.78)
          (set! r15 L.rp.25)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.77 rax)
      (return-point L.rp.26
        (begin
          (set! rsi 904)
          (set! rdi 1768)
          (set! r15 L.rp.26)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.81 rax)
      (return-point L.rp.27
        (begin
          (set! rsi 104)
          (set! rdi 928)
          (set! r15 L.rp.27)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.82 rax)
      (return-point L.rp.28
        (begin
          (set! rsi tmp.82)
          (set! rdi tmp.81)
          (set! r15 L.rp.28)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.80 rax)
      (return-point L.rp.29
        (begin
          (set! rsi tmp.80)
          (set! rdi tmp.77)
          (set! r15 L.rp.29)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.76 rax)
      (return-point L.rp.30
        (begin
          (set! rsi tmp.76)
          (set! rdi tmp.69)
          (set! r15 L.rp.30)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! fixnum0.6 rax)
      (return-point L.rp.31
        (begin
          (set! rsi 240)
          (set! rdi 1160)
          (set! r15 L.rp.31)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.85 rax)
      (return-point L.rp.32
        (begin
          (set! rsi 256)
          (set! rdi 1520)
          (set! r15 L.rp.32)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.86 rax)
      (return-point L.rp.33
        (begin
          (set! rsi tmp.86)
          (set! rdi tmp.85)
          (set! r15 L.rp.33)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.84 rax)
      (return-point L.rp.34
        (begin
          (set! rsi 240)
          (set! rdi 960)
          (set! r15 L.rp.34)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.88 rax)
      (return-point L.rp.35
        (begin
          (set! rsi 728)
          (set! rdi 624)
          (set! r15 L.rp.35)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.89 rax)
      (return-point L.rp.36
        (begin
          (set! rsi tmp.89)
          (set! rdi tmp.88)
          (set! r15 L.rp.36)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.87 rax)
      (return-point L.rp.37
        (begin
          (set! rsi tmp.87)
          (set! rdi tmp.84)
          (set! r15 L.rp.37)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.83 rax)
      (return-point L.rp.38
        (begin
          (set! rsi 1080)
          (set! rdi 1880)
          (set! r15 L.rp.38)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.92 rax)
      (return-point L.rp.39
        (begin
          (set! rsi 1000)
          (set! rdi 440)
          (set! r15 L.rp.39)
          (jump L.*.13 rbp r15 rdi rsi)))
      (set! tmp.93 rax)
      (return-point L.rp.40
        (begin
          (set! rsi tmp.93)
          (set! rdi tmp.92)
          (set! r15 L.rp.40)
          (jump L.+.14 rbp r15 rdi rsi)))
      (set! tmp.91 rax)
      (return-point L.rp.41
        (begin
          (set! rsi 608)
          (set! rdi 936)
          (set! r15 L.rp.41)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.95 rax)
      (return-point L.rp.42
        (begin
          (set! rsi 984)
          (set! rdi 568)
          (set! r15 L.rp.42)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.96 rax)
      (return-point L.rp.43
        (begin
          (set! rsi tmp.96)
          (set! rdi tmp.95)
          (set! r15 L.rp.43)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.94 rax)
      (return-point L.rp.44
        (begin
          (set! rsi tmp.94)
          (set! rdi tmp.91)
          (set! r15 L.rp.44)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! tmp.90 rax)
      (return-point L.rp.45
        (begin
          (set! rsi tmp.90)
          (set! rdi tmp.83)
          (set! r15 L.rp.45)
          (jump L.-.15 rbp r15 rdi rsi)))
      (set! fixnum1.5 rax)
      (return-point L.rp.46
        (begin (set! r15 L.rp.46) (jump L.fun/ascii-char171684.6 rbp r15)))
      (set! ascii-char2.4 rax)
      (return-point L.rp.47
        (begin (set! r15 L.rp.47) (jump L.fun/empty171686.4 rbp r15)))
      (set! empty3.3 rax)
      (return-point L.rp.48
        (begin (set! r15 L.rp.48) (jump L.fun/void171688.7 rbp r15)))
      (set! void4.2 rax)
      (return-point L.rp.49
        (begin (set! r15 L.rp.49) (jump L.fun/void171690.11 rbp r15)))
      (set! void5.1 rax)
      (set! rax fixnum1.5)
      (jump tmp-ra.108 rbp rax))))
