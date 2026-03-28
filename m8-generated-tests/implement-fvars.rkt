#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v8
         (only-in "../implement-fvars.rkt"))
(define (fail-if-invalid p)
  (when (not (nested-asm-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "nested-asm-lang-v8"
      " program")))
  p)
(define (check-by-interp p)
  (interp-nested-asm-lang-fvars-v8 p)
  (interp-nested-asm-lang-v8 (fail-if-invalid (implement-fvars p))))

(check-by-interp '(module (begin (set! r15 r15) (set! rax 24894) (jump r15))))
(check-by-interp '(module (begin (set! r15 r15) (set! rax 22) (jump r15))))
(check-by-interp
 '(module
    (define L.fun/void8390.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin (set! r15 r15) (set! r15 r15) (jump L.fun/void8390.4))))
(check-by-interp
 '(module (begin (set! r15 r15) (set! r14 22) (set! rax 21310) (jump r15))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (set! r14 30)
      (set! r14 25390)
      (set! rax 576)
      (jump r15))))
(check-by-interp
 '(module
    (define L.fun/void8397.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 30) (jump r15)))
    (begin
      (set! r15 r15)
      (set! r14 25390)
      (set! r14 6)
      (set! r14 14)
      (set! rdi r14)
      (set! r15 r15)
      (jump L.fun/void8397.4))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin (set! r14 14) (true))
        (begin (set! rax 18494) (jump r15))
        (begin (set! rax 57406) (jump r15))))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin (set! r14 6) (false))
        (begin (set! rax 25390) (jump r15))
        (begin (set! rax 25390) (jump r15))))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin (set! r14 14) (true))
        (begin (set! rax 240) (jump r15))
        (begin (set! rax 224) (jump r15))))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (set! r14 22)
      (set! r14 25390)
      (set! rax 30)
      (jump r15))))
(check-by-interp
 '(module
    (define L.fun/error8412.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 29758) (jump r15)))
    (begin
      (set! r15 r15)
      (set! r14 30)
      (set! r14 38974)
      (set! r14 r14)
      (set! rdi r14)
      (set! r15 r15)
      (jump L.fun/error8412.4))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8415.4
      (begin (set! r15 r15) (set! r14 rdi) (set! rax 25390) (jump r15)))
    (begin
      (set! r15 r15)
      (set! r14 25390)
      (set! r14 29502)
      (set! r14 25390)
      (set! rdi r14)
      (set! r15 r15)
      (jump L.fun/ascii-char8415.4))))
(check-by-interp
 '(module
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
    (define L.fun/empty8418.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char8419.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.9
          (begin (set! rsi 912) (set! rdi 760) (set! r15 L.rp.9) (jump L.+.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin
            (set! rsi 1664)
            (set! rdi 384)
            (set! r15 L.rp.10)
            (jump L.-.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty8418.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char8419.5))))
(check-by-interp
 '(module
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
    (begin
      (set! fv0 r15)
      (set! r15 25390)
      (set! r15 22)
      (set! r15 15166)
      (set! fv1 25390)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.8
          (begin
            (set! rsi 6)
            (set! rdi 30)
            (set! r15 L.rp.8)
            (jump L.fun/void8469.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (if (begin (set! r14 6) (false)) (set! r14 43582) (set! r14 65086))
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.9
          (begin
            (set! rsi r14)
            (set! rdi r15)
            (set! r15 L.rp.9)
            (jump L.fun/empty8468.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.fun/ascii-char8467.4))))
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
    (define L.-.5
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
    (begin
      (set! fv0 r15)
      (if (begin (set! r15 6) (false)) (set! r15 1712) (set! r15 688))
      (if (begin (set! r14 14) (true)) (set! r14 1480) (set! r14 128))
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.7
          (begin (set! rsi r14) (set! rdi r15) (set! r15 L.rp.7) (jump L.-.5)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (if (begin (set! r15 6) (false)) (set! r15 352) (set! r15 264))
      (set! r14 25390)
      (set! r14 13118)
      (set! r14 22)
      (set! r14 608)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.8
          (begin (set! rsi r14) (set! rdi r15) (set! r15 L.rp.8) (jump L.-.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.*.6))))
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
    (define L.vector?.6
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
    (define L.fun/any8734.4
      (begin
        (set! r15 r15)
        (set! r14 rdi)
        (set! r14 rsi)
        (set! r14 rdx)
        (set! rax 41278)
        (jump r15)))
    (begin
      (set! fv0 r15)
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 8))
                (return-point L.rp.9
                  (begin
                    (set! rdx 25390)
                    (set! rsi 22)
                    (set! rdi 5950)
                    (set! r15 L.rp.9)
                    (jump L.fun/any8734.4)))
                (set! rbp (+ rbp 8)))
              (set! r15 rax)
              (begin
                (set! rbp (- rbp 8))
                (return-point L.rp.10
                  (begin (set! rdi r15) (set! r15 L.rp.10) (jump L.vector?.6)))
                (set! rbp (+ rbp 8)))
              (set! r15 rax))
            (!= r15 6))
        (begin
          (begin
            (set! rbp (- rbp 8))
            (return-point L.rp.11
              (begin
                (set! rsi 528)
                (set! rdi 1480)
                (set! r15 L.rp.11)
                (jump L.-.7)))
            (set! rbp (+ rbp 8)))
          (set! r15 rax)
          (if (begin (set! r14 14) (true)) (set! r14 1488) (set! r14 1392))
          (set! rsi r14)
          (set! rdi r15)
          (set! r15 fv0)
          (jump L.*.8))
        (if (begin (set! r15 14) (true))
          (begin (set! rax 1552) (jump fv0))
          (begin (set! rax 1376) (jump fv0)))))))
(check-by-interp
 '(module
    (define L.fun/void8780.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char8782.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void8781.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error8783.7
      (begin (set! r15 r15) (set! rax 35646) (jump r15)))
    (define L.fun/void8779.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/void8779.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/void8780.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void8781.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/ascii-char8782.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error8783.7))))
(check-by-interp
 '(module
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
    (define L.fun/empty8806.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void8807.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char8808.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty8806.4)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.12
          (begin
            (set! rsi 864)
            (set! rdi 1608)
            (set! r15 L.rp.12)
            (jump L.-.8)))
        (set! rbp (+ rbp 24)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.13
          (begin
            (set! rsi 352)
            (set! rdi 328)
            (set! r15 L.rp.13)
            (jump L.+.9)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.-.8)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.15
          (begin
            (set! rsi 1048)
            (set! rdi 320)
            (set! r15 L.rp.15)
            (jump L.*.10)))
        (set! rbp (+ rbp 24)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.16
          (begin
            (set! rsi 968)
            (set! rdi 1096)
            (set! r15 L.rp.16)
            (jump L.*.10)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.17)
            (jump L.-.8)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void8807.5)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char8808.6))))
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
    (define L.vector?.13
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
    (begin
      (set! fv0 r15)
      (if (begin
            (begin
              (begin
                (set! rbp (- rbp 24))
                (return-point L.rp.17
                  (begin
                    (set! rdx 25390)
                    (set! rsi 44094)
                    (set! rdi 25390)
                    (set! r15 L.rp.17)
                    (jump L.fun/boolean9033.11)))
                (set! rbp (+ rbp 24)))
              (set! r15 rax))
            (!= r15 6))
        (if (begin (set! r15 6) (false)) (set! fv1 22) (set! fv1 22))
        (begin
          (begin
            (set! rbp (- rbp 24))
            (return-point L.rp.18
              (begin
                (set! rdx 14)
                (set! rsi 59454)
                (set! rdi 4158)
                (set! r15 L.rp.18)
                (jump L.fun/empty9034.4)))
            (set! rbp (+ rbp 24)))
          (set! fv1 rax)))
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.19
          (begin (set! rdi 25390) (set! r15 L.rp.19) (jump L.vector?.13)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.20
          (begin
            (set! rsi 192)
            (set! rdi 224)
            (set! r15 L.rp.20)
            (jump L.+.14)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error9035.6)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error9036.5)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.23
          (begin (set! rdi 30) (set! r15 L.rp.23) (jump L.fixnum?.15)))
        (set! rbp (+ rbp 24)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.24
          (begin
            (set! rdx 14)
            (set! rsi 6)
            (set! rdi 22)
            (set! r15 L.rp.24)
            (jump L.fun/ascii-char9031.10)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.25
          (begin (set! r15 L.rp.25) (jump L.fun/void9037.7)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.26
          (begin
            (set! rdx 6)
            (set! rsi 14)
            (set! rdi 22)
            (set! r15 L.rp.26)
            (jump L.fun/ascii-char9031.10)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.27
          (begin (set! r15 L.rp.27) (jump L.fun/empty9038.9)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.28
          (begin (set! rdi 30) (set! r15 L.rp.28) (jump L.error?.16)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (set! rdx r15)
      (set! rsi fv2)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.fun/ascii-char9031.10))))
(check-by-interp
 '(module
    (define L.fun/void9076.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char9078.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error9075.6
      (begin (set! r15 r15) (set! rax 57662) (jump r15)))
    (define L.fun/empty9077.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.9
          (begin (set! r15 L.rp.9) (jump L.fun/error9075.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/void9076.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty9077.7)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/ascii-char9078.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (if (begin (set! r14 6) (false))
            (begin (set! r14 14) (true))
            (begin (set! r14 14) (true)))
        (begin
          (set! r14 1720)
          (set! r13 984)
          (set! r13 30)
          (set! r13 25390)
          (set! rax r14)
          (jump r15))
        (if (begin (set! r14 6) (false))
          (begin (set! rax 1448) (jump r15))
          (begin (set! rax 1416) (jump r15)))))))
(check-by-interp
 '(module
    (define L.boolean?.10
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
    (define L.fun/error9365.4
      (begin (set! r15 r15) (set! rax 62014) (jump r15)))
    (define L.fun/error9364.5
      (begin (set! r15 r15) (set! rax 63806) (jump r15)))
    (define L.fun/any9366.6 (begin (set! r15 r15) (set! rax 14) (jump r15)))
    (define L.fun/error9363.7
      (begin (set! r15 r15) (set! rax 60990) (jump r15)))
    (define L.fun/empty9362.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty9362.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error9363.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/error9364.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/error9365.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/any9366.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! rdi r15)
      (set! r15 fv0)
      (jump L.boolean?.10))))
(check-by-interp
 '(module
    (define L.fun/ascii-char9574.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void9575.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void9573.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty9572.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.9
          (begin (set! r15 L.rp.9) (jump L.fun/empty9572.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/void9573.6)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char9574.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void9575.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (begin
      (set! r15 r15)
      (if (begin
            (set! r14 22)
            (set! r14 968)
            (set! r14 30)
            (set! r14 896)
            (begin (set! r14 6) (false)))
        (if (begin (set! r14 14) (true))
          (begin (set! rax 22) (jump r15))
          (begin (set! rax 22) (jump r15)))
        (begin
          (set! r14 22)
          (set! r14 42302)
          (set! r14 30)
          (set! r14 992)
          (set! rax 22)
          (jump r15))))))
(check-by-interp
 '(module
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
    (define L.fun/ascii-char9904.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void9902.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char9903.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/void9902.5)))
        (set! rbp (+ rbp 24)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char9903.6)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.12
          (begin
            (set! rsi 1592)
            (set! rdi 504)
            (set! r15 L.rp.12)
            (jump L.*.8)))
        (set! rbp (+ rbp 24)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.13
          (begin
            (set! rsi 1320)
            (set! rdi 552)
            (set! r15 L.rp.13)
            (jump L.*.8)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.-.9)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 24))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/ascii-char9904.4)))
        (set! rbp (+ rbp 24)))
      (set! r15 rax)
      (set! rax fv2)
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
    (define L.fun/void10674.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error10675.5
      (begin (set! r15 r15) (set! rax 64318) (jump r15)))
    (define L.fun/void10672.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty10673.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.12
          (begin
            (set! rsi 1560)
            (set! rdi 1112)
            (set! r15 L.rp.12)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.13
          (begin
            (set! rsi 704)
            (set! rdi 904)
            (set! r15 L.rp.13)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.15
          (begin
            (set! rsi 744)
            (set! rdi 216)
            (set! r15 L.rp.15)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.16
          (begin
            (set! rsi 1952)
            (set! rdi 1832)
            (set! r15 L.rp.16)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.17)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.18)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/void10672.6)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty10673.7)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void10674.4)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.22
          (begin
            (set! rsi 1024)
            (set! rdi 760)
            (set! r15 L.rp.22)
            (jump L.*.11)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.23
          (begin
            (set! rsi 160)
            (set! rdi 1344)
            (set! r15 L.rp.23)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.24)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.25
          (begin
            (set! rsi 648)
            (set! rdi 1136)
            (set! r15 L.rp.25)
            (jump L.*.11)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.26
          (begin
            (set! rsi 224)
            (set! rdi 736)
            (set! r15 L.rp.26)
            (jump L.*.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error10675.5))))
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
    (define L.fun/any10855.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char10854.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty10856.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void10857.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/ascii-char10854.5)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/any10855.4)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin (set! rdi r15) (set! r15 L.rp.14) (jump L.ascii-char?.9)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/empty10856.6)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi 784)
            (set! rdi 1352)
            (set! r15 L.rp.16)
            (jump L.+.10)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi 1792)
            (set! rdi 8)
            (set! r15 L.rp.17)
            (jump L.-.11)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.18)
            (jump L.-.11)))
        (set! rbp (+ rbp 40)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi 992)
            (set! rdi 112)
            (set! r15 L.rp.19)
            (jump L.-.11)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin
            (set! rsi 48)
            (set! rdi 1104)
            (set! r15 L.rp.20)
            (jump L.+.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.21)
            (jump L.+.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.22)
            (jump L.+.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/void10857.7)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.fun/void11402.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char11403.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char11400.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error11401.7
      (begin (set! r15 r15) (set! rax 15166) (jump r15)))
    (define L.fun/ascii-char11399.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/ascii-char11399.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char11400.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/error11401.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void11402.4)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char11403.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.fun/void13621.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char13620.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty13623.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error13618.7
      (begin (set! r15 r15) (set! rax 22846) (jump r15)))
    (define L.fun/void13619.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error13622.9
      (begin (set! r15 r15) (set! rax 25150) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/error13618.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void13619.8)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/ascii-char13620.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void13621.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/error13622.9)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/empty13623.6))))
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
    (define L.fun/void14228.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty14229.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char14227.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.11
          (begin
            (set! rsi 1328)
            (set! rdi 1512)
            (set! r15 L.rp.11)
            (jump L.*.8)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.12
          (begin
            (set! rsi 1096)
            (set! rdi 1088)
            (set! r15 L.rp.12)
            (jump L.*.8)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.13
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.13)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.14
          (begin
            (set! rsi 832)
            (set! rdi 1528)
            (set! r15 L.rp.14)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.15
          (begin
            (set! rsi 1744)
            (set! rdi 192)
            (set! r15 L.rp.15)
            (jump L.*.8)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.16
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.16)
            (jump L.*.8)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.17
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.17)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char14227.6)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.19
          (begin
            (set! rsi 1440)
            (set! rdi 880)
            (set! r15 L.rp.19)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.20
          (begin
            (set! rsi 320)
            (set! rdi 632)
            (set! r15 L.rp.20)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.21)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.22
          (begin
            (set! rsi 360)
            (set! rdi 1688)
            (set! r15 L.rp.22)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.23
          (begin
            (set! rsi 1952)
            (set! rdi 1800)
            (set! r15 L.rp.23)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.24)
            (jump L.-.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.25)
            (jump L.*.8)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.26
          (begin (set! r15 L.rp.26) (jump L.fun/void14228.4)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.27
          (begin (set! r15 L.rp.27) (jump L.fun/empty14229.5)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (set! rax r15)
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
    (define L.fun/void14544.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty14543.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char14546.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error14545.7 (begin (set! r15 r15) (set! rax 62) (jump r15)))
    (define L.fun/error14542.8
      (begin (set! r15 r15) (set! rax 38462) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/error14542.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/empty14543.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin
            (set! rsi 288)
            (set! rdi 1248)
            (set! r15 L.rp.15)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 552)
            (set! rdi 856)
            (set! r15 L.rp.16)
            (jump L.*.10)))
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
            (set! rsi 1056)
            (set! rdi 824)
            (set! r15 L.rp.18)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1720)
            (set! rdi 608)
            (set! r15 L.rp.19)
            (jump L.+.11)))
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
          (begin (set! r15 L.rp.22) (jump L.fun/void14544.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/error14545.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char14546.6))))
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
    (define L.fun/empty15112.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error15114.5
      (begin (set! r15 r15) (set! rax 11326) (jump r15)))
    (define L.fun/empty15111.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char15115.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/void15113.8 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.12
          (begin
            (set! rsi 1392)
            (set! rdi 1304)
            (set! r15 L.rp.12)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin
            (set! rsi 368)
            (set! rdi 1800)
            (set! r15 L.rp.13)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.14)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin
            (set! rsi 1944)
            (set! rdi 1672)
            (set! r15 L.rp.15)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin
            (set! rsi 1864)
            (set! rdi 1184)
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
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.18)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/empty15111.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty15112.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void15113.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error15114.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char15115.7))))
(check-by-interp
 '(module
    (define L.fixnum?.11
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
    (define L.fun/empty16025.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char16027.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/any16026.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty16025.4)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.13
          (begin (set! rsi 224) (set! rdi 56) (set! r15 L.rp.13) (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.14
          (begin
            (set! rsi 384)
            (set! rdi 336)
            (set! r15 L.rp.14)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.15
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.15)
            (jump L.-.10)))
        (set! rbp (+ rbp 80)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.16
          (begin
            (set! rsi 672)
            (set! rdi 1936)
            (set! r15 L.rp.16)
            (jump L.-.10)))
        (set! rbp (+ rbp 80)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.17
          (begin
            (set! rsi 1760)
            (set! rdi 1096)
            (set! r15 L.rp.17)
            (jump L.-.10)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.18)
            (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.19)
            (jump L.-.10)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.20
          (begin
            (set! rsi 1408)
            (set! rdi 56)
            (set! r15 L.rp.20)
            (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.21
          (begin (set! rsi 528) (set! rdi 8) (set! r15 L.rp.21) (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.22)
            (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.23
          (begin
            (set! rsi 376)
            (set! rdi 472)
            (set! r15 L.rp.23)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.24
          (begin
            (set! rsi 656)
            (set! rdi 1000)
            (set! r15 L.rp.24)
            (jump L.-.10)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.25)
            (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.26)
            (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.27
          (begin
            (set! rsi 464)
            (set! rdi 1064)
            (set! r15 L.rp.27)
            (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.28
          (begin
            (set! rsi 1504)
            (set! rdi 1088)
            (set! r15 L.rp.28)
            (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.30
          (begin
            (set! rsi 1048)
            (set! rdi 1328)
            (set! r15 L.rp.30)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.31
          (begin
            (set! rsi 560)
            (set! rdi 1832)
            (set! r15 L.rp.31)
            (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.32)
            (jump L.*.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.+.9)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/any16026.6)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.35
          (begin (set! rdi r15) (set! r15 L.rp.35) (jump L.fixnum?.11)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/ascii-char16027.5))))
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
    (define L.fun/ascii-char19237.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char19236.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error19239.6
      (begin (set! r15 r15) (set! rax 55358) (jump r15)))
    (define L.fun/void19235.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/error19238.8
      (begin (set! r15 r15) (set! rax 21566) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void19235.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char19236.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/ascii-char19237.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/error19238.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/error19239.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 160)
            (set! rdi 1752)
            (set! r15 L.rp.18)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1232)
            (set! rdi 456)
            (set! r15 L.rp.19)
            (jump L.+.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi 1432)
            (set! rdi 792)
            (set! r15 L.rp.21)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi 1552)
            (set! rdi 1848)
            (set! r15 L.rp.22)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.23)
            (jump L.*.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.-.10))))
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
    (define L.fun/empty20765.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char20767.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char20768.6
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/empty20764.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error20766.8
      (begin (set! r15 r15) (set! rax 64574) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty20764.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/empty20765.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/error20766.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/ascii-char20767.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/ascii-char20768.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 1184)
            (set! rdi 1504)
            (set! r15 L.rp.18)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1296)
            (set! rdi 1616)
            (set! r15 L.rp.19)
            (jump L.+.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi 1272)
            (set! rdi 8)
            (set! r15 L.rp.21)
            (jump L.-.10)))
        (set! rbp (+ rbp 32)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi 528)
            (set! rdi 888)
            (set! r15 L.rp.22)
            (jump L.*.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.23)
            (jump L.*.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.*.12))))
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
    (define L.fun/ascii-char21096.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/ascii-char21098.5
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error21099.6
      (begin (set! r15 r15) (set! rax 33086) (jump r15)))
    (define L.fun/ascii-char21097.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/ascii-char21096.4)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.13
          (begin
            (set! rsi 1976)
            (set! rdi 1208)
            (set! r15 L.rp.13)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.14
          (begin
            (set! rsi 32)
            (set! rdi 1432)
            (set! r15 L.rp.14)
            (jump L.*.10)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.15
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.15)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.16
          (begin
            (set! rsi 456)
            (set! rdi 1400)
            (set! r15 L.rp.16)
            (jump L.*.10)))
        (set! rbp (+ rbp 56)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.17
          (begin
            (set! rsi 1672)
            (set! rdi 888)
            (set! r15 L.rp.17)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.18)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.19)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char21097.7)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char21098.5)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.22
          (begin
            (set! rsi 1800)
            (set! rdi 1032)
            (set! r15 L.rp.22)
            (jump L.*.10)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.23
          (begin
            (set! rsi 560)
            (set! rdi 552)
            (set! r15 L.rp.23)
            (jump L.+.9)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.24)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.25
          (begin
            (set! rsi 368)
            (set! rdi 1424)
            (set! r15 L.rp.25)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.26
          (begin
            (set! rsi 296)
            (set! rdi 864)
            (set! r15 L.rp.26)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 56))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.-.11)))
        (set! rbp (+ rbp 56)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error21099.6))))
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
    (define L.fun/void21257.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void21255.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void21256.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char21254.7
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/ascii-char21254.7)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void21255.5)))
        (set! rbp (+ rbp 40)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.13
          (begin
            (set! rsi 736)
            (set! rdi 1728)
            (set! r15 L.rp.13)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.14
          (begin
            (set! rsi 192)
            (set! rdi 1624)
            (set! r15 L.rp.14)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.15
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.15)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.16
          (begin
            (set! rsi 888)
            (set! rdi 160)
            (set! r15 L.rp.16)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.17
          (begin
            (set! rsi 1920)
            (set! rdi 1968)
            (set! r15 L.rp.17)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.18)
            (jump L.+.9)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.19)
            (jump L.-.10)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void21256.6)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 40))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void21257.4)))
        (set! rbp (+ rbp 40)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
    (define L.fun/error21502.4
      (begin (set! r15 r15) (set! rax 12606) (jump r15)))
    (define L.fun/empty21506.5 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/empty21503.6 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/error21505.7
      (begin (set! r15 r15) (set! rax 45630) (jump r15)))
    (define L.fun/empty21504.8 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/error21502.4)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty21503.6)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/empty21504.8)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/error21505.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/empty21506.5)))
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
    (define L.fun/empty21523.4 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/void21525.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void21524.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void21527.7 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/ascii-char21526.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/empty21523.4)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/void21524.6)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.15
          (begin (set! r15 L.rp.15) (jump L.fun/void21525.5)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.16
          (begin (set! r15 L.rp.16) (jump L.fun/ascii-char21526.8)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void21527.7)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.18
          (begin
            (set! rsi 1448)
            (set! rdi 1072)
            (set! r15 L.rp.18)
            (jump L.*.10)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.19
          (begin
            (set! rsi 1416)
            (set! rdi 496)
            (set! r15 L.rp.19)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.21
          (begin
            (set! rsi 1208)
            (set! rdi 80)
            (set! r15 L.rp.21)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.22
          (begin
            (set! rsi 1032)
            (set! rdi 888)
            (set! r15 L.rp.22)
            (jump L.-.11)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 32))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.23)
            (jump L.+.12)))
        (set! rbp (+ rbp 32)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.+.12))))
(check-by-interp
 '(module
    (define L.fun/void22132.4 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void22129.5 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/void22131.6 (begin (set! r15 r15) (set! rax 30) (jump r15)))
    (define L.fun/empty22130.7 (begin (set! r15 r15) (set! rax 22) (jump r15)))
    (define L.fun/ascii-char22133.8
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.10
          (begin (set! r15 L.rp.10) (jump L.fun/void22129.5)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.11
          (begin (set! r15 L.rp.11) (jump L.fun/empty22130.7)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.12
          (begin (set! r15 L.rp.12) (jump L.fun/void22131.6)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.13
          (begin (set! r15 L.rp.13) (jump L.fun/void22132.4)))
        (set! rbp (+ rbp 8)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 8))
        (return-point L.rp.14
          (begin (set! r15 L.rp.14) (jump L.fun/ascii-char22133.8)))
        (set! rbp (+ rbp 8)))
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/ascii-char35206.4)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char35208.5)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty35210.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/error35212.12)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 112)
            (set! rdi 24)
            (set! r15 L.rp.22)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi 808)
            (set! rdi 1176)
            (set! r15 L.rp.23)
            (jump L.+.16)))
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
            (set! rsi 1560)
            (set! rdi 1752)
            (set! r15 L.rp.25)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 1400)
            (set! rdi 40)
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
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.28)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 1136)
            (set! rdi 680)
            (set! r15 L.rp.29)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi 1040)
            (set! rdi 1016)
            (set! r15 L.rp.30)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.31)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi 288)
            (set! rdi 256)
            (set! r15 L.rp.32)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi 1544)
            (set! rdi 280)
            (set! r15 L.rp.33)
            (jump L.+.16)))
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
            (jump L.+.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/void35214.8)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/empty43333.9)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/empty43335.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/any43337.6)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! rdi r15) (set! r15 L.rp.23) (jump L.void?.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 704)
            (set! rdi 832)
            (set! r15 L.rp.24)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 1832)
            (set! rdi 1040)
            (set! r15 L.rp.25)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.26)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 568)
            (set! rdi 952)
            (set! r15 L.rp.27)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 1880)
            (set! rdi 1392)
            (set! r15 L.rp.28)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi 456)
            (set! rdi 616)
            (set! r15 L.rp.31)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi 432)
            (set! rdi 1928)
            (set! r15 L.rp.32)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi 1376)
            (set! rdi 400)
            (set! r15 L.rp.34)
            (jump L.+.18)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 1920)
            (set! rdi 576)
            (set! r15 L.rp.35)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.*.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.37)
            (jump L.*.16)))
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
          (begin (set! r15 L.rp.39) (jump L.fun/empty43338.10)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin (set! r15 L.rp.40) (jump L.fun/any43340.7)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.41
          (begin (set! rdi r15) (set! r15 L.rp.41) (jump L.error?.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/void43341.4))))
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/empty44111.6)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/ascii-char44113.12)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/ascii-char44115.4)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void44117.7)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.22
          (begin
            (set! rsi 1768)
            (set! rdi 488)
            (set! r15 L.rp.22)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.23
          (begin
            (set! rsi 1968)
            (set! rdi 992)
            (set! r15 L.rp.23)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.24)
            (jump L.+.16)))
        (set! rbp (+ rbp 104)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.25
          (begin
            (set! rsi 120)
            (set! rdi 1304)
            (set! r15 L.rp.25)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.26
          (begin
            (set! rsi 336)
            (set! rdi 296)
            (set! r15 L.rp.26)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.+.16)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.+.16)))
        (set! rbp (+ rbp 104)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.29
          (begin
            (set! rsi 136)
            (set! rdi 200)
            (set! r15 L.rp.29)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.30
          (begin
            (set! rsi 1016)
            (set! rdi 544)
            (set! r15 L.rp.30)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.32
          (begin
            (set! rsi 712)
            (set! rdi 1440)
            (set! r15 L.rp.32)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.33
          (begin
            (set! rsi 1408)
            (set! rdi 1984)
            (set! r15 L.rp.33)
            (jump L.-.17)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.34)
            (jump L.-.17)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.35)
            (jump L.-.17)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.36)
            (jump L.+.16)))
        (set! rbp (+ rbp 104)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char44119.5)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.38
          (begin
            (set! rsi 736)
            (set! rdi 416)
            (set! r15 L.rp.38)
            (jump L.+.16)))
        (set! rbp (+ rbp 104)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.39
          (begin
            (set! rsi 136)
            (set! rdi fv3)
            (set! r15 L.rp.39)
            (jump L.-.17)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.40)
            (jump L.-.17)))
        (set! rbp (+ rbp 104)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.41
          (begin
            (set! rsi 192)
            (set! rdi 520)
            (set! r15 L.rp.41)
            (jump L.+.16)))
        (set! rbp (+ rbp 104)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.42
          (begin
            (set! rsi fv3)
            (set! rdi fv3)
            (set! r15 L.rp.42)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.43)
            (jump L.-.17)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.44
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.44)
            (jump L.+.16)))
        (set! rbp (+ rbp 104)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.45
          (begin
            (set! rsi fv3)
            (set! rdi 440)
            (set! r15 L.rp.45)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.46)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 104))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.47)
            (jump L.*.15)))
        (set! rbp (+ rbp 104)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.-.17))))
(check-by-interp
 '(module
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin
            (set! rsi 1192)
            (set! rdi 2024)
            (set! r15 L.rp.16)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin
            (set! rsi 1848)
            (set! rdi 472)
            (set! r15 L.rp.17)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin
            (set! rsi 200)
            (set! rdi 1496)
            (set! r15 L.rp.19)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi 400)
            (set! rdi 936)
            (set! r15 L.rp.20)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.21)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.22)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi 512)
            (set! rdi 1400)
            (set! r15 L.rp.23)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi 568)
            (set! rdi 304)
            (set! r15 L.rp.24)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.25)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi 1904)
            (set! rdi 1000)
            (set! r15 L.rp.26)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi 448)
            (set! rdi 528)
            (set! r15 L.rp.27)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.30)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin (set! rsi 8) (set! rdi 888) (set! r15 L.rp.31) (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin
            (set! rsi 1296)
            (set! rdi 1576)
            (set! r15 L.rp.32)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi 2000)
            (set! rdi 1288)
            (set! r15 L.rp.34)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin
            (set! rsi 1088)
            (set! rdi 488)
            (set! r15 L.rp.35)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.37)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi 1032)
            (set! rdi 1392)
            (set! r15 L.rp.38)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi 536)
            (set! rdi 1776)
            (set! r15 L.rp.39)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.40)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi 2016)
            (set! rdi 1016)
            (set! r15 L.rp.41)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi 1736)
            (set! rdi 1680)
            (set! r15 L.rp.42)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.43)
            (jump L.-.12)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.44)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.45)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin (set! r15 L.rp.46) (jump L.fun/error58874.10)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin (set! r15 L.rp.47) (jump L.fun/empty58876.8)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/ascii-char58878.9)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/any58880.7)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.50
          (begin (set! rdi r15) (set! r15 L.rp.50) (jump L.fixnum?.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
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
    (define L.fun/ascii-char63953.4
      (begin (set! r15 r15) (set! rax 25390) (jump r15)))
    (define L.fun/error63956.5
      (begin (set! r15 r15) (set! rax 20030) (jump r15)))
    (define L.fun/ascii-char63952.6
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/ascii-char63953.4)))
    (define L.fun/error63955.7
      (begin (set! r15 r15) (set! r15 r15) (jump L.fun/error63956.5)))
    (define L.fun/any63954.8 (begin (set! r15 r15) (set! rax 1784) (jump r15)))
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.14
          (begin
            (set! rsi 2024)
            (set! rdi 224)
            (set! r15 L.rp.14)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.15
          (begin
            (set! rsi 1720)
            (set! rdi 1520)
            (set! r15 L.rp.15)
            (jump L.*.10)))
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
            (set! rsi 680)
            (set! rdi 1768)
            (set! r15 L.rp.17)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.18
          (begin
            (set! rsi 840)
            (set! rdi 1488)
            (set! r15 L.rp.18)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.19
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.19)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.20)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.21
          (begin
            (set! rsi 1392)
            (set! rdi 1920)
            (set! r15 L.rp.21)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.22
          (begin
            (set! rsi 1024)
            (set! rdi 1632)
            (set! r15 L.rp.22)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.24
          (begin
            (set! rsi 1008)
            (set! rdi 1096)
            (set! r15 L.rp.24)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.25
          (begin
            (set! rsi 416)
            (set! rdi 416)
            (set! r15 L.rp.25)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.26)
            (jump L.*.10)))
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
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.29
          (begin (set! r15 L.rp.29) (jump L.fun/ascii-char63952.6)))
        (set! rbp (+ rbp 184)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.30
          (begin
            (set! rsi 120)
            (set! rdi 424)
            (set! r15 L.rp.30)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.31
          (begin
            (set! rsi 64)
            (set! rdi 792)
            (set! r15 L.rp.31)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.32)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.33
          (begin
            (set! rsi 240)
            (set! rdi 936)
            (set! r15 L.rp.33)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.34
          (begin
            (set! rsi 376)
            (set! rdi 1192)
            (set! r15 L.rp.34)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.35)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.36)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.37
          (begin
            (set! rsi 1872)
            (set! rdi 1392)
            (set! r15 L.rp.37)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.38
          (begin
            (set! rsi 304)
            (set! rdi 1024)
            (set! r15 L.rp.38)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.39)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.40
          (begin
            (set! rsi 688)
            (set! rdi 1776)
            (set! r15 L.rp.40)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.41
          (begin
            (set! rsi 1240)
            (set! rdi 552)
            (set! r15 L.rp.41)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.42
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.42)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.43)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.44
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.44)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.45
          (begin
            (set! rsi 1848)
            (set! rdi 872)
            (set! r15 L.rp.45)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.46
          (begin
            (set! rsi 1936)
            (set! rdi 128)
            (set! r15 L.rp.46)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.47)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.48
          (begin
            (set! rsi 256)
            (set! rdi 1336)
            (set! r15 L.rp.48)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.49
          (begin
            (set! rsi 1576)
            (set! rdi 2000)
            (set! r15 L.rp.49)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.50
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.50)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.51
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.51)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.52
          (begin
            (set! rsi 1152)
            (set! rdi 1528)
            (set! r15 L.rp.52)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.53
          (begin
            (set! rsi 816)
            (set! rdi 1792)
            (set! r15 L.rp.53)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.54
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.54)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.55
          (begin
            (set! rsi 2032)
            (set! rdi 512)
            (set! r15 L.rp.55)
            (jump L.+.11)))
        (set! rbp (+ rbp 184)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.56
          (begin
            (set! rsi 360)
            (set! rdi 1032)
            (set! r15 L.rp.56)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.57
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.57)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.58
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.58)
            (jump L.*.10)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.59
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.59)
            (jump L.-.12)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.60
          (begin (set! r15 L.rp.60) (jump L.fun/any63954.8)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.61
          (begin (set! rdi r15) (set! r15 L.rp.61) (jump L.void?.13)))
        (set! rbp (+ rbp 184)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 184))
        (return-point L.rp.62
          (begin (set! r15 L.rp.62) (jump L.fun/error63955.7)))
        (set! rbp (+ rbp 184)))
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin
            (set! rsi 336)
            (set! rdi 104)
            (set! r15 L.rp.18)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin
            (set! rsi 1800)
            (set! rdi 888)
            (set! r15 L.rp.19)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi 1344)
            (set! rdi 872)
            (set! r15 L.rp.21)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 680)
            (set! rdi 1360)
            (set! r15 L.rp.22)
            (jump L.+.15)))
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
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi 1248)
            (set! rdi 72)
            (set! r15 L.rp.25)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 1360)
            (set! rdi 896)
            (set! r15 L.rp.26)
            (jump L.+.15)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.-.17)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 152)
            (set! rdi 680)
            (set! r15 L.rp.28)
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 1392)
            (set! rdi 1104)
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
            (jump L.+.15)))
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
            (jump L.*.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/empty71269.12)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/ascii-char71271.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/ascii-char71273.7)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/ascii-char71275.10)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/void71277.11)))
        (set! rbp (+ rbp 72)))
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin
            (set! rsi 2024)
            (set! rdi 1888)
            (set! r15 L.rp.16)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin
            (set! rsi 1464)
            (set! rdi 696)
            (set! r15 L.rp.17)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin
            (set! rsi 416)
            (set! rdi 1344)
            (set! r15 L.rp.19)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi 88)
            (set! rdi 464)
            (set! r15 L.rp.20)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.21)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.22)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi 1760)
            (set! rdi 40)
            (set! r15 L.rp.23)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi 1688)
            (set! rdi 104)
            (set! r15 L.rp.24)
            (jump L.-.14)))
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
            (set! rsi 952)
            (set! rdi 1952)
            (set! r15 L.rp.26)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi 584)
            (set! rdi 1264)
            (set! r15 L.rp.27)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.30)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin (set! r15 L.rp.31) (jump L.fun/empty73456.4)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin (set! r15 L.rp.32) (jump L.fun/ascii-char73458.5)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/error73460.7)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi 1504)
            (set! rdi 2008)
            (set! r15 L.rp.34)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin
            (set! rsi 1856)
            (set! rdi 1768)
            (set! r15 L.rp.35)
            (jump L.+.15)))
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
            (set! rsi 1728)
            (set! rdi 880)
            (set! r15 L.rp.37)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi 152)
            (set! rdi 1992)
            (set! r15 L.rp.38)
            (jump L.*.13)))
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
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv4 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi 672)
            (set! rdi 840)
            (set! r15 L.rp.41)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi 368)
            (set! rdi 1704)
            (set! r15 L.rp.42)
            (jump L.+.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.43)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi 1992)
            (set! rdi 624)
            (set! r15 L.rp.44)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi 920)
            (set! rdi 1976)
            (set! r15 L.rp.45)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.46)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.47)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin
            (set! rsi r15)
            (set! rdi fv4)
            (set! r15 L.rp.48)
            (jump L.-.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/empty73462.11)))
        (set! rbp (+ rbp 128)))
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void77838.5)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin
            (set! rsi 800)
            (set! rdi 1560)
            (set! r15 L.rp.19)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin
            (set! rsi 1936)
            (set! rdi 1880)
            (set! r15 L.rp.20)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.21)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 752)
            (set! rdi 216)
            (set! r15 L.rp.22)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.23
          (begin
            (set! rsi 800)
            (set! rdi 1208)
            (set! r15 L.rp.23)
            (jump L.-.16)))
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
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.25)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin (set! rsi 752) (set! rdi 8) (set! r15 L.rp.26) (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi 1208)
            (set! rdi 1448)
            (set! r15 L.rp.27)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 1784)
            (set! rdi 1232)
            (set! r15 L.rp.29)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.30
          (begin
            (set! rsi 1256)
            (set! rdi 1288)
            (set! r15 L.rp.30)
            (jump L.-.16)))
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
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.32)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.+.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/empty77840.8)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/void77842.4)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/error77844.12)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/error77846.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error78092.6)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.19
          (begin
            (set! rsi 480)
            (set! rdi 1192)
            (set! r15 L.rp.19)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.20
          (begin
            (set! rsi 56)
            (set! rdi 1584)
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
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.22
          (begin
            (set! rsi 128)
            (set! rdi 1488)
            (set! r15 L.rp.22)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.23
          (begin
            (set! rsi 1720)
            (set! rdi 488)
            (set! r15 L.rp.23)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.24
          (begin
            (set! rsi r15)
            (set! rdi fv2)
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
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.26
          (begin
            (set! rsi 1640)
            (set! rdi 1312)
            (set! r15 L.rp.26)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.27
          (begin
            (set! rsi 864)
            (set! rdi 1184)
            (set! r15 L.rp.27)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.29
          (begin
            (set! rsi 296)
            (set! rdi 208)
            (set! r15 L.rp.29)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.30
          (begin
            (set! rsi 32)
            (set! rdi 800)
            (set! r15 L.rp.30)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.31)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.32)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.34
          (begin (set! r15 L.rp.34) (jump L.fun/any78094.7)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.35
          (begin (set! rdi r15) (set! r15 L.rp.35) (jump L.boolean?.16)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/any78095.4)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.37
          (begin (set! rdi r15) (set! r15 L.rp.37) (jump L.ascii-char?.17)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.38
          (begin
            (set! rsi 1384)
            (set! rdi 136)
            (set! r15 L.rp.38)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.39
          (begin
            (set! rsi 592)
            (set! rdi 1784)
            (set! r15 L.rp.39)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.40)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.41
          (begin
            (set! rsi 584)
            (set! rdi 1536)
            (set! r15 L.rp.41)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.42
          (begin
            (set! rsi 1504)
            (set! rdi 1528)
            (set! r15 L.rp.42)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.43)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.44
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.44)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.45
          (begin
            (set! rsi 1824)
            (set! rdi 1536)
            (set! r15 L.rp.45)
            (jump L.*.14)))
        (set! rbp (+ rbp 120)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.46
          (begin
            (set! rsi 840)
            (set! rdi 1760)
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
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.48
          (begin
            (set! rsi 1032)
            (set! rdi 1864)
            (set! r15 L.rp.48)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.49
          (begin
            (set! rsi 688)
            (set! rdi 88)
            (set! r15 L.rp.49)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.50
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.50)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.51
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.51)
            (jump L.+.15)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.52
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.52)
            (jump L.-.13)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 120))
        (return-point L.rp.53
          (begin (set! r15 L.rp.53) (jump L.fun/error78096.10)))
        (set! rbp (+ rbp 120)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/void78098.11))))
(check-by-interp
 '(module
    (define L.boolean?.17
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.18
          (begin
            (set! rsi 248)
            (set! rdi 1216)
            (set! r15 L.rp.18)
            (jump L.+.14)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.19
          (begin
            (set! rsi 528)
            (set! rdi 1128)
            (set! r15 L.rp.19)
            (jump L.+.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.20
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.20)
            (jump L.*.15)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.21
          (begin
            (set! rsi 1032)
            (set! rdi 176)
            (set! r15 L.rp.21)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.22
          (begin
            (set! rsi 1320)
            (set! rdi 968)
            (set! r15 L.rp.22)
            (jump L.-.16)))
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
            (set! rsi 1872)
            (set! rdi 424)
            (set! r15 L.rp.25)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.26
          (begin
            (set! rsi 1288)
            (set! rdi 480)
            (set! r15 L.rp.26)
            (jump L.+.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.+.14)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.28
          (begin
            (set! rsi 1400)
            (set! rdi 1368)
            (set! r15 L.rp.28)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.29
          (begin
            (set! rsi 544)
            (set! rdi 704)
            (set! r15 L.rp.29)
            (jump L.+.14)))
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
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.31
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.31)
            (jump L.-.16)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.32)
            (jump L.+.14)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.33
          (begin (set! r15 L.rp.33) (jump L.fun/any101991.10)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.34
          (begin (set! rdi r15) (set! r15 L.rp.34) (jump L.boolean?.17)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.35
          (begin (set! r15 L.rp.35) (jump L.fun/void101992.7)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/ascii-char101994.6)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/empty101996.9)))
        (set! rbp (+ rbp 72)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 72))
        (return-point L.rp.38
          (begin (set! r15 L.rp.38) (jump L.fun/void101998.8)))
        (set! rbp (+ rbp 72)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
(check-by-interp
 '(module
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.17
          (begin (set! r15 L.rp.17) (jump L.fun/void102352.11)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/error102354.6)))
        (set! rbp (+ rbp 16)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/empty102356.5)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/void102358.7)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/void102360.14)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 16))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/void102362.4)))
        (set! rbp (+ rbp 16)))
      (set! r15 rax)
      (set! rax fv1)
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/any122156.11)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! rdi r15) (set! r15 L.rp.21) (jump L.boolean?.16)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/empty122157.12)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin
            (set! rsi 96)
            (set! rdi 1368)
            (set! r15 L.rp.23)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin
            (set! rsi 448)
            (set! rdi 1560)
            (set! r15 L.rp.24)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.25)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 224)
            (set! rdi 952)
            (set! r15 L.rp.26)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.27
          (begin
            (set! rsi 1680)
            (set! rdi 1856)
            (set! r15 L.rp.27)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.+.19)))
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
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi 304)
            (set! rdi 104)
            (set! r15 L.rp.30)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.31
          (begin
            (set! rsi 1296)
            (set! rdi 1432)
            (set! r15 L.rp.31)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.32
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.32)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 1160)
            (set! rdi 728)
            (set! r15 L.rp.33)
            (jump L.+.19)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi 464)
            (set! rdi 416)
            (set! r15 L.rp.34)
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.35)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv3)
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
            (jump L.-.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin (set! r15 L.rp.38) (jump L.fun/ascii-char122159.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin (set! r15 L.rp.39) (jump L.fun/ascii-char122161.14)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.40
          (begin (set! r15 L.rp.40) (jump L.fun/void122163.4)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/error122165.9))))
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.20
          (begin (set! r15 L.rp.20) (jump L.fun/error124205.15)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.21
          (begin (set! r15 L.rp.21) (jump L.fun/ascii-char124207.8)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.22
          (begin (set! r15 L.rp.22) (jump L.fun/error124209.12)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.23
          (begin (set! r15 L.rp.23) (jump L.fun/ascii-char124211.5)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.24
          (begin (set! r15 L.rp.24) (jump L.fun/error124213.7)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.25
          (begin
            (set! rsi 16)
            (set! rdi 1640)
            (set! r15 L.rp.25)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.26
          (begin
            (set! rsi 120)
            (set! rdi 1384)
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
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.28
          (begin
            (set! rsi 1400)
            (set! rdi 712)
            (set! r15 L.rp.28)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.29
          (begin
            (set! rsi 912)
            (set! rdi 936)
            (set! r15 L.rp.29)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.+.17)))
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
            (set! rsi 952)
            (set! rdi 1344)
            (set! r15 L.rp.32)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.33
          (begin
            (set! rsi 264)
            (set! rdi 648)
            (set! r15 L.rp.33)
            (jump L.-.19)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.34)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.35
          (begin
            (set! rsi 1552)
            (set! rdi 560)
            (set! r15 L.rp.35)
            (jump L.-.19)))
        (set! rbp (+ rbp 64)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.36
          (begin
            (set! rsi 952)
            (set! rdi 592)
            (set! r15 L.rp.36)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.37)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.38
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.38)
            (jump L.+.17)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 64))
        (return-point L.rp.39
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.39)
            (jump L.*.18)))
        (set! rbp (+ rbp 64)))
      (set! r15 rax)
      (set! r15 fv0)
      (jump L.fun/void124215.9))))
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
    (define L.pair?.14
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.18
          (begin (set! r15 L.rp.18) (jump L.fun/void156379.5)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.19
          (begin (set! r15 L.rp.19) (jump L.fun/any156381.8)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.20
          (begin (set! rdi r15) (set! r15 L.rp.20) (jump L.pair?.14)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.21
          (begin
            (set! rsi 2016)
            (set! rdi 232)
            (set! r15 L.rp.21)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.22
          (begin
            (set! rsi 304)
            (set! rdi 504)
            (set! r15 L.rp.22)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.23
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.23)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.24
          (begin
            (set! rsi 1152)
            (set! rdi 368)
            (set! r15 L.rp.24)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.25
          (begin
            (set! rsi 424)
            (set! rdi 1752)
            (set! r15 L.rp.25)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.26
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.26)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.27
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.27)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.28
          (begin
            (set! rsi 1616)
            (set! rdi 1736)
            (set! r15 L.rp.28)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.29
          (begin
            (set! rsi 568)
            (set! rdi 320)
            (set! r15 L.rp.29)
            (jump L.*.16)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.30)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.31
          (begin
            (set! rsi 1224)
            (set! rdi 192)
            (set! r15 L.rp.31)
            (jump L.+.17)))
        (set! rbp (+ rbp 80)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.32
          (begin
            (set! rsi 2016)
            (set! rdi 1976)
            (set! r15 L.rp.32)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.33)
            (jump L.+.17)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.34
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.34)
            (jump L.*.16)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.35
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.35)
            (jump L.+.17)))
        (set! rbp (+ rbp 80)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.36
          (begin (set! r15 L.rp.36) (jump L.fun/ascii-char156382.4)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.37
          (begin (set! r15 L.rp.37) (jump L.fun/ascii-char156384.10)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.38
          (begin (set! r15 L.rp.38) (jump L.fun/void156386.9)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.39
          (begin
            (set! rsi 1944)
            (set! rdi 912)
            (set! r15 L.rp.39)
            (jump L.+.17)))
        (set! rbp (+ rbp 80)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.40
          (begin
            (set! rsi fv1)
            (set! rdi 1896)
            (set! r15 L.rp.40)
            (jump L.+.17)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.41
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.41)
            (jump L.-.15)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 80))
        (return-point L.rp.42
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.42)
            (jump L.*.16)))
        (set! rbp (+ rbp 80)))
      (set! r15 rax)
      (set! rsi r15)
      (set! rdi fv1)
      (set! r15 fv0)
      (jump L.-.15))))
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
    (begin
      (set! fv0 r15)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.16
          (begin
            (set! rsi 1576)
            (set! rdi 2008)
            (set! r15 L.rp.16)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.17
          (begin
            (set! rsi 1128)
            (set! rdi 1088)
            (set! r15 L.rp.17)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.18
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.18)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.19
          (begin
            (set! rsi 48)
            (set! rdi 1968)
            (set! r15 L.rp.19)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.20
          (begin
            (set! rsi 624)
            (set! rdi 592)
            (set! r15 L.rp.20)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.21
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.21)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.22
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.22)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.23
          (begin
            (set! rsi 672)
            (set! rdi 1184)
            (set! r15 L.rp.23)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.24
          (begin
            (set! rsi 1584)
            (set! rdi 1320)
            (set! r15 L.rp.24)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.25
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.25)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.26
          (begin
            (set! rsi 904)
            (set! rdi 1768)
            (set! r15 L.rp.26)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.27
          (begin
            (set! rsi 104)
            (set! rdi 928)
            (set! r15 L.rp.27)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.28
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.28)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.29
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.29)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.30
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.30)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.31
          (begin
            (set! rsi 240)
            (set! rdi 1160)
            (set! r15 L.rp.31)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.32
          (begin
            (set! rsi 256)
            (set! rdi 1520)
            (set! r15 L.rp.32)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.33
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.33)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.34
          (begin
            (set! rsi 240)
            (set! rdi 960)
            (set! r15 L.rp.34)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.35
          (begin
            (set! rsi 728)
            (set! rdi 624)
            (set! r15 L.rp.35)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.36
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.36)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.37
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.37)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.38
          (begin
            (set! rsi 1080)
            (set! rdi 1880)
            (set! r15 L.rp.38)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.39
          (begin
            (set! rsi 1000)
            (set! rdi 440)
            (set! r15 L.rp.39)
            (jump L.*.13)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.40
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.40)
            (jump L.+.14)))
        (set! rbp (+ rbp 128)))
      (set! fv3 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.41
          (begin
            (set! rsi 608)
            (set! rdi 936)
            (set! r15 L.rp.41)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! fv2 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.42
          (begin
            (set! rsi 984)
            (set! rdi 568)
            (set! r15 L.rp.42)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.43
          (begin
            (set! rsi r15)
            (set! rdi fv2)
            (set! r15 L.rp.43)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.44
          (begin
            (set! rsi r15)
            (set! rdi fv3)
            (set! r15 L.rp.44)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.45
          (begin
            (set! rsi r15)
            (set! rdi fv1)
            (set! r15 L.rp.45)
            (jump L.-.15)))
        (set! rbp (+ rbp 128)))
      (set! fv1 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.46
          (begin (set! r15 L.rp.46) (jump L.fun/ascii-char171684.6)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.47
          (begin (set! r15 L.rp.47) (jump L.fun/empty171686.4)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.48
          (begin (set! r15 L.rp.48) (jump L.fun/void171688.7)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (begin
        (set! rbp (- rbp 128))
        (return-point L.rp.49
          (begin (set! r15 L.rp.49) (jump L.fun/void171690.11)))
        (set! rbp (+ rbp 128)))
      (set! r15 rax)
      (set! rax fv1)
      (jump fv0))))
