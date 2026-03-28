#lang racket
(require cpsc411/compiler-lib cpsc411/langs/v8 "../implement-safe-primops.rkt")
(define (fail-if-invalid p)
  (when (not (exprs-unsafe-data-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "exprs-unsafe-data-lang-v8"
      " program")))
  p)
(define (check-by-interp p)
  (interp-exprs-unique-lang-v8 p)
  (interp-exprs-unsafe-data-lang-v8
   (fail-if-invalid (implement-safe-primops p))))

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
    (define L.fun/fixnum8396.4 (lambda (oprand0.1) 241))
    (call + (if #t 74 97) (call L.fun/fixnum8396.4 (void)))))
(check-by-interp
 '(module
    (define L.fun/void8399.4 (lambda (oprand0.1) (void)))
    (call L.fun/void8399.4 (call * 135 150))))
(check-by-interp
 '(module (let ((fixnum0.2 125) (vector1.1 (call make-vector 8))) fixnum0.2)))
(check-by-interp
 '(module
    (define L.fun/boolean8404.4 (lambda (oprand0.1) #t))
    (define L.fun/void8405.5
      (lambda (oprand0.2)
        (call
         vector-set!
         oprand0.2
         7
         (call vector-set! oprand0.2 7 (error 226)))))
    (call L.fun/boolean8404.4 (call L.fun/void8405.5 (call make-vector 8)))))
(check-by-interp '(module (let ((empty0.2 empty) (empty1.1 empty)) (void))))
(check-by-interp '(module (if #f 6 200)))
(check-by-interp
 '(module
    (define L.fun/ascii-char8412.4 (lambda (oprand0.1) #\c))
    (call
     L.fun/ascii-char8412.4
     (let ((void0.3 (void)) (empty1.2 empty)) (call make-vector 8)))))
(check-by-interp
 '(module
    (define L.fun/error8417.4 (lambda () (error 17)))
    (define L.fun/empty8415.5 (lambda () empty))
    (define L.fun/vector8416.6 (lambda () (call make-vector 8)))
    (let ((empty0.3 (call L.fun/empty8415.5))
          (vector1.2 (call L.fun/vector8416.6))
          (error2.1 (call L.fun/error8417.4)))
      error2.1)))
(check-by-interp
 '(module
    (define L.fun/error8429.4 (lambda () (error 208)))
    (define L.fun/vector8431.5 (lambda () (call make-vector 8)))
    (define L.fun/vector8430.6 (lambda () (call make-vector 8)))
    (let ((error0.3 (call L.fun/error8429.4))
          (vector1.2 (call L.fun/vector8430.6))
          (vector2.1 (call L.fun/vector8431.5)))
      vector2.1)))
(check-by-interp
 '(module
    (define L.fun/void8436.4 (lambda (oprand0.2 oprand1.1) oprand1.1))
    (define L.fun/ascii-char8434.5
      (lambda (oprand0.4 oprand1.3) (call L.fun/ascii-char8435.6)))
    (define L.fun/ascii-char8435.6 (lambda () #\c))
    (call
     L.fun/ascii-char8434.5
     (call
      L.fun/void8436.4
      (call L.fun/ascii-char8434.5 (void) (call make-vector 8))
      (if #t (void) (void)))
     (let ((vector0.7 (call make-vector 8))
           (empty1.6 empty)
           (vector2.5 (call make-vector 8)))
       vector2.5))))
(check-by-interp
 '(module
    (define L.fun/fixnum8456.4 (lambda (oprand0.2 oprand1.1) (call - 33 75)))
    (call
     L.fun/fixnum8456.4
     (let ((error0.5 (error 178)) (error1.4 (error 123)) (boolean2.3 #f))
       boolean2.3)
     (let ((boolean0.8 #t)
           (vector1.7 (call make-vector 8))
           (ascii-char2.6 #\c))
       #\c))))
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
    (define L.fun/void8466.4
      (lambda (oprand0.2 oprand1.1) (call vector-set! oprand1.1 7 oprand0.2)))
    (define L.fun/error8467.5 (lambda (oprand0.4 oprand1.3) (error 197)))
    (define L.fun/fixnum8468.6 (lambda (oprand0.6 oprand1.5) 230))
    (call
     L.fun/void8466.4
     (call
      L.fun/error8467.5
      (if #t (void) (void))
      (call L.fun/fixnum8468.6 #f empty))
     (let ((ascii-char0.9 #\c) (error1.8 (error 112)) (ascii-char2.7 #\c))
       (call make-vector 8)))))
(check-by-interp
 '(module
    (define L.fun/vector8472.4
      (lambda (oprand0.2 oprand1.1) (call make-vector 8)))
    (define L.fun/ascii-char8473.5 (lambda (oprand0.4 oprand1.3) #\c))
    (define L.fun/fixnum8471.6 (lambda (oprand0.6 oprand1.5) 10))
    (call
     +
     (call
      L.fun/fixnum8471.6
      (call L.fun/vector8472.4 58 (call make-vector 8))
      (call L.fun/ascii-char8473.5 82 #t))
     (if #t 223 166))))
(check-by-interp
 '(module
    (define L.fun/empty8476.4 (lambda () empty))
    (define L.fun/vector8477.5 (lambda () (call make-vector 8)))
    (let ((fixnum0.3 (call * 51 120))
          (empty1.2 (call L.fun/empty8476.4))
          (vector2.1 (call L.fun/vector8477.5)))
      vector2.1)))
(check-by-interp
 '(module
    (define L.fun/fixnum8490.4 (lambda (oprand0.2 oprand1.1) 21))
    (define L.fun/boolean8489.5 (lambda (oprand0.4 oprand1.3) #f))
    (if (call L.fun/boolean8489.5 (error 248) 76)
      (call L.fun/fixnum8490.4 (void) #t)
      (call * 214 251))))
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
    (define L.fun/fixnum8501.4 (lambda (oprand0.2 oprand1.1) 23))
    (if (let ((void0.5 (void)) (error1.4 (error 162)) (empty2.3 empty)) #t)
      (call * 26 123)
      (call L.fun/fixnum8501.4 #t (void)))))
(check-by-interp
 '(module
    (define L.fun/empty8545.4 (lambda () empty))
    (define L.fun/vector8546.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char8544.6 (lambda () #\c))
    (let ((ascii-char0.3 (call L.fun/ascii-char8544.6))
          (empty1.2 (call L.fun/empty8545.4))
          (vector2.1 (call L.fun/vector8546.5)))
      (call + 76 15))))
(check-by-interp
 '(module
    (if (let ((void0.3 (void)) (ascii-char1.2 #\c) (fixnum2.1 202)) #t)
      (call + 65 205)
      (call + 3 49))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8555.4 (lambda () #\c))
    (define L.fun/void8554.5 (lambda () (void)))
    (let ((boolean0.3 (call pair? (error 49)))
          (void1.2 (call L.fun/void8554.5))
          (fixnum2.1 (call + 92 194)))
      (call L.fun/ascii-char8555.4))))
(check-by-interp
 '(module
    (define L.fun/empty8590.4 (lambda () empty))
    (let ((empty0.3 (call L.fun/empty8590.4))
          (boolean1.2 (call error? (void)))
          (fixnum2.1 (call + 174 187)))
      fixnum2.1)))
(check-by-interp
 '(module
    (define L.fun/void8641.4 (lambda () (void)))
    (define L.fun/empty8642.5 (lambda () empty))
    (define L.fun/void8643.6 (lambda () (void)))
    (let ((void0.4 (call L.fun/void8641.4))
          (empty1.3 (call L.fun/empty8642.5))
          (fixnum2.2 (call - (call - 205 242) (call * 205 113)))
          (void3.1 (call L.fun/void8643.6)))
      void3.1)))
(check-by-interp
 '(module
    (define L.fun/ascii-char8677.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) oprand2.1))
    (define L.fun/fixnum8684.5 (lambda (oprand0.6 oprand1.5 oprand2.4) 119))
    (define L.fun/boolean8680.6 (lambda (oprand0.9 oprand1.8 oprand2.7) #t))
    (define L.fun/vector8679.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) (call make-vector 8)))
    (define L.fun/vector8682.8
      (lambda (oprand0.15 oprand1.14 oprand2.13) (call make-vector 8)))
    (define L.fun/boolean8678.9 (lambda (oprand0.18 oprand1.17 oprand2.16) #f))
    (define L.fun/fixnum8681.10 (lambda (oprand0.21 oprand1.20 oprand2.19) 33))
    (define L.fun/empty8683.11
      (lambda (oprand0.24 oprand1.23 oprand2.22) empty))
    (call
     L.fun/ascii-char8677.4
     (if (call L.fun/boolean8678.9 empty empty #\c)
       (if #f (call make-vector 8) (call make-vector 8))
       (call L.fun/vector8679.7 103 (void) (error 210)))
     (if (call
          L.fun/boolean8680.6
          163
          (call make-vector 8)
          (call make-vector 8))
       (call * 230 63)
       (call L.fun/fixnum8681.10 #f (call make-vector 8) (void)))
     (call
      L.fun/ascii-char8677.4
      (call
       L.fun/vector8682.8
       (call
        L.fun/empty8683.11
        (call make-vector 8)
        (error 248)
        (call make-vector 8))
       (if #f (call make-vector 8) (call make-vector 8))
       (let ((boolean0.28 #f)
             (void1.27 (void))
             (fixnum2.26 171)
             (ascii-char3.25 #\c))
         void1.27))
      (call
       L.fun/fixnum8684.5
       (let ((void0.32 (void))
             (empty1.31 empty)
             (vector2.30 (call make-vector 8))
             (fixnum3.29 204))
         empty1.31)
       (call ascii-char? (error 224))
       (if #t #\c #\c))
      (if #t #\c #\c)))))
(check-by-interp
 '(module
    (if (let ((vector0.4 (call make-vector 8))
              (void1.3 (void))
              (error2.2 (error 137))
              (boolean3.1 #t))
          boolean3.1)
      (if #f #\c #\c)
      (let ((fixnum0.8 189)
            (void1.7 (void))
            (void2.6 (void))
            (ascii-char3.5 #\c))
        ascii-char3.5))))
(check-by-interp
 '(module
    (if (if #f #f #f)
      (call * (if #f 137 109) (call * 163 203))
      (let ((vector0.4 (call make-vector 8))
            (empty1.3 empty)
            (error2.2 (error 236))
            (boolean3.1 #f))
        194))))
(check-by-interp
 '(module
    (define L.fun/void9010.4 (lambda () (void)))
    (define L.fun/error9012.5 (lambda () (error 66)))
    (define L.fun/vector9011.6 (lambda () (call make-vector 8)))
    (define L.fun/vector9013.7 (lambda () (call make-vector 8)))
    (let ((void0.4 (call L.fun/void9010.4))
          (vector1.3 (call L.fun/vector9011.6))
          (error2.2 (call L.fun/error9012.5))
          (vector3.1 (call L.fun/vector9013.7)))
      void0.4)))
(check-by-interp
 '(module
    (define L.fun/empty9031.4 (lambda () empty))
    (define L.fun/vector9032.5 (lambda () (call make-vector 8)))
    (define L.fun/vector9030.6 (lambda () (call make-vector 8)))
    (define L.fun/error9033.7 (lambda () (error 69)))
    (let ((vector0.4 (call L.fun/vector9030.6))
          (empty1.3 (call L.fun/empty9031.4))
          (vector2.2 (call L.fun/vector9032.5))
          (error3.1 (call L.fun/error9033.7)))
      empty1.3)))
(check-by-interp
 '(module
    (define L.fun/error9302.4 (lambda () (error 3)))
    (define L.fun/vector9300.5 (lambda () (call make-vector 8)))
    (define L.fun/vector9301.6 (lambda () (call make-vector 8)))
    (define L.fun/vector9298.7 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char9299.8 (lambda () #\c))
    (let ((vector0.4 (call L.fun/vector9298.7))
          (ascii-char1.3 (call L.fun/ascii-char9299.8))
          (vector2.2 (call L.fun/vector9300.5))
          (vector3.1 (call L.fun/vector9301.6)))
      (call L.fun/error9302.4))))
(check-by-interp
 '(module
    (define L.fun/error9361.4 (lambda () (error 55)))
    (define L.fun/empty9358.5 (lambda () empty))
    (define L.fun/void9360.6 (lambda () (void)))
    (define L.fun/empty9359.7 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty9358.5))
          (fixnum1.3 (call - (call * 182 165) (call * 13 1)))
          (empty2.2 (call L.fun/empty9359.7))
          (void3.1 (call L.fun/void9360.6)))
      (call L.fun/error9361.4))))
(check-by-interp
 '(module
    (define L.fun/empty9583.4 (lambda () empty))
    (define L.fun/error9578.5 (lambda () (error 162)))
    (define L.fun/vector9576.6
      (lambda (oprand0.3 oprand1.2 oprand2.1) (call L.fun/vector9577.12)))
    (define L.fun/ascii-char9584.7 (lambda () #\c))
    (define L.fun/ascii-char9579.8 (lambda () #\c))
    (define L.fun/error9582.9 (lambda () (error 153)))
    (define L.fun/empty9580.10 (lambda () empty))
    (define L.fun/ascii-char9581.11 (lambda () #\c))
    (define L.fun/vector9577.12 (lambda () (call make-vector 8)))
    (call
     L.fun/vector9576.6
     (call
      +
      (if #t 74 28)
      (let ((error0.7 (error 192))
            (vector1.6 (call make-vector 8))
            (void2.5 (void))
            (void3.4 (void)))
        179))
     (let ((error0.11 (call L.fun/error9578.5))
           (ascii-char1.10 (call L.fun/ascii-char9579.8))
           (empty2.9 (call L.fun/empty9580.10))
           (ascii-char3.8 (call L.fun/ascii-char9581.11)))
       (call * 212 128))
     (let ((error0.15 (call L.fun/error9582.9))
           (empty1.14 (call L.fun/empty9583.4))
           (boolean2.13 (call boolean? (void)))
           (ascii-char3.12 (call L.fun/ascii-char9584.7)))
       empty1.14))))
(check-by-interp
 '(module
    (define L.fun/void9768.4 (lambda () (void)))
    (define L.fun/any9769.5 (lambda () (call make-vector 8)))
    (define L.fun/error9767.6 (lambda () (error 33)))
    (define L.fun/empty9770.7 (lambda () empty))
    (let ((error0.4 (call L.fun/error9767.6))
          (void1.3 (call L.fun/void9768.4))
          (boolean2.2 (call empty? (call L.fun/any9769.5)))
          (empty3.1 (call L.fun/empty9770.7)))
      void1.3)))
(check-by-interp
 '(module
    (define L.fun/error9957.4 (lambda () (error 156)))
    (define L.fun/vector9959.5 (lambda () (call make-vector 8)))
    (define L.fun/empty9960.6 (lambda () empty))
    (define L.fun/void9958.7 (lambda () (void)))
    (let ((error0.4 (call L.fun/error9957.4))
          (void1.3 (call L.fun/void9958.7))
          (vector2.2 (call L.fun/vector9959.5))
          (fixnum3.1 (call - (call * 224 128) (call - 121 68))))
      (call L.fun/empty9960.6))))
(check-by-interp
 '(module
    (define L.fun/vector10055.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) (call make-vector 8)))
    (define L.fun/ascii-char10053.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) oprand1.5))
    (define L.fun/vector10054.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) oprand1.8))
    (define L.fun/error10056.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) oprand1.11))
    (call
     L.fun/ascii-char10053.5
     (call
      L.fun/vector10054.6
      (let ((boolean0.16 #f)
            (error1.15 (error 59))
            (error2.14 (error 140))
            (fixnum3.13 119))
        203)
      (if #f (call make-vector 8) (call make-vector 8))
      (let ((ascii-char0.20 #\c)
            (ascii-char1.19 #\c)
            (vector2.18 (call make-vector 8))
            (boolean3.17 #f))
        (error 37)))
     (call
      L.fun/ascii-char10053.5
      (call
       L.fun/vector10055.4
       (let ((ascii-char0.24 #\c)
             (vector1.23 (call make-vector 8))
             (boolean2.22 #t)
             (fixnum3.21 33))
         (error 99))
       (if #t #\c #\c)
       (call L.fun/ascii-char10053.5 (call make-vector 8) #\c (error 211)))
      (let ((boolean0.28 #f)
            (boolean1.27 #t)
            (ascii-char2.26 #\c)
            (vector3.25 (call make-vector 8)))
        #\c)
      (if #f (error 182) (error 55)))
     (call
      L.fun/error10056.7
      (if #t empty empty)
      (call
       L.fun/error10056.7
       (if #f empty empty)
       (call L.fun/error10056.7 empty (error 46) (void))
       (if #t (void) (void)))
      (if #f (void) (void))))))
(check-by-interp
 '(module
    (define L.fun/void10119.4 (lambda (oprand0.3 oprand1.2 oprand2.1) (void)))
    (define L.fun/fixnum10117.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) oprand1.5))
    (define L.fun/fixnum10118.6 (lambda (oprand0.9 oprand1.8 oprand2.7) 205))
    (call
     -
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
      +
      (if #f 95 53)
      (call
       L.fun/fixnum10118.6
       (call L.fun/void10119.4 #f #\c empty)
       (let ((boolean0.21 #t)
             (empty1.20 empty)
             (boolean2.19 #t)
             (boolean3.18 #t))
         (error 105))
       (call * 37 187))))))
(check-by-interp
 '(module
    (define L.fun/error10147.4 (lambda () (error 9)))
    (define L.fun/void10149.5 (lambda () (void)))
    (define L.fun/empty10148.6 (lambda () empty))
    (define L.fun/vector10150.7 (lambda () (call make-vector 8)))
    (let ((error0.4 (call L.fun/error10147.4))
          (empty1.3 (call L.fun/empty10148.6))
          (void2.2 (call L.fun/void10149.5))
          (vector3.1 (call L.fun/vector10150.7)))
      empty1.3)))
(check-by-interp
 '(module
    (define L.fun/error10153.4 (lambda () (error 12)))
    (define L.fun/error10154.5 (lambda () (error 19)))
    (let ((error0.4 (call L.fun/error10153.4))
          (fixnum1.3 (call * (call - 135 185) (call * 237 167)))
          (error2.2 (call L.fun/error10154.5))
          (fixnum3.1 (call + (call + 246 49) (call * 176 151))))
      error2.2)))
(check-by-interp
 '(module
    (define L.fun/error10182.4 (lambda () (error 160)))
    (define L.fun/void10183.5 (lambda () (void)))
    (define L.fun/vector10184.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char10185.7 (lambda () #\c))
    (let ((error0.4 (call L.fun/error10182.4))
          (void1.3 (call L.fun/void10183.5))
          (vector2.2 (call L.fun/vector10184.6))
          (fixnum3.1 (call * (call - 27 232) (call + 223 209))))
      (call L.fun/ascii-char10185.7))))
(check-by-interp
 '(module
    (define L.fun/ascii-char10875.4 (lambda () #\c))
    (define L.fun/vector10878.5 (lambda () (call make-vector 8)))
    (define L.fun/void10876.6 (lambda () (void)))
    (define L.fun/vector10877.7 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char10879.8 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char10875.4))
          (void1.4 (call L.fun/void10876.6))
          (vector2.3 (call L.fun/vector10877.7))
          (vector3.2 (call L.fun/vector10878.5))
          (ascii-char4.1 (call L.fun/ascii-char10879.8)))
      (call
       -
       (call * (call - 117 4) (call + 216 102))
       (call + (call * 114 249) (call * 209 177))))))
(check-by-interp
 '(module
    (define L.fun/vector11280.4 (lambda () (call make-vector 8)))
    (define L.fun/empty11282.5 (lambda () empty))
    (define L.fun/error11283.6 (lambda () (error 235)))
    (define L.fun/error11281.7 (lambda () (error 145)))
    (define L.fun/ascii-char11284.8 (lambda () #\c))
    (let ((vector0.5 (call L.fun/vector11280.4))
          (error1.4 (call L.fun/error11281.7))
          (empty2.3 (call L.fun/empty11282.5))
          (fixnum3.2
           (call
            +
            (call - (call + 120 239) (call - 127 153))
            (call - (call * 191 153) (call * 76 30))))
          (error4.1 (call L.fun/error11283.6)))
      (call L.fun/ascii-char11284.8))))
(check-by-interp
 '(module
    (define L.fun/vector11329.4 (lambda () (call make-vector 8)))
    (define L.fun/empty11330.5 (lambda () empty))
    (define L.fun/void11328.6 (lambda () (void)))
    (let ((fixnum0.5
           (call
            -
            (call + (call - 179 253) (call * 165 99))
            (call - (call * 69 45) (call - 208 233))))
          (fixnum1.4
           (call
            *
            (call - (call + 127 107) (call + 220 57))
            (call * (call + 243 167) (call + 167 52))))
          (void2.3 (call L.fun/void11328.6))
          (vector3.2 (call L.fun/vector11329.4))
          (empty4.1 (call L.fun/empty11330.5)))
      fixnum0.5)))
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
    (define L.fun/ascii-char11665.4 (lambda () #\c))
    (define L.fun/void11663.5 (lambda () (void)))
    (define L.fun/vector11666.6 (lambda () (call make-vector 8)))
    (define L.fun/empty11664.7 (lambda () empty))
    (define L.fun/vector11667.8 (lambda () (call make-vector 8)))
    (let ((void0.5 (call L.fun/void11663.5))
          (empty1.4 (call L.fun/empty11664.7))
          (ascii-char2.3 (call L.fun/ascii-char11665.4))
          (vector3.2 (call L.fun/vector11666.6))
          (vector4.1 (call L.fun/vector11667.8)))
      empty1.4)))
(check-by-interp
 '(module
    (define L.fun/empty11788.4 (lambda () empty))
    (define L.fun/empty11787.5 (lambda () empty))
    (define L.fun/vector11789.6 (lambda () (call make-vector 8)))
    (define L.fun/vector11786.7 (lambda () (call make-vector 8)))
    (let ((vector0.5 (call L.fun/vector11786.7))
          (empty1.4 (call L.fun/empty11787.5))
          (fixnum2.3
           (call
            *
            (call * (call - 42 35) (call - 64 48))
            (call + (call - 122 73) (call - 203 180))))
          (empty3.2 (call L.fun/empty11788.4))
          (vector4.1 (call L.fun/vector11789.6)))
      empty3.2)))
(check-by-interp
 '(module
    (define L.fun/any11902.4 (lambda () #f))
    (define L.fun/ascii-char11900.5 (lambda () #\c))
    (define L.fun/ascii-char11901.6 (lambda () #\c))
    (define L.fun/ascii-char11903.7 (lambda () #\c))
    (define L.fun/void11904.8 (lambda () (void)))
    (define L.fun/empty11899.9 (lambda () empty))
    (let ((empty0.5 (call L.fun/empty11899.9))
          (ascii-char1.4 (call L.fun/ascii-char11900.5))
          (ascii-char2.3 (call L.fun/ascii-char11901.6))
          (boolean3.2 (call boolean? (call L.fun/any11902.4)))
          (ascii-char4.1 (call L.fun/ascii-char11903.7)))
      (call L.fun/void11904.8))))
(check-by-interp
 '(module
    (define L.fun/void11995.4 (lambda () (void)))
    (define L.fun/ascii-char11994.5 (lambda () #\c))
    (define L.fun/void11996.6 (lambda () (void)))
    (let ((ascii-char0.5 (call L.fun/ascii-char11994.5))
          (void1.4 (call L.fun/void11995.4))
          (void2.3 (call L.fun/void11996.6))
          (fixnum3.2
           (call
            -
            (call + (call + 250 5) (call * 94 16))
            (call + (call + 38 236) (call - 180 46))))
          (fixnum4.1
           (call
            *
            (call * (call - 173 225) (call * 12 137))
            (call + (call + 139 45) (call * 168 159)))))
      (call + fixnum4.1 fixnum3.2))))
(check-by-interp
 '(module
    (define L.fun/void11999.4 (lambda () (void)))
    (define L.fun/ascii-char12000.5 (lambda () #\c))
    (let ((fixnum0.5
           (call
            +
            (call * (call * 248 56) (call - 156 82))
            (call - (call + 57 175) (call + 131 140))))
          (fixnum1.4
           (call
            +
            (call + (call - 45 197) (call * 221 181))
            (call * (call * 140 242) (call * 177 131))))
          (void2.3 (call L.fun/void11999.4))
          (fixnum3.2
           (call
            +
            (call * (call + 85 210) (call * 98 238))
            (call - (call * 203 209) (call * 251 129))))
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
    (define L.fun/any12082.4 (lambda () (call make-vector 8)))
    (define L.fun/error12079.5 (lambda () (error 59)))
    (define L.fun/error12080.6 (lambda () (error 90)))
    (define L.fun/any12081.7 (lambda () (call make-vector 8)))
    (define L.fun/empty12078.8 (lambda () empty))
    (call
     vector?
     (let ((empty0.5 (call L.fun/empty12078.8))
           (error1.4 (call L.fun/error12079.5))
           (fixnum2.3 (call - (call + 254 82) (call - 19 23)))
           (error3.2 (call L.fun/error12080.6))
           (boolean4.1 (call empty? (call L.fun/any12081.7))))
       (call L.fun/any12082.4)))))
(check-by-interp
 '(module
    (define L.fun/empty12122.4 (lambda () empty))
    (define L.fun/vector12120.5 (lambda () (call make-vector 8)))
    (define L.fun/vector12123.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char12121.7 (lambda () #\c))
    (define L.fun/vector12124.8 (lambda () (call make-vector 8)))
    (define L.fun/any12125.9 (lambda () (error 150)))
    (let ((vector0.5 (call L.fun/vector12120.5))
          (ascii-char1.4 (call L.fun/ascii-char12121.7))
          (empty2.3 (call L.fun/empty12122.4))
          (vector3.2 (call L.fun/vector12123.6))
          (vector4.1 (call L.fun/vector12124.8)))
      (call error? (call L.fun/any12125.9)))))
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
    (define L.fun/empty13119.4 (lambda () empty))
    (define L.fun/vector13122.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char13121.6 (lambda () #\c))
    (define L.fun/empty13118.7 (lambda () empty))
    (define L.fun/void13120.8 (lambda () (void)))
    (let ((empty0.5 (call L.fun/empty13118.7))
          (empty1.4 (call L.fun/empty13119.4))
          (void2.3 (call L.fun/void13120.8))
          (ascii-char3.2 (call L.fun/ascii-char13121.6))
          (vector4.1 (call L.fun/vector13122.5)))
      empty0.5)))
(check-by-interp
 '(module
    (define L.fun/ascii-char13212.4 (lambda () #\c))
    (define L.fun/error13215.5 (lambda () (error 252)))
    (define L.fun/vector13211.6 (lambda () (call make-vector 8)))
    (define L.fun/empty13213.7 (lambda () empty))
    (define L.fun/ascii-char13214.8 (lambda () #\c))
    (let ((vector0.5 (call L.fun/vector13211.6))
          (ascii-char1.4 (call L.fun/ascii-char13212.4))
          (empty2.3 (call L.fun/empty13213.7))
          (ascii-char3.2 (call L.fun/ascii-char13214.8))
          (error4.1 (call L.fun/error13215.5)))
      empty2.3)))
(check-by-interp
 '(module
    (define L.fun/ascii-char14008.4 (lambda () #\c))
    (define L.fun/error14007.5 (lambda () (error 128)))
    (define L.fun/void14006.6 (lambda () (void)))
    (let ((fixnum0.5
           (call
            -
            (call + (call * 192 89) (call - 209 20))
            (call * (call - 30 228) (call * 180 215))))
          (void1.4 (call L.fun/void14006.6))
          (fixnum2.3
           (call
            *
            (call - (call + 35 74) (call * 55 67))
            (call + (call - 50 93) (call - 199 135))))
          (error3.2 (call L.fun/error14007.5))
          (ascii-char4.1 (call L.fun/ascii-char14008.4)))
      (call * fixnum0.5 fixnum0.5))))
(check-by-interp
 '(module
    (define L.fun/vector14141.4 (lambda () (call make-vector 8)))
    (define L.fun/error14142.5 (lambda () (error 87)))
    (define L.fun/any14139.6 (lambda () (call make-vector 8)))
    (define L.fun/empty14140.7 (lambda () empty))
    (let ((boolean0.5 (call ascii-char? (call L.fun/any14139.6)))
          (empty1.4 (call L.fun/empty14140.7))
          (fixnum2.3
           (call
            +
            (call + (call * 131 3) (call - 169 101))
            (call * (call - 141 4) (call + 223 165))))
          (fixnum3.2
           (call
            -
            (call - (call * 223 123) (call * 162 234))
            (call + (call + 128 165) (call * 103 193))))
          (vector4.1 (call L.fun/vector14141.4)))
      (call L.fun/error14142.5))))
(check-by-interp
 '(module
    (define L.fun/ascii-char14689.4 (lambda () #\c))
    (define L.fun/error14685.5 (lambda () (error 11)))
    (define L.fun/vector14688.6 (lambda () (call make-vector 8)))
    (define L.fun/void14686.7 (lambda () (void)))
    (define L.fun/vector14687.8 (lambda () (call make-vector 8)))
    (let ((error0.5 (call L.fun/error14685.5))
          (void1.4 (call L.fun/void14686.7))
          (vector2.3 (call L.fun/vector14687.8))
          (fixnum3.2
           (call
            +
            (call - (call * 196 234) (call * 145 245))
            (call * (call * 27 41) (call + 47 85))))
          (vector4.1 (call L.fun/vector14688.6)))
      (call L.fun/ascii-char14689.4))))
(check-by-interp
 '(module
    (define L.fun/vector15058.4 (lambda () (call make-vector 8)))
    (define L.fun/vector15059.5 (lambda () (call make-vector 8)))
    (define L.fun/error15060.6 (lambda () (error 216)))
    (let ((fixnum0.5
           (call
            *
            (call * (call * 28 216) (call * 161 212))
            (call + (call - 55 152) (call + 49 180))))
          (vector1.4 (call L.fun/vector15058.4))
          (vector2.3 (call L.fun/vector15059.5))
          (fixnum3.2
           (call
            -
            (call * (call + 105 69) (call - 70 246))
            (call - (call - 145 164) (call * 22 8))))
          (error4.1 (call L.fun/error15060.6)))
      fixnum3.2)))
(check-by-interp
 '(module
    (define L.fun/ascii-char15107.4 (lambda () #\c))
    (define L.fun/vector15108.5 (lambda () (call make-vector 8)))
    (let ((ascii-char0.5 (call L.fun/ascii-char15107.4))
          (fixnum1.4
           (call
            +
            (call * (call + 252 39) (call * 182 36))
            (call - (call * 144 253) (call * 198 34))))
          (fixnum2.3
           (call
            +
            (call - (call * 9 212) (call * 209 237))
            (call + (call * 176 88) (call - 76 100))))
          (fixnum3.2
           (call
            *
            (call - (call * 227 27) (call * 82 107))
            (call - (call * 53 63) (call + 212 202))))
          (fixnum4.1
           (call
            *
            (call - (call + 133 110) (call - 221 54))
            (call - (call + 245 130) (call * 56 191)))))
      (call L.fun/vector15108.5))))
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
            *
            (call + (call + 110 157) (call * 142 196))
            (call - (call - 35 147) (call + 151 154)))))
      void0.5)))
(check-by-interp
 '(module
    (define L.fun/ascii-char15482.4 (lambda () #\c))
    (define L.fun/void15483.5 (lambda () (void)))
    (define L.fun/any15480.6 (lambda () empty))
    (define L.fun/void15481.7 (lambda () (void)))
    (let ((boolean0.5 (call ascii-char? (call L.fun/any15480.6)))
          (void1.4 (call L.fun/void15481.7))
          (ascii-char2.3 (call L.fun/ascii-char15482.4))
          (fixnum3.2
           (call
            +
            (call + (call + 142 247) (call + 12 162))
            (call - (call * 85 149) (call + 76 79))))
          (void4.1 (call L.fun/void15483.5)))
      void4.1)))
(check-by-interp
 '(module
    (define L.fun/void15713.4 (lambda () (void)))
    (define L.fun/ascii-char15715.5 (lambda () #\c))
    (define L.fun/vector15714.6 (lambda () (call make-vector 8)))
    (define L.fun/any15712.7 (lambda () 55))
    (define L.fun/void15716.8 (lambda () (void)))
    (let ((boolean0.5 (call vector? (call L.fun/any15712.7)))
          (void1.4 (call L.fun/void15713.4))
          (vector2.3 (call L.fun/vector15714.6))
          (ascii-char3.2 (call L.fun/ascii-char15715.5))
          (void4.1 (call L.fun/void15716.8)))
      vector2.3)))
(check-by-interp
 '(module
    (define L.fun/empty15779.4 (lambda () empty))
    (define L.fun/vector15781.5 (lambda () (call make-vector 8)))
    (define L.fun/error15780.6 (lambda () (error 146)))
    (let ((empty0.5 (call L.fun/empty15779.4))
          (fixnum1.4
           (call
            +
            (call * (call - 13 233) (call + 27 254))
            (call + (call * 96 13) (call * 92 154))))
          (fixnum2.3
           (call
            +
            (call - (call + 31 184) (call - 156 0))
            (call * (call - 241 140) (call + 193 89))))
          (fixnum3.2
           (call
            *
            (call * (call - 146 110) (call * 47 107))
            (call - (call - 170 175) (call - 188 108))))
          (error4.1 (call L.fun/error15780.6)))
      (call L.fun/vector15781.5))))
(check-by-interp
 '(module
    (define L.fun/empty16392.4 (lambda () empty))
    (define L.fun/void16390.5 (lambda () (void)))
    (define L.fun/ascii-char16393.6 (lambda () #\c))
    (define L.fun/error16394.7 (lambda () (error 149)))
    (define L.fun/vector16391.8 (lambda () (call make-vector 8)))
    (let ((void0.5 (call L.fun/void16390.5))
          (vector1.4 (call L.fun/vector16391.8))
          (fixnum2.3
           (call
            *
            (call + (call + 203 3) (call - 97 129))
            (call + (call - 9 69) (call * 83 79))))
          (empty3.2 (call L.fun/empty16392.4))
          (ascii-char4.1 (call L.fun/ascii-char16393.6)))
      (call L.fun/error16394.7))))
(check-by-interp
 '(module
    (define L.fun/ascii-char17311.4 (lambda () #\c))
    (define L.fun/void17307.5 (lambda () (void)))
    (define L.fun/empty17309.6 (lambda () empty))
    (define L.fun/vector17310.7 (lambda () (call make-vector 8)))
    (define L.fun/empty17308.8 (lambda () empty))
    (let ((fixnum0.5
           (call
            -
            (call + (call + 45 176) (call - 223 22))
            (call - (call - 73 29) (call - 0 26))))
          (void1.4 (call L.fun/void17307.5))
          (empty2.3 (call L.fun/empty17308.8))
          (empty3.2 (call L.fun/empty17309.6))
          (vector4.1 (call L.fun/vector17310.7)))
      (call L.fun/ascii-char17311.4))))
(check-by-interp
 '(module
    (define L.fun/any17793.4 (lambda () #\c))
    (define L.fun/error17796.5 (lambda () (error 76)))
    (define L.fun/any17795.6 (lambda () (error 183)))
    (define L.fun/empty17794.7 (lambda () empty))
    (let ((boolean0.5 (call empty? (call L.fun/any17793.4)))
          (empty1.4 (call L.fun/empty17794.7))
          (fixnum2.3
           (call
            *
            (call * (call * 244 242) (call - 2 140))
            (call * (call - 193 190) (call - 221 196))))
          (boolean3.2 (call vector? (call L.fun/any17795.6)))
          (error4.1 (call L.fun/error17796.5)))
      error4.1)))
(check-by-interp
 '(module
    (define L.fun/ascii-char17800.4 (lambda () #\c))
    (define L.fun/vector17801.5 (lambda () (call make-vector 8)))
    (define L.fun/empty17802.6 (lambda () empty))
    (define L.fun/ascii-char17799.7 (lambda () #\c))
    (define L.fun/ascii-char17803.8 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char17799.7))
          (ascii-char1.4 (call L.fun/ascii-char17800.4))
          (vector2.3 (call L.fun/vector17801.5))
          (empty3.2 (call L.fun/empty17802.6))
          (ascii-char4.1 (call L.fun/ascii-char17803.8)))
      empty3.2)))
(check-by-interp
 '(module
    (define L.fun/vector17866.4 (lambda () (call make-vector 8)))
    (define L.fun/vector17865.5 (lambda () (call make-vector 8)))
    (define L.fun/error17868.6 (lambda () (error 217)))
    (define L.fun/any17869.7 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char17867.8 (lambda () #\c))
    (let ((vector0.5 (call L.fun/vector17865.5))
          (vector1.4 (call L.fun/vector17866.4))
          (ascii-char2.3 (call L.fun/ascii-char17867.8))
          (error3.2 (call L.fun/error17868.6))
          (boolean4.1 (call error? (call L.fun/any17869.7))))
      vector0.5)))
(check-by-interp
 '(module
    (define L.fun/vector17918.4 (lambda () (call make-vector 8)))
    (define L.fun/void17920.5 (lambda () (void)))
    (define L.fun/ascii-char17917.6 (lambda () #\c))
    (define L.fun/void17916.7 (lambda () (void)))
    (define L.fun/vector17919.8 (lambda () (call make-vector 8)))
    (let ((void0.5 (call L.fun/void17916.7))
          (ascii-char1.4 (call L.fun/ascii-char17917.6))
          (vector2.3 (call L.fun/vector17918.4))
          (vector3.2 (call L.fun/vector17919.8))
          (void4.1 (call L.fun/void17920.5)))
      ascii-char1.4)))
(check-by-interp
 '(module
    (define L.fun/void19438.4 (lambda () (void)))
    (define L.fun/error19439.5 (lambda () (error 184)))
    (define L.fun/vector19440.6 (lambda () (call make-vector 8)))
    (define L.fun/any19441.7 (lambda () (void)))
    (define L.fun/ascii-char19442.8 (lambda () #\c))
    (let ((void0.5 (call L.fun/void19438.4))
          (error1.4 (call L.fun/error19439.5))
          (vector2.3 (call L.fun/vector19440.6))
          (boolean3.2 (call empty? (call L.fun/any19441.7)))
          (ascii-char4.1 (call L.fun/ascii-char19442.8)))
      void0.5)))
(check-by-interp
 '(module
    (define L.fun/error20171.4 (lambda () (error 229)))
    (define L.fun/vector20172.5 (lambda () (call make-vector 8)))
    (define L.fun/vector20170.6 (lambda () (call make-vector 8)))
    (define L.fun/error20169.7 (lambda () (error 2)))
    (define L.fun/any20173.8 (lambda () (error 221)))
    (let ((error0.5 (call L.fun/error20169.7))
          (vector1.4 (call L.fun/vector20170.6))
          (error2.3 (call L.fun/error20171.4))
          (vector3.2 (call L.fun/vector20172.5))
          (boolean4.1 (call pair? (call L.fun/any20173.8))))
      vector1.4)))
(check-by-interp
 '(module
    (define L.fun/ascii-char20264.4 (lambda () #\c))
    (define L.fun/void20262.5 (lambda () (void)))
    (define L.fun/empty20263.6 (lambda () empty))
    (define L.fun/ascii-char20266.7 (lambda () #\c))
    (define L.fun/vector20265.8 (lambda () (call make-vector 8)))
    (let ((void0.5 (call L.fun/void20262.5))
          (empty1.4 (call L.fun/empty20263.6))
          (ascii-char2.3 (call L.fun/ascii-char20264.4))
          (vector3.2 (call L.fun/vector20265.8))
          (ascii-char4.1 (call L.fun/ascii-char20266.7)))
      vector3.2)))
(check-by-interp
 '(module
    (define L.fun/vector20594.4 (lambda () (call make-vector 8)))
    (define L.fun/error20595.5 (lambda () (error 217)))
    (define L.fun/ascii-char20591.6 (lambda () #\c))
    (define L.fun/error20593.7 (lambda () (error 191)))
    (define L.fun/empty20592.8 (lambda () empty))
    (let ((ascii-char0.5 (call L.fun/ascii-char20591.6))
          (empty1.4 (call L.fun/empty20592.8))
          (error2.3 (call L.fun/error20593.7))
          (vector3.2 (call L.fun/vector20594.4))
          (error4.1 (call L.fun/error20595.5)))
      empty1.4)))
(check-by-interp
 '(module
    (define L.fun/any20781.4 (lambda () (void)))
    (define L.fun/error20783.5 (lambda () (error 177)))
    (define L.fun/empty20785.6 (lambda () empty))
    (define L.fun/error20782.7 (lambda () (error 164)))
    (define L.fun/any20784.8 (lambda () #t))
    (let ((boolean0.5 (call fixnum? (call L.fun/any20781.4)))
          (fixnum1.4
           (call
            -
            (call * (call - 226 247) (call * 249 138))
            (call * (call - 192 49) (call * 69 197))))
          (error2.3 (call L.fun/error20782.7))
          (error3.2 (call L.fun/error20783.5))
          (boolean4.1 (call boolean? (call L.fun/any20784.8))))
      (call L.fun/empty20785.6))))
(check-by-interp
 '(module
    (define L.fun/error20840.4 (lambda () (error 27)))
    (define L.fun/void20837.5 (lambda () (void)))
    (define L.fun/any20838.6 (lambda () (void)))
    (define L.fun/empty20839.7 (lambda () empty))
    (define L.fun/vector20841.8 (lambda () (call make-vector 8)))
    (let ((void0.5 (call L.fun/void20837.5))
          (boolean1.4 (call boolean? (call L.fun/any20838.6)))
          (empty2.3 (call L.fun/empty20839.7))
          (error3.2 (call L.fun/error20840.4))
          (vector4.1 (call L.fun/vector20841.8)))
      vector4.1)))
(check-by-interp
 '(module
    (define L.fun/ascii-char22127.4 (lambda () #\c))
    (define L.fun/error22124.5 (lambda () (error 160)))
    (define L.fun/error22126.6 (lambda () (error 10)))
    (define L.fun/void22125.7 (lambda () (void)))
    (let ((error0.5 (call L.fun/error22124.5))
          (fixnum1.4
           (call
            -
            (call + (call + 66 23) (call - 154 19))
            (call - (call - 56 80) (call + 93 29))))
          (void2.3 (call L.fun/void22125.7))
          (error3.2 (call L.fun/error22126.6))
          (ascii-char4.1 (call L.fun/ascii-char22127.4)))
      void2.3)))
(check-by-interp
 '(module
    (define L.fun/any22156.4 (lambda () (void)))
    (define L.fun/ascii-char22153.5 (lambda () #\c))
    (define L.fun/ascii-char22152.6 (lambda () #\c))
    (define L.fun/void22154.7 (lambda () (void)))
    (define L.fun/any22155.8 (lambda () (void)))
    (let ((ascii-char0.5 (call L.fun/ascii-char22152.6))
          (ascii-char1.4 (call L.fun/ascii-char22153.5))
          (void2.3 (call L.fun/void22154.7))
          (boolean3.2 (call void? (call L.fun/any22155.8)))
          (boolean4.1 (call ascii-char? (call L.fun/any22156.4))))
      ascii-char1.4)))
(check-by-interp
 '(module
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
       +
       (call - (call + 237 212) (call + 68 144))
       (call - (call * 197 48) (call * 159 227))))))
(check-by-interp
 '(module
    (define L.fun/vector22361.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char22363.5 (lambda () #\c))
    (define L.fun/ascii-char22359.6 (lambda () #\c))
    (define L.fun/any22362.7 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char22360.8 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char22359.6))
          (ascii-char1.4 (call L.fun/ascii-char22360.8))
          (vector2.3 (call L.fun/vector22361.4))
          (boolean3.2 (call boolean? (call L.fun/any22362.7)))
          (ascii-char4.1 (call L.fun/ascii-char22363.5)))
      ascii-char1.4)))
(check-by-interp
 '(module
    (define L.fun/vector22406.4 (lambda () (call make-vector 8)))
    (define L.fun/vector22405.5 (lambda () (call make-vector 8)))
    (define L.fun/error22407.6 (lambda () (error 2)))
    (define L.fun/ascii-char22404.7 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char22404.7))
          (vector1.4 (call L.fun/vector22405.5))
          (vector2.3 (call L.fun/vector22406.4))
          (fixnum3.2
           (call
            -
            (call * (call * 45 205) (call - 236 39))
            (call - (call + 124 242) (call + 129 44))))
          (error4.1 (call L.fun/error22407.6)))
      vector2.3)))
(check-by-interp
 '(module
    (define L.fun/vector22557.4 (lambda () (call make-vector 8)))
    (define L.fun/void22559.5 (lambda () (void)))
    (define L.fun/vector22558.6 (lambda () (call make-vector 8)))
    (define L.fun/empty22560.7 (lambda () empty))
    (let ((fixnum0.5
           (call
            +
            (call * (call - 201 66) (call + 247 80))
            (call + (call * 148 2) (call + 187 166))))
          (vector1.4 (call L.fun/vector22557.4))
          (vector2.3 (call L.fun/vector22558.6))
          (void3.2 (call L.fun/void22559.5))
          (empty4.1 (call L.fun/empty22560.7)))
      vector1.4)))
(check-by-interp
 '(module
    (define L.fun/ascii-char22583.4 (lambda () #\c))
    (define L.fun/any22584.5 (lambda () empty))
    (define L.fun/any22585.6 (lambda () empty))
    (define L.fun/empty22581.7 (lambda () empty))
    (define L.fun/ascii-char22582.8 (lambda () #\c))
    (let ((empty0.5 (call L.fun/empty22581.7))
          (fixnum1.4
           (call
            *
            (call * (call + 100 46) (call + 137 22))
            (call - (call - 185 166) (call - 194 99))))
          (ascii-char2.3 (call L.fun/ascii-char22582.8))
          (ascii-char3.2 (call L.fun/ascii-char22583.4))
          (boolean4.1 (call empty? (call L.fun/any22584.5))))
      (call empty? (call L.fun/any22585.6)))))
(check-by-interp
 '(module
    (define L.fun/void22702.4 (lambda () (void)))
    (define L.fun/error22701.5 (lambda () (error 125)))
    (define L.fun/any22703.6 (lambda () empty))
    (let ((error0.5 (call L.fun/error22701.5))
          (void1.4 (call L.fun/void22702.4))
          (boolean2.3 (call empty? (call L.fun/any22703.6)))
          (fixnum3.2
           (call
            *
            (call + (call + 49 222) (call * 135 152))
            (call * (call + 29 139) (call - 192 210))))
          (fixnum4.1
           (call
            *
            (call + (call * 42 172) (call + 66 25))
            (call * (call + 16 73) (call - 81 22)))))
      void1.4)))
(check-by-interp
 '(module
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
            +
            (call
             +
             (call + (call + 194 66) (call + 251 232))
             (call + (call * 108 115) (call + 23 219)))
            (call
             -
             (call - (call * 138 73) (call + 2 179))
             (call - (call * 92 140) (call * 244 126)))))
          (ascii-char4.2 (call L.fun/ascii-char23156.9))
          (error5.1 (call L.fun/error23158.12)))
      error5.1)))
(check-by-interp
 '(module
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
          (boolean3.3 (call ascii-char? (call L.fun/any24558.5)))
          (boolean4.2 (call empty? (call L.fun/any24559.11)))
          (empty5.1 (call L.fun/empty24560.8)))
      (call L.fun/ascii-char24562.7))))
(check-by-interp
 '(module
    (define L.fun/void26320.4 (lambda () (call L.fun/void26321.11)))
    (define L.fun/error26317.5 (lambda () (error 38)))
    (define L.fun/ascii-char26323.6 (lambda () #\c))
    (define L.fun/empty26318.7 (lambda () (call L.fun/empty26319.10)))
    (define L.fun/void26314.8 (lambda () (call L.fun/void26315.15)))
    (define L.fun/vector26324.9 (lambda () (call L.fun/vector26325.14)))
    (define L.fun/empty26319.10 (lambda () empty))
    (define L.fun/void26321.11 (lambda () (void)))
    (define L.fun/error26316.12 (lambda () (call L.fun/error26317.5)))
    (define L.fun/ascii-char26322.13
      (lambda () (call L.fun/ascii-char26323.6)))
    (define L.fun/vector26325.14 (lambda () (call make-vector 8)))
    (define L.fun/void26315.15 (lambda () (void)))
    (let ((void0.6 (call L.fun/void26314.8))
          (error1.5 (call L.fun/error26316.12))
          (empty2.4 (call L.fun/empty26318.7))
          (void3.3 (call L.fun/void26320.4))
          (ascii-char4.2 (call L.fun/ascii-char26322.13))
          (vector5.1 (call L.fun/vector26324.9)))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.fun/empty28807.4 (lambda () empty))
    (define L.fun/vector28798.5 (lambda () (call L.fun/vector28799.12)))
    (define L.fun/empty28806.6 (lambda () (call L.fun/empty28807.4)))
    (define L.fun/error28804.7 (lambda () (call L.fun/error28805.13)))
    (define L.fun/error28801.8 (lambda () (error 128)))
    (define L.fun/void28802.9 (lambda () (call L.fun/void28803.14)))
    (define L.fun/error28800.10 (lambda () (call L.fun/error28801.8)))
    (define L.fun/any28797.11 (lambda () 9))
    (define L.fun/vector28799.12 (lambda () (call make-vector 8)))
    (define L.fun/error28805.13 (lambda () (error 64)))
    (define L.fun/void28803.14 (lambda () (void)))
    (let ((boolean0.6 (call pair? (call L.fun/any28797.11)))
          (vector1.5 (call L.fun/vector28798.5))
          (error2.4 (call L.fun/error28800.10))
          (void3.3 (call L.fun/void28802.9))
          (error4.2 (call L.fun/error28804.7))
          (empty5.1 (call L.fun/empty28806.6)))
      void3.3)))
(check-by-interp
 '(module
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
            -
            (call
             +
             (call * (call + 236 137) (call - 132 27))
             (call * (call - 111 23) (call - 0 120)))
            (call
             -
             (call * (call - 247 107) (call - 202 245))
             (call + (call - 199 49) (call * 144 52)))))
          (fixnum4.2
           (call
            -
            (call
             +
             (call * (call + 145 98) (call - 50 36))
             (call - (call * 80 45) (call * 114 232)))
            (call
             *
             (call - (call * 45 242) (call - 64 37))
             (call + (call * 15 88) (call * 41 117)))))
          (ascii-char5.1 (call L.fun/ascii-char29405.9)))
      (call
       *
       (call * (call + (call - fixnum4.2 fixnum3.3) fixnum3.3) fixnum3.3)
       (call - fixnum4.2 (call - fixnum4.2 (call - 43 fixnum4.2)))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char31474.4 (lambda () #\c))
    (define L.fun/vector31478.5 (lambda () (call make-vector 8)))
    (define L.fun/error31475.6 (lambda () (call L.fun/error31476.10)))
    (define L.fun/empty31472.7 (lambda () empty))
    (define L.fun/ascii-char31479.8
      (lambda () (call L.fun/ascii-char31480.12)))
    (define L.fun/vector31477.9 (lambda () (call L.fun/vector31478.5)))
    (define L.fun/error31476.10 (lambda () (error 203)))
    (define L.fun/ascii-char31473.11
      (lambda () (call L.fun/ascii-char31474.4)))
    (define L.fun/ascii-char31480.12 (lambda () #\c))
    (define L.fun/empty31481.13 (lambda () (call L.fun/empty31482.15)))
    (define L.fun/empty31471.14 (lambda () (call L.fun/empty31472.7)))
    (define L.fun/empty31482.15 (lambda () empty))
    (let ((empty0.6 (call L.fun/empty31471.14))
          (ascii-char1.5 (call L.fun/ascii-char31473.11))
          (error2.4 (call L.fun/error31475.6))
          (vector3.3 (call L.fun/vector31477.9))
          (ascii-char4.2 (call L.fun/ascii-char31479.8))
          (empty5.1 (call L.fun/empty31481.13)))
      vector3.3)))
(check-by-interp
 '(module
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
            -
            (call
             -
             (call + (call - 34 78) (call * 33 115))
             (call + (call * 113 3) (call * 232 221)))
            (call
             -
             (call + (call * 158 210) (call * 88 13))
             (call - (call * 182 94) (call - 80 253)))))
          (void2.4 (call L.fun/void31690.8))
          (empty3.3 (call L.fun/empty31692.7))
          (boolean4.2 (call empty? (call L.fun/any31694.6)))
          (void5.1 (call L.fun/void31695.5)))
      empty0.6)))
(check-by-interp
 '(module
    (define L.fun/vector33321.4 (lambda () (call make-vector 8)))
    (define L.fun/vector33317.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char33318.6
      (lambda () (call L.fun/ascii-char33319.13)))
    (define L.fun/ascii-char33325.7 (lambda () #\c))
    (define L.fun/empty33322.8 (lambda () (call L.fun/empty33323.12)))
    (define L.fun/error33326.9 (lambda () (call L.fun/error33327.15)))
    (define L.fun/vector33320.10 (lambda () (call L.fun/vector33321.4)))
    (define L.fun/ascii-char33324.11
      (lambda () (call L.fun/ascii-char33325.7)))
    (define L.fun/empty33323.12 (lambda () empty))
    (define L.fun/ascii-char33319.13 (lambda () #\c))
    (define L.fun/vector33316.14 (lambda () (call L.fun/vector33317.5)))
    (define L.fun/error33327.15 (lambda () (error 39)))
    (let ((vector0.6 (call L.fun/vector33316.14))
          (ascii-char1.5 (call L.fun/ascii-char33318.6))
          (vector2.4 (call L.fun/vector33320.10))
          (empty3.3 (call L.fun/empty33322.8))
          (ascii-char4.2 (call L.fun/ascii-char33324.11))
          (error5.1 (call L.fun/error33326.9)))
      ascii-char1.5)))
(check-by-interp
 '(module
    (define L.fun/empty33353.4 (lambda () (call L.fun/empty33354.13)))
    (define L.fun/vector33343.5 (lambda () (call L.fun/vector33344.9)))
    (define L.fun/ascii-char33350.6 (lambda () #\c))
    (define L.fun/vector33348.7 (lambda () (call make-vector 8)))
    (define L.fun/empty33345.8 (lambda () (call L.fun/empty33346.12)))
    (define L.fun/vector33344.9 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char33351.10
      (lambda () (call L.fun/ascii-char33352.15)))
    (define L.fun/ascii-char33349.11
      (lambda () (call L.fun/ascii-char33350.6)))
    (define L.fun/empty33346.12 (lambda () empty))
    (define L.fun/empty33354.13 (lambda () empty))
    (define L.fun/vector33347.14 (lambda () (call L.fun/vector33348.7)))
    (define L.fun/ascii-char33352.15 (lambda () #\c))
    (let ((vector0.6 (call L.fun/vector33343.5))
          (empty1.5 (call L.fun/empty33345.8))
          (vector2.4 (call L.fun/vector33347.14))
          (ascii-char3.3 (call L.fun/ascii-char33349.11))
          (ascii-char4.2 (call L.fun/ascii-char33351.10))
          (empty5.1 (call L.fun/empty33353.4)))
      (call
       -
       (call
        -
        (call - (call - 101 146) (call - 205 203))
        (call * (call + 129 36) (call - 184 29)))
       (call
        *
        (call + (call + 129 212) (call + 84 128))
        (call - (call + 199 98) (call * 124 224)))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char37881.4 (lambda () #\c))
    (define L.fun/ascii-char37880.5 (lambda () (call L.fun/ascii-char37881.4)))
    (define L.fun/any37875.6 (lambda () #t))
    (define L.fun/error37883.7 (lambda () (error 63)))
    (define L.fun/empty37879.8 (lambda () empty))
    (define L.fun/vector37877.9 (lambda () (call make-vector 8)))
    (define L.fun/vector37876.10 (lambda () (call L.fun/vector37877.9)))
    (define L.fun/error37882.11 (lambda () (call L.fun/error37883.7)))
    (define L.fun/empty37878.12 (lambda () (call L.fun/empty37879.8)))
    (let ((boolean0.6 (call empty? (call L.fun/any37875.6)))
          (vector1.5 (call L.fun/vector37876.10))
          (empty2.4 (call L.fun/empty37878.12))
          (fixnum3.3
           (call
            +
            (call
             +
             (call + (call * 31 174) (call * 159 164))
             (call + (call - 140 34) (call - 172 160)))
            (call
             *
             (call + (call + 161 46) (call * 70 147))
             (call * (call * 11 195) (call * 138 11)))))
          (ascii-char4.2 (call L.fun/ascii-char37880.5))
          (error5.1 (call L.fun/error37882.11)))
      empty2.4)))
(check-by-interp
 '(module
    (define L.fun/void40451.4 (lambda () (call L.fun/void40452.6)))
    (define L.fun/vector40454.5 (lambda () (call make-vector 8)))
    (define L.fun/void40452.6 (lambda () (void)))
    (define L.fun/vector40453.7 (lambda () (call L.fun/vector40454.5)))
    (let ((fixnum0.6
           (call
            *
            (call
             -
             (call + (call - 124 70) (call + 146 105))
             (call - (call + 204 152) (call - 51 183)))
            (call
             +
             (call * (call * 114 51) (call + 19 49))
             (call - (call - 209 43) (call + 69 92)))))
          (void1.5 (call L.fun/void40451.4))
          (fixnum2.4
           (call
            +
            (call
             *
             (call * (call - 119 197) (call + 142 252))
             (call + (call * 226 141) (call - 210 130)))
            (call
             +
             (call - (call + 236 77) (call - 249 168))
             (call + (call - 120 123) (call + 230 8)))))
          (fixnum3.3
           (call
            +
            (call
             -
             (call * (call + 102 121) (call - 52 248))
             (call - (call - 5 26) (call - 219 177)))
            (call
             -
             (call - (call * 229 2) (call - 16 115))
             (call + (call - 104 97) (call + 24 174)))))
          (vector4.2 (call L.fun/vector40453.7))
          (fixnum5.1
           (call
            *
            (call
             -
             (call * (call + 180 153) (call + 82 221))
             (call * (call - 100 54) (call + 181 101)))
            (call
             -
             (call - (call - 174 127) (call - 168 75))
             (call + (call + 198 147) (call + 243 184))))))
      void1.5)))
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
    (define L.fun/vector41741.4 (lambda () (call L.fun/vector41742.5)))
    (define L.fun/vector41742.5 (lambda () (call make-vector 8)))
    (define L.fun/empty41735.6 (lambda () (call L.fun/empty41736.13)))
    (define L.fun/vector41744.7 (lambda () (call make-vector 8)))
    (define L.fun/vector41740.8 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char41737.9
      (lambda () (call L.fun/ascii-char41738.10)))
    (define L.fun/ascii-char41738.10 (lambda () #\c))
    (define L.fun/vector41743.11 (lambda () (call L.fun/vector41744.7)))
    (define L.fun/vector41739.12 (lambda () (call L.fun/vector41740.8)))
    (define L.fun/empty41736.13 (lambda () empty))
    (let ((empty0.6 (call L.fun/empty41735.6))
          (ascii-char1.5 (call L.fun/ascii-char41737.9))
          (vector2.4 (call L.fun/vector41739.12))
          (fixnum3.3
           (call
            +
            (call
             +
             (call + (call - 131 33) (call + 15 18))
             (call + (call * 198 171) (call - 83 105)))
            (call
             +
             (call - (call - 146 121) (call * 177 55))
             (call + (call * 16 175) (call * 207 96)))))
          (vector4.2 (call L.fun/vector41741.4))
          (vector5.1 (call L.fun/vector41743.11)))
      vector2.4)))
(check-by-interp
 '(module
    (define L.fun/error43435.4 (lambda () (error 119)))
    (define L.fun/ascii-char43427.5 (lambda () #\c))
    (define L.fun/empty43433.6 (lambda () empty))
    (define L.fun/error43431.7 (lambda () (error 35)))
    (define L.fun/vector43429.8 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char43426.9 (lambda () (call L.fun/ascii-char43427.5)))
    (define L.fun/error43430.10 (lambda () (call L.fun/error43431.7)))
    (define L.fun/error43434.11 (lambda () (call L.fun/error43435.4)))
    (define L.fun/empty43432.12 (lambda () (call L.fun/empty43433.6)))
    (define L.fun/vector43428.13 (lambda () (call L.fun/vector43429.8)))
    (let ((ascii-char0.6 (call L.fun/ascii-char43426.9))
          (vector1.5 (call L.fun/vector43428.13))
          (fixnum2.4
           (call
            *
            (call
             *
             (call * (call * 73 65) (call - 105 63))
             (call + (call - 16 226) (call - 140 76)))
            (call
             -
             (call * (call - 183 201) (call * 13 174))
             (call * (call + 206 191) (call + 77 42)))))
          (error3.3 (call L.fun/error43430.10))
          (empty4.2 (call L.fun/empty43432.12))
          (error5.1 (call L.fun/error43434.11)))
      vector1.5)))
(check-by-interp
 '(module
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
            +
            (call
             +
             (call - (call - 205 103) (call * 157 2))
             (call + (call + 96 194) (call * 169 167)))
            (call
             *
             (call * (call * 176 129) (call + 118 20))
             (call - (call * 160 92) (call * 81 106)))))
          (ascii-char1.5 (call L.fun/ascii-char44603.10))
          (boolean2.4 (call fixnum? (call L.fun/any44605.6)))
          (error3.3 (call L.fun/error44606.7))
          (boolean4.2 (call void? (call L.fun/any44608.8)))
          (void5.1 (call L.fun/void44609.4)))
      void5.1)))
(check-by-interp
 '(module
    (define L.fun/error45483.4 (lambda () (call L.fun/error45484.6)))
    (define L.fun/void45488.5 (lambda () (void)))
    (define L.fun/error45484.6 (lambda () (error 182)))
    (define L.fun/void45487.7 (lambda () (call L.fun/void45488.5)))
    (define L.fun/any45489.8 (lambda () (error 216)))
    (define L.fun/vector45485.9 (lambda () (call L.fun/vector45486.10)))
    (define L.fun/vector45486.10 (lambda () (call make-vector 8)))
    (let ((error0.6 (call L.fun/error45483.4))
          (vector1.5 (call L.fun/vector45485.9))
          (void2.4 (call L.fun/void45487.7))
          (fixnum3.3
           (call
            -
            (call
             *
             (call - (call - 247 44) (call - 68 142))
             (call - (call - 68 146) (call * 114 224)))
            (call
             -
             (call * (call * 249 32) (call * 53 65))
             (call - (call * 85 210) (call * 218 130)))))
          (fixnum4.2
           (call
            +
            (call
             *
             (call * (call * 138 123) (call * 250 63))
             (call - (call * 171 165) (call * 1 57)))
            (call
             -
             (call + (call * 127 36) (call + 137 158))
             (call - (call * 68 22) (call * 57 0)))))
          (boolean5.1 (call empty? (call L.fun/any45489.8))))
      vector1.5)))
(check-by-interp
 '(module
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
            +
            (call
             *
             (call + (call * 129 204) (call - 6 33))
             (call * (call + 83 165) (call * 209 217)))
            (call
             *
             (call * (call * 168 88) (call + 198 249))
             (call + (call - 156 127) (call * 82 194)))))
          (fixnum5.1
           (call
            *
            (call
             -
             (call - (call + 233 74) (call * 49 252))
             (call + (call * 176 62) (call + 12 168)))
            (call
             *
             (call + (call - 137 58) (call + 224 237))
             (call + (call * 60 20) (call - 62 75))))))
      (call L.fun/void47023.7))))
(check-by-interp
 '(module
    (define L.fun/void47049.4 (lambda () (void)))
    (define L.fun/empty47040.5 (lambda () (call L.fun/empty47041.15)))
    (define L.fun/void47043.6 (lambda () (void)))
    (define L.fun/vector47038.7 (lambda () (call L.fun/vector47039.8)))
    (define L.fun/vector47039.8 (lambda () (call make-vector 8)))
    (define L.fun/vector47047.9 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char47044.10
      (lambda () (call L.fun/ascii-char47045.11)))
    (define L.fun/ascii-char47045.11 (lambda () #\c))
    (define L.fun/vector47046.12 (lambda () (call L.fun/vector47047.9)))
    (define L.fun/void47048.13 (lambda () (call L.fun/void47049.4)))
    (define L.fun/void47042.14 (lambda () (call L.fun/void47043.6)))
    (define L.fun/empty47041.15 (lambda () empty))
    (let ((vector0.6 (call L.fun/vector47038.7))
          (empty1.5 (call L.fun/empty47040.5))
          (void2.4 (call L.fun/void47042.14))
          (ascii-char3.3 (call L.fun/ascii-char47044.10))
          (vector4.2 (call L.fun/vector47046.12))
          (void5.1 (call L.fun/void47048.13)))
      (call
       +
       (call
        +
        (call * (call + 220 32) (call * 198 175))
        (call * (call - 247 250) (call * 252 58)))
       (call
        +
        (call + (call * 124 27) (call - 99 251))
        (call - (call - 168 241) (call - 193 74)))))))
(check-by-interp
 '(module
    (define L.fun/error47944.4 (lambda () (call L.fun/error47945.11)))
    (define L.fun/ascii-char47942.5
      (lambda () (call L.fun/ascii-char47943.12)))
    (define L.fun/ascii-char47949.6 (lambda () #\c))
    (define L.fun/error47947.7 (lambda () (error 86)))
    (define L.fun/vector47950.8 (lambda () (call L.fun/vector47951.9)))
    (define L.fun/vector47951.9 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char47948.10
      (lambda () (call L.fun/ascii-char47949.6)))
    (define L.fun/error47945.11 (lambda () (error 216)))
    (define L.fun/ascii-char47943.12 (lambda () #\c))
    (define L.fun/error47946.13 (lambda () (call L.fun/error47947.7)))
    (let ((ascii-char0.6 (call L.fun/ascii-char47942.5))
          (fixnum1.5
           (call
            +
            (call
             +
             (call - (call * 65 85) (call * 193 208))
             (call + (call - 72 146) (call - 117 51)))
            (call
             +
             (call * (call * 107 179) (call + 84 106))
             (call - (call + 204 38) (call - 90 226)))))
          (error2.4 (call L.fun/error47944.4))
          (error3.3 (call L.fun/error47946.13))
          (ascii-char4.2 (call L.fun/ascii-char47948.10))
          (fixnum5.1
           (call
            -
            (call
             +
             (call - (call + 133 184) (call + 96 88))
             (call * (call - 90 79) (call + 211 132)))
            (call
             +
             (call * (call * 131 252) (call - 65 35))
             (call * (call - 145 49) (call * 244 46))))))
      (call L.fun/vector47950.8))))
(check-by-interp
 '(module
    (define L.fun/error48429.4 (lambda () (error 123)))
    (define L.fun/void48432.5 (lambda () (call L.fun/void48433.10)))
    (define L.fun/empty48430.6 (lambda () (call L.fun/empty48431.7)))
    (define L.fun/empty48431.7 (lambda () empty))
    (define L.fun/any48434.8 (lambda () empty))
    (define L.fun/error48428.9 (lambda () (call L.fun/error48429.4)))
    (define L.fun/void48433.10 (lambda () (void)))
    (let ((fixnum0.6
           (call
            +
            (call
             +
             (call - (call - 240 252) (call + 197 162))
             (call - (call * 168 173) (call - 170 47)))
            (call
             -
             (call * (call + 1 181) (call * 239 247))
             (call + (call - 172 147) (call - 8 49)))))
          (fixnum1.5
           (call
            -
            (call
             *
             (call + (call * 65 198) (call + 178 239))
             (call + (call - 177 7) (call - 241 62)))
            (call
             -
             (call - (call * 209 167) (call - 54 187))
             (call - (call * 125 251) (call * 144 194)))))
          (error2.4 (call L.fun/error48428.9))
          (empty3.3 (call L.fun/empty48430.6))
          (void4.2 (call L.fun/void48432.5))
          (boolean5.1 (call void? (call L.fun/any48434.8))))
      fixnum0.6)))
(check-by-interp
 '(module
    (define L.fun/any48767.4 (lambda () (call make-vector 8)))
    (define L.fun/error48777.5 (lambda () (error 193)))
    (define L.fun/void48775.6 (lambda () (void)))
    (define L.fun/void48774.7 (lambda () (call L.fun/void48775.6)))
    (define L.fun/error48771.8 (lambda () (error 135)))
    (define L.fun/vector48768.9 (lambda () (call L.fun/vector48769.14)))
    (define L.fun/ascii-char48773.10 (lambda () #\c))
    (define L.fun/error48770.11 (lambda () (call L.fun/error48771.8)))
    (define L.fun/ascii-char48772.12
      (lambda () (call L.fun/ascii-char48773.10)))
    (define L.fun/error48776.13 (lambda () (call L.fun/error48777.5)))
    (define L.fun/vector48769.14 (lambda () (call make-vector 8)))
    (let ((boolean0.6 (call void? (call L.fun/any48767.4)))
          (vector1.5 (call L.fun/vector48768.9))
          (error2.4 (call L.fun/error48770.11))
          (ascii-char3.3 (call L.fun/ascii-char48772.12))
          (void4.2 (call L.fun/void48774.7))
          (error5.1 (call L.fun/error48776.13)))
      void4.2)))
(check-by-interp
 '(module
    (define L.fun/vector49002.4 (lambda () (call make-vector 8)))
    (define L.fun/vector49003.5 (lambda () (call L.fun/vector49004.10)))
    (define L.fun/error49006.6 (lambda () (error 187)))
    (define L.fun/empty49008.7 (lambda () empty))
    (define L.fun/void48999.8 (lambda () (call L.fun/void49000.15)))
    (define L.fun/error49009.9 (lambda () (call L.fun/error49010.11)))
    (define L.fun/vector49004.10 (lambda () (call make-vector 8)))
    (define L.fun/error49010.11 (lambda () (error 223)))
    (define L.fun/error49005.12 (lambda () (call L.fun/error49006.6)))
    (define L.fun/empty49007.13 (lambda () (call L.fun/empty49008.7)))
    (define L.fun/vector49001.14 (lambda () (call L.fun/vector49002.4)))
    (define L.fun/void49000.15 (lambda () (void)))
    (let ((void0.6 (call L.fun/void48999.8))
          (vector1.5 (call L.fun/vector49001.14))
          (vector2.4 (call L.fun/vector49003.5))
          (error3.3 (call L.fun/error49005.12))
          (empty4.2 (call L.fun/empty49007.13))
          (error5.1 (call L.fun/error49009.9)))
      vector1.5)))
(check-by-interp
 '(module
    (define L.fun/error50158.4 (lambda () (error 201)))
    (define L.fun/vector50165.5 (lambda () (call make-vector 8)))
    (define L.fun/error50162.6 (lambda () (error 230)))
    (define L.fun/any50163.7 (lambda () (call make-vector 8)))
    (define L.fun/error50161.8 (lambda () (call L.fun/error50162.6)))
    (define L.fun/ascii-char50160.9 (lambda () #\c))
    (define L.fun/void50155.10 (lambda () (call L.fun/void50156.14)))
    (define L.fun/vector50164.11 (lambda () (call L.fun/vector50165.5)))
    (define L.fun/ascii-char50159.12
      (lambda () (call L.fun/ascii-char50160.9)))
    (define L.fun/error50157.13 (lambda () (call L.fun/error50158.4)))
    (define L.fun/void50156.14 (lambda () (void)))
    (let ((void0.6 (call L.fun/void50155.10))
          (error1.5 (call L.fun/error50157.13))
          (ascii-char2.4 (call L.fun/ascii-char50159.12))
          (fixnum3.3
           (call
            +
            (call
             *
             (call - (call * 169 115) (call - 60 115))
             (call * (call - 157 177) (call - 6 83)))
            (call
             -
             (call * (call - 184 127) (call * 149 236))
             (call - (call + 91 224) (call + 185 108)))))
          (error4.2 (call L.fun/error50161.8))
          (boolean5.1 (call empty? (call L.fun/any50163.7))))
      (call L.fun/vector50164.11))))
(check-by-interp
 '(module
    (define L.fun/error50542.4 (lambda () (error 147)))
    (define L.fun/void50544.5 (lambda () (void)))
    (define L.fun/any50545.6 (lambda () (void)))
    (define L.fun/ascii-char50537.7
      (lambda () (call L.fun/ascii-char50538.11)))
    (define L.fun/vector50539.8 (lambda () (call L.fun/vector50540.12)))
    (define L.fun/error50541.9 (lambda () (call L.fun/error50542.4)))
    (define L.fun/empty50535.10 (lambda () (call L.fun/empty50536.13)))
    (define L.fun/ascii-char50538.11 (lambda () #\c))
    (define L.fun/vector50540.12 (lambda () (call make-vector 8)))
    (define L.fun/empty50536.13 (lambda () empty))
    (define L.fun/void50543.14 (lambda () (call L.fun/void50544.5)))
    (let ((empty0.6 (call L.fun/empty50535.10))
          (ascii-char1.5 (call L.fun/ascii-char50537.7))
          (vector2.4 (call L.fun/vector50539.8))
          (error3.3 (call L.fun/error50541.9))
          (void4.2 (call L.fun/void50543.14))
          (boolean5.1 (call ascii-char? (call L.fun/any50545.6))))
      vector2.4)))
(check-by-interp
 '(module
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
            +
            (call
             -
             (call - (call * 211 150) (call - 117 142))
             (call + (call + 81 168) (call - 220 87)))
            (call
             *
             (call * (call * 55 142) (call + 129 201))
             (call * (call - 129 1) (call - 0 213))))))
      (call L.fun/void52450.10))))
(check-by-interp
 '(module
    (define L.fun/empty53231.4 (lambda () empty))
    (define L.fun/any53225.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char53229.6 (lambda () #\c))
    (define L.fun/ascii-char53228.7 (lambda () (call L.fun/ascii-char53229.6)))
    (define L.fun/empty53227.8 (lambda () empty))
    (define L.fun/ascii-char53232.9
      (lambda () (call L.fun/ascii-char53233.12)))
    (define L.fun/empty53226.10 (lambda () (call L.fun/empty53227.8)))
    (define L.fun/empty53230.11 (lambda () (call L.fun/empty53231.4)))
    (define L.fun/ascii-char53233.12 (lambda () #\c))
    (define L.fun/error53235.13 (lambda () (error 55)))
    (define L.fun/error53234.14 (lambda () (call L.fun/error53235.13)))
    (let ((boolean0.6 (call ascii-char? (call L.fun/any53225.5)))
          (empty1.5 (call L.fun/empty53226.10))
          (ascii-char2.4 (call L.fun/ascii-char53228.7))
          (empty3.3 (call L.fun/empty53230.11))
          (fixnum4.2
           (call
            +
            (call
             *
             (call + (call * 124 77) (call * 42 115))
             (call - (call * 201 252) (call - 251 21)))
            (call
             *
             (call * (call * 138 254) (call + 99 176))
             (call + (call - 25 73) (call + 32 8)))))
          (ascii-char5.1 (call L.fun/ascii-char53232.9)))
      (call L.fun/error53234.14))))
(check-by-interp
 '(module
    (define L.fun/vector53786.4 (lambda () (call L.fun/vector53787.11)))
    (define L.fun/empty53785.5 (lambda () empty))
    (define L.fun/ascii-char53788.6 (lambda () (call L.fun/ascii-char53789.8)))
    (define L.fun/ascii-char53791.7 (lambda () #\c))
    (define L.fun/ascii-char53789.8 (lambda () #\c))
    (define L.fun/empty53784.9 (lambda () (call L.fun/empty53785.5)))
    (define L.fun/empty53793.10 (lambda () (call L.fun/empty53794.14)))
    (define L.fun/vector53787.11 (lambda () (call make-vector 8)))
    (define L.fun/any53792.12 (lambda () #\c))
    (define L.fun/ascii-char53790.13
      (lambda () (call L.fun/ascii-char53791.7)))
    (define L.fun/empty53794.14 (lambda () empty))
    (let ((empty0.6 (call L.fun/empty53784.9))
          (vector1.5 (call L.fun/vector53786.4))
          (ascii-char2.4 (call L.fun/ascii-char53788.6))
          (ascii-char3.3 (call L.fun/ascii-char53790.13))
          (boolean4.2 (call void? (call L.fun/any53792.12)))
          (empty5.1 (call L.fun/empty53793.10)))
      ascii-char3.3)))
(check-by-interp
 '(module
    (define L.fun/ascii-char54522.4 (lambda () (call L.fun/ascii-char54523.8)))
    (define L.fun/error54517.5 (lambda () (error 95)))
    (define L.fun/vector54521.6 (lambda () (call make-vector 8)))
    (define L.fun/void54525.7 (lambda () (void)))
    (define L.fun/ascii-char54523.8 (lambda () #\c))
    (define L.fun/error54518.9 (lambda () (call L.fun/error54519.13)))
    (define L.fun/vector54520.10 (lambda () (call L.fun/vector54521.6)))
    (define L.fun/void54524.11 (lambda () (call L.fun/void54525.7)))
    (define L.fun/error54516.12 (lambda () (call L.fun/error54517.5)))
    (define L.fun/error54519.13 (lambda () (error 10)))
    (let ((error0.6 (call L.fun/error54516.12))
          (fixnum1.5
           (call
            *
            (call
             *
             (call + (call - 77 57) (call - 98 104))
             (call + (call - 212 160) (call - 185 200)))
            (call
             +
             (call - (call + 147 81) (call + 33 114))
             (call * (call * 29 201) (call + 95 116)))))
          (error2.4 (call L.fun/error54518.9))
          (vector3.3 (call L.fun/vector54520.10))
          (ascii-char4.2 (call L.fun/ascii-char54522.4))
          (void5.1 (call L.fun/void54524.11)))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.fun/void54535.4 (lambda () (void)))
    (define L.fun/void54532.5 (lambda () (call L.fun/void54533.15)))
    (define L.fun/ascii-char54537.6 (lambda () #\c))
    (define L.fun/vector54530.7 (lambda () (call L.fun/vector54531.12)))
    (define L.fun/empty54539.8 (lambda () empty))
    (define L.fun/error54528.9 (lambda () (call L.fun/error54529.13)))
    (define L.fun/empty54538.10 (lambda () (call L.fun/empty54539.8)))
    (define L.fun/void54534.11 (lambda () (call L.fun/void54535.4)))
    (define L.fun/vector54531.12 (lambda () (call make-vector 8)))
    (define L.fun/error54529.13 (lambda () (error 217)))
    (define L.fun/ascii-char54536.14
      (lambda () (call L.fun/ascii-char54537.6)))
    (define L.fun/void54533.15 (lambda () (void)))
    (let ((error0.6 (call L.fun/error54528.9))
          (vector1.5 (call L.fun/vector54530.7))
          (void2.4 (call L.fun/void54532.5))
          (void3.3 (call L.fun/void54534.11))
          (ascii-char4.2 (call L.fun/ascii-char54536.14))
          (fixnum5.1
           (call
            +
            (call
             -
             (call + (call * 26 96) (call + 63 157))
             (call + (call * 118 180) (call - 87 85)))
            (call
             -
             (call + (call + 181 210) (call + 61 63))
             (call * (call * 223 71) (call + 48 206))))))
      (call L.fun/empty54538.10))))
(check-by-interp
 '(module
    (define L.fun/vector54731.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char54737.5 (lambda () #\c))
    (define L.fun/any54729.6 (lambda () #t))
    (define L.fun/vector54739.7 (lambda () (call make-vector 8)))
    (define L.fun/empty54734.8 (lambda () (call L.fun/empty54735.11)))
    (define L.fun/vector54730.9 (lambda () (call L.fun/vector54731.4)))
    (define L.fun/void54732.10 (lambda () (call L.fun/void54733.14)))
    (define L.fun/empty54735.11 (lambda () empty))
    (define L.fun/ascii-char54736.12
      (lambda () (call L.fun/ascii-char54737.5)))
    (define L.fun/vector54738.13 (lambda () (call L.fun/vector54739.7)))
    (define L.fun/void54733.14 (lambda () (void)))
    (let ((boolean0.6 (call void? (call L.fun/any54729.6)))
          (vector1.5 (call L.fun/vector54730.9))
          (void2.4 (call L.fun/void54732.10))
          (empty3.3 (call L.fun/empty54734.8))
          (ascii-char4.2 (call L.fun/ascii-char54736.12))
          (vector5.1 (call L.fun/vector54738.13)))
      void2.4)))
(check-by-interp
 '(module
    (define L.fun/any55519.4 (lambda () #\c))
    (define L.fun/ascii-char55520.5 (lambda () (call L.fun/ascii-char55521.9)))
    (define L.fun/vector55523.6 (lambda () (call make-vector 8)))
    (define L.fun/any55524.7 (lambda () #f))
    (define L.fun/empty55526.8 (lambda () empty))
    (define L.fun/ascii-char55521.9 (lambda () #\c))
    (define L.fun/vector55522.10 (lambda () (call L.fun/vector55523.6)))
    (define L.fun/empty55525.11 (lambda () (call L.fun/empty55526.8)))
    (let ((boolean0.6 (call boolean? (call L.fun/any55519.4)))
          (fixnum1.5
           (call
            +
            (call
             -
             (call + (call + 46 247) (call * 8 160))
             (call * (call + 167 7) (call - 50 11)))
            (call
             +
             (call - (call - 59 234) (call + 31 73))
             (call + (call + 122 151) (call + 171 26)))))
          (ascii-char2.4 (call L.fun/ascii-char55520.5))
          (vector3.3 (call L.fun/vector55522.10))
          (boolean4.2 (call fixnum? (call L.fun/any55524.7)))
          (empty5.1 (call L.fun/empty55525.11)))
      vector3.3)))
(check-by-interp
 '(module
    (define L.fun/error56381.4 (lambda () (call L.fun/error56382.10)))
    (define L.fun/void56379.5 (lambda () (call L.fun/void56380.14)))
    (define L.fun/vector56375.6 (lambda () (call L.fun/vector56376.13)))
    (define L.fun/error56383.7 (lambda () (call L.fun/error56384.8)))
    (define L.fun/error56384.8 (lambda () (error 47)))
    (define L.fun/ascii-char56386.9 (lambda () #\c))
    (define L.fun/error56382.10 (lambda () (error 76)))
    (define L.fun/empty56377.11 (lambda () (call L.fun/empty56378.12)))
    (define L.fun/empty56378.12 (lambda () empty))
    (define L.fun/vector56376.13 (lambda () (call make-vector 8)))
    (define L.fun/void56380.14 (lambda () (void)))
    (define L.fun/ascii-char56385.15
      (lambda () (call L.fun/ascii-char56386.9)))
    (let ((vector0.6 (call L.fun/vector56375.6))
          (empty1.5 (call L.fun/empty56377.11))
          (void2.4 (call L.fun/void56379.5))
          (error3.3 (call L.fun/error56381.4))
          (error4.2 (call L.fun/error56383.7))
          (ascii-char5.1 (call L.fun/ascii-char56385.15)))
      error3.3)))
(check-by-interp
 '(module
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
    (let ((boolean0.6 (call boolean? (call L.fun/any59063.6)))
          (fixnum1.5
           (call
            -
            (call
             +
             (call + (call * 21 6) (call + 183 44))
             (call + (call * 63 236) (call + 46 68)))
            (call
             *
             (call + (call + 231 244) (call + 241 196))
             (call - (call + 63 90) (call - 158 1)))))
          (ascii-char2.4 (call L.fun/ascii-char59064.4))
          (empty3.3 (call L.fun/empty59066.8))
          (ascii-char4.2 (call L.fun/ascii-char59068.5))
          (ascii-char5.1 (call L.fun/ascii-char59070.7)))
      fixnum1.5)))
(check-by-interp
 '(module
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
            -
            (call
             *
             (call * (call * 122 211) (call + 110 81))
             (call * (call * 253 95) (call - 54 31)))
            (call
             +
             (call + (call - 32 182) (call + 110 51))
             (call + (call + 104 80) (call - 0 154)))))
          (void5.1 (call L.fun/void59453.11)))
      error3.3)))
(check-by-interp
 '(module
    (define L.fun/vector59746.4 (lambda () (call L.fun/vector59747.13)))
    (define L.fun/empty59754.5 (lambda () (call L.fun/empty59755.11)))
    (define L.fun/void59750.6 (lambda () (call L.fun/void59751.7)))
    (define L.fun/void59751.7 (lambda () (void)))
    (define L.fun/error59752.8 (lambda () (call L.fun/error59753.12)))
    (define L.fun/empty59749.9 (lambda () empty))
    (define L.fun/empty59748.10 (lambda () (call L.fun/empty59749.9)))
    (define L.fun/empty59755.11 (lambda () empty))
    (define L.fun/error59753.12 (lambda () (error 191)))
    (define L.fun/vector59747.13 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char59756.14
      (lambda () (call L.fun/ascii-char59757.15)))
    (define L.fun/ascii-char59757.15 (lambda () #\c))
    (let ((vector0.6 (call L.fun/vector59746.4))
          (empty1.5 (call L.fun/empty59748.10))
          (void2.4 (call L.fun/void59750.6))
          (error3.3 (call L.fun/error59752.8))
          (empty4.2 (call L.fun/empty59754.5))
          (ascii-char5.1 (call L.fun/ascii-char59756.14)))
      empty1.5)))
(check-by-interp
 '(module
    (define L.fun/empty63444.4 (lambda () (call L.fun/empty63445.10)))
    (define L.fun/error63448.5 (lambda () (call L.fun/error63449.9)))
    (define L.fun/ascii-char63446.6
      (lambda () (call L.fun/ascii-char63447.11)))
    (define L.fun/ascii-char63442.7
      (lambda () (call L.fun/ascii-char63443.13)))
    (define L.fun/vector63441.8 (lambda () (call make-vector 8)))
    (define L.fun/error63449.9 (lambda () (error 172)))
    (define L.fun/empty63445.10 (lambda () empty))
    (define L.fun/ascii-char63447.11 (lambda () #\c))
    (define L.fun/vector63440.12 (lambda () (call L.fun/vector63441.8)))
    (define L.fun/ascii-char63443.13 (lambda () #\c))
    (let ((vector0.6 (call L.fun/vector63440.12))
          (ascii-char1.5 (call L.fun/ascii-char63442.7))
          (empty2.4 (call L.fun/empty63444.4))
          (ascii-char3.3 (call L.fun/ascii-char63446.6))
          (fixnum4.2
           (call
            -
            (call
             +
             (call + (call + 20 239) (call - 29 20))
             (call - (call - 72 105) (call * 7 138)))
            (call
             -
             (call * (call - 21 38) (call + 143 28))
             (call * (call - 209 191) (call - 130 206)))))
          (error5.1 (call L.fun/error63448.5)))
      fixnum4.2)))
(check-by-interp
 '(module
    (define L.fun/any65187.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char65195.5 (lambda () #\c))
    (define L.fun/empty65188.6 (lambda () empty))
    (define L.fun/empty65198.7 (lambda () empty))
    (define L.fun/ascii-char65185.8 (lambda () #\c))
    (define L.fun/any65192.9 (lambda () #t))
    (define L.fun/ascii-char65190.10 (lambda () #\c))
    (define L.fun/error65194.11 (lambda () (error 182)))
    (define L.fun/void65196.12 (lambda () (void)))
    (define L.fun/any65183.13 (lambda () (call make-vector 8)))
    (define L.fun/vector65182.14 (lambda () (call make-vector 8)))
    (define L.fun/void65186.15 (lambda () (void)))
    (define L.fun/error65197.16 (lambda () (error 154)))
    (define L.fun/error65191.17 (lambda () (error 44)))
    (define L.fun/vector65193.18 (lambda () (call make-vector 8)))
    (define L.fun/vector65184.19 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char65189.20 (lambda () #\c))
    (if (let ((vector0.6 (call L.fun/vector65182.14))
              (boolean1.5 (call void? (call L.fun/any65183.13)))
              (fixnum2.4 (call - (call * 214 141) (call - 23 250)))
              (vector3.3 (call L.fun/vector65184.19))
              (ascii-char4.2 (call L.fun/ascii-char65185.8))
              (void5.1 (call L.fun/void65186.15)))
          (call boolean? (call L.fun/any65187.4)))
      (let ((empty0.12 (call L.fun/empty65188.6))
            (ascii-char1.11 (call L.fun/ascii-char65189.20))
            (fixnum2.10 (call + (call + 214 231) (call - 100 196)))
            (ascii-char3.9 (call L.fun/ascii-char65190.10))
            (error4.8 (call L.fun/error65191.17))
            (boolean5.7 (call vector? (call L.fun/any65192.9))))
        empty0.12)
      (let ((vector0.18 (call L.fun/vector65193.18))
            (fixnum1.17 (call + (call + 205 233) (call - 250 41)))
            (error2.16 (call L.fun/error65194.11))
            (ascii-char3.15 (call L.fun/ascii-char65195.5))
            (void4.14 (call L.fun/void65196.12))
            (error5.13 (call L.fun/error65197.16)))
        (call L.fun/empty65198.7)))))
(check-by-interp
 '(module
    (define L.fun/error65698.4 (lambda () (error 163)))
    (define L.fun/ascii-char65700.5 (lambda () #\c))
    (define L.fun/ascii-char65699.6 (lambda () (call L.fun/ascii-char65700.5)))
    (define L.fun/vector65693.7 (lambda () (call L.fun/vector65694.8)))
    (define L.fun/vector65694.8 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char65695.9
      (lambda () (call L.fun/ascii-char65696.10)))
    (define L.fun/ascii-char65696.10 (lambda () #\c))
    (define L.fun/error65697.11 (lambda () (call L.fun/error65698.4)))
    (let ((fixnum0.6
           (call
            -
            (call
             -
             (call + (call * 118 4) (call - 80 69))
             (call * (call - 140 165) (call * 177 79)))
            (call
             *
             (call - (call + 0 251) (call + 143 104))
             (call - (call * 179 21) (call - 205 46)))))
          (vector1.5 (call L.fun/vector65693.7))
          (fixnum2.4
           (call
            +
            (call
             -
             (call - (call * 29 34) (call - 175 235))
             (call + (call + 141 66) (call * 95 181)))
            (call
             -
             (call - (call + 236 168) (call - 108 129))
             (call + (call * 121 152) (call + 106 153)))))
          (ascii-char3.3 (call L.fun/ascii-char65695.9))
          (error4.2 (call L.fun/error65697.11))
          (ascii-char5.1 (call L.fun/ascii-char65699.6)))
      (call * fixnum2.4 fixnum2.4))))
(check-by-interp
 '(module
    (define L.fun/empty67816.4 (lambda () empty))
    (define L.fun/vector67811.5 (lambda () (call L.fun/vector67812.9)))
    (define L.fun/any67817.6 (lambda () empty))
    (define L.fun/vector67819.7 (lambda () (call make-vector 8)))
    (define L.fun/error67814.8 (lambda () (error 87)))
    (define L.fun/vector67812.9 (lambda () (call make-vector 8)))
    (define L.fun/empty67815.10 (lambda () (call L.fun/empty67816.4)))
    (define L.fun/vector67818.11 (lambda () (call L.fun/vector67819.7)))
    (define L.fun/error67813.12 (lambda () (call L.fun/error67814.8)))
    (let ((vector0.6 (call L.fun/vector67811.5))
          (error1.5 (call L.fun/error67813.12))
          (empty2.4 (call L.fun/empty67815.10))
          (boolean3.3 (call empty? (call L.fun/any67817.6)))
          (fixnum4.2
           (call
            +
            (call
             -
             (call + (call - 125 98) (call - 113 90))
             (call * (call * 251 205) (call + 236 185)))
            (call
             *
             (call * (call * 94 170) (call - 242 237))
             (call * (call * 203 55) (call + 134 165)))))
          (vector5.1 (call L.fun/vector67818.11)))
      error1.5)))
(check-by-interp
 '(module
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
          (boolean2.4 (call void? (call L.fun/any72179.9)))
          (ascii-char3.3 (call L.fun/ascii-char72180.4))
          (boolean4.2 (call boolean? (call L.fun/any72182.10)))
          (fixnum5.1
           (call
            +
            (call
             -
             (call + (call - 32 33) (call - 121 173))
             (call - (call * 209 159) (call + 247 237)))
            (call
             +
             (call + (call - 247 159) (call - 14 109))
             (call + (call * 38 183) (call + 178 240))))))
      ascii-char3.3)))
(check-by-interp
 '(module
    (define L.fun/any73111.4 (lambda () #\c))
    (define L.fun/vector73119.5 (lambda () (call make-vector 8)))
    (define L.fun/empty73114.6 (lambda () (call L.fun/empty73115.10)))
    (define L.fun/error73113.7 (lambda () (error 225)))
    (define L.fun/vector73118.8 (lambda () (call L.fun/vector73119.5)))
    (define L.fun/empty73116.9 (lambda () (call L.fun/empty73117.11)))
    (define L.fun/empty73115.10 (lambda () empty))
    (define L.fun/empty73117.11 (lambda () empty))
    (define L.fun/error73112.12 (lambda () (call L.fun/error73113.7)))
    (let ((fixnum0.6
           (call
            -
            (call
             *
             (call * (call - 102 106) (call + 210 110))
             (call + (call * 49 7) (call + 239 142)))
            (call
             *
             (call * (call + 194 69) (call - 30 45))
             (call + (call - 241 245) (call - 31 18)))))
          (boolean1.5 (call pair? (call L.fun/any73111.4)))
          (error2.4 (call L.fun/error73112.12))
          (empty3.3 (call L.fun/empty73114.6))
          (empty4.2 (call L.fun/empty73116.9))
          (vector5.1 (call L.fun/vector73118.8)))
      empty4.2)))
(check-by-interp
 '(module
    (define L.fun/ascii-char73483.4 (lambda () #\c))
    (define L.fun/ascii-char73478.5
      (lambda () (call L.fun/ascii-char73479.13)))
    (define L.fun/error73480.6 (lambda () (call L.fun/error73481.8)))
    (define L.fun/void73474.7 (lambda () (call L.fun/void73475.11)))
    (define L.fun/error73481.8 (lambda () (error 144)))
    (define L.fun/vector73476.9 (lambda () (call L.fun/vector73477.10)))
    (define L.fun/vector73477.10 (lambda () (call make-vector 8)))
    (define L.fun/void73475.11 (lambda () (void)))
    (define L.fun/ascii-char73482.12
      (lambda () (call L.fun/ascii-char73483.4)))
    (define L.fun/ascii-char73479.13 (lambda () #\c))
    (let ((void0.6 (call L.fun/void73474.7))
          (vector1.5 (call L.fun/vector73476.9))
          (ascii-char2.4 (call L.fun/ascii-char73478.5))
          (fixnum3.3
           (call
            +
            (call
             *
             (call * (call - 244 207) (call * 97 228))
             (call - (call * 175 193) (call * 253 12)))
            (call
             -
             (call + (call - 60 148) (call + 215 182))
             (call - (call - 89 234) (call - 11 253)))))
          (error4.2 (call L.fun/error73480.6))
          (ascii-char5.1 (call L.fun/ascii-char73482.12)))
      (call
       *
       (call
        +
        (call - (call + fixnum3.3 129) (call + 233 81))
        (call + (call * fixnum3.3 139) (call - 152 165)))
       (call
        *
        (call + (call + fixnum3.3 fixnum3.3) (call + 243 fixnum3.3))
        fixnum3.3)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char74214.4 (lambda () #\c))
    (define L.fun/ascii-char74212.5 (lambda () #\c))
    (define L.fun/vector74218.6 (lambda () (call make-vector 8)))
    (define L.fun/error74216.7 (lambda () (error 152)))
    (define L.fun/void74210.8 (lambda () (void)))
    (define L.fun/ascii-char74211.9 (lambda () (call L.fun/ascii-char74212.5)))
    (define L.fun/void74209.10 (lambda () (call L.fun/void74210.8)))
    (define L.fun/error74207.11 (lambda () (call L.fun/error74208.14)))
    (define L.fun/vector74217.12 (lambda () (call L.fun/vector74218.6)))
    (define L.fun/ascii-char74213.13
      (lambda () (call L.fun/ascii-char74214.4)))
    (define L.fun/error74208.14 (lambda () (error 222)))
    (define L.fun/error74215.15 (lambda () (call L.fun/error74216.7)))
    (let ((error0.6 (call L.fun/error74207.11))
          (void1.5 (call L.fun/void74209.10))
          (ascii-char2.4 (call L.fun/ascii-char74211.9))
          (fixnum3.3
           (call
            *
            (call
             -
             (call + (call * 208 38) (call - 46 4))
             (call + (call - 23 0) (call + 202 244)))
            (call
             -
             (call + (call - 114 69) (call - 211 169))
             (call + (call - 64 11) (call + 190 224)))))
          (ascii-char4.2 (call L.fun/ascii-char74213.13))
          (error5.1 (call L.fun/error74215.15)))
      (call L.fun/vector74217.12))))
(check-by-interp
 '(module
    (define L.fun/error74460.4 (lambda () (error 77)))
    (define L.fun/vector74464.5 (lambda () (call L.fun/vector74465.11)))
    (define L.fun/void74462.6 (lambda () (void)))
    (define L.fun/ascii-char74457.7
      (lambda () (call L.fun/ascii-char74458.12)))
    (define L.fun/any74463.8 (lambda () (void)))
    (define L.fun/error74459.9 (lambda () (call L.fun/error74460.4)))
    (define L.fun/void74461.10 (lambda () (call L.fun/void74462.6)))
    (define L.fun/vector74465.11 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char74458.12 (lambda () #\c))
    (let ((fixnum0.6
           (call
            -
            (call
             -
             (call * (call + 68 187) (call + 122 164))
             (call + (call + 56 133) (call - 179 5)))
            (call
             *
             (call + (call - 219 147) (call + 113 27))
             (call + (call + 20 100) (call + 115 58)))))
          (ascii-char1.5 (call L.fun/ascii-char74457.7))
          (error2.4 (call L.fun/error74459.9))
          (void3.3 (call L.fun/void74461.10))
          (boolean4.2 (call vector? (call L.fun/any74463.8)))
          (vector5.1 (call L.fun/vector74464.5)))
      vector5.1)))
(check-by-interp
 '(module
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
            -
            (call
             -
             (call + (call - 155 235) (call * 95 108))
             (call * (call + 28 173) (call - 228 29)))
            (call
             *
             (call * (call + 67 93) (call + 240 16))
             (call + (call - 64 86) (call + 51 147)))))
          (empty1.5 (call L.fun/empty76143.10))
          (void2.4 (call L.fun/void76145.8))
          (empty3.3 (call L.fun/empty76147.4))
          (ascii-char4.2 (call L.fun/ascii-char76149.9))
          (void5.1 (call L.fun/void76151.13)))
      (call
       *
       (call * fixnum0.6 fixnum0.6)
       (call
        -
        (call + (call - fixnum0.6 fixnum0.6) fixnum0.6)
        (call - fixnum0.6 (call - 86 fixnum0.6)))))))
(check-by-interp
 '(module
    (define L.fun/void77894.4 (lambda () (void)))
    (define L.fun/error77897.5 (lambda () (call L.fun/error77898.14)))
    (define L.fun/vector77892.6 (lambda () (call make-vector 8)))
    (define L.fun/empty77895.7 (lambda () (call L.fun/empty77896.11)))
    (define L.fun/void77893.8 (lambda () (call L.fun/void77894.4)))
    (define L.fun/ascii-char77890.9 (lambda () #\c))
    (define L.fun/ascii-char77888.10 (lambda () #\c))
    (define L.fun/empty77896.11 (lambda () empty))
    (define L.fun/ascii-char77889.12
      (lambda () (call L.fun/ascii-char77890.9)))
    (define L.fun/ascii-char77887.13
      (lambda () (call L.fun/ascii-char77888.10)))
    (define L.fun/error77898.14 (lambda () (error 95)))
    (define L.fun/vector77891.15 (lambda () (call L.fun/vector77892.6)))
    (let ((ascii-char0.6 (call L.fun/ascii-char77887.13))
          (ascii-char1.5 (call L.fun/ascii-char77889.12))
          (vector2.4 (call L.fun/vector77891.15))
          (void3.3 (call L.fun/void77893.8))
          (empty4.2 (call L.fun/empty77895.7))
          (error5.1 (call L.fun/error77897.5)))
      vector2.4)))
(check-by-interp
 '(module
    (define L.fun/empty78856.4 (lambda () empty))
    (define L.fun/empty78853.5 (lambda () (call L.fun/empty78854.12)))
    (define L.fun/empty78849.6 (lambda () (call L.fun/empty78850.15)))
    (define L.fun/vector78851.7 (lambda () (call L.fun/vector78852.13)))
    (define L.fun/empty78859.8 (lambda () (call L.fun/empty78860.10)))
    (define L.fun/empty78855.9 (lambda () (call L.fun/empty78856.4)))
    (define L.fun/empty78860.10 (lambda () empty))
    (define L.fun/error78857.11 (lambda () (call L.fun/error78858.14)))
    (define L.fun/empty78854.12 (lambda () empty))
    (define L.fun/vector78852.13 (lambda () (call make-vector 8)))
    (define L.fun/error78858.14 (lambda () (error 90)))
    (define L.fun/empty78850.15 (lambda () empty))
    (let ((empty0.6 (call L.fun/empty78849.6))
          (vector1.5 (call L.fun/vector78851.7))
          (empty2.4 (call L.fun/empty78853.5))
          (empty3.3 (call L.fun/empty78855.9))
          (error4.2 (call L.fun/error78857.11))
          (empty5.1 (call L.fun/empty78859.8)))
      (call
       *
       (call
        +
        (call + (call - 34 55) (call + 164 227))
        (call - (call + 159 122) (call + 153 146)))
       (call
        +
        (call * (call * 163 88) (call * 2 218))
        (call + (call * 227 146) (call - 82 98)))))))
(check-by-interp
 '(module
    (define L.fun/void80571.4 (lambda () (void)))
    (define L.fun/error80566.5 (lambda () (call L.fun/error80567.12)))
    (define L.fun/ascii-char80576.6 (lambda () #\c))
    (define L.fun/vector80574.7 (lambda () (call make-vector 8)))
    (define L.fun/void80568.8 (lambda () (call L.fun/void80569.10)))
    (define L.fun/void80570.9 (lambda () (call L.fun/void80571.4)))
    (define L.fun/void80569.10 (lambda () (void)))
    (define L.fun/ascii-char80575.11
      (lambda () (call L.fun/ascii-char80576.6)))
    (define L.fun/error80567.12 (lambda () (error 139)))
    (define L.fun/any80572.13 (lambda () (error 41)))
    (define L.fun/vector80573.14 (lambda () (call L.fun/vector80574.7)))
    (let ((error0.6 (call L.fun/error80566.5))
          (void1.5 (call L.fun/void80568.8))
          (void2.4 (call L.fun/void80570.9))
          (boolean3.3 (call pair? (call L.fun/any80572.13)))
          (vector4.2 (call L.fun/vector80573.14))
          (ascii-char5.1 (call L.fun/ascii-char80575.11)))
      vector4.2)))
(check-by-interp
 '(module
    (define L.fun/ascii-char81022.4 (lambda () (call L.fun/ascii-char81023.5)))
    (define L.fun/ascii-char81023.5 (lambda () #\c))
    (define L.fun/void81027.6 (lambda () (void)))
    (define L.fun/error81021.7 (lambda () (error 17)))
    (define L.fun/empty81025.8 (lambda () empty))
    (define L.fun/vector81019.9 (lambda () (call make-vector 8)))
    (define L.fun/error81020.10 (lambda () (call L.fun/error81021.7)))
    (define L.fun/vector81018.11 (lambda () (call L.fun/vector81019.9)))
    (define L.fun/void81026.12 (lambda () (call L.fun/void81027.6)))
    (define L.fun/empty81024.13 (lambda () (call L.fun/empty81025.8)))
    (let ((vector0.6 (call L.fun/vector81018.11))
          (error1.5 (call L.fun/error81020.10))
          (fixnum2.4
           (call
            *
            (call
             +
             (call - (call * 237 18) (call - 157 99))
             (call + (call + 134 198) (call + 147 144)))
            (call
             *
             (call * (call - 200 51) (call + 118 238))
             (call - (call - 100 144) (call * 123 107)))))
          (ascii-char3.3 (call L.fun/ascii-char81022.4))
          (empty4.2 (call L.fun/empty81024.13))
          (void5.1 (call L.fun/void81026.12)))
      error1.5)))
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
    (define L.fun/void83998.4 (lambda () (call L.fun/void83999.12)))
    (define L.fun/error83996.5 (lambda () (call L.fun/error83997.10)))
    (define L.fun/void83994.6 (lambda () (call L.fun/void83995.8)))
    (define L.fun/ascii-char84001.7 (lambda () #\c))
    (define L.fun/void83995.8 (lambda () (void)))
    (define L.fun/vector83993.9 (lambda () (call make-vector 8)))
    (define L.fun/error83997.10 (lambda () (error 70)))
    (define L.fun/ascii-char84000.11
      (lambda () (call L.fun/ascii-char84001.7)))
    (define L.fun/void83999.12 (lambda () (void)))
    (define L.fun/vector83992.13 (lambda () (call L.fun/vector83993.9)))
    (let ((vector0.6 (call L.fun/vector83992.13))
          (void1.5 (call L.fun/void83994.6))
          (error2.4 (call L.fun/error83996.5))
          (void3.3 (call L.fun/void83998.4))
          (ascii-char4.2 (call L.fun/ascii-char84000.11))
          (fixnum5.1
           (call
            -
            (call
             *
             (call + (call * 181 217) (call + 10 63))
             (call + (call + 34 22) (call - 157 35)))
            (call
             *
             (call - (call - 79 125) (call * 120 202))
             (call + (call + 83 253) (call + 84 223))))))
      (call
       +
       (call
        *
        (call + fixnum5.1 (call + fixnum5.1 fixnum5.1))
        (call - fixnum5.1 (call - 104 145)))
       (call + (call - (call + 163 26) (call * 134 fixnum5.1)) fixnum5.1)))))
(check-by-interp
 '(module
    (define L.fun/void85079.4 (lambda () (void)))
    (define L.fun/empty85084.5 (lambda () (call L.fun/empty85085.8)))
    (define L.fun/empty85082.6 (lambda () (call L.fun/empty85083.13)))
    (define L.fun/error85087.7 (lambda () (error 196)))
    (define L.fun/empty85085.8 (lambda () empty))
    (define L.fun/error85080.9 (lambda () (call L.fun/error85081.14)))
    (define L.fun/void85078.10 (lambda () (call L.fun/void85079.4)))
    (define L.fun/any85077.11 (lambda () (call make-vector 8)))
    (define L.fun/error85086.12 (lambda () (call L.fun/error85087.7)))
    (define L.fun/empty85083.13 (lambda () empty))
    (define L.fun/error85081.14 (lambda () (error 171)))
    (let ((boolean0.6 (call void? (call L.fun/any85077.11)))
          (void1.5 (call L.fun/void85078.10))
          (error2.4 (call L.fun/error85080.9))
          (empty3.3 (call L.fun/empty85082.6))
          (empty4.2 (call L.fun/empty85084.5))
          (error5.1 (call L.fun/error85086.12)))
      empty4.2)))
(check-by-interp
 '(module
    (define L.fun/empty86109.4 (lambda () (call L.fun/empty86110.13)))
    (define L.fun/vector86106.5 (lambda () (call make-vector 8)))
    (define L.fun/vector86112.6 (lambda () (call make-vector 8)))
    (define L.fun/void86115.7 (lambda () (call L.fun/void86116.10)))
    (define L.fun/empty86108.8 (lambda () empty))
    (define L.fun/ascii-char86113.9
      (lambda () (call L.fun/ascii-char86114.11)))
    (define L.fun/void86116.10 (lambda () (void)))
    (define L.fun/ascii-char86114.11 (lambda () #\c))
    (define L.fun/vector86111.12 (lambda () (call L.fun/vector86112.6)))
    (define L.fun/empty86110.13 (lambda () empty))
    (define L.fun/vector86105.14 (lambda () (call L.fun/vector86106.5)))
    (define L.fun/empty86107.15 (lambda () (call L.fun/empty86108.8)))
    (let ((vector0.6 (call L.fun/vector86105.14))
          (empty1.5 (call L.fun/empty86107.15))
          (empty2.4 (call L.fun/empty86109.4))
          (vector3.3 (call L.fun/vector86111.12))
          (ascii-char4.2 (call L.fun/ascii-char86113.9))
          (void5.1 (call L.fun/void86115.7)))
      (call
       *
       (call
        *
        (call + (call + 139 118) (call * 92 127))
        (call - (call * 72 10) (call + 133 86)))
       (call
        *
        (call * (call * 111 21) (call * 124 95))
        (call - (call - 18 142) (call * 197 144)))))))
(check-by-interp
 '(module
    (define L.fun/void86192.4 (lambda () (void)))
    (define L.fun/vector86197.5 (lambda () (call L.fun/vector86198.11)))
    (define L.fun/empty86194.6 (lambda () empty))
    (define L.fun/void86191.7 (lambda () (call L.fun/void86192.4)))
    (define L.fun/empty86193.8 (lambda () (call L.fun/empty86194.6)))
    (define L.fun/vector86196.9 (lambda () (call make-vector 8)))
    (define L.fun/vector86195.10 (lambda () (call L.fun/vector86196.9)))
    (define L.fun/vector86198.11 (lambda () (call make-vector 8)))
    (let ((void0.6 (call L.fun/void86191.7))
          (fixnum1.5
           (call
            *
            (call
             *
             (call + (call - 42 189) (call + 158 252))
             (call * (call + 188 97) (call * 152 105)))
            (call
             -
             (call - (call * 14 204) (call - 141 128))
             (call - (call - 115 205) (call + 212 124)))))
          (empty2.4 (call L.fun/empty86193.8))
          (fixnum3.3
           (call
            *
            (call
             +
             (call + (call - 168 105) (call * 54 11))
             (call - (call - 247 97) (call - 74 159)))
            (call
             -
             (call * (call - 7 39) (call * 143 121))
             (call * (call * 163 153) (call * 68 87)))))
          (vector4.2 (call L.fun/vector86195.10))
          (vector5.1 (call L.fun/vector86197.5)))
      empty2.4)))
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
    (define L.fun/empty87364.4 (lambda () (call L.fun/empty87365.9)))
    (define L.fun/vector87371.5 (lambda () (call L.fun/vector87372.14)))
    (define L.fun/void87367.6 (lambda () (call L.fun/void87368.13)))
    (define L.fun/vector87369.7 (lambda () (call L.fun/vector87370.12)))
    (define L.fun/any87366.8 (lambda () (void)))
    (define L.fun/empty87365.9 (lambda () empty))
    (define L.fun/empty87363.10 (lambda () empty))
    (define L.fun/empty87362.11 (lambda () (call L.fun/empty87363.10)))
    (define L.fun/vector87370.12 (lambda () (call make-vector 8)))
    (define L.fun/void87368.13 (lambda () (void)))
    (define L.fun/vector87372.14 (lambda () (call make-vector 8)))
    (let ((empty0.6 (call L.fun/empty87362.11))
          (empty1.5 (call L.fun/empty87364.4))
          (boolean2.4 (call boolean? (call L.fun/any87366.8)))
          (void3.3 (call L.fun/void87367.6))
          (vector4.2 (call L.fun/vector87369.7))
          (vector5.1 (call L.fun/vector87371.5)))
      empty0.6)))
(check-by-interp
 '(module
    (define L.fun/error87568.4 (lambda () (error 156)))
    (define L.fun/empty87561.5 (lambda () (call L.fun/empty87562.6)))
    (define L.fun/empty87562.6 (lambda () empty))
    (define L.fun/error87567.7 (lambda () (call L.fun/error87568.4)))
    (define L.fun/any87569.8 (lambda () empty))
    (define L.fun/void87565.9 (lambda () (call L.fun/void87566.14)))
    (define L.fun/error87571.10 (lambda () (error 120)))
    (define L.fun/ascii-char87572.11
      (lambda () (call L.fun/ascii-char87573.13)))
    (define L.fun/vector87563.12 (lambda () (call L.fun/vector87564.15)))
    (define L.fun/ascii-char87573.13 (lambda () #\c))
    (define L.fun/void87566.14 (lambda () (void)))
    (define L.fun/vector87564.15 (lambda () (call make-vector 8)))
    (define L.fun/error87570.16 (lambda () (call L.fun/error87571.10)))
    (let ((empty0.6 (call L.fun/empty87561.5))
          (vector1.5 (call L.fun/vector87563.12))
          (void2.4 (call L.fun/void87565.9))
          (error3.3 (call L.fun/error87567.7))
          (boolean4.2 (call fixnum? (call L.fun/any87569.8)))
          (error5.1 (call L.fun/error87570.16)))
      (call L.fun/ascii-char87572.11))))
(check-by-interp
 '(module
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
          (boolean1.5 (call empty? (call L.fun/any89588.4)))
          (void2.4 (call L.fun/void89589.14))
          (error3.3 (call L.fun/error89591.12))
          (void4.2 (call L.fun/void89593.13))
          (void5.1 (call L.fun/void89595.9)))
      (call
       *
       (call
        *
        (call + (call * 18 204) (call * 183 177))
        (call - (call + 144 133) (call - 137 104)))
       (call
        *
        (call * (call + 86 31) (call * 250 30))
        (call + (call + 100 130) (call * 153 39)))))))
(check-by-interp
 '(module
    (define L.fun/vector90477.4 (lambda () (call L.fun/vector90478.7)))
    (define L.fun/vector90476.5 (lambda () (call make-vector 8)))
    (define L.fun/error90481.6 (lambda () (error 227)))
    (define L.fun/vector90478.7 (lambda () (call make-vector 8)))
    (define L.fun/void90483.8 (lambda () (void)))
    (define L.fun/any90479.9 (lambda () empty))
    (define L.fun/void90482.10 (lambda () (call L.fun/void90483.8)))
    (define L.fun/vector90475.11 (lambda () (call L.fun/vector90476.5)))
    (define L.fun/ascii-char90485.12 (lambda () #\c))
    (define L.fun/ascii-char90484.13
      (lambda () (call L.fun/ascii-char90485.12)))
    (define L.fun/error90480.14 (lambda () (call L.fun/error90481.6)))
    (let ((vector0.6 (call L.fun/vector90475.11))
          (vector1.5 (call L.fun/vector90477.4))
          (boolean2.4 (call empty? (call L.fun/any90479.9)))
          (error3.3 (call L.fun/error90480.14))
          (void4.2 (call L.fun/void90482.10))
          (fixnum5.1
           (call
            +
            (call
             *
             (call * (call - 96 29) (call + 150 82))
             (call - (call * 44 78) (call + 40 219)))
            (call
             +
             (call + (call - 246 245) (call * 53 97))
             (call * (call * 100 135) (call + 27 105))))))
      (call L.fun/ascii-char90484.13))))
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
    (define L.fun/error92012.4 (lambda () (call L.fun/error92013.10)))
    (define L.fun/any92007.5 (lambda () (call make-vector 8)))
    (define L.fun/empty92016.6 (lambda () (call L.fun/empty92017.12)))
    (define L.fun/void92014.7 (lambda () (call L.fun/void92015.13)))
    (define L.fun/void92011.8 (lambda () (void)))
    (define L.fun/ascii-char92008.9
      (lambda () (call L.fun/ascii-char92009.14)))
    (define L.fun/error92013.10 (lambda () (error 169)))
    (define L.fun/void92010.11 (lambda () (call L.fun/void92011.8)))
    (define L.fun/empty92017.12 (lambda () empty))
    (define L.fun/void92015.13 (lambda () (void)))
    (define L.fun/ascii-char92009.14 (lambda () #\c))
    (let ((fixnum0.6
           (call
            -
            (call
             +
             (call - (call + 116 28) (call * 7 187))
             (call - (call * 108 30) (call + 87 64)))
            (call
             -
             (call + (call * 201 236) (call * 56 172))
             (call * (call * 70 173) (call * 150 164)))))
          (boolean1.5 (call fixnum? (call L.fun/any92007.5)))
          (ascii-char2.4 (call L.fun/ascii-char92008.9))
          (void3.3 (call L.fun/void92010.11))
          (error4.2 (call L.fun/error92012.4))
          (void5.1 (call L.fun/void92014.7)))
      (call L.fun/empty92016.6))))
(check-by-interp
 '(module
    (define L.fun/ascii-char92849.4 (lambda () #\c))
    (define L.fun/empty92859.5 (lambda () empty))
    (define L.fun/void92853.6 (lambda () (void)))
    (define L.fun/ascii-char92857.7 (lambda () #\c))
    (define L.fun/empty92858.8 (lambda () (call L.fun/empty92859.5)))
    (define L.fun/vector92855.9 (lambda () (call make-vector 8)))
    (define L.fun/vector92854.10 (lambda () (call L.fun/vector92855.9)))
    (define L.fun/ascii-char92856.11
      (lambda () (call L.fun/ascii-char92857.7)))
    (define L.fun/error92850.12 (lambda () (call L.fun/error92851.14)))
    (define L.fun/ascii-char92848.13
      (lambda () (call L.fun/ascii-char92849.4)))
    (define L.fun/error92851.14 (lambda () (error 220)))
    (define L.fun/void92852.15 (lambda () (call L.fun/void92853.6)))
    (let ((ascii-char0.6 (call L.fun/ascii-char92848.13))
          (fixnum1.5
           (call
            +
            (call
             -
             (call - (call + 111 242) (call * 87 26))
             (call - (call + 80 171) (call * 185 147)))
            (call
             +
             (call - (call * 87 145) (call - 89 225))
             (call - (call * 222 100) (call - 3 47)))))
          (error2.4 (call L.fun/error92850.12))
          (void3.3 (call L.fun/void92852.15))
          (vector4.2 (call L.fun/vector92854.10))
          (ascii-char5.1 (call L.fun/ascii-char92856.11)))
      (call L.fun/empty92858.8))))
(check-by-interp
 '(module
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
            *
            (call
             *
             (call + (call * 229 205) (call - 172 26))
             (call + (call - 102 5) (call * 216 181)))
            (call
             -
             (call - (call + 94 137) (call - 74 199))
             (call - (call + 25 250) (call - 142 24)))))
          (error3.3 (call L.fun/error93189.6))
          (error4.2 (call L.fun/error93191.13))
          (void5.1 (call L.fun/void93193.8)))
      (call
       +
       (call
        -
        (call + fixnum2.4 fixnum2.4)
        (call + (call * fixnum2.4 183) (call * fixnum2.4 219)))
       (call - fixnum2.4 fixnum2.4)))))
(check-by-interp
 '(module
    (define L.fun/any95251.4 (lambda () 92))
    (define L.fun/error95248.5 (lambda () (call L.fun/error95249.12)))
    (define L.fun/error95247.6 (lambda () (error 229)))
    (define L.fun/any95253.7 (lambda () #\c))
    (define L.fun/vector95254.8 (lambda () (call L.fun/vector95255.10)))
    (define L.fun/any95252.9 (lambda () (call make-vector 8)))
    (define L.fun/vector95255.10 (lambda () (call make-vector 8)))
    (define L.fun/any95250.11 (lambda () (call make-vector 8)))
    (define L.fun/error95249.12 (lambda () (error 61)))
    (define L.fun/error95246.13 (lambda () (call L.fun/error95247.6)))
    (let ((error0.6 (call L.fun/error95246.13))
          (error1.5 (call L.fun/error95248.5))
          (boolean2.4 (call vector? (call L.fun/any95250.11)))
          (boolean3.3 (call void? (call L.fun/any95251.4)))
          (boolean4.2 (call empty? (call L.fun/any95252.9)))
          (boolean5.1 (call empty? (call L.fun/any95253.7))))
      (call L.fun/vector95254.8))))
(check-by-interp
 '(module
    (define L.fun/empty98518.4 (lambda () (call L.fun/empty98519.12)))
    (define L.fun/error98520.5 (lambda () (call L.fun/error98521.6)))
    (define L.fun/error98521.6 (lambda () (error 37)))
    (define L.fun/vector98514.7 (lambda () (call L.fun/vector98515.11)))
    (define L.fun/empty98517.8 (lambda () empty))
    (define L.fun/error98522.9 (lambda () (call L.fun/error98523.13)))
    (define L.fun/empty98516.10 (lambda () (call L.fun/empty98517.8)))
    (define L.fun/vector98515.11 (lambda () (call make-vector 8)))
    (define L.fun/empty98519.12 (lambda () empty))
    (define L.fun/error98523.13 (lambda () (error 61)))
    (let ((fixnum0.6
           (call
            +
            (call
             -
             (call * (call * 33 14) (call - 81 120))
             (call - (call - 133 89) (call + 168 148)))
            (call
             *
             (call + (call - 140 73) (call * 204 30))
             (call * (call + 119 227) (call + 212 173)))))
          (vector1.5 (call L.fun/vector98514.7))
          (empty2.4 (call L.fun/empty98516.10))
          (empty3.3 (call L.fun/empty98518.4))
          (error4.2 (call L.fun/error98520.5))
          (error5.1 (call L.fun/error98522.9)))
      (call
       -
       fixnum0.6
       (call * fixnum0.6 (call - (call - 191 3) (call + 227 fixnum0.6)))))))
(check-by-interp
 '(module
    (define L.fun/vector98535.4 (lambda () (call make-vector 8)))
    (define L.fun/empty98532.5 (lambda () (call L.fun/empty98533.15)))
    (define L.fun/error98527.6 (lambda () (error 171)))
    (define L.fun/error98526.7 (lambda () (call L.fun/error98527.6)))
    (define L.fun/ascii-char98536.8
      (lambda () (call L.fun/ascii-char98537.12)))
    (define L.fun/vector98530.9 (lambda () (call L.fun/vector98531.13)))
    (define L.fun/empty98529.10 (lambda () empty))
    (define L.fun/vector98534.11 (lambda () (call L.fun/vector98535.4)))
    (define L.fun/ascii-char98537.12 (lambda () #\c))
    (define L.fun/vector98531.13 (lambda () (call make-vector 8)))
    (define L.fun/empty98528.14 (lambda () (call L.fun/empty98529.10)))
    (define L.fun/empty98533.15 (lambda () empty))
    (let ((fixnum0.6
           (call
            +
            (call
             *
             (call + (call * 49 228) (call - 118 134))
             (call + (call + 107 126) (call + 209 63)))
            (call
             *
             (call - (call * 94 240) (call * 154 180))
             (call * (call * 202 22) (call + 62 106)))))
          (error1.5 (call L.fun/error98526.7))
          (empty2.4 (call L.fun/empty98528.14))
          (vector3.3 (call L.fun/vector98530.9))
          (empty4.2 (call L.fun/empty98532.5))
          (vector5.1 (call L.fun/vector98534.11)))
      (call L.fun/ascii-char98536.8))))
(check-by-interp
 '(module
    (define L.fun/void98954.4 (lambda () (call L.fun/void98955.13)))
    (define L.fun/error98959.5 (lambda () (error 156)))
    (define L.fun/error98952.6 (lambda () (call L.fun/error98953.9)))
    (define L.fun/vector98960.7 (lambda () (call L.fun/vector98961.12)))
    (define L.fun/vector98956.8 (lambda () (call L.fun/vector98957.10)))
    (define L.fun/error98953.9 (lambda () (error 220)))
    (define L.fun/vector98957.10 (lambda () (call make-vector 8)))
    (define L.fun/error98958.11 (lambda () (call L.fun/error98959.5)))
    (define L.fun/vector98961.12 (lambda () (call make-vector 8)))
    (define L.fun/void98955.13 (lambda () (void)))
    (let ((error0.6 (call L.fun/error98952.6))
          (fixnum1.5
           (call
            -
            (call
             +
             (call - (call + 162 51) (call - 98 71))
             (call * (call + 84 225) (call - 248 36)))
            (call
             *
             (call - (call + 207 202) (call - 120 113))
             (call * (call * 171 87) (call * 53 132)))))
          (void2.4 (call L.fun/void98954.4))
          (vector3.3 (call L.fun/vector98956.8))
          (error4.2 (call L.fun/error98958.11))
          (vector5.1 (call L.fun/vector98960.7)))
      (call
       +
       (call
        -
        (call + (call * fixnum1.5 243) (call - fixnum1.5 154))
        (call + (call * fixnum1.5 226) (call + 40 70)))
       (call - fixnum1.5 (call * (call + 6 fixnum1.5) fixnum1.5))))))
(check-by-interp
 '(module
    (define L.fun/empty101495.4 (lambda () (call L.fun/empty101496.12)))
    (define L.fun/ascii-char101493.5
      (lambda () (call L.fun/ascii-char101494.13)))
    (define L.fun/vector101492.6 (lambda () (call make-vector 8)))
    (define L.fun/error101498.7 (lambda () (call L.fun/error101499.8)))
    (define L.fun/error101499.8 (lambda () (error 7)))
    (define L.fun/vector101491.9 (lambda () (call L.fun/vector101492.6)))
    (define L.fun/error101489.10 (lambda () (call L.fun/error101490.14)))
    (define L.fun/any101497.11 (lambda () empty))
    (define L.fun/empty101496.12 (lambda () empty))
    (define L.fun/ascii-char101494.13 (lambda () #\c))
    (define L.fun/error101490.14 (lambda () (error 115)))
    (let ((error0.6 (call L.fun/error101489.10))
          (vector1.5 (call L.fun/vector101491.9))
          (ascii-char2.4 (call L.fun/ascii-char101493.5))
          (empty3.3 (call L.fun/empty101495.4))
          (boolean4.2 (call void? (call L.fun/any101497.11)))
          (error5.1 (call L.fun/error101498.7)))
      error0.6)))
(check-by-interp
 '(module
    (define L.fun/vector102190.4 (lambda () (call L.fun/vector102191.10)))
    (define L.fun/any102185.5 (lambda () empty))
    (define L.fun/vector102188.6 (lambda () (call L.fun/vector102189.8)))
    (define L.fun/ascii-char102187.7 (lambda () #\c))
    (define L.fun/vector102189.8 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char102186.9
      (lambda () (call L.fun/ascii-char102187.7)))
    (define L.fun/vector102191.10 (lambda () (call make-vector 8)))
    (let ((boolean0.6 (call vector? (call L.fun/any102185.5)))
          (fixnum1.5
           (call
            +
            (call
             *
             (call + (call + 83 92) (call - 36 175))
             (call * (call + 19 18) (call - 43 221)))
            (call
             +
             (call - (call + 112 176) (call * 209 122))
             (call + (call + 143 148) (call - 83 172)))))
          (ascii-char2.4 (call L.fun/ascii-char102186.9))
          (vector3.3 (call L.fun/vector102188.6))
          (fixnum4.2
           (call
            *
            (call
             +
             (call * (call - 140 86) (call * 97 190))
             (call + (call + 25 224) (call + 10 179)))
            (call
             *
             (call + (call + 244 138) (call + 164 130))
             (call + (call - 50 116) (call * 246 111)))))
          (vector5.1 (call L.fun/vector102190.4)))
      fixnum1.5)))
(check-by-interp
 '(module
    (define L.fun/vector102621.4 (lambda () (call L.fun/vector102622.13)))
    (define L.fun/ascii-char102628.5 (lambda () #\c))
    (define L.fun/ascii-char102625.6
      (lambda () (call L.fun/ascii-char102626.10)))
    (define L.fun/vector102623.7 (lambda () (call L.fun/vector102624.11)))
    (define L.fun/empty102620.8 (lambda () empty))
    (define L.fun/empty102619.9 (lambda () (call L.fun/empty102620.8)))
    (define L.fun/ascii-char102626.10 (lambda () #\c))
    (define L.fun/vector102624.11 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char102627.12
      (lambda () (call L.fun/ascii-char102628.5)))
    (define L.fun/vector102622.13 (lambda () (call make-vector 8)))
    (let ((fixnum0.6
           (call
            -
            (call
             +
             (call - (call * 130 215) (call * 15 193))
             (call * (call * 193 65) (call * 30 85)))
            (call
             *
             (call + (call + 160 10) (call * 72 132))
             (call + (call + 10 228) (call * 104 190)))))
          (empty1.5 (call L.fun/empty102619.9))
          (vector2.4 (call L.fun/vector102621.4))
          (vector3.3 (call L.fun/vector102623.7))
          (ascii-char4.2 (call L.fun/ascii-char102625.6))
          (ascii-char5.1 (call L.fun/ascii-char102627.12)))
      vector3.3)))
(check-by-interp
 '(module
    (define L.fun/empty102764.4 (lambda () empty))
    (define L.fun/error102771.5 (lambda () (call L.fun/error102772.11)))
    (define L.fun/vector102766.6 (lambda () (call make-vector 8)))
    (define L.fun/void102768.7 (lambda () (void)))
    (define L.fun/void102767.8 (lambda () (call L.fun/void102768.7)))
    (define L.fun/ascii-char102770.9 (lambda () #\c))
    (define L.fun/empty102763.10 (lambda () (call L.fun/empty102764.4)))
    (define L.fun/error102772.11 (lambda () (error 217)))
    (define L.fun/ascii-char102769.12
      (lambda () (call L.fun/ascii-char102770.9)))
    (define L.fun/vector102765.13 (lambda () (call L.fun/vector102766.6)))
    (let ((empty0.6 (call L.fun/empty102763.10))
          (fixnum1.5
           (call
            +
            (call
             -
             (call - (call + 30 159) (call + 16 20))
             (call + (call * 162 7) (call + 17 155)))
            (call
             +
             (call - (call - 6 149) (call - 30 50))
             (call - (call * 215 85) (call + 219 225)))))
          (vector2.4 (call L.fun/vector102765.13))
          (void3.3 (call L.fun/void102767.8))
          (ascii-char4.2 (call L.fun/ascii-char102769.12))
          (error5.1 (call L.fun/error102771.5)))
      vector2.4)))
(check-by-interp
 '(module
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
            +
            (call
             -
             (call + (call * 235 21) (call + 13 17))
             (call * (call * 44 93) (call + 57 240)))
            (call
             +
             (call * (call + 236 21) (call * 58 8))
             (call + (call + 44 20) (call + 144 189)))))
          (error3.3 (call L.fun/error103339.5))
          (boolean4.2 (call vector? (call L.fun/any103341.10)))
          (ascii-char5.1 (call L.fun/ascii-char103342.8)))
      error3.3)))
(check-by-interp
 '(module
    (define L.fun/empty105765.4 (lambda () empty))
    (define L.fun/void105770.5 (lambda () (call L.fun/void105771.13)))
    (define L.fun/any105774.6 (lambda () (call make-vector 8)))
    (define L.fun/error105773.7 (lambda () (error 62)))
    (define L.fun/empty105766.8 (lambda () (call L.fun/empty105767.10)))
    (define L.fun/empty105764.9 (lambda () (call L.fun/empty105765.4)))
    (define L.fun/empty105767.10 (lambda () empty))
    (define L.fun/ascii-char105769.11 (lambda () #\c))
    (define L.fun/error105772.12 (lambda () (call L.fun/error105773.7)))
    (define L.fun/void105771.13 (lambda () (void)))
    (define L.fun/ascii-char105768.14
      (lambda () (call L.fun/ascii-char105769.11)))
    (let ((empty0.6 (call L.fun/empty105764.9))
          (empty1.5 (call L.fun/empty105766.8))
          (ascii-char2.4 (call L.fun/ascii-char105768.14))
          (void3.3 (call L.fun/void105770.5))
          (error4.2 (call L.fun/error105772.12))
          (boolean5.1 (call vector? (call L.fun/any105774.6))))
      empty0.6)))
(check-by-interp
 '(module
    (define L.fun/void107063.4 (lambda () (void)))
    (define L.fun/any107059.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char107061.6 (lambda () #\c))
    (define L.fun/void107062.7 (lambda () (call L.fun/void107063.4)))
    (define L.fun/vector107064.8 (lambda () (call L.fun/vector107065.10)))
    (define L.fun/ascii-char107060.9
      (lambda () (call L.fun/ascii-char107061.6)))
    (define L.fun/vector107065.10 (lambda () (call make-vector 8)))
    (let ((boolean0.6 (call void? (call L.fun/any107059.5)))
          (fixnum1.5
           (call
            +
            (call
             *
             (call * (call + 12 240) (call * 25 98))
             (call * (call * 188 133) (call + 243 20)))
            (call
             -
             (call * (call - 22 171) (call + 196 163))
             (call * (call * 135 77) (call + 222 115)))))
          (ascii-char2.4 (call L.fun/ascii-char107060.9))
          (void3.3 (call L.fun/void107062.7))
          (vector4.2 (call L.fun/vector107064.8))
          (fixnum5.1
           (call
            +
            (call
             *
             (call * (call + 9 2) (call + 236 129))
             (call * (call * 189 155) (call * 5 177)))
            (call
             *
             (call * (call - 251 133) (call - 242 70))
             (call * (call * 229 157) (call + 86 169))))))
      void3.3)))
(check-by-interp
 '(module
    (define L.fun/any109024.4 (lambda () (void)))
    (define L.fun/vector109029.5 (lambda () (call L.fun/vector109030.11)))
    (define L.fun/vector109027.6 (lambda () (call L.fun/vector109028.9)))
    (define L.fun/void109025.7 (lambda () (call L.fun/void109026.10)))
    (define L.fun/void109032.8 (lambda () (void)))
    (define L.fun/vector109028.9 (lambda () (call make-vector 8)))
    (define L.fun/void109026.10 (lambda () (void)))
    (define L.fun/vector109030.11 (lambda () (call make-vector 8)))
    (define L.fun/void109031.12 (lambda () (call L.fun/void109032.8)))
    (let ((boolean0.6 (call error? (call L.fun/any109024.4)))
          (void1.5 (call L.fun/void109025.7))
          (vector2.4 (call L.fun/vector109027.6))
          (vector3.3 (call L.fun/vector109029.5))
          (void4.2 (call L.fun/void109031.12))
          (fixnum5.1
           (call
            +
            (call
             +
             (call - (call * 105 201) (call * 234 8))
             (call - (call * 165 225) (call + 169 126)))
            (call
             -
             (call + (call - 159 191) (call + 55 43))
             (call * (call - 64 43) (call * 54 66))))))
      void1.5)))
(check-by-interp
 '(module
    (define L.fun/vector111008.4 (lambda () (call L.fun/vector111009.5)))
    (define L.fun/vector111009.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char111007.6 (lambda () #\c))
    (define L.fun/ascii-char111001.7
      (lambda () (call L.fun/ascii-char111002.14)))
    (define L.fun/error111010.8 (lambda () (call L.fun/error111011.9)))
    (define L.fun/error111011.9 (lambda () (error 179)))
    (define L.fun/any111003.10 (lambda () (error 72)))
    (define L.fun/ascii-char111006.11
      (lambda () (call L.fun/ascii-char111007.6)))
    (define L.fun/void111005.12 (lambda () (void)))
    (define L.fun/void111004.13 (lambda () (call L.fun/void111005.12)))
    (define L.fun/ascii-char111002.14 (lambda () #\c))
    (let ((ascii-char0.6 (call L.fun/ascii-char111001.7))
          (boolean1.5 (call empty? (call L.fun/any111003.10)))
          (void2.4 (call L.fun/void111004.13))
          (ascii-char3.3 (call L.fun/ascii-char111006.11))
          (fixnum4.2
           (call
            *
            (call
             +
             (call - (call - 228 22) (call * 106 112))
             (call - (call * 10 220) (call + 146 218)))
            (call
             +
             (call - (call * 5 0) (call * 112 183))
             (call - (call - 248 44) (call - 93 191)))))
          (vector5.1 (call L.fun/vector111008.4)))
      (call L.fun/error111010.8))))
(check-by-interp
 '(module
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
          (boolean4.2 (call fixnum? (call L.fun/any111257.7)))
          (error5.1 (call L.fun/error111258.6)))
      error2.4)))
(check-by-interp
 '(module
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
            +
            (call
             -
             (call - (call * 123 41) (call * 91 111))
             (call - (call - 75 222) (call * 238 182)))
            (call
             -
             (call + (call - 159 192) (call * 132 114))
             (call - (call + 181 187) (call - 71 43)))))
          (void4.2 (call L.fun/void112730.4))
          (empty5.1 (call L.fun/empty112732.11)))
      (call
       +
       (call * (call + fixnum3.3 (call - fixnum3.3 149)) fixnum3.3)
       (call * fixnum3.3 (call * (call + fixnum3.3 39) fixnum3.3))))))
(check-by-interp
 '(module
    (define L.fun/vector114088.4 (lambda () (call make-vector 8)))
    (define L.fun/error114092.5 (lambda () (call L.fun/error114093.9)))
    (define L.fun/ascii-char114094.6
      (lambda () (call L.fun/ascii-char114095.8)))
    (define L.fun/error114091.7 (lambda () (error 173)))
    (define L.fun/ascii-char114095.8 (lambda () #\c))
    (define L.fun/error114093.9 (lambda () (error 116)))
    (define L.fun/vector114087.10 (lambda () (call L.fun/vector114088.4)))
    (define L.fun/error114090.11 (lambda () (call L.fun/error114091.7)))
    (define L.fun/any114089.12 (lambda () (error 188)))
    (let ((vector0.6 (call L.fun/vector114087.10))
          (boolean1.5 (call fixnum? (call L.fun/any114089.12)))
          (error2.4 (call L.fun/error114090.11))
          (fixnum3.3
           (call
            *
            (call
             +
             (call - (call + 138 240) (call + 46 151))
             (call + (call - 49 42) (call + 150 10)))
            (call
             *
             (call - (call - 189 50) (call * 211 252))
             (call + (call - 15 247) (call - 119 233)))))
          (error4.2 (call L.fun/error114092.5))
          (fixnum5.1
           (call
            +
            (call
             *
             (call + (call * 27 225) (call * 64 148))
             (call - (call - 13 7) (call + 100 65)))
            (call
             -
             (call + (call * 2 50) (call * 209 243))
             (call + (call * 210 176) (call - 116 238))))))
      (call L.fun/ascii-char114094.6))))
(check-by-interp
 '(module
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
            +
            (call
             *
             (call * (call + 22 69) (call * 228 18))
             (call - (call + 123 158) (call * 4 160)))
            (call
             +
             (call + (call - 192 177) (call * 134 77))
             (call + (call + 48 247) (call + 50 161)))))
          (ascii-char2.4 (call L.fun/ascii-char117130.6))
          (fixnum3.3
           (call
            *
            (call
             +
             (call + (call - 72 168) (call + 66 227))
             (call - (call - 145 108) (call + 170 12)))
            (call
             -
             (call * (call + 30 43) (call * 241 135))
             (call * (call + 101 56) (call + 162 250)))))
          (ascii-char4.2 (call L.fun/ascii-char117132.4))
          (fixnum5.1
           (call
            +
            (call
             +
             (call - (call * 209 182) (call + 212 60))
             (call * (call - 40 77) (call * 127 132)))
            (call
             -
             (call - (call * 104 147) (call - 31 41))
             (call - (call + 115 244) (call * 40 125))))))
      ascii-char0.6)))
(check-by-interp
 '(module
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
            +
            (call
             +
             (call + (call + 123 180) (call - 76 74))
             (call + (call * 32 209) (call * 216 81)))
            (call
             -
             (call * (call - 40 194) (call * 220 220))
             (call * (call - 159 173) (call - 232 149)))))
          (error1.5 (call L.fun/error117483.7))
          (void2.4 (call L.fun/void117485.9))
          (boolean3.3 (call empty? (call L.fun/any117487.5)))
          (empty4.2 (call L.fun/empty117488.10))
          (void5.1 (call L.fun/void117490.6)))
      empty4.2)))
(check-by-interp
 '(module
    (define L.fun/empty117767.4 (lambda () empty))
    (define L.fun/error117761.5 (lambda () (error 80)))
    (define L.fun/ascii-char117765.6 (lambda () #\c))
    (define L.fun/error117762.7 (lambda () (call L.fun/error117763.9)))
    (define L.fun/vector117769.8 (lambda () (call make-vector 8)))
    (define L.fun/error117763.9 (lambda () (error 81)))
    (define L.fun/error117760.10 (lambda () (call L.fun/error117761.5)))
    (define L.fun/empty117766.11 (lambda () (call L.fun/empty117767.4)))
    (define L.fun/ascii-char117764.12
      (lambda () (call L.fun/ascii-char117765.6)))
    (define L.fun/vector117768.13 (lambda () (call L.fun/vector117769.8)))
    (let ((error0.6 (call L.fun/error117760.10))
          (error1.5 (call L.fun/error117762.7))
          (fixnum2.4
           (call
            -
            (call
             -
             (call + (call * 161 130) (call + 64 109))
             (call + (call + 24 80) (call * 67 164)))
            (call
             +
             (call - (call - 97 8) (call - 44 251))
             (call + (call - 80 247) (call - 177 26)))))
          (ascii-char3.3 (call L.fun/ascii-char117764.12))
          (empty4.2 (call L.fun/empty117766.11))
          (fixnum5.1
           (call
            +
            (call
             +
             (call + (call - 205 154) (call - 161 27))
             (call * (call - 58 124) (call * 55 110)))
            (call
             +
             (call + (call + 106 248) (call + 176 118))
             (call + (call - 215 46) (call - 208 162))))))
      (call L.fun/vector117768.13))))
(check-by-interp
 '(module
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
            *
            (call
             *
             (call * (call + 66 155) (call + 152 163))
             (call + (call - 194 117) (call + 236 95)))
            (call
             *
             (call - (call * 48 97) (call - 228 100))
             (call + (call + 122 150) (call - 188 233))))))
      ascii-char3.3)))
(check-by-interp
 '(module
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
    (let ((boolean0.6 (call pair? (call L.fun/any123822.9)))
          (error1.5 (call L.fun/error123823.7))
          (empty2.4 (call L.fun/empty123825.5))
          (void3.3 (call L.fun/void123827.4))
          (error4.2 (call L.fun/error123829.12))
          (empty5.1 (call L.fun/empty123831.6)))
      (call L.fun/ascii-char123833.13))))
(check-by-interp
 '(module
    (define L.fun/empty126710.4 (lambda () empty))
    (define L.fun/empty126709.5 (lambda () (call L.fun/empty126710.4)))
    (define L.fun/any126713.6 (lambda () #\c))
    (define L.fun/any126711.7 (lambda () 148))
    (define L.fun/any126712.8 (lambda () (void)))
    (let ((fixnum0.6
           (call
            -
            (call
             -
             (call + (call - 58 144) (call - 219 7))
             (call * (call - 124 113) (call + 16 61)))
            (call
             -
             (call * (call * 218 107) (call * 81 92))
             (call * (call * 13 89) (call - 33 237)))))
          (empty1.5 (call L.fun/empty126709.5))
          (boolean2.4 (call void? (call L.fun/any126711.7)))
          (fixnum3.3
           (call
            *
            (call
             *
             (call - (call + 9 113) (call - 102 56))
             (call + (call - 17 106) (call * 136 234)))
            (call
             +
             (call + (call - 47 122) (call * 223 38))
             (call - (call * 177 46) (call + 223 215)))))
          (boolean4.2 (call boolean? (call L.fun/any126712.8)))
          (boolean5.1 (call error? (call L.fun/any126713.6))))
      (call - fixnum3.3 (call + (call * fixnum0.6 fixnum3.3) fixnum0.6)))))
(check-by-interp
 '(module
    (define L.fun/any127352.4 (lambda () (void)))
    (define L.fun/empty127355.5 (lambda () (call L.fun/empty127356.10)))
    (define L.fun/vector127354.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char127346.7
      (lambda () (call L.fun/ascii-char127347.12)))
    (define L.fun/empty127350.8 (lambda () (call L.fun/empty127351.9)))
    (define L.fun/empty127351.9 (lambda () empty))
    (define L.fun/empty127356.10 (lambda () empty))
    (define L.fun/ascii-char127349.11 (lambda () #\c))
    (define L.fun/ascii-char127347.12 (lambda () #\c))
    (define L.fun/ascii-char127348.13
      (lambda () (call L.fun/ascii-char127349.11)))
    (define L.fun/vector127353.14 (lambda () (call L.fun/vector127354.6)))
    (let ((ascii-char0.6 (call L.fun/ascii-char127346.7))
          (ascii-char1.5 (call L.fun/ascii-char127348.13))
          (empty2.4 (call L.fun/empty127350.8))
          (boolean3.3 (call void? (call L.fun/any127352.4)))
          (vector4.2 (call L.fun/vector127353.14))
          (empty5.1 (call L.fun/empty127355.5)))
      (call
       +
       (call
        -
        (call + (call * 58 67) (call * 99 222))
        (call + (call + 205 119) (call - 175 231)))
       (call
        *
        (call * (call + 35 94) (call + 171 230))
        (call * (call + 202 15) (call - 170 45)))))))
(check-by-interp
 '(module
    (define L.fun/any128526.4 (lambda () #t))
    (define L.fun/vector128521.5 (lambda () (call make-vector 8)))
    (define L.fun/error128527.6 (lambda () (call L.fun/error128528.11)))
    (define L.fun/empty128519.7 (lambda () empty))
    (define L.fun/error128525.8 (lambda () (error 223)))
    (define L.fun/empty128518.9 (lambda () (call L.fun/empty128519.7)))
    (define L.fun/error128524.10 (lambda () (call L.fun/error128525.8)))
    (define L.fun/error128528.11 (lambda () (error 73)))
    (define L.fun/ascii-char128522.12
      (lambda () (call L.fun/ascii-char128523.14)))
    (define L.fun/vector128520.13 (lambda () (call L.fun/vector128521.5)))
    (define L.fun/ascii-char128523.14 (lambda () #\c))
    (let ((empty0.6 (call L.fun/empty128518.9))
          (vector1.5 (call L.fun/vector128520.13))
          (ascii-char2.4 (call L.fun/ascii-char128522.12))
          (error3.3 (call L.fun/error128524.10))
          (boolean4.2 (call empty? (call L.fun/any128526.4)))
          (error5.1 (call L.fun/error128527.6)))
      vector1.5)))
(check-by-interp
 '(module
    (define L.fun/ascii-char129540.4
      (lambda () (call L.fun/ascii-char129541.11)))
    (define L.fun/void129535.5 (lambda () (call L.fun/void129536.8)))
    (define L.fun/vector129542.6 (lambda () (call L.fun/vector129543.10)))
    (define L.fun/any129537.7 (lambda () #\c))
    (define L.fun/void129536.8 (lambda () (void)))
    (define L.fun/any129534.9 (lambda () (call make-vector 8)))
    (define L.fun/vector129543.10 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char129541.11 (lambda () #\c))
    (define L.fun/ascii-char129539.12 (lambda () #\c))
    (define L.fun/ascii-char129538.13
      (lambda () (call L.fun/ascii-char129539.12)))
    (let ((fixnum0.6
           (call
            +
            (call
             *
             (call + (call * 100 239) (call * 94 44))
             (call + (call + 204 183) (call - 140 14)))
            (call
             +
             (call - (call - 2 57) (call + 155 245))
             (call * (call - 180 229) (call - 87 76)))))
          (boolean1.5 (call empty? (call L.fun/any129534.9)))
          (void2.4 (call L.fun/void129535.5))
          (boolean3.3 (call error? (call L.fun/any129537.7)))
          (ascii-char4.2 (call L.fun/ascii-char129538.13))
          (ascii-char5.1 (call L.fun/ascii-char129540.4)))
      (call L.fun/vector129542.6))))
(check-by-interp
 '(module
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
    (let ((boolean0.6 (call vector? (call L.fun/any129830.12)))
          (ascii-char1.5 (call L.fun/ascii-char129831.10))
          (ascii-char2.4 (call L.fun/ascii-char129833.13))
          (empty3.3 (call L.fun/empty129835.11))
          (empty4.2 (call L.fun/empty129837.14))
          (empty5.1 (call L.fun/empty129839.16)))
      (call L.fun/error129841.4))))
(check-by-interp
 '(module
    (define L.fun/vector130258.4 (lambda () (call make-vector 8)))
    (define L.fun/vector130260.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char130262.6 (lambda () #\c))
    (define L.fun/void130255.7 (lambda () (call L.fun/void130256.10)))
    (define L.fun/vector130259.8 (lambda () (call L.fun/vector130260.5)))
    (define L.fun/ascii-char130261.9
      (lambda () (call L.fun/ascii-char130262.6)))
    (define L.fun/void130256.10 (lambda () (void)))
    (define L.fun/vector130257.11 (lambda () (call L.fun/vector130258.4)))
    (let ((fixnum0.6
           (call
            +
            (call
             *
             (call - (call + 242 56) (call + 147 183))
             (call * (call + 63 17) (call + 92 179)))
            (call
             +
             (call + (call * 123 128) (call * 13 192))
             (call - (call * 212 134) (call + 14 69)))))
          (void1.5 (call L.fun/void130255.7))
          (fixnum2.4
           (call
            *
            (call
             *
             (call - (call * 35 222) (call + 222 177))
             (call + (call + 140 216) (call - 50 38)))
            (call
             *
             (call - (call + 225 35) (call + 240 192))
             (call + (call * 23 187) (call - 55 36)))))
          (fixnum3.3
           (call
            *
            (call
             -
             (call * (call * 164 249) (call * 190 112))
             (call - (call * 204 37) (call - 132 17)))
            (call
             *
             (call + (call + 135 48) (call * 52 126))
             (call - (call + 132 49) (call + 65 193)))))
          (vector4.2 (call L.fun/vector130257.11))
          (vector5.1 (call L.fun/vector130259.8)))
      (call L.fun/ascii-char130261.9))))
(check-by-interp
 '(module
    (define L.fun/vector132253.4 (lambda () (call L.fun/vector132254.9)))
    (define L.fun/vector132246.5 (lambda () (call make-vector 8)))
    (define L.fun/vector132249.6 (lambda () (call L.fun/vector132250.11)))
    (define L.fun/ascii-char132248.7 (lambda () #\c))
    (define L.fun/ascii-char132251.8
      (lambda () (call L.fun/ascii-char132252.10)))
    (define L.fun/vector132254.9 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char132252.10 (lambda () #\c))
    (define L.fun/vector132250.11 (lambda () (call make-vector 8)))
    (define L.fun/vector132245.12 (lambda () (call L.fun/vector132246.5)))
    (define L.fun/ascii-char132247.13
      (lambda () (call L.fun/ascii-char132248.7)))
    (let ((vector0.6 (call L.fun/vector132245.12))
          (fixnum1.5
           (call
            -
            (call
             -
             (call + (call + 79 41) (call - 24 190))
             (call * (call + 189 126) (call * 185 222)))
            (call
             +
             (call + (call * 70 98) (call - 58 29))
             (call * (call - 140 159) (call + 100 142)))))
          (ascii-char2.4 (call L.fun/ascii-char132247.13))
          (vector3.3 (call L.fun/vector132249.6))
          (ascii-char4.2 (call L.fun/ascii-char132251.8))
          (vector5.1 (call L.fun/vector132253.4)))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.fun/empty134124.4 (lambda () empty))
    (define L.fun/empty134123.5 (lambda () (call L.fun/empty134124.4)))
    (define L.fun/vector134119.6 (lambda () (call L.fun/vector134120.14)))
    (define L.fun/void134116.7 (lambda () (void)))
    (define L.fun/vector134114.8 (lambda () (call make-vector 8)))
    (define L.fun/void134115.9 (lambda () (call L.fun/void134116.7)))
    (define L.fun/void134118.10 (lambda () (void)))
    (define L.fun/vector134113.11 (lambda () (call L.fun/vector134114.8)))
    (define L.fun/void134122.12 (lambda () (void)))
    (define L.fun/void134117.13 (lambda () (call L.fun/void134118.10)))
    (define L.fun/vector134120.14 (lambda () (call make-vector 8)))
    (define L.fun/error134112.15 (lambda () (error 139)))
    (define L.fun/error134111.16 (lambda () (call L.fun/error134112.15)))
    (define L.fun/void134121.17 (lambda () (call L.fun/void134122.12)))
    (let ((error0.6 (call L.fun/error134111.16))
          (vector1.5 (call L.fun/vector134113.11))
          (void2.4 (call L.fun/void134115.9))
          (void3.3 (call L.fun/void134117.13))
          (vector4.2 (call L.fun/vector134119.6))
          (void5.1 (call L.fun/void134121.17)))
      (call L.fun/empty134123.5))))
