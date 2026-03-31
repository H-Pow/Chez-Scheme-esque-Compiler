#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         "../target-nested-asm-lang-v2/replace-locations.rkt")
(define (fail-if-invalid p)
  (when (not (nested-asm-lang-fvars-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "nested-asm-lang-fvars-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-asm-pred-lang-v8/assignments p)
  (interp-nested-asm-lang-fvars-v8 (fail-if-invalid (replace-locations p)))))

(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.50 (rax rbp)) (rbp (rax tmp-ra.50)) (rax (rbp tmp-ra.50))))
     (assignment ((tmp-ra.50 r15))))
    (begin (set! tmp-ra.50 r15) (set! rax 30) (jump tmp-ra.50 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.53 (rdi rsi rbp))
       (rbp (r15 rdi rsi tmp-ra.53))
       (rsi (r15 rdi rbp tmp-ra.53))
       (rdi (r15 rbp rsi tmp-ra.53))
       (r15 (rbp rdi rsi))))
     (assignment ((tmp-ra.53 r15))))
    (define L.cons.5
      ((locals ())
       (conflicts
        ((tmp-ra.52 (rax tmp.50 tmp.54 tmp.51 tmp.47 tmp.46 rbp r12 rsi rdi))
         (tmp.46 (tmp.50 tmp.54 tmp.51 tmp.47 rbp tmp-ra.52 r12 rsi))
         (tmp.47 (tmp.50 tmp.54 tmp.51 tmp.46 rbp tmp-ra.52 r12))
         (tmp.51 (tmp.46 rbp tmp-ra.52 tmp.47 r12))
         (tmp.54 (tmp.46 rbp tmp-ra.52 tmp.47))
         (tmp.50 (tmp.46 rbp tmp-ra.52 tmp.47))
         (rdi (tmp-ra.52))
         (rsi (tmp.46 tmp-ra.52))
         (r12 (rbp tmp.51 tmp.47 tmp.46 tmp-ra.52))
         (rbp (rax tmp.50 tmp.54 tmp.51 r12 tmp.47 tmp.46 tmp-ra.52))
         (rax (rbp tmp-ra.52))))
       (assignment
        ((tmp-ra.52 r15)
         (tmp.46 r14)
         (tmp.47 r13)
         (tmp.51 r9)
         (tmp.54 r9)
         (tmp.50 r9))))
      (begin
        (set! tmp-ra.52 r15)
        (set! tmp.46 rdi)
        (set! tmp.47 rsi)
        (begin (set! tmp.51 r12) (set! r12 (+ r12 16)))
        (set! tmp.54 tmp.51)
        (set! tmp.54 (+ tmp.54 1))
        (set! tmp.50 tmp.54)
        (mset! tmp.50 -1 tmp.46)
        (mset! tmp.50 7 tmp.47)
        (set! rax tmp.50)
        (jump tmp-ra.52 rbp rax)))
    (begin
      (set! tmp-ra.53 r15)
      (set! rsi 3816)
      (set! rdi 1808)
      (set! r15 tmp-ra.53)
      (jump L.cons.5 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.51 (rax ascii-char0.1 rbp))
       (ascii-char0.1 (rbp tmp-ra.51))
       (rbp (rax ascii-char0.1 tmp-ra.51))
       (rax (rbp tmp-ra.51))))
     (assignment ((tmp-ra.51 r15) (ascii-char0.1 r14))))
    (begin
      (set! tmp-ra.51 r15)
      (set! ascii-char0.1 27438)
      (set! rax 22)
      (jump tmp-ra.51 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.51 (rax void0.1 rbp))
       (void0.1 (rbp tmp-ra.51))
       (rbp (rax void0.1 tmp-ra.51))
       (rax (rbp tmp-ra.51))))
     (assignment ((tmp-ra.51 r15) (void0.1 r14))))
    (begin
      (set! tmp-ra.51 r15)
      (set! void0.1 30)
      (set! rax 31790)
      (jump tmp-ra.51 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.54 (rdi rsi void0.1 rbp))
       (void0.1 (rbp tmp-ra.54))
       (rbp (r15 rdi rsi void0.1 tmp-ra.54))
       (rsi (r15 rdi rbp tmp-ra.54))
       (rdi (r15 rbp rsi tmp-ra.54))
       (r15 (rbp rdi rsi))))
     (assignment ((tmp-ra.54 r15) (void0.1 r14))))
    (define L.cons.5
      ((locals ())
       (conflicts
        ((tmp-ra.53 (rax tmp.51 tmp.55 tmp.52 tmp.48 tmp.47 rbp r12 rsi rdi))
         (tmp.47 (tmp.51 tmp.55 tmp.52 tmp.48 rbp tmp-ra.53 r12 rsi))
         (tmp.48 (tmp.51 tmp.55 tmp.52 tmp.47 rbp tmp-ra.53 r12))
         (tmp.52 (tmp.47 rbp tmp-ra.53 tmp.48 r12))
         (tmp.55 (tmp.47 rbp tmp-ra.53 tmp.48))
         (tmp.51 (tmp.47 rbp tmp-ra.53 tmp.48))
         (rdi (tmp-ra.53))
         (rsi (tmp.47 tmp-ra.53))
         (r12 (rbp tmp.52 tmp.48 tmp.47 tmp-ra.53))
         (rbp (rax tmp.51 tmp.55 tmp.52 r12 tmp.48 tmp.47 tmp-ra.53))
         (rax (rbp tmp-ra.53))))
       (assignment
        ((tmp-ra.53 r15)
         (tmp.47 r14)
         (tmp.48 r13)
         (tmp.52 r9)
         (tmp.55 r9)
         (tmp.51 r9))))
      (begin
        (set! tmp-ra.53 r15)
        (set! tmp.47 rdi)
        (set! tmp.48 rsi)
        (begin (set! tmp.52 r12) (set! r12 (+ r12 16)))
        (set! tmp.55 tmp.52)
        (set! tmp.55 (+ tmp.55 1))
        (set! tmp.51 tmp.55)
        (mset! tmp.51 -1 tmp.47)
        (mset! tmp.51 7 tmp.48)
        (set! rax tmp.51)
        (jump tmp-ra.53 rbp rax)))
    (begin
      (set! tmp-ra.54 r15)
      (set! void0.1 30)
      (set! rsi 3704)
      (set! rdi 1624)
      (set! r15 tmp-ra.54)
      (jump L.cons.5 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts ((tmp-ra.51 (rbp)) (rbp (r15 tmp-ra.51)) (r15 (rbp))))
     (assignment ((tmp-ra.51 r15))))
    (define L.fun/fixnum8389.4
      ((locals ())
       (conflicts
        ((tmp-ra.50 (rax rbp)) (rbp (rax tmp-ra.50)) (rax (rbp tmp-ra.50))))
       (assignment ((tmp-ra.50 r15))))
      (begin (set! tmp-ra.50 r15) (set! rax 1672) (jump tmp-ra.50 rbp rax)))
    (begin
      (set! tmp-ra.51 r15)
      (set! r15 tmp-ra.51)
      (jump L.fun/fixnum8389.4 rbp r15))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.52 (rax void1.1 boolean0.2 rbp))
       (boolean0.2 (rbp tmp-ra.52))
       (void1.1 (rbp tmp-ra.52))
       (rbp (rax void1.1 boolean0.2 tmp-ra.52))
       (rax (rbp tmp-ra.52))))
     (assignment ((tmp-ra.52 r15) (boolean0.2 r14) (void1.1 r14))))
    (begin
      (set! tmp-ra.52 r15)
      (set! boolean0.2 6)
      (set! void1.1 30)
      (set! rax 30)
      (jump tmp-ra.52 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.53 (rdi tmp.54 tmp.51 rbp))
       (tmp.51 (rbp tmp-ra.53))
       (tmp.54 (rbp tmp-ra.53))
       (rbp (r15 rdi tmp.54 tmp.51 tmp-ra.53))
       (rdi (r15 rbp tmp-ra.53))
       (r15 (rbp rdi))))
     (assignment ((tmp-ra.53 r15) (tmp.51 r14) (tmp.54 r14))))
    (define L.fun/fixnum8394.4
      ((locals ())
       (conflicts
        ((tmp-ra.52 (rax oprand0.1 rbp rdi))
         (oprand0.1 (rbp tmp-ra.52))
         (rdi (tmp-ra.52))
         (rbp (rax oprand0.1 tmp-ra.52))
         (rax (rbp tmp-ra.52))))
       (assignment ((tmp-ra.52 r15) (oprand0.1 r14))))
      (begin
        (set! tmp-ra.52 r15)
        (set! oprand0.1 rdi)
        (set! rax 312)
        (jump tmp-ra.52 rbp rax)))
    (begin
      (set! tmp-ra.53 r15)
      (if (begin (set! tmp.54 14) (!= tmp.54 6))
        (set! tmp.51 15934)
        (set! tmp.51 45118))
      (set! rdi tmp.51)
      (set! r15 tmp-ra.53)
      (jump L.fun/fixnum8394.4 rbp r15 rdi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.55 (rdi tmp.52 rax rbp))
       (tmp.52 (rbp tmp-ra.55))
       (rbp (tmp.52 r15 rdi rax tmp-ra.55))
       (rax (rbp tmp-ra.55))
       (rdi (tmp-ra.55 r15 rbp))
       (r15 (rbp rdi))))
     (assignment ((tmp-ra.55 fv0) (tmp.52 r15))))
    (define L.fun/error8401.4
      ((locals ())
       (conflicts
        ((tmp-ra.53 (rax oprand0.1 rbp rdi))
         (oprand0.1 (rbp tmp-ra.53))
         (rdi (tmp-ra.53))
         (rbp (rax oprand0.1 tmp-ra.53))
         (rax (rbp tmp-ra.53))))
       (assignment ((tmp-ra.53 r15) (oprand0.1 r14))))
      (begin
        (set! tmp-ra.53 r15)
        (set! oprand0.1 rdi)
        (set! rax 1854)
        (jump tmp-ra.53 rbp rax)))
    (define L.fun/void8402.5
      ((locals ())
       (conflicts
        ((tmp-ra.54 (rax oprand0.2 rbp rdi))
         (oprand0.2 (rbp tmp-ra.54))
         (rdi (tmp-ra.54))
         (rbp (rax oprand0.2 tmp-ra.54))
         (rax (rbp tmp-ra.54))))
       (assignment ((tmp-ra.54 r15) (oprand0.2 r14))))
      (begin
        (set! tmp-ra.54 r15)
        (set! oprand0.2 rdi)
        (set! rax 30)
        (jump tmp-ra.54 rbp rax)))
    (begin
      (set! tmp-ra.55 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.7
          (begin
            (set! rdi 22)
            (set! r15 L.rp.7)
            (jump L.fun/void8402.5 rbp r15 rdi)))
        (set! rbp (+ rbp 8)))
      (set! tmp.52 rax)
      (set! rdi tmp.52)
      (set! r15 tmp-ra.55)
      (jump L.fun/error8401.4 rbp r15 rdi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.55 (pair1.1 rax ascii-char0.2 rbp))
       (ascii-char0.2 (pair1.1 rax rbp tmp-ra.55))
       (pair1.1 (rbp tmp-ra.55 ascii-char0.2))
       (rbp (pair1.1 r15 rdi rsi rax ascii-char0.2 tmp-ra.55))
       (rax (rbp tmp-ra.55 ascii-char0.2))
       (rsi (r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment ((tmp-ra.55 fv0) (ascii-char0.2 fv1) (pair1.1 r15))))
    (define L.cons.5
      ((locals ())
       (conflicts
        ((tmp-ra.54 (rax tmp.52 tmp.56 tmp.53 tmp.49 tmp.48 rbp r12 rsi rdi))
         (tmp.48 (tmp.52 tmp.56 tmp.53 tmp.49 rbp tmp-ra.54 r12 rsi))
         (tmp.49 (tmp.52 tmp.56 tmp.53 tmp.48 rbp tmp-ra.54 r12))
         (tmp.53 (tmp.48 rbp tmp-ra.54 tmp.49 r12))
         (tmp.56 (tmp.48 rbp tmp-ra.54 tmp.49))
         (tmp.52 (tmp.48 rbp tmp-ra.54 tmp.49))
         (rdi (tmp-ra.54))
         (rsi (tmp.48 tmp-ra.54))
         (r12 (rbp tmp.53 tmp.49 tmp.48 tmp-ra.54))
         (rbp (rax tmp.52 tmp.56 tmp.53 r12 tmp.49 tmp.48 tmp-ra.54))
         (rax (rbp tmp-ra.54))))
       (assignment
        ((tmp-ra.54 r15)
         (tmp.48 r14)
         (tmp.49 r13)
         (tmp.53 r9)
         (tmp.56 r9)
         (tmp.52 r9))))
      (begin
        (set! tmp-ra.54 r15)
        (set! tmp.48 rdi)
        (set! tmp.49 rsi)
        (begin (set! tmp.53 r12) (set! r12 (+ r12 16)))
        (set! tmp.56 tmp.53)
        (set! tmp.56 (+ tmp.56 1))
        (set! tmp.52 tmp.56)
        (mset! tmp.52 -1 tmp.48)
        (mset! tmp.52 7 tmp.49)
        (set! rax tmp.52)
        (jump tmp-ra.54 rbp rax)))
    (begin
      (set! tmp-ra.55 r15)
      (set! ascii-char0.2 18222)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.6
          (begin
            (set! rsi 2272)
            (set! rdi 832)
            (set! r15 L.rp.6)
            (jump L.cons.5 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 16)))
      (set! pair1.1 rax)
      (set! rax ascii-char0.2)
      (jump tmp-ra.55 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.56 (rdi tmp.58 tmp.53 rbp))
       (tmp.53 (rbp tmp-ra.56))
       (tmp.58 (rbp tmp-ra.56))
       (rbp (r15 rdi tmp.58 tmp.53 tmp-ra.56))
       (rdi (r15 rbp tmp-ra.56))
       (r15 (rbp rdi))))
     (assignment ((tmp-ra.56 r15) (tmp.53 r14) (tmp.58 r14))))
    (define L.cons.6
      ((locals ())
       (conflicts
        ((tmp-ra.54 (rax tmp.51 tmp.57 tmp.52 tmp.48 tmp.47 rbp r12 rsi rdi))
         (tmp.47 (tmp.51 tmp.57 tmp.52 tmp.48 rbp tmp-ra.54 r12 rsi))
         (tmp.48 (tmp.51 tmp.57 tmp.52 tmp.47 rbp tmp-ra.54 r12))
         (tmp.52 (tmp.47 rbp tmp-ra.54 tmp.48 r12))
         (tmp.57 (tmp.47 rbp tmp-ra.54 tmp.48))
         (tmp.51 (tmp.47 rbp tmp-ra.54 tmp.48))
         (rdi (tmp-ra.54))
         (rsi (tmp.47 tmp-ra.54))
         (r12 (rbp tmp.52 tmp.48 tmp.47 tmp-ra.54))
         (rbp (rax tmp.51 tmp.57 tmp.52 r12 tmp.48 tmp.47 tmp-ra.54))
         (rax (rbp tmp-ra.54))))
       (assignment
        ((tmp-ra.54 r15)
         (tmp.47 r14)
         (tmp.48 r13)
         (tmp.52 r9)
         (tmp.57 r9)
         (tmp.51 r9))))
      (begin
        (set! tmp-ra.54 r15)
        (set! tmp.47 rdi)
        (set! tmp.48 rsi)
        (begin (set! tmp.52 r12) (set! r12 (+ r12 16)))
        (set! tmp.57 tmp.52)
        (set! tmp.57 (+ tmp.57 1))
        (set! tmp.51 tmp.57)
        (mset! tmp.51 -1 tmp.47)
        (mset! tmp.51 7 tmp.48)
        (set! rax tmp.51)
        (jump tmp-ra.54 rbp rax)))
    (define L.fun/pair8407.4
      ((locals ())
       (conflicts
        ((tmp-ra.55 (rsi oprand0.1 rbp rdi))
         (oprand0.1 (rbp tmp-ra.55))
         (rdi (r15 rbp rsi tmp-ra.55))
         (rbp (r15 rdi rsi oprand0.1 tmp-ra.55))
         (rsi (r15 rdi rbp tmp-ra.55))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.55 r15) (oprand0.1 r14))))
      (begin
        (set! tmp-ra.55 r15)
        (set! oprand0.1 rdi)
        (set! rsi 3872)
        (set! rdi 400)
        (set! r15 tmp-ra.55)
        (jump L.cons.6 rbp r15 rdi rsi)))
    (begin
      (set! tmp-ra.56 r15)
      (if (begin (set! tmp.58 14) (!= tmp.58 6))
        (set! tmp.53 17454)
        (set! tmp.53 17966))
      (set! rdi tmp.53)
      (set! r15 tmp-ra.56)
      (jump L.fun/pair8407.4 rbp r15 rdi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.52 (rax boolean1.1 fixnum0.2 rbp))
       (fixnum0.2 (rbp tmp-ra.52))
       (boolean1.1 (rbp tmp-ra.52))
       (rbp (rax boolean1.1 fixnum0.2 tmp-ra.52))
       (rax (rbp tmp-ra.52))))
     (assignment ((tmp-ra.52 r15) (fixnum0.2 r14) (boolean1.1 r14))))
    (begin
      (set! tmp-ra.52 r15)
      (set! fixnum0.2 1712)
      (set! boolean1.1 14)
      (set! rax 1864)
      (jump tmp-ra.52 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.52 (rax boolean1.1 error0.2 rbp))
       (error0.2 (rbp tmp-ra.52))
       (boolean1.1 (rbp tmp-ra.52))
       (rbp (rax boolean1.1 error0.2 tmp-ra.52))
       (rax (rbp tmp-ra.52))))
     (assignment ((tmp-ra.52 r15) (error0.2 r14) (boolean1.1 r14))))
    (begin
      (set! tmp-ra.52 r15)
      (set! error0.2 13118)
      (set! boolean1.1 14)
      (set! rax boolean1.1)
      (jump tmp-ra.52 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp.58 (rbp tmp-ra.64))
       (tmp-ra.64 (rbp tmp.58 rdi rsi tmp.59 rax))
       (tmp.59 (rbp tmp-ra.64))
       (rax (rbp tmp-ra.64))
       (rbp (tmp-ra.64 tmp.58 tmp.59 r15 rdi rsi rax))
       (rsi (tmp-ra.64 r15 rdi rbp))
       (rdi (tmp-ra.64 r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment ((tmp-ra.64 fv0) (tmp.58 r15) (tmp.59 r15))))
    (define L.cons.8
      ((locals ())
       (conflicts
        ((tmp-ra.60 (rax tmp.56 tmp.65 tmp.57 tmp.53 tmp.52 rbp r12 rsi rdi))
         (tmp.52 (tmp.56 tmp.65 tmp.57 tmp.53 rbp tmp-ra.60 r12 rsi))
         (tmp.53 (tmp.56 tmp.65 tmp.57 tmp.52 rbp tmp-ra.60 r12))
         (tmp.57 (tmp.52 rbp tmp-ra.60 tmp.53 r12))
         (tmp.65 (tmp.52 rbp tmp-ra.60 tmp.53))
         (tmp.56 (tmp.52 rbp tmp-ra.60 tmp.53))
         (rdi (tmp-ra.60))
         (rsi (tmp.52 tmp-ra.60))
         (r12 (rbp tmp.57 tmp.53 tmp.52 tmp-ra.60))
         (rbp (rax tmp.56 tmp.65 tmp.57 r12 tmp.53 tmp.52 tmp-ra.60))
         (rax (rbp tmp-ra.60))))
       (assignment
        ((tmp-ra.60 r15)
         (tmp.52 r14)
         (tmp.53 r13)
         (tmp.57 r9)
         (tmp.65 r9)
         (tmp.56 r9))))
      (begin
        (set! tmp-ra.60 r15)
        (set! tmp.52 rdi)
        (set! tmp.53 rsi)
        (begin (set! tmp.57 r12) (set! r12 (+ r12 16)))
        (set! tmp.65 tmp.57)
        (set! tmp.65 (+ tmp.65 1))
        (set! tmp.56 tmp.65)
        (mset! tmp.56 -1 tmp.52)
        (mset! tmp.56 7 tmp.53)
        (set! rax tmp.56)
        (jump tmp-ra.60 rbp rax)))
    (define L.fun/error8419.4
      ((locals ())
       (conflicts
        ((tmp-ra.61 (rax oprand1.1 oprand0.2 rbp rsi rdi))
         (oprand0.2 (rbp tmp-ra.61 rsi))
         (oprand1.1 (rbp tmp-ra.61))
         (rdi (tmp-ra.61))
         (rsi (oprand0.2 tmp-ra.61))
         (rbp (rax oprand1.1 oprand0.2 tmp-ra.61))
         (rax (rbp tmp-ra.61))))
       (assignment ((tmp-ra.61 r15) (oprand0.2 r14) (oprand1.1 r14))))
      (begin
        (set! tmp-ra.61 r15)
        (set! oprand0.2 rdi)
        (set! oprand1.1 rsi)
        (set! rax 47678)
        (jump tmp-ra.61 rbp rax)))
    (define L.fun/boolean8418.5
      ((locals ())
       (conflicts
        ((tmp-ra.62 (rax oprand1.3 oprand0.4 rbp rsi rdi))
         (oprand0.4 (rbp tmp-ra.62 rsi))
         (oprand1.3 (rbp tmp-ra.62))
         (rdi (tmp-ra.62))
         (rsi (oprand0.4 tmp-ra.62))
         (rbp (rax oprand1.3 oprand0.4 tmp-ra.62))
         (rax (rbp tmp-ra.62))))
       (assignment ((tmp-ra.62 r15) (oprand0.4 r14) (oprand1.3 r14))))
      (begin
        (set! tmp-ra.62 r15)
        (set! oprand0.4 rdi)
        (set! oprand1.3 rsi)
        (set! rax 6)
        (jump tmp-ra.62 rbp rax)))
    (define L.fun/error8420.6
      ((locals ())
       (conflicts
        ((tmp-ra.63 (rax oprand1.5 oprand0.6 rbp rsi rdi))
         (oprand0.6 (rbp tmp-ra.63 rsi))
         (oprand1.5 (rbp tmp-ra.63))
         (rdi (tmp-ra.63))
         (rsi (oprand0.6 tmp-ra.63))
         (rbp (rax oprand1.5 oprand0.6 tmp-ra.63))
         (rax (rbp tmp-ra.63))))
       (assignment ((tmp-ra.63 r15) (oprand0.6 r14) (oprand1.5 r14))))
      (begin
        (set! tmp-ra.63 r15)
        (set! oprand0.6 rdi)
        (set! oprand1.5 rsi)
        (set! rax 39998)
        (jump tmp-ra.63 rbp rax)))
    (begin
      (set! tmp-ra.64 r15)
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 8))
                (return-point L.rp.9
                  (begin
                    (set! rsi 456)
                    (set! rdi 14)
                    (set! r15 L.rp.9)
                    (jump L.fun/boolean8418.5 rbp r15 rdi rsi)))
                (set! rbp (+ rbp 8)))
              (set! tmp.58 rax))
            (!= tmp.58 6))
        (begin
          (set! rsi 22)
          (set! rdi 14)
          (set! r15 tmp-ra.64)
          (jump L.fun/error8419.4 rbp r15 rdi rsi))
        (begin
          (begin
            (set! rbp (- rbp 8))
            (return-point L.rp.10
              (begin
                (set! rsi 3240)
                (set! rdi 208)
                (set! r15 L.rp.10)
                (jump L.cons.8 rbp r15 rdi rsi)))
            (set! rbp (+ rbp 8)))
          (set! tmp.59 rax)
          (set! rsi tmp.59)
          (set! rdi 22)
          (set! r15 tmp-ra.64)
          (jump L.fun/error8420.6 rbp r15 rdi rsi))))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.64 (rdi rsi pair2.1 error1.2 ascii-char0.3 rax rbp))
       (ascii-char0.3 (rbp tmp-ra.64))
       (error1.2 (rbp tmp-ra.64))
       (pair2.1 (rbp tmp-ra.64))
       (rbp (rdi rsi pair2.1 error1.2 ascii-char0.3 r15 rax tmp-ra.64))
       (rax (rbp tmp-ra.64))
       (r15 (rdi rsi rbp))
       (rsi (r15 rdi rbp tmp-ra.64))
       (rdi (r15 rbp rsi tmp-ra.64))))
     (assignment
      ((tmp-ra.64 fv0) (ascii-char0.3 r15) (error1.2 r15) (pair2.1 r15))))
    (define L.+.9
      ((locals ())
       (conflicts
        ((tmp.54 (rbp tmp-ra.59 tmp.20 tmp.19))
         (tmp.65 (tmp.20 rbp tmp-ra.59 tmp.19))
         (tmp.20
          (rbp
           tmp-ra.59
           tmp.19
           tmp.65
           tmp.55
           tmp.54
           tmp.66
           tmp.57
           tmp.56
           tmp.67))
         (tmp.55 (rbp tmp-ra.59 tmp.20 tmp.19))
         (tmp-ra.59
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.65
           tmp.55
           tmp.54
           tmp.66
           tmp.57
           tmp.56
           tmp.67
           rax))
         (tmp.67 (rbp tmp-ra.59 tmp.20))
         (tmp.57 (rbp tmp-ra.59 tmp.20 tmp.19))
         (tmp.19
          (tmp.20 rbp tmp-ra.59 rsi tmp.65 tmp.55 tmp.54 tmp.66 tmp.57 tmp.56))
         (tmp.66 (tmp.19 rbp tmp-ra.59 tmp.20))
         (tmp.56 (rbp tmp-ra.59 tmp.20 tmp.19))
         (rax (rbp tmp-ra.59))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.59
           tmp.65
           tmp.55
           tmp.54
           tmp.66
           tmp.57
           tmp.56
           tmp.67
           rax))
         (rdi (tmp-ra.59))
         (rsi (tmp.19 tmp-ra.59))))
       (assignment
        ((tmp-ra.59 r15)
         (tmp.20 r14)
         (tmp.19 r13)
         (tmp.54 r9)
         (tmp.65 r9)
         (tmp.55 r9)
         (tmp.57 r9)
         (tmp.66 r9)
         (tmp.56 r9)
         (tmp.67 r13))))
      (begin
        (set! tmp-ra.59 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.65 tmp.20)
                      (set! tmp.65 (bitwise-and tmp.65 7))
                      (set! tmp.55 tmp.65))
                    (= tmp.55 0))
                (set! tmp.54 14)
                (set! tmp.54 6))
              (!= tmp.54 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.66 tmp.19)
                        (set! tmp.66 (bitwise-and tmp.66 7))
                        (set! tmp.57 tmp.66))
                      (= tmp.57 0))
                  (set! tmp.56 14)
                  (set! tmp.56 6))
                (!= tmp.56 6))
            (begin
              (set! tmp.67 tmp.19)
              (set! tmp.67 (+ tmp.67 tmp.20))
              (set! rax tmp.67)
              (jump tmp-ra.59 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.59 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.59 rbp rax)))))
    (define L.cons.8
      ((locals ())
       (conflicts
        ((tmp-ra.60 (rax tmp.53 tmp.68 tmp.58 tmp.50 tmp.49 rbp r12 rsi rdi))
         (tmp.49 (tmp.53 tmp.68 tmp.58 tmp.50 rbp tmp-ra.60 r12 rsi))
         (tmp.50 (tmp.53 tmp.68 tmp.58 tmp.49 rbp tmp-ra.60 r12))
         (tmp.58 (tmp.49 rbp tmp-ra.60 tmp.50 r12))
         (tmp.68 (tmp.49 rbp tmp-ra.60 tmp.50))
         (tmp.53 (tmp.49 rbp tmp-ra.60 tmp.50))
         (rdi (tmp-ra.60))
         (rsi (tmp.49 tmp-ra.60))
         (r12 (rbp tmp.58 tmp.50 tmp.49 tmp-ra.60))
         (rbp (rax tmp.53 tmp.68 tmp.58 r12 tmp.50 tmp.49 tmp-ra.60))
         (rax (rbp tmp-ra.60))))
       (assignment
        ((tmp-ra.60 r15)
         (tmp.49 r14)
         (tmp.50 r13)
         (tmp.58 r9)
         (tmp.68 r9)
         (tmp.53 r9))))
      (begin
        (set! tmp-ra.60 r15)
        (set! tmp.49 rdi)
        (set! tmp.50 rsi)
        (begin (set! tmp.58 r12) (set! r12 (+ r12 16)))
        (set! tmp.68 tmp.58)
        (set! tmp.68 (+ tmp.68 1))
        (set! tmp.53 tmp.68)
        (mset! tmp.53 -1 tmp.49)
        (mset! tmp.53 7 tmp.50)
        (set! rax tmp.53)
        (jump tmp-ra.60 rbp rax)))
    (define L.fun/ascii-char8439.4
      ((locals ())
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ((tmp-ra.61 r15))))
      (begin (set! tmp-ra.61 r15) (set! rax 22318) (jump tmp-ra.61 rbp rax)))
    (define L.fun/error8440.5
      ((locals ())
       (conflicts
        ((tmp-ra.62 (rax rbp)) (rbp (rax tmp-ra.62)) (rax (rbp tmp-ra.62))))
       (assignment ((tmp-ra.62 r15))))
      (begin (set! tmp-ra.62 r15) (set! rax 4670) (jump tmp-ra.62 rbp rax)))
    (define L.fun/pair8441.6
      ((locals ())
       (conflicts
        ((tmp-ra.63 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.63))
         (rsi (r15 rdi rbp tmp-ra.63))
         (rdi (r15 rbp rsi tmp-ra.63))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.63 r15))))
      (begin
        (set! tmp-ra.63 r15)
        (set! rsi 2392)
        (set! rdi 704)
        (set! r15 tmp-ra.63)
        (jump L.cons.8 rbp r15 rdi rsi)))
    (begin
      (set! tmp-ra.64 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char8439.4 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char0.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/error8440.5 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error1.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/pair8441.6 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! pair2.1 rax)
      (set! rsi 1064)
      (set! rdi 2024)
      (set! r15 tmp-ra.64)
      (jump L.+.9 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.62 (rdi rsi tmp.66 tmp.57 tmp.55 rax tmp.65 tmp.56 rbp))
       (tmp.56 (rbp tmp-ra.62))
       (tmp.65 (rbp tmp-ra.62))
       (tmp.55 (rsi tmp.66 tmp.57 rbp tmp-ra.62))
       (tmp.57 (rbp tmp-ra.62 tmp.55))
       (tmp.66 (rbp tmp-ra.62 tmp.55))
       (rbp (rsi tmp.66 tmp.57 tmp.55 r15 rdi rax tmp.65 tmp.56 tmp-ra.62))
       (rax (rbp tmp-ra.62))
       (rdi (rsi tmp-ra.62 r15 rbp))
       (r15 (rsi rbp rdi))
       (rsi (r15 rdi rbp tmp-ra.62 tmp.55))))
     (assignment
      ((tmp-ra.62 fv0)
       (tmp.55 r15)
       (tmp.57 r14)
       (tmp.66 r14)
       (tmp.56 r15)
       (tmp.65 r15))))
    (define L.empty?.8
      ((locals ())
       (conflicts
        ((tmp.53 (rbp tmp-ra.58))
         (tmp.41 (rbp tmp-ra.58))
         (tmp.63 (rbp tmp-ra.58))
         (tmp-ra.58 (tmp.41 rbp rdi tmp.63 tmp.53 rax))
         (rax (rbp tmp-ra.58))
         (rbp (tmp.41 tmp-ra.58 tmp.63 tmp.53 rax))
         (rdi (tmp-ra.58))))
       (assignment ((tmp-ra.58 r15) (tmp.53 r14) (tmp.41 r14) (tmp.63 r14))))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.41 rdi)
        (if (begin
              (begin
                (set! tmp.63 tmp.41)
                (set! tmp.63 (bitwise-and tmp.63 255))
                (set! tmp.53 tmp.63))
              (= tmp.53 22))
          (begin (set! rax 14) (jump tmp-ra.58 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.58 rbp rax)))))
    (define L.cons.7
      ((locals ())
       (conflicts
        ((tmp-ra.59 (rax tmp.52 tmp.64 tmp.54 tmp.49 tmp.48 rbp r12 rsi rdi))
         (tmp.48 (tmp.52 tmp.64 tmp.54 tmp.49 rbp tmp-ra.59 r12 rsi))
         (tmp.49 (tmp.52 tmp.64 tmp.54 tmp.48 rbp tmp-ra.59 r12))
         (tmp.54 (tmp.48 rbp tmp-ra.59 tmp.49 r12))
         (tmp.64 (tmp.48 rbp tmp-ra.59 tmp.49))
         (tmp.52 (tmp.48 rbp tmp-ra.59 tmp.49))
         (rdi (tmp-ra.59))
         (rsi (tmp.48 tmp-ra.59))
         (r12 (rbp tmp.54 tmp.49 tmp.48 tmp-ra.59))
         (rbp (rax tmp.52 tmp.64 tmp.54 r12 tmp.49 tmp.48 tmp-ra.59))
         (rax (rbp tmp-ra.59))))
       (assignment
        ((tmp-ra.59 r15)
         (tmp.48 r14)
         (tmp.49 r13)
         (tmp.54 r9)
         (tmp.64 r9)
         (tmp.52 r9))))
      (begin
        (set! tmp-ra.59 r15)
        (set! tmp.48 rdi)
        (set! tmp.49 rsi)
        (begin (set! tmp.54 r12) (set! r12 (+ r12 16)))
        (set! tmp.64 tmp.54)
        (set! tmp.64 (+ tmp.64 1))
        (set! tmp.52 tmp.64)
        (mset! tmp.52 -1 tmp.48)
        (mset! tmp.52 7 tmp.49)
        (set! rax tmp.52)
        (jump tmp-ra.59 rbp rax)))
    (define L.fun/pair8459.4
      ((locals ())
       (conflicts
        ((tmp-ra.60 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.60))
         (rsi (r15 rdi rbp tmp-ra.60))
         (rdi (r15 rbp rsi tmp-ra.60))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.60 r15))))
      (begin
        (set! tmp-ra.60 r15)
        (set! rsi 2824)
        (set! rdi 704)
        (set! r15 tmp-ra.60)
        (jump L.cons.7 rbp r15 rdi rsi)))
    (define L.fun/pair8458.5
      ((locals ())
       (conflicts
        ((tmp-ra.61 (oprand1.1 oprand0.2 rbp rsi rdi))
         (oprand0.2 (rbp tmp-ra.61 rsi))
         (oprand1.1 (rbp tmp-ra.61))
         (rdi (tmp-ra.61))
         (rsi (oprand0.2 tmp-ra.61))
         (rbp (r15 oprand1.1 oprand0.2 tmp-ra.61))
         (r15 (rbp))))
       (assignment ((tmp-ra.61 r15) (oprand0.2 r14) (oprand1.1 r14))))
      (begin
        (set! tmp-ra.61 r15)
        (set! oprand0.2 rdi)
        (set! oprand1.1 rsi)
        (set! r15 tmp-ra.61)
        (jump L.fun/pair8459.4 rbp r15)))
    (begin
      (set! tmp-ra.62 r15)
      (if (begin (set! tmp.65 6) (!= tmp.65 6))
        (set! tmp.56 54078)
        (set! tmp.56 38718))
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.9
          (begin
            (set! rdi tmp.56)
            (set! r15 L.rp.9)
            (jump L.empty?.8 rbp r15 rdi)))
        (set! rbp (+ rbp 8)))
      (set! tmp.55 rax)
      (if (begin (set! tmp.66 6) (!= tmp.66 6))
        (set! tmp.57 30)
        (set! tmp.57 30))
      (set! rsi tmp.57)
      (set! rdi tmp.55)
      (set! r15 tmp-ra.62)
      (jump L.fun/pair8458.5 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.58 (boolean2.1 ascii-char1.2 ascii-char0.3 rax rbp))
       (ascii-char0.3 (rbp tmp-ra.58))
       (ascii-char1.2 (rbp tmp-ra.58))
       (boolean2.1 (rbp tmp-ra.58))
       (rbp (boolean2.1 rdi ascii-char1.2 ascii-char0.3 r15 rax tmp-ra.58))
       (rax (rbp tmp-ra.58))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment
      ((tmp-ra.58 fv0)
       (ascii-char0.3 r15)
       (ascii-char1.2 r15)
       (boolean2.1 r15))))
    (define L.pair?.8
      ((locals ())
       (conflicts
        ((tmp.53 (rbp tmp-ra.54))
         (tmp.46 (rbp tmp-ra.54))
         (tmp.59 (rbp tmp-ra.54))
         (tmp-ra.54 (tmp.46 rbp rdi tmp.59 tmp.53 rax))
         (rax (rbp tmp-ra.54))
         (rbp (tmp.46 tmp-ra.54 tmp.59 tmp.53 rax))
         (rdi (tmp-ra.54))))
       (assignment ((tmp-ra.54 r15) (tmp.53 r14) (tmp.46 r14) (tmp.59 r14))))
      (begin
        (set! tmp-ra.54 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.59 tmp.46)
                (set! tmp.59 (bitwise-and tmp.59 7))
                (set! tmp.53 tmp.59))
              (= tmp.53 1))
          (begin (set! rax 14) (jump tmp-ra.54 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.54 rbp rax)))))
    (define L.fun/ascii-char8463.4
      ((locals ())
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55))))
       (assignment ((tmp-ra.55 r15))))
      (begin (set! tmp-ra.55 r15) (set! rax 22574) (jump tmp-ra.55 rbp rax)))
    (define L.fun/ascii-char8462.5
      ((locals ())
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56))))
       (assignment ((tmp-ra.56 r15))))
      (begin (set! tmp-ra.56 r15) (set! rax 10286) (jump tmp-ra.56 rbp rax)))
    (define L.fun/error8464.6
      ((locals ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57))))
       (assignment ((tmp-ra.57 r15))))
      (begin (set! tmp-ra.57 r15) (set! rax 5694) (jump tmp-ra.57 rbp rax)))
    (begin
      (set! tmp-ra.58 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.9
          (begin (set! r15 L.rp.9) (jump L.fun/ascii-char8462.5 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char0.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char8463.4 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char1.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin
            (set! rdi 14)
            (set! r15 L.rp.11)
            (jump L.pair?.8 rbp r15 rdi)))
        (set! rbp (+ rbp 8)))
      (set! boolean2.1 rax)
      (set! r15 tmp-ra.58)
      (jump L.fun/error8464.6 rbp r15))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((boolean0.3 (boolean2.1 fixnum1.2 rbp tmp-ra.56))
       (fixnum1.2 (rbp tmp-ra.56 boolean0.3))
       (boolean2.1 (rbp tmp-ra.56 boolean0.3))
       (error2.4 (rbp tmp-ra.56 fixnum0.6))
       (boolean1.5 (rbp tmp-ra.56 fixnum0.6))
       (fixnum0.6 (error2.4 boolean1.5 rbp tmp-ra.56))
       (tmp-ra.56
        (rbp
         boolean2.1
         fixnum1.2
         boolean0.3
         error2.4
         boolean1.5
         fixnum0.6
         tmp.57
         rax))
       (tmp.57 (rbp tmp-ra.56))
       (rax (rbp tmp-ra.56))
       (rbp
        (tmp-ra.56
         boolean2.1
         fixnum1.2
         boolean0.3
         error2.4
         boolean1.5
         fixnum0.6
         tmp.57
         rax))))
     (assignment
      ((tmp-ra.56 r15)
       (boolean0.3 r14)
       (fixnum0.6 r14)
       (fixnum1.2 r13)
       (boolean2.1 r13)
       (error2.4 r13)
       (boolean1.5 r13)
       (tmp.57 r14))))
    (begin
      (set! tmp-ra.56 r15)
      (if (begin
            (set! boolean0.3 6)
            (set! fixnum1.2 1448)
            (set! boolean2.1 6)
            (!= boolean0.3 6))
        (begin
          (set! fixnum0.6 1104)
          (set! boolean1.5 14)
          (set! error2.4 64318)
          (set! rax fixnum0.6)
          (jump tmp-ra.56 rbp rax))
        (if (begin (set! tmp.57 14) (!= tmp.57 6))
          (begin (set! rax 416) (jump tmp-ra.56 rbp rax))
          (begin (set! rax 664) (jump tmp-ra.56 rbp rax)))))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.61 (empty3.1 void2.2 pair1.3 empty0.4 rax rbp))
       (empty0.4 (rbp tmp-ra.61))
       (pair1.3 (empty3.1 void2.2 rax rbp tmp-ra.61))
       (void2.2 (rbp tmp-ra.61 pair1.3))
       (empty3.1 (rbp tmp-ra.61 pair1.3))
       (rbp (empty3.1 void2.2 pair1.3 empty0.4 r15 rax tmp-ra.61))
       (rax (pair1.3 rbp tmp-ra.61))
       (r15 (rbp))))
     (assignment
      ((tmp-ra.61 fv0)
       (pair1.3 fv1)
       (void2.2 r15)
       (empty3.1 r15)
       (empty0.4 r15))))
    (define L.cons.9
      ((locals ())
       (conflicts
        ((tmp-ra.56 (rax tmp.54 tmp.62 tmp.55 tmp.51 tmp.50 rbp r12 rsi rdi))
         (tmp.50 (tmp.54 tmp.62 tmp.55 tmp.51 rbp tmp-ra.56 r12 rsi))
         (tmp.51 (tmp.54 tmp.62 tmp.55 tmp.50 rbp tmp-ra.56 r12))
         (tmp.55 (tmp.50 rbp tmp-ra.56 tmp.51 r12))
         (tmp.62 (tmp.50 rbp tmp-ra.56 tmp.51))
         (tmp.54 (tmp.50 rbp tmp-ra.56 tmp.51))
         (rdi (tmp-ra.56))
         (rsi (tmp.50 tmp-ra.56))
         (r12 (rbp tmp.55 tmp.51 tmp.50 tmp-ra.56))
         (rbp (rax tmp.54 tmp.62 tmp.55 r12 tmp.51 tmp.50 tmp-ra.56))
         (rax (rbp tmp-ra.56))))
       (assignment
        ((tmp-ra.56 r15)
         (tmp.50 r14)
         (tmp.51 r13)
         (tmp.55 r9)
         (tmp.62 r9)
         (tmp.54 r9))))
      (begin
        (set! tmp-ra.56 r15)
        (set! tmp.50 rdi)
        (set! tmp.51 rsi)
        (begin (set! tmp.55 r12) (set! r12 (+ r12 16)))
        (set! tmp.62 tmp.55)
        (set! tmp.62 (+ tmp.62 1))
        (set! tmp.54 tmp.62)
        (mset! tmp.54 -1 tmp.50)
        (mset! tmp.54 7 tmp.51)
        (set! rax tmp.54)
        (jump tmp-ra.56 rbp rax)))
    (define L.fun/void8484.4
      ((locals ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57))))
       (assignment ((tmp-ra.57 r15))))
      (begin (set! tmp-ra.57 r15) (set! rax 30) (jump tmp-ra.57 rbp rax)))
    (define L.fun/empty8485.5
      ((locals ())
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ((tmp-ra.58 r15))))
      (begin (set! tmp-ra.58 r15) (set! rax 22) (jump tmp-ra.58 rbp rax)))
    (define L.fun/pair8483.6
      ((locals ())
       (conflicts
        ((tmp-ra.59 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.59))
         (rsi (r15 rdi rbp tmp-ra.59))
         (rdi (r15 rbp rsi tmp-ra.59))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.59 r15))))
      (begin
        (set! tmp-ra.59 r15)
        (set! rsi 2640)
        (set! rdi 712)
        (set! r15 tmp-ra.59)
        (jump L.cons.9 rbp r15 rdi rsi)))
    (define L.fun/empty8482.7
      ((locals ())
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60))))
       (assignment ((tmp-ra.60 r15))))
      (begin (set! tmp-ra.60 r15) (set! rax 22) (jump tmp-ra.60 rbp rax)))
    (begin
      (set! tmp-ra.61 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/empty8482.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty0.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/pair8483.6 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! pair1.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void8484.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void2.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty8485.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty3.1 rax)
      (set! rax pair1.3)
      (jump tmp-ra.61 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.79 (void3.1 pair2.2 void1.3 fixnum0.4 tmp.70 tmp.69 rax rbp))
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.79))
       (tmp.70 (rbp tmp-ra.79 tmp.69))
       (fixnum0.4 (rbp tmp-ra.79))
       (void1.3 (rbp tmp-ra.79))
       (pair2.2 (rbp tmp-ra.79))
       (void3.1 (rbp tmp-ra.79))
       (rbp
        (void3.1
         pair2.2
         void1.3
         fixnum0.4
         tmp.70
         tmp.69
         r15
         rdi
         rsi
         rax
         tmp-ra.79))
       (rax (tmp.69 rbp tmp-ra.79))
       (rsi (tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.79 fv0)
       (tmp.69 fv1)
       (tmp.70 r15)
       (fixnum0.4 r15)
       (void1.3 r15)
       (pair2.2 r15)
       (void3.1 r15))))
    (define L.+.12
      ((locals ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.71 tmp.21 tmp.20))
         (tmp.80 (tmp.21 rbp tmp-ra.71 tmp.20))
         (tmp.21
          (rbp
           tmp-ra.71
           tmp.20
           tmp.80
           tmp.56
           tmp.55
           tmp.81
           tmp.58
           tmp.57
           tmp.82))
         (tmp.56 (rbp tmp-ra.71 tmp.21 tmp.20))
         (tmp-ra.71
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.80
           tmp.56
           tmp.55
           tmp.81
           tmp.58
           tmp.57
           tmp.82
           rax))
         (tmp.82 (rbp tmp-ra.71 tmp.21))
         (tmp.58 (rbp tmp-ra.71 tmp.21 tmp.20))
         (tmp.20
          (tmp.21 rbp tmp-ra.71 rsi tmp.80 tmp.56 tmp.55 tmp.81 tmp.58 tmp.57))
         (tmp.81 (tmp.20 rbp tmp-ra.71 tmp.21))
         (tmp.57 (rbp tmp-ra.71 tmp.21 tmp.20))
         (rax (rbp tmp-ra.71))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.71
           tmp.80
           tmp.56
           tmp.55
           tmp.81
           tmp.58
           tmp.57
           tmp.82
           rax))
         (rdi (tmp-ra.71))
         (rsi (tmp.20 tmp-ra.71))))
       (assignment
        ((tmp-ra.71 r15)
         (tmp.21 r14)
         (tmp.20 r13)
         (tmp.55 r9)
         (tmp.80 r9)
         (tmp.56 r9)
         (tmp.58 r9)
         (tmp.81 r9)
         (tmp.57 r9)
         (tmp.82 r13))))
      (begin
        (set! tmp-ra.71 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.80 tmp.21)
                      (set! tmp.80 (bitwise-and tmp.80 7))
                      (set! tmp.56 tmp.80))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.81 tmp.20)
                        (set! tmp.81 (bitwise-and tmp.81 7))
                        (set! tmp.58 tmp.81))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.82 tmp.20)
              (set! tmp.82 (+ tmp.82 tmp.21))
              (set! rax tmp.82)
              (jump tmp-ra.71 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.71 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.71 rbp rax)))))
    (define L.-.11
      ((locals ())
       (conflicts
        ((tmp.59 (rbp tmp-ra.72 tmp.23 tmp.22))
         (tmp.83 (tmp.23 rbp tmp-ra.72 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.72
           tmp.22
           tmp.83
           tmp.60
           tmp.59
           tmp.84
           tmp.62
           tmp.61
           tmp.85))
         (tmp.60 (rbp tmp-ra.72 tmp.23 tmp.22))
         (tmp-ra.72
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.83
           tmp.60
           tmp.59
           tmp.84
           tmp.62
           tmp.61
           tmp.85
           rax))
         (tmp.85 (rbp tmp-ra.72 tmp.23))
         (tmp.62 (rbp tmp-ra.72 tmp.23 tmp.22))
         (tmp.22
          (tmp.23 rbp tmp-ra.72 rsi tmp.83 tmp.60 tmp.59 tmp.84 tmp.62 tmp.61))
         (tmp.84 (tmp.22 rbp tmp-ra.72 tmp.23))
         (tmp.61 (rbp tmp-ra.72 tmp.23 tmp.22))
         (rax (rbp tmp-ra.72))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.72
           tmp.83
           tmp.60
           tmp.59
           tmp.84
           tmp.62
           tmp.61
           tmp.85
           rax))
         (rdi (tmp-ra.72))
         (rsi (tmp.22 tmp-ra.72))))
       (assignment
        ((tmp-ra.72 r15)
         (tmp.23 r14)
         (tmp.22 r13)
         (tmp.59 r9)
         (tmp.83 r9)
         (tmp.60 r9)
         (tmp.62 r9)
         (tmp.84 r9)
         (tmp.61 r9)
         (tmp.85 r13))))
      (begin
        (set! tmp-ra.72 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.83 tmp.23)
                      (set! tmp.83 (bitwise-and tmp.83 7))
                      (set! tmp.60 tmp.83))
                    (= tmp.60 0))
                (set! tmp.59 14)
                (set! tmp.59 6))
              (!= tmp.59 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.84 tmp.22)
                        (set! tmp.84 (bitwise-and tmp.84 7))
                        (set! tmp.62 tmp.84))
                      (= tmp.62 0))
                  (set! tmp.61 14)
                  (set! tmp.61 6))
                (!= tmp.61 6))
            (begin
              (set! tmp.85 tmp.22)
              (set! tmp.85 (- tmp.85 tmp.23))
              (set! rax tmp.85)
              (jump tmp-ra.72 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.72 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.72 rbp rax)))))
    (define L.*.10
      ((locals ())
       (conflicts
        ((tmp.63 (rbp tmp-ra.73 tmp.18 tmp.19))
         (tmp.86 (tmp.19 rbp tmp-ra.73 tmp.18))
         (tmp.19
          (rbp tmp-ra.73 tmp.18 tmp.86 tmp.64 tmp.63 tmp.87 tmp.66 tmp.65))
         (tmp.64 (rbp tmp-ra.73 tmp.18 tmp.19))
         (tmp-ra.73
          (tmp.19
           tmp.18
           rbp
           rsi
           rdi
           tmp.86
           tmp.64
           tmp.63
           tmp.87
           tmp.66
           tmp.65
           tmp.89
           tmp.67
           tmp.88
           rax))
         (tmp.88 (rbp tmp-ra.73 tmp.18))
         (tmp.67 (tmp.89 rbp tmp-ra.73 tmp.18))
         (tmp.89 (rbp tmp-ra.73 tmp.67))
         (tmp.66 (rbp tmp-ra.73 tmp.18 tmp.19))
         (tmp.18
          (tmp.19
           rbp
           tmp-ra.73
           rsi
           tmp.86
           tmp.64
           tmp.63
           tmp.87
           tmp.66
           tmp.65
           tmp.67
           tmp.88))
         (tmp.87 (tmp.18 rbp tmp-ra.73 tmp.19))
         (tmp.65 (rbp tmp-ra.73 tmp.18 tmp.19))
         (rax (rbp tmp-ra.73))
         (rbp
          (tmp.19
           tmp.18
           tmp-ra.73
           tmp.86
           tmp.64
           tmp.63
           tmp.87
           tmp.66
           tmp.65
           tmp.89
           tmp.67
           tmp.88
           rax))
         (rdi (tmp-ra.73))
         (rsi (tmp.18 tmp-ra.73))))
       (assignment
        ((tmp-ra.73 r15)
         (tmp.18 r14)
         (tmp.19 r13)
         (tmp.63 r9)
         (tmp.86 r9)
         (tmp.64 r9)
         (tmp.67 r13)
         (tmp.66 r9)
         (tmp.87 r9)
         (tmp.65 r9)
         (tmp.88 r13)
         (tmp.89 r14))))
      (begin
        (set! tmp-ra.73 r15)
        (set! tmp.18 rdi)
        (set! tmp.19 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.86 tmp.19)
                      (set! tmp.86 (bitwise-and tmp.86 7))
                      (set! tmp.64 tmp.86))
                    (= tmp.64 0))
                (set! tmp.63 14)
                (set! tmp.63 6))
              (!= tmp.63 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.87 tmp.18)
                        (set! tmp.87 (bitwise-and tmp.87 7))
                        (set! tmp.66 tmp.87))
                      (= tmp.66 0))
                  (set! tmp.65 14)
                  (set! tmp.65 6))
                (!= tmp.65 6))
            (begin
              (set! tmp.88 tmp.19)
              (set! tmp.88 (arithmetic-shift-right tmp.88 3))
              (set! tmp.67 tmp.88)
              (set! tmp.89 tmp.18)
              (set! tmp.89 (* tmp.89 tmp.67))
              (set! rax tmp.89)
              (jump tmp-ra.73 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.73 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.73 rbp rax)))))
    (define L.cons.9
      ((locals ())
       (conflicts
        ((tmp-ra.74 (rax tmp.54 tmp.90 tmp.68 tmp.51 tmp.50 rbp r12 rsi rdi))
         (tmp.50 (tmp.54 tmp.90 tmp.68 tmp.51 rbp tmp-ra.74 r12 rsi))
         (tmp.51 (tmp.54 tmp.90 tmp.68 tmp.50 rbp tmp-ra.74 r12))
         (tmp.68 (tmp.50 rbp tmp-ra.74 tmp.51 r12))
         (tmp.90 (tmp.50 rbp tmp-ra.74 tmp.51))
         (tmp.54 (tmp.50 rbp tmp-ra.74 tmp.51))
         (rdi (tmp-ra.74))
         (rsi (tmp.50 tmp-ra.74))
         (r12 (rbp tmp.68 tmp.51 tmp.50 tmp-ra.74))
         (rbp (rax tmp.54 tmp.90 tmp.68 r12 tmp.51 tmp.50 tmp-ra.74))
         (rax (rbp tmp-ra.74))))
       (assignment
        ((tmp-ra.74 r15)
         (tmp.50 r14)
         (tmp.51 r13)
         (tmp.68 r9)
         (tmp.90 r9)
         (tmp.54 r9))))
      (begin
        (set! tmp-ra.74 r15)
        (set! tmp.50 rdi)
        (set! tmp.51 rsi)
        (begin (set! tmp.68 r12) (set! r12 (+ r12 16)))
        (set! tmp.90 tmp.68)
        (set! tmp.90 (+ tmp.90 1))
        (set! tmp.54 tmp.90)
        (mset! tmp.54 -1 tmp.50)
        (mset! tmp.54 7 tmp.51)
        (set! rax tmp.54)
        (jump tmp-ra.74 rbp rax)))
    (define L.fun/error8501.4
      ((locals ())
       (conflicts
        ((tmp-ra.75 (rax rbp)) (rbp (rax tmp-ra.75)) (rax (rbp tmp-ra.75))))
       (assignment ((tmp-ra.75 r15))))
      (begin (set! tmp-ra.75 r15) (set! rax 1342) (jump tmp-ra.75 rbp rax)))
    (define L.fun/pair8499.5
      ((locals ())
       (conflicts
        ((tmp-ra.76 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.76))
         (rsi (r15 rdi rbp tmp-ra.76))
         (rdi (r15 rbp rsi tmp-ra.76))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.76 r15))))
      (begin
        (set! tmp-ra.76 r15)
        (set! rsi 2072)
        (set! rdi 592)
        (set! r15 tmp-ra.76)
        (jump L.cons.9 rbp r15 rdi rsi)))
    (define L.fun/void8500.6
      ((locals ())
       (conflicts
        ((tmp-ra.77 (rax rbp)) (rbp (rax tmp-ra.77)) (rax (rbp tmp-ra.77))))
       (assignment ((tmp-ra.77 r15))))
      (begin (set! tmp-ra.77 r15) (set! rax 30) (jump tmp-ra.77 rbp rax)))
    (define L.fun/void8498.7
      ((locals ())
       (conflicts
        ((tmp-ra.78 (rax rbp)) (rbp (rax tmp-ra.78)) (rax (rbp tmp-ra.78))))
       (assignment ((tmp-ra.78 r15))))
      (begin (set! tmp-ra.78 r15) (set! rax 30) (jump tmp-ra.78 rbp rax)))
    (begin
      (set! tmp-ra.79 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin
            (set! rsi 1784)
            (set! rdi 1400)
            (set! r15 L.rp.13)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 16)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin
            (set! rsi 2024)
            (set! rdi 1776)
            (set! r15 L.rp.14)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 16)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.15
          (begin
            (set! rsi tmp.70)
            (set! rdi tmp.69)
            (set! r15 L.rp.15)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 16)))
      (set! fixnum0.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void8498.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void1.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/pair8499.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! pair2.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void8500.6 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void3.1 rax)
      (set! r15 tmp-ra.79)
      (jump L.fun/error8501.4 rbp r15))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.81
        (rdi
         rsi
         rdx
         tmp.74
         tmp.87
         tmp.88
         tmp.73
         tmp.72
         tmp.71
         tmp.85
         tmp.86
         tmp.70
         error3.13
         empty2.14
         void1.15
         ascii-char0.16
         tmp.84
         rax
         tmp.69
         rbp))
       (tmp.69
        (rsi
         rdx
         tmp.74
         tmp.87
         tmp.88
         tmp.73
         tmp.72
         rax
         tmp.71
         tmp.85
         tmp.86
         tmp.70
         rbp
         tmp-ra.81))
       (error3.13 (rbp tmp-ra.81))
       (empty2.14 (rbp tmp-ra.81))
       (void1.15 (rbp tmp-ra.81))
       (ascii-char0.16 (rbp tmp-ra.81))
       (tmp.84 (rbp tmp-ra.81))
       (tmp.86 (rbp tmp-ra.81 tmp.69))
       (tmp.85 (rbp tmp-ra.81 tmp.69))
       (tmp.70 (rdx rax tmp.74 tmp.87 tmp.88 tmp.73 rbp tmp-ra.81 tmp.69))
       (tmp.72 (rbp tmp-ra.81 tmp.69))
       (tmp.71 (rbp tmp-ra.81 tmp.69))
       (tmp.88 (rbp tmp-ra.81 tmp.69 tmp.70))
       (tmp.87 (rbp tmp-ra.81 tmp.69 tmp.70))
       (tmp.73 (rbp tmp-ra.81 tmp.69 tmp.70))
       (tmp.74 (rbp tmp-ra.81 tmp.69 tmp.70))
       (rbp
        (tmp.74
         tmp.87
         tmp.88
         tmp.73
         tmp.72
         tmp.71
         tmp.85
         tmp.86
         tmp.70
         error3.13
         empty2.14
         void1.15
         ascii-char0.16
         tmp.84
         r15
         rdi
         rsi
         rdx
         rax
         tmp.69
         tmp-ra.81))
       (rax (tmp.70 tmp.69 rbp tmp-ra.81))
       (rdx (tmp-ra.81 tmp.69 tmp.70 r15 rdi rsi rbp))
       (rsi (tmp-ra.81 tmp.69 r15 rdi rbp rdx))
       (rdi (tmp-ra.81 r15 rbp rsi rdx))
       (r15 (rbp rdi rsi rdx))))
     (assignment
      ((tmp-ra.81 fv0)
       (tmp.69 fv1)
       (tmp.70 fv2)
       (tmp.88 r15)
       (tmp.87 r15)
       (tmp.73 r15)
       (tmp.74 r15)
       (tmp.86 r15)
       (tmp.85 r15)
       (tmp.72 r15)
       (tmp.71 r15)
       (error3.13 r15)
       (empty2.14 r15)
       (void1.15 r15)
       (ascii-char0.16 r15)
       (tmp.84 r15))))
    (define L.pair?.10
      ((locals ())
       (conflicts
        ((tmp.67 (rbp tmp-ra.75))
         (tmp.59 (rbp tmp-ra.75))
         (tmp.82 (rbp tmp-ra.75))
         (tmp-ra.75 (tmp.59 rbp rdi tmp.82 tmp.67 rax))
         (rax (rbp tmp-ra.75))
         (rbp (tmp.59 tmp-ra.75 tmp.82 tmp.67 rax))
         (rdi (tmp-ra.75))))
       (assignment ((tmp-ra.75 r15) (tmp.67 r14) (tmp.59 r14) (tmp.82 r14))))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.59 rdi)
        (if (begin
              (begin
                (set! tmp.82 tmp.59)
                (set! tmp.82 (bitwise-and tmp.82 7))
                (set! tmp.67 tmp.82))
              (= tmp.67 1))
          (begin (set! rax 14) (jump tmp-ra.75 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.75 rbp rax)))))
    (define L.cons.9
      ((locals ())
       (conflicts
        ((tmp-ra.76 (rax tmp.66 tmp.83 tmp.68 tmp.63 tmp.62 rbp r12 rsi rdi))
         (tmp.62 (tmp.66 tmp.83 tmp.68 tmp.63 rbp tmp-ra.76 r12 rsi))
         (tmp.63 (tmp.66 tmp.83 tmp.68 tmp.62 rbp tmp-ra.76 r12))
         (tmp.68 (tmp.62 rbp tmp-ra.76 tmp.63 r12))
         (tmp.83 (tmp.62 rbp tmp-ra.76 tmp.63))
         (tmp.66 (tmp.62 rbp tmp-ra.76 tmp.63))
         (rdi (tmp-ra.76))
         (rsi (tmp.62 tmp-ra.76))
         (r12 (rbp tmp.68 tmp.63 tmp.62 tmp-ra.76))
         (rbp (rax tmp.66 tmp.83 tmp.68 r12 tmp.63 tmp.62 tmp-ra.76))
         (rax (rbp tmp-ra.76))))
       (assignment
        ((tmp-ra.76 r15)
         (tmp.62 r14)
         (tmp.63 r13)
         (tmp.68 r9)
         (tmp.83 r9)
         (tmp.66 r9))))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.62 rdi)
        (set! tmp.63 rsi)
        (begin (set! tmp.68 r12) (set! r12 (+ r12 16)))
        (set! tmp.83 tmp.68)
        (set! tmp.83 (+ tmp.83 1))
        (set! tmp.66 tmp.83)
        (mset! tmp.66 -1 tmp.62)
        (mset! tmp.66 7 tmp.63)
        (set! rax tmp.66)
        (jump tmp-ra.76 rbp rax)))
    (define L.fun/ascii-char8512.4
      ((locals ())
       (conflicts
        ((tmp-ra.77 (rax oprand2.1 oprand1.2 oprand0.3 rbp rdx rsi rdi))
         (oprand0.3 (rbp tmp-ra.77 rdx rsi))
         (oprand1.2 (rbp tmp-ra.77 rdx))
         (oprand2.1 (rbp tmp-ra.77))
         (rdi (tmp-ra.77))
         (rsi (oprand0.3 tmp-ra.77))
         (rdx (oprand1.2 oprand0.3 tmp-ra.77))
         (rbp (rax oprand2.1 oprand1.2 oprand0.3 tmp-ra.77))
         (rax (rbp tmp-ra.77))))
       (assignment
        ((tmp-ra.77 r15) (oprand0.3 r14) (oprand1.2 r14) (oprand2.1 r14))))
      (begin
        (set! tmp-ra.77 r15)
        (set! oprand0.3 rdi)
        (set! oprand1.2 rsi)
        (set! oprand2.1 rdx)
        (set! rax 18734)
        (jump tmp-ra.77 rbp rax)))
    (define L.fun/ascii-char8510.5
      ((locals ())
       (conflicts
        ((tmp-ra.78 (rax oprand2.4 oprand1.5 oprand0.6 rbp rdx rsi rdi))
         (oprand0.6 (oprand2.4 oprand1.5 rbp tmp-ra.78 rdx rsi))
         (oprand1.5 (rbp tmp-ra.78 oprand0.6 rdx))
         (oprand2.4 (rbp tmp-ra.78 oprand0.6))
         (rdi (tmp-ra.78))
         (rsi (oprand0.6 tmp-ra.78))
         (rdx (oprand1.5 oprand0.6 tmp-ra.78))
         (rbp (rax oprand2.4 oprand1.5 oprand0.6 tmp-ra.78))
         (rax (rbp tmp-ra.78))))
       (assignment
        ((tmp-ra.78 r15) (oprand0.6 r14) (oprand1.5 r13) (oprand2.4 r13))))
      (begin
        (set! tmp-ra.78 r15)
        (set! oprand0.6 rdi)
        (set! oprand1.5 rsi)
        (set! oprand2.4 rdx)
        (set! rax oprand0.6)
        (jump tmp-ra.78 rbp rax)))
    (define L.fun/ascii-char8511.6
      ((locals ())
       (conflicts
        ((tmp-ra.79 (rax oprand2.7 oprand1.8 oprand0.9 rbp rdx rsi rdi))
         (oprand0.9 (rbp tmp-ra.79 rdx rsi))
         (oprand1.8 (rbp tmp-ra.79 rdx))
         (oprand2.7 (rbp tmp-ra.79))
         (rdi (tmp-ra.79))
         (rsi (oprand0.9 tmp-ra.79))
         (rdx (oprand1.8 oprand0.9 tmp-ra.79))
         (rbp (rax oprand2.7 oprand1.8 oprand0.9 tmp-ra.79))
         (rax (rbp tmp-ra.79))))
       (assignment
        ((tmp-ra.79 r15) (oprand0.9 r14) (oprand1.8 r14) (oprand2.7 r14))))
      (begin
        (set! tmp-ra.79 r15)
        (set! oprand0.9 rdi)
        (set! oprand1.8 rsi)
        (set! oprand2.7 rdx)
        (set! rax 12334)
        (jump tmp-ra.79 rbp rax)))
    (define L.fun/boolean8513.7
      ((locals ())
       (conflicts
        ((tmp-ra.80 (rax oprand2.10 oprand1.11 oprand0.12 rbp rdx rsi rdi))
         (oprand0.12 (rbp tmp-ra.80 rdx rsi))
         (oprand1.11 (rbp tmp-ra.80 rdx))
         (oprand2.10 (rbp tmp-ra.80))
         (rdi (tmp-ra.80))
         (rsi (oprand0.12 tmp-ra.80))
         (rdx (oprand1.11 oprand0.12 tmp-ra.80))
         (rbp (rax oprand2.10 oprand1.11 oprand0.12 tmp-ra.80))
         (rax (rbp tmp-ra.80))))
       (assignment
        ((tmp-ra.80 r15) (oprand0.12 r14) (oprand1.11 r14) (oprand2.10 r14))))
      (begin
        (set! tmp-ra.80 r15)
        (set! oprand0.12 rdi)
        (set! oprand1.11 rsi)
        (set! oprand2.10 rdx)
        (set! rax 6)
        (jump tmp-ra.80 rbp rax)))
    (begin
      (set! tmp-ra.81 r15)
      (if (begin
            (set! ascii-char0.16 30510)
            (set! void1.15 30)
            (set! empty2.14 22)
            (set! error3.13 28222)
            (begin (set! tmp.84 14) (!= tmp.84 6)))
        (begin
          (begin
            (set! rbp (- rbp 24))
            (return-point L.rp.11
              (begin
                (set! rdx 12078)
                (set! rsi 23870)
                (set! rdi 28974)
                (set! r15 L.rp.11)
                (jump L.fun/ascii-char8511.6 rbp r15 rdi rsi rdx)))
            (set! rbp (+ rbp 24)))
          (set! tmp.69 rax))
        (begin
          (begin
            (set! rbp (- rbp 24))
            (return-point L.rp.12
              (begin
                (set! rdx 11838)
                (set! rsi 13102)
                (set! rdi 25134)
                (set! r15 L.rp.12)
                (jump L.fun/ascii-char8512.4 rbp r15 rdi rsi rdx)))
            (set! rbp (+ rbp 24)))
          (set! tmp.69 rax)))
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 24))
                (return-point L.rp.13
                  (begin
                    (set! rsi 3600)
                    (set! rdi 688)
                    (set! r15 L.rp.13)
                    (jump L.cons.9 rbp r15 rdi rsi)))
                (set! rbp (+ rbp 24)))
              (set! tmp.72 rax)
              (begin
                (set! rbp (- rbp 24))
                (return-point L.rp.14
                  (begin
                    (set! rdi tmp.72)
                    (set! r15 L.rp.14)
                    (jump L.pair?.10 rbp r15 rdi)))
                (set! rbp (+ rbp 24)))
              (set! tmp.71 rax))
            (!= tmp.71 6))
        (if (begin (set! tmp.85 14) (!= tmp.85 6))
          (set! tmp.70 58942)
          (set! tmp.70 23102))
        (if (begin (set! tmp.86 6) (!= tmp.86 6))
          (set! tmp.70 54078)
          (set! tmp.70 19774)))
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 24))
                (return-point L.rp.15
                  (begin
                    (set! rdx 320)
                    (set! rsi 1968)
                    (set! rdi 416)
                    (set! r15 L.rp.15)
                    (jump L.fun/boolean8513.7 rbp r15 rdi rsi rdx)))
                (set! rbp (+ rbp 24)))
              (set! tmp.74 rax))
            (!= tmp.74 6))
        (if (begin (set! tmp.87 6) (!= tmp.87 6))
          (set! tmp.73 18478)
          (set! tmp.73 19246))
        (if (begin (set! tmp.88 14) (!= tmp.88 6))
          (set! tmp.73 26414)
          (set! tmp.73 18990)))
      (set! rdx tmp.73)
      (set! rsi tmp.70)
      (set! rdi tmp.69)
      (set! r15 tmp-ra.81)
      (jump L.fun/ascii-char8510.5 rbp r15 rdi rsi rdx))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.58 (empty3.1 ascii-char2.2 ascii-char1.3 error0.4 rax rbp))
       (error0.4 (rbp tmp-ra.58))
       (ascii-char1.3 (empty3.1 ascii-char2.2 rax rbp tmp-ra.58))
       (ascii-char2.2 (rbp tmp-ra.58 ascii-char1.3))
       (empty3.1 (rbp tmp-ra.58 ascii-char1.3))
       (rbp (empty3.1 ascii-char2.2 ascii-char1.3 error0.4 r15 rax tmp-ra.58))
       (rax (ascii-char1.3 rbp tmp-ra.58))
       (r15 (rbp))))
     (assignment
      ((tmp-ra.58 fv0)
       (ascii-char1.3 fv1)
       (ascii-char2.2 r15)
       (empty3.1 r15)
       (error0.4 r15))))
    (define L.fun/ascii-char8546.4
      ((locals ())
       (conflicts
        ((tmp-ra.54 (rax rbp)) (rbp (rax tmp-ra.54)) (rax (rbp tmp-ra.54))))
       (assignment ((tmp-ra.54 r15))))
      (begin (set! tmp-ra.54 r15) (set! rax 29486) (jump tmp-ra.54 rbp rax)))
    (define L.fun/empty8547.5
      ((locals ())
       (conflicts
        ((tmp-ra.55 (rax rbp)) (rbp (rax tmp-ra.55)) (rax (rbp tmp-ra.55))))
       (assignment ((tmp-ra.55 r15))))
      (begin (set! tmp-ra.55 r15) (set! rax 22) (jump tmp-ra.55 rbp rax)))
    (define L.fun/error8544.6
      ((locals ())
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56))))
       (assignment ((tmp-ra.56 r15))))
      (begin (set! tmp-ra.56 r15) (set! rax 17982) (jump tmp-ra.56 rbp rax)))
    (define L.fun/ascii-char8545.7
      ((locals ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57))))
       (assignment ((tmp-ra.57 r15))))
      (begin (set! tmp-ra.57 r15) (set! rax 12334) (jump tmp-ra.57 rbp rax)))
    (begin
      (set! tmp-ra.58 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.9
          (begin (set! r15 L.rp.9) (jump L.fun/error8544.6 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error0.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char8545.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char1.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char8546.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char2.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty8547.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty3.1 rax)
      (set! rax ascii-char1.3)
      (jump tmp-ra.58 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.65 (rdi tmp.57 pair3.1 error2.2 error1.3 pair0.4 rax rbp))
       (pair0.4 (rbp tmp-ra.65))
       (error1.3 (rbp tmp-ra.65))
       (error2.2 (rbp tmp-ra.65))
       (pair3.1 (rbp tmp-ra.65))
       (tmp.57 (rbp tmp-ra.65))
       (rbp (rdi tmp.57 pair3.1 error2.2 error1.3 pair0.4 r15 rax tmp-ra.65))
       (rax (rbp tmp-ra.65))
       (r15 (rdi rbp))
       (rdi (r15 rbp tmp-ra.65))))
     (assignment
      ((tmp-ra.65 fv0)
       (pair0.4 r15)
       (error1.3 r15)
       (error2.2 r15)
       (pair3.1 r15)
       (tmp.57 r15))))
    (define L.void?.11
      ((locals ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.58))
         (tmp.44 (rbp tmp-ra.58))
         (tmp.66 (rbp tmp-ra.58))
         (tmp-ra.58 (tmp.44 rbp rdi tmp.66 tmp.55 rax))
         (rax (rbp tmp-ra.58))
         (rbp (tmp.44 tmp-ra.58 tmp.66 tmp.55 rax))
         (rdi (tmp-ra.58))))
       (assignment ((tmp-ra.58 r15) (tmp.55 r14) (tmp.44 r14) (tmp.66 r14))))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.66 tmp.44)
                (set! tmp.66 (bitwise-and tmp.66 255))
                (set! tmp.55 tmp.66))
              (= tmp.55 30))
          (begin (set! rax 14) (jump tmp-ra.58 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.58 rbp rax)))))
    (define L.cons.10
      ((locals ())
       (conflicts
        ((tmp-ra.59 (rax tmp.54 tmp.67 tmp.56 tmp.51 tmp.50 rbp r12 rsi rdi))
         (tmp.50 (tmp.54 tmp.67 tmp.56 tmp.51 rbp tmp-ra.59 r12 rsi))
         (tmp.51 (tmp.54 tmp.67 tmp.56 tmp.50 rbp tmp-ra.59 r12))
         (tmp.56 (tmp.50 rbp tmp-ra.59 tmp.51 r12))
         (tmp.67 (tmp.50 rbp tmp-ra.59 tmp.51))
         (tmp.54 (tmp.50 rbp tmp-ra.59 tmp.51))
         (rdi (tmp-ra.59))
         (rsi (tmp.50 tmp-ra.59))
         (r12 (rbp tmp.56 tmp.51 tmp.50 tmp-ra.59))
         (rbp (rax tmp.54 tmp.67 tmp.56 r12 tmp.51 tmp.50 tmp-ra.59))
         (rax (rbp tmp-ra.59))))
       (assignment
        ((tmp-ra.59 r15)
         (tmp.50 r14)
         (tmp.51 r13)
         (tmp.56 r9)
         (tmp.67 r9)
         (tmp.54 r9))))
      (begin
        (set! tmp-ra.59 r15)
        (set! tmp.50 rdi)
        (set! tmp.51 rsi)
        (begin (set! tmp.56 r12) (set! r12 (+ r12 16)))
        (set! tmp.67 tmp.56)
        (set! tmp.67 (+ tmp.67 1))
        (set! tmp.54 tmp.67)
        (mset! tmp.54 -1 tmp.50)
        (mset! tmp.54 7 tmp.51)
        (set! rax tmp.54)
        (jump tmp-ra.59 rbp rax)))
    (define L.fun/any8685.4
      ((locals ())
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60))))
       (assignment ((tmp-ra.60 r15))))
      (begin (set! tmp-ra.60 r15) (set! rax 30) (jump tmp-ra.60 rbp rax)))
    (define L.fun/pair8681.5
      ((locals ())
       (conflicts
        ((tmp-ra.61 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.61))
         (rsi (r15 rdi rbp tmp-ra.61))
         (rdi (r15 rbp rsi tmp-ra.61))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.61 r15))))
      (begin
        (set! tmp-ra.61 r15)
        (set! rsi 3104)
        (set! rdi 856)
        (set! r15 tmp-ra.61)
        (jump L.cons.10 rbp r15 rdi rsi)))
    (define L.fun/error8683.6
      ((locals ())
       (conflicts
        ((tmp-ra.62 (rax rbp)) (rbp (rax tmp-ra.62)) (rax (rbp tmp-ra.62))))
       (assignment ((tmp-ra.62 r15))))
      (begin (set! tmp-ra.62 r15) (set! rax 21310) (jump tmp-ra.62 rbp rax)))
    (define L.fun/pair8684.7
      ((locals ())
       (conflicts
        ((tmp-ra.63 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.63))
         (rsi (r15 rdi rbp tmp-ra.63))
         (rdi (r15 rbp rsi tmp-ra.63))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.63 r15))))
      (begin
        (set! tmp-ra.63 r15)
        (set! rsi 2576)
        (set! rdi 936)
        (set! r15 tmp-ra.63)
        (jump L.cons.10 rbp r15 rdi rsi)))
    (define L.fun/error8682.8
      ((locals ())
       (conflicts
        ((tmp-ra.64 (rax rbp)) (rbp (rax tmp-ra.64)) (rax (rbp tmp-ra.64))))
       (assignment ((tmp-ra.64 r15))))
      (begin (set! tmp-ra.64 r15) (set! rax 51774) (jump tmp-ra.64 rbp rax)))
    (begin
      (set! tmp-ra.65 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/pair8681.5 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! pair0.4 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/error8682.8 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error1.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error8683.6 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error2.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/pair8684.7 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! pair3.1 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/any8685.4 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! tmp.57 rax)
      (set! rdi tmp.57)
      (set! r15 tmp-ra.65)
      (jump L.void?.11 rbp r15 rdi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.84
        (void4.1
         pair3.2
         fixnum2.3
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         empty1.4
         empty0.5
         rax
         rbp))
       (empty0.5 (rbp tmp-ra.84))
       (empty1.4 (rbp tmp-ra.84))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.84))
       (tmp.72 (rbp tmp-ra.84 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.84))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.84 tmp.70))
       (tmp.75 (rbp tmp-ra.84 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.84 tmp.70))
       (fixnum2.3 (rbp tmp-ra.84))
       (pair3.2 (void4.1 rax rbp tmp-ra.84))
       (void4.1 (rbp tmp-ra.84 pair3.2))
       (rbp
        (void4.1
         pair3.2
         fixnum2.3
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         rdi
         rsi
         empty1.4
         empty0.5
         r15
         rax
         tmp-ra.84))
       (rax (pair3.2 tmp.74 tmp.70 tmp.71 rbp tmp-ra.84))
       (r15 (rdi rsi rbp))
       (rsi (tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.84 fv0)
       (tmp.74 fv1)
       (pair3.2 fv1)
       (tmp.70 fv2)
       (tmp.71 fv1)
       (tmp.75 r15)
       (tmp.72 r15)
       (tmp.73 r15)
       (void4.1 r15)
       (empty0.5 r15)
       (empty1.4 r15)
       (fixnum2.3 r15))))
    (define L.+.12
      ((locals ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.76 tmp.22 tmp.21))
         (tmp.85 (tmp.22 rbp tmp-ra.76 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.76
           tmp.21
           tmp.85
           tmp.57
           tmp.56
           tmp.86
           tmp.59
           tmp.58
           tmp.87))
         (tmp.57 (rbp tmp-ra.76 tmp.22 tmp.21))
         (tmp-ra.76
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.85
           tmp.57
           tmp.56
           tmp.86
           tmp.59
           tmp.58
           tmp.87
           rax))
         (tmp.87 (rbp tmp-ra.76 tmp.22))
         (tmp.59 (rbp tmp-ra.76 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.76 rsi tmp.85 tmp.57 tmp.56 tmp.86 tmp.59 tmp.58))
         (tmp.86 (tmp.21 rbp tmp-ra.76 tmp.22))
         (tmp.58 (rbp tmp-ra.76 tmp.22 tmp.21))
         (rax (rbp tmp-ra.76))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.76
           tmp.85
           tmp.57
           tmp.56
           tmp.86
           tmp.59
           tmp.58
           tmp.87
           rax))
         (rdi (tmp-ra.76))
         (rsi (tmp.21 tmp-ra.76))))
       (assignment
        ((tmp-ra.76 r15)
         (tmp.22 r14)
         (tmp.21 r13)
         (tmp.56 r9)
         (tmp.85 r9)
         (tmp.57 r9)
         (tmp.59 r9)
         (tmp.86 r9)
         (tmp.58 r9)
         (tmp.87 r13))))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.85 tmp.22)
                      (set! tmp.85 (bitwise-and tmp.85 7))
                      (set! tmp.57 tmp.85))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.86 tmp.21)
                        (set! tmp.86 (bitwise-and tmp.86 7))
                        (set! tmp.59 tmp.86))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.87 tmp.21)
              (set! tmp.87 (+ tmp.87 tmp.22))
              (set! rax tmp.87)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.76 rbp rax)))))
    (define L.-.11
      ((locals ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.77 tmp.24 tmp.23))
         (tmp.88 (tmp.24 rbp tmp-ra.77 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.77
           tmp.23
           tmp.88
           tmp.61
           tmp.60
           tmp.89
           tmp.63
           tmp.62
           tmp.90))
         (tmp.61 (rbp tmp-ra.77 tmp.24 tmp.23))
         (tmp-ra.77
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.88
           tmp.61
           tmp.60
           tmp.89
           tmp.63
           tmp.62
           tmp.90
           rax))
         (tmp.90 (rbp tmp-ra.77 tmp.24))
         (tmp.63 (rbp tmp-ra.77 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.77 rsi tmp.88 tmp.61 tmp.60 tmp.89 tmp.63 tmp.62))
         (tmp.89 (tmp.23 rbp tmp-ra.77 tmp.24))
         (tmp.62 (rbp tmp-ra.77 tmp.24 tmp.23))
         (rax (rbp tmp-ra.77))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.77
           tmp.88
           tmp.61
           tmp.60
           tmp.89
           tmp.63
           tmp.62
           tmp.90
           rax))
         (rdi (tmp-ra.77))
         (rsi (tmp.23 tmp-ra.77))))
       (assignment
        ((tmp-ra.77 r15)
         (tmp.24 r14)
         (tmp.23 r13)
         (tmp.60 r9)
         (tmp.88 r9)
         (tmp.61 r9)
         (tmp.63 r9)
         (tmp.89 r9)
         (tmp.62 r9)
         (tmp.90 r13))))
      (begin
        (set! tmp-ra.77 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.88 tmp.24)
                      (set! tmp.88 (bitwise-and tmp.88 7))
                      (set! tmp.61 tmp.88))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.89 tmp.23)
                        (set! tmp.89 (bitwise-and tmp.89 7))
                        (set! tmp.63 tmp.89))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.90 tmp.23)
              (set! tmp.90 (- tmp.90 tmp.24))
              (set! rax tmp.90)
              (jump tmp-ra.77 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.77 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.77 rbp rax)))))
    (define L.*.10
      ((locals ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.78 tmp.19 tmp.20))
         (tmp.91 (tmp.20 rbp tmp-ra.78 tmp.19))
         (tmp.20
          (rbp tmp-ra.78 tmp.19 tmp.91 tmp.65 tmp.64 tmp.92 tmp.67 tmp.66))
         (tmp.65 (rbp tmp-ra.78 tmp.19 tmp.20))
         (tmp-ra.78
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.91
           tmp.65
           tmp.64
           tmp.92
           tmp.67
           tmp.66
           tmp.94
           tmp.68
           tmp.93
           rax))
         (tmp.93 (rbp tmp-ra.78 tmp.19))
         (tmp.68 (tmp.94 rbp tmp-ra.78 tmp.19))
         (tmp.94 (rbp tmp-ra.78 tmp.68))
         (tmp.67 (rbp tmp-ra.78 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.78
           rsi
           tmp.91
           tmp.65
           tmp.64
           tmp.92
           tmp.67
           tmp.66
           tmp.68
           tmp.93))
         (tmp.92 (tmp.19 rbp tmp-ra.78 tmp.20))
         (tmp.66 (rbp tmp-ra.78 tmp.19 tmp.20))
         (rax (rbp tmp-ra.78))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.78
           tmp.91
           tmp.65
           tmp.64
           tmp.92
           tmp.67
           tmp.66
           tmp.94
           tmp.68
           tmp.93
           rax))
         (rdi (tmp-ra.78))
         (rsi (tmp.19 tmp-ra.78))))
       (assignment
        ((tmp-ra.78 r15)
         (tmp.19 r14)
         (tmp.20 r13)
         (tmp.64 r9)
         (tmp.91 r9)
         (tmp.65 r9)
         (tmp.68 r13)
         (tmp.67 r9)
         (tmp.92 r9)
         (tmp.66 r9)
         (tmp.93 r13)
         (tmp.94 r14))))
      (begin
        (set! tmp-ra.78 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.91 tmp.20)
                      (set! tmp.91 (bitwise-and tmp.91 7))
                      (set! tmp.65 tmp.91))
                    (= tmp.65 0))
                (set! tmp.64 14)
                (set! tmp.64 6))
              (!= tmp.64 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.92 tmp.19)
                        (set! tmp.92 (bitwise-and tmp.92 7))
                        (set! tmp.67 tmp.92))
                      (= tmp.67 0))
                  (set! tmp.66 14)
                  (set! tmp.66 6))
                (!= tmp.66 6))
            (begin
              (set! tmp.93 tmp.20)
              (set! tmp.93 (arithmetic-shift-right tmp.93 3))
              (set! tmp.68 tmp.93)
              (set! tmp.94 tmp.19)
              (set! tmp.94 (* tmp.94 tmp.68))
              (set! rax tmp.94)
              (jump tmp-ra.78 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.78 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.78 rbp rax)))))
    (define L.cons.9
      ((locals ())
       (conflicts
        ((tmp-ra.79 (rax tmp.55 tmp.95 tmp.69 tmp.52 tmp.51 rbp r12 rsi rdi))
         (tmp.51 (tmp.55 tmp.95 tmp.69 tmp.52 rbp tmp-ra.79 r12 rsi))
         (tmp.52 (tmp.55 tmp.95 tmp.69 tmp.51 rbp tmp-ra.79 r12))
         (tmp.69 (tmp.51 rbp tmp-ra.79 tmp.52 r12))
         (tmp.95 (tmp.51 rbp tmp-ra.79 tmp.52))
         (tmp.55 (tmp.51 rbp tmp-ra.79 tmp.52))
         (rdi (tmp-ra.79))
         (rsi (tmp.51 tmp-ra.79))
         (r12 (rbp tmp.69 tmp.52 tmp.51 tmp-ra.79))
         (rbp (rax tmp.55 tmp.95 tmp.69 r12 tmp.52 tmp.51 tmp-ra.79))
         (rax (rbp tmp-ra.79))))
       (assignment
        ((tmp-ra.79 r15)
         (tmp.51 r14)
         (tmp.52 r13)
         (tmp.69 r9)
         (tmp.95 r9)
         (tmp.55 r9))))
      (begin
        (set! tmp-ra.79 r15)
        (set! tmp.51 rdi)
        (set! tmp.52 rsi)
        (begin (set! tmp.69 r12) (set! r12 (+ r12 16)))
        (set! tmp.95 tmp.69)
        (set! tmp.95 (+ tmp.95 1))
        (set! tmp.55 tmp.95)
        (mset! tmp.55 -1 tmp.51)
        (mset! tmp.55 7 tmp.52)
        (set! rax tmp.55)
        (jump tmp-ra.79 rbp rax)))
    (define L.fun/empty8893.4
      ((locals ())
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80))))
       (assignment ((tmp-ra.80 r15))))
      (begin (set! tmp-ra.80 r15) (set! rax 22) (jump tmp-ra.80 rbp rax)))
    (define L.fun/empty8894.5
      ((locals ())
       (conflicts
        ((tmp-ra.81 (rax rbp)) (rbp (rax tmp-ra.81)) (rax (rbp tmp-ra.81))))
       (assignment ((tmp-ra.81 r15))))
      (begin (set! tmp-ra.81 r15) (set! rax 22) (jump tmp-ra.81 rbp rax)))
    (define L.fun/pair8895.6
      ((locals ())
       (conflicts
        ((tmp-ra.82 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.82))
         (rsi (r15 rdi rbp tmp-ra.82))
         (rdi (r15 rbp rsi tmp-ra.82))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.82 r15))))
      (begin
        (set! tmp-ra.82 r15)
        (set! rsi 2344)
        (set! rdi 1160)
        (set! r15 tmp-ra.82)
        (jump L.cons.9 rbp r15 rdi rsi)))
    (define L.fun/void8896.7
      ((locals ())
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83))))
       (assignment ((tmp-ra.83 r15))))
      (begin (set! tmp-ra.83 r15) (set! rax 30) (jump tmp-ra.83 rbp rax)))
    (begin
      (set! tmp-ra.84 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty8893.4 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! empty0.5 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/empty8894.5 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! empty1.4 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin
            (set! rsi 200)
            (set! rdi 1632)
            (set! r15 L.rp.15)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi 904)
            (set! rdi 320)
            (set! r15 L.rp.16)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.17)
            (jump L.*.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi 320)
            (set! rdi 712)
            (set! r15 L.rp.18)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi 928)
            (set! rdi 896)
            (set! r15 L.rp.19)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.20)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.21)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! fixnum2.3 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/pair8895.6 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! pair3.2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void8896.7 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! void4.1 rax)
      (set! rax pair3.2)
      (jump tmp-ra.84 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.90
        (pair4.1
         empty3.2
         fixnum2.3
         tmp.79
         tmp.81
         tmp.80
         tmp.76
         tmp.78
         tmp.77
         error1.4
         fixnum0.5
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         rax
         rbp))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.90))
       (tmp.72 (rbp tmp-ra.90 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.90))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.90 tmp.70))
       (tmp.75 (rbp tmp-ra.90 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.90 tmp.70))
       (fixnum0.5 (rbp tmp-ra.90))
       (error1.4 (rbp tmp-ra.90))
       (tmp.77 (rsi tmp.78 rax rbp tmp-ra.90))
       (tmp.78 (rbp tmp-ra.90 tmp.77))
       (tmp.76 (rsi tmp.79 tmp.81 tmp.80 rax rbp tmp-ra.90))
       (tmp.80 (rsi tmp.81 rax rbp tmp-ra.90 tmp.76))
       (tmp.81 (rbp tmp-ra.90 tmp.76 tmp.80))
       (tmp.79 (rbp tmp-ra.90 tmp.76))
       (fixnum2.3 (rbp tmp-ra.90))
       (empty3.2 (rbp tmp-ra.90))
       (pair4.1 (rbp tmp-ra.90))
       (rbp
        (pair4.1
         empty3.2
         fixnum2.3
         tmp.79
         tmp.81
         tmp.80
         tmp.76
         tmp.78
         tmp.77
         error1.4
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
         tmp-ra.90))
       (rax (tmp.80 tmp.76 tmp.77 tmp.74 tmp.70 tmp.71 rbp tmp-ra.90))
       (rsi (tmp.76 tmp.80 tmp.77 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.90 fv0)
       (tmp.74 fv1)
       (tmp.80 fv1)
       (tmp.76 fv2)
       (tmp.77 fv1)
       (tmp.70 fv2)
       (tmp.71 fv1)
       (tmp.75 r15)
       (tmp.81 r15)
       (tmp.72 r15)
       (tmp.73 r15)
       (tmp.78 r15)
       (tmp.79 r15)
       (fixnum0.5 r15)
       (error1.4 r15)
       (fixnum2.3 r15)
       (empty3.2 r15)
       (pair4.1 r15))))
    (define L.*.12
      ((locals ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.82 tmp.19 tmp.20))
         (tmp.91 (tmp.20 rbp tmp-ra.82 tmp.19))
         (tmp.20
          (rbp tmp-ra.82 tmp.19 tmp.91 tmp.57 tmp.56 tmp.92 tmp.59 tmp.58))
         (tmp.57 (rbp tmp-ra.82 tmp.19 tmp.20))
         (tmp-ra.82
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.91
           tmp.57
           tmp.56
           tmp.92
           tmp.59
           tmp.58
           tmp.94
           tmp.60
           tmp.93
           rax))
         (tmp.93 (rbp tmp-ra.82 tmp.19))
         (tmp.60 (tmp.94 rbp tmp-ra.82 tmp.19))
         (tmp.94 (rbp tmp-ra.82 tmp.60))
         (tmp.59 (rbp tmp-ra.82 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.82
           rsi
           tmp.91
           tmp.57
           tmp.56
           tmp.92
           tmp.59
           tmp.58
           tmp.60
           tmp.93))
         (tmp.92 (tmp.19 rbp tmp-ra.82 tmp.20))
         (tmp.58 (rbp tmp-ra.82 tmp.19 tmp.20))
         (rax (rbp tmp-ra.82))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.82
           tmp.91
           tmp.57
           tmp.56
           tmp.92
           tmp.59
           tmp.58
           tmp.94
           tmp.60
           tmp.93
           rax))
         (rdi (tmp-ra.82))
         (rsi (tmp.19 tmp-ra.82))))
       (assignment
        ((tmp-ra.82 r15)
         (tmp.19 r14)
         (tmp.20 r13)
         (tmp.56 r9)
         (tmp.91 r9)
         (tmp.57 r9)
         (tmp.60 r13)
         (tmp.59 r9)
         (tmp.92 r9)
         (tmp.58 r9)
         (tmp.93 r13)
         (tmp.94 r14))))
      (begin
        (set! tmp-ra.82 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.91 tmp.20)
                      (set! tmp.91 (bitwise-and tmp.91 7))
                      (set! tmp.57 tmp.91))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.92 tmp.19)
                        (set! tmp.92 (bitwise-and tmp.92 7))
                        (set! tmp.59 tmp.92))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.93 tmp.20)
              (set! tmp.93 (arithmetic-shift-right tmp.93 3))
              (set! tmp.60 tmp.93)
              (set! tmp.94 tmp.19)
              (set! tmp.94 (* tmp.94 tmp.60))
              (set! rax tmp.94)
              (jump tmp-ra.82 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.82 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.82 rbp rax)))))
    (define L.-.11
      ((locals ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.83 tmp.24 tmp.23))
         (tmp.95 (tmp.24 rbp tmp-ra.83 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.83
           tmp.23
           tmp.95
           tmp.62
           tmp.61
           tmp.96
           tmp.64
           tmp.63
           tmp.97))
         (tmp.62 (rbp tmp-ra.83 tmp.24 tmp.23))
         (tmp-ra.83
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.95
           tmp.62
           tmp.61
           tmp.96
           tmp.64
           tmp.63
           tmp.97
           rax))
         (tmp.97 (rbp tmp-ra.83 tmp.24))
         (tmp.64 (rbp tmp-ra.83 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.83 rsi tmp.95 tmp.62 tmp.61 tmp.96 tmp.64 tmp.63))
         (tmp.96 (tmp.23 rbp tmp-ra.83 tmp.24))
         (tmp.63 (rbp tmp-ra.83 tmp.24 tmp.23))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.83
           tmp.95
           tmp.62
           tmp.61
           tmp.96
           tmp.64
           tmp.63
           tmp.97
           rax))
         (rdi (tmp-ra.83))
         (rsi (tmp.23 tmp-ra.83))))
       (assignment
        ((tmp-ra.83 r15)
         (tmp.24 r14)
         (tmp.23 r13)
         (tmp.61 r9)
         (tmp.95 r9)
         (tmp.62 r9)
         (tmp.64 r9)
         (tmp.96 r9)
         (tmp.63 r9)
         (tmp.97 r13))))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.95 tmp.24)
                      (set! tmp.95 (bitwise-and tmp.95 7))
                      (set! tmp.62 tmp.95))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.96 tmp.23)
                        (set! tmp.96 (bitwise-and tmp.96 7))
                        (set! tmp.64 tmp.96))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.97 tmp.23)
              (set! tmp.97 (- tmp.97 tmp.24))
              (set! rax tmp.97)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.83 rbp rax)))))
    (define L.+.10
      ((locals ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.84 tmp.22 tmp.21))
         (tmp.98 (tmp.22 rbp tmp-ra.84 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.84
           tmp.21
           tmp.98
           tmp.66
           tmp.65
           tmp.99
           tmp.68
           tmp.67
           tmp.100))
         (tmp.66 (rbp tmp-ra.84 tmp.22 tmp.21))
         (tmp-ra.84
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.98
           tmp.66
           tmp.65
           tmp.99
           tmp.68
           tmp.67
           tmp.100
           rax))
         (tmp.100 (rbp tmp-ra.84 tmp.22))
         (tmp.68 (rbp tmp-ra.84 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.84 rsi tmp.98 tmp.66 tmp.65 tmp.99 tmp.68 tmp.67))
         (tmp.99 (tmp.21 rbp tmp-ra.84 tmp.22))
         (tmp.67 (rbp tmp-ra.84 tmp.22 tmp.21))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.84
           tmp.98
           tmp.66
           tmp.65
           tmp.99
           tmp.68
           tmp.67
           tmp.100
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.21 tmp-ra.84))))
       (assignment
        ((tmp-ra.84 r15)
         (tmp.22 r14)
         (tmp.21 r13)
         (tmp.65 r9)
         (tmp.98 r9)
         (tmp.66 r9)
         (tmp.68 r9)
         (tmp.99 r9)
         (tmp.67 r9)
         (tmp.100 r13))))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.98 tmp.22)
                      (set! tmp.98 (bitwise-and tmp.98 7))
                      (set! tmp.66 tmp.98))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.99 tmp.21)
                        (set! tmp.99 (bitwise-and tmp.99 7))
                        (set! tmp.68 tmp.99))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.100 tmp.21)
              (set! tmp.100 (+ tmp.100 tmp.22))
              (set! rax tmp.100)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.84 rbp rax)))))
    (define L.cons.9
      ((locals ())
       (conflicts
        ((tmp-ra.85 (rax tmp.55 tmp.101 tmp.69 tmp.52 tmp.51 rbp r12 rsi rdi))
         (tmp.51 (tmp.55 tmp.101 tmp.69 tmp.52 rbp tmp-ra.85 r12 rsi))
         (tmp.52 (tmp.55 tmp.101 tmp.69 tmp.51 rbp tmp-ra.85 r12))
         (tmp.69 (tmp.51 rbp tmp-ra.85 tmp.52 r12))
         (tmp.101 (tmp.51 rbp tmp-ra.85 tmp.52))
         (tmp.55 (tmp.51 rbp tmp-ra.85 tmp.52))
         (rdi (tmp-ra.85))
         (rsi (tmp.51 tmp-ra.85))
         (r12 (rbp tmp.69 tmp.52 tmp.51 tmp-ra.85))
         (rbp (rax tmp.55 tmp.101 tmp.69 r12 tmp.52 tmp.51 tmp-ra.85))
         (rax (rbp tmp-ra.85))))
       (assignment
        ((tmp-ra.85 r15)
         (tmp.51 r14)
         (tmp.52 r13)
         (tmp.69 r9)
         (tmp.101 r9)
         (tmp.55 r9))))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.51 rdi)
        (set! tmp.52 rsi)
        (begin (set! tmp.69 r12) (set! r12 (+ r12 16)))
        (set! tmp.101 tmp.69)
        (set! tmp.101 (+ tmp.101 1))
        (set! tmp.55 tmp.101)
        (mset! tmp.55 -1 tmp.51)
        (mset! tmp.55 7 tmp.52)
        (set! rax tmp.55)
        (jump tmp-ra.85 rbp rax)))
    (define L.fun/empty8907.4
      ((locals ())
       (conflicts
        ((tmp-ra.86 (rax rbp)) (rbp (rax tmp-ra.86)) (rax (rbp tmp-ra.86))))
       (assignment ((tmp-ra.86 r15))))
      (begin (set! tmp-ra.86 r15) (set! rax 22) (jump tmp-ra.86 rbp rax)))
    (define L.fun/error8906.5
      ((locals ())
       (conflicts
        ((tmp-ra.87 (rax rbp)) (rbp (rax tmp-ra.87)) (rax (rbp tmp-ra.87))))
       (assignment ((tmp-ra.87 r15))))
      (begin (set! tmp-ra.87 r15) (set! rax 18238) (jump tmp-ra.87 rbp rax)))
    (define L.fun/pair8908.6
      ((locals ())
       (conflicts
        ((tmp-ra.88 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.88))
         (rsi (r15 rdi rbp tmp-ra.88))
         (rdi (r15 rbp rsi tmp-ra.88))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.88 r15))))
      (begin
        (set! tmp-ra.88 r15)
        (set! rsi 3040)
        (set! rdi 1360)
        (set! r15 tmp-ra.88)
        (jump L.cons.9 rbp r15 rdi rsi)))
    (define L.fun/void8909.7
      ((locals ())
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89))))
       (assignment ((tmp-ra.89 r15))))
      (begin (set! tmp-ra.89 r15) (set! rax 30) (jump tmp-ra.89 rbp rax)))
    (begin
      (set! tmp-ra.90 r15)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.13
          (begin
            (set! rsi 1560)
            (set! rdi 864)
            (set! r15 L.rp.13)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.14
          (begin
            (set! rsi 1832)
            (set! rdi 1632)
            (set! r15 L.rp.14)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.15
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.15)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.16
          (begin
            (set! rsi 408)
            (set! rdi 408)
            (set! r15 L.rp.16)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.17
          (begin
            (set! rsi 88)
            (set! rdi 1168)
            (set! r15 L.rp.17)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.18)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.19)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! fixnum0.5 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error8906.5 rbp r15)))
        (set! rbp (+ rbp 56)))
      (set! error1.4 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.21
          (begin
            (set! rsi 512)
            (set! rdi 1752)
            (set! r15 L.rp.21)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.22
          (begin
            (set! rsi 1392)
            (set! rdi 1728)
            (set! r15 L.rp.22)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.78)
            (set! rdi tmp.77)
            (set! r15 L.rp.23)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.24
          (begin
            (set! rsi 560)
            (set! rdi 136)
            (set! r15 L.rp.24)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.25
          (begin
            (set! rsi 984)
            (set! rdi 176)
            (set! r15 L.rp.25)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.81)
            (set! rdi tmp.80)
            (set! r15 L.rp.26)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.76)
            (set! r15 L.rp.27)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 56)))
      (set! fixnum2.3 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.28
          (begin (set! r15 L.rp.28) (jump L.fun/empty8907.4 rbp r15)))
        (set! rbp (+ rbp 56)))
      (set! empty3.2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.29
          (begin (set! r15 L.rp.29) (jump L.fun/pair8908.6 rbp r15)))
        (set! rbp (+ rbp 56)))
      (set! pair4.1 rax)
      (set! r15 tmp-ra.90)
      (jump L.fun/void8909.7 rbp r15))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.84
        (fixnum4.1
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         error3.2
         empty2.3
         ascii-char1.4
         pair0.5
         rax
         rbp))
       (pair0.5 (rbp tmp-ra.84))
       (ascii-char1.4 (rbp tmp-ra.84))
       (empty2.3 (rbp tmp-ra.84))
       (error3.2
        (fixnum4.1
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         rax
         rbp
         tmp-ra.84))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.84 error3.2))
       (tmp.72 (rbp tmp-ra.84 error3.2 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.84 error3.2))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.84 error3.2 tmp.70))
       (tmp.75 (rbp tmp-ra.84 error3.2 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.84 error3.2 tmp.70))
       (fixnum4.1 (rbp tmp-ra.84 error3.2))
       (rbp
        (fixnum4.1
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         rdi
         rsi
         error3.2
         empty2.3
         ascii-char1.4
         pair0.5
         r15
         rax
         tmp-ra.84))
       (rax (tmp.74 tmp.70 tmp.71 error3.2 rbp tmp-ra.84))
       (r15 (rdi rsi rbp))
       (rsi (tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.84 fv0)
       (error3.2 fv1)
       (tmp.74 fv2)
       (tmp.70 fv3)
       (tmp.71 fv2)
       (tmp.75 r15)
       (tmp.72 r15)
       (tmp.73 r15)
       (fixnum4.1 r15)
       (pair0.5 r15)
       (ascii-char1.4 r15)
       (empty2.3 r15))))
    (define L.*.12
      ((locals ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp.85 (tmp.20 rbp tmp-ra.76 tmp.19))
         (tmp.20
          (rbp tmp-ra.76 tmp.19 tmp.85 tmp.57 tmp.56 tmp.86 tmp.59 tmp.58))
         (tmp.57 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp-ra.76
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.85
           tmp.57
           tmp.56
           tmp.86
           tmp.59
           tmp.58
           tmp.88
           tmp.60
           tmp.87
           rax))
         (tmp.87 (rbp tmp-ra.76 tmp.19))
         (tmp.60 (tmp.88 rbp tmp-ra.76 tmp.19))
         (tmp.88 (rbp tmp-ra.76 tmp.60))
         (tmp.59 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.76
           rsi
           tmp.85
           tmp.57
           tmp.56
           tmp.86
           tmp.59
           tmp.58
           tmp.60
           tmp.87))
         (tmp.86 (tmp.19 rbp tmp-ra.76 tmp.20))
         (tmp.58 (rbp tmp-ra.76 tmp.19 tmp.20))
         (rax (rbp tmp-ra.76))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.76
           tmp.85
           tmp.57
           tmp.56
           tmp.86
           tmp.59
           tmp.58
           tmp.88
           tmp.60
           tmp.87
           rax))
         (rdi (tmp-ra.76))
         (rsi (tmp.19 tmp-ra.76))))
       (assignment
        ((tmp-ra.76 r15)
         (tmp.19 r14)
         (tmp.20 r13)
         (tmp.56 r9)
         (tmp.85 r9)
         (tmp.57 r9)
         (tmp.60 r13)
         (tmp.59 r9)
         (tmp.86 r9)
         (tmp.58 r9)
         (tmp.87 r13)
         (tmp.88 r14))))
      (begin
        (set! tmp-ra.76 r15)
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
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))))
    (define L.-.11
      ((locals ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.77 tmp.24 tmp.23))
         (tmp.89 (tmp.24 rbp tmp-ra.77 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.77
           tmp.23
           tmp.89
           tmp.62
           tmp.61
           tmp.90
           tmp.64
           tmp.63
           tmp.91))
         (tmp.62 (rbp tmp-ra.77 tmp.24 tmp.23))
         (tmp-ra.77
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.89
           tmp.62
           tmp.61
           tmp.90
           tmp.64
           tmp.63
           tmp.91
           rax))
         (tmp.91 (rbp tmp-ra.77 tmp.24))
         (tmp.64 (rbp tmp-ra.77 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.77 rsi tmp.89 tmp.62 tmp.61 tmp.90 tmp.64 tmp.63))
         (tmp.90 (tmp.23 rbp tmp-ra.77 tmp.24))
         (tmp.63 (rbp tmp-ra.77 tmp.24 tmp.23))
         (rax (rbp tmp-ra.77))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.77
           tmp.89
           tmp.62
           tmp.61
           tmp.90
           tmp.64
           tmp.63
           tmp.91
           rax))
         (rdi (tmp-ra.77))
         (rsi (tmp.23 tmp-ra.77))))
       (assignment
        ((tmp-ra.77 r15)
         (tmp.24 r14)
         (tmp.23 r13)
         (tmp.61 r9)
         (tmp.89 r9)
         (tmp.62 r9)
         (tmp.64 r9)
         (tmp.90 r9)
         (tmp.63 r9)
         (tmp.91 r13))))
      (begin
        (set! tmp-ra.77 r15)
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
              (jump tmp-ra.77 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.77 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.77 rbp rax)))))
    (define L.+.10
      ((locals ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.78 tmp.22 tmp.21))
         (tmp.92 (tmp.22 rbp tmp-ra.78 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.78
           tmp.21
           tmp.92
           tmp.66
           tmp.65
           tmp.93
           tmp.68
           tmp.67
           tmp.94))
         (tmp.66 (rbp tmp-ra.78 tmp.22 tmp.21))
         (tmp-ra.78
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.92
           tmp.66
           tmp.65
           tmp.93
           tmp.68
           tmp.67
           tmp.94
           rax))
         (tmp.94 (rbp tmp-ra.78 tmp.22))
         (tmp.68 (rbp tmp-ra.78 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.78 rsi tmp.92 tmp.66 tmp.65 tmp.93 tmp.68 tmp.67))
         (tmp.93 (tmp.21 rbp tmp-ra.78 tmp.22))
         (tmp.67 (rbp tmp-ra.78 tmp.22 tmp.21))
         (rax (rbp tmp-ra.78))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.78
           tmp.92
           tmp.66
           tmp.65
           tmp.93
           tmp.68
           tmp.67
           tmp.94
           rax))
         (rdi (tmp-ra.78))
         (rsi (tmp.21 tmp-ra.78))))
       (assignment
        ((tmp-ra.78 r15)
         (tmp.22 r14)
         (tmp.21 r13)
         (tmp.65 r9)
         (tmp.92 r9)
         (tmp.66 r9)
         (tmp.68 r9)
         (tmp.93 r9)
         (tmp.67 r9)
         (tmp.94 r13))))
      (begin
        (set! tmp-ra.78 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.92 tmp.22)
                      (set! tmp.92 (bitwise-and tmp.92 7))
                      (set! tmp.66 tmp.92))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.93 tmp.21)
                        (set! tmp.93 (bitwise-and tmp.93 7))
                        (set! tmp.68 tmp.93))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.94 tmp.21)
              (set! tmp.94 (+ tmp.94 tmp.22))
              (set! rax tmp.94)
              (jump tmp-ra.78 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.78 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.78 rbp rax)))))
    (define L.cons.9
      ((locals ())
       (conflicts
        ((tmp-ra.79 (rax tmp.55 tmp.95 tmp.69 tmp.52 tmp.51 rbp r12 rsi rdi))
         (tmp.51 (tmp.55 tmp.95 tmp.69 tmp.52 rbp tmp-ra.79 r12 rsi))
         (tmp.52 (tmp.55 tmp.95 tmp.69 tmp.51 rbp tmp-ra.79 r12))
         (tmp.69 (tmp.51 rbp tmp-ra.79 tmp.52 r12))
         (tmp.95 (tmp.51 rbp tmp-ra.79 tmp.52))
         (tmp.55 (tmp.51 rbp tmp-ra.79 tmp.52))
         (rdi (tmp-ra.79))
         (rsi (tmp.51 tmp-ra.79))
         (r12 (rbp tmp.69 tmp.52 tmp.51 tmp-ra.79))
         (rbp (rax tmp.55 tmp.95 tmp.69 r12 tmp.52 tmp.51 tmp-ra.79))
         (rax (rbp tmp-ra.79))))
       (assignment
        ((tmp-ra.79 r15)
         (tmp.51 r14)
         (tmp.52 r13)
         (tmp.69 r9)
         (tmp.95 r9)
         (tmp.55 r9))))
      (begin
        (set! tmp-ra.79 r15)
        (set! tmp.51 rdi)
        (set! tmp.52 rsi)
        (begin (set! tmp.69 r12) (set! r12 (+ r12 16)))
        (set! tmp.95 tmp.69)
        (set! tmp.95 (+ tmp.95 1))
        (set! tmp.55 tmp.95)
        (mset! tmp.55 -1 tmp.51)
        (mset! tmp.55 7 tmp.52)
        (set! rax tmp.55)
        (jump tmp-ra.79 rbp rax)))
    (define L.fun/pair9174.4
      ((locals ())
       (conflicts
        ((tmp-ra.80 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.80))
         (rsi (r15 rdi rbp tmp-ra.80))
         (rdi (r15 rbp rsi tmp-ra.80))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.80 r15))))
      (begin
        (set! tmp-ra.80 r15)
        (set! rsi 3672)
        (set! rdi 1016)
        (set! r15 tmp-ra.80)
        (jump L.cons.9 rbp r15 rdi rsi)))
    (define L.fun/ascii-char9175.5
      ((locals ())
       (conflicts
        ((tmp-ra.81 (rax rbp)) (rbp (rax tmp-ra.81)) (rax (rbp tmp-ra.81))))
       (assignment ((tmp-ra.81 r15))))
      (begin (set! tmp-ra.81 r15) (set! rax 23598) (jump tmp-ra.81 rbp rax)))
    (define L.fun/empty9176.6
      ((locals ())
       (conflicts
        ((tmp-ra.82 (rax rbp)) (rbp (rax tmp-ra.82)) (rax (rbp tmp-ra.82))))
       (assignment ((tmp-ra.82 r15))))
      (begin (set! tmp-ra.82 r15) (set! rax 22) (jump tmp-ra.82 rbp rax)))
    (define L.fun/error9177.7
      ((locals ())
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83))))
       (assignment ((tmp-ra.83 r15))))
      (begin (set! tmp-ra.83 r15) (set! rax 17470) (jump tmp-ra.83 rbp rax)))
    (begin
      (set! tmp-ra.84 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/pair9174.4 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! pair0.5 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char9175.5 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! ascii-char1.4 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty9176.6 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! empty2.3 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/error9177.7 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! error3.2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi 256)
            (set! rdi 1312)
            (set! r15 L.rp.17)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi 320)
            (set! rdi 1592)
            (set! r15 L.rp.18)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.19)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin
            (set! rsi 456)
            (set! rdi 1512)
            (set! r15 L.rp.20)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin
            (set! rsi 1776)
            (set! rdi 280)
            (set! r15 L.rp.21)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.22)
            (jump L.-.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.23)
            (jump L.*.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! fixnum4.1 rax)
      (set! rax error3.2)
      (jump tmp-ra.84 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.81
        (empty4.1
         error3.2
         void2.3
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
       (tmp.69 (rsi tmp.70 rax rbp tmp-ra.81))
       (tmp.70 (rbp tmp-ra.81 tmp.69))
       (tmp.68 (rsi tmp.71 tmp.73 tmp.72 rax rbp tmp-ra.81))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.81 tmp.68))
       (tmp.73 (rbp tmp-ra.81 tmp.68 tmp.72))
       (tmp.71 (rbp tmp-ra.81 tmp.68))
       (fixnum0.5 (rbp tmp-ra.81))
       (void1.4 (rbp tmp-ra.81))
       (void2.3 (rbp tmp-ra.81))
       (error3.2 (empty4.1 rax rbp tmp-ra.81))
       (empty4.1 (rbp tmp-ra.81 error3.2))
       (rbp
        (empty4.1
         error3.2
         void2.3
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
         tmp-ra.81))
       (rax (error3.2 tmp.72 tmp.68 tmp.69 rbp tmp-ra.81))
       (rsi (tmp.68 tmp.72 tmp.69 r15 rdi rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.81 fv0)
       (tmp.72 fv1)
       (error3.2 fv1)
       (tmp.68 fv2)
       (tmp.69 fv1)
       (tmp.73 r15)
       (tmp.70 r15)
       (tmp.71 r15)
       (empty4.1 r15)
       (fixnum0.5 r15)
       (void1.4 r15)
       (void2.3 r15))))
    (define L.*.11
      ((locals ())
       (conflicts
        ((tmp.55 (rbp tmp-ra.74 tmp.19 tmp.20))
         (tmp.82 (tmp.20 rbp tmp-ra.74 tmp.19))
         (tmp.20
          (rbp tmp-ra.74 tmp.19 tmp.82 tmp.56 tmp.55 tmp.83 tmp.58 tmp.57))
         (tmp.56 (rbp tmp-ra.74 tmp.19 tmp.20))
         (tmp-ra.74
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.82
           tmp.56
           tmp.55
           tmp.83
           tmp.58
           tmp.57
           tmp.85
           tmp.59
           tmp.84
           rax))
         (tmp.84 (rbp tmp-ra.74 tmp.19))
         (tmp.59 (tmp.85 rbp tmp-ra.74 tmp.19))
         (tmp.85 (rbp tmp-ra.74 tmp.59))
         (tmp.58 (rbp tmp-ra.74 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.74
           rsi
           tmp.82
           tmp.56
           tmp.55
           tmp.83
           tmp.58
           tmp.57
           tmp.59
           tmp.84))
         (tmp.83 (tmp.19 rbp tmp-ra.74 tmp.20))
         (tmp.57 (rbp tmp-ra.74 tmp.19 tmp.20))
         (rax (rbp tmp-ra.74))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.74
           tmp.82
           tmp.56
           tmp.55
           tmp.83
           tmp.58
           tmp.57
           tmp.85
           tmp.59
           tmp.84
           rax))
         (rdi (tmp-ra.74))
         (rsi (tmp.19 tmp-ra.74))))
       (assignment
        ((tmp-ra.74 r15)
         (tmp.19 r14)
         (tmp.20 r13)
         (tmp.55 r9)
         (tmp.82 r9)
         (tmp.56 r9)
         (tmp.59 r13)
         (tmp.58 r9)
         (tmp.83 r9)
         (tmp.57 r9)
         (tmp.84 r13)
         (tmp.85 r14))))
      (begin
        (set! tmp-ra.74 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.82 tmp.20)
                      (set! tmp.82 (bitwise-and tmp.82 7))
                      (set! tmp.56 tmp.82))
                    (= tmp.56 0))
                (set! tmp.55 14)
                (set! tmp.55 6))
              (!= tmp.55 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.83 tmp.19)
                        (set! tmp.83 (bitwise-and tmp.83 7))
                        (set! tmp.58 tmp.83))
                      (= tmp.58 0))
                  (set! tmp.57 14)
                  (set! tmp.57 6))
                (!= tmp.57 6))
            (begin
              (set! tmp.84 tmp.20)
              (set! tmp.84 (arithmetic-shift-right tmp.84 3))
              (set! tmp.59 tmp.84)
              (set! tmp.85 tmp.19)
              (set! tmp.85 (* tmp.85 tmp.59))
              (set! rax tmp.85)
              (jump tmp-ra.74 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.74 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.74 rbp rax)))))
    (define L.-.10
      ((locals ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.75 tmp.24 tmp.23))
         (tmp.86 (tmp.24 rbp tmp-ra.75 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.75
           tmp.23
           tmp.86
           tmp.61
           tmp.60
           tmp.87
           tmp.63
           tmp.62
           tmp.88))
         (tmp.61 (rbp tmp-ra.75 tmp.24 tmp.23))
         (tmp-ra.75
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.86
           tmp.61
           tmp.60
           tmp.87
           tmp.63
           tmp.62
           tmp.88
           rax))
         (tmp.88 (rbp tmp-ra.75 tmp.24))
         (tmp.63 (rbp tmp-ra.75 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.75 rsi tmp.86 tmp.61 tmp.60 tmp.87 tmp.63 tmp.62))
         (tmp.87 (tmp.23 rbp tmp-ra.75 tmp.24))
         (tmp.62 (rbp tmp-ra.75 tmp.24 tmp.23))
         (rax (rbp tmp-ra.75))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.75
           tmp.86
           tmp.61
           tmp.60
           tmp.87
           tmp.63
           tmp.62
           tmp.88
           rax))
         (rdi (tmp-ra.75))
         (rsi (tmp.23 tmp-ra.75))))
       (assignment
        ((tmp-ra.75 r15)
         (tmp.24 r14)
         (tmp.23 r13)
         (tmp.60 r9)
         (tmp.86 r9)
         (tmp.61 r9)
         (tmp.63 r9)
         (tmp.87 r9)
         (tmp.62 r9)
         (tmp.88 r13))))
      (begin
        (set! tmp-ra.75 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.86 tmp.24)
                      (set! tmp.86 (bitwise-and tmp.86 7))
                      (set! tmp.61 tmp.86))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.87 tmp.23)
                        (set! tmp.87 (bitwise-and tmp.87 7))
                        (set! tmp.63 tmp.87))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.88 tmp.23)
              (set! tmp.88 (- tmp.88 tmp.24))
              (set! rax tmp.88)
              (jump tmp-ra.75 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.75 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.75 rbp rax)))))
    (define L.+.9
      ((locals ())
       (conflicts
        ((tmp.64 (rbp tmp-ra.76 tmp.22 tmp.21))
         (tmp.89 (tmp.22 rbp tmp-ra.76 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.76
           tmp.21
           tmp.89
           tmp.65
           tmp.64
           tmp.90
           tmp.67
           tmp.66
           tmp.91))
         (tmp.65 (rbp tmp-ra.76 tmp.22 tmp.21))
         (tmp-ra.76
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.89
           tmp.65
           tmp.64
           tmp.90
           tmp.67
           tmp.66
           tmp.91
           rax))
         (tmp.91 (rbp tmp-ra.76 tmp.22))
         (tmp.67 (rbp tmp-ra.76 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.76 rsi tmp.89 tmp.65 tmp.64 tmp.90 tmp.67 tmp.66))
         (tmp.90 (tmp.21 rbp tmp-ra.76 tmp.22))
         (tmp.66 (rbp tmp-ra.76 tmp.22 tmp.21))
         (rax (rbp tmp-ra.76))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.76
           tmp.89
           tmp.65
           tmp.64
           tmp.90
           tmp.67
           tmp.66
           tmp.91
           rax))
         (rdi (tmp-ra.76))
         (rsi (tmp.21 tmp-ra.76))))
       (assignment
        ((tmp-ra.76 r15)
         (tmp.22 r14)
         (tmp.21 r13)
         (tmp.64 r9)
         (tmp.89 r9)
         (tmp.65 r9)
         (tmp.67 r9)
         (tmp.90 r9)
         (tmp.66 r9)
         (tmp.91 r13))))
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
    (define L.fun/error9704.4
      ((locals ())
       (conflicts
        ((tmp-ra.77 (rax rbp)) (rbp (rax tmp-ra.77)) (rax (rbp tmp-ra.77))))
       (assignment ((tmp-ra.77 r15))))
      (begin (set! tmp-ra.77 r15) (set! rax 56382) (jump tmp-ra.77 rbp rax)))
    (define L.fun/void9703.5
      ((locals ())
       (conflicts
        ((tmp-ra.78 (rax rbp)) (rbp (rax tmp-ra.78)) (rax (rbp tmp-ra.78))))
       (assignment ((tmp-ra.78 r15))))
      (begin (set! tmp-ra.78 r15) (set! rax 30) (jump tmp-ra.78 rbp rax)))
    (define L.fun/void9702.6
      ((locals ())
       (conflicts
        ((tmp-ra.79 (rax rbp)) (rbp (rax tmp-ra.79)) (rax (rbp tmp-ra.79))))
       (assignment ((tmp-ra.79 r15))))
      (begin (set! tmp-ra.79 r15) (set! rax 30) (jump tmp-ra.79 rbp rax)))
    (define L.fun/empty9705.7
      ((locals ())
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80))))
       (assignment ((tmp-ra.80 r15))))
      (begin (set! tmp-ra.80 r15) (set! rax 22) (jump tmp-ra.80 rbp rax)))
    (begin
      (set! tmp-ra.81 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.12
          (begin
            (set! rsi 992)
            (set! rdi 904)
            (set! r15 L.rp.12)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin
            (set! rsi 1512)
            (set! rdi 1656)
            (set! r15 L.rp.13)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin
            (set! rsi tmp.70)
            (set! rdi tmp.69)
            (set! r15 L.rp.14)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.68 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin
            (set! rsi 1624)
            (set! rdi 1080)
            (set! r15 L.rp.15)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi 240)
            (set! rdi 296)
            (set! r15 L.rp.16)
            (jump L.*.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.72)
            (set! r15 L.rp.17)
            (jump L.+.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi tmp.71)
            (set! rdi tmp.68)
            (set! r15 L.rp.18)
            (jump L.-.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 40)))
      (set! fixnum0.5 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void9702.6 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! void1.4 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void9703.5 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! void2.3 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error9704.4 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! error3.2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty9705.7 rbp r15)))
        (set! rbp (+ rbp 40)))
      (set! empty4.1 rax)
      (set! rax error3.2)
      (jump tmp-ra.81 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.89
        (pair4.1
         fixnum3.2
         tmp.79
         tmp.81
         tmp.80
         tmp.76
         tmp.78
         tmp.77
         fixnum2.3
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         void1.4
         error0.5
         rax
         rbp))
       (error0.5 (rbp tmp-ra.89))
       (void1.4
        (pair4.1
         fixnum3.2
         tmp.79
         tmp.81
         tmp.80
         tmp.76
         tmp.78
         tmp.77
         fixnum2.3
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         rax
         rbp
         tmp-ra.89))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.89 void1.4))
       (tmp.72 (rbp tmp-ra.89 void1.4 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.89 void1.4))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.89 void1.4 tmp.70))
       (tmp.75 (rbp tmp-ra.89 void1.4 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.89 void1.4 tmp.70))
       (fixnum2.3 (rbp tmp-ra.89 void1.4))
       (tmp.77 (rsi tmp.78 rax rbp tmp-ra.89 void1.4))
       (tmp.78 (rbp tmp-ra.89 void1.4 tmp.77))
       (tmp.76 (rsi tmp.79 tmp.81 tmp.80 rax rbp tmp-ra.89 void1.4))
       (tmp.80 (rsi tmp.81 rax rbp tmp-ra.89 void1.4 tmp.76))
       (tmp.81 (rbp tmp-ra.89 void1.4 tmp.76 tmp.80))
       (tmp.79 (rbp tmp-ra.89 void1.4 tmp.76))
       (fixnum3.2 (rbp tmp-ra.89 void1.4))
       (pair4.1 (rbp tmp-ra.89 void1.4))
       (rbp
        (pair4.1
         fixnum3.2
         tmp.79
         tmp.81
         tmp.80
         tmp.76
         tmp.78
         tmp.77
         fixnum2.3
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         rdi
         rsi
         void1.4
         error0.5
         r15
         rax
         tmp-ra.89))
       (rax (tmp.80 tmp.76 tmp.77 tmp.74 tmp.70 tmp.71 void1.4 rbp tmp-ra.89))
       (r15 (rdi rsi rbp))
       (rsi (tmp.76 tmp.80 tmp.77 tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.89 fv0)
       (void1.4 fv1)
       (tmp.74 fv2)
       (tmp.77 fv2)
       (tmp.76 fv2)
       (tmp.80 fv3)
       (tmp.70 fv3)
       (tmp.71 fv2)
       (tmp.75 r15)
       (tmp.81 r15)
       (tmp.72 r15)
       (tmp.73 r15)
       (tmp.78 r15)
       (tmp.79 r15)
       (fixnum2.3 r15)
       (fixnum3.2 r15)
       (pair4.1 r15)
       (error0.5 r15))))
    (define L.*.11
      ((locals ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.82 tmp.19 tmp.20))
         (tmp.90 (tmp.20 rbp tmp-ra.82 tmp.19))
         (tmp.20
          (rbp tmp-ra.82 tmp.19 tmp.90 tmp.57 tmp.56 tmp.91 tmp.59 tmp.58))
         (tmp.57 (rbp tmp-ra.82 tmp.19 tmp.20))
         (tmp-ra.82
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.90
           tmp.57
           tmp.56
           tmp.91
           tmp.59
           tmp.58
           tmp.93
           tmp.60
           tmp.92
           rax))
         (tmp.92 (rbp tmp-ra.82 tmp.19))
         (tmp.60 (tmp.93 rbp tmp-ra.82 tmp.19))
         (tmp.93 (rbp tmp-ra.82 tmp.60))
         (tmp.59 (rbp tmp-ra.82 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.82
           rsi
           tmp.90
           tmp.57
           tmp.56
           tmp.91
           tmp.59
           tmp.58
           tmp.60
           tmp.92))
         (tmp.91 (tmp.19 rbp tmp-ra.82 tmp.20))
         (tmp.58 (rbp tmp-ra.82 tmp.19 tmp.20))
         (rax (rbp tmp-ra.82))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.82
           tmp.90
           tmp.57
           tmp.56
           tmp.91
           tmp.59
           tmp.58
           tmp.93
           tmp.60
           tmp.92
           rax))
         (rdi (tmp-ra.82))
         (rsi (tmp.19 tmp-ra.82))))
       (assignment
        ((tmp-ra.82 r15)
         (tmp.19 r14)
         (tmp.20 r13)
         (tmp.56 r9)
         (tmp.90 r9)
         (tmp.57 r9)
         (tmp.60 r13)
         (tmp.59 r9)
         (tmp.91 r9)
         (tmp.58 r9)
         (tmp.92 r13)
         (tmp.93 r14))))
      (begin
        (set! tmp-ra.82 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.90 tmp.20)
                      (set! tmp.90 (bitwise-and tmp.90 7))
                      (set! tmp.57 tmp.90))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.91 tmp.19)
                        (set! tmp.91 (bitwise-and tmp.91 7))
                        (set! tmp.59 tmp.91))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.92 tmp.20)
              (set! tmp.92 (arithmetic-shift-right tmp.92 3))
              (set! tmp.60 tmp.92)
              (set! tmp.93 tmp.19)
              (set! tmp.93 (* tmp.93 tmp.60))
              (set! rax tmp.93)
              (jump tmp-ra.82 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.82 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.82 rbp rax)))))
    (define L.+.10
      ((locals ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.83 tmp.22 tmp.21))
         (tmp.94 (tmp.22 rbp tmp-ra.83 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.83
           tmp.21
           tmp.94
           tmp.62
           tmp.61
           tmp.95
           tmp.64
           tmp.63
           tmp.96))
         (tmp.62 (rbp tmp-ra.83 tmp.22 tmp.21))
         (tmp-ra.83
          (tmp.22
           tmp.21
           rbp
           rsi
           rdi
           tmp.94
           tmp.62
           tmp.61
           tmp.95
           tmp.64
           tmp.63
           tmp.96
           rax))
         (tmp.96 (rbp tmp-ra.83 tmp.22))
         (tmp.64 (rbp tmp-ra.83 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.83 rsi tmp.94 tmp.62 tmp.61 tmp.95 tmp.64 tmp.63))
         (tmp.95 (tmp.21 rbp tmp-ra.83 tmp.22))
         (tmp.63 (rbp tmp-ra.83 tmp.22 tmp.21))
         (rax (rbp tmp-ra.83))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.83
           tmp.94
           tmp.62
           tmp.61
           tmp.95
           tmp.64
           tmp.63
           tmp.96
           rax))
         (rdi (tmp-ra.83))
         (rsi (tmp.21 tmp-ra.83))))
       (assignment
        ((tmp-ra.83 r15)
         (tmp.22 r14)
         (tmp.21 r13)
         (tmp.61 r9)
         (tmp.94 r9)
         (tmp.62 r9)
         (tmp.64 r9)
         (tmp.95 r9)
         (tmp.63 r9)
         (tmp.96 r13))))
      (begin
        (set! tmp-ra.83 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.94 tmp.22)
                      (set! tmp.94 (bitwise-and tmp.94 7))
                      (set! tmp.62 tmp.94))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.95 tmp.21)
                        (set! tmp.95 (bitwise-and tmp.95 7))
                        (set! tmp.64 tmp.95))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.96 tmp.21)
              (set! tmp.96 (+ tmp.96 tmp.22))
              (set! rax tmp.96)
              (jump tmp-ra.83 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.83 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.83 rbp rax)))))
    (define L.-.9
      ((locals ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.84 tmp.24 tmp.23))
         (tmp.97 (tmp.24 rbp tmp-ra.84 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.84
           tmp.23
           tmp.97
           tmp.66
           tmp.65
           tmp.98
           tmp.68
           tmp.67
           tmp.99))
         (tmp.66 (rbp tmp-ra.84 tmp.24 tmp.23))
         (tmp-ra.84
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.97
           tmp.66
           tmp.65
           tmp.98
           tmp.68
           tmp.67
           tmp.99
           rax))
         (tmp.99 (rbp tmp-ra.84 tmp.24))
         (tmp.68 (rbp tmp-ra.84 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.84 rsi tmp.97 tmp.66 tmp.65 tmp.98 tmp.68 tmp.67))
         (tmp.98 (tmp.23 rbp tmp-ra.84 tmp.24))
         (tmp.67 (rbp tmp-ra.84 tmp.24 tmp.23))
         (rax (rbp tmp-ra.84))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.84
           tmp.97
           tmp.66
           tmp.65
           tmp.98
           tmp.68
           tmp.67
           tmp.99
           rax))
         (rdi (tmp-ra.84))
         (rsi (tmp.23 tmp-ra.84))))
       (assignment
        ((tmp-ra.84 r15)
         (tmp.24 r14)
         (tmp.23 r13)
         (tmp.65 r9)
         (tmp.97 r9)
         (tmp.66 r9)
         (tmp.68 r9)
         (tmp.98 r9)
         (tmp.67 r9)
         (tmp.99 r13))))
      (begin
        (set! tmp-ra.84 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.97 tmp.24)
                      (set! tmp.97 (bitwise-and tmp.97 7))
                      (set! tmp.66 tmp.97))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.98 tmp.23)
                        (set! tmp.98 (bitwise-and tmp.98 7))
                        (set! tmp.68 tmp.98))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.99 tmp.23)
              (set! tmp.99 (- tmp.99 tmp.24))
              (set! rax tmp.99)
              (jump tmp-ra.84 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.84 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.84 rbp rax)))))
    (define L.cons.8
      ((locals ())
       (conflicts
        ((tmp-ra.85 (rax tmp.55 tmp.100 tmp.69 tmp.52 tmp.51 rbp r12 rsi rdi))
         (tmp.51 (tmp.55 tmp.100 tmp.69 tmp.52 rbp tmp-ra.85 r12 rsi))
         (tmp.52 (tmp.55 tmp.100 tmp.69 tmp.51 rbp tmp-ra.85 r12))
         (tmp.69 (tmp.51 rbp tmp-ra.85 tmp.52 r12))
         (tmp.100 (tmp.51 rbp tmp-ra.85 tmp.52))
         (tmp.55 (tmp.51 rbp tmp-ra.85 tmp.52))
         (rdi (tmp-ra.85))
         (rsi (tmp.51 tmp-ra.85))
         (r12 (rbp tmp.69 tmp.52 tmp.51 tmp-ra.85))
         (rbp (rax tmp.55 tmp.100 tmp.69 r12 tmp.52 tmp.51 tmp-ra.85))
         (rax (rbp tmp-ra.85))))
       (assignment
        ((tmp-ra.85 r15)
         (tmp.51 r14)
         (tmp.52 r13)
         (tmp.69 r9)
         (tmp.100 r9)
         (tmp.55 r9))))
      (begin
        (set! tmp-ra.85 r15)
        (set! tmp.51 rdi)
        (set! tmp.52 rsi)
        (begin (set! tmp.69 r12) (set! r12 (+ r12 16)))
        (set! tmp.100 tmp.69)
        (set! tmp.100 (+ tmp.100 1))
        (set! tmp.55 tmp.100)
        (mset! tmp.55 -1 tmp.51)
        (mset! tmp.55 7 tmp.52)
        (set! rax tmp.55)
        (jump tmp-ra.85 rbp rax)))
    (define L.fun/pair9710.4
      ((locals ())
       (conflicts
        ((tmp-ra.86 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.86))
         (rsi (r15 rdi rbp tmp-ra.86))
         (rdi (r15 rbp rsi tmp-ra.86))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.86 r15))))
      (begin
        (set! tmp-ra.86 r15)
        (set! rsi 2640)
        (set! rdi 792)
        (set! r15 tmp-ra.86)
        (jump L.cons.8 rbp r15 rdi rsi)))
    (define L.fun/error9708.5
      ((locals ())
       (conflicts
        ((tmp-ra.87 (rax rbp)) (rbp (rax tmp-ra.87)) (rax (rbp tmp-ra.87))))
       (assignment ((tmp-ra.87 r15))))
      (begin (set! tmp-ra.87 r15) (set! rax 54846) (jump tmp-ra.87 rbp rax)))
    (define L.fun/void9709.6
      ((locals ())
       (conflicts
        ((tmp-ra.88 (rax rbp)) (rbp (rax tmp-ra.88)) (rax (rbp tmp-ra.88))))
       (assignment ((tmp-ra.88 r15))))
      (begin (set! tmp-ra.88 r15) (set! rax 30) (jump tmp-ra.88 rbp rax)))
    (begin
      (set! tmp-ra.89 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error9708.5 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! error0.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void9709.6 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void1.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.14
          (begin
            (set! rsi 152)
            (set! rdi 2000)
            (set! r15 L.rp.14)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.15
          (begin
            (set! rsi 416)
            (set! rdi 784)
            (set! r15 L.rp.15)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.16
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.16)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.17
          (begin
            (set! rsi 240)
            (set! rdi 1824)
            (set! r15 L.rp.17)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi 312)
            (set! rdi 320)
            (set! r15 L.rp.18)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.19)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.20)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum2.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 992)
            (set! rdi 216)
            (set! r15 L.rp.21)
            (jump L.*.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 568)
            (set! rdi 168)
            (set! r15 L.rp.22)
            (jump L.*.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.78)
            (set! rdi tmp.77)
            (set! r15 L.rp.23)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 1352)
            (set! rdi 1248)
            (set! r15 L.rp.24)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1632)
            (set! rdi 168)
            (set! r15 L.rp.25)
            (jump L.-.9 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.81)
            (set! rdi tmp.80)
            (set! r15 L.rp.26)
            (jump L.+.10 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.76)
            (set! r15 L.rp.27)
            (jump L.*.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum3.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin (set! r15 L.rp.28) (jump L.fun/pair9710.4 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! pair4.1 rax)
      (set! rax void1.4)
      (jump tmp-ra.89 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.85
        (fixnum4.1
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         void3.2
         empty2.3
         void1.4
         pair0.5
         rax
         rbp))
       (pair0.5 (rbp tmp-ra.85))
       (void1.4 (rbp tmp-ra.85))
       (empty2.3 (rbp tmp-ra.85))
       (void3.2 (rbp tmp-ra.85))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.85))
       (tmp.72 (rbp tmp-ra.85 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.85))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.85 tmp.70))
       (tmp.75 (rbp tmp-ra.85 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.85 tmp.70))
       (fixnum4.1 (rbp tmp-ra.85))
       (rbp
        (fixnum4.1
         tmp.73
         tmp.75
         tmp.74
         tmp.70
         tmp.72
         tmp.71
         rdi
         rsi
         void3.2
         empty2.3
         void1.4
         pair0.5
         r15
         rax
         tmp-ra.85))
       (rax (tmp.74 tmp.70 tmp.71 rbp tmp-ra.85))
       (r15 (rdi rsi rbp))
       (rsi (tmp.70 tmp.74 tmp.71 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.85 fv0)
       (tmp.74 fv1)
       (tmp.70 fv2)
       (tmp.71 fv1)
       (tmp.75 r15)
       (tmp.72 r15)
       (tmp.73 r15)
       (pair0.5 r15)
       (void1.4 r15)
       (empty2.3 r15)
       (void3.2 r15)
       (fixnum4.1 r15))))
    (define L.*.13
      ((locals ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp.86 (tmp.20 rbp tmp-ra.76 tmp.19))
         (tmp.20
          (rbp tmp-ra.76 tmp.19 tmp.86 tmp.57 tmp.56 tmp.87 tmp.59 tmp.58))
         (tmp.57 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp-ra.76
          (tmp.20
           tmp.19
           rbp
           rsi
           rdi
           tmp.86
           tmp.57
           tmp.56
           tmp.87
           tmp.59
           tmp.58
           tmp.89
           tmp.60
           tmp.88
           rax))
         (tmp.88 (rbp tmp-ra.76 tmp.19))
         (tmp.60 (tmp.89 rbp tmp-ra.76 tmp.19))
         (tmp.89 (rbp tmp-ra.76 tmp.60))
         (tmp.59 (rbp tmp-ra.76 tmp.19 tmp.20))
         (tmp.19
          (tmp.20
           rbp
           tmp-ra.76
           rsi
           tmp.86
           tmp.57
           tmp.56
           tmp.87
           tmp.59
           tmp.58
           tmp.60
           tmp.88))
         (tmp.87 (tmp.19 rbp tmp-ra.76 tmp.20))
         (tmp.58 (rbp tmp-ra.76 tmp.19 tmp.20))
         (rax (rbp tmp-ra.76))
         (rbp
          (tmp.20
           tmp.19
           tmp-ra.76
           tmp.86
           tmp.57
           tmp.56
           tmp.87
           tmp.59
           tmp.58
           tmp.89
           tmp.60
           tmp.88
           rax))
         (rdi (tmp-ra.76))
         (rsi (tmp.19 tmp-ra.76))))
       (assignment
        ((tmp-ra.76 r15)
         (tmp.19 r14)
         (tmp.20 r13)
         (tmp.56 r9)
         (tmp.86 r9)
         (tmp.57 r9)
         (tmp.60 r13)
         (tmp.59 r9)
         (tmp.87 r9)
         (tmp.58 r9)
         (tmp.88 r13)
         (tmp.89 r14))))
      (begin
        (set! tmp-ra.76 r15)
        (set! tmp.19 rdi)
        (set! tmp.20 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.86 tmp.20)
                      (set! tmp.86 (bitwise-and tmp.86 7))
                      (set! tmp.57 tmp.86))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.87 tmp.19)
                        (set! tmp.87 (bitwise-and tmp.87 7))
                        (set! tmp.59 tmp.87))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.88 tmp.20)
              (set! tmp.88 (arithmetic-shift-right tmp.88 3))
              (set! tmp.60 tmp.88)
              (set! tmp.89 tmp.19)
              (set! tmp.89 (* tmp.89 tmp.60))
              (set! rax tmp.89)
              (jump tmp-ra.76 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.76 rbp rax)))))
    (define L.-.12
      ((locals ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.77 tmp.24 tmp.23))
         (tmp.90 (tmp.24 rbp tmp-ra.77 tmp.23))
         (tmp.24
          (rbp
           tmp-ra.77
           tmp.23
           tmp.90
           tmp.62
           tmp.61
           tmp.91
           tmp.64
           tmp.63
           tmp.92))
         (tmp.62 (rbp tmp-ra.77 tmp.24 tmp.23))
         (tmp-ra.77
          (tmp.24
           tmp.23
           rbp
           rsi
           rdi
           tmp.90
           tmp.62
           tmp.61
           tmp.91
           tmp.64
           tmp.63
           tmp.92
           rax))
         (tmp.92 (rbp tmp-ra.77 tmp.24))
         (tmp.64 (rbp tmp-ra.77 tmp.24 tmp.23))
         (tmp.23
          (tmp.24 rbp tmp-ra.77 rsi tmp.90 tmp.62 tmp.61 tmp.91 tmp.64 tmp.63))
         (tmp.91 (tmp.23 rbp tmp-ra.77 tmp.24))
         (tmp.63 (rbp tmp-ra.77 tmp.24 tmp.23))
         (rax (rbp tmp-ra.77))
         (rbp
          (tmp.24
           tmp.23
           tmp-ra.77
           tmp.90
           tmp.62
           tmp.61
           tmp.91
           tmp.64
           tmp.63
           tmp.92
           rax))
         (rdi (tmp-ra.77))
         (rsi (tmp.23 tmp-ra.77))))
       (assignment
        ((tmp-ra.77 r15)
         (tmp.24 r14)
         (tmp.23 r13)
         (tmp.61 r9)
         (tmp.90 r9)
         (tmp.62 r9)
         (tmp.64 r9)
         (tmp.91 r9)
         (tmp.63 r9)
         (tmp.92 r13))))
      (begin
        (set! tmp-ra.77 r15)
        (set! tmp.23 rdi)
        (set! tmp.24 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.90 tmp.24)
                      (set! tmp.90 (bitwise-and tmp.90 7))
                      (set! tmp.62 tmp.90))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.91 tmp.23)
                        (set! tmp.91 (bitwise-and tmp.91 7))
                        (set! tmp.64 tmp.91))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.92 tmp.23)
              (set! tmp.92 (- tmp.92 tmp.24))
              (set! rax tmp.92)
              (jump tmp-ra.77 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.77 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.77 rbp rax)))))
    (define L.+.11
      ((locals ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.78 tmp.22 tmp.21))
         (tmp.93 (tmp.22 rbp tmp-ra.78 tmp.21))
         (tmp.22
          (rbp
           tmp-ra.78
           tmp.21
           tmp.93
           tmp.66
           tmp.65
           tmp.94
           tmp.68
           tmp.67
           tmp.95))
         (tmp.66 (rbp tmp-ra.78 tmp.22 tmp.21))
         (tmp-ra.78
          (tmp.22
           tmp.21
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
         (tmp.95 (rbp tmp-ra.78 tmp.22))
         (tmp.68 (rbp tmp-ra.78 tmp.22 tmp.21))
         (tmp.21
          (tmp.22 rbp tmp-ra.78 rsi tmp.93 tmp.66 tmp.65 tmp.94 tmp.68 tmp.67))
         (tmp.94 (tmp.21 rbp tmp-ra.78 tmp.22))
         (tmp.67 (rbp tmp-ra.78 tmp.22 tmp.21))
         (rax (rbp tmp-ra.78))
         (rbp
          (tmp.22
           tmp.21
           tmp-ra.78
           tmp.93
           tmp.66
           tmp.65
           tmp.94
           tmp.68
           tmp.67
           tmp.95
           rax))
         (rdi (tmp-ra.78))
         (rsi (tmp.21 tmp-ra.78))))
       (assignment
        ((tmp-ra.78 r15)
         (tmp.22 r14)
         (tmp.21 r13)
         (tmp.65 r9)
         (tmp.93 r9)
         (tmp.66 r9)
         (tmp.68 r9)
         (tmp.94 r9)
         (tmp.67 r9)
         (tmp.95 r13))))
      (begin
        (set! tmp-ra.78 r15)
        (set! tmp.21 rdi)
        (set! tmp.22 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.93 tmp.22)
                      (set! tmp.93 (bitwise-and tmp.93 7))
                      (set! tmp.66 tmp.93))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.94 tmp.21)
                        (set! tmp.94 (bitwise-and tmp.94 7))
                        (set! tmp.68 tmp.94))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.95 tmp.21)
              (set! tmp.95 (+ tmp.95 tmp.22))
              (set! rax tmp.95)
              (jump tmp-ra.78 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.78 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.78 rbp rax)))))
    (define L.cons.10
      ((locals ())
       (conflicts
        ((tmp-ra.79 (rax tmp.55 tmp.96 tmp.69 tmp.52 tmp.51 rbp r12 rsi rdi))
         (tmp.51 (tmp.55 tmp.96 tmp.69 tmp.52 rbp tmp-ra.79 r12 rsi))
         (tmp.52 (tmp.55 tmp.96 tmp.69 tmp.51 rbp tmp-ra.79 r12))
         (tmp.69 (tmp.51 rbp tmp-ra.79 tmp.52 r12))
         (tmp.96 (tmp.51 rbp tmp-ra.79 tmp.52))
         (tmp.55 (tmp.51 rbp tmp-ra.79 tmp.52))
         (rdi (tmp-ra.79))
         (rsi (tmp.51 tmp-ra.79))
         (r12 (rbp tmp.69 tmp.52 tmp.51 tmp-ra.79))
         (rbp (rax tmp.55 tmp.96 tmp.69 r12 tmp.52 tmp.51 tmp-ra.79))
         (rax (rbp tmp-ra.79))))
       (assignment
        ((tmp-ra.79 r15)
         (tmp.51 r14)
         (tmp.52 r13)
         (tmp.69 r9)
         (tmp.96 r9)
         (tmp.55 r9))))
      (begin
        (set! tmp-ra.79 r15)
        (set! tmp.51 rdi)
        (set! tmp.52 rsi)
        (begin (set! tmp.69 r12) (set! r12 (+ r12 16)))
        (set! tmp.96 tmp.69)
        (set! tmp.96 (+ tmp.96 1))
        (set! tmp.55 tmp.96)
        (mset! tmp.55 -1 tmp.51)
        (mset! tmp.55 7 tmp.52)
        (set! rax tmp.55)
        (jump tmp-ra.79 rbp rax)))
    (define L.fun/void9976.4
      ((locals ())
       (conflicts
        ((tmp-ra.80 (rax rbp)) (rbp (rax tmp-ra.80)) (rax (rbp tmp-ra.80))))
       (assignment ((tmp-ra.80 r15))))
      (begin (set! tmp-ra.80 r15) (set! rax 30) (jump tmp-ra.80 rbp rax)))
    (define L.fun/pair9973.5
      ((locals ())
       (conflicts
        ((tmp-ra.81 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.81))
         (rsi (r15 rdi rbp tmp-ra.81))
         (rdi (r15 rbp rsi tmp-ra.81))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.81 r15))))
      (begin
        (set! tmp-ra.81 r15)
        (set! rsi 3448)
        (set! rdi 1352)
        (set! r15 tmp-ra.81)
        (jump L.cons.10 rbp r15 rdi rsi)))
    (define L.fun/empty9975.6
      ((locals ())
       (conflicts
        ((tmp-ra.82 (rax rbp)) (rbp (rax tmp-ra.82)) (rax (rbp tmp-ra.82))))
       (assignment ((tmp-ra.82 r15))))
      (begin (set! tmp-ra.82 r15) (set! rax 22) (jump tmp-ra.82 rbp rax)))
    (define L.fun/void9974.7
      ((locals ())
       (conflicts
        ((tmp-ra.83 (rax rbp)) (rbp (rax tmp-ra.83)) (rax (rbp tmp-ra.83))))
       (assignment ((tmp-ra.83 r15))))
      (begin (set! tmp-ra.83 r15) (set! rax 30) (jump tmp-ra.83 rbp rax)))
    (define L.fun/ascii-char9977.8
      ((locals ())
       (conflicts
        ((tmp-ra.84 (rax rbp)) (rbp (rax tmp-ra.84)) (rax (rbp tmp-ra.84))))
       (assignment ((tmp-ra.84 r15))))
      (begin (set! tmp-ra.84 r15) (set! rax 20782) (jump tmp-ra.84 rbp rax)))
    (begin
      (set! tmp-ra.85 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/pair9973.5 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! pair0.5 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/void9974.7 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! void1.4 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/empty9975.6 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! empty2.3 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void9976.4 rbp r15)))
        (set! rbp (+ rbp 32)))
      (set! void3.2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 1288)
            (set! rdi 1608)
            (set! r15 L.rp.18)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1528)
            (set! rdi 1992)
            (set! r15 L.rp.19)
            (jump L.-.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.20)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi 1152)
            (set! rdi 688)
            (set! r15 L.rp.21)
            (jump L.-.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi 1848)
            (set! rdi 1048)
            (set! r15 L.rp.22)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.23)
            (jump L.+.11 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.24
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.24)
            (jump L.-.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 32)))
      (set! fixnum4.1 rax)
      (set! r15 tmp-ra.85)
      (jump L.fun/ascii-char9977.8 rbp r15))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.68
        (void5.1
         empty4.2
         ascii-char3.3
         ascii-char2.4
         error1.5
         empty0.6
         rax
         rbp))
       (empty0.6 (rbp tmp-ra.68))
       (error1.5 (rbp tmp-ra.68))
       (ascii-char2.4 (rbp tmp-ra.68))
       (ascii-char3.3 (rbp tmp-ra.68))
       (empty4.2 (rbp tmp-ra.68))
       (void5.1 (rbp tmp-ra.68))
       (rbp
        (void5.1
         empty4.2
         ascii-char3.3
         ascii-char2.4
         error1.5
         empty0.6
         r15
         rax
         tmp-ra.68))
       (rax (rbp tmp-ra.68))
       (r15 (rbp))))
     (assignment
      ((tmp-ra.68 fv0)
       (empty0.6 r15)
       (error1.5 r15)
       (ascii-char2.4 r15)
       (ascii-char3.3 r15)
       (empty4.2 r15)
       (void5.1 r15))))
    (define L.fun/void15785.4
      ((locals ())
       (conflicts ((tmp-ra.56 (rbp)) (rbp (r15 tmp-ra.56)) (r15 (rbp))))
       (assignment ((tmp-ra.56 r15))))
      (begin
        (set! tmp-ra.56 r15)
        (set! r15 tmp-ra.56)
        (jump L.fun/void15786.9 rbp r15)))
    (define L.fun/empty15784.5
      ((locals ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57))))
       (assignment ((tmp-ra.57 r15))))
      (begin (set! tmp-ra.57 r15) (set! rax 22) (jump tmp-ra.57 rbp rax)))
    (define L.fun/error15778.6
      ((locals ())
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ((tmp-ra.58 r15))))
      (begin (set! tmp-ra.58 r15) (set! rax 4670) (jump tmp-ra.58 rbp rax)))
    (define L.fun/ascii-char15782.7
      ((locals ())
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ((tmp-ra.59 r15))))
      (begin (set! tmp-ra.59 r15) (set! rax 29742) (jump tmp-ra.59 rbp rax)))
    (define L.fun/error15777.8
      ((locals ())
       (conflicts ((tmp-ra.60 (rbp)) (rbp (r15 tmp-ra.60)) (r15 (rbp))))
       (assignment ((tmp-ra.60 r15))))
      (begin
        (set! tmp-ra.60 r15)
        (set! r15 tmp-ra.60)
        (jump L.fun/error15778.6 rbp r15)))
    (define L.fun/void15786.9
      ((locals ())
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ((tmp-ra.61 r15))))
      (begin (set! tmp-ra.61 r15) (set! rax 30) (jump tmp-ra.61 rbp rax)))
    (define L.fun/ascii-char15781.10
      ((locals ())
       (conflicts ((tmp-ra.62 (rbp)) (rbp (r15 tmp-ra.62)) (r15 (rbp))))
       (assignment ((tmp-ra.62 r15))))
      (begin
        (set! tmp-ra.62 r15)
        (set! r15 tmp-ra.62)
        (jump L.fun/ascii-char15782.7 rbp r15)))
    (define L.fun/ascii-char15779.11
      ((locals ())
       (conflicts ((tmp-ra.63 (rbp)) (rbp (r15 tmp-ra.63)) (r15 (rbp))))
       (assignment ((tmp-ra.63 r15))))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/ascii-char15780.14 rbp r15)))
    (define L.fun/empty15775.12
      ((locals ())
       (conflicts ((tmp-ra.64 (rbp)) (rbp (r15 tmp-ra.64)) (r15 (rbp))))
       (assignment ((tmp-ra.64 r15))))
      (begin
        (set! tmp-ra.64 r15)
        (set! r15 tmp-ra.64)
        (jump L.fun/empty15776.15 rbp r15)))
    (define L.fun/empty15783.13
      ((locals ())
       (conflicts ((tmp-ra.65 (rbp)) (rbp (r15 tmp-ra.65)) (r15 (rbp))))
       (assignment ((tmp-ra.65 r15))))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/empty15784.5 rbp r15)))
    (define L.fun/ascii-char15780.14
      ((locals ())
       (conflicts
        ((tmp-ra.66 (rax rbp)) (rbp (rax tmp-ra.66)) (rax (rbp tmp-ra.66))))
       (assignment ((tmp-ra.66 r15))))
      (begin (set! tmp-ra.66 r15) (set! rax 21038) (jump tmp-ra.66 rbp rax)))
    (define L.fun/empty15776.15
      ((locals ())
       (conflicts
        ((tmp-ra.67 (rax rbp)) (rbp (rax tmp-ra.67)) (rax (rbp tmp-ra.67))))
       (assignment ((tmp-ra.67 r15))))
      (begin (set! tmp-ra.67 r15) (set! rax 22) (jump tmp-ra.67 rbp rax)))
    (begin
      (set! tmp-ra.68 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/empty15775.12 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! empty0.6 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error15777.8 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char15779.11 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char2.4 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char15781.10 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char3.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty15783.13 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! empty4.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/void15785.4 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! void5.1 rax)
      (set! rax void5.1)
      (jump tmp-ra.68 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.72
        (void5.1
         error4.2
         boolean3.3
         tmp.59
         boolean2.4
         tmp.58
         void1.5
         ascii-char0.6
         rax
         rbp))
       (ascii-char0.6
        (void5.1
         error4.2
         boolean3.3
         tmp.59
         boolean2.4
         tmp.58
         void1.5
         rax
         rbp
         tmp-ra.72))
       (void1.5 (rbp tmp-ra.72 ascii-char0.6))
       (tmp.58 (rbp tmp-ra.72 ascii-char0.6))
       (boolean2.4 (rbp tmp-ra.72 ascii-char0.6))
       (tmp.59 (rbp tmp-ra.72 ascii-char0.6))
       (boolean3.3 (rbp tmp-ra.72 ascii-char0.6))
       (error4.2 (rbp tmp-ra.72 ascii-char0.6))
       (void5.1 (rbp tmp-ra.72 ascii-char0.6))
       (rbp
        (void5.1
         error4.2
         boolean3.3
         tmp.59
         boolean2.4
         rdi
         tmp.58
         void1.5
         ascii-char0.6
         r15
         rax
         tmp-ra.72))
       (rax (ascii-char0.6 rbp tmp-ra.72))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment
      ((tmp-ra.72 fv0)
       (ascii-char0.6 fv1)
       (void1.5 r15)
       (tmp.58 r15)
       (boolean2.4 r15)
       (tmp.59 r15)
       (boolean3.3 r15)
       (error4.2 r15)
       (void5.1 r15))))
    (define L.void?.16
      ((locals ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.60))
         (tmp.46 (rbp tmp-ra.60))
         (tmp.73 (rbp tmp-ra.60))
         (tmp-ra.60 (tmp.46 rbp rdi tmp.73 tmp.56 rax))
         (rax (rbp tmp-ra.60))
         (rbp (tmp.46 tmp-ra.60 tmp.73 tmp.56 rax))
         (rdi (tmp-ra.60))))
       (assignment ((tmp-ra.60 r15) (tmp.56 r14) (tmp.46 r14) (tmp.73 r14))))
      (begin
        (set! tmp-ra.60 r15)
        (set! tmp.46 rdi)
        (if (begin
              (begin
                (set! tmp.73 tmp.46)
                (set! tmp.73 (bitwise-and tmp.73 255))
                (set! tmp.56 tmp.73))
              (= tmp.56 30))
          (begin (set! rax 14) (jump tmp-ra.60 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.60 rbp rax)))))
    (define L.boolean?.15
      ((locals ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.61))
         (tmp.44 (rbp tmp-ra.61))
         (tmp.74 (rbp tmp-ra.61))
         (tmp-ra.61 (tmp.44 rbp rdi tmp.74 tmp.57 rax))
         (rax (rbp tmp-ra.61))
         (rbp (tmp.44 tmp-ra.61 tmp.74 tmp.57 rax))
         (rdi (tmp-ra.61))))
       (assignment ((tmp-ra.61 r15) (tmp.57 r14) (tmp.44 r14) (tmp.74 r14))))
      (begin
        (set! tmp-ra.61 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.74 tmp.44)
                (set! tmp.74 (bitwise-and tmp.74 247))
                (set! tmp.57 tmp.74))
              (= tmp.57 6))
          (begin (set! rax 14) (jump tmp-ra.61 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.61 rbp rax)))))
    (define L.fun/any18974.4
      ((locals ())
       (conflicts
        ((tmp-ra.62 (rax rbp)) (rbp (rax tmp-ra.62)) (rax (rbp tmp-ra.62))))
       (assignment ((tmp-ra.62 r15))))
      (begin (set! tmp-ra.62 r15) (set! rax 30) (jump tmp-ra.62 rbp rax)))
    (define L.fun/void18977.5
      ((locals ())
       (conflicts ((tmp-ra.63 (rbp)) (rbp (r15 tmp-ra.63)) (r15 (rbp))))
       (assignment ((tmp-ra.63 r15))))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/void18978.12 rbp r15)))
    (define L.fun/ascii-char18970.6
      ((locals ())
       (conflicts
        ((tmp-ra.64 (rax rbp)) (rbp (rax tmp-ra.64)) (rax (rbp tmp-ra.64))))
       (assignment ((tmp-ra.64 r15))))
      (begin (set! tmp-ra.64 r15) (set! rax 23854) (jump tmp-ra.64 rbp rax)))
    (define L.fun/ascii-char18969.7
      ((locals ())
       (conflicts ((tmp-ra.65 (rbp)) (rbp (r15 tmp-ra.65)) (r15 (rbp))))
       (assignment ((tmp-ra.65 r15))))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/ascii-char18970.6 rbp r15)))
    (define L.fun/error18976.8
      ((locals ())
       (conflicts
        ((tmp-ra.66 (rax rbp)) (rbp (rax tmp-ra.66)) (rax (rbp tmp-ra.66))))
       (assignment ((tmp-ra.66 r15))))
      (begin (set! tmp-ra.66 r15) (set! rax 39742) (jump tmp-ra.66 rbp rax)))
    (define L.fun/void18971.9
      ((locals ())
       (conflicts ((tmp-ra.67 (rbp)) (rbp (r15 tmp-ra.67)) (r15 (rbp))))
       (assignment ((tmp-ra.67 r15))))
      (begin
        (set! tmp-ra.67 r15)
        (set! r15 tmp-ra.67)
        (jump L.fun/void18972.10 rbp r15)))
    (define L.fun/void18972.10
      ((locals ())
       (conflicts
        ((tmp-ra.68 (rax rbp)) (rbp (rax tmp-ra.68)) (rax (rbp tmp-ra.68))))
       (assignment ((tmp-ra.68 r15))))
      (begin (set! tmp-ra.68 r15) (set! rax 30) (jump tmp-ra.68 rbp rax)))
    (define L.fun/error18975.11
      ((locals ())
       (conflicts ((tmp-ra.69 (rbp)) (rbp (r15 tmp-ra.69)) (r15 (rbp))))
       (assignment ((tmp-ra.69 r15))))
      (begin
        (set! tmp-ra.69 r15)
        (set! r15 tmp-ra.69)
        (jump L.fun/error18976.8 rbp r15)))
    (define L.fun/void18978.12
      ((locals ())
       (conflicts
        ((tmp-ra.70 (rax rbp)) (rbp (rax tmp-ra.70)) (rax (rbp tmp-ra.70))))
       (assignment ((tmp-ra.70 r15))))
      (begin (set! tmp-ra.70 r15) (set! rax 30) (jump tmp-ra.70 rbp rax)))
    (define L.fun/any18973.13
      ((locals ())
       (conflicts
        ((tmp-ra.71 (rax rbp)) (rbp (rax tmp-ra.71)) (rax (rbp tmp-ra.71))))
       (assignment ((tmp-ra.71 r15))))
      (begin (set! tmp-ra.71 r15) (set! rax 60990) (jump tmp-ra.71 rbp rax)))
    (begin
      (set! tmp-ra.72 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char18969.7 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char0.6 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void18971.9 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void1.5 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/any18973.13 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! tmp.58 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin
            (set! rdi tmp.58)
            (set! r15 L.rp.20)
            (jump L.boolean?.15 rbp r15 rdi)))
        (set! rbp (+ rbp 16)))
      (set! boolean2.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/any18974.4 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! tmp.59 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin
            (set! rdi tmp.59)
            (set! r15 L.rp.22)
            (jump L.void?.16 rbp r15 rdi)))
        (set! rbp (+ rbp 16)))
      (set! boolean3.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error18975.11 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error4.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/void18977.5 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void5.1 rax)
      (set! rax ascii-char0.6)
      (jump tmp-ra.72 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.71
        (pair5.1 empty4.2 empty3.3 ascii-char2.4 error1.5 error0.6 rax rbp))
       (error0.6 (rbp tmp-ra.71))
       (error1.5 (rbp tmp-ra.71))
       (ascii-char2.4 (rbp tmp-ra.71))
       (empty3.3 (rbp tmp-ra.71))
       (empty4.2 (rbp tmp-ra.71))
       (pair5.1 (rbp tmp-ra.71))
       (rbp
        (pair5.1
         empty4.2
         empty3.3
         ascii-char2.4
         error1.5
         error0.6
         r15
         rax
         tmp-ra.71))
       (rax (rbp tmp-ra.71))
       (r15 (rbp))))
     (assignment
      ((tmp-ra.71 fv0)
       (error0.6 r15)
       (error1.5 r15)
       (ascii-char2.4 r15)
       (empty3.3 r15)
       (empty4.2 r15)
       (pair5.1 r15))))
    (define L.cons.17
      ((locals ())
       (conflicts
        ((tmp-ra.58 (rax tmp.56 tmp.72 tmp.57 tmp.53 tmp.52 rbp r12 rsi rdi))
         (tmp.52 (tmp.56 tmp.72 tmp.57 tmp.53 rbp tmp-ra.58 r12 rsi))
         (tmp.53 (tmp.56 tmp.72 tmp.57 tmp.52 rbp tmp-ra.58 r12))
         (tmp.57 (tmp.52 rbp tmp-ra.58 tmp.53 r12))
         (tmp.72 (tmp.52 rbp tmp-ra.58 tmp.53))
         (tmp.56 (tmp.52 rbp tmp-ra.58 tmp.53))
         (rdi (tmp-ra.58))
         (rsi (tmp.52 tmp-ra.58))
         (r12 (rbp tmp.57 tmp.53 tmp.52 tmp-ra.58))
         (rbp (rax tmp.56 tmp.72 tmp.57 r12 tmp.53 tmp.52 tmp-ra.58))
         (rax (rbp tmp-ra.58))))
       (assignment
        ((tmp-ra.58 r15)
         (tmp.52 r14)
         (tmp.53 r13)
         (tmp.57 r9)
         (tmp.72 r9)
         (tmp.56 r9))))
      (begin
        (set! tmp-ra.58 r15)
        (set! tmp.52 rdi)
        (set! tmp.53 rsi)
        (begin (set! tmp.57 r12) (set! r12 (+ r12 16)))
        (set! tmp.72 tmp.57)
        (set! tmp.72 (+ tmp.72 1))
        (set! tmp.56 tmp.72)
        (mset! tmp.56 -1 tmp.52)
        (mset! tmp.56 7 tmp.53)
        (set! rax tmp.56)
        (jump tmp-ra.58 rbp rax)))
    (define L.fun/error19375.4
      ((locals ())
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ((tmp-ra.59 r15))))
      (begin (set! tmp-ra.59 r15) (set! rax 5438) (jump tmp-ra.59 rbp rax)))
    (define L.fun/empty19379.5
      ((locals ())
       (conflicts
        ((tmp-ra.60 (rax rbp)) (rbp (rax tmp-ra.60)) (rax (rbp tmp-ra.60))))
       (assignment ((tmp-ra.60 r15))))
      (begin (set! tmp-ra.60 r15) (set! rax 22) (jump tmp-ra.60 rbp rax)))
    (define L.fun/error19373.6
      ((locals ())
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ((tmp-ra.61 r15))))
      (begin (set! tmp-ra.61 r15) (set! rax 1086) (jump tmp-ra.61 rbp rax)))
    (define L.fun/pair19383.7
      ((locals ())
       (conflicts
        ((tmp-ra.62 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.62))
         (rsi (r15 rdi rbp tmp-ra.62))
         (rdi (r15 rbp rsi tmp-ra.62))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.62 r15))))
      (begin
        (set! tmp-ra.62 r15)
        (set! rsi 3048)
        (set! rdi 1696)
        (set! r15 tmp-ra.62)
        (jump L.cons.17 rbp r15 rdi rsi)))
    (define L.fun/ascii-char19377.8
      ((locals ())
       (conflicts
        ((tmp-ra.63 (rax rbp)) (rbp (rax tmp-ra.63)) (rax (rbp tmp-ra.63))))
       (assignment ((tmp-ra.63 r15))))
      (begin (set! tmp-ra.63 r15) (set! rax 28718) (jump tmp-ra.63 rbp rax)))
    (define L.fun/pair19382.9
      ((locals ())
       (conflicts ((tmp-ra.64 (rbp)) (rbp (r15 tmp-ra.64)) (r15 (rbp))))
       (assignment ((tmp-ra.64 r15))))
      (begin
        (set! tmp-ra.64 r15)
        (set! r15 tmp-ra.64)
        (jump L.fun/pair19383.7 rbp r15)))
    (define L.fun/ascii-char19376.10
      ((locals ())
       (conflicts ((tmp-ra.65 (rbp)) (rbp (r15 tmp-ra.65)) (r15 (rbp))))
       (assignment ((tmp-ra.65 r15))))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/ascii-char19377.8 rbp r15)))
    (define L.fun/empty19378.11
      ((locals ())
       (conflicts ((tmp-ra.66 (rbp)) (rbp (r15 tmp-ra.66)) (r15 (rbp))))
       (assignment ((tmp-ra.66 r15))))
      (begin
        (set! tmp-ra.66 r15)
        (set! r15 tmp-ra.66)
        (jump L.fun/empty19379.5 rbp r15)))
    (define L.fun/empty19381.12
      ((locals ())
       (conflicts
        ((tmp-ra.67 (rax rbp)) (rbp (rax tmp-ra.67)) (rax (rbp tmp-ra.67))))
       (assignment ((tmp-ra.67 r15))))
      (begin (set! tmp-ra.67 r15) (set! rax 22) (jump tmp-ra.67 rbp rax)))
    (define L.fun/empty19380.13
      ((locals ())
       (conflicts ((tmp-ra.68 (rbp)) (rbp (r15 tmp-ra.68)) (r15 (rbp))))
       (assignment ((tmp-ra.68 r15))))
      (begin
        (set! tmp-ra.68 r15)
        (set! r15 tmp-ra.68)
        (jump L.fun/empty19381.12 rbp r15)))
    (define L.fun/error19372.14
      ((locals ())
       (conflicts ((tmp-ra.69 (rbp)) (rbp (r15 tmp-ra.69)) (r15 (rbp))))
       (assignment ((tmp-ra.69 r15))))
      (begin
        (set! tmp-ra.69 r15)
        (set! r15 tmp-ra.69)
        (jump L.fun/error19373.6 rbp r15)))
    (define L.fun/error19374.15
      ((locals ())
       (conflicts ((tmp-ra.70 (rbp)) (rbp (r15 tmp-ra.70)) (r15 (rbp))))
       (assignment ((tmp-ra.70 r15))))
      (begin
        (set! tmp-ra.70 r15)
        (set! r15 tmp-ra.70)
        (jump L.fun/error19375.4 rbp r15)))
    (begin
      (set! tmp-ra.71 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error19372.14 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error0.6 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error19374.15 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char19376.10 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char2.4 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty19378.11 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! empty3.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty19380.13 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! empty4.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/pair19382.9 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! pair5.1 rax)
      (set! rax pair5.1)
      (jump tmp-ra.71 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.124
        (rdi
         tmp.112
         fixnum5.1
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
         void4.2
         fixnum3.3
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
         ascii-char2.4
         fixnum1.5
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
         ascii-char0.6
         rax
         rbp))
       (ascii-char0.6 (rbp tmp-ra.124))
       (tmp.72 (rsi tmp.73 rax rbp tmp-ra.124))
       (tmp.73 (rbp tmp-ra.124 tmp.72))
       (tmp.71 (rsi tmp.74 tmp.76 tmp.75 rax rbp tmp-ra.124))
       (tmp.75 (rsi tmp.76 rax rbp tmp-ra.124 tmp.71))
       (tmp.76 (rbp tmp-ra.124 tmp.71 tmp.75))
       (tmp.74 (rbp tmp-ra.124 tmp.71))
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
         tmp-ra.124))
       (tmp.79 (rsi tmp.80 rax rbp tmp-ra.124 tmp.70))
       (tmp.80 (rbp tmp-ra.124 tmp.70 tmp.79))
       (tmp.78 (rsi tmp.81 tmp.83 tmp.82 rax rbp tmp-ra.124 tmp.70))
       (tmp.82 (rsi tmp.83 rax rbp tmp-ra.124 tmp.70 tmp.78))
       (tmp.83 (rbp tmp-ra.124 tmp.70 tmp.78 tmp.82))
       (tmp.81 (rbp tmp-ra.124 tmp.70 tmp.78))
       (tmp.77 (rbp tmp-ra.124 tmp.70))
       (fixnum1.5 (rbp tmp-ra.124))
       (ascii-char2.4 (rbp tmp-ra.124))
       (tmp.86 (rsi tmp.87 rax rbp tmp-ra.124))
       (tmp.87 (rbp tmp-ra.124 tmp.86))
       (tmp.85 (rsi tmp.88 tmp.90 tmp.89 rax rbp tmp-ra.124))
       (tmp.89 (rsi tmp.90 rax rbp tmp-ra.124 tmp.85))
       (tmp.90 (rbp tmp-ra.124 tmp.85 tmp.89))
       (tmp.88 (rbp tmp-ra.124 tmp.85))
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
         tmp-ra.124))
       (tmp.93 (rsi tmp.94 rax rbp tmp-ra.124 tmp.84))
       (tmp.94 (rbp tmp-ra.124 tmp.84 tmp.93))
       (tmp.92 (rsi tmp.95 tmp.97 tmp.96 rax rbp tmp-ra.124 tmp.84))
       (tmp.96 (rsi tmp.97 rax rbp tmp-ra.124 tmp.84 tmp.92))
       (tmp.97 (rbp tmp-ra.124 tmp.84 tmp.92 tmp.96))
       (tmp.95 (rbp tmp-ra.124 tmp.84 tmp.92))
       (tmp.91 (rbp tmp-ra.124 tmp.84))
       (fixnum3.3 (rbp tmp-ra.124))
       (void4.2 (rbp tmp-ra.124))
       (tmp.100 (rsi tmp.101 rax rbp tmp-ra.124))
       (tmp.101 (rbp tmp-ra.124 tmp.100))
       (tmp.99 (rsi tmp.102 tmp.104 tmp.103 rax rbp tmp-ra.124))
       (tmp.103 (rsi tmp.104 rax rbp tmp-ra.124 tmp.99))
       (tmp.104 (rbp tmp-ra.124 tmp.99 tmp.103))
       (tmp.102 (rbp tmp-ra.124 tmp.99))
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
         tmp-ra.124))
       (tmp.107 (rsi tmp.108 rax rbp tmp-ra.124 tmp.98))
       (tmp.108 (rbp tmp-ra.124 tmp.98 tmp.107))
       (tmp.106 (rsi tmp.109 tmp.111 tmp.110 rax rbp tmp-ra.124 tmp.98))
       (tmp.110 (rsi tmp.111 rax rbp tmp-ra.124 tmp.98 tmp.106))
       (tmp.111 (rbp tmp-ra.124 tmp.98 tmp.106 tmp.110))
       (tmp.109 (rbp tmp-ra.124 tmp.98 tmp.106))
       (tmp.105 (rbp tmp-ra.124 tmp.98))
       (fixnum5.1 (rbp tmp-ra.124))
       (tmp.112 (rbp tmp-ra.124))
       (rbp
        (tmp.112
         fixnum5.1
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
         void4.2
         fixnum3.3
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
         ascii-char2.4
         fixnum1.5
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
         ascii-char0.6
         r15
         rax
         tmp-ra.124))
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
         tmp.82
         tmp.78
         tmp.79
         tmp.70
         tmp.75
         tmp.71
         tmp.72
         rbp
         tmp-ra.124))
       (r15 (rdi rsi rbp))
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
       (rdi (tmp-ra.124 r15 rbp rsi))))
     (assignment
      ((tmp-ra.124 fv0)
       (tmp.72 fv1)
       (tmp.71 fv1)
       (tmp.70 fv1)
       (tmp.82 fv2)
       (tmp.86 fv1)
       (tmp.85 fv1)
       (tmp.84 fv1)
       (tmp.96 fv2)
       (tmp.100 fv1)
       (tmp.99 fv1)
       (tmp.98 fv1)
       (tmp.110 fv2)
       (tmp.106 fv3)
       (tmp.107 fv2)
       (tmp.103 fv2)
       (tmp.92 fv3)
       (tmp.93 fv2)
       (tmp.89 fv2)
       (tmp.78 fv3)
       (tmp.79 fv2)
       (tmp.75 fv2)
       (tmp.83 r15)
       (tmp.97 r15)
       (tmp.111 r15)
       (tmp.76 r15)
       (tmp.80 r15)
       (tmp.81 r15)
       (tmp.90 r15)
       (tmp.94 r15)
       (tmp.95 r15)
       (tmp.104 r15)
       (tmp.108 r15)
       (tmp.109 r15)
       (tmp.73 r15)
       (tmp.74 r15)
       (tmp.77 r15)
       (tmp.87 r15)
       (tmp.88 r15)
       (tmp.91 r15)
       (tmp.101 r15)
       (tmp.102 r15)
       (tmp.105 r15)
       (ascii-char0.6 r15)
       (fixnum1.5 r15)
       (ascii-char2.4 r15)
       (fixnum3.3 r15)
       (void4.2 r15)
       (fixnum5.1 r15)
       (tmp.112 r15))))
    (define L.boolean?.15
      ((locals ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.113))
         (tmp.44 (rbp tmp-ra.113))
         (tmp.125 (rbp tmp-ra.113))
         (tmp-ra.113 (tmp.44 rbp rdi tmp.125 tmp.56 rax))
         (rax (rbp tmp-ra.113))
         (rbp (tmp.44 tmp-ra.113 tmp.125 tmp.56 rax))
         (rdi (tmp-ra.113))))
       (assignment ((tmp-ra.113 r15) (tmp.56 r14) (tmp.44 r14) (tmp.125 r14))))
      (begin
        (set! tmp-ra.113 r15)
        (set! tmp.44 rdi)
        (if (begin
              (begin
                (set! tmp.125 tmp.44)
                (set! tmp.125 (bitwise-and tmp.125 247))
                (set! tmp.56 tmp.125))
              (= tmp.56 6))
          (begin (set! rax 14) (jump tmp-ra.113 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.113 rbp rax)))))
    (define L.-.14
      ((locals ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.114 tmp.25 tmp.24))
         (tmp.126 (tmp.25 rbp tmp-ra.114 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.114
           tmp.24
           tmp.126
           tmp.58
           tmp.57
           tmp.127
           tmp.60
           tmp.59
           tmp.128))
         (tmp.58 (rbp tmp-ra.114 tmp.25 tmp.24))
         (tmp-ra.114
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.126
           tmp.58
           tmp.57
           tmp.127
           tmp.60
           tmp.59
           tmp.128
           rax))
         (tmp.128 (rbp tmp-ra.114 tmp.25))
         (tmp.60 (rbp tmp-ra.114 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.114
           rsi
           tmp.126
           tmp.58
           tmp.57
           tmp.127
           tmp.60
           tmp.59))
         (tmp.127 (tmp.24 rbp tmp-ra.114 tmp.25))
         (tmp.59 (rbp tmp-ra.114 tmp.25 tmp.24))
         (rax (rbp tmp-ra.114))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.114
           tmp.126
           tmp.58
           tmp.57
           tmp.127
           tmp.60
           tmp.59
           tmp.128
           rax))
         (rdi (tmp-ra.114))
         (rsi (tmp.24 tmp-ra.114))))
       (assignment
        ((tmp-ra.114 r15)
         (tmp.25 r14)
         (tmp.24 r13)
         (tmp.57 r9)
         (tmp.126 r9)
         (tmp.58 r9)
         (tmp.60 r9)
         (tmp.127 r9)
         (tmp.59 r9)
         (tmp.128 r13))))
      (begin
        (set! tmp-ra.114 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.126 tmp.25)
                      (set! tmp.126 (bitwise-and tmp.126 7))
                      (set! tmp.58 tmp.126))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.127 tmp.24)
                        (set! tmp.127 (bitwise-and tmp.127 7))
                        (set! tmp.60 tmp.127))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.128 tmp.24)
              (set! tmp.128 (- tmp.128 tmp.25))
              (set! rax tmp.128)
              (jump tmp-ra.114 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.114 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.114 rbp rax)))))
    (define L.*.13
      ((locals ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.115 tmp.20 tmp.21))
         (tmp.129 (tmp.21 rbp tmp-ra.115 tmp.20))
         (tmp.21
          (rbp tmp-ra.115 tmp.20 tmp.129 tmp.62 tmp.61 tmp.130 tmp.64 tmp.63))
         (tmp.62 (rbp tmp-ra.115 tmp.20 tmp.21))
         (tmp-ra.115
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.129
           tmp.62
           tmp.61
           tmp.130
           tmp.64
           tmp.63
           tmp.132
           tmp.65
           tmp.131
           rax))
         (tmp.131 (rbp tmp-ra.115 tmp.20))
         (tmp.65 (tmp.132 rbp tmp-ra.115 tmp.20))
         (tmp.132 (rbp tmp-ra.115 tmp.65))
         (tmp.64 (rbp tmp-ra.115 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.115
           rsi
           tmp.129
           tmp.62
           tmp.61
           tmp.130
           tmp.64
           tmp.63
           tmp.65
           tmp.131))
         (tmp.130 (tmp.20 rbp tmp-ra.115 tmp.21))
         (tmp.63 (rbp tmp-ra.115 tmp.20 tmp.21))
         (rax (rbp tmp-ra.115))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.115
           tmp.129
           tmp.62
           tmp.61
           tmp.130
           tmp.64
           tmp.63
           tmp.132
           tmp.65
           tmp.131
           rax))
         (rdi (tmp-ra.115))
         (rsi (tmp.20 tmp-ra.115))))
       (assignment
        ((tmp-ra.115 r15)
         (tmp.20 r14)
         (tmp.21 r13)
         (tmp.61 r9)
         (tmp.129 r9)
         (tmp.62 r9)
         (tmp.65 r13)
         (tmp.64 r9)
         (tmp.130 r9)
         (tmp.63 r9)
         (tmp.131 r13)
         (tmp.132 r14))))
      (begin
        (set! tmp-ra.115 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.129 tmp.21)
                      (set! tmp.129 (bitwise-and tmp.129 7))
                      (set! tmp.62 tmp.129))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.130 tmp.20)
                        (set! tmp.130 (bitwise-and tmp.130 7))
                        (set! tmp.64 tmp.130))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.131 tmp.21)
              (set! tmp.131 (arithmetic-shift-right tmp.131 3))
              (set! tmp.65 tmp.131)
              (set! tmp.132 tmp.20)
              (set! tmp.132 (* tmp.132 tmp.65))
              (set! rax tmp.132)
              (jump tmp-ra.115 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.115 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.115 rbp rax)))))
    (define L.+.12
      ((locals ())
       (conflicts
        ((tmp.66 (rbp tmp-ra.116 tmp.23 tmp.22))
         (tmp.133 (tmp.23 rbp tmp-ra.116 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.116
           tmp.22
           tmp.133
           tmp.67
           tmp.66
           tmp.134
           tmp.69
           tmp.68
           tmp.135))
         (tmp.67 (rbp tmp-ra.116 tmp.23 tmp.22))
         (tmp-ra.116
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.133
           tmp.67
           tmp.66
           tmp.134
           tmp.69
           tmp.68
           tmp.135
           rax))
         (tmp.135 (rbp tmp-ra.116 tmp.23))
         (tmp.69 (rbp tmp-ra.116 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.116
           rsi
           tmp.133
           tmp.67
           tmp.66
           tmp.134
           tmp.69
           tmp.68))
         (tmp.134 (tmp.22 rbp tmp-ra.116 tmp.23))
         (tmp.68 (rbp tmp-ra.116 tmp.23 tmp.22))
         (rax (rbp tmp-ra.116))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.116
           tmp.133
           tmp.67
           tmp.66
           tmp.134
           tmp.69
           tmp.68
           tmp.135
           rax))
         (rdi (tmp-ra.116))
         (rsi (tmp.22 tmp-ra.116))))
       (assignment
        ((tmp-ra.116 r15)
         (tmp.23 r14)
         (tmp.22 r13)
         (tmp.66 r9)
         (tmp.133 r9)
         (tmp.67 r9)
         (tmp.69 r9)
         (tmp.134 r9)
         (tmp.68 r9)
         (tmp.135 r13))))
      (begin
        (set! tmp-ra.116 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.133 tmp.23)
                      (set! tmp.133 (bitwise-and tmp.133 7))
                      (set! tmp.67 tmp.133))
                    (= tmp.67 0))
                (set! tmp.66 14)
                (set! tmp.66 6))
              (!= tmp.66 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.134 tmp.22)
                        (set! tmp.134 (bitwise-and tmp.134 7))
                        (set! tmp.69 tmp.134))
                      (= tmp.69 0))
                  (set! tmp.68 14)
                  (set! tmp.68 6))
                (!= tmp.68 6))
            (begin
              (set! tmp.135 tmp.22)
              (set! tmp.135 (+ tmp.135 tmp.23))
              (set! rax tmp.135)
              (jump tmp-ra.116 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.116 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.116 rbp rax)))))
    (define L.fun/void20855.4
      ((locals ())
       (conflicts
        ((tmp-ra.117 (rax rbp)) (rbp (rax tmp-ra.117)) (rax (rbp tmp-ra.117))))
       (assignment ((tmp-ra.117 r15))))
      (begin (set! tmp-ra.117 r15) (set! rax 30) (jump tmp-ra.117 rbp rax)))
    (define L.fun/ascii-char20850.5
      ((locals ())
       (conflicts ((tmp-ra.118 (rbp)) (rbp (r15 tmp-ra.118)) (r15 (rbp))))
       (assignment ((tmp-ra.118 r15))))
      (begin
        (set! tmp-ra.118 r15)
        (set! r15 tmp-ra.118)
        (jump L.fun/ascii-char20851.8 rbp r15)))
    (define L.fun/void20854.6
      ((locals ())
       (conflicts ((tmp-ra.119 (rbp)) (rbp (r15 tmp-ra.119)) (r15 (rbp))))
       (assignment ((tmp-ra.119 r15))))
      (begin
        (set! tmp-ra.119 r15)
        (set! r15 tmp-ra.119)
        (jump L.fun/void20855.4 rbp r15)))
    (define L.fun/any20856.7
      ((locals ())
       (conflicts
        ((tmp-ra.120 (rax rbp)) (rbp (rax tmp-ra.120)) (rax (rbp tmp-ra.120))))
       (assignment ((tmp-ra.120 r15))))
      (begin (set! tmp-ra.120 r15) (set! rax 14) (jump tmp-ra.120 rbp rax)))
    (define L.fun/ascii-char20851.8
      ((locals ())
       (conflicts
        ((tmp-ra.121 (rax rbp)) (rbp (rax tmp-ra.121)) (rax (rbp tmp-ra.121))))
       (assignment ((tmp-ra.121 r15))))
      (begin (set! tmp-ra.121 r15) (set! rax 29742) (jump tmp-ra.121 rbp rax)))
    (define L.fun/ascii-char20853.9
      ((locals ())
       (conflicts
        ((tmp-ra.122 (rax rbp)) (rbp (rax tmp-ra.122)) (rax (rbp tmp-ra.122))))
       (assignment ((tmp-ra.122 r15))))
      (begin (set! tmp-ra.122 r15) (set! rax 24366) (jump tmp-ra.122 rbp rax)))
    (define L.fun/ascii-char20852.10
      ((locals ())
       (conflicts ((tmp-ra.123 (rbp)) (rbp (r15 tmp-ra.123)) (r15 (rbp))))
       (assignment ((tmp-ra.123 r15))))
      (begin
        (set! tmp-ra.123 r15)
        (set! r15 tmp-ra.123)
        (jump L.fun/ascii-char20853.9 rbp r15)))
    (begin
      (set! tmp-ra.124 r15)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/ascii-char20850.5 rbp r15)))
        (set! rbp (+ rbp 176)))
      (set! ascii-char0.6 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.17
          (begin
            (set! rsi 456)
            (set! rdi 1200)
            (set! r15 L.rp.17)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.18
          (begin
            (set! rsi 616)
            (set! rdi 336)
            (set! r15 L.rp.18)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.72)
            (set! r15 L.rp.19)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.20
          (begin
            (set! rsi 480)
            (set! rdi 352)
            (set! r15 L.rp.20)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.21
          (begin
            (set! rsi 1240)
            (set! rdi 456)
            (set! r15 L.rp.21)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.75)
            (set! r15 L.rp.22)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.74)
            (set! rdi tmp.71)
            (set! r15 L.rp.23)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.24
          (begin
            (set! rsi 640)
            (set! rdi 1264)
            (set! r15 L.rp.24)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.25
          (begin
            (set! rsi 400)
            (set! rdi 504)
            (set! r15 L.rp.25)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.79)
            (set! r15 L.rp.26)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.27
          (begin
            (set! rsi 664)
            (set! rdi 1024)
            (set! r15 L.rp.27)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.28
          (begin
            (set! rsi 936)
            (set! rdi 112)
            (set! r15 L.rp.28)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.83)
            (set! rdi tmp.82)
            (set! r15 L.rp.29)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.81)
            (set! rdi tmp.78)
            (set! r15 L.rp.30)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.70)
            (set! r15 L.rp.31)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! fixnum1.5 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/ascii-char20852.10 rbp r15)))
        (set! rbp (+ rbp 176)))
      (set! ascii-char2.4 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.33
          (begin
            (set! rsi 672)
            (set! rdi 376)
            (set! r15 L.rp.33)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.34
          (begin
            (set! rsi 352)
            (set! rdi 1128)
            (set! r15 L.rp.34)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.35
          (begin
            (set! rsi tmp.87)
            (set! rdi tmp.86)
            (set! r15 L.rp.35)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.36
          (begin
            (set! rsi 1896)
            (set! rdi 1360)
            (set! r15 L.rp.36)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.37
          (begin
            (set! rsi 1680)
            (set! rdi 1848)
            (set! r15 L.rp.37)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.90)
            (set! rdi tmp.89)
            (set! r15 L.rp.38)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.88)
            (set! rdi tmp.85)
            (set! r15 L.rp.39)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.40
          (begin
            (set! rsi 440)
            (set! rdi 248)
            (set! r15 L.rp.40)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.41
          (begin
            (set! rsi 1952)
            (set! rdi 960)
            (set! r15 L.rp.41)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.42
          (begin
            (set! rsi tmp.94)
            (set! rdi tmp.93)
            (set! r15 L.rp.42)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.43
          (begin
            (set! rsi 248)
            (set! rdi 504)
            (set! r15 L.rp.43)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.44
          (begin
            (set! rsi 1768)
            (set! rdi 696)
            (set! r15 L.rp.44)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.97 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.45
          (begin
            (set! rsi tmp.97)
            (set! rdi tmp.96)
            (set! r15 L.rp.45)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.46
          (begin
            (set! rsi tmp.95)
            (set! rdi tmp.92)
            (set! r15 L.rp.46)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.47
          (begin
            (set! rsi tmp.91)
            (set! rdi tmp.84)
            (set! r15 L.rp.47)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! fixnum3.3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/void20854.6 rbp r15)))
        (set! rbp (+ rbp 176)))
      (set! void4.2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.49
          (begin
            (set! rsi 1552)
            (set! rdi 424)
            (set! r15 L.rp.49)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.100 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.50
          (begin
            (set! rsi 144)
            (set! rdi 1264)
            (set! r15 L.rp.50)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.101 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.51
          (begin
            (set! rsi tmp.101)
            (set! rdi tmp.100)
            (set! r15 L.rp.51)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.99 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.52
          (begin
            (set! rsi 1256)
            (set! rdi 640)
            (set! r15 L.rp.52)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.103 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.53
          (begin
            (set! rsi 1904)
            (set! rdi 712)
            (set! r15 L.rp.53)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.104 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.54
          (begin
            (set! rsi tmp.104)
            (set! rdi tmp.103)
            (set! r15 L.rp.54)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.102 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.55
          (begin
            (set! rsi tmp.102)
            (set! rdi tmp.99)
            (set! r15 L.rp.55)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.98 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.56
          (begin
            (set! rsi 1304)
            (set! rdi 1080)
            (set! r15 L.rp.56)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.107 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.57
          (begin
            (set! rsi 1928)
            (set! rdi 1000)
            (set! r15 L.rp.57)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.108 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.58
          (begin
            (set! rsi tmp.108)
            (set! rdi tmp.107)
            (set! r15 L.rp.58)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.106 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.59
          (begin
            (set! rsi 416)
            (set! rdi 1720)
            (set! r15 L.rp.59)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.110 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.60
          (begin
            (set! rsi 1112)
            (set! rdi 1344)
            (set! r15 L.rp.60)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.111 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.61
          (begin
            (set! rsi tmp.111)
            (set! rdi tmp.110)
            (set! r15 L.rp.61)
            (jump L.-.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.109 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.62
          (begin
            (set! rsi tmp.109)
            (set! rdi tmp.106)
            (set! r15 L.rp.62)
            (jump L.+.12 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.105 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.63
          (begin
            (set! rsi tmp.105)
            (set! rdi tmp.98)
            (set! r15 L.rp.63)
            (jump L.*.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! fixnum5.1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.64
          (begin (set! r15 L.rp.64) (jump L.fun/any20856.7 rbp r15)))
        (set! rbp (+ rbp 176)))
      (set! tmp.112 rax)
      (set! rdi tmp.112)
      (set! r15 tmp-ra.124)
      (jump L.boolean?.15 rbp r15 rdi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.99
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
         ascii-char2.4
         pair1.5
         error0.6
         rax
         rbp))
       (error0.6
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
         ascii-char2.4
         pair1.5
         rax
         rbp
         tmp-ra.99))
       (pair1.5 (rbp tmp-ra.99 error0.6))
       (ascii-char2.4 (rbp tmp-ra.99 error0.6))
       (empty3.3 (rbp tmp-ra.99 error0.6))
       (empty4.2 (rbp tmp-ra.99 error0.6))
       (tmp.73 (rsi tmp.74 rax rbp tmp-ra.99 error0.6))
       (tmp.74 (rbp tmp-ra.99 error0.6 tmp.73))
       (tmp.72 (rsi tmp.75 tmp.77 tmp.76 rax rbp tmp-ra.99 error0.6))
       (tmp.76 (rsi tmp.77 rax rbp tmp-ra.99 error0.6 tmp.72))
       (tmp.77 (rbp tmp-ra.99 error0.6 tmp.72 tmp.76))
       (tmp.75 (rbp tmp-ra.99 error0.6 tmp.72))
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
         tmp-ra.99
         error0.6))
       (tmp.80 (rsi tmp.81 rax rbp tmp-ra.99 error0.6 tmp.71))
       (tmp.81 (rbp tmp-ra.99 error0.6 tmp.71 tmp.80))
       (tmp.79 (rsi tmp.82 tmp.84 tmp.83 rax rbp tmp-ra.99 error0.6 tmp.71))
       (tmp.83 (rsi tmp.84 rax rbp tmp-ra.99 error0.6 tmp.71 tmp.79))
       (tmp.84 (rbp tmp-ra.99 error0.6 tmp.71 tmp.79 tmp.83))
       (tmp.82 (rbp tmp-ra.99 error0.6 tmp.71 tmp.79))
       (tmp.78 (rbp tmp-ra.99 error0.6 tmp.71))
       (fixnum5.1 (rbp tmp-ra.99 error0.6))
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
         rdi
         rsi
         empty4.2
         empty3.3
         ascii-char2.4
         pair1.5
         error0.6
         r15
         rax
         tmp-ra.99))
       (rax
        (tmp.83
         tmp.79
         tmp.80
         tmp.71
         tmp.76
         tmp.72
         tmp.73
         error0.6
         rbp
         tmp-ra.99))
       (r15 (rdi rsi rbp))
       (rsi (tmp.71 tmp.79 tmp.83 tmp.80 tmp.72 tmp.76 tmp.73 r15 rdi rbp))
       (rdi (r15 rbp rsi))))
     (assignment
      ((tmp-ra.99 fv0)
       (tmp.73 fv1)
       (tmp.72 fv1)
       (tmp.71 fv1)
       (tmp.83 fv2)
       (tmp.79 fv3)
       (tmp.80 fv2)
       (tmp.76 fv2)
       (error0.6 fv4)
       (tmp.84 r15)
       (tmp.77 r15)
       (tmp.81 r15)
       (tmp.82 r15)
       (tmp.74 r15)
       (tmp.75 r15)
       (tmp.78 r15)
       (pair1.5 r15)
       (ascii-char2.4 r15)
       (empty3.3 r15)
       (empty4.2 r15)
       (fixnum5.1 r15))))
    (define L.-.18
      ((locals ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.100 (tmp.25 rbp tmp-ra.85 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.85
           tmp.24
           tmp.100
           tmp.58
           tmp.57
           tmp.101
           tmp.60
           tmp.59
           tmp.102))
         (tmp.58 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp-ra.85
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
         (tmp.102 (rbp tmp-ra.85 tmp.25))
         (tmp.60 (rbp tmp-ra.85 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.85
           rsi
           tmp.100
           tmp.58
           tmp.57
           tmp.101
           tmp.60
           tmp.59))
         (tmp.101 (tmp.24 rbp tmp-ra.85 tmp.25))
         (tmp.59 (rbp tmp-ra.85 tmp.25 tmp.24))
         (rax (rbp tmp-ra.85))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.85
           tmp.100
           tmp.58
           tmp.57
           tmp.101
           tmp.60
           tmp.59
           tmp.102
           rax))
         (rdi (tmp-ra.85))
         (rsi (tmp.24 tmp-ra.85))))
       (assignment
        ((tmp-ra.85 r15)
         (tmp.25 r14)
         (tmp.24 r13)
         (tmp.57 r9)
         (tmp.100 r9)
         (tmp.58 r9)
         (tmp.60 r9)
         (tmp.101 r9)
         (tmp.59 r9)
         (tmp.102 r13))))
      (begin
        (set! tmp-ra.85 r15)
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
              (jump tmp-ra.85 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.85 rbp rax)))))
    (define L.*.17
      ((locals ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.86 tmp.20 tmp.21))
         (tmp.103 (tmp.21 rbp tmp-ra.86 tmp.20))
         (tmp.21
          (rbp tmp-ra.86 tmp.20 tmp.103 tmp.62 tmp.61 tmp.104 tmp.64 tmp.63))
         (tmp.62 (rbp tmp-ra.86 tmp.20 tmp.21))
         (tmp-ra.86
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
         (tmp.105 (rbp tmp-ra.86 tmp.20))
         (tmp.65 (tmp.106 rbp tmp-ra.86 tmp.20))
         (tmp.106 (rbp tmp-ra.86 tmp.65))
         (tmp.64 (rbp tmp-ra.86 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.86
           rsi
           tmp.103
           tmp.62
           tmp.61
           tmp.104
           tmp.64
           tmp.63
           tmp.65
           tmp.105))
         (tmp.104 (tmp.20 rbp tmp-ra.86 tmp.21))
         (tmp.63 (rbp tmp-ra.86 tmp.20 tmp.21))
         (rax (rbp tmp-ra.86))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.86
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
         (rdi (tmp-ra.86))
         (rsi (tmp.20 tmp-ra.86))))
       (assignment
        ((tmp-ra.86 r15)
         (tmp.20 r14)
         (tmp.21 r13)
         (tmp.61 r9)
         (tmp.103 r9)
         (tmp.62 r9)
         (tmp.65 r13)
         (tmp.64 r9)
         (tmp.104 r9)
         (tmp.63 r9)
         (tmp.105 r13)
         (tmp.106 r14))))
      (begin
        (set! tmp-ra.86 r15)
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
              (jump tmp-ra.86 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.86 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.86 rbp rax)))))
    (define L.+.16
      ((locals ())
       (conflicts
        ((tmp.66 (rbp tmp-ra.87 tmp.23 tmp.22))
         (tmp.107 (tmp.23 rbp tmp-ra.87 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.87
           tmp.22
           tmp.107
           tmp.67
           tmp.66
           tmp.108
           tmp.69
           tmp.68
           tmp.109))
         (tmp.67 (rbp tmp-ra.87 tmp.23 tmp.22))
         (tmp-ra.87
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
         (tmp.109 (rbp tmp-ra.87 tmp.23))
         (tmp.69 (rbp tmp-ra.87 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.87
           rsi
           tmp.107
           tmp.67
           tmp.66
           tmp.108
           tmp.69
           tmp.68))
         (tmp.108 (tmp.22 rbp tmp-ra.87 tmp.23))
         (tmp.68 (rbp tmp-ra.87 tmp.23 tmp.22))
         (rax (rbp tmp-ra.87))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.87
           tmp.107
           tmp.67
           tmp.66
           tmp.108
           tmp.69
           tmp.68
           tmp.109
           rax))
         (rdi (tmp-ra.87))
         (rsi (tmp.22 tmp-ra.87))))
       (assignment
        ((tmp-ra.87 r15)
         (tmp.23 r14)
         (tmp.22 r13)
         (tmp.66 r9)
         (tmp.107 r9)
         (tmp.67 r9)
         (tmp.69 r9)
         (tmp.108 r9)
         (tmp.68 r9)
         (tmp.109 r13))))
      (begin
        (set! tmp-ra.87 r15)
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
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.87 rbp rax)))))
    (define L.cons.15
      ((locals ())
       (conflicts
        ((tmp-ra.88 (rax tmp.56 tmp.110 tmp.70 tmp.53 tmp.52 rbp r12 rsi rdi))
         (tmp.52 (tmp.56 tmp.110 tmp.70 tmp.53 rbp tmp-ra.88 r12 rsi))
         (tmp.53 (tmp.56 tmp.110 tmp.70 tmp.52 rbp tmp-ra.88 r12))
         (tmp.70 (tmp.52 rbp tmp-ra.88 tmp.53 r12))
         (tmp.110 (tmp.52 rbp tmp-ra.88 tmp.53))
         (tmp.56 (tmp.52 rbp tmp-ra.88 tmp.53))
         (rdi (tmp-ra.88))
         (rsi (tmp.52 tmp-ra.88))
         (r12 (rbp tmp.70 tmp.53 tmp.52 tmp-ra.88))
         (rbp (rax tmp.56 tmp.110 tmp.70 r12 tmp.53 tmp.52 tmp-ra.88))
         (rax (rbp tmp-ra.88))))
       (assignment
        ((tmp-ra.88 r15)
         (tmp.52 r14)
         (tmp.53 r13)
         (tmp.70 r9)
         (tmp.110 r9)
         (tmp.56 r9))))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.52 rdi)
        (set! tmp.53 rsi)
        (begin (set! tmp.70 r12) (set! r12 (+ r12 16)))
        (set! tmp.110 tmp.70)
        (set! tmp.110 (+ tmp.110 1))
        (set! tmp.56 tmp.110)
        (mset! tmp.56 -1 tmp.52)
        (mset! tmp.56 7 tmp.53)
        (set! rax tmp.56)
        (jump tmp-ra.88 rbp rax)))
    (define L.fun/ascii-char22195.4
      ((locals ())
       (conflicts
        ((tmp-ra.89 (rax rbp)) (rbp (rax tmp-ra.89)) (rax (rbp tmp-ra.89))))
       (assignment ((tmp-ra.89 r15))))
      (begin (set! tmp-ra.89 r15) (set! rax 31278) (jump tmp-ra.89 rbp rax)))
    (define L.fun/empty22197.5
      ((locals ())
       (conflicts
        ((tmp-ra.90 (rax rbp)) (rbp (rax tmp-ra.90)) (rax (rbp tmp-ra.90))))
       (assignment ((tmp-ra.90 r15))))
      (begin (set! tmp-ra.90 r15) (set! rax 22) (jump tmp-ra.90 rbp rax)))
    (define L.fun/pair22193.6
      ((locals ())
       (conflicts
        ((tmp-ra.91 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.91))
         (rsi (r15 rdi rbp tmp-ra.91))
         (rdi (r15 rbp rsi tmp-ra.91))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.91 r15))))
      (begin
        (set! tmp-ra.91 r15)
        (set! rsi 2320)
        (set! rdi 640)
        (set! r15 tmp-ra.91)
        (jump L.cons.15 rbp r15 rdi rsi)))
    (define L.fun/pair22192.7
      ((locals ())
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp))))
       (assignment ((tmp-ra.92 r15))))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/pair22193.6 rbp r15)))
    (define L.fun/empty22199.8
      ((locals ())
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93))))
       (assignment ((tmp-ra.93 r15))))
      (begin (set! tmp-ra.93 r15) (set! rax 22) (jump tmp-ra.93 rbp rax)))
    (define L.fun/empty22198.9
      ((locals ())
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp))))
       (assignment ((tmp-ra.94 r15))))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/empty22199.8 rbp r15)))
    (define L.fun/empty22196.10
      ((locals ())
       (conflicts ((tmp-ra.95 (rbp)) (rbp (r15 tmp-ra.95)) (r15 (rbp))))
       (assignment ((tmp-ra.95 r15))))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/empty22197.5 rbp r15)))
    (define L.fun/error22191.11
      ((locals ())
       (conflicts
        ((tmp-ra.96 (rax rbp)) (rbp (rax tmp-ra.96)) (rax (rbp tmp-ra.96))))
       (assignment ((tmp-ra.96 r15))))
      (begin (set! tmp-ra.96 r15) (set! rax 19262) (jump tmp-ra.96 rbp rax)))
    (define L.fun/error22190.12
      ((locals ())
       (conflicts ((tmp-ra.97 (rbp)) (rbp (r15 tmp-ra.97)) (r15 (rbp))))
       (assignment ((tmp-ra.97 r15))))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/error22191.11 rbp r15)))
    (define L.fun/ascii-char22194.13
      ((locals ())
       (conflicts ((tmp-ra.98 (rbp)) (rbp (r15 tmp-ra.98)) (r15 (rbp))))
       (assignment ((tmp-ra.98 r15))))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/ascii-char22195.4 rbp r15)))
    (begin
      (set! tmp-ra.99 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error22190.12 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! error0.6 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/pair22192.7 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! pair1.5 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char22194.13 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! ascii-char2.4 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty22196.10 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! empty3.3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty22198.9 rbp r15)))
        (set! rbp (+ rbp 72)))
      (set! empty4.2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi 1408)
            (set! rdi 1072)
            (set! r15 L.rp.24)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 784)
            (set! rdi 1232)
            (set! r15 L.rp.25)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.74)
            (set! rdi tmp.73)
            (set! r15 L.rp.26)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi 1688)
            (set! rdi 1496)
            (set! r15 L.rp.27)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 824)
            (set! rdi 832)
            (set! r15 L.rp.28)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.76)
            (set! r15 L.rp.29)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.72)
            (set! r15 L.rp.30)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi 880)
            (set! rdi 392)
            (set! r15 L.rp.31)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 192)
            (set! rdi 312)
            (set! r15 L.rp.32)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi tmp.81)
            (set! rdi tmp.80)
            (set! r15 L.rp.33)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi 576)
            (set! rdi 1728)
            (set! r15 L.rp.34)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi 848)
            (set! rdi 160)
            (set! r15 L.rp.35)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.84)
            (set! rdi tmp.83)
            (set! r15 L.rp.36)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.79)
            (set! r15 L.rp.37)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.78)
            (set! rdi tmp.71)
            (set! r15 L.rp.38)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 72)))
      (set! fixnum5.1 rax)
      (set! rax error0.6)
      (jump tmp-ra.99 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.103
        (void5.1
         error4.2
         fixnum3.3
         tmp.80
         tmp.84
         tmp.86
         tmp.85
         tmp.81
         tmp.83
         tmp.82
         tmp.73
         tmp.77
         tmp.79
         tmp.78
         tmp.74
         tmp.76
         tmp.75
         boolean2.4
         tmp.72
         empty1.5
         void0.6
         rax
         rbp))
       (void0.6 (rbp tmp-ra.103))
       (empty1.5 (rbp tmp-ra.103))
       (tmp.72 (rbp tmp-ra.103))
       (boolean2.4 (rbp tmp-ra.103))
       (tmp.75 (rsi tmp.76 rax rbp tmp-ra.103))
       (tmp.76 (rbp tmp-ra.103 tmp.75))
       (tmp.74 (rsi tmp.77 tmp.79 tmp.78 rax rbp tmp-ra.103))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.103 tmp.74))
       (tmp.79 (rbp tmp-ra.103 tmp.74 tmp.78))
       (tmp.77 (rbp tmp-ra.103 tmp.74))
       (tmp.73
        (rsi
         tmp.80
         tmp.84
         tmp.86
         tmp.85
         tmp.81
         tmp.83
         tmp.82
         rax
         rbp
         tmp-ra.103))
       (tmp.82 (rsi tmp.83 rax rbp tmp-ra.103 tmp.73))
       (tmp.83 (rbp tmp-ra.103 tmp.73 tmp.82))
       (tmp.81 (rsi tmp.84 tmp.86 tmp.85 rax rbp tmp-ra.103 tmp.73))
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.103 tmp.73 tmp.81))
       (tmp.86 (rbp tmp-ra.103 tmp.73 tmp.81 tmp.85))
       (tmp.84 (rbp tmp-ra.103 tmp.73 tmp.81))
       (tmp.80 (rbp tmp-ra.103 tmp.73))
       (fixnum3.3 (rbp tmp-ra.103))
       (error4.2 (rbp tmp-ra.103))
       (void5.1 (rbp tmp-ra.103))
       (rbp
        (void5.1
         error4.2
         fixnum3.3
         tmp.80
         tmp.84
         tmp.86
         tmp.85
         tmp.81
         tmp.83
         tmp.82
         tmp.73
         tmp.77
         tmp.79
         tmp.78
         tmp.74
         tmp.76
         tmp.75
         rsi
         boolean2.4
         rdi
         tmp.72
         empty1.5
         void0.6
         r15
         rax
         tmp-ra.103))
       (rax (tmp.85 tmp.81 tmp.82 tmp.73 tmp.78 tmp.74 tmp.75 rbp tmp-ra.103))
       (r15 (rsi rdi rbp))
       (rdi (rsi r15 rbp))
       (rsi (tmp.73 tmp.81 tmp.85 tmp.82 tmp.74 tmp.78 tmp.75 r15 rdi rbp))))
     (assignment
      ((tmp-ra.103 fv0)
       (tmp.78 fv1)
       (tmp.82 fv1)
       (tmp.81 fv1)
       (tmp.85 fv2)
       (tmp.73 fv3)
       (tmp.74 fv2)
       (tmp.75 fv1)
       (tmp.86 r15)
       (tmp.79 r15)
       (tmp.83 r15)
       (tmp.84 r15)
       (tmp.76 r15)
       (tmp.77 r15)
       (tmp.80 r15)
       (void0.6 r15)
       (empty1.5 r15)
       (tmp.72 r15)
       (boolean2.4 r15)
       (fixnum3.3 r15)
       (error4.2 r15)
       (void5.1 r15))))
    (define L.*.20
      ((locals ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.87 tmp.20 tmp.21))
         (tmp.104 (tmp.21 rbp tmp-ra.87 tmp.20))
         (tmp.21
          (rbp tmp-ra.87 tmp.20 tmp.104 tmp.58 tmp.57 tmp.105 tmp.60 tmp.59))
         (tmp.58 (rbp tmp-ra.87 tmp.20 tmp.21))
         (tmp-ra.87
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.104
           tmp.58
           tmp.57
           tmp.105
           tmp.60
           tmp.59
           tmp.107
           tmp.61
           tmp.106
           rax))
         (tmp.106 (rbp tmp-ra.87 tmp.20))
         (tmp.61 (tmp.107 rbp tmp-ra.87 tmp.20))
         (tmp.107 (rbp tmp-ra.87 tmp.61))
         (tmp.60 (rbp tmp-ra.87 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.87
           rsi
           tmp.104
           tmp.58
           tmp.57
           tmp.105
           tmp.60
           tmp.59
           tmp.61
           tmp.106))
         (tmp.105 (tmp.20 rbp tmp-ra.87 tmp.21))
         (tmp.59 (rbp tmp-ra.87 tmp.20 tmp.21))
         (rax (rbp tmp-ra.87))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.87
           tmp.104
           tmp.58
           tmp.57
           tmp.105
           tmp.60
           tmp.59
           tmp.107
           tmp.61
           tmp.106
           rax))
         (rdi (tmp-ra.87))
         (rsi (tmp.20 tmp-ra.87))))
       (assignment
        ((tmp-ra.87 r15)
         (tmp.20 r14)
         (tmp.21 r13)
         (tmp.57 r9)
         (tmp.104 r9)
         (tmp.58 r9)
         (tmp.61 r13)
         (tmp.60 r9)
         (tmp.105 r9)
         (tmp.59 r9)
         (tmp.106 r13)
         (tmp.107 r14))))
      (begin
        (set! tmp-ra.87 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.104 tmp.21)
                      (set! tmp.104 (bitwise-and tmp.104 7))
                      (set! tmp.58 tmp.104))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.105 tmp.20)
                        (set! tmp.105 (bitwise-and tmp.105 7))
                        (set! tmp.60 tmp.105))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.106 tmp.21)
              (set! tmp.106 (arithmetic-shift-right tmp.106 3))
              (set! tmp.61 tmp.106)
              (set! tmp.107 tmp.20)
              (set! tmp.107 (* tmp.107 tmp.61))
              (set! rax tmp.107)
              (jump tmp-ra.87 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.87 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.87 rbp rax)))))
    (define L.+.19
      ((locals ())
       (conflicts
        ((tmp.62 (rbp tmp-ra.88 tmp.23 tmp.22))
         (tmp.108 (tmp.23 rbp tmp-ra.88 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.88
           tmp.22
           tmp.108
           tmp.63
           tmp.62
           tmp.109
           tmp.65
           tmp.64
           tmp.110))
         (tmp.63 (rbp tmp-ra.88 tmp.23 tmp.22))
         (tmp-ra.88
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.108
           tmp.63
           tmp.62
           tmp.109
           tmp.65
           tmp.64
           tmp.110
           rax))
         (tmp.110 (rbp tmp-ra.88 tmp.23))
         (tmp.65 (rbp tmp-ra.88 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.88
           rsi
           tmp.108
           tmp.63
           tmp.62
           tmp.109
           tmp.65
           tmp.64))
         (tmp.109 (tmp.22 rbp tmp-ra.88 tmp.23))
         (tmp.64 (rbp tmp-ra.88 tmp.23 tmp.22))
         (rax (rbp tmp-ra.88))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.88
           tmp.108
           tmp.63
           tmp.62
           tmp.109
           tmp.65
           tmp.64
           tmp.110
           rax))
         (rdi (tmp-ra.88))
         (rsi (tmp.22 tmp-ra.88))))
       (assignment
        ((tmp-ra.88 r15)
         (tmp.23 r14)
         (tmp.22 r13)
         (tmp.62 r9)
         (tmp.108 r9)
         (tmp.63 r9)
         (tmp.65 r9)
         (tmp.109 r9)
         (tmp.64 r9)
         (tmp.110 r13))))
      (begin
        (set! tmp-ra.88 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.108 tmp.23)
                      (set! tmp.108 (bitwise-and tmp.108 7))
                      (set! tmp.63 tmp.108))
                    (= tmp.63 0))
                (set! tmp.62 14)
                (set! tmp.62 6))
              (!= tmp.62 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.109 tmp.22)
                        (set! tmp.109 (bitwise-and tmp.109 7))
                        (set! tmp.65 tmp.109))
                      (= tmp.65 0))
                  (set! tmp.64 14)
                  (set! tmp.64 6))
                (!= tmp.64 6))
            (begin
              (set! tmp.110 tmp.22)
              (set! tmp.110 (+ tmp.110 tmp.23))
              (set! rax tmp.110)
              (jump tmp-ra.88 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.88 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.88 rbp rax)))))
    (define L.-.18
      ((locals ())
       (conflicts
        ((tmp.66 (rbp tmp-ra.89 tmp.25 tmp.24))
         (tmp.111 (tmp.25 rbp tmp-ra.89 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.89
           tmp.24
           tmp.111
           tmp.67
           tmp.66
           tmp.112
           tmp.69
           tmp.68
           tmp.113))
         (tmp.67 (rbp tmp-ra.89 tmp.25 tmp.24))
         (tmp-ra.89
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.111
           tmp.67
           tmp.66
           tmp.112
           tmp.69
           tmp.68
           tmp.113
           rax))
         (tmp.113 (rbp tmp-ra.89 tmp.25))
         (tmp.69 (rbp tmp-ra.89 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.89
           rsi
           tmp.111
           tmp.67
           tmp.66
           tmp.112
           tmp.69
           tmp.68))
         (tmp.112 (tmp.24 rbp tmp-ra.89 tmp.25))
         (tmp.68 (rbp tmp-ra.89 tmp.25 tmp.24))
         (rax (rbp tmp-ra.89))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.89
           tmp.111
           tmp.67
           tmp.66
           tmp.112
           tmp.69
           tmp.68
           tmp.113
           rax))
         (rdi (tmp-ra.89))
         (rsi (tmp.24 tmp-ra.89))))
       (assignment
        ((tmp-ra.89 r15)
         (tmp.25 r14)
         (tmp.24 r13)
         (tmp.66 r9)
         (tmp.111 r9)
         (tmp.67 r9)
         (tmp.69 r9)
         (tmp.112 r9)
         (tmp.68 r9)
         (tmp.113 r13))))
      (begin
        (set! tmp-ra.89 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.111 tmp.25)
                      (set! tmp.111 (bitwise-and tmp.111 7))
                      (set! tmp.67 tmp.111))
                    (= tmp.67 0))
                (set! tmp.66 14)
                (set! tmp.66 6))
              (!= tmp.66 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.112 tmp.24)
                        (set! tmp.112 (bitwise-and tmp.112 7))
                        (set! tmp.69 tmp.112))
                      (= tmp.69 0))
                  (set! tmp.68 14)
                  (set! tmp.68 6))
                (!= tmp.68 6))
            (begin
              (set! tmp.113 tmp.24)
              (set! tmp.113 (- tmp.113 tmp.25))
              (set! rax tmp.113)
              (jump tmp-ra.89 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.89 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.89 rbp rax)))))
    (define L.vector?.17
      ((locals ())
       (conflicts
        ((tmp.70 (rbp tmp-ra.90))
         (tmp.50 (rbp tmp-ra.90))
         (tmp.114 (rbp tmp-ra.90))
         (tmp-ra.90 (tmp.50 rbp rdi tmp.114 tmp.70 rax))
         (rax (rbp tmp-ra.90))
         (rbp (tmp.50 tmp-ra.90 tmp.114 tmp.70 rax))
         (rdi (tmp-ra.90))))
       (assignment ((tmp-ra.90 r15) (tmp.70 r14) (tmp.50 r14) (tmp.114 r14))))
      (begin
        (set! tmp-ra.90 r15)
        (set! tmp.50 rdi)
        (if (begin
              (begin
                (set! tmp.114 tmp.50)
                (set! tmp.114 (bitwise-and tmp.114 7))
                (set! tmp.70 tmp.114))
              (= tmp.70 3))
          (begin (set! rax 14) (jump tmp-ra.90 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.90 rbp rax)))))
    (define L.cons.16
      ((locals ())
       (conflicts
        ((tmp-ra.91 (rax tmp.56 tmp.115 tmp.71 tmp.53 tmp.52 rbp r12 rsi rdi))
         (tmp.52 (tmp.56 tmp.115 tmp.71 tmp.53 rbp tmp-ra.91 r12 rsi))
         (tmp.53 (tmp.56 tmp.115 tmp.71 tmp.52 rbp tmp-ra.91 r12))
         (tmp.71 (tmp.52 rbp tmp-ra.91 tmp.53 r12))
         (tmp.115 (tmp.52 rbp tmp-ra.91 tmp.53))
         (tmp.56 (tmp.52 rbp tmp-ra.91 tmp.53))
         (rdi (tmp-ra.91))
         (rsi (tmp.52 tmp-ra.91))
         (r12 (rbp tmp.71 tmp.53 tmp.52 tmp-ra.91))
         (rbp (rax tmp.56 tmp.115 tmp.71 r12 tmp.53 tmp.52 tmp-ra.91))
         (rax (rbp tmp-ra.91))))
       (assignment
        ((tmp-ra.91 r15)
         (tmp.52 r14)
         (tmp.53 r13)
         (tmp.71 r9)
         (tmp.115 r9)
         (tmp.56 r9))))
      (begin
        (set! tmp-ra.91 r15)
        (set! tmp.52 rdi)
        (set! tmp.53 rsi)
        (begin (set! tmp.71 r12) (set! r12 (+ r12 16)))
        (set! tmp.115 tmp.71)
        (set! tmp.115 (+ tmp.115 1))
        (set! tmp.56 tmp.115)
        (mset! tmp.56 -1 tmp.52)
        (mset! tmp.56 7 tmp.53)
        (set! rax tmp.56)
        (jump tmp-ra.91 rbp rax)))
    (define L.fun/pair23550.4
      ((locals ())
       (conflicts ((tmp-ra.92 (rbp)) (rbp (r15 tmp-ra.92)) (r15 (rbp))))
       (assignment ((tmp-ra.92 r15))))
      (begin
        (set! tmp-ra.92 r15)
        (set! r15 tmp-ra.92)
        (jump L.fun/pair23551.8 rbp r15)))
    (define L.fun/void23549.5
      ((locals ())
       (conflicts
        ((tmp-ra.93 (rax rbp)) (rbp (rax tmp-ra.93)) (rax (rbp tmp-ra.93))))
       (assignment ((tmp-ra.93 r15))))
      (begin (set! tmp-ra.93 r15) (set! rax 30) (jump tmp-ra.93 rbp rax)))
    (define L.fun/void23541.6
      ((locals ())
       (conflicts ((tmp-ra.94 (rbp)) (rbp (r15 tmp-ra.94)) (r15 (rbp))))
       (assignment ((tmp-ra.94 r15))))
      (begin
        (set! tmp-ra.94 r15)
        (set! r15 tmp-ra.94)
        (jump L.fun/void23542.14 rbp r15)))
    (define L.fun/void23548.7
      ((locals ())
       (conflicts ((tmp-ra.95 (rbp)) (rbp (r15 tmp-ra.95)) (r15 (rbp))))
       (assignment ((tmp-ra.95 r15))))
      (begin
        (set! tmp-ra.95 r15)
        (set! r15 tmp-ra.95)
        (jump L.fun/void23549.5 rbp r15)))
    (define L.fun/pair23551.8
      ((locals ())
       (conflicts
        ((tmp-ra.96 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.96))
         (rsi (r15 rdi rbp tmp-ra.96))
         (rdi (r15 rbp rsi tmp-ra.96))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.96 r15))))
      (begin
        (set! tmp-ra.96 r15)
        (set! rsi 3872)
        (set! rdi 664)
        (set! r15 tmp-ra.96)
        (jump L.cons.16 rbp r15 rdi rsi)))
    (define L.fun/error23546.9
      ((locals ())
       (conflicts ((tmp-ra.97 (rbp)) (rbp (r15 tmp-ra.97)) (r15 (rbp))))
       (assignment ((tmp-ra.97 r15))))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/error23547.11 rbp r15)))
    (define L.fun/empty23544.10
      ((locals ())
       (conflicts
        ((tmp-ra.98 (rax rbp)) (rbp (rax tmp-ra.98)) (rax (rbp tmp-ra.98))))
       (assignment ((tmp-ra.98 r15))))
      (begin (set! tmp-ra.98 r15) (set! rax 22) (jump tmp-ra.98 rbp rax)))
    (define L.fun/error23547.11
      ((locals ())
       (conflicts
        ((tmp-ra.99 (rax rbp)) (rbp (rax tmp-ra.99)) (rax (rbp tmp-ra.99))))
       (assignment ((tmp-ra.99 r15))))
      (begin (set! tmp-ra.99 r15) (set! rax 53822) (jump tmp-ra.99 rbp rax)))
    (define L.fun/any23545.12
      ((locals ())
       (conflicts
        ((tmp-ra.100 (rax rbp)) (rbp (rax tmp-ra.100)) (rax (rbp tmp-ra.100))))
       (assignment ((tmp-ra.100 r15))))
      (begin (set! tmp-ra.100 r15) (set! rax 6) (jump tmp-ra.100 rbp rax)))
    (define L.fun/empty23543.13
      ((locals ())
       (conflicts ((tmp-ra.101 (rbp)) (rbp (r15 tmp-ra.101)) (r15 (rbp))))
       (assignment ((tmp-ra.101 r15))))
      (begin
        (set! tmp-ra.101 r15)
        (set! r15 tmp-ra.101)
        (jump L.fun/empty23544.10 rbp r15)))
    (define L.fun/void23542.14
      ((locals ())
       (conflicts
        ((tmp-ra.102 (rax rbp)) (rbp (rax tmp-ra.102)) (rax (rbp tmp-ra.102))))
       (assignment ((tmp-ra.102 r15))))
      (begin (set! tmp-ra.102 r15) (set! rax 30) (jump tmp-ra.102 rbp rax)))
    (begin
      (set! tmp-ra.103 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void23541.6 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void0.6 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty23543.13 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! empty1.5 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/any23545.12 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rdi tmp.72)
            (set! r15 L.rp.24)
            (jump L.vector?.17 rbp r15 rdi)))
        (set! rbp (+ rbp 64)))
      (set! boolean2.4 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 368)
            (set! rdi 1448)
            (set! r15 L.rp.25)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 1528)
            (set! rdi 672)
            (set! r15 L.rp.26)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.75)
            (set! r15 L.rp.27)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 464)
            (set! rdi 1808)
            (set! r15 L.rp.28)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 520)
            (set! rdi 104)
            (set! r15 L.rp.29)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.30)
            (jump L.*.20 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.74)
            (set! r15 L.rp.31)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 104)
            (set! rdi 1264)
            (set! r15 L.rp.32)
            (jump L.*.20 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 448)
            (set! rdi 448)
            (set! r15 L.rp.33)
            (jump L.-.18 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi tmp.83)
            (set! rdi tmp.82)
            (set! r15 L.rp.34)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 320)
            (set! rdi 1664)
            (set! r15 L.rp.35)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi 112)
            (set! rdi 1296)
            (set! r15 L.rp.36)
            (jump L.*.20 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi tmp.86)
            (set! rdi tmp.85)
            (set! r15 L.rp.37)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.84)
            (set! rdi tmp.81)
            (set! r15 L.rp.38)
            (jump L.*.20 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.73)
            (set! r15 L.rp.39)
            (jump L.+.19 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 64)))
      (set! fixnum3.3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin (set! r15 L.rp.40) (jump L.fun/error23546.9 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! error4.2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.41
          (begin (set! r15 L.rp.41) (jump L.fun/void23548.7 rbp r15)))
        (set! rbp (+ rbp 64)))
      (set! void5.1 rax)
      (set! r15 tmp-ra.103)
      (jump L.fun/pair23550.4 rbp r15))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.68
        (error5.1
         empty4.2
         ascii-char3.3
         void2.4
         error1.5
         ascii-char0.6
         rax
         rbp))
       (ascii-char0.6 (rbp tmp-ra.68))
       (error1.5 (rbp tmp-ra.68))
       (void2.4 (rbp tmp-ra.68))
       (ascii-char3.3 (rbp tmp-ra.68))
       (empty4.2 (error5.1 rax rbp tmp-ra.68))
       (error5.1 (rbp tmp-ra.68 empty4.2))
       (rbp
        (error5.1
         empty4.2
         ascii-char3.3
         void2.4
         error1.5
         ascii-char0.6
         r15
         rax
         tmp-ra.68))
       (rax (empty4.2 rbp tmp-ra.68))
       (r15 (rbp))))
     (assignment
      ((tmp-ra.68 fv0)
       (empty4.2 fv1)
       (error5.1 r15)
       (ascii-char0.6 r15)
       (error1.5 r15)
       (void2.4 r15)
       (ascii-char3.3 r15))))
    (define L.fun/error24539.4
      ((locals ())
       (conflicts
        ((tmp-ra.56 (rax rbp)) (rbp (rax tmp-ra.56)) (rax (rbp tmp-ra.56))))
       (assignment ((tmp-ra.56 r15))))
      (begin (set! tmp-ra.56 r15) (set! rax 15934) (jump tmp-ra.56 rbp rax)))
    (define L.fun/ascii-char24535.5
      ((locals ())
       (conflicts
        ((tmp-ra.57 (rax rbp)) (rbp (rax tmp-ra.57)) (rax (rbp tmp-ra.57))))
       (assignment ((tmp-ra.57 r15))))
      (begin (set! tmp-ra.57 r15) (set! rax 18734) (jump tmp-ra.57 rbp rax)))
    (define L.fun/ascii-char24529.6
      ((locals ())
       (conflicts
        ((tmp-ra.58 (rax rbp)) (rbp (rax tmp-ra.58)) (rax (rbp tmp-ra.58))))
       (assignment ((tmp-ra.58 r15))))
      (begin (set! tmp-ra.58 r15) (set! rax 24622) (jump tmp-ra.58 rbp rax)))
    (define L.fun/empty24537.7
      ((locals ())
       (conflicts
        ((tmp-ra.59 (rax rbp)) (rbp (rax tmp-ra.59)) (rax (rbp tmp-ra.59))))
       (assignment ((tmp-ra.59 r15))))
      (begin (set! tmp-ra.59 r15) (set! rax 22) (jump tmp-ra.59 rbp rax)))
    (define L.fun/ascii-char24534.8
      ((locals ())
       (conflicts ((tmp-ra.60 (rbp)) (rbp (r15 tmp-ra.60)) (r15 (rbp))))
       (assignment ((tmp-ra.60 r15))))
      (begin
        (set! tmp-ra.60 r15)
        (set! r15 tmp-ra.60)
        (jump L.fun/ascii-char24535.5 rbp r15)))
    (define L.fun/error24531.9
      ((locals ())
       (conflicts
        ((tmp-ra.61 (rax rbp)) (rbp (rax tmp-ra.61)) (rax (rbp tmp-ra.61))))
       (assignment ((tmp-ra.61 r15))))
      (begin (set! tmp-ra.61 r15) (set! rax 2622) (jump tmp-ra.61 rbp rax)))
    (define L.fun/error24538.10
      ((locals ())
       (conflicts ((tmp-ra.62 (rbp)) (rbp (r15 tmp-ra.62)) (r15 (rbp))))
       (assignment ((tmp-ra.62 r15))))
      (begin
        (set! tmp-ra.62 r15)
        (set! r15 tmp-ra.62)
        (jump L.fun/error24539.4 rbp r15)))
    (define L.fun/empty24536.11
      ((locals ())
       (conflicts ((tmp-ra.63 (rbp)) (rbp (r15 tmp-ra.63)) (r15 (rbp))))
       (assignment ((tmp-ra.63 r15))))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/empty24537.7 rbp r15)))
    (define L.fun/void24532.12
      ((locals ())
       (conflicts ((tmp-ra.64 (rbp)) (rbp (r15 tmp-ra.64)) (r15 (rbp))))
       (assignment ((tmp-ra.64 r15))))
      (begin
        (set! tmp-ra.64 r15)
        (set! r15 tmp-ra.64)
        (jump L.fun/void24533.14 rbp r15)))
    (define L.fun/error24530.13
      ((locals ())
       (conflicts ((tmp-ra.65 (rbp)) (rbp (r15 tmp-ra.65)) (r15 (rbp))))
       (assignment ((tmp-ra.65 r15))))
      (begin
        (set! tmp-ra.65 r15)
        (set! r15 tmp-ra.65)
        (jump L.fun/error24531.9 rbp r15)))
    (define L.fun/void24533.14
      ((locals ())
       (conflicts
        ((tmp-ra.66 (rax rbp)) (rbp (rax tmp-ra.66)) (rax (rbp tmp-ra.66))))
       (assignment ((tmp-ra.66 r15))))
      (begin (set! tmp-ra.66 r15) (set! rax 30) (jump tmp-ra.66 rbp rax)))
    (define L.fun/ascii-char24528.15
      ((locals ())
       (conflicts ((tmp-ra.67 (rbp)) (rbp (r15 tmp-ra.67)) (r15 (rbp))))
       (assignment ((tmp-ra.67 r15))))
      (begin
        (set! tmp-ra.67 r15)
        (set! r15 tmp-ra.67)
        (jump L.fun/ascii-char24529.6 rbp r15)))
    (begin
      (set! tmp-ra.68 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char24528.15 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char0.6 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error24530.13 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void24532.12 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! void2.4 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char24534.8 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! ascii-char3.3 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty24536.11 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! empty4.2 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error24538.10 rbp r15)))
        (set! rbp (+ rbp 16)))
      (set! error5.1 rax)
      (set! rax empty4.2)
      (jump tmp-ra.68 rbp rax))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.114
        (rdi
         rsi
         tmp.102
         tmp.97
         tmp.100
         tmp.101
         tmp.98
         tmp.99
         empty5.1
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
         error0.6
         rax
         rbp))
       (error0.6 (rbp tmp-ra.114))
       (tmp.71 (rsi tmp.72 rax rbp tmp-ra.114))
       (tmp.72 (rbp tmp-ra.114 tmp.71))
       (tmp.70 (rsi tmp.73 tmp.75 tmp.74 rax rbp tmp-ra.114))
       (tmp.74 (rsi tmp.75 rax rbp tmp-ra.114 tmp.70))
       (tmp.75 (rbp tmp-ra.114 tmp.70 tmp.74))
       (tmp.73 (rbp tmp-ra.114 tmp.70))
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
         tmp-ra.114))
       (tmp.78 (rsi tmp.79 rax rbp tmp-ra.114 tmp.69))
       (tmp.79 (rbp tmp-ra.114 tmp.69 tmp.78))
       (tmp.77 (rsi tmp.80 tmp.82 tmp.81 rax rbp tmp-ra.114 tmp.69))
       (tmp.81 (rsi tmp.82 rax rbp tmp-ra.114 tmp.69 tmp.77))
       (tmp.82 (rbp tmp-ra.114 tmp.69 tmp.77 tmp.81))
       (tmp.80 (rbp tmp-ra.114 tmp.69 tmp.77))
       (tmp.76 (rbp tmp-ra.114 tmp.69))
       (fixnum1.5
        (tmp.97
         tmp.100
         rsi
         tmp.101
         tmp.98
         tmp.99
         empty5.1
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
         empty2.4
         rax
         rbp
         tmp-ra.114))
       (empty2.4 (rbp tmp-ra.114 fixnum1.5))
       (error3.3 (rbp tmp-ra.114 fixnum1.5))
       (tmp.85 (rsi tmp.86 rax rbp tmp-ra.114 fixnum1.5))
       (tmp.86 (rbp tmp-ra.114 fixnum1.5 tmp.85))
       (tmp.84 (rsi tmp.87 tmp.89 tmp.88 rax rbp tmp-ra.114 fixnum1.5))
       (tmp.88 (rsi tmp.89 rax rbp tmp-ra.114 fixnum1.5 tmp.84))
       (tmp.89 (rbp tmp-ra.114 fixnum1.5 tmp.84 tmp.88))
       (tmp.87 (rbp tmp-ra.114 fixnum1.5 tmp.84))
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
         tmp-ra.114
         fixnum1.5))
       (tmp.92 (rsi tmp.93 rax rbp tmp-ra.114 fixnum1.5 tmp.83))
       (tmp.93 (rbp tmp-ra.114 fixnum1.5 tmp.83 tmp.92))
       (tmp.91 (rsi tmp.94 tmp.96 tmp.95 rax rbp tmp-ra.114 fixnum1.5 tmp.83))
       (tmp.95 (rsi tmp.96 rax rbp tmp-ra.114 fixnum1.5 tmp.83 tmp.91))
       (tmp.96 (rbp tmp-ra.114 fixnum1.5 tmp.83 tmp.91 tmp.95))
       (tmp.94 (rbp tmp-ra.114 fixnum1.5 tmp.83 tmp.91))
       (tmp.90 (rbp tmp-ra.114 fixnum1.5 tmp.83))
       (fixnum4.2
        (rsi
         tmp.97
         tmp.100
         tmp.101
         tmp.98
         tmp.99
         empty5.1
         rax
         rbp
         tmp-ra.114
         fixnum1.5))
       (empty5.1 (rbp tmp-ra.114 fixnum1.5 fixnum4.2))
       (tmp.99 (rsi rbp tmp-ra.114 fixnum1.5 fixnum4.2))
       (tmp.98 (rsi tmp.100 tmp.101 rax rbp tmp-ra.114 fixnum1.5 fixnum4.2))
       (tmp.101 (rbp tmp-ra.114 fixnum1.5 fixnum4.2 tmp.98))
       (tmp.100 (rbp tmp-ra.114 fixnum1.5 fixnum4.2 tmp.98))
       (tmp.97 (rsi tmp.102 rax rbp tmp-ra.114 fixnum1.5 fixnum4.2))
       (tmp.102 (rbp tmp-ra.114 tmp.97))
       (rbp
        (tmp.102
         tmp.97
         tmp.100
         tmp.101
         tmp.98
         tmp.99
         empty5.1
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
         error0.6
         r15
         rax
         tmp-ra.114))
       (rax
        (tmp.97
         tmp.98
         fixnum4.2
         tmp.95
         tmp.91
         tmp.92
         tmp.83
         tmp.88
         tmp.84
         tmp.85
         fixnum1.5
         tmp.81
         tmp.77
         tmp.78
         tmp.69
         tmp.74
         tmp.70
         tmp.71
         rbp
         tmp-ra.114))
       (r15 (rdi rsi rbp))
       (rsi
        (tmp-ra.114
         tmp.97
         fixnum4.2
         tmp.98
         fixnum1.5
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
       (rdi (tmp-ra.114 r15 rbp rsi))))
     (assignment
      ((tmp-ra.114 fv0)
       (tmp.71 fv1)
       (tmp.70 fv1)
       (tmp.69 fv1)
       (tmp.81 fv2)
       (fixnum1.5 fv1)
       (tmp.88 fv2)
       (tmp.92 fv2)
       (tmp.91 fv2)
       (tmp.98 fv2)
       (tmp.97 fv2)
       (fixnum4.2 fv3)
       (tmp.95 fv3)
       (tmp.83 fv4)
       (tmp.84 fv3)
       (tmp.85 fv2)
       (tmp.77 fv3)
       (tmp.78 fv2)
       (tmp.74 fv2)
       (tmp.96 r15)
       (tmp.82 r15)
       (tmp.89 r15)
       (tmp.93 r15)
       (tmp.94 r15)
       (tmp.99 r15)
       (tmp.101 r15)
       (tmp.100 r15)
       (tmp.75 r15)
       (tmp.79 r15)
       (tmp.80 r15)
       (tmp.86 r15)
       (tmp.87 r15)
       (tmp.90 r15)
       (empty5.1 r15)
       (tmp.72 r15)
       (tmp.73 r15)
       (tmp.76 r15)
       (empty2.4 r15)
       (error3.3 r15)
       (tmp.102 r15)
       (error0.6 r15))))
    (define L.-.15
      ((locals ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.103 tmp.25 tmp.24))
         (tmp.115 (tmp.25 rbp tmp-ra.103 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.103
           tmp.24
           tmp.115
           tmp.57
           tmp.56
           tmp.116
           tmp.59
           tmp.58
           tmp.117))
         (tmp.57 (rbp tmp-ra.103 tmp.25 tmp.24))
         (tmp-ra.103
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.115
           tmp.57
           tmp.56
           tmp.116
           tmp.59
           tmp.58
           tmp.117
           rax))
         (tmp.117 (rbp tmp-ra.103 tmp.25))
         (tmp.59 (rbp tmp-ra.103 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.103
           rsi
           tmp.115
           tmp.57
           tmp.56
           tmp.116
           tmp.59
           tmp.58))
         (tmp.116 (tmp.24 rbp tmp-ra.103 tmp.25))
         (tmp.58 (rbp tmp-ra.103 tmp.25 tmp.24))
         (rax (rbp tmp-ra.103))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.103
           tmp.115
           tmp.57
           tmp.56
           tmp.116
           tmp.59
           tmp.58
           tmp.117
           rax))
         (rdi (tmp-ra.103))
         (rsi (tmp.24 tmp-ra.103))))
       (assignment
        ((tmp-ra.103 r15)
         (tmp.25 r14)
         (tmp.24 r13)
         (tmp.56 r9)
         (tmp.115 r9)
         (tmp.57 r9)
         (tmp.59 r9)
         (tmp.116 r9)
         (tmp.58 r9)
         (tmp.117 r13))))
      (begin
        (set! tmp-ra.103 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.115 tmp.25)
                      (set! tmp.115 (bitwise-and tmp.115 7))
                      (set! tmp.57 tmp.115))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.116 tmp.24)
                        (set! tmp.116 (bitwise-and tmp.116 7))
                        (set! tmp.59 tmp.116))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.117 tmp.24)
              (set! tmp.117 (- tmp.117 tmp.25))
              (set! rax tmp.117)
              (jump tmp-ra.103 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.103 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.103 rbp rax)))))
    (define L.*.14
      ((locals ())
       (conflicts
        ((tmp.60 (rbp tmp-ra.104 tmp.20 tmp.21))
         (tmp.118 (tmp.21 rbp tmp-ra.104 tmp.20))
         (tmp.21
          (rbp tmp-ra.104 tmp.20 tmp.118 tmp.61 tmp.60 tmp.119 tmp.63 tmp.62))
         (tmp.61 (rbp tmp-ra.104 tmp.20 tmp.21))
         (tmp-ra.104
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.118
           tmp.61
           tmp.60
           tmp.119
           tmp.63
           tmp.62
           tmp.121
           tmp.64
           tmp.120
           rax))
         (tmp.120 (rbp tmp-ra.104 tmp.20))
         (tmp.64 (tmp.121 rbp tmp-ra.104 tmp.20))
         (tmp.121 (rbp tmp-ra.104 tmp.64))
         (tmp.63 (rbp tmp-ra.104 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.104
           rsi
           tmp.118
           tmp.61
           tmp.60
           tmp.119
           tmp.63
           tmp.62
           tmp.64
           tmp.120))
         (tmp.119 (tmp.20 rbp tmp-ra.104 tmp.21))
         (tmp.62 (rbp tmp-ra.104 tmp.20 tmp.21))
         (rax (rbp tmp-ra.104))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.104
           tmp.118
           tmp.61
           tmp.60
           tmp.119
           tmp.63
           tmp.62
           tmp.121
           tmp.64
           tmp.120
           rax))
         (rdi (tmp-ra.104))
         (rsi (tmp.20 tmp-ra.104))))
       (assignment
        ((tmp-ra.104 r15)
         (tmp.20 r14)
         (tmp.21 r13)
         (tmp.60 r9)
         (tmp.118 r9)
         (tmp.61 r9)
         (tmp.64 r13)
         (tmp.63 r9)
         (tmp.119 r9)
         (tmp.62 r9)
         (tmp.120 r13)
         (tmp.121 r14))))
      (begin
        (set! tmp-ra.104 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.118 tmp.21)
                      (set! tmp.118 (bitwise-and tmp.118 7))
                      (set! tmp.61 tmp.118))
                    (= tmp.61 0))
                (set! tmp.60 14)
                (set! tmp.60 6))
              (!= tmp.60 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.119 tmp.20)
                        (set! tmp.119 (bitwise-and tmp.119 7))
                        (set! tmp.63 tmp.119))
                      (= tmp.63 0))
                  (set! tmp.62 14)
                  (set! tmp.62 6))
                (!= tmp.62 6))
            (begin
              (set! tmp.120 tmp.21)
              (set! tmp.120 (arithmetic-shift-right tmp.120 3))
              (set! tmp.64 tmp.120)
              (set! tmp.121 tmp.20)
              (set! tmp.121 (* tmp.121 tmp.64))
              (set! rax tmp.121)
              (jump tmp-ra.104 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.104 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.104 rbp rax)))))
    (define L.+.13
      ((locals ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.105 tmp.23 tmp.22))
         (tmp.122 (tmp.23 rbp tmp-ra.105 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.105
           tmp.22
           tmp.122
           tmp.66
           tmp.65
           tmp.123
           tmp.68
           tmp.67
           tmp.124))
         (tmp.66 (rbp tmp-ra.105 tmp.23 tmp.22))
         (tmp-ra.105
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.122
           tmp.66
           tmp.65
           tmp.123
           tmp.68
           tmp.67
           tmp.124
           rax))
         (tmp.124 (rbp tmp-ra.105 tmp.23))
         (tmp.68 (rbp tmp-ra.105 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.105
           rsi
           tmp.122
           tmp.66
           tmp.65
           tmp.123
           tmp.68
           tmp.67))
         (tmp.123 (tmp.22 rbp tmp-ra.105 tmp.23))
         (tmp.67 (rbp tmp-ra.105 tmp.23 tmp.22))
         (rax (rbp tmp-ra.105))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.105
           tmp.122
           tmp.66
           tmp.65
           tmp.123
           tmp.68
           tmp.67
           tmp.124
           rax))
         (rdi (tmp-ra.105))
         (rsi (tmp.22 tmp-ra.105))))
       (assignment
        ((tmp-ra.105 r15)
         (tmp.23 r14)
         (tmp.22 r13)
         (tmp.65 r9)
         (tmp.122 r9)
         (tmp.66 r9)
         (tmp.68 r9)
         (tmp.123 r9)
         (tmp.67 r9)
         (tmp.124 r13))))
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
    (define L.fun/empty24788.4
      ((locals ())
       (conflicts
        ((tmp-ra.106 (rax rbp)) (rbp (rax tmp-ra.106)) (rax (rbp tmp-ra.106))))
       (assignment ((tmp-ra.106 r15))))
      (begin (set! tmp-ra.106 r15) (set! rax 22) (jump tmp-ra.106 rbp rax)))
    (define L.fun/error24789.5
      ((locals ())
       (conflicts ((tmp-ra.107 (rbp)) (rbp (r15 tmp-ra.107)) (r15 (rbp))))
       (assignment ((tmp-ra.107 r15))))
      (begin
        (set! tmp-ra.107 r15)
        (set! r15 tmp-ra.107)
        (jump L.fun/error24790.10 rbp r15)))
    (define L.fun/error24786.6
      ((locals ())
       (conflicts
        ((tmp-ra.108 (rax rbp)) (rbp (rax tmp-ra.108)) (rax (rbp tmp-ra.108))))
       (assignment ((tmp-ra.108 r15))))
      (begin (set! tmp-ra.108 r15) (set! rax 34622) (jump tmp-ra.108 rbp rax)))
    (define L.fun/error24785.7
      ((locals ())
       (conflicts ((tmp-ra.109 (rbp)) (rbp (r15 tmp-ra.109)) (r15 (rbp))))
       (assignment ((tmp-ra.109 r15))))
      (begin
        (set! tmp-ra.109 r15)
        (set! r15 tmp-ra.109)
        (jump L.fun/error24786.6 rbp r15)))
    (define L.fun/empty24792.8
      ((locals ())
       (conflicts
        ((tmp-ra.110 (rax rbp)) (rbp (rax tmp-ra.110)) (rax (rbp tmp-ra.110))))
       (assignment ((tmp-ra.110 r15))))
      (begin (set! tmp-ra.110 r15) (set! rax 22) (jump tmp-ra.110 rbp rax)))
    (define L.fun/empty24787.9
      ((locals ())
       (conflicts ((tmp-ra.111 (rbp)) (rbp (r15 tmp-ra.111)) (r15 (rbp))))
       (assignment ((tmp-ra.111 r15))))
      (begin
        (set! tmp-ra.111 r15)
        (set! r15 tmp-ra.111)
        (jump L.fun/empty24788.4 rbp r15)))
    (define L.fun/error24790.10
      ((locals ())
       (conflicts
        ((tmp-ra.112 (rax rbp)) (rbp (rax tmp-ra.112)) (rax (rbp tmp-ra.112))))
       (assignment ((tmp-ra.112 r15))))
      (begin (set! tmp-ra.112 r15) (set! rax 11070) (jump tmp-ra.112 rbp rax)))
    (define L.fun/empty24791.11
      ((locals ())
       (conflicts ((tmp-ra.113 (rbp)) (rbp (r15 tmp-ra.113)) (r15 (rbp))))
       (assignment ((tmp-ra.113 r15))))
      (begin
        (set! tmp-ra.113 r15)
        (set! r15 tmp-ra.113)
        (jump L.fun/empty24792.8 rbp r15)))
    (begin
      (set! tmp-ra.114 r15)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/error24785.7 rbp r15)))
        (set! rbp (+ rbp 152)))
      (set! error0.6 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.17
          (begin
            (set! rsi 1112)
            (set! rdi 1392)
            (set! r15 L.rp.17)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.18
          (begin
            (set! rsi 1584)
            (set! rdi 1104)
            (set! r15 L.rp.18)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.19)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.20
          (begin
            (set! rsi 1024)
            (set! rdi 88)
            (set! r15 L.rp.20)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.21
          (begin
            (set! rsi 32)
            (set! rdi 680)
            (set! r15 L.rp.21)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.22)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.23)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.24
          (begin
            (set! rsi 1672)
            (set! rdi 1648)
            (set! r15 L.rp.24)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.25
          (begin
            (set! rsi 1616)
            (set! rdi 2016)
            (set! r15 L.rp.25)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.26)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.27
          (begin
            (set! rsi 1512)
            (set! rdi 1040)
            (set! r15 L.rp.27)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.28
          (begin
            (set! rsi 1256)
            (set! rdi 2024)
            (set! r15 L.rp.28)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.29)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.30)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.31)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! fixnum1.5 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/empty24787.9 rbp r15)))
        (set! rbp (+ rbp 152)))
      (set! empty2.4 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/error24789.5 rbp r15)))
        (set! rbp (+ rbp 152)))
      (set! error3.3 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.34
          (begin
            (set! rsi 608)
            (set! rdi 640)
            (set! r15 L.rp.34)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.35
          (begin
            (set! rsi 1840)
            (set! rdi 88)
            (set! r15 L.rp.35)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.86)
            (set! rdi tmp.85)
            (set! r15 L.rp.36)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.37
          (begin
            (set! rsi 2008)
            (set! rdi 1992)
            (set! r15 L.rp.37)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.38
          (begin
            (set! rsi 1960)
            (set! rdi 632)
            (set! r15 L.rp.38)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.89)
            (set! rdi tmp.88)
            (set! r15 L.rp.39)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.40
          (begin
            (set! rsi tmp.87)
            (set! rdi tmp.84)
            (set! r15 L.rp.40)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.41
          (begin
            (set! rsi 1392)
            (set! rdi 744)
            (set! r15 L.rp.41)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.42
          (begin
            (set! rsi 440)
            (set! rdi 808)
            (set! r15 L.rp.42)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.43
          (begin
            (set! rsi tmp.93)
            (set! rdi tmp.92)
            (set! r15 L.rp.43)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.44
          (begin
            (set! rsi 920)
            (set! rdi 1368)
            (set! r15 L.rp.44)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.45
          (begin
            (set! rsi 920)
            (set! rdi 912)
            (set! r15 L.rp.45)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.46
          (begin
            (set! rsi tmp.96)
            (set! rdi tmp.95)
            (set! r15 L.rp.46)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.47
          (begin
            (set! rsi tmp.94)
            (set! rdi tmp.91)
            (set! r15 L.rp.47)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.48
          (begin
            (set! rsi tmp.90)
            (set! rdi tmp.83)
            (set! r15 L.rp.48)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/empty24791.11 rbp r15)))
        (set! rbp (+ rbp 152)))
      (set! empty5.1 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.50
          (begin
            (set! rsi fixnum4.2)
            (set! rdi 56)
            (set! r15 L.rp.50)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.99 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.51
          (begin
            (set! rsi fixnum4.2)
            (set! rdi tmp.99)
            (set! r15 L.rp.51)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.98 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.52
          (begin
            (set! rsi fixnum1.5)
            (set! rdi 144)
            (set! r15 L.rp.52)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.101 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.53
          (begin
            (set! rsi tmp.101)
            (set! rdi fixnum1.5)
            (set! r15 L.rp.53)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.100 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.54
          (begin
            (set! rsi tmp.100)
            (set! rdi tmp.98)
            (set! r15 L.rp.54)
            (jump L.+.13 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.97 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.55
          (begin
            (set! rsi fixnum1.5)
            (set! rdi fixnum4.2)
            (set! r15 L.rp.55)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 152)))
      (set! tmp.102 rax)
      (set! rsi tmp.102)
      (set! rdi tmp.97)
      (set! r15 tmp-ra.114)
      (jump L.+.13 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.75
        (empty5.1 pair4.2 boolean3.3 tmp.59 pair2.4 void1.5 error0.6 rax rbp))
       (error0.6 (rbp tmp-ra.75))
       (void1.5 (rbp tmp-ra.75))
       (pair2.4 (rbp tmp-ra.75))
       (tmp.59 (rbp tmp-ra.75))
       (boolean3.3 (rbp tmp-ra.75))
       (pair4.2 (rbp tmp-ra.75))
       (empty5.1 (rbp tmp-ra.75))
       (rbp
        (empty5.1
         pair4.2
         boolean3.3
         rdi
         tmp.59
         pair2.4
         void1.5
         error0.6
         r15
         rax
         tmp-ra.75))
       (rax (rbp tmp-ra.75))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment
      ((tmp-ra.75 fv0)
       (error0.6 r15)
       (void1.5 r15)
       (pair2.4 r15)
       (tmp.59 r15)
       (boolean3.3 r15)
       (pair4.2 r15)
       (empty5.1 r15))))
    (define L.error?.19
      ((locals ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.60))
         (tmp.48 (rbp tmp-ra.60))
         (tmp.76 (rbp tmp-ra.60))
         (tmp-ra.60 (tmp.48 rbp rdi tmp.76 tmp.57 rax))
         (rax (rbp tmp-ra.60))
         (rbp (tmp.48 tmp-ra.60 tmp.76 tmp.57 rax))
         (rdi (tmp-ra.60))))
       (assignment ((tmp-ra.60 r15) (tmp.57 r14) (tmp.48 r14) (tmp.76 r14))))
      (begin
        (set! tmp-ra.60 r15)
        (set! tmp.48 rdi)
        (if (begin
              (begin
                (set! tmp.76 tmp.48)
                (set! tmp.76 (bitwise-and tmp.76 255))
                (set! tmp.57 tmp.76))
              (= tmp.57 62))
          (begin (set! rax 14) (jump tmp-ra.60 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.60 rbp rax)))))
    (define L.cons.18
      ((locals ())
       (conflicts
        ((tmp-ra.61 (rax tmp.56 tmp.77 tmp.58 tmp.53 tmp.52 rbp r12 rsi rdi))
         (tmp.52 (tmp.56 tmp.77 tmp.58 tmp.53 rbp tmp-ra.61 r12 rsi))
         (tmp.53 (tmp.56 tmp.77 tmp.58 tmp.52 rbp tmp-ra.61 r12))
         (tmp.58 (tmp.52 rbp tmp-ra.61 tmp.53 r12))
         (tmp.77 (tmp.52 rbp tmp-ra.61 tmp.53))
         (tmp.56 (tmp.52 rbp tmp-ra.61 tmp.53))
         (rdi (tmp-ra.61))
         (rsi (tmp.52 tmp-ra.61))
         (r12 (rbp tmp.58 tmp.53 tmp.52 tmp-ra.61))
         (rbp (rax tmp.56 tmp.77 tmp.58 r12 tmp.53 tmp.52 tmp-ra.61))
         (rax (rbp tmp-ra.61))))
       (assignment
        ((tmp-ra.61 r15)
         (tmp.52 r14)
         (tmp.53 r13)
         (tmp.58 r9)
         (tmp.77 r9)
         (tmp.56 r9))))
      (begin
        (set! tmp-ra.61 r15)
        (set! tmp.52 rdi)
        (set! tmp.53 rsi)
        (begin (set! tmp.58 r12) (set! r12 (+ r12 16)))
        (set! tmp.77 tmp.58)
        (set! tmp.77 (+ tmp.77 1))
        (set! tmp.56 tmp.77)
        (mset! tmp.56 -1 tmp.52)
        (mset! tmp.56 7 tmp.53)
        (set! rax tmp.56)
        (jump tmp-ra.61 rbp rax)))
    (define L.fun/pair24832.4
      ((locals ())
       (conflicts ((tmp-ra.62 (rbp)) (rbp (r15 tmp-ra.62)) (r15 (rbp))))
       (assignment ((tmp-ra.62 r15))))
      (begin
        (set! tmp-ra.62 r15)
        (set! r15 tmp-ra.62)
        (jump L.fun/pair24833.15 rbp r15)))
    (define L.fun/error24829.5
      ((locals ())
       (conflicts
        ((tmp-ra.63 (rax rbp)) (rbp (rax tmp-ra.63)) (rax (rbp tmp-ra.63))))
       (assignment ((tmp-ra.63 r15))))
      (begin (set! tmp-ra.63 r15) (set! rax 2110) (jump tmp-ra.63 rbp rax)))
    (define L.fun/pair24835.6
      ((locals ())
       (conflicts ((tmp-ra.64 (rbp)) (rbp (r15 tmp-ra.64)) (r15 (rbp))))
       (assignment ((tmp-ra.64 r15))))
      (begin
        (set! tmp-ra.64 r15)
        (set! r15 tmp-ra.64)
        (jump L.fun/pair24836.7 rbp r15)))
    (define L.fun/pair24836.7
      ((locals ())
       (conflicts
        ((tmp-ra.65 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.65))
         (rsi (r15 rdi rbp tmp-ra.65))
         (rdi (r15 rbp rsi tmp-ra.65))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.65 r15))))
      (begin
        (set! tmp-ra.65 r15)
        (set! rsi 4056)
        (set! rdi 1040)
        (set! r15 tmp-ra.65)
        (jump L.cons.18 rbp r15 rdi rsi)))
    (define L.fun/any24834.8
      ((locals ())
       (conflicts
        ((tmp-ra.66 (rax rbp)) (rbp (rax tmp-ra.66)) (rax (rbp tmp-ra.66))))
       (assignment ((tmp-ra.66 r15))))
      (begin (set! tmp-ra.66 r15) (set! rax 40766) (jump tmp-ra.66 rbp rax)))
    (define L.fun/ascii-char24839.9
      ((locals ())
       (conflicts ((tmp-ra.67 (rbp)) (rbp (r15 tmp-ra.67)) (r15 (rbp))))
       (assignment ((tmp-ra.67 r15))))
      (begin
        (set! tmp-ra.67 r15)
        (set! r15 tmp-ra.67)
        (jump L.fun/ascii-char24840.12 rbp r15)))
    (define L.fun/void24831.10
      ((locals ())
       (conflicts
        ((tmp-ra.68 (rax rbp)) (rbp (rax tmp-ra.68)) (rax (rbp tmp-ra.68))))
       (assignment ((tmp-ra.68 r15))))
      (begin (set! tmp-ra.68 r15) (set! rax 30) (jump tmp-ra.68 rbp rax)))
    (define L.fun/void24830.11
      ((locals ())
       (conflicts ((tmp-ra.69 (rbp)) (rbp (r15 tmp-ra.69)) (r15 (rbp))))
       (assignment ((tmp-ra.69 r15))))
      (begin
        (set! tmp-ra.69 r15)
        (set! r15 tmp-ra.69)
        (jump L.fun/void24831.10 rbp r15)))
    (define L.fun/ascii-char24840.12
      ((locals ())
       (conflicts
        ((tmp-ra.70 (rax rbp)) (rbp (rax tmp-ra.70)) (rax (rbp tmp-ra.70))))
       (assignment ((tmp-ra.70 r15))))
      (begin (set! tmp-ra.70 r15) (set! rax 26414) (jump tmp-ra.70 rbp rax)))
    (define L.fun/empty24838.13
      ((locals ())
       (conflicts
        ((tmp-ra.71 (rax rbp)) (rbp (rax tmp-ra.71)) (rax (rbp tmp-ra.71))))
       (assignment ((tmp-ra.71 r15))))
      (begin (set! tmp-ra.71 r15) (set! rax 22) (jump tmp-ra.71 rbp rax)))
    (define L.fun/empty24837.14
      ((locals ())
       (conflicts ((tmp-ra.72 (rbp)) (rbp (r15 tmp-ra.72)) (r15 (rbp))))
       (assignment ((tmp-ra.72 r15))))
      (begin
        (set! tmp-ra.72 r15)
        (set! r15 tmp-ra.72)
        (jump L.fun/empty24838.13 rbp r15)))
    (define L.fun/pair24833.15
      ((locals ())
       (conflicts
        ((tmp-ra.73 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.73))
         (rsi (r15 rdi rbp tmp-ra.73))
         (rdi (r15 rbp rsi tmp-ra.73))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.73 r15))))
      (begin
        (set! tmp-ra.73 r15)
        (set! rsi 3544)
        (set! rdi 1856)
        (set! r15 tmp-ra.73)
        (jump L.cons.18 rbp r15 rdi rsi)))
    (define L.fun/error24828.16
      ((locals ())
       (conflicts ((tmp-ra.74 (rbp)) (rbp (r15 tmp-ra.74)) (r15 (rbp))))
       (assignment ((tmp-ra.74 r15))))
      (begin
        (set! tmp-ra.74 r15)
        (set! r15 tmp-ra.74)
        (jump L.fun/error24829.5 rbp r15)))
    (begin
      (set! tmp-ra.75 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error24828.16 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error0.6 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void24830.11 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! void1.5 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/pair24832.4 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! pair2.4 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/any24834.8 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! tmp.59 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.24
          (begin
            (set! rdi tmp.59)
            (set! r15 L.rp.24)
            (jump L.error?.19 rbp r15 rdi)))
        (set! rbp (+ rbp 8)))
      (set! boolean3.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/pair24835.6 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! pair4.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/empty24837.14 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! empty5.1 rax)
      (set! r15 tmp-ra.75)
      (jump L.fun/ascii-char24839.9 rbp r15))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.125
        (fixnum5.1
         tmp.106
         tmp.110
         tmp.112
         tmp.111
         tmp.107
         tmp.109
         tmp.108
         tmp.99
         tmp.103
         tmp.105
         tmp.104
         tmp.100
         tmp.102
         tmp.101
         empty4.2
         void3.3
         ascii-char2.4
         fixnum1.5
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
         fixnum0.6
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
         rbp))
       (tmp.73 (rsi tmp.74 rax rbp tmp-ra.125))
       (tmp.74 (rbp tmp-ra.125 tmp.73))
       (tmp.72 (rsi tmp.75 tmp.77 tmp.76 rax rbp tmp-ra.125))
       (tmp.76 (rsi tmp.77 rax rbp tmp-ra.125 tmp.72))
       (tmp.77 (rbp tmp-ra.125 tmp.72 tmp.76))
       (tmp.75 (rbp tmp-ra.125 tmp.72))
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
         tmp-ra.125))
       (tmp.80 (rsi tmp.81 rax rbp tmp-ra.125 tmp.71))
       (tmp.81 (rbp tmp-ra.125 tmp.71 tmp.80))
       (tmp.79 (rsi tmp.82 tmp.84 tmp.83 rax rbp tmp-ra.125 tmp.71))
       (tmp.83 (rsi tmp.84 rax rbp tmp-ra.125 tmp.71 tmp.79))
       (tmp.84 (rbp tmp-ra.125 tmp.71 tmp.79 tmp.83))
       (tmp.82 (rbp tmp-ra.125 tmp.71 tmp.79))
       (tmp.78 (rbp tmp-ra.125 tmp.71))
       (fixnum0.6 (rbp tmp-ra.125))
       (tmp.87 (rsi tmp.88 rax rbp tmp-ra.125))
       (tmp.88 (rbp tmp-ra.125 tmp.87))
       (tmp.86 (rsi tmp.89 tmp.91 tmp.90 rax rbp tmp-ra.125))
       (tmp.90 (rsi tmp.91 rax rbp tmp-ra.125 tmp.86))
       (tmp.91 (rbp tmp-ra.125 tmp.86 tmp.90))
       (tmp.89 (rbp tmp-ra.125 tmp.86))
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
         tmp-ra.125))
       (tmp.94 (rsi tmp.95 rax rbp tmp-ra.125 tmp.85))
       (tmp.95 (rbp tmp-ra.125 tmp.85 tmp.94))
       (tmp.93 (rsi tmp.96 tmp.98 tmp.97 rax rbp tmp-ra.125 tmp.85))
       (tmp.97 (rsi tmp.98 rax rbp tmp-ra.125 tmp.85 tmp.93))
       (tmp.98 (rbp tmp-ra.125 tmp.85 tmp.93 tmp.97))
       (tmp.96 (rbp tmp-ra.125 tmp.85 tmp.93))
       (tmp.92 (rbp tmp-ra.125 tmp.85))
       (fixnum1.5 (rbp tmp-ra.125))
       (ascii-char2.4 (rbp tmp-ra.125))
       (void3.3 (rbp tmp-ra.125))
       (empty4.2 (rbp tmp-ra.125))
       (tmp.101 (rsi tmp.102 rax rbp tmp-ra.125))
       (tmp.102 (rbp tmp-ra.125 tmp.101))
       (tmp.100 (rsi tmp.103 tmp.105 tmp.104 rax rbp tmp-ra.125))
       (tmp.104 (rsi tmp.105 rax rbp tmp-ra.125 tmp.100))
       (tmp.105 (rbp tmp-ra.125 tmp.100 tmp.104))
       (tmp.103 (rbp tmp-ra.125 tmp.100))
       (tmp.99
        (rsi
         tmp.106
         tmp.110
         tmp.112
         tmp.111
         tmp.107
         tmp.109
         tmp.108
         rax
         rbp
         tmp-ra.125))
       (tmp.108 (rsi tmp.109 rax rbp tmp-ra.125 tmp.99))
       (tmp.109 (rbp tmp-ra.125 tmp.99 tmp.108))
       (tmp.107 (rsi tmp.110 tmp.112 tmp.111 rax rbp tmp-ra.125 tmp.99))
       (tmp.111 (rsi tmp.112 rax rbp tmp-ra.125 tmp.99 tmp.107))
       (tmp.112 (rbp tmp-ra.125 tmp.99 tmp.107 tmp.111))
       (tmp.110 (rbp tmp-ra.125 tmp.99 tmp.107))
       (tmp.106 (rbp tmp-ra.125 tmp.99))
       (fixnum5.1 (rbp tmp-ra.125))
       (rbp
        (fixnum5.1
         tmp.106
         tmp.110
         tmp.112
         tmp.111
         tmp.107
         tmp.109
         tmp.108
         tmp.99
         tmp.103
         tmp.105
         tmp.104
         tmp.100
         tmp.102
         tmp.101
         empty4.2
         void3.3
         ascii-char2.4
         fixnum1.5
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
         fixnum0.6
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
         r15
         rdi
         rsi
         rax
         tmp-ra.125))
       (rax
        (tmp.111
         tmp.107
         tmp.108
         tmp.99
         tmp.104
         tmp.100
         tmp.101
         tmp.97
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
         rbp
         tmp-ra.125))
       (rsi
        (tmp.99
         tmp.107
         tmp.111
         tmp.108
         tmp.100
         tmp.104
         tmp.101
         tmp.85
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
         rbp))
       (rdi (r15 rbp rsi))
       (r15 (rbp rdi rsi))))
     (assignment
      ((tmp-ra.125 fv0)
       (tmp.76 fv1)
       (tmp.80 fv1)
       (tmp.79 fv1)
       (tmp.87 fv1)
       (tmp.86 fv1)
       (tmp.85 fv1)
       (tmp.97 fv2)
       (tmp.101 fv1)
       (tmp.100 fv1)
       (tmp.99 fv1)
       (tmp.111 fv2)
       (tmp.107 fv3)
       (tmp.108 fv2)
       (tmp.104 fv2)
       (tmp.93 fv3)
       (tmp.94 fv2)
       (tmp.90 fv2)
       (tmp.83 fv2)
       (tmp.71 fv3)
       (tmp.72 fv2)
       (tmp.73 fv1)
       (tmp.84 r15)
       (tmp.98 r15)
       (tmp.112 r15)
       (tmp.77 r15)
       (tmp.81 r15)
       (tmp.82 r15)
       (tmp.91 r15)
       (tmp.95 r15)
       (tmp.96 r15)
       (tmp.105 r15)
       (tmp.109 r15)
       (tmp.110 r15)
       (tmp.74 r15)
       (tmp.75 r15)
       (tmp.78 r15)
       (tmp.88 r15)
       (tmp.89 r15)
       (tmp.92 r15)
       (tmp.102 r15)
       (tmp.103 r15)
       (tmp.106 r15)
       (fixnum0.6 r15)
       (fixnum1.5 r15)
       (ascii-char2.4 r15)
       (void3.3 r15)
       (empty4.2 r15)
       (fixnum5.1 r15))))
    (define L.+.16
      ((locals ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.113 tmp.23 tmp.22))
         (tmp.126 (tmp.23 rbp tmp-ra.113 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.113
           tmp.22
           tmp.126
           tmp.58
           tmp.57
           tmp.127
           tmp.60
           tmp.59
           tmp.128))
         (tmp.58 (rbp tmp-ra.113 tmp.23 tmp.22))
         (tmp-ra.113
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.126
           tmp.58
           tmp.57
           tmp.127
           tmp.60
           tmp.59
           tmp.128
           rax))
         (tmp.128 (rbp tmp-ra.113 tmp.23))
         (tmp.60 (rbp tmp-ra.113 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.113
           rsi
           tmp.126
           tmp.58
           tmp.57
           tmp.127
           tmp.60
           tmp.59))
         (tmp.127 (tmp.22 rbp tmp-ra.113 tmp.23))
         (tmp.59 (rbp tmp-ra.113 tmp.23 tmp.22))
         (rax (rbp tmp-ra.113))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.113
           tmp.126
           tmp.58
           tmp.57
           tmp.127
           tmp.60
           tmp.59
           tmp.128
           rax))
         (rdi (tmp-ra.113))
         (rsi (tmp.22 tmp-ra.113))))
       (assignment
        ((tmp-ra.113 r15)
         (tmp.23 r14)
         (tmp.22 r13)
         (tmp.57 r9)
         (tmp.126 r9)
         (tmp.58 r9)
         (tmp.60 r9)
         (tmp.127 r9)
         (tmp.59 r9)
         (tmp.128 r13))))
      (begin
        (set! tmp-ra.113 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.126 tmp.23)
                      (set! tmp.126 (bitwise-and tmp.126 7))
                      (set! tmp.58 tmp.126))
                    (= tmp.58 0))
                (set! tmp.57 14)
                (set! tmp.57 6))
              (!= tmp.57 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.127 tmp.22)
                        (set! tmp.127 (bitwise-and tmp.127 7))
                        (set! tmp.60 tmp.127))
                      (= tmp.60 0))
                  (set! tmp.59 14)
                  (set! tmp.59 6))
                (!= tmp.59 6))
            (begin
              (set! tmp.128 tmp.22)
              (set! tmp.128 (+ tmp.128 tmp.23))
              (set! rax tmp.128)
              (jump tmp-ra.113 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.113 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.113 rbp rax)))))
    (define L.-.15
      ((locals ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.114 tmp.25 tmp.24))
         (tmp.129 (tmp.25 rbp tmp-ra.114 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.114
           tmp.24
           tmp.129
           tmp.62
           tmp.61
           tmp.130
           tmp.64
           tmp.63
           tmp.131))
         (tmp.62 (rbp tmp-ra.114 tmp.25 tmp.24))
         (tmp-ra.114
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.129
           tmp.62
           tmp.61
           tmp.130
           tmp.64
           tmp.63
           tmp.131
           rax))
         (tmp.131 (rbp tmp-ra.114 tmp.25))
         (tmp.64 (rbp tmp-ra.114 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.114
           rsi
           tmp.129
           tmp.62
           tmp.61
           tmp.130
           tmp.64
           tmp.63))
         (tmp.130 (tmp.24 rbp tmp-ra.114 tmp.25))
         (tmp.63 (rbp tmp-ra.114 tmp.25 tmp.24))
         (rax (rbp tmp-ra.114))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.114
           tmp.129
           tmp.62
           tmp.61
           tmp.130
           tmp.64
           tmp.63
           tmp.131
           rax))
         (rdi (tmp-ra.114))
         (rsi (tmp.24 tmp-ra.114))))
       (assignment
        ((tmp-ra.114 r15)
         (tmp.25 r14)
         (tmp.24 r13)
         (tmp.61 r9)
         (tmp.129 r9)
         (tmp.62 r9)
         (tmp.64 r9)
         (tmp.130 r9)
         (tmp.63 r9)
         (tmp.131 r13))))
      (begin
        (set! tmp-ra.114 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.129 tmp.25)
                      (set! tmp.129 (bitwise-and tmp.129 7))
                      (set! tmp.62 tmp.129))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.130 tmp.24)
                        (set! tmp.130 (bitwise-and tmp.130 7))
                        (set! tmp.64 tmp.130))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.131 tmp.24)
              (set! tmp.131 (- tmp.131 tmp.25))
              (set! rax tmp.131)
              (jump tmp-ra.114 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.114 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.114 rbp rax)))))
    (define L.*.14
      ((locals ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.115 tmp.20 tmp.21))
         (tmp.132 (tmp.21 rbp tmp-ra.115 tmp.20))
         (tmp.21
          (rbp tmp-ra.115 tmp.20 tmp.132 tmp.66 tmp.65 tmp.133 tmp.68 tmp.67))
         (tmp.66 (rbp tmp-ra.115 tmp.20 tmp.21))
         (tmp-ra.115
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.132
           tmp.66
           tmp.65
           tmp.133
           tmp.68
           tmp.67
           tmp.135
           tmp.69
           tmp.134
           rax))
         (tmp.134 (rbp tmp-ra.115 tmp.20))
         (tmp.69 (tmp.135 rbp tmp-ra.115 tmp.20))
         (tmp.135 (rbp tmp-ra.115 tmp.69))
         (tmp.68 (rbp tmp-ra.115 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.115
           rsi
           tmp.132
           tmp.66
           tmp.65
           tmp.133
           tmp.68
           tmp.67
           tmp.69
           tmp.134))
         (tmp.133 (tmp.20 rbp tmp-ra.115 tmp.21))
         (tmp.67 (rbp tmp-ra.115 tmp.20 tmp.21))
         (rax (rbp tmp-ra.115))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.115
           tmp.132
           tmp.66
           tmp.65
           tmp.133
           tmp.68
           tmp.67
           tmp.135
           tmp.69
           tmp.134
           rax))
         (rdi (tmp-ra.115))
         (rsi (tmp.20 tmp-ra.115))))
       (assignment
        ((tmp-ra.115 r15)
         (tmp.20 r14)
         (tmp.21 r13)
         (tmp.65 r9)
         (tmp.132 r9)
         (tmp.66 r9)
         (tmp.69 r13)
         (tmp.68 r9)
         (tmp.133 r9)
         (tmp.67 r9)
         (tmp.134 r13)
         (tmp.135 r14))))
      (begin
        (set! tmp-ra.115 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.132 tmp.21)
                      (set! tmp.132 (bitwise-and tmp.132 7))
                      (set! tmp.66 tmp.132))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.133 tmp.20)
                        (set! tmp.133 (bitwise-and tmp.133 7))
                        (set! tmp.68 tmp.133))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.134 tmp.21)
              (set! tmp.134 (arithmetic-shift-right tmp.134 3))
              (set! tmp.69 tmp.134)
              (set! tmp.135 tmp.20)
              (set! tmp.135 (* tmp.135 tmp.69))
              (set! rax tmp.135)
              (jump tmp-ra.115 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.115 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.115 rbp rax)))))
    (define L.cons.13
      ((locals ())
       (conflicts
        ((tmp-ra.116 (rax tmp.56 tmp.136 tmp.70 tmp.53 tmp.52 rbp r12 rsi rdi))
         (tmp.52 (tmp.56 tmp.136 tmp.70 tmp.53 rbp tmp-ra.116 r12 rsi))
         (tmp.53 (tmp.56 tmp.136 tmp.70 tmp.52 rbp tmp-ra.116 r12))
         (tmp.70 (tmp.52 rbp tmp-ra.116 tmp.53 r12))
         (tmp.136 (tmp.52 rbp tmp-ra.116 tmp.53))
         (tmp.56 (tmp.52 rbp tmp-ra.116 tmp.53))
         (rdi (tmp-ra.116))
         (rsi (tmp.52 tmp-ra.116))
         (r12 (rbp tmp.70 tmp.53 tmp.52 tmp-ra.116))
         (rbp (rax tmp.56 tmp.136 tmp.70 r12 tmp.53 tmp.52 tmp-ra.116))
         (rax (rbp tmp-ra.116))))
       (assignment
        ((tmp-ra.116 r15)
         (tmp.52 r14)
         (tmp.53 r13)
         (tmp.70 r9)
         (tmp.136 r9)
         (tmp.56 r9))))
      (begin
        (set! tmp-ra.116 r15)
        (set! tmp.52 rdi)
        (set! tmp.53 rsi)
        (begin (set! tmp.70 r12) (set! r12 (+ r12 16)))
        (set! tmp.136 tmp.70)
        (set! tmp.136 (+ tmp.136 1))
        (set! tmp.56 tmp.136)
        (mset! tmp.56 -1 tmp.52)
        (mset! tmp.56 7 tmp.53)
        (set! rax tmp.56)
        (jump tmp-ra.116 rbp rax)))
    (define L.fun/empty27006.4
      ((locals ())
       (conflicts ((tmp-ra.117 (rbp)) (rbp (r15 tmp-ra.117)) (r15 (rbp))))
       (assignment ((tmp-ra.117 r15))))
      (begin
        (set! tmp-ra.117 r15)
        (set! r15 tmp-ra.117)
        (jump L.fun/empty27007.9 rbp r15)))
    (define L.fun/pair27009.5
      ((locals ())
       (conflicts
        ((tmp-ra.118 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.118))
         (rsi (r15 rdi rbp tmp-ra.118))
         (rdi (r15 rbp rsi tmp-ra.118))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.118 r15))))
      (begin
        (set! tmp-ra.118 r15)
        (set! rsi 2952)
        (set! rdi 1768)
        (set! r15 tmp-ra.118)
        (jump L.cons.13 rbp r15 rdi rsi)))
    (define L.fun/void27004.6
      ((locals ())
       (conflicts ((tmp-ra.119 (rbp)) (rbp (r15 tmp-ra.119)) (r15 (rbp))))
       (assignment ((tmp-ra.119 r15))))
      (begin
        (set! tmp-ra.119 r15)
        (set! r15 tmp-ra.119)
        (jump L.fun/void27005.11 rbp r15)))
    (define L.fun/ascii-char27003.7
      ((locals ())
       (conflicts
        ((tmp-ra.120 (rax rbp)) (rbp (rax tmp-ra.120)) (rax (rbp tmp-ra.120))))
       (assignment ((tmp-ra.120 r15))))
      (begin (set! tmp-ra.120 r15) (set! rax 29998) (jump tmp-ra.120 rbp rax)))
    (define L.fun/pair27008.8
      ((locals ())
       (conflicts ((tmp-ra.121 (rbp)) (rbp (r15 tmp-ra.121)) (r15 (rbp))))
       (assignment ((tmp-ra.121 r15))))
      (begin
        (set! tmp-ra.121 r15)
        (set! r15 tmp-ra.121)
        (jump L.fun/pair27009.5 rbp r15)))
    (define L.fun/empty27007.9
      ((locals ())
       (conflicts
        ((tmp-ra.122 (rax rbp)) (rbp (rax tmp-ra.122)) (rax (rbp tmp-ra.122))))
       (assignment ((tmp-ra.122 r15))))
      (begin (set! tmp-ra.122 r15) (set! rax 22) (jump tmp-ra.122 rbp rax)))
    (define L.fun/ascii-char27002.10
      ((locals ())
       (conflicts ((tmp-ra.123 (rbp)) (rbp (r15 tmp-ra.123)) (r15 (rbp))))
       (assignment ((tmp-ra.123 r15))))
      (begin
        (set! tmp-ra.123 r15)
        (set! r15 tmp-ra.123)
        (jump L.fun/ascii-char27003.7 rbp r15)))
    (define L.fun/void27005.11
      ((locals ())
       (conflicts
        ((tmp-ra.124 (rax rbp)) (rbp (rax tmp-ra.124)) (rax (rbp tmp-ra.124))))
       (assignment ((tmp-ra.124 r15))))
      (begin (set! tmp-ra.124 r15) (set! rax 30) (jump tmp-ra.124 rbp rax)))
    (begin
      (set! tmp-ra.125 r15)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.17
          (begin
            (set! rsi 1480)
            (set! rdi 264)
            (set! r15 L.rp.17)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.18
          (begin
            (set! rsi 408)
            (set! rdi 1256)
            (set! r15 L.rp.18)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.19
          (begin
            (set! rsi tmp.74)
            (set! rdi tmp.73)
            (set! r15 L.rp.19)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.20
          (begin
            (set! rsi 1408)
            (set! rdi 384)
            (set! r15 L.rp.20)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.21
          (begin
            (set! rsi 1384)
            (set! rdi 2016)
            (set! r15 L.rp.21)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.22
          (begin
            (set! rsi tmp.77)
            (set! rdi tmp.76)
            (set! r15 L.rp.22)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.23
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.72)
            (set! r15 L.rp.23)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.24
          (begin
            (set! rsi 1384)
            (set! rdi 168)
            (set! r15 L.rp.24)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.25
          (begin
            (set! rsi 808)
            (set! rdi 872)
            (set! r15 L.rp.25)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.26
          (begin
            (set! rsi tmp.81)
            (set! rdi tmp.80)
            (set! r15 L.rp.26)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.27
          (begin
            (set! rsi 608)
            (set! rdi 560)
            (set! r15 L.rp.27)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.28
          (begin
            (set! rsi 872)
            (set! rdi 520)
            (set! r15 L.rp.28)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.29
          (begin
            (set! rsi tmp.84)
            (set! rdi tmp.83)
            (set! r15 L.rp.29)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.30
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.79)
            (set! r15 L.rp.30)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.78)
            (set! rdi tmp.71)
            (set! r15 L.rp.31)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! fixnum0.6 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.32
          (begin
            (set! rsi 488)
            (set! rdi 776)
            (set! r15 L.rp.32)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.33
          (begin
            (set! rsi 1368)
            (set! rdi 704)
            (set! r15 L.rp.33)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.88 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.34
          (begin
            (set! rsi tmp.88)
            (set! rdi tmp.87)
            (set! r15 L.rp.34)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.35
          (begin
            (set! rsi 1592)
            (set! rdi 1880)
            (set! r15 L.rp.35)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.36
          (begin
            (set! rsi 1824)
            (set! rdi 1080)
            (set! r15 L.rp.36)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.37
          (begin
            (set! rsi tmp.91)
            (set! rdi tmp.90)
            (set! r15 L.rp.37)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.38
          (begin
            (set! rsi tmp.89)
            (set! rdi tmp.86)
            (set! r15 L.rp.38)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.39
          (begin
            (set! rsi 1800)
            (set! rdi 1312)
            (set! r15 L.rp.39)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.94 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.40
          (begin
            (set! rsi 1856)
            (set! rdi 792)
            (set! r15 L.rp.40)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.95 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.41
          (begin
            (set! rsi tmp.95)
            (set! rdi tmp.94)
            (set! r15 L.rp.41)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.93 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.42
          (begin
            (set! rsi 408)
            (set! rdi 608)
            (set! r15 L.rp.42)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.97 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.43
          (begin
            (set! rsi 904)
            (set! rdi 16)
            (set! r15 L.rp.43)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.98 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.44
          (begin
            (set! rsi tmp.98)
            (set! rdi tmp.97)
            (set! r15 L.rp.44)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.96 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.45
          (begin
            (set! rsi tmp.96)
            (set! rdi tmp.93)
            (set! r15 L.rp.45)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.46
          (begin
            (set! rsi tmp.92)
            (set! rdi tmp.85)
            (set! r15 L.rp.46)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! fixnum1.5 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.47
          (begin (set! r15 L.rp.47) (jump L.fun/ascii-char27002.10 rbp r15)))
        (set! rbp (+ rbp 176)))
      (set! ascii-char2.4 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/void27004.6 rbp r15)))
        (set! rbp (+ rbp 176)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/empty27006.4 rbp r15)))
        (set! rbp (+ rbp 176)))
      (set! empty4.2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.50
          (begin
            (set! rsi 48)
            (set! rdi 704)
            (set! r15 L.rp.50)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.101 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.51
          (begin
            (set! rsi 1168)
            (set! rdi 1448)
            (set! r15 L.rp.51)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.102 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.52
          (begin
            (set! rsi tmp.102)
            (set! rdi tmp.101)
            (set! r15 L.rp.52)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.100 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.53
          (begin
            (set! rsi 784)
            (set! rdi 1016)
            (set! r15 L.rp.53)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.104 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.54
          (begin
            (set! rsi 2016)
            (set! rdi 240)
            (set! r15 L.rp.54)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.105 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.55
          (begin
            (set! rsi tmp.105)
            (set! rdi tmp.104)
            (set! r15 L.rp.55)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.103 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.56
          (begin
            (set! rsi tmp.103)
            (set! rdi tmp.100)
            (set! r15 L.rp.56)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.99 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.57
          (begin
            (set! rsi 1968)
            (set! rdi 496)
            (set! r15 L.rp.57)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.108 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.58
          (begin
            (set! rsi 1688)
            (set! rdi 1672)
            (set! r15 L.rp.58)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.109 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.59
          (begin
            (set! rsi tmp.109)
            (set! rdi tmp.108)
            (set! r15 L.rp.59)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.107 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.60
          (begin
            (set! rsi 992)
            (set! rdi 880)
            (set! r15 L.rp.60)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.111 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.61
          (begin
            (set! rsi 1000)
            (set! rdi 1176)
            (set! r15 L.rp.61)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.112 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.62
          (begin
            (set! rsi tmp.112)
            (set! rdi tmp.111)
            (set! r15 L.rp.62)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.110 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.63
          (begin
            (set! rsi tmp.110)
            (set! rdi tmp.107)
            (set! r15 L.rp.63)
            (jump L.*.14 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! tmp.106 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.64
          (begin
            (set! rsi tmp.106)
            (set! rdi tmp.99)
            (set! r15 L.rp.64)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 176)))
      (set! fixnum5.1 rax)
      (set! r15 tmp-ra.125)
      (jump L.fun/pair27008.8 rbp r15))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.106
        (rdi
         rsi
         tmp.88
         tmp.91
         tmp.92
         tmp.89
         tmp.90
         tmp.83
         tmp.86
         tmp.87
         tmp.84
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
         empty3.3
         empty2.4
         error1.5
         ascii-char0.6
         rax
         rbp))
       (ascii-char0.6 (rbp tmp-ra.106))
       (error1.5 (rbp tmp-ra.106))
       (empty2.4 (rbp tmp-ra.106))
       (empty3.3 (rbp tmp-ra.106))
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
        (tmp.92
         tmp.89
         tmp.90
         tmp.83
         tmp.86
         tmp.87
         tmp.84
         tmp.85
         rsi
         ascii-char5.1
         rax
         rbp
         tmp-ra.106))
       (ascii-char5.1 (rbp tmp-ra.106 fixnum4.2))
       (tmp.85 (rbp tmp-ra.106 fixnum4.2))
       (tmp.84 (rsi tmp.86 tmp.87 rax rbp tmp-ra.106 fixnum4.2))
       (tmp.87 (rbp tmp-ra.106 fixnum4.2 tmp.84))
       (tmp.86 (rbp tmp-ra.106 fixnum4.2 tmp.84))
       (tmp.83
        (rsi tmp.88 tmp.91 tmp.92 tmp.89 tmp.90 rax rbp tmp-ra.106 fixnum4.2))
       (tmp.90 (rsi rbp tmp-ra.106 tmp.83 fixnum4.2))
       (tmp.89 (rsi tmp.91 tmp.92 rax rbp tmp-ra.106 tmp.83 fixnum4.2))
       (tmp.92 (rsi rbp tmp-ra.106 tmp.83 tmp.89 fixnum4.2))
       (tmp.91 (rbp tmp-ra.106 tmp.83 tmp.89))
       (tmp.88 (rbp tmp-ra.106 tmp.83))
       (rbp
        (tmp.88
         tmp.91
         tmp.92
         tmp.89
         tmp.90
         tmp.83
         tmp.86
         tmp.87
         tmp.84
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
         empty3.3
         empty2.4
         error1.5
         ascii-char0.6
         r15
         rax
         tmp-ra.106))
       (rax
        (tmp.89
         tmp.83
         tmp.84
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
         tmp.89
         tmp.92
         tmp.90
         tmp.84
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
       (rdi (tmp-ra.106 r15 rbp rsi))))
     (assignment
      ((tmp-ra.106 fv0)
       (tmp.74 fv1)
       (tmp.78 fv1)
       (tmp.77 fv1)
       (tmp.84 fv1)
       (tmp.89 fv1)
       (tmp.83 fv2)
       (fixnum4.2 fv3)
       (tmp.81 fv2)
       (tmp.69 fv3)
       (tmp.70 fv2)
       (tmp.71 fv1)
       (tmp.92 r15)
       (tmp.82 r15)
       (tmp.90 r15)
       (tmp.75 r15)
       (tmp.79 r15)
       (tmp.80 r15)
       (tmp.87 r15)
       (tmp.86 r15)
       (tmp.91 r15)
       (tmp.72 r15)
       (tmp.73 r15)
       (tmp.76 r15)
       (ascii-char5.1 r15)
       (tmp.85 r15)
       (tmp.88 r15)
       (ascii-char0.6 r15)
       (error1.5 r15)
       (empty2.4 r15)
       (empty3.3 r15))))
    (define L.*.17
      ((locals ())
       (conflicts
        ((tmp.56 (rbp tmp-ra.93 tmp.20 tmp.21))
         (tmp.107 (tmp.21 rbp tmp-ra.93 tmp.20))
         (tmp.21
          (rbp tmp-ra.93 tmp.20 tmp.107 tmp.57 tmp.56 tmp.108 tmp.59 tmp.58))
         (tmp.57 (rbp tmp-ra.93 tmp.20 tmp.21))
         (tmp-ra.93
          (tmp.21
           tmp.20
           rbp
           rsi
           rdi
           tmp.107
           tmp.57
           tmp.56
           tmp.108
           tmp.59
           tmp.58
           tmp.110
           tmp.60
           tmp.109
           rax))
         (tmp.109 (rbp tmp-ra.93 tmp.20))
         (tmp.60 (tmp.110 rbp tmp-ra.93 tmp.20))
         (tmp.110 (rbp tmp-ra.93 tmp.60))
         (tmp.59 (rbp tmp-ra.93 tmp.20 tmp.21))
         (tmp.20
          (tmp.21
           rbp
           tmp-ra.93
           rsi
           tmp.107
           tmp.57
           tmp.56
           tmp.108
           tmp.59
           tmp.58
           tmp.60
           tmp.109))
         (tmp.108 (tmp.20 rbp tmp-ra.93 tmp.21))
         (tmp.58 (rbp tmp-ra.93 tmp.20 tmp.21))
         (rax (rbp tmp-ra.93))
         (rbp
          (tmp.21
           tmp.20
           tmp-ra.93
           tmp.107
           tmp.57
           tmp.56
           tmp.108
           tmp.59
           tmp.58
           tmp.110
           tmp.60
           tmp.109
           rax))
         (rdi (tmp-ra.93))
         (rsi (tmp.20 tmp-ra.93))))
       (assignment
        ((tmp-ra.93 r15)
         (tmp.20 r14)
         (tmp.21 r13)
         (tmp.56 r9)
         (tmp.107 r9)
         (tmp.57 r9)
         (tmp.60 r13)
         (tmp.59 r9)
         (tmp.108 r9)
         (tmp.58 r9)
         (tmp.109 r13)
         (tmp.110 r14))))
      (begin
        (set! tmp-ra.93 r15)
        (set! tmp.20 rdi)
        (set! tmp.21 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.107 tmp.21)
                      (set! tmp.107 (bitwise-and tmp.107 7))
                      (set! tmp.57 tmp.107))
                    (= tmp.57 0))
                (set! tmp.56 14)
                (set! tmp.56 6))
              (!= tmp.56 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.108 tmp.20)
                        (set! tmp.108 (bitwise-and tmp.108 7))
                        (set! tmp.59 tmp.108))
                      (= tmp.59 0))
                  (set! tmp.58 14)
                  (set! tmp.58 6))
                (!= tmp.58 6))
            (begin
              (set! tmp.109 tmp.21)
              (set! tmp.109 (arithmetic-shift-right tmp.109 3))
              (set! tmp.60 tmp.109)
              (set! tmp.110 tmp.20)
              (set! tmp.110 (* tmp.110 tmp.60))
              (set! rax tmp.110)
              (jump tmp-ra.93 rbp rax))
            (begin (set! rax 318) (jump tmp-ra.93 rbp rax)))
          (begin (set! rax 318) (jump tmp-ra.93 rbp rax)))))
    (define L.+.16
      ((locals ())
       (conflicts
        ((tmp.61 (rbp tmp-ra.94 tmp.23 tmp.22))
         (tmp.111 (tmp.23 rbp tmp-ra.94 tmp.22))
         (tmp.23
          (rbp
           tmp-ra.94
           tmp.22
           tmp.111
           tmp.62
           tmp.61
           tmp.112
           tmp.64
           tmp.63
           tmp.113))
         (tmp.62 (rbp tmp-ra.94 tmp.23 tmp.22))
         (tmp-ra.94
          (tmp.23
           tmp.22
           rbp
           rsi
           rdi
           tmp.111
           tmp.62
           tmp.61
           tmp.112
           tmp.64
           tmp.63
           tmp.113
           rax))
         (tmp.113 (rbp tmp-ra.94 tmp.23))
         (tmp.64 (rbp tmp-ra.94 tmp.23 tmp.22))
         (tmp.22
          (tmp.23
           rbp
           tmp-ra.94
           rsi
           tmp.111
           tmp.62
           tmp.61
           tmp.112
           tmp.64
           tmp.63))
         (tmp.112 (tmp.22 rbp tmp-ra.94 tmp.23))
         (tmp.63 (rbp tmp-ra.94 tmp.23 tmp.22))
         (rax (rbp tmp-ra.94))
         (rbp
          (tmp.23
           tmp.22
           tmp-ra.94
           tmp.111
           tmp.62
           tmp.61
           tmp.112
           tmp.64
           tmp.63
           tmp.113
           rax))
         (rdi (tmp-ra.94))
         (rsi (tmp.22 tmp-ra.94))))
       (assignment
        ((tmp-ra.94 r15)
         (tmp.23 r14)
         (tmp.22 r13)
         (tmp.61 r9)
         (tmp.111 r9)
         (tmp.62 r9)
         (tmp.64 r9)
         (tmp.112 r9)
         (tmp.63 r9)
         (tmp.113 r13))))
      (begin
        (set! tmp-ra.94 r15)
        (set! tmp.22 rdi)
        (set! tmp.23 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.111 tmp.23)
                      (set! tmp.111 (bitwise-and tmp.111 7))
                      (set! tmp.62 tmp.111))
                    (= tmp.62 0))
                (set! tmp.61 14)
                (set! tmp.61 6))
              (!= tmp.61 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.112 tmp.22)
                        (set! tmp.112 (bitwise-and tmp.112 7))
                        (set! tmp.64 tmp.112))
                      (= tmp.64 0))
                  (set! tmp.63 14)
                  (set! tmp.63 6))
                (!= tmp.63 6))
            (begin
              (set! tmp.113 tmp.22)
              (set! tmp.113 (+ tmp.113 tmp.23))
              (set! rax tmp.113)
              (jump tmp-ra.94 rbp rax))
            (begin (set! rax 574) (jump tmp-ra.94 rbp rax)))
          (begin (set! rax 574) (jump tmp-ra.94 rbp rax)))))
    (define L.-.15
      ((locals ())
       (conflicts
        ((tmp.65 (rbp tmp-ra.95 tmp.25 tmp.24))
         (tmp.114 (tmp.25 rbp tmp-ra.95 tmp.24))
         (tmp.25
          (rbp
           tmp-ra.95
           tmp.24
           tmp.114
           tmp.66
           tmp.65
           tmp.115
           tmp.68
           tmp.67
           tmp.116))
         (tmp.66 (rbp tmp-ra.95 tmp.25 tmp.24))
         (tmp-ra.95
          (tmp.25
           tmp.24
           rbp
           rsi
           rdi
           tmp.114
           tmp.66
           tmp.65
           tmp.115
           tmp.68
           tmp.67
           tmp.116
           rax))
         (tmp.116 (rbp tmp-ra.95 tmp.25))
         (tmp.68 (rbp tmp-ra.95 tmp.25 tmp.24))
         (tmp.24
          (tmp.25
           rbp
           tmp-ra.95
           rsi
           tmp.114
           tmp.66
           tmp.65
           tmp.115
           tmp.68
           tmp.67))
         (tmp.115 (tmp.24 rbp tmp-ra.95 tmp.25))
         (tmp.67 (rbp tmp-ra.95 tmp.25 tmp.24))
         (rax (rbp tmp-ra.95))
         (rbp
          (tmp.25
           tmp.24
           tmp-ra.95
           tmp.114
           tmp.66
           tmp.65
           tmp.115
           tmp.68
           tmp.67
           tmp.116
           rax))
         (rdi (tmp-ra.95))
         (rsi (tmp.24 tmp-ra.95))))
       (assignment
        ((tmp-ra.95 r15)
         (tmp.25 r14)
         (tmp.24 r13)
         (tmp.65 r9)
         (tmp.114 r9)
         (tmp.66 r9)
         (tmp.68 r9)
         (tmp.115 r9)
         (tmp.67 r9)
         (tmp.116 r13))))
      (begin
        (set! tmp-ra.95 r15)
        (set! tmp.24 rdi)
        (set! tmp.25 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! tmp.114 tmp.25)
                      (set! tmp.114 (bitwise-and tmp.114 7))
                      (set! tmp.66 tmp.114))
                    (= tmp.66 0))
                (set! tmp.65 14)
                (set! tmp.65 6))
              (!= tmp.65 6))
          (if (begin
                (if (begin
                      (begin
                        (set! tmp.115 tmp.24)
                        (set! tmp.115 (bitwise-and tmp.115 7))
                        (set! tmp.68 tmp.115))
                      (= tmp.68 0))
                  (set! tmp.67 14)
                  (set! tmp.67 6))
                (!= tmp.67 6))
            (begin
              (set! tmp.116 tmp.24)
              (set! tmp.116 (- tmp.116 tmp.25))
              (set! rax tmp.116)
              (jump tmp-ra.95 rbp rax))
            (begin (set! rax 830) (jump tmp-ra.95 rbp rax)))
          (begin (set! rax 830) (jump tmp-ra.95 rbp rax)))))
    (define L.fun/ascii-char27114.4
      ((locals ())
       (conflicts ((tmp-ra.96 (rbp)) (rbp (r15 tmp-ra.96)) (r15 (rbp))))
       (assignment ((tmp-ra.96 r15))))
      (begin
        (set! tmp-ra.96 r15)
        (set! r15 tmp-ra.96)
        (jump L.fun/ascii-char27115.8 rbp r15)))
    (define L.fun/empty27120.5
      ((locals ())
       (conflicts ((tmp-ra.97 (rbp)) (rbp (r15 tmp-ra.97)) (r15 (rbp))))
       (assignment ((tmp-ra.97 r15))))
      (begin
        (set! tmp-ra.97 r15)
        (set! r15 tmp-ra.97)
        (jump L.fun/empty27121.11 rbp r15)))
    (define L.fun/error27116.6
      ((locals ())
       (conflicts ((tmp-ra.98 (rbp)) (rbp (r15 tmp-ra.98)) (r15 (rbp))))
       (assignment ((tmp-ra.98 r15))))
      (begin
        (set! tmp-ra.98 r15)
        (set! r15 tmp-ra.98)
        (jump L.fun/error27117.7 rbp r15)))
    (define L.fun/error27117.7
      ((locals ())
       (conflicts
        ((tmp-ra.99 (rax rbp)) (rbp (rax tmp-ra.99)) (rax (rbp tmp-ra.99))))
       (assignment ((tmp-ra.99 r15))))
      (begin (set! tmp-ra.99 r15) (set! rax 34622) (jump tmp-ra.99 rbp rax)))
    (define L.fun/ascii-char27115.8
      ((locals ())
       (conflicts
        ((tmp-ra.100 (rax rbp)) (rbp (rax tmp-ra.100)) (rax (rbp tmp-ra.100))))
       (assignment ((tmp-ra.100 r15))))
      (begin (set! tmp-ra.100 r15) (set! rax 23342) (jump tmp-ra.100 rbp rax)))
    (define L.fun/ascii-char27123.9
      ((locals ())
       (conflicts
        ((tmp-ra.101 (rax rbp)) (rbp (rax tmp-ra.101)) (rax (rbp tmp-ra.101))))
       (assignment ((tmp-ra.101 r15))))
      (begin (set! tmp-ra.101 r15) (set! rax 27694) (jump tmp-ra.101 rbp rax)))
    (define L.fun/ascii-char27122.10
      ((locals ())
       (conflicts ((tmp-ra.102 (rbp)) (rbp (r15 tmp-ra.102)) (r15 (rbp))))
       (assignment ((tmp-ra.102 r15))))
      (begin
        (set! tmp-ra.102 r15)
        (set! r15 tmp-ra.102)
        (jump L.fun/ascii-char27123.9 rbp r15)))
    (define L.fun/empty27121.11
      ((locals ())
       (conflicts
        ((tmp-ra.103 (rax rbp)) (rbp (rax tmp-ra.103)) (rax (rbp tmp-ra.103))))
       (assignment ((tmp-ra.103 r15))))
      (begin (set! tmp-ra.103 r15) (set! rax 22) (jump tmp-ra.103 rbp rax)))
    (define L.fun/empty27118.12
      ((locals ())
       (conflicts ((tmp-ra.104 (rbp)) (rbp (r15 tmp-ra.104)) (r15 (rbp))))
       (assignment ((tmp-ra.104 r15))))
      (begin
        (set! tmp-ra.104 r15)
        (set! r15 tmp-ra.104)
        (jump L.fun/empty27119.13 rbp r15)))
    (define L.fun/empty27119.13
      ((locals ())
       (conflicts
        ((tmp-ra.105 (rax rbp)) (rbp (rax tmp-ra.105)) (rax (rbp tmp-ra.105))))
       (assignment ((tmp-ra.105 r15))))
      (begin (set! tmp-ra.105 r15) (set! rax 22) (jump tmp-ra.105 rbp rax)))
    (begin
      (set! tmp-ra.106 r15)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char27114.4 rbp r15)))
        (set! rbp (+ rbp 96)))
      (set! ascii-char0.6 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error27116.6 rbp r15)))
        (set! rbp (+ rbp 96)))
      (set! error1.5 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty27118.12 rbp r15)))
        (set! rbp (+ rbp 96)))
      (set! empty2.4 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty27120.5 rbp r15)))
        (set! rbp (+ rbp 96)))
      (set! empty3.3 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.22
          (begin
            (set! rsi 584)
            (set! rdi 608)
            (set! r15 L.rp.22)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.71 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.23
          (begin
            (set! rsi 1304)
            (set! rdi 1776)
            (set! r15 L.rp.23)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.72 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.24
          (begin
            (set! rsi tmp.72)
            (set! rdi tmp.71)
            (set! r15 L.rp.24)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.70 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.25
          (begin
            (set! rsi 1824)
            (set! rdi 1456)
            (set! r15 L.rp.25)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.74 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.26
          (begin
            (set! rsi 312)
            (set! rdi 1832)
            (set! r15 L.rp.26)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.75 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.27
          (begin
            (set! rsi tmp.75)
            (set! rdi tmp.74)
            (set! r15 L.rp.27)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.73 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.28
          (begin
            (set! rsi tmp.73)
            (set! rdi tmp.70)
            (set! r15 L.rp.28)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.69 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.29
          (begin
            (set! rsi 8)
            (set! rdi 1536)
            (set! r15 L.rp.29)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.78 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.30
          (begin
            (set! rsi 912)
            (set! rdi 648)
            (set! r15 L.rp.30)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.79 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.31
          (begin
            (set! rsi tmp.79)
            (set! rdi tmp.78)
            (set! r15 L.rp.31)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.77 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.32
          (begin
            (set! rsi 1304)
            (set! rdi 688)
            (set! r15 L.rp.32)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.81 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.33
          (begin
            (set! rsi 1096)
            (set! rdi 1544)
            (set! r15 L.rp.33)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.82 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.34
          (begin
            (set! rsi tmp.82)
            (set! rdi tmp.81)
            (set! r15 L.rp.34)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.80 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.35
          (begin
            (set! rsi tmp.80)
            (set! rdi tmp.77)
            (set! r15 L.rp.35)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.76 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.36
          (begin
            (set! rsi tmp.76)
            (set! rdi tmp.69)
            (set! r15 L.rp.36)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! fixnum4.2 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char27122.10 rbp r15)))
        (set! rbp (+ rbp 96)))
      (set! ascii-char5.1 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.38
          (begin
            (set! rsi 1928)
            (set! rdi fixnum4.2)
            (set! r15 L.rp.38)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.85 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.39
          (begin
            (set! rsi tmp.85)
            (set! rdi fixnum4.2)
            (set! r15 L.rp.39)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.84 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.40
          (begin
            (set! rsi fixnum4.2)
            (set! rdi 184)
            (set! r15 L.rp.40)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.87 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.41
          (begin
            (set! rsi tmp.87)
            (set! rdi fixnum4.2)
            (set! r15 L.rp.41)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.86 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.42
          (begin
            (set! rsi tmp.86)
            (set! rdi tmp.84)
            (set! r15 L.rp.42)
            (jump L.*.17 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.83 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.43
          (begin
            (set! rsi 912)
            (set! rdi 920)
            (set! r15 L.rp.43)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.90 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.44
          (begin
            (set! rsi fixnum4.2)
            (set! rdi tmp.90)
            (set! r15 L.rp.44)
            (jump L.+.16 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.89 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.45
          (begin
            (set! rsi 1752)
            (set! rdi 792)
            (set! r15 L.rp.45)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.92 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.46
          (begin
            (set! rsi fixnum4.2)
            (set! rdi tmp.92)
            (set! r15 L.rp.46)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.91 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.47
          (begin
            (set! rsi tmp.91)
            (set! rdi tmp.89)
            (set! r15 L.rp.47)
            (jump L.-.15 rbp r15 rdi rsi)))
        (set! rbp (+ rbp 96)))
      (set! tmp.88 rax)
      (set! rsi tmp.88)
      (set! rdi tmp.83)
      (set! r15 tmp-ra.106)
      (jump L.-.15 rbp r15 rdi rsi))))
(check-by-interp
 '(module
    ((locals ())
     (conflicts
      ((tmp-ra.75
        (ascii-char5.1
         ascii-char4.2
         void3.3
         error2.4
         ascii-char1.5
         boolean0.6
         tmp.59
         rax
         rbp))
       (tmp.59 (rbp tmp-ra.75))
       (boolean0.6 (rbp tmp-ra.75))
       (ascii-char1.5 (rbp tmp-ra.75))
       (error2.4 (rbp tmp-ra.75))
       (void3.3 (rbp tmp-ra.75))
       (ascii-char4.2 (rbp tmp-ra.75))
       (ascii-char5.1 (rbp tmp-ra.75))
       (rbp
        (ascii-char5.1
         ascii-char4.2
         void3.3
         error2.4
         ascii-char1.5
         boolean0.6
         rdi
         tmp.59
         r15
         rax
         tmp-ra.75))
       (rax (rbp tmp-ra.75))
       (r15 (rdi rbp))
       (rdi (r15 rbp))))
     (assignment
      ((tmp-ra.75 fv0)
       (tmp.59 r15)
       (boolean0.6 r15)
       (ascii-char1.5 r15)
       (error2.4 r15)
       (void3.3 r15)
       (ascii-char4.2 r15)
       (ascii-char5.1 r15))))
    (define L.pair?.19
      ((locals ())
       (conflicts
        ((tmp.57 (rbp tmp-ra.60))
         (tmp.49 (rbp tmp-ra.60))
         (tmp.76 (rbp tmp-ra.60))
         (tmp-ra.60 (tmp.49 rbp rdi tmp.76 tmp.57 rax))
         (rax (rbp tmp-ra.60))
         (rbp (tmp.49 tmp-ra.60 tmp.76 tmp.57 rax))
         (rdi (tmp-ra.60))))
       (assignment ((tmp-ra.60 r15) (tmp.57 r14) (tmp.49 r14) (tmp.76 r14))))
      (begin
        (set! tmp-ra.60 r15)
        (set! tmp.49 rdi)
        (if (begin
              (begin
                (set! tmp.76 tmp.49)
                (set! tmp.76 (bitwise-and tmp.76 7))
                (set! tmp.57 tmp.76))
              (= tmp.57 1))
          (begin (set! rax 14) (jump tmp-ra.60 rbp rax))
          (begin (set! rax 6) (jump tmp-ra.60 rbp rax)))))
    (define L.cons.18
      ((locals ())
       (conflicts
        ((tmp-ra.61 (rax tmp.56 tmp.77 tmp.58 tmp.53 tmp.52 rbp r12 rsi rdi))
         (tmp.52 (tmp.56 tmp.77 tmp.58 tmp.53 rbp tmp-ra.61 r12 rsi))
         (tmp.53 (tmp.56 tmp.77 tmp.58 tmp.52 rbp tmp-ra.61 r12))
         (tmp.58 (tmp.52 rbp tmp-ra.61 tmp.53 r12))
         (tmp.77 (tmp.52 rbp tmp-ra.61 tmp.53))
         (tmp.56 (tmp.52 rbp tmp-ra.61 tmp.53))
         (rdi (tmp-ra.61))
         (rsi (tmp.52 tmp-ra.61))
         (r12 (rbp tmp.58 tmp.53 tmp.52 tmp-ra.61))
         (rbp (rax tmp.56 tmp.77 tmp.58 r12 tmp.53 tmp.52 tmp-ra.61))
         (rax (rbp tmp-ra.61))))
       (assignment
        ((tmp-ra.61 r15)
         (tmp.52 r14)
         (tmp.53 r13)
         (tmp.58 r9)
         (tmp.77 r9)
         (tmp.56 r9))))
      (begin
        (set! tmp-ra.61 r15)
        (set! tmp.52 rdi)
        (set! tmp.53 rsi)
        (begin (set! tmp.58 r12) (set! r12 (+ r12 16)))
        (set! tmp.77 tmp.58)
        (set! tmp.77 (+ tmp.77 1))
        (set! tmp.56 tmp.77)
        (mset! tmp.56 -1 tmp.52)
        (mset! tmp.56 7 tmp.53)
        (set! rax tmp.56)
        (jump tmp-ra.61 rbp rax)))
    (define L.fun/pair27447.4
      ((locals ())
       (conflicts ((tmp-ra.62 (rbp)) (rbp (r15 tmp-ra.62)) (r15 (rbp))))
       (assignment ((tmp-ra.62 r15))))
      (begin
        (set! tmp-ra.62 r15)
        (set! r15 tmp-ra.62)
        (jump L.fun/pair27448.11 rbp r15)))
    (define L.fun/ascii-char27445.5
      ((locals ())
       (conflicts ((tmp-ra.63 (rbp)) (rbp (r15 tmp-ra.63)) (r15 (rbp))))
       (assignment ((tmp-ra.63 r15))))
      (begin
        (set! tmp-ra.63 r15)
        (set! r15 tmp-ra.63)
        (jump L.fun/ascii-char27446.13 rbp r15)))
    (define L.fun/ascii-char27438.6
      ((locals ())
       (conflicts
        ((tmp-ra.64 (rax rbp)) (rbp (rax tmp-ra.64)) (rax (rbp tmp-ra.64))))
       (assignment ((tmp-ra.64 r15))))
      (begin (set! tmp-ra.64 r15) (set! rax 18222) (jump tmp-ra.64 rbp rax)))
    (define L.fun/error27440.7
      ((locals ())
       (conflicts
        ((tmp-ra.65 (rax rbp)) (rbp (rax tmp-ra.65)) (rax (rbp tmp-ra.65))))
       (assignment ((tmp-ra.65 r15))))
      (begin (set! tmp-ra.65 r15) (set! rax 33342) (jump tmp-ra.65 rbp rax)))
    (define L.fun/ascii-char27443.8
      ((locals ())
       (conflicts ((tmp-ra.66 (rbp)) (rbp (r15 tmp-ra.66)) (r15 (rbp))))
       (assignment ((tmp-ra.66 r15))))
      (begin
        (set! tmp-ra.66 r15)
        (set! r15 tmp-ra.66)
        (jump L.fun/ascii-char27444.14 rbp r15)))
    (define L.fun/void27441.9
      ((locals ())
       (conflicts ((tmp-ra.67 (rbp)) (rbp (r15 tmp-ra.67)) (r15 (rbp))))
       (assignment ((tmp-ra.67 r15))))
      (begin
        (set! tmp-ra.67 r15)
        (set! r15 tmp-ra.67)
        (jump L.fun/void27442.12 rbp r15)))
    (define L.fun/error27439.10
      ((locals ())
       (conflicts ((tmp-ra.68 (rbp)) (rbp (r15 tmp-ra.68)) (r15 (rbp))))
       (assignment ((tmp-ra.68 r15))))
      (begin
        (set! tmp-ra.68 r15)
        (set! r15 tmp-ra.68)
        (jump L.fun/error27440.7 rbp r15)))
    (define L.fun/pair27448.11
      ((locals ())
       (conflicts
        ((tmp-ra.69 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.69))
         (rsi (r15 rdi rbp tmp-ra.69))
         (rdi (r15 rbp rsi tmp-ra.69))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.69 r15))))
      (begin
        (set! tmp-ra.69 r15)
        (set! rsi 3512)
        (set! rdi 1488)
        (set! r15 tmp-ra.69)
        (jump L.cons.18 rbp r15 rdi rsi)))
    (define L.fun/void27442.12
      ((locals ())
       (conflicts
        ((tmp-ra.70 (rax rbp)) (rbp (rax tmp-ra.70)) (rax (rbp tmp-ra.70))))
       (assignment ((tmp-ra.70 r15))))
      (begin (set! tmp-ra.70 r15) (set! rax 30) (jump tmp-ra.70 rbp rax)))
    (define L.fun/ascii-char27446.13
      ((locals ())
       (conflicts
        ((tmp-ra.71 (rax rbp)) (rbp (rax tmp-ra.71)) (rax (rbp tmp-ra.71))))
       (assignment ((tmp-ra.71 r15))))
      (begin (set! tmp-ra.71 r15) (set! rax 29230) (jump tmp-ra.71 rbp rax)))
    (define L.fun/ascii-char27444.14
      ((locals ())
       (conflicts
        ((tmp-ra.72 (rax rbp)) (rbp (rax tmp-ra.72)) (rax (rbp tmp-ra.72))))
       (assignment ((tmp-ra.72 r15))))
      (begin (set! tmp-ra.72 r15) (set! rax 25134) (jump tmp-ra.72 rbp rax)))
    (define L.fun/ascii-char27437.15
      ((locals ())
       (conflicts ((tmp-ra.73 (rbp)) (rbp (r15 tmp-ra.73)) (r15 (rbp))))
       (assignment ((tmp-ra.73 r15))))
      (begin
        (set! tmp-ra.73 r15)
        (set! r15 tmp-ra.73)
        (jump L.fun/ascii-char27438.6 rbp r15)))
    (define L.fun/any27436.16
      ((locals ())
       (conflicts
        ((tmp-ra.74 (rdi rsi rbp))
         (rbp (r15 rdi rsi tmp-ra.74))
         (rsi (r15 rdi rbp tmp-ra.74))
         (rdi (r15 rbp rsi tmp-ra.74))
         (r15 (rbp rdi rsi))))
       (assignment ((tmp-ra.74 r15))))
      (begin
        (set! tmp-ra.74 r15)
        (set! rsi 3104)
        (set! rdi 1488)
        (set! r15 tmp-ra.74)
        (jump L.cons.18 rbp r15 rdi rsi)))
    (begin
      (set! tmp-ra.75 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/any27436.16 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! tmp.59 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin
            (set! rdi tmp.59)
            (set! r15 L.rp.21)
            (jump L.pair?.19 rbp r15 rdi)))
        (set! rbp (+ rbp 8)))
      (set! boolean0.6 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char27437.15 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char1.5 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error27439.10 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! error2.4 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/void27441.9 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! void3.3 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/ascii-char27443.8 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char4.2 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/ascii-char27445.5 rbp r15)))
        (set! rbp (+ rbp 8)))
      (set! ascii-char5.1 rax)
      (set! r15 tmp-ra.75)
      (jump L.fun/pair27447.4 rbp r15))))
