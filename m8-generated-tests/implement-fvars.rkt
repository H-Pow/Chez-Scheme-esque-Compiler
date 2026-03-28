#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         "../implement-fvars.rkt")
(define (fail-if-invalid p)
  (when (not (nested-asm-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "nested-asm-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-nested-asm-lang-fvars-v8 p)
  (interp-nested-asm-lang-v8 (fail-if-invalid (implement-fvars p)))))

(check-by-interp '(module (begin (set! r15 r15) (set! rax 840) (jump r15))))
(check-by-interp '(module (begin (set! r15 r15) (set! rax 26942) (jump r15))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin (set! r14 14) (true))
        (begin (set! rax 17214) (jump r15))
        (begin (set! rax 9790) (jump r15))))))
(check-by-interp
 '(module (begin (set! r15 r15) (set! r14 28478) (set! rax 1128) (jump r15))))
(check-by-interp
 '(module
    (define L.fun/empty8385.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty8385.4))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin (set! r14 14) (true))
        (begin (set! rax 25390) (jump r15))
        (begin (set! rax 25390) (jump r15))))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin (set! r14 14) (true))
        (begin (set! rax 50238) (jump r15))
        (begin (set! rax 14398) (jump r15))))))
(check-by-interp
 '(module
    (define L.-.6
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
    (define L.fun/fixnum8420.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 400) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.7
          (begin (set! rdi 25390) (set! r15 L.rp.7) (jump L.fun/fixnum8420.4)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.8
          (begin
            (set! rsi 2024)
            (set! rdi 168)
            (set! r15 L.rp.8)
            (jump L.-.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.-.6))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin (set! r14 14) (true))
        (begin (set! rax 61502) (jump r15))
        (begin (set! rax 13118) (jump r15))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8428.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 25390) (jump r15)))
    (define L.fun/empty8427.5
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.7
          (begin
            (set! rdi 22)
            (set! r15 L.rp.7)
            (jump L.fun/ascii-char8428.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rdi r15)
      (set! r15 fv0)
      (jump L.fun/empty8427.5))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8442.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 25390)
        (jump r15)))
    (begin
      (set! r15 r15)
      (if (if (begin (set! r14 14) (true))
            (begin (set! r14 14) (true))
            (begin (set! r14 14) (true)))
        (begin
          (set! rsi 22)
          (set! rdi 25390)
          (set! r15 r15)
          (jump L.fun/ascii-char8442.4))
        (begin
          (set! r14 832)
          (set! r14 608)
          (set! r14 30)
          (set! rax 25390)
          (jump r15))))))
(check-by-interp
 '(module
    (define L.*.8
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
    (define L.fun/ascii-char8498.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void8499.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty8500.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.9
          (begin
            (set! rsi 272)
            (set! rdi 1856)
            (set! r15 L.rp.9)
            (jump L.*.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char8498.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/void8499.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/empty8500.6))))
(check-by-interp
 '(module
    (define L.-.7
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
    (define L.fun/empty8553.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error8554.5
      (begin (set! r15 r15) (set! rax 43326) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.8
          (begin (set! r15 L.rp.8) (jump L.fun/empty8553.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.9
          (begin (set! r15 L.rp.9) (jump L.fun/error8554.5)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin
            (set! rsi 144)
            (set! rdi 1768)
            (set! r15 L.rp.10)
            (jump L.-.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.fun/boolean8597.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 6)
        (jump r15)))
    (define L.fun/ascii-char8598.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 25390)
        (jump r15)))
    (begin
      (set! fv0 r15)
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 8))
                (return-point L.rp.7
                  (begin
                    (set! rsi 25390)
                    (set! rdi 22)
                    (set! r15 L.rp.7)
                    (jump L.fun/boolean8597.4)))
                (set! rbp (+ rbp 8)))
              (set! r15 rax))
            (!= r15 6))
        (if (begin (set! r15 6) (false))
          (begin (set! rax 25390) (jump fv0))
          (begin (set! rax 25390) (jump fv0)))
        (begin
          (set! rsi 22)
          (set! rdi 624)
          (set! r15 fv0)
          (jump L.fun/ascii-char8598.5))))))
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
    (define L.fun/fixnum9203.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 1368)
        (jump r15)))
    (define L.fun/fixnum9202.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 568)
        (jump r15)))
    (define L.fun/fixnum9204.6
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax r14)
        (jump r15)))
    (define L.fun/boolean9201.7
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 14)
        (jump r15)))
    (begin
      (set! fv0 r15)
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
                    (jump L.fun/boolean9201.7)))
                (set! rbp (+ rbp 16)))
              (set! r15 rax))
            (!= r15 6))
        (begin
          (begin
            (set! rbp (- rbp 16))
            (return-point L.rp.11
              (begin
                (set! rdx 30)
                (set! rsi 22)
                (set! rdi 30)
                (set! r15 L.rp.11)
                (jump L.fun/fixnum9202.5)))
            (set! rbp (+ rbp 16)))
          (set! fv1 rax))
        (begin
          (begin
            (set! rbp (- rbp 16))
            (return-point L.rp.12
              (begin
                (set! rdx 6)
                (set! rsi 6)
                (set! rdi 22)
                (set! r15 L.rp.12)
                (jump L.fun/fixnum9203.4)))
            (set! rbp (+ rbp 16)))
          (set! fv1 rax)))
      (if (if (begin (set! r15 14) (true))
            (begin (set! r15 6) (false))
            (begin (set! r15 6) (false)))
        (begin
          (set! r15 6)
          (set! r15 59198)
          (set! r15 216)
          (set! r14 30)
          (set! r15 r15))
        (begin
          (begin
            (set! rbp (- rbp 16))
            (return-point L.rp.13
              (begin
                (set! rdx 1776)
                (set! rsi 25390)
                (set! rdi 30)
                (set! r15 L.rp.13)
                (jump L.fun/fixnum9204.6)))
            (set! rbp (+ rbp 16)))
          (set! r15 rax)))
      (set! rsi r15)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.+.9))))
(check-by-interp
 '(module
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
    (define L.*.9
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
    (define L.fun/ascii-char9328.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void9330.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error9331.6
      (begin (set! r15 r15) (set! rax 27198) (jump r15)))
    (define L.fun/ascii-char9329.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin
            (set! rsi 1800)
            (set! rdi 440)
            (set! r15 L.rp.12)
            (jump L.*.9)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin
            (set! rsi 224)
            (set! rdi 416)
            (set! r15 L.rp.13)
            (jump L.+.10)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.-.11)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/ascii-char9328.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/ascii-char9329.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void9330.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error9331.6))))
(check-by-interp
 '(module
    (define L.*.8
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
    (define L.-.7
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
    (define L.fun/ascii-char9350.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error9349.5
      (begin (set! r15 r15) (set! rax 34878) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.9
          (begin
            (set! rsi 1608)
            (set! rdi 1200)
            (set! r15 L.rp.9)
            (jump L.-.7)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.10
          (begin
            (set! rsi 936)
            (set! rdi 760)
            (set! r15 L.rp.10)
            (jump L.-.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.11
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.11)
            (jump L.-.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.12
          (begin
            (set! rsi 856)
            (set! rdi 1024)
            (set! r15 L.rp.12)
            (jump L.*.8)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin
            (set! rsi 776)
            (set! rdi 712)
            (set! r15 L.rp.13)
            (jump L.*.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.-.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/error9349.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 32)
            (set! rdi 1064)
            (set! r15 L.rp.16)
            (jump L.-.7)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 1200)
            (set! rdi 1088)
            (set! r15 L.rp.17)
            (jump L.-.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.*.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char9350.4))))
(check-by-interp
 '(module
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
    (define L.*.9
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
    (define L.+.8
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
    (define L.fun/empty9463.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty9462.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void9461.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/void9461.6)))
        (set! rbp (+ rbp 24)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.12
          (begin
            (set! rsi 1440)
            (set! rdi 1464)
            (set! r15 L.rp.12)
            (jump L.+.8)))
        (set! rbp (+ rbp 24)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.13
          (begin
            (set! rsi 944)
            (set! rdi 1904)
            (set! r15 L.rp.13)
            (jump L.*.9)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.-.10)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty9462.5)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/empty9463.4)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (set! rax fv2)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.-.6
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
    (define L.fun/ascii-char9530.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 25390)
        (jump r15)))
    (begin
      (set! fv0 r15)
      (if (begin
            (set! r15 1064)
            (set! r15 22)
            (set! r15 680)
            (set! r15 28222)
            (begin (set! r15 6) (false)))
        (begin
          (set! r15 30)
          (set! r15 40510)
          (set! r15 30)
          (set! r15 6)
          (set! fv1 1440)
          (begin
            (set! rbp (- rbp 16))
            (return-point L.rp.7
              (begin
                (set! rsi 32)
                (set! rdi 1288)
                (set! r15 L.rp.7)
                (jump L.-.6)))
            (set! rbp (+ rbp 16)))
          (set! r15 rax)
          (if (begin (set! r14 14) (true)) (set! r14 30) (set! r14 30))
          (set! rdx r14)
          (set! rsi r15)
          (set! rdi fv1)
          (set! r15 fv0)
          (jump L.fun/ascii-char9530.4))
        (begin
          (set! r15 25390)
          (set! r15 1560)
          (set! r15 22)
          (set! r15 30)
          (set! rax 25390)
          (jump fv0))))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (if (begin (set! r14 14) (true))
            (begin (set! r14 6) (false))
            (begin (set! r14 14) (true)))
        (if (begin (set! r14 6) (false))
          (begin (set! rax 46654) (jump r15))
          (begin (set! rax 42046) (jump r15)))
        (if (begin (set! r14 14) (true))
          (begin (set! rax 33598) (jump r15))
          (begin (set! rax 58174) (jump r15)))))))
(check-by-interp
 '(module
    (define L.*.9
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
    (define L.-.8
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
    (define L.fun/error9595.4
      (begin (set! r15 r15) (set! rax 9022) (jump r15)))
    (define L.fun/void9594.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty9593.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/empty9593.6)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/void9594.5)))
        (set! rbp (+ rbp 24)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error9595.4)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.13
          (begin
            (set! rsi 1392)
            (set! rdi 1368)
            (set! r15 L.rp.13)
            (jump L.-.8)))
        (set! rbp (+ rbp 24)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.14
          (begin
            (set! rsi 400)
            (set! rdi 1288)
            (set! r15 L.rp.14)
            (jump L.*.9)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.15
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.15)
            (jump L.*.9)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.void?.10
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
    (define L.fun/error9648.4
      (begin (set! r15 r15) (set! rax 2622) (jump r15)))
    (define L.fun/error9646.5
      (begin (set! r15 r15) (set! rax 58430) (jump r15)))
    (define L.fun/any9647.6 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/error9649.7
      (begin (set! r15 r15) (set! rax 28222) (jump r15)))
    (define L.fun/void9650.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/error9646.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/any9647.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! rdi r15) (set! r15 L.rp.13) (jump L.void?.10)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error9648.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/error9649.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/void9650.8))))
(check-by-interp
 '(module
    (define L.ascii-char?.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 255))
                (set! r14 r14))
              (= r14 46))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.fun/error10696.4
      (begin (set! r15 r15) (set! rax 55102) (jump r15)))
    (define L.fun/ascii-char10693.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void10697.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any10694.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void10695.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char10693.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/any10694.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! rdi r15) (set! r15 L.rp.13) (jump L.ascii-char?.10)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void10695.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/error10696.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void10697.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.fun/empty12161.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error12159.5
      (begin (set! r15 r15) (set! rax 1854) (jump r15)))
    (define L.fun/ascii-char12162.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error12163.7
      (begin (set! r15 r15) (set! rax 10814) (jump r15)))
    (define L.fun/error12160.8
      (begin (set! r15 r15) (set! rax 27198) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/error12159.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/error12160.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty12161.4)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/ascii-char12162.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error12163.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
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
    (define L.empty?.9
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
    (define L.fun/void12536.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any12537.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error12539.6
      (begin (set! r15 r15) (set! rax 29502) (jump r15)))
    (define L.fun/error12538.7
      (begin (set! r15 r15) (set! rax 24894) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void12536.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/any12537.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! rdi r15) (set! r15 L.rp.15) (jump L.empty?.9)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 384)
            (set! rdi 784)
            (set! r15 L.rp.16)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 912)
            (set! rdi 104)
            (set! r15 L.rp.17)
            (jump L.+.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.+.11)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1288)
            (set! rdi 1776)
            (set! r15 L.rp.19)
            (jump L.-.12)))
        (set! rbp (+ rbp 32)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi 760)
            (set! rdi 792)
            (set! r15 L.rp.20)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.21)
            (jump L.-.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.22)
            (jump L.-.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error12538.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/error12539.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.pair?.12
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
    (define L.*.9
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
    (define L.fun/any13289.4 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/empty13290.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error13288.6
      (begin (set! r15 r15) (set! rax 48958) (jump r15)))
    (define L.fun/ascii-char13291.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.13
          (begin
            (set! rsi 1576)
            (set! rdi 1360)
            (set! r15 L.rp.13)
            (jump L.*.9)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.14
          (begin
            (set! rsi 296)
            (set! rdi 1888)
            (set! r15 L.rp.14)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.15
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.15)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.16
          (begin
            (set! rsi 1808)
            (set! rdi 1880)
            (set! r15 L.rp.16)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.17
          (begin
            (set! rsi 704)
            (set! rdi 2008)
            (set! r15 L.rp.17)
            (jump L.*.9)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.19)
            (jump L.+.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error13288.6)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.21
          (begin
            (set! rsi 1192)
            (set! rdi 1488)
            (set! r15 L.rp.21)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.22
          (begin
            (set! rsi 1480)
            (set! rdi 1160)
            (set! r15 L.rp.22)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.24
          (begin
            (set! rsi 1240)
            (set! rdi 24)
            (set! r15 L.rp.24)
            (jump L.*.9)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.25
          (begin
            (set! rsi 1752)
            (set! rdi 1808)
            (set! r15 L.rp.25)
            (jump L.+.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.26)
            (jump L.*.9)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.27)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.28
          (begin (set! r15 L.rp.28) (jump L.fun/any13289.4)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.29
          (begin (set! rdi r15) (set! r15 L.rp.29) (jump L.pair?.12)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.30
          (begin (set! r15 L.rp.30) (jump L.fun/empty13290.5)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char13291.7))))
(check-by-interp
 '(module
    (define L.fixnum?.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 7))
                (set! r14 r14))
              (= r14 0))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
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
    (define L.fun/ascii-char13294.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any13295.5 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/error13297.6
      (begin (set! r15 r15) (set! rax 46910) (jump r15)))
    (define L.fun/ascii-char13296.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/ascii-char13294.4)))
        (set! rbp (+ rbp 40)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin
            (set! rsi 920)
            (set! rdi 272)
            (set! r15 L.rp.14)
            (jump L.-.9)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin
            (set! rsi 1528)
            (set! rdi 1312)
            (set! r15 L.rp.15)
            (jump L.*.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.16)
            (jump L.-.9)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi 608)
            (set! rdi 928)
            (set! r15 L.rp.17)
            (jump L.+.11)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi 1288)
            (set! rdi 224)
            (set! r15 L.rp.18)
            (jump L.-.9)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.19)
            (jump L.+.11)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.+.11)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/any13295.5)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin (set! rdi r15) (set! r15 L.rp.22) (jump L.fixnum?.12)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char13296.7)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/error13297.6)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (set! rax fv3)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.ascii-char?.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 255))
                (set! r14 r14))
              (= r14 46))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.fun/ascii-char13919.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error13917.5
      (begin (set! r15 r15) (set! rax 34878) (jump r15)))
    (define L.fun/any13918.6 (begin (set! r15 r15) (set! rax 14) (jump r15)))
    (define L.fun/void13916.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char13915.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char13915.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void13916.7)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/error13917.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/any13918.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.15
          (begin (set! rdi r15) (set! r15 L.rp.15) (jump L.ascii-char?.10)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/ascii-char13919.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
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
    (define L.*.8
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
    (define L.fun/empty14259.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char14257.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error14258.6
      (begin (set! r15 r15) (set! rax 21310) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char14257.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.12
          (begin
            (set! rsi 1776)
            (set! rdi 1648)
            (set! r15 L.rp.12)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.13
          (begin
            (set! rsi 1328)
            (set! rdi 1808)
            (set! r15 L.rp.13)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.15
          (begin
            (set! rsi 1872)
            (set! rdi 1456)
            (set! r15 L.rp.15)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.16
          (begin
            (set! rsi 624)
            (set! rdi 432)
            (set! r15 L.rp.16)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.17)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error14258.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty14259.4)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 544)
            (set! rdi 1448)
            (set! r15 L.rp.21)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1936)
            (set! rdi 504)
            (set! r15 L.rp.22)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.23)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 624)
            (set! rdi 832)
            (set! r15 L.rp.24)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 256)
            (set! rdi 816)
            (set! r15 L.rp.25)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.26)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.27)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.fun/empty15571.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char15572.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char15569.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty15570.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void15568.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/void15568.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char15569.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty15570.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty15571.4)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char15572.5)))
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
    (define L.fun/ascii-char15704.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void15705.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char15707.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error15708.7
      (begin (set! r15 r15) (set! rax 36158) (jump r15)))
    (define L.fun/empty15706.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/ascii-char15704.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void15705.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin
            (set! rsi 424)
            (set! rdi 1192)
            (set! r15 L.rp.15)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 1368)
            (set! rdi 1600)
            (set! r15 L.rp.16)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.17)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 536)
            (set! rdi 1936)
            (set! r15 L.rp.18)
            (jump L.+.12)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1704)
            (set! rdi 112)
            (set! r15 L.rp.19)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.21)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty15706.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char15707.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error15708.7))))
(check-by-interp
 '(module
    (define L.empty?.13
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
    (define L.ascii-char?.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 255))
                (set! r14 r14))
              (= r14 46))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
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
    (define L.fun/void15911.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any15910.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any15908.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char15909.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin
            (set! rsi 152)
            (set! rdi 1608)
            (set! r15 L.rp.14)
            (jump L.+.9)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin
            (set! rsi 256)
            (set! rdi 1064)
            (set! r15 L.rp.15)
            (jump L.+.9)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.16)
            (jump L.+.9)))
        (set! rbp (+ rbp 32)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 1016)
            (set! rdi 2032)
            (set! r15 L.rp.17)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 1496)
            (set! rdi 544)
            (set! r15 L.rp.18)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.19)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.20)
            (jump L.*.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/any15908.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin (set! rdi r15) (set! r15 L.rp.22) (jump L.ascii-char?.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char15909.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/any15910.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.25
          (begin (set! rdi r15) (set! r15 L.rp.25) (jump L.empty?.13)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/void15911.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.fun/error16257.4
      (begin (set! r15 r15) (set! rax 57150) (jump r15)))
    (define L.fun/ascii-char16255.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty16258.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty16256.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char16259.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char16255.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty16256.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error16257.4)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty16258.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char16259.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
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
    (define L.*.8
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
    (define L.fun/void17748.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char17750.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error17749.6
      (begin (set! r15 r15) (set! rax 36158) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/void17748.4)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.12
          (begin
            (set! rsi 1496)
            (set! rdi 2000)
            (set! r15 L.rp.12)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.13
          (begin
            (set! rsi 464)
            (set! rdi 1416)
            (set! r15 L.rp.13)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.15
          (begin
            (set! rsi 1352)
            (set! rdi 912)
            (set! r15 L.rp.15)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.16
          (begin
            (set! rsi 1184)
            (set! rdi 1176)
            (set! r15 L.rp.16)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.17)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error17749.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char17750.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 608)
            (set! rdi 1920)
            (set! r15 L.rp.21)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1456)
            (set! rdi 1400)
            (set! r15 L.rp.22)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.-.10)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 400)
            (set! rdi 1480)
            (set! r15 L.rp.24)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1320)
            (set! rdi 848)
            (set! r15 L.rp.25)
            (jump L.-.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.26)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.27)
            (jump L.-.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rax fv3)
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
    (define L.fun/empty17803.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error17806.5
      (begin (set! r15 r15) (set! rax 38462) (jump r15)))
    (define L.fun/void17802.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void17805.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty17804.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void17802.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/empty17803.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty17804.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void17805.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 992)
            (set! rdi 936)
            (set! r15 L.rp.17)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 416)
            (set! rdi 792)
            (set! r15 L.rp.18)
            (jump L.*.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.19)
            (jump L.*.11)))
        (set! rbp (+ rbp 32)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi 792)
            (set! rdi 1936)
            (set! r15 L.rp.20)
            (jump L.+.12)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi 1904)
            (set! rdi 472)
            (set! r15 L.rp.21)
            (jump L.*.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.22)
            (jump L.*.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.23)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error17806.5))))
(check-by-interp
 '(module
    (define L.*.6
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
    (define L.void?.5
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
    (begin
      (set! fv0 r15)
      (if (begin
            (begin
              (set! r15 14)
              (set! r15 830)
              (set! r15 30)
              (set! r15 1512)
              (set! r15 88)
              (set! r15 30)
              (begin
                (set! rbp (- rbp 8))
                (return-point L.rp.7
                  (begin (set! rdi r15) (set! r15 L.rp.7) (jump L.void?.5)))
                (set! rbp (+ rbp 8)))
              (set! r15 rax))
            (!= r15 6))
        (begin
          (if (begin (set! r15 14) (true)) (set! r15 400) (set! r15 1200))
          (if (begin (set! r14 14) (true)) (set! r14 1000) (set! r14 1256))
          (set! rsi r14)
          (set! rdi r15)
          (set! r15 fv0)
          (jump L.*.6))
        (begin
          (if (begin (set! r15 6) (false)) (set! r15 1464) (set! r15 360))
          (if (begin (set! r14 14) (true)) (set! r14 72) (set! r14 816))
          (set! rsi r14)
          (set! rdi r15)
          (set! r15 fv0)
          (jump L.*.6))))))
(check-by-interp
 '(module
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
    (define L.*.9
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
    (define L.fun/void20503.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty20501.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char20504.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void20502.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty20501.5)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void20502.7)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void20503.4)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/ascii-char20504.6)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi 1000)
            (set! rdi 144)
            (set! r15 L.rp.16)
            (jump L.*.9)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi 1840)
            (set! rdi 1248)
            (set! r15 L.rp.17)
            (jump L.*.9)))
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
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi 1216)
            (set! rdi 88)
            (set! r15 L.rp.19)
            (jump L.*.9)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin
            (set! rsi 784)
            (set! rdi 512)
            (set! r15 L.rp.20)
            (jump L.+.11)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.21)
            (jump L.*.9)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.22)
            (jump L.*.9)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.-.17
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
    (define L.*.15
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
    (define L.fun/error28491.4
      (begin (set! r15 r15) (set! rax 45118) (jump r15)))
    (define L.fun/empty28492.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty28493.6)))
    (define L.fun/empty28493.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty28494.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty28495.12)))
    (define L.fun/ascii-char28488.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char28489.13)))
    (define L.fun/error28490.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error28491.4)))
    (define L.fun/void28497.10 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void28496.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void28497.10)))
    (define L.fun/empty28495.12
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char28489.13
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin
            (set! rsi 1616)
            (set! rdi 456)
            (set! r15 L.rp.18)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin
            (set! rsi 144)
            (set! rdi 912)
            (set! r15 L.rp.19)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi 928)
            (set! rdi 1048)
            (set! r15 L.rp.21)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 224)
            (set! rdi 1272)
            (set! r15 L.rp.22)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.24)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 224)
            (set! rdi 1872)
            (set! r15 L.rp.25)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 1528)
            (set! rdi 912)
            (set! r15 L.rp.26)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 320)
            (set! rdi 1672)
            (set! r15 L.rp.28)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 1280)
            (set! rdi 1352)
            (set! r15 L.rp.29)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.32)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/ascii-char28488.8)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/error28490.9)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/empty28492.5)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/empty28494.7)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/void28496.11)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.fun/ascii-char28930.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char28931.10)))
    (define L.fun/error28940.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error28941.15)))
    (define L.fun/ascii-char28935.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void28936.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void28937.11)))
    (define L.fun/void28938.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void28939.14)))
    (define L.fun/error28933.9
      (begin (set! r15 r15) (set! rax 44606) (jump r15)))
    (define L.fun/ascii-char28931.10
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void28937.11 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char28934.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char28935.6)))
    (define L.fun/error28932.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error28933.9)))
    (define L.fun/void28939.14 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error28941.15
      (begin (set! r15 r15) (set! rax 62526) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char28930.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error28932.13)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char28934.12)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void28936.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void28938.8)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error28940.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.+.17
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
    (define L.*.16
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
    (define L.fun/empty30828.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty30827.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty30828.4)))
    (define L.fun/void30829.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void30830.12)))
    (define L.fun/error30825.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error30826.11)))
    (define L.fun/error30824.8
      (begin (set! r15 r15) (set! rax 31294) (jump r15)))
    (define L.fun/empty30822.9 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error30823.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error30824.8)))
    (define L.fun/error30826.11
      (begin (set! r15 r15) (set! rax 28734) (jump r15)))
    (define L.fun/void30830.12 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty30821.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty30822.9)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/empty30821.13)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error30823.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error30825.7)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty30827.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1424)
            (set! rdi 1560)
            (set! r15 L.rp.22)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi 1440)
            (set! rdi 488)
            (set! r15 L.rp.23)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.24)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 432)
            (set! rdi 1008)
            (set! r15 L.rp.25)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 664)
            (set! rdi 760)
            (set! r15 L.rp.26)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 408)
            (set! rdi 1368)
            (set! r15 L.rp.29)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi 2016)
            (set! rdi 552)
            (set! r15 L.rp.30)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 1168)
            (set! rdi 528)
            (set! r15 L.rp.32)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 1424)
            (set! rdi 1872)
            (set! r15 L.rp.33)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.34)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.35)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.36)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/void30829.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.-.13
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
    (define L.fun/void31698.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void31699.8)))
    (define L.fun/void31701.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void31700.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void31701.5)))
    (define L.fun/empty31697.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void31699.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty31696.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty31697.7)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.14
          (begin
            (set! rsi 1264)
            (set! rdi 608)
            (set! r15 L.rp.14)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.15
          (begin
            (set! rsi 1424)
            (set! rdi 800)
            (set! r15 L.rp.15)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.16
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.16)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.17
          (begin
            (set! rsi 360)
            (set! rdi 1392)
            (set! r15 L.rp.17)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.18
          (begin
            (set! rsi 1936)
            (set! rdi 1416)
            (set! r15 L.rp.18)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.19)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.20)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.21
          (begin
            (set! rsi 1840)
            (set! rdi 760)
            (set! r15 L.rp.21)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.22
          (begin
            (set! rsi 1968)
            (set! rdi 1616)
            (set! r15 L.rp.22)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.24
          (begin
            (set! rsi 1792)
            (set! rdi 360)
            (set! r15 L.rp.24)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.25
          (begin
            (set! rsi 1480)
            (set! rdi 896)
            (set! r15 L.rp.25)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.26)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.28)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.29
          (begin
            (set! rsi 968)
            (set! rdi 1584)
            (set! r15 L.rp.29)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.30
          (begin
            (set! rsi 1624)
            (set! rdi 928)
            (set! r15 L.rp.30)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.32
          (begin
            (set! rsi 1432)
            (set! rdi 656)
            (set! r15 L.rp.32)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.33
          (begin
            (set! rsi 208)
            (set! rdi 784)
            (set! r15 L.rp.33)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.34)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.35)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.36
          (begin
            (set! rsi 1192)
            (set! rdi 192)
            (set! r15 L.rp.36)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.37
          (begin
            (set! rsi 1872)
            (set! rdi 1424)
            (set! r15 L.rp.37)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.38)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.39
          (begin
            (set! rsi 88)
            (set! rdi 176)
            (set! r15 L.rp.39)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.40
          (begin
            (set! rsi 1120)
            (set! rdi 912)
            (set! r15 L.rp.40)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.41
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.41)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.42
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.42)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.43)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.44
          (begin (set! r15 L.rp.44) (jump L.fun/empty31696.9)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.45
          (begin (set! r15 L.rp.45) (jump L.fun/void31698.4)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.46
          (begin (set! r15 L.rp.46) (jump L.fun/void31700.6)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.47
          (begin
            (set! rsi 896)
            (set! rdi 640)
            (set! r15 L.rp.47)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.48
          (begin
            (set! rsi 88)
            (set! rdi 1112)
            (set! r15 L.rp.48)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.49
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.49)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.50
          (begin
            (set! rsi 1928)
            (set! rdi 1952)
            (set! r15 L.rp.50)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.51
          (begin
            (set! rsi 1384)
            (set! rdi 1552)
            (set! r15 L.rp.51)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.52
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.52)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.53
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.53)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.54
          (begin
            (set! rsi 960)
            (set! rdi 272)
            (set! r15 L.rp.54)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.55
          (begin
            (set! rsi 1392)
            (set! rdi 1216)
            (set! r15 L.rp.55)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.56
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.56)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.57
          (begin
            (set! rsi 1432)
            (set! rdi 1152)
            (set! r15 L.rp.57)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.58
          (begin
            (set! rsi 832)
            (set! rdi 1216)
            (set! r15 L.rp.58)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.59
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.59)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.60
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.60)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.61
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.61)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.pair?.15
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
    (define L.fun/void46565.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void46566.6)))
    (define L.fun/error46563.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error46564.8)))
    (define L.fun/void46566.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty46562.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error46564.8
      (begin (set! r15 r15) (set! rax 49982) (jump r15)))
    (define L.fun/empty46561.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty46562.7)))
    (define L.fun/any46567.10
      (begin (set! r15 r15) (set! rax 1696) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/empty46561.9)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/error46563.5)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rsi 1432)
            (set! rdi 152)
            (set! r15 L.rp.18)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin
            (set! rsi 288)
            (set! rdi 640)
            (set! r15 L.rp.19)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi 424)
            (set! rdi 608)
            (set! r15 L.rp.21)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi 1016)
            (set! rdi 1656)
            (set! r15 L.rp.22)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.24)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi 600)
            (set! rdi 1392)
            (set! r15 L.rp.25)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi 856)
            (set! rdi 280)
            (set! r15 L.rp.26)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi 344)
            (set! rdi 760)
            (set! r15 L.rp.28)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi 1496)
            (set! rdi 704)
            (set! r15 L.rp.29)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.32)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/void46565.4)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi 544)
            (set! rdi 1784)
            (set! r15 L.rp.34)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin
            (set! rsi 352)
            (set! rdi 1800)
            (set! r15 L.rp.35)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi 392)
            (set! rdi 592)
            (set! r15 L.rp.37)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi 520)
            (set! rdi 1544)
            (set! r15 L.rp.38)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.39)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.40)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi 896)
            (set! rdi 1288)
            (set! r15 L.rp.41)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi 384)
            (set! rdi 912)
            (set! r15 L.rp.42)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.43)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi 400)
            (set! rdi 680)
            (set! r15 L.rp.44)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi 480)
            (set! rdi 664)
            (set! r15 L.rp.45)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.46)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.47)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.48)
            (jump L.*.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/any46567.10)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.50
          (begin (set! rdi r15) (set! r15 L.rp.50) (jump L.pair?.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.+.15
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
    (define L.fun/error50281.4
      (begin (set! r15 r15) (set! rax 16446) (jump r15)))
    (define L.fun/error50280.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error50281.4)))
    (define L.fun/void50283.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char50284.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char50285.9)))
    (define L.fun/void50278.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void50279.10)))
    (define L.fun/ascii-char50285.9
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void50279.10 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void50282.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void50283.6)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void50278.8)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/error50280.5)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rsi 1120)
            (set! rdi 616)
            (set! r15 L.rp.18)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin
            (set! rsi 192)
            (set! rdi 1456)
            (set! r15 L.rp.19)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi 424)
            (set! rdi 1400)
            (set! r15 L.rp.21)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi 1392)
            (set! rdi 1416)
            (set! r15 L.rp.22)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.24)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi 1424)
            (set! rdi 1960)
            (set! r15 L.rp.25)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi 128)
            (set! rdi 336)
            (set! r15 L.rp.26)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi 1640)
            (set! rdi 1152)
            (set! r15 L.rp.28)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi 312)
            (set! rdi 1088)
            (set! r15 L.rp.29)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.32)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/void50282.11)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi 608)
            (set! rdi 1672)
            (set! r15 L.rp.34)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin
            (set! rsi 400)
            (set! rdi 1736)
            (set! r15 L.rp.35)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.36)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi 1520)
            (set! rdi 1496)
            (set! r15 L.rp.37)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi 1136)
            (set! rdi 304)
            (set! r15 L.rp.38)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.39)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.40)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi 192)
            (set! rdi 1640)
            (set! r15 L.rp.41)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi 1224)
            (set! rdi 1816)
            (set! r15 L.rp.42)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.43)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi 1312)
            (set! rdi 520)
            (set! r15 L.rp.44)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi 1176)
            (set! rdi 120)
            (set! r15 L.rp.45)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.46)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.47)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.48)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/ascii-char50284.7)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (set! rax fv4)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.+.15
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
    (define L.-.13
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
    (define L.fun/ascii-char51656.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char51657.5)))
    (define L.fun/ascii-char51657.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error51658.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error51659.11)))
    (define L.fun/void51654.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void51655.9)))
    (define L.fun/error51653.8
      (begin (set! r15 r15) (set! rax 20030) (jump r15)))
    (define L.fun/void51655.9 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error51652.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error51653.8)))
    (define L.fun/error51659.11
      (begin (set! r15 r15) (set! rax 45374) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin
            (set! rsi 32)
            (set! rdi 696)
            (set! r15 L.rp.16)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin
            (set! rsi 1768)
            (set! rdi 1576)
            (set! r15 L.rp.17)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin
            (set! rsi 408)
            (set! rdi 1632)
            (set! r15 L.rp.19)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi 976)
            (set! rdi 632)
            (set! r15 L.rp.20)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.21)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.22)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi 608)
            (set! rdi 168)
            (set! r15 L.rp.23)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi 400)
            (set! rdi 1912)
            (set! r15 L.rp.24)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.25)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi 1256)
            (set! rdi 992)
            (set! r15 L.rp.26)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi 424)
            (set! rdi 1144)
            (set! r15 L.rp.27)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.30)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin (set! r15 L.rp.31) (jump L.fun/error51652.10)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/void51654.7)))
        (set! rbp (+ rbp 128)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin
            (set! rsi 1560)
            (set! rdi 1472)
            (set! r15 L.rp.33)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi 1624)
            (set! rdi 592)
            (set! r15 L.rp.34)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.35)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi 1352)
            (set! rdi 536)
            (set! r15 L.rp.36)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi 848)
            (set! rdi 888)
            (set! r15 L.rp.37)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.38)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.39)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi 56)
            (set! rdi 1120)
            (set! r15 L.rp.40)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi 1016)
            (set! rdi 824)
            (set! r15 L.rp.41)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.42)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi 1056)
            (set! rdi 16)
            (set! r15 L.rp.43)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi 144)
            (set! rdi 904)
            (set! r15 L.rp.44)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.45)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.46)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.47)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/ascii-char51656.4)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/error51658.6)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (set! rax fv4)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.vector?.16
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
    (define L.fun/error54326.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error54327.8)))
    (define L.fun/error54322.5
      (begin (set! r15 r15) (set! rax 18238) (jump r15)))
    (define L.fun/empty54331.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void54329.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error54327.8
      (begin (set! r15 r15) (set! rax 17214) (jump r15)))
    (define L.fun/error54325.9
      (begin (set! r15 r15) (set! rax 8766) (jump r15)))
    (define L.fun/error54321.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error54322.5)))
    (define L.fun/any54323.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void54328.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void54329.7)))
    (define L.fun/error54324.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error54325.9)))
    (define L.fun/empty54330.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty54331.6)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/error54321.10)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/any54323.11)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! rdi r15) (set! r15 L.rp.19) (jump L.vector?.16)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error54324.13)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error54326.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/void54328.12)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty54330.14)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.*.19
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
    (define L.+.18
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
    (define L.-.17
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
    (define L.boolean?.16
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
    (define L.fun/ascii-char64319.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error64313.5
      (begin (set! r15 r15) (set! rax 26430) (jump r15)))
    (define L.fun/empty64317.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char64318.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char64319.4)))
    (define L.fun/void64310.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty64315.9 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/any64311.10
      (begin (set! r15 r15) (set! rax 40766) (jump r15)))
    (define L.fun/error64312.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error64313.5)))
    (define L.fun/empty64316.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty64317.6)))
    (define L.fun/empty64314.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty64315.9)))
    (define L.fun/void64309.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void64310.8)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void64309.14)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/any64311.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! rdi r15) (set! r15 L.rp.22) (jump L.boolean?.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error64312.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/empty64314.13)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/empty64316.12)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 1520)
            (set! rdi 1160)
            (set! r15 L.rp.26)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 512)
            (set! rdi 1104)
            (set! r15 L.rp.27)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.28)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 1808)
            (set! rdi 1440)
            (set! r15 L.rp.29)
            (jump L.*.19)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi 1592)
            (set! rdi 696)
            (set! r15 L.rp.30)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.32)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 976)
            (set! rdi 184)
            (set! r15 L.rp.33)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin (set! rsi 880) (set! rdi 8) (set! r15 L.rp.34) (jump L.*.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.35)
            (jump L.*.19)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi 1104)
            (set! rdi 1112)
            (set! r15 L.rp.36)
            (jump L.*.19)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi 1528)
            (set! rdi 992)
            (set! r15 L.rp.37)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.38)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.39)
            (jump L.*.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.40)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char64318.7))))
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
    (define L.fun/void75654.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty75657.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty75658.10)))
    (define L.fun/ascii-char75662.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char75660.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty75656.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char75661.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char75662.6)))
    (define L.fun/empty75658.10
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty75655.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty75656.8)))
    (define L.fun/void75653.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void75654.4)))
    (define L.fun/ascii-char75659.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char75660.7)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi 8)
            (set! rdi 1632)
            (set! r15 L.rp.18)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin
            (set! rsi 448)
            (set! rdi 824)
            (set! r15 L.rp.19)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 8)
            (set! rdi 1680)
            (set! r15 L.rp.21)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1232)
            (set! rdi 1912)
            (set! r15 L.rp.22)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.24)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1320)
            (set! rdi 552)
            (set! r15 L.rp.25)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 1840)
            (set! rdi 1744)
            (set! r15 L.rp.26)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 1096)
            (set! rdi 1744)
            (set! r15 L.rp.28)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 408)
            (set! rdi 1680)
            (set! r15 L.rp.29)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.32)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/void75653.12)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/empty75655.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/empty75657.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/ascii-char75659.13)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char75661.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.+.17
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
    (define L.*.16
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
    (define L.error?.14
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
    (define L.fun/error83230.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error83231.10)))
    (define L.fun/empty83233.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty83234.9)))
    (define L.fun/void83236.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char83229.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void83235.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void83236.6)))
    (define L.fun/empty83234.9 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error83231.10
      (begin (set! r15 r15) (set! rax 6974) (jump r15)))
    (define L.fun/any83232.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char83228.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char83229.7)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char83228.12)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error83230.4)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/any83232.11)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin (set! rdi r15) (set! r15 L.rp.21) (jump L.error?.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty83233.5)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void83235.8)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi 1816)
            (set! rdi 72)
            (set! r15 L.rp.24)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 440)
            (set! rdi 1344)
            (set! r15 L.rp.25)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.26)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi 192)
            (set! rdi 912)
            (set! r15 L.rp.27)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 88)
            (set! rdi 608)
            (set! r15 L.rp.28)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.29)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.30)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi 136)
            (set! rdi 1432)
            (set! r15 L.rp.31)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 984)
            (set! rdi 824)
            (set! r15 L.rp.32)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.33)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi 504)
            (set! rdi 208)
            (set! r15 L.rp.34)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi 720)
            (set! rdi 1128)
            (set! r15 L.rp.35)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.36)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.37)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.38)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.error?.16
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
    (define L.fun/ascii-char87923.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char87924.13)))
    (define L.fun/empty87931.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char87928.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char87929.7)))
    (define L.fun/ascii-char87929.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char87926.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty87930.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty87931.5)))
    (define L.fun/void87922.10 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any87927.11 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char87925.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char87926.8)))
    (define L.fun/ascii-char87924.13
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void87921.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void87922.10)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void87921.14)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char87923.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char87925.12)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/any87927.11)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! rdi r15) (set! r15 L.rp.21) (jump L.error?.16)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char87928.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty87930.9)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
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
    (define L.-.16
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
    (define L.+.15
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
    (define L.fun/void88023.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty88027.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error88024.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error88025.11)))
    (define L.fun/error88021.7
      (begin (set! r15 r15) (set! rax 56894) (jump r15)))
    (define L.fun/empty88026.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty88027.5)))
    (define L.fun/error88029.9
      (begin (set! r15 r15) (set! rax 50494) (jump r15)))
    (define L.fun/error88020.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error88021.7)))
    (define L.fun/error88025.11
      (begin (set! r15 r15) (set! rax 54334) (jump r15)))
    (define L.fun/void88022.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void88023.4)))
    (define L.fun/error88028.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error88029.9)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error88020.10)))
        (set! rbp (+ rbp 72)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void88022.12)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error88024.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi 608)
            (set! rdi 440)
            (set! r15 L.rp.21)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin (set! rsi 0) (set! rdi 184) (set! r15 L.rp.22) (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi 168)
            (set! rdi 144)
            (set! r15 L.rp.24)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 1448)
            (set! rdi 1224)
            (set! r15 L.rp.25)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.26)
            (jump L.*.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 864)
            (set! rdi 32)
            (set! r15 L.rp.28)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 872)
            (set! rdi 752)
            (set! r15 L.rp.29)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi 1912)
            (set! rdi 1912)
            (set! r15 L.rp.31)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 784)
            (set! rdi 1704)
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
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.34)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.35)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/empty88026.8)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/error88028.13)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax fv4)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.+.15
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
    (define L.-.13
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
    (define L.pair?.12
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
    (define L.fun/ascii-char95245.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty95247.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void95242.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void95241.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void95242.6)))
    (define L.fun/any95243.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char95244.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char95245.4)))
    (define L.fun/empty95246.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty95247.5)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void95241.7)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/any95243.8)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin (set! rdi r15) (set! r15 L.rp.18) (jump L.pair?.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char95244.9)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi 1928)
            (set! rdi 336)
            (set! r15 L.rp.20)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi 1904)
            (set! rdi 776)
            (set! r15 L.rp.21)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.22)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi 376)
            (set! rdi 1720)
            (set! r15 L.rp.23)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi 256)
            (set! rdi 912)
            (set! r15 L.rp.24)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.25)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.26)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi 1400)
            (set! rdi 136)
            (set! r15 L.rp.27)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi 1648)
            (set! rdi 1472)
            (set! r15 L.rp.28)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.29)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi 528)
            (set! rdi 1240)
            (set! r15 L.rp.30)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin
            (set! rsi 728)
            (set! rdi 1200)
            (set! r15 L.rp.31)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.32)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.33)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.34)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/empty95246.10)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi 1368)
            (set! rdi 168)
            (set! r15 L.rp.36)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi 1400)
            (set! rdi 1368)
            (set! r15 L.rp.37)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.38)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi 72)
            (set! rdi 696)
            (set! r15 L.rp.39)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi 128)
            (set! rdi 1616)
            (set! r15 L.rp.40)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.41)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.42)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi 896)
            (set! rdi 360)
            (set! r15 L.rp.43)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi 1472)
            (set! rdi 1968)
            (set! r15 L.rp.44)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.45)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin
            (set! rsi 1136)
            (set! rdi 1360)
            (set! r15 L.rp.46)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin
            (set! rsi 728)
            (set! rdi 1096)
            (set! r15 L.rp.47)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.48)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.49)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.50
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.50)
            (jump L.-.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
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
    (define L.fun/ascii-char101002.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void101005.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void101006.12)))
    (define L.fun/ascii-char101007.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char101008.10)))
    (define L.fun/ascii-char101000.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void101004.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char100999.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char101000.7)))
    (define L.fun/ascii-char101008.10
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void101003.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void101004.8)))
    (define L.fun/void101006.12
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char101001.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char101002.4)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char100999.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin
            (set! rsi 720)
            (set! rdi 1032)
            (set! r15 L.rp.19)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin
            (set! rsi 1568)
            (set! rdi 1368)
            (set! r15 L.rp.20)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.21)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 952)
            (set! rdi 576)
            (set! r15 L.rp.22)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi 976)
            (set! rdi 112)
            (set! r15 L.rp.23)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.24)
            (jump L.-.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.25)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 1048)
            (set! rdi 1704)
            (set! r15 L.rp.26)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 16)
            (set! rdi 728)
            (set! r15 L.rp.27)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 1072)
            (set! rdi 784)
            (set! r15 L.rp.29)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi 1152)
            (set! rdi 1656)
            (set! r15 L.rp.30)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.31)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.32)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.+.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/ascii-char101001.13)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/void101003.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/void101005.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char101007.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.-.17
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
    (define L.*.15
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
    (define L.fun/error102221.4
      (begin (set! r15 r15) (set! rax 2110) (jump r15)))
    (define L.fun/void102218.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void102219.11)))
    (define L.fun/empty102216.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty102217.9)))
    (define L.fun/ascii-char102223.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void102214.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void102215.13)))
    (define L.fun/empty102217.9
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error102220.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error102221.4)))
    (define L.fun/void102219.11
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char102222.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char102223.7)))
    (define L.fun/void102215.13
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void102214.8)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/empty102216.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void102218.5)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error102220.10)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 184)
            (set! rdi 1688)
            (set! r15 L.rp.22)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi 936)
            (set! rdi 1192)
            (set! r15 L.rp.23)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.24)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 1936)
            (set! rdi 1264)
            (set! r15 L.rp.25)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 1968)
            (set! rdi 656)
            (set! r15 L.rp.26)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.27)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.28)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 1256)
            (set! rdi 632)
            (set! r15 L.rp.29)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi 520)
            (set! rdi 1456)
            (set! r15 L.rp.30)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.31)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 1832)
            (set! rdi 568)
            (set! r15 L.rp.32)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi 24)
            (set! rdi 1672)
            (set! r15 L.rp.33)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.34)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.35)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.36)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char102222.12)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.-.19
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
    (define L.*.18
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
    (define L.+.17
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
    (define L.vector?.16
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
    (define L.fun/void102243.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void102244.10)))
    (define L.fun/any102238.5 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/ascii-char102236.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char102237.13)))
    (define L.fun/void102241.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void102242.11)))
    (define L.fun/ascii-char102239.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char102240.12)))
    (define L.fun/ascii-char102234.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char102235.14)))
    (define L.fun/void102244.10
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void102242.11
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char102240.12
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char102237.13
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char102235.14
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char102234.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char102236.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/any102238.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! rdi r15) (set! r15 L.rp.23) (jump L.vector?.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/ascii-char102239.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/void102241.7)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/void102243.4)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 1032)
            (set! rdi 1848)
            (set! r15 L.rp.27)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 1088)
            (set! rdi 488)
            (set! r15 L.rp.28)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi 264)
            (set! rdi 1440)
            (set! r15 L.rp.30)
            (jump L.-.19)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi 1248)
            (set! rdi 1976)
            (set! r15 L.rp.31)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.32)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi 1616)
            (set! rdi 1904)
            (set! r15 L.rp.34)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 312)
            (set! rdi 576)
            (set! r15 L.rp.35)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.-.19)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi 1400)
            (set! rdi 784)
            (set! r15 L.rp.37)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi 1936)
            (set! rdi 592)
            (set! r15 L.rp.38)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.39)
            (jump L.-.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.40)
            (jump L.-.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.*.18))))
(check-by-interp
 '(module
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
    (define L.fun/empty104399.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty104400.8)))
    (define L.fun/void104397.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void104398.12)))
    (define L.fun/error104406.6
      (begin (set! r15 r15) (set! rax 52798) (jump r15)))
    (define L.fun/empty104404.7
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty104400.8
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error104405.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error104406.6)))
    (define L.fun/empty104395.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty104396.14)))
    (define L.fun/void104401.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void104402.13)))
    (define L.fun/void104398.12
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void104402.13
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty104396.14
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty104403.15
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty104404.7)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty104395.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void104397.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty104399.4)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void104401.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 984)
            (set! rdi 1080)
            (set! r15 L.rp.24)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1576)
            (set! rdi 128)
            (set! r15 L.rp.25)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.26)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 576)
            (set! rdi 1344)
            (set! r15 L.rp.27)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 560)
            (set! rdi 832)
            (set! r15 L.rp.28)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi 568)
            (set! rdi 1424)
            (set! r15 L.rp.31)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 776)
            (set! rdi 1512)
            (set! r15 L.rp.32)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi 1344)
            (set! rdi 208)
            (set! r15 L.rp.34)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 1296)
            (set! rdi 608)
            (set! r15 L.rp.35)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.37)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.38)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin (set! r15 L.rp.39) (jump L.fun/empty104403.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error104405.9))))
(check-by-interp
 '(module
    (define L.boolean?.16
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
    (define L.fun/any105578.4
      (begin (set! r15 r15) (set! rax 1504) (jump r15)))
    (define L.fun/error105579.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error105580.11)))
    (define L.fun/error105575.6
      (begin (set! r15 r15) (set! rax 18494) (jump r15)))
    (define L.fun/ascii-char105573.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error105576.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error105577.13)))
    (define L.fun/ascii-char105572.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char105573.7)))
    (define L.fun/void105581.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void105582.14)))
    (define L.fun/error105580.11
      (begin (set! r15 r15) (set! rax 31038) (jump r15)))
    (define L.fun/error105574.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error105575.6)))
    (define L.fun/error105577.13
      (begin (set! r15 r15) (set! rax 55358) (jump r15)))
    (define L.fun/void105582.14
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char105572.9)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error105574.12)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error105576.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/any105578.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! rdi r15) (set! r15 L.rp.21) (jump L.boolean?.16)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error105579.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void105581.10)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.ascii-char?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 255))
                (set! r14 r14))
              (= r14 46))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.fun/void121813.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char121818.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char121819.11)))
    (define L.fun/void121814.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void121815.12)))
    (define L.fun/ascii-char121816.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char121817.9)))
    (define L.fun/void121812.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void121813.4)))
    (define L.fun/ascii-char121817.9
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char121811.10
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char121819.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void121815.12
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char121810.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char121811.10)))
    (define L.fun/any121809.14 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/any121809.14)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! rdi r15) (set! r15 L.rp.18) (jump L.ascii-char?.16)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char121810.13)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void121812.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void121814.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char121816.7)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char121818.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.+.15
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
    (define L.-.13
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
    (define L.fun/error128005.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error128006.9)))
    (define L.fun/empty128002.5
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void128004.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty128001.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty128002.5)))
    (define L.fun/empty128008.8
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error128006.9
      (begin (set! r15 r15) (set! rax 9278) (jump r15)))
    (define L.fun/empty128007.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty128008.8)))
    (define L.fun/void128003.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void128004.6)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.16
          (begin
            (set! rsi 1144)
            (set! rdi 1312)
            (set! r15 L.rp.16)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.17
          (begin
            (set! rsi 2016)
            (set! rdi 1080)
            (set! r15 L.rp.17)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.19
          (begin
            (set! rsi 1384)
            (set! rdi 40)
            (set! r15 L.rp.19)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.20
          (begin
            (set! rsi 1832)
            (set! rdi 1872)
            (set! r15 L.rp.20)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.21)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.22)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.23
          (begin
            (set! rsi 264)
            (set! rdi 1008)
            (set! r15 L.rp.23)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.24
          (begin
            (set! rsi 952)
            (set! rdi 1376)
            (set! r15 L.rp.24)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.25)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.26
          (begin
            (set! rsi 464)
            (set! rdi 1376)
            (set! r15 L.rp.26)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.27
          (begin
            (set! rsi 656)
            (set! rdi 776)
            (set! r15 L.rp.27)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.30)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.31
          (begin (set! r15 L.rp.31) (jump L.fun/empty128001.7)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/void128003.11)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/error128005.4)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.34
          (begin
            (set! rsi 928)
            (set! rdi 816)
            (set! r15 L.rp.34)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.35
          (begin
            (set! rsi 824)
            (set! rdi 1728)
            (set! r15 L.rp.35)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.36)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.37
          (begin
            (set! rsi 1736)
            (set! rdi 1480)
            (set! r15 L.rp.37)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.38
          (begin
            (set! rsi 776)
            (set! rdi 1816)
            (set! r15 L.rp.38)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.39)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.40)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.41
          (begin
            (set! rsi 1104)
            (set! rdi 1272)
            (set! r15 L.rp.41)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.42
          (begin
            (set! rsi 1264)
            (set! rdi 1912)
            (set! r15 L.rp.42)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.43)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.44
          (begin
            (set! rsi 848)
            (set! rdi 1968)
            (set! r15 L.rp.44)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.45
          (begin
            (set! rsi 8)
            (set! rdi 1560)
            (set! r15 L.rp.45)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.46)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.47)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.48
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.48)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/empty128007.10)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (set! rax r15)
      (jump fv0))))
(check-by-interp
 '(module
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
    (define L.*.18
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
    (define L.-.17
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
    (define L.fun/ascii-char138303.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty138301.5
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty138304.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty138305.13)))
    (define L.fun/empty138307.7
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty138306.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty138307.7)))
    (define L.fun/ascii-char138302.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char138303.4)))
    (define L.fun/ascii-char138308.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char138309.12)))
    (define L.fun/error138310.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error138311.15)))
    (define L.fun/ascii-char138309.12
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty138305.13
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty138300.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty138301.5)))
    (define L.fun/error138311.15
      (begin (set! r15 r15) (set! rax 28990) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty138300.14)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char138302.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty138304.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty138306.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 1600)
            (set! rdi 2024)
            (set! r15 L.rp.24)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 376)
            (set! rdi 1728)
            (set! r15 L.rp.25)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.26)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 272)
            (set! rdi 1504)
            (set! r15 L.rp.27)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 72)
            (set! rdi 360)
            (set! r15 L.rp.28)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi 1448)
            (set! rdi 1984)
            (set! r15 L.rp.31)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 24)
            (set! rdi 1992)
            (set! r15 L.rp.32)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi 1576)
            (set! rdi 856)
            (set! r15 L.rp.34)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 256)
            (set! rdi 1424)
            (set! r15 L.rp.35)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.37)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.38)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin (set! r15 L.rp.39) (jump L.fun/ascii-char138308.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error138310.11))))
(check-by-interp
 '(module
    (define L.boolean?.19
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
    (define L.+.18
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
    (define L.-.17
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
    (define L.*.16
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
    (define L.fixnum?.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (if (begin
              (begin
                (set! r14 r14)
                (set! r14 (bitwise-and r14 7))
                (set! r14 r14))
              (= r14 0))
          (begin (set! rax 14) (jump r15))
          (begin (set! rax 6) (jump r15)))))
    (define L.fun/error139284.4
      (begin (set! r15 r15) (set! rax 15934) (jump r15)))
    (define L.fun/ascii-char139281.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char139282.10)))
    (define L.fun/error139283.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error139284.4)))
    (define L.fun/void139290.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any139288.8
      (begin (set! r15 r15) (set! rax 13886) (jump r15)))
    (define L.fun/empty139287.9
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char139282.10
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any139285.11 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void139289.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void139290.7)))
    (define L.fun/empty139286.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty139287.9)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char139281.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error139283.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/any139285.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! rdi r15) (set! r15 L.rp.23) (jump L.fixnum?.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/empty139286.13)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1832)
            (set! rdi 1960)
            (set! r15 L.rp.25)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 768)
            (set! rdi 1680)
            (set! r15 L.rp.26)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 1520)
            (set! rdi 856)
            (set! r15 L.rp.28)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 1096)
            (set! rdi 1264)
            (set! r15 L.rp.29)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 96)
            (set! rdi 160)
            (set! r15 L.rp.32)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 240)
            (set! rdi 696)
            (set! r15 L.rp.33)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.34)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 1704)
            (set! rdi 880)
            (set! r15 L.rp.35)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi 1640)
            (set! rdi 1696)
            (set! r15 L.rp.36)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.37)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.38)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.39)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin (set! r15 L.rp.40) (jump L.fun/any139288.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.41
          (begin (set! rdi r15) (set! r15 L.rp.41) (jump L.boolean?.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/void139289.12))))
(check-by-interp
 '(module
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
    (define L.*.9
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
    (define L.fun/void140574.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty140576.5
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty140575.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty140576.5)))
    (define L.fun/void140573.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void140574.4)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.12
          (begin
            (set! rsi 336)
            (set! rdi 1776)
            (set! r15 L.rp.12)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.13
          (begin
            (set! rsi 728)
            (set! rdi 728)
            (set! r15 L.rp.13)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.15
          (begin
            (set! rsi 1264)
            (set! rdi 1176)
            (set! r15 L.rp.15)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.16
          (begin
            (set! rsi 984)
            (set! rdi 496)
            (set! r15 L.rp.16)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.17)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.18)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.19
          (begin
            (set! rsi 1616)
            (set! rdi 1520)
            (set! r15 L.rp.19)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.20
          (begin
            (set! rsi 1392)
            (set! rdi 24)
            (set! r15 L.rp.20)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.21)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.22
          (begin
            (set! rsi 1456)
            (set! rdi 824)
            (set! r15 L.rp.22)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.23
          (begin
            (set! rsi 240)
            (set! rdi 1952)
            (set! r15 L.rp.23)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.24)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.25)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.26)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.27
          (begin
            (set! rsi 816)
            (set! rdi 1424)
            (set! r15 L.rp.27)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.28
          (begin
            (set! rsi 1520)
            (set! rdi 784)
            (set! r15 L.rp.28)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.30
          (begin
            (set! rsi 1680)
            (set! rdi 2032)
            (set! r15 L.rp.30)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.31
          (begin
            (set! rsi 328)
            (set! rdi 1776)
            (set! r15 L.rp.31)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.32)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.34
          (begin
            (set! rsi 1216)
            (set! rdi 2000)
            (set! r15 L.rp.34)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.35
          (begin
            (set! rsi 1280)
            (set! rdi 1928)
            (set! r15 L.rp.35)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.37
          (begin
            (set! rsi 488)
            (set! rdi 120)
            (set! r15 L.rp.37)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.38
          (begin
            (set! rsi 280)
            (set! rdi 1032)
            (set! r15 L.rp.38)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.39)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.40)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.41
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.41)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.42
          (begin
            (set! rsi 1984)
            (set! rdi 888)
            (set! r15 L.rp.42)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.43
          (begin
            (set! rsi 888)
            (set! rdi 1024)
            (set! r15 L.rp.43)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.44
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.44)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.45
          (begin (set! rsi 8) (set! rdi 504) (set! r15 L.rp.45) (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.46
          (begin
            (set! rsi 1544)
            (set! rdi 512)
            (set! r15 L.rp.46)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.47)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.48
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.48)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.49
          (begin
            (set! rsi 760)
            (set! rdi 288)
            (set! r15 L.rp.49)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.50
          (begin
            (set! rsi 960)
            (set! rdi 880)
            (set! r15 L.rp.50)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.51
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.51)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.52
          (begin
            (set! rsi 1288)
            (set! rdi 1000)
            (set! r15 L.rp.52)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.53
          (begin
            (set! rsi 48)
            (set! rdi 1744)
            (set! r15 L.rp.53)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.54
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.54)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.55
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.55)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.56
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.56)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.57
          (begin (set! r15 L.rp.57) (jump L.fun/void140573.7)))
        (set! rbp (+ rbp 240)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.58
          (begin
            (set! rsi 1960)
            (set! rdi 1272)
            (set! r15 L.rp.58)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.59
          (begin
            (set! rsi 648)
            (set! rdi 1632)
            (set! r15 L.rp.59)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.60
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.60)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.61
          (begin
            (set! rsi 1632)
            (set! rdi 712)
            (set! r15 L.rp.61)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.62
          (begin
            (set! rsi 552)
            (set! rdi 216)
            (set! r15 L.rp.62)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.63
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.63)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.64
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.64)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.65
          (begin
            (set! rsi 1296)
            (set! rdi 1944)
            (set! r15 L.rp.65)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.66
          (begin
            (set! rsi 1872)
            (set! rdi 1872)
            (set! r15 L.rp.66)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.67
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.67)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.68
          (begin
            (set! rsi 1744)
            (set! rdi 1128)
            (set! r15 L.rp.68)
            (jump L.+.10)))
        (set! rbp (+ rbp 240)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.69
          (begin
            (set! rsi 480)
            (set! rdi 944)
            (set! r15 L.rp.69)
            (jump L.*.9)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.70
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.70)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.71
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.71)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.72
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.72)
            (jump L.-.11)))
        (set! rbp (+ rbp 240)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 240))
        (return-point L.rp.73
          (begin (set! r15 L.rp.73) (jump L.fun/empty140575.6)))
        (set! rbp (+ rbp 240)))
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
    (define L.fun/error143927.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error143928.6)))
    (define L.fun/ascii-char143929.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char143930.11)))
    (define L.fun/error143928.6
      (begin (set! r15 r15) (set! rax 10814) (jump r15)))
    (define L.fun/void143926.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void143924.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void143923.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void143924.8)))
    (define L.fun/void143925.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void143926.7)))
    (define L.fun/ascii-char143930.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.16
          (begin
            (set! rsi 1392)
            (set! rdi 544)
            (set! r15 L.rp.16)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.17
          (begin
            (set! rsi 1344)
            (set! rdi 360)
            (set! r15 L.rp.17)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.19
          (begin
            (set! rsi 288)
            (set! rdi 1888)
            (set! r15 L.rp.19)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.20
          (begin
            (set! rsi 800)
            (set! rdi 968)
            (set! r15 L.rp.20)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.21)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.22)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.23
          (begin
            (set! rsi 912)
            (set! rdi 32)
            (set! r15 L.rp.23)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.24
          (begin
            (set! rsi 1744)
            (set! rdi 688)
            (set! r15 L.rp.24)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.25)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.26
          (begin
            (set! rsi 568)
            (set! rdi 304)
            (set! r15 L.rp.26)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.27
          (begin
            (set! rsi 256)
            (set! rdi 1344)
            (set! r15 L.rp.27)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.30)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.31
          (begin
            (set! rsi 1384)
            (set! rdi 1648)
            (set! r15 L.rp.31)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.32
          (begin
            (set! rsi 488)
            (set! rdi 1664)
            (set! r15 L.rp.32)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.34
          (begin
            (set! rsi 192)
            (set! rdi 1624)
            (set! r15 L.rp.34)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.35
          (begin
            (set! rsi 416)
            (set! rdi 1080)
            (set! r15 L.rp.35)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.37)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.38
          (begin
            (set! rsi 1496)
            (set! rdi 1936)
            (set! r15 L.rp.38)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.39
          (begin
            (set! rsi 80)
            (set! rdi 344)
            (set! r15 L.rp.39)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.40)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.41
          (begin
            (set! rsi 1656)
            (set! rdi 1728)
            (set! r15 L.rp.41)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.42
          (begin
            (set! rsi 1408)
            (set! rdi 1040)
            (set! r15 L.rp.42)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.43)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.44
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.44)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.45
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.45)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.46
          (begin (set! r15 L.rp.46) (jump L.fun/void143923.9)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.47
          (begin (set! r15 L.rp.47) (jump L.fun/void143925.10)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/error143927.4)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.49
          (begin
            (set! rsi 1064)
            (set! rdi 464)
            (set! r15 L.rp.49)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.50
          (begin
            (set! rsi 1200)
            (set! rdi 664)
            (set! r15 L.rp.50)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.51
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.51)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.52
          (begin
            (set! rsi 848)
            (set! rdi 1152)
            (set! r15 L.rp.52)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.53
          (begin
            (set! rsi 1976)
            (set! rdi 448)
            (set! r15 L.rp.53)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.54
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.54)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.55
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.55)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.56
          (begin
            (set! rsi 128)
            (set! rdi 16)
            (set! r15 L.rp.56)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.57
          (begin
            (set! rsi 88)
            (set! rdi 1704)
            (set! r15 L.rp.57)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.58
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.58)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.59
          (begin
            (set! rsi 472)
            (set! rdi 1280)
            (set! r15 L.rp.59)
            (jump L.*.14)))
        (set! rbp (+ rbp 176)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.60
          (begin
            (set! rsi 752)
            (set! rdi 472)
            (set! r15 L.rp.60)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.61
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.61)
            (jump L.-.15)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.62
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.62)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 176))
        (return-point L.rp.63
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.63)
            (jump L.+.13)))
        (set! rbp (+ rbp 176)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char143929.5))))
