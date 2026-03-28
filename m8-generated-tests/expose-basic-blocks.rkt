#lang racket
(require cpsc411/compiler-lib cpsc411/langs/v8 "../expose-basic-blocks.rkt")
(define (fail-if-invalid p)
  (when (not (block-pred-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "block-pred-lang-v8"
      " program")))
  p)
(define (check-by-interp p)
  (interp-nested-asm-lang-v8 p)
  (interp-block-pred-lang-v8 (fail-if-invalid (expose-basic-blocks p))))

(check-by-interp '(module (begin (set! r15 r15) (set! rax 25390) (jump r15))))
(check-by-interp '(module (begin (set! r15 r15) (set! rax 48958) (jump r15))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8383.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char8383.4))))
(check-by-interp
 '(module
    (define L.fun/error8386.4
      (begin (set! r15 r15) (set! rax 20030) (jump r15)))
    (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error8386.4))))
(check-by-interp
 '(module (begin (set! r15 r15) (set! r14 22) (set! rax 30) (jump r15))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin (set! r14 6) (false))
        (begin (set! rax 50494) (jump r15))
        (begin (set! rax 57662) (jump r15))))))
(check-by-interp
 '(module
    (define L.fun/boolean8393.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 14) (jump r15)))
    (begin
      (set! r15 r15)
      (if (begin (set! r14 14) (true)) (set! r14 928) (set! r14 1456))
      (set! rdi r14)
      (set! r15 r15)
      (jump L.fun/boolean8393.4))))
(check-by-interp
 '(module
    (define L.+.6
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
    (define L.fun/fixnum8396.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 1928) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (if (begin (set! r15 14) (true))
        (set! (rbp - 8) 592)
        (set! (rbp - 8) 776))
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.7
          (begin (set! rdi 30) (set! r15 L.rp.7) (jump L.fun/fixnum8396.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi (rbp - 8))
      (set! r15 (rbp - 0))
      (jump L.+.6))))
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
    (define L.fun/void8399.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.7
          (begin
            (set! rsi 1200)
            (set! rdi 1080)
            (set! r15 L.rp.7)
            (jump L.*.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rdi r15)
      (set! r15 (rbp - 0))
      (jump L.fun/void8399.4))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (set! r14 22)
      (set! r14 22)
      (set! rax 30)
      (jump r15))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin (set! r14 6) (false))
        (begin (set! rax 48) (jump r15))
        (begin (set! rax 1600) (jump r15))))))
(check-by-interp
 '(module
    (define L.fun/error8463.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax r14)
        (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (set! r15 25390)
      (set! r15 25390)
      (set! r15 62782)
      (set! (rbp - 8) r15)
      (set! r15 25390)
      (set! r15 6)
      (set! r15 30)
      (set! r15 56894)
      (if (begin (set! r14 6) (false)) (set! r14 318) (set! r14 37182))
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.6
          (begin
            (set! rsi r14)
            (set! rdi r15)
            (set! r15 L.rp.6)
            (jump L.fun/error8463.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi (rbp - 8))
      (set! r15 (rbp - 0))
      (jump L.fun/error8463.4))))
(check-by-interp
 '(module
    (define L.*.7
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
    (define L.fun/fixnum8490.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 168)
        (jump r15)))
    (define L.fun/boolean8489.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 6)
        (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 8))
                (return-point L.rp.8
                  (begin
                    (set! rsi 608)
                    (set! rdi 63550)
                    (set! r15 L.rp.8)
                    (jump L.fun/boolean8489.5)))
                (set! rbp (+ rbp 8)))
              (set! r15 rax))
            (!= r15 6))
        (begin
          (set! rsi 14)
          (set! rdi 30)
          (set! r15 (rbp - 0))
          (jump L.fun/fixnum8490.4))
        (begin
          (set! rsi 2008)
          (set! rdi 1712)
          (set! r15 (rbp - 0))
          (jump L.*.7))))))
(check-by-interp
 '(module
    (define L.fun/empty8497.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void8496.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char8498.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.8 (begin (set! r15 L.rp.8) (jump L.fun/void8496.5)))
        (set! rbp (+ rbp 16)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.9
          (begin (set! r15 L.rp.9) (jump L.fun/empty8497.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char8498.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
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
    (define L.fun/fixnum8501.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! rax 184)
        (jump r15)))
    (begin
      (set! r15 r15)
      (if (begin
            (set! r14 30)
            (set! r14 41534)
            (set! r14 22)
            (begin (set! r14 14) (true)))
        (begin (set! rsi 984) (set! rdi 208) (set! r15 r15) (jump L.*.6))
        (begin
          (set! rsi 30)
          (set! rdi 14)
          (set! r15 r15)
          (jump L.fun/fixnum8501.4))))))
(check-by-interp
 '(module
    (define L.+.5
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
    (begin
      (set! r15 r15)
      (if (begin
            (set! r14 30)
            (set! r14 25390)
            (set! r14 1616)
            (begin (set! r14 14) (true)))
        (begin (set! rsi 1640) (set! rdi 520) (set! r15 r15) (jump L.+.5))
        (begin (set! rsi 392) (set! rdi 24) (set! r15 r15) (jump L.+.5))))))
(check-by-interp
 '(module
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
    (define L.pair?.7
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
    (define L.fun/ascii-char8555.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void8554.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.9
          (begin (set! rdi 12606) (set! r15 L.rp.9) (jump L.pair?.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/void8554.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin
            (set! rsi 1552)
            (set! rdi 736)
            (set! r15 L.rp.11)
            (jump L.+.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/ascii-char8555.4))))
(check-by-interp
 '(module
    (define L.+.7
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
    (define L.error?.6
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
    (define L.fun/empty8590.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.8
          (begin (set! r15 L.rp.8) (jump L.fun/empty8590.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.9
          (begin (set! rdi 30) (set! r15 L.rp.9) (jump L.error?.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin
            (set! rsi 1496)
            (set! rdi 1392)
            (set! r15 L.rp.10)
            (jump L.+.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rax r15)
      (jump (rbp - 0)))))
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
    (define L.fun/void8641.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty8642.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void8643.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/void8641.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty8642.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin
            (set! rsi 1936)
            (set! rdi 1640)
            (set! r15 L.rp.12)
            (jump L.-.8)))
        (set! rbp (+ rbp 16)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin
            (set! rsi 904)
            (set! rdi 1640)
            (set! r15 L.rp.13)
            (jump L.*.9)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -8))
            (set! r15 L.rp.14)
            (jump L.-.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/void8643.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax r15)
      (jump (rbp - 0)))))
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
    (define L.fun/error9361.4
      (begin (set! r15 r15) (set! rax 14142) (jump r15)))
    (define L.fun/empty9358.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void9360.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty9359.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty9358.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin
            (set! rsi 1320)
            (set! rdi 1456)
            (set! r15 L.rp.12)
            (jump L.*.9)))
        (set! rbp (+ rbp 16)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! rsi 8) (set! rdi 104) (set! r15 L.rp.13) (jump L.*.9)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -8))
            (set! r15 L.rp.14)
            (jump L.-.10)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty9359.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void9360.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/error9361.4))))
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
    (define L.fun/void10119.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 30)
        (jump r15)))
    (define L.fun/fixnum10117.5
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r13 rdx)
        (set! rax r14)
        (jump r15)))
    (define L.fun/fixnum10118.6
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 1640)
        (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (if (begin (set! r15 14) (true)) (set! r15 27710) (set! r15 36158))
      (set! r14 30)
      (set! r14 232)
      (set! r13 14)
      (set! r13 128)
      (set! r14 r14)
      (set! r13 22)
      (set! r13 6)
      (set! r13 30)
      (set! r13 30)
      (set! r13 30)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.11
          (begin
            (set! rdx r13)
            (set! rsi r14)
            (set! rdi r15)
            (set! r15 L.rp.11)
            (jump L.fun/fixnum10117.5)))
        (set! rbp (+ rbp 40)))
      (set! (rbp - 32) rax)
      (if (begin (set! r15 6) (false))
        (set! (rbp - 24) 760)
        (set! (rbp - 24) 424))
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.12
          (begin
            (set! rdx 22)
            (set! rsi 25390)
            (set! rdi 6)
            (set! r15 L.rp.12)
            (jump L.fun/void10119.4)))
        (set! rbp (+ rbp 40)))
      (set! (rbp - 16) rax)
      (set! r15 14)
      (set! r15 22)
      (set! r15 14)
      (set! r15 14)
      (set! (rbp - 8) 26942)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin
            (set! rsi 1496)
            (set! rdi 296)
            (set! r15 L.rp.13)
            (jump L.*.8)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin
            (set! rdx r15)
            (set! rsi (rbp - -32))
            (set! rdi (rbp - -24))
            (set! r15 L.rp.14)
            (jump L.fun/fixnum10118.6)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -16))
            (set! r15 L.rp.15)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi (rbp - 32))
      (set! r15 (rbp - 0))
      (jump L.-.10))))
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
    (define L.fun/error10153.4
      (begin (set! r15 r15) (set! rax 3134) (jump r15)))
    (define L.fun/error10154.5
      (begin (set! r15 r15) (set! rax 4926) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/error10153.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.11
          (begin
            (set! rsi 1480)
            (set! rdi 1080)
            (set! r15 L.rp.11)
            (jump L.-.7)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.12
          (begin
            (set! rsi 1336)
            (set! rdi 1896)
            (set! r15 L.rp.12)
            (jump L.*.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.13)
            (jump L.*.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error10154.5)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin
            (set! rsi 392)
            (set! rdi 1968)
            (set! r15 L.rp.15)
            (jump L.+.9)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 1208)
            (set! rdi 1408)
            (set! r15 L.rp.16)
            (jump L.*.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.17)
            (jump L.+.9)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! rax (rbp - 16))
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char11508.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void11512.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char11511.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty11507.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty11509.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error11510.9
      (begin (set! r15 r15) (set! rax 31294) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty11507.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/ascii-char11508.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty11509.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error11510.9)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/ascii-char11511.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/void11512.5))))
(check-by-interp
 '(module
    (define L.boolean?.11
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
    (define L.fun/any11902.4 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/ascii-char11900.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char11901.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char11903.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void11904.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty11899.9 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty11899.9)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/ascii-char11900.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char11901.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/any11902.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.16
          (begin (set! rdi r15) (set! r15 L.rp.16) (jump L.boolean?.11)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char11903.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/void11904.8))))
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
    (define L.fun/void11995.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char11994.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void11996.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char11994.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void11995.4)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void11996.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.14
          (begin
            (set! rsi 40)
            (set! rdi 2000)
            (set! r15 L.rp.14)
            (jump L.+.8)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.15
          (begin
            (set! rsi 128)
            (set! rdi 752)
            (set! r15 L.rp.15)
            (jump L.*.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.16
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.16)
            (jump L.+.8)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.17
          (begin
            (set! rsi 1888)
            (set! rdi 304)
            (set! r15 L.rp.17)
            (jump L.+.8)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi 368)
            (set! rdi 1440)
            (set! r15 L.rp.18)
            (jump L.-.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.19)
            (jump L.+.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.20)
            (jump L.-.10)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 1800)
            (set! rdi 1384)
            (set! r15 L.rp.21)
            (jump L.-.10)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1096)
            (set! rdi 96)
            (set! r15 L.rp.22)
            (jump L.*.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.23)
            (jump L.*.9)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 360)
            (set! rdi 1112)
            (set! r15 L.rp.24)
            (jump L.+.8)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1272)
            (set! rdi 1344)
            (set! r15 L.rp.25)
            (jump L.*.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.26)
            (jump L.+.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -40))
            (set! r15 L.rp.27)
            (jump L.*.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rsi (rbp - 8))
      (set! rdi r15)
      (set! r15 (rbp - 0))
      (jump L.+.8))))
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
    (define L.*.7
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
    (define L.fun/void11999.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char12000.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.10
          (begin
            (set! rsi 448)
            (set! rdi 1984)
            (set! r15 L.rp.10)
            (jump L.*.7)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.11
          (begin
            (set! rsi 656)
            (set! rdi 1248)
            (set! r15 L.rp.11)
            (jump L.-.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.12
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.12)
            (jump L.*.7)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.13
          (begin
            (set! rsi 1400)
            (set! rdi 456)
            (set! r15 L.rp.13)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.14
          (begin
            (set! rsi 1120)
            (set! rdi 1048)
            (set! r15 L.rp.14)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.15
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.15)
            (jump L.-.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.16
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.16)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.17
          (begin
            (set! rsi 1576)
            (set! rdi 360)
            (set! r15 L.rp.17)
            (jump L.-.8)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.18
          (begin
            (set! rsi 1448)
            (set! rdi 1768)
            (set! r15 L.rp.18)
            (jump L.*.7)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.19)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.20
          (begin
            (set! rsi 1936)
            (set! rdi 1120)
            (set! r15 L.rp.20)
            (jump L.*.7)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.21
          (begin
            (set! rsi 1048)
            (set! rdi 1416)
            (set! r15 L.rp.21)
            (jump L.*.7)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.22)
            (jump L.*.7)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.23)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/void11999.4)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.25
          (begin
            (set! rsi 1680)
            (set! rdi 680)
            (set! r15 L.rp.25)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.26
          (begin
            (set! rsi 1904)
            (set! rdi 784)
            (set! r15 L.rp.26)
            (jump L.*.7)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.27)
            (jump L.*.7)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.28
          (begin
            (set! rsi 1672)
            (set! rdi 1624)
            (set! r15 L.rp.28)
            (jump L.*.7)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.29
          (begin
            (set! rsi 1032)
            (set! rdi 2008)
            (set! r15 L.rp.29)
            (jump L.*.7)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.30)
            (jump L.-.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.31)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/ascii-char12000.5)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (set! rax r15)
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.fun/empty12004.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void12007.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty12006.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char12003.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void12005.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char12003.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty12004.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void12005.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty12006.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void12007.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rax r15)
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char12857.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void12858.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error12860.6
      (begin (set! r15 r15) (set! rax 36926) (jump r15)))
    (define L.fun/error12859.7
      (begin (set! r15 r15) (set! rax 30526) (jump r15)))
    (define L.fun/empty12861.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char12857.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/void12858.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error12859.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/error12860.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/empty12861.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rax r15)
      (jump (rbp - 0)))))
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
    (define L.fun/ascii-char14008.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error14007.5
      (begin (set! r15 r15) (set! rax 32830) (jump r15)))
    (define L.fun/void14006.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.11
          (begin
            (set! rsi 712)
            (set! rdi 1536)
            (set! r15 L.rp.11)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.12
          (begin
            (set! rsi 160)
            (set! rdi 1672)
            (set! r15 L.rp.12)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.13
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.13)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.14
          (begin
            (set! rsi 1824)
            (set! rdi 240)
            (set! r15 L.rp.14)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.15
          (begin
            (set! rsi 1720)
            (set! rdi 1440)
            (set! r15 L.rp.15)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.16
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.16)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.17)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void14006.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin
            (set! rsi 592)
            (set! rdi 280)
            (set! r15 L.rp.19)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin
            (set! rsi 536)
            (set! rdi 440)
            (set! r15 L.rp.20)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.21)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 744)
            (set! rdi 400)
            (set! r15 L.rp.22)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi 1080)
            (set! rdi 1592)
            (set! r15 L.rp.23)
            (jump L.-.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.24)
            (jump L.+.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.25)
            (jump L.*.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/error14007.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin (set! r15 L.rp.27) (jump L.fun/ascii-char14008.4)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rsi (rbp - 24))
      (set! rdi (rbp - 24))
      (set! r15 (rbp - 0))
      (jump L.*.8))))
(check-by-interp
 '(module
    (define L.fun/void15239.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char15242.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error15237.6
      (begin (set! r15 r15) (set! rax 11070) (jump r15)))
    (define L.fun/error15240.7
      (begin (set! r15 r15) (set! rax 4158) (jump r15)))
    (define L.fun/error15238.8
      (begin (set! r15 r15) (set! rax 57406) (jump r15)))
    (define L.fun/empty15241.9 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/error15237.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error15238.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void15239.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error15240.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty15241.9)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/ascii-char15242.5))))
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
    (define L.fun/void15268.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void15269.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty15270.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void15267.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void15267.7)))
        (set! rbp (+ rbp 40)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void15268.4)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void15269.5)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty15270.6)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi 1256)
            (set! rdi 880)
            (set! r15 L.rp.16)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi 1568)
            (set! rdi 1136)
            (set! r15 L.rp.17)
            (jump L.*.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -32))
            (set! r15 L.rp.18)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi 1176)
            (set! rdi 280)
            (set! r15 L.rp.19)
            (jump L.-.11)))
        (set! rbp (+ rbp 40)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin
            (set! rsi 1232)
            (set! rdi 1208)
            (set! r15 L.rp.20)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -32))
            (set! r15 L.rp.21)
            (jump L.-.11)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.22)
            (jump L.*.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (set! rax (rbp - 24))
      (jump (rbp - 0)))))
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
    (define L.ascii-char?.9
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
    (define L.fun/ascii-char15482.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void15483.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any15480.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void15481.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/any15480.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! rdi r15) (set! r15 L.rp.14) (jump L.ascii-char?.9)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/void15481.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/ascii-char15482.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 1976)
            (set! rdi 1136)
            (set! r15 L.rp.17)
            (jump L.+.10)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 1296)
            (set! rdi 96)
            (set! r15 L.rp.18)
            (jump L.+.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.19)
            (jump L.+.10)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi 1192)
            (set! rdi 680)
            (set! r15 L.rp.20)
            (jump L.*.11)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi 632)
            (set! rdi 608)
            (set! r15 L.rp.21)
            (jump L.+.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.22)
            (jump L.-.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -16))
            (set! r15 L.rp.23)
            (jump L.+.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/void15483.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! rax r15)
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.vector?.12
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
    (define L.fun/any17793.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error17796.5
      (begin (set! r15 r15) (set! rax 19518) (jump r15)))
    (define L.fun/any17795.6
      (begin (set! r15 r15) (set! rax 46910) (jump r15)))
    (define L.fun/empty17794.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/any17793.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! rdi r15) (set! r15 L.rp.14) (jump L.empty?.9)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty17794.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 1936)
            (set! rdi 1952)
            (set! r15 L.rp.16)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 1120)
            (set! rdi 16)
            (set! r15 L.rp.17)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.18)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1520)
            (set! rdi 1544)
            (set! r15 L.rp.19)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi 1568)
            (set! rdi 1768)
            (set! r15 L.rp.20)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -16))
            (set! r15 L.rp.21)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.22)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/any17795.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.24
          (begin (set! rdi r15) (set! r15 L.rp.24) (jump L.vector?.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/error17796.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! rax r15)
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.boolean?.13
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
    (define L.fixnum?.10
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
    (define L.fun/any20781.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error20783.5
      (begin (set! r15 r15) (set! rax 45374) (jump r15)))
    (define L.fun/empty20785.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error20782.7
      (begin (set! r15 r15) (set! rax 42046) (jump r15)))
    (define L.fun/any20784.8 (begin (set! r15 r15) (set! rax 14) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/any20781.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! rdi r15) (set! r15 L.rp.15) (jump L.fixnum?.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 1976)
            (set! rdi 1808)
            (set! r15 L.rp.16)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi 1104)
            (set! rdi 1992)
            (set! r15 L.rp.17)
            (jump L.*.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.18)
            (jump L.*.12)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 392)
            (set! rdi 1536)
            (set! r15 L.rp.19)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi 1576)
            (set! rdi 552)
            (set! r15 L.rp.20)
            (jump L.*.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.21)
            (jump L.*.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -16))
            (set! r15 L.rp.22)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error20782.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/error20783.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/any20784.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.26
          (begin (set! rdi r15) (set! r15 L.rp.26) (jump L.boolean?.13)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/empty20785.6))))
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
    (define L.fun/ascii-char22127.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error22124.5
      (begin (set! r15 r15) (set! rax 41022) (jump r15)))
    (define L.fun/error22126.6
      (begin (set! r15 r15) (set! rax 2622) (jump r15)))
    (define L.fun/void22125.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/error22124.5)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.12
          (begin
            (set! rsi 184)
            (set! rdi 528)
            (set! r15 L.rp.12)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin
            (set! rsi 152)
            (set! rdi 1232)
            (set! r15 L.rp.13)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -32))
            (set! r15 L.rp.14)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin
            (set! rsi 640)
            (set! rdi 448)
            (set! r15 L.rp.15)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi 232)
            (set! rdi 744)
            (set! r15 L.rp.16)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.17)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -32))
            (set! r15 L.rp.18)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void22125.7)))
        (set! rbp (+ rbp 40)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error22126.6)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char22127.4)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.ascii-char?.11
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
    (define L.fun/any22156.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char22153.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char22152.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void22154.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any22155.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/ascii-char22152.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/ascii-char22153.5)))
        (set! rbp (+ rbp 16)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void22154.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/any22155.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.16
          (begin (set! rdi r15) (set! r15 L.rp.16) (jump L.void?.10)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/any22156.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! rdi r15) (set! r15 L.rp.18) (jump L.ascii-char?.11)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
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
    (define L.fun/error22341.4
      (begin (set! r15 r15) (set! rax 39998) (jump r15)))
    (define L.fun/void22343.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty22340.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty22342.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void22344.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty22340.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error22341.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty22342.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/void22343.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void22344.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 1696)
            (set! rdi 1896)
            (set! r15 L.rp.18)
            (jump L.+.10)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1152)
            (set! rdi 544)
            (set! r15 L.rp.19)
            (jump L.+.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.20)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi 384)
            (set! rdi 1576)
            (set! r15 L.rp.21)
            (jump L.*.12)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi 1816)
            (set! rdi 1272)
            (set! r15 L.rp.22)
            (jump L.*.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -16))
            (set! r15 L.rp.23)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi (rbp - 8))
      (set! r15 (rbp - 0))
      (jump L.+.10))))
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
    (define L.fun/ascii-char22583.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any22584.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/any22585.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty22581.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char22582.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/empty22581.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin
            (set! rsi 368)
            (set! rdi 800)
            (set! r15 L.rp.15)
            (jump L.+.10)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 176)
            (set! rdi 1096)
            (set! r15 L.rp.16)
            (jump L.+.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.17)
            (jump L.*.11)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 1328)
            (set! rdi 1480)
            (set! r15 L.rp.18)
            (jump L.-.12)))
        (set! rbp (+ rbp 32)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 792)
            (set! rdi 1552)
            (set! r15 L.rp.19)
            (jump L.-.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -16))
            (set! r15 L.rp.20)
            (jump L.-.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -24))
            (set! r15 L.rp.21)
            (jump L.*.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char22582.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char22583.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/any22584.5)))
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
          (begin (set! r15 L.rp.26) (jump L.fun/any22585.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! rdi r15)
      (set! r15 (rbp - 0))
      (jump L.empty?.13))))
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
    (define L.fun/void22702.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error22701.5
      (begin (set! r15 r15) (set! rax 32062) (jump r15)))
    (define L.fun/any22703.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error22701.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void22702.4)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/any22703.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.15
          (begin (set! rdi r15) (set! r15 L.rp.15) (jump L.empty?.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.16
          (begin
            (set! rsi 1776)
            (set! rdi 392)
            (set! r15 L.rp.16)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.17
          (begin
            (set! rsi 1216)
            (set! rdi 1080)
            (set! r15 L.rp.17)
            (jump L.*.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.18)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin
            (set! rsi 1112)
            (set! rdi 232)
            (set! r15 L.rp.19)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin
            (set! rsi 1680)
            (set! rdi 1536)
            (set! r15 L.rp.20)
            (jump L.-.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.21)
            (jump L.*.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -40))
            (set! r15 L.rp.22)
            (jump L.*.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi 1376)
            (set! rdi 336)
            (set! r15 L.rp.23)
            (jump L.*.10)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 200)
            (set! rdi 528)
            (set! r15 L.rp.24)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.25)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 584)
            (set! rdi 128)
            (set! r15 L.rp.26)
            (jump L.+.9)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 176)
            (set! rdi 648)
            (set! r15 L.rp.27)
            (jump L.-.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -40))
            (set! r15 L.rp.28)
            (jump L.*.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.29)
            (jump L.*.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
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
    (define L.fun/ascii-char23153.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error23159.5
      (begin (set! r15 r15) (set! rax 44862) (jump r15)))
    (define L.fun/ascii-char23157.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void23154.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void23155.10)))
    (define L.fun/error23151.8
      (begin (set! r15 r15) (set! rax 22846) (jump r15)))
    (define L.fun/ascii-char23156.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char23157.6)))
    (define L.fun/void23155.10 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error23150.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error23151.8)))
    (define L.fun/error23158.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error23159.5)))
    (define L.fun/ascii-char23152.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char23153.4)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error23150.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char23152.13)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void23154.7)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 528)
            (set! rdi 1552)
            (set! r15 L.rp.21)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1856)
            (set! rdi 2008)
            (set! r15 L.rp.22)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.23)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 920)
            (set! rdi 864)
            (set! r15 L.rp.24)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1752)
            (set! rdi 184)
            (set! r15 L.rp.25)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.26)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.27)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 584)
            (set! rdi 1104)
            (set! r15 L.rp.28)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 1432)
            (set! rdi 16)
            (set! r15 L.rp.29)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.30)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi 1120)
            (set! rdi 736)
            (set! r15 L.rp.31)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 1008)
            (set! rdi 1952)
            (set! r15 L.rp.32)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.33)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -40))
            (set! r15 L.rp.34)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.35)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/ascii-char23156.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/error23158.12)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rax r15)
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.empty?.18
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
    (define L.ascii-char?.17
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
    (define L.fun/empty24557.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/any24558.5 (begin (set! r15 r15) (set! rax 14) (jump r15)))
    (define L.fun/error24555.6
      (begin (set! r15 r15) (set! rax 56894) (jump r15)))
    (define L.fun/ascii-char24562.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char24563.13)))
    (define L.fun/empty24560.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty24561.9)))
    (define L.fun/empty24561.9 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty24556.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty24557.4)))
    (define L.fun/any24559.11 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error24552.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error24553.14)))
    (define L.fun/ascii-char24563.13
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error24553.14
      (begin (set! r15 r15) (set! rax 52030) (jump r15)))
    (define L.fun/error24554.15
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error24555.6)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error24552.12)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error24554.15)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty24556.10)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/any24558.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! rdi r15) (set! r15 L.rp.23) (jump L.ascii-char?.17)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/any24559.11)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.25
          (begin (set! rdi r15) (set! r15 L.rp.25) (jump L.empty?.18)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/empty24560.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/ascii-char24562.7))))
(check-by-interp
 '(module
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
    (define L.fun/ascii-char29402.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty29399.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty29400.10)))
    (define L.fun/ascii-char29401.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char29402.4)))
    (define L.fun/empty29404.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char29406.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char29405.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char29406.8)))
    (define L.fun/empty29400.10
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty29403.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty29404.7)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/empty29399.5)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char29401.6)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/empty29403.11)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.19
          (begin
            (set! rsi 1096)
            (set! rdi 1888)
            (set! r15 L.rp.19)
            (jump L.+.13)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.20
          (begin
            (set! rsi 216)
            (set! rdi 1056)
            (set! r15 L.rp.20)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -136))
            (set! r15 L.rp.21)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.22
          (begin
            (set! rsi 184)
            (set! rdi 888)
            (set! r15 L.rp.22)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.23
          (begin (set! rsi 960) (set! rdi 0) (set! r15 L.rp.23) (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.24)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -136))
            (set! r15 L.rp.25)
            (jump L.+.13)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.26
          (begin
            (set! rsi 856)
            (set! rdi 1976)
            (set! r15 L.rp.26)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.27
          (begin
            (set! rsi 1960)
            (set! rdi 1616)
            (set! r15 L.rp.27)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.28)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.29
          (begin
            (set! rsi 392)
            (set! rdi 1592)
            (set! r15 L.rp.29)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.30
          (begin
            (set! rsi 416)
            (set! rdi 1152)
            (set! r15 L.rp.30)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.31)
            (jump L.+.13)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.32)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -136))
            (set! r15 L.rp.33)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.34
          (begin
            (set! rsi 784)
            (set! rdi 1160)
            (set! r15 L.rp.34)
            (jump L.+.13)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.35
          (begin
            (set! rsi 288)
            (set! rdi 400)
            (set! r15 L.rp.35)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.36)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.37
          (begin
            (set! rsi 360)
            (set! rdi 640)
            (set! r15 L.rp.37)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.38
          (begin
            (set! rsi 1856)
            (set! rdi 912)
            (set! r15 L.rp.38)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.39)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.40)
            (jump L.+.13)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 32) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.41
          (begin
            (set! rsi 1936)
            (set! rdi 360)
            (set! r15 L.rp.41)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.42
          (begin
            (set! rsi 296)
            (set! rdi 512)
            (set! r15 L.rp.42)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.43)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.44
          (begin
            (set! rsi 704)
            (set! rdi 120)
            (set! r15 L.rp.44)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.45
          (begin
            (set! rsi 936)
            (set! rdi 328)
            (set! r15 L.rp.45)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.46)
            (jump L.+.13)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.47)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.48
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.48)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/ascii-char29405.9)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.50
          (begin
            (set! rsi (rbp - -136))
            (set! rdi (rbp - -128))
            (set! r15 L.rp.50)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.51
          (begin
            (set! rsi (rbp - -136))
            (set! rdi r15)
            (set! r15 L.rp.51)
            (jump L.+.13)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.52
          (begin
            (set! rsi (rbp - -136))
            (set! rdi r15)
            (set! r15 L.rp.52)
            (jump L.*.15)))
        (set! rbp (+ rbp 144)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.53
          (begin
            (set! rsi (rbp - -128))
            (set! rdi 344)
            (set! r15 L.rp.53)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.54
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.54)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 144))
        (return-point L.rp.55
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.55)
            (jump L.-.14)))
        (set! rbp (+ rbp 144)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi (rbp - 8))
      (set! r15 (rbp - 0))
      (jump L.*.15))))
(check-by-interp
 '(module
    (define L.empty?.17
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
    (define L.fun/void31691.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void31695.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void31696.11)))
    (define L.fun/any31694.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty31692.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty31693.9)))
    (define L.fun/void31690.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void31691.4)))
    (define L.fun/empty31693.9 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty31688.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty31689.12)))
    (define L.fun/void31696.11 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty31689.12
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/empty31688.10)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 32) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin
            (set! rsi 624)
            (set! rdi 272)
            (set! r15 L.rp.19)
            (jump L.-.14)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin
            (set! rsi 920)
            (set! rdi 264)
            (set! r15 L.rp.20)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.21)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 24)
            (set! rdi 904)
            (set! r15 L.rp.22)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi 1768)
            (set! rdi 1856)
            (set! r15 L.rp.23)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.24)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.25)
            (jump L.-.14)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 1680)
            (set! rdi 1264)
            (set! r15 L.rp.26)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi 104)
            (set! rdi 704)
            (set! r15 L.rp.27)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.28)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 752)
            (set! rdi 1456)
            (set! r15 L.rp.29)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi 2024)
            (set! rdi 640)
            (set! r15 L.rp.30)
            (jump L.-.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.31)
            (jump L.-.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.32)
            (jump L.-.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.33)
            (jump L.-.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/void31690.8)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/empty31692.7)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/any31694.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! rdi r15) (set! r15 L.rp.37) (jump L.empty?.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.38
          (begin (set! r15 L.rp.38) (jump L.fun/void31695.5)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax (rbp - 32))
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.fun/error41241.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error41242.12)))
    (define L.fun/void41237.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void41238.13)))
    (define L.fun/error41233.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error41234.9)))
    (define L.fun/void41232.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error41236.8
      (begin (set! r15 r15) (set! rax 574) (jump r15)))
    (define L.fun/error41234.9
      (begin (set! r15 r15) (set! rax 8510) (jump r15)))
    (define L.fun/ascii-char41240.10
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void41231.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void41232.7)))
    (define L.fun/error41242.12
      (begin (set! r15 r15) (set! rax 28222) (jump r15)))
    (define L.fun/void41238.13 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty41244.14
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error41235.15
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error41236.8)))
    (define L.fun/empty41243.16
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty41244.14)))
    (define L.fun/ascii-char41239.17
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char41240.10)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void41231.11)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error41233.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error41235.15)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/void41237.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char41239.17)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/error41241.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/empty41243.16))))
(check-by-interp
 '(module
    (define L.void?.17
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
    (define L.fixnum?.16
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
    (define L.fun/void44609.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void44610.9)))
    (define L.fun/error44607.5
      (begin (set! r15 r15) (set! rax 64830) (jump r15)))
    (define L.fun/any44605.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error44606.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error44607.5)))
    (define L.fun/any44608.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void44610.9 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char44603.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char44604.11)))
    (define L.fun/ascii-char44604.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.18
          (begin
            (set! rsi 824)
            (set! rdi 1640)
            (set! r15 L.rp.18)
            (jump L.-.13)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.19
          (begin
            (set! rsi 16)
            (set! rdi 1256)
            (set! r15 L.rp.19)
            (jump L.*.14)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.20)
            (jump L.-.13)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin
            (set! rsi 1552)
            (set! rdi 768)
            (set! r15 L.rp.21)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin
            (set! rsi 1336)
            (set! rdi 1352)
            (set! r15 L.rp.22)
            (jump L.*.14)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.23)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.24)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1032)
            (set! rdi 1408)
            (set! r15 L.rp.25)
            (jump L.*.14)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 160)
            (set! rdi 944)
            (set! r15 L.rp.26)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.27)
            (jump L.*.14)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 736)
            (set! rdi 1280)
            (set! r15 L.rp.28)
            (jump L.*.14)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 848)
            (set! rdi 648)
            (set! r15 L.rp.29)
            (jump L.*.14)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.30)
            (jump L.-.13)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.31)
            (jump L.*.14)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -40))
            (set! r15 L.rp.32)
            (jump L.+.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/ascii-char44603.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/any44605.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin (set! rdi r15) (set! r15 L.rp.35) (jump L.fixnum?.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/error44606.7)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/any44608.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin (set! rdi r15) (set! r15 L.rp.38) (jump L.void?.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin (set! r15 L.rp.39) (jump L.fun/void44609.4)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rax r15)
      (jump (rbp - 0)))))
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
    (define L.fun/error47015.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error47016.10)))
    (define L.fun/empty47018.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void47024.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void47023.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void47024.6)))
    (define L.fun/empty47020.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty47017.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty47018.5)))
    (define L.fun/error47016.10
      (begin (set! r15 r15) (set! rax 30270) (jump r15)))
    (define L.fun/ascii-char47022.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char47021.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char47022.11)))
    (define L.fun/empty47019.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty47020.8)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error47015.4)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/empty47017.9)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty47019.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char47021.12)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.22
          (begin
            (set! rsi 1632)
            (set! rdi 1032)
            (set! r15 L.rp.22)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.23
          (begin
            (set! rsi 264)
            (set! rdi 48)
            (set! r15 L.rp.23)
            (jump L.-.16)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.24)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.25
          (begin
            (set! rsi 1320)
            (set! rdi 664)
            (set! r15 L.rp.25)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.26
          (begin
            (set! rsi 1736)
            (set! rdi 1672)
            (set! r15 L.rp.26)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.27)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -104))
            (set! r15 L.rp.28)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.29
          (begin
            (set! rsi 704)
            (set! rdi 1344)
            (set! r15 L.rp.29)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.30
          (begin
            (set! rsi 1992)
            (set! rdi 1584)
            (set! r15 L.rp.30)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.31)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.32
          (begin
            (set! rsi 1016)
            (set! rdi 1248)
            (set! r15 L.rp.32)
            (jump L.-.16)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.33
          (begin
            (set! rsi 1552)
            (set! rdi 656)
            (set! r15 L.rp.33)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -104))
            (set! r15 L.rp.34)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.35)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -96))
            (set! r15 L.rp.36)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.37
          (begin
            (set! rsi 592)
            (set! rdi 1864)
            (set! r15 L.rp.37)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.38
          (begin
            (set! rsi 2016)
            (set! rdi 392)
            (set! r15 L.rp.38)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.39)
            (jump L.-.16)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.40
          (begin
            (set! rsi 496)
            (set! rdi 1408)
            (set! r15 L.rp.40)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.41
          (begin
            (set! rsi 1344)
            (set! rdi 96)
            (set! r15 L.rp.41)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.42
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -104))
            (set! r15 L.rp.42)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.43)
            (jump L.-.16)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.44
          (begin
            (set! rsi 464)
            (set! rdi 1096)
            (set! r15 L.rp.44)
            (jump L.-.16)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.45
          (begin
            (set! rsi 1896)
            (set! rdi 1792)
            (set! r15 L.rp.45)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -104))
            (set! r15 L.rp.46)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.47
          (begin
            (set! rsi 160)
            (set! rdi 480)
            (set! r15 L.rp.47)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.48
          (begin
            (set! rsi 600)
            (set! rdi 496)
            (set! r15 L.rp.48)
            (jump L.-.16)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.49
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -104))
            (set! r15 L.rp.49)
            (jump L.+.17)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.50
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -96))
            (set! r15 L.rp.50)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.51
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.51)
            (jump L.*.15)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/void47023.7))))
(check-by-interp
 '(module
    (define L.void?.15
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
    (define L.fun/error48429.4
      (begin (set! r15 r15) (set! rax 31550) (jump r15)))
    (define L.fun/void48432.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void48433.10)))
    (define L.fun/empty48430.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty48431.7)))
    (define L.fun/empty48431.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/any48434.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error48428.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error48429.4)))
    (define L.fun/void48433.10 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin
            (set! rsi 2016)
            (set! rdi 1920)
            (set! r15 L.rp.16)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin
            (set! rsi 1296)
            (set! rdi 1576)
            (set! r15 L.rp.17)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.18)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin
            (set! rsi 1384)
            (set! rdi 1344)
            (set! r15 L.rp.19)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi 376)
            (set! rdi 1360)
            (set! r15 L.rp.20)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.21)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.22)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi 1448)
            (set! rdi 8)
            (set! r15 L.rp.23)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi 1976)
            (set! rdi 1912)
            (set! r15 L.rp.24)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.25)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi 1176)
            (set! rdi 1376)
            (set! r15 L.rp.26)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi 392)
            (set! rdi 64)
            (set! r15 L.rp.27)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.28)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.29)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -104))
            (set! r15 L.rp.30)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 32) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin
            (set! rsi 1584)
            (set! rdi 520)
            (set! r15 L.rp.31)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin
            (set! rsi 1912)
            (set! rdi 1424)
            (set! r15 L.rp.32)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.33)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi 56)
            (set! rdi 1416)
            (set! r15 L.rp.34)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin
            (set! rsi 496)
            (set! rdi 1928)
            (set! r15 L.rp.35)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.36)
            (jump L.+.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.37)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi 1336)
            (set! rdi 1672)
            (set! r15 L.rp.38)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi 1496)
            (set! rdi 432)
            (set! r15 L.rp.39)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.40)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi 2008)
            (set! rdi 1000)
            (set! r15 L.rp.41)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi 1552)
            (set! rdi 1152)
            (set! r15 L.rp.42)
            (jump L.*.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.43)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -104))
            (set! r15 L.rp.44)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.45)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin (set! r15 L.rp.46) (jump L.fun/error48428.9)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin (set! r15 L.rp.47) (jump L.fun/empty48430.6)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/void48432.5)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/any48434.8)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.50
          (begin (set! rdi r15) (set! r15 L.rp.50) (jump L.void?.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (set! rax (rbp - 32))
      (jump (rbp - 0)))))
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
    (define L.fun/ascii-char52445.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void52451.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char52442.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char52443.14)))
    (define L.fun/error52440.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error52441.15)))
    (define L.fun/ascii-char52449.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char52448.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char52449.8)))
    (define L.fun/void52450.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void52451.5)))
    (define L.fun/empty52447.11
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty52446.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty52447.11)))
    (define L.fun/ascii-char52444.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char52445.4)))
    (define L.fun/ascii-char52443.14
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error52441.15
      (begin (set! r15 r15) (set! rax 62782) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error52440.7)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char52442.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char52444.13)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty52446.12)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/ascii-char52448.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1200)
            (set! rdi 1688)
            (set! r15 L.rp.25)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 1136)
            (set! rdi 936)
            (set! r15 L.rp.26)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.27)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 1344)
            (set! rdi 648)
            (set! r15 L.rp.28)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 696)
            (set! rdi 1760)
            (set! r15 L.rp.29)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.30)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.31)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 1136)
            (set! rdi 440)
            (set! r15 L.rp.32)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 1608)
            (set! rdi 1032)
            (set! r15 L.rp.33)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.34)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 8)
            (set! rdi 1032)
            (set! r15 L.rp.35)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi 1704)
            (set! rdi 0)
            (set! r15 L.rp.36)
            (jump L.-.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.37)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -40))
            (set! r15 L.rp.38)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.39)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/void52450.10))))
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
    (define L.boolean?.14
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
    (define L.fun/ascii-char59064.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char59065.9)))
    (define L.fun/ascii-char59068.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char59069.12)))
    (define L.fun/any59063.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char59070.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char59071.11)))
    (define L.fun/empty59066.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty59067.10)))
    (define L.fun/ascii-char59065.9
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty59067.10
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char59071.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char59069.12
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/any59063.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! rdi r15) (set! r15 L.rp.19) (jump L.boolean?.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin
            (set! rsi 48)
            (set! rdi 168)
            (set! r15 L.rp.20)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi 352)
            (set! rdi 1464)
            (set! r15 L.rp.21)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.22)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi 1888)
            (set! rdi 504)
            (set! r15 L.rp.23)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi 544)
            (set! rdi 368)
            (set! r15 L.rp.24)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.25)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.26)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi 1952)
            (set! rdi 1848)
            (set! r15 L.rp.27)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 1568)
            (set! rdi 1928)
            (set! r15 L.rp.28)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.29)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi 720)
            (set! rdi 504)
            (set! r15 L.rp.30)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi 8)
            (set! rdi 1264)
            (set! r15 L.rp.31)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.32)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.33)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.34)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/ascii-char59064.4)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/empty59066.8)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char59068.5)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.38
          (begin (set! r15 L.rp.38) (jump L.fun/ascii-char59070.7)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
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
    (define L.fun/empty59449.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty59450.8)))
    (define L.fun/ascii-char59447.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char59448.13)))
    (define L.fun/error59452.6
      (begin (set! r15 r15) (set! rax 6718) (jump r15)))
    (define L.fun/void59454.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty59450.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char59445.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char59446.10)))
    (define L.fun/ascii-char59446.10
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void59453.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void59454.7)))
    (define L.fun/error59451.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error59452.6)))
    (define L.fun/ascii-char59448.13
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char59445.9)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char59447.5)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty59449.4)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error59451.12)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 1688)
            (set! rdi 976)
            (set! r15 L.rp.22)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi 648)
            (set! rdi 880)
            (set! r15 L.rp.23)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.24)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 760)
            (set! rdi 2024)
            (set! r15 L.rp.25)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 248)
            (set! rdi 432)
            (set! r15 L.rp.26)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.27)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.28)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 32) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 1456)
            (set! rdi 256)
            (set! r15 L.rp.29)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi 408)
            (set! rdi 880)
            (set! r15 L.rp.30)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.31)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 640)
            (set! rdi 832)
            (set! r15 L.rp.32)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi 1232)
            (set! rdi 0)
            (set! r15 L.rp.33)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.34)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.35)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -40))
            (set! r15 L.rp.36)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/void59453.11)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
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
    (define L.boolean?.14
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
    (define L.void?.13
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
    (define L.fun/ascii-char72180.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char72181.7)))
    (define L.fun/ascii-char72175.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char72176.11)))
    (define L.fun/void72177.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void72178.8)))
    (define L.fun/ascii-char72181.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void72178.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any72179.9
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any72182.10
      (begin (set! r15 r15) (set! rax 19774) (jump r15)))
    (define L.fun/ascii-char72176.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char72175.5)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void72177.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/any72179.9)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin (set! rdi r15) (set! r15 L.rp.21) (jump L.void?.13)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char72180.4)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 32) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/any72182.10)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin (set! rdi r15) (set! r15 L.rp.24) (jump L.boolean?.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 264)
            (set! rdi 256)
            (set! r15 L.rp.25)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 1384)
            (set! rdi 968)
            (set! r15 L.rp.26)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.27)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 1272)
            (set! rdi 1672)
            (set! r15 L.rp.28)
            (jump L.*.17)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 1896)
            (set! rdi 1976)
            (set! r15 L.rp.29)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.30)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.31)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 1272)
            (set! rdi 1976)
            (set! r15 L.rp.32)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi 872)
            (set! rdi 112)
            (set! r15 L.rp.33)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.34)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi 1464)
            (set! rdi 304)
            (set! r15 L.rp.35)
            (jump L.*.17)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin
            (set! rsi 1920)
            (set! rdi 1424)
            (set! r15 L.rp.36)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.37)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.38)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.39)
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax (rbp - 32))
      (jump (rbp - 0)))))
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
    (define L.fun/empty76147.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty76148.12)))
    (define L.fun/empty76144.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char76150.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void76152.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void76145.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void76146.11)))
    (define L.fun/ascii-char76149.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char76150.6)))
    (define L.fun/empty76143.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty76144.5)))
    (define L.fun/void76146.11 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty76148.12
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void76151.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void76152.7)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.18
          (begin
            (set! rsi 1880)
            (set! rdi 1240)
            (set! r15 L.rp.18)
            (jump L.-.15)))
        (set! rbp (+ rbp 88)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.19
          (begin
            (set! rsi 864)
            (set! rdi 760)
            (set! r15 L.rp.19)
            (jump L.*.16)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -80))
            (set! r15 L.rp.20)
            (jump L.+.17)))
        (set! rbp (+ rbp 88)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.21
          (begin
            (set! rsi 1384)
            (set! rdi 224)
            (set! r15 L.rp.21)
            (jump L.+.17)))
        (set! rbp (+ rbp 88)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.22
          (begin
            (set! rsi 232)
            (set! rdi 1824)
            (set! r15 L.rp.22)
            (jump L.-.15)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -80))
            (set! r15 L.rp.23)
            (jump L.*.16)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.24)
            (jump L.-.15)))
        (set! rbp (+ rbp 88)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.25
          (begin
            (set! rsi 744)
            (set! rdi 536)
            (set! r15 L.rp.25)
            (jump L.+.17)))
        (set! rbp (+ rbp 88)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.26
          (begin
            (set! rsi 128)
            (set! rdi 1920)
            (set! r15 L.rp.26)
            (jump L.+.17)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -80))
            (set! r15 L.rp.27)
            (jump L.*.16)))
        (set! rbp (+ rbp 88)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.28
          (begin
            (set! rsi 688)
            (set! rdi 512)
            (set! r15 L.rp.28)
            (jump L.-.15)))
        (set! rbp (+ rbp 88)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.29
          (begin
            (set! rsi 1176)
            (set! rdi 408)
            (set! r15 L.rp.29)
            (jump L.+.17)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.30)
            (jump L.+.17)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -80))
            (set! r15 L.rp.31)
            (jump L.*.16)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.32)
            (jump L.-.15)))
        (set! rbp (+ rbp 88)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/empty76143.10)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/void76145.8)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/empty76147.4)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/ascii-char76149.9)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/void76151.13)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.38
          (begin
            (set! rsi (rbp - -64))
            (set! rdi (rbp - -64))
            (set! r15 L.rp.38)
            (jump L.*.16)))
        (set! rbp (+ rbp 88)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.39
          (begin
            (set! rsi (rbp - -64))
            (set! rdi (rbp - -64))
            (set! r15 L.rp.39)
            (jump L.-.15)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.40
          (begin
            (set! rsi (rbp - -64))
            (set! rdi r15)
            (set! r15 L.rp.40)
            (jump L.+.17)))
        (set! rbp (+ rbp 88)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.41
          (begin
            (set! rsi (rbp - -64))
            (set! rdi 688)
            (set! r15 L.rp.41)
            (jump L.-.15)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.42
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.42)
            (jump L.-.15)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 88))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -80))
            (set! r15 L.rp.43)
            (jump L.-.15)))
        (set! rbp (+ rbp 88)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi (rbp - 16))
      (set! r15 (rbp - 0))
      (jump L.*.16))))
(check-by-interp
 '(module
    (define L.fun/empty82623.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void82617.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error82624.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error82625.7)))
    (define L.fun/error82625.7
      (begin (set! r15 r15) (set! rax 59454) (jump r15)))
    (define L.fun/ascii-char82621.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error82619.9
      (begin (set! r15 r15) (set! rax 39998) (jump r15)))
    (define L.fun/error82618.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error82619.9)))
    (define L.fun/ascii-char82627.11
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty82622.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty82623.4)))
    (define L.fun/ascii-char82620.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char82621.8)))
    (define L.fun/ascii-char82626.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char82627.11)))
    (define L.fun/void82616.15
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void82617.5)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void82616.15)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error82618.10)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char82620.13)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty82622.12)))
        (set! rbp (+ rbp 16)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error82624.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char82626.14)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.fun/empty86209.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty86210.13)))
    (define L.fun/void86206.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char86207.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char86208.15)))
    (define L.fun/empty86211.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty86212.16)))
    (define L.fun/empty86201.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty86202.12)))
    (define L.fun/error86214.9
      (begin (set! r15 r15) (set! rax 21310) (jump r15)))
    (define L.fun/void86205.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void86206.5)))
    (define L.fun/empty86203.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty86204.14)))
    (define L.fun/empty86202.12
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty86210.13
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty86204.14
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char86208.15
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty86212.16
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error86213.17
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error86214.9)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/empty86201.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty86203.11)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void86205.10)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char86207.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty86209.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/empty86211.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/error86213.17))))
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
    (define L.empty?.16
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
    (define L.fun/any89588.4 (begin (set! r15 r15) (set! rax 1840) (jump r15)))
    (define L.fun/void89590.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void89587.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error89592.7
      (begin (set! r15 r15) (set! rax 5438) (jump r15)))
    (define L.fun/void89594.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void89595.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void89596.11)))
    (define L.fun/void89586.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void89587.6)))
    (define L.fun/void89596.11 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error89591.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error89592.7)))
    (define L.fun/void89593.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void89594.8)))
    (define L.fun/void89589.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void89590.5)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void89586.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/any89588.4)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! rdi r15) (set! r15 L.rp.22) (jump L.empty?.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void89589.14)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/error89591.12)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/void89593.13)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/void89595.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 1632)
            (set! rdi 144)
            (set! r15 L.rp.27)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 1416)
            (set! rdi 1464)
            (set! r15 L.rp.28)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.29)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi 1064)
            (set! rdi 1152)
            (set! r15 L.rp.30)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi 832)
            (set! rdi 1096)
            (set! r15 L.rp.31)
            (jump L.-.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.32)
            (jump L.-.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.33)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi 248)
            (set! rdi 688)
            (set! r15 L.rp.34)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 240)
            (set! rdi 2000)
            (set! r15 L.rp.35)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.36)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi 1040)
            (set! rdi 800)
            (set! r15 L.rp.37)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi 312)
            (set! rdi 1224)
            (set! r15 L.rp.38)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.39)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -40))
            (set! r15 L.rp.40)
            (jump L.*.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi (rbp - 8))
      (set! r15 (rbp - 0))
      (jump L.*.17))))
(check-by-interp
 '(module
    (define L.fun/ascii-char91899.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char91896.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char91897.12)))
    (define L.fun/empty91891.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty91890.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty91891.6)))
    (define L.fun/ascii-char91892.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char91893.15)))
    (define L.fun/ascii-char91898.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char91899.4)))
    (define L.fun/ascii-char91894.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char91895.14)))
    (define L.fun/error91900.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error91901.13)))
    (define L.fun/ascii-char91897.12
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error91901.13
      (begin (set! r15 r15) (set! rax 33086) (jump r15)))
    (define L.fun/ascii-char91895.14
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char91893.15
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/empty91890.7)))
        (set! rbp (+ rbp 16)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char91892.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char91894.10)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char91896.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char91898.9)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error91900.11)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
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
    (define L.fun/empty93185.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty93186.9)))
    (define L.fun/void93187.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void93188.11)))
    (define L.fun/error93189.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error93190.7)))
    (define L.fun/error93190.7
      (begin (set! r15 r15) (set! rax 9790) (jump r15)))
    (define L.fun/void93193.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void93194.12)))
    (define L.fun/empty93186.9 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error93192.10
      (begin (set! r15 r15) (set! rax 19774) (jump r15)))
    (define L.fun/void93188.11 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void93194.12 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error93191.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error93192.10)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/empty93185.4)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void93187.5)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.20
          (begin
            (set! rsi 1640)
            (set! rdi 1832)
            (set! r15 L.rp.20)
            (jump L.*.15)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.21
          (begin
            (set! rsi 208)
            (set! rdi 1376)
            (set! r15 L.rp.21)
            (jump L.-.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -88))
            (set! r15 L.rp.22)
            (jump L.+.17)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.23
          (begin
            (set! rsi 40)
            (set! rdi 816)
            (set! r15 L.rp.23)
            (jump L.-.16)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.24
          (begin
            (set! rsi 1448)
            (set! rdi 1728)
            (set! r15 L.rp.24)
            (jump L.*.15)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -88))
            (set! r15 L.rp.25)
            (jump L.+.17)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -80))
            (set! r15 L.rp.26)
            (jump L.*.15)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.27
          (begin
            (set! rsi 1096)
            (set! rdi 752)
            (set! r15 L.rp.27)
            (jump L.+.17)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.28
          (begin
            (set! rsi 1592)
            (set! rdi 592)
            (set! r15 L.rp.28)
            (jump L.-.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -88))
            (set! r15 L.rp.29)
            (jump L.-.16)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.30
          (begin
            (set! rsi 2000)
            (set! rdi 200)
            (set! r15 L.rp.30)
            (jump L.+.17)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.31
          (begin
            (set! rsi 192)
            (set! rdi 1136)
            (set! r15 L.rp.31)
            (jump L.-.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -80))
            (set! r15 L.rp.32)
            (jump L.-.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -88))
            (set! r15 L.rp.33)
            (jump L.-.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.34)
            (jump L.*.15)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/error93189.6)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/error93191.13)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/void93193.8)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.38
          (begin
            (set! rsi (rbp - -72))
            (set! rdi (rbp - -72))
            (set! r15 L.rp.38)
            (jump L.+.17)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.39
          (begin
            (set! rsi 1464)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.39)
            (jump L.*.15)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.40
          (begin
            (set! rsi 1752)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.40)
            (jump L.*.15)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.41
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -88))
            (set! r15 L.rp.41)
            (jump L.+.17)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.42
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -80))
            (set! r15 L.rp.42)
            (jump L.-.16)))
        (set! rbp (+ rbp 96)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 96))
        (return-point L.rp.43
          (begin
            (set! rsi (rbp - -72))
            (set! rdi (rbp - -72))
            (set! r15 L.rp.43)
            (jump L.-.16)))
        (set! rbp (+ rbp 96)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi (rbp - 8))
      (set! r15 (rbp - 0))
      (jump L.+.17))))
(check-by-interp
 '(module
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
    (define L.fun/ascii-char103343.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error103339.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error103340.7)))
    (define L.fun/ascii-char103337.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char103338.12)))
    (define L.fun/error103340.7
      (begin (set! r15 r15) (set! rax 41534) (jump r15)))
    (define L.fun/ascii-char103342.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char103343.4)))
    (define L.fun/empty103336.9
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/any103341.10 (begin (set! r15 r15) (set! rax 14) (jump r15)))
    (define L.fun/empty103335.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty103336.9)))
    (define L.fun/ascii-char103338.12
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/empty103335.11)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char103337.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin
            (set! rsi 168)
            (set! rdi 1880)
            (set! r15 L.rp.20)
            (jump L.*.14)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi 136)
            (set! rdi 104)
            (set! r15 L.rp.21)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.22)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi 744)
            (set! rdi 352)
            (set! r15 L.rp.23)
            (jump L.*.14)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi 1920)
            (set! rdi 456)
            (set! r15 L.rp.24)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.25)
            (jump L.*.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.26)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi 168)
            (set! rdi 1888)
            (set! r15 L.rp.27)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 64)
            (set! rdi 464)
            (set! r15 L.rp.28)
            (jump L.*.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.29)
            (jump L.*.14)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi 160)
            (set! rdi 352)
            (set! r15 L.rp.30)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi 1512)
            (set! rdi 1152)
            (set! r15 L.rp.31)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.32)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.33)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.34)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/error103339.5)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/any103341.10)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! rdi r15) (set! r15 L.rp.37) (jump L.vector?.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.38
          (begin (set! r15 L.rp.38) (jump L.fun/ascii-char103342.8)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.fixnum?.16
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
    (define L.fun/void111249.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void111250.14)))
    (define L.fun/error111259.5
      (begin (set! r15 r15) (set! rax 36670) (jump r15)))
    (define L.fun/error111258.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error111259.5)))
    (define L.fun/any111257.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char111255.8
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char111256.12)))
    (define L.fun/error111254.9
      (begin (set! r15 r15) (set! rax 58430) (jump r15)))
    (define L.fun/error111253.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error111254.9)))
    (define L.fun/ascii-char111251.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char111252.13)))
    (define L.fun/ascii-char111256.12
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char111252.13
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void111250.14
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void111249.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char111251.11)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/error111253.10)))
        (set! rbp (+ rbp 16)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char111255.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/any111257.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! rdi r15) (set! r15 L.rp.22) (jump L.fixnum?.16)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error111258.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
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
    (define L.fun/void112730.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void112731.8)))
    (define L.fun/ascii-char112724.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char112725.9)))
    (define L.fun/void112726.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void112727.13)))
    (define L.fun/empty112733.7
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void112731.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char112725.9
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void112728.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void112729.12)))
    (define L.fun/empty112732.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty112733.7)))
    (define L.fun/void112729.12
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void112727.13
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char112724.5)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void112726.6)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void112728.10)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.21
          (begin
            (set! rsi 328)
            (set! rdi 984)
            (set! r15 L.rp.21)
            (jump L.*.15)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.22
          (begin
            (set! rsi 888)
            (set! rdi 728)
            (set! r15 L.rp.22)
            (jump L.*.15)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.23)
            (jump L.-.16)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.24
          (begin
            (set! rsi 1776)
            (set! rdi 600)
            (set! r15 L.rp.24)
            (jump L.-.16)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.25
          (begin
            (set! rsi 1456)
            (set! rdi 1904)
            (set! r15 L.rp.25)
            (jump L.*.15)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.26)
            (jump L.-.16)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.27)
            (jump L.-.16)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.28
          (begin
            (set! rsi 1536)
            (set! rdi 1272)
            (set! r15 L.rp.28)
            (jump L.-.16)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.29
          (begin
            (set! rsi 912)
            (set! rdi 1056)
            (set! r15 L.rp.29)
            (jump L.*.15)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.30)
            (jump L.+.17)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.31
          (begin
            (set! rsi 1496)
            (set! rdi 1448)
            (set! r15 L.rp.31)
            (jump L.+.17)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.32
          (begin
            (set! rsi 344)
            (set! rdi 568)
            (set! r15 L.rp.32)
            (jump L.-.16)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.33)
            (jump L.-.16)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.34)
            (jump L.-.16)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.35)
            (jump L.+.17)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/void112730.4)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/empty112732.11)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.38
          (begin
            (set! rsi 1192)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.38)
            (jump L.-.16)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.39)
            (jump L.+.17)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.40
          (begin
            (set! rsi (rbp - -72))
            (set! rdi r15)
            (set! r15 L.rp.40)
            (jump L.*.15)))
        (set! rbp (+ rbp 80)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.41
          (begin
            (set! rsi 312)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.41)
            (jump L.+.17)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.42
          (begin
            (set! rsi (rbp - -72))
            (set! rdi r15)
            (set! r15 L.rp.42)
            (jump L.*.15)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -72))
            (set! r15 L.rp.43)
            (jump L.*.15)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi (rbp - 16))
      (set! r15 (rbp - 0))
      (jump L.+.17))))
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
    (define L.fun/ascii-char117132.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char117133.9)))
    (define L.fun/ascii-char117129.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char117130.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char117131.8)))
    (define L.fun/ascii-char117128.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char117129.5)))
    (define L.fun/ascii-char117131.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char117133.9
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char117128.7)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 32) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.15
          (begin
            (set! rsi 552)
            (set! rdi 176)
            (set! r15 L.rp.15)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.16
          (begin
            (set! rsi 144)
            (set! rdi 1824)
            (set! r15 L.rp.16)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -176))
            (set! r15 L.rp.17)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.18
          (begin
            (set! rsi 1264)
            (set! rdi 984)
            (set! r15 L.rp.18)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.19
          (begin
            (set! rsi 1280)
            (set! rdi 32)
            (set! r15 L.rp.19)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -168))
            (set! r15 L.rp.20)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -176))
            (set! r15 L.rp.21)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.22
          (begin
            (set! rsi 1416)
            (set! rdi 1536)
            (set! r15 L.rp.22)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.23
          (begin
            (set! rsi 616)
            (set! rdi 1072)
            (set! r15 L.rp.23)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -168))
            (set! r15 L.rp.24)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.25
          (begin
            (set! rsi 1976)
            (set! rdi 384)
            (set! r15 L.rp.25)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.26
          (begin
            (set! rsi 1288)
            (set! rdi 400)
            (set! r15 L.rp.26)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -168))
            (set! r15 L.rp.27)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -160))
            (set! r15 L.rp.28)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -176))
            (set! r15 L.rp.29)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.30
          (begin (set! r15 L.rp.30) (jump L.fun/ascii-char117130.6)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.31
          (begin
            (set! rsi 1344)
            (set! rdi 576)
            (set! r15 L.rp.31)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.32
          (begin
            (set! rsi 1816)
            (set! rdi 528)
            (set! r15 L.rp.32)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -176))
            (set! r15 L.rp.33)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.34
          (begin
            (set! rsi 864)
            (set! rdi 1160)
            (set! r15 L.rp.34)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.35
          (begin
            (set! rsi 96)
            (set! rdi 1360)
            (set! r15 L.rp.35)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -168))
            (set! r15 L.rp.36)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -176))
            (set! r15 L.rp.37)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.38
          (begin
            (set! rsi 344)
            (set! rdi 240)
            (set! r15 L.rp.38)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.39
          (begin
            (set! rsi 1080)
            (set! rdi 1928)
            (set! r15 L.rp.39)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -168))
            (set! r15 L.rp.40)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.41
          (begin
            (set! rsi 448)
            (set! rdi 808)
            (set! r15 L.rp.41)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.42
          (begin
            (set! rsi 2000)
            (set! rdi 1296)
            (set! r15 L.rp.42)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -168))
            (set! r15 L.rp.43)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.44
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -160))
            (set! r15 L.rp.44)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.45
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -176))
            (set! r15 L.rp.45)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.46
          (begin (set! r15 L.rp.46) (jump L.fun/ascii-char117132.4)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.47
          (begin
            (set! rsi 1456)
            (set! rdi 1672)
            (set! r15 L.rp.47)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.48
          (begin
            (set! rsi 480)
            (set! rdi 1696)
            (set! r15 L.rp.48)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.49
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -176))
            (set! r15 L.rp.49)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.50
          (begin
            (set! rsi 616)
            (set! rdi 320)
            (set! r15 L.rp.50)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.51
          (begin
            (set! rsi 1056)
            (set! rdi 1016)
            (set! r15 L.rp.51)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.52
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -168))
            (set! r15 L.rp.52)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.53
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -176))
            (set! r15 L.rp.53)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.54
          (begin
            (set! rsi 1176)
            (set! rdi 832)
            (set! r15 L.rp.54)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.55
          (begin
            (set! rsi 328)
            (set! rdi 248)
            (set! r15 L.rp.55)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.56
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -168))
            (set! r15 L.rp.56)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.57
          (begin
            (set! rsi 1952)
            (set! rdi 920)
            (set! r15 L.rp.57)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.58
          (begin
            (set! rsi 1000)
            (set! rdi 320)
            (set! r15 L.rp.58)
            (jump L.*.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.59
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -168))
            (set! r15 L.rp.59)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.60
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -160))
            (set! r15 L.rp.60)
            (jump L.-.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.61
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -176))
            (set! r15 L.rp.61)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (set! rax (rbp - 32))
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.empty?.17
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
    (define L.+.14
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
    (define L.fun/void117486.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any117487.5 (begin (set! r15 r15) (set! rax 6) (jump r15)))
    (define L.fun/void117490.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void117491.11)))
    (define L.fun/error117483.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error117484.12)))
    (define L.fun/empty117489.8
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void117485.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void117486.4)))
    (define L.fun/empty117488.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty117489.8)))
    (define L.fun/void117491.11
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error117484.12
      (begin (set! r15 r15) (set! rax 5182) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin
            (set! rsi 1440)
            (set! rdi 984)
            (set! r15 L.rp.18)
            (jump L.+.14)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin
            (set! rsi 592)
            (set! rdi 608)
            (set! r15 L.rp.19)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.20)
            (jump L.+.14)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi 1672)
            (set! rdi 256)
            (set! r15 L.rp.21)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 648)
            (set! rdi 1728)
            (set! r15 L.rp.22)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.23)
            (jump L.+.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.24)
            (jump L.+.14)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 1552)
            (set! rdi 320)
            (set! r15 L.rp.25)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 1760)
            (set! rdi 1760)
            (set! r15 L.rp.26)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.27)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 1384)
            (set! rdi 1272)
            (set! r15 L.rp.28)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 1192)
            (set! rdi 1856)
            (set! r15 L.rp.29)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.30)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -64))
            (set! r15 L.rp.31)
            (jump L.-.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.32)
            (jump L.+.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/error117483.7)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/void117485.9)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/any117487.5)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! rdi r15) (set! r15 L.rp.36) (jump L.empty?.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/empty117488.10)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.38
          (begin (set! r15 L.rp.38) (jump L.fun/void117490.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
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
    (define L.fun/void118048.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void118049.8)))
    (define L.fun/ascii-char118051.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void118045.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error118053.7
      (begin (set! r15 r15) (set! rax 47678) (jump r15)))
    (define L.fun/void118049.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void118046.9
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void118047.11)))
    (define L.fun/void118044.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void118045.6)))
    (define L.fun/void118047.11
      (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error118052.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error118053.7)))
    (define L.fun/ascii-char118050.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char118051.5)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void118044.10)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void118046.9)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void118048.4)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char118050.13)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error118052.12)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi 1240)
            (set! rdi 528)
            (set! r15 L.rp.23)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.24
          (begin
            (set! rsi 1304)
            (set! rdi 1216)
            (set! r15 L.rp.24)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.25)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 936)
            (set! rdi 1552)
            (set! r15 L.rp.26)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi 760)
            (set! rdi 1888)
            (set! r15 L.rp.27)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.28)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.29)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi 776)
            (set! rdi 384)
            (set! r15 L.rp.30)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi 800)
            (set! rdi 1824)
            (set! r15 L.rp.31)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.32)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 32) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi 1200)
            (set! rdi 976)
            (set! r15 L.rp.33)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin
            (set! rsi 1864)
            (set! rdi 1504)
            (set! r15 L.rp.34)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -48))
            (set! r15 L.rp.35)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -40))
            (set! r15 L.rp.36)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -56))
            (set! r15 L.rp.37)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax (rbp - 8))
      (jump (rbp - 0)))))
(check-by-interp
 '(module
    (define L.pair?.18
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
    (define L.fun/void123827.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void123828.8)))
    (define L.fun/empty123825.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty123826.10)))
    (define L.fun/empty123831.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty123832.14)))
    (define L.fun/error123823.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error123824.15)))
    (define L.fun/void123828.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/any123822.9
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty123826.10
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error123830.11
      (begin (set! r15 r15) (set! rax 42814) (jump r15)))
    (define L.fun/error123829.12
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error123830.11)))
    (define L.fun/ascii-char123833.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char123834.16)))
    (define L.fun/empty123832.14
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error123824.15
      (begin (set! r15 r15) (set! rax 32062) (jump r15)))
    (define L.fun/ascii-char123834.16
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/any123822.9)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! rdi r15) (set! r15 L.rp.20) (jump L.pair?.18)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error123823.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty123825.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void123827.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/error123829.12)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/empty123831.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/ascii-char123833.13))))
(check-by-interp
 '(module
    (define L.error?.15
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
    (define L.boolean?.14
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
    (define L.void?.13
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
    (define L.fun/empty126710.4
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty126709.5
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty126710.4)))
    (define L.fun/any126713.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any126711.7
      (begin (set! r15 r15) (set! rax 1184) (jump r15)))
    (define L.fun/any126712.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.16
          (begin
            (set! rsi 1152)
            (set! rdi 464)
            (set! r15 L.rp.16)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.17
          (begin
            (set! rsi 56)
            (set! rdi 1752)
            (set! r15 L.rp.17)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.18)
            (jump L.+.11)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.19
          (begin
            (set! rsi 904)
            (set! rdi 992)
            (set! r15 L.rp.19)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.20
          (begin
            (set! rsi 488)
            (set! rdi 128)
            (set! r15 L.rp.20)
            (jump L.+.11)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.21)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.22)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.23
          (begin
            (set! rsi 856)
            (set! rdi 1744)
            (set! r15 L.rp.23)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.24
          (begin
            (set! rsi 736)
            (set! rdi 648)
            (set! r15 L.rp.24)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.25)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.26
          (begin
            (set! rsi 712)
            (set! rdi 104)
            (set! r15 L.rp.26)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.27
          (begin
            (set! rsi 1896)
            (set! rdi 264)
            (set! r15 L.rp.27)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.28)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.29)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.30)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 32) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.31
          (begin (set! r15 L.rp.31) (jump L.fun/empty126709.5)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/any126711.7)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.33
          (begin (set! rdi r15) (set! r15 L.rp.33) (jump L.void?.13)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.34
          (begin
            (set! rsi 904)
            (set! rdi 72)
            (set! r15 L.rp.34)
            (jump L.+.11)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.35
          (begin
            (set! rsi 448)
            (set! rdi 816)
            (set! r15 L.rp.35)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.36)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.37
          (begin
            (set! rsi 848)
            (set! rdi 136)
            (set! r15 L.rp.37)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.38
          (begin
            (set! rsi 1872)
            (set! rdi 1088)
            (set! r15 L.rp.38)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.39)
            (jump L.+.11)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.40)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 24) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.41
          (begin
            (set! rsi 976)
            (set! rdi 376)
            (set! r15 L.rp.41)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.42
          (begin
            (set! rsi 304)
            (set! rdi 1784)
            (set! r15 L.rp.42)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.43)
            (jump L.+.11)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.44
          (begin
            (set! rsi 368)
            (set! rdi 1416)
            (set! r15 L.rp.44)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 16) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.45
          (begin
            (set! rsi 1720)
            (set! rdi 1784)
            (set! r15 L.rp.45)
            (jump L.+.11)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -120))
            (set! r15 L.rp.46)
            (jump L.-.10)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -128))
            (set! r15 L.rp.47)
            (jump L.+.11)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.48
          (begin
            (set! rsi r15)
            (set! rdi (rbp - -112))
            (set! r15 L.rp.48)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! (rbp - 8) rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/any126712.8)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.50
          (begin (set! rdi r15) (set! r15 L.rp.50) (jump L.boolean?.14)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.51
          (begin (set! r15 L.rp.51) (jump L.fun/any126713.6)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.52
          (begin (set! rdi r15) (set! r15 L.rp.52) (jump L.error?.15)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.53
          (begin
            (set! rsi (rbp - -128))
            (set! rdi (rbp - -104))
            (set! r15 L.rp.53)
            (jump L.*.12)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 136))
        (return-point L.rp.54
          (begin
            (set! rsi (rbp - -104))
            (set! rdi r15)
            (set! r15 L.rp.54)
            (jump L.+.11)))
        (set! rbp (+ rbp 136)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi (rbp - 8))
      (set! r15 (rbp - 0))
      (jump L.-.10))))
(check-by-interp
 '(module
    (define L.vector?.18
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
    (define L.fun/error129841.4
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error129842.9)))
    (define L.fun/ascii-char129834.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char129832.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty129840.7
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty129836.8
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error129842.9
      (begin (set! r15 r15) (set! rax 41278) (jump r15)))
    (define L.fun/ascii-char129831.10
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char129832.6)))
    (define L.fun/empty129835.11
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty129836.8)))
    (define L.fun/any129830.12 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char129833.13
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char129834.5)))
    (define L.fun/empty129837.14
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty129838.15)))
    (define L.fun/empty129838.15
      (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty129839.16
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/empty129840.7)))
    (begin
      (set! (rbp - 0) r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/any129830.12)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.20
          (begin (set! rdi r15) (set! r15 L.rp.20) (jump L.vector?.18)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char129831.10)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/ascii-char129833.13)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/empty129835.11)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/empty129837.14)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/empty129839.16)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 (rbp - 0))
      (jump L.fun/error129841.4))))
