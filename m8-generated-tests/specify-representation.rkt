#lang racket
(require cpsc411/compiler-lib cpsc411/langs/v8 "../specify-representation.rkt")
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

(check-by-interp '(module #\c))
(check-by-interp '(module (error 191)))
(check-by-interp
 '(module
    (define L.fun/ascii-char8383.4 (lambda () #\c))
    (call L.fun/ascii-char8383.4)))
(check-by-interp
 '(module
    (define L.fun/error8386.4 (lambda () (error 78)))
    (call L.fun/error8386.4)))
(check-by-interp '(module (let ((empty0.1 empty)) (void))))
(check-by-interp '(module (if #f (error 197) (error 225))))
(check-by-interp
 '(module
    (define L.fun/boolean8393.4 (lambda (oprand0.1) #t))
    (call L.fun/boolean8393.4 (if #t 116 182))))
(check-by-interp
 '(module
    (define L.+.6
      (lambda (tmp.17 tmp.18)
        (if (fixnum? tmp.18)
          (if (fixnum? tmp.17) (unsafe-fx+ tmp.17 tmp.18) (error 2))
          (error 2))))
    (define L.fun/fixnum8396.4 (lambda (oprand0.1) 241))
    (call L.+.6 (if #t 74 97) (call L.fun/fixnum8396.4 (void)))))
(check-by-interp
 '(module
    (define L.*.6
      (lambda (tmp.15 tmp.16)
        (if (fixnum? tmp.16)
          (if (fixnum? tmp.15) (unsafe-fx* tmp.15 tmp.16) (error 1))
          (error 1))))
    (define L.fun/void8399.4 (lambda (oprand0.1) (void)))
    (call L.fun/void8399.4 (call L.*.6 135 150))))
(check-by-interp '(module (let ((empty0.2 empty) (empty1.1 empty)) (void))))
(check-by-interp '(module (if #f 6 200)))
(check-by-interp
 '(module
    (define L.fun/error8463.4 (lambda (oprand0.2 oprand1.1) oprand1.1))
    (call
     L.fun/error8463.4
     (let ((ascii-char0.5 #\c) (ascii-char1.4 #\c) (error2.3 (error 245)))
       error2.3)
     (call
      L.fun/error8463.4
      (let ((ascii-char0.8 #\c) (boolean1.7 #f) (void2.6 (void))) (error 222))
      (if #f (error 1) (error 145))))))
(check-by-interp
 '(module
    (define L.*.7
      (lambda (tmp.18 tmp.19)
        (if (fixnum? tmp.19)
          (if (fixnum? tmp.18) (unsafe-fx* tmp.18 tmp.19) (error 1))
          (error 1))))
    (define L.fun/fixnum8490.4 (lambda (oprand0.2 oprand1.1) 21))
    (define L.fun/boolean8489.5 (lambda (oprand0.4 oprand1.3) #f))
    (if (call L.fun/boolean8489.5 (error 248) 76)
      (call L.fun/fixnum8490.4 (void) #t)
      (call L.*.7 214 251))))
(check-by-interp
 '(module
    (define L.fun/empty8497.4 (lambda () empty))
    (define L.fun/void8496.5 (lambda () (void)))
    (define L.fun/ascii-char8498.6 (lambda () #\c))
    (let ((void0.3 (call L.fun/void8496.5))
          (empty1.2 (call L.fun/empty8497.4))
          (ascii-char2.1 (call L.fun/ascii-char8498.6)))
      void0.3)))
(check-by-interp
 '(module
    (define L.*.6
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.fun/fixnum8501.4 (lambda (oprand0.2 oprand1.1) 23))
    (if (let ((void0.5 (void)) (error1.4 (error 162)) (empty2.3 empty)) #t)
      (call L.*.6 26 123)
      (call L.fun/fixnum8501.4 #t (void)))))
(check-by-interp
 '(module
    (define L.+.5
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx+ tmp.19 tmp.20) (error 2))
          (error 2))))
    (if (let ((void0.3 (void)) (ascii-char1.2 #\c) (fixnum2.1 202)) #t)
      (call L.+.5 65 205)
      (call L.+.5 3 49))))
(check-by-interp
 '(module
    (define L.+.8
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx+ tmp.19 tmp.20) (error 2))
          (error 2))))
    (define L.pair?.7 (lambda (tmp.46) (pair? tmp.46)))
    (define L.fun/ascii-char8555.4 (lambda () #\c))
    (define L.fun/void8554.5 (lambda () (void)))
    (let ((boolean0.3 (call L.pair?.7 (error 49)))
          (void1.2 (call L.fun/void8554.5))
          (fixnum2.1 (call L.+.8 92 194)))
      (call L.fun/ascii-char8555.4))))
(check-by-interp
 '(module
    (define L.+.7
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx+ tmp.19 tmp.20) (error 2))
          (error 2))))
    (define L.error?.6 (lambda (tmp.45) (error? tmp.45)))
    (define L.fun/empty8590.4 (lambda () empty))
    (let ((empty0.3 (call L.fun/empty8590.4))
          (boolean1.2 (call L.error?.6 (void)))
          (fixnum2.1 (call L.+.7 174 187)))
      fixnum2.1)))
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
    (define L.fun/void8641.4 (lambda () (void)))
    (define L.fun/empty8642.5 (lambda () empty))
    (define L.fun/void8643.6 (lambda () (void)))
    (let ((void0.4 (call L.fun/void8641.4))
          (empty1.3 (call L.fun/empty8642.5))
          (fixnum2.2 (call L.-.8 (call L.-.8 205 242) (call L.*.9 205 113)))
          (void3.1 (call L.fun/void8643.6)))
      void3.1)))
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
    (define L.fun/error9361.4 (lambda () (error 55)))
    (define L.fun/empty9358.5 (lambda () empty))
    (define L.fun/void9360.6 (lambda () (void)))
    (define L.fun/empty9359.7 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty9358.5))
          (fixnum1.3 (call L.-.10 (call L.*.9 182 165) (call L.*.9 13 1)))
          (empty2.2 (call L.fun/empty9359.7))
          (void3.1 (call L.fun/void9360.6)))
      (call L.fun/error9361.4))))
(check-by-interp
 '(module
    (define L.-.10
      (lambda (tmp.39 tmp.40)
        (if (fixnum? tmp.40)
          (if (fixnum? tmp.39) (unsafe-fx- tmp.39 tmp.40) (error 3))
          (error 3))))
    (define L.+.9
      (lambda (tmp.37 tmp.38)
        (if (fixnum? tmp.38)
          (if (fixnum? tmp.37) (unsafe-fx+ tmp.37 tmp.38) (error 2))
          (error 2))))
    (define L.*.8
      (lambda (tmp.35 tmp.36)
        (if (fixnum? tmp.36)
          (if (fixnum? tmp.35) (unsafe-fx* tmp.35 tmp.36) (error 1))
          (error 1))))
    (define L.fun/void10119.4 (lambda (oprand0.3 oprand1.2 oprand2.1) (void)))
    (define L.fun/fixnum10117.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) oprand1.5))
    (define L.fun/fixnum10118.6 (lambda (oprand0.9 oprand1.8 oprand2.7) 205))
    (call
     L.-.10
     (call
      L.fun/fixnum10117.5
      (if #t (error 108) (error 141))
      (let ((void0.13 (void)) (fixnum1.12 29) (boolean2.11 #t) (fixnum3.10 16))
        fixnum1.12)
      (let ((empty0.17 empty)
            (boolean1.16 #f)
            (void2.15 (void))
            (void3.14 (void)))
        (void)))
     (call
      L.+.9
      (if #f 95 53)
      (call
       L.fun/fixnum10118.6
       (call L.fun/void10119.4 #f #\c empty)
       (let ((boolean0.21 #t)
             (empty1.20 empty)
             (boolean2.19 #t)
             (boolean3.18 #t))
         (error 105))
       (call L.*.8 37 187))))))
(check-by-interp
 '(module
    (define L.+.9
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx+ tmp.20 tmp.21) (error 2))
          (error 2))))
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
    (define L.fun/error10153.4 (lambda () (error 12)))
    (define L.fun/error10154.5 (lambda () (error 19)))
    (let ((error0.4 (call L.fun/error10153.4))
          (fixnum1.3 (call L.*.8 (call L.-.7 135 185) (call L.*.8 237 167)))
          (error2.2 (call L.fun/error10154.5))
          (fixnum3.1 (call L.+.9 (call L.+.9 246 49) (call L.*.8 176 151))))
      error2.2)))
(check-by-interp
 '(module
    (define L.fun/ascii-char11508.4 (lambda () #\c))
    (define L.fun/void11512.5 (lambda () (void)))
    (define L.fun/ascii-char11511.6 (lambda () #\c))
    (define L.fun/empty11507.7 (lambda () empty))
    (define L.fun/empty11509.8 (lambda () empty))
    (define L.fun/error11510.9 (lambda () (error 122)))
    (let ((empty0.5 (call L.fun/empty11507.7))
          (ascii-char1.4 (call L.fun/ascii-char11508.4))
          (empty2.3 (call L.fun/empty11509.8))
          (error3.2 (call L.fun/error11510.9))
          (ascii-char4.1 (call L.fun/ascii-char11511.6)))
      (call L.fun/void11512.5))))
(check-by-interp
 '(module
    (define L.boolean?.11 (lambda (tmp.43) (boolean? tmp.43)))
    (define L.fun/any11902.4 (lambda () #f))
    (define L.fun/ascii-char11900.5 (lambda () #\c))
    (define L.fun/ascii-char11901.6 (lambda () #\c))
    (define L.fun/ascii-char11903.7 (lambda () #\c))
    (define L.fun/void11904.8 (lambda () (void)))
    (define L.fun/empty11899.9 (lambda () empty))
    (let ((empty0.5 (call L.fun/empty11899.9))
          (ascii-char1.4 (call L.fun/ascii-char11900.5))
          (ascii-char2.3 (call L.fun/ascii-char11901.6))
          (boolean3.2 (call L.boolean?.11 (call L.fun/any11902.4)))
          (ascii-char4.1 (call L.fun/ascii-char11903.7)))
      (call L.fun/void11904.8))))
(check-by-interp
 '(module
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
    (define L.+.8
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.fun/void11995.4 (lambda () (void)))
    (define L.fun/ascii-char11994.5 (lambda () #\c))
    (define L.fun/void11996.6 (lambda () (void)))
    (let ((ascii-char0.5 (call L.fun/ascii-char11994.5))
          (void1.4 (call L.fun/void11995.4))
          (void2.3 (call L.fun/void11996.6))
          (fixnum3.2
           (call
            L.-.10
            (call L.+.8 (call L.+.8 250 5) (call L.*.9 94 16))
            (call L.+.8 (call L.+.8 38 236) (call L.-.10 180 46))))
          (fixnum4.1
           (call
            L.*.9
            (call L.*.9 (call L.-.10 173 225) (call L.*.9 12 137))
            (call L.+.8 (call L.+.8 139 45) (call L.*.9 168 159)))))
      (call L.+.8 fixnum4.1 fixnum3.2))))
(check-by-interp
 '(module
    (define L.+.9
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.-.8
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.*.7
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.fun/void11999.4 (lambda () (void)))
    (define L.fun/ascii-char12000.5 (lambda () #\c))
    (let ((fixnum0.5
           (call
            L.+.9
            (call L.*.7 (call L.*.7 248 56) (call L.-.8 156 82))
            (call L.-.8 (call L.+.9 57 175) (call L.+.9 131 140))))
          (fixnum1.4
           (call
            L.+.9
            (call L.+.9 (call L.-.8 45 197) (call L.*.7 221 181))
            (call L.*.7 (call L.*.7 140 242) (call L.*.7 177 131))))
          (void2.3 (call L.fun/void11999.4))
          (fixnum3.2
           (call
            L.+.9
            (call L.*.7 (call L.+.9 85 210) (call L.*.7 98 238))
            (call L.-.8 (call L.*.7 203 209) (call L.*.7 251 129))))
          (ascii-char4.1 (call L.fun/ascii-char12000.5)))
      ascii-char4.1)))
(check-by-interp
 '(module
    (define L.fun/empty12004.4 (lambda () empty))
    (define L.fun/void12007.5 (lambda () (void)))
    (define L.fun/empty12006.6 (lambda () empty))
    (define L.fun/ascii-char12003.7 (lambda () #\c))
    (define L.fun/void12005.8 (lambda () (void)))
    (let ((ascii-char0.5 (call L.fun/ascii-char12003.7))
          (empty1.4 (call L.fun/empty12004.4))
          (void2.3 (call L.fun/void12005.8))
          (empty3.2 (call L.fun/empty12006.6))
          (void4.1 (call L.fun/void12007.5)))
      void4.1)))
(check-by-interp
 '(module
    (define L.fun/ascii-char12857.4 (lambda () #\c))
    (define L.fun/void12858.5 (lambda () (void)))
    (define L.fun/error12860.6 (lambda () (error 144)))
    (define L.fun/error12859.7 (lambda () (error 119)))
    (define L.fun/empty12861.8 (lambda () empty))
    (let ((ascii-char0.5 (call L.fun/ascii-char12857.4))
          (void1.4 (call L.fun/void12858.5))
          (error2.3 (call L.fun/error12859.7))
          (error3.2 (call L.fun/error12860.6))
          (empty4.1 (call L.fun/empty12861.8)))
      empty4.1)))
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
    (define L.fun/ascii-char14008.4 (lambda () #\c))
    (define L.fun/error14007.5 (lambda () (error 128)))
    (define L.fun/void14006.6 (lambda () (void)))
    (let ((fixnum0.5
           (call
            L.-.9
            (call L.+.10 (call L.*.8 192 89) (call L.-.9 209 20))
            (call L.*.8 (call L.-.9 30 228) (call L.*.8 180 215))))
          (void1.4 (call L.fun/void14006.6))
          (fixnum2.3
           (call
            L.*.8
            (call L.-.9 (call L.+.10 35 74) (call L.*.8 55 67))
            (call L.+.10 (call L.-.9 50 93) (call L.-.9 199 135))))
          (error3.2 (call L.fun/error14007.5))
          (ascii-char4.1 (call L.fun/ascii-char14008.4)))
      (call L.*.8 fixnum0.5 fixnum0.5))))
(check-by-interp
 '(module
    (define L.fun/void15239.4 (lambda () (void)))
    (define L.fun/ascii-char15242.5 (lambda () #\c))
    (define L.fun/error15237.6 (lambda () (error 43)))
    (define L.fun/error15240.7 (lambda () (error 16)))
    (define L.fun/error15238.8 (lambda () (error 224)))
    (define L.fun/empty15241.9 (lambda () empty))
    (let ((error0.5 (call L.fun/error15237.6))
          (error1.4 (call L.fun/error15238.8))
          (void2.3 (call L.fun/void15239.4))
          (error3.2 (call L.fun/error15240.7))
          (empty4.1 (call L.fun/empty15241.9)))
      (call L.fun/ascii-char15242.5))))
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
    (define L.fun/void15268.4 (lambda () (void)))
    (define L.fun/void15269.5 (lambda () (void)))
    (define L.fun/empty15270.6 (lambda () empty))
    (define L.fun/void15267.7 (lambda () (void)))
    (let ((void0.5 (call L.fun/void15267.7))
          (void1.4 (call L.fun/void15268.4))
          (void2.3 (call L.fun/void15269.5))
          (empty3.2 (call L.fun/empty15270.6))
          (fixnum4.1
           (call
            L.*.10
            (call L.+.9 (call L.+.9 110 157) (call L.*.10 142 196))
            (call L.-.11 (call L.-.11 35 147) (call L.+.9 151 154)))))
      void0.5)))
(check-by-interp
 '(module
    (define L.-.12
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.ascii-char?.9 (lambda (tmp.46) (ascii-char? tmp.46)))
    (define L.fun/ascii-char15482.4 (lambda () #\c))
    (define L.fun/void15483.5 (lambda () (void)))
    (define L.fun/any15480.6 (lambda () empty))
    (define L.fun/void15481.7 (lambda () (void)))
    (let ((boolean0.5 (call L.ascii-char?.9 (call L.fun/any15480.6)))
          (void1.4 (call L.fun/void15481.7))
          (ascii-char2.3 (call L.fun/ascii-char15482.4))
          (fixnum3.2
           (call
            L.+.10
            (call L.+.10 (call L.+.10 142 247) (call L.+.10 12 162))
            (call L.-.12 (call L.*.11 85 149) (call L.+.10 76 79))))
          (void4.1 (call L.fun/void15483.5)))
      void4.1)))
(check-by-interp
 '(module
    (define L.vector?.12 (lambda (tmp.49) (vector? tmp.49)))
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
    (define L.empty?.9 (lambda (tmp.44) (empty? tmp.44)))
    (define L.fun/any17793.4 (lambda () #\c))
    (define L.fun/error17796.5 (lambda () (error 76)))
    (define L.fun/any17795.6 (lambda () (error 183)))
    (define L.fun/empty17794.7 (lambda () empty))
    (let ((boolean0.5 (call L.empty?.9 (call L.fun/any17793.4)))
          (empty1.4 (call L.fun/empty17794.7))
          (fixnum2.3
           (call
            L.*.10
            (call L.*.10 (call L.*.10 244 242) (call L.-.11 2 140))
            (call L.*.10 (call L.-.11 193 190) (call L.-.11 221 196))))
          (boolean3.2 (call L.vector?.12 (call L.fun/any17795.6)))
          (error4.1 (call L.fun/error17796.5)))
      error4.1)))
(check-by-interp
 '(module
    (define L.boolean?.13 (lambda (tmp.43) (boolean? tmp.43)))
    (define L.*.12
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.-.11
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.fixnum?.10 (lambda (tmp.42) (fixnum? tmp.42)))
    (define L.fun/any20781.4 (lambda () (void)))
    (define L.fun/error20783.5 (lambda () (error 177)))
    (define L.fun/empty20785.6 (lambda () empty))
    (define L.fun/error20782.7 (lambda () (error 164)))
    (define L.fun/any20784.8 (lambda () #t))
    (let ((boolean0.5 (call L.fixnum?.10 (call L.fun/any20781.4)))
          (fixnum1.4
           (call
            L.-.11
            (call L.*.12 (call L.-.11 226 247) (call L.*.12 249 138))
            (call L.*.12 (call L.-.11 192 49) (call L.*.12 69 197))))
          (error2.3 (call L.fun/error20782.7))
          (error3.2 (call L.fun/error20783.5))
          (boolean4.1 (call L.boolean?.13 (call L.fun/any20784.8))))
      (call L.fun/empty20785.6))))
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
    (define L.fun/ascii-char22127.4 (lambda () #\c))
    (define L.fun/error22124.5 (lambda () (error 160)))
    (define L.fun/error22126.6 (lambda () (error 10)))
    (define L.fun/void22125.7 (lambda () (void)))
    (let ((error0.5 (call L.fun/error22124.5))
          (fixnum1.4
           (call
            L.-.10
            (call L.+.9 (call L.+.9 66 23) (call L.-.10 154 19))
            (call L.-.10 (call L.-.10 56 80) (call L.+.9 93 29))))
          (void2.3 (call L.fun/void22125.7))
          (error3.2 (call L.fun/error22126.6))
          (ascii-char4.1 (call L.fun/ascii-char22127.4)))
      void2.3)))
(check-by-interp
 '(module
    (define L.ascii-char?.11 (lambda (tmp.46) (ascii-char? tmp.46)))
    (define L.void?.10 (lambda (tmp.45) (void? tmp.45)))
    (define L.fun/any22156.4 (lambda () (void)))
    (define L.fun/ascii-char22153.5 (lambda () #\c))
    (define L.fun/ascii-char22152.6 (lambda () #\c))
    (define L.fun/void22154.7 (lambda () (void)))
    (define L.fun/any22155.8 (lambda () (void)))
    (let ((ascii-char0.5 (call L.fun/ascii-char22152.6))
          (ascii-char1.4 (call L.fun/ascii-char22153.5))
          (void2.3 (call L.fun/void22154.7))
          (boolean3.2 (call L.void?.10 (call L.fun/any22155.8)))
          (boolean4.1 (call L.ascii-char?.11 (call L.fun/any22156.4))))
      ascii-char1.4)))
(check-by-interp
 '(module
    (define L.*.12
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
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
    (define L.fun/error22341.4 (lambda () (error 156)))
    (define L.fun/void22343.5 (lambda () (void)))
    (define L.fun/empty22340.6 (lambda () empty))
    (define L.fun/empty22342.7 (lambda () empty))
    (define L.fun/void22344.8 (lambda () (void)))
    (let ((empty0.5 (call L.fun/empty22340.6))
          (error1.4 (call L.fun/error22341.4))
          (empty2.3 (call L.fun/empty22342.7))
          (void3.2 (call L.fun/void22343.5))
          (void4.1 (call L.fun/void22344.8)))
      (call
       L.+.10
       (call L.-.11 (call L.+.10 237 212) (call L.+.10 68 144))
       (call L.-.11 (call L.*.12 197 48) (call L.*.12 159 227))))))
(check-by-interp
 '(module
    (define L.empty?.13 (lambda (tmp.44) (empty? tmp.44)))
    (define L.-.12
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.*.11
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
    (define L.+.10
      (lambda (tmp.21 tmp.22)
        (if (fixnum? tmp.22)
          (if (fixnum? tmp.21) (unsafe-fx+ tmp.21 tmp.22) (error 2))
          (error 2))))
    (define L.fun/ascii-char22583.4 (lambda () #\c))
    (define L.fun/any22584.5 (lambda () empty))
    (define L.fun/any22585.6 (lambda () empty))
    (define L.fun/empty22581.7 (lambda () empty))
    (define L.fun/ascii-char22582.8 (lambda () #\c))
    (let ((empty0.5 (call L.fun/empty22581.7))
          (fixnum1.4
           (call
            L.*.11
            (call L.*.11 (call L.+.10 100 46) (call L.+.10 137 22))
            (call L.-.12 (call L.-.12 185 166) (call L.-.12 194 99))))
          (ascii-char2.3 (call L.fun/ascii-char22582.8))
          (ascii-char3.2 (call L.fun/ascii-char22583.4))
          (boolean4.1 (call L.empty?.13 (call L.fun/any22584.5))))
      (call L.empty?.13 (call L.fun/any22585.6)))))
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
    (define L.empty?.8 (lambda (tmp.44) (empty? tmp.44)))
    (define L.fun/void22702.4 (lambda () (void)))
    (define L.fun/error22701.5 (lambda () (error 125)))
    (define L.fun/any22703.6 (lambda () empty))
    (let ((error0.5 (call L.fun/error22701.5))
          (void1.4 (call L.fun/void22702.4))
          (boolean2.3 (call L.empty?.8 (call L.fun/any22703.6)))
          (fixnum3.2
           (call
            L.*.10
            (call L.+.9 (call L.+.9 49 222) (call L.*.10 135 152))
            (call L.*.10 (call L.+.9 29 139) (call L.-.11 192 210))))
          (fixnum4.1
           (call
            L.*.10
            (call L.+.9 (call L.*.10 42 172) (call L.+.9 66 25))
            (call L.*.10 (call L.+.9 16 73) (call L.-.11 81 22)))))
      void1.4)))
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
    (define L.fun/ascii-char23153.4 (lambda () #\c))
    (define L.fun/error23159.5 (lambda () (error 175)))
    (define L.fun/ascii-char23157.6 (lambda () #\c))
    (define L.fun/void23154.7 (lambda () (call L.fun/void23155.10)))
    (define L.fun/error23151.8 (lambda () (error 89)))
    (define L.fun/ascii-char23156.9 (lambda () (call L.fun/ascii-char23157.6)))
    (define L.fun/void23155.10 (lambda () (void)))
    (define L.fun/error23150.11 (lambda () (call L.fun/error23151.8)))
    (define L.fun/error23158.12 (lambda () (call L.fun/error23159.5)))
    (define L.fun/ascii-char23152.13
      (lambda () (call L.fun/ascii-char23153.4)))
    (let ((error0.6 (call L.fun/error23150.11))
          (ascii-char1.5 (call L.fun/ascii-char23152.13))
          (void2.4 (call L.fun/void23154.7))
          (fixnum3.3
           (call
            L.+.15
            (call
             L.+.15
             (call L.+.15 (call L.+.15 194 66) (call L.+.15 251 232))
             (call L.+.15 (call L.*.16 108 115) (call L.+.15 23 219)))
            (call
             L.-.17
             (call L.-.17 (call L.*.16 138 73) (call L.+.15 2 179))
             (call L.-.17 (call L.*.16 92 140) (call L.*.16 244 126)))))
          (ascii-char4.2 (call L.fun/ascii-char23156.9))
          (error5.1 (call L.fun/error23158.12)))
      error5.1)))
(check-by-interp
 '(module
    (define L.empty?.18 (lambda (tmp.45) (empty? tmp.45)))
    (define L.ascii-char?.17 (lambda (tmp.47) (ascii-char? tmp.47)))
    (define L.fun/empty24557.4 (lambda () empty))
    (define L.fun/any24558.5 (lambda () #t))
    (define L.fun/error24555.6 (lambda () (error 222)))
    (define L.fun/ascii-char24562.7
      (lambda () (call L.fun/ascii-char24563.13)))
    (define L.fun/empty24560.8 (lambda () (call L.fun/empty24561.9)))
    (define L.fun/empty24561.9 (lambda () empty))
    (define L.fun/empty24556.10 (lambda () (call L.fun/empty24557.4)))
    (define L.fun/any24559.11 (lambda () (void)))
    (define L.fun/error24552.12 (lambda () (call L.fun/error24553.14)))
    (define L.fun/ascii-char24563.13 (lambda () #\c))
    (define L.fun/error24553.14 (lambda () (error 203)))
    (define L.fun/error24554.15 (lambda () (call L.fun/error24555.6)))
    (let ((error0.6 (call L.fun/error24552.12))
          (error1.5 (call L.fun/error24554.15))
          (empty2.4 (call L.fun/empty24556.10))
          (boolean3.3 (call L.ascii-char?.17 (call L.fun/any24558.5)))
          (boolean4.2 (call L.empty?.18 (call L.fun/any24559.11)))
          (empty5.1 (call L.fun/empty24560.8)))
      (call L.fun/ascii-char24562.7))))
(check-by-interp
 '(module
    (define L.*.15
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
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
    (define L.fun/ascii-char29402.4 (lambda () #\c))
    (define L.fun/empty29399.5 (lambda () (call L.fun/empty29400.10)))
    (define L.fun/ascii-char29401.6 (lambda () (call L.fun/ascii-char29402.4)))
    (define L.fun/empty29404.7 (lambda () empty))
    (define L.fun/ascii-char29406.8 (lambda () #\c))
    (define L.fun/ascii-char29405.9 (lambda () (call L.fun/ascii-char29406.8)))
    (define L.fun/empty29400.10 (lambda () empty))
    (define L.fun/empty29403.11 (lambda () (call L.fun/empty29404.7)))
    (let ((empty0.6 (call L.fun/empty29399.5))
          (ascii-char1.5 (call L.fun/ascii-char29401.6))
          (empty2.4 (call L.fun/empty29403.11))
          (fixnum3.3
           (call
            L.-.14
            (call
             L.+.13
             (call L.*.15 (call L.+.13 236 137) (call L.-.14 132 27))
             (call L.*.15 (call L.-.14 111 23) (call L.-.14 0 120)))
            (call
             L.-.14
             (call L.*.15 (call L.-.14 247 107) (call L.-.14 202 245))
             (call L.+.13 (call L.-.14 199 49) (call L.*.15 144 52)))))
          (fixnum4.2
           (call
            L.-.14
            (call
             L.+.13
             (call L.*.15 (call L.+.13 145 98) (call L.-.14 50 36))
             (call L.-.14 (call L.*.15 80 45) (call L.*.15 114 232)))
            (call
             L.*.15
             (call L.-.14 (call L.*.15 45 242) (call L.-.14 64 37))
             (call L.+.13 (call L.*.15 15 88) (call L.*.15 41 117)))))
          (ascii-char5.1 (call L.fun/ascii-char29405.9)))
      (call
       L.*.15
       (call
        L.*.15
        (call L.+.13 (call L.-.14 fixnum4.2 fixnum3.3) fixnum3.3)
        fixnum3.3)
       (call
        L.-.14
        fixnum4.2
        (call L.-.14 fixnum4.2 (call L.-.14 43 fixnum4.2)))))))
(check-by-interp
 '(module
    (define L.empty?.17 (lambda (tmp.45) (empty? tmp.45)))
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
    (define L.-.14
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.fun/void31691.4 (lambda () (void)))
    (define L.fun/void31695.5 (lambda () (call L.fun/void31696.11)))
    (define L.fun/any31694.6 (lambda () #\c))
    (define L.fun/empty31692.7 (lambda () (call L.fun/empty31693.9)))
    (define L.fun/void31690.8 (lambda () (call L.fun/void31691.4)))
    (define L.fun/empty31693.9 (lambda () empty))
    (define L.fun/empty31688.10 (lambda () (call L.fun/empty31689.12)))
    (define L.fun/void31696.11 (lambda () (void)))
    (define L.fun/empty31689.12 (lambda () empty))
    (let ((empty0.6 (call L.fun/empty31688.10))
          (fixnum1.5
           (call
            L.-.14
            (call
             L.-.14
             (call L.+.16 (call L.-.14 34 78) (call L.*.15 33 115))
             (call L.+.16 (call L.*.15 113 3) (call L.*.15 232 221)))
            (call
             L.-.14
             (call L.+.16 (call L.*.15 158 210) (call L.*.15 88 13))
             (call L.-.14 (call L.*.15 182 94) (call L.-.14 80 253)))))
          (void2.4 (call L.fun/void31690.8))
          (empty3.3 (call L.fun/empty31692.7))
          (boolean4.2 (call L.empty?.17 (call L.fun/any31694.6)))
          (void5.1 (call L.fun/void31695.5)))
      empty0.6)))
(check-by-interp
 '(module
    (define L.fun/error41241.4 (lambda () (call L.fun/error41242.12)))
    (define L.fun/void41237.5 (lambda () (call L.fun/void41238.13)))
    (define L.fun/error41233.6 (lambda () (call L.fun/error41234.9)))
    (define L.fun/void41232.7 (lambda () (void)))
    (define L.fun/error41236.8 (lambda () (error 2)))
    (define L.fun/error41234.9 (lambda () (error 33)))
    (define L.fun/ascii-char41240.10 (lambda () #\c))
    (define L.fun/void41231.11 (lambda () (call L.fun/void41232.7)))
    (define L.fun/error41242.12 (lambda () (error 110)))
    (define L.fun/void41238.13 (lambda () (void)))
    (define L.fun/empty41244.14 (lambda () empty))
    (define L.fun/error41235.15 (lambda () (call L.fun/error41236.8)))
    (define L.fun/empty41243.16 (lambda () (call L.fun/empty41244.14)))
    (define L.fun/ascii-char41239.17
      (lambda () (call L.fun/ascii-char41240.10)))
    (let ((void0.6 (call L.fun/void41231.11))
          (error1.5 (call L.fun/error41233.6))
          (error2.4 (call L.fun/error41235.15))
          (void3.3 (call L.fun/void41237.5))
          (ascii-char4.2 (call L.fun/ascii-char41239.17))
          (error5.1 (call L.fun/error41241.4)))
      (call L.fun/empty41243.16))))
(check-by-interp
 '(module
    (define L.void?.17 (lambda (tmp.46) (void? tmp.46)))
    (define L.fixnum?.16 (lambda (tmp.43) (fixnum? tmp.43)))
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
    (define L.fun/void44609.4 (lambda () (call L.fun/void44610.9)))
    (define L.fun/error44607.5 (lambda () (error 253)))
    (define L.fun/any44605.6 (lambda () empty))
    (define L.fun/error44606.7 (lambda () (call L.fun/error44607.5)))
    (define L.fun/any44608.8 (lambda () (void)))
    (define L.fun/void44610.9 (lambda () (void)))
    (define L.fun/ascii-char44603.10
      (lambda () (call L.fun/ascii-char44604.11)))
    (define L.fun/ascii-char44604.11 (lambda () #\c))
    (let ((fixnum0.6
           (call
            L.+.15
            (call
             L.+.15
             (call L.-.13 (call L.-.13 205 103) (call L.*.14 157 2))
             (call L.+.15 (call L.+.15 96 194) (call L.*.14 169 167)))
            (call
             L.*.14
             (call L.*.14 (call L.*.14 176 129) (call L.+.15 118 20))
             (call L.-.13 (call L.*.14 160 92) (call L.*.14 81 106)))))
          (ascii-char1.5 (call L.fun/ascii-char44603.10))
          (boolean2.4 (call L.fixnum?.16 (call L.fun/any44605.6)))
          (error3.3 (call L.fun/error44606.7))
          (boolean4.2 (call L.void?.17 (call L.fun/any44608.8)))
          (void5.1 (call L.fun/void44609.4)))
      void5.1)))
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
    (define L.fun/error47015.4 (lambda () (call L.fun/error47016.10)))
    (define L.fun/empty47018.5 (lambda () empty))
    (define L.fun/void47024.6 (lambda () (void)))
    (define L.fun/void47023.7 (lambda () (call L.fun/void47024.6)))
    (define L.fun/empty47020.8 (lambda () empty))
    (define L.fun/empty47017.9 (lambda () (call L.fun/empty47018.5)))
    (define L.fun/error47016.10 (lambda () (error 118)))
    (define L.fun/ascii-char47022.11 (lambda () #\c))
    (define L.fun/ascii-char47021.12
      (lambda () (call L.fun/ascii-char47022.11)))
    (define L.fun/empty47019.13 (lambda () (call L.fun/empty47020.8)))
    (let ((error0.6 (call L.fun/error47015.4))
          (empty1.5 (call L.fun/empty47017.9))
          (empty2.4 (call L.fun/empty47019.13))
          (ascii-char3.3 (call L.fun/ascii-char47021.12))
          (fixnum4.2
           (call
            L.+.17
            (call
             L.*.15
             (call L.+.17 (call L.*.15 129 204) (call L.-.16 6 33))
             (call L.*.15 (call L.+.17 83 165) (call L.*.15 209 217)))
            (call
             L.*.15
             (call L.*.15 (call L.*.15 168 88) (call L.+.17 198 249))
             (call L.+.17 (call L.-.16 156 127) (call L.*.15 82 194)))))
          (fixnum5.1
           (call
            L.*.15
            (call
             L.-.16
             (call L.-.16 (call L.+.17 233 74) (call L.*.15 49 252))
             (call L.+.17 (call L.*.15 176 62) (call L.+.17 12 168)))
            (call
             L.*.15
             (call L.+.17 (call L.-.16 137 58) (call L.+.17 224 237))
             (call L.+.17 (call L.*.15 60 20) (call L.-.16 62 75))))))
      (call L.fun/void47023.7))))
(check-by-interp
 '(module
    (define L.void?.15 (lambda (tmp.46) (void? tmp.46)))
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
    (define L.-.12
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.fun/error48429.4 (lambda () (error 123)))
    (define L.fun/void48432.5 (lambda () (call L.fun/void48433.10)))
    (define L.fun/empty48430.6 (lambda () (call L.fun/empty48431.7)))
    (define L.fun/empty48431.7 (lambda () empty))
    (define L.fun/any48434.8 (lambda () empty))
    (define L.fun/error48428.9 (lambda () (call L.fun/error48429.4)))
    (define L.fun/void48433.10 (lambda () (void)))
    (let ((fixnum0.6
           (call
            L.+.13
            (call
             L.+.13
             (call L.-.12 (call L.-.12 240 252) (call L.+.13 197 162))
             (call L.-.12 (call L.*.14 168 173) (call L.-.12 170 47)))
            (call
             L.-.12
             (call L.*.14 (call L.+.13 1 181) (call L.*.14 239 247))
             (call L.+.13 (call L.-.12 172 147) (call L.-.12 8 49)))))
          (fixnum1.5
           (call
            L.-.12
            (call
             L.*.14
             (call L.+.13 (call L.*.14 65 198) (call L.+.13 178 239))
             (call L.+.13 (call L.-.12 177 7) (call L.-.12 241 62)))
            (call
             L.-.12
             (call L.-.12 (call L.*.14 209 167) (call L.-.12 54 187))
             (call L.-.12 (call L.*.14 125 251) (call L.*.14 144 194)))))
          (error2.4 (call L.fun/error48428.9))
          (empty3.3 (call L.fun/empty48430.6))
          (void4.2 (call L.fun/void48432.5))
          (boolean5.1 (call L.void?.15 (call L.fun/any48434.8))))
      fixnum0.6)))
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
    (define L.fun/ascii-char52445.4 (lambda () #\c))
    (define L.fun/void52451.5 (lambda () (void)))
    (define L.fun/ascii-char52442.6
      (lambda () (call L.fun/ascii-char52443.14)))
    (define L.fun/error52440.7 (lambda () (call L.fun/error52441.15)))
    (define L.fun/ascii-char52449.8 (lambda () #\c))
    (define L.fun/ascii-char52448.9 (lambda () (call L.fun/ascii-char52449.8)))
    (define L.fun/void52450.10 (lambda () (call L.fun/void52451.5)))
    (define L.fun/empty52447.11 (lambda () empty))
    (define L.fun/empty52446.12 (lambda () (call L.fun/empty52447.11)))
    (define L.fun/ascii-char52444.13
      (lambda () (call L.fun/ascii-char52445.4)))
    (define L.fun/ascii-char52443.14 (lambda () #\c))
    (define L.fun/error52441.15 (lambda () (error 245)))
    (let ((error0.6 (call L.fun/error52440.7))
          (ascii-char1.5 (call L.fun/ascii-char52442.6))
          (ascii-char2.4 (call L.fun/ascii-char52444.13))
          (empty3.3 (call L.fun/empty52446.12))
          (ascii-char4.2 (call L.fun/ascii-char52448.9))
          (fixnum5.1
           (call
            L.+.19
            (call
             L.-.18
             (call L.-.18 (call L.*.17 211 150) (call L.-.18 117 142))
             (call L.+.19 (call L.+.19 81 168) (call L.-.18 220 87)))
            (call
             L.*.17
             (call L.*.17 (call L.*.17 55 142) (call L.+.19 129 201))
             (call L.*.17 (call L.-.18 129 1) (call L.-.18 0 213))))))
      (call L.fun/void52450.10))))
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
    (define L.boolean?.14 (lambda (tmp.44) (boolean? tmp.44)))
    (define L.fun/ascii-char59064.4 (lambda () (call L.fun/ascii-char59065.9)))
    (define L.fun/ascii-char59068.5
      (lambda () (call L.fun/ascii-char59069.12)))
    (define L.fun/any59063.6 (lambda () (void)))
    (define L.fun/ascii-char59070.7
      (lambda () (call L.fun/ascii-char59071.11)))
    (define L.fun/empty59066.8 (lambda () (call L.fun/empty59067.10)))
    (define L.fun/ascii-char59065.9 (lambda () #\c))
    (define L.fun/empty59067.10 (lambda () empty))
    (define L.fun/ascii-char59071.11 (lambda () #\c))
    (define L.fun/ascii-char59069.12 (lambda () #\c))
    (let ((boolean0.6 (call L.boolean?.14 (call L.fun/any59063.6)))
          (fixnum1.5
           (call
            L.-.17
            (call
             L.+.16
             (call L.+.16 (call L.*.15 21 6) (call L.+.16 183 44))
             (call L.+.16 (call L.*.15 63 236) (call L.+.16 46 68)))
            (call
             L.*.15
             (call L.+.16 (call L.+.16 231 244) (call L.+.16 241 196))
             (call L.-.17 (call L.+.16 63 90) (call L.-.17 158 1)))))
          (ascii-char2.4 (call L.fun/ascii-char59064.4))
          (empty3.3 (call L.fun/empty59066.8))
          (ascii-char4.2 (call L.fun/ascii-char59068.5))
          (ascii-char5.1 (call L.fun/ascii-char59070.7)))
      fixnum1.5)))
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
    (define L.fun/empty59449.4 (lambda () (call L.fun/empty59450.8)))
    (define L.fun/ascii-char59447.5
      (lambda () (call L.fun/ascii-char59448.13)))
    (define L.fun/error59452.6 (lambda () (error 26)))
    (define L.fun/void59454.7 (lambda () (void)))
    (define L.fun/empty59450.8 (lambda () empty))
    (define L.fun/ascii-char59445.9
      (lambda () (call L.fun/ascii-char59446.10)))
    (define L.fun/ascii-char59446.10 (lambda () #\c))
    (define L.fun/void59453.11 (lambda () (call L.fun/void59454.7)))
    (define L.fun/error59451.12 (lambda () (call L.fun/error59452.6)))
    (define L.fun/ascii-char59448.13 (lambda () #\c))
    (let ((ascii-char0.6 (call L.fun/ascii-char59445.9))
          (ascii-char1.5 (call L.fun/ascii-char59447.5))
          (empty2.4 (call L.fun/empty59449.4))
          (error3.3 (call L.fun/error59451.12))
          (fixnum4.2
           (call
            L.-.17
            (call
             L.*.15
             (call L.*.15 (call L.*.15 122 211) (call L.+.16 110 81))
             (call L.*.15 (call L.*.15 253 95) (call L.-.17 54 31)))
            (call
             L.+.16
             (call L.+.16 (call L.-.17 32 182) (call L.+.16 110 51))
             (call L.+.16 (call L.+.16 104 80) (call L.-.17 0 154)))))
          (void5.1 (call L.fun/void59453.11)))
      error3.3)))
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
    (define L.boolean?.14 (lambda (tmp.44) (boolean? tmp.44)))
    (define L.void?.13 (lambda (tmp.46) (void? tmp.46)))
    (define L.fun/ascii-char72180.4 (lambda () (call L.fun/ascii-char72181.7)))
    (define L.fun/ascii-char72175.5
      (lambda () (call L.fun/ascii-char72176.11)))
    (define L.fun/void72177.6 (lambda () (call L.fun/void72178.8)))
    (define L.fun/ascii-char72181.7 (lambda () #\c))
    (define L.fun/void72178.8 (lambda () (void)))
    (define L.fun/any72179.9 (lambda () #\c))
    (define L.fun/any72182.10 (lambda () (error 77)))
    (define L.fun/ascii-char72176.11 (lambda () #\c))
    (let ((ascii-char0.6 (call L.fun/ascii-char72175.5))
          (void1.5 (call L.fun/void72177.6))
          (boolean2.4 (call L.void?.13 (call L.fun/any72179.9)))
          (ascii-char3.3 (call L.fun/ascii-char72180.4))
          (boolean4.2 (call L.boolean?.14 (call L.fun/any72182.10)))
          (fixnum5.1
           (call
            L.+.16
            (call
             L.-.15
             (call L.+.16 (call L.-.15 32 33) (call L.-.15 121 173))
             (call L.-.15 (call L.*.17 209 159) (call L.+.16 247 237)))
            (call
             L.+.16
             (call L.+.16 (call L.-.15 247 159) (call L.-.15 14 109))
             (call L.+.16 (call L.*.17 38 183) (call L.+.16 178 240))))))
      ascii-char3.3)))
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
    (define L.fun/empty76147.4 (lambda () (call L.fun/empty76148.12)))
    (define L.fun/empty76144.5 (lambda () empty))
    (define L.fun/ascii-char76150.6 (lambda () #\c))
    (define L.fun/void76152.7 (lambda () (void)))
    (define L.fun/void76145.8 (lambda () (call L.fun/void76146.11)))
    (define L.fun/ascii-char76149.9 (lambda () (call L.fun/ascii-char76150.6)))
    (define L.fun/empty76143.10 (lambda () (call L.fun/empty76144.5)))
    (define L.fun/void76146.11 (lambda () (void)))
    (define L.fun/empty76148.12 (lambda () empty))
    (define L.fun/void76151.13 (lambda () (call L.fun/void76152.7)))
    (let ((fixnum0.6
           (call
            L.-.15
            (call
             L.-.15
             (call L.+.17 (call L.-.15 155 235) (call L.*.16 95 108))
             (call L.*.16 (call L.+.17 28 173) (call L.-.15 228 29)))
            (call
             L.*.16
             (call L.*.16 (call L.+.17 67 93) (call L.+.17 240 16))
             (call L.+.17 (call L.-.15 64 86) (call L.+.17 51 147)))))
          (empty1.5 (call L.fun/empty76143.10))
          (void2.4 (call L.fun/void76145.8))
          (empty3.3 (call L.fun/empty76147.4))
          (ascii-char4.2 (call L.fun/ascii-char76149.9))
          (void5.1 (call L.fun/void76151.13)))
      (call
       L.*.16
       (call L.*.16 fixnum0.6 fixnum0.6)
       (call
        L.-.15
        (call L.+.17 (call L.-.15 fixnum0.6 fixnum0.6) fixnum0.6)
        (call L.-.15 fixnum0.6 (call L.-.15 86 fixnum0.6)))))))
(check-by-interp
 '(module
    (define L.fun/empty82623.4 (lambda () empty))
    (define L.fun/void82617.5 (lambda () (void)))
    (define L.fun/error82624.6 (lambda () (call L.fun/error82625.7)))
    (define L.fun/error82625.7 (lambda () (error 232)))
    (define L.fun/ascii-char82621.8 (lambda () #\c))
    (define L.fun/error82619.9 (lambda () (error 156)))
    (define L.fun/error82618.10 (lambda () (call L.fun/error82619.9)))
    (define L.fun/ascii-char82627.11 (lambda () #\c))
    (define L.fun/empty82622.12 (lambda () (call L.fun/empty82623.4)))
    (define L.fun/ascii-char82620.13
      (lambda () (call L.fun/ascii-char82621.8)))
    (define L.fun/ascii-char82626.14
      (lambda () (call L.fun/ascii-char82627.11)))
    (define L.fun/void82616.15 (lambda () (call L.fun/void82617.5)))
    (let ((void0.6 (call L.fun/void82616.15))
          (error1.5 (call L.fun/error82618.10))
          (ascii-char2.4 (call L.fun/ascii-char82620.13))
          (empty3.3 (call L.fun/empty82622.12))
          (error4.2 (call L.fun/error82624.6))
          (ascii-char5.1 (call L.fun/ascii-char82626.14)))
      empty3.3)))
(check-by-interp
 '(module
    (define L.fun/empty86209.4 (lambda () (call L.fun/empty86210.13)))
    (define L.fun/void86206.5 (lambda () (void)))
    (define L.fun/ascii-char86207.6
      (lambda () (call L.fun/ascii-char86208.15)))
    (define L.fun/empty86211.7 (lambda () (call L.fun/empty86212.16)))
    (define L.fun/empty86201.8 (lambda () (call L.fun/empty86202.12)))
    (define L.fun/error86214.9 (lambda () (error 83)))
    (define L.fun/void86205.10 (lambda () (call L.fun/void86206.5)))
    (define L.fun/empty86203.11 (lambda () (call L.fun/empty86204.14)))
    (define L.fun/empty86202.12 (lambda () empty))
    (define L.fun/empty86210.13 (lambda () empty))
    (define L.fun/empty86204.14 (lambda () empty))
    (define L.fun/ascii-char86208.15 (lambda () #\c))
    (define L.fun/empty86212.16 (lambda () empty))
    (define L.fun/error86213.17 (lambda () (call L.fun/error86214.9)))
    (let ((empty0.6 (call L.fun/empty86201.8))
          (empty1.5 (call L.fun/empty86203.11))
          (void2.4 (call L.fun/void86205.10))
          (ascii-char3.3 (call L.fun/ascii-char86207.6))
          (empty4.2 (call L.fun/empty86209.4))
          (empty5.1 (call L.fun/empty86211.7)))
      (call L.fun/error86213.17))))
(check-by-interp
 '(module
    (define L.-.19
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.+.18
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.*.17
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.empty?.16 (lambda (tmp.45) (empty? tmp.45)))
    (define L.fun/any89588.4 (lambda () 230))
    (define L.fun/void89590.5 (lambda () (void)))
    (define L.fun/void89587.6 (lambda () (void)))
    (define L.fun/error89592.7 (lambda () (error 21)))
    (define L.fun/void89594.8 (lambda () (void)))
    (define L.fun/void89595.9 (lambda () (call L.fun/void89596.11)))
    (define L.fun/void89586.10 (lambda () (call L.fun/void89587.6)))
    (define L.fun/void89596.11 (lambda () (void)))
    (define L.fun/error89591.12 (lambda () (call L.fun/error89592.7)))
    (define L.fun/void89593.13 (lambda () (call L.fun/void89594.8)))
    (define L.fun/void89589.14 (lambda () (call L.fun/void89590.5)))
    (let ((void0.6 (call L.fun/void89586.10))
          (boolean1.5 (call L.empty?.16 (call L.fun/any89588.4)))
          (void2.4 (call L.fun/void89589.14))
          (error3.3 (call L.fun/error89591.12))
          (void4.2 (call L.fun/void89593.13))
          (void5.1 (call L.fun/void89595.9)))
      (call
       L.*.17
       (call
        L.*.17
        (call L.+.18 (call L.*.17 18 204) (call L.*.17 183 177))
        (call L.-.19 (call L.+.18 144 133) (call L.-.19 137 104)))
       (call
        L.*.17
        (call L.*.17 (call L.+.18 86 31) (call L.*.17 250 30))
        (call L.+.18 (call L.+.18 100 130) (call L.*.17 153 39)))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char91899.4 (lambda () #\c))
    (define L.fun/ascii-char91896.5
      (lambda () (call L.fun/ascii-char91897.12)))
    (define L.fun/empty91891.6 (lambda () empty))
    (define L.fun/empty91890.7 (lambda () (call L.fun/empty91891.6)))
    (define L.fun/ascii-char91892.8
      (lambda () (call L.fun/ascii-char91893.15)))
    (define L.fun/ascii-char91898.9 (lambda () (call L.fun/ascii-char91899.4)))
    (define L.fun/ascii-char91894.10
      (lambda () (call L.fun/ascii-char91895.14)))
    (define L.fun/error91900.11 (lambda () (call L.fun/error91901.13)))
    (define L.fun/ascii-char91897.12 (lambda () #\c))
    (define L.fun/error91901.13 (lambda () (error 129)))
    (define L.fun/ascii-char91895.14 (lambda () #\c))
    (define L.fun/ascii-char91893.15 (lambda () #\c))
    (let ((empty0.6 (call L.fun/empty91890.7))
          (ascii-char1.5 (call L.fun/ascii-char91892.8))
          (ascii-char2.4 (call L.fun/ascii-char91894.10))
          (ascii-char3.3 (call L.fun/ascii-char91896.5))
          (ascii-char4.2 (call L.fun/ascii-char91898.9))
          (error5.1 (call L.fun/error91900.11)))
      empty0.6)))
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
    (define L.fun/empty93185.4 (lambda () (call L.fun/empty93186.9)))
    (define L.fun/void93187.5 (lambda () (call L.fun/void93188.11)))
    (define L.fun/error93189.6 (lambda () (call L.fun/error93190.7)))
    (define L.fun/error93190.7 (lambda () (error 38)))
    (define L.fun/void93193.8 (lambda () (call L.fun/void93194.12)))
    (define L.fun/empty93186.9 (lambda () empty))
    (define L.fun/error93192.10 (lambda () (error 77)))
    (define L.fun/void93188.11 (lambda () (void)))
    (define L.fun/void93194.12 (lambda () (void)))
    (define L.fun/error93191.13 (lambda () (call L.fun/error93192.10)))
    (let ((empty0.6 (call L.fun/empty93185.4))
          (void1.5 (call L.fun/void93187.5))
          (fixnum2.4
           (call
            L.*.15
            (call
             L.*.15
             (call L.+.17 (call L.*.15 229 205) (call L.-.16 172 26))
             (call L.+.17 (call L.-.16 102 5) (call L.*.15 216 181)))
            (call
             L.-.16
             (call L.-.16 (call L.+.17 94 137) (call L.-.16 74 199))
             (call L.-.16 (call L.+.17 25 250) (call L.-.16 142 24)))))
          (error3.3 (call L.fun/error93189.6))
          (error4.2 (call L.fun/error93191.13))
          (void5.1 (call L.fun/void93193.8)))
      (call
       L.+.17
       (call
        L.-.16
        (call L.+.17 fixnum2.4 fixnum2.4)
        (call L.+.17 (call L.*.15 fixnum2.4 183) (call L.*.15 fixnum2.4 219)))
       (call L.-.16 fixnum2.4 fixnum2.4)))))
(check-by-interp
 '(module
    (define L.vector?.17 (lambda (tmp.50) (vector? tmp.50)))
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
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.fun/ascii-char103343.4 (lambda () #\c))
    (define L.fun/error103339.5 (lambda () (call L.fun/error103340.7)))
    (define L.fun/ascii-char103337.6
      (lambda () (call L.fun/ascii-char103338.12)))
    (define L.fun/error103340.7 (lambda () (error 162)))
    (define L.fun/ascii-char103342.8
      (lambda () (call L.fun/ascii-char103343.4)))
    (define L.fun/empty103336.9 (lambda () empty))
    (define L.fun/any103341.10 (lambda () #t))
    (define L.fun/empty103335.11 (lambda () (call L.fun/empty103336.9)))
    (define L.fun/ascii-char103338.12 (lambda () #\c))
    (let ((empty0.6 (call L.fun/empty103335.11))
          (ascii-char1.5 (call L.fun/ascii-char103337.6))
          (fixnum2.4
           (call
            L.+.15
            (call
             L.-.16
             (call L.+.15 (call L.*.14 235 21) (call L.+.15 13 17))
             (call L.*.14 (call L.*.14 44 93) (call L.+.15 57 240)))
            (call
             L.+.15
             (call L.*.14 (call L.+.15 236 21) (call L.*.14 58 8))
             (call L.+.15 (call L.+.15 44 20) (call L.+.15 144 189)))))
          (error3.3 (call L.fun/error103339.5))
          (boolean4.2 (call L.vector?.17 (call L.fun/any103341.10)))
          (ascii-char5.1 (call L.fun/ascii-char103342.8)))
      error3.3)))
(check-by-interp
 '(module
    (define L.fixnum?.16 (lambda (tmp.43) (fixnum? tmp.43)))
    (define L.fun/void111249.4 (lambda () (call L.fun/void111250.14)))
    (define L.fun/error111259.5 (lambda () (error 143)))
    (define L.fun/error111258.6 (lambda () (call L.fun/error111259.5)))
    (define L.fun/any111257.7 (lambda () empty))
    (define L.fun/ascii-char111255.8
      (lambda () (call L.fun/ascii-char111256.12)))
    (define L.fun/error111254.9 (lambda () (error 228)))
    (define L.fun/error111253.10 (lambda () (call L.fun/error111254.9)))
    (define L.fun/ascii-char111251.11
      (lambda () (call L.fun/ascii-char111252.13)))
    (define L.fun/ascii-char111256.12 (lambda () #\c))
    (define L.fun/ascii-char111252.13 (lambda () #\c))
    (define L.fun/void111250.14 (lambda () (void)))
    (let ((void0.6 (call L.fun/void111249.4))
          (ascii-char1.5 (call L.fun/ascii-char111251.11))
          (error2.4 (call L.fun/error111253.10))
          (ascii-char3.3 (call L.fun/ascii-char111255.8))
          (boolean4.2 (call L.fixnum?.16 (call L.fun/any111257.7)))
          (error5.1 (call L.fun/error111258.6)))
      error2.4)))
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
    (define L.fun/void112730.4 (lambda () (call L.fun/void112731.8)))
    (define L.fun/ascii-char112724.5
      (lambda () (call L.fun/ascii-char112725.9)))
    (define L.fun/void112726.6 (lambda () (call L.fun/void112727.13)))
    (define L.fun/empty112733.7 (lambda () empty))
    (define L.fun/void112731.8 (lambda () (void)))
    (define L.fun/ascii-char112725.9 (lambda () #\c))
    (define L.fun/void112728.10 (lambda () (call L.fun/void112729.12)))
    (define L.fun/empty112732.11 (lambda () (call L.fun/empty112733.7)))
    (define L.fun/void112729.12 (lambda () (void)))
    (define L.fun/void112727.13 (lambda () (void)))
    (let ((ascii-char0.6 (call L.fun/ascii-char112724.5))
          (void1.5 (call L.fun/void112726.6))
          (void2.4 (call L.fun/void112728.10))
          (fixnum3.3
           (call
            L.+.17
            (call
             L.-.16
             (call L.-.16 (call L.*.15 123 41) (call L.*.15 91 111))
             (call L.-.16 (call L.-.16 75 222) (call L.*.15 238 182)))
            (call
             L.-.16
             (call L.+.17 (call L.-.16 159 192) (call L.*.15 132 114))
             (call L.-.16 (call L.+.17 181 187) (call L.-.16 71 43)))))
          (void4.2 (call L.fun/void112730.4))
          (empty5.1 (call L.fun/empty112732.11)))
      (call
       L.+.17
       (call
        L.*.15
        (call L.+.17 fixnum3.3 (call L.-.16 fixnum3.3 149))
        fixnum3.3)
       (call
        L.*.15
        fixnum3.3
        (call L.*.15 (call L.+.17 fixnum3.3 39) fixnum3.3))))))
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
    (define L.fun/ascii-char117132.4
      (lambda () (call L.fun/ascii-char117133.9)))
    (define L.fun/ascii-char117129.5 (lambda () #\c))
    (define L.fun/ascii-char117130.6
      (lambda () (call L.fun/ascii-char117131.8)))
    (define L.fun/ascii-char117128.7
      (lambda () (call L.fun/ascii-char117129.5)))
    (define L.fun/ascii-char117131.8 (lambda () #\c))
    (define L.fun/ascii-char117133.9 (lambda () #\c))
    (let ((ascii-char0.6 (call L.fun/ascii-char117128.7))
          (fixnum1.5
           (call
            L.+.11
            (call
             L.*.12
             (call L.*.12 (call L.+.11 22 69) (call L.*.12 228 18))
             (call L.-.13 (call L.+.11 123 158) (call L.*.12 4 160)))
            (call
             L.+.11
             (call L.+.11 (call L.-.13 192 177) (call L.*.12 134 77))
             (call L.+.11 (call L.+.11 48 247) (call L.+.11 50 161)))))
          (ascii-char2.4 (call L.fun/ascii-char117130.6))
          (fixnum3.3
           (call
            L.*.12
            (call
             L.+.11
             (call L.+.11 (call L.-.13 72 168) (call L.+.11 66 227))
             (call L.-.13 (call L.-.13 145 108) (call L.+.11 170 12)))
            (call
             L.-.13
             (call L.*.12 (call L.+.11 30 43) (call L.*.12 241 135))
             (call L.*.12 (call L.+.11 101 56) (call L.+.11 162 250)))))
          (ascii-char4.2 (call L.fun/ascii-char117132.4))
          (fixnum5.1
           (call
            L.+.11
            (call
             L.+.11
             (call L.-.13 (call L.*.12 209 182) (call L.+.11 212 60))
             (call L.*.12 (call L.-.13 40 77) (call L.*.12 127 132)))
            (call
             L.-.13
             (call L.-.13 (call L.*.12 104 147) (call L.-.13 31 41))
             (call L.-.13 (call L.+.11 115 244) (call L.*.12 40 125))))))
      ascii-char0.6)))
(check-by-interp
 '(module
    (define L.empty?.17 (lambda (tmp.45) (empty? tmp.45)))
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
    (define L.+.14
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.fun/void117486.4 (lambda () (void)))
    (define L.fun/any117487.5 (lambda () #f))
    (define L.fun/void117490.6 (lambda () (call L.fun/void117491.11)))
    (define L.fun/error117483.7 (lambda () (call L.fun/error117484.12)))
    (define L.fun/empty117489.8 (lambda () empty))
    (define L.fun/void117485.9 (lambda () (call L.fun/void117486.4)))
    (define L.fun/empty117488.10 (lambda () (call L.fun/empty117489.8)))
    (define L.fun/void117491.11 (lambda () (void)))
    (define L.fun/error117484.12 (lambda () (error 20)))
    (let ((fixnum0.6
           (call
            L.+.14
            (call
             L.+.14
             (call L.+.14 (call L.+.14 123 180) (call L.-.15 76 74))
             (call L.+.14 (call L.*.16 32 209) (call L.*.16 216 81)))
            (call
             L.-.15
             (call L.*.16 (call L.-.15 40 194) (call L.*.16 220 220))
             (call L.*.16 (call L.-.15 159 173) (call L.-.15 232 149)))))
          (error1.5 (call L.fun/error117483.7))
          (void2.4 (call L.fun/void117485.9))
          (boolean3.3 (call L.empty?.17 (call L.fun/any117487.5)))
          (empty4.2 (call L.fun/empty117488.10))
          (void5.1 (call L.fun/void117490.6)))
      empty4.2)))
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
    (define L.fun/void118048.4 (lambda () (call L.fun/void118049.8)))
    (define L.fun/ascii-char118051.5 (lambda () #\c))
    (define L.fun/void118045.6 (lambda () (void)))
    (define L.fun/error118053.7 (lambda () (error 186)))
    (define L.fun/void118049.8 (lambda () (void)))
    (define L.fun/void118046.9 (lambda () (call L.fun/void118047.11)))
    (define L.fun/void118044.10 (lambda () (call L.fun/void118045.6)))
    (define L.fun/void118047.11 (lambda () (void)))
    (define L.fun/error118052.12 (lambda () (call L.fun/error118053.7)))
    (define L.fun/ascii-char118050.13
      (lambda () (call L.fun/ascii-char118051.5)))
    (let ((void0.6 (call L.fun/void118044.10))
          (void1.5 (call L.fun/void118046.9))
          (void2.4 (call L.fun/void118048.4))
          (ascii-char3.3 (call L.fun/ascii-char118050.13))
          (error4.2 (call L.fun/error118052.12))
          (fixnum5.1
           (call
            L.*.16
            (call
             L.*.16
             (call L.*.16 (call L.+.15 66 155) (call L.+.15 152 163))
             (call L.+.15 (call L.-.17 194 117) (call L.+.15 236 95)))
            (call
             L.*.16
             (call L.-.17 (call L.*.16 48 97) (call L.-.17 228 100))
             (call L.+.15 (call L.+.15 122 150) (call L.-.17 188 233))))))
      ascii-char3.3)))
(check-by-interp
 '(module
    (define L.pair?.18 (lambda (tmp.49) (pair? tmp.49)))
    (define L.fun/void123827.4 (lambda () (call L.fun/void123828.8)))
    (define L.fun/empty123825.5 (lambda () (call L.fun/empty123826.10)))
    (define L.fun/empty123831.6 (lambda () (call L.fun/empty123832.14)))
    (define L.fun/error123823.7 (lambda () (call L.fun/error123824.15)))
    (define L.fun/void123828.8 (lambda () (void)))
    (define L.fun/any123822.9 (lambda () #\c))
    (define L.fun/empty123826.10 (lambda () empty))
    (define L.fun/error123830.11 (lambda () (error 167)))
    (define L.fun/error123829.12 (lambda () (call L.fun/error123830.11)))
    (define L.fun/ascii-char123833.13
      (lambda () (call L.fun/ascii-char123834.16)))
    (define L.fun/empty123832.14 (lambda () empty))
    (define L.fun/error123824.15 (lambda () (error 125)))
    (define L.fun/ascii-char123834.16 (lambda () #\c))
    (let ((boolean0.6 (call L.pair?.18 (call L.fun/any123822.9)))
          (error1.5 (call L.fun/error123823.7))
          (empty2.4 (call L.fun/empty123825.5))
          (void3.3 (call L.fun/void123827.4))
          (error4.2 (call L.fun/error123829.12))
          (empty5.1 (call L.fun/empty123831.6)))
      (call L.fun/ascii-char123833.13))))
(check-by-interp
 '(module
    (define L.error?.15 (lambda (tmp.48) (error? tmp.48)))
    (define L.boolean?.14 (lambda (tmp.44) (boolean? tmp.44)))
    (define L.void?.13 (lambda (tmp.46) (void? tmp.46)))
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
    (define L.-.10
      (lambda (tmp.24 tmp.25)
        (if (fixnum? tmp.25)
          (if (fixnum? tmp.24) (unsafe-fx- tmp.24 tmp.25) (error 3))
          (error 3))))
    (define L.fun/empty126710.4 (lambda () empty))
    (define L.fun/empty126709.5 (lambda () (call L.fun/empty126710.4)))
    (define L.fun/any126713.6 (lambda () #\c))
    (define L.fun/any126711.7 (lambda () 148))
    (define L.fun/any126712.8 (lambda () (void)))
    (let ((fixnum0.6
           (call
            L.-.10
            (call
             L.-.10
             (call L.+.11 (call L.-.10 58 144) (call L.-.10 219 7))
             (call L.*.12 (call L.-.10 124 113) (call L.+.11 16 61)))
            (call
             L.-.10
             (call L.*.12 (call L.*.12 218 107) (call L.*.12 81 92))
             (call L.*.12 (call L.*.12 13 89) (call L.-.10 33 237)))))
          (empty1.5 (call L.fun/empty126709.5))
          (boolean2.4 (call L.void?.13 (call L.fun/any126711.7)))
          (fixnum3.3
           (call
            L.*.12
            (call
             L.*.12
             (call L.-.10 (call L.+.11 9 113) (call L.-.10 102 56))
             (call L.+.11 (call L.-.10 17 106) (call L.*.12 136 234)))
            (call
             L.+.11
             (call L.+.11 (call L.-.10 47 122) (call L.*.12 223 38))
             (call L.-.10 (call L.*.12 177 46) (call L.+.11 223 215)))))
          (boolean4.2 (call L.boolean?.14 (call L.fun/any126712.8)))
          (boolean5.1 (call L.error?.15 (call L.fun/any126713.6))))
      (call
       L.-.10
       fixnum3.3
       (call L.+.11 (call L.*.12 fixnum0.6 fixnum3.3) fixnum0.6)))))
(check-by-interp
 '(module
    (define L.vector?.18 (lambda (tmp.50) (vector? tmp.50)))
    (define L.fun/error129841.4 (lambda () (call L.fun/error129842.9)))
    (define L.fun/ascii-char129834.5 (lambda () #\c))
    (define L.fun/ascii-char129832.6 (lambda () #\c))
    (define L.fun/empty129840.7 (lambda () empty))
    (define L.fun/empty129836.8 (lambda () empty))
    (define L.fun/error129842.9 (lambda () (error 161)))
    (define L.fun/ascii-char129831.10
      (lambda () (call L.fun/ascii-char129832.6)))
    (define L.fun/empty129835.11 (lambda () (call L.fun/empty129836.8)))
    (define L.fun/any129830.12 (lambda () (void)))
    (define L.fun/ascii-char129833.13
      (lambda () (call L.fun/ascii-char129834.5)))
    (define L.fun/empty129837.14 (lambda () (call L.fun/empty129838.15)))
    (define L.fun/empty129838.15 (lambda () empty))
    (define L.fun/empty129839.16 (lambda () (call L.fun/empty129840.7)))
    (let ((boolean0.6 (call L.vector?.18 (call L.fun/any129830.12)))
          (ascii-char1.5 (call L.fun/ascii-char129831.10))
          (ascii-char2.4 (call L.fun/ascii-char129833.13))
          (empty3.3 (call L.fun/empty129835.11))
          (empty4.2 (call L.fun/empty129837.14))
          (empty5.1 (call L.fun/empty129839.16)))
      (call L.fun/error129841.4))))
