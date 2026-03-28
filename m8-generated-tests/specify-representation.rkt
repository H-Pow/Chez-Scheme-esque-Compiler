#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v8
         (only-in "../specify-representation.rkt"))
(define (fail-if-invalid p)
  (when (not (exprs-bits-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "exprs-bits-lang-v8"
      " program")))
  p)
(define (check-by-interp p)
  (interp-exprs-unsafe-data-lang-v8 p)
  (interp-exprs-bits-lang-v8 (fail-if-invalid (specify-representation p))))

(check-by-interp '(module (error 97)))
(check-by-interp '(module empty))
(check-by-interp
 '(module
    (define L.fun/void8390.4 (lambda () (void)))
    (call L.fun/void8390.4)))
(check-by-interp '(module (let ((empty0.1 empty)) (error 83))))
(check-by-interp '(module (let ((void0.2 (void)) (ascii-char1.1 #\c)) 72)))
(check-by-interp
 '(module
    (define L.fun/void8397.4 (lambda (oprand0.1) (void)))
    (call L.fun/void8397.4 (let ((ascii-char0.3 #\c) (boolean1.2 #f)) #t))))
(check-by-interp '(module (if #t (error 72) (error 224))))
(check-by-interp '(module (if #f #\c #\c)))
(check-by-interp '(module (if #t 30 28)))
(check-by-interp '(module (let ((empty0.2 empty) (ascii-char1.1 #\c)) (void))))
(check-by-interp
 '(module
    (define L.fun/error8412.4 (lambda (oprand0.1) (error 116)))
    (call
     L.fun/error8412.4
     (let ((void0.3 (void)) (error1.2 (error 152))) error1.2))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8415.4 (lambda (oprand0.1) #\c))
    (call
     L.fun/ascii-char8415.4
     (let ((ascii-char0.3 #\c) (error1.2 (error 115))) #\c))))
(check-by-interp
 '(module
    (define L.-.8
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx- tmp.21 tmp.22) (error 3))
          (error 3))))
    (define L.+.7
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx+ tmp.19 tmp.20) (error 2))
          (error 2))))
    (define L.fun/empty8418.4 (lambda () empty))
    (define L.fun/ascii-char8419.5 (lambda () #\c))
    (let ((fixnum0.3 (call L.+.7 95 114))
          (fixnum1.2 (call L.-.8 48 208))
          (empty2.1 (call L.fun/empty8418.4)))
      (call L.fun/ascii-char8419.5))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8467.4 (lambda (oprand0.2 oprand1.1) oprand0.2))
    (define L.fun/void8469.5 (lambda (oprand0.4 oprand1.3) (void)))
    (define L.fun/empty8468.6 (lambda (oprand0.6 oprand1.5) empty))
    (call
     L.fun/ascii-char8467.4
     (let ((ascii-char0.9 #\c) (empty1.8 empty) (error2.7 (error 59))) #\c)
     (call
      L.fun/empty8468.6
      (call L.fun/void8469.5 (void) #f)
      (if #f (error 170) (error 254))))))
(check-by-interp
 '(module
    (define L.*.6
      (lambda (tmp.17 tmp.18)
        (if (fixnum? tmp.18)
          (if (fixnum? tmp.17) (unsafe-fx* tmp.17 tmp.18) (error 1))
          (error 1))))
    (define L.-.5
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx- tmp.21 tmp.22) (error 3))
          (error 3))))
    (call
     L.*.6
     (call L.-.5 (if #f 214 86) (if #t 185 16))
     (call
      L.-.5
      (if #f 44 33)
      (let ((ascii-char0.3 #\c) (error1.2 (error 51)) (empty2.1 empty)) 76)))))
(check-by-interp
 '(module
    (define L.*.8
      (lambda (tmp.17 tmp.18)
        (if (fixnum? tmp.18)
          (if (fixnum? tmp.17) (unsafe-fx* tmp.17 tmp.18) (error 1))
          (error 1))))
    (define L.-.7
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx- tmp.21 tmp.22) (error 3))
          (error 3))))
    (define L.vector?.6 (lambda (tmp.47) (vector? tmp.47)))
    (define L.fun/any8734.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) (error 161)))
    (if (call L.vector?.6 (call L.fun/any8734.4 (error 23) empty #\c))
      (call L.*.8 (call L.-.7 185 66) (if #t 186 174))
      (if #t 194 172))))
(check-by-interp
 '(module
    (define L.fun/void8780.4 (lambda () (void)))
    (define L.fun/ascii-char8782.5 (lambda () #\c))
    (define L.fun/void8781.6 (lambda () (void)))
    (define L.fun/error8783.7 (lambda () (error 139)))
    (define L.fun/void8779.8 (lambda () (void)))
    (let ((void0.4 (call L.fun/void8779.8))
          (void1.3 (call L.fun/void8780.4))
          (void2.2 (call L.fun/void8781.6))
          (ascii-char3.1 (call L.fun/ascii-char8782.5)))
      (call L.fun/error8783.7))))
(check-by-interp
 '(module
    (define L.*.10
      (lambda (tmp.18 tmp.19)
        (if (fixnum? tmp.19)
          (if (fixnum? tmp.18) (unsafe-fx* tmp.18 tmp.19) (error 1))
          (error 1))))
    (define L.+.9
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx+ tmp.20 tmp.21) (error 2))
          (error 2))))
    (define L.-.8
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx- tmp.22 tmp.23) (error 3))
          (error 3))))
    (define L.fun/empty8806.4 (lambda () empty))
    (define L.fun/void8807.5 (lambda () (void)))
    (define L.fun/ascii-char8808.6 (lambda () #\c))
    (let ((empty0.4 (call L.fun/empty8806.4))
          (fixnum1.3 (call L.-.8 (call L.-.8 201 108) (call L.+.9 41 44)))
          (fixnum2.2 (call L.-.8 (call L.*.10 40 131) (call L.*.10 137 121)))
          (void3.1 (call L.fun/void8807.5)))
      (call L.fun/ascii-char8808.6))))
(check-by-interp
 '(module
    (define L.error?.16 (lambda (tmp.59) (error? tmp.59)))
    (define L.fixnum?.15 (lambda (tmp.54) (fixnum? tmp.54)))
    (define L.+.14
      (lambda (tmp.33 tmp.34)
        (if (fixnum? tmp.34)
          (if (fixnum? tmp.33) (unsafe-fx+ tmp.33 tmp.34) (error 2))
          (error 2))))
    (define L.vector?.13 (lambda (tmp.61) (vector? tmp.61)))
    (define L.fun/empty9034.4 (lambda (oprand0.3 oprand1.2 oprand2.1) empty))
    (define L.fun/error9036.5 (lambda () (error 184)))
    (define L.fun/error9035.6 (lambda () (error 142)))
    (define L.fun/void9037.7 (lambda () (void)))
    (define L.fun/ascii-char9032.8 (lambda () #\c))
    (define L.fun/empty9038.9 (lambda () empty))
    (define L.fun/ascii-char9031.10
      (lambda (oprand0.6 oprand1.5 oprand2.4) (call L.fun/ascii-char9032.8)))
    (define L.fun/boolean9033.11 (lambda (oprand0.9 oprand1.8 oprand2.7) #t))
    (call
     L.fun/ascii-char9031.10
     (if (call L.fun/boolean9033.11 #\c (error 172) #\c)
       (if #f empty empty)
       (call L.fun/empty9034.4 (error 16) (error 232) #t))
     (let ((boolean0.13 (call L.vector?.13 #\c))
           (fixnum1.12 (call L.+.14 28 24))
           (error2.11 (call L.fun/error9035.6))
           (error3.10 (call L.fun/error9036.5)))
       (call L.fixnum?.15 (void)))
     (let ((ascii-char0.17 (call L.fun/ascii-char9031.10 empty #f #t))
           (void1.16 (call L.fun/void9037.7))
           (ascii-char2.15 (call L.fun/ascii-char9031.10 empty #t #f))
           (empty3.14 (call L.fun/empty9038.9)))
       (call L.error?.16 (void))))))
(check-by-interp
 '(module
    (define L.fun/void9076.4 (lambda () (void)))
    (define L.fun/ascii-char9078.5 (lambda () #\c))
    (define L.fun/error9075.6 (lambda () (error 225)))
    (define L.fun/empty9077.7 (lambda () empty))
    (let ((error0.4 (call L.fun/error9075.6))
          (void1.3 (call L.fun/void9076.4))
          (empty2.2 (call L.fun/empty9077.7))
          (ascii-char3.1 (call L.fun/ascii-char9078.5)))
      empty2.2)))
(check-by-interp
 '(module
    (if (if #f #t #t)
      (let ((fixnum0.4 215)
            (fixnum1.3 123)
            (void2.2 (void))
            (ascii-char3.1 #\c))
        fixnum0.4)
      (if #f 181 177))))
(check-by-interp
 '(module
    (define L.boolean?.10 (lambda (tmp.42) (boolean? tmp.42)))
    (define L.fun/error9365.4 (lambda () (error 242)))
    (define L.fun/error9364.5 (lambda () (error 249)))
    (define L.fun/any9366.6 (lambda () #t))
    (define L.fun/error9363.7 (lambda () (error 238)))
    (define L.fun/empty9362.8 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty9362.8))
          (error1.3 (call L.fun/error9363.7))
          (error2.2 (call L.fun/error9364.5))
          (error3.1 (call L.fun/error9365.4)))
      (call L.boolean?.10 (call L.fun/any9366.6)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char9574.4 (lambda () #\c))
    (define L.fun/void9575.5 (lambda () (void)))
    (define L.fun/void9573.6 (lambda () (void)))
    (define L.fun/empty9572.7 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty9572.7))
          (void1.3 (call L.fun/void9573.6))
          (ascii-char2.2 (call L.fun/ascii-char9574.4))
          (void3.1 (call L.fun/void9575.5)))
      void1.3)))
(check-by-interp
 '(module
    (if (let ((empty0.4 empty)
              (fixnum1.3 121)
              (void2.2 (void))
              (fixnum3.1 112))
          #f)
      (if #t empty empty)
      (let ((empty0.8 empty)
            (error1.7 (error 165))
            (void2.6 (void))
            (fixnum3.5 124))
        empty))))
(check-by-interp
 '(module
    (define L.-.9
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx- tmp.22 tmp.23) (error 3))
          (error 3))))
    (define L.*.8
      (lambda (tmp.18 tmp.19)
        (if (fixnum? tmp.19)
          (if (fixnum? tmp.18) (unsafe-fx* tmp.18 tmp.19) (error 1))
          (error 1))))
    (define L.fun/ascii-char9904.4 (lambda () #\c))
    (define L.fun/void9902.5 (lambda () (void)))
    (define L.fun/ascii-char9903.6 (lambda () #\c))
    (let ((void0.4 (call L.fun/void9902.5))
          (ascii-char1.3 (call L.fun/ascii-char9903.6))
          (fixnum2.2 (call L.-.9 (call L.*.8 63 199) (call L.*.8 69 165)))
          (ascii-char3.1 (call L.fun/ascii-char9904.4)))
      void0.4)))
(check-by-interp
 '(module
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
    (define L.fun/void10674.4 (lambda () (void)))
    (define L.fun/error10675.5 (lambda () (error 251)))
    (define L.fun/void10672.6 (lambda () (void)))
    (define L.fun/empty10673.7 (lambda () empty))
    (let ((fixnum0.5
           (call
            L.-.10
            (call L.+.9 (call L.+.9 139 195) (call L.-.10 113 88))
            (call L.-.10 (call L.+.9 27 93) (call L.-.10 229 244))))
          (void1.4 (call L.fun/void10672.6))
          (empty2.3 (call L.fun/empty10673.7))
          (void3.2 (call L.fun/void10674.4))
          (fixnum4.1
           (call
            L.-.10
            (call L.-.10 (call L.*.11 95 128) (call L.+.9 168 20))
            (call L.-.10 (call L.*.11 142 81) (call L.*.11 92 28)))))
      (call L.fun/error10675.5))))
(check-by-interp
 '(module
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.ascii-char?.9 (lambda (tmp.46) (ascii-char? tmp.46)))
    (define L.fun/any10855.4 (lambda () #\c))
    (define L.fun/ascii-char10854.5 (lambda () #\c))
    (define L.fun/empty10856.6 (lambda () empty))
    (define L.fun/void10857.7 (lambda () (void)))
    (let ((ascii-char0.5 (call L.fun/ascii-char10854.5))
          (boolean1.4 (call L.ascii-char?.9 (call L.fun/any10855.4)))
          (empty2.3 (call L.fun/empty10856.6))
          (fixnum3.2
           (call
            L.+.10
            (call L.-.11 (call L.+.10 169 98) (call L.-.11 1 224))
            (call L.+.10 (call L.-.11 14 124) (call L.+.10 138 6))))
          (void4.1 (call L.fun/void10857.7)))
      empty2.3)))
(check-by-interp
 '(module
    (define L.fun/void11402.4 (lambda () (void)))
    (define L.fun/ascii-char11403.5 (lambda () #\c))
    (define L.fun/ascii-char11400.6 (lambda () #\c))
    (define L.fun/error11401.7 (lambda () (error 59)))
    (define L.fun/ascii-char11399.8 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char11399.8))
          (ascii-char1.4 (call L.fun/ascii-char11400.6))
          (error2.3 (call L.fun/error11401.7))
          (void3.2 (call L.fun/void11402.4))
          (ascii-char4.1 (call L.fun/ascii-char11403.5)))
      void3.2)))
(check-by-interp
 '(module
    (define L.fun/void13621.4 (lambda () (void)))
    (define L.fun/ascii-char13620.5 (lambda () #\c))
    (define L.fun/empty13623.6 (lambda () empty))
    (define L.fun/error13618.7 (lambda () (error 89)))
    (define L.fun/void13619.8 (lambda () (void)))
    (define L.fun/error13622.9 (lambda () (error 98)))
    (let ((error0.5 (call L.fun/error13618.7))
          (void1.4 (call L.fun/void13619.8))
          (ascii-char2.3 (call L.fun/ascii-char13620.5))
          (void3.2 (call L.fun/void13621.4))
          (error4.1 (call L.fun/error13622.9)))
      (call L.fun/empty13623.6))))
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
    (define L.fun/void14228.4 (lambda () (void)))
    (define L.fun/empty14229.5 (lambda () empty))
    (define L.fun/ascii-char14227.6 (lambda () #\c))
    (let ((fixnum0.5
           (call
            L.+.9
            (call L.+.9 (call L.*.8 189 166) (call L.*.8 136 137))
            (call L.*.8 (call L.-.10 191 104) (call L.*.8 24 218))))
          (ascii-char1.4 (call L.fun/ascii-char14227.6))
          (fixnum2.3
           (call
            L.*.8
            (call L.-.10 (call L.+.9 110 180) (call L.-.10 79 40))
            (call L.-.10 (call L.-.10 211 45) (call L.+.9 225 244))))
          (void3.2 (call L.fun/void14228.4))
          (empty4.1 (call L.fun/empty14229.5)))
      empty4.1)))
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
    (define L.fun/void14544.4 (lambda () (void)))
    (define L.fun/empty14543.5 (lambda () empty))
    (define L.fun/ascii-char14546.6 (lambda () #\c))
    (define L.fun/error14545.7 (lambda () (error 0)))
    (define L.fun/error14542.8 (lambda () (error 150)))
    (let ((error0.5 (call L.fun/error14542.8))
          (empty1.4 (call L.fun/empty14543.5))
          (fixnum2.3
           (call
            L.-.12
            (call L.*.10 (call L.*.10 156 36) (call L.*.10 107 69))
            (call L.+.11 (call L.*.10 103 132) (call L.+.11 76 215))))
          (void3.2 (call L.fun/void14544.4))
          (error4.1 (call L.fun/error14545.7)))
      (call L.fun/ascii-char14546.6))))
(check-by-interp
 '(module
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
    (define L.fun/empty15112.4 (lambda () empty))
    (define L.fun/error15114.5 (lambda () (error 44)))
    (define L.fun/empty15111.6 (lambda () empty))
    (define L.fun/ascii-char15115.7 (lambda () #\c))
    (define L.fun/void15113.8 (lambda () (void)))
    (let ((fixnum0.5
           (call
            L.*.10
            (call L.-.11 (call L.*.10 163 174) (call L.*.10 225 46))
            (call L.-.11 (call L.*.10 209 243) (call L.-.11 148 233))))
          (empty1.4 (call L.fun/empty15111.6))
          (empty2.3 (call L.fun/empty15112.4))
          (void3.2 (call L.fun/void15113.8))
          (error4.1 (call L.fun/error15114.5)))
      (call L.fun/ascii-char15115.7))))
(check-by-interp
 '(module
    (define L.fixnum?.11 (lambda (tmp.42) (fixnum? tmp.42)))
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
    (define L.fun/empty16025.4 (lambda () empty))
    (define L.fun/ascii-char16027.5 (lambda () #\c))
    (define L.fun/any16026.6 (lambda () (void)))
    (let ((empty0.5 (call L.fun/empty16025.4))
          (fixnum1.4
           (call
            L.-.10
            (call L.-.10 (call L.*.8 7 28) (call L.+.9 42 48))
            (call L.*.8 (call L.-.10 242 84) (call L.-.10 137 220))))
          (fixnum2.3
           (call
            L.*.8
            (call L.*.8 (call L.*.8 7 176) (call L.*.8 1 66))
            (call L.*.8 (call L.+.9 59 47) (call L.-.10 125 82))))
          (fixnum3.2
           (call
            L.+.9
            (call L.*.8 (call L.*.8 133 58) (call L.*.8 136 188))
            (call L.*.8 (call L.+.9 166 131) (call L.*.8 229 70))))
          (boolean4.1 (call L.fixnum?.11 (call L.fun/any16026.6))))
      (call L.fun/ascii-char16027.5))))
(check-by-interp
 '(module
    (define L.*.12
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
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
    (define L.fun/ascii-char19237.4 (lambda () #\c))
    (define L.fun/ascii-char19236.5 (lambda () #\c))
    (define L.fun/error19239.6 (lambda () (error 216)))
    (define L.fun/void19235.7 (lambda () (void)))
    (define L.fun/error19238.8 (lambda () (error 84)))
    (let ((void0.5 (call L.fun/void19235.7))
          (ascii-char1.4 (call L.fun/ascii-char19236.5))
          (ascii-char2.3 (call L.fun/ascii-char19237.4))
          (error3.2 (call L.fun/error19238.8))
          (error4.1 (call L.fun/error19239.6)))
      (call
       L.-.10
       (call L.-.10 (call L.-.10 219 20) (call L.+.11 57 154))
       (call L.*.12 (call L.-.10 99 179) (call L.-.10 231 194))))))
(check-by-interp
 '(module
    (define L.*.12
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
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
    (define L.fun/empty20765.4 (lambda () empty))
    (define L.fun/ascii-char20767.5 (lambda () #\c))
    (define L.fun/ascii-char20768.6 (lambda () #\c))
    (define L.fun/empty20764.7 (lambda () empty))
    (define L.fun/error20766.8 (lambda () (error 252)))
    (let ((empty0.5 (call L.fun/empty20764.7))
          (empty1.4 (call L.fun/empty20765.4))
          (error2.3 (call L.fun/error20766.8))
          (ascii-char3.2 (call L.fun/ascii-char20767.5))
          (ascii-char4.1 (call L.fun/ascii-char20768.6)))
      (call
       L.*.12
       (call L.-.10 (call L.-.10 188 148) (call L.+.11 202 162))
       (call L.*.12 (call L.-.10 1 159) (call L.*.12 111 66))))))
(check-by-interp
 '(module
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
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.fun/ascii-char21096.4 (lambda () #\c))
    (define L.fun/ascii-char21098.5 (lambda () #\c))
    (define L.fun/error21099.6 (lambda () (error 129)))
    (define L.fun/ascii-char21097.7 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char21096.4))
          (fixnum1.4
           (call
            L.+.9
            (call L.+.9 (call L.+.9 151 247) (call L.*.10 179 4))
            (call L.+.9 (call L.*.10 175 57) (call L.-.11 111 209))))
          (ascii-char2.3 (call L.fun/ascii-char21097.7))
          (ascii-char3.2 (call L.fun/ascii-char21098.5))
          (fixnum4.1
           (call
            L.-.11
            (call L.-.11 (call L.*.10 129 225) (call L.+.9 69 70))
            (call L.-.11 (call L.-.11 178 46) (call L.-.11 108 37)))))
      (call L.fun/error21099.6))))
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
    (define L.fun/void21257.4 (lambda () (void)))
    (define L.fun/void21255.5 (lambda () (void)))
    (define L.fun/void21256.6 (lambda () (void)))
    (define L.fun/ascii-char21254.7 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char21254.7))
          (void1.4 (call L.fun/void21255.5))
          (fixnum2.3
           (call
            L.-.10
            (call L.-.10 (call L.+.9 216 92) (call L.-.10 203 24))
            (call L.+.9 (call L.-.10 20 111) (call L.-.10 246 240))))
          (void3.2 (call L.fun/void21256.6))
          (void4.1 (call L.fun/void21257.4)))
      void1.4)))
(check-by-interp
 '(module
    (define L.fun/error21502.4 (lambda () (error 49)))
    (define L.fun/empty21506.5 (lambda () empty))
    (define L.fun/empty21503.6 (lambda () empty))
    (define L.fun/error21505.7 (lambda () (error 178)))
    (define L.fun/empty21504.8 (lambda () empty))
    (let ((error0.5 (call L.fun/error21502.4))
          (empty1.4 (call L.fun/empty21503.6))
          (empty2.3 (call L.fun/empty21504.8))
          (error3.2 (call L.fun/error21505.7))
          (empty4.1 (call L.fun/empty21506.5)))
      error0.5)))
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
    (define L.fun/empty21523.4 (lambda () empty))
    (define L.fun/void21525.5 (lambda () (void)))
    (define L.fun/void21524.6 (lambda () (void)))
    (define L.fun/void21527.7 (lambda () (void)))
    (define L.fun/ascii-char21526.8 (lambda () #\c))
    (let ((empty0.5 (call L.fun/empty21523.4))
          (void1.4 (call L.fun/void21524.6))
          (void2.3 (call L.fun/void21525.5))
          (ascii-char3.2 (call L.fun/ascii-char21526.8))
          (void4.1 (call L.fun/void21527.7)))
      (call
       L.+.12
       (call L.-.11 (call L.*.10 134 181) (call L.-.11 62 177))
       (call L.+.12 (call L.-.11 10 151) (call L.-.11 111 129))))))
(check-by-interp
 '(module
    (define L.fun/void22132.4 (lambda () (void)))
    (define L.fun/void22129.5 (lambda () (void)))
    (define L.fun/void22131.6 (lambda () (void)))
    (define L.fun/empty22130.7 (lambda () empty))
    (define L.fun/ascii-char22133.8 (lambda () #\c))
    (let ((void0.5 (call L.fun/void22129.5))
          (empty1.4 (call L.fun/empty22130.7))
          (void2.3 (call L.fun/void22131.6))
          (void3.2 (call L.fun/void22132.4))
          (ascii-char4.1 (call L.fun/ascii-char22133.8)))
      ascii-char4.1)))
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
    (define L.fun/ascii-char35206.4 (lambda () (call L.fun/ascii-char35207.9)))
    (define L.fun/ascii-char35208.5
      (lambda () (call L.fun/ascii-char35209.10)))
    (define L.fun/empty35210.6 (lambda () (call L.fun/empty35211.13)))
    (define L.fun/error35213.7 (lambda () (error 142)))
    (define L.fun/void35214.8 (lambda () (call L.fun/void35215.11)))
    (define L.fun/ascii-char35207.9 (lambda () #\c))
    (define L.fun/ascii-char35209.10 (lambda () #\c))
    (define L.fun/void35215.11 (lambda () (void)))
    (define L.fun/error35212.12 (lambda () (call L.fun/error35213.7)))
    (define L.fun/empty35211.13 (lambda () empty))
    (let ((ascii-char0.6 (call L.fun/ascii-char35206.4))
          (ascii-char1.5 (call L.fun/ascii-char35208.5))
          (empty2.4 (call L.fun/empty35210.6))
          (error3.3 (call L.fun/error35212.12))
          (fixnum4.2
           (call
            L.+.16
            (call
             L.-.17
             (call L.+.16 (call L.*.15 3 14) (call L.+.16 147 101))
             (call L.+.16 (call L.-.17 219 195) (call L.*.15 5 175)))
            (call
             L.-.17
             (call L.-.17 (call L.-.17 85 142) (call L.-.17 127 130))
             (call L.+.16 (call L.-.17 32 36) (call L.+.16 35 193)))))
          (void5.1 (call L.fun/void35214.8)))
      ascii-char1.5)))
(check-by-interp
 '(module
    (define L.error?.19 (lambda (tmp.48) (error? tmp.48)))
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
    (define L.void?.15 (lambda (tmp.46) (void? tmp.46)))
    (define L.fun/void43341.4 (lambda () (call L.fun/void43342.11)))
    (define L.fun/empty43339.5 (lambda () empty))
    (define L.fun/any43337.6 (lambda () (error 53)))
    (define L.fun/any43340.7 (lambda () 60))
    (define L.fun/empty43335.8 (lambda () (call L.fun/empty43336.13)))
    (define L.fun/empty43333.9 (lambda () (call L.fun/empty43334.12)))
    (define L.fun/empty43338.10 (lambda () (call L.fun/empty43339.5)))
    (define L.fun/void43342.11 (lambda () (void)))
    (define L.fun/empty43334.12 (lambda () empty))
    (define L.fun/empty43336.13 (lambda () empty))
    (let ((empty0.6 (call L.fun/empty43333.9))
          (empty1.5 (call L.fun/empty43335.8))
          (boolean2.4 (call L.void?.15 (call L.fun/any43337.6)))
          (fixnum3.3
           (call
            L.+.18
            (call
             L.+.18
             (call L.*.16 (call L.*.16 104 88) (call L.-.17 130 229))
             (call L.+.18 (call L.-.17 119 71) (call L.+.18 174 235)))
            (call
             L.*.16
             (call L.+.18 (call L.*.16 77 57) (call L.-.17 241 54))
             (call L.*.16 (call L.+.18 50 172) (call L.*.16 72 240)))))
          (empty4.2 (call L.fun/empty43338.10))
          (boolean5.1 (call L.error?.19 (call L.fun/any43340.7))))
      (call L.fun/void43341.4))))
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
    (define L.fun/ascii-char44115.4
      (lambda () (call L.fun/ascii-char44116.11)))
    (define L.fun/ascii-char44119.5
      (lambda () (call L.fun/ascii-char44120.10)))
    (define L.fun/empty44111.6 (lambda () (call L.fun/empty44112.13)))
    (define L.fun/void44117.7 (lambda () (call L.fun/void44118.9)))
    (define L.fun/ascii-char44114.8 (lambda () #\c))
    (define L.fun/void44118.9 (lambda () (void)))
    (define L.fun/ascii-char44120.10 (lambda () #\c))
    (define L.fun/ascii-char44116.11 (lambda () #\c))
    (define L.fun/ascii-char44113.12
      (lambda () (call L.fun/ascii-char44114.8)))
    (define L.fun/empty44112.13 (lambda () empty))
    (let ((empty0.6 (call L.fun/empty44111.6))
          (ascii-char1.5 (call L.fun/ascii-char44113.12))
          (ascii-char2.4 (call L.fun/ascii-char44115.4))
          (void3.3 (call L.fun/void44117.7))
          (fixnum4.2
           (call
            L.+.16
            (call
             L.+.16
             (call L.+.16 (call L.*.15 61 221) (call L.*.15 124 246))
             (call L.+.16 (call L.*.15 163 15) (call L.*.15 37 42)))
            (call
             L.-.17
             (call L.*.15 (call L.*.15 25 17) (call L.*.15 68 127))
             (call L.-.17 (call L.*.15 180 89) (call L.-.17 248 176)))))
          (ascii-char5.1 (call L.fun/ascii-char44119.5)))
      (call
       L.-.17
       (call
        L.+.16
        (call L.-.17 (call L.+.16 52 92) (call L.-.17 fixnum4.2 17))
        (call L.-.17 (call L.+.16 65 24) (call L.*.15 fixnum4.2 fixnum4.2)))
       (call
        L.*.15
        fixnum4.2
        (call L.*.15 fixnum4.2 (call L.*.15 55 fixnum4.2)))))))
(check-by-interp
 '(module
    (define L.fixnum?.15 (lambda (tmp.43) (fixnum? tmp.43)))
    (define L.+.14
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.13
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.-.12
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.fun/empty58877.4 (lambda () empty))
    (define L.fun/error58875.5 (lambda () (error 150)))
    (define L.fun/ascii-char58879.6 (lambda () #\c))
    (define L.fun/any58880.7 (lambda () #f))
    (define L.fun/empty58876.8 (lambda () (call L.fun/empty58877.4)))
    (define L.fun/ascii-char58878.9 (lambda () (call L.fun/ascii-char58879.6)))
    (define L.fun/error58874.10 (lambda () (call L.fun/error58875.5)))
    (let ((fixnum0.6
           (call
            L.+.14
            (call
             L.-.12
             (call L.-.12 (call L.-.12 253 149) (call L.*.13 59 231))
             (call L.-.12 (call L.-.12 187 25) (call L.*.13 117 50)))
            (call
             L.*.13
             (call L.*.13 (call L.-.12 175 64) (call L.+.14 38 71))
             (call L.-.12 (call L.-.12 125 238) (call L.*.13 66 56)))))
          (fixnum1.5
           (call
            L.*.13
            (call
             L.+.14
             (call L.+.14 (call L.-.12 111 1) (call L.*.13 197 162))
             (call L.*.13 (call L.-.12 161 250) (call L.+.14 61 136)))
            (call
             L.+.14
             (call L.+.14 (call L.-.12 174 129) (call L.+.14 222 67))
             (call L.-.12 (call L.*.13 127 252) (call L.-.12 210 217)))))
          (error2.4 (call L.fun/error58874.10))
          (empty3.3 (call L.fun/empty58876.8))
          (ascii-char4.2 (call L.fun/ascii-char58878.9))
          (boolean5.1 (call L.fixnum?.15 (call L.fun/any58880.7))))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.void?.13 (lambda (tmp.46) (void? tmp.46)))
    (define L.-.12
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.+.11
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.10
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fun/ascii-char63953.4 (lambda () #\c))
    (define L.fun/error63956.5 (lambda () (error 78)))
    (define L.fun/ascii-char63952.6 (lambda () (call L.fun/ascii-char63953.4)))
    (define L.fun/error63955.7 (lambda () (call L.fun/error63956.5)))
    (define L.fun/any63954.8 (lambda () 223))
    (let ((fixnum0.6
           (call
            L.+.11
            (call
             L.+.11
             (call L.+.11 (call L.*.10 28 253) (call L.*.10 190 215))
             (call L.*.10 (call L.+.11 221 85) (call L.-.12 186 105)))
            (call
             L.+.11
             (call L.-.12 (call L.-.12 240 174) (call L.+.11 204 128))
             (call L.*.10 (call L.*.10 137 126) (call L.+.11 52 52)))))
          (ascii-char1.5 (call L.fun/ascii-char63952.6))
          (fixnum2.4
           (call
            L.-.12
            (call
             L.-.12
             (call L.+.11 (call L.+.11 53 15) (call L.-.12 99 8))
             (call L.*.10 (call L.*.10 117 30) (call L.*.10 149 47)))
            (call
             L.*.10
             (call L.-.12 (call L.-.12 174 234) (call L.+.11 128 38))
             (call L.+.11 (call L.-.12 222 86) (call L.+.11 69 155)))))
          (fixnum3.3
           (call
            L.-.12
            (call
             L.*.10
             (call L.+.11 (call L.+.11 109 231) (call L.+.11 16 242))
             (call L.*.10 (call L.-.12 167 32) (call L.*.10 250 197)))
            (call
             L.*.10
             (call L.+.11 (call L.+.11 191 144) (call L.+.11 224 102))
             (call L.*.10 (call L.+.11 64 254) (call L.*.10 129 45)))))
          (boolean4.2 (call L.void?.13 (call L.fun/any63954.8)))
          (error5.1 (call L.fun/error63955.7)))
      ascii-char1.5)))
(check-by-interp
 '(module
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
    (define L.+.15
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.fun/ascii-char71274.4 (lambda () #\c))
    (define L.fun/void71278.5 (lambda () (void)))
    (define L.fun/ascii-char71271.6 (lambda () (call L.fun/ascii-char71272.9)))
    (define L.fun/ascii-char71273.7 (lambda () (call L.fun/ascii-char71274.4)))
    (define L.fun/empty71270.8 (lambda () empty))
    (define L.fun/ascii-char71272.9 (lambda () #\c))
    (define L.fun/ascii-char71275.10
      (lambda () (call L.fun/ascii-char71276.13)))
    (define L.fun/void71277.11 (lambda () (call L.fun/void71278.5)))
    (define L.fun/empty71269.12 (lambda () (call L.fun/empty71270.8)))
    (define L.fun/ascii-char71276.13 (lambda () #\c))
    (let ((fixnum0.6
           (call
            L.*.16
            (call
             L.+.15
             (call L.*.16 (call L.+.15 13 42) (call L.+.15 111 225))
             (call L.-.17 (call L.-.17 109 168) (call L.+.15 170 85)))
            (call
             L.-.17
             (call L.-.17 (call L.+.15 9 156) (call L.+.15 112 170))
             (call L.+.15 (call L.*.16 85 19) (call L.-.17 138 174)))))
          (empty1.5 (call L.fun/empty71269.12))
          (ascii-char2.4 (call L.fun/ascii-char71271.6))
          (ascii-char3.3 (call L.fun/ascii-char71273.7))
          (ascii-char4.2 (call L.fun/ascii-char71275.10))
          (void5.1 (call L.fun/void71277.11)))
      empty1.5)))
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
    (define L.fun/empty73456.4 (lambda () (call L.fun/empty73457.8)))
    (define L.fun/ascii-char73458.5
      (lambda () (call L.fun/ascii-char73459.10)))
    (define L.fun/empty73463.6 (lambda () empty))
    (define L.fun/error73460.7 (lambda () (call L.fun/error73461.9)))
    (define L.fun/empty73457.8 (lambda () empty))
    (define L.fun/error73461.9 (lambda () (error 80)))
    (define L.fun/ascii-char73459.10 (lambda () #\c))
    (define L.fun/empty73462.11 (lambda () (call L.fun/empty73463.6)))
    (let ((fixnum0.6
           (call
            L.+.15
            (call
             L.-.14
             (call L.-.14 (call L.*.13 236 253) (call L.*.13 87 183))
             (call L.+.15 (call L.*.13 168 52) (call L.-.14 58 11)))
            (call
             L.-.14
             (call L.+.15 (call L.*.13 5 220) (call L.-.14 13 211))
             (call L.-.14 (call L.+.15 244 119) (call L.*.13 158 73)))))
          (empty1.5 (call L.fun/empty73456.4))
          (ascii-char2.4 (call L.fun/ascii-char73458.5))
          (error3.3 (call L.fun/error73460.7))
          (fixnum4.2
           (call
            L.-.14
            (call
             L.*.13
             (call L.-.14 (call L.-.14 251 188) (call L.+.15 221 232))
             (call L.-.14 (call L.-.14 110 216) (call L.*.13 249 19)))
            (call
             L.-.14
             (call L.*.13 (call L.*.13 105 84) (call L.+.15 213 46))
             (call L.*.13 (call L.*.13 78 249) (call L.-.14 247 115)))))
          (empty5.1 (call L.fun/empty73462.11)))
      error3.3)))
(check-by-interp
 '(module
    (define L.+.17
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.-.16
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fun/void77842.4 (lambda () (call L.fun/void77843.9)))
    (define L.fun/void77838.5 (lambda () (call L.fun/void77839.10)))
    (define L.fun/error77846.6 (lambda () (call L.fun/error77847.13)))
    (define L.fun/error77845.7 (lambda () (error 242)))
    (define L.fun/empty77840.8 (lambda () (call L.fun/empty77841.11)))
    (define L.fun/void77843.9 (lambda () (void)))
    (define L.fun/void77839.10 (lambda () (void)))
    (define L.fun/empty77841.11 (lambda () empty))
    (define L.fun/error77844.12 (lambda () (call L.fun/error77845.7)))
    (define L.fun/error77847.13 (lambda () (error 190)))
    (let ((void0.6 (call L.fun/void77838.5))
          (fixnum1.5
           (call
            L.+.17
            (call
             L.+.17
             (call L.+.17 (call L.*.15 195 100) (call L.-.16 235 242))
             (call L.*.15 (call L.*.15 27 94) (call L.-.16 151 100)))
            (call
             L.-.16
             (call L.-.16 (call L.-.16 1 94) (call L.-.16 181 151))
             (call L.*.15 (call L.+.17 154 223) (call L.-.16 161 157)))))
          (empty2.4 (call L.fun/empty77840.8))
          (void3.3 (call L.fun/void77842.4))
          (error4.2 (call L.fun/error77844.12))
          (error5.1 (call L.fun/error77846.6)))
      empty2.4)))
(check-by-interp
 '(module
    (define L.ascii-char?.17 (lambda (tmp.47) (ascii-char? tmp.47)))
    (define L.boolean?.16 (lambda (tmp.44) (boolean? tmp.44)))
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
    (define L.fun/any78095.4 (lambda () #f))
    (define L.fun/void78099.5 (lambda () (void)))
    (define L.fun/error78092.6 (lambda () (call L.fun/error78093.9)))
    (define L.fun/any78094.7 (lambda () #f))
    (define L.fun/error78097.8 (lambda () (error 143)))
    (define L.fun/error78093.9 (lambda () (error 94)))
    (define L.fun/error78096.10 (lambda () (call L.fun/error78097.8)))
    (define L.fun/void78098.11 (lambda () (call L.fun/void78099.5)))
    (let ((error0.6 (call L.fun/error78092.6))
          (fixnum1.5
           (call
            L.-.13
            (call
             L.+.15
             (call L.-.13 (call L.-.13 149 60) (call L.*.14 198 7))
             (call L.-.13 (call L.+.15 186 16) (call L.+.15 61 215)))
            (call
             L.-.13
             (call L.-.13 (call L.*.14 164 205) (call L.*.14 148 108))
             (call L.*.14 (call L.*.14 26 37) (call L.*.14 100 4)))))
          (boolean2.4 (call L.boolean?.16 (call L.fun/any78094.7)))
          (boolean3.3 (call L.ascii-char?.17 (call L.fun/any78095.4)))
          (fixnum4.2
           (call
            L.-.13
            (call
             L.+.15
             (call L.+.15 (call L.*.14 17 173) (call L.-.13 223 74))
             (call L.*.14 (call L.+.15 192 73) (call L.*.14 191 188)))
            (call
             L.+.15
             (call L.-.13 (call L.*.14 192 228) (call L.*.14 220 105))
             (call L.-.13 (call L.-.13 233 129) (call L.-.13 11 86)))))
          (error5.1 (call L.fun/error78096.10)))
      (call L.fun/void78098.11))))
(check-by-interp
 '(module
    (define L.boolean?.17 (lambda (tmp.44) (boolean? tmp.44)))
    (define L.-.16
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.+.14
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.fun/void101999.4 (lambda () (void)))
    (define L.fun/empty101997.5 (lambda () empty))
    (define L.fun/ascii-char101994.6
      (lambda () (call L.fun/ascii-char101995.11)))
    (define L.fun/void101992.7 (lambda () (call L.fun/void101993.12)))
    (define L.fun/void101998.8 (lambda () (call L.fun/void101999.4)))
    (define L.fun/empty101996.9 (lambda () (call L.fun/empty101997.5)))
    (define L.fun/any101991.10 (lambda () (void)))
    (define L.fun/ascii-char101995.11 (lambda () #\c))
    (define L.fun/void101993.12 (lambda () (void)))
    (let ((fixnum0.6
           (call
            L.+.14
            (call
             L.*.15
             (call L.*.15 (call L.+.14 152 31) (call L.+.14 141 66))
             (call L.-.16 (call L.-.16 22 129) (call L.-.16 121 165)))
            (call
             L.-.16
             (call L.+.14 (call L.-.16 53 234) (call L.+.14 60 161))
             (call L.-.16 (call L.-.16 171 175) (call L.+.14 88 68)))))
          (boolean1.5 (call L.boolean?.17 (call L.fun/any101991.10)))
          (void2.4 (call L.fun/void101992.7))
          (ascii-char3.3 (call L.fun/ascii-char101994.6))
          (empty4.2 (call L.fun/empty101996.9))
          (void5.1 (call L.fun/void101998.8)))
      empty4.2)))
(check-by-interp
 '(module
    (define L.fun/void102362.4 (lambda () (call L.fun/void102363.9)))
    (define L.fun/empty102356.5 (lambda () (call L.fun/empty102357.12)))
    (define L.fun/error102354.6 (lambda () (call L.fun/error102355.10)))
    (define L.fun/void102358.7 (lambda () (call L.fun/void102359.13)))
    (define L.fun/void102353.8 (lambda () (void)))
    (define L.fun/void102363.9 (lambda () (void)))
    (define L.fun/error102355.10 (lambda () (error 147)))
    (define L.fun/void102352.11 (lambda () (call L.fun/void102353.8)))
    (define L.fun/empty102357.12 (lambda () empty))
    (define L.fun/void102359.13 (lambda () (void)))
    (define L.fun/void102360.14 (lambda () (call L.fun/void102361.15)))
    (define L.fun/void102361.15 (lambda () (void)))
    (let ((void0.6 (call L.fun/void102352.11))
          (error1.5 (call L.fun/error102354.6))
          (empty2.4 (call L.fun/empty102356.5))
          (void3.3 (call L.fun/void102358.7))
          (void4.2 (call L.fun/void102360.14))
          (void5.1 (call L.fun/void102362.4)))
      error1.5)))
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
    (define L.boolean?.16 (lambda (tmp.44) (boolean? tmp.44)))
    (define L.fun/void122163.4 (lambda () (call L.fun/void122164.13)))
    (define L.fun/ascii-char122159.5
      (lambda () (call L.fun/ascii-char122160.6)))
    (define L.fun/ascii-char122160.6 (lambda () #\c))
    (define L.fun/ascii-char122162.7 (lambda () #\c))
    (define L.fun/empty122158.8 (lambda () empty))
    (define L.fun/error122165.9 (lambda () (call L.fun/error122166.10)))
    (define L.fun/error122166.10 (lambda () (error 183)))
    (define L.fun/any122156.11 (lambda () empty))
    (define L.fun/empty122157.12 (lambda () (call L.fun/empty122158.8)))
    (define L.fun/void122164.13 (lambda () (void)))
    (define L.fun/ascii-char122161.14
      (lambda () (call L.fun/ascii-char122162.7)))
    (let ((boolean0.6 (call L.boolean?.16 (call L.fun/any122156.11)))
          (empty1.5 (call L.fun/empty122157.12))
          (fixnum2.4
           (call
            L.-.17
            (call
             L.-.17
             (call L.-.17 (call L.-.17 171 12) (call L.-.17 195 56))
             (call L.+.19 (call L.-.17 119 28) (call L.*.18 232 210)))
            (call
             L.+.19
             (call L.+.19 (call L.-.17 13 38) (call L.*.18 179 162))
             (call L.*.18 (call L.+.19 91 145) (call L.-.17 52 58)))))
          (ascii-char3.3 (call L.fun/ascii-char122159.5))
          (ascii-char4.2 (call L.fun/ascii-char122161.14))
          (void5.1 (call L.fun/void122163.4)))
      (call L.fun/error122165.9))))
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
    (define L.fun/void124216.4 (lambda () (void)))
    (define L.fun/ascii-char124211.5
      (lambda () (call L.fun/ascii-char124212.10)))
    (define L.fun/error124206.6 (lambda () (error 34)))
    (define L.fun/error124213.7 (lambda () (call L.fun/error124214.11)))
    (define L.fun/ascii-char124207.8
      (lambda () (call L.fun/ascii-char124208.14)))
    (define L.fun/void124215.9 (lambda () (call L.fun/void124216.4)))
    (define L.fun/ascii-char124212.10 (lambda () #\c))
    (define L.fun/error124214.11 (lambda () (error 6)))
    (define L.fun/error124209.12 (lambda () (call L.fun/error124210.13)))
    (define L.fun/error124210.13 (lambda () (error 3)))
    (define L.fun/ascii-char124208.14 (lambda () #\c))
    (define L.fun/error124205.15 (lambda () (call L.fun/error124206.6)))
    (let ((error0.6 (call L.fun/error124205.15))
          (ascii-char1.5 (call L.fun/ascii-char124207.8))
          (error2.4 (call L.fun/error124209.12))
          (ascii-char3.3 (call L.fun/ascii-char124211.5))
          (error4.2 (call L.fun/error124213.7))
          (fixnum5.1
           (call
            L.*.18
            (call
             L.+.17
             (call L.*.18 (call L.+.17 205 2) (call L.+.17 173 15))
             (call L.+.17 (call L.+.17 89 175) (call L.+.17 117 114)))
            (call
             L.+.17
             (call L.*.18 (call L.*.18 168 119) (call L.-.19 81 33))
             (call L.+.17 (call L.-.19 70 194) (call L.+.17 74 119))))))
      (call L.fun/void124215.9))))
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
    (define L.pair?.14 (lambda (tmp.49) (pair? tmp.49)))
    (define L.fun/ascii-char156382.4
      (lambda () (call L.fun/ascii-char156383.11)))
    (define L.fun/void156379.5 (lambda () (call L.fun/void156380.6)))
    (define L.fun/void156380.6 (lambda () (void)))
    (define L.fun/void156387.7 (lambda () (void)))
    (define L.fun/any156381.8 (lambda () (error 44)))
    (define L.fun/void156386.9 (lambda () (call L.fun/void156387.7)))
    (define L.fun/ascii-char156384.10
      (lambda () (call L.fun/ascii-char156385.12)))
    (define L.fun/ascii-char156383.11 (lambda () #\c))
    (define L.fun/ascii-char156385.12 (lambda () #\c))
    (let ((void0.6 (call L.fun/void156379.5))
          (boolean1.5 (call L.pair?.14 (call L.fun/any156381.8)))
          (fixnum2.4
           (call
            L.+.17
            (call
             L.-.15
             (call L.-.15 (call L.-.15 29 252) (call L.-.15 63 38))
             (call L.-.15 (call L.-.15 46 144) (call L.-.15 219 53)))
            (call
             L.*.16
             (call L.-.15 (call L.-.15 217 202) (call L.*.16 40 71))
             (call L.+.17 (call L.+.17 24 153) (call L.-.15 247 252)))))
          (ascii-char3.3 (call L.fun/ascii-char156382.4))
          (ascii-char4.2 (call L.fun/ascii-char156384.10))
          (void5.1 (call L.fun/void156386.9)))
      (call
       L.-.15
       fixnum2.4
       (call
        L.*.16
        fixnum2.4
        (call L.-.15 (call L.+.17 114 243) (call L.+.17 237 fixnum2.4)))))))
(check-by-interp
 '(module
    (define L.-.15
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.+.14
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.13
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fun/empty171686.4 (lambda () (call L.fun/empty171687.10)))
    (define L.fun/void171689.5 (lambda () (void)))
    (define L.fun/ascii-char171684.6
      (lambda () (call L.fun/ascii-char171685.9)))
    (define L.fun/void171688.7 (lambda () (call L.fun/void171689.5)))
    (define L.fun/void171691.8 (lambda () (void)))
    (define L.fun/ascii-char171685.9 (lambda () #\c))
    (define L.fun/empty171687.10 (lambda () empty))
    (define L.fun/void171690.11 (lambda () (call L.fun/void171691.8)))
    (let ((fixnum0.6
           (call
            L.-.15
            (call
             L.-.15
             (call L.+.14 (call L.*.13 251 197) (call L.*.13 136 141))
             (call L.+.14 (call L.-.15 246 6) (call L.*.13 74 78)))
            (call
             L.+.14
             (call L.-.15 (call L.*.13 148 84) (call L.+.14 165 198))
             (call L.-.15 (call L.+.14 221 113) (call L.*.13 116 13)))))
          (fixnum1.5
           (call
            L.-.15
            (call
             L.-.15
             (call L.*.13 (call L.*.13 145 30) (call L.-.15 190 32))
             (call L.+.14 (call L.+.14 120 30) (call L.+.14 78 91)))
            (call
             L.-.15
             (call L.+.14 (call L.-.15 235 135) (call L.*.13 55 125))
             (call L.-.15 (call L.-.15 117 76) (call L.-.15 71 123)))))
          (ascii-char2.4 (call L.fun/ascii-char171684.6))
          (empty3.3 (call L.fun/empty171686.4))
          (void4.2 (call L.fun/void171688.7))
          (void5.1 (call L.fun/void171690.11)))
      fixnum1.5)))
