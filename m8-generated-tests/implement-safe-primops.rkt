#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         "../implement-safe-primops.rkt")
(define (fail-if-invalid p)
  (when (not (exprs-unsafe-data-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "exprs-unsafe-data-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-exprs-unique-lang-v8 p)
  (interp-exprs-unsafe-data-lang-v8
   (fail-if-invalid (implement-safe-primops p)))))

(check-by-interp '(module (void)))
(check-by-interp '(module (call cons 226 477)))
(check-by-interp '(module (let ((ascii-char0.1 #\k)) empty)))
(check-by-interp '(module (let ((void0.1 (void))) #\|)))
(check-by-interp '(module (let ((void0.1 (void))) (call cons 203 463))))
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
    (define L.fun/pair8398.4 (lambda (oprand0.1) (call cons 144 422)))
    (define L.fun/fixnum8397.5 (lambda (oprand0.2) 65))
    (call L.fun/fixnum8397.5 (call L.fun/pair8398.4 (call make-vector 8)))))
(check-by-interp
 '(module
    (define L.fun/error8401.4 (lambda (oprand0.1) (error 7)))
    (define L.fun/void8402.5 (lambda (oprand0.2) (void)))
    (call L.fun/error8401.4 (call L.fun/void8402.5 empty))))
(check-by-interp
 '(module
    (let ((ascii-char0.2 #\G) (pair1.1 (call cons 104 284))) ascii-char0.2)))
(check-by-interp
 '(module
    (define L.fun/pair8407.4 (lambda (oprand0.1) (call cons 50 484)))
    (call L.fun/pair8407.4 (if #t #\D #\F))))
(check-by-interp '(module (let ((fixnum0.2 214) (boolean1.1 #t)) 233)))
(check-by-interp
 '(module (let ((error0.2 (error 51)) (boolean1.1 #t)) boolean1.1)))
(check-by-interp
 '(module
    (define L.fun/vector8415.4 (lambda () (call make-vector 8)))
    (define L.fun/void8414.5 (lambda () (void)))
    (let ((void0.3 (call L.fun/void8414.5))
          (fixnum1.2 (call + 168 43))
          (vector2.1 (call L.fun/vector8415.4)))
      (call - 29 101))))
(check-by-interp
 '(module
    (define L.fun/error8419.4 (lambda (oprand0.2 oprand1.1) (error 186)))
    (define L.fun/boolean8418.5 (lambda (oprand0.4 oprand1.3) #f))
    (define L.fun/error8420.6 (lambda (oprand0.6 oprand1.5) (error 156)))
    (if (call L.fun/boolean8418.5 #t 57)
      (call L.fun/error8419.4 #t empty)
      (call L.fun/error8420.6 empty (call cons 26 405)))))
(check-by-interp
 '(module
    (define L.fun/empty8426.4 (lambda (oprand0.2 oprand1.1) empty))
    (call
     L.fun/empty8426.4
     (let ((fixnum0.5 76)
           (pair1.4 (call cons 82 258))
           (pair2.3 (call cons 88 343)))
       (void))
     (let ((void0.8 (void)) (boolean1.7 #f) (fixnum2.6 7))
       (call make-vector 8)))))
(check-by-interp
 '(module
    (define L.fun/error8429.4 (lambda (oprand0.2 oprand1.1) (error 226)))
    (define L.fun/error8430.5 (lambda (oprand0.4 oprand1.3) (error 136)))
    (if (call void? (call make-vector 8))
      (call L.fun/error8429.4 (void) #\/)
      (call L.fun/error8430.5 (void) (call cons 136 343)))))
(check-by-interp
 '(module
    (define L.fun/empty8433.4 (lambda () empty))
    (define L.fun/pair8436.5 (lambda () (call cons 54 417)))
    (define L.fun/void8434.6 (lambda () (void)))
    (define L.fun/vector8435.7 (lambda () (call make-vector 8)))
    (let ((empty0.3 (call L.fun/empty8433.4))
          (void1.2 (call L.fun/void8434.6))
          (vector2.1 (call L.fun/vector8435.7)))
      (call L.fun/pair8436.5))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8439.4 (lambda () #\W))
    (define L.fun/error8440.5 (lambda () (error 18)))
    (define L.fun/pair8441.6 (lambda () (call cons 88 299)))
    (let ((ascii-char0.3 (call L.fun/ascii-char8439.4))
          (error1.2 (call L.fun/error8440.5))
          (pair2.1 (call L.fun/pair8441.6)))
      (call + 253 133))))
(check-by-interp
 '(module
    (call
     *
     (let ((boolean0.3 #t) (empty1.2 empty) (pair2.1 (call cons 24 355))) 25)
     (let ((boolean0.6 #t)
           (vector1.5 (call make-vector 8))
           (ascii-char2.4 #\!))
       182))))
(check-by-interp
 '(module
    (define L.fun/pair8455.4
      (lambda (oprand0.2 oprand1.1) (call cons 224 257)))
    (if (let ((fixnum0.5 158)
              (pair1.4 (call cons 174 325))
              (ascii-char2.3 #\Q))
          #f)
      (call L.fun/pair8455.4 (call make-vector 8) (void))
      (let ((error0.8 (error 168))
            (vector1.7 (call make-vector 8))
            (boolean2.6 #t))
        (call cons 37 257)))))
(check-by-interp
 '(module
    (define L.fun/pair8459.4 (lambda () (call cons 88 353)))
    (define L.fun/pair8458.5
      (lambda (oprand0.2 oprand1.1) (call L.fun/pair8459.4)))
    (call
     L.fun/pair8458.5
     (call empty? (if #f (error 211) (error 151)))
     (if #f (void) (void)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8463.4 (lambda () #\X))
    (define L.fun/ascii-char8462.5 (lambda () #\())
    (define L.fun/error8464.6 (lambda () (error 22)))
    (let ((ascii-char0.3 (call L.fun/ascii-char8462.5))
          (ascii-char1.2 (call L.fun/ascii-char8463.4))
          (boolean2.1 (call pair? #t)))
      (call L.fun/error8464.6))))
(check-by-interp
 '(module
    (define L.fun/boolean8469.4 (lambda (oprand0.2 oprand1.1) #t))
    (define L.fun/fixnum8471.5 (lambda (oprand0.4 oprand1.3) 9))
    (define L.fun/fixnum8470.6 (lambda (oprand0.6 oprand1.5) 154))
    (if (call L.fun/boolean8469.4 (void) (call cons 167 304))
      (call L.fun/fixnum8470.6 (call cons 242 331) (call make-vector 8))
      (call L.fun/fixnum8471.5 (void) (call cons 177 501)))))
(check-by-interp
 '(module
    (if (let ((boolean0.3 #f) (fixnum1.2 181) (boolean2.1 #f)) boolean0.3)
      (let ((fixnum0.6 138) (boolean1.5 #t) (error2.4 (error 251))) fixnum0.6)
      (if #t 52 83))))
(check-by-interp
 '(module
    (define L.fun/pair8479.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) oprand0.3))
    (define L.fun/vector8476.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) (call make-vector 8)))
    (define L.fun/ascii-char8477.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) #\[))
    (define L.fun/vector8478.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) (call make-vector 8)))
    (if (if #f #f #f)
      (call
       L.fun/vector8476.5
       (let ((boolean0.16 #f)
             (error1.15 (error 181))
             (boolean2.14 #t)
             (void3.13 (void)))
         boolean0.16)
       (call L.fun/ascii-char8477.6 (call cons 12 370) 170 (void))
       (if #f #t #t))
      (call
       L.fun/vector8478.7
       (if #f #\F #\$)
       (if #t (void) (void))
       (call L.fun/pair8479.4 (call cons 153 428) #t 57)))))
(check-by-interp
 '(module
    (define L.fun/void8484.4 (lambda () (void)))
    (define L.fun/empty8485.5 (lambda () empty))
    (define L.fun/pair8483.6 (lambda () (call cons 89 330)))
    (define L.fun/empty8482.7 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty8482.7))
          (pair1.3 (call L.fun/pair8483.6))
          (void2.2 (call L.fun/void8484.4))
          (empty3.1 (call L.fun/empty8485.5)))
      pair1.3)))
(check-by-interp
 '(module
    (define L.fun/void8492.4 (lambda () (void)))
    (define L.fun/vector8493.5 (lambda () (call make-vector 8)))
    (define L.fun/error8494.6 (lambda () (error 68)))
    (define L.fun/ascii-char8495.7 (lambda () #\B))
    (let ((void0.4 (call L.fun/void8492.4))
          (vector1.3 (call L.fun/vector8493.5))
          (error2.2 (call L.fun/error8494.6))
          (fixnum3.1 (call + (call - 143 8) (call * 212 95))))
      (call L.fun/ascii-char8495.7))))
(check-by-interp
 '(module
    (define L.fun/error8501.4 (lambda () (error 5)))
    (define L.fun/pair8499.5 (lambda () (call cons 74 259)))
    (define L.fun/void8500.6 (lambda () (void)))
    (define L.fun/void8498.7 (lambda () (void)))
    (let ((fixnum0.4 (call + (call * 175 223) (call - 222 253)))
          (void1.3 (call L.fun/void8498.7))
          (pair2.2 (call L.fun/pair8499.5))
          (void3.1 (call L.fun/void8500.6)))
      (call L.fun/error8501.4))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8504.4 (lambda () #\u))
    (define L.fun/empty8506.5 (lambda () empty))
    (define L.fun/vector8505.6 (lambda () (call make-vector 8)))
    (define L.fun/error8507.7 (lambda () (error 0)))
    (let ((ascii-char0.4 (call L.fun/ascii-char8504.4))
          (vector1.3 (call L.fun/vector8505.6))
          (empty2.2 (call L.fun/empty8506.5))
          (fixnum3.1 (call * (call + 27 134) (call + 183 253))))
      (call L.fun/error8507.7))))
(check-by-interp
 '(module
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
     (if (call pair? (call cons 86 450))
       (if #t (error 230) (error 90))
       (if #f (error 211) (error 77)))
     (if (call L.fun/boolean8513.7 52 246 40)
       (if #f #\H #\K)
       (if #t #\g #\J)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8517.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) (call L.fun/ascii-char8518.17)))
    (define L.fun/fixnum8523.5 (lambda (oprand0.6 oprand1.5 oprand2.4) 191))
    (define L.fun/vector8526.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) (call make-vector 8)))
    (define L.fun/error8520.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) (error 104)))
    (define L.fun/boolean8522.8 (lambda (oprand0.15 oprand1.14 oprand2.13) #t))
    (define L.fun/error8525.9
      (lambda (oprand0.18 oprand1.17 oprand2.16) (error 232)))
    (define L.fun/error8528.10 (lambda () (error 8)))
    (define L.fun/error8521.11
      (lambda (oprand0.21 oprand1.20 oprand2.19) oprand2.19))
    (define L.fun/ascii-char8519.12
      (lambda (oprand0.24 oprand1.23 oprand2.22) #\k))
    (define L.fun/error8529.13 (lambda () (error 177)))
    (define L.fun/pair8516.14
      (lambda (oprand0.27 oprand1.26 oprand2.25) oprand2.25))
    (define L.fun/vector8524.15
      (lambda (oprand0.30 oprand1.29 oprand2.28) (call make-vector 8)))
    (define L.fun/void8527.16 (lambda () (void)))
    (define L.fun/ascii-char8518.17 (lambda () #\c))
    (call
     L.fun/pair8516.14
     (call
      L.fun/ascii-char8517.4
      (let ((boolean0.34 #t)
            (error1.33 (error 12))
            (empty2.32 empty)
            (ascii-char3.31 #\L))
        85)
      (let ((empty0.38 empty)
            (vector1.37 (call make-vector 8))
            (void2.36 (void))
            (error3.35 (error 247)))
        (call vector-set! vector1.37 7 #\6))
      (call vector? (if #f (void) (call cons 89 345))))
     (call
      L.fun/ascii-char8519.12
      (call
       L.fun/error8520.7
       (call L.fun/error8521.11 (call cons 243 351) empty (error 57))
       (call vector? (error 77))
       (if #t (call make-vector 8) (call make-vector 8)))
      (call
       L.fun/boolean8522.8
       (let ((pair0.42 (call cons 161 496))
             (empty1.41 empty)
             (boolean2.40 #t)
             (ascii-char3.39 #\0))
         empty)
       (call L.fun/fixnum8523.5 empty (error 219) (call cons 79 445))
       (call L.fun/vector8524.15 (void) (call cons 76 340) #t))
      (call
       L.fun/error8525.9
       (call void? (call cons 149 497))
       (call L.fun/vector8526.6 (call cons 38 434) (void) (error 77))
       (call L.fun/error8525.9 #t (call make-vector 8) (error 231))))
     (let ((pair0.46 (call L.fun/pair8516.14 #\O #\q (call cons 80 281)))
           (void1.45 (call L.fun/void8527.16))
           (error2.44 (call L.fun/error8528.10))
           (error3.43 (call L.fun/error8529.13)))
       (call L.fun/pair8516.14 #\, #\. pair0.46)))))
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
    (define L.fun/empty8566.4 (lambda () empty))
    (define L.fun/pair8563.5 (lambda () (call cons 174 334)))
    (define L.fun/pair8567.6 (lambda () (call cons 216 425)))
    (define L.fun/vector8560.7
      (lambda (oprand0.3 oprand1.2 oprand2.1) (call L.fun/vector8561.10)))
    (define L.fun/pair8568.8 (lambda () (call cons 43 458)))
    (define L.fun/pair8570.9 (lambda () (call cons 157 272)))
    (define L.fun/vector8561.10 (lambda () (call make-vector 8)))
    (define L.fun/pair8569.11 (lambda () (call cons 198 510)))
    (define L.fun/error8565.12 (lambda () (error 179)))
    (define L.fun/ascii-char8571.13 (lambda () #\c))
    (define L.fun/error8562.14 (lambda () (error 221)))
    (define L.fun/error8564.15 (lambda () (error 74)))
    (call
     L.fun/vector8560.7
     (let ((error0.7 (call L.fun/error8562.14))
           (pair1.6 (call L.fun/pair8563.5))
           (error2.5 (call L.fun/error8564.15))
           (error3.4 (call L.fun/error8565.12)))
       error2.5)
     (let ((fixnum0.11 (call - 173 12))
           (boolean1.10 (call ascii-char? #f))
           (empty2.9 (call L.fun/empty8566.4))
           (pair3.8 (call L.fun/pair8567.6)))
       (call * fixnum0.11 65))
     (let ((pair0.15 (call L.fun/pair8568.8))
           (pair1.14 (call L.fun/pair8569.11))
           (pair2.13 (call L.fun/pair8570.9))
           (ascii-char3.12 (call L.fun/ascii-char8571.13)))
       (call cdr pair2.13)))))
(check-by-interp
 '(module
    (define L.fun/void8594.4 (lambda () (void)))
    (define L.fun/pair8598.5
      (lambda (oprand0.3 oprand1.2 oprand2.1) oprand2.1))
    (define L.fun/empty8602.6 (lambda (oprand0.6 oprand1.5 oprand2.4) empty))
    (define L.fun/ascii-char8597.7
      (lambda (oprand0.9 oprand1.8 oprand2.7) #\V))
    (define L.fun/void8596.8
      (lambda (oprand0.12 oprand1.11 oprand2.10) (void)))
    (define L.fun/pair8601.9
      (lambda (oprand0.15 oprand1.14 oprand2.13) (call cons 240 278)))
    (define L.fun/fixnum8604.10
      (lambda (oprand0.18 oprand1.17 oprand2.16) 185))
    (define L.fun/pair8603.11
      (lambda (oprand0.21 oprand1.20 oprand2.19) oprand1.20))
    (define L.fun/boolean8595.12
      (lambda (oprand0.24 oprand1.23 oprand2.22) (call void? 172)))
    (define L.fun/void8599.13
      (lambda (oprand0.27 oprand1.26 oprand2.25) (void)))
    (define L.fun/void8593.14
      (lambda (oprand0.30 oprand1.29 oprand2.28) (call L.fun/void8594.4)))
    (define L.fun/error8600.15
      (lambda (oprand0.33 oprand1.32 oprand2.31) (error 187)))
    (call
     L.fun/void8593.14
     (call
      L.fun/boolean8595.12
      (let ((empty0.37 empty)
            (ascii-char1.36 #\\)
            (vector2.35 (call make-vector 8))
            (pair3.34 (call cons 16 510)))
        pair3.34)
      (call
       L.fun/void8596.8
       (let ((error0.41 (error 207))
             (error1.40 (error 198))
             (void2.39 (void))
             (boolean3.38 #t))
         (error 233))
       (call
        L.fun/ascii-char8597.7
        empty
        (call make-vector 8)
        (call make-vector 8))
       (if #f (error 75) (error 199)))
      (call
       L.fun/pair8598.5
       (let ((ascii-char0.45 #\^)
             (vector1.44 (call make-vector 8))
             (boolean2.43 #t)
             (error3.42 (error 34)))
         (call make-vector 8))
       (call L.fun/void8599.13 empty empty (call cons 200 312))
       (call
        L.fun/pair8598.5
        (call make-vector 8)
        (void)
        (call cons 111 296))))
     (call
      L.fun/error8600.15
      (call
       L.fun/pair8601.9
       (let ((pair0.49 (call cons 80 502))
             (ascii-char1.48 #\~)
             (void2.47 (void))
             (pair3.46 (call cons 135 511)))
         (error 0))
       (if #f (call make-vector 8) (call make-vector 8))
       (call L.fun/empty8602.6 (void) (call make-vector 8) #t))
      (call
       L.fun/pair8603.11
       (if #t (error 53) (error 53))
       (call L.fun/pair8603.11 (error 0) (call cons 175 264) 86)
       (if #t 249 81))
      (let ((empty0.53 empty)
            (vector1.52 (call make-vector 8))
            (ascii-char2.51 #\X)
            (error3.50 (error 126)))
        (call cons 115 509)))
     (if (call boolean? (error 79))
       (call - 127 64)
       (call
        L.fun/fixnum8604.10
        (call cons 111 352)
        (call cons 30 467)
        (void))))))
(check-by-interp
 '(module
    (define L.fun/empty8611.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) oprand1.2))
    (define L.fun/pair8612.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) (call cons 132 481)))
    (define L.fun/boolean8616.6 (lambda (oprand0.9 oprand1.8 oprand2.7) #f))
    (define L.fun/pair8613.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) (call cons 238 279)))
    (define L.fun/error8610.8
      (lambda (oprand0.15 oprand1.14 oprand2.13) (error 175)))
    (define L.fun/void8608.9
      (lambda (oprand0.18 oprand1.17 oprand2.16) (call L.fun/void8609.11)))
    (define L.fun/ascii-char8614.10
      (lambda (oprand0.21 oprand1.20 oprand2.19) #\=))
    (define L.fun/void8609.11 (lambda () (void)))
    (define L.fun/pair8615.12
      (lambda (oprand0.24 oprand1.23 oprand2.22) (call cons 78 364)))
    (define L.fun/fixnum8607.13
      (lambda (oprand0.27 oprand1.26 oprand2.25)
        (call * (call * 14 110) (call * 226 237))))
    (call
     L.fun/fixnum8607.13
     (call
      L.fun/void8608.9
      (let ((fixnum0.31 48)
            (vector1.30 (call make-vector 8))
            (vector2.29 (call make-vector 8))
            (pair3.28 (call cons 53 383)))
        #f)
      (if #f (call cons 17 415) (call cons 127 446))
      (call
       L.fun/error8610.8
       (let ((ascii-char0.35 #\$)
             (vector1.34 (call make-vector 8))
             (empty2.33 empty)
             (ascii-char3.32 #\A))
         empty)
       (let ((fixnum0.39 86)
             (empty1.38 empty)
             (fixnum2.37 240)
             (ascii-char3.36 #\b))
         (error 144))
       (call L.fun/empty8611.4 (call cons 60 356) empty (void))))
     (if (call boolean? #t)
       (call L.fun/pair8612.5 #f #t (call make-vector 8))
       (call L.fun/pair8613.7 #f (call make-vector 8) (error 72)))
     (call
      L.fun/ascii-char8614.10
      (call
       L.fun/pair8615.12
       (call L.fun/boolean8616.6 (void) #t empty)
       (if #f (call cons 92 465) (call cons 53 482))
       (let ((vector0.43 (call make-vector 8))
             (boolean1.42 #f)
             (pair2.41 (call cons 215 494))
             (ascii-char3.40 #\w))
         ascii-char3.40))
      (let ((void0.47 (void))
            (pair1.46 (call cons 130 263))
            (pair2.45 (call cons 208 275))
            (empty3.44 empty))
        (error 125))
      (let ((pair0.51 (call cons 235 467))
            (ascii-char1.50 #\q)
            (pair2.49 (call cons 128 476))
            (error3.48 (error 78)))
        empty)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8623.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) #\5))
    (define L.fun/error8622.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) (error 109)))
    (define L.fun/void8621.6 (lambda (oprand0.9 oprand1.8 oprand2.7) (void)))
    (define L.fun/boolean8619.7 (lambda (oprand0.12 oprand1.11 oprand2.10) #t))
    (define L.fun/void8620.8
      (lambda (oprand0.15 oprand1.14 oprand2.13)
        (call vector-set! oprand2.13 7 #\i)))
    (if (call
         L.fun/boolean8619.7
         (if #f 118 251)
         (let ((ascii-char0.19 #\a)
               (vector1.18 (call make-vector 8))
               (ascii-char2.17 #\h)
               (error3.16 (error 224)))
           error3.16)
         (call L.fun/void8620.8 #t (void) (call make-vector 8)))
      (let ((boolean0.23 #t)
            (void1.22 (void))
            (ascii-char2.21 #\0)
            (fixnum3.20 228))
        void1.22)
      (call
       L.fun/void8621.6
       (call L.fun/error8622.5 #\7 (void) (call make-vector 8))
       (if #f 187 237)
       (call
        L.fun/ascii-char8623.4
        (call make-vector 8)
        #f
        (call make-vector 8))))))
(check-by-interp
 '(module
    (define L.fun/vector8648.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) (call make-vector 8)))
    (define L.fun/void8642.5 (lambda () (void)))
    (define L.fun/error8641.6 (lambda () (error 181)))
    (define L.fun/ascii-char8649.7
      (lambda (oprand0.6 oprand1.5 oprand2.4) #\N))
    (define L.fun/fixnum8640.8 (lambda (oprand0.9 oprand1.8 oprand2.7) 112))
    (define L.fun/boolean8639.9 (lambda (oprand0.12 oprand1.11 oprand2.10) #t))
    (define L.fun/vector8638.10
      (lambda (oprand0.15 oprand1.14 oprand2.13) oprand2.13))
    (define L.fun/pair8646.11
      (lambda (oprand0.18 oprand1.17 oprand2.16) (call cons 118 468)))
    (define L.fun/empty8644.12
      (lambda (oprand0.21 oprand1.20 oprand2.19) empty))
    (define L.fun/fixnum8645.13
      (lambda (oprand0.24 oprand1.23 oprand2.22) 159))
    (define L.fun/ascii-char8647.14
      (lambda (oprand0.27 oprand1.26 oprand2.25) #\~))
    (define L.fun/empty8643.15 (lambda () empty))
    (call
     L.fun/vector8638.10
     (if (call L.fun/boolean8639.9 empty 139 #\[)
       (let ((void0.31 (void))
             (vector1.30 (call make-vector 8))
             (ascii-char2.29 #\r)
             (void3.28 (void)))
         141)
       (call L.fun/fixnum8640.8 (void) #\T empty))
     (let ((fixnum0.35 (call + 191 60))
           (fixnum1.34 (call + 17 35))
           (error2.33 (call L.fun/error8641.6))
           (void3.32 (call L.fun/void8642.5)))
       (call L.fun/empty8643.15))
     (call
      L.fun/vector8638.10
      (let ((empty0.39 empty)
            (vector1.38 (call make-vector 8))
            (error2.37 (error 238))
            (void3.36 (void)))
        59)
      (call
       L.fun/empty8644.12
       (call L.fun/fixnum8645.13 (error 15) 53 (call make-vector 8))
       (call L.fun/pair8646.11 (error 28) (void) (call make-vector 8))
       (call L.fun/ascii-char8647.14 empty #t (error 31)))
      (call
       L.fun/vector8648.4
       (let ((pair0.43 (call cons 176 322))
             (empty1.42 empty)
             (fixnum2.41 51)
             (empty3.40 empty))
         #\))
       (let ((vector0.47 (call make-vector 8))
             (error1.46 (error 83))
             (void2.45 (void))
             (pair3.44 (call cons 16 262)))
         empty)
       (call
        L.fun/ascii-char8649.7
        (call make-vector 8)
        #\+
        (call cons 212 439)))))))
(check-by-interp
 '(module
    (define L.fun/error8653.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) (error 210)))
    (define L.fun/boolean8655.5 (lambda (oprand0.6 oprand1.5 oprand2.4) #f))
    (define L.fun/void8654.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) oprand1.8))
    (define L.fun/void8652.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) (void)))
    (if (let ((ascii-char0.16 #\F)
              (empty1.15 empty)
              (pair2.14 (call cons 173 334))
              (fixnum3.13 148))
          #t)
      (call
       L.fun/void8652.7
       (let ((vector0.20 (call make-vector 8))
             (pair1.19 (call cons 109 333))
             (void2.18 (void))
             (pair3.17 (call cons 127 371)))
         void2.18)
       (call L.fun/error8653.4 (void) #f (call make-vector 8))
       (if #f #\X #\7))
      (call
       L.fun/void8654.6
       (call ascii-char? 145)
       (call L.fun/void8654.6 #t (void) #t)
       (call L.fun/boolean8655.5 (call cons 52 492) (void) (void))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8659.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) #\q))
    (define L.fun/boolean8660.5 (lambda (oprand0.6 oprand1.5 oprand2.4) #f))
    (define L.fun/vector8665.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) oprand0.9))
    (define L.fun/ascii-char8661.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) #\K))
    (define L.fun/fixnum8662.8
      (lambda (oprand0.15 oprand1.14 oprand2.13) oprand2.13))
    (define L.fun/vector8658.9
      (lambda (oprand0.18 oprand1.17 oprand2.16) oprand2.16))
    (define L.fun/ascii-char8664.10
      (lambda (oprand0.21 oprand1.20 oprand2.19) #\e))
    (define L.fun/empty8663.11
      (lambda (oprand0.24 oprand1.23 oprand2.22) empty))
    (call
     L.fun/vector8658.9
     (call
      L.fun/ascii-char8659.4
      (if #f (error 28) (error 67))
      (if #f (void) (void))
      (let ((error0.28 (error 79))
            (error1.27 (error 99))
            (vector2.26 (call make-vector 8))
            (pair3.25 (call cons 119 465)))
        pair3.25))
     (if (call L.fun/boolean8660.5 121 #\5 (error 43))
       (let ((error0.32 (error 142))
             (void1.31 (void))
             (void2.30 (void))
             (boolean3.29 #t))
         (call make-vector 8))
       (call L.fun/vector8658.9 #\i (call make-vector 8) (call make-vector 8)))
     (call
      L.fun/vector8658.9
      (call
       L.fun/ascii-char8661.7
       (if #t 67 75)
       (call L.fun/fixnum8662.8 #t (error 194) 100)
       (call L.fun/empty8663.11 (void) (void) (error 230)))
      (call
       L.fun/vector8658.9
       (call L.fun/ascii-char8664.10 (void) #\{ 111)
       (call
        L.fun/vector8665.6
        (call make-vector 8)
        (call make-vector 8)
        empty)
       (if #f (call make-vector 8) (call make-vector 8)))
      (let ((error0.36 (error 142))
            (empty1.35 empty)
            (empty2.34 empty)
            (error3.33 (error 157)))
        (call make-vector 8))))))
(check-by-interp
 '(module
    (define L.fun/vector8675.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) oprand2.1))
    (define L.fun/ascii-char8671.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) oprand2.4))
    (define L.fun/error8678.6 (lambda () (error 104)))
    (define L.fun/boolean8673.7
      (lambda (oprand0.9 oprand1.8 oprand2.7) oprand0.9))
    (define L.fun/empty8676.8
      (lambda (oprand0.12 oprand1.11 oprand2.10) empty))
    (define L.fun/boolean8674.9 (lambda (oprand0.15 oprand1.14 oprand2.13) #t))
    (define L.fun/ascii-char8669.10 (lambda () #\i))
    (define L.fun/error8677.11
      (lambda (oprand0.18 oprand1.17 oprand2.16) (call L.fun/error8678.6)))
    (define L.fun/ascii-char8668.12
      (lambda (oprand0.21 oprand1.20 oprand2.19)
        (call L.fun/ascii-char8669.10)))
    (define L.fun/pair8670.13
      (lambda (oprand0.24 oprand1.23 oprand2.22) oprand0.24))
    (define L.fun/boolean8672.14
      (lambda (oprand0.27 oprand1.26 oprand2.25) #f))
    (call
     L.fun/ascii-char8668.12
     (call
      L.fun/pair8670.13
      (call
       L.fun/pair8670.13
       (if #t (call cons 173 407) (call cons 157 319))
       (call L.fun/ascii-char8671.5 78 #\A #\,)
       (call L.fun/boolean8672.14 (call cons 78 376) (error 159) (void)))
      (if #t #\- #\/)
      (call
       L.fun/boolean8673.7
       (let ((empty0.31 empty)
             (empty1.30 empty)
             (ascii-char2.29 #\6)
             (error3.28 (error 174)))
         #f)
       (call L.fun/boolean8674.9 113 #\c (void))
       (call L.fun/vector8675.4 #\v (call cons 156 502) (call make-vector 8))))
     (call
      L.fun/empty8676.8
      (let ((fixnum0.35 117)
            (boolean1.34 #t)
            (fixnum2.33 166)
            (vector3.32 (call make-vector 8)))
        #\N)
      (let ((fixnum0.39 144)
            (boolean1.38 #f)
            (fixnum2.37 163)
            (ascii-char3.36 #\,))
        (void))
      (let ((pair0.43 (call cons 235 303))
            (pair1.42 (call cons 136 295))
            (fixnum2.41 157)
            (error3.40 (error 74)))
        fixnum2.41))
     (call
      L.fun/error8677.11
      (if #t 16 131)
      (let ((void0.47 (void))
            (boolean1.46 #t)
            (error2.45 (error 5))
            (error3.44 (error 161)))
        123)
      (let ((boolean0.51 #f)
            (vector1.50 (call make-vector 8))
            (empty2.49 empty)
            (void3.48 (void)))
        empty2.49)))))
(check-by-interp
 '(module
    (define L.fun/any8685.4 (lambda () (void)))
    (define L.fun/pair8681.5 (lambda () (call cons 107 388)))
    (define L.fun/error8683.6 (lambda () (error 83)))
    (define L.fun/pair8684.7 (lambda () (call cons 117 322)))
    (define L.fun/error8682.8 (lambda () (error 202)))
    (call
     void?
     (let ((pair0.4 (call L.fun/pair8681.5))
           (error1.3 (call L.fun/error8682.8))
           (error2.2 (call L.fun/error8683.6))
           (pair3.1 (call L.fun/pair8684.7)))
       (call L.fun/any8685.4)))))
(check-by-interp
 '(module
    (define L.fun/vector8727.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) oprand0.3))
    (define L.fun/pair8726.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) (call cons 53 468)))
    (define L.fun/ascii-char8723.6 (lambda () #\_))
    (define L.fun/ascii-char8722.7
      (lambda (oprand0.9 oprand1.8 oprand2.7) (call L.fun/ascii-char8723.6)))
    (define L.fun/vector8725.8
      (lambda (oprand0.12 oprand1.11 oprand2.10) (call make-vector 8)))
    (define L.fun/void8724.9
      (lambda (oprand0.15 oprand1.14 oprand2.13) oprand2.13))
    (define L.fun/error8728.10
      (lambda (oprand0.18 oprand1.17 oprand2.16) (error 94)))
    (call
     L.fun/ascii-char8722.7
     (call
      L.fun/void8724.9
      (call
       L.fun/vector8725.8
       (call L.fun/void8724.9 (call make-vector 8) (call cons 6 444) (void))
       (call error? #t)
       (let ((void0.22 (void))
             (vector1.21 (call make-vector 8))
             (empty2.20 empty)
             (empty3.19 empty))
         #f))
      (call
       L.fun/pair8726.5
       (call L.fun/vector8727.4 (call make-vector 8) (void) (void))
       (let ((fixnum0.26 174)
             (boolean1.25 #t)
             (fixnum2.24 173)
             (void3.23 (void)))
         empty)
       (let ((vector0.30 (call make-vector 8))
             (ascii-char1.29 #\N)
             (vector2.28 (call make-vector 8))
             (fixnum3.27 164))
         (call cons 219 458)))
      (let ((fixnum0.34 46)
            (empty1.33 empty)
            (void2.32 (void))
            (fixnum3.31 252))
        (void)))
     (if (let ((fixnum0.38 20)
               (vector1.37 (call make-vector 8))
               (boolean2.36 #f)
               (error3.35 (error 230)))
           #f)
       (if #f #f #t)
       (let ((boolean0.42 #f)
             (void1.41 (void))
             (pair2.40 (call cons 216 369))
             (void3.39 (void)))
         #t))
     (if (let ((fixnum0.46 103)
               (error1.45 (error 39))
               (pair2.44 (call cons 36 507))
               (boolean3.43 #f))
           #t)
       (let ((vector0.50 (call make-vector 8))
             (pair1.49 (call cons 219 357))
             (ascii-char2.48 #\\)
             (pair3.47 (call cons 1 378)))
         (error 88))
       (call L.fun/error8728.10 (void) (error 105) empty)))))
(check-by-interp
 '(module
    (define L.fun/pair8731.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) (call L.fun/pair8732.10)))
    (define L.fun/empty8739.5 (lambda () empty))
    (define L.fun/error8738.6 (lambda () (error 148)))
    (define L.fun/ascii-char8737.7 (lambda () #\=))
    (define L.fun/void8740.8 (lambda () (void)))
    (define L.fun/ascii-char8741.9 (lambda () #\b))
    (define L.fun/pair8732.10 (lambda () (call cons 254 455)))
    (define L.fun/error8736.11 (lambda () (error 199)))
    (define L.fun/boolean8733.12 (lambda (oprand0.6 oprand1.5 oprand2.4) #t))
    (define L.fun/boolean8734.13 (lambda (oprand0.9 oprand1.8 oprand2.7) #f))
    (define L.fun/empty8735.14 (lambda () empty))
    (call
     L.fun/pair8731.4
     (if (call L.fun/boolean8733.12 #\W (error 33) empty)
       (call L.fun/boolean8734.13 (call cons 11 443) (error 97) empty)
       (call boolean? (call make-vector 8)))
     (let ((empty0.13 (call L.fun/empty8735.14))
           (error1.12 (call L.fun/error8736.11))
           (ascii-char2.11 (call L.fun/ascii-char8737.7))
           (error3.10 (call L.fun/error8738.6)))
       error3.10)
     (let ((empty0.17 (call L.fun/empty8739.5))
           (fixnum1.16 (call * 40 187))
           (void2.15 (call L.fun/void8740.8))
           (ascii-char3.14 (call L.fun/ascii-char8741.9)))
       (call vector? #\P)))))
(check-by-interp
 '(module
    (define L.fun/void8752.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) oprand1.2))
    (define L.fun/empty8754.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) oprand2.4))
    (define L.fun/void8766.6
      (lambda (oprand0.9 oprand1.8 oprand2.7)
        (call vector-set! oprand2.7 7 empty)))
    (define L.fun/empty8759.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) empty))
    (define L.fun/pair8765.8
      (lambda (oprand0.15 oprand1.14 oprand2.13) (call cons 245 451)))
    (define L.fun/vector8767.9
      (lambda (oprand0.18 oprand1.17 oprand2.16) (call make-vector 8)))
    (define L.fun/ascii-char8757.10
      (lambda (oprand0.21 oprand1.20 oprand2.19) oprand2.19))
    (define L.fun/error8748.11
      (lambda (oprand0.24 oprand1.23 oprand2.22) (call L.fun/error8749.19)))
    (define L.fun/ascii-char8770.12
      (lambda (oprand0.27 oprand1.26 oprand2.25) #\_))
    (define L.fun/pair8762.13
      (lambda (oprand0.30 oprand1.29 oprand2.28) (call cons 156 501)))
    (define L.fun/vector8753.14
      (lambda (oprand0.33 oprand1.32 oprand2.31) (call make-vector 8)))
    (define L.fun/boolean8768.15
      (lambda (oprand0.36 oprand1.35 oprand2.34) #t))
    (define L.fun/empty8763.16
      (lambda (oprand0.39 oprand1.38 oprand2.37) empty))
    (define L.fun/void8750.17
      (lambda (oprand0.42 oprand1.41 oprand2.40) oprand2.40))
    (define L.fun/fixnum8761.18
      (lambda (oprand0.45 oprand1.44 oprand2.43) (call * 81 29)))
    (define L.fun/error8749.19 (lambda () (error 243)))
    (define L.fun/pair8760.20
      (lambda (oprand0.48 oprand1.47 oprand2.46) (call cons 136 288)))
    (define L.fun/pair8751.21
      (lambda (oprand0.51 oprand1.50 oprand2.49) (call cons 219 356)))
    (define L.fun/empty8764.22
      (lambda (oprand0.54 oprand1.53 oprand2.52) empty))
    (define L.fun/empty8755.23
      (lambda (oprand0.57 oprand1.56 oprand2.55) empty))
    (define L.fun/ascii-char8758.24
      (lambda (oprand0.60 oprand1.59 oprand2.58) #\H))
    (define L.fun/empty8769.25
      (lambda (oprand0.63 oprand1.62 oprand2.61) empty))
    (define L.fun/empty8756.26
      (lambda (oprand0.66 oprand1.65 oprand2.64) empty))
    (call
     L.fun/error8748.11
     (call
      L.fun/void8750.17
      (if #t 152 207)
      (call L.fun/pair8751.21 (if #t #\O #\3) (if #f #\" #\;) (if #t #\O #\G))
      (call
       L.fun/void8752.4
       (call L.fun/vector8753.14 #f 194 (error 11))
       (let ((error0.70 (error 112))
             (ascii-char1.69 #\!)
             (boolean2.68 #t)
             (vector3.67 (call make-vector 8)))
         (call vector-set! vector3.67 7 empty))
       (if #t empty empty)))
     (call
      L.fun/empty8754.5
      (call
       L.fun/empty8755.23
       (if #t (void) (void))
       (let ((error0.74 (error 172))
             (error1.73 (error 193))
             (empty2.72 empty)
             (fixnum3.71 205))
         (call cons 107 467))
       (let ((boolean0.78 #t)
             (pair1.77 (call cons 48 370))
             (fixnum2.76 93)
             (error3.75 (error 183)))
         error3.75))
      (call
       L.fun/empty8756.26
       (call
        L.fun/ascii-char8757.10
        (call cons 185 397)
        (call cons 48 359)
        #\})
       (call L.fun/ascii-char8758.24 (error 141) empty (call make-vector 8))
       (if #f #f #t))
      (call
       L.fun/empty8759.7
       (if #t 213 75)
       (call L.fun/pair8760.20 (void) #f (void))
       (let ((error0.82 (error 233))
             (fixnum1.81 70)
             (boolean2.80 #t)
             (error3.79 (error 241)))
         fixnum1.81)))
     (call
      L.fun/fixnum8761.18
      (call
       L.fun/pair8762.13
       (call L.fun/empty8763.16 (call make-vector 8) (void) #f)
       (call L.fun/empty8764.22 26 (call make-vector 8) 103)
       (call L.fun/pair8765.8 (call cons 163 498) 250 (call cons 19 500)))
      (call
       L.fun/void8766.6
       (if #f (call cons 11 468) (call cons 60 391))
       (let ((fixnum0.86 134)
             (boolean1.85 #f)
             (pair2.84 (call cons 197 279))
             (error3.83 (error 89)))
         pair2.84)
       (call L.fun/vector8767.9 (void) (void) (call make-vector 8)))
      (call
       L.fun/boolean8768.15
       (call + 27 226)
       (call L.fun/empty8769.25 (call cons 56 338) 52 (error 241))
       (call L.fun/ascii-char8770.12 136 #\R (call make-vector 8)))))))
(check-by-interp
 '(module
    (define L.fun/fixnum8779.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) (call + 87 166)))
    (define L.fun/pair8777.5 (lambda () (call cons 97 316)))
    (define L.fun/vector8775.6 (lambda () (call make-vector 8)))
    (define L.fun/empty8773.7
      (lambda (oprand0.6 oprand1.5 oprand2.4) (call L.fun/empty8774.11)))
    (define L.fun/error8780.8
      (lambda (oprand0.9 oprand1.8 oprand2.7) (error 75)))
    (define L.fun/void8778.9 (lambda () (void)))
    (define L.fun/error8776.10 (lambda () (error 51)))
    (define L.fun/empty8774.11 (lambda () empty))
    (define L.fun/boolean8781.12
      (lambda (oprand0.12 oprand1.11 oprand2.10) oprand2.10))
    (call
     L.fun/empty8773.7
     (let ((vector0.16 (call L.fun/vector8775.6))
           (error1.15 (call L.fun/error8776.10))
           (pair2.14 (call L.fun/pair8777.5))
           (void3.13 (call L.fun/void8778.9)))
       error1.15)
     (call
      L.fun/fixnum8779.4
      (call
       L.fun/error8780.8
       (let ((vector0.20 (call make-vector 8))
             (empty1.19 empty)
             (void2.18 (void))
             (boolean3.17 #f))
         253)
       (if #f (void) (void))
       (let ((ascii-char0.24 #\Z)
             (error1.23 (error 167))
             (error2.22 (error 74))
             (boolean3.21 #t))
         #\e))
      (call pair? (if #t (call cons 140 323) #\Y))
      (let ((empty0.28 empty)
            (fixnum1.27 131)
            (empty2.26 empty)
            (void3.25 (void)))
        (void)))
     (if (call L.fun/boolean8781.12 (void) (call make-vector 8) #f)
       (call - 125 196)
       (if #t 6 128)))))
(check-by-interp
 '(module
    (define L.fun/vector8785.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char8784.5 (lambda () #\w))
    (define L.fun/vector8786.6 (lambda () (call make-vector 8)))
    (let ((ascii-char0.4 (call L.fun/ascii-char8784.5))
          (fixnum1.3 (call + (call * 57 163) (call + 239 187)))
          (vector2.2 (call L.fun/vector8785.4))
          (vector3.1 (call L.fun/vector8786.6)))
      vector3.1)))
(check-by-interp
 '(module
    (define L.fun/error8791.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) oprand1.2))
    (define L.fun/pair8793.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) (call cons 92 501)))
    (define L.fun/fixnum8794.6 (lambda (oprand0.9 oprand1.8 oprand2.7) 94))
    (define L.fun/fixnum8790.7 (lambda (oprand0.12 oprand1.11 oprand2.10) 20))
    (define L.fun/error8792.8
      (lambda (oprand0.15 oprand1.14 oprand2.13) (error 226)))
    (define L.fun/pair8789.9
      (lambda (oprand0.18 oprand1.17 oprand2.16) oprand2.16))
    (define L.fun/vector8795.10
      (lambda (oprand0.21 oprand1.20 oprand2.19) (call make-vector 8)))
    (call
     L.fun/pair8789.9
     (if (let ((empty0.25 empty)
               (ascii-char1.24 #\F)
               (fixnum2.23 213)
               (boolean3.22 #f))
           boolean3.22)
       (call
        L.fun/fixnum8790.7
        (error 224)
        (call cons 60 503)
        (call cons 140 491))
       (let ((empty0.29 empty)
             (ascii-char1.28 #\Y)
             (ascii-char2.27 #\V)
             (empty3.26 empty))
         130))
     (call
      L.fun/error8791.4
      (if #t 188 113)
      (if #t (error 50) (error 91))
      (if #t (call cons 230 474) (call cons 214 311)))
     (call
      L.fun/pair8789.9
      (let ((fixnum0.33 243)
            (error1.32 (error 91))
            (error2.31 (error 54))
            (fixnum3.30 164))
        fixnum3.30)
      (call
       L.fun/error8792.8
       (if #t #f #f)
       (let ((fixnum0.37 94)
             (boolean1.36 #t)
             (vector2.35 (call make-vector 8))
             (error3.34 (error 70)))
         #\O)
       (if #f (call cons 133 277) (call cons 254 499)))
      (call
       L.fun/pair8793.5
       (call
        L.fun/fixnum8794.6
        (error 90)
        (call make-vector 8)
        (call cons 110 470))
       (if #t 75 237)
       (call L.fun/vector8795.10 #f empty (error 194)))))))
(check-by-interp
 '(module
    (define L.fun/boolean7231.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) #t))
    (define L.fun/ascii-char7242.5
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) #\\))
    (define L.fun/vector7234.6
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) oprand1.11))
    (define L.fun/void7243.7
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13)
        (call vector-set! oprand0.16 7 #f)))
    (define L.fun/void7237.8
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17)
        (call vector-set! oprand0.20 7 (error 76))))
    (define L.fun/pair7236.9
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21) oprand0.24))
    (define L.fun/vector7239.10
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25)
        (call make-vector 8)))
    (define L.fun/empty7235.11
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29) empty))
    (define L.fun/fixnum7238.12
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33) (call + 43 140)))
    (define L.fun/fixnum7232.13
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37)
        (call * oprand0.40 oprand3.37)))
    (define L.fun/error7233.14
      (lambda (oprand0.44 oprand1.43 oprand2.42 oprand3.41) (error 104)))
    (define L.fun/error7244.15
      (lambda (oprand0.48 oprand1.47 oprand2.46 oprand3.45) (error 179)))
    (define L.fun/empty7240.16
      (lambda (oprand0.52 oprand1.51 oprand2.50 oprand3.49) empty))
    (define L.fun/void7241.17
      (lambda (oprand0.56 oprand1.55 oprand2.54 oprand3.53) oprand3.53))
    (if (if (call L.fun/boolean7231.4 (void) (void) (void) empty)
          (let ((error0.61 (error 252))
                (fixnum1.60 238)
                (vector2.59 (call make-vector 8))
                (error3.58 (error 143))
                (pair4.57 (call cons 224 269)))
            #f)
          (call fixnum? #t))
      (call
       L.fun/fixnum7232.13
       (if #t 97 107)
       (call
        L.fun/error7233.14
        (call
         L.fun/vector7234.6
         (call cons 18 266)
         (call make-vector 8)
         243
         empty)
        (let ((pair0.66 (call cons 72 470))
              (error1.65 (error 19))
              (fixnum2.64 49)
              (empty3.63 empty)
              (fixnum4.62 101))
          (call make-vector 8))
        (call L.fun/empty7235.11 (error 86) #\h #\H #\U)
        (let ((empty0.71 empty)
              (pair1.70 (call cons 42 368))
              (vector2.69 (call make-vector 8))
              (fixnum3.68 133)
              (error4.67 (error 251)))
          (call vector-set! vector2.69 7 fixnum3.68)))
       (call
        L.fun/pair7236.9
        (let ((boolean0.76 #f)
              (error1.75 (error 182))
              (ascii-char2.74 #\P)
              (boolean3.73 #f)
              (void4.72 (void)))
          (call cons 248 404))
        (call L.fun/void7237.8 (call make-vector 8) #t (void) 97)
        (let ((error0.81 (error 212))
              (fixnum1.80 66)
              (pair2.79 (call cons 117 382))
              (pair3.78 (call cons 47 495))
              (empty4.77 empty))
          empty)
        (let ((empty0.86 empty)
              (pair1.85 (call cons 46 500))
              (empty2.84 empty)
              (fixnum3.83 39)
              (pair4.82 (call cons 14 503)))
          #\C))
       (if #t 32 47))
      (call
       L.fun/fixnum7238.12
       (let ((error0.91 (error 209))
             (pair1.90 (call cons 10 273))
             (fixnum2.89 160)
             (void3.88 (void))
             (boolean4.87 #f))
         boolean4.87)
       (let ((pair0.96 (call cons 253 421))
             (vector1.95 (call make-vector 8))
             (void2.94 (void))
             (error3.93 (error 138))
             (vector4.92 (call make-vector 8)))
         #\`)
       (call
        L.fun/vector7239.10
        (if #t 249 106)
        (call L.fun/empty7240.16 #f (call make-vector 8) 92 #t)
        (call
         L.fun/void7241.17
         #t
         (call make-vector 8)
         (call make-vector 8)
         (void))
        (if #f (call make-vector 8) (call make-vector 8)))
       (call
        L.fun/ascii-char7242.5
        (if #f (void) (void))
        (call L.fun/void7243.7 (call make-vector 8) empty 169 (error 189))
        (call L.fun/error7244.15 empty (error 34) (error 89) (error 239))
        (call pair? (void)))))))
(check-by-interp
 '(module
    (define L.fun/empty8464.4 (lambda () empty))
    (define L.fun/ascii-char8469.5
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) oprand1.3))
    (define L.fun/pair8466.6
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) (call cons 214 379)))
    (define L.fun/empty8471.7
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) empty))
    (define L.fun/empty8463.8
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13)
        (call L.fun/empty8464.4)))
    (define L.fun/vector8465.9
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17)
        (call make-vector 8)))
    (define L.fun/empty8470.10
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21) empty))
    (define L.fun/error8468.11
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25) (error 243)))
    (define L.fun/vector8467.12
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29)
        (call make-vector 8)))
    (if (call boolean? (if #t empty (error 54)))
      (call
       L.fun/empty8463.8
       (call
        L.fun/vector8465.9
        (let ((void0.37 (void))
              (fixnum1.36 254)
              (pair2.35 (call cons 249 471))
              (ascii-char3.34 #\u)
              (empty4.33 empty))
          empty)
        (let ((vector0.42 (call make-vector 8))
              (empty1.41 empty)
              (ascii-char2.40 #\m)
              (void3.39 (void))
              (pair4.38 (call cons 69 412)))
          189)
        (call L.fun/pair8466.6 #t empty (call cons 173 340) (void))
        (call L.fun/vector8467.12 (error 195) (error 182) empty 17))
       (if #t 118 221)
       (call
        L.fun/error8468.11
        (call L.fun/ascii-char8469.5 (void) #\s #f (call make-vector 8))
        (call L.fun/empty8470.10 223 #\v (void) (error 87))
        (if #t (void) (void))
        (if #t (void) (void)))
       (if #f 112 126))
      (if (let ((fixnum0.47 140)
                (fixnum1.46 222)
                (void2.45 (void))
                (ascii-char3.44 #\o)
                (void4.43 (void)))
            #t)
        (if #t empty empty)
        (call L.fun/empty8471.7 (error 249) (call cons 242 497) empty #\x)))))
(check-by-interp
 '(module
    (define L.fun/vector8495.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) (call make-vector 8)))
    (define L.fun/error8500.5
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) (error 113)))
    (define L.fun/boolean8493.6
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) (call pair? 137)))
    (define L.fun/pair8501.7
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13)
        (call cons 182 505)))
    (define L.fun/fixnum8499.8
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17) oprand3.17))
    (define L.fun/void8497.9
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21) (void)))
    (define L.fun/error8496.10
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25) (error 185)))
    (define L.fun/fixnum8498.11
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29) oprand3.29))
    (define L.fun/vector8494.12
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33)
        (call make-vector 8)))
    (if (call
         L.fun/boolean8493.6
         (call
          boolean?
          (let ((ascii-char0.41 #\W)
                (fixnum1.40 187)
                (ascii-char2.39 #\\)
                (boolean3.38 #f)
                (empty4.37 empty))
            (void)))
         (call
          L.fun/vector8494.12
          (let ((ascii-char0.46 #\H)
                (error1.45 (error 161))
                (error2.44 (error 1))
                (vector3.43 (call make-vector 8))
                (vector4.42 (call make-vector 8)))
            (call cons 183 343))
          (if #f (void) (void))
          (if #t (call make-vector 8) (call make-vector 8))
          (call L.fun/vector8495.4 #t empty (void) #\[))
         (call
          L.fun/error8496.10
          (call L.fun/void8497.9 (void) empty (void) #\J)
          (if #f (void) (void))
          (let ((error0.51 (error 56))
                (error1.50 (error 210))
                (void2.49 (void))
                (error3.48 (error 15))
                (boolean4.47 #t))
            (call make-vector 8))
          (call void? #\O))
         (if #f empty empty))
      (call
       *
       (let ((vector0.56 (call make-vector 8))
             (fixnum1.55 244)
             (void2.54 (void))
             (vector3.53 (call make-vector 8))
             (pair4.52 (call cons 33 409)))
         fixnum1.55)
       (let ((error0.61 (error 195))
             (error1.60 (error 170))
             (boolean2.59 #t)
             (vector3.58 (call make-vector 8))
             (fixnum4.57 91))
         35))
      (call
       *
       (call
        +
        (call * 15 131)
        (call L.fun/fixnum8498.11 #\Y empty (call cons 241 380) 96))
       (call
        L.fun/fixnum8499.8
        (call L.fun/error8500.5 (error 226) (void) (call cons 53 475) 206)
        (call L.fun/pair8501.7 (error 66) (call make-vector 8) #\T empty)
        (call - 134 231)
        (call L.fun/fixnum8499.8 (error 101) (call cons 159 374) 133 20))))))
(check-by-interp
 '(module
    (define L.fun/pair8615.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) (call cons 97 472)))
    (define L.fun/void8613.5
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) oprand3.5))
    (define L.fun/fixnum8605.6
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) 112))
    (define L.fun/fixnum8610.7
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13) (call - 248 209)))
    (define L.fun/pair8606.8
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17)
        (call cons 101 360)))
    (define L.fun/pair8602.9
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21)
        (call cons 124 492)))
    (define L.fun/error8608.10
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25) (error 40)))
    (define L.fun/pair8612.11
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29) oprand2.30))
    (define L.fun/empty8603.12
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33) oprand0.36))
    (define L.fun/ascii-char8616.13
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37) oprand3.37))
    (define L.fun/void8611.14
      (lambda (oprand0.44 oprand1.43 oprand2.42 oprand3.41) oprand2.42))
    (define L.fun/fixnum8600.15
      (lambda (oprand0.48 oprand1.47 oprand2.46 oprand3.45) (call * 147 7)))
    (define L.fun/error8604.16
      (lambda (oprand0.52 oprand1.51 oprand2.50 oprand3.49) (error 62)))
    (define L.fun/empty8609.17 (lambda () empty))
    (define L.fun/error8607.18
      (lambda (oprand0.56 oprand1.55 oprand2.54 oprand3.53) (error 245)))
    (define L.fun/error8614.19
      (lambda (oprand0.60 oprand1.59 oprand2.58 oprand3.57) (error 173)))
    (define L.fun/void8617.20
      (lambda (oprand0.64 oprand1.63 oprand2.62 oprand3.61) (void)))
    (define L.fun/error8601.21
      (lambda (oprand0.68 oprand1.67 oprand2.66 oprand3.65) (error 178)))
    (call
     +
     (call
      +
      (call
       L.fun/fixnum8600.15
       (let ((fixnum0.73 238)
             (fixnum1.72 231)
             (vector2.71 (call make-vector 8))
             (fixnum3.70 197)
             (vector4.69 (call make-vector 8)))
         #\D)
       (if #t empty empty)
       (call
        L.fun/error8601.21
        (call L.fun/pair8602.9 161 (call make-vector 8) #\q #f)
        (call L.fun/empty8603.12 empty (error 85) (call make-vector 8) #t)
        (call L.fun/error8604.16 #f (void) (call cons 56 311) #t)
        (call L.fun/fixnum8605.6 #t empty (error 89) empty))
       (call
        L.fun/pair8606.8
        (if #t 72 103)
        (call L.fun/error8607.18 #\w 236 (call cons 61 389) empty)
        (let ((error0.78 (error 53))
              (pair1.77 (call cons 65 412))
              (pair2.76 (call cons 217 484))
              (fixnum3.75 236)
              (pair4.74 (call cons 159 319)))
          #f)
        (call
         L.fun/error8608.10
         (call make-vector 8)
         empty
         (error 251)
         (void))))
      (let ((boolean0.83 (call void? (call make-vector 8)))
            (boolean1.82 (call ascii-char? (error 219)))
            (fixnum2.81 (call + 64 197))
            (fixnum3.80 (call + 111 145))
            (empty4.79 (call L.fun/empty8609.17)))
        (call + fixnum2.81 fixnum3.80)))
     (call
      +
      (call
       L.fun/fixnum8610.7
       (let ((fixnum0.88 181)
             (ascii-char1.87 #\n)
             (void2.86 (void))
             (vector3.85 (call make-vector 8))
             (fixnum4.84 221))
         (call make-vector 8))
       (call
        L.fun/void8611.14
        (call
         L.fun/pair8612.11
         (call cons 210 488)
         (error 222)
         (call cons 210 373)
         (void))
        (let ((pair0.93 (call cons 169 291))
              (ascii-char1.92 #\f)
              (empty2.91 empty)
              (error3.90 (error 201))
              (fixnum4.89 229))
          error3.90)
        (if #t (void) (void))
        (if #f (error 149) (error 199)))
       (call
        L.fun/void8613.5
        (if #t 177 230)
        (let ((error0.98 (error 27))
              (pair1.97 (call cons 1 408))
              (void2.96 (void))
              (void3.95 (void))
              (fixnum4.94 53))
          empty)
        (call L.fun/error8614.19 (error 80) (void) (void) (call make-vector 8))
        (call L.fun/void8613.5 78 empty (error 221) (void)))
       (call
        L.fun/pair8615.4
        (call L.fun/ascii-char8616.13 (void) (void) 220 #\])
        (call L.fun/void8617.20 #\e (void) (void) #f)
        (call - 16 0)
        (let ((boolean0.103 #t)
              (empty1.102 empty)
              (error2.101 (error 112))
              (vector3.100 (call make-vector 8))
              (void4.99 (void)))
          (call make-vector 8))))
      (if (let ((vector0.108 (call make-vector 8))
                (ascii-char1.107 #\C)
                (pair2.106 (call cons 110 453))
                (vector3.105 (call make-vector 8))
                (boolean4.104 #t))
            boolean4.104)
        (if #t 221 128)
        (if #f 74 16))))))
(check-by-interp
 '(module
    (define L.fun/boolean8639.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) oprand3.1))
    (define L.fun/boolean8641.5
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) oprand3.5))
    (define L.fun/ascii-char8643.6
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) #\[))
    (define L.fun/boolean8640.7
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13) #t))
    (define L.fun/ascii-char8642.8
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17) oprand1.19))
    (if (if (call L.fun/boolean8639.4 empty (void) empty #t)
          (call ascii-char? empty)
          (call L.fun/boolean8640.7 (void) (void) #\d (call make-vector 8)))
      (if (call L.fun/boolean8641.5 empty #\p (call make-vector 8) #f)
        (if #f #\O #\i)
        (call L.fun/ascii-char8642.8 (error 80) #\L empty (error 111)))
      (if (if #f #t #f)
        (call L.fun/ascii-char8643.6 (call make-vector 8) 220 (error 199) #\G)
        (if #f #\h #\[)))))
(check-by-interp
 '(module
    (define L.fun/empty8786.4 (lambda () empty))
    (define L.fun/vector8781.5 (lambda () (call make-vector 8)))
    (define L.fun/pair8782.6 (lambda () (call cons 8 411)))
    (define L.fun/void8783.7 (lambda () (void)))
    (define L.fun/vector8784.8 (lambda () (call make-vector 8)))
    (define L.fun/pair8785.9 (lambda () (call cons 91 368)))
    (let ((vector0.5 (call L.fun/vector8781.5))
          (pair1.4 (call L.fun/pair8782.6))
          (void2.3 (call L.fun/void8783.7))
          (vector3.2 (call L.fun/vector8784.8))
          (pair4.1 (call L.fun/pair8785.9)))
      (call L.fun/empty8786.4))))
(check-by-interp
 '(module
    (define L.fun/void8885.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1)
        (call vector-set! oprand0.4 7 #t)))
    (define L.fun/error8886.5
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) (error 218)))
    (define L.fun/boolean8890.6
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) #f))
    (define L.fun/vector8884.7
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13)
        (call make-vector 8)))
    (define L.fun/boolean8879.8
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17)
        (call boolean? 32)))
    (define L.fun/error8883.9
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21) (error 193)))
    (define L.fun/pair8880.10
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25)
        (call cons 126 440)))
    (define L.fun/pair8887.11
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29)
        (call cons 113 374)))
    (define L.fun/empty8882.12
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33) empty))
    (define L.fun/void8889.13
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37)
        (call vector-set! oprand1.39 7 (error 25))))
    (define L.fun/boolean8888.14
      (lambda (oprand0.44 oprand1.43 oprand2.42 oprand3.41) #f))
    (define L.fun/empty8881.15
      (lambda (oprand0.48 oprand1.47 oprand2.46 oprand3.45) empty))
    (if (call
         L.fun/boolean8879.8
         (call
          L.fun/pair8880.10
          (let ((void0.53 (void))
                (ascii-char1.52 #\P)
                (error2.51 (error 27))
                (fixnum3.50 95)
                (vector4.49 (call make-vector 8)))
            vector4.49)
          (call L.fun/empty8881.15 #f 40 (void) (error 244))
          (call
           L.fun/pair8880.10
           (call make-vector 8)
           empty
           (call cons 157 306)
           empty)
          (call L.fun/empty8882.12 #t #t (void) #\H))
         (if #f 187 17)
         (if #t (error 184) (error 201))
         (let ((pair0.58 (call cons 251 290))
               (ascii-char1.57 #\b)
               (void2.56 (void))
               (fixnum3.55 134)
               (error4.54 (error 47)))
           empty))
      (call
       L.fun/error8883.9
       (call
        L.fun/vector8884.7
        (if #t (void) (void))
        (call L.fun/void8885.4 (call make-vector 8) 115 #t 168)
        (call L.fun/error8886.5 (void) #\d #\G #t)
        (let ((empty0.63 empty)
              (ascii-char1.62 #\F)
              (ascii-char2.61 #\U)
              (pair3.60 (call cons 0 419))
              (ascii-char4.59 #\j))
          #f))
       (call
        L.fun/pair8887.11
        (call + 129 97)
        (call L.fun/boolean8888.14 12 208 (call cons 114 300) (error 178))
        (call L.fun/void8889.13 #t (call make-vector 8) 215 (call cons 80 364))
        (if #f (call make-vector 8) (call make-vector 8)))
       (let ((boolean0.68 #f)
             (vector1.67 (call make-vector 8))
             (pair2.66 (call cons 152 285))
             (boolean3.65 #t)
             (empty4.64 empty))
         empty)
       (call
        +
        (let ((ascii-char0.73 #\b)
              (empty1.72 empty)
              (empty2.71 empty)
              (error3.70 (error 139))
              (void4.69 (void)))
          129)
        (if #t 238 27)))
      (if (call L.fun/boolean8890.6 #\r 123 empty (error 83))
        (let ((vector0.78 (call make-vector 8))
              (void1.77 (void))
              (vector2.76 (call make-vector 8))
              (vector3.75 (call make-vector 8))
              (empty4.74 empty))
          (error 64))
        (let ((void0.83 (void))
              (ascii-char1.82 #\r)
              (error2.81 (error 193))
              (vector3.80 (call make-vector 8))
              (empty4.79 empty))
          (error 164))))))
(check-by-interp
 '(module
    (define L.fun/empty8893.4 (lambda () empty))
    (define L.fun/empty8894.5 (lambda () empty))
    (define L.fun/pair8895.6 (lambda () (call cons 145 293)))
    (define L.fun/void8896.7 (lambda () (void)))
    (let ((empty0.5 (call L.fun/empty8893.4))
          (empty1.4 (call L.fun/empty8894.5))
          (fixnum2.3
           (call
            -
            (call * (call * 204 25) (call * 40 113))
            (call - (call - 89 40) (call + 112 116))))
          (pair3.2 (call L.fun/pair8895.6))
          (void4.1 (call L.fun/void8896.7)))
      pair3.2)))
(check-by-interp
 '(module
    (define L.fun/ascii-char8900.4 (lambda () #\F))
    (define L.fun/any8902.5 (lambda () (call make-vector 8)))
    (define L.fun/empty8899.6 (lambda () empty))
    (define L.fun/vector8901.7 (lambda () (call make-vector 8)))
    (define L.fun/void8903.8 (lambda () (void)))
    (let ((empty0.5 (call L.fun/empty8899.6))
          (ascii-char1.4 (call L.fun/ascii-char8900.4))
          (vector2.3 (call L.fun/vector8901.7))
          (boolean3.2 (call vector? (call L.fun/any8902.5)))
          (void4.1 (call L.fun/void8903.8)))
      empty0.5)))
(check-by-interp
 '(module
    (define L.fun/empty8907.4 (lambda () empty))
    (define L.fun/error8906.5 (lambda () (error 71)))
    (define L.fun/pair8908.6 (lambda () (call cons 170 380)))
    (define L.fun/void8909.7 (lambda () (void)))
    (let ((fixnum0.5
           (call
            -
            (call * (call + 108 195) (call - 204 229))
            (call * (call + 51 51) (call + 146 11))))
          (error1.4 (call L.fun/error8906.5))
          (fixnum2.3
           (call
            +
            (call * (call + 219 64) (call - 216 174))
            (call - (call * 17 70) (call - 22 123))))
          (empty3.2 (call L.fun/empty8907.4))
          (pair4.1 (call L.fun/pair8908.6)))
      (call L.fun/void8909.7))))
(check-by-interp
 '(module
    (define L.fun/vector8912.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1)
        (call L.fun/vector8913.19)))
    (define L.fun/empty8926.5
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) oprand1.7))
    (define L.fun/void8920.6 (lambda () (void)))
    (define L.fun/ascii-char8922.7 (lambda () #\n))
    (define L.fun/empty8921.8 (lambda () empty))
    (define L.fun/ascii-char8927.9
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) #\K))
    (define L.fun/fixnum8932.10
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13) 241))
    (define L.fun/fixnum8917.11
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17) 128))
    (define L.fun/pair8923.12
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21)
        (call L.fun/pair8924.20)))
    (define L.fun/boolean8914.13
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25) #t))
    (define L.fun/pair8931.14
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29)
        (call cons 165 405)))
    (define L.fun/ascii-char8915.15
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33) oprand1.35))
    (define L.fun/void8930.16
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37) (void)))
    (define L.fun/void8918.17
      (lambda (oprand0.44 oprand1.43 oprand2.42 oprand3.41) (void)))
    (define L.fun/pair8928.18
      (lambda (oprand0.48 oprand1.47 oprand2.46 oprand3.45)
        (call cons 114 343)))
    (define L.fun/vector8913.19 (lambda () (call make-vector 8)))
    (define L.fun/pair8924.20 (lambda () (call cons 70 334)))
    (define L.fun/fixnum8929.21
      (lambda (oprand0.52 oprand1.51 oprand2.50 oprand3.49) 164))
    (define L.fun/error8925.22
      (lambda (oprand0.56 oprand1.55 oprand2.54 oprand3.53) (error 233)))
    (define L.fun/void8919.23
      (lambda (oprand0.60 oprand1.59 oprand2.58 oprand3.57)
        (call L.fun/void8920.6)))
    (define L.fun/boolean8916.24
      (lambda (oprand0.64 oprand1.63 oprand2.62 oprand3.61) #f))
    (define L.fun/any8933.25
      (lambda (oprand0.68 oprand1.67 oprand2.66 oprand3.65) empty))
    (call
     L.fun/vector8912.4
     (if (call error? (if #t (error 242) #f))
       (let ((fixnum0.73 191)
             (error1.72 (error 88))
             (error2.71 (error 5))
             (pair3.70 (call cons 91 259))
             (empty4.69 empty))
         #t)
       (call
        L.fun/boolean8914.13
        (let ((error0.78 (error 116))
              (error1.77 (error 235))
              (error2.76 (error 35))
              (boolean3.75 #f)
              (void4.74 (void)))
          (error 15))
        (let ((fixnum0.83 41)
              (ascii-char1.82 #\L)
              (ascii-char2.81 #\l)
              (pair3.80 (call cons 40 343))
              (ascii-char4.79 #\Y))
          #\a)
        (if #t (error 22) (error 20))
        (call
         L.fun/ascii-char8915.15
         (error 204)
         #\N
         (error 218)
         (call make-vector 8))))
     (if (call
          L.fun/boolean8916.24
          (let ((empty0.88 empty)
                (ascii-char1.87 #\o)
                (vector2.86 (call make-vector 8))
                (void3.85 (void))
                (fixnum4.84 66))
            (call cons 115 358))
          (call
           L.fun/fixnum8917.11
           (call make-vector 8)
           (call make-vector 8)
           (call make-vector 8)
           (error 81))
          (call L.fun/vector8912.4 #f (call cons 224 319) (void) #f)
          (call L.fun/void8918.17 #t (void) (error 115) empty))
       (let ((fixnum0.93 216)
             (fixnum1.92 115)
             (void2.91 (void))
             (ascii-char3.90 #\a)
             (boolean4.89 #t))
         (call cons 99 256))
       (if #t (call cons 38 330) (call cons 89 266)))
     (call
      L.fun/void8919.23
      (let ((empty0.98 (call L.fun/empty8921.8))
            (fixnum1.97 (call - 188 3))
            (vector2.96
             (call L.fun/vector8912.4 #t (call cons 236 406) (void) #t))
            (fixnum3.95 (call - 219 112))
            (ascii-char4.94 (call L.fun/ascii-char8922.7)))
        (call empty? empty))
      (call
       L.fun/pair8923.12
       (if #t #t #f)
       (call
        -
        (if #t 96 249)
        (let ((void0.103 (void))
              (vector1.102 (call make-vector 8))
              (empty2.101 empty)
              (empty3.100 empty)
              (fixnum4.99 143))
          235))
       (let ((vector0.108 (call make-vector 8))
             (error1.107 (error 54))
             (fixnum2.106 94)
             (void3.105 (void))
             (fixnum4.104 129))
         vector0.108)
       (if #f (error 82) (error 120)))
      (call
       L.fun/error8925.22
       (call
        L.fun/empty8926.5
        (call L.fun/ascii-char8927.9 empty #t empty #f)
        (let ((error0.113 (error 242))
              (error1.112 (error 248))
              (boolean2.111 #f)
              (vector3.110 (call make-vector 8))
              (void4.109 (void)))
          empty)
        (call L.fun/pair8928.18 (error 106) (call make-vector 8) #\O empty)
        (call L.fun/fixnum8929.21 empty empty #\e (error 147)))
       (let ((void0.118 (void))
             (error1.117 (error 86))
             (ascii-char2.116 #\F)
             (boolean3.115 #t)
             (pair4.114 (call cons 121 337)))
         #\W)
       (call
        L.fun/void8930.16
        (let ((error0.123 (error 55))
              (error1.122 (error 90))
              (void2.121 (void))
              (boolean3.120 #f)
              (pair4.119 (call cons 74 499)))
          #\H)
        (call
         L.fun/pair8931.14
         (call cons 192 342)
         (call make-vector 8)
         (void)
         #\J)
        (if #t #t #f)
        (call * 193 20))
       (let ((fixnum0.128 186)
             (boolean1.127 #f)
             (vector2.126 (call make-vector 8))
             (boolean3.125 #t)
             (ascii-char4.124 #\m))
         empty))
      (call
       -
       (call
        -
        (call
         L.fun/fixnum8932.10
         (error 68)
         (call cons 189 267)
         (error 162)
         (error 231))
        (let ((ascii-char0.133 #\c)
              (boolean1.132 #f)
              (boolean2.131 #t)
              (empty3.130 empty)
              (vector4.129 (call make-vector 8)))
          125))
       (let ((vector0.138 (call make-vector 8))
             (ascii-char1.137 #\r)
             (ascii-char2.136 #\W)
             (boolean3.135 #f)
             (empty4.134 empty))
         53)))
     (call
      boolean?
      (call
       L.fun/any8933.25
       (if #t (error 63) (error 231))
       (let ((boolean0.143 #t)
             (boolean1.142 #f)
             (fixnum2.141 136)
             (error3.140 (error 233))
             (fixnum4.139 188))
         (void))
       (if #t empty empty)
       (call
        L.fun/vector8912.4
        (let ((boolean0.148 #t)
              (error1.147 (error 242))
              (void2.146 (void))
              (empty3.145 empty)
              (error4.144 (error 234)))
          boolean0.148)
        (if #f (call cons 52 452) (call cons 129 391))
        (if #t (void) (void))
        (if #t #t #f)))))))
(check-by-interp
 '(module
    (define L.fun/void8946.4 (lambda () (void)))
    (define L.fun/pair8943.5 (lambda () (call cons 114 286)))
    (define L.fun/vector8945.6 (lambda () (call make-vector 8)))
    (define L.fun/boolean8941.7
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) #f))
    (define L.fun/error8944.8 (lambda () (error 117)))
    (define L.fun/error8939.9 (lambda () (error 99)))
    (define L.fun/void8938.10 (lambda () (void)))
    (define L.fun/void8937.11 (lambda () (void)))
    (define L.fun/ascii-char8940.12 (lambda () #\b))
    (define L.fun/fixnum8942.13
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) 220))
    (define L.fun/error8936.14 (lambda () (error 177)))
    (call
     *
     (call
      -
      (let ((error0.13 (call L.fun/error8936.14))
            (void1.12 (call L.fun/void8937.11))
            (void2.11 (call L.fun/void8938.10))
            (error3.10 (call L.fun/error8939.9))
            (ascii-char4.9 (call L.fun/ascii-char8940.12)))
        (call * 183 226))
      (if (call
           L.fun/boolean8941.7
           (call cons 181 311)
           (call make-vector 8)
           (call make-vector 8)
           (call cons 227 288))
        (call L.fun/fixnum8942.13 212 (error 166) (call make-vector 8) #\W)
        (let ((void0.18 (void))
              (pair1.17 (call cons 23 387))
              (error2.16 (error 177))
              (vector3.15 (call make-vector 8))
              (ascii-char4.14 #\E))
          240)))
     (let ((pair0.23 (call L.fun/pair8943.5))
           (error1.22 (call L.fun/error8944.8))
           (fixnum2.21 (call - (call - 87 49) (call + 41 89)))
           (vector3.20 (call L.fun/vector8945.6))
           (void4.19 (call L.fun/void8946.4)))
       (call cdr pair0.23)))))
(check-by-interp
 '(module
    (define L.fun/empty9018.4 (lambda () empty))
    (define L.fun/vector9016.5 (lambda () (call make-vector 8)))
    (define L.fun/void9017.6 (lambda () (void)))
    (define L.fun/error9015.7 (lambda () (error 30)))
    (define L.fun/ascii-char9020.8 (lambda () #\e))
    (define L.fun/error9019.9 (lambda () (error 248)))
    (define L.fun/ascii-char9021.10
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) oprand1.3))
    (if (if (let ((error0.9 (error 150))
                  (boolean1.8 #f)
                  (boolean2.7 #f)
                  (ascii-char3.6 #\r)
                  (empty4.5 empty))
              #f)
          (if #f #t #f)
          (call void? empty))
      (let ((error0.14 (call L.fun/error9015.7))
            (vector1.13 (call L.fun/vector9016.5))
            (void2.12 (call L.fun/void9017.6))
            (empty3.11 (call L.fun/empty9018.4))
            (error4.10 (call L.fun/error9019.9)))
        (call L.fun/ascii-char9020.8))
      (call
       L.fun/ascii-char9021.10
       (let ((vector0.19 (call make-vector 8))
             (fixnum1.18 161)
             (pair2.17 (call cons 127 404))
             (vector3.16 (call make-vector 8))
             (pair4.15 (call cons 78 452)))
         fixnum1.18)
       (if #t #\g #\H)
       (let ((ascii-char0.24 #\Q)
             (vector1.23 (call make-vector 8))
             (pair2.22 (call cons 142 301))
             (pair3.21 (call cons 11 346))
             (error4.20 (error 94)))
         (call vector-set! vector1.23 7 vector1.23))
       (if #f (call cons 41 325) (call cons 203 293))))))
(check-by-interp
 '(module
    (define L.fun/vector9152.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) (call make-vector 8)))
    (define L.fun/any9154.5 (lambda () (call make-vector 8)))
    (define L.fun/pair9150.6
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) (call cons 5 460)))
    (define L.fun/ascii-char9147.7 (lambda () #\W))
    (define L.fun/void9155.8 (lambda () (void)))
    (define L.fun/void9148.9 (lambda () (void)))
    (define L.fun/any9153.10 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char9151.11
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) #\b))
    (define L.fun/void9146.12 (lambda () (void)))
    (define L.fun/fixnum9149.13
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13) oprand2.14))
    (define L.fun/empty9145.14 (lambda () empty))
    (call
     +
     (call
      +
      (let ((empty0.21 (call L.fun/empty9145.14))
            (void1.20 (call L.fun/void9146.12))
            (ascii-char2.19 (call L.fun/ascii-char9147.7))
            (boolean3.18 (call pair? (void)))
            (void4.17 (call L.fun/void9148.9)))
        (call - 208 94))
      (call
       L.fun/fixnum9149.13
       (call
        L.fun/pair9150.6
        (call
         L.fun/ascii-char9151.11
         #f
         199
         (call make-vector 8)
         (call cons 215 446))
        (if #t 17 9)
        (call L.fun/vector9152.4 (error 233) #\\ #\b empty)
        (let ((ascii-char0.26 #\Z)
              (empty1.25 empty)
              (vector2.24 (call make-vector 8))
              (vector3.23 (call make-vector 8))
              (error4.22 (error 16)))
          (error 233)))
       (let ((boolean0.31 #f)
             (vector1.30 (call make-vector 8))
             (error2.29 (error 55))
             (empty3.28 empty)
             (boolean4.27 #t))
         error2.29)
       (let ((pair0.36 (call cons 108 382))
             (boolean1.35 #f)
             (boolean2.34 #t)
             (ascii-char3.33 #\N)
             (boolean4.32 #t))
         78)
       (if #f empty empty)))
     (let ((boolean0.41 (call error? (call L.fun/any9153.10)))
           (fixnum1.40 (call * (call - 142 139) (call - 106 141)))
           (fixnum2.39 (call + (call + 187 10) (call + 49 164)))
           (boolean3.38 (call error? (call L.fun/any9154.5)))
           (void4.37 (call L.fun/void9155.8)))
       fixnum1.40))))
(check-by-interp
 '(module
    (define L.fun/pair9174.4 (lambda () (call cons 127 459)))
    (define L.fun/ascii-char9175.5 (lambda () #\\))
    (define L.fun/empty9176.6 (lambda () empty))
    (define L.fun/error9177.7 (lambda () (error 68)))
    (let ((pair0.5 (call L.fun/pair9174.4))
          (ascii-char1.4 (call L.fun/ascii-char9175.5))
          (empty2.3 (call L.fun/empty9176.6))
          (error3.2 (call L.fun/error9177.7))
          (fixnum4.1
           (call
            *
            (call + (call + 164 32) (call - 199 40))
            (call - (call * 189 57) (call + 35 222)))))
      error3.2)))
(check-by-interp
 '(module
    (define L.fun/ascii-char9184.4 (lambda () #\w))
    (define L.fun/boolean9181.5
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) #f))
    (define L.fun/boolean9180.6
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) #t))
    (define L.fun/pair9183.7 (lambda () (call cons 107 477)))
    (define L.fun/empty9187.8
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) empty))
    (define L.fun/void9188.9
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13) oprand3.13))
    (define L.fun/vector9185.10 (lambda () (call make-vector 8)))
    (define L.fun/pair9186.11
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17) oprand3.17))
    (define L.fun/ascii-char9182.12 (lambda () #\k))
    (define L.fun/pair9189.13
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21)
        (call cons 84 435)))
    (if (if (let ((fixnum0.29 172)
                  (void1.28 (void))
                  (void2.27 (void))
                  (error3.26 (error 127))
                  (void4.25 (void)))
              #t)
          (call L.fun/boolean9180.6 #\j (call make-vector 8) empty (void))
          (call L.fun/boolean9181.5 #\v (void) empty (call cons 135 455)))
      (let ((ascii-char0.34 (call L.fun/ascii-char9182.12))
            (pair1.33 (call L.fun/pair9183.7))
            (fixnum2.32 (call + 234 94))
            (ascii-char3.31 (call L.fun/ascii-char9184.4))
            (vector4.30 (call L.fun/vector9185.10)))
        pair1.33)
      (call
       L.fun/pair9186.11
       (if #t empty empty)
       (if #t #\^ #\g)
       (if #f (void) (void))
       (call
        L.fun/pair9186.11
        (call
         L.fun/empty9187.8
         (call make-vector 8)
         (error 49)
         (call make-vector 8)
         empty)
        (if #t #\[ #\Z)
        (call L.fun/void9188.9 (error 215) 245 (error 112) (void))
        (call L.fun/pair9189.13 (void) (void) empty #t))))))
(check-by-interp
 '(module
    (define L.fun/void9202.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1)
        (call vector-set! oprand2.2 7 #\v)))
    (define L.fun/empty9193.5 (lambda () empty))
    (define L.fun/boolean9200.6
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) #t))
    (define L.fun/void9201.7
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) oprand1.11))
    (define L.fun/boolean9199.8
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13) #f))
    (define L.fun/error9197.9
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17) (error 236)))
    (define L.fun/void9198.10
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21) (void)))
    (define L.fun/ascii-char9194.11 (lambda () #\_))
    (define L.fun/error9192.12 (lambda () (error 39)))
    (define L.fun/void9196.13
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25)
        (call vector-set! oprand3.25 7 #\K)))
    (define L.fun/void9195.14
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29) oprand2.30))
    (if (let ((fixnum0.37 (call - 201 200))
              (error1.36 (call L.fun/error9192.12))
              (boolean2.35 (call void? (call cons 147 466)))
              (empty3.34 (call L.fun/empty9193.5))
              (ascii-char4.33 (call L.fun/ascii-char9194.11)))
          (call empty? (call cons 87 303)))
      (call
       L.fun/void9195.14
       (let ((boolean0.42 #f)
             (boolean1.41 #t)
             (ascii-char2.40 #\a)
             (empty3.39 empty)
             (fixnum4.38 44))
         fixnum4.38)
       (call
        L.fun/void9195.14
        (if #t 69 178)
        (call L.fun/void9196.13 empty (void) 4 (call make-vector 8))
        (if #f (void) (void))
        (call L.fun/error9197.9 #\h empty (void) #f))
       (call
        L.fun/void9198.10
        (let ((pair0.47 (call cons 42 499))
              (vector1.46 (call make-vector 8))
              (vector2.45 (call make-vector 8))
              (fixnum3.44 113)
              (fixnum4.43 192))
          empty)
        (if #t #t #f)
        (call L.fun/boolean9199.8 (void) (void) (call make-vector 8) 155)
        (if #t (error 99) (error 145)))
       (let ((void0.52 (void))
             (void1.51 (void))
             (error2.50 (error 238))
             (fixnum3.49 48)
             (error4.48 (error 159)))
         error2.50))
      (if (call
           L.fun/boolean9200.6
           #\Y
           (call make-vector 8)
           empty
           (call make-vector 8))
        (call
         L.fun/void9201.7
         (call cons 31 364)
         (void)
         (error 91)
         (error 110))
        (call
         L.fun/void9202.4
         empty
         (void)
         (call make-vector 8)
         (call make-vector 8))))))
(check-by-interp
 '(module
    (define L.fun/void9209.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) (void)))
    (define L.fun/vector9216.5
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) (call make-vector 8)))
    (define L.fun/empty9212.6
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) empty))
    (define L.fun/error9215.7
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13) (error 171)))
    (define L.fun/void9214.8
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17) oprand1.19))
    (define L.fun/any9206.9
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21) empty))
    (define L.fun/boolean9207.10
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25) #t))
    (define L.fun/ascii-char9210.11
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29) oprand3.29))
    (define L.fun/empty9208.12
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33) empty))
    (define L.fun/error9211.13
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37) (error 165)))
    (define L.fun/ascii-char9205.14
      (lambda (oprand0.44 oprand1.43 oprand2.42 oprand3.41) oprand1.43))
    (define L.fun/boolean9213.15
      (lambda (oprand0.48 oprand1.47 oprand2.46 oprand3.45) oprand1.47))
    (if (if (call vector? #\N)
          (if #f #f #t)
          (let ((error0.53 (error 167))
                (empty1.52 empty)
                (ascii-char2.51 #\])
                (empty3.50 empty)
                (error4.49 (error 13)))
            #f))
      (call
       L.fun/ascii-char9205.14
       (call
        empty?
        (call L.fun/any9206.9 (call cons 208 367) (error 165) 80 (error 107)))
       (let ((empty0.58 empty)
             (error1.57 (error 185))
             (ascii-char2.56 #\q)
             (error3.55 (error 35))
             (pair4.54 (call cons 38 486)))
         ascii-char2.56)
       (call
        L.fun/boolean9207.10
        (if #f (error 15) (error 231))
        (call
         L.fun/empty9208.12
         (call cons 61 286)
         (call cons 184 279)
         (call make-vector 8)
         (call make-vector 8))
        (if #f (call make-vector 8) (call make-vector 8))
        (call L.fun/void9209.4 #f 242 #t (call cons 164 296)))
       (let ((fixnum0.63 87)
             (ascii-char1.62 #\p)
             (boolean2.61 #f)
             (error3.60 (error 183))
             (vector4.59 (call make-vector 8)))
         (call cons 221 419)))
      (call
       L.fun/ascii-char9210.11
       (if #f (error 73) (error 104))
       (call
        L.fun/error9211.13
        (call L.fun/empty9212.6 (error 200) #f (void) (call make-vector 8))
        (if #f #\x #\j)
        (if #f #\h #\C)
        (call L.fun/boolean9213.15 #f #t (void) #\t))
       (call
        L.fun/void9214.8
        (call L.fun/error9215.7 empty (void) empty (void))
        (call L.fun/void9214.8 (error 157) (void) 80 (call make-vector 8))
        (if #f 224 135)
        (call L.fun/vector9216.5 143 (error 160) 186 (call cons 65 298)))
       (if #f #\Q #\g)))))
(check-by-interp
 '(module
    (define L.fun/vector9220.4 (lambda () (call make-vector 8)))
    (define L.fun/error9222.5 (lambda () (error 137)))
    (define L.fun/any9223.6 (lambda () (error 155)))
    (define L.fun/any9221.7 (lambda () (call make-vector 8)))
    (define L.fun/pair9219.8 (lambda () (call cons 107 269)))
    (let ((fixnum0.5
           (call
            *
            (call * (call + 81 149) (call + 226 59))
            (call * (call * 252 6) (call + 201 74))))
          (pair1.4 (call L.fun/pair9219.8))
          (vector2.3 (call L.fun/vector9220.4))
          (boolean3.2 (call ascii-char? (call L.fun/any9221.7)))
          (error4.1 (call L.fun/error9222.5)))
      (call error? (call L.fun/any9223.6)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char9280.4 (lambda () #\a))
    (define L.fun/void9282.5 (lambda () (void)))
    (define L.fun/empty9281.6 (lambda () empty))
    (define L.fun/any9283.7 (lambda () (call cons 28 412)))
    (define L.fun/pair9284.8 (lambda () (call cons 182 402)))
    (define L.fun/vector9279.9 (lambda () (call make-vector 8)))
    (let ((vector0.5 (call L.fun/vector9279.9))
          (ascii-char1.4 (call L.fun/ascii-char9280.4))
          (empty2.3 (call L.fun/empty9281.6))
          (void3.2 (call L.fun/void9282.5))
          (boolean4.1 (call fixnum? (call L.fun/any9283.7))))
      (call L.fun/pair9284.8))))
(check-by-interp
 '(module
    (define L.fun/vector9388.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char9389.5 (lambda () #\G))
    (let ((vector0.5 (call L.fun/vector9388.4))
          (ascii-char1.4 (call L.fun/ascii-char9389.5))
          (fixnum2.3
           (call
            -
            (call + (call + 31 186) (call * 252 112))
            (call + (call * 219 15) (call + 199 185))))
          (fixnum3.2
           (call
            *
            (call + (call + 50 132) (call + 241 219))
            (call * (call + 37 144) (call - 128 246))))
          (fixnum4.1
           (call
            +
            (call + (call + 139 140) (call + 133 196))
            (call * (call - 150 106) (call * 71 94)))))
      fixnum2.3)))
(check-by-interp
 '(module
    (define L.fun/vector9493.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) (call make-vector 8)))
    (define L.fun/fixnum9491.5
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5)
        (call - (call + oprand2.6 126) (call - 53 oprand0.8))))
    (define L.fun/boolean9503.6
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) #t))
    (define L.fun/empty9494.7
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13) empty))
    (define L.fun/ascii-char9499.8
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17) #\f))
    (define L.fun/void9487.9 (lambda () (void)))
    (define L.fun/void9495.10
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21)
        (call vector-set! oprand1.23 7 (call cons 170 335))))
    (define L.fun/void9500.11
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25)
        (call vector-set! oprand2.26 7 (call make-vector 8))))
    (define L.fun/pair9506.12 (lambda () (call cons 36 398)))
    (define L.fun/pair9489.13 (lambda () (call cons 250 334)))
    (define L.fun/pair9507.14 (lambda () (call cons 144 287)))
    (define L.fun/fixnum9504.15
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29) 82))
    (define L.fun/fixnum9492.16
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33) 214))
    (define L.fun/pair9505.17 (lambda () (call cons 215 267)))
    (define L.fun/error9486.18 (lambda () (error 142)))
    (define L.fun/pair9501.19
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37)
        (call cons 29 479)))
    (define L.fun/empty9490.20 (lambda () empty))
    (define L.fun/vector9498.21
      (lambda (oprand0.44 oprand1.43 oprand2.42 oprand3.41)
        (call make-vector 8)))
    (define L.fun/vector9509.22 (lambda () (call make-vector 8)))
    (define L.fun/pair9502.23
      (lambda (oprand0.48 oprand1.47 oprand2.46 oprand3.45)
        (call cons 252 325)))
    (define L.fun/vector9496.24
      (lambda (oprand0.52 oprand1.51 oprand2.50 oprand3.49)
        (call make-vector 8)))
    (define L.fun/empty9488.25 (lambda () empty))
    (define L.fun/empty9497.26
      (lambda (oprand0.56 oprand1.55 oprand2.54 oprand3.53) empty))
    (define L.fun/ascii-char9508.27 (lambda () #\[))
    (call
     *
     (let ((error0.61 (call L.fun/error9486.18))
           (void1.60 (call L.fun/void9487.9))
           (empty2.59 (call L.fun/empty9488.25))
           (pair3.58 (call L.fun/pair9489.13))
           (empty4.57 (call L.fun/empty9490.20)))
       (call - (call - 16 157) (call + 93 204)))
     (call
      L.fun/fixnum9491.5
      (call
       L.fun/fixnum9491.5
       (call
        L.fun/fixnum9492.16
        (call
         L.fun/vector9493.4
         (call make-vector 8)
         (call make-vector 8)
         (call cons 191 346)
         #\F)
        (let ((fixnum0.66 74)
              (vector1.65 (call make-vector 8))
              (error2.64 (error 84))
              (boolean3.63 #f)
              (pair4.62 (call cons 241 332)))
          error2.64)
        (call L.fun/empty9494.7 (call make-vector 8) (error 13) #\c #\L)
        (call L.fun/void9495.10 #\L (call make-vector 8) (void) #f))
       (call
        L.fun/vector9496.24
        (if #f (call make-vector 8) (call make-vector 8))
        (if #f (error 155) (error 174))
        (if #f (call make-vector 8) (call make-vector 8))
        (call L.fun/empty9497.26 (call cons 23 306) (void) #f #f))
       (let ((fixnum0.71 188)
             (pair1.70 (call cons 143 336))
             (empty2.69 empty)
             (void3.68 (void))
             (pair4.67 (call cons 36 438)))
         95)
       (call vector? (if #t #f #\Q)))
      (call
       L.fun/vector9498.21
       (let ((empty0.76 empty)
             (fixnum1.75 218)
             (ascii-char2.74 #\R)
             (empty3.73 empty)
             (fixnum4.72 34))
         (call cons 64 447))
       (call
        L.fun/ascii-char9499.8
        (call
         L.fun/void9500.11
         (call cons 107 385)
         164
         (call make-vector 8)
         (error 36))
        (let ((ascii-char0.81 #\Y)
              (void1.80 (void))
              (ascii-char2.79 #\h)
              (empty3.78 empty)
              (error4.77 (error 219)))
          empty)
        (call vector? (void))
        (call boolean? #f))
       (call
        L.fun/pair9501.19
        (let ((void0.86 (void))
              (pair1.85 (call cons 170 333))
              (fixnum2.84 154)
              (pair3.83 (call cons 172 383))
              (boolean4.82 #f))
          fixnum2.84)
        (call L.fun/pair9502.23 (void) #f (error 230) empty)
        (call L.fun/boolean9503.6 #f #\w (error 159) #\d)
        (let ((empty0.91 empty)
              (ascii-char1.90 #\F)
              (error2.89 (error 130))
              (pair3.88 (call cons 55 466))
              (error4.87 (error 244)))
          (void)))
       (let ((empty0.96 empty)
             (void1.95 (void))
             (void2.94 (void))
             (vector3.93 (call make-vector 8))
             (error4.92 (error 63)))
         error4.92))
      (if (let ((vector0.101 (call make-vector 8))
                (ascii-char1.100 #\n)
                (ascii-char2.99 #\u)
                (error3.98 (error 109))
                (error4.97 (error 8)))
            #t)
        (call - 243 171)
        (call
         L.fun/fixnum9504.15
         (call make-vector 8)
         empty
         (error 26)
         (call make-vector 8)))
      (let ((pair0.106 (call L.fun/pair9505.17))
            (pair1.105 (call L.fun/pair9506.12))
            (pair2.104 (call L.fun/pair9507.14))
            (ascii-char3.103 (call L.fun/ascii-char9508.27))
            (vector4.102 (call L.fun/vector9509.22)))
        (call fixnum? (call cons 26 370)))))))
(check-by-interp
 '(module
    (define L.fun/empty9642.4 (lambda () empty))
    (define L.fun/vector9648.5 (lambda () (call make-vector 8)))
    (define L.fun/void9636.6 (lambda () (void)))
    (define L.fun/empty9640.7 (lambda () empty))
    (define L.fun/pair9633.8 (lambda () (call cons 220 472)))
    (define L.fun/any9643.9 (lambda () 122))
    (define L.fun/ascii-char9635.10 (lambda () #\Q))
    (define L.fun/vector9638.11 (lambda () (call make-vector 8)))
    (define L.fun/pair9637.12 (lambda () (call cons 42 488)))
    (define L.fun/void9647.13 (lambda () (void)))
    (define L.fun/empty9639.14 (lambda () empty))
    (define L.fun/any9634.15 (lambda () 113))
    (define L.fun/empty9646.16 (lambda () empty))
    (define L.fun/pair9641.17 (lambda () (call cons 79 258)))
    (define L.fun/void9631.18 (lambda () (void)))
    (define L.fun/void9644.19 (lambda () (void)))
    (define L.fun/error9629.20
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1)
        (call L.fun/error9630.21)))
    (define L.fun/error9630.21 (lambda () (error 132)))
    (define L.fun/empty9632.22 (lambda () empty))
    (define L.fun/any9645.23 (lambda () empty))
    (call
     L.fun/error9629.20
     (call
      fixnum?
      (let ((void0.9 (call L.fun/void9631.18))
            (error1.8
             (call L.fun/error9629.20 #t empty (void) (call make-vector 8)))
            (boolean2.7 (call pair? (call cons 194 508)))
            (empty3.6 (call L.fun/empty9632.22))
            (pair4.5 (call L.fun/pair9633.8)))
        (call L.fun/any9634.15)))
     (let ((ascii-char0.14 (call L.fun/ascii-char9635.10))
           (void1.13 (call L.fun/void9636.6))
           (pair2.12 (call L.fun/pair9637.12))
           (fixnum3.11 (call - (call * 135 98) (call * 45 252)))
           (vector4.10 (call L.fun/vector9638.11)))
       (call L.fun/empty9639.14))
     (let ((empty0.19 (call L.fun/empty9640.7))
           (pair1.18 (call L.fun/pair9641.17))
           (empty2.17 (call L.fun/empty9642.4))
           (boolean3.16 (call vector? (call L.fun/any9643.9)))
           (void4.15 (call L.fun/void9644.19)))
       void4.15)
     (let ((fixnum0.24 (call + (call * 122 9) (call + 213 93)))
           (boolean1.23 (call boolean? (call L.fun/any9645.23)))
           (empty2.22 (call L.fun/empty9646.16))
           (fixnum3.21 (call * (call * 121 125) (call + 148 53)))
           (void4.20 (call L.fun/void9647.13)))
       (call L.fun/vector9648.5)))))
(check-by-interp
 '(module
    (define L.fun/vector9664.4 (lambda () (call make-vector 8)))
    (define L.fun/empty9673.5 (lambda () empty))
    (define L.fun/error9670.6 (lambda () (error 71)))
    (define L.fun/error9657.7
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) (error 96)))
    (define L.fun/empty9653.8 (lambda () empty))
    (define L.fun/void9658.9
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) (void)))
    (define L.fun/void9668.10
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) (void)))
    (define L.fun/pair9666.11
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13)
        (call cons 207 311)))
    (define L.fun/vector9654.12
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17) oprand2.18))
    (define L.fun/empty9667.13
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21) empty))
    (define L.fun/void9672.14 (lambda () (void)))
    (define L.fun/vector9663.15 (lambda () (call make-vector 8)))
    (define L.fun/pair9656.16
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25)
        (call cons 110 428)))
    (define L.fun/ascii-char9651.17
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29) oprand1.31))
    (define L.fun/vector9671.18 (lambda () (call make-vector 8)))
    (define L.fun/pair9669.19 (lambda () (call cons 241 510)))
    (define L.fun/boolean9665.20
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33) #f))
    (define L.fun/empty9652.21
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37)
        (call L.fun/empty9653.8)))
    (define L.fun/void9659.22 (lambda () (void)))
    (define L.fun/error9661.23 (lambda () (error 172)))
    (define L.fun/void9674.24
      (lambda (oprand0.44 oprand1.43 oprand2.42 oprand3.41) oprand2.42))
    (define L.fun/boolean9655.25
      (lambda (oprand0.48 oprand1.47 oprand2.46 oprand3.45) #t))
    (define L.fun/vector9660.26 (lambda () (call make-vector 8)))
    (define L.fun/pair9675.27
      (lambda (oprand0.52 oprand1.51 oprand2.50 oprand3.49)
        (call cons 172 308)))
    (define L.fun/error9662.28 (lambda () (error 3)))
    (call
     L.fun/ascii-char9651.17
     (call
      L.fun/empty9652.21
      (call
       L.fun/vector9654.12
       (let ((ascii-char0.57 #\h)
             (vector1.56 (call make-vector 8))
             (boolean2.55 #f)
             (empty3.54 empty)
             (void4.53 (void)))
         void4.53)
       (call
        L.fun/boolean9655.25
        (let ((ascii-char0.62 #\Z)
              (vector1.61 (call make-vector 8))
              (fixnum2.60 41)
              (empty3.59 empty)
              (void4.58 (void)))
          (call cons 251 421))
        (if #f (call cons 234 412) (call cons 50 418))
        (if #f (error 103) (error 181))
        (let ((vector0.67 (call make-vector 8))
              (boolean1.66 #f)
              (error2.65 (error 75))
              (boolean3.64 #t)
              (pair4.63 (call cons 21 321)))
          (call cons 101 501)))
       (let ((fixnum0.72 43)
             (boolean1.71 #f)
             (ascii-char2.70 #\i)
             (fixnum3.69 207)
             (error4.68 (error 54)))
         (call make-vector 8))
       (call
        L.fun/pair9656.16
        (if #f (void) (void))
        (let ((empty0.77 empty)
              (void1.76 (void))
              (vector2.75 (call make-vector 8))
              (void3.74 (void))
              (void4.73 (void)))
          #t)
        (call
         L.fun/empty9652.21
         (call make-vector 8)
         (void)
         (call make-vector 8)
         #\n)
        (call L.fun/error9657.7 (call make-vector 8) empty #\Y empty)))
      (if (if #t #t #t)
        (let ((ascii-char0.82 #\V)
              (pair1.81 (call cons 31 505))
              (boolean2.80 #t)
              (ascii-char3.79 #\y)
              (void4.78 (void)))
          (void))
        (call L.fun/void9658.9 (error 251) #t (call cons 2 268) #f))
      (let ((boolean0.87 (call boolean? (call make-vector 8)))
            (ascii-char1.86
             (call L.fun/ascii-char9651.17 empty #\P #\S (void)))
            (boolean2.85 (call empty? empty))
            (void3.84 (call L.fun/void9659.22))
            (fixnum4.83 (call - 113 115)))
        (call L.fun/vector9660.26))
      (let ((error0.92 (call L.fun/error9661.23))
            (error1.91 (call L.fun/error9662.28))
            (vector2.90 (call L.fun/vector9663.15))
            (vector3.89 (call L.fun/vector9664.4))
            (empty4.88
             (call
              L.fun/empty9652.21
              (call make-vector 8)
              (void)
              (call make-vector 8)
              #\Z)))
        (call
         L.fun/ascii-char9651.17
         empty
         #\W
         #\J
         (call vector-set! vector2.90 7 187))))
     (if (call
          L.fun/boolean9665.20
          (call L.fun/pair9666.11 empty #\` (error 246) (error 52))
          (if #f #\_ #\_)
          (call L.fun/empty9667.13 empty empty empty #\])
          (call L.fun/void9668.10 #t empty #\e #t))
       (if #t #\S #\W)
       (let ((fixnum0.97 184)
             (error1.96 (error 75))
             (empty2.95 empty)
             (pair3.94 (call cons 27 283))
             (void4.93 (void)))
         #\D))
     (let ((pair0.102 (call L.fun/pair9669.19))
           (error1.101 (call L.fun/error9670.6))
           (vector2.100 (call L.fun/vector9671.18))
           (void3.99 (call L.fun/void9672.14))
           (fixnum4.98 (call + (call - 192 61) (call + 116 205))))
       (call
        L.fun/ascii-char9651.17
        (call L.fun/empty9673.5)
        (call L.fun/ascii-char9651.17 empty #\f #\` void3.99)
        (call
         L.fun/ascii-char9651.17
         empty
         #\K
         #\^
         (call
          vector-set!
          vector2.100
          7
          (call vector-set! vector2.100 7 fixnum4.98)))
        void3.99))
     (if (if #f #f #f)
       (call
        L.fun/void9674.24
        (call * 251 196)
        (call
         L.fun/pair9675.27
         #f
         (call make-vector 8)
         (call cons 158 495)
         (call make-vector 8))
        (call L.fun/void9674.24 13 (call cons 182 416) (void) #\r)
        (let ((pair0.107 (call cons 172 333))
              (pair1.106 (call cons 7 426))
              (boolean2.105 #f)
              (empty3.104 empty)
              (pair4.103 (call cons 130 256)))
          #\b))
       (if #f (void) (void))))))
(check-by-interp
 '(module
    (define L.fun/error9704.4 (lambda () (error 220)))
    (define L.fun/void9703.5 (lambda () (void)))
    (define L.fun/void9702.6 (lambda () (void)))
    (define L.fun/empty9705.7 (lambda () empty))
    (let ((fixnum0.5
           (call
            -
            (call - (call + 113 124) (call - 207 189))
            (call + (call + 135 203) (call * 37 30))))
          (void1.4 (call L.fun/void9702.6))
          (void2.3 (call L.fun/void9703.5))
          (error3.2 (call L.fun/error9704.4))
          (empty4.1 (call L.fun/empty9705.7)))
      error3.2)))
(check-by-interp
 '(module
    (define L.fun/pair9710.4 (lambda () (call cons 99 330)))
    (define L.fun/error9708.5 (lambda () (error 214)))
    (define L.fun/void9709.6 (lambda () (void)))
    (let ((error0.5 (call L.fun/error9708.5))
          (void1.4 (call L.fun/void9709.6))
          (fixnum2.3
           (call
            +
            (call - (call - 250 19) (call - 98 52))
            (call + (call - 228 30) (call + 40 39))))
          (fixnum3.2
           (call
            *
            (call + (call * 27 124) (call * 21 71))
            (call + (call + 156 169) (call - 21 204))))
          (pair4.1 (call L.fun/pair9710.4)))
      void1.4)))
(check-by-interp
 '(module
    (define L.fun/void9720.4 (lambda () (void)))
    (define L.fun/pair9723.5
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) (call cons 119 350)))
    (define L.fun/void9737.6 (lambda () (void)))
    (define L.fun/pair9744.7 (lambda () (call cons 36 502)))
    (define L.fun/ascii-char9726.8
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) oprand0.8))
    (define L.fun/empty9740.9 (lambda () empty))
    (define L.fun/empty9715.10
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9)
        (call L.fun/empty9716.24)))
    (define L.fun/error9713.11
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13)
        (call L.fun/error9714.30)))
    (define L.fun/pair9722.12
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17) oprand0.20))
    (define L.fun/vector9728.13
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21)
        (call make-vector 8)))
    (define L.fun/void9730.14
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25) oprand2.26))
    (define L.fun/vector9719.15 (lambda () (call make-vector 8)))
    (define L.fun/pair9732.16 (lambda () (call cons 124 389)))
    (define L.fun/ascii-char9742.17 (lambda () #\Z))
    (define L.fun/vector9746.18 (lambda () (call make-vector 8)))
    (define L.fun/pair9729.19
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29)
        (call cons 46 405)))
    (define L.fun/pair9734.20 (lambda () (call cons 87 341)))
    (define L.fun/ascii-char9750.21 (lambda () #\b))
    (define L.fun/pair9747.22 (lambda () (call cons 203 270)))
    (define L.fun/pair9743.23 (lambda () (call cons 158 342)))
    (define L.fun/empty9716.24 (lambda () empty))
    (define L.fun/pair9739.25 (lambda () (call cons 34 410)))
    (define L.fun/ascii-char9733.26 (lambda () #\u))
    (define L.fun/void9749.27 (lambda () (void)))
    (define L.fun/empty9736.28 (lambda () empty))
    (define L.fun/ascii-char9745.29 (lambda () #\G))
    (define L.fun/error9714.30 (lambda () (error 117)))
    (define L.fun/error9725.31
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33) (error 8)))
    (define L.fun/void9724.32
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37)
        (call vector-set! oprand2.38 7 oprand1.39)))
    (define L.fun/pair9727.33
      (lambda (oprand0.44 oprand1.43 oprand2.42 oprand3.41) oprand0.44))
    (define L.fun/ascii-char9721.34 (lambda () #\P))
    (define L.fun/empty9748.35 (lambda () empty))
    (define L.fun/void9741.36 (lambda () (void)))
    (define L.fun/pair9751.37 (lambda () (call cons 220 398)))
    (define L.fun/empty9731.38
      (lambda (oprand0.48 oprand1.47 oprand2.46 oprand3.45) oprand3.45))
    (define L.fun/vector9717.39 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char9738.40 (lambda () #\G))
    (define L.fun/void9718.41 (lambda () (void)))
    (define L.fun/ascii-char9735.42 (lambda () #\^))
    (define L.fun/void9752.43 (lambda () (void)))
    (call
     L.fun/error9713.11
     (call
      L.fun/empty9715.10
      (let ((empty0.53
             (call
              L.fun/empty9715.10
              #\D
              (call cons 148 302)
              (call cons 27 369)
              #\[))
            (vector1.52 (call L.fun/vector9717.39))
            (void2.51 (call L.fun/void9718.41))
            (vector3.50 (call L.fun/vector9719.15))
            (void4.49 (call L.fun/void9720.4)))
        (call L.fun/ascii-char9721.34))
      (call
       L.fun/pair9722.12
       (call
        L.fun/pair9723.5
        (call * 15 57)
        (let ((fixnum0.58 133)
              (void1.57 (void))
              (pair2.56 (call cons 19 321))
              (fixnum3.55 221)
              (vector4.54 (call make-vector 8)))
          vector4.54)
        (if #f #\K #\q)
        (call
         L.fun/void9724.32
         (call cons 34 486)
         (error 175)
         (call make-vector 8)
         (error 210)))
       (call
        L.fun/error9725.31
        (if #t 233 133)
        (if #t (void) (void))
        (call L.fun/ascii-char9726.8 #\G empty #t empty)
        (call * 21 51))
       (let ((error0.63 (error 93))
             (error1.62 (error 167))
             (boolean2.61 #t)
             (error3.60 (error 189))
             (fixnum4.59 192))
         (error 22))
       (let ((boolean0.68 #f)
             (empty1.67 empty)
             (void2.66 (void))
             (boolean3.65 #t)
             (ascii-char4.64 #\M))
         ascii-char4.64))
      (call
       L.fun/pair9727.33
       (if #t (call cons 180 353) (call cons 155 363))
       (call
        L.fun/vector9728.13
        (call L.fun/pair9729.19 (void) (void) #\E #\t)
        (if #t empty empty)
        (let ((empty0.73 empty)
              (pair1.72 (call cons 66 383))
              (void2.71 (void))
              (fixnum3.70 212)
              (fixnum4.69 114))
          #\W)
        (let ((ascii-char0.78 #\B)
              (empty1.77 empty)
              (error2.76 (error 141))
              (ascii-char3.75 #\L)
              (ascii-char4.74 #\\))
          empty1.77))
       (call
        L.fun/void9730.14
        (call
         L.fun/empty9731.38
         (error 216)
         (call cons 200 310)
         (error 211)
         empty)
        (if #f (error 50) (error 232))
        (let ((empty0.83 empty)
              (vector1.82 (call make-vector 8))
              (void2.81 (void))
              (vector3.80 (call make-vector 8))
              (vector4.79 (call make-vector 8)))
          void2.81)
        (if #f empty empty))
       (let ((empty0.88 empty)
             (void1.87 (void))
             (error2.86 (error 181))
             (boolean3.85 #f)
             (ascii-char4.84 #\[))
         error2.86))
      (let ((pair0.93 (call L.fun/pair9732.16))
            (fixnum1.92 (call + 155 225))
            (ascii-char2.91 (call L.fun/ascii-char9733.26))
            (pair3.90 (call L.fun/pair9734.20))
            (ascii-char4.89 (call L.fun/ascii-char9735.42)))
        ascii-char4.89))
     (if (if #f #t #t)
       (if #t (void) (void))
       (let ((vector0.98 (call make-vector 8))
             (pair1.97 (call cons 165 382))
             (empty2.96 empty)
             (error3.95 (error 131))
             (vector4.94 (call make-vector 8)))
         (call vector-set! vector0.98 7 #\m)))
     (let ((error0.103
            (call
             L.fun/error9713.11
             (call L.fun/empty9736.28)
             (call L.fun/void9737.6)
             (call L.fun/ascii-char9738.40)
             (call L.fun/pair9739.25)))
           (fixnum1.102 (call + (call - 9 192) (call + 25 62)))
           (error2.101
            (call
             L.fun/error9713.11
             (call L.fun/empty9740.9)
             (call L.fun/void9741.36)
             (call L.fun/ascii-char9742.17)
             (call L.fun/pair9743.23)))
           (fixnum3.100 (call - (call + 95 78) (call * 112 206)))
           (pair4.99 (call L.fun/pair9744.7)))
       (call L.fun/ascii-char9745.29))
     (let ((vector0.108 (call L.fun/vector9746.18))
           (pair1.107 (call L.fun/pair9747.22))
           (error2.106
            (call
             L.fun/error9713.11
             (call L.fun/empty9748.35)
             (call L.fun/void9749.27)
             (call L.fun/ascii-char9750.21)
             (call L.fun/pair9751.37)))
           (fixnum3.105 (call * (call + 5 9) (call + 165 228)))
           (void4.104 (call L.fun/void9752.43)))
       pair1.107))))
(check-by-interp
 '(module
    (define L.fun/vector9809.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) (call make-vector 8)))
    (define L.fun/error9807.5
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) (error 171)))
    (define L.fun/pair9808.6
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) (call cons 15 447)))
    (define L.fun/void9813.7
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13)
        (call vector-set! oprand0.16 7 62)))
    (define L.fun/void9810.8
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17)
        (call vector-set! oprand0.20 7 #f)))
    (define L.fun/pair9811.9
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21)
        (call cons 160 421)))
    (define L.fun/boolean9806.10
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25) #t))
    (define L.fun/pair9815.11
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29)
        (call cons 126 328)))
    (define L.fun/ascii-char9812.12
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33) #\R))
    (define L.fun/error9814.13
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37) oprand1.39))
    (if (if (call L.fun/boolean9806.10 145 (void) empty empty)
          (call fixnum? #t)
          (call ascii-char? 225))
      (call
       L.fun/error9807.5
       (let ((error0.45 (error 205))
             (vector1.44 (call make-vector 8))
             (vector2.43 (call make-vector 8))
             (ascii-char3.42 #\E)
             (ascii-char4.41 #\A))
         #f)
       (call
        L.fun/pair9808.6
        (let ((fixnum0.50 64)
              (fixnum1.49 143)
              (void2.48 (void))
              (empty3.47 empty)
              (pair4.46 (call cons 15 326)))
          #f)
        (call L.fun/vector9809.4 empty #\w (error 125) (call make-vector 8))
        (call
         L.fun/void9810.8
         (call make-vector 8)
         #\s
         145
         (call cons 134 325))
        (call * 134 89))
       (call
        L.fun/pair9811.9
        (call L.fun/ascii-char9812.12 #t #t #f (call cons 3 310))
        (if #f #\d #\m)
        (if #f (call make-vector 8) (call make-vector 8))
        (call
         L.fun/void9813.7
         (call make-vector 8)
         (call make-vector 8)
         248
         #t))
       (let ((empty0.55 empty)
             (ascii-char1.54 #\x)
             (fixnum2.53 121)
             (empty3.52 empty)
             (pair4.51 (call cons 241 288)))
         (call make-vector 8)))
      (call
       L.fun/error9814.13
       (call
        L.fun/pair9815.11
        (call
         L.fun/pair9815.11
         (call cons 99 453)
         13
         (call cons 52 462)
         (call make-vector 8))
        (call + 24 202)
        (let ((boolean0.60 #t)
              (boolean1.59 #t)
              (void2.58 (void))
              (fixnum3.57 248)
              (empty4.56 empty))
          (call cons 45 307))
        (if #t (call make-vector 8) (call make-vector 8)))
       (if #f (error 67) (error 38))
       (let ((empty0.65 empty)
             (pair1.64 (call cons 97 411))
             (ascii-char2.63 #\K)
             (vector3.62 (call make-vector 8))
             (boolean4.61 #t))
         (error 158))
       (if #f (call make-vector 8) (call make-vector 8))))))
(check-by-interp
 '(module
    (define L.fun/vector9907.4
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1)
        (call L.fun/vector9908.21)))
    (define L.fun/boolean9916.5
      (lambda (oprand0.8 oprand1.7 oprand2.6 oprand3.5) #f))
    (define L.fun/empty9915.6
      (lambda (oprand0.12 oprand1.11 oprand2.10 oprand3.9) empty))
    (define L.fun/pair9909.7
      (lambda (oprand0.16 oprand1.15 oprand2.14 oprand3.13)
        (call cons 22 265)))
    (define L.fun/void9925.8
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17) (void)))
    (define L.fun/ascii-char9910.9
      (lambda (oprand0.24 oprand1.23 oprand2.22 oprand3.21) oprand0.24))
    (define L.fun/empty9914.10
      (lambda (oprand0.28 oprand1.27 oprand2.26 oprand3.25) oprand2.26))
    (define L.fun/boolean9930.11
      (lambda (oprand0.32 oprand1.31 oprand2.30 oprand3.29) #f))
    (define L.fun/ascii-char9931.12
      (lambda (oprand0.36 oprand1.35 oprand2.34 oprand3.33) oprand0.36))
    (define L.fun/void9922.13 (lambda () (void)))
    (define L.fun/empty9919.14
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37) oprand3.37))
    (define L.fun/empty9918.15
      (lambda (oprand0.44 oprand1.43 oprand2.42 oprand3.41) empty))
    (define L.fun/empty9927.16 (lambda () empty))
    (define L.fun/pair9923.17
      (lambda (oprand0.48 oprand1.47 oprand2.46 oprand3.45) oprand0.48))
    (define L.fun/empty9911.18
      (lambda (oprand0.52 oprand1.51 oprand2.50 oprand3.49) empty))
    (define L.fun/ascii-char9924.19
      (lambda (oprand0.56 oprand1.55 oprand2.54 oprand3.53) oprand2.54))
    (define L.fun/ascii-char9913.20 (lambda () #\y))
    (define L.fun/vector9908.21 (lambda () (call make-vector 8)))
    (define L.fun/empty9917.22
      (lambda (oprand0.60 oprand1.59 oprand2.58 oprand3.57) empty))
    (define L.fun/empty9926.23
      (lambda (oprand0.64 oprand1.63 oprand2.62 oprand3.61)
        (call L.fun/empty9927.16)))
    (define L.fun/boolean9928.24
      (lambda (oprand0.68 oprand1.67 oprand2.66 oprand3.65) #t))
    (define L.fun/ascii-char9912.25
      (lambda (oprand0.72 oprand1.71 oprand2.70 oprand3.69)
        (call L.fun/ascii-char9913.20)))
    (define L.fun/vector9920.26
      (lambda (oprand0.76 oprand1.75 oprand2.74 oprand3.73)
        (call make-vector 8)))
    (define L.fun/ascii-char9929.27
      (lambda (oprand0.80 oprand1.79 oprand2.78 oprand3.77) #\d))
    (define L.fun/void9921.28
      (lambda (oprand0.84 oprand1.83 oprand2.82 oprand3.81)
        (call L.fun/void9922.13)))
    (call
     L.fun/vector9907.4
     (if (if #f #t #t)
       (call
        L.fun/pair9909.7
        (if #t #t #t)
        (call L.fun/ascii-char9910.9 #\m 204 (void) #f)
        (call
         L.fun/empty9911.18
         (call make-vector 8)
         #t
         (call make-vector 8)
         (void))
        (let ((fixnum0.89 67)
              (fixnum1.88 186)
              (pair2.87 (call cons 44 370))
              (ascii-char3.86 #\i)
              (pair4.85 (call cons 121 388)))
          3))
       (if #f (call cons 210 386) (call cons 215 390)))
     (if (if #f #f #f)
       (let ((boolean0.94 #f)
             (vector1.93 (call make-vector 8))
             (boolean2.92 #f)
             (fixnum3.91 169)
             (empty4.90 empty))
         fixnum3.91)
       (let ((boolean0.99 #t)
             (fixnum1.98 181)
             (ascii-char2.97 #\T)
             (pair3.96 (call cons 165 509))
             (error4.95 (error 176)))
         98))
     (call
      L.fun/ascii-char9912.25
      (if (if #t #t #f)
        (call L.fun/empty9914.10 (void) #\b empty #\m)
        (call
         L.fun/empty9915.6
         (void)
         (call cons 129 449)
         (call make-vector 8)
         empty))
      (if (call
           L.fun/boolean9916.5
           (call make-vector 8)
           (error 113)
           (call cons 116 299)
           47)
        (call L.fun/empty9917.22 (void) 42 182 128)
        (if #t empty empty))
      (if (if #t #t #f)
        (call
         L.fun/empty9918.15
         (call make-vector 8)
         #\g
         #f
         (call make-vector 8))
        (call L.fun/empty9919.14 206 (call cons 149 489) (void) empty))
      (if (if #f #t #f)
        (call
         L.fun/vector9920.26
         (call make-vector 8)
         empty
         (error 209)
         (call cons 50 296))
        (if #t (call make-vector 8) (call make-vector 8))))
     (call
      L.fun/void9921.28
      (call
       L.fun/pair9923.17
       (let ((boolean0.104 #f)
             (pair1.103 (call cons 198 269))
             (fixnum2.102 13)
             (ascii-char3.101 #\G)
             (boolean4.100 #t))
         (call cons 184 493))
       (let ((void0.109 (void))
             (boolean1.108 #t)
             (empty2.107 empty)
             (pair3.106 (call cons 125 476))
             (fixnum4.105 125))
         (call make-vector 8))
       (call
        L.fun/ascii-char9924.19
        (if #t 127 109)
        (let ((vector0.114 (call make-vector 8))
              (empty1.113 empty)
              (pair2.112 (call cons 148 351))
              (ascii-char3.111 #\g)
              (boolean4.110 #t))
          (error 102))
        (let ((fixnum0.119 11)
              (boolean1.118 #f)
              (void2.117 (void))
              (ascii-char3.116 #\W)
              (ascii-char4.115 #\T))
          #\c)
        (call L.fun/void9925.8 (call cons 128 445) empty empty empty))
       (call - (call * 173 133) (call + 240 227)))
      (call
       L.fun/empty9926.23
       (let ((empty0.124 empty)
             (empty1.123 empty)
             (ascii-char2.122 #\x)
             (ascii-char3.121 #\F)
             (vector4.120 (call make-vector 8)))
         (call vector-set! vector4.120 7 empty))
       (let ((pair0.129 (call cons 75 355))
             (pair1.128 (call cons 113 347))
             (fixnum2.127 97)
             (pair3.126 (call cons 21 494))
             (ascii-char4.125 #\q))
         #\M)
       (if #f (error 96) (error 198))
       (let ((pair0.134 (call cons 109 419))
             (pair1.133 (call cons 74 380))
             (vector2.132 (call make-vector 8))
             (ascii-char3.131 #\f)
             (pair4.130 (call cons 86 293)))
         #f))
      (if (call L.fun/boolean9928.24 (error 235) #\s 200 (call make-vector 8))
        (call L.fun/ascii-char9929.27 216 #\n (void) #f)
        (let ((empty0.139 empty)
              (error1.138 (error 146))
              (void2.137 (void))
              (boolean3.136 #t)
              (fixnum4.135 177))
          #\G))
      (if (call
           L.fun/boolean9930.11
           (call make-vector 8)
           (call cons 203 307)
           (void)
           (void))
        (call L.fun/ascii-char9931.12 #\e (call make-vector 8) (void) (void))
        (if #t #\y #\J))))))
(check-by-interp
 '(module
    (define L.fun/void9942.4 (lambda () (void)))
    (define L.fun/error9940.5 (lambda () (error 109)))
    (define L.fun/vector9941.6 (lambda () (call make-vector 8)))
    (let ((fixnum0.5
           (call
            +
            (call + (call + 94 17) (call - 244 137))
            (call + (call * 156 39) (call + 68 243))))
          (error1.4 (call L.fun/error9940.5))
          (vector2.3 (call L.fun/vector9941.6))
          (void3.2 (call L.fun/void9942.4))
          (fixnum4.1
           (call
            +
            (call * (call * 24 98) (call * 244 63))
            (call * (call - 77 175) (call * 178 52)))))
      error1.4)))
(check-by-interp
 '(module
    (define L.fun/void9976.4 (lambda () (void)))
    (define L.fun/pair9973.5 (lambda () (call cons 169 431)))
    (define L.fun/empty9975.6 (lambda () empty))
    (define L.fun/void9974.7 (lambda () (void)))
    (define L.fun/ascii-char9977.8 (lambda () #\Q))
    (let ((pair0.5 (call L.fun/pair9973.5))
          (void1.4 (call L.fun/void9974.7))
          (empty2.3 (call L.fun/empty9975.6))
          (void3.2 (call L.fun/void9976.4))
          (fixnum4.1
           (call
            -
            (call + (call + 201 161) (call - 249 191))
            (call + (call - 86 144) (call * 131 231)))))
      (call L.fun/ascii-char9977.8))))
(check-by-interp
 '(module
    (define L.fun/void10025.4 (lambda () (void)))
    (define L.fun/empty10007.5
      (lambda (oprand0.5 oprand1.4 oprand2.3 oprand3.2 oprand4.1) oprand4.1))
    (define L.fun/error10022.6 (lambda () (error 88)))
    (define L.fun/error10016.7
      (lambda (oprand0.10 oprand1.9 oprand2.8 oprand3.7 oprand4.6)
        (call L.fun/error10017.22)))
    (define L.fun/error10027.8 (lambda () (error 10)))
    (define L.fun/ascii-char10015.9 (lambda () #\l))
    (define L.fun/void10011.10 (lambda () (void)))
    (define L.fun/vector10023.11 (lambda () (call make-vector 8)))
    (define L.fun/error10012.12 (lambda () (error 62)))
    (define L.fun/boolean10006.13
      (lambda (oprand0.15 oprand1.14 oprand2.13 oprand3.12 oprand4.11) #f))
    (define L.fun/empty10010.14 (lambda () empty))
    (define L.fun/void10005.15
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17 oprand4.16) (void)))
    (define L.fun/error10014.16 (lambda () (error 179)))
    (define L.fun/ascii-char10009.17
      (lambda (oprand0.25 oprand1.24 oprand2.23 oprand3.22 oprand4.21) #\w))
    (define L.fun/void10026.18 (lambda () (void)))
    (define L.fun/pair10013.19 (lambda () (call cons 111 431)))
    (define L.fun/fixnum10021.20
      (lambda (oprand0.30 oprand1.29 oprand2.28 oprand3.27 oprand4.26) 68))
    (define L.fun/ascii-char10018.21
      (lambda (oprand0.35 oprand1.34 oprand2.33 oprand3.32 oprand4.31) #\E))
    (define L.fun/error10017.22 (lambda () (error 10)))
    (define L.fun/any10019.23
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37 oprand4.36) (void)))
    (define L.fun/vector10003.24
      (lambda (oprand0.45 oprand1.44 oprand2.43 oprand3.42 oprand4.41)
        oprand3.42))
    (define L.fun/empty10020.25
      (lambda (oprand0.50 oprand1.49 oprand2.48 oprand3.47 oprand4.46) empty))
    (define L.fun/void10004.26
      (lambda (oprand0.55 oprand1.54 oprand2.53 oprand3.52 oprand4.51)
        oprand1.54))
    (define L.fun/error10008.27
      (lambda (oprand0.60 oprand1.59 oprand2.58 oprand3.57 oprand4.56)
        (error 184)))
    (define L.fun/any10024.28 (lambda () #f))
    (if (if (let ((boolean0.66 #f)
                  (boolean1.65 #t)
                  (ascii-char2.64 #\t)
                  (fixnum3.63 182)
                  (pair4.62 (call cons 174 413))
                  (empty5.61 empty))
              boolean0.66)
          (let ((boolean0.72 #f)
                (ascii-char1.71 #\a)
                (vector2.70 (call make-vector 8))
                (boolean3.69 #f)
                (pair4.68 (call cons 12 415))
                (boolean5.67 #f))
            boolean5.67)
          (call vector? (if #t (error 168) empty)))
      (call
       L.fun/vector10003.24
       (if (call vector? 66)
         (let ((error0.78 (error 98))
               (void1.77 (void))
               (ascii-char2.76 #\s)
               (fixnum3.75 28)
               (empty4.74 empty)
               (pair5.73 (call cons 252 318)))
           (void))
         (call L.fun/void10004.26 (error 58) (void) 96 #\S #t))
       (call
        L.fun/void10005.15
        (call
         L.fun/boolean10006.13
         (let ((empty0.84 empty)
               (ascii-char1.83 #\a)
               (boolean2.82 #f)
               (void3.81 (void))
               (boolean4.80 #t)
               (fixnum5.79 253))
           121)
         (call
          L.fun/vector10003.24
          (void)
          (void)
          empty
          (call make-vector 8)
          (error 12))
         (call
          L.fun/vector10003.24
          (void)
          (void)
          empty
          (call make-vector 8)
          (error 13))
         (if #t #t #t)
         (call L.fun/empty10007.5 55 #f #f #t empty))
        (call
         L.fun/error10008.27
         (call
          L.fun/ascii-char10009.17
          (call make-vector 8)
          empty
          (error 106)
          (error 9)
          #t)
         (if #f #\B #\G)
         (call pair? (error 74))
         (if #t (error 171) (error 207))
         (call L.fun/void10005.15 #t (error 248) #\J #\r empty))
        (if #f #\K #\O)
        (if #f #\m #\I)
        (let ((empty0.90 empty)
              (fixnum1.89 141)
              (void2.88 (void))
              (pair3.87 (call cons 136 386))
              (ascii-char4.86 #\I)
              (error5.85 (error 3)))
          empty))
       (let ((fixnum0.96 (call * 50 156))
             (fixnum1.95 (call - 32 194))
             (empty2.94 (call L.fun/empty10010.14))
             (boolean3.93 (call empty? (error 36)))
             (vector4.92
              (call
               L.fun/vector10003.24
               (void)
               (void)
               empty
               (call make-vector 8)
               (error 224)))
             (fixnum5.91 (call + 209 141)))
         empty2.94)
       (let ((void0.102 (call L.fun/void10011.10))
             (fixnum1.101 (call + 244 237))
             (error2.100 (call L.fun/error10012.12))
             (pair3.99 (call L.fun/pair10013.19))
             (error4.98 (call L.fun/error10014.16))
             (ascii-char5.97 (call L.fun/ascii-char10015.9)))
         (call
          L.fun/vector10003.24
          (void)
          void0.102
          empty
          (call make-vector 8)
          (error 10)))
       (call
        L.fun/error10016.7
        (call
         L.fun/ascii-char10018.21
         (if #f (error 90) (error 21))
         (if #t (void) (void))
         (if #t (call cons 35 309) (call cons 234 379))
         (if #f (void) (void))
         (call
          L.fun/vector10003.24
          (void)
          (void)
          empty
          (call make-vector 8)
          (error 2)))
        (call
         error?
         (let ((vector0.108 (call make-vector 8))
               (void1.107 (void))
               (pair2.106 (call cons 204 423))
               (fixnum3.105 129)
               (error4.104 (error 125))
               (empty5.103 empty))
           (error 225)))
        (let ((boolean0.114 #f)
              (fixnum1.113 21)
              (boolean2.112 #t)
              (void3.111 (void))
              (empty4.110 empty)
              (ascii-char5.109 #\m))
          #t)
        (call empty? (call L.fun/any10019.23 (void) 47 #\t 253 empty))
        (call
         L.fun/empty10020.25
         (call
          L.fun/vector10003.24
          (void)
          (void)
          empty
          (call make-vector 8)
          (error 193))
         (if #f (call cons 236 504) (call cons 171 318))
         (let ((vector0.120 (call make-vector 8))
               (boolean1.119 #t)
               (ascii-char2.118 #\G)
               (void3.117 (void))
               (vector4.116 (call make-vector 8))
               (error5.115 (error 165)))
           #t)
         (let ((boolean0.126 #t)
               (void1.125 (void))
               (void2.124 (void))
               (pair3.123 (call cons 225 345))
               (fixnum4.122 3)
               (boolean5.121 #t))
           void1.125)
         (call
          L.fun/fixnum10021.20
          #t
          (call make-vector 8)
          #\`
          (call cons 5 279)
          (call make-vector 8)))))
      (let ((error0.132 (call L.fun/error10022.6))
            (vector1.131 (call L.fun/vector10023.11))
            (boolean2.130 (call fixnum? (call L.fun/any10024.28)))
            (void3.129 (call L.fun/void10025.4))
            (void4.128 (call L.fun/void10026.18))
            (error5.127 (call L.fun/error10027.8)))
        vector1.131))))
(check-by-interp
 '(module
    (define L.fun/empty10115.4 (lambda () (call L.fun/empty10116.9)))
    (define L.fun/vector10109.5 (lambda () (call make-vector 8)))
    (define L.fun/pair10110.6 (lambda () (call L.fun/pair10111.11)))
    (define L.fun/vector10108.7 (lambda () (call L.fun/vector10109.5)))
    (define L.fun/void10114.8 (lambda () (void)))
    (define L.fun/empty10116.9 (lambda () empty))
    (define L.fun/void10113.10 (lambda () (call L.fun/void10114.8)))
    (define L.fun/pair10111.11 (lambda () (call cons 160 312)))
    (define L.fun/any10112.12 (lambda () #\m))
    (let ((vector0.6 (call L.fun/vector10108.7))
          (pair1.5 (call L.fun/pair10110.6))
          (boolean2.4 (call ascii-char? (call L.fun/any10112.12)))
          (void3.3 (call L.fun/void10113.10))
          (fixnum4.2
           (call
            *
            (call
             +
             (call - (call + 239 41) (call * 154 74))
             (call * (call + 90 233) (call + 134 135)))
            (call
             *
             (call * (call - 199 237) (call - 5 101))
             (call * (call * 238 188) (call - 67 110)))))
          (empty5.1 (call L.fun/empty10115.4)))
      empty5.1)))
(check-by-interp
 '(module
    (define L.fun/any10407.4 (lambda () (call cons 113 268)))
    (define L.fun/empty10406.5 (lambda () empty))
    (define L.fun/empty10405.6 (lambda () (call L.fun/empty10406.5)))
    (define L.fun/pair10412.7 (lambda () (call L.fun/pair10413.16)))
    (define L.fun/vector10414.8 (lambda () (call L.fun/vector10415.13)))
    (define L.fun/ascii-char10408.9
      (lambda () (call L.fun/ascii-char10409.11)))
    (define L.fun/pair10410.10 (lambda () (call L.fun/pair10411.14)))
    (define L.fun/ascii-char10409.11 (lambda () #\I))
    (define L.fun/void10404.12 (lambda () (void)))
    (define L.fun/vector10415.13 (lambda () (call make-vector 8)))
    (define L.fun/pair10411.14 (lambda () (call cons 170 493)))
    (define L.fun/void10403.15 (lambda () (call L.fun/void10404.12)))
    (define L.fun/pair10413.16 (lambda () (call cons 144 500)))
    (let ((void0.6 (call L.fun/void10403.15))
          (empty1.5 (call L.fun/empty10405.6))
          (boolean2.4 (call void? (call L.fun/any10407.4)))
          (ascii-char3.3 (call L.fun/ascii-char10408.9))
          (pair4.2 (call L.fun/pair10410.10))
          (pair5.1 (call L.fun/pair10412.7)))
      (call L.fun/vector10414.8))))
(check-by-interp
 '(module
    (define L.fun/any11347.4
      (lambda (oprand0.5 oprand1.4 oprand2.3 oprand3.2 oprand4.1)
        (call L.fun/any11348.25)))
    (define L.fun/error11352.5 (lambda () (error 228)))
    (define L.fun/ascii-char11360.6 (lambda () #\l))
    (define L.fun/empty11356.7 (lambda () empty))
    (define L.fun/error11364.8
      (lambda (oprand0.10 oprand1.9 oprand2.8 oprand3.7 oprand4.6) oprand1.9))
    (define L.fun/ascii-char11354.9 (lambda () #\]))
    (define L.fun/pair11349.10 (lambda () (call cons 212 446)))
    (define L.fun/pair11363.11
      (lambda (oprand0.15 oprand1.14 oprand2.13 oprand3.12 oprand4.11)
        (call cons 240 402)))
    (define L.fun/void11369.12 (lambda () (void)))
    (define L.fun/void11357.13 (lambda () (void)))
    (define L.fun/error11367.14 (lambda () (error 248)))
    (define L.fun/pair11351.15 (lambda () (call cons 68 315)))
    (define L.fun/vector11362.16 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char11365.17
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17 oprand4.16) #\g))
    (define L.fun/pair11353.18 (lambda () (call cons 249 433)))
    (define L.fun/void11350.19 (lambda () (void)))
    (define L.fun/vector11368.20 (lambda () (call make-vector 8)))
    (define L.fun/empty11355.21 (lambda () empty))
    (define L.fun/pair11358.22 (lambda () (call cons 75 441)))
    (define L.fun/vector11366.23 (lambda () (call make-vector 8)))
    (define L.fun/pair11359.24 (lambda () (call cons 157 386)))
    (define L.fun/any11348.25 (lambda () #t))
    (define L.fun/empty11361.26 (lambda () empty))
    (call
     boolean?
     (call
      L.fun/any11347.4
      (let ((pair0.26 (call L.fun/pair11349.10))
            (void1.25 (call L.fun/void11350.19))
            (pair2.24 (call L.fun/pair11351.15))
            (fixnum3.23 (call + (call + 115 132) (call - 210 141)))
            (error4.22 (call L.fun/error11352.5))
            (pair5.21 (call L.fun/pair11353.18)))
        (call cdr pair0.26))
      (let ((fixnum0.32 (call + (call + 122 193) (call * 55 87)))
            (ascii-char1.31 (call L.fun/ascii-char11354.9))
            (empty2.30 (call L.fun/empty11355.21))
            (fixnum3.29 (call - (call * 75 2) (call - 152 154)))
            (boolean4.28
             (call
              void?
              (call
               L.fun/any11347.4
               213
               empty
               (call make-vector 8)
               (call cons 74 358)
               #t)))
            (empty5.27 (call L.fun/empty11356.7)))
        empty2.30)
      (let ((fixnum0.38 (call * (call * 128 159) (call + 130 217)))
            (void1.37 (call L.fun/void11357.13))
            (pair2.36 (call L.fun/pair11358.22))
            (pair3.35 (call L.fun/pair11359.24))
            (ascii-char4.34 (call L.fun/ascii-char11360.6))
            (empty5.33 (call L.fun/empty11361.26)))
        (call L.fun/vector11362.16))
      (if (let ((vector0.44 (call make-vector 8))
                (boolean1.43 #f)
                (void2.42 (void))
                (ascii-char3.41 #\\)
                (boolean4.40 #t)
                (boolean5.39 #t))
            #f)
        (call
         L.fun/pair11363.11
         (if #f 113 14)
         (if #f 29 188)
         (call
          L.fun/error11364.8
          (call cons 11 396)
          (error 53)
          #t
          (call cons 44 488)
          (void))
         (call
          L.fun/ascii-char11365.17
          (error 210)
          171
          (void)
          (call make-vector 8)
          empty)
         (let ((fixnum0.50 215)
               (void1.49 (void))
               (fixnum2.48 206)
               (pair3.47 (call cons 153 366))
               (pair4.46 (call cons 197 396))
               (ascii-char5.45 #\`))
           (void)))
        (let ((boolean0.56 #t)
              (pair1.55 (call cons 225 269))
              (fixnum2.54 224)
              (void3.53 (void))
              (pair4.52 (call cons 70 411))
              (empty5.51 empty))
          (call cons 121 324)))
      (let ((vector0.62 (call L.fun/vector11366.23))
            (error1.61 (call L.fun/error11367.14))
            (vector2.60 (call L.fun/vector11368.20))
            (boolean3.59
             (call
              ascii-char?
              (call
               L.fun/any11347.4
               244
               empty
               (call make-vector 8)
               (call cons 229 380)
               #t)))
            (void4.58 (call L.fun/void11369.12))
            (fixnum5.57 (call - (call + 14 181) (call * 18 156))))
        (call
         vector?
         (call
          L.fun/any11347.4
          fixnum5.57
          empty
          (call make-vector 8)
          (call cons 31 268)
          #t)))))))
(check-by-interp
 '(module
    (define L.fun/error11905.4 (lambda () (error 59)))
    (define L.fun/vector11903.5 (lambda () (call make-vector 8)))
    (define L.fun/any11899.6 (lambda () (call make-vector 8)))
    (define L.fun/empty11898.7 (lambda () empty))
    (define L.fun/empty11894.8 (lambda () empty))
    (define L.fun/empty11897.9 (lambda () (call L.fun/empty11898.7)))
    (define L.fun/vector11896.10 (lambda () (call make-vector 8)))
    (define L.fun/vector11895.11 (lambda () (call L.fun/vector11896.10)))
    (define L.fun/error11904.12 (lambda () (call L.fun/error11905.4)))
    (define L.fun/empty11893.13 (lambda () (call L.fun/empty11894.8)))
    (define L.fun/void11901.14 (lambda () (void)))
    (define L.fun/void11900.15 (lambda () (call L.fun/void11901.14)))
    (define L.fun/vector11902.16 (lambda () (call L.fun/vector11903.5)))
    (let ((empty0.6 (call L.fun/empty11893.13))
          (vector1.5 (call L.fun/vector11895.11))
          (empty2.4 (call L.fun/empty11897.9))
          (boolean3.3 (call error? (call L.fun/any11899.6)))
          (void4.2 (call L.fun/void11900.15))
          (vector5.1 (call L.fun/vector11902.16)))
      (call L.fun/error11904.12))))
(check-by-interp
 '(module
    (define L.fun/any12205.4 (lambda () #\e))
    (define L.fun/vector12204.5 (lambda () (call make-vector 8)))
    (define L.fun/any12202.6 (lambda () 242))
    (define L.fun/vector12203.7 (lambda () (call L.fun/vector12204.5)))
    (define L.fun/pair12209.8 (lambda () (call cons 249 403)))
    (define L.fun/ascii-char12206.9
      (lambda () (call L.fun/ascii-char12207.10)))
    (define L.fun/ascii-char12207.10 (lambda () #\q))
    (define L.fun/pair12208.11 (lambda () (call L.fun/pair12209.8)))
    (let ((fixnum0.6
           (call
            -
            (call
             *
             (call * (call - 248 141) (call * 17 30))
             (call * (call - 147 52) (call + 25 74)))
            (call
             *
             (call - (call - 14 236) (call * 44 66))
             (call - (call * 79 97) (call * 194 118)))))
          (fixnum1.5
           (call
            -
            (call
             -
             (call * (call - 139 248) (call * 147 21))
             (call * (call * 227 189) (call * 112 182)))
            (call
             *
             (call + (call - 144 151) (call + 149 49))
             (call * (call * 148 163) (call - 15 123)))))
          (boolean2.4 (call empty? (call L.fun/any12202.6)))
          (vector3.3 (call L.fun/vector12203.7))
          (boolean4.2 (call pair? (call L.fun/any12205.4)))
          (ascii-char5.1 (call L.fun/ascii-char12206.9)))
      (call L.fun/pair12208.11))))
(check-by-interp
 '(module
    (define L.fun/ascii-char12743.4 (lambda () #\K))
    (define L.fun/void12745.5 (lambda () (void)))
    (define L.fun/ascii-char12742.6 (lambda () (call L.fun/ascii-char12743.4)))
    (define L.fun/void12744.7 (lambda () (call L.fun/void12745.5)))
    (define L.fun/vector12746.8 (lambda () (call L.fun/vector12747.11)))
    (define L.fun/empty12749.9 (lambda () empty))
    (define L.fun/empty12748.10 (lambda () (call L.fun/empty12749.9)))
    (define L.fun/vector12747.11 (lambda () (call make-vector 8)))
    (let ((fixnum0.6
           (call
            -
            (call
             -
             (call + (call - 245 221) (call - 241 54))
             (call + (call - 88 57) (call - 120 178)))
            (call
             +
             (call * (call - 229 77) (call - 182 171))
             (call + (call - 19 198) (call * 72 115)))))
          (fixnum1.5
           (call
            *
            (call
             +
             (call + (call + 154 89) (call + 28 42))
             (call * (call * 162 152) (call * 87 61)))
            (call
             -
             (call * (call - 102 32) (call * 120 228))
             (call - (call - 76 122) (call + 95 176)))))
          (ascii-char2.4 (call L.fun/ascii-char12742.6))
          (void3.3 (call L.fun/void12744.7))
          (vector4.2 (call L.fun/vector12746.8))
          (empty5.1 (call L.fun/empty12748.10)))
      empty5.1)))
(check-by-interp
 '(module
    (define L.fun/ascii-char13664.4 (lambda () (call L.fun/ascii-char13665.5)))
    (define L.fun/ascii-char13665.5 (lambda () #\`))
    (define L.fun/vector13666.6 (lambda () (call L.fun/vector13667.14)))
    (define L.fun/void13672.7 (lambda () (call L.fun/void13673.12)))
    (define L.fun/empty13674.8 (lambda () (call L.fun/empty13675.9)))
    (define L.fun/empty13675.9 (lambda () empty))
    (define L.fun/void13668.10 (lambda () (call L.fun/void13669.11)))
    (define L.fun/void13669.11 (lambda () (void)))
    (define L.fun/void13673.12 (lambda () (void)))
    (define L.fun/error13670.13 (lambda () (call L.fun/error13671.15)))
    (define L.fun/vector13667.14 (lambda () (call make-vector 8)))
    (define L.fun/error13671.15 (lambda () (error 98)))
    (let ((ascii-char0.6 (call L.fun/ascii-char13664.4))
          (vector1.5 (call L.fun/vector13666.6))
          (void2.4 (call L.fun/void13668.10))
          (error3.3 (call L.fun/error13670.13))
          (void4.2 (call L.fun/void13672.7))
          (empty5.1 (call L.fun/empty13674.8)))
      vector1.5)))
(check-by-interp
 '(module
    (define L.fun/pair14188.4 (lambda () (call cons 8 274)))
    (define L.fun/void14192.5 (lambda () (void)))
    (define L.fun/vector14189.6 (lambda () (call L.fun/vector14190.12)))
    (define L.fun/ascii-char14196.7 (lambda () #\Z))
    (define L.fun/empty14197.8 (lambda () (call L.fun/empty14198.13)))
    (define L.fun/void14191.9 (lambda () (call L.fun/void14192.5)))
    (define L.fun/pair14187.10 (lambda () (call L.fun/pair14188.4)))
    (define L.fun/ascii-char14195.11
      (lambda () (call L.fun/ascii-char14196.7)))
    (define L.fun/vector14190.12 (lambda () (call make-vector 8)))
    (define L.fun/empty14198.13 (lambda () empty))
    (define L.fun/void14194.14 (lambda () (void)))
    (define L.fun/void14193.15 (lambda () (call L.fun/void14194.14)))
    (let ((pair0.6 (call L.fun/pair14187.10))
          (vector1.5 (call L.fun/vector14189.6))
          (void2.4 (call L.fun/void14191.9))
          (void3.3 (call L.fun/void14193.15))
          (ascii-char4.2 (call L.fun/ascii-char14195.11))
          (empty5.1 (call L.fun/empty14197.8)))
      (call + (call vector-ref vector1.5 5) (call vector-length vector1.5)))))
(check-by-interp
 '(module
    (define L.fun/empty14713.4 (lambda () empty))
    (define L.fun/vector14720.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char14714.6 (lambda () (call L.fun/ascii-char14715.9)))
    (define L.fun/ascii-char14717.7
      (lambda () (call L.fun/ascii-char14718.10)))
    (define L.fun/any14716.8 (lambda () #t))
    (define L.fun/ascii-char14715.9 (lambda () #\j))
    (define L.fun/ascii-char14718.10 (lambda () #\o))
    (define L.fun/empty14712.11 (lambda () (call L.fun/empty14713.4)))
    (define L.fun/vector14719.12 (lambda () (call L.fun/vector14720.5)))
    (let ((empty0.6 (call L.fun/empty14712.11))
          (ascii-char1.5 (call L.fun/ascii-char14714.6))
          (fixnum2.4
           (call
            *
            (call
             +
             (call * (call + 246 87) (call * 74 54))
             (call * (call + 198 251) (call + 38 247)))
            (call
             -
             (call + (call * 99 174) (call + 96 153))
             (call + (call * 58 47) (call - 179 65)))))
          (boolean3.3 (call vector? (call L.fun/any14716.8)))
          (ascii-char4.2 (call L.fun/ascii-char14717.7))
          (fixnum5.1
           (call
            +
            (call
             +
             (call - (call * 154 233) (call - 42 209))
             (call + (call + 128 187) (call * 155 107)))
            (call
             -
             (call - (call - 180 33) (call + 187 154))
             (call * (call * 210 35) (call - 19 61))))))
      (call L.fun/vector14719.12))))
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
    (define L.fun/void17549.4 (lambda () (call L.fun/void17550.7)))
    (define L.fun/vector17544.5 (lambda () (call make-vector 8)))
    (define L.fun/vector17543.6 (lambda () (call L.fun/vector17544.5)))
    (define L.fun/void17550.7 (lambda () (void)))
    (define L.fun/void17545.8 (lambda () (call L.fun/void17546.9)))
    (define L.fun/void17546.9 (lambda () (void)))
    (define L.fun/void17554.10 (lambda () (void)))
    (define L.fun/error17548.11 (lambda () (error 76)))
    (define L.fun/pair17552.12 (lambda () (call cons 144 258)))
    (define L.fun/pair17551.13 (lambda () (call L.fun/pair17552.12)))
    (define L.fun/error17547.14 (lambda () (call L.fun/error17548.11)))
    (define L.fun/void17553.15 (lambda () (call L.fun/void17554.10)))
    (let ((vector0.6 (call L.fun/vector17543.6))
          (void1.5 (call L.fun/void17545.8))
          (error2.4 (call L.fun/error17547.14))
          (void3.3 (call L.fun/void17549.4))
          (pair4.2 (call L.fun/pair17551.13))
          (void5.1 (call L.fun/void17553.15)))
      pair4.2)))
(check-by-interp
 '(module
    (define L.fun/error17563.4 (lambda () (call L.fun/error17564.11)))
    (define L.fun/pair17566.5 (lambda () (call cons 27 345)))
    (define L.fun/empty17562.6 (lambda () empty))
    (define L.fun/ascii-char17557.7 (lambda () (call L.fun/ascii-char17558.9)))
    (define L.fun/empty17561.8 (lambda () (call L.fun/empty17562.6)))
    (define L.fun/ascii-char17558.9 (lambda () #\t))
    (define L.fun/pair17565.10 (lambda () (call L.fun/pair17566.5)))
    (define L.fun/error17564.11 (lambda () (error 133)))
    (define L.fun/vector17559.12 (lambda () (call L.fun/vector17560.13)))
    (define L.fun/vector17560.13 (lambda () (call make-vector 8)))
    (let ((ascii-char0.6 (call L.fun/ascii-char17557.7))
          (vector1.5 (call L.fun/vector17559.12))
          (empty2.4 (call L.fun/empty17561.8))
          (error3.3 (call L.fun/error17563.4))
          (pair4.2 (call L.fun/pair17565.10))
          (fixnum5.1
           (call
            -
            (call
             +
             (call - (call * 228 73) (call - 165 213))
             (call + (call - 109 43) (call + 88 188)))
            (call
             +
             (call - (call * 22 62) (call - 174 198))
             (call * (call - 105 71) (call - 165 145))))))
      pair4.2)))
(check-by-interp
 '(module
    (define L.fun/empty18351.4 (lambda () (call L.fun/empty18352.12)))
    (define L.fun/pair18364.5 (lambda () (call cons 103 380)))
    (define L.fun/vector18362.6 (lambda () (call make-vector 8)))
    (define L.fun/vector18361.7 (lambda () (call L.fun/vector18362.6)))
    (define L.fun/vector18357.8 (lambda () (call L.fun/vector18358.16)))
    (define L.fun/ascii-char18355.9
      (lambda () (call L.fun/ascii-char18356.11)))
    (define L.fun/ascii-char18354.10 (lambda () #\P))
    (define L.fun/ascii-char18356.11 (lambda () #\x))
    (define L.fun/empty18352.12 (lambda () empty))
    (define L.fun/empty18359.13 (lambda () (call L.fun/empty18360.15)))
    (define L.fun/pair18363.14 (lambda () (call L.fun/pair18364.5)))
    (define L.fun/empty18360.15 (lambda () empty))
    (define L.fun/vector18358.16 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char18353.17
      (lambda () (call L.fun/ascii-char18354.10)))
    (let ((empty0.6 (call L.fun/empty18351.4))
          (ascii-char1.5 (call L.fun/ascii-char18353.17))
          (ascii-char2.4 (call L.fun/ascii-char18355.9))
          (vector3.3 (call L.fun/vector18357.8))
          (empty4.2 (call L.fun/empty18359.13))
          (vector5.1 (call L.fun/vector18361.7)))
      (call L.fun/pair18363.14))))
(check-by-interp
 '(module
    (define L.fun/pair18688.4 (lambda () (call L.fun/pair18689.16)))
    (define L.fun/ascii-char18694.5 (lambda () (call L.fun/ascii-char18695.6)))
    (define L.fun/ascii-char18695.6 (lambda () #\P))
    (define L.fun/vector18682.7 (lambda () (call L.fun/vector18683.15)))
    (define L.fun/error18690.8 (lambda () (call L.fun/error18691.12)))
    (define L.fun/vector18686.9 (lambda () (call L.fun/vector18687.17)))
    (define L.fun/empty18692.10 (lambda () (call L.fun/empty18693.13)))
    (define L.fun/error18685.11 (lambda () (error 43)))
    (define L.fun/error18691.12 (lambda () (error 20)))
    (define L.fun/empty18693.13 (lambda () empty))
    (define L.fun/error18684.14 (lambda () (call L.fun/error18685.11)))
    (define L.fun/vector18683.15 (lambda () (call make-vector 8)))
    (define L.fun/pair18689.16 (lambda () (call cons 63 266)))
    (define L.fun/vector18687.17 (lambda () (call make-vector 8)))
    (let ((vector0.6 (call L.fun/vector18682.7))
          (error1.5 (call L.fun/error18684.14))
          (vector2.4 (call L.fun/vector18686.9))
          (pair3.3 (call L.fun/pair18688.4))
          (error4.2 (call L.fun/error18690.8))
          (empty5.1 (call L.fun/empty18692.10)))
      (call L.fun/ascii-char18694.5))))
(check-by-interp
 '(module
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
          (boolean2.4 (call boolean? (call L.fun/any18973.13)))
          (boolean3.3 (call void? (call L.fun/any18974.4)))
          (error4.2 (call L.fun/error18975.11))
          (void5.1 (call L.fun/void18977.5)))
      ascii-char0.6)))
(check-by-interp
 '(module
    (define L.fun/void19100.4 (lambda () (void)))
    (define L.fun/void19096.5 (lambda () (void)))
    (define L.fun/void19099.6 (lambda () (call L.fun/void19100.4)))
    (define L.fun/ascii-char19097.7
      (lambda () (call L.fun/ascii-char19098.13)))
    (define L.fun/void19095.8 (lambda () (call L.fun/void19096.5)))
    (define L.fun/void19091.9 (lambda () (call L.fun/void19092.17)))
    (define L.fun/vector19089.10 (lambda () (call L.fun/vector19090.14)))
    (define L.fun/pair19101.11 (lambda () (call L.fun/pair19102.15)))
    (define L.fun/error19094.12 (lambda () (error 6)))
    (define L.fun/ascii-char19098.13 (lambda () #\]))
    (define L.fun/vector19090.14 (lambda () (call make-vector 8)))
    (define L.fun/pair19102.15 (lambda () (call cons 196 450)))
    (define L.fun/error19093.16 (lambda () (call L.fun/error19094.12)))
    (define L.fun/void19092.17 (lambda () (void)))
    (let ((vector0.6 (call L.fun/vector19089.10))
          (void1.5 (call L.fun/void19091.9))
          (error2.4 (call L.fun/error19093.16))
          (void3.3 (call L.fun/void19095.8))
          (ascii-char4.2 (call L.fun/ascii-char19097.7))
          (void5.1 (call L.fun/void19099.6)))
      (call L.fun/pair19101.11))))
(check-by-interp
 '(module
    (define L.fun/error19110.4 (lambda () (call L.fun/error19111.6)))
    (define L.fun/vector19107.5 (lambda () (call make-vector 8)))
    (define L.fun/error19111.6 (lambda () (error 204)))
    (define L.fun/vector19112.7 (lambda () (call L.fun/vector19113.10)))
    (define L.fun/vector19109.8 (lambda () (call make-vector 8)))
    (define L.fun/any19105.9 (lambda () (void)))
    (define L.fun/vector19113.10 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char19115.11 (lambda () #\S))
    (define L.fun/ascii-char19114.12
      (lambda () (call L.fun/ascii-char19115.11)))
    (define L.fun/vector19108.13 (lambda () (call L.fun/vector19109.8)))
    (define L.fun/vector19106.14 (lambda () (call L.fun/vector19107.5)))
    (let ((boolean0.6 (call empty? (call L.fun/any19105.9)))
          (fixnum1.5
           (call
            -
            (call
             +
             (call + (call - 2 21) (call * 188 227))
             (call - (call * 169 86) (call + 219 238)))
            (call
             *
             (call + (call + 43 93) (call + 65 90))
             (call + (call - 228 180) (call * 166 170)))))
          (vector2.4 (call L.fun/vector19106.14))
          (vector3.3 (call L.fun/vector19108.13))
          (error4.2 (call L.fun/error19110.4))
          (vector5.1 (call L.fun/vector19112.7)))
      (call L.fun/ascii-char19114.12))))
(check-by-interp
 '(module
    (define L.fun/error19375.4 (lambda () (error 21)))
    (define L.fun/empty19379.5 (lambda () empty))
    (define L.fun/error19373.6 (lambda () (error 4)))
    (define L.fun/pair19383.7 (lambda () (call cons 212 381)))
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
    (define L.fun/error20166.4 (lambda () (error 196)))
    (define L.fun/ascii-char20168.5 (lambda () #\k))
    (define L.fun/error20174.6 (lambda () (error 25)))
    (define L.fun/any20172.7 (lambda () empty))
    (define L.fun/ascii-char20170.8 (lambda () #\V))
    (define L.fun/vector20175.9 (lambda () (call make-vector 8)))
    (define L.fun/empty20167.10 (lambda () empty))
    (define L.fun/ascii-char20173.11 (lambda () #\`))
    (define L.fun/any20165.12 (lambda () (call cons 13 307)))
    (define L.fun/void20171.13 (lambda () (void)))
    (define L.fun/any20169.14 (lambda () empty))
    (call
     *
     (let ((boolean0.6 (call ascii-char? (call L.fun/any20165.12)))
           (error1.5 (call L.fun/error20166.4))
           (empty2.4 (call L.fun/empty20167.10))
           (fixnum3.3
            (call
             +
             (call - (call + 98 34) (call * 212 116))
             (call + (call + 154 66) (call + 93 250))))
           (ascii-char4.2 (call L.fun/ascii-char20168.5))
           (boolean5.1 (call empty? (call L.fun/any20169.14))))
       (call * (call - fixnum3.3 (call + 52 80)) fixnum3.3))
     (let ((ascii-char0.12 (call L.fun/ascii-char20170.8))
           (void1.11 (call L.fun/void20171.13))
           (boolean2.10 (call boolean? (call L.fun/any20172.7)))
           (ascii-char3.9 (call L.fun/ascii-char20173.11))
           (error4.8 (call L.fun/error20174.6))
           (vector5.7 (call L.fun/vector20175.9)))
       (call vector-ref vector5.7 6)))))
(check-by-interp
 '(module
    (define L.fun/vector20384.4 (lambda () (call make-vector 8)))
    (define L.fun/void20387.5 (lambda () (call L.fun/void20388.6)))
    (define L.fun/void20388.6 (lambda () (void)))
    (define L.fun/empty20385.7 (lambda () (call L.fun/empty20386.9)))
    (define L.fun/vector20383.8 (lambda () (call L.fun/vector20384.4)))
    (define L.fun/empty20386.9 (lambda () empty))
    (let ((fixnum0.6
           (call
            *
            (call
             +
             (call * (call * 251 156) (call - 116 60))
             (call + (call - 2 160) (call - 236 196)))
            (call
             *
             (call * (call * 41 57) (call - 70 192))
             (call - (call * 7 183) (call - 145 250)))))
          (fixnum1.5
           (call
            *
            (call
             -
             (call - (call + 226 18) (call - 244 238))
             (call - (call * 98 1) (call - 204 105)))
            (call
             -
             (call + (call * 99 147) (call - 100 27))
             (call + (call - 46 14) (call * 158 233)))))
          (vector2.4 (call L.fun/vector20383.8))
          (empty3.3 (call L.fun/empty20385.7))
          (void4.2 (call L.fun/void20387.5))
          (fixnum5.1
           (call
            -
            (call
             +
             (call - (call * 231 162) (call - 127 246))
             (call - (call + 39 180) (call - 51 85)))
            (call
             *
             (call * (call - 62 232) (call - 155 239))
             (call * (call * 50 63) (call - 98 166))))))
      empty3.3)))
(check-by-interp
 '(module
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
            +
            (call
             -
             (call + (call + 150 57) (call + 42 77))
             (call - (call * 44 60) (call - 57 155)))
            (call
             -
             (call * (call + 158 80) (call - 63 50))
             (call - (call + 128 83) (call - 14 117)))))
          (ascii-char2.4 (call L.fun/ascii-char20852.10))
          (fixnum3.3
           (call
            -
            (call
             +
             (call - (call * 47 84) (call * 141 44))
             (call + (call - 170 237) (call + 231 210)))
            (call
             *
             (call - (call + 31 55) (call - 120 244))
             (call + (call + 63 31) (call - 87 221)))))
          (void4.2 (call L.fun/void20854.6))
          (fixnum5.1
           (call
            *
            (call
             -
             (call - (call - 53 194) (call - 158 18))
             (call * (call - 80 157) (call + 89 238)))
            (call
             +
             (call + (call + 135 163) (call * 125 241))
             (call - (call * 215 52) (call - 168 139))))))
      (call boolean? (call L.fun/any20856.7)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char22185.4
      (lambda (oprand0.5 oprand1.4 oprand2.3 oprand3.2 oprand4.1) #\Q))
    (define L.fun/pair22178.5
      (lambda (oprand0.10 oprand1.9 oprand2.8 oprand3.7 oprand4.6) oprand3.7))
    (define L.fun/vector22177.6
      (lambda (oprand0.15 oprand1.14 oprand2.13 oprand3.12 oprand4.11)
        (call make-vector 8)))
    (define L.fun/vector22179.7
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17 oprand4.16)
        (call make-vector 8)))
    (define L.fun/boolean22175.8
      (lambda (oprand0.25 oprand1.24 oprand2.23 oprand3.22 oprand4.21) #f))
    (define L.fun/vector22176.9
      (lambda (oprand0.30 oprand1.29 oprand2.28 oprand3.27 oprand4.26)
        (call make-vector 8)))
    (define L.fun/error22167.10
      (lambda (oprand0.35 oprand1.34 oprand2.33 oprand3.32 oprand4.31)
        oprand1.34))
    (define L.fun/pair22187.11
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37 oprand4.36)
        (call cons 215 428)))
    (define L.fun/any22166.12 (lambda () #f))
    (define L.fun/error22168.13
      (lambda (oprand0.45 oprand1.44 oprand2.43 oprand3.42 oprand4.41)
        (error 72)))
    (define L.fun/pair22182.14
      (lambda (oprand0.50 oprand1.49 oprand2.48 oprand3.47 oprand4.46)
        oprand1.49))
    (define L.fun/error22173.15 (lambda () (error 23)))
    (define L.fun/pair22171.16 (lambda () (call cons 8 426)))
    (define L.fun/boolean22165.17
      (lambda (oprand0.55 oprand1.54 oprand2.53 oprand3.52 oprand4.51)
        (call vector? (call L.fun/any22166.12))))
    (define L.fun/pair22180.18
      (lambda (oprand0.60 oprand1.59 oprand2.58 oprand3.57 oprand4.56)
        (call cons 143 501)))
    (define L.fun/pair22186.19
      (lambda (oprand0.65 oprand1.64 oprand2.63 oprand3.62 oprand4.61)
        oprand2.63))
    (define L.fun/boolean22184.20
      (lambda (oprand0.70 oprand1.69 oprand2.68 oprand3.67 oprand4.66) #t))
    (define L.fun/pair22181.21
      (lambda (oprand0.75 oprand1.74 oprand2.73 oprand3.72 oprand4.71)
        oprand0.75))
    (define L.fun/ascii-char22183.22
      (lambda (oprand0.80 oprand1.79 oprand2.78 oprand3.77 oprand4.76) #\X))
    (define L.fun/error22172.23 (lambda () (error 246)))
    (define L.fun/pair22169.24 (lambda () (call cons 47 307)))
    (define L.fun/empty22174.25 (lambda () empty))
    (define L.fun/void22170.26 (lambda () (void)))
    (if (call
         L.fun/boolean22165.17
         (if (let ((pair0.86 (call cons 144 389))
                   (pair1.85 (call cons 84 410))
                   (void2.84 (void))
                   (fixnum3.83 62)
                   (empty4.82 empty)
                   (vector5.81 (call make-vector 8)))
               #f)
           (call
            L.fun/error22167.10
            #\h
            (error 133)
            empty
            (call cons 83 413)
            (error 67))
           (call
            L.fun/error22168.13
            empty
            (error 119)
            #\J
            (call make-vector 8)
            181))
         (let ((pair0.92 (call L.fun/pair22169.24))
               (void1.91 (call L.fun/void22170.26))
               (pair2.90 (call L.fun/pair22171.16))
               (boolean3.89 (call fixnum? (void)))
               (error4.88 (call L.fun/error22172.23))
               (error5.87 (call L.fun/error22173.15)))
           (call L.fun/empty22174.25))
         (if (call L.fun/boolean22175.8 #t 164 (call make-vector 8) 115 47)
           (let ((ascii-char0.98 #\M)
                 (void1.97 (void))
                 (fixnum2.96 92)
                 (error3.95 (error 104))
                 (empty4.94 empty)
                 (fixnum5.93 90))
             ascii-char0.98)
           (if #t #\F #\_))
         (call
          -
          (call
           -
           (let ((fixnum0.104 148)
                 (void1.103 (void))
                 (error2.102 (error 202))
                 (pair3.101 (call cons 75 325))
                 (vector4.100 (call make-vector 8))
                 (empty5.99 empty))
             1)
           (let ((void0.110 (void))
                 (boolean1.109 #t)
                 (pair2.108 (call cons 252 491))
                 (void3.107 (void))
                 (pair4.106 (call cons 132 269))
                 (ascii-char5.105 #\l))
             227))
          (let ((vector0.116 (call make-vector 8))
                (error1.115 (error 156))
                (vector2.114 (call make-vector 8))
                (empty3.113 empty)
                (vector4.112 (call make-vector 8))
                (boolean5.111 #t))
            145))
         (if (if #f #f #f)
           (call L.fun/vector22176.9 empty empty (void) (void) #t)
           (call
            L.fun/vector22177.6
            (error 218)
            #\m
            (call cons 67 304)
            (call make-vector 8)
            #\T)))
      (if (if #t #t #f)
        (call
         L.fun/pair22178.5
         (let ((vector0.122 (call make-vector 8))
               (error1.121 (error 230))
               (error2.120 (error 153))
               (fixnum3.119 222)
               (error4.118 (error 0))
               (ascii-char5.117 #\V))
           18)
         (call L.fun/vector22179.7 #\S empty (call cons 151 289) 246 (error 1))
         (let ((empty0.128 empty)
               (error1.127 (error 151))
               (error2.126 (error 23))
               (boolean3.125 #f)
               (void4.124 (void))
               (empty5.123 empty))
           error1.127)
         (call L.fun/pair22180.18 177 (void) (void) (void) empty)
         (let ((void0.134 (void))
               (boolean1.133 #t)
               (fixnum2.132 238)
               (boolean3.131 #f)
               (boolean4.130 #f)
               (pair5.129 (call cons 67 261)))
           fixnum2.132))
        (call
         L.fun/pair22181.21
         (call L.fun/pair22182.14 #\w (call cons 186 393) #\W #t (error 186))
         (let ((vector0.140 (call make-vector 8))
               (empty1.139 empty)
               (ascii-char2.138 #\P)
               (ascii-char3.137 #\t)
               (vector4.136 (call make-vector 8))
               (pair5.135 (call cons 119 299)))
           empty1.139)
         (call pair? #t)
         (call
          L.fun/ascii-char22183.22
          (call make-vector 8)
          #f
          (call make-vector 8)
          153
          (call make-vector 8))
         (if #t (error 207) (error 189))))
      (if (call
           L.fun/boolean22184.20
           (if #t (error 49) (error 2))
           (if #f (call cons 161 285) (call cons 46 483))
           (if #f (error 175) (error 52))
           (if #f empty empty)
           (call
            L.fun/ascii-char22185.4
            193
            (void)
            (call make-vector 8)
            117
            (error 49)))
        (if #f (call cons 93 367) (call cons 202 506))
        (call
         L.fun/pair22186.19
         (if #f #t #t)
         (let ((fixnum0.146 31)
               (empty1.145 empty)
               (pair2.144 (call cons 22 364))
               (boolean3.143 #f)
               (void4.142 (void))
               (empty5.141 empty))
           fixnum0.146)
         (call
          L.fun/pair22187.11
          (call cons 129 511)
          #\A
          (call cons 15 385)
          empty
          #t)
         (if #t 218 22)
         (call vector? (void)))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char22195.4 (lambda () #\z))
    (define L.fun/empty22197.5 (lambda () empty))
    (define L.fun/pair22193.6 (lambda () (call cons 80 290)))
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
            +
            (call
             *
             (call - (call + 134 176) (call * 154 98))
             (call - (call * 187 211) (call + 104 103)))
            (call
             -
             (call + (call * 49 110) (call * 39 24))
             (call * (call * 216 72) (call - 20 106))))))
      error0.6)))
(check-by-interp
 '(module
    (define L.fun/void22739.4 (lambda () (call L.fun/void22740.11)))
    (define L.fun/pair22741.5 (lambda () (call L.fun/pair22742.7)))
    (define L.fun/any22736.6 (lambda () #t))
    (define L.fun/pair22742.7 (lambda () (call cons 100 307)))
    (define L.fun/any22743.8 (lambda () (call make-vector 8)))
    (define L.fun/pair22737.9 (lambda () (call L.fun/pair22738.10)))
    (define L.fun/pair22738.10 (lambda () (call cons 70 475)))
    (define L.fun/void22740.11 (lambda () (void)))
    (let ((boolean0.6 (call pair? (call L.fun/any22736.6)))
          (pair1.5 (call L.fun/pair22737.9))
          (void2.4 (call L.fun/void22739.4))
          (pair3.3 (call L.fun/pair22741.5))
          (fixnum4.2
           (call
            -
            (call
             -
             (call + (call * 122 25) (call * 115 55))
             (call + (call + 135 235) (call - 214 169)))
            (call
             -
             (call * (call * 153 240) (call + 62 46))
             (call + (call + 37 164) (call * 33 85)))))
          (boolean5.1 (call error? (call L.fun/any22743.8))))
      pair3.3)))
(check-by-interp
 '(module
    (define L.fun/boolean23291.4
      (lambda (oprand0.5 oprand1.4 oprand2.3 oprand3.2 oprand4.1)
        (call pair? (call L.fun/any23292.6))))
    (define L.fun/ascii-char23324.5
      (lambda (oprand0.10 oprand1.9 oprand2.8 oprand3.7 oprand4.6) #\v))
    (define L.fun/any23292.6 (lambda () (call cons 140 481)))
    (define L.fun/pair23311.7
      (lambda (oprand0.15 oprand1.14 oprand2.13 oprand3.12 oprand4.11)
        oprand4.11))
    (define L.fun/pair23295.8
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17 oprand4.16)
        (call cons 179 422)))
    (define L.fun/void23293.9
      (lambda (oprand0.25 oprand1.24 oprand2.23 oprand3.22 oprand4.21) (void)))
    (define L.fun/pair23303.10 (lambda () (call cons 171 348)))
    (define L.fun/void23308.11
      (lambda (oprand0.30 oprand1.29 oprand2.28 oprand3.27 oprand4.26) (void)))
    (define L.fun/pair23298.12
      (lambda (oprand0.35 oprand1.34 oprand2.33 oprand3.32 oprand4.31)
        (call cons 50 483)))
    (define L.fun/empty23307.13
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37 oprand4.36)
        oprand3.37))
    (define L.fun/empty23314.14
      (lambda (oprand0.45 oprand1.44 oprand2.43 oprand3.42 oprand4.41) empty))
    (define L.fun/fixnum23320.15
      (lambda (oprand0.50 oprand1.49 oprand2.48 oprand3.47 oprand4.46)
        oprand1.49))
    (define L.fun/pair23316.16
      (lambda (oprand0.55 oprand1.54 oprand2.53 oprand3.52 oprand4.51)
        (call cons 33 391)))
    (define L.fun/fixnum23313.17
      (lambda (oprand0.60 oprand1.59 oprand2.58 oprand3.57 oprand4.56) 153))
    (define L.fun/ascii-char23309.18
      (lambda (oprand0.65 oprand1.64 oprand2.63 oprand3.62 oprand4.61)
        oprand4.61))
    (define L.fun/void23321.19 (lambda () (void)))
    (define L.fun/ascii-char23304.20 (lambda () #\a))
    (define L.fun/empty23297.21
      (lambda (oprand0.70 oprand1.69 oprand2.68 oprand3.67 oprand4.66) empty))
    (define L.fun/ascii-char23326.22
      (lambda (oprand0.75 oprand1.74 oprand2.73 oprand3.72 oprand4.71) #\a))
    (define L.fun/ascii-char23325.23
      (lambda (oprand0.80 oprand1.79 oprand2.78 oprand3.77 oprand4.76) #\c))
    (define L.fun/fixnum23323.24
      (lambda (oprand0.85 oprand1.84 oprand2.83 oprand3.82 oprand4.81) 6))
    (define L.fun/empty23301.25 (lambda () empty))
    (define L.fun/void23299.26
      (lambda (oprand0.90 oprand1.89 oprand2.88 oprand3.87 oprand4.86)
        oprand4.86))
    (define L.fun/error23294.27
      (lambda (oprand0.95 oprand1.94 oprand2.93 oprand3.92 oprand4.91)
        (error 184)))
    (define L.fun/vector23302.28 (lambda () (call make-vector 8)))
    (define L.fun/vector23322.29 (lambda () (call make-vector 8)))
    (define L.fun/boolean23318.30
      (lambda (oprand0.100 oprand1.99 oprand2.98 oprand3.97 oprand4.96) #t))
    (define L.fun/empty23306.31
      (lambda (oprand0.105 oprand1.104 oprand2.103 oprand3.102 oprand4.101)
        oprand1.104))
    (define L.fun/empty23305.32
      (lambda (oprand0.110 oprand1.109 oprand2.108 oprand3.107 oprand4.106)
        empty))
    (define L.fun/void23300.33
      (lambda (oprand0.115 oprand1.114 oprand2.113 oprand3.112 oprand4.111)
        (call
         vector-set!
         oprand1.114
         7
         (call vector-set! oprand1.114 7 (error 175)))))
    (define L.fun/boolean23296.34
      (lambda (oprand0.120 oprand1.119 oprand2.118 oprand3.117 oprand4.116)
        #f))
    (define L.fun/pair23310.35
      (lambda (oprand0.125 oprand1.124 oprand2.123 oprand3.122 oprand4.121)
        (call cons 174 508)))
    (define L.fun/boolean23317.36
      (lambda (oprand0.130 oprand1.129 oprand2.128 oprand3.127 oprand4.126)
        #t))
    (define L.fun/boolean23319.37
      (lambda (oprand0.135 oprand1.134 oprand2.133 oprand3.132 oprand4.131)
        oprand2.133))
    (define L.fun/void23312.38
      (lambda (oprand0.140 oprand1.139 oprand2.138 oprand3.137 oprand4.136)
        (void)))
    (define L.fun/empty23315.39
      (lambda (oprand0.145 oprand1.144 oprand2.143 oprand3.142 oprand4.141)
        empty))
    (if (call
         L.fun/boolean23291.4
         (call
          L.fun/void23293.9
          (let ((ascii-char0.151 #\Q)
                (ascii-char1.150 #\\)
                (boolean2.149 #f)
                (pair3.148 (call cons 246 336))
                (error4.147 (error 199))
                (void5.146 (void)))
            9)
          (let ((fixnum0.157 155)
                (fixnum1.156 193)
                (error2.155 (error 6))
                (vector3.154 (call make-vector 8))
                (error4.153 (error 89))
                (pair5.152 (call cons 240 447)))
            pair5.152)
          (let ((ascii-char0.163 #\v)
                (boolean1.162 #t)
                (fixnum2.161 122)
                (vector3.160 (call make-vector 8))
                (void4.159 (void))
                (error5.158 (error 217)))
            (call vector-set! vector3.160 7 #t))
          (call
           L.fun/error23294.27
           (call
            L.fun/pair23295.8
            (void)
            (call cons 6 356)
            #\D
            (call make-vector 8)
            94)
           (call
            L.fun/boolean23296.34
            32
            (call cons 13 357)
            (error 2)
            empty
            #\z)
           (let ((ascii-char0.169 #\V)
                 (error1.168 (error 52))
                 (vector2.167 (call make-vector 8))
                 (error3.166 (error 109))
                 (empty4.165 empty)
                 (fixnum5.164 249))
             vector2.167)
           (call
            L.fun/empty23297.21
            empty
            244
            (call cons 218 427)
            (call cons 186 370)
            #\Q)
           (if #f #\K #\y))
          (call
           L.fun/void23293.9
           (if #t 203 99)
           (call
            L.fun/pair23298.12
            (void)
            #f
            empty
            (call cons 254 355)
            (call cons 50 456))
           (call L.fun/void23299.26 196 217 #t #t (void))
           (let ((empty0.175 empty)
                 (fixnum1.174 142)
                 (vector2.173 (call make-vector 8))
                 (pair3.172 (call cons 56 275))
                 (boolean4.171 #t)
                 (empty5.170 empty))
             (error 179))
           (call
            L.fun/void23300.33
            #t
            (call make-vector 8)
            77
            (call make-vector 8)
            211)))
         (let ((empty0.181 (call L.fun/empty23301.25))
               (fixnum1.180 (call + 50 42))
               (vector2.179 (call L.fun/vector23302.28))
               (boolean3.178 (call error? (error 149)))
               (pair4.177 (call L.fun/pair23303.10))
               (ascii-char5.176 (call L.fun/ascii-char23304.20)))
           (call vector-ref vector2.179 3))
         (if (if #f #f #t)
           (call L.fun/empty23305.32 #\U empty #f (call make-vector 8) #t)
           (call L.fun/empty23306.31 4 empty #f #\W 184))
         (call
          L.fun/empty23307.13
          (let ((void0.187 (void))
                (boolean1.186 #t)
                (void2.185 (void))
                (pair3.184 (call cons 11 477))
                (error4.183 (error 117))
                (ascii-char5.182 #\u))
            boolean1.186)
          (call
           L.fun/void23308.11
           (call L.fun/empty23307.13 #t (void) (call cons 18 438) empty empty)
           (call
            L.fun/ascii-char23309.18
            (error 90)
            (call make-vector 8)
            empty
            112
            #\v)
           (call * 211 155)
           (call
            L.fun/pair23310.35
            empty
            212
            (call make-vector 8)
            (void)
            (call make-vector 8))
           (let ((error0.193 (error 43))
                 (empty1.192 empty)
                 (fixnum2.191 153)
                 (boolean3.190 #t)
                 (pair4.189 (call cons 249 458))
                 (fixnum5.188 41))
             (error 184)))
          (call
           L.fun/pair23311.7
           (call L.fun/void23312.38 empty (error 161) (error 116) (void) 15)
           (call
            L.fun/fixnum23313.17
            (call cons 147 335)
            (call cons 186 469)
            (void)
            (call cons 195 312)
            (error 238))
           (let ((vector0.199 (call make-vector 8))
                 (empty1.198 empty)
                 (ascii-char2.197 #\X)
                 (boolean3.196 #f)
                 (ascii-char4.195 #\z)
                 (ascii-char5.194 #\P))
             (call make-vector 8))
           (if #f #\h #\r)
           (call
            L.fun/pair23311.7
            (void)
            46
            (call make-vector 8)
            #\V
            (call cons 102 475)))
          (call
           L.fun/empty23314.14
           (call boolean? (void))
           (if #t #f #f)
           (if #t 161 51)
           (if #t #\O #\Z)
           (let ((boolean0.205 #t)
                 (vector1.204 (call make-vector 8))
                 (fixnum2.203 113)
                 (ascii-char3.202 #\r)
                 (error4.201 (error 152))
                 (vector5.200 (call make-vector 8)))
             error4.201))
          (call
           L.fun/empty23315.39
           (if #t (call make-vector 8) (call make-vector 8))
           (if #t #t #t)
           (call error? 69)
           (call
            L.fun/pair23316.16
            (void)
            #f
            (error 50)
            (call cons 226 434)
            #f)
           (if #f (void) (void))))
         (if (call L.fun/boolean23317.36 25 (void) #f (call cons 125 354) #\_)
           (call
            L.fun/boolean23318.30
            (error 92)
            (void)
            (call cons 62 458)
            #\x
            (call make-vector 8))
           (let ((boolean0.211 #f)
                 (fixnum1.210 70)
                 (fixnum2.209 118)
                 (vector3.208 (call make-vector 8))
                 (error4.207 (error 20))
                 (boolean5.206 #f))
             boolean0.211)))
      (call
       *
       (if (call
            L.fun/boolean23319.37
            163
            (call cons 153 451)
            #t
            (call make-vector 8)
            135)
         (call - 144 46)
         (if #f 232 245))
       (if (let ((error0.217 (error 147))
                 (vector1.216 (call make-vector 8))
                 (error2.215 (error 122))
                 (vector3.214 (call make-vector 8))
                 (error4.213 (error 104))
                 (fixnum5.212 142))
             #f)
         (let ((ascii-char0.223 #\W)
               (boolean1.222 #t)
               (empty2.221 empty)
               (boolean3.220 #t)
               (vector4.219 (call make-vector 8))
               (error5.218 (error 239)))
           59)
         (call
          L.fun/fixnum23320.15
          156
          204
          empty
          (error 188)
          (call make-vector 8))))
      (call
       +
       (let ((fixnum0.229 (call * 1 28))
             (fixnum1.228 (call - 64 65))
             (boolean2.227 (call pair? (void)))
             (void3.226 (call L.fun/void23321.19))
             (boolean4.225 (call error? #f))
             (vector5.224 (call L.fun/vector23322.29)))
         fixnum1.228)
       (call
        -
        (call
         L.fun/fixnum23323.24
         (call L.fun/ascii-char23324.5 #f (void) (error 26) empty empty)
         (let ((fixnum0.235 162)
               (vector1.234 (call make-vector 8))
               (fixnum2.233 90)
               (void3.232 (void))
               (void4.231 (void))
               (ascii-char5.230 #\]))
           fixnum2.233)
         (call
          L.fun/ascii-char23325.23
          (void)
          (call make-vector 8)
          (call make-vector 8)
          64
          empty)
         (if #t (call cons 35 278) (call cons 54 510))
         (call
          L.fun/ascii-char23326.22
          #f
          (error 50)
          (call cons 206 471)
          (call make-vector 8)
          empty))
        (call
         *
         (let ((empty0.241 empty)
               (vector1.240 (call make-vector 8))
               (ascii-char2.239 #\Z)
               (fixnum3.238 78)
               (fixnum4.237 94)
               (error5.236 (error 117)))
           fixnum4.237)
         (let ((void0.247 (void))
               (vector1.246 (call make-vector 8))
               (pair2.245 (call cons 137 289))
               (void3.244 (void))
               (fixnum4.243 161)
               (ascii-char5.242 #\b))
           fixnum4.243)))))))
(check-by-interp
 '(module
    (define L.fun/void23376.4 (lambda () (void)))
    (define L.fun/empty23372.5 (lambda () empty))
    (define L.fun/vector23370.6 (lambda () (call make-vector 8)))
    (define L.fun/empty23371.7 (lambda () (call L.fun/empty23372.5)))
    (define L.fun/pair23373.8 (lambda () (call L.fun/pair23374.9)))
    (define L.fun/pair23374.9 (lambda () (call cons 24 272)))
    (define L.fun/error23377.10 (lambda () (call L.fun/error23378.11)))
    (define L.fun/error23378.11 (lambda () (error 141)))
    (define L.fun/void23375.12 (lambda () (call L.fun/void23376.4)))
    (define L.fun/vector23369.13 (lambda () (call L.fun/vector23370.6)))
    (let ((vector0.6 (call L.fun/vector23369.13))
          (empty1.5 (call L.fun/empty23371.7))
          (pair2.4 (call L.fun/pair23373.8))
          (fixnum3.3
           (call
            *
            (call
             *
             (call + (call - 1 189) (call - 121 38))
             (call - (call - 58 168) (call - 156 22)))
            (call
             +
             (call + (call + 82 184) (call - 40 186))
             (call - (call + 92 83) (call - 95 174)))))
          (void4.2 (call L.fun/void23375.12))
          (error5.1 (call L.fun/error23377.10)))
      vector0.6)))
(check-by-interp
 '(module
    (define L.fun/pair23550.4 (lambda () (call L.fun/pair23551.8)))
    (define L.fun/void23549.5 (lambda () (void)))
    (define L.fun/void23541.6 (lambda () (call L.fun/void23542.14)))
    (define L.fun/void23548.7 (lambda () (call L.fun/void23549.5)))
    (define L.fun/pair23551.8 (lambda () (call cons 83 484)))
    (define L.fun/error23546.9 (lambda () (call L.fun/error23547.11)))
    (define L.fun/empty23544.10 (lambda () empty))
    (define L.fun/error23547.11 (lambda () (error 210)))
    (define L.fun/any23545.12 (lambda () #f))
    (define L.fun/empty23543.13 (lambda () (call L.fun/empty23544.10)))
    (define L.fun/void23542.14 (lambda () (void)))
    (let ((void0.6 (call L.fun/void23541.6))
          (empty1.5 (call L.fun/empty23543.13))
          (boolean2.4 (call vector? (call L.fun/any23545.12)))
          (fixnum3.3
           (call
            +
            (call
             -
             (call + (call - 181 46) (call - 84 191))
             (call * (call + 226 58) (call - 13 65)))
            (call
             *
             (call + (call * 158 13) (call - 56 56))
             (call + (call + 208 40) (call * 162 14)))))
          (error4.2 (call L.fun/error23546.9))
          (void5.1 (call L.fun/void23548.7)))
      (call L.fun/pair23550.4))))
(check-by-interp
 '(module
    (define L.fun/error23726.4 (lambda () (call L.fun/error23727.6)))
    (define L.fun/vector23729.5 (lambda () (call make-vector 8)))
    (define L.fun/error23727.6 (lambda () (error 82)))
    (define L.fun/empty23724.7 (lambda () (call L.fun/empty23725.12)))
    (define L.fun/vector23728.8 (lambda () (call L.fun/vector23729.5)))
    (define L.fun/ascii-char23732.9
      (lambda () (call L.fun/ascii-char23733.13)))
    (define L.fun/error23731.10 (lambda () (error 34)))
    (define L.fun/error23730.11 (lambda () (call L.fun/error23731.10)))
    (define L.fun/empty23725.12 (lambda () empty))
    (define L.fun/ascii-char23733.13 (lambda () #\i))
    (let ((empty0.6 (call L.fun/empty23724.7))
          (error1.5 (call L.fun/error23726.4))
          (fixnum2.4
           (call
            -
            (call
             -
             (call * (call - 30 13) (call + 169 175))
             (call - (call * 38 206) (call + 91 27)))
            (call
             +
             (call + (call * 81 204) (call + 31 87))
             (call * (call + 159 220) (call + 134 220)))))
          (vector3.3 (call L.fun/vector23728.8))
          (error4.2 (call L.fun/error23730.11))
          (ascii-char5.1 (call L.fun/ascii-char23732.9)))
      ascii-char5.1)))
(check-by-interp
 '(module
    (define L.fun/boolean23920.4
      (lambda (oprand0.5 oprand1.4 oprand2.3 oprand3.2 oprand4.1) oprand4.1))
    (define L.fun/error23940.5
      (lambda (oprand0.10 oprand1.9 oprand2.8 oprand3.7 oprand4.6) oprand3.7))
    (define L.fun/void23930.6
      (lambda (oprand0.15 oprand1.14 oprand2.13 oprand3.12 oprand4.11)
        oprand3.12))
    (define L.fun/empty23932.7
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17 oprand4.16)
        oprand1.19))
    (define L.fun/boolean23917.8
      (lambda (oprand0.25 oprand1.24 oprand2.23 oprand3.22 oprand4.21)
        oprand2.23))
    (define L.fun/error23934.9
      (lambda (oprand0.30 oprand1.29 oprand2.28 oprand3.27 oprand4.26)
        (error 109)))
    (define L.fun/pair23912.10
      (lambda (oprand0.35 oprand1.34 oprand2.33 oprand3.32 oprand4.31)
        oprand2.33))
    (define L.fun/pair23927.11
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37 oprand4.36)
        oprand2.38))
    (define L.fun/empty23936.12
      (lambda (oprand0.45 oprand1.44 oprand2.43 oprand3.42 oprand4.41)
        oprand3.42))
    (define L.fun/empty23915.13
      (lambda (oprand0.50 oprand1.49 oprand2.48 oprand3.47 oprand4.46) empty))
    (define L.fun/any23909.14
      (lambda (oprand0.55 oprand1.54 oprand2.53 oprand3.52 oprand4.51) 209))
    (define L.fun/boolean23922.15
      (lambda (oprand0.60 oprand1.59 oprand2.58 oprand3.57 oprand4.56) #f))
    (define L.fun/empty23928.16
      (lambda (oprand0.65 oprand1.64 oprand2.63 oprand3.62 oprand4.61) empty))
    (define L.fun/boolean23933.17
      (lambda (oprand0.70 oprand1.69 oprand2.68 oprand3.67 oprand4.66) #f))
    (define L.fun/error23911.18
      (lambda (oprand0.75 oprand1.74 oprand2.73 oprand3.72 oprand4.71)
        (error 26)))
    (define L.fun/void23925.19
      (lambda (oprand0.80 oprand1.79 oprand2.78 oprand3.77 oprand4.76)
        oprand4.76))
    (define L.fun/fixnum23910.20
      (lambda (oprand0.85 oprand1.84 oprand2.83 oprand3.82 oprand4.81)
        oprand0.85))
    (define L.fun/boolean23937.21
      (lambda (oprand0.90 oprand1.89 oprand2.88 oprand3.87 oprand4.86) #t))
    (define L.fun/vector23931.22
      (lambda (oprand0.95 oprand1.94 oprand2.93 oprand3.92 oprand4.91)
        (call make-vector 8)))
    (define L.fun/empty23942.23
      (lambda (oprand0.100 oprand1.99 oprand2.98 oprand3.97 oprand4.96) empty))
    (define L.fun/vector23913.24
      (lambda (oprand0.105 oprand1.104 oprand2.103 oprand3.102 oprand4.101)
        (call make-vector 8)))
    (define L.fun/vector23935.25
      (lambda (oprand0.110 oprand1.109 oprand2.108 oprand3.107 oprand4.106)
        (call make-vector 8)))
    (define L.fun/fixnum23924.26
      (lambda (oprand0.115 oprand1.114 oprand2.113 oprand3.112 oprand4.111)
        194))
    (define L.fun/ascii-char23938.27
      (lambda (oprand0.120 oprand1.119 oprand2.118 oprand3.117 oprand4.116)
        #\i))
    (define L.fun/ascii-char23919.28
      (lambda (oprand0.125 oprand1.124 oprand2.123 oprand3.122 oprand4.121)
        #\r))
    (define L.fun/vector23916.29
      (lambda (oprand0.130 oprand1.129 oprand2.128 oprand3.127 oprand4.126)
        oprand4.126))
    (define L.fun/error23921.30
      (lambda (oprand0.135 oprand1.134 oprand2.133 oprand3.132 oprand4.131)
        oprand4.131))
    (define L.fun/pair23918.31
      (lambda (oprand0.140 oprand1.139 oprand2.138 oprand3.137 oprand4.136)
        (call cons 79 406)))
    (define L.fun/vector23939.32
      (lambda (oprand0.145 oprand1.144 oprand2.143 oprand3.142 oprand4.141)
        (call make-vector 8)))
    (define L.fun/void23926.33
      (lambda (oprand0.150 oprand1.149 oprand2.148 oprand3.147 oprand4.146)
        (void)))
    (define L.fun/vector23929.34
      (lambda (oprand0.155 oprand1.154 oprand2.153 oprand3.152 oprand4.151)
        oprand1.154))
    (define L.fun/void23923.35
      (lambda (oprand0.160 oprand1.159 oprand2.158 oprand3.157 oprand4.156)
        (void)))
    (define L.fun/empty23914.36
      (lambda (oprand0.165 oprand1.164 oprand2.163 oprand3.162 oprand4.161)
        empty))
    (define L.fun/void23941.37
      (lambda (oprand0.170 oprand1.169 oprand2.168 oprand3.167 oprand4.166)
        (call
         vector-set!
         oprand3.167
         7
         (call vector-set! oprand3.167 7 empty))))
    (if (call
         boolean?
         (call
          L.fun/any23909.14
          (let ((ascii-char0.176 #\\)
                (ascii-char1.175 #\p)
                (void2.174 (void))
                (pair3.173 (call cons 174 259))
                (ascii-char4.172 #\P)
                (pair5.171 (call cons 210 285)))
            pair3.173)
          (call
           L.fun/fixnum23910.20
           (let ((vector0.182 (call make-vector 8))
                 (vector1.181 (call make-vector 8))
                 (empty2.180 empty)
                 (ascii-char3.179 #\C)
                 (void4.178 (void))
                 (vector5.177 (call make-vector 8)))
             27)
           (if #t (call cons 139 416) (call cons 24 315))
           (let ((fixnum0.188 19)
                 (void1.187 (void))
                 (error2.186 (error 200))
                 (vector3.185 (call make-vector 8))
                 (pair4.184 (call cons 17 272))
                 (ascii-char5.183 #\g))
             empty)
           (call
            L.fun/error23911.18
            (call make-vector 8)
            (void)
            (void)
            #\m
            (call make-vector 8))
           (if #t (void) (void)))
          (if #f #t #f)
          (call
           L.fun/pair23912.10
           (let ((void0.194 (void))
                 (fixnum1.193 187)
                 (pair2.192 (call cons 250 436))
                 (boolean3.191 #t)
                 (boolean4.190 #f)
                 (error5.189 (error 106)))
             (error 216))
           (call L.fun/vector23913.24 (call cons 101 420) (void) #t 170 57)
           (call
            L.fun/pair23912.10
            (error 84)
            (call make-vector 8)
            (call cons 223 339)
            empty
            empty)
           (call
            L.fun/empty23914.36
            (error 84)
            222
            (call make-vector 8)
            171
            #\D)
           (call
            L.fun/empty23915.13
            (void)
            125
            (void)
            #\D
            (call make-vector 8)))
          (let ((error0.200 (error 193))
                (ascii-char1.199 #\[)
                (fixnum2.198 204)
                (void3.197 (void))
                (ascii-char4.196 #\l)
                (void5.195 (void)))
            #\j)))
      (call
       L.fun/vector23916.29
       (call
        L.fun/boolean23917.8
        (let ((ascii-char0.206 #\C)
              (empty1.205 empty)
              (vector2.204 (call make-vector 8))
              (fixnum3.203 141)
              (pair4.202 (call cons 91 308))
              (empty5.201 empty))
          (call make-vector 8))
        (call
         L.fun/pair23918.31
         (call L.fun/ascii-char23919.28 empty (error 60) empty empty (void))
         (call
          L.fun/vector23916.29
          #t
          #\n
          (void)
          (call cons 9 340)
          (call make-vector 8))
         (call
          L.fun/boolean23920.4
          (void)
          (call cons 32 418)
          (call make-vector 8)
          #t
          #f)
         (call
          L.fun/error23921.30
          194
          (call make-vector 8)
          (call cons 83 281)
          (call cons 39 496)
          (error 231))
         (let ((boolean0.212 #t)
               (pair1.211 (call cons 113 284))
               (fixnum2.210 39)
               (empty3.209 empty)
               (fixnum4.208 149)
               (empty5.207 empty))
           #\T))
        (if #f #f #f)
        (call
         L.fun/boolean23922.15
         (call
          L.fun/void23923.35
          (call cons 124 309)
          (error 112)
          #f
          (error 245)
          (call cons 131 489))
         (let ((ascii-char0.218 #\e)
               (empty1.217 empty)
               (fixnum2.216 220)
               (void3.215 (void))
               (boolean4.214 #f)
               (ascii-char5.213 #\p))
           (call cons 86 330))
         (call
          L.fun/fixnum23924.26
          (void)
          empty
          (call make-vector 8)
          (call cons 162 401)
          empty)
         (if #t (error 164) (error 167))
         (if #f #\^ #\X))
        (let ((void0.224 (void))
              (empty1.223 empty)
              (vector2.222 (call make-vector 8))
              (fixnum3.221 29)
              (ascii-char4.220 #\S)
              (vector5.219 (call make-vector 8)))
          (call make-vector 8)))
       (if (if #t #f #f)
         (let ((error0.230 (error 36))
               (empty1.229 empty)
               (vector2.228 (call make-vector 8))
               (empty3.227 empty)
               (fixnum4.226 106)
               (vector5.225 (call make-vector 8)))
           #\c)
         (if #t #\\ #\P))
       (if (let ((fixnum0.236 150)
                 (error1.235 (error 181))
                 (void2.234 (void))
                 (fixnum3.233 77)
                 (error4.232 (error 179))
                 (empty5.231 empty))
             #t)
         (call
          L.fun/void23925.19
          (error 192)
          194
          (call cons 36 416)
          #\w
          (void))
         (call
          L.fun/void23926.33
          (void)
          (error 23)
          #t
          (call cons 0 343)
          empty))
       (call
        L.fun/pair23927.11
        (if #f #t #t)
        (if #f (void) (void))
        (call
         L.fun/pair23927.11
         (if #t #f #t)
         (let ((boolean0.242 #t)
               (fixnum1.241 92)
               (pair2.240 (call cons 246 446))
               (empty3.239 empty)
               (pair4.238 (call cons 222 419))
               (void5.237 (void)))
           (void))
         (let ((empty0.248 empty)
               (boolean1.247 #t)
               (boolean2.246 #f)
               (boolean3.245 #t)
               (error4.244 (error 61))
               (ascii-char5.243 #\M))
           (call cons 25 401))
         (if #t (call make-vector 8) (call make-vector 8))
         (let ((vector0.254 (call make-vector 8))
               (boolean1.253 #t)
               (boolean2.252 #f)
               (pair3.251 (call cons 115 491))
               (fixnum4.250 30)
               (error5.249 (error 49)))
           empty))
        (let ((pair0.260 (call cons 195 450))
              (pair1.259 (call cons 19 299))
              (boolean2.258 #f)
              (empty3.257 empty)
              (boolean4.256 #f)
              (error5.255 (error 148)))
          (call make-vector 8))
        (call
         L.fun/empty23928.16
         (call
          L.fun/vector23916.29
          #t
          #\X
          (void)
          (call cons 9 362)
          (call make-vector 8))
         (let ((boolean0.266 #t)
               (fixnum1.265 10)
               (vector2.264 (call make-vector 8))
               (ascii-char3.263 #\`)
               (error4.262 (error 195))
               (void5.261 (void)))
           #\Y)
         (let ((pair0.272 (call cons 46 417))
               (vector1.271 (call make-vector 8))
               (empty2.270 empty)
               (void3.269 (void))
               (empty4.268 empty)
               (pair5.267 (call cons 149 414)))
           void3.269)
         (if #t (call make-vector 8) (call make-vector 8))
         (if #t (call cons 68 269) (call cons 8 420))))
       (call
        L.fun/vector23916.29
        (let ((ascii-char0.278 #\J)
              (empty1.277 empty)
              (pair2.276 (call cons 63 475))
              (fixnum3.275 189)
              (pair4.274 (call cons 129 455))
              (empty5.273 empty))
          #t)
        (let ((error0.284 (error 195))
              (ascii-char1.283 #\b)
              (fixnum2.282 253)
              (ascii-char3.281 #\t)
              (error4.280 (error 219))
              (boolean5.279 #t))
          #\Z)
        (if #f (void) (void))
        (let ((error0.290 (error 130))
              (boolean1.289 #f)
              (void2.288 (void))
              (void3.287 (void))
              (vector4.286 (call make-vector 8))
              (fixnum5.285 92))
          (call cons 134 323))
        (call
         L.fun/vector23929.34
         (call L.fun/void23930.6 #\[ empty #\r (void) (error 115))
         (call
          L.fun/vector23931.22
          9
          (call cons 229 501)
          empty
          (void)
          (call cons 29 455))
         (let ((pair0.296 (call cons 181 427))
               (vector1.295 (call make-vector 8))
               (boolean2.294 #f)
               (boolean3.293 #f)
               (void4.292 (void))
               (error5.291 (error 173)))
           #\Y)
         (let ((ascii-char0.302 #\z)
               (vector1.301 (call make-vector 8))
               (empty2.300 empty)
               (ascii-char3.299 #\\)
               (pair4.298 (call cons 131 510))
               (ascii-char5.297 #\u))
           (call vector-set! vector1.301 7 empty))
         (call
          L.fun/empty23932.7
          (call make-vector 8)
          empty
          (error 174)
          (call make-vector 8)
          (void)))))
      (if (call
           L.fun/boolean23933.17
           (let ((pair0.308 (call cons 55 384))
                 (void1.307 (void))
                 (fixnum2.306 158)
                 (pair3.305 (call cons 227 390))
                 (error4.304 (error 150))
                 (fixnum5.303 243))
             (call cons 125 399))
           (if #t #\\ #\f)
           (let ((fixnum0.314 101)
                 (pair1.313 (call cons 4 355))
                 (vector2.312 (call make-vector 8))
                 (void3.311 (void))
                 (fixnum4.310 242)
                 (boolean5.309 #t))
             (call vector-set! vector2.312 7 vector2.312))
           (call L.fun/error23934.9 (call cons 238 350) #\I #\c (void) #\I)
           (if #t #\i #\a))
        (call
         L.fun/vector23935.25
         (call
          L.fun/empty23936.12
          empty
          (call make-vector 8)
          (call cons 244 315)
          empty
          (void))
         (call
          L.fun/boolean23937.21
          #\b
          (call make-vector 8)
          empty
          (call cons 186 289)
          (call cons 15 498))
         (let ((error0.320 (error 16))
               (boolean1.319 #t)
               (vector2.318 (call make-vector 8))
               (boolean3.317 #t)
               (fixnum4.316 6)
               (ascii-char5.315 #\j))
           (call vector-set! vector2.318 7 error0.320))
         (let ((empty0.326 empty)
               (empty1.325 empty)
               (ascii-char2.324 #\J)
               (error3.323 (error 11))
               (vector4.322 (call make-vector 8))
               (vector5.321 (call make-vector 8)))
           15)
         (call
          L.fun/ascii-char23938.27
          (void)
          (void)
          empty
          (call cons 232 341)
          78))
        (call
         L.fun/vector23939.32
         (let ((error0.332 (error 193))
               (empty1.331 empty)
               (ascii-char2.330 #\h)
               (pair3.329 (call cons 131 406))
               (ascii-char4.328 #\_)
               (vector5.327 (call make-vector 8)))
           #\^)
         (call
          L.fun/error23940.5
          (call cons 205 284)
          (error 27)
          (call cons 37 279)
          (error 138)
          #\z)
         (call L.fun/void23941.37 154 124 #\L (call make-vector 8) (void))
         (call L.fun/empty23942.23 (call cons 119 492) #\Z (void) #\S #\c)
         (if #t #\C #\N))))))
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
            -
            (call
             -
             (call + (call + 174 139) (call * 138 198))
             (call - (call * 11 128) (call + 85 4)))
            (call
             +
             (call + (call - 206 209) (call * 252 202))
             (call * (call - 130 189) (call + 253 157)))))
          (empty2.4 (call L.fun/empty24787.9))
          (error3.3 (call L.fun/error24789.5))
          (fixnum4.2
           (call
            *
            (call
             -
             (call - (call * 80 76) (call * 11 230))
             (call + (call + 249 251) (call * 79 245)))
            (call
             *
             (call + (call * 93 174) (call * 101 55))
             (call * (call - 171 115) (call - 114 115)))))
          (empty5.1 (call L.fun/empty24791.11)))
      (call
       +
       (call
        +
        (call - (call - 7 fixnum4.2) fixnum4.2)
        (call * fixnum1.5 (call * 18 fixnum1.5)))
       (call - fixnum4.2 fixnum1.5)))))
(check-by-interp
 '(module
    (define L.fun/pair24832.4 (lambda () (call L.fun/pair24833.15)))
    (define L.fun/error24829.5 (lambda () (error 8)))
    (define L.fun/pair24835.6 (lambda () (call L.fun/pair24836.7)))
    (define L.fun/pair24836.7 (lambda () (call cons 130 507)))
    (define L.fun/any24834.8 (lambda () (error 159)))
    (define L.fun/ascii-char24839.9
      (lambda () (call L.fun/ascii-char24840.12)))
    (define L.fun/void24831.10 (lambda () (void)))
    (define L.fun/void24830.11 (lambda () (call L.fun/void24831.10)))
    (define L.fun/ascii-char24840.12 (lambda () #\g))
    (define L.fun/empty24838.13 (lambda () empty))
    (define L.fun/empty24837.14 (lambda () (call L.fun/empty24838.13)))
    (define L.fun/pair24833.15 (lambda () (call cons 232 443)))
    (define L.fun/error24828.16 (lambda () (call L.fun/error24829.5)))
    (let ((error0.6 (call L.fun/error24828.16))
          (void1.5 (call L.fun/void24830.11))
          (pair2.4 (call L.fun/pair24832.4))
          (boolean3.3 (call error? (call L.fun/any24834.8)))
          (pair4.2 (call L.fun/pair24835.6))
          (empty5.1 (call L.fun/empty24837.14)))
      (call L.fun/ascii-char24839.9))))
(check-by-interp
 '(module
    (define L.fun/ascii-char25064.4 (lambda () #\c))
    (define L.fun/error25065.5 (lambda () (call L.fun/error25066.14)))
    (define L.fun/void25061.6 (lambda () (call L.fun/void25062.11)))
    (define L.fun/ascii-char25055.7
      (lambda () (call L.fun/ascii-char25056.10)))
    (define L.fun/ascii-char25063.8 (lambda () (call L.fun/ascii-char25064.4)))
    (define L.fun/void25059.9 (lambda () (call L.fun/void25060.12)))
    (define L.fun/ascii-char25056.10 (lambda () #\i))
    (define L.fun/void25062.11 (lambda () (void)))
    (define L.fun/void25060.12 (lambda () (void)))
    (define L.fun/vector25058.13 (lambda () (call make-vector 8)))
    (define L.fun/error25066.14 (lambda () (error 47)))
    (define L.fun/vector25057.15 (lambda () (call L.fun/vector25058.13)))
    (let ((ascii-char0.6 (call L.fun/ascii-char25055.7))
          (fixnum1.5
           (call
            -
            (call
             +
             (call * (call - 12 154) (call - 27 11))
             (call - (call + 30 92) (call - 55 234)))
            (call
             *
             (call + (call + 206 107) (call + 182 103))
             (call + (call * 101 129) (call + 163 109)))))
          (vector2.4 (call L.fun/vector25057.15))
          (void3.3 (call L.fun/void25059.9))
          (void4.2 (call L.fun/void25061.6))
          (ascii-char5.1 (call L.fun/ascii-char25063.8)))
      (call L.fun/error25065.5))))
(check-by-interp
 '(module
    (define L.fun/empty25901.4 (lambda () empty))
    (define L.fun/vector25907.5 (lambda () (call make-vector 8)))
    (define L.fun/vector25903.6 (lambda () (call make-vector 8)))
    (define L.fun/pair25904.7 (lambda () (call L.fun/pair25905.9)))
    (define L.fun/vector25902.8 (lambda () (call L.fun/vector25903.6)))
    (define L.fun/pair25905.9 (lambda () (call cons 93 378)))
    (define L.fun/empty25900.10 (lambda () (call L.fun/empty25901.4)))
    (define L.fun/vector25906.11 (lambda () (call L.fun/vector25907.5)))
    (let ((empty0.6 (call L.fun/empty25900.10))
          (fixnum1.5
           (call
            +
            (call
             *
             (call + (call * 170 173) (call + 87 229))
             (call - (call * 175 17) (call + 161 185)))
            (call
             +
             (call + (call + 140 122) (call - 114 111))
             (call - (call * 16 50) (call + 168 42)))))
          (fixnum2.4
           (call
            -
            (call
             *
             (call + (call + 118 7) (call - 191 106))
             (call + (call - 31 144) (call * 24 211)))
            (call
             *
             (call - (call + 217 163) (call + 192 243))
             (call - (call + 52 208) (call * 254 145)))))
          (vector3.3 (call L.fun/vector25902.8))
          (pair4.2 (call L.fun/pair25904.7))
          (vector5.1 (call L.fun/vector25906.11)))
      pair4.2)))
(check-by-interp
 '(module
    (define L.fun/vector25980.4 (lambda () (call L.fun/vector25981.8)))
    (define L.fun/void25978.5 (lambda () (call L.fun/void25979.9)))
    (define L.fun/ascii-char25984.6 (lambda () (call L.fun/ascii-char25985.7)))
    (define L.fun/ascii-char25985.7 (lambda () #\Y))
    (define L.fun/vector25981.8 (lambda () (call make-vector 8)))
    (define L.fun/void25979.9 (lambda () (void)))
    (define L.fun/vector25982.10 (lambda () (call L.fun/vector25983.11)))
    (define L.fun/vector25983.11 (lambda () (call make-vector 8)))
    (define L.fun/any25977.12 (lambda () #t))
    (define L.fun/empty25987.13 (lambda () empty))
    (define L.fun/empty25986.14 (lambda () (call L.fun/empty25987.13)))
    (let ((boolean0.6 (call empty? (call L.fun/any25977.12)))
          (void1.5 (call L.fun/void25978.5))
          (vector2.4 (call L.fun/vector25980.4))
          (vector3.3 (call L.fun/vector25982.10))
          (ascii-char4.2 (call L.fun/ascii-char25984.6))
          (empty5.1 (call L.fun/empty25986.14)))
      empty5.1)))
(check-by-interp
 '(module
    (define L.fun/void26351.4 (lambda () (void)))
    (define L.fun/void26350.5 (lambda () (call L.fun/void26351.4)))
    (define L.fun/vector26359.6 (lambda () (call make-vector 8)))
    (define L.fun/vector26358.7 (lambda () (call L.fun/vector26359.6)))
    (define L.fun/pair26355.8 (lambda () (call cons 182 381)))
    (define L.fun/pair26354.9 (lambda () (call L.fun/pair26355.8)))
    (define L.fun/ascii-char26352.10
      (lambda () (call L.fun/ascii-char26353.11)))
    (define L.fun/ascii-char26353.11 (lambda () #\M))
    (define L.fun/vector26357.12 (lambda () (call make-vector 8)))
    (define L.fun/vector26356.13 (lambda () (call L.fun/vector26357.12)))
    (let ((void0.6 (call L.fun/void26350.5))
          (ascii-char1.5 (call L.fun/ascii-char26352.10))
          (pair2.4 (call L.fun/pair26354.9))
          (fixnum3.3
           (call
            +
            (call
             *
             (call + (call * 231 9) (call * 186 153))
             (call * (call - 211 254) (call * 23 59)))
            (call
             +
             (call - (call * 53 35) (call + 84 21))
             (call + (call - 116 114) (call - 57 251)))))
          (vector4.2 (call L.fun/vector26356.13))
          (vector5.1 (call L.fun/vector26358.7)))
      void0.6)))
(check-by-interp
 '(module
    (define L.fun/any26369.4 (lambda () (call cons 41 404)))
    (define L.fun/fixnum26364.5
      (lambda (oprand0.5 oprand1.4 oprand2.3 oprand3.2 oprand4.1) oprand0.5))
    (define L.fun/any26371.6 (lambda () (call cons 185 267)))
    (define L.fun/void26368.7 (lambda () (void)))
    (define L.fun/empty26370.8 (lambda () empty))
    (define L.fun/void26366.9
      (lambda (oprand0.10 oprand1.9 oprand2.8 oprand3.7 oprand4.6)
        (call vector-set! oprand2.8 7 (call vector-set! oprand2.8 7 #t))))
    (define L.fun/boolean26365.10
      (lambda (oprand0.15 oprand1.14 oprand2.13 oprand3.12 oprand4.11) #f))
    (define L.fun/ascii-char26363.11
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17 oprand4.16) #\j))
    (define L.fun/any26372.12 (lambda () (void)))
    (define L.fun/void26367.13
      (lambda (oprand0.25 oprand1.24 oprand2.23 oprand3.22 oprand4.21) (void)))
    (define L.fun/boolean26362.14
      (lambda (oprand0.30 oprand1.29 oprand2.28 oprand3.27 oprand4.26) #f))
    (if (if (call
             L.fun/boolean26362.14
             (if #f 32 152)
             (let ((void0.36 (void))
                   (empty1.35 empty)
                   (empty2.34 empty)
                   (ascii-char3.33 #\e)
                   (empty4.32 empty)
                   (error5.31 (error 249)))
               empty4.32)
             (call
              L.fun/ascii-char26363.11
              (void)
              (error 68)
              (void)
              (call make-vector 8)
              #t)
             (if #f empty empty)
             (call L.fun/fixnum26364.5 129 (error 57) #\t #\[ (void)))
          (let ((pair0.42 (call cons 232 503))
                (boolean1.41 #t)
                (ascii-char2.40 #\^)
                (ascii-char3.39 #\X)
                (fixnum4.38 47)
                (empty5.37 empty))
            boolean1.41)
          (let ((error0.48 (error 205))
                (void1.47 (void))
                (pair2.46 (call cons 107 345))
                (fixnum3.45 138)
                (boolean4.44 #t)
                (error5.43 (error 55)))
            boolean4.44))
      (if (call
           L.fun/boolean26365.10
           (let ((error0.54 (error 125))
                 (error1.53 (error 204))
                 (error2.52 (error 78))
                 (void3.51 (void))
                 (pair4.50 (call cons 58 426))
                 (void5.49 (void)))
             void3.51)
           (if #t (call make-vector 8) (call make-vector 8))
           (call
            L.fun/void26366.9
            #\m
            (call cons 130 490)
            (call make-vector 8)
            #\Z
            empty)
           (call L.fun/void26367.13 10 #\G #\] #t (error 125))
           (if #f empty empty))
        (let ((vector0.60 (call make-vector 8))
              (empty1.59 empty)
              (empty2.58 empty)
              (error3.57 (error 62))
              (vector4.56 (call make-vector 8))
              (ascii-char5.55 #\R))
          112)
        (if #t 65 135))
      (let ((fixnum0.66 (call - (call + 10 194) (call - 182 181)))
            (void1.65 (call L.fun/void26368.7))
            (boolean2.64 (call vector? (call L.fun/any26369.4)))
            (empty3.63 (call L.fun/empty26370.8))
            (boolean4.62 (call boolean? (call L.fun/any26371.6)))
            (boolean5.61 (call empty? (call L.fun/any26372.12))))
        (call - (call * fixnum0.66 53) fixnum0.66)))))
(check-by-interp
 '(module
    (define L.fun/pair26393.4 (lambda () (call cons 65 316)))
    (define L.fun/any26402.5 (lambda () #\H))
    (define L.fun/any26403.6 (lambda () (call cons 34 336)))
    (define L.fun/empty26405.7 (lambda () empty))
    (define L.fun/error26401.8
      (lambda (oprand0.5 oprand1.4 oprand2.3 oprand3.2 oprand4.1) (error 219)))
    (define L.fun/error26390.9 (lambda () (error 130)))
    (define L.fun/vector26406.10 (lambda () (call make-vector 8)))
    (define L.fun/fixnum26399.11
      (lambda (oprand0.10 oprand1.9 oprand2.8 oprand3.7 oprand4.6)
        (call + 29 202)))
    (define L.fun/error26398.12 (lambda () (error 249)))
    (define L.fun/pair26394.13 (lambda () (call cons 235 503)))
    (define L.fun/pair26396.14 (lambda () (call cons 181 273)))
    (define L.fun/void26391.15 (lambda () (void)))
    (define L.fun/empty26400.16
      (lambda (oprand0.15 oprand1.14 oprand2.13 oprand3.12 oprand4.11) empty))
    (define L.fun/error26388.17 (lambda () (error 45)))
    (define L.fun/void26404.18 (lambda () (void)))
    (define L.fun/empty26395.19 (lambda () empty))
    (define L.fun/error26392.20 (lambda () (error 192)))
    (define L.fun/vector26387.21 (lambda () (call make-vector 8)))
    (define L.fun/error26397.22 (lambda () (error 225)))
    (define L.fun/ascii-char26389.23 (lambda () #\k))
    (call
     +
     (if (let ((vector0.21 (call L.fun/vector26387.21))
               (error1.20 (call L.fun/error26388.17))
               (ascii-char2.19 (call L.fun/ascii-char26389.23))
               (error3.18 (call L.fun/error26390.9))
               (void4.17 (call L.fun/void26391.15))
               (error5.16 (call L.fun/error26392.20)))
           (call ascii-char? (error 63)))
       (let ((pair0.27 (call L.fun/pair26393.4))
             (pair1.26 (call L.fun/pair26394.13))
             (empty2.25 (call L.fun/empty26395.19))
             (pair3.24 (call L.fun/pair26396.14))
             (error4.23 (call L.fun/error26397.22))
             (error5.22 (call L.fun/error26398.12)))
         (call car pair0.27))
       (call
        L.fun/fixnum26399.11
        (let ((fixnum0.33 94)
              (vector1.32 (call make-vector 8))
              (error2.31 (error 126))
              (void3.30 (void))
              (empty4.29 empty)
              (pair5.28 (call cons 20 323)))
          #f)
        (let ((error0.39 (error 50))
              (empty1.38 empty)
              (boolean2.37 #t)
              (fixnum3.36 104)
              (void4.35 (void))
              (ascii-char5.34 #\g))
          (void))
        (call
         L.fun/empty26400.16
         (if #f (error 242) (error 81))
         (call boolean? (call make-vector 8))
         (if #t 71 85)
         (call
          L.fun/error26401.8
          182
          (call make-vector 8)
          (error 240)
          185
          (call make-vector 8))
         (if #f (error 27) (error 132)))
        (let ((pair0.45 (call cons 30 419))
              (pair1.44 (call cons 144 340))
              (void2.43 (void))
              (boolean3.42 #t)
              (empty4.41 empty)
              (void5.40 (void)))
          (call make-vector 8))
        (if #t #f #t)))
     (let ((fixnum0.51
            (call
             +
             (call + (call + 115 2) (call - 88 94))
             (call + (call + 242 222) (call - 160 50))))
           (boolean1.50 (call void? (call L.fun/any26402.5)))
           (boolean2.49 (call boolean? (call L.fun/any26403.6)))
           (void3.48 (call L.fun/void26404.18))
           (empty4.47 (call L.fun/empty26405.7))
           (vector5.46 (call L.fun/vector26406.10)))
       (call vector-ref vector5.46 2)))))
(check-by-interp
 '(module
    (define L.fun/vector26761.4 (lambda () (call make-vector 8)))
    (define L.fun/void26753.5 (lambda () (call L.fun/void26754.7)))
    (define L.fun/pair26757.6 (lambda () (call L.fun/pair26758.8)))
    (define L.fun/void26754.7 (lambda () (void)))
    (define L.fun/pair26758.8 (lambda () (call cons 4 411)))
    (define L.fun/ascii-char26764.9
      (lambda () (call L.fun/ascii-char26765.13)))
    (define L.fun/pair26762.10 (lambda () (call L.fun/pair26763.16)))
    (define L.fun/any26759.11 (lambda () (void)))
    (define L.fun/vector26760.12 (lambda () (call L.fun/vector26761.4)))
    (define L.fun/ascii-char26765.13 (lambda () #\o))
    (define L.fun/vector26755.14 (lambda () (call L.fun/vector26756.15)))
    (define L.fun/vector26756.15 (lambda () (call make-vector 8)))
    (define L.fun/pair26763.16 (lambda () (call cons 12 432)))
    (let ((void0.6 (call L.fun/void26753.5))
          (vector1.5 (call L.fun/vector26755.14))
          (pair2.4 (call L.fun/pair26757.6))
          (boolean3.3 (call empty? (call L.fun/any26759.11)))
          (vector4.2 (call L.fun/vector26760.12))
          (pair5.1 (call L.fun/pair26762.10)))
      (call L.fun/ascii-char26764.9))))
(check-by-interp
 '(module
    (define L.fun/empty27006.4 (lambda () (call L.fun/empty27007.9)))
    (define L.fun/pair27009.5 (lambda () (call cons 221 369)))
    (define L.fun/void27004.6 (lambda () (call L.fun/void27005.11)))
    (define L.fun/ascii-char27003.7 (lambda () #\u))
    (define L.fun/pair27008.8 (lambda () (call L.fun/pair27009.5)))
    (define L.fun/empty27007.9 (lambda () empty))
    (define L.fun/ascii-char27002.10
      (lambda () (call L.fun/ascii-char27003.7)))
    (define L.fun/void27005.11 (lambda () (void)))
    (let ((fixnum0.6
           (call
            -
            (call
             +
             (call - (call * 33 185) (call - 157 51))
             (call + (call - 48 176) (call - 252 173)))
            (call
             -
             (call * (call - 21 173) (call * 109 101))
             (call - (call + 70 76) (call - 65 109)))))
          (fixnum1.5
           (call
            *
            (call
             *
             (call + (call + 97 61) (call * 88 171))
             (call + (call - 235 199) (call * 135 228)))
            (call
             -
             (call - (call - 164 225) (call * 99 232))
             (call - (call * 76 51) (call - 2 113)))))
          (ascii-char2.4 (call L.fun/ascii-char27002.10))
          (void3.3 (call L.fun/void27004.6))
          (empty4.2 (call L.fun/empty27006.4))
          (fixnum5.1
           (call
            +
            (call
             *
             (call * (call * 88 6) (call - 181 146))
             (call - (call - 127 98) (call * 30 252)))
            (call
             *
             (call - (call - 62 246) (call + 209 211))
             (call - (call * 110 124) (call - 147 125))))))
      (call L.fun/pair27008.8))))
(check-by-interp
 '(module
    (define L.fun/empty27106.4 (lambda () (call L.fun/empty27107.8)))
    (define L.fun/vector27108.5 (lambda () (call L.fun/vector27109.13)))
    (define L.fun/ascii-char27100.6
      (lambda () (call L.fun/ascii-char27101.15)))
    (define L.fun/error27110.7 (lambda () (call L.fun/error27111.9)))
    (define L.fun/empty27107.8 (lambda () empty))
    (define L.fun/error27111.9 (lambda () (error 175)))
    (define L.fun/ascii-char27104.10
      (lambda () (call L.fun/ascii-char27105.14)))
    (define L.fun/vector27102.11 (lambda () (call L.fun/vector27103.12)))
    (define L.fun/vector27103.12 (lambda () (call make-vector 8)))
    (define L.fun/vector27109.13 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char27105.14 (lambda () #\J))
    (define L.fun/ascii-char27101.15 (lambda () #\c))
    (define L.fun/vector27098.16 (lambda () (call L.fun/vector27099.17)))
    (define L.fun/vector27099.17 (lambda () (call make-vector 8)))
    (let ((vector0.6 (call L.fun/vector27098.16))
          (ascii-char1.5 (call L.fun/ascii-char27100.6))
          (vector2.4 (call L.fun/vector27102.11))
          (ascii-char3.3 (call L.fun/ascii-char27104.10))
          (empty4.2 (call L.fun/empty27106.4))
          (vector5.1 (call L.fun/vector27108.5)))
      (call L.fun/error27110.7))))
(check-by-interp
 '(module
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
            +
            (call
             +
             (call - (call - 76 73) (call - 222 163))
             (call + (call + 182 228) (call + 229 39)))
            (call
             *
             (call * (call - 192 1) (call - 81 114))
             (call + (call + 86 163) (call - 193 137)))))
          (ascii-char5.1 (call L.fun/ascii-char27122.10)))
      (call
       -
       (call
        *
        (call - fixnum4.2 (call * fixnum4.2 241))
        (call + fixnum4.2 (call + 23 fixnum4.2)))
       (call
        -
        (call + (call - 115 114) fixnum4.2)
        (call - (call - 99 219) fixnum4.2))))))
(check-by-interp
 '(module
    (define L.fun/vector27132.4 (lambda () (call L.fun/vector27133.8)))
    (define L.fun/vector27136.5 (lambda () (call L.fun/vector27137.6)))
    (define L.fun/vector27137.6 (lambda () (call make-vector 8)))
    (define L.fun/empty27134.7 (lambda () (call L.fun/empty27135.11)))
    (define L.fun/vector27133.8 (lambda () (call make-vector 8)))
    (define L.fun/void27126.9 (lambda () (call L.fun/void27127.10)))
    (define L.fun/void27127.10 (lambda () (void)))
    (define L.fun/empty27135.11 (lambda () empty))
    (define L.fun/vector27130.12 (lambda () (call L.fun/vector27131.14)))
    (define L.fun/pair27128.13 (lambda () (call L.fun/pair27129.15)))
    (define L.fun/vector27131.14 (lambda () (call make-vector 8)))
    (define L.fun/pair27129.15 (lambda () (call cons 145 464)))
    (let ((void0.6 (call L.fun/void27126.9))
          (pair1.5 (call L.fun/pair27128.13))
          (vector2.4 (call L.fun/vector27130.12))
          (vector3.3 (call L.fun/vector27132.4))
          (empty4.2 (call L.fun/empty27134.7))
          (vector5.1 (call L.fun/vector27136.5)))
      pair1.5)))
(check-by-interp
 '(module
    (define L.fun/pair27447.4 (lambda () (call L.fun/pair27448.11)))
    (define L.fun/ascii-char27445.5
      (lambda () (call L.fun/ascii-char27446.13)))
    (define L.fun/ascii-char27438.6 (lambda () #\G))
    (define L.fun/error27440.7 (lambda () (error 130)))
    (define L.fun/ascii-char27443.8
      (lambda () (call L.fun/ascii-char27444.14)))
    (define L.fun/void27441.9 (lambda () (call L.fun/void27442.12)))
    (define L.fun/error27439.10 (lambda () (call L.fun/error27440.7)))
    (define L.fun/pair27448.11 (lambda () (call cons 186 439)))
    (define L.fun/void27442.12 (lambda () (void)))
    (define L.fun/ascii-char27446.13 (lambda () #\r))
    (define L.fun/ascii-char27444.14 (lambda () #\b))
    (define L.fun/ascii-char27437.15
      (lambda () (call L.fun/ascii-char27438.6)))
    (define L.fun/any27436.16 (lambda () (call cons 186 388)))
    (let ((boolean0.6 (call pair? (call L.fun/any27436.16)))
          (ascii-char1.5 (call L.fun/ascii-char27437.15))
          (error2.4 (call L.fun/error27439.10))
          (void3.3 (call L.fun/void27441.9))
          (ascii-char4.2 (call L.fun/ascii-char27443.8))
          (ascii-char5.1 (call L.fun/ascii-char27445.5)))
      (call L.fun/pair27447.4))))
(check-by-interp
 '(module
    (define L.fun/empty27452.4 (lambda () empty))
    (define L.fun/vector27460.5 (lambda () (call L.fun/vector27461.7)))
    (define L.fun/empty27458.6 (lambda () empty))
    (define L.fun/vector27461.7 (lambda () (call make-vector 8)))
    (define L.fun/empty27457.8 (lambda () (call L.fun/empty27458.6)))
    (define L.fun/ascii-char27462.9
      (lambda () (call L.fun/ascii-char27463.16)))
    (define L.fun/any27459.10 (lambda () (error 3)))
    (define L.fun/empty27455.11 (lambda () (call L.fun/empty27456.15)))
    (define L.fun/pair27454.12 (lambda () (call cons 34 496)))
    (define L.fun/pair27453.13 (lambda () (call L.fun/pair27454.12)))
    (define L.fun/empty27451.14 (lambda () (call L.fun/empty27452.4)))
    (define L.fun/empty27456.15 (lambda () empty))
    (define L.fun/ascii-char27463.16 (lambda () #\j))
    (let ((empty0.6 (call L.fun/empty27451.14))
          (pair1.5 (call L.fun/pair27453.13))
          (empty2.4 (call L.fun/empty27455.11))
          (empty3.3 (call L.fun/empty27457.8))
          (boolean4.2 (call boolean? (call L.fun/any27459.10)))
          (vector5.1 (call L.fun/vector27460.5)))
      (call L.fun/ascii-char27462.9))))
(check-by-interp
 '(module
    (define L.fun/any27714.4 (lambda () (call make-vector 8)))
    (define L.fun/vector27722.5 (lambda () (call make-vector 8)))
    (define L.fun/pair27724.6 (lambda () (call cons 143 407)))
    (define L.fun/vector27712.7 (lambda () (call L.fun/vector27713.12)))
    (define L.fun/empty27715.8 (lambda () (call L.fun/empty27716.10)))
    (define L.fun/empty27717.9 (lambda () (call L.fun/empty27718.11)))
    (define L.fun/empty27716.10 (lambda () empty))
    (define L.fun/empty27718.11 (lambda () empty))
    (define L.fun/vector27713.12 (lambda () (call make-vector 8)))
    (define L.fun/pair27723.13 (lambda () (call L.fun/pair27724.6)))
    (define L.fun/ascii-char27720.14 (lambda () #\L))
    (define L.fun/ascii-char27719.15
      (lambda () (call L.fun/ascii-char27720.14)))
    (define L.fun/vector27721.16 (lambda () (call L.fun/vector27722.5)))
    (let ((vector0.6 (call L.fun/vector27712.7))
          (boolean1.5 (call boolean? (call L.fun/any27714.4)))
          (empty2.4 (call L.fun/empty27715.8))
          (empty3.3 (call L.fun/empty27717.9))
          (ascii-char4.2 (call L.fun/ascii-char27719.15))
          (vector5.1 (call L.fun/vector27721.16)))
      (call L.fun/pair27723.13))))
(check-by-interp
 '(module
    (define L.fun/void28240.4 (lambda () (void)))
    (define L.fun/vector28232.5 (lambda () (call L.fun/vector28233.16)))
    (define L.fun/error28236.6 (lambda () (error 1)))
    (define L.fun/void28239.7 (lambda () (call L.fun/void28240.4)))
    (define L.fun/any28234.8 (lambda () #t))
    (define L.fun/pair28238.9 (lambda () (call cons 167 414)))
    (define L.fun/pair28237.10 (lambda () (call L.fun/pair28238.9)))
    (define L.fun/error28235.11 (lambda () (call L.fun/error28236.6)))
    (define L.fun/empty28243.12 (lambda () (call L.fun/empty28244.15)))
    (define L.fun/pair28242.13 (lambda () (call cons 218 308)))
    (define L.fun/pair28241.14 (lambda () (call L.fun/pair28242.13)))
    (define L.fun/empty28244.15 (lambda () empty))
    (define L.fun/vector28233.16 (lambda () (call make-vector 8)))
    (let ((vector0.6 (call L.fun/vector28232.5))
          (boolean1.5 (call boolean? (call L.fun/any28234.8)))
          (error2.4 (call L.fun/error28235.11))
          (pair3.3 (call L.fun/pair28237.10))
          (void4.2 (call L.fun/void28239.7))
          (pair5.1 (call L.fun/pair28241.14)))
      (call L.fun/empty28243.12))))
(check-by-interp
 '(module
    (define L.fun/vector28252.4 (lambda () (call make-vector 8)))
    (define L.fun/pair28257.5 (lambda () (call L.fun/pair28258.11)))
    (define L.fun/error28248.6 (lambda () (error 161)))
    (define L.fun/pair28250.7 (lambda () (call cons 202 394)))
    (define L.fun/error28247.8 (lambda () (call L.fun/error28248.6)))
    (define L.fun/pair28249.9 (lambda () (call L.fun/pair28250.7)))
    (define L.fun/void28254.10 (lambda () (void)))
    (define L.fun/pair28258.11 (lambda () (call cons 35 259)))
    (define L.fun/ascii-char28255.12
      (lambda () (call L.fun/ascii-char28256.15)))
    (define L.fun/void28253.13 (lambda () (call L.fun/void28254.10)))
    (define L.fun/vector28251.14 (lambda () (call L.fun/vector28252.4)))
    (define L.fun/ascii-char28256.15 (lambda () #\m))
    (let ((error0.6 (call L.fun/error28247.8))
          (pair1.5 (call L.fun/pair28249.9))
          (vector2.4 (call L.fun/vector28251.14))
          (void3.3 (call L.fun/void28253.13))
          (ascii-char4.2 (call L.fun/ascii-char28255.12))
          (pair5.1 (call L.fun/pair28257.5)))
      error0.6)))
(check-by-interp
 '(module
    (define L.fun/any28262.4 (lambda () (error 37)))
    (define L.fun/boolean28268.5
      (lambda (oprand0.5 oprand1.4 oprand2.3 oprand3.2 oprand4.1) #f))
    (define L.fun/void28269.6
      (lambda (oprand0.10 oprand1.9 oprand2.8 oprand3.7 oprand4.6)
        (call vector-set! oprand4.6 7 #t)))
    (define L.fun/any28261.7
      (lambda (oprand0.15 oprand1.14 oprand2.13 oprand3.12 oprand4.11)
        (call L.fun/any28262.4)))
    (define L.fun/pair28273.8 (lambda () (call cons 234 305)))
    (define L.fun/vector28266.9
      (lambda (oprand0.20 oprand1.19 oprand2.18 oprand3.17 oprand4.16)
        (call make-vector 8)))
    (define L.fun/pair28264.10
      (lambda (oprand0.25 oprand1.24 oprand2.23 oprand3.22 oprand4.21)
        oprand4.21))
    (define L.fun/empty28274.11 (lambda () empty))
    (define L.fun/ascii-char28263.12
      (lambda (oprand0.30 oprand1.29 oprand2.28 oprand3.27 oprand4.26) #\K))
    (define L.fun/vector28275.13 (lambda () (call make-vector 8)))
    (define L.fun/empty28270.14 (lambda () empty))
    (define L.fun/error28267.15
      (lambda (oprand0.35 oprand1.34 oprand2.33 oprand3.32 oprand4.31)
        (error 129)))
    (define L.fun/any28272.16 (lambda () empty))
    (define L.fun/pair28265.17
      (lambda (oprand0.40 oprand1.39 oprand2.38 oprand3.37 oprand4.36)
        oprand4.36))
    (define L.fun/empty28271.18 (lambda () empty))
    (if (call
         vector?
         (call
          L.fun/any28261.7
          (call
           *
           (if #f 136 135)
           (let ((ascii-char0.46 #\])
                 (error1.45 (error 89))
                 (void2.44 (void))
                 (fixnum3.43 66)
                 (error4.42 (error 252))
                 (empty5.41 empty))
             116))
          (if #t #\P #\J)
          (if #t (error 7) (error 73))
          (call
           L.fun/ascii-char28263.12
           (if #f (void) (void))
           (call
            L.fun/pair28264.10
            (error 14)
            empty
            empty
            (call make-vector 8)
            (call cons 109 271))
           (if #f (call cons 45 312) (call cons 164 327))
           (let ((empty0.52 empty)
                 (vector1.51 (call make-vector 8))
                 (pair2.50 (call cons 187 381))
                 (error3.49 (error 78))
                 (vector4.48 (call make-vector 8))
                 (boolean5.47 #f))
             error3.49)
           (call
            L.fun/pair28265.17
            #\n
            (error 165)
            (error 64)
            #\o
            (call cons 167 363)))
          (if #f (call cons 33 488) (call cons 198 495))))
      (if (let ((pair0.58 (call cons 55 339))
                (void1.57 (void))
                (boolean2.56 #f)
                (boolean3.55 #t)
                (ascii-char4.54 #\i)
                (fixnum5.53 223))
            boolean2.56)
        (call
         L.fun/vector28266.9
         (call L.fun/error28267.15 (void) #t empty (call cons 176 418) 204)
         (call
          L.fun/boolean28268.5
          empty
          (error 93)
          (call make-vector 8)
          (void)
          (void))
         (let ((pair0.64 (call cons 30 433))
               (void1.63 (void))
               (vector2.62 (call make-vector 8))
               (empty3.61 empty)
               (error4.60 (error 252))
               (boolean5.59 #t))
           pair0.64)
         (let ((empty0.70 empty)
               (vector1.69 (call make-vector 8))
               (error2.68 (error 133))
               (fixnum3.67 155)
               (void4.66 (void))
               (pair5.65 (call cons 40 398)))
           (call cons 129 495))
         (call
          L.fun/void28269.6
          #\]
          (call cons 129 379)
          188
          #t
          (call make-vector 8)))
        (if #t (call make-vector 8) (call make-vector 8)))
      (let ((empty0.76 (call L.fun/empty28270.14))
            (empty1.75 (call L.fun/empty28271.18))
            (fixnum2.74 (call - (call * 21 20) (call + 56 218)))
            (boolean3.73 (call boolean? (call L.fun/any28272.16)))
            (pair4.72 (call L.fun/pair28273.8))
            (empty5.71 (call L.fun/empty28274.11)))
        (call L.fun/vector28275.13)))))
(check-by-interp
 '(module
    (define L.fun/vector28362.4 (lambda () (call make-vector 8)))
    (define L.fun/void28357.5 (lambda () (call L.fun/void28358.9)))
    (define L.fun/ascii-char28363.6
      (lambda () (call L.fun/ascii-char28364.10)))
    (define L.fun/vector28361.7 (lambda () (call L.fun/vector28362.4)))
    (define L.fun/void28359.8 (lambda () (call L.fun/void28360.12)))
    (define L.fun/void28358.9 (lambda () (void)))
    (define L.fun/ascii-char28364.10 (lambda () #\^))
    (define L.fun/pair28366.11 (lambda () (call cons 171 447)))
    (define L.fun/void28360.12 (lambda () (void)))
    (define L.fun/ascii-char28355.13
      (lambda () (call L.fun/ascii-char28356.14)))
    (define L.fun/ascii-char28356.14 (lambda () #\k))
    (define L.fun/pair28365.15 (lambda () (call L.fun/pair28366.11)))
    (let ((ascii-char0.6 (call L.fun/ascii-char28355.13))
          (void1.5 (call L.fun/void28357.5))
          (void2.4 (call L.fun/void28359.8))
          (vector3.3 (call L.fun/vector28361.7))
          (ascii-char4.2 (call L.fun/ascii-char28363.6))
          (pair5.1 (call L.fun/pair28365.15)))
      ascii-char0.6)))
