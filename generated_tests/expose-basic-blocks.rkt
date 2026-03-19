#lang racket

(require rackunit
  cpsc411/langs/v6
  (only-in "../expose-basic-blocks.rkt" expose-basic-blocks))

(define-syntax-rule (check-by-interp p)
    (check-equal? (interp-nested-asm-lang-v6 p) (interp-block-pred-lang-v6 (expose-basic-blocks p))))

;; M6 tests; Added by Trevor on March 6th 2026, at most one binding per let
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 -422317085)
     (set! r14 r14)
     (set! r14 r14)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r14 rcx)
       (set! r14 r8)
       (set! rax 9223372036854775807)
       (jump r15)))
   (define L.proc.1.2
     (begin
       (set! (rbp - 0) r15)
       (set! (rbp - 8) rdi)
       (set! r15 rsi)
       (set! (rbp - 8) (rbp - 8))
       (begin
         (set! rbp (- rbp 24))
         (return-point L.rp.3
           (begin
             (set! rsi (rbp - -16))
             (set! rdi (rbp - -16))
             (set! r15 L.rp.3)
             (jump L.proc.1.2)))
         (set! rbp (+ rbp 24)))
       (set! r15 rax)
       (if (begin (set! r15 -59730991) (= r15 (rbp - 8)))
         (begin (set! rax 0) (jump (rbp - 0)))
         (begin (set! rax (rbp - 8)) (jump (rbp - 0))))))
   (begin
     (set! r15 r15)
     (begin
       (set! r14 1)
       (set! r14 (* r14 -9223372036854775808))
       (set! r14 r14))
     (if (not (> r14 r14))
       (begin (set! r14 r14) (set! rax -1510146984) (jump r15))
       (begin
         (set! rsi r14)
         (set! rdi -9223372036854775808)
         (set! r15 r15)
         (jump L.proc.1.2))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (if (begin (set! r14 -1418594624) (false))
       (begin
         (if (begin (set! r14 -1123833745) (false)) (set! r14 1) (set! r14 0))
         (set! r14 767736686)
         (set! r14 r14))
       (begin (set! r14 1942655457) (set! r14 r14)))
     (set! r14 r14)
     (set! r14 (- r14 r14))
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! (rbp - 0) r15)
       (set! r15 rdi)
       (set! r15 rsi)
       (set! r14 rdx)
       (set! (rbp - 16) rcx)
       (set! (rbp - 8) r8)
       (begin
         (set! rbp (- rbp 24))
         (return-point L.rp.2
           (begin
             (set! r8 (rbp - -16))
             (set! rcx (rbp - -8))
             (set! rdx r15)
             (set! rsi -9223372036854775808)
             (set! rdi -1343541856)
             (set! r15 L.rp.2)
             (jump L.func.0.1)))
         (set! rbp (+ rbp 24)))
       (set! r15 rax)
       (if (begin (set! r15 0) (true))
         (if (begin (set! r15 1346978436) (= r15 (rbp - 8)))
           (begin (set! rax 0) (jump (rbp - 0)))
           (begin (set! rax (rbp - 8)) (jump (rbp - 0))))
         (begin
           (set! r8 (rbp - 16))
           (set! rcx 9223372036854775807)
           (set! rdx 1)
           (set! rsi (rbp - 8))
           (set! rdi -1402588641)
           (set! r15 (rbp - 0))
           (jump L.func.0.1)))))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 824269768) (true))
       (set! r14 -9223372036854775808)
       (set! r14 709343632))
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 -356902212)
     (set! r14 -979281755)
     (set! r14 (+ r14 9223372036854775807))
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.tmp.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! rdx r14)
       (set! rsi 182548382)
       (set! rdi 0)
       (set! r15 r15)
       (jump L.tmp.0.1)))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 1) (false))
       (begin (set! rax -9223372036854775808) (jump r15))
       (begin (set! rax 0) (jump r15))))))
(check-by-interp '(module
   (define L.x.0.1
     (begin
       (set! (rbp - 0) r15)
       (set! r15 rdi)
       (set! (rbp - 16) rsi)
       (set! (rbp - 8) rdx)
       (set! r15 rcx)
       (set! r14 r8)
       (if (not (<= (rbp - 8) 9223372036854775807))
         (begin
           (set! r14 -18835826)
           (set! r14 r14)
           (if (>= (rbp - 8) r15)
             (begin (set! rax (rbp - 8)) (jump (rbp - 0)))
             (begin (set! rax (rbp - 16)) (jump (rbp - 0)))))
         (begin
           (begin
             (set! rbp (- rbp 24))
             (return-point L.rp.3
               (begin
                 (set! r8 0)
                 (set! rcx r14)
                 (set! rdx (rbp - -16))
                 (set! rsi 9223372036854775807)
                 (set! rdi r14)
                 (set! r15 L.rp.3)
                 (jump L.x.0.1)))
             (set! rbp (+ rbp 24)))
           (set! r15 rax)
           (if (<= (rbp - 16) -186024487)
             (begin (set! rax r15) (jump (rbp - 0)))
             (begin (set! rax (rbp - 8)) (jump (rbp - 0))))))))
   (define L.func.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 -932453002)
       (if (begin (set! r9 -1133252869) (false))
         (set! r14 479665611)
         (set! r14 r14))
       (set! r14 r13)
       (set! rax r13)
       (jump r15)))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 1588211020) (true))
       (begin (set! rax 9223372036854775807) (jump r15))
       (begin (set! rax -9223372036854775808) (jump r15))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (if (begin (set! r14 1) (true))
       (begin (set! rax 234292566) (jump r15))
       (begin (set! rax -1579825632) (jump r15))))))
(check-by-interp '(module (begin (set! r15 r15) (set! rax 1) (jump r15))))
(check-by-interp '(module
   (define L.fn.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r14 r14)
       (set! r14 0)
       (set! r14 (* r14 0))
       (set! rax r14)
       (jump r15)))
   (define L.fn.1.2
     (begin
       (set! r15 r15)
       (if (begin (set! r14 -9223372036854775808) (false))
         (begin (set! rax -1098447432) (jump r15))
         (begin
           (set! r14 -9223372036854775808)
           (set! r14 (+ r14 -9223372036854775808))
           (set! r14 r14)
           (if (begin (set! r14 857729561) (true))
             (begin (set! rax 9223372036854775807) (jump r15))
             (begin (set! rax 1) (jump r15)))))))
   (define L.fn.2.3
     (begin
       (set! r15 r15)
       (set! r13 rdi)
       (set! r14 rsi)
       (set! rdi rdx)
       (set! rdi rcx)
       (set! r8 r8)
       (set! r9 r9)
       (set! r8 (rbp - 0))
       (begin (set! r14 r9) (set! r14 (* r14 rdi)) (set! rax r14) (jump r15))))
   (begin
     (set! r15 r15)
     (if (begin
           (begin
             (set! r14 1)
             (set! r14 -9223372036854775808)
             (set! r14 r14)
             (set! r14 9223372036854775807))
           (begin (set! r13 -1195644570) (false)))
       (begin
         (set! (rbp - 0) 0)
         (set! r9 9223372036854775807)
         (set! r8 -2036437657)
         (set! rcx 0)
         (set! rdx 0)
         (set! rsi -1663007716)
         (set! rdi 1453047515)
         (set! r15 r15)
         (jump L.fn.2.3))
       (begin
         (set! rsi -1792916675)
         (set! rdi 1)
         (set! r15 r15)
         (jump L.fn.0.1))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (if (begin (set! r14 -9223372036854775808) (false))
       (begin
         (if (begin (set! r14 1) (true))
           (set! r14 9223372036854775807)
           (set! r14 463110926))
         (set! r14 0))
       (begin
         (set! r14 0)
         (set! r14 -1584028825)
         (set! r14 (- r14 -9223372036854775808))
         (set! r14 r14)))
     (if (not (> r14 1))
       (if (begin (set! r13 -9223372036854775808) (true))
         (if (> r14 491128034)
           (begin (set! rax r14) (jump r15))
           (begin (set! rax 1) (jump r15)))
         (if (begin (set! r13 1050399943) (= r13 r14))
           (begin (set! rax -1604958676) (jump r15))
           (begin (set! rax r14) (jump r15))))
       (begin (set! rax r14) (jump r15))))))
(check-by-interp '(module
   (define L.proc.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r9 rdx)
       (set! r13 rcx)
       (set! r8 r9)
       (set! rcx 9223372036854775807)
       (set! rdx r14)
       (set! rsi r13)
       (set! rdi 9223372036854775807)
       (set! r15 r15)
       (jump L.func.1.2)))
   (define L.func.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! rdi rcx)
       (set! r9 r8)
       (set! (rbp - 0) -9223372036854775808)
       (set! r9 r9)
       (set! r8 rdi)
       (set! rcx r13)
       (set! rdx r14)
       (set! rsi r13)
       (set! rdi 9223372036854775807)
       (set! r15 r15)
       (jump L.tmp.2.3)))
   (define L.tmp.2.3
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r13 rcx)
       (set! r13 r8)
       (set! r13 r9)
       (set! r13 (rbp - 0))
       (set! rax r14)
       (jump r15)))
   (begin
     (set! r15 r15)
     (begin
       (set! (rbp - 0) 1)
       (set! r9 9223372036854775807)
       (set! r8 1)
       (set! rcx -282402130)
       (set! rdx -9223372036854775808)
       (set! rsi 9223372036854775807)
       (set! rdi 1)
       (set! r15 r15)
       (jump L.tmp.2.3)))))
(check-by-interp '(module
   (define L.tmp.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r14 rcx)
       (set! r13 r8)
       (set! r13 r9)
       (set! r13 (rbp - 0))
       (set! rdx r14)
       (set! rsi 946654223)
       (set! rdi 9223372036854775807)
       (set! r15 r15)
       (jump L.func.1.2)))
   (define L.func.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! rdx 9223372036854775807)
       (set! rsi r13)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.func.1.2)))
   (define L.fn.2.3
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r9 rdx)
       (set! r9 9223372036854775807)
       (set! rdx r14)
       (set! rsi 0)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.func.1.2)))
   (begin (set! r15 r15) (set! r14 0) (set! rax 1) (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! r13 rcx)
       (set! r13 r8)
       (begin (set! rax 1) (jump r15))))
   (begin
     (set! r15 r15)
     (set! r8 1653803490)
     (set! rcx 1918330809)
     (set! rdx 1)
     (set! rsi 9223372036854775807)
     (set! rdi -9223372036854775808)
     (set! r15 r15)
     (jump L.func.0.1))))
(check-by-interp '(module
   (define L.fn.0.1
     (begin
       (set! r15 r15)
       (set! r13 rdi)
       (set! r14 rsi)
       (if (begin (set! r9 559317709) (not (= r9 r13)))
         (begin
           (set! rdx -675648818)
           (set! rsi -9223372036854775808)
           (set! rdi r14)
           (set! r15 r15)
           (jump L.func.1.2))
         (begin (set! r15 r15) (jump L.tmp.2.3)))))
   (define L.func.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r15 r15)
       (jump L.tmp.2.3)))
   (define L.tmp.2.3 (begin (set! r15 r15) (set! r15 r15) (jump L.tmp.2.3)))
   (begin (set! r15 r15) (set! rax 1) (jump r15))))
(check-by-interp '(module
   (define L.x.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r9 rdx)
       (set! r9 rcx)
       (if (= r13 r9) (set! r13 r13) (set! r13 -1012326174))
       (set! r13 0)
       (set! r13 r13)
       (set! r14 r14)
       (set! r14 (- r14 0))
       (set! rax r14)
       (jump r15)))
   (begin
     (set! r15 r15)
     (set! rcx 1259250868)
     (set! rdx 1097392993)
     (set! rsi 0)
     (set! rdi 1)
     (set! r15 r15)
     (jump L.x.0.1))))
(check-by-interp '(module
   (define L.tmp.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! r8 r13)
       (set! rcx 1)
       (set! rdx r14)
       (set! rsi -1620042780)
       (set! rdi 0)
       (set! r15 r15)
       (jump L.x.1.2)))
   (define L.x.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r14 rcx)
       (set! r13 r8)
       (set! r13 9223372036854775807)
       (set! r13 -9223372036854775808)
       (set! r13 (+ r13 r14))
       (set! rax r13)
       (jump r15)))
   (begin
     (set! r15 r15)
     (set! r8 0)
     (set! rcx 1)
     (set! rdx 9223372036854775807)
     (set! rsi -913438169)
     (set! rdi -1611188905)
     (set! r15 r15)
     (jump L.x.1.2))))
(check-by-interp '(module
   (define L.tmp.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! r9 rcx)
       (set! rcx r13)
       (set! rdx r13)
       (set! rsi r13)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.tmp.0.1)))
   (begin
     (set! (rbp - 0) r15)
     (begin
       (set! r15 1326448876)
       (set! r15 (- r15 360169641))
       (set! rax r15)
       (jump (rbp - 0))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 1)
     (set! r14 r14)
     (set! r14 r14)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r14 1903463490)
       (set! r14 (* r14 -9223372036854775808))
       (set! rax r14)
       (jump r15)))
   (define L.func.1.2
     (begin
       (set! r15 r15)
       (set! r9 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! r8 rcx)
       (set! rdi -9223372036854775808)
       (set! rdi (- rdi r9))
       (set! rdi rdi)
       (if (begin (set! r9 9223372036854775807) (> r9 r13))
         (if (< r14 r8)
           (begin (set! rax rdi) (jump r15))
           (begin (set! rax r14) (jump r15)))
         (if (>= r8 1408489810)
           (begin (set! rax rdi) (jump r15))
           (begin (set! rax r14) (jump r15))))))
   (begin
     (set! r15 r15)
     (set! r14 977777990)
     (set! r14 (* r14 900224161))
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.x.0.1
     (begin
       (set! (rbp - 0) r15)
       (if (begin (set! r15 0) (true))
         (begin
           (begin
             (set! rbp (- rbp 8))
             (return-point L.rp.4
               (begin
                 (set! rdi 1456910402)
                 (set! r15 L.rp.4)
                 (jump L.tmp.2.3)))
             (set! rbp (+ rbp 8)))
           (set! r15 rax)
           (set! r15 -9223372036854775808)
           (set! rax 1)
           (jump (rbp - 0)))
         (begin
           (set! rdi -9223372036854775808)
           (set! r15 (rbp - 0))
           (jump L.tmp.2.3)))))
   (define L.fn.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r13 rcx)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.tmp.2.3)))
   (define L.tmp.2.3
     (begin (set! r15 r15) (set! r14 rdi) (set! rax r14) (jump r15)))
   (begin (set! r15 r15) (set! rdi 0) (set! r15 r15) (jump L.tmp.2.3))))
(check-by-interp '(module
   (define L.fn.0.1
     (begin
       (set! r15 r15)
       (set! r13 rdi)
       (set! r14 rsi)
       (set! r13 r13)
       (set! r9 r13)
       (set! r9 (+ r9 r13))
       (set! r13 r9)
       (set! rsi r14)
       (set! rdi 0)
       (set! r15 r15)
       (jump L.fn.0.1)))
   (define L.tmp.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r9 rsi)
       (set! r13 rdx)
       (set! rdi rcx)
       (set! r8 r8)
       (if (< r8 r14)
         (begin
           (if (begin (set! r9 167876306) (<= r9 r14))
             (set! r14 44784438)
             (set! r14 -874603706))
           (set! r8 r13)
           (set! rcx r13)
           (set! rdx 0)
           (set! rsi 696038140)
           (set! rdi -9223372036854775808)
           (set! r15 r15)
           (jump L.tmp.1.2))
         (if (begin (set! r8 r8) (= rdi 0))
           (if (< r13 r13)
             (begin (set! rax r9) (jump r15))
             (begin (set! rax -727094500) (jump r15)))
           (begin
             (set! rsi -9223372036854775808)
             (set! rdi r14)
             (set! r15 r15)
             (jump L.fn.0.1))))))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 9223372036854775807) (false))
       (set! r14 0)
       (set! r14 93609173))
     (set! r14 r14)
     (set! r14 r14)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 -9223372036854775808)
     (set! r14 0)
     (set! r13 r14)
     (if (begin (set! r14 r13) (begin (set! r14 1) (false)))
       (begin (set! rax r13) (jump r15))
       (begin (set! r14 r13) (set! rax 1974766267) (jump r15))))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r14 rcx)
       (set! r14 r8)
       (set! r14 r9)
       (set! r13 -951184591)
       (begin (set! r13 310790521) (set! rax r14) (jump r15))))
   (begin
     (set! r15 r15)
     (set! r14 -1379426851)
     (set! rax 488563830)
     (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r8 rdx)
       (if (if (begin (set! r9 0) (= r9 r14))
             (false)
             (if (<= r8 -483103791) (= r13 r14) (= r14 r13)))
         (begin
           (set! rdx 1)
           (set! rsi 1)
           (set! rdi r13)
           (set! r15 r15)
           (jump L.func.0.1))
         (begin (set! r14 r14) (set! rax r14) (jump r15)))))
   (begin
     (set! r15 r15)
     (set! r14 -1766715399)
     (begin (set! r14 0) (set! r14 (* r14 0)) (set! rax r14) (jump r15)))))
(check-by-interp '(module
   (define L.tmp.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! rdi 9223372036854775807)
       (set! r15 r15)
       (jump L.fn.1.2)))
   (define L.fn.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (if (begin (set! r13 1) (false))
         (begin
           (set! rdx -9223372036854775808)
           (set! rsi -9223372036854775808)
           (set! rdi r14)
           (set! r15 r15)
           (jump L.x.2.3))
         (if (if (> r14 9223372036854775807)
               (<= r14 2069349298)
               (begin (set! r13 327435684) (= r13 r14)))
           (begin
             (set! rdx r14)
             (set! rsi r14)
             (set! rdi 937688474)
             (set! r15 r15)
             (jump L.x.2.3))
           (begin (set! rax -9223372036854775808) (jump r15))))))
   (define L.x.2.3
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! rdx r13)
       (set! rsi -845528888)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.x.2.3)))
   (begin (set! r15 r15) (set! r14 0) (set! rax r14) (jump r15))))
(check-by-interp '(module
   (define L.x.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! r9 rcx)
       (set! r9 r8)
       (if (begin (set! r14 -9223372036854775808) (true))
         (begin (set! rax 0) (jump r15))
         (begin (set! rax 849007740) (jump r15)))))
   (define L.x.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 r13)
       (set! r8 9223372036854775807)
       (set! rcx 0)
       (set! rdx r13)
       (set! rsi 0)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.x.0.1)))
   (define L.x.2.3
     (begin
       (set! (rbp - 0) r15)
       (set! r15 rdi)
       (set! r15 rsi)
       (set! r15 rdx)
       (set! r15 rcx)
       (set! r15 r8)
       (begin
         (set! rbp (- rbp 8))
         (return-point L.rp.4
           (begin
             (set! rsi r15)
             (set! rdi r15)
             (set! r15 L.rp.4)
             (jump L.x.1.2)))
         (set! rbp (+ rbp 8)))
       (set! r15 rax)
       (set! rsi 1)
       (set! rdi -1927041153)
       (set! r15 (rbp - 0))
       (jump L.x.1.2)))
   (begin
     (set! r15 r15)
     (set! r14 1)
     (set! r14 (* r14 -394936001))
     (set! r14 r14)
     (set! r8 r14)
     (set! rcx -9223372036854775808)
     (set! rdx 0)
     (set! rsi r14)
     (set! rdi r14)
     (set! r15 r15)
     (jump L.x.0.1))))
(check-by-interp '(module
   (define L.tmp.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r14 rcx)
       (set! r14 r8)
       (set! rax r14)
       (jump r15)))
   (begin
     (set! (rbp - 0) r15)
     (begin
       (set! rbp (- rbp 8))
       (return-point L.rp.2
         (begin
           (set! r8 -9223372036854775808)
           (set! rcx 1)
           (set! rdx 0)
           (set! rsi -9223372036854775808)
           (set! rdi 1)
           (set! r15 L.rp.2)
           (jump L.tmp.0.1)))
       (set! rbp (+ rbp 8)))
     (set! r14 rax)
     (if (begin (set! r15 -9223372036854775808) (false))
       (begin (set! rax -1855219983) (jump (rbp - 0)))
       (begin (set! rax r14) (jump (rbp - 0)))))))
(check-by-interp '(module
   (define L.proc.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (if (begin
             (set! r13 1541307282)
             (begin (set! r13 9223372036854775807) (false)))
         (begin (set! r14 r14) (set! r14 (- r14 -1702731989)) (set! r14 r14))
         (begin (set! r14 r14) (set! r14 r14)))
       (if (not (begin (set! r13 -9223372036854775808) (= r13 r14)))
         (begin (set! r13 1) (set! rax r14) (jump r15))
         (begin (set! rdi 0) (set! r15 r15) (jump L.proc.0.1)))))
   (define L.fn.1.2
     (begin
       (set! r15 r15)
       (set! r14 9223372036854775807)
       (set! r14 (+ r14 1))
       (set! rax r14)
       (jump r15)))
   (define L.fn.2.3
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 1)
       (set! r14 (* r14 0))
       (set! r14 r14)
       (set! r15 r15)
       (jump L.fn.1.2)))
   (begin
     (set! (rbp - 0) r15)
     (begin
       (begin
         (set! rbp (- rbp 8))
         (return-point L.rp.4
           (begin (set! rdi 1) (set! r15 L.rp.4) (jump L.fn.2.3)))
         (set! rbp (+ rbp 8)))
       (set! r15 rax)
       (set! r15 r15)
       (set! rax 1)
       (jump (rbp - 0))))))
(check-by-interp '(module
   (define L.x.0.1
     (begin
       (set! (rbp - 0) r15)
       (set! r15 rdi)
       (set! r15 rsi)
       (set! r15 rdx)
       (set! (rbp - 8) rcx)
       (set! r14 r8)
       (begin
         (set! rbp (- rbp 16))
         (return-point L.rp.4
           (begin
             (set! r8 1)
             (set! rcx r15)
             (set! rdx r14)
             (set! rsi r14)
             (set! rdi 0)
             (set! r15 L.rp.4)
             (jump L.x.0.1)))
         (set! rbp (+ rbp 16)))
       (set! r15 rax)
       (set! r15 r15)
       (set! r15 (- r15 r15))
       (set! r15 r15)
       (begin
         (set! r15 -9223372036854775808)
         (set! r15 (* r15 (rbp - 8)))
         (set! rax r15)
         (jump (rbp - 0)))))
   (define L.fn.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! r9 rcx)
       (set! r8 r8)
       (begin (set! r14 r13) (set! rax 1) (jump r15))))
   (define L.tmp.2.3
     (begin
       (set! r15 r15)
       (set! r14 1)
       (set! r14 r14)
       (if (if (begin (set! r13 9223372036854775807) (true)) (false) (true))
         (begin (set! rax r14) (jump r15))
         (begin
           (set! r8 9223372036854775807)
           (set! rcx r14)
           (set! rdx r14)
           (set! rsi -126978532)
           (set! rdi r14)
           (set! r15 r15)
           (jump L.x.0.1)))))
   (begin
     (set! r15 r15)
     (set! r14 -1293429216)
     (set! r14 (* r14 880066208))
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.proc.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! rdi rdx)
       (set! rsi rcx)
       (set! r8 r8)
       (set! rdi r9)
       (if (not
            (if (begin (set! r9 0) (false))
              (!= rsi 9223372036854775807)
              (< rdi rdi)))
         (if (begin (set! r13 1779018832) (= r13 rdi))
           (begin (set! rax -9223372036854775808) (jump r15))
           (begin (set! rax r14) (jump r15)))
         (begin
           (set! r9 r14)
           (set! r8 r8)
           (set! rcx rsi)
           (set! rdx 9223372036854775807)
           (set! rsi rdi)
           (set! rdi 1)
           (set! r15 r15)
           (jump L.proc.0.1)))))
   (define L.proc.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r9 rdx)
       (if (begin (set! r9 -408033154) (<= r9 r14))
         (begin (set! r9 r13) (set! r9 (+ r9 r14)) (set! r9 r9))
         (begin (set! r13 r13) (set! r9 r13)))
       (set! rdx r13)
       (set! rsi r14)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.proc.1.2)))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 1) (true)) (set! r14 0) (set! r14 0))
     (set! r9 -9223372036854775808)
     (set! r8 1792291800)
     (set! rcx r14)
     (set! rdx 1961997671)
     (set! rsi r14)
     (set! rdi r14)
     (set! r15 r15)
     (jump L.proc.0.1))))
(check-by-interp '(module
   (define L.x.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! r9 rcx)
       (if (begin (set! r9 r9) (begin (set! r9 -9223372036854775808) (true)))
         (begin (set! r9 1) (set! r13 r13))
         (set! r13 r13))
       (begin (set! r14 r14) (set! rax r13) (jump r15))))
   (begin
     (set! r15 r15)
     (set! r14 480297521)
     (if (= r14 0)
       (begin
         (set! r14 r14)
         (set! r14 0)
         (set! rcx r14)
         (set! rdx 0)
         (set! rsi 9223372036854775807)
         (set! rdi 9223372036854775807)
         (set! r15 r15)
         (jump L.x.0.1))
       (if (begin (set! r13 1) (>= r14 1434817833))
         (begin
           (set! r14 -9223372036854775808)
           (set! r14 (* r14 -1655015632))
           (set! rax r14)
           (jump r15))
         (begin
           (set! r14 -9223372036854775808)
           (set! rax 1398310587)
           (jump r15)))))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! rdi rcx)
       (set! r8 r8)
       (set! r9 r9)
       (set! rsi (rbp - 0))
       (if (begin (set! rsi 9223372036854775807) (true))
         (if (if (> r13 1) (> r9 -9223372036854775808) (!= r8 -847185955))
           (begin
             (set! (rbp - 0) -260761950)
             (set! r9 0)
             (set! r8 -9223372036854775808)
             (set! rcx rdi)
             (set! rdx r14)
             (set! rsi -144908363)
             (set! rdi 9223372036854775807)
             (set! r15 r15)
             (jump L.func.0.1))
           (if (> rdi rdi)
             (begin (set! rax 0) (jump r15))
             (begin (set! rax 1) (jump r15))))
         (begin
           (set! r13 9223372036854775807)
           (set! (rbp - 0) 0)
           (set! r9 r14)
           (set! r8 r14)
           (set! rcx 9223372036854775807)
           (set! rdx -9223372036854775808)
           (set! rsi -472335653)
           (set! rdi -9223372036854775808)
           (set! r15 r15)
           (jump L.func.0.1)))))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 1) (false))
       (begin (set! r14 1) (set! rax r14) (jump r15))
       (begin (set! rax -32529780) (jump r15))))))
(check-by-interp '(module
   (define L.proc.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r14 rcx)
       (set! r14 r8)
       (set! r14 r9)
       (set! r14 (rbp - 0))
       (set! r15 r15)
       (jump L.tmp.1.2)))
   (define L.tmp.1.2
     (begin
       (set! r15 r15)
       (set! rsi 0)
       (set! rdi 0)
       (set! r15 r15)
       (jump L.proc.2.3)))
   (define L.proc.2.3
     (begin
       (set! r15 r15)
       (set! r13 rdi)
       (set! r14 rsi)
       (set! (rbp - 0) 1635273112)
       (set! r9 r13)
       (set! r8 r14)
       (set! rcx r13)
       (set! rdx 445965252)
       (set! rsi r13)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.proc.0.1)))
   (begin
     (set! r15 r15)
     (if (if (begin (set! r14 9223372036854775807) (false))
           (begin (set! r14 692968731) (false))
           (begin (set! r14 -1490931083) (true)))
       (begin (set! rax 1275113131) (jump r15))
       (if (begin (set! r14 -1702177019) (false))
         (begin (set! rax 0) (jump r15))
         (begin (set! rax 1843455920) (jump r15)))))))
(check-by-interp '(module
   (define L.fn.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! rdi rcx)
       (set! r13 r8)
       (set! r13 r9)
       (set! r9 (rbp - 0))
       (set! (rbp - 0) r13)
       (set! r9 rdi)
       (set! r8 rdi)
       (set! rcx 9223372036854775807)
       (set! rdx r14)
       (set! rsi -9223372036854775808)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.fn.0.1)))
   (begin
     (set! r15 r15)
     (set! r14 9223372036854775807)
     (set! r14 9223372036854775807)
     (set! r13 9223372036854775807)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! (rbp - 0) r15)
       (set! r14 rdi)
       (set! r15 rsi)
       (set! r15 rdx)
       (set! r13 rcx)
       (set! (rbp - 8) r8)
       (begin
         (set! r14 r14)
         (begin
           (set! rbp (- rbp 16))
           (return-point L.rp.3
             (begin
               (set! rdx -1140169546)
               (set! rsi r13)
               (set! rdi r15)
               (set! r15 L.rp.3)
               (jump L.func.1.2)))
           (set! rbp (+ rbp 16)))
         (set! r15 rax)
         (set! r14 (rbp - 8))
         (set! r14 (+ r14 r15))
         (set! rax r14)
         (jump (rbp - 0)))))
   (define L.func.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r8 rdx)
       (if (begin (set! r9 9223372036854775807) (true))
         (begin
           (set! rdx r8)
           (set! rsi r8)
           (set! rdi r14)
           (set! r15 r15)
           (jump L.func.1.2))
         (begin
           (set! r14 -9223372036854775808)
           (set! r14 (+ r14 r13))
           (set! rax r14)
           (jump r15)))))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 9223372036854775807) (false))
       (begin (set! rax -877748660) (jump r15))
       (begin (set! rax -9223372036854775808) (jump r15))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 -1640821439)
     (set! r14 (+ r14 -406700566))
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.fn.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r9 r14)
       (set! r8 r13)
       (set! rcx -9223372036854775808)
       (set! rdx r13)
       (set! rsi r14)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.x.1.2)))
   (define L.x.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r14 rcx)
       (set! r13 r8)
       (set! r13 r9)
       (set! r9 r14)
       (set! r8 1)
       (set! rcx -984231193)
       (set! rdx r13)
       (set! rsi r13)
       (set! rdi 933807622)
       (set! r15 r15)
       (jump L.x.1.2)))
   (begin
     (set! r15 r15)
     (set! r14 -477286222)
     (set! r14 0)
     (set! rax 643069821)
     (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (if (!= r14 r14)
         (begin (set! rdi 2058053814) (set! r15 r15) (jump L.func.0.1))
         (begin
           (set! r13 r14)
           (set! r13 (- r13 r14))
           (set! r13 r13)
           (set! r14 r14)
           (set! r14 r14)
           (set! r14 r14)
           (set! r13 r14)
           (set! rdi r14)
           (set! r15 r15)
           (jump L.x.2.3)))))
   (define L.tmp.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.x.2.3)))
   (define L.x.2.3
     (begin
       (set! (rbp - 0) r15)
       (set! r15 rdi)
       (begin
         (set! rbp (- rbp 8))
         (return-point L.rp.4
           (begin
             (set! rdx -1942673900)
             (set! rsi r15)
             (set! rdi r15)
             (set! r15 L.rp.4)
             (jump L.tmp.1.2)))
         (set! rbp (+ rbp 8)))
       (set! r15 rax)
       (if (begin (set! r15 r15) (set! r15 r15) (set! r15 r15) (= r15 r15))
         (begin
           (set! rdx -1386061378)
           (set! rsi r15)
           (set! rdi r15)
           (set! r15 (rbp - 0))
           (jump L.tmp.1.2))
         (begin (set! rdi r15) (set! r15 (rbp - 0)) (jump L.func.0.1)))))
   (begin
     (set! r15 r15)
     (begin
       (set! r14 9223372036854775807)
       (set! r14 (+ r14 -9223372036854775808))
       (set! rax r14)
       (jump r15)))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (if (begin (set! r14 1) (false))
       (begin (set! rax 2012039291) (jump r15))
       (begin (set! rax 9223372036854775807) (jump r15))))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! rdi rcx)
       (set! r8 r8)
       (set! r9 r9)
       (set! r14 r14)
       (set! r14 (- r14 r13))
       (set! rax r14)
       (jump r15)))
   (define L.proc.1.2
     (begin
       (set! (rbp - 0) r15)
       (set! r15 9223372036854775807)
       (set! r15 (+ r15 1))
       (set! (rbp - 8) r15)
       (begin
         (set! rbp (- rbp 16))
         (return-point L.rp.4
           (begin
             (set! r9 (rbp - -8))
             (set! r8 (rbp - -8))
             (set! rcx (rbp - -8))
             (set! rdx (rbp - -8))
             (set! rsi (rbp - -8))
             (set! rdi 0)
             (set! r15 L.rp.4)
             (jump L.func.0.1)))
         (set! rbp (+ rbp 16)))
       (set! r15 rax)
       (set! r14 (rbp - 8))
       (if (>= (rbp - 8) (rbp - 8)) (set! r14 (rbp - 8)) (set! r14 (rbp - 8)))
       (set! r15 r15)
       (set! r15 r15)
       (set! r15 -9223372036854775808)
       (set! rax 9223372036854775807)
       (jump (rbp - 0))))
   (define L.func.2.3
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r9 rdx)
       (set! r9 rcx)
       (set! r13 r13)
       (set! r9 r9)
       (set! r9 r9)
       (set! r8 r13)
       (if (>= r13 r9)
         (begin (set! rax r13) (jump r15))
         (begin (set! rax r14) (jump r15)))))
   (begin
     (set! r15 r15)
     (set! rcx 9223372036854775807)
     (set! rdx -1735352110)
     (set! rsi 9223372036854775807)
     (set! rdi 0)
     (set! r15 r15)
     (jump L.func.2.3))))
(check-by-interp '(module
   (define L.x.0.1
     (begin
       (set! (rbp - 8) r15)
       (set! r15 rdi)
       (set! (rbp - 24) rsi)
       (set! r14 rdx)
       (set! (rbp - 32) rcx)
       (set! (rbp - 16) r8)
       (set! r13 r9)
       (set! r14 (rbp - 0))
       (begin
         (set! rbp (- rbp 40))
         (return-point L.rp.3
           (begin
             (set! (rbp - 0) r13)
             (set! r9 r15)
             (set! r8 r13)
             (set! rcx 0)
             (set! rdx r14)
             (set! rsi (rbp - -8))
             (set! rdi (rbp - -8))
             (set! r15 L.rp.3)
             (jump L.fn.1.2)))
         (set! rbp (+ rbp 40)))
       (set! r15 rax)
       (if (not (begin (set! r14 0) (false)))
         (begin
           (set! r14 (rbp - 16))
           (set! r14 (+ r14 r15))
           (set! rax r14)
           (jump (rbp - 8)))
         (if (<= (rbp - 32) 0)
           (begin (set! rax (rbp - 32)) (jump (rbp - 8)))
           (begin (set! rax (rbp - 24)) (jump (rbp - 8)))))))
   (define L.fn.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! r13 rcx)
       (set! r8 r8)
       (set! r8 r9)
       (set! r9 (rbp - 0))
       (set! (rbp - 0) 0)
       (set! r9 r14)
       (set! r8 r8)
       (set! rcx -9223372036854775808)
       (set! rdx r14)
       (set! rsi r8)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.fn.1.2)))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 -9223372036854775808) (false))
       (begin (set! rax -9223372036854775808) (jump r15))
       (begin (set! rax 0) (jump r15))))))
(check-by-interp '(module (begin (set! r15 r15) (set! rax 9223372036854775807) (jump r15))))
(check-by-interp '(module
   (define L.proc.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! rdi rcx)
       (set! r13 r8)
       (set! r9 r9)
       (set! r9 rdi)
       (set! r8 r14)
       (set! rcx -635532414)
       (set! rdx r13)
       (set! rsi r13)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.proc.0.1)))
   (define L.tmp.1.2
     (begin
       (set! (rbp - 8) r15)
       (set! (rbp - 24) rdi)
       (set! (rbp - 0) rsi)
       (set! (rbp - 32) rdx)
       (set! (rbp - 40) rcx)
       (set! (rbp - 16) r8)
       (begin
         (set! rbp (- rbp 56))
         (return-point L.rp.4
           (begin
             (set! r8 (rbp - -40))
             (set! rcx (rbp - -16))
             (set! rdx (rbp - -32))
             (set! rsi (rbp - -40))
             (set! rdi (rbp - -16))
             (set! r15 L.rp.4)
             (jump L.tmp.1.2)))
         (set! rbp (+ rbp 56)))
       (set! (rbp - 48) rax)
       (begin
         (set! rbp (- rbp 56))
         (return-point L.rp.5
           (begin
             (set! (rbp - 0) (rbp - -40))
             (set! r9 (rbp - -24))
             (set! r8 (rbp - -16))
             (set! rcx -501684781)
             (set! rdx (rbp - -40))
             (set! rsi 9223372036854775807)
             (set! rdi (rbp - -56))
             (set! r15 L.rp.5)
             (jump L.func.2.3)))
         (set! rbp (+ rbp 56)))
       (set! r15 rax)
       (set! r15 (rbp - 0))
       (begin
         (set! rbp (- rbp 56))
         (return-point L.rp.6
           (begin
             (set! (rbp - 0) (rbp - -32))
             (set! r9 (rbp - -56))
             (set! r8 (rbp - -24))
             (set! rcx -9223372036854775808)
             (set! rdx (rbp - -40))
             (set! rsi 1644735104)
             (set! rdi (rbp - -32))
             (set! r15 L.rp.6)
             (jump L.func.2.3)))
         (set! rbp (+ rbp 56)))
       (set! r15 rax)
       (set! r14 (rbp - 48))
       (set! r14 (- r14 (rbp - 48)))
       (set! r14 r14)
       (if (= (rbp - 48) r15) (set! r14 r15) (set! r14 (rbp - 48)))
       (set! (rbp - 0) r15)
       (set! r9 -9223372036854775808)
       (set! r8 (rbp - 24))
       (set! rcx r14)
       (set! rdx (rbp - 16))
       (set! rsi (rbp - 16))
       (set! rdi r15)
       (set! r15 (rbp - 8))
       (jump L.func.2.3)))
   (define L.func.2.3
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r13 rcx)
       (set! r14 r8)
       (set! r9 r9)
       (set! r8 (rbp - 0))
       (set! (rbp - 0) 9223372036854775807)
       (set! r9 r13)
       (set! r8 r8)
       (set! rcx r8)
       (set! rdx r13)
       (set! rsi -9223372036854775808)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.func.2.3)))
   (begin
     (set! r15 r15)
     (set! r14 -9223372036854775808)
     (set! r13 9223372036854775807)
     (set! r13 9223372036854775807)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! (rbp - 0) r15)
       (set! r15 rdi)
       (set! (rbp - 16) rsi)
       (set! (rbp - 24) rdx)
       (set! (rbp - 32) rcx)
       (set! (rbp - 8) r8)
       (if (begin
             (set! r14 (rbp - 24))
             (if (<= (rbp - 32) (rbp - 8))
               (set! r14 (rbp - 32))
               (set! r14 (rbp - 8)))
             (begin
               (begin
                 (set! rbp (- rbp 40))
                 (return-point L.rp.3
                   (begin
                     (set! r8 (rbp - -32))
                     (set! rcx r15)
                     (set! rdx r15)
                     (set! rsi (rbp - -16))
                     (set! rdi 1)
                     (set! r15 L.rp.3)
                     (jump L.func.0.1)))
                 (set! rbp (+ rbp 40)))
               (set! r15 rax))
             (false))
         (begin
           (set! r8 0)
           (set! rcx (rbp - 24))
           (set! rdx 1603961181)
           (set! rsi (rbp - 16))
           (set! rdi (rbp - 8))
           (set! r15 (rbp - 0))
           (jump L.func.0.1))
         (begin
           (set! r9 (rbp - 32))
           (set! r8 (rbp - 8))
           (set! rcx (rbp - 16))
           (set! rdx (rbp - 8))
           (set! rsi -9223372036854775808)
           (set! rdi (rbp - 16))
           (set! r15 (rbp - 0))
           (jump L.fn.1.2)))))
   (define L.fn.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! rdi rsi)
       (set! rsi rdx)
       (set! rdx rcx)
       (set! r13 r8)
       (set! r9 r9)
       (if (if (>= r13 r14) (> rdi -9223372036854775808) (>= rsi r13))
         (begin
           (set! r9 rdx)
           (set! r9 9223372036854775807)
           (set! r14 r14)
           (set! rax r13)
           (jump r15))
         (if (< r13 r14)
           (begin (set! rax rdx) (jump r15))
           (begin (set! rax rdi) (jump r15))))))
   (begin
     (set! r15 r15)
     (set! r14 405359082)
     (if (not (begin (set! r13 -915730633) (false)))
       (begin (set! r13 -532660031) (set! r13 -248685178))
       (set! r13 0))
     (set! r9 1254220652)
     (set! r9 r14)
     (set! r8 r13)
     (set! rcx 9223372036854775807)
     (set! rdx r13)
     (set! rsi r13)
     (set! rdi -9223372036854775808)
     (set! r15 r15)
     (jump L.fn.1.2))))
(check-by-interp '(module
   (define L.proc.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r13 rcx)
       (set! r13 r8)
       (set! r8 1)
       (set! rcx -1754605622)
       (set! rdx -675715652)
       (set! rsi r14)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.proc.0.1)))
   (define L.func.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r8 r13)
       (set! rcx r13)
       (set! rdx r14)
       (set! rsi r14)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.proc.0.1)))
   (define L.x.2.3
     (begin
       (set! (rbp - 8) r15)
       (set! (rbp - 32) rdi)
       (set! r14 rsi)
       (set! r15 rdx)
       (set! (rbp - 24) rcx)
       (set! r13 r8)
       (set! r9 r9)
       (set! (rbp - 16) (rbp - 0))
       (if (>= (rbp - 24) (rbp - 16))
         (set! r15 r14)
         (begin
           (begin
             (set! rbp (- rbp 40))
             (return-point L.rp.4
               (begin
                 (set! (rbp - 0) 1783645727)
                 (set! r9 r9)
                 (set! r8 (rbp - -16))
                 (set! rcx r13)
                 (set! rdx 0)
                 (set! rsi r15)
                 (set! rdi 1)
                 (set! r15 L.rp.4)
                 (jump L.x.2.3)))
             (set! rbp (+ rbp 40)))
           (set! r15 rax)))
       (set! r15 (rbp - 24))
       (set! r15 (* r15 (rbp - 24)))
       (set! r15 r15)
       (set! (rbp - 0) (rbp - 24))
       (set! r9 (rbp - 32))
       (set! r8 -922337918)
       (set! rcx (rbp - 16))
       (set! rdx (rbp - 16))
       (set! rsi (rbp - 24))
       (set! rdi (rbp - 16))
       (set! r15 (rbp - 8))
       (jump L.x.2.3)))
   (begin
     (set! r15 r15)
     (set! r14 0)
     (set! r13 1029279872)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (if (if (begin (set! r14 1) (set! r13 -1606724555) (true))
           (begin
             (set! r14 1)
             (set! r13 1)
             (set! r13 -9223372036854775808)
             (true))
           (begin (begin (set! r14 -1879829070) (true))))
       (begin
         (set! r14 -634246165)
         (set! r14 (- r14 -684848771))
         (set! rax r14)
         (jump r15))
       (begin (set! rax 0) (jump r15))))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! rdx r14)
       (set! rsi -1803672217)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.proc.1.2)))
   (define L.proc.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! rdx r13)
       (set! rsi r14)
       (set! rdi 1)
       (set! r15 r15)
       (jump L.proc.1.2)))
   (begin (set! r15 r15) (set! r14 0) (set! rax r14) (jump r15))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 1550347185)
     (set! r14 9223372036854775807)
     (set! r13 -9223372036854775808)
     (set! r14 r14)
     (set! r14 r14)
     (set! r13 9223372036854775807)
     (set! r13 (- r13 r14))
     (set! rax r13)
     (jump r15))))
(check-by-interp '(module
   (define L.proc.0.1
     (begin
       (set! (rbp - 0) r15)
       (set! (rbp - 24) rdi)
       (set! (rbp - 16) rsi)
       (set! (rbp - 8) rdx)
       (begin
         (set! rbp (- rbp 56))
         (return-point L.rp.2
           (begin
             (set! rdx (rbp - -48))
             (set! rsi (rbp - -48))
             (set! rdi 9223372036854775807)
             (set! r15 L.rp.2)
             (jump L.proc.0.1)))
         (set! rbp (+ rbp 56)))
       (set! (rbp - 40) rax)
       (begin
         (set! rbp (- rbp 56))
         (return-point L.rp.3
           (begin
             (set! rdx (rbp - -32))
             (set! rsi (rbp - -48))
             (set! rdi (rbp - -32))
             (set! r15 L.rp.3)
             (jump L.proc.0.1)))
         (set! rbp (+ rbp 56)))
       (set! (rbp - 32) rax)
       (begin
         (set! rbp (- rbp 56))
         (return-point L.rp.4
           (begin
             (set! rdx (rbp - -32))
             (set! rsi (rbp - -48))
             (set! rdi (rbp - -48))
             (set! r15 L.rp.4)
             (jump L.proc.0.1)))
         (set! rbp (+ rbp 56)))
       (set! (rbp - 24) rax)
       (set! r15 (rbp - 16))
       (begin
         (set! rbp (- rbp 56))
         (return-point L.rp.5
           (begin
             (set! rdx (rbp - -40))
             (set! rsi (rbp - -48))
             (set! rdi (rbp - -48))
             (set! r15 L.rp.5)
             (jump L.proc.0.1)))
         (set! rbp (+ rbp 56)))
       (set! r15 rax)
       (begin
         (set! rbp (- rbp 56))
         (return-point L.rp.6
           (begin
             (set! rdx (rbp - -32))
             (set! rsi r15)
             (set! rdi r15)
             (set! r15 L.rp.6)
             (jump L.proc.0.1)))
         (set! rbp (+ rbp 56)))
       (set! r15 rax)
       (if (> r15 (rbp - 8))
         (if (>= (rbp - 40) (rbp - 40))
           (begin (set! rax (rbp - 8)) (jump (rbp - 0)))
           (begin (set! rax r15) (jump (rbp - 0))))
         (begin
           (set! r15 -2087609688)
           (set! r15 (rbp - 40))
           (set! rax (rbp - 32))
           (jump (rbp - 0))))))
   (begin
     (set! r15 r15)
     (set! r14 1)
     (set! r14 -9223372036854775808)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.fn.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (begin
         (set! rcx 2099518136)
         (set! rdx r14)
         (set! rsi r14)
         (set! rdi r14)
         (set! r15 r15)
         (jump L.func.2.3))))
   (define L.tmp.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! rdi rdx)
       (set! r13 rcx)
       (set! r8 r8)
       (set! r9 r9)
       (set! r9 9223372036854775807)
       (set! r9 rdi)
       (set! r9 (+ r9 r14))
       (set! r9 r9)
       (set! r13 r13)
       (set! r13 (+ r13 r14))
       (set! r13 r13)
       (set! r14 r14)
       (set! rdi 0)
       (set! r15 r15)
       (jump L.fn.0.1)))
   (define L.func.2.3
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r8 rdx)
       (set! r13 rcx)
       (set! r9 9223372036854775807)
       (set! r8 r8)
       (set! rcx r14)
       (set! rdx r13)
       (set! rsi r13)
       (set! rdi 1)
       (set! r15 r15)
       (jump L.tmp.1.2)))
   (begin
     (set! r15 r15)
     (set! r14 1)
     (set! r14 (+ r14 9223372036854775807))
     (set! r14 r14)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (begin (set! r15 r15) (set! r14 0) (set! r14 1) (set! rax r14) (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r9 0)
       (set! r8 1)
       (set! rcx 9223372036854775807)
       (set! rdx 9223372036854775807)
       (set! rsi 1)
       (set! rdi 38797657)
       (set! r15 r15)
       (jump L.x.1.2)))
   (define L.x.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! rdi rcx)
       (set! rsi r8)
       (set! r8 r9)
       (if (if (>= rsi rsi) (< r14 rdi) (< r8 812242710))
         (begin
           (set! r14 rsi)
           (set! r14 (- r14 rdi))
           (set! rax r14)
           (jump r15))
         (begin (set! r15 r15) (jump L.func.0.1)))))
   (begin
     (set! r15 r15)
     (set! r9 -9223372036854775808)
     (set! r8 0)
     (set! rcx -9223372036854775808)
     (set! rdx -9223372036854775808)
     (set! rsi -2062025435)
     (set! rdi 0)
     (set! r15 r15)
     (jump L.x.1.2))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! r9 rcx)
       (set! rdx r13)
       (set! rsi -9223372036854775808)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.proc.1.2)))
   (define L.proc.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! r14 r14)
       (set! r14 (- r14 r13))
       (set! rax r14)
       (jump r15)))
   (begin (set! r15 r15) (set! rax 1) (jump r15))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 -550916464)
     (set! r14 9223372036854775807)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (begin
       (set! r14 9223372036854775807)
       (set! r14 (- r14 1))
       (set! rax r14)
       (jump r15)))))
(check-by-interp '(module
   (define L.tmp.0.1
     (begin
       (set! (rbp - 0) r15)
       (set! (rbp - 16) rdi)
       (set! (rbp - 8) rsi)
       (set! r15 rdx)
       (set! (rbp - 24) rcx)
       (begin
         (set! rbp (- rbp 32))
         (return-point L.rp.3
           (begin
             (set! rcx (rbp - -16))
             (set! rdx (rbp - -8))
             (set! rsi (rbp - -24))
             (set! rdi (rbp - -24))
             (set! r15 L.rp.3)
             (jump L.tmp.0.1)))
         (set! rbp (+ rbp 32)))
       (set! r15 rax)
       (set! r15 (rbp - 8))
       (set! r15 (- r15 (rbp - 24)))
       (set! r15 r15)
       (set! r15 (rbp - 8))
       (set! r15 1)
       (set! r15 (rbp - 24))
       (set! r15 (rbp - 16))
       (begin
         (set! rbp (- rbp 32))
         (return-point L.rp.4
           (begin
             (set! rdx (rbp - -16))
             (set! rsi 9223372036854775807)
             (set! rdi (rbp - -8))
             (set! r15 L.rp.4)
             (jump L.x.1.2)))
         (set! rbp (+ rbp 32)))
       (set! r15 rax)
       (set! rdx (rbp - 8))
       (set! rsi (rbp - 8))
       (set! rdi -9223372036854775808)
       (set! r15 (rbp - 0))
       (jump L.x.1.2)))
   (define L.x.1.2
     (begin
       (set! r15 r15)
       (set! r9 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (begin
         (set! rdx r13)
         (set! rsi 580696126)
         (set! rdi r13)
         (set! r15 r15)
         (jump L.x.1.2))))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 9223372036854775807) (true))
       (begin (set! rax -1677147892) (jump r15))
       (begin (set! rax 874915829) (jump r15))))))
(check-by-interp '(module
   (define L.proc.0.1
     (begin
       (set! (rbp - 8) r15)
       (set! (rbp - 40) rdi)
       (set! (rbp - 24) rsi)
       (set! (rbp - 48) rdx)
       (set! r15 rcx)
       (set! (rbp - 32) r8)
       (set! (rbp - 16) r9)
       (set! (rbp - 0) (rbp - 0))
       (if (not (> (rbp - 0) -727829088))
         (begin
           (set! r14 (rbp - 40))
           (begin
             (set! rbp (- rbp 56))
             (return-point L.rp.4
               (begin
                 (set! (rbp - 0) (rbp - -16))
                 (set! r9 (rbp - -16))
                 (set! r8 r15)
                 (set! rcx (rbp - -32))
                 (set! rdx (rbp - -8))
                 (set! rsi (rbp - -24))
                 (set! rdi (rbp - -32))
                 (set! r15 L.rp.4)
                 (jump L.proc.0.1)))
             (set! rbp (+ rbp 56)))
           (set! r15 rax)
           (begin
             (set! rbp (- rbp 56))
             (return-point L.rp.5
               (begin
                 (set! r9 (rbp - -56))
                 (set! r8 -9223372036854775808)
                 (set! rcx (rbp - -24))
                 (set! rdx 1)
                 (set! rsi (rbp - -16))
                 (set! rdi (rbp - -8))
                 (set! r15 L.rp.5)
                 (jump L.fn.1.2)))
             (set! rbp (+ rbp 56)))
           (set! r15 rax)
           (set! r15 (rbp - 24))
           (set! rax (rbp - 16))
           (jump (rbp - 8)))
         (begin (set! rax -774243080) (jump (rbp - 8))))))
   (define L.fn.1.2
     (begin
       (set! r15 r15)
       (set! rdi rdi)
       (set! r14 rsi)
       (set! rsi rdx)
       (set! rbx rcx)
       (set! r13 r8)
       (set! r8 r9)
       (if (if (if (< r13 rdi) (>= rdi rbx) (!= r14 r14))
             (if (>= r8 rbx) (< rdi rdi) (>= rsi r13))
             (not (> rbx r8)))
         (begin
           (set! r9 -1548357748)
           (set! r9 (- r9 r13))
           (set! r13 r9)
           (set! r9 r13)
           (set! r8 rsi)
           (set! rcx r14)
           (set! rdx rsi)
           (set! rsi 0)
           (set! rdi r13)
           (set! r15 r15)
           (jump L.fn.1.2))
         (begin
           (set! r9 rdi)
           (set! r8 r8)
           (set! rcx r8)
           (set! rdx r14)
           (set! rsi r13)
           (set! rdi rbx)
           (set! r15 r15)
           (jump L.fn.2.3)))))
   (define L.fn.2.3
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r13 rcx)
       (set! r14 r8)
       (set! r9 r9)
       (set! r9 0)
       (set! r8 1)
       (set! rcx r14)
       (set! rdx r13)
       (set! rsi -9223372036854775808)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.fn.2.3)))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 -534391580) (true))
       (begin (set! rax 0) (jump r15))
       (begin (set! rax 0) (jump r15))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 -1762920629)
     (set! r14 1)
     (set! r14 9223372036854775807)
     (set! rax 0)
     (jump r15))))
(check-by-interp '(module
   (define L.proc.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! rdi rdx)
       (set! rdi rcx)
       (set! r8 r8)
       (set! r9 r9)
       (set! r9 r13)
       (set! r8 r13)
       (set! rcx rdi)
       (set! rdx r14)
       (set! rsi 15882253)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.proc.0.1)))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 1038395452) (true))
       (begin (set! rax -9223372036854775808) (jump r15))
       (begin (set! rax 717010255) (jump r15))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (if (not (begin (set! r14 0) (false)))
       (if (begin (set! r14 -9223372036854775808) (false))
         (begin (set! rax 0) (jump r15))
         (begin (set! rax 9223372036854775807) (jump r15)))
       (if (begin (set! r14 -9223372036854775808) (true))
         (begin (set! rax 1) (jump r15))
         (begin (set! rax 9223372036854775807) (jump r15)))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (if (begin (set! r14 0) (true))
       (begin (set! rax 1620518798) (jump r15))
       (if (begin (set! r14 0) (true))
         (begin (set! rax 0) (jump r15))
         (begin (set! rax -9223372036854775808) (jump r15)))))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! rdx 9223372036854775807)
       (set! rsi r14)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.tmp.1.2)))
   (define L.tmp.1.2
     (begin
       (set! r15 r15)
       (set! r13 rdi)
       (set! r14 rsi)
       (set! r9 rdx)
       (begin
         (set! rdx r13)
         (set! rsi 9223372036854775807)
         (set! rdi r14)
         (set! r15 r15)
         (jump L.tmp.1.2))))
   (define L.tmp.2.3
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! rdi rdx)
       (set! rdi rcx)
       (set! r8 r8)
       (set! r9 r9)
       (set! r9 r13)
       (set! r8 r8)
       (set! rcx r14)
       (set! rdx r8)
       (set! rsi 1666412948)
       (set! rdi 273235985)
       (set! r15 r15)
       (jump L.tmp.2.3)))
   (begin
     (set! r15 r15)
     (if (begin (set! r14 -9223372036854775808) (false))
       (begin (set! rax 9223372036854775807) (jump r15))
       (begin (set! rax 1) (jump r15))))))
(check-by-interp '(module
   (define L.fn.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r9 rdx)
       (set! rdi rcx)
       (set! r9 r8)
       (set! r8 r14)
       (set! rcx rdi)
       (set! rdx r13)
       (set! rsi r14)
       (set! rdi r9)
       (set! r15 r15)
       (jump L.fn.0.1)))
   (begin (set! r15 r15) (set! rax -167685894) (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r9 r13)
       (set! r8 r13)
       (set! rcx r14)
       (set! rdx r13)
       (set! rsi r14)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.fn.2.3)))
   (define L.fn.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! rdi rsi)
       (set! r13 rdx)
       (set! r14 rcx)
       (set! r9 r8)
       (set! r9 r9)
       (set! r8 r13)
       (set! r8 (- r8 rdi))
       (set! r8 r8)
       (set! rdi r9)
       (set! r8 r8)
       (set! r13 r13)
       (set! r14 r14)
       (set! r8 r9)
       (set! rcx r14)
       (set! rdx r9)
       (set! rsi -9223372036854775808)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.fn.1.2)))
   (define L.fn.2.3
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (set! r13 rdx)
       (set! r13 rcx)
       (set! r8 r8)
       (set! r9 r9)
       (set! rsi r13)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.func.0.1)))
   (begin
     (set! r15 r15)
     (set! r14 1962527269)
     (set! r14 (+ r14 9223372036854775807))
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (if (not (> r14 r14))
         (if (= r14 r14)
           (begin (set! rax r14) (jump r15))
           (begin (set! rax r14) (jump r15)))
         (begin
           (set! rdi 9223372036854775807)
           (set! r15 r15)
           (jump L.func.0.1)))))
   (begin
     (set! r15 r15)
     (set! rdi 733499244)
     (set! r15 r15)
     (jump L.func.0.1))))
(check-by-interp '(module
   (define L.proc.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! r13 rcx)
       (set! r8 r14)
       (set! rcx 1)
       (set! rdx 0)
       (set! rsi -9223372036854775808)
       (set! rdi 835392363)
       (set! r15 r15)
       (jump L.fn.1.2)))
   (define L.fn.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! r13 rcx)
       (set! r13 r8)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.x.2.3)))
   (define L.x.2.3
     (begin
       (set! (rbp - 0) r15)
       (set! (rbp - 8) rdi)
       (begin
         (set! rbp (- rbp 16))
         (return-point L.rp.4
           (begin
             (set! rcx (rbp - -8))
             (set! rdx (rbp - -8))
             (set! rsi (rbp - -8))
             (set! rdi (rbp - -8))
             (set! r15 L.rp.4)
             (jump L.proc.0.1)))
         (set! rbp (+ rbp 16)))
       (set! r15 rax)
       (set! r15 r15)
       (set! r15 (- r15 r15))
       (set! r15 r15)
       (if (<= r15 (rbp - 8)) (set! r14 r15) (set! r14 (rbp - 8)))
       (set! r15 r15)
       (set! r14 (rbp - 8))
       (set! r14 r15)
       (set! r15 r15)
       (set! r15 (rbp - 8))
       (set! rdi r15)
       (set! r15 (rbp - 0))
       (jump L.x.2.3)))
   (begin
     (set! r15 r15)
     (set! r14 1830309714)
     (set! r13 -9223372036854775808)
     (set! r13 -9223372036854775808)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r14 rcx)
       (set! r13 r8)
       (set! rax r14)
       (jump r15)))
   (define L.func.1.2
     (begin
       (set! (rbp - 0) r15)
       (set! r15 -620373304)
       (set! r15 (- r15 -68719063))
       (set! r15 r15)
       (set! (rbp - 8) 0)
       (begin
         (set! rbp (- rbp 16))
         (return-point L.rp.4 (begin (set! r15 L.rp.4) (jump L.func.1.2)))
         (set! rbp (+ rbp 16)))
       (set! r15 rax)
       (set! rax (rbp - 8))
       (jump (rbp - 0))))
   (define L.x.2.3
     (begin (set! r15 r15) (set! r14 rdi) (set! r15 r15) (jump L.func.1.2)))
   (begin (set! r15 r15) (set! rax -575594324) (jump r15))))
(check-by-interp '(module
   (define L.x.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r14 rdx)
       (set! r14 rcx)
       (set! r13 r8)
       (set! r13 r9)
       (set! rsi 1)
       (set! rdi r14)
       (set! r15 r15)
       (jump L.x.1.2)))
   (define L.x.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r13 rsi)
       (if (<= r13 -9223372036854775808)
         (begin
           (set! r9 r14)
           (set! r8 r13)
           (set! rcx r13)
           (set! rdx r13)
           (set! rsi r14)
           (set! rdi r14)
           (set! r15 r15)
           (jump L.x.0.1))
         (begin (set! rax r13) (jump r15)))))
   (begin
     (set! r15 r15)
     (if (not (begin (set! r14 0) (false)))
       (begin
         (set! r14 996590913)
         (set! r13 299367411)
         (set! r13 -9223372036854775808)
         (set! rax r14)
         (jump r15))
       (if (begin (set! r14 894536270) (false))
         (begin (set! rax 1) (jump r15))
         (begin (set! rax 1) (jump r15)))))))
(check-by-interp '(module
   (define L.tmp.0.1
     (begin
       (set! r15 r15)
       (set! r13 rdi)
       (set! rdi rsi)
       (set! r14 rdx)
       (set! rbx rcx)
       (set! r9 r8)
       (if (<= rdi 9223372036854775807)
         (begin
           (set! (rbp - 0) rbx)
           (set! r9 -9223372036854775808)
           (set! r8 1)
           (set! rcx r14)
           (set! rdx r13)
           (set! rsi r14)
           (set! rdi rbx)
           (set! r15 r15)
           (jump L.tmp.1.2))
         (begin
           (set! r9 r9)
           (set! r13 r13)
           (set! r14 r14)
           (set! rax r14)
           (jump r15)))))
   (define L.tmp.1.2
     (begin
       (set! (rbp - 8) r15)
       (set! r15 rdi)
       (set! (rbp - 24) rsi)
       (set! r15 rdx)
       (set! r14 rcx)
       (set! (rbp - 40) r8)
       (set! (rbp - 16) r9)
       (set! (rbp - 32) (rbp - 0))
       (if (not (begin (set! r13 1242010444) (> r13 r15)))
         (begin
           (begin
             (set! rbp (- rbp 56))
             (return-point L.rp.3
               (begin
                 (set! r8 (rbp - -40))
                 (set! rcx 1)
                 (set! rdx r14)
                 (set! rsi (rbp - -40))
                 (set! rdi (rbp - -16))
                 (set! r15 L.rp.3)
                 (jump L.tmp.0.1)))
             (set! rbp (+ rbp 56)))
           (set! (rbp - 48) rax))
         (begin
           (begin
             (set! rbp (- rbp 56))
             (return-point L.rp.4
               (begin
                 (set! r8 r14)
                 (set! rcx r14)
                 (set! rdx (rbp - -32))
                 (set! rsi r15)
                 (set! rdi r15)
                 (set! r15 L.rp.4)
                 (jump L.tmp.0.1)))
             (set! rbp (+ rbp 56)))
           (set! (rbp - 48) rax)))
       (set! r15 (rbp - 32))
       (set! r15 (* r15 (rbp - 24)))
       (set! r15 r15)
       (begin
         (set! rbp (- rbp 56))
         (return-point L.rp.5
           (begin
             (set! r8 (rbp - -16))
             (set! rcx (rbp - -16))
             (set! rdx 0)
             (set! rsi (rbp - -32))
             (set! rdi (rbp - -32))
             (set! r15 L.rp.5)
             (jump L.tmp.0.1)))
         (set! rbp (+ rbp 56)))
       (set! r15 rax)
       (set! (rbp - 0) (rbp - 16))
       (set! r9 (rbp - 48))
       (set! r8 (rbp - 32))
       (set! rcx r15)
       (set! rdx 1)
       (set! rsi (rbp - 24))
       (set! rdi (rbp - 16))
       (set! r15 (rbp - 8))
       (jump L.tmp.1.2)))
   (begin
     (set! r15 r15)
     (if (not (begin (set! r14 1973720366) (false)))
       (begin (set! rax 9223372036854775807) (jump r15))
       (begin
         (set! (rbp - 0) 379193781)
         (set! r9 726597669)
         (set! r8 -264137160)
         (set! rcx -1022801227)
         (set! rdx 501537014)
         (set! rsi 9223372036854775807)
         (set! rdi 9223372036854775807)
         (set! r15 r15)
         (jump L.tmp.1.2))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r9 1521957632)
     (set! r13 -9223372036854775808)
     (set! r14 -9223372036854775808)
     (begin (set! rax 0) (jump r15)))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 -9223372036854775808)
     (set! r13 0)
     (set! r14 r14)
     (set! r14 r14)
     (set! r13 r14)
     (set! r14 r14)
     (set! r14 r14)
     (set! r13 r13)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 1)
     (begin (set! r14 r14) (set! r14 r14) (set! r14 r14) (set! r14 r14))
     (set! r13 r14)
     (set! r13 r14)
     (set! r13 (+ r13 r14))
     (set! r13 r13)
     (set! r13 r14)
     (set! r13 1648274049)
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module
   (define L.func.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! rsi r14)
       (set! rdi 1)
       (set! r15 r15)
       (jump L.func.0.1)))
   (begin (set! r15 r15) (set! rax 0) (jump r15))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (if (begin (set! r14 -9223372036854775808) (false))
       (begin (set! rax -9223372036854775808) (jump r15))
       (begin (set! rax 9223372036854775807) (jump r15))))))
(check-by-interp '(module
   (define L.fn.0.1
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! r14 rsi)
       (set! r13 rdx)
       (set! rdi rcx)
       (set! r13 r8)
       (set! r9 r14)
       (set! r8 rdi)
       (set! rcx r13)
       (set! rdx 1064830001)
       (set! rsi r14)
       (set! rdi r13)
       (set! r15 r15)
       (jump L.func.1.2)))
   (define L.func.1.2
     (begin
       (set! r15 r15)
       (set! r14 rdi)
       (set! rsi rsi)
       (set! rdi rdx)
       (set! rdx rcx)
       (set! r8 r8)
       (set! r13 r9)
       (if (if (if (< r8 r8) (= r14 r14) (!= rsi r8))
             (= r13 0)
             (if (begin (set! r9 0) (> r9 r13))
               (begin (set! r9 1) (<= r9 rdx))
               (begin (set! r9 529266316) (>= r9 r8))))
         (if (begin (set! r9 rdi) (<= rdx r9))
           (begin (set! r14 r13) (set! rax r13) (jump r15))
           (begin
             (set! r9 r13)
             (set! r8 rdi)
             (set! rcx rsi)
             (set! rdx rsi)
             (set! rsi r14)
             (set! rdi rdi)
             (set! r15 r15)
             (jump L.func.1.2)))
         (begin
           (set! r14 rdi)
           (set! r14 r14)
           (set! r9 rdi)
           (set! r8 r14)
           (set! rcx rdi)
           (set! rdx r13)
           (set! rsi r13)
           (set! rdi r14)
           (set! r15 r15)
           (jump L.func.1.2)))))
   (begin
     (set! r15 r15)
     (set! r9 0)
     (set! r8 0)
     (set! rcx 1)
     (set! rdx 1)
     (set! rsi -1337458253)
     (set! rdi 9223372036854775807)
     (set! r15 r15)
     (jump L.func.1.2))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (if (if (begin (set! r14 9223372036854775807) (true))
           (true)
           (not (begin (set! r14 9223372036854775807) (false))))
       (begin
         (set! r14 -9223372036854775808)
         (set! r14 -9223372036854775808)
         (set! r13 9223372036854775807)
         (set! r13 (* r13 -9223372036854775808))
         (set! r13 r13)
         (set! rax r14)
         (jump r15))
       (begin
         (set! r14 1865158198)
         (set! r14 (+ r14 1))
         (set! r14 r14)
         (begin (set! rax r14) (jump r15)))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (if (begin (set! r14 1069510162) (true))
       (begin (set! rax 1) (jump r15))
       (begin (set! rax 323863587) (jump r15))))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 379335310)
     (set! r14 (* r14 0))
     (set! rax r14)
     (jump r15))))
(check-by-interp '(module (begin (set! r15 r15) (set! rax 0) (jump r15))))
(check-by-interp '(module
   (begin
     (set! r15 r15)
     (set! r14 -9223372036854775808)
     (set! r14 (- r14 0))
     (set! r13 r14)
     (set! r14 -9223372036854775808)
     (set! r9 1969620648)
     (set! r13 r13)
     (set! r14 r14)
     (set! rax r13)
     (jump r15))))
  ;; !!!
