#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         cpsc411/test-suite/utils
         "../specify-representation.rkt")
(define (fail-if-invalid p)
  (when (not (exprs-bits-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "exprs-bits-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-exprs-unsafe-data-lang-v8 p)
  (ptr->v (interp-exprs-bits-lang-v8 (fail-if-invalid (specify-representation p))))))

(check-by-interp '(module 105))
(check-by-interp '(module (error 105)))
(check-by-interp '(module (if #t (error 67) (error 38))))
(check-by-interp '(module (let ((error0.1 (error 111))) 141)))
(check-by-interp
 '(module
    (define L.fun/empty8385.4 (lambda () empty))
    (call L.fun/empty8385.4)))
(check-by-interp '(module (if #t #\c #\c)))
(check-by-interp '(module (if #t (error 196) (error 56))))
(check-by-interp
 '(module
    (define L.-.6
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx- tmp.19 tmp.20) (error 3))
          (error 3))))
    (define L.fun/fixnum8420.4 (lambda (oprand0.1) 50))
    (call L.-.6 (call L.fun/fixnum8420.4 #\c) (call L.-.6 21 253))))
(check-by-interp '(module (if #t (error 240) (error 51))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8428.4 (lambda (oprand0.1) #\c))
    (define L.fun/empty8427.5 (lambda (oprand0.2) empty))
    (call L.fun/empty8427.5 (call L.fun/ascii-char8428.4 empty))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8442.4 (lambda (oprand0.2 oprand1.1) #\c))
    (if (if #t #t #t)
      (call L.fun/ascii-char8442.4 #\c empty)
      (let ((fixnum0.5 104) (fixnum1.4 76) (void2.3 (void))) #\c))))
(check-by-interp
 '(module
    (define L.*.8
      (lambda (tmp.17 tmp.18)
        (if (fixnum? tmp.18)
          (if (fixnum? tmp.17) (unsafe-fx* tmp.17 tmp.18) (error 1))
          (error 1))))
    (define L.fun/ascii-char8498.4 (lambda () #\c))
    (define L.fun/void8499.5 (lambda () (void)))
    (define L.fun/empty8500.6 (lambda () empty))
    (let ((fixnum0.3 (call L.*.8 232 34))
          (ascii-char1.2 (call L.fun/ascii-char8498.4))
          (void2.1 (call L.fun/void8499.5)))
      (call L.fun/empty8500.6))))
(check-by-interp
 '(module
    (define L.-.7
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx- tmp.21 tmp.22) (error 3))
          (error 3))))
    (define L.fun/empty8553.4 (lambda () empty))
    (define L.fun/error8554.5 (lambda () (error 169)))
    (let ((empty0.3 (call L.fun/empty8553.4))
          (error1.2 (call L.fun/error8554.5))
          (fixnum2.1 (call L.-.7 221 18)))
      error1.2)))
(check-by-interp
 '(module
    (define L.fun/boolean8597.4 (lambda (oprand0.2 oprand1.1) #f))
    (define L.fun/ascii-char8598.5 (lambda (oprand0.4 oprand1.3) #\c))
    (if (call L.fun/boolean8597.4 empty #\c)
      (if #f #\c #\c)
      (call L.fun/ascii-char8598.5 78 empty))))
(check-by-interp
 '(module
    (define L.+.9
      (lambda (tmp.32 tmp.33)
        (if (fixnum? tmp.33)
          (if (fixnum? tmp.32) (unsafe-fx+ tmp.32 tmp.33) (error 2))
          (error 2))))
    (define L.fun/fixnum9203.4 (lambda (oprand0.3 oprand1.2 oprand2.1) 171))
    (define L.fun/fixnum9202.5 (lambda (oprand0.6 oprand1.5 oprand2.4) 71))
    (define L.fun/fixnum9204.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) oprand2.7))
    (define L.fun/boolean9201.7 (lambda (oprand0.12 oprand1.11 oprand2.10) #t))
    (call
     L.+.9
     (if (call L.fun/boolean9201.7 (error 11) #\c empty)
       (call L.fun/fixnum9202.5 (void) empty (void))
       (call L.fun/fixnum9203.4 empty #f #f))
     (if (if #t #f #f)
       (let ((boolean0.16 #f)
             (error1.15 (error 231))
             (fixnum2.14 27)
             (void3.13 (void)))
         fixnum2.14)
       (call L.fun/fixnum9204.6 (void) #\c 222)))))
(check-by-interp
 '(module
    (define L.-.11
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx- tmp.22 tmp.23) (error 3))
          (error 3))))
    (define L.+.10
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx+ tmp.20 tmp.21) (error 2))
          (error 2))))
    (define L.*.9
      (lambda (tmp.18 tmp.19)
        (if (fixnum? tmp.19)
          (if (fixnum? tmp.18) (unsafe-fx* tmp.18 tmp.19) (error 1))
          (error 1))))
    (define L.fun/ascii-char9328.4 (lambda () #\c))
    (define L.fun/void9330.5 (lambda () (void)))
    (define L.fun/error9331.6 (lambda () (error 106)))
    (define L.fun/ascii-char9329.7 (lambda () #\c))
    (let ((fixnum0.4 (call L.-.11 (call L.*.9 55 225) (call L.+.10 52 28)))
          (ascii-char1.3 (call L.fun/ascii-char9328.4))
          (ascii-char2.2 (call L.fun/ascii-char9329.7))
          (void3.1 (call L.fun/void9330.5)))
      (call L.fun/error9331.6))))
(check-by-interp
 '(module
    (define L.*.8
      (lambda (tmp.18 tmp.19)
        (if (fixnum? tmp.19)
          (if (fixnum? tmp.18) (unsafe-fx* tmp.18 tmp.19) (error 1))
          (error 1))))
    (define L.-.7
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx- tmp.22 tmp.23) (error 3))
          (error 3))))
    (define L.fun/ascii-char9350.4 (lambda () #\c))
    (define L.fun/error9349.5 (lambda () (error 136)))
    (let ((fixnum0.4 (call L.-.7 (call L.-.7 150 201) (call L.-.7 95 117)))
          (fixnum1.3 (call L.-.7 (call L.*.8 128 107) (call L.*.8 89 97)))
          (error2.2 (call L.fun/error9349.5))
          (fixnum3.1 (call L.*.8 (call L.-.7 133 4) (call L.-.7 136 150))))
      (call L.fun/ascii-char9350.4))))
(check-by-interp
 '(module
    (define L.-.10
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx- tmp.22 tmp.23) (error 3))
          (error 3))))
    (define L.*.9
      (lambda (tmp.18 tmp.19)
        (if (fixnum? tmp.19)
          (if (fixnum? tmp.18) (unsafe-fx* tmp.18 tmp.19) (error 1))
          (error 1))))
    (define L.+.8
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx+ tmp.20 tmp.21) (error 2))
          (error 2))))
    (define L.fun/empty9463.4 (lambda () empty))
    (define L.fun/empty9462.5 (lambda () empty))
    (define L.fun/void9461.6 (lambda () (void)))
    (let ((void0.4 (call L.fun/void9461.6))
          (fixnum1.3 (call L.-.10 (call L.+.8 183 180) (call L.*.9 238 118)))
          (empty2.2 (call L.fun/empty9462.5))
          (empty3.1 (call L.fun/empty9463.4)))
      void0.4)))
(check-by-interp
 '(module
    (define L.-.6
      (lambda (tmp.33 tmp.34)
        (if (fixnum? tmp.34)
          (if (fixnum? tmp.33) (unsafe-fx- tmp.33 tmp.34) (error 3))
          (error 3))))
    (define L.fun/ascii-char9530.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) #\c))
    (if (let ((fixnum0.7 133)
              (empty1.6 empty)
              (fixnum2.5 85)
              (error3.4 (error 110)))
          #f)
      (call
       L.fun/ascii-char9530.4
       (let ((void0.11 (void))
             (error1.10 (error 158))
             (void2.9 (void))
             (boolean3.8 #f))
         180)
       (call L.-.6 161 4)
       (if #t (void) (void)))
      (let ((ascii-char0.15 #\c)
            (fixnum1.14 195)
            (empty2.13 empty)
            (void3.12 (void)))
        #\c))))
(check-by-interp
 '(module
    (if (if #t #f #t)
      (if #f (error 182) (error 164))
      (if #t (error 131) (error 227)))))
(check-by-interp
 '(module
    (define L.*.9
      (lambda (tmp.18 tmp.19)
        (if (fixnum? tmp.19)
          (if (fixnum? tmp.18) (unsafe-fx* tmp.18 tmp.19) (error 1))
          (error 1))))
    (define L.-.8
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx- tmp.22 tmp.23) (error 3))
          (error 3))))
    (define L.fun/error9595.4 (lambda () (error 35)))
    (define L.fun/void9594.5 (lambda () (void)))
    (define L.fun/empty9593.6 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty9593.6))
          (void1.3 (call L.fun/void9594.5))
          (error2.2 (call L.fun/error9595.4))
          (fixnum3.1 (call L.*.9 (call L.-.8 171 174) (call L.*.9 161 50))))
      void1.3)))
(check-by-interp
 '(module
    (define L.void?.10 (lambda (tmp.44) (void? tmp.44)))
    (define L.fun/error9648.4 (lambda () (error 10)))
    (define L.fun/error9646.5 (lambda () (error 228)))
    (define L.fun/any9647.6 (lambda () #f))
    (define L.fun/error9649.7 (lambda () (error 110)))
    (define L.fun/void9650.8 (lambda () (void)))
    (let ((error0.4 (call L.fun/error9646.5))
          (boolean1.3 (call L.void?.10 (call L.fun/any9647.6)))
          (error2.2 (call L.fun/error9648.4))
          (error3.1 (call L.fun/error9649.7)))
      (call L.fun/void9650.8))))
(check-by-interp
 '(module
    (define L.ascii-char?.10 (lambda (tmp.46) (ascii-char? tmp.46)))
    (define L.fun/error10696.4 (lambda () (error 215)))
    (define L.fun/ascii-char10693.5 (lambda () #\c))
    (define L.fun/void10697.6 (lambda () (void)))
    (define L.fun/any10694.7 (lambda () empty))
    (define L.fun/void10695.8 (lambda () (void)))
    (let ((ascii-char0.5 (call L.fun/ascii-char10693.5))
          (boolean1.4 (call L.ascii-char?.10 (call L.fun/any10694.7)))
          (void2.3 (call L.fun/void10695.8))
          (error3.2 (call L.fun/error10696.4))
          (void4.1 (call L.fun/void10697.6)))
      void4.1)))
(check-by-interp
 '(module
    (define L.fun/empty12161.4 (lambda () empty))
    (define L.fun/error12159.5 (lambda () (error 7)))
    (define L.fun/ascii-char12162.6 (lambda () #\c))
    (define L.fun/error12163.7 (lambda () (error 42)))
    (define L.fun/error12160.8 (lambda () (error 106)))
    (let ((error0.5 (call L.fun/error12159.5))
          (error1.4 (call L.fun/error12160.8))
          (empty2.3 (call L.fun/empty12161.4))
          (ascii-char3.2 (call L.fun/ascii-char12162.6))
          (error4.1 (call L.fun/error12163.7)))
      empty2.3)))
(check-by-interp
 '(module
    (define L.-.12
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.empty?.9 (lambda (tmp.44) (empty? tmp.44)))
    (define L.fun/void12536.4 (lambda () (void)))
    (define L.fun/any12537.5 (lambda () empty))
    (define L.fun/error12539.6 (lambda () (error 115)))
    (define L.fun/error12538.7 (lambda () (error 97)))
    (let ((void0.5 (call L.fun/void12536.4))
          (boolean1.4 (call L.empty?.9 (call L.fun/any12537.5)))
          (fixnum2.3
           (call
            L.-.12
            (call L.+.11 (call L.*.10 98 48) (call L.+.11 13 114))
            (call L.-.12 (call L.-.12 222 161) (call L.*.10 99 95))))
          (error3.2 (call L.fun/error12538.7))
          (error4.1 (call L.fun/error12539.6)))
      error4.1)))
(check-by-interp
 '(module
    (define L.pair?.12 (lambda (tmp.48) (pair? tmp.48)))
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.*.9
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.fun/any13289.4 (lambda () #f))
    (define L.fun/empty13290.5 (lambda () empty))
    (define L.fun/error13288.6 (lambda () (error 191)))
    (define L.fun/ascii-char13291.7 (lambda () #\c))
    (let ((fixnum0.5
           (call
            L.+.11
            (call L.-.10 (call L.*.9 170 197) (call L.-.10 236 37))
            (call L.-.10 (call L.-.10 235 226) (call L.*.9 251 88))))
          (error1.4 (call L.fun/error13288.6))
          (fixnum2.3
           (call
            L.-.10
            (call L.-.10 (call L.-.10 186 149) (call L.-.10 145 185))
            (call L.*.9 (call L.*.9 3 155) (call L.+.11 226 219))))
          (boolean3.2 (call L.pair?.12 (call L.fun/any13289.4)))
          (empty4.1 (call L.fun/empty13290.5)))
      (call L.fun/ascii-char13291.7))))
(check-by-interp
 '(module
    (define L.fixnum?.12 (lambda (tmp.42) (fixnum? tmp.42)))
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.-.9
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.fun/ascii-char13294.4 (lambda () #\c))
    (define L.fun/any13295.5 (lambda () #f))
    (define L.fun/error13297.6 (lambda () (error 183)))
    (define L.fun/ascii-char13296.7 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char13294.4))
          (fixnum1.4
           (call
            L.+.11
            (call L.-.9 (call L.-.9 34 115) (call L.*.10 164 191))
            (call L.+.11 (call L.+.11 116 76) (call L.-.9 28 161))))
          (boolean2.3 (call L.fixnum?.12 (call L.fun/any13295.5)))
          (ascii-char3.2 (call L.fun/ascii-char13296.7))
          (error4.1 (call L.fun/error13297.6)))
      ascii-char0.5)))
(check-by-interp
 '(module
    (define L.ascii-char?.10 (lambda (tmp.46) (ascii-char? tmp.46)))
    (define L.fun/ascii-char13919.4 (lambda () #\c))
    (define L.fun/error13917.5 (lambda () (error 136)))
    (define L.fun/any13918.6 (lambda () #t))
    (define L.fun/void13916.7 (lambda () (void)))
    (define L.fun/ascii-char13915.8 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char13915.8))
          (void1.4 (call L.fun/void13916.7))
          (error2.3 (call L.fun/error13917.5))
          (boolean3.2 (call L.ascii-char?.10 (call L.fun/any13918.6)))
          (ascii-char4.1 (call L.fun/ascii-char13919.4)))
      void1.4)))
(check-by-interp
 '(module
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.-.9
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.*.8
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.fun/empty14259.4 (lambda () empty))
    (define L.fun/ascii-char14257.5 (lambda () #\c))
    (define L.fun/error14258.6 (lambda () (error 83)))
    (let ((ascii-char0.5 (call L.fun/ascii-char14257.5))
          (fixnum1.4
           (call
            L.*.8
            (call L.-.9 (call L.*.8 206 222) (call L.*.8 226 166))
            (call L.-.9 (call L.-.9 182 234) (call L.+.10 54 78))))
          (error2.3 (call L.fun/error14258.6))
          (empty3.2 (call L.fun/empty14259.4))
          (fixnum4.1
           (call
            L.-.9
            (call L.-.9 (call L.+.10 181 68) (call L.+.10 63 242))
            (call L.+.10 (call L.*.8 104 78) (call L.*.8 102 32)))))
      empty3.2)))
(check-by-interp
 '(module
    (define L.fun/empty15571.4 (lambda () empty))
    (define L.fun/ascii-char15572.5 (lambda () #\c))
    (define L.fun/ascii-char15569.6 (lambda () #\c))
    (define L.fun/empty15570.7 (lambda () empty))
    (define L.fun/void15568.8 (lambda () (void)))
    (let ((void0.5 (call L.fun/void15568.8))
          (ascii-char1.4 (call L.fun/ascii-char15569.6))
          (empty2.3 (call L.fun/empty15570.7))
          (empty3.2 (call L.fun/empty15571.4))
          (ascii-char4.1 (call L.fun/ascii-char15572.5)))
      empty3.2)))
(check-by-interp
 '(module
    (define L.+.12
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.*.10
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.fun/ascii-char15704.4 (lambda () #\c))
    (define L.fun/void15705.5 (lambda () (void)))
    (define L.fun/ascii-char15707.6 (lambda () #\c))
    (define L.fun/error15708.7 (lambda () (error 141)))
    (define L.fun/empty15706.8 (lambda () empty))
    (let ((ascii-char0.5 (call L.fun/ascii-char15704.4))
          (void1.4 (call L.fun/void15705.5))
          (fixnum2.3
           (call
            L.*.10
            (call L.*.10 (call L.*.10 149 53) (call L.-.11 200 171))
            (call L.*.10 (call L.+.12 242 67) (call L.*.10 14 213))))
          (empty3.2 (call L.fun/empty15706.8))
          (ascii-char4.1 (call L.fun/ascii-char15707.6)))
      (call L.fun/error15708.7))))
(check-by-interp
 '(module
    (define L.empty?.13 (lambda (tmp.44) (empty? tmp.44)))
    (define L.ascii-char?.12 (lambda (tmp.46) (ascii-char? tmp.46)))
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.fun/void15911.4 (lambda () (void)))
    (define L.fun/any15910.5 (lambda () #\c))
    (define L.fun/any15908.6 (lambda () #\c))
    (define L.fun/ascii-char15909.7 (lambda () #\c))
    (let ((fixnum0.5
           (call
            L.*.11
            (call L.+.9 (call L.+.9 201 19) (call L.+.9 133 32))
            (call L.-.10 (call L.-.10 254 127) (call L.-.10 68 187))))
          (boolean1.4 (call L.ascii-char?.12 (call L.fun/any15908.6)))
          (ascii-char2.3 (call L.fun/ascii-char15909.7))
          (boolean3.2 (call L.empty?.13 (call L.fun/any15910.5)))
          (void4.1 (call L.fun/void15911.4)))
      void4.1)))
(check-by-interp
 '(module
    (define L.fun/error16257.4 (lambda () (error 223)))
    (define L.fun/ascii-char16255.5 (lambda () #\c))
    (define L.fun/empty16258.6 (lambda () empty))
    (define L.fun/empty16256.7 (lambda () empty))
    (define L.fun/ascii-char16259.8 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char16255.5))
          (empty1.4 (call L.fun/empty16256.7))
          (error2.3 (call L.fun/error16257.4))
          (empty3.2 (call L.fun/empty16258.6))
          (ascii-char4.1 (call L.fun/ascii-char16259.8)))
      error2.3)))
(check-by-interp
 '(module
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.*.8
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.fun/void17748.4 (lambda () (void)))
    (define L.fun/ascii-char17750.5 (lambda () #\c))
    (define L.fun/error17749.6 (lambda () (error 141)))
    (let ((void0.5 (call L.fun/void17748.4))
          (fixnum1.4
           (call
            L.+.9
            (call L.+.9 (call L.*.8 250 187) (call L.+.9 177 58))
            (call L.+.9 (call L.*.8 114 169) (call L.+.9 147 148))))
          (error2.3 (call L.fun/error17749.6))
          (ascii-char3.2 (call L.fun/ascii-char17750.5))
          (fixnum4.1
           (call
            L.-.10
            (call L.-.10 (call L.*.8 240 76) (call L.+.9 175 182))
            (call L.+.9 (call L.*.8 185 50) (call L.-.10 106 165)))))
      void0.5)))
(check-by-interp
 '(module
    (define L.+.12
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.fun/empty17803.4 (lambda () empty))
    (define L.fun/error17806.5 (lambda () (error 150)))
    (define L.fun/void17802.6 (lambda () (void)))
    (define L.fun/void17805.7 (lambda () (void)))
    (define L.fun/empty17804.8 (lambda () empty))
    (let ((void0.5 (call L.fun/void17802.6))
          (empty1.4 (call L.fun/empty17803.4))
          (empty2.3 (call L.fun/empty17804.8))
          (void3.2 (call L.fun/void17805.7))
          (fixnum4.1
           (call
            L.-.10
            (call L.*.11 (call L.-.10 117 124) (call L.*.11 99 52))
            (call L.*.11 (call L.+.12 242 99) (call L.*.11 59 238)))))
      (call L.fun/error17806.5))))
(check-by-interp
 '(module
    (define L.*.6
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.void?.5 (lambda (tmp.45) (void? tmp.45)))
    (if (call
         L.void?.5
         (let ((boolean0.5 #t)
               (error1.4 (error 3))
               (void2.3 (void))
               (fixnum3.2 189)
               (fixnum4.1 11))
           (void)))
      (call L.*.6 (if #t 50 150) (if #t 125 157))
      (call L.*.6 (if #f 183 45) (if #t 9 102)))))
(check-by-interp
 '(module
    (define L.+.11
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.-.10
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.*.9
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.fun/void20503.4 (lambda () (void)))
    (define L.fun/empty20501.5 (lambda () empty))
    (define L.fun/ascii-char20504.6 (lambda () #\c))
    (define L.fun/void20502.7 (lambda () (void)))
    (let ((empty0.5 (call L.fun/empty20501.5))
          (void1.4 (call L.fun/void20502.7))
          (void2.3 (call L.fun/void20503.4))
          (ascii-char3.2 (call L.fun/ascii-char20504.6))
          (fixnum4.1
           (call
            L.*.9
            (call L.-.10 (call L.*.9 18 125) (call L.*.9 156 230))
            (call L.*.9 (call L.*.9 11 152) (call L.+.11 64 98)))))
      ascii-char3.2)))
(check-by-interp
 '(module
    (define L.-.17
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fun/error28491.4 (lambda () (error 176)))
    (define L.fun/empty28492.5 (lambda () (call L.fun/empty28493.6)))
    (define L.fun/empty28493.6 (lambda () empty))
    (define L.fun/empty28494.7 (lambda () (call L.fun/empty28495.12)))
    (define L.fun/ascii-char28488.8
      (lambda () (call L.fun/ascii-char28489.13)))
    (define L.fun/error28490.9 (lambda () (call L.fun/error28491.4)))
    (define L.fun/void28497.10 (lambda () (void)))
    (define L.fun/void28496.11 (lambda () (call L.fun/void28497.10)))
    (define L.fun/empty28495.12 (lambda () empty))
    (define L.fun/ascii-char28489.13 (lambda () #\c))
    (let ((fixnum0.6
           (call
            L.-.17
            (call
             L.+.16
             (call L.-.17 (call L.*.15 57 202) (call L.+.16 114 18))
             (call L.-.17 (call L.*.15 131 116) (call L.*.15 159 28)))
            (call
             L.-.17
             (call L.*.15 (call L.*.15 234 28) (call L.+.16 114 191))
             (call L.+.16 (call L.+.16 209 40) (call L.-.17 169 160)))))
          (ascii-char1.5 (call L.fun/ascii-char28488.8))
          (error2.4 (call L.fun/error28490.9))
          (empty3.3 (call L.fun/empty28492.5))
          (empty4.2 (call L.fun/empty28494.7))
          (void5.1 (call L.fun/void28496.11)))
      error2.4)))
(check-by-interp
 '(module
    (define L.fun/ascii-char28930.4
      (lambda () (call L.fun/ascii-char28931.10)))
    (define L.fun/error28940.5 (lambda () (call L.fun/error28941.15)))
    (define L.fun/ascii-char28935.6 (lambda () #\c))
    (define L.fun/void28936.7 (lambda () (call L.fun/void28937.11)))
    (define L.fun/void28938.8 (lambda () (call L.fun/void28939.14)))
    (define L.fun/error28933.9 (lambda () (error 174)))
    (define L.fun/ascii-char28931.10 (lambda () #\c))
    (define L.fun/void28937.11 (lambda () (void)))
    (define L.fun/ascii-char28934.12
      (lambda () (call L.fun/ascii-char28935.6)))
    (define L.fun/error28932.13 (lambda () (call L.fun/error28933.9)))
    (define L.fun/void28939.14 (lambda () (void)))
    (define L.fun/error28941.15 (lambda () (error 244)))
    (let ((ascii-char0.6 (call L.fun/ascii-char28930.4))
          (error1.5 (call L.fun/error28932.13))
          (ascii-char2.4 (call L.fun/ascii-char28934.12))
          (void3.3 (call L.fun/void28936.7))
          (void4.2 (call L.fun/void28938.8))
          (error5.1 (call L.fun/error28940.5)))
      void4.2)))
(check-by-interp
 '(module
    (define L.+.17
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.16
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.fun/empty30828.4 (lambda () empty))
    (define L.fun/empty30827.5 (lambda () (call L.fun/empty30828.4)))
    (define L.fun/void30829.6 (lambda () (call L.fun/void30830.12)))
    (define L.fun/error30825.7 (lambda () (call L.fun/error30826.11)))
    (define L.fun/error30824.8 (lambda () (error 122)))
    (define L.fun/empty30822.9 (lambda () empty))
    (define L.fun/error30823.10 (lambda () (call L.fun/error30824.8)))
    (define L.fun/error30826.11 (lambda () (error 112)))
    (define L.fun/void30830.12 (lambda () (void)))
    (define L.fun/empty30821.13 (lambda () (call L.fun/empty30822.9)))
    (let ((empty0.6 (call L.fun/empty30821.13))
          (error1.5 (call L.fun/error30823.10))
          (error2.4 (call L.fun/error30825.7))
          (empty3.3 (call L.fun/empty30827.5))
          (fixnum4.2
           (call
            L.-.15
            (call
             L.+.17
             (call L.*.16 (call L.-.15 195 178) (call L.-.15 61 180))
             (call L.*.16 (call L.+.17 126 54) (call L.+.17 95 83)))
            (call
             L.+.17
             (call L.+.17 (call L.+.17 171 51) (call L.*.16 69 252))
             (call L.+.17 (call L.*.16 66 146) (call L.+.17 234 178)))))
          (void5.1 (call L.fun/void30829.6)))
      void5.1)))
(check-by-interp
 '(module
    (define L.-.13
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.*.12
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.+.11
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.fun/void31698.4 (lambda () (call L.fun/void31699.8)))
    (define L.fun/void31701.5 (lambda () (void)))
    (define L.fun/void31700.6 (lambda () (call L.fun/void31701.5)))
    (define L.fun/empty31697.7 (lambda () empty))
    (define L.fun/void31699.8 (lambda () (void)))
    (define L.fun/empty31696.9 (lambda () (call L.fun/empty31697.7)))
    (let ((fixnum0.6
           (call
            L.*.12
            (call
             L.*.12
             (call L.+.11 (call L.+.11 76 158) (call L.*.12 100 178))
             (call L.*.12 (call L.-.13 174 45) (call L.*.12 177 242)))
            (call
             L.+.11
             (call L.*.12 (call L.+.11 95 230) (call L.*.12 202 246))
             (call L.+.11 (call L.+.11 45 224) (call L.*.12 112 185)))))
          (fixnum1.5
           (call
            L.+.11
            (call
             L.*.12
             (call L.*.12 (call L.*.12 198 121) (call L.+.11 116 203))
             (call L.-.13 (call L.*.12 82 179) (call L.+.11 98 26)))
            (call
             L.*.12
             (call L.-.13 (call L.-.13 24 149) (call L.-.13 178 234))
             (call L.-.13 (call L.*.12 22 11) (call L.*.12 114 140)))))
          (empty2.4 (call L.fun/empty31696.9))
          (void3.3 (call L.fun/void31698.4))
          (void4.2 (call L.fun/void31700.6))
          (fixnum5.1
           (call
            L.*.12
            (call
             L.+.11
             (call L.+.11 (call L.-.13 80 112) (call L.-.13 139 11))
             (call L.+.11 (call L.+.11 244 241) (call L.*.12 194 173)))
            (call
             L.*.12
             (call L.+.11 (call L.-.13 34 120) (call L.*.12 152 174))
             (call L.+.11 (call L.*.12 144 179) (call L.-.13 152 104))))))
      void3.3)))
(check-by-interp
 '(module
    (define L.pair?.15 (lambda (tmp.49) (pair? tmp.49)))
    (define L.-.14
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.+.13
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.12
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fun/void46565.4 (lambda () (call L.fun/void46566.6)))
    (define L.fun/error46563.5 (lambda () (call L.fun/error46564.8)))
    (define L.fun/void46566.6 (lambda () (void)))
    (define L.fun/empty46562.7 (lambda () empty))
    (define L.fun/error46564.8 (lambda () (error 195)))
    (define L.fun/empty46561.9 (lambda () (call L.fun/empty46562.7)))
    (define L.fun/any46567.10 (lambda () 212))
    (let ((empty0.6 (call L.fun/empty46561.9))
          (error1.5 (call L.fun/error46563.5))
          (fixnum2.4
           (call
            L.*.12
            (call
             L.-.14
             (call L.+.13 (call L.*.12 19 179) (call L.+.13 80 36))
             (call L.*.12 (call L.-.14 76 53) (call L.*.12 207 127)))
            (call
             L.+.13
             (call L.-.14 (call L.*.12 174 75) (call L.-.14 35 107))
             (call L.+.13 (call L.-.14 95 43) (call L.+.13 88 187)))))
          (void3.3 (call L.fun/void46565.4))
          (fixnum4.2
           (call
            L.*.12
            (call
             L.-.14
             (call L.-.14 (call L.*.12 223 68) (call L.-.14 225 44))
             (call L.-.14 (call L.+.13 74 49) (call L.-.14 193 65)))
            (call
             L.*.12
             (call L.-.14 (call L.*.12 161 112) (call L.*.12 114 48))
             (call L.-.14 (call L.*.12 85 50) (call L.+.13 83 60)))))
          (boolean5.1 (call L.pair?.15 (call L.fun/any46567.10))))
      void3.3)))
(check-by-interp
 '(module
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.-.14
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.*.13
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fun/error50281.4 (lambda () (error 64)))
    (define L.fun/error50280.5 (lambda () (call L.fun/error50281.4)))
    (define L.fun/void50283.6 (lambda () (void)))
    (define L.fun/ascii-char50284.7 (lambda () (call L.fun/ascii-char50285.9)))
    (define L.fun/void50278.8 (lambda () (call L.fun/void50279.10)))
    (define L.fun/ascii-char50285.9 (lambda () #\c))
    (define L.fun/void50279.10 (lambda () (void)))
    (define L.fun/void50282.11 (lambda () (call L.fun/void50283.6)))
    (let ((void0.6 (call L.fun/void50278.8))
          (error1.5 (call L.fun/error50280.5))
          (fixnum2.4
           (call
            L.+.15
            (call
             L.*.13
             (call L.-.14 (call L.*.13 77 140) (call L.-.14 182 24))
             (call L.-.14 (call L.+.15 175 53) (call L.+.15 177 174)))
            (call
             L.-.14
             (call L.-.14 (call L.-.14 245 178) (call L.-.14 42 16))
             (call L.-.14 (call L.+.15 144 205) (call L.+.15 136 39)))))
          (void3.3 (call L.fun/void50282.11))
          (fixnum4.2
           (call
            L.*.13
            (call
             L.-.14
             (call L.-.14 (call L.-.14 209 76) (call L.+.15 217 50))
             (call L.-.14 (call L.+.15 187 190) (call L.-.14 38 142)))
            (call
             L.+.15
             (call L.-.14 (call L.-.14 205 24) (call L.-.14 227 153))
             (call L.-.14 (call L.-.14 65 164) (call L.*.13 15 147)))))
          (ascii-char5.1 (call L.fun/ascii-char50284.7)))
      fixnum2.4)))
(check-by-interp
 '(module
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.-.13
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.fun/ascii-char51656.4 (lambda () (call L.fun/ascii-char51657.5)))
    (define L.fun/ascii-char51657.5 (lambda () #\c))
    (define L.fun/error51658.6 (lambda () (call L.fun/error51659.11)))
    (define L.fun/void51654.7 (lambda () (call L.fun/void51655.9)))
    (define L.fun/error51653.8 (lambda () (error 78)))
    (define L.fun/void51655.9 (lambda () (void)))
    (define L.fun/error51652.10 (lambda () (call L.fun/error51653.8)))
    (define L.fun/error51659.11 (lambda () (error 177)))
    (let ((fixnum0.6
           (call
            L.*.14
            (call
             L.*.14
             (call L.-.13 (call L.-.13 87 4) (call L.*.14 197 221))
             (call L.-.13 (call L.+.15 204 51) (call L.-.13 79 122)))
            (call
             L.*.14
             (call L.+.15 (call L.+.15 21 76) (call L.+.15 239 50))
             (call L.+.15 (call L.*.14 124 157) (call L.*.14 143 53)))))
          (error1.5 (call L.fun/error51652.10))
          (void2.4 (call L.fun/void51654.7))
          (fixnum3.3
           (call
            L.*.14
            (call
             L.-.13
             (call L.*.14 (call L.*.14 184 195) (call L.*.14 74 203))
             (call L.*.14 (call L.*.14 67 169) (call L.*.14 111 106)))
            (call
             L.-.13
             (call L.-.13 (call L.*.14 140 7) (call L.+.15 103 127))
             (call L.+.15 (call L.*.14 2 132) (call L.+.15 113 18)))))
          (ascii-char4.2 (call L.fun/ascii-char51656.4))
          (error5.1 (call L.fun/error51658.6)))
      void2.4)))
(check-by-interp
 '(module
    (define L.vector?.16 (lambda (tmp.50) (vector? tmp.50)))
    (define L.fun/error54326.4 (lambda () (call L.fun/error54327.8)))
    (define L.fun/error54322.5 (lambda () (error 71)))
    (define L.fun/empty54331.6 (lambda () empty))
    (define L.fun/void54329.7 (lambda () (void)))
    (define L.fun/error54327.8 (lambda () (error 67)))
    (define L.fun/error54325.9 (lambda () (error 34)))
    (define L.fun/error54321.10 (lambda () (call L.fun/error54322.5)))
    (define L.fun/any54323.11 (lambda () #\c))
    (define L.fun/void54328.12 (lambda () (call L.fun/void54329.7)))
    (define L.fun/error54324.13 (lambda () (call L.fun/error54325.9)))
    (define L.fun/empty54330.14 (lambda () (call L.fun/empty54331.6)))
    (let ((error0.6 (call L.fun/error54321.10))
          (boolean1.5 (call L.vector?.16 (call L.fun/any54323.11)))
          (error2.4 (call L.fun/error54324.13))
          (error3.3 (call L.fun/error54326.4))
          (void4.2 (call L.fun/void54328.12))
          (empty5.1 (call L.fun/empty54330.14)))
      void4.2)))
(check-by-interp
 '(module
    (define L.*.19
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.+.18
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.-.17
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.boolean?.16 (lambda (tmp.44) (boolean? tmp.44)))
    (define L.fun/ascii-char64319.4 (lambda () #\c))
    (define L.fun/error64313.5 (lambda () (error 103)))
    (define L.fun/empty64317.6 (lambda () empty))
    (define L.fun/ascii-char64318.7 (lambda () (call L.fun/ascii-char64319.4)))
    (define L.fun/void64310.8 (lambda () (void)))
    (define L.fun/empty64315.9 (lambda () empty))
    (define L.fun/any64311.10 (lambda () (error 159)))
    (define L.fun/error64312.11 (lambda () (call L.fun/error64313.5)))
    (define L.fun/empty64316.12 (lambda () (call L.fun/empty64317.6)))
    (define L.fun/empty64314.13 (lambda () (call L.fun/empty64315.9)))
    (define L.fun/void64309.14 (lambda () (call L.fun/void64310.8)))
    (let ((void0.6 (call L.fun/void64309.14))
          (boolean1.5 (call L.boolean?.16 (call L.fun/any64311.10)))
          (error2.4 (call L.fun/error64312.11))
          (empty3.3 (call L.fun/empty64314.13))
          (empty4.2 (call L.fun/empty64316.12))
          (fixnum5.1
           (call
            L.+.18
            (call
             L.-.17
             (call L.+.18 (call L.-.17 145 190) (call L.+.18 138 64))
             (call L.-.17 (call L.*.19 180 226) (call L.-.17 87 199)))
            (call
             L.*.19
             (call L.*.19 (call L.-.17 23 122) (call L.*.19 1 110))
             (call L.-.17 (call L.*.19 139 138) (call L.+.18 124 191))))))
      (call L.fun/ascii-char64318.7))))
(check-by-interp
 '(module
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.fun/void75654.4 (lambda () (void)))
    (define L.fun/empty75657.5 (lambda () (call L.fun/empty75658.10)))
    (define L.fun/ascii-char75662.6 (lambda () #\c))
    (define L.fun/ascii-char75660.7 (lambda () #\c))
    (define L.fun/empty75656.8 (lambda () empty))
    (define L.fun/ascii-char75661.9 (lambda () (call L.fun/ascii-char75662.6)))
    (define L.fun/empty75658.10 (lambda () empty))
    (define L.fun/empty75655.11 (lambda () (call L.fun/empty75656.8)))
    (define L.fun/void75653.12 (lambda () (call L.fun/void75654.4)))
    (define L.fun/ascii-char75659.13
      (lambda () (call L.fun/ascii-char75660.7)))
    (let ((fixnum0.6
           (call
            L.-.15
            (call
             L.+.16
             (call L.+.16 (call L.-.15 204 1) (call L.-.15 103 56))
             (call L.+.16 (call L.-.15 210 1) (call L.*.17 239 154)))
            (call
             L.*.17
             (call L.+.16 (call L.+.16 69 165) (call L.-.15 218 230))
             (call L.-.15 (call L.-.15 218 137) (call L.*.17 210 51)))))
          (void1.5 (call L.fun/void75653.12))
          (empty2.4 (call L.fun/empty75655.11))
          (empty3.3 (call L.fun/empty75657.5))
          (ascii-char4.2 (call L.fun/ascii-char75659.13))
          (ascii-char5.1 (call L.fun/ascii-char75661.9)))
      ascii-char5.1)))
(check-by-interp
 '(module
    (define L.+.17
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.16
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.error?.14 (lambda (tmp.48) (error? tmp.48)))
    (define L.fun/error83230.4 (lambda () (call L.fun/error83231.10)))
    (define L.fun/empty83233.5 (lambda () (call L.fun/empty83234.9)))
    (define L.fun/void83236.6 (lambda () (void)))
    (define L.fun/ascii-char83229.7 (lambda () #\c))
    (define L.fun/void83235.8 (lambda () (call L.fun/void83236.6)))
    (define L.fun/empty83234.9 (lambda () empty))
    (define L.fun/error83231.10 (lambda () (error 27)))
    (define L.fun/any83232.11 (lambda () #\c))
    (define L.fun/ascii-char83228.12
      (lambda () (call L.fun/ascii-char83229.7)))
    (let ((ascii-char0.6 (call L.fun/ascii-char83228.12))
          (error1.5 (call L.fun/error83230.4))
          (boolean2.4 (call L.error?.14 (call L.fun/any83232.11)))
          (empty3.3 (call L.fun/empty83233.5))
          (void4.2 (call L.fun/void83235.8))
          (fixnum5.1
           (call
            L.-.15
            (call
             L.*.16
             (call L.+.17 (call L.-.15 9 227) (call L.*.16 168 55))
             (call L.*.16 (call L.-.15 114 24) (call L.-.15 76 11)))
            (call
             L.+.17
             (call L.+.17 (call L.+.17 179 17) (call L.+.17 103 123))
             (call L.*.16 (call L.+.17 26 63) (call L.+.17 141 90))))))
      void4.2)))
(check-by-interp
 '(module
    (define L.error?.16 (lambda (tmp.48) (error? tmp.48)))
    (define L.fun/ascii-char87923.4
      (lambda () (call L.fun/ascii-char87924.13)))
    (define L.fun/empty87931.5 (lambda () empty))
    (define L.fun/ascii-char87928.6 (lambda () (call L.fun/ascii-char87929.7)))
    (define L.fun/ascii-char87929.7 (lambda () #\c))
    (define L.fun/ascii-char87926.8 (lambda () #\c))
    (define L.fun/empty87930.9 (lambda () (call L.fun/empty87931.5)))
    (define L.fun/void87922.10 (lambda () (void)))
    (define L.fun/any87927.11 (lambda () (void)))
    (define L.fun/ascii-char87925.12
      (lambda () (call L.fun/ascii-char87926.8)))
    (define L.fun/ascii-char87924.13 (lambda () #\c))
    (define L.fun/void87921.14 (lambda () (call L.fun/void87922.10)))
    (let ((void0.6 (call L.fun/void87921.14))
          (ascii-char1.5 (call L.fun/ascii-char87923.4))
          (ascii-char2.4 (call L.fun/ascii-char87925.12))
          (boolean3.3 (call L.error?.16 (call L.fun/any87927.11)))
          (ascii-char4.2 (call L.fun/ascii-char87928.6))
          (empty5.1 (call L.fun/empty87930.9)))
      empty5.1)))
(check-by-interp
 '(module
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.-.16
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.fun/void88023.4 (lambda () (void)))
    (define L.fun/empty88027.5 (lambda () empty))
    (define L.fun/error88024.6 (lambda () (call L.fun/error88025.11)))
    (define L.fun/error88021.7 (lambda () (error 222)))
    (define L.fun/empty88026.8 (lambda () (call L.fun/empty88027.5)))
    (define L.fun/error88029.9 (lambda () (error 197)))
    (define L.fun/error88020.10 (lambda () (call L.fun/error88021.7)))
    (define L.fun/error88025.11 (lambda () (error 212)))
    (define L.fun/void88022.12 (lambda () (call L.fun/void88023.4)))
    (define L.fun/error88028.13 (lambda () (call L.fun/error88029.9)))
    (let ((error0.6 (call L.fun/error88020.10))
          (void1.5 (call L.fun/void88022.12))
          (error2.4 (call L.fun/error88024.6))
          (fixnum3.3
           (call
            L.+.15
            (call
             L.-.16
             (call L.-.16 (call L.+.15 55 76) (call L.+.15 23 0))
             (call L.*.17 (call L.+.15 18 21) (call L.+.15 153 181)))
            (call
             L.-.16
             (call L.-.16 (call L.-.16 4 108) (call L.+.15 94 109))
             (call L.+.15 (call L.-.16 239 239) (call L.*.17 213 98)))))
          (empty4.2 (call L.fun/empty88026.8))
          (error5.1 (call L.fun/error88028.13)))
      error0.6)))
(check-by-interp
 '(module
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.-.13
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.pair?.12 (lambda (tmp.49) (pair? tmp.49)))
    (define L.fun/ascii-char95245.4 (lambda () #\c))
    (define L.fun/empty95247.5 (lambda () empty))
    (define L.fun/void95242.6 (lambda () (void)))
    (define L.fun/void95241.7 (lambda () (call L.fun/void95242.6)))
    (define L.fun/any95243.8 (lambda () (void)))
    (define L.fun/ascii-char95244.9 (lambda () (call L.fun/ascii-char95245.4)))
    (define L.fun/empty95246.10 (lambda () (call L.fun/empty95247.5)))
    (let ((void0.6 (call L.fun/void95241.7))
          (boolean1.5 (call L.pair?.12 (call L.fun/any95243.8)))
          (ascii-char2.4 (call L.fun/ascii-char95244.9))
          (fixnum3.3
           (call
            L.*.14
            (call
             L.-.13
             (call L.-.13 (call L.-.13 42 241) (call L.*.14 97 238))
             (call L.-.13 (call L.*.14 215 47) (call L.*.14 114 32)))
            (call
             L.*.14
             (call L.*.14 (call L.-.13 17 175) (call L.-.13 184 206))
             (call L.+.15 (call L.-.13 155 66) (call L.+.15 150 91)))))
          (empty4.2 (call L.fun/empty95246.10))
          (fixnum5.1
           (call
            L.-.13
            (call
             L.+.15
             (call L.*.14 (call L.-.13 21 171) (call L.+.15 171 175))
             (call L.*.14 (call L.*.14 87 9) (call L.*.14 202 16)))
            (call
             L.-.13
             (call L.*.14 (call L.+.15 45 112) (call L.*.14 246 184))
             (call L.*.14 (call L.+.15 170 142) (call L.*.14 137 91))))))
      ascii-char2.4)))
(check-by-interp
 '(module
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.fun/ascii-char101002.4 (lambda () #\c))
    (define L.fun/void101005.5 (lambda () (call L.fun/void101006.12)))
    (define L.fun/ascii-char101007.6
      (lambda () (call L.fun/ascii-char101008.10)))
    (define L.fun/ascii-char101000.7 (lambda () #\c))
    (define L.fun/void101004.8 (lambda () (void)))
    (define L.fun/ascii-char100999.9
      (lambda () (call L.fun/ascii-char101000.7)))
    (define L.fun/ascii-char101008.10 (lambda () #\c))
    (define L.fun/void101003.11 (lambda () (call L.fun/void101004.8)))
    (define L.fun/void101006.12 (lambda () (void)))
    (define L.fun/ascii-char101001.13
      (lambda () (call L.fun/ascii-char101002.4)))
    (let ((ascii-char0.6 (call L.fun/ascii-char100999.9))
          (fixnum1.5
           (call
            L.+.16
            (call
             L.+.16
             (call L.+.16 (call L.-.15 129 90) (call L.-.15 171 196))
             (call L.-.15 (call L.*.17 72 119) (call L.*.17 14 122)))
            (call
             L.+.16
             (call L.*.17 (call L.*.17 213 131) (call L.+.16 91 2))
             (call L.*.17 (call L.+.16 98 134) (call L.*.17 207 144)))))
          (ascii-char2.4 (call L.fun/ascii-char101001.13))
          (void3.3 (call L.fun/void101003.11))
          (void4.2 (call L.fun/void101005.5))
          (ascii-char5.1 (call L.fun/ascii-char101007.6)))
      ascii-char5.1)))
(check-by-interp
 '(module
    (define L.-.17
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fun/error102221.4 (lambda () (error 8)))
    (define L.fun/void102218.5 (lambda () (call L.fun/void102219.11)))
    (define L.fun/empty102216.6 (lambda () (call L.fun/empty102217.9)))
    (define L.fun/ascii-char102223.7 (lambda () #\c))
    (define L.fun/void102214.8 (lambda () (call L.fun/void102215.13)))
    (define L.fun/empty102217.9 (lambda () empty))
    (define L.fun/error102220.10 (lambda () (call L.fun/error102221.4)))
    (define L.fun/void102219.11 (lambda () (void)))
    (define L.fun/ascii-char102222.12
      (lambda () (call L.fun/ascii-char102223.7)))
    (define L.fun/void102215.13 (lambda () (void)))
    (let ((void0.6 (call L.fun/void102214.8))
          (empty1.5 (call L.fun/empty102216.6))
          (void2.4 (call L.fun/void102218.5))
          (error3.3 (call L.fun/error102220.10))
          (fixnum4.2
           (call
            L.-.17
            (call
             L.+.16
             (call L.*.15 (call L.*.15 211 23) (call L.*.15 149 117))
             (call L.*.15 (call L.*.15 158 242) (call L.*.15 82 246)))
            (call
             L.-.17
             (call L.*.15 (call L.*.15 79 157) (call L.+.16 182 65))
             (call L.+.16 (call L.*.15 71 229) (call L.-.17 209 3)))))
          (ascii-char5.1 (call L.fun/ascii-char102222.12)))
      error3.3)))
(check-by-interp
 '(module
    (define L.-.19
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.*.18
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.+.17
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.vector?.16 (lambda (tmp.50) (vector? tmp.50)))
    (define L.fun/void102243.4 (lambda () (call L.fun/void102244.10)))
    (define L.fun/any102238.5 (lambda () #f))
    (define L.fun/ascii-char102236.6
      (lambda () (call L.fun/ascii-char102237.13)))
    (define L.fun/void102241.7 (lambda () (call L.fun/void102242.11)))
    (define L.fun/ascii-char102239.8
      (lambda () (call L.fun/ascii-char102240.12)))
    (define L.fun/ascii-char102234.9
      (lambda () (call L.fun/ascii-char102235.14)))
    (define L.fun/void102244.10 (lambda () (void)))
    (define L.fun/void102242.11 (lambda () (void)))
    (define L.fun/ascii-char102240.12 (lambda () #\c))
    (define L.fun/ascii-char102237.13 (lambda () #\c))
    (define L.fun/ascii-char102235.14 (lambda () #\c))
    (let ((ascii-char0.6 (call L.fun/ascii-char102234.9))
          (ascii-char1.5 (call L.fun/ascii-char102236.6))
          (boolean2.4 (call L.vector?.16 (call L.fun/any102238.5)))
          (ascii-char3.3 (call L.fun/ascii-char102239.8))
          (void4.2 (call L.fun/void102241.7))
          (void5.1 (call L.fun/void102243.4)))
      (call
       L.*.18
       (call
        L.*.18
        (call L.*.18 (call L.+.17 231 129) (call L.+.17 61 136))
        (call L.*.18 (call L.-.19 180 33) (call L.+.17 247 156)))
       (call
        L.-.19
        (call L.-.19 (call L.+.17 238 202) (call L.+.17 72 39))
        (call L.-.19 (call L.+.17 98 175) (call L.*.18 74 242)))))))
(check-by-interp
 '(module
    (define L.+.19
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.-.18
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fun/empty104399.4 (lambda () (call L.fun/empty104400.8)))
    (define L.fun/void104397.5 (lambda () (call L.fun/void104398.12)))
    (define L.fun/error104406.6 (lambda () (error 206)))
    (define L.fun/empty104404.7 (lambda () empty))
    (define L.fun/empty104400.8 (lambda () empty))
    (define L.fun/error104405.9 (lambda () (call L.fun/error104406.6)))
    (define L.fun/empty104395.10 (lambda () (call L.fun/empty104396.14)))
    (define L.fun/void104401.11 (lambda () (call L.fun/void104402.13)))
    (define L.fun/void104398.12 (lambda () (void)))
    (define L.fun/void104402.13 (lambda () (void)))
    (define L.fun/empty104396.14 (lambda () empty))
    (define L.fun/empty104403.15 (lambda () (call L.fun/empty104404.7)))
    (let ((empty0.6 (call L.fun/empty104395.10))
          (void1.5 (call L.fun/void104397.5))
          (empty2.4 (call L.fun/empty104399.4))
          (void3.3 (call L.fun/void104401.11))
          (fixnum4.2
           (call
            L.*.17
            (call
             L.*.17
             (call L.-.18 (call L.*.17 135 123) (call L.*.17 16 197))
             (call L.*.17 (call L.-.18 168 72) (call L.*.17 104 70)))
            (call
             L.*.17
             (call L.-.18 (call L.+.19 178 71) (call L.+.19 189 97))
             (call L.+.19 (call L.*.17 26 168) (call L.-.18 76 162)))))
          (empty5.1 (call L.fun/empty104403.15)))
      (call L.fun/error104405.9))))
(check-by-interp
 '(module
    (define L.boolean?.16 (lambda (tmp.44) (boolean? tmp.44)))
    (define L.fun/any105578.4 (lambda () 188))
    (define L.fun/error105579.5 (lambda () (call L.fun/error105580.11)))
    (define L.fun/error105575.6 (lambda () (error 72)))
    (define L.fun/ascii-char105573.7 (lambda () #\c))
    (define L.fun/error105576.8 (lambda () (call L.fun/error105577.13)))
    (define L.fun/ascii-char105572.9
      (lambda () (call L.fun/ascii-char105573.7)))
    (define L.fun/void105581.10 (lambda () (call L.fun/void105582.14)))
    (define L.fun/error105580.11 (lambda () (error 121)))
    (define L.fun/error105574.12 (lambda () (call L.fun/error105575.6)))
    (define L.fun/error105577.13 (lambda () (error 216)))
    (define L.fun/void105582.14 (lambda () (void)))
    (let ((ascii-char0.6 (call L.fun/ascii-char105572.9))
          (error1.5 (call L.fun/error105574.12))
          (error2.4 (call L.fun/error105576.8))
          (boolean3.3 (call L.boolean?.16 (call L.fun/any105578.4)))
          (error4.2 (call L.fun/error105579.5))
          (void5.1 (call L.fun/void105581.10)))
      void5.1)))
(check-by-interp
 '(module
    (define L.ascii-char?.16 (lambda (tmp.47) (ascii-char? tmp.47)))
    (define L.fun/void121813.4 (lambda () (void)))
    (define L.fun/ascii-char121818.5
      (lambda () (call L.fun/ascii-char121819.11)))
    (define L.fun/void121814.6 (lambda () (call L.fun/void121815.12)))
    (define L.fun/ascii-char121816.7
      (lambda () (call L.fun/ascii-char121817.9)))
    (define L.fun/void121812.8 (lambda () (call L.fun/void121813.4)))
    (define L.fun/ascii-char121817.9 (lambda () #\c))
    (define L.fun/ascii-char121811.10 (lambda () #\c))
    (define L.fun/ascii-char121819.11 (lambda () #\c))
    (define L.fun/void121815.12 (lambda () (void)))
    (define L.fun/ascii-char121810.13
      (lambda () (call L.fun/ascii-char121811.10)))
    (define L.fun/any121809.14 (lambda () #f))
    (let ((boolean0.6 (call L.ascii-char?.16 (call L.fun/any121809.14)))
          (ascii-char1.5 (call L.fun/ascii-char121810.13))
          (void2.4 (call L.fun/void121812.8))
          (void3.3 (call L.fun/void121814.6))
          (ascii-char4.2 (call L.fun/ascii-char121816.7))
          (ascii-char5.1 (call L.fun/ascii-char121818.5)))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.-.13
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.fun/error128005.4 (lambda () (call L.fun/error128006.9)))
    (define L.fun/empty128002.5 (lambda () empty))
    (define L.fun/void128004.6 (lambda () (void)))
    (define L.fun/empty128001.7 (lambda () (call L.fun/empty128002.5)))
    (define L.fun/empty128008.8 (lambda () empty))
    (define L.fun/error128006.9 (lambda () (error 36)))
    (define L.fun/empty128007.10 (lambda () (call L.fun/empty128008.8)))
    (define L.fun/void128003.11 (lambda () (call L.fun/void128004.6)))
    (let ((fixnum0.6
           (call
            L.-.13
            (call
             L.*.14
             (call L.*.14 (call L.-.13 164 143) (call L.*.14 135 252))
             (call L.*.14 (call L.+.15 5 173) (call L.*.14 234 229)))
            (call
             L.*.14
             (call L.*.14 (call L.-.13 126 33) (call L.-.13 172 119))
             (call L.*.14 (call L.-.13 172 58) (call L.-.13 97 82)))))
          (empty1.5 (call L.fun/empty128001.7))
          (void2.4 (call L.fun/void128003.11))
          (error3.3 (call L.fun/error128005.4))
          (fixnum4.2
           (call
            L.-.13
            (call
             L.+.15
             (call L.*.14 (call L.*.14 102 116) (call L.+.15 216 103))
             (call L.*.14 (call L.+.15 185 217) (call L.*.14 227 97)))
            (call
             L.-.13
             (call L.-.13 (call L.+.15 159 138) (call L.-.13 239 158))
             (call L.*.14 (call L.-.13 246 106) (call L.-.13 195 1)))))
          (empty5.1 (call L.fun/empty128007.10)))
      empty5.1)))
(check-by-interp
 '(module
    (define L.+.19
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.18
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.-.17
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.fun/ascii-char138303.4 (lambda () #\c))
    (define L.fun/empty138301.5 (lambda () empty))
    (define L.fun/empty138304.6 (lambda () (call L.fun/empty138305.13)))
    (define L.fun/empty138307.7 (lambda () empty))
    (define L.fun/empty138306.8 (lambda () (call L.fun/empty138307.7)))
    (define L.fun/ascii-char138302.9
      (lambda () (call L.fun/ascii-char138303.4)))
    (define L.fun/ascii-char138308.10
      (lambda () (call L.fun/ascii-char138309.12)))
    (define L.fun/error138310.11 (lambda () (call L.fun/error138311.15)))
    (define L.fun/ascii-char138309.12 (lambda () #\c))
    (define L.fun/empty138305.13 (lambda () empty))
    (define L.fun/empty138300.14 (lambda () (call L.fun/empty138301.5)))
    (define L.fun/error138311.15 (lambda () (error 113)))
    (let ((empty0.6 (call L.fun/empty138300.14))
          (ascii-char1.5 (call L.fun/ascii-char138302.9))
          (empty2.4 (call L.fun/empty138304.6))
          (empty3.3 (call L.fun/empty138306.8))
          (fixnum4.2
           (call
            L.*.18
            (call
             L.*.18
             (call L.+.19 (call L.-.17 253 200) (call L.*.18 216 47))
             (call L.-.17 (call L.*.18 188 34) (call L.*.18 45 9)))
            (call
             L.+.19
             (call L.*.18 (call L.-.17 248 181) (call L.*.18 249 3))
             (call L.*.18 (call L.+.19 107 197) (call L.-.17 178 32)))))
          (ascii-char5.1 (call L.fun/ascii-char138308.10)))
      (call L.fun/error138310.11))))
(check-by-interp
 '(module
    (define L.boolean?.19 (lambda (tmp.44) (boolean? tmp.44)))
    (define L.+.18
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.-.17
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.*.16
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fixnum?.15 (lambda (tmp.43) (fixnum? tmp.43)))
    (define L.fun/error139284.4 (lambda () (error 62)))
    (define L.fun/ascii-char139281.5
      (lambda () (call L.fun/ascii-char139282.10)))
    (define L.fun/error139283.6 (lambda () (call L.fun/error139284.4)))
    (define L.fun/void139290.7 (lambda () (void)))
    (define L.fun/any139288.8 (lambda () (error 54)))
    (define L.fun/empty139287.9 (lambda () empty))
    (define L.fun/ascii-char139282.10 (lambda () #\c))
    (define L.fun/any139285.11 (lambda () empty))
    (define L.fun/void139289.12 (lambda () (call L.fun/void139290.7)))
    (define L.fun/empty139286.13 (lambda () (call L.fun/empty139287.9)))
    (let ((ascii-char0.6 (call L.fun/ascii-char139281.5))
          (error1.5 (call L.fun/error139283.6))
          (boolean2.4 (call L.fixnum?.15 (call L.fun/any139285.11)))
          (empty3.3 (call L.fun/empty139286.13))
          (fixnum4.2
           (call
            L.+.18
            (call
             L.+.18
             (call L.-.17 (call L.*.16 245 229) (call L.-.17 210 96))
             (call L.-.17 (call L.-.17 107 190) (call L.*.16 158 137)))
            (call
             L.+.18
             (call L.*.16 (call L.+.18 20 12) (call L.-.17 87 30))
             (call L.-.17 (call L.*.16 110 213) (call L.*.16 212 205)))))
          (boolean5.1 (call L.boolean?.19 (call L.fun/any139288.8))))
      (call L.fun/void139289.12))))
(check-by-interp
 '(module
    (define L.-.11
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.+.10
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.9
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fun/void140574.4 (lambda () (void)))
    (define L.fun/empty140576.5 (lambda () empty))
    (define L.fun/empty140575.6 (lambda () (call L.fun/empty140576.5)))
    (define L.fun/void140573.7 (lambda () (call L.fun/void140574.4)))
    (let ((fixnum0.6
           (call
            L.*.9
            (call
             L.-.11
             (call L.*.9 (call L.*.9 222 42) (call L.+.10 91 91))
             (call L.*.9 (call L.+.10 147 158) (call L.-.11 62 123)))
            (call
             L.-.11
             (call L.+.10 (call L.+.10 190 202) (call L.+.10 3 174))
             (call L.-.11 (call L.+.10 103 182) (call L.+.10 244 30)))))
          (fixnum1.5
           (call
            L.+.10
            (call
             L.*.9
             (call L.+.10 (call L.*.9 178 102) (call L.-.11 98 190))
             (call L.+.10 (call L.-.11 254 210) (call L.*.9 222 41)))
            (call
             L.+.10
             (call L.-.11 (call L.+.10 250 152) (call L.+.10 241 160))
             (call L.-.11 (call L.-.11 15 61) (call L.-.11 129 35)))))
          (fixnum2.4
           (call
            L.*.9
            (call
             L.-.11
             (call L.*.9 (call L.+.10 111 248) (call L.-.11 128 111))
             (call L.+.10 (call L.+.10 63 1) (call L.*.9 64 193)))
            (call
             L.-.11
             (call L.+.10 (call L.*.9 36 95) (call L.-.11 110 120))
             (call L.*.9 (call L.+.10 125 161) (call L.+.10 218 6)))))
          (void3.3 (call L.fun/void140573.7))
          (fixnum4.2
           (call
            L.-.11
            (call
             L.-.11
             (call L.-.11 (call L.-.11 159 245) (call L.-.11 204 81))
             (call L.-.11 (call L.-.11 89 204) (call L.*.9 27 69)))
            (call
             L.-.11
             (call L.+.10 (call L.-.11 243 162) (call L.+.10 234 234))
             (call L.-.11 (call L.+.10 141 218) (call L.*.9 118 60)))))
          (empty5.1 (call L.fun/empty140575.6)))
      void3.3)))
(check-by-interp
 '(module
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.+.13
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.fun/error143927.4 (lambda () (call L.fun/error143928.6)))
    (define L.fun/ascii-char143929.5
      (lambda () (call L.fun/ascii-char143930.11)))
    (define L.fun/error143928.6 (lambda () (error 42)))
    (define L.fun/void143926.7 (lambda () (void)))
    (define L.fun/void143924.8 (lambda () (void)))
    (define L.fun/void143923.9 (lambda () (call L.fun/void143924.8)))
    (define L.fun/void143925.10 (lambda () (call L.fun/void143926.7)))
    (define L.fun/ascii-char143930.11 (lambda () #\c))
    (let ((fixnum0.6
           (call
            L.*.14
            (call
             L.*.14
             (call L.-.15 (call L.+.13 68 174) (call L.*.14 45 168))
             (call L.*.14 (call L.-.15 236 36) (call L.-.15 121 100)))
            (call
             L.+.13
             (call L.-.15 (call L.*.14 4 114) (call L.+.13 86 218))
             (call L.*.14 (call L.-.15 38 71) (call L.*.14 168 32)))))
          (fixnum1.5
           (call
            L.*.14
            (call
             L.+.13
             (call L.*.14 (call L.+.13 206 173) (call L.*.14 208 61))
             (call L.+.13 (call L.+.13 203 24) (call L.*.14 135 52)))
            (call
             L.+.13
             (call L.-.15 (call L.+.13 242 187) (call L.+.13 43 10))
             (call L.-.15 (call L.*.14 216 207) (call L.*.14 130 176)))))
          (void2.4 (call L.fun/void143923.9))
          (void3.3 (call L.fun/void143925.10))
          (error4.2 (call L.fun/error143927.4))
          (fixnum5.1
           (call
            L.+.13
            (call
             L.-.15
             (call L.-.15 (call L.-.15 58 133) (call L.*.14 83 150))
             (call L.+.13 (call L.*.14 144 106) (call L.*.14 56 247)))
            (call
             L.+.13
             (call L.-.15 (call L.+.13 2 16) (call L.+.13 213 11))
             (call L.-.15 (call L.*.14 160 59) (call L.+.13 59 94))))))
      (call L.fun/ascii-char143929.5))))
