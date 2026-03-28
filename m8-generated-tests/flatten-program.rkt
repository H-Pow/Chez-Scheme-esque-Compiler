#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         "../flatten-program.rkt")
(define (fail-if-invalid p)
  (when (not (para-asm-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "para-asm-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-block-asm-lang-v8 p)
  (interp-para-asm-lang-v8 (fail-if-invalid (flatten-program p)))))

(check-by-interp
 '(module
    (define L.__main.5 (begin (set! r15 r15) (set! rax 840) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.5 (begin (set! r15 r15) (set! rax 26942) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.7
      (begin (set! r15 r15) (set! r14 14) (jump L.__nested.5)))
    (define L.__nested.5 (begin (set! rax 17214) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.5
      (begin (set! r15 r15) (set! r14 28478) (set! rax 1128) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty8385.4)))
    (define L.fun/empty8385.4
      (begin (set! r15 r15) (set! rax 22) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.7
      (begin (set! r15 r15) (set! r14 14) (jump L.__nested.5)))
    (define L.__nested.5 (begin (set! rax 25390) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.7
      (begin (set! r15 r15) (set! r14 14) (jump L.__nested.5)))
    (define L.__nested.5 (begin (set! rax 50238) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.9
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! rdi 25390)
        (set! r15 L.rp.7)
        (jump L.fun/fixnum8420.4)))
    (define L.-.6
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.17) (jump L.tmp.18))))
    (define L.tmp.17 (begin (set! r9 14) (jump L.tmp.19)))
    (define L.tmp.18 (begin (set! r9 6) (jump L.tmp.19)))
    (define L.tmp.19 (if (!= r9 6) (jump L.__nested.10) (jump L.__nested.11)))
    (define L.tmp.14 (begin (set! r9 14) (jump L.tmp.16)))
    (define L.tmp.15 (begin (set! r9 6) (jump L.tmp.16)))
    (define L.tmp.16 (if (!= r9 6) (jump L.__nested.12) (jump L.__nested.13)))
    (define L.__nested.12
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.13 (begin (set! rax 830) (jump r15)))
    (define L.__nested.10
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.14) (jump L.tmp.15))))
    (define L.__nested.11 (begin (set! rax 830) (jump r15)))
    (define L.fun/fixnum8420.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 400) (jump r15)))
    (define L.rp.7
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! rsi 2024)
        (set! rdi 168)
        (set! r15 L.rp.8)
        (jump L.-.6)))
    (define L.rp.8
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.-.6)))))
(check-by-interp
 '(module
    (define L.__main.7
      (begin (set! r15 r15) (set! r14 14) (jump L.__nested.5)))
    (define L.__nested.5 (begin (set! rax 61502) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.8
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! rdi 22)
        (set! r15 L.rp.7)
        (jump L.fun/ascii-char8428.4)))
    (define L.fun/ascii-char8428.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 25390) (jump r15)))
    (define L.fun/empty8427.5
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 22) (jump r15)))
    (define L.rp.7
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rdi r15)
        (set! r15 (rbp - 0))
        (jump L.fun/empty8427.5)))))
(check-by-interp
 '(module
    (define L.__main.10 (begin (set! r15 r15) (set! r14 14) (jump L.tmp.8)))
    (define L.fun/ascii-char8442.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 25390)
        (jump r15)))
    (define L.tmp.8 (begin (set! r14 14) (jump L.__nested.6)))
    (define L.__nested.6
      (begin
        (set! rsi 22)
        (set! rdi 25390)
        (set! r15 r15)
        (jump L.fun/ascii-char8442.4)))))
(check-by-interp
 '(module
    (define L.__main.12
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! rsi 272)
        (set! rdi 1856)
        (set! r15 L.rp.9)
        (jump L.*.8)))
    (define L.*.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.20) (jump L.tmp.21))))
    (define L.tmp.20 (begin (set! r9 14) (jump L.tmp.22)))
    (define L.tmp.21 (begin (set! r9 6) (jump L.tmp.22)))
    (define L.tmp.22 (if (!= r9 6) (jump L.__nested.13) (jump L.__nested.14)))
    (define L.tmp.17 (begin (set! r9 14) (jump L.tmp.19)))
    (define L.tmp.18 (begin (set! r9 6) (jump L.tmp.19)))
    (define L.tmp.19 (if (!= r9 6) (jump L.__nested.15) (jump L.__nested.16)))
    (define L.__nested.15
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.16 (begin (set! rax 318) (jump r15)))
    (define L.__nested.13
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.17) (jump L.tmp.18))))
    (define L.__nested.14 (begin (set! rax 318) (jump r15)))
    (define L.fun/ascii-char8498.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void8499.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty8500.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.10)
        (jump L.fun/ascii-char8498.4)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.11)
        (jump L.fun/void8499.5)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/empty8500.6)))))
(check-by-interp
 '(module
    (define L.__main.11
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.8)
        (jump L.fun/empty8553.4)))
    (define L.-.7
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.19) (jump L.tmp.20))))
    (define L.tmp.19 (begin (set! r9 14) (jump L.tmp.21)))
    (define L.tmp.20 (begin (set! r9 6) (jump L.tmp.21)))
    (define L.tmp.21 (if (!= r9 6) (jump L.__nested.12) (jump L.__nested.13)))
    (define L.tmp.16 (begin (set! r9 14) (jump L.tmp.18)))
    (define L.tmp.17 (begin (set! r9 6) (jump L.tmp.18)))
    (define L.tmp.18 (if (!= r9 6) (jump L.__nested.14) (jump L.__nested.15)))
    (define L.__nested.14
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.15 (begin (set! rax 830) (jump r15)))
    (define L.__nested.12
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.16) (jump L.tmp.17))))
    (define L.__nested.13 (begin (set! rax 830) (jump r15)))
    (define L.fun/empty8553.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error8554.5
      (begin (set! r15 r15) (set! rax 43326) (jump r15)))
    (define L.rp.8
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.9)
        (jump L.fun/error8554.5)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! rsi 144)
        (set! rdi 1768)
        (set! r15 L.rp.10)
        (jump L.-.7)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.12
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! rsi 25390)
        (set! rdi 22)
        (set! r15 L.rp.7)
        (jump L.fun/boolean8597.4)))
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
    (define L.rp.7
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (if (!= r15 6) (jump L.__nested.8) (jump L.__nested.9))))
    (define L.__nested.11 (begin (set! rax 25390) (jump (rbp - 0))))
    (define L.__nested.8 (begin (set! r15 6) (jump L.__nested.11)))
    (define L.__nested.9
      (begin
        (set! rsi 22)
        (set! rdi 624)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char8598.5)))))
(check-by-interp
 '(module
    (define L.__main.22
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! rdx 22)
        (set! rsi 25390)
        (set! rdi 2878)
        (set! r15 L.rp.10)
        (jump L.fun/boolean9201.7)))
    (define L.+.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.30) (jump L.tmp.31))))
    (define L.tmp.30 (begin (set! r9 14) (jump L.tmp.32)))
    (define L.tmp.31 (begin (set! r9 6) (jump L.tmp.32)))
    (define L.tmp.32 (if (!= r9 6) (jump L.__nested.23) (jump L.__nested.24)))
    (define L.tmp.27 (begin (set! r9 14) (jump L.tmp.29)))
    (define L.tmp.28 (begin (set! r9 6) (jump L.tmp.29)))
    (define L.tmp.29 (if (!= r9 6) (jump L.__nested.25) (jump L.__nested.26)))
    (define L.__nested.25
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.26 (begin (set! rax 574) (jump r15)))
    (define L.__nested.23
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.27) (jump L.tmp.28))))
    (define L.__nested.24 (begin (set! rax 574) (jump r15)))
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
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (if (!= r15 6) (jump L.tmp.19) (jump L.tmp.20))))
    (define L.rp.11
      (begin (set! rbp (+ rbp 16)) (set! (rbp - 8) rax) (jump L.tmp.21)))
    (define L.rp.12
      (begin (set! rbp (+ rbp 16)) (set! (rbp - 8) rax) (jump L.tmp.21)))
    (define L.tmp.19
      (begin
        (set! rbp (- rbp 16))
        (set! rdx 30)
        (set! rsi 22)
        (set! rdi 30)
        (set! r15 L.rp.11)
        (jump L.fun/fixnum9202.5)))
    (define L.tmp.20
      (begin
        (set! rbp (- rbp 16))
        (set! rdx 6)
        (set! rsi 6)
        (set! rdi 22)
        (set! r15 L.rp.12)
        (jump L.fun/fixnum9203.4)))
    (define L.tmp.21 (begin (set! r15 14) (jump L.tmp.17)))
    (define L.tmp.17 (begin (set! r15 6) (jump L.tmp.15)))
    (define L.rp.13
      (begin (set! rbp (+ rbp 16)) (set! r15 rax) (jump L.tmp.16)))
    (define L.tmp.15
      (begin
        (set! rbp (- rbp 16))
        (set! rdx 1776)
        (set! rsi 25390)
        (set! rdi 30)
        (set! r15 L.rp.13)
        (jump L.fun/fixnum9204.6)))
    (define L.tmp.16
      (begin
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.+.9)))))
(check-by-interp
 '(module
    (define L.__main.18
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! rsi 1800)
        (set! rdi 440)
        (set! r15 L.rp.12)
        (jump L.*.9)))
    (define L.-.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.26) (jump L.tmp.27))))
    (define L.tmp.26 (begin (set! r9 14) (jump L.tmp.28)))
    (define L.tmp.27 (begin (set! r9 6) (jump L.tmp.28)))
    (define L.tmp.28 (if (!= r9 6) (jump L.__nested.19) (jump L.__nested.20)))
    (define L.tmp.23 (begin (set! r9 14) (jump L.tmp.25)))
    (define L.tmp.24 (begin (set! r9 6) (jump L.tmp.25)))
    (define L.tmp.25 (if (!= r9 6) (jump L.__nested.21) (jump L.__nested.22)))
    (define L.__nested.21
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.22 (begin (set! rax 830) (jump r15)))
    (define L.__nested.19
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.23) (jump L.tmp.24))))
    (define L.__nested.20 (begin (set! rax 830) (jump r15)))
    (define L.+.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.36) (jump L.tmp.37))))
    (define L.tmp.36 (begin (set! r9 14) (jump L.tmp.38)))
    (define L.tmp.37 (begin (set! r9 6) (jump L.tmp.38)))
    (define L.tmp.38 (if (!= r9 6) (jump L.__nested.29) (jump L.__nested.30)))
    (define L.tmp.33 (begin (set! r9 14) (jump L.tmp.35)))
    (define L.tmp.34 (begin (set! r9 6) (jump L.tmp.35)))
    (define L.tmp.35 (if (!= r9 6) (jump L.__nested.31) (jump L.__nested.32)))
    (define L.__nested.31
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.32 (begin (set! rax 574) (jump r15)))
    (define L.__nested.29
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.33) (jump L.tmp.34))))
    (define L.__nested.30 (begin (set! rax 574) (jump r15)))
    (define L.*.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.39) (jump L.__nested.40)))
    (define L.tmp.43 (begin (set! r9 14) (jump L.tmp.45)))
    (define L.tmp.44 (begin (set! r9 6) (jump L.tmp.45)))
    (define L.tmp.45 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.__nested.41
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.42 (begin (set! rax 318) (jump r15)))
    (define L.__nested.39
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.43) (jump L.tmp.44))))
    (define L.__nested.40 (begin (set! rax 318) (jump r15)))
    (define L.fun/ascii-char9328.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void9330.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error9331.6
      (begin (set! r15 r15) (set! rax 27198) (jump r15)))
    (define L.fun/ascii-char9329.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! rsi 224)
        (set! rdi 416)
        (set! r15 L.rp.13)
        (jump L.+.10)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! rsi r15)
        (set! rdi (rbp - -8))
        (set! r15 L.rp.14)
        (jump L.-.11)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.15)
        (jump L.fun/ascii-char9328.4)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.16)
        (jump L.fun/ascii-char9329.7)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.17)
        (jump L.fun/void9330.5)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error9331.6)))))
(check-by-interp
 '(module
    (define L.__main.19
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 32))
        (set! rsi 1608)
        (set! rdi 1200)
        (set! r15 L.rp.9)
        (jump L.-.7)))
    (define L.*.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.27) (jump L.tmp.28))))
    (define L.tmp.27 (begin (set! r9 14) (jump L.tmp.29)))
    (define L.tmp.28 (begin (set! r9 6) (jump L.tmp.29)))
    (define L.tmp.29 (if (!= r9 6) (jump L.__nested.20) (jump L.__nested.21)))
    (define L.tmp.24 (begin (set! r9 14) (jump L.tmp.26)))
    (define L.tmp.25 (begin (set! r9 6) (jump L.tmp.26)))
    (define L.tmp.26 (if (!= r9 6) (jump L.__nested.22) (jump L.__nested.23)))
    (define L.__nested.22
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.23 (begin (set! rax 318) (jump r15)))
    (define L.__nested.20
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.24) (jump L.tmp.25))))
    (define L.__nested.21 (begin (set! rax 318) (jump r15)))
    (define L.-.7
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.37) (jump L.tmp.38))))
    (define L.tmp.37 (begin (set! r9 14) (jump L.tmp.39)))
    (define L.tmp.38 (begin (set! r9 6) (jump L.tmp.39)))
    (define L.tmp.39 (if (!= r9 6) (jump L.__nested.30) (jump L.__nested.31)))
    (define L.tmp.34 (begin (set! r9 14) (jump L.tmp.36)))
    (define L.tmp.35 (begin (set! r9 6) (jump L.tmp.36)))
    (define L.tmp.36 (if (!= r9 6) (jump L.__nested.32) (jump L.__nested.33)))
    (define L.__nested.32
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.33 (begin (set! rax 830) (jump r15)))
    (define L.__nested.30
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.34) (jump L.tmp.35))))
    (define L.__nested.31 (begin (set! rax 830) (jump r15)))
    (define L.fun/ascii-char9350.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error9349.5
      (begin (set! r15 r15) (set! rax 34878) (jump r15)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 936)
        (set! rdi 760)
        (set! r15 L.rp.10)
        (jump L.-.7)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.11)
        (jump L.-.7)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi 856)
        (set! rdi 1024)
        (set! r15 L.rp.12)
        (jump L.*.8)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 776)
        (set! rdi 712)
        (set! r15 L.rp.13)
        (jump L.*.8)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.14)
        (jump L.-.7)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.15)
        (jump L.fun/error9349.5)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi 32)
        (set! rdi 1064)
        (set! r15 L.rp.16)
        (jump L.-.7)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1200)
        (set! rdi 1088)
        (set! r15 L.rp.17)
        (jump L.-.7)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.18)
        (jump L.*.8)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char9350.4)))))
(check-by-interp
 '(module
    (define L.__main.17
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.11)
        (jump L.fun/void9461.6)))
    (define L.-.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.25) (jump L.tmp.26))))
    (define L.tmp.25 (begin (set! r9 14) (jump L.tmp.27)))
    (define L.tmp.26 (begin (set! r9 6) (jump L.tmp.27)))
    (define L.tmp.27 (if (!= r9 6) (jump L.__nested.18) (jump L.__nested.19)))
    (define L.tmp.22 (begin (set! r9 14) (jump L.tmp.24)))
    (define L.tmp.23 (begin (set! r9 6) (jump L.tmp.24)))
    (define L.tmp.24 (if (!= r9 6) (jump L.__nested.20) (jump L.__nested.21)))
    (define L.__nested.20
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.21 (begin (set! rax 830) (jump r15)))
    (define L.__nested.18
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.22) (jump L.tmp.23))))
    (define L.__nested.19 (begin (set! rax 830) (jump r15)))
    (define L.*.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.35) (jump L.tmp.36))))
    (define L.tmp.35 (begin (set! r9 14) (jump L.tmp.37)))
    (define L.tmp.36 (begin (set! r9 6) (jump L.tmp.37)))
    (define L.tmp.37 (if (!= r9 6) (jump L.__nested.28) (jump L.__nested.29)))
    (define L.tmp.32 (begin (set! r9 14) (jump L.tmp.34)))
    (define L.tmp.33 (begin (set! r9 6) (jump L.tmp.34)))
    (define L.tmp.34 (if (!= r9 6) (jump L.__nested.30) (jump L.__nested.31)))
    (define L.__nested.30
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.31 (begin (set! rax 318) (jump r15)))
    (define L.__nested.28
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.32) (jump L.tmp.33))))
    (define L.__nested.29 (begin (set! rax 318) (jump r15)))
    (define L.+.8
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.45) (jump L.tmp.46))))
    (define L.tmp.45 (begin (set! r9 14) (jump L.tmp.47)))
    (define L.tmp.46 (begin (set! r9 6) (jump L.tmp.47)))
    (define L.tmp.47 (if (!= r9 6) (jump L.__nested.38) (jump L.__nested.39)))
    (define L.tmp.42 (begin (set! r9 14) (jump L.tmp.44)))
    (define L.tmp.43 (begin (set! r9 6) (jump L.tmp.44)))
    (define L.tmp.44 (if (!= r9 6) (jump L.__nested.40) (jump L.__nested.41)))
    (define L.__nested.40
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.41 (begin (set! rax 574) (jump r15)))
    (define L.__nested.38
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.42) (jump L.tmp.43))))
    (define L.__nested.39 (begin (set! rax 574) (jump r15)))
    (define L.fun/empty9463.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty9462.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void9461.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 24))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 24))
        (set! rsi 1440)
        (set! rdi 1464)
        (set! r15 L.rp.12)
        (jump L.+.8)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 24))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 24))
        (set! rsi 944)
        (set! rdi 1904)
        (set! r15 L.rp.13)
        (jump L.*.9)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.14)
        (jump L.-.10)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.15)
        (jump L.fun/empty9462.5)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.16)
        (jump L.fun/empty9463.4)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rax (rbp - 16))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.13
      (begin
        (set! (rbp - 0) r15)
        (set! r15 1064)
        (set! r15 22)
        (set! r15 680)
        (set! r15 28222)
        (set! r15 6)
        (jump L.__nested.9)))
    (define L.-.6
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.21) (jump L.tmp.22))))
    (define L.tmp.21 (begin (set! r9 14) (jump L.tmp.23)))
    (define L.tmp.22 (begin (set! r9 6) (jump L.tmp.23)))
    (define L.tmp.23 (if (!= r9 6) (jump L.__nested.14) (jump L.__nested.15)))
    (define L.tmp.18 (begin (set! r9 14) (jump L.tmp.20)))
    (define L.tmp.19 (begin (set! r9 6) (jump L.tmp.20)))
    (define L.tmp.20 (if (!= r9 6) (jump L.__nested.16) (jump L.__nested.17)))
    (define L.__nested.16
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.17 (begin (set! rax 830) (jump r15)))
    (define L.__nested.14
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.18) (jump L.tmp.19))))
    (define L.__nested.15 (begin (set! rax 830) (jump r15)))
    (define L.fun/ascii-char9530.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 25390)
        (jump r15)))
    (define L.rp.7
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! r14 14)
        (jump L.tmp.10)))
    (define L.tmp.10 (begin (set! r14 30) (jump L.tmp.12)))
    (define L.tmp.12
      (begin
        (set! rdx r14)
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char9530.4)))
    (define L.__nested.9
      (begin
        (set! r15 25390)
        (set! r15 1560)
        (set! r15 22)
        (set! r15 30)
        (set! rax 25390)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.13 (begin (set! r15 r15) (set! r14 14) (jump L.tmp.11)))
    (define L.tmp.11 (begin (set! r14 6) (jump L.__nested.6)))
    (define L.__nested.8 (begin (set! rax 42046) (jump r15)))
    (define L.__nested.9 (begin (set! rax 33598) (jump r15)))
    (define L.__nested.5 (begin (set! r14 6) (jump L.__nested.8)))
    (define L.__nested.6 (begin (set! r14 14) (jump L.__nested.9)))))
(check-by-interp
 '(module
    (define L.__main.16
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.10)
        (jump L.fun/empty9593.6)))
    (define L.*.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.24) (jump L.tmp.25))))
    (define L.tmp.24 (begin (set! r9 14) (jump L.tmp.26)))
    (define L.tmp.25 (begin (set! r9 6) (jump L.tmp.26)))
    (define L.tmp.26 (if (!= r9 6) (jump L.__nested.17) (jump L.__nested.18)))
    (define L.tmp.21 (begin (set! r9 14) (jump L.tmp.23)))
    (define L.tmp.22 (begin (set! r9 6) (jump L.tmp.23)))
    (define L.tmp.23 (if (!= r9 6) (jump L.__nested.19) (jump L.__nested.20)))
    (define L.__nested.19
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.20 (begin (set! rax 318) (jump r15)))
    (define L.__nested.17
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.21) (jump L.tmp.22))))
    (define L.__nested.18 (begin (set! rax 318) (jump r15)))
    (define L.-.8
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.34) (jump L.tmp.35))))
    (define L.tmp.34 (begin (set! r9 14) (jump L.tmp.36)))
    (define L.tmp.35 (begin (set! r9 6) (jump L.tmp.36)))
    (define L.tmp.36 (if (!= r9 6) (jump L.__nested.27) (jump L.__nested.28)))
    (define L.tmp.31 (begin (set! r9 14) (jump L.tmp.33)))
    (define L.tmp.32 (begin (set! r9 6) (jump L.tmp.33)))
    (define L.tmp.33 (if (!= r9 6) (jump L.__nested.29) (jump L.__nested.30)))
    (define L.__nested.29
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.30 (begin (set! rax 830) (jump r15)))
    (define L.__nested.27
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.31) (jump L.tmp.32))))
    (define L.__nested.28 (begin (set! rax 830) (jump r15)))
    (define L.fun/error9595.4
      (begin (set! r15 r15) (set! rax 9022) (jump r15)))
    (define L.fun/void9594.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty9593.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.11)
        (jump L.fun/void9594.5)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 24))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.12)
        (jump L.fun/error9595.4)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rsi 1392)
        (set! rdi 1368)
        (set! r15 L.rp.13)
        (jump L.-.8)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 24))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 24))
        (set! rsi 400)
        (set! rdi 1288)
        (set! r15 L.rp.14)
        (jump L.*.9)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rsi r15)
        (set! rdi (rbp - -8))
        (set! r15 L.rp.15)
        (jump L.*.9)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.16
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.11)
        (jump L.fun/error9646.5)))
    (define L.void?.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 30) (jump L.__nested.17) (jump L.__nested.18))))
    (define L.__nested.17 (begin (set! rax 14) (jump r15)))
    (define L.__nested.18 (begin (set! rax 6) (jump r15)))
    (define L.fun/error9648.4
      (begin (set! r15 r15) (set! rax 2622) (jump r15)))
    (define L.fun/error9646.5
      (begin (set! r15 r15) (set! rax 58430) (jump r15)))
    (define L.fun/any9647.6 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/error9649.7
      (begin (set! r15 r15) (set! rax 28222) (jump r15)))
    (define L.fun/void9650.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.12)
        (jump L.fun/any9647.6)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! rdi r15)
        (set! r15 L.rp.13)
        (jump L.void?.10)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.14)
        (jump L.fun/error9648.4)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.15)
        (jump L.fun/error9649.7)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/void9650.8)))))
(check-by-interp
 '(module
    (define L.__main.17
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.11)
        (jump L.fun/ascii-char10693.5)))
    (define L.ascii-char?.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 46) (jump L.__nested.18) (jump L.__nested.19))))
    (define L.__nested.18 (begin (set! rax 14) (jump r15)))
    (define L.__nested.19 (begin (set! rax 6) (jump r15)))
    (define L.fun/error10696.4
      (begin (set! r15 r15) (set! rax 55102) (jump r15)))
    (define L.fun/ascii-char10693.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void10697.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any10694.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void10695.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.12)
        (jump L.fun/any10694.7)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! rdi r15)
        (set! r15 L.rp.13)
        (jump L.ascii-char?.10)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.14)
        (jump L.fun/void10695.8)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.15)
        (jump L.fun/error10696.4)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.16)
        (jump L.fun/void10697.6)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.15
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.10)
        (jump L.fun/error12159.5)))
    (define L.fun/empty12161.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error12159.5
      (begin (set! r15 r15) (set! rax 1854) (jump r15)))
    (define L.fun/ascii-char12162.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error12163.7
      (begin (set! r15 r15) (set! rax 10814) (jump r15)))
    (define L.fun/error12160.8
      (begin (set! r15 r15) (set! rax 27198) (jump r15)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.11)
        (jump L.fun/error12160.8)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.12)
        (jump L.fun/empty12161.4)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.13)
        (jump L.fun/ascii-char12162.6)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.14)
        (jump L.fun/error12163.7)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.25
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.13)
        (jump L.fun/void12536.4)))
    (define L.-.12
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.33) (jump L.tmp.34))))
    (define L.tmp.33 (begin (set! r9 14) (jump L.tmp.35)))
    (define L.tmp.34 (begin (set! r9 6) (jump L.tmp.35)))
    (define L.tmp.35 (if (!= r9 6) (jump L.__nested.26) (jump L.__nested.27)))
    (define L.tmp.30 (begin (set! r9 14) (jump L.tmp.32)))
    (define L.tmp.31 (begin (set! r9 6) (jump L.tmp.32)))
    (define L.tmp.32 (if (!= r9 6) (jump L.__nested.28) (jump L.__nested.29)))
    (define L.__nested.28
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.29 (begin (set! rax 830) (jump r15)))
    (define L.__nested.26
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.30) (jump L.tmp.31))))
    (define L.__nested.27 (begin (set! rax 830) (jump r15)))
    (define L.+.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.43) (jump L.tmp.44))))
    (define L.tmp.43 (begin (set! r9 14) (jump L.tmp.45)))
    (define L.tmp.44 (begin (set! r9 6) (jump L.tmp.45)))
    (define L.tmp.45 (if (!= r9 6) (jump L.__nested.36) (jump L.__nested.37)))
    (define L.tmp.40 (begin (set! r9 14) (jump L.tmp.42)))
    (define L.tmp.41 (begin (set! r9 6) (jump L.tmp.42)))
    (define L.tmp.42 (if (!= r9 6) (jump L.__nested.38) (jump L.__nested.39)))
    (define L.__nested.38
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.39 (begin (set! rax 574) (jump r15)))
    (define L.__nested.36
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.40) (jump L.tmp.41))))
    (define L.__nested.37 (begin (set! rax 574) (jump r15)))
    (define L.*.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.53) (jump L.tmp.54))))
    (define L.tmp.53 (begin (set! r9 14) (jump L.tmp.55)))
    (define L.tmp.54 (begin (set! r9 6) (jump L.tmp.55)))
    (define L.tmp.55 (if (!= r9 6) (jump L.__nested.46) (jump L.__nested.47)))
    (define L.tmp.50 (begin (set! r9 14) (jump L.tmp.52)))
    (define L.tmp.51 (begin (set! r9 6) (jump L.tmp.52)))
    (define L.tmp.52 (if (!= r9 6) (jump L.__nested.48) (jump L.__nested.49)))
    (define L.__nested.48
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.49 (begin (set! rax 318) (jump r15)))
    (define L.__nested.46
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.50) (jump L.tmp.51))))
    (define L.__nested.47 (begin (set! rax 318) (jump r15)))
    (define L.empty?.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 22) (jump L.__nested.56) (jump L.__nested.57))))
    (define L.__nested.56 (begin (set! rax 14) (jump r15)))
    (define L.__nested.57 (begin (set! rax 6) (jump r15)))
    (define L.fun/void12536.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any12537.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error12539.6
      (begin (set! r15 r15) (set! rax 29502) (jump r15)))
    (define L.fun/error12538.7
      (begin (set! r15 r15) (set! rax 24894) (jump r15)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.14)
        (jump L.fun/any12537.5)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rdi r15)
        (set! r15 L.rp.15)
        (jump L.empty?.9)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi 384)
        (set! rdi 784)
        (set! r15 L.rp.16)
        (jump L.*.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 912)
        (set! rdi 104)
        (set! r15 L.rp.17)
        (jump L.+.11)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.18)
        (jump L.+.11)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1288)
        (set! rdi 1776)
        (set! r15 L.rp.19)
        (jump L.-.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 32))
        (set! rsi 760)
        (set! rdi 792)
        (set! r15 L.rp.20)
        (jump L.*.10)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.21)
        (jump L.-.12)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.22)
        (jump L.-.12)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.23)
        (jump L.fun/error12538.7)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.24)
        (jump L.fun/error12539.6)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.31
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 56))
        (set! rsi 1576)
        (set! rdi 1360)
        (set! r15 L.rp.13)
        (jump L.*.9)))
    (define L.pair?.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 1) (jump L.__nested.32) (jump L.__nested.33))))
    (define L.__nested.32 (begin (set! rax 14) (jump r15)))
    (define L.__nested.33 (begin (set! rax 6) (jump r15)))
    (define L.+.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.41) (jump L.tmp.42))))
    (define L.tmp.41 (begin (set! r9 14) (jump L.tmp.43)))
    (define L.tmp.42 (begin (set! r9 6) (jump L.tmp.43)))
    (define L.tmp.43 (if (!= r9 6) (jump L.__nested.34) (jump L.__nested.35)))
    (define L.tmp.38 (begin (set! r9 14) (jump L.tmp.40)))
    (define L.tmp.39 (begin (set! r9 6) (jump L.tmp.40)))
    (define L.tmp.40 (if (!= r9 6) (jump L.__nested.36) (jump L.__nested.37)))
    (define L.__nested.36
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.37 (begin (set! rax 574) (jump r15)))
    (define L.__nested.34
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.38) (jump L.tmp.39))))
    (define L.__nested.35 (begin (set! rax 574) (jump r15)))
    (define L.-.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.51) (jump L.tmp.52))))
    (define L.tmp.51 (begin (set! r9 14) (jump L.tmp.53)))
    (define L.tmp.52 (begin (set! r9 6) (jump L.tmp.53)))
    (define L.tmp.53 (if (!= r9 6) (jump L.__nested.44) (jump L.__nested.45)))
    (define L.tmp.48 (begin (set! r9 14) (jump L.tmp.50)))
    (define L.tmp.49 (begin (set! r9 6) (jump L.tmp.50)))
    (define L.tmp.50 (if (!= r9 6) (jump L.__nested.46) (jump L.__nested.47)))
    (define L.__nested.46
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.47 (begin (set! rax 830) (jump r15)))
    (define L.__nested.44
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.48) (jump L.tmp.49))))
    (define L.__nested.45 (begin (set! rax 830) (jump r15)))
    (define L.*.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.61) (jump L.tmp.62))))
    (define L.tmp.61 (begin (set! r9 14) (jump L.tmp.63)))
    (define L.tmp.62 (begin (set! r9 6) (jump L.tmp.63)))
    (define L.tmp.63 (if (!= r9 6) (jump L.__nested.54) (jump L.__nested.55)))
    (define L.tmp.58 (begin (set! r9 14) (jump L.tmp.60)))
    (define L.tmp.59 (begin (set! r9 6) (jump L.tmp.60)))
    (define L.tmp.60 (if (!= r9 6) (jump L.__nested.56) (jump L.__nested.57)))
    (define L.__nested.56
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.57 (begin (set! rax 318) (jump r15)))
    (define L.__nested.54
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.58) (jump L.tmp.59))))
    (define L.__nested.55 (begin (set! rax 318) (jump r15)))
    (define L.fun/any13289.4 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/empty13290.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error13288.6
      (begin (set! r15 r15) (set! rax 48958) (jump r15)))
    (define L.fun/ascii-char13291.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 296)
        (set! rdi 1888)
        (set! r15 L.rp.14)
        (jump L.-.10)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.15)
        (jump L.-.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1808)
        (set! rdi 1880)
        (set! r15 L.rp.16)
        (jump L.-.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 704)
        (set! rdi 2008)
        (set! r15 L.rp.17)
        (jump L.*.9)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.18)
        (jump L.-.10)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.19)
        (jump L.+.11)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.20)
        (jump L.fun/error13288.6)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi 1192)
        (set! rdi 1488)
        (set! r15 L.rp.21)
        (jump L.-.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1480)
        (set! rdi 1160)
        (set! r15 L.rp.22)
        (jump L.-.10)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.23)
        (jump L.-.10)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1240)
        (set! rdi 24)
        (set! r15 L.rp.24)
        (jump L.*.9)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1752)
        (set! rdi 1808)
        (set! r15 L.rp.25)
        (jump L.+.11)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.26)
        (jump L.*.9)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.27)
        (jump L.-.10)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.28)
        (jump L.fun/any13289.4)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rdi r15)
        (set! r15 L.rp.29)
        (jump L.pair?.12)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.30)
        (jump L.fun/empty13290.5)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char13291.7)))))
(check-by-interp
 '(module
    (define L.__main.25
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.13)
        (jump L.fun/ascii-char13294.4)))
    (define L.fixnum?.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 0) (jump L.__nested.26) (jump L.__nested.27))))
    (define L.__nested.26 (begin (set! rax 14) (jump r15)))
    (define L.__nested.27 (begin (set! rax 6) (jump r15)))
    (define L.+.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.35) (jump L.tmp.36))))
    (define L.tmp.35 (begin (set! r9 14) (jump L.tmp.37)))
    (define L.tmp.36 (begin (set! r9 6) (jump L.tmp.37)))
    (define L.tmp.37 (if (!= r9 6) (jump L.__nested.28) (jump L.__nested.29)))
    (define L.tmp.32 (begin (set! r9 14) (jump L.tmp.34)))
    (define L.tmp.33 (begin (set! r9 6) (jump L.tmp.34)))
    (define L.tmp.34 (if (!= r9 6) (jump L.__nested.30) (jump L.__nested.31)))
    (define L.__nested.30
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.31 (begin (set! rax 574) (jump r15)))
    (define L.__nested.28
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.32) (jump L.tmp.33))))
    (define L.__nested.29 (begin (set! rax 574) (jump r15)))
    (define L.*.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.45) (jump L.tmp.46))))
    (define L.tmp.45 (begin (set! r9 14) (jump L.tmp.47)))
    (define L.tmp.46 (begin (set! r9 6) (jump L.tmp.47)))
    (define L.tmp.47 (if (!= r9 6) (jump L.__nested.38) (jump L.__nested.39)))
    (define L.tmp.42 (begin (set! r9 14) (jump L.tmp.44)))
    (define L.tmp.43 (begin (set! r9 6) (jump L.tmp.44)))
    (define L.tmp.44 (if (!= r9 6) (jump L.__nested.40) (jump L.__nested.41)))
    (define L.__nested.40
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.41 (begin (set! rax 318) (jump r15)))
    (define L.__nested.38
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.42) (jump L.tmp.43))))
    (define L.__nested.39 (begin (set! rax 318) (jump r15)))
    (define L.-.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.55) (jump L.tmp.56))))
    (define L.tmp.55 (begin (set! r9 14) (jump L.tmp.57)))
    (define L.tmp.56 (begin (set! r9 6) (jump L.tmp.57)))
    (define L.tmp.57 (if (!= r9 6) (jump L.__nested.48) (jump L.__nested.49)))
    (define L.tmp.52 (begin (set! r9 14) (jump L.tmp.54)))
    (define L.tmp.53 (begin (set! r9 6) (jump L.tmp.54)))
    (define L.tmp.54 (if (!= r9 6) (jump L.__nested.50) (jump L.__nested.51)))
    (define L.__nested.50
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.51 (begin (set! rax 830) (jump r15)))
    (define L.__nested.48
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.52) (jump L.tmp.53))))
    (define L.__nested.49 (begin (set! rax 830) (jump r15)))
    (define L.fun/ascii-char13294.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any13295.5 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/error13297.6
      (begin (set! r15 r15) (set! rax 46910) (jump r15)))
    (define L.fun/ascii-char13296.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 40))
        (set! rsi 920)
        (set! rdi 272)
        (set! r15 L.rp.14)
        (jump L.-.9)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! rsi 1528)
        (set! rdi 1312)
        (set! r15 L.rp.15)
        (jump L.*.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -32))
        (set! r15 L.rp.16)
        (jump L.-.9)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! rsi 608)
        (set! rdi 928)
        (set! r15 L.rp.17)
        (jump L.+.11)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 1288)
        (set! rdi 224)
        (set! r15 L.rp.18)
        (jump L.-.9)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.19)
        (jump L.+.11)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -32))
        (set! r15 L.rp.20)
        (jump L.+.11)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.21)
        (jump L.fun/any13295.5)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rdi r15)
        (set! r15 L.rp.22)
        (jump L.fixnum?.12)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.23)
        (jump L.fun/ascii-char13296.7)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.24)
        (jump L.fun/error13297.6)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rax (rbp - 24))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.17
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.11)
        (jump L.fun/ascii-char13915.8)))
    (define L.ascii-char?.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 46) (jump L.__nested.18) (jump L.__nested.19))))
    (define L.__nested.18 (begin (set! rax 14) (jump r15)))
    (define L.__nested.19 (begin (set! rax 6) (jump r15)))
    (define L.fun/ascii-char13919.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error13917.5
      (begin (set! r15 r15) (set! rax 34878) (jump r15)))
    (define L.fun/any13918.6 (begin (set! r15 r15) (set! rax 14) (jump r15)))
    (define L.fun/void13916.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char13915.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.12)
        (jump L.fun/void13916.7)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.13)
        (jump L.fun/error13917.5)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.14)
        (jump L.fun/any13918.6)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! rdi r15)
        (set! r15 L.rp.15)
        (jump L.ascii-char?.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.16)
        (jump L.fun/ascii-char13919.4)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.28
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.11)
        (jump L.fun/ascii-char14257.5)))
    (define L.+.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.36) (jump L.tmp.37))))
    (define L.tmp.36 (begin (set! r9 14) (jump L.tmp.38)))
    (define L.tmp.37 (begin (set! r9 6) (jump L.tmp.38)))
    (define L.tmp.38 (if (!= r9 6) (jump L.__nested.29) (jump L.__nested.30)))
    (define L.tmp.33 (begin (set! r9 14) (jump L.tmp.35)))
    (define L.tmp.34 (begin (set! r9 6) (jump L.tmp.35)))
    (define L.tmp.35 (if (!= r9 6) (jump L.__nested.31) (jump L.__nested.32)))
    (define L.__nested.31
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.32 (begin (set! rax 574) (jump r15)))
    (define L.__nested.29
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.33) (jump L.tmp.34))))
    (define L.__nested.30 (begin (set! rax 574) (jump r15)))
    (define L.-.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.39) (jump L.__nested.40)))
    (define L.tmp.43 (begin (set! r9 14) (jump L.tmp.45)))
    (define L.tmp.44 (begin (set! r9 6) (jump L.tmp.45)))
    (define L.tmp.45 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.__nested.41
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.42 (begin (set! rax 830) (jump r15)))
    (define L.__nested.39
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.43) (jump L.tmp.44))))
    (define L.__nested.40 (begin (set! rax 830) (jump r15)))
    (define L.*.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.49) (jump L.__nested.50)))
    (define L.tmp.53 (begin (set! r9 14) (jump L.tmp.55)))
    (define L.tmp.54 (begin (set! r9 6) (jump L.tmp.55)))
    (define L.tmp.55 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.__nested.51
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.52 (begin (set! rax 318) (jump r15)))
    (define L.__nested.49
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.53) (jump L.tmp.54))))
    (define L.__nested.50 (begin (set! rax 318) (jump r15)))
    (define L.fun/empty14259.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char14257.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error14258.6
      (begin (set! r15 r15) (set! rax 21310) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 1776)
        (set! rdi 1648)
        (set! r15 L.rp.12)
        (jump L.*.8)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1328)
        (set! rdi 1808)
        (set! r15 L.rp.13)
        (jump L.*.8)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.14)
        (jump L.-.9)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1872)
        (set! rdi 1456)
        (set! r15 L.rp.15)
        (jump L.-.9)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 624)
        (set! rdi 432)
        (set! r15 L.rp.16)
        (jump L.+.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.17)
        (jump L.-.9)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.18)
        (jump L.*.8)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.19)
        (jump L.fun/error14258.6)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.20)
        (jump L.fun/empty14259.4)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 544)
        (set! rdi 1448)
        (set! r15 L.rp.21)
        (jump L.+.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1936)
        (set! rdi 504)
        (set! r15 L.rp.22)
        (jump L.+.10)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.23)
        (jump L.-.9)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 624)
        (set! rdi 832)
        (set! r15 L.rp.24)
        (jump L.*.8)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 256)
        (set! rdi 816)
        (set! r15 L.rp.25)
        (jump L.*.8)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.26)
        (jump L.+.10)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.27)
        (jump L.-.9)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.15
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.10)
        (jump L.fun/void15568.8)))
    (define L.fun/empty15571.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char15572.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char15569.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty15570.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void15568.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.11)
        (jump L.fun/ascii-char15569.6)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.12)
        (jump L.fun/empty15570.7)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.13)
        (jump L.fun/empty15571.4)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.14)
        (jump L.fun/ascii-char15572.5)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.13)
        (jump L.fun/ascii-char15704.4)))
    (define L.+.12
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.32) (jump L.tmp.33))))
    (define L.tmp.32 (begin (set! r9 14) (jump L.tmp.34)))
    (define L.tmp.33 (begin (set! r9 6) (jump L.tmp.34)))
    (define L.tmp.34 (if (!= r9 6) (jump L.__nested.25) (jump L.__nested.26)))
    (define L.tmp.29 (begin (set! r9 14) (jump L.tmp.31)))
    (define L.tmp.30 (begin (set! r9 6) (jump L.tmp.31)))
    (define L.tmp.31 (if (!= r9 6) (jump L.__nested.27) (jump L.__nested.28)))
    (define L.__nested.27
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.28 (begin (set! rax 574) (jump r15)))
    (define L.__nested.25
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.29) (jump L.tmp.30))))
    (define L.__nested.26 (begin (set! rax 574) (jump r15)))
    (define L.-.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.42) (jump L.tmp.43))))
    (define L.tmp.42 (begin (set! r9 14) (jump L.tmp.44)))
    (define L.tmp.43 (begin (set! r9 6) (jump L.tmp.44)))
    (define L.tmp.44 (if (!= r9 6) (jump L.__nested.35) (jump L.__nested.36)))
    (define L.tmp.39 (begin (set! r9 14) (jump L.tmp.41)))
    (define L.tmp.40 (begin (set! r9 6) (jump L.tmp.41)))
    (define L.tmp.41 (if (!= r9 6) (jump L.__nested.37) (jump L.__nested.38)))
    (define L.__nested.37
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.38 (begin (set! rax 830) (jump r15)))
    (define L.__nested.35
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.39) (jump L.tmp.40))))
    (define L.__nested.36 (begin (set! rax 830) (jump r15)))
    (define L.*.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.52) (jump L.tmp.53))))
    (define L.tmp.52 (begin (set! r9 14) (jump L.tmp.54)))
    (define L.tmp.53 (begin (set! r9 6) (jump L.tmp.54)))
    (define L.tmp.54 (if (!= r9 6) (jump L.__nested.45) (jump L.__nested.46)))
    (define L.tmp.49 (begin (set! r9 14) (jump L.tmp.51)))
    (define L.tmp.50 (begin (set! r9 6) (jump L.tmp.51)))
    (define L.tmp.51 (if (!= r9 6) (jump L.__nested.47) (jump L.__nested.48)))
    (define L.__nested.47
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.48 (begin (set! rax 318) (jump r15)))
    (define L.__nested.45
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.49) (jump L.tmp.50))))
    (define L.__nested.46 (begin (set! rax 318) (jump r15)))
    (define L.fun/ascii-char15704.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void15705.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char15707.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error15708.7
      (begin (set! r15 r15) (set! rax 36158) (jump r15)))
    (define L.fun/empty15706.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.14)
        (jump L.fun/void15705.5)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi 424)
        (set! rdi 1192)
        (set! r15 L.rp.15)
        (jump L.*.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1368)
        (set! rdi 1600)
        (set! r15 L.rp.16)
        (jump L.-.11)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.17)
        (jump L.*.10)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 32))
        (set! rsi 536)
        (set! rdi 1936)
        (set! r15 L.rp.18)
        (jump L.+.12)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1704)
        (set! rdi 112)
        (set! r15 L.rp.19)
        (jump L.*.10)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.20)
        (jump L.*.10)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.21)
        (jump L.*.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.22)
        (jump L.fun/empty15706.8)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.23)
        (jump L.fun/ascii-char15707.6)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error15708.7)))))
(check-by-interp
 '(module
    (define L.__main.27
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 32))
        (set! rsi 152)
        (set! rdi 1608)
        (set! r15 L.rp.14)
        (jump L.+.9)))
    (define L.empty?.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 22) (jump L.__nested.28) (jump L.__nested.29))))
    (define L.__nested.28 (begin (set! rax 14) (jump r15)))
    (define L.__nested.29 (begin (set! rax 6) (jump r15)))
    (define L.ascii-char?.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 46) (jump L.__nested.30) (jump L.__nested.31))))
    (define L.__nested.30 (begin (set! rax 14) (jump r15)))
    (define L.__nested.31 (begin (set! rax 6) (jump r15)))
    (define L.*.11
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.39) (jump L.tmp.40))))
    (define L.tmp.39 (begin (set! r9 14) (jump L.tmp.41)))
    (define L.tmp.40 (begin (set! r9 6) (jump L.tmp.41)))
    (define L.tmp.41 (if (!= r9 6) (jump L.__nested.32) (jump L.__nested.33)))
    (define L.tmp.36 (begin (set! r9 14) (jump L.tmp.38)))
    (define L.tmp.37 (begin (set! r9 6) (jump L.tmp.38)))
    (define L.tmp.38 (if (!= r9 6) (jump L.__nested.34) (jump L.__nested.35)))
    (define L.__nested.34
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.35 (begin (set! rax 318) (jump r15)))
    (define L.__nested.32
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.36) (jump L.tmp.37))))
    (define L.__nested.33 (begin (set! rax 318) (jump r15)))
    (define L.-.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.49) (jump L.tmp.50))))
    (define L.tmp.49 (begin (set! r9 14) (jump L.tmp.51)))
    (define L.tmp.50 (begin (set! r9 6) (jump L.tmp.51)))
    (define L.tmp.51 (if (!= r9 6) (jump L.__nested.42) (jump L.__nested.43)))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.44) (jump L.__nested.45)))
    (define L.__nested.44
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.45 (begin (set! rax 830) (jump r15)))
    (define L.__nested.42
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.__nested.43 (begin (set! rax 830) (jump r15)))
    (define L.+.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.59) (jump L.tmp.60))))
    (define L.tmp.59 (begin (set! r9 14) (jump L.tmp.61)))
    (define L.tmp.60 (begin (set! r9 6) (jump L.tmp.61)))
    (define L.tmp.61 (if (!= r9 6) (jump L.__nested.52) (jump L.__nested.53)))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.54) (jump L.__nested.55)))
    (define L.__nested.54
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.55 (begin (set! rax 574) (jump r15)))
    (define L.__nested.52
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.__nested.53 (begin (set! rax 574) (jump r15)))
    (define L.fun/void15911.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any15910.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any15908.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char15909.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 256)
        (set! rdi 1064)
        (set! r15 L.rp.15)
        (jump L.+.9)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.16)
        (jump L.+.9)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1016)
        (set! rdi 2032)
        (set! r15 L.rp.17)
        (jump L.-.10)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1496)
        (set! rdi 544)
        (set! r15 L.rp.18)
        (jump L.-.10)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.19)
        (jump L.-.10)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.20)
        (jump L.*.11)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.21)
        (jump L.fun/any15908.6)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rdi r15)
        (set! r15 L.rp.22)
        (jump L.ascii-char?.12)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.23)
        (jump L.fun/ascii-char15909.7)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.24)
        (jump L.fun/any15910.5)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rdi r15)
        (set! r15 L.rp.25)
        (jump L.empty?.13)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.26)
        (jump L.fun/void15911.4)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.15
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.10)
        (jump L.fun/ascii-char16255.5)))
    (define L.fun/error16257.4
      (begin (set! r15 r15) (set! rax 57150) (jump r15)))
    (define L.fun/ascii-char16255.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty16258.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty16256.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char16259.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.11)
        (jump L.fun/empty16256.7)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.12)
        (jump L.fun/error16257.4)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.13)
        (jump L.fun/empty16258.6)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.14)
        (jump L.fun/ascii-char16259.8)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.28
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.11)
        (jump L.fun/void17748.4)))
    (define L.-.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.36) (jump L.tmp.37))))
    (define L.tmp.36 (begin (set! r9 14) (jump L.tmp.38)))
    (define L.tmp.37 (begin (set! r9 6) (jump L.tmp.38)))
    (define L.tmp.38 (if (!= r9 6) (jump L.__nested.29) (jump L.__nested.30)))
    (define L.tmp.33 (begin (set! r9 14) (jump L.tmp.35)))
    (define L.tmp.34 (begin (set! r9 6) (jump L.tmp.35)))
    (define L.tmp.35 (if (!= r9 6) (jump L.__nested.31) (jump L.__nested.32)))
    (define L.__nested.31
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.32 (begin (set! rax 830) (jump r15)))
    (define L.__nested.29
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.33) (jump L.tmp.34))))
    (define L.__nested.30 (begin (set! rax 830) (jump r15)))
    (define L.+.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.39) (jump L.__nested.40)))
    (define L.tmp.43 (begin (set! r9 14) (jump L.tmp.45)))
    (define L.tmp.44 (begin (set! r9 6) (jump L.tmp.45)))
    (define L.tmp.45 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.__nested.41
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.42 (begin (set! rax 574) (jump r15)))
    (define L.__nested.39
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.43) (jump L.tmp.44))))
    (define L.__nested.40 (begin (set! rax 574) (jump r15)))
    (define L.*.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.49) (jump L.__nested.50)))
    (define L.tmp.53 (begin (set! r9 14) (jump L.tmp.55)))
    (define L.tmp.54 (begin (set! r9 6) (jump L.tmp.55)))
    (define L.tmp.55 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.__nested.51
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.52 (begin (set! rax 318) (jump r15)))
    (define L.__nested.49
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.53) (jump L.tmp.54))))
    (define L.__nested.50 (begin (set! rax 318) (jump r15)))
    (define L.fun/void17748.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char17750.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error17749.6
      (begin (set! r15 r15) (set! rax 36158) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1496)
        (set! rdi 2000)
        (set! r15 L.rp.12)
        (jump L.*.8)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 464)
        (set! rdi 1416)
        (set! r15 L.rp.13)
        (jump L.+.9)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.14)
        (jump L.+.9)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1352)
        (set! rdi 912)
        (set! r15 L.rp.15)
        (jump L.*.8)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1184)
        (set! rdi 1176)
        (set! r15 L.rp.16)
        (jump L.+.9)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.17)
        (jump L.+.9)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.18)
        (jump L.+.9)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.19)
        (jump L.fun/error17749.6)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.20)
        (jump L.fun/ascii-char17750.5)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 608)
        (set! rdi 1920)
        (set! r15 L.rp.21)
        (jump L.*.8)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1456)
        (set! rdi 1400)
        (set! r15 L.rp.22)
        (jump L.+.9)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.23)
        (jump L.-.10)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 400)
        (set! rdi 1480)
        (set! r15 L.rp.24)
        (jump L.*.8)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1320)
        (set! rdi 848)
        (set! r15 L.rp.25)
        (jump L.-.10)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.26)
        (jump L.+.9)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.27)
        (jump L.-.10)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rax (rbp - 24))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.13)
        (jump L.fun/void17802.6)))
    (define L.+.12
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.32) (jump L.tmp.33))))
    (define L.tmp.32 (begin (set! r9 14) (jump L.tmp.34)))
    (define L.tmp.33 (begin (set! r9 6) (jump L.tmp.34)))
    (define L.tmp.34 (if (!= r9 6) (jump L.__nested.25) (jump L.__nested.26)))
    (define L.tmp.29 (begin (set! r9 14) (jump L.tmp.31)))
    (define L.tmp.30 (begin (set! r9 6) (jump L.tmp.31)))
    (define L.tmp.31 (if (!= r9 6) (jump L.__nested.27) (jump L.__nested.28)))
    (define L.__nested.27
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.28 (begin (set! rax 574) (jump r15)))
    (define L.__nested.25
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.29) (jump L.tmp.30))))
    (define L.__nested.26 (begin (set! rax 574) (jump r15)))
    (define L.*.11
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.42) (jump L.tmp.43))))
    (define L.tmp.42 (begin (set! r9 14) (jump L.tmp.44)))
    (define L.tmp.43 (begin (set! r9 6) (jump L.tmp.44)))
    (define L.tmp.44 (if (!= r9 6) (jump L.__nested.35) (jump L.__nested.36)))
    (define L.tmp.39 (begin (set! r9 14) (jump L.tmp.41)))
    (define L.tmp.40 (begin (set! r9 6) (jump L.tmp.41)))
    (define L.tmp.41 (if (!= r9 6) (jump L.__nested.37) (jump L.__nested.38)))
    (define L.__nested.37
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.38 (begin (set! rax 318) (jump r15)))
    (define L.__nested.35
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.39) (jump L.tmp.40))))
    (define L.__nested.36 (begin (set! rax 318) (jump r15)))
    (define L.-.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.52) (jump L.tmp.53))))
    (define L.tmp.52 (begin (set! r9 14) (jump L.tmp.54)))
    (define L.tmp.53 (begin (set! r9 6) (jump L.tmp.54)))
    (define L.tmp.54 (if (!= r9 6) (jump L.__nested.45) (jump L.__nested.46)))
    (define L.tmp.49 (begin (set! r9 14) (jump L.tmp.51)))
    (define L.tmp.50 (begin (set! r9 6) (jump L.tmp.51)))
    (define L.tmp.51 (if (!= r9 6) (jump L.__nested.47) (jump L.__nested.48)))
    (define L.__nested.47
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.48 (begin (set! rax 830) (jump r15)))
    (define L.__nested.45
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.49) (jump L.tmp.50))))
    (define L.__nested.46 (begin (set! rax 830) (jump r15)))
    (define L.fun/empty17803.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error17806.5
      (begin (set! r15 r15) (set! rax 38462) (jump r15)))
    (define L.fun/void17802.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void17805.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty17804.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.14)
        (jump L.fun/empty17803.4)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.15)
        (jump L.fun/empty17804.8)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.16)
        (jump L.fun/void17805.7)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi 992)
        (set! rdi 936)
        (set! r15 L.rp.17)
        (jump L.-.10)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 416)
        (set! rdi 792)
        (set! r15 L.rp.18)
        (jump L.*.11)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.19)
        (jump L.*.11)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 32))
        (set! rsi 792)
        (set! rdi 1936)
        (set! r15 L.rp.20)
        (jump L.+.12)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1904)
        (set! rdi 472)
        (set! r15 L.rp.21)
        (jump L.*.11)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.22)
        (jump L.*.11)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.23)
        (jump L.-.10)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error17806.5)))))
(check-by-interp
 '(module
    (define L.__main.22
      (begin
        (set! (rbp - 0) r15)
        (set! r15 14)
        (set! r15 830)
        (set! r15 30)
        (set! r15 1512)
        (set! r15 88)
        (set! r15 30)
        (set! rbp (- rbp 8))
        (set! rdi r15)
        (set! r15 L.rp.7)
        (jump L.void?.5)))
    (define L.*.6
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.30) (jump L.tmp.31))))
    (define L.tmp.30 (begin (set! r9 14) (jump L.tmp.32)))
    (define L.tmp.31 (begin (set! r9 6) (jump L.tmp.32)))
    (define L.tmp.32 (if (!= r9 6) (jump L.__nested.23) (jump L.__nested.24)))
    (define L.tmp.27 (begin (set! r9 14) (jump L.tmp.29)))
    (define L.tmp.28 (begin (set! r9 6) (jump L.tmp.29)))
    (define L.tmp.29 (if (!= r9 6) (jump L.__nested.25) (jump L.__nested.26)))
    (define L.__nested.25
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.26 (begin (set! rax 318) (jump r15)))
    (define L.__nested.23
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.27) (jump L.tmp.28))))
    (define L.__nested.24 (begin (set! rax 318) (jump r15)))
    (define L.void?.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 30) (jump L.__nested.33) (jump L.__nested.34))))
    (define L.__nested.33 (begin (set! rax 14) (jump r15)))
    (define L.__nested.34 (begin (set! rax 6) (jump r15)))
    (define L.rp.7
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (if (!= r15 6) (jump L.__nested.8) (jump L.__nested.9))))
    (define L.tmp.13 (begin (set! r15 400) (jump L.tmp.15)))
    (define L.tmp.15 (begin (set! r14 14) (jump L.tmp.10)))
    (define L.tmp.10 (begin (set! r14 1000) (jump L.tmp.12)))
    (define L.tmp.12
      (begin (set! rsi r14) (set! rdi r15) (set! r15 (rbp - 0)) (jump L.*.6)))
    (define L.tmp.20 (begin (set! r15 360) (jump L.tmp.21)))
    (define L.tmp.21 (begin (set! r14 14) (jump L.tmp.16)))
    (define L.tmp.16 (begin (set! r14 72) (jump L.tmp.18)))
    (define L.tmp.18
      (begin (set! rsi r14) (set! rdi r15) (set! r15 (rbp - 0)) (jump L.*.6)))
    (define L.__nested.8 (begin (set! r15 14) (jump L.tmp.13)))
    (define L.__nested.9 (begin (set! r15 6) (jump L.tmp.20)))))
(check-by-interp
 '(module
    (define L.__main.23
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.12)
        (jump L.fun/empty20501.5)))
    (define L.+.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.31) (jump L.tmp.32))))
    (define L.tmp.31 (begin (set! r9 14) (jump L.tmp.33)))
    (define L.tmp.32 (begin (set! r9 6) (jump L.tmp.33)))
    (define L.tmp.33 (if (!= r9 6) (jump L.__nested.24) (jump L.__nested.25)))
    (define L.tmp.28 (begin (set! r9 14) (jump L.tmp.30)))
    (define L.tmp.29 (begin (set! r9 6) (jump L.tmp.30)))
    (define L.tmp.30 (if (!= r9 6) (jump L.__nested.26) (jump L.__nested.27)))
    (define L.__nested.26
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.27 (begin (set! rax 574) (jump r15)))
    (define L.__nested.24
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.28) (jump L.tmp.29))))
    (define L.__nested.25 (begin (set! rax 574) (jump r15)))
    (define L.-.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.41) (jump L.tmp.42))))
    (define L.tmp.41 (begin (set! r9 14) (jump L.tmp.43)))
    (define L.tmp.42 (begin (set! r9 6) (jump L.tmp.43)))
    (define L.tmp.43 (if (!= r9 6) (jump L.__nested.34) (jump L.__nested.35)))
    (define L.tmp.38 (begin (set! r9 14) (jump L.tmp.40)))
    (define L.tmp.39 (begin (set! r9 6) (jump L.tmp.40)))
    (define L.tmp.40 (if (!= r9 6) (jump L.__nested.36) (jump L.__nested.37)))
    (define L.__nested.36
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.37 (begin (set! rax 830) (jump r15)))
    (define L.__nested.34
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.38) (jump L.tmp.39))))
    (define L.__nested.35 (begin (set! rax 830) (jump r15)))
    (define L.*.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.51) (jump L.tmp.52))))
    (define L.tmp.51 (begin (set! r9 14) (jump L.tmp.53)))
    (define L.tmp.52 (begin (set! r9 6) (jump L.tmp.53)))
    (define L.tmp.53 (if (!= r9 6) (jump L.__nested.44) (jump L.__nested.45)))
    (define L.tmp.48 (begin (set! r9 14) (jump L.tmp.50)))
    (define L.tmp.49 (begin (set! r9 6) (jump L.tmp.50)))
    (define L.tmp.50 (if (!= r9 6) (jump L.__nested.46) (jump L.__nested.47)))
    (define L.__nested.46
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.47 (begin (set! rax 318) (jump r15)))
    (define L.__nested.44
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.48) (jump L.tmp.49))))
    (define L.__nested.45 (begin (set! rax 318) (jump r15)))
    (define L.fun/void20503.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty20501.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char20504.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void20502.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.13)
        (jump L.fun/void20502.7)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.14)
        (jump L.fun/void20503.4)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.15)
        (jump L.fun/ascii-char20504.6)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! rsi 1000)
        (set! rdi 144)
        (set! r15 L.rp.16)
        (jump L.*.9)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 1840)
        (set! rdi 1248)
        (set! r15 L.rp.17)
        (jump L.*.9)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.18)
        (jump L.-.10)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 40))
        (set! rsi 1216)
        (set! rdi 88)
        (set! r15 L.rp.19)
        (jump L.*.9)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 784)
        (set! rdi 512)
        (set! r15 L.rp.20)
        (jump L.+.11)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.21)
        (jump L.*.9)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.22)
        (jump L.*.9)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.38
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 72))
        (set! rsi 1616)
        (set! rdi 456)
        (set! r15 L.rp.18)
        (jump L.*.15)))
    (define L.-.17
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.39) (jump L.__nested.40)))
    (define L.tmp.43 (begin (set! r9 14) (jump L.tmp.45)))
    (define L.tmp.44 (begin (set! r9 6) (jump L.tmp.45)))
    (define L.tmp.45 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.__nested.41
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.42 (begin (set! rax 830) (jump r15)))
    (define L.__nested.39
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.43) (jump L.tmp.44))))
    (define L.__nested.40 (begin (set! rax 830) (jump r15)))
    (define L.+.16
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.49) (jump L.__nested.50)))
    (define L.tmp.53 (begin (set! r9 14) (jump L.tmp.55)))
    (define L.tmp.54 (begin (set! r9 6) (jump L.tmp.55)))
    (define L.tmp.55 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.__nested.51
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.52 (begin (set! rax 574) (jump r15)))
    (define L.__nested.49
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.53) (jump L.tmp.54))))
    (define L.__nested.50 (begin (set! rax 574) (jump r15)))
    (define L.*.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.66) (jump L.tmp.67))))
    (define L.tmp.66 (begin (set! r9 14) (jump L.tmp.68)))
    (define L.tmp.67 (begin (set! r9 6) (jump L.tmp.68)))
    (define L.tmp.68 (if (!= r9 6) (jump L.__nested.59) (jump L.__nested.60)))
    (define L.tmp.63 (begin (set! r9 14) (jump L.tmp.65)))
    (define L.tmp.64 (begin (set! r9 6) (jump L.tmp.65)))
    (define L.tmp.65 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.__nested.61
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.62 (begin (set! rax 318) (jump r15)))
    (define L.__nested.59
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.63) (jump L.tmp.64))))
    (define L.__nested.60 (begin (set! rax 318) (jump r15)))
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
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 144)
        (set! rdi 912)
        (set! r15 L.rp.19)
        (jump L.+.16)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.20)
        (jump L.-.17)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 928)
        (set! rdi 1048)
        (set! r15 L.rp.21)
        (jump L.*.15)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 224)
        (set! rdi 1272)
        (set! r15 L.rp.22)
        (jump L.*.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.23)
        (jump L.-.17)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.24)
        (jump L.+.16)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 72))
        (set! rsi 224)
        (set! rdi 1872)
        (set! r15 L.rp.25)
        (jump L.*.15)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1528)
        (set! rdi 912)
        (set! r15 L.rp.26)
        (jump L.+.16)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.27)
        (jump L.*.15)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 320)
        (set! rdi 1672)
        (set! r15 L.rp.28)
        (jump L.+.16)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1280)
        (set! rdi 1352)
        (set! r15 L.rp.29)
        (jump L.-.17)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.30)
        (jump L.+.16)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.31)
        (jump L.-.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.32)
        (jump L.-.17)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.33)
        (jump L.fun/ascii-char28488.8)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.34)
        (jump L.fun/error28490.9)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.35)
        (jump L.fun/empty28492.5)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.36)
        (jump L.fun/empty28494.7)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.37)
        (jump L.fun/void28496.11)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.23
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.17)
        (jump L.fun/ascii-char28930.4)))
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
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.18)
        (jump L.fun/error28932.13)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.19)
        (jump L.fun/ascii-char28934.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.20)
        (jump L.fun/void28936.7)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.21)
        (jump L.fun/void28938.8)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.22)
        (jump L.fun/error28940.5)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.38
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.18)
        (jump L.fun/empty30821.13)))
    (define L.+.17
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.39) (jump L.__nested.40)))
    (define L.tmp.43 (begin (set! r9 14) (jump L.tmp.45)))
    (define L.tmp.44 (begin (set! r9 6) (jump L.tmp.45)))
    (define L.tmp.45 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.__nested.41
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.42 (begin (set! rax 574) (jump r15)))
    (define L.__nested.39
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.43) (jump L.tmp.44))))
    (define L.__nested.40 (begin (set! rax 574) (jump r15)))
    (define L.*.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.49) (jump L.__nested.50)))
    (define L.tmp.53 (begin (set! r9 14) (jump L.tmp.55)))
    (define L.tmp.54 (begin (set! r9 6) (jump L.tmp.55)))
    (define L.tmp.55 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.__nested.51
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.52 (begin (set! rax 318) (jump r15)))
    (define L.__nested.49
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.53) (jump L.tmp.54))))
    (define L.__nested.50 (begin (set! rax 318) (jump r15)))
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.66) (jump L.tmp.67))))
    (define L.tmp.66 (begin (set! r9 14) (jump L.tmp.68)))
    (define L.tmp.67 (begin (set! r9 6) (jump L.tmp.68)))
    (define L.tmp.68 (if (!= r9 6) (jump L.__nested.59) (jump L.__nested.60)))
    (define L.tmp.63 (begin (set! r9 14) (jump L.tmp.65)))
    (define L.tmp.64 (begin (set! r9 6) (jump L.tmp.65)))
    (define L.tmp.65 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.__nested.61
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.62 (begin (set! rax 830) (jump r15)))
    (define L.__nested.59
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.63) (jump L.tmp.64))))
    (define L.__nested.60 (begin (set! rax 830) (jump r15)))
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
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.19)
        (jump L.fun/error30823.10)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.20)
        (jump L.fun/error30825.7)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.21)
        (jump L.fun/empty30827.5)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 1424)
        (set! rdi 1560)
        (set! r15 L.rp.22)
        (jump L.-.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1440)
        (set! rdi 488)
        (set! r15 L.rp.23)
        (jump L.-.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.24)
        (jump L.*.16)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 432)
        (set! rdi 1008)
        (set! r15 L.rp.25)
        (jump L.+.17)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 664)
        (set! rdi 760)
        (set! r15 L.rp.26)
        (jump L.+.17)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.27)
        (jump L.*.16)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.28)
        (jump L.+.17)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 408)
        (set! rdi 1368)
        (set! r15 L.rp.29)
        (jump L.+.17)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 2016)
        (set! rdi 552)
        (set! r15 L.rp.30)
        (jump L.*.16)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.31)
        (jump L.+.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1168)
        (set! rdi 528)
        (set! r15 L.rp.32)
        (jump L.*.16)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1424)
        (set! rdi 1872)
        (set! r15 L.rp.33)
        (jump L.+.17)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.34)
        (jump L.+.17)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.35)
        (jump L.+.17)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.36)
        (jump L.-.15)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.37)
        (jump L.fun/void30829.6)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.62
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 184))
        (set! rsi 1264)
        (set! rdi 608)
        (set! r15 L.rp.14)
        (jump L.+.11)))
    (define L.-.13
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.70) (jump L.tmp.71))))
    (define L.tmp.70 (begin (set! r9 14) (jump L.tmp.72)))
    (define L.tmp.71 (begin (set! r9 6) (jump L.tmp.72)))
    (define L.tmp.72 (if (!= r9 6) (jump L.__nested.63) (jump L.__nested.64)))
    (define L.tmp.67 (begin (set! r9 14) (jump L.tmp.69)))
    (define L.tmp.68 (begin (set! r9 6) (jump L.tmp.69)))
    (define L.tmp.69 (if (!= r9 6) (jump L.__nested.65) (jump L.__nested.66)))
    (define L.__nested.65
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.66 (begin (set! rax 830) (jump r15)))
    (define L.__nested.63
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.67) (jump L.tmp.68))))
    (define L.__nested.64 (begin (set! rax 830) (jump r15)))
    (define L.*.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.80) (jump L.tmp.81))))
    (define L.tmp.80 (begin (set! r9 14) (jump L.tmp.82)))
    (define L.tmp.81 (begin (set! r9 6) (jump L.tmp.82)))
    (define L.tmp.82 (if (!= r9 6) (jump L.__nested.73) (jump L.__nested.74)))
    (define L.tmp.77 (begin (set! r9 14) (jump L.tmp.79)))
    (define L.tmp.78 (begin (set! r9 6) (jump L.tmp.79)))
    (define L.tmp.79 (if (!= r9 6) (jump L.__nested.75) (jump L.__nested.76)))
    (define L.__nested.75
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.76 (begin (set! rax 318) (jump r15)))
    (define L.__nested.73
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.77) (jump L.tmp.78))))
    (define L.__nested.74 (begin (set! rax 318) (jump r15)))
    (define L.+.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.90) (jump L.tmp.91))))
    (define L.tmp.90 (begin (set! r9 14) (jump L.tmp.92)))
    (define L.tmp.91 (begin (set! r9 6) (jump L.tmp.92)))
    (define L.tmp.92 (if (!= r9 6) (jump L.__nested.83) (jump L.__nested.84)))
    (define L.tmp.87 (begin (set! r9 14) (jump L.tmp.89)))
    (define L.tmp.88 (begin (set! r9 6) (jump L.tmp.89)))
    (define L.tmp.89 (if (!= r9 6) (jump L.__nested.85) (jump L.__nested.86)))
    (define L.__nested.85
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.86 (begin (set! rax 574) (jump r15)))
    (define L.__nested.83
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.87) (jump L.tmp.88))))
    (define L.__nested.84 (begin (set! rax 574) (jump r15)))
    (define L.fun/void31698.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void31699.8)))
    (define L.fun/void31701.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void31700.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void31701.5)))
    (define L.fun/empty31697.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void31699.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty31696.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty31697.7)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1424)
        (set! rdi 800)
        (set! r15 L.rp.15)
        (jump L.*.12)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -176))
        (set! r15 L.rp.16)
        (jump L.+.11)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 360)
        (set! rdi 1392)
        (set! r15 L.rp.17)
        (jump L.-.13)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1936)
        (set! rdi 1416)
        (set! r15 L.rp.18)
        (jump L.*.12)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -176))
        (set! r15 L.rp.19)
        (jump L.*.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.20)
        (jump L.*.12)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1840)
        (set! rdi 760)
        (set! r15 L.rp.21)
        (jump L.+.11)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1968)
        (set! rdi 1616)
        (set! r15 L.rp.22)
        (jump L.*.12)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -176))
        (set! r15 L.rp.23)
        (jump L.*.12)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1792)
        (set! rdi 360)
        (set! r15 L.rp.24)
        (jump L.+.11)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1480)
        (set! rdi 896)
        (set! r15 L.rp.25)
        (jump L.*.12)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.26)
        (jump L.+.11)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -176))
        (set! r15 L.rp.27)
        (jump L.+.11)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.28)
        (jump L.*.12)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi 968)
        (set! rdi 1584)
        (set! r15 L.rp.29)
        (jump L.*.12)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1624)
        (set! rdi 928)
        (set! r15 L.rp.30)
        (jump L.+.11)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -176))
        (set! r15 L.rp.31)
        (jump L.*.12)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1432)
        (set! rdi 656)
        (set! r15 L.rp.32)
        (jump L.*.12)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 208)
        (set! rdi 784)
        (set! r15 L.rp.33)
        (jump L.+.11)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.34)
        (jump L.-.13)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -176))
        (set! r15 L.rp.35)
        (jump L.*.12)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1192)
        (set! rdi 192)
        (set! r15 L.rp.36)
        (jump L.-.13)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1872)
        (set! rdi 1424)
        (set! r15 L.rp.37)
        (jump L.-.13)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.38)
        (jump L.-.13)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 88)
        (set! rdi 176)
        (set! r15 L.rp.39)
        (jump L.*.12)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1120)
        (set! rdi 912)
        (set! r15 L.rp.40)
        (jump L.*.12)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.41)
        (jump L.-.13)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.42)
        (jump L.*.12)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -176))
        (set! r15 L.rp.43)
        (jump L.+.11)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! r15 L.rp.44)
        (jump L.fun/empty31696.9)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! r15 L.rp.45)
        (jump L.fun/void31698.4)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! r15 L.rp.46)
        (jump L.fun/void31700.6)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi 896)
        (set! rdi 640)
        (set! r15 L.rp.47)
        (jump L.-.13)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 88)
        (set! rdi 1112)
        (set! r15 L.rp.48)
        (jump L.-.13)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.49)
        (jump L.+.11)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1928)
        (set! rdi 1952)
        (set! r15 L.rp.50)
        (jump L.+.11)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1384)
        (set! rdi 1552)
        (set! r15 L.rp.51)
        (jump L.*.12)))
    (define L.rp.51
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.52)
        (jump L.+.11)))
    (define L.rp.52
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.53)
        (jump L.+.11)))
    (define L.rp.53
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 960)
        (set! rdi 272)
        (set! r15 L.rp.54)
        (jump L.-.13)))
    (define L.rp.54
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1392)
        (set! rdi 1216)
        (set! r15 L.rp.55)
        (jump L.*.12)))
    (define L.rp.55
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.56)
        (jump L.+.11)))
    (define L.rp.56
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1432)
        (set! rdi 1152)
        (set! r15 L.rp.57)
        (jump L.*.12)))
    (define L.rp.57
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 832)
        (set! rdi 1216)
        (set! r15 L.rp.58)
        (jump L.-.13)))
    (define L.rp.58
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.59)
        (jump L.+.11)))
    (define L.rp.59
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.60)
        (jump L.*.12)))
    (define L.rp.60
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.61)
        (jump L.*.12)))
    (define L.rp.61
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.51
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.16)
        (jump L.fun/empty46561.9)))
    (define L.pair?.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 1) (jump L.__nested.52) (jump L.__nested.53))))
    (define L.__nested.52 (begin (set! rax 14) (jump r15)))
    (define L.__nested.53 (begin (set! rax 6) (jump r15)))
    (define L.-.14
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.61) (jump L.tmp.62))))
    (define L.tmp.61 (begin (set! r9 14) (jump L.tmp.63)))
    (define L.tmp.62 (begin (set! r9 6) (jump L.tmp.63)))
    (define L.tmp.63 (if (!= r9 6) (jump L.__nested.54) (jump L.__nested.55)))
    (define L.tmp.58 (begin (set! r9 14) (jump L.tmp.60)))
    (define L.tmp.59 (begin (set! r9 6) (jump L.tmp.60)))
    (define L.tmp.60 (if (!= r9 6) (jump L.__nested.56) (jump L.__nested.57)))
    (define L.__nested.56
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.57 (begin (set! rax 830) (jump r15)))
    (define L.__nested.54
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.58) (jump L.tmp.59))))
    (define L.__nested.55 (begin (set! rax 830) (jump r15)))
    (define L.+.13
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.71) (jump L.tmp.72))))
    (define L.tmp.71 (begin (set! r9 14) (jump L.tmp.73)))
    (define L.tmp.72 (begin (set! r9 6) (jump L.tmp.73)))
    (define L.tmp.73 (if (!= r9 6) (jump L.__nested.64) (jump L.__nested.65)))
    (define L.tmp.68 (begin (set! r9 14) (jump L.tmp.70)))
    (define L.tmp.69 (begin (set! r9 6) (jump L.tmp.70)))
    (define L.tmp.70 (if (!= r9 6) (jump L.__nested.66) (jump L.__nested.67)))
    (define L.__nested.66
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.67 (begin (set! rax 574) (jump r15)))
    (define L.__nested.64
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.68) (jump L.tmp.69))))
    (define L.__nested.65 (begin (set! rax 574) (jump r15)))
    (define L.*.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.81) (jump L.tmp.82))))
    (define L.tmp.81 (begin (set! r9 14) (jump L.tmp.83)))
    (define L.tmp.82 (begin (set! r9 6) (jump L.tmp.83)))
    (define L.tmp.83 (if (!= r9 6) (jump L.__nested.74) (jump L.__nested.75)))
    (define L.tmp.78 (begin (set! r9 14) (jump L.tmp.80)))
    (define L.tmp.79 (begin (set! r9 6) (jump L.tmp.80)))
    (define L.tmp.80 (if (!= r9 6) (jump L.__nested.76) (jump L.__nested.77)))
    (define L.__nested.76
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.77 (begin (set! rax 318) (jump r15)))
    (define L.__nested.74
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.78) (jump L.tmp.79))))
    (define L.__nested.75 (begin (set! rax 318) (jump r15)))
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
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.17)
        (jump L.fun/error46563.5)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi 1432)
        (set! rdi 152)
        (set! r15 L.rp.18)
        (jump L.*.12)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 288)
        (set! rdi 640)
        (set! r15 L.rp.19)
        (jump L.+.13)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.20)
        (jump L.+.13)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 424)
        (set! rdi 608)
        (set! r15 L.rp.21)
        (jump L.-.14)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1016)
        (set! rdi 1656)
        (set! r15 L.rp.22)
        (jump L.*.12)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.23)
        (jump L.*.12)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.24)
        (jump L.-.14)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 600)
        (set! rdi 1392)
        (set! r15 L.rp.25)
        (jump L.*.12)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 856)
        (set! rdi 280)
        (set! r15 L.rp.26)
        (jump L.-.14)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.27)
        (jump L.-.14)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 344)
        (set! rdi 760)
        (set! r15 L.rp.28)
        (jump L.-.14)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1496)
        (set! rdi 704)
        (set! r15 L.rp.29)
        (jump L.+.13)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.30)
        (jump L.+.13)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.31)
        (jump L.+.13)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.32)
        (jump L.*.12)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.33)
        (jump L.fun/void46565.4)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 544)
        (set! rdi 1784)
        (set! r15 L.rp.34)
        (jump L.*.12)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 352)
        (set! rdi 1800)
        (set! r15 L.rp.35)
        (jump L.-.14)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.36)
        (jump L.-.14)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 392)
        (set! rdi 592)
        (set! r15 L.rp.37)
        (jump L.+.13)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 520)
        (set! rdi 1544)
        (set! r15 L.rp.38)
        (jump L.-.14)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.39)
        (jump L.-.14)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.40)
        (jump L.-.14)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 128))
        (set! rsi 896)
        (set! rdi 1288)
        (set! r15 L.rp.41)
        (jump L.*.12)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 384)
        (set! rdi 912)
        (set! r15 L.rp.42)
        (jump L.*.12)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.43)
        (jump L.-.14)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 400)
        (set! rdi 680)
        (set! r15 L.rp.44)
        (jump L.*.12)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 480)
        (set! rdi 664)
        (set! r15 L.rp.45)
        (jump L.+.13)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.46)
        (jump L.-.14)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.47)
        (jump L.*.12)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.48)
        (jump L.*.12)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.49)
        (jump L.fun/any46567.10)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rdi r15)
        (set! r15 L.rp.50)
        (jump L.pair?.15)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.50
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.16)
        (jump L.fun/void50278.8)))
    (define L.+.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.58) (jump L.tmp.59))))
    (define L.tmp.58 (begin (set! r9 14) (jump L.tmp.60)))
    (define L.tmp.59 (begin (set! r9 6) (jump L.tmp.60)))
    (define L.tmp.60 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.tmp.55 (begin (set! r9 14) (jump L.tmp.57)))
    (define L.tmp.56 (begin (set! r9 6) (jump L.tmp.57)))
    (define L.tmp.57 (if (!= r9 6) (jump L.__nested.53) (jump L.__nested.54)))
    (define L.__nested.53
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.54 (begin (set! rax 574) (jump r15)))
    (define L.__nested.51
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.55) (jump L.tmp.56))))
    (define L.__nested.52 (begin (set! rax 574) (jump r15)))
    (define L.-.14
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.68) (jump L.tmp.69))))
    (define L.tmp.68 (begin (set! r9 14) (jump L.tmp.70)))
    (define L.tmp.69 (begin (set! r9 6) (jump L.tmp.70)))
    (define L.tmp.70 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.tmp.65 (begin (set! r9 14) (jump L.tmp.67)))
    (define L.tmp.66 (begin (set! r9 6) (jump L.tmp.67)))
    (define L.tmp.67 (if (!= r9 6) (jump L.__nested.63) (jump L.__nested.64)))
    (define L.__nested.63
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.64 (begin (set! rax 830) (jump r15)))
    (define L.__nested.61
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.65) (jump L.tmp.66))))
    (define L.__nested.62 (begin (set! rax 830) (jump r15)))
    (define L.*.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.78) (jump L.tmp.79))))
    (define L.tmp.78 (begin (set! r9 14) (jump L.tmp.80)))
    (define L.tmp.79 (begin (set! r9 6) (jump L.tmp.80)))
    (define L.tmp.80 (if (!= r9 6) (jump L.__nested.71) (jump L.__nested.72)))
    (define L.tmp.75 (begin (set! r9 14) (jump L.tmp.77)))
    (define L.tmp.76 (begin (set! r9 6) (jump L.tmp.77)))
    (define L.tmp.77 (if (!= r9 6) (jump L.__nested.73) (jump L.__nested.74)))
    (define L.__nested.73
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.74 (begin (set! rax 318) (jump r15)))
    (define L.__nested.71
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.75) (jump L.tmp.76))))
    (define L.__nested.72 (begin (set! rax 318) (jump r15)))
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
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.17)
        (jump L.fun/error50280.5)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi 1120)
        (set! rdi 616)
        (set! r15 L.rp.18)
        (jump L.*.13)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 192)
        (set! rdi 1456)
        (set! r15 L.rp.19)
        (jump L.-.14)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.20)
        (jump L.-.14)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 424)
        (set! rdi 1400)
        (set! r15 L.rp.21)
        (jump L.+.15)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1392)
        (set! rdi 1416)
        (set! r15 L.rp.22)
        (jump L.+.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.23)
        (jump L.-.14)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.24)
        (jump L.*.13)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1424)
        (set! rdi 1960)
        (set! r15 L.rp.25)
        (jump L.-.14)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 128)
        (set! rdi 336)
        (set! r15 L.rp.26)
        (jump L.-.14)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.27)
        (jump L.-.14)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1640)
        (set! rdi 1152)
        (set! r15 L.rp.28)
        (jump L.+.15)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 312)
        (set! rdi 1088)
        (set! r15 L.rp.29)
        (jump L.+.15)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.30)
        (jump L.-.14)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.31)
        (jump L.-.14)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.32)
        (jump L.+.15)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.33)
        (jump L.fun/void50282.11)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi 608)
        (set! rdi 1672)
        (set! r15 L.rp.34)
        (jump L.-.14)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 400)
        (set! rdi 1736)
        (set! r15 L.rp.35)
        (jump L.+.15)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.36)
        (jump L.-.14)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1520)
        (set! rdi 1496)
        (set! r15 L.rp.37)
        (jump L.+.15)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1136)
        (set! rdi 304)
        (set! r15 L.rp.38)
        (jump L.-.14)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.39)
        (jump L.-.14)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.40)
        (jump L.-.14)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 192)
        (set! rdi 1640)
        (set! r15 L.rp.41)
        (jump L.-.14)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1224)
        (set! rdi 1816)
        (set! r15 L.rp.42)
        (jump L.-.14)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.43)
        (jump L.-.14)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1312)
        (set! rdi 520)
        (set! r15 L.rp.44)
        (jump L.-.14)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1176)
        (set! rdi 120)
        (set! r15 L.rp.45)
        (jump L.*.13)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.46)
        (jump L.-.14)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.47)
        (jump L.+.15)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.48)
        (jump L.*.13)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.49)
        (jump L.fun/ascii-char50284.7)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rax (rbp - 32))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.50
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 128))
        (set! rsi 32)
        (set! rdi 696)
        (set! r15 L.rp.16)
        (jump L.-.13)))
    (define L.+.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.58) (jump L.tmp.59))))
    (define L.tmp.58 (begin (set! r9 14) (jump L.tmp.60)))
    (define L.tmp.59 (begin (set! r9 6) (jump L.tmp.60)))
    (define L.tmp.60 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.tmp.55 (begin (set! r9 14) (jump L.tmp.57)))
    (define L.tmp.56 (begin (set! r9 6) (jump L.tmp.57)))
    (define L.tmp.57 (if (!= r9 6) (jump L.__nested.53) (jump L.__nested.54)))
    (define L.__nested.53
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.54 (begin (set! rax 574) (jump r15)))
    (define L.__nested.51
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.55) (jump L.tmp.56))))
    (define L.__nested.52 (begin (set! rax 574) (jump r15)))
    (define L.*.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.68) (jump L.tmp.69))))
    (define L.tmp.68 (begin (set! r9 14) (jump L.tmp.70)))
    (define L.tmp.69 (begin (set! r9 6) (jump L.tmp.70)))
    (define L.tmp.70 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.tmp.65 (begin (set! r9 14) (jump L.tmp.67)))
    (define L.tmp.66 (begin (set! r9 6) (jump L.tmp.67)))
    (define L.tmp.67 (if (!= r9 6) (jump L.__nested.63) (jump L.__nested.64)))
    (define L.__nested.63
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.64 (begin (set! rax 318) (jump r15)))
    (define L.__nested.61
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.65) (jump L.tmp.66))))
    (define L.__nested.62 (begin (set! rax 318) (jump r15)))
    (define L.-.13
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.78) (jump L.tmp.79))))
    (define L.tmp.78 (begin (set! r9 14) (jump L.tmp.80)))
    (define L.tmp.79 (begin (set! r9 6) (jump L.tmp.80)))
    (define L.tmp.80 (if (!= r9 6) (jump L.__nested.71) (jump L.__nested.72)))
    (define L.tmp.75 (begin (set! r9 14) (jump L.tmp.77)))
    (define L.tmp.76 (begin (set! r9 6) (jump L.tmp.77)))
    (define L.tmp.77 (if (!= r9 6) (jump L.__nested.73) (jump L.__nested.74)))
    (define L.__nested.73
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.74 (begin (set! rax 830) (jump r15)))
    (define L.__nested.71
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.75) (jump L.tmp.76))))
    (define L.__nested.72 (begin (set! rax 830) (jump r15)))
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
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1768)
        (set! rdi 1576)
        (set! r15 L.rp.17)
        (jump L.*.14)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.18)
        (jump L.-.13)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 408)
        (set! rdi 1632)
        (set! r15 L.rp.19)
        (jump L.+.15)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 976)
        (set! rdi 632)
        (set! r15 L.rp.20)
        (jump L.-.13)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.21)
        (jump L.-.13)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.22)
        (jump L.*.14)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 608)
        (set! rdi 168)
        (set! r15 L.rp.23)
        (jump L.+.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 400)
        (set! rdi 1912)
        (set! r15 L.rp.24)
        (jump L.+.15)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.25)
        (jump L.+.15)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1256)
        (set! rdi 992)
        (set! r15 L.rp.26)
        (jump L.*.14)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 424)
        (set! rdi 1144)
        (set! r15 L.rp.27)
        (jump L.*.14)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.28)
        (jump L.+.15)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.29)
        (jump L.*.14)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.30)
        (jump L.*.14)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.31)
        (jump L.fun/error51652.10)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.32)
        (jump L.fun/void51654.7)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1560)
        (set! rdi 1472)
        (set! r15 L.rp.33)
        (jump L.*.14)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1624)
        (set! rdi 592)
        (set! r15 L.rp.34)
        (jump L.*.14)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.35)
        (jump L.*.14)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1352)
        (set! rdi 536)
        (set! r15 L.rp.36)
        (jump L.*.14)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 848)
        (set! rdi 888)
        (set! r15 L.rp.37)
        (jump L.*.14)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.38)
        (jump L.*.14)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.39)
        (jump L.-.13)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 56)
        (set! rdi 1120)
        (set! r15 L.rp.40)
        (jump L.*.14)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1016)
        (set! rdi 824)
        (set! r15 L.rp.41)
        (jump L.+.15)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.42)
        (jump L.-.13)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1056)
        (set! rdi 16)
        (set! r15 L.rp.43)
        (jump L.*.14)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 144)
        (set! rdi 904)
        (set! r15 L.rp.44)
        (jump L.+.15)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.45)
        (jump L.+.15)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.46)
        (jump L.-.13)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.47)
        (jump L.*.14)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.48)
        (jump L.fun/ascii-char51656.4)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.49)
        (jump L.fun/error51658.6)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rax (rbp - 32))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.17)
        (jump L.fun/error54321.10)))
    (define L.vector?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 3) (jump L.__nested.25) (jump L.__nested.26))))
    (define L.__nested.25 (begin (set! rax 14) (jump r15)))
    (define L.__nested.26 (begin (set! rax 6) (jump r15)))
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
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.18)
        (jump L.fun/any54323.11)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! rdi r15)
        (set! r15 L.rp.19)
        (jump L.vector?.16)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.20)
        (jump L.fun/error54324.13)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.21)
        (jump L.fun/error54326.4)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.22)
        (jump L.fun/void54328.12)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.23)
        (jump L.fun/empty54330.14)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.41
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.20)
        (jump L.fun/void64309.14)))
    (define L.*.19
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.49) (jump L.tmp.50))))
    (define L.tmp.49 (begin (set! r9 14) (jump L.tmp.51)))
    (define L.tmp.50 (begin (set! r9 6) (jump L.tmp.51)))
    (define L.tmp.51 (if (!= r9 6) (jump L.__nested.42) (jump L.__nested.43)))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.44) (jump L.__nested.45)))
    (define L.__nested.44
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.45 (begin (set! rax 318) (jump r15)))
    (define L.__nested.42
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.__nested.43 (begin (set! rax 318) (jump r15)))
    (define L.+.18
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.59) (jump L.tmp.60))))
    (define L.tmp.59 (begin (set! r9 14) (jump L.tmp.61)))
    (define L.tmp.60 (begin (set! r9 6) (jump L.tmp.61)))
    (define L.tmp.61 (if (!= r9 6) (jump L.__nested.52) (jump L.__nested.53)))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.54) (jump L.__nested.55)))
    (define L.__nested.54
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.55 (begin (set! rax 574) (jump r15)))
    (define L.__nested.52
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.__nested.53 (begin (set! rax 574) (jump r15)))
    (define L.-.17
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.69) (jump L.tmp.70))))
    (define L.tmp.69 (begin (set! r9 14) (jump L.tmp.71)))
    (define L.tmp.70 (begin (set! r9 6) (jump L.tmp.71)))
    (define L.tmp.71 (if (!= r9 6) (jump L.__nested.62) (jump L.__nested.63)))
    (define L.tmp.66 (begin (set! r9 14) (jump L.tmp.68)))
    (define L.tmp.67 (begin (set! r9 6) (jump L.tmp.68)))
    (define L.tmp.68 (if (!= r9 6) (jump L.__nested.64) (jump L.__nested.65)))
    (define L.__nested.64
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.65 (begin (set! rax 830) (jump r15)))
    (define L.__nested.62
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.66) (jump L.tmp.67))))
    (define L.__nested.63 (begin (set! rax 830) (jump r15)))
    (define L.boolean?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 247))
        (set! r14 r14)
        (if (= r14 6) (jump L.__nested.72) (jump L.__nested.73))))
    (define L.__nested.72 (begin (set! rax 14) (jump r15)))
    (define L.__nested.73 (begin (set! rax 6) (jump r15)))
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
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.21)
        (jump L.fun/any64311.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rdi r15)
        (set! r15 L.rp.22)
        (jump L.boolean?.16)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.23)
        (jump L.fun/error64312.11)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.24)
        (jump L.fun/empty64314.13)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.25)
        (jump L.fun/empty64316.12)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 1520)
        (set! rdi 1160)
        (set! r15 L.rp.26)
        (jump L.-.17)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 512)
        (set! rdi 1104)
        (set! r15 L.rp.27)
        (jump L.+.18)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.28)
        (jump L.+.18)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1808)
        (set! rdi 1440)
        (set! r15 L.rp.29)
        (jump L.*.19)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1592)
        (set! rdi 696)
        (set! r15 L.rp.30)
        (jump L.-.17)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.31)
        (jump L.-.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.32)
        (jump L.-.17)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 976)
        (set! rdi 184)
        (set! r15 L.rp.33)
        (jump L.-.17)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 880)
        (set! rdi 8)
        (set! r15 L.rp.34)
        (jump L.*.19)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.35)
        (jump L.*.19)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1104)
        (set! rdi 1112)
        (set! r15 L.rp.36)
        (jump L.*.19)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1528)
        (set! rdi 992)
        (set! r15 L.rp.37)
        (jump L.+.18)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.38)
        (jump L.-.17)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.39)
        (jump L.*.19)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.40)
        (jump L.+.18)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char64318.7)))))
(check-by-interp
 '(module
    (define L.__main.38
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! rsi 8)
        (set! rdi 1632)
        (set! r15 L.rp.18)
        (jump L.-.15)))
    (define L.*.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.39) (jump L.__nested.40)))
    (define L.tmp.43 (begin (set! r9 14) (jump L.tmp.45)))
    (define L.tmp.44 (begin (set! r9 6) (jump L.tmp.45)))
    (define L.tmp.45 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.__nested.41
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.42 (begin (set! rax 318) (jump r15)))
    (define L.__nested.39
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.43) (jump L.tmp.44))))
    (define L.__nested.40 (begin (set! rax 318) (jump r15)))
    (define L.+.16
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.49) (jump L.__nested.50)))
    (define L.tmp.53 (begin (set! r9 14) (jump L.tmp.55)))
    (define L.tmp.54 (begin (set! r9 6) (jump L.tmp.55)))
    (define L.tmp.55 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.__nested.51
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.52 (begin (set! rax 574) (jump r15)))
    (define L.__nested.49
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.53) (jump L.tmp.54))))
    (define L.__nested.50 (begin (set! rax 574) (jump r15)))
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.66) (jump L.tmp.67))))
    (define L.tmp.66 (begin (set! r9 14) (jump L.tmp.68)))
    (define L.tmp.67 (begin (set! r9 6) (jump L.tmp.68)))
    (define L.tmp.68 (if (!= r9 6) (jump L.__nested.59) (jump L.__nested.60)))
    (define L.tmp.63 (begin (set! r9 14) (jump L.tmp.65)))
    (define L.tmp.64 (begin (set! r9 6) (jump L.tmp.65)))
    (define L.tmp.65 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.__nested.61
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.62 (begin (set! rax 830) (jump r15)))
    (define L.__nested.59
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.63) (jump L.tmp.64))))
    (define L.__nested.60 (begin (set! rax 830) (jump r15)))
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
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 448)
        (set! rdi 824)
        (set! r15 L.rp.19)
        (jump L.-.15)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.20)
        (jump L.+.16)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 8)
        (set! rdi 1680)
        (set! r15 L.rp.21)
        (jump L.-.15)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1232)
        (set! rdi 1912)
        (set! r15 L.rp.22)
        (jump L.*.17)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.23)
        (jump L.+.16)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.24)
        (jump L.+.16)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1320)
        (set! rdi 552)
        (set! r15 L.rp.25)
        (jump L.+.16)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1840)
        (set! rdi 1744)
        (set! r15 L.rp.26)
        (jump L.-.15)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.27)
        (jump L.+.16)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1096)
        (set! rdi 1744)
        (set! r15 L.rp.28)
        (jump L.-.15)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 408)
        (set! rdi 1680)
        (set! r15 L.rp.29)
        (jump L.*.17)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.30)
        (jump L.-.15)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.31)
        (jump L.*.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.32)
        (jump L.-.15)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.33)
        (jump L.fun/void75653.12)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.34)
        (jump L.fun/empty75655.11)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.35)
        (jump L.fun/empty75657.5)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.36)
        (jump L.fun/ascii-char75659.13)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.37)
        (jump L.fun/ascii-char75661.9)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.39
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.18)
        (jump L.fun/ascii-char83228.12)))
    (define L.+.17
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.47) (jump L.tmp.48))))
    (define L.tmp.47 (begin (set! r9 14) (jump L.tmp.49)))
    (define L.tmp.48 (begin (set! r9 6) (jump L.tmp.49)))
    (define L.tmp.49 (if (!= r9 6) (jump L.__nested.40) (jump L.__nested.41)))
    (define L.tmp.44 (begin (set! r9 14) (jump L.tmp.46)))
    (define L.tmp.45 (begin (set! r9 6) (jump L.tmp.46)))
    (define L.tmp.46 (if (!= r9 6) (jump L.__nested.42) (jump L.__nested.43)))
    (define L.__nested.42
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.43 (begin (set! rax 574) (jump r15)))
    (define L.__nested.40
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.44) (jump L.tmp.45))))
    (define L.__nested.41 (begin (set! rax 574) (jump r15)))
    (define L.*.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.57) (jump L.tmp.58))))
    (define L.tmp.57 (begin (set! r9 14) (jump L.tmp.59)))
    (define L.tmp.58 (begin (set! r9 6) (jump L.tmp.59)))
    (define L.tmp.59 (if (!= r9 6) (jump L.__nested.50) (jump L.__nested.51)))
    (define L.tmp.54 (begin (set! r9 14) (jump L.tmp.56)))
    (define L.tmp.55 (begin (set! r9 6) (jump L.tmp.56)))
    (define L.tmp.56 (if (!= r9 6) (jump L.__nested.52) (jump L.__nested.53)))
    (define L.__nested.52
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.53 (begin (set! rax 318) (jump r15)))
    (define L.__nested.50
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.54) (jump L.tmp.55))))
    (define L.__nested.51 (begin (set! rax 318) (jump r15)))
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.67) (jump L.tmp.68))))
    (define L.tmp.67 (begin (set! r9 14) (jump L.tmp.69)))
    (define L.tmp.68 (begin (set! r9 6) (jump L.tmp.69)))
    (define L.tmp.69 (if (!= r9 6) (jump L.__nested.60) (jump L.__nested.61)))
    (define L.tmp.64 (begin (set! r9 14) (jump L.tmp.66)))
    (define L.tmp.65 (begin (set! r9 6) (jump L.tmp.66)))
    (define L.tmp.66 (if (!= r9 6) (jump L.__nested.62) (jump L.__nested.63)))
    (define L.__nested.62
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.63 (begin (set! rax 830) (jump r15)))
    (define L.__nested.60
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.64) (jump L.tmp.65))))
    (define L.__nested.61 (begin (set! rax 830) (jump r15)))
    (define L.error?.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 62) (jump L.__nested.70) (jump L.__nested.71))))
    (define L.__nested.70 (begin (set! rax 14) (jump r15)))
    (define L.__nested.71 (begin (set! rax 6) (jump r15)))
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
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.19)
        (jump L.fun/error83230.4)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.20)
        (jump L.fun/any83232.11)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rdi r15)
        (set! r15 L.rp.21)
        (jump L.error?.14)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.22)
        (jump L.fun/empty83233.5)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.23)
        (jump L.fun/void83235.8)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1816)
        (set! rdi 72)
        (set! r15 L.rp.24)
        (jump L.-.15)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 440)
        (set! rdi 1344)
        (set! r15 L.rp.25)
        (jump L.*.16)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.26)
        (jump L.+.17)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 72))
        (set! rsi 192)
        (set! rdi 912)
        (set! r15 L.rp.27)
        (jump L.-.15)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 88)
        (set! rdi 608)
        (set! r15 L.rp.28)
        (jump L.-.15)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.29)
        (jump L.*.16)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.30)
        (jump L.*.16)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 72))
        (set! rsi 136)
        (set! rdi 1432)
        (set! r15 L.rp.31)
        (jump L.+.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 984)
        (set! rdi 824)
        (set! r15 L.rp.32)
        (jump L.+.17)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.33)
        (jump L.+.17)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 504)
        (set! rdi 208)
        (set! r15 L.rp.34)
        (jump L.+.17)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 72))
        (set! rsi 720)
        (set! rdi 1128)
        (set! r15 L.rp.35)
        (jump L.+.17)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.36)
        (jump L.*.16)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.37)
        (jump L.+.17)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.38)
        (jump L.-.15)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.17)
        (jump L.fun/void87921.14)))
    (define L.error?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 62) (jump L.__nested.25) (jump L.__nested.26))))
    (define L.__nested.25 (begin (set! rax 14) (jump r15)))
    (define L.__nested.26 (begin (set! rax 6) (jump r15)))
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
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.18)
        (jump L.fun/ascii-char87923.4)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.19)
        (jump L.fun/ascii-char87925.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.20)
        (jump L.fun/any87927.11)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! rdi r15)
        (set! r15 L.rp.21)
        (jump L.error?.16)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.22)
        (jump L.fun/ascii-char87928.6)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.23)
        (jump L.fun/empty87930.9)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.38
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.18)
        (jump L.fun/error88020.10)))
    (define L.*.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.39) (jump L.__nested.40)))
    (define L.tmp.43 (begin (set! r9 14) (jump L.tmp.45)))
    (define L.tmp.44 (begin (set! r9 6) (jump L.tmp.45)))
    (define L.tmp.45 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.__nested.41
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.42 (begin (set! rax 318) (jump r15)))
    (define L.__nested.39
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.43) (jump L.tmp.44))))
    (define L.__nested.40 (begin (set! rax 318) (jump r15)))
    (define L.-.16
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.49) (jump L.__nested.50)))
    (define L.tmp.53 (begin (set! r9 14) (jump L.tmp.55)))
    (define L.tmp.54 (begin (set! r9 6) (jump L.tmp.55)))
    (define L.tmp.55 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.__nested.51
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.52 (begin (set! rax 830) (jump r15)))
    (define L.__nested.49
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.53) (jump L.tmp.54))))
    (define L.__nested.50 (begin (set! rax 830) (jump r15)))
    (define L.+.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.66) (jump L.tmp.67))))
    (define L.tmp.66 (begin (set! r9 14) (jump L.tmp.68)))
    (define L.tmp.67 (begin (set! r9 6) (jump L.tmp.68)))
    (define L.tmp.68 (if (!= r9 6) (jump L.__nested.59) (jump L.__nested.60)))
    (define L.tmp.63 (begin (set! r9 14) (jump L.tmp.65)))
    (define L.tmp.64 (begin (set! r9 6) (jump L.tmp.65)))
    (define L.tmp.65 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.__nested.61
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.62 (begin (set! rax 574) (jump r15)))
    (define L.__nested.59
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.63) (jump L.tmp.64))))
    (define L.__nested.60 (begin (set! rax 574) (jump r15)))
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
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.19)
        (jump L.fun/void88022.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.20)
        (jump L.fun/error88024.6)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi 608)
        (set! rdi 440)
        (set! r15 L.rp.21)
        (jump L.+.15)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 0)
        (set! rdi 184)
        (set! r15 L.rp.22)
        (jump L.+.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.23)
        (jump L.-.16)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 168)
        (set! rdi 144)
        (set! r15 L.rp.24)
        (jump L.+.15)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1448)
        (set! rdi 1224)
        (set! r15 L.rp.25)
        (jump L.+.15)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.26)
        (jump L.*.17)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.27)
        (jump L.-.16)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 864)
        (set! rdi 32)
        (set! r15 L.rp.28)
        (jump L.-.16)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 872)
        (set! rdi 752)
        (set! r15 L.rp.29)
        (jump L.+.15)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.30)
        (jump L.-.16)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1912)
        (set! rdi 1912)
        (set! r15 L.rp.31)
        (jump L.-.16)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 784)
        (set! rdi 1704)
        (set! r15 L.rp.32)
        (jump L.*.17)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.33)
        (jump L.+.15)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.34)
        (jump L.-.16)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.35)
        (jump L.+.15)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.36)
        (jump L.fun/empty88026.8)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.37)
        (jump L.fun/error88028.13)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rax (rbp - 32))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.51
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.16)
        (jump L.fun/void95241.7)))
    (define L.+.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.59) (jump L.tmp.60))))
    (define L.tmp.59 (begin (set! r9 14) (jump L.tmp.61)))
    (define L.tmp.60 (begin (set! r9 6) (jump L.tmp.61)))
    (define L.tmp.61 (if (!= r9 6) (jump L.__nested.52) (jump L.__nested.53)))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.54) (jump L.__nested.55)))
    (define L.__nested.54
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.55 (begin (set! rax 574) (jump r15)))
    (define L.__nested.52
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.__nested.53 (begin (set! rax 574) (jump r15)))
    (define L.*.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.69) (jump L.tmp.70))))
    (define L.tmp.69 (begin (set! r9 14) (jump L.tmp.71)))
    (define L.tmp.70 (begin (set! r9 6) (jump L.tmp.71)))
    (define L.tmp.71 (if (!= r9 6) (jump L.__nested.62) (jump L.__nested.63)))
    (define L.tmp.66 (begin (set! r9 14) (jump L.tmp.68)))
    (define L.tmp.67 (begin (set! r9 6) (jump L.tmp.68)))
    (define L.tmp.68 (if (!= r9 6) (jump L.__nested.64) (jump L.__nested.65)))
    (define L.__nested.64
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.65 (begin (set! rax 318) (jump r15)))
    (define L.__nested.62
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.66) (jump L.tmp.67))))
    (define L.__nested.63 (begin (set! rax 318) (jump r15)))
    (define L.-.13
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.79) (jump L.tmp.80))))
    (define L.tmp.79 (begin (set! r9 14) (jump L.tmp.81)))
    (define L.tmp.80 (begin (set! r9 6) (jump L.tmp.81)))
    (define L.tmp.81 (if (!= r9 6) (jump L.__nested.72) (jump L.__nested.73)))
    (define L.tmp.76 (begin (set! r9 14) (jump L.tmp.78)))
    (define L.tmp.77 (begin (set! r9 6) (jump L.tmp.78)))
    (define L.tmp.78 (if (!= r9 6) (jump L.__nested.74) (jump L.__nested.75)))
    (define L.__nested.74
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.75 (begin (set! rax 830) (jump r15)))
    (define L.__nested.72
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.76) (jump L.tmp.77))))
    (define L.__nested.73 (begin (set! rax 830) (jump r15)))
    (define L.pair?.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 1) (jump L.__nested.82) (jump L.__nested.83))))
    (define L.__nested.82 (begin (set! rax 14) (jump r15)))
    (define L.__nested.83 (begin (set! rax 6) (jump r15)))
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
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.17)
        (jump L.fun/any95243.8)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rdi r15)
        (set! r15 L.rp.18)
        (jump L.pair?.12)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.19)
        (jump L.fun/ascii-char95244.9)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1928)
        (set! rdi 336)
        (set! r15 L.rp.20)
        (jump L.-.13)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1904)
        (set! rdi 776)
        (set! r15 L.rp.21)
        (jump L.*.14)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.22)
        (jump L.-.13)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 376)
        (set! rdi 1720)
        (set! r15 L.rp.23)
        (jump L.*.14)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 256)
        (set! rdi 912)
        (set! r15 L.rp.24)
        (jump L.*.14)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.25)
        (jump L.-.13)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.26)
        (jump L.-.13)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1400)
        (set! rdi 136)
        (set! r15 L.rp.27)
        (jump L.-.13)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1648)
        (set! rdi 1472)
        (set! r15 L.rp.28)
        (jump L.-.13)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.29)
        (jump L.*.14)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 528)
        (set! rdi 1240)
        (set! r15 L.rp.30)
        (jump L.-.13)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 728)
        (set! rdi 1200)
        (set! r15 L.rp.31)
        (jump L.+.15)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.32)
        (jump L.+.15)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.33)
        (jump L.*.14)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.34)
        (jump L.*.14)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.35)
        (jump L.fun/empty95246.10)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi 1368)
        (set! rdi 168)
        (set! r15 L.rp.36)
        (jump L.-.13)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1400)
        (set! rdi 1368)
        (set! r15 L.rp.37)
        (jump L.+.15)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.38)
        (jump L.*.14)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 72)
        (set! rdi 696)
        (set! r15 L.rp.39)
        (jump L.*.14)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 128)
        (set! rdi 1616)
        (set! r15 L.rp.40)
        (jump L.*.14)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.41)
        (jump L.*.14)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.42)
        (jump L.+.15)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 128))
        (set! rsi 896)
        (set! rdi 360)
        (set! r15 L.rp.43)
        (jump L.+.15)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1472)
        (set! rdi 1968)
        (set! r15 L.rp.44)
        (jump L.*.14)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.45)
        (jump L.*.14)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1136)
        (set! rdi 1360)
        (set! r15 L.rp.46)
        (jump L.+.15)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 728)
        (set! rdi 1096)
        (set! r15 L.rp.47)
        (jump L.*.14)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.48)
        (jump L.*.14)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.49)
        (jump L.-.13)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.50)
        (jump L.-.13)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.38
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.18)
        (jump L.fun/ascii-char100999.9)))
    (define L.*.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.39) (jump L.__nested.40)))
    (define L.tmp.43 (begin (set! r9 14) (jump L.tmp.45)))
    (define L.tmp.44 (begin (set! r9 6) (jump L.tmp.45)))
    (define L.tmp.45 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.__nested.41
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.42 (begin (set! rax 318) (jump r15)))
    (define L.__nested.39
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.43) (jump L.tmp.44))))
    (define L.__nested.40 (begin (set! rax 318) (jump r15)))
    (define L.+.16
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.49) (jump L.__nested.50)))
    (define L.tmp.53 (begin (set! r9 14) (jump L.tmp.55)))
    (define L.tmp.54 (begin (set! r9 6) (jump L.tmp.55)))
    (define L.tmp.55 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.__nested.51
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.52 (begin (set! rax 574) (jump r15)))
    (define L.__nested.49
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.53) (jump L.tmp.54))))
    (define L.__nested.50 (begin (set! rax 574) (jump r15)))
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.66) (jump L.tmp.67))))
    (define L.tmp.66 (begin (set! r9 14) (jump L.tmp.68)))
    (define L.tmp.67 (begin (set! r9 6) (jump L.tmp.68)))
    (define L.tmp.68 (if (!= r9 6) (jump L.__nested.59) (jump L.__nested.60)))
    (define L.tmp.63 (begin (set! r9 14) (jump L.tmp.65)))
    (define L.tmp.64 (begin (set! r9 6) (jump L.tmp.65)))
    (define L.tmp.65 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.__nested.61
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.62 (begin (set! rax 830) (jump r15)))
    (define L.__nested.59
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.63) (jump L.tmp.64))))
    (define L.__nested.60 (begin (set! rax 830) (jump r15)))
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
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 720)
        (set! rdi 1032)
        (set! r15 L.rp.19)
        (jump L.-.15)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1568)
        (set! rdi 1368)
        (set! r15 L.rp.20)
        (jump L.-.15)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.21)
        (jump L.+.16)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 952)
        (set! rdi 576)
        (set! r15 L.rp.22)
        (jump L.*.17)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 976)
        (set! rdi 112)
        (set! r15 L.rp.23)
        (jump L.*.17)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.24)
        (jump L.-.15)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.25)
        (jump L.+.16)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1048)
        (set! rdi 1704)
        (set! r15 L.rp.26)
        (jump L.*.17)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 16)
        (set! rdi 728)
        (set! r15 L.rp.27)
        (jump L.+.16)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.28)
        (jump L.*.17)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1072)
        (set! rdi 784)
        (set! r15 L.rp.29)
        (jump L.+.16)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1152)
        (set! rdi 1656)
        (set! r15 L.rp.30)
        (jump L.*.17)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.31)
        (jump L.*.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.32)
        (jump L.+.16)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.33)
        (jump L.+.16)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.34)
        (jump L.fun/ascii-char101001.13)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.35)
        (jump L.fun/void101003.11)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.36)
        (jump L.fun/void101005.5)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.37)
        (jump L.fun/ascii-char101007.6)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.38
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.18)
        (jump L.fun/void102214.8)))
    (define L.-.17
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.39) (jump L.__nested.40)))
    (define L.tmp.43 (begin (set! r9 14) (jump L.tmp.45)))
    (define L.tmp.44 (begin (set! r9 6) (jump L.tmp.45)))
    (define L.tmp.45 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.__nested.41
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.42 (begin (set! rax 830) (jump r15)))
    (define L.__nested.39
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.43) (jump L.tmp.44))))
    (define L.__nested.40 (begin (set! rax 830) (jump r15)))
    (define L.+.16
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.49) (jump L.__nested.50)))
    (define L.tmp.53 (begin (set! r9 14) (jump L.tmp.55)))
    (define L.tmp.54 (begin (set! r9 6) (jump L.tmp.55)))
    (define L.tmp.55 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.__nested.51
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.52 (begin (set! rax 574) (jump r15)))
    (define L.__nested.49
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.53) (jump L.tmp.54))))
    (define L.__nested.50 (begin (set! rax 574) (jump r15)))
    (define L.*.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.66) (jump L.tmp.67))))
    (define L.tmp.66 (begin (set! r9 14) (jump L.tmp.68)))
    (define L.tmp.67 (begin (set! r9 6) (jump L.tmp.68)))
    (define L.tmp.68 (if (!= r9 6) (jump L.__nested.59) (jump L.__nested.60)))
    (define L.tmp.63 (begin (set! r9 14) (jump L.tmp.65)))
    (define L.tmp.64 (begin (set! r9 6) (jump L.tmp.65)))
    (define L.tmp.65 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.__nested.61
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.62 (begin (set! rax 318) (jump r15)))
    (define L.__nested.59
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.63) (jump L.tmp.64))))
    (define L.__nested.60 (begin (set! rax 318) (jump r15)))
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
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.19)
        (jump L.fun/empty102216.6)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.20)
        (jump L.fun/void102218.5)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.21)
        (jump L.fun/error102220.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 184)
        (set! rdi 1688)
        (set! r15 L.rp.22)
        (jump L.*.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 936)
        (set! rdi 1192)
        (set! r15 L.rp.23)
        (jump L.*.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.24)
        (jump L.*.15)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1936)
        (set! rdi 1264)
        (set! r15 L.rp.25)
        (jump L.*.15)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1968)
        (set! rdi 656)
        (set! r15 L.rp.26)
        (jump L.*.15)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.27)
        (jump L.*.15)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.28)
        (jump L.+.16)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1256)
        (set! rdi 632)
        (set! r15 L.rp.29)
        (jump L.*.15)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 520)
        (set! rdi 1456)
        (set! r15 L.rp.30)
        (jump L.+.16)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.31)
        (jump L.*.15)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1832)
        (set! rdi 568)
        (set! r15 L.rp.32)
        (jump L.*.15)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 72))
        (set! rsi 24)
        (set! rdi 1672)
        (set! r15 L.rp.33)
        (jump L.-.17)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.34)
        (jump L.+.16)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.35)
        (jump L.-.17)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.36)
        (jump L.-.17)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.37)
        (jump L.fun/ascii-char102222.12)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.41
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.20)
        (jump L.fun/ascii-char102234.9)))
    (define L.-.19
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.49) (jump L.tmp.50))))
    (define L.tmp.49 (begin (set! r9 14) (jump L.tmp.51)))
    (define L.tmp.50 (begin (set! r9 6) (jump L.tmp.51)))
    (define L.tmp.51 (if (!= r9 6) (jump L.__nested.42) (jump L.__nested.43)))
    (define L.tmp.46 (begin (set! r9 14) (jump L.tmp.48)))
    (define L.tmp.47 (begin (set! r9 6) (jump L.tmp.48)))
    (define L.tmp.48 (if (!= r9 6) (jump L.__nested.44) (jump L.__nested.45)))
    (define L.__nested.44
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.45 (begin (set! rax 830) (jump r15)))
    (define L.__nested.42
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.__nested.43 (begin (set! rax 830) (jump r15)))
    (define L.*.18
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.59) (jump L.tmp.60))))
    (define L.tmp.59 (begin (set! r9 14) (jump L.tmp.61)))
    (define L.tmp.60 (begin (set! r9 6) (jump L.tmp.61)))
    (define L.tmp.61 (if (!= r9 6) (jump L.__nested.52) (jump L.__nested.53)))
    (define L.tmp.56 (begin (set! r9 14) (jump L.tmp.58)))
    (define L.tmp.57 (begin (set! r9 6) (jump L.tmp.58)))
    (define L.tmp.58 (if (!= r9 6) (jump L.__nested.54) (jump L.__nested.55)))
    (define L.__nested.54
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.55 (begin (set! rax 318) (jump r15)))
    (define L.__nested.52
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.56) (jump L.tmp.57))))
    (define L.__nested.53 (begin (set! rax 318) (jump r15)))
    (define L.+.17
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.69) (jump L.tmp.70))))
    (define L.tmp.69 (begin (set! r9 14) (jump L.tmp.71)))
    (define L.tmp.70 (begin (set! r9 6) (jump L.tmp.71)))
    (define L.tmp.71 (if (!= r9 6) (jump L.__nested.62) (jump L.__nested.63)))
    (define L.tmp.66 (begin (set! r9 14) (jump L.tmp.68)))
    (define L.tmp.67 (begin (set! r9 6) (jump L.tmp.68)))
    (define L.tmp.68 (if (!= r9 6) (jump L.__nested.64) (jump L.__nested.65)))
    (define L.__nested.64
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.65 (begin (set! rax 574) (jump r15)))
    (define L.__nested.62
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.66) (jump L.tmp.67))))
    (define L.__nested.63 (begin (set! rax 574) (jump r15)))
    (define L.vector?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 3) (jump L.__nested.72) (jump L.__nested.73))))
    (define L.__nested.72 (begin (set! rax 14) (jump r15)))
    (define L.__nested.73 (begin (set! rax 6) (jump r15)))
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
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.21)
        (jump L.fun/ascii-char102236.6)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.22)
        (jump L.fun/any102238.5)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rdi r15)
        (set! r15 L.rp.23)
        (jump L.vector?.16)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.24)
        (jump L.fun/ascii-char102239.8)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.25)
        (jump L.fun/void102241.7)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.26)
        (jump L.fun/void102243.4)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 1032)
        (set! rdi 1848)
        (set! r15 L.rp.27)
        (jump L.+.17)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1088)
        (set! rdi 488)
        (set! r15 L.rp.28)
        (jump L.+.17)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.29)
        (jump L.*.18)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 264)
        (set! rdi 1440)
        (set! r15 L.rp.30)
        (jump L.-.19)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1248)
        (set! rdi 1976)
        (set! r15 L.rp.31)
        (jump L.+.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.32)
        (jump L.*.18)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.33)
        (jump L.*.18)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1616)
        (set! rdi 1904)
        (set! r15 L.rp.34)
        (jump L.+.17)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 312)
        (set! rdi 576)
        (set! r15 L.rp.35)
        (jump L.+.17)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.36)
        (jump L.-.19)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1400)
        (set! rdi 784)
        (set! r15 L.rp.37)
        (jump L.+.17)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1936)
        (set! rdi 592)
        (set! r15 L.rp.38)
        (jump L.*.18)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.39)
        (jump L.-.19)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.40)
        (jump L.-.19)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.*.18)))))
(check-by-interp
 '(module
    (define L.__main.40
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.20)
        (jump L.fun/empty104395.10)))
    (define L.+.19
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.48) (jump L.tmp.49))))
    (define L.tmp.48 (begin (set! r9 14) (jump L.tmp.50)))
    (define L.tmp.49 (begin (set! r9 6) (jump L.tmp.50)))
    (define L.tmp.50 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.tmp.45 (begin (set! r9 14) (jump L.tmp.47)))
    (define L.tmp.46 (begin (set! r9 6) (jump L.tmp.47)))
    (define L.tmp.47 (if (!= r9 6) (jump L.__nested.43) (jump L.__nested.44)))
    (define L.__nested.43
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.44 (begin (set! rax 574) (jump r15)))
    (define L.__nested.41
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.45) (jump L.tmp.46))))
    (define L.__nested.42 (begin (set! rax 574) (jump r15)))
    (define L.-.18
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.58) (jump L.tmp.59))))
    (define L.tmp.58 (begin (set! r9 14) (jump L.tmp.60)))
    (define L.tmp.59 (begin (set! r9 6) (jump L.tmp.60)))
    (define L.tmp.60 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.tmp.55 (begin (set! r9 14) (jump L.tmp.57)))
    (define L.tmp.56 (begin (set! r9 6) (jump L.tmp.57)))
    (define L.tmp.57 (if (!= r9 6) (jump L.__nested.53) (jump L.__nested.54)))
    (define L.__nested.53
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.54 (begin (set! rax 830) (jump r15)))
    (define L.__nested.51
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.55) (jump L.tmp.56))))
    (define L.__nested.52 (begin (set! rax 830) (jump r15)))
    (define L.*.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.68) (jump L.tmp.69))))
    (define L.tmp.68 (begin (set! r9 14) (jump L.tmp.70)))
    (define L.tmp.69 (begin (set! r9 6) (jump L.tmp.70)))
    (define L.tmp.70 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.tmp.65 (begin (set! r9 14) (jump L.tmp.67)))
    (define L.tmp.66 (begin (set! r9 6) (jump L.tmp.67)))
    (define L.tmp.67 (if (!= r9 6) (jump L.__nested.63) (jump L.__nested.64)))
    (define L.__nested.63
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.64 (begin (set! rax 318) (jump r15)))
    (define L.__nested.61
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.65) (jump L.tmp.66))))
    (define L.__nested.62 (begin (set! rax 318) (jump r15)))
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
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.21)
        (jump L.fun/void104397.5)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.22)
        (jump L.fun/empty104399.4)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.23)
        (jump L.fun/void104401.11)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 984)
        (set! rdi 1080)
        (set! r15 L.rp.24)
        (jump L.*.17)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1576)
        (set! rdi 128)
        (set! r15 L.rp.25)
        (jump L.*.17)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.26)
        (jump L.-.18)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 576)
        (set! rdi 1344)
        (set! r15 L.rp.27)
        (jump L.-.18)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 560)
        (set! rdi 832)
        (set! r15 L.rp.28)
        (jump L.*.17)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.29)
        (jump L.*.17)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.30)
        (jump L.*.17)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 568)
        (set! rdi 1424)
        (set! r15 L.rp.31)
        (jump L.+.19)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 776)
        (set! rdi 1512)
        (set! r15 L.rp.32)
        (jump L.+.19)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.33)
        (jump L.-.18)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1344)
        (set! rdi 208)
        (set! r15 L.rp.34)
        (jump L.*.17)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1296)
        (set! rdi 608)
        (set! r15 L.rp.35)
        (jump L.-.18)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.36)
        (jump L.+.19)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.37)
        (jump L.*.17)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.38)
        (jump L.*.17)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.39)
        (jump L.fun/empty104403.15)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error104405.9)))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.17)
        (jump L.fun/ascii-char105572.9)))
    (define L.boolean?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 247))
        (set! r14 r14)
        (if (= r14 6) (jump L.__nested.25) (jump L.__nested.26))))
    (define L.__nested.25 (begin (set! rax 14) (jump r15)))
    (define L.__nested.26 (begin (set! rax 6) (jump r15)))
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
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.18)
        (jump L.fun/error105574.12)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.19)
        (jump L.fun/error105576.8)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.20)
        (jump L.fun/any105578.4)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! rdi r15)
        (set! r15 L.rp.21)
        (jump L.boolean?.16)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.22)
        (jump L.fun/error105579.5)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.23)
        (jump L.fun/void105581.10)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.17)
        (jump L.fun/any121809.14)))
    (define L.ascii-char?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 46) (jump L.__nested.25) (jump L.__nested.26))))
    (define L.__nested.25 (begin (set! rax 14) (jump r15)))
    (define L.__nested.26 (begin (set! rax 6) (jump r15)))
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
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! rdi r15)
        (set! r15 L.rp.18)
        (jump L.ascii-char?.16)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.19)
        (jump L.fun/ascii-char121810.13)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.20)
        (jump L.fun/void121812.8)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.21)
        (jump L.fun/void121814.6)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.22)
        (jump L.fun/ascii-char121816.7)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.23)
        (jump L.fun/ascii-char121818.5)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.50
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 120))
        (set! rsi 1144)
        (set! rdi 1312)
        (set! r15 L.rp.16)
        (jump L.-.13)))
    (define L.+.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.58) (jump L.tmp.59))))
    (define L.tmp.58 (begin (set! r9 14) (jump L.tmp.60)))
    (define L.tmp.59 (begin (set! r9 6) (jump L.tmp.60)))
    (define L.tmp.60 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.tmp.55 (begin (set! r9 14) (jump L.tmp.57)))
    (define L.tmp.56 (begin (set! r9 6) (jump L.tmp.57)))
    (define L.tmp.57 (if (!= r9 6) (jump L.__nested.53) (jump L.__nested.54)))
    (define L.__nested.53
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.54 (begin (set! rax 574) (jump r15)))
    (define L.__nested.51
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.55) (jump L.tmp.56))))
    (define L.__nested.52 (begin (set! rax 574) (jump r15)))
    (define L.*.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.68) (jump L.tmp.69))))
    (define L.tmp.68 (begin (set! r9 14) (jump L.tmp.70)))
    (define L.tmp.69 (begin (set! r9 6) (jump L.tmp.70)))
    (define L.tmp.70 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.tmp.65 (begin (set! r9 14) (jump L.tmp.67)))
    (define L.tmp.66 (begin (set! r9 6) (jump L.tmp.67)))
    (define L.tmp.67 (if (!= r9 6) (jump L.__nested.63) (jump L.__nested.64)))
    (define L.__nested.63
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.64 (begin (set! rax 318) (jump r15)))
    (define L.__nested.61
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.65) (jump L.tmp.66))))
    (define L.__nested.62 (begin (set! rax 318) (jump r15)))
    (define L.-.13
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.78) (jump L.tmp.79))))
    (define L.tmp.78 (begin (set! r9 14) (jump L.tmp.80)))
    (define L.tmp.79 (begin (set! r9 6) (jump L.tmp.80)))
    (define L.tmp.80 (if (!= r9 6) (jump L.__nested.71) (jump L.__nested.72)))
    (define L.tmp.75 (begin (set! r9 14) (jump L.tmp.77)))
    (define L.tmp.76 (begin (set! r9 6) (jump L.tmp.77)))
    (define L.tmp.77 (if (!= r9 6) (jump L.__nested.73) (jump L.__nested.74)))
    (define L.__nested.73
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.74 (begin (set! rax 830) (jump r15)))
    (define L.__nested.71
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.75) (jump L.tmp.76))))
    (define L.__nested.72 (begin (set! rax 830) (jump r15)))
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
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 2016)
        (set! rdi 1080)
        (set! r15 L.rp.17)
        (jump L.*.14)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.18)
        (jump L.*.14)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 120))
        (set! rsi 1384)
        (set! rdi 40)
        (set! r15 L.rp.19)
        (jump L.+.15)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 1832)
        (set! rdi 1872)
        (set! r15 L.rp.20)
        (jump L.*.14)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.21)
        (jump L.*.14)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.22)
        (jump L.*.14)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 120))
        (set! rsi 264)
        (set! rdi 1008)
        (set! r15 L.rp.23)
        (jump L.-.13)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 952)
        (set! rdi 1376)
        (set! r15 L.rp.24)
        (jump L.-.13)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.25)
        (jump L.*.14)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 464)
        (set! rdi 1376)
        (set! r15 L.rp.26)
        (jump L.-.13)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 120))
        (set! rsi 656)
        (set! rdi 776)
        (set! r15 L.rp.27)
        (jump L.-.13)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.28)
        (jump L.*.14)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.29)
        (jump L.*.14)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.30)
        (jump L.-.13)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! r15 L.rp.31)
        (jump L.fun/empty128001.7)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! r15 L.rp.32)
        (jump L.fun/void128003.11)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! r15 L.rp.33)
        (jump L.fun/error128005.4)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi 928)
        (set! rdi 816)
        (set! r15 L.rp.34)
        (jump L.*.14)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 824)
        (set! rdi 1728)
        (set! r15 L.rp.35)
        (jump L.+.15)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.36)
        (jump L.*.14)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 120))
        (set! rsi 1736)
        (set! rdi 1480)
        (set! r15 L.rp.37)
        (jump L.+.15)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 776)
        (set! rdi 1816)
        (set! r15 L.rp.38)
        (jump L.*.14)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.39)
        (jump L.*.14)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.40)
        (jump L.+.15)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 120))
        (set! rsi 1104)
        (set! rdi 1272)
        (set! r15 L.rp.41)
        (jump L.+.15)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 1264)
        (set! rdi 1912)
        (set! r15 L.rp.42)
        (jump L.-.13)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.43)
        (jump L.-.13)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 848)
        (set! rdi 1968)
        (set! r15 L.rp.44)
        (jump L.-.13)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 120))
        (set! rsi 8)
        (set! rdi 1560)
        (set! r15 L.rp.45)
        (jump L.-.13)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.46)
        (jump L.*.14)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.47)
        (jump L.-.13)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.48)
        (jump L.-.13)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! r15 L.rp.49)
        (jump L.fun/empty128007.10)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.40
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.20)
        (jump L.fun/empty138300.14)))
    (define L.+.19
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.48) (jump L.tmp.49))))
    (define L.tmp.48 (begin (set! r9 14) (jump L.tmp.50)))
    (define L.tmp.49 (begin (set! r9 6) (jump L.tmp.50)))
    (define L.tmp.50 (if (!= r9 6) (jump L.__nested.41) (jump L.__nested.42)))
    (define L.tmp.45 (begin (set! r9 14) (jump L.tmp.47)))
    (define L.tmp.46 (begin (set! r9 6) (jump L.tmp.47)))
    (define L.tmp.47 (if (!= r9 6) (jump L.__nested.43) (jump L.__nested.44)))
    (define L.__nested.43
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.44 (begin (set! rax 574) (jump r15)))
    (define L.__nested.41
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.45) (jump L.tmp.46))))
    (define L.__nested.42 (begin (set! rax 574) (jump r15)))
    (define L.*.18
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.58) (jump L.tmp.59))))
    (define L.tmp.58 (begin (set! r9 14) (jump L.tmp.60)))
    (define L.tmp.59 (begin (set! r9 6) (jump L.tmp.60)))
    (define L.tmp.60 (if (!= r9 6) (jump L.__nested.51) (jump L.__nested.52)))
    (define L.tmp.55 (begin (set! r9 14) (jump L.tmp.57)))
    (define L.tmp.56 (begin (set! r9 6) (jump L.tmp.57)))
    (define L.tmp.57 (if (!= r9 6) (jump L.__nested.53) (jump L.__nested.54)))
    (define L.__nested.53
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.54 (begin (set! rax 318) (jump r15)))
    (define L.__nested.51
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.55) (jump L.tmp.56))))
    (define L.__nested.52 (begin (set! rax 318) (jump r15)))
    (define L.-.17
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.68) (jump L.tmp.69))))
    (define L.tmp.68 (begin (set! r9 14) (jump L.tmp.70)))
    (define L.tmp.69 (begin (set! r9 6) (jump L.tmp.70)))
    (define L.tmp.70 (if (!= r9 6) (jump L.__nested.61) (jump L.__nested.62)))
    (define L.tmp.65 (begin (set! r9 14) (jump L.tmp.67)))
    (define L.tmp.66 (begin (set! r9 6) (jump L.tmp.67)))
    (define L.tmp.67 (if (!= r9 6) (jump L.__nested.63) (jump L.__nested.64)))
    (define L.__nested.63
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.64 (begin (set! rax 830) (jump r15)))
    (define L.__nested.61
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.65) (jump L.tmp.66))))
    (define L.__nested.62 (begin (set! rax 830) (jump r15)))
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
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.21)
        (jump L.fun/ascii-char138302.9)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.22)
        (jump L.fun/empty138304.6)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.23)
        (jump L.fun/empty138306.8)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 1600)
        (set! rdi 2024)
        (set! r15 L.rp.24)
        (jump L.-.17)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 376)
        (set! rdi 1728)
        (set! r15 L.rp.25)
        (jump L.*.18)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.26)
        (jump L.+.19)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 272)
        (set! rdi 1504)
        (set! r15 L.rp.27)
        (jump L.*.18)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 72)
        (set! rdi 360)
        (set! r15 L.rp.28)
        (jump L.*.18)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.29)
        (jump L.-.17)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.30)
        (jump L.*.18)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1448)
        (set! rdi 1984)
        (set! r15 L.rp.31)
        (jump L.-.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 24)
        (set! rdi 1992)
        (set! r15 L.rp.32)
        (jump L.*.18)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.33)
        (jump L.*.18)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1576)
        (set! rdi 856)
        (set! r15 L.rp.34)
        (jump L.+.19)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 256)
        (set! rdi 1424)
        (set! r15 L.rp.35)
        (jump L.-.17)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.36)
        (jump L.*.18)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.37)
        (jump L.+.19)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.38)
        (jump L.*.18)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.39)
        (jump L.fun/ascii-char138308.10)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error138310.11)))))
(check-by-interp
 '(module
    (define L.__main.42
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.20)
        (jump L.fun/ascii-char139281.5)))
    (define L.boolean?.19
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 247))
        (set! r14 r14)
        (if (= r14 6) (jump L.__nested.43) (jump L.__nested.44))))
    (define L.__nested.43 (begin (set! rax 14) (jump r15)))
    (define L.__nested.44 (begin (set! rax 6) (jump r15)))
    (define L.+.18
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.52) (jump L.tmp.53))))
    (define L.tmp.52 (begin (set! r9 14) (jump L.tmp.54)))
    (define L.tmp.53 (begin (set! r9 6) (jump L.tmp.54)))
    (define L.tmp.54 (if (!= r9 6) (jump L.__nested.45) (jump L.__nested.46)))
    (define L.tmp.49 (begin (set! r9 14) (jump L.tmp.51)))
    (define L.tmp.50 (begin (set! r9 6) (jump L.tmp.51)))
    (define L.tmp.51 (if (!= r9 6) (jump L.__nested.47) (jump L.__nested.48)))
    (define L.__nested.47
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.48 (begin (set! rax 574) (jump r15)))
    (define L.__nested.45
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.49) (jump L.tmp.50))))
    (define L.__nested.46 (begin (set! rax 574) (jump r15)))
    (define L.-.17
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.62) (jump L.tmp.63))))
    (define L.tmp.62 (begin (set! r9 14) (jump L.tmp.64)))
    (define L.tmp.63 (begin (set! r9 6) (jump L.tmp.64)))
    (define L.tmp.64 (if (!= r9 6) (jump L.__nested.55) (jump L.__nested.56)))
    (define L.tmp.59 (begin (set! r9 14) (jump L.tmp.61)))
    (define L.tmp.60 (begin (set! r9 6) (jump L.tmp.61)))
    (define L.tmp.61 (if (!= r9 6) (jump L.__nested.57) (jump L.__nested.58)))
    (define L.__nested.57
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.58 (begin (set! rax 830) (jump r15)))
    (define L.__nested.55
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.59) (jump L.tmp.60))))
    (define L.__nested.56 (begin (set! rax 830) (jump r15)))
    (define L.*.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.72) (jump L.tmp.73))))
    (define L.tmp.72 (begin (set! r9 14) (jump L.tmp.74)))
    (define L.tmp.73 (begin (set! r9 6) (jump L.tmp.74)))
    (define L.tmp.74 (if (!= r9 6) (jump L.__nested.65) (jump L.__nested.66)))
    (define L.tmp.69 (begin (set! r9 14) (jump L.tmp.71)))
    (define L.tmp.70 (begin (set! r9 6) (jump L.tmp.71)))
    (define L.tmp.71 (if (!= r9 6) (jump L.__nested.67) (jump L.__nested.68)))
    (define L.__nested.67
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.68 (begin (set! rax 318) (jump r15)))
    (define L.__nested.65
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.69) (jump L.tmp.70))))
    (define L.__nested.66 (begin (set! rax 318) (jump r15)))
    (define L.fixnum?.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 0) (jump L.__nested.75) (jump L.__nested.76))))
    (define L.__nested.75 (begin (set! rax 14) (jump r15)))
    (define L.__nested.76 (begin (set! rax 6) (jump r15)))
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
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.21)
        (jump L.fun/error139283.6)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.22)
        (jump L.fun/any139285.11)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rdi r15)
        (set! r15 L.rp.23)
        (jump L.fixnum?.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.24)
        (jump L.fun/empty139286.13)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 1832)
        (set! rdi 1960)
        (set! r15 L.rp.25)
        (jump L.*.16)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 768)
        (set! rdi 1680)
        (set! r15 L.rp.26)
        (jump L.-.17)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.27)
        (jump L.-.17)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1520)
        (set! rdi 856)
        (set! r15 L.rp.28)
        (jump L.-.17)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1096)
        (set! rdi 1264)
        (set! r15 L.rp.29)
        (jump L.*.16)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.30)
        (jump L.-.17)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.31)
        (jump L.+.18)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 96)
        (set! rdi 160)
        (set! r15 L.rp.32)
        (jump L.+.18)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 240)
        (set! rdi 696)
        (set! r15 L.rp.33)
        (jump L.-.17)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.34)
        (jump L.*.16)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1704)
        (set! rdi 880)
        (set! r15 L.rp.35)
        (jump L.*.16)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1640)
        (set! rdi 1696)
        (set! r15 L.rp.36)
        (jump L.*.16)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.37)
        (jump L.-.17)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.38)
        (jump L.+.18)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.39)
        (jump L.+.18)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.40)
        (jump L.fun/any139288.8)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rdi r15)
        (set! r15 L.rp.41)
        (jump L.boolean?.19)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/void139289.12)))))
(check-by-interp
 '(module
    (define L.__main.74
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 240))
        (set! rsi 336)
        (set! rdi 1776)
        (set! r15 L.rp.12)
        (jump L.*.9)))
    (define L.-.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.82) (jump L.tmp.83))))
    (define L.tmp.82 (begin (set! r9 14) (jump L.tmp.84)))
    (define L.tmp.83 (begin (set! r9 6) (jump L.tmp.84)))
    (define L.tmp.84 (if (!= r9 6) (jump L.__nested.75) (jump L.__nested.76)))
    (define L.tmp.79 (begin (set! r9 14) (jump L.tmp.81)))
    (define L.tmp.80 (begin (set! r9 6) (jump L.tmp.81)))
    (define L.tmp.81 (if (!= r9 6) (jump L.__nested.77) (jump L.__nested.78)))
    (define L.__nested.77
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.78 (begin (set! rax 830) (jump r15)))
    (define L.__nested.75
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.79) (jump L.tmp.80))))
    (define L.__nested.76 (begin (set! rax 830) (jump r15)))
    (define L.+.10
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.92) (jump L.tmp.93))))
    (define L.tmp.92 (begin (set! r9 14) (jump L.tmp.94)))
    (define L.tmp.93 (begin (set! r9 6) (jump L.tmp.94)))
    (define L.tmp.94 (if (!= r9 6) (jump L.__nested.85) (jump L.__nested.86)))
    (define L.tmp.89 (begin (set! r9 14) (jump L.tmp.91)))
    (define L.tmp.90 (begin (set! r9 6) (jump L.tmp.91)))
    (define L.tmp.91 (if (!= r9 6) (jump L.__nested.87) (jump L.__nested.88)))
    (define L.__nested.87
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.88 (begin (set! rax 574) (jump r15)))
    (define L.__nested.85
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.89) (jump L.tmp.90))))
    (define L.__nested.86 (begin (set! rax 574) (jump r15)))
    (define L.*.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.102) (jump L.tmp.103))))
    (define L.tmp.102 (begin (set! r9 14) (jump L.tmp.104)))
    (define L.tmp.103 (begin (set! r9 6) (jump L.tmp.104)))
    (define L.tmp.104 (if (!= r9 6) (jump L.__nested.95) (jump L.__nested.96)))
    (define L.tmp.99 (begin (set! r9 14) (jump L.tmp.101)))
    (define L.tmp.100 (begin (set! r9 6) (jump L.tmp.101)))
    (define L.tmp.101 (if (!= r9 6) (jump L.__nested.97) (jump L.__nested.98)))
    (define L.__nested.97
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.98 (begin (set! rax 318) (jump r15)))
    (define L.__nested.95
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.99) (jump L.tmp.100))))
    (define L.__nested.96 (begin (set! rax 318) (jump r15)))
    (define L.fun/void140574.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty140576.5
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty140575.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty140576.5)))
    (define L.fun/void140573.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void140574.4)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 728)
        (set! rdi 728)
        (set! r15 L.rp.13)
        (jump L.+.10)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.14)
        (jump L.*.9)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1264)
        (set! rdi 1176)
        (set! r15 L.rp.15)
        (jump L.+.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 984)
        (set! rdi 496)
        (set! r15 L.rp.16)
        (jump L.-.11)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.17)
        (jump L.*.9)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.18)
        (jump L.-.11)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1616)
        (set! rdi 1520)
        (set! r15 L.rp.19)
        (jump L.+.10)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1392)
        (set! rdi 24)
        (set! r15 L.rp.20)
        (jump L.+.10)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.21)
        (jump L.+.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1456)
        (set! rdi 824)
        (set! r15 L.rp.22)
        (jump L.+.10)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 240)
        (set! rdi 1952)
        (set! r15 L.rp.23)
        (jump L.+.10)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.24)
        (jump L.-.11)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.25)
        (jump L.-.11)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -216))
        (set! r15 L.rp.26)
        (jump L.*.9)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi 816)
        (set! rdi 1424)
        (set! r15 L.rp.27)
        (jump L.*.9)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1520)
        (set! rdi 784)
        (set! r15 L.rp.28)
        (jump L.-.11)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.29)
        (jump L.+.10)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1680)
        (set! rdi 2032)
        (set! r15 L.rp.30)
        (jump L.-.11)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 328)
        (set! rdi 1776)
        (set! r15 L.rp.31)
        (jump L.*.9)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.32)
        (jump L.+.10)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.33)
        (jump L.*.9)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1216)
        (set! rdi 2000)
        (set! r15 L.rp.34)
        (jump L.+.10)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1280)
        (set! rdi 1928)
        (set! r15 L.rp.35)
        (jump L.+.10)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.36)
        (jump L.-.11)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 240))
        (set! rsi 488)
        (set! rdi 120)
        (set! r15 L.rp.37)
        (jump L.-.11)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 280)
        (set! rdi 1032)
        (set! r15 L.rp.38)
        (jump L.-.11)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.39)
        (jump L.-.11)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -216))
        (set! r15 L.rp.40)
        (jump L.+.10)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.41)
        (jump L.+.10)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi 1984)
        (set! rdi 888)
        (set! r15 L.rp.42)
        (jump L.+.10)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 888)
        (set! rdi 1024)
        (set! r15 L.rp.43)
        (jump L.-.11)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.44)
        (jump L.*.9)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 8)
        (set! rdi 504)
        (set! r15 L.rp.45)
        (jump L.+.10)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1544)
        (set! rdi 512)
        (set! r15 L.rp.46)
        (jump L.*.9)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.47)
        (jump L.+.10)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.48)
        (jump L.-.11)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 240))
        (set! rsi 760)
        (set! rdi 288)
        (set! r15 L.rp.49)
        (jump L.*.9)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 960)
        (set! rdi 880)
        (set! r15 L.rp.50)
        (jump L.-.11)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.51)
        (jump L.+.10)))
    (define L.rp.51
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1288)
        (set! rdi 1000)
        (set! r15 L.rp.52)
        (jump L.+.10)))
    (define L.rp.52
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 48)
        (set! rdi 1744)
        (set! r15 L.rp.53)
        (jump L.+.10)))
    (define L.rp.53
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.54)
        (jump L.*.9)))
    (define L.rp.54
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -232))
        (set! r15 L.rp.55)
        (jump L.-.11)))
    (define L.rp.55
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -216))
        (set! r15 L.rp.56)
        (jump L.*.9)))
    (define L.rp.56
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! r15 L.rp.57)
        (jump L.fun/void140573.7)))
    (define L.rp.57
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1960)
        (set! rdi 1272)
        (set! r15 L.rp.58)
        (jump L.-.11)))
    (define L.rp.58
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 648)
        (set! rdi 1632)
        (set! r15 L.rp.59)
        (jump L.-.11)))
    (define L.rp.59
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.60)
        (jump L.-.11)))
    (define L.rp.60
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1632)
        (set! rdi 712)
        (set! r15 L.rp.61)
        (jump L.-.11)))
    (define L.rp.61
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 552)
        (set! rdi 216)
        (set! r15 L.rp.62)
        (jump L.*.9)))
    (define L.rp.62
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.63)
        (jump L.-.11)))
    (define L.rp.63
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -216))
        (set! r15 L.rp.64)
        (jump L.-.11)))
    (define L.rp.64
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1296)
        (set! rdi 1944)
        (set! r15 L.rp.65)
        (jump L.-.11)))
    (define L.rp.65
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1872)
        (set! rdi 1872)
        (set! r15 L.rp.66)
        (jump L.+.10)))
    (define L.rp.66
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.67)
        (jump L.+.10)))
    (define L.rp.67
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 240))
        (set! rsi 1744)
        (set! rdi 1128)
        (set! r15 L.rp.68)
        (jump L.+.10)))
    (define L.rp.68
      (begin
        (set! rbp (+ rbp 240))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 240))
        (set! rsi 480)
        (set! rdi 944)
        (set! r15 L.rp.69)
        (jump L.*.9)))
    (define L.rp.69
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -216))
        (set! r15 L.rp.70)
        (jump L.-.11)))
    (define L.rp.70
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -224))
        (set! r15 L.rp.71)
        (jump L.-.11)))
    (define L.rp.71
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! rsi r15)
        (set! rdi (rbp - -208))
        (set! r15 L.rp.72)
        (jump L.-.11)))
    (define L.rp.72
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rbp (- rbp 240))
        (set! r15 L.rp.73)
        (jump L.fun/empty140575.6)))
    (define L.rp.73
      (begin
        (set! rbp (+ rbp 240))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.64
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 176))
        (set! rsi 1392)
        (set! rdi 544)
        (set! r15 L.rp.16)
        (jump L.+.13)))
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.72) (jump L.tmp.73))))
    (define L.tmp.72 (begin (set! r9 14) (jump L.tmp.74)))
    (define L.tmp.73 (begin (set! r9 6) (jump L.tmp.74)))
    (define L.tmp.74 (if (!= r9 6) (jump L.__nested.65) (jump L.__nested.66)))
    (define L.tmp.69 (begin (set! r9 14) (jump L.tmp.71)))
    (define L.tmp.70 (begin (set! r9 6) (jump L.tmp.71)))
    (define L.tmp.71 (if (!= r9 6) (jump L.__nested.67) (jump L.__nested.68)))
    (define L.__nested.67
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.68 (begin (set! rax 830) (jump r15)))
    (define L.__nested.65
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.69) (jump L.tmp.70))))
    (define L.__nested.66 (begin (set! rax 830) (jump r15)))
    (define L.*.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.82) (jump L.tmp.83))))
    (define L.tmp.82 (begin (set! r9 14) (jump L.tmp.84)))
    (define L.tmp.83 (begin (set! r9 6) (jump L.tmp.84)))
    (define L.tmp.84 (if (!= r9 6) (jump L.__nested.75) (jump L.__nested.76)))
    (define L.tmp.79 (begin (set! r9 14) (jump L.tmp.81)))
    (define L.tmp.80 (begin (set! r9 6) (jump L.tmp.81)))
    (define L.tmp.81 (if (!= r9 6) (jump L.__nested.77) (jump L.__nested.78)))
    (define L.__nested.77
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.78 (begin (set! rax 318) (jump r15)))
    (define L.__nested.75
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.79) (jump L.tmp.80))))
    (define L.__nested.76 (begin (set! rax 318) (jump r15)))
    (define L.+.13
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.92) (jump L.tmp.93))))
    (define L.tmp.92 (begin (set! r9 14) (jump L.tmp.94)))
    (define L.tmp.93 (begin (set! r9 6) (jump L.tmp.94)))
    (define L.tmp.94 (if (!= r9 6) (jump L.__nested.85) (jump L.__nested.86)))
    (define L.tmp.89 (begin (set! r9 14) (jump L.tmp.91)))
    (define L.tmp.90 (begin (set! r9 6) (jump L.tmp.91)))
    (define L.tmp.91 (if (!= r9 6) (jump L.__nested.87) (jump L.__nested.88)))
    (define L.__nested.87
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.88 (begin (set! rax 574) (jump r15)))
    (define L.__nested.85
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.89) (jump L.tmp.90))))
    (define L.__nested.86 (begin (set! rax 574) (jump r15)))
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
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1344)
        (set! rdi 360)
        (set! r15 L.rp.17)
        (jump L.*.14)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.18)
        (jump L.-.15)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 288)
        (set! rdi 1888)
        (set! r15 L.rp.19)
        (jump L.-.15)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 800)
        (set! rdi 968)
        (set! r15 L.rp.20)
        (jump L.-.15)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.21)
        (jump L.*.14)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.22)
        (jump L.*.14)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 176))
        (set! rsi 912)
        (set! rdi 32)
        (set! r15 L.rp.23)
        (jump L.*.14)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1744)
        (set! rdi 688)
        (set! r15 L.rp.24)
        (jump L.+.13)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.25)
        (jump L.-.15)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 568)
        (set! rdi 304)
        (set! r15 L.rp.26)
        (jump L.-.15)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 256)
        (set! rdi 1344)
        (set! r15 L.rp.27)
        (jump L.*.14)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.28)
        (jump L.*.14)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.29)
        (jump L.+.13)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.30)
        (jump L.*.14)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi 1384)
        (set! rdi 1648)
        (set! r15 L.rp.31)
        (jump L.+.13)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 488)
        (set! rdi 1664)
        (set! r15 L.rp.32)
        (jump L.*.14)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.33)
        (jump L.*.14)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 192)
        (set! rdi 1624)
        (set! r15 L.rp.34)
        (jump L.+.13)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 416)
        (set! rdi 1080)
        (set! r15 L.rp.35)
        (jump L.*.14)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.36)
        (jump L.+.13)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.37)
        (jump L.+.13)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1496)
        (set! rdi 1936)
        (set! r15 L.rp.38)
        (jump L.+.13)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 80)
        (set! rdi 344)
        (set! r15 L.rp.39)
        (jump L.+.13)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.40)
        (jump L.-.15)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1656)
        (set! rdi 1728)
        (set! r15 L.rp.41)
        (jump L.*.14)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1408)
        (set! rdi 1040)
        (set! r15 L.rp.42)
        (jump L.*.14)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.43)
        (jump L.-.15)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.44)
        (jump L.+.13)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.45)
        (jump L.*.14)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! r15 L.rp.46)
        (jump L.fun/void143923.9)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! r15 L.rp.47)
        (jump L.fun/void143925.10)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! r15 L.rp.48)
        (jump L.fun/error143927.4)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi 1064)
        (set! rdi 464)
        (set! r15 L.rp.49)
        (jump L.-.15)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1200)
        (set! rdi 664)
        (set! r15 L.rp.50)
        (jump L.*.14)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.51)
        (jump L.-.15)))
    (define L.rp.51
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 848)
        (set! rdi 1152)
        (set! r15 L.rp.52)
        (jump L.*.14)))
    (define L.rp.52
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1976)
        (set! rdi 448)
        (set! r15 L.rp.53)
        (jump L.*.14)))
    (define L.rp.53
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.54)
        (jump L.+.13)))
    (define L.rp.54
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.55)
        (jump L.-.15)))
    (define L.rp.55
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 128)
        (set! rdi 16)
        (set! r15 L.rp.56)
        (jump L.+.13)))
    (define L.rp.56
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 88)
        (set! rdi 1704)
        (set! r15 L.rp.57)
        (jump L.+.13)))
    (define L.rp.57
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.58)
        (jump L.-.15)))
    (define L.rp.58
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 176))
        (set! rsi 472)
        (set! rdi 1280)
        (set! r15 L.rp.59)
        (jump L.*.14)))
    (define L.rp.59
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 752)
        (set! rdi 472)
        (set! r15 L.rp.60)
        (jump L.+.13)))
    (define L.rp.60
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.61)
        (jump L.-.15)))
    (define L.rp.61
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.62)
        (jump L.+.13)))
    (define L.rp.62
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.63)
        (jump L.+.13)))
    (define L.rp.63
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char143929.5)))))
