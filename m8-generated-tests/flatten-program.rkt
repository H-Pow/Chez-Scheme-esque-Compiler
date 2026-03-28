#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v8
         (only-in "../flatten-program.rkt"))
(define (fail-if-invalid p)
  (when (not (para-asm-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "para-asm-lang-v8"
      " program")))
  p)
(define (check-by-interp p)
  (interp-block-asm-lang-v8 p)
  (interp-para-asm-lang-v8 (fail-if-invalid (flatten-program p))))

(check-by-interp
 '(module
    (define L.__main.5 (begin (set! r15 r15) (set! rax 24894) (jump r15)))))
(check-by-interp
 '(module (define L.__main.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void8390.4)))
    (define L.fun/void8390.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.5
      (begin (set! r15 r15) (set! r14 22) (set! rax 21310) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.5
      (begin
        (set! r15 r15)
        (set! r14 30)
        (set! r14 25390)
        (set! rax 576)
        (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.6
      (begin
        (set! r15 r15)
        (set! r14 25390)
        (set! r14 6)
        (set! r14 14)
        (set! rdi r14)
        (set! r15 r15)
        (jump L.fun/void8397.4)))
    (define L.fun/void8397.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 30) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.7
      (begin (set! r15 r15) (set! r14 14) (jump L.__nested.5)))
    (define L.__nested.5 (begin (set! rax 18494) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.7 (begin (set! r15 r15) (set! r14 6) (jump L.__nested.6)))
    (define L.__nested.6 (begin (set! rax 25390) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.7
      (begin (set! r15 r15) (set! r14 14) (jump L.__nested.5)))
    (define L.__nested.5 (begin (set! rax 240) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.5
      (begin
        (set! r15 r15)
        (set! r14 22)
        (set! r14 25390)
        (set! rax 30)
        (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.6
      (begin
        (set! r15 r15)
        (set! r14 30)
        (set! r14 38974)
        (set! r14 r14)
        (set! rdi r14)
        (set! r15 r15)
        (jump L.fun/error8412.4)))
    (define L.fun/error8412.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 29758) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.6
      (begin
        (set! r15 r15)
        (set! r14 25390)
        (set! r14 29502)
        (set! r14 25390)
        (set! rdi r14)
        (set! r15 r15)
        (jump L.fun/ascii-char8415.4)))
    (define L.fun/ascii-char8415.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 25390) (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.12
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! rsi 912)
        (set! rdi 760)
        (set! r15 L.rp.9)
        (jump L.+.7)))
    (define L.-.8
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.16 (begin (set! rax 830) (jump r15)))
    (define L.__nested.13
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.17) (jump L.tmp.18))))
    (define L.__nested.14 (begin (set! rax 830) (jump r15)))
    (define L.+.7
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
    (define L.fun/empty8418.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char8419.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! rsi 1664)
        (set! rdi 384)
        (set! r15 L.rp.10)
        (jump L.-.8)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.11)
        (jump L.fun/empty8418.4)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char8419.5)))))
(check-by-interp
 '(module
    (define L.__main.13
      (begin
        (set! (rbp - 0) r15)
        (set! r15 25390)
        (set! r15 22)
        (set! r15 15166)
        (set! (rbp - 8) 25390)
        (set! rbp (- rbp 16))
        (set! rsi 6)
        (set! rdi 30)
        (set! r15 L.rp.8)
        (jump L.fun/void8469.5)))
    (define L.fun/ascii-char8467.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! rax r14)
        (jump r15)))
    (define L.fun/void8469.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 30)
        (jump r15)))
    (define L.fun/empty8468.6
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 22)
        (jump r15)))
    (define L.rp.8
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! r14 6)
        (jump L.tmp.11)))
    (define L.tmp.11 (begin (set! r14 65086) (jump L.tmp.12)))
    (define L.tmp.12
      (begin
        (set! rbp (- rbp 16))
        (set! rsi r14)
        (set! rdi r15)
        (set! r15 L.rp.9)
        (jump L.fun/empty8468.6)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char8467.4)))))
(check-by-interp
 '(module
    (define L.__main.18
      (begin (set! (rbp - 0) r15) (set! r15 6) (jump L.tmp.16)))
    (define L.*.6
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.22 (begin (set! rax 318) (jump r15)))
    (define L.__nested.19
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.23) (jump L.tmp.24))))
    (define L.__nested.20 (begin (set! rax 318) (jump r15)))
    (define L.-.5
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
    (define L.tmp.16 (begin (set! r15 688) (jump L.tmp.17)))
    (define L.tmp.17 (begin (set! r14 14) (jump L.tmp.12)))
    (define L.tmp.12 (begin (set! r14 1480) (jump L.tmp.14)))
    (define L.tmp.14
      (begin
        (set! rbp (- rbp 16))
        (set! rsi r14)
        (set! rdi r15)
        (set! r15 L.rp.7)
        (jump L.-.5)))
    (define L.rp.7
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! r15 6)
        (jump L.tmp.10)))
    (define L.tmp.10 (begin (set! r15 264) (jump L.tmp.11)))
    (define L.tmp.11
      (begin
        (set! r14 25390)
        (set! r14 13118)
        (set! r14 22)
        (set! r14 608)
        (set! rbp (- rbp 16))
        (set! rsi r14)
        (set! rdi r15)
        (set! r15 L.rp.8)
        (jump L.-.5)))
    (define L.rp.8
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.*.6)))))
(check-by-interp
 '(module
    (define L.__main.19
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! rdx 25390)
        (set! rsi 22)
        (set! rdi 5950)
        (set! r15 L.rp.9)
        (jump L.fun/any8734.4)))
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
    (define L.vector?.6
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 3) (jump L.__nested.40) (jump L.__nested.41))))
    (define L.__nested.40 (begin (set! rax 14) (jump r15)))
    (define L.__nested.41 (begin (set! rax 6) (jump r15)))
    (define L.fun/any8734.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 41278)
        (jump r15)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! rdi r15)
        (set! r15 L.rp.10)
        (jump L.vector?.6)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (if (!= r15 6) (jump L.__nested.12) (jump L.__nested.13))))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! r14 14)
        (jump L.tmp.14)))
    (define L.tmp.14 (begin (set! r14 1488) (jump L.tmp.16)))
    (define L.tmp.16
      (begin (set! rsi r14) (set! rdi r15) (set! r15 (rbp - 0)) (jump L.*.8)))
    (define L.__nested.17 (begin (set! rax 1552) (jump (rbp - 0))))
    (define L.__nested.12
      (begin
        (set! rbp (- rbp 8))
        (set! rsi 528)
        (set! rdi 1480)
        (set! r15 L.rp.11)
        (jump L.-.7)))
    (define L.__nested.13 (begin (set! r15 14) (jump L.__nested.17)))))
(check-by-interp
 '(module
    (define L.__main.14
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.10)
        (jump L.fun/void8779.8)))
    (define L.fun/void8780.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char8782.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void8781.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error8783.7
      (begin (set! r15 r15) (set! rax 35646) (jump r15)))
    (define L.fun/void8779.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.11)
        (jump L.fun/void8780.4)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.12)
        (jump L.fun/void8781.6)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.13)
        (jump L.fun/ascii-char8782.5)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error8783.7)))))
(check-by-interp
 '(module
    (define L.__main.19
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.11)
        (jump L.fun/empty8806.4)))
    (define L.*.10
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
    (define L.+.9
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.33 (begin (set! rax 574) (jump r15)))
    (define L.__nested.30
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.34) (jump L.tmp.35))))
    (define L.__nested.31 (begin (set! rax 574) (jump r15)))
    (define L.-.8
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
    (define L.fun/empty8806.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void8807.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char8808.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rsi 864)
        (set! rdi 1608)
        (set! r15 L.rp.12)
        (jump L.-.8)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 24))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 24))
        (set! rsi 352)
        (set! rdi 328)
        (set! r15 L.rp.13)
        (jump L.+.9)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.14)
        (jump L.-.8)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rsi 1048)
        (set! rdi 320)
        (set! r15 L.rp.15)
        (jump L.*.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 24))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 24))
        (set! rsi 968)
        (set! rdi 1096)
        (set! r15 L.rp.16)
        (jump L.*.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.17)
        (jump L.-.8)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.18)
        (jump L.fun/void8807.5)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char8808.6)))))
(check-by-interp
 '(module
    (define L.__main.35
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 24))
        (set! rdx 25390)
        (set! rsi 44094)
        (set! rdi 25390)
        (set! r15 L.rp.17)
        (jump L.fun/boolean9033.11)))
    (define L.error?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 62) (jump L.__nested.36) (jump L.__nested.37))))
    (define L.__nested.36 (begin (set! rax 14) (jump r15)))
    (define L.__nested.37 (begin (set! rax 6) (jump r15)))
    (define L.fixnum?.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 0) (jump L.__nested.38) (jump L.__nested.39))))
    (define L.__nested.38 (begin (set! rax 14) (jump r15)))
    (define L.__nested.39 (begin (set! rax 6) (jump r15)))
    (define L.+.14
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
    (define L.vector?.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 3) (jump L.__nested.50) (jump L.__nested.51))))
    (define L.__nested.50 (begin (set! rax 14) (jump r15)))
    (define L.__nested.51 (begin (set! rax 6) (jump r15)))
    (define L.fun/empty9034.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 22)
        (jump r15)))
    (define L.fun/error9036.5
      (begin (set! r15 r15) (set! rax 47166) (jump r15)))
    (define L.fun/error9035.6
      (begin (set! r15 r15) (set! rax 36414) (jump r15)))
    (define L.fun/void9037.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char9032.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty9038.9 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char9031.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! r15 r15)
        (jump L.fun/ascii-char9032.8)))
    (define L.fun/boolean9033.11
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 14)
        (jump r15)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (if (!= r15 6) (jump L.tmp.29) (jump L.tmp.30))))
    (define L.tmp.33 (begin (set! (rbp - 8) 22) (jump L.tmp.31)))
    (define L.rp.18
      (begin (set! rbp (+ rbp 24)) (set! (rbp - 8) rax) (jump L.tmp.31)))
    (define L.tmp.29 (begin (set! r15 6) (jump L.tmp.33)))
    (define L.tmp.30
      (begin
        (set! rbp (- rbp 24))
        (set! rdx 14)
        (set! rsi 59454)
        (set! rdi 4158)
        (set! r15 L.rp.18)
        (jump L.fun/empty9034.4)))
    (define L.tmp.31
      (begin
        (set! rbp (- rbp 24))
        (set! rdi 25390)
        (set! r15 L.rp.19)
        (jump L.vector?.13)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rsi 192)
        (set! rdi 224)
        (set! r15 L.rp.20)
        (jump L.+.14)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.21)
        (jump L.fun/error9035.6)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.22)
        (jump L.fun/error9036.5)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rdi 30)
        (set! r15 L.rp.23)
        (jump L.fixnum?.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 24))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 24))
        (set! rdx 14)
        (set! rsi 6)
        (set! rdi 22)
        (set! r15 L.rp.24)
        (jump L.fun/ascii-char9031.10)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.25)
        (jump L.fun/void9037.7)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rdx 6)
        (set! rsi 14)
        (set! rdi 22)
        (set! r15 L.rp.26)
        (jump L.fun/ascii-char9031.10)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.27)
        (jump L.fun/empty9038.9)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rdi 30)
        (set! r15 L.rp.28)
        (jump L.error?.16)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rdx r15)
        (set! rsi (rbp - 16))
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char9031.10)))))
(check-by-interp
 '(module
    (define L.__main.13
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.9)
        (jump L.fun/error9075.6)))
    (define L.fun/void9076.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char9078.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error9075.6
      (begin (set! r15 r15) (set! rax 57662) (jump r15)))
    (define L.fun/empty9077.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.10)
        (jump L.fun/void9076.4)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.11)
        (jump L.fun/empty9077.7)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.12)
        (jump L.fun/ascii-char9078.5)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.11 (begin (set! r15 r15) (set! r14 6) (jump L.tmp.10)))
    (define L.tmp.10 (begin (set! r14 14) (jump L.__nested.5)))
    (define L.__nested.8 (begin (set! rax 1416) (jump r15)))
    (define L.__nested.5
      (begin
        (set! r14 1720)
        (set! r13 984)
        (set! r13 30)
        (set! r13 25390)
        (set! rax r14)
        (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.16
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.11)
        (jump L.fun/empty9362.8)))
    (define L.boolean?.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 247))
        (set! r14 r14)
        (if (= r14 6) (jump L.__nested.17) (jump L.__nested.18))))
    (define L.__nested.17 (begin (set! rax 14) (jump r15)))
    (define L.__nested.18 (begin (set! rax 6) (jump r15)))
    (define L.fun/error9365.4
      (begin (set! r15 r15) (set! rax 62014) (jump r15)))
    (define L.fun/error9364.5
      (begin (set! r15 r15) (set! rax 63806) (jump r15)))
    (define L.fun/any9366.6 (begin (set! r15 r15) (set! rax 14) (jump r15)))
    (define L.fun/error9363.7
      (begin (set! r15 r15) (set! rax 60990) (jump r15)))
    (define L.fun/empty9362.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.12)
        (jump L.fun/error9363.7)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.13)
        (jump L.fun/error9364.5)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.14)
        (jump L.fun/error9365.4)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.15)
        (jump L.fun/any9366.6)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rdi r15)
        (set! r15 (rbp - 0))
        (jump L.boolean?.10)))))
(check-by-interp
 '(module
    (define L.__main.13
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.9)
        (jump L.fun/empty9572.7)))
    (define L.fun/ascii-char9574.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void9575.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void9573.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty9572.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.9
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.10)
        (jump L.fun/void9573.6)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.11)
        (jump L.fun/ascii-char9574.4)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.12)
        (jump L.fun/void9575.5)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.9
      (begin
        (set! r15 r15)
        (set! r14 22)
        (set! r14 968)
        (set! r14 30)
        (set! r14 896)
        (set! r14 6)
        (jump L.__nested.6)))
    (define L.__nested.7 (begin (set! rax 22) (jump r15)))
    (define L.__nested.6
      (begin
        (set! r14 22)
        (set! r14 42302)
        (set! r14 30)
        (set! r14 992)
        (set! rax 22)
        (jump r15)))))
(check-by-interp
 '(module
    (define L.__main.16
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.10)
        (jump L.fun/void9902.5)))
    (define L.-.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.20 (begin (set! rax 830) (jump r15)))
    (define L.__nested.17
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.21) (jump L.tmp.22))))
    (define L.__nested.18 (begin (set! rax 830) (jump r15)))
    (define L.*.8
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.30 (begin (set! rax 318) (jump r15)))
    (define L.__nested.27
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.31) (jump L.tmp.32))))
    (define L.__nested.28 (begin (set! rax 318) (jump r15)))
    (define L.fun/ascii-char9904.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void9902.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char9903.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 24))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.11)
        (jump L.fun/ascii-char9903.6)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rsi 1592)
        (set! rdi 504)
        (set! r15 L.rp.12)
        (jump L.*.8)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 24))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 24))
        (set! rsi 1320)
        (set! rdi 552)
        (set! r15 L.rp.13)
        (jump L.*.8)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.14)
        (jump L.-.9)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rbp (- rbp 24))
        (set! r15 L.rp.15)
        (jump L.fun/ascii-char9904.4)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 24))
        (set! r15 rax)
        (set! rax (rbp - 16))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.29
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 56))
        (set! rsi 1560)
        (set! rdi 1112)
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
    (define L.-.10
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
    (define L.+.9
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.53 (begin (set! rax 574) (jump r15)))
    (define L.__nested.50
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.54) (jump L.tmp.55))))
    (define L.__nested.51 (begin (set! rax 574) (jump r15)))
    (define L.fun/void10674.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error10675.5
      (begin (set! r15 r15) (set! rax 64318) (jump r15)))
    (define L.fun/void10672.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty10673.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 704)
        (set! rdi 904)
        (set! r15 L.rp.13)
        (jump L.-.10)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.14)
        (jump L.+.9)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 56))
        (set! rsi 744)
        (set! rdi 216)
        (set! r15 L.rp.15)
        (jump L.+.9)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1952)
        (set! rdi 1832)
        (set! r15 L.rp.16)
        (jump L.-.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.17)
        (jump L.-.10)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.18)
        (jump L.-.10)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.19)
        (jump L.fun/void10672.6)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.20)
        (jump L.fun/empty10673.7)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.21)
        (jump L.fun/void10674.4)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi 1024)
        (set! rdi 760)
        (set! r15 L.rp.22)
        (jump L.*.11)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 160)
        (set! rdi 1344)
        (set! r15 L.rp.23)
        (jump L.+.9)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.24)
        (jump L.-.10)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 56))
        (set! rsi 648)
        (set! rdi 1136)
        (set! r15 L.rp.25)
        (jump L.*.11)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 224)
        (set! rdi 736)
        (set! r15 L.rp.26)
        (jump L.*.11)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.27)
        (jump L.-.10)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.28)
        (jump L.-.10)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error10675.5)))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.12)
        (jump L.fun/ascii-char10854.5)))
    (define L.-.11
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.28 (begin (set! rax 830) (jump r15)))
    (define L.__nested.25
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.29) (jump L.tmp.30))))
    (define L.__nested.26 (begin (set! rax 830) (jump r15)))
    (define L.+.10
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.38 (begin (set! rax 574) (jump r15)))
    (define L.__nested.35
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.39) (jump L.tmp.40))))
    (define L.__nested.36 (begin (set! rax 574) (jump r15)))
    (define L.ascii-char?.9
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 46) (jump L.__nested.45) (jump L.__nested.46))))
    (define L.__nested.45 (begin (set! rax 14) (jump r15)))
    (define L.__nested.46 (begin (set! rax 6) (jump r15)))
    (define L.fun/any10855.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char10854.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty10856.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void10857.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.13)
        (jump L.fun/any10855.4)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rdi r15)
        (set! r15 L.rp.14)
        (jump L.ascii-char?.9)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.15)
        (jump L.fun/empty10856.6)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! rsi 784)
        (set! rdi 1352)
        (set! r15 L.rp.16)
        (jump L.+.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 1792)
        (set! rdi 8)
        (set! r15 L.rp.17)
        (jump L.-.11)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.18)
        (jump L.-.11)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 40))
        (set! rsi 992)
        (set! rdi 112)
        (set! r15 L.rp.19)
        (jump L.-.11)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 48)
        (set! rdi 1104)
        (set! r15 L.rp.20)
        (jump L.+.10)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.21)
        (jump L.+.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.22)
        (jump L.+.10)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.23)
        (jump L.fun/void10857.7)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 40))
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
        (jump L.fun/ascii-char11399.8)))
    (define L.fun/void11402.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char11403.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char11400.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error11401.7
      (begin (set! r15 r15) (set! rax 15166) (jump r15)))
    (define L.fun/ascii-char11399.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.11)
        (jump L.fun/ascii-char11400.6)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.12)
        (jump L.fun/error11401.7)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.13)
        (jump L.fun/void11402.4)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.14)
        (jump L.fun/ascii-char11403.5)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 16))
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
        (jump L.fun/error13618.7)))
    (define L.fun/void13621.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char13620.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty13623.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error13618.7
      (begin (set! r15 r15) (set! rax 22846) (jump r15)))
    (define L.fun/void13619.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error13622.9
      (begin (set! r15 r15) (set! rax 25150) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.12)
        (jump L.fun/void13619.8)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.13)
        (jump L.fun/ascii-char13620.5)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.14)
        (jump L.fun/void13621.4)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.15)
        (jump L.fun/error13622.9)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/empty13623.6)))))
(check-by-interp
 '(module
    (define L.__main.28
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 56))
        (set! rsi 1328)
        (set! rdi 1512)
        (set! r15 L.rp.11)
        (jump L.*.8)))
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
    (define L.fun/void14228.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty14229.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char14227.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1096)
        (set! rdi 1088)
        (set! r15 L.rp.12)
        (jump L.*.8)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.13)
        (jump L.+.9)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 56))
        (set! rsi 832)
        (set! rdi 1528)
        (set! r15 L.rp.14)
        (jump L.-.10)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1744)
        (set! rdi 192)
        (set! r15 L.rp.15)
        (jump L.*.8)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.16)
        (jump L.*.8)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.17)
        (jump L.+.9)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.18)
        (jump L.fun/ascii-char14227.6)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi 1440)
        (set! rdi 880)
        (set! r15 L.rp.19)
        (jump L.+.9)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 320)
        (set! rdi 632)
        (set! r15 L.rp.20)
        (jump L.-.10)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.21)
        (jump L.-.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 56))
        (set! rsi 360)
        (set! rdi 1688)
        (set! r15 L.rp.22)
        (jump L.-.10)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1952)
        (set! rdi 1800)
        (set! r15 L.rp.23)
        (jump L.+.9)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.24)
        (jump L.-.10)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.25)
        (jump L.*.8)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.26)
        (jump L.fun/void14228.4)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.27)
        (jump L.fun/empty14229.5)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rax r15)
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.13)
        (jump L.fun/error14542.8)))
    (define L.-.12
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.28 (begin (set! rax 830) (jump r15)))
    (define L.__nested.25
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.29) (jump L.tmp.30))))
    (define L.__nested.26 (begin (set! rax 830) (jump r15)))
    (define L.+.11
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.38 (begin (set! rax 574) (jump r15)))
    (define L.__nested.35
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.39) (jump L.tmp.40))))
    (define L.__nested.36 (begin (set! rax 574) (jump r15)))
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
    (define L.fun/void14544.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty14543.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char14546.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error14545.7 (begin (set! r15 r15) (set! rax 62) (jump r15)))
    (define L.fun/error14542.8
      (begin (set! r15 r15) (set! rax 38462) (jump r15)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.14)
        (jump L.fun/empty14543.5)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi 288)
        (set! rdi 1248)
        (set! r15 L.rp.15)
        (jump L.*.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 552)
        (set! rdi 856)
        (set! r15 L.rp.16)
        (jump L.*.10)))
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
        (set! rsi 1056)
        (set! rdi 824)
        (set! r15 L.rp.18)
        (jump L.*.10)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1720)
        (set! rdi 608)
        (set! r15 L.rp.19)
        (jump L.+.11)))
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
        (set! r15 L.rp.22)
        (jump L.fun/void14544.4)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.23)
        (jump L.fun/error14545.7)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char14546.6)))))
(check-by-interp
 '(module
    (define L.__main.23
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 32))
        (set! rsi 1392)
        (set! rdi 1304)
        (set! r15 L.rp.12)
        (jump L.*.10)))
    (define L.-.11
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.27 (begin (set! rax 830) (jump r15)))
    (define L.__nested.24
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.28) (jump L.tmp.29))))
    (define L.__nested.25 (begin (set! rax 830) (jump r15)))
    (define L.*.10
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.37 (begin (set! rax 318) (jump r15)))
    (define L.__nested.34
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.38) (jump L.tmp.39))))
    (define L.__nested.35 (begin (set! rax 318) (jump r15)))
    (define L.fun/empty15112.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error15114.5
      (begin (set! r15 r15) (set! rax 11326) (jump r15)))
    (define L.fun/empty15111.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char15115.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void15113.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 368)
        (set! rdi 1800)
        (set! r15 L.rp.13)
        (jump L.*.10)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.14)
        (jump L.-.11)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1944)
        (set! rdi 1672)
        (set! r15 L.rp.15)
        (jump L.*.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1864)
        (set! rdi 1184)
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
        (jump L.-.11)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.18)
        (jump L.*.10)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.19)
        (jump L.fun/empty15111.6)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.20)
        (jump L.fun/empty15112.4)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.21)
        (jump L.fun/void15113.8)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.22)
        (jump L.fun/error15114.5)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char15115.7)))))
(check-by-interp
 '(module
    (define L.__main.36
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 80))
        (set! r15 L.rp.12)
        (jump L.fun/empty16025.4)))
    (define L.fixnum?.11
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 0) (jump L.__nested.37) (jump L.__nested.38))))
    (define L.__nested.37 (begin (set! rax 14) (jump r15)))
    (define L.__nested.38 (begin (set! rax 6) (jump r15)))
    (define L.-.10
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
    (define L.+.9
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
    (define L.*.8
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
    (define L.fun/empty16025.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char16027.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any16026.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi 224)
        (set! rdi 56)
        (set! r15 L.rp.13)
        (jump L.*.8)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 80))
        (set! rsi 384)
        (set! rdi 336)
        (set! r15 L.rp.14)
        (jump L.+.9)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.15)
        (jump L.-.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 80))
        (set! rsi 672)
        (set! rdi 1936)
        (set! r15 L.rp.16)
        (jump L.-.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 80))
        (set! rsi 1760)
        (set! rdi 1096)
        (set! r15 L.rp.17)
        (jump L.-.10)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.18)
        (jump L.*.8)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.19)
        (jump L.-.10)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi 1408)
        (set! rdi 56)
        (set! r15 L.rp.20)
        (jump L.*.8)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 80))
        (set! rsi 528)
        (set! rdi 8)
        (set! r15 L.rp.21)
        (jump L.*.8)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.22)
        (jump L.*.8)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 80))
        (set! rsi 376)
        (set! rdi 472)
        (set! r15 L.rp.23)
        (jump L.+.9)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 80))
        (set! rsi 656)
        (set! rdi 1000)
        (set! r15 L.rp.24)
        (jump L.-.10)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.25)
        (jump L.*.8)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.26)
        (jump L.*.8)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi 464)
        (set! rdi 1064)
        (set! r15 L.rp.27)
        (jump L.*.8)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 80))
        (set! rsi 1504)
        (set! rdi 1088)
        (set! r15 L.rp.28)
        (jump L.*.8)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.29)
        (jump L.*.8)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 80))
        (set! rsi 1048)
        (set! rdi 1328)
        (set! r15 L.rp.30)
        (jump L.+.9)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 80))
        (set! rsi 560)
        (set! rdi 1832)
        (set! r15 L.rp.31)
        (jump L.*.8)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.32)
        (jump L.*.8)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.33)
        (jump L.+.9)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! r15 L.rp.34)
        (jump L.fun/any16026.6)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rdi r15)
        (set! r15 L.rp.35)
        (jump L.fixnum?.11)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/ascii-char16027.5)))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.13)
        (jump L.fun/void19235.7)))
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
    (define L.+.11
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.38 (begin (set! rax 574) (jump r15)))
    (define L.__nested.35
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.39) (jump L.tmp.40))))
    (define L.__nested.36 (begin (set! rax 574) (jump r15)))
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
    (define L.fun/ascii-char19237.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char19236.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error19239.6
      (begin (set! r15 r15) (set! rax 55358) (jump r15)))
    (define L.fun/void19235.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error19238.8
      (begin (set! r15 r15) (set! rax 21566) (jump r15)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.14)
        (jump L.fun/ascii-char19236.5)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.15)
        (jump L.fun/ascii-char19237.4)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.16)
        (jump L.fun/error19238.8)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.17)
        (jump L.fun/error19239.6)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi 160)
        (set! rdi 1752)
        (set! r15 L.rp.18)
        (jump L.-.10)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1232)
        (set! rdi 456)
        (set! r15 L.rp.19)
        (jump L.+.11)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.20)
        (jump L.-.10)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1432)
        (set! rdi 792)
        (set! r15 L.rp.21)
        (jump L.-.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1552)
        (set! rdi 1848)
        (set! r15 L.rp.22)
        (jump L.-.10)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.23)
        (jump L.*.12)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.-.10)))))
(check-by-interp
 '(module
    (define L.__main.24
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.13)
        (jump L.fun/empty20764.7)))
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
    (define L.+.11
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.38 (begin (set! rax 574) (jump r15)))
    (define L.__nested.35
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.39) (jump L.tmp.40))))
    (define L.__nested.36 (begin (set! rax 574) (jump r15)))
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
    (define L.fun/empty20765.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char20767.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char20768.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty20764.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error20766.8
      (begin (set! r15 r15) (set! rax 64574) (jump r15)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.14)
        (jump L.fun/empty20765.4)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.15)
        (jump L.fun/error20766.8)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.16)
        (jump L.fun/ascii-char20767.5)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.17)
        (jump L.fun/ascii-char20768.6)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi 1184)
        (set! rdi 1504)
        (set! r15 L.rp.18)
        (jump L.-.10)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1296)
        (set! rdi 1616)
        (set! r15 L.rp.19)
        (jump L.+.11)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.20)
        (jump L.-.10)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1272)
        (set! rdi 8)
        (set! r15 L.rp.21)
        (jump L.-.10)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 32))
        (set! rsi 528)
        (set! rdi 888)
        (set! r15 L.rp.22)
        (jump L.*.12)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.23)
        (jump L.*.12)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.*.12)))))
(check-by-interp
 '(module
    (define L.__main.29
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.12)
        (jump L.fun/ascii-char21096.4)))
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
    (define L.+.9
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.53 (begin (set! rax 574) (jump r15)))
    (define L.__nested.50
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.54) (jump L.tmp.55))))
    (define L.__nested.51 (begin (set! rax 574) (jump r15)))
    (define L.fun/ascii-char21096.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char21098.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error21099.6
      (begin (set! r15 r15) (set! rax 33086) (jump r15)))
    (define L.fun/ascii-char21097.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi 1976)
        (set! rdi 1208)
        (set! r15 L.rp.13)
        (jump L.+.9)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 32)
        (set! rdi 1432)
        (set! r15 L.rp.14)
        (jump L.*.10)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.15)
        (jump L.+.9)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 456)
        (set! rdi 1400)
        (set! r15 L.rp.16)
        (jump L.*.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 56))
        (set! rsi 1672)
        (set! rdi 888)
        (set! r15 L.rp.17)
        (jump L.-.11)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.18)
        (jump L.+.9)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.19)
        (jump L.+.9)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.20)
        (jump L.fun/ascii-char21097.7)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! r15 L.rp.21)
        (jump L.fun/ascii-char21098.5)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi 1800)
        (set! rdi 1032)
        (set! r15 L.rp.22)
        (jump L.*.10)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 560)
        (set! rdi 552)
        (set! r15 L.rp.23)
        (jump L.+.9)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.24)
        (jump L.-.11)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 56))
        (set! rsi 368)
        (set! rdi 1424)
        (set! r15 L.rp.25)
        (jump L.-.11)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 56))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 56))
        (set! rsi 296)
        (set! rdi 864)
        (set! r15 L.rp.26)
        (jump L.-.11)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.27)
        (jump L.-.11)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! rbp (- rbp 56))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.28)
        (jump L.-.11)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 56))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error21099.6)))))
(check-by-interp
 '(module
    (define L.__main.22
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.11)
        (jump L.fun/ascii-char21254.7)))
    (define L.-.10
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.26 (begin (set! rax 830) (jump r15)))
    (define L.__nested.23
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.27) (jump L.tmp.28))))
    (define L.__nested.24 (begin (set! rax 830) (jump r15)))
    (define L.+.9
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.40) (jump L.tmp.41))))
    (define L.tmp.40 (begin (set! r9 14) (jump L.tmp.42)))
    (define L.tmp.41 (begin (set! r9 6) (jump L.tmp.42)))
    (define L.tmp.42 (if (!= r9 6) (jump L.__nested.33) (jump L.__nested.34)))
    (define L.tmp.37 (begin (set! r9 14) (jump L.tmp.39)))
    (define L.tmp.38 (begin (set! r9 6) (jump L.tmp.39)))
    (define L.tmp.39 (if (!= r9 6) (jump L.__nested.35) (jump L.__nested.36)))
    (define L.__nested.35
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.36 (begin (set! rax 574) (jump r15)))
    (define L.__nested.33
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.37) (jump L.tmp.38))))
    (define L.__nested.34 (begin (set! rax 574) (jump r15)))
    (define L.fun/void21257.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void21255.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void21256.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char21254.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.12)
        (jump L.fun/void21255.5)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 40))
        (set! rsi 736)
        (set! rdi 1728)
        (set! r15 L.rp.13)
        (jump L.+.9)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 192)
        (set! rdi 1624)
        (set! r15 L.rp.14)
        (jump L.-.10)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.15)
        (jump L.-.10)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 40))
        (set! rsi 888)
        (set! rdi 160)
        (set! r15 L.rp.16)
        (jump L.-.10)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 40))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 40))
        (set! rsi 1920)
        (set! rdi 1968)
        (set! r15 L.rp.17)
        (jump L.-.10)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.18)
        (jump L.+.9)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.19)
        (jump L.-.10)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.20)
        (jump L.fun/void21256.6)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 40))
        (set! r15 rax)
        (set! rbp (- rbp 40))
        (set! r15 L.rp.21)
        (jump L.fun/void21257.4)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 40))
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
        (jump L.fun/error21502.4)))
    (define L.fun/error21502.4
      (begin (set! r15 r15) (set! rax 12606) (jump r15)))
    (define L.fun/empty21506.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty21503.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error21505.7
      (begin (set! r15 r15) (set! rax 45630) (jump r15)))
    (define L.fun/empty21504.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.11)
        (jump L.fun/empty21503.6)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.12)
        (jump L.fun/empty21504.8)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.13)
        (jump L.fun/error21505.7)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.14)
        (jump L.fun/empty21506.5)))
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
        (jump L.fun/empty21523.4)))
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
    (define L.fun/empty21523.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void21525.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void21524.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void21527.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char21526.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.14)
        (jump L.fun/void21524.6)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.15)
        (jump L.fun/void21525.5)))
    (define L.rp.15
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.16)
        (jump L.fun/ascii-char21526.8)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! r15 L.rp.17)
        (jump L.fun/void21527.7)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi 1448)
        (set! rdi 1072)
        (set! r15 L.rp.18)
        (jump L.*.10)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1416)
        (set! rdi 496)
        (set! r15 L.rp.19)
        (jump L.-.11)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -24))
        (set! r15 L.rp.20)
        (jump L.-.11)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1208)
        (set! rdi 80)
        (set! r15 L.rp.21)
        (jump L.-.11)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 32))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 32))
        (set! rsi 1032)
        (set! rdi 888)
        (set! r15 L.rp.22)
        (jump L.-.11)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rbp (- rbp 32))
        (set! rsi r15)
        (set! rdi (rbp - -16))
        (set! r15 L.rp.23)
        (jump L.+.12)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 32))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.+.12)))))
(check-by-interp
 '(module
    (define L.__main.15
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.10)
        (jump L.fun/void22129.5)))
    (define L.fun/void22132.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void22129.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void22131.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty22130.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char22133.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.10
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.11)
        (jump L.fun/empty22130.7)))
    (define L.rp.11
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.12)
        (jump L.fun/void22131.6)))
    (define L.rp.12
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.13)
        (jump L.fun/void22132.4)))
    (define L.rp.13
      (begin
        (set! rbp (+ rbp 8))
        (set! r15 rax)
        (set! rbp (- rbp 8))
        (set! r15 L.rp.14)
        (jump L.fun/ascii-char22133.8)))
    (define L.rp.14
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
        (jump L.fun/ascii-char35206.4)))
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
    (define L.fun/ascii-char35206.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char35207.9)))
    (define L.fun/ascii-char35208.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char35209.10)))
    (define L.fun/empty35210.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty35211.13)))
    (define L.fun/error35213.7
      (begin (set! r15 r15) (set! rax 36414) (jump r15)))
    (define L.fun/void35214.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void35215.11)))
    (define L.fun/ascii-char35207.9
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char35209.10
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void35215.11 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error35212.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error35213.7)))
    (define L.fun/empty35211.13
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.19)
        (jump L.fun/ascii-char35208.5)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.20)
        (jump L.fun/empty35210.6)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.21)
        (jump L.fun/error35212.12)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi 112)
        (set! rdi 24)
        (set! r15 L.rp.22)
        (jump L.*.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 808)
        (set! rdi 1176)
        (set! r15 L.rp.23)
        (jump L.+.16)))
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
        (set! rsi 1560)
        (set! rdi 1752)
        (set! r15 L.rp.25)
        (jump L.-.17)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1400)
        (set! rdi 40)
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
        (jump L.+.16)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.28)
        (jump L.-.17)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1136)
        (set! rdi 680)
        (set! r15 L.rp.29)
        (jump L.-.17)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1040)
        (set! rdi 1016)
        (set! r15 L.rp.30)
        (jump L.-.17)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.31)
        (jump L.-.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 288)
        (set! rdi 256)
        (set! r15 L.rp.32)
        (jump L.-.17)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1544)
        (set! rdi 280)
        (set! r15 L.rp.33)
        (jump L.+.16)))
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
        (jump L.+.16)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.37)
        (jump L.fun/void35214.8)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.42
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.20)
        (jump L.fun/empty43333.9)))
    (define L.error?.19
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 62) (jump L.__nested.43) (jump L.__nested.44))))
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
    (define L.void?.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 30) (jump L.__nested.75) (jump L.__nested.76))))
    (define L.__nested.75 (begin (set! rax 14) (jump r15)))
    (define L.__nested.76 (begin (set! rax 6) (jump r15)))
    (define L.fun/void43341.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void43342.11)))
    (define L.fun/empty43339.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/any43337.6
      (begin (set! r15 r15) (set! rax 13630) (jump r15)))
    (define L.fun/any43340.7 (begin (set! r15 r15) (set! rax 480) (jump r15)))
    (define L.fun/empty43335.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty43336.13)))
    (define L.fun/empty43333.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty43334.12)))
    (define L.fun/empty43338.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty43339.5)))
    (define L.fun/void43342.11 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty43334.12
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty43336.13
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.21)
        (jump L.fun/empty43335.8)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.22)
        (jump L.fun/any43337.6)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rdi r15)
        (set! r15 L.rp.23)
        (jump L.void?.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 704)
        (set! rdi 832)
        (set! r15 L.rp.24)
        (jump L.*.16)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1832)
        (set! rdi 1040)
        (set! r15 L.rp.25)
        (jump L.-.17)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.26)
        (jump L.*.16)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 568)
        (set! rdi 952)
        (set! r15 L.rp.27)
        (jump L.-.17)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1880)
        (set! rdi 1392)
        (set! r15 L.rp.28)
        (jump L.+.18)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.29)
        (jump L.+.18)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.30)
        (jump L.+.18)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 456)
        (set! rdi 616)
        (set! r15 L.rp.31)
        (jump L.*.16)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 432)
        (set! rdi 1928)
        (set! r15 L.rp.32)
        (jump L.-.17)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.33)
        (jump L.+.18)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1376)
        (set! rdi 400)
        (set! r15 L.rp.34)
        (jump L.+.18)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1920)
        (set! rdi 576)
        (set! r15 L.rp.35)
        (jump L.*.16)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.36)
        (jump L.*.16)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.37)
        (jump L.*.16)))
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
        (set! r15 L.rp.39)
        (jump L.fun/empty43338.10)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.40)
        (jump L.fun/any43340.7)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rdi r15)
        (set! r15 L.rp.41)
        (jump L.error?.19)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/void43341.4)))))
(check-by-interp
 '(module
    (define L.__main.48
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 104))
        (set! r15 L.rp.18)
        (jump L.fun/empty44111.6)))
    (define L.-.17
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
    (define L.*.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.72 (begin (set! rax 318) (jump r15)))
    (define L.__nested.69
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.73) (jump L.tmp.74))))
    (define L.__nested.70 (begin (set! rax 318) (jump r15)))
    (define L.fun/ascii-char44115.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char44116.11)))
    (define L.fun/ascii-char44119.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char44120.10)))
    (define L.fun/empty44111.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty44112.13)))
    (define L.fun/void44117.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void44118.9)))
    (define L.fun/ascii-char44114.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void44118.9 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char44120.10
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char44116.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char44113.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char44114.8)))
    (define L.fun/empty44112.13
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! r15 L.rp.19)
        (jump L.fun/ascii-char44113.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! r15 L.rp.20)
        (jump L.fun/ascii-char44115.4)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! r15 L.rp.21)
        (jump L.fun/void44117.7)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi 1768)
        (set! rdi 488)
        (set! r15 L.rp.22)
        (jump L.*.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 104))
        (set! rsi 1968)
        (set! rdi 992)
        (set! r15 L.rp.23)
        (jump L.*.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.24)
        (jump L.+.16)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 104))
        (set! rsi 120)
        (set! rdi 1304)
        (set! r15 L.rp.25)
        (jump L.*.15)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 104))
        (set! rsi 336)
        (set! rdi 296)
        (set! r15 L.rp.26)
        (jump L.*.15)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.27)
        (jump L.+.16)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -88))
        (set! r15 L.rp.28)
        (jump L.+.16)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 104))
        (set! rsi 136)
        (set! rdi 200)
        (set! r15 L.rp.29)
        (jump L.*.15)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 104))
        (set! rsi 1016)
        (set! rdi 544)
        (set! r15 L.rp.30)
        (jump L.*.15)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.31)
        (jump L.*.15)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 104))
        (set! rsi 712)
        (set! rdi 1440)
        (set! r15 L.rp.32)
        (jump L.*.15)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 104))
        (set! rsi 1408)
        (set! rdi 1984)
        (set! r15 L.rp.33)
        (jump L.-.17)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -88))
        (set! r15 L.rp.34)
        (jump L.-.17)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.35)
        (jump L.-.17)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -80))
        (set! r15 L.rp.36)
        (jump L.+.16)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 104))
        (set! r15 L.rp.37)
        (jump L.fun/ascii-char44119.5)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi 736)
        (set! rdi 416)
        (set! r15 L.rp.38)
        (jump L.+.16)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 104))
        (set! rsi 136)
        (set! rdi (rbp - -80))
        (set! r15 L.rp.39)
        (jump L.-.17)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.40)
        (jump L.-.17)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 104))
        (set! rsi 192)
        (set! rdi 520)
        (set! r15 L.rp.41)
        (jump L.+.16)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 104))
        (set! rsi (rbp - -80))
        (set! rdi (rbp - -80))
        (set! r15 L.rp.42)
        (jump L.*.15)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.43)
        (jump L.-.17)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -88))
        (set! r15 L.rp.44)
        (jump L.+.16)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 104))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 104))
        (set! rsi (rbp - -80))
        (set! rdi 440)
        (set! r15 L.rp.45)
        (jump L.*.15)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -80))
        (set! r15 L.rp.46)
        (jump L.*.15)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rbp (- rbp 104))
        (set! rsi r15)
        (set! rdi (rbp - -80))
        (set! r15 L.rp.47)
        (jump L.*.15)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 104))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.-.17)))))
(check-by-interp
 '(module
    (define L.__main.51
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 128))
        (set! rsi 1192)
        (set! rdi 2024)
        (set! r15 L.rp.16)
        (jump L.-.12)))
    (define L.fixnum?.15
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 0) (jump L.__nested.52) (jump L.__nested.53))))
    (define L.__nested.52 (begin (set! rax 14) (jump r15)))
    (define L.__nested.53 (begin (set! rax 6) (jump r15)))
    (define L.+.14
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.57 (begin (set! rax 574) (jump r15)))
    (define L.__nested.54
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.58) (jump L.tmp.59))))
    (define L.__nested.55 (begin (set! rax 574) (jump r15)))
    (define L.*.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.67 (begin (set! rax 318) (jump r15)))
    (define L.__nested.64
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.68) (jump L.tmp.69))))
    (define L.__nested.65 (begin (set! rax 318) (jump r15)))
    (define L.-.12
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.77 (begin (set! rax 830) (jump r15)))
    (define L.__nested.74
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.78) (jump L.tmp.79))))
    (define L.__nested.75 (begin (set! rax 830) (jump r15)))
    (define L.fun/empty58877.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error58875.5
      (begin (set! r15 r15) (set! rax 38462) (jump r15)))
    (define L.fun/ascii-char58879.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any58880.7 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/empty58876.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty58877.4)))
    (define L.fun/ascii-char58878.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char58879.6)))
    (define L.fun/error58874.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error58875.5)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1848)
        (set! rdi 472)
        (set! r15 L.rp.17)
        (jump L.*.13)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.18)
        (jump L.-.12)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 200)
        (set! rdi 1496)
        (set! r15 L.rp.19)
        (jump L.-.12)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 400)
        (set! rdi 936)
        (set! r15 L.rp.20)
        (jump L.*.13)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.21)
        (jump L.-.12)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.22)
        (jump L.-.12)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 512)
        (set! rdi 1400)
        (set! r15 L.rp.23)
        (jump L.-.12)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 568)
        (set! rdi 304)
        (set! r15 L.rp.24)
        (jump L.+.14)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.25)
        (jump L.*.13)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1904)
        (set! rdi 1000)
        (set! r15 L.rp.26)
        (jump L.-.12)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 448)
        (set! rdi 528)
        (set! r15 L.rp.27)
        (jump L.*.13)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.28)
        (jump L.-.12)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.29)
        (jump L.*.13)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.30)
        (jump L.+.14)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi 8)
        (set! rdi 888)
        (set! r15 L.rp.31)
        (jump L.-.12)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1296)
        (set! rdi 1576)
        (set! r15 L.rp.32)
        (jump L.*.13)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.33)
        (jump L.+.14)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 2000)
        (set! rdi 1288)
        (set! r15 L.rp.34)
        (jump L.-.12)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1088)
        (set! rdi 488)
        (set! r15 L.rp.35)
        (jump L.+.14)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.36)
        (jump L.*.13)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.37)
        (jump L.+.14)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1032)
        (set! rdi 1392)
        (set! r15 L.rp.38)
        (jump L.-.12)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 536)
        (set! rdi 1776)
        (set! r15 L.rp.39)
        (jump L.+.14)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.40)
        (jump L.+.14)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 2016)
        (set! rdi 1016)
        (set! r15 L.rp.41)
        (jump L.*.13)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1736)
        (set! rdi 1680)
        (set! r15 L.rp.42)
        (jump L.-.12)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.43)
        (jump L.-.12)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.44)
        (jump L.+.14)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.45)
        (jump L.*.13)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.46)
        (jump L.fun/error58874.10)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.47)
        (jump L.fun/empty58876.8)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.48)
        (jump L.fun/ascii-char58878.9)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.49)
        (jump L.fun/any58880.7)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rdi r15)
        (set! r15 L.rp.50)
        (jump L.fixnum?.15)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.63
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 184))
        (set! rsi 2024)
        (set! rdi 224)
        (set! r15 L.rp.14)
        (jump L.*.10)))
    (define L.void?.13
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 30) (jump L.__nested.64) (jump L.__nested.65))))
    (define L.__nested.64 (begin (set! rax 14) (jump r15)))
    (define L.__nested.65 (begin (set! rax 6) (jump r15)))
    (define L.-.12
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.69 (begin (set! rax 830) (jump r15)))
    (define L.__nested.66
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.70) (jump L.tmp.71))))
    (define L.__nested.67 (begin (set! rax 830) (jump r15)))
    (define L.+.11
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.79 (begin (set! rax 574) (jump r15)))
    (define L.__nested.76
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.80) (jump L.tmp.81))))
    (define L.__nested.77 (begin (set! rax 574) (jump r15)))
    (define L.*.10
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
    (define L.fun/ascii-char63953.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error63956.5
      (begin (set! r15 r15) (set! rax 20030) (jump r15)))
    (define L.fun/ascii-char63952.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char63953.4)))
    (define L.fun/error63955.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error63956.5)))
    (define L.fun/any63954.8 (begin (set! r15 r15) (set! rax 1784) (jump r15)))
    (define L.rp.14
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1720)
        (set! rdi 1520)
        (set! r15 L.rp.15)
        (jump L.*.10)))
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
        (set! rsi 680)
        (set! rdi 1768)
        (set! r15 L.rp.17)
        (jump L.+.11)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 840)
        (set! rdi 1488)
        (set! r15 L.rp.18)
        (jump L.-.12)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -176))
        (set! r15 L.rp.19)
        (jump L.*.10)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.20)
        (jump L.+.11)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1392)
        (set! rdi 1920)
        (set! r15 L.rp.21)
        (jump L.-.12)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1024)
        (set! rdi 1632)
        (set! r15 L.rp.22)
        (jump L.+.11)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -176))
        (set! r15 L.rp.23)
        (jump L.-.12)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1008)
        (set! rdi 1096)
        (set! r15 L.rp.24)
        (jump L.*.10)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 416)
        (set! rdi 416)
        (set! r15 L.rp.25)
        (jump L.+.11)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.26)
        (jump L.*.10)))
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
        (jump L.+.11)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! r15 L.rp.29)
        (jump L.fun/ascii-char63952.6)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 184))
        (set! rsi 120)
        (set! rdi 424)
        (set! r15 L.rp.30)
        (jump L.+.11)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 64)
        (set! rdi 792)
        (set! r15 L.rp.31)
        (jump L.-.12)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.32)
        (jump L.+.11)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 240)
        (set! rdi 936)
        (set! r15 L.rp.33)
        (jump L.*.10)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 376)
        (set! rdi 1192)
        (set! r15 L.rp.34)
        (jump L.*.10)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.35)
        (jump L.*.10)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.36)
        (jump L.-.12)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1872)
        (set! rdi 1392)
        (set! r15 L.rp.37)
        (jump L.-.12)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 304)
        (set! rdi 1024)
        (set! r15 L.rp.38)
        (jump L.+.11)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.39)
        (jump L.-.12)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 688)
        (set! rdi 1776)
        (set! r15 L.rp.40)
        (jump L.-.12)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1240)
        (set! rdi 552)
        (set! r15 L.rp.41)
        (jump L.+.11)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.42)
        (jump L.+.11)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.43)
        (jump L.*.10)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.44)
        (jump L.-.12)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi 1848)
        (set! rdi 872)
        (set! r15 L.rp.45)
        (jump L.+.11)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1936)
        (set! rdi 128)
        (set! r15 L.rp.46)
        (jump L.+.11)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.47)
        (jump L.+.11)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 256)
        (set! rdi 1336)
        (set! r15 L.rp.48)
        (jump L.-.12)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1576)
        (set! rdi 2000)
        (set! r15 L.rp.49)
        (jump L.*.10)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.50)
        (jump L.*.10)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.51)
        (jump L.*.10)))
    (define L.rp.51
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 184))
        (set! rsi 1152)
        (set! rdi 1528)
        (set! r15 L.rp.52)
        (jump L.+.11)))
    (define L.rp.52
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 816)
        (set! rdi 1792)
        (set! r15 L.rp.53)
        (jump L.+.11)))
    (define L.rp.53
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.54)
        (jump L.+.11)))
    (define L.rp.54
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 184))
        (set! rsi 2032)
        (set! rdi 512)
        (set! r15 L.rp.55)
        (jump L.+.11)))
    (define L.rp.55
      (begin
        (set! rbp (+ rbp 184))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 184))
        (set! rsi 360)
        (set! rdi 1032)
        (set! r15 L.rp.56)
        (jump L.*.10)))
    (define L.rp.56
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -160))
        (set! r15 L.rp.57)
        (jump L.*.10)))
    (define L.rp.57
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -152))
        (set! r15 L.rp.58)
        (jump L.*.10)))
    (define L.rp.58
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rsi r15)
        (set! rdi (rbp - -168))
        (set! r15 L.rp.59)
        (jump L.-.12)))
    (define L.rp.59
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! r15 L.rp.60)
        (jump L.fun/any63954.8)))
    (define L.rp.60
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! rdi r15)
        (set! r15 L.rp.61)
        (jump L.void?.13)))
    (define L.rp.61
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rbp (- rbp 184))
        (set! r15 L.rp.62)
        (jump L.fun/error63955.7)))
    (define L.rp.62
      (begin
        (set! rbp (+ rbp 184))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.38
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 72))
        (set! rsi 336)
        (set! rdi 104)
        (set! r15 L.rp.18)
        (jump L.+.15)))
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
    (define L.fun/ascii-char71274.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void71278.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char71271.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char71272.9)))
    (define L.fun/ascii-char71273.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char71274.4)))
    (define L.fun/empty71270.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char71272.9
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char71275.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char71276.13)))
    (define L.fun/void71277.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void71278.5)))
    (define L.fun/empty71269.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty71270.8)))
    (define L.fun/ascii-char71276.13
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1800)
        (set! rdi 888)
        (set! r15 L.rp.19)
        (jump L.+.15)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.20)
        (jump L.*.16)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1344)
        (set! rdi 872)
        (set! r15 L.rp.21)
        (jump L.-.17)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 680)
        (set! rdi 1360)
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
        (jump L.-.17)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.24)
        (jump L.+.15)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1248)
        (set! rdi 72)
        (set! r15 L.rp.25)
        (jump L.+.15)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1360)
        (set! rdi 896)
        (set! r15 L.rp.26)
        (jump L.+.15)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.27)
        (jump L.-.17)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 152)
        (set! rdi 680)
        (set! r15 L.rp.28)
        (jump L.*.16)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1392)
        (set! rdi 1104)
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
        (jump L.+.15)))
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
        (jump L.*.16)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.33)
        (jump L.fun/empty71269.12)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.34)
        (jump L.fun/ascii-char71271.6)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.35)
        (jump L.fun/ascii-char71273.7)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.36)
        (jump L.fun/ascii-char71275.10)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.37)
        (jump L.fun/void71277.11)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.50
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 128))
        (set! rsi 2024)
        (set! rdi 1888)
        (set! r15 L.rp.16)
        (jump L.*.13)))
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
    (define L.fun/empty73456.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty73457.8)))
    (define L.fun/ascii-char73458.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char73459.10)))
    (define L.fun/empty73463.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error73460.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error73461.9)))
    (define L.fun/empty73457.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error73461.9
      (begin (set! r15 r15) (set! rax 20542) (jump r15)))
    (define L.fun/ascii-char73459.10
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty73462.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty73463.6)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1464)
        (set! rdi 696)
        (set! r15 L.rp.17)
        (jump L.*.13)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.18)
        (jump L.-.14)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 416)
        (set! rdi 1344)
        (set! r15 L.rp.19)
        (jump L.*.13)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 88)
        (set! rdi 464)
        (set! r15 L.rp.20)
        (jump L.-.14)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.21)
        (jump L.+.15)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.22)
        (jump L.-.14)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1760)
        (set! rdi 40)
        (set! r15 L.rp.23)
        (jump L.*.13)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1688)
        (set! rdi 104)
        (set! r15 L.rp.24)
        (jump L.-.14)))
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
        (set! rsi 952)
        (set! rdi 1952)
        (set! r15 L.rp.26)
        (jump L.+.15)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 584)
        (set! rdi 1264)
        (set! r15 L.rp.27)
        (jump L.*.13)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.28)
        (jump L.-.14)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.29)
        (jump L.-.14)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.30)
        (jump L.+.15)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.31)
        (jump L.fun/empty73456.4)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.32)
        (jump L.fun/ascii-char73458.5)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.33)
        (jump L.fun/error73460.7)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1504)
        (set! rdi 2008)
        (set! r15 L.rp.34)
        (jump L.-.14)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1856)
        (set! rdi 1768)
        (set! r15 L.rp.35)
        (jump L.+.15)))
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
        (set! rsi 1728)
        (set! rdi 880)
        (set! r15 L.rp.37)
        (jump L.-.14)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 152)
        (set! rdi 1992)
        (set! r15 L.rp.38)
        (jump L.*.13)))
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
        (jump L.*.13)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 32) rax)
        (set! rbp (- rbp 128))
        (set! rsi 672)
        (set! rdi 840)
        (set! r15 L.rp.41)
        (jump L.*.13)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 368)
        (set! rdi 1704)
        (set! r15 L.rp.42)
        (jump L.+.15)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.43)
        (jump L.*.13)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1992)
        (set! rdi 624)
        (set! r15 L.rp.44)
        (jump L.*.13)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 920)
        (set! rdi 1976)
        (set! r15 L.rp.45)
        (jump L.-.14)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.46)
        (jump L.*.13)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.47)
        (jump L.-.14)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.48)
        (jump L.-.14)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.49)
        (jump L.fun/empty73462.11)))
    (define L.rp.49
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
        (set! rbp (- rbp 72))
        (set! r15 L.rp.18)
        (jump L.fun/void77838.5)))
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
    (define L.fun/void77842.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void77843.9)))
    (define L.fun/void77838.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void77839.10)))
    (define L.fun/error77846.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error77847.13)))
    (define L.fun/error77845.7
      (begin (set! r15 r15) (set! rax 62014) (jump r15)))
    (define L.fun/empty77840.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty77841.11)))
    (define L.fun/void77843.9 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void77839.10 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty77841.11
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error77844.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error77845.7)))
    (define L.fun/error77847.13
      (begin (set! r15 r15) (set! rax 48702) (jump r15)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi 800)
        (set! rdi 1560)
        (set! r15 L.rp.19)
        (jump L.*.15)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1936)
        (set! rdi 1880)
        (set! r15 L.rp.20)
        (jump L.-.16)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.21)
        (jump L.+.17)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 752)
        (set! rdi 216)
        (set! r15 L.rp.22)
        (jump L.*.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 800)
        (set! rdi 1208)
        (set! r15 L.rp.23)
        (jump L.-.16)))
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
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.25)
        (jump L.+.17)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 752)
        (set! rdi 8)
        (set! r15 L.rp.26)
        (jump L.-.16)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1208)
        (set! rdi 1448)
        (set! r15 L.rp.27)
        (jump L.-.16)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.28)
        (jump L.-.16)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1784)
        (set! rdi 1232)
        (set! r15 L.rp.29)
        (jump L.+.17)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1256)
        (set! rdi 1288)
        (set! r15 L.rp.30)
        (jump L.-.16)))
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
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.32)
        (jump L.-.16)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.33)
        (jump L.+.17)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.34)
        (jump L.fun/empty77840.8)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.35)
        (jump L.fun/void77842.4)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.36)
        (jump L.fun/error77844.12)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.37)
        (jump L.fun/error77846.6)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
(check-by-interp
 '(module
    (define L.__main.54
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 120))
        (set! r15 L.rp.18)
        (jump L.fun/error78092.6)))
    (define L.ascii-char?.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 255))
        (set! r14 r14)
        (if (= r14 46) (jump L.__nested.55) (jump L.__nested.56))))
    (define L.__nested.55 (begin (set! rax 14) (jump r15)))
    (define L.__nested.56 (begin (set! rax 6) (jump r15)))
    (define L.boolean?.16
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 247))
        (set! r14 r14)
        (if (= r14 6) (jump L.__nested.57) (jump L.__nested.58))))
    (define L.__nested.57 (begin (set! rax 14) (jump r15)))
    (define L.__nested.58 (begin (set! rax 6) (jump r15)))
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
    (define L.*.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r13 rsi)
        (set! r9 r13)
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
      (begin
        (set! r13 r13)
        (set! r13 (arithmetic-shift-right r13 3))
        (set! r13 r13)
        (set! r14 r14)
        (set! r14 (* r14 r13))
        (set! rax r14)
        (jump r15)))
    (define L.__nested.72 (begin (set! rax 318) (jump r15)))
    (define L.__nested.69
      (begin
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.73) (jump L.tmp.74))))
    (define L.__nested.70 (begin (set! rax 318) (jump r15)))
    (define L.-.13
      (begin
        (set! r15 r15)
        (set! r13 rdi)
        (set! r14 rsi)
        (set! r9 r14)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.86) (jump L.tmp.87))))
    (define L.tmp.86 (begin (set! r9 14) (jump L.tmp.88)))
    (define L.tmp.87 (begin (set! r9 6) (jump L.tmp.88)))
    (define L.tmp.88 (if (!= r9 6) (jump L.__nested.79) (jump L.__nested.80)))
    (define L.tmp.83 (begin (set! r9 14) (jump L.tmp.85)))
    (define L.tmp.84 (begin (set! r9 6) (jump L.tmp.85)))
    (define L.tmp.85 (if (!= r9 6) (jump L.__nested.81) (jump L.__nested.82)))
    (define L.__nested.81
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.82 (begin (set! rax 830) (jump r15)))
    (define L.__nested.79
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.83) (jump L.tmp.84))))
    (define L.__nested.80 (begin (set! rax 830) (jump r15)))
    (define L.fun/any78095.4 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/void78099.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error78092.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error78093.9)))
    (define L.fun/any78094.7 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/error78097.8
      (begin (set! r15 r15) (set! rax 36670) (jump r15)))
    (define L.fun/error78093.9
      (begin (set! r15 r15) (set! rax 24126) (jump r15)))
    (define L.fun/error78096.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error78097.8)))
    (define L.fun/void78098.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void78099.5)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi 480)
        (set! rdi 1192)
        (set! r15 L.rp.19)
        (jump L.-.13)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 56)
        (set! rdi 1584)
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
        (jump L.-.13)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 128)
        (set! rdi 1488)
        (set! r15 L.rp.22)
        (jump L.+.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 120))
        (set! rsi 1720)
        (set! rdi 488)
        (set! r15 L.rp.23)
        (jump L.+.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -104))
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
        (jump L.+.15)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 1640)
        (set! rdi 1312)
        (set! r15 L.rp.26)
        (jump L.*.14)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 120))
        (set! rsi 864)
        (set! rdi 1184)
        (set! r15 L.rp.27)
        (jump L.*.14)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.28)
        (jump L.-.13)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 120))
        (set! rsi 296)
        (set! rdi 208)
        (set! r15 L.rp.29)
        (jump L.*.14)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 120))
        (set! rsi 32)
        (set! rdi 800)
        (set! r15 L.rp.30)
        (jump L.*.14)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.31)
        (jump L.*.14)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.32)
        (jump L.-.13)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.33)
        (jump L.-.13)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! r15 L.rp.34)
        (jump L.fun/any78094.7)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rdi r15)
        (set! r15 L.rp.35)
        (jump L.boolean?.16)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! r15 L.rp.36)
        (jump L.fun/any78095.4)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rdi r15)
        (set! r15 L.rp.37)
        (jump L.ascii-char?.17)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi 1384)
        (set! rdi 136)
        (set! r15 L.rp.38)
        (jump L.*.14)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 592)
        (set! rdi 1784)
        (set! r15 L.rp.39)
        (jump L.-.13)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.40)
        (jump L.+.15)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 120))
        (set! rsi 584)
        (set! rdi 1536)
        (set! r15 L.rp.41)
        (jump L.+.15)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 1504)
        (set! rdi 1528)
        (set! r15 L.rp.42)
        (jump L.*.14)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.43)
        (jump L.*.14)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.44)
        (jump L.+.15)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 120))
        (set! rsi 1824)
        (set! rdi 1536)
        (set! r15 L.rp.45)
        (jump L.*.14)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 840)
        (set! rdi 1760)
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
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 120))
        (set! rsi 1032)
        (set! rdi 1864)
        (set! r15 L.rp.48)
        (jump L.-.13)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 120))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 120))
        (set! rsi 688)
        (set! rdi 88)
        (set! r15 L.rp.49)
        (jump L.-.13)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.50)
        (jump L.-.13)))
    (define L.rp.50
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.51)
        (jump L.+.15)))
    (define L.rp.51
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! rsi r15)
        (set! rdi (rbp - -96))
        (set! r15 L.rp.52)
        (jump L.-.13)))
    (define L.rp.52
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! rbp (- rbp 120))
        (set! r15 L.rp.53)
        (jump L.fun/error78096.10)))
    (define L.rp.53
      (begin
        (set! rbp (+ rbp 120))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/void78098.11)))))
(check-by-interp
 '(module
    (define L.__main.39
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 72))
        (set! rsi 248)
        (set! rdi 1216)
        (set! r15 L.rp.18)
        (jump L.+.14)))
    (define L.boolean?.17
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 247))
        (set! r14 r14)
        (if (= r14 6) (jump L.__nested.40) (jump L.__nested.41))))
    (define L.__nested.40 (begin (set! rax 14) (jump r15)))
    (define L.__nested.41 (begin (set! rax 6) (jump r15)))
    (define L.-.16
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
    (define L.*.15
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
    (define L.+.14
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
    (define L.fun/void101999.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty101997.5
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char101994.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char101995.11)))
    (define L.fun/void101992.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void101993.12)))
    (define L.fun/void101998.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void101999.4)))
    (define L.fun/empty101996.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty101997.5)))
    (define L.fun/any101991.10 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char101995.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void101993.12
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 528)
        (set! rdi 1128)
        (set! r15 L.rp.19)
        (jump L.+.14)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.20)
        (jump L.*.15)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1032)
        (set! rdi 176)
        (set! r15 L.rp.21)
        (jump L.-.16)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1320)
        (set! rdi 968)
        (set! r15 L.rp.22)
        (jump L.-.16)))
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
        (set! rsi 1872)
        (set! rdi 424)
        (set! r15 L.rp.25)
        (jump L.-.16)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1288)
        (set! rdi 480)
        (set! r15 L.rp.26)
        (jump L.+.14)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.27)
        (jump L.+.14)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! rsi 1400)
        (set! rdi 1368)
        (set! r15 L.rp.28)
        (jump L.-.16)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 72))
        (set! rsi 544)
        (set! rdi 704)
        (set! r15 L.rp.29)
        (jump L.+.14)))
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
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.31)
        (jump L.-.16)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.32)
        (jump L.+.14)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.33)
        (jump L.fun/any101991.10)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! rdi r15)
        (set! r15 L.rp.34)
        (jump L.boolean?.17)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.35)
        (jump L.fun/void101992.7)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.36)
        (jump L.fun/ascii-char101994.6)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 72))
        (set! r15 rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.37)
        (jump L.fun/empty101996.9)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 72))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 72))
        (set! r15 L.rp.38)
        (jump L.fun/void101998.8)))
    (define L.rp.38
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
        (jump L.fun/void102352.11)))
    (define L.fun/void102362.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void102363.9)))
    (define L.fun/empty102356.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty102357.12)))
    (define L.fun/error102354.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error102355.10)))
    (define L.fun/void102358.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void102359.13)))
    (define L.fun/void102353.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void102363.9 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error102355.10
      (begin (set! r15 r15) (set! rax 37694) (jump r15)))
    (define L.fun/void102352.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void102353.8)))
    (define L.fun/empty102357.12
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void102359.13
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void102360.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void102361.15)))
    (define L.fun/void102361.15
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.18)
        (jump L.fun/error102354.6)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 16))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.19)
        (jump L.fun/empty102356.5)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.20)
        (jump L.fun/void102358.7)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.21)
        (jump L.fun/void102360.14)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 16))
        (set! r15 rax)
        (set! rbp (- rbp 16))
        (set! r15 L.rp.22)
        (jump L.fun/void102362.4)))
    (define L.rp.22
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
        (jump L.fun/any122156.11)))
    (define L.+.19
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.45 (begin (set! rax 574) (jump r15)))
    (define L.__nested.42
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.46) (jump L.tmp.47))))
    (define L.__nested.43 (begin (set! rax 574) (jump r15)))
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
    (define L.fun/void122163.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void122164.13)))
    (define L.fun/ascii-char122159.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char122160.6)))
    (define L.fun/ascii-char122160.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char122162.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty122158.8
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error122165.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error122166.10)))
    (define L.fun/error122166.10
      (begin (set! r15 r15) (set! rax 46910) (jump r15)))
    (define L.fun/any122156.11 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty122157.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty122158.8)))
    (define L.fun/void122164.13
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char122161.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char122162.7)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rdi r15)
        (set! r15 L.rp.21)
        (jump L.boolean?.16)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.22)
        (jump L.fun/empty122157.12)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 96)
        (set! rdi 1368)
        (set! r15 L.rp.23)
        (jump L.-.17)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 448)
        (set! rdi 1560)
        (set! r15 L.rp.24)
        (jump L.-.17)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.25)
        (jump L.-.17)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 224)
        (set! rdi 952)
        (set! r15 L.rp.26)
        (jump L.-.17)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1680)
        (set! rdi 1856)
        (set! r15 L.rp.27)
        (jump L.*.18)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.28)
        (jump L.+.19)))
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
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 304)
        (set! rdi 104)
        (set! r15 L.rp.30)
        (jump L.-.17)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1296)
        (set! rdi 1432)
        (set! r15 L.rp.31)
        (jump L.*.18)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.32)
        (jump L.+.19)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1160)
        (set! rdi 728)
        (set! r15 L.rp.33)
        (jump L.+.19)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 464)
        (set! rdi 416)
        (set! r15 L.rp.34)
        (jump L.-.17)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.35)
        (jump L.*.18)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
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
        (jump L.-.17)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.38)
        (jump L.fun/ascii-char122159.5)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.39)
        (jump L.fun/ascii-char122161.14)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.40)
        (jump L.fun/void122163.4)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/error122165.9)))))
(check-by-interp
 '(module
    (define L.__main.40
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.20)
        (jump L.fun/error124205.15)))
    (define L.-.19
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
    (define L.+.17
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.64 (begin (set! rax 574) (jump r15)))
    (define L.__nested.61
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.65) (jump L.tmp.66))))
    (define L.__nested.62 (begin (set! rax 574) (jump r15)))
    (define L.fun/void124216.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char124211.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char124212.10)))
    (define L.fun/error124206.6
      (begin (set! r15 r15) (set! rax 8766) (jump r15)))
    (define L.fun/error124213.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error124214.11)))
    (define L.fun/ascii-char124207.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char124208.14)))
    (define L.fun/void124215.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void124216.4)))
    (define L.fun/ascii-char124212.10
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error124214.11
      (begin (set! r15 r15) (set! rax 1598) (jump r15)))
    (define L.fun/error124209.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error124210.13)))
    (define L.fun/error124210.13
      (begin (set! r15 r15) (set! rax 830) (jump r15)))
    (define L.fun/ascii-char124208.14
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error124205.15
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error124206.6)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.21)
        (jump L.fun/ascii-char124207.8)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.22)
        (jump L.fun/error124209.12)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.23)
        (jump L.fun/ascii-char124211.5)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! r15 L.rp.24)
        (jump L.fun/error124213.7)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi 16)
        (set! rdi 1640)
        (set! r15 L.rp.25)
        (jump L.+.17)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 120)
        (set! rdi 1384)
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
        (jump L.*.18)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1400)
        (set! rdi 712)
        (set! r15 L.rp.28)
        (jump L.+.17)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 912)
        (set! rdi 936)
        (set! r15 L.rp.29)
        (jump L.+.17)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.30)
        (jump L.+.17)))
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
        (set! rsi 952)
        (set! rdi 1344)
        (set! r15 L.rp.32)
        (jump L.*.18)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 264)
        (set! rdi 648)
        (set! r15 L.rp.33)
        (jump L.-.19)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.34)
        (jump L.*.18)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 64))
        (set! rsi 1552)
        (set! rdi 560)
        (set! r15 L.rp.35)
        (jump L.-.19)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 64))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 64))
        (set! rsi 952)
        (set! rdi 592)
        (set! r15 L.rp.36)
        (jump L.+.17)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -48))
        (set! r15 L.rp.37)
        (jump L.+.17)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -40))
        (set! r15 L.rp.38)
        (jump L.+.17)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! rbp (- rbp 64))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.39)
        (jump L.*.18)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 64))
        (set! r15 rax)
        (set! r15 (rbp - 0))
        (jump L.fun/void124215.9)))))
(check-by-interp
 '(module
    (define L.__main.43
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 80))
        (set! r15 L.rp.18)
        (jump L.fun/void156379.5)))
    (define L.+.17
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
    (define L.*.16
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
    (define L.-.15
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
      (begin (set! r13 r13) (set! r13 (- r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.67 (begin (set! rax 830) (jump r15)))
    (define L.__nested.64
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.68) (jump L.tmp.69))))
    (define L.__nested.65 (begin (set! rax 830) (jump r15)))
    (define L.pair?.14
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 r14)
        (set! r14 (bitwise-and r14 7))
        (set! r14 r14)
        (if (= r14 1) (jump L.__nested.74) (jump L.__nested.75))))
    (define L.__nested.74 (begin (set! rax 14) (jump r15)))
    (define L.__nested.75 (begin (set! rax 6) (jump r15)))
    (define L.fun/ascii-char156382.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char156383.11)))
    (define L.fun/void156379.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void156380.6)))
    (define L.fun/void156380.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void156387.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any156381.8
      (begin (set! r15 r15) (set! rax 11326) (jump r15)))
    (define L.fun/void156386.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void156387.7)))
    (define L.fun/ascii-char156384.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char156385.12)))
    (define L.fun/ascii-char156383.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char156385.12
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! r15 L.rp.19)
        (jump L.fun/any156381.8)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rdi r15)
        (set! r15 L.rp.20)
        (jump L.pair?.14)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi 2016)
        (set! rdi 232)
        (set! r15 L.rp.21)
        (jump L.-.15)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 80))
        (set! rsi 304)
        (set! rdi 504)
        (set! r15 L.rp.22)
        (jump L.-.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.23)
        (jump L.-.15)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 80))
        (set! rsi 1152)
        (set! rdi 368)
        (set! r15 L.rp.24)
        (jump L.-.15)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 80))
        (set! rsi 424)
        (set! rdi 1752)
        (set! r15 L.rp.25)
        (jump L.-.15)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.26)
        (jump L.-.15)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.27)
        (jump L.-.15)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 80))
        (set! rsi 1616)
        (set! rdi 1736)
        (set! r15 L.rp.28)
        (jump L.-.15)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 80))
        (set! rsi 568)
        (set! rdi 320)
        (set! r15 L.rp.29)
        (jump L.*.16)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.30)
        (jump L.-.15)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 80))
        (set! rsi 1224)
        (set! rdi 192)
        (set! r15 L.rp.31)
        (jump L.+.17)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 80))
        (set! rsi 2016)
        (set! rdi 1976)
        (set! r15 L.rp.32)
        (jump L.-.15)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.33)
        (jump L.+.17)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -56))
        (set! r15 L.rp.34)
        (jump L.*.16)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.35)
        (jump L.+.17)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 80))
        (set! r15 L.rp.36)
        (jump L.fun/ascii-char156382.4)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! r15 L.rp.37)
        (jump L.fun/ascii-char156384.10)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! r15 L.rp.38)
        (jump L.fun/void156386.9)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi 1944)
        (set! rdi 912)
        (set! r15 L.rp.39)
        (jump L.+.17)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 80))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 80))
        (set! rsi (rbp - -72))
        (set! rdi 1896)
        (set! r15 L.rp.40)
        (jump L.+.17)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -64))
        (set! r15 L.rp.41)
        (jump L.-.15)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rbp (- rbp 80))
        (set! rsi r15)
        (set! rdi (rbp - -72))
        (set! r15 L.rp.42)
        (jump L.*.16)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 80))
        (set! r15 rax)
        (set! rsi r15)
        (set! rdi (rbp - 8))
        (set! r15 (rbp - 0))
        (jump L.-.15)))))
(check-by-interp
 '(module
    (define L.__main.50
      (begin
        (set! (rbp - 0) r15)
        (set! rbp (- rbp 128))
        (set! rsi 1576)
        (set! rdi 2008)
        (set! r15 L.rp.16)
        (jump L.*.13)))
    (define L.-.15
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
    (define L.+.14
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
      (begin (set! r13 r13) (set! r13 (+ r13 r14)) (set! rax r13) (jump r15)))
    (define L.__nested.64 (begin (set! rax 574) (jump r15)))
    (define L.__nested.61
      (begin
        (set! r9 r13)
        (set! r9 (bitwise-and r9 7))
        (set! r9 r9)
        (if (= r9 0) (jump L.tmp.65) (jump L.tmp.66))))
    (define L.__nested.62 (begin (set! rax 574) (jump r15)))
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
    (define L.fun/empty171686.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty171687.10)))
    (define L.fun/void171689.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char171684.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char171685.9)))
    (define L.fun/void171688.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void171689.5)))
    (define L.fun/void171691.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char171685.9
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty171687.10
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void171690.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void171691.8)))
    (define L.rp.16
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1128)
        (set! rdi 1088)
        (set! r15 L.rp.17)
        (jump L.*.13)))
    (define L.rp.17
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.18)
        (jump L.+.14)))
    (define L.rp.18
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 48)
        (set! rdi 1968)
        (set! r15 L.rp.19)
        (jump L.-.15)))
    (define L.rp.19
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 624)
        (set! rdi 592)
        (set! r15 L.rp.20)
        (jump L.*.13)))
    (define L.rp.20
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.21)
        (jump L.+.14)))
    (define L.rp.21
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.22)
        (jump L.-.15)))
    (define L.rp.22
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 672)
        (set! rdi 1184)
        (set! r15 L.rp.23)
        (jump L.*.13)))
    (define L.rp.23
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1584)
        (set! rdi 1320)
        (set! r15 L.rp.24)
        (jump L.+.14)))
    (define L.rp.24
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.25)
        (jump L.-.15)))
    (define L.rp.25
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 904)
        (set! rdi 1768)
        (set! r15 L.rp.26)
        (jump L.+.14)))
    (define L.rp.26
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 104)
        (set! rdi 928)
        (set! r15 L.rp.27)
        (jump L.*.13)))
    (define L.rp.27
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.28)
        (jump L.-.15)))
    (define L.rp.28
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.29)
        (jump L.+.14)))
    (define L.rp.29
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.30)
        (jump L.-.15)))
    (define L.rp.30
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi 240)
        (set! rdi 1160)
        (set! r15 L.rp.31)
        (jump L.*.13)))
    (define L.rp.31
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 256)
        (set! rdi 1520)
        (set! r15 L.rp.32)
        (jump L.-.15)))
    (define L.rp.32
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.33)
        (jump L.*.13)))
    (define L.rp.33
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 240)
        (set! rdi 960)
        (set! r15 L.rp.34)
        (jump L.+.14)))
    (define L.rp.34
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 728)
        (set! rdi 624)
        (set! r15 L.rp.35)
        (jump L.+.14)))
    (define L.rp.35
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.36)
        (jump L.+.14)))
    (define L.rp.36
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.37)
        (jump L.-.15)))
    (define L.rp.37
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1080)
        (set! rdi 1880)
        (set! r15 L.rp.38)
        (jump L.-.15)))
    (define L.rp.38
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 1000)
        (set! rdi 440)
        (set! r15 L.rp.39)
        (jump L.*.13)))
    (define L.rp.39
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.40)
        (jump L.+.14)))
    (define L.rp.40
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 24) rax)
        (set! rbp (- rbp 128))
        (set! rsi 608)
        (set! rdi 936)
        (set! r15 L.rp.41)
        (jump L.-.15)))
    (define L.rp.41
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 16) rax)
        (set! rbp (- rbp 128))
        (set! rsi 984)
        (set! rdi 568)
        (set! r15 L.rp.42)
        (jump L.-.15)))
    (define L.rp.42
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -112))
        (set! r15 L.rp.43)
        (jump L.-.15)))
    (define L.rp.43
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -104))
        (set! r15 L.rp.44)
        (jump L.-.15)))
    (define L.rp.44
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! rsi r15)
        (set! rdi (rbp - -120))
        (set! r15 L.rp.45)
        (jump L.-.15)))
    (define L.rp.45
      (begin
        (set! rbp (+ rbp 128))
        (set! (rbp - 8) rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.46)
        (jump L.fun/ascii-char171684.6)))
    (define L.rp.46
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.47)
        (jump L.fun/empty171686.4)))
    (define L.rp.47
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.48)
        (jump L.fun/void171688.7)))
    (define L.rp.48
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rbp (- rbp 128))
        (set! r15 L.rp.49)
        (jump L.fun/void171690.11)))
    (define L.rp.49
      (begin
        (set! rbp (+ rbp 128))
        (set! r15 rax)
        (set! rax (rbp - 8))
        (jump (rbp - 0))))))
