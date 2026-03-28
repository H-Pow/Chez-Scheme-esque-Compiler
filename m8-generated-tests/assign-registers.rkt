#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         "../assign-registers.rkt")
(define (fail-if-invalid p)
  (when (not (asm-pred-lang-v8/spilled? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "asm-pred-lang-v8/spilled"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-asm-pred-lang-v8/framed p)
  (interp-asm-pred-lang-v8/spilled (fail-if-invalid (assign-registers p)))))

(check-by-interp
 '(module
    ((locals (tmp-ra.50))
     (conflicts
      ((tmp-ra.50 (rax rbp)) (rbp (rax tmp-ra.50)) (rax (rbp tmp-ra.50))))
     (assignment ()))
    (begin (set! tmp-ra.50 r15) (set! rax 840) (jump tmp-ra.50 rbp rax))))
(check-by-interp
 '(module
    ((locals (tmp-ra.50))
     (conflicts
      ((tmp-ra.50 (rax rbp)) (rbp (rax tmp-ra.50)) (rax (rbp tmp-ra.50))))
     (assignment ()))
    (begin (set! tmp-ra.50 r15) (set! rax 26942) (jump tmp-ra.50 rbp rax))))
(check-by-interp
 '(module
    ((locals (tmp-ra.50 tmp.51))
     (conflicts
      ((tmp.51 (rbp tmp-ra.50))
       (tmp-ra.50 (rbp tmp.51 rax))
       (rax (rbp tmp-ra.50))
       (rbp (tmp-ra.50 tmp.51 rax))))
     (assignment ()))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 14) (!= tmp.51 6))
        (begin (set! rax 17214) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 9790) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((locals (error0.1 tmp-ra.51))
     (conflicts
      ((tmp-ra.51 (rax error0.1 rbp))
       (error0.1 (rbp tmp-ra.51))
       (rbp (rax error0.1 tmp-ra.51))
       (rax (rbp tmp-ra.51))))
     (assignment ()))
    (begin
      (set! tmp-ra.51 r15)
      (set! error0.1 28478)
      (set! rax 1128)
      (jump tmp-ra.51 rbp rax))))
(check-by-interp
 '(module
    ((locals (tmp-ra.51))
     (conflicts ((tmp-ra.51 (rbp)) (rbp (r15 tmp-ra.51)) (r15 (rbp))))
     (assignment ()))
    (define L.fun/empty8385.4
      ((locals (tmp-ra.50))
       (conflicts
        ((tmp-ra.50 (rax rbp)) (rbp (rax tmp-ra.50)) (rax (rbp tmp-ra.50))))
       (assignment ()))
      (begin (set! tmp-ra.50 r15) (set! rax 22) (jump tmp-ra.50 rbp rax)))
    (begin
      (set! tmp-ra.51 r15)
      (set! r15 tmp-ra.51)
      (jump L.fun/empty8385.4 rbp r15))))
(check-by-interp
 '(module
    ((locals (tmp-ra.50 tmp.51))
     (conflicts
      ((tmp.51 (rbp tmp-ra.50))
       (tmp-ra.50 (rbp tmp.51 rax))
       (rax (rbp tmp-ra.50))
       (rbp (tmp-ra.50 tmp.51 rax))))
     (assignment ()))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 14) (!= tmp.51 6))
        (begin (set! rax 25390) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 25390) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((locals (tmp-ra.50 tmp.51))
     (conflicts
      ((tmp.51 (rbp tmp-ra.50))
       (tmp-ra.50 (rbp tmp.51 rax))
       (rax (rbp tmp-ra.50))
       (rbp (tmp-ra.50 tmp.51 rax))))
     (assignment ()))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 14) (!= tmp.51 6))
        (begin (set! rax 50238) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 14398) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((locals (tmp.56))
     (conflicts
      ((tmp-ra.59 (rdi rsi tmp.56 tmp.55 rax rbp))
       (tmp.55 (rsi tmp.56 rax rbp tmp-ra.59))
       (tmp.56 (rbp tmp-ra.59 tmp.55))
       (rbp (tmp.56 rsi tmp.55 r15 rdi rax tmp-ra.59))
       (rax (tmp.55 rbp tmp-ra.59))
       (rdi (tmp-ra.59 rsi r15 rbp))
       (r15 (rsi rbp rdi))
       (rsi (tmp-ra.59 tmp.55 r15 rdi rbp))))
     (assignment ((tmp-ra.59 fv0) (tmp.55 fv1))))
    (define L.-.6
      ((locals
        (tmp.53
         tmp.61
         tmp.19
         tmp.54
         tmp.62
         tmp-ra.57
         tmp.52
         tmp.20
         tmp.60
         tmp.51))
       (conflicts
        ((tmp.51 (rbp tmp-ra.57 tmp.20 tmp.19))
         (tmp.60 (tmp.20 rbp tmp-ra.57 tmp.19))
         (tmp.20
          (rbp
           tmp-ra.57
           tmp.19
           tmp.60
           tmp.52
           tmp.51
           tmp.61
           tmp.54
           tmp.53
           tmp.62))
         (tmp.52 (rbp tmp-ra.57 tmp.20 tmp.19))
         (tmp-ra.57
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.60
           tmp.52
           tmp.51
           tmp.61
           tmp.54
           tmp.53
           tmp.62
           rax))
         (tmp.62 (rbp tmp-ra.57 tmp.20))
         (tmp.54 (rbp tmp-ra.57 tmp.20 tmp.19))
         (tmp.19
          (tmp.20 rbp tmp-ra.57 rsi tmp.60 tmp.52 tmp.51 tmp.61 tmp.54 tmp.53))
         (tmp.61 (tmp.19 rbp tmp-ra.57 tmp.20))
         (tmp.53 (rbp tmp-ra.57 tmp.20 tmp.19))
         (rax (rbp tmp-ra.57))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.57
           tmp.60
           tmp.52
           tmp.51
           tmp.61
           tmp.54
           tmp.53
           tmp.62
           rax))
         (rdi (tmp-ra.57))
         (rsi (tmp.19 tmp-ra.57))))
       (assignment ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.60 tmp.20)
                      (set! tmp.60 (bitwise-and tmp.60 7))
                      (set! tmp.52 tmp.60))
                    (= tmp.52 0))
                (set! tmp.51 14)
                (set! tmp.51 6))
              (!= tmp.51 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.61 tmp.19)
                        (set! tmp.61 (bitwise-and tmp.61 7))
                        (set! tmp.54 tmp.61))
                      (= tmp.54 0))
                  (set! tmp.53 14)
                  (set! tmp.53 6))
                (!= tmp.53 6))
            (begin
              (set! tmp.62 tmp.19)
              (set! tmp.62 (- tmp.62 tmp.20))
              (set! rax tmp.62)
              (jump tmp-ra.57 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.57 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.57 rbp rax)))))
    (define L.fun/fixnum8420.4
      ((locals (oprand0.1 tmp-ra.58))
       (conflicts
        ((tmp-ra.58 (rax oprand0.1 rbp rdi))
         (oprand0.1 (rbp tmp-ra.58))
         (rdi (tmp-ra.58))
         (rbp (rax oprand0.1 tmp-ra.58))
         (rax (rbp tmp-ra.58))))
       (assignment ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! oprand0.1 rdi)
        (set! rax 400)
        (jump tmp-ra.58 rbp rax)))
    (begin
      (set! tmp-ra.59 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.7
          (begin
            (set! rdi 25390)
            (set! r15 L.rp.7)
            (jump L.fun/fixnum8420.4 rbp r15 rdi)))
        (set! rbp (+ rbp 16)))
      (set! tmp.55 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.8
          (begin
            (set! rsi 2024)
            (set! rdi 168)
            (set! r15 L.rp.8)
            (jump L.-.6 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 16)))
      (set! tmp.56 rax)
      (set! rsi tmp.56)
      (set! rdi tmp.55)
      (set! r15 tmp-ra.59)
      (jump L.-.6 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((locals (tmp-ra.50 tmp.51))
     (conflicts
      ((tmp.51 (rbp tmp-ra.50))
       (tmp-ra.50 (rbp tmp.51 rax))
       (rax (rbp tmp-ra.50))
       (rbp (tmp-ra.50 tmp.51 rax))))
     (assignment ()))
    (begin
      (set! tmp-ra.50 r15)
      (if (begin (set! tmp.51 14) (!= tmp.51 6))
        (begin (set! rax 61502) (jump tmp-ra.50 rbp rax))
        (begin (set! rax 13118) (jump tmp-ra.50 rbp rax))))))
(check-by-interp
 '(module
    ((locals (tmp.52))
     (conflicts
      ((tmp-ra.55 (rdi tmp.52 rax rbp))
       (tmp.52 (rbp tmp-ra.55))
       (rbp (tmp.52 r15 rdi rax tmp-ra.55))
       (rax (rbp tmp-ra.55))
       (rdi (tmp-ra.55 r15 rbp))
       (r15 (rbp rdi))))
     (assignment ((tmp-ra.55 fv0))))
    (define L.fun/ascii-char8428.4
      ((locals (oprand0.1 tmp-ra.53))
       (conflicts
        ((tmp-ra.53 (rax oprand0.1 rbp rdi))
         (oprand0.1 (rbp tmp-ra.53))
         (rdi (tmp-ra.53))
         (rbp (rax oprand0.1 tmp-ra.53))
         (rax (rbp tmp-ra.53))))
       (assignment ()))
      (begin
        (set! tmp-ra.53 r15)
        (set! oprand0.1 rdi)
        (set! rax 25390)
        (jump tmp-ra.53 rbp rax)))
    (define L.fun/empty8427.5
      ((locals (oprand0.2 tmp-ra.54))
       (conflicts
        ((tmp-ra.54 (rax oprand0.2 rbp rdi))
         (oprand0.2 (rbp tmp-ra.54))
         (rdi (tmp-ra.54))
         (rbp (rax oprand0.2 tmp-ra.54))
         (rax (rbp tmp-ra.54))))
       (assignment ()))
      (begin
        (set! tmp-ra.54 r15)
        (set! oprand0.2 rdi)
        (set! rax 22)
        (jump tmp-ra.54 rbp rax)))
    (begin
      (set! tmp-ra.55 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.7
          (begin
            (set! rdi 22)
            (set! r15 L.rp.7)
            (jump L.fun/ascii-char8428.4 rbp r15 rdi)))
        (set! rbp (+ rbp 8)))
      (set! tmp.52 rax)
      (set! rdi tmp.52)
      (set! r15 tmp-ra.55)
      (jump L.fun/empty8427.5 rbp r15 rdi))))
(check-by-interp
 '(module
    ((locals (fixnum0.5 fixnum1.4 void2.3 tmp-ra.56 tmp.59 tmp.58 tmp.57))
     (conflicts
      ((tmp.57 (rbp tmp-ra.56))
       (tmp.58 (rbp tmp-ra.56))
       (tmp.59 (rbp tmp-ra.56))
       (tmp-ra.56
        (rbp tmp.57 tmp.58 tmp.59 rdi rsi rax void2.3 fixnum1.4 fixnum0.5))
       (void2.3 (rbp tmp-ra.56))
       (fixnum1.4 (rbp tmp-ra.56))
       (fixnum0.5 (rbp tmp-ra.56))
       (rbp
        (tmp-ra.56
         tmp.57
         tmp.58
         tmp.59
         r15
         rdi
         rsi
         rax
         void2.3
         fixnum1.4
         fixnum0.5))
       (rax (rbp tmp-ra.56))
       (rsi (r15 rdi rbp tmp-ra.56))
       (rdi (r15 rbp rsi tmp-ra.56))
       (r15 (rbp rdi rsi))))
     (assignment ()))
    (define L.fun/ascii-char8442.4
      ((locals (oprand1.1 oprand0.2 tmp-ra.55))
       (conflicts
        ((tmp-ra.55 (rax oprand1.1 oprand0.2 rbp rsi rdi))
         (oprand0.2 (rbp tmp-ra.55 rsi))
         (oprand1.1 (rbp tmp-ra.55))
         (rdi (tmp-ra.55))
         (rsi (oprand0.2 tmp-ra.55))
         (rbp (rax oprand1.1 oprand0.2 tmp-ra.55))
         (rax (rbp tmp-ra.55))))
       (assignment ()))
      (begin
        (set! tmp-ra.55 r15)
        (set! oprand0.2 rdi)
        (set! oprand1.1 rsi)
        (set! rax 25390)
        (jump tmp-ra.55 rbp rax)))
    (begin
      (set! tmp-ra.56 r15)
      (if (if (begin (set! tmp.57 14) (!= tmp.57 6))
            (begin (set! tmp.58 14) (!= tmp.58 6))
            (begin (set! tmp.59 14) (!= tmp.59 6)))
        (begin
          (set! rsi 22)
          (set! rdi 25390)
          (set! r15 tmp-ra.56)
          (jump L.fun/ascii-char8442.4 rbp r15 rdi rsi))
        (begin
          (set! fixnum0.5 832)
          (set! fixnum1.4 608)
          (set! void2.3 30)
          (set! rax 25390)
          (jump tmp-ra.56 rbp rax))))))
(check-by-interp
 '(module
    ((locals (void2.1 ascii-char1.2 fixnum0.3))
     (conflicts
      ((tmp-ra.62 (void2.1 ascii-char1.2 fixnum0.3 rax rbp))
       (fixnum0.3 (rbp tmp-ra.62))
       (ascii-char1.2 (rbp tmp-ra.62))
       (void2.1 (rbp tmp-ra.62))
       (rbp (void2.1 ascii-char1.2 fixnum0.3 r15 rdi rsi rax tmp-ra.62))
       (rax (rbp tmp-ra.62))
       (rsi (r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment ((tmp-ra.62 fv0))))
    (define L.*.8
      ((locals
        (tmp.55
         tmp.64
         tmp.17
         tmp.56
         tmp.66
         tmp.57
         tmp.65
         tmp-ra.58
         tmp.54
         tmp.18
         tmp.63
         tmp.53))
       (conflicts
        ((tmp.53 (rbp tmp-ra.58 tmp.17 tmp.18))
         (tmp.63 (tmp.18 rbp tmp-ra.58 tmp.17))
         (tmp.18
          (rbp tmp-ra.58 tmp.17 tmp.63 tmp.54 tmp.53 tmp.64 tmp.56 tmp.55))
         (tmp.54 (rbp tmp-ra.58 tmp.17 tmp.18))
         (tmp-ra.58
          (tmp.18
           tmp.17
           rbp
           rsi
           rdi
           tmp.63
           tmp.54
           tmp.53
           tmp.64
           tmp.56
           tmp.55
           tmp.66
           tmp.57
           tmp.65
           rax))
         (tmp.65 (rbp tmp-ra.58 tmp.17))
         (tmp.57 (tmp.66 rbp tmp-ra.58 tmp.17))
         (tmp.66 (rbp tmp-ra.58 tmp.57))
         (tmp.56 (rbp tmp-ra.58 tmp.17 tmp.18))
         (tmp.17
          (tmp.18
           rbp
           tmp-ra.58
           rsi
           tmp.63
           tmp.54
           tmp.53
           tmp.64
           tmp.56
           tmp.55
           tmp.57
           tmp.65))
         (tmp.64 (tmp.17 rbp tmp-ra.58 tmp.18))
         (tmp.55 (rbp tmp-ra.58 tmp.17 tmp.18))
         (rax (rbp tmp-ra.58))
         (rbp
          (tmp.18
           tmp.17
           tmp-ra.58
           tmp.63
           tmp.54
           tmp.53
           tmp.64
           tmp.56
           tmp.55
           tmp.66
           tmp.57
           tmp.65
           rax))
         (rdi (tmp-ra.58))
         (rsi (tmp.17 tmp-ra.58))))
       (assignment ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.17 rdi)
        (set! tmp.18 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.63 tmp.18)
                      (set! tmp.63 (bitwise-and tmp.63 7))
                      (set! tmp.54 tmp.63))
                    (= tmp.54 0))
                (set! tmp.53 14)
                (set! tmp.53 6))
              (!= tmp.53 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.64 tmp.17)
                        (set! tmp.64 (bitwise-and tmp.64 7))
                        (set! tmp.56 tmp.64))
                      (= tmp.56 0))
                  (set! tmp.55 14)
                  (set! tmp.55 6))
                (!= tmp.55 6))
            (begin
              (set! tmp.65 tmp.18)
              (set! tmp.65 (arithmetic-shift-right tmp.65 3))
              (set! tmp.57 tmp.65)
              (set! tmp.66 tmp.17)
              (set! tmp.66 (* tmp.66 tmp.57))
              (set! rax tmp.66)
              (jump tmp-ra.58 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.58 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.58 rbp rax)))))
    (define L.fun/ascii-char8498.4
      ((locals (tmp-ra.59))
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ()))
      (begin (set! tmp-ra.59 r15) (set! rax 25390) (jump tmp-ra.59 rbp rax)))
    (define L.fun/void8499.5
      ((locals (tmp-ra.60))
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60))))
       (assignment ()))
      (begin (set! tmp-ra.60 r15) (set! rax 30) (jump tmp-ra.60 rbp rax)))
    (define L.fun/empty8500.6
      ((locals (tmp-ra.61))
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ()))
      (begin (set! tmp-ra.61 r15) (set! rax 22) (jump tmp-ra.61 rbp rax)))
    (begin
      (set! tmp-ra.62 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.9
          (begin
            (set! rsi 272)
            (set! rdi 1856)
            (set! r15 L.rp.9)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 8)))
      (set! fixnum0.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char8498.4 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char1.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/void8499.5 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! void2.1 rax)
      (set! r15 tmp-ra.62)
      (jump L.fun/empty8500.6 rbp r15))))
(check-by-interp
 '(module
    ((locals (fixnum2.1 empty0.3))
     (conflicts
      ((tmp-ra.60 (fixnum2.1 error1.2 empty0.3 rax rbp))
       (empty0.3 (rbp tmp-ra.60))
       (error1.2 (fixnum2.1 rax rbp tmp-ra.60))
       (fixnum2.1 (rbp tmp-ra.60 error1.2))
       (rbp (fixnum2.1 rdi rsi error1.2 empty0.3 r15 rax tmp-ra.60))
       (rax (error1.2 rbp tmp-ra.60))
       (r15 (rdi rsi rbp))
       (rsi (r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment ((tmp-ra.60 fv0) (error1.2 fv1))))
    (define L.-.7
      ((locals
        (tmp.55
         tmp.62
         tmp.21
         tmp.56
         tmp.63
         tmp-ra.57
         tmp.54
         tmp.22
         tmp.61
         tmp.53))
       (conflicts
        ((tmp.53 (rbp tmp-ra.57 tmp.22 tmp.21))
         (tmp.61 (tmp.22 rbp tmp-ra.57 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.57
           tmp.21
           tmp.61
           tmp.54
           tmp.53
           tmp.62
           tmp.56
           tmp.55
           tmp.63))
         (tmp.54 (rbp tmp-ra.57 tmp.22 tmp.21))
         (tmp-ra.57
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.61
           tmp.54
           tmp.53
           tmp.62
           tmp.56
           tmp.55
           tmp.63
           rax))
         (tmp.63 (rbp tmp-ra.57 tmp.22))
         (tmp.56 (rbp tmp-ra.57 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.57 rsi tmp.61 tmp.54 tmp.53 tmp.62 tmp.56 tmp.55))
         (tmp.62 (tmp.21 rbp tmp-ra.57 tmp.22))
         (tmp.55 (rbp tmp-ra.57 tmp.22 tmp.21))
         (rax (rbp tmp-ra.57))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.57
           tmp.61
           tmp.54
           tmp.53
           tmp.62
           tmp.56
           tmp.55
           tmp.63
           rax))
         (rdi (tmp-ra.57))
         (rsi (tmp.21 tmp-ra.57))))
       (assignment ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.61 tmp.22)
                      (set! tmp.61 (bitwise-and tmp.61 7))
                      (set! tmp.54 tmp.61))
                    (= tmp.54 0))
                (set! tmp.53 14)
                (set! tmp.53 6))
              (!= tmp.53 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.62 tmp.21)
                        (set! tmp.62 (bitwise-and tmp.62 7))
                        (set! tmp.56 tmp.62))
                      (= tmp.56 0))
                  (set! tmp.55 14)
                  (set! tmp.55 6))
                (!= tmp.55 6))
            (begin
              (set! tmp.63 tmp.21)
              (set! tmp.63 (- tmp.63 tmp.22))
              (set! rax tmp.63)
              (jump tmp-ra.57 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.57 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.57 rbp rax)))))
    (define L.fun/empty8553.4
      ((locals (tmp-ra.58))
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ()))
      (begin (set! tmp-ra.58 r15) (set! rax 22) (jump tmp-ra.58 rbp rax)))
    (define L.fun/error8554.5
      ((locals (tmp-ra.59))
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ()))
      (begin (set! tmp-ra.59 r15) (set! rax 43326) (jump tmp-ra.59 rbp rax)))
    (begin
      (set! tmp-ra.60 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.8
          (begin (set! r15 L.rp.8) (jump L.fun/empty8553.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty0.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.9
          (begin (set! r15 L.rp.9) (jump L.fun/error8554.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error1.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin
            (set! rsi 144)
            (set! rdi 1768)
            (set! r15 L.rp.10)
            (jump L.-.7 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 16)))
      (set! fixnum2.1 rax)
      (set! rax error1.2)
      (jump tmp-ra.60 rbp rax))))
(check-by-interp
 '(module
    ((locals (tmp.58 tmp.54))
     (conflicts
      ((tmp.54 (rbp tmp-ra.57))
       (tmp-ra.57 (rbp tmp.54 tmp.58 rax rdi rsi))
       (tmp.58 (rbp tmp-ra.57))
       (rsi (r15 rdi rbp tmp-ra.57))
       (rbp (tmp-ra.57 tmp.54 tmp.58 rax r15 rdi rsi))
       (rdi (r15 rbp rsi tmp-ra.57))
       (r15 (rbp rdi rsi))
       (rax (rbp tmp-ra.57))))
     (assignment ((tmp-ra.57 fv0))))
    (define L.fun/boolean8597.4
      ((locals (oprand1.1 oprand0.2 tmp-ra.55))
       (conflicts
        ((tmp-ra.55 (rax oprand1.1 oprand0.2 rbp rsi rdi))
         (oprand0.2 (rbp tmp-ra.55 rsi))
         (oprand1.1 (rbp tmp-ra.55))
         (rdi (tmp-ra.55))
         (rsi (oprand0.2 tmp-ra.55))
         (rbp (rax oprand1.1 oprand0.2 tmp-ra.55))
         (rax (rbp tmp-ra.55))))
       (assignment ()))
      (begin
        (set! tmp-ra.55 r15)
        (set! oprand0.2 rdi)
        (set! oprand1.1 rsi)
        (set! rax 6)
        (jump tmp-ra.55 rbp rax)))
    (define L.fun/ascii-char8598.5
      ((locals (oprand1.3 oprand0.4 tmp-ra.56))
       (conflicts
        ((tmp-ra.56 (rax oprand1.3 oprand0.4 rbp rsi rdi))
         (oprand0.4 (rbp tmp-ra.56 rsi))
         (oprand1.3 (rbp tmp-ra.56))
         (rdi (tmp-ra.56))
         (rsi (oprand0.4 tmp-ra.56))
         (rbp (rax oprand1.3 oprand0.4 tmp-ra.56))
         (rax (rbp tmp-ra.56))))
       (assignment ()))
      (begin
        (set! tmp-ra.56 r15)
        (set! oprand0.4 rdi)
        (set! oprand1.3 rsi)
        (set! rax 25390)
        (jump tmp-ra.56 rbp rax)))
    (begin
      (set! tmp-ra.57 r15)
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 8))
                (return-point L.rp.7
                  (begin
                    (set! rsi 25390)
                    (set! rdi 22)
                    (set! r15 L.rp.7)
                    (jump L.fun/boolean8597.4 rbp r15 rdi rsi)))
                (set! rbp (+ rbp 8)))
              (set! tmp.54 rax))
            (!= tmp.54 6))
        (if (begin (set! tmp.58 6) (!= tmp.58 6))
          (begin (set! rax 25390) (jump tmp-ra.57 rbp rax))
          (begin (set! rax 25390) (jump tmp-ra.57 rbp rax)))
        (begin
          (set! rsi 22)
          (set! rdi 624)
          (set! r15 tmp-ra.57)
          (jump L.fun/ascii-char8598.5 rbp r15 rdi rsi))))))
(check-by-interp
 '(module
    ((locals
      (tmp.82
       tmp.83
       tmp.84
       tmp.72
       void3.13
       fixnum2.14
       error1.15
       boolean0.16
       tmp.71))
     (conflicts
      ((tmp-ra.78
        (rdi
         rsi
         tmp.82
         tmp.83
         tmp.84
         void3.13
         fixnum2.14
         error1.15
         boolean0.16
         tmp.72
         tmp.71
         rax
         tmp.70
         rbp))
       (tmp.70
        (rsi
         tmp.82
         tmp.83
         tmp.84
         void3.13
         fixnum2.14
         error1.15
         boolean0.16
         rax
         tmp.72
         rbp
         tmp-ra.78))
       (tmp.71 (rbp tmp-ra.78))
       (boolean0.16 (rbp tmp-ra.78 tmp.70))
       (error1.15 (rbp tmp-ra.78 tmp.70))
       (fixnum2.14 (void3.13 rbp tmp-ra.78 tmp.70))
       (void3.13 (rbp tmp-ra.78 tmp.70 fixnum2.14))
       (tmp.72 (rbp tmp-ra.78 tmp.70))
       (tmp.84 (rbp tmp-ra.78 tmp.70))
       (tmp.83 (rbp tmp-ra.78 tmp.70))
       (tmp.82 (rbp tmp-ra.78 tmp.70))
       (rbp
        (tmp.82
         tmp.83
         tmp.84
         void3.13
         fixnum2.14
         error1.15
         boolean0.16
         tmp.72
         tmp.71
         r15
         rdi
         rsi
         rdx
         rax
         tmp.70
         tmp-ra.78))
       (rax (tmp.70 rbp tmp-ra.78))
       (rdx (r15 rdi rsi rbp))
       (rsi (tmp-ra.78 tmp.70 r15 rdi rbp rdx))
       (rdi (tmp-ra.78 r15 rbp rsi rdx))
       (r15 (rbp rdi rsi rdx))))
     (assignment ((tmp-ra.78 fv0) (tmp.70 fv1))))
    (define L.+.9
      ((locals
        (tmp.68
         tmp.80
         tmp.32
         tmp.69
         tmp.81
         tmp-ra.73
         tmp.67
         tmp.33
         tmp.79
         tmp.66))
       (conflicts
        ((tmp.66 (rbp tmp-ra.73 tmp.33 tmp.32))
         (tmp.79 (tmp.33 rbp tmp-ra.73 tmp.32))
         (tmp.33
          (rbp
           tmp-ra.73
           tmp.32
           tmp.79
           tmp.67
           tmp.66
           tmp.80
           tmp.69
           tmp.68
           tmp.81))
         (tmp.67 (rbp tmp-ra.73 tmp.33 tmp.32))
         (tmp-ra.73
          (tmp.33
           tmp.32
           rbp
           rsi
           rdi
           tmp.79
           tmp.67
           tmp.66
           tmp.80
           tmp.69
           tmp.68
           tmp.81
           rax))
         (tmp.81 (rbp tmp-ra.73 tmp.33))
         (tmp.69 (rbp tmp-ra.73 tmp.33 tmp.32))
         (tmp.32
          (tmp.33 rbp tmp-ra.73 rsi tmp.79 tmp.67 tmp.66 tmp.80 tmp.69 tmp.68))
         (tmp.80 (tmp.32 rbp tmp-ra.73 tmp.33))
         (tmp.68 (rbp tmp-ra.73 tmp.33 tmp.32))
         (rax (rbp tmp-ra.73))
         (rbp
          (tmp.33
           tmp.32
           tmp-ra.73
           tmp.79
           tmp.67
           tmp.66
           tmp.80
           tmp.69
           tmp.68
           tmp.81
           rax))
         (rdi (tmp-ra.73))
         (rsi (tmp.32 tmp-ra.73))))
       (assignment ()))
      (begin
        (set! tmp-ra.73 r15)
        (set! tmp.32 rdi)
        (set! tmp.33 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.79 tmp.33)
                      (set! tmp.79 (bitwise-and tmp.79 7))
                      (set! tmp.67 tmp.79))
                    (= tmp.67 0))
                (set! tmp.66 14)
                (set! tmp.66 6))
              (!= tmp.66 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.80 tmp.32)
                        (set! tmp.80 (bitwise-and tmp.80 7))
                        (set! tmp.69 tmp.80))
                      (= tmp.69 0))
                  (set! tmp.68 14)
                  (set! tmp.68 6))
                (!= tmp.68 6))
            (begin
              (set! tmp.81 tmp.32)
              (set! tmp.81 (+ tmp.81 tmp.33))
              (set! rax tmp.81)
              (jump tmp-ra.73 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.73 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.73 rbp rax)))))
    (define L.fun/fixnum9203.4
      ((locals (oprand2.1 oprand1.2 oprand0.3 tmp-ra.74))
       (conflicts
        ((tmp-ra.74 (rax oprand2.1 oprand1.2 oprand0.3 rbp rdx rsi rdi))
         (oprand0.3 (rbp tmp-ra.74 rdx rsi))
         (oprand1.2 (rbp tmp-ra.74 rdx))
         (oprand2.1 (rbp tmp-ra.74))
         (rdi (tmp-ra.74))
         (rsi (oprand0.3 tmp-ra.74))
         (rdx (oprand1.2 oprand0.3 tmp-ra.74))
         (rbp (rax oprand2.1 oprand1.2 oprand0.3 tmp-ra.74))
         (rax (rbp tmp-ra.74))))
       (assignment ()))
      (begin
        (set! tmp-ra.74 r15)
        (set! oprand0.3 rdi)
        (set! oprand1.2 rsi)
        (set! oprand2.1 rdx)
        (set! rax 1368)
        (jump tmp-ra.74 rbp rax)))
    (define L.fun/fixnum9202.5
      ((locals (oprand2.4 oprand1.5 oprand0.6 tmp-ra.75))
       (conflicts
        ((tmp-ra.75 (rax oprand2.4 oprand1.5 oprand0.6 rbp rdx rsi rdi))
         (oprand0.6 (rbp tmp-ra.75 rdx rsi))
         (oprand1.5 (rbp tmp-ra.75 rdx))
         (oprand2.4 (rbp tmp-ra.75))
         (rdi (tmp-ra.75))
         (rsi (oprand0.6 tmp-ra.75))
         (rdx (oprand1.5 oprand0.6 tmp-ra.75))
         (rbp (rax oprand2.4 oprand1.5 oprand0.6 tmp-ra.75))
         (rax (rbp tmp-ra.75))))
       (assignment ()))
      (begin
        (set! tmp-ra.75 r15)
        (set! oprand0.6 rdi)
        (set! oprand1.5 rsi)
        (set! oprand2.4 rdx)
        (set! rax 568)
        (jump tmp-ra.75 rbp rax)))
    (define L.fun/fixnum9204.6
      ((locals (oprand2.7 oprand1.8 oprand0.9 tmp-ra.76))
       (conflicts
        ((tmp-ra.76 (rax oprand2.7 oprand1.8 oprand0.9 rbp rdx rsi rdi))
         (oprand0.9 (rbp tmp-ra.76 rdx rsi))
         (oprand1.8 (rbp tmp-ra.76 rdx))
         (oprand2.7 (rbp tmp-ra.76))
         (rdi (tmp-ra.76))
         (rsi (oprand0.9 tmp-ra.76))
         (rdx (oprand1.8 oprand0.9 tmp-ra.76))
         (rbp (rax oprand2.7 oprand1.8 oprand0.9 tmp-ra.76))
         (rax (rbp tmp-ra.76))))
       (assignment ()))
      (begin
        (set! tmp-ra.76 r15)
        (set! oprand0.9 rdi)
        (set! oprand1.8 rsi)
        (set! oprand2.7 rdx)
        (set! rax oprand2.7)
        (jump tmp-ra.76 rbp rax)))
    (define L.fun/boolean9201.7
      ((locals (oprand2.10 oprand1.11 oprand0.12 tmp-ra.77))
       (conflicts
        ((tmp-ra.77 (rax oprand2.10 oprand1.11 oprand0.12 rbp rdx rsi rdi))
         (oprand0.12 (rbp tmp-ra.77 rdx rsi))
         (oprand1.11 (rbp tmp-ra.77 rdx))
         (oprand2.10 (rbp tmp-ra.77))
         (rdi (tmp-ra.77))
         (rsi (oprand0.12 tmp-ra.77))
         (rdx (oprand1.11 oprand0.12 tmp-ra.77))
         (rbp (rax oprand2.10 oprand1.11 oprand0.12 tmp-ra.77))
         (rax (rbp tmp-ra.77))))
       (assignment ()))
      (begin
        (set! tmp-ra.77 r15)
        (set! oprand0.12 rdi)
        (set! oprand1.11 rsi)
        (set! oprand2.10 rdx)
        (set! rax 14)
        (jump tmp-ra.77 rbp rax)))
    (begin
      (set! tmp-ra.78 r15)
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 16))
                (return-point L.rp.10
                  (begin
                    (set! rdx 22)
                    (set! rsi 25390)
                    (set! rdi 2878)
                    (set! r15 L.rp.10)
                    (jump L.fun/boolean9201.7 rbp r15 rdi rsi rdx)))
                (set! rbp (+ rbp 16)))
              (set! tmp.71 rax))
            (!= tmp.71 6))
        (begin
          (begin
            (set! rbp (- rbp 16))
            (return-point L.rp.11
              (begin
                (set! rdx 30)
                (set! rsi 22)
                (set! rdi 30)
                (set! r15 L.rp.11)
                (jump L.fun/fixnum9202.5 rbp r15 rdi rsi rdx)))
            (set! rbp (+ rbp 16)))
          (set! tmp.70 rax))
        (begin
          (begin
            (set! rbp (- rbp 16))
            (return-point L.rp.12
              (begin
                (set! rdx 6)
                (set! rsi 6)
                (set! rdi 22)
                (set! r15 L.rp.12)
                (jump L.fun/fixnum9203.4 rbp r15 rdi rsi rdx)))
            (set! rbp (+ rbp 16)))
          (set! tmp.70 rax)))
      (if (if (begin (set! tmp.82 14) (!= tmp.82 6))
            (begin (set! tmp.83 6) (!= tmp.83 6))
            (begin (set! tmp.84 6) (!= tmp.84 6)))
        (begin
          (set! boolean0.16 6)
          (set! error1.15 59198)
          (set! fixnum2.14 216)
          (set! void3.13 30)
          (set! tmp.72 fixnum2.14))
        (begin
          (begin
            (set! rbp (- rbp 16))
            (return-point L.rp.13
              (begin
                (set! rdx 1776)
                (set! rsi 25390)
                (set! rdi 30)
                (set! r15 L.rp.13)
                (jump L.fun/fixnum9204.6 rbp r15 rdi rsi rdx)))
            (set! rbp (+ rbp 16)))
          (set! tmp.72 rax)))
      (set! rsi tmp.72)
      (set! rdi tmp.70)
      (set! r15 tmp-ra.78)
      (jump L.+.9 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((locals (void3.1 ascii-char2.2 ascii-char1.3 fixnum0.4 tmp.68))
     (conflicts
      ((tmp-ra.76
        (void3.1 ascii-char2.2 ascii-char1.3 fixnum0.4 tmp.68 tmp.67 rax rbp))
       (tmp.67 (rsi tmp.68 rax rbp tmp-ra.76))
       (tmp.68 (rbp tmp-ra.76 tmp.67))
       (fixnum0.4 (rbp tmp-ra.76))
       (ascii-char1.3 (rbp tmp-ra.76))
       (ascii-char2.2 (rbp tmp-ra.76))
       (void3.1 (rbp tmp-ra.76))
       (rbp
        (void3.1
         ascii-char2.2
         ascii-char1.3
         fixnum0.4
         tmp.68
         tmp.67
         r15
         rdi
         rsi
         rax
         tmp-ra.76))
       (rax (tmp.67 rbp tmp-ra.76))
       (rsi (tmp.67 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment ((tmp-ra.76 fv0) (tmp.67 fv1))))
    (define L.-.11
      ((locals
        (tmp.56
         tmp.78
         tmp.22
         tmp.57
         tmp.79
         tmp-ra.69
         tmp.55
         tmp.23
         tmp.77
         tmp.54))
       (conflicts
        ((tmp.54 (rbp tmp-ra.69 tmp.23 tmp.22))
         (tmp.77 (tmp.23 rbp tmp-ra.69 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.69
           tmp.22
           tmp.77
           tmp.55
           tmp.54
           tmp.78
           tmp.57
           tmp.56
           tmp.79))
         (tmp.55 (rbp tmp-ra.69 tmp.23 tmp.22))
         (tmp-ra.69
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.77
           tmp.55
           tmp.54
           tmp.78
           tmp.57
           tmp.56
           tmp.79
           rax))
         (tmp.79 (rbp tmp-ra.69 tmp.23))
         (tmp.57 (rbp tmp-ra.69 tmp.23 tmp.22))
         (tmp.22
          (tmp.23 rbp tmp-ra.69 rsi tmp.77 tmp.55 tmp.54 tmp.78 tmp.57 tmp.56))
         (tmp.78 (tmp.22 rbp tmp-ra.69 tmp.23))
         (tmp.56 (rbp tmp-ra.69 tmp.23 tmp.22))
         (rax (rbp tmp-ra.69))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.69
           tmp.77
           tmp.55
           tmp.54
           tmp.78
           tmp.57
           tmp.56
           tmp.79
           rax))
         (rdi (tmp-ra.69))
         (rsi (tmp.22 tmp-ra.69))))
       (assignment ()))
      (begin
        (set! tmp-ra.69 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.77 tmp.23)
                      (set! tmp.77 (bitwise-and tmp.77 7))
                      (set! tmp.55 tmp.77))
                    (= tmp.55 0))
                (set! tmp.54 14)
                (set! tmp.54 6))
              (!= tmp.54 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.78 tmp.22)
                        (set! tmp.78 (bitwise-and tmp.78 7))
                        (set! tmp.57 tmp.78))
                      (= tmp.57 0))
                  (set! tmp.56 14)
                  (set! tmp.56 6))
                (!= tmp.56 6))
            (begin
              (set! tmp.79 tmp.22)
              (set! tmp.79 (- tmp.79 tmp.23))
              (set! rax tmp.79)
              (jump tmp-ra.69 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.69 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.69 rbp rax)))))
    (define L.+.10
      ((locals
        (tmp.60
         tmp.81
         tmp.20
         tmp.61
         tmp.82
         tmp-ra.70
         tmp.59
         tmp.21
         tmp.80
         tmp.58))
       (conflicts
        ((tmp.58 (rbp tmp-ra.70 tmp.21 tmp.20))
         (tmp.80 (tmp.21 rbp tmp-ra.70 tmp.20))
         (tmp.21
          (rbp
           tmp-ra.70
           tmp.20
           tmp.80
           tmp.59
           tmp.58
           tmp.81
           tmp.61
           tmp.60
           tmp.82))
         (tmp.59 (rbp tmp-ra.70 tmp.21 tmp.20))
         (tmp-ra.70
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.80
           tmp.59
           tmp.58
           tmp.81
           tmp.61
           tmp.60
           tmp.82
           rax))
         (tmp.82 (rbp tmp-ra.70 tmp.21))
         (tmp.61 (rbp tmp-ra.70 tmp.21 tmp.20))
         (tmp.20
          (tmp.21 rbp tmp-ra.70 rsi tmp.80 tmp.59 tmp.58 tmp.81 tmp.61 tmp.60))
         (tmp.81 (tmp.20 rbp tmp-ra.70 tmp.21))
         (tmp.60 (rbp tmp-ra.70 tmp.21 tmp.20))
         (rax (rbp tmp-ra.70))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.70
           tmp.80
           tmp.59
           tmp.58
           tmp.81
           tmp.61
           tmp.60
           tmp.82
           rax))
         (rdi (tmp-ra.70))
         (rsi (tmp.20 tmp-ra.70))))
       (assignment ()))
      (begin
        (set! tmp-ra.70 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.80 tmp.21)
                      (set! tmp.80 (bitwise-and tmp.80 7))
                      (set! tmp.59 tmp.80))
                    (= tmp.59 0))
                (set! tmp.58 14)
                (set! tmp.58 6))
              (!= tmp.58 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.81 tmp.20)
                        (set! tmp.81 (bitwise-and tmp.81 7))
                        (set! tmp.61 tmp.81))
                      (= tmp.61 0))
                  (set! tmp.60 14)
                  (set! tmp.60 6))
                (!= tmp.60 6))
            (begin
              (set! tmp.82 tmp.20)
              (set! tmp.82 (+ tmp.82 tmp.21))
              (set! rax tmp.82)
              (jump tmp-ra.70 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.70 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.70 rbp rax)))))
    (define L.*.9
      ((locals
        (tmp.64
         tmp.84
         tmp.18
         tmp.65
         tmp.86
         tmp.66
         tmp.85
         tmp-ra.71
         tmp.63
         tmp.19
         tmp.83
         tmp.62))
       (conflicts
        ((tmp.62 (rbp tmp-ra.71 tmp.18 tmp.19))
         (tmp.83 (tmp.19 rbp tmp-ra.71 tmp.18))
         (tmp.19
          (rbp tmp-ra.71 tmp.18 tmp.83 tmp.63 tmp.62 tmp.84 tmp.65 tmp.64))
         (tmp.63 (rbp tmp-ra.71 tmp.18 tmp.19))
         (tmp-ra.71
          (tmp.19
           tmp.18
           rbp
           rsi
           rdi
           tmp.83
           tmp.63
           tmp.62
           tmp.84
           tmp.65
           tmp.64
           tmp.86
           tmp.66
           tmp.85
           rax))
         (tmp.85 (rbp tmp-ra.71 tmp.18))
         (tmp.66 (tmp.86 rbp tmp-ra.71 tmp.18))
         (tmp.86 (rbp tmp-ra.71 tmp.66))
         (tmp.65 (rbp tmp-ra.71 tmp.18 tmp.19))
         (tmp.18
          (tmp.19
           rbp
           tmp-ra.71
           rsi
           tmp.83
           tmp.63
           tmp.62
           tmp.84
           tmp.65
           tmp.64
           tmp.66
           tmp.85))
         (tmp.84 (tmp.18 rbp tmp-ra.71 tmp.19))
         (tmp.64 (rbp tmp-ra.71 tmp.18 tmp.19))
         (rax (rbp tmp-ra.71))
         (rbp
          (tmp.19
           tmp.18
           tmp-ra.71
           tmp.83
           tmp.63
           tmp.62
           tmp.84
           tmp.65
           tmp.64
           tmp.86
           tmp.66
           tmp.85
           rax))
         (rdi (tmp-ra.71))
         (rsi (tmp.18 tmp-ra.71))))
       (assignment ()))
      (begin
        (set! tmp-ra.71 r15)
        (set! tmp.18 rdi)
        (set! tmp.19 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.83 tmp.19)
                      (set! tmp.83 (bitwise-and tmp.83 7))
                      (set! tmp.63 tmp.83))
                    (= tmp.63 0))
                (set! tmp.62 14)
                (set! tmp.62 6))
              (!= tmp.62 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.84 tmp.18)
                        (set! tmp.84 (bitwise-and tmp.84 7))
                        (set! tmp.65 tmp.84))
                      (= tmp.65 0))
                  (set! tmp.64 14)
                  (set! tmp.64 6))
                (!= tmp.64 6))
            (begin
              (set! tmp.85 tmp.19)
              (set! tmp.85 (arithmetic-shift-right tmp.85 3))
              (set! tmp.66 tmp.85)
              (set! tmp.86 tmp.18)
              (set! tmp.86 (* tmp.86 tmp.66))
              (set! rax tmp.86)
              (jump tmp-ra.71 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.71 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.71 rbp rax)))))
    (define L.fun/ascii-char9328.4
      ((locals (tmp-ra.72))
       (conflicts
        ((tmp-ra.72 (rax rbp)) (rbp (rax tmp-ra.72)) (rax (rbp tmp-ra.72))))
       (assignment ()))
      (begin (set! tmp-ra.72 r15) (set! rax 25390) (jump tmp-ra.72 rbp rax)))
    (define L.fun/void9330.5
      ((locals (tmp-ra.73))
       (conflicts
        ((tmp-ra.73 (rax rbp)) (rbp (rax tmp-ra.73)) (rax (rbp tmp-ra.73))))
       (assignment ()))
      (begin (set! tmp-ra.73 r15) (set! rax 30) (jump tmp-ra.73 rbp rax)))
    (define L.fun/error9331.6
      ((locals (tmp-ra.74))
       (conflicts
        ((tmp-ra.74 (rax rbp)) (rbp (rax tmp-ra.74)) (rax (rbp tmp-ra.74))))
       (assignment ()))
      (begin (set! tmp-ra.74 r15) (set! rax 27198) (jump tmp-ra.74 rbp rax)))
    (define L.fun/ascii-char9329.7
      ((locals (tmp-ra.75))
       (conflicts
        ((tmp-ra.75 (rax rbp)) (rbp (rax tmp-ra.75)) (rax (rbp tmp-ra.75))))
       (assignment ()))
      (begin (set! tmp-ra.75 r15) (set! rax 25390) (jump tmp-ra.75 rbp rax)))
    (begin
      (set! tmp-ra.76 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin
            (set! rsi 1800)
            (set! rdi 440)
            (set! r15 L.rp.12)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 16)))
      (set! tmp.67 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin
            (set! rsi 224)
            (set! rdi 416)
            (set! r15 L.rp.13)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 16)))
      (set! tmp.68 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin
            (set! rsi tmp.68)
            (set! rdi tmp.67)
            (set! r15 L.rp.14)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 16)))
      (set! fixnum0.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/ascii-char9328.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char1.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/ascii-char9329.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char2.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void9330.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void3.1 rax)
      (set! r15 tmp-ra.76)
      (jump L.fun/error9331.6 rbp r15))))
(check-by-interp
 '(module
    ((locals (fixnum3.1 tmp.68 error2.2 fixnum1.3 tmp.66 fixnum0.4 tmp.64))
     (conflicts
      ((tmp-ra.73
        (fixnum3.1
         tmp.68
         tmp.67
         error2.2
         fixnum1.3
         tmp.66
         tmp.65
         fixnum0.4
         tmp.64
         tmp.63
         rax
         rbp))
       (tmp.63 (rsi tmp.64 rax rbp tmp-ra.73))
       (tmp.64 (rbp tmp-ra.73 tmp.63))
       (fixnum0.4 (rbp tmp-ra.73))
       (tmp.65 (rsi tmp.66 rax rbp tmp-ra.73))
       (tmp.66 (rbp tmp-ra.73 tmp.65))
       (fixnum1.3 (rbp tmp-ra.73))
       (error2.2 (rbp tmp-ra.73))
       (tmp.67 (rsi tmp.68 rax rbp tmp-ra.73))
       (tmp.68 (rbp tmp-ra.73 tmp.67))
       (fixnum3.1 (rbp tmp-ra.73))
       (rbp
        (fixnum3.1
         tmp.68
         tmp.67
         error2.2
         fixnum1.3
         tmp.66
         tmp.65
         fixnum0.4
         tmp.64
         tmp.63
         r15
         rdi
         rsi
         rax
         tmp-ra.73))
       (rax (tmp.67 tmp.65 tmp.63 rbp tmp-ra.73))
       (rsi (tmp.67 tmp.65 tmp.63 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment ((tmp-ra.73 fv0) (tmp.65 fv1) (tmp.67 fv1) (tmp.63 fv1))))
    (define L.*.8
      ((locals
        (tmp.56
         tmp.75
         tmp.18
         tmp.57
         tmp.77
         tmp.58
         tmp.76
         tmp-ra.69
         tmp.55
         tmp.19
         tmp.74
         tmp.54))
       (conflicts
        ((tmp.54 (rbp tmp-ra.69 tmp.18 tmp.19))
         (tmp.74 (tmp.19 rbp tmp-ra.69 tmp.18))
         (tmp.19
          (rbp tmp-ra.69 tmp.18 tmp.74 tmp.55 tmp.54 tmp.75 tmp.57 tmp.56))
         (tmp.55 (rbp tmp-ra.69 tmp.18 tmp.19))
         (tmp-ra.69
          (tmp.19
           tmp.18
           rbp
           rsi
           rdi
           tmp.74
           tmp.55
           tmp.54
           tmp.75
           tmp.57
           tmp.56
           tmp.77
           tmp.58
           tmp.76
           rax))
         (tmp.76 (rbp tmp-ra.69 tmp.18))
         (tmp.58 (tmp.77 rbp tmp-ra.69 tmp.18))
         (tmp.77 (rbp tmp-ra.69 tmp.58))
         (tmp.57 (rbp tmp-ra.69 tmp.18 tmp.19))
         (tmp.18
          (tmp.19
           rbp
           tmp-ra.69
           rsi
           tmp.74
           tmp.55
           tmp.54
           tmp.75
           tmp.57
           tmp.56
           tmp.58
           tmp.76))
         (tmp.75 (tmp.18 rbp tmp-ra.69 tmp.19))
         (tmp.56 (rbp tmp-ra.69 tmp.18 tmp.19))
         (rax (rbp tmp-ra.69))
         (rbp
          (tmp.19
           tmp.18
           tmp-ra.69
           tmp.74
           tmp.55
           tmp.54
           tmp.75
           tmp.57
           tmp.56
           tmp.77
           tmp.58
           tmp.76
           rax))
         (rdi (tmp-ra.69))
         (rsi (tmp.18 tmp-ra.69))))
       (assignment ()))
      (begin
        (set! tmp-ra.69 r15)
        (set! tmp.18 rdi)
        (set! tmp.19 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.74 tmp.19)
                      (set! tmp.74 (bitwise-and tmp.74 7))
                      (set! tmp.55 tmp.74))
                    (= tmp.55 0))
                (set! tmp.54 14)
                (set! tmp.54 6))
              (!= tmp.54 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.75 tmp.18)
                        (set! tmp.75 (bitwise-and tmp.75 7))
                        (set! tmp.57 tmp.75))
                      (= tmp.57 0))
                  (set! tmp.56 14)
                  (set! tmp.56 6))
                (!= tmp.56 6))
            (begin
              (set! tmp.76 tmp.19)
              (set! tmp.76 (arithmetic-shift-right tmp.76 3))
              (set! tmp.58 tmp.76)
              (set! tmp.77 tmp.18)
              (set! tmp.77 (* tmp.77 tmp.58))
              (set! rax tmp.77)
              (jump tmp-ra.69 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.69 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.69 rbp rax)))))
    (define L.-.7
      ((locals
        (tmp.61
         tmp.79
         tmp.22
         tmp.62
         tmp.80
         tmp-ra.70
         tmp.60
         tmp.23
         tmp.78
         tmp.59))
       (conflicts
        ((tmp.59 (rbp tmp-ra.70 tmp.23 tmp.22))
         (tmp.78 (tmp.23 rbp tmp-ra.70 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.70
           tmp.22
           tmp.78
           tmp.60
           tmp.59
           tmp.79
           tmp.62
           tmp.61
           tmp.80))
         (tmp.60 (rbp tmp-ra.70 tmp.23 tmp.22))
         (tmp-ra.70
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.78
           tmp.60
           tmp.59
           tmp.79
           tmp.62
           tmp.61
           tmp.80
           rax))
         (tmp.80 (rbp tmp-ra.70 tmp.23))
         (tmp.62 (rbp tmp-ra.70 tmp.23 tmp.22))
         (tmp.22
          (tmp.23 rbp tmp-ra.70 rsi tmp.78 tmp.60 tmp.59 tmp.79 tmp.62 tmp.61))
         (tmp.79 (tmp.22 rbp tmp-ra.70 tmp.23))
         (tmp.61 (rbp tmp-ra.70 tmp.23 tmp.22))
         (rax (rbp tmp-ra.70))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.70
           tmp.78
           tmp.60
           tmp.59
           tmp.79
           tmp.62
           tmp.61
           tmp.80
           rax))
         (rdi (tmp-ra.70))
         (rsi (tmp.22 tmp-ra.70))))
       (assignment ()))
      (begin
        (set! tmp-ra.70 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.78 tmp.23)
                      (set! tmp.78 (bitwise-and tmp.78 7))
                      (set! tmp.60 tmp.78))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.79 tmp.22)
                        (set! tmp.79 (bitwise-and tmp.79 7))
                        (set! tmp.62 tmp.79))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.80 tmp.22)
              (set! tmp.80 (- tmp.80 tmp.23))
              (set! rax tmp.80)
              (jump tmp-ra.70 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.70 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.70 rbp rax)))))
    (define L.fun/ascii-char9350.4
      ((locals (tmp-ra.71))
       (conflicts
        ((tmp-ra.71 (rax rbp)) (rbp (rax tmp-ra.71)) (rax (rbp tmp-ra.71))))
       (assignment ()))
      (begin (set! tmp-ra.71 r15) (set! rax 25390) (jump tmp-ra.71 rbp rax)))
    (define L.fun/error9349.5
      ((locals (tmp-ra.72))
       (conflicts
        ((tmp-ra.72 (rax rbp)) (rbp (rax tmp-ra.72)) (rax (rbp tmp-ra.72))))
       (assignment ()))
      (begin (set! tmp-ra.72 r15) (set! rax 34878) (jump tmp-ra.72 rbp rax)))
    (begin
      (set! tmp-ra.73 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.9
          (begin
            (set! rsi 1608)
            (set! rdi 1200)
            (set! r15 L.rp.9)
            (jump L.-.7 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.63 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.10
          (begin
            (set! rsi 936)
            (set! rdi 760)
            (set! r15 L.rp.10)
            (jump L.-.7 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.64 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.11
          (begin
            (set! rsi tmp.64)
            (set! rdi tmp.63)
            (set! r15 L.rp.11)
            (jump L.-.7 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! fixnum0.4 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.12
          (begin
            (set! rsi 856)
            (set! rdi 1024)
            (set! r15 L.rp.12)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.65 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin
            (set! rsi 776)
            (set! rdi 712)
            (set! r15 L.rp.13)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.66 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin
            (set! rsi tmp.66)
            (set! rdi tmp.65)
            (set! r15 L.rp.14)
            (jump L.-.7 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! fixnum1.3 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/error9349.5 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! error2.2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 32)
            (set! rdi 1064)
            (set! r15 L.rp.16)
            (jump L.-.7 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.67 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 1200)
            (set! rdi 1088)
            (set! r15 L.rp.17)
            (jump L.-.7 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.68 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.68)
            (set! rdi tmp.67)
            (set! r15 L.rp.18)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! fixnum3.1 rax)
      (set! r15 tmp-ra.73)
      (jump L.fun/ascii-char9350.4 rbp r15))))
(check-by-interp
 '(module
    ((locals (empty3.1 empty2.2 fixnum1.3 tmp.68))
     (conflicts
      ((tmp-ra.75 (empty3.1 empty2.2 fixnum1.3 tmp.68 tmp.67 void0.4 rax rbp))
       (void0.4 (empty3.1 empty2.2 fixnum1.3 tmp.68 tmp.67 rax rbp tmp-ra.75))
       (tmp.67 (rsi tmp.68 rax rbp tmp-ra.75 void0.4))
       (tmp.68 (rbp tmp-ra.75 void0.4 tmp.67))
       (fixnum1.3 (rbp tmp-ra.75 void0.4))
       (empty2.2 (rbp tmp-ra.75 void0.4))
       (empty3.1 (rbp tmp-ra.75 void0.4))
       (rbp
        (empty3.1
         empty2.2
         fixnum1.3
         tmp.68
         tmp.67
         rdi
         rsi
         void0.4
         r15
         rax
         tmp-ra.75))
       (rax (tmp.67 void0.4 rbp tmp-ra.75))
       (r15 (rdi rsi rbp))
       (rsi (tmp.67 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment ((tmp-ra.75 fv0) (tmp.67 fv1) (void0.4 fv2))))
    (define L.-.10
      ((locals
        (tmp.56
         tmp.77
         tmp.22
         tmp.57
         tmp.78
         tmp-ra.69
         tmp.55
         tmp.23
         tmp.76
         tmp.54))
       (conflicts
        ((tmp.54 (rbp tmp-ra.69 tmp.23 tmp.22))
         (tmp.76 (tmp.23 rbp tmp-ra.69 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.69
           tmp.22
           tmp.76
           tmp.55
           tmp.54
           tmp.77
           tmp.57
           tmp.56
           tmp.78))
         (tmp.55 (rbp tmp-ra.69 tmp.23 tmp.22))
         (tmp-ra.69
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.76
           tmp.55
           tmp.54
           tmp.77
           tmp.57
           tmp.56
           tmp.78
           rax))
         (tmp.78 (rbp tmp-ra.69 tmp.23))
         (tmp.57 (rbp tmp-ra.69 tmp.23 tmp.22))
         (tmp.22
          (tmp.23 rbp tmp-ra.69 rsi tmp.76 tmp.55 tmp.54 tmp.77 tmp.57 tmp.56))
         (tmp.77 (tmp.22 rbp tmp-ra.69 tmp.23))
         (tmp.56 (rbp tmp-ra.69 tmp.23 tmp.22))
         (rax (rbp tmp-ra.69))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.69
           tmp.76
           tmp.55
           tmp.54
           tmp.77
           tmp.57
           tmp.56
           tmp.78
           rax))
         (rdi (tmp-ra.69))
         (rsi (tmp.22 tmp-ra.69))))
       (assignment ()))
      (begin
        (set! tmp-ra.69 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.76 tmp.23)
                      (set! tmp.76 (bitwise-and tmp.76 7))
                      (set! tmp.55 tmp.76))
                    (= tmp.55 0))
                (set! tmp.54 14)
                (set! tmp.54 6))
              (!= tmp.54 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.77 tmp.22)
                        (set! tmp.77 (bitwise-and tmp.77 7))
                        (set! tmp.57 tmp.77))
                      (= tmp.57 0))
                  (set! tmp.56 14)
                  (set! tmp.56 6))
                (!= tmp.56 6))
            (begin
              (set! tmp.78 tmp.22)
              (set! tmp.78 (- tmp.78 tmp.23))
              (set! rax tmp.78)
              (jump tmp-ra.69 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.69 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.69 rbp rax)))))
    (define L.*.9
      ((locals
        (tmp.60
         tmp.80
         tmp.18
         tmp.61
         tmp.82
         tmp.62
         tmp.81
         tmp-ra.70
         tmp.59
         tmp.19
         tmp.79
         tmp.58))
       (conflicts
        ((tmp.58 (rbp tmp-ra.70 tmp.18 tmp.19))
         (tmp.79 (tmp.19 rbp tmp-ra.70 tmp.18))
         (tmp.19
          (rbp tmp-ra.70 tmp.18 tmp.79 tmp.59 tmp.58 tmp.80 tmp.61 tmp.60))
         (tmp.59 (rbp tmp-ra.70 tmp.18 tmp.19))
         (tmp-ra.70
          (tmp.19
           tmp.18
           rbp
           rsi
           rdi
           tmp.79
           tmp.59
           tmp.58
           tmp.80
           tmp.61
           tmp.60
           tmp.82
           tmp.62
           tmp.81
           rax))
         (tmp.81 (rbp tmp-ra.70 tmp.18))
         (tmp.62 (tmp.82 rbp tmp-ra.70 tmp.18))
         (tmp.82 (rbp tmp-ra.70 tmp.62))
         (tmp.61 (rbp tmp-ra.70 tmp.18 tmp.19))
         (tmp.18
          (tmp.19
           rbp
           tmp-ra.70
           rsi
           tmp.79
           tmp.59
           tmp.58
           tmp.80
           tmp.61
           tmp.60
           tmp.62
           tmp.81))
         (tmp.80 (tmp.18 rbp tmp-ra.70 tmp.19))
         (tmp.60 (rbp tmp-ra.70 tmp.18 tmp.19))
         (rax (rbp tmp-ra.70))
         (rbp
          (tmp.19
           tmp.18
           tmp-ra.70
           tmp.79
           tmp.59
           tmp.58
           tmp.80
           tmp.61
           tmp.60
           tmp.82
           tmp.62
           tmp.81
           rax))
         (rdi (tmp-ra.70))
         (rsi (tmp.18 tmp-ra.70))))
       (assignment ()))
      (begin
        (set! tmp-ra.70 r15)
        (set! tmp.18 rdi)
        (set! tmp.19 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.79 tmp.19)
                      (set! tmp.79 (bitwise-and tmp.79 7))
                      (set! tmp.59 tmp.79))
                    (= tmp.59 0))
                (set! tmp.58 14)
                (set! tmp.58 6))
              (!= tmp.58 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.80 tmp.18)
                        (set! tmp.80 (bitwise-and tmp.80 7))
                        (set! tmp.61 tmp.80))
                      (= tmp.61 0))
                  (set! tmp.60 14)
                  (set! tmp.60 6))
                (!= tmp.60 6))
            (begin
              (set! tmp.81 tmp.19)
              (set! tmp.81 (arithmetic-shift-right tmp.81 3))
              (set! tmp.62 tmp.81)
              (set! tmp.82 tmp.18)
              (set! tmp.82 (* tmp.82 tmp.62))
              (set! rax tmp.82)
              (jump tmp-ra.70 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.70 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.70 rbp rax)))))
    (define L.+.8
      ((locals
        (tmp.65
         tmp.84
         tmp.20
         tmp.66
         tmp.85
         tmp-ra.71
         tmp.64
         tmp.21
         tmp.83
         tmp.63))
       (conflicts
        ((tmp.63 (rbp tmp-ra.71 tmp.21 tmp.20))
         (tmp.83 (tmp.21 rbp tmp-ra.71 tmp.20))
         (tmp.21
          (rbp
           tmp-ra.71
           tmp.20
           tmp.83
           tmp.64
           tmp.63
           tmp.84
           tmp.66
           tmp.65
           tmp.85))
         (tmp.64 (rbp tmp-ra.71 tmp.21 tmp.20))
         (tmp-ra.71
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.83
           tmp.64
           tmp.63
           tmp.84
           tmp.66
           tmp.65
           tmp.85
           rax))
         (tmp.85 (rbp tmp-ra.71 tmp.21))
         (tmp.66 (rbp tmp-ra.71 tmp.21 tmp.20))
         (tmp.20
          (tmp.21 rbp tmp-ra.71 rsi tmp.83 tmp.64 tmp.63 tmp.84 tmp.66 tmp.65))
         (tmp.84 (tmp.20 rbp tmp-ra.71 tmp.21))
         (tmp.65 (rbp tmp-ra.71 tmp.21 tmp.20))
         (rax (rbp tmp-ra.71))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.71
           tmp.83
           tmp.64
           tmp.63
           tmp.84
           tmp.66
           tmp.65
           tmp.85
           rax))
         (rdi (tmp-ra.71))
         (rsi (tmp.20 tmp-ra.71))))
       (assignment ()))
      (begin
        (set! tmp-ra.71 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.83 tmp.21)
                      (set! tmp.83 (bitwise-and tmp.83 7))
                      (set! tmp.64 tmp.83))
                    (= tmp.64 0))
                (set! tmp.63 14)
                (set! tmp.63 6))
              (!= tmp.63 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.84 tmp.20)
                        (set! tmp.84 (bitwise-and tmp.84 7))
                        (set! tmp.66 tmp.84))
                      (= tmp.66 0))
                  (set! tmp.65 14)
                  (set! tmp.65 6))
                (!= tmp.65 6))
            (begin
              (set! tmp.85 tmp.20)
              (set! tmp.85 (+ tmp.85 tmp.21))
              (set! rax tmp.85)
              (jump tmp-ra.71 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.71 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.71 rbp rax)))))
    (define L.fun/empty9463.4
      ((locals (tmp-ra.72))
       (conflicts
        ((tmp-ra.72 (rax rbp)) (rbp (rax tmp-ra.72)) (rax (rbp tmp-ra.72))))
       (assignment ()))
      (begin (set! tmp-ra.72 r15) (set! rax 22) (jump tmp-ra.72 rbp rax)))
    (define L.fun/empty9462.5
      ((locals (tmp-ra.73))
       (conflicts
        ((tmp-ra.73 (rax rbp)) (rbp (rax tmp-ra.73)) (rax (rbp tmp-ra.73))))
       (assignment ()))
      (begin (set! tmp-ra.73 r15) (set! rax 22) (jump tmp-ra.73 rbp rax)))
    (define L.fun/void9461.6
      ((locals (tmp-ra.74))
       (conflicts
        ((tmp-ra.74 (rax rbp)) (rbp (rax tmp-ra.74)) (rax (rbp tmp-ra.74))))
       (assignment ()))
      (begin (set! tmp-ra.74 r15) (set! rax 30) (jump tmp-ra.74 rbp rax)))
    (begin
      (set! tmp-ra.75 r15)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/void9461.6 rbp r15)))
        (set! rbp (+ rbp 24)))
      (set! void0.4 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.12
          (begin
            (set! rsi 1440)
            (set! rdi 1464)
            (set! r15 L.rp.12)
            (jump L.+.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 24)))
      (set! tmp.67 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.13
          (begin
            (set! rsi 944)
            (set! rdi 1904)
            (set! r15 L.rp.13)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 24)))
      (set! tmp.68 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.14
          (begin
            (set! rsi tmp.68)
            (set! rdi tmp.67)
            (set! r15 L.rp.14)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 24)))
      (set! fixnum1.3 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty9462.5 rbp r15)))
        (set! rbp (+ rbp 24)))
      (set! empty2.2 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/empty9463.4 rbp r15)))
        (set! rbp (+ rbp 24)))
      (set! empty3.1 rax)
      (set! rax void0.4)
      (jump tmp-ra.75 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (ascii-char0.15
       fixnum1.14
       empty2.13
       void3.12
       void0.11
       error1.10
       void2.9
       boolean3.8
       tmp.70
       tmp.71
       tmp.79
       error3.4
       fixnum2.5
       empty1.6
       fixnum0.7
       tmp.78))
     (conflicts
      ((tmp.78 (rbp tmp-ra.74))
       (fixnum0.7 (rbp tmp-ra.74))
       (empty1.6 (rbp tmp-ra.74))
       (fixnum2.5 (rbp tmp-ra.74))
       (error3.4 (rbp tmp-ra.74))
       (tmp-ra.74
        (rbp
         error3.4
         fixnum2.5
         empty1.6
         fixnum0.7
         tmp.78
         rdi
         rsi
         rdx
         tmp.79
         tmp.71
         tmp.70
         tmp.69
         boolean3.8
         void2.9
         error1.10
         void0.11
         rax
         void3.12
         empty2.13
         fixnum1.14
         ascii-char0.15))
       (tmp.79 (rbp tmp-ra.74 tmp.69 tmp.70))
       (tmp.71 (rbp tmp-ra.74 tmp.69 tmp.70))
       (tmp.70 (rdx tmp.79 tmp.71 rbp tmp-ra.74 tmp.69))
       (tmp.69 (rsi rdx tmp.79 tmp.71 tmp.70 rax rbp tmp-ra.74))
       (boolean3.8 (rbp tmp-ra.74))
       (void2.9 (rbp tmp-ra.74))
       (error1.10 (rbp tmp-ra.74))
       (void0.11 (rbp tmp-ra.74))
       (void3.12 (rbp tmp-ra.74))
       (empty2.13 (rbp tmp-ra.74))
       (fixnum1.14 (rbp tmp-ra.74))
       (ascii-char0.15 (rbp tmp-ra.74))
       (rbp
        (tmp-ra.74
         error3.4
         fixnum2.5
         empty1.6
         fixnum0.7
         tmp.78
         rdx
         tmp.79
         tmp.71
         tmp.70
         r15
         rdi
         rsi
         tmp.69
         boolean3.8
         void2.9
         error1.10
         void0.11
         rax
         void3.12
         empty2.13
         fixnum1.14
         ascii-char0.15))
       (rax (tmp.69 rbp tmp-ra.74))
       (rsi (rdx tmp-ra.74 tmp.69 r15 rdi rbp))
       (rdi (rdx tmp-ra.74 r15 rbp rsi))
       (r15 (rdx rbp rdi rsi))
       (rdx (r15 rdi rsi rbp tmp-ra.74 tmp.69 tmp.70))))
     (assignment ((tmp-ra.74 fv0) (tmp.69 fv1))))
    (define L.-.6
      ((locals
        (tmp.67
         tmp.76
         tmp.33
         tmp.68
         tmp.77
         tmp-ra.72
         tmp.66
         tmp.34
         tmp.75
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.72 tmp.34 tmp.33))
         (tmp.75 (tmp.34 rbp tmp-ra.72 tmp.33))
         (tmp.34
          (rbp
           tmp-ra.72
           tmp.33
           tmp.75
           tmp.66
           tmp.65
           tmp.76
           tmp.68
           tmp.67
           tmp.77))
         (tmp.66 (rbp tmp-ra.72 tmp.34 tmp.33))
         (tmp-ra.72
          (tmp.34
           tmp.33
           rbp
           rsi
           rdi
           tmp.75
           tmp.66
           tmp.65
           tmp.76
           tmp.68
           tmp.67
           tmp.77
           rax))
         (tmp.77 (rbp tmp-ra.72 tmp.34))
         (tmp.68 (rbp tmp-ra.72 tmp.34 tmp.33))
         (tmp.33
          (tmp.34 rbp tmp-ra.72 rsi tmp.75 tmp.66 tmp.65 tmp.76 tmp.68 tmp.67))
         (tmp.76 (tmp.33 rbp tmp-ra.72 tmp.34))
         (tmp.67 (rbp tmp-ra.72 tmp.34 tmp.33))
         (rax (rbp tmp-ra.72))
         (rbp
          (tmp.34
           tmp.33
           tmp-ra.72
           tmp.75
           tmp.66
           tmp.65
           tmp.76
           tmp.68
           tmp.67
           tmp.77
           rax))
         (rdi (tmp-ra.72))
         (rsi (tmp.33 tmp-ra.72))))
       (assignment ()))
      (begin
        (set! tmp-ra.72 r15)
        (set! tmp.33 rdi)
        (set! tmp.34 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.75 tmp.34)
                      (set! tmp.75 (bitwise-and tmp.75 7))
                      (set! tmp.66 tmp.75))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.76 tmp.33)
                        (set! tmp.76 (bitwise-and tmp.76 7))
                        (set! tmp.68 tmp.76))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.77 tmp.33)
              (set! tmp.77 (- tmp.77 tmp.34))
              (set! rax tmp.77)
              (jump tmp-ra.72 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.72 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.72 rbp rax)))))
    (define L.fun/ascii-char9530.4
      ((locals (oprand2.1 oprand1.2 oprand0.3 tmp-ra.73))
       (conflicts
        ((tmp-ra.73 (rax oprand2.1 oprand1.2 oprand0.3 rbp rdx rsi rdi))
         (oprand0.3 (rbp tmp-ra.73 rdx rsi))
         (oprand1.2 (rbp tmp-ra.73 rdx))
         (oprand2.1 (rbp tmp-ra.73))
         (rdi (tmp-ra.73))
         (rsi (oprand0.3 tmp-ra.73))
         (rdx (oprand1.2 oprand0.3 tmp-ra.73))
         (rbp (rax oprand2.1 oprand1.2 oprand0.3 tmp-ra.73))
         (rax (rbp tmp-ra.73))))
       (assignment ()))
      (begin
        (set! tmp-ra.73 r15)
        (set! oprand0.3 rdi)
        (set! oprand1.2 rsi)
        (set! oprand2.1 rdx)
        (set! rax 25390)
        (jump tmp-ra.73 rbp rax)))
    (begin
      (set! tmp-ra.74 r15)
      (if (begin
            (set! fixnum0.7 1064)
            (set! empty1.6 22)
            (set! fixnum2.5 680)
            (set! error3.4 28222)
            (begin (set! tmp.78 6) (!= tmp.78 6)))
        (begin
          (set! void0.11 30)
          (set! error1.10 40510)
          (set! void2.9 30)
          (set! boolean3.8 6)
          (set! tmp.69 1440)
          (begin
            (set! rbp (- rbp 16))
            (return-point L.rp.7
              (begin
                (set! rsi 32)
                (set! rdi 1288)
                (set! r15 L.rp.7)
                (jump L.-.6 rbp r15 rdi rsi)))
            (set! rbp (+ rbp 16)))
          (set! tmp.70 rax)
          (if (begin (set! tmp.79 14) (!= tmp.79 6))
            (set! tmp.71 30)
            (set! tmp.71 30))
          (set! rdx tmp.71)
          (set! rsi tmp.70)
          (set! rdi tmp.69)
          (set! r15 tmp-ra.74)
          (jump L.fun/ascii-char9530.4 rbp r15 rdi rsi rdx))
        (begin
          (set! ascii-char0.15 25390)
          (set! fixnum1.14 1560)
          (set! empty2.13 22)
          (set! void3.12 30)
          (set! rax 25390)
          (jump tmp-ra.74 rbp rax))))))
(check-by-interp
 '(module
    ((locals (tmp.55 tmp.54 tmp-ra.50 tmp.53 tmp.52 tmp.51))
     (conflicts
      ((tmp.51 (rbp tmp-ra.50))
       (tmp.52 (rbp tmp-ra.50))
       (tmp.53 (rbp tmp-ra.50))
       (tmp-ra.50 (rbp tmp.51 tmp.52 tmp.53 tmp.54 tmp.55 rax))
       (tmp.54 (rbp tmp-ra.50))
       (tmp.55 (rbp tmp-ra.50))
       (rax (rbp tmp-ra.50))
       (rbp (tmp-ra.50 tmp.51 tmp.52 tmp.53 tmp.54 tmp.55 rax))))
     (assignment ()))
    (begin
      (set! tmp-ra.50 r15)
      (if (if (begin (set! tmp.51 14) (!= tmp.51 6))
            (begin (set! tmp.52 6) (!= tmp.52 6))
            (begin (set! tmp.53 14) (!= tmp.53 6)))
        (if (begin (set! tmp.54 6) (!= tmp.54 6))
          (begin (set! rax 46654) (jump tmp-ra.50 rbp rax))
          (begin (set! rax 42046) (jump tmp-ra.50 rbp rax)))
        (if (begin (set! tmp.55 14) (!= tmp.55 6))
          (begin (set! rax 33598) (jump tmp-ra.50 rbp rax))
          (begin (set! rax 58174) (jump tmp-ra.50 rbp rax)))))))
(check-by-interp
 '(module
    ((locals (fixnum3.1 tmp.64 error2.2 empty0.4))
     (conflicts
      ((tmp-ra.70 (fixnum3.1 tmp.64 tmp.63 error2.2 void1.3 empty0.4 rax rbp))
       (empty0.4 (rbp tmp-ra.70))
       (void1.3 (fixnum3.1 tmp.64 tmp.63 error2.2 rax rbp tmp-ra.70))
       (error2.2 (rbp tmp-ra.70 void1.3))
       (tmp.63 (rsi tmp.64 rax rbp tmp-ra.70 void1.3))
       (tmp.64 (rbp tmp-ra.70 void1.3 tmp.63))
       (fixnum3.1 (rbp tmp-ra.70 void1.3))
       (rbp
        (fixnum3.1
         tmp.64
         tmp.63
         rdi
         rsi
         error2.2
         void1.3
         empty0.4
         r15
         rax
         tmp-ra.70))
       (rax (tmp.63 void1.3 rbp tmp-ra.70))
       (r15 (rdi rsi rbp))
       (rsi (tmp.63 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment ((tmp-ra.70 fv0) (void1.3 fv1) (tmp.63 fv2))))
    (define L.*.9
      ((locals
        (tmp.56
         tmp.72
         tmp.18
         tmp.57
         tmp.74
         tmp.58
         tmp.73
         tmp-ra.65
         tmp.55
         tmp.19
         tmp.71
         tmp.54))
       (conflicts
        ((tmp.54 (rbp tmp-ra.65 tmp.18 tmp.19))
         (tmp.71 (tmp.19 rbp tmp-ra.65 tmp.18))
         (tmp.19
          (rbp tmp-ra.65 tmp.18 tmp.71 tmp.55 tmp.54 tmp.72 tmp.57 tmp.56))
         (tmp.55 (rbp tmp-ra.65 tmp.18 tmp.19))
         (tmp-ra.65
          (tmp.19
           tmp.18
           rbp
           rsi
           rdi
           tmp.71
           tmp.55
           tmp.54
           tmp.72
           tmp.57
           tmp.56
           tmp.74
           tmp.58
           tmp.73
           rax))
         (tmp.73 (rbp tmp-ra.65 tmp.18))
         (tmp.58 (tmp.74 rbp tmp-ra.65 tmp.18))
         (tmp.74 (rbp tmp-ra.65 tmp.58))
         (tmp.57 (rbp tmp-ra.65 tmp.18 tmp.19))
         (tmp.18
          (tmp.19
           rbp
           tmp-ra.65
           rsi
           tmp.71
           tmp.55
           tmp.54
           tmp.72
           tmp.57
           tmp.56
           tmp.58
           tmp.73))
         (tmp.72 (tmp.18 rbp tmp-ra.65 tmp.19))
         (tmp.56 (rbp tmp-ra.65 tmp.18 tmp.19))
         (rax (rbp tmp-ra.65))
         (rbp
          (tmp.19
           tmp.18
           tmp-ra.65
           tmp.71
           tmp.55
           tmp.54
           tmp.72
           tmp.57
           tmp.56
           tmp.74
           tmp.58
           tmp.73
           rax))
         (rdi (tmp-ra.65))
         (rsi (tmp.18 tmp-ra.65))))
       (assignment ()))
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
      ((locals
        (tmp.61
         tmp.76
         tmp.22
         tmp.62
         tmp.77
         tmp-ra.66
         tmp.60
         tmp.23
         tmp.75
         tmp.59))
       (conflicts
        ((tmp.59 (rbp tmp-ra.66 tmp.23 tmp.22))
         (tmp.75 (tmp.23 rbp tmp-ra.66 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.66
           tmp.22
           tmp.75
           tmp.60
           tmp.59
           tmp.76
           tmp.62
           tmp.61
           tmp.77))
         (tmp.60 (rbp tmp-ra.66 tmp.23 tmp.22))
         (tmp-ra.66
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.75
           tmp.60
           tmp.59
           tmp.76
           tmp.62
           tmp.61
           tmp.77
           rax))
         (tmp.77 (rbp tmp-ra.66 tmp.23))
         (tmp.62 (rbp tmp-ra.66 tmp.23 tmp.22))
         (tmp.22
          (tmp.23 rbp tmp-ra.66 rsi tmp.75 tmp.60 tmp.59 tmp.76 tmp.62 tmp.61))
         (tmp.76 (tmp.22 rbp tmp-ra.66 tmp.23))
         (tmp.61 (rbp tmp-ra.66 tmp.23 tmp.22))
         (rax (rbp tmp-ra.66))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.66
           tmp.75
           tmp.60
           tmp.59
           tmp.76
           tmp.62
           tmp.61
           tmp.77
           rax))
         (rdi (tmp-ra.66))
         (rsi (tmp.22 tmp-ra.66))))
       (assignment ()))
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
    (define L.fun/error9595.4
      ((locals (tmp-ra.67))
       (conflicts
        ((tmp-ra.67 (rax rbp)) (rbp (rax tmp-ra.67)) (rax (rbp tmp-ra.67))))
       (assignment ()))
      (begin (set! tmp-ra.67 r15) (set! rax 9022) (jump tmp-ra.67 rbp rax)))
    (define L.fun/void9594.5
      ((locals (tmp-ra.68))
       (conflicts
        ((tmp-ra.68 (rax rbp)) (rbp (rax tmp-ra.68)) (rax (rbp tmp-ra.68))))
       (assignment ()))
      (begin (set! tmp-ra.68 r15) (set! rax 30) (jump tmp-ra.68 rbp rax)))
    (define L.fun/empty9593.6
      ((locals (tmp-ra.69))
       (conflicts
        ((tmp-ra.69 (rax rbp)) (rbp (rax tmp-ra.69)) (rax (rbp tmp-ra.69))))
       (assignment ()))
      (begin (set! tmp-ra.69 r15) (set! rax 22) (jump tmp-ra.69 rbp rax)))
    (begin
      (set! tmp-ra.70 r15)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/empty9593.6 rbp r15)))
        (set! rbp (+ rbp 24)))
      (set! empty0.4 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/void9594.5 rbp r15)))
        (set! rbp (+ rbp 24)))
      (set! void1.3 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error9595.4 rbp r15)))
        (set! rbp (+ rbp 24)))
      (set! error2.2 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.13
          (begin
            (set! rsi 1392)
            (set! rdi 1368)
            (set! r15 L.rp.13)
            (jump L.-.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 24)))
      (set! tmp.63 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.14
          (begin
            (set! rsi 400)
            (set! rdi 1288)
            (set! r15 L.rp.14)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 24)))
      (set! tmp.64 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.15
          (begin
            (set! rsi tmp.64)
            (set! rdi tmp.63)
            (set! r15 L.rp.15)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 24)))
      (set! fixnum3.1 rax)
      (set! rax void1.3)
      (jump tmp-ra.70 rbp rax))))
(check-by-interp
 '(module
    ((locals (error3.1 error2.2 boolean1.3 tmp.55 error0.4))
     (conflicts
      ((tmp-ra.62 (error3.1 error2.2 boolean1.3 tmp.55 error0.4 rax rbp))
       (error0.4 (rbp tmp-ra.62))
       (tmp.55 (rbp tmp-ra.62))
       (boolean1.3 (rbp tmp-ra.62))
       (error2.2 (rbp tmp-ra.62))
       (error3.1 (rbp tmp-ra.62))
       (rbp
        (error3.1 error2.2 boolean1.3 rdi tmp.55 error0.4 r15 rax tmp-ra.62))
       (rax (rbp tmp-ra.62))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment ((tmp-ra.62 fv0))))
    (define L.void?.10
      ((locals (tmp-ra.56 tmp.63 tmp.44 tmp.54))
       (conflicts
        ((tmp.54 (rbp tmp-ra.56))
         (tmp.44 (rbp tmp-ra.56))
         (tmp.63 (rbp tmp-ra.56))
         (tmp-ra.56 (tmp.44 rbp rdi tmp.63 tmp.54 rax))
         (rax (rbp tmp-ra.56))
         (rbp (tmp.44 tmp-ra.56 tmp.63 tmp.54 rax))
         (rdi (tmp-ra.56))))
       (assignment ()))
      (begin
        (set! tmp-ra.56 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.63 tmp.44)
                (set! tmp.63 (bitwise-and tmp.63 255))
                (set! tmp.54 tmp.63))
              (= tmp.54 30))
          (begin (set! rax 14) (jump tmp-ra.56 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.56 rbp rax)))))
    (define L.fun/error9648.4
      ((locals (tmp-ra.57))
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57))))
       (assignment ()))
      (begin (set! tmp-ra.57 r15) (set! rax 2622) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error9646.5
      ((locals (tmp-ra.58))
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ()))
      (begin (set! tmp-ra.58 r15) (set! rax 58430) (jump tmp-ra.58 rbp rax)))
    (define L.fun/any9647.6
      ((locals (tmp-ra.59))
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ()))
      (begin (set! tmp-ra.59 r15) (set! rax 6) (jump tmp-ra.59 rbp rax)))
    (define L.fun/error9649.7
      ((locals (tmp-ra.60))
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60))))
       (assignment ()))
      (begin (set! tmp-ra.60 r15) (set! rax 28222) (jump tmp-ra.60 rbp rax)))
    (define L.fun/void9650.8
      ((locals (tmp-ra.61))
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ()))
      (begin (set! tmp-ra.61 r15) (set! rax 30) (jump tmp-ra.61 rbp rax)))
    (begin
      (set! tmp-ra.62 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/error9646.5 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error0.4 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/any9647.6 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! tmp.55 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin
            (set! rdi tmp.55)
            (set! r15 L.rp.13)
            (jump L.void?.10 rbp r15 rdi)))
        (set! rbp (+ rbp 8)))
      (set! boolean1.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error9648.4 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error2.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/error9649.7 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error3.1 rax)
      (set! r15 tmp-ra.62)
      (jump L.fun/void9650.8 rbp r15))))
(check-by-interp
 '(module
    ((locals (void4.1 error3.2 void2.3 boolean1.4 tmp.56 ascii-char0.5))
     (conflicts
      ((tmp-ra.63
        (void4.1 error3.2 void2.3 boolean1.4 tmp.56 ascii-char0.5 rax rbp))
       (ascii-char0.5 (rbp tmp-ra.63))
       (tmp.56 (rbp tmp-ra.63))
       (boolean1.4 (rbp tmp-ra.63))
       (void2.3 (rbp tmp-ra.63))
       (error3.2 (rbp tmp-ra.63))
       (void4.1 (rbp tmp-ra.63))
       (rbp
        (void4.1
         error3.2
         void2.3
         boolean1.4
         rdi
         tmp.56
         ascii-char0.5
         r15
         rax
         tmp-ra.63))
       (rax (rbp tmp-ra.63))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment ((tmp-ra.63 fv0))))
    (define L.ascii-char?.10
      ((locals (tmp-ra.57 tmp.64 tmp.46 tmp.55))
       (conflicts
        ((tmp.55 (rbp tmp-ra.57))
         (tmp.46 (rbp tmp-ra.57))
         (tmp.64 (rbp tmp-ra.57))
         (tmp-ra.57 (tmp.46 rbp rdi tmp.64 tmp.55 rax))
         (rax (rbp tmp-ra.57))
         (rbp (tmp.46 tmp-ra.57 tmp.64 tmp.55 rax))
         (rdi (tmp-ra.57))))
       (assignment ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.64 tmp.46)
                (set! tmp.64 (bitwise-and tmp.64 255))
                (set! tmp.55 tmp.64))
              (= tmp.55 46))
          (begin (set! rax 14) (jump tmp-ra.57 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.57 rbp rax)))))
    (define L.fun/error10696.4
      ((locals (tmp-ra.58))
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ()))
      (begin (set! tmp-ra.58 r15) (set! rax 55102) (jump tmp-ra.58 rbp rax)))
    (define L.fun/ascii-char10693.5
      ((locals (tmp-ra.59))
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ()))
      (begin (set! tmp-ra.59 r15) (set! rax 25390) (jump tmp-ra.59 rbp rax)))
    (define L.fun/void10697.6
      ((locals (tmp-ra.60))
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60))))
       (assignment ()))
      (begin (set! tmp-ra.60 r15) (set! rax 30) (jump tmp-ra.60 rbp rax)))
    (define L.fun/any10694.7
      ((locals (tmp-ra.61))
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ()))
      (begin (set! tmp-ra.61 r15) (set! rax 22) (jump tmp-ra.61 rbp rax)))
    (define L.fun/void10695.8
      ((locals (tmp-ra.62))
       (conflicts
        ((tmp-ra.62 (rax rbp)) (rbp (rax tmp-ra.62)) (rax (rbp tmp-ra.62))))
       (assignment ()))
      (begin (set! tmp-ra.62 r15) (set! rax 30) (jump tmp-ra.62 rbp rax)))
    (begin
      (set! tmp-ra.63 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char10693.5 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char0.5 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/any10694.7 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! tmp.56 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin
            (set! rdi tmp.56)
            (set! r15 L.rp.13)
            (jump L.ascii-char?.10 rbp r15 rdi)))
        (set! rbp (+ rbp 8)))
      (set! boolean1.4 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void10695.8 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! void2.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/error10696.4 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error3.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void10697.6 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! void4.1 rax)
      (set! rax void4.1)
      (jump tmp-ra.63 rbp rax))))
(check-by-interp
 '(module
    ((locals (error4.1 ascii-char3.2 error1.4 error0.5))
     (conflicts
      ((tmp-ra.60 (error4.1 ascii-char3.2 empty2.3 error1.4 error0.5 rax rbp))
       (error0.5 (rbp tmp-ra.60))
       (error1.4 (rbp tmp-ra.60))
       (empty2.3 (error4.1 ascii-char3.2 rax rbp tmp-ra.60))
       (ascii-char3.2 (rbp tmp-ra.60 empty2.3))
       (error4.1 (rbp tmp-ra.60 empty2.3))
       (rbp
        (error4.1 ascii-char3.2 empty2.3 error1.4 error0.5 r15 rax tmp-ra.60))
       (rax (empty2.3 rbp tmp-ra.60))
       (r15 (rbp))))
     (assignment ((tmp-ra.60 fv0) (empty2.3 fv1))))
    (define L.fun/empty12161.4
      ((locals (tmp-ra.55))
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55))))
       (assignment ()))
      (begin (set! tmp-ra.55 r15) (set! rax 22) (jump tmp-ra.55 rbp rax)))
    (define L.fun/error12159.5
      ((locals (tmp-ra.56))
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56))))
       (assignment ()))
      (begin (set! tmp-ra.56 r15) (set! rax 1854) (jump tmp-ra.56 rbp rax)))
    (define L.fun/ascii-char12162.6
      ((locals (tmp-ra.57))
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57))))
       (assignment ()))
      (begin (set! tmp-ra.57 r15) (set! rax 25390) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error12163.7
      ((locals (tmp-ra.58))
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ()))
      (begin (set! tmp-ra.58 r15) (set! rax 10814) (jump tmp-ra.58 rbp rax)))
    (define L.fun/error12160.8
      ((locals (tmp-ra.59))
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ()))
      (begin (set! tmp-ra.59 r15) (set! rax 27198) (jump tmp-ra.59 rbp rax)))
    (begin
      (set! tmp-ra.60 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/error12159.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error0.5 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/error12160.8 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error1.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty12161.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty2.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/ascii-char12162.6 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char3.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error12163.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error4.1 rax)
      (set! rax empty2.3)
      (jump tmp-ra.60 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (error4.1
       error3.2
       fixnum2.3
       tmp.73
       tmp.75
       tmp.72
       boolean1.4
       tmp.69
       void0.5))
     (conflicts
      ((tmp-ra.84
        (error4.1
         error3.2
         fixnum2.3
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         boolean1.4
         tmp.69
         void0.5
         rax
         rbp))
       (void0.5 (rbp tmp-ra.84))
       (tmp.69 (rbp tmp-ra.84))
       (boolean1.4 (rbp tmp-ra.84))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.84))
       (tmp.72 (rbp tmp-ra.84 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.84))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.84 tmp.70))
       (tmp.75 (rbp tmp-ra.84 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.84 tmp.70))
       (fixnum2.3 (rbp tmp-ra.84))
       (error3.2 (rbp tmp-ra.84))
       (error4.1 (rbp tmp-ra.84))
       (rbp
        (error4.1
         error3.2
         fixnum2.3
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         rsi
         boolean1.4
         rdi
         tmp.69
         void0.5
         r15
         rax
         tmp-ra.84))
       (rax (tmp.74 tmp.70 tmp.71 rbp tmp-ra.84))
       (r15 (rsi rdi rbp))
       (rdi (rsi r15 rbp))
       (rsi (tmp.70 tmp.74 tmp.71 r15 rdi rbp))))
     (assignment ((tmp-ra.84 fv0) (tmp.71 fv1) (tmp.70 fv1) (tmp.74 fv2))))
    (define L.-.12
      ((locals
        (tmp.57
         tmp.86
         tmp.23
         tmp.58
         tmp.87
         tmp-ra.76
         tmp.56
         tmp.24
         tmp.85
         tmp.55))
       (conflicts
        ((tmp.55 (rbp tmp-ra.76 tmp.24 tmp.23))
         (tmp.85 (tmp.24 rbp tmp-ra.76 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.76
           tmp.23
           tmp.85
           tmp.56
           tmp.55
           tmp.86
           tmp.58
           tmp.57
           tmp.87))
         (tmp.56 (rbp tmp-ra.76 tmp.24 tmp.23))
         (tmp-ra.76
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.85
           tmp.56
           tmp.55
           tmp.86
           tmp.58
           tmp.57
           tmp.87
           rax))
         (tmp.87 (rbp tmp-ra.76 tmp.24))
         (tmp.58 (rbp tmp-ra.76 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.76 rsi tmp.85 tmp.56 tmp.55 tmp.86 tmp.58 tmp.57))
         (tmp.86 (tmp.23 rbp tmp-ra.76 tmp.24))
         (tmp.57 (rbp tmp-ra.76 tmp.24 tmp.23))
         (rax (rbp tmp-ra.76))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.76
           tmp.85
           tmp.56
           tmp.55
           tmp.86
           tmp.58
           tmp.57
           tmp.87
           rax))
         (rdi (tmp-ra.76))
         (rsi (tmp.23 tmp-ra.76))))
       (assignment ()))
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
    (define L.+.11
      ((locals
        (tmp.61
         tmp.89
         tmp.21
         tmp.62
         tmp.90
         tmp-ra.77
         tmp.60
         tmp.22
         tmp.88
         tmp.59))
       (conflicts
        ((tmp.59 (rbp tmp-ra.77 tmp.22 tmp.21))
         (tmp.88 (tmp.22 rbp tmp-ra.77 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.77
           tmp.21
           tmp.88
           tmp.60
           tmp.59
           tmp.89
           tmp.62
           tmp.61
           tmp.90))
         (tmp.60 (rbp tmp-ra.77 tmp.22 tmp.21))
         (tmp-ra.77
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.88
           tmp.60
           tmp.59
           tmp.89
           tmp.62
           tmp.61
           tmp.90
           rax))
         (tmp.90 (rbp tmp-ra.77 tmp.22))
         (tmp.62 (rbp tmp-ra.77 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.77 rsi tmp.88 tmp.60 tmp.59 tmp.89 tmp.62 tmp.61))
         (tmp.89 (tmp.21 rbp tmp-ra.77 tmp.22))
         (tmp.61 (rbp tmp-ra.77 tmp.22 tmp.21))
         (rax (rbp tmp-ra.77))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.77
           tmp.88
           tmp.60
           tmp.59
           tmp.89
           tmp.62
           tmp.61
           tmp.90
           rax))
         (rdi (tmp-ra.77))
         (rsi (tmp.21 tmp-ra.77))))
       (assignment ()))
      (begin
        (set! tmp-ra.77 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.88 tmp.22)
                      (set! tmp.88 (bitwise-and tmp.88 7))
                      (set! tmp.60 tmp.88))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.89 tmp.21)
                        (set! tmp.89 (bitwise-and tmp.89 7))
                        (set! tmp.62 tmp.89))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.90 tmp.21)
              (set! tmp.90 (+ tmp.90 tmp.22))
              (set! rax tmp.90)
              (jump tmp-ra.77 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.77 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.77 rbp rax)))))
    (define L.*.10
      ((locals
        (tmp.65
         tmp.92
         tmp.19
         tmp.66
         tmp.94
         tmp.67
         tmp.93
         tmp-ra.78
         tmp.64
         tmp.20
         tmp.91
         tmp.63))
       (conflicts
        ((tmp.63 (rbp tmp-ra.78 tmp.19 tmp.20))
         (tmp.91 (tmp.20 rbp tmp-ra.78 tmp.19))
         (tmp.20
          (rbp tmp-ra.78 tmp.19 tmp.91 tmp.64 tmp.63 tmp.92 tmp.66 tmp.65))
         (tmp.64 (rbp tmp-ra.78 tmp.19 tmp.20))
         (tmp-ra.78
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.91
           tmp.64
           tmp.63
           tmp.92
           tmp.66
           tmp.65
           tmp.94
           tmp.67
           tmp.93
           rax))
         (tmp.93 (rbp tmp-ra.78 tmp.19))
         (tmp.67 (tmp.94 rbp tmp-ra.78 tmp.19))
         (tmp.94 (rbp tmp-ra.78 tmp.67))
         (tmp.66 (rbp tmp-ra.78 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.78
           rsi
           tmp.91
           tmp.64
           tmp.63
           tmp.92
           tmp.66
           tmp.65
           tmp.67
           tmp.93))
         (tmp.92 (tmp.19 rbp tmp-ra.78 tmp.20))
         (tmp.65 (rbp tmp-ra.78 tmp.19 tmp.20))
         (rax (rbp tmp-ra.78))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.78
           tmp.91
           tmp.64
           tmp.63
           tmp.92
           tmp.66
           tmp.65
           tmp.94
           tmp.67
           tmp.93
           rax))
         (rdi (tmp-ra.78))
         (rsi (tmp.19 tmp-ra.78))))
       (assignment ()))
      (begin
        (set! tmp-ra.78 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.91 tmp.20)
                      (set! tmp.91 (bitwise-and tmp.91 7))
                      (set! tmp.64 tmp.91))
                    (= tmp.64 0))
                (set! tmp.63 14)
                (set! tmp.63 6))
              (!= tmp.63 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.92 tmp.19)
                        (set! tmp.92 (bitwise-and tmp.92 7))
                        (set! tmp.66 tmp.92))
                      (= tmp.66 0))
                  (set! tmp.65 14)
                  (set! tmp.65 6))
                (!= tmp.65 6))
            (begin
              (set! tmp.93 tmp.20)
              (set! tmp.93 (arithmetic-shift-right tmp.93 3))
              (set! tmp.67 tmp.93)
              (set! tmp.94 tmp.19)
              (set! tmp.94 (* tmp.94 tmp.67))
              (set! rax tmp.94)
              (jump tmp-ra.78 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.78 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.78 rbp rax)))))
    (define L.empty?.9
      ((locals (tmp-ra.79 tmp.95 tmp.44 tmp.68))
       (conflicts
        ((tmp.68 (rbp tmp-ra.79))
         (tmp.44 (rbp tmp-ra.79))
         (tmp.95 (rbp tmp-ra.79))
         (tmp-ra.79 (tmp.44 rbp rdi tmp.95 tmp.68 rax))
         (rax (rbp tmp-ra.79))
         (rbp (tmp.44 tmp-ra.79 tmp.95 tmp.68 rax))
         (rdi (tmp-ra.79))))
       (assignment ()))
      (begin
        (set! tmp-ra.79 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.95 tmp.44)
                (set! tmp.95 (bitwise-and tmp.95 255))
                (set! tmp.68 tmp.95))
              (= tmp.68 22))
          (begin (set! rax 14) (jump tmp-ra.79 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.79 rbp rax)))))
    (define L.fun/void12536.4
      ((locals (tmp-ra.80))
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80))))
       (assignment ()))
      (begin (set! tmp-ra.80 r15) (set! rax 30) (jump tmp-ra.80 rbp rax)))
    (define L.fun/any12537.5
      ((locals (tmp-ra.81))
       (conflicts
        ((tmp-ra.81 (rax rbp)) (rbp (rax tmp-ra.81)) (rax (rbp tmp-ra.81))))
       (assignment ()))
      (begin (set! tmp-ra.81 r15) (set! rax 22) (jump tmp-ra.81 rbp rax)))
    (define L.fun/error12539.6
      ((locals (tmp-ra.82))
       (conflicts
        ((tmp-ra.82 (rax rbp)) (rbp (rax tmp-ra.82)) (rax (rbp tmp-ra.82))))
       (assignment ()))
      (begin (set! tmp-ra.82 r15) (set! rax 29502) (jump tmp-ra.82 rbp rax)))
    (define L.fun/error12538.7
      ((locals (tmp-ra.83))
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83))))
       (assignment ()))
      (begin (set! tmp-ra.83 r15) (set! rax 24894) (jump tmp-ra.83 rbp rax)))
    (begin
      (set! tmp-ra.84 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void12536.4 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! void0.5 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/any12537.5 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin
            (set! rdi tmp.69)
            (set! r15 L.rp.15)
            (jump L.empty?.9 rbp r15 rdi)))
        (set! rbp (+ rbp 32)))
      (set! boolean1.4 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 384)
            (set! rdi 784)
            (set! r15 L.rp.16)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 912)
            (set! rdi 104)
            (set! r15 L.rp.17)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.18)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1288)
            (set! rdi 1776)
            (set! r15 L.rp.19)
            (jump L.-.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi 760)
            (set! rdi 792)
            (set! r15 L.rp.20)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.21)
            (jump L.-.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.22)
            (jump L.-.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! fixnum2.3 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error12538.7 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! error3.2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/error12539.6 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! error4.1 rax)
      (set! rax error4.1)
      (jump tmp-ra.84 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (empty4.1
       boolean3.2
       tmp.81
       fixnum2.3
       tmp.78
       tmp.80
       tmp.77
       error1.4
       fixnum0.5
       tmp.72
       tmp.74
       tmp.71))
     (conflicts
      ((tmp-ra.90
        (empty4.1
         boolean3.2
         tmp.81
         fixnum2.3
         tmp.78
         tmp.80
         tmp.79
         tmp.75
         tmp.77
         tmp.76
         error1.4
         fixnum0.5
         tmp.72
         tmp.74
         tmp.73
         tmp.69
         tmp.71
         tmp.70
         rax
         rbp))
       (tmp.70 (rsi tmp.71 rax rbp tmp-ra.90))
       (tmp.71 (rbp tmp-ra.90 tmp.70))
       (tmp.69 (rsi tmp.72 tmp.74 tmp.73 rax rbp tmp-ra.90))
       (tmp.73 (rsi tmp.74 rax rbp tmp-ra.90 tmp.69))
       (tmp.74 (rbp tmp-ra.90 tmp.69 tmp.73))
       (tmp.72 (rbp tmp-ra.90 tmp.69))
       (fixnum0.5 (rbp tmp-ra.90))
       (error1.4 (rbp tmp-ra.90))
       (tmp.76 (rsi tmp.77 rax rbp tmp-ra.90))
       (tmp.77 (rbp tmp-ra.90 tmp.76))
       (tmp.75 (rsi tmp.78 tmp.80 tmp.79 rax rbp tmp-ra.90))
       (tmp.79 (rsi tmp.80 rax rbp tmp-ra.90 tmp.75))
       (tmp.80 (rbp tmp-ra.90 tmp.75 tmp.79))
       (tmp.78 (rbp tmp-ra.90 tmp.75))
       (fixnum2.3 (rbp tmp-ra.90))
       (tmp.81 (rbp tmp-ra.90))
       (boolean3.2 (rbp tmp-ra.90))
       (empty4.1 (rbp tmp-ra.90))
       (rbp
        (empty4.1
         boolean3.2
         tmp.81
         fixnum2.3
         tmp.78
         tmp.80
         tmp.79
         tmp.75
         tmp.77
         tmp.76
         error1.4
         fixnum0.5
         tmp.72
         tmp.74
         tmp.73
         tmp.69
         tmp.71
         tmp.70
         r15
         rdi
         rsi
         rax
         tmp-ra.90))
       (rax (tmp.79 tmp.75 tmp.76 tmp.73 tmp.69 tmp.70 rbp tmp-ra.90))
       (rsi (tmp.75 tmp.79 tmp.76 tmp.69 tmp.73 tmp.70 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.90 fv0)
       (tmp.73 fv1)
       (tmp.79 fv1)
       (tmp.75 fv2)
       (tmp.76 fv1)
       (tmp.69 fv2)
       (tmp.70 fv1))))
    (define L.pair?.12
      ((locals (tmp-ra.82 tmp.91 tmp.48 tmp.55))
       (conflicts
        ((tmp.55 (rbp tmp-ra.82))
         (tmp.48 (rbp tmp-ra.82))
         (tmp.91 (rbp tmp-ra.82))
         (tmp-ra.82 (tmp.48 rbp rdi tmp.91 tmp.55 rax))
         (rax (rbp tmp-ra.82))
         (rbp (tmp.48 tmp-ra.82 tmp.91 tmp.55 rax))
         (rdi (tmp-ra.82))))
       (assignment ()))
      (begin
        (set! tmp-ra.82 r15)
        (set! tmp.48 rdi)
        (if (begin
              (begin
                (set! tmp.91 tmp.48)
                (set! tmp.91 (bitwise-and tmp.91 7))
                (set! tmp.55 tmp.91))
              (= tmp.55 1))
          (begin (set! rax 14) (jump tmp-ra.82 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.82 rbp rax)))))
    (define L.+.11
      ((locals
        (tmp.58
         tmp.93
         tmp.21
         tmp.59
         tmp.94
         tmp-ra.83
         tmp.57
         tmp.22
         tmp.92
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.83 tmp.22 tmp.21))
         (tmp.92 (tmp.22 rbp tmp-ra.83 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.83
           tmp.21
           tmp.92
           tmp.57
           tmp.56
           tmp.93
           tmp.59
           tmp.58
           tmp.94))
         (tmp.57 (rbp tmp-ra.83 tmp.22 tmp.21))
         (tmp-ra.83
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.92
           tmp.57
           tmp.56
           tmp.93
           tmp.59
           tmp.58
           tmp.94
           rax))
         (tmp.94 (rbp tmp-ra.83 tmp.22))
         (tmp.59 (rbp tmp-ra.83 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.83 rsi tmp.92 tmp.57 tmp.56 tmp.93 tmp.59 tmp.58))
         (tmp.93 (tmp.21 rbp tmp-ra.83 tmp.22))
         (tmp.58 (rbp tmp-ra.83 tmp.22 tmp.21))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.83
           tmp.92
           tmp.57
           tmp.56
           tmp.93
           tmp.59
           tmp.58
           tmp.94
           rax))
         (rdi (tmp-ra.83))
         (rsi (tmp.21 tmp-ra.83))))
       (assignment ()))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.92 tmp.22)
                      (set! tmp.92 (bitwise-and tmp.92 7))
                      (set! tmp.57 tmp.92))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.93 tmp.21)
                        (set! tmp.93 (bitwise-and tmp.93 7))
                        (set! tmp.59 tmp.93))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.94 tmp.21)
              (set! tmp.94 (+ tmp.94 tmp.22))
              (set! rax tmp.94)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.83 rbp rax)))))
    (define L.-.10
      ((locals
        (tmp.62
         tmp.96
         tmp.23
         tmp.63
         tmp.97
         tmp-ra.84
         tmp.61
         tmp.24
         tmp.95
         tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.84 tmp.24 tmp.23))
         (tmp.95 (tmp.24 rbp tmp-ra.84 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.84
           tmp.23
           tmp.95
           tmp.61
           tmp.60
           tmp.96
           tmp.63
           tmp.62
           tmp.97))
         (tmp.61 (rbp tmp-ra.84 tmp.24 tmp.23))
         (tmp-ra.84
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.95
           tmp.61
           tmp.60
           tmp.96
           tmp.63
           tmp.62
           tmp.97
           rax))
         (tmp.97 (rbp tmp-ra.84 tmp.24))
         (tmp.63 (rbp tmp-ra.84 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.84 rsi tmp.95 tmp.61 tmp.60 tmp.96 tmp.63 tmp.62))
         (tmp.96 (tmp.23 rbp tmp-ra.84 tmp.24))
         (tmp.62 (rbp tmp-ra.84 tmp.24 tmp.23))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.84
           tmp.95
           tmp.61
           tmp.60
           tmp.96
           tmp.63
           tmp.62
           tmp.97
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.23 tmp-ra.84))))
       (assignment ()))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.95 tmp.24)
                      (set! tmp.95 (bitwise-and tmp.95 7))
                      (set! tmp.61 tmp.95))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.96 tmp.23)
                        (set! tmp.96 (bitwise-and tmp.96 7))
                        (set! tmp.63 tmp.96))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.97 tmp.23)
              (set! tmp.97 (- tmp.97 tmp.24))
              (set! rax tmp.97)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.84 rbp rax)))))
    (define L.*.9
      ((locals
        (tmp.66
         tmp.99
         tmp.19
         tmp.67
         tmp.101
         tmp.68
         tmp.100
         tmp-ra.85
         tmp.65
         tmp.20
         tmp.98
         tmp.64))
       (conflicts
        ((tmp.64 (rbp tmp-ra.85 tmp.19 tmp.20))
         (tmp.98 (tmp.20 rbp tmp-ra.85 tmp.19))
         (tmp.20
          (rbp tmp-ra.85 tmp.19 tmp.98 tmp.65 tmp.64 tmp.99 tmp.67 tmp.66))
         (tmp.65 (rbp tmp-ra.85 tmp.19 tmp.20))
         (tmp-ra.85
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.98
           tmp.65
           tmp.64
           tmp.99
           tmp.67
           tmp.66
           tmp.101
           tmp.68
           tmp.100
           rax))
         (tmp.100 (rbp tmp-ra.85 tmp.19))
         (tmp.68 (tmp.101 rbp tmp-ra.85 tmp.19))
         (tmp.101 (rbp tmp-ra.85 tmp.68))
         (tmp.67 (rbp tmp-ra.85 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.85
           rsi
           tmp.98
           tmp.65
           tmp.64
           tmp.99
           tmp.67
           tmp.66
           tmp.68
           tmp.100))
         (tmp.99 (tmp.19 rbp tmp-ra.85 tmp.20))
         (tmp.66 (rbp tmp-ra.85 tmp.19 tmp.20))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.85
           tmp.98
           tmp.65
           tmp.64
           tmp.99
           tmp.67
           tmp.66
           tmp.101
           tmp.68
           tmp.100
           rax))
         (rdi (tmp-ra.85))
         (rsi (tmp.19 tmp-ra.85))))
       (assignment ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.98 tmp.20)
                      (set! tmp.98 (bitwise-and tmp.98 7))
                      (set! tmp.65 tmp.98))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.99 tmp.19)
                        (set! tmp.99 (bitwise-and tmp.99 7))
                        (set! tmp.67 tmp.99))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.100 tmp.20)
              (set! tmp.100 (arithmetic-shift-right tmp.100 3))
              (set! tmp.68 tmp.100)
              (set! tmp.101 tmp.19)
              (set! tmp.101 (* tmp.101 tmp.68))
              (set! rax tmp.101)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/any13289.4
      ((locals (tmp-ra.86))
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86))))
       (assignment ()))
      (begin (set! tmp-ra.86 r15) (set! rax 6) (jump tmp-ra.86 rbp rax)))
    (define L.fun/empty13290.5
      ((locals (tmp-ra.87))
       (conflicts
        ((tmp-ra.87 (rax rbp)) (rbp (rax tmp-ra.87)) (rax (rbp tmp-ra.87))))
       (assignment ()))
      (begin (set! tmp-ra.87 r15) (set! rax 22) (jump tmp-ra.87 rbp rax)))
    (define L.fun/error13288.6
      ((locals (tmp-ra.88))
       (conflicts
        ((tmp-ra.88 (rax rbp)) (rbp (rax tmp-ra.88)) (rax (rbp tmp-ra.88))))
       (assignment ()))
      (begin (set! tmp-ra.88 r15) (set! rax 48958) (jump tmp-ra.88 rbp rax)))
    (define L.fun/ascii-char13291.7
      ((locals (tmp-ra.89))
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89))))
       (assignment ()))
      (begin (set! tmp-ra.89 r15) (set! rax 25390) (jump tmp-ra.89 rbp rax)))
    (begin
      (set! tmp-ra.90 r15)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.13
          (begin
            (set! rsi 1576)
            (set! rdi 1360)
            (set! r15 L.rp.13)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.14
          (begin
            (set! rsi 296)
            (set! rdi 1888)
            (set! r15 L.rp.14)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.15
          (begin
            (set! rsi tmp.71)
            (set! rdi tmp.70)
            (set! r15 L.rp.15)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.16
          (begin
            (set! rsi 1808)
            (set! rdi 1880)
            (set! r15 L.rp.16)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.17
          (begin
            (set! rsi 704)
            (set! rdi 2008)
            (set! r15 L.rp.17)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.74)
            (set! rdi tmp.73)
            (set! r15 L.rp.18)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.69)
            (set! r15 L.rp.19)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! fixnum0.5 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error13288.6 rbp r15)))
        (set! rbp (+ rbp 56)))
      (set! error1.4 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.21
          (begin
            (set! rsi 1192)
            (set! rdi 1488)
            (set! r15 L.rp.21)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.22
          (begin
            (set! rsi 1480)
            (set! rdi 1160)
            (set! r15 L.rp.22)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.76)
            (set! r15 L.rp.23)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.24
          (begin
            (set! rsi 1240)
            (set! rdi 24)
            (set! r15 L.rp.24)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.25
          (begin
            (set! rsi 1752)
            (set! rdi 1808)
            (set! r15 L.rp.25)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.79)
            (set! r15 L.rp.26)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.78)
            (set! rdi tmp.75)
            (set! r15 L.rp.27)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! fixnum2.3 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.28
          (begin (set! r15 L.rp.28) (jump L.fun/any13289.4 rbp r15)))
        (set! rbp (+ rbp 56)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.29
          (begin
            (set! rdi tmp.81)
            (set! r15 L.rp.29)
            (jump L.pair?.12 rbp r15 rdi)))
        (set! rbp (+ rbp 56)))
      (set! boolean3.2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.30
          (begin (set! r15 L.rp.30) (jump L.fun/empty13290.5 rbp r15)))
        (set! rbp (+ rbp 56)))
      (set! empty4.1 rax)
      (set! r15 tmp-ra.90)
      (jump L.fun/ascii-char13291.7 rbp r15))))
(check-by-interp
 '(module
    ((locals
      (error4.1
       ascii-char3.2
       boolean2.3
       tmp.75
       fixnum1.4
       tmp.72
       tmp.74
       tmp.71))
     (conflicts
      ((tmp-ra.84
        (error4.1
         ascii-char3.2
         boolean2.3
         tmp.75
         fixnum1.4
         tmp.72
         tmp.74
         tmp.73
         tmp.69
         tmp.71
         tmp.70
         ascii-char0.5
         rax
         rbp))
       (ascii-char0.5
        (error4.1
         ascii-char3.2
         boolean2.3
         tmp.75
         fixnum1.4
         tmp.72
         tmp.74
         tmp.73
         tmp.69
         tmp.71
         tmp.70
         rax
         rbp
         tmp-ra.84))
       (tmp.70 (rsi tmp.71 rax rbp tmp-ra.84 ascii-char0.5))
       (tmp.71 (rbp tmp-ra.84 ascii-char0.5 tmp.70))
       (tmp.69 (rsi tmp.72 tmp.74 tmp.73 rax rbp tmp-ra.84 ascii-char0.5))
       (tmp.73 (rsi tmp.74 rax rbp tmp-ra.84 ascii-char0.5 tmp.69))
       (tmp.74 (rbp tmp-ra.84 ascii-char0.5 tmp.69 tmp.73))
       (tmp.72 (rbp tmp-ra.84 ascii-char0.5 tmp.69))
       (fixnum1.4 (rbp tmp-ra.84 ascii-char0.5))
       (tmp.75 (rbp tmp-ra.84 ascii-char0.5))
       (boolean2.3 (rbp tmp-ra.84 ascii-char0.5))
       (ascii-char3.2 (rbp tmp-ra.84 ascii-char0.5))
       (error4.1 (rbp tmp-ra.84 ascii-char0.5))
       (rbp
        (error4.1
         ascii-char3.2
         boolean2.3
         tmp.75
         fixnum1.4
         tmp.72
         tmp.74
         tmp.73
         tmp.69
         tmp.71
         tmp.70
         rdi
         rsi
         ascii-char0.5
         r15
         rax
         tmp-ra.84))
       (rax (tmp.73 tmp.69 tmp.70 ascii-char0.5 rbp tmp-ra.84))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.73 tmp.70 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.84 fv0)
       (tmp.70 fv1)
       (tmp.69 fv1)
       (tmp.73 fv2)
       (ascii-char0.5 fv3))))
    (define L.fixnum?.12
      ((locals (tmp-ra.76 tmp.85 tmp.42 tmp.55))
       (conflicts
        ((tmp.55 (rbp tmp-ra.76))
         (tmp.42 (rbp tmp-ra.76))
         (tmp.85 (rbp tmp-ra.76))
         (tmp-ra.76 (tmp.42 rbp rdi tmp.85 tmp.55 rax))
         (rax (rbp tmp-ra.76))
         (rbp (tmp.42 tmp-ra.76 tmp.85 tmp.55 rax))
         (rdi (tmp-ra.76))))
       (assignment ()))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.42 rdi)
        (if (begin
              (begin
                (set! tmp.85 tmp.42)
                (set! tmp.85 (bitwise-and tmp.85 7))
                (set! tmp.55 tmp.85))
              (= tmp.55 0))
          (begin (set! rax 14) (jump tmp-ra.76 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.76 rbp rax)))))
    (define L.+.11
      ((locals
        (tmp.58
         tmp.87
         tmp.21
         tmp.59
         tmp.88
         tmp-ra.77
         tmp.57
         tmp.22
         tmp.86
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.77 tmp.22 tmp.21))
         (tmp.86 (tmp.22 rbp tmp-ra.77 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.77
           tmp.21
           tmp.86
           tmp.57
           tmp.56
           tmp.87
           tmp.59
           tmp.58
           tmp.88))
         (tmp.57 (rbp tmp-ra.77 tmp.22 tmp.21))
         (tmp-ra.77
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.86
           tmp.57
           tmp.56
           tmp.87
           tmp.59
           tmp.58
           tmp.88
           rax))
         (tmp.88 (rbp tmp-ra.77 tmp.22))
         (tmp.59 (rbp tmp-ra.77 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.77 rsi tmp.86 tmp.57 tmp.56 tmp.87 tmp.59 tmp.58))
         (tmp.87 (tmp.21 rbp tmp-ra.77 tmp.22))
         (tmp.58 (rbp tmp-ra.77 tmp.22 tmp.21))
         (rax (rbp tmp-ra.77))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.77
           tmp.86
           tmp.57
           tmp.56
           tmp.87
           tmp.59
           tmp.58
           tmp.88
           rax))
         (rdi (tmp-ra.77))
         (rsi (tmp.21 tmp-ra.77))))
       (assignment ()))
      (begin
        (set! tmp-ra.77 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.86 tmp.22)
                      (set! tmp.86 (bitwise-and tmp.86 7))
                      (set! tmp.57 tmp.86))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.87 tmp.21)
                        (set! tmp.87 (bitwise-and tmp.87 7))
                        (set! tmp.59 tmp.87))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.88 tmp.21)
              (set! tmp.88 (+ tmp.88 tmp.22))
              (set! rax tmp.88)
              (jump tmp-ra.77 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.77 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.77 rbp rax)))))
    (define L.*.10
      ((locals
        (tmp.62
         tmp.90
         tmp.19
         tmp.63
         tmp.92
         tmp.64
         tmp.91
         tmp-ra.78
         tmp.61
         tmp.20
         tmp.89
         tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.78 tmp.19 tmp.20))
         (tmp.89 (tmp.20 rbp tmp-ra.78 tmp.19))
         (tmp.20
          (rbp tmp-ra.78 tmp.19 tmp.89 tmp.61 tmp.60 tmp.90 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.78 tmp.19 tmp.20))
         (tmp-ra.78
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.89
           tmp.61
           tmp.60
           tmp.90
           tmp.63
           tmp.62
           tmp.92
           tmp.64
           tmp.91
           rax))
         (tmp.91 (rbp tmp-ra.78 tmp.19))
         (tmp.64 (tmp.92 rbp tmp-ra.78 tmp.19))
         (tmp.92 (rbp tmp-ra.78 tmp.64))
         (tmp.63 (rbp tmp-ra.78 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.78
           rsi
           tmp.89
           tmp.61
           tmp.60
           tmp.90
           tmp.63
           tmp.62
           tmp.64
           tmp.91))
         (tmp.90 (tmp.19 rbp tmp-ra.78 tmp.20))
         (tmp.62 (rbp tmp-ra.78 tmp.19 tmp.20))
         (rax (rbp tmp-ra.78))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.78
           tmp.89
           tmp.61
           tmp.60
           tmp.90
           tmp.63
           tmp.62
           tmp.92
           tmp.64
           tmp.91
           rax))
         (rdi (tmp-ra.78))
         (rsi (tmp.19 tmp-ra.78))))
       (assignment ()))
      (begin
        (set! tmp-ra.78 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.89 tmp.20)
                      (set! tmp.89 (bitwise-and tmp.89 7))
                      (set! tmp.61 tmp.89))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.90 tmp.19)
                        (set! tmp.90 (bitwise-and tmp.90 7))
                        (set! tmp.63 tmp.90))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.91 tmp.20)
              (set! tmp.91 (arithmetic-shift-right tmp.91 3))
              (set! tmp.64 tmp.91)
              (set! tmp.92 tmp.19)
              (set! tmp.92 (* tmp.92 tmp.64))
              (set! rax tmp.92)
              (jump tmp-ra.78 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.78 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.78 rbp rax)))))
    (define L.-.9
      ((locals
        (tmp.67
         tmp.94
         tmp.23
         tmp.68
         tmp.95
         tmp-ra.79
         tmp.66
         tmp.24
         tmp.93
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.79 tmp.24 tmp.23))
         (tmp.93 (tmp.24 rbp tmp-ra.79 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.79
           tmp.23
           tmp.93
           tmp.66
           tmp.65
           tmp.94
           tmp.68
           tmp.67
           tmp.95))
         (tmp.66 (rbp tmp-ra.79 tmp.24 tmp.23))
         (tmp-ra.79
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.93
           tmp.66
           tmp.65
           tmp.94
           tmp.68
           tmp.67
           tmp.95
           rax))
         (tmp.95 (rbp tmp-ra.79 tmp.24))
         (tmp.68 (rbp tmp-ra.79 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.79 rsi tmp.93 tmp.66 tmp.65 tmp.94 tmp.68 tmp.67))
         (tmp.94 (tmp.23 rbp tmp-ra.79 tmp.24))
         (tmp.67 (rbp tmp-ra.79 tmp.24 tmp.23))
         (rax (rbp tmp-ra.79))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.79
           tmp.93
           tmp.66
           tmp.65
           tmp.94
           tmp.68
           tmp.67
           tmp.95
           rax))
         (rdi (tmp-ra.79))
         (rsi (tmp.23 tmp-ra.79))))
       (assignment ()))
      (begin
        (set! tmp-ra.79 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.93 tmp.24)
                      (set! tmp.93 (bitwise-and tmp.93 7))
                      (set! tmp.66 tmp.93))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.94 tmp.23)
                        (set! tmp.94 (bitwise-and tmp.94 7))
                        (set! tmp.68 tmp.94))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.95 tmp.23)
              (set! tmp.95 (- tmp.95 tmp.24))
              (set! rax tmp.95)
              (jump tmp-ra.79 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.79 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.79 rbp rax)))))
    (define L.fun/ascii-char13294.4
      ((locals (tmp-ra.80))
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80))))
       (assignment ()))
      (begin (set! tmp-ra.80 r15) (set! rax 25390) (jump tmp-ra.80 rbp rax)))
    (define L.fun/any13295.5
      ((locals (tmp-ra.81))
       (conflicts
        ((tmp-ra.81 (rax rbp)) (rbp (rax tmp-ra.81)) (rax (rbp tmp-ra.81))))
       (assignment ()))
      (begin (set! tmp-ra.81 r15) (set! rax 6) (jump tmp-ra.81 rbp rax)))
    (define L.fun/error13297.6
      ((locals (tmp-ra.82))
       (conflicts
        ((tmp-ra.82 (rax rbp)) (rbp (rax tmp-ra.82)) (rax (rbp tmp-ra.82))))
       (assignment ()))
      (begin (set! tmp-ra.82 r15) (set! rax 46910) (jump tmp-ra.82 rbp rax)))
    (define L.fun/ascii-char13296.7
      ((locals (tmp-ra.83))
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83))))
       (assignment ()))
      (begin (set! tmp-ra.83 r15) (set! rax 25390) (jump tmp-ra.83 rbp rax)))
    (begin
      (set! tmp-ra.84 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/ascii-char13294.4 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! ascii-char0.5 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin
            (set! rsi 920)
            (set! rdi 272)
            (set! r15 L.rp.14)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin
            (set! rsi 1528)
            (set! rdi 1312)
            (set! r15 L.rp.15)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi tmp.71)
            (set! rdi tmp.70)
            (set! r15 L.rp.16)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi 608)
            (set! rdi 928)
            (set! r15 L.rp.17)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi 1288)
            (set! rdi 224)
            (set! r15 L.rp.18)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.74)
            (set! rdi tmp.73)
            (set! r15 L.rp.19)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.69)
            (set! r15 L.rp.20)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! fixnum1.4 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/any13295.5 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin
            (set! rdi tmp.75)
            (set! r15 L.rp.22)
            (jump L.fixnum?.12 rbp r15 rdi)))
        (set! rbp (+ rbp 40)))
      (set! boolean2.3 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char13296.7 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! ascii-char3.2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/error13297.6 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! error4.1 rax)
      (set! rax ascii-char0.5)
      (jump tmp-ra.84 rbp rax))))
(check-by-interp
 '(module
    ((locals (ascii-char4.1 boolean3.2 tmp.56 error2.3 ascii-char0.5))
     (conflicts
      ((tmp-ra.63
        (ascii-char4.1
         boolean3.2
         tmp.56
         error2.3
         void1.4
         ascii-char0.5
         rax
         rbp))
       (ascii-char0.5 (rbp tmp-ra.63))
       (void1.4 (ascii-char4.1 boolean3.2 tmp.56 error2.3 rax rbp tmp-ra.63))
       (error2.3 (rbp tmp-ra.63 void1.4))
       (tmp.56 (rbp tmp-ra.63 void1.4))
       (boolean3.2 (rbp tmp-ra.63 void1.4))
       (ascii-char4.1 (rbp tmp-ra.63 void1.4))
       (rbp
        (ascii-char4.1
         boolean3.2
         rdi
         tmp.56
         error2.3
         void1.4
         ascii-char0.5
         r15
         rax
         tmp-ra.63))
       (rax (void1.4 rbp tmp-ra.63))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment ((tmp-ra.63 fv0) (void1.4 fv1))))
    (define L.ascii-char?.10
      ((locals (tmp-ra.57 tmp.64 tmp.46 tmp.55))
       (conflicts
        ((tmp.55 (rbp tmp-ra.57))
         (tmp.46 (rbp tmp-ra.57))
         (tmp.64 (rbp tmp-ra.57))
         (tmp-ra.57 (tmp.46 rbp rdi tmp.64 tmp.55 rax))
         (rax (rbp tmp-ra.57))
         (rbp (tmp.46 tmp-ra.57 tmp.64 tmp.55 rax))
         (rdi (tmp-ra.57))))
       (assignment ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.64 tmp.46)
                (set! tmp.64 (bitwise-and tmp.64 255))
                (set! tmp.55 tmp.64))
              (= tmp.55 46))
          (begin (set! rax 14) (jump tmp-ra.57 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.57 rbp rax)))))
    (define L.fun/ascii-char13919.4
      ((locals (tmp-ra.58))
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ()))
      (begin (set! tmp-ra.58 r15) (set! rax 25390) (jump tmp-ra.58 rbp rax)))
    (define L.fun/error13917.5
      ((locals (tmp-ra.59))
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ()))
      (begin (set! tmp-ra.59 r15) (set! rax 34878) (jump tmp-ra.59 rbp rax)))
    (define L.fun/any13918.6
      ((locals (tmp-ra.60))
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60))))
       (assignment ()))
      (begin (set! tmp-ra.60 r15) (set! rax 14) (jump tmp-ra.60 rbp rax)))
    (define L.fun/void13916.7
      ((locals (tmp-ra.61))
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ()))
      (begin (set! tmp-ra.61 r15) (set! rax 30) (jump tmp-ra.61 rbp rax)))
    (define L.fun/ascii-char13915.8
      ((locals (tmp-ra.62))
       (conflicts
        ((tmp-ra.62 (rax rbp)) (rbp (rax tmp-ra.62)) (rax (rbp tmp-ra.62))))
       (assignment ()))
      (begin (set! tmp-ra.62 r15) (set! rax 25390) (jump tmp-ra.62 rbp rax)))
    (begin
      (set! tmp-ra.63 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char13915.8 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char0.5 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void13916.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void1.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/error13917.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error2.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/any13918.6 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! tmp.56 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.15
          (begin
            (set! rdi tmp.56)
            (set! r15 L.rp.15)
            (jump L.ascii-char?.10 rbp r15 rdi)))
        (set! rbp (+ rbp 16)))
      (set! boolean3.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/ascii-char13919.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char4.1 rax)
      (set! rax void1.4)
      (jump tmp-ra.63 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (fixnum4.1
       tmp.77
       tmp.79
       tmp.76
       error2.3
       fixnum1.4
       tmp.71
       tmp.73
       tmp.70
       ascii-char0.5))
     (conflicts
      ((tmp-ra.86
        (fixnum4.1
         tmp.77
         tmp.79
         tmp.78
         tmp.74
         tmp.76
         tmp.75
         empty3.2
         error2.3
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
       (ascii-char0.5 (rbp tmp-ra.86))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.86))
       (tmp.70 (rbp tmp-ra.86 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.86))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.86 tmp.68))
       (tmp.73 (rbp tmp-ra.86 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.86 tmp.68))
       (fixnum1.4 (rbp tmp-ra.86))
       (error2.3 (rbp tmp-ra.86))
       (empty3.2
        (fixnum4.1
         tmp.77
         tmp.79
         tmp.78
         tmp.74
         tmp.76
         tmp.75
         rax
         rbp
         tmp-ra.86))
       (tmp.75 (rsi tmp.76 rax rbp tmp-ra.86 empty3.2))
       (tmp.76 (rbp tmp-ra.86 empty3.2 tmp.75))
       (tmp.74 (rsi tmp.77 tmp.79 tmp.78 rax rbp tmp-ra.86 empty3.2))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.86 empty3.2 tmp.74))
       (tmp.79 (rbp tmp-ra.86 empty3.2 tmp.74 tmp.78))
       (tmp.77 (rbp tmp-ra.86 empty3.2 tmp.74))
       (fixnum4.1 (rbp tmp-ra.86 empty3.2))
       (rbp
        (fixnum4.1
         tmp.77
         tmp.79
         tmp.78
         tmp.74
         tmp.76
         tmp.75
         empty3.2
         error2.3
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
         tmp-ra.86))
       (rax (tmp.78 tmp.74 tmp.75 empty3.2 tmp.72 tmp.68 tmp.69 rbp tmp-ra.86))
       (r15 (rdi rsi rbp))
       (rsi (tmp.74 tmp.78 tmp.75 tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.86 fv0)
       (tmp.69 fv1)
       (tmp.68 fv1)
       (empty3.2 fv1)
       (tmp.78 fv2)
       (tmp.74 fv3)
       (tmp.75 fv2)
       (tmp.72 fv2))))
    (define L.+.10
      ((locals
        (tmp.57
         tmp.88
         tmp.21
         tmp.58
         tmp.89
         tmp-ra.80
         tmp.56
         tmp.22
         tmp.87
         tmp.55))
       (conflicts
        ((tmp.55 (rbp tmp-ra.80 tmp.22 tmp.21))
         (tmp.87 (tmp.22 rbp tmp-ra.80 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.80
           tmp.21
           tmp.87
           tmp.56
           tmp.55
           tmp.88
           tmp.58
           tmp.57
           tmp.89))
         (tmp.56 (rbp tmp-ra.80 tmp.22 tmp.21))
         (tmp-ra.80
          (tmp.22
           tmp.21
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
         (tmp.89 (rbp tmp-ra.80 tmp.22))
         (tmp.58 (rbp tmp-ra.80 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.80 rsi tmp.87 tmp.56 tmp.55 tmp.88 tmp.58 tmp.57))
         (tmp.88 (tmp.21 rbp tmp-ra.80 tmp.22))
         (tmp.57 (rbp tmp-ra.80 tmp.22 tmp.21))
         (rax (rbp tmp-ra.80))
         (rbp
          (tmp.22
           tmp.21
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
         (rsi (tmp.21 tmp-ra.80))))
       (assignment ()))
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
      ((locals
        (tmp.61
         tmp.91
         tmp.23
         tmp.62
         tmp.92
         tmp-ra.81
         tmp.60
         tmp.24
         tmp.90
         tmp.59))
       (conflicts
        ((tmp.59 (rbp tmp-ra.81 tmp.24 tmp.23))
         (tmp.90 (tmp.24 rbp tmp-ra.81 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.81
           tmp.23
           tmp.90
           tmp.60
           tmp.59
           tmp.91
           tmp.62
           tmp.61
           tmp.92))
         (tmp.60 (rbp tmp-ra.81 tmp.24 tmp.23))
         (tmp-ra.81
          (tmp.24
           tmp.23
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
         (tmp.92 (rbp tmp-ra.81 tmp.24))
         (tmp.62 (rbp tmp-ra.81 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.81 rsi tmp.90 tmp.60 tmp.59 tmp.91 tmp.62 tmp.61))
         (tmp.91 (tmp.23 rbp tmp-ra.81 tmp.24))
         (tmp.61 (rbp tmp-ra.81 tmp.24 tmp.23))
         (rax (rbp tmp-ra.81))
         (rbp
          (tmp.24
           tmp.23
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
         (rsi (tmp.23 tmp-ra.81))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.19 tmp-ra.82))))
       (assignment ()))
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
    (define L.fun/empty14259.4
      ((locals (tmp-ra.83))
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83))))
       (assignment ()))
      (begin (set! tmp-ra.83 r15) (set! rax 22) (jump tmp-ra.83 rbp rax)))
    (define L.fun/ascii-char14257.5
      ((locals (tmp-ra.84))
       (conflicts
        ((tmp-ra.84 (rax rbp)) (rbp (rax tmp-ra.84)) (rax (rbp tmp-ra.84))))
       (assignment ()))
      (begin (set! tmp-ra.84 r15) (set! rax 25390) (jump tmp-ra.84 rbp rax)))
    (define L.fun/error14258.6
      ((locals (tmp-ra.85))
       (conflicts
        ((tmp-ra.85 (rax rbp)) (rbp (rax tmp-ra.85)) (rax (rbp tmp-ra.85))))
       (assignment ()))
      (begin (set! tmp-ra.85 r15) (set! rax 21310) (jump tmp-ra.85 rbp rax)))
    (begin
      (set! tmp-ra.86 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char14257.5 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char0.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.12
          (begin
            (set! rsi 1776)
            (set! rdi 1648)
            (set! r15 L.rp.12)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.13
          (begin
            (set! rsi 1328)
            (set! rdi 1808)
            (set! r15 L.rp.13)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.14
          (begin
            (set! rsi tmp.70)
            (set! rdi tmp.69)
            (set! r15 L.rp.14)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.68 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.15
          (begin
            (set! rsi 1872)
            (set! rdi 1456)
            (set! r15 L.rp.15)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.16
          (begin
            (set! rsi 624)
            (set! rdi 432)
            (set! r15 L.rp.16)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.17
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.72)
            (set! r15 L.rp.17)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.71)
            (set! rdi tmp.68)
            (set! r15 L.rp.18)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum1.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error14258.6 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! error2.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty14259.4 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty3.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 544)
            (set! rdi 1448)
            (set! r15 L.rp.21)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1936)
            (set! rdi 504)
            (set! r15 L.rp.22)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.75)
            (set! r15 L.rp.23)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 624)
            (set! rdi 832)
            (set! r15 L.rp.24)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 256)
            (set! rdi 816)
            (set! r15 L.rp.25)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.26)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.74)
            (set! r15 L.rp.27)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum4.1 rax)
      (set! rax empty3.2)
      (jump tmp-ra.86 rbp rax))))
(check-by-interp
 '(module
    ((locals (ascii-char4.1 empty2.3 ascii-char1.4 void0.5))
     (conflicts
      ((tmp-ra.60
        (ascii-char4.1 empty3.2 empty2.3 ascii-char1.4 void0.5 rax rbp))
       (void0.5 (rbp tmp-ra.60))
       (ascii-char1.4 (rbp tmp-ra.60))
       (empty2.3 (rbp tmp-ra.60))
       (empty3.2 (ascii-char4.1 rax rbp tmp-ra.60))
       (ascii-char4.1 (rbp tmp-ra.60 empty3.2))
       (rbp
        (ascii-char4.1
         empty3.2
         empty2.3
         ascii-char1.4
         void0.5
         r15
         rax
         tmp-ra.60))
       (rax (empty3.2 rbp tmp-ra.60))
       (r15 (rbp))))
     (assignment ((tmp-ra.60 fv0) (empty3.2 fv1))))
    (define L.fun/empty15571.4
      ((locals (tmp-ra.55))
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55))))
       (assignment ()))
      (begin (set! tmp-ra.55 r15) (set! rax 22) (jump tmp-ra.55 rbp rax)))
    (define L.fun/ascii-char15572.5
      ((locals (tmp-ra.56))
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56))))
       (assignment ()))
      (begin (set! tmp-ra.56 r15) (set! rax 25390) (jump tmp-ra.56 rbp rax)))
    (define L.fun/ascii-char15569.6
      ((locals (tmp-ra.57))
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57))))
       (assignment ()))
      (begin (set! tmp-ra.57 r15) (set! rax 25390) (jump tmp-ra.57 rbp rax)))
    (define L.fun/empty15570.7
      ((locals (tmp-ra.58))
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ()))
      (begin (set! tmp-ra.58 r15) (set! rax 22) (jump tmp-ra.58 rbp rax)))
    (define L.fun/void15568.8
      ((locals (tmp-ra.59))
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ()))
      (begin (set! tmp-ra.59 r15) (set! rax 30) (jump tmp-ra.59 rbp rax)))
    (begin
      (set! tmp-ra.60 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/void15568.8 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void0.5 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char15569.6 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char1.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty15570.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty2.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty15571.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty3.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char15572.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char4.1 rax)
      (set! rax empty3.2)
      (jump tmp-ra.60 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (ascii-char4.1
       empty3.2
       fixnum2.3
       tmp.71
       tmp.73
       tmp.70
       void1.4
       ascii-char0.5))
     (conflicts
      ((tmp-ra.82
        (ascii-char4.1
         empty3.2
         fixnum2.3
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         void1.4
         ascii-char0.5
         rax
         rbp))
       (ascii-char0.5 (rbp tmp-ra.82))
       (void1.4 (rbp tmp-ra.82))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.82))
       (tmp.70 (rbp tmp-ra.82 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.82))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.82 tmp.68))
       (tmp.73 (rbp tmp-ra.82 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.82 tmp.68))
       (fixnum2.3 (rbp tmp-ra.82))
       (empty3.2 (rbp tmp-ra.82))
       (ascii-char4.1 (rbp tmp-ra.82))
       (rbp
        (ascii-char4.1
         empty3.2
         fixnum2.3
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         rdi
         rsi
         void1.4
         ascii-char0.5
         r15
         rax
         tmp-ra.82))
       (rax (tmp.72 tmp.68 tmp.69 rbp tmp-ra.82))
       (r15 (rdi rsi rbp))
       (rsi (tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment ((tmp-ra.82 fv0) (tmp.72 fv1) (tmp.68 fv2) (tmp.69 fv1))))
    (define L.+.12
      ((locals
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
         (rsi (tmp.21 tmp-ra.74))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.23 tmp-ra.75))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.19 tmp-ra.76))))
       (assignment ()))
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
    (define L.fun/ascii-char15704.4
      ((locals (tmp-ra.77))
       (conflicts
        ((tmp-ra.77 (rax rbp)) (rbp (rax tmp-ra.77)) (rax (rbp tmp-ra.77))))
       (assignment ()))
      (begin (set! tmp-ra.77 r15) (set! rax 25390) (jump tmp-ra.77 rbp rax)))
    (define L.fun/void15705.5
      ((locals (tmp-ra.78))
       (conflicts
        ((tmp-ra.78 (rax rbp)) (rbp (rax tmp-ra.78)) (rax (rbp tmp-ra.78))))
       (assignment ()))
      (begin (set! tmp-ra.78 r15) (set! rax 30) (jump tmp-ra.78 rbp rax)))
    (define L.fun/ascii-char15707.6
      ((locals (tmp-ra.79))
       (conflicts
        ((tmp-ra.79 (rax rbp)) (rbp (rax tmp-ra.79)) (rax (rbp tmp-ra.79))))
       (assignment ()))
      (begin (set! tmp-ra.79 r15) (set! rax 25390) (jump tmp-ra.79 rbp rax)))
    (define L.fun/error15708.7
      ((locals (tmp-ra.80))
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80))))
       (assignment ()))
      (begin (set! tmp-ra.80 r15) (set! rax 36158) (jump tmp-ra.80 rbp rax)))
    (define L.fun/empty15706.8
      ((locals (tmp-ra.81))
       (conflicts
        ((tmp-ra.81 (rax rbp)) (rbp (rax tmp-ra.81)) (rax (rbp tmp-ra.81))))
       (assignment ()))
      (begin (set! tmp-ra.81 r15) (set! rax 22) (jump tmp-ra.81 rbp rax)))
    (begin
      (set! tmp-ra.82 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/ascii-char15704.4 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! ascii-char0.5 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void15705.5 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! void1.4 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin
            (set! rsi 424)
            (set! rdi 1192)
            (set! r15 L.rp.15)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 1368)
            (set! rdi 1600)
            (set! r15 L.rp.16)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi tmp.70)
            (set! rdi tmp.69)
            (set! r15 L.rp.17)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.68 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 536)
            (set! rdi 1936)
            (set! r15 L.rp.18)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1704)
            (set! rdi 112)
            (set! r15 L.rp.19)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.72)
            (set! r15 L.rp.20)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi tmp.71)
            (set! rdi tmp.68)
            (set! r15 L.rp.21)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! fixnum2.3 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty15706.8 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! empty3.2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char15707.6 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! ascii-char4.1 rax)
      (set! r15 tmp-ra.82)
      (jump L.fun/error15708.7 rbp r15))))
(check-by-interp
 '(module
    ((locals
      (void4.1
       boolean3.2
       tmp.77
       ascii-char2.3
       boolean1.4
       tmp.76
       fixnum0.5
       tmp.73
       tmp.75
       tmp.72))
     (conflicts
      ((tmp-ra.87
        (void4.1
         boolean3.2
         tmp.77
         ascii-char2.3
         boolean1.4
         tmp.76
         fixnum0.5
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         rax
         rbp))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.87))
       (tmp.72 (rbp tmp-ra.87 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.87))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.87 tmp.70))
       (tmp.75 (rbp tmp-ra.87 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.87 tmp.70))
       (fixnum0.5 (rbp tmp-ra.87))
       (tmp.76 (rbp tmp-ra.87))
       (boolean1.4 (rbp tmp-ra.87))
       (ascii-char2.3 (rbp tmp-ra.87))
       (tmp.77 (rbp tmp-ra.87))
       (boolean3.2 (rbp tmp-ra.87))
       (void4.1 (rbp tmp-ra.87))
       (rbp
        (void4.1
         boolean3.2
         tmp.77
         ascii-char2.3
         boolean1.4
         tmp.76
         fixnum0.5
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
         tmp-ra.87))
       (rax (tmp.74 tmp.70 tmp.71 rbp tmp-ra.87))
       (rsi (tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment ((tmp-ra.87 fv0) (tmp.74 fv1) (tmp.70 fv2) (tmp.71 fv1))))
    (define L.empty?.13
      ((locals (tmp-ra.78 tmp.88 tmp.44 tmp.55))
       (conflicts
        ((tmp.55 (rbp tmp-ra.78))
         (tmp.44 (rbp tmp-ra.78))
         (tmp.88 (rbp tmp-ra.78))
         (tmp-ra.78 (tmp.44 rbp rdi tmp.88 tmp.55 rax))
         (rax (rbp tmp-ra.78))
         (rbp (tmp.44 tmp-ra.78 tmp.88 tmp.55 rax))
         (rdi (tmp-ra.78))))
       (assignment ()))
      (begin
        (set! tmp-ra.78 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.88 tmp.44)
                (set! tmp.88 (bitwise-and tmp.88 255))
                (set! tmp.55 tmp.88))
              (= tmp.55 22))
          (begin (set! rax 14) (jump tmp-ra.78 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.78 rbp rax)))))
    (define L.ascii-char?.12
      ((locals (tmp-ra.79 tmp.89 tmp.46 tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.79))
         (tmp.46 (rbp tmp-ra.79))
         (tmp.89 (rbp tmp-ra.79))
         (tmp-ra.79 (tmp.46 rbp rdi tmp.89 tmp.56 rax))
         (rax (rbp tmp-ra.79))
         (rbp (tmp.46 tmp-ra.79 tmp.89 tmp.56 rax))
         (rdi (tmp-ra.79))))
       (assignment ()))
      (begin
        (set! tmp-ra.79 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.89 tmp.46)
                (set! tmp.89 (bitwise-and tmp.89 255))
                (set! tmp.56 tmp.89))
              (= tmp.56 46))
          (begin (set! rax 14) (jump tmp-ra.79 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.79 rbp rax)))))
    (define L.*.11
      ((locals
        (tmp.59
         tmp.91
         tmp.19
         tmp.60
         tmp.93
         tmp.61
         tmp.92
         tmp-ra.80
         tmp.58
         tmp.20
         tmp.90
         tmp.57))
       (conflicts
        ((tmp.57 (rbp tmp-ra.80 tmp.19 tmp.20))
         (tmp.90 (tmp.20 rbp tmp-ra.80 tmp.19))
         (tmp.20
          (rbp tmp-ra.80 tmp.19 tmp.90 tmp.58 tmp.57 tmp.91 tmp.60 tmp.59))
         (tmp.58 (rbp tmp-ra.80 tmp.19 tmp.20))
         (tmp-ra.80
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.90
           tmp.58
           tmp.57
           tmp.91
           tmp.60
           tmp.59
           tmp.93
           tmp.61
           tmp.92
           rax))
         (tmp.92 (rbp tmp-ra.80 tmp.19))
         (tmp.61 (tmp.93 rbp tmp-ra.80 tmp.19))
         (tmp.93 (rbp tmp-ra.80 tmp.61))
         (tmp.60 (rbp tmp-ra.80 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.80
           rsi
           tmp.90
           tmp.58
           tmp.57
           tmp.91
           tmp.60
           tmp.59
           tmp.61
           tmp.92))
         (tmp.91 (tmp.19 rbp tmp-ra.80 tmp.20))
         (tmp.59 (rbp tmp-ra.80 tmp.19 tmp.20))
         (rax (rbp tmp-ra.80))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.80
           tmp.90
           tmp.58
           tmp.57
           tmp.91
           tmp.60
           tmp.59
           tmp.93
           tmp.61
           tmp.92
           rax))
         (rdi (tmp-ra.80))
         (rsi (tmp.19 tmp-ra.80))))
       (assignment ()))
      (begin
        (set! tmp-ra.80 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.90 tmp.20)
                      (set! tmp.90 (bitwise-and tmp.90 7))
                      (set! tmp.58 tmp.90))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.91 tmp.19)
                        (set! tmp.91 (bitwise-and tmp.91 7))
                        (set! tmp.60 tmp.91))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.92 tmp.20)
              (set! tmp.92 (arithmetic-shift-right tmp.92 3))
              (set! tmp.61 tmp.92)
              (set! tmp.93 tmp.19)
              (set! tmp.93 (* tmp.93 tmp.61))
              (set! rax tmp.93)
              (jump tmp-ra.80 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.80 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.80 rbp rax)))))
    (define L.-.10
      ((locals
        (tmp.64
         tmp.95
         tmp.23
         tmp.65
         tmp.96
         tmp-ra.81
         tmp.63
         tmp.24
         tmp.94
         tmp.62))
       (conflicts
        ((tmp.62 (rbp tmp-ra.81 tmp.24 tmp.23))
         (tmp.94 (tmp.24 rbp tmp-ra.81 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.81
           tmp.23
           tmp.94
           tmp.63
           tmp.62
           tmp.95
           tmp.65
           tmp.64
           tmp.96))
         (tmp.63 (rbp tmp-ra.81 tmp.24 tmp.23))
         (tmp-ra.81
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.94
           tmp.63
           tmp.62
           tmp.95
           tmp.65
           tmp.64
           tmp.96
           rax))
         (tmp.96 (rbp tmp-ra.81 tmp.24))
         (tmp.65 (rbp tmp-ra.81 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.81 rsi tmp.94 tmp.63 tmp.62 tmp.95 tmp.65 tmp.64))
         (tmp.95 (tmp.23 rbp tmp-ra.81 tmp.24))
         (tmp.64 (rbp tmp-ra.81 tmp.24 tmp.23))
         (rax (rbp tmp-ra.81))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.81
           tmp.94
           tmp.63
           tmp.62
           tmp.95
           tmp.65
           tmp.64
           tmp.96
           rax))
         (rdi (tmp-ra.81))
         (rsi (tmp.23 tmp-ra.81))))
       (assignment ()))
      (begin
        (set! tmp-ra.81 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.94 tmp.24)
                      (set! tmp.94 (bitwise-and tmp.94 7))
                      (set! tmp.63 tmp.94))
                    (= tmp.63 0))
                (set! tmp.62 14)
                (set! tmp.62 6))
              (!= tmp.62 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.95 tmp.23)
                        (set! tmp.95 (bitwise-and tmp.95 7))
                        (set! tmp.65 tmp.95))
                      (= tmp.65 0))
                  (set! tmp.64 14)
                  (set! tmp.64 6))
                (!= tmp.64 6))
            (begin
              (set! tmp.96 tmp.23)
              (set! tmp.96 (- tmp.96 tmp.24))
              (set! rax tmp.96)
              (jump tmp-ra.81 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.81 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.81 rbp rax)))))
    (define L.+.9
      ((locals
        (tmp.68
         tmp.98
         tmp.21
         tmp.69
         tmp.99
         tmp-ra.82
         tmp.67
         tmp.22
         tmp.97
         tmp.66))
       (conflicts
        ((tmp.66 (rbp tmp-ra.82 tmp.22 tmp.21))
         (tmp.97 (tmp.22 rbp tmp-ra.82 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.82
           tmp.21
           tmp.97
           tmp.67
           tmp.66
           tmp.98
           tmp.69
           tmp.68
           tmp.99))
         (tmp.67 (rbp tmp-ra.82 tmp.22 tmp.21))
         (tmp-ra.82
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.97
           tmp.67
           tmp.66
           tmp.98
           tmp.69
           tmp.68
           tmp.99
           rax))
         (tmp.99 (rbp tmp-ra.82 tmp.22))
         (tmp.69 (rbp tmp-ra.82 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.82 rsi tmp.97 tmp.67 tmp.66 tmp.98 tmp.69 tmp.68))
         (tmp.98 (tmp.21 rbp tmp-ra.82 tmp.22))
         (tmp.68 (rbp tmp-ra.82 tmp.22 tmp.21))
         (rax (rbp tmp-ra.82))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.82
           tmp.97
           tmp.67
           tmp.66
           tmp.98
           tmp.69
           tmp.68
           tmp.99
           rax))
         (rdi (tmp-ra.82))
         (rsi (tmp.21 tmp-ra.82))))
       (assignment ()))
      (begin
        (set! tmp-ra.82 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.22)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.67 tmp.97))
                    (= tmp.67 0))
                (set! tmp.66 14)
                (set! tmp.66 6))
              (!= tmp.66 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.21)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.69 tmp.98))
                      (= tmp.69 0))
                  (set! tmp.68 14)
                  (set! tmp.68 6))
                (!= tmp.68 6))
            (begin
              (set! tmp.99 tmp.21)
              (set! tmp.99 (+ tmp.99 tmp.22))
              (set! rax tmp.99)
              (jump tmp-ra.82 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.82 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.82 rbp rax)))))
    (define L.fun/void15911.4
      ((locals (tmp-ra.83))
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83))))
       (assignment ()))
      (begin (set! tmp-ra.83 r15) (set! rax 30) (jump tmp-ra.83 rbp rax)))
    (define L.fun/any15910.5
      ((locals (tmp-ra.84))
       (conflicts
        ((tmp-ra.84 (rax rbp)) (rbp (rax tmp-ra.84)) (rax (rbp tmp-ra.84))))
       (assignment ()))
      (begin (set! tmp-ra.84 r15) (set! rax 25390) (jump tmp-ra.84 rbp rax)))
    (define L.fun/any15908.6
      ((locals (tmp-ra.85))
       (conflicts
        ((tmp-ra.85 (rax rbp)) (rbp (rax tmp-ra.85)) (rax (rbp tmp-ra.85))))
       (assignment ()))
      (begin (set! tmp-ra.85 r15) (set! rax 25390) (jump tmp-ra.85 rbp rax)))
    (define L.fun/ascii-char15909.7
      ((locals (tmp-ra.86))
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86))))
       (assignment ()))
      (begin (set! tmp-ra.86 r15) (set! rax 25390) (jump tmp-ra.86 rbp rax)))
    (begin
      (set! tmp-ra.87 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin
            (set! rsi 152)
            (set! rdi 1608)
            (set! r15 L.rp.14)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin
            (set! rsi 256)
            (set! rdi 1064)
            (set! r15 L.rp.15)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.16)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 1016)
            (set! rdi 2032)
            (set! r15 L.rp.17)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 1496)
            (set! rdi 544)
            (set! r15 L.rp.18)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.19)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.20)
            (jump L.*.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! fixnum0.5 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/any15908.6 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rdi tmp.76)
            (set! r15 L.rp.22)
            (jump L.ascii-char?.12 rbp r15 rdi)))
        (set! rbp (+ rbp 32)))
      (set! boolean1.4 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char15909.7 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! ascii-char2.3 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/any15910.5 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.25
          (begin
            (set! rdi tmp.77)
            (set! r15 L.rp.25)
            (jump L.empty?.13 rbp r15 rdi)))
        (set! rbp (+ rbp 32)))
      (set! boolean3.2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/void15911.4 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! void4.1 rax)
      (set! rax void4.1)
      (jump tmp-ra.87 rbp rax))))
(check-by-interp
 '(module
    ((locals (ascii-char4.1 empty3.2 empty1.4 ascii-char0.5))
     (conflicts
      ((tmp-ra.60
        (ascii-char4.1 empty3.2 error2.3 empty1.4 ascii-char0.5 rax rbp))
       (ascii-char0.5 (rbp tmp-ra.60))
       (empty1.4 (rbp tmp-ra.60))
       (error2.3 (ascii-char4.1 empty3.2 rax rbp tmp-ra.60))
       (empty3.2 (rbp tmp-ra.60 error2.3))
       (ascii-char4.1 (rbp tmp-ra.60 error2.3))
       (rbp
        (ascii-char4.1
         empty3.2
         error2.3
         empty1.4
         ascii-char0.5
         r15
         rax
         tmp-ra.60))
       (rax (error2.3 rbp tmp-ra.60))
       (r15 (rbp))))
     (assignment ((tmp-ra.60 fv0) (error2.3 fv1))))
    (define L.fun/error16257.4
      ((locals (tmp-ra.55))
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55))))
       (assignment ()))
      (begin (set! tmp-ra.55 r15) (set! rax 57150) (jump tmp-ra.55 rbp rax)))
    (define L.fun/ascii-char16255.5
      ((locals (tmp-ra.56))
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56))))
       (assignment ()))
      (begin (set! tmp-ra.56 r15) (set! rax 25390) (jump tmp-ra.56 rbp rax)))
    (define L.fun/empty16258.6
      ((locals (tmp-ra.57))
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57))))
       (assignment ()))
      (begin (set! tmp-ra.57 r15) (set! rax 22) (jump tmp-ra.57 rbp rax)))
    (define L.fun/empty16256.7
      ((locals (tmp-ra.58))
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ()))
      (begin (set! tmp-ra.58 r15) (set! rax 22) (jump tmp-ra.58 rbp rax)))
    (define L.fun/ascii-char16259.8
      ((locals (tmp-ra.59))
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ()))
      (begin (set! tmp-ra.59 r15) (set! rax 25390) (jump tmp-ra.59 rbp rax)))
    (begin
      (set! tmp-ra.60 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char16255.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char0.5 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty16256.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty1.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error16257.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error2.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty16258.6 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty3.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char16259.8 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char4.1 rax)
      (set! rax error2.3)
      (jump tmp-ra.60 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (fixnum4.1
       tmp.77
       tmp.79
       tmp.76
       ascii-char3.2
       error2.3
       fixnum1.4
       tmp.71
       tmp.73
       tmp.70))
     (conflicts
      ((tmp-ra.86
        (fixnum4.1
         tmp.77
         tmp.79
         tmp.78
         tmp.74
         tmp.76
         tmp.75
         ascii-char3.2
         error2.3
         fixnum1.4
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         void0.5
         rax
         rbp))
       (void0.5
        (fixnum4.1
         tmp.77
         tmp.79
         tmp.78
         tmp.74
         tmp.76
         tmp.75
         ascii-char3.2
         error2.3
         fixnum1.4
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         rax
         rbp
         tmp-ra.86))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.86 void0.5))
       (tmp.70 (rbp tmp-ra.86 void0.5 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.86 void0.5))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.86 void0.5 tmp.68))
       (tmp.73 (rbp tmp-ra.86 void0.5 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.86 void0.5 tmp.68))
       (fixnum1.4 (rbp tmp-ra.86 void0.5))
       (error2.3 (rbp tmp-ra.86 void0.5))
       (ascii-char3.2 (rbp tmp-ra.86 void0.5))
       (tmp.75 (rsi tmp.76 rax rbp tmp-ra.86 void0.5))
       (tmp.76 (rbp tmp-ra.86 void0.5 tmp.75))
       (tmp.74 (rsi tmp.77 tmp.79 tmp.78 rax rbp tmp-ra.86 void0.5))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.86 void0.5 tmp.74))
       (tmp.79 (rbp tmp-ra.86 void0.5 tmp.74 tmp.78))
       (tmp.77 (rbp tmp-ra.86 void0.5 tmp.74))
       (fixnum4.1 (rbp tmp-ra.86 void0.5))
       (rbp
        (fixnum4.1
         tmp.77
         tmp.79
         tmp.78
         tmp.74
         tmp.76
         tmp.75
         ascii-char3.2
         error2.3
         fixnum1.4
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         rdi
         rsi
         void0.5
         r15
         rax
         tmp-ra.86))
       (rax (tmp.78 tmp.74 tmp.75 tmp.72 tmp.68 tmp.69 void0.5 rbp tmp-ra.86))
       (r15 (rdi rsi rbp))
       (rsi (tmp.74 tmp.78 tmp.75 tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.86 fv0)
       (tmp.69 fv1)
       (tmp.68 fv1)
       (tmp.78 fv1)
       (tmp.74 fv2)
       (tmp.75 fv1)
       (tmp.72 fv2)
       (void0.5 fv3))))
    (define L.-.10
      ((locals
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
         (rsi (tmp.23 tmp-ra.80))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.21 tmp-ra.81))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.19 tmp-ra.82))))
       (assignment ()))
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
    (define L.fun/void17748.4
      ((locals (tmp-ra.83))
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83))))
       (assignment ()))
      (begin (set! tmp-ra.83 r15) (set! rax 30) (jump tmp-ra.83 rbp rax)))
    (define L.fun/ascii-char17750.5
      ((locals (tmp-ra.84))
       (conflicts
        ((tmp-ra.84 (rax rbp)) (rbp (rax tmp-ra.84)) (rax (rbp tmp-ra.84))))
       (assignment ()))
      (begin (set! tmp-ra.84 r15) (set! rax 25390) (jump tmp-ra.84 rbp rax)))
    (define L.fun/error17749.6
      ((locals (tmp-ra.85))
       (conflicts
        ((tmp-ra.85 (rax rbp)) (rbp (rax tmp-ra.85)) (rax (rbp tmp-ra.85))))
       (assignment ()))
      (begin (set! tmp-ra.85 r15) (set! rax 36158) (jump tmp-ra.85 rbp rax)))
    (begin
      (set! tmp-ra.86 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/void17748.4 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void0.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.12
          (begin
            (set! rsi 1496)
            (set! rdi 2000)
            (set! r15 L.rp.12)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.13
          (begin
            (set! rsi 464)
            (set! rdi 1416)
            (set! r15 L.rp.13)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.14
          (begin
            (set! rsi tmp.70)
            (set! rdi tmp.69)
            (set! r15 L.rp.14)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.68 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.15
          (begin
            (set! rsi 1352)
            (set! rdi 912)
            (set! r15 L.rp.15)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.16
          (begin
            (set! rsi 1184)
            (set! rdi 1176)
            (set! r15 L.rp.16)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.17
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.72)
            (set! r15 L.rp.17)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.71)
            (set! rdi tmp.68)
            (set! r15 L.rp.18)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum1.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error17749.6 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! error2.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char17750.5 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char3.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 608)
            (set! rdi 1920)
            (set! r15 L.rp.21)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1456)
            (set! rdi 1400)
            (set! r15 L.rp.22)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.75)
            (set! r15 L.rp.23)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 400)
            (set! rdi 1480)
            (set! r15 L.rp.24)
            (jump L.*.8 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1320)
            (set! rdi 848)
            (set! r15 L.rp.25)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.26)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.74)
            (set! r15 L.rp.27)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum4.1 rax)
      (set! rax void0.5)
      (jump tmp-ra.86 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (fixnum4.1 tmp.71 tmp.73 tmp.70 void3.2 empty2.3 empty1.4 void0.5))
     (conflicts
      ((tmp-ra.82
        (fixnum4.1
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         void3.2
         empty2.3
         empty1.4
         void0.5
         rax
         rbp))
       (void0.5 (rbp tmp-ra.82))
       (empty1.4 (rbp tmp-ra.82))
       (empty2.3 (rbp tmp-ra.82))
       (void3.2 (rbp tmp-ra.82))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.82))
       (tmp.70 (rbp tmp-ra.82 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.82))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.82 tmp.68))
       (tmp.73 (rbp tmp-ra.82 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.82 tmp.68))
       (fixnum4.1 (rbp tmp-ra.82))
       (rbp
        (fixnum4.1
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         rdi
         rsi
         void3.2
         empty2.3
         empty1.4
         void0.5
         r15
         rax
         tmp-ra.82))
       (rax (tmp.72 tmp.68 tmp.69 rbp tmp-ra.82))
       (r15 (rdi rsi rbp))
       (rsi (tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment ((tmp-ra.82 fv0) (tmp.72 fv1) (tmp.68 fv2) (tmp.69 fv1))))
    (define L.+.12
      ((locals
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
         (rsi (tmp.21 tmp-ra.74))))
       (assignment ()))
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
    (define L.*.11
      ((locals
        (tmp.61
         tmp.87
         tmp.19
         tmp.62
         tmp.89
         tmp.63
         tmp.88
         tmp-ra.75
         tmp.60
         tmp.20
         tmp.86
         tmp.59))
       (conflicts
        ((tmp.59 (rbp tmp-ra.75 tmp.19 tmp.20))
         (tmp.86 (tmp.20 rbp tmp-ra.75 tmp.19))
         (tmp.20
          (rbp tmp-ra.75 tmp.19 tmp.86 tmp.60 tmp.59 tmp.87 tmp.62 tmp.61))
         (tmp.60 (rbp tmp-ra.75 tmp.19 tmp.20))
         (tmp-ra.75
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.86
           tmp.60
           tmp.59
           tmp.87
           tmp.62
           tmp.61
           tmp.89
           tmp.63
           tmp.88
           rax))
         (tmp.88 (rbp tmp-ra.75 tmp.19))
         (tmp.63 (tmp.89 rbp tmp-ra.75 tmp.19))
         (tmp.89 (rbp tmp-ra.75 tmp.63))
         (tmp.62 (rbp tmp-ra.75 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.75
           rsi
           tmp.86
           tmp.60
           tmp.59
           tmp.87
           tmp.62
           tmp.61
           tmp.63
           tmp.88))
         (tmp.87 (tmp.19 rbp tmp-ra.75 tmp.20))
         (tmp.61 (rbp tmp-ra.75 tmp.19 tmp.20))
         (rax (rbp tmp-ra.75))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.75
           tmp.86
           tmp.60
           tmp.59
           tmp.87
           tmp.62
           tmp.61
           tmp.89
           tmp.63
           tmp.88
           rax))
         (rdi (tmp-ra.75))
         (rsi (tmp.19 tmp-ra.75))))
       (assignment ()))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.86 tmp.20)
                      (set! tmp.86 (bitwise-and tmp.86 7))
                      (set! tmp.60 tmp.86))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.87 tmp.19)
                        (set! tmp.87 (bitwise-and tmp.87 7))
                        (set! tmp.62 tmp.87))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.88 tmp.20)
              (set! tmp.88 (arithmetic-shift-right tmp.88 3))
              (set! tmp.63 tmp.88)
              (set! tmp.89 tmp.19)
              (set! tmp.89 (* tmp.89 tmp.63))
              (set! rax tmp.89)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.75 rbp rax)))))
    (define L.-.10
      ((locals
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
         (rsi (tmp.23 tmp-ra.76))))
       (assignment ()))
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
    (define L.fun/empty17803.4
      ((locals (tmp-ra.77))
       (conflicts
        ((tmp-ra.77 (rax rbp)) (rbp (rax tmp-ra.77)) (rax (rbp tmp-ra.77))))
       (assignment ()))
      (begin (set! tmp-ra.77 r15) (set! rax 22) (jump tmp-ra.77 rbp rax)))
    (define L.fun/error17806.5
      ((locals (tmp-ra.78))
       (conflicts
        ((tmp-ra.78 (rax rbp)) (rbp (rax tmp-ra.78)) (rax (rbp tmp-ra.78))))
       (assignment ()))
      (begin (set! tmp-ra.78 r15) (set! rax 38462) (jump tmp-ra.78 rbp rax)))
    (define L.fun/void17802.6
      ((locals (tmp-ra.79))
       (conflicts
        ((tmp-ra.79 (rax rbp)) (rbp (rax tmp-ra.79)) (rax (rbp tmp-ra.79))))
       (assignment ()))
      (begin (set! tmp-ra.79 r15) (set! rax 30) (jump tmp-ra.79 rbp rax)))
    (define L.fun/void17805.7
      ((locals (tmp-ra.80))
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80))))
       (assignment ()))
      (begin (set! tmp-ra.80 r15) (set! rax 30) (jump tmp-ra.80 rbp rax)))
    (define L.fun/empty17804.8
      ((locals (tmp-ra.81))
       (conflicts
        ((tmp-ra.81 (rax rbp)) (rbp (rax tmp-ra.81)) (rax (rbp tmp-ra.81))))
       (assignment ()))
      (begin (set! tmp-ra.81 r15) (set! rax 22) (jump tmp-ra.81 rbp rax)))
    (begin
      (set! tmp-ra.82 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void17802.6 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! void0.5 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/empty17803.4 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! empty1.4 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty17804.8 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! empty2.3 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void17805.7 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! void3.2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 992)
            (set! rdi 936)
            (set! r15 L.rp.17)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 416)
            (set! rdi 792)
            (set! r15 L.rp.18)
            (jump L.*.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.70)
            (set! rdi tmp.69)
            (set! r15 L.rp.19)
            (jump L.*.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.68 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi 792)
            (set! rdi 1936)
            (set! r15 L.rp.20)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi 1904)
            (set! rdi 472)
            (set! r15 L.rp.21)
            (jump L.*.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.72)
            (set! r15 L.rp.22)
            (jump L.*.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.71)
            (set! rdi tmp.68)
            (set! r15 L.rp.23)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! fixnum4.1 rax)
      (set! r15 tmp-ra.82)
      (jump L.fun/error17806.5 rbp r15))))
(check-by-interp
 '(module
    ((locals
      (tmp.65
       tmp.77
       tmp.66
       tmp.78
       tmp.63
       tmp.75
       tmp.64
       tmp.76
       boolean0.5
       error1.4
       void2.3
       fixnum3.2
       fixnum4.1
       tmp.62
       tmp.61))
     (conflicts
      ((tmp.61 (rbp tmp-ra.69))
       (tmp.62 (rbp tmp-ra.69))
       (fixnum4.1 (rbp tmp-ra.69))
       (fixnum3.2 (rbp tmp-ra.69))
       (void2.3 (rbp tmp-ra.69))
       (error1.4 (rbp tmp-ra.69))
       (boolean0.5 (rbp tmp-ra.69))
       (tmp-ra.69
        (rbp
         rax
         tmp.62
         fixnum4.1
         fixnum3.2
         void2.3
         error1.4
         boolean0.5
         tmp.61
         tmp.76
         tmp.64
         tmp.75
         tmp.63
         rdi
         rsi
         tmp.78
         tmp.66
         tmp.77
         tmp.65))
       (tmp.76 (rbp tmp-ra.69 tmp.63))
       (tmp.64 (rbp tmp-ra.69 tmp.63))
       (tmp.75 (rbp tmp-ra.69))
       (tmp.63 (rsi tmp.76 tmp.64 rbp tmp-ra.69))
       (tmp.78 (rbp tmp-ra.69 tmp.65))
       (tmp.66 (rbp tmp-ra.69 tmp.65))
       (tmp.77 (rbp tmp-ra.69))
       (tmp.65 (rsi tmp.78 tmp.66 rbp tmp-ra.69))
       (rbp
        (tmp-ra.69
         rax
         tmp.62
         fixnum4.1
         fixnum3.2
         void2.3
         error1.4
         boolean0.5
         tmp.61
         tmp.76
         tmp.64
         tmp.75
         tmp.63
         r15
         rdi
         rsi
         tmp.78
         tmp.66
         tmp.77
         tmp.65))
       (rsi (tmp.63 r15 rdi rbp tmp-ra.69 tmp.65))
       (rdi (r15 rbp rsi tmp-ra.69))
       (r15 (rbp rdi rsi))
       (rax (rbp tmp-ra.69))))
     (assignment ((tmp-ra.69 fv0))))
    (define L.*.6
      ((locals
        (tmp.57
         tmp.71
         tmp.19
         tmp.58
         tmp.73
         tmp.59
         tmp.72
         tmp-ra.67
         tmp.56
         tmp.20
         tmp.70
         tmp.55))
       (conflicts
        ((tmp.55 (rbp tmp-ra.67 tmp.19 tmp.20))
         (tmp.70 (tmp.20 rbp tmp-ra.67 tmp.19))
         (tmp.20
          (rbp tmp-ra.67 tmp.19 tmp.70 tmp.56 tmp.55 tmp.71 tmp.58 tmp.57))
         (tmp.56 (rbp tmp-ra.67 tmp.19 tmp.20))
         (tmp-ra.67
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.70
           tmp.56
           tmp.55
           tmp.71
           tmp.58
           tmp.57
           tmp.73
           tmp.59
           tmp.72
           rax))
         (tmp.72 (rbp tmp-ra.67 tmp.19))
         (tmp.59 (tmp.73 rbp tmp-ra.67 tmp.19))
         (tmp.73 (rbp tmp-ra.67 tmp.59))
         (tmp.58 (rbp tmp-ra.67 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.67
           rsi
           tmp.70
           tmp.56
           tmp.55
           tmp.71
           tmp.58
           tmp.57
           tmp.59
           tmp.72))
         (tmp.71 (tmp.19 rbp tmp-ra.67 tmp.20))
         (tmp.57 (rbp tmp-ra.67 tmp.19 tmp.20))
         (rax (rbp tmp-ra.67))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.67
           tmp.70
           tmp.56
           tmp.55
           tmp.71
           tmp.58
           tmp.57
           tmp.73
           tmp.59
           tmp.72
           rax))
         (rdi (tmp-ra.67))
         (rsi (tmp.19 tmp-ra.67))))
       (assignment ()))
      (begin
        (set! tmp-ra.67 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.70 tmp.20)
                      (set! tmp.70 (bitwise-and tmp.70 7))
                      (set! tmp.56 tmp.70))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.71 tmp.19)
                        (set! tmp.71 (bitwise-and tmp.71 7))
                        (set! tmp.58 tmp.71))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.72 tmp.20)
              (set! tmp.72 (arithmetic-shift-right tmp.72 3))
              (set! tmp.59 tmp.72)
              (set! tmp.73 tmp.19)
              (set! tmp.73 (* tmp.73 tmp.59))
              (set! rax tmp.73)
              (jump tmp-ra.67 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.67 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.67 rbp rax)))))
    (define L.void?.5
      ((locals (tmp-ra.68 tmp.74 tmp.45 tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.68))
         (tmp.45 (rbp tmp-ra.68))
         (tmp.74 (rbp tmp-ra.68))
         (tmp-ra.68 (tmp.45 rbp rdi tmp.74 tmp.60 rax))
         (rax (rbp tmp-ra.68))
         (rbp (tmp.45 tmp-ra.68 tmp.74 tmp.60 rax))
         (rdi (tmp-ra.68))))
       (assignment ()))
      (begin
        (set! tmp-ra.68 r15)
        (set! tmp.45 rdi)
        (if (begin
              (begin
                (set! tmp.74 tmp.45)
                (set! tmp.74 (bitwise-and tmp.74 255))
                (set! tmp.60 tmp.74))
              (= tmp.60 30))
          (begin (set! rax 14) (jump tmp-ra.68 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.68 rbp rax)))))
    (begin
      (set! tmp-ra.69 r15)
      (if (begin
            (begin
              (set! boolean0.5 14)
              (set! error1.4 830)
              (set! void2.3 30)
              (set! fixnum3.2 1512)
              (set! fixnum4.1 88)
              (set! tmp.62 30)
              (begin
                (set! rbp (- rbp 8))
                (return-point L.rp.7
                  (begin
                    (set! rdi tmp.62)
                    (set! r15 L.rp.7)
                    (jump L.void?.5 rbp r15 rdi)))
                (set! rbp (+ rbp 8)))
              (set! tmp.61 rax))
            (!= tmp.61 6))
        (begin
          (if (begin (set! tmp.75 14) (!= tmp.75 6))
            (set! tmp.63 400)
            (set! tmp.63 1200))
          (if (begin (set! tmp.76 14) (!= tmp.76 6))
            (set! tmp.64 1000)
            (set! tmp.64 1256))
          (set! rsi tmp.64)
          (set! rdi tmp.63)
          (set! r15 tmp-ra.69)
          (jump L.*.6 rbp r15 rdi rsi))
        (begin
          (if (begin (set! tmp.77 6) (!= tmp.77 6))
            (set! tmp.65 1464)
            (set! tmp.65 360))
          (if (begin (set! tmp.78 14) (!= tmp.78 6))
            (set! tmp.66 72)
            (set! tmp.66 816))
          (set! rsi tmp.66)
          (set! rdi tmp.65)
          (set! r15 tmp-ra.69)
          (jump L.*.6 rbp r15 rdi rsi))))))
(check-by-interp
 '(module
    ((locals (fixnum4.1 tmp.71 tmp.73 tmp.70 void2.3 void1.4 empty0.5))
     (conflicts
      ((tmp-ra.81
        (fixnum4.1
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         ascii-char3.2
         void2.3
         void1.4
         empty0.5
         rax
         rbp))
       (empty0.5 (rbp tmp-ra.81))
       (void1.4 (rbp tmp-ra.81))
       (void2.3 (rbp tmp-ra.81))
       (ascii-char3.2
        (fixnum4.1
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         rax
         rbp
         tmp-ra.81))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.81 ascii-char3.2))
       (tmp.70 (rbp tmp-ra.81 ascii-char3.2 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.81 ascii-char3.2))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.81 ascii-char3.2 tmp.68))
       (tmp.73 (rbp tmp-ra.81 ascii-char3.2 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.81 ascii-char3.2 tmp.68))
       (fixnum4.1 (rbp tmp-ra.81 ascii-char3.2))
       (rbp
        (fixnum4.1
         tmp.71
         tmp.73
         tmp.72
         tmp.68
         tmp.70
         tmp.69
         rdi
         rsi
         ascii-char3.2
         void2.3
         void1.4
         empty0.5
         r15
         rax
         tmp-ra.81))
       (rax (tmp.72 tmp.68 tmp.69 ascii-char3.2 rbp tmp-ra.81))
       (r15 (rdi rsi rbp))
       (rsi (tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.81 fv0)
       (ascii-char3.2 fv1)
       (tmp.72 fv2)
       (tmp.68 fv3)
       (tmp.69 fv2))))
    (define L.+.11
      ((locals
        (tmp.57
         tmp.83
         tmp.21
         tmp.58
         tmp.84
         tmp-ra.74
         tmp.56
         tmp.22
         tmp.82
         tmp.55))
       (conflicts
        ((tmp.55 (rbp tmp-ra.74 tmp.22 tmp.21))
         (tmp.82 (tmp.22 rbp tmp-ra.74 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.74
           tmp.21
           tmp.82
           tmp.56
           tmp.55
           tmp.83
           tmp.58
           tmp.57
           tmp.84))
         (tmp.56 (rbp tmp-ra.74 tmp.22 tmp.21))
         (tmp-ra.74
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.82
           tmp.56
           tmp.55
           tmp.83
           tmp.58
           tmp.57
           tmp.84
           rax))
         (tmp.84 (rbp tmp-ra.74 tmp.22))
         (tmp.58 (rbp tmp-ra.74 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.74 rsi tmp.82 tmp.56 tmp.55 tmp.83 tmp.58 tmp.57))
         (tmp.83 (tmp.21 rbp tmp-ra.74 tmp.22))
         (tmp.57 (rbp tmp-ra.74 tmp.22 tmp.21))
         (rax (rbp tmp-ra.74))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.74
           tmp.82
           tmp.56
           tmp.55
           tmp.83
           tmp.58
           tmp.57
           tmp.84
           rax))
         (rdi (tmp-ra.74))
         (rsi (tmp.21 tmp-ra.74))))
       (assignment ()))
      (begin
        (set! tmp-ra.74 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.82 tmp.22)
                      (set! tmp.82 (bitwise-and tmp.82 7))
                      (set! tmp.56 tmp.82))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.83 tmp.21)
                        (set! tmp.83 (bitwise-and tmp.83 7))
                        (set! tmp.58 tmp.83))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.84 tmp.21)
              (set! tmp.84 (+ tmp.84 tmp.22))
              (set! rax tmp.84)
              (jump tmp-ra.74 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.74 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.74 rbp rax)))))
    (define L.-.10
      ((locals
        (tmp.61
         tmp.86
         tmp.23
         tmp.62
         tmp.87
         tmp-ra.75
         tmp.60
         tmp.24
         tmp.85
         tmp.59))
       (conflicts
        ((tmp.59 (rbp tmp-ra.75 tmp.24 tmp.23))
         (tmp.85 (tmp.24 rbp tmp-ra.75 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.75
           tmp.23
           tmp.85
           tmp.60
           tmp.59
           tmp.86
           tmp.62
           tmp.61
           tmp.87))
         (tmp.60 (rbp tmp-ra.75 tmp.24 tmp.23))
         (tmp-ra.75
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.85
           tmp.60
           tmp.59
           tmp.86
           tmp.62
           tmp.61
           tmp.87
           rax))
         (tmp.87 (rbp tmp-ra.75 tmp.24))
         (tmp.62 (rbp tmp-ra.75 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.75 rsi tmp.85 tmp.60 tmp.59 tmp.86 tmp.62 tmp.61))
         (tmp.86 (tmp.23 rbp tmp-ra.75 tmp.24))
         (tmp.61 (rbp tmp-ra.75 tmp.24 tmp.23))
         (rax (rbp tmp-ra.75))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.75
           tmp.85
           tmp.60
           tmp.59
           tmp.86
           tmp.62
           tmp.61
           tmp.87
           rax))
         (rdi (tmp-ra.75))
         (rsi (tmp.23 tmp-ra.75))))
       (assignment ()))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.85 tmp.24)
                      (set! tmp.85 (bitwise-and tmp.85 7))
                      (set! tmp.60 tmp.85))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.86 tmp.23)
                        (set! tmp.86 (bitwise-and tmp.86 7))
                        (set! tmp.62 tmp.86))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.87 tmp.23)
              (set! tmp.87 (- tmp.87 tmp.24))
              (set! rax tmp.87)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.75 rbp rax)))))
    (define L.*.9
      ((locals
        (tmp.65
         tmp.89
         tmp.19
         tmp.66
         tmp.91
         tmp.67
         tmp.90
         tmp-ra.76
         tmp.64
         tmp.20
         tmp.88
         tmp.63))
       (conflicts
        ((tmp.63 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp.88 (tmp.20 rbp tmp-ra.76 tmp.19))
         (tmp.20
          (rbp tmp-ra.76 tmp.19 tmp.88 tmp.64 tmp.63 tmp.89 tmp.66 tmp.65))
         (tmp.64 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp-ra.76
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.88
           tmp.64
           tmp.63
           tmp.89
           tmp.66
           tmp.65
           tmp.91
           tmp.67
           tmp.90
           rax))
         (tmp.90 (rbp tmp-ra.76 tmp.19))
         (tmp.67 (tmp.91 rbp tmp-ra.76 tmp.19))
         (tmp.91 (rbp tmp-ra.76 tmp.67))
         (tmp.66 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.76
           rsi
           tmp.88
           tmp.64
           tmp.63
           tmp.89
           tmp.66
           tmp.65
           tmp.67
           tmp.90))
         (tmp.89 (tmp.19 rbp tmp-ra.76 tmp.20))
         (tmp.65 (rbp tmp-ra.76 tmp.19 tmp.20))
         (rax (rbp tmp-ra.76))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.76
           tmp.88
           tmp.64
           tmp.63
           tmp.89
           tmp.66
           tmp.65
           tmp.91
           tmp.67
           tmp.90
           rax))
         (rdi (tmp-ra.76))
         (rsi (tmp.19 tmp-ra.76))))
       (assignment ()))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.88 tmp.20)
                      (set! tmp.88 (bitwise-and tmp.88 7))
                      (set! tmp.64 tmp.88))
                    (= tmp.64 0))
                (set! tmp.63 14)
                (set! tmp.63 6))
              (!= tmp.63 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.89 tmp.19)
                        (set! tmp.89 (bitwise-and tmp.89 7))
                        (set! tmp.66 tmp.89))
                      (= tmp.66 0))
                  (set! tmp.65 14)
                  (set! tmp.65 6))
                (!= tmp.65 6))
            (begin
              (set! tmp.90 tmp.20)
              (set! tmp.90 (arithmetic-shift-right tmp.90 3))
              (set! tmp.67 tmp.90)
              (set! tmp.91 tmp.19)
              (set! tmp.91 (* tmp.91 tmp.67))
              (set! rax tmp.91)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))))
    (define L.fun/void20503.4
      ((locals (tmp-ra.77))
       (conflicts
        ((tmp-ra.77 (rax rbp)) (rbp (rax tmp-ra.77)) (rax (rbp tmp-ra.77))))
       (assignment ()))
      (begin (set! tmp-ra.77 r15) (set! rax 30) (jump tmp-ra.77 rbp rax)))
    (define L.fun/empty20501.5
      ((locals (tmp-ra.78))
       (conflicts
        ((tmp-ra.78 (rax rbp)) (rbp (rax tmp-ra.78)) (rax (rbp tmp-ra.78))))
       (assignment ()))
      (begin (set! tmp-ra.78 r15) (set! rax 22) (jump tmp-ra.78 rbp rax)))
    (define L.fun/ascii-char20504.6
      ((locals (tmp-ra.79))
       (conflicts
        ((tmp-ra.79 (rax rbp)) (rbp (rax tmp-ra.79)) (rax (rbp tmp-ra.79))))
       (assignment ()))
      (begin (set! tmp-ra.79 r15) (set! rax 25390) (jump tmp-ra.79 rbp rax)))
    (define L.fun/void20502.7
      ((locals (tmp-ra.80))
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80))))
       (assignment ()))
      (begin (set! tmp-ra.80 r15) (set! rax 30) (jump tmp-ra.80 rbp rax)))
    (begin
      (set! tmp-ra.81 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty20501.5 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! empty0.5 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void20502.7 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! void1.4 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void20503.4 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! void2.3 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/ascii-char20504.6 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! ascii-char3.2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi 1000)
            (set! rdi 144)
            (set! r15 L.rp.16)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi 1840)
            (set! rdi 1248)
            (set! r15 L.rp.17)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.70)
            (set! rdi tmp.69)
            (set! r15 L.rp.18)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.68 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi 1216)
            (set! rdi 88)
            (set! r15 L.rp.19)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin
            (set! rsi 784)
            (set! rdi 512)
            (set! r15 L.rp.20)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.72)
            (set! r15 L.rp.21)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.71)
            (set! rdi tmp.68)
            (set! r15 L.rp.22)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! fixnum4.1 rax)
      (set! rax ascii-char3.2)
      (jump tmp-ra.81 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (void5.1
       empty4.2
       empty3.3
       ascii-char1.5
       fixnum0.6
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72))
     (conflicts
      ((tmp-ra.96
        (void5.1
         empty4.2
         empty3.3
         error2.4
         ascii-char1.5
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
       (ascii-char1.5 (rbp tmp-ra.96))
       (error2.4 (void5.1 empty4.2 empty3.3 rax rbp tmp-ra.96))
       (empty3.3 (rbp tmp-ra.96 error2.4))
       (empty4.2 (rbp tmp-ra.96 error2.4))
       (void5.1 (rbp tmp-ra.96 error2.4))
       (rbp
        (void5.1
         empty4.2
         empty3.3
         error2.4
         ascii-char1.5
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
        (error2.4
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
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.96 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (error2.4 fv1)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.-.17
      ((locals
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
         (rsi (tmp.24 tmp-ra.83))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.22 tmp-ra.84))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.20 tmp-ra.85))))
       (assignment ()))
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
    (define L.fun/error28491.4
      ((locals (tmp-ra.86))
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86))))
       (assignment ()))
      (begin (set! tmp-ra.86 r15) (set! rax 45118) (jump tmp-ra.86 rbp rax)))
    (define L.fun/empty28492.5
      ((locals (tmp-ra.87))
       (conflicts ((tmp-ra.87 (rbp)) (rbp (r15 tmp-ra.87)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/empty28493.6 rbp r15)))
    (define L.fun/empty28493.6
      ((locals (tmp-ra.88))
       (conflicts
        ((tmp-ra.88 (rax rbp)) (rbp (rax tmp-ra.88)) (rax (rbp tmp-ra.88))))
       (assignment ()))
      (begin (set! tmp-ra.88 r15) (set! rax 22) (jump tmp-ra.88 rbp rax)))
    (define L.fun/empty28494.7
      ((locals (tmp-ra.89))
       (conflicts ((tmp-ra.89 (rbp)) (rbp (r15 tmp-ra.89)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/empty28495.12 rbp r15)))
    (define L.fun/ascii-char28488.8
      ((locals (tmp-ra.90))
       (conflicts ((tmp-ra.90 (rbp)) (rbp (r15 tmp-ra.90)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/ascii-char28489.13 rbp r15)))
    (define L.fun/error28490.9
      ((locals (tmp-ra.91))
       (conflicts ((tmp-ra.91 (rbp)) (rbp (r15 tmp-ra.91)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/error28491.4 rbp r15)))
    (define L.fun/void28497.10
      ((locals (tmp-ra.92))
       (conflicts
        ((tmp-ra.92 (rax rbp)) (rbp (rax tmp-ra.92)) (rax (rbp tmp-ra.92))))
       (assignment ()))
      (begin (set! tmp-ra.92 r15) (set! rax 30) (jump tmp-ra.92 rbp rax)))
    (define L.fun/void28496.11
      ((locals (tmp-ra.93))
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void28497.10 rbp r15)))
    (define L.fun/empty28495.12
      ((locals (tmp-ra.94))
       (conflicts
        ((tmp-ra.94 (rax rbp)) (rbp (rax tmp-ra.94)) (rax (rbp tmp-ra.94))))
       (assignment ()))
      (begin (set! tmp-ra.94 r15) (set! rax 22) (jump tmp-ra.94 rbp rax)))
    (define L.fun/ascii-char28489.13
      ((locals (tmp-ra.95))
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95))))
       (assignment ()))
      (begin (set! tmp-ra.95 r15) (set! rax 25390) (jump tmp-ra.95 rbp rax)))
    (begin
      (set! tmp-ra.96 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin
            (set! rsi 1616)
            (set! rdi 456)
            (set! r15 L.rp.18)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin
            (set! rsi 144)
            (set! rdi 912)
            (set! r15 L.rp.19)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.20)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi 928)
            (set! rdi 1048)
            (set! r15 L.rp.21)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 224)
            (set! rdi 1272)
            (set! r15 L.rp.22)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.23)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.24)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 224)
            (set! rdi 1872)
            (set! r15 L.rp.25)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 1528)
            (set! rdi 912)
            (set! r15 L.rp.26)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.27)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 320)
            (set! rdi 1672)
            (set! r15 L.rp.28)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 1280)
            (set! rdi 1352)
            (set! r15 L.rp.29)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.30)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.31)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.32)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! fixnum0.6 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/ascii-char28488.8 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! ascii-char1.5 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/error28490.9 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! error2.4 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/empty28492.5 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! empty3.3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/empty28494.7 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! empty4.2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/void28496.11 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! void5.1 rax)
      (set! rax error2.4)
      (jump tmp-ra.96 rbp rax))))
(check-by-interp
 '(module
    ((locals (error5.1 void3.3 ascii-char2.4 error1.5 ascii-char0.6))
     (conflicts
      ((tmp-ra.68
        (error5.1
         void4.2
         void3.3
         ascii-char2.4
         error1.5
         ascii-char0.6
         rax
         rbp))
       (ascii-char0.6 (rbp tmp-ra.68))
       (error1.5 (rbp tmp-ra.68))
       (ascii-char2.4 (rbp tmp-ra.68))
       (void3.3 (rbp tmp-ra.68))
       (void4.2 (error5.1 rax rbp tmp-ra.68))
       (error5.1 (rbp tmp-ra.68 void4.2))
       (rbp
        (error5.1
         void4.2
         void3.3
         ascii-char2.4
         error1.5
         ascii-char0.6
         r15
         rax
         tmp-ra.68))
       (rax (void4.2 rbp tmp-ra.68))
       (r15 (rbp))))
     (assignment ((tmp-ra.68 fv0) (void4.2 fv1))))
    (define L.fun/ascii-char28930.4
      ((locals (tmp-ra.56))
       (conflicts ((tmp-ra.56 (rbp)) (rbp (r15 tmp-ra.56)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.56 r15)
        (set! r15 tmp-ra.56)
        (jump L.fun/ascii-char28931.10 rbp r15)))
    (define L.fun/error28940.5
      ((locals (tmp-ra.57))
       (conflicts ((tmp-ra.57 (rbp)) (rbp (r15 tmp-ra.57)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.57 r15)
        (set! r15 tmp-ra.57)
        (jump L.fun/error28941.15 rbp r15)))
    (define L.fun/ascii-char28935.6
      ((locals (tmp-ra.58))
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ()))
      (begin (set! tmp-ra.58 r15) (set! rax 25390) (jump tmp-ra.58 rbp rax)))
    (define L.fun/void28936.7
      ((locals (tmp-ra.59))
       (conflicts ((tmp-ra.59 (rbp)) (rbp (r15 tmp-ra.59)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! r15 tmp-ra.59)
        (jump L.fun/void28937.11 rbp r15)))
    (define L.fun/void28938.8
      ((locals (tmp-ra.60))
       (conflicts ((tmp-ra.60 (rbp)) (rbp (r15 tmp-ra.60)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.60 r15)
        (set! r15 tmp-ra.60)
        (jump L.fun/void28939.14 rbp r15)))
    (define L.fun/error28933.9
      ((locals (tmp-ra.61))
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ()))
      (begin (set! tmp-ra.61 r15) (set! rax 44606) (jump tmp-ra.61 rbp rax)))
    (define L.fun/ascii-char28931.10
      ((locals (tmp-ra.62))
       (conflicts
        ((tmp-ra.62 (rax rbp)) (rbp (rax tmp-ra.62)) (rax (rbp tmp-ra.62))))
       (assignment ()))
      (begin (set! tmp-ra.62 r15) (set! rax 25390) (jump tmp-ra.62 rbp rax)))
    (define L.fun/void28937.11
      ((locals (tmp-ra.63))
       (conflicts
        ((tmp-ra.63 (rax rbp)) (rbp (rax tmp-ra.63)) (rax (rbp tmp-ra.63))))
       (assignment ()))
      (begin (set! tmp-ra.63 r15) (set! rax 30) (jump tmp-ra.63 rbp rax)))
    (define L.fun/ascii-char28934.12
      ((locals (tmp-ra.64))
       (conflicts ((tmp-ra.64 (rbp)) (rbp (r15 tmp-ra.64)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.64 r15)
        (set! r15 tmp-ra.64)
        (jump L.fun/ascii-char28935.6 rbp r15)))
    (define L.fun/error28932.13
      ((locals (tmp-ra.65))
       (conflicts ((tmp-ra.65 (rbp)) (rbp (r15 tmp-ra.65)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/error28933.9 rbp r15)))
    (define L.fun/void28939.14
      ((locals (tmp-ra.66))
       (conflicts
        ((tmp-ra.66 (rax rbp)) (rbp (rax tmp-ra.66)) (rax (rbp tmp-ra.66))))
       (assignment ()))
      (begin (set! tmp-ra.66 r15) (set! rax 30) (jump tmp-ra.66 rbp rax)))
    (define L.fun/error28941.15
      ((locals (tmp-ra.67))
       (conflicts
        ((tmp-ra.67 (rax rbp)) (rbp (rax tmp-ra.67)) (rax (rbp tmp-ra.67))))
       (assignment ()))
      (begin (set! tmp-ra.67 r15) (set! rax 62526) (jump tmp-ra.67 rbp rax)))
    (begin
      (set! tmp-ra.68 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char28930.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char0.6 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error28932.13 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char28934.12 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char2.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void28936.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void28938.8 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void4.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error28940.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error5.1 rax)
      (set! rax void4.2)
      (jump tmp-ra.68 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (void5.1
       fixnum4.2
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72
       empty3.3
       error2.4
       error1.5
       empty0.6))
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
         empty3.3
         error2.4
         error1.5
         empty0.6
         rax
         rbp))
       (empty0.6 (rbp tmp-ra.96))
       (error1.5 (rbp tmp-ra.96))
       (error2.4 (rbp tmp-ra.96))
       (empty3.3 (rbp tmp-ra.96))
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
       (fixnum4.2 (rbp tmp-ra.96))
       (void5.1 (rbp tmp-ra.96))
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
         empty3.3
         error2.4
         error1.5
         empty0.6
         r15
         rax
         tmp-ra.96))
       (rax (tmp.81 tmp.77 tmp.78 tmp.69 tmp.74 tmp.70 tmp.71 rbp tmp-ra.96))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.96 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.+.17
      ((locals
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
         (rsi (tmp.22 tmp-ra.83))))
       (assignment ()))
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
    (define L.*.16
      ((locals
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
         (rsi (tmp.20 tmp-ra.84))))
       (assignment ()))
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
    (define L.-.15
      ((locals
        (tmp.67
         tmp.105
         tmp.24
         tmp.68
         tmp.106
         tmp-ra.85
         tmp.66
         tmp.25
         tmp.104
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.104 (tmp.25 rbp tmp-ra.85 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.85
           tmp.24
           tmp.104
           tmp.66
           tmp.65
           tmp.105
           tmp.68
           tmp.67
           tmp.106))
         (tmp.66 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp-ra.85
          (tmp.25
           tmp.24
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
         (tmp.106 (rbp tmp-ra.85 tmp.25))
         (tmp.68 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.85
           rsi
           tmp.104
           tmp.66
           tmp.65
           tmp.105
           tmp.68
           tmp.67))
         (tmp.105 (tmp.24 rbp tmp-ra.85 tmp.25))
         (tmp.67 (rbp tmp-ra.85 tmp.25 tmp.24))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.25
           tmp.24
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
         (rsi (tmp.24 tmp-ra.85))))
       (assignment ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.25)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.66 tmp.104))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.24)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.68 tmp.105))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.106 tmp.24)
              (set! tmp.106 (- tmp.106 tmp.25))
              (set! rax tmp.106)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/empty30828.4
      ((locals (tmp-ra.86))
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86))))
       (assignment ()))
      (begin (set! tmp-ra.86 r15) (set! rax 22) (jump tmp-ra.86 rbp rax)))
    (define L.fun/empty30827.5
      ((locals (tmp-ra.87))
       (conflicts ((tmp-ra.87 (rbp)) (rbp (r15 tmp-ra.87)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/empty30828.4 rbp r15)))
    (define L.fun/void30829.6
      ((locals (tmp-ra.88))
       (conflicts ((tmp-ra.88 (rbp)) (rbp (r15 tmp-ra.88)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/void30830.12 rbp r15)))
    (define L.fun/error30825.7
      ((locals (tmp-ra.89))
       (conflicts ((tmp-ra.89 (rbp)) (rbp (r15 tmp-ra.89)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/error30826.11 rbp r15)))
    (define L.fun/error30824.8
      ((locals (tmp-ra.90))
       (conflicts
        ((tmp-ra.90 (rax rbp)) (rbp (rax tmp-ra.90)) (rax (rbp tmp-ra.90))))
       (assignment ()))
      (begin (set! tmp-ra.90 r15) (set! rax 31294) (jump tmp-ra.90 rbp rax)))
    (define L.fun/empty30822.9
      ((locals (tmp-ra.91))
       (conflicts
        ((tmp-ra.91 (rax rbp)) (rbp (rax tmp-ra.91)) (rax (rbp tmp-ra.91))))
       (assignment ()))
      (begin (set! tmp-ra.91 r15) (set! rax 22) (jump tmp-ra.91 rbp rax)))
    (define L.fun/error30823.10
      ((locals (tmp-ra.92))
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/error30824.8 rbp r15)))
    (define L.fun/error30826.11
      ((locals (tmp-ra.93))
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93))))
       (assignment ()))
      (begin (set! tmp-ra.93 r15) (set! rax 28734) (jump tmp-ra.93 rbp rax)))
    (define L.fun/void30830.12
      ((locals (tmp-ra.94))
       (conflicts
        ((tmp-ra.94 (rax rbp)) (rbp (rax tmp-ra.94)) (rax (rbp tmp-ra.94))))
       (assignment ()))
      (begin (set! tmp-ra.94 r15) (set! rax 30) (jump tmp-ra.94 rbp rax)))
    (define L.fun/empty30821.13
      ((locals (tmp-ra.95))
       (conflicts ((tmp-ra.95 (rbp)) (rbp (r15 tmp-ra.95)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/empty30822.9 rbp r15)))
    (begin
      (set! tmp-ra.96 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/empty30821.13 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty0.6 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error30823.10 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error30825.7 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! error2.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty30827.5 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty3.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1424)
            (set! rdi 1560)
            (set! r15 L.rp.22)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi 1440)
            (set! rdi 488)
            (set! r15 L.rp.23)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.24)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 432)
            (set! rdi 1008)
            (set! r15 L.rp.25)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 664)
            (set! rdi 760)
            (set! r15 L.rp.26)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.27)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.28)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 408)
            (set! rdi 1368)
            (set! r15 L.rp.29)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi 2016)
            (set! rdi 552)
            (set! r15 L.rp.30)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.31)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 1168)
            (set! rdi 528)
            (set! r15 L.rp.32)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 1424)
            (set! rdi 1872)
            (set! r15 L.rp.33)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.34)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.35)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.36)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/void30829.6 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void5.1 rax)
      (set! rax void5.1)
      (jump tmp-ra.96 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (fixnum5.1
       tmp.104
       tmp.108
       tmp.110
       tmp.107
       tmp.101
       tmp.103
       tmp.100
       void4.2
       empty2.4
       fixnum1.5
       tmp.90
       tmp.94
       tmp.96
       tmp.93
       tmp.87
       tmp.89
       tmp.86
       fixnum0.6
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72))
     (conflicts
      ((tmp-ra.120
        (fixnum5.1
         tmp.104
         tmp.108
         tmp.110
         tmp.109
         tmp.105
         tmp.107
         tmp.106
         tmp.97
         tmp.101
         tmp.103
         tmp.102
         tmp.98
         tmp.100
         tmp.99
         void4.2
         void3.3
         empty2.4
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
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.120))
       (tmp.72 (rbp tmp-ra.120 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.120))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.120 tmp.70))
       (tmp.75 (rbp tmp-ra.120 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.120 tmp.70))
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
         tmp-ra.120))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.120 tmp.69))
       (tmp.79 (rbp tmp-ra.120 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.120 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.120 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.120 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.120 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.120 tmp.69))
       (fixnum0.6 (rbp tmp-ra.120))
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.120))
       (tmp.86 (rbp tmp-ra.120 tmp.85))
       (tmp.84 (rsi tmp.87 tmp.89 tmp.88 rax rbp tmp-ra.120))
       (tmp.88 (rsi tmp.89 rax rbp tmp-ra.120 tmp.84))
       (tmp.89 (rbp tmp-ra.120 tmp.84 tmp.88))
       (tmp.87 (rbp tmp-ra.120 tmp.84))
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
         tmp-ra.120))
       (tmp.92 (rsi tmp.93 rax rbp tmp-ra.120 tmp.83))
       (tmp.93 (rbp tmp-ra.120 tmp.83 tmp.92))
       (tmp.91 (rsi tmp.94 tmp.96 tmp.95 rax rbp tmp-ra.120 tmp.83))
       (tmp.95 (rsi tmp.96 rax rbp tmp-ra.120 tmp.83 tmp.91))
       (tmp.96 (rbp tmp-ra.120 tmp.83 tmp.91 tmp.95))
       (tmp.94 (rbp tmp-ra.120 tmp.83 tmp.91))
       (tmp.90 (rbp tmp-ra.120 tmp.83))
       (fixnum1.5 (rbp tmp-ra.120))
       (empty2.4 (rbp tmp-ra.120))
       (void3.3
        (fixnum5.1
         tmp.104
         tmp.108
         tmp.110
         tmp.109
         tmp.105
         tmp.107
         tmp.106
         tmp.97
         tmp.101
         tmp.103
         tmp.102
         tmp.98
         tmp.100
         tmp.99
         void4.2
         rax
         rbp
         tmp-ra.120))
       (void4.2 (rbp tmp-ra.120 void3.3))
       (tmp.99 (rsi tmp.100 rax rbp tmp-ra.120 void3.3))
       (tmp.100 (rbp tmp-ra.120 void3.3 tmp.99))
       (tmp.98 (rsi tmp.101 tmp.103 tmp.102 rax rbp tmp-ra.120 void3.3))
       (tmp.102 (rsi tmp.103 rax rbp tmp-ra.120 void3.3 tmp.98))
       (tmp.103 (rbp tmp-ra.120 void3.3 tmp.98 tmp.102))
       (tmp.101 (rbp tmp-ra.120 void3.3 tmp.98))
       (tmp.97
        (rsi
         tmp.104
         tmp.108
         tmp.110
         tmp.109
         tmp.105
         tmp.107
         tmp.106
         rax
         rbp
         tmp-ra.120
         void3.3))
       (tmp.106 (rsi tmp.107 rax rbp tmp-ra.120 void3.3 tmp.97))
       (tmp.107 (rbp tmp-ra.120 void3.3 tmp.97 tmp.106))
       (tmp.105
        (rsi tmp.108 tmp.110 tmp.109 rax rbp tmp-ra.120 void3.3 tmp.97))
       (tmp.109 (rsi tmp.110 rax rbp tmp-ra.120 void3.3 tmp.97 tmp.105))
       (tmp.110 (rbp tmp-ra.120 void3.3 tmp.97 tmp.105 tmp.109))
       (tmp.108 (rbp tmp-ra.120 void3.3 tmp.97 tmp.105))
       (tmp.104 (rbp tmp-ra.120 void3.3 tmp.97))
       (fixnum5.1 (rbp tmp-ra.120 void3.3))
       (rbp
        (fixnum5.1
         tmp.104
         tmp.108
         tmp.110
         tmp.109
         tmp.105
         tmp.107
         tmp.106
         tmp.97
         tmp.101
         tmp.103
         tmp.102
         tmp.98
         tmp.100
         tmp.99
         void4.2
         void3.3
         empty2.4
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
         tmp-ra.120))
       (rax
        (tmp.109
         tmp.105
         tmp.106
         tmp.97
         tmp.102
         tmp.98
         tmp.99
         void3.3
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
         tmp-ra.120))
       (rsi
        (tmp.97
         tmp.105
         tmp.109
         tmp.106
         tmp.98
         tmp.102
         tmp.99
         tmp.83
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
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.120 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.85 fv1)
       (tmp.84 fv1)
       (tmp.83 fv1)
       (tmp.95 fv2)
       (void3.3 fv1)
       (tmp.99 fv2)
       (tmp.98 fv2)
       (tmp.97 fv2)
       (tmp.109 fv3)
       (tmp.105 fv4)
       (tmp.106 fv3)
       (tmp.102 fv3)
       (tmp.91 fv3)
       (tmp.92 fv2)
       (tmp.88 fv2)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.-.13
      ((locals
        (tmp.58
         tmp.122
         tmp.24
         tmp.59
         tmp.123
         tmp-ra.111
         tmp.57
         tmp.25
         tmp.121
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.111 tmp.25 tmp.24))
         (tmp.121 (tmp.25 rbp tmp-ra.111 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.111
           tmp.24
           tmp.121
           tmp.57
           tmp.56
           tmp.122
           tmp.59
           tmp.58
           tmp.123))
         (tmp.57 (rbp tmp-ra.111 tmp.25 tmp.24))
         (tmp-ra.111
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.121
           tmp.57
           tmp.56
           tmp.122
           tmp.59
           tmp.58
           tmp.123
           rax))
         (tmp.123 (rbp tmp-ra.111 tmp.25))
         (tmp.59 (rbp tmp-ra.111 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.111
           rsi
           tmp.121
           tmp.57
           tmp.56
           tmp.122
           tmp.59
           tmp.58))
         (tmp.122 (tmp.24 rbp tmp-ra.111 tmp.25))
         (tmp.58 (rbp tmp-ra.111 tmp.25 tmp.24))
         (rax (rbp tmp-ra.111))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.111
           tmp.121
           tmp.57
           tmp.56
           tmp.122
           tmp.59
           tmp.58
           tmp.123
           rax))
         (rdi (tmp-ra.111))
         (rsi (tmp.24 tmp-ra.111))))
       (assignment ()))
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
      ((locals
        (tmp.62
         tmp.125
         tmp.20
         tmp.63
         tmp.127
         tmp.64
         tmp.126
         tmp-ra.112
         tmp.61
         tmp.21
         tmp.124
         tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.112 tmp.20 tmp.21))
         (tmp.124 (tmp.21 rbp tmp-ra.112 tmp.20))
         (tmp.21
          (rbp tmp-ra.112 tmp.20 tmp.124 tmp.61 tmp.60 tmp.125 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.112 tmp.20 tmp.21))
         (tmp-ra.112
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.124
           tmp.61
           tmp.60
           tmp.125
           tmp.63
           tmp.62
           tmp.127
           tmp.64
           tmp.126
           rax))
         (tmp.126 (rbp tmp-ra.112 tmp.20))
         (tmp.64 (tmp.127 rbp tmp-ra.112 tmp.20))
         (tmp.127 (rbp tmp-ra.112 tmp.64))
         (tmp.63 (rbp tmp-ra.112 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.112
           rsi
           tmp.124
           tmp.61
           tmp.60
           tmp.125
           tmp.63
           tmp.62
           tmp.64
           tmp.126))
         (tmp.125 (tmp.20 rbp tmp-ra.112 tmp.21))
         (tmp.62 (rbp tmp-ra.112 tmp.20 tmp.21))
         (rax (rbp tmp-ra.112))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.112
           tmp.124
           tmp.61
           tmp.60
           tmp.125
           tmp.63
           tmp.62
           tmp.127
           tmp.64
           tmp.126
           rax))
         (rdi (tmp-ra.112))
         (rsi (tmp.20 tmp-ra.112))))
       (assignment ()))
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
      ((locals
        (tmp.67
         tmp.129
         tmp.22
         tmp.68
         tmp.130
         tmp-ra.113
         tmp.66
         tmp.23
         tmp.128
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.113 tmp.23 tmp.22))
         (tmp.128 (tmp.23 rbp tmp-ra.113 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.113
           tmp.22
           tmp.128
           tmp.66
           tmp.65
           tmp.129
           tmp.68
           tmp.67
           tmp.130))
         (tmp.66 (rbp tmp-ra.113 tmp.23 tmp.22))
         (tmp-ra.113
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.128
           tmp.66
           tmp.65
           tmp.129
           tmp.68
           tmp.67
           tmp.130
           rax))
         (tmp.130 (rbp tmp-ra.113 tmp.23))
         (tmp.68 (rbp tmp-ra.113 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.113
           rsi
           tmp.128
           tmp.66
           tmp.65
           tmp.129
           tmp.68
           tmp.67))
         (tmp.129 (tmp.22 rbp tmp-ra.113 tmp.23))
         (tmp.67 (rbp tmp-ra.113 tmp.23 tmp.22))
         (rax (rbp tmp-ra.113))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.113
           tmp.128
           tmp.66
           tmp.65
           tmp.129
           tmp.68
           tmp.67
           tmp.130
           rax))
         (rdi (tmp-ra.113))
         (rsi (tmp.22 tmp-ra.113))))
       (assignment ()))
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
    (define L.fun/void31698.4
      ((locals (tmp-ra.114))
       (conflicts ((tmp-ra.114 (rbp)) (rbp (r15 tmp-ra.114)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.114 r15)
        (set! r15 tmp-ra.114)
        (jump L.fun/void31699.8 rbp r15)))
    (define L.fun/void31701.5
      ((locals (tmp-ra.115))
       (conflicts
        ((tmp-ra.115 (rax rbp)) (rbp (rax tmp-ra.115)) (rax (rbp tmp-ra.115))))
       (assignment ()))
      (begin (set! tmp-ra.115 r15) (set! rax 30) (jump tmp-ra.115 rbp rax)))
    (define L.fun/void31700.6
      ((locals (tmp-ra.116))
       (conflicts ((tmp-ra.116 (rbp)) (rbp (r15 tmp-ra.116)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.116 r15)
        (set! r15 tmp-ra.116)
        (jump L.fun/void31701.5 rbp r15)))
    (define L.fun/empty31697.7
      ((locals (tmp-ra.117))
       (conflicts
        ((tmp-ra.117 (rax rbp)) (rbp (rax tmp-ra.117)) (rax (rbp tmp-ra.117))))
       (assignment ()))
      (begin (set! tmp-ra.117 r15) (set! rax 22) (jump tmp-ra.117 rbp rax)))
    (define L.fun/void31699.8
      ((locals (tmp-ra.118))
       (conflicts
        ((tmp-ra.118 (rax rbp)) (rbp (rax tmp-ra.118)) (rax (rbp tmp-ra.118))))
       (assignment ()))
      (begin (set! tmp-ra.118 r15) (set! rax 30) (jump tmp-ra.118 rbp rax)))
    (define L.fun/empty31696.9
      ((locals (tmp-ra.119))
       (conflicts ((tmp-ra.119 (rbp)) (rbp (r15 tmp-ra.119)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.119 r15)
        (set! r15 tmp-ra.119)
        (jump L.fun/empty31697.7 rbp r15)))
    (begin
      (set! tmp-ra.120 r15)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.14
          (begin
            (set! rsi 1264)
            (set! rdi 608)
            (set! r15 L.rp.14)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.15
          (begin
            (set! rsi 1424)
            (set! rdi 800)
            (set! r15 L.rp.15)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.16
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.16)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.17
          (begin
            (set! rsi 360)
            (set! rdi 1392)
            (set! r15 L.rp.17)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.18
          (begin
            (set! rsi 1936)
            (set! rdi 1416)
            (set! r15 L.rp.18)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.19)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.20)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.21
          (begin
            (set! rsi 1840)
            (set! rdi 760)
            (set! r15 L.rp.21)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.22
          (begin
            (set! rsi 1968)
            (set! rdi 1616)
            (set! r15 L.rp.22)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.23)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.24
          (begin
            (set! rsi 1792)
            (set! rdi 360)
            (set! r15 L.rp.24)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.25
          (begin
            (set! rsi 1480)
            (set! rdi 896)
            (set! r15 L.rp.25)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.26)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.27)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.28
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.28)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! fixnum0.6 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.29
          (begin
            (set! rsi 968)
            (set! rdi 1584)
            (set! r15 L.rp.29)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.30
          (begin
            (set! rsi 1624)
            (set! rdi 928)
            (set! r15 L.rp.30)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.86)
            (set! rdi tmp.85)
            (set! r15 L.rp.31)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.32
          (begin
            (set! rsi 1432)
            (set! rdi 656)
            (set! r15 L.rp.32)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.33
          (begin
            (set! rsi 208)
            (set! rdi 784)
            (set! r15 L.rp.33)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.34
          (begin
            (set! rsi tmp.89)
            (set! rdi tmp.88)
            (set! r15 L.rp.34)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.35
          (begin
            (set! rsi tmp.87)
            (set! rdi tmp.84)
            (set! r15 L.rp.35)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.36
          (begin
            (set! rsi 1192)
            (set! rdi 192)
            (set! r15 L.rp.36)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.37
          (begin
            (set! rsi 1872)
            (set! rdi 1424)
            (set! r15 L.rp.37)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.93)
            (set! rdi tmp.92)
            (set! r15 L.rp.38)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.39
          (begin
            (set! rsi 88)
            (set! rdi 176)
            (set! r15 L.rp.39)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.40
          (begin
            (set! rsi 1120)
            (set! rdi 912)
            (set! r15 L.rp.40)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.41
          (begin
            (set! rsi tmp.96)
            (set! rdi tmp.95)
            (set! r15 L.rp.41)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.42
          (begin
            (set! rsi tmp.94)
            (set! rdi tmp.91)
            (set! r15 L.rp.42)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.43
          (begin
            (set! rsi tmp.90)
            (set! rdi tmp.83)
            (set! r15 L.rp.43)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! fixnum1.5 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.44
          (begin (set! r15 L.rp.44) (jump L.fun/empty31696.9 rbp r15)))
        (set! rbp (+ rbp 184)))
      (set! empty2.4 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.45
          (begin (set! r15 L.rp.45) (jump L.fun/void31698.4 rbp r15)))
        (set! rbp (+ rbp 184)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.46
          (begin (set! r15 L.rp.46) (jump L.fun/void31700.6 rbp r15)))
        (set! rbp (+ rbp 184)))
      (set! void4.2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.47
          (begin
            (set! rsi 896)
            (set! rdi 640)
            (set! r15 L.rp.47)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.99 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.48
          (begin
            (set! rsi 88)
            (set! rdi 1112)
            (set! r15 L.rp.48)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.100 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.49
          (begin
            (set! rsi tmp.100)
            (set! rdi tmp.99)
            (set! r15 L.rp.49)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.98 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.50
          (begin
            (set! rsi 1928)
            (set! rdi 1952)
            (set! r15 L.rp.50)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.102 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.51
          (begin
            (set! rsi 1384)
            (set! rdi 1552)
            (set! r15 L.rp.51)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.103 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.52
          (begin
            (set! rsi tmp.103)
            (set! rdi tmp.102)
            (set! r15 L.rp.52)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.101 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.53
          (begin
            (set! rsi tmp.101)
            (set! rdi tmp.98)
            (set! r15 L.rp.53)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.97 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.54
          (begin
            (set! rsi 960)
            (set! rdi 272)
            (set! r15 L.rp.54)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.106 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.55
          (begin
            (set! rsi 1392)
            (set! rdi 1216)
            (set! r15 L.rp.55)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.107 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.56
          (begin
            (set! rsi tmp.107)
            (set! rdi tmp.106)
            (set! r15 L.rp.56)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.105 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.57
          (begin
            (set! rsi 1432)
            (set! rdi 1152)
            (set! r15 L.rp.57)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.109 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.58
          (begin
            (set! rsi 832)
            (set! rdi 1216)
            (set! r15 L.rp.58)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.110 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.59
          (begin
            (set! rsi tmp.110)
            (set! rdi tmp.109)
            (set! r15 L.rp.59)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.108 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.60
          (begin
            (set! rsi tmp.108)
            (set! rdi tmp.105)
            (set! r15 L.rp.60)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! tmp.104 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.61
          (begin
            (set! rsi tmp.104)
            (set! rdi tmp.97)
            (set! r15 L.rp.61)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 184)))
      (set! fixnum5.1 rax)
      (set! rax void3.3)
      (jump tmp-ra.120 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (boolean5.1
       tmp.98
       fixnum4.2
       tmp.91
       tmp.95
       tmp.97
       tmp.94
       tmp.88
       tmp.90
       tmp.87
       fixnum2.4
       tmp.77
       tmp.81
       tmp.83
       tmp.80
       tmp.74
       tmp.76
       tmp.73
       error1.5
       empty0.6))
     (conflicts
      ((tmp-ra.110
        (boolean5.1
         tmp.98
         fixnum4.2
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
         void3.3
         fixnum2.4
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
         error1.5
         empty0.6
         rax
         rbp))
       (empty0.6 (rbp tmp-ra.110))
       (error1.5 (rbp tmp-ra.110))
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
       (fixnum2.4 (rbp tmp-ra.110))
       (void3.3
        (boolean5.1
         tmp.98
         fixnum4.2
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
         tmp-ra.110))
       (tmp.86 (rsi tmp.87 rax rbp tmp-ra.110 void3.3))
       (tmp.87 (rbp tmp-ra.110 void3.3 tmp.86))
       (tmp.85 (rsi tmp.88 tmp.90 tmp.89 rax rbp tmp-ra.110 void3.3))
       (tmp.89 (rsi tmp.90 rax rbp tmp-ra.110 void3.3 tmp.85))
       (tmp.90 (rbp tmp-ra.110 void3.3 tmp.85 tmp.89))
       (tmp.88 (rbp tmp-ra.110 void3.3 tmp.85))
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
         tmp-ra.110
         void3.3))
       (tmp.93 (rsi tmp.94 rax rbp tmp-ra.110 void3.3 tmp.84))
       (tmp.94 (rbp tmp-ra.110 void3.3 tmp.84 tmp.93))
       (tmp.92 (rsi tmp.95 tmp.97 tmp.96 rax rbp tmp-ra.110 void3.3 tmp.84))
       (tmp.96 (rsi tmp.97 rax rbp tmp-ra.110 void3.3 tmp.84 tmp.92))
       (tmp.97 (rbp tmp-ra.110 void3.3 tmp.84 tmp.92 tmp.96))
       (tmp.95 (rbp tmp-ra.110 void3.3 tmp.84 tmp.92))
       (tmp.91 (rbp tmp-ra.110 void3.3 tmp.84))
       (fixnum4.2 (rbp tmp-ra.110 void3.3))
       (tmp.98 (rbp tmp-ra.110 void3.3))
       (boolean5.1 (rbp tmp-ra.110 void3.3))
       (rbp
        (boolean5.1
         tmp.98
         fixnum4.2
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
         void3.3
         fixnum2.4
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
         rdi
         rsi
         error1.5
         empty0.6
         r15
         rax
         tmp-ra.110))
       (rax
        (tmp.96
         tmp.92
         tmp.93
         tmp.84
         tmp.89
         tmp.85
         tmp.86
         void3.3
         tmp.82
         tmp.78
         tmp.79
         tmp.70
         tmp.75
         tmp.71
         tmp.72
         rbp
         tmp-ra.110))
       (r15 (rdi rsi rbp))
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
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.110 fv0)
       (tmp.75 fv1)
       (tmp.79 fv1)
       (tmp.78 fv1)
       (void3.3 fv1)
       (tmp.89 fv2)
       (tmp.93 fv2)
       (tmp.92 fv2)
       (tmp.96 fv3)
       (tmp.84 fv4)
       (tmp.85 fv3)
       (tmp.86 fv2)
       (tmp.82 fv2)
       (tmp.70 fv3)
       (tmp.71 fv2)
       (tmp.72 fv1))))
    (define L.pair?.15
      ((locals (tmp-ra.99 tmp.111 tmp.49 tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.99))
         (tmp.49 (rbp tmp-ra.99))
         (tmp.111 (rbp tmp-ra.99))
         (tmp-ra.99 (tmp.49 rbp rdi tmp.111 tmp.56 rax))
         (rax (rbp tmp-ra.99))
         (rbp (tmp.49 tmp-ra.99 tmp.111 tmp.56 rax))
         (rdi (tmp-ra.99))))
       (assignment ()))
      (begin
        (set! tmp-ra.99 r15)
        (set! tmp.49 rdi)
        (if (begin
              (begin
                (set! tmp.111 tmp.49)
                (set! tmp.111 (bitwise-and tmp.111 7))
                (set! tmp.56 tmp.111))
              (= tmp.56 1))
          (begin (set! rax 14) (jump tmp-ra.99 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.99 rbp rax)))))
    (define L.-.14
      ((locals
        (tmp.59
         tmp.113
         tmp.24
         tmp.60
         tmp.114
         tmp-ra.100
         tmp.58
         tmp.25
         tmp.112
         tmp.57))
       (conflicts
        ((tmp.57 (rbp tmp-ra.100 tmp.25 tmp.24))
         (tmp.112 (tmp.25 rbp tmp-ra.100 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.100
           tmp.24
           tmp.112
           tmp.58
           tmp.57
           tmp.113
           tmp.60
           tmp.59
           tmp.114))
         (tmp.58 (rbp tmp-ra.100 tmp.25 tmp.24))
         (tmp-ra.100
          (tmp.25
           tmp.24
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
         (tmp.114 (rbp tmp-ra.100 tmp.25))
         (tmp.60 (rbp tmp-ra.100 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.100
           rsi
           tmp.112
           tmp.58
           tmp.57
           tmp.113
           tmp.60
           tmp.59))
         (tmp.113 (tmp.24 rbp tmp-ra.100 tmp.25))
         (tmp.59 (rbp tmp-ra.100 tmp.25 tmp.24))
         (rax (rbp tmp-ra.100))
         (rbp
          (tmp.25
           tmp.24
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
         (rsi (tmp.24 tmp-ra.100))))
       (assignment ()))
      (begin
        (set! tmp-ra.100 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.112 tmp.25)
                      (set! tmp.112 (bitwise-and tmp.112 7))
                      (set! tmp.58 tmp.112))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.113 tmp.24)
                        (set! tmp.113 (bitwise-and tmp.113 7))
                        (set! tmp.60 tmp.113))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.114 tmp.24)
              (set! tmp.114 (- tmp.114 tmp.25))
              (set! rax tmp.114)
              (jump tmp-ra.100 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.100 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.100 rbp rax)))))
    (define L.+.13
      ((locals
        (tmp.63
         tmp.116
         tmp.22
         tmp.64
         tmp.117
         tmp-ra.101
         tmp.62
         tmp.23
         tmp.115
         tmp.61))
       (conflicts
        ((tmp.61 (rbp tmp-ra.101 tmp.23 tmp.22))
         (tmp.115 (tmp.23 rbp tmp-ra.101 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.101
           tmp.22
           tmp.115
           tmp.62
           tmp.61
           tmp.116
           tmp.64
           tmp.63
           tmp.117))
         (tmp.62 (rbp tmp-ra.101 tmp.23 tmp.22))
         (tmp-ra.101
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.115
           tmp.62
           tmp.61
           tmp.116
           tmp.64
           tmp.63
           tmp.117
           rax))
         (tmp.117 (rbp tmp-ra.101 tmp.23))
         (tmp.64 (rbp tmp-ra.101 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.101
           rsi
           tmp.115
           tmp.62
           tmp.61
           tmp.116
           tmp.64
           tmp.63))
         (tmp.116 (tmp.22 rbp tmp-ra.101 tmp.23))
         (tmp.63 (rbp tmp-ra.101 tmp.23 tmp.22))
         (rax (rbp tmp-ra.101))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.101
           tmp.115
           tmp.62
           tmp.61
           tmp.116
           tmp.64
           tmp.63
           tmp.117
           rax))
         (rdi (tmp-ra.101))
         (rsi (tmp.22 tmp-ra.101))))
       (assignment ()))
      (begin
        (set! tmp-ra.101 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.115 tmp.23)
                      (set! tmp.115 (bitwise-and tmp.115 7))
                      (set! tmp.62 tmp.115))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.116 tmp.22)
                        (set! tmp.116 (bitwise-and tmp.116 7))
                        (set! tmp.64 tmp.116))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.117 tmp.22)
              (set! tmp.117 (+ tmp.117 tmp.23))
              (set! rax tmp.117)
              (jump tmp-ra.101 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.101 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.101 rbp rax)))))
    (define L.*.12
      ((locals
        (tmp.67
         tmp.119
         tmp.20
         tmp.68
         tmp.121
         tmp.69
         tmp.120
         tmp-ra.102
         tmp.66
         tmp.21
         tmp.118
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.102 tmp.20 tmp.21))
         (tmp.118 (tmp.21 rbp tmp-ra.102 tmp.20))
         (tmp.21
          (rbp tmp-ra.102 tmp.20 tmp.118 tmp.66 tmp.65 tmp.119 tmp.68 tmp.67))
         (tmp.66 (rbp tmp-ra.102 tmp.20 tmp.21))
         (tmp-ra.102
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.118
           tmp.66
           tmp.65
           tmp.119
           tmp.68
           tmp.67
           tmp.121
           tmp.69
           tmp.120
           rax))
         (tmp.120 (rbp tmp-ra.102 tmp.20))
         (tmp.69 (tmp.121 rbp tmp-ra.102 tmp.20))
         (tmp.121 (rbp tmp-ra.102 tmp.69))
         (tmp.68 (rbp tmp-ra.102 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.102
           rsi
           tmp.118
           tmp.66
           tmp.65
           tmp.119
           tmp.68
           tmp.67
           tmp.69
           tmp.120))
         (tmp.119 (tmp.20 rbp tmp-ra.102 tmp.21))
         (tmp.67 (rbp tmp-ra.102 tmp.20 tmp.21))
         (rax (rbp tmp-ra.102))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.102
           tmp.118
           tmp.66
           tmp.65
           tmp.119
           tmp.68
           tmp.67
           tmp.121
           tmp.69
           tmp.120
           rax))
         (rdi (tmp-ra.102))
         (rsi (tmp.20 tmp-ra.102))))
       (assignment ()))
      (begin
        (set! tmp-ra.102 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.118 tmp.21)
                      (set! tmp.118 (bitwise-and tmp.118 7))
                      (set! tmp.66 tmp.118))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.119 tmp.20)
                        (set! tmp.119 (bitwise-and tmp.119 7))
                        (set! tmp.68 tmp.119))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.120 tmp.21)
              (set! tmp.120 (arithmetic-shift-right tmp.120 3))
              (set! tmp.69 tmp.120)
              (set! tmp.121 tmp.20)
              (set! tmp.121 (* tmp.121 tmp.69))
              (set! rax tmp.121)
              (jump tmp-ra.102 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.102 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.102 rbp rax)))))
    (define L.fun/void46565.4
      ((locals (tmp-ra.103))
       (conflicts ((tmp-ra.103 (rbp)) (rbp (r15 tmp-ra.103)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.103 r15)
        (set! r15 tmp-ra.103)
        (jump L.fun/void46566.6 rbp r15)))
    (define L.fun/error46563.5
      ((locals (tmp-ra.104))
       (conflicts ((tmp-ra.104 (rbp)) (rbp (r15 tmp-ra.104)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.104 r15)
        (set! r15 tmp-ra.104)
        (jump L.fun/error46564.8 rbp r15)))
    (define L.fun/void46566.6
      ((locals (tmp-ra.105))
       (conflicts
        ((tmp-ra.105 (rax rbp)) (rbp (rax tmp-ra.105)) (rax (rbp tmp-ra.105))))
       (assignment ()))
      (begin (set! tmp-ra.105 r15) (set! rax 30) (jump tmp-ra.105 rbp rax)))
    (define L.fun/empty46562.7
      ((locals (tmp-ra.106))
       (conflicts
        ((tmp-ra.106 (rax rbp)) (rbp (rax tmp-ra.106)) (rax (rbp tmp-ra.106))))
       (assignment ()))
      (begin (set! tmp-ra.106 r15) (set! rax 22) (jump tmp-ra.106 rbp rax)))
    (define L.fun/error46564.8
      ((locals (tmp-ra.107))
       (conflicts
        ((tmp-ra.107 (rax rbp)) (rbp (rax tmp-ra.107)) (rax (rbp tmp-ra.107))))
       (assignment ()))
      (begin (set! tmp-ra.107 r15) (set! rax 49982) (jump tmp-ra.107 rbp rax)))
    (define L.fun/empty46561.9
      ((locals (tmp-ra.108))
       (conflicts ((tmp-ra.108 (rbp)) (rbp (r15 tmp-ra.108)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.108 r15)
        (set! r15 tmp-ra.108)
        (jump L.fun/empty46562.7 rbp r15)))
    (define L.fun/any46567.10
      ((locals (tmp-ra.109))
       (conflicts
        ((tmp-ra.109 (rax rbp)) (rbp (rax tmp-ra.109)) (rax (rbp tmp-ra.109))))
       (assignment ()))
      (begin (set! tmp-ra.109 r15) (set! rax 1696) (jump tmp-ra.109 rbp rax)))
    (begin
      (set! tmp-ra.110 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/empty46561.9 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! empty0.6 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/error46563.5 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rsi 1432)
            (set! rdi 152)
            (set! r15 L.rp.18)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin
            (set! rsi 288)
            (set! rdi 640)
            (set! r15 L.rp.19)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.72)
            (set! r15 L.rp.20)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi 424)
            (set! rdi 608)
            (set! r15 L.rp.21)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi 1016)
            (set! rdi 1656)
            (set! r15 L.rp.22)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.75)
            (set! r15 L.rp.23)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi tmp.74)
            (set! rdi tmp.71)
            (set! r15 L.rp.24)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi 600)
            (set! rdi 1392)
            (set! r15 L.rp.25)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi 856)
            (set! rdi 280)
            (set! r15 L.rp.26)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.79)
            (set! r15 L.rp.27)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi 344)
            (set! rdi 760)
            (set! r15 L.rp.28)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi 1496)
            (set! rdi 704)
            (set! r15 L.rp.29)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.83)
            (set! rdi tmp.82)
            (set! r15 L.rp.30)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.81)
            (set! rdi tmp.78)
            (set! r15 L.rp.31)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.70)
            (set! r15 L.rp.32)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! fixnum2.4 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/void46565.4 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi 544)
            (set! rdi 1784)
            (set! r15 L.rp.34)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin
            (set! rsi 352)
            (set! rdi 1800)
            (set! r15 L.rp.35)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.87)
            (set! rdi tmp.86)
            (set! r15 L.rp.36)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi 392)
            (set! rdi 592)
            (set! r15 L.rp.37)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi 520)
            (set! rdi 1544)
            (set! r15 L.rp.38)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.90)
            (set! rdi tmp.89)
            (set! r15 L.rp.39)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi tmp.88)
            (set! rdi tmp.85)
            (set! r15 L.rp.40)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi 896)
            (set! rdi 1288)
            (set! r15 L.rp.41)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi 384)
            (set! rdi 912)
            (set! r15 L.rp.42)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi tmp.94)
            (set! rdi tmp.93)
            (set! r15 L.rp.43)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi 400)
            (set! rdi 680)
            (set! r15 L.rp.44)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi 480)
            (set! rdi 664)
            (set! r15 L.rp.45)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.97 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin
            (set! rsi tmp.97)
            (set! rdi tmp.96)
            (set! r15 L.rp.46)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin
            (set! rsi tmp.95)
            (set! rdi tmp.92)
            (set! r15 L.rp.47)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin
            (set! rsi tmp.91)
            (set! rdi tmp.84)
            (set! r15 L.rp.48)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/any46567.10 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! tmp.98 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.50
          (begin
            (set! rdi tmp.98)
            (set! r15 L.rp.50)
            (jump L.pair?.15 rbp r15 rdi)))
        (set! rbp (+ rbp 128)))
      (set! boolean5.1 rax)
      (set! rax void3.3)
      (jump tmp-ra.110 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (ascii-char5.1
       fixnum4.2
       tmp.90
       tmp.94
       tmp.96
       tmp.93
       tmp.87
       tmp.89
       tmp.86
       void3.3
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72
       error1.5
       void0.6))
     (conflicts
      ((tmp-ra.108
        (ascii-char5.1
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
         void3.3
         fixnum2.4
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
         error1.5
         void0.6
         rax
         rbp))
       (void0.6 (rbp tmp-ra.108))
       (error1.5 (rbp tmp-ra.108))
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
       (fixnum2.4
        (ascii-char5.1
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
         void3.3
         rax
         rbp
         tmp-ra.108))
       (void3.3 (rbp tmp-ra.108 fixnum2.4))
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.108 fixnum2.4))
       (tmp.86 (rbp tmp-ra.108 fixnum2.4 tmp.85))
       (tmp.84 (rsi tmp.87 tmp.89 tmp.88 rax rbp tmp-ra.108 fixnum2.4))
       (tmp.88 (rsi tmp.89 rax rbp tmp-ra.108 fixnum2.4 tmp.84))
       (tmp.89 (rbp tmp-ra.108 fixnum2.4 tmp.84 tmp.88))
       (tmp.87 (rbp tmp-ra.108 fixnum2.4 tmp.84))
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
         fixnum2.4))
       (tmp.92 (rsi tmp.93 rax rbp tmp-ra.108 fixnum2.4 tmp.83))
       (tmp.93 (rbp tmp-ra.108 fixnum2.4 tmp.83 tmp.92))
       (tmp.91 (rsi tmp.94 tmp.96 tmp.95 rax rbp tmp-ra.108 fixnum2.4 tmp.83))
       (tmp.95 (rsi tmp.96 rax rbp tmp-ra.108 fixnum2.4 tmp.83 tmp.91))
       (tmp.96 (rbp tmp-ra.108 fixnum2.4 tmp.83 tmp.91 tmp.95))
       (tmp.94 (rbp tmp-ra.108 fixnum2.4 tmp.83 tmp.91))
       (tmp.90 (rbp tmp-ra.108 fixnum2.4 tmp.83))
       (fixnum4.2 (rbp tmp-ra.108 fixnum2.4))
       (ascii-char5.1 (rbp tmp-ra.108 fixnum2.4))
       (rbp
        (ascii-char5.1
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
         void3.3
         fixnum2.4
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
         error1.5
         void0.6
         r15
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
         fixnum2.4
         tmp.81
         tmp.77
         tmp.78
         tmp.69
         tmp.74
         tmp.70
         tmp.71
         rbp
         tmp-ra.108))
       (r15 (rdi rsi rbp))
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
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.108 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.88 fv1)
       (tmp.92 fv1)
       (tmp.91 fv1)
       (tmp.95 fv2)
       (tmp.83 fv3)
       (tmp.84 fv2)
       (tmp.85 fv1)
       (fixnum2.4 fv4)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.+.15
      ((locals
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
         (rsi (tmp.22 tmp-ra.97))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.24 tmp-ra.98))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.20 tmp-ra.99))))
       (assignment ()))
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
    (define L.fun/error50281.4
      ((locals (tmp-ra.100))
       (conflicts
        ((tmp-ra.100 (rax rbp)) (rbp (rax tmp-ra.100)) (rax (rbp tmp-ra.100))))
       (assignment ()))
      (begin (set! tmp-ra.100 r15) (set! rax 16446) (jump tmp-ra.100 rbp rax)))
    (define L.fun/error50280.5
      ((locals (tmp-ra.101))
       (conflicts ((tmp-ra.101 (rbp)) (rbp (r15 tmp-ra.101)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.101 r15)
        (set! r15 tmp-ra.101)
        (jump L.fun/error50281.4 rbp r15)))
    (define L.fun/void50283.6
      ((locals (tmp-ra.102))
       (conflicts
        ((tmp-ra.102 (rax rbp)) (rbp (rax tmp-ra.102)) (rax (rbp tmp-ra.102))))
       (assignment ()))
      (begin (set! tmp-ra.102 r15) (set! rax 30) (jump tmp-ra.102 rbp rax)))
    (define L.fun/ascii-char50284.7
      ((locals (tmp-ra.103))
       (conflicts ((tmp-ra.103 (rbp)) (rbp (r15 tmp-ra.103)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.103 r15)
        (set! r15 tmp-ra.103)
        (jump L.fun/ascii-char50285.9 rbp r15)))
    (define L.fun/void50278.8
      ((locals (tmp-ra.104))
       (conflicts ((tmp-ra.104 (rbp)) (rbp (r15 tmp-ra.104)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.104 r15)
        (set! r15 tmp-ra.104)
        (jump L.fun/void50279.10 rbp r15)))
    (define L.fun/ascii-char50285.9
      ((locals (tmp-ra.105))
       (conflicts
        ((tmp-ra.105 (rax rbp)) (rbp (rax tmp-ra.105)) (rax (rbp tmp-ra.105))))
       (assignment ()))
      (begin (set! tmp-ra.105 r15) (set! rax 25390) (jump tmp-ra.105 rbp rax)))
    (define L.fun/void50279.10
      ((locals (tmp-ra.106))
       (conflicts
        ((tmp-ra.106 (rax rbp)) (rbp (rax tmp-ra.106)) (rax (rbp tmp-ra.106))))
       (assignment ()))
      (begin (set! tmp-ra.106 r15) (set! rax 30) (jump tmp-ra.106 rbp rax)))
    (define L.fun/void50282.11
      ((locals (tmp-ra.107))
       (conflicts ((tmp-ra.107 (rbp)) (rbp (r15 tmp-ra.107)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.107 r15)
        (set! r15 tmp-ra.107)
        (jump L.fun/void50283.6 rbp r15)))
    (begin
      (set! tmp-ra.108 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void50278.8 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! void0.6 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/error50280.5 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rsi 1120)
            (set! rdi 616)
            (set! r15 L.rp.18)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin
            (set! rsi 192)
            (set! rdi 1456)
            (set! r15 L.rp.19)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.20)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi 424)
            (set! rdi 1400)
            (set! r15 L.rp.21)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi 1392)
            (set! rdi 1416)
            (set! r15 L.rp.22)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.23)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.24)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi 1424)
            (set! rdi 1960)
            (set! r15 L.rp.25)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi 128)
            (set! rdi 336)
            (set! r15 L.rp.26)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.27)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi 1640)
            (set! rdi 1152)
            (set! r15 L.rp.28)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi 312)
            (set! rdi 1088)
            (set! r15 L.rp.29)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.30)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.31)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.32)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! fixnum2.4 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/void50282.11 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi 608)
            (set! rdi 1672)
            (set! r15 L.rp.34)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin
            (set! rsi 400)
            (set! rdi 1736)
            (set! r15 L.rp.35)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.86)
            (set! rdi tmp.85)
            (set! r15 L.rp.36)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi 1520)
            (set! rdi 1496)
            (set! r15 L.rp.37)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi 1136)
            (set! rdi 304)
            (set! r15 L.rp.38)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.89)
            (set! rdi tmp.88)
            (set! r15 L.rp.39)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi tmp.87)
            (set! rdi tmp.84)
            (set! r15 L.rp.40)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi 192)
            (set! rdi 1640)
            (set! r15 L.rp.41)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi 1224)
            (set! rdi 1816)
            (set! r15 L.rp.42)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi tmp.93)
            (set! rdi tmp.92)
            (set! r15 L.rp.43)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi 1312)
            (set! rdi 520)
            (set! r15 L.rp.44)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi 1176)
            (set! rdi 120)
            (set! r15 L.rp.45)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin
            (set! rsi tmp.96)
            (set! rdi tmp.95)
            (set! r15 L.rp.46)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin
            (set! rsi tmp.94)
            (set! rdi tmp.91)
            (set! r15 L.rp.47)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin
            (set! rsi tmp.90)
            (set! rdi tmp.83)
            (set! r15 L.rp.48)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/ascii-char50284.7 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! ascii-char5.1 rax)
      (set! rax fixnum2.4)
      (jump tmp-ra.108 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (error5.1
       ascii-char4.2
       fixnum3.3
       tmp.90
       tmp.94
       tmp.96
       tmp.93
       tmp.87
       tmp.89
       tmp.86
       error1.5
       fixnum0.6
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72))
     (conflicts
      ((tmp-ra.108
        (error5.1
         ascii-char4.2
         fixnum3.3
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
         void2.4
         error1.5
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
       (error1.5 (rbp tmp-ra.108))
       (void2.4
        (error5.1
         ascii-char4.2
         fixnum3.3
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
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.108 void2.4))
       (tmp.86 (rbp tmp-ra.108 void2.4 tmp.85))
       (tmp.84 (rsi tmp.87 tmp.89 tmp.88 rax rbp tmp-ra.108 void2.4))
       (tmp.88 (rsi tmp.89 rax rbp tmp-ra.108 void2.4 tmp.84))
       (tmp.89 (rbp tmp-ra.108 void2.4 tmp.84 tmp.88))
       (tmp.87 (rbp tmp-ra.108 void2.4 tmp.84))
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
         void2.4))
       (tmp.92 (rsi tmp.93 rax rbp tmp-ra.108 void2.4 tmp.83))
       (tmp.93 (rbp tmp-ra.108 void2.4 tmp.83 tmp.92))
       (tmp.91 (rsi tmp.94 tmp.96 tmp.95 rax rbp tmp-ra.108 void2.4 tmp.83))
       (tmp.95 (rsi tmp.96 rax rbp tmp-ra.108 void2.4 tmp.83 tmp.91))
       (tmp.96 (rbp tmp-ra.108 void2.4 tmp.83 tmp.91 tmp.95))
       (tmp.94 (rbp tmp-ra.108 void2.4 tmp.83 tmp.91))
       (tmp.90 (rbp tmp-ra.108 void2.4 tmp.83))
       (fixnum3.3 (rbp tmp-ra.108 void2.4))
       (ascii-char4.2 (rbp tmp-ra.108 void2.4))
       (error5.1 (rbp tmp-ra.108 void2.4))
       (rbp
        (error5.1
         ascii-char4.2
         fixnum3.3
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
         void2.4
         error1.5
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
         void2.4
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
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.108 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.85 fv1)
       (tmp.84 fv1)
       (tmp.83 fv1)
       (tmp.95 fv2)
       (tmp.91 fv3)
       (tmp.92 fv2)
       (tmp.88 fv2)
       (void2.4 fv4)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.+.15
      ((locals
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
         (rsi (tmp.22 tmp-ra.97))))
       (assignment ()))
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
    (define L.*.14
      ((locals
        (tmp.62
         tmp.113
         tmp.20
         tmp.63
         tmp.115
         tmp.64
         tmp.114
         tmp-ra.98
         tmp.61
         tmp.21
         tmp.112
         tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.98 tmp.20 tmp.21))
         (tmp.112 (tmp.21 rbp tmp-ra.98 tmp.20))
         (tmp.21
          (rbp tmp-ra.98 tmp.20 tmp.112 tmp.61 tmp.60 tmp.113 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.98 tmp.20 tmp.21))
         (tmp-ra.98
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.115
           tmp.64
           tmp.114
           rax))
         (tmp.114 (rbp tmp-ra.98 tmp.20))
         (tmp.64 (tmp.115 rbp tmp-ra.98 tmp.20))
         (tmp.115 (rbp tmp-ra.98 tmp.64))
         (tmp.63 (rbp tmp-ra.98 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.98
           rsi
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.64
           tmp.114))
         (tmp.113 (tmp.20 rbp tmp-ra.98 tmp.21))
         (tmp.62 (rbp tmp-ra.98 tmp.20 tmp.21))
         (rax (rbp tmp-ra.98))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.98
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.115
           tmp.64
           tmp.114
           rax))
         (rdi (tmp-ra.98))
         (rsi (tmp.20 tmp-ra.98))))
       (assignment ()))
      (begin
        (set! tmp-ra.98 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.112 tmp.21)
                      (set! tmp.112 (bitwise-and tmp.112 7))
                      (set! tmp.61 tmp.112))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.113 tmp.20)
                        (set! tmp.113 (bitwise-and tmp.113 7))
                        (set! tmp.63 tmp.113))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.114 tmp.21)
              (set! tmp.114 (arithmetic-shift-right tmp.114 3))
              (set! tmp.64 tmp.114)
              (set! tmp.115 tmp.20)
              (set! tmp.115 (* tmp.115 tmp.64))
              (set! rax tmp.115)
              (jump tmp-ra.98 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.98 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.98 rbp rax)))))
    (define L.-.13
      ((locals
        (tmp.67
         tmp.117
         tmp.24
         tmp.68
         tmp.118
         tmp-ra.99
         tmp.66
         tmp.25
         tmp.116
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.99 tmp.25 tmp.24))
         (tmp.116 (tmp.25 rbp tmp-ra.99 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.99
           tmp.24
           tmp.116
           tmp.66
           tmp.65
           tmp.117
           tmp.68
           tmp.67
           tmp.118))
         (tmp.66 (rbp tmp-ra.99 tmp.25 tmp.24))
         (tmp-ra.99
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.116
           tmp.66
           tmp.65
           tmp.117
           tmp.68
           tmp.67
           tmp.118
           rax))
         (tmp.118 (rbp tmp-ra.99 tmp.25))
         (tmp.68 (rbp tmp-ra.99 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.99
           rsi
           tmp.116
           tmp.66
           tmp.65
           tmp.117
           tmp.68
           tmp.67))
         (tmp.117 (tmp.24 rbp tmp-ra.99 tmp.25))
         (tmp.67 (rbp tmp-ra.99 tmp.25 tmp.24))
         (rax (rbp tmp-ra.99))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.99
           tmp.116
           tmp.66
           tmp.65
           tmp.117
           tmp.68
           tmp.67
           tmp.118
           rax))
         (rdi (tmp-ra.99))
         (rsi (tmp.24 tmp-ra.99))))
       (assignment ()))
      (begin
        (set! tmp-ra.99 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.116 tmp.25)
                      (set! tmp.116 (bitwise-and tmp.116 7))
                      (set! tmp.66 tmp.116))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.117 tmp.24)
                        (set! tmp.117 (bitwise-and tmp.117 7))
                        (set! tmp.68 tmp.117))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.118 tmp.24)
              (set! tmp.118 (- tmp.118 tmp.25))
              (set! rax tmp.118)
              (jump tmp-ra.99 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.99 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.99 rbp rax)))))
    (define L.fun/ascii-char51656.4
      ((locals (tmp-ra.100))
       (conflicts ((tmp-ra.100 (rbp)) (rbp (r15 tmp-ra.100)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.100 r15)
        (set! r15 tmp-ra.100)
        (jump L.fun/ascii-char51657.5 rbp r15)))
    (define L.fun/ascii-char51657.5
      ((locals (tmp-ra.101))
       (conflicts
        ((tmp-ra.101 (rax rbp)) (rbp (rax tmp-ra.101)) (rax (rbp tmp-ra.101))))
       (assignment ()))
      (begin (set! tmp-ra.101 r15) (set! rax 25390) (jump tmp-ra.101 rbp rax)))
    (define L.fun/error51658.6
      ((locals (tmp-ra.102))
       (conflicts ((tmp-ra.102 (rbp)) (rbp (r15 tmp-ra.102)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.102 r15)
        (set! r15 tmp-ra.102)
        (jump L.fun/error51659.11 rbp r15)))
    (define L.fun/void51654.7
      ((locals (tmp-ra.103))
       (conflicts ((tmp-ra.103 (rbp)) (rbp (r15 tmp-ra.103)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.103 r15)
        (set! r15 tmp-ra.103)
        (jump L.fun/void51655.9 rbp r15)))
    (define L.fun/error51653.8
      ((locals (tmp-ra.104))
       (conflicts
        ((tmp-ra.104 (rax rbp)) (rbp (rax tmp-ra.104)) (rax (rbp tmp-ra.104))))
       (assignment ()))
      (begin (set! tmp-ra.104 r15) (set! rax 20030) (jump tmp-ra.104 rbp rax)))
    (define L.fun/void51655.9
      ((locals (tmp-ra.105))
       (conflicts
        ((tmp-ra.105 (rax rbp)) (rbp (rax tmp-ra.105)) (rax (rbp tmp-ra.105))))
       (assignment ()))
      (begin (set! tmp-ra.105 r15) (set! rax 30) (jump tmp-ra.105 rbp rax)))
    (define L.fun/error51652.10
      ((locals (tmp-ra.106))
       (conflicts ((tmp-ra.106 (rbp)) (rbp (r15 tmp-ra.106)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.106 r15)
        (set! r15 tmp-ra.106)
        (jump L.fun/error51653.8 rbp r15)))
    (define L.fun/error51659.11
      ((locals (tmp-ra.107))
       (conflicts
        ((tmp-ra.107 (rax rbp)) (rbp (rax tmp-ra.107)) (rax (rbp tmp-ra.107))))
       (assignment ()))
      (begin (set! tmp-ra.107 r15) (set! rax 45374) (jump tmp-ra.107 rbp rax)))
    (begin
      (set! tmp-ra.108 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin
            (set! rsi 32)
            (set! rdi 696)
            (set! r15 L.rp.16)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin
            (set! rsi 1768)
            (set! rdi 1576)
            (set! r15 L.rp.17)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.18)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin
            (set! rsi 408)
            (set! rdi 1632)
            (set! r15 L.rp.19)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi 976)
            (set! rdi 632)
            (set! r15 L.rp.20)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.21)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.22)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi 608)
            (set! rdi 168)
            (set! r15 L.rp.23)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi 400)
            (set! rdi 1912)
            (set! r15 L.rp.24)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.25)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi 1256)
            (set! rdi 992)
            (set! r15 L.rp.26)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi 424)
            (set! rdi 1144)
            (set! r15 L.rp.27)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.28)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.29)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.30)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! fixnum0.6 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin (set! r15 L.rp.31) (jump L.fun/error51652.10 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/void51654.7 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! void2.4 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin
            (set! rsi 1560)
            (set! rdi 1472)
            (set! r15 L.rp.33)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi 1624)
            (set! rdi 592)
            (set! r15 L.rp.34)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin
            (set! rsi tmp.86)
            (set! rdi tmp.85)
            (set! r15 L.rp.35)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi 1352)
            (set! rdi 536)
            (set! r15 L.rp.36)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi 848)
            (set! rdi 888)
            (set! r15 L.rp.37)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.89)
            (set! rdi tmp.88)
            (set! r15 L.rp.38)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.87)
            (set! rdi tmp.84)
            (set! r15 L.rp.39)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi 56)
            (set! rdi 1120)
            (set! r15 L.rp.40)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi 1016)
            (set! rdi 824)
            (set! r15 L.rp.41)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi tmp.93)
            (set! rdi tmp.92)
            (set! r15 L.rp.42)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi 1056)
            (set! rdi 16)
            (set! r15 L.rp.43)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi 144)
            (set! rdi 904)
            (set! r15 L.rp.44)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi tmp.96)
            (set! rdi tmp.95)
            (set! r15 L.rp.45)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin
            (set! rsi tmp.94)
            (set! rdi tmp.91)
            (set! r15 L.rp.46)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin
            (set! rsi tmp.90)
            (set! rdi tmp.83)
            (set! r15 L.rp.47)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! fixnum3.3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/ascii-char51656.4 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! ascii-char4.2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/error51658.6 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! error5.1 rax)
      (set! rax void2.4)
      (jump tmp-ra.108 rbp rax))))
(check-by-interp
 '(module
    ((locals (empty5.1 error3.3 error2.4 boolean1.5 tmp.57 error0.6))
     (conflicts
      ((tmp-ra.70
        (empty5.1
         void4.2
         error3.3
         error2.4
         boolean1.5
         tmp.57
         error0.6
         rax
         rbp))
       (error0.6 (rbp tmp-ra.70))
       (tmp.57 (rbp tmp-ra.70))
       (boolean1.5 (rbp tmp-ra.70))
       (error2.4 (rbp tmp-ra.70))
       (error3.3 (rbp tmp-ra.70))
       (void4.2 (empty5.1 rax rbp tmp-ra.70))
       (empty5.1 (rbp tmp-ra.70 void4.2))
       (rbp
        (empty5.1
         void4.2
         error3.3
         error2.4
         boolean1.5
         rdi
         tmp.57
         error0.6
         r15
         rax
         tmp-ra.70))
       (rax (void4.2 rbp tmp-ra.70))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment ((tmp-ra.70 fv0) (void4.2 fv1))))
    (define L.vector?.16
      ((locals (tmp-ra.58 tmp.71 tmp.50 tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.58))
         (tmp.50 (rbp tmp-ra.58))
         (tmp.71 (rbp tmp-ra.58))
         (tmp-ra.58 (tmp.50 rbp rdi tmp.71 tmp.56 rax))
         (rax (rbp tmp-ra.58))
         (rbp (tmp.50 tmp-ra.58 tmp.71 tmp.56 rax))
         (rdi (tmp-ra.58))))
       (assignment ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.50 rdi)
        (if (begin
              (begin
                (set! tmp.71 tmp.50)
                (set! tmp.71 (bitwise-and tmp.71 7))
                (set! tmp.56 tmp.71))
              (= tmp.56 3))
          (begin (set! rax 14) (jump tmp-ra.58 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.58 rbp rax)))))
    (define L.fun/error54326.4
      ((locals (tmp-ra.59))
       (conflicts ((tmp-ra.59 (rbp)) (rbp (r15 tmp-ra.59)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! r15 tmp-ra.59)
        (jump L.fun/error54327.8 rbp r15)))
    (define L.fun/error54322.5
      ((locals (tmp-ra.60))
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60))))
       (assignment ()))
      (begin (set! tmp-ra.60 r15) (set! rax 18238) (jump tmp-ra.60 rbp rax)))
    (define L.fun/empty54331.6
      ((locals (tmp-ra.61))
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ()))
      (begin (set! tmp-ra.61 r15) (set! rax 22) (jump tmp-ra.61 rbp rax)))
    (define L.fun/void54329.7
      ((locals (tmp-ra.62))
       (conflicts
        ((tmp-ra.62 (rax rbp)) (rbp (rax tmp-ra.62)) (rax (rbp tmp-ra.62))))
       (assignment ()))
      (begin (set! tmp-ra.62 r15) (set! rax 30) (jump tmp-ra.62 rbp rax)))
    (define L.fun/error54327.8
      ((locals (tmp-ra.63))
       (conflicts
        ((tmp-ra.63 (rax rbp)) (rbp (rax tmp-ra.63)) (rax (rbp tmp-ra.63))))
       (assignment ()))
      (begin (set! tmp-ra.63 r15) (set! rax 17214) (jump tmp-ra.63 rbp rax)))
    (define L.fun/error54325.9
      ((locals (tmp-ra.64))
       (conflicts
        ((tmp-ra.64 (rax rbp)) (rbp (rax tmp-ra.64)) (rax (rbp tmp-ra.64))))
       (assignment ()))
      (begin (set! tmp-ra.64 r15) (set! rax 8766) (jump tmp-ra.64 rbp rax)))
    (define L.fun/error54321.10
      ((locals (tmp-ra.65))
       (conflicts ((tmp-ra.65 (rbp)) (rbp (r15 tmp-ra.65)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/error54322.5 rbp r15)))
    (define L.fun/any54323.11
      ((locals (tmp-ra.66))
       (conflicts
        ((tmp-ra.66 (rax rbp)) (rbp (rax tmp-ra.66)) (rax (rbp tmp-ra.66))))
       (assignment ()))
      (begin (set! tmp-ra.66 r15) (set! rax 25390) (jump tmp-ra.66 rbp rax)))
    (define L.fun/void54328.12
      ((locals (tmp-ra.67))
       (conflicts ((tmp-ra.67 (rbp)) (rbp (r15 tmp-ra.67)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.67 r15)
        (set! r15 tmp-ra.67)
        (jump L.fun/void54329.7 rbp r15)))
    (define L.fun/error54324.13
      ((locals (tmp-ra.68))
       (conflicts ((tmp-ra.68 (rbp)) (rbp (r15 tmp-ra.68)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.68 r15)
        (set! r15 tmp-ra.68)
        (jump L.fun/error54325.9 rbp r15)))
    (define L.fun/empty54330.14
      ((locals (tmp-ra.69))
       (conflicts ((tmp-ra.69 (rbp)) (rbp (r15 tmp-ra.69)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.69 r15)
        (set! r15 tmp-ra.69)
        (jump L.fun/empty54331.6 rbp r15)))
    (begin
      (set! tmp-ra.70 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/error54321.10 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error0.6 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/any54323.11 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! tmp.57 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin
            (set! rdi tmp.57)
            (set! r15 L.rp.19)
            (jump L.vector?.16 rbp r15 rdi)))
        (set! rbp (+ rbp 16)))
      (set! boolean1.5 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error54324.13 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error2.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error54326.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error3.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/void54328.12 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void4.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty54330.14 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty5.1 rax)
      (set! rax void4.2)
      (jump tmp-ra.70 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (fixnum5.1
       tmp.78
       tmp.82
       tmp.84
       tmp.81
       tmp.75
       tmp.77
       tmp.74
       empty4.2
       empty3.3
       error2.4
       boolean1.5
       tmp.70
       void0.6))
     (conflicts
      ((tmp-ra.100
        (fixnum5.1
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
         empty4.2
         empty3.3
         error2.4
         boolean1.5
         tmp.70
         void0.6
         rax
         rbp))
       (void0.6 (rbp tmp-ra.100))
       (tmp.70 (rbp tmp-ra.100))
       (boolean1.5 (rbp tmp-ra.100))
       (error2.4 (rbp tmp-ra.100))
       (empty3.3 (rbp tmp-ra.100))
       (empty4.2 (rbp tmp-ra.100))
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
       (fixnum5.1 (rbp tmp-ra.100))
       (rbp
        (fixnum5.1
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
         empty4.2
         empty3.3
         error2.4
         boolean1.5
         rdi
         tmp.70
         void0.6
         r15
         rax
         tmp-ra.100))
       (rax (tmp.83 tmp.79 tmp.80 tmp.71 tmp.76 tmp.72 tmp.73 rbp tmp-ra.100))
       (r15 (rsi rdi rbp))
       (rdi (rsi r15 rbp))
       (rsi (tmp.71 tmp.79 tmp.83 tmp.80 tmp.72 tmp.76 tmp.73 r15 rdi rbp))))
     (assignment
      ((tmp-ra.100 fv0)
       (tmp.76 fv1)
       (tmp.80 fv1)
       (tmp.79 fv1)
       (tmp.83 fv2)
       (tmp.71 fv3)
       (tmp.72 fv2)
       (tmp.73 fv1))))
    (define L.*.19
      ((locals
        (tmp.58
         tmp.102
         tmp.20
         tmp.59
         tmp.104
         tmp.60
         tmp.103
         tmp-ra.85
         tmp.57
         tmp.21
         tmp.101
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp.101 (tmp.21 rbp tmp-ra.85 tmp.20))
         (tmp.21
          (rbp tmp-ra.85 tmp.20 tmp.101 tmp.57 tmp.56 tmp.102 tmp.59 tmp.58))
         (tmp.57 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp-ra.85
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.101
           tmp.57
           tmp.56
           tmp.102
           tmp.59
           tmp.58
           tmp.104
           tmp.60
           tmp.103
           rax))
         (tmp.103 (rbp tmp-ra.85 tmp.20))
         (tmp.60 (tmp.104 rbp tmp-ra.85 tmp.20))
         (tmp.104 (rbp tmp-ra.85 tmp.60))
         (tmp.59 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.85
           rsi
           tmp.101
           tmp.57
           tmp.56
           tmp.102
           tmp.59
           tmp.58
           tmp.60
           tmp.103))
         (tmp.102 (tmp.20 rbp tmp-ra.85 tmp.21))
         (tmp.58 (rbp tmp-ra.85 tmp.20 tmp.21))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.85
           tmp.101
           tmp.57
           tmp.56
           tmp.102
           tmp.59
           tmp.58
           tmp.104
           tmp.60
           tmp.103
           rax))
         (rdi (tmp-ra.85))
         (rsi (tmp.20 tmp-ra.85))))
       (assignment ()))
      (begin
        (set! tmp-ra.85 r15)
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
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.85 rbp rax)))))
    (define L.+.18
      ((locals
        (tmp.63
         tmp.106
         tmp.22
         tmp.64
         tmp.107
         tmp-ra.86
         tmp.62
         tmp.23
         tmp.105
         tmp.61))
       (conflicts
        ((tmp.61 (rbp tmp-ra.86 tmp.23 tmp.22))
         (tmp.105 (tmp.23 rbp tmp-ra.86 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.86
           tmp.22
           tmp.105
           tmp.62
           tmp.61
           tmp.106
           tmp.64
           tmp.63
           tmp.107))
         (tmp.62 (rbp tmp-ra.86 tmp.23 tmp.22))
         (tmp-ra.86
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.105
           tmp.62
           tmp.61
           tmp.106
           tmp.64
           tmp.63
           tmp.107
           rax))
         (tmp.107 (rbp tmp-ra.86 tmp.23))
         (tmp.64 (rbp tmp-ra.86 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.86
           rsi
           tmp.105
           tmp.62
           tmp.61
           tmp.106
           tmp.64
           tmp.63))
         (tmp.106 (tmp.22 rbp tmp-ra.86 tmp.23))
         (tmp.63 (rbp tmp-ra.86 tmp.23 tmp.22))
         (rax (rbp tmp-ra.86))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.86
           tmp.105
           tmp.62
           tmp.61
           tmp.106
           tmp.64
           tmp.63
           tmp.107
           rax))
         (rdi (tmp-ra.86))
         (rsi (tmp.22 tmp-ra.86))))
       (assignment ()))
      (begin
        (set! tmp-ra.86 r15)
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
              (jump tmp-ra.86 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.86 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.86 rbp rax)))))
    (define L.-.17
      ((locals
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
         (rsi (tmp.24 tmp-ra.87))))
       (assignment ()))
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
      ((locals (tmp-ra.88 tmp.111 tmp.44 tmp.69))
       (conflicts
        ((tmp.69 (rbp tmp-ra.88))
         (tmp.44 (rbp tmp-ra.88))
         (tmp.111 (rbp tmp-ra.88))
         (tmp-ra.88 (tmp.44 rbp rdi tmp.111 tmp.69 rax))
         (rax (rbp tmp-ra.88))
         (rbp (tmp.44 tmp-ra.88 tmp.111 tmp.69 rax))
         (rdi (tmp-ra.88))))
       (assignment ()))
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
    (define L.fun/ascii-char64319.4
      ((locals (tmp-ra.89))
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89))))
       (assignment ()))
      (begin (set! tmp-ra.89 r15) (set! rax 25390) (jump tmp-ra.89 rbp rax)))
    (define L.fun/error64313.5
      ((locals (tmp-ra.90))
       (conflicts
        ((tmp-ra.90 (rax rbp)) (rbp (rax tmp-ra.90)) (rax (rbp tmp-ra.90))))
       (assignment ()))
      (begin (set! tmp-ra.90 r15) (set! rax 26430) (jump tmp-ra.90 rbp rax)))
    (define L.fun/empty64317.6
      ((locals (tmp-ra.91))
       (conflicts
        ((tmp-ra.91 (rax rbp)) (rbp (rax tmp-ra.91)) (rax (rbp tmp-ra.91))))
       (assignment ()))
      (begin (set! tmp-ra.91 r15) (set! rax 22) (jump tmp-ra.91 rbp rax)))
    (define L.fun/ascii-char64318.7
      ((locals (tmp-ra.92))
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/ascii-char64319.4 rbp r15)))
    (define L.fun/void64310.8
      ((locals (tmp-ra.93))
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93))))
       (assignment ()))
      (begin (set! tmp-ra.93 r15) (set! rax 30) (jump tmp-ra.93 rbp rax)))
    (define L.fun/empty64315.9
      ((locals (tmp-ra.94))
       (conflicts
        ((tmp-ra.94 (rax rbp)) (rbp (rax tmp-ra.94)) (rax (rbp tmp-ra.94))))
       (assignment ()))
      (begin (set! tmp-ra.94 r15) (set! rax 22) (jump tmp-ra.94 rbp rax)))
    (define L.fun/any64311.10
      ((locals (tmp-ra.95))
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95))))
       (assignment ()))
      (begin (set! tmp-ra.95 r15) (set! rax 40766) (jump tmp-ra.95 rbp rax)))
    (define L.fun/error64312.11
      ((locals (tmp-ra.96))
       (conflicts ((tmp-ra.96 (rbp)) (rbp (r15 tmp-ra.96)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.96 r15)
        (set! r15 tmp-ra.96)
        (jump L.fun/error64313.5 rbp r15)))
    (define L.fun/empty64316.12
      ((locals (tmp-ra.97))
       (conflicts ((tmp-ra.97 (rbp)) (rbp (r15 tmp-ra.97)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/empty64317.6 rbp r15)))
    (define L.fun/empty64314.13
      ((locals (tmp-ra.98))
       (conflicts ((tmp-ra.98 (rbp)) (rbp (r15 tmp-ra.98)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/empty64315.9 rbp r15)))
    (define L.fun/void64309.14
      ((locals (tmp-ra.99))
       (conflicts ((tmp-ra.99 (rbp)) (rbp (r15 tmp-ra.99)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.99 r15)
        (set! r15 tmp-ra.99)
        (jump L.fun/void64310.8 rbp r15)))
    (begin
      (set! tmp-ra.100 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void64309.14 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void0.6 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/any64311.10 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rdi tmp.70)
            (set! r15 L.rp.22)
            (jump L.boolean?.16 rbp r15 rdi)))
        (set! rbp (+ rbp 64)))
      (set! boolean1.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error64312.11 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! error2.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/empty64314.13 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty3.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/empty64316.12 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty4.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 1520)
            (set! rdi 1160)
            (set! r15 L.rp.26)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 512)
            (set! rdi 1104)
            (set! r15 L.rp.27)
            (jump L.+.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi tmp.74)
            (set! rdi tmp.73)
            (set! r15 L.rp.28)
            (jump L.+.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 1808)
            (set! rdi 1440)
            (set! r15 L.rp.29)
            (jump L.*.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi 1592)
            (set! rdi 696)
            (set! r15 L.rp.30)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.76)
            (set! r15 L.rp.31)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.72)
            (set! r15 L.rp.32)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 976)
            (set! rdi 184)
            (set! r15 L.rp.33)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi 880)
            (set! rdi 8)
            (set! r15 L.rp.34)
            (jump L.*.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi tmp.81)
            (set! rdi tmp.80)
            (set! r15 L.rp.35)
            (jump L.*.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi 1104)
            (set! rdi 1112)
            (set! r15 L.rp.36)
            (jump L.*.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi 1528)
            (set! rdi 992)
            (set! r15 L.rp.37)
            (jump L.+.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.84)
            (set! rdi tmp.83)
            (set! r15 L.rp.38)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.79)
            (set! r15 L.rp.39)
            (jump L.*.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin
            (set! rsi tmp.78)
            (set! rdi tmp.71)
            (set! r15 L.rp.40)
            (jump L.+.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum5.1 rax)
      (set! r15 tmp-ra.100)
      (jump L.fun/ascii-char64318.7 rbp r15))))
(check-by-interp
 '(module
    ((locals
      (ascii-char5.1
       ascii-char4.2
       empty3.3
       empty2.4
       void1.5
       fixnum0.6
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72))
     (conflicts
      ((tmp-ra.96
        (ascii-char5.1
         ascii-char4.2
         empty3.3
         empty2.4
         void1.5
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
       (void1.5 (rbp tmp-ra.96))
       (empty2.4 (rbp tmp-ra.96))
       (empty3.3 (rbp tmp-ra.96))
       (ascii-char4.2 (rbp tmp-ra.96))
       (ascii-char5.1 (rbp tmp-ra.96))
       (rbp
        (ascii-char5.1
         ascii-char4.2
         empty3.3
         empty2.4
         void1.5
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
       (rax (tmp.81 tmp.77 tmp.78 tmp.69 tmp.74 tmp.70 tmp.71 rbp tmp-ra.96))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.96 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.*.17
      ((locals
        (tmp.58
         tmp.98
         tmp.20
         tmp.59
         tmp.100
         tmp.60
         tmp.99
         tmp-ra.83
         tmp.57
         tmp.21
         tmp.97
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.83 tmp.20 tmp.21))
         (tmp.97 (tmp.21 rbp tmp-ra.83 tmp.20))
         (tmp.21
          (rbp tmp-ra.83 tmp.20 tmp.97 tmp.57 tmp.56 tmp.98 tmp.59 tmp.58))
         (tmp.57 (rbp tmp-ra.83 tmp.20 tmp.21))
         (tmp-ra.83
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.100
           tmp.60
           tmp.99
           rax))
         (tmp.99 (rbp tmp-ra.83 tmp.20))
         (tmp.60 (tmp.100 rbp tmp-ra.83 tmp.20))
         (tmp.100 (rbp tmp-ra.83 tmp.60))
         (tmp.59 (rbp tmp-ra.83 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.83
           rsi
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.60
           tmp.99))
         (tmp.98 (tmp.20 rbp tmp-ra.83 tmp.21))
         (tmp.58 (rbp tmp-ra.83 tmp.20 tmp.21))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.83
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.100
           tmp.60
           tmp.99
           rax))
         (rdi (tmp-ra.83))
         (rsi (tmp.20 tmp-ra.83))))
       (assignment ()))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.21)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.57 tmp.97))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.20)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.59 tmp.98))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.99 tmp.21)
              (set! tmp.99 (arithmetic-shift-right tmp.99 3))
              (set! tmp.60 tmp.99)
              (set! tmp.100 tmp.20)
              (set! tmp.100 (* tmp.100 tmp.60))
              (set! rax tmp.100)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.83 rbp rax)))))
    (define L.+.16
      ((locals
        (tmp.63
         tmp.102
         tmp.22
         tmp.64
         tmp.103
         tmp-ra.84
         tmp.62
         tmp.23
         tmp.101
         tmp.61))
       (conflicts
        ((tmp.61 (rbp tmp-ra.84 tmp.23 tmp.22))
         (tmp.101 (tmp.23 rbp tmp-ra.84 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.84
           tmp.22
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63
           tmp.103))
         (tmp.62 (rbp tmp-ra.84 tmp.23 tmp.22))
         (tmp-ra.84
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63
           tmp.103
           rax))
         (tmp.103 (rbp tmp-ra.84 tmp.23))
         (tmp.64 (rbp tmp-ra.84 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.84
           rsi
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63))
         (tmp.102 (tmp.22 rbp tmp-ra.84 tmp.23))
         (tmp.63 (rbp tmp-ra.84 tmp.23 tmp.22))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.84
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63
           tmp.103
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.22 tmp-ra.84))))
       (assignment ()))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.101 tmp.23)
                      (set! tmp.101 (bitwise-and tmp.101 7))
                      (set! tmp.62 tmp.101))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.102 tmp.22)
                        (set! tmp.102 (bitwise-and tmp.102 7))
                        (set! tmp.64 tmp.102))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.103 tmp.22)
              (set! tmp.103 (+ tmp.103 tmp.23))
              (set! rax tmp.103)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.84 rbp rax)))))
    (define L.-.15
      ((locals
        (tmp.67
         tmp.105
         tmp.24
         tmp.68
         tmp.106
         tmp-ra.85
         tmp.66
         tmp.25
         tmp.104
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.104 (tmp.25 rbp tmp-ra.85 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.85
           tmp.24
           tmp.104
           tmp.66
           tmp.65
           tmp.105
           tmp.68
           tmp.67
           tmp.106))
         (tmp.66 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp-ra.85
          (tmp.25
           tmp.24
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
         (tmp.106 (rbp tmp-ra.85 tmp.25))
         (tmp.68 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.85
           rsi
           tmp.104
           tmp.66
           tmp.65
           tmp.105
           tmp.68
           tmp.67))
         (tmp.105 (tmp.24 rbp tmp-ra.85 tmp.25))
         (tmp.67 (rbp tmp-ra.85 tmp.25 tmp.24))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.25
           tmp.24
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
         (rsi (tmp.24 tmp-ra.85))))
       (assignment ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.25)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.66 tmp.104))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.24)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.68 tmp.105))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.106 tmp.24)
              (set! tmp.106 (- tmp.106 tmp.25))
              (set! rax tmp.106)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/void75654.4
      ((locals (tmp-ra.86))
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86))))
       (assignment ()))
      (begin (set! tmp-ra.86 r15) (set! rax 30) (jump tmp-ra.86 rbp rax)))
    (define L.fun/empty75657.5
      ((locals (tmp-ra.87))
       (conflicts ((tmp-ra.87 (rbp)) (rbp (r15 tmp-ra.87)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/empty75658.10 rbp r15)))
    (define L.fun/ascii-char75662.6
      ((locals (tmp-ra.88))
       (conflicts
        ((tmp-ra.88 (rax rbp)) (rbp (rax tmp-ra.88)) (rax (rbp tmp-ra.88))))
       (assignment ()))
      (begin (set! tmp-ra.88 r15) (set! rax 25390) (jump tmp-ra.88 rbp rax)))
    (define L.fun/ascii-char75660.7
      ((locals (tmp-ra.89))
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89))))
       (assignment ()))
      (begin (set! tmp-ra.89 r15) (set! rax 25390) (jump tmp-ra.89 rbp rax)))
    (define L.fun/empty75656.8
      ((locals (tmp-ra.90))
       (conflicts
        ((tmp-ra.90 (rax rbp)) (rbp (rax tmp-ra.90)) (rax (rbp tmp-ra.90))))
       (assignment ()))
      (begin (set! tmp-ra.90 r15) (set! rax 22) (jump tmp-ra.90 rbp rax)))
    (define L.fun/ascii-char75661.9
      ((locals (tmp-ra.91))
       (conflicts ((tmp-ra.91 (rbp)) (rbp (r15 tmp-ra.91)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/ascii-char75662.6 rbp r15)))
    (define L.fun/empty75658.10
      ((locals (tmp-ra.92))
       (conflicts
        ((tmp-ra.92 (rax rbp)) (rbp (rax tmp-ra.92)) (rax (rbp tmp-ra.92))))
       (assignment ()))
      (begin (set! tmp-ra.92 r15) (set! rax 22) (jump tmp-ra.92 rbp rax)))
    (define L.fun/empty75655.11
      ((locals (tmp-ra.93))
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/empty75656.8 rbp r15)))
    (define L.fun/void75653.12
      ((locals (tmp-ra.94))
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/void75654.4 rbp r15)))
    (define L.fun/ascii-char75659.13
      ((locals (tmp-ra.95))
       (conflicts ((tmp-ra.95 (rbp)) (rbp (r15 tmp-ra.95)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/ascii-char75660.7 rbp r15)))
    (begin
      (set! tmp-ra.96 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi 8)
            (set! rdi 1632)
            (set! r15 L.rp.18)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin
            (set! rsi 448)
            (set! rdi 824)
            (set! r15 L.rp.19)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.20)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 8)
            (set! rdi 1680)
            (set! r15 L.rp.21)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1232)
            (set! rdi 1912)
            (set! r15 L.rp.22)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.23)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.24)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1320)
            (set! rdi 552)
            (set! r15 L.rp.25)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 1840)
            (set! rdi 1744)
            (set! r15 L.rp.26)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.27)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 1096)
            (set! rdi 1744)
            (set! r15 L.rp.28)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 408)
            (set! rdi 1680)
            (set! r15 L.rp.29)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.30)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.31)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.32)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum0.6 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/void75653.12 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void1.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/empty75655.11 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty2.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/empty75657.5 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty3.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/ascii-char75659.13 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char4.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char75661.9 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char5.1 rax)
      (set! rax ascii-char5.1)
      (jump tmp-ra.96 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (fixnum5.1
       tmp.78
       tmp.82
       tmp.84
       tmp.81
       tmp.75
       tmp.77
       tmp.74
       empty3.3
       boolean2.4
       tmp.70
       error1.5
       ascii-char0.6))
     (conflicts
      ((tmp-ra.98
        (fixnum5.1
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
         void4.2
         empty3.3
         boolean2.4
         tmp.70
         error1.5
         ascii-char0.6
         rax
         rbp))
       (ascii-char0.6 (rbp tmp-ra.98))
       (error1.5 (rbp tmp-ra.98))
       (tmp.70 (rbp tmp-ra.98))
       (boolean2.4 (rbp tmp-ra.98))
       (empty3.3 (rbp tmp-ra.98))
       (void4.2
        (fixnum5.1
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
         rax
         rbp
         tmp-ra.98))
       (tmp.73 (rsi tmp.74 rax rbp tmp-ra.98 void4.2))
       (tmp.74 (rbp tmp-ra.98 void4.2 tmp.73))
       (tmp.72 (rsi tmp.75 tmp.77 tmp.76 rax rbp tmp-ra.98 void4.2))
       (tmp.76 (rsi tmp.77 rax rbp tmp-ra.98 void4.2 tmp.72))
       (tmp.77 (rbp tmp-ra.98 void4.2 tmp.72 tmp.76))
       (tmp.75 (rbp tmp-ra.98 void4.2 tmp.72))
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
         tmp-ra.98
         void4.2))
       (tmp.80 (rsi tmp.81 rax rbp tmp-ra.98 void4.2 tmp.71))
       (tmp.81 (rbp tmp-ra.98 void4.2 tmp.71 tmp.80))
       (tmp.79 (rsi tmp.82 tmp.84 tmp.83 rax rbp tmp-ra.98 void4.2 tmp.71))
       (tmp.83 (rsi tmp.84 rax rbp tmp-ra.98 void4.2 tmp.71 tmp.79))
       (tmp.84 (rbp tmp-ra.98 void4.2 tmp.71 tmp.79 tmp.83))
       (tmp.82 (rbp tmp-ra.98 void4.2 tmp.71 tmp.79))
       (tmp.78 (rbp tmp-ra.98 void4.2 tmp.71))
       (fixnum5.1 (rbp tmp-ra.98 void4.2))
       (rbp
        (fixnum5.1
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
         void4.2
         empty3.3
         boolean2.4
         rdi
         tmp.70
         error1.5
         ascii-char0.6
         r15
         rax
         tmp-ra.98))
       (rax
        (tmp.83
         tmp.79
         tmp.80
         tmp.71
         tmp.76
         tmp.72
         tmp.73
         void4.2
         rbp
         tmp-ra.98))
       (r15 (rsi rdi rbp))
       (rdi (rsi r15 rbp))
       (rsi (tmp.71 tmp.79 tmp.83 tmp.80 tmp.72 tmp.76 tmp.73 r15 rdi rbp))))
     (assignment
      ((tmp-ra.98 fv0)
       (void4.2 fv1)
       (tmp.76 fv2)
       (tmp.80 fv2)
       (tmp.79 fv2)
       (tmp.83 fv3)
       (tmp.71 fv4)
       (tmp.72 fv3)
       (tmp.73 fv2))))
    (define L.+.17
      ((locals
        (tmp.58
         tmp.100
         tmp.22
         tmp.59
         tmp.101
         tmp-ra.85
         tmp.57
         tmp.23
         tmp.99
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp.99 (tmp.23 rbp tmp-ra.85 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.85
           tmp.22
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58
           tmp.101))
         (tmp.57 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp-ra.85
          (tmp.23
           tmp.22
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
         (tmp.101 (rbp tmp-ra.85 tmp.23))
         (tmp.59 (rbp tmp-ra.85 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.85
           rsi
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58))
         (tmp.100 (tmp.22 rbp tmp-ra.85 tmp.23))
         (tmp.58 (rbp tmp-ra.85 tmp.23 tmp.22))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.85
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58
           tmp.101
           rax))
         (rdi (tmp-ra.85))
         (rsi (tmp.22 tmp-ra.85))))
       (assignment ()))
      (begin
        (set! tmp-ra.85 r15)
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
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.85 rbp rax)))))
    (define L.*.16
      ((locals
        (tmp.62
         tmp.103
         tmp.20
         tmp.63
         tmp.105
         tmp.64
         tmp.104
         tmp-ra.86
         tmp.61
         tmp.21
         tmp.102
         tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.86 tmp.20 tmp.21))
         (tmp.102 (tmp.21 rbp tmp-ra.86 tmp.20))
         (tmp.21
          (rbp tmp-ra.86 tmp.20 tmp.102 tmp.61 tmp.60 tmp.103 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.86 tmp.20 tmp.21))
         (tmp-ra.86
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
         (tmp.104 (rbp tmp-ra.86 tmp.20))
         (tmp.64 (tmp.105 rbp tmp-ra.86 tmp.20))
         (tmp.105 (rbp tmp-ra.86 tmp.64))
         (tmp.63 (rbp tmp-ra.86 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.86
           rsi
           tmp.102
           tmp.61
           tmp.60
           tmp.103
           tmp.63
           tmp.62
           tmp.64
           tmp.104))
         (tmp.103 (tmp.20 rbp tmp-ra.86 tmp.21))
         (tmp.62 (rbp tmp-ra.86 tmp.20 tmp.21))
         (rax (rbp tmp-ra.86))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.86
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
         (rdi (tmp-ra.86))
         (rsi (tmp.20 tmp-ra.86))))
       (assignment ()))
      (begin
        (set! tmp-ra.86 r15)
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
              (jump tmp-ra.86 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.86 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.86 rbp rax)))))
    (define L.-.15
      ((locals
        (tmp.67
         tmp.107
         tmp.24
         tmp.68
         tmp.108
         tmp-ra.87
         tmp.66
         tmp.25
         tmp.106
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.87 tmp.25 tmp.24))
         (tmp.106 (tmp.25 rbp tmp-ra.87 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.87
           tmp.24
           tmp.106
           tmp.66
           tmp.65
           tmp.107
           tmp.68
           tmp.67
           tmp.108))
         (tmp.66 (rbp tmp-ra.87 tmp.25 tmp.24))
         (tmp-ra.87
          (tmp.25
           tmp.24
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
         (tmp.108 (rbp tmp-ra.87 tmp.25))
         (tmp.68 (rbp tmp-ra.87 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.87
           rsi
           tmp.106
           tmp.66
           tmp.65
           tmp.107
           tmp.68
           tmp.67))
         (tmp.107 (tmp.24 rbp tmp-ra.87 tmp.25))
         (tmp.67 (rbp tmp-ra.87 tmp.25 tmp.24))
         (rax (rbp tmp-ra.87))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.87
           tmp.106
           tmp.66
           tmp.65
           tmp.107
           tmp.68
           tmp.67
           tmp.108
           rax))
         (rdi (tmp-ra.87))
         (rsi (tmp.24 tmp-ra.87))))
       (assignment ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.106 tmp.25)
                      (set! tmp.106 (bitwise-and tmp.106 7))
                      (set! tmp.66 tmp.106))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.107 tmp.24)
                        (set! tmp.107 (bitwise-and tmp.107 7))
                        (set! tmp.68 tmp.107))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.108 tmp.24)
              (set! tmp.108 (- tmp.108 tmp.25))
              (set! rax tmp.108)
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.87 rbp rax)))))
    (define L.error?.14
      ((locals (tmp-ra.88 tmp.109 tmp.48 tmp.69))
       (conflicts
        ((tmp.69 (rbp tmp-ra.88))
         (tmp.48 (rbp tmp-ra.88))
         (tmp.109 (rbp tmp-ra.88))
         (tmp-ra.88 (tmp.48 rbp rdi tmp.109 tmp.69 rax))
         (rax (rbp tmp-ra.88))
         (rbp (tmp.48 tmp-ra.88 tmp.109 tmp.69 rax))
         (rdi (tmp-ra.88))))
       (assignment ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.48 rdi)
        (if (begin
              (begin
                (set! tmp.109 tmp.48)
                (set! tmp.109 (bitwise-and tmp.109 255))
                (set! tmp.69 tmp.109))
              (= tmp.69 62))
          (begin (set! rax 14) (jump tmp-ra.88 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.88 rbp rax)))))
    (define L.fun/error83230.4
      ((locals (tmp-ra.89))
       (conflicts ((tmp-ra.89 (rbp)) (rbp (r15 tmp-ra.89)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/error83231.10 rbp r15)))
    (define L.fun/empty83233.5
      ((locals (tmp-ra.90))
       (conflicts ((tmp-ra.90 (rbp)) (rbp (r15 tmp-ra.90)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/empty83234.9 rbp r15)))
    (define L.fun/void83236.6
      ((locals (tmp-ra.91))
       (conflicts
        ((tmp-ra.91 (rax rbp)) (rbp (rax tmp-ra.91)) (rax (rbp tmp-ra.91))))
       (assignment ()))
      (begin (set! tmp-ra.91 r15) (set! rax 30) (jump tmp-ra.91 rbp rax)))
    (define L.fun/ascii-char83229.7
      ((locals (tmp-ra.92))
       (conflicts
        ((tmp-ra.92 (rax rbp)) (rbp (rax tmp-ra.92)) (rax (rbp tmp-ra.92))))
       (assignment ()))
      (begin (set! tmp-ra.92 r15) (set! rax 25390) (jump tmp-ra.92 rbp rax)))
    (define L.fun/void83235.8
      ((locals (tmp-ra.93))
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void83236.6 rbp r15)))
    (define L.fun/empty83234.9
      ((locals (tmp-ra.94))
       (conflicts
        ((tmp-ra.94 (rax rbp)) (rbp (rax tmp-ra.94)) (rax (rbp tmp-ra.94))))
       (assignment ()))
      (begin (set! tmp-ra.94 r15) (set! rax 22) (jump tmp-ra.94 rbp rax)))
    (define L.fun/error83231.10
      ((locals (tmp-ra.95))
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95))))
       (assignment ()))
      (begin (set! tmp-ra.95 r15) (set! rax 6974) (jump tmp-ra.95 rbp rax)))
    (define L.fun/any83232.11
      ((locals (tmp-ra.96))
       (conflicts
        ((tmp-ra.96 (rax rbp)) (rbp (rax tmp-ra.96)) (rax (rbp tmp-ra.96))))
       (assignment ()))
      (begin (set! tmp-ra.96 r15) (set! rax 25390) (jump tmp-ra.96 rbp rax)))
    (define L.fun/ascii-char83228.12
      ((locals (tmp-ra.97))
       (conflicts ((tmp-ra.97 (rbp)) (rbp (r15 tmp-ra.97)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/ascii-char83229.7 rbp r15)))
    (begin
      (set! tmp-ra.98 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char83228.12 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! ascii-char0.6 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error83230.4 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/any83232.11 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rdi tmp.70)
            (set! r15 L.rp.21)
            (jump L.error?.14 rbp r15 rdi)))
        (set! rbp (+ rbp 72)))
      (set! boolean2.4 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty83233.5 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! empty3.3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void83235.8 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! void4.2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi 1816)
            (set! rdi 72)
            (set! r15 L.rp.24)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 440)
            (set! rdi 1344)
            (set! r15 L.rp.25)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.74)
            (set! rdi tmp.73)
            (set! r15 L.rp.26)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi 192)
            (set! rdi 912)
            (set! r15 L.rp.27)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 88)
            (set! rdi 608)
            (set! r15 L.rp.28)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.76)
            (set! r15 L.rp.29)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.72)
            (set! r15 L.rp.30)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi 136)
            (set! rdi 1432)
            (set! r15 L.rp.31)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 984)
            (set! rdi 824)
            (set! r15 L.rp.32)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi tmp.81)
            (set! rdi tmp.80)
            (set! r15 L.rp.33)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi 504)
            (set! rdi 208)
            (set! r15 L.rp.34)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi 720)
            (set! rdi 1128)
            (set! r15 L.rp.35)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.84)
            (set! rdi tmp.83)
            (set! r15 L.rp.36)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.79)
            (set! r15 L.rp.37)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.78)
            (set! rdi tmp.71)
            (set! r15 L.rp.38)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! fixnum5.1 rax)
      (set! rax void4.2)
      (jump tmp-ra.98 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (empty5.1
       ascii-char4.2
       boolean3.3
       tmp.57
       ascii-char2.4
       ascii-char1.5
       void0.6))
     (conflicts
      ((tmp-ra.70
        (empty5.1
         ascii-char4.2
         boolean3.3
         tmp.57
         ascii-char2.4
         ascii-char1.5
         void0.6
         rax
         rbp))
       (void0.6 (rbp tmp-ra.70))
       (ascii-char1.5 (rbp tmp-ra.70))
       (ascii-char2.4 (rbp tmp-ra.70))
       (tmp.57 (rbp tmp-ra.70))
       (boolean3.3 (rbp tmp-ra.70))
       (ascii-char4.2 (rbp tmp-ra.70))
       (empty5.1 (rbp tmp-ra.70))
       (rbp
        (empty5.1
         ascii-char4.2
         boolean3.3
         rdi
         tmp.57
         ascii-char2.4
         ascii-char1.5
         void0.6
         r15
         rax
         tmp-ra.70))
       (rax (rbp tmp-ra.70))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment ((tmp-ra.70 fv0))))
    (define L.error?.16
      ((locals (tmp-ra.58 tmp.71 tmp.48 tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.58))
         (tmp.48 (rbp tmp-ra.58))
         (tmp.71 (rbp tmp-ra.58))
         (tmp-ra.58 (tmp.48 rbp rdi tmp.71 tmp.56 rax))
         (rax (rbp tmp-ra.58))
         (rbp (tmp.48 tmp-ra.58 tmp.71 tmp.56 rax))
         (rdi (tmp-ra.58))))
       (assignment ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.48 rdi)
        (if (begin
              (begin
                (set! tmp.71 tmp.48)
                (set! tmp.71 (bitwise-and tmp.71 255))
                (set! tmp.56 tmp.71))
              (= tmp.56 62))
          (begin (set! rax 14) (jump tmp-ra.58 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.58 rbp rax)))))
    (define L.fun/ascii-char87923.4
      ((locals (tmp-ra.59))
       (conflicts ((tmp-ra.59 (rbp)) (rbp (r15 tmp-ra.59)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.59 r15)
        (set! r15 tmp-ra.59)
        (jump L.fun/ascii-char87924.13 rbp r15)))
    (define L.fun/empty87931.5
      ((locals (tmp-ra.60))
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60))))
       (assignment ()))
      (begin (set! tmp-ra.60 r15) (set! rax 22) (jump tmp-ra.60 rbp rax)))
    (define L.fun/ascii-char87928.6
      ((locals (tmp-ra.61))
       (conflicts ((tmp-ra.61 (rbp)) (rbp (r15 tmp-ra.61)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.61 r15)
        (set! r15 tmp-ra.61)
        (jump L.fun/ascii-char87929.7 rbp r15)))
    (define L.fun/ascii-char87929.7
      ((locals (tmp-ra.62))
       (conflicts
        ((tmp-ra.62 (rax rbp)) (rbp (rax tmp-ra.62)) (rax (rbp tmp-ra.62))))
       (assignment ()))
      (begin (set! tmp-ra.62 r15) (set! rax 25390) (jump tmp-ra.62 rbp rax)))
    (define L.fun/ascii-char87926.8
      ((locals (tmp-ra.63))
       (conflicts
        ((tmp-ra.63 (rax rbp)) (rbp (rax tmp-ra.63)) (rax (rbp tmp-ra.63))))
       (assignment ()))
      (begin (set! tmp-ra.63 r15) (set! rax 25390) (jump tmp-ra.63 rbp rax)))
    (define L.fun/empty87930.9
      ((locals (tmp-ra.64))
       (conflicts ((tmp-ra.64 (rbp)) (rbp (r15 tmp-ra.64)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.64 r15)
        (set! r15 tmp-ra.64)
        (jump L.fun/empty87931.5 rbp r15)))
    (define L.fun/void87922.10
      ((locals (tmp-ra.65))
       (conflicts
        ((tmp-ra.65 (rax rbp)) (rbp (rax tmp-ra.65)) (rax (rbp tmp-ra.65))))
       (assignment ()))
      (begin (set! tmp-ra.65 r15) (set! rax 30) (jump tmp-ra.65 rbp rax)))
    (define L.fun/any87927.11
      ((locals (tmp-ra.66))
       (conflicts
        ((tmp-ra.66 (rax rbp)) (rbp (rax tmp-ra.66)) (rax (rbp tmp-ra.66))))
       (assignment ()))
      (begin (set! tmp-ra.66 r15) (set! rax 30) (jump tmp-ra.66 rbp rax)))
    (define L.fun/ascii-char87925.12
      ((locals (tmp-ra.67))
       (conflicts ((tmp-ra.67 (rbp)) (rbp (r15 tmp-ra.67)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.67 r15)
        (set! r15 tmp-ra.67)
        (jump L.fun/ascii-char87926.8 rbp r15)))
    (define L.fun/ascii-char87924.13
      ((locals (tmp-ra.68))
       (conflicts
        ((tmp-ra.68 (rax rbp)) (rbp (rax tmp-ra.68)) (rax (rbp tmp-ra.68))))
       (assignment ()))
      (begin (set! tmp-ra.68 r15) (set! rax 25390) (jump tmp-ra.68 rbp rax)))
    (define L.fun/void87921.14
      ((locals (tmp-ra.69))
       (conflicts ((tmp-ra.69 (rbp)) (rbp (r15 tmp-ra.69)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.69 r15)
        (set! r15 tmp-ra.69)
        (jump L.fun/void87922.10 rbp r15)))
    (begin
      (set! tmp-ra.70 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void87921.14 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! void0.6 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char87923.4 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char1.5 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char87925.12 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char2.4 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/any87927.11 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! tmp.57 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin
            (set! rdi tmp.57)
            (set! r15 L.rp.21)
            (jump L.error?.16 rbp r15 rdi)))
        (set! rbp (+ rbp 8)))
      (set! boolean3.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char87928.6 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char4.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty87930.9 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! empty5.1 rax)
      (set! rax empty5.1)
      (jump tmp-ra.70 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (error5.1
       empty4.2
       fixnum3.3
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72
       error2.4
       void1.5))
     (conflicts
      ((tmp-ra.96
        (error5.1
         empty4.2
         fixnum3.3
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
         error2.4
         void1.5
         error0.6
         rax
         rbp))
       (error0.6
        (error5.1
         empty4.2
         fixnum3.3
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
         error2.4
         void1.5
         rax
         rbp
         tmp-ra.96))
       (void1.5 (rbp tmp-ra.96 error0.6))
       (error2.4 (rbp tmp-ra.96 error0.6))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.96 error0.6))
       (tmp.72 (rbp tmp-ra.96 error0.6 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.96 error0.6))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.96 error0.6 tmp.70))
       (tmp.75 (rbp tmp-ra.96 error0.6 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.96 error0.6 tmp.70))
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
         error0.6))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.96 error0.6 tmp.69))
       (tmp.79 (rbp tmp-ra.96 error0.6 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.96 error0.6 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.96 error0.6 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.96 error0.6 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.96 error0.6 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.96 error0.6 tmp.69))
       (fixnum3.3 (rbp tmp-ra.96 error0.6))
       (empty4.2 (rbp tmp-ra.96 error0.6))
       (error5.1 (rbp tmp-ra.96 error0.6))
       (rbp
        (error5.1
         empty4.2
         fixnum3.3
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
         error2.4
         void1.5
         error0.6
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
         error0.6
         rbp
         tmp-ra.96))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.96 fv0)
       (tmp.71 fv1)
       (tmp.70 fv1)
       (tmp.69 fv1)
       (tmp.81 fv2)
       (tmp.77 fv3)
       (tmp.78 fv2)
       (tmp.74 fv2)
       (error0.6 fv4))))
    (define L.*.17
      ((locals
        (tmp.58
         tmp.98
         tmp.20
         tmp.59
         tmp.100
         tmp.60
         tmp.99
         tmp-ra.83
         tmp.57
         tmp.21
         tmp.97
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.83 tmp.20 tmp.21))
         (tmp.97 (tmp.21 rbp tmp-ra.83 tmp.20))
         (tmp.21
          (rbp tmp-ra.83 tmp.20 tmp.97 tmp.57 tmp.56 tmp.98 tmp.59 tmp.58))
         (tmp.57 (rbp tmp-ra.83 tmp.20 tmp.21))
         (tmp-ra.83
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.100
           tmp.60
           tmp.99
           rax))
         (tmp.99 (rbp tmp-ra.83 tmp.20))
         (tmp.60 (tmp.100 rbp tmp-ra.83 tmp.20))
         (tmp.100 (rbp tmp-ra.83 tmp.60))
         (tmp.59 (rbp tmp-ra.83 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.83
           rsi
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.60
           tmp.99))
         (tmp.98 (tmp.20 rbp tmp-ra.83 tmp.21))
         (tmp.58 (rbp tmp-ra.83 tmp.20 tmp.21))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.83
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.100
           tmp.60
           tmp.99
           rax))
         (rdi (tmp-ra.83))
         (rsi (tmp.20 tmp-ra.83))))
       (assignment ()))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.21)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.57 tmp.97))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.20)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.59 tmp.98))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.99 tmp.21)
              (set! tmp.99 (arithmetic-shift-right tmp.99 3))
              (set! tmp.60 tmp.99)
              (set! tmp.100 tmp.20)
              (set! tmp.100 (* tmp.100 tmp.60))
              (set! rax tmp.100)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.83 rbp rax)))))
    (define L.-.16
      ((locals
        (tmp.63
         tmp.102
         tmp.24
         tmp.64
         tmp.103
         tmp-ra.84
         tmp.62
         tmp.25
         tmp.101
         tmp.61))
       (conflicts
        ((tmp.61 (rbp tmp-ra.84 tmp.25 tmp.24))
         (tmp.101 (tmp.25 rbp tmp-ra.84 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.84
           tmp.24
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63
           tmp.103))
         (tmp.62 (rbp tmp-ra.84 tmp.25 tmp.24))
         (tmp-ra.84
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63
           tmp.103
           rax))
         (tmp.103 (rbp tmp-ra.84 tmp.25))
         (tmp.64 (rbp tmp-ra.84 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.84
           rsi
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63))
         (tmp.102 (tmp.24 rbp tmp-ra.84 tmp.25))
         (tmp.63 (rbp tmp-ra.84 tmp.25 tmp.24))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.84
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63
           tmp.103
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.24 tmp-ra.84))))
       (assignment ()))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.101 tmp.25)
                      (set! tmp.101 (bitwise-and tmp.101 7))
                      (set! tmp.62 tmp.101))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.102 tmp.24)
                        (set! tmp.102 (bitwise-and tmp.102 7))
                        (set! tmp.64 tmp.102))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.103 tmp.24)
              (set! tmp.103 (- tmp.103 tmp.25))
              (set! rax tmp.103)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.84 rbp rax)))))
    (define L.+.15
      ((locals
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
         (rsi (tmp.22 tmp-ra.85))))
       (assignment ()))
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
    (define L.fun/void88023.4
      ((locals (tmp-ra.86))
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86))))
       (assignment ()))
      (begin (set! tmp-ra.86 r15) (set! rax 30) (jump tmp-ra.86 rbp rax)))
    (define L.fun/empty88027.5
      ((locals (tmp-ra.87))
       (conflicts
        ((tmp-ra.87 (rax rbp)) (rbp (rax tmp-ra.87)) (rax (rbp tmp-ra.87))))
       (assignment ()))
      (begin (set! tmp-ra.87 r15) (set! rax 22) (jump tmp-ra.87 rbp rax)))
    (define L.fun/error88024.6
      ((locals (tmp-ra.88))
       (conflicts ((tmp-ra.88 (rbp)) (rbp (r15 tmp-ra.88)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/error88025.11 rbp r15)))
    (define L.fun/error88021.7
      ((locals (tmp-ra.89))
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89))))
       (assignment ()))
      (begin (set! tmp-ra.89 r15) (set! rax 56894) (jump tmp-ra.89 rbp rax)))
    (define L.fun/empty88026.8
      ((locals (tmp-ra.90))
       (conflicts ((tmp-ra.90 (rbp)) (rbp (r15 tmp-ra.90)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/empty88027.5 rbp r15)))
    (define L.fun/error88029.9
      ((locals (tmp-ra.91))
       (conflicts
        ((tmp-ra.91 (rax rbp)) (rbp (rax tmp-ra.91)) (rax (rbp tmp-ra.91))))
       (assignment ()))
      (begin (set! tmp-ra.91 r15) (set! rax 50494) (jump tmp-ra.91 rbp rax)))
    (define L.fun/error88020.10
      ((locals (tmp-ra.92))
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/error88021.7 rbp r15)))
    (define L.fun/error88025.11
      ((locals (tmp-ra.93))
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93))))
       (assignment ()))
      (begin (set! tmp-ra.93 r15) (set! rax 54334) (jump tmp-ra.93 rbp rax)))
    (define L.fun/void88022.12
      ((locals (tmp-ra.94))
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/void88023.4 rbp r15)))
    (define L.fun/error88028.13
      ((locals (tmp-ra.95))
       (conflicts ((tmp-ra.95 (rbp)) (rbp (r15 tmp-ra.95)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/error88029.9 rbp r15)))
    (begin
      (set! tmp-ra.96 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error88020.10 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! error0.6 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void88022.12 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! void1.5 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error88024.6 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! error2.4 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi 608)
            (set! rdi 440)
            (set! r15 L.rp.21)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 0)
            (set! rdi 184)
            (set! r15 L.rp.22)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.23)
            (jump L.-.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi 168)
            (set! rdi 144)
            (set! r15 L.rp.24)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 1448)
            (set! rdi 1224)
            (set! r15 L.rp.25)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.26)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.27)
            (jump L.-.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 864)
            (set! rdi 32)
            (set! r15 L.rp.28)
            (jump L.-.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 872)
            (set! rdi 752)
            (set! r15 L.rp.29)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.30)
            (jump L.-.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi 1912)
            (set! rdi 1912)
            (set! r15 L.rp.31)
            (jump L.-.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 784)
            (set! rdi 1704)
            (set! r15 L.rp.32)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.33)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.34)
            (jump L.-.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.35)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! fixnum3.3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/empty88026.8 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! empty4.2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/error88028.13 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! error5.1 rax)
      (set! rax error0.6)
      (jump tmp-ra.96 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (fixnum5.1
       tmp.92
       tmp.96
       tmp.98
       tmp.95
       tmp.89
       tmp.91
       tmp.88
       empty4.2
       fixnum3.3
       tmp.78
       tmp.82
       tmp.84
       tmp.81
       tmp.75
       tmp.77
       tmp.74
       boolean1.5
       tmp.70
       void0.6))
     (conflicts
      ((tmp-ra.110
        (fixnum5.1
         tmp.92
         tmp.96
         tmp.98
         tmp.97
         tmp.93
         tmp.95
         tmp.94
         tmp.85
         tmp.89
         tmp.91
         tmp.90
         tmp.86
         tmp.88
         tmp.87
         empty4.2
         fixnum3.3
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
         ascii-char2.4
         boolean1.5
         tmp.70
         void0.6
         rax
         rbp))
       (void0.6 (rbp tmp-ra.110))
       (tmp.70 (rbp tmp-ra.110))
       (boolean1.5 (rbp tmp-ra.110))
       (ascii-char2.4
        (fixnum5.1
         tmp.92
         tmp.96
         tmp.98
         tmp.97
         tmp.93
         tmp.95
         tmp.94
         tmp.85
         tmp.89
         tmp.91
         tmp.90
         tmp.86
         tmp.88
         tmp.87
         empty4.2
         fixnum3.3
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
         rax
         rbp
         tmp-ra.110))
       (tmp.73 (rsi tmp.74 rax rbp tmp-ra.110 ascii-char2.4))
       (tmp.74 (rbp tmp-ra.110 ascii-char2.4 tmp.73))
       (tmp.72 (rsi tmp.75 tmp.77 tmp.76 rax rbp tmp-ra.110 ascii-char2.4))
       (tmp.76 (rsi tmp.77 rax rbp tmp-ra.110 ascii-char2.4 tmp.72))
       (tmp.77 (rbp tmp-ra.110 ascii-char2.4 tmp.72 tmp.76))
       (tmp.75 (rbp tmp-ra.110 ascii-char2.4 tmp.72))
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
         tmp-ra.110
         ascii-char2.4))
       (tmp.80 (rsi tmp.81 rax rbp tmp-ra.110 ascii-char2.4 tmp.71))
       (tmp.81 (rbp tmp-ra.110 ascii-char2.4 tmp.71 tmp.80))
       (tmp.79
        (rsi tmp.82 tmp.84 tmp.83 rax rbp tmp-ra.110 ascii-char2.4 tmp.71))
       (tmp.83 (rsi tmp.84 rax rbp tmp-ra.110 ascii-char2.4 tmp.71 tmp.79))
       (tmp.84 (rbp tmp-ra.110 ascii-char2.4 tmp.71 tmp.79 tmp.83))
       (tmp.82 (rbp tmp-ra.110 ascii-char2.4 tmp.71 tmp.79))
       (tmp.78 (rbp tmp-ra.110 ascii-char2.4 tmp.71))
       (fixnum3.3 (rbp tmp-ra.110 ascii-char2.4))
       (empty4.2 (rbp tmp-ra.110 ascii-char2.4))
       (tmp.87 (rsi tmp.88 rax rbp tmp-ra.110 ascii-char2.4))
       (tmp.88 (rbp tmp-ra.110 ascii-char2.4 tmp.87))
       (tmp.86 (rsi tmp.89 tmp.91 tmp.90 rax rbp tmp-ra.110 ascii-char2.4))
       (tmp.90 (rsi tmp.91 rax rbp tmp-ra.110 ascii-char2.4 tmp.86))
       (tmp.91 (rbp tmp-ra.110 ascii-char2.4 tmp.86 tmp.90))
       (tmp.89 (rbp tmp-ra.110 ascii-char2.4 tmp.86))
       (tmp.85
        (rsi
         tmp.92
         tmp.96
         tmp.98
         tmp.97
         tmp.93
         tmp.95
         tmp.94
         rax
         rbp
         tmp-ra.110
         ascii-char2.4))
       (tmp.94 (rsi tmp.95 rax rbp tmp-ra.110 ascii-char2.4 tmp.85))
       (tmp.95 (rbp tmp-ra.110 ascii-char2.4 tmp.85 tmp.94))
       (tmp.93
        (rsi tmp.96 tmp.98 tmp.97 rax rbp tmp-ra.110 ascii-char2.4 tmp.85))
       (tmp.97 (rsi tmp.98 rax rbp tmp-ra.110 ascii-char2.4 tmp.85 tmp.93))
       (tmp.98 (rbp tmp-ra.110 ascii-char2.4 tmp.85 tmp.93 tmp.97))
       (tmp.96 (rbp tmp-ra.110 ascii-char2.4 tmp.85 tmp.93))
       (tmp.92 (rbp tmp-ra.110 ascii-char2.4 tmp.85))
       (fixnum5.1 (rbp tmp-ra.110 ascii-char2.4))
       (rbp
        (fixnum5.1
         tmp.92
         tmp.96
         tmp.98
         tmp.97
         tmp.93
         tmp.95
         tmp.94
         tmp.85
         tmp.89
         tmp.91
         tmp.90
         tmp.86
         tmp.88
         tmp.87
         empty4.2
         fixnum3.3
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
         ascii-char2.4
         boolean1.5
         rdi
         tmp.70
         void0.6
         r15
         rax
         tmp-ra.110))
       (rax
        (tmp.97
         tmp.93
         tmp.94
         tmp.85
         tmp.90
         tmp.86
         tmp.87
         tmp.83
         tmp.79
         tmp.80
         tmp.71
         tmp.76
         tmp.72
         tmp.73
         ascii-char2.4
         rbp
         tmp-ra.110))
       (r15 (rsi rdi rbp))
       (rdi (rsi r15 rbp))
       (rsi
        (tmp.85
         tmp.93
         tmp.97
         tmp.94
         tmp.86
         tmp.90
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
         rbp))))
     (assignment
      ((tmp-ra.110 fv0)
       (ascii-char2.4 fv1)
       (tmp.76 fv2)
       (tmp.80 fv2)
       (tmp.79 fv2)
       (tmp.90 fv2)
       (tmp.94 fv2)
       (tmp.93 fv2)
       (tmp.97 fv3)
       (tmp.85 fv4)
       (tmp.86 fv3)
       (tmp.87 fv2)
       (tmp.83 fv3)
       (tmp.71 fv4)
       (tmp.72 fv3)
       (tmp.73 fv2))))
    (define L.+.15
      ((locals
        (tmp.58
         tmp.112
         tmp.22
         tmp.59
         tmp.113
         tmp-ra.99
         tmp.57
         tmp.23
         tmp.111
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.99 tmp.23 tmp.22))
         (tmp.111 (tmp.23 rbp tmp-ra.99 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.99
           tmp.22
           tmp.111
           tmp.57
           tmp.56
           tmp.112
           tmp.59
           tmp.58
           tmp.113))
         (tmp.57 (rbp tmp-ra.99 tmp.23 tmp.22))
         (tmp-ra.99
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.111
           tmp.57
           tmp.56
           tmp.112
           tmp.59
           tmp.58
           tmp.113
           rax))
         (tmp.113 (rbp tmp-ra.99 tmp.23))
         (tmp.59 (rbp tmp-ra.99 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.99
           rsi
           tmp.111
           tmp.57
           tmp.56
           tmp.112
           tmp.59
           tmp.58))
         (tmp.112 (tmp.22 rbp tmp-ra.99 tmp.23))
         (tmp.58 (rbp tmp-ra.99 tmp.23 tmp.22))
         (rax (rbp tmp-ra.99))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.99
           tmp.111
           tmp.57
           tmp.56
           tmp.112
           tmp.59
           tmp.58
           tmp.113
           rax))
         (rdi (tmp-ra.99))
         (rsi (tmp.22 tmp-ra.99))))
       (assignment ()))
      (begin
        (set! tmp-ra.99 r15)
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
              (jump tmp-ra.99 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.99 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.99 rbp rax)))))
    (define L.*.14
      ((locals
        (tmp.62
         tmp.115
         tmp.20
         tmp.63
         tmp.117
         tmp.64
         tmp.116
         tmp-ra.100
         tmp.61
         tmp.21
         tmp.114
         tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.100 tmp.20 tmp.21))
         (tmp.114 (tmp.21 rbp tmp-ra.100 tmp.20))
         (tmp.21
          (rbp tmp-ra.100 tmp.20 tmp.114 tmp.61 tmp.60 tmp.115 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.100 tmp.20 tmp.21))
         (tmp-ra.100
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.114
           tmp.61
           tmp.60
           tmp.115
           tmp.63
           tmp.62
           tmp.117
           tmp.64
           tmp.116
           rax))
         (tmp.116 (rbp tmp-ra.100 tmp.20))
         (tmp.64 (tmp.117 rbp tmp-ra.100 tmp.20))
         (tmp.117 (rbp tmp-ra.100 tmp.64))
         (tmp.63 (rbp tmp-ra.100 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.100
           rsi
           tmp.114
           tmp.61
           tmp.60
           tmp.115
           tmp.63
           tmp.62
           tmp.64
           tmp.116))
         (tmp.115 (tmp.20 rbp tmp-ra.100 tmp.21))
         (tmp.62 (rbp tmp-ra.100 tmp.20 tmp.21))
         (rax (rbp tmp-ra.100))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.100
           tmp.114
           tmp.61
           tmp.60
           tmp.115
           tmp.63
           tmp.62
           tmp.117
           tmp.64
           tmp.116
           rax))
         (rdi (tmp-ra.100))
         (rsi (tmp.20 tmp-ra.100))))
       (assignment ()))
      (begin
        (set! tmp-ra.100 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.114 tmp.21)
                      (set! tmp.114 (bitwise-and tmp.114 7))
                      (set! tmp.61 tmp.114))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.115 tmp.20)
                        (set! tmp.115 (bitwise-and tmp.115 7))
                        (set! tmp.63 tmp.115))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.116 tmp.21)
              (set! tmp.116 (arithmetic-shift-right tmp.116 3))
              (set! tmp.64 tmp.116)
              (set! tmp.117 tmp.20)
              (set! tmp.117 (* tmp.117 tmp.64))
              (set! rax tmp.117)
              (jump tmp-ra.100 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.100 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.100 rbp rax)))))
    (define L.-.13
      ((locals
        (tmp.67
         tmp.119
         tmp.24
         tmp.68
         tmp.120
         tmp-ra.101
         tmp.66
         tmp.25
         tmp.118
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.101 tmp.25 tmp.24))
         (tmp.118 (tmp.25 rbp tmp-ra.101 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.101
           tmp.24
           tmp.118
           tmp.66
           tmp.65
           tmp.119
           tmp.68
           tmp.67
           tmp.120))
         (tmp.66 (rbp tmp-ra.101 tmp.25 tmp.24))
         (tmp-ra.101
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.118
           tmp.66
           tmp.65
           tmp.119
           tmp.68
           tmp.67
           tmp.120
           rax))
         (tmp.120 (rbp tmp-ra.101 tmp.25))
         (tmp.68 (rbp tmp-ra.101 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.101
           rsi
           tmp.118
           tmp.66
           tmp.65
           tmp.119
           tmp.68
           tmp.67))
         (tmp.119 (tmp.24 rbp tmp-ra.101 tmp.25))
         (tmp.67 (rbp tmp-ra.101 tmp.25 tmp.24))
         (rax (rbp tmp-ra.101))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.101
           tmp.118
           tmp.66
           tmp.65
           tmp.119
           tmp.68
           tmp.67
           tmp.120
           rax))
         (rdi (tmp-ra.101))
         (rsi (tmp.24 tmp-ra.101))))
       (assignment ()))
      (begin
        (set! tmp-ra.101 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.118 tmp.25)
                      (set! tmp.118 (bitwise-and tmp.118 7))
                      (set! tmp.66 tmp.118))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.119 tmp.24)
                        (set! tmp.119 (bitwise-and tmp.119 7))
                        (set! tmp.68 tmp.119))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.120 tmp.24)
              (set! tmp.120 (- tmp.120 tmp.25))
              (set! rax tmp.120)
              (jump tmp-ra.101 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.101 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.101 rbp rax)))))
    (define L.pair?.12
      ((locals (tmp-ra.102 tmp.121 tmp.49 tmp.69))
       (conflicts
        ((tmp.69 (rbp tmp-ra.102))
         (tmp.49 (rbp tmp-ra.102))
         (tmp.121 (rbp tmp-ra.102))
         (tmp-ra.102 (tmp.49 rbp rdi tmp.121 tmp.69 rax))
         (rax (rbp tmp-ra.102))
         (rbp (tmp.49 tmp-ra.102 tmp.121 tmp.69 rax))
         (rdi (tmp-ra.102))))
       (assignment ()))
      (begin
        (set! tmp-ra.102 r15)
        (set! tmp.49 rdi)
        (if (begin
              (begin
                (set! tmp.121 tmp.49)
                (set! tmp.121 (bitwise-and tmp.121 7))
                (set! tmp.69 tmp.121))
              (= tmp.69 1))
          (begin (set! rax 14) (jump tmp-ra.102 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.102 rbp rax)))))
    (define L.fun/ascii-char95245.4
      ((locals (tmp-ra.103))
       (conflicts
        ((tmp-ra.103 (rax rbp)) (rbp (rax tmp-ra.103)) (rax (rbp tmp-ra.103))))
       (assignment ()))
      (begin (set! tmp-ra.103 r15) (set! rax 25390) (jump tmp-ra.103 rbp rax)))
    (define L.fun/empty95247.5
      ((locals (tmp-ra.104))
       (conflicts
        ((tmp-ra.104 (rax rbp)) (rbp (rax tmp-ra.104)) (rax (rbp tmp-ra.104))))
       (assignment ()))
      (begin (set! tmp-ra.104 r15) (set! rax 22) (jump tmp-ra.104 rbp rax)))
    (define L.fun/void95242.6
      ((locals (tmp-ra.105))
       (conflicts
        ((tmp-ra.105 (rax rbp)) (rbp (rax tmp-ra.105)) (rax (rbp tmp-ra.105))))
       (assignment ()))
      (begin (set! tmp-ra.105 r15) (set! rax 30) (jump tmp-ra.105 rbp rax)))
    (define L.fun/void95241.7
      ((locals (tmp-ra.106))
       (conflicts ((tmp-ra.106 (rbp)) (rbp (r15 tmp-ra.106)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.106 r15)
        (set! r15 tmp-ra.106)
        (jump L.fun/void95242.6 rbp r15)))
    (define L.fun/any95243.8
      ((locals (tmp-ra.107))
       (conflicts
        ((tmp-ra.107 (rax rbp)) (rbp (rax tmp-ra.107)) (rax (rbp tmp-ra.107))))
       (assignment ()))
      (begin (set! tmp-ra.107 r15) (set! rax 30) (jump tmp-ra.107 rbp rax)))
    (define L.fun/ascii-char95244.9
      ((locals (tmp-ra.108))
       (conflicts ((tmp-ra.108 (rbp)) (rbp (r15 tmp-ra.108)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.108 r15)
        (set! r15 tmp-ra.108)
        (jump L.fun/ascii-char95245.4 rbp r15)))
    (define L.fun/empty95246.10
      ((locals (tmp-ra.109))
       (conflicts ((tmp-ra.109 (rbp)) (rbp (r15 tmp-ra.109)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.109 r15)
        (set! r15 tmp-ra.109)
        (jump L.fun/empty95247.5 rbp r15)))
    (begin
      (set! tmp-ra.110 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void95241.7 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! void0.6 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/any95243.8 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rdi tmp.70)
            (set! r15 L.rp.18)
            (jump L.pair?.12 rbp r15 rdi)))
        (set! rbp (+ rbp 128)))
      (set! boolean1.5 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char95244.9 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! ascii-char2.4 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi 1928)
            (set! rdi 336)
            (set! r15 L.rp.20)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi 1904)
            (set! rdi 776)
            (set! r15 L.rp.21)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.74)
            (set! rdi tmp.73)
            (set! r15 L.rp.22)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi 376)
            (set! rdi 1720)
            (set! r15 L.rp.23)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi 256)
            (set! rdi 912)
            (set! r15 L.rp.24)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.76)
            (set! r15 L.rp.25)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.72)
            (set! r15 L.rp.26)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi 1400)
            (set! rdi 136)
            (set! r15 L.rp.27)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi 1648)
            (set! rdi 1472)
            (set! r15 L.rp.28)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.81)
            (set! rdi tmp.80)
            (set! r15 L.rp.29)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi 528)
            (set! rdi 1240)
            (set! r15 L.rp.30)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin
            (set! rsi 728)
            (set! rdi 1200)
            (set! r15 L.rp.31)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin
            (set! rsi tmp.84)
            (set! rdi tmp.83)
            (set! r15 L.rp.32)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.79)
            (set! r15 L.rp.33)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi tmp.78)
            (set! rdi tmp.71)
            (set! r15 L.rp.34)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! fixnum3.3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/empty95246.10 rbp r15)))
        (set! rbp (+ rbp 128)))
      (set! empty4.2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi 1368)
            (set! rdi 168)
            (set! r15 L.rp.36)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi 1400)
            (set! rdi 1368)
            (set! r15 L.rp.37)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.88)
            (set! rdi tmp.87)
            (set! r15 L.rp.38)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi 72)
            (set! rdi 696)
            (set! r15 L.rp.39)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi 128)
            (set! rdi 1616)
            (set! r15 L.rp.40)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi tmp.91)
            (set! rdi tmp.90)
            (set! r15 L.rp.41)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi tmp.89)
            (set! rdi tmp.86)
            (set! r15 L.rp.42)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi 896)
            (set! rdi 360)
            (set! r15 L.rp.43)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi 1472)
            (set! rdi 1968)
            (set! r15 L.rp.44)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi tmp.95)
            (set! rdi tmp.94)
            (set! r15 L.rp.45)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin
            (set! rsi 1136)
            (set! rdi 1360)
            (set! r15 L.rp.46)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.97 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin
            (set! rsi 728)
            (set! rdi 1096)
            (set! r15 L.rp.47)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.98 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin
            (set! rsi tmp.98)
            (set! rdi tmp.97)
            (set! r15 L.rp.48)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin
            (set! rsi tmp.96)
            (set! rdi tmp.93)
            (set! r15 L.rp.49)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.50
          (begin
            (set! rsi tmp.92)
            (set! rdi tmp.85)
            (set! r15 L.rp.50)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 128)))
      (set! fixnum5.1 rax)
      (set! rax ascii-char2.4)
      (jump tmp-ra.110 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (ascii-char5.1
       void4.2
       void3.3
       ascii-char2.4
       fixnum1.5
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72
       ascii-char0.6))
     (conflicts
      ((tmp-ra.96
        (ascii-char5.1
         void4.2
         void3.3
         ascii-char2.4
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
         ascii-char0.6
         rax
         rbp))
       (ascii-char0.6 (rbp tmp-ra.96))
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
       (ascii-char2.4 (rbp tmp-ra.96))
       (void3.3 (rbp tmp-ra.96))
       (void4.2 (rbp tmp-ra.96))
       (ascii-char5.1 (rbp tmp-ra.96))
       (rbp
        (ascii-char5.1
         void4.2
         void3.3
         ascii-char2.4
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
         ascii-char0.6
         r15
         rax
         tmp-ra.96))
       (rax (tmp.81 tmp.77 tmp.78 tmp.69 tmp.74 tmp.70 tmp.71 rbp tmp-ra.96))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.96 fv0)
       (tmp.71 fv1)
       (tmp.70 fv1)
       (tmp.69 fv1)
       (tmp.81 fv2)
       (tmp.77 fv3)
       (tmp.78 fv2)
       (tmp.74 fv2))))
    (define L.*.17
      ((locals
        (tmp.58
         tmp.98
         tmp.20
         tmp.59
         tmp.100
         tmp.60
         tmp.99
         tmp-ra.83
         tmp.57
         tmp.21
         tmp.97
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.83 tmp.20 tmp.21))
         (tmp.97 (tmp.21 rbp tmp-ra.83 tmp.20))
         (tmp.21
          (rbp tmp-ra.83 tmp.20 tmp.97 tmp.57 tmp.56 tmp.98 tmp.59 tmp.58))
         (tmp.57 (rbp tmp-ra.83 tmp.20 tmp.21))
         (tmp-ra.83
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.100
           tmp.60
           tmp.99
           rax))
         (tmp.99 (rbp tmp-ra.83 tmp.20))
         (tmp.60 (tmp.100 rbp tmp-ra.83 tmp.20))
         (tmp.100 (rbp tmp-ra.83 tmp.60))
         (tmp.59 (rbp tmp-ra.83 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.83
           rsi
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.60
           tmp.99))
         (tmp.98 (tmp.20 rbp tmp-ra.83 tmp.21))
         (tmp.58 (rbp tmp-ra.83 tmp.20 tmp.21))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.83
           tmp.97
           tmp.57
           tmp.56
           tmp.98
           tmp.59
           tmp.58
           tmp.100
           tmp.60
           tmp.99
           rax))
         (rdi (tmp-ra.83))
         (rsi (tmp.20 tmp-ra.83))))
       (assignment ()))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.21)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.57 tmp.97))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.20)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.59 tmp.98))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.99 tmp.21)
              (set! tmp.99 (arithmetic-shift-right tmp.99 3))
              (set! tmp.60 tmp.99)
              (set! tmp.100 tmp.20)
              (set! tmp.100 (* tmp.100 tmp.60))
              (set! rax tmp.100)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.83 rbp rax)))))
    (define L.+.16
      ((locals
        (tmp.63
         tmp.102
         tmp.22
         tmp.64
         tmp.103
         tmp-ra.84
         tmp.62
         tmp.23
         tmp.101
         tmp.61))
       (conflicts
        ((tmp.61 (rbp tmp-ra.84 tmp.23 tmp.22))
         (tmp.101 (tmp.23 rbp tmp-ra.84 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.84
           tmp.22
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63
           tmp.103))
         (tmp.62 (rbp tmp-ra.84 tmp.23 tmp.22))
         (tmp-ra.84
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63
           tmp.103
           rax))
         (tmp.103 (rbp tmp-ra.84 tmp.23))
         (tmp.64 (rbp tmp-ra.84 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.84
           rsi
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63))
         (tmp.102 (tmp.22 rbp tmp-ra.84 tmp.23))
         (tmp.63 (rbp tmp-ra.84 tmp.23 tmp.22))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.84
           tmp.101
           tmp.62
           tmp.61
           tmp.102
           tmp.64
           tmp.63
           tmp.103
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.22 tmp-ra.84))))
       (assignment ()))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.101 tmp.23)
                      (set! tmp.101 (bitwise-and tmp.101 7))
                      (set! tmp.62 tmp.101))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.102 tmp.22)
                        (set! tmp.102 (bitwise-and tmp.102 7))
                        (set! tmp.64 tmp.102))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.103 tmp.22)
              (set! tmp.103 (+ tmp.103 tmp.23))
              (set! rax tmp.103)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.84 rbp rax)))))
    (define L.-.15
      ((locals
        (tmp.67
         tmp.105
         tmp.24
         tmp.68
         tmp.106
         tmp-ra.85
         tmp.66
         tmp.25
         tmp.104
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.104 (tmp.25 rbp tmp-ra.85 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.85
           tmp.24
           tmp.104
           tmp.66
           tmp.65
           tmp.105
           tmp.68
           tmp.67
           tmp.106))
         (tmp.66 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp-ra.85
          (tmp.25
           tmp.24
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
         (tmp.106 (rbp tmp-ra.85 tmp.25))
         (tmp.68 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.85
           rsi
           tmp.104
           tmp.66
           tmp.65
           tmp.105
           tmp.68
           tmp.67))
         (tmp.105 (tmp.24 rbp tmp-ra.85 tmp.25))
         (tmp.67 (rbp tmp-ra.85 tmp.25 tmp.24))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.25
           tmp.24
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
         (rsi (tmp.24 tmp-ra.85))))
       (assignment ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.25)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.66 tmp.104))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.24)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.68 tmp.105))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.106 tmp.24)
              (set! tmp.106 (- tmp.106 tmp.25))
              (set! rax tmp.106)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/ascii-char101002.4
      ((locals (tmp-ra.86))
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86))))
       (assignment ()))
      (begin (set! tmp-ra.86 r15) (set! rax 25390) (jump tmp-ra.86 rbp rax)))
    (define L.fun/void101005.5
      ((locals (tmp-ra.87))
       (conflicts ((tmp-ra.87 (rbp)) (rbp (r15 tmp-ra.87)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/void101006.12 rbp r15)))
    (define L.fun/ascii-char101007.6
      ((locals (tmp-ra.88))
       (conflicts ((tmp-ra.88 (rbp)) (rbp (r15 tmp-ra.88)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/ascii-char101008.10 rbp r15)))
    (define L.fun/ascii-char101000.7
      ((locals (tmp-ra.89))
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89))))
       (assignment ()))
      (begin (set! tmp-ra.89 r15) (set! rax 25390) (jump tmp-ra.89 rbp rax)))
    (define L.fun/void101004.8
      ((locals (tmp-ra.90))
       (conflicts
        ((tmp-ra.90 (rax rbp)) (rbp (rax tmp-ra.90)) (rax (rbp tmp-ra.90))))
       (assignment ()))
      (begin (set! tmp-ra.90 r15) (set! rax 30) (jump tmp-ra.90 rbp rax)))
    (define L.fun/ascii-char100999.9
      ((locals (tmp-ra.91))
       (conflicts ((tmp-ra.91 (rbp)) (rbp (r15 tmp-ra.91)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/ascii-char101000.7 rbp r15)))
    (define L.fun/ascii-char101008.10
      ((locals (tmp-ra.92))
       (conflicts
        ((tmp-ra.92 (rax rbp)) (rbp (rax tmp-ra.92)) (rax (rbp tmp-ra.92))))
       (assignment ()))
      (begin (set! tmp-ra.92 r15) (set! rax 25390) (jump tmp-ra.92 rbp rax)))
    (define L.fun/void101003.11
      ((locals (tmp-ra.93))
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void101004.8 rbp r15)))
    (define L.fun/void101006.12
      ((locals (tmp-ra.94))
       (conflicts
        ((tmp-ra.94 (rax rbp)) (rbp (rax tmp-ra.94)) (rax (rbp tmp-ra.94))))
       (assignment ()))
      (begin (set! tmp-ra.94 r15) (set! rax 30) (jump tmp-ra.94 rbp rax)))
    (define L.fun/ascii-char101001.13
      ((locals (tmp-ra.95))
       (conflicts ((tmp-ra.95 (rbp)) (rbp (r15 tmp-ra.95)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/ascii-char101002.4 rbp r15)))
    (begin
      (set! tmp-ra.96 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char100999.9 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char0.6 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin
            (set! rsi 720)
            (set! rdi 1032)
            (set! r15 L.rp.19)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin
            (set! rsi 1568)
            (set! rdi 1368)
            (set! r15 L.rp.20)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.21)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 952)
            (set! rdi 576)
            (set! r15 L.rp.22)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi 976)
            (set! rdi 112)
            (set! r15 L.rp.23)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.24)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.25)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 1048)
            (set! rdi 1704)
            (set! r15 L.rp.26)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 16)
            (set! rdi 728)
            (set! r15 L.rp.27)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.28)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 1072)
            (set! rdi 784)
            (set! r15 L.rp.29)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi 1152)
            (set! rdi 1656)
            (set! r15 L.rp.30)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.31)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.32)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.33)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum1.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/ascii-char101001.13 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char2.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/void101003.11 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/void101005.5 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void4.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char101007.6 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char5.1 rax)
      (set! rax ascii-char5.1)
      (jump tmp-ra.96 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (ascii-char5.1
       fixnum4.2
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72
       void2.4
       empty1.5
       void0.6))
     (conflicts
      ((tmp-ra.96
        (ascii-char5.1
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
         void2.4
         empty1.5
         void0.6
         rax
         rbp))
       (void0.6 (rbp tmp-ra.96))
       (empty1.5 (rbp tmp-ra.96))
       (void2.4 (rbp tmp-ra.96))
       (error3.3
        (ascii-char5.1
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
         rax
         rbp
         tmp-ra.96))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.96 error3.3))
       (tmp.72 (rbp tmp-ra.96 error3.3 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.96 error3.3))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.96 error3.3 tmp.70))
       (tmp.75 (rbp tmp-ra.96 error3.3 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.96 error3.3 tmp.70))
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
         error3.3))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.96 error3.3 tmp.69))
       (tmp.79 (rbp tmp-ra.96 error3.3 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.96 error3.3 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.96 error3.3 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.96 error3.3 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.96 error3.3 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.96 error3.3 tmp.69))
       (fixnum4.2 (rbp tmp-ra.96 error3.3))
       (ascii-char5.1 (rbp tmp-ra.96 error3.3))
       (rbp
        (ascii-char5.1
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
         void2.4
         empty1.5
         void0.6
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
         error3.3
         rbp
         tmp-ra.96))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.96 fv0)
       (error3.3 fv1)
       (tmp.74 fv2)
       (tmp.78 fv2)
       (tmp.77 fv2)
       (tmp.81 fv3)
       (tmp.69 fv4)
       (tmp.70 fv3)
       (tmp.71 fv2))))
    (define L.-.17
      ((locals
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
         (rsi (tmp.24 tmp-ra.83))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.22 tmp-ra.84))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.20 tmp-ra.85))))
       (assignment ()))
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
    (define L.fun/error102221.4
      ((locals (tmp-ra.86))
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86))))
       (assignment ()))
      (begin (set! tmp-ra.86 r15) (set! rax 2110) (jump tmp-ra.86 rbp rax)))
    (define L.fun/void102218.5
      ((locals (tmp-ra.87))
       (conflicts ((tmp-ra.87 (rbp)) (rbp (r15 tmp-ra.87)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/void102219.11 rbp r15)))
    (define L.fun/empty102216.6
      ((locals (tmp-ra.88))
       (conflicts ((tmp-ra.88 (rbp)) (rbp (r15 tmp-ra.88)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/empty102217.9 rbp r15)))
    (define L.fun/ascii-char102223.7
      ((locals (tmp-ra.89))
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89))))
       (assignment ()))
      (begin (set! tmp-ra.89 r15) (set! rax 25390) (jump tmp-ra.89 rbp rax)))
    (define L.fun/void102214.8
      ((locals (tmp-ra.90))
       (conflicts ((tmp-ra.90 (rbp)) (rbp (r15 tmp-ra.90)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/void102215.13 rbp r15)))
    (define L.fun/empty102217.9
      ((locals (tmp-ra.91))
       (conflicts
        ((tmp-ra.91 (rax rbp)) (rbp (rax tmp-ra.91)) (rax (rbp tmp-ra.91))))
       (assignment ()))
      (begin (set! tmp-ra.91 r15) (set! rax 22) (jump tmp-ra.91 rbp rax)))
    (define L.fun/error102220.10
      ((locals (tmp-ra.92))
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/error102221.4 rbp r15)))
    (define L.fun/void102219.11
      ((locals (tmp-ra.93))
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93))))
       (assignment ()))
      (begin (set! tmp-ra.93 r15) (set! rax 30) (jump tmp-ra.93 rbp rax)))
    (define L.fun/ascii-char102222.12
      ((locals (tmp-ra.94))
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/ascii-char102223.7 rbp r15)))
    (define L.fun/void102215.13
      ((locals (tmp-ra.95))
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95))))
       (assignment ()))
      (begin (set! tmp-ra.95 r15) (set! rax 30) (jump tmp-ra.95 rbp rax)))
    (begin
      (set! tmp-ra.96 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void102214.8 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! void0.6 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/empty102216.6 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! empty1.5 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void102218.5 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! void2.4 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error102220.10 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! error3.3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 184)
            (set! rdi 1688)
            (set! r15 L.rp.22)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi 936)
            (set! rdi 1192)
            (set! r15 L.rp.23)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.24)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 1936)
            (set! rdi 1264)
            (set! r15 L.rp.25)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 1968)
            (set! rdi 656)
            (set! r15 L.rp.26)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.27)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.28)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 1256)
            (set! rdi 632)
            (set! r15 L.rp.29)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi 520)
            (set! rdi 1456)
            (set! r15 L.rp.30)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.31)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 1832)
            (set! rdi 568)
            (set! r15 L.rp.32)
            (jump L.*.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi 24)
            (set! rdi 1672)
            (set! r15 L.rp.33)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.34)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.35)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.36)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char102222.12 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! ascii-char5.1 rax)
      (set! rax error3.3)
      (jump tmp-ra.96 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (tmp.78
       tmp.82
       tmp.84
       tmp.81
       tmp.75
       tmp.77
       tmp.74
       void5.1
       void4.2
       ascii-char3.3
       boolean2.4
       tmp.70
       ascii-char1.5
       ascii-char0.6))
     (conflicts
      ((tmp-ra.100
        (rdi
         rsi
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
         void5.1
         void4.2
         ascii-char3.3
         boolean2.4
         tmp.70
         ascii-char1.5
         ascii-char0.6
         rax
         rbp))
       (ascii-char0.6 (rbp tmp-ra.100))
       (ascii-char1.5 (rbp tmp-ra.100))
       (tmp.70 (rbp tmp-ra.100))
       (boolean2.4 (rbp tmp-ra.100))
       (ascii-char3.3 (rbp tmp-ra.100))
       (void4.2 (rbp tmp-ra.100))
       (void5.1 (rbp tmp-ra.100))
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
       (rbp
        (tmp.78
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
         void5.1
         void4.2
         ascii-char3.3
         boolean2.4
         rdi
         tmp.70
         ascii-char1.5
         ascii-char0.6
         r15
         rax
         tmp-ra.100))
       (rax (tmp.83 tmp.79 tmp.80 tmp.71 tmp.76 tmp.72 tmp.73 rbp tmp-ra.100))
       (r15 (rsi rdi rbp))
       (rdi (tmp-ra.100 rsi r15 rbp))
       (rsi
        (tmp-ra.100
         tmp.71
         tmp.79
         tmp.83
         tmp.80
         tmp.72
         tmp.76
         tmp.73
         r15
         rdi
         rbp))))
     (assignment
      ((tmp-ra.100 fv0)
       (tmp.73 fv1)
       (tmp.72 fv1)
       (tmp.71 fv1)
       (tmp.83 fv2)
       (tmp.79 fv3)
       (tmp.80 fv2)
       (tmp.76 fv2))))
    (define L.-.19
      ((locals
        (tmp.58
         tmp.102
         tmp.24
         tmp.59
         tmp.103
         tmp-ra.85
         tmp.57
         tmp.25
         tmp.101
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.101 (tmp.25 rbp tmp-ra.85 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.85
           tmp.24
           tmp.101
           tmp.57
           tmp.56
           tmp.102
           tmp.59
           tmp.58
           tmp.103))
         (tmp.57 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp-ra.85
          (tmp.25
           tmp.24
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
         (tmp.103 (rbp tmp-ra.85 tmp.25))
         (tmp.59 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.85
           rsi
           tmp.101
           tmp.57
           tmp.56
           tmp.102
           tmp.59
           tmp.58))
         (tmp.102 (tmp.24 rbp tmp-ra.85 tmp.25))
         (tmp.58 (rbp tmp-ra.85 tmp.25 tmp.24))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.25
           tmp.24
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
         (rsi (tmp.24 tmp-ra.85))))
       (assignment ()))
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
    (define L.*.18
      ((locals
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
         (rsi (tmp.20 tmp-ra.86))))
       (assignment ()))
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
    (define L.+.17
      ((locals
        (tmp.67
         tmp.109
         tmp.22
         tmp.68
         tmp.110
         tmp-ra.87
         tmp.66
         tmp.23
         tmp.108
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.87 tmp.23 tmp.22))
         (tmp.108 (tmp.23 rbp tmp-ra.87 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.87
           tmp.22
           tmp.108
           tmp.66
           tmp.65
           tmp.109
           tmp.68
           tmp.67
           tmp.110))
         (tmp.66 (rbp tmp-ra.87 tmp.23 tmp.22))
         (tmp-ra.87
          (tmp.23
           tmp.22
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
         (tmp.110 (rbp tmp-ra.87 tmp.23))
         (tmp.68 (rbp tmp-ra.87 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.87
           rsi
           tmp.108
           tmp.66
           tmp.65
           tmp.109
           tmp.68
           tmp.67))
         (tmp.109 (tmp.22 rbp tmp-ra.87 tmp.23))
         (tmp.67 (rbp tmp-ra.87 tmp.23 tmp.22))
         (rax (rbp tmp-ra.87))
         (rbp
          (tmp.23
           tmp.22
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
         (rsi (tmp.22 tmp-ra.87))))
       (assignment ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.108 tmp.23)
                      (set! tmp.108 (bitwise-and tmp.108 7))
                      (set! tmp.66 tmp.108))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.109 tmp.22)
                        (set! tmp.109 (bitwise-and tmp.109 7))
                        (set! tmp.68 tmp.109))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.110 tmp.22)
              (set! tmp.110 (+ tmp.110 tmp.23))
              (set! rax tmp.110)
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.87 rbp rax)))))
    (define L.vector?.16
      ((locals (tmp-ra.88 tmp.111 tmp.50 tmp.69))
       (conflicts
        ((tmp.69 (rbp tmp-ra.88))
         (tmp.50 (rbp tmp-ra.88))
         (tmp.111 (rbp tmp-ra.88))
         (tmp-ra.88 (tmp.50 rbp rdi tmp.111 tmp.69 rax))
         (rax (rbp tmp-ra.88))
         (rbp (tmp.50 tmp-ra.88 tmp.111 tmp.69 rax))
         (rdi (tmp-ra.88))))
       (assignment ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.50 rdi)
        (if (begin
              (begin
                (set! tmp.111 tmp.50)
                (set! tmp.111 (bitwise-and tmp.111 7))
                (set! tmp.69 tmp.111))
              (= tmp.69 3))
          (begin (set! rax 14) (jump tmp-ra.88 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.88 rbp rax)))))
    (define L.fun/void102243.4
      ((locals (tmp-ra.89))
       (conflicts ((tmp-ra.89 (rbp)) (rbp (r15 tmp-ra.89)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.89 r15)
        (set! r15 tmp-ra.89)
        (jump L.fun/void102244.10 rbp r15)))
    (define L.fun/any102238.5
      ((locals (tmp-ra.90))
       (conflicts
        ((tmp-ra.90 (rax rbp)) (rbp (rax tmp-ra.90)) (rax (rbp tmp-ra.90))))
       (assignment ()))
      (begin (set! tmp-ra.90 r15) (set! rax 6) (jump tmp-ra.90 rbp rax)))
    (define L.fun/ascii-char102236.6
      ((locals (tmp-ra.91))
       (conflicts ((tmp-ra.91 (rbp)) (rbp (r15 tmp-ra.91)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/ascii-char102237.13 rbp r15)))
    (define L.fun/void102241.7
      ((locals (tmp-ra.92))
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/void102242.11 rbp r15)))
    (define L.fun/ascii-char102239.8
      ((locals (tmp-ra.93))
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/ascii-char102240.12 rbp r15)))
    (define L.fun/ascii-char102234.9
      ((locals (tmp-ra.94))
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/ascii-char102235.14 rbp r15)))
    (define L.fun/void102244.10
      ((locals (tmp-ra.95))
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95))))
       (assignment ()))
      (begin (set! tmp-ra.95 r15) (set! rax 30) (jump tmp-ra.95 rbp rax)))
    (define L.fun/void102242.11
      ((locals (tmp-ra.96))
       (conflicts
        ((tmp-ra.96 (rax rbp)) (rbp (rax tmp-ra.96)) (rax (rbp tmp-ra.96))))
       (assignment ()))
      (begin (set! tmp-ra.96 r15) (set! rax 30) (jump tmp-ra.96 rbp rax)))
    (define L.fun/ascii-char102240.12
      ((locals (tmp-ra.97))
       (conflicts
        ((tmp-ra.97 (rax rbp)) (rbp (rax tmp-ra.97)) (rax (rbp tmp-ra.97))))
       (assignment ()))
      (begin (set! tmp-ra.97 r15) (set! rax 25390) (jump tmp-ra.97 rbp rax)))
    (define L.fun/ascii-char102237.13
      ((locals (tmp-ra.98))
       (conflicts
        ((tmp-ra.98 (rax rbp)) (rbp (rax tmp-ra.98)) (rax (rbp tmp-ra.98))))
       (assignment ()))
      (begin (set! tmp-ra.98 r15) (set! rax 25390) (jump tmp-ra.98 rbp rax)))
    (define L.fun/ascii-char102235.14
      ((locals (tmp-ra.99))
       (conflicts
        ((tmp-ra.99 (rax rbp)) (rbp (rax tmp-ra.99)) (rax (rbp tmp-ra.99))))
       (assignment ()))
      (begin (set! tmp-ra.99 r15) (set! rax 25390) (jump tmp-ra.99 rbp rax)))
    (begin
      (set! tmp-ra.100 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char102234.9 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char0.6 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char102236.6 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char1.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/any102238.5 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rdi tmp.70)
            (set! r15 L.rp.23)
            (jump L.vector?.16 rbp r15 rdi)))
        (set! rbp (+ rbp 64)))
      (set! boolean2.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/ascii-char102239.8 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char3.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/void102241.7 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void4.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/void102243.4 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void5.1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 1032)
            (set! rdi 1848)
            (set! r15 L.rp.27)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 1088)
            (set! rdi 488)
            (set! r15 L.rp.28)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.74)
            (set! rdi tmp.73)
            (set! r15 L.rp.29)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi 264)
            (set! rdi 1440)
            (set! r15 L.rp.30)
            (jump L.-.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi 1248)
            (set! rdi 1976)
            (set! r15 L.rp.31)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.76)
            (set! r15 L.rp.32)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.72)
            (set! r15 L.rp.33)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi 1616)
            (set! rdi 1904)
            (set! r15 L.rp.34)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 312)
            (set! rdi 576)
            (set! r15 L.rp.35)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.81)
            (set! rdi tmp.80)
            (set! r15 L.rp.36)
            (jump L.-.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi 1400)
            (set! rdi 784)
            (set! r15 L.rp.37)
            (jump L.+.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi 1936)
            (set! rdi 592)
            (set! r15 L.rp.38)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.84)
            (set! rdi tmp.83)
            (set! r15 L.rp.39)
            (jump L.-.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.79)
            (set! r15 L.rp.40)
            (jump L.-.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (set! rsi tmp.78)
      (set! rdi tmp.71)
      (set! r15 tmp-ra.100)
      (jump L.*.18 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((locals
      (empty5.1
       fixnum4.2
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72
       void3.3
       empty2.4
       void1.5
       empty0.6))
     (conflicts
      ((tmp-ra.98
        (empty5.1
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
         empty2.4
         void1.5
         empty0.6
         rax
         rbp))
       (empty0.6 (rbp tmp-ra.98))
       (void1.5 (rbp tmp-ra.98))
       (empty2.4 (rbp tmp-ra.98))
       (void3.3 (rbp tmp-ra.98))
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
       (fixnum4.2 (rbp tmp-ra.98))
       (empty5.1 (rbp tmp-ra.98))
       (rbp
        (empty5.1
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
         empty2.4
         void1.5
         empty0.6
         r15
         rax
         tmp-ra.98))
       (rax (tmp.81 tmp.77 tmp.78 tmp.69 tmp.74 tmp.70 tmp.71 rbp tmp-ra.98))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.98 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.+.19
      ((locals
        (tmp.58
         tmp.100
         tmp.22
         tmp.59
         tmp.101
         tmp-ra.83
         tmp.57
         tmp.23
         tmp.99
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.83 tmp.23 tmp.22))
         (tmp.99 (tmp.23 rbp tmp-ra.83 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.83
           tmp.22
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58
           tmp.101))
         (tmp.57 (rbp tmp-ra.83 tmp.23 tmp.22))
         (tmp-ra.83
          (tmp.23
           tmp.22
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
         (tmp.101 (rbp tmp-ra.83 tmp.23))
         (tmp.59 (rbp tmp-ra.83 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.83
           rsi
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58))
         (tmp.100 (tmp.22 rbp tmp-ra.83 tmp.23))
         (tmp.58 (rbp tmp-ra.83 tmp.23 tmp.22))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.23
           tmp.22
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
         (rsi (tmp.22 tmp-ra.83))))
       (assignment ()))
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
      ((locals
        (tmp.62
         tmp.103
         tmp.24
         tmp.63
         tmp.104
         tmp-ra.84
         tmp.61
         tmp.25
         tmp.102
         tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.84 tmp.25 tmp.24))
         (tmp.102 (tmp.25 rbp tmp-ra.84 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.84
           tmp.24
           tmp.102
           tmp.61
           tmp.60
           tmp.103
           tmp.63
           tmp.62
           tmp.104))
         (tmp.61 (rbp tmp-ra.84 tmp.25 tmp.24))
         (tmp-ra.84
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.102
           tmp.61
           tmp.60
           tmp.103
           tmp.63
           tmp.62
           tmp.104
           rax))
         (tmp.104 (rbp tmp-ra.84 tmp.25))
         (tmp.63 (rbp tmp-ra.84 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.84
           rsi
           tmp.102
           tmp.61
           tmp.60
           tmp.103
           tmp.63
           tmp.62))
         (tmp.103 (tmp.24 rbp tmp-ra.84 tmp.25))
         (tmp.62 (rbp tmp-ra.84 tmp.25 tmp.24))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.84
           tmp.102
           tmp.61
           tmp.60
           tmp.103
           tmp.63
           tmp.62
           tmp.104
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.24 tmp-ra.84))))
       (assignment ()))
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
      ((locals
        (tmp.66
         tmp.106
         tmp.20
         tmp.67
         tmp.108
         tmp.68
         tmp.107
         tmp-ra.85
         tmp.65
         tmp.21
         tmp.105
         tmp.64))
       (conflicts
        ((tmp.64 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp.105 (tmp.21 rbp tmp-ra.85 tmp.20))
         (tmp.21
          (rbp tmp-ra.85 tmp.20 tmp.105 tmp.65 tmp.64 tmp.106 tmp.67 tmp.66))
         (tmp.65 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp-ra.85
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.105
           tmp.65
           tmp.64
           tmp.106
           tmp.67
           tmp.66
           tmp.108
           tmp.68
           tmp.107
           rax))
         (tmp.107 (rbp tmp-ra.85 tmp.20))
         (tmp.68 (tmp.108 rbp tmp-ra.85 tmp.20))
         (tmp.108 (rbp tmp-ra.85 tmp.68))
         (tmp.67 (rbp tmp-ra.85 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.85
           rsi
           tmp.105
           tmp.65
           tmp.64
           tmp.106
           tmp.67
           tmp.66
           tmp.68
           tmp.107))
         (tmp.106 (tmp.20 rbp tmp-ra.85 tmp.21))
         (tmp.66 (rbp tmp-ra.85 tmp.20 tmp.21))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.85
           tmp.105
           tmp.65
           tmp.64
           tmp.106
           tmp.67
           tmp.66
           tmp.108
           tmp.68
           tmp.107
           rax))
         (rdi (tmp-ra.85))
         (rsi (tmp.20 tmp-ra.85))))
       (assignment ()))
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
    (define L.fun/empty104399.4
      ((locals (tmp-ra.86))
       (conflicts ((tmp-ra.86 (rbp)) (rbp (r15 tmp-ra.86)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.86 r15)
        (set! r15 tmp-ra.86)
        (jump L.fun/empty104400.8 rbp r15)))
    (define L.fun/void104397.5
      ((locals (tmp-ra.87))
       (conflicts ((tmp-ra.87 (rbp)) (rbp (r15 tmp-ra.87)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! r15 tmp-ra.87)
        (jump L.fun/void104398.12 rbp r15)))
    (define L.fun/error104406.6
      ((locals (tmp-ra.88))
       (conflicts
        ((tmp-ra.88 (rax rbp)) (rbp (rax tmp-ra.88)) (rax (rbp tmp-ra.88))))
       (assignment ()))
      (begin (set! tmp-ra.88 r15) (set! rax 52798) (jump tmp-ra.88 rbp rax)))
    (define L.fun/empty104404.7
      ((locals (tmp-ra.89))
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89))))
       (assignment ()))
      (begin (set! tmp-ra.89 r15) (set! rax 22) (jump tmp-ra.89 rbp rax)))
    (define L.fun/empty104400.8
      ((locals (tmp-ra.90))
       (conflicts
        ((tmp-ra.90 (rax rbp)) (rbp (rax tmp-ra.90)) (rax (rbp tmp-ra.90))))
       (assignment ()))
      (begin (set! tmp-ra.90 r15) (set! rax 22) (jump tmp-ra.90 rbp rax)))
    (define L.fun/error104405.9
      ((locals (tmp-ra.91))
       (conflicts ((tmp-ra.91 (rbp)) (rbp (r15 tmp-ra.91)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/error104406.6 rbp r15)))
    (define L.fun/empty104395.10
      ((locals (tmp-ra.92))
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/empty104396.14 rbp r15)))
    (define L.fun/void104401.11
      ((locals (tmp-ra.93))
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/void104402.13 rbp r15)))
    (define L.fun/void104398.12
      ((locals (tmp-ra.94))
       (conflicts
        ((tmp-ra.94 (rax rbp)) (rbp (rax tmp-ra.94)) (rax (rbp tmp-ra.94))))
       (assignment ()))
      (begin (set! tmp-ra.94 r15) (set! rax 30) (jump tmp-ra.94 rbp rax)))
    (define L.fun/void104402.13
      ((locals (tmp-ra.95))
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95))))
       (assignment ()))
      (begin (set! tmp-ra.95 r15) (set! rax 30) (jump tmp-ra.95 rbp rax)))
    (define L.fun/empty104396.14
      ((locals (tmp-ra.96))
       (conflicts
        ((tmp-ra.96 (rax rbp)) (rbp (rax tmp-ra.96)) (rax (rbp tmp-ra.96))))
       (assignment ()))
      (begin (set! tmp-ra.96 r15) (set! rax 22) (jump tmp-ra.96 rbp rax)))
    (define L.fun/empty104403.15
      ((locals (tmp-ra.97))
       (conflicts ((tmp-ra.97 (rbp)) (rbp (r15 tmp-ra.97)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/empty104404.7 rbp r15)))
    (begin
      (set! tmp-ra.98 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty104395.10 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty0.6 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void104397.5 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void1.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty104399.4 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty2.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void104401.11 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 984)
            (set! rdi 1080)
            (set! r15 L.rp.24)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1576)
            (set! rdi 128)
            (set! r15 L.rp.25)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.26)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 576)
            (set! rdi 1344)
            (set! r15 L.rp.27)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 560)
            (set! rdi 832)
            (set! r15 L.rp.28)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.29)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.30)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi 568)
            (set! rdi 1424)
            (set! r15 L.rp.31)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 776)
            (set! rdi 1512)
            (set! r15 L.rp.32)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.33)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi 1344)
            (set! rdi 208)
            (set! r15 L.rp.34)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 1296)
            (set! rdi 608)
            (set! r15 L.rp.35)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.36)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.37)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.38)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin (set! r15 L.rp.39) (jump L.fun/empty104403.15 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty5.1 rax)
      (set! r15 tmp-ra.98)
      (jump L.fun/error104405.9 rbp r15))))
(check-by-interp
 '(module
    ((locals
      (void5.1 error4.2 boolean3.3 tmp.57 error2.4 error1.5 ascii-char0.6))
     (conflicts
      ((tmp-ra.70
        (void5.1
         error4.2
         boolean3.3
         tmp.57
         error2.4
         error1.5
         ascii-char0.6
         rax
         rbp))
       (ascii-char0.6 (rbp tmp-ra.70))
       (error1.5 (rbp tmp-ra.70))
       (error2.4 (rbp tmp-ra.70))
       (tmp.57 (rbp tmp-ra.70))
       (boolean3.3 (rbp tmp-ra.70))
       (error4.2 (rbp tmp-ra.70))
       (void5.1 (rbp tmp-ra.70))
       (rbp
        (void5.1
         error4.2
         boolean3.3
         rdi
         tmp.57
         error2.4
         error1.5
         ascii-char0.6
         r15
         rax
         tmp-ra.70))
       (rax (rbp tmp-ra.70))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment ((tmp-ra.70 fv0))))
    (define L.boolean?.16
      ((locals (tmp-ra.58 tmp.71 tmp.44 tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.58))
         (tmp.44 (rbp tmp-ra.58))
         (tmp.71 (rbp tmp-ra.58))
         (tmp-ra.58 (tmp.44 rbp rdi tmp.71 tmp.56 rax))
         (rax (rbp tmp-ra.58))
         (rbp (tmp.44 tmp-ra.58 tmp.71 tmp.56 rax))
         (rdi (tmp-ra.58))))
       (assignment ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.71 tmp.44)
                (set! tmp.71 (bitwise-and tmp.71 247))
                (set! tmp.56 tmp.71))
              (= tmp.56 6))
          (begin (set! rax 14) (jump tmp-ra.58 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.58 rbp rax)))))
    (define L.fun/any105578.4
      ((locals (tmp-ra.59))
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ()))
      (begin (set! tmp-ra.59 r15) (set! rax 1504) (jump tmp-ra.59 rbp rax)))
    (define L.fun/error105579.5
      ((locals (tmp-ra.60))
       (conflicts ((tmp-ra.60 (rbp)) (rbp (r15 tmp-ra.60)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.60 r15)
        (set! r15 tmp-ra.60)
        (jump L.fun/error105580.11 rbp r15)))
    (define L.fun/error105575.6
      ((locals (tmp-ra.61))
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ()))
      (begin (set! tmp-ra.61 r15) (set! rax 18494) (jump tmp-ra.61 rbp rax)))
    (define L.fun/ascii-char105573.7
      ((locals (tmp-ra.62))
       (conflicts
        ((tmp-ra.62 (rax rbp)) (rbp (rax tmp-ra.62)) (rax (rbp tmp-ra.62))))
       (assignment ()))
      (begin (set! tmp-ra.62 r15) (set! rax 25390) (jump tmp-ra.62 rbp rax)))
    (define L.fun/error105576.8
      ((locals (tmp-ra.63))
       (conflicts ((tmp-ra.63 (rbp)) (rbp (r15 tmp-ra.63)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/error105577.13 rbp r15)))
    (define L.fun/ascii-char105572.9
      ((locals (tmp-ra.64))
       (conflicts ((tmp-ra.64 (rbp)) (rbp (r15 tmp-ra.64)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.64 r15)
        (set! r15 tmp-ra.64)
        (jump L.fun/ascii-char105573.7 rbp r15)))
    (define L.fun/void105581.10
      ((locals (tmp-ra.65))
       (conflicts ((tmp-ra.65 (rbp)) (rbp (r15 tmp-ra.65)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/void105582.14 rbp r15)))
    (define L.fun/error105580.11
      ((locals (tmp-ra.66))
       (conflicts
        ((tmp-ra.66 (rax rbp)) (rbp (rax tmp-ra.66)) (rax (rbp tmp-ra.66))))
       (assignment ()))
      (begin (set! tmp-ra.66 r15) (set! rax 31038) (jump tmp-ra.66 rbp rax)))
    (define L.fun/error105574.12
      ((locals (tmp-ra.67))
       (conflicts ((tmp-ra.67 (rbp)) (rbp (r15 tmp-ra.67)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.67 r15)
        (set! r15 tmp-ra.67)
        (jump L.fun/error105575.6 rbp r15)))
    (define L.fun/error105577.13
      ((locals (tmp-ra.68))
       (conflicts
        ((tmp-ra.68 (rax rbp)) (rbp (rax tmp-ra.68)) (rax (rbp tmp-ra.68))))
       (assignment ()))
      (begin (set! tmp-ra.68 r15) (set! rax 55358) (jump tmp-ra.68 rbp rax)))
    (define L.fun/void105582.14
      ((locals (tmp-ra.69))
       (conflicts
        ((tmp-ra.69 (rax rbp)) (rbp (rax tmp-ra.69)) (rax (rbp tmp-ra.69))))
       (assignment ()))
      (begin (set! tmp-ra.69 r15) (set! rax 30) (jump tmp-ra.69 rbp rax)))
    (begin
      (set! tmp-ra.70 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char105572.9 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char0.6 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error105574.12 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error105576.8 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error2.4 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/any105578.4 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! tmp.57 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin
            (set! rdi tmp.57)
            (set! r15 L.rp.21)
            (jump L.boolean?.16 rbp r15 rdi)))
        (set! rbp (+ rbp 8)))
      (set! boolean3.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error105579.5 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error4.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void105581.10 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! void5.1 rax)
      (set! rax void5.1)
      (jump tmp-ra.70 rbp rax))))
(check-by-interp
 '(module
    ((locals (ascii-char5.1 void3.3 void2.4 ascii-char1.5 boolean0.6 tmp.57))
     (conflicts
      ((tmp-ra.70
        (ascii-char5.1
         ascii-char4.2
         void3.3
         void2.4
         ascii-char1.5
         boolean0.6
         tmp.57
         rax
         rbp))
       (tmp.57 (rbp tmp-ra.70))
       (boolean0.6 (rbp tmp-ra.70))
       (ascii-char1.5 (rbp tmp-ra.70))
       (void2.4 (rbp tmp-ra.70))
       (void3.3 (rbp tmp-ra.70))
       (ascii-char4.2 (ascii-char5.1 rax rbp tmp-ra.70))
       (ascii-char5.1 (rbp tmp-ra.70 ascii-char4.2))
       (rbp
        (ascii-char5.1
         ascii-char4.2
         void3.3
         void2.4
         ascii-char1.5
         boolean0.6
         rdi
         tmp.57
         r15
         rax
         tmp-ra.70))
       (rax (ascii-char4.2 rbp tmp-ra.70))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment ((tmp-ra.70 fv0) (ascii-char4.2 fv1))))
    (define L.ascii-char?.16
      ((locals (tmp-ra.58 tmp.71 tmp.47 tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.58))
         (tmp.47 (rbp tmp-ra.58))
         (tmp.71 (rbp tmp-ra.58))
         (tmp-ra.58 (tmp.47 rbp rdi tmp.71 tmp.56 rax))
         (rax (rbp tmp-ra.58))
         (rbp (tmp.47 tmp-ra.58 tmp.71 tmp.56 rax))
         (rdi (tmp-ra.58))))
       (assignment ()))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.47 rdi)
        (if (begin
              (begin
                (set! tmp.71 tmp.47)
                (set! tmp.71 (bitwise-and tmp.71 255))
                (set! tmp.56 tmp.71))
              (= tmp.56 46))
          (begin (set! rax 14) (jump tmp-ra.58 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.58 rbp rax)))))
    (define L.fun/void121813.4
      ((locals (tmp-ra.59))
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ()))
      (begin (set! tmp-ra.59 r15) (set! rax 30) (jump tmp-ra.59 rbp rax)))
    (define L.fun/ascii-char121818.5
      ((locals (tmp-ra.60))
       (conflicts ((tmp-ra.60 (rbp)) (rbp (r15 tmp-ra.60)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.60 r15)
        (set! r15 tmp-ra.60)
        (jump L.fun/ascii-char121819.11 rbp r15)))
    (define L.fun/void121814.6
      ((locals (tmp-ra.61))
       (conflicts ((tmp-ra.61 (rbp)) (rbp (r15 tmp-ra.61)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.61 r15)
        (set! r15 tmp-ra.61)
        (jump L.fun/void121815.12 rbp r15)))
    (define L.fun/ascii-char121816.7
      ((locals (tmp-ra.62))
       (conflicts ((tmp-ra.62 (rbp)) (rbp (r15 tmp-ra.62)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.62 r15)
        (set! r15 tmp-ra.62)
        (jump L.fun/ascii-char121817.9 rbp r15)))
    (define L.fun/void121812.8
      ((locals (tmp-ra.63))
       (conflicts ((tmp-ra.63 (rbp)) (rbp (r15 tmp-ra.63)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/void121813.4 rbp r15)))
    (define L.fun/ascii-char121817.9
      ((locals (tmp-ra.64))
       (conflicts
        ((tmp-ra.64 (rax rbp)) (rbp (rax tmp-ra.64)) (rax (rbp tmp-ra.64))))
       (assignment ()))
      (begin (set! tmp-ra.64 r15) (set! rax 25390) (jump tmp-ra.64 rbp rax)))
    (define L.fun/ascii-char121811.10
      ((locals (tmp-ra.65))
       (conflicts
        ((tmp-ra.65 (rax rbp)) (rbp (rax tmp-ra.65)) (rax (rbp tmp-ra.65))))
       (assignment ()))
      (begin (set! tmp-ra.65 r15) (set! rax 25390) (jump tmp-ra.65 rbp rax)))
    (define L.fun/ascii-char121819.11
      ((locals (tmp-ra.66))
       (conflicts
        ((tmp-ra.66 (rax rbp)) (rbp (rax tmp-ra.66)) (rax (rbp tmp-ra.66))))
       (assignment ()))
      (begin (set! tmp-ra.66 r15) (set! rax 25390) (jump tmp-ra.66 rbp rax)))
    (define L.fun/void121815.12
      ((locals (tmp-ra.67))
       (conflicts
        ((tmp-ra.67 (rax rbp)) (rbp (rax tmp-ra.67)) (rax (rbp tmp-ra.67))))
       (assignment ()))
      (begin (set! tmp-ra.67 r15) (set! rax 30) (jump tmp-ra.67 rbp rax)))
    (define L.fun/ascii-char121810.13
      ((locals (tmp-ra.68))
       (conflicts ((tmp-ra.68 (rbp)) (rbp (r15 tmp-ra.68)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.68 r15)
        (set! r15 tmp-ra.68)
        (jump L.fun/ascii-char121811.10 rbp r15)))
    (define L.fun/any121809.14
      ((locals (tmp-ra.69))
       (conflicts
        ((tmp-ra.69 (rax rbp)) (rbp (rax tmp-ra.69)) (rax (rbp tmp-ra.69))))
       (assignment ()))
      (begin (set! tmp-ra.69 r15) (set! rax 6) (jump tmp-ra.69 rbp rax)))
    (begin
      (set! tmp-ra.70 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/any121809.14 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! tmp.57 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin
            (set! rdi tmp.57)
            (set! r15 L.rp.18)
            (jump L.ascii-char?.16 rbp r15 rdi)))
        (set! rbp (+ rbp 16)))
      (set! boolean0.6 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char121810.13 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char1.5 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void121812.8 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void2.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void121814.6 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char121816.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char4.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char121818.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char5.1 rax)
      (set! rax ascii-char4.2)
      (jump tmp-ra.70 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (empty5.1
       fixnum4.2
       tmp.90
       tmp.94
       tmp.96
       tmp.93
       tmp.87
       tmp.89
       tmp.86
       error3.3
       void2.4
       empty1.5
       fixnum0.6
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72))
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
         void2.4
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
       (void2.4 (rbp tmp-ra.108))
       (error3.3 (rbp tmp-ra.108))
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
       (fixnum4.2 (rbp tmp-ra.108))
       (empty5.1 (rbp tmp-ra.108))
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
         void2.4
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
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.108 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.88 fv1)
       (tmp.92 fv1)
       (tmp.91 fv1)
       (tmp.95 fv2)
       (tmp.83 fv3)
       (tmp.84 fv2)
       (tmp.85 fv1)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.+.15
      ((locals
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
         (rsi (tmp.22 tmp-ra.97))))
       (assignment ()))
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
    (define L.*.14
      ((locals
        (tmp.62
         tmp.113
         tmp.20
         tmp.63
         tmp.115
         tmp.64
         tmp.114
         tmp-ra.98
         tmp.61
         tmp.21
         tmp.112
         tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.98 tmp.20 tmp.21))
         (tmp.112 (tmp.21 rbp tmp-ra.98 tmp.20))
         (tmp.21
          (rbp tmp-ra.98 tmp.20 tmp.112 tmp.61 tmp.60 tmp.113 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.98 tmp.20 tmp.21))
         (tmp-ra.98
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.115
           tmp.64
           tmp.114
           rax))
         (tmp.114 (rbp tmp-ra.98 tmp.20))
         (tmp.64 (tmp.115 rbp tmp-ra.98 tmp.20))
         (tmp.115 (rbp tmp-ra.98 tmp.64))
         (tmp.63 (rbp tmp-ra.98 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.98
           rsi
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.64
           tmp.114))
         (tmp.113 (tmp.20 rbp tmp-ra.98 tmp.21))
         (tmp.62 (rbp tmp-ra.98 tmp.20 tmp.21))
         (rax (rbp tmp-ra.98))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.98
           tmp.112
           tmp.61
           tmp.60
           tmp.113
           tmp.63
           tmp.62
           tmp.115
           tmp.64
           tmp.114
           rax))
         (rdi (tmp-ra.98))
         (rsi (tmp.20 tmp-ra.98))))
       (assignment ()))
      (begin
        (set! tmp-ra.98 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.112 tmp.21)
                      (set! tmp.112 (bitwise-and tmp.112 7))
                      (set! tmp.61 tmp.112))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.113 tmp.20)
                        (set! tmp.113 (bitwise-and tmp.113 7))
                        (set! tmp.63 tmp.113))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.114 tmp.21)
              (set! tmp.114 (arithmetic-shift-right tmp.114 3))
              (set! tmp.64 tmp.114)
              (set! tmp.115 tmp.20)
              (set! tmp.115 (* tmp.115 tmp.64))
              (set! rax tmp.115)
              (jump tmp-ra.98 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.98 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.98 rbp rax)))))
    (define L.-.13
      ((locals
        (tmp.67
         tmp.117
         tmp.24
         tmp.68
         tmp.118
         tmp-ra.99
         tmp.66
         tmp.25
         tmp.116
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.99 tmp.25 tmp.24))
         (tmp.116 (tmp.25 rbp tmp-ra.99 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.99
           tmp.24
           tmp.116
           tmp.66
           tmp.65
           tmp.117
           tmp.68
           tmp.67
           tmp.118))
         (tmp.66 (rbp tmp-ra.99 tmp.25 tmp.24))
         (tmp-ra.99
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.116
           tmp.66
           tmp.65
           tmp.117
           tmp.68
           tmp.67
           tmp.118
           rax))
         (tmp.118 (rbp tmp-ra.99 tmp.25))
         (tmp.68 (rbp tmp-ra.99 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.99
           rsi
           tmp.116
           tmp.66
           tmp.65
           tmp.117
           tmp.68
           tmp.67))
         (tmp.117 (tmp.24 rbp tmp-ra.99 tmp.25))
         (tmp.67 (rbp tmp-ra.99 tmp.25 tmp.24))
         (rax (rbp tmp-ra.99))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.99
           tmp.116
           tmp.66
           tmp.65
           tmp.117
           tmp.68
           tmp.67
           tmp.118
           rax))
         (rdi (tmp-ra.99))
         (rsi (tmp.24 tmp-ra.99))))
       (assignment ()))
      (begin
        (set! tmp-ra.99 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.116 tmp.25)
                      (set! tmp.116 (bitwise-and tmp.116 7))
                      (set! tmp.66 tmp.116))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.117 tmp.24)
                        (set! tmp.117 (bitwise-and tmp.117 7))
                        (set! tmp.68 tmp.117))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.118 tmp.24)
              (set! tmp.118 (- tmp.118 tmp.25))
              (set! rax tmp.118)
              (jump tmp-ra.99 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.99 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.99 rbp rax)))))
    (define L.fun/error128005.4
      ((locals (tmp-ra.100))
       (conflicts ((tmp-ra.100 (rbp)) (rbp (r15 tmp-ra.100)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.100 r15)
        (set! r15 tmp-ra.100)
        (jump L.fun/error128006.9 rbp r15)))
    (define L.fun/empty128002.5
      ((locals (tmp-ra.101))
       (conflicts
        ((tmp-ra.101 (rax rbp)) (rbp (rax tmp-ra.101)) (rax (rbp tmp-ra.101))))
       (assignment ()))
      (begin (set! tmp-ra.101 r15) (set! rax 22) (jump tmp-ra.101 rbp rax)))
    (define L.fun/void128004.6
      ((locals (tmp-ra.102))
       (conflicts
        ((tmp-ra.102 (rax rbp)) (rbp (rax tmp-ra.102)) (rax (rbp tmp-ra.102))))
       (assignment ()))
      (begin (set! tmp-ra.102 r15) (set! rax 30) (jump tmp-ra.102 rbp rax)))
    (define L.fun/empty128001.7
      ((locals (tmp-ra.103))
       (conflicts ((tmp-ra.103 (rbp)) (rbp (r15 tmp-ra.103)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.103 r15)
        (set! r15 tmp-ra.103)
        (jump L.fun/empty128002.5 rbp r15)))
    (define L.fun/empty128008.8
      ((locals (tmp-ra.104))
       (conflicts
        ((tmp-ra.104 (rax rbp)) (rbp (rax tmp-ra.104)) (rax (rbp tmp-ra.104))))
       (assignment ()))
      (begin (set! tmp-ra.104 r15) (set! rax 22) (jump tmp-ra.104 rbp rax)))
    (define L.fun/error128006.9
      ((locals (tmp-ra.105))
       (conflicts
        ((tmp-ra.105 (rax rbp)) (rbp (rax tmp-ra.105)) (rax (rbp tmp-ra.105))))
       (assignment ()))
      (begin (set! tmp-ra.105 r15) (set! rax 9278) (jump tmp-ra.105 rbp rax)))
    (define L.fun/empty128007.10
      ((locals (tmp-ra.106))
       (conflicts ((tmp-ra.106 (rbp)) (rbp (r15 tmp-ra.106)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.106 r15)
        (set! r15 tmp-ra.106)
        (jump L.fun/empty128008.8 rbp r15)))
    (define L.fun/void128003.11
      ((locals (tmp-ra.107))
       (conflicts ((tmp-ra.107 (rbp)) (rbp (r15 tmp-ra.107)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.107 r15)
        (set! r15 tmp-ra.107)
        (jump L.fun/void128004.6 rbp r15)))
    (begin
      (set! tmp-ra.108 r15)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.16
          (begin
            (set! rsi 1144)
            (set! rdi 1312)
            (set! r15 L.rp.16)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.17
          (begin
            (set! rsi 2016)
            (set! rdi 1080)
            (set! r15 L.rp.17)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.18)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.19
          (begin
            (set! rsi 1384)
            (set! rdi 40)
            (set! r15 L.rp.19)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.20
          (begin
            (set! rsi 1832)
            (set! rdi 1872)
            (set! r15 L.rp.20)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.21
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.21)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.22)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.23
          (begin
            (set! rsi 264)
            (set! rdi 1008)
            (set! r15 L.rp.23)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.24
          (begin
            (set! rsi 952)
            (set! rdi 1376)
            (set! r15 L.rp.24)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.25
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.25)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.26
          (begin
            (set! rsi 464)
            (set! rdi 1376)
            (set! r15 L.rp.26)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.27
          (begin
            (set! rsi 656)
            (set! rdi 776)
            (set! r15 L.rp.27)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.28
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.28)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.29)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.30)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! fixnum0.6 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.31
          (begin (set! r15 L.rp.31) (jump L.fun/empty128001.7 rbp r15)))
        (set! rbp (+ rbp 120)))
      (set! empty1.5 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/void128003.11 rbp r15)))
        (set! rbp (+ rbp 120)))
      (set! void2.4 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/error128005.4 rbp r15)))
        (set! rbp (+ rbp 120)))
      (set! error3.3 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.34
          (begin
            (set! rsi 928)
            (set! rdi 816)
            (set! r15 L.rp.34)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.35
          (begin
            (set! rsi 824)
            (set! rdi 1728)
            (set! r15 L.rp.35)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.86)
            (set! rdi tmp.85)
            (set! r15 L.rp.36)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.37
          (begin
            (set! rsi 1736)
            (set! rdi 1480)
            (set! r15 L.rp.37)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.38
          (begin
            (set! rsi 776)
            (set! rdi 1816)
            (set! r15 L.rp.38)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.89)
            (set! rdi tmp.88)
            (set! r15 L.rp.39)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.40
          (begin
            (set! rsi tmp.87)
            (set! rdi tmp.84)
            (set! r15 L.rp.40)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.41
          (begin
            (set! rsi 1104)
            (set! rdi 1272)
            (set! r15 L.rp.41)
            (jump L.+.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.42
          (begin
            (set! rsi 1264)
            (set! rdi 1912)
            (set! r15 L.rp.42)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.43
          (begin
            (set! rsi tmp.93)
            (set! rdi tmp.92)
            (set! r15 L.rp.43)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.44
          (begin
            (set! rsi 848)
            (set! rdi 1968)
            (set! r15 L.rp.44)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.45
          (begin
            (set! rsi 8)
            (set! rdi 1560)
            (set! r15 L.rp.45)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.46
          (begin
            (set! rsi tmp.96)
            (set! rdi tmp.95)
            (set! r15 L.rp.46)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.47
          (begin
            (set! rsi tmp.94)
            (set! rdi tmp.91)
            (set! r15 L.rp.47)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.48
          (begin
            (set! rsi tmp.90)
            (set! rdi tmp.83)
            (set! r15 L.rp.48)
            (jump L.-.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 120)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/empty128007.10 rbp r15)))
        (set! rbp (+ rbp 120)))
      (set! empty5.1 rax)
      (set! rax empty5.1)
      (jump tmp-ra.108 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (ascii-char5.1
       fixnum4.2
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72
       empty3.3
       empty2.4
       ascii-char1.5
       empty0.6))
     (conflicts
      ((tmp-ra.98
        (ascii-char5.1
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
         empty3.3
         empty2.4
         ascii-char1.5
         empty0.6
         rax
         rbp))
       (empty0.6 (rbp tmp-ra.98))
       (ascii-char1.5 (rbp tmp-ra.98))
       (empty2.4 (rbp tmp-ra.98))
       (empty3.3 (rbp tmp-ra.98))
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
       (fixnum4.2 (rbp tmp-ra.98))
       (ascii-char5.1 (rbp tmp-ra.98))
       (rbp
        (ascii-char5.1
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
         empty3.3
         empty2.4
         ascii-char1.5
         empty0.6
         r15
         rax
         tmp-ra.98))
       (rax (tmp.81 tmp.77 tmp.78 tmp.69 tmp.74 tmp.70 tmp.71 rbp tmp-ra.98))
       (r15 (rdi rsi rbp))
       (rsi (tmp.69 tmp.77 tmp.81 tmp.78 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.98 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.+.19
      ((locals
        (tmp.58
         tmp.100
         tmp.22
         tmp.59
         tmp.101
         tmp-ra.83
         tmp.57
         tmp.23
         tmp.99
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.83 tmp.23 tmp.22))
         (tmp.99 (tmp.23 rbp tmp-ra.83 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.83
           tmp.22
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58
           tmp.101))
         (tmp.57 (rbp tmp-ra.83 tmp.23 tmp.22))
         (tmp-ra.83
          (tmp.23
           tmp.22
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
         (tmp.101 (rbp tmp-ra.83 tmp.23))
         (tmp.59 (rbp tmp-ra.83 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.83
           rsi
           tmp.99
           tmp.57
           tmp.56
           tmp.100
           tmp.59
           tmp.58))
         (tmp.100 (tmp.22 rbp tmp-ra.83 tmp.23))
         (tmp.58 (rbp tmp-ra.83 tmp.23 tmp.22))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.23
           tmp.22
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
         (rsi (tmp.22 tmp-ra.83))))
       (assignment ()))
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
    (define L.*.18
      ((locals
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
         (rsi (tmp.20 tmp-ra.84))))
       (assignment ()))
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
    (define L.-.17
      ((locals
        (tmp.67
         tmp.107
         tmp.24
         tmp.68
         tmp.108
         tmp-ra.85
         tmp.66
         tmp.25
         tmp.106
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.106 (tmp.25 rbp tmp-ra.85 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.85
           tmp.24
           tmp.106
           tmp.66
           tmp.65
           tmp.107
           tmp.68
           tmp.67
           tmp.108))
         (tmp.66 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp-ra.85
          (tmp.25
           tmp.24
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
         (tmp.108 (rbp tmp-ra.85 tmp.25))
         (tmp.68 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.85
           rsi
           tmp.106
           tmp.66
           tmp.65
           tmp.107
           tmp.68
           tmp.67))
         (tmp.107 (tmp.24 rbp tmp-ra.85 tmp.25))
         (tmp.67 (rbp tmp-ra.85 tmp.25 tmp.24))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.25
           tmp.24
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
         (rsi (tmp.24 tmp-ra.85))))
       (assignment ()))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.106 tmp.25)
                      (set! tmp.106 (bitwise-and tmp.106 7))
                      (set! tmp.66 tmp.106))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.107 tmp.24)
                        (set! tmp.107 (bitwise-and tmp.107 7))
                        (set! tmp.68 tmp.107))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.108 tmp.24)
              (set! tmp.108 (- tmp.108 tmp.25))
              (set! rax tmp.108)
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))))
    (define L.fun/ascii-char138303.4
      ((locals (tmp-ra.86))
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86))))
       (assignment ()))
      (begin (set! tmp-ra.86 r15) (set! rax 25390) (jump tmp-ra.86 rbp rax)))
    (define L.fun/empty138301.5
      ((locals (tmp-ra.87))
       (conflicts
        ((tmp-ra.87 (rax rbp)) (rbp (rax tmp-ra.87)) (rax (rbp tmp-ra.87))))
       (assignment ()))
      (begin (set! tmp-ra.87 r15) (set! rax 22) (jump tmp-ra.87 rbp rax)))
    (define L.fun/empty138304.6
      ((locals (tmp-ra.88))
       (conflicts ((tmp-ra.88 (rbp)) (rbp (r15 tmp-ra.88)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.88 r15)
        (set! r15 tmp-ra.88)
        (jump L.fun/empty138305.13 rbp r15)))
    (define L.fun/empty138307.7
      ((locals (tmp-ra.89))
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89))))
       (assignment ()))
      (begin (set! tmp-ra.89 r15) (set! rax 22) (jump tmp-ra.89 rbp rax)))
    (define L.fun/empty138306.8
      ((locals (tmp-ra.90))
       (conflicts ((tmp-ra.90 (rbp)) (rbp (r15 tmp-ra.90)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.90 r15)
        (set! r15 tmp-ra.90)
        (jump L.fun/empty138307.7 rbp r15)))
    (define L.fun/ascii-char138302.9
      ((locals (tmp-ra.91))
       (conflicts ((tmp-ra.91 (rbp)) (rbp (r15 tmp-ra.91)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! r15 tmp-ra.91)
        (jump L.fun/ascii-char138303.4 rbp r15)))
    (define L.fun/ascii-char138308.10
      ((locals (tmp-ra.92))
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/ascii-char138309.12 rbp r15)))
    (define L.fun/error138310.11
      ((locals (tmp-ra.93))
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/error138311.15 rbp r15)))
    (define L.fun/ascii-char138309.12
      ((locals (tmp-ra.94))
       (conflicts
        ((tmp-ra.94 (rax rbp)) (rbp (rax tmp-ra.94)) (rax (rbp tmp-ra.94))))
       (assignment ()))
      (begin (set! tmp-ra.94 r15) (set! rax 25390) (jump tmp-ra.94 rbp rax)))
    (define L.fun/empty138305.13
      ((locals (tmp-ra.95))
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95))))
       (assignment ()))
      (begin (set! tmp-ra.95 r15) (set! rax 22) (jump tmp-ra.95 rbp rax)))
    (define L.fun/empty138300.14
      ((locals (tmp-ra.96))
       (conflicts ((tmp-ra.96 (rbp)) (rbp (r15 tmp-ra.96)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.96 r15)
        (set! r15 tmp-ra.96)
        (jump L.fun/empty138301.5 rbp r15)))
    (define L.fun/error138311.15
      ((locals (tmp-ra.97))
       (conflicts
        ((tmp-ra.97 (rax rbp)) (rbp (rax tmp-ra.97)) (rax (rbp tmp-ra.97))))
       (assignment ()))
      (begin (set! tmp-ra.97 r15) (set! rax 28990) (jump tmp-ra.97 rbp rax)))
    (begin
      (set! tmp-ra.98 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty138300.14 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty0.6 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char138302.9 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char1.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty138304.6 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty2.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty138306.8 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty3.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 1600)
            (set! rdi 2024)
            (set! r15 L.rp.24)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 376)
            (set! rdi 1728)
            (set! r15 L.rp.25)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.26)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 272)
            (set! rdi 1504)
            (set! r15 L.rp.27)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 72)
            (set! rdi 360)
            (set! r15 L.rp.28)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.29)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.30)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi 1448)
            (set! rdi 1984)
            (set! r15 L.rp.31)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 24)
            (set! rdi 1992)
            (set! r15 L.rp.32)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.33)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi 1576)
            (set! rdi 856)
            (set! r15 L.rp.34)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 256)
            (set! rdi 1424)
            (set! r15 L.rp.35)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.36)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.37)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.38)
            (jump L.*.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin (set! r15 L.rp.39) (jump L.fun/ascii-char138308.10 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char5.1 rax)
      (set! r15 tmp-ra.98)
      (jump L.fun/error138310.11 rbp r15))))
(check-by-interp
 '(module
    ((locals
      (boolean5.1
       tmp.86
       fixnum4.2
       tmp.79
       tmp.83
       tmp.85
       tmp.82
       tmp.76
       tmp.78
       tmp.75
       empty3.3
       boolean2.4
       tmp.71
       error1.5
       ascii-char0.6))
     (conflicts
      ((tmp-ra.102
        (boolean5.1
         tmp.86
         fixnum4.2
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
         empty3.3
         boolean2.4
         tmp.71
         error1.5
         ascii-char0.6
         rax
         rbp))
       (ascii-char0.6 (rbp tmp-ra.102))
       (error1.5 (rbp tmp-ra.102))
       (tmp.71 (rbp tmp-ra.102))
       (boolean2.4 (rbp tmp-ra.102))
       (empty3.3 (rbp tmp-ra.102))
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
       (fixnum4.2 (rbp tmp-ra.102))
       (tmp.86 (rbp tmp-ra.102))
       (boolean5.1 (rbp tmp-ra.102))
       (rbp
        (boolean5.1
         tmp.86
         fixnum4.2
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
         empty3.3
         boolean2.4
         rdi
         tmp.71
         error1.5
         ascii-char0.6
         r15
         rax
         tmp-ra.102))
       (rax (tmp.84 tmp.80 tmp.81 tmp.72 tmp.77 tmp.73 tmp.74 rbp tmp-ra.102))
       (r15 (rsi rdi rbp))
       (rdi (rsi r15 rbp))
       (rsi (tmp.72 tmp.80 tmp.84 tmp.81 tmp.73 tmp.77 tmp.74 r15 rdi rbp))))
     (assignment
      ((tmp-ra.102 fv0)
       (tmp.74 fv1)
       (tmp.73 fv1)
       (tmp.72 fv1)
       (tmp.84 fv2)
       (tmp.80 fv3)
       (tmp.81 fv2)
       (tmp.77 fv2))))
    (define L.boolean?.19
      ((locals (tmp-ra.87 tmp.103 tmp.44 tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.87))
         (tmp.44 (rbp tmp-ra.87))
         (tmp.103 (rbp tmp-ra.87))
         (tmp-ra.87 (tmp.44 rbp rdi tmp.103 tmp.56 rax))
         (rax (rbp tmp-ra.87))
         (rbp (tmp.44 tmp-ra.87 tmp.103 tmp.56 rax))
         (rdi (tmp-ra.87))))
       (assignment ()))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.103 tmp.44)
                (set! tmp.103 (bitwise-and tmp.103 247))
                (set! tmp.56 tmp.103))
              (= tmp.56 6))
          (begin (set! rax 14) (jump tmp-ra.87 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.87 rbp rax)))))
    (define L.+.18
      ((locals
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
         (rsi (tmp.22 tmp-ra.88))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.24 tmp-ra.89))))
       (assignment ()))
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
      ((locals
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
         (rsi (tmp.20 tmp-ra.90))))
       (assignment ()))
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
    (define L.fixnum?.15
      ((locals (tmp-ra.91 tmp.114 tmp.43 tmp.70))
       (conflicts
        ((tmp.70 (rbp tmp-ra.91))
         (tmp.43 (rbp tmp-ra.91))
         (tmp.114 (rbp tmp-ra.91))
         (tmp-ra.91 (tmp.43 rbp rdi tmp.114 tmp.70 rax))
         (rax (rbp tmp-ra.91))
         (rbp (tmp.43 tmp-ra.91 tmp.114 tmp.70 rax))
         (rdi (tmp-ra.91))))
       (assignment ()))
      (begin
        (set! tmp-ra.91 r15)
        (set! tmp.43 rdi)
        (if (begin
              (begin
                (set! tmp.114 tmp.43)
                (set! tmp.114 (bitwise-and tmp.114 7))
                (set! tmp.70 tmp.114))
              (= tmp.70 0))
          (begin (set! rax 14) (jump tmp-ra.91 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.91 rbp rax)))))
    (define L.fun/error139284.4
      ((locals (tmp-ra.92))
       (conflicts
        ((tmp-ra.92 (rax rbp)) (rbp (rax tmp-ra.92)) (rax (rbp tmp-ra.92))))
       (assignment ()))
      (begin (set! tmp-ra.92 r15) (set! rax 15934) (jump tmp-ra.92 rbp rax)))
    (define L.fun/ascii-char139281.5
      ((locals (tmp-ra.93))
       (conflicts ((tmp-ra.93 (rbp)) (rbp (r15 tmp-ra.93)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.93 r15)
        (set! r15 tmp-ra.93)
        (jump L.fun/ascii-char139282.10 rbp r15)))
    (define L.fun/error139283.6
      ((locals (tmp-ra.94))
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/error139284.4 rbp r15)))
    (define L.fun/void139290.7
      ((locals (tmp-ra.95))
       (conflicts
        ((tmp-ra.95 (rax rbp)) (rbp (rax tmp-ra.95)) (rax (rbp tmp-ra.95))))
       (assignment ()))
      (begin (set! tmp-ra.95 r15) (set! rax 30) (jump tmp-ra.95 rbp rax)))
    (define L.fun/any139288.8
      ((locals (tmp-ra.96))
       (conflicts
        ((tmp-ra.96 (rax rbp)) (rbp (rax tmp-ra.96)) (rax (rbp tmp-ra.96))))
       (assignment ()))
      (begin (set! tmp-ra.96 r15) (set! rax 13886) (jump tmp-ra.96 rbp rax)))
    (define L.fun/empty139287.9
      ((locals (tmp-ra.97))
       (conflicts
        ((tmp-ra.97 (rax rbp)) (rbp (rax tmp-ra.97)) (rax (rbp tmp-ra.97))))
       (assignment ()))
      (begin (set! tmp-ra.97 r15) (set! rax 22) (jump tmp-ra.97 rbp rax)))
    (define L.fun/ascii-char139282.10
      ((locals (tmp-ra.98))
       (conflicts
        ((tmp-ra.98 (rax rbp)) (rbp (rax tmp-ra.98)) (rax (rbp tmp-ra.98))))
       (assignment ()))
      (begin (set! tmp-ra.98 r15) (set! rax 25390) (jump tmp-ra.98 rbp rax)))
    (define L.fun/any139285.11
      ((locals (tmp-ra.99))
       (conflicts
        ((tmp-ra.99 (rax rbp)) (rbp (rax tmp-ra.99)) (rax (rbp tmp-ra.99))))
       (assignment ()))
      (begin (set! tmp-ra.99 r15) (set! rax 22) (jump tmp-ra.99 rbp rax)))
    (define L.fun/void139289.12
      ((locals (tmp-ra.100))
       (conflicts ((tmp-ra.100 (rbp)) (rbp (r15 tmp-ra.100)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.100 r15)
        (set! r15 tmp-ra.100)
        (jump L.fun/void139290.7 rbp r15)))
    (define L.fun/empty139286.13
      ((locals (tmp-ra.101))
       (conflicts ((tmp-ra.101 (rbp)) (rbp (r15 tmp-ra.101)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.101 r15)
        (set! r15 tmp-ra.101)
        (jump L.fun/empty139287.9 rbp r15)))
    (begin
      (set! tmp-ra.102 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char139281.5 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! ascii-char0.6 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error139283.6 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/any139285.11 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rdi tmp.71)
            (set! r15 L.rp.23)
            (jump L.fixnum?.15 rbp r15 rdi)))
        (set! rbp (+ rbp 64)))
      (set! boolean2.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/empty139286.13 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty3.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1832)
            (set! rdi 1960)
            (set! r15 L.rp.25)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 768)
            (set! rdi 1680)
            (set! r15 L.rp.26)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.27)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 1520)
            (set! rdi 856)
            (set! r15 L.rp.28)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 1096)
            (set! rdi 1264)
            (set! r15 L.rp.29)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.78)
            (set! rdi tmp.77)
            (set! r15 L.rp.30)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.73)
            (set! r15 L.rp.31)
            (jump L.+.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 96)
            (set! rdi 160)
            (set! r15 L.rp.32)
            (jump L.+.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 240)
            (set! rdi 696)
            (set! r15 L.rp.33)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.34)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 1704)
            (set! rdi 880)
            (set! r15 L.rp.35)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi 1640)
            (set! rdi 1696)
            (set! r15 L.rp.36)
            (jump L.*.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi tmp.85)
            (set! rdi tmp.84)
            (set! r15 L.rp.37)
            (jump L.-.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.83)
            (set! rdi tmp.80)
            (set! r15 L.rp.38)
            (jump L.+.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.72)
            (set! r15 L.rp.39)
            (jump L.+.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin (set! r15 L.rp.40) (jump L.fun/any139288.8 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.41
          (begin
            (set! rdi tmp.86)
            (set! r15 L.rp.41)
            (jump L.boolean?.19 rbp r15 rdi)))
        (set! rbp (+ rbp 64)))
      (set! boolean5.1 rax)
      (set! r15 tmp-ra.102)
      (jump L.fun/void139289.12 rbp r15))))
(check-by-interp
 '(module
    ((locals
      (empty5.1
       fixnum4.2
       tmp.118
       tmp.122
       tmp.124
       tmp.121
       tmp.115
       tmp.117
       tmp.114
       fixnum2.4
       tmp.104
       tmp.108
       tmp.110
       tmp.107
       tmp.101
       tmp.103
       tmp.100
       fixnum1.5
       tmp.90
       tmp.94
       tmp.96
       tmp.93
       tmp.87
       tmp.89
       tmp.86
       fixnum0.6
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72))
     (conflicts
      ((tmp-ra.132
        (empty5.1
         fixnum4.2
         tmp.118
         tmp.122
         tmp.124
         tmp.123
         tmp.119
         tmp.121
         tmp.120
         tmp.111
         tmp.115
         tmp.117
         tmp.116
         tmp.112
         tmp.114
         tmp.113
         void3.3
         fixnum2.4
         tmp.104
         tmp.108
         tmp.110
         tmp.109
         tmp.105
         tmp.107
         tmp.106
         tmp.97
         tmp.101
         tmp.103
         tmp.102
         tmp.98
         tmp.100
         tmp.99
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
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.132))
       (tmp.72 (rbp tmp-ra.132 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.132))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.132 tmp.70))
       (tmp.75 (rbp tmp-ra.132 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.132 tmp.70))
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
         tmp-ra.132))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.132 tmp.69))
       (tmp.79 (rbp tmp-ra.132 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.132 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.132 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.132 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.132 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.132 tmp.69))
       (fixnum0.6 (rbp tmp-ra.132))
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.132))
       (tmp.86 (rbp tmp-ra.132 tmp.85))
       (tmp.84 (rsi tmp.87 tmp.89 tmp.88 rax rbp tmp-ra.132))
       (tmp.88 (rsi tmp.89 rax rbp tmp-ra.132 tmp.84))
       (tmp.89 (rbp tmp-ra.132 tmp.84 tmp.88))
       (tmp.87 (rbp tmp-ra.132 tmp.84))
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
         tmp-ra.132))
       (tmp.92 (rsi tmp.93 rax rbp tmp-ra.132 tmp.83))
       (tmp.93 (rbp tmp-ra.132 tmp.83 tmp.92))
       (tmp.91 (rsi tmp.94 tmp.96 tmp.95 rax rbp tmp-ra.132 tmp.83))
       (tmp.95 (rsi tmp.96 rax rbp tmp-ra.132 tmp.83 tmp.91))
       (tmp.96 (rbp tmp-ra.132 tmp.83 tmp.91 tmp.95))
       (tmp.94 (rbp tmp-ra.132 tmp.83 tmp.91))
       (tmp.90 (rbp tmp-ra.132 tmp.83))
       (fixnum1.5 (rbp tmp-ra.132))
       (tmp.99 (rsi tmp.100 rax rbp tmp-ra.132))
       (tmp.100 (rbp tmp-ra.132 tmp.99))
       (tmp.98 (rsi tmp.101 tmp.103 tmp.102 rax rbp tmp-ra.132))
       (tmp.102 (rsi tmp.103 rax rbp tmp-ra.132 tmp.98))
       (tmp.103 (rbp tmp-ra.132 tmp.98 tmp.102))
       (tmp.101 (rbp tmp-ra.132 tmp.98))
       (tmp.97
        (rsi
         tmp.104
         tmp.108
         tmp.110
         tmp.109
         tmp.105
         tmp.107
         tmp.106
         rax
         rbp
         tmp-ra.132))
       (tmp.106 (rsi tmp.107 rax rbp tmp-ra.132 tmp.97))
       (tmp.107 (rbp tmp-ra.132 tmp.97 tmp.106))
       (tmp.105 (rsi tmp.108 tmp.110 tmp.109 rax rbp tmp-ra.132 tmp.97))
       (tmp.109 (rsi tmp.110 rax rbp tmp-ra.132 tmp.97 tmp.105))
       (tmp.110 (rbp tmp-ra.132 tmp.97 tmp.105 tmp.109))
       (tmp.108 (rbp tmp-ra.132 tmp.97 tmp.105))
       (tmp.104 (rbp tmp-ra.132 tmp.97))
       (fixnum2.4 (rbp tmp-ra.132))
       (void3.3
        (empty5.1
         fixnum4.2
         tmp.118
         tmp.122
         tmp.124
         tmp.123
         tmp.119
         tmp.121
         tmp.120
         tmp.111
         tmp.115
         tmp.117
         tmp.116
         tmp.112
         tmp.114
         tmp.113
         rax
         rbp
         tmp-ra.132))
       (tmp.113 (rsi tmp.114 rax rbp tmp-ra.132 void3.3))
       (tmp.114 (rbp tmp-ra.132 void3.3 tmp.113))
       (tmp.112 (rsi tmp.115 tmp.117 tmp.116 rax rbp tmp-ra.132 void3.3))
       (tmp.116 (rsi tmp.117 rax rbp tmp-ra.132 void3.3 tmp.112))
       (tmp.117 (rbp tmp-ra.132 void3.3 tmp.112 tmp.116))
       (tmp.115 (rbp tmp-ra.132 void3.3 tmp.112))
       (tmp.111
        (rsi
         tmp.118
         tmp.122
         tmp.124
         tmp.123
         tmp.119
         tmp.121
         tmp.120
         rax
         rbp
         tmp-ra.132
         void3.3))
       (tmp.120 (rsi tmp.121 rax rbp tmp-ra.132 void3.3 tmp.111))
       (tmp.121 (rbp tmp-ra.132 void3.3 tmp.111 tmp.120))
       (tmp.119
        (rsi tmp.122 tmp.124 tmp.123 rax rbp tmp-ra.132 void3.3 tmp.111))
       (tmp.123 (rsi tmp.124 rax rbp tmp-ra.132 void3.3 tmp.111 tmp.119))
       (tmp.124 (rbp tmp-ra.132 void3.3 tmp.111 tmp.119 tmp.123))
       (tmp.122 (rbp tmp-ra.132 void3.3 tmp.111 tmp.119))
       (tmp.118 (rbp tmp-ra.132 void3.3 tmp.111))
       (fixnum4.2 (rbp tmp-ra.132 void3.3))
       (empty5.1 (rbp tmp-ra.132 void3.3))
       (rbp
        (empty5.1
         fixnum4.2
         tmp.118
         tmp.122
         tmp.124
         tmp.123
         tmp.119
         tmp.121
         tmp.120
         tmp.111
         tmp.115
         tmp.117
         tmp.116
         tmp.112
         tmp.114
         tmp.113
         void3.3
         fixnum2.4
         tmp.104
         tmp.108
         tmp.110
         tmp.109
         tmp.105
         tmp.107
         tmp.106
         tmp.97
         tmp.101
         tmp.103
         tmp.102
         tmp.98
         tmp.100
         tmp.99
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
         tmp-ra.132))
       (rax
        (tmp.123
         tmp.119
         tmp.120
         tmp.111
         tmp.116
         tmp.112
         tmp.113
         void3.3
         tmp.109
         tmp.105
         tmp.106
         tmp.97
         tmp.102
         tmp.98
         tmp.99
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
         tmp-ra.132))
       (rsi
        (tmp.111
         tmp.119
         tmp.123
         tmp.120
         tmp.112
         tmp.116
         tmp.113
         tmp.97
         tmp.105
         tmp.109
         tmp.106
         tmp.98
         tmp.102
         tmp.99
         tmp.83
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
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.132 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.85 fv1)
       (tmp.84 fv1)
       (tmp.83 fv1)
       (tmp.95 fv2)
       (tmp.102 fv1)
       (tmp.106 fv1)
       (tmp.105 fv1)
       (void3.3 fv1)
       (tmp.116 fv2)
       (tmp.120 fv2)
       (tmp.119 fv2)
       (tmp.123 fv3)
       (tmp.111 fv4)
       (tmp.112 fv3)
       (tmp.113 fv2)
       (tmp.109 fv2)
       (tmp.97 fv3)
       (tmp.98 fv2)
       (tmp.99 fv1)
       (tmp.91 fv3)
       (tmp.92 fv2)
       (tmp.88 fv2)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.-.11
      ((locals
        (tmp.58
         tmp.134
         tmp.24
         tmp.59
         tmp.135
         tmp-ra.125
         tmp.57
         tmp.25
         tmp.133
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.125 tmp.25 tmp.24))
         (tmp.133 (tmp.25 rbp tmp-ra.125 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.125
           tmp.24
           tmp.133
           tmp.57
           tmp.56
           tmp.134
           tmp.59
           tmp.58
           tmp.135))
         (tmp.57 (rbp tmp-ra.125 tmp.25 tmp.24))
         (tmp-ra.125
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.133
           tmp.57
           tmp.56
           tmp.134
           tmp.59
           tmp.58
           tmp.135
           rax))
         (tmp.135 (rbp tmp-ra.125 tmp.25))
         (tmp.59 (rbp tmp-ra.125 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.125
           rsi
           tmp.133
           tmp.57
           tmp.56
           tmp.134
           tmp.59
           tmp.58))
         (tmp.134 (tmp.24 rbp tmp-ra.125 tmp.25))
         (tmp.58 (rbp tmp-ra.125 tmp.25 tmp.24))
         (rax (rbp tmp-ra.125))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.125
           tmp.133
           tmp.57
           tmp.56
           tmp.134
           tmp.59
           tmp.58
           tmp.135
           rax))
         (rdi (tmp-ra.125))
         (rsi (tmp.24 tmp-ra.125))))
       (assignment ()))
      (begin
        (set! tmp-ra.125 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.133 tmp.25)
                      (set! tmp.133 (bitwise-and tmp.133 7))
                      (set! tmp.57 tmp.133))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.134 tmp.24)
                        (set! tmp.134 (bitwise-and tmp.134 7))
                        (set! tmp.59 tmp.134))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.135 tmp.24)
              (set! tmp.135 (- tmp.135 tmp.25))
              (set! rax tmp.135)
              (jump tmp-ra.125 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.125 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.125 rbp rax)))))
    (define L.+.10
      ((locals
        (tmp.62
         tmp.137
         tmp.22
         tmp.63
         tmp.138
         tmp-ra.126
         tmp.61
         tmp.23
         tmp.136
         tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.126 tmp.23 tmp.22))
         (tmp.136 (tmp.23 rbp tmp-ra.126 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.126
           tmp.22
           tmp.136
           tmp.61
           tmp.60
           tmp.137
           tmp.63
           tmp.62
           tmp.138))
         (tmp.61 (rbp tmp-ra.126 tmp.23 tmp.22))
         (tmp-ra.126
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.136
           tmp.61
           tmp.60
           tmp.137
           tmp.63
           tmp.62
           tmp.138
           rax))
         (tmp.138 (rbp tmp-ra.126 tmp.23))
         (tmp.63 (rbp tmp-ra.126 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.126
           rsi
           tmp.136
           tmp.61
           tmp.60
           tmp.137
           tmp.63
           tmp.62))
         (tmp.137 (tmp.22 rbp tmp-ra.126 tmp.23))
         (tmp.62 (rbp tmp-ra.126 tmp.23 tmp.22))
         (rax (rbp tmp-ra.126))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.126
           tmp.136
           tmp.61
           tmp.60
           tmp.137
           tmp.63
           tmp.62
           tmp.138
           rax))
         (rdi (tmp-ra.126))
         (rsi (tmp.22 tmp-ra.126))))
       (assignment ()))
      (begin
        (set! tmp-ra.126 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.136 tmp.23)
                      (set! tmp.136 (bitwise-and tmp.136 7))
                      (set! tmp.61 tmp.136))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.137 tmp.22)
                        (set! tmp.137 (bitwise-and tmp.137 7))
                        (set! tmp.63 tmp.137))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.138 tmp.22)
              (set! tmp.138 (+ tmp.138 tmp.23))
              (set! rax tmp.138)
              (jump tmp-ra.126 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.126 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.126 rbp rax)))))
    (define L.*.9
      ((locals
        (tmp.66
         tmp.140
         tmp.20
         tmp.67
         tmp.142
         tmp.68
         tmp.141
         tmp-ra.127
         tmp.65
         tmp.21
         tmp.139
         tmp.64))
       (conflicts
        ((tmp.64 (rbp tmp-ra.127 tmp.20 tmp.21))
         (tmp.139 (tmp.21 rbp tmp-ra.127 tmp.20))
         (tmp.21
          (rbp tmp-ra.127 tmp.20 tmp.139 tmp.65 tmp.64 tmp.140 tmp.67 tmp.66))
         (tmp.65 (rbp tmp-ra.127 tmp.20 tmp.21))
         (tmp-ra.127
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.139
           tmp.65
           tmp.64
           tmp.140
           tmp.67
           tmp.66
           tmp.142
           tmp.68
           tmp.141
           rax))
         (tmp.141 (rbp tmp-ra.127 tmp.20))
         (tmp.68 (tmp.142 rbp tmp-ra.127 tmp.20))
         (tmp.142 (rbp tmp-ra.127 tmp.68))
         (tmp.67 (rbp tmp-ra.127 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.127
           rsi
           tmp.139
           tmp.65
           tmp.64
           tmp.140
           tmp.67
           tmp.66
           tmp.68
           tmp.141))
         (tmp.140 (tmp.20 rbp tmp-ra.127 tmp.21))
         (tmp.66 (rbp tmp-ra.127 tmp.20 tmp.21))
         (rax (rbp tmp-ra.127))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.127
           tmp.139
           tmp.65
           tmp.64
           tmp.140
           tmp.67
           tmp.66
           tmp.142
           tmp.68
           tmp.141
           rax))
         (rdi (tmp-ra.127))
         (rsi (tmp.20 tmp-ra.127))))
       (assignment ()))
      (begin
        (set! tmp-ra.127 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.139 tmp.21)
                      (set! tmp.139 (bitwise-and tmp.139 7))
                      (set! tmp.65 tmp.139))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.140 tmp.20)
                        (set! tmp.140 (bitwise-and tmp.140 7))
                        (set! tmp.67 tmp.140))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.141 tmp.21)
              (set! tmp.141 (arithmetic-shift-right tmp.141 3))
              (set! tmp.68 tmp.141)
              (set! tmp.142 tmp.20)
              (set! tmp.142 (* tmp.142 tmp.68))
              (set! rax tmp.142)
              (jump tmp-ra.127 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.127 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.127 rbp rax)))))
    (define L.fun/void140574.4
      ((locals (tmp-ra.128))
       (conflicts
        ((tmp-ra.128 (rax rbp)) (rbp (rax tmp-ra.128)) (rax (rbp tmp-ra.128))))
       (assignment ()))
      (begin (set! tmp-ra.128 r15) (set! rax 30) (jump tmp-ra.128 rbp rax)))
    (define L.fun/empty140576.5
      ((locals (tmp-ra.129))
       (conflicts
        ((tmp-ra.129 (rax rbp)) (rbp (rax tmp-ra.129)) (rax (rbp tmp-ra.129))))
       (assignment ()))
      (begin (set! tmp-ra.129 r15) (set! rax 22) (jump tmp-ra.129 rbp rax)))
    (define L.fun/empty140575.6
      ((locals (tmp-ra.130))
       (conflicts ((tmp-ra.130 (rbp)) (rbp (r15 tmp-ra.130)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.130 r15)
        (set! r15 tmp-ra.130)
        (jump L.fun/empty140576.5 rbp r15)))
    (define L.fun/void140573.7
      ((locals (tmp-ra.131))
       (conflicts ((tmp-ra.131 (rbp)) (rbp (r15 tmp-ra.131)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.131 r15)
        (set! r15 tmp-ra.131)
        (jump L.fun/void140574.4 rbp r15)))
    (begin
      (set! tmp-ra.132 r15)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.12
          (begin
            (set! rsi 336)
            (set! rdi 1776)
            (set! r15 L.rp.12)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.13
          (begin
            (set! rsi 728)
            (set! rdi 728)
            (set! r15 L.rp.13)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.14
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.14)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.15
          (begin
            (set! rsi 1264)
            (set! rdi 1176)
            (set! r15 L.rp.15)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.16
          (begin
            (set! rsi 984)
            (set! rdi 496)
            (set! r15 L.rp.16)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.17
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.17)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.18)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.19
          (begin
            (set! rsi 1616)
            (set! rdi 1520)
            (set! r15 L.rp.19)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.20
          (begin
            (set! rsi 1392)
            (set! rdi 24)
            (set! r15 L.rp.20)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.21
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.21)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.22
          (begin
            (set! rsi 1456)
            (set! rdi 824)
            (set! r15 L.rp.22)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.23
          (begin
            (set! rsi 240)
            (set! rdi 1952)
            (set! r15 L.rp.23)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.24
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.24)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.25
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.25)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.26)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! fixnum0.6 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.27
          (begin
            (set! rsi 816)
            (set! rdi 1424)
            (set! r15 L.rp.27)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.28
          (begin
            (set! rsi 1520)
            (set! rdi 784)
            (set! r15 L.rp.28)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.86)
            (set! rdi tmp.85)
            (set! r15 L.rp.29)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.30
          (begin
            (set! rsi 1680)
            (set! rdi 2032)
            (set! r15 L.rp.30)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.31
          (begin
            (set! rsi 328)
            (set! rdi 1776)
            (set! r15 L.rp.31)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.32
          (begin
            (set! rsi tmp.89)
            (set! rdi tmp.88)
            (set! r15 L.rp.32)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.33
          (begin
            (set! rsi tmp.87)
            (set! rdi tmp.84)
            (set! r15 L.rp.33)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.34
          (begin
            (set! rsi 1216)
            (set! rdi 2000)
            (set! r15 L.rp.34)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.35
          (begin
            (set! rsi 1280)
            (set! rdi 1928)
            (set! r15 L.rp.35)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.93)
            (set! rdi tmp.92)
            (set! r15 L.rp.36)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.37
          (begin
            (set! rsi 488)
            (set! rdi 120)
            (set! r15 L.rp.37)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.38
          (begin
            (set! rsi 280)
            (set! rdi 1032)
            (set! r15 L.rp.38)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.96)
            (set! rdi tmp.95)
            (set! r15 L.rp.39)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.40
          (begin
            (set! rsi tmp.94)
            (set! rdi tmp.91)
            (set! r15 L.rp.40)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.41
          (begin
            (set! rsi tmp.90)
            (set! rdi tmp.83)
            (set! r15 L.rp.41)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! fixnum1.5 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.42
          (begin
            (set! rsi 1984)
            (set! rdi 888)
            (set! r15 L.rp.42)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.99 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.43
          (begin
            (set! rsi 888)
            (set! rdi 1024)
            (set! r15 L.rp.43)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.100 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.44
          (begin
            (set! rsi tmp.100)
            (set! rdi tmp.99)
            (set! r15 L.rp.44)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.98 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.45
          (begin
            (set! rsi 8)
            (set! rdi 504)
            (set! r15 L.rp.45)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.102 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.46
          (begin
            (set! rsi 1544)
            (set! rdi 512)
            (set! r15 L.rp.46)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.103 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.47
          (begin
            (set! rsi tmp.103)
            (set! rdi tmp.102)
            (set! r15 L.rp.47)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.101 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.48
          (begin
            (set! rsi tmp.101)
            (set! rdi tmp.98)
            (set! r15 L.rp.48)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.97 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.49
          (begin
            (set! rsi 760)
            (set! rdi 288)
            (set! r15 L.rp.49)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.106 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.50
          (begin
            (set! rsi 960)
            (set! rdi 880)
            (set! r15 L.rp.50)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.107 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.51
          (begin
            (set! rsi tmp.107)
            (set! rdi tmp.106)
            (set! r15 L.rp.51)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.105 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.52
          (begin
            (set! rsi 1288)
            (set! rdi 1000)
            (set! r15 L.rp.52)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.109 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.53
          (begin
            (set! rsi 48)
            (set! rdi 1744)
            (set! r15 L.rp.53)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.110 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.54
          (begin
            (set! rsi tmp.110)
            (set! rdi tmp.109)
            (set! r15 L.rp.54)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.108 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.55
          (begin
            (set! rsi tmp.108)
            (set! rdi tmp.105)
            (set! r15 L.rp.55)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.104 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.56
          (begin
            (set! rsi tmp.104)
            (set! rdi tmp.97)
            (set! r15 L.rp.56)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! fixnum2.4 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.57
          (begin (set! r15 L.rp.57) (jump L.fun/void140573.7 rbp r15)))
        (set! rbp (+ rbp 240)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.58
          (begin
            (set! rsi 1960)
            (set! rdi 1272)
            (set! r15 L.rp.58)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.113 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.59
          (begin
            (set! rsi 648)
            (set! rdi 1632)
            (set! r15 L.rp.59)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.114 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.60
          (begin
            (set! rsi tmp.114)
            (set! rdi tmp.113)
            (set! r15 L.rp.60)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.112 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.61
          (begin
            (set! rsi 1632)
            (set! rdi 712)
            (set! r15 L.rp.61)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.116 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.62
          (begin
            (set! rsi 552)
            (set! rdi 216)
            (set! r15 L.rp.62)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.117 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.63
          (begin
            (set! rsi tmp.117)
            (set! rdi tmp.116)
            (set! r15 L.rp.63)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.115 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.64
          (begin
            (set! rsi tmp.115)
            (set! rdi tmp.112)
            (set! r15 L.rp.64)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.111 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.65
          (begin
            (set! rsi 1296)
            (set! rdi 1944)
            (set! r15 L.rp.65)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.120 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.66
          (begin
            (set! rsi 1872)
            (set! rdi 1872)
            (set! r15 L.rp.66)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.121 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.67
          (begin
            (set! rsi tmp.121)
            (set! rdi tmp.120)
            (set! r15 L.rp.67)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.119 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.68
          (begin
            (set! rsi 1744)
            (set! rdi 1128)
            (set! r15 L.rp.68)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.123 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.69
          (begin
            (set! rsi 480)
            (set! rdi 944)
            (set! r15 L.rp.69)
            (jump L.*.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.124 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.70
          (begin
            (set! rsi tmp.124)
            (set! rdi tmp.123)
            (set! r15 L.rp.70)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.122 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.71
          (begin
            (set! rsi tmp.122)
            (set! rdi tmp.119)
            (set! r15 L.rp.71)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! tmp.118 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.72
          (begin
            (set! rsi tmp.118)
            (set! rdi tmp.111)
            (set! r15 L.rp.72)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 240)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.73
          (begin (set! r15 L.rp.73) (jump L.fun/empty140575.6 rbp r15)))
        (set! rbp (+ rbp 240)))
      (set! empty5.1 rax)
      (set! rax void3.3)
      (jump tmp-ra.132 rbp rax))))
(check-by-interp
 '(module
    ((locals
      (fixnum5.1
       tmp.104
       tmp.108
       tmp.110
       tmp.107
       tmp.101
       tmp.103
       tmp.100
       error4.2
       void3.3
       void2.4
       fixnum1.5
       tmp.90
       tmp.94
       tmp.96
       tmp.93
       tmp.87
       tmp.89
       tmp.86
       fixnum0.6
       tmp.76
       tmp.80
       tmp.82
       tmp.79
       tmp.73
       tmp.75
       tmp.72))
     (conflicts
      ((tmp-ra.122
        (fixnum5.1
         tmp.104
         tmp.108
         tmp.110
         tmp.109
         tmp.105
         tmp.107
         tmp.106
         tmp.97
         tmp.101
         tmp.103
         tmp.102
         tmp.98
         tmp.100
         tmp.99
         error4.2
         void3.3
         void2.4
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
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.122))
       (tmp.72 (rbp tmp-ra.122 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.122))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.122 tmp.70))
       (tmp.75 (rbp tmp-ra.122 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.122 tmp.70))
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
         tmp-ra.122))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.122 tmp.69))
       (tmp.79 (rbp tmp-ra.122 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.122 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.122 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.122 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.122 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.122 tmp.69))
       (fixnum0.6 (rbp tmp-ra.122))
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.122))
       (tmp.86 (rbp tmp-ra.122 tmp.85))
       (tmp.84 (rsi tmp.87 tmp.89 tmp.88 rax rbp tmp-ra.122))
       (tmp.88 (rsi tmp.89 rax rbp tmp-ra.122 tmp.84))
       (tmp.89 (rbp tmp-ra.122 tmp.84 tmp.88))
       (tmp.87 (rbp tmp-ra.122 tmp.84))
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
         tmp-ra.122))
       (tmp.92 (rsi tmp.93 rax rbp tmp-ra.122 tmp.83))
       (tmp.93 (rbp tmp-ra.122 tmp.83 tmp.92))
       (tmp.91 (rsi tmp.94 tmp.96 tmp.95 rax rbp tmp-ra.122 tmp.83))
       (tmp.95 (rsi tmp.96 rax rbp tmp-ra.122 tmp.83 tmp.91))
       (tmp.96 (rbp tmp-ra.122 tmp.83 tmp.91 tmp.95))
       (tmp.94 (rbp tmp-ra.122 tmp.83 tmp.91))
       (tmp.90 (rbp tmp-ra.122 tmp.83))
       (fixnum1.5 (rbp tmp-ra.122))
       (void2.4 (rbp tmp-ra.122))
       (void3.3 (rbp tmp-ra.122))
       (error4.2 (rbp tmp-ra.122))
       (tmp.99 (rsi tmp.100 rax rbp tmp-ra.122))
       (tmp.100 (rbp tmp-ra.122 tmp.99))
       (tmp.98 (rsi tmp.101 tmp.103 tmp.102 rax rbp tmp-ra.122))
       (tmp.102 (rsi tmp.103 rax rbp tmp-ra.122 tmp.98))
       (tmp.103 (rbp tmp-ra.122 tmp.98 tmp.102))
       (tmp.101 (rbp tmp-ra.122 tmp.98))
       (tmp.97
        (rsi
         tmp.104
         tmp.108
         tmp.110
         tmp.109
         tmp.105
         tmp.107
         tmp.106
         rax
         rbp
         tmp-ra.122))
       (tmp.106 (rsi tmp.107 rax rbp tmp-ra.122 tmp.97))
       (tmp.107 (rbp tmp-ra.122 tmp.97 tmp.106))
       (tmp.105 (rsi tmp.108 tmp.110 tmp.109 rax rbp tmp-ra.122 tmp.97))
       (tmp.109 (rsi tmp.110 rax rbp tmp-ra.122 tmp.97 tmp.105))
       (tmp.110 (rbp tmp-ra.122 tmp.97 tmp.105 tmp.109))
       (tmp.108 (rbp tmp-ra.122 tmp.97 tmp.105))
       (tmp.104 (rbp tmp-ra.122 tmp.97))
       (fixnum5.1 (rbp tmp-ra.122))
       (rbp
        (fixnum5.1
         tmp.104
         tmp.108
         tmp.110
         tmp.109
         tmp.105
         tmp.107
         tmp.106
         tmp.97
         tmp.101
         tmp.103
         tmp.102
         tmp.98
         tmp.100
         tmp.99
         error4.2
         void3.3
         void2.4
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
         tmp-ra.122))
       (rax
        (tmp.109
         tmp.105
         tmp.106
         tmp.97
         tmp.102
         tmp.98
         tmp.99
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
         tmp-ra.122))
       (rsi
        (tmp.97
         tmp.105
         tmp.109
         tmp.106
         tmp.98
         tmp.102
         tmp.99
         tmp.83
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
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.122 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.85 fv1)
       (tmp.84 fv1)
       (tmp.83 fv1)
       (tmp.95 fv2)
       (tmp.99 fv1)
       (tmp.98 fv1)
       (tmp.97 fv1)
       (tmp.109 fv2)
       (tmp.105 fv3)
       (tmp.106 fv2)
       (tmp.102 fv2)
       (tmp.91 fv3)
       (tmp.92 fv2)
       (tmp.88 fv2)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1))))
    (define L.-.15
      ((locals
        (tmp.58
         tmp.124
         tmp.24
         tmp.59
         tmp.125
         tmp-ra.111
         tmp.57
         tmp.25
         tmp.123
         tmp.56))
       (conflicts
        ((tmp.56 (rbp tmp-ra.111 tmp.25 tmp.24))
         (tmp.123 (tmp.25 rbp tmp-ra.111 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.111
           tmp.24
           tmp.123
           tmp.57
           tmp.56
           tmp.124
           tmp.59
           tmp.58
           tmp.125))
         (tmp.57 (rbp tmp-ra.111 tmp.25 tmp.24))
         (tmp-ra.111
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.123
           tmp.57
           tmp.56
           tmp.124
           tmp.59
           tmp.58
           tmp.125
           rax))
         (tmp.125 (rbp tmp-ra.111 tmp.25))
         (tmp.59 (rbp tmp-ra.111 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.111
           rsi
           tmp.123
           tmp.57
           tmp.56
           tmp.124
           tmp.59
           tmp.58))
         (tmp.124 (tmp.24 rbp tmp-ra.111 tmp.25))
         (tmp.58 (rbp tmp-ra.111 tmp.25 tmp.24))
         (rax (rbp tmp-ra.111))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.111
           tmp.123
           tmp.57
           tmp.56
           tmp.124
           tmp.59
           tmp.58
           tmp.125
           rax))
         (rdi (tmp-ra.111))
         (rsi (tmp.24 tmp-ra.111))))
       (assignment ()))
      (begin
        (set! tmp-ra.111 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.123 tmp.25)
                      (set! tmp.123 (bitwise-and tmp.123 7))
                      (set! tmp.57 tmp.123))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.124 tmp.24)
                        (set! tmp.124 (bitwise-and tmp.124 7))
                        (set! tmp.59 tmp.124))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.125 tmp.24)
              (set! tmp.125 (- tmp.125 tmp.25))
              (set! rax tmp.125)
              (jump tmp-ra.111 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.111 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.111 rbp rax)))))
    (define L.*.14
      ((locals
        (tmp.62
         tmp.127
         tmp.20
         tmp.63
         tmp.129
         tmp.64
         tmp.128
         tmp-ra.112
         tmp.61
         tmp.21
         tmp.126
         tmp.60))
       (conflicts
        ((tmp.60 (rbp tmp-ra.112 tmp.20 tmp.21))
         (tmp.126 (tmp.21 rbp tmp-ra.112 tmp.20))
         (tmp.21
          (rbp tmp-ra.112 tmp.20 tmp.126 tmp.61 tmp.60 tmp.127 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.112 tmp.20 tmp.21))
         (tmp-ra.112
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.126
           tmp.61
           tmp.60
           tmp.127
           tmp.63
           tmp.62
           tmp.129
           tmp.64
           tmp.128
           rax))
         (tmp.128 (rbp tmp-ra.112 tmp.20))
         (tmp.64 (tmp.129 rbp tmp-ra.112 tmp.20))
         (tmp.129 (rbp tmp-ra.112 tmp.64))
         (tmp.63 (rbp tmp-ra.112 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.112
           rsi
           tmp.126
           tmp.61
           tmp.60
           tmp.127
           tmp.63
           tmp.62
           tmp.64
           tmp.128))
         (tmp.127 (tmp.20 rbp tmp-ra.112 tmp.21))
         (tmp.62 (rbp tmp-ra.112 tmp.20 tmp.21))
         (rax (rbp tmp-ra.112))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.112
           tmp.126
           tmp.61
           tmp.60
           tmp.127
           tmp.63
           tmp.62
           tmp.129
           tmp.64
           tmp.128
           rax))
         (rdi (tmp-ra.112))
         (rsi (tmp.20 tmp-ra.112))))
       (assignment ()))
      (begin
        (set! tmp-ra.112 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.126 tmp.21)
                      (set! tmp.126 (bitwise-and tmp.126 7))
                      (set! tmp.61 tmp.126))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.127 tmp.20)
                        (set! tmp.127 (bitwise-and tmp.127 7))
                        (set! tmp.63 tmp.127))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.128 tmp.21)
              (set! tmp.128 (arithmetic-shift-right tmp.128 3))
              (set! tmp.64 tmp.128)
              (set! tmp.129 tmp.20)
              (set! tmp.129 (* tmp.129 tmp.64))
              (set! rax tmp.129)
              (jump tmp-ra.112 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.112 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.112 rbp rax)))))
    (define L.+.13
      ((locals
        (tmp.67
         tmp.131
         tmp.22
         tmp.68
         tmp.132
         tmp-ra.113
         tmp.66
         tmp.23
         tmp.130
         tmp.65))
       (conflicts
        ((tmp.65 (rbp tmp-ra.113 tmp.23 tmp.22))
         (tmp.130 (tmp.23 rbp tmp-ra.113 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.113
           tmp.22
           tmp.130
           tmp.66
           tmp.65
           tmp.131
           tmp.68
           tmp.67
           tmp.132))
         (tmp.66 (rbp tmp-ra.113 tmp.23 tmp.22))
         (tmp-ra.113
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.130
           tmp.66
           tmp.65
           tmp.131
           tmp.68
           tmp.67
           tmp.132
           rax))
         (tmp.132 (rbp tmp-ra.113 tmp.23))
         (tmp.68 (rbp tmp-ra.113 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.113
           rsi
           tmp.130
           tmp.66
           tmp.65
           tmp.131
           tmp.68
           tmp.67))
         (tmp.131 (tmp.22 rbp tmp-ra.113 tmp.23))
         (tmp.67 (rbp tmp-ra.113 tmp.23 tmp.22))
         (rax (rbp tmp-ra.113))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.113
           tmp.130
           tmp.66
           tmp.65
           tmp.131
           tmp.68
           tmp.67
           tmp.132
           rax))
         (rdi (tmp-ra.113))
         (rsi (tmp.22 tmp-ra.113))))
       (assignment ()))
      (begin
        (set! tmp-ra.113 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.130 tmp.23)
                      (set! tmp.130 (bitwise-and tmp.130 7))
                      (set! tmp.66 tmp.130))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.131 tmp.22)
                        (set! tmp.131 (bitwise-and tmp.131 7))
                        (set! tmp.68 tmp.131))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.132 tmp.22)
              (set! tmp.132 (+ tmp.132 tmp.23))
              (set! rax tmp.132)
              (jump tmp-ra.113 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.113 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.113 rbp rax)))))
    (define L.fun/error143927.4
      ((locals (tmp-ra.114))
       (conflicts ((tmp-ra.114 (rbp)) (rbp (r15 tmp-ra.114)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.114 r15)
        (set! r15 tmp-ra.114)
        (jump L.fun/error143928.6 rbp r15)))
    (define L.fun/ascii-char143929.5
      ((locals (tmp-ra.115))
       (conflicts ((tmp-ra.115 (rbp)) (rbp (r15 tmp-ra.115)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.115 r15)
        (set! r15 tmp-ra.115)
        (jump L.fun/ascii-char143930.11 rbp r15)))
    (define L.fun/error143928.6
      ((locals (tmp-ra.116))
       (conflicts
        ((tmp-ra.116 (rax rbp)) (rbp (rax tmp-ra.116)) (rax (rbp tmp-ra.116))))
       (assignment ()))
      (begin (set! tmp-ra.116 r15) (set! rax 10814) (jump tmp-ra.116 rbp rax)))
    (define L.fun/void143926.7
      ((locals (tmp-ra.117))
       (conflicts
        ((tmp-ra.117 (rax rbp)) (rbp (rax tmp-ra.117)) (rax (rbp tmp-ra.117))))
       (assignment ()))
      (begin (set! tmp-ra.117 r15) (set! rax 30) (jump tmp-ra.117 rbp rax)))
    (define L.fun/void143924.8
      ((locals (tmp-ra.118))
       (conflicts
        ((tmp-ra.118 (rax rbp)) (rbp (rax tmp-ra.118)) (rax (rbp tmp-ra.118))))
       (assignment ()))
      (begin (set! tmp-ra.118 r15) (set! rax 30) (jump tmp-ra.118 rbp rax)))
    (define L.fun/void143923.9
      ((locals (tmp-ra.119))
       (conflicts ((tmp-ra.119 (rbp)) (rbp (r15 tmp-ra.119)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.119 r15)
        (set! r15 tmp-ra.119)
        (jump L.fun/void143924.8 rbp r15)))
    (define L.fun/void143925.10
      ((locals (tmp-ra.120))
       (conflicts ((tmp-ra.120 (rbp)) (rbp (r15 tmp-ra.120)) (r15 (rbp))))
       (assignment ()))
      (begin
        (set! tmp-ra.120 r15)
        (set! r15 tmp-ra.120)
        (jump L.fun/void143926.7 rbp r15)))
    (define L.fun/ascii-char143930.11
      ((locals (tmp-ra.121))
       (conflicts
        ((tmp-ra.121 (rax rbp)) (rbp (rax tmp-ra.121)) (rax (rbp tmp-ra.121))))
       (assignment ()))
      (begin (set! tmp-ra.121 r15) (set! rax 25390) (jump tmp-ra.121 rbp rax)))
    (begin
      (set! tmp-ra.122 r15)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.16
          (begin
            (set! rsi 1392)
            (set! rdi 544)
            (set! r15 L.rp.16)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.17
          (begin
            (set! rsi 1344)
            (set! rdi 360)
            (set! r15 L.rp.17)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.18)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.19
          (begin
            (set! rsi 288)
            (set! rdi 1888)
            (set! r15 L.rp.19)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.20
          (begin
            (set! rsi 800)
            (set! rdi 968)
            (set! r15 L.rp.20)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.21
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.21)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.22)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.23
          (begin
            (set! rsi 912)
            (set! rdi 32)
            (set! r15 L.rp.23)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.24
          (begin
            (set! rsi 1744)
            (set! rdi 688)
            (set! r15 L.rp.24)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.25
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.25)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.26
          (begin
            (set! rsi 568)
            (set! rdi 304)
            (set! r15 L.rp.26)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.27
          (begin
            (set! rsi 256)
            (set! rdi 1344)
            (set! r15 L.rp.27)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.28
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.28)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.29)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.30)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! fixnum0.6 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.31
          (begin
            (set! rsi 1384)
            (set! rdi 1648)
            (set! r15 L.rp.31)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.32
          (begin
            (set! rsi 488)
            (set! rdi 1664)
            (set! r15 L.rp.32)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.33
          (begin
            (set! rsi tmp.86)
            (set! rdi tmp.85)
            (set! r15 L.rp.33)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.34
          (begin
            (set! rsi 192)
            (set! rdi 1624)
            (set! r15 L.rp.34)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.35
          (begin
            (set! rsi 416)
            (set! rdi 1080)
            (set! r15 L.rp.35)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.89)
            (set! rdi tmp.88)
            (set! r15 L.rp.36)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.37
          (begin
            (set! rsi tmp.87)
            (set! rdi tmp.84)
            (set! r15 L.rp.37)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.38
          (begin
            (set! rsi 1496)
            (set! rdi 1936)
            (set! r15 L.rp.38)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.39
          (begin
            (set! rsi 80)
            (set! rdi 344)
            (set! r15 L.rp.39)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.40
          (begin
            (set! rsi tmp.93)
            (set! rdi tmp.92)
            (set! r15 L.rp.40)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.41
          (begin
            (set! rsi 1656)
            (set! rdi 1728)
            (set! r15 L.rp.41)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.42
          (begin
            (set! rsi 1408)
            (set! rdi 1040)
            (set! r15 L.rp.42)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.43
          (begin
            (set! rsi tmp.96)
            (set! rdi tmp.95)
            (set! r15 L.rp.43)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.44
          (begin
            (set! rsi tmp.94)
            (set! rdi tmp.91)
            (set! r15 L.rp.44)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.45
          (begin
            (set! rsi tmp.90)
            (set! rdi tmp.83)
            (set! r15 L.rp.45)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! fixnum1.5 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.46
          (begin (set! r15 L.rp.46) (jump L.fun/void143923.9 rbp r15)))
        (set! rbp (+ rbp 176)))
      (set! void2.4 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.47
          (begin (set! r15 L.rp.47) (jump L.fun/void143925.10 rbp r15)))
        (set! rbp (+ rbp 176)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/error143927.4 rbp r15)))
        (set! rbp (+ rbp 176)))
      (set! error4.2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.49
          (begin
            (set! rsi 1064)
            (set! rdi 464)
            (set! r15 L.rp.49)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.99 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.50
          (begin
            (set! rsi 1200)
            (set! rdi 664)
            (set! r15 L.rp.50)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.100 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.51
          (begin
            (set! rsi tmp.100)
            (set! rdi tmp.99)
            (set! r15 L.rp.51)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.98 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.52
          (begin
            (set! rsi 848)
            (set! rdi 1152)
            (set! r15 L.rp.52)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.102 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.53
          (begin
            (set! rsi 1976)
            (set! rdi 448)
            (set! r15 L.rp.53)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.103 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.54
          (begin
            (set! rsi tmp.103)
            (set! rdi tmp.102)
            (set! r15 L.rp.54)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.101 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.55
          (begin
            (set! rsi tmp.101)
            (set! rdi tmp.98)
            (set! r15 L.rp.55)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.97 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.56
          (begin
            (set! rsi 128)
            (set! rdi 16)
            (set! r15 L.rp.56)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.106 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.57
          (begin
            (set! rsi 88)
            (set! rdi 1704)
            (set! r15 L.rp.57)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.107 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.58
          (begin
            (set! rsi tmp.107)
            (set! rdi tmp.106)
            (set! r15 L.rp.58)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.105 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.59
          (begin
            (set! rsi 472)
            (set! rdi 1280)
            (set! r15 L.rp.59)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.109 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.60
          (begin
            (set! rsi 752)
            (set! rdi 472)
            (set! r15 L.rp.60)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.110 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.61
          (begin
            (set! rsi tmp.110)
            (set! rdi tmp.109)
            (set! r15 L.rp.61)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.108 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.62
          (begin
            (set! rsi tmp.108)
            (set! rdi tmp.105)
            (set! r15 L.rp.62)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.104 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.63
          (begin
            (set! rsi tmp.104)
            (set! rdi tmp.97)
            (set! r15 L.rp.63)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! fixnum5.1 rax)
      (set! r15 tmp-ra.122)
      (jump L.fun/ascii-char143929.5 rbp r15))))
