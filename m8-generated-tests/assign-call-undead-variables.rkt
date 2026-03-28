#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v8
         (only-in "../assign-call-undead-variables.rkt"))
(define (fail-if-invalid p)
  (when (not (asm-pred-lang-v8/pre-framed? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "asm-pred-lang-v8/pre-framed"
      " program")))
  p)
(define (check-by-interp p)
  (interp-asm-pred-lang-v8/conflicts p)
  (interp-asm-pred-lang-v8/pre-framed
   (fail-if-invalid (assign-call-undead-variables p))))

(check-by-interp
 '(module
    ((new-frames ())
     (locals (tmp-ra.50))
     (call-undead ())
     (undead-out ((tmp-ra.50 rbp) (tmp-ra.50 rax rbp) (rax rbp)))
     (conflicts
      ((tmp-ra.50 (rax rbp)) (rbp (rax tmp-ra.50)) (rax (rbp tmp-ra.50)))))
    (begin (set! tmp-ra.50 r15) (set! rax 24894) (jump tmp-ra.50 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals (tmp-ra.50))
     (call-undead ())
     (undead-out ((tmp-ra.50 rbp) (tmp-ra.50 rax rbp) (rax rbp)))
     (conflicts
      ((tmp-ra.50 (rax rbp)) (rbp (rax tmp-ra.50)) (rax (rbp tmp-ra.50)))))
    (begin (set! tmp-ra.50 r15) (set! rax 22) (jump tmp-ra.50 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals (tmp-ra.51))
     (call-undead ())
     (undead-out ((tmp-ra.51 rbp) (r15 rbp) (r15 rbp)))
     (conflicts ((tmp-ra.51 (rbp)) (rbp (r15 tmp-ra.51)) (r15 (rbp)))))
    (define L.fun/void8390.4
      ((new-frames ())
       (locals (tmp-ra.50))
       (undead-out ((tmp-ra.50 rbp) (tmp-ra.50 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.50 (rax rbp)) (rbp (rax tmp-ra.50)) (rax (rbp tmp-ra.50)))))
      (begin (set! tmp-ra.50 r15) (set! rax 30) (jump tmp-ra.50 rbp rax)))
    (begin
      (set! tmp-ra.51 r15)
      (set! r15 tmp-ra.51)
      (jump L.fun/void8390.4 rbp r15))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals (empty0.1 tmp-ra.51))
     (call-undead ())
     (undead-out
      ((tmp-ra.51 rbp) (tmp-ra.51 rbp) (tmp-ra.51 rax rbp) (rax rbp)))
     (conflicts
      ((tmp-ra.51 (rax empty0.1 rbp))
       (empty0.1 (rbp tmp-ra.51))
       (rbp (rax empty0.1 tmp-ra.51))
       (rax (rbp tmp-ra.51)))))
    (begin
      (set! tmp-ra.51 r15)
      (set! empty0.1 22)
      (set! rax 21310)
      (jump tmp-ra.51 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals (ascii-char1.1 void0.2 tmp-ra.52))
     (call-undead ())
     (undead-out
      ((tmp-ra.52 rbp)
       (tmp-ra.52 rbp)
       (tmp-ra.52 rbp)
       (tmp-ra.52 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.52 (rax ascii-char1.1 void0.2 rbp))
       (void0.2 (rbp tmp-ra.52))
       (ascii-char1.1 (rbp tmp-ra.52))
       (rbp (rax ascii-char1.1 void0.2 tmp-ra.52))
       (rax (rbp tmp-ra.52)))))
    (begin
      (set! tmp-ra.52 r15)
      (set! void0.2 30)
      (set! ascii-char1.1 25390)
      (set! rax 576)
      (jump tmp-ra.52 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals (tmp.53 boolean1.2 ascii-char0.3 tmp-ra.55))
     (call-undead ())
     (undead-out
      ((tmp-ra.55 rbp)
       (tmp-ra.55 rbp)
       (tmp-ra.55 rbp)
       (tmp.53 tmp-ra.55 rbp)
       (tmp-ra.55 rdi rbp)
       (rdi r15 rbp)
       (rdi r15 rbp)))
     (conflicts
      ((tmp-ra.55 (rdi tmp.53 boolean1.2 ascii-char0.3 rbp))
       (ascii-char0.3 (rbp tmp-ra.55))
       (boolean1.2 (rbp tmp-ra.55))
       (tmp.53 (rbp tmp-ra.55))
       (rbp (r15 rdi tmp.53 boolean1.2 ascii-char0.3 tmp-ra.55))
       (rdi (r15 rbp tmp-ra.55))
       (r15 (rbp rdi)))))
    (define L.fun/void8397.4
      ((new-frames ())
       (locals (oprand0.1 tmp-ra.54))
       (undead-out
        ((rdi tmp-ra.54 rbp) (tmp-ra.54 rbp) (tmp-ra.54 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.54 (rax oprand0.1 rbp rdi))
         (oprand0.1 (rbp tmp-ra.54))
         (rdi (tmp-ra.54))
         (rbp (rax oprand0.1 tmp-ra.54))
         (rax (rbp tmp-ra.54)))))
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
    ((new-frames ())
     (locals (tmp-ra.50 tmp.51))
     (call-undead ())
     (undead-out
      ((tmp-ra.50 rbp)
       (((tmp.51 tmp-ra.50 rbp) (tmp-ra.50 rbp))
        ((tmp-ra.50 rax rbp) (rax rbp))
        ((tmp-ra.50 rax rbp) (rax rbp)))))
     (conflicts
      ((tmp.51 (rbp tmp-ra.50))
       (tmp-ra.50 (rbp tmp.51 rax))
       (rax (rbp tmp-ra.50))
       (rbp (tmp-ra.50 tmp.51 rax)))))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 14) (!= tmp.51 6))
        (begin (set! rax 18494) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 57406) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals (tmp-ra.50 tmp.51))
     (call-undead ())
     (undead-out
      ((tmp-ra.50 rbp)
       (((tmp.51 tmp-ra.50 rbp) (tmp-ra.50 rbp))
        ((tmp-ra.50 rax rbp) (rax rbp))
        ((tmp-ra.50 rax rbp) (rax rbp)))))
     (conflicts
      ((tmp.51 (rbp tmp-ra.50))
       (tmp-ra.50 (rbp tmp.51 rax))
       (rax (rbp tmp-ra.50))
       (rbp (tmp-ra.50 tmp.51 rax)))))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 6) (!= tmp.51 6))
        (begin (set! rax 25390) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 25390) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals (tmp-ra.50 tmp.51))
     (call-undead ())
     (undead-out
      ((tmp-ra.50 rbp)
       (((tmp.51 tmp-ra.50 rbp) (tmp-ra.50 rbp))
        ((tmp-ra.50 rax rbp) (rax rbp))
        ((tmp-ra.50 rax rbp) (rax rbp)))))
     (conflicts
      ((tmp.51 (rbp tmp-ra.50))
       (tmp-ra.50 (rbp tmp.51 rax))
       (rax (rbp tmp-ra.50))
       (rbp (tmp-ra.50 tmp.51 rax)))))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 14) (!= tmp.51 6))
        (begin (set! rax 240) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 224) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals (ascii-char1.1 empty0.2 tmp-ra.52))
     (call-undead ())
     (undead-out
      ((tmp-ra.52 rbp)
       (tmp-ra.52 rbp)
       (tmp-ra.52 rbp)
       (tmp-ra.52 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.52 (rax ascii-char1.1 empty0.2 rbp))
       (empty0.2 (rbp tmp-ra.52))
       (ascii-char1.1 (rbp tmp-ra.52))
       (rbp (rax ascii-char1.1 empty0.2 tmp-ra.52))
       (rax (rbp tmp-ra.52)))))
    (begin
      (set! tmp-ra.52 r15)
      (set! empty0.2 22)
      (set! ascii-char1.1 25390)
      (set! rax 30)
      (jump tmp-ra.52 rbp rax))))
(check-by-interp
 '(module
    ((new-frames ())
     (locals (tmp.53 error1.2 void0.3 tmp-ra.55))
     (call-undead ())
     (undead-out
      ((tmp-ra.55 rbp)
       (tmp-ra.55 rbp)
       (error1.2 tmp-ra.55 rbp)
       (tmp.53 tmp-ra.55 rbp)
       (tmp-ra.55 rdi rbp)
       (rdi r15 rbp)
       (rdi r15 rbp)))
     (conflicts
      ((tmp-ra.55 (rdi tmp.53 error1.2 void0.3 rbp))
       (void0.3 (rbp tmp-ra.55))
       (error1.2 (rbp tmp-ra.55))
       (tmp.53 (rbp tmp-ra.55))
       (rbp (r15 rdi tmp.53 error1.2 void0.3 tmp-ra.55))
       (rdi (r15 rbp tmp-ra.55))
       (r15 (rbp rdi)))))
    (define L.fun/error8412.4
      ((new-frames ())
       (locals (oprand0.1 tmp-ra.54))
       (undead-out
        ((rdi tmp-ra.54 rbp) (tmp-ra.54 rbp) (tmp-ra.54 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.54 (rax oprand0.1 rbp rdi))
         (oprand0.1 (rbp tmp-ra.54))
         (rdi (tmp-ra.54))
         (rbp (rax oprand0.1 tmp-ra.54))
         (rax (rbp tmp-ra.54)))))
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
    ((new-frames ())
     (locals (tmp.53 error1.2 ascii-char0.3 tmp-ra.55))
     (call-undead ())
     (undead-out
      ((tmp-ra.55 rbp)
       (tmp-ra.55 rbp)
       (tmp-ra.55 rbp)
       (tmp.53 tmp-ra.55 rbp)
       (tmp-ra.55 rdi rbp)
       (rdi r15 rbp)
       (rdi r15 rbp)))
     (conflicts
      ((tmp-ra.55 (rdi tmp.53 error1.2 ascii-char0.3 rbp))
       (ascii-char0.3 (rbp tmp-ra.55))
       (error1.2 (rbp tmp-ra.55))
       (tmp.53 (rbp tmp-ra.55))
       (rbp (r15 rdi tmp.53 error1.2 ascii-char0.3 tmp-ra.55))
       (rdi (r15 rbp tmp-ra.55))
       (r15 (rbp rdi)))))
    (define L.fun/ascii-char8415.4
      ((new-frames ())
       (locals (oprand0.1 tmp-ra.54))
       (undead-out
        ((rdi tmp-ra.54 rbp) (tmp-ra.54 rbp) (tmp-ra.54 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.54 (rax oprand0.1 rbp rdi))
         (oprand0.1 (rbp tmp-ra.54))
         (rdi (tmp-ra.54))
         (rbp (rax oprand0.1 tmp-ra.54))
         (rax (rbp tmp-ra.54)))))
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
    ((new-frames (() () ()))
     (locals (empty2.1 fixnum1.2 fixnum0.3 tmp-ra.65))
     (call-undead (tmp-ra.65))
     (undead-out
      ((tmp-ra.65 rbp)
       ((rax tmp-ra.65 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.65 rbp)
       ((rax tmp-ra.65 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.65 rbp)
       ((rax tmp-ra.65 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.65 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.65 (empty2.1 fixnum1.2 fixnum0.3 rax rbp))
       (fixnum0.3 (rbp tmp-ra.65))
       (fixnum1.2 (rbp tmp-ra.65))
       (empty2.1 (rbp tmp-ra.65))
       (rbp (empty2.1 fixnum1.2 fixnum0.3 r15 rdi rsi rax tmp-ra.65))
       (rax (rbp tmp-ra.65))
       (rsi (r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
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
         tmp.53))
       (undead-out
        ((rdi rsi tmp-ra.61 rbp)
         (rsi tmp.21 tmp-ra.61 rbp)
         (tmp.21 tmp.22 tmp-ra.61 rbp)
         ((((((tmp.66 tmp.21 tmp.22 tmp-ra.61 rbp)
              (tmp.66 tmp.21 tmp.22 tmp-ra.61 rbp)
              (tmp.54 tmp.21 tmp.22 tmp-ra.61 rbp))
             (tmp.21 tmp.22 tmp-ra.61 rbp))
            (tmp.53 tmp.21 tmp.22 tmp-ra.61 rbp)
            (tmp.53 tmp.21 tmp.22 tmp-ra.61 rbp))
           (tmp.21 tmp.22 tmp-ra.61 rbp))
          ((((((tmp.67 tmp.21 tmp.22 tmp-ra.61 rbp)
               (tmp.67 tmp.21 tmp.22 tmp-ra.61 rbp)
               (tmp.56 tmp.21 tmp.22 tmp-ra.61 rbp))
              (tmp.21 tmp.22 tmp-ra.61 rbp))
             (tmp.55 tmp.21 tmp.22 tmp-ra.61 rbp)
             (tmp.55 tmp.21 tmp.22 tmp-ra.61 rbp))
            (tmp.21 tmp.22 tmp-ra.61 rbp))
           ((tmp.22 tmp.68 tmp-ra.61 rbp)
            (tmp.68 tmp-ra.61 rbp)
            (tmp-ra.61 rax rbp)
            (rax rbp))
           ((tmp-ra.61 rax rbp) (rax rbp)))
          ((tmp-ra.61 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.53 (rbp tmp-ra.61 tmp.22 tmp.21))
         (tmp.66 (tmp.22 rbp tmp-ra.61 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.61
           tmp.21
           tmp.66
           tmp.54
           tmp.53
           tmp.67
           tmp.56
           tmp.55
           tmp.68))
         (tmp.54 (rbp tmp-ra.61 tmp.22 tmp.21))
         (tmp-ra.61
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.66
           tmp.54
           tmp.53
           tmp.67
           tmp.56
           tmp.55
           tmp.68
           rax))
         (tmp.68 (rbp tmp-ra.61 tmp.22))
         (tmp.56 (rbp tmp-ra.61 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.61 rsi tmp.66 tmp.54 tmp.53 tmp.67 tmp.56 tmp.55))
         (tmp.67 (tmp.21 rbp tmp-ra.61 tmp.22))
         (tmp.55 (rbp tmp-ra.61 tmp.22 tmp.21))
         (rax (rbp tmp-ra.61))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.61
           tmp.66
           tmp.54
           tmp.53
           tmp.67
           tmp.56
           tmp.55
           tmp.68
           rax))
         (rdi (tmp-ra.61))
         (rsi (tmp.21 tmp-ra.61)))))
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
         tmp.57))
       (undead-out
        ((rdi rsi tmp-ra.62 rbp)
         (rsi tmp.19 tmp-ra.62 rbp)
         (tmp.19 tmp.20 tmp-ra.62 rbp)
         ((((((tmp.69 tmp.19 tmp.20 tmp-ra.62 rbp)
              (tmp.69 tmp.19 tmp.20 tmp-ra.62 rbp)
              (tmp.58 tmp.19 tmp.20 tmp-ra.62 rbp))
             (tmp.19 tmp.20 tmp-ra.62 rbp))
            (tmp.57 tmp.19 tmp.20 tmp-ra.62 rbp)
            (tmp.57 tmp.19 tmp.20 tmp-ra.62 rbp))
           (tmp.19 tmp.20 tmp-ra.62 rbp))
          ((((((tmp.70 tmp.19 tmp.20 tmp-ra.62 rbp)
               (tmp.70 tmp.19 tmp.20 tmp-ra.62 rbp)
               (tmp.60 tmp.19 tmp.20 tmp-ra.62 rbp))
              (tmp.19 tmp.20 tmp-ra.62 rbp))
             (tmp.59 tmp.19 tmp.20 tmp-ra.62 rbp)
             (tmp.59 tmp.19 tmp.20 tmp-ra.62 rbp))
            (tmp.19 tmp.20 tmp-ra.62 rbp))
           ((tmp.20 tmp.71 tmp-ra.62 rbp)
            (tmp.71 tmp-ra.62 rbp)
            (tmp-ra.62 rax rbp)
            (rax rbp))
           ((tmp-ra.62 rax rbp) (rax rbp)))
          ((tmp-ra.62 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.62 tmp.20 tmp.19))
         (tmp.69 (tmp.20 rbp tmp-ra.62 tmp.19))
         (tmp.20
          (rbp
           tmp-ra.62
           tmp.19
           tmp.69
           tmp.58
           tmp.57
           tmp.70
           tmp.60
           tmp.59
           tmp.71))
         (tmp.58 (rbp tmp-ra.62 tmp.20 tmp.19))
         (tmp-ra.62
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.69
           tmp.58
           tmp.57
           tmp.70
           tmp.60
           tmp.59
           tmp.71
           rax))
         (tmp.71 (rbp tmp-ra.62 tmp.20))
         (tmp.60 (rbp tmp-ra.62 tmp.20 tmp.19))
         (tmp.19
          (tmp.20 rbp tmp-ra.62 rsi tmp.69 tmp.58 tmp.57 tmp.70 tmp.60 tmp.59))
         (tmp.70 (tmp.19 rbp tmp-ra.62 tmp.20))
         (tmp.59 (rbp tmp-ra.62 tmp.20 tmp.19))
         (rax (rbp tmp-ra.62))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.62
           tmp.69
           tmp.58
           tmp.57
           tmp.70
           tmp.60
           tmp.59
           tmp.71
           rax))
         (rdi (tmp-ra.62))
         (rsi (tmp.19 tmp-ra.62)))))
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
      ((new-frames ())
       (locals (tmp-ra.63))
       (undead-out ((tmp-ra.63 rbp) (tmp-ra.63 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.63 (rax rbp)) (rbp (rax tmp-ra.63)) (rax (rbp tmp-ra.63)))))
      (begin (set! tmp-ra.63 r15) (set! rax 22) (jump tmp-ra.63 rbp rax)))
    (define L.fun/ascii-char8419.5
      ((new-frames ())
       (locals (tmp-ra.64))
       (undead-out ((tmp-ra.64 rbp) (tmp-ra.64 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.64 (rax rbp)) (rbp (rax tmp-ra.64)) (rax (rbp tmp-ra.64)))))
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
       tmp-ra.66))
     (call-undead (tmp.59 tmp-ra.66))
     (undead-out
      ((tmp-ra.66 rbp)
       (tmp-ra.66 rbp)
       (tmp-ra.66 rbp)
       (tmp-ra.66 rbp)
       (tmp.59 tmp-ra.66 rbp)
       ((rax tmp.59 tmp-ra.66 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.61 tmp.59 tmp-ra.66 rbp)
       (((tmp.67 tmp.61 tmp.59 tmp-ra.66 rbp) (tmp.61 tmp.59 tmp-ra.66 rbp))
        (tmp.61 tmp.62 tmp.59 tmp-ra.66 rbp)
        (tmp.61 tmp.62 tmp.59 tmp-ra.66 rbp))
       ((rax tmp.59 tmp-ra.66 rbp)
        ((tmp.61 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.60 tmp.59 tmp-ra.66 rbp)
       (tmp.59 tmp-ra.66 rsi rbp)
       (tmp-ra.66 rsi rdi rbp)
       (rsi rdi r15 rbp)
       (rsi rdi r15 rbp)))
     (conflicts
      ((tmp-ra.66
        (rdi
         rsi
         tmp.60
         tmp.67
         tmp.62
         tmp.61
         rax
         tmp.59
         error2.7
         empty1.8
         ascii-char0.9
         rbp))
       (ascii-char0.9 (rbp tmp-ra.66))
       (empty1.8 (rbp tmp-ra.66))
       (error2.7 (rbp tmp-ra.66))
       (tmp.59 (rsi tmp.60 tmp.67 tmp.62 tmp.61 rax rbp tmp-ra.66))
       (tmp.61 (rsi tmp.67 tmp.62 rbp tmp-ra.66 tmp.59))
       (tmp.62 (rbp tmp-ra.66 tmp.59 tmp.61))
       (tmp.67 (rbp tmp-ra.66 tmp.59 tmp.61))
       (tmp.60 (rbp tmp-ra.66 tmp.59))
       (rbp
        (tmp.60
         tmp.67
         tmp.62
         tmp.61
         r15
         rdi
         rsi
         rax
         tmp.59
         error2.7
         empty1.8
         ascii-char0.9
         tmp-ra.66))
       (rax (rbp tmp-ra.66 tmp.59))
       (rsi (tmp-ra.66 tmp.59 tmp.61 r15 rdi rbp))
       (rdi (tmp-ra.66 r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
    (define L.fun/ascii-char8467.4
      ((new-frames ())
       (locals (oprand1.1 oprand0.2 tmp-ra.63))
       (undead-out
        ((rdi rsi tmp-ra.63 rbp)
         (rsi oprand0.2 tmp-ra.63 rbp)
         (oprand0.2 tmp-ra.63 rbp)
         (tmp-ra.63 rax rbp)
         (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.63 (rax oprand1.1 oprand0.2 rbp rsi rdi))
         (oprand0.2 (oprand1.1 rbp tmp-ra.63 rsi))
         (oprand1.1 (rbp tmp-ra.63 oprand0.2))
         (rdi (tmp-ra.63))
         (rsi (oprand0.2 tmp-ra.63))
         (rbp (rax oprand1.1 oprand0.2 tmp-ra.63))
         (rax (rbp tmp-ra.63)))))
      (begin
        (set! tmp-ra.63 r15)
        (set! oprand0.2 rdi)
        (set! oprand1.1 rsi)
        (set! rax oprand0.2)
        (jump tmp-ra.63 rbp rax)))
    (define L.fun/void8469.5
      ((new-frames ())
       (locals (oprand1.3 oprand0.4 tmp-ra.64))
       (undead-out
        ((rdi rsi tmp-ra.64 rbp)
         (rsi tmp-ra.64 rbp)
         (tmp-ra.64 rbp)
         (tmp-ra.64 rax rbp)
         (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.64 (rax oprand1.3 oprand0.4 rbp rsi rdi))
         (oprand0.4 (rbp tmp-ra.64 rsi))
         (oprand1.3 (rbp tmp-ra.64))
         (rdi (tmp-ra.64))
         (rsi (oprand0.4 tmp-ra.64))
         (rbp (rax oprand1.3 oprand0.4 tmp-ra.64))
         (rax (rbp tmp-ra.64)))))
      (begin
        (set! tmp-ra.64 r15)
        (set! oprand0.4 rdi)
        (set! oprand1.3 rsi)
        (set! rax 30)
        (jump tmp-ra.64 rbp rax)))
    (define L.fun/empty8468.6
      ((new-frames ())
       (locals (oprand1.5 oprand0.6 tmp-ra.65))
       (undead-out
        ((rdi rsi tmp-ra.65 rbp)
         (rsi tmp-ra.65 rbp)
         (tmp-ra.65 rbp)
         (tmp-ra.65 rax rbp)
         (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.65 (rax oprand1.5 oprand0.6 rbp rsi rdi))
         (oprand0.6 (rbp tmp-ra.65 rsi))
         (oprand1.5 (rbp tmp-ra.65))
         (rdi (tmp-ra.65))
         (rsi (oprand0.6 tmp-ra.65))
         (rbp (rax oprand1.5 oprand0.6 tmp-ra.65))
         (rax (rbp tmp-ra.65)))))
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
       tmp-ra.70))
     (call-undead (tmp.62 tmp-ra.70))
     (undead-out
      ((tmp-ra.70 rbp)
       (((tmp.78 tmp-ra.70 rbp) (tmp-ra.70 rbp))
        (tmp.63 tmp-ra.70 rbp)
        (tmp.63 tmp-ra.70 rbp))
       (((tmp.79 tmp.63 tmp-ra.70 rbp) (tmp.63 tmp-ra.70 rbp))
        (tmp.63 tmp.64 tmp-ra.70 rbp)
        (tmp.63 tmp.64 tmp-ra.70 rbp))
       ((rax tmp-ra.70 rbp)
        ((tmp.63 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.62 tmp-ra.70 rbp)
       (((tmp.80 tmp.62 tmp-ra.70 rbp) (tmp.62 tmp-ra.70 rbp))
        (tmp.66 tmp.62 tmp-ra.70 rbp)
        (tmp.66 tmp.62 tmp-ra.70 rbp))
       (tmp.66 tmp.62 tmp-ra.70 rbp)
       (tmp.66 tmp.62 tmp-ra.70 rbp)
       (tmp.66 tmp.62 tmp-ra.70 rbp)
       (tmp.66 tmp.67 tmp.62 tmp-ra.70 rbp)
       ((rax tmp.62 tmp-ra.70 rbp)
        ((tmp.66 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.65 tmp.62 tmp-ra.70 rbp)
       (tmp.62 tmp-ra.70 rsi rbp)
       (tmp-ra.70 rsi rdi rbp)
       (rsi rdi r15 rbp)
       (rsi rdi r15 rbp)))
     (conflicts
      ((tmp-ra.70
        (rdi
         rsi
         tmp.65
         tmp.67
         empty2.1
         error1.2
         ascii-char0.3
         tmp.80
         tmp.66
         tmp.62
         rax
         tmp.79
         tmp.64
         tmp.78
         tmp.63
         rbp))
       (tmp.63 (rsi tmp.79 tmp.64 rbp tmp-ra.70))
       (tmp.78 (rbp tmp-ra.70))
       (tmp.64 (rbp tmp-ra.70 tmp.63))
       (tmp.79 (rbp tmp-ra.70 tmp.63))
       (tmp.62
        (rsi
         tmp.65
         rax
         tmp.67
         empty2.1
         error1.2
         ascii-char0.3
         tmp.80
         tmp.66
         rbp
         tmp-ra.70))
       (tmp.66
        (rsi tmp.67 empty2.1 error1.2 ascii-char0.3 rbp tmp-ra.70 tmp.62))
       (tmp.80 (rbp tmp-ra.70 tmp.62))
       (ascii-char0.3 (rbp tmp-ra.70 tmp.62 tmp.66))
       (error1.2 (rbp tmp-ra.70 tmp.62 tmp.66))
       (empty2.1 (rbp tmp-ra.70 tmp.62 tmp.66))
       (tmp.67 (rbp tmp-ra.70 tmp.62 tmp.66))
       (tmp.65 (rbp tmp-ra.70 tmp.62))
       (rbp
        (tmp.65
         tmp.67
         empty2.1
         error1.2
         ascii-char0.3
         tmp.80
         tmp.66
         tmp.62
         r15
         rdi
         rsi
         rax
         tmp.79
         tmp.64
         tmp.78
         tmp.63
         tmp-ra.70))
       (rax (tmp.62 rbp tmp-ra.70))
       (rsi (tmp-ra.70 tmp.62 tmp.66 r15 rdi rbp tmp.63))
       (rdi (tmp-ra.70 r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
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
         tmp.53))
       (undead-out
        ((rdi rsi tmp-ra.68 rbp)
         (rsi tmp.17 tmp-ra.68 rbp)
         (tmp.18 tmp.17 tmp-ra.68 rbp)
         ((((((tmp.71 tmp.18 tmp.17 tmp-ra.68 rbp)
              (tmp.71 tmp.18 tmp.17 tmp-ra.68 rbp)
              (tmp.54 tmp.18 tmp.17 tmp-ra.68 rbp))
             (tmp.18 tmp.17 tmp-ra.68 rbp))
            (tmp.53 tmp.18 tmp.17 tmp-ra.68 rbp)
            (tmp.53 tmp.18 tmp.17 tmp-ra.68 rbp))
           (tmp.18 tmp.17 tmp-ra.68 rbp))
          ((((((tmp.72 tmp.18 tmp.17 tmp-ra.68 rbp)
               (tmp.72 tmp.18 tmp.17 tmp-ra.68 rbp)
               (tmp.56 tmp.18 tmp.17 tmp-ra.68 rbp))
              (tmp.18 tmp.17 tmp-ra.68 rbp))
             (tmp.55 tmp.18 tmp.17 tmp-ra.68 rbp)
             (tmp.55 tmp.18 tmp.17 tmp-ra.68 rbp))
            (tmp.18 tmp.17 tmp-ra.68 rbp))
           ((tmp.73 tmp.17 tmp-ra.68 rbp)
            (tmp.73 tmp.17 tmp-ra.68 rbp)
            (tmp.17 tmp.57 tmp-ra.68 rbp)
            (tmp.57 tmp.74 tmp-ra.68 rbp)
            (tmp.74 tmp-ra.68 rbp)
            (tmp-ra.68 rax rbp)
            (rax rbp))
           ((tmp-ra.68 rax rbp) (rax rbp)))
          ((tmp-ra.68 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.53 (rbp tmp-ra.68 tmp.17 tmp.18))
         (tmp.71 (tmp.18 rbp tmp-ra.68 tmp.17))
         (tmp.18
          (rbp tmp-ra.68 tmp.17 tmp.71 tmp.54 tmp.53 tmp.72 tmp.56 tmp.55))
         (tmp.54 (rbp tmp-ra.68 tmp.17 tmp.18))
         (tmp-ra.68
          (tmp.18
           tmp.17
           rbp
           rsi
           rdi
           tmp.71
           tmp.54
           tmp.53
           tmp.72
           tmp.56
           tmp.55
           tmp.74
           tmp.57
           tmp.73
           rax))
         (tmp.73 (rbp tmp-ra.68 tmp.17))
         (tmp.57 (tmp.74 rbp tmp-ra.68 tmp.17))
         (tmp.74 (rbp tmp-ra.68 tmp.57))
         (tmp.56 (rbp tmp-ra.68 tmp.17 tmp.18))
         (tmp.17
          (tmp.18
           rbp
           tmp-ra.68
           rsi
           tmp.71
           tmp.54
           tmp.53
           tmp.72
           tmp.56
           tmp.55
           tmp.57
           tmp.73))
         (tmp.72 (tmp.17 rbp tmp-ra.68 tmp.18))
         (tmp.55 (rbp tmp-ra.68 tmp.17 tmp.18))
         (rax (rbp tmp-ra.68))
         (rbp
          (tmp.18
           tmp.17
           tmp-ra.68
           tmp.71
           tmp.54
           tmp.53
           tmp.72
           tmp.56
           tmp.55
           tmp.74
           tmp.57
           tmp.73
           rax))
         (rdi (tmp-ra.68))
         (rsi (tmp.17 tmp-ra.68)))))
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
         tmp.58))
       (undead-out
        ((rdi rsi tmp-ra.69 rbp)
         (rsi tmp.21 tmp-ra.69 rbp)
         (tmp.21 tmp.22 tmp-ra.69 rbp)
         ((((((tmp.75 tmp.21 tmp.22 tmp-ra.69 rbp)
              (tmp.75 tmp.21 tmp.22 tmp-ra.69 rbp)
              (tmp.59 tmp.21 tmp.22 tmp-ra.69 rbp))
             (tmp.21 tmp.22 tmp-ra.69 rbp))
            (tmp.58 tmp.21 tmp.22 tmp-ra.69 rbp)
            (tmp.58 tmp.21 tmp.22 tmp-ra.69 rbp))
           (tmp.21 tmp.22 tmp-ra.69 rbp))
          ((((((tmp.76 tmp.21 tmp.22 tmp-ra.69 rbp)
               (tmp.76 tmp.21 tmp.22 tmp-ra.69 rbp)
               (tmp.61 tmp.21 tmp.22 tmp-ra.69 rbp))
              (tmp.21 tmp.22 tmp-ra.69 rbp))
             (tmp.60 tmp.21 tmp.22 tmp-ra.69 rbp)
             (tmp.60 tmp.21 tmp.22 tmp-ra.69 rbp))
            (tmp.21 tmp.22 tmp-ra.69 rbp))
           ((tmp.22 tmp.77 tmp-ra.69 rbp)
            (tmp.77 tmp-ra.69 rbp)
            (tmp-ra.69 rax rbp)
            (rax rbp))
           ((tmp-ra.69 rax rbp) (rax rbp)))
          ((tmp-ra.69 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.58 (rbp tmp-ra.69 tmp.22 tmp.21))
         (tmp.75 (tmp.22 rbp tmp-ra.69 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.69
           tmp.21
           tmp.75
           tmp.59
           tmp.58
           tmp.76
           tmp.61
           tmp.60
           tmp.77))
         (tmp.59 (rbp tmp-ra.69 tmp.22 tmp.21))
         (tmp-ra.69
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.75
           tmp.59
           tmp.58
           tmp.76
           tmp.61
           tmp.60
           tmp.77
           rax))
         (tmp.77 (rbp tmp-ra.69 tmp.22))
         (tmp.61 (rbp tmp-ra.69 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.69 rsi tmp.75 tmp.59 tmp.58 tmp.76 tmp.61 tmp.60))
         (tmp.76 (tmp.21 rbp tmp-ra.69 tmp.22))
         (tmp.60 (rbp tmp-ra.69 tmp.22 tmp.21))
         (rax (rbp tmp-ra.69))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.69
           tmp.75
           tmp.59
           tmp.58
           tmp.76
           tmp.61
           tmp.60
           tmp.77
           rax))
         (rdi (tmp-ra.69))
         (rsi (tmp.21 tmp-ra.69)))))
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
     (locals (tmp.81 tmp.65 tmp.66 tmp.80 tmp-ra.71 tmp.64 tmp.63))
     (call-undead (tmp-ra.71))
     (undead-out
      ((tmp-ra.71 rbp)
       (((((rax tmp-ra.71 rbp)
           ((rdx rbp)
            (rdx rsi rbp)
            (rdx rsi rdi rbp)
            (rdx rsi rdi r15 rbp)
            (rdx rsi rdi r15 rbp)))
          (tmp.64 tmp-ra.71 rbp)
          ((rax tmp-ra.71 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
          (tmp.63 tmp-ra.71 rbp))
         (tmp-ra.71 rbp))
        (((rax tmp-ra.71 rbp)
          ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
         (tmp.65 tmp-ra.71 rbp)
         (((tmp.80 tmp.65 tmp-ra.71 rbp) (tmp.65 tmp-ra.71 rbp))
          (tmp.66 tmp.65 tmp-ra.71 rbp)
          (tmp.66 tmp.65 tmp-ra.71 rbp))
         (tmp.65 tmp-ra.71 rsi rbp)
         (tmp-ra.71 rsi rdi rbp)
         (rsi rdi r15 rbp)
         (rsi rdi r15 rbp))
        (((tmp.81 tmp-ra.71 rbp) (tmp-ra.71 rbp))
         ((tmp-ra.71 rax rbp) (rax rbp))
         ((tmp-ra.71 rax rbp) (rax rbp))))))
     (conflicts
      ((tmp.63 (rbp tmp-ra.71))
       (tmp.64 (rbp tmp-ra.71))
       (tmp-ra.71 (rbp tmp.64 tmp.63 rdi rsi tmp.80 tmp.66 tmp.65 tmp.81 rax))
       (tmp.80 (rbp tmp-ra.71 tmp.65))
       (tmp.66 (rbp tmp-ra.71 tmp.65))
       (tmp.65 (rsi tmp.80 tmp.66 rbp tmp-ra.71))
       (tmp.81 (rbp tmp-ra.71))
       (rax (rbp tmp-ra.71))
       (rbp
        (tmp-ra.71
         tmp.64
         rdx
         tmp.63
         tmp.80
         tmp.66
         tmp.65
         r15
         rdi
         rsi
         tmp.81
         rax))
       (rsi (rdx tmp-ra.71 tmp.65 r15 rdi rbp))
       (rdi (rdx tmp-ra.71 r15 rbp rsi))
       (r15 (rdx rbp rdi rsi))
       (rdx (r15 rdi rsi rbp)))))
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
         tmp.53))
       (undead-out
        ((rdi rsi tmp-ra.67 rbp)
         (rsi tmp.17 tmp-ra.67 rbp)
         (tmp.18 tmp.17 tmp-ra.67 rbp)
         ((((((tmp.72 tmp.18 tmp.17 tmp-ra.67 rbp)
              (tmp.72 tmp.18 tmp.17 tmp-ra.67 rbp)
              (tmp.54 tmp.18 tmp.17 tmp-ra.67 rbp))
             (tmp.18 tmp.17 tmp-ra.67 rbp))
            (tmp.53 tmp.18 tmp.17 tmp-ra.67 rbp)
            (tmp.53 tmp.18 tmp.17 tmp-ra.67 rbp))
           (tmp.18 tmp.17 tmp-ra.67 rbp))
          ((((((tmp.73 tmp.18 tmp.17 tmp-ra.67 rbp)
               (tmp.73 tmp.18 tmp.17 tmp-ra.67 rbp)
               (tmp.56 tmp.18 tmp.17 tmp-ra.67 rbp))
              (tmp.18 tmp.17 tmp-ra.67 rbp))
             (tmp.55 tmp.18 tmp.17 tmp-ra.67 rbp)
             (tmp.55 tmp.18 tmp.17 tmp-ra.67 rbp))
            (tmp.18 tmp.17 tmp-ra.67 rbp))
           ((tmp.74 tmp.17 tmp-ra.67 rbp)
            (tmp.74 tmp.17 tmp-ra.67 rbp)
            (tmp.17 tmp.57 tmp-ra.67 rbp)
            (tmp.57 tmp.75 tmp-ra.67 rbp)
            (tmp.75 tmp-ra.67 rbp)
            (tmp-ra.67 rax rbp)
            (rax rbp))
           ((tmp-ra.67 rax rbp) (rax rbp)))
          ((tmp-ra.67 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.53 (rbp tmp-ra.67 tmp.17 tmp.18))
         (tmp.72 (tmp.18 rbp tmp-ra.67 tmp.17))
         (tmp.18
          (rbp tmp-ra.67 tmp.17 tmp.72 tmp.54 tmp.53 tmp.73 tmp.56 tmp.55))
         (tmp.54 (rbp tmp-ra.67 tmp.17 tmp.18))
         (tmp-ra.67
          (tmp.18
           tmp.17
           rbp
           rsi
           rdi
           tmp.72
           tmp.54
           tmp.53
           tmp.73
           tmp.56
           tmp.55
           tmp.75
           tmp.57
           tmp.74
           rax))
         (tmp.74 (rbp tmp-ra.67 tmp.17))
         (tmp.57 (tmp.75 rbp tmp-ra.67 tmp.17))
         (tmp.75 (rbp tmp-ra.67 tmp.57))
         (tmp.56 (rbp tmp-ra.67 tmp.17 tmp.18))
         (tmp.17
          (tmp.18
           rbp
           tmp-ra.67
           rsi
           tmp.72
           tmp.54
           tmp.53
           tmp.73
           tmp.56
           tmp.55
           tmp.57
           tmp.74))
         (tmp.73 (tmp.17 rbp tmp-ra.67 tmp.18))
         (tmp.55 (rbp tmp-ra.67 tmp.17 tmp.18))
         (rax (rbp tmp-ra.67))
         (rbp
          (tmp.18
           tmp.17
           tmp-ra.67
           tmp.72
           tmp.54
           tmp.53
           tmp.73
           tmp.56
           tmp.55
           tmp.75
           tmp.57
           tmp.74
           rax))
         (rdi (tmp-ra.67))
         (rsi (tmp.17 tmp-ra.67)))))
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
         tmp.58))
       (undead-out
        ((rdi rsi tmp-ra.68 rbp)
         (rsi tmp.21 tmp-ra.68 rbp)
         (tmp.21 tmp.22 tmp-ra.68 rbp)
         ((((((tmp.76 tmp.21 tmp.22 tmp-ra.68 rbp)
              (tmp.76 tmp.21 tmp.22 tmp-ra.68 rbp)
              (tmp.59 tmp.21 tmp.22 tmp-ra.68 rbp))
             (tmp.21 tmp.22 tmp-ra.68 rbp))
            (tmp.58 tmp.21 tmp.22 tmp-ra.68 rbp)
            (tmp.58 tmp.21 tmp.22 tmp-ra.68 rbp))
           (tmp.21 tmp.22 tmp-ra.68 rbp))
          ((((((tmp.77 tmp.21 tmp.22 tmp-ra.68 rbp)
               (tmp.77 tmp.21 tmp.22 tmp-ra.68 rbp)
               (tmp.61 tmp.21 tmp.22 tmp-ra.68 rbp))
              (tmp.21 tmp.22 tmp-ra.68 rbp))
             (tmp.60 tmp.21 tmp.22 tmp-ra.68 rbp)
             (tmp.60 tmp.21 tmp.22 tmp-ra.68 rbp))
            (tmp.21 tmp.22 tmp-ra.68 rbp))
           ((tmp.22 tmp.78 tmp-ra.68 rbp)
            (tmp.78 tmp-ra.68 rbp)
            (tmp-ra.68 rax rbp)
            (rax rbp))
           ((tmp-ra.68 rax rbp) (rax rbp)))
          ((tmp-ra.68 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.58 (rbp tmp-ra.68 tmp.22 tmp.21))
         (tmp.76 (tmp.22 rbp tmp-ra.68 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.68
           tmp.21
           tmp.76
           tmp.59
           tmp.58
           tmp.77
           tmp.61
           tmp.60
           tmp.78))
         (tmp.59 (rbp tmp-ra.68 tmp.22 tmp.21))
         (tmp-ra.68
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.76
           tmp.59
           tmp.58
           tmp.77
           tmp.61
           tmp.60
           tmp.78
           rax))
         (tmp.78 (rbp tmp-ra.68 tmp.22))
         (tmp.61 (rbp tmp-ra.68 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.68 rsi tmp.76 tmp.59 tmp.58 tmp.77 tmp.61 tmp.60))
         (tmp.77 (tmp.21 rbp tmp-ra.68 tmp.22))
         (tmp.60 (rbp tmp-ra.68 tmp.22 tmp.21))
         (rax (rbp tmp-ra.68))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.68
           tmp.76
           tmp.59
           tmp.58
           tmp.77
           tmp.61
           tmp.60
           tmp.78
           rax))
         (rdi (tmp-ra.68))
         (rsi (tmp.21 tmp-ra.68)))))
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
      ((new-frames ())
       (locals (tmp-ra.69 tmp.79 tmp.47 tmp.62))
       (undead-out
        ((rdi tmp-ra.69 rbp)
         (tmp.47 tmp-ra.69 rbp)
         ((((tmp.79 tmp-ra.69 rbp)
            (tmp.79 tmp-ra.69 rbp)
            (tmp.62 tmp-ra.69 rbp))
           (tmp-ra.69 rbp))
          ((tmp-ra.69 rax rbp) (rax rbp))
          ((tmp-ra.69 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.62 (rbp tmp-ra.69))
         (tmp.47 (rbp tmp-ra.69))
         (tmp.79 (rbp tmp-ra.69))
         (tmp-ra.69 (tmp.47 rbp rdi tmp.79 tmp.62 rax))
         (rax (rbp tmp-ra.69))
         (rbp (tmp.47 tmp-ra.69 tmp.79 tmp.62 rax))
         (rdi (tmp-ra.69)))))
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
      ((new-frames ())
       (locals (oprand2.1 oprand1.2 oprand0.3 tmp-ra.70))
       (undead-out
        ((rdi rsi rdx tmp-ra.70 rbp)
         (rsi rdx tmp-ra.70 rbp)
         (rdx tmp-ra.70 rbp)
         (tmp-ra.70 rbp)
         (tmp-ra.70 rax rbp)
         (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.70 (rax oprand2.1 oprand1.2 oprand0.3 rbp rdx rsi rdi))
         (oprand0.3 (rbp tmp-ra.70 rdx rsi))
         (oprand1.2 (rbp tmp-ra.70 rdx))
         (oprand2.1 (rbp tmp-ra.70))
         (rdi (tmp-ra.70))
         (rsi (oprand0.3 tmp-ra.70))
         (rdx (oprand1.2 oprand0.3 tmp-ra.70))
         (rbp (rax oprand2.1 oprand1.2 oprand0.3 tmp-ra.70))
         (rax (rbp tmp-ra.70)))))
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
     (locals (ascii-char3.1 void2.2 void1.3 void0.4 tmp-ra.59))
     (call-undead (tmp-ra.59))
     (undead-out
      ((tmp-ra.59 rbp)
       ((rax tmp-ra.59 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.59 rbp)
       ((rax tmp-ra.59 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.59 rbp)
       ((rax tmp-ra.59 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.59 rbp)
       ((rax tmp-ra.59 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.59 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.59 (ascii-char3.1 void2.2 void1.3 void0.4 rax rbp))
       (void0.4 (rbp tmp-ra.59))
       (void1.3 (rbp tmp-ra.59))
       (void2.2 (rbp tmp-ra.59))
       (ascii-char3.1 (rbp tmp-ra.59))
       (rbp (ascii-char3.1 void2.2 void1.3 void0.4 r15 rax tmp-ra.59))
       (rax (rbp tmp-ra.59))
       (r15 (rbp)))))
    (define L.fun/void8780.4
      ((new-frames ())
       (locals (tmp-ra.54))
       (undead-out ((tmp-ra.54 rbp) (tmp-ra.54 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.54 (rax rbp)) (rbp (rax tmp-ra.54)) (rax (rbp tmp-ra.54)))))
      (begin (set! tmp-ra.54 r15) (set! rax 30) (jump tmp-ra.54 rbp rax)))
    (define L.fun/ascii-char8782.5
      ((new-frames ())
       (locals (tmp-ra.55))
       (undead-out ((tmp-ra.55 rbp) (tmp-ra.55 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55)))))
      (begin (set! tmp-ra.55 r15) (set! rax 25390) (jump tmp-ra.55 rbp rax)))
    (define L.fun/void8781.6
      ((new-frames ())
       (locals (tmp-ra.56))
       (undead-out ((tmp-ra.56 rbp) (tmp-ra.56 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56)))))
      (begin (set! tmp-ra.56 r15) (set! rax 30) (jump tmp-ra.56 rbp rax)))
    (define L.fun/error8783.7
      ((new-frames ())
       (locals (tmp-ra.57))
       (undead-out ((tmp-ra.57 rbp) (tmp-ra.57 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57)))))
      (begin (set! tmp-ra.57 r15) (set! rax 35646) (jump tmp-ra.57 rbp rax)))
    (define L.fun/void8779.8
      ((new-frames ())
       (locals (tmp-ra.58))
       (undead-out ((tmp-ra.58 rbp) (tmp-ra.58 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58)))))
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
       tmp-ra.77))
     (call-undead (tmp.69 tmp.67 tmp-ra.77))
     (undead-out
      ((tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.67 tmp-ra.77 rbp)
       ((rax tmp.67 tmp-ra.77 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.67 tmp.68 tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp)
        ((tmp.67 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.77 rbp)
       ((rax tmp.69 tmp-ra.77 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.70 tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.77 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.77
        (void3.1
         fixnum2.2
         tmp.70
         tmp.69
         fixnum1.3
         tmp.68
         tmp.67
         empty0.4
         rax
         rbp))
       (empty0.4 (rbp tmp-ra.77))
       (tmp.67 (rsi tmp.68 rax rbp tmp-ra.77))
       (tmp.68 (rbp tmp-ra.77 tmp.67))
       (fixnum1.3 (rbp tmp-ra.77))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.77))
       (tmp.70 (rbp tmp-ra.77 tmp.69))
       (fixnum2.2 (rbp tmp-ra.77))
       (void3.1 (rbp tmp-ra.77))
       (rbp
        (void3.1
         fixnum2.2
         tmp.70
         tmp.69
         fixnum1.3
         tmp.68
         tmp.67
         rdi
         rsi
         empty0.4
         r15
         rax
         tmp-ra.77))
       (rax (tmp.69 tmp.67 rbp tmp-ra.77))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.67 r15 rdi rbp))
       (rdi (r15 rbp rsi)))))
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
         tmp.54))
       (undead-out
        ((rdi rsi tmp-ra.71 rbp)
         (rsi tmp.18 tmp-ra.71 rbp)
         (tmp.19 tmp.18 tmp-ra.71 rbp)
         ((((((tmp.78 tmp.19 tmp.18 tmp-ra.71 rbp)
              (tmp.78 tmp.19 tmp.18 tmp-ra.71 rbp)
              (tmp.55 tmp.19 tmp.18 tmp-ra.71 rbp))
             (tmp.19 tmp.18 tmp-ra.71 rbp))
            (tmp.54 tmp.19 tmp.18 tmp-ra.71 rbp)
            (tmp.54 tmp.19 tmp.18 tmp-ra.71 rbp))
           (tmp.19 tmp.18 tmp-ra.71 rbp))
          ((((((tmp.79 tmp.19 tmp.18 tmp-ra.71 rbp)
               (tmp.79 tmp.19 tmp.18 tmp-ra.71 rbp)
               (tmp.57 tmp.19 tmp.18 tmp-ra.71 rbp))
              (tmp.19 tmp.18 tmp-ra.71 rbp))
             (tmp.56 tmp.19 tmp.18 tmp-ra.71 rbp)
             (tmp.56 tmp.19 tmp.18 tmp-ra.71 rbp))
            (tmp.19 tmp.18 tmp-ra.71 rbp))
           ((tmp.80 tmp.18 tmp-ra.71 rbp)
            (tmp.80 tmp.18 tmp-ra.71 rbp)
            (tmp.18 tmp.58 tmp-ra.71 rbp)
            (tmp.58 tmp.81 tmp-ra.71 rbp)
            (tmp.81 tmp-ra.71 rbp)
            (tmp-ra.71 rax rbp)
            (rax rbp))
           ((tmp-ra.71 rax rbp) (rax rbp)))
          ((tmp-ra.71 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.54 (rbp tmp-ra.71 tmp.18 tmp.19))
         (tmp.78 (tmp.19 rbp tmp-ra.71 tmp.18))
         (tmp.19
          (rbp tmp-ra.71 tmp.18 tmp.78 tmp.55 tmp.54 tmp.79 tmp.57 tmp.56))
         (tmp.55 (rbp tmp-ra.71 tmp.18 tmp.19))
         (tmp-ra.71
          (tmp.19
           tmp.18
           rbp
           rsi
           rdi
           tmp.78
           tmp.55
           tmp.54
           tmp.79
           tmp.57
           tmp.56
           tmp.81
           tmp.58
           tmp.80
           rax))
         (tmp.80 (rbp tmp-ra.71 tmp.18))
         (tmp.58 (tmp.81 rbp tmp-ra.71 tmp.18))
         (tmp.81 (rbp tmp-ra.71 tmp.58))
         (tmp.57 (rbp tmp-ra.71 tmp.18 tmp.19))
         (tmp.18
          (tmp.19
           rbp
           tmp-ra.71
           rsi
           tmp.78
           tmp.55
           tmp.54
           tmp.79
           tmp.57
           tmp.56
           tmp.58
           tmp.80))
         (tmp.79 (tmp.18 rbp tmp-ra.71 tmp.19))
         (tmp.56 (rbp tmp-ra.71 tmp.18 tmp.19))
         (rax (rbp tmp-ra.71))
         (rbp
          (tmp.19
           tmp.18
           tmp-ra.71
           tmp.78
           tmp.55
           tmp.54
           tmp.79
           tmp.57
           tmp.56
           tmp.81
           tmp.58
           tmp.80
           rax))
         (rdi (tmp-ra.71))
         (rsi (tmp.18 tmp-ra.71)))))
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
         tmp.59))
       (undead-out
        ((rdi rsi tmp-ra.72 rbp)
         (rsi tmp.20 tmp-ra.72 rbp)
         (tmp.20 tmp.21 tmp-ra.72 rbp)
         ((((((tmp.82 tmp.20 tmp.21 tmp-ra.72 rbp)
              (tmp.82 tmp.20 tmp.21 tmp-ra.72 rbp)
              (tmp.60 tmp.20 tmp.21 tmp-ra.72 rbp))
             (tmp.20 tmp.21 tmp-ra.72 rbp))
            (tmp.59 tmp.20 tmp.21 tmp-ra.72 rbp)
            (tmp.59 tmp.20 tmp.21 tmp-ra.72 rbp))
           (tmp.20 tmp.21 tmp-ra.72 rbp))
          ((((((tmp.83 tmp.20 tmp.21 tmp-ra.72 rbp)
               (tmp.83 tmp.20 tmp.21 tmp-ra.72 rbp)
               (tmp.62 tmp.20 tmp.21 tmp-ra.72 rbp))
              (tmp.20 tmp.21 tmp-ra.72 rbp))
             (tmp.61 tmp.20 tmp.21 tmp-ra.72 rbp)
             (tmp.61 tmp.20 tmp.21 tmp-ra.72 rbp))
            (tmp.20 tmp.21 tmp-ra.72 rbp))
           ((tmp.21 tmp.84 tmp-ra.72 rbp)
            (tmp.84 tmp-ra.72 rbp)
            (tmp-ra.72 rax rbp)
            (rax rbp))
           ((tmp-ra.72 rax rbp) (rax rbp)))
          ((tmp-ra.72 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.59 (rbp tmp-ra.72 tmp.21 tmp.20))
         (tmp.82 (tmp.21 rbp tmp-ra.72 tmp.20))
         (tmp.21
          (rbp
           tmp-ra.72
           tmp.20
           tmp.82
           tmp.60
           tmp.59
           tmp.83
           tmp.62
           tmp.61
           tmp.84))
         (tmp.60 (rbp tmp-ra.72 tmp.21 tmp.20))
         (tmp-ra.72
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.82
           tmp.60
           tmp.59
           tmp.83
           tmp.62
           tmp.61
           tmp.84
           rax))
         (tmp.84 (rbp tmp-ra.72 tmp.21))
         (tmp.62 (rbp tmp-ra.72 tmp.21 tmp.20))
         (tmp.20
          (tmp.21 rbp tmp-ra.72 rsi tmp.82 tmp.60 tmp.59 tmp.83 tmp.62 tmp.61))
         (tmp.83 (tmp.20 rbp tmp-ra.72 tmp.21))
         (tmp.61 (rbp tmp-ra.72 tmp.21 tmp.20))
         (rax (rbp tmp-ra.72))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.72
           tmp.82
           tmp.60
           tmp.59
           tmp.83
           tmp.62
           tmp.61
           tmp.84
           rax))
         (rdi (tmp-ra.72))
         (rsi (tmp.20 tmp-ra.72)))))
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
         tmp.63))
       (undead-out
        ((rdi rsi tmp-ra.73 rbp)
         (rsi tmp.22 tmp-ra.73 rbp)
         (tmp.22 tmp.23 tmp-ra.73 rbp)
         ((((((tmp.85 tmp.22 tmp.23 tmp-ra.73 rbp)
              (tmp.85 tmp.22 tmp.23 tmp-ra.73 rbp)
              (tmp.64 tmp.22 tmp.23 tmp-ra.73 rbp))
             (tmp.22 tmp.23 tmp-ra.73 rbp))
            (tmp.63 tmp.22 tmp.23 tmp-ra.73 rbp)
            (tmp.63 tmp.22 tmp.23 tmp-ra.73 rbp))
           (tmp.22 tmp.23 tmp-ra.73 rbp))
          ((((((tmp.86 tmp.22 tmp.23 tmp-ra.73 rbp)
               (tmp.86 tmp.22 tmp.23 tmp-ra.73 rbp)
               (tmp.66 tmp.22 tmp.23 tmp-ra.73 rbp))
              (tmp.22 tmp.23 tmp-ra.73 rbp))
             (tmp.65 tmp.22 tmp.23 tmp-ra.73 rbp)
             (tmp.65 tmp.22 tmp.23 tmp-ra.73 rbp))
            (tmp.22 tmp.23 tmp-ra.73 rbp))
           ((tmp.23 tmp.87 tmp-ra.73 rbp)
            (tmp.87 tmp-ra.73 rbp)
            (tmp-ra.73 rax rbp)
            (rax rbp))
           ((tmp-ra.73 rax rbp) (rax rbp)))
          ((tmp-ra.73 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.63 (rbp tmp-ra.73 tmp.23 tmp.22))
         (tmp.85 (tmp.23 rbp tmp-ra.73 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.73
           tmp.22
           tmp.85
           tmp.64
           tmp.63
           tmp.86
           tmp.66
           tmp.65
           tmp.87))
         (tmp.64 (rbp tmp-ra.73 tmp.23 tmp.22))
         (tmp-ra.73
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.85
           tmp.64
           tmp.63
           tmp.86
           tmp.66
           tmp.65
           tmp.87
           rax))
         (tmp.87 (rbp tmp-ra.73 tmp.23))
         (tmp.66 (rbp tmp-ra.73 tmp.23 tmp.22))
         (tmp.22
          (tmp.23 rbp tmp-ra.73 rsi tmp.85 tmp.64 tmp.63 tmp.86 tmp.66 tmp.65))
         (tmp.86 (tmp.22 rbp tmp-ra.73 tmp.23))
         (tmp.65 (rbp tmp-ra.73 tmp.23 tmp.22))
         (rax (rbp tmp-ra.73))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.73
           tmp.85
           tmp.64
           tmp.63
           tmp.86
           tmp.66
           tmp.65
           tmp.87
           rax))
         (rdi (tmp-ra.73))
         (rsi (tmp.22 tmp-ra.73)))))
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
      ((new-frames ())
       (locals (tmp-ra.74))
       (undead-out ((tmp-ra.74 rbp) (tmp-ra.74 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.74 (rax rbp)) (rbp (rax tmp-ra.74)) (rax (rbp tmp-ra.74)))))
      (begin (set! tmp-ra.74 r15) (set! rax 22) (jump tmp-ra.74 rbp rax)))
    (define L.fun/void8807.5
      ((new-frames ())
       (locals (tmp-ra.75))
       (undead-out ((tmp-ra.75 rbp) (tmp-ra.75 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.75 (rax rbp)) (rbp (rax tmp-ra.75)) (rax (rbp tmp-ra.75)))))
      (begin (set! tmp-ra.75 r15) (set! rax 30) (jump tmp-ra.75 rbp rax)))
    (define L.fun/ascii-char8808.6
      ((new-frames ())
       (locals (tmp-ra.76))
       (undead-out ((tmp-ra.76 rbp) (tmp-ra.76 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.76 (rax rbp)) (rbp (rax tmp-ra.76)) (rax (rbp tmp-ra.76)))))
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
       tmp-ra.90))
     (call-undead (tmp.76 tmp.74 tmp-ra.90))
     (undead-out
      ((tmp-ra.90 rbp)
       (((((rax tmp-ra.90 rbp)
           ((rdx rbp)
            (rdx rsi rbp)
            (rdx rsi rdi rbp)
            (rdx rsi rdi r15 rbp)
            (rdx rsi rdi r15 rbp)))
          (tmp.75 tmp-ra.90 rbp))
         (tmp-ra.90 rbp))
        (((tmp.97 tmp-ra.90 rbp) (tmp-ra.90 rbp))
         (tmp.74 tmp-ra.90 rbp)
         (tmp.74 tmp-ra.90 rbp))
        (((rax tmp-ra.90 rbp)
          ((rdx rbp)
           (rdx rsi rbp)
           (rdx rsi rdi rbp)
           (rdx rsi rdi r15 rbp)
           (rdx rsi rdi r15 rbp)))
         (tmp.74 tmp-ra.90 rbp)))
       ((rax tmp.74 tmp-ra.90 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp.74 tmp-ra.90 rbp)
       ((rax tmp.74 tmp-ra.90 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp-ra.90 rbp)
       ((rax tmp.74 tmp-ra.90 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.74 tmp-ra.90 rbp)
       ((rax tmp.74 tmp-ra.90 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.74 tmp-ra.90 rbp)
       ((rax tmp.74 tmp-ra.90 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp.76 tmp.74 tmp-ra.90 rbp)
       ((rax tmp.76 tmp.74 tmp-ra.90 rbp)
        ((rdx rbp)
         (rdx rsi rbp)
         (rdx rsi rdi rbp)
         (rdx rsi rdi r15 rbp)
         (rdx rsi rdi r15 rbp)))
       (tmp.76 tmp.74 tmp-ra.90 rbp)
       ((rax tmp.76 tmp.74 tmp-ra.90 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.76 tmp.74 tmp-ra.90 rbp)
       ((rax tmp.76 tmp.74 tmp-ra.90 rbp)
        ((rdx rbp)
         (rdx rsi rbp)
         (rdx rsi rdi rbp)
         (rdx rsi rdi r15 rbp)
         (rdx rsi rdi r15 rbp)))
       (tmp.76 tmp.74 tmp-ra.90 rbp)
       ((rax tmp.76 tmp.74 tmp-ra.90 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.76 tmp.74 tmp-ra.90 rbp)
       ((rax tmp.76 tmp.74 tmp-ra.90 rbp)
        ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp.77 tmp.76 tmp.74 tmp-ra.90 rbp)
       (tmp.76 tmp.74 tmp-ra.90 rdx rbp)
       (tmp.74 tmp-ra.90 rdx rsi rbp)
       (tmp-ra.90 rdx rsi rdi rbp)
       (rdx rsi rdi r15 rbp)
       (rdx rsi rdi r15 rbp)))
     (conflicts
      ((tmp-ra.90
        (rdi
         rsi
         rdx
         tmp.77
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
         tmp.97
         rax
         tmp.74
         rbp))
       (tmp.97 (rbp tmp-ra.90))
       (tmp.74
        (rsi
         rdx
         tmp.77
         empty3.14
         ascii-char2.15
         void1.16
         ascii-char0.17
         tmp.76
         error3.10
         error2.11
         fixnum1.12
         boolean0.13
         rax
         rbp
         tmp-ra.90))
       (tmp.75 (rbp tmp-ra.90))
       (boolean0.13 (rbp tmp-ra.90 tmp.74))
       (fixnum1.12 (rbp tmp-ra.90 tmp.74))
       (error2.11 (rbp tmp-ra.90 tmp.74))
       (error3.10 (rbp tmp-ra.90 tmp.74))
       (tmp.76
        (rdx
         tmp.77
         empty3.14
         ascii-char2.15
         void1.16
         ascii-char0.17
         rax
         rbp
         tmp-ra.90
         tmp.74))
       (ascii-char0.17 (rbp tmp-ra.90 tmp.74 tmp.76))
       (void1.16 (rbp tmp-ra.90 tmp.74 tmp.76))
       (ascii-char2.15 (rbp tmp-ra.90 tmp.74 tmp.76))
       (empty3.14 (rbp tmp-ra.90 tmp.74 tmp.76))
       (tmp.77 (rbp tmp-ra.90 tmp.74 tmp.76))
       (rbp
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
         tmp.97
         r15
         rdi
         rsi
         rdx
         rax
         tmp.74
         tmp-ra.90))
       (rax (tmp.76 tmp.74 rbp tmp-ra.90))
       (rdx (tmp-ra.90 tmp.74 tmp.76 r15 rdi rsi rbp))
       (rsi (tmp-ra.90 tmp.74 r15 rdi rbp rdx))
       (rdi (tmp-ra.90 r15 rbp rsi rdx))
       (r15 (rbp rdi rsi rdx)))))
    (define L.error?.16
      ((new-frames ())
       (locals (tmp-ra.78 tmp.91 tmp.59 tmp.67))
       (undead-out
        ((rdi tmp-ra.78 rbp)
         (tmp.59 tmp-ra.78 rbp)
         ((((tmp.91 tmp-ra.78 rbp)
            (tmp.91 tmp-ra.78 rbp)
            (tmp.67 tmp-ra.78 rbp))
           (tmp-ra.78 rbp))
          ((tmp-ra.78 rax rbp) (rax rbp))
          ((tmp-ra.78 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.67 (rbp tmp-ra.78))
         (tmp.59 (rbp tmp-ra.78))
         (tmp.91 (rbp tmp-ra.78))
         (tmp-ra.78 (tmp.59 rbp rdi tmp.91 tmp.67 rax))
         (rax (rbp tmp-ra.78))
         (rbp (tmp.59 tmp-ra.78 tmp.91 tmp.67 rax))
         (rdi (tmp-ra.78)))))
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
      ((new-frames ())
       (locals (tmp-ra.79 tmp.92 tmp.54 tmp.68))
       (undead-out
        ((rdi tmp-ra.79 rbp)
         (tmp.54 tmp-ra.79 rbp)
         ((((tmp.92 tmp-ra.79 rbp)
            (tmp.92 tmp-ra.79 rbp)
            (tmp.68 tmp-ra.79 rbp))
           (tmp-ra.79 rbp))
          ((tmp-ra.79 rax rbp) (rax rbp))
          ((tmp-ra.79 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.68 (rbp tmp-ra.79))
         (tmp.54 (rbp tmp-ra.79))
         (tmp.92 (rbp tmp-ra.79))
         (tmp-ra.79 (tmp.54 rbp rdi tmp.92 tmp.68 rax))
         (rax (rbp tmp-ra.79))
         (rbp (tmp.54 tmp-ra.79 tmp.92 tmp.68 rax))
         (rdi (tmp-ra.79)))))
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
         tmp.69))
       (undead-out
        ((rdi rsi tmp-ra.80 rbp)
         (rsi tmp.33 tmp-ra.80 rbp)
         (tmp.33 tmp.34 tmp-ra.80 rbp)
         ((((((tmp.93 tmp.33 tmp.34 tmp-ra.80 rbp)
              (tmp.93 tmp.33 tmp.34 tmp-ra.80 rbp)
              (tmp.70 tmp.33 tmp.34 tmp-ra.80 rbp))
             (tmp.33 tmp.34 tmp-ra.80 rbp))
            (tmp.69 tmp.33 tmp.34 tmp-ra.80 rbp)
            (tmp.69 tmp.33 tmp.34 tmp-ra.80 rbp))
           (tmp.33 tmp.34 tmp-ra.80 rbp))
          ((((((tmp.94 tmp.33 tmp.34 tmp-ra.80 rbp)
               (tmp.94 tmp.33 tmp.34 tmp-ra.80 rbp)
               (tmp.72 tmp.33 tmp.34 tmp-ra.80 rbp))
              (tmp.33 tmp.34 tmp-ra.80 rbp))
             (tmp.71 tmp.33 tmp.34 tmp-ra.80 rbp)
             (tmp.71 tmp.33 tmp.34 tmp-ra.80 rbp))
            (tmp.33 tmp.34 tmp-ra.80 rbp))
           ((tmp.34 tmp.95 tmp-ra.80 rbp)
            (tmp.95 tmp-ra.80 rbp)
            (tmp-ra.80 rax rbp)
            (rax rbp))
           ((tmp-ra.80 rax rbp) (rax rbp)))
          ((tmp-ra.80 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.69 (rbp tmp-ra.80 tmp.34 tmp.33))
         (tmp.93 (tmp.34 rbp tmp-ra.80 tmp.33))
         (tmp.34
          (rbp
           tmp-ra.80
           tmp.33
           tmp.93
           tmp.70
           tmp.69
           tmp.94
           tmp.72
           tmp.71
           tmp.95))
         (tmp.70 (rbp tmp-ra.80 tmp.34 tmp.33))
         (tmp-ra.80
          (tmp.34
           tmp.33
           rbp
           rsi
           rdi
           tmp.93
           tmp.70
           tmp.69
           tmp.94
           tmp.72
           tmp.71
           tmp.95
           rax))
         (tmp.95 (rbp tmp-ra.80 tmp.34))
         (tmp.72 (rbp tmp-ra.80 tmp.34 tmp.33))
         (tmp.33
          (tmp.34 rbp tmp-ra.80 rsi tmp.93 tmp.70 tmp.69 tmp.94 tmp.72 tmp.71))
         (tmp.94 (tmp.33 rbp tmp-ra.80 tmp.34))
         (tmp.71 (rbp tmp-ra.80 tmp.34 tmp.33))
         (rax (rbp tmp-ra.80))
         (rbp
          (tmp.34
           tmp.33
           tmp-ra.80
           tmp.93
           tmp.70
           tmp.69
           tmp.94
           tmp.72
           tmp.71
           tmp.95
           rax))
         (rdi (tmp-ra.80))
         (rsi (tmp.33 tmp-ra.80)))))
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
      ((new-frames ())
       (locals (tmp-ra.81 tmp.96 tmp.61 tmp.73))
       (undead-out
        ((rdi tmp-ra.81 rbp)
         (tmp.61 tmp-ra.81 rbp)
         ((((tmp.96 tmp-ra.81 rbp)
            (tmp.96 tmp-ra.81 rbp)
            (tmp.73 tmp-ra.81 rbp))
           (tmp-ra.81 rbp))
          ((tmp-ra.81 rax rbp) (rax rbp))
          ((tmp-ra.81 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.73 (rbp tmp-ra.81))
         (tmp.61 (rbp tmp-ra.81))
         (tmp.96 (rbp tmp-ra.81))
         (tmp-ra.81 (tmp.61 rbp rdi tmp.96 tmp.73 rax))
         (rax (rbp tmp-ra.81))
         (rbp (tmp.61 tmp-ra.81 tmp.96 tmp.73 rax))
         (rdi (tmp-ra.81)))))
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
      ((new-frames ())
       (locals (oprand2.1 oprand1.2 oprand0.3 tmp-ra.82))
       (undead-out
        ((rdi rsi rdx tmp-ra.82 rbp)
         (rsi rdx tmp-ra.82 rbp)
         (rdx tmp-ra.82 rbp)
         (tmp-ra.82 rbp)
         (tmp-ra.82 rax rbp)
         (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.82 (rax oprand2.1 oprand1.2 oprand0.3 rbp rdx rsi rdi))
         (oprand0.3 (rbp tmp-ra.82 rdx rsi))
         (oprand1.2 (rbp tmp-ra.82 rdx))
         (oprand2.1 (rbp tmp-ra.82))
         (rdi (tmp-ra.82))
         (rsi (oprand0.3 tmp-ra.82))
         (rdx (oprand1.2 oprand0.3 tmp-ra.82))
         (rbp (rax oprand2.1 oprand1.2 oprand0.3 tmp-ra.82))
         (rax (rbp tmp-ra.82)))))
      (begin
        (set! tmp-ra.82 r15)
        (set! oprand0.3 rdi)
        (set! oprand1.2 rsi)
        (set! oprand2.1 rdx)
        (set! rax 22)
        (jump tmp-ra.82 rbp rax)))
    (define L.fun/error9036.5
      ((new-frames ())
       (locals (tmp-ra.83))
       (undead-out ((tmp-ra.83 rbp) (tmp-ra.83 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83)))))
      (begin (set! tmp-ra.83 r15) (set! rax 47166) (jump tmp-ra.83 rbp rax)))
    (define L.fun/error9035.6
      ((new-frames ())
       (locals (tmp-ra.84))
       (undead-out ((tmp-ra.84 rbp) (tmp-ra.84 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.84 (rax rbp)) (rbp (rax tmp-ra.84)) (rax (rbp tmp-ra.84)))))
      (begin (set! tmp-ra.84 r15) (set! rax 36414) (jump tmp-ra.84 rbp rax)))
    (define L.fun/void9037.7
      ((new-frames ())
       (locals (tmp-ra.85))
       (undead-out ((tmp-ra.85 rbp) (tmp-ra.85 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.85 (rax rbp)) (rbp (rax tmp-ra.85)) (rax (rbp tmp-ra.85)))))
      (begin (set! tmp-ra.85 r15) (set! rax 30) (jump tmp-ra.85 rbp rax)))
    (define L.fun/ascii-char9032.8
      ((new-frames ())
       (locals (tmp-ra.86))
       (undead-out ((tmp-ra.86 rbp) (tmp-ra.86 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86)))))
      (begin (set! tmp-ra.86 r15) (set! rax 25390) (jump tmp-ra.86 rbp rax)))
    (define L.fun/empty9038.9
      ((new-frames ())
       (locals (tmp-ra.87))
       (undead-out ((tmp-ra.87 rbp) (tmp-ra.87 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.87 (rax rbp)) (rbp (rax tmp-ra.87)) (rax (rbp tmp-ra.87)))))
      (begin (set! tmp-ra.87 r15) (set! rax 22) (jump tmp-ra.87 rbp rax)))
    (define L.fun/ascii-char9031.10
      ((new-frames ())
       (locals (oprand2.4 oprand1.5 oprand0.6 tmp-ra.88))
       (undead-out
        ((rdi rsi rdx tmp-ra.88 rbp)
         (rsi rdx tmp-ra.88 rbp)
         (rdx tmp-ra.88 rbp)
         (tmp-ra.88 rbp)
         (r15 rbp)
         (r15 rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.88 (oprand2.4 oprand1.5 oprand0.6 rbp rdx rsi rdi))
         (oprand0.6 (rbp tmp-ra.88 rdx rsi))
         (oprand1.5 (rbp tmp-ra.88 rdx))
         (oprand2.4 (rbp tmp-ra.88))
         (rdi (tmp-ra.88))
         (rsi (oprand0.6 tmp-ra.88))
         (rdx (oprand1.5 oprand0.6 tmp-ra.88))
         (rbp (r15 oprand2.4 oprand1.5 oprand0.6 tmp-ra.88))
         (r15 (rbp)))))
      (begin
        (set! tmp-ra.88 r15)
        (set! oprand0.6 rdi)
        (set! oprand1.5 rsi)
        (set! oprand2.4 rdx)
        (set! r15 tmp-ra.88)
        (jump L.fun/ascii-char9032.8 rbp r15)))
    (define L.fun/boolean9033.11
      ((new-frames ())
       (locals (oprand2.7 oprand1.8 oprand0.9 tmp-ra.89))
       (undead-out
        ((rdi rsi rdx tmp-ra.89 rbp)
         (rsi rdx tmp-ra.89 rbp)
         (rdx tmp-ra.89 rbp)
         (tmp-ra.89 rbp)
         (tmp-ra.89 rax rbp)
         (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.89 (rax oprand2.7 oprand1.8 oprand0.9 rbp rdx rsi rdi))
         (oprand0.9 (rbp tmp-ra.89 rdx rsi))
         (oprand1.8 (rbp tmp-ra.89 rdx))
         (oprand2.7 (rbp tmp-ra.89))
         (rdi (tmp-ra.89))
         (rsi (oprand0.9 tmp-ra.89))
         (rdx (oprand1.8 oprand0.9 tmp-ra.89))
         (rbp (rax oprand2.7 oprand1.8 oprand0.9 tmp-ra.89))
         (rax (rbp tmp-ra.89)))))
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
     (locals (ascii-char3.1 empty2.2 void1.3 error0.4 tmp-ra.58))
     (call-undead (empty2.2 tmp-ra.58))
     (undead-out
      ((tmp-ra.58 rbp)
       ((rax tmp-ra.58 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.58 rbp)
       ((rax tmp-ra.58 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.58 rbp)
       ((rax tmp-ra.58 rbp) ((r15 rbp) (r15 rbp)))
       (empty2.2 tmp-ra.58 rbp)
       ((rax empty2.2 tmp-ra.58 rbp) ((r15 rbp) (r15 rbp)))
       (empty2.2 tmp-ra.58 rbp)
       (tmp-ra.58 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.58 (ascii-char3.1 empty2.2 void1.3 error0.4 rax rbp))
       (error0.4 (rbp tmp-ra.58))
       (void1.3 (rbp tmp-ra.58))
       (empty2.2 (ascii-char3.1 rax rbp tmp-ra.58))
       (ascii-char3.1 (rbp tmp-ra.58 empty2.2))
       (rbp (ascii-char3.1 empty2.2 void1.3 error0.4 r15 rax tmp-ra.58))
       (rax (empty2.2 rbp tmp-ra.58))
       (r15 (rbp)))))
    (define L.fun/void9076.4
      ((new-frames ())
       (locals (tmp-ra.54))
       (undead-out ((tmp-ra.54 rbp) (tmp-ra.54 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.54 (rax rbp)) (rbp (rax tmp-ra.54)) (rax (rbp tmp-ra.54)))))
      (begin (set! tmp-ra.54 r15) (set! rax 30) (jump tmp-ra.54 rbp rax)))
    (define L.fun/ascii-char9078.5
      ((new-frames ())
       (locals (tmp-ra.55))
       (undead-out ((tmp-ra.55 rbp) (tmp-ra.55 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55)))))
      (begin (set! tmp-ra.55 r15) (set! rax 25390) (jump tmp-ra.55 rbp rax)))
    (define L.fun/error9075.6
      ((new-frames ())
       (locals (tmp-ra.56))
       (undead-out ((tmp-ra.56 rbp) (tmp-ra.56 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56)))))
      (begin (set! tmp-ra.56 r15) (set! rax 57662) (jump tmp-ra.56 rbp rax)))
    (define L.fun/empty9077.7
      ((new-frames ())
       (locals (tmp-ra.57))
       (undead-out ((tmp-ra.57 rbp) (tmp-ra.57 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57)))))
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
       tmp.55))
     (call-undead ())
     (undead-out
      ((tmp-ra.54 rbp)
       ((((tmp.55 tmp-ra.54 rbp) (tmp-ra.54 rbp))
         ((tmp.56 tmp-ra.54 rbp) (tmp-ra.54 rbp))
         ((tmp.57 tmp-ra.54 rbp) (tmp-ra.54 rbp)))
        ((fixnum0.4 tmp-ra.54 rbp)
         (fixnum0.4 tmp-ra.54 rbp)
         (fixnum0.4 tmp-ra.54 rbp)
         (fixnum0.4 tmp-ra.54 rbp)
         (tmp-ra.54 rax rbp)
         (rax rbp))
        (((tmp.58 tmp-ra.54 rbp) (tmp-ra.54 rbp))
         ((tmp-ra.54 rax rbp) (rax rbp))
         ((tmp-ra.54 rax rbp) (rax rbp))))))
     (conflicts
      ((tmp.55 (rbp tmp-ra.54))
       (tmp.56 (rbp tmp-ra.54))
       (tmp.57 (rbp tmp-ra.54))
       (ascii-char3.1 (rbp tmp-ra.54 fixnum0.4))
       (void2.2 (rbp tmp-ra.54 fixnum0.4))
       (fixnum1.3 (rbp tmp-ra.54 fixnum0.4))
       (fixnum0.4 (ascii-char3.1 void2.2 fixnum1.3 rbp tmp-ra.54))
       (tmp-ra.54
        (rbp
         tmp.55
         tmp.56
         tmp.57
         ascii-char3.1
         void2.2
         fixnum1.3
         fixnum0.4
         tmp.58
         rax))
       (tmp.58 (rbp tmp-ra.54))
       (rax (rbp tmp-ra.54))
       (rbp
        (tmp-ra.54
         tmp.55
         tmp.56
         tmp.57
         ascii-char3.1
         void2.2
         fixnum1.3
         fixnum0.4
         tmp.58
         rax)))))
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
     (locals (tmp.55 error3.1 error2.2 error1.3 empty0.4 tmp-ra.62))
     (call-undead (tmp-ra.62))
     (undead-out
      ((tmp-ra.62 rbp)
       ((rax tmp-ra.62 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.62 rbp)
       ((rax tmp-ra.62 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.62 rbp)
       ((rax tmp-ra.62 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.62 rbp)
       ((rax tmp-ra.62 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.62 rbp)
       ((rax tmp-ra.62 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.55 tmp-ra.62 rbp)
       (tmp-ra.62 rdi rbp)
       (rdi r15 rbp)
       (rdi r15 rbp)))
     (conflicts
      ((tmp-ra.62 (rdi tmp.55 error3.1 error2.2 error1.3 empty0.4 rax rbp))
       (empty0.4 (rbp tmp-ra.62))
       (error1.3 (rbp tmp-ra.62))
       (error2.2 (rbp tmp-ra.62))
       (error3.1 (rbp tmp-ra.62))
       (tmp.55 (rbp tmp-ra.62))
       (rbp (rdi tmp.55 error3.1 error2.2 error1.3 empty0.4 r15 rax tmp-ra.62))
       (rax (rbp tmp-ra.62))
       (r15 (rdi rbp))
       (rdi (r15 rbp tmp-ra.62)))))
    (define L.boolean?.10
      ((new-frames ())
       (locals (tmp-ra.56 tmp.63 tmp.42 tmp.54))
       (undead-out
        ((rdi tmp-ra.56 rbp)
         (tmp.42 tmp-ra.56 rbp)
         ((((tmp.63 tmp-ra.56 rbp)
            (tmp.63 tmp-ra.56 rbp)
            (tmp.54 tmp-ra.56 rbp))
           (tmp-ra.56 rbp))
          ((tmp-ra.56 rax rbp) (rax rbp))
          ((tmp-ra.56 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.54 (rbp tmp-ra.56))
         (tmp.42 (rbp tmp-ra.56))
         (tmp.63 (rbp tmp-ra.56))
         (tmp-ra.56 (tmp.42 rbp rdi tmp.63 tmp.54 rax))
         (rax (rbp tmp-ra.56))
         (rbp (tmp.42 tmp-ra.56 tmp.63 tmp.54 rax))
         (rdi (tmp-ra.56)))))
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
      ((new-frames ())
       (locals (tmp-ra.57))
       (undead-out ((tmp-ra.57 rbp) (tmp-ra.57 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57)))))
      (begin (set! tmp-ra.57 r15) (set! rax 62014) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error9364.5
      ((new-frames ())
       (locals (tmp-ra.58))
       (undead-out ((tmp-ra.58 rbp) (tmp-ra.58 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58)))))
      (begin (set! tmp-ra.58 r15) (set! rax 63806) (jump tmp-ra.58 rbp rax)))
    (define L.fun/any9366.6
      ((new-frames ())
       (locals (tmp-ra.59))
       (undead-out ((tmp-ra.59 rbp) (tmp-ra.59 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59)))))
      (begin (set! tmp-ra.59 r15) (set! rax 14) (jump tmp-ra.59 rbp rax)))
    (define L.fun/error9363.7
      ((new-frames ())
       (locals (tmp-ra.60))
       (undead-out ((tmp-ra.60 rbp) (tmp-ra.60 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60)))))
      (begin (set! tmp-ra.60 r15) (set! rax 60990) (jump tmp-ra.60 rbp rax)))
    (define L.fun/empty9362.8
      ((new-frames ())
       (locals (tmp-ra.61))
       (undead-out ((tmp-ra.61 rbp) (tmp-ra.61 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61)))))
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
     (locals (void3.1 ascii-char2.2 void1.3 empty0.4 tmp-ra.58))
     (call-undead (void1.3 tmp-ra.58))
     (undead-out
      ((tmp-ra.58 rbp)
       ((rax tmp-ra.58 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.58 rbp)
       ((rax tmp-ra.58 rbp) ((r15 rbp) (r15 rbp)))
       (void1.3 tmp-ra.58 rbp)
       ((rax void1.3 tmp-ra.58 rbp) ((r15 rbp) (r15 rbp)))
       (void1.3 tmp-ra.58 rbp)
       ((rax void1.3 tmp-ra.58 rbp) ((r15 rbp) (r15 rbp)))
       (void1.3 tmp-ra.58 rbp)
       (tmp-ra.58 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.58 (void3.1 ascii-char2.2 void1.3 empty0.4 rax rbp))
       (empty0.4 (rbp tmp-ra.58))
       (void1.3 (void3.1 ascii-char2.2 rax rbp tmp-ra.58))
       (ascii-char2.2 (rbp tmp-ra.58 void1.3))
       (void3.1 (rbp tmp-ra.58 void1.3))
       (rbp (void3.1 ascii-char2.2 void1.3 empty0.4 r15 rax tmp-ra.58))
       (rax (void1.3 rbp tmp-ra.58))
       (r15 (rbp)))))
    (define L.fun/ascii-char9574.4
      ((new-frames ())
       (locals (tmp-ra.54))
       (undead-out ((tmp-ra.54 rbp) (tmp-ra.54 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.54 (rax rbp)) (rbp (rax tmp-ra.54)) (rax (rbp tmp-ra.54)))))
      (begin (set! tmp-ra.54 r15) (set! rax 25390) (jump tmp-ra.54 rbp rax)))
    (define L.fun/void9575.5
      ((new-frames ())
       (locals (tmp-ra.55))
       (undead-out ((tmp-ra.55 rbp) (tmp-ra.55 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55)))))
      (begin (set! tmp-ra.55 r15) (set! rax 30) (jump tmp-ra.55 rbp rax)))
    (define L.fun/void9573.6
      ((new-frames ())
       (locals (tmp-ra.56))
       (undead-out ((tmp-ra.56 rbp) (tmp-ra.56 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56)))))
      (begin (set! tmp-ra.56 r15) (set! rax 30) (jump tmp-ra.56 rbp rax)))
    (define L.fun/empty9572.7
      ((new-frames ())
       (locals (tmp-ra.57))
       (undead-out ((tmp-ra.57 rbp) (tmp-ra.57 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57)))))
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
       tmp.59))
     (call-undead ())
     (undead-out
      ((tmp-ra.58 rbp)
       (((tmp-ra.58 rbp)
         (tmp-ra.58 rbp)
         (tmp-ra.58 rbp)
         (tmp-ra.58 rbp)
         ((tmp.59 tmp-ra.58 rbp) (tmp-ra.58 rbp)))
        (((tmp.60 tmp-ra.58 rbp) (tmp-ra.58 rbp))
         ((tmp-ra.58 rax rbp) (rax rbp))
         ((tmp-ra.58 rax rbp) (rax rbp)))
        ((tmp-ra.58 rbp)
         (tmp-ra.58 rbp)
         (tmp-ra.58 rbp)
         (tmp-ra.58 rbp)
         (tmp-ra.58 rax rbp)
         (rax rbp)))))
     (conflicts
      ((tmp.59 (rbp tmp-ra.58))
       (empty0.4 (rbp tmp-ra.58))
       (fixnum1.3 (rbp tmp-ra.58))
       (void2.2 (rbp tmp-ra.58))
       (fixnum3.1 (rbp tmp-ra.58))
       (tmp-ra.58
        (rbp
         fixnum3.1
         void2.2
         fixnum1.3
         empty0.4
         tmp.59
         tmp.60
         rax
         fixnum3.5
         void2.6
         error1.7
         empty0.8))
       (tmp.60 (rbp tmp-ra.58))
       (fixnum3.5 (rbp tmp-ra.58))
       (void2.6 (rbp tmp-ra.58))
       (error1.7 (rbp tmp-ra.58))
       (empty0.8 (rbp tmp-ra.58))
       (rbp
        (tmp-ra.58
         fixnum3.1
         void2.2
         fixnum1.3
         empty0.4
         tmp.59
         tmp.60
         rax
         fixnum3.5
         void2.6
         error1.7
         empty0.8))
       (rax (rbp tmp-ra.58)))))
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
      (ascii-char3.1 fixnum2.2 tmp.64 tmp.63 ascii-char1.3 void0.4 tmp-ra.70))
     (call-undead (void0.4 tmp.63 tmp-ra.70))
     (undead-out
      ((tmp-ra.70 rbp)
       ((rax tmp-ra.70 rbp) ((r15 rbp) (r15 rbp)))
       (void0.4 tmp-ra.70 rbp)
       ((rax void0.4 tmp-ra.70 rbp) ((r15 rbp) (r15 rbp)))
       (void0.4 tmp-ra.70 rbp)
       ((rax void0.4 tmp-ra.70 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.63 void0.4 tmp-ra.70 rbp)
       ((rax tmp.63 void0.4 tmp-ra.70 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.63 tmp.64 void0.4 tmp-ra.70 rbp)
       ((rax void0.4 tmp-ra.70 rbp)
        ((tmp.63 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (void0.4 tmp-ra.70 rbp)
       ((rax void0.4 tmp-ra.70 rbp) ((r15 rbp) (r15 rbp)))
       (void0.4 tmp-ra.70 rbp)
       (tmp-ra.70 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.70
        (ascii-char3.1 fixnum2.2 tmp.64 tmp.63 ascii-char1.3 void0.4 rax rbp))
       (void0.4
        (ascii-char3.1
         fixnum2.2
         tmp.64
         tmp.63
         ascii-char1.3
         rax
         rbp
         tmp-ra.70))
       (ascii-char1.3 (rbp tmp-ra.70 void0.4))
       (tmp.63 (rsi tmp.64 rax rbp tmp-ra.70 void0.4))
       (tmp.64 (rbp tmp-ra.70 void0.4 tmp.63))
       (fixnum2.2 (rbp tmp-ra.70 void0.4))
       (ascii-char3.1 (rbp tmp-ra.70 void0.4))
       (rbp
        (ascii-char3.1
         fixnum2.2
         tmp.64
         tmp.63
         rdi
         rsi
         ascii-char1.3
         void0.4
         r15
         rax
         tmp-ra.70))
       (rax (tmp.63 void0.4 rbp tmp-ra.70))
       (r15 (rdi rsi rbp))
       (rsi (tmp.63 r15 rdi rbp))
       (rdi (r15 rbp rsi)))))
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
         tmp.54))
       (undead-out
        ((rdi rsi tmp-ra.65 rbp)
         (rsi tmp.22 tmp-ra.65 rbp)
         (tmp.22 tmp.23 tmp-ra.65 rbp)
         ((((((tmp.71 tmp.22 tmp.23 tmp-ra.65 rbp)
              (tmp.71 tmp.22 tmp.23 tmp-ra.65 rbp)
              (tmp.55 tmp.22 tmp.23 tmp-ra.65 rbp))
             (tmp.22 tmp.23 tmp-ra.65 rbp))
            (tmp.54 tmp.22 tmp.23 tmp-ra.65 rbp)
            (tmp.54 tmp.22 tmp.23 tmp-ra.65 rbp))
           (tmp.22 tmp.23 tmp-ra.65 rbp))
          ((((((tmp.72 tmp.22 tmp.23 tmp-ra.65 rbp)
               (tmp.72 tmp.22 tmp.23 tmp-ra.65 rbp)
               (tmp.57 tmp.22 tmp.23 tmp-ra.65 rbp))
              (tmp.22 tmp.23 tmp-ra.65 rbp))
             (tmp.56 tmp.22 tmp.23 tmp-ra.65 rbp)
             (tmp.56 tmp.22 tmp.23 tmp-ra.65 rbp))
            (tmp.22 tmp.23 tmp-ra.65 rbp))
           ((tmp.23 tmp.73 tmp-ra.65 rbp)
            (tmp.73 tmp-ra.65 rbp)
            (tmp-ra.65 rax rbp)
            (rax rbp))
           ((tmp-ra.65 rax rbp) (rax rbp)))
          ((tmp-ra.65 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.54 (rbp tmp-ra.65 tmp.23 tmp.22))
         (tmp.71 (tmp.23 rbp tmp-ra.65 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.65
           tmp.22
           tmp.71
           tmp.55
           tmp.54
           tmp.72
           tmp.57
           tmp.56
           tmp.73))
         (tmp.55 (rbp tmp-ra.65 tmp.23 tmp.22))
         (tmp-ra.65
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.71
           tmp.55
           tmp.54
           tmp.72
           tmp.57
           tmp.56
           tmp.73
           rax))
         (tmp.73 (rbp tmp-ra.65 tmp.23))
         (tmp.57 (rbp tmp-ra.65 tmp.23 tmp.22))
         (tmp.22
          (tmp.23 rbp tmp-ra.65 rsi tmp.71 tmp.55 tmp.54 tmp.72 tmp.57 tmp.56))
         (tmp.72 (tmp.22 rbp tmp-ra.65 tmp.23))
         (tmp.56 (rbp tmp-ra.65 tmp.23 tmp.22))
         (rax (rbp tmp-ra.65))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.65
           tmp.71
           tmp.55
           tmp.54
           tmp.72
           tmp.57
           tmp.56
           tmp.73
           rax))
         (rdi (tmp-ra.65))
         (rsi (tmp.22 tmp-ra.65)))))
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
         tmp.58))
       (undead-out
        ((rdi rsi tmp-ra.66 rbp)
         (rsi tmp.18 tmp-ra.66 rbp)
         (tmp.19 tmp.18 tmp-ra.66 rbp)
         ((((((tmp.74 tmp.19 tmp.18 tmp-ra.66 rbp)
              (tmp.74 tmp.19 tmp.18 tmp-ra.66 rbp)
              (tmp.59 tmp.19 tmp.18 tmp-ra.66 rbp))
             (tmp.19 tmp.18 tmp-ra.66 rbp))
            (tmp.58 tmp.19 tmp.18 tmp-ra.66 rbp)
            (tmp.58 tmp.19 tmp.18 tmp-ra.66 rbp))
           (tmp.19 tmp.18 tmp-ra.66 rbp))
          ((((((tmp.75 tmp.19 tmp.18 tmp-ra.66 rbp)
               (tmp.75 tmp.19 tmp.18 tmp-ra.66 rbp)
               (tmp.61 tmp.19 tmp.18 tmp-ra.66 rbp))
              (tmp.19 tmp.18 tmp-ra.66 rbp))
             (tmp.60 tmp.19 tmp.18 tmp-ra.66 rbp)
             (tmp.60 tmp.19 tmp.18 tmp-ra.66 rbp))
            (tmp.19 tmp.18 tmp-ra.66 rbp))
           ((tmp.76 tmp.18 tmp-ra.66 rbp)
            (tmp.76 tmp.18 tmp-ra.66 rbp)
            (tmp.18 tmp.62 tmp-ra.66 rbp)
            (tmp.62 tmp.77 tmp-ra.66 rbp)
            (tmp.77 tmp-ra.66 rbp)
            (tmp-ra.66 rax rbp)
            (rax rbp))
           ((tmp-ra.66 rax rbp) (rax rbp)))
          ((tmp-ra.66 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.58 (rbp tmp-ra.66 tmp.18 tmp.19))
         (tmp.74 (tmp.19 rbp tmp-ra.66 tmp.18))
         (tmp.19
          (rbp tmp-ra.66 tmp.18 tmp.74 tmp.59 tmp.58 tmp.75 tmp.61 tmp.60))
         (tmp.59 (rbp tmp-ra.66 tmp.18 tmp.19))
         (tmp-ra.66
          (tmp.19
           tmp.18
           rbp
           rsi
           rdi
           tmp.74
           tmp.59
           tmp.58
           tmp.75
           tmp.61
           tmp.60
           tmp.77
           tmp.62
           tmp.76
           rax))
         (tmp.76 (rbp tmp-ra.66 tmp.18))
         (tmp.62 (tmp.77 rbp tmp-ra.66 tmp.18))
         (tmp.77 (rbp tmp-ra.66 tmp.62))
         (tmp.61 (rbp tmp-ra.66 tmp.18 tmp.19))
         (tmp.18
          (tmp.19
           rbp
           tmp-ra.66
           rsi
           tmp.74
           tmp.59
           tmp.58
           tmp.75
           tmp.61
           tmp.60
           tmp.62
           tmp.76))
         (tmp.75 (tmp.18 rbp tmp-ra.66 tmp.19))
         (tmp.60 (rbp tmp-ra.66 tmp.18 tmp.19))
         (rax (rbp tmp-ra.66))
         (rbp
          (tmp.19
           tmp.18
           tmp-ra.66
           tmp.74
           tmp.59
           tmp.58
           tmp.75
           tmp.61
           tmp.60
           tmp.77
           tmp.62
           tmp.76
           rax))
         (rdi (tmp-ra.66))
         (rsi (tmp.18 tmp-ra.66)))))
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
      ((new-frames ())
       (locals (tmp-ra.67))
       (undead-out ((tmp-ra.67 rbp) (tmp-ra.67 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.67 (rax rbp)) (rbp (rax tmp-ra.67)) (rax (rbp tmp-ra.67)))))
      (begin (set! tmp-ra.67 r15) (set! rax 25390) (jump tmp-ra.67 rbp rax)))
    (define L.fun/void9902.5
      ((new-frames ())
       (locals (tmp-ra.68))
       (undead-out ((tmp-ra.68 rbp) (tmp-ra.68 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.68 (rax rbp)) (rbp (rax tmp-ra.68)) (rax (rbp tmp-ra.68)))))
      (begin (set! tmp-ra.68 r15) (set! rax 30) (jump tmp-ra.68 rbp rax)))
    (define L.fun/ascii-char9903.6
      ((new-frames ())
       (locals (tmp-ra.69))
       (undead-out ((tmp-ra.69 rbp) (tmp-ra.69 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.69 (rax rbp)) (rbp (rax tmp-ra.69)) (rax (rbp tmp-ra.69)))))
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
       tmp-ra.87))
     (call-undead (tmp.69 tmp.68 tmp.75 tmp.74 tmp.78 tmp.72 tmp-ra.87))
     (undead-out
      ((tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.87 rbp)
       ((rax tmp.69 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.70 tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp-ra.87 rbp)
       ((rax tmp.68 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.68 tmp-ra.87 rbp)
       ((rax tmp.72 tmp.68 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.73 tmp.68 tmp-ra.87 rbp)
       ((rax tmp.68 tmp-ra.87 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp.71 tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((tmp.68 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp-ra.87 rbp)
       ((rax tmp.75 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp.76 tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((tmp.75 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp-ra.87 rbp)
       ((rax tmp.74 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.74 tmp-ra.87 rbp)
       ((rax tmp.78 tmp.74 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.79 tmp.74 tmp-ra.87 rbp)
       ((rax tmp.74 tmp-ra.87 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.77 tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.87 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.87
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
         rax
         rbp))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.87))
       (tmp.70 (rbp tmp-ra.87 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.87))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.87 tmp.68))
       (tmp.73 (rbp tmp-ra.87 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.87 tmp.68))
       (fixnum0.5 (rbp tmp-ra.87))
       (void1.4 (rbp tmp-ra.87))
       (empty2.3 (rbp tmp-ra.87))
       (void3.2 (rbp tmp-ra.87))
       (tmp.75 (rsi tmp.76 rax rbp tmp-ra.87))
       (tmp.76 (rbp tmp-ra.87 tmp.75))
       (tmp.74 (rsi tmp.77 tmp.79 tmp.78 rax rbp tmp-ra.87))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.87 tmp.74))
       (tmp.79 (rbp tmp-ra.87 tmp.74 tmp.78))
       (tmp.77 (rbp tmp-ra.87 tmp.74))
       (fixnum4.1 (rbp tmp-ra.87))
       (rbp
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
         r15
         rdi
         rsi
         rax
         tmp-ra.87))
       (rax (tmp.78 tmp.74 tmp.75 tmp.72 tmp.68 tmp.69 rbp tmp-ra.87))
       (rsi (tmp.74 tmp.78 tmp.75 tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
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
         tmp.55))
       (undead-out
        ((rdi rsi tmp-ra.80 rbp)
         (rsi tmp.19 tmp-ra.80 rbp)
         (tmp.20 tmp.19 tmp-ra.80 rbp)
         ((((((tmp.88 tmp.20 tmp.19 tmp-ra.80 rbp)
              (tmp.88 tmp.20 tmp.19 tmp-ra.80 rbp)
              (tmp.56 tmp.20 tmp.19 tmp-ra.80 rbp))
             (tmp.20 tmp.19 tmp-ra.80 rbp))
            (tmp.55 tmp.20 tmp.19 tmp-ra.80 rbp)
            (tmp.55 tmp.20 tmp.19 tmp-ra.80 rbp))
           (tmp.20 tmp.19 tmp-ra.80 rbp))
          ((((((tmp.89 tmp.20 tmp.19 tmp-ra.80 rbp)
               (tmp.89 tmp.20 tmp.19 tmp-ra.80 rbp)
               (tmp.58 tmp.20 tmp.19 tmp-ra.80 rbp))
              (tmp.20 tmp.19 tmp-ra.80 rbp))
             (tmp.57 tmp.20 tmp.19 tmp-ra.80 rbp)
             (tmp.57 tmp.20 tmp.19 tmp-ra.80 rbp))
            (tmp.20 tmp.19 tmp-ra.80 rbp))
           ((tmp.90 tmp.19 tmp-ra.80 rbp)
            (tmp.90 tmp.19 tmp-ra.80 rbp)
            (tmp.19 tmp.59 tmp-ra.80 rbp)
            (tmp.59 tmp.91 tmp-ra.80 rbp)
            (tmp.91 tmp-ra.80 rbp)
            (tmp-ra.80 rax rbp)
            (rax rbp))
           ((tmp-ra.80 rax rbp) (rax rbp)))
          ((tmp-ra.80 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.80 tmp.19 tmp.20))
         (tmp.88 (tmp.20 rbp tmp-ra.80 tmp.19))
         (tmp.20
          (rbp tmp-ra.80 tmp.19 tmp.88 tmp.56 tmp.55 tmp.89 tmp.58 tmp.57))
         (tmp.56 (rbp tmp-ra.80 tmp.19 tmp.20))
         (tmp-ra.80
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.88
           tmp.56
           tmp.55
           tmp.89
           tmp.58
           tmp.57
           tmp.91
           tmp.59
           tmp.90
           rax))
         (tmp.90 (rbp tmp-ra.80 tmp.19))
         (tmp.59 (tmp.91 rbp tmp-ra.80 tmp.19))
         (tmp.91 (rbp tmp-ra.80 tmp.59))
         (tmp.58 (rbp tmp-ra.80 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.80
           rsi
           tmp.88
           tmp.56
           tmp.55
           tmp.89
           tmp.58
           tmp.57
           tmp.59
           tmp.90))
         (tmp.89 (tmp.19 rbp tmp-ra.80 tmp.20))
         (tmp.57 (rbp tmp-ra.80 tmp.19 tmp.20))
         (rax (rbp tmp-ra.80))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.80
           tmp.88
           tmp.56
           tmp.55
           tmp.89
           tmp.58
           tmp.57
           tmp.91
           tmp.59
           tmp.90
           rax))
         (rdi (tmp-ra.80))
         (rsi (tmp.19 tmp-ra.80)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.81 rbp)
         (rsi tmp.23 tmp-ra.81 rbp)
         (tmp.23 tmp.24 tmp-ra.81 rbp)
         ((((((tmp.92 tmp.23 tmp.24 tmp-ra.81 rbp)
              (tmp.92 tmp.23 tmp.24 tmp-ra.81 rbp)
              (tmp.61 tmp.23 tmp.24 tmp-ra.81 rbp))
             (tmp.23 tmp.24 tmp-ra.81 rbp))
            (tmp.60 tmp.23 tmp.24 tmp-ra.81 rbp)
            (tmp.60 tmp.23 tmp.24 tmp-ra.81 rbp))
           (tmp.23 tmp.24 tmp-ra.81 rbp))
          ((((((tmp.93 tmp.23 tmp.24 tmp-ra.81 rbp)
               (tmp.93 tmp.23 tmp.24 tmp-ra.81 rbp)
               (tmp.63 tmp.23 tmp.24 tmp-ra.81 rbp))
              (tmp.23 tmp.24 tmp-ra.81 rbp))
             (tmp.62 tmp.23 tmp.24 tmp-ra.81 rbp)
             (tmp.62 tmp.23 tmp.24 tmp-ra.81 rbp))
            (tmp.23 tmp.24 tmp-ra.81 rbp))
           ((tmp.24 tmp.94 tmp-ra.81 rbp)
            (tmp.94 tmp-ra.81 rbp)
            (tmp-ra.81 rax rbp)
            (rax rbp))
           ((tmp-ra.81 rax rbp) (rax rbp)))
          ((tmp-ra.81 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.81 tmp.24 tmp.23))
         (tmp.92 (tmp.24 rbp tmp-ra.81 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.81
           tmp.23
           tmp.92
           tmp.61
           tmp.60
           tmp.93
           tmp.63
           tmp.62
           tmp.94))
         (tmp.61 (rbp tmp-ra.81 tmp.24 tmp.23))
         (tmp-ra.81
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.92
           tmp.61
           tmp.60
           tmp.93
           tmp.63
           tmp.62
           tmp.94
           rax))
         (tmp.94 (rbp tmp-ra.81 tmp.24))
         (tmp.63 (rbp tmp-ra.81 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.81 rsi tmp.92 tmp.61 tmp.60 tmp.93 tmp.63 tmp.62))
         (tmp.93 (tmp.23 rbp tmp-ra.81 tmp.24))
         (tmp.62 (rbp tmp-ra.81 tmp.24 tmp.23))
         (rax (rbp tmp-ra.81))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.81
           tmp.92
           tmp.61
           tmp.60
           tmp.93
           tmp.63
           tmp.62
           tmp.94
           rax))
         (rdi (tmp-ra.81))
         (rsi (tmp.23 tmp-ra.81)))))
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
         tmp.64))
       (undead-out
        ((rdi rsi tmp-ra.82 rbp)
         (rsi tmp.21 tmp-ra.82 rbp)
         (tmp.21 tmp.22 tmp-ra.82 rbp)
         ((((((tmp.95 tmp.21 tmp.22 tmp-ra.82 rbp)
              (tmp.95 tmp.21 tmp.22 tmp-ra.82 rbp)
              (tmp.65 tmp.21 tmp.22 tmp-ra.82 rbp))
             (tmp.21 tmp.22 tmp-ra.82 rbp))
            (tmp.64 tmp.21 tmp.22 tmp-ra.82 rbp)
            (tmp.64 tmp.21 tmp.22 tmp-ra.82 rbp))
           (tmp.21 tmp.22 tmp-ra.82 rbp))
          ((((((tmp.96 tmp.21 tmp.22 tmp-ra.82 rbp)
               (tmp.96 tmp.21 tmp.22 tmp-ra.82 rbp)
               (tmp.67 tmp.21 tmp.22 tmp-ra.82 rbp))
              (tmp.21 tmp.22 tmp-ra.82 rbp))
             (tmp.66 tmp.21 tmp.22 tmp-ra.82 rbp)
             (tmp.66 tmp.21 tmp.22 tmp-ra.82 rbp))
            (tmp.21 tmp.22 tmp-ra.82 rbp))
           ((tmp.22 tmp.97 tmp-ra.82 rbp)
            (tmp.97 tmp-ra.82 rbp)
            (tmp-ra.82 rax rbp)
            (rax rbp))
           ((tmp-ra.82 rax rbp) (rax rbp)))
          ((tmp-ra.82 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.82 tmp.22 tmp.21))
         (tmp.95 (tmp.22 rbp tmp-ra.82 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.82
           tmp.21
           tmp.95
           tmp.65
           tmp.64
           tmp.96
           tmp.67
           tmp.66
           tmp.97))
         (tmp.65 (rbp tmp-ra.82 tmp.22 tmp.21))
         (tmp-ra.82
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.95
           tmp.65
           tmp.64
           tmp.96
           tmp.67
           tmp.66
           tmp.97
           rax))
         (tmp.97 (rbp tmp-ra.82 tmp.22))
         (tmp.67 (rbp tmp-ra.82 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.82 rsi tmp.95 tmp.65 tmp.64 tmp.96 tmp.67 tmp.66))
         (tmp.96 (tmp.21 rbp tmp-ra.82 tmp.22))
         (tmp.66 (rbp tmp-ra.82 tmp.22 tmp.21))
         (rax (rbp tmp-ra.82))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.82
           tmp.95
           tmp.65
           tmp.64
           tmp.96
           tmp.67
           tmp.66
           tmp.97
           rax))
         (rdi (tmp-ra.82))
         (rsi (tmp.21 tmp-ra.82)))))
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
      ((new-frames ())
       (locals (tmp-ra.83))
       (undead-out ((tmp-ra.83 rbp) (tmp-ra.83 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83)))))
      (begin (set! tmp-ra.83 r15) (set! rax 30) (jump tmp-ra.83 rbp rax)))
    (define L.fun/error10675.5
      ((new-frames ())
       (locals (tmp-ra.84))
       (undead-out ((tmp-ra.84 rbp) (tmp-ra.84 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.84 (rax rbp)) (rbp (rax tmp-ra.84)) (rax (rbp tmp-ra.84)))))
      (begin (set! tmp-ra.84 r15) (set! rax 64318) (jump tmp-ra.84 rbp rax)))
    (define L.fun/void10672.6
      ((new-frames ())
       (locals (tmp-ra.85))
       (undead-out ((tmp-ra.85 rbp) (tmp-ra.85 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.85 (rax rbp)) (rbp (rax tmp-ra.85)) (rax (rbp tmp-ra.85)))))
      (begin (set! tmp-ra.85 r15) (set! rax 30) (jump tmp-ra.85 rbp rax)))
    (define L.fun/empty10673.7
      ((new-frames ())
       (locals (tmp-ra.86))
       (undead-out ((tmp-ra.86 rbp) (tmp-ra.86 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86)))))
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
       tmp-ra.78))
     (call-undead (tmp.66 tmp.65 tmp.69 empty2.3 tmp-ra.78))
     (undead-out
      ((tmp-ra.78 rbp)
       ((rax tmp-ra.78 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.78 rbp)
       ((rax tmp-ra.78 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.64 tmp-ra.78 rbp)
       ((rax tmp-ra.78 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp-ra.78 rbp)
       ((rax tmp-ra.78 rbp) ((r15 rbp) (r15 rbp)))
       (empty2.3 tmp-ra.78 rbp)
       ((rax empty2.3 tmp-ra.78 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.66 empty2.3 tmp-ra.78 rbp)
       ((rax tmp.66 empty2.3 tmp-ra.78 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.66 tmp.67 empty2.3 tmp-ra.78 rbp)
       ((rax empty2.3 tmp-ra.78 rbp)
        ((tmp.66 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.65 empty2.3 tmp-ra.78 rbp)
       ((rax tmp.65 empty2.3 tmp-ra.78 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.65 empty2.3 tmp-ra.78 rbp)
       ((rax tmp.69 tmp.65 empty2.3 tmp-ra.78 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.70 tmp.65 empty2.3 tmp-ra.78 rbp)
       ((rax tmp.65 empty2.3 tmp-ra.78 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.65 tmp.68 empty2.3 tmp-ra.78 rbp)
       ((rax empty2.3 tmp-ra.78 rbp)
        ((tmp.65 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (empty2.3 tmp-ra.78 rbp)
       ((rax empty2.3 tmp-ra.78 rbp) ((r15 rbp) (r15 rbp)))
       (empty2.3 tmp-ra.78 rbp)
       (tmp-ra.78 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.78
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
         rax
         rbp))
       (ascii-char0.5 (rbp tmp-ra.78))
       (tmp.64 (rbp tmp-ra.78))
       (boolean1.4 (rbp tmp-ra.78))
       (empty2.3
        (void4.1
         fixnum3.2
         tmp.68
         tmp.70
         tmp.69
         tmp.65
         tmp.67
         tmp.66
         rax
         rbp
         tmp-ra.78))
       (tmp.66 (rsi tmp.67 rax rbp tmp-ra.78 empty2.3))
       (tmp.67 (rbp tmp-ra.78 empty2.3 tmp.66))
       (tmp.65 (rsi tmp.68 tmp.70 tmp.69 rax rbp tmp-ra.78 empty2.3))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.78 empty2.3 tmp.65))
       (tmp.70 (rbp tmp-ra.78 empty2.3 tmp.65 tmp.69))
       (tmp.68 (rbp tmp-ra.78 empty2.3 tmp.65))
       (fixnum3.2 (rbp tmp-ra.78 empty2.3))
       (void4.1 (rbp tmp-ra.78 empty2.3))
       (rbp
        (void4.1
         fixnum3.2
         tmp.68
         tmp.70
         tmp.69
         tmp.65
         tmp.67
         tmp.66
         rsi
         empty2.3
         boolean1.4
         rdi
         tmp.64
         ascii-char0.5
         r15
         rax
         tmp-ra.78))
       (rax (tmp.69 tmp.65 tmp.66 empty2.3 rbp tmp-ra.78))
       (r15 (rsi rdi rbp))
       (rdi (rsi r15 rbp))
       (rsi (tmp.65 tmp.69 tmp.66 r15 rdi rbp)))))
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
         tmp.55))
       (undead-out
        ((rdi rsi tmp-ra.71 rbp)
         (rsi tmp.23 tmp-ra.71 rbp)
         (tmp.23 tmp.24 tmp-ra.71 rbp)
         ((((((tmp.79 tmp.23 tmp.24 tmp-ra.71 rbp)
              (tmp.79 tmp.23 tmp.24 tmp-ra.71 rbp)
              (tmp.56 tmp.23 tmp.24 tmp-ra.71 rbp))
             (tmp.23 tmp.24 tmp-ra.71 rbp))
            (tmp.55 tmp.23 tmp.24 tmp-ra.71 rbp)
            (tmp.55 tmp.23 tmp.24 tmp-ra.71 rbp))
           (tmp.23 tmp.24 tmp-ra.71 rbp))
          ((((((tmp.80 tmp.23 tmp.24 tmp-ra.71 rbp)
               (tmp.80 tmp.23 tmp.24 tmp-ra.71 rbp)
               (tmp.58 tmp.23 tmp.24 tmp-ra.71 rbp))
              (tmp.23 tmp.24 tmp-ra.71 rbp))
             (tmp.57 tmp.23 tmp.24 tmp-ra.71 rbp)
             (tmp.57 tmp.23 tmp.24 tmp-ra.71 rbp))
            (tmp.23 tmp.24 tmp-ra.71 rbp))
           ((tmp.24 tmp.81 tmp-ra.71 rbp)
            (tmp.81 tmp-ra.71 rbp)
            (tmp-ra.71 rax rbp)
            (rax rbp))
           ((tmp-ra.71 rax rbp) (rax rbp)))
          ((tmp-ra.71 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.71 tmp.24 tmp.23))
         (tmp.79 (tmp.24 rbp tmp-ra.71 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.71
           tmp.23
           tmp.79
           tmp.56
           tmp.55
           tmp.80
           tmp.58
           tmp.57
           tmp.81))
         (tmp.56 (rbp tmp-ra.71 tmp.24 tmp.23))
         (tmp-ra.71
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.79
           tmp.56
           tmp.55
           tmp.80
           tmp.58
           tmp.57
           tmp.81
           rax))
         (tmp.81 (rbp tmp-ra.71 tmp.24))
         (tmp.58 (rbp tmp-ra.71 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.71 rsi tmp.79 tmp.56 tmp.55 tmp.80 tmp.58 tmp.57))
         (tmp.80 (tmp.23 rbp tmp-ra.71 tmp.24))
         (tmp.57 (rbp tmp-ra.71 tmp.24 tmp.23))
         (rax (rbp tmp-ra.71))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.71
           tmp.79
           tmp.56
           tmp.55
           tmp.80
           tmp.58
           tmp.57
           tmp.81
           rax))
         (rdi (tmp-ra.71))
         (rsi (tmp.23 tmp-ra.71)))))
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
         tmp.59))
       (undead-out
        ((rdi rsi tmp-ra.72 rbp)
         (rsi tmp.21 tmp-ra.72 rbp)
         (tmp.21 tmp.22 tmp-ra.72 rbp)
         ((((((tmp.82 tmp.21 tmp.22 tmp-ra.72 rbp)
              (tmp.82 tmp.21 tmp.22 tmp-ra.72 rbp)
              (tmp.60 tmp.21 tmp.22 tmp-ra.72 rbp))
             (tmp.21 tmp.22 tmp-ra.72 rbp))
            (tmp.59 tmp.21 tmp.22 tmp-ra.72 rbp)
            (tmp.59 tmp.21 tmp.22 tmp-ra.72 rbp))
           (tmp.21 tmp.22 tmp-ra.72 rbp))
          ((((((tmp.83 tmp.21 tmp.22 tmp-ra.72 rbp)
               (tmp.83 tmp.21 tmp.22 tmp-ra.72 rbp)
               (tmp.62 tmp.21 tmp.22 tmp-ra.72 rbp))
              (tmp.21 tmp.22 tmp-ra.72 rbp))
             (tmp.61 tmp.21 tmp.22 tmp-ra.72 rbp)
             (tmp.61 tmp.21 tmp.22 tmp-ra.72 rbp))
            (tmp.21 tmp.22 tmp-ra.72 rbp))
           ((tmp.22 tmp.84 tmp-ra.72 rbp)
            (tmp.84 tmp-ra.72 rbp)
            (tmp-ra.72 rax rbp)
            (rax rbp))
           ((tmp-ra.72 rax rbp) (rax rbp)))
          ((tmp-ra.72 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.59 (rbp tmp-ra.72 tmp.22 tmp.21))
         (tmp.82 (tmp.22 rbp tmp-ra.72 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.72
           tmp.21
           tmp.82
           tmp.60
           tmp.59
           tmp.83
           tmp.62
           tmp.61
           tmp.84))
         (tmp.60 (rbp tmp-ra.72 tmp.22 tmp.21))
         (tmp-ra.72
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.82
           tmp.60
           tmp.59
           tmp.83
           tmp.62
           tmp.61
           tmp.84
           rax))
         (tmp.84 (rbp tmp-ra.72 tmp.22))
         (tmp.62 (rbp tmp-ra.72 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.72 rsi tmp.82 tmp.60 tmp.59 tmp.83 tmp.62 tmp.61))
         (tmp.83 (tmp.21 rbp tmp-ra.72 tmp.22))
         (tmp.61 (rbp tmp-ra.72 tmp.22 tmp.21))
         (rax (rbp tmp-ra.72))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.72
           tmp.82
           tmp.60
           tmp.59
           tmp.83
           tmp.62
           tmp.61
           tmp.84
           rax))
         (rdi (tmp-ra.72))
         (rsi (tmp.21 tmp-ra.72)))))
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
      ((new-frames ())
       (locals (tmp-ra.73 tmp.85 tmp.46 tmp.63))
       (undead-out
        ((rdi tmp-ra.73 rbp)
         (tmp.46 tmp-ra.73 rbp)
         ((((tmp.85 tmp-ra.73 rbp)
            (tmp.85 tmp-ra.73 rbp)
            (tmp.63 tmp-ra.73 rbp))
           (tmp-ra.73 rbp))
          ((tmp-ra.73 rax rbp) (rax rbp))
          ((tmp-ra.73 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.63 (rbp tmp-ra.73))
         (tmp.46 (rbp tmp-ra.73))
         (tmp.85 (rbp tmp-ra.73))
         (tmp-ra.73 (tmp.46 rbp rdi tmp.85 tmp.63 rax))
         (rax (rbp tmp-ra.73))
         (rbp (tmp.46 tmp-ra.73 tmp.85 tmp.63 rax))
         (rdi (tmp-ra.73)))))
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
      ((new-frames ())
       (locals (tmp-ra.74))
       (undead-out ((tmp-ra.74 rbp) (tmp-ra.74 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.74 (rax rbp)) (rbp (rax tmp-ra.74)) (rax (rbp tmp-ra.74)))))
      (begin (set! tmp-ra.74 r15) (set! rax 25390) (jump tmp-ra.74 rbp rax)))
    (define L.fun/ascii-char10854.5
      ((new-frames ())
       (locals (tmp-ra.75))
       (undead-out ((tmp-ra.75 rbp) (tmp-ra.75 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.75 (rax rbp)) (rbp (rax tmp-ra.75)) (rax (rbp tmp-ra.75)))))
      (begin (set! tmp-ra.75 r15) (set! rax 25390) (jump tmp-ra.75 rbp rax)))
    (define L.fun/empty10856.6
      ((new-frames ())
       (locals (tmp-ra.76))
       (undead-out ((tmp-ra.76 rbp) (tmp-ra.76 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.76 (rax rbp)) (rbp (rax tmp-ra.76)) (rax (rbp tmp-ra.76)))))
      (begin (set! tmp-ra.76 r15) (set! rax 22) (jump tmp-ra.76 rbp rax)))
    (define L.fun/void10857.7
      ((new-frames ())
       (locals (tmp-ra.77))
       (undead-out ((tmp-ra.77 rbp) (tmp-ra.77 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.77 (rax rbp)) (rbp (rax tmp-ra.77)) (rax (rbp tmp-ra.77)))))
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
      (ascii-char4.1 void3.2 error2.3 ascii-char1.4 ascii-char0.5 tmp-ra.60))
     (call-undead (void3.2 tmp-ra.60))
     (undead-out
      ((tmp-ra.60 rbp)
       ((rax tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.60 rbp)
       ((rax tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.60 rbp)
       ((rax tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.60 rbp)
       ((rax tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (void3.2 tmp-ra.60 rbp)
       ((rax void3.2 tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (void3.2 tmp-ra.60 rbp)
       (tmp-ra.60 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.60
        (ascii-char4.1 void3.2 error2.3 ascii-char1.4 ascii-char0.5 rax rbp))
       (ascii-char0.5 (rbp tmp-ra.60))
       (ascii-char1.4 (rbp tmp-ra.60))
       (error2.3 (rbp tmp-ra.60))
       (void3.2 (ascii-char4.1 rax rbp tmp-ra.60))
       (ascii-char4.1 (rbp tmp-ra.60 void3.2))
       (rbp
        (ascii-char4.1
         void3.2
         error2.3
         ascii-char1.4
         ascii-char0.5
         r15
         rax
         tmp-ra.60))
       (rax (void3.2 rbp tmp-ra.60))
       (r15 (rbp)))))
    (define L.fun/void11402.4
      ((new-frames ())
       (locals (tmp-ra.55))
       (undead-out ((tmp-ra.55 rbp) (tmp-ra.55 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55)))))
      (begin (set! tmp-ra.55 r15) (set! rax 30) (jump tmp-ra.55 rbp rax)))
    (define L.fun/ascii-char11403.5
      ((new-frames ())
       (locals (tmp-ra.56))
       (undead-out ((tmp-ra.56 rbp) (tmp-ra.56 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56)))))
      (begin (set! tmp-ra.56 r15) (set! rax 25390) (jump tmp-ra.56 rbp rax)))
    (define L.fun/ascii-char11400.6
      ((new-frames ())
       (locals (tmp-ra.57))
       (undead-out ((tmp-ra.57 rbp) (tmp-ra.57 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57)))))
      (begin (set! tmp-ra.57 r15) (set! rax 25390) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error11401.7
      ((new-frames ())
       (locals (tmp-ra.58))
       (undead-out ((tmp-ra.58 rbp) (tmp-ra.58 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58)))))
      (begin (set! tmp-ra.58 r15) (set! rax 15166) (jump tmp-ra.58 rbp rax)))
    (define L.fun/ascii-char11399.8
      ((new-frames ())
       (locals (tmp-ra.59))
       (undead-out ((tmp-ra.59 rbp) (tmp-ra.59 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59)))))
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
     (locals (error4.1 void3.2 ascii-char2.3 void1.4 error0.5 tmp-ra.61))
     (call-undead (tmp-ra.61))
     (undead-out
      ((tmp-ra.61 rbp)
       ((rax tmp-ra.61 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.61 rbp)
       ((rax tmp-ra.61 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.61 rbp)
       ((rax tmp-ra.61 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.61 rbp)
       ((rax tmp-ra.61 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.61 rbp)
       ((rax tmp-ra.61 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.61 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.61 (error4.1 void3.2 ascii-char2.3 void1.4 error0.5 rax rbp))
       (error0.5 (rbp tmp-ra.61))
       (void1.4 (rbp tmp-ra.61))
       (ascii-char2.3 (rbp tmp-ra.61))
       (void3.2 (rbp tmp-ra.61))
       (error4.1 (rbp tmp-ra.61))
       (rbp
        (error4.1 void3.2 ascii-char2.3 void1.4 error0.5 r15 rax tmp-ra.61))
       (rax (rbp tmp-ra.61))
       (r15 (rbp)))))
    (define L.fun/void13621.4
      ((new-frames ())
       (locals (tmp-ra.55))
       (undead-out ((tmp-ra.55 rbp) (tmp-ra.55 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55)))))
      (begin (set! tmp-ra.55 r15) (set! rax 30) (jump tmp-ra.55 rbp rax)))
    (define L.fun/ascii-char13620.5
      ((new-frames ())
       (locals (tmp-ra.56))
       (undead-out ((tmp-ra.56 rbp) (tmp-ra.56 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56)))))
      (begin (set! tmp-ra.56 r15) (set! rax 25390) (jump tmp-ra.56 rbp rax)))
    (define L.fun/empty13623.6
      ((new-frames ())
       (locals (tmp-ra.57))
       (undead-out ((tmp-ra.57 rbp) (tmp-ra.57 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57)))))
      (begin (set! tmp-ra.57 r15) (set! rax 22) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error13618.7
      ((new-frames ())
       (locals (tmp-ra.58))
       (undead-out ((tmp-ra.58 rbp) (tmp-ra.58 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58)))))
      (begin (set! tmp-ra.58 r15) (set! rax 22846) (jump tmp-ra.58 rbp rax)))
    (define L.fun/void13619.8
      ((new-frames ())
       (locals (tmp-ra.59))
       (undead-out ((tmp-ra.59 rbp) (tmp-ra.59 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59)))))
      (begin (set! tmp-ra.59 r15) (set! rax 30) (jump tmp-ra.59 rbp rax)))
    (define L.fun/error13622.9
      ((new-frames ())
       (locals (tmp-ra.60))
       (undead-out ((tmp-ra.60 rbp) (tmp-ra.60 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60)))))
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
       tmp-ra.86))
     (call-undead (tmp.69 tmp.68 tmp.75 tmp.74 tmp.78 tmp.72 tmp-ra.86))
     (undead-out
      ((tmp-ra.86 rbp)
       ((rax tmp-ra.86 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.86 rbp)
       ((rax tmp.69 tmp-ra.86 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.70 tmp-ra.86 rbp)
       ((rax tmp-ra.86 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp-ra.86 rbp)
       ((rax tmp.68 tmp-ra.86 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.68 tmp-ra.86 rbp)
       ((rax tmp.72 tmp.68 tmp-ra.86 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.73 tmp.68 tmp-ra.86 rbp)
       ((rax tmp.68 tmp-ra.86 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp.71 tmp-ra.86 rbp)
       ((rax tmp-ra.86 rbp)
        ((tmp.68 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.86 rbp)
       ((rax tmp-ra.86 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.86 rbp)
       ((rax tmp-ra.86 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp-ra.86 rbp)
       ((rax tmp.75 tmp-ra.86 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp.76 tmp-ra.86 rbp)
       ((rax tmp-ra.86 rbp)
        ((tmp.75 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp-ra.86 rbp)
       ((rax tmp.74 tmp-ra.86 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.74 tmp-ra.86 rbp)
       ((rax tmp.78 tmp.74 tmp-ra.86 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.79 tmp.74 tmp-ra.86 rbp)
       ((rax tmp.74 tmp-ra.86 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.77 tmp-ra.86 rbp)
       ((rax tmp-ra.86 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.86 rbp)
       ((rax tmp-ra.86 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.86 rbp)
       ((rax tmp-ra.86 rbp) ((r15 rbp) (r15 rbp)))
       (empty4.1 tmp-ra.86 rbp)
       (tmp-ra.86 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.86
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
         rax
         rbp))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.86))
       (tmp.70 (rbp tmp-ra.86 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.86))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.86 tmp.68))
       (tmp.73 (rbp tmp-ra.86 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.86 tmp.68))
       (fixnum0.5 (rbp tmp-ra.86))
       (ascii-char1.4 (rbp tmp-ra.86))
       (tmp.75 (rsi tmp.76 rax rbp tmp-ra.86))
       (tmp.76 (rbp tmp-ra.86 tmp.75))
       (tmp.74 (rsi tmp.77 tmp.79 tmp.78 rax rbp tmp-ra.86))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.86 tmp.74))
       (tmp.79 (rbp tmp-ra.86 tmp.74 tmp.78))
       (tmp.77 (rbp tmp-ra.86 tmp.74))
       (fixnum2.3 (rbp tmp-ra.86))
       (void3.2 (rbp tmp-ra.86))
       (empty4.1 (rbp tmp-ra.86))
       (rbp
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
         r15
         rdi
         rsi
         rax
         tmp-ra.86))
       (rax (tmp.78 tmp.74 tmp.75 tmp.72 tmp.68 tmp.69 rbp tmp-ra.86))
       (rsi (tmp.74 tmp.78 tmp.75 tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
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
         tmp.55))
       (undead-out
        ((rdi rsi tmp-ra.80 rbp)
         (rsi tmp.23 tmp-ra.80 rbp)
         (tmp.23 tmp.24 tmp-ra.80 rbp)
         ((((((tmp.87 tmp.23 tmp.24 tmp-ra.80 rbp)
              (tmp.87 tmp.23 tmp.24 tmp-ra.80 rbp)
              (tmp.56 tmp.23 tmp.24 tmp-ra.80 rbp))
             (tmp.23 tmp.24 tmp-ra.80 rbp))
            (tmp.55 tmp.23 tmp.24 tmp-ra.80 rbp)
            (tmp.55 tmp.23 tmp.24 tmp-ra.80 rbp))
           (tmp.23 tmp.24 tmp-ra.80 rbp))
          ((((((tmp.88 tmp.23 tmp.24 tmp-ra.80 rbp)
               (tmp.88 tmp.23 tmp.24 tmp-ra.80 rbp)
               (tmp.58 tmp.23 tmp.24 tmp-ra.80 rbp))
              (tmp.23 tmp.24 tmp-ra.80 rbp))
             (tmp.57 tmp.23 tmp.24 tmp-ra.80 rbp)
             (tmp.57 tmp.23 tmp.24 tmp-ra.80 rbp))
            (tmp.23 tmp.24 tmp-ra.80 rbp))
           ((tmp.24 tmp.89 tmp-ra.80 rbp)
            (tmp.89 tmp-ra.80 rbp)
            (tmp-ra.80 rax rbp)
            (rax rbp))
           ((tmp-ra.80 rax rbp) (rax rbp)))
          ((tmp-ra.80 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.80 tmp.24 tmp.23))
         (tmp.87 (tmp.24 rbp tmp-ra.80 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.80
           tmp.23
           tmp.87
           tmp.56
           tmp.55
           tmp.88
           tmp.58
           tmp.57
           tmp.89))
         (tmp.56 (rbp tmp-ra.80 tmp.24 tmp.23))
         (tmp-ra.80
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.87
           tmp.56
           tmp.55
           tmp.88
           tmp.58
           tmp.57
           tmp.89
           rax))
         (tmp.89 (rbp tmp-ra.80 tmp.24))
         (tmp.58 (rbp tmp-ra.80 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.80 rsi tmp.87 tmp.56 tmp.55 tmp.88 tmp.58 tmp.57))
         (tmp.88 (tmp.23 rbp tmp-ra.80 tmp.24))
         (tmp.57 (rbp tmp-ra.80 tmp.24 tmp.23))
         (rax (rbp tmp-ra.80))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.80
           tmp.87
           tmp.56
           tmp.55
           tmp.88
           tmp.58
           tmp.57
           tmp.89
           rax))
         (rdi (tmp-ra.80))
         (rsi (tmp.23 tmp-ra.80)))))
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
         tmp.59))
       (undead-out
        ((rdi rsi tmp-ra.81 rbp)
         (rsi tmp.21 tmp-ra.81 rbp)
         (tmp.21 tmp.22 tmp-ra.81 rbp)
         ((((((tmp.90 tmp.21 tmp.22 tmp-ra.81 rbp)
              (tmp.90 tmp.21 tmp.22 tmp-ra.81 rbp)
              (tmp.60 tmp.21 tmp.22 tmp-ra.81 rbp))
             (tmp.21 tmp.22 tmp-ra.81 rbp))
            (tmp.59 tmp.21 tmp.22 tmp-ra.81 rbp)
            (tmp.59 tmp.21 tmp.22 tmp-ra.81 rbp))
           (tmp.21 tmp.22 tmp-ra.81 rbp))
          ((((((tmp.91 tmp.21 tmp.22 tmp-ra.81 rbp)
               (tmp.91 tmp.21 tmp.22 tmp-ra.81 rbp)
               (tmp.62 tmp.21 tmp.22 tmp-ra.81 rbp))
              (tmp.21 tmp.22 tmp-ra.81 rbp))
             (tmp.61 tmp.21 tmp.22 tmp-ra.81 rbp)
             (tmp.61 tmp.21 tmp.22 tmp-ra.81 rbp))
            (tmp.21 tmp.22 tmp-ra.81 rbp))
           ((tmp.22 tmp.92 tmp-ra.81 rbp)
            (tmp.92 tmp-ra.81 rbp)
            (tmp-ra.81 rax rbp)
            (rax rbp))
           ((tmp-ra.81 rax rbp) (rax rbp)))
          ((tmp-ra.81 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.59 (rbp tmp-ra.81 tmp.22 tmp.21))
         (tmp.90 (tmp.22 rbp tmp-ra.81 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.81
           tmp.21
           tmp.90
           tmp.60
           tmp.59
           tmp.91
           tmp.62
           tmp.61
           tmp.92))
         (tmp.60 (rbp tmp-ra.81 tmp.22 tmp.21))
         (tmp-ra.81
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.90
           tmp.60
           tmp.59
           tmp.91
           tmp.62
           tmp.61
           tmp.92
           rax))
         (tmp.92 (rbp tmp-ra.81 tmp.22))
         (tmp.62 (rbp tmp-ra.81 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.81 rsi tmp.90 tmp.60 tmp.59 tmp.91 tmp.62 tmp.61))
         (tmp.91 (tmp.21 rbp tmp-ra.81 tmp.22))
         (tmp.61 (rbp tmp-ra.81 tmp.22 tmp.21))
         (rax (rbp tmp-ra.81))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.81
           tmp.90
           tmp.60
           tmp.59
           tmp.91
           tmp.62
           tmp.61
           tmp.92
           rax))
         (rdi (tmp-ra.81))
         (rsi (tmp.21 tmp-ra.81)))))
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
         tmp.63))
       (undead-out
        ((rdi rsi tmp-ra.82 rbp)
         (rsi tmp.19 tmp-ra.82 rbp)
         (tmp.20 tmp.19 tmp-ra.82 rbp)
         ((((((tmp.93 tmp.20 tmp.19 tmp-ra.82 rbp)
              (tmp.93 tmp.20 tmp.19 tmp-ra.82 rbp)
              (tmp.64 tmp.20 tmp.19 tmp-ra.82 rbp))
             (tmp.20 tmp.19 tmp-ra.82 rbp))
            (tmp.63 tmp.20 tmp.19 tmp-ra.82 rbp)
            (tmp.63 tmp.20 tmp.19 tmp-ra.82 rbp))
           (tmp.20 tmp.19 tmp-ra.82 rbp))
          ((((((tmp.94 tmp.20 tmp.19 tmp-ra.82 rbp)
               (tmp.94 tmp.20 tmp.19 tmp-ra.82 rbp)
               (tmp.66 tmp.20 tmp.19 tmp-ra.82 rbp))
              (tmp.20 tmp.19 tmp-ra.82 rbp))
             (tmp.65 tmp.20 tmp.19 tmp-ra.82 rbp)
             (tmp.65 tmp.20 tmp.19 tmp-ra.82 rbp))
            (tmp.20 tmp.19 tmp-ra.82 rbp))
           ((tmp.95 tmp.19 tmp-ra.82 rbp)
            (tmp.95 tmp.19 tmp-ra.82 rbp)
            (tmp.19 tmp.67 tmp-ra.82 rbp)
            (tmp.67 tmp.96 tmp-ra.82 rbp)
            (tmp.96 tmp-ra.82 rbp)
            (tmp-ra.82 rax rbp)
            (rax rbp))
           ((tmp-ra.82 rax rbp) (rax rbp)))
          ((tmp-ra.82 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.63 (rbp tmp-ra.82 tmp.19 tmp.20))
         (tmp.93 (tmp.20 rbp tmp-ra.82 tmp.19))
         (tmp.20
          (rbp tmp-ra.82 tmp.19 tmp.93 tmp.64 tmp.63 tmp.94 tmp.66 tmp.65))
         (tmp.64 (rbp tmp-ra.82 tmp.19 tmp.20))
         (tmp-ra.82
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.93
           tmp.64
           tmp.63
           tmp.94
           tmp.66
           tmp.65
           tmp.96
           tmp.67
           tmp.95
           rax))
         (tmp.95 (rbp tmp-ra.82 tmp.19))
         (tmp.67 (tmp.96 rbp tmp-ra.82 tmp.19))
         (tmp.96 (rbp tmp-ra.82 tmp.67))
         (tmp.66 (rbp tmp-ra.82 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.82
           rsi
           tmp.93
           tmp.64
           tmp.63
           tmp.94
           tmp.66
           tmp.65
           tmp.67
           tmp.95))
         (tmp.94 (tmp.19 rbp tmp-ra.82 tmp.20))
         (tmp.65 (rbp tmp-ra.82 tmp.19 tmp.20))
         (rax (rbp tmp-ra.82))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.82
           tmp.93
           tmp.64
           tmp.63
           tmp.94
           tmp.66
           tmp.65
           tmp.96
           tmp.67
           tmp.95
           rax))
         (rdi (tmp-ra.82))
         (rsi (tmp.19 tmp-ra.82)))))
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
      ((new-frames ())
       (locals (tmp-ra.83))
       (undead-out ((tmp-ra.83 rbp) (tmp-ra.83 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83)))))
      (begin (set! tmp-ra.83 r15) (set! rax 30) (jump tmp-ra.83 rbp rax)))
    (define L.fun/empty14229.5
      ((new-frames ())
       (locals (tmp-ra.84))
       (undead-out ((tmp-ra.84 rbp) (tmp-ra.84 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.84 (rax rbp)) (rbp (rax tmp-ra.84)) (rax (rbp tmp-ra.84)))))
      (begin (set! tmp-ra.84 r15) (set! rax 22) (jump tmp-ra.84 rbp rax)))
    (define L.fun/ascii-char14227.6
      ((new-frames ())
       (locals (tmp-ra.85))
       (undead-out ((tmp-ra.85 rbp) (tmp-ra.85 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.85 (rax rbp)) (rbp (rax tmp-ra.85)) (rax (rbp tmp-ra.85)))))
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
       tmp-ra.82))
     (call-undead (tmp.69 tmp.68 tmp.72 tmp-ra.82))
     (undead-out
      ((tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.82 rbp)
       ((rax tmp.69 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.70 tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp-ra.82 rbp)
       ((rax tmp.68 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.68 tmp-ra.82 rbp)
       ((rax tmp.72 tmp.68 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.73 tmp.68 tmp-ra.82 rbp)
       ((rax tmp.68 tmp-ra.82 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp.71 tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp)
        ((tmp.68 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.82
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
         rax
         rbp))
       (error0.5 (rbp tmp-ra.82))
       (empty1.4 (rbp tmp-ra.82))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.82))
       (tmp.70 (rbp tmp-ra.82 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.82))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.82 tmp.68))
       (tmp.73 (rbp tmp-ra.82 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.82 tmp.68))
       (fixnum2.3 (rbp tmp-ra.82))
       (void3.2 (rbp tmp-ra.82))
       (error4.1 (rbp tmp-ra.82))
       (rbp
        (error4.1
         void3.2
         fixnum2.3
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         rdi
         rsi
         empty1.4
         error0.5
         r15
         rax
         tmp-ra.82))
       (rax (tmp.72 tmp.68 tmp.69 rbp tmp-ra.82))
       (r15 (rdi rsi rbp))
       (rsi (tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi)))))
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
         tmp.55))
       (undead-out
        ((rdi rsi tmp-ra.74 rbp)
         (rsi tmp.23 tmp-ra.74 rbp)
         (tmp.23 tmp.24 tmp-ra.74 rbp)
         ((((((tmp.83 tmp.23 tmp.24 tmp-ra.74 rbp)
              (tmp.83 tmp.23 tmp.24 tmp-ra.74 rbp)
              (tmp.56 tmp.23 tmp.24 tmp-ra.74 rbp))
             (tmp.23 tmp.24 tmp-ra.74 rbp))
            (tmp.55 tmp.23 tmp.24 tmp-ra.74 rbp)
            (tmp.55 tmp.23 tmp.24 tmp-ra.74 rbp))
           (tmp.23 tmp.24 tmp-ra.74 rbp))
          ((((((tmp.84 tmp.23 tmp.24 tmp-ra.74 rbp)
               (tmp.84 tmp.23 tmp.24 tmp-ra.74 rbp)
               (tmp.58 tmp.23 tmp.24 tmp-ra.74 rbp))
              (tmp.23 tmp.24 tmp-ra.74 rbp))
             (tmp.57 tmp.23 tmp.24 tmp-ra.74 rbp)
             (tmp.57 tmp.23 tmp.24 tmp-ra.74 rbp))
            (tmp.23 tmp.24 tmp-ra.74 rbp))
           ((tmp.24 tmp.85 tmp-ra.74 rbp)
            (tmp.85 tmp-ra.74 rbp)
            (tmp-ra.74 rax rbp)
            (rax rbp))
           ((tmp-ra.74 rax rbp) (rax rbp)))
          ((tmp-ra.74 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.74 tmp.24 tmp.23))
         (tmp.83 (tmp.24 rbp tmp-ra.74 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.74
           tmp.23
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.85))
         (tmp.56 (rbp tmp-ra.74 tmp.24 tmp.23))
         (tmp-ra.74
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.85
           rax))
         (tmp.85 (rbp tmp-ra.74 tmp.24))
         (tmp.58 (rbp tmp-ra.74 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.74 rsi tmp.83 tmp.56 tmp.55 tmp.84 tmp.58 tmp.57))
         (tmp.84 (tmp.23 rbp tmp-ra.74 tmp.24))
         (tmp.57 (rbp tmp-ra.74 tmp.24 tmp.23))
         (rax (rbp tmp-ra.74))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.74
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.85
           rax))
         (rdi (tmp-ra.74))
         (rsi (tmp.23 tmp-ra.74)))))
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
         tmp.59))
       (undead-out
        ((rdi rsi tmp-ra.75 rbp)
         (rsi tmp.21 tmp-ra.75 rbp)
         (tmp.21 tmp.22 tmp-ra.75 rbp)
         ((((((tmp.86 tmp.21 tmp.22 tmp-ra.75 rbp)
              (tmp.86 tmp.21 tmp.22 tmp-ra.75 rbp)
              (tmp.60 tmp.21 tmp.22 tmp-ra.75 rbp))
             (tmp.21 tmp.22 tmp-ra.75 rbp))
            (tmp.59 tmp.21 tmp.22 tmp-ra.75 rbp)
            (tmp.59 tmp.21 tmp.22 tmp-ra.75 rbp))
           (tmp.21 tmp.22 tmp-ra.75 rbp))
          ((((((tmp.87 tmp.21 tmp.22 tmp-ra.75 rbp)
               (tmp.87 tmp.21 tmp.22 tmp-ra.75 rbp)
               (tmp.62 tmp.21 tmp.22 tmp-ra.75 rbp))
              (tmp.21 tmp.22 tmp-ra.75 rbp))
             (tmp.61 tmp.21 tmp.22 tmp-ra.75 rbp)
             (tmp.61 tmp.21 tmp.22 tmp-ra.75 rbp))
            (tmp.21 tmp.22 tmp-ra.75 rbp))
           ((tmp.22 tmp.88 tmp-ra.75 rbp)
            (tmp.88 tmp-ra.75 rbp)
            (tmp-ra.75 rax rbp)
            (rax rbp))
           ((tmp-ra.75 rax rbp) (rax rbp)))
          ((tmp-ra.75 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.59 (rbp tmp-ra.75 tmp.22 tmp.21))
         (tmp.86 (tmp.22 rbp tmp-ra.75 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.75
           tmp.21
           tmp.86
           tmp.60
           tmp.59
           tmp.87
           tmp.62
           tmp.61
           tmp.88))
         (tmp.60 (rbp tmp-ra.75 tmp.22 tmp.21))
         (tmp-ra.75
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.86
           tmp.60
           tmp.59
           tmp.87
           tmp.62
           tmp.61
           tmp.88
           rax))
         (tmp.88 (rbp tmp-ra.75 tmp.22))
         (tmp.62 (rbp tmp-ra.75 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.75 rsi tmp.86 tmp.60 tmp.59 tmp.87 tmp.62 tmp.61))
         (tmp.87 (tmp.21 rbp tmp-ra.75 tmp.22))
         (tmp.61 (rbp tmp-ra.75 tmp.22 tmp.21))
         (rax (rbp tmp-ra.75))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.75
           tmp.86
           tmp.60
           tmp.59
           tmp.87
           tmp.62
           tmp.61
           tmp.88
           rax))
         (rdi (tmp-ra.75))
         (rsi (tmp.21 tmp-ra.75)))))
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
         tmp.63))
       (undead-out
        ((rdi rsi tmp-ra.76 rbp)
         (rsi tmp.19 tmp-ra.76 rbp)
         (tmp.20 tmp.19 tmp-ra.76 rbp)
         ((((((tmp.89 tmp.20 tmp.19 tmp-ra.76 rbp)
              (tmp.89 tmp.20 tmp.19 tmp-ra.76 rbp)
              (tmp.64 tmp.20 tmp.19 tmp-ra.76 rbp))
             (tmp.20 tmp.19 tmp-ra.76 rbp))
            (tmp.63 tmp.20 tmp.19 tmp-ra.76 rbp)
            (tmp.63 tmp.20 tmp.19 tmp-ra.76 rbp))
           (tmp.20 tmp.19 tmp-ra.76 rbp))
          ((((((tmp.90 tmp.20 tmp.19 tmp-ra.76 rbp)
               (tmp.90 tmp.20 tmp.19 tmp-ra.76 rbp)
               (tmp.66 tmp.20 tmp.19 tmp-ra.76 rbp))
              (tmp.20 tmp.19 tmp-ra.76 rbp))
             (tmp.65 tmp.20 tmp.19 tmp-ra.76 rbp)
             (tmp.65 tmp.20 tmp.19 tmp-ra.76 rbp))
            (tmp.20 tmp.19 tmp-ra.76 rbp))
           ((tmp.91 tmp.19 tmp-ra.76 rbp)
            (tmp.91 tmp.19 tmp-ra.76 rbp)
            (tmp.19 tmp.67 tmp-ra.76 rbp)
            (tmp.67 tmp.92 tmp-ra.76 rbp)
            (tmp.92 tmp-ra.76 rbp)
            (tmp-ra.76 rax rbp)
            (rax rbp))
           ((tmp-ra.76 rax rbp) (rax rbp)))
          ((tmp-ra.76 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.63 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp.89 (tmp.20 rbp tmp-ra.76 tmp.19))
         (tmp.20
          (rbp tmp-ra.76 tmp.19 tmp.89 tmp.64 tmp.63 tmp.90 tmp.66 tmp.65))
         (tmp.64 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp-ra.76
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.89
           tmp.64
           tmp.63
           tmp.90
           tmp.66
           tmp.65
           tmp.92
           tmp.67
           tmp.91
           rax))
         (tmp.91 (rbp tmp-ra.76 tmp.19))
         (tmp.67 (tmp.92 rbp tmp-ra.76 tmp.19))
         (tmp.92 (rbp tmp-ra.76 tmp.67))
         (tmp.66 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.76
           rsi
           tmp.89
           tmp.64
           tmp.63
           tmp.90
           tmp.66
           tmp.65
           tmp.67
           tmp.91))
         (tmp.90 (tmp.19 rbp tmp-ra.76 tmp.20))
         (tmp.65 (rbp tmp-ra.76 tmp.19 tmp.20))
         (rax (rbp tmp-ra.76))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.76
           tmp.89
           tmp.64
           tmp.63
           tmp.90
           tmp.66
           tmp.65
           tmp.92
           tmp.67
           tmp.91
           rax))
         (rdi (tmp-ra.76))
         (rsi (tmp.19 tmp-ra.76)))))
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
      ((new-frames ())
       (locals (tmp-ra.77))
       (undead-out ((tmp-ra.77 rbp) (tmp-ra.77 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.77 (rax rbp)) (rbp (rax tmp-ra.77)) (rax (rbp tmp-ra.77)))))
      (begin (set! tmp-ra.77 r15) (set! rax 30) (jump tmp-ra.77 rbp rax)))
    (define L.fun/empty14543.5
      ((new-frames ())
       (locals (tmp-ra.78))
       (undead-out ((tmp-ra.78 rbp) (tmp-ra.78 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.78 (rax rbp)) (rbp (rax tmp-ra.78)) (rax (rbp tmp-ra.78)))))
      (begin (set! tmp-ra.78 r15) (set! rax 22) (jump tmp-ra.78 rbp rax)))
    (define L.fun/ascii-char14546.6
      ((new-frames ())
       (locals (tmp-ra.79))
       (undead-out ((tmp-ra.79 rbp) (tmp-ra.79 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.79 (rax rbp)) (rbp (rax tmp-ra.79)) (rax (rbp tmp-ra.79)))))
      (begin (set! tmp-ra.79 r15) (set! rax 25390) (jump tmp-ra.79 rbp rax)))
    (define L.fun/error14545.7
      ((new-frames ())
       (locals (tmp-ra.80))
       (undead-out ((tmp-ra.80 rbp) (tmp-ra.80 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80)))))
      (begin (set! tmp-ra.80 r15) (set! rax 62) (jump tmp-ra.80 rbp rax)))
    (define L.fun/error14542.8
      ((new-frames ())
       (locals (tmp-ra.81))
       (undead-out ((tmp-ra.81 rbp) (tmp-ra.81 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.81 (rax rbp)) (rbp (rax tmp-ra.81)) (rax (rbp tmp-ra.81)))))
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
       tmp-ra.77))
     (call-undead (tmp.65 tmp.64 tmp.68 tmp-ra.77))
     (undead-out
      ((tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.65 tmp-ra.77 rbp)
       ((rax tmp.65 tmp-ra.77 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.65 tmp.66 tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp)
        ((tmp.65 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.64 tmp-ra.77 rbp)
       ((rax tmp.64 tmp-ra.77 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp.64 tmp-ra.77 rbp)
       ((rax tmp.68 tmp.64 tmp-ra.77 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp.69 tmp.64 tmp-ra.77 rbp)
       ((rax tmp.64 tmp-ra.77 rbp)
        ((tmp.68 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.64 tmp.67 tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp)
        ((tmp.64 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.77 rbp)
       ((rax tmp-ra.77 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.77 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.77
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
         rax
         rbp))
       (tmp.65 (rsi tmp.66 rax rbp tmp-ra.77))
       (tmp.66 (rbp tmp-ra.77 tmp.65))
       (tmp.64 (rsi tmp.67 tmp.69 tmp.68 rax rbp tmp-ra.77))
       (tmp.68 (rsi tmp.69 rax rbp tmp-ra.77 tmp.64))
       (tmp.69 (rbp tmp-ra.77 tmp.64 tmp.68))
       (tmp.67 (rbp tmp-ra.77 tmp.64))
       (fixnum0.5 (rbp tmp-ra.77))
       (empty1.4 (rbp tmp-ra.77))
       (empty2.3 (rbp tmp-ra.77))
       (void3.2 (rbp tmp-ra.77))
       (error4.1 (rbp tmp-ra.77))
       (rbp
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
         r15
         rdi
         rsi
         rax
         tmp-ra.77))
       (rax (tmp.68 tmp.64 tmp.65 rbp tmp-ra.77))
       (rsi (tmp.64 tmp.68 tmp.65 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
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
         tmp.55))
       (undead-out
        ((rdi rsi tmp-ra.70 rbp)
         (rsi tmp.23 tmp-ra.70 rbp)
         (tmp.23 tmp.24 tmp-ra.70 rbp)
         ((((((tmp.78 tmp.23 tmp.24 tmp-ra.70 rbp)
              (tmp.78 tmp.23 tmp.24 tmp-ra.70 rbp)
              (tmp.56 tmp.23 tmp.24 tmp-ra.70 rbp))
             (tmp.23 tmp.24 tmp-ra.70 rbp))
            (tmp.55 tmp.23 tmp.24 tmp-ra.70 rbp)
            (tmp.55 tmp.23 tmp.24 tmp-ra.70 rbp))
           (tmp.23 tmp.24 tmp-ra.70 rbp))
          ((((((tmp.79 tmp.23 tmp.24 tmp-ra.70 rbp)
               (tmp.79 tmp.23 tmp.24 tmp-ra.70 rbp)
               (tmp.58 tmp.23 tmp.24 tmp-ra.70 rbp))
              (tmp.23 tmp.24 tmp-ra.70 rbp))
             (tmp.57 tmp.23 tmp.24 tmp-ra.70 rbp)
             (tmp.57 tmp.23 tmp.24 tmp-ra.70 rbp))
            (tmp.23 tmp.24 tmp-ra.70 rbp))
           ((tmp.24 tmp.80 tmp-ra.70 rbp)
            (tmp.80 tmp-ra.70 rbp)
            (tmp-ra.70 rax rbp)
            (rax rbp))
           ((tmp-ra.70 rax rbp) (rax rbp)))
          ((tmp-ra.70 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.70 tmp.24 tmp.23))
         (tmp.78 (tmp.24 rbp tmp-ra.70 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.70
           tmp.23
           tmp.78
           tmp.56
           tmp.55
           tmp.79
           tmp.58
           tmp.57
           tmp.80))
         (tmp.56 (rbp tmp-ra.70 tmp.24 tmp.23))
         (tmp-ra.70
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.78
           tmp.56
           tmp.55
           tmp.79
           tmp.58
           tmp.57
           tmp.80
           rax))
         (tmp.80 (rbp tmp-ra.70 tmp.24))
         (tmp.58 (rbp tmp-ra.70 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.70 rsi tmp.78 tmp.56 tmp.55 tmp.79 tmp.58 tmp.57))
         (tmp.79 (tmp.23 rbp tmp-ra.70 tmp.24))
         (tmp.57 (rbp tmp-ra.70 tmp.24 tmp.23))
         (rax (rbp tmp-ra.70))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.70
           tmp.78
           tmp.56
           tmp.55
           tmp.79
           tmp.58
           tmp.57
           tmp.80
           rax))
         (rdi (tmp-ra.70))
         (rsi (tmp.23 tmp-ra.70)))))
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
         tmp.59))
       (undead-out
        ((rdi rsi tmp-ra.71 rbp)
         (rsi tmp.19 tmp-ra.71 rbp)
         (tmp.20 tmp.19 tmp-ra.71 rbp)
         ((((((tmp.81 tmp.20 tmp.19 tmp-ra.71 rbp)
              (tmp.81 tmp.20 tmp.19 tmp-ra.71 rbp)
              (tmp.60 tmp.20 tmp.19 tmp-ra.71 rbp))
             (tmp.20 tmp.19 tmp-ra.71 rbp))
            (tmp.59 tmp.20 tmp.19 tmp-ra.71 rbp)
            (tmp.59 tmp.20 tmp.19 tmp-ra.71 rbp))
           (tmp.20 tmp.19 tmp-ra.71 rbp))
          ((((((tmp.82 tmp.20 tmp.19 tmp-ra.71 rbp)
               (tmp.82 tmp.20 tmp.19 tmp-ra.71 rbp)
               (tmp.62 tmp.20 tmp.19 tmp-ra.71 rbp))
              (tmp.20 tmp.19 tmp-ra.71 rbp))
             (tmp.61 tmp.20 tmp.19 tmp-ra.71 rbp)
             (tmp.61 tmp.20 tmp.19 tmp-ra.71 rbp))
            (tmp.20 tmp.19 tmp-ra.71 rbp))
           ((tmp.83 tmp.19 tmp-ra.71 rbp)
            (tmp.83 tmp.19 tmp-ra.71 rbp)
            (tmp.19 tmp.63 tmp-ra.71 rbp)
            (tmp.63 tmp.84 tmp-ra.71 rbp)
            (tmp.84 tmp-ra.71 rbp)
            (tmp-ra.71 rax rbp)
            (rax rbp))
           ((tmp-ra.71 rax rbp) (rax rbp)))
          ((tmp-ra.71 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.59 (rbp tmp-ra.71 tmp.19 tmp.20))
         (tmp.81 (tmp.20 rbp tmp-ra.71 tmp.19))
         (tmp.20
          (rbp tmp-ra.71 tmp.19 tmp.81 tmp.60 tmp.59 tmp.82 tmp.62 tmp.61))
         (tmp.60 (rbp tmp-ra.71 tmp.19 tmp.20))
         (tmp-ra.71
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.81
           tmp.60
           tmp.59
           tmp.82
           tmp.62
           tmp.61
           tmp.84
           tmp.63
           tmp.83
           rax))
         (tmp.83 (rbp tmp-ra.71 tmp.19))
         (tmp.63 (tmp.84 rbp tmp-ra.71 tmp.19))
         (tmp.84 (rbp tmp-ra.71 tmp.63))
         (tmp.62 (rbp tmp-ra.71 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.71
           rsi
           tmp.81
           tmp.60
           tmp.59
           tmp.82
           tmp.62
           tmp.61
           tmp.63
           tmp.83))
         (tmp.82 (tmp.19 rbp tmp-ra.71 tmp.20))
         (tmp.61 (rbp tmp-ra.71 tmp.19 tmp.20))
         (rax (rbp tmp-ra.71))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.71
           tmp.81
           tmp.60
           tmp.59
           tmp.82
           tmp.62
           tmp.61
           tmp.84
           tmp.63
           tmp.83
           rax))
         (rdi (tmp-ra.71))
         (rsi (tmp.19 tmp-ra.71)))))
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
      ((new-frames ())
       (locals (tmp-ra.72))
       (undead-out ((tmp-ra.72 rbp) (tmp-ra.72 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.72 (rax rbp)) (rbp (rax tmp-ra.72)) (rax (rbp tmp-ra.72)))))
      (begin (set! tmp-ra.72 r15) (set! rax 22) (jump tmp-ra.72 rbp rax)))
    (define L.fun/error15114.5
      ((new-frames ())
       (locals (tmp-ra.73))
       (undead-out ((tmp-ra.73 rbp) (tmp-ra.73 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.73 (rax rbp)) (rbp (rax tmp-ra.73)) (rax (rbp tmp-ra.73)))))
      (begin (set! tmp-ra.73 r15) (set! rax 11326) (jump tmp-ra.73 rbp rax)))
    (define L.fun/empty15111.6
      ((new-frames ())
       (locals (tmp-ra.74))
       (undead-out ((tmp-ra.74 rbp) (tmp-ra.74 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.74 (rax rbp)) (rbp (rax tmp-ra.74)) (rax (rbp tmp-ra.74)))))
      (begin (set! tmp-ra.74 r15) (set! rax 22) (jump tmp-ra.74 rbp rax)))
    (define L.fun/ascii-char15115.7
      ((new-frames ())
       (locals (tmp-ra.75))
       (undead-out ((tmp-ra.75 rbp) (tmp-ra.75 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.75 (rax rbp)) (rbp (rax tmp-ra.75)) (rax (rbp tmp-ra.75)))))
      (begin (set! tmp-ra.75 r15) (set! rax 25390) (jump tmp-ra.75 rbp rax)))
    (define L.fun/void15113.8
      ((new-frames ())
       (locals (tmp-ra.76))
       (undead-out ((tmp-ra.76 rbp) (tmp-ra.76 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.76 (rax rbp)) (rbp (rax tmp-ra.76)) (rax (rbp tmp-ra.76)))))
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
       tmp-ra.95))
     (call-undead
      (tmp.73
       tmp.76
       tmp.75
       tmp.85
       tmp.81
       tmp.82
       tmp.79
       tmp.69
       tmp.70
       tmp-ra.95))
     (undead-out
      ((tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp-ra.95 rbp)
       ((rax tmp.70 tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.71 tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.95 rbp)
       ((rax tmp.69 tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.73 tmp.69 tmp-ra.95 rbp)
       ((rax tmp.73 tmp.69 tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.73 tmp.74 tmp.69 tmp-ra.95 rbp)
       ((rax tmp.69 tmp-ra.95 rbp)
        ((tmp.73 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.72 tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.76 tmp-ra.95 rbp)
       ((rax tmp.76 tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.76 tmp.77 tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp)
        ((tmp.76 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp-ra.95 rbp)
       ((rax tmp.75 tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.75 tmp-ra.95 rbp)
       ((rax tmp.79 tmp.75 tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.80 tmp.75 tmp-ra.95 rbp)
       ((rax tmp.75 tmp-ra.95 rbp)
        ((tmp.79 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp.78 tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp)
        ((tmp.75 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.82 tmp-ra.95 rbp)
       ((rax tmp.82 tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.82 tmp.83 tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp)
        ((tmp.82 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp-ra.95 rbp)
       ((rax tmp.81 tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 tmp.81 tmp-ra.95 rbp)
       ((rax tmp.85 tmp.81 tmp-ra.95 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 tmp.86 tmp.81 tmp-ra.95 rbp)
       ((rax tmp.81 tmp-ra.95 rbp)
        ((tmp.85 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.84 tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp)
        ((tmp.81 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.87 tmp-ra.95 rbp)
       ((rax tmp-ra.95 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp-ra.95 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.95
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
         rax
         rbp))
       (empty0.5 (rbp tmp-ra.95))
       (tmp.70 (rsi tmp.71 rax rbp tmp-ra.95))
       (tmp.71 (rbp tmp-ra.95 tmp.70))
       (tmp.69 (rsi tmp.72 tmp.74 tmp.73 rax rbp tmp-ra.95))
       (tmp.73 (rsi tmp.74 rax rbp tmp-ra.95 tmp.69))
       (tmp.74 (rbp tmp-ra.95 tmp.69 tmp.73))
       (tmp.72 (rbp tmp-ra.95 tmp.69))
       (fixnum1.4 (rbp tmp-ra.95))
       (tmp.76 (rsi tmp.77 rax rbp tmp-ra.95))
       (tmp.77 (rbp tmp-ra.95 tmp.76))
       (tmp.75 (rsi tmp.78 tmp.80 tmp.79 rax rbp tmp-ra.95))
       (tmp.79 (rsi tmp.80 rax rbp tmp-ra.95 tmp.75))
       (tmp.80 (rbp tmp-ra.95 tmp.75 tmp.79))
       (tmp.78 (rbp tmp-ra.95 tmp.75))
       (fixnum2.3 (rbp tmp-ra.95))
       (tmp.82 (rsi tmp.83 rax rbp tmp-ra.95))
       (tmp.83 (rbp tmp-ra.95 tmp.82))
       (tmp.81 (rsi tmp.84 tmp.86 tmp.85 rax rbp tmp-ra.95))
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.95 tmp.81))
       (tmp.86 (rbp tmp-ra.95 tmp.81 tmp.85))
       (tmp.84 (rbp tmp-ra.95 tmp.81))
       (fixnum3.2 (rbp tmp-ra.95))
       (tmp.87 (rbp tmp-ra.95))
       (boolean4.1 (rbp tmp-ra.95))
       (rbp
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
         rdi
         rsi
         empty0.5
         r15
         rax
         tmp-ra.95))
       (rax
        (tmp.85
         tmp.81
         tmp.82
         tmp.79
         tmp.75
         tmp.76
         tmp.73
         tmp.69
         tmp.70
         rbp
         tmp-ra.95))
       (r15 (rdi rsi rbp))
       (rsi
        (tmp.81
         tmp.85
         tmp.82
         tmp.75
         tmp.79
         tmp.76
         tmp.69
         tmp.73
         tmp.70
         r15
         rdi
         rbp))
       (rdi (r15 rbp rsi)))))
    (define L.fixnum?.11
      ((new-frames ())
       (locals (tmp-ra.88 tmp.96 tmp.42 tmp.55))
       (undead-out
        ((rdi tmp-ra.88 rbp)
         (tmp.42 tmp-ra.88 rbp)
         ((((tmp.96 tmp-ra.88 rbp)
            (tmp.96 tmp-ra.88 rbp)
            (tmp.55 tmp-ra.88 rbp))
           (tmp-ra.88 rbp))
          ((tmp-ra.88 rax rbp) (rax rbp))
          ((tmp-ra.88 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.88))
         (tmp.42 (rbp tmp-ra.88))
         (tmp.96 (rbp tmp-ra.88))
         (tmp-ra.88 (tmp.42 rbp rdi tmp.96 tmp.55 rax))
         (rax (rbp tmp-ra.88))
         (rbp (tmp.42 tmp-ra.88 tmp.96 tmp.55 rax))
         (rdi (tmp-ra.88)))))
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
         tmp.56))
       (undead-out
        ((rdi rsi tmp-ra.89 rbp)
         (rsi tmp.23 tmp-ra.89 rbp)
         (tmp.23 tmp.24 tmp-ra.89 rbp)
         ((((((tmp.97 tmp.23 tmp.24 tmp-ra.89 rbp)
              (tmp.97 tmp.23 tmp.24 tmp-ra.89 rbp)
              (tmp.57 tmp.23 tmp.24 tmp-ra.89 rbp))
             (tmp.23 tmp.24 tmp-ra.89 rbp))
            (tmp.56 tmp.23 tmp.24 tmp-ra.89 rbp)
            (tmp.56 tmp.23 tmp.24 tmp-ra.89 rbp))
           (tmp.23 tmp.24 tmp-ra.89 rbp))
          ((((((tmp.98 tmp.23 tmp.24 tmp-ra.89 rbp)
               (tmp.98 tmp.23 tmp.24 tmp-ra.89 rbp)
               (tmp.59 tmp.23 tmp.24 tmp-ra.89 rbp))
              (tmp.23 tmp.24 tmp-ra.89 rbp))
             (tmp.58 tmp.23 tmp.24 tmp-ra.89 rbp)
             (tmp.58 tmp.23 tmp.24 tmp-ra.89 rbp))
            (tmp.23 tmp.24 tmp-ra.89 rbp))
           ((tmp.24 tmp.99 tmp-ra.89 rbp)
            (tmp.99 tmp-ra.89 rbp)
            (tmp-ra.89 rax rbp)
            (rax rbp))
           ((tmp-ra.89 rax rbp) (rax rbp)))
          ((tmp-ra.89 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.89 tmp.24 tmp.23))
         (tmp.97 (tmp.24 rbp tmp-ra.89 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.89
           tmp.23
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99))
         (tmp.57 (rbp tmp-ra.89 tmp.24 tmp.23))
         (tmp-ra.89
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99
           rax))
         (tmp.99 (rbp tmp-ra.89 tmp.24))
         (tmp.59 (rbp tmp-ra.89 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.89 rsi tmp.97 tmp.57 tmp.56 tmp.98 tmp.59 tmp.58))
         (tmp.98 (tmp.23 rbp tmp-ra.89 tmp.24))
         (tmp.58 (rbp tmp-ra.89 tmp.24 tmp.23))
         (rax (rbp tmp-ra.89))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.89
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99
           rax))
         (rdi (tmp-ra.89))
         (rsi (tmp.23 tmp-ra.89)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.90 rbp)
         (rsi tmp.21 tmp-ra.90 rbp)
         (tmp.21 tmp.22 tmp-ra.90 rbp)
         ((((((tmp.100 tmp.21 tmp.22 tmp-ra.90 rbp)
              (tmp.100 tmp.21 tmp.22 tmp-ra.90 rbp)
              (tmp.61 tmp.21 tmp.22 tmp-ra.90 rbp))
             (tmp.21 tmp.22 tmp-ra.90 rbp))
            (tmp.60 tmp.21 tmp.22 tmp-ra.90 rbp)
            (tmp.60 tmp.21 tmp.22 tmp-ra.90 rbp))
           (tmp.21 tmp.22 tmp-ra.90 rbp))
          ((((((tmp.101 tmp.21 tmp.22 tmp-ra.90 rbp)
               (tmp.101 tmp.21 tmp.22 tmp-ra.90 rbp)
               (tmp.63 tmp.21 tmp.22 tmp-ra.90 rbp))
              (tmp.21 tmp.22 tmp-ra.90 rbp))
             (tmp.62 tmp.21 tmp.22 tmp-ra.90 rbp)
             (tmp.62 tmp.21 tmp.22 tmp-ra.90 rbp))
            (tmp.21 tmp.22 tmp-ra.90 rbp))
           ((tmp.22 tmp.102 tmp-ra.90 rbp)
            (tmp.102 tmp-ra.90 rbp)
            (tmp-ra.90 rax rbp)
            (rax rbp))
           ((tmp-ra.90 rax rbp) (rax rbp)))
          ((tmp-ra.90 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.90 tmp.22 tmp.21))
         (tmp.100 (tmp.22 rbp tmp-ra.90 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.90
           tmp.21
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.102))
         (tmp.61 (rbp tmp-ra.90 tmp.22 tmp.21))
         (tmp-ra.90
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.102
           rax))
         (tmp.102 (rbp tmp-ra.90 tmp.22))
         (tmp.63 (rbp tmp-ra.90 tmp.22 tmp.21))
         (tmp.21
          (tmp.22
           rbp
           tmp-ra.90
           rsi
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62))
         (tmp.101 (tmp.21 rbp tmp-ra.90 tmp.22))
         (tmp.62 (rbp tmp-ra.90 tmp.22 tmp.21))
         (rax (rbp tmp-ra.90))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.90
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.102
           rax))
         (rdi (tmp-ra.90))
         (rsi (tmp.21 tmp-ra.90)))))
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
         tmp.64))
       (undead-out
        ((rdi rsi tmp-ra.91 rbp)
         (rsi tmp.19 tmp-ra.91 rbp)
         (tmp.20 tmp.19 tmp-ra.91 rbp)
         ((((((tmp.103 tmp.20 tmp.19 tmp-ra.91 rbp)
              (tmp.103 tmp.20 tmp.19 tmp-ra.91 rbp)
              (tmp.65 tmp.20 tmp.19 tmp-ra.91 rbp))
             (tmp.20 tmp.19 tmp-ra.91 rbp))
            (tmp.64 tmp.20 tmp.19 tmp-ra.91 rbp)
            (tmp.64 tmp.20 tmp.19 tmp-ra.91 rbp))
           (tmp.20 tmp.19 tmp-ra.91 rbp))
          ((((((tmp.104 tmp.20 tmp.19 tmp-ra.91 rbp)
               (tmp.104 tmp.20 tmp.19 tmp-ra.91 rbp)
               (tmp.67 tmp.20 tmp.19 tmp-ra.91 rbp))
              (tmp.20 tmp.19 tmp-ra.91 rbp))
             (tmp.66 tmp.20 tmp.19 tmp-ra.91 rbp)
             (tmp.66 tmp.20 tmp.19 tmp-ra.91 rbp))
            (tmp.20 tmp.19 tmp-ra.91 rbp))
           ((tmp.105 tmp.19 tmp-ra.91 rbp)
            (tmp.105 tmp.19 tmp-ra.91 rbp)
            (tmp.19 tmp.68 tmp-ra.91 rbp)
            (tmp.68 tmp.106 tmp-ra.91 rbp)
            (tmp.106 tmp-ra.91 rbp)
            (tmp-ra.91 rax rbp)
            (rax rbp))
           ((tmp-ra.91 rax rbp) (rax rbp)))
          ((tmp-ra.91 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.91 tmp.19 tmp.20))
         (tmp.103 (tmp.20 rbp tmp-ra.91 tmp.19))
         (tmp.20
          (rbp tmp-ra.91 tmp.19 tmp.103 tmp.65 tmp.64 tmp.104 tmp.67 tmp.66))
         (tmp.65 (rbp tmp-ra.91 tmp.19 tmp.20))
         (tmp-ra.91
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.103
           tmp.65
           tmp.64
           tmp.104
           tmp.67
           tmp.66
           tmp.106
           tmp.68
           tmp.105
           rax))
         (tmp.105 (rbp tmp-ra.91 tmp.19))
         (tmp.68 (tmp.106 rbp tmp-ra.91 tmp.19))
         (tmp.106 (rbp tmp-ra.91 tmp.68))
         (tmp.67 (rbp tmp-ra.91 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.91
           rsi
           tmp.103
           tmp.65
           tmp.64
           tmp.104
           tmp.67
           tmp.66
           tmp.68
           tmp.105))
         (tmp.104 (tmp.19 rbp tmp-ra.91 tmp.20))
         (tmp.66 (rbp tmp-ra.91 tmp.19 tmp.20))
         (rax (rbp tmp-ra.91))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.91
           tmp.103
           tmp.65
           tmp.64
           tmp.104
           tmp.67
           tmp.66
           tmp.106
           tmp.68
           tmp.105
           rax))
         (rdi (tmp-ra.91))
         (rsi (tmp.19 tmp-ra.91)))))
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
      ((new-frames ())
       (locals (tmp-ra.92))
       (undead-out ((tmp-ra.92 rbp) (tmp-ra.92 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.92 (rax rbp)) (rbp (rax tmp-ra.92)) (rax (rbp tmp-ra.92)))))
      (begin (set! tmp-ra.92 r15) (set! rax 22) (jump tmp-ra.92 rbp rax)))
    (define L.fun/ascii-char16027.5
      ((new-frames ())
       (locals (tmp-ra.93))
       (undead-out ((tmp-ra.93 rbp) (tmp-ra.93 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93)))))
      (begin (set! tmp-ra.93 r15) (set! rax 25390) (jump tmp-ra.93 rbp rax)))
    (define L.fun/any16026.6
      ((new-frames ())
       (locals (tmp-ra.94))
       (undead-out ((tmp-ra.94 rbp) (tmp-ra.94 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.94 (rax rbp)) (rbp (rax tmp-ra.94)) (rax (rbp tmp-ra.94)))))
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
       tmp-ra.82))
     (call-undead (tmp.72 tmp.68 tmp.69 tmp-ra.82))
     (undead-out
      ((tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.82 rbp)
       ((rax tmp.69 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.70 tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp-ra.82 rbp)
       ((rax tmp.68 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.68 tmp-ra.82 rbp)
       ((rax tmp.72 tmp.68 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.73 tmp.68 tmp-ra.82 rbp)
       ((rax tmp.68 tmp-ra.82 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.68 tmp-ra.82 rbp)
       (tmp.68 tmp-ra.82 rsi rbp)
       (tmp-ra.82 rsi rdi rbp)
       (rsi rdi r15 rbp)
       (rsi rdi r15 rbp)))
     (conflicts
      ((tmp-ra.82
        (rdi
         rsi
         tmp.71
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
         rax
         rbp))
       (void0.5 (rbp tmp-ra.82))
       (ascii-char1.4 (rbp tmp-ra.82))
       (ascii-char2.3 (rbp tmp-ra.82))
       (error3.2 (rbp tmp-ra.82))
       (error4.1 (rbp tmp-ra.82))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.82))
       (tmp.70 (rbp tmp-ra.82 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.82))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.82 tmp.68))
       (tmp.73 (rbp tmp-ra.82 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.82 tmp.68))
       (rbp
        (tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         rdi
         rsi
         error4.1
         error3.2
         ascii-char2.3
         ascii-char1.4
         void0.5
         r15
         rax
         tmp-ra.82))
       (rax (tmp.72 tmp.68 tmp.69 rbp tmp-ra.82))
       (r15 (rdi rsi rbp))
       (rsi (tmp-ra.82 tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (tmp-ra.82 r15 rbp rsi)))))
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
         tmp.55))
       (undead-out
        ((rdi rsi tmp-ra.74 rbp)
         (rsi tmp.19 tmp-ra.74 rbp)
         (tmp.20 tmp.19 tmp-ra.74 rbp)
         ((((((tmp.83 tmp.20 tmp.19 tmp-ra.74 rbp)
              (tmp.83 tmp.20 tmp.19 tmp-ra.74 rbp)
              (tmp.56 tmp.20 tmp.19 tmp-ra.74 rbp))
             (tmp.20 tmp.19 tmp-ra.74 rbp))
            (tmp.55 tmp.20 tmp.19 tmp-ra.74 rbp)
            (tmp.55 tmp.20 tmp.19 tmp-ra.74 rbp))
           (tmp.20 tmp.19 tmp-ra.74 rbp))
          ((((((tmp.84 tmp.20 tmp.19 tmp-ra.74 rbp)
               (tmp.84 tmp.20 tmp.19 tmp-ra.74 rbp)
               (tmp.58 tmp.20 tmp.19 tmp-ra.74 rbp))
              (tmp.20 tmp.19 tmp-ra.74 rbp))
             (tmp.57 tmp.20 tmp.19 tmp-ra.74 rbp)
             (tmp.57 tmp.20 tmp.19 tmp-ra.74 rbp))
            (tmp.20 tmp.19 tmp-ra.74 rbp))
           ((tmp.85 tmp.19 tmp-ra.74 rbp)
            (tmp.85 tmp.19 tmp-ra.74 rbp)
            (tmp.19 tmp.59 tmp-ra.74 rbp)
            (tmp.59 tmp.86 tmp-ra.74 rbp)
            (tmp.86 tmp-ra.74 rbp)
            (tmp-ra.74 rax rbp)
            (rax rbp))
           ((tmp-ra.74 rax rbp) (rax rbp)))
          ((tmp-ra.74 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.74 tmp.19 tmp.20))
         (tmp.83 (tmp.20 rbp tmp-ra.74 tmp.19))
         (tmp.20
          (rbp tmp-ra.74 tmp.19 tmp.83 tmp.56 tmp.55 tmp.84 tmp.58 tmp.57))
         (tmp.56 (rbp tmp-ra.74 tmp.19 tmp.20))
         (tmp-ra.74
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.86
           tmp.59
           tmp.85
           rax))
         (tmp.85 (rbp tmp-ra.74 tmp.19))
         (tmp.59 (tmp.86 rbp tmp-ra.74 tmp.19))
         (tmp.86 (rbp tmp-ra.74 tmp.59))
         (tmp.58 (rbp tmp-ra.74 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.74
           rsi
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.59
           tmp.85))
         (tmp.84 (tmp.19 rbp tmp-ra.74 tmp.20))
         (tmp.57 (rbp tmp-ra.74 tmp.19 tmp.20))
         (rax (rbp tmp-ra.74))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.74
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.86
           tmp.59
           tmp.85
           rax))
         (rdi (tmp-ra.74))
         (rsi (tmp.19 tmp-ra.74)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.75 rbp)
         (rsi tmp.21 tmp-ra.75 rbp)
         (tmp.21 tmp.22 tmp-ra.75 rbp)
         ((((((tmp.87 tmp.21 tmp.22 tmp-ra.75 rbp)
              (tmp.87 tmp.21 tmp.22 tmp-ra.75 rbp)
              (tmp.61 tmp.21 tmp.22 tmp-ra.75 rbp))
             (tmp.21 tmp.22 tmp-ra.75 rbp))
            (tmp.60 tmp.21 tmp.22 tmp-ra.75 rbp)
            (tmp.60 tmp.21 tmp.22 tmp-ra.75 rbp))
           (tmp.21 tmp.22 tmp-ra.75 rbp))
          ((((((tmp.88 tmp.21 tmp.22 tmp-ra.75 rbp)
               (tmp.88 tmp.21 tmp.22 tmp-ra.75 rbp)
               (tmp.63 tmp.21 tmp.22 tmp-ra.75 rbp))
              (tmp.21 tmp.22 tmp-ra.75 rbp))
             (tmp.62 tmp.21 tmp.22 tmp-ra.75 rbp)
             (tmp.62 tmp.21 tmp.22 tmp-ra.75 rbp))
            (tmp.21 tmp.22 tmp-ra.75 rbp))
           ((tmp.22 tmp.89 tmp-ra.75 rbp)
            (tmp.89 tmp-ra.75 rbp)
            (tmp-ra.75 rax rbp)
            (rax rbp))
           ((tmp-ra.75 rax rbp) (rax rbp)))
          ((tmp-ra.75 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.75 tmp.22 tmp.21))
         (tmp.87 (tmp.22 rbp tmp-ra.75 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.75
           tmp.21
           tmp.87
           tmp.61
           tmp.60
           tmp.88
           tmp.63
           tmp.62
           tmp.89))
         (tmp.61 (rbp tmp-ra.75 tmp.22 tmp.21))
         (tmp-ra.75
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.87
           tmp.61
           tmp.60
           tmp.88
           tmp.63
           tmp.62
           tmp.89
           rax))
         (tmp.89 (rbp tmp-ra.75 tmp.22))
         (tmp.63 (rbp tmp-ra.75 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.75 rsi tmp.87 tmp.61 tmp.60 tmp.88 tmp.63 tmp.62))
         (tmp.88 (tmp.21 rbp tmp-ra.75 tmp.22))
         (tmp.62 (rbp tmp-ra.75 tmp.22 tmp.21))
         (rax (rbp tmp-ra.75))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.75
           tmp.87
           tmp.61
           tmp.60
           tmp.88
           tmp.63
           tmp.62
           tmp.89
           rax))
         (rdi (tmp-ra.75))
         (rsi (tmp.21 tmp-ra.75)))))
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
         tmp.64))
       (undead-out
        ((rdi rsi tmp-ra.76 rbp)
         (rsi tmp.23 tmp-ra.76 rbp)
         (tmp.23 tmp.24 tmp-ra.76 rbp)
         ((((((tmp.90 tmp.23 tmp.24 tmp-ra.76 rbp)
              (tmp.90 tmp.23 tmp.24 tmp-ra.76 rbp)
              (tmp.65 tmp.23 tmp.24 tmp-ra.76 rbp))
             (tmp.23 tmp.24 tmp-ra.76 rbp))
            (tmp.64 tmp.23 tmp.24 tmp-ra.76 rbp)
            (tmp.64 tmp.23 tmp.24 tmp-ra.76 rbp))
           (tmp.23 tmp.24 tmp-ra.76 rbp))
          ((((((tmp.91 tmp.23 tmp.24 tmp-ra.76 rbp)
               (tmp.91 tmp.23 tmp.24 tmp-ra.76 rbp)
               (tmp.67 tmp.23 tmp.24 tmp-ra.76 rbp))
              (tmp.23 tmp.24 tmp-ra.76 rbp))
             (tmp.66 tmp.23 tmp.24 tmp-ra.76 rbp)
             (tmp.66 tmp.23 tmp.24 tmp-ra.76 rbp))
            (tmp.23 tmp.24 tmp-ra.76 rbp))
           ((tmp.24 tmp.92 tmp-ra.76 rbp)
            (tmp.92 tmp-ra.76 rbp)
            (tmp-ra.76 rax rbp)
            (rax rbp))
           ((tmp-ra.76 rax rbp) (rax rbp)))
          ((tmp-ra.76 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.76 tmp.24 tmp.23))
         (tmp.90 (tmp.24 rbp tmp-ra.76 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.76
           tmp.23
           tmp.90
           tmp.65
           tmp.64
           tmp.91
           tmp.67
           tmp.66
           tmp.92))
         (tmp.65 (rbp tmp-ra.76 tmp.24 tmp.23))
         (tmp-ra.76
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.90
           tmp.65
           tmp.64
           tmp.91
           tmp.67
           tmp.66
           tmp.92
           rax))
         (tmp.92 (rbp tmp-ra.76 tmp.24))
         (tmp.67 (rbp tmp-ra.76 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.76 rsi tmp.90 tmp.65 tmp.64 tmp.91 tmp.67 tmp.66))
         (tmp.91 (tmp.23 rbp tmp-ra.76 tmp.24))
         (tmp.66 (rbp tmp-ra.76 tmp.24 tmp.23))
         (rax (rbp tmp-ra.76))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.76
           tmp.90
           tmp.65
           tmp.64
           tmp.91
           tmp.67
           tmp.66
           tmp.92
           rax))
         (rdi (tmp-ra.76))
         (rsi (tmp.23 tmp-ra.76)))))
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
      ((new-frames ())
       (locals (tmp-ra.77))
       (undead-out ((tmp-ra.77 rbp) (tmp-ra.77 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.77 (rax rbp)) (rbp (rax tmp-ra.77)) (rax (rbp tmp-ra.77)))))
      (begin (set! tmp-ra.77 r15) (set! rax 25390) (jump tmp-ra.77 rbp rax)))
    (define L.fun/ascii-char19236.5
      ((new-frames ())
       (locals (tmp-ra.78))
       (undead-out ((tmp-ra.78 rbp) (tmp-ra.78 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.78 (rax rbp)) (rbp (rax tmp-ra.78)) (rax (rbp tmp-ra.78)))))
      (begin (set! tmp-ra.78 r15) (set! rax 25390) (jump tmp-ra.78 rbp rax)))
    (define L.fun/error19239.6
      ((new-frames ())
       (locals (tmp-ra.79))
       (undead-out ((tmp-ra.79 rbp) (tmp-ra.79 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.79 (rax rbp)) (rbp (rax tmp-ra.79)) (rax (rbp tmp-ra.79)))))
      (begin (set! tmp-ra.79 r15) (set! rax 55358) (jump tmp-ra.79 rbp rax)))
    (define L.fun/void19235.7
      ((new-frames ())
       (locals (tmp-ra.80))
       (undead-out ((tmp-ra.80 rbp) (tmp-ra.80 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80)))))
      (begin (set! tmp-ra.80 r15) (set! rax 30) (jump tmp-ra.80 rbp rax)))
    (define L.fun/error19238.8
      ((new-frames ())
       (locals (tmp-ra.81))
       (undead-out ((tmp-ra.81 rbp) (tmp-ra.81 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.81 (rax rbp)) (rbp (rax tmp-ra.81)) (rax (rbp tmp-ra.81)))))
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
       tmp-ra.82))
     (call-undead (tmp.72 tmp.68 tmp.69 tmp-ra.82))
     (undead-out
      ((tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.82 rbp)
       ((rax tmp.69 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.70 tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp-ra.82 rbp)
       ((rax tmp.68 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.68 tmp-ra.82 rbp)
       ((rax tmp.72 tmp.68 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.73 tmp.68 tmp-ra.82 rbp)
       ((rax tmp.68 tmp-ra.82 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.68 tmp-ra.82 rbp)
       (tmp.68 tmp-ra.82 rsi rbp)
       (tmp-ra.82 rsi rdi rbp)
       (rsi rdi r15 rbp)
       (rsi rdi r15 rbp)))
     (conflicts
      ((tmp-ra.82
        (rdi
         rsi
         tmp.71
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
         rax
         rbp))
       (empty0.5 (rbp tmp-ra.82))
       (empty1.4 (rbp tmp-ra.82))
       (error2.3 (rbp tmp-ra.82))
       (ascii-char3.2 (rbp tmp-ra.82))
       (ascii-char4.1 (rbp tmp-ra.82))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.82))
       (tmp.70 (rbp tmp-ra.82 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.82))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.82 tmp.68))
       (tmp.73 (rbp tmp-ra.82 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.82 tmp.68))
       (rbp
        (tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         rdi
         rsi
         ascii-char4.1
         ascii-char3.2
         error2.3
         empty1.4
         empty0.5
         r15
         rax
         tmp-ra.82))
       (rax (tmp.72 tmp.68 tmp.69 rbp tmp-ra.82))
       (r15 (rdi rsi rbp))
       (rsi (tmp-ra.82 tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (tmp-ra.82 r15 rbp rsi)))))
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
         tmp.55))
       (undead-out
        ((rdi rsi tmp-ra.74 rbp)
         (rsi tmp.19 tmp-ra.74 rbp)
         (tmp.20 tmp.19 tmp-ra.74 rbp)
         ((((((tmp.83 tmp.20 tmp.19 tmp-ra.74 rbp)
              (tmp.83 tmp.20 tmp.19 tmp-ra.74 rbp)
              (tmp.56 tmp.20 tmp.19 tmp-ra.74 rbp))
             (tmp.20 tmp.19 tmp-ra.74 rbp))
            (tmp.55 tmp.20 tmp.19 tmp-ra.74 rbp)
            (tmp.55 tmp.20 tmp.19 tmp-ra.74 rbp))
           (tmp.20 tmp.19 tmp-ra.74 rbp))
          ((((((tmp.84 tmp.20 tmp.19 tmp-ra.74 rbp)
               (tmp.84 tmp.20 tmp.19 tmp-ra.74 rbp)
               (tmp.58 tmp.20 tmp.19 tmp-ra.74 rbp))
              (tmp.20 tmp.19 tmp-ra.74 rbp))
             (tmp.57 tmp.20 tmp.19 tmp-ra.74 rbp)
             (tmp.57 tmp.20 tmp.19 tmp-ra.74 rbp))
            (tmp.20 tmp.19 tmp-ra.74 rbp))
           ((tmp.85 tmp.19 tmp-ra.74 rbp)
            (tmp.85 tmp.19 tmp-ra.74 rbp)
            (tmp.19 tmp.59 tmp-ra.74 rbp)
            (tmp.59 tmp.86 tmp-ra.74 rbp)
            (tmp.86 tmp-ra.74 rbp)
            (tmp-ra.74 rax rbp)
            (rax rbp))
           ((tmp-ra.74 rax rbp) (rax rbp)))
          ((tmp-ra.74 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.74 tmp.19 tmp.20))
         (tmp.83 (tmp.20 rbp tmp-ra.74 tmp.19))
         (tmp.20
          (rbp tmp-ra.74 tmp.19 tmp.83 tmp.56 tmp.55 tmp.84 tmp.58 tmp.57))
         (tmp.56 (rbp tmp-ra.74 tmp.19 tmp.20))
         (tmp-ra.74
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.86
           tmp.59
           tmp.85
           rax))
         (tmp.85 (rbp tmp-ra.74 tmp.19))
         (tmp.59 (tmp.86 rbp tmp-ra.74 tmp.19))
         (tmp.86 (rbp tmp-ra.74 tmp.59))
         (tmp.58 (rbp tmp-ra.74 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.74
           rsi
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.59
           tmp.85))
         (tmp.84 (tmp.19 rbp tmp-ra.74 tmp.20))
         (tmp.57 (rbp tmp-ra.74 tmp.19 tmp.20))
         (rax (rbp tmp-ra.74))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.74
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.86
           tmp.59
           tmp.85
           rax))
         (rdi (tmp-ra.74))
         (rsi (tmp.19 tmp-ra.74)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.75 rbp)
         (rsi tmp.21 tmp-ra.75 rbp)
         (tmp.21 tmp.22 tmp-ra.75 rbp)
         ((((((tmp.87 tmp.21 tmp.22 tmp-ra.75 rbp)
              (tmp.87 tmp.21 tmp.22 tmp-ra.75 rbp)
              (tmp.61 tmp.21 tmp.22 tmp-ra.75 rbp))
             (tmp.21 tmp.22 tmp-ra.75 rbp))
            (tmp.60 tmp.21 tmp.22 tmp-ra.75 rbp)
            (tmp.60 tmp.21 tmp.22 tmp-ra.75 rbp))
           (tmp.21 tmp.22 tmp-ra.75 rbp))
          ((((((tmp.88 tmp.21 tmp.22 tmp-ra.75 rbp)
               (tmp.88 tmp.21 tmp.22 tmp-ra.75 rbp)
               (tmp.63 tmp.21 tmp.22 tmp-ra.75 rbp))
              (tmp.21 tmp.22 tmp-ra.75 rbp))
             (tmp.62 tmp.21 tmp.22 tmp-ra.75 rbp)
             (tmp.62 tmp.21 tmp.22 tmp-ra.75 rbp))
            (tmp.21 tmp.22 tmp-ra.75 rbp))
           ((tmp.22 tmp.89 tmp-ra.75 rbp)
            (tmp.89 tmp-ra.75 rbp)
            (tmp-ra.75 rax rbp)
            (rax rbp))
           ((tmp-ra.75 rax rbp) (rax rbp)))
          ((tmp-ra.75 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.75 tmp.22 tmp.21))
         (tmp.87 (tmp.22 rbp tmp-ra.75 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.75
           tmp.21
           tmp.87
           tmp.61
           tmp.60
           tmp.88
           tmp.63
           tmp.62
           tmp.89))
         (tmp.61 (rbp tmp-ra.75 tmp.22 tmp.21))
         (tmp-ra.75
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.87
           tmp.61
           tmp.60
           tmp.88
           tmp.63
           tmp.62
           tmp.89
           rax))
         (tmp.89 (rbp tmp-ra.75 tmp.22))
         (tmp.63 (rbp tmp-ra.75 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.75 rsi tmp.87 tmp.61 tmp.60 tmp.88 tmp.63 tmp.62))
         (tmp.88 (tmp.21 rbp tmp-ra.75 tmp.22))
         (tmp.62 (rbp tmp-ra.75 tmp.22 tmp.21))
         (rax (rbp tmp-ra.75))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.75
           tmp.87
           tmp.61
           tmp.60
           tmp.88
           tmp.63
           tmp.62
           tmp.89
           rax))
         (rdi (tmp-ra.75))
         (rsi (tmp.21 tmp-ra.75)))))
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
         tmp.64))
       (undead-out
        ((rdi rsi tmp-ra.76 rbp)
         (rsi tmp.23 tmp-ra.76 rbp)
         (tmp.23 tmp.24 tmp-ra.76 rbp)
         ((((((tmp.90 tmp.23 tmp.24 tmp-ra.76 rbp)
              (tmp.90 tmp.23 tmp.24 tmp-ra.76 rbp)
              (tmp.65 tmp.23 tmp.24 tmp-ra.76 rbp))
             (tmp.23 tmp.24 tmp-ra.76 rbp))
            (tmp.64 tmp.23 tmp.24 tmp-ra.76 rbp)
            (tmp.64 tmp.23 tmp.24 tmp-ra.76 rbp))
           (tmp.23 tmp.24 tmp-ra.76 rbp))
          ((((((tmp.91 tmp.23 tmp.24 tmp-ra.76 rbp)
               (tmp.91 tmp.23 tmp.24 tmp-ra.76 rbp)
               (tmp.67 tmp.23 tmp.24 tmp-ra.76 rbp))
              (tmp.23 tmp.24 tmp-ra.76 rbp))
             (tmp.66 tmp.23 tmp.24 tmp-ra.76 rbp)
             (tmp.66 tmp.23 tmp.24 tmp-ra.76 rbp))
            (tmp.23 tmp.24 tmp-ra.76 rbp))
           ((tmp.24 tmp.92 tmp-ra.76 rbp)
            (tmp.92 tmp-ra.76 rbp)
            (tmp-ra.76 rax rbp)
            (rax rbp))
           ((tmp-ra.76 rax rbp) (rax rbp)))
          ((tmp-ra.76 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.76 tmp.24 tmp.23))
         (tmp.90 (tmp.24 rbp tmp-ra.76 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.76
           tmp.23
           tmp.90
           tmp.65
           tmp.64
           tmp.91
           tmp.67
           tmp.66
           tmp.92))
         (tmp.65 (rbp tmp-ra.76 tmp.24 tmp.23))
         (tmp-ra.76
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.90
           tmp.65
           tmp.64
           tmp.91
           tmp.67
           tmp.66
           tmp.92
           rax))
         (tmp.92 (rbp tmp-ra.76 tmp.24))
         (tmp.67 (rbp tmp-ra.76 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.76 rsi tmp.90 tmp.65 tmp.64 tmp.91 tmp.67 tmp.66))
         (tmp.91 (tmp.23 rbp tmp-ra.76 tmp.24))
         (tmp.66 (rbp tmp-ra.76 tmp.24 tmp.23))
         (rax (rbp tmp-ra.76))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.76
           tmp.90
           tmp.65
           tmp.64
           tmp.91
           tmp.67
           tmp.66
           tmp.92
           rax))
         (rdi (tmp-ra.76))
         (rsi (tmp.23 tmp-ra.76)))))
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
      ((new-frames ())
       (locals (tmp-ra.77))
       (undead-out ((tmp-ra.77 rbp) (tmp-ra.77 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.77 (rax rbp)) (rbp (rax tmp-ra.77)) (rax (rbp tmp-ra.77)))))
      (begin (set! tmp-ra.77 r15) (set! rax 22) (jump tmp-ra.77 rbp rax)))
    (define L.fun/ascii-char20767.5
      ((new-frames ())
       (locals (tmp-ra.78))
       (undead-out ((tmp-ra.78 rbp) (tmp-ra.78 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.78 (rax rbp)) (rbp (rax tmp-ra.78)) (rax (rbp tmp-ra.78)))))
      (begin (set! tmp-ra.78 r15) (set! rax 25390) (jump tmp-ra.78 rbp rax)))
    (define L.fun/ascii-char20768.6
      ((new-frames ())
       (locals (tmp-ra.79))
       (undead-out ((tmp-ra.79 rbp) (tmp-ra.79 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.79 (rax rbp)) (rbp (rax tmp-ra.79)) (rax (rbp tmp-ra.79)))))
      (begin (set! tmp-ra.79 r15) (set! rax 25390) (jump tmp-ra.79 rbp rax)))
    (define L.fun/empty20764.7
      ((new-frames ())
       (locals (tmp-ra.80))
       (undead-out ((tmp-ra.80 rbp) (tmp-ra.80 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80)))))
      (begin (set! tmp-ra.80 r15) (set! rax 22) (jump tmp-ra.80 rbp rax)))
    (define L.fun/error20766.8
      ((new-frames ())
       (locals (tmp-ra.81))
       (undead-out ((tmp-ra.81 rbp) (tmp-ra.81 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.81 (rax rbp)) (rbp (rax tmp-ra.81)) (rax (rbp tmp-ra.81)))))
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
       tmp-ra.87))
     (call-undead (tmp.72 tmp.75 tmp.74 tmp.78 tmp.68 tmp.69 tmp-ra.87))
     (undead-out
      ((tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.87 rbp)
       ((rax tmp.69 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.70 tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp-ra.87 rbp)
       ((rax tmp.68 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.68 tmp-ra.87 rbp)
       ((rax tmp.72 tmp.68 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.73 tmp.68 tmp-ra.87 rbp)
       ((rax tmp.68 tmp-ra.87 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp.71 tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((tmp.68 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp-ra.87 rbp)
       ((rax tmp.75 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp.76 tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((tmp.75 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp-ra.87 rbp)
       ((rax tmp.74 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.74 tmp-ra.87 rbp)
       ((rax tmp.78 tmp.74 tmp-ra.87 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.79 tmp.74 tmp-ra.87 rbp)
       ((rax tmp.74 tmp-ra.87 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.77 tmp-ra.87 rbp)
       ((rax tmp-ra.87 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.87 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.87
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
         rax
         rbp))
       (ascii-char0.5 (rbp tmp-ra.87))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.87))
       (tmp.70 (rbp tmp-ra.87 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.87))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.87 tmp.68))
       (tmp.73 (rbp tmp-ra.87 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.87 tmp.68))
       (fixnum1.4 (rbp tmp-ra.87))
       (ascii-char2.3 (rbp tmp-ra.87))
       (ascii-char3.2 (rbp tmp-ra.87))
       (tmp.75 (rsi tmp.76 rax rbp tmp-ra.87))
       (tmp.76 (rbp tmp-ra.87 tmp.75))
       (tmp.74 (rsi tmp.77 tmp.79 tmp.78 rax rbp tmp-ra.87))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.87 tmp.74))
       (tmp.79 (rbp tmp-ra.87 tmp.74 tmp.78))
       (tmp.77 (rbp tmp-ra.87 tmp.74))
       (fixnum4.1 (rbp tmp-ra.87))
       (rbp
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
         rdi
         rsi
         ascii-char0.5
         r15
         rax
         tmp-ra.87))
       (rax (tmp.78 tmp.74 tmp.75 tmp.72 tmp.68 tmp.69 rbp tmp-ra.87))
       (r15 (rdi rsi rbp))
       (rsi (tmp.74 tmp.78 tmp.75 tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi)))))
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
         tmp.55))
       (undead-out
        ((rdi rsi tmp-ra.80 rbp)
         (rsi tmp.23 tmp-ra.80 rbp)
         (tmp.23 tmp.24 tmp-ra.80 rbp)
         ((((((tmp.88 tmp.23 tmp.24 tmp-ra.80 rbp)
              (tmp.88 tmp.23 tmp.24 tmp-ra.80 rbp)
              (tmp.56 tmp.23 tmp.24 tmp-ra.80 rbp))
             (tmp.23 tmp.24 tmp-ra.80 rbp))
            (tmp.55 tmp.23 tmp.24 tmp-ra.80 rbp)
            (tmp.55 tmp.23 tmp.24 tmp-ra.80 rbp))
           (tmp.23 tmp.24 tmp-ra.80 rbp))
          ((((((tmp.89 tmp.23 tmp.24 tmp-ra.80 rbp)
               (tmp.89 tmp.23 tmp.24 tmp-ra.80 rbp)
               (tmp.58 tmp.23 tmp.24 tmp-ra.80 rbp))
              (tmp.23 tmp.24 tmp-ra.80 rbp))
             (tmp.57 tmp.23 tmp.24 tmp-ra.80 rbp)
             (tmp.57 tmp.23 tmp.24 tmp-ra.80 rbp))
            (tmp.23 tmp.24 tmp-ra.80 rbp))
           ((tmp.24 tmp.90 tmp-ra.80 rbp)
            (tmp.90 tmp-ra.80 rbp)
            (tmp-ra.80 rax rbp)
            (rax rbp))
           ((tmp-ra.80 rax rbp) (rax rbp)))
          ((tmp-ra.80 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.80 tmp.24 tmp.23))
         (tmp.88 (tmp.24 rbp tmp-ra.80 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.80
           tmp.23
           tmp.88
           tmp.56
           tmp.55
           tmp.89
           tmp.58
           tmp.57
           tmp.90))
         (tmp.56 (rbp tmp-ra.80 tmp.24 tmp.23))
         (tmp-ra.80
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.88
           tmp.56
           tmp.55
           tmp.89
           tmp.58
           tmp.57
           tmp.90
           rax))
         (tmp.90 (rbp tmp-ra.80 tmp.24))
         (tmp.58 (rbp tmp-ra.80 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.80 rsi tmp.88 tmp.56 tmp.55 tmp.89 tmp.58 tmp.57))
         (tmp.89 (tmp.23 rbp tmp-ra.80 tmp.24))
         (tmp.57 (rbp tmp-ra.80 tmp.24 tmp.23))
         (rax (rbp tmp-ra.80))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.80
           tmp.88
           tmp.56
           tmp.55
           tmp.89
           tmp.58
           tmp.57
           tmp.90
           rax))
         (rdi (tmp-ra.80))
         (rsi (tmp.23 tmp-ra.80)))))
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
         tmp.59))
       (undead-out
        ((rdi rsi tmp-ra.81 rbp)
         (rsi tmp.19 tmp-ra.81 rbp)
         (tmp.20 tmp.19 tmp-ra.81 rbp)
         ((((((tmp.91 tmp.20 tmp.19 tmp-ra.81 rbp)
              (tmp.91 tmp.20 tmp.19 tmp-ra.81 rbp)
              (tmp.60 tmp.20 tmp.19 tmp-ra.81 rbp))
             (tmp.20 tmp.19 tmp-ra.81 rbp))
            (tmp.59 tmp.20 tmp.19 tmp-ra.81 rbp)
            (tmp.59 tmp.20 tmp.19 tmp-ra.81 rbp))
           (tmp.20 tmp.19 tmp-ra.81 rbp))
          ((((((tmp.92 tmp.20 tmp.19 tmp-ra.81 rbp)
               (tmp.92 tmp.20 tmp.19 tmp-ra.81 rbp)
               (tmp.62 tmp.20 tmp.19 tmp-ra.81 rbp))
              (tmp.20 tmp.19 tmp-ra.81 rbp))
             (tmp.61 tmp.20 tmp.19 tmp-ra.81 rbp)
             (tmp.61 tmp.20 tmp.19 tmp-ra.81 rbp))
            (tmp.20 tmp.19 tmp-ra.81 rbp))
           ((tmp.93 tmp.19 tmp-ra.81 rbp)
            (tmp.93 tmp.19 tmp-ra.81 rbp)
            (tmp.19 tmp.63 tmp-ra.81 rbp)
            (tmp.63 tmp.94 tmp-ra.81 rbp)
            (tmp.94 tmp-ra.81 rbp)
            (tmp-ra.81 rax rbp)
            (rax rbp))
           ((tmp-ra.81 rax rbp) (rax rbp)))
          ((tmp-ra.81 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.59 (rbp tmp-ra.81 tmp.19 tmp.20))
         (tmp.91 (tmp.20 rbp tmp-ra.81 tmp.19))
         (tmp.20
          (rbp tmp-ra.81 tmp.19 tmp.91 tmp.60 tmp.59 tmp.92 tmp.62 tmp.61))
         (tmp.60 (rbp tmp-ra.81 tmp.19 tmp.20))
         (tmp-ra.81
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.91
           tmp.60
           tmp.59
           tmp.92
           tmp.62
           tmp.61
           tmp.94
           tmp.63
           tmp.93
           rax))
         (tmp.93 (rbp tmp-ra.81 tmp.19))
         (tmp.63 (tmp.94 rbp tmp-ra.81 tmp.19))
         (tmp.94 (rbp tmp-ra.81 tmp.63))
         (tmp.62 (rbp tmp-ra.81 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.81
           rsi
           tmp.91
           tmp.60
           tmp.59
           tmp.92
           tmp.62
           tmp.61
           tmp.63
           tmp.93))
         (tmp.92 (tmp.19 rbp tmp-ra.81 tmp.20))
         (tmp.61 (rbp tmp-ra.81 tmp.19 tmp.20))
         (rax (rbp tmp-ra.81))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.81
           tmp.91
           tmp.60
           tmp.59
           tmp.92
           tmp.62
           tmp.61
           tmp.94
           tmp.63
           tmp.93
           rax))
         (rdi (tmp-ra.81))
         (rsi (tmp.19 tmp-ra.81)))))
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
         tmp.64))
       (undead-out
        ((rdi rsi tmp-ra.82 rbp)
         (rsi tmp.21 tmp-ra.82 rbp)
         (tmp.21 tmp.22 tmp-ra.82 rbp)
         ((((((tmp.95 tmp.21 tmp.22 tmp-ra.82 rbp)
              (tmp.95 tmp.21 tmp.22 tmp-ra.82 rbp)
              (tmp.65 tmp.21 tmp.22 tmp-ra.82 rbp))
             (tmp.21 tmp.22 tmp-ra.82 rbp))
            (tmp.64 tmp.21 tmp.22 tmp-ra.82 rbp)
            (tmp.64 tmp.21 tmp.22 tmp-ra.82 rbp))
           (tmp.21 tmp.22 tmp-ra.82 rbp))
          ((((((tmp.96 tmp.21 tmp.22 tmp-ra.82 rbp)
               (tmp.96 tmp.21 tmp.22 tmp-ra.82 rbp)
               (tmp.67 tmp.21 tmp.22 tmp-ra.82 rbp))
              (tmp.21 tmp.22 tmp-ra.82 rbp))
             (tmp.66 tmp.21 tmp.22 tmp-ra.82 rbp)
             (tmp.66 tmp.21 tmp.22 tmp-ra.82 rbp))
            (tmp.21 tmp.22 tmp-ra.82 rbp))
           ((tmp.22 tmp.97 tmp-ra.82 rbp)
            (tmp.97 tmp-ra.82 rbp)
            (tmp-ra.82 rax rbp)
            (rax rbp))
           ((tmp-ra.82 rax rbp) (rax rbp)))
          ((tmp-ra.82 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.82 tmp.22 tmp.21))
         (tmp.95 (tmp.22 rbp tmp-ra.82 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.82
           tmp.21
           tmp.95
           tmp.65
           tmp.64
           tmp.96
           tmp.67
           tmp.66
           tmp.97))
         (tmp.65 (rbp tmp-ra.82 tmp.22 tmp.21))
         (tmp-ra.82
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.95
           tmp.65
           tmp.64
           tmp.96
           tmp.67
           tmp.66
           tmp.97
           rax))
         (tmp.97 (rbp tmp-ra.82 tmp.22))
         (tmp.67 (rbp tmp-ra.82 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.82 rsi tmp.95 tmp.65 tmp.64 tmp.96 tmp.67 tmp.66))
         (tmp.96 (tmp.21 rbp tmp-ra.82 tmp.22))
         (tmp.66 (rbp tmp-ra.82 tmp.22 tmp.21))
         (rax (rbp tmp-ra.82))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.82
           tmp.95
           tmp.65
           tmp.64
           tmp.96
           tmp.67
           tmp.66
           tmp.97
           rax))
         (rdi (tmp-ra.82))
         (rsi (tmp.21 tmp-ra.82)))))
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
      ((new-frames ())
       (locals (tmp-ra.83))
       (undead-out ((tmp-ra.83 rbp) (tmp-ra.83 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83)))))
      (begin (set! tmp-ra.83 r15) (set! rax 25390) (jump tmp-ra.83 rbp rax)))
    (define L.fun/ascii-char21098.5
      ((new-frames ())
       (locals (tmp-ra.84))
       (undead-out ((tmp-ra.84 rbp) (tmp-ra.84 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.84 (rax rbp)) (rbp (rax tmp-ra.84)) (rax (rbp tmp-ra.84)))))
      (begin (set! tmp-ra.84 r15) (set! rax 25390) (jump tmp-ra.84 rbp rax)))
    (define L.fun/error21099.6
      ((new-frames ())
       (locals (tmp-ra.85))
       (undead-out ((tmp-ra.85 rbp) (tmp-ra.85 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.85 (rax rbp)) (rbp (rax tmp-ra.85)) (rax (rbp tmp-ra.85)))))
      (begin (set! tmp-ra.85 r15) (set! rax 33086) (jump tmp-ra.85 rbp rax)))
    (define L.fun/ascii-char21097.7
      ((new-frames ())
       (locals (tmp-ra.86))
       (undead-out ((tmp-ra.86 rbp) (tmp-ra.86 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86)))))
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
       tmp-ra.75))
     (call-undead (tmp.64 tmp.63 tmp.67 void1.4 tmp-ra.75))
     (undead-out
      ((tmp-ra.75 rbp)
       ((rax tmp-ra.75 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.75 rbp)
       ((rax tmp-ra.75 rbp) ((r15 rbp) (r15 rbp)))
       (void1.4 tmp-ra.75 rbp)
       ((rax void1.4 tmp-ra.75 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.64 void1.4 tmp-ra.75 rbp)
       ((rax tmp.64 void1.4 tmp-ra.75 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.64 tmp.65 void1.4 tmp-ra.75 rbp)
       ((rax void1.4 tmp-ra.75 rbp)
        ((tmp.64 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.63 void1.4 tmp-ra.75 rbp)
       ((rax tmp.63 void1.4 tmp-ra.75 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.67 tmp.63 void1.4 tmp-ra.75 rbp)
       ((rax tmp.67 tmp.63 void1.4 tmp-ra.75 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.67 tmp.68 tmp.63 void1.4 tmp-ra.75 rbp)
       ((rax tmp.63 void1.4 tmp-ra.75 rbp)
        ((tmp.67 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.63 tmp.66 void1.4 tmp-ra.75 rbp)
       ((rax void1.4 tmp-ra.75 rbp)
        ((tmp.63 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (void1.4 tmp-ra.75 rbp)
       ((rax void1.4 tmp-ra.75 rbp) ((r15 rbp) (r15 rbp)))
       (void1.4 tmp-ra.75 rbp)
       ((rax void1.4 tmp-ra.75 rbp) ((r15 rbp) (r15 rbp)))
       (void1.4 tmp-ra.75 rbp)
       (tmp-ra.75 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.75
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
         rax
         rbp))
       (ascii-char0.5 (rbp tmp-ra.75))
       (void1.4
        (void4.1
         void3.2
         fixnum2.3
         tmp.66
         tmp.68
         tmp.67
         tmp.63
         tmp.65
         tmp.64
         rax
         rbp
         tmp-ra.75))
       (tmp.64 (rsi tmp.65 rax rbp tmp-ra.75 void1.4))
       (tmp.65 (rbp tmp-ra.75 void1.4 tmp.64))
       (tmp.63 (rsi tmp.66 tmp.68 tmp.67 rax rbp tmp-ra.75 void1.4))
       (tmp.67 (rsi tmp.68 rax rbp tmp-ra.75 void1.4 tmp.63))
       (tmp.68 (rbp tmp-ra.75 void1.4 tmp.63 tmp.67))
       (tmp.66 (rbp tmp-ra.75 void1.4 tmp.63))
       (fixnum2.3 (rbp tmp-ra.75 void1.4))
       (void3.2 (rbp tmp-ra.75 void1.4))
       (void4.1 (rbp tmp-ra.75 void1.4))
       (rbp
        (void4.1
         void3.2
         fixnum2.3
         tmp.66
         tmp.68
         tmp.67
         tmp.63
         tmp.65
         tmp.64
         rdi
         rsi
         void1.4
         ascii-char0.5
         r15
         rax
         tmp-ra.75))
       (rax (tmp.67 tmp.63 tmp.64 void1.4 rbp tmp-ra.75))
       (r15 (rdi rsi rbp))
       (rsi (tmp.63 tmp.67 tmp.64 r15 rdi rbp))
       (rdi (r15 rbp rsi)))))
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
         tmp.55))
       (undead-out
        ((rdi rsi tmp-ra.69 rbp)
         (rsi tmp.23 tmp-ra.69 rbp)
         (tmp.23 tmp.24 tmp-ra.69 rbp)
         ((((((tmp.76 tmp.23 tmp.24 tmp-ra.69 rbp)
              (tmp.76 tmp.23 tmp.24 tmp-ra.69 rbp)
              (tmp.56 tmp.23 tmp.24 tmp-ra.69 rbp))
             (tmp.23 tmp.24 tmp-ra.69 rbp))
            (tmp.55 tmp.23 tmp.24 tmp-ra.69 rbp)
            (tmp.55 tmp.23 tmp.24 tmp-ra.69 rbp))
           (tmp.23 tmp.24 tmp-ra.69 rbp))
          ((((((tmp.77 tmp.23 tmp.24 tmp-ra.69 rbp)
               (tmp.77 tmp.23 tmp.24 tmp-ra.69 rbp)
               (tmp.58 tmp.23 tmp.24 tmp-ra.69 rbp))
              (tmp.23 tmp.24 tmp-ra.69 rbp))
             (tmp.57 tmp.23 tmp.24 tmp-ra.69 rbp)
             (tmp.57 tmp.23 tmp.24 tmp-ra.69 rbp))
            (tmp.23 tmp.24 tmp-ra.69 rbp))
           ((tmp.24 tmp.78 tmp-ra.69 rbp)
            (tmp.78 tmp-ra.69 rbp)
            (tmp-ra.69 rax rbp)
            (rax rbp))
           ((tmp-ra.69 rax rbp) (rax rbp)))
          ((tmp-ra.69 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.69 tmp.24 tmp.23))
         (tmp.76 (tmp.24 rbp tmp-ra.69 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.69
           tmp.23
           tmp.76
           tmp.56
           tmp.55
           tmp.77
           tmp.58
           tmp.57
           tmp.78))
         (tmp.56 (rbp tmp-ra.69 tmp.24 tmp.23))
         (tmp-ra.69
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.76
           tmp.56
           tmp.55
           tmp.77
           tmp.58
           tmp.57
           tmp.78
           rax))
         (tmp.78 (rbp tmp-ra.69 tmp.24))
         (tmp.58 (rbp tmp-ra.69 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.69 rsi tmp.76 tmp.56 tmp.55 tmp.77 tmp.58 tmp.57))
         (tmp.77 (tmp.23 rbp tmp-ra.69 tmp.24))
         (tmp.57 (rbp tmp-ra.69 tmp.24 tmp.23))
         (rax (rbp tmp-ra.69))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.69
           tmp.76
           tmp.56
           tmp.55
           tmp.77
           tmp.58
           tmp.57
           tmp.78
           rax))
         (rdi (tmp-ra.69))
         (rsi (tmp.23 tmp-ra.69)))))
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
         tmp.59))
       (undead-out
        ((rdi rsi tmp-ra.70 rbp)
         (rsi tmp.21 tmp-ra.70 rbp)
         (tmp.21 tmp.22 tmp-ra.70 rbp)
         ((((((tmp.79 tmp.21 tmp.22 tmp-ra.70 rbp)
              (tmp.79 tmp.21 tmp.22 tmp-ra.70 rbp)
              (tmp.60 tmp.21 tmp.22 tmp-ra.70 rbp))
             (tmp.21 tmp.22 tmp-ra.70 rbp))
            (tmp.59 tmp.21 tmp.22 tmp-ra.70 rbp)
            (tmp.59 tmp.21 tmp.22 tmp-ra.70 rbp))
           (tmp.21 tmp.22 tmp-ra.70 rbp))
          ((((((tmp.80 tmp.21 tmp.22 tmp-ra.70 rbp)
               (tmp.80 tmp.21 tmp.22 tmp-ra.70 rbp)
               (tmp.62 tmp.21 tmp.22 tmp-ra.70 rbp))
              (tmp.21 tmp.22 tmp-ra.70 rbp))
             (tmp.61 tmp.21 tmp.22 tmp-ra.70 rbp)
             (tmp.61 tmp.21 tmp.22 tmp-ra.70 rbp))
            (tmp.21 tmp.22 tmp-ra.70 rbp))
           ((tmp.22 tmp.81 tmp-ra.70 rbp)
            (tmp.81 tmp-ra.70 rbp)
            (tmp-ra.70 rax rbp)
            (rax rbp))
           ((tmp-ra.70 rax rbp) (rax rbp)))
          ((tmp-ra.70 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.59 (rbp tmp-ra.70 tmp.22 tmp.21))
         (tmp.79 (tmp.22 rbp tmp-ra.70 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.70
           tmp.21
           tmp.79
           tmp.60
           tmp.59
           tmp.80
           tmp.62
           tmp.61
           tmp.81))
         (tmp.60 (rbp tmp-ra.70 tmp.22 tmp.21))
         (tmp-ra.70
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.79
           tmp.60
           tmp.59
           tmp.80
           tmp.62
           tmp.61
           tmp.81
           rax))
         (tmp.81 (rbp tmp-ra.70 tmp.22))
         (tmp.62 (rbp tmp-ra.70 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.70 rsi tmp.79 tmp.60 tmp.59 tmp.80 tmp.62 tmp.61))
         (tmp.80 (tmp.21 rbp tmp-ra.70 tmp.22))
         (tmp.61 (rbp tmp-ra.70 tmp.22 tmp.21))
         (rax (rbp tmp-ra.70))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.70
           tmp.79
           tmp.60
           tmp.59
           tmp.80
           tmp.62
           tmp.61
           tmp.81
           rax))
         (rdi (tmp-ra.70))
         (rsi (tmp.21 tmp-ra.70)))))
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
      ((new-frames ())
       (locals (tmp-ra.71))
       (undead-out ((tmp-ra.71 rbp) (tmp-ra.71 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.71 (rax rbp)) (rbp (rax tmp-ra.71)) (rax (rbp tmp-ra.71)))))
      (begin (set! tmp-ra.71 r15) (set! rax 30) (jump tmp-ra.71 rbp rax)))
    (define L.fun/void21255.5
      ((new-frames ())
       (locals (tmp-ra.72))
       (undead-out ((tmp-ra.72 rbp) (tmp-ra.72 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.72 (rax rbp)) (rbp (rax tmp-ra.72)) (rax (rbp tmp-ra.72)))))
      (begin (set! tmp-ra.72 r15) (set! rax 30) (jump tmp-ra.72 rbp rax)))
    (define L.fun/void21256.6
      ((new-frames ())
       (locals (tmp-ra.73))
       (undead-out ((tmp-ra.73 rbp) (tmp-ra.73 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.73 (rax rbp)) (rbp (rax tmp-ra.73)) (rax (rbp tmp-ra.73)))))
      (begin (set! tmp-ra.73 r15) (set! rax 30) (jump tmp-ra.73 rbp rax)))
    (define L.fun/ascii-char21254.7
      ((new-frames ())
       (locals (tmp-ra.74))
       (undead-out ((tmp-ra.74 rbp) (tmp-ra.74 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.74 (rax rbp)) (rbp (rax tmp-ra.74)) (rax (rbp tmp-ra.74)))))
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
     (locals (empty4.1 error3.2 empty2.3 empty1.4 error0.5 tmp-ra.60))
     (call-undead (error0.5 tmp-ra.60))
     (undead-out
      ((tmp-ra.60 rbp)
       ((rax tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (error0.5 tmp-ra.60 rbp)
       ((rax error0.5 tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (error0.5 tmp-ra.60 rbp)
       ((rax error0.5 tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (error0.5 tmp-ra.60 rbp)
       ((rax error0.5 tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (error0.5 tmp-ra.60 rbp)
       ((rax error0.5 tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (error0.5 tmp-ra.60 rbp)
       (tmp-ra.60 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.60 (empty4.1 error3.2 empty2.3 empty1.4 error0.5 rax rbp))
       (error0.5 (empty4.1 error3.2 empty2.3 empty1.4 rax rbp tmp-ra.60))
       (empty1.4 (rbp tmp-ra.60 error0.5))
       (empty2.3 (rbp tmp-ra.60 error0.5))
       (error3.2 (rbp tmp-ra.60 error0.5))
       (empty4.1 (rbp tmp-ra.60 error0.5))
       (rbp (empty4.1 error3.2 empty2.3 empty1.4 error0.5 r15 rax tmp-ra.60))
       (rax (error0.5 rbp tmp-ra.60))
       (r15 (rbp)))))
    (define L.fun/error21502.4
      ((new-frames ())
       (locals (tmp-ra.55))
       (undead-out ((tmp-ra.55 rbp) (tmp-ra.55 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55)))))
      (begin (set! tmp-ra.55 r15) (set! rax 12606) (jump tmp-ra.55 rbp rax)))
    (define L.fun/empty21506.5
      ((new-frames ())
       (locals (tmp-ra.56))
       (undead-out ((tmp-ra.56 rbp) (tmp-ra.56 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56)))))
      (begin (set! tmp-ra.56 r15) (set! rax 22) (jump tmp-ra.56 rbp rax)))
    (define L.fun/empty21503.6
      ((new-frames ())
       (locals (tmp-ra.57))
       (undead-out ((tmp-ra.57 rbp) (tmp-ra.57 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57)))))
      (begin (set! tmp-ra.57 r15) (set! rax 22) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error21505.7
      ((new-frames ())
       (locals (tmp-ra.58))
       (undead-out ((tmp-ra.58 rbp) (tmp-ra.58 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58)))))
      (begin (set! tmp-ra.58 r15) (set! rax 45630) (jump tmp-ra.58 rbp rax)))
    (define L.fun/empty21504.8
      ((new-frames ())
       (locals (tmp-ra.59))
       (undead-out ((tmp-ra.59 rbp) (tmp-ra.59 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59)))))
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
       tmp-ra.82))
     (call-undead (tmp.72 tmp.68 tmp.69 tmp-ra.82))
     (undead-out
      ((tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.82 rbp)
       ((rax tmp.69 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.70 tmp-ra.82 rbp)
       ((rax tmp-ra.82 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.68 tmp-ra.82 rbp)
       ((rax tmp.68 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.68 tmp-ra.82 rbp)
       ((rax tmp.72 tmp.68 tmp-ra.82 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.73 tmp.68 tmp-ra.82 rbp)
       ((rax tmp.68 tmp-ra.82 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.68 tmp-ra.82 rbp)
       (tmp.68 tmp-ra.82 rsi rbp)
       (tmp-ra.82 rsi rdi rbp)
       (rsi rdi r15 rbp)
       (rsi rdi r15 rbp)))
     (conflicts
      ((tmp-ra.82
        (rdi
         rsi
         tmp.71
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
         rax
         rbp))
       (empty0.5 (rbp tmp-ra.82))
       (void1.4 (rbp tmp-ra.82))
       (void2.3 (rbp tmp-ra.82))
       (ascii-char3.2 (rbp tmp-ra.82))
       (void4.1 (rbp tmp-ra.82))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.82))
       (tmp.70 (rbp tmp-ra.82 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.82))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.82 tmp.68))
       (tmp.73 (rbp tmp-ra.82 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.82 tmp.68))
       (rbp
        (tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         rdi
         rsi
         void4.1
         ascii-char3.2
         void2.3
         void1.4
         empty0.5
         r15
         rax
         tmp-ra.82))
       (rax (tmp.72 tmp.68 tmp.69 rbp tmp-ra.82))
       (r15 (rdi rsi rbp))
       (rsi (tmp-ra.82 tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (tmp-ra.82 r15 rbp rsi)))))
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
         tmp.55))
       (undead-out
        ((rdi rsi tmp-ra.74 rbp)
         (rsi tmp.21 tmp-ra.74 rbp)
         (tmp.21 tmp.22 tmp-ra.74 rbp)
         ((((((tmp.83 tmp.21 tmp.22 tmp-ra.74 rbp)
              (tmp.83 tmp.21 tmp.22 tmp-ra.74 rbp)
              (tmp.56 tmp.21 tmp.22 tmp-ra.74 rbp))
             (tmp.21 tmp.22 tmp-ra.74 rbp))
            (tmp.55 tmp.21 tmp.22 tmp-ra.74 rbp)
            (tmp.55 tmp.21 tmp.22 tmp-ra.74 rbp))
           (tmp.21 tmp.22 tmp-ra.74 rbp))
          ((((((tmp.84 tmp.21 tmp.22 tmp-ra.74 rbp)
               (tmp.84 tmp.21 tmp.22 tmp-ra.74 rbp)
               (tmp.58 tmp.21 tmp.22 tmp-ra.74 rbp))
              (tmp.21 tmp.22 tmp-ra.74 rbp))
             (tmp.57 tmp.21 tmp.22 tmp-ra.74 rbp)
             (tmp.57 tmp.21 tmp.22 tmp-ra.74 rbp))
            (tmp.21 tmp.22 tmp-ra.74 rbp))
           ((tmp.22 tmp.85 tmp-ra.74 rbp)
            (tmp.85 tmp-ra.74 rbp)
            (tmp-ra.74 rax rbp)
            (rax rbp))
           ((tmp-ra.74 rax rbp) (rax rbp)))
          ((tmp-ra.74 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.74 tmp.22 tmp.21))
         (tmp.83 (tmp.22 rbp tmp-ra.74 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.74
           tmp.21
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.85))
         (tmp.56 (rbp tmp-ra.74 tmp.22 tmp.21))
         (tmp-ra.74
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.85
           rax))
         (tmp.85 (rbp tmp-ra.74 tmp.22))
         (tmp.58 (rbp tmp-ra.74 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.74 rsi tmp.83 tmp.56 tmp.55 tmp.84 tmp.58 tmp.57))
         (tmp.84 (tmp.21 rbp tmp-ra.74 tmp.22))
         (tmp.57 (rbp tmp-ra.74 tmp.22 tmp.21))
         (rax (rbp tmp-ra.74))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.74
           tmp.83
           tmp.56
           tmp.55
           tmp.84
           tmp.58
           tmp.57
           tmp.85
           rax))
         (rdi (tmp-ra.74))
         (rsi (tmp.21 tmp-ra.74)))))
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
         tmp.59))
       (undead-out
        ((rdi rsi tmp-ra.75 rbp)
         (rsi tmp.23 tmp-ra.75 rbp)
         (tmp.23 tmp.24 tmp-ra.75 rbp)
         ((((((tmp.86 tmp.23 tmp.24 tmp-ra.75 rbp)
              (tmp.86 tmp.23 tmp.24 tmp-ra.75 rbp)
              (tmp.60 tmp.23 tmp.24 tmp-ra.75 rbp))
             (tmp.23 tmp.24 tmp-ra.75 rbp))
            (tmp.59 tmp.23 tmp.24 tmp-ra.75 rbp)
            (tmp.59 tmp.23 tmp.24 tmp-ra.75 rbp))
           (tmp.23 tmp.24 tmp-ra.75 rbp))
          ((((((tmp.87 tmp.23 tmp.24 tmp-ra.75 rbp)
               (tmp.87 tmp.23 tmp.24 tmp-ra.75 rbp)
               (tmp.62 tmp.23 tmp.24 tmp-ra.75 rbp))
              (tmp.23 tmp.24 tmp-ra.75 rbp))
             (tmp.61 tmp.23 tmp.24 tmp-ra.75 rbp)
             (tmp.61 tmp.23 tmp.24 tmp-ra.75 rbp))
            (tmp.23 tmp.24 tmp-ra.75 rbp))
           ((tmp.24 tmp.88 tmp-ra.75 rbp)
            (tmp.88 tmp-ra.75 rbp)
            (tmp-ra.75 rax rbp)
            (rax rbp))
           ((tmp-ra.75 rax rbp) (rax rbp)))
          ((tmp-ra.75 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.59 (rbp tmp-ra.75 tmp.24 tmp.23))
         (tmp.86 (tmp.24 rbp tmp-ra.75 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.75
           tmp.23
           tmp.86
           tmp.60
           tmp.59
           tmp.87
           tmp.62
           tmp.61
           tmp.88))
         (tmp.60 (rbp tmp-ra.75 tmp.24 tmp.23))
         (tmp-ra.75
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.86
           tmp.60
           tmp.59
           tmp.87
           tmp.62
           tmp.61
           tmp.88
           rax))
         (tmp.88 (rbp tmp-ra.75 tmp.24))
         (tmp.62 (rbp tmp-ra.75 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.75 rsi tmp.86 tmp.60 tmp.59 tmp.87 tmp.62 tmp.61))
         (tmp.87 (tmp.23 rbp tmp-ra.75 tmp.24))
         (tmp.61 (rbp tmp-ra.75 tmp.24 tmp.23))
         (rax (rbp tmp-ra.75))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.75
           tmp.86
           tmp.60
           tmp.59
           tmp.87
           tmp.62
           tmp.61
           tmp.88
           rax))
         (rdi (tmp-ra.75))
         (rsi (tmp.23 tmp-ra.75)))))
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
         tmp.63))
       (undead-out
        ((rdi rsi tmp-ra.76 rbp)
         (rsi tmp.19 tmp-ra.76 rbp)
         (tmp.20 tmp.19 tmp-ra.76 rbp)
         ((((((tmp.89 tmp.20 tmp.19 tmp-ra.76 rbp)
              (tmp.89 tmp.20 tmp.19 tmp-ra.76 rbp)
              (tmp.64 tmp.20 tmp.19 tmp-ra.76 rbp))
             (tmp.20 tmp.19 tmp-ra.76 rbp))
            (tmp.63 tmp.20 tmp.19 tmp-ra.76 rbp)
            (tmp.63 tmp.20 tmp.19 tmp-ra.76 rbp))
           (tmp.20 tmp.19 tmp-ra.76 rbp))
          ((((((tmp.90 tmp.20 tmp.19 tmp-ra.76 rbp)
               (tmp.90 tmp.20 tmp.19 tmp-ra.76 rbp)
               (tmp.66 tmp.20 tmp.19 tmp-ra.76 rbp))
              (tmp.20 tmp.19 tmp-ra.76 rbp))
             (tmp.65 tmp.20 tmp.19 tmp-ra.76 rbp)
             (tmp.65 tmp.20 tmp.19 tmp-ra.76 rbp))
            (tmp.20 tmp.19 tmp-ra.76 rbp))
           ((tmp.91 tmp.19 tmp-ra.76 rbp)
            (tmp.91 tmp.19 tmp-ra.76 rbp)
            (tmp.19 tmp.67 tmp-ra.76 rbp)
            (tmp.67 tmp.92 tmp-ra.76 rbp)
            (tmp.92 tmp-ra.76 rbp)
            (tmp-ra.76 rax rbp)
            (rax rbp))
           ((tmp-ra.76 rax rbp) (rax rbp)))
          ((tmp-ra.76 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.63 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp.89 (tmp.20 rbp tmp-ra.76 tmp.19))
         (tmp.20
          (rbp tmp-ra.76 tmp.19 tmp.89 tmp.64 tmp.63 tmp.90 tmp.66 tmp.65))
         (tmp.64 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp-ra.76
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.89
           tmp.64
           tmp.63
           tmp.90
           tmp.66
           tmp.65
           tmp.92
           tmp.67
           tmp.91
           rax))
         (tmp.91 (rbp tmp-ra.76 tmp.19))
         (tmp.67 (tmp.92 rbp tmp-ra.76 tmp.19))
         (tmp.92 (rbp tmp-ra.76 tmp.67))
         (tmp.66 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.76
           rsi
           tmp.89
           tmp.64
           tmp.63
           tmp.90
           tmp.66
           tmp.65
           tmp.67
           tmp.91))
         (tmp.90 (tmp.19 rbp tmp-ra.76 tmp.20))
         (tmp.65 (rbp tmp-ra.76 tmp.19 tmp.20))
         (rax (rbp tmp-ra.76))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.76
           tmp.89
           tmp.64
           tmp.63
           tmp.90
           tmp.66
           tmp.65
           tmp.92
           tmp.67
           tmp.91
           rax))
         (rdi (tmp-ra.76))
         (rsi (tmp.19 tmp-ra.76)))))
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
      ((new-frames ())
       (locals (tmp-ra.77))
       (undead-out ((tmp-ra.77 rbp) (tmp-ra.77 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.77 (rax rbp)) (rbp (rax tmp-ra.77)) (rax (rbp tmp-ra.77)))))
      (begin (set! tmp-ra.77 r15) (set! rax 22) (jump tmp-ra.77 rbp rax)))
    (define L.fun/void21525.5
      ((new-frames ())
       (locals (tmp-ra.78))
       (undead-out ((tmp-ra.78 rbp) (tmp-ra.78 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.78 (rax rbp)) (rbp (rax tmp-ra.78)) (rax (rbp tmp-ra.78)))))
      (begin (set! tmp-ra.78 r15) (set! rax 30) (jump tmp-ra.78 rbp rax)))
    (define L.fun/void21524.6
      ((new-frames ())
       (locals (tmp-ra.79))
       (undead-out ((tmp-ra.79 rbp) (tmp-ra.79 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.79 (rax rbp)) (rbp (rax tmp-ra.79)) (rax (rbp tmp-ra.79)))))
      (begin (set! tmp-ra.79 r15) (set! rax 30) (jump tmp-ra.79 rbp rax)))
    (define L.fun/void21527.7
      ((new-frames ())
       (locals (tmp-ra.80))
       (undead-out ((tmp-ra.80 rbp) (tmp-ra.80 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80)))))
      (begin (set! tmp-ra.80 r15) (set! rax 30) (jump tmp-ra.80 rbp rax)))
    (define L.fun/ascii-char21526.8
      ((new-frames ())
       (locals (tmp-ra.81))
       (undead-out ((tmp-ra.81 rbp) (tmp-ra.81 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.81 (rax rbp)) (rbp (rax tmp-ra.81)) (rax (rbp tmp-ra.81)))))
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
     (locals (ascii-char4.1 void3.2 void2.3 empty1.4 void0.5 tmp-ra.60))
     (call-undead (tmp-ra.60))
     (undead-out
      ((tmp-ra.60 rbp)
       ((rax tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.60 rbp)
       ((rax tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.60 rbp)
       ((rax tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.60 rbp)
       ((rax tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.60 rbp)
       ((rax tmp-ra.60 rbp) ((r15 rbp) (r15 rbp)))
       (ascii-char4.1 tmp-ra.60 rbp)
       (tmp-ra.60 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.60 (ascii-char4.1 void3.2 void2.3 empty1.4 void0.5 rax rbp))
       (void0.5 (rbp tmp-ra.60))
       (empty1.4 (rbp tmp-ra.60))
       (void2.3 (rbp tmp-ra.60))
       (void3.2 (rbp tmp-ra.60))
       (ascii-char4.1 (rbp tmp-ra.60))
       (rbp (ascii-char4.1 void3.2 void2.3 empty1.4 void0.5 r15 rax tmp-ra.60))
       (rax (rbp tmp-ra.60))
       (r15 (rbp)))))
    (define L.fun/void22132.4
      ((new-frames ())
       (locals (tmp-ra.55))
       (undead-out ((tmp-ra.55 rbp) (tmp-ra.55 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55)))))
      (begin (set! tmp-ra.55 r15) (set! rax 30) (jump tmp-ra.55 rbp rax)))
    (define L.fun/void22129.5
      ((new-frames ())
       (locals (tmp-ra.56))
       (undead-out ((tmp-ra.56 rbp) (tmp-ra.56 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56)))))
      (begin (set! tmp-ra.56 r15) (set! rax 30) (jump tmp-ra.56 rbp rax)))
    (define L.fun/void22131.6
      ((new-frames ())
       (locals (tmp-ra.57))
       (undead-out ((tmp-ra.57 rbp) (tmp-ra.57 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57)))))
      (begin (set! tmp-ra.57 r15) (set! rax 30) (jump tmp-ra.57 rbp rax)))
    (define L.fun/empty22130.7
      ((new-frames ())
       (locals (tmp-ra.58))
       (undead-out ((tmp-ra.58 rbp) (tmp-ra.58 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58)))))
      (begin (set! tmp-ra.58 r15) (set! rax 22) (jump tmp-ra.58 rbp rax)))
    (define L.fun/ascii-char22133.8
      ((new-frames ())
       (locals (tmp-ra.59))
       (undead-out ((tmp-ra.59 rbp) (tmp-ra.59 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59)))))
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
       tmp-ra.96))
     (call-undead
      (tmp.71
       tmp.70
       tmp.69
       tmp.81
       tmp.77
       tmp.78
       tmp.74
       ascii-char1.5
       tmp-ra.96))
     (undead-out
      ((tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (ascii-char1.5 tmp-ra.96 rbp)
       ((rax ascii-char1.5 tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (ascii-char1.5 tmp-ra.96 rbp)
       ((rax ascii-char1.5 tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (ascii-char1.5 tmp-ra.96 rbp)
       ((rax ascii-char1.5 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.71 ascii-char1.5 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.72 ascii-char1.5 tmp-ra.96 rbp)
       ((rax ascii-char1.5 tmp-ra.96 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.70 ascii-char1.5 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.70 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.74 tmp.70 ascii-char1.5 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.75 tmp.70 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.70 ascii-char1.5 tmp-ra.96 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.73 ascii-char1.5 tmp-ra.96 rbp)
       ((rax ascii-char1.5 tmp-ra.96 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.69 ascii-char1.5 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.69 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.78 tmp.69 ascii-char1.5 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.79 tmp.69 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.69 ascii-char1.5 tmp-ra.96 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.69 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.77 tmp.69 ascii-char1.5 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.77 tmp.69 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.81 tmp.77 tmp.69 ascii-char1.5 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.82 tmp.77 tmp.69 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.77 tmp.69 ascii-char1.5 tmp-ra.96 rbp)
        ((tmp.81 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.80 tmp.69 ascii-char1.5 tmp-ra.96 rbp)
       ((rax tmp.69 ascii-char1.5 tmp-ra.96 rbp)
        ((tmp.77 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.76 ascii-char1.5 tmp-ra.96 rbp)
       ((rax ascii-char1.5 tmp-ra.96 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (ascii-char1.5 tmp-ra.96 rbp)
       ((rax ascii-char1.5 tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (ascii-char1.5 tmp-ra.96 rbp)
       (tmp-ra.96 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.96
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
         rax
         rbp))
       (ascii-char0.6 (rbp tmp-ra.96))
       (ascii-char1.5
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
         rax
         rbp
         tmp-ra.96))
       (empty2.4 (rbp tmp-ra.96 ascii-char1.5))
       (error3.3 (rbp tmp-ra.96 ascii-char1.5))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.96 ascii-char1.5))
       (tmp.72 (rbp tmp-ra.96 ascii-char1.5 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.96 ascii-char1.5))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.96 ascii-char1.5 tmp.70))
       (tmp.75 (rbp tmp-ra.96 ascii-char1.5 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.96 ascii-char1.5 tmp.70))
       (tmp.69
        (rsi
         tmp.76
         tmp.80
         tmp.82
         tmp.81
         tmp.77
         tmp.79
         tmp.78
         rax
         rbp
         tmp-ra.96
         ascii-char1.5))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.96 ascii-char1.5 tmp.69))
       (tmp.79 (rbp tmp-ra.96 ascii-char1.5 tmp.69 tmp.78))
       (tmp.77
        (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.96 ascii-char1.5 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.96 ascii-char1.5 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.96 ascii-char1.5 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.96 ascii-char1.5 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.96 ascii-char1.5 tmp.69))
       (fixnum4.2 (rbp tmp-ra.96 ascii-char1.5))
       (void5.1 (rbp tmp-ra.96 ascii-char1.5))
       (rbp
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
         rdi
         rsi
         error3.3
         empty2.4
         ascii-char1.5
         ascii-char0.6
         r15
         rax
         tmp-ra.96))
       (rax
        (tmp.81
         tmp.77
         tmp.78
         tmp.69
         tmp.74
         tmp.70
         tmp.71
         ascii-char1.5
         rbp
         tmp-ra.96))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi)))))
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
         tmp.56))
       (undead-out
        ((rdi rsi tmp-ra.83 rbp)
         (rsi tmp.24 tmp-ra.83 rbp)
         (tmp.24 tmp.25 tmp-ra.83 rbp)
         ((((((tmp.97 tmp.24 tmp.25 tmp-ra.83 rbp)
              (tmp.97 tmp.24 tmp.25 tmp-ra.83 rbp)
              (tmp.57 tmp.24 tmp.25 tmp-ra.83 rbp))
             (tmp.24 tmp.25 tmp-ra.83 rbp))
            (tmp.56 tmp.24 tmp.25 tmp-ra.83 rbp)
            (tmp.56 tmp.24 tmp.25 tmp-ra.83 rbp))
           (tmp.24 tmp.25 tmp-ra.83 rbp))
          ((((((tmp.98 tmp.24 tmp.25 tmp-ra.83 rbp)
               (tmp.98 tmp.24 tmp.25 tmp-ra.83 rbp)
               (tmp.59 tmp.24 tmp.25 tmp-ra.83 rbp))
              (tmp.24 tmp.25 tmp-ra.83 rbp))
             (tmp.58 tmp.24 tmp.25 tmp-ra.83 rbp)
             (tmp.58 tmp.24 tmp.25 tmp-ra.83 rbp))
            (tmp.24 tmp.25 tmp-ra.83 rbp))
           ((tmp.25 tmp.99 tmp-ra.83 rbp)
            (tmp.99 tmp-ra.83 rbp)
            (tmp-ra.83 rax rbp)
            (rax rbp))
           ((tmp-ra.83 rax rbp) (rax rbp)))
          ((tmp-ra.83 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.83 tmp.25 tmp.24))
         (tmp.97 (tmp.25 rbp tmp-ra.83 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.83
           tmp.24
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99))
         (tmp.57 (rbp tmp-ra.83 tmp.25 tmp.24))
         (tmp-ra.83
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99
           rax))
         (tmp.99 (rbp tmp-ra.83 tmp.25))
         (tmp.59 (rbp tmp-ra.83 tmp.25 tmp.24))
         (tmp.24
          (tmp.25 rbp tmp-ra.83 rsi tmp.97 tmp.57 tmp.56 tmp.98 tmp.59 tmp.58))
         (tmp.98 (tmp.24 rbp tmp-ra.83 tmp.25))
         (tmp.58 (rbp tmp-ra.83 tmp.25 tmp.24))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.83
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99
           rax))
         (rdi (tmp-ra.83))
         (rsi (tmp.24 tmp-ra.83)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.84 rbp)
         (rsi tmp.22 tmp-ra.84 rbp)
         (tmp.22 tmp.23 tmp-ra.84 rbp)
         ((((((tmp.100 tmp.22 tmp.23 tmp-ra.84 rbp)
              (tmp.100 tmp.22 tmp.23 tmp-ra.84 rbp)
              (tmp.61 tmp.22 tmp.23 tmp-ra.84 rbp))
             (tmp.22 tmp.23 tmp-ra.84 rbp))
            (tmp.60 tmp.22 tmp.23 tmp-ra.84 rbp)
            (tmp.60 tmp.22 tmp.23 tmp-ra.84 rbp))
           (tmp.22 tmp.23 tmp-ra.84 rbp))
          ((((((tmp.101 tmp.22 tmp.23 tmp-ra.84 rbp)
               (tmp.101 tmp.22 tmp.23 tmp-ra.84 rbp)
               (tmp.63 tmp.22 tmp.23 tmp-ra.84 rbp))
              (tmp.22 tmp.23 tmp-ra.84 rbp))
             (tmp.62 tmp.22 tmp.23 tmp-ra.84 rbp)
             (tmp.62 tmp.22 tmp.23 tmp-ra.84 rbp))
            (tmp.22 tmp.23 tmp-ra.84 rbp))
           ((tmp.23 tmp.102 tmp-ra.84 rbp)
            (tmp.102 tmp-ra.84 rbp)
            (tmp-ra.84 rax rbp)
            (rax rbp))
           ((tmp-ra.84 rax rbp) (rax rbp)))
          ((tmp-ra.84 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.84 tmp.23 tmp.22))
         (tmp.100 (tmp.23 rbp tmp-ra.84 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.84
           tmp.22
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.102))
         (tmp.61 (rbp tmp-ra.84 tmp.23 tmp.22))
         (tmp-ra.84
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.102
           rax))
         (tmp.102 (rbp tmp-ra.84 tmp.23))
         (tmp.63 (rbp tmp-ra.84 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.84
           rsi
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62))
         (tmp.101 (tmp.22 rbp tmp-ra.84 tmp.23))
         (tmp.62 (rbp tmp-ra.84 tmp.23 tmp.22))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.84
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.102
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.22 tmp-ra.84)))))
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
         tmp.64))
       (undead-out
        ((rdi rsi tmp-ra.85 rbp)
         (rsi tmp.20 tmp-ra.85 rbp)
         (tmp.21 tmp.20 tmp-ra.85 rbp)
         ((((((tmp.103 tmp.21 tmp.20 tmp-ra.85 rbp)
              (tmp.103 tmp.21 tmp.20 tmp-ra.85 rbp)
              (tmp.65 tmp.21 tmp.20 tmp-ra.85 rbp))
             (tmp.21 tmp.20 tmp-ra.85 rbp))
            (tmp.64 tmp.21 tmp.20 tmp-ra.85 rbp)
            (tmp.64 tmp.21 tmp.20 tmp-ra.85 rbp))
           (tmp.21 tmp.20 tmp-ra.85 rbp))
          ((((((tmp.104 tmp.21 tmp.20 tmp-ra.85 rbp)
               (tmp.104 tmp.21 tmp.20 tmp-ra.85 rbp)
               (tmp.67 tmp.21 tmp.20 tmp-ra.85 rbp))
              (tmp.21 tmp.20 tmp-ra.85 rbp))
             (tmp.66 tmp.21 tmp.20 tmp-ra.85 rbp)
             (tmp.66 tmp.21 tmp.20 tmp-ra.85 rbp))
            (tmp.21 tmp.20 tmp-ra.85 rbp))
           ((tmp.105 tmp.20 tmp-ra.85 rbp)
            (tmp.105 tmp.20 tmp-ra.85 rbp)
            (tmp.20 tmp.68 tmp-ra.85 rbp)
            (tmp.68 tmp.106 tmp-ra.85 rbp)
            (tmp.106 tmp-ra.85 rbp)
            (tmp-ra.85 rax rbp)
            (rax rbp))
           ((tmp-ra.85 rax rbp) (rax rbp)))
          ((tmp-ra.85 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp.103 (tmp.21 rbp tmp-ra.85 tmp.20))
         (tmp.21
          (rbp tmp-ra.85 tmp.20 tmp.103 tmp.65 tmp.64 tmp.104 tmp.67 tmp.66))
         (tmp.65 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp-ra.85
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.103
           tmp.65
           tmp.64
           tmp.104
           tmp.67
           tmp.66
           tmp.106
           tmp.68
           tmp.105
           rax))
         (tmp.105 (rbp tmp-ra.85 tmp.20))
         (tmp.68 (tmp.106 rbp tmp-ra.85 tmp.20))
         (tmp.106 (rbp tmp-ra.85 tmp.68))
         (tmp.67 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.85
           rsi
           tmp.103
           tmp.65
           tmp.64
           tmp.104
           tmp.67
           tmp.66
           tmp.68
           tmp.105))
         (tmp.104 (tmp.20 rbp tmp-ra.85 tmp.21))
         (tmp.66 (rbp tmp-ra.85 tmp.20 tmp.21))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.85
           tmp.103
           tmp.65
           tmp.64
           tmp.104
           tmp.67
           tmp.66
           tmp.106
           tmp.68
           tmp.105
           rax))
         (rdi (tmp-ra.85))
         (rsi (tmp.20 tmp-ra.85)))))
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
      ((new-frames ())
       (locals (tmp-ra.86))
       (undead-out ((tmp-ra.86 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.86 (rbp)) (rbp (r15 tmp-ra.86)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.86 r15)
        (set! r15 tmp-ra.86)
        (jump L.fun/ascii-char35207.9 rbp r15)))
    (define L.fun/ascii-char35208.5
      ((new-frames ())
       (locals (tmp-ra.87))
       (undead-out ((tmp-ra.87 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.87 (rbp)) (rbp (r15 tmp-ra.87)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/ascii-char35209.10 rbp r15)))
    (define L.fun/empty35210.6
      ((new-frames ())
       (locals (tmp-ra.88))
       (undead-out ((tmp-ra.88 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.88 (rbp)) (rbp (r15 tmp-ra.88)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/empty35211.13 rbp r15)))
    (define L.fun/error35213.7
      ((new-frames ())
       (locals (tmp-ra.89))
       (undead-out ((tmp-ra.89 rbp) (tmp-ra.89 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89)))))
      (begin (set! tmp-ra.89 r15) (set! rax 36414) (jump tmp-ra.89 rbp rax)))
    (define L.fun/void35214.8
      ((new-frames ())
       (locals (tmp-ra.90))
       (undead-out ((tmp-ra.90 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.90 (rbp)) (rbp (r15 tmp-ra.90)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/void35215.11 rbp r15)))
    (define L.fun/ascii-char35207.9
      ((new-frames ())
       (locals (tmp-ra.91))
       (undead-out ((tmp-ra.91 rbp) (tmp-ra.91 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.91 (rax rbp)) (rbp (rax tmp-ra.91)) (rax (rbp tmp-ra.91)))))
      (begin (set! tmp-ra.91 r15) (set! rax 25390) (jump tmp-ra.91 rbp rax)))
    (define L.fun/ascii-char35209.10
      ((new-frames ())
       (locals (tmp-ra.92))
       (undead-out ((tmp-ra.92 rbp) (tmp-ra.92 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.92 (rax rbp)) (rbp (rax tmp-ra.92)) (rax (rbp tmp-ra.92)))))
      (begin (set! tmp-ra.92 r15) (set! rax 25390) (jump tmp-ra.92 rbp rax)))
    (define L.fun/void35215.11
      ((new-frames ())
       (locals (tmp-ra.93))
       (undead-out ((tmp-ra.93 rbp) (tmp-ra.93 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93)))))
      (begin (set! tmp-ra.93 r15) (set! rax 30) (jump tmp-ra.93 rbp rax)))
    (define L.fun/error35212.12
      ((new-frames ())
       (locals (tmp-ra.94))
       (undead-out ((tmp-ra.94 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error35213.7 rbp r15)))
    (define L.fun/empty35211.13
      ((new-frames ())
       (locals (tmp-ra.95))
       (undead-out ((tmp-ra.95 rbp) (tmp-ra.95 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95)))))
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
       tmp-ra.102))
     (call-undead
      (tmp.74 tmp.73 tmp.72 tmp.84 tmp.80 tmp.81 tmp.77 tmp-ra.102))
     (undead-out
      ((tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.71 tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp-ra.102 rbp)
       ((rax tmp.74 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.75 tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.73 tmp-ra.102 rbp)
       ((rax tmp.73 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.73 tmp-ra.102 rbp)
       ((rax tmp.77 tmp.73 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.78 tmp.73 tmp-ra.102 rbp)
       ((rax tmp.73 tmp-ra.102 rbp)
        ((tmp.77 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.73 tmp.76 tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp)
        ((tmp.73 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp-ra.102 rbp)
       ((rax tmp.72 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.72 tmp-ra.102 rbp)
       ((rax tmp.81 tmp.72 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.82 tmp.72 tmp-ra.102 rbp)
       ((rax tmp.72 tmp-ra.102 rbp)
        ((tmp.81 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.80 tmp.72 tmp-ra.102 rbp)
       ((rax tmp.80 tmp.72 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 tmp.80 tmp.72 tmp-ra.102 rbp)
       ((rax tmp.84 tmp.80 tmp.72 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 tmp.85 tmp.80 tmp.72 tmp-ra.102 rbp)
       ((rax tmp.80 tmp.72 tmp-ra.102 rbp)
        ((tmp.84 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.80 tmp.83 tmp.72 tmp-ra.102 rbp)
       ((rax tmp.72 tmp-ra.102 rbp)
        ((tmp.80 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.79 tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.86 tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp-ra.102 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.102
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
         rax
         rbp))
       (empty0.6 (rbp tmp-ra.102))
       (empty1.5 (rbp tmp-ra.102))
       (tmp.71 (rbp tmp-ra.102))
       (boolean2.4 (rbp tmp-ra.102))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.102))
       (tmp.75 (rbp tmp-ra.102 tmp.74))
       (tmp.73 (rsi tmp.76 tmp.78 tmp.77 rax rbp tmp-ra.102))
       (tmp.77 (rsi tmp.78 rax rbp tmp-ra.102 tmp.73))
       (tmp.78 (rbp tmp-ra.102 tmp.73 tmp.77))
       (tmp.76 (rbp tmp-ra.102 tmp.73))
       (tmp.72
        (rsi
         tmp.79
         tmp.83
         tmp.85
         tmp.84
         tmp.80
         tmp.82
         tmp.81
         rax
         rbp
         tmp-ra.102))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.102 tmp.72))
       (tmp.82 (rbp tmp-ra.102 tmp.72 tmp.81))
       (tmp.80 (rsi tmp.83 tmp.85 tmp.84 rax rbp tmp-ra.102 tmp.72))
       (tmp.84 (rsi tmp.85 rax rbp tmp-ra.102 tmp.72 tmp.80))
       (tmp.85 (rbp tmp-ra.102 tmp.72 tmp.80 tmp.84))
       (tmp.83 (rbp tmp-ra.102 tmp.72 tmp.80))
       (tmp.79 (rbp tmp-ra.102 tmp.72))
       (fixnum3.3 (rbp tmp-ra.102))
       (empty4.2 (rbp tmp-ra.102))
       (tmp.86 (rbp tmp-ra.102))
       (boolean5.1 (rbp tmp-ra.102))
       (rbp
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
         rsi
         boolean2.4
         rdi
         tmp.71
         empty1.5
         empty0.6
         r15
         rax
         tmp-ra.102))
       (rax (tmp.84 tmp.80 tmp.81 tmp.72 tmp.77 tmp.73 tmp.74 rbp tmp-ra.102))
       (r15 (rsi rdi rbp))
       (rdi (rsi r15 rbp))
       (rsi (tmp.72 tmp.80 tmp.84 tmp.81 tmp.73 tmp.77 tmp.74 r15 rdi rbp)))))
    (define L.error?.19
      ((new-frames ())
       (locals (tmp-ra.87 tmp.103 tmp.48 tmp.56))
       (undead-out
        ((rdi tmp-ra.87 rbp)
         (tmp.48 tmp-ra.87 rbp)
         ((((tmp.103 tmp-ra.87 rbp)
            (tmp.103 tmp-ra.87 rbp)
            (tmp.56 tmp-ra.87 rbp))
           (tmp-ra.87 rbp))
          ((tmp-ra.87 rax rbp) (rax rbp))
          ((tmp-ra.87 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.87))
         (tmp.48 (rbp tmp-ra.87))
         (tmp.103 (rbp tmp-ra.87))
         (tmp-ra.87 (tmp.48 rbp rdi tmp.103 tmp.56 rax))
         (rax (rbp tmp-ra.87))
         (rbp (tmp.48 tmp-ra.87 tmp.103 tmp.56 rax))
         (rdi (tmp-ra.87)))))
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
         tmp.57))
       (undead-out
        ((rdi rsi tmp-ra.88 rbp)
         (rsi tmp.22 tmp-ra.88 rbp)
         (tmp.22 tmp.23 tmp-ra.88 rbp)
         ((((((tmp.104 tmp.22 tmp.23 tmp-ra.88 rbp)
              (tmp.104 tmp.22 tmp.23 tmp-ra.88 rbp)
              (tmp.58 tmp.22 tmp.23 tmp-ra.88 rbp))
             (tmp.22 tmp.23 tmp-ra.88 rbp))
            (tmp.57 tmp.22 tmp.23 tmp-ra.88 rbp)
            (tmp.57 tmp.22 tmp.23 tmp-ra.88 rbp))
           (tmp.22 tmp.23 tmp-ra.88 rbp))
          ((((((tmp.105 tmp.22 tmp.23 tmp-ra.88 rbp)
               (tmp.105 tmp.22 tmp.23 tmp-ra.88 rbp)
               (tmp.60 tmp.22 tmp.23 tmp-ra.88 rbp))
              (tmp.22 tmp.23 tmp-ra.88 rbp))
             (tmp.59 tmp.22 tmp.23 tmp-ra.88 rbp)
             (tmp.59 tmp.22 tmp.23 tmp-ra.88 rbp))
            (tmp.22 tmp.23 tmp-ra.88 rbp))
           ((tmp.23 tmp.106 tmp-ra.88 rbp)
            (tmp.106 tmp-ra.88 rbp)
            (tmp-ra.88 rax rbp)
            (rax rbp))
           ((tmp-ra.88 rax rbp) (rax rbp)))
          ((tmp-ra.88 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.88 tmp.23 tmp.22))
         (tmp.104 (tmp.23 rbp tmp-ra.88 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.88
           tmp.22
           tmp.104
           tmp.58
           tmp.57
           tmp.105
           tmp.60
           tmp.59
           tmp.106))
         (tmp.58 (rbp tmp-ra.88 tmp.23 tmp.22))
         (tmp-ra.88
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.104
           tmp.58
           tmp.57
           tmp.105
           tmp.60
           tmp.59
           tmp.106
           rax))
         (tmp.106 (rbp tmp-ra.88 tmp.23))
         (tmp.60 (rbp tmp-ra.88 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.88
           rsi
           tmp.104
           tmp.58
           tmp.57
           tmp.105
           tmp.60
           tmp.59))
         (tmp.105 (tmp.22 rbp tmp-ra.88 tmp.23))
         (tmp.59 (rbp tmp-ra.88 tmp.23 tmp.22))
         (rax (rbp tmp-ra.88))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.88
           tmp.104
           tmp.58
           tmp.57
           tmp.105
           tmp.60
           tmp.59
           tmp.106
           rax))
         (rdi (tmp-ra.88))
         (rsi (tmp.22 tmp-ra.88)))))
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
         tmp.61))
       (undead-out
        ((rdi rsi tmp-ra.89 rbp)
         (rsi tmp.24 tmp-ra.89 rbp)
         (tmp.24 tmp.25 tmp-ra.89 rbp)
         ((((((tmp.107 tmp.24 tmp.25 tmp-ra.89 rbp)
              (tmp.107 tmp.24 tmp.25 tmp-ra.89 rbp)
              (tmp.62 tmp.24 tmp.25 tmp-ra.89 rbp))
             (tmp.24 tmp.25 tmp-ra.89 rbp))
            (tmp.61 tmp.24 tmp.25 tmp-ra.89 rbp)
            (tmp.61 tmp.24 tmp.25 tmp-ra.89 rbp))
           (tmp.24 tmp.25 tmp-ra.89 rbp))
          ((((((tmp.108 tmp.24 tmp.25 tmp-ra.89 rbp)
               (tmp.108 tmp.24 tmp.25 tmp-ra.89 rbp)
               (tmp.64 tmp.24 tmp.25 tmp-ra.89 rbp))
              (tmp.24 tmp.25 tmp-ra.89 rbp))
             (tmp.63 tmp.24 tmp.25 tmp-ra.89 rbp)
             (tmp.63 tmp.24 tmp.25 tmp-ra.89 rbp))
            (tmp.24 tmp.25 tmp-ra.89 rbp))
           ((tmp.25 tmp.109 tmp-ra.89 rbp)
            (tmp.109 tmp-ra.89 rbp)
            (tmp-ra.89 rax rbp)
            (rax rbp))
           ((tmp-ra.89 rax rbp) (rax rbp)))
          ((tmp-ra.89 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.89 tmp.25 tmp.24))
         (tmp.107 (tmp.25 rbp tmp-ra.89 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.89
           tmp.24
           tmp.107
           tmp.62
           tmp.61
           tmp.108
           tmp.64
           tmp.63
           tmp.109))
         (tmp.62 (rbp tmp-ra.89 tmp.25 tmp.24))
         (tmp-ra.89
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.107
           tmp.62
           tmp.61
           tmp.108
           tmp.64
           tmp.63
           tmp.109
           rax))
         (tmp.109 (rbp tmp-ra.89 tmp.25))
         (tmp.64 (rbp tmp-ra.89 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.89
           rsi
           tmp.107
           tmp.62
           tmp.61
           tmp.108
           tmp.64
           tmp.63))
         (tmp.108 (tmp.24 rbp tmp-ra.89 tmp.25))
         (tmp.63 (rbp tmp-ra.89 tmp.25 tmp.24))
         (rax (rbp tmp-ra.89))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.89
           tmp.107
           tmp.62
           tmp.61
           tmp.108
           tmp.64
           tmp.63
           tmp.109
           rax))
         (rdi (tmp-ra.89))
         (rsi (tmp.24 tmp-ra.89)))))
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
         tmp.65))
       (undead-out
        ((rdi rsi tmp-ra.90 rbp)
         (rsi tmp.20 tmp-ra.90 rbp)
         (tmp.21 tmp.20 tmp-ra.90 rbp)
         ((((((tmp.110 tmp.21 tmp.20 tmp-ra.90 rbp)
              (tmp.110 tmp.21 tmp.20 tmp-ra.90 rbp)
              (tmp.66 tmp.21 tmp.20 tmp-ra.90 rbp))
             (tmp.21 tmp.20 tmp-ra.90 rbp))
            (tmp.65 tmp.21 tmp.20 tmp-ra.90 rbp)
            (tmp.65 tmp.21 tmp.20 tmp-ra.90 rbp))
           (tmp.21 tmp.20 tmp-ra.90 rbp))
          ((((((tmp.111 tmp.21 tmp.20 tmp-ra.90 rbp)
               (tmp.111 tmp.21 tmp.20 tmp-ra.90 rbp)
               (tmp.68 tmp.21 tmp.20 tmp-ra.90 rbp))
              (tmp.21 tmp.20 tmp-ra.90 rbp))
             (tmp.67 tmp.21 tmp.20 tmp-ra.90 rbp)
             (tmp.67 tmp.21 tmp.20 tmp-ra.90 rbp))
            (tmp.21 tmp.20 tmp-ra.90 rbp))
           ((tmp.112 tmp.20 tmp-ra.90 rbp)
            (tmp.112 tmp.20 tmp-ra.90 rbp)
            (tmp.20 tmp.69 tmp-ra.90 rbp)
            (tmp.69 tmp.113 tmp-ra.90 rbp)
            (tmp.113 tmp-ra.90 rbp)
            (tmp-ra.90 rax rbp)
            (rax rbp))
           ((tmp-ra.90 rax rbp) (rax rbp)))
          ((tmp-ra.90 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.90 tmp.20 tmp.21))
         (tmp.110 (tmp.21 rbp tmp-ra.90 tmp.20))
         (tmp.21
          (rbp tmp-ra.90 tmp.20 tmp.110 tmp.66 tmp.65 tmp.111 tmp.68 tmp.67))
         (tmp.66 (rbp tmp-ra.90 tmp.20 tmp.21))
         (tmp-ra.90
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.110
           tmp.66
           tmp.65
           tmp.111
           tmp.68
           tmp.67
           tmp.113
           tmp.69
           tmp.112
           rax))
         (tmp.112 (rbp tmp-ra.90 tmp.20))
         (tmp.69 (tmp.113 rbp tmp-ra.90 tmp.20))
         (tmp.113 (rbp tmp-ra.90 tmp.69))
         (tmp.68 (rbp tmp-ra.90 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.90
           rsi
           tmp.110
           tmp.66
           tmp.65
           tmp.111
           tmp.68
           tmp.67
           tmp.69
           tmp.112))
         (tmp.111 (tmp.20 rbp tmp-ra.90 tmp.21))
         (tmp.67 (rbp tmp-ra.90 tmp.20 tmp.21))
         (rax (rbp tmp-ra.90))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.90
           tmp.110
           tmp.66
           tmp.65
           tmp.111
           tmp.68
           tmp.67
           tmp.113
           tmp.69
           tmp.112
           rax))
         (rdi (tmp-ra.90))
         (rsi (tmp.20 tmp-ra.90)))))
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
      ((new-frames ())
       (locals (tmp-ra.91 tmp.114 tmp.46 tmp.70))
       (undead-out
        ((rdi tmp-ra.91 rbp)
         (tmp.46 tmp-ra.91 rbp)
         ((((tmp.114 tmp-ra.91 rbp)
            (tmp.114 tmp-ra.91 rbp)
            (tmp.70 tmp-ra.91 rbp))
           (tmp-ra.91 rbp))
          ((tmp-ra.91 rax rbp) (rax rbp))
          ((tmp-ra.91 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.70 (rbp tmp-ra.91))
         (tmp.46 (rbp tmp-ra.91))
         (tmp.114 (rbp tmp-ra.91))
         (tmp-ra.91 (tmp.46 rbp rdi tmp.114 tmp.70 rax))
         (rax (rbp tmp-ra.91))
         (rbp (tmp.46 tmp-ra.91 tmp.114 tmp.70 rax))
         (rdi (tmp-ra.91)))))
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
      ((new-frames ())
       (locals (tmp-ra.92))
       (undead-out ((tmp-ra.92 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/void43342.11 rbp r15)))
    (define L.fun/empty43339.5
      ((new-frames ())
       (locals (tmp-ra.93))
       (undead-out ((tmp-ra.93 rbp) (tmp-ra.93 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93)))))
      (begin (set! tmp-ra.93 r15) (set! rax 22) (jump tmp-ra.93 rbp rax)))
    (define L.fun/any43337.6
      ((new-frames ())
       (locals (tmp-ra.94))
       (undead-out ((tmp-ra.94 rbp) (tmp-ra.94 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.94 (rax rbp)) (rbp (rax tmp-ra.94)) (rax (rbp tmp-ra.94)))))
      (begin (set! tmp-ra.94 r15) (set! rax 13630) (jump tmp-ra.94 rbp rax)))
    (define L.fun/any43340.7
      ((new-frames ())
       (locals (tmp-ra.95))
       (undead-out ((tmp-ra.95 rbp) (tmp-ra.95 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95)))))
      (begin (set! tmp-ra.95 r15) (set! rax 480) (jump tmp-ra.95 rbp rax)))
    (define L.fun/empty43335.8
      ((new-frames ())
       (locals (tmp-ra.96))
       (undead-out ((tmp-ra.96 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.96 (rbp)) (rbp (r15 tmp-ra.96)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.96 r15)
        (set! r15 tmp-ra.96)
        (jump L.fun/empty43336.13 rbp r15)))
    (define L.fun/empty43333.9
      ((new-frames ())
       (locals (tmp-ra.97))
       (undead-out ((tmp-ra.97 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.97 (rbp)) (rbp (r15 tmp-ra.97)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/empty43334.12 rbp r15)))
    (define L.fun/empty43338.10
      ((new-frames ())
       (locals (tmp-ra.98))
       (undead-out ((tmp-ra.98 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.98 (rbp)) (rbp (r15 tmp-ra.98)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/empty43339.5 rbp r15)))
    (define L.fun/void43342.11
      ((new-frames ())
       (locals (tmp-ra.99))
       (undead-out ((tmp-ra.99 rbp) (tmp-ra.99 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.99 (rax rbp)) (rbp (rax tmp-ra.99)) (rax (rbp tmp-ra.99)))))
      (begin (set! tmp-ra.99 r15) (set! rax 30) (jump tmp-ra.99 rbp rax)))
    (define L.fun/empty43334.12
      ((new-frames ())
       (locals (tmp-ra.100))
       (undead-out ((tmp-ra.100 rbp) (tmp-ra.100 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.100 (rax rbp))
         (rbp (rax tmp-ra.100))
         (rax (rbp tmp-ra.100)))))
      (begin (set! tmp-ra.100 r15) (set! rax 22) (jump tmp-ra.100 rbp rax)))
    (define L.fun/empty43336.13
      ((new-frames ())
       (locals (tmp-ra.101))
       (undead-out ((tmp-ra.101 rbp) (tmp-ra.101 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.101 (rax rbp))
         (rbp (rax tmp-ra.101))
         (rax (rbp tmp-ra.101)))))
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
       tmp-ra.106))
     (call-undead
      (tmp.71
       tmp.70
       tmp.69
       tmp.81
       fixnum4.2
       tmp.85
       tmp.84
       tmp.83
       tmp.88
       tmp.77
       tmp.78
       tmp.74
       tmp-ra.106))
     (undead-out
      ((tmp-ra.106 rbp)
       ((rax tmp-ra.106 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.106 rbp)
       ((rax tmp-ra.106 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.106 rbp)
       ((rax tmp-ra.106 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.106 rbp)
       ((rax tmp-ra.106 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.106 rbp)
       ((rax tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.106 rbp)
       ((rax tmp.71 tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.72 tmp-ra.106 rbp)
       ((rax tmp-ra.106 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp-ra.106 rbp)
       ((rax tmp.70 tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.70 tmp-ra.106 rbp)
       ((rax tmp.74 tmp.70 tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.75 tmp.70 tmp-ra.106 rbp)
       ((rax tmp.70 tmp-ra.106 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.73 tmp-ra.106 rbp)
       ((rax tmp-ra.106 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.106 rbp)
       ((rax tmp.69 tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.69 tmp-ra.106 rbp)
       ((rax tmp.78 tmp.69 tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.79 tmp.69 tmp-ra.106 rbp)
       ((rax tmp.69 tmp-ra.106 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.69 tmp-ra.106 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.77 tmp.69 tmp-ra.106 rbp)
       ((rax tmp.81 tmp.77 tmp.69 tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.82 tmp.77 tmp.69 tmp-ra.106 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.106 rbp)
        ((tmp.81 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.80 tmp.69 tmp-ra.106 rbp)
       ((rax tmp.69 tmp-ra.106 rbp)
        ((tmp.77 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.76 tmp-ra.106 rbp)
       ((rax tmp-ra.106 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (fixnum4.2 tmp-ra.106 rbp)
       ((rax fixnum4.2 tmp-ra.106 rbp) ((r15 rbp) (r15 rbp)))
       (fixnum4.2 tmp-ra.106 rbp)
       ((rax fixnum4.2 tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 fixnum4.2 tmp-ra.106 rbp)
       ((rax tmp.85 fixnum4.2 tmp-ra.106 rbp)
        ((fixnum4.2 rsi rbp)
         (rsi rdi rbp)
         (rsi rdi r15 rbp)
         (rsi rdi r15 rbp)))
       (tmp.85 tmp.86 fixnum4.2 tmp-ra.106 rbp)
       ((rax fixnum4.2 tmp-ra.106 rbp)
        ((tmp.85 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 fixnum4.2 tmp-ra.106 rbp)
       ((rax tmp.84 fixnum4.2 tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.88 tmp.84 fixnum4.2 tmp-ra.106 rbp)
       ((rax tmp.88 tmp.84 fixnum4.2 tmp-ra.106 rbp)
        ((fixnum4.2 rsi rbp)
         (rsi rdi rbp)
         (rsi rdi r15 rbp)
         (rsi rdi r15 rbp)))
       (tmp.88 tmp.89 tmp.84 fixnum4.2 tmp-ra.106 rbp)
       ((rax tmp.84 fixnum4.2 tmp-ra.106 rbp)
        ((tmp.88 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 tmp.87 fixnum4.2 tmp-ra.106 rbp)
       ((rax fixnum4.2 tmp-ra.106 rbp)
        ((tmp.84 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (fixnum4.2 tmp.83 tmp-ra.106 rbp)
       ((rax fixnum4.2 tmp.83 tmp-ra.106 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 fixnum4.2 tmp.83 tmp-ra.106 rbp)
       ((rax fixnum4.2 tmp.83 tmp-ra.106 rbp)
        ((fixnum4.2 rsi rbp)
         (rsi rdi rbp)
         (rsi rdi r15 rbp)
         (rsi rdi r15 rbp)))
       (fixnum4.2 tmp.91 tmp.83 tmp-ra.106 rbp)
       ((rax tmp.83 tmp-ra.106 rbp)
        ((fixnum4.2 rsi rbp)
         (rsi rdi rbp)
         (rsi rdi r15 rbp)
         (rsi rdi r15 rbp)))
       (tmp.90 tmp.83 tmp-ra.106 rbp)
       (tmp.83 tmp-ra.106 rsi rbp)
       (tmp-ra.106 rsi rdi rbp)
       (rsi rdi r15 rbp)
       (rsi rdi r15 rbp)))
     (conflicts
      ((tmp-ra.106
        (rdi
         rsi
         tmp.90
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
         rax
         rbp))
       (empty0.6 (rbp tmp-ra.106))
       (ascii-char1.5 (rbp tmp-ra.106))
       (ascii-char2.4 (rbp tmp-ra.106))
       (void3.3 (rbp tmp-ra.106))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.106))
       (tmp.72 (rbp tmp-ra.106 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.106))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.106 tmp.70))
       (tmp.75 (rbp tmp-ra.106 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.106 tmp.70))
       (tmp.69
        (rsi
         tmp.76
         tmp.80
         tmp.82
         tmp.81
         tmp.77
         tmp.79
         tmp.78
         rax
         rbp
         tmp-ra.106))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.106 tmp.69))
       (tmp.79 (rbp tmp-ra.106 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.106 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.106 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.106 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.106 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.106 tmp.69))
       (fixnum4.2
        (tmp.91
         tmp.92
         tmp.83
         tmp.87
         tmp.89
         tmp.88
         tmp.84
         tmp.86
         rsi
         tmp.85
         ascii-char5.1
         rax
         rbp
         tmp-ra.106))
       (ascii-char5.1 (rbp tmp-ra.106 fixnum4.2))
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.106 fixnum4.2))
       (tmp.86 (rbp tmp-ra.106 fixnum4.2 tmp.85))
       (tmp.84 (rsi tmp.87 tmp.89 tmp.88 rax rbp tmp-ra.106 fixnum4.2))
       (tmp.88 (rsi tmp.89 rax rbp tmp-ra.106 fixnum4.2 tmp.84))
       (tmp.89 (rbp tmp-ra.106 fixnum4.2 tmp.84 tmp.88))
       (tmp.87 (rbp tmp-ra.106 fixnum4.2 tmp.84))
       (tmp.83 (rsi tmp.90 tmp.91 tmp.92 rax rbp tmp-ra.106 fixnum4.2))
       (tmp.92 (rbp tmp-ra.106 tmp.83 fixnum4.2))
       (tmp.91 (rbp tmp-ra.106 tmp.83 fixnum4.2))
       (tmp.90 (rbp tmp-ra.106 tmp.83))
       (rbp
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
         rdi
         rsi
         void3.3
         ascii-char2.4
         ascii-char1.5
         empty0.6
         r15
         rax
         tmp-ra.106))
       (rax
        (tmp.83
         tmp.88
         tmp.84
         tmp.85
         fixnum4.2
         tmp.81
         tmp.77
         tmp.78
         tmp.69
         tmp.74
         tmp.70
         tmp.71
         rbp
         tmp-ra.106))
       (r15 (rdi rsi rbp))
       (rsi
        (tmp-ra.106
         tmp.83
         tmp.84
         tmp.88
         tmp.85
         fixnum4.2
         tmp.69
         tmp.77
         tmp.81
         tmp.78
         tmp.70
         tmp.74
         tmp.71
         r15
         rdi
         rbp))
       (rdi (tmp-ra.106 r15 rbp rsi)))))
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
         tmp.56))
       (undead-out
        ((rdi rsi tmp-ra.93 rbp)
         (rsi tmp.24 tmp-ra.93 rbp)
         (tmp.24 tmp.25 tmp-ra.93 rbp)
         ((((((tmp.107 tmp.24 tmp.25 tmp-ra.93 rbp)
              (tmp.107 tmp.24 tmp.25 tmp-ra.93 rbp)
              (tmp.57 tmp.24 tmp.25 tmp-ra.93 rbp))
             (tmp.24 tmp.25 tmp-ra.93 rbp))
            (tmp.56 tmp.24 tmp.25 tmp-ra.93 rbp)
            (tmp.56 tmp.24 tmp.25 tmp-ra.93 rbp))
           (tmp.24 tmp.25 tmp-ra.93 rbp))
          ((((((tmp.108 tmp.24 tmp.25 tmp-ra.93 rbp)
               (tmp.108 tmp.24 tmp.25 tmp-ra.93 rbp)
               (tmp.59 tmp.24 tmp.25 tmp-ra.93 rbp))
              (tmp.24 tmp.25 tmp-ra.93 rbp))
             (tmp.58 tmp.24 tmp.25 tmp-ra.93 rbp)
             (tmp.58 tmp.24 tmp.25 tmp-ra.93 rbp))
            (tmp.24 tmp.25 tmp-ra.93 rbp))
           ((tmp.25 tmp.109 tmp-ra.93 rbp)
            (tmp.109 tmp-ra.93 rbp)
            (tmp-ra.93 rax rbp)
            (rax rbp))
           ((tmp-ra.93 rax rbp) (rax rbp)))
          ((tmp-ra.93 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.93 tmp.25 tmp.24))
         (tmp.107 (tmp.25 rbp tmp-ra.93 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.93
           tmp.24
           tmp.107
           tmp.57
           tmp.56
           tmp.108
           tmp.59
           tmp.58
           tmp.109))
         (tmp.57 (rbp tmp-ra.93 tmp.25 tmp.24))
         (tmp-ra.93
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.107
           tmp.57
           tmp.56
           tmp.108
           tmp.59
           tmp.58
           tmp.109
           rax))
         (tmp.109 (rbp tmp-ra.93 tmp.25))
         (tmp.59 (rbp tmp-ra.93 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.93
           rsi
           tmp.107
           tmp.57
           tmp.56
           tmp.108
           tmp.59
           tmp.58))
         (tmp.108 (tmp.24 rbp tmp-ra.93 tmp.25))
         (tmp.58 (rbp tmp-ra.93 tmp.25 tmp.24))
         (rax (rbp tmp-ra.93))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.93
           tmp.107
           tmp.57
           tmp.56
           tmp.108
           tmp.59
           tmp.58
           tmp.109
           rax))
         (rdi (tmp-ra.93))
         (rsi (tmp.24 tmp-ra.93)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.94 rbp)
         (rsi tmp.22 tmp-ra.94 rbp)
         (tmp.22 tmp.23 tmp-ra.94 rbp)
         ((((((tmp.110 tmp.22 tmp.23 tmp-ra.94 rbp)
              (tmp.110 tmp.22 tmp.23 tmp-ra.94 rbp)
              (tmp.61 tmp.22 tmp.23 tmp-ra.94 rbp))
             (tmp.22 tmp.23 tmp-ra.94 rbp))
            (tmp.60 tmp.22 tmp.23 tmp-ra.94 rbp)
            (tmp.60 tmp.22 tmp.23 tmp-ra.94 rbp))
           (tmp.22 tmp.23 tmp-ra.94 rbp))
          ((((((tmp.111 tmp.22 tmp.23 tmp-ra.94 rbp)
               (tmp.111 tmp.22 tmp.23 tmp-ra.94 rbp)
               (tmp.63 tmp.22 tmp.23 tmp-ra.94 rbp))
              (tmp.22 tmp.23 tmp-ra.94 rbp))
             (tmp.62 tmp.22 tmp.23 tmp-ra.94 rbp)
             (tmp.62 tmp.22 tmp.23 tmp-ra.94 rbp))
            (tmp.22 tmp.23 tmp-ra.94 rbp))
           ((tmp.23 tmp.112 tmp-ra.94 rbp)
            (tmp.112 tmp-ra.94 rbp)
            (tmp-ra.94 rax rbp)
            (rax rbp))
           ((tmp-ra.94 rax rbp) (rax rbp)))
          ((tmp-ra.94 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.94 tmp.23 tmp.22))
         (tmp.110 (tmp.23 rbp tmp-ra.94 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.94
           tmp.22
           tmp.110
           tmp.61
           tmp.60
           tmp.111
           tmp.63
           tmp.62
           tmp.112))
         (tmp.61 (rbp tmp-ra.94 tmp.23 tmp.22))
         (tmp-ra.94
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.110
           tmp.61
           tmp.60
           tmp.111
           tmp.63
           tmp.62
           tmp.112
           rax))
         (tmp.112 (rbp tmp-ra.94 tmp.23))
         (tmp.63 (rbp tmp-ra.94 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.94
           rsi
           tmp.110
           tmp.61
           tmp.60
           tmp.111
           tmp.63
           tmp.62))
         (tmp.111 (tmp.22 rbp tmp-ra.94 tmp.23))
         (tmp.62 (rbp tmp-ra.94 tmp.23 tmp.22))
         (rax (rbp tmp-ra.94))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.94
           tmp.110
           tmp.61
           tmp.60
           tmp.111
           tmp.63
           tmp.62
           tmp.112
           rax))
         (rdi (tmp-ra.94))
         (rsi (tmp.22 tmp-ra.94)))))
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
         tmp.64))
       (undead-out
        ((rdi rsi tmp-ra.95 rbp)
         (rsi tmp.20 tmp-ra.95 rbp)
         (tmp.21 tmp.20 tmp-ra.95 rbp)
         ((((((tmp.113 tmp.21 tmp.20 tmp-ra.95 rbp)
              (tmp.113 tmp.21 tmp.20 tmp-ra.95 rbp)
              (tmp.65 tmp.21 tmp.20 tmp-ra.95 rbp))
             (tmp.21 tmp.20 tmp-ra.95 rbp))
            (tmp.64 tmp.21 tmp.20 tmp-ra.95 rbp)
            (tmp.64 tmp.21 tmp.20 tmp-ra.95 rbp))
           (tmp.21 tmp.20 tmp-ra.95 rbp))
          ((((((tmp.114 tmp.21 tmp.20 tmp-ra.95 rbp)
               (tmp.114 tmp.21 tmp.20 tmp-ra.95 rbp)
               (tmp.67 tmp.21 tmp.20 tmp-ra.95 rbp))
              (tmp.21 tmp.20 tmp-ra.95 rbp))
             (tmp.66 tmp.21 tmp.20 tmp-ra.95 rbp)
             (tmp.66 tmp.21 tmp.20 tmp-ra.95 rbp))
            (tmp.21 tmp.20 tmp-ra.95 rbp))
           ((tmp.115 tmp.20 tmp-ra.95 rbp)
            (tmp.115 tmp.20 tmp-ra.95 rbp)
            (tmp.20 tmp.68 tmp-ra.95 rbp)
            (tmp.68 tmp.116 tmp-ra.95 rbp)
            (tmp.116 tmp-ra.95 rbp)
            (tmp-ra.95 rax rbp)
            (rax rbp))
           ((tmp-ra.95 rax rbp) (rax rbp)))
          ((tmp-ra.95 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.95 tmp.20 tmp.21))
         (tmp.113 (tmp.21 rbp tmp-ra.95 tmp.20))
         (tmp.21
          (rbp tmp-ra.95 tmp.20 tmp.113 tmp.65 tmp.64 tmp.114 tmp.67 tmp.66))
         (tmp.65 (rbp tmp-ra.95 tmp.20 tmp.21))
         (tmp-ra.95
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.113
           tmp.65
           tmp.64
           tmp.114
           tmp.67
           tmp.66
           tmp.116
           tmp.68
           tmp.115
           rax))
         (tmp.115 (rbp tmp-ra.95 tmp.20))
         (tmp.68 (tmp.116 rbp tmp-ra.95 tmp.20))
         (tmp.116 (rbp tmp-ra.95 tmp.68))
         (tmp.67 (rbp tmp-ra.95 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.95
           rsi
           tmp.113
           tmp.65
           tmp.64
           tmp.114
           tmp.67
           tmp.66
           tmp.68
           tmp.115))
         (tmp.114 (tmp.20 rbp tmp-ra.95 tmp.21))
         (tmp.66 (rbp tmp-ra.95 tmp.20 tmp.21))
         (rax (rbp tmp-ra.95))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.95
           tmp.113
           tmp.65
           tmp.64
           tmp.114
           tmp.67
           tmp.66
           tmp.116
           tmp.68
           tmp.115
           rax))
         (rdi (tmp-ra.95))
         (rsi (tmp.20 tmp-ra.95)))))
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
      ((new-frames ())
       (locals (tmp-ra.96))
       (undead-out ((tmp-ra.96 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.96 (rbp)) (rbp (r15 tmp-ra.96)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.96 r15)
        (set! r15 tmp-ra.96)
        (jump L.fun/ascii-char44116.11 rbp r15)))
    (define L.fun/ascii-char44119.5
      ((new-frames ())
       (locals (tmp-ra.97))
       (undead-out ((tmp-ra.97 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.97 (rbp)) (rbp (r15 tmp-ra.97)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/ascii-char44120.10 rbp r15)))
    (define L.fun/empty44111.6
      ((new-frames ())
       (locals (tmp-ra.98))
       (undead-out ((tmp-ra.98 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.98 (rbp)) (rbp (r15 tmp-ra.98)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/empty44112.13 rbp r15)))
    (define L.fun/void44117.7
      ((new-frames ())
       (locals (tmp-ra.99))
       (undead-out ((tmp-ra.99 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.99 (rbp)) (rbp (r15 tmp-ra.99)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.99 r15)
        (set! r15 tmp-ra.99)
        (jump L.fun/void44118.9 rbp r15)))
    (define L.fun/ascii-char44114.8
      ((new-frames ())
       (locals (tmp-ra.100))
       (undead-out ((tmp-ra.100 rbp) (tmp-ra.100 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.100 (rax rbp))
         (rbp (rax tmp-ra.100))
         (rax (rbp tmp-ra.100)))))
      (begin (set! tmp-ra.100 r15) (set! rax 25390) (jump tmp-ra.100 rbp rax)))
    (define L.fun/void44118.9
      ((new-frames ())
       (locals (tmp-ra.101))
       (undead-out ((tmp-ra.101 rbp) (tmp-ra.101 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.101 (rax rbp))
         (rbp (rax tmp-ra.101))
         (rax (rbp tmp-ra.101)))))
      (begin (set! tmp-ra.101 r15) (set! rax 30) (jump tmp-ra.101 rbp rax)))
    (define L.fun/ascii-char44120.10
      ((new-frames ())
       (locals (tmp-ra.102))
       (undead-out ((tmp-ra.102 rbp) (tmp-ra.102 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.102 (rax rbp))
         (rbp (rax tmp-ra.102))
         (rax (rbp tmp-ra.102)))))
      (begin (set! tmp-ra.102 r15) (set! rax 25390) (jump tmp-ra.102 rbp rax)))
    (define L.fun/ascii-char44116.11
      ((new-frames ())
       (locals (tmp-ra.103))
       (undead-out ((tmp-ra.103 rbp) (tmp-ra.103 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.103 (rax rbp))
         (rbp (rax tmp-ra.103))
         (rax (rbp tmp-ra.103)))))
      (begin (set! tmp-ra.103 r15) (set! rax 25390) (jump tmp-ra.103 rbp rax)))
    (define L.fun/ascii-char44113.12
      ((new-frames ())
       (locals (tmp-ra.104))
       (undead-out ((tmp-ra.104 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.104 (rbp)) (rbp (r15 tmp-ra.104)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.104 r15)
        (set! r15 tmp-ra.104)
        (jump L.fun/ascii-char44114.8 rbp r15)))
    (define L.fun/empty44112.13
      ((new-frames ())
       (locals (tmp-ra.105))
       (undead-out ((tmp-ra.105 rbp) (tmp-ra.105 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.105 (rax rbp))
         (rbp (rax tmp-ra.105))
         (rax (rbp tmp-ra.105)))))
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
       tmp-ra.110))
     (call-undead
      (tmp.72
       tmp.71
       tmp.70
       tmp.82
       tmp.89
       tmp.93
       tmp.92
       ascii-char4.2
       tmp.96
       tmp.84
       tmp.85
       tmp.86
       tmp.78
       tmp.79
       tmp.75
       tmp-ra.110))
     (undead-out
      ((tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp-ra.110 rbp)
       ((rax tmp.72 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.73 tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.110 rbp)
       ((rax tmp.71 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp.71 tmp-ra.110 rbp)
       ((rax tmp.75 tmp.71 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp.76 tmp.71 tmp-ra.110 rbp)
       ((rax tmp.71 tmp-ra.110 rbp)
        ((tmp.75 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.74 tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp-ra.110 rbp)
       ((rax tmp.70 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.70 tmp-ra.110 rbp)
       ((rax tmp.79 tmp.70 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.80 tmp.70 tmp-ra.110 rbp)
       ((rax tmp.70 tmp-ra.110 rbp)
        ((tmp.79 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.70 tmp-ra.110 rbp)
       ((rax tmp.78 tmp.70 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.82 tmp.78 tmp.70 tmp-ra.110 rbp)
       ((rax tmp.82 tmp.78 tmp.70 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.82 tmp.83 tmp.78 tmp.70 tmp-ra.110 rbp)
       ((rax tmp.78 tmp.70 tmp-ra.110 rbp)
        ((tmp.82 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.81 tmp.70 tmp-ra.110 rbp)
       ((rax tmp.70 tmp-ra.110 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.77 tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.86 tmp-ra.110 rbp)
       ((rax tmp.86 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.86 tmp.87 tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp)
        ((tmp.86 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 tmp-ra.110 rbp)
       ((rax tmp.85 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.89 tmp.85 tmp-ra.110 rbp)
       ((rax tmp.89 tmp.85 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.89 tmp.90 tmp.85 tmp-ra.110 rbp)
       ((rax tmp.85 tmp-ra.110 rbp)
        ((tmp.89 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 tmp.88 tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp)
        ((tmp.85 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 tmp-ra.110 rbp)
       ((rax tmp.84 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.93 tmp.84 tmp-ra.110 rbp)
       ((rax tmp.93 tmp.84 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.93 tmp.94 tmp.84 tmp-ra.110 rbp)
       ((rax tmp.84 tmp-ra.110 rbp)
        ((tmp.93 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 tmp.84 tmp-ra.110 rbp)
       ((rax tmp.92 tmp.84 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.96 tmp.92 tmp.84 tmp-ra.110 rbp)
       ((rax tmp.96 tmp.92 tmp.84 tmp-ra.110 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.96 tmp.97 tmp.92 tmp.84 tmp-ra.110 rbp)
       ((rax tmp.92 tmp.84 tmp-ra.110 rbp)
        ((tmp.96 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 tmp.95 tmp.84 tmp-ra.110 rbp)
       ((rax tmp.84 tmp-ra.110 rbp)
        ((tmp.92 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 tmp.91 tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp)
        ((tmp.84 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.110 rbp)
       ((rax tmp-ra.110 rbp) ((r15 rbp) (r15 rbp)))
       (ascii-char4.2 tmp-ra.110 rbp)
       ((rax ascii-char4.2 tmp-ra.110 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.98 ascii-char4.2 tmp-ra.110 rbp)
       ((rax ascii-char4.2 tmp-ra.110 rbp)
        ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (ascii-char4.2 tmp-ra.110 rbp)
       (tmp-ra.110 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.110
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
         rax
         rbp))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.110))
       (tmp.73 (rbp tmp-ra.110 tmp.72))
       (tmp.71 (rsi tmp.74 tmp.76 tmp.75 rax rbp tmp-ra.110))
       (tmp.75 (rsi tmp.76 rax rbp tmp-ra.110 tmp.71))
       (tmp.76 (rbp tmp-ra.110 tmp.71 tmp.75))
       (tmp.74 (rbp tmp-ra.110 tmp.71))
       (tmp.70
        (rsi
         tmp.77
         tmp.81
         tmp.83
         tmp.82
         tmp.78
         tmp.80
         tmp.79
         rax
         rbp
         tmp-ra.110))
       (tmp.79 (rsi tmp.80 rax rbp tmp-ra.110 tmp.70))
       (tmp.80 (rbp tmp-ra.110 tmp.70 tmp.79))
       (tmp.78 (rsi tmp.81 tmp.83 tmp.82 rax rbp tmp-ra.110 tmp.70))
       (tmp.82 (rsi tmp.83 rax rbp tmp-ra.110 tmp.70 tmp.78))
       (tmp.83 (rbp tmp-ra.110 tmp.70 tmp.78 tmp.82))
       (tmp.81 (rbp tmp-ra.110 tmp.70 tmp.78))
       (tmp.77 (rbp tmp-ra.110 tmp.70))
       (fixnum0.6 (rbp tmp-ra.110))
       (tmp.86 (rsi tmp.87 rax rbp tmp-ra.110))
       (tmp.87 (rbp tmp-ra.110 tmp.86))
       (tmp.85 (rsi tmp.88 tmp.90 tmp.89 rax rbp tmp-ra.110))
       (tmp.89 (rsi tmp.90 rax rbp tmp-ra.110 tmp.85))
       (tmp.90 (rbp tmp-ra.110 tmp.85 tmp.89))
       (tmp.88 (rbp tmp-ra.110 tmp.85))
       (tmp.84
        (rsi
         tmp.91
         tmp.95
         tmp.97
         tmp.96
         tmp.92
         tmp.94
         tmp.93
         rax
         rbp
         tmp-ra.110))
       (tmp.93 (rsi tmp.94 rax rbp tmp-ra.110 tmp.84))
       (tmp.94 (rbp tmp-ra.110 tmp.84 tmp.93))
       (tmp.92 (rsi tmp.95 tmp.97 tmp.96 rax rbp tmp-ra.110 tmp.84))
       (tmp.96 (rsi tmp.97 rax rbp tmp-ra.110 tmp.84 tmp.92))
       (tmp.97 (rbp tmp-ra.110 tmp.84 tmp.92 tmp.96))
       (tmp.95 (rbp tmp-ra.110 tmp.84 tmp.92))
       (tmp.91 (rbp tmp-ra.110 tmp.84))
       (fixnum1.5 (rbp tmp-ra.110))
       (error2.4 (rbp tmp-ra.110))
       (empty3.3 (rbp tmp-ra.110))
       (ascii-char4.2 (boolean5.1 tmp.98 rax rbp tmp-ra.110))
       (tmp.98 (rbp tmp-ra.110 ascii-char4.2))
       (boolean5.1 (rbp tmp-ra.110 ascii-char4.2))
       (rbp
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
         r15
         rdi
         rsi
         rax
         tmp-ra.110))
       (rax
        (ascii-char4.2
         tmp.96
         tmp.92
         tmp.93
         tmp.84
         tmp.89
         tmp.85
         tmp.86
         tmp.82
         tmp.78
         tmp.79
         tmp.70
         tmp.75
         tmp.71
         tmp.72
         rbp
         tmp-ra.110))
       (rsi
        (tmp.84
         tmp.92
         tmp.96
         tmp.93
         tmp.85
         tmp.89
         tmp.86
         tmp.70
         tmp.78
         tmp.82
         tmp.79
         tmp.71
         tmp.75
         tmp.72
         r15
         rdi
         rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
    (define L.fixnum?.15
      ((new-frames ())
       (locals (tmp-ra.99 tmp.111 tmp.43 tmp.56))
       (undead-out
        ((rdi tmp-ra.99 rbp)
         (tmp.43 tmp-ra.99 rbp)
         ((((tmp.111 tmp-ra.99 rbp)
            (tmp.111 tmp-ra.99 rbp)
            (tmp.56 tmp-ra.99 rbp))
           (tmp-ra.99 rbp))
          ((tmp-ra.99 rax rbp) (rax rbp))
          ((tmp-ra.99 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.99))
         (tmp.43 (rbp tmp-ra.99))
         (tmp.111 (rbp tmp-ra.99))
         (tmp-ra.99 (tmp.43 rbp rdi tmp.111 tmp.56 rax))
         (rax (rbp tmp-ra.99))
         (rbp (tmp.43 tmp-ra.99 tmp.111 tmp.56 rax))
         (rdi (tmp-ra.99)))))
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
         tmp.57))
       (undead-out
        ((rdi rsi tmp-ra.100 rbp)
         (rsi tmp.22 tmp-ra.100 rbp)
         (tmp.22 tmp.23 tmp-ra.100 rbp)
         ((((((tmp.112 tmp.22 tmp.23 tmp-ra.100 rbp)
              (tmp.112 tmp.22 tmp.23 tmp-ra.100 rbp)
              (tmp.58 tmp.22 tmp.23 tmp-ra.100 rbp))
             (tmp.22 tmp.23 tmp-ra.100 rbp))
            (tmp.57 tmp.22 tmp.23 tmp-ra.100 rbp)
            (tmp.57 tmp.22 tmp.23 tmp-ra.100 rbp))
           (tmp.22 tmp.23 tmp-ra.100 rbp))
          ((((((tmp.113 tmp.22 tmp.23 tmp-ra.100 rbp)
               (tmp.113 tmp.22 tmp.23 tmp-ra.100 rbp)
               (tmp.60 tmp.22 tmp.23 tmp-ra.100 rbp))
              (tmp.22 tmp.23 tmp-ra.100 rbp))
             (tmp.59 tmp.22 tmp.23 tmp-ra.100 rbp)
             (tmp.59 tmp.22 tmp.23 tmp-ra.100 rbp))
            (tmp.22 tmp.23 tmp-ra.100 rbp))
           ((tmp.23 tmp.114 tmp-ra.100 rbp)
            (tmp.114 tmp-ra.100 rbp)
            (tmp-ra.100 rax rbp)
            (rax rbp))
           ((tmp-ra.100 rax rbp) (rax rbp)))
          ((tmp-ra.100 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.100 tmp.23 tmp.22))
         (tmp.112 (tmp.23 rbp tmp-ra.100 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.100
           tmp.22
           tmp.112
           tmp.58
           tmp.57
           tmp.113
           tmp.60
           tmp.59
           tmp.114))
         (tmp.58 (rbp tmp-ra.100 tmp.23 tmp.22))
         (tmp-ra.100
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.112
           tmp.58
           tmp.57
           tmp.113
           tmp.60
           tmp.59
           tmp.114
           rax))
         (tmp.114 (rbp tmp-ra.100 tmp.23))
         (tmp.60 (rbp tmp-ra.100 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.100
           rsi
           tmp.112
           tmp.58
           tmp.57
           tmp.113
           tmp.60
           tmp.59))
         (tmp.113 (tmp.22 rbp tmp-ra.100 tmp.23))
         (tmp.59 (rbp tmp-ra.100 tmp.23 tmp.22))
         (rax (rbp tmp-ra.100))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.100
           tmp.112
           tmp.58
           tmp.57
           tmp.113
           tmp.60
           tmp.59
           tmp.114
           rax))
         (rdi (tmp-ra.100))
         (rsi (tmp.22 tmp-ra.100)))))
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
         tmp.61))
       (undead-out
        ((rdi rsi tmp-ra.101 rbp)
         (rsi tmp.20 tmp-ra.101 rbp)
         (tmp.21 tmp.20 tmp-ra.101 rbp)
         ((((((tmp.115 tmp.21 tmp.20 tmp-ra.101 rbp)
              (tmp.115 tmp.21 tmp.20 tmp-ra.101 rbp)
              (tmp.62 tmp.21 tmp.20 tmp-ra.101 rbp))
             (tmp.21 tmp.20 tmp-ra.101 rbp))
            (tmp.61 tmp.21 tmp.20 tmp-ra.101 rbp)
            (tmp.61 tmp.21 tmp.20 tmp-ra.101 rbp))
           (tmp.21 tmp.20 tmp-ra.101 rbp))
          ((((((tmp.116 tmp.21 tmp.20 tmp-ra.101 rbp)
               (tmp.116 tmp.21 tmp.20 tmp-ra.101 rbp)
               (tmp.64 tmp.21 tmp.20 tmp-ra.101 rbp))
              (tmp.21 tmp.20 tmp-ra.101 rbp))
             (tmp.63 tmp.21 tmp.20 tmp-ra.101 rbp)
             (tmp.63 tmp.21 tmp.20 tmp-ra.101 rbp))
            (tmp.21 tmp.20 tmp-ra.101 rbp))
           ((tmp.117 tmp.20 tmp-ra.101 rbp)
            (tmp.117 tmp.20 tmp-ra.101 rbp)
            (tmp.20 tmp.65 tmp-ra.101 rbp)
            (tmp.65 tmp.118 tmp-ra.101 rbp)
            (tmp.118 tmp-ra.101 rbp)
            (tmp-ra.101 rax rbp)
            (rax rbp))
           ((tmp-ra.101 rax rbp) (rax rbp)))
          ((tmp-ra.101 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.101 tmp.20 tmp.21))
         (tmp.115 (tmp.21 rbp tmp-ra.101 tmp.20))
         (tmp.21
          (rbp tmp-ra.101 tmp.20 tmp.115 tmp.62 tmp.61 tmp.116 tmp.64 tmp.63))
         (tmp.62 (rbp tmp-ra.101 tmp.20 tmp.21))
         (tmp-ra.101
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.115
           tmp.62
           tmp.61
           tmp.116
           tmp.64
           tmp.63
           tmp.118
           tmp.65
           tmp.117
           rax))
         (tmp.117 (rbp tmp-ra.101 tmp.20))
         (tmp.65 (tmp.118 rbp tmp-ra.101 tmp.20))
         (tmp.118 (rbp tmp-ra.101 tmp.65))
         (tmp.64 (rbp tmp-ra.101 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.101
           rsi
           tmp.115
           tmp.62
           tmp.61
           tmp.116
           tmp.64
           tmp.63
           tmp.65
           tmp.117))
         (tmp.116 (tmp.20 rbp tmp-ra.101 tmp.21))
         (tmp.63 (rbp tmp-ra.101 tmp.20 tmp.21))
         (rax (rbp tmp-ra.101))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.101
           tmp.115
           tmp.62
           tmp.61
           tmp.116
           tmp.64
           tmp.63
           tmp.118
           tmp.65
           tmp.117
           rax))
         (rdi (tmp-ra.101))
         (rsi (tmp.20 tmp-ra.101)))))
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
         tmp.66))
       (undead-out
        ((rdi rsi tmp-ra.102 rbp)
         (rsi tmp.24 tmp-ra.102 rbp)
         (tmp.24 tmp.25 tmp-ra.102 rbp)
         ((((((tmp.119 tmp.24 tmp.25 tmp-ra.102 rbp)
              (tmp.119 tmp.24 tmp.25 tmp-ra.102 rbp)
              (tmp.67 tmp.24 tmp.25 tmp-ra.102 rbp))
             (tmp.24 tmp.25 tmp-ra.102 rbp))
            (tmp.66 tmp.24 tmp.25 tmp-ra.102 rbp)
            (tmp.66 tmp.24 tmp.25 tmp-ra.102 rbp))
           (tmp.24 tmp.25 tmp-ra.102 rbp))
          ((((((tmp.120 tmp.24 tmp.25 tmp-ra.102 rbp)
               (tmp.120 tmp.24 tmp.25 tmp-ra.102 rbp)
               (tmp.69 tmp.24 tmp.25 tmp-ra.102 rbp))
              (tmp.24 tmp.25 tmp-ra.102 rbp))
             (tmp.68 tmp.24 tmp.25 tmp-ra.102 rbp)
             (tmp.68 tmp.24 tmp.25 tmp-ra.102 rbp))
            (tmp.24 tmp.25 tmp-ra.102 rbp))
           ((tmp.25 tmp.121 tmp-ra.102 rbp)
            (tmp.121 tmp-ra.102 rbp)
            (tmp-ra.102 rax rbp)
            (rax rbp))
           ((tmp-ra.102 rax rbp) (rax rbp)))
          ((tmp-ra.102 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.66 (rbp tmp-ra.102 tmp.25 tmp.24))
         (tmp.119 (tmp.25 rbp tmp-ra.102 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.102
           tmp.24
           tmp.119
           tmp.67
           tmp.66
           tmp.120
           tmp.69
           tmp.68
           tmp.121))
         (tmp.67 (rbp tmp-ra.102 tmp.25 tmp.24))
         (tmp-ra.102
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.119
           tmp.67
           tmp.66
           tmp.120
           tmp.69
           tmp.68
           tmp.121
           rax))
         (tmp.121 (rbp tmp-ra.102 tmp.25))
         (tmp.69 (rbp tmp-ra.102 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.102
           rsi
           tmp.119
           tmp.67
           tmp.66
           tmp.120
           tmp.69
           tmp.68))
         (tmp.120 (tmp.24 rbp tmp-ra.102 tmp.25))
         (tmp.68 (rbp tmp-ra.102 tmp.25 tmp.24))
         (rax (rbp tmp-ra.102))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.102
           tmp.119
           tmp.67
           tmp.66
           tmp.120
           tmp.69
           tmp.68
           tmp.121
           rax))
         (rdi (tmp-ra.102))
         (rsi (tmp.24 tmp-ra.102)))))
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
      ((new-frames ())
       (locals (tmp-ra.103))
       (undead-out ((tmp-ra.103 rbp) (tmp-ra.103 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.103 (rax rbp))
         (rbp (rax tmp-ra.103))
         (rax (rbp tmp-ra.103)))))
      (begin (set! tmp-ra.103 r15) (set! rax 22) (jump tmp-ra.103 rbp rax)))
    (define L.fun/error58875.5
      ((new-frames ())
       (locals (tmp-ra.104))
       (undead-out ((tmp-ra.104 rbp) (tmp-ra.104 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.104 (rax rbp))
         (rbp (rax tmp-ra.104))
         (rax (rbp tmp-ra.104)))))
      (begin (set! tmp-ra.104 r15) (set! rax 38462) (jump tmp-ra.104 rbp rax)))
    (define L.fun/ascii-char58879.6
      ((new-frames ())
       (locals (tmp-ra.105))
       (undead-out ((tmp-ra.105 rbp) (tmp-ra.105 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.105 (rax rbp))
         (rbp (rax tmp-ra.105))
         (rax (rbp tmp-ra.105)))))
      (begin (set! tmp-ra.105 r15) (set! rax 25390) (jump tmp-ra.105 rbp rax)))
    (define L.fun/any58880.7
      ((new-frames ())
       (locals (tmp-ra.106))
       (undead-out ((tmp-ra.106 rbp) (tmp-ra.106 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.106 (rax rbp))
         (rbp (rax tmp-ra.106))
         (rax (rbp tmp-ra.106)))))
      (begin (set! tmp-ra.106 r15) (set! rax 6) (jump tmp-ra.106 rbp rax)))
    (define L.fun/empty58876.8
      ((new-frames ())
       (locals (tmp-ra.107))
       (undead-out ((tmp-ra.107 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.107 (rbp)) (rbp (r15 tmp-ra.107)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.107 r15)
        (set! r15 tmp-ra.107)
        (jump L.fun/empty58877.4 rbp r15)))
    (define L.fun/ascii-char58878.9
      ((new-frames ())
       (locals (tmp-ra.108))
       (undead-out ((tmp-ra.108 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.108 (rbp)) (rbp (r15 tmp-ra.108)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.108 r15)
        (set! r15 tmp-ra.108)
        (jump L.fun/ascii-char58879.6 rbp r15)))
    (define L.fun/error58874.10
      ((new-frames ())
       (locals (tmp-ra.109))
       (undead-out ((tmp-ra.109 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.109 (rbp)) (rbp (r15 tmp-ra.109)) (r15 (rbp)))))
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
       tmp-ra.122))
     (call-undead
      (tmp.72
       tmp.71
       tmp.70
       tmp.82
       tmp.86
       tmp.85
       tmp.84
       tmp.96
       tmp.103
       tmp.107
       tmp.106
       tmp.110
       tmp.98
       tmp.99
       tmp.100
       tmp.92
       tmp.93
       tmp.89
       ascii-char1.5
       tmp.78
       tmp.79
       tmp.75
       tmp-ra.122))
     (undead-out
      ((tmp-ra.122 rbp)
       ((rax tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp-ra.122 rbp)
       ((rax tmp.72 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.73 tmp-ra.122 rbp)
       ((rax tmp-ra.122 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.122 rbp)
       ((rax tmp.71 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp.71 tmp-ra.122 rbp)
       ((rax tmp.75 tmp.71 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp.76 tmp.71 tmp-ra.122 rbp)
       ((rax tmp.71 tmp-ra.122 rbp)
        ((tmp.75 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.74 tmp-ra.122 rbp)
       ((rax tmp-ra.122 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp-ra.122 rbp)
       ((rax tmp.70 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.70 tmp-ra.122 rbp)
       ((rax tmp.79 tmp.70 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.80 tmp.70 tmp-ra.122 rbp)
       ((rax tmp.70 tmp-ra.122 rbp)
        ((tmp.79 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.70 tmp-ra.122 rbp)
       ((rax tmp.78 tmp.70 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.82 tmp.78 tmp.70 tmp-ra.122 rbp)
       ((rax tmp.82 tmp.78 tmp.70 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.82 tmp.83 tmp.78 tmp.70 tmp-ra.122 rbp)
       ((rax tmp.78 tmp.70 tmp-ra.122 rbp)
        ((tmp.82 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.81 tmp.70 tmp-ra.122 rbp)
       ((rax tmp.70 tmp-ra.122 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.77 tmp-ra.122 rbp)
       ((rax tmp-ra.122 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.122 rbp)
       ((rax tmp-ra.122 rbp) ((r15 rbp) (r15 rbp)))
       (ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.86 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.86 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.86 tmp.87 ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.86 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.85 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.89 tmp.85 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.89 tmp.85 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.89 tmp.90 tmp.85 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.85 ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.89 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 tmp.88 ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.85 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.84 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.93 tmp.84 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.93 tmp.84 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.93 tmp.94 tmp.84 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.84 ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.93 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 tmp.84 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.92 tmp.84 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.96 tmp.92 tmp.84 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.96 tmp.92 tmp.84 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.96 tmp.97 tmp.92 tmp.84 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.92 tmp.84 ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.96 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 tmp.95 tmp.84 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.84 ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.92 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 tmp.91 ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.84 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.100 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.100 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.100 tmp.101 ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.100 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.99 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.99 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.103 tmp.99 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.103 tmp.99 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.103 tmp.104 tmp.99 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.99 ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.103 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.99 tmp.102 ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.99 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.98 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.98 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.107 tmp.98 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.107 tmp.98 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.107 tmp.108 tmp.98 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.98 ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.107 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.106 tmp.98 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.106 tmp.98 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.110 tmp.106 tmp.98 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.110 tmp.106 tmp.98 ascii-char1.5 tmp-ra.122 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.110 tmp.111 tmp.106 tmp.98 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.106 tmp.98 ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.110 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.106 tmp.109 tmp.98 ascii-char1.5 tmp-ra.122 rbp)
       ((rax tmp.98 ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.106 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.98 tmp.105 ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp)
        ((tmp.98 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.112 ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp)
        ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (ascii-char1.5 tmp-ra.122 rbp)
       ((rax ascii-char1.5 tmp-ra.122 rbp) ((r15 rbp) (r15 rbp)))
       (ascii-char1.5 tmp-ra.122 rbp)
       (tmp-ra.122 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.122
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
         rax
         rbp))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.122))
       (tmp.73 (rbp tmp-ra.122 tmp.72))
       (tmp.71 (rsi tmp.74 tmp.76 tmp.75 rax rbp tmp-ra.122))
       (tmp.75 (rsi tmp.76 rax rbp tmp-ra.122 tmp.71))
       (tmp.76 (rbp tmp-ra.122 tmp.71 tmp.75))
       (tmp.74 (rbp tmp-ra.122 tmp.71))
       (tmp.70
        (rsi
         tmp.77
         tmp.81
         tmp.83
         tmp.82
         tmp.78
         tmp.80
         tmp.79
         rax
         rbp
         tmp-ra.122))
       (tmp.79 (rsi tmp.80 rax rbp tmp-ra.122 tmp.70))
       (tmp.80 (rbp tmp-ra.122 tmp.70 tmp.79))
       (tmp.78 (rsi tmp.81 tmp.83 tmp.82 rax rbp tmp-ra.122 tmp.70))
       (tmp.82 (rsi tmp.83 rax rbp tmp-ra.122 tmp.70 tmp.78))
       (tmp.83 (rbp tmp-ra.122 tmp.70 tmp.78 tmp.82))
       (tmp.81 (rbp tmp-ra.122 tmp.70 tmp.78))
       (tmp.77 (rbp tmp-ra.122 tmp.70))
       (fixnum0.6 (rbp tmp-ra.122))
       (ascii-char1.5
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
         rax
         rbp
         tmp-ra.122))
       (tmp.86 (rsi tmp.87 rax rbp tmp-ra.122 ascii-char1.5))
       (tmp.87 (rbp tmp-ra.122 ascii-char1.5 tmp.86))
       (tmp.85 (rsi tmp.88 tmp.90 tmp.89 rax rbp tmp-ra.122 ascii-char1.5))
       (tmp.89 (rsi tmp.90 rax rbp tmp-ra.122 ascii-char1.5 tmp.85))
       (tmp.90 (rbp tmp-ra.122 ascii-char1.5 tmp.85 tmp.89))
       (tmp.88 (rbp tmp-ra.122 ascii-char1.5 tmp.85))
       (tmp.84
        (rsi
         tmp.91
         tmp.95
         tmp.97
         tmp.96
         tmp.92
         tmp.94
         tmp.93
         rax
         rbp
         tmp-ra.122
         ascii-char1.5))
       (tmp.93 (rsi tmp.94 rax rbp tmp-ra.122 ascii-char1.5 tmp.84))
       (tmp.94 (rbp tmp-ra.122 ascii-char1.5 tmp.84 tmp.93))
       (tmp.92
        (rsi tmp.95 tmp.97 tmp.96 rax rbp tmp-ra.122 ascii-char1.5 tmp.84))
       (tmp.96 (rsi tmp.97 rax rbp tmp-ra.122 ascii-char1.5 tmp.84 tmp.92))
       (tmp.97 (rbp tmp-ra.122 ascii-char1.5 tmp.84 tmp.92 tmp.96))
       (tmp.95 (rbp tmp-ra.122 ascii-char1.5 tmp.84 tmp.92))
       (tmp.91 (rbp tmp-ra.122 ascii-char1.5 tmp.84))
       (fixnum2.4 (rbp tmp-ra.122 ascii-char1.5))
       (tmp.100 (rsi tmp.101 rax rbp tmp-ra.122 ascii-char1.5))
       (tmp.101 (rbp tmp-ra.122 ascii-char1.5 tmp.100))
       (tmp.99 (rsi tmp.102 tmp.104 tmp.103 rax rbp tmp-ra.122 ascii-char1.5))
       (tmp.103 (rsi tmp.104 rax rbp tmp-ra.122 ascii-char1.5 tmp.99))
       (tmp.104 (rbp tmp-ra.122 ascii-char1.5 tmp.99 tmp.103))
       (tmp.102 (rbp tmp-ra.122 ascii-char1.5 tmp.99))
       (tmp.98
        (rsi
         tmp.105
         tmp.109
         tmp.111
         tmp.110
         tmp.106
         tmp.108
         tmp.107
         rax
         rbp
         tmp-ra.122
         ascii-char1.5))
       (tmp.107 (rsi tmp.108 rax rbp tmp-ra.122 ascii-char1.5 tmp.98))
       (tmp.108 (rbp tmp-ra.122 ascii-char1.5 tmp.98 tmp.107))
       (tmp.106
        (rsi tmp.109 tmp.111 tmp.110 rax rbp tmp-ra.122 ascii-char1.5 tmp.98))
       (tmp.110 (rsi tmp.111 rax rbp tmp-ra.122 ascii-char1.5 tmp.98 tmp.106))
       (tmp.111 (rbp tmp-ra.122 ascii-char1.5 tmp.98 tmp.106 tmp.110))
       (tmp.109 (rbp tmp-ra.122 ascii-char1.5 tmp.98 tmp.106))
       (tmp.105 (rbp tmp-ra.122 ascii-char1.5 tmp.98))
       (fixnum3.3 (rbp tmp-ra.122 ascii-char1.5))
       (tmp.112 (rbp tmp-ra.122 ascii-char1.5))
       (boolean4.2 (rbp tmp-ra.122 ascii-char1.5))
       (error5.1 (rbp tmp-ra.122 ascii-char1.5))
       (rbp
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
         r15
         rdi
         rsi
         rax
         tmp-ra.122))
       (rax
        (tmp.110
         tmp.106
         tmp.107
         tmp.98
         tmp.103
         tmp.99
         tmp.100
         tmp.96
         tmp.92
         tmp.93
         tmp.84
         tmp.89
         tmp.85
         tmp.86
         ascii-char1.5
         tmp.82
         tmp.78
         tmp.79
         tmp.70
         tmp.75
         tmp.71
         tmp.72
         rbp
         tmp-ra.122))
       (rsi
        (tmp.98
         tmp.106
         tmp.110
         tmp.107
         tmp.99
         tmp.103
         tmp.100
         tmp.84
         tmp.92
         tmp.96
         tmp.93
         tmp.85
         tmp.89
         tmp.86
         tmp.70
         tmp.78
         tmp.82
         tmp.79
         tmp.71
         tmp.75
         tmp.72
         r15
         rdi
         rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
    (define L.void?.13
      ((new-frames ())
       (locals (tmp-ra.113 tmp.123 tmp.46 tmp.56))
       (undead-out
        ((rdi tmp-ra.113 rbp)
         (tmp.46 tmp-ra.113 rbp)
         ((((tmp.123 tmp-ra.113 rbp)
            (tmp.123 tmp-ra.113 rbp)
            (tmp.56 tmp-ra.113 rbp))
           (tmp-ra.113 rbp))
          ((tmp-ra.113 rax rbp) (rax rbp))
          ((tmp-ra.113 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.113))
         (tmp.46 (rbp tmp-ra.113))
         (tmp.123 (rbp tmp-ra.113))
         (tmp-ra.113 (tmp.46 rbp rdi tmp.123 tmp.56 rax))
         (rax (rbp tmp-ra.113))
         (rbp (tmp.46 tmp-ra.113 tmp.123 tmp.56 rax))
         (rdi (tmp-ra.113)))))
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
         tmp.57))
       (undead-out
        ((rdi rsi tmp-ra.114 rbp)
         (rsi tmp.24 tmp-ra.114 rbp)
         (tmp.24 tmp.25 tmp-ra.114 rbp)
         ((((((tmp.124 tmp.24 tmp.25 tmp-ra.114 rbp)
              (tmp.124 tmp.24 tmp.25 tmp-ra.114 rbp)
              (tmp.58 tmp.24 tmp.25 tmp-ra.114 rbp))
             (tmp.24 tmp.25 tmp-ra.114 rbp))
            (tmp.57 tmp.24 tmp.25 tmp-ra.114 rbp)
            (tmp.57 tmp.24 tmp.25 tmp-ra.114 rbp))
           (tmp.24 tmp.25 tmp-ra.114 rbp))
          ((((((tmp.125 tmp.24 tmp.25 tmp-ra.114 rbp)
               (tmp.125 tmp.24 tmp.25 tmp-ra.114 rbp)
               (tmp.60 tmp.24 tmp.25 tmp-ra.114 rbp))
              (tmp.24 tmp.25 tmp-ra.114 rbp))
             (tmp.59 tmp.24 tmp.25 tmp-ra.114 rbp)
             (tmp.59 tmp.24 tmp.25 tmp-ra.114 rbp))
            (tmp.24 tmp.25 tmp-ra.114 rbp))
           ((tmp.25 tmp.126 tmp-ra.114 rbp)
            (tmp.126 tmp-ra.114 rbp)
            (tmp-ra.114 rax rbp)
            (rax rbp))
           ((tmp-ra.114 rax rbp) (rax rbp)))
          ((tmp-ra.114 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.114 tmp.25 tmp.24))
         (tmp.124 (tmp.25 rbp tmp-ra.114 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.114
           tmp.24
           tmp.124
           tmp.58
           tmp.57
           tmp.125
           tmp.60
           tmp.59
           tmp.126))
         (tmp.58 (rbp tmp-ra.114 tmp.25 tmp.24))
         (tmp-ra.114
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.124
           tmp.58
           tmp.57
           tmp.125
           tmp.60
           tmp.59
           tmp.126
           rax))
         (tmp.126 (rbp tmp-ra.114 tmp.25))
         (tmp.60 (rbp tmp-ra.114 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.114
           rsi
           tmp.124
           tmp.58
           tmp.57
           tmp.125
           tmp.60
           tmp.59))
         (tmp.125 (tmp.24 rbp tmp-ra.114 tmp.25))
         (tmp.59 (rbp tmp-ra.114 tmp.25 tmp.24))
         (rax (rbp tmp-ra.114))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.114
           tmp.124
           tmp.58
           tmp.57
           tmp.125
           tmp.60
           tmp.59
           tmp.126
           rax))
         (rdi (tmp-ra.114))
         (rsi (tmp.24 tmp-ra.114)))))
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
         tmp.61))
       (undead-out
        ((rdi rsi tmp-ra.115 rbp)
         (rsi tmp.22 tmp-ra.115 rbp)
         (tmp.22 tmp.23 tmp-ra.115 rbp)
         ((((((tmp.127 tmp.22 tmp.23 tmp-ra.115 rbp)
              (tmp.127 tmp.22 tmp.23 tmp-ra.115 rbp)
              (tmp.62 tmp.22 tmp.23 tmp-ra.115 rbp))
             (tmp.22 tmp.23 tmp-ra.115 rbp))
            (tmp.61 tmp.22 tmp.23 tmp-ra.115 rbp)
            (tmp.61 tmp.22 tmp.23 tmp-ra.115 rbp))
           (tmp.22 tmp.23 tmp-ra.115 rbp))
          ((((((tmp.128 tmp.22 tmp.23 tmp-ra.115 rbp)
               (tmp.128 tmp.22 tmp.23 tmp-ra.115 rbp)
               (tmp.64 tmp.22 tmp.23 tmp-ra.115 rbp))
              (tmp.22 tmp.23 tmp-ra.115 rbp))
             (tmp.63 tmp.22 tmp.23 tmp-ra.115 rbp)
             (tmp.63 tmp.22 tmp.23 tmp-ra.115 rbp))
            (tmp.22 tmp.23 tmp-ra.115 rbp))
           ((tmp.23 tmp.129 tmp-ra.115 rbp)
            (tmp.129 tmp-ra.115 rbp)
            (tmp-ra.115 rax rbp)
            (rax rbp))
           ((tmp-ra.115 rax rbp) (rax rbp)))
          ((tmp-ra.115 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.115 tmp.23 tmp.22))
         (tmp.127 (tmp.23 rbp tmp-ra.115 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.115
           tmp.22
           tmp.127
           tmp.62
           tmp.61
           tmp.128
           tmp.64
           tmp.63
           tmp.129))
         (tmp.62 (rbp tmp-ra.115 tmp.23 tmp.22))
         (tmp-ra.115
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.127
           tmp.62
           tmp.61
           tmp.128
           tmp.64
           tmp.63
           tmp.129
           rax))
         (tmp.129 (rbp tmp-ra.115 tmp.23))
         (tmp.64 (rbp tmp-ra.115 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.115
           rsi
           tmp.127
           tmp.62
           tmp.61
           tmp.128
           tmp.64
           tmp.63))
         (tmp.128 (tmp.22 rbp tmp-ra.115 tmp.23))
         (tmp.63 (rbp tmp-ra.115 tmp.23 tmp.22))
         (rax (rbp tmp-ra.115))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.115
           tmp.127
           tmp.62
           tmp.61
           tmp.128
           tmp.64
           tmp.63
           tmp.129
           rax))
         (rdi (tmp-ra.115))
         (rsi (tmp.22 tmp-ra.115)))))
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
         tmp.65))
       (undead-out
        ((rdi rsi tmp-ra.116 rbp)
         (rsi tmp.20 tmp-ra.116 rbp)
         (tmp.21 tmp.20 tmp-ra.116 rbp)
         ((((((tmp.130 tmp.21 tmp.20 tmp-ra.116 rbp)
              (tmp.130 tmp.21 tmp.20 tmp-ra.116 rbp)
              (tmp.66 tmp.21 tmp.20 tmp-ra.116 rbp))
             (tmp.21 tmp.20 tmp-ra.116 rbp))
            (tmp.65 tmp.21 tmp.20 tmp-ra.116 rbp)
            (tmp.65 tmp.21 tmp.20 tmp-ra.116 rbp))
           (tmp.21 tmp.20 tmp-ra.116 rbp))
          ((((((tmp.131 tmp.21 tmp.20 tmp-ra.116 rbp)
               (tmp.131 tmp.21 tmp.20 tmp-ra.116 rbp)
               (tmp.68 tmp.21 tmp.20 tmp-ra.116 rbp))
              (tmp.21 tmp.20 tmp-ra.116 rbp))
             (tmp.67 tmp.21 tmp.20 tmp-ra.116 rbp)
             (tmp.67 tmp.21 tmp.20 tmp-ra.116 rbp))
            (tmp.21 tmp.20 tmp-ra.116 rbp))
           ((tmp.132 tmp.20 tmp-ra.116 rbp)
            (tmp.132 tmp.20 tmp-ra.116 rbp)
            (tmp.20 tmp.69 tmp-ra.116 rbp)
            (tmp.69 tmp.133 tmp-ra.116 rbp)
            (tmp.133 tmp-ra.116 rbp)
            (tmp-ra.116 rax rbp)
            (rax rbp))
           ((tmp-ra.116 rax rbp) (rax rbp)))
          ((tmp-ra.116 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.116 tmp.20 tmp.21))
         (tmp.130 (tmp.21 rbp tmp-ra.116 tmp.20))
         (tmp.21
          (rbp tmp-ra.116 tmp.20 tmp.130 tmp.66 tmp.65 tmp.131 tmp.68 tmp.67))
         (tmp.66 (rbp tmp-ra.116 tmp.20 tmp.21))
         (tmp-ra.116
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.130
           tmp.66
           tmp.65
           tmp.131
           tmp.68
           tmp.67
           tmp.133
           tmp.69
           tmp.132
           rax))
         (tmp.132 (rbp tmp-ra.116 tmp.20))
         (tmp.69 (tmp.133 rbp tmp-ra.116 tmp.20))
         (tmp.133 (rbp tmp-ra.116 tmp.69))
         (tmp.68 (rbp tmp-ra.116 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.116
           rsi
           tmp.130
           tmp.66
           tmp.65
           tmp.131
           tmp.68
           tmp.67
           tmp.69
           tmp.132))
         (tmp.131 (tmp.20 rbp tmp-ra.116 tmp.21))
         (tmp.67 (rbp tmp-ra.116 tmp.20 tmp.21))
         (rax (rbp tmp-ra.116))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.116
           tmp.130
           tmp.66
           tmp.65
           tmp.131
           tmp.68
           tmp.67
           tmp.133
           tmp.69
           tmp.132
           rax))
         (rdi (tmp-ra.116))
         (rsi (tmp.20 tmp-ra.116)))))
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
      ((new-frames ())
       (locals (tmp-ra.117))
       (undead-out ((tmp-ra.117 rbp) (tmp-ra.117 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.117 (rax rbp))
         (rbp (rax tmp-ra.117))
         (rax (rbp tmp-ra.117)))))
      (begin (set! tmp-ra.117 r15) (set! rax 25390) (jump tmp-ra.117 rbp rax)))
    (define L.fun/error63956.5
      ((new-frames ())
       (locals (tmp-ra.118))
       (undead-out ((tmp-ra.118 rbp) (tmp-ra.118 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.118 (rax rbp))
         (rbp (rax tmp-ra.118))
         (rax (rbp tmp-ra.118)))))
      (begin (set! tmp-ra.118 r15) (set! rax 20030) (jump tmp-ra.118 rbp rax)))
    (define L.fun/ascii-char63952.6
      ((new-frames ())
       (locals (tmp-ra.119))
       (undead-out ((tmp-ra.119 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.119 (rbp)) (rbp (r15 tmp-ra.119)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.119 r15)
        (set! r15 tmp-ra.119)
        (jump L.fun/ascii-char63953.4 rbp r15)))
    (define L.fun/error63955.7
      ((new-frames ())
       (locals (tmp-ra.120))
       (undead-out ((tmp-ra.120 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.120 (rbp)) (rbp (r15 tmp-ra.120)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.120 r15)
        (set! r15 tmp-ra.120)
        (jump L.fun/error63956.5 rbp r15)))
    (define L.fun/any63954.8
      ((new-frames ())
       (locals (tmp-ra.121))
       (undead-out ((tmp-ra.121 rbp) (tmp-ra.121 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.121 (rax rbp))
         (rbp (rax tmp-ra.121))
         (rax (rbp tmp-ra.121)))))
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
       tmp-ra.96))
     (call-undead
      (tmp.71 tmp.70 tmp.69 tmp.81 empty1.5 tmp.77 tmp.78 tmp.74 tmp-ra.96))
     (undead-out
      ((tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.96 rbp)
       ((rax tmp.71 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.72 tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp-ra.96 rbp)
       ((rax tmp.70 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.70 tmp-ra.96 rbp)
       ((rax tmp.74 tmp.70 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.75 tmp.70 tmp-ra.96 rbp)
       ((rax tmp.70 tmp-ra.96 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.73 tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.96 rbp)
       ((rax tmp.69 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.78 tmp.69 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.79 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.69 tmp-ra.96 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.77 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.81 tmp.77 tmp.69 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.82 tmp.77 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.96 rbp)
        ((tmp.81 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.80 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.69 tmp-ra.96 rbp)
        ((tmp.77 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.76 tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (empty1.5 tmp-ra.96 rbp)
       ((rax empty1.5 tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (empty1.5 tmp-ra.96 rbp)
       ((rax empty1.5 tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (empty1.5 tmp-ra.96 rbp)
       ((rax empty1.5 tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (empty1.5 tmp-ra.96 rbp)
       ((rax empty1.5 tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (empty1.5 tmp-ra.96 rbp)
       (tmp-ra.96 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.96
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
         rax
         rbp))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.96))
       (tmp.72 (rbp tmp-ra.96 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.96))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.96 tmp.70))
       (tmp.75 (rbp tmp-ra.96 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.96 tmp.70))
       (tmp.69
        (rsi
         tmp.76
         tmp.80
         tmp.82
         tmp.81
         tmp.77
         tmp.79
         tmp.78
         rax
         rbp
         tmp-ra.96))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.96 tmp.69))
       (tmp.79 (rbp tmp-ra.96 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.96 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.96 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.96 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.96 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.96 tmp.69))
       (fixnum0.6 (rbp tmp-ra.96))
       (empty1.5
        (void5.1 ascii-char4.2 ascii-char3.3 ascii-char2.4 rax rbp tmp-ra.96))
       (ascii-char2.4 (rbp tmp-ra.96 empty1.5))
       (ascii-char3.3 (rbp tmp-ra.96 empty1.5))
       (ascii-char4.2 (rbp tmp-ra.96 empty1.5))
       (void5.1 (rbp tmp-ra.96 empty1.5))
       (rbp
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
         r15
         rdi
         rsi
         rax
         tmp-ra.96))
       (rax
        (empty1.5
         tmp.81
         tmp.77
         tmp.78
         tmp.69
         tmp.74
         tmp.70
         tmp.71
         rbp
         tmp-ra.96))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
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
         tmp.56))
       (undead-out
        ((rdi rsi tmp-ra.83 rbp)
         (rsi tmp.24 tmp-ra.83 rbp)
         (tmp.24 tmp.25 tmp-ra.83 rbp)
         ((((((tmp.97 tmp.24 tmp.25 tmp-ra.83 rbp)
              (tmp.97 tmp.24 tmp.25 tmp-ra.83 rbp)
              (tmp.57 tmp.24 tmp.25 tmp-ra.83 rbp))
             (tmp.24 tmp.25 tmp-ra.83 rbp))
            (tmp.56 tmp.24 tmp.25 tmp-ra.83 rbp)
            (tmp.56 tmp.24 tmp.25 tmp-ra.83 rbp))
           (tmp.24 tmp.25 tmp-ra.83 rbp))
          ((((((tmp.98 tmp.24 tmp.25 tmp-ra.83 rbp)
               (tmp.98 tmp.24 tmp.25 tmp-ra.83 rbp)
               (tmp.59 tmp.24 tmp.25 tmp-ra.83 rbp))
              (tmp.24 tmp.25 tmp-ra.83 rbp))
             (tmp.58 tmp.24 tmp.25 tmp-ra.83 rbp)
             (tmp.58 tmp.24 tmp.25 tmp-ra.83 rbp))
            (tmp.24 tmp.25 tmp-ra.83 rbp))
           ((tmp.25 tmp.99 tmp-ra.83 rbp)
            (tmp.99 tmp-ra.83 rbp)
            (tmp-ra.83 rax rbp)
            (rax rbp))
           ((tmp-ra.83 rax rbp) (rax rbp)))
          ((tmp-ra.83 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.83 tmp.25 tmp.24))
         (tmp.97 (tmp.25 rbp tmp-ra.83 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.83
           tmp.24
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99))
         (tmp.57 (rbp tmp-ra.83 tmp.25 tmp.24))
         (tmp-ra.83
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99
           rax))
         (tmp.99 (rbp tmp-ra.83 tmp.25))
         (tmp.59 (rbp tmp-ra.83 tmp.25 tmp.24))
         (tmp.24
          (tmp.25 rbp tmp-ra.83 rsi tmp.97 tmp.57 tmp.56 tmp.98 tmp.59 tmp.58))
         (tmp.98 (tmp.24 rbp tmp-ra.83 tmp.25))
         (tmp.58 (rbp tmp-ra.83 tmp.25 tmp.24))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.83
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99
           rax))
         (rdi (tmp-ra.83))
         (rsi (tmp.24 tmp-ra.83)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.84 rbp)
         (rsi tmp.20 tmp-ra.84 rbp)
         (tmp.21 tmp.20 tmp-ra.84 rbp)
         ((((((tmp.100 tmp.21 tmp.20 tmp-ra.84 rbp)
              (tmp.100 tmp.21 tmp.20 tmp-ra.84 rbp)
              (tmp.61 tmp.21 tmp.20 tmp-ra.84 rbp))
             (tmp.21 tmp.20 tmp-ra.84 rbp))
            (tmp.60 tmp.21 tmp.20 tmp-ra.84 rbp)
            (tmp.60 tmp.21 tmp.20 tmp-ra.84 rbp))
           (tmp.21 tmp.20 tmp-ra.84 rbp))
          ((((((tmp.101 tmp.21 tmp.20 tmp-ra.84 rbp)
               (tmp.101 tmp.21 tmp.20 tmp-ra.84 rbp)
               (tmp.63 tmp.21 tmp.20 tmp-ra.84 rbp))
              (tmp.21 tmp.20 tmp-ra.84 rbp))
             (tmp.62 tmp.21 tmp.20 tmp-ra.84 rbp)
             (tmp.62 tmp.21 tmp.20 tmp-ra.84 rbp))
            (tmp.21 tmp.20 tmp-ra.84 rbp))
           ((tmp.102 tmp.20 tmp-ra.84 rbp)
            (tmp.102 tmp.20 tmp-ra.84 rbp)
            (tmp.20 tmp.64 tmp-ra.84 rbp)
            (tmp.64 tmp.103 tmp-ra.84 rbp)
            (tmp.103 tmp-ra.84 rbp)
            (tmp-ra.84 rax rbp)
            (rax rbp))
           ((tmp-ra.84 rax rbp) (rax rbp)))
          ((tmp-ra.84 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.84 tmp.20 tmp.21))
         (tmp.100 (tmp.21 rbp tmp-ra.84 tmp.20))
         (tmp.21
          (rbp tmp-ra.84 tmp.20 tmp.100 tmp.61 tmp.60 tmp.101 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.84 tmp.20 tmp.21))
         (tmp-ra.84
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.103
           tmp.64
           tmp.102
           rax))
         (tmp.102 (rbp tmp-ra.84 tmp.20))
         (tmp.64 (tmp.103 rbp tmp-ra.84 tmp.20))
         (tmp.103 (rbp tmp-ra.84 tmp.64))
         (tmp.63 (rbp tmp-ra.84 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.84
           rsi
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.64
           tmp.102))
         (tmp.101 (tmp.20 rbp tmp-ra.84 tmp.21))
         (tmp.62 (rbp tmp-ra.84 tmp.20 tmp.21))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.84
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.103
           tmp.64
           tmp.102
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.20 tmp-ra.84)))))
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
         tmp.65))
       (undead-out
        ((rdi rsi tmp-ra.85 rbp)
         (rsi tmp.22 tmp-ra.85 rbp)
         (tmp.22 tmp.23 tmp-ra.85 rbp)
         ((((((tmp.104 tmp.22 tmp.23 tmp-ra.85 rbp)
              (tmp.104 tmp.22 tmp.23 tmp-ra.85 rbp)
              (tmp.66 tmp.22 tmp.23 tmp-ra.85 rbp))
             (tmp.22 tmp.23 tmp-ra.85 rbp))
            (tmp.65 tmp.22 tmp.23 tmp-ra.85 rbp)
            (tmp.65 tmp.22 tmp.23 tmp-ra.85 rbp))
           (tmp.22 tmp.23 tmp-ra.85 rbp))
          ((((((tmp.105 tmp.22 tmp.23 tmp-ra.85 rbp)
               (tmp.105 tmp.22 tmp.23 tmp-ra.85 rbp)
               (tmp.68 tmp.22 tmp.23 tmp-ra.85 rbp))
              (tmp.22 tmp.23 tmp-ra.85 rbp))
             (tmp.67 tmp.22 tmp.23 tmp-ra.85 rbp)
             (tmp.67 tmp.22 tmp.23 tmp-ra.85 rbp))
            (tmp.22 tmp.23 tmp-ra.85 rbp))
           ((tmp.23 tmp.106 tmp-ra.85 rbp)
            (tmp.106 tmp-ra.85 rbp)
            (tmp-ra.85 rax rbp)
            (rax rbp))
           ((tmp-ra.85 rax rbp) (rax rbp)))
          ((tmp-ra.85 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp.104 (tmp.23 rbp tmp-ra.85 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.85
           tmp.22
           tmp.104
           tmp.66
           tmp.65
           tmp.105
           tmp.68
           tmp.67
           tmp.106))
         (tmp.66 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp-ra.85
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.104
           tmp.66
           tmp.65
           tmp.105
           tmp.68
           tmp.67
           tmp.106
           rax))
         (tmp.106 (rbp tmp-ra.85 tmp.23))
         (tmp.68 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.85
           rsi
           tmp.104
           tmp.66
           tmp.65
           tmp.105
           tmp.68
           tmp.67))
         (tmp.105 (tmp.22 rbp tmp-ra.85 tmp.23))
         (tmp.67 (rbp tmp-ra.85 tmp.23 tmp.22))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.85
           tmp.104
           tmp.66
           tmp.65
           tmp.105
           tmp.68
           tmp.67
           tmp.106
           rax))
         (rdi (tmp-ra.85))
         (rsi (tmp.22 tmp-ra.85)))))
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
      ((new-frames ())
       (locals (tmp-ra.86))
       (undead-out ((tmp-ra.86 rbp) (tmp-ra.86 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86)))))
      (begin (set! tmp-ra.86 r15) (set! rax 25390) (jump tmp-ra.86 rbp rax)))
    (define L.fun/void71278.5
      ((new-frames ())
       (locals (tmp-ra.87))
       (undead-out ((tmp-ra.87 rbp) (tmp-ra.87 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.87 (rax rbp)) (rbp (rax tmp-ra.87)) (rax (rbp tmp-ra.87)))))
      (begin (set! tmp-ra.87 r15) (set! rax 30) (jump tmp-ra.87 rbp rax)))
    (define L.fun/ascii-char71271.6
      ((new-frames ())
       (locals (tmp-ra.88))
       (undead-out ((tmp-ra.88 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.88 (rbp)) (rbp (r15 tmp-ra.88)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/ascii-char71272.9 rbp r15)))
    (define L.fun/ascii-char71273.7
      ((new-frames ())
       (locals (tmp-ra.89))
       (undead-out ((tmp-ra.89 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.89 (rbp)) (rbp (r15 tmp-ra.89)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/ascii-char71274.4 rbp r15)))
    (define L.fun/empty71270.8
      ((new-frames ())
       (locals (tmp-ra.90))
       (undead-out ((tmp-ra.90 rbp) (tmp-ra.90 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.90 (rax rbp)) (rbp (rax tmp-ra.90)) (rax (rbp tmp-ra.90)))))
      (begin (set! tmp-ra.90 r15) (set! rax 22) (jump tmp-ra.90 rbp rax)))
    (define L.fun/ascii-char71272.9
      ((new-frames ())
       (locals (tmp-ra.91))
       (undead-out ((tmp-ra.91 rbp) (tmp-ra.91 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.91 (rax rbp)) (rbp (rax tmp-ra.91)) (rax (rbp tmp-ra.91)))))
      (begin (set! tmp-ra.91 r15) (set! rax 25390) (jump tmp-ra.91 rbp rax)))
    (define L.fun/ascii-char71275.10
      ((new-frames ())
       (locals (tmp-ra.92))
       (undead-out ((tmp-ra.92 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/ascii-char71276.13 rbp r15)))
    (define L.fun/void71277.11
      ((new-frames ())
       (locals (tmp-ra.93))
       (undead-out ((tmp-ra.93 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void71278.5 rbp r15)))
    (define L.fun/empty71269.12
      ((new-frames ())
       (locals (tmp-ra.94))
       (undead-out ((tmp-ra.94 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/empty71270.8 rbp r15)))
    (define L.fun/ascii-char71276.13
      ((new-frames ())
       (locals (tmp-ra.95))
       (undead-out ((tmp-ra.95 rbp) (tmp-ra.95 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95)))))
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
       tmp-ra.108))
     (call-undead
      (tmp.71
       tmp.70
       tmp.69
       tmp.81
       tmp.85
       tmp.84
       tmp.83
       tmp.95
       tmp.91
       tmp.92
       tmp.88
       error3.3
       tmp.77
       tmp.78
       tmp.74
       tmp-ra.108))
     (undead-out
      ((tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.108 rbp)
       ((rax tmp.71 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.72 tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp-ra.108 rbp)
       ((rax tmp.70 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.70 tmp-ra.108 rbp)
       ((rax tmp.74 tmp.70 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.75 tmp.70 tmp-ra.108 rbp)
       ((rax tmp.70 tmp-ra.108 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.73 tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.108 rbp)
       ((rax tmp.69 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.78 tmp.69 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.79 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.69 tmp-ra.108 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.77 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.81 tmp.77 tmp.69 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.82 tmp.77 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.108 rbp)
        ((tmp.81 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.80 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.69 tmp-ra.108 rbp)
        ((tmp.77 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.76 tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp) ((r15 rbp) (r15 rbp)))
       (error3.3 tmp-ra.108 rbp)
       ((rax error3.3 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 error3.3 tmp-ra.108 rbp)
       ((rax tmp.85 error3.3 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 tmp.86 error3.3 tmp-ra.108 rbp)
       ((rax error3.3 tmp-ra.108 rbp)
        ((tmp.85 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 error3.3 tmp-ra.108 rbp)
       ((rax tmp.84 error3.3 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.88 tmp.84 error3.3 tmp-ra.108 rbp)
       ((rax tmp.88 tmp.84 error3.3 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.88 tmp.89 tmp.84 error3.3 tmp-ra.108 rbp)
       ((rax tmp.84 error3.3 tmp-ra.108 rbp)
        ((tmp.88 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 tmp.87 error3.3 tmp-ra.108 rbp)
       ((rax error3.3 tmp-ra.108 rbp)
        ((tmp.84 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.83 error3.3 tmp-ra.108 rbp)
       ((rax tmp.83 error3.3 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 tmp.83 error3.3 tmp-ra.108 rbp)
       ((rax tmp.92 tmp.83 error3.3 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 tmp.93 tmp.83 error3.3 tmp-ra.108 rbp)
       ((rax tmp.83 error3.3 tmp-ra.108 rbp)
        ((tmp.92 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.91 tmp.83 error3.3 tmp-ra.108 rbp)
       ((rax tmp.91 tmp.83 error3.3 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.95 tmp.91 tmp.83 error3.3 tmp-ra.108 rbp)
       ((rax tmp.95 tmp.91 tmp.83 error3.3 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.95 tmp.96 tmp.91 tmp.83 error3.3 tmp-ra.108 rbp)
       ((rax tmp.91 tmp.83 error3.3 tmp-ra.108 rbp)
        ((tmp.95 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.91 tmp.94 tmp.83 error3.3 tmp-ra.108 rbp)
       ((rax tmp.83 error3.3 tmp-ra.108 rbp)
        ((tmp.91 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.83 tmp.90 error3.3 tmp-ra.108 rbp)
       ((rax error3.3 tmp-ra.108 rbp)
        ((tmp.83 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (error3.3 tmp-ra.108 rbp)
       ((rax error3.3 tmp-ra.108 rbp) ((r15 rbp) (r15 rbp)))
       (error3.3 tmp-ra.108 rbp)
       (tmp-ra.108 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.108
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
         rax
         rbp))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.108))
       (tmp.72 (rbp tmp-ra.108 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.108))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.108 tmp.70))
       (tmp.75 (rbp tmp-ra.108 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.108 tmp.70))
       (tmp.69
        (rsi
         tmp.76
         tmp.80
         tmp.82
         tmp.81
         tmp.77
         tmp.79
         tmp.78
         rax
         rbp
         tmp-ra.108))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.108 tmp.69))
       (tmp.79 (rbp tmp-ra.108 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.108 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.108 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.108 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.108 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.108 tmp.69))
       (fixnum0.6 (rbp tmp-ra.108))
       (empty1.5 (rbp tmp-ra.108))
       (ascii-char2.4 (rbp tmp-ra.108))
       (error3.3
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
         rax
         rbp
         tmp-ra.108))
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.108 error3.3))
       (tmp.86 (rbp tmp-ra.108 error3.3 tmp.85))
       (tmp.84 (rsi tmp.87 tmp.89 tmp.88 rax rbp tmp-ra.108 error3.3))
       (tmp.88 (rsi tmp.89 rax rbp tmp-ra.108 error3.3 tmp.84))
       (tmp.89 (rbp tmp-ra.108 error3.3 tmp.84 tmp.88))
       (tmp.87 (rbp tmp-ra.108 error3.3 tmp.84))
       (tmp.83
        (rsi
         tmp.90
         tmp.94
         tmp.96
         tmp.95
         tmp.91
         tmp.93
         tmp.92
         rax
         rbp
         tmp-ra.108
         error3.3))
       (tmp.92 (rsi tmp.93 rax rbp tmp-ra.108 error3.3 tmp.83))
       (tmp.93 (rbp tmp-ra.108 error3.3 tmp.83 tmp.92))
       (tmp.91 (rsi tmp.94 tmp.96 tmp.95 rax rbp tmp-ra.108 error3.3 tmp.83))
       (tmp.95 (rsi tmp.96 rax rbp tmp-ra.108 error3.3 tmp.83 tmp.91))
       (tmp.96 (rbp tmp-ra.108 error3.3 tmp.83 tmp.91 tmp.95))
       (tmp.94 (rbp tmp-ra.108 error3.3 tmp.83 tmp.91))
       (tmp.90 (rbp tmp-ra.108 error3.3 tmp.83))
       (fixnum4.2 (rbp tmp-ra.108 error3.3))
       (empty5.1 (rbp tmp-ra.108 error3.3))
       (rbp
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
         r15
         rdi
         rsi
         rax
         tmp-ra.108))
       (rax
        (tmp.95
         tmp.91
         tmp.92
         tmp.83
         tmp.88
         tmp.84
         tmp.85
         error3.3
         tmp.81
         tmp.77
         tmp.78
         tmp.69
         tmp.74
         tmp.70
         tmp.71
         rbp
         tmp-ra.108))
       (rsi
        (tmp.83
         tmp.91
         tmp.95
         tmp.92
         tmp.84
         tmp.88
         tmp.85
         tmp.69
         tmp.77
         tmp.81
         tmp.78
         tmp.70
         tmp.74
         tmp.71
         r15
         rdi
         rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
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
         tmp.56))
       (undead-out
        ((rdi rsi tmp-ra.97 rbp)
         (rsi tmp.22 tmp-ra.97 rbp)
         (tmp.22 tmp.23 tmp-ra.97 rbp)
         ((((((tmp.109 tmp.22 tmp.23 tmp-ra.97 rbp)
              (tmp.109 tmp.22 tmp.23 tmp-ra.97 rbp)
              (tmp.57 tmp.22 tmp.23 tmp-ra.97 rbp))
             (tmp.22 tmp.23 tmp-ra.97 rbp))
            (tmp.56 tmp.22 tmp.23 tmp-ra.97 rbp)
            (tmp.56 tmp.22 tmp.23 tmp-ra.97 rbp))
           (tmp.22 tmp.23 tmp-ra.97 rbp))
          ((((((tmp.110 tmp.22 tmp.23 tmp-ra.97 rbp)
               (tmp.110 tmp.22 tmp.23 tmp-ra.97 rbp)
               (tmp.59 tmp.22 tmp.23 tmp-ra.97 rbp))
              (tmp.22 tmp.23 tmp-ra.97 rbp))
             (tmp.58 tmp.22 tmp.23 tmp-ra.97 rbp)
             (tmp.58 tmp.22 tmp.23 tmp-ra.97 rbp))
            (tmp.22 tmp.23 tmp-ra.97 rbp))
           ((tmp.23 tmp.111 tmp-ra.97 rbp)
            (tmp.111 tmp-ra.97 rbp)
            (tmp-ra.97 rax rbp)
            (rax rbp))
           ((tmp-ra.97 rax rbp) (rax rbp)))
          ((tmp-ra.97 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.97 tmp.23 tmp.22))
         (tmp.109 (tmp.23 rbp tmp-ra.97 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.97
           tmp.22
           tmp.109
           tmp.57
           tmp.56
           tmp.110
           tmp.59
           tmp.58
           tmp.111))
         (tmp.57 (rbp tmp-ra.97 tmp.23 tmp.22))
         (tmp-ra.97
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.109
           tmp.57
           tmp.56
           tmp.110
           tmp.59
           tmp.58
           tmp.111
           rax))
         (tmp.111 (rbp tmp-ra.97 tmp.23))
         (tmp.59 (rbp tmp-ra.97 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.97
           rsi
           tmp.109
           tmp.57
           tmp.56
           tmp.110
           tmp.59
           tmp.58))
         (tmp.110 (tmp.22 rbp tmp-ra.97 tmp.23))
         (tmp.58 (rbp tmp-ra.97 tmp.23 tmp.22))
         (rax (rbp tmp-ra.97))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.97
           tmp.109
           tmp.57
           tmp.56
           tmp.110
           tmp.59
           tmp.58
           tmp.111
           rax))
         (rdi (tmp-ra.97))
         (rsi (tmp.22 tmp-ra.97)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.98 rbp)
         (rsi tmp.24 tmp-ra.98 rbp)
         (tmp.24 tmp.25 tmp-ra.98 rbp)
         ((((((tmp.112 tmp.24 tmp.25 tmp-ra.98 rbp)
              (tmp.112 tmp.24 tmp.25 tmp-ra.98 rbp)
              (tmp.61 tmp.24 tmp.25 tmp-ra.98 rbp))
             (tmp.24 tmp.25 tmp-ra.98 rbp))
            (tmp.60 tmp.24 tmp.25 tmp-ra.98 rbp)
            (tmp.60 tmp.24 tmp.25 tmp-ra.98 rbp))
           (tmp.24 tmp.25 tmp-ra.98 rbp))
          ((((((tmp.113 tmp.24 tmp.25 tmp-ra.98 rbp)
               (tmp.113 tmp.24 tmp.25 tmp-ra.98 rbp)
               (tmp.63 tmp.24 tmp.25 tmp-ra.98 rbp))
              (tmp.24 tmp.25 tmp-ra.98 rbp))
             (tmp.62 tmp.24 tmp.25 tmp-ra.98 rbp)
             (tmp.62 tmp.24 tmp.25 tmp-ra.98 rbp))
            (tmp.24 tmp.25 tmp-ra.98 rbp))
           ((tmp.25 tmp.114 tmp-ra.98 rbp)
            (tmp.114 tmp-ra.98 rbp)
            (tmp-ra.98 rax rbp)
            (rax rbp))
           ((tmp-ra.98 rax rbp) (rax rbp)))
          ((tmp-ra.98 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.98 tmp.25 tmp.24))
         (tmp.112 (tmp.25 rbp tmp-ra.98 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.98
           tmp.24
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.114))
         (tmp.61 (rbp tmp-ra.98 tmp.25 tmp.24))
         (tmp-ra.98
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.114
           rax))
         (tmp.114 (rbp tmp-ra.98 tmp.25))
         (tmp.63 (rbp tmp-ra.98 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.98
           rsi
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62))
         (tmp.113 (tmp.24 rbp tmp-ra.98 tmp.25))
         (tmp.62 (rbp tmp-ra.98 tmp.25 tmp.24))
         (rax (rbp tmp-ra.98))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.98
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.114
           rax))
         (rdi (tmp-ra.98))
         (rsi (tmp.24 tmp-ra.98)))))
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
         tmp.64))
       (undead-out
        ((rdi rsi tmp-ra.99 rbp)
         (rsi tmp.20 tmp-ra.99 rbp)
         (tmp.21 tmp.20 tmp-ra.99 rbp)
         ((((((tmp.115 tmp.21 tmp.20 tmp-ra.99 rbp)
              (tmp.115 tmp.21 tmp.20 tmp-ra.99 rbp)
              (tmp.65 tmp.21 tmp.20 tmp-ra.99 rbp))
             (tmp.21 tmp.20 tmp-ra.99 rbp))
            (tmp.64 tmp.21 tmp.20 tmp-ra.99 rbp)
            (tmp.64 tmp.21 tmp.20 tmp-ra.99 rbp))
           (tmp.21 tmp.20 tmp-ra.99 rbp))
          ((((((tmp.116 tmp.21 tmp.20 tmp-ra.99 rbp)
               (tmp.116 tmp.21 tmp.20 tmp-ra.99 rbp)
               (tmp.67 tmp.21 tmp.20 tmp-ra.99 rbp))
              (tmp.21 tmp.20 tmp-ra.99 rbp))
             (tmp.66 tmp.21 tmp.20 tmp-ra.99 rbp)
             (tmp.66 tmp.21 tmp.20 tmp-ra.99 rbp))
            (tmp.21 tmp.20 tmp-ra.99 rbp))
           ((tmp.117 tmp.20 tmp-ra.99 rbp)
            (tmp.117 tmp.20 tmp-ra.99 rbp)
            (tmp.20 tmp.68 tmp-ra.99 rbp)
            (tmp.68 tmp.118 tmp-ra.99 rbp)
            (tmp.118 tmp-ra.99 rbp)
            (tmp-ra.99 rax rbp)
            (rax rbp))
           ((tmp-ra.99 rax rbp) (rax rbp)))
          ((tmp-ra.99 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.99 tmp.20 tmp.21))
         (tmp.115 (tmp.21 rbp tmp-ra.99 tmp.20))
         (tmp.21
          (rbp tmp-ra.99 tmp.20 tmp.115 tmp.65 tmp.64 tmp.116 tmp.67 tmp.66))
         (tmp.65 (rbp tmp-ra.99 tmp.20 tmp.21))
         (tmp-ra.99
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.115
           tmp.65
           tmp.64
           tmp.116
           tmp.67
           tmp.66
           tmp.118
           tmp.68
           tmp.117
           rax))
         (tmp.117 (rbp tmp-ra.99 tmp.20))
         (tmp.68 (tmp.118 rbp tmp-ra.99 tmp.20))
         (tmp.118 (rbp tmp-ra.99 tmp.68))
         (tmp.67 (rbp tmp-ra.99 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.99
           rsi
           tmp.115
           tmp.65
           tmp.64
           tmp.116
           tmp.67
           tmp.66
           tmp.68
           tmp.117))
         (tmp.116 (tmp.20 rbp tmp-ra.99 tmp.21))
         (tmp.66 (rbp tmp-ra.99 tmp.20 tmp.21))
         (rax (rbp tmp-ra.99))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.99
           tmp.115
           tmp.65
           tmp.64
           tmp.116
           tmp.67
           tmp.66
           tmp.118
           tmp.68
           tmp.117
           rax))
         (rdi (tmp-ra.99))
         (rsi (tmp.20 tmp-ra.99)))))
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
      ((new-frames ())
       (locals (tmp-ra.100))
       (undead-out ((tmp-ra.100 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.100 (rbp)) (rbp (r15 tmp-ra.100)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.100 r15)
        (set! r15 tmp-ra.100)
        (jump L.fun/empty73457.8 rbp r15)))
    (define L.fun/ascii-char73458.5
      ((new-frames ())
       (locals (tmp-ra.101))
       (undead-out ((tmp-ra.101 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.101 (rbp)) (rbp (r15 tmp-ra.101)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.101 r15)
        (set! r15 tmp-ra.101)
        (jump L.fun/ascii-char73459.10 rbp r15)))
    (define L.fun/empty73463.6
      ((new-frames ())
       (locals (tmp-ra.102))
       (undead-out ((tmp-ra.102 rbp) (tmp-ra.102 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.102 (rax rbp))
         (rbp (rax tmp-ra.102))
         (rax (rbp tmp-ra.102)))))
      (begin (set! tmp-ra.102 r15) (set! rax 22) (jump tmp-ra.102 rbp rax)))
    (define L.fun/error73460.7
      ((new-frames ())
       (locals (tmp-ra.103))
       (undead-out ((tmp-ra.103 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.103 (rbp)) (rbp (r15 tmp-ra.103)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.103 r15)
        (set! r15 tmp-ra.103)
        (jump L.fun/error73461.9 rbp r15)))
    (define L.fun/empty73457.8
      ((new-frames ())
       (locals (tmp-ra.104))
       (undead-out ((tmp-ra.104 rbp) (tmp-ra.104 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.104 (rax rbp))
         (rbp (rax tmp-ra.104))
         (rax (rbp tmp-ra.104)))))
      (begin (set! tmp-ra.104 r15) (set! rax 22) (jump tmp-ra.104 rbp rax)))
    (define L.fun/error73461.9
      ((new-frames ())
       (locals (tmp-ra.105))
       (undead-out ((tmp-ra.105 rbp) (tmp-ra.105 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.105 (rax rbp))
         (rbp (rax tmp-ra.105))
         (rax (rbp tmp-ra.105)))))
      (begin (set! tmp-ra.105 r15) (set! rax 20542) (jump tmp-ra.105 rbp rax)))
    (define L.fun/ascii-char73459.10
      ((new-frames ())
       (locals (tmp-ra.106))
       (undead-out ((tmp-ra.106 rbp) (tmp-ra.106 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.106 (rax rbp))
         (rbp (rax tmp-ra.106))
         (rax (rbp tmp-ra.106)))))
      (begin (set! tmp-ra.106 r15) (set! rax 25390) (jump tmp-ra.106 rbp rax)))
    (define L.fun/empty73462.11
      ((new-frames ())
       (locals (tmp-ra.107))
       (undead-out ((tmp-ra.107 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.107 (rbp)) (rbp (r15 tmp-ra.107)) (r15 (rbp)))))
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
       tmp-ra.96))
     (call-undead
      (tmp.74 tmp.78 tmp.77 empty2.4 tmp.81 tmp.69 tmp.70 tmp.71 tmp-ra.96))
     (undead-out
      ((tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.96 rbp)
       ((rax tmp.71 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.72 tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp-ra.96 rbp)
       ((rax tmp.70 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.70 tmp-ra.96 rbp)
       ((rax tmp.74 tmp.70 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.75 tmp.70 tmp-ra.96 rbp)
       ((rax tmp.70 tmp-ra.96 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.73 tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.96 rbp)
       ((rax tmp.69 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.78 tmp.69 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.79 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.69 tmp-ra.96 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.77 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.81 tmp.77 tmp.69 tmp-ra.96 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.82 tmp.77 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.96 rbp)
        ((tmp.81 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.80 tmp.69 tmp-ra.96 rbp)
       ((rax tmp.69 tmp-ra.96 rbp)
        ((tmp.77 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.76 tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.96 rbp)
       ((rax tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (empty2.4 tmp-ra.96 rbp)
       ((rax empty2.4 tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (empty2.4 tmp-ra.96 rbp)
       ((rax empty2.4 tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (empty2.4 tmp-ra.96 rbp)
       ((rax empty2.4 tmp-ra.96 rbp) ((r15 rbp) (r15 rbp)))
       (empty2.4 tmp-ra.96 rbp)
       (tmp-ra.96 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.96
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
         rax
         rbp))
       (void0.6 (rbp tmp-ra.96))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.96))
       (tmp.72 (rbp tmp-ra.96 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.96))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.96 tmp.70))
       (tmp.75 (rbp tmp-ra.96 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.96 tmp.70))
       (tmp.69
        (rsi
         tmp.76
         tmp.80
         tmp.82
         tmp.81
         tmp.77
         tmp.79
         tmp.78
         rax
         rbp
         tmp-ra.96))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.96 tmp.69))
       (tmp.79 (rbp tmp-ra.96 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.96 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.96 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.96 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.96 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.96 tmp.69))
       (fixnum1.5 (rbp tmp-ra.96))
       (empty2.4 (error5.1 error4.2 void3.3 rax rbp tmp-ra.96))
       (void3.3 (rbp tmp-ra.96 empty2.4))
       (error4.2 (rbp tmp-ra.96 empty2.4))
       (error5.1 (rbp tmp-ra.96 empty2.4))
       (rbp
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
         rdi
         rsi
         void0.6
         r15
         rax
         tmp-ra.96))
       (rax
        (empty2.4
         tmp.81
         tmp.77
         tmp.78
         tmp.69
         tmp.74
         tmp.70
         tmp.71
         rbp
         tmp-ra.96))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi)))))
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
         tmp.56))
       (undead-out
        ((rdi rsi tmp-ra.83 rbp)
         (rsi tmp.22 tmp-ra.83 rbp)
         (tmp.22 tmp.23 tmp-ra.83 rbp)
         ((((((tmp.97 tmp.22 tmp.23 tmp-ra.83 rbp)
              (tmp.97 tmp.22 tmp.23 tmp-ra.83 rbp)
              (tmp.57 tmp.22 tmp.23 tmp-ra.83 rbp))
             (tmp.22 tmp.23 tmp-ra.83 rbp))
            (tmp.56 tmp.22 tmp.23 tmp-ra.83 rbp)
            (tmp.56 tmp.22 tmp.23 tmp-ra.83 rbp))
           (tmp.22 tmp.23 tmp-ra.83 rbp))
          ((((((tmp.98 tmp.22 tmp.23 tmp-ra.83 rbp)
               (tmp.98 tmp.22 tmp.23 tmp-ra.83 rbp)
               (tmp.59 tmp.22 tmp.23 tmp-ra.83 rbp))
              (tmp.22 tmp.23 tmp-ra.83 rbp))
             (tmp.58 tmp.22 tmp.23 tmp-ra.83 rbp)
             (tmp.58 tmp.22 tmp.23 tmp-ra.83 rbp))
            (tmp.22 tmp.23 tmp-ra.83 rbp))
           ((tmp.23 tmp.99 tmp-ra.83 rbp)
            (tmp.99 tmp-ra.83 rbp)
            (tmp-ra.83 rax rbp)
            (rax rbp))
           ((tmp-ra.83 rax rbp) (rax rbp)))
          ((tmp-ra.83 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.83 tmp.23 tmp.22))
         (tmp.97 (tmp.23 rbp tmp-ra.83 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.83
           tmp.22
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99))
         (tmp.57 (rbp tmp-ra.83 tmp.23 tmp.22))
         (tmp-ra.83
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99
           rax))
         (tmp.99 (rbp tmp-ra.83 tmp.23))
         (tmp.59 (rbp tmp-ra.83 tmp.23 tmp.22))
         (tmp.22
          (tmp.23 rbp tmp-ra.83 rsi tmp.97 tmp.57 tmp.56 tmp.98 tmp.59 tmp.58))
         (tmp.98 (tmp.22 rbp tmp-ra.83 tmp.23))
         (tmp.58 (rbp tmp-ra.83 tmp.23 tmp.22))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.83
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.99
           rax))
         (rdi (tmp-ra.83))
         (rsi (tmp.22 tmp-ra.83)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.84 rbp)
         (rsi tmp.24 tmp-ra.84 rbp)
         (tmp.24 tmp.25 tmp-ra.84 rbp)
         ((((((tmp.100 tmp.24 tmp.25 tmp-ra.84 rbp)
              (tmp.100 tmp.24 tmp.25 tmp-ra.84 rbp)
              (tmp.61 tmp.24 tmp.25 tmp-ra.84 rbp))
             (tmp.24 tmp.25 tmp-ra.84 rbp))
            (tmp.60 tmp.24 tmp.25 tmp-ra.84 rbp)
            (tmp.60 tmp.24 tmp.25 tmp-ra.84 rbp))
           (tmp.24 tmp.25 tmp-ra.84 rbp))
          ((((((tmp.101 tmp.24 tmp.25 tmp-ra.84 rbp)
               (tmp.101 tmp.24 tmp.25 tmp-ra.84 rbp)
               (tmp.63 tmp.24 tmp.25 tmp-ra.84 rbp))
              (tmp.24 tmp.25 tmp-ra.84 rbp))
             (tmp.62 tmp.24 tmp.25 tmp-ra.84 rbp)
             (tmp.62 tmp.24 tmp.25 tmp-ra.84 rbp))
            (tmp.24 tmp.25 tmp-ra.84 rbp))
           ((tmp.25 tmp.102 tmp-ra.84 rbp)
            (tmp.102 tmp-ra.84 rbp)
            (tmp-ra.84 rax rbp)
            (rax rbp))
           ((tmp-ra.84 rax rbp) (rax rbp)))
          ((tmp-ra.84 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.84 tmp.25 tmp.24))
         (tmp.100 (tmp.25 rbp tmp-ra.84 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.84
           tmp.24
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.102))
         (tmp.61 (rbp tmp-ra.84 tmp.25 tmp.24))
         (tmp-ra.84
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.102
           rax))
         (tmp.102 (rbp tmp-ra.84 tmp.25))
         (tmp.63 (rbp tmp-ra.84 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.84
           rsi
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62))
         (tmp.101 (tmp.24 rbp tmp-ra.84 tmp.25))
         (tmp.62 (rbp tmp-ra.84 tmp.25 tmp.24))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.84
           tmp.100
           tmp.61
           tmp.60
           tmp.101
           tmp.63
           tmp.62
           tmp.102
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.24 tmp-ra.84)))))
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
         tmp.64))
       (undead-out
        ((rdi rsi tmp-ra.85 rbp)
         (rsi tmp.20 tmp-ra.85 rbp)
         (tmp.21 tmp.20 tmp-ra.85 rbp)
         ((((((tmp.103 tmp.21 tmp.20 tmp-ra.85 rbp)
              (tmp.103 tmp.21 tmp.20 tmp-ra.85 rbp)
              (tmp.65 tmp.21 tmp.20 tmp-ra.85 rbp))
             (tmp.21 tmp.20 tmp-ra.85 rbp))
            (tmp.64 tmp.21 tmp.20 tmp-ra.85 rbp)
            (tmp.64 tmp.21 tmp.20 tmp-ra.85 rbp))
           (tmp.21 tmp.20 tmp-ra.85 rbp))
          ((((((tmp.104 tmp.21 tmp.20 tmp-ra.85 rbp)
               (tmp.104 tmp.21 tmp.20 tmp-ra.85 rbp)
               (tmp.67 tmp.21 tmp.20 tmp-ra.85 rbp))
              (tmp.21 tmp.20 tmp-ra.85 rbp))
             (tmp.66 tmp.21 tmp.20 tmp-ra.85 rbp)
             (tmp.66 tmp.21 tmp.20 tmp-ra.85 rbp))
            (tmp.21 tmp.20 tmp-ra.85 rbp))
           ((tmp.105 tmp.20 tmp-ra.85 rbp)
            (tmp.105 tmp.20 tmp-ra.85 rbp)
            (tmp.20 tmp.68 tmp-ra.85 rbp)
            (tmp.68 tmp.106 tmp-ra.85 rbp)
            (tmp.106 tmp-ra.85 rbp)
            (tmp-ra.85 rax rbp)
            (rax rbp))
           ((tmp-ra.85 rax rbp) (rax rbp)))
          ((tmp-ra.85 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp.103 (tmp.21 rbp tmp-ra.85 tmp.20))
         (tmp.21
          (rbp tmp-ra.85 tmp.20 tmp.103 tmp.65 tmp.64 tmp.104 tmp.67 tmp.66))
         (tmp.65 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp-ra.85
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.103
           tmp.65
           tmp.64
           tmp.104
           tmp.67
           tmp.66
           tmp.106
           tmp.68
           tmp.105
           rax))
         (tmp.105 (rbp tmp-ra.85 tmp.20))
         (tmp.68 (tmp.106 rbp tmp-ra.85 tmp.20))
         (tmp.106 (rbp tmp-ra.85 tmp.68))
         (tmp.67 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.85
           rsi
           tmp.103
           tmp.65
           tmp.64
           tmp.104
           tmp.67
           tmp.66
           tmp.68
           tmp.105))
         (tmp.104 (tmp.20 rbp tmp-ra.85 tmp.21))
         (tmp.66 (rbp tmp-ra.85 tmp.20 tmp.21))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.85
           tmp.103
           tmp.65
           tmp.64
           tmp.104
           tmp.67
           tmp.66
           tmp.106
           tmp.68
           tmp.105
           rax))
         (rdi (tmp-ra.85))
         (rsi (tmp.20 tmp-ra.85)))))
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
      ((new-frames ())
       (locals (tmp-ra.86))
       (undead-out ((tmp-ra.86 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.86 (rbp)) (rbp (r15 tmp-ra.86)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.86 r15)
        (set! r15 tmp-ra.86)
        (jump L.fun/void77843.9 rbp r15)))
    (define L.fun/void77838.5
      ((new-frames ())
       (locals (tmp-ra.87))
       (undead-out ((tmp-ra.87 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.87 (rbp)) (rbp (r15 tmp-ra.87)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/void77839.10 rbp r15)))
    (define L.fun/error77846.6
      ((new-frames ())
       (locals (tmp-ra.88))
       (undead-out ((tmp-ra.88 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.88 (rbp)) (rbp (r15 tmp-ra.88)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/error77847.13 rbp r15)))
    (define L.fun/error77845.7
      ((new-frames ())
       (locals (tmp-ra.89))
       (undead-out ((tmp-ra.89 rbp) (tmp-ra.89 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89)))))
      (begin (set! tmp-ra.89 r15) (set! rax 62014) (jump tmp-ra.89 rbp rax)))
    (define L.fun/empty77840.8
      ((new-frames ())
       (locals (tmp-ra.90))
       (undead-out ((tmp-ra.90 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.90 (rbp)) (rbp (r15 tmp-ra.90)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/empty77841.11 rbp r15)))
    (define L.fun/void77843.9
      ((new-frames ())
       (locals (tmp-ra.91))
       (undead-out ((tmp-ra.91 rbp) (tmp-ra.91 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.91 (rax rbp)) (rbp (rax tmp-ra.91)) (rax (rbp tmp-ra.91)))))
      (begin (set! tmp-ra.91 r15) (set! rax 30) (jump tmp-ra.91 rbp rax)))
    (define L.fun/void77839.10
      ((new-frames ())
       (locals (tmp-ra.92))
       (undead-out ((tmp-ra.92 rbp) (tmp-ra.92 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.92 (rax rbp)) (rbp (rax tmp-ra.92)) (rax (rbp tmp-ra.92)))))
      (begin (set! tmp-ra.92 r15) (set! rax 30) (jump tmp-ra.92 rbp rax)))
    (define L.fun/empty77841.11
      ((new-frames ())
       (locals (tmp-ra.93))
       (undead-out ((tmp-ra.93 rbp) (tmp-ra.93 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93)))))
      (begin (set! tmp-ra.93 r15) (set! rax 22) (jump tmp-ra.93 rbp rax)))
    (define L.fun/error77844.12
      ((new-frames ())
       (locals (tmp-ra.94))
       (undead-out ((tmp-ra.94 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error77845.7 rbp r15)))
    (define L.fun/error77847.13
      ((new-frames ())
       (locals (tmp-ra.95))
       (undead-out ((tmp-ra.95 rbp) (tmp-ra.95 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95)))))
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
       tmp-ra.114))
     (call-undead
      (tmp.76
       tmp.80
       tmp.79
       tmp.89
       tmp.88
       tmp.87
       tmp.99
       tmp.95
       tmp.96
       tmp.92
       tmp.83
       tmp.71
       tmp.72
       tmp.73
       tmp-ra.114))
     (undead-out
      ((tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.73 tmp-ra.114 rbp)
       ((rax tmp.73 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.73 tmp.74 tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp)
        ((tmp.73 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp-ra.114 rbp)
       ((rax tmp.72 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.76 tmp.72 tmp-ra.114 rbp)
       ((rax tmp.76 tmp.72 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.76 tmp.77 tmp.72 tmp-ra.114 rbp)
       ((rax tmp.72 tmp-ra.114 rbp)
        ((tmp.76 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.75 tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.114 rbp)
       ((rax tmp.71 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.80 tmp.71 tmp-ra.114 rbp)
       ((rax tmp.80 tmp.71 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.80 tmp.81 tmp.71 tmp-ra.114 rbp)
       ((rax tmp.71 tmp-ra.114 rbp)
        ((tmp.80 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.71 tmp-ra.114 rbp)
       ((rax tmp.79 tmp.71 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.83 tmp.79 tmp.71 tmp-ra.114 rbp)
       ((rax tmp.83 tmp.79 tmp.71 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.83 tmp.84 tmp.79 tmp.71 tmp-ra.114 rbp)
       ((rax tmp.79 tmp.71 tmp-ra.114 rbp)
        ((tmp.83 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.82 tmp.71 tmp-ra.114 rbp)
       ((rax tmp.71 tmp-ra.114 rbp)
        ((tmp.79 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.78 tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.85 tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.86 tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.89 tmp-ra.114 rbp)
       ((rax tmp.89 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.89 tmp.90 tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp)
        ((tmp.89 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.88 tmp-ra.114 rbp)
       ((rax tmp.88 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 tmp.88 tmp-ra.114 rbp)
       ((rax tmp.92 tmp.88 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 tmp.93 tmp.88 tmp-ra.114 rbp)
       ((rax tmp.88 tmp-ra.114 rbp)
        ((tmp.92 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.88 tmp.91 tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp)
        ((tmp.88 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.87 tmp-ra.114 rbp)
       ((rax tmp.87 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.96 tmp.87 tmp-ra.114 rbp)
       ((rax tmp.96 tmp.87 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.96 tmp.97 tmp.87 tmp-ra.114 rbp)
       ((rax tmp.87 tmp-ra.114 rbp)
        ((tmp.96 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.95 tmp.87 tmp-ra.114 rbp)
       ((rax tmp.95 tmp.87 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.99 tmp.95 tmp.87 tmp-ra.114 rbp)
       ((rax tmp.99 tmp.95 tmp.87 tmp-ra.114 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.99 tmp.100 tmp.95 tmp.87 tmp-ra.114 rbp)
       ((rax tmp.95 tmp.87 tmp-ra.114 rbp)
        ((tmp.99 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.95 tmp.98 tmp.87 tmp-ra.114 rbp)
       ((rax tmp.87 tmp-ra.114 rbp)
        ((tmp.95 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.87 tmp.94 tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp)
        ((tmp.87 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.114 rbp)
       ((rax tmp-ra.114 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.114 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.114
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
         rax
         rbp))
       (error0.6 (rbp tmp-ra.114))
       (tmp.73 (rsi tmp.74 rax rbp tmp-ra.114))
       (tmp.74 (rbp tmp-ra.114 tmp.73))
       (tmp.72 (rsi tmp.75 tmp.77 tmp.76 rax rbp tmp-ra.114))
       (tmp.76 (rsi tmp.77 rax rbp tmp-ra.114 tmp.72))
       (tmp.77 (rbp tmp-ra.114 tmp.72 tmp.76))
       (tmp.75 (rbp tmp-ra.114 tmp.72))
       (tmp.71
        (rsi
         tmp.78
         tmp.82
         tmp.84
         tmp.83
         tmp.79
         tmp.81
         tmp.80
         rax
         rbp
         tmp-ra.114))
       (tmp.80 (rsi tmp.81 rax rbp tmp-ra.114 tmp.71))
       (tmp.81 (rbp tmp-ra.114 tmp.71 tmp.80))
       (tmp.79 (rsi tmp.82 tmp.84 tmp.83 rax rbp tmp-ra.114 tmp.71))
       (tmp.83 (rsi tmp.84 rax rbp tmp-ra.114 tmp.71 tmp.79))
       (tmp.84 (rbp tmp-ra.114 tmp.71 tmp.79 tmp.83))
       (tmp.82 (rbp tmp-ra.114 tmp.71 tmp.79))
       (tmp.78 (rbp tmp-ra.114 tmp.71))
       (fixnum1.5 (rbp tmp-ra.114))
       (tmp.85 (rbp tmp-ra.114))
       (boolean2.4 (rbp tmp-ra.114))
       (tmp.86 (rbp tmp-ra.114))
       (boolean3.3 (rbp tmp-ra.114))
       (tmp.89 (rsi tmp.90 rax rbp tmp-ra.114))
       (tmp.90 (rbp tmp-ra.114 tmp.89))
       (tmp.88 (rsi tmp.91 tmp.93 tmp.92 rax rbp tmp-ra.114))
       (tmp.92 (rsi tmp.93 rax rbp tmp-ra.114 tmp.88))
       (tmp.93 (rbp tmp-ra.114 tmp.88 tmp.92))
       (tmp.91 (rbp tmp-ra.114 tmp.88))
       (tmp.87
        (rsi
         tmp.94
         tmp.98
         tmp.100
         tmp.99
         tmp.95
         tmp.97
         tmp.96
         rax
         rbp
         tmp-ra.114))
       (tmp.96 (rsi tmp.97 rax rbp tmp-ra.114 tmp.87))
       (tmp.97 (rbp tmp-ra.114 tmp.87 tmp.96))
       (tmp.95 (rsi tmp.98 tmp.100 tmp.99 rax rbp tmp-ra.114 tmp.87))
       (tmp.99 (rsi tmp.100 rax rbp tmp-ra.114 tmp.87 tmp.95))
       (tmp.100 (rbp tmp-ra.114 tmp.87 tmp.95 tmp.99))
       (tmp.98 (rbp tmp-ra.114 tmp.87 tmp.95))
       (tmp.94 (rbp tmp-ra.114 tmp.87))
       (fixnum4.2 (rbp tmp-ra.114))
       (error5.1 (rbp tmp-ra.114))
       (rbp
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
         rdi
         rsi
         error0.6
         r15
         rax
         tmp-ra.114))
       (rax
        (tmp.99
         tmp.95
         tmp.96
         tmp.87
         tmp.92
         tmp.88
         tmp.89
         tmp.83
         tmp.79
         tmp.80
         tmp.71
         tmp.76
         tmp.72
         tmp.73
         rbp
         tmp-ra.114))
       (r15 (rdi rsi rbp))
       (rsi
        (tmp.87
         tmp.95
         tmp.99
         tmp.96
         tmp.88
         tmp.92
         tmp.89
         tmp.71
         tmp.79
         tmp.83
         tmp.80
         tmp.72
         tmp.76
         tmp.73
         r15
         rdi
         rbp))
       (rdi (r15 rbp rsi)))))
    (define L.ascii-char?.17
      ((new-frames ())
       (locals (tmp-ra.101 tmp.115 tmp.47 tmp.56))
       (undead-out
        ((rdi tmp-ra.101 rbp)
         (tmp.47 tmp-ra.101 rbp)
         ((((tmp.115 tmp-ra.101 rbp)
            (tmp.115 tmp-ra.101 rbp)
            (tmp.56 tmp-ra.101 rbp))
           (tmp-ra.101 rbp))
          ((tmp-ra.101 rax rbp) (rax rbp))
          ((tmp-ra.101 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.101))
         (tmp.47 (rbp tmp-ra.101))
         (tmp.115 (rbp tmp-ra.101))
         (tmp-ra.101 (tmp.47 rbp rdi tmp.115 tmp.56 rax))
         (rax (rbp tmp-ra.101))
         (rbp (tmp.47 tmp-ra.101 tmp.115 tmp.56 rax))
         (rdi (tmp-ra.101)))))
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
      ((new-frames ())
       (locals (tmp-ra.102 tmp.116 tmp.44 tmp.57))
       (undead-out
        ((rdi tmp-ra.102 rbp)
         (tmp.44 tmp-ra.102 rbp)
         ((((tmp.116 tmp-ra.102 rbp)
            (tmp.116 tmp-ra.102 rbp)
            (tmp.57 tmp-ra.102 rbp))
           (tmp-ra.102 rbp))
          ((tmp-ra.102 rax rbp) (rax rbp))
          ((tmp-ra.102 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.102))
         (tmp.44 (rbp tmp-ra.102))
         (tmp.116 (rbp tmp-ra.102))
         (tmp-ra.102 (tmp.44 rbp rdi tmp.116 tmp.57 rax))
         (rax (rbp tmp-ra.102))
         (rbp (tmp.44 tmp-ra.102 tmp.116 tmp.57 rax))
         (rdi (tmp-ra.102)))))
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
         tmp.58))
       (undead-out
        ((rdi rsi tmp-ra.103 rbp)
         (rsi tmp.22 tmp-ra.103 rbp)
         (tmp.22 tmp.23 tmp-ra.103 rbp)
         ((((((tmp.117 tmp.22 tmp.23 tmp-ra.103 rbp)
              (tmp.117 tmp.22 tmp.23 tmp-ra.103 rbp)
              (tmp.59 tmp.22 tmp.23 tmp-ra.103 rbp))
             (tmp.22 tmp.23 tmp-ra.103 rbp))
            (tmp.58 tmp.22 tmp.23 tmp-ra.103 rbp)
            (tmp.58 tmp.22 tmp.23 tmp-ra.103 rbp))
           (tmp.22 tmp.23 tmp-ra.103 rbp))
          ((((((tmp.118 tmp.22 tmp.23 tmp-ra.103 rbp)
               (tmp.118 tmp.22 tmp.23 tmp-ra.103 rbp)
               (tmp.61 tmp.22 tmp.23 tmp-ra.103 rbp))
              (tmp.22 tmp.23 tmp-ra.103 rbp))
             (tmp.60 tmp.22 tmp.23 tmp-ra.103 rbp)
             (tmp.60 tmp.22 tmp.23 tmp-ra.103 rbp))
            (tmp.22 tmp.23 tmp-ra.103 rbp))
           ((tmp.23 tmp.119 tmp-ra.103 rbp)
            (tmp.119 tmp-ra.103 rbp)
            (tmp-ra.103 rax rbp)
            (rax rbp))
           ((tmp-ra.103 rax rbp) (rax rbp)))
          ((tmp-ra.103 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.58 (rbp tmp-ra.103 tmp.23 tmp.22))
         (tmp.117 (tmp.23 rbp tmp-ra.103 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.103
           tmp.22
           tmp.117
           tmp.59
           tmp.58
           tmp.118
           tmp.61
           tmp.60
           tmp.119))
         (tmp.59 (rbp tmp-ra.103 tmp.23 tmp.22))
         (tmp-ra.103
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.117
           tmp.59
           tmp.58
           tmp.118
           tmp.61
           tmp.60
           tmp.119
           rax))
         (tmp.119 (rbp tmp-ra.103 tmp.23))
         (tmp.61 (rbp tmp-ra.103 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.103
           rsi
           tmp.117
           tmp.59
           tmp.58
           tmp.118
           tmp.61
           tmp.60))
         (tmp.118 (tmp.22 rbp tmp-ra.103 tmp.23))
         (tmp.60 (rbp tmp-ra.103 tmp.23 tmp.22))
         (rax (rbp tmp-ra.103))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.103
           tmp.117
           tmp.59
           tmp.58
           tmp.118
           tmp.61
           tmp.60
           tmp.119
           rax))
         (rdi (tmp-ra.103))
         (rsi (tmp.22 tmp-ra.103)))))
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
         tmp.62))
       (undead-out
        ((rdi rsi tmp-ra.104 rbp)
         (rsi tmp.20 tmp-ra.104 rbp)
         (tmp.21 tmp.20 tmp-ra.104 rbp)
         ((((((tmp.120 tmp.21 tmp.20 tmp-ra.104 rbp)
              (tmp.120 tmp.21 tmp.20 tmp-ra.104 rbp)
              (tmp.63 tmp.21 tmp.20 tmp-ra.104 rbp))
             (tmp.21 tmp.20 tmp-ra.104 rbp))
            (tmp.62 tmp.21 tmp.20 tmp-ra.104 rbp)
            (tmp.62 tmp.21 tmp.20 tmp-ra.104 rbp))
           (tmp.21 tmp.20 tmp-ra.104 rbp))
          ((((((tmp.121 tmp.21 tmp.20 tmp-ra.104 rbp)
               (tmp.121 tmp.21 tmp.20 tmp-ra.104 rbp)
               (tmp.65 tmp.21 tmp.20 tmp-ra.104 rbp))
              (tmp.21 tmp.20 tmp-ra.104 rbp))
             (tmp.64 tmp.21 tmp.20 tmp-ra.104 rbp)
             (tmp.64 tmp.21 tmp.20 tmp-ra.104 rbp))
            (tmp.21 tmp.20 tmp-ra.104 rbp))
           ((tmp.122 tmp.20 tmp-ra.104 rbp)
            (tmp.122 tmp.20 tmp-ra.104 rbp)
            (tmp.20 tmp.66 tmp-ra.104 rbp)
            (tmp.66 tmp.123 tmp-ra.104 rbp)
            (tmp.123 tmp-ra.104 rbp)
            (tmp-ra.104 rax rbp)
            (rax rbp))
           ((tmp-ra.104 rax rbp) (rax rbp)))
          ((tmp-ra.104 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.62 (rbp tmp-ra.104 tmp.20 tmp.21))
         (tmp.120 (tmp.21 rbp tmp-ra.104 tmp.20))
         (tmp.21
          (rbp tmp-ra.104 tmp.20 tmp.120 tmp.63 tmp.62 tmp.121 tmp.65 tmp.64))
         (tmp.63 (rbp tmp-ra.104 tmp.20 tmp.21))
         (tmp-ra.104
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.120
           tmp.63
           tmp.62
           tmp.121
           tmp.65
           tmp.64
           tmp.123
           tmp.66
           tmp.122
           rax))
         (tmp.122 (rbp tmp-ra.104 tmp.20))
         (tmp.66 (tmp.123 rbp tmp-ra.104 tmp.20))
         (tmp.123 (rbp tmp-ra.104 tmp.66))
         (tmp.65 (rbp tmp-ra.104 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.104
           rsi
           tmp.120
           tmp.63
           tmp.62
           tmp.121
           tmp.65
           tmp.64
           tmp.66
           tmp.122))
         (tmp.121 (tmp.20 rbp tmp-ra.104 tmp.21))
         (tmp.64 (rbp tmp-ra.104 tmp.20 tmp.21))
         (rax (rbp tmp-ra.104))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.104
           tmp.120
           tmp.63
           tmp.62
           tmp.121
           tmp.65
           tmp.64
           tmp.123
           tmp.66
           tmp.122
           rax))
         (rdi (tmp-ra.104))
         (rsi (tmp.20 tmp-ra.104)))))
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
         tmp.67))
       (undead-out
        ((rdi rsi tmp-ra.105 rbp)
         (rsi tmp.24 tmp-ra.105 rbp)
         (tmp.24 tmp.25 tmp-ra.105 rbp)
         ((((((tmp.124 tmp.24 tmp.25 tmp-ra.105 rbp)
              (tmp.124 tmp.24 tmp.25 tmp-ra.105 rbp)
              (tmp.68 tmp.24 tmp.25 tmp-ra.105 rbp))
             (tmp.24 tmp.25 tmp-ra.105 rbp))
            (tmp.67 tmp.24 tmp.25 tmp-ra.105 rbp)
            (tmp.67 tmp.24 tmp.25 tmp-ra.105 rbp))
           (tmp.24 tmp.25 tmp-ra.105 rbp))
          ((((((tmp.125 tmp.24 tmp.25 tmp-ra.105 rbp)
               (tmp.125 tmp.24 tmp.25 tmp-ra.105 rbp)
               (tmp.70 tmp.24 tmp.25 tmp-ra.105 rbp))
              (tmp.24 tmp.25 tmp-ra.105 rbp))
             (tmp.69 tmp.24 tmp.25 tmp-ra.105 rbp)
             (tmp.69 tmp.24 tmp.25 tmp-ra.105 rbp))
            (tmp.24 tmp.25 tmp-ra.105 rbp))
           ((tmp.25 tmp.126 tmp-ra.105 rbp)
            (tmp.126 tmp-ra.105 rbp)
            (tmp-ra.105 rax rbp)
            (rax rbp))
           ((tmp-ra.105 rax rbp) (rax rbp)))
          ((tmp-ra.105 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.67 (rbp tmp-ra.105 tmp.25 tmp.24))
         (tmp.124 (tmp.25 rbp tmp-ra.105 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.105
           tmp.24
           tmp.124
           tmp.68
           tmp.67
           tmp.125
           tmp.70
           tmp.69
           tmp.126))
         (tmp.68 (rbp tmp-ra.105 tmp.25 tmp.24))
         (tmp-ra.105
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.124
           tmp.68
           tmp.67
           tmp.125
           tmp.70
           tmp.69
           tmp.126
           rax))
         (tmp.126 (rbp tmp-ra.105 tmp.25))
         (tmp.70 (rbp tmp-ra.105 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.105
           rsi
           tmp.124
           tmp.68
           tmp.67
           tmp.125
           tmp.70
           tmp.69))
         (tmp.125 (tmp.24 rbp tmp-ra.105 tmp.25))
         (tmp.69 (rbp tmp-ra.105 tmp.25 tmp.24))
         (rax (rbp tmp-ra.105))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.105
           tmp.124
           tmp.68
           tmp.67
           tmp.125
           tmp.70
           tmp.69
           tmp.126
           rax))
         (rdi (tmp-ra.105))
         (rsi (tmp.24 tmp-ra.105)))))
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
      ((new-frames ())
       (locals (tmp-ra.106))
       (undead-out ((tmp-ra.106 rbp) (tmp-ra.106 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.106 (rax rbp))
         (rbp (rax tmp-ra.106))
         (rax (rbp tmp-ra.106)))))
      (begin (set! tmp-ra.106 r15) (set! rax 6) (jump tmp-ra.106 rbp rax)))
    (define L.fun/void78099.5
      ((new-frames ())
       (locals (tmp-ra.107))
       (undead-out ((tmp-ra.107 rbp) (tmp-ra.107 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.107 (rax rbp))
         (rbp (rax tmp-ra.107))
         (rax (rbp tmp-ra.107)))))
      (begin (set! tmp-ra.107 r15) (set! rax 30) (jump tmp-ra.107 rbp rax)))
    (define L.fun/error78092.6
      ((new-frames ())
       (locals (tmp-ra.108))
       (undead-out ((tmp-ra.108 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.108 (rbp)) (rbp (r15 tmp-ra.108)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.108 r15)
        (set! r15 tmp-ra.108)
        (jump L.fun/error78093.9 rbp r15)))
    (define L.fun/any78094.7
      ((new-frames ())
       (locals (tmp-ra.109))
       (undead-out ((tmp-ra.109 rbp) (tmp-ra.109 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.109 (rax rbp))
         (rbp (rax tmp-ra.109))
         (rax (rbp tmp-ra.109)))))
      (begin (set! tmp-ra.109 r15) (set! rax 6) (jump tmp-ra.109 rbp rax)))
    (define L.fun/error78097.8
      ((new-frames ())
       (locals (tmp-ra.110))
       (undead-out ((tmp-ra.110 rbp) (tmp-ra.110 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.110 (rax rbp))
         (rbp (rax tmp-ra.110))
         (rax (rbp tmp-ra.110)))))
      (begin (set! tmp-ra.110 r15) (set! rax 36670) (jump tmp-ra.110 rbp rax)))
    (define L.fun/error78093.9
      ((new-frames ())
       (locals (tmp-ra.111))
       (undead-out ((tmp-ra.111 rbp) (tmp-ra.111 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.111 (rax rbp))
         (rbp (rax tmp-ra.111))
         (rax (rbp tmp-ra.111)))))
      (begin (set! tmp-ra.111 r15) (set! rax 24126) (jump tmp-ra.111 rbp rax)))
    (define L.fun/error78096.10
      ((new-frames ())
       (locals (tmp-ra.112))
       (undead-out ((tmp-ra.112 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.112 (rbp)) (rbp (r15 tmp-ra.112)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.112 r15)
        (set! r15 tmp-ra.112)
        (jump L.fun/error78097.8 rbp r15)))
    (define L.fun/void78098.11
      ((new-frames ())
       (locals (tmp-ra.113))
       (undead-out ((tmp-ra.113 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.113 (rbp)) (rbp (r15 tmp-ra.113)) (r15 (rbp)))))
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
       tmp-ra.98))
     (call-undead
      (tmp.72 tmp.71 tmp.70 tmp.82 empty4.2 tmp.78 tmp.79 tmp.75 tmp-ra.98))
     (undead-out
      ((tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp-ra.98 rbp)
       ((rax tmp.72 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.73 tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.98 rbp)
       ((rax tmp.71 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp.71 tmp-ra.98 rbp)
       ((rax tmp.75 tmp.71 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.75 tmp.76 tmp.71 tmp-ra.98 rbp)
       ((rax tmp.71 tmp-ra.98 rbp)
        ((tmp.75 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.74 tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp-ra.98 rbp)
       ((rax tmp.70 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.70 tmp-ra.98 rbp)
       ((rax tmp.79 tmp.70 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.80 tmp.70 tmp-ra.98 rbp)
       ((rax tmp.70 tmp-ra.98 rbp)
        ((tmp.79 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.70 tmp-ra.98 rbp)
       ((rax tmp.78 tmp.70 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.82 tmp.78 tmp.70 tmp-ra.98 rbp)
       ((rax tmp.82 tmp.78 tmp.70 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.82 tmp.83 tmp.78 tmp.70 tmp-ra.98 rbp)
       ((rax tmp.78 tmp.70 tmp-ra.98 rbp)
        ((tmp.82 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.81 tmp.70 tmp-ra.98 rbp)
       ((rax tmp.70 tmp-ra.98 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.77 tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.84 tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp) ((r15 rbp) (r15 rbp)))
       (empty4.2 tmp-ra.98 rbp)
       ((rax empty4.2 tmp-ra.98 rbp) ((r15 rbp) (r15 rbp)))
       (empty4.2 tmp-ra.98 rbp)
       (tmp-ra.98 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.98
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
         rax
         rbp))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.98))
       (tmp.73 (rbp tmp-ra.98 tmp.72))
       (tmp.71 (rsi tmp.74 tmp.76 tmp.75 rax rbp tmp-ra.98))
       (tmp.75 (rsi tmp.76 rax rbp tmp-ra.98 tmp.71))
       (tmp.76 (rbp tmp-ra.98 tmp.71 tmp.75))
       (tmp.74 (rbp tmp-ra.98 tmp.71))
       (tmp.70
        (rsi
         tmp.77
         tmp.81
         tmp.83
         tmp.82
         tmp.78
         tmp.80
         tmp.79
         rax
         rbp
         tmp-ra.98))
       (tmp.79 (rsi tmp.80 rax rbp tmp-ra.98 tmp.70))
       (tmp.80 (rbp tmp-ra.98 tmp.70 tmp.79))
       (tmp.78 (rsi tmp.81 tmp.83 tmp.82 rax rbp tmp-ra.98 tmp.70))
       (tmp.82 (rsi tmp.83 rax rbp tmp-ra.98 tmp.70 tmp.78))
       (tmp.83 (rbp tmp-ra.98 tmp.70 tmp.78 tmp.82))
       (tmp.81 (rbp tmp-ra.98 tmp.70 tmp.78))
       (tmp.77 (rbp tmp-ra.98 tmp.70))
       (fixnum0.6 (rbp tmp-ra.98))
       (tmp.84 (rbp tmp-ra.98))
       (boolean1.5 (rbp tmp-ra.98))
       (void2.4 (rbp tmp-ra.98))
       (ascii-char3.3 (rbp tmp-ra.98))
       (empty4.2 (void5.1 rax rbp tmp-ra.98))
       (void5.1 (rbp tmp-ra.98 empty4.2))
       (rbp
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
         r15
         rdi
         rsi
         rax
         tmp-ra.98))
       (rax
        (empty4.2
         tmp.82
         tmp.78
         tmp.79
         tmp.70
         tmp.75
         tmp.71
         tmp.72
         rbp
         tmp-ra.98))
       (rsi (tmp.70 tmp.78 tmp.82 tmp.79 tmp.71 tmp.75 tmp.72 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
    (define L.boolean?.17
      ((new-frames ())
       (locals (tmp-ra.85 tmp.99 tmp.44 tmp.56))
       (undead-out
        ((rdi tmp-ra.85 rbp)
         (tmp.44 tmp-ra.85 rbp)
         ((((tmp.99 tmp-ra.85 rbp)
            (tmp.99 tmp-ra.85 rbp)
            (tmp.56 tmp-ra.85 rbp))
           (tmp-ra.85 rbp))
          ((tmp-ra.85 rax rbp) (rax rbp))
          ((tmp-ra.85 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.85))
         (tmp.44 (rbp tmp-ra.85))
         (tmp.99 (rbp tmp-ra.85))
         (tmp-ra.85 (tmp.44 rbp rdi tmp.99 tmp.56 rax))
         (rax (rbp tmp-ra.85))
         (rbp (tmp.44 tmp-ra.85 tmp.99 tmp.56 rax))
         (rdi (tmp-ra.85)))))
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
         tmp.57))
       (undead-out
        ((rdi rsi tmp-ra.86 rbp)
         (rsi tmp.24 tmp-ra.86 rbp)
         (tmp.24 tmp.25 tmp-ra.86 rbp)
         ((((((tmp.100 tmp.24 tmp.25 tmp-ra.86 rbp)
              (tmp.100 tmp.24 tmp.25 tmp-ra.86 rbp)
              (tmp.58 tmp.24 tmp.25 tmp-ra.86 rbp))
             (tmp.24 tmp.25 tmp-ra.86 rbp))
            (tmp.57 tmp.24 tmp.25 tmp-ra.86 rbp)
            (tmp.57 tmp.24 tmp.25 tmp-ra.86 rbp))
           (tmp.24 tmp.25 tmp-ra.86 rbp))
          ((((((tmp.101 tmp.24 tmp.25 tmp-ra.86 rbp)
               (tmp.101 tmp.24 tmp.25 tmp-ra.86 rbp)
               (tmp.60 tmp.24 tmp.25 tmp-ra.86 rbp))
              (tmp.24 tmp.25 tmp-ra.86 rbp))
             (tmp.59 tmp.24 tmp.25 tmp-ra.86 rbp)
             (tmp.59 tmp.24 tmp.25 tmp-ra.86 rbp))
            (tmp.24 tmp.25 tmp-ra.86 rbp))
           ((tmp.25 tmp.102 tmp-ra.86 rbp)
            (tmp.102 tmp-ra.86 rbp)
            (tmp-ra.86 rax rbp)
            (rax rbp))
           ((tmp-ra.86 rax rbp) (rax rbp)))
          ((tmp-ra.86 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.86 tmp.25 tmp.24))
         (tmp.100 (tmp.25 rbp tmp-ra.86 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.86
           tmp.24
           tmp.100
           tmp.58
           tmp.57
           tmp.101
           tmp.60
           tmp.59
           tmp.102))
         (tmp.58 (rbp tmp-ra.86 tmp.25 tmp.24))
         (tmp-ra.86
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.100
           tmp.58
           tmp.57
           tmp.101
           tmp.60
           tmp.59
           tmp.102
           rax))
         (tmp.102 (rbp tmp-ra.86 tmp.25))
         (tmp.60 (rbp tmp-ra.86 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.86
           rsi
           tmp.100
           tmp.58
           tmp.57
           tmp.101
           tmp.60
           tmp.59))
         (tmp.101 (tmp.24 rbp tmp-ra.86 tmp.25))
         (tmp.59 (rbp tmp-ra.86 tmp.25 tmp.24))
         (rax (rbp tmp-ra.86))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.86
           tmp.100
           tmp.58
           tmp.57
           tmp.101
           tmp.60
           tmp.59
           tmp.102
           rax))
         (rdi (tmp-ra.86))
         (rsi (tmp.24 tmp-ra.86)))))
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
         tmp.61))
       (undead-out
        ((rdi rsi tmp-ra.87 rbp)
         (rsi tmp.20 tmp-ra.87 rbp)
         (tmp.21 tmp.20 tmp-ra.87 rbp)
         ((((((tmp.103 tmp.21 tmp.20 tmp-ra.87 rbp)
              (tmp.103 tmp.21 tmp.20 tmp-ra.87 rbp)
              (tmp.62 tmp.21 tmp.20 tmp-ra.87 rbp))
             (tmp.21 tmp.20 tmp-ra.87 rbp))
            (tmp.61 tmp.21 tmp.20 tmp-ra.87 rbp)
            (tmp.61 tmp.21 tmp.20 tmp-ra.87 rbp))
           (tmp.21 tmp.20 tmp-ra.87 rbp))
          ((((((tmp.104 tmp.21 tmp.20 tmp-ra.87 rbp)
               (tmp.104 tmp.21 tmp.20 tmp-ra.87 rbp)
               (tmp.64 tmp.21 tmp.20 tmp-ra.87 rbp))
              (tmp.21 tmp.20 tmp-ra.87 rbp))
             (tmp.63 tmp.21 tmp.20 tmp-ra.87 rbp)
             (tmp.63 tmp.21 tmp.20 tmp-ra.87 rbp))
            (tmp.21 tmp.20 tmp-ra.87 rbp))
           ((tmp.105 tmp.20 tmp-ra.87 rbp)
            (tmp.105 tmp.20 tmp-ra.87 rbp)
            (tmp.20 tmp.65 tmp-ra.87 rbp)
            (tmp.65 tmp.106 tmp-ra.87 rbp)
            (tmp.106 tmp-ra.87 rbp)
            (tmp-ra.87 rax rbp)
            (rax rbp))
           ((tmp-ra.87 rax rbp) (rax rbp)))
          ((tmp-ra.87 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.87 tmp.20 tmp.21))
         (tmp.103 (tmp.21 rbp tmp-ra.87 tmp.20))
         (tmp.21
          (rbp tmp-ra.87 tmp.20 tmp.103 tmp.62 tmp.61 tmp.104 tmp.64 tmp.63))
         (tmp.62 (rbp tmp-ra.87 tmp.20 tmp.21))
         (tmp-ra.87
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.103
           tmp.62
           tmp.61
           tmp.104
           tmp.64
           tmp.63
           tmp.106
           tmp.65
           tmp.105
           rax))
         (tmp.105 (rbp tmp-ra.87 tmp.20))
         (tmp.65 (tmp.106 rbp tmp-ra.87 tmp.20))
         (tmp.106 (rbp tmp-ra.87 tmp.65))
         (tmp.64 (rbp tmp-ra.87 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.87
           rsi
           tmp.103
           tmp.62
           tmp.61
           tmp.104
           tmp.64
           tmp.63
           tmp.65
           tmp.105))
         (tmp.104 (tmp.20 rbp tmp-ra.87 tmp.21))
         (tmp.63 (rbp tmp-ra.87 tmp.20 tmp.21))
         (rax (rbp tmp-ra.87))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.87
           tmp.103
           tmp.62
           tmp.61
           tmp.104
           tmp.64
           tmp.63
           tmp.106
           tmp.65
           tmp.105
           rax))
         (rdi (tmp-ra.87))
         (rsi (tmp.20 tmp-ra.87)))))
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
         tmp.66))
       (undead-out
        ((rdi rsi tmp-ra.88 rbp)
         (rsi tmp.22 tmp-ra.88 rbp)
         (tmp.22 tmp.23 tmp-ra.88 rbp)
         ((((((tmp.107 tmp.22 tmp.23 tmp-ra.88 rbp)
              (tmp.107 tmp.22 tmp.23 tmp-ra.88 rbp)
              (tmp.67 tmp.22 tmp.23 tmp-ra.88 rbp))
             (tmp.22 tmp.23 tmp-ra.88 rbp))
            (tmp.66 tmp.22 tmp.23 tmp-ra.88 rbp)
            (tmp.66 tmp.22 tmp.23 tmp-ra.88 rbp))
           (tmp.22 tmp.23 tmp-ra.88 rbp))
          ((((((tmp.108 tmp.22 tmp.23 tmp-ra.88 rbp)
               (tmp.108 tmp.22 tmp.23 tmp-ra.88 rbp)
               (tmp.69 tmp.22 tmp.23 tmp-ra.88 rbp))
              (tmp.22 tmp.23 tmp-ra.88 rbp))
             (tmp.68 tmp.22 tmp.23 tmp-ra.88 rbp)
             (tmp.68 tmp.22 tmp.23 tmp-ra.88 rbp))
            (tmp.22 tmp.23 tmp-ra.88 rbp))
           ((tmp.23 tmp.109 tmp-ra.88 rbp)
            (tmp.109 tmp-ra.88 rbp)
            (tmp-ra.88 rax rbp)
            (rax rbp))
           ((tmp-ra.88 rax rbp) (rax rbp)))
          ((tmp-ra.88 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.66 (rbp tmp-ra.88 tmp.23 tmp.22))
         (tmp.107 (tmp.23 rbp tmp-ra.88 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.88
           tmp.22
           tmp.107
           tmp.67
           tmp.66
           tmp.108
           tmp.69
           tmp.68
           tmp.109))
         (tmp.67 (rbp tmp-ra.88 tmp.23 tmp.22))
         (tmp-ra.88
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.107
           tmp.67
           tmp.66
           tmp.108
           tmp.69
           tmp.68
           tmp.109
           rax))
         (tmp.109 (rbp tmp-ra.88 tmp.23))
         (tmp.69 (rbp tmp-ra.88 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.88
           rsi
           tmp.107
           tmp.67
           tmp.66
           tmp.108
           tmp.69
           tmp.68))
         (tmp.108 (tmp.22 rbp tmp-ra.88 tmp.23))
         (tmp.68 (rbp tmp-ra.88 tmp.23 tmp.22))
         (rax (rbp tmp-ra.88))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.88
           tmp.107
           tmp.67
           tmp.66
           tmp.108
           tmp.69
           tmp.68
           tmp.109
           rax))
         (rdi (tmp-ra.88))
         (rsi (tmp.22 tmp-ra.88)))))
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
      ((new-frames ())
       (locals (tmp-ra.89))
       (undead-out ((tmp-ra.89 rbp) (tmp-ra.89 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89)))))
      (begin (set! tmp-ra.89 r15) (set! rax 30) (jump tmp-ra.89 rbp rax)))
    (define L.fun/empty101997.5
      ((new-frames ())
       (locals (tmp-ra.90))
       (undead-out ((tmp-ra.90 rbp) (tmp-ra.90 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.90 (rax rbp)) (rbp (rax tmp-ra.90)) (rax (rbp tmp-ra.90)))))
      (begin (set! tmp-ra.90 r15) (set! rax 22) (jump tmp-ra.90 rbp rax)))
    (define L.fun/ascii-char101994.6
      ((new-frames ())
       (locals (tmp-ra.91))
       (undead-out ((tmp-ra.91 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.91 (rbp)) (rbp (r15 tmp-ra.91)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/ascii-char101995.11 rbp r15)))
    (define L.fun/void101992.7
      ((new-frames ())
       (locals (tmp-ra.92))
       (undead-out ((tmp-ra.92 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/void101993.12 rbp r15)))
    (define L.fun/void101998.8
      ((new-frames ())
       (locals (tmp-ra.93))
       (undead-out ((tmp-ra.93 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void101999.4 rbp r15)))
    (define L.fun/empty101996.9
      ((new-frames ())
       (locals (tmp-ra.94))
       (undead-out ((tmp-ra.94 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/empty101997.5 rbp r15)))
    (define L.fun/any101991.10
      ((new-frames ())
       (locals (tmp-ra.95))
       (undead-out ((tmp-ra.95 rbp) (tmp-ra.95 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95)))))
      (begin (set! tmp-ra.95 r15) (set! rax 30) (jump tmp-ra.95 rbp rax)))
    (define L.fun/ascii-char101995.11
      ((new-frames ())
       (locals (tmp-ra.96))
       (undead-out ((tmp-ra.96 rbp) (tmp-ra.96 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.96 (rax rbp)) (rbp (rax tmp-ra.96)) (rax (rbp tmp-ra.96)))))
      (begin (set! tmp-ra.96 r15) (set! rax 25390) (jump tmp-ra.96 rbp rax)))
    (define L.fun/void101993.12
      ((new-frames ())
       (locals (tmp-ra.97))
       (undead-out ((tmp-ra.97 rbp) (tmp-ra.97 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.97 (rax rbp)) (rbp (rax tmp-ra.97)) (rax (rbp tmp-ra.97)))))
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
     (locals (void5.1 void4.2 void3.3 empty2.4 error1.5 void0.6 tmp-ra.68))
     (call-undead (error1.5 tmp-ra.68))
     (undead-out
      ((tmp-ra.68 rbp)
       ((rax tmp-ra.68 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.68 rbp)
       ((rax tmp-ra.68 rbp) ((r15 rbp) (r15 rbp)))
       (error1.5 tmp-ra.68 rbp)
       ((rax error1.5 tmp-ra.68 rbp) ((r15 rbp) (r15 rbp)))
       (error1.5 tmp-ra.68 rbp)
       ((rax error1.5 tmp-ra.68 rbp) ((r15 rbp) (r15 rbp)))
       (error1.5 tmp-ra.68 rbp)
       ((rax error1.5 tmp-ra.68 rbp) ((r15 rbp) (r15 rbp)))
       (error1.5 tmp-ra.68 rbp)
       ((rax error1.5 tmp-ra.68 rbp) ((r15 rbp) (r15 rbp)))
       (error1.5 tmp-ra.68 rbp)
       (tmp-ra.68 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.68 (void5.1 void4.2 void3.3 empty2.4 error1.5 void0.6 rax rbp))
       (void0.6 (rbp tmp-ra.68))
       (error1.5 (void5.1 void4.2 void3.3 empty2.4 rax rbp tmp-ra.68))
       (empty2.4 (rbp tmp-ra.68 error1.5))
       (void3.3 (rbp tmp-ra.68 error1.5))
       (void4.2 (rbp tmp-ra.68 error1.5))
       (void5.1 (rbp tmp-ra.68 error1.5))
       (rbp
        (void5.1 void4.2 void3.3 empty2.4 error1.5 void0.6 r15 rax tmp-ra.68))
       (rax (error1.5 rbp tmp-ra.68))
       (r15 (rbp)))))
    (define L.fun/void102362.4
      ((new-frames ())
       (locals (tmp-ra.56))
       (undead-out ((tmp-ra.56 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.56 (rbp)) (rbp (r15 tmp-ra.56)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.56 r15)
        (set! r15 tmp-ra.56)
        (jump L.fun/void102363.9 rbp r15)))
    (define L.fun/empty102356.5
      ((new-frames ())
       (locals (tmp-ra.57))
       (undead-out ((tmp-ra.57 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.57 (rbp)) (rbp (r15 tmp-ra.57)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.57 r15)
        (set! r15 tmp-ra.57)
        (jump L.fun/empty102357.12 rbp r15)))
    (define L.fun/error102354.6
      ((new-frames ())
       (locals (tmp-ra.58))
       (undead-out ((tmp-ra.58 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.58 (rbp)) (rbp (r15 tmp-ra.58)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.58 r15)
        (set! r15 tmp-ra.58)
        (jump L.fun/error102355.10 rbp r15)))
    (define L.fun/void102358.7
      ((new-frames ())
       (locals (tmp-ra.59))
       (undead-out ((tmp-ra.59 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.59 (rbp)) (rbp (r15 tmp-ra.59)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.59 r15)
        (set! r15 tmp-ra.59)
        (jump L.fun/void102359.13 rbp r15)))
    (define L.fun/void102353.8
      ((new-frames ())
       (locals (tmp-ra.60))
       (undead-out ((tmp-ra.60 rbp) (tmp-ra.60 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60)))))
      (begin (set! tmp-ra.60 r15) (set! rax 30) (jump tmp-ra.60 rbp rax)))
    (define L.fun/void102363.9
      ((new-frames ())
       (locals (tmp-ra.61))
       (undead-out ((tmp-ra.61 rbp) (tmp-ra.61 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61)))))
      (begin (set! tmp-ra.61 r15) (set! rax 30) (jump tmp-ra.61 rbp rax)))
    (define L.fun/error102355.10
      ((new-frames ())
       (locals (tmp-ra.62))
       (undead-out ((tmp-ra.62 rbp) (tmp-ra.62 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.62 (rax rbp)) (rbp (rax tmp-ra.62)) (rax (rbp tmp-ra.62)))))
      (begin (set! tmp-ra.62 r15) (set! rax 37694) (jump tmp-ra.62 rbp rax)))
    (define L.fun/void102352.11
      ((new-frames ())
       (locals (tmp-ra.63))
       (undead-out ((tmp-ra.63 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.63 (rbp)) (rbp (r15 tmp-ra.63)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/void102353.8 rbp r15)))
    (define L.fun/empty102357.12
      ((new-frames ())
       (locals (tmp-ra.64))
       (undead-out ((tmp-ra.64 rbp) (tmp-ra.64 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.64 (rax rbp)) (rbp (rax tmp-ra.64)) (rax (rbp tmp-ra.64)))))
      (begin (set! tmp-ra.64 r15) (set! rax 22) (jump tmp-ra.64 rbp rax)))
    (define L.fun/void102359.13
      ((new-frames ())
       (locals (tmp-ra.65))
       (undead-out ((tmp-ra.65 rbp) (tmp-ra.65 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.65 (rax rbp)) (rbp (rax tmp-ra.65)) (rax (rbp tmp-ra.65)))))
      (begin (set! tmp-ra.65 r15) (set! rax 30) (jump tmp-ra.65 rbp rax)))
    (define L.fun/void102360.14
      ((new-frames ())
       (locals (tmp-ra.66))
       (undead-out ((tmp-ra.66 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.66 (rbp)) (rbp (r15 tmp-ra.66)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.66 r15)
        (set! r15 tmp-ra.66)
        (jump L.fun/void102361.15 rbp r15)))
    (define L.fun/void102361.15
      ((new-frames ())
       (locals (tmp-ra.67))
       (undead-out ((tmp-ra.67 rbp) (tmp-ra.67 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.67 (rax rbp)) (rbp (rax tmp-ra.67)) (rax (rbp tmp-ra.67)))))
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
       tmp-ra.100))
     (call-undead
      (tmp.76 tmp.80 tmp.79 tmp.83 tmp.71 tmp.72 tmp.73 tmp-ra.100))
     (undead-out
      ((tmp-ra.100 rbp)
       ((rax tmp-ra.100 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.70 tmp-ra.100 rbp)
       ((rax tmp-ra.100 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp-ra.100 rbp)
       ((rax tmp-ra.100 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.100 rbp)
       ((rax tmp-ra.100 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.73 tmp-ra.100 rbp)
       ((rax tmp.73 tmp-ra.100 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.73 tmp.74 tmp-ra.100 rbp)
       ((rax tmp-ra.100 rbp)
        ((tmp.73 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp-ra.100 rbp)
       ((rax tmp.72 tmp-ra.100 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.76 tmp.72 tmp-ra.100 rbp)
       ((rax tmp.76 tmp.72 tmp-ra.100 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.76 tmp.77 tmp.72 tmp-ra.100 rbp)
       ((rax tmp.72 tmp-ra.100 rbp)
        ((tmp.76 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.75 tmp-ra.100 rbp)
       ((rax tmp-ra.100 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.100 rbp)
       ((rax tmp.71 tmp-ra.100 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.80 tmp.71 tmp-ra.100 rbp)
       ((rax tmp.80 tmp.71 tmp-ra.100 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.80 tmp.81 tmp.71 tmp-ra.100 rbp)
       ((rax tmp.71 tmp-ra.100 rbp)
        ((tmp.80 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.71 tmp-ra.100 rbp)
       ((rax tmp.79 tmp.71 tmp-ra.100 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.83 tmp.79 tmp.71 tmp-ra.100 rbp)
       ((rax tmp.83 tmp.79 tmp.71 tmp-ra.100 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.83 tmp.84 tmp.79 tmp.71 tmp-ra.100 rbp)
       ((rax tmp.79 tmp.71 tmp-ra.100 rbp)
        ((tmp.83 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.82 tmp.71 tmp-ra.100 rbp)
       ((rax tmp.71 tmp-ra.100 rbp)
        ((tmp.79 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.78 tmp-ra.100 rbp)
       ((rax tmp-ra.100 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.100 rbp)
       ((rax tmp-ra.100 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.100 rbp)
       ((rax tmp-ra.100 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.100 rbp)
       ((rax tmp-ra.100 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.100 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.100
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
         rax
         rbp))
       (tmp.70 (rbp tmp-ra.100))
       (boolean0.6 (rbp tmp-ra.100))
       (empty1.5 (rbp tmp-ra.100))
       (tmp.73 (rsi tmp.74 rax rbp tmp-ra.100))
       (tmp.74 (rbp tmp-ra.100 tmp.73))
       (tmp.72 (rsi tmp.75 tmp.77 tmp.76 rax rbp tmp-ra.100))
       (tmp.76 (rsi tmp.77 rax rbp tmp-ra.100 tmp.72))
       (tmp.77 (rbp tmp-ra.100 tmp.72 tmp.76))
       (tmp.75 (rbp tmp-ra.100 tmp.72))
       (tmp.71
        (rsi
         tmp.78
         tmp.82
         tmp.84
         tmp.83
         tmp.79
         tmp.81
         tmp.80
         rax
         rbp
         tmp-ra.100))
       (tmp.80 (rsi tmp.81 rax rbp tmp-ra.100 tmp.71))
       (tmp.81 (rbp tmp-ra.100 tmp.71 tmp.80))
       (tmp.79 (rsi tmp.82 tmp.84 tmp.83 rax rbp tmp-ra.100 tmp.71))
       (tmp.83 (rsi tmp.84 rax rbp tmp-ra.100 tmp.71 tmp.79))
       (tmp.84 (rbp tmp-ra.100 tmp.71 tmp.79 tmp.83))
       (tmp.82 (rbp tmp-ra.100 tmp.71 tmp.79))
       (tmp.78 (rbp tmp-ra.100 tmp.71))
       (fixnum2.4 (rbp tmp-ra.100))
       (ascii-char3.3 (rbp tmp-ra.100))
       (ascii-char4.2 (rbp tmp-ra.100))
       (void5.1 (rbp tmp-ra.100))
       (rbp
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
         rsi
         empty1.5
         boolean0.6
         rdi
         tmp.70
         r15
         rax
         tmp-ra.100))
       (rax (tmp.83 tmp.79 tmp.80 tmp.71 tmp.76 tmp.72 tmp.73 rbp tmp-ra.100))
       (r15 (rsi rdi rbp))
       (rdi (rsi r15 rbp))
       (rsi (tmp.71 tmp.79 tmp.83 tmp.80 tmp.72 tmp.76 tmp.73 r15 rdi rbp)))))
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
         tmp.56))
       (undead-out
        ((rdi rsi tmp-ra.85 rbp)
         (rsi tmp.22 tmp-ra.85 rbp)
         (tmp.22 tmp.23 tmp-ra.85 rbp)
         ((((((tmp.101 tmp.22 tmp.23 tmp-ra.85 rbp)
              (tmp.101 tmp.22 tmp.23 tmp-ra.85 rbp)
              (tmp.57 tmp.22 tmp.23 tmp-ra.85 rbp))
             (tmp.22 tmp.23 tmp-ra.85 rbp))
            (tmp.56 tmp.22 tmp.23 tmp-ra.85 rbp)
            (tmp.56 tmp.22 tmp.23 tmp-ra.85 rbp))
           (tmp.22 tmp.23 tmp-ra.85 rbp))
          ((((((tmp.102 tmp.22 tmp.23 tmp-ra.85 rbp)
               (tmp.102 tmp.22 tmp.23 tmp-ra.85 rbp)
               (tmp.59 tmp.22 tmp.23 tmp-ra.85 rbp))
              (tmp.22 tmp.23 tmp-ra.85 rbp))
             (tmp.58 tmp.22 tmp.23 tmp-ra.85 rbp)
             (tmp.58 tmp.22 tmp.23 tmp-ra.85 rbp))
            (tmp.22 tmp.23 tmp-ra.85 rbp))
           ((tmp.23 tmp.103 tmp-ra.85 rbp)
            (tmp.103 tmp-ra.85 rbp)
            (tmp-ra.85 rax rbp)
            (rax rbp))
           ((tmp-ra.85 rax rbp) (rax rbp)))
          ((tmp-ra.85 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp.101 (tmp.23 rbp tmp-ra.85 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.85
           tmp.22
           tmp.101
           tmp.57
           tmp.56
           tmp.102
           tmp.59
           tmp.58
           tmp.103))
         (tmp.57 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp-ra.85
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.101
           tmp.57
           tmp.56
           tmp.102
           tmp.59
           tmp.58
           tmp.103
           rax))
         (tmp.103 (rbp tmp-ra.85 tmp.23))
         (tmp.59 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.85
           rsi
           tmp.101
           tmp.57
           tmp.56
           tmp.102
           tmp.59
           tmp.58))
         (tmp.102 (tmp.22 rbp tmp-ra.85 tmp.23))
         (tmp.58 (rbp tmp-ra.85 tmp.23 tmp.22))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.85
           tmp.101
           tmp.57
           tmp.56
           tmp.102
           tmp.59
           tmp.58
           tmp.103
           rax))
         (rdi (tmp-ra.85))
         (rsi (tmp.22 tmp-ra.85)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.86 rbp)
         (rsi tmp.20 tmp-ra.86 rbp)
         (tmp.21 tmp.20 tmp-ra.86 rbp)
         ((((((tmp.104 tmp.21 tmp.20 tmp-ra.86 rbp)
              (tmp.104 tmp.21 tmp.20 tmp-ra.86 rbp)
              (tmp.61 tmp.21 tmp.20 tmp-ra.86 rbp))
             (tmp.21 tmp.20 tmp-ra.86 rbp))
            (tmp.60 tmp.21 tmp.20 tmp-ra.86 rbp)
            (tmp.60 tmp.21 tmp.20 tmp-ra.86 rbp))
           (tmp.21 tmp.20 tmp-ra.86 rbp))
          ((((((tmp.105 tmp.21 tmp.20 tmp-ra.86 rbp)
               (tmp.105 tmp.21 tmp.20 tmp-ra.86 rbp)
               (tmp.63 tmp.21 tmp.20 tmp-ra.86 rbp))
              (tmp.21 tmp.20 tmp-ra.86 rbp))
             (tmp.62 tmp.21 tmp.20 tmp-ra.86 rbp)
             (tmp.62 tmp.21 tmp.20 tmp-ra.86 rbp))
            (tmp.21 tmp.20 tmp-ra.86 rbp))
           ((tmp.106 tmp.20 tmp-ra.86 rbp)
            (tmp.106 tmp.20 tmp-ra.86 rbp)
            (tmp.20 tmp.64 tmp-ra.86 rbp)
            (tmp.64 tmp.107 tmp-ra.86 rbp)
            (tmp.107 tmp-ra.86 rbp)
            (tmp-ra.86 rax rbp)
            (rax rbp))
           ((tmp-ra.86 rax rbp) (rax rbp)))
          ((tmp-ra.86 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.86 tmp.20 tmp.21))
         (tmp.104 (tmp.21 rbp tmp-ra.86 tmp.20))
         (tmp.21
          (rbp tmp-ra.86 tmp.20 tmp.104 tmp.61 tmp.60 tmp.105 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.86 tmp.20 tmp.21))
         (tmp-ra.86
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.104
           tmp.61
           tmp.60
           tmp.105
           tmp.63
           tmp.62
           tmp.107
           tmp.64
           tmp.106
           rax))
         (tmp.106 (rbp tmp-ra.86 tmp.20))
         (tmp.64 (tmp.107 rbp tmp-ra.86 tmp.20))
         (tmp.107 (rbp tmp-ra.86 tmp.64))
         (tmp.63 (rbp tmp-ra.86 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.86
           rsi
           tmp.104
           tmp.61
           tmp.60
           tmp.105
           tmp.63
           tmp.62
           tmp.64
           tmp.106))
         (tmp.105 (tmp.20 rbp tmp-ra.86 tmp.21))
         (tmp.62 (rbp tmp-ra.86 tmp.20 tmp.21))
         (rax (rbp tmp-ra.86))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.86
           tmp.104
           tmp.61
           tmp.60
           tmp.105
           tmp.63
           tmp.62
           tmp.107
           tmp.64
           tmp.106
           rax))
         (rdi (tmp-ra.86))
         (rsi (tmp.20 tmp-ra.86)))))
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
         tmp.65))
       (undead-out
        ((rdi rsi tmp-ra.87 rbp)
         (rsi tmp.24 tmp-ra.87 rbp)
         (tmp.24 tmp.25 tmp-ra.87 rbp)
         ((((((tmp.108 tmp.24 tmp.25 tmp-ra.87 rbp)
              (tmp.108 tmp.24 tmp.25 tmp-ra.87 rbp)
              (tmp.66 tmp.24 tmp.25 tmp-ra.87 rbp))
             (tmp.24 tmp.25 tmp-ra.87 rbp))
            (tmp.65 tmp.24 tmp.25 tmp-ra.87 rbp)
            (tmp.65 tmp.24 tmp.25 tmp-ra.87 rbp))
           (tmp.24 tmp.25 tmp-ra.87 rbp))
          ((((((tmp.109 tmp.24 tmp.25 tmp-ra.87 rbp)
               (tmp.109 tmp.24 tmp.25 tmp-ra.87 rbp)
               (tmp.68 tmp.24 tmp.25 tmp-ra.87 rbp))
              (tmp.24 tmp.25 tmp-ra.87 rbp))
             (tmp.67 tmp.24 tmp.25 tmp-ra.87 rbp)
             (tmp.67 tmp.24 tmp.25 tmp-ra.87 rbp))
            (tmp.24 tmp.25 tmp-ra.87 rbp))
           ((tmp.25 tmp.110 tmp-ra.87 rbp)
            (tmp.110 tmp-ra.87 rbp)
            (tmp-ra.87 rax rbp)
            (rax rbp))
           ((tmp-ra.87 rax rbp) (rax rbp)))
          ((tmp-ra.87 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.87 tmp.25 tmp.24))
         (tmp.108 (tmp.25 rbp tmp-ra.87 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.87
           tmp.24
           tmp.108
           tmp.66
           tmp.65
           tmp.109
           tmp.68
           tmp.67
           tmp.110))
         (tmp.66 (rbp tmp-ra.87 tmp.25 tmp.24))
         (tmp-ra.87
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.108
           tmp.66
           tmp.65
           tmp.109
           tmp.68
           tmp.67
           tmp.110
           rax))
         (tmp.110 (rbp tmp-ra.87 tmp.25))
         (tmp.68 (rbp tmp-ra.87 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.87
           rsi
           tmp.108
           tmp.66
           tmp.65
           tmp.109
           tmp.68
           tmp.67))
         (tmp.109 (tmp.24 rbp tmp-ra.87 tmp.25))
         (tmp.67 (rbp tmp-ra.87 tmp.25 tmp.24))
         (rax (rbp tmp-ra.87))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.87
           tmp.108
           tmp.66
           tmp.65
           tmp.109
           tmp.68
           tmp.67
           tmp.110
           rax))
         (rdi (tmp-ra.87))
         (rsi (tmp.24 tmp-ra.87)))))
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
      ((new-frames ())
       (locals (tmp-ra.88 tmp.111 tmp.44 tmp.69))
       (undead-out
        ((rdi tmp-ra.88 rbp)
         (tmp.44 tmp-ra.88 rbp)
         ((((tmp.111 tmp-ra.88 rbp)
            (tmp.111 tmp-ra.88 rbp)
            (tmp.69 tmp-ra.88 rbp))
           (tmp-ra.88 rbp))
          ((tmp-ra.88 rax rbp) (rax rbp))
          ((tmp-ra.88 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.69 (rbp tmp-ra.88))
         (tmp.44 (rbp tmp-ra.88))
         (tmp.111 (rbp tmp-ra.88))
         (tmp-ra.88 (tmp.44 rbp rdi tmp.111 tmp.69 rax))
         (rax (rbp tmp-ra.88))
         (rbp (tmp.44 tmp-ra.88 tmp.111 tmp.69 rax))
         (rdi (tmp-ra.88)))))
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
      ((new-frames ())
       (locals (tmp-ra.89))
       (undead-out ((tmp-ra.89 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.89 (rbp)) (rbp (r15 tmp-ra.89)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/void122164.13 rbp r15)))
    (define L.fun/ascii-char122159.5
      ((new-frames ())
       (locals (tmp-ra.90))
       (undead-out ((tmp-ra.90 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.90 (rbp)) (rbp (r15 tmp-ra.90)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/ascii-char122160.6 rbp r15)))
    (define L.fun/ascii-char122160.6
      ((new-frames ())
       (locals (tmp-ra.91))
       (undead-out ((tmp-ra.91 rbp) (tmp-ra.91 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.91 (rax rbp)) (rbp (rax tmp-ra.91)) (rax (rbp tmp-ra.91)))))
      (begin (set! tmp-ra.91 r15) (set! rax 25390) (jump tmp-ra.91 rbp rax)))
    (define L.fun/ascii-char122162.7
      ((new-frames ())
       (locals (tmp-ra.92))
       (undead-out ((tmp-ra.92 rbp) (tmp-ra.92 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.92 (rax rbp)) (rbp (rax tmp-ra.92)) (rax (rbp tmp-ra.92)))))
      (begin (set! tmp-ra.92 r15) (set! rax 25390) (jump tmp-ra.92 rbp rax)))
    (define L.fun/empty122158.8
      ((new-frames ())
       (locals (tmp-ra.93))
       (undead-out ((tmp-ra.93 rbp) (tmp-ra.93 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93)))))
      (begin (set! tmp-ra.93 r15) (set! rax 22) (jump tmp-ra.93 rbp rax)))
    (define L.fun/error122165.9
      ((new-frames ())
       (locals (tmp-ra.94))
       (undead-out ((tmp-ra.94 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error122166.10 rbp r15)))
    (define L.fun/error122166.10
      ((new-frames ())
       (locals (tmp-ra.95))
       (undead-out ((tmp-ra.95 rbp) (tmp-ra.95 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95)))))
      (begin (set! tmp-ra.95 r15) (set! rax 46910) (jump tmp-ra.95 rbp rax)))
    (define L.fun/any122156.11
      ((new-frames ())
       (locals (tmp-ra.96))
       (undead-out ((tmp-ra.96 rbp) (tmp-ra.96 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.96 (rax rbp)) (rbp (rax tmp-ra.96)) (rax (rbp tmp-ra.96)))))
      (begin (set! tmp-ra.96 r15) (set! rax 22) (jump tmp-ra.96 rbp rax)))
    (define L.fun/empty122157.12
      ((new-frames ())
       (locals (tmp-ra.97))
       (undead-out ((tmp-ra.97 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.97 (rbp)) (rbp (r15 tmp-ra.97)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/empty122158.8 rbp r15)))
    (define L.fun/void122164.13
      ((new-frames ())
       (locals (tmp-ra.98))
       (undead-out ((tmp-ra.98 rbp) (tmp-ra.98 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.98 (rax rbp)) (rbp (rax tmp-ra.98)) (rax (rbp tmp-ra.98)))))
      (begin (set! tmp-ra.98 r15) (set! rax 30) (jump tmp-ra.98 rbp rax)))
    (define L.fun/ascii-char122161.14
      ((new-frames ())
       (locals (tmp-ra.99))
       (undead-out ((tmp-ra.99 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.99 (rbp)) (rbp (r15 tmp-ra.99)) (r15 (rbp)))))
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
       tmp-ra.98))
     (call-undead (tmp.74 tmp.78 tmp.77 tmp.81 tmp.69 tmp.70 tmp.71 tmp-ra.98))
     (undead-out
      ((tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.98 rbp)
       ((rax tmp.71 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.72 tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp-ra.98 rbp)
       ((rax tmp.70 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.70 tmp-ra.98 rbp)
       ((rax tmp.74 tmp.70 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.75 tmp.70 tmp-ra.98 rbp)
       ((rax tmp.70 tmp-ra.98 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.73 tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.98 rbp)
       ((rax tmp.69 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.69 tmp-ra.98 rbp)
       ((rax tmp.78 tmp.69 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.79 tmp.69 tmp-ra.98 rbp)
       ((rax tmp.69 tmp-ra.98 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.69 tmp-ra.98 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.77 tmp.69 tmp-ra.98 rbp)
       ((rax tmp.81 tmp.77 tmp.69 tmp-ra.98 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.82 tmp.77 tmp.69 tmp-ra.98 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.98 rbp)
        ((tmp.81 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.80 tmp.69 tmp-ra.98 rbp)
       ((rax tmp.69 tmp-ra.98 rbp)
        ((tmp.77 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.76 tmp-ra.98 rbp)
       ((rax tmp-ra.98 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.98 rbp)
       (r15 rbp)
       (r15 rbp)))
     (conflicts
      ((tmp-ra.98
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
         rax
         rbp))
       (error0.6 (rbp tmp-ra.98))
       (ascii-char1.5 (rbp tmp-ra.98))
       (error2.4 (rbp tmp-ra.98))
       (ascii-char3.3 (rbp tmp-ra.98))
       (error4.2 (rbp tmp-ra.98))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.98))
       (tmp.72 (rbp tmp-ra.98 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.98))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.98 tmp.70))
       (tmp.75 (rbp tmp-ra.98 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.98 tmp.70))
       (tmp.69
        (rsi
         tmp.76
         tmp.80
         tmp.82
         tmp.81
         tmp.77
         tmp.79
         tmp.78
         rax
         rbp
         tmp-ra.98))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.98 tmp.69))
       (tmp.79 (rbp tmp-ra.98 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.98 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.98 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.98 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.98 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.98 tmp.69))
       (fixnum5.1 (rbp tmp-ra.98))
       (rbp
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
         rdi
         rsi
         error4.2
         ascii-char3.3
         error2.4
         ascii-char1.5
         error0.6
         r15
         rax
         tmp-ra.98))
       (rax (tmp.81 tmp.77 tmp.78 tmp.69 tmp.74 tmp.70 tmp.71 rbp tmp-ra.98))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi)))))
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
         tmp.56))
       (undead-out
        ((rdi rsi tmp-ra.83 rbp)
         (rsi tmp.24 tmp-ra.83 rbp)
         (tmp.24 tmp.25 tmp-ra.83 rbp)
         ((((((tmp.99 tmp.24 tmp.25 tmp-ra.83 rbp)
              (tmp.99 tmp.24 tmp.25 tmp-ra.83 rbp)
              (tmp.57 tmp.24 tmp.25 tmp-ra.83 rbp))
             (tmp.24 tmp.25 tmp-ra.83 rbp))
            (tmp.56 tmp.24 tmp.25 tmp-ra.83 rbp)
            (tmp.56 tmp.24 tmp.25 tmp-ra.83 rbp))
           (tmp.24 tmp.25 tmp-ra.83 rbp))
          ((((((tmp.100 tmp.24 tmp.25 tmp-ra.83 rbp)
               (tmp.100 tmp.24 tmp.25 tmp-ra.83 rbp)
               (tmp.59 tmp.24 tmp.25 tmp-ra.83 rbp))
              (tmp.24 tmp.25 tmp-ra.83 rbp))
             (tmp.58 tmp.24 tmp.25 tmp-ra.83 rbp)
             (tmp.58 tmp.24 tmp.25 tmp-ra.83 rbp))
            (tmp.24 tmp.25 tmp-ra.83 rbp))
           ((tmp.25 tmp.101 tmp-ra.83 rbp)
            (tmp.101 tmp-ra.83 rbp)
            (tmp-ra.83 rax rbp)
            (rax rbp))
           ((tmp-ra.83 rax rbp) (rax rbp)))
          ((tmp-ra.83 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.83 tmp.25 tmp.24))
         (tmp.99 (tmp.25 rbp tmp-ra.83 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.83
           tmp.24
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58
           tmp.101))
         (tmp.57 (rbp tmp-ra.83 tmp.25 tmp.24))
         (tmp-ra.83
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58
           tmp.101
           rax))
         (tmp.101 (rbp tmp-ra.83 tmp.25))
         (tmp.59 (rbp tmp-ra.83 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.83
           rsi
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58))
         (tmp.100 (tmp.24 rbp tmp-ra.83 tmp.25))
         (tmp.58 (rbp tmp-ra.83 tmp.25 tmp.24))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.83
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58
           tmp.101
           rax))
         (rdi (tmp-ra.83))
         (rsi (tmp.24 tmp-ra.83)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.84 rbp)
         (rsi tmp.20 tmp-ra.84 rbp)
         (tmp.21 tmp.20 tmp-ra.84 rbp)
         ((((((tmp.102 tmp.21 tmp.20 tmp-ra.84 rbp)
              (tmp.102 tmp.21 tmp.20 tmp-ra.84 rbp)
              (tmp.61 tmp.21 tmp.20 tmp-ra.84 rbp))
             (tmp.21 tmp.20 tmp-ra.84 rbp))
            (tmp.60 tmp.21 tmp.20 tmp-ra.84 rbp)
            (tmp.60 tmp.21 tmp.20 tmp-ra.84 rbp))
           (tmp.21 tmp.20 tmp-ra.84 rbp))
          ((((((tmp.103 tmp.21 tmp.20 tmp-ra.84 rbp)
               (tmp.103 tmp.21 tmp.20 tmp-ra.84 rbp)
               (tmp.63 tmp.21 tmp.20 tmp-ra.84 rbp))
              (tmp.21 tmp.20 tmp-ra.84 rbp))
             (tmp.62 tmp.21 tmp.20 tmp-ra.84 rbp)
             (tmp.62 tmp.21 tmp.20 tmp-ra.84 rbp))
            (tmp.21 tmp.20 tmp-ra.84 rbp))
           ((tmp.104 tmp.20 tmp-ra.84 rbp)
            (tmp.104 tmp.20 tmp-ra.84 rbp)
            (tmp.20 tmp.64 tmp-ra.84 rbp)
            (tmp.64 tmp.105 tmp-ra.84 rbp)
            (tmp.105 tmp-ra.84 rbp)
            (tmp-ra.84 rax rbp)
            (rax rbp))
           ((tmp-ra.84 rax rbp) (rax rbp)))
          ((tmp-ra.84 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.84 tmp.20 tmp.21))
         (tmp.102 (tmp.21 rbp tmp-ra.84 tmp.20))
         (tmp.21
          (rbp tmp-ra.84 tmp.20 tmp.102 tmp.61 tmp.60 tmp.103 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.84 tmp.20 tmp.21))
         (tmp-ra.84
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.102
           tmp.61
           tmp.60
           tmp.103
           tmp.63
           tmp.62
           tmp.105
           tmp.64
           tmp.104
           rax))
         (tmp.104 (rbp tmp-ra.84 tmp.20))
         (tmp.64 (tmp.105 rbp tmp-ra.84 tmp.20))
         (tmp.105 (rbp tmp-ra.84 tmp.64))
         (tmp.63 (rbp tmp-ra.84 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.84
           rsi
           tmp.102
           tmp.61
           tmp.60
           tmp.103
           tmp.63
           tmp.62
           tmp.64
           tmp.104))
         (tmp.103 (tmp.20 rbp tmp-ra.84 tmp.21))
         (tmp.62 (rbp tmp-ra.84 tmp.20 tmp.21))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.84
           tmp.102
           tmp.61
           tmp.60
           tmp.103
           tmp.63
           tmp.62
           tmp.105
           tmp.64
           tmp.104
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.20 tmp-ra.84)))))
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
         tmp.65))
       (undead-out
        ((rdi rsi tmp-ra.85 rbp)
         (rsi tmp.22 tmp-ra.85 rbp)
         (tmp.22 tmp.23 tmp-ra.85 rbp)
         ((((((tmp.106 tmp.22 tmp.23 tmp-ra.85 rbp)
              (tmp.106 tmp.22 tmp.23 tmp-ra.85 rbp)
              (tmp.66 tmp.22 tmp.23 tmp-ra.85 rbp))
             (tmp.22 tmp.23 tmp-ra.85 rbp))
            (tmp.65 tmp.22 tmp.23 tmp-ra.85 rbp)
            (tmp.65 tmp.22 tmp.23 tmp-ra.85 rbp))
           (tmp.22 tmp.23 tmp-ra.85 rbp))
          ((((((tmp.107 tmp.22 tmp.23 tmp-ra.85 rbp)
               (tmp.107 tmp.22 tmp.23 tmp-ra.85 rbp)
               (tmp.68 tmp.22 tmp.23 tmp-ra.85 rbp))
              (tmp.22 tmp.23 tmp-ra.85 rbp))
             (tmp.67 tmp.22 tmp.23 tmp-ra.85 rbp)
             (tmp.67 tmp.22 tmp.23 tmp-ra.85 rbp))
            (tmp.22 tmp.23 tmp-ra.85 rbp))
           ((tmp.23 tmp.108 tmp-ra.85 rbp)
            (tmp.108 tmp-ra.85 rbp)
            (tmp-ra.85 rax rbp)
            (rax rbp))
           ((tmp-ra.85 rax rbp) (rax rbp)))
          ((tmp-ra.85 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp.106 (tmp.23 rbp tmp-ra.85 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.85
           tmp.22
           tmp.106
           tmp.66
           tmp.65
           tmp.107
           tmp.68
           tmp.67
           tmp.108))
         (tmp.66 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp-ra.85
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.106
           tmp.66
           tmp.65
           tmp.107
           tmp.68
           tmp.67
           tmp.108
           rax))
         (tmp.108 (rbp tmp-ra.85 tmp.23))
         (tmp.68 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.85
           rsi
           tmp.106
           tmp.66
           tmp.65
           tmp.107
           tmp.68
           tmp.67))
         (tmp.107 (tmp.22 rbp tmp-ra.85 tmp.23))
         (tmp.67 (rbp tmp-ra.85 tmp.23 tmp.22))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.85
           tmp.106
           tmp.66
           tmp.65
           tmp.107
           tmp.68
           tmp.67
           tmp.108
           rax))
         (rdi (tmp-ra.85))
         (rsi (tmp.22 tmp-ra.85)))))
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
      ((new-frames ())
       (locals (tmp-ra.86))
       (undead-out ((tmp-ra.86 rbp) (tmp-ra.86 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86)))))
      (begin (set! tmp-ra.86 r15) (set! rax 30) (jump tmp-ra.86 rbp rax)))
    (define L.fun/ascii-char124211.5
      ((new-frames ())
       (locals (tmp-ra.87))
       (undead-out ((tmp-ra.87 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.87 (rbp)) (rbp (r15 tmp-ra.87)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/ascii-char124212.10 rbp r15)))
    (define L.fun/error124206.6
      ((new-frames ())
       (locals (tmp-ra.88))
       (undead-out ((tmp-ra.88 rbp) (tmp-ra.88 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.88 (rax rbp)) (rbp (rax tmp-ra.88)) (rax (rbp tmp-ra.88)))))
      (begin (set! tmp-ra.88 r15) (set! rax 8766) (jump tmp-ra.88 rbp rax)))
    (define L.fun/error124213.7
      ((new-frames ())
       (locals (tmp-ra.89))
       (undead-out ((tmp-ra.89 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.89 (rbp)) (rbp (r15 tmp-ra.89)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/error124214.11 rbp r15)))
    (define L.fun/ascii-char124207.8
      ((new-frames ())
       (locals (tmp-ra.90))
       (undead-out ((tmp-ra.90 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.90 (rbp)) (rbp (r15 tmp-ra.90)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/ascii-char124208.14 rbp r15)))
    (define L.fun/void124215.9
      ((new-frames ())
       (locals (tmp-ra.91))
       (undead-out ((tmp-ra.91 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.91 (rbp)) (rbp (r15 tmp-ra.91)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/void124216.4 rbp r15)))
    (define L.fun/ascii-char124212.10
      ((new-frames ())
       (locals (tmp-ra.92))
       (undead-out ((tmp-ra.92 rbp) (tmp-ra.92 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.92 (rax rbp)) (rbp (rax tmp-ra.92)) (rax (rbp tmp-ra.92)))))
      (begin (set! tmp-ra.92 r15) (set! rax 25390) (jump tmp-ra.92 rbp rax)))
    (define L.fun/error124214.11
      ((new-frames ())
       (locals (tmp-ra.93))
       (undead-out ((tmp-ra.93 rbp) (tmp-ra.93 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93)))))
      (begin (set! tmp-ra.93 r15) (set! rax 1598) (jump tmp-ra.93 rbp rax)))
    (define L.fun/error124209.12
      ((new-frames ())
       (locals (tmp-ra.94))
       (undead-out ((tmp-ra.94 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error124210.13 rbp r15)))
    (define L.fun/error124210.13
      ((new-frames ())
       (locals (tmp-ra.95))
       (undead-out ((tmp-ra.95 rbp) (tmp-ra.95 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95)))))
      (begin (set! tmp-ra.95 r15) (set! rax 830) (jump tmp-ra.95 rbp rax)))
    (define L.fun/ascii-char124208.14
      ((new-frames ())
       (locals (tmp-ra.96))
       (undead-out ((tmp-ra.96 rbp) (tmp-ra.96 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.96 (rax rbp)) (rbp (rax tmp-ra.96)) (rax (rbp tmp-ra.96)))))
      (begin (set! tmp-ra.96 r15) (set! rax 25390) (jump tmp-ra.96 rbp rax)))
    (define L.fun/error124205.15
      ((new-frames ())
       (locals (tmp-ra.97))
       (undead-out ((tmp-ra.97 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.97 (rbp)) (rbp (r15 tmp-ra.97)) (r15 (rbp)))))
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
       tmp-ra.102))
     (call-undead
      (tmp.76
       tmp.80
       tmp.79
       tmp.87
       fixnum2.4
       tmp.83
       tmp.71
       tmp.72
       tmp.73
       tmp-ra.102))
     (undead-out
      ((tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp) ((r15 rbp) (r15 rbp)))
       (tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp) ((r15 rbp) (r15 rbp)))
       (tmp.70 tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp) ((rdi rbp) (rdi r15 rbp) (rdi r15 rbp)))
       (tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.73 tmp-ra.102 rbp)
       ((rax tmp.73 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.73 tmp.74 tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp)
        ((tmp.73 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp-ra.102 rbp)
       ((rax tmp.72 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.76 tmp.72 tmp-ra.102 rbp)
       ((rax tmp.76 tmp.72 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.76 tmp.77 tmp.72 tmp-ra.102 rbp)
       ((rax tmp.72 tmp-ra.102 rbp)
        ((tmp.76 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.72 tmp.75 tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp)
        ((tmp.72 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.102 rbp)
       ((rax tmp.71 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.80 tmp.71 tmp-ra.102 rbp)
       ((rax tmp.80 tmp.71 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.80 tmp.81 tmp.71 tmp-ra.102 rbp)
       ((rax tmp.71 tmp-ra.102 rbp)
        ((tmp.80 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.71 tmp-ra.102 rbp)
       ((rax tmp.79 tmp.71 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.83 tmp.79 tmp.71 tmp-ra.102 rbp)
       ((rax tmp.83 tmp.79 tmp.71 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.83 tmp.84 tmp.79 tmp.71 tmp-ra.102 rbp)
       ((rax tmp.79 tmp.71 tmp-ra.102 rbp)
        ((tmp.83 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.79 tmp.82 tmp.71 tmp-ra.102 rbp)
       ((rax tmp.71 tmp-ra.102 rbp)
        ((tmp.79 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.78 tmp-ra.102 rbp)
       ((rax tmp-ra.102 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (fixnum2.4 tmp-ra.102 rbp)
       ((rax fixnum2.4 tmp-ra.102 rbp) ((r15 rbp) (r15 rbp)))
       (fixnum2.4 tmp-ra.102 rbp)
       ((rax fixnum2.4 tmp-ra.102 rbp) ((r15 rbp) (r15 rbp)))
       (fixnum2.4 tmp-ra.102 rbp)
       ((rax fixnum2.4 tmp-ra.102 rbp) ((r15 rbp) (r15 rbp)))
       (fixnum2.4 tmp-ra.102 rbp)
       ((rax fixnum2.4 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.87 fixnum2.4 tmp-ra.102 rbp)
       ((rax tmp.87 fixnum2.4 tmp-ra.102 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.87 tmp.88 fixnum2.4 tmp-ra.102 rbp)
       ((rax fixnum2.4 tmp-ra.102 rbp)
        ((tmp.87 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.86 fixnum2.4 tmp-ra.102 rbp)
       ((rax fixnum2.4 tmp-ra.102 rbp)
        ((fixnum2.4 rsi rbp)
         (rsi rdi rbp)
         (rsi rdi r15 rbp)
         (rsi rdi r15 rbp)))
       (tmp.85 fixnum2.4 tmp-ra.102 rbp)
       (fixnum2.4 tmp-ra.102 rsi rbp)
       (tmp-ra.102 rsi rdi rbp)
       (rsi rdi r15 rbp)
       (rsi rdi r15 rbp)))
     (conflicts
      ((tmp-ra.102
        (rdi
         rsi
         tmp.85
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
         rax
         rbp))
       (void0.6 (rbp tmp-ra.102))
       (tmp.70 (rbp tmp-ra.102))
       (boolean1.5 (rbp tmp-ra.102))
       (tmp.73 (rsi tmp.74 rax rbp tmp-ra.102))
       (tmp.74 (rbp tmp-ra.102 tmp.73))
       (tmp.72 (rsi tmp.75 tmp.77 tmp.76 rax rbp tmp-ra.102))
       (tmp.76 (rsi tmp.77 rax rbp tmp-ra.102 tmp.72))
       (tmp.77 (rbp tmp-ra.102 tmp.72 tmp.76))
       (tmp.75 (rbp tmp-ra.102 tmp.72))
       (tmp.71
        (rsi
         tmp.78
         tmp.82
         tmp.84
         tmp.83
         tmp.79
         tmp.81
         tmp.80
         rax
         rbp
         tmp-ra.102))
       (tmp.80 (rsi tmp.81 rax rbp tmp-ra.102 tmp.71))
       (tmp.81 (rbp tmp-ra.102 tmp.71 tmp.80))
       (tmp.79 (rsi tmp.82 tmp.84 tmp.83 rax rbp tmp-ra.102 tmp.71))
       (tmp.83 (rsi tmp.84 rax rbp tmp-ra.102 tmp.71 tmp.79))
       (tmp.84 (rbp tmp-ra.102 tmp.71 tmp.79 tmp.83))
       (tmp.82 (rbp tmp-ra.102 tmp.71 tmp.79))
       (tmp.78 (rbp tmp-ra.102 tmp.71))
       (fixnum2.4
        (tmp.85
         rsi
         tmp.86
         tmp.88
         tmp.87
         void5.1
         ascii-char4.2
         ascii-char3.3
         rax
         rbp
         tmp-ra.102))
       (ascii-char3.3 (rbp tmp-ra.102 fixnum2.4))
       (ascii-char4.2 (rbp tmp-ra.102 fixnum2.4))
       (void5.1 (rbp tmp-ra.102 fixnum2.4))
       (tmp.87 (rsi tmp.88 rax rbp tmp-ra.102 fixnum2.4))
       (tmp.88 (rbp tmp-ra.102 fixnum2.4 tmp.87))
       (tmp.86 (rbp tmp-ra.102 fixnum2.4))
       (tmp.85 (rbp tmp-ra.102 fixnum2.4))
       (rbp
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
         rsi
         boolean1.5
         rdi
         tmp.70
         void0.6
         r15
         rax
         tmp-ra.102))
       (rax
        (tmp.87
         fixnum2.4
         tmp.83
         tmp.79
         tmp.80
         tmp.71
         tmp.76
         tmp.72
         tmp.73
         rbp
         tmp-ra.102))
       (r15 (rsi rdi rbp))
       (rdi (tmp-ra.102 rsi r15 rbp))
       (rsi
        (tmp-ra.102
         fixnum2.4
         tmp.87
         tmp.71
         tmp.79
         tmp.83
         tmp.80
         tmp.72
         tmp.76
         tmp.73
         r15
         rdi
         rbp)))))
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
         tmp.56))
       (undead-out
        ((rdi rsi tmp-ra.89 rbp)
         (rsi tmp.22 tmp-ra.89 rbp)
         (tmp.22 tmp.23 tmp-ra.89 rbp)
         ((((((tmp.103 tmp.22 tmp.23 tmp-ra.89 rbp)
              (tmp.103 tmp.22 tmp.23 tmp-ra.89 rbp)
              (tmp.57 tmp.22 tmp.23 tmp-ra.89 rbp))
             (tmp.22 tmp.23 tmp-ra.89 rbp))
            (tmp.56 tmp.22 tmp.23 tmp-ra.89 rbp)
            (tmp.56 tmp.22 tmp.23 tmp-ra.89 rbp))
           (tmp.22 tmp.23 tmp-ra.89 rbp))
          ((((((tmp.104 tmp.22 tmp.23 tmp-ra.89 rbp)
               (tmp.104 tmp.22 tmp.23 tmp-ra.89 rbp)
               (tmp.59 tmp.22 tmp.23 tmp-ra.89 rbp))
              (tmp.22 tmp.23 tmp-ra.89 rbp))
             (tmp.58 tmp.22 tmp.23 tmp-ra.89 rbp)
             (tmp.58 tmp.22 tmp.23 tmp-ra.89 rbp))
            (tmp.22 tmp.23 tmp-ra.89 rbp))
           ((tmp.23 tmp.105 tmp-ra.89 rbp)
            (tmp.105 tmp-ra.89 rbp)
            (tmp-ra.89 rax rbp)
            (rax rbp))
           ((tmp-ra.89 rax rbp) (rax rbp)))
          ((tmp-ra.89 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.89 tmp.23 tmp.22))
         (tmp.103 (tmp.23 rbp tmp-ra.89 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.89
           tmp.22
           tmp.103
           tmp.57
           tmp.56
           tmp.104
           tmp.59
           tmp.58
           tmp.105))
         (tmp.57 (rbp tmp-ra.89 tmp.23 tmp.22))
         (tmp-ra.89
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.103
           tmp.57
           tmp.56
           tmp.104
           tmp.59
           tmp.58
           tmp.105
           rax))
         (tmp.105 (rbp tmp-ra.89 tmp.23))
         (tmp.59 (rbp tmp-ra.89 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.89
           rsi
           tmp.103
           tmp.57
           tmp.56
           tmp.104
           tmp.59
           tmp.58))
         (tmp.104 (tmp.22 rbp tmp-ra.89 tmp.23))
         (tmp.58 (rbp tmp-ra.89 tmp.23 tmp.22))
         (rax (rbp tmp-ra.89))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.89
           tmp.103
           tmp.57
           tmp.56
           tmp.104
           tmp.59
           tmp.58
           tmp.105
           rax))
         (rdi (tmp-ra.89))
         (rsi (tmp.22 tmp-ra.89)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.90 rbp)
         (rsi tmp.20 tmp-ra.90 rbp)
         (tmp.21 tmp.20 tmp-ra.90 rbp)
         ((((((tmp.106 tmp.21 tmp.20 tmp-ra.90 rbp)
              (tmp.106 tmp.21 tmp.20 tmp-ra.90 rbp)
              (tmp.61 tmp.21 tmp.20 tmp-ra.90 rbp))
             (tmp.21 tmp.20 tmp-ra.90 rbp))
            (tmp.60 tmp.21 tmp.20 tmp-ra.90 rbp)
            (tmp.60 tmp.21 tmp.20 tmp-ra.90 rbp))
           (tmp.21 tmp.20 tmp-ra.90 rbp))
          ((((((tmp.107 tmp.21 tmp.20 tmp-ra.90 rbp)
               (tmp.107 tmp.21 tmp.20 tmp-ra.90 rbp)
               (tmp.63 tmp.21 tmp.20 tmp-ra.90 rbp))
              (tmp.21 tmp.20 tmp-ra.90 rbp))
             (tmp.62 tmp.21 tmp.20 tmp-ra.90 rbp)
             (tmp.62 tmp.21 tmp.20 tmp-ra.90 rbp))
            (tmp.21 tmp.20 tmp-ra.90 rbp))
           ((tmp.108 tmp.20 tmp-ra.90 rbp)
            (tmp.108 tmp.20 tmp-ra.90 rbp)
            (tmp.20 tmp.64 tmp-ra.90 rbp)
            (tmp.64 tmp.109 tmp-ra.90 rbp)
            (tmp.109 tmp-ra.90 rbp)
            (tmp-ra.90 rax rbp)
            (rax rbp))
           ((tmp-ra.90 rax rbp) (rax rbp)))
          ((tmp-ra.90 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.90 tmp.20 tmp.21))
         (tmp.106 (tmp.21 rbp tmp-ra.90 tmp.20))
         (tmp.21
          (rbp tmp-ra.90 tmp.20 tmp.106 tmp.61 tmp.60 tmp.107 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.90 tmp.20 tmp.21))
         (tmp-ra.90
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.106
           tmp.61
           tmp.60
           tmp.107
           tmp.63
           tmp.62
           tmp.109
           tmp.64
           tmp.108
           rax))
         (tmp.108 (rbp tmp-ra.90 tmp.20))
         (tmp.64 (tmp.109 rbp tmp-ra.90 tmp.20))
         (tmp.109 (rbp tmp-ra.90 tmp.64))
         (tmp.63 (rbp tmp-ra.90 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.90
           rsi
           tmp.106
           tmp.61
           tmp.60
           tmp.107
           tmp.63
           tmp.62
           tmp.64
           tmp.108))
         (tmp.107 (tmp.20 rbp tmp-ra.90 tmp.21))
         (tmp.62 (rbp tmp-ra.90 tmp.20 tmp.21))
         (rax (rbp tmp-ra.90))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.90
           tmp.106
           tmp.61
           tmp.60
           tmp.107
           tmp.63
           tmp.62
           tmp.109
           tmp.64
           tmp.108
           rax))
         (rdi (tmp-ra.90))
         (rsi (tmp.20 tmp-ra.90)))))
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
         tmp.65))
       (undead-out
        ((rdi rsi tmp-ra.91 rbp)
         (rsi tmp.24 tmp-ra.91 rbp)
         (tmp.24 tmp.25 tmp-ra.91 rbp)
         ((((((tmp.110 tmp.24 tmp.25 tmp-ra.91 rbp)
              (tmp.110 tmp.24 tmp.25 tmp-ra.91 rbp)
              (tmp.66 tmp.24 tmp.25 tmp-ra.91 rbp))
             (tmp.24 tmp.25 tmp-ra.91 rbp))
            (tmp.65 tmp.24 tmp.25 tmp-ra.91 rbp)
            (tmp.65 tmp.24 tmp.25 tmp-ra.91 rbp))
           (tmp.24 tmp.25 tmp-ra.91 rbp))
          ((((((tmp.111 tmp.24 tmp.25 tmp-ra.91 rbp)
               (tmp.111 tmp.24 tmp.25 tmp-ra.91 rbp)
               (tmp.68 tmp.24 tmp.25 tmp-ra.91 rbp))
              (tmp.24 tmp.25 tmp-ra.91 rbp))
             (tmp.67 tmp.24 tmp.25 tmp-ra.91 rbp)
             (tmp.67 tmp.24 tmp.25 tmp-ra.91 rbp))
            (tmp.24 tmp.25 tmp-ra.91 rbp))
           ((tmp.25 tmp.112 tmp-ra.91 rbp)
            (tmp.112 tmp-ra.91 rbp)
            (tmp-ra.91 rax rbp)
            (rax rbp))
           ((tmp-ra.91 rax rbp) (rax rbp)))
          ((tmp-ra.91 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.91 tmp.25 tmp.24))
         (tmp.110 (tmp.25 rbp tmp-ra.91 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.91
           tmp.24
           tmp.110
           tmp.66
           tmp.65
           tmp.111
           tmp.68
           tmp.67
           tmp.112))
         (tmp.66 (rbp tmp-ra.91 tmp.25 tmp.24))
         (tmp-ra.91
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.110
           tmp.66
           tmp.65
           tmp.111
           tmp.68
           tmp.67
           tmp.112
           rax))
         (tmp.112 (rbp tmp-ra.91 tmp.25))
         (tmp.68 (rbp tmp-ra.91 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.91
           rsi
           tmp.110
           tmp.66
           tmp.65
           tmp.111
           tmp.68
           tmp.67))
         (tmp.111 (tmp.24 rbp tmp-ra.91 tmp.25))
         (tmp.67 (rbp tmp-ra.91 tmp.25 tmp.24))
         (rax (rbp tmp-ra.91))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.91
           tmp.110
           tmp.66
           tmp.65
           tmp.111
           tmp.68
           tmp.67
           tmp.112
           rax))
         (rdi (tmp-ra.91))
         (rsi (tmp.24 tmp-ra.91)))))
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
      ((new-frames ())
       (locals (tmp-ra.92 tmp.113 tmp.49 tmp.69))
       (undead-out
        ((rdi tmp-ra.92 rbp)
         (tmp.49 tmp-ra.92 rbp)
         ((((tmp.113 tmp-ra.92 rbp)
            (tmp.113 tmp-ra.92 rbp)
            (tmp.69 tmp-ra.92 rbp))
           (tmp-ra.92 rbp))
          ((tmp-ra.92 rax rbp) (rax rbp))
          ((tmp-ra.92 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.69 (rbp tmp-ra.92))
         (tmp.49 (rbp tmp-ra.92))
         (tmp.113 (rbp tmp-ra.92))
         (tmp-ra.92 (tmp.49 rbp rdi tmp.113 tmp.69 rax))
         (rax (rbp tmp-ra.92))
         (rbp (tmp.49 tmp-ra.92 tmp.113 tmp.69 rax))
         (rdi (tmp-ra.92)))))
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
      ((new-frames ())
       (locals (tmp-ra.93))
       (undead-out ((tmp-ra.93 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/ascii-char156383.11 rbp r15)))
    (define L.fun/void156379.5
      ((new-frames ())
       (locals (tmp-ra.94))
       (undead-out ((tmp-ra.94 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/void156380.6 rbp r15)))
    (define L.fun/void156380.6
      ((new-frames ())
       (locals (tmp-ra.95))
       (undead-out ((tmp-ra.95 rbp) (tmp-ra.95 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95)))))
      (begin (set! tmp-ra.95 r15) (set! rax 30) (jump tmp-ra.95 rbp rax)))
    (define L.fun/void156387.7
      ((new-frames ())
       (locals (tmp-ra.96))
       (undead-out ((tmp-ra.96 rbp) (tmp-ra.96 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.96 (rax rbp)) (rbp (rax tmp-ra.96)) (rax (rbp tmp-ra.96)))))
      (begin (set! tmp-ra.96 r15) (set! rax 30) (jump tmp-ra.96 rbp rax)))
    (define L.fun/any156381.8
      ((new-frames ())
       (locals (tmp-ra.97))
       (undead-out ((tmp-ra.97 rbp) (tmp-ra.97 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.97 (rax rbp)) (rbp (rax tmp-ra.97)) (rax (rbp tmp-ra.97)))))
      (begin (set! tmp-ra.97 r15) (set! rax 11326) (jump tmp-ra.97 rbp rax)))
    (define L.fun/void156386.9
      ((new-frames ())
       (locals (tmp-ra.98))
       (undead-out ((tmp-ra.98 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.98 (rbp)) (rbp (r15 tmp-ra.98)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/void156387.7 rbp r15)))
    (define L.fun/ascii-char156384.10
      ((new-frames ())
       (locals (tmp-ra.99))
       (undead-out ((tmp-ra.99 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.99 (rbp)) (rbp (r15 tmp-ra.99)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.99 r15)
        (set! r15 tmp-ra.99)
        (jump L.fun/ascii-char156385.12 rbp r15)))
    (define L.fun/ascii-char156383.11
      ((new-frames ())
       (locals (tmp-ra.100))
       (undead-out ((tmp-ra.100 rbp) (tmp-ra.100 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.100 (rax rbp))
         (rbp (rax tmp-ra.100))
         (rax (rbp tmp-ra.100)))))
      (begin (set! tmp-ra.100 r15) (set! rax 25390) (jump tmp-ra.100 rbp rax)))
    (define L.fun/ascii-char156385.12
      ((new-frames ())
       (locals (tmp-ra.101))
       (undead-out ((tmp-ra.101 rbp) (tmp-ra.101 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.101 (rax rbp))
         (rbp (rax tmp-ra.101))
         (rax (rbp tmp-ra.101)))))
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
       tmp-ra.108))
     (call-undead
      (tmp.71
       tmp.70
       tmp.69
       tmp.81
       tmp.88
       tmp.92
       tmp.91
       fixnum1.5
       tmp.95
       tmp.83
       tmp.84
       tmp.85
       tmp.77
       tmp.78
       tmp.74
       tmp-ra.108))
     (undead-out
      ((tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp-ra.108 rbp)
       ((rax tmp.71 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.71 tmp.72 tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((tmp.71 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp-ra.108 rbp)
       ((rax tmp.70 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.70 tmp-ra.108 rbp)
       ((rax tmp.74 tmp.70 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.74 tmp.75 tmp.70 tmp-ra.108 rbp)
       ((rax tmp.70 tmp-ra.108 rbp)
        ((tmp.74 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.70 tmp.73 tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((tmp.70 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp-ra.108 rbp)
       ((rax tmp.69 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.78 tmp.69 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.78 tmp.79 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.69 tmp-ra.108 rbp)
        ((tmp.78 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.77 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.81 tmp.77 tmp.69 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.81 tmp.82 tmp.77 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.77 tmp.69 tmp-ra.108 rbp)
        ((tmp.81 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.77 tmp.80 tmp.69 tmp-ra.108 rbp)
       ((rax tmp.69 tmp-ra.108 rbp)
        ((tmp.77 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.69 tmp.76 tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((tmp.69 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 tmp-ra.108 rbp)
       ((rax tmp.85 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.85 tmp.86 tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((tmp.85 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 tmp-ra.108 rbp)
       ((rax tmp.84 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.88 tmp.84 tmp-ra.108 rbp)
       ((rax tmp.88 tmp.84 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.88 tmp.89 tmp.84 tmp-ra.108 rbp)
       ((rax tmp.84 tmp-ra.108 rbp)
        ((tmp.88 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.84 tmp.87 tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((tmp.84 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.83 tmp-ra.108 rbp)
       ((rax tmp.83 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 tmp.83 tmp-ra.108 rbp)
       ((rax tmp.92 tmp.83 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.92 tmp.93 tmp.83 tmp-ra.108 rbp)
       ((rax tmp.83 tmp-ra.108 rbp)
        ((tmp.92 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.91 tmp.83 tmp-ra.108 rbp)
       ((rax tmp.91 tmp.83 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.95 tmp.91 tmp.83 tmp-ra.108 rbp)
       ((rax tmp.95 tmp.91 tmp.83 tmp-ra.108 rbp)
        ((rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.95 tmp.96 tmp.91 tmp.83 tmp-ra.108 rbp)
       ((rax tmp.91 tmp.83 tmp-ra.108 rbp)
        ((tmp.95 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.91 tmp.94 tmp.83 tmp-ra.108 rbp)
       ((rax tmp.83 tmp-ra.108 rbp)
        ((tmp.91 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (tmp.83 tmp.90 tmp-ra.108 rbp)
       ((rax tmp-ra.108 rbp)
        ((tmp.83 rsi rbp) (rsi rdi rbp) (rsi rdi r15 rbp) (rsi rdi r15 rbp)))
       (fixnum1.5 tmp-ra.108 rbp)
       ((rax fixnum1.5 tmp-ra.108 rbp) ((r15 rbp) (r15 rbp)))
       (fixnum1.5 tmp-ra.108 rbp)
       ((rax fixnum1.5 tmp-ra.108 rbp) ((r15 rbp) (r15 rbp)))
       (fixnum1.5 tmp-ra.108 rbp)
       ((rax fixnum1.5 tmp-ra.108 rbp) ((r15 rbp) (r15 rbp)))
       (fixnum1.5 tmp-ra.108 rbp)
       ((rax fixnum1.5 tmp-ra.108 rbp) ((r15 rbp) (r15 rbp)))
       (fixnum1.5 tmp-ra.108 rbp)
       (tmp-ra.108 rax rbp)
       (rax rbp)))
     (conflicts
      ((tmp-ra.108
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
         rax
         rbp))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.108))
       (tmp.72 (rbp tmp-ra.108 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.108))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.108 tmp.70))
       (tmp.75 (rbp tmp-ra.108 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.108 tmp.70))
       (tmp.69
        (rsi
         tmp.76
         tmp.80
         tmp.82
         tmp.81
         tmp.77
         tmp.79
         tmp.78
         rax
         rbp
         tmp-ra.108))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.108 tmp.69))
       (tmp.79 (rbp tmp-ra.108 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.108 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.108 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.108 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.108 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.108 tmp.69))
       (fixnum0.6 (rbp tmp-ra.108))
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.108))
       (tmp.86 (rbp tmp-ra.108 tmp.85))
       (tmp.84 (rsi tmp.87 tmp.89 tmp.88 rax rbp tmp-ra.108))
       (tmp.88 (rsi tmp.89 rax rbp tmp-ra.108 tmp.84))
       (tmp.89 (rbp tmp-ra.108 tmp.84 tmp.88))
       (tmp.87 (rbp tmp-ra.108 tmp.84))
       (tmp.83
        (rsi
         tmp.90
         tmp.94
         tmp.96
         tmp.95
         tmp.91
         tmp.93
         tmp.92
         rax
         rbp
         tmp-ra.108))
       (tmp.92 (rsi tmp.93 rax rbp tmp-ra.108 tmp.83))
       (tmp.93 (rbp tmp-ra.108 tmp.83 tmp.92))
       (tmp.91 (rsi tmp.94 tmp.96 tmp.95 rax rbp tmp-ra.108 tmp.83))
       (tmp.95 (rsi tmp.96 rax rbp tmp-ra.108 tmp.83 tmp.91))
       (tmp.96 (rbp tmp-ra.108 tmp.83 tmp.91 tmp.95))
       (tmp.94 (rbp tmp-ra.108 tmp.83 tmp.91))
       (tmp.90 (rbp tmp-ra.108 tmp.83))
       (fixnum1.5 (void5.1 void4.2 empty3.3 ascii-char2.4 rax rbp tmp-ra.108))
       (ascii-char2.4 (rbp tmp-ra.108 fixnum1.5))
       (empty3.3 (rbp tmp-ra.108 fixnum1.5))
       (void4.2 (rbp tmp-ra.108 fixnum1.5))
       (void5.1 (rbp tmp-ra.108 fixnum1.5))
       (rbp
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
         r15
         rdi
         rsi
         rax
         tmp-ra.108))
       (rax
        (fixnum1.5
         tmp.95
         tmp.91
         tmp.92
         tmp.83
         tmp.88
         tmp.84
         tmp.85
         tmp.81
         tmp.77
         tmp.78
         tmp.69
         tmp.74
         tmp.70
         tmp.71
         rbp
         tmp-ra.108))
       (rsi
        (tmp.83
         tmp.91
         tmp.95
         tmp.92
         tmp.84
         tmp.88
         tmp.85
         tmp.69
         tmp.77
         tmp.81
         tmp.78
         tmp.70
         tmp.74
         tmp.71
         r15
         rdi
         rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi)))))
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
         tmp.56))
       (undead-out
        ((rdi rsi tmp-ra.97 rbp)
         (rsi tmp.24 tmp-ra.97 rbp)
         (tmp.24 tmp.25 tmp-ra.97 rbp)
         ((((((tmp.109 tmp.24 tmp.25 tmp-ra.97 rbp)
              (tmp.109 tmp.24 tmp.25 tmp-ra.97 rbp)
              (tmp.57 tmp.24 tmp.25 tmp-ra.97 rbp))
             (tmp.24 tmp.25 tmp-ra.97 rbp))
            (tmp.56 tmp.24 tmp.25 tmp-ra.97 rbp)
            (tmp.56 tmp.24 tmp.25 tmp-ra.97 rbp))
           (tmp.24 tmp.25 tmp-ra.97 rbp))
          ((((((tmp.110 tmp.24 tmp.25 tmp-ra.97 rbp)
               (tmp.110 tmp.24 tmp.25 tmp-ra.97 rbp)
               (tmp.59 tmp.24 tmp.25 tmp-ra.97 rbp))
              (tmp.24 tmp.25 tmp-ra.97 rbp))
             (tmp.58 tmp.24 tmp.25 tmp-ra.97 rbp)
             (tmp.58 tmp.24 tmp.25 tmp-ra.97 rbp))
            (tmp.24 tmp.25 tmp-ra.97 rbp))
           ((tmp.25 tmp.111 tmp-ra.97 rbp)
            (tmp.111 tmp-ra.97 rbp)
            (tmp-ra.97 rax rbp)
            (rax rbp))
           ((tmp-ra.97 rax rbp) (rax rbp)))
          ((tmp-ra.97 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.97 tmp.25 tmp.24))
         (tmp.109 (tmp.25 rbp tmp-ra.97 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.97
           tmp.24
           tmp.109
           tmp.57
           tmp.56
           tmp.110
           tmp.59
           tmp.58
           tmp.111))
         (tmp.57 (rbp tmp-ra.97 tmp.25 tmp.24))
         (tmp-ra.97
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.109
           tmp.57
           tmp.56
           tmp.110
           tmp.59
           tmp.58
           tmp.111
           rax))
         (tmp.111 (rbp tmp-ra.97 tmp.25))
         (tmp.59 (rbp tmp-ra.97 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.97
           rsi
           tmp.109
           tmp.57
           tmp.56
           tmp.110
           tmp.59
           tmp.58))
         (tmp.110 (tmp.24 rbp tmp-ra.97 tmp.25))
         (tmp.58 (rbp tmp-ra.97 tmp.25 tmp.24))
         (rax (rbp tmp-ra.97))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.97
           tmp.109
           tmp.57
           tmp.56
           tmp.110
           tmp.59
           tmp.58
           tmp.111
           rax))
         (rdi (tmp-ra.97))
         (rsi (tmp.24 tmp-ra.97)))))
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
         tmp.60))
       (undead-out
        ((rdi rsi tmp-ra.98 rbp)
         (rsi tmp.22 tmp-ra.98 rbp)
         (tmp.22 tmp.23 tmp-ra.98 rbp)
         ((((((tmp.112 tmp.22 tmp.23 tmp-ra.98 rbp)
              (tmp.112 tmp.22 tmp.23 tmp-ra.98 rbp)
              (tmp.61 tmp.22 tmp.23 tmp-ra.98 rbp))
             (tmp.22 tmp.23 tmp-ra.98 rbp))
            (tmp.60 tmp.22 tmp.23 tmp-ra.98 rbp)
            (tmp.60 tmp.22 tmp.23 tmp-ra.98 rbp))
           (tmp.22 tmp.23 tmp-ra.98 rbp))
          ((((((tmp.113 tmp.22 tmp.23 tmp-ra.98 rbp)
               (tmp.113 tmp.22 tmp.23 tmp-ra.98 rbp)
               (tmp.63 tmp.22 tmp.23 tmp-ra.98 rbp))
              (tmp.22 tmp.23 tmp-ra.98 rbp))
             (tmp.62 tmp.22 tmp.23 tmp-ra.98 rbp)
             (tmp.62 tmp.22 tmp.23 tmp-ra.98 rbp))
            (tmp.22 tmp.23 tmp-ra.98 rbp))
           ((tmp.23 tmp.114 tmp-ra.98 rbp)
            (tmp.114 tmp-ra.98 rbp)
            (tmp-ra.98 rax rbp)
            (rax rbp))
           ((tmp-ra.98 rax rbp) (rax rbp)))
          ((tmp-ra.98 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.98 tmp.23 tmp.22))
         (tmp.112 (tmp.23 rbp tmp-ra.98 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.98
           tmp.22
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.114))
         (tmp.61 (rbp tmp-ra.98 tmp.23 tmp.22))
         (tmp-ra.98
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.114
           rax))
         (tmp.114 (rbp tmp-ra.98 tmp.23))
         (tmp.63 (rbp tmp-ra.98 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.98
           rsi
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62))
         (tmp.113 (tmp.22 rbp tmp-ra.98 tmp.23))
         (tmp.62 (rbp tmp-ra.98 tmp.23 tmp.22))
         (rax (rbp tmp-ra.98))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.98
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.114
           rax))
         (rdi (tmp-ra.98))
         (rsi (tmp.22 tmp-ra.98)))))
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
         tmp.64))
       (undead-out
        ((rdi rsi tmp-ra.99 rbp)
         (rsi tmp.20 tmp-ra.99 rbp)
         (tmp.21 tmp.20 tmp-ra.99 rbp)
         ((((((tmp.115 tmp.21 tmp.20 tmp-ra.99 rbp)
              (tmp.115 tmp.21 tmp.20 tmp-ra.99 rbp)
              (tmp.65 tmp.21 tmp.20 tmp-ra.99 rbp))
             (tmp.21 tmp.20 tmp-ra.99 rbp))
            (tmp.64 tmp.21 tmp.20 tmp-ra.99 rbp)
            (tmp.64 tmp.21 tmp.20 tmp-ra.99 rbp))
           (tmp.21 tmp.20 tmp-ra.99 rbp))
          ((((((tmp.116 tmp.21 tmp.20 tmp-ra.99 rbp)
               (tmp.116 tmp.21 tmp.20 tmp-ra.99 rbp)
               (tmp.67 tmp.21 tmp.20 tmp-ra.99 rbp))
              (tmp.21 tmp.20 tmp-ra.99 rbp))
             (tmp.66 tmp.21 tmp.20 tmp-ra.99 rbp)
             (tmp.66 tmp.21 tmp.20 tmp-ra.99 rbp))
            (tmp.21 tmp.20 tmp-ra.99 rbp))
           ((tmp.117 tmp.20 tmp-ra.99 rbp)
            (tmp.117 tmp.20 tmp-ra.99 rbp)
            (tmp.20 tmp.68 tmp-ra.99 rbp)
            (tmp.68 tmp.118 tmp-ra.99 rbp)
            (tmp.118 tmp-ra.99 rbp)
            (tmp-ra.99 rax rbp)
            (rax rbp))
           ((tmp-ra.99 rax rbp) (rax rbp)))
          ((tmp-ra.99 rax rbp) (rax rbp)))))
       (call-undead ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.99 tmp.20 tmp.21))
         (tmp.115 (tmp.21 rbp tmp-ra.99 tmp.20))
         (tmp.21
          (rbp tmp-ra.99 tmp.20 tmp.115 tmp.65 tmp.64 tmp.116 tmp.67 tmp.66))
         (tmp.65 (rbp tmp-ra.99 tmp.20 tmp.21))
         (tmp-ra.99
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.115
           tmp.65
           tmp.64
           tmp.116
           tmp.67
           tmp.66
           tmp.118
           tmp.68
           tmp.117
           rax))
         (tmp.117 (rbp tmp-ra.99 tmp.20))
         (tmp.68 (tmp.118 rbp tmp-ra.99 tmp.20))
         (tmp.118 (rbp tmp-ra.99 tmp.68))
         (tmp.67 (rbp tmp-ra.99 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.99
           rsi
           tmp.115
           tmp.65
           tmp.64
           tmp.116
           tmp.67
           tmp.66
           tmp.68
           tmp.117))
         (tmp.116 (tmp.20 rbp tmp-ra.99 tmp.21))
         (tmp.66 (rbp tmp-ra.99 tmp.20 tmp.21))
         (rax (rbp tmp-ra.99))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.99
           tmp.115
           tmp.65
           tmp.64
           tmp.116
           tmp.67
           tmp.66
           tmp.118
           tmp.68
           tmp.117
           rax))
         (rdi (tmp-ra.99))
         (rsi (tmp.20 tmp-ra.99)))))
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
      ((new-frames ())
       (locals (tmp-ra.100))
       (undead-out ((tmp-ra.100 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.100 (rbp)) (rbp (r15 tmp-ra.100)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.100 r15)
        (set! r15 tmp-ra.100)
        (jump L.fun/empty171687.10 rbp r15)))
    (define L.fun/void171689.5
      ((new-frames ())
       (locals (tmp-ra.101))
       (undead-out ((tmp-ra.101 rbp) (tmp-ra.101 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.101 (rax rbp))
         (rbp (rax tmp-ra.101))
         (rax (rbp tmp-ra.101)))))
      (begin (set! tmp-ra.101 r15) (set! rax 30) (jump tmp-ra.101 rbp rax)))
    (define L.fun/ascii-char171684.6
      ((new-frames ())
       (locals (tmp-ra.102))
       (undead-out ((tmp-ra.102 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.102 (rbp)) (rbp (r15 tmp-ra.102)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.102 r15)
        (set! r15 tmp-ra.102)
        (jump L.fun/ascii-char171685.9 rbp r15)))
    (define L.fun/void171688.7
      ((new-frames ())
       (locals (tmp-ra.103))
       (undead-out ((tmp-ra.103 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.103 (rbp)) (rbp (r15 tmp-ra.103)) (r15 (rbp)))))
      (begin
        (set! tmp-ra.103 r15)
        (set! r15 tmp-ra.103)
        (jump L.fun/void171689.5 rbp r15)))
    (define L.fun/void171691.8
      ((new-frames ())
       (locals (tmp-ra.104))
       (undead-out ((tmp-ra.104 rbp) (tmp-ra.104 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.104 (rax rbp))
         (rbp (rax tmp-ra.104))
         (rax (rbp tmp-ra.104)))))
      (begin (set! tmp-ra.104 r15) (set! rax 30) (jump tmp-ra.104 rbp rax)))
    (define L.fun/ascii-char171685.9
      ((new-frames ())
       (locals (tmp-ra.105))
       (undead-out ((tmp-ra.105 rbp) (tmp-ra.105 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.105 (rax rbp))
         (rbp (rax tmp-ra.105))
         (rax (rbp tmp-ra.105)))))
      (begin (set! tmp-ra.105 r15) (set! rax 25390) (jump tmp-ra.105 rbp rax)))
    (define L.fun/empty171687.10
      ((new-frames ())
       (locals (tmp-ra.106))
       (undead-out ((tmp-ra.106 rbp) (tmp-ra.106 rax rbp) (rax rbp)))
       (call-undead ())
       (conflicts
        ((tmp-ra.106 (rax rbp))
         (rbp (rax tmp-ra.106))
         (rax (rbp tmp-ra.106)))))
      (begin (set! tmp-ra.106 r15) (set! rax 22) (jump tmp-ra.106 rbp rax)))
    (define L.fun/void171690.11
      ((new-frames ())
       (locals (tmp-ra.107))
       (undead-out ((tmp-ra.107 rbp) (r15 rbp) (r15 rbp)))
       (call-undead ())
       (conflicts ((tmp-ra.107 (rbp)) (rbp (r15 tmp-ra.107)) (r15 (rbp)))))
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
