#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
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
  (interp-exprs-bits-lang-v8 (fail-if-invalid (specify-representation p)))))

(check-by-interp '(module (void)))
(check-by-interp
 '(module
    (define L.cons.5 (lambda (tmp.46 tmp.47) (cons tmp.46 tmp.47)))
    (call L.cons.5 226 477)))
(check-by-interp '(module (let ((ascii-char0.1 #\k)) empty)))
(check-by-interp '(module (let ((void0.1 (void))) #\|)))
(check-by-interp
 '(module
    (define L.cons.5 (lambda (tmp.47 tmp.48) (cons tmp.47 tmp.48)))
    (let ((void0.1 (void))) (call L.cons.5 203 463))))
(check-by-interp
 '(module
    (define L.fun/fixnum8389.4 (lambda () 209))
    (call L.fun/fixnum8389.4)))
(check-by-interp '(module (let ((boolean0.2 #f) (void1.1 (void))) (void))))
(check-by-interp
 '(module
    (define L.fun/fixnum8394.4 (lambda (oprand0.1) 39))
    (call L.fun/fixnum8394.4 (if #t (error 62) (error 176)))))
(check-by-interp
 '(module
    (define L.fun/error8401.4 (lambda (oprand0.1) (error 7)))
    (define L.fun/void8402.5 (lambda (oprand0.2) (void)))
    (call L.fun/error8401.4 (call L.fun/void8402.5 empty))))
(check-by-interp
 '(module
    (define L.cons.5 (lambda (tmp.48 tmp.49) (cons tmp.48 tmp.49)))
    (let ((ascii-char0.2 #\G) (pair1.1 (call L.cons.5 104 284)))
      ascii-char0.2)))
(check-by-interp
 '(module
    (define L.cons.6 (lambda (tmp.47 tmp.48) (cons tmp.47 tmp.48)))
    (define L.fun/pair8407.4 (lambda (oprand0.1) (call L.cons.6 50 484)))
    (call L.fun/pair8407.4 (if #t #\D #\F))))
(check-by-interp '(module (let ((fixnum0.2 214) (boolean1.1 #t)) 233)))
(check-by-interp
 '(module (let ((error0.2 (error 51)) (boolean1.1 #t)) boolean1.1)))
(check-by-interp
 '(module
    (define L.cons.8 (lambda (tmp.52 tmp.53) (cons tmp.52 tmp.53)))
    (define L.fun/error8419.4 (lambda (oprand0.2 oprand1.1) (error 186)))
    (define L.fun/boolean8418.5 (lambda (oprand0.4 oprand1.3) #f))
    (define L.fun/error8420.6 (lambda (oprand0.6 oprand1.5) (error 156)))
    (if (call L.fun/boolean8418.5 #t 57)
      (call L.fun/error8419.4 #t empty)
      (call L.fun/error8420.6 empty (call L.cons.8 26 405)))))
(check-by-interp
 '(module
    (define L.+.9
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx+ tmp.19 tmp.20) (error 2))
          (error 2))))
    (define L.cons.8 (lambda (tmp.49 tmp.50) (cons tmp.49 tmp.50)))
    (define L.fun/ascii-char8439.4 (lambda () #\W))
    (define L.fun/error8440.5 (lambda () (error 18)))
    (define L.fun/pair8441.6 (lambda () (call L.cons.8 88 299)))
    (let ((ascii-char0.3 (call L.fun/ascii-char8439.4))
          (error1.2 (call L.fun/error8440.5))
          (pair2.1 (call L.fun/pair8441.6)))
      (call L.+.9 253 133))))
(check-by-interp
 '(module
    (define L.empty?.8 (lambda (tmp.41) (empty? tmp.41)))
    (define L.cons.7 (lambda (tmp.48 tmp.49) (cons tmp.48 tmp.49)))
    (define L.fun/pair8459.4 (lambda () (call L.cons.7 88 353)))
    (define L.fun/pair8458.5
      (lambda (oprand0.2 oprand1.1) (call L.fun/pair8459.4)))
    (call
     L.fun/pair8458.5
     (call L.empty?.8 (if #f (error 211) (error 151)))
     (if #f (void) (void)))))
(check-by-interp
 '(module
    (define L.pair?.8 (lambda (tmp.46) (pair? tmp.46)))
    (define L.fun/ascii-char8463.4 (lambda () #\X))
    (define L.fun/ascii-char8462.5 (lambda () #\())
    (define L.fun/error8464.6 (lambda () (error 22)))
    (let ((ascii-char0.3 (call L.fun/ascii-char8462.5))
          (ascii-char1.2 (call L.fun/ascii-char8463.4))
          (boolean2.1 (call L.pair?.8 #t)))
      (call L.fun/error8464.6))))
(check-by-interp
 '(module
    (if (let ((boolean0.3 #f) (fixnum1.2 181) (boolean2.1 #f)) boolean0.3)
      (let ((fixnum0.6 138) (boolean1.5 #t) (error2.4 (error 251))) fixnum0.6)
      (if #t 52 83))))
(check-by-interp
 '(module
    (define L.cons.9 (lambda (tmp.50 tmp.51) (cons tmp.50 tmp.51)))
    (define L.fun/void8484.4 (lambda () (void)))
    (define L.fun/empty8485.5 (lambda () empty))
    (define L.fun/pair8483.6 (lambda () (call L.cons.9 89 330)))
    (define L.fun/empty8482.7 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty8482.7))
          (pair1.3 (call L.fun/pair8483.6))
          (void2.2 (call L.fun/void8484.4))
          (empty3.1 (call L.fun/empty8485.5)))
      pair1.3)))
(check-by-interp
 '(module
    (define L.+.12
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx+ tmp.20 tmp.21) (error 2))
          (error 2))))
    (define L.-.11
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx- tmp.22 tmp.23) (error 3))
          (error 3))))
    (define L.*.10
      (lambda (tmp.18 tmp.19)
        (if (fixnum? tmp.19)
          (if (fixnum? tmp.18) (unsafe-fx* tmp.18 tmp.19) (error 1))
          (error 1))))
    (define L.cons.9 (lambda (tmp.50 tmp.51) (cons tmp.50 tmp.51)))
    (define L.fun/error8501.4 (lambda () (error 5)))
    (define L.fun/pair8499.5 (lambda () (call L.cons.9 74 259)))
    (define L.fun/void8500.6 (lambda () (void)))
    (define L.fun/void8498.7 (lambda () (void)))
    (let ((fixnum0.4 (call L.+.12 (call L.*.10 175 223) (call L.-.11 222 253)))
          (void1.3 (call L.fun/void8498.7))
          (pair2.2 (call L.fun/pair8499.5))
          (void3.1 (call L.fun/void8500.6)))
      (call L.fun/error8501.4))))
(check-by-interp
 '(module
    (define L.pair?.10 (lambda (tmp.59) (pair? tmp.59)))
    (define L.cons.9 (lambda (tmp.62 tmp.63) (cons tmp.62 tmp.63)))
    (define L.fun/ascii-char8512.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) #\I))
    (define L.fun/ascii-char8510.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) oprand0.6))
    (define L.fun/ascii-char8511.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) #\0))
    (define L.fun/boolean8513.7 (lambda (oprand0.12 oprand1.11 oprand2.10) #f))
    (call
     L.fun/ascii-char8510.5
     (if (let ((ascii-char0.16 #\w)
               (void1.15 (void))
               (empty2.14 empty)
               (error3.13 (error 110)))
           #t)
       (call L.fun/ascii-char8511.6 #\q (error 93) #\/)
       (call L.fun/ascii-char8512.4 #\b #\3 (error 46)))
     (if (call L.pair?.10 (call L.cons.9 86 450))
       (if #t (error 230) (error 90))
       (if #f (error 211) (error 77)))
     (if (call L.fun/boolean8513.7 52 246 40)
       (if #f #\H #\K)
       (if #t #\g #\J)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8546.4 (lambda () #\s))
    (define L.fun/empty8547.5 (lambda () empty))
    (define L.fun/error8544.6 (lambda () (error 70)))
    (define L.fun/ascii-char8545.7 (lambda () #\0))
    (let ((error0.4 (call L.fun/error8544.6))
          (ascii-char1.3 (call L.fun/ascii-char8545.7))
          (ascii-char2.2 (call L.fun/ascii-char8546.4))
          (empty3.1 (call L.fun/empty8547.5)))
      ascii-char1.3)))
(check-by-interp
 '(module
    (define L.void?.11 (lambda (tmp.44) (void? tmp.44)))
    (define L.cons.10 (lambda (tmp.50 tmp.51) (cons tmp.50 tmp.51)))
    (define L.fun/any8685.4 (lambda () (void)))
    (define L.fun/pair8681.5 (lambda () (call L.cons.10 107 388)))
    (define L.fun/error8683.6 (lambda () (error 83)))
    (define L.fun/pair8684.7 (lambda () (call L.cons.10 117 322)))
    (define L.fun/error8682.8 (lambda () (error 202)))
    (call
     L.void?.11
     (let ((pair0.4 (call L.fun/pair8681.5))
           (error1.3 (call L.fun/error8682.8))
           (error2.2 (call L.fun/error8683.6))
           (pair3.1 (call L.fun/pair8684.7)))
       (call L.fun/any8685.4)))))
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
    (define L.cons.9 (lambda (tmp.51 tmp.52) (cons tmp.51 tmp.52)))
    (define L.fun/empty8893.4 (lambda () empty))
    (define L.fun/empty8894.5 (lambda () empty))
    (define L.fun/pair8895.6 (lambda () (call L.cons.9 145 293)))
    (define L.fun/void8896.7 (lambda () (void)))
    (let ((empty0.5 (call L.fun/empty8893.4))
          (empty1.4 (call L.fun/empty8894.5))
          (fixnum2.3
           (call
            L.-.11
            (call L.*.10 (call L.*.10 204 25) (call L.*.10 40 113))
            (call L.-.11 (call L.-.11 89 40) (call L.+.12 112 116))))
          (pair3.2 (call L.fun/pair8895.6))
          (void4.1 (call L.fun/void8896.7)))
      pair3.2)))
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
    (define L.cons.9 (lambda (tmp.51 tmp.52) (cons tmp.51 tmp.52)))
    (define L.fun/empty8907.4 (lambda () empty))
    (define L.fun/error8906.5 (lambda () (error 71)))
    (define L.fun/pair8908.6 (lambda () (call L.cons.9 170 380)))
    (define L.fun/void8909.7 (lambda () (void)))
    (let ((fixnum0.5
           (call
            L.-.11
            (call L.*.12 (call L.+.10 108 195) (call L.-.11 204 229))
            (call L.*.12 (call L.+.10 51 51) (call L.+.10 146 11))))
          (error1.4 (call L.fun/error8906.5))
          (fixnum2.3
           (call
            L.+.10
            (call L.*.12 (call L.+.10 219 64) (call L.-.11 216 174))
            (call L.-.11 (call L.*.12 17 70) (call L.-.11 22 123))))
          (empty3.2 (call L.fun/empty8907.4))
          (pair4.1 (call L.fun/pair8908.6)))
      (call L.fun/void8909.7))))
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
    (define L.cons.9 (lambda (tmp.51 tmp.52) (cons tmp.51 tmp.52)))
    (define L.fun/pair9174.4 (lambda () (call L.cons.9 127 459)))
    (define L.fun/ascii-char9175.5 (lambda () #\\))
    (define L.fun/empty9176.6 (lambda () empty))
    (define L.fun/error9177.7 (lambda () (error 68)))
    (let ((pair0.5 (call L.fun/pair9174.4))
          (ascii-char1.4 (call L.fun/ascii-char9175.5))
          (empty2.3 (call L.fun/empty9176.6))
          (error3.2 (call L.fun/error9177.7))
          (fixnum4.1
           (call
            L.*.12
            (call L.+.10 (call L.+.10 164 32) (call L.-.11 199 40))
            (call L.-.11 (call L.*.12 189 57) (call L.+.10 35 222)))))
      error3.2)))
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
    (define L.fun/error9704.4 (lambda () (error 220)))
    (define L.fun/void9703.5 (lambda () (void)))
    (define L.fun/void9702.6 (lambda () (void)))
    (define L.fun/empty9705.7 (lambda () empty))
    (let ((fixnum0.5
           (call
            L.-.10
            (call L.-.10 (call L.+.9 113 124) (call L.-.10 207 189))
            (call L.+.9 (call L.+.9 135 203) (call L.*.11 37 30))))
          (void1.4 (call L.fun/void9702.6))
          (void2.3 (call L.fun/void9703.5))
          (error3.2 (call L.fun/error9704.4))
          (empty4.1 (call L.fun/empty9705.7)))
      error3.2)))
(check-by-interp
 '(module
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
    (define L.-.9
      (lambda (tmp.23 tmp.24)
        (if (fixnum? tmp.24)
          (if (fixnum? tmp.23) (unsafe-fx- tmp.23 tmp.24) (error 3))
          (error 3))))
    (define L.cons.8 (lambda (tmp.51 tmp.52) (cons tmp.51 tmp.52)))
    (define L.fun/pair9710.4 (lambda () (call L.cons.8 99 330)))
    (define L.fun/error9708.5 (lambda () (error 214)))
    (define L.fun/void9709.6 (lambda () (void)))
    (let ((error0.5 (call L.fun/error9708.5))
          (void1.4 (call L.fun/void9709.6))
          (fixnum2.3
           (call
            L.+.10
            (call L.-.9 (call L.-.9 250 19) (call L.-.9 98 52))
            (call L.+.10 (call L.-.9 228 30) (call L.+.10 40 39))))
          (fixnum3.2
           (call
            L.*.11
            (call L.+.10 (call L.*.11 27 124) (call L.*.11 21 71))
            (call L.+.10 (call L.+.10 156 169) (call L.-.9 21 204))))
          (pair4.1 (call L.fun/pair9710.4)))
      void1.4)))
(check-by-interp
 '(module
    (define L.*.13
      (lambda (tmp.19 tmp.20)
        (if (fixnum? tmp.20)
          (if (fixnum? tmp.19) (unsafe-fx* tmp.19 tmp.20) (error 1))
          (error 1))))
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
    (define L.cons.10 (lambda (tmp.51 tmp.52) (cons tmp.51 tmp.52)))
    (define L.fun/void9976.4 (lambda () (void)))
    (define L.fun/pair9973.5 (lambda () (call L.cons.10 169 431)))
    (define L.fun/empty9975.6 (lambda () empty))
    (define L.fun/void9974.7 (lambda () (void)))
    (define L.fun/ascii-char9977.8 (lambda () #\Q))
    (let ((pair0.5 (call L.fun/pair9973.5))
          (void1.4 (call L.fun/void9974.7))
          (empty2.3 (call L.fun/empty9975.6))
          (void3.2 (call L.fun/void9976.4))
          (fixnum4.1
           (call
            L.-.12
            (call L.+.11 (call L.+.11 201 161) (call L.-.12 249 191))
            (call L.+.11 (call L.-.12 86 144) (call L.*.13 131 231)))))
      (call L.fun/ascii-char9977.8))))
(check-by-interp
 '(module
    (define L.fun/void15785.4 (lambda () (call L.fun/void15786.9)))
    (define L.fun/empty15784.5 (lambda () empty))
    (define L.fun/error15778.6 (lambda () (error 18)))
    (define L.fun/ascii-char15782.7 (lambda () #\t))
    (define L.fun/error15777.8 (lambda () (call L.fun/error15778.6)))
    (define L.fun/void15786.9 (lambda () (void)))
    (define L.fun/ascii-char15781.10
      (lambda () (call L.fun/ascii-char15782.7)))
    (define L.fun/ascii-char15779.11
      (lambda () (call L.fun/ascii-char15780.14)))
    (define L.fun/empty15775.12 (lambda () (call L.fun/empty15776.15)))
    (define L.fun/empty15783.13 (lambda () (call L.fun/empty15784.5)))
    (define L.fun/ascii-char15780.14 (lambda () #\R))
    (define L.fun/empty15776.15 (lambda () empty))
    (let ((empty0.6 (call L.fun/empty15775.12))
          (error1.5 (call L.fun/error15777.8))
          (ascii-char2.4 (call L.fun/ascii-char15779.11))
          (ascii-char3.3 (call L.fun/ascii-char15781.10))
          (empty4.2 (call L.fun/empty15783.13))
          (void5.1 (call L.fun/void15785.4)))
      void5.1)))
(check-by-interp
 '(module
    (define L.void?.16 (lambda (tmp.46) (void? tmp.46)))
    (define L.boolean?.15 (lambda (tmp.44) (boolean? tmp.44)))
    (define L.fun/any18974.4 (lambda () (void)))
    (define L.fun/void18977.5 (lambda () (call L.fun/void18978.12)))
    (define L.fun/ascii-char18970.6 (lambda () #\]))
    (define L.fun/ascii-char18969.7 (lambda () (call L.fun/ascii-char18970.6)))
    (define L.fun/error18976.8 (lambda () (error 155)))
    (define L.fun/void18971.9 (lambda () (call L.fun/void18972.10)))
    (define L.fun/void18972.10 (lambda () (void)))
    (define L.fun/error18975.11 (lambda () (call L.fun/error18976.8)))
    (define L.fun/void18978.12 (lambda () (void)))
    (define L.fun/any18973.13 (lambda () (error 238)))
    (let ((ascii-char0.6 (call L.fun/ascii-char18969.7))
          (void1.5 (call L.fun/void18971.9))
          (boolean2.4 (call L.boolean?.15 (call L.fun/any18973.13)))
          (boolean3.3 (call L.void?.16 (call L.fun/any18974.4)))
          (error4.2 (call L.fun/error18975.11))
          (void5.1 (call L.fun/void18977.5)))
      ascii-char0.6)))
(check-by-interp
 '(module
    (define L.cons.17 (lambda (tmp.52 tmp.53) (cons tmp.52 tmp.53)))
    (define L.fun/error19375.4 (lambda () (error 21)))
    (define L.fun/empty19379.5 (lambda () empty))
    (define L.fun/error19373.6 (lambda () (error 4)))
    (define L.fun/pair19383.7 (lambda () (call L.cons.17 212 381)))
    (define L.fun/ascii-char19377.8 (lambda () #\p))
    (define L.fun/pair19382.9 (lambda () (call L.fun/pair19383.7)))
    (define L.fun/ascii-char19376.10
      (lambda () (call L.fun/ascii-char19377.8)))
    (define L.fun/empty19378.11 (lambda () (call L.fun/empty19379.5)))
    (define L.fun/empty19381.12 (lambda () empty))
    (define L.fun/empty19380.13 (lambda () (call L.fun/empty19381.12)))
    (define L.fun/error19372.14 (lambda () (call L.fun/error19373.6)))
    (define L.fun/error19374.15 (lambda () (call L.fun/error19375.4)))
    (let ((error0.6 (call L.fun/error19372.14))
          (error1.5 (call L.fun/error19374.15))
          (ascii-char2.4 (call L.fun/ascii-char19376.10))
          (empty3.3 (call L.fun/empty19378.11))
          (empty4.2 (call L.fun/empty19380.13))
          (pair5.1 (call L.fun/pair19382.9)))
      pair5.1)))
(check-by-interp
 '(module
    (define L.boolean?.15 (lambda (tmp.44) (boolean? tmp.44)))
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
    (define L.+.12
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.fun/void20855.4 (lambda () (void)))
    (define L.fun/ascii-char20850.5 (lambda () (call L.fun/ascii-char20851.8)))
    (define L.fun/void20854.6 (lambda () (call L.fun/void20855.4)))
    (define L.fun/any20856.7 (lambda () #t))
    (define L.fun/ascii-char20851.8 (lambda () #\t))
    (define L.fun/ascii-char20853.9 (lambda () #\_))
    (define L.fun/ascii-char20852.10
      (lambda () (call L.fun/ascii-char20853.9)))
    (let ((ascii-char0.6 (call L.fun/ascii-char20850.5))
          (fixnum1.5
           (call
            L.+.12
            (call
             L.-.14
             (call L.+.12 (call L.+.12 150 57) (call L.+.12 42 77))
             (call L.-.14 (call L.*.13 44 60) (call L.-.14 57 155)))
            (call
             L.-.14
             (call L.*.13 (call L.+.12 158 80) (call L.-.14 63 50))
             (call L.-.14 (call L.+.12 128 83) (call L.-.14 14 117)))))
          (ascii-char2.4 (call L.fun/ascii-char20852.10))
          (fixnum3.3
           (call
            L.-.14
            (call
             L.+.12
             (call L.-.14 (call L.*.13 47 84) (call L.*.13 141 44))
             (call L.+.12 (call L.-.14 170 237) (call L.+.12 231 210)))
            (call
             L.*.13
             (call L.-.14 (call L.+.12 31 55) (call L.-.14 120 244))
             (call L.+.12 (call L.+.12 63 31) (call L.-.14 87 221)))))
          (void4.2 (call L.fun/void20854.6))
          (fixnum5.1
           (call
            L.*.13
            (call
             L.-.14
             (call L.-.14 (call L.-.14 53 194) (call L.-.14 158 18))
             (call L.*.13 (call L.-.14 80 157) (call L.+.12 89 238)))
            (call
             L.+.12
             (call L.+.12 (call L.+.12 135 163) (call L.*.13 125 241))
             (call L.-.14 (call L.*.13 215 52) (call L.-.14 168 139))))))
      (call L.boolean?.15 (call L.fun/any20856.7)))))
(check-by-interp
 '(module
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
    (define L.+.16
      (lambda (tmp.22 tmp.23)
        (if (fixnum? tmp.23)
          (if (fixnum? tmp.22) (unsafe-fx+ tmp.22 tmp.23) (error 2))
          (error 2))))
    (define L.cons.15 (lambda (tmp.52 tmp.53) (cons tmp.52 tmp.53)))
    (define L.fun/ascii-char22195.4 (lambda () #\z))
    (define L.fun/empty22197.5 (lambda () empty))
    (define L.fun/pair22193.6 (lambda () (call L.cons.15 80 290)))
    (define L.fun/pair22192.7 (lambda () (call L.fun/pair22193.6)))
    (define L.fun/empty22199.8 (lambda () empty))
    (define L.fun/empty22198.9 (lambda () (call L.fun/empty22199.8)))
    (define L.fun/empty22196.10 (lambda () (call L.fun/empty22197.5)))
    (define L.fun/error22191.11 (lambda () (error 75)))
    (define L.fun/error22190.12 (lambda () (call L.fun/error22191.11)))
    (define L.fun/ascii-char22194.13
      (lambda () (call L.fun/ascii-char22195.4)))
    (let ((error0.6 (call L.fun/error22190.12))
          (pair1.5 (call L.fun/pair22192.7))
          (ascii-char2.4 (call L.fun/ascii-char22194.13))
          (empty3.3 (call L.fun/empty22196.10))
          (empty4.2 (call L.fun/empty22198.9))
          (fixnum5.1
           (call
            L.+.16
            (call
             L.*.17
             (call L.-.18 (call L.+.16 134 176) (call L.*.17 154 98))
             (call L.-.18 (call L.*.17 187 211) (call L.+.16 104 103)))
            (call
             L.-.18
             (call L.+.16 (call L.*.17 49 110) (call L.*.17 39 24))
             (call L.*.17 (call L.*.17 216 72) (call L.-.18 20 106))))))
      error0.6)))
(check-by-interp
 '(module
    (define L.*.20
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
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
    (define L.vector?.17 (lambda (tmp.50) (vector? tmp.50)))
    (define L.cons.16 (lambda (tmp.52 tmp.53) (cons tmp.52 tmp.53)))
    (define L.fun/pair23550.4 (lambda () (call L.fun/pair23551.8)))
    (define L.fun/void23549.5 (lambda () (void)))
    (define L.fun/void23541.6 (lambda () (call L.fun/void23542.14)))
    (define L.fun/void23548.7 (lambda () (call L.fun/void23549.5)))
    (define L.fun/pair23551.8 (lambda () (call L.cons.16 83 484)))
    (define L.fun/error23546.9 (lambda () (call L.fun/error23547.11)))
    (define L.fun/empty23544.10 (lambda () empty))
    (define L.fun/error23547.11 (lambda () (error 210)))
    (define L.fun/any23545.12 (lambda () #f))
    (define L.fun/empty23543.13 (lambda () (call L.fun/empty23544.10)))
    (define L.fun/void23542.14 (lambda () (void)))
    (let ((void0.6 (call L.fun/void23541.6))
          (empty1.5 (call L.fun/empty23543.13))
          (boolean2.4 (call L.vector?.17 (call L.fun/any23545.12)))
          (fixnum3.3
           (call
            L.+.19
            (call
             L.-.18
             (call L.+.19 (call L.-.18 181 46) (call L.-.18 84 191))
             (call L.*.20 (call L.+.19 226 58) (call L.-.18 13 65)))
            (call
             L.*.20
             (call L.+.19 (call L.*.20 158 13) (call L.-.18 56 56))
             (call L.+.19 (call L.+.19 208 40) (call L.*.20 162 14)))))
          (error4.2 (call L.fun/error23546.9))
          (void5.1 (call L.fun/void23548.7)))
      (call L.fun/pair23550.4))))
(check-by-interp
 '(module
    (define L.fun/error24539.4 (lambda () (error 62)))
    (define L.fun/ascii-char24535.5 (lambda () #\I))
    (define L.fun/ascii-char24529.6 (lambda () #\`))
    (define L.fun/empty24537.7 (lambda () empty))
    (define L.fun/ascii-char24534.8 (lambda () (call L.fun/ascii-char24535.5)))
    (define L.fun/error24531.9 (lambda () (error 10)))
    (define L.fun/error24538.10 (lambda () (call L.fun/error24539.4)))
    (define L.fun/empty24536.11 (lambda () (call L.fun/empty24537.7)))
    (define L.fun/void24532.12 (lambda () (call L.fun/void24533.14)))
    (define L.fun/error24530.13 (lambda () (call L.fun/error24531.9)))
    (define L.fun/void24533.14 (lambda () (void)))
    (define L.fun/ascii-char24528.15
      (lambda () (call L.fun/ascii-char24529.6)))
    (let ((ascii-char0.6 (call L.fun/ascii-char24528.15))
          (error1.5 (call L.fun/error24530.13))
          (void2.4 (call L.fun/void24532.12))
          (ascii-char3.3 (call L.fun/ascii-char24534.8))
          (empty4.2 (call L.fun/empty24536.11))
          (error5.1 (call L.fun/error24538.10)))
      empty4.2)))
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
    (define L.fun/empty24788.4 (lambda () empty))
    (define L.fun/error24789.5 (lambda () (call L.fun/error24790.10)))
    (define L.fun/error24786.6 (lambda () (error 135)))
    (define L.fun/error24785.7 (lambda () (call L.fun/error24786.6)))
    (define L.fun/empty24792.8 (lambda () empty))
    (define L.fun/empty24787.9 (lambda () (call L.fun/empty24788.4)))
    (define L.fun/error24790.10 (lambda () (error 43)))
    (define L.fun/empty24791.11 (lambda () (call L.fun/empty24792.8)))
    (let ((error0.6 (call L.fun/error24785.7))
          (fixnum1.5
           (call
            L.-.15
            (call
             L.-.15
             (call L.+.13 (call L.+.13 174 139) (call L.*.14 138 198))
             (call L.-.15 (call L.*.14 11 128) (call L.+.13 85 4)))
            (call
             L.+.13
             (call L.+.13 (call L.-.15 206 209) (call L.*.14 252 202))
             (call L.*.14 (call L.-.15 130 189) (call L.+.13 253 157)))))
          (empty2.4 (call L.fun/empty24787.9))
          (error3.3 (call L.fun/error24789.5))
          (fixnum4.2
           (call
            L.*.14
            (call
             L.-.15
             (call L.-.15 (call L.*.14 80 76) (call L.*.14 11 230))
             (call L.+.13 (call L.+.13 249 251) (call L.*.14 79 245)))
            (call
             L.*.14
             (call L.+.13 (call L.*.14 93 174) (call L.*.14 101 55))
             (call L.*.14 (call L.-.15 171 115) (call L.-.15 114 115)))))
          (empty5.1 (call L.fun/empty24791.11)))
      (call
       L.+.13
       (call
        L.+.13
        (call L.-.15 (call L.-.15 7 fixnum4.2) fixnum4.2)
        (call L.*.14 fixnum1.5 (call L.*.14 18 fixnum1.5)))
       (call L.-.15 fixnum4.2 fixnum1.5)))))
(check-by-interp
 '(module
    (define L.error?.19 (lambda (tmp.48) (error? tmp.48)))
    (define L.cons.18 (lambda (tmp.52 tmp.53) (cons tmp.52 tmp.53)))
    (define L.fun/pair24832.4 (lambda () (call L.fun/pair24833.15)))
    (define L.fun/error24829.5 (lambda () (error 8)))
    (define L.fun/pair24835.6 (lambda () (call L.fun/pair24836.7)))
    (define L.fun/pair24836.7 (lambda () (call L.cons.18 130 507)))
    (define L.fun/any24834.8 (lambda () (error 159)))
    (define L.fun/ascii-char24839.9
      (lambda () (call L.fun/ascii-char24840.12)))
    (define L.fun/void24831.10 (lambda () (void)))
    (define L.fun/void24830.11 (lambda () (call L.fun/void24831.10)))
    (define L.fun/ascii-char24840.12 (lambda () #\g))
    (define L.fun/empty24838.13 (lambda () empty))
    (define L.fun/empty24837.14 (lambda () (call L.fun/empty24838.13)))
    (define L.fun/pair24833.15 (lambda () (call L.cons.18 232 443)))
    (define L.fun/error24828.16 (lambda () (call L.fun/error24829.5)))
    (let ((error0.6 (call L.fun/error24828.16))
          (void1.5 (call L.fun/void24830.11))
          (pair2.4 (call L.fun/pair24832.4))
          (boolean3.3 (call L.error?.19 (call L.fun/any24834.8)))
          (pair4.2 (call L.fun/pair24835.6))
          (empty5.1 (call L.fun/empty24837.14)))
      (call L.fun/ascii-char24839.9))))
(check-by-interp
 '(module
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
    (define L.*.14
      (lambda (tmp.20 tmp.21)
        (if (fixnum? tmp.21)
          (if (fixnum? tmp.20) (unsafe-fx* tmp.20 tmp.21) (error 1))
          (error 1))))
    (define L.cons.13 (lambda (tmp.52 tmp.53) (cons tmp.52 tmp.53)))
    (define L.fun/empty27006.4 (lambda () (call L.fun/empty27007.9)))
    (define L.fun/pair27009.5 (lambda () (call L.cons.13 221 369)))
    (define L.fun/void27004.6 (lambda () (call L.fun/void27005.11)))
    (define L.fun/ascii-char27003.7 (lambda () #\u))
    (define L.fun/pair27008.8 (lambda () (call L.fun/pair27009.5)))
    (define L.fun/empty27007.9 (lambda () empty))
    (define L.fun/ascii-char27002.10
      (lambda () (call L.fun/ascii-char27003.7)))
    (define L.fun/void27005.11 (lambda () (void)))
    (let ((fixnum0.6
           (call
            L.-.15
            (call
             L.+.16
             (call L.-.15 (call L.*.14 33 185) (call L.-.15 157 51))
             (call L.+.16 (call L.-.15 48 176) (call L.-.15 252 173)))
            (call
             L.-.15
             (call L.*.14 (call L.-.15 21 173) (call L.*.14 109 101))
             (call L.-.15 (call L.+.16 70 76) (call L.-.15 65 109)))))
          (fixnum1.5
           (call
            L.*.14
            (call
             L.*.14
             (call L.+.16 (call L.+.16 97 61) (call L.*.14 88 171))
             (call L.+.16 (call L.-.15 235 199) (call L.*.14 135 228)))
            (call
             L.-.15
             (call L.-.15 (call L.-.15 164 225) (call L.*.14 99 232))
             (call L.-.15 (call L.*.14 76 51) (call L.-.15 2 113)))))
          (ascii-char2.4 (call L.fun/ascii-char27002.10))
          (void3.3 (call L.fun/void27004.6))
          (empty4.2 (call L.fun/empty27006.4))
          (fixnum5.1
           (call
            L.+.16
            (call
             L.*.14
             (call L.*.14 (call L.*.14 88 6) (call L.-.15 181 146))
             (call L.-.15 (call L.-.15 127 98) (call L.*.14 30 252)))
            (call
             L.*.14
             (call L.-.15 (call L.-.15 62 246) (call L.+.16 209 211))
             (call L.-.15 (call L.*.14 110 124) (call L.-.15 147 125))))))
      (call L.fun/pair27008.8))))
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
    (define L.fun/ascii-char27114.4 (lambda () (call L.fun/ascii-char27115.8)))
    (define L.fun/empty27120.5 (lambda () (call L.fun/empty27121.11)))
    (define L.fun/error27116.6 (lambda () (call L.fun/error27117.7)))
    (define L.fun/error27117.7 (lambda () (error 135)))
    (define L.fun/ascii-char27115.8 (lambda () #\[))
    (define L.fun/ascii-char27123.9 (lambda () #\l))
    (define L.fun/ascii-char27122.10
      (lambda () (call L.fun/ascii-char27123.9)))
    (define L.fun/empty27121.11 (lambda () empty))
    (define L.fun/empty27118.12 (lambda () (call L.fun/empty27119.13)))
    (define L.fun/empty27119.13 (lambda () empty))
    (let ((ascii-char0.6 (call L.fun/ascii-char27114.4))
          (error1.5 (call L.fun/error27116.6))
          (empty2.4 (call L.fun/empty27118.12))
          (empty3.3 (call L.fun/empty27120.5))
          (fixnum4.2
           (call
            L.+.16
            (call
             L.+.16
             (call L.-.15 (call L.-.15 76 73) (call L.-.15 222 163))
             (call L.+.16 (call L.+.16 182 228) (call L.+.16 229 39)))
            (call
             L.*.17
             (call L.*.17 (call L.-.15 192 1) (call L.-.15 81 114))
             (call L.+.16 (call L.+.16 86 163) (call L.-.15 193 137)))))
          (ascii-char5.1 (call L.fun/ascii-char27122.10)))
      (call
       L.-.15
       (call
        L.*.17
        (call L.-.15 fixnum4.2 (call L.*.17 fixnum4.2 241))
        (call L.+.16 fixnum4.2 (call L.+.16 23 fixnum4.2)))
       (call
        L.-.15
        (call L.+.16 (call L.-.15 115 114) fixnum4.2)
        (call L.-.15 (call L.-.15 99 219) fixnum4.2))))))
(check-by-interp
 '(module
    (define L.pair?.19 (lambda (tmp.49) (pair? tmp.49)))
    (define L.cons.18 (lambda (tmp.52 tmp.53) (cons tmp.52 tmp.53)))
    (define L.fun/pair27447.4 (lambda () (call L.fun/pair27448.11)))
    (define L.fun/ascii-char27445.5
      (lambda () (call L.fun/ascii-char27446.13)))
    (define L.fun/ascii-char27438.6 (lambda () #\G))
    (define L.fun/error27440.7 (lambda () (error 130)))
    (define L.fun/ascii-char27443.8
      (lambda () (call L.fun/ascii-char27444.14)))
    (define L.fun/void27441.9 (lambda () (call L.fun/void27442.12)))
    (define L.fun/error27439.10 (lambda () (call L.fun/error27440.7)))
    (define L.fun/pair27448.11 (lambda () (call L.cons.18 186 439)))
    (define L.fun/void27442.12 (lambda () (void)))
    (define L.fun/ascii-char27446.13 (lambda () #\r))
    (define L.fun/ascii-char27444.14 (lambda () #\b))
    (define L.fun/ascii-char27437.15
      (lambda () (call L.fun/ascii-char27438.6)))
    (define L.fun/any27436.16 (lambda () (call L.cons.18 186 388)))
    (let ((boolean0.6 (call L.pair?.19 (call L.fun/any27436.16)))
          (ascii-char1.5 (call L.fun/ascii-char27437.15))
          (error2.4 (call L.fun/error27439.10))
          (void3.3 (call L.fun/void27441.9))
          (ascii-char4.2 (call L.fun/ascii-char27443.8))
          (ascii-char5.1 (call L.fun/ascii-char27445.5)))
      (call L.fun/pair27447.4))))
