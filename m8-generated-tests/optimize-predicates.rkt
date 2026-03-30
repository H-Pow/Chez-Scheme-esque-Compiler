#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         "../target-nested-asm-lang-v2/optimize-predicates.rkt")
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
  (interp-nested-asm-lang-fvars-v8 p)
  (interp-nested-asm-lang-fvars-v8 (fail-if-invalid (optimize-predicates p)))))

(check-by-interp '(module (begin (set! r15 r15) (set! rax 30) (jump r15))))
(check-by-interp
 '(module
    (define L.cons.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (begin
      (set! r15 r15)
      (set! rsi 3816)
      (set! rdi 1808)
      (set! r15 r15)
      (jump L.cons.5))))
(check-by-interp
 '(module (begin (set! r15 r15) (set! r14 27438) (set! rax 22) (jump r15))))
(check-by-interp
 '(module (begin (set! r15 r15) (set! r14 30) (set! rax 31790) (jump r15))))
(check-by-interp
 '(module
    (define L.cons.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (begin
      (set! r15 r15)
      (set! r14 30)
      (set! rsi 3704)
      (set! rdi 1624)
      (set! r15 r15)
      (jump L.cons.5))))
(check-by-interp
 '(module
    (define L.fun/fixnum8389.4
      (begin (set! r15 r15) (set! rax 1672) (jump r15)))
    (begin (set! r15 r15) (set! r15 r15) (jump L.fun/fixnum8389.4))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (set! r14 6)
      (set! r14 30)
      (set! rax 30)
      (jump r15))))
(check-by-interp
 '(module
    (define L.fun/fixnum8394.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 312) (jump r15)))
    (begin
      (set! r15 r15)
      (if (begin (set! r14 14) (!= r14 6)) (set! r14 15934) (set! r14 45118))
      (set! rdi r14)
      (set! r15 r15)
      (jump L.fun/fixnum8394.4))))
(check-by-interp
 '(module
    (define L.fun/error8401.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 1854) (jump r15)))
    (define L.fun/void8402.5
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.7
          (begin (set! rdi 22) (set! r15 L.rp.7) (jump L.fun/void8402.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rdi r15)
      (set! r15 fv0)
      (jump L.fun/error8401.4))))
(check-by-interp
 '(module
    (define L.cons.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (begin
      (set! fv0 r15)
      (set! fv1 18222)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.6
          (begin
            (set! rsi 2272)
            (set! rdi 832)
            (set! r15 L.rp.6)
            (jump L.cons.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.cons.6
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/pair8407.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! rsi 3872)
        (set! rdi 400)
        (set! r15 r15)
        (jump L.cons.6)))
    (begin
      (set! r15 r15)
      (if (begin (set! r14 14) (!= r14 6)) (set! r14 17454) (set! r14 17966))
      (set! rdi r14)
      (set! r15 r15)
      (jump L.fun/pair8407.4))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (set! r14 1712)
      (set! r14 14)
      (set! rax 1864)
      (jump r15))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (set! r14 13118)
      (set! r14 14)
      (set! rax r14)
      (jump r15))))
(check-by-interp
 '(module
    (define L.cons.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/error8419.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 47678)
        (jump r15)))
    (define L.fun/boolean8418.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 6)
        (jump r15)))
    (define L.fun/error8420.6
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 39998)
        (jump r15)))
    (begin
      (set! fv0 r15)
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 8))
                (return-point L.rp.9
                  (begin
                    (set! rsi 456)
                    (set! rdi 14)
                    (set! r15 L.rp.9)
                    (jump L.fun/boolean8418.5)))
                (set! rbp (+ rbp 8)))
              (set! r15 rax))
            (!= r15 6))
        (begin
          (set! rsi 22)
          (set! rdi 14)
          (set! r15 fv0)
          (jump L.fun/error8419.4))
        (begin
          (begin
            (set! rbp (- rbp 8))
            (return-point L.rp.10
              (begin
                (set! rsi 3240)
                (set! rdi 208)
                (set! r15 L.rp.10)
                (jump L.cons.8)))
            (set! rbp (+ rbp 8)))
          (set! r15 rax)
          (set! rsi r15)
          (set! rdi 22)
          (set! r15 fv0)
          (jump L.fun/error8420.6))))))
(check-by-interp
 '(module
    (define L.+.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.cons.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/ascii-char8439.4
      (begin (set! r15 r15) (set! rax 22318) (jump r15)))
    (define L.fun/error8440.5
      (begin (set! r15 r15) (set! rax 4670) (jump r15)))
    (define L.fun/pair8441.6
      (begin
        (set! r15 r15)
        (set! rsi 2392)
        (set! rdi 704)
        (set! r15 r15)
        (jump L.cons.8)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char8439.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/error8440.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/pair8441.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rsi 1064)
      (set! rdi 2024)
      (set! r15 fv0)
      (jump L.+.9))))
(check-by-interp
 '(module
    (define L.empty?.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 255))
                (set! r14 r14))
              (= r14 22))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.cons.7
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/pair8459.4
      (begin
        (set! r15 r15)
        (set! rsi 2824)
        (set! rdi 704)
        (set! r15 r15)
        (jump L.cons.7)))
    (define L.fun/pair8458.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r15 r15)
        (jump L.fun/pair8459.4)))
    (begin
      (set! fv0 r15)
      (if (begin (set! r15 6) (!= r15 6)) (set! r15 54078) (set! r15 38718))
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.9
          (begin (set! rdi r15) (set! r15 L.rp.9) (jump L.empty?.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (if (begin (set! r14 6) (!= r14 6)) (set! r14 30) (set! r14 30))
      (set! rsi r14)
      (set! rdi r15)
      (set! r15 fv0)
      (jump L.fun/pair8458.5))))
(check-by-interp
 '(module
    (define L.pair?.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 7))
                (set! r14 r14))
              (= r14 1))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.fun/ascii-char8463.4
      (begin (set! r15 r15) (set! rax 22574) (jump r15)))
    (define L.fun/ascii-char8462.5
      (begin (set! r15 r15) (set! rax 10286) (jump r15)))
    (define L.fun/error8464.6
      (begin (set! r15 r15) (set! rax 5694) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.9
          (begin (set! r15 L.rp.9) (jump L.fun/ascii-char8462.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char8463.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! rdi 14) (set! r15 L.rp.11) (jump L.pair?.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error8464.6))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin (set! r14 6) (set! r13 1448) (set! r13 6) (!= r14 6))
        (begin
          (set! r14 1104)
          (set! r13 14)
          (set! r13 64318)
          (set! rax r14)
          (jump r15))
        (if (begin (set! r14 14) (!= r14 6))
          (begin (set! rax 416) (jump r15))
          (begin (set! rax 664) (jump r15)))))))
(check-by-interp
 '(module
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/void8484.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty8485.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/pair8483.6
      (begin
        (set! r15 r15)
        (set! rsi 2640)
        (set! rdi 712)
        (set! r15 r15)
        (jump L.cons.9)))
    (define L.fun/empty8482.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/empty8482.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/pair8483.6)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void8484.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty8485.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.+.12
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.-.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.*.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/error8501.4
      (begin (set! r15 r15) (set! rax 1342) (jump r15)))
    (define L.fun/pair8499.5
      (begin
        (set! r15 r15)
        (set! rsi 2072)
        (set! rdi 592)
        (set! r15 r15)
        (jump L.cons.9)))
    (define L.fun/void8500.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void8498.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin
            (set! rsi 1784)
            (set! rdi 1400)
            (set! r15 L.rp.13)
            (jump L.*.10)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin
            (set! rsi 2024)
            (set! rdi 1776)
            (set! r15 L.rp.14)
            (jump L.-.11)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.15
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.15)
            (jump L.+.12)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void8498.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/pair8499.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void8500.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error8501.4))))
(check-by-interp
 '(module
    (define L.pair?.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 7))
                (set! r14 r14))
              (= r14 1))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/ascii-char8512.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 18734)
        (jump r15)))
    (define L.fun/ascii-char8510.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r13 rdx)
        (set! rax r14)
        (jump r15)))
    (define L.fun/ascii-char8511.6
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 12334)
        (jump r15)))
    (define L.fun/boolean8513.7
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 6)
        (jump r15)))
    (begin
      (set! fv0 r15)
      (if (begin
            (set! r15 30510)
            (set! r15 30)
            (set! r15 22)
            (set! r15 28222)
            (begin (set! r15 14) (!= r15 6)))
        (begin
          (begin
            (set! rbp (- rbp 24))
            (return-point L.rp.11
              (begin
                (set! rdx 12078)
                (set! rsi 23870)
                (set! rdi 28974)
                (set! r15 L.rp.11)
                (jump L.fun/ascii-char8511.6)))
            (set! rbp (+ rbp 24)))
          (set! fv1 rax))
        (begin
          (begin
            (set! rbp (- rbp 24))
            (return-point L.rp.12
              (begin
                (set! rdx 11838)
                (set! rsi 13102)
                (set! rdi 25134)
                (set! r15 L.rp.12)
                (jump L.fun/ascii-char8512.4)))
            (set! rbp (+ rbp 24)))
          (set! fv1 rax)))
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 24))
                (return-point L.rp.13
                  (begin
                    (set! rsi 3600)
                    (set! rdi 688)
                    (set! r15 L.rp.13)
                    (jump L.cons.9)))
                (set! rbp (+ rbp 24)))
              (set! r15 rax)
              (begin
                (set! rbp (- rbp 24))
                (return-point L.rp.14
                  (begin (set! rdi r15) (set! r15 L.rp.14) (jump L.pair?.10)))
                (set! rbp (+ rbp 24)))
              (set! r15 rax))
            (!= r15 6))
        (if (begin (set! r15 14) (!= r15 6)) (set! fv2 58942) (set! fv2 23102))
        (if (begin (set! r15 6) (!= r15 6)) (set! fv2 54078) (set! fv2 19774)))
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
                    (jump L.fun/boolean8513.7)))
                (set! rbp (+ rbp 24)))
              (set! r15 rax))
            (!= r15 6))
        (if (begin (set! r15 6) (!= r15 6)) (set! r15 18478) (set! r15 19246))
        (if (begin (set! r15 14) (!= r15 6))
          (set! r15 26414)
          (set! r15 18990)))
      (set! rdx r15)
      (set! rsi fv2)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.fun/ascii-char8510.5))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8546.4
      (begin (set! r15 r15) (set! rax 29486) (jump r15)))
    (define L.fun/empty8547.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error8544.6
      (begin (set! r15 r15) (set! rax 17982) (jump r15)))
    (define L.fun/ascii-char8545.7
      (begin (set! r15 r15) (set! rax 12334) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.9
          (begin (set! r15 L.rp.9) (jump L.fun/error8544.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char8545.7)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char8546.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty8547.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.void?.11
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 255))
                (set! r14 r14))
              (= r14 30))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.cons.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/any8685.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/pair8681.5
      (begin
        (set! r15 r15)
        (set! rsi 3104)
        (set! rdi 856)
        (set! r15 r15)
        (jump L.cons.10)))
    (define L.fun/error8683.6
      (begin (set! r15 r15) (set! rax 21310) (jump r15)))
    (define L.fun/pair8684.7
      (begin
        (set! r15 r15)
        (set! rsi 2576)
        (set! rdi 936)
        (set! r15 r15)
        (jump L.cons.10)))
    (define L.fun/error8682.8
      (begin (set! r15 r15) (set! rax 51774) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/pair8681.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/error8682.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error8683.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/pair8684.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/any8685.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rdi r15)
      (set! r15 fv0)
      (jump L.void?.11))))
(check-by-interp
 '(module
    (define L.+.12
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.-.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.*.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/empty8893.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty8894.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/pair8895.6
      (begin
        (set! r15 r15)
        (set! rsi 2344)
        (set! rdi 1160)
        (set! r15 r15)
        (jump L.cons.9)))
    (define L.fun/void8896.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty8893.4)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/empty8894.5)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin
            (set! rsi 200)
            (set! rdi 1632)
            (set! r15 L.rp.15)
            (jump L.*.10)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi 904)
            (set! rdi 320)
            (set! r15 L.rp.16)
            (jump L.*.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.17)
            (jump L.*.10)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi 320)
            (set! rdi 712)
            (set! r15 L.rp.18)
            (jump L.-.11)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi 928)
            (set! rdi 896)
            (set! r15 L.rp.19)
            (jump L.+.12)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.-.11)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.21)
            (jump L.-.11)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/pair8895.6)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void8896.7)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.*.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.-.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.+.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/empty8907.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error8906.5
      (begin (set! r15 r15) (set! rax 18238) (jump r15)))
    (define L.fun/pair8908.6
      (begin
        (set! r15 r15)
        (set! rsi 3040)
        (set! rdi 1360)
        (set! r15 r15)
        (jump L.cons.9)))
    (define L.fun/void8909.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.13
          (begin
            (set! rsi 1560)
            (set! rdi 864)
            (set! r15 L.rp.13)
            (jump L.+.10)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.14
          (begin
            (set! rsi 1832)
            (set! rdi 1632)
            (set! r15 L.rp.14)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.15
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.15)
            (jump L.*.12)))
        (set! rbp (+ rbp 56)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.16
          (begin
            (set! rsi 408)
            (set! rdi 408)
            (set! r15 L.rp.16)
            (jump L.+.10)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.17
          (begin
            (set! rsi 88)
            (set! rdi 1168)
            (set! r15 L.rp.17)
            (jump L.+.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.*.12)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.19)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error8906.5)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.21
          (begin
            (set! rsi 512)
            (set! rdi 1752)
            (set! r15 L.rp.21)
            (jump L.+.10)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.22
          (begin
            (set! rsi 1392)
            (set! rdi 1728)
            (set! r15 L.rp.22)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.*.12)))
        (set! rbp (+ rbp 56)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.24
          (begin
            (set! rsi 560)
            (set! rdi 136)
            (set! r15 L.rp.24)
            (jump L.*.12)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.25
          (begin
            (set! rsi 984)
            (set! rdi 176)
            (set! r15 L.rp.25)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.26)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.27)
            (jump L.+.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.28
          (begin (set! r15 L.rp.28) (jump L.fun/empty8907.4)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.29
          (begin (set! r15 L.rp.29) (jump L.fun/pair8908.6)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/void8909.7))))
(check-by-interp
 '(module
    (define L.*.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.-.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.+.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/pair9174.4
      (begin
        (set! r15 r15)
        (set! rsi 3672)
        (set! rdi 1016)
        (set! r15 r15)
        (jump L.cons.9)))
    (define L.fun/ascii-char9175.5
      (begin (set! r15 r15) (set! rax 23598) (jump r15)))
    (define L.fun/empty9176.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error9177.7
      (begin (set! r15 r15) (set! rax 17470) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/pair9174.4)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char9175.5)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty9176.6)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/error9177.7)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi 256)
            (set! rdi 1312)
            (set! r15 L.rp.17)
            (jump L.+.10)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi 320)
            (set! rdi 1592)
            (set! r15 L.rp.18)
            (jump L.-.11)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.19)
            (jump L.+.10)))
        (set! rbp (+ rbp 40)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin
            (set! rsi 456)
            (set! rdi 1512)
            (set! r15 L.rp.20)
            (jump L.*.12)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin
            (set! rsi 1776)
            (set! rdi 280)
            (set! r15 L.rp.21)
            (jump L.+.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.22)
            (jump L.-.11)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.23)
            (jump L.*.12)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.*.11
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.-.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.+.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.fun/error9704.4
      (begin (set! r15 r15) (set! rax 56382) (jump r15)))
    (define L.fun/void9703.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void9702.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty9705.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.12
          (begin
            (set! rsi 992)
            (set! rdi 904)
            (set! r15 L.rp.12)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin
            (set! rsi 1512)
            (set! rdi 1656)
            (set! r15 L.rp.13)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin
            (set! rsi 1624)
            (set! rdi 1080)
            (set! r15 L.rp.15)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi 240)
            (set! rdi 296)
            (set! r15 L.rp.16)
            (jump L.*.11)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.17)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.18)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void9702.6)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void9703.5)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error9704.4)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty9705.7)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.*.11
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.+.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.-.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.cons.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/pair9710.4
      (begin
        (set! r15 r15)
        (set! rsi 2640)
        (set! rdi 792)
        (set! r15 r15)
        (jump L.cons.8)))
    (define L.fun/error9708.5
      (begin (set! r15 r15) (set! rax 54846) (jump r15)))
    (define L.fun/void9709.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error9708.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void9709.6)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.14
          (begin
            (set! rsi 152)
            (set! rdi 2000)
            (set! r15 L.rp.14)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.15
          (begin
            (set! rsi 416)
            (set! rdi 784)
            (set! r15 L.rp.15)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.16
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.16)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.17
          (begin
            (set! rsi 240)
            (set! rdi 1824)
            (set! r15 L.rp.17)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi 312)
            (set! rdi 320)
            (set! r15 L.rp.18)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.19)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.20)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 992)
            (set! rdi 216)
            (set! r15 L.rp.21)
            (jump L.*.11)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 568)
            (set! rdi 168)
            (set! r15 L.rp.22)
            (jump L.*.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.23)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 1352)
            (set! rdi 1248)
            (set! r15 L.rp.24)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1632)
            (set! rdi 168)
            (set! r15 L.rp.25)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.26)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.27)
            (jump L.*.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin (set! r15 L.rp.28) (jump L.fun/pair9710.4)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.*.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.-.12
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.+.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.cons.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/void9976.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/pair9973.5
      (begin
        (set! r15 r15)
        (set! rsi 3448)
        (set! rdi 1352)
        (set! r15 r15)
        (jump L.cons.10)))
    (define L.fun/empty9975.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void9974.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char9977.8
      (begin (set! r15 r15) (set! rax 20782) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/pair9973.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/void9974.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/empty9975.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void9976.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 1288)
            (set! rdi 1608)
            (set! r15 L.rp.18)
            (jump L.+.11)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1528)
            (set! rdi 1992)
            (set! r15 L.rp.19)
            (jump L.-.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.+.11)))
        (set! rbp (+ rbp 32)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi 1152)
            (set! rdi 688)
            (set! r15 L.rp.21)
            (jump L.-.12)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi 1848)
            (set! rdi 1048)
            (set! r15 L.rp.22)
            (jump L.*.13)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.+.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.24)
            (jump L.-.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char9977.8))))
(check-by-interp
 '(module
    (define L.fun/void15785.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void15786.9)))
    (define L.fun/empty15784.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error15778.6
      (begin (set! r15 r15) (set! rax 4670) (jump r15)))
    (define L.fun/ascii-char15782.7
      (begin (set! r15 r15) (set! rax 29742) (jump r15)))
    (define L.fun/error15777.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error15778.6)))
    (define L.fun/void15786.9 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char15781.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char15782.7)))
    (define L.fun/ascii-char15779.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char15780.14)))
    (define L.fun/empty15775.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty15776.15)))
    (define L.fun/empty15783.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty15784.5)))
    (define L.fun/ascii-char15780.14
      (begin (set! r15 r15) (set! rax 21038) (jump r15)))
    (define L.fun/empty15776.15
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/empty15775.12)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error15777.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char15779.11)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char15781.10)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty15783.13)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/void15785.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.void?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 255))
                (set! r14 r14))
              (= r14 30))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.boolean?.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 247))
                (set! r14 r14))
              (= r14 6))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.fun/any18974.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void18977.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void18978.12)))
    (define L.fun/ascii-char18970.6
      (begin (set! r15 r15) (set! rax 23854) (jump r15)))
    (define L.fun/ascii-char18969.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char18970.6)))
    (define L.fun/error18976.8
      (begin (set! r15 r15) (set! rax 39742) (jump r15)))
    (define L.fun/void18971.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void18972.10)))
    (define L.fun/void18972.10 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error18975.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error18976.8)))
    (define L.fun/void18978.12 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any18973.13
      (begin (set! r15 r15) (set! rax 60990) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char18969.7)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void18971.9)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/any18973.13)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! rdi r15) (set! r15 L.rp.20) (jump L.boolean?.15)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/any18974.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! rdi r15) (set! r15 L.rp.22) (jump L.void?.16)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error18975.11)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/void18977.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.cons.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/error19375.4
      (begin (set! r15 r15) (set! rax 5438) (jump r15)))
    (define L.fun/empty19379.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error19373.6
      (begin (set! r15 r15) (set! rax 1086) (jump r15)))
    (define L.fun/pair19383.7
      (begin
        (set! r15 r15)
        (set! rsi 3048)
        (set! rdi 1696)
        (set! r15 r15)
        (jump L.cons.17)))
    (define L.fun/ascii-char19377.8
      (begin (set! r15 r15) (set! rax 28718) (jump r15)))
    (define L.fun/pair19382.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/pair19383.7)))
    (define L.fun/ascii-char19376.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char19377.8)))
    (define L.fun/empty19378.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty19379.5)))
    (define L.fun/empty19381.12
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty19380.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty19381.12)))
    (define L.fun/error19372.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error19373.6)))
    (define L.fun/error19374.15
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error19375.4)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error19372.14)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error19374.15)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char19376.10)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty19378.11)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty19380.13)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/pair19382.9)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.boolean?.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 247))
                (set! r14 r14))
              (= r14 6))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.-.14
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.*.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.+.12
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.fun/void20855.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char20850.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char20851.8)))
    (define L.fun/void20854.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void20855.4)))
    (define L.fun/any20856.7 (begin (set! r15 r15) (set! rax 14) (jump r15)))
    (define L.fun/ascii-char20851.8
      (begin (set! r15 r15) (set! rax 29742) (jump r15)))
    (define L.fun/ascii-char20853.9
      (begin (set! r15 r15) (set! rax 24366) (jump r15)))
    (define L.fun/ascii-char20852.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char20853.9)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/ascii-char20850.5)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.17
          (begin
            (set! rsi 456)
            (set! rdi 1200)
            (set! r15 L.rp.17)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.18
          (begin
            (set! rsi 616)
            (set! rdi 336)
            (set! r15 L.rp.18)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.19)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.20
          (begin
            (set! rsi 480)
            (set! rdi 352)
            (set! r15 L.rp.20)
            (jump L.*.13)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.21
          (begin
            (set! rsi 1240)
            (set! rdi 456)
            (set! r15 L.rp.21)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.22)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.24
          (begin
            (set! rsi 640)
            (set! rdi 1264)
            (set! r15 L.rp.24)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.25
          (begin
            (set! rsi 400)
            (set! rdi 504)
            (set! r15 L.rp.25)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.26)
            (jump L.*.13)))
        (set! rbp (+ rbp 176)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.27
          (begin
            (set! rsi 664)
            (set! rdi 1024)
            (set! r15 L.rp.27)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.28
          (begin
            (set! rsi 936)
            (set! rdi 112)
            (set! r15 L.rp.28)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.29)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.30)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/ascii-char20852.10)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.33
          (begin
            (set! rsi 672)
            (set! rdi 376)
            (set! r15 L.rp.33)
            (jump L.*.13)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.34
          (begin
            (set! rsi 352)
            (set! rdi 1128)
            (set! r15 L.rp.34)
            (jump L.*.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.35)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.36
          (begin
            (set! rsi 1896)
            (set! rdi 1360)
            (set! r15 L.rp.36)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.37
          (begin
            (set! rsi 1680)
            (set! rdi 1848)
            (set! r15 L.rp.37)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.38)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.39)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.40
          (begin
            (set! rsi 440)
            (set! rdi 248)
            (set! r15 L.rp.40)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.41
          (begin
            (set! rsi 1952)
            (set! rdi 960)
            (set! r15 L.rp.41)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.42
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.42)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.43
          (begin
            (set! rsi 248)
            (set! rdi 504)
            (set! r15 L.rp.43)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.44
          (begin
            (set! rsi 1768)
            (set! rdi 696)
            (set! r15 L.rp.44)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.45
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.45)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.46)
            (jump L.*.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.47)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/void20854.6)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.49
          (begin
            (set! rsi 1552)
            (set! rdi 424)
            (set! r15 L.rp.49)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.50
          (begin
            (set! rsi 144)
            (set! rdi 1264)
            (set! r15 L.rp.50)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.51
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.51)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.52
          (begin
            (set! rsi 1256)
            (set! rdi 640)
            (set! r15 L.rp.52)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.53
          (begin
            (set! rsi 1904)
            (set! rdi 712)
            (set! r15 L.rp.53)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.54
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.54)
            (jump L.*.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.55
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.55)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.56
          (begin
            (set! rsi 1304)
            (set! rdi 1080)
            (set! r15 L.rp.56)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.57
          (begin
            (set! rsi 1928)
            (set! rdi 1000)
            (set! r15 L.rp.57)
            (jump L.*.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.58
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.58)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.59
          (begin
            (set! rsi 416)
            (set! rdi 1720)
            (set! r15 L.rp.59)
            (jump L.*.13)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.60
          (begin
            (set! rsi 1112)
            (set! rdi 1344)
            (set! r15 L.rp.60)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.61
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.61)
            (jump L.-.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.62
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.62)
            (jump L.+.12)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.63
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.63)
            (jump L.*.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.64
          (begin (set! r15 L.rp.64) (jump L.fun/any20856.7)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (set! rdi r15)
      (set! r15 fv0)
      (jump L.boolean?.15))))
(check-by-interp
 '(module
    (define L.-.18
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.*.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.+.16
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.cons.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/ascii-char22195.4
      (begin (set! r15 r15) (set! rax 31278) (jump r15)))
    (define L.fun/empty22197.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/pair22193.6
      (begin
        (set! r15 r15)
        (set! rsi 2320)
        (set! rdi 640)
        (set! r15 r15)
        (jump L.cons.15)))
    (define L.fun/pair22192.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/pair22193.6)))
    (define L.fun/empty22199.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty22198.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty22199.8)))
    (define L.fun/empty22196.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty22197.5)))
    (define L.fun/error22191.11
      (begin (set! r15 r15) (set! rax 19262) (jump r15)))
    (define L.fun/error22190.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error22191.11)))
    (define L.fun/ascii-char22194.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char22195.4)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error22190.12)))
        (set! rbp (+ rbp 72)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/pair22192.7)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char22194.13)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty22196.10)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty22198.9)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi 1408)
            (set! rdi 1072)
            (set! r15 L.rp.24)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 784)
            (set! rdi 1232)
            (set! r15 L.rp.25)
            (jump L.*.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.26)
            (jump L.-.18)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi 1688)
            (set! rdi 1496)
            (set! r15 L.rp.27)
            (jump L.*.17)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 824)
            (set! rdi 832)
            (set! r15 L.rp.28)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.29)
            (jump L.-.18)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.30)
            (jump L.*.17)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi 880)
            (set! rdi 392)
            (set! r15 L.rp.31)
            (jump L.*.17)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 192)
            (set! rdi 312)
            (set! r15 L.rp.32)
            (jump L.*.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.33)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi 576)
            (set! rdi 1728)
            (set! r15 L.rp.34)
            (jump L.*.17)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi 848)
            (set! rdi 160)
            (set! r15 L.rp.35)
            (jump L.-.18)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.*.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.37)
            (jump L.-.18)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.38)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax fv4)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.*.20
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.+.19
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.-.18
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.vector?.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 7))
                (set! r14 r14))
              (= r14 3))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.cons.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/pair23550.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/pair23551.8)))
    (define L.fun/void23549.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void23541.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void23542.14)))
    (define L.fun/void23548.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void23549.5)))
    (define L.fun/pair23551.8
      (begin
        (set! r15 r15)
        (set! rsi 3872)
        (set! rdi 664)
        (set! r15 r15)
        (jump L.cons.16)))
    (define L.fun/error23546.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error23547.11)))
    (define L.fun/empty23544.10
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error23547.11
      (begin (set! r15 r15) (set! rax 53822) (jump r15)))
    (define L.fun/any23545.12 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/empty23543.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty23544.10)))
    (define L.fun/void23542.14 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void23541.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty23543.13)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/any23545.12)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin (set! rdi r15) (set! r15 L.rp.24) (jump L.vector?.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 368)
            (set! rdi 1448)
            (set! r15 L.rp.25)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 1528)
            (set! rdi 672)
            (set! r15 L.rp.26)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 464)
            (set! rdi 1808)
            (set! r15 L.rp.28)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 520)
            (set! rdi 104)
            (set! r15 L.rp.29)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.30)
            (jump L.*.20)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.31)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 104)
            (set! rdi 1264)
            (set! r15 L.rp.32)
            (jump L.*.20)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 448)
            (set! rdi 448)
            (set! r15 L.rp.33)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.34)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 320)
            (set! rdi 1664)
            (set! r15 L.rp.35)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi 112)
            (set! rdi 1296)
            (set! r15 L.rp.36)
            (jump L.*.20)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.37)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.38)
            (jump L.*.20)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.39)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin (set! r15 L.rp.40) (jump L.fun/error23546.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.41
          (begin (set! r15 L.rp.41) (jump L.fun/void23548.7)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/pair23550.4))))
(check-by-interp
 '(module
    (define L.fun/error24539.4
      (begin (set! r15 r15) (set! rax 15934) (jump r15)))
    (define L.fun/ascii-char24535.5
      (begin (set! r15 r15) (set! rax 18734) (jump r15)))
    (define L.fun/ascii-char24529.6
      (begin (set! r15 r15) (set! rax 24622) (jump r15)))
    (define L.fun/empty24537.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char24534.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char24535.5)))
    (define L.fun/error24531.9
      (begin (set! r15 r15) (set! rax 2622) (jump r15)))
    (define L.fun/error24538.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error24539.4)))
    (define L.fun/empty24536.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty24537.7)))
    (define L.fun/void24532.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void24533.14)))
    (define L.fun/error24530.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error24531.9)))
    (define L.fun/void24533.14 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char24528.15
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char24529.6)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char24528.15)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error24530.13)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void24532.12)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char24534.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty24536.11)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error24538.10)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.*.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.+.13
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.fun/empty24788.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error24789.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error24790.10)))
    (define L.fun/error24786.6
      (begin (set! r15 r15) (set! rax 34622) (jump r15)))
    (define L.fun/error24785.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error24786.6)))
    (define L.fun/empty24792.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty24787.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty24788.4)))
    (define L.fun/error24790.10
      (begin (set! r15 r15) (set! rax 11070) (jump r15)))
    (define L.fun/empty24791.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty24792.8)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/error24785.7)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.17
          (begin
            (set! rsi 1112)
            (set! rdi 1392)
            (set! r15 L.rp.17)
            (jump L.+.13)))
        (set! rbp (+ rbp 152)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.18
          (begin
            (set! rsi 1584)
            (set! rdi 1104)
            (set! r15 L.rp.18)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.19)
            (jump L.+.13)))
        (set! rbp (+ rbp 152)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.20
          (begin
            (set! rsi 1024)
            (set! rdi 88)
            (set! r15 L.rp.20)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.21
          (begin
            (set! rsi 32)
            (set! rdi 680)
            (set! r15 L.rp.21)
            (jump L.+.13)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.22)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.24
          (begin
            (set! rsi 1672)
            (set! rdi 1648)
            (set! r15 L.rp.24)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.25
          (begin
            (set! rsi 1616)
            (set! rdi 2016)
            (set! r15 L.rp.25)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.26)
            (jump L.+.13)))
        (set! rbp (+ rbp 152)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.27
          (begin
            (set! rsi 1512)
            (set! rdi 1040)
            (set! r15 L.rp.27)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.28
          (begin
            (set! rsi 1256)
            (set! rdi 2024)
            (set! r15 L.rp.28)
            (jump L.+.13)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.29)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.30)
            (jump L.+.13)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/empty24787.9)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/error24789.5)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.34
          (begin
            (set! rsi 608)
            (set! rdi 640)
            (set! r15 L.rp.34)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.35
          (begin
            (set! rsi 1840)
            (set! rdi 88)
            (set! r15 L.rp.35)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.37
          (begin
            (set! rsi 2008)
            (set! rdi 1992)
            (set! r15 L.rp.37)
            (jump L.+.13)))
        (set! rbp (+ rbp 152)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.38
          (begin
            (set! rsi 1960)
            (set! rdi 632)
            (set! r15 L.rp.38)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.39)
            (jump L.+.13)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.40)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.41
          (begin
            (set! rsi 1392)
            (set! rdi 744)
            (set! r15 L.rp.41)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.42
          (begin
            (set! rsi 440)
            (set! rdi 808)
            (set! r15 L.rp.42)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.43)
            (jump L.+.13)))
        (set! rbp (+ rbp 152)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.44
          (begin
            (set! rsi 920)
            (set! rdi 1368)
            (set! r15 L.rp.44)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.45
          (begin
            (set! rsi 920)
            (set! rdi 912)
            (set! r15 L.rp.45)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.46)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.47)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.48
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.48)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/empty24791.11)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.50
          (begin
            (set! rsi fv3)
            (set! rdi 56)
            (set! r15 L.rp.50)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.51
          (begin
            (set! rsi fv3)
            (set! rdi r15)
            (set! r15 L.rp.51)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.52
          (begin
            (set! rsi fv1)
            (set! rdi 144)
            (set! r15 L.rp.52)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.53
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.53)
            (jump L.*.14)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.54
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.54)
            (jump L.+.13)))
        (set! rbp (+ rbp 152)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 152))
        (return-point L.rp.55
          (begin
            (set! rsi fv1)
            (set! rdi fv3)
            (set! r15 L.rp.55)
            (jump L.-.15)))
        (set! rbp (+ rbp 152)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv2)
      (set! r15 fv0)
      (jump L.+.13))))
(check-by-interp
 '(module
    (define L.error?.19
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 255))
                (set! r14 r14))
              (= r14 62))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.cons.18
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/pair24832.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/pair24833.15)))
    (define L.fun/error24829.5
      (begin (set! r15 r15) (set! rax 2110) (jump r15)))
    (define L.fun/pair24835.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/pair24836.7)))
    (define L.fun/pair24836.7
      (begin
        (set! r15 r15)
        (set! rsi 4056)
        (set! rdi 1040)
        (set! r15 r15)
        (jump L.cons.18)))
    (define L.fun/any24834.8
      (begin (set! r15 r15) (set! rax 40766) (jump r15)))
    (define L.fun/ascii-char24839.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char24840.12)))
    (define L.fun/void24831.10 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void24830.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void24831.10)))
    (define L.fun/ascii-char24840.12
      (begin (set! r15 r15) (set! rax 26414) (jump r15)))
    (define L.fun/empty24838.13
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty24837.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty24838.13)))
    (define L.fun/pair24833.15
      (begin
        (set! r15 r15)
        (set! rsi 3544)
        (set! rdi 1856)
        (set! r15 r15)
        (jump L.cons.18)))
    (define L.fun/error24828.16
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error24829.5)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error24828.16)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void24830.11)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/pair24832.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/any24834.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.24
          (begin (set! rdi r15) (set! r15 L.rp.24) (jump L.error?.19)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/pair24835.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/empty24837.14)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char24839.9))))
(check-by-interp
 '(module
    (define L.+.16
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.*.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.cons.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/empty27006.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty27007.9)))
    (define L.fun/pair27009.5
      (begin
        (set! r15 r15)
        (set! rsi 2952)
        (set! rdi 1768)
        (set! r15 r15)
        (jump L.cons.13)))
    (define L.fun/void27004.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void27005.11)))
    (define L.fun/ascii-char27003.7
      (begin (set! r15 r15) (set! rax 29998) (jump r15)))
    (define L.fun/pair27008.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/pair27009.5)))
    (define L.fun/empty27007.9 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char27002.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char27003.7)))
    (define L.fun/void27005.11 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.17
          (begin
            (set! rsi 1480)
            (set! rdi 264)
            (set! r15 L.rp.17)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.18
          (begin
            (set! rsi 408)
            (set! rdi 1256)
            (set! r15 L.rp.18)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.19)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.20
          (begin
            (set! rsi 1408)
            (set! rdi 384)
            (set! r15 L.rp.20)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.21
          (begin
            (set! rsi 1384)
            (set! rdi 2016)
            (set! r15 L.rp.21)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.22)
            (jump L.+.16)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.23)
            (jump L.+.16)))
        (set! rbp (+ rbp 176)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.24
          (begin
            (set! rsi 1384)
            (set! rdi 168)
            (set! r15 L.rp.24)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.25
          (begin
            (set! rsi 808)
            (set! rdi 872)
            (set! r15 L.rp.25)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.26)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.27
          (begin
            (set! rsi 608)
            (set! rdi 560)
            (set! r15 L.rp.27)
            (jump L.+.16)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.28
          (begin
            (set! rsi 872)
            (set! rdi 520)
            (set! r15 L.rp.28)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.29)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.30)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.31)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.32
          (begin
            (set! rsi 488)
            (set! rdi 776)
            (set! r15 L.rp.32)
            (jump L.+.16)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.33
          (begin
            (set! rsi 1368)
            (set! rdi 704)
            (set! r15 L.rp.33)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.34)
            (jump L.+.16)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.35
          (begin
            (set! rsi 1592)
            (set! rdi 1880)
            (set! r15 L.rp.35)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.36
          (begin
            (set! rsi 1824)
            (set! rdi 1080)
            (set! r15 L.rp.36)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.37)
            (jump L.+.16)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.38)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.39
          (begin
            (set! rsi 1800)
            (set! rdi 1312)
            (set! r15 L.rp.39)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.40
          (begin
            (set! rsi 1856)
            (set! rdi 792)
            (set! r15 L.rp.40)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.41
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.41)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.42
          (begin
            (set! rsi 408)
            (set! rdi 608)
            (set! r15 L.rp.42)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.43
          (begin
            (set! rsi 904)
            (set! rdi 16)
            (set! r15 L.rp.43)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.44
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.44)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.45
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.45)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.46)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.47
          (begin (set! r15 L.rp.47) (jump L.fun/ascii-char27002.10)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/void27004.6)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/empty27006.4)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.50
          (begin
            (set! rsi 48)
            (set! rdi 704)
            (set! r15 L.rp.50)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.51
          (begin
            (set! rsi 1168)
            (set! rdi 1448)
            (set! r15 L.rp.51)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.52
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.52)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.53
          (begin
            (set! rsi 784)
            (set! rdi 1016)
            (set! r15 L.rp.53)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.54
          (begin
            (set! rsi 2016)
            (set! rdi 240)
            (set! r15 L.rp.54)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.55
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.55)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.56
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.56)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.57
          (begin
            (set! rsi 1968)
            (set! rdi 496)
            (set! r15 L.rp.57)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.58
          (begin
            (set! rsi 1688)
            (set! rdi 1672)
            (set! r15 L.rp.58)
            (jump L.+.16)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.59
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.59)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.60
          (begin
            (set! rsi 992)
            (set! rdi 880)
            (set! r15 L.rp.60)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.61
          (begin
            (set! rsi 1000)
            (set! rdi 1176)
            (set! r15 L.rp.61)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.62
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.62)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.63
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.63)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.64
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.64)
            (jump L.+.16)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/pair27008.8))))
(check-by-interp
 '(module
    (define L.*.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r13)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r14)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (arithmetic-shift-right r13 3))
              (set! r13 r13)
              (set! r14 r14)
              (set! r14 (* r14 r13))
              (set! rax r14)
              (jump r15))
            (begin (set! rax 318) (jump r15)))
          (begin (set! rax 318) (jump r15)))))
    (define L.+.16
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (+ r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 574) (jump r15)))
          (begin (set! rax 574) (jump r15)))))
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (if (begin
              (if (begin
                    (begin
                      (set! r9 r14)
                      (set! r9 (bitwise-and r9 7))
                      (set! r9 r9))
                    (= r9 0))
                (set! r9 14)
                (set! r9 6))
              (!= r9 6))
          (if (begin
                (if (begin
                      (begin
                        (set! r9 r13)
                        (set! r9 (bitwise-and r9 7))
                        (set! r9 r9))
                      (= r9 0))
                  (set! r9 14)
                  (set! r9 6))
                (!= r9 6))
            (begin
              (set! r13 r13)
              (set! r13 (- r13 r14))
              (set! rax r13)
              (jump r15))
            (begin (set! rax 830) (jump r15)))
          (begin (set! rax 830) (jump r15)))))
    (define L.fun/ascii-char27114.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char27115.8)))
    (define L.fun/empty27120.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty27121.11)))
    (define L.fun/error27116.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error27117.7)))
    (define L.fun/error27117.7
      (begin (set! r15 r15) (set! rax 34622) (jump r15)))
    (define L.fun/ascii-char27115.8
      (begin (set! r15 r15) (set! rax 23342) (jump r15)))
    (define L.fun/ascii-char27123.9
      (begin (set! r15 r15) (set! rax 27694) (jump r15)))
    (define L.fun/ascii-char27122.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char27123.9)))
    (define L.fun/empty27121.11
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty27118.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty27119.13)))
    (define L.fun/empty27119.13
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char27114.4)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error27116.6)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty27118.12)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty27120.5)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.22
          (begin
            (set! rsi 584)
            (set! rdi 608)
            (set! r15 L.rp.22)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.23
          (begin
            (set! rsi 1304)
            (set! rdi 1776)
            (set! r15 L.rp.23)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.24)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.25
          (begin
            (set! rsi 1824)
            (set! rdi 1456)
            (set! r15 L.rp.25)
            (jump L.+.16)))
        (set! rbp (+ rbp 96)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.26
          (begin
            (set! rsi 312)
            (set! rdi 1832)
            (set! r15 L.rp.26)
            (jump L.+.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.+.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.+.16)))
        (set! rbp (+ rbp 96)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.29
          (begin
            (set! rsi 8)
            (set! rdi 1536)
            (set! r15 L.rp.29)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.30
          (begin
            (set! rsi 912)
            (set! rdi 648)
            (set! r15 L.rp.30)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.*.17)))
        (set! rbp (+ rbp 96)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.32
          (begin
            (set! rsi 1304)
            (set! rdi 688)
            (set! r15 L.rp.32)
            (jump L.+.16)))
        (set! rbp (+ rbp 96)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.33
          (begin
            (set! rsi 1096)
            (set! rdi 1544)
            (set! r15 L.rp.33)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.34)
            (jump L.+.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.35)
            (jump L.*.17)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.36)
            (jump L.+.16)))
        (set! rbp (+ rbp 96)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char27122.10)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.38
          (begin
            (set! rsi 1928)
            (set! rdi fv3)
            (set! r15 L.rp.38)
            (jump L.*.17)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.39)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.40
          (begin
            (set! rsi fv3)
            (set! rdi 184)
            (set! r15 L.rp.40)
            (jump L.+.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.41
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.41)
            (jump L.+.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.42
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.42)
            (jump L.*.17)))
        (set! rbp (+ rbp 96)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.43
          (begin
            (set! rsi 912)
            (set! rdi 920)
            (set! r15 L.rp.43)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.44
          (begin
            (set! rsi fv3)
            (set! rdi r15)
            (set! r15 L.rp.44)
            (jump L.+.16)))
        (set! rbp (+ rbp 96)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.45
          (begin
            (set! rsi 1752)
            (set! rdi 792)
            (set! r15 L.rp.45)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.46
          (begin
            (set! rsi fv3)
            (set! rdi r15)
            (set! r15 L.rp.46)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.47)
            (jump L.-.15)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv2)
      (set! r15 fv0)
      (jump L.-.15))))
(check-by-interp
 '(module
    (define L.pair?.19
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 7))
                (set! r14 r14))
              (= r14 1))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.cons.18
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (begin (set! r9 r12) (set! r12 (+ r12 16)))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.fun/pair27447.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/pair27448.11)))
    (define L.fun/ascii-char27445.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char27446.13)))
    (define L.fun/ascii-char27438.6
      (begin (set! r15 r15) (set! rax 18222) (jump r15)))
    (define L.fun/error27440.7
      (begin (set! r15 r15) (set! rax 33342) (jump r15)))
    (define L.fun/ascii-char27443.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char27444.14)))
    (define L.fun/void27441.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void27442.12)))
    (define L.fun/error27439.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error27440.7)))
    (define L.fun/pair27448.11
      (begin
        (set! r15 r15)
        (set! rsi 3512)
        (set! rdi 1488)
        (set! r15 r15)
        (jump L.cons.18)))
    (define L.fun/void27442.12 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char27446.13
      (begin (set! r15 r15) (set! rax 29230) (jump r15)))
    (define L.fun/ascii-char27444.14
      (begin (set! r15 r15) (set! rax 25134) (jump r15)))
    (define L.fun/ascii-char27437.15
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char27438.6)))
    (define L.fun/any27436.16
      (begin
        (set! r15 r15)
        (set! rsi 3104)
        (set! rdi 1488)
        (set! r15 r15)
        (jump L.cons.18)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/any27436.16)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! rdi r15) (set! r15 L.rp.21) (jump L.pair?.19)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char27437.15)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error27439.10)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/void27441.9)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/ascii-char27443.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/ascii-char27445.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/pair27447.4))))
