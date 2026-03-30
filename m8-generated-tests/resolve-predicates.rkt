#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         "../resolve-predicates.rkt")
(define (fail-if-invalid p)
  (when (not (block-asm-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "block-asm-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-block-pred-lang-v8 p)
  (interp-block-asm-lang-v8 (fail-if-invalid (resolve-predicates p)))))

(check-by-interp
 '(module (define L.__main.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.6
      (begin
        (set! r15 r15)
        (set! rsi 3816)
        (set! rdi 1808)
        (set! r15 r15)
        (jump L.cons.5)))
    (define L.cons.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.5
      (begin (set! r15 r15) (set! r14 27438) (set! rax 22) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.5
      (begin (set! r15 r15) (set! r14 30) (set! rax 31790) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.6
      (begin
        (set! r15 r15)
        (set! r14 30)
        (set! rsi 3704)
        (set! rdi 1624)
        (set! r15 r15)
        (jump L.cons.5)))
    (define L.cons.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/fixnum8389.4)))
    (define L.fun/fixnum8389.4
      (begin (set! r15 r15) (set! rax 1672) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.5
      (begin
        (set! r15 r15)
        (set! r14 6)
        (set! r14 30)
        (set! rax 30)
        (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.9
      (begin
        (set! r15 r15)
        (set! r14 14)
        (if (true) (jump L.tmp.6) (jump L.tmp.7))))
    (define L.fun/fixnum8394.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 312) (jump r15)))
    (define L.tmp.6 (begin (set! r14 15934) (jump L.tmp.8)))
    (define L.tmp.7 (begin (set! r14 45118) (jump L.tmp.8)))
    (define L.tmp.8
      (begin (set! rdi r14) (set! r15 r15) (jump L.fun/fixnum8394.4)))))
(check-by-interp
 '(module
    (define L.__main.8
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! rdi 22)
        (set! r15 L.rp.7)
        (jump L.fun/void8402.5)))
    (define L.fun/error8401.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 1854) (jump r15)))
    (define L.fun/void8402.5
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 30) (jump r15)))
    (define L.rp.7
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rdi r15)
        (set! r15 (rbp - 0))
        (jump L.fun/error8401.4)))))
(check-by-interp
 '(module
    (define L.__main.7
      (begin
        (set! (rbp - 0) r15)
        (set! (rbp - 8) 18222)
        (set! rbp (- rbp 16))
        (set! rsi 2272)
        (set! rdi 832)
        (set! r15 L.rp.6)
        (jump L.cons.5)))
    (define L.cons.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
        (set! r9 r9)
        (set! r9 (+ r9 1))
        (set! r9 r9)
        (mset! r9 -1 r14)
        (mset! r9 7 r13)
        (set! rax r9)
        (jump r15)))
    (define L.rp.6
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.10
      (begin
        (set! r15 r15)
        (set! r14 14)
        (if (true) (jump L.tmp.7) (jump L.tmp.8))))
    (define L.cons.6
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.tmp.7 (begin (set! r14 17454) (jump L.tmp.9)))
    (define L.tmp.8 (begin (set! r14 17966) (jump L.tmp.9)))
    (define L.tmp.9
      (begin (set! rdi r14) (set! r15 r15) (jump L.fun/pair8407.4)))))
(check-by-interp
 '(module
    (define L.__main.5
      (begin
        (set! r15 r15)
        (set! r14 1712)
        (set! r14 14)
        (set! rax 1864)
        (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.5
      (begin
        (set! r15 r15)
        (set! r14 13118)
        (set! r14 14)
        (set! rax r14)
        (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.13
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! rsi 456)
        (set! rdi 14)
        (set! r15 L.rp.9)
        (jump L.fun/boolean8418.5)))
    (define L.cons.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (if (!= r15 6) (jump L.__nested.11) (jump L.__nested.12))))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi 22)
        (set! r15 (rbp - 0))
        (jump L.fun/error8420.6)))
    (define L.__nested.11
      (begin
        (set! rsi 22)
        (set! rdi 14)
        (set! r15 (rbp - 0))
        (jump L.fun/error8419.4)))
    (define L.__nested.12
      (begin
        (set! rbp (- rbp 8))
        (set! rsi 3240)
        (set! rdi 208)
        (set! r15 L.rp.10)
        (jump L.cons.8)))))
(check-by-interp
 '(module
    (define L.__main.13
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.10)
        (jump L.fun/ascii-char8439.4)))
    (define L.+.9
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.17 (begin (set! rax 574) (jump r15)))
    (define L.__nested.14
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.18) (jump L.tmp.19))))
    (define L.__nested.15 (begin (set! rax 574) (jump r15)))
    (define L.cons.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.11)
        (jump L.fun/error8440.5)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.12)
        (jump L.fun/pair8441.6)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rsi 1064)
        (set! rdi 2024)
        (set! r15 (rbp - 0))
        (jump L.+.9)))))
(check-by-interp
 '(module
    (define L.__main.16
      (begin
        (set! (rbp - 0) r15)
        (set! r15 6)
        (if (false) (jump L.tmp.13) (jump L.tmp.14))))
    (define L.empty?.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 22) (jump L.__nested.17) (jump L.__nested.18))))
    (define L.__nested.17 (begin (set! rax 14) (jump r15)))
    (define L.__nested.18 (begin (set! rax 6) (jump r15)))
    (define L.cons.7
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.tmp.13 (begin (set! r15 54078) (jump L.tmp.15)))
    (define L.tmp.14 (begin (set! r15 38718) (jump L.tmp.15)))
    (define L.tmp.15
      (begin
        (set! rbp (- rbp 8))
        (set! rdi r15)
        (set! r15 L.rp.9)
        (jump L.empty?.8)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! r14 6)
        (if (false) (jump L.tmp.10) (jump L.tmp.11))))
    (define L.tmp.10 (begin (set! r14 30) (jump L.tmp.12)))
    (define L.tmp.11 (begin (set! r14 30) (jump L.tmp.12)))
    (define L.tmp.12
      (begin
        (set! rsi r14)
        (set! rdi r15)
        (set! r15 (rbp - 0))
        (jump L.fun/pair8458.5)))))
(check-by-interp
 '(module
    (define L.__main.12
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.9)
        (jump L.fun/ascii-char8462.5)))
    (define L.pair?.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 1) (jump L.__nested.13) (jump L.__nested.14))))
    (define L.__nested.13 (begin (set! rax 14) (jump r15)))
    (define L.__nested.14 (begin (set! rax 6) (jump r15)))
    (define L.fun/ascii-char8463.4
      (begin (set! r15 r15) (set! rax 22574) (jump r15)))
    (define L.fun/ascii-char8462.5
      (begin (set! r15 r15) (set! rax 10286) (jump r15)))
    (define L.fun/error8464.6
      (begin (set! r15 r15) (set! rax 5694) (jump r15)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.10)
        (jump L.fun/ascii-char8463.4)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! rdi 14)
        (set! r15 L.rp.11)
        (jump L.pair?.8)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error8464.6)))))
(check-by-interp
 '(module
    (define L.__main.9
      (begin
        (set! r15 r15)
        (set! r14 6)
        (set! r13 1448)
        (set! r13 6)
        (if (false) (jump L.__nested.5) (jump L.__nested.6))))
    (define L.__nested.7 (begin (set! rax 416) (jump r15)))
    (define L.__nested.8 (begin (set! rax 664) (jump r15)))
    (define L.__nested.5
      (begin
        (set! r14 1104)
        (set! r13 14)
        (set! r13 64318)
        (set! rax r14)
        (jump r15)))
    (define L.__nested.6
      (begin
        (set! r14 14)
        (if (true) (jump L.__nested.7) (jump L.__nested.8))))))
(check-by-interp
 '(module
    (define L.__main.14
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.10)
        (jump L.fun/empty8482.7)))
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.11)
        (jump L.fun/pair8483.6)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.12)
        (jump L.fun/void8484.4)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.13)
        (jump L.fun/empty8485.5)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.19
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! rsi 1784)
        (set! rdi 1400)
        (set! r15 L.rp.13)
        (jump L.*.10)))
    (define L.+.12
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.23 (begin (set! rax 574) (jump r15)))
    (define L.__nested.20
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.24) (jump L.tmp.25))))
    (define L.__nested.21 (begin (set! rax 574) (jump r15)))
    (define L.-.11
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
    (define L.*.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.43 (begin (set! rax 318) (jump r15)))
    (define L.__nested.40
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.44) (jump L.tmp.45))))
    (define L.__nested.41 (begin (set! rax 318) (jump r15)))
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! rsi 2024)
        (set! rdi 1776)
        (set! r15 L.rp.14)
        (jump L.-.11)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! rsi r15)
        (set! rdi (rbp - -8))
        (set! r15 L.rp.15)
        (jump L.+.12)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.16)
        (jump L.fun/void8498.7)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.17)
        (jump L.fun/pair8499.5)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.18)
        (jump L.fun/void8500.6)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error8501.4)))))
(check-by-interp
 '(module
    (define L.__main.37
      (begin
        (set! (rbp - 0) r15)
        (set! r15 30510)
        (set! r15 30)
        (set! r15 22)
        (set! r15 28222)
        (set! r15 14)
        (if (true) (jump L.tmp.34) (jump L.tmp.35))))
    (define L.pair?.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 1) (jump L.__nested.38) (jump L.__nested.39))))
    (define L.__nested.38 (begin (set! rax 14) (jump r15)))
    (define L.__nested.39 (begin (set! rax 6) (jump r15)))
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.11
      (begin (set! rbp (+ rbp 24)) (set! (rbp - 8) rax) (jump L.tmp.36)))
    (define L.rp.12
      (begin (set! rbp (+ rbp 24)) (set! (rbp - 8) rax) (jump L.tmp.36)))
    (define L.tmp.34
      (begin
        (set! rbp (- rbp 24))
        (set! rdx 12078)
        (set! rsi 23870)
        (set! rdi 28974)
        (set! r15 L.rp.11)
        (jump L.fun/ascii-char8511.6)))
    (define L.tmp.35
      (begin
        (set! rbp (- rbp 24))
        (set! rdx 11838)
        (set! rsi 13102)
        (set! rdi 25134)
        (set! r15 L.rp.12)
        (jump L.fun/ascii-char8512.4)))
    (define L.tmp.36
      (begin
        (set! rbp (- rbp 24))
        (set! rsi 3600)
        (set! rdi 688)
        (set! r15 L.rp.13)
        (jump L.cons.9)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rdi r15)
        (set! r15 L.rp.14)
        (jump L.pair?.10)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (if (!= r15 6) (jump L.tmp.25) (jump L.tmp.26))))
    (define L.tmp.28 (begin (set! (rbp - 16) 58942) (jump L.tmp.30)))
    (define L.tmp.29 (begin (set! (rbp - 16) 23102) (jump L.tmp.30)))
    (define L.tmp.30 (jump L.tmp.27))
    (define L.tmp.31 (begin (set! (rbp - 16) 54078) (jump L.tmp.33)))
    (define L.tmp.32 (begin (set! (rbp - 16) 19774) (jump L.tmp.33)))
    (define L.tmp.33 (jump L.tmp.27))
    (define L.tmp.25
      (begin (set! r15 14) (if (true) (jump L.tmp.28) (jump L.tmp.29))))
    (define L.tmp.26
      (begin (set! r15 6) (if (false) (jump L.tmp.31) (jump L.tmp.32))))
    (define L.tmp.27
      (begin
        (set! rbp (- rbp 24))
        (set! rdx 320)
        (set! rsi 1968)
        (set! rdi 416)
        (set! r15 L.rp.15)
        (jump L.fun/boolean8513.7)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (if (!= r15 6) (jump L.tmp.16) (jump L.tmp.17))))
    (define L.tmp.19 (begin (set! r15 18478) (jump L.tmp.21)))
    (define L.tmp.20 (begin (set! r15 19246) (jump L.tmp.21)))
    (define L.tmp.21 (jump L.tmp.18))
    (define L.tmp.22 (begin (set! r15 26414) (jump L.tmp.24)))
    (define L.tmp.23 (begin (set! r15 18990) (jump L.tmp.24)))
    (define L.tmp.24 (jump L.tmp.18))
    (define L.tmp.16
      (begin (set! r15 6) (if (false) (jump L.tmp.19) (jump L.tmp.20))))
    (define L.tmp.17
      (begin (set! r15 14) (if (true) (jump L.tmp.22) (jump L.tmp.23))))
    (define L.tmp.18
      (begin
        (set! rdx r15)
        (set! rsi (rbp - 16))
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char8510.5)))))
(check-by-interp
 '(module
    (define L.__main.13
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.9)
        (jump L.fun/error8544.6)))
    (define L.fun/ascii-char8546.4
      (begin (set! r15 r15) (set! rax 29486) (jump r15)))
    (define L.fun/empty8547.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error8544.6
      (begin (set! r15 r15) (set! rax 17982) (jump r15)))
    (define L.fun/ascii-char8545.7
      (begin (set! r15 r15) (set! rax 12334) (jump r15)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.10)
        (jump L.fun/ascii-char8545.7)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.11)
        (jump L.fun/ascii-char8546.4)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.12)
        (jump L.fun/empty8547.5)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.17
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.12)
        (jump L.fun/pair8681.5)))
    (define L.void?.11
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 30) (jump L.__nested.18) (jump L.__nested.19))))
    (define L.__nested.18 (begin (set! rax 14) (jump r15)))
    (define L.__nested.19 (begin (set! rax 6) (jump r15)))
    (define L.cons.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.13)
        (jump L.fun/error8682.8)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.14)
        (jump L.fun/error8683.6)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.15)
        (jump L.fun/pair8684.7)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.16)
        (jump L.fun/any8685.4)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rdi r15)
        (set! r15 (rbp - 0))
        (jump L.void?.11)))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.13)
        (jump L.fun/empty8893.4)))
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
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.14)
        (jump L.fun/empty8894.5)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi 200)
        (set! rdi 1632)
        (set! r15 L.rp.15)
        (jump L.*.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! rsi 904)
        (set! rdi 320)
        (set! r15 L.rp.16)
        (jump L.*.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -32))
        (set! r15 L.rp.17)
        (jump L.*.10)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 320)
        (set! rdi 712)
        (set! r15 L.rp.18)
        (jump L.-.11)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! rsi 928)
        (set! rdi 896)
        (set! r15 L.rp.19)
        (jump L.+.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -32))
        (set! r15 L.rp.20)
        (jump L.-.11)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.21)
        (jump L.-.11)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.22)
        (jump L.fun/pair8895.6)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.23)
        (jump L.fun/void8896.7)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.30
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 56))
        (set! rsi 1560)
        (set! rdi 864)
        (set! r15 L.rp.13)
        (jump L.+.10)))
    (define L.*.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.38) (jump L.tmp.39))))
    (define L.tmp.38 (begin (set! r9 14) (jump L.tmp.40)))
    (define L.tmp.39 (begin (set! r9 6) (jump L.tmp.40)))
    (define L.tmp.40 (if (!= r9 6) (jump L.__nested.31) (jump L.__nested.32)))
    (define L.tmp.35 (begin (set! r9 14) (jump L.tmp.37)))
    (define L.tmp.36 (begin (set! r9 6) (jump L.tmp.37)))
    (define L.tmp.37 (if (!= r9 6) (jump L.__nested.33) (jump L.__nested.34)))
    (define L.__nested.33
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.34 (begin (set! rax 318) (jump r15)))
    (define L.__nested.31
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.35) (jump L.tmp.36))))
    (define L.__nested.32 (begin (set! rax 318) (jump r15)))
    (define L.-.11
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.44 (begin (set! rax 830) (jump r15)))
    (define L.__nested.41
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.45) (jump L.tmp.46))))
    (define L.__nested.42 (begin (set! rax 830) (jump r15)))
    (define L.+.10
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
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1832)
        (set! rdi 1632)
        (set! r15 L.rp.14)
        (jump L.-.11)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.15)
        (jump L.*.12)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 56))
        (set! rsi 408)
        (set! rdi 408)
        (set! r15 L.rp.16)
        (jump L.+.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 88)
        (set! rdi 1168)
        (set! r15 L.rp.17)
        (jump L.+.10)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.18)
        (jump L.*.12)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.19)
        (jump L.-.11)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.20)
        (jump L.fun/error8906.5)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi 512)
        (set! rdi 1752)
        (set! r15 L.rp.21)
        (jump L.+.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1392)
        (set! rdi 1728)
        (set! r15 L.rp.22)
        (jump L.-.11)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.23)
        (jump L.*.12)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 56))
        (set! rsi 560)
        (set! rdi 136)
        (set! r15 L.rp.24)
        (jump L.*.12)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 984)
        (set! rdi 176)
        (set! r15 L.rp.25)
        (jump L.-.11)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.26)
        (jump L.-.11)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.27)
        (jump L.+.10)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.28)
        (jump L.fun/empty8907.4)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.29)
        (jump L.fun/pair8908.6)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/void8909.7)))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.13)
        (jump L.fun/pair9174.4)))
    (define L.*.12
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.28 (begin (set! rax 318) (jump r15)))
    (define L.__nested.25
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.29) (jump L.tmp.30))))
    (define L.__nested.26 (begin (set! rax 318) (jump r15)))
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
    (define L.+.10
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
    (define L.cons.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.14)
        (jump L.fun/ascii-char9175.5)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.15)
        (jump L.fun/empty9176.6)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.16)
        (jump L.fun/error9177.7)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! rsi 256)
        (set! rdi 1312)
        (set! r15 L.rp.17)
        (jump L.+.10)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 320)
        (set! rdi 1592)
        (set! r15 L.rp.18)
        (jump L.-.11)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.19)
        (jump L.+.10)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 40))
        (set! rsi 456)
        (set! rdi 1512)
        (set! r15 L.rp.20)
        (jump L.*.12)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 1776)
        (set! rdi 280)
        (set! r15 L.rp.21)
        (jump L.+.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.22)
        (jump L.-.11)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.23)
        (jump L.*.12)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.23
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 40))
        (set! rsi 992)
        (set! rdi 904)
        (set! r15 L.rp.12)
        (jump L.+.9)))
    (define L.*.11
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.27 (begin (set! rax 318) (jump r15)))
    (define L.__nested.24
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.28) (jump L.tmp.29))))
    (define L.__nested.25 (begin (set! rax 318) (jump r15)))
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
    (define L.+.9
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.47 (begin (set! rax 574) (jump r15)))
    (define L.__nested.44
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.48) (jump L.tmp.49))))
    (define L.__nested.45 (begin (set! rax 574) (jump r15)))
    (define L.fun/error9704.4
      (begin (set! r15 r15) (set! rax 56382) (jump r15)))
    (define L.fun/void9703.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void9702.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty9705.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! rsi 1512)
        (set! rdi 1656)
        (set! r15 L.rp.13)
        (jump L.-.10)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -32))
        (set! r15 L.rp.14)
        (jump L.-.10)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 1624)
        (set! rdi 1080)
        (set! r15 L.rp.15)
        (jump L.+.9)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! rsi 240)
        (set! rdi 296)
        (set! r15 L.rp.16)
        (jump L.*.11)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -32))
        (set! r15 L.rp.17)
        (jump L.+.9)))
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
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.19)
        (jump L.fun/void9702.6)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.20)
        (jump L.fun/void9703.5)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.21)
        (jump L.fun/error9704.4)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.22)
        (jump L.fun/empty9705.7)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.29
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.12)
        (jump L.fun/error9708.5)))
    (define L.*.11
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.33 (begin (set! rax 318) (jump r15)))
    (define L.__nested.30
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.34) (jump L.tmp.35))))
    (define L.__nested.31 (begin (set! rax 318) (jump r15)))
    (define L.+.10
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
    (define L.-.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.53 (begin (set! rax 830) (jump r15)))
    (define L.__nested.50
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.54) (jump L.tmp.55))))
    (define L.__nested.51 (begin (set! rax 830) (jump r15)))
    (define L.cons.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.13)
        (jump L.fun/void9709.6)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 152)
        (set! rdi 2000)
        (set! r15 L.rp.14)
        (jump L.-.9)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 416)
        (set! rdi 784)
        (set! r15 L.rp.15)
        (jump L.-.9)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.16)
        (jump L.-.9)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 240)
        (set! rdi 1824)
        (set! r15 L.rp.17)
        (jump L.-.9)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 312)
        (set! rdi 320)
        (set! r15 L.rp.18)
        (jump L.+.10)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.19)
        (jump L.+.10)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.20)
        (jump L.+.10)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 992)
        (set! rdi 216)
        (set! r15 L.rp.21)
        (jump L.*.11)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 568)
        (set! rdi 168)
        (set! r15 L.rp.22)
        (jump L.*.11)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.23)
        (jump L.+.10)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1352)
        (set! rdi 1248)
        (set! r15 L.rp.24)
        (jump L.+.10)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1632)
        (set! rdi 168)
        (set! r15 L.rp.25)
        (jump L.-.9)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.26)
        (jump L.+.10)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.27)
        (jump L.*.11)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.28)
        (jump L.fun/pair9710.4)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.25
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.14)
        (jump L.fun/pair9973.5)))
    (define L.*.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.29 (begin (set! rax 318) (jump r15)))
    (define L.__nested.26
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.30) (jump L.tmp.31))))
    (define L.__nested.27 (begin (set! rax 318) (jump r15)))
    (define L.-.12
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.39 (begin (set! rax 830) (jump r15)))
    (define L.__nested.36
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.40) (jump L.tmp.41))))
    (define L.__nested.37 (begin (set! rax 830) (jump r15)))
    (define L.+.11
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.49 (begin (set! rax 574) (jump r15)))
    (define L.__nested.46
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.50) (jump L.tmp.51))))
    (define L.__nested.47 (begin (set! rax 574) (jump r15)))
    (define L.cons.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.15)
        (jump L.fun/void9974.7)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.16)
        (jump L.fun/empty9975.6)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.17)
        (jump L.fun/void9976.4)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi 1288)
        (set! rdi 1608)
        (set! r15 L.rp.18)
        (jump L.+.11)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1528)
        (set! rdi 1992)
        (set! r15 L.rp.19)
        (jump L.-.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.20)
        (jump L.+.11)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1152)
        (set! rdi 688)
        (set! r15 L.rp.21)
        (jump L.-.12)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1848)
        (set! rdi 1048)
        (set! r15 L.rp.22)
        (jump L.*.13)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.23)
        (jump L.+.11)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.24)
        (jump L.-.12)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char9977.8)))))
(check-by-interp
 '(module
    (define L.__main.23
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.17)
        (jump L.fun/empty15775.12)))
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
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.18)
        (jump L.fun/error15777.8)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.19)
        (jump L.fun/ascii-char15779.11)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.20)
        (jump L.fun/ascii-char15781.10)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.21)
        (jump L.fun/empty15783.13)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.22)
        (jump L.fun/void15785.4)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.25
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.17)
        (jump L.fun/ascii-char18969.7)))
    (define L.void?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 30) (jump L.__nested.26) (jump L.__nested.27))))
    (define L.__nested.26 (begin (set! rax 14) (jump r15)))
    (define L.__nested.27 (begin (set! rax 6) (jump r15)))
    (define L.boolean?.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 247))
        (set! r14 r14)
        (if (= r14 6) (jump L.__nested.28) (jump L.__nested.29))))
    (define L.__nested.28 (begin (set! rax 14) (jump r15)))
    (define L.__nested.29 (begin (set! rax 6) (jump r15)))
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
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.18)
        (jump L.fun/void18971.9)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.19)
        (jump L.fun/any18973.13)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! rdi r15)
        (set! r15 L.rp.20)
        (jump L.boolean?.15)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.21)
        (jump L.fun/any18974.4)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! rdi r15)
        (set! r15 L.rp.22)
        (jump L.void?.16)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.23)
        (jump L.fun/error18975.11)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.24)
        (jump L.fun/void18977.5)))
    (define L.rp.24
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
        (set! rbp (- rbp 8))
        (set! r15 L.rp.18)
        (jump L.fun/error19372.14)))
    (define L.cons.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.19)
        (jump L.fun/error19374.15)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.20)
        (jump L.fun/ascii-char19376.10)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.21)
        (jump L.fun/empty19378.11)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.22)
        (jump L.fun/empty19380.13)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.23)
        (jump L.fun/pair19382.9)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.65
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 176))
        (set! r15 L.rp.16)
        (jump L.fun/ascii-char20850.5)))
    (define L.boolean?.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 247))
        (set! r14 r14)
        (if (= r14 6) (jump L.__nested.66) (jump L.__nested.67))))
    (define L.__nested.66 (begin (set! rax 14) (jump r15)))
    (define L.__nested.67 (begin (set! rax 6) (jump r15)))
    (define L.-.14
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.75) (jump L.tmp.76))))
    (define L.tmp.75 (begin (set! r9 14) (jump L.tmp.77)))
    (define L.tmp.76 (begin (set! r9 6) (jump L.tmp.77)))
    (define L.tmp.77 (if (!= r9 6) (jump L.__nested.68) (jump L.__nested.69)))
    (define L.tmp.72 (begin (set! r9 14) (jump L.tmp.74)))
    (define L.tmp.73 (begin (set! r9 6) (jump L.tmp.74)))
    (define L.tmp.74 (if (!= r9 6) (jump L.__nested.70) (jump L.__nested.71)))
    (define L.__nested.70
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.71 (begin (set! rax 830) (jump r15)))
    (define L.__nested.68
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.72) (jump L.tmp.73))))
    (define L.__nested.69 (begin (set! rax 830) (jump r15)))
    (define L.*.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.85) (jump L.tmp.86))))
    (define L.tmp.85 (begin (set! r9 14) (jump L.tmp.87)))
    (define L.tmp.86 (begin (set! r9 6) (jump L.tmp.87)))
    (define L.tmp.87 (if (!= r9 6) (jump L.__nested.78) (jump L.__nested.79)))
    (define L.tmp.82 (begin (set! r9 14) (jump L.tmp.84)))
    (define L.tmp.83 (begin (set! r9 6) (jump L.tmp.84)))
    (define L.tmp.84 (if (!= r9 6) (jump L.__nested.80) (jump L.__nested.81)))
    (define L.__nested.80
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.81 (begin (set! rax 318) (jump r15)))
    (define L.__nested.78
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.82) (jump L.tmp.83))))
    (define L.__nested.79 (begin (set! rax 318) (jump r15)))
    (define L.+.12
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.95) (jump L.tmp.96))))
    (define L.tmp.95 (begin (set! r9 14) (jump L.tmp.97)))
    (define L.tmp.96 (begin (set! r9 6) (jump L.tmp.97)))
    (define L.tmp.97 (if (!= r9 6) (jump L.__nested.88) (jump L.__nested.89)))
    (define L.tmp.92 (begin (set! r9 14) (jump L.tmp.94)))
    (define L.tmp.93 (begin (set! r9 6) (jump L.tmp.94)))
    (define L.tmp.94 (if (!= r9 6) (jump L.__nested.90) (jump L.__nested.91)))
    (define L.__nested.90
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.91 (begin (set! rax 574) (jump r15)))
    (define L.__nested.88
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.92) (jump L.tmp.93))))
    (define L.__nested.89 (begin (set! rax 574) (jump r15)))
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
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi 456)
        (set! rdi 1200)
        (set! r15 L.rp.17)
        (jump L.+.12)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 616)
        (set! rdi 336)
        (set! r15 L.rp.18)
        (jump L.+.12)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.19)
        (jump L.+.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 480)
        (set! rdi 352)
        (set! r15 L.rp.20)
        (jump L.*.13)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1240)
        (set! rdi 456)
        (set! r15 L.rp.21)
        (jump L.-.14)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.22)
        (jump L.-.14)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.23)
        (jump L.-.14)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 640)
        (set! rdi 1264)
        (set! r15 L.rp.24)
        (jump L.+.12)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 400)
        (set! rdi 504)
        (set! r15 L.rp.25)
        (jump L.-.14)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.26)
        (jump L.*.13)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 176))
        (set! rsi 664)
        (set! rdi 1024)
        (set! r15 L.rp.27)
        (jump L.+.12)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 936)
        (set! rdi 112)
        (set! r15 L.rp.28)
        (jump L.-.14)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.29)
        (jump L.-.14)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.30)
        (jump L.-.14)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.31)
        (jump L.+.12)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! r15 L.rp.32)
        (jump L.fun/ascii-char20852.10)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi 672)
        (set! rdi 376)
        (set! r15 L.rp.33)
        (jump L.*.13)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 352)
        (set! rdi 1128)
        (set! r15 L.rp.34)
        (jump L.*.13)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.35)
        (jump L.-.14)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1896)
        (set! rdi 1360)
        (set! r15 L.rp.36)
        (jump L.-.14)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1680)
        (set! rdi 1848)
        (set! r15 L.rp.37)
        (jump L.+.12)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.38)
        (jump L.+.12)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.39)
        (jump L.+.12)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 440)
        (set! rdi 248)
        (set! r15 L.rp.40)
        (jump L.+.12)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1952)
        (set! rdi 960)
        (set! r15 L.rp.41)
        (jump L.-.14)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.42)
        (jump L.-.14)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 176))
        (set! rsi 248)
        (set! rdi 504)
        (set! r15 L.rp.43)
        (jump L.+.12)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1768)
        (set! rdi 696)
        (set! r15 L.rp.44)
        (jump L.-.14)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.45)
        (jump L.+.12)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.46)
        (jump L.*.13)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.47)
        (jump L.-.14)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! r15 L.rp.48)
        (jump L.fun/void20854.6)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi 1552)
        (set! rdi 424)
        (set! r15 L.rp.49)
        (jump L.-.14)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 144)
        (set! rdi 1264)
        (set! r15 L.rp.50)
        (jump L.-.14)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.51)
        (jump L.-.14)))
    (define L.rp.51
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1256)
        (set! rdi 640)
        (set! r15 L.rp.52)
        (jump L.-.14)))
    (define L.rp.52
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1904)
        (set! rdi 712)
        (set! r15 L.rp.53)
        (jump L.+.12)))
    (define L.rp.53
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.54)
        (jump L.*.13)))
    (define L.rp.54
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.55)
        (jump L.-.14)))
    (define L.rp.55
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1304)
        (set! rdi 1080)
        (set! r15 L.rp.56)
        (jump L.+.12)))
    (define L.rp.56
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1928)
        (set! rdi 1000)
        (set! r15 L.rp.57)
        (jump L.*.13)))
    (define L.rp.57
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.58)
        (jump L.+.12)))
    (define L.rp.58
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 176))
        (set! rsi 416)
        (set! rdi 1720)
        (set! r15 L.rp.59)
        (jump L.*.13)))
    (define L.rp.59
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1112)
        (set! rdi 1344)
        (set! r15 L.rp.60)
        (jump L.-.14)))
    (define L.rp.60
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.61)
        (jump L.-.14)))
    (define L.rp.61
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.62)
        (jump L.+.12)))
    (define L.rp.62
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.63)
        (jump L.*.13)))
    (define L.rp.63
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! r15 L.rp.64)
        (jump L.fun/any20856.7)))
    (define L.rp.64
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rdi r15)
        (set! r15 (rbp - 0))
        (jump L.boolean?.15)))))
(check-by-interp
 '(module
    (define L.__main.39
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.19)
        (jump L.fun/error22190.12)))
    (define L.-.18
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.43 (begin (set! rax 830) (jump r15)))
    (define L.__nested.40
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.44) (jump L.tmp.45))))
    (define L.__nested.41 (begin (set! rax 830) (jump r15)))
    (define L.*.17
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
    (define L.+.16
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.63 (begin (set! rax 574) (jump r15)))
    (define L.__nested.60
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.64) (jump L.tmp.65))))
    (define L.__nested.61 (begin (set! rax 574) (jump r15)))
    (define L.cons.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.20)
        (jump L.fun/pair22192.7)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.21)
        (jump L.fun/ascii-char22194.13)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.22)
        (jump L.fun/empty22196.10)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.23)
        (jump L.fun/empty22198.9)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi 1408)
        (set! rdi 1072)
        (set! r15 L.rp.24)
        (jump L.+.16)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 784)
        (set! rdi 1232)
        (set! r15 L.rp.25)
        (jump L.*.17)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.26)
        (jump L.-.18)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1688)
        (set! rdi 1496)
        (set! r15 L.rp.27)
        (jump L.*.17)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 824)
        (set! rdi 832)
        (set! r15 L.rp.28)
        (jump L.+.16)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.29)
        (jump L.-.18)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.30)
        (jump L.*.17)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 880)
        (set! rdi 392)
        (set! r15 L.rp.31)
        (jump L.*.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 192)
        (set! rdi 312)
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
        (jump L.+.16)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 72))
        (set! rsi 576)
        (set! rdi 1728)
        (set! r15 L.rp.34)
        (jump L.*.17)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 848)
        (set! rdi 160)
        (set! r15 L.rp.35)
        (jump L.-.18)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.36)
        (jump L.*.17)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.37)
        (jump L.-.18)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.38)
        (jump L.+.16)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rax (rbp - 32))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.42
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.21)
        (jump L.fun/void23541.6)))
    (define L.*.20
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.50) (jump L.tmp.51))))
    (define L.tmp.50 (begin (set! r9 14) (jump L.tmp.52)))
    (define L.tmp.51 (begin (set! r9 6) (jump L.tmp.52)))
    (define L.tmp.52 (if (!= r9 6) (jump L.__nested.43) (jump L.__nested.44)))
    (define L.tmp.47 (begin (set! r9 14) (jump L.tmp.49)))
    (define L.tmp.48 (begin (set! r9 6) (jump L.tmp.49)))
    (define L.tmp.49 (if (!= r9 6) (jump L.__nested.45) (jump L.__nested.46)))
    (define L.__nested.45
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.46 (begin (set! rax 318) (jump r15)))
    (define L.__nested.43
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.47) (jump L.tmp.48))))
    (define L.__nested.44 (begin (set! rax 318) (jump r15)))
    (define L.+.19
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.60) (jump L.tmp.61))))
    (define L.tmp.60 (begin (set! r9 14) (jump L.tmp.62)))
    (define L.tmp.61 (begin (set! r9 6) (jump L.tmp.62)))
    (define L.tmp.62 (if (!= r9 6) (jump L.__nested.53) (jump L.__nested.54)))
    (define L.tmp.57 (begin (set! r9 14) (jump L.tmp.59)))
    (define L.tmp.58 (begin (set! r9 6) (jump L.tmp.59)))
    (define L.tmp.59 (if (!= r9 6) (jump L.__nested.55) (jump L.__nested.56)))
    (define L.__nested.55
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.56 (begin (set! rax 574) (jump r15)))
    (define L.__nested.53
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.57) (jump L.tmp.58))))
    (define L.__nested.54 (begin (set! rax 574) (jump r15)))
    (define L.-.18
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
    (define L.vector?.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 3) (jump L.__nested.73) (jump L.__nested.74))))
    (define L.__nested.73 (begin (set! rax 14) (jump r15)))
    (define L.__nested.74 (begin (set! rax 6) (jump r15)))
    (define L.cons.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.22)
        (jump L.fun/empty23543.13)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.23)
        (jump L.fun/any23545.12)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rdi r15)
        (set! r15 L.rp.24)
        (jump L.vector?.17)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 368)
        (set! rdi 1448)
        (set! r15 L.rp.25)
        (jump L.-.18)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1528)
        (set! rdi 672)
        (set! r15 L.rp.26)
        (jump L.-.18)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.27)
        (jump L.+.19)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 464)
        (set! rdi 1808)
        (set! r15 L.rp.28)
        (jump L.+.19)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 520)
        (set! rdi 104)
        (set! r15 L.rp.29)
        (jump L.-.18)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.30)
        (jump L.*.20)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.31)
        (jump L.-.18)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 104)
        (set! rdi 1264)
        (set! r15 L.rp.32)
        (jump L.*.20)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 448)
        (set! rdi 448)
        (set! r15 L.rp.33)
        (jump L.-.18)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.34)
        (jump L.+.19)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 320)
        (set! rdi 1664)
        (set! r15 L.rp.35)
        (jump L.+.19)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 112)
        (set! rdi 1296)
        (set! r15 L.rp.36)
        (jump L.*.20)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.37)
        (jump L.+.19)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.38)
        (jump L.*.20)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.39)
        (jump L.+.19)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.40)
        (jump L.fun/error23546.9)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.41)
        (jump L.fun/void23548.7)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/pair23550.4)))))
(check-by-interp
 '(module
    (define L.__main.23
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.17)
        (jump L.fun/ascii-char24528.15)))
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
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.18)
        (jump L.fun/error24530.13)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.19)
        (jump L.fun/void24532.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.20)
        (jump L.fun/ascii-char24534.8)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.21)
        (jump L.fun/empty24536.11)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.22)
        (jump L.fun/error24538.10)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.56
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 152))
        (set! r15 L.rp.16)
        (jump L.fun/error24785.7)))
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.64) (jump L.tmp.65))))
    (define L.tmp.64 (begin (set! r9 14) (jump L.tmp.66)))
    (define L.tmp.65 (begin (set! r9 6) (jump L.tmp.66)))
    (define L.tmp.66 (if (!= r9 6) (jump L.__nested.57) (jump L.__nested.58)))
    (define L.tmp.61 (begin (set! r9 14) (jump L.tmp.63)))
    (define L.tmp.62 (begin (set! r9 6) (jump L.tmp.63)))
    (define L.tmp.63 (if (!= r9 6) (jump L.__nested.59) (jump L.__nested.60)))
    (define L.__nested.59
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.60 (begin (set! rax 830) (jump r15)))
    (define L.__nested.57
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.61) (jump L.tmp.62))))
    (define L.__nested.58 (begin (set! rax 830) (jump r15)))
    (define L.*.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.74) (jump L.tmp.75))))
    (define L.tmp.74 (begin (set! r9 14) (jump L.tmp.76)))
    (define L.tmp.75 (begin (set! r9 6) (jump L.tmp.76)))
    (define L.tmp.76 (if (!= r9 6) (jump L.__nested.67) (jump L.__nested.68)))
    (define L.tmp.71 (begin (set! r9 14) (jump L.tmp.73)))
    (define L.tmp.72 (begin (set! r9 6) (jump L.tmp.73)))
    (define L.tmp.73 (if (!= r9 6) (jump L.__nested.69) (jump L.__nested.70)))
    (define L.__nested.69
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.70 (begin (set! rax 318) (jump r15)))
    (define L.__nested.67
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.71) (jump L.tmp.72))))
    (define L.__nested.68 (begin (set! rax 318) (jump r15)))
    (define L.+.13
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.84) (jump L.tmp.85))))
    (define L.tmp.84 (begin (set! r9 14) (jump L.tmp.86)))
    (define L.tmp.85 (begin (set! r9 6) (jump L.tmp.86)))
    (define L.tmp.86 (if (!= r9 6) (jump L.__nested.77) (jump L.__nested.78)))
    (define L.tmp.81 (begin (set! r9 14) (jump L.tmp.83)))
    (define L.tmp.82 (begin (set! r9 6) (jump L.tmp.83)))
    (define L.tmp.83 (if (!= r9 6) (jump L.__nested.79) (jump L.__nested.80)))
    (define L.__nested.79
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.80 (begin (set! rax 574) (jump r15)))
    (define L.__nested.77
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.81) (jump L.tmp.82))))
    (define L.__nested.78 (begin (set! rax 574) (jump r15)))
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
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi 1112)
        (set! rdi 1392)
        (set! r15 L.rp.17)
        (jump L.+.13)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 152))
        (set! rsi 1584)
        (set! rdi 1104)
        (set! r15 L.rp.18)
        (jump L.*.14)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -144))
        (set! r15 L.rp.19)
        (jump L.+.13)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 152))
        (set! rsi 1024)
        (set! rdi 88)
        (set! r15 L.rp.20)
        (jump L.*.14)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 152))
        (set! rsi 32)
        (set! rdi 680)
        (set! r15 L.rp.21)
        (jump L.+.13)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -136))
        (set! r15 L.rp.22)
        (jump L.-.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -144))
        (set! r15 L.rp.23)
        (jump L.-.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 152))
        (set! rsi 1672)
        (set! rdi 1648)
        (set! r15 L.rp.24)
        (jump L.-.15)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 152))
        (set! rsi 1616)
        (set! rdi 2016)
        (set! r15 L.rp.25)
        (jump L.*.14)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -136))
        (set! r15 L.rp.26)
        (jump L.+.13)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 152))
        (set! rsi 1512)
        (set! rdi 1040)
        (set! r15 L.rp.27)
        (jump L.-.15)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 152))
        (set! rsi 1256)
        (set! rdi 2024)
        (set! r15 L.rp.28)
        (jump L.+.13)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -136))
        (set! r15 L.rp.29)
        (jump L.*.14)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -128))
        (set! r15 L.rp.30)
        (jump L.+.13)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -144))
        (set! r15 L.rp.31)
        (jump L.-.15)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 152))
        (set! r15 L.rp.32)
        (jump L.fun/empty24787.9)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! r15 L.rp.33)
        (jump L.fun/error24789.5)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi 608)
        (set! rdi 640)
        (set! r15 L.rp.34)
        (jump L.*.14)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 152))
        (set! rsi 1840)
        (set! rdi 88)
        (set! r15 L.rp.35)
        (jump L.*.14)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -136))
        (set! r15 L.rp.36)
        (jump L.-.15)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 152))
        (set! rsi 2008)
        (set! rdi 1992)
        (set! r15 L.rp.37)
        (jump L.+.13)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 152))
        (set! rsi 1960)
        (set! rdi 632)
        (set! r15 L.rp.38)
        (jump L.*.14)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -136))
        (set! r15 L.rp.39)
        (jump L.+.13)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -128))
        (set! r15 L.rp.40)
        (jump L.-.15)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 152))
        (set! rsi 1392)
        (set! rdi 744)
        (set! r15 L.rp.41)
        (jump L.*.14)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 152))
        (set! rsi 440)
        (set! rdi 808)
        (set! r15 L.rp.42)
        (jump L.*.14)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -136))
        (set! r15 L.rp.43)
        (jump L.+.13)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 152))
        (set! rsi 920)
        (set! rdi 1368)
        (set! r15 L.rp.44)
        (jump L.-.15)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 152))
        (set! rsi 920)
        (set! rdi 912)
        (set! r15 L.rp.45)
        (jump L.-.15)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -128))
        (set! r15 L.rp.46)
        (jump L.*.14)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -136))
        (set! r15 L.rp.47)
        (jump L.*.14)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.48)
        (jump L.*.14)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 152))
        (set! r15 L.rp.49)
        (jump L.fun/empty24791.11)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi (rbp - -128))
        (set! rdi 56)
        (set! r15 L.rp.50)
        (jump L.-.15)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi (rbp - -128))
        (set! rdi r15)
        (set! r15 L.rp.51)
        (jump L.-.15)))
    (define L.rp.51
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 152))
        (set! rsi (rbp - -144))
        (set! rdi 144)
        (set! r15 L.rp.52)
        (jump L.*.14)))
    (define L.rp.52
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -144))
        (set! r15 L.rp.53)
        (jump L.*.14)))
    (define L.rp.53
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rbp (- rbp 152))
        (set! rsi r15)
        (set! rdi (rbp - -136))
        (set! r15 L.rp.54)
        (jump L.+.13)))
    (define L.rp.54
      (begin
        (set! rbp (+ rbp 152))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 152))
        (set! rsi (rbp - -144))
        (set! rdi (rbp - -128))
        (set! r15 L.rp.55)
        (jump L.-.15)))
    (define L.rp.55
      (begin
        (set! rbp (+ rbp 152))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 16))
        (set! r15 (rbp - 0))
        (jump L.+.13)))))
(check-by-interp
 '(module
    (define L.__main.27
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.20)
        (jump L.fun/error24828.16)))
    (define L.error?.19
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 62) (jump L.__nested.28) (jump L.__nested.29))))
    (define L.__nested.28 (begin (set! rax 14) (jump r15)))
    (define L.__nested.29 (begin (set! rax 6) (jump r15)))
    (define L.cons.18
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.21)
        (jump L.fun/void24830.11)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.22)
        (jump L.fun/pair24832.4)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.23)
        (jump L.fun/any24834.8)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! rdi r15)
        (set! r15 L.rp.24)
        (jump L.error?.19)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.25)
        (jump L.fun/pair24835.6)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.26)
        (jump L.fun/empty24837.14)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char24839.9)))))
(check-by-interp
 '(module
    (define L.__main.65
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 176))
        (set! rsi 1480)
        (set! rdi 264)
        (set! r15 L.rp.17)
        (jump L.*.14)))
    (define L.+.16
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.73) (jump L.tmp.74))))
    (define L.tmp.73 (begin (set! r9 14) (jump L.tmp.75)))
    (define L.tmp.74 (begin (set! r9 6) (jump L.tmp.75)))
    (define L.tmp.75 (if (!= r9 6) (jump L.__nested.66) (jump L.__nested.67)))
    (define L.tmp.70 (begin (set! r9 14) (jump L.tmp.72)))
    (define L.tmp.71 (begin (set! r9 6) (jump L.tmp.72)))
    (define L.tmp.72 (if (!= r9 6) (jump L.__nested.68) (jump L.__nested.69)))
    (define L.__nested.68
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.69 (begin (set! rax 574) (jump r15)))
    (define L.__nested.66
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.70) (jump L.tmp.71))))
    (define L.__nested.67 (begin (set! rax 574) (jump r15)))
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.83) (jump L.tmp.84))))
    (define L.tmp.83 (begin (set! r9 14) (jump L.tmp.85)))
    (define L.tmp.84 (begin (set! r9 6) (jump L.tmp.85)))
    (define L.tmp.85 (if (!= r9 6) (jump L.__nested.76) (jump L.__nested.77)))
    (define L.tmp.80 (begin (set! r9 14) (jump L.tmp.82)))
    (define L.tmp.81 (begin (set! r9 6) (jump L.tmp.82)))
    (define L.tmp.82 (if (!= r9 6) (jump L.__nested.78) (jump L.__nested.79)))
    (define L.__nested.78
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.79 (begin (set! rax 830) (jump r15)))
    (define L.__nested.76
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.80) (jump L.tmp.81))))
    (define L.__nested.77 (begin (set! rax 830) (jump r15)))
    (define L.*.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.93) (jump L.tmp.94))))
    (define L.tmp.93 (begin (set! r9 14) (jump L.tmp.95)))
    (define L.tmp.94 (begin (set! r9 6) (jump L.tmp.95)))
    (define L.tmp.95 (if (!= r9 6) (jump L.__nested.86) (jump L.__nested.87)))
    (define L.tmp.90 (begin (set! r9 14) (jump L.tmp.92)))
    (define L.tmp.91 (begin (set! r9 6) (jump L.tmp.92)))
    (define L.tmp.92 (if (!= r9 6) (jump L.__nested.88) (jump L.__nested.89)))
    (define L.__nested.88
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.89 (begin (set! rax 318) (jump r15)))
    (define L.__nested.86
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.90) (jump L.tmp.91))))
    (define L.__nested.87 (begin (set! rax 318) (jump r15)))
    (define L.cons.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 408)
        (set! rdi 1256)
        (set! r15 L.rp.18)
        (jump L.-.15)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.19)
        (jump L.-.15)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1408)
        (set! rdi 384)
        (set! r15 L.rp.20)
        (jump L.-.15)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1384)
        (set! rdi 2016)
        (set! r15 L.rp.21)
        (jump L.-.15)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.22)
        (jump L.+.16)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.23)
        (jump L.+.16)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1384)
        (set! rdi 168)
        (set! r15 L.rp.24)
        (jump L.-.15)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 808)
        (set! rdi 872)
        (set! r15 L.rp.25)
        (jump L.*.14)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.26)
        (jump L.*.14)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 608)
        (set! rdi 560)
        (set! r15 L.rp.27)
        (jump L.+.16)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 872)
        (set! rdi 520)
        (set! r15 L.rp.28)
        (jump L.-.15)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.29)
        (jump L.-.15)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.30)
        (jump L.-.15)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.31)
        (jump L.-.15)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi 488)
        (set! rdi 776)
        (set! r15 L.rp.32)
        (jump L.+.16)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1368)
        (set! rdi 704)
        (set! r15 L.rp.33)
        (jump L.*.14)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.34)
        (jump L.+.16)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1592)
        (set! rdi 1880)
        (set! r15 L.rp.35)
        (jump L.-.15)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1824)
        (set! rdi 1080)
        (set! r15 L.rp.36)
        (jump L.*.14)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.37)
        (jump L.+.16)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.38)
        (jump L.*.14)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1800)
        (set! rdi 1312)
        (set! r15 L.rp.39)
        (jump L.-.15)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1856)
        (set! rdi 792)
        (set! r15 L.rp.40)
        (jump L.*.14)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.41)
        (jump L.-.15)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 176))
        (set! rsi 408)
        (set! rdi 608)
        (set! r15 L.rp.42)
        (jump L.*.14)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 904)
        (set! rdi 16)
        (set! r15 L.rp.43)
        (jump L.-.15)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.44)
        (jump L.-.15)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.45)
        (jump L.-.15)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.46)
        (jump L.*.14)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! r15 L.rp.47)
        (jump L.fun/ascii-char27002.10)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! r15 L.rp.48)
        (jump L.fun/void27004.6)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! r15 L.rp.49)
        (jump L.fun/empty27006.4)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi 48)
        (set! rdi 704)
        (set! r15 L.rp.50)
        (jump L.*.14)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1168)
        (set! rdi 1448)
        (set! r15 L.rp.51)
        (jump L.-.15)))
    (define L.rp.51
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.52)
        (jump L.*.14)))
    (define L.rp.52
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 784)
        (set! rdi 1016)
        (set! r15 L.rp.53)
        (jump L.-.15)))
    (define L.rp.53
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 2016)
        (set! rdi 240)
        (set! r15 L.rp.54)
        (jump L.*.14)))
    (define L.rp.54
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.55)
        (jump L.-.15)))
    (define L.rp.55
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.56)
        (jump L.*.14)))
    (define L.rp.56
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1968)
        (set! rdi 496)
        (set! r15 L.rp.57)
        (jump L.-.15)))
    (define L.rp.57
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1688)
        (set! rdi 1672)
        (set! r15 L.rp.58)
        (jump L.+.16)))
    (define L.rp.58
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.59)
        (jump L.-.15)))
    (define L.rp.59
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 176))
        (set! rsi 992)
        (set! rdi 880)
        (set! r15 L.rp.60)
        (jump L.*.14)))
    (define L.rp.60
      (begin
        (set! rbp (+ rbp 176))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 176))
        (set! rsi 1000)
        (set! rdi 1176)
        (set! r15 L.rp.61)
        (jump L.-.15)))
    (define L.rp.61
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.62)
        (jump L.-.15)))
    (define L.rp.62
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.63)
        (jump L.*.14)))
    (define L.rp.63
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! rbp (- rbp 176))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.64)
        (jump L.+.16)))
    (define L.rp.64
      (begin
        (set! rbp (+ rbp 176))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/pair27008.8)))))
(check-by-interp
 '(module
    (define L.__main.48
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 96))
        (set! r15 L.rp.18)
        (jump L.fun/ascii-char27114.4)))
    (define L.*.17
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
    (define L.+.16
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
    (define L.-.15
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.76) (jump L.tmp.77))))
    (define L.tmp.76 (begin (set! r9 14) (jump L.tmp.78)))
    (define L.tmp.77 (begin (set! r9 6) (jump L.tmp.78)))
    (define L.tmp.78 (if (!= r9 6) (jump L.__nested.69) (jump L.__nested.70)))
    (define L.tmp.73 (begin (set! r9 14) (jump L.tmp.75)))
    (define L.tmp.74 (begin (set! r9 6) (jump L.tmp.75)))
    (define L.tmp.75 (if (!= r9 6) (jump L.__nested.71) (jump L.__nested.72)))
    (define L.__nested.71
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.72 (begin (set! rax 830) (jump r15)))
    (define L.__nested.69
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.73) (jump L.tmp.74))))
    (define L.__nested.70 (begin (set! rax 830) (jump r15)))
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
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! r15 L.rp.19)
        (jump L.fun/error27116.6)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! r15 L.rp.20)
        (jump L.fun/empty27118.12)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! r15 L.rp.21)
        (jump L.fun/empty27120.5)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi 584)
        (set! rdi 608)
        (set! r15 L.rp.22)
        (jump L.-.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 96))
        (set! rsi 1304)
        (set! rdi 1776)
        (set! r15 L.rp.23)
        (jump L.-.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -88))
        (set! r15 L.rp.24)
        (jump L.-.15)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 96))
        (set! rsi 1824)
        (set! rdi 1456)
        (set! r15 L.rp.25)
        (jump L.+.16)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 96))
        (set! rsi 312)
        (set! rdi 1832)
        (set! r15 L.rp.26)
        (jump L.+.16)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -88))
        (set! r15 L.rp.27)
        (jump L.+.16)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -80))
        (set! r15 L.rp.28)
        (jump L.+.16)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 96))
        (set! rsi 8)
        (set! rdi 1536)
        (set! r15 L.rp.29)
        (jump L.-.15)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 96))
        (set! rsi 912)
        (set! rdi 648)
        (set! r15 L.rp.30)
        (jump L.-.15)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -88))
        (set! r15 L.rp.31)
        (jump L.*.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 96))
        (set! rsi 1304)
        (set! rdi 688)
        (set! r15 L.rp.32)
        (jump L.+.16)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 96))
        (set! rsi 1096)
        (set! rdi 1544)
        (set! r15 L.rp.33)
        (jump L.-.15)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -80))
        (set! r15 L.rp.34)
        (jump L.+.16)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -88))
        (set! r15 L.rp.35)
        (jump L.*.17)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.36)
        (jump L.+.16)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 96))
        (set! r15 L.rp.37)
        (jump L.fun/ascii-char27122.10)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi 1928)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.38)
        (jump L.*.17)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.39)
        (jump L.-.15)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 96))
        (set! rsi (rbp - -72))
        (set! rdi 184)
        (set! r15 L.rp.40)
        (jump L.+.16)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.41)
        (jump L.+.16)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -88))
        (set! r15 L.rp.42)
        (jump L.*.17)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 96))
        (set! rsi 912)
        (set! rdi 920)
        (set! r15 L.rp.43)
        (jump L.-.15)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi (rbp - -72))
        (set! rdi r15)
        (set! r15 L.rp.44)
        (jump L.+.16)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 96))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 96))
        (set! rsi 1752)
        (set! rdi 792)
        (set! r15 L.rp.45)
        (jump L.-.15)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi (rbp - -72))
        (set! rdi r15)
        (set! r15 L.rp.46)
        (jump L.-.15)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rbp (- rbp 96))
        (set! rsi r15)
        (set! rdi (rbp - -88))
        (set! r15 L.rp.47)
        (jump L.-.15)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 96))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 16))
        (set! r15 (rbp - 0))
        (jump L.-.15)))))
(check-by-interp
 '(module
    (define L.__main.27
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.20)
        (jump L.fun/any27436.16)))
    (define L.pair?.19
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 1) (jump L.__nested.28) (jump L.__nested.29))))
    (define L.__nested.28 (begin (set! rax 14) (jump r15)))
    (define L.__nested.29 (begin (set! rax 6) (jump r15)))
    (define L.cons.18
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r12)
        (set! r12 (+ r12 16))
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
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! rdi r15)
        (set! r15 L.rp.21)
        (jump L.pair?.19)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.22)
        (jump L.fun/ascii-char27437.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.23)
        (jump L.fun/error27439.10)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.24)
        (jump L.fun/void27441.9)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.25)
        (jump L.fun/ascii-char27443.8)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.26)
        (jump L.fun/ascii-char27445.5)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/pair27447.4)))))
