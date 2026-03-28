#lang racket
(require cpsc411/compiler-lib
         cpsc411/langs/v8
         (only-in "../implement-safe-primops.rkt"))
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

(check-by-interp '(module (error 97)))
(check-by-interp '(module empty))
(check-by-interp '(module (let ((boolean0.1 #t)) (call make-vector 8))))
(check-by-interp
 '(module
    (define L.fun/vector8387.4 (lambda () (call make-vector 8)))
    (call L.fun/vector8387.4)))
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
    (define L.fun/empty8418.4 (lambda () empty))
    (define L.fun/ascii-char8419.5 (lambda () #\c))
    (let ((fixnum0.3 (call + 95 114))
          (fixnum1.2 (call - 48 208))
          (empty2.1 (call L.fun/empty8418.4)))
      (call L.fun/ascii-char8419.5))))
(check-by-interp
 '(module
    (define L.fun/vector8448.4 (lambda () (call make-vector 8)))
    (define L.fun/error8449.5 (lambda () (error 86)))
    (let ((fixnum0.3 (call * 100 7))
          (vector1.2 (call L.fun/vector8448.4))
          (fixnum2.1 (call - 208 27)))
      (call L.fun/error8449.5))))
(check-by-interp
 '(module
    (define L.fun/boolean8452.4 (lambda (oprand0.2 oprand1.1) oprand0.2))
    (define L.fun/ascii-char8453.5 (lambda (oprand0.4 oprand1.3) #\c))
    (if (call L.fun/boolean8452.4 #f #\c)
      (call L.fun/ascii-char8453.5 (error 29) (error 79))
      (let ((ascii-char0.7 #\c)
            (vector1.6 (call make-vector 8))
            (fixnum2.5 144))
        ascii-char0.7))))
(check-by-interp
 '(module
    (define L.fun/boolean8459.4 (lambda (oprand0.2 oprand1.1) oprand1.1))
    (define L.fun/boolean8460.5 (lambda (oprand0.4 oprand1.3) #t))
    (if (call L.fun/boolean8459.4 (error 206) #t)
      (if #f #f #t)
      (call L.fun/boolean8460.5 (call make-vector 8) (void)))))
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
    (define L.fun/vector8490.4 (lambda () (call make-vector 8)))
    (define L.fun/vector8491.5 (lambda () (call make-vector 8)))
    (define L.fun/empty8489.6 (lambda () empty))
    (let ((empty0.3 (call L.fun/empty8489.6))
          (vector1.2 (call L.fun/vector8490.4))
          (vector2.1 (call L.fun/vector8491.5)))
      empty0.3)))
(check-by-interp
 '(module
    (define L.fun/error8496.4 (lambda (oprand0.2 oprand1.1) (error 97)))
    (if (if #t #f #t)
      (call L.fun/error8496.4 (call make-vector 8) 77)
      (let ((fixnum0.5 250) (empty1.4 empty) (ascii-char2.3 #\c))
        (error 225)))))
(check-by-interp
 '(module
    (define L.fun/vector8505.4 (lambda () (call make-vector 8)))
    (define L.fun/empty8502.5 (lambda () empty))
    (define L.fun/ascii-char8503.6 (lambda () #\c))
    (define L.fun/ascii-char8504.7 (lambda () #\c))
    (let ((empty0.3 (call L.fun/empty8502.5))
          (ascii-char1.2 (call L.fun/ascii-char8503.6))
          (ascii-char2.1 (call L.fun/ascii-char8504.7)))
      (call L.fun/vector8505.4))))
(check-by-interp
 '(module
    (call
     *
     (call - (if #f 214 86) (if #t 185 16))
     (call
      -
      (if #f 44 33)
      (let ((ascii-char0.3 #\c) (error1.2 (error 51)) (empty2.1 empty)) 76)))))
(check-by-interp
 '(module
    (define L.fun/void8563.4 (lambda () (void)))
    (define L.fun/vector8562.5 (lambda () (call make-vector 8)))
    (define L.fun/empty8564.6 (lambda () empty))
    (let ((vector0.3 (call L.fun/vector8562.5))
          (boolean1.2 (call fixnum? #f))
          (void2.1 (call L.fun/void8563.4)))
      (call L.fun/empty8564.6))))
(check-by-interp
 '(module
    (define L.fun/boolean8567.4 (lambda (oprand0.2 oprand1.1) #f))
    (if (call L.fun/boolean8567.4 #\c #\c)
      (let ((boolean0.5 #t) (boolean1.4 #f) (error2.3 (error 155))) empty)
      (let ((vector0.8 (call make-vector 8))
            (fixnum1.7 78)
            (error2.6 (error 4)))
        empty))))
(check-by-interp
 '(module
    (define L.fun/boolean8570.4 (lambda (oprand0.2 oprand1.1) #f))
    (define L.fun/void8571.5 (lambda (oprand0.4 oprand1.3) (void)))
    (if (call L.fun/boolean8570.4 (error 247) (error 231))
      (let ((boolean0.7 #f) (empty1.6 empty) (vector2.5 (call make-vector 8)))
        (call vector-set! vector2.5 7 #\c))
      (call L.fun/void8571.5 #\c #f))))
(check-by-interp
 '(module
    (define L.fun/void8575.4 (lambda () (void)))
    (define L.fun/void8576.5 (lambda () (void)))
    (define L.fun/vector8574.6 (lambda () (call make-vector 8)))
    (define L.fun/empty8577.7 (lambda () empty))
    (let ((vector0.3 (call L.fun/vector8574.6))
          (void1.2 (call L.fun/void8575.4))
          (void2.1 (call L.fun/void8576.5)))
      (call L.fun/empty8577.7))))
(check-by-interp
 '(module
    (define L.fun/fixnum8668.4 (lambda (oprand0.3 oprand1.2 oprand2.1) 208))
    (call
     +
     (call
      -
      (call
       -
       (call L.fun/fixnum8668.4 #\c (error 242) (call make-vector 8))
       (let ((boolean0.7 #f)
             (void1.6 (void))
             (error2.5 (error 187))
             (fixnum3.4 95))
         173))
      (call + (if #t 102 141) (call + 9 72)))
     (call
      *
      (call
       *
       (if #f 174 247)
       (let ((void0.11 (void))
             (fixnum1.10 188)
             (boolean2.9 #t)
             (ascii-char3.8 #\c))
         fixnum1.10))
      (if #f 71 107)))))
(check-by-interp
 '(module
    (define L.fun/any8705.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) (call make-vector 8)))
    (define L.fun/empty8707.5 (lambda (oprand0.6 oprand1.5 oprand2.4) empty))
    (define L.fun/error8706.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) (error 21)))
    (if (call ascii-char? (call L.fun/any8705.4 94 #t 149))
      (call
       L.fun/error8706.6
       (let ((ascii-char0.13 #\c)
             (boolean1.12 #t)
             (error2.11 (error 24))
             (ascii-char3.10 #\c))
         empty)
       (call L.fun/empty8707.5 (error 235) #\c #\c)
       (if #f (call make-vector 8) (call make-vector 8)))
      (let ((vector0.17 (call make-vector 8))
            (ascii-char1.16 #\c)
            (ascii-char2.15 #\c)
            (fixnum3.14 46))
        (error 153)))))
(check-by-interp
 '(module
    (define L.fun/any8734.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) (error 161)))
    (if (call vector? (call L.fun/any8734.4 (error 23) empty #\c))
      (call * (call - 185 66) (if #t 186 174))
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
    (define L.fun/empty8806.4 (lambda () empty))
    (define L.fun/void8807.5 (lambda () (void)))
    (define L.fun/ascii-char8808.6 (lambda () #\c))
    (let ((empty0.4 (call L.fun/empty8806.4))
          (fixnum1.3 (call - (call - 201 108) (call + 41 44)))
          (fixnum2.2 (call - (call * 40 131) (call * 137 121)))
          (void3.1 (call L.fun/void8807.5)))
      (call L.fun/ascii-char8808.6))))
(check-by-interp
 '(module
    (define L.fun/void8834.4 (lambda () (void)))
    (define L.fun/empty8833.5 (lambda () empty))
    (define L.fun/ascii-char8832.6 (lambda () #\c))
    (define L.fun/vector8835.7 (lambda () (call make-vector 8)))
    (let ((fixnum0.4 (call + (call * 228 35) (call * 172 58)))
          (ascii-char1.3 (call L.fun/ascii-char8832.6))
          (empty2.2 (call L.fun/empty8833.5))
          (void3.1 (call L.fun/void8834.4)))
      (call L.fun/vector8835.7))))
(check-by-interp
 '(module
    (if (let ((vector0.4 (call make-vector 8))
              (void1.3 (void))
              (fixnum2.2 3)
              (void3.1 (void)))
          #f)
      (let ((fixnum0.8 99)
            (void1.7 (void))
            (ascii-char2.6 #\c)
            (fixnum3.5 125))
        228)
      (call
       *
       (let ((ascii-char0.12 #\c)
             (error1.11 (error 154))
             (fixnum2.10 220)
             (boolean3.9 #t))
         250)
       (call * 101 80)))))
(check-by-interp
 '(module
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
     (let ((boolean0.13 (call vector? #\c))
           (fixnum1.12 (call + 28 24))
           (error2.11 (call L.fun/error9035.6))
           (error3.10 (call L.fun/error9036.5)))
       (call fixnum? (void)))
     (let ((ascii-char0.17 (call L.fun/ascii-char9031.10 empty #f #t))
           (void1.16 (call L.fun/void9037.7))
           (ascii-char2.15 (call L.fun/ascii-char9031.10 empty #t #f))
           (empty3.14 (call L.fun/empty9038.9)))
       (call error? (void))))))
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
    (if (let ((fixnum0.4 159)
              (vector1.3 (call make-vector 8))
              (boolean2.2 #t)
              (fixnum3.1 89))
          boolean2.2)
      (let ((void0.8 (void))
            (vector1.7 (call make-vector 8))
            (ascii-char2.6 #\c)
            (empty3.5 empty))
        237)
      (if #f 165 107))))
(check-by-interp
 '(module
    (define L.fun/error9365.4 (lambda () (error 242)))
    (define L.fun/error9364.5 (lambda () (error 249)))
    (define L.fun/any9366.6 (lambda () #t))
    (define L.fun/error9363.7 (lambda () (error 238)))
    (define L.fun/empty9362.8 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty9362.8))
          (error1.3 (call L.fun/error9363.7))
          (error2.2 (call L.fun/error9364.5))
          (error3.1 (call L.fun/error9365.4)))
      (call boolean? (call L.fun/any9366.6)))))
(check-by-interp
 '(module
    (define L.fun/void9414.4 (lambda () (void)))
    (define L.fun/vector9416.5 (lambda () (call make-vector 8)))
    (define L.fun/error9415.6 (lambda () (error 23)))
    (define L.fun/void9417.7 (lambda () (void)))
    (let ((void0.4 (call L.fun/void9414.4))
          (error1.3 (call L.fun/error9415.6))
          (vector2.2 (call L.fun/vector9416.5))
          (void3.1 (call L.fun/void9417.7)))
      void3.1)))
(check-by-interp
 '(module
    (define L.fun/vector9554.4 (lambda () (call make-vector 8)))
    (define L.fun/empty9556.5 (lambda () empty))
    (define L.fun/ascii-char9553.6 (lambda () #\c))
    (define L.fun/empty9555.7 (lambda () empty))
    (define L.fun/error9557.8 (lambda () (error 43)))
    (let ((ascii-char0.4 (call L.fun/ascii-char9553.6))
          (vector1.3 (call L.fun/vector9554.4))
          (empty2.2 (call L.fun/empty9555.7))
          (empty3.1 (call L.fun/empty9556.5)))
      (call L.fun/error9557.8))))
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
    (define L.fun/ascii-char9674.4 (lambda () #\c))
    (define L.fun/error9677.5 (lambda () (error 254)))
    (define L.fun/any9676.6 (lambda () #t))
    (define L.fun/vector9675.7 (lambda () (call make-vector 8)))
    (let ((ascii-char0.4 (call L.fun/ascii-char9674.4))
          (vector1.3 (call L.fun/vector9675.7))
          (boolean2.2 (call error? (call L.fun/any9676.6)))
          (error3.1 (call L.fun/error9677.5)))
      vector1.3)))
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
    (define L.fun/boolean9711.4 (lambda (oprand0.3 oprand1.2 oprand2.1) #f))
    (define L.fun/error9714.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) (error 137)))
    (define L.fun/fixnum9715.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) oprand1.8))
    (define L.fun/void9712.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) (void)))
    (define L.fun/boolean9716.8 (lambda (oprand0.15 oprand1.14 oprand2.13) #f))
    (define L.fun/ascii-char9713.9
      (lambda (oprand0.18 oprand1.17 oprand2.16) #\c))
    (if (call
         L.fun/boolean9711.4
         (call L.fun/void9712.7 #f 78 #\c)
         (let ((empty0.22 empty)
               (ascii-char1.21 #\c)
               (vector2.20 (call make-vector 8))
               (empty3.19 empty))
           empty0.22)
         (if #t empty empty))
      (call
       L.fun/ascii-char9713.9
       (call L.fun/error9714.5 2 43 (void))
       (call L.fun/fixnum9715.6 (void) 135 229)
       (call L.fun/boolean9716.8 (error 123) (void) (call make-vector 8)))
      (let ((fixnum0.26 69)
            (void1.25 (void))
            (boolean2.24 #t)
            (ascii-char3.23 #\c))
        #\c))))
(check-by-interp
 '(module
    (define L.fun/vector9745.4 (lambda () (call make-vector 8)))
    (define L.fun/void9746.5 (lambda () (void)))
    (define L.fun/empty9747.6 (lambda () empty))
    (define L.fun/any9744.7 (lambda () 166))
    (let ((boolean0.4 (call pair? (call L.fun/any9744.7)))
          (vector1.3 (call L.fun/vector9745.4))
          (void2.2 (call L.fun/void9746.5))
          (empty3.1 (call L.fun/empty9747.6)))
      vector1.3)))
(check-by-interp
 '(module
    (define L.fun/empty9750.4 (lambda () empty))
    (define L.fun/error9751.5 (lambda () (error 123)))
    (define L.fun/vector9752.6 (lambda () (call make-vector 8)))
    (define L.fun/error9753.7 (lambda () (error 64)))
    (define L.fun/ascii-char9754.8 (lambda () #\c))
    (let ((empty0.4 (call L.fun/empty9750.4))
          (error1.3 (call L.fun/error9751.5))
          (vector2.2 (call L.fun/vector9752.6))
          (error3.1 (call L.fun/error9753.7)))
      (call L.fun/ascii-char9754.8))))
(check-by-interp
 '(module
    (if (call vector? (if #f (void) (call make-vector 8)))
      (let ((boolean0.4 #f) (empty1.3 empty) (boolean2.2 #t) (boolean3.1 #t))
        #\c)
      (let ((error0.8 (error 79))
            (empty1.7 empty)
            (ascii-char2.6 #\c)
            (ascii-char3.5 #\c))
        ascii-char2.6))))
(check-by-interp
 '(module
    (define L.fun/ascii-char9904.4 (lambda () #\c))
    (define L.fun/void9902.5 (lambda () (void)))
    (define L.fun/ascii-char9903.6 (lambda () #\c))
    (let ((void0.4 (call L.fun/void9902.5))
          (ascii-char1.3 (call L.fun/ascii-char9903.6))
          (fixnum2.2 (call - (call * 63 199) (call * 69 165)))
          (ascii-char3.1 (call L.fun/ascii-char9904.4)))
      void0.4)))
(check-by-interp
 '(module
    (define L.fun/void10674.4 (lambda () (void)))
    (define L.fun/error10675.5 (lambda () (error 251)))
    (define L.fun/void10672.6 (lambda () (void)))
    (define L.fun/empty10673.7 (lambda () empty))
    (let ((fixnum0.5
           (call
            -
            (call + (call + 139 195) (call - 113 88))
            (call - (call + 27 93) (call - 229 244))))
          (void1.4 (call L.fun/void10672.6))
          (empty2.3 (call L.fun/empty10673.7))
          (void3.2 (call L.fun/void10674.4))
          (fixnum4.1
           (call
            -
            (call - (call * 95 128) (call + 168 20))
            (call - (call * 142 81) (call * 92 28)))))
      (call L.fun/error10675.5))))
(check-by-interp
 '(module
    (define L.fun/any10855.4 (lambda () #\c))
    (define L.fun/ascii-char10854.5 (lambda () #\c))
    (define L.fun/empty10856.6 (lambda () empty))
    (define L.fun/void10857.7 (lambda () (void)))
    (let ((ascii-char0.5 (call L.fun/ascii-char10854.5))
          (boolean1.4 (call ascii-char? (call L.fun/any10855.4)))
          (empty2.3 (call L.fun/empty10856.6))
          (fixnum3.2
           (call
            +
            (call - (call + 169 98) (call - 1 224))
            (call + (call - 14 124) (call + 138 6))))
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
    (define L.fun/vector12711.4 (lambda () (call make-vector 8)))
    (define L.fun/empty12712.5 (lambda () empty))
    (define L.fun/vector12714.6 (lambda () (call make-vector 8)))
    (define L.fun/void12713.7 (lambda () (void)))
    (let ((vector0.5 (call L.fun/vector12711.4))
          (empty1.4 (call L.fun/empty12712.5))
          (void2.3 (call L.fun/void12713.7))
          (fixnum3.2
           (call
            -
            (call * (call * 170 154) (call - 13 71))
            (call - (call * 140 70) (call * 81 61))))
          (vector4.1 (call L.fun/vector12714.6)))
      vector0.5)))
(check-by-interp
 '(module
    (define L.fun/vector13203.4 (lambda () (call make-vector 8)))
    (define L.fun/error13204.5 (lambda () (error 157)))
    (define L.fun/ascii-char13205.6 (lambda () #\c))
    (let ((vector0.5 (call L.fun/vector13203.4))
          (error1.4 (call L.fun/error13204.5))
          (fixnum2.3
           (call
            +
            (call - (call - 80 223) (call - 58 99))
            (call + (call + 195 218) (call + 11 57))))
          (fixnum3.2
           (call
            *
            (call + (call * 62 220) (call - 250 199))
            (call * (call + 29 207) (call + 47 127))))
          (ascii-char4.1 (call L.fun/ascii-char13205.6)))
      vector0.5)))
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
    (define L.fun/void13657.4 (lambda () (void)))
    (define L.fun/error13660.5 (lambda () (error 21)))
    (define L.fun/ascii-char13659.6 (lambda () #\c))
    (define L.fun/vector13658.7 (lambda () (call make-vector 8)))
    (let ((fixnum0.5
           (call
            +
            (call * (call * 202 235) (call + 148 119))
            (call + (call * 149 216) (call * 253 177))))
          (fixnum1.4
           (call
            *
            (call - (call + 1 58) (call * 68 174))
            (call * (call - 208 139) (call * 101 233))))
          (void2.3 (call L.fun/void13657.4))
          (vector3.2 (call L.fun/vector13658.7))
          (ascii-char4.1 (call L.fun/ascii-char13659.6)))
      (call L.fun/error13660.5))))
(check-by-interp
 '(module
    (define L.fun/vector13886.4 (lambda () (call make-vector 8)))
    (define L.fun/vector13888.5 (lambda () (call make-vector 8)))
    (define L.fun/error13885.6 (lambda () (error 205)))
    (define L.fun/void13887.7 (lambda () (void)))
    (define L.fun/ascii-char13889.8 (lambda () #\c))
    (let ((error0.5 (call L.fun/error13885.6))
          (vector1.4 (call L.fun/vector13886.4))
          (void2.3 (call L.fun/void13887.7))
          (vector3.2 (call L.fun/vector13888.5))
          (ascii-char4.1 (call L.fun/ascii-char13889.8)))
      vector3.2)))
(check-by-interp
 '(module
    (define L.fun/void14228.4 (lambda () (void)))
    (define L.fun/empty14229.5 (lambda () empty))
    (define L.fun/ascii-char14227.6 (lambda () #\c))
    (let ((fixnum0.5
           (call
            +
            (call + (call * 189 166) (call * 136 137))
            (call * (call - 191 104) (call * 24 218))))
          (ascii-char1.4 (call L.fun/ascii-char14227.6))
          (fixnum2.3
           (call
            *
            (call - (call + 110 180) (call - 79 40))
            (call - (call - 211 45) (call + 225 244))))
          (void3.2 (call L.fun/void14228.4))
          (empty4.1 (call L.fun/empty14229.5)))
      empty4.1)))
(check-by-interp
 '(module
    (define L.fun/ascii-char14455.4 (lambda () #\c))
    (define L.fun/error14458.5 (lambda () (error 229)))
    (define L.fun/vector14457.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char14456.7 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char14455.4))
          (fixnum1.4
           (call
            +
            (call - (call * 238 14) (call - 59 220))
            (call - (call + 138 8) (call * 78 39))))
          (ascii-char2.3 (call L.fun/ascii-char14456.7))
          (vector3.2 (call L.fun/vector14457.6))
          (error4.1 (call L.fun/error14458.5)))
      error4.1)))
(check-by-interp
 '(module
    (define L.fun/void14544.4 (lambda () (void)))
    (define L.fun/empty14543.5 (lambda () empty))
    (define L.fun/ascii-char14546.6 (lambda () #\c))
    (define L.fun/error14545.7 (lambda () (error 0)))
    (define L.fun/error14542.8 (lambda () (error 150)))
    (let ((error0.5 (call L.fun/error14542.8))
          (empty1.4 (call L.fun/empty14543.5))
          (fixnum2.3
           (call
            -
            (call * (call * 156 36) (call * 107 69))
            (call + (call * 103 132) (call + 76 215))))
          (void3.2 (call L.fun/void14544.4))
          (error4.1 (call L.fun/error14545.7)))
      (call L.fun/ascii-char14546.6))))
(check-by-interp
 '(module
    (define L.fun/error14839.4 (lambda () (error 109)))
    (define L.fun/empty14843.5 (lambda () empty))
    (define L.fun/void14842.6 (lambda () (void)))
    (define L.fun/ascii-char14840.7 (lambda () #\c))
    (define L.fun/vector14841.8 (lambda () (call make-vector 8)))
    (let ((error0.5 (call L.fun/error14839.4))
          (ascii-char1.4 (call L.fun/ascii-char14840.7))
          (vector2.3 (call L.fun/vector14841.8))
          (void3.2 (call L.fun/void14842.6))
          (empty4.1 (call L.fun/empty14843.5)))
      void3.2)))
(check-by-interp
 '(module
    (define L.fun/void14856.4 (lambda () (void)))
    (define L.fun/ascii-char14858.5 (lambda () #\c))
    (define L.fun/void14860.6 (lambda () (void)))
    (define L.fun/vector14857.7 (lambda () (call make-vector 8)))
    (define L.fun/void14859.8 (lambda () (void)))
    (let ((void0.5 (call L.fun/void14856.4))
          (vector1.4 (call L.fun/vector14857.7))
          (ascii-char2.3 (call L.fun/ascii-char14858.5))
          (void3.2 (call L.fun/void14859.8))
          (void4.1 (call L.fun/void14860.6)))
      ascii-char2.3)))
(check-by-interp
 '(module
    (define L.fun/vector15071.4 (lambda () (call make-vector 8)))
    (define L.fun/error15068.5 (lambda () (error 99)))
    (define L.fun/empty15070.6 (lambda () empty))
    (define L.fun/empty15069.7 (lambda () empty))
    (let ((error0.5 (call L.fun/error15068.5))
          (empty1.4 (call L.fun/empty15069.7))
          (empty2.3 (call L.fun/empty15070.6))
          (vector3.2 (call L.fun/vector15071.4))
          (fixnum4.1
           (call
            -
            (call + (call - 14 174) (call - 1 238))
            (call * (call - 185 184) (call * 19 199)))))
      vector3.2)))
(check-by-interp
 '(module
    (define L.fun/empty15112.4 (lambda () empty))
    (define L.fun/error15114.5 (lambda () (error 44)))
    (define L.fun/empty15111.6 (lambda () empty))
    (define L.fun/ascii-char15115.7 (lambda () #\c))
    (define L.fun/void15113.8 (lambda () (void)))
    (let ((fixnum0.5
           (call
            *
            (call - (call * 163 174) (call * 225 46))
            (call - (call * 209 243) (call - 148 233))))
          (empty1.4 (call L.fun/empty15111.6))
          (empty2.3 (call L.fun/empty15112.4))
          (void3.2 (call L.fun/void15113.8))
          (error4.1 (call L.fun/error15114.5)))
      (call L.fun/ascii-char15115.7))))
(check-by-interp
 '(module
    (define L.fun/vector15538.4 (lambda () (call make-vector 8)))
    (define L.fun/error15539.5 (lambda () (error 103)))
    (define L.fun/empty15540.6 (lambda () empty))
    (define L.fun/error15541.7 (lambda () (error 133)))
    (define L.fun/ascii-char15542.8 (lambda () #\c))
    (define L.fun/empty15537.9 (lambda () empty))
    (let ((empty0.5 (call L.fun/empty15537.9))
          (vector1.4 (call L.fun/vector15538.4))
          (error2.3 (call L.fun/error15539.5))
          (empty3.2 (call L.fun/empty15540.6))
          (error4.1 (call L.fun/error15541.7)))
      (call L.fun/ascii-char15542.8))))
(check-by-interp
 '(module
    (define L.fun/empty16025.4 (lambda () empty))
    (define L.fun/ascii-char16027.5 (lambda () #\c))
    (define L.fun/any16026.6 (lambda () (void)))
    (let ((empty0.5 (call L.fun/empty16025.4))
          (fixnum1.4
           (call
            -
            (call - (call * 7 28) (call + 42 48))
            (call * (call - 242 84) (call - 137 220))))
          (fixnum2.3
           (call
            *
            (call * (call * 7 176) (call * 1 66))
            (call * (call + 59 47) (call - 125 82))))
          (fixnum3.2
           (call
            +
            (call * (call * 133 58) (call * 136 188))
            (call * (call + 166 131) (call * 229 70))))
          (boolean4.1 (call fixnum? (call L.fun/any16026.6))))
      (call L.fun/ascii-char16027.5))))
(check-by-interp
 '(module
    (define L.fun/vector16217.4 (lambda () (call make-vector 8)))
    (define L.fun/error16218.5 (lambda () (error 168)))
    (define L.fun/empty16220.6 (lambda () empty))
    (define L.fun/ascii-char16216.7 (lambda () #\c))
    (define L.fun/empty16219.8 (lambda () empty))
    (let ((ascii-char0.5 (call L.fun/ascii-char16216.7))
          (vector1.4 (call L.fun/vector16217.4))
          (error2.3 (call L.fun/error16218.5))
          (empty3.2 (call L.fun/empty16219.8))
          (empty4.1 (call L.fun/empty16220.6)))
      (call
       +
       (call * (call + 178 137) (call + 83 73))
       (call + (call * 214 174) (call + 28 196))))))
(check-by-interp
 '(module
    (define L.fun/error17051.4 (lambda () (error 145)))
    (define L.fun/error17048.5 (lambda () (error 110)))
    (define L.fun/void17050.6 (lambda () (void)))
    (define L.fun/vector17049.7 (lambda () (call make-vector 8)))
    (let ((fixnum0.5
           (call
            +
            (call + (call * 155 25) (call * 116 45))
            (call - (call * 231 87) (call - 62 219))))
          (error1.4 (call L.fun/error17048.5))
          (vector2.3 (call L.fun/vector17049.7))
          (void3.2 (call L.fun/void17050.6))
          (error4.1 (call L.fun/error17051.4)))
      error1.4)))
(check-by-interp
 '(module
    (define L.fun/error17146.4 (lambda () (error 64)))
    (define L.fun/void17144.5 (lambda () (void)))
    (define L.fun/ascii-char17142.6 (lambda () #\c))
    (define L.fun/any17145.7 (lambda () (call make-vector 8)))
    (define L.fun/empty17143.8 (lambda () empty))
    (let ((ascii-char0.5 (call L.fun/ascii-char17142.6))
          (empty1.4 (call L.fun/empty17143.8))
          (void2.3 (call L.fun/void17144.5))
          (boolean3.2 (call pair? (call L.fun/any17145.7)))
          (error4.1 (call L.fun/error17146.4)))
      (call
       +
       (call + (call * 243 44) (call - 12 9))
       (call * (call - 143 63) (call - 63 206))))))
(check-by-interp
 '(module
    (define L.fun/any17224.4 (lambda () (error 63)))
    (define L.fun/ascii-char17222.5 (lambda () #\c))
    (define L.fun/error17225.6 (lambda () (error 105)))
    (define L.fun/vector17223.7 (lambda () (call make-vector 8)))
    (define L.fun/any17221.8 (lambda () #\c))
    (let ((boolean0.5 (call ascii-char? (call L.fun/any17221.8)))
          (ascii-char1.4 (call L.fun/ascii-char17222.5))
          (vector2.3 (call L.fun/vector17223.7))
          (boolean3.2 (call error? (call L.fun/any17224.4)))
          (error4.1 (call L.fun/error17225.6)))
      vector2.3)))
(check-by-interp
 '(module
    (define L.fun/any18171.4 (lambda () (void)))
    (define L.fun/vector18170.5 (lambda () (call make-vector 8)))
    (define L.fun/vector18172.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char18169.7 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char18169.7))
          (vector1.4 (call L.fun/vector18170.5))
          (fixnum2.3
           (call
            +
            (call * (call * 79 254) (call - 42 87))
            (call * (call + 17 207) (call * 98 250))))
          (boolean3.2 (call vector? (call L.fun/any18171.4)))
          (vector4.1 (call L.fun/vector18172.6)))
      vector4.1)))
(check-by-interp
 '(module
    (define L.fun/error18672.4 (lambda () (error 201)))
    (define L.fun/vector18674.5 (lambda () (call make-vector 8)))
    (define L.fun/void18673.6 (lambda () (void)))
    (let ((error0.5 (call L.fun/error18672.4))
          (fixnum1.4
           (call
            +
            (call + (call + 83 253) (call - 52 64))
            (call + (call * 208 185) (call + 254 229))))
          (fixnum2.3
           (call
            -
            (call * (call * 142 225) (call - 102 137))
            (call - (call * 70 133) (call + 76 53))))
          (void3.2 (call L.fun/void18673.6))
          (vector4.1 (call L.fun/vector18674.5)))
      (call - fixnum1.4 (call + fixnum1.4 (call + 149 211))))))
(check-by-interp
 '(module
    (define L.fun/any18778.4 (lambda () (void)))
    (define L.fun/vector18775.5 (lambda () (call make-vector 8)))
    (define L.fun/vector18777.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char18779.7 (lambda () #\c))
    (define L.fun/vector18774.8 (lambda () (call make-vector 8)))
    (define L.fun/void18776.9 (lambda () (void)))
    (let ((vector0.5 (call L.fun/vector18774.8))
          (vector1.4 (call L.fun/vector18775.5))
          (void2.3 (call L.fun/void18776.9))
          (vector3.2 (call L.fun/vector18777.6))
          (boolean4.1 (call error? (call L.fun/any18778.4))))
      (call L.fun/ascii-char18779.7))))
(check-by-interp
 '(module
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
       -
       (call - (call - 219 20) (call + 57 154))
       (call * (call - 99 179) (call - 231 194))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char19452.4 (lambda () #\c))
    (define L.fun/vector19455.5 (lambda () (call make-vector 8)))
    (define L.fun/empty19454.6 (lambda () empty))
    (define L.fun/empty19453.7 (lambda () empty))
    (let ((ascii-char0.5 (call L.fun/ascii-char19452.4))
          (empty1.4 (call L.fun/empty19453.7))
          (empty2.3 (call L.fun/empty19454.6))
          (vector3.2 (call L.fun/vector19455.5))
          (fixnum4.1
           (call
            -
            (call - (call + 29 157) (call * 160 191))
            (call - (call * 70 178) (call + 176 131)))))
      vector3.2)))
(check-by-interp
 '(module
    (define L.fun/error19687.4 (lambda () (error 80)))
    (define L.fun/empty19688.5 (lambda () empty))
    (define L.fun/vector19689.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char19684.7 (lambda () #\c))
    (define L.fun/ascii-char19685.8 (lambda () #\c))
    (define L.fun/ascii-char19686.9 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char19684.7))
          (ascii-char1.4 (call L.fun/ascii-char19685.8))
          (ascii-char2.3 (call L.fun/ascii-char19686.9))
          (error3.2 (call L.fun/error19687.4))
          (empty4.1 (call L.fun/empty19688.5)))
      (call L.fun/vector19689.6))))
(check-by-interp
 '(module
    (define L.fun/error19710.4 (lambda () (error 181)))
    (define L.fun/vector19707.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char19709.6 (lambda () #\c))
    (define L.fun/error19711.7 (lambda () (error 151)))
    (define L.fun/error19708.8 (lambda () (error 188)))
    (let ((vector0.5 (call L.fun/vector19707.5))
          (error1.4 (call L.fun/error19708.8))
          (ascii-char2.3 (call L.fun/ascii-char19709.6))
          (error3.2 (call L.fun/error19710.4))
          (error4.1 (call L.fun/error19711.7)))
      error3.2)))
(check-by-interp
 '(module
    (define L.fun/vector20535.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char20536.5 (lambda () #\c))
    (define L.fun/void20534.6 (lambda () (void)))
    (define L.fun/void20537.7 (lambda () (void)))
    (let ((void0.5 (call L.fun/void20534.6))
          (fixnum1.4
           (call
            +
            (call + (call - 56 162) (call + 237 2))
            (call - (call * 116 82) (call - 219 253))))
          (vector2.3 (call L.fun/vector20535.4))
          (ascii-char3.2 (call L.fun/ascii-char20536.5))
          (void4.1 (call L.fun/void20537.7)))
      (call * fixnum1.4 fixnum1.4))))
(check-by-interp
 '(module
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
       *
       (call - (call - 188 148) (call + 202 162))
       (call * (call - 1 159) (call * 111 66))))))
(check-by-interp
 '(module
    (define L.fun/any21000.4 (lambda () #\c))
    (define L.fun/vector21002.5 (lambda () (call make-vector 8)))
    (define L.fun/vector21001.6 (lambda () (call make-vector 8)))
    (define L.fun/void21003.7 (lambda () (void)))
    (define L.fun/error21004.8 (lambda () (error 241)))
    (let ((boolean0.5 (call error? (call L.fun/any21000.4)))
          (vector1.4 (call L.fun/vector21001.6))
          (vector2.3 (call L.fun/vector21002.5))
          (fixnum3.2
           (call
            +
            (call + (call + 90 120) (call - 205 70))
            (call * (call - 249 161) (call + 81 202))))
          (void4.1 (call L.fun/void21003.7)))
      (call L.fun/error21004.8))))
(check-by-interp
 '(module
    (define L.fun/ascii-char21096.4 (lambda () #\c))
    (define L.fun/ascii-char21098.5 (lambda () #\c))
    (define L.fun/error21099.6 (lambda () (error 129)))
    (define L.fun/ascii-char21097.7 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char21096.4))
          (fixnum1.4
           (call
            +
            (call + (call + 151 247) (call * 179 4))
            (call + (call * 175 57) (call - 111 209))))
          (ascii-char2.3 (call L.fun/ascii-char21097.7))
          (ascii-char3.2 (call L.fun/ascii-char21098.5))
          (fixnum4.1
           (call
            -
            (call - (call * 129 225) (call + 69 70))
            (call - (call - 178 46) (call - 108 37)))))
      (call L.fun/error21099.6))))
(check-by-interp
 '(module
    (define L.fun/void21257.4 (lambda () (void)))
    (define L.fun/void21255.5 (lambda () (void)))
    (define L.fun/void21256.6 (lambda () (void)))
    (define L.fun/ascii-char21254.7 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char21254.7))
          (void1.4 (call L.fun/void21255.5))
          (fixnum2.3
           (call
            -
            (call - (call + 216 92) (call - 203 24))
            (call + (call - 20 111) (call - 246 240))))
          (void3.2 (call L.fun/void21256.6))
          (void4.1 (call L.fun/void21257.4)))
      void1.4)))
(check-by-interp
 '(module
    (define L.fun/ascii-char21338.4 (lambda () #\c))
    (define L.fun/error21339.5 (lambda () (error 149)))
    (define L.fun/any21340.6 (lambda () (void)))
    (define L.fun/vector21341.7 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char21337.8 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char21337.8))
          (ascii-char1.4 (call L.fun/ascii-char21338.4))
          (error2.3 (call L.fun/error21339.5))
          (fixnum3.2
           (call
            -
            (call + (call + 123 146) (call + 239 49))
            (call + (call + 235 58) (call + 105 238))))
          (boolean4.1 (call boolean? (call L.fun/any21340.6))))
      (call L.fun/vector21341.7))))
(check-by-interp
 '(module
    (define L.fun/ascii-char21457.4 (lambda () #\c))
    (define L.fun/any21458.5 (lambda () #f))
    (define L.fun/ascii-char21459.6 (lambda () #\c))
    (define L.fun/vector21460.7 (lambda () (call make-vector 8)))
    (let ((ascii-char0.5 (call L.fun/ascii-char21457.4))
          (boolean1.4 (call ascii-char? (call L.fun/any21458.5)))
          (ascii-char2.3 (call L.fun/ascii-char21459.6))
          (vector3.2 (call L.fun/vector21460.7))
          (fixnum4.1
           (call
            -
            (call - (call + 29 75) (call + 131 225))
            (call - (call - 49 113) (call + 238 111)))))
      ascii-char0.5)))
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
       +
       (call - (call * 134 181) (call - 62 177))
       (call + (call - 10 151) (call - 111 129))))))
(check-by-interp
 '(module
    (define L.fun/vector21647.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char21651.5 (lambda () #\c))
    (define L.fun/empty21650.6 (lambda () empty))
    (define L.fun/any21649.7 (lambda () (error 62)))
    (define L.fun/empty21648.8 (lambda () empty))
    (let ((vector0.5 (call L.fun/vector21647.4))
          (empty1.4 (call L.fun/empty21648.8))
          (boolean2.3 (call pair? (call L.fun/any21649.7)))
          (empty3.2 (call L.fun/empty21650.6))
          (fixnum4.1
           (call
            *
            (call * (call * 46 57) (call - 44 102))
            (call - (call - 230 56) (call * 38 159)))))
      (call L.fun/ascii-char21651.5))))
(check-by-interp
 '(module
    (define L.fun/void21925.4 (lambda () (void)))
    (define L.fun/error21927.5 (lambda () (error 161)))
    (define L.fun/vector21928.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char21924.7 (lambda () #\c))
    (define L.fun/void21926.8 (lambda () (void)))
    (let ((ascii-char0.5 (call L.fun/ascii-char21924.7))
          (fixnum1.4
           (call
            +
            (call - (call + 33 207) (call * 159 69))
            (call - (call * 40 161) (call + 188 232))))
          (void2.3 (call L.fun/void21925.4))
          (void3.2 (call L.fun/void21926.8))
          (error4.1 (call L.fun/error21927.5)))
      (call L.fun/vector21928.6))))
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
    (define L.fun/vector22195.4 (lambda () (call make-vector 8)))
    (define L.fun/void22199.5 (lambda () (void)))
    (define L.fun/empty22200.6 (lambda () empty))
    (define L.fun/error22196.7 (lambda () (error 86)))
    (define L.fun/ascii-char22198.8 (lambda () #\c))
    (define L.fun/ascii-char22197.9 (lambda () #\c))
    (let ((vector0.5 (call L.fun/vector22195.4))
          (error1.4 (call L.fun/error22196.7))
          (ascii-char2.3 (call L.fun/ascii-char22197.9))
          (ascii-char3.2 (call L.fun/ascii-char22198.8))
          (void4.1 (call L.fun/void22199.5)))
      (call L.fun/empty22200.6))))
(check-by-interp
 '(module
    (define L.fun/empty22498.4 (lambda () empty))
    (define L.fun/void22500.5 (lambda () (void)))
    (define L.fun/vector22501.6 (lambda () (call make-vector 8)))
    (define L.fun/error22499.7 (lambda () (error 208)))
    (let ((fixnum0.5
           (call
            -
            (call + (call - 125 166) (call + 27 37))
            (call * (call * 37 39) (call - 253 23))))
          (empty1.4 (call L.fun/empty22498.4))
          (error2.3 (call L.fun/error22499.7))
          (void3.2 (call L.fun/void22500.5))
          (vector4.1 (call L.fun/vector22501.6)))
      void3.2)))
(check-by-interp
 '(module
    (define L.fun/vector22639.4 (lambda () (call make-vector 8)))
    (define L.fun/boolean22642.5
      (lambda (oprand0.4 oprand1.3 oprand2.2 oprand3.1) #t))
    (define L.fun/vector22640.6 (lambda () (call make-vector 8)))
    (define L.fun/empty22641.7 (lambda () empty))
    (if (call
         error?
         (let ((error0.9 (error 146))
               (ascii-char1.8 #\c)
               (ascii-char2.7 #\c)
               (boolean3.6 #t)
               (empty4.5 empty))
           #t))
      (let ((boolean0.14 (call vector? (call make-vector 8)))
            (fixnum1.13 (call + 223 230))
            (vector2.12 (call L.fun/vector22639.4))
            (fixnum3.11 (call + 50 33))
            (vector4.10 (call L.fun/vector22640.6)))
        (call L.fun/empty22641.7))
      (if (call L.fun/boolean22642.5 #f (error 63) (void) (error 117))
        (if #t empty empty)
        (if #f empty empty)))))
(check-by-interp
 '(module
    (define L.fun/void22688.4 (lambda () (call L.fun/void22689.12)))
    (define L.fun/empty22681.5 (lambda () empty))
    (define L.fun/ascii-char22683.6 (lambda () #\c))
    (define L.fun/ascii-char22682.7 (lambda () (call L.fun/ascii-char22683.6)))
    (define L.fun/empty22687.8 (lambda () empty))
    (define L.fun/vector22685.9 (lambda () (call make-vector 8)))
    (define L.fun/vector22678.10 (lambda () (call L.fun/vector22679.13)))
    (define L.fun/empty22680.11 (lambda () (call L.fun/empty22681.5)))
    (define L.fun/void22689.12 (lambda () (void)))
    (define L.fun/vector22679.13 (lambda () (call make-vector 8)))
    (define L.fun/empty22686.14 (lambda () (call L.fun/empty22687.8)))
    (define L.fun/vector22684.15 (lambda () (call L.fun/vector22685.9)))
    (let ((vector0.6 (call L.fun/vector22678.10))
          (empty1.5 (call L.fun/empty22680.11))
          (ascii-char2.4 (call L.fun/ascii-char22682.7))
          (vector3.3 (call L.fun/vector22684.15))
          (empty4.2 (call L.fun/empty22686.14))
          (void5.1 (call L.fun/void22688.4)))
      void5.1)))
(check-by-interp
 '(module
    (define L.fun/vector23398.4 (lambda () (call L.fun/vector23399.10)))
    (define L.fun/error23400.5 (lambda () (call L.fun/error23401.11)))
    (define L.fun/error23396.6 (lambda () (call L.fun/error23397.8)))
    (define L.fun/ascii-char23402.7 (lambda () (call L.fun/ascii-char23403.9)))
    (define L.fun/error23397.8 (lambda () (error 29)))
    (define L.fun/ascii-char23403.9 (lambda () #\c))
    (define L.fun/vector23399.10 (lambda () (call make-vector 8)))
    (define L.fun/error23401.11 (lambda () (error 159)))
    (let ((error0.6 (call L.fun/error23396.6))
          (fixnum1.5
           (call
            -
            (call
             -
             (call - (call + 100 84) (call + 128 24))
             (call * (call - 246 117) (call - 121 245)))
            (call
             -
             (call - (call - 45 241) (call + 138 20))
             (call + (call + 174 55) (call - 40 129)))))
          (vector2.4 (call L.fun/vector23398.4))
          (error3.3 (call L.fun/error23400.5))
          (fixnum4.2
           (call
            *
            (call
             *
             (call + (call + 105 80) (call * 166 149))
             (call + (call * 237 166) (call * 58 166)))
            (call
             *
             (call * (call - 7 102) (call * 183 238))
             (call + (call - 210 61) (call * 179 55)))))
          (ascii-char5.1 (call L.fun/ascii-char23402.7)))
      vector2.4)))
(check-by-interp
 '(module
    (define L.fun/empty23859.4 (lambda () (call L.fun/empty23860.8)))
    (define L.fun/empty23858.5 (lambda () empty))
    (define L.fun/void23863.6 (lambda () (void)))
    (define L.fun/void23862.7 (lambda () (call L.fun/void23863.6)))
    (define L.fun/empty23860.8 (lambda () empty))
    (define L.fun/empty23857.9 (lambda () (call L.fun/empty23858.5)))
    (define L.fun/any23861.10 (lambda () (call make-vector 8)))
    (let ((empty0.6 (call L.fun/empty23857.9))
          (fixnum1.5
           (call
            *
            (call
             -
             (call - (call * 208 174) (call - 95 183))
             (call * (call + 132 104) (call + 34 149)))
            (call
             -
             (call * (call * 55 252) (call + 171 248))
             (call - (call * 104 34) (call + 95 182)))))
          (fixnum2.4
           (call
            *
            (call
             +
             (call * (call * 79 35) (call + 224 172))
             (call * (call + 44 69) (call - 222 171)))
            (call
             -
             (call * (call - 12 247) (call - 42 133))
             (call - (call - 91 41) (call * 22 119)))))
          (empty3.3 (call L.fun/empty23859.4))
          (boolean4.2 (call vector? (call L.fun/any23861.10)))
          (void5.1 (call L.fun/void23862.7)))
      (call + fixnum2.4 fixnum2.4))))
(check-by-interp
 '(module
    (define L.fun/void30044.4 (lambda () (void)))
    (define L.fun/empty30040.5 (lambda () (call L.fun/empty30041.10)))
    (define L.fun/void30049.6 (lambda () (call L.fun/void30050.12)))
    (define L.fun/empty30047.7 (lambda () (call L.fun/empty30048.16)))
    (define L.fun/error30045.8 (lambda () (call L.fun/error30046.15)))
    (define L.fun/vector30052.9 (lambda () (call make-vector 8)))
    (define L.fun/empty30041.10 (lambda () empty))
    (define L.fun/void30043.11 (lambda () (call L.fun/void30044.4)))
    (define L.fun/void30050.12 (lambda () (void)))
    (define L.fun/vector30051.13 (lambda () (call L.fun/vector30052.9)))
    (define L.fun/any30042.14 (lambda () (call make-vector 8)))
    (define L.fun/error30046.15 (lambda () (error 214)))
    (define L.fun/empty30048.16 (lambda () empty))
    (let ((empty0.6 (call L.fun/empty30040.5))
          (boolean1.5 (call empty? (call L.fun/any30042.14)))
          (void2.4 (call L.fun/void30043.11))
          (error3.3 (call L.fun/error30045.8))
          (empty4.2 (call L.fun/empty30047.7))
          (void5.1 (call L.fun/void30049.6)))
      (call L.fun/vector30051.13))))
(check-by-interp
 '(module
    (define L.fun/vector31209.4 (lambda () (call make-vector 8)))
    (define L.fun/void31211.5 (lambda () (void)))
    (define L.fun/vector31202.6 (lambda () (call L.fun/vector31203.10)))
    (define L.fun/error31206.7 (lambda () (call L.fun/error31207.9)))
    (define L.fun/error31205.8 (lambda () (error 219)))
    (define L.fun/error31207.9 (lambda () (error 229)))
    (define L.fun/vector31203.10 (lambda () (call make-vector 8)))
    (define L.fun/void31210.11 (lambda () (call L.fun/void31211.5)))
    (define L.fun/error31204.12 (lambda () (call L.fun/error31205.8)))
    (define L.fun/vector31208.13 (lambda () (call L.fun/vector31209.4)))
    (let ((vector0.6 (call L.fun/vector31202.6))
          (error1.5 (call L.fun/error31204.12))
          (error2.4 (call L.fun/error31206.7))
          (vector3.3 (call L.fun/vector31208.13))
          (fixnum4.2
           (call
            +
            (call
             -
             (call * (call + 39 31) (call * 204 200))
             (call - (call - 67 43) (call * 88 81)))
            (call
             -
             (call - (call + 157 53) (call + 209 206))
             (call * (call + 49 46) (call - 43 159)))))
          (void5.1 (call L.fun/void31210.11)))
      void5.1)))
(check-by-interp
 '(module
    (define L.fun/ascii-char33057.4 (lambda () (call L.fun/ascii-char33058.7)))
    (define L.fun/error33066.5 (lambda () (error 235)))
    (define L.fun/empty33064.6 (lambda () empty))
    (define L.fun/ascii-char33058.7 (lambda () #\c))
    (define L.fun/empty33063.8 (lambda () (call L.fun/empty33064.6)))
    (define L.fun/vector33062.9 (lambda () (call make-vector 8)))
    (define L.fun/vector33059.10 (lambda () (call L.fun/vector33060.12)))
    (define L.fun/vector33061.11 (lambda () (call L.fun/vector33062.9)))
    (define L.fun/vector33060.12 (lambda () (call make-vector 8)))
    (define L.fun/error33065.13 (lambda () (call L.fun/error33066.5)))
    (let ((ascii-char0.6 (call L.fun/ascii-char33057.4))
          (vector1.5 (call L.fun/vector33059.10))
          (vector2.4 (call L.fun/vector33061.11))
          (empty3.3 (call L.fun/empty33063.8))
          (error4.2 (call L.fun/error33065.13))
          (fixnum5.1
           (call
            *
            (call
             +
             (call * (call - 4 241) (call * 219 91))
             (call - (call * 148 159) (call * 208 228)))
            (call
             +
             (call * (call * 128 115) (call * 109 13))
             (call + (call + 220 146) (call * 183 193))))))
      empty3.3)))
(check-by-interp
 '(module
    (define L.fun/empty35185.4 (lambda () empty))
    (define L.fun/empty35187.5 (lambda () empty))
    (define L.fun/ascii-char35182.6
      (lambda () (call L.fun/ascii-char35183.11)))
    (define L.fun/empty35184.7 (lambda () (call L.fun/empty35185.4)))
    (define L.fun/vector35189.8 (lambda () (call make-vector 8)))
    (define L.fun/vector35188.9 (lambda () (call L.fun/vector35189.8)))
    (define L.fun/empty35186.10 (lambda () (call L.fun/empty35187.5)))
    (define L.fun/ascii-char35183.11 (lambda () #\c))
    (let ((ascii-char0.6 (call L.fun/ascii-char35182.6))
          (empty1.5 (call L.fun/empty35184.7))
          (empty2.4 (call L.fun/empty35186.10))
          (vector3.3 (call L.fun/vector35188.9))
          (fixnum4.2
           (call
            -
            (call
             +
             (call + (call - 104 166) (call + 216 100))
             (call - (call - 244 5) (call + 18 163)))
            (call
             *
             (call - (call - 36 143) (call + 90 214))
             (call + (call * 166 196) (call * 244 163)))))
          (fixnum5.1
           (call
            *
            (call
             *
             (call * (call + 66 176) (call + 48 71))
             (call * (call * 29 53) (call + 247 0)))
            (call
             -
             (call * (call + 103 33) (call * 4 144))
             (call * (call * 190 207) (call * 113 17))))))
      fixnum5.1)))
(check-by-interp
 '(module
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
            +
            (call
             -
             (call + (call * 3 14) (call + 147 101))
             (call + (call - 219 195) (call * 5 175)))
            (call
             -
             (call - (call - 85 142) (call - 127 130))
             (call + (call - 32 36) (call + 35 193)))))
          (void5.1 (call L.fun/void35214.8)))
      ascii-char1.5)))
(check-by-interp
 '(module
    (define L.fun/vector35811.4 (lambda () (call make-vector 8)))
    (define L.fun/void35805.5 (lambda () (void)))
    (define L.fun/vector35806.6 (lambda () (call L.fun/vector35807.10)))
    (define L.fun/error35808.7 (lambda () (call L.fun/error35809.11)))
    (define L.fun/vector35810.8 (lambda () (call L.fun/vector35811.4)))
    (define L.fun/void35804.9 (lambda () (call L.fun/void35805.5)))
    (define L.fun/vector35807.10 (lambda () (call make-vector 8)))
    (define L.fun/error35809.11 (lambda () (error 108)))
    (let ((void0.6 (call L.fun/void35804.9))
          (vector1.5 (call L.fun/vector35806.6))
          (error2.4 (call L.fun/error35808.7))
          (fixnum3.3
           (call
            *
            (call
             +
             (call * (call * 67 180) (call * 75 54))
             (call * (call * 105 171) (call * 163 130)))
            (call
             *
             (call - (call - 141 27) (call - 202 198))
             (call - (call - 81 112) (call * 53 83)))))
          (vector4.2 (call L.fun/vector35810.8))
          (fixnum5.1
           (call
            +
            (call
             *
             (call + (call - 44 31) (call * 3 150))
             (call * (call * 160 197) (call + 83 115)))
            (call
             *
             (call + (call * 206 229) (call + 193 56))
             (call - (call * 17 14) (call * 217 131))))))
      vector1.5)))
(check-by-interp
 '(module
    (define L.fun/ascii-char38887.4
      (lambda () (call L.fun/ascii-char38888.14)))
    (define L.fun/error38886.5 (lambda () (error 110)))
    (define L.fun/error38884.6 (lambda () (error 228)))
    (define L.fun/empty38889.7 (lambda () (call L.fun/empty38890.12)))
    (define L.fun/empty38882.8 (lambda () empty))
    (define L.fun/empty38881.9 (lambda () (call L.fun/empty38882.8)))
    (define L.fun/error38883.10 (lambda () (call L.fun/error38884.6)))
    (define L.fun/error38885.11 (lambda () (call L.fun/error38886.5)))
    (define L.fun/empty38890.12 (lambda () empty))
    (define L.fun/vector38892.13 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char38888.14 (lambda () #\c))
    (define L.fun/vector38891.15 (lambda () (call L.fun/vector38892.13)))
    (let ((empty0.6 (call L.fun/empty38881.9))
          (error1.5 (call L.fun/error38883.10))
          (error2.4 (call L.fun/error38885.11))
          (ascii-char3.3 (call L.fun/ascii-char38887.4))
          (empty4.2 (call L.fun/empty38889.7))
          (vector5.1 (call L.fun/vector38891.15)))
      ascii-char3.3)))
(check-by-interp
 '(module
    (define L.fun/empty42202.4 (lambda () (call L.fun/empty42203.13)))
    (define L.fun/ascii-char42195.5 (lambda () #\c))
    (define L.fun/ascii-char42193.6 (lambda () #\c))
    (define L.fun/ascii-char42200.7
      (lambda () (call L.fun/ascii-char42201.14)))
    (define L.fun/vector42197.8 (lambda () (call make-vector 8)))
    (define L.fun/error42199.9 (lambda () (error 121)))
    (define L.fun/ascii-char42194.10
      (lambda () (call L.fun/ascii-char42195.5)))
    (define L.fun/ascii-char42192.11
      (lambda () (call L.fun/ascii-char42193.6)))
    (define L.fun/vector42196.12 (lambda () (call L.fun/vector42197.8)))
    (define L.fun/empty42203.13 (lambda () empty))
    (define L.fun/ascii-char42201.14 (lambda () #\c))
    (define L.fun/error42198.15 (lambda () (call L.fun/error42199.9)))
    (let ((ascii-char0.6 (call L.fun/ascii-char42192.11))
          (ascii-char1.5 (call L.fun/ascii-char42194.10))
          (vector2.4 (call L.fun/vector42196.12))
          (error3.3 (call L.fun/error42198.15))
          (ascii-char4.2 (call L.fun/ascii-char42200.7))
          (fixnum5.1
           (call
            -
            (call
             *
             (call + (call - 244 113) (call - 242 178))
             (call + (call * 117 87) (call + 73 142)))
            (call
             *
             (call + (call - 31 67) (call * 11 121))
             (call + (call * 112 179) (call - 232 107))))))
      (call L.fun/empty42202.4))))
(check-by-interp
 '(module
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
          (boolean2.4 (call void? (call L.fun/any43337.6)))
          (fixnum3.3
           (call
            +
            (call
             +
             (call * (call * 104 88) (call - 130 229))
             (call + (call - 119 71) (call + 174 235)))
            (call
             *
             (call + (call * 77 57) (call - 241 54))
             (call * (call + 50 172) (call * 72 240)))))
          (empty4.2 (call L.fun/empty43338.10))
          (boolean5.1 (call error? (call L.fun/any43340.7))))
      (call L.fun/void43341.4))))
(check-by-interp
 '(module
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
            +
            (call
             +
             (call + (call * 61 221) (call * 124 246))
             (call + (call * 163 15) (call * 37 42)))
            (call
             -
             (call * (call * 25 17) (call * 68 127))
             (call - (call * 180 89) (call - 248 176)))))
          (ascii-char5.1 (call L.fun/ascii-char44119.5)))
      (call
       -
       (call
        +
        (call - (call + 52 92) (call - fixnum4.2 17))
        (call - (call + 65 24) (call * fixnum4.2 fixnum4.2)))
       (call * fixnum4.2 (call * fixnum4.2 (call * 55 fixnum4.2)))))))
(check-by-interp
 '(module
    (define L.fun/vector45779.4 (lambda () (call make-vector 8)))
    (define L.fun/any45780.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char45783.6
      (lambda () (call L.fun/ascii-char45784.10)))
    (define L.fun/error45781.7 (lambda () (call L.fun/error45782.9)))
    (define L.fun/vector45778.8 (lambda () (call L.fun/vector45779.4)))
    (define L.fun/error45782.9 (lambda () (error 58)))
    (define L.fun/ascii-char45784.10 (lambda () #\c))
    (let ((vector0.6 (call L.fun/vector45778.8))
          (fixnum1.5
           (call
            +
            (call
             *
             (call - (call + 162 141) (call + 140 3))
             (call * (call + 182 101) (call - 38 11)))
            (call
             -
             (call * (call + 96 72) (call * 193 203))
             (call - (call + 2 43) (call * 32 90)))))
          (boolean2.4 (call boolean? (call L.fun/any45780.5)))
          (error3.3 (call L.fun/error45781.7))
          (fixnum4.2
           (call
            +
            (call
             *
             (call * (call + 144 112) (call - 161 131))
             (call * (call * 101 84) (call - 187 100)))
            (call
             -
             (call + (call - 236 203) (call * 124 120))
             (call - (call - 178 169) (call - 220 171)))))
          (ascii-char5.1 (call L.fun/ascii-char45783.6)))
      error3.3)))
(check-by-interp
 '(module
    (define L.fun/ascii-char47094.4 (lambda () #\c))
    (define L.fun/empty47092.5 (lambda () empty))
    (define L.fun/empty47086.6 (lambda () empty))
    (define L.fun/void47084.7 (lambda () (void)))
    (define L.fun/empty47090.8 (lambda () empty))
    (define L.fun/vector47088.9 (lambda () (call make-vector 8)))
    (define L.fun/empty47089.10 (lambda () (call L.fun/empty47090.8)))
    (define L.fun/empty47091.11 (lambda () (call L.fun/empty47092.5)))
    (define L.fun/empty47085.12 (lambda () (call L.fun/empty47086.6)))
    (define L.fun/void47083.13 (lambda () (call L.fun/void47084.7)))
    (define L.fun/ascii-char47093.14
      (lambda () (call L.fun/ascii-char47094.4)))
    (define L.fun/vector47087.15 (lambda () (call L.fun/vector47088.9)))
    (let ((void0.6 (call L.fun/void47083.13))
          (empty1.5 (call L.fun/empty47085.12))
          (vector2.4 (call L.fun/vector47087.15))
          (empty3.3 (call L.fun/empty47089.10))
          (empty4.2 (call L.fun/empty47091.11))
          (ascii-char5.1 (call L.fun/ascii-char47093.14)))
      (call
       *
       (call
        -
        (call - (call + 56 191) (call * 131 57))
        (call + (call - 173 171) (call * 131 138)))
       (call
        *
        (call * (call + 201 4) (call + 207 127))
        (call - (call + 4 190) (call + 141 249)))))))
(check-by-interp
 '(module
    (define L.fun/any47118.4 (lambda () (error 88)))
    (define L.fun/error47111.5 (lambda () (call L.fun/error47112.9)))
    (define L.fun/error47113.6 (lambda () (call L.fun/error47114.10)))
    (define L.fun/any47115.7 (lambda () empty))
    (define L.fun/vector47116.8 (lambda () (call L.fun/vector47117.11)))
    (define L.fun/error47112.9 (lambda () (error 228)))
    (define L.fun/error47114.10 (lambda () (error 240)))
    (define L.fun/vector47117.11 (lambda () (call make-vector 8)))
    (let ((error0.6 (call L.fun/error47111.5))
          (error1.5 (call L.fun/error47113.6))
          (boolean2.4 (call void? (call L.fun/any47115.7)))
          (vector3.3 (call L.fun/vector47116.8))
          (fixnum4.2
           (call
            *
            (call
             -
             (call * (call - 197 21) (call + 170 236))
             (call - (call - 46 172) (call - 8 237)))
            (call
             *
             (call + (call * 195 45) (call - 201 18))
             (call + (call * 196 45) (call - 192 59)))))
          (boolean5.1 (call ascii-char? (call L.fun/any47118.4))))
      vector3.3)))
(check-by-interp
 '(module
    (define L.fun/ascii-char48099.4
      (lambda () (call L.fun/ascii-char48100.11)))
    (define L.fun/void48092.5 (lambda () (void)))
    (define L.fun/void48098.6 (lambda () (void)))
    (define L.fun/void48093.7 (lambda () (call L.fun/void48094.9)))
    (define L.fun/void48097.8 (lambda () (call L.fun/void48098.6)))
    (define L.fun/void48094.9 (lambda () (void)))
    (define L.fun/empty48096.10 (lambda () empty))
    (define L.fun/ascii-char48100.11 (lambda () #\c))
    (define L.fun/vector48102.12 (lambda () (call make-vector 8)))
    (define L.fun/empty48095.13 (lambda () (call L.fun/empty48096.10)))
    (define L.fun/vector48101.14 (lambda () (call L.fun/vector48102.12)))
    (define L.fun/any48103.15 (lambda () #\c))
    (define L.fun/void48091.16 (lambda () (call L.fun/void48092.5)))
    (let ((void0.6 (call L.fun/void48091.16))
          (void1.5 (call L.fun/void48093.7))
          (empty2.4 (call L.fun/empty48095.13))
          (void3.3 (call L.fun/void48097.8))
          (ascii-char4.2 (call L.fun/ascii-char48099.4))
          (vector5.1 (call L.fun/vector48101.14)))
      (call ascii-char? (call L.fun/any48103.15)))))
(check-by-interp
 '(module
    (define L.fun/vector52040.4 (lambda () (call L.fun/vector52041.13)))
    (define L.fun/error52042.5 (lambda () (call L.fun/error52043.12)))
    (define L.fun/empty52039.6 (lambda () empty))
    (define L.fun/void52044.7 (lambda () (call L.fun/void52045.8)))
    (define L.fun/void52045.8 (lambda () (void)))
    (define L.fun/empty52038.9 (lambda () (call L.fun/empty52039.6)))
    (define L.fun/empty52036.10 (lambda () (call L.fun/empty52037.11)))
    (define L.fun/empty52037.11 (lambda () empty))
    (define L.fun/error52043.12 (lambda () (error 159)))
    (define L.fun/vector52041.13 (lambda () (call make-vector 8)))
    (let ((fixnum0.6
           (call
            *
            (call
             *
             (call * (call + 0 118) (call * 34 241))
             (call - (call + 190 46) (call + 107 199)))
            (call
             +
             (call - (call - 145 247) (call + 35 121))
             (call - (call * 195 114) (call * 67 211)))))
          (empty1.5 (call L.fun/empty52036.10))
          (empty2.4 (call L.fun/empty52038.9))
          (vector3.3 (call L.fun/vector52040.4))
          (error4.2 (call L.fun/error52042.5))
          (void5.1 (call L.fun/void52044.7)))
      vector3.3)))
(check-by-interp
 '(module
    (define L.fun/error52272.4 (lambda () (call L.fun/error52273.11)))
    (define L.fun/ascii-char52269.5 (lambda () (call L.fun/ascii-char52270.9)))
    (define L.fun/vector52264.6 (lambda () (call make-vector 8)))
    (define L.fun/any52271.7 (lambda () (void)))
    (define L.fun/void52268.8 (lambda () (void)))
    (define L.fun/ascii-char52270.9 (lambda () #\c))
    (define L.fun/void52267.10 (lambda () (call L.fun/void52268.8)))
    (define L.fun/error52273.11 (lambda () (error 58)))
    (define L.fun/ascii-char52266.12 (lambda () #\c))
    (define L.fun/vector52263.13 (lambda () (call L.fun/vector52264.6)))
    (define L.fun/ascii-char52265.14
      (lambda () (call L.fun/ascii-char52266.12)))
    (let ((vector0.6 (call L.fun/vector52263.13))
          (ascii-char1.5 (call L.fun/ascii-char52265.14))
          (void2.4 (call L.fun/void52267.10))
          (ascii-char3.3 (call L.fun/ascii-char52269.5))
          (boolean4.2 (call vector? (call L.fun/any52271.7)))
          (error5.1 (call L.fun/error52272.4)))
      void2.4)))
(check-by-interp
 '(module
    (define L.fun/vector52861.4 (lambda () (call make-vector 8)))
    (define L.fun/empty52857.5 (lambda () empty))
    (define L.fun/ascii-char52854.6
      (lambda () (call L.fun/ascii-char52855.10)))
    (define L.fun/error52853.7 (lambda () (error 46)))
    (define L.fun/empty52863.8 (lambda () empty))
    (define L.fun/empty52856.9 (lambda () (call L.fun/empty52857.5)))
    (define L.fun/ascii-char52855.10 (lambda () #\c))
    (define L.fun/empty52859.11 (lambda () empty))
    (define L.fun/vector52860.12 (lambda () (call L.fun/vector52861.4)))
    (define L.fun/error52852.13 (lambda () (call L.fun/error52853.7)))
    (define L.fun/empty52862.14 (lambda () (call L.fun/empty52863.8)))
    (define L.fun/empty52858.15 (lambda () (call L.fun/empty52859.11)))
    (let ((error0.6 (call L.fun/error52852.13))
          (ascii-char1.5 (call L.fun/ascii-char52854.6))
          (empty2.4 (call L.fun/empty52856.9))
          (empty3.3 (call L.fun/empty52858.15))
          (vector4.2 (call L.fun/vector52860.12))
          (empty5.1 (call L.fun/empty52862.14)))
      vector4.2)))
(check-by-interp
 '(module
    (define L.fun/vector55180.4 (lambda () (call L.fun/vector55181.13)))
    (define L.fun/empty55178.5 (lambda () (call L.fun/empty55179.8)))
    (define L.fun/empty55177.6 (lambda () empty))
    (define L.fun/vector55175.7 (lambda () (call make-vector 8)))
    (define L.fun/empty55179.8 (lambda () empty))
    (define L.fun/empty55176.9 (lambda () (call L.fun/empty55177.6)))
    (define L.fun/empty55173.10 (lambda () empty))
    (define L.fun/error55182.11 (lambda () (call L.fun/error55183.12)))
    (define L.fun/error55183.12 (lambda () (error 81)))
    (define L.fun/vector55181.13 (lambda () (call make-vector 8)))
    (define L.fun/empty55172.14 (lambda () (call L.fun/empty55173.10)))
    (define L.fun/vector55174.15 (lambda () (call L.fun/vector55175.7)))
    (let ((empty0.6 (call L.fun/empty55172.14))
          (vector1.5 (call L.fun/vector55174.15))
          (empty2.4 (call L.fun/empty55176.9))
          (fixnum3.3
           (call
            +
            (call
             -
             (call + (call + 47 22) (call - 107 52))
             (call - (call + 217 210) (call * 195 126)))
            (call
             *
             (call * (call * 52 161) (call - 18 202))
             (call - (call - 158 88) (call * 238 2)))))
          (empty4.2 (call L.fun/empty55178.5))
          (vector5.1 (call L.fun/vector55180.4)))
      (call L.fun/error55182.11))))
(check-by-interp
 '(module
    (define L.fun/ascii-char57873.4
      (lambda () (call L.fun/ascii-char57874.12)))
    (define L.fun/vector57872.5 (lambda () (call make-vector 8)))
    (define L.fun/error57869.6 (lambda () (call L.fun/error57870.13)))
    (define L.fun/empty57877.7 (lambda () (call L.fun/empty57878.11)))
    (define L.fun/error57876.8 (lambda () (error 173)))
    (define L.fun/vector57871.9 (lambda () (call L.fun/vector57872.5)))
    (define L.fun/vector57868.10 (lambda () (call make-vector 8)))
    (define L.fun/empty57878.11 (lambda () empty))
    (define L.fun/ascii-char57874.12 (lambda () #\c))
    (define L.fun/error57870.13 (lambda () (error 150)))
    (define L.fun/vector57867.14 (lambda () (call L.fun/vector57868.10)))
    (define L.fun/error57875.15 (lambda () (call L.fun/error57876.8)))
    (let ((vector0.6 (call L.fun/vector57867.14))
          (error1.5 (call L.fun/error57869.6))
          (vector2.4 (call L.fun/vector57871.9))
          (ascii-char3.3 (call L.fun/ascii-char57873.4))
          (fixnum4.2
           (call
            *
            (call
             -
             (call * (call * 12 171) (call * 40 153))
             (call * (call * 92 21) (call * 29 19)))
            (call
             -
             (call + (call + 156 15) (call - 123 254))
             (call * (call * 26 243) (call + 175 73)))))
          (error5.1 (call L.fun/error57875.15)))
      (call L.fun/empty57877.7))))
(check-by-interp
 '(module
    (define L.fun/empty58877.4 (lambda () empty))
    (define L.fun/error58875.5 (lambda () (error 150)))
    (define L.fun/ascii-char58879.6 (lambda () #\c))
    (define L.fun/any58880.7 (lambda () #f))
    (define L.fun/empty58876.8 (lambda () (call L.fun/empty58877.4)))
    (define L.fun/ascii-char58878.9 (lambda () (call L.fun/ascii-char58879.6)))
    (define L.fun/error58874.10 (lambda () (call L.fun/error58875.5)))
    (let ((fixnum0.6
           (call
            +
            (call
             -
             (call - (call - 253 149) (call * 59 231))
             (call - (call - 187 25) (call * 117 50)))
            (call
             *
             (call * (call - 175 64) (call + 38 71))
             (call - (call - 125 238) (call * 66 56)))))
          (fixnum1.5
           (call
            *
            (call
             +
             (call + (call - 111 1) (call * 197 162))
             (call * (call - 161 250) (call + 61 136)))
            (call
             +
             (call + (call - 174 129) (call + 222 67))
             (call - (call * 127 252) (call - 210 217)))))
          (error2.4 (call L.fun/error58874.10))
          (empty3.3 (call L.fun/empty58876.8))
          (ascii-char4.2 (call L.fun/ascii-char58878.9))
          (boolean5.1 (call fixnum? (call L.fun/any58880.7))))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.fun/vector63530.4 (lambda () (call L.fun/vector63531.5)))
    (define L.fun/vector63531.5 (lambda () (call make-vector 8)))
    (define L.fun/empty63532.6 (lambda () (call L.fun/empty63533.10)))
    (define L.fun/empty63536.7 (lambda () (call L.fun/empty63537.11)))
    (define L.fun/void63534.8 (lambda () (call L.fun/void63535.9)))
    (define L.fun/void63535.9 (lambda () (void)))
    (define L.fun/empty63533.10 (lambda () empty))
    (define L.fun/empty63537.11 (lambda () empty))
    (let ((vector0.6 (call L.fun/vector63530.4))
          (fixnum1.5
           (call
            -
            (call
             -
             (call - (call * 7 190) (call - 86 156))
             (call - (call * 232 191) (call + 183 204)))
            (call
             +
             (call + (call * 101 223) (call + 63 76))
             (call * (call + 241 26) (call + 31 208)))))
          (empty2.4 (call L.fun/empty63532.6))
          (void3.3 (call L.fun/void63534.8))
          (fixnum4.2
           (call
            *
            (call
             -
             (call * (call * 245 158) (call * 73 130))
             (call * (call * 177 88) (call - 215 106)))
            (call
             -
             (call - (call + 234 51) (call + 138 97))
             (call + (call - 128 196) (call + 14 44)))))
          (empty5.1 (call L.fun/empty63536.7)))
      void3.3)))
(check-by-interp
 '(module
    (define L.fun/ascii-char63953.4 (lambda () #\c))
    (define L.fun/error63956.5 (lambda () (error 78)))
    (define L.fun/ascii-char63952.6 (lambda () (call L.fun/ascii-char63953.4)))
    (define L.fun/error63955.7 (lambda () (call L.fun/error63956.5)))
    (define L.fun/any63954.8 (lambda () 223))
    (let ((fixnum0.6
           (call
            +
            (call
             +
             (call + (call * 28 253) (call * 190 215))
             (call * (call + 221 85) (call - 186 105)))
            (call
             +
             (call - (call - 240 174) (call + 204 128))
             (call * (call * 137 126) (call + 52 52)))))
          (ascii-char1.5 (call L.fun/ascii-char63952.6))
          (fixnum2.4
           (call
            -
            (call
             -
             (call + (call + 53 15) (call - 99 8))
             (call * (call * 117 30) (call * 149 47)))
            (call
             *
             (call - (call - 174 234) (call + 128 38))
             (call + (call - 222 86) (call + 69 155)))))
          (fixnum3.3
           (call
            -
            (call
             *
             (call + (call + 109 231) (call + 16 242))
             (call * (call - 167 32) (call * 250 197)))
            (call
             *
             (call + (call + 191 144) (call + 224 102))
             (call * (call + 64 254) (call * 129 45)))))
          (boolean4.2 (call void? (call L.fun/any63954.8)))
          (error5.1 (call L.fun/error63955.7)))
      ascii-char1.5)))
(check-by-interp
 '(module
    (define L.fun/vector69403.4 (lambda () (call make-vector 8)))
    (define L.fun/empty69407.5 (lambda () empty))
    (define L.fun/ascii-char69397.6 (lambda () #\c))
    (define L.fun/empty69406.7 (lambda () (call L.fun/empty69407.5)))
    (define L.fun/empty69404.8 (lambda () (call L.fun/empty69405.15)))
    (define L.fun/vector69401.9 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char69398.10
      (lambda () (call L.fun/ascii-char69399.13)))
    (define L.fun/vector69402.11 (lambda () (call L.fun/vector69403.4)))
    (define L.fun/vector69400.12 (lambda () (call L.fun/vector69401.9)))
    (define L.fun/ascii-char69399.13 (lambda () #\c))
    (define L.fun/ascii-char69396.14
      (lambda () (call L.fun/ascii-char69397.6)))
    (define L.fun/empty69405.15 (lambda () empty))
    (let ((ascii-char0.6 (call L.fun/ascii-char69396.14))
          (ascii-char1.5 (call L.fun/ascii-char69398.10))
          (vector2.4 (call L.fun/vector69400.12))
          (vector3.3 (call L.fun/vector69402.11))
          (empty4.2 (call L.fun/empty69404.8))
          (empty5.1 (call L.fun/empty69406.7)))
      (call
       *
       (call
        -
        (call - (call * 180 164) (call * 223 228))
        (call * (call - 62 114) (call * 234 128)))
       (call
        *
        (call + (call * 9 6) (call - 67 220))
        (call + (call + 191 184) (call - 185 239)))))))
(check-by-interp
 '(module
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
            *
            (call
             +
             (call * (call + 13 42) (call + 111 225))
             (call - (call - 109 168) (call + 170 85)))
            (call
             -
             (call - (call + 9 156) (call + 112 170))
             (call + (call * 85 19) (call - 138 174)))))
          (empty1.5 (call L.fun/empty71269.12))
          (ascii-char2.4 (call L.fun/ascii-char71271.6))
          (ascii-char3.3 (call L.fun/ascii-char71273.7))
          (ascii-char4.2 (call L.fun/ascii-char71275.10))
          (void5.1 (call L.fun/void71277.11)))
      empty1.5)))
(check-by-interp
 '(module
    (define L.fun/void72540.4 (lambda () (void)))
    (define L.fun/ascii-char72544.5 (lambda () #\c))
    (define L.fun/vector72535.6 (lambda () (call L.fun/vector72536.12)))
    (define L.fun/ascii-char72543.7 (lambda () (call L.fun/ascii-char72544.5)))
    (define L.fun/vector72541.8 (lambda () (call L.fun/vector72542.15)))
    (define L.fun/vector72533.9 (lambda () (call L.fun/vector72534.14)))
    (define L.fun/vector72538.10 (lambda () (call make-vector 8)))
    (define L.fun/void72539.11 (lambda () (call L.fun/void72540.4)))
    (define L.fun/vector72536.12 (lambda () (call make-vector 8)))
    (define L.fun/vector72537.13 (lambda () (call L.fun/vector72538.10)))
    (define L.fun/vector72534.14 (lambda () (call make-vector 8)))
    (define L.fun/vector72542.15 (lambda () (call make-vector 8)))
    (let ((vector0.6 (call L.fun/vector72533.9))
          (fixnum1.5
           (call
            *
            (call
             -
             (call * (call * 22 211) (call + 215 201))
             (call + (call + 76 166) (call + 216 242)))
            (call
             +
             (call - (call - 244 48) (call - 84 199))
             (call * (call + 9 250) (call + 52 76)))))
          (vector2.4 (call L.fun/vector72535.6))
          (vector3.3 (call L.fun/vector72537.13))
          (void4.2 (call L.fun/void72539.11))
          (vector5.1 (call L.fun/vector72541.8)))
      (call L.fun/ascii-char72543.7))))
(check-by-interp
 '(module
    (define L.fun/vector72932.4 (lambda () (call L.fun/vector72933.10)))
    (define L.fun/ascii-char72931.5 (lambda () #\c))
    (define L.fun/any72925.6 (lambda () 152))
    (define L.fun/empty72928.7 (lambda () (call L.fun/empty72929.12)))
    (define L.fun/ascii-char72930.8 (lambda () (call L.fun/ascii-char72931.5)))
    (define L.fun/error72927.9 (lambda () (error 138)))
    (define L.fun/vector72933.10 (lambda () (call make-vector 8)))
    (define L.fun/error72926.11 (lambda () (call L.fun/error72927.9)))
    (define L.fun/empty72929.12 (lambda () empty))
    (let ((boolean0.6 (call pair? (call L.fun/any72925.6)))
          (error1.5 (call L.fun/error72926.11))
          (empty2.4 (call L.fun/empty72928.7))
          (ascii-char3.3 (call L.fun/ascii-char72930.8))
          (fixnum4.2
           (call
            +
            (call
             +
             (call * (call * 41 164) (call - 117 110))
             (call * (call * 10 180) (call + 124 133)))
            (call
             *
             (call - (call + 98 146) (call - 174 53))
             (call * (call + 208 81) (call - 158 181)))))
          (vector5.1 (call L.fun/vector72932.4)))
      vector5.1)))
(check-by-interp
 '(module
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
            +
            (call
             -
             (call - (call * 236 253) (call * 87 183))
             (call + (call * 168 52) (call - 58 11)))
            (call
             -
             (call + (call * 5 220) (call - 13 211))
             (call - (call + 244 119) (call * 158 73)))))
          (empty1.5 (call L.fun/empty73456.4))
          (ascii-char2.4 (call L.fun/ascii-char73458.5))
          (error3.3 (call L.fun/error73460.7))
          (fixnum4.2
           (call
            -
            (call
             *
             (call - (call - 251 188) (call + 221 232))
             (call - (call - 110 216) (call * 249 19)))
            (call
             -
             (call * (call * 105 84) (call + 213 46))
             (call * (call * 78 249) (call - 247 115)))))
          (empty5.1 (call L.fun/empty73462.11)))
      error3.3)))
(check-by-interp
 '(module
    (define L.fun/vector75268.4 (lambda () (call make-vector 8)))
    (define L.fun/error75260.5 (lambda () (error 129)))
    (define L.fun/error75264.6 (lambda () (error 144)))
    (define L.fun/ascii-char75266.7 (lambda () #\c))
    (define L.fun/vector75267.8 (lambda () (call L.fun/vector75268.4)))
    (define L.fun/error75263.9 (lambda () (call L.fun/error75264.6)))
    (define L.fun/error75259.10 (lambda () (call L.fun/error75260.5)))
    (define L.fun/any75262.11 (lambda () empty))
    (define L.fun/any75261.12 (lambda () 14))
    (define L.fun/ascii-char75265.13
      (lambda () (call L.fun/ascii-char75266.7)))
    (let ((error0.6 (call L.fun/error75259.10))
          (boolean1.5 (call vector? (call L.fun/any75261.12)))
          (boolean2.4 (call vector? (call L.fun/any75262.11)))
          (error3.3 (call L.fun/error75263.9))
          (ascii-char4.2 (call L.fun/ascii-char75265.13))
          (fixnum5.1
           (call
            +
            (call
             *
             (call + (call * 46 65) (call + 214 51))
             (call - (call * 212 166) (call + 156 20)))
            (call
             -
             (call * (call + 42 128) (call - 167 19))
             (call - (call - 112 100) (call * 242 152))))))
      (call L.fun/vector75267.8))))
(check-by-interp
 '(module
    (define L.fun/error75926.4 (lambda () (call L.fun/error75927.12)))
    (define L.fun/vector75921.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char75925.6 (lambda () #\c))
    (define L.fun/error75928.7 (lambda () (call L.fun/error75929.9)))
    (define L.fun/ascii-char75918.8
      (lambda () (call L.fun/ascii-char75919.14)))
    (define L.fun/error75929.9 (lambda () (error 68)))
    (define L.fun/empty75923.10 (lambda () empty))
    (define L.fun/vector75920.11 (lambda () (call L.fun/vector75921.5)))
    (define L.fun/error75927.12 (lambda () (error 149)))
    (define L.fun/empty75922.13 (lambda () (call L.fun/empty75923.10)))
    (define L.fun/ascii-char75919.14 (lambda () #\c))
    (define L.fun/ascii-char75924.15
      (lambda () (call L.fun/ascii-char75925.6)))
    (let ((ascii-char0.6 (call L.fun/ascii-char75918.8))
          (vector1.5 (call L.fun/vector75920.11))
          (empty2.4 (call L.fun/empty75922.13))
          (ascii-char3.3 (call L.fun/ascii-char75924.15))
          (error4.2 (call L.fun/error75926.4))
          (error5.1 (call L.fun/error75928.7)))
      vector1.5)))
(check-by-interp
 '(module
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
            +
            (call
             +
             (call + (call * 195 100) (call - 235 242))
             (call * (call * 27 94) (call - 151 100)))
            (call
             -
             (call - (call - 1 94) (call - 181 151))
             (call * (call + 154 223) (call - 161 157)))))
          (empty2.4 (call L.fun/empty77840.8))
          (void3.3 (call L.fun/void77842.4))
          (error4.2 (call L.fun/error77844.12))
          (error5.1 (call L.fun/error77846.6)))
      empty2.4)))
(check-by-interp
 '(module
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
            -
            (call
             +
             (call - (call - 149 60) (call * 198 7))
             (call - (call + 186 16) (call + 61 215)))
            (call
             -
             (call - (call * 164 205) (call * 148 108))
             (call * (call * 26 37) (call * 100 4)))))
          (boolean2.4 (call boolean? (call L.fun/any78094.7)))
          (boolean3.3 (call ascii-char? (call L.fun/any78095.4)))
          (fixnum4.2
           (call
            -
            (call
             +
             (call + (call * 17 173) (call - 223 74))
             (call * (call + 192 73) (call * 191 188)))
            (call
             +
             (call - (call * 192 228) (call * 220 105))
             (call - (call - 233 129) (call - 11 86)))))
          (error5.1 (call L.fun/error78096.10)))
      (call L.fun/void78098.11))))
(check-by-interp
 '(module
    (define L.fun/vector78121.4 (lambda () (call make-vector 8)))
    (define L.fun/error78128.5 (lambda () (error 0)))
    (define L.fun/error78125.6 (lambda () (call L.fun/error78126.8)))
    (define L.fun/void78130.7 (lambda () (void)))
    (define L.fun/error78126.8 (lambda () (error 237)))
    (define L.fun/empty78124.9 (lambda () empty))
    (define L.fun/any78122.10 (lambda () (call make-vector 8)))
    (define L.fun/vector78120.11 (lambda () (call L.fun/vector78121.4)))
    (define L.fun/void78129.12 (lambda () (call L.fun/void78130.7)))
    (define L.fun/error78127.13 (lambda () (call L.fun/error78128.5)))
    (define L.fun/empty78123.14 (lambda () (call L.fun/empty78124.9)))
    (let ((vector0.6 (call L.fun/vector78120.11))
          (boolean1.5 (call ascii-char? (call L.fun/any78122.10)))
          (empty2.4 (call L.fun/empty78123.14))
          (error3.3 (call L.fun/error78125.6))
          (error4.2 (call L.fun/error78127.13))
          (void5.1 (call L.fun/void78129.12)))
      empty2.4)))
(check-by-interp
 '(module
    (define L.fun/ascii-char80978.4
      (lambda () (call L.fun/ascii-char80979.15)))
    (define L.fun/void80976.5 (lambda () (call L.fun/void80977.7)))
    (define L.fun/empty80970.6 (lambda () (call L.fun/empty80971.9)))
    (define L.fun/void80977.7 (lambda () (void)))
    (define L.fun/empty80974.8 (lambda () (call L.fun/empty80975.11)))
    (define L.fun/empty80971.9 (lambda () empty))
    (define L.fun/vector80981.10 (lambda () (call make-vector 8)))
    (define L.fun/empty80975.11 (lambda () empty))
    (define L.fun/vector80980.12 (lambda () (call L.fun/vector80981.10)))
    (define L.fun/error80973.13 (lambda () (error 138)))
    (define L.fun/error80972.14 (lambda () (call L.fun/error80973.13)))
    (define L.fun/ascii-char80979.15 (lambda () #\c))
    (let ((empty0.6 (call L.fun/empty80970.6))
          (error1.5 (call L.fun/error80972.14))
          (empty2.4 (call L.fun/empty80974.8))
          (void3.3 (call L.fun/void80976.5))
          (ascii-char4.2 (call L.fun/ascii-char80978.4))
          (vector5.1 (call L.fun/vector80980.12)))
      void3.3)))
(check-by-interp
 '(module
    (define L.fun/void81922.4 (lambda () (void)))
    (define L.fun/void81924.5 (lambda () (void)))
    (define L.fun/ascii-char81925.6 (lambda () (call L.fun/ascii-char81926.9)))
    (define L.fun/error81919.7 (lambda () (call L.fun/error81920.10)))
    (define L.fun/vector81917.8 (lambda () (call L.fun/vector81918.14)))
    (define L.fun/ascii-char81926.9 (lambda () #\c))
    (define L.fun/error81920.10 (lambda () (error 189)))
    (define L.fun/void81923.11 (lambda () (call L.fun/void81924.5)))
    (define L.fun/void81915.12 (lambda () (call L.fun/void81916.15)))
    (define L.fun/void81921.13 (lambda () (call L.fun/void81922.4)))
    (define L.fun/vector81918.14 (lambda () (call make-vector 8)))
    (define L.fun/void81916.15 (lambda () (void)))
    (let ((void0.6 (call L.fun/void81915.12))
          (vector1.5 (call L.fun/vector81917.8))
          (error2.4 (call L.fun/error81919.7))
          (void3.3 (call L.fun/void81921.13))
          (void4.2 (call L.fun/void81923.11))
          (fixnum5.1
           (call
            +
            (call
             *
             (call + (call + 48 248) (call * 144 160))
             (call + (call + 9 103) (call - 175 37)))
            (call
             +
             (call * (call * 230 172) (call + 127 71))
             (call * (call * 93 114) (call + 90 86))))))
      (call L.fun/ascii-char81925.6))))
(check-by-interp
 '(module
    (define L.fun/ascii-char84565.4 (lambda () #\c))
    (define L.fun/vector84574.5 (lambda () (call make-vector 8)))
    (define L.fun/void84570.6 (lambda () (void)))
    (define L.fun/any84566.7 (lambda () #\c))
    (define L.fun/void84572.8 (lambda () (void)))
    (define L.fun/void84569.9 (lambda () (call L.fun/void84570.6)))
    (define L.fun/ascii-char84564.10
      (lambda () (call L.fun/ascii-char84565.4)))
    (define L.fun/empty84567.11 (lambda () (call L.fun/empty84568.12)))
    (define L.fun/empty84568.12 (lambda () empty))
    (define L.fun/vector84573.13 (lambda () (call L.fun/vector84574.5)))
    (define L.fun/void84571.14 (lambda () (call L.fun/void84572.8)))
    (let ((ascii-char0.6 (call L.fun/ascii-char84564.10))
          (boolean1.5 (call vector? (call L.fun/any84566.7)))
          (empty2.4 (call L.fun/empty84567.11))
          (void3.3 (call L.fun/void84569.9))
          (void4.2 (call L.fun/void84571.14))
          (vector5.1 (call L.fun/vector84573.13)))
      vector5.1)))
(check-by-interp
 '(module
    (define L.fun/vector84815.4 (lambda () (call L.fun/vector84816.11)))
    (define L.fun/vector84812.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char84820.6 (lambda () (call L.fun/ascii-char84821.7)))
    (define L.fun/ascii-char84821.7 (lambda () #\c))
    (define L.fun/error84818.8 (lambda () (error 169)))
    (define L.fun/error84817.9 (lambda () (call L.fun/error84818.8)))
    (define L.fun/vector84811.10 (lambda () (call L.fun/vector84812.5)))
    (define L.fun/vector84816.11 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char84813.12
      (lambda () (call L.fun/ascii-char84814.14)))
    (define L.fun/any84819.13 (lambda () #f))
    (define L.fun/ascii-char84814.14 (lambda () #\c))
    (let ((vector0.6 (call L.fun/vector84811.10))
          (ascii-char1.5 (call L.fun/ascii-char84813.12))
          (vector2.4 (call L.fun/vector84815.4))
          (error3.3 (call L.fun/error84817.9))
          (boolean4.2 (call pair? (call L.fun/any84819.13)))
          (ascii-char5.1 (call L.fun/ascii-char84820.6)))
      ascii-char1.5)))
(check-by-interp
 '(module
    (define L.fun/void87672.4 (lambda () (void)))
    (define L.fun/empty87673.5 (lambda () (call L.fun/empty87674.14)))
    (define L.fun/void87671.6 (lambda () (call L.fun/void87672.4)))
    (define L.fun/empty87668.7 (lambda () empty))
    (define L.fun/empty87670.8 (lambda () empty))
    (define L.fun/vector87675.9 (lambda () (call L.fun/vector87676.10)))
    (define L.fun/vector87676.10 (lambda () (call make-vector 8)))
    (define L.fun/empty87669.11 (lambda () (call L.fun/empty87670.8)))
    (define L.fun/error87677.12 (lambda () (call L.fun/error87678.15)))
    (define L.fun/empty87667.13 (lambda () (call L.fun/empty87668.7)))
    (define L.fun/empty87674.14 (lambda () empty))
    (define L.fun/error87678.15 (lambda () (error 135)))
    (let ((fixnum0.6
           (call
            +
            (call
             -
             (call + (call + 47 44) (call - 202 109))
             (call + (call * 97 58) (call + 57 239)))
            (call
             +
             (call * (call + 88 9) (call - 72 55))
             (call - (call - 103 93) (call * 6 139)))))
          (empty1.5 (call L.fun/empty87667.13))
          (empty2.4 (call L.fun/empty87669.11))
          (void3.3 (call L.fun/void87671.6))
          (empty4.2 (call L.fun/empty87673.5))
          (vector5.1 (call L.fun/vector87675.9)))
      (call L.fun/error87677.12))))
(check-by-interp
 '(module
    (define L.fun/empty87682.4 (lambda () empty))
    (define L.fun/empty87687.5 (lambda () (call L.fun/empty87688.9)))
    (define L.fun/void87685.6 (lambda () (call L.fun/void87686.12)))
    (define L.fun/vector87684.7 (lambda () (call make-vector 8)))
    (define L.fun/error87691.8 (lambda () (call L.fun/error87692.11)))
    (define L.fun/empty87688.9 (lambda () empty))
    (define L.fun/empty87690.10 (lambda () empty))
    (define L.fun/error87692.11 (lambda () (error 15)))
    (define L.fun/void87686.12 (lambda () (void)))
    (define L.fun/empty87689.13 (lambda () (call L.fun/empty87690.10)))
    (define L.fun/vector87683.14 (lambda () (call L.fun/vector87684.7)))
    (define L.fun/empty87681.15 (lambda () (call L.fun/empty87682.4)))
    (let ((empty0.6 (call L.fun/empty87681.15))
          (vector1.5 (call L.fun/vector87683.14))
          (void2.4 (call L.fun/void87685.6))
          (empty3.3 (call L.fun/empty87687.5))
          (empty4.2 (call L.fun/empty87689.13))
          (error5.1 (call L.fun/error87691.8)))
      void2.4)))
(check-by-interp
 '(module
    (define L.fun/vector89241.4 (lambda () (call make-vector 8)))
    (define L.fun/empty89236.5 (lambda () (call L.fun/empty89237.10)))
    (define L.fun/empty89243.6 (lambda () empty))
    (define L.fun/empty89244.7 (lambda () (call L.fun/empty89245.11)))
    (define L.fun/vector89240.8 (lambda () (call L.fun/vector89241.4)))
    (define L.fun/void89235.9 (lambda () (void)))
    (define L.fun/empty89237.10 (lambda () empty))
    (define L.fun/empty89245.11 (lambda () empty))
    (define L.fun/empty89238.12 (lambda () (call L.fun/empty89239.13)))
    (define L.fun/empty89239.13 (lambda () empty))
    (define L.fun/empty89242.14 (lambda () (call L.fun/empty89243.6)))
    (define L.fun/void89234.15 (lambda () (call L.fun/void89235.9)))
    (let ((void0.6 (call L.fun/void89234.15))
          (empty1.5 (call L.fun/empty89236.5))
          (empty2.4 (call L.fun/empty89238.12))
          (vector3.3 (call L.fun/vector89240.8))
          (empty4.2 (call L.fun/empty89242.14))
          (empty5.1 (call L.fun/empty89244.7)))
      (call
       -
       (call
        *
        (call + (call - 252 165) (call + 36 64))
        (call + (call + 90 55) (call + 29 249)))
       (call
        *
        (call + (call - 133 19) (call + 142 174))
        (call - (call + 152 75) (call * 176 198)))))))
(check-by-interp
 '(module
    (define L.fun/empty90359.4 (lambda () empty))
    (define L.fun/error90361.5 (lambda () (error 126)))
    (define L.fun/void90365.6 (lambda () (void)))
    (define L.fun/void90362.7 (lambda () (call L.fun/void90363.9)))
    (define L.fun/vector90356.8 (lambda () (call L.fun/vector90357.12)))
    (define L.fun/void90363.9 (lambda () (void)))
    (define L.fun/empty90358.10 (lambda () (call L.fun/empty90359.4)))
    (define L.fun/void90364.11 (lambda () (call L.fun/void90365.6)))
    (define L.fun/vector90357.12 (lambda () (call make-vector 8)))
    (define L.fun/error90360.13 (lambda () (call L.fun/error90361.5)))
    (let ((vector0.6 (call L.fun/vector90356.8))
          (empty1.5 (call L.fun/empty90358.10))
          (error2.4 (call L.fun/error90360.13))
          (fixnum3.3
           (call
            -
            (call
             *
             (call - (call + 207 93) (call - 220 222))
             (call + (call + 225 37) (call * 2 172)))
            (call
             *
             (call * (call - 48 69) (call * 10 27))
             (call * (call + 147 89) (call * 160 172)))))
          (void4.2 (call L.fun/void90362.7))
          (void5.1 (call L.fun/void90364.11)))
      vector0.6)))
(check-by-interp
 '(module
    (define L.fun/ascii-char91870.4 (lambda () #\c))
    (define L.fun/error91868.5 (lambda () (error 156)))
    (define L.fun/void91866.6 (lambda () (void)))
    (define L.fun/void91863.7 (lambda () (call L.fun/void91864.13)))
    (define L.fun/void91871.8 (lambda () (call L.fun/void91872.14)))
    (define L.fun/vector91873.9 (lambda () (call L.fun/vector91874.10)))
    (define L.fun/vector91874.10 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char91869.11
      (lambda () (call L.fun/ascii-char91870.4)))
    (define L.fun/void91865.12 (lambda () (call L.fun/void91866.6)))
    (define L.fun/void91864.13 (lambda () (void)))
    (define L.fun/void91872.14 (lambda () (void)))
    (define L.fun/error91867.15 (lambda () (call L.fun/error91868.5)))
    (let ((void0.6 (call L.fun/void91863.7))
          (void1.5 (call L.fun/void91865.12))
          (fixnum2.4
           (call
            *
            (call
             *
             (call + (call + 26 233) (call + 249 166))
             (call * (call - 96 24) (call + 38 237)))
            (call
             -
             (call + (call + 102 158) (call - 76 180))
             (call * (call * 59 206) (call + 40 44)))))
          (error3.3 (call L.fun/error91867.15))
          (ascii-char4.2 (call L.fun/ascii-char91869.11))
          (void5.1 (call L.fun/void91871.8)))
      (call L.fun/vector91873.9))))
(check-by-interp
 '(module
    (define L.fun/empty95365.4 (lambda () empty))
    (define L.fun/vector95371.5 (lambda () (call make-vector 8)))
    (define L.fun/empty95364.6 (lambda () (call L.fun/empty95365.4)))
    (define L.fun/error95367.7 (lambda () (error 83)))
    (define L.fun/error95366.8 (lambda () (call L.fun/error95367.7)))
    (define L.fun/empty95369.9 (lambda () empty))
    (define L.fun/vector95370.10 (lambda () (call L.fun/vector95371.5)))
    (define L.fun/empty95368.11 (lambda () (call L.fun/empty95369.9)))
    (let ((fixnum0.6
           (call
            *
            (call
             -
             (call - (call + 176 171) (call * 234 215))
             (call - (call - 20 12) (call * 43 90)))
            (call
             *
             (call + (call - 1 110) (call * 197 57))
             (call - (call - 84 170) (call * 54 176)))))
          (empty1.5 (call L.fun/empty95364.6))
          (fixnum2.4
           (call
            +
            (call
             +
             (call * (call + 159 68) (call + 237 84))
             (call * (call + 231 206) (call * 203 200)))
            (call
             -
             (call * (call + 236 192) (call - 73 248))
             (call * (call + 15 8) (call - 128 244)))))
          (error3.3 (call L.fun/error95366.8))
          (empty4.2 (call L.fun/empty95368.11))
          (vector5.1 (call L.fun/vector95370.10)))
      vector5.1)))
(check-by-interp
 '(module
    (define L.fun/any100103.4 (lambda () 81))
    (define L.fun/vector100108.5 (lambda () (call L.fun/vector100109.6)))
    (define L.fun/vector100109.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char100104.7
      (lambda () (call L.fun/ascii-char100105.12)))
    (define L.fun/empty100110.8 (lambda () (call L.fun/empty100111.10)))
    (define L.fun/error100107.9 (lambda () (error 186)))
    (define L.fun/empty100111.10 (lambda () empty))
    (define L.fun/error100106.11 (lambda () (call L.fun/error100107.9)))
    (define L.fun/ascii-char100105.12 (lambda () #\c))
    (let ((boolean0.6 (call error? (call L.fun/any100103.4)))
          (ascii-char1.5 (call L.fun/ascii-char100104.7))
          (error2.4 (call L.fun/error100106.11))
          (fixnum3.3
           (call
            *
            (call
             +
             (call - (call - 41 209) (call - 118 149))
             (call + (call + 208 53) (call * 110 126)))
            (call
             -
             (call - (call + 111 230) (call - 179 48))
             (call - (call - 88 110) (call - 121 31)))))
          (vector4.2 (call L.fun/vector100108.5))
          (fixnum5.1
           (call
            -
            (call
             -
             (call - (call - 68 199) (call + 233 131))
             (call * (call * 201 129) (call * 58 227)))
            (call
             -
             (call + (call * 254 126) (call - 46 192))
             (call + (call - 161 158) (call + 100 194))))))
      (call L.fun/empty100110.8))))
(check-by-interp
 '(module
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
            +
            (call
             *
             (call * (call + 152 31) (call + 141 66))
             (call - (call - 22 129) (call - 121 165)))
            (call
             -
             (call + (call - 53 234) (call + 60 161))
             (call - (call - 171 175) (call + 88 68)))))
          (boolean1.5 (call boolean? (call L.fun/any101991.10)))
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
    (define L.fun/any104329.4 (lambda () #f))
    (define L.fun/vector104330.5 (lambda () (call L.fun/vector104331.8)))
    (define L.fun/error104328.6 (lambda () (error 201)))
    (define L.fun/error104327.7 (lambda () (call L.fun/error104328.6)))
    (define L.fun/vector104331.8 (lambda () (call make-vector 8)))
    (define L.fun/empty104332.9 (lambda () (call L.fun/empty104333.10)))
    (define L.fun/empty104333.10 (lambda () empty))
    (let ((error0.6 (call L.fun/error104327.7))
          (fixnum1.5
           (call
            *
            (call
             -
             (call - (call + 22 73) (call * 197 152))
             (call - (call - 251 160) (call - 106 139)))
            (call
             *
             (call * (call - 162 94) (call - 113 63))
             (call + (call + 30 161) (call - 249 198)))))
          (boolean2.4 (call vector? (call L.fun/any104329.4)))
          (vector3.3 (call L.fun/vector104330.5))
          (fixnum4.2
           (call
            -
            (call
             +
             (call * (call * 76 23) (call + 56 58))
             (call + (call * 157 162) (call + 131 125)))
            (call
             -
             (call - (call + 57 1) (call - 130 212))
             (call + (call - 68 139) (call + 1 19)))))
          (empty5.1 (call L.fun/empty104332.9)))
      fixnum1.5)))
(check-by-interp
 '(module
    (define L.fun/void104914.4 (lambda () (call L.fun/void104915.11)))
    (define L.fun/ascii-char104905.5 (lambda () #\c))
    (define L.fun/empty104912.6 (lambda () (call L.fun/empty104913.14)))
    (define L.fun/vector104906.7 (lambda () (call L.fun/vector104907.13)))
    (define L.fun/ascii-char104904.8
      (lambda () (call L.fun/ascii-char104905.5)))
    (define L.fun/error104911.9 (lambda () (error 197)))
    (define L.fun/void104908.10 (lambda () (call L.fun/void104909.15)))
    (define L.fun/void104915.11 (lambda () (void)))
    (define L.fun/error104910.12 (lambda () (call L.fun/error104911.9)))
    (define L.fun/vector104907.13 (lambda () (call make-vector 8)))
    (define L.fun/empty104913.14 (lambda () empty))
    (define L.fun/void104909.15 (lambda () (void)))
    (let ((ascii-char0.6 (call L.fun/ascii-char104904.8))
          (vector1.5 (call L.fun/vector104906.7))
          (void2.4 (call L.fun/void104908.10))
          (error3.3 (call L.fun/error104910.12))
          (empty4.2 (call L.fun/empty104912.6))
          (void5.1 (call L.fun/void104914.4)))
      empty4.2)))
(check-by-interp
 '(module
    (define L.fun/error106438.4 (lambda () (error 65)))
    (define L.fun/error106446.5 (lambda () (error 16)))
    (define L.fun/error106442.6 (lambda () (error 56)))
    (define L.fun/any106436.7 (lambda () #\c))
    (define L.fun/empty106443.8 (lambda () (call L.fun/empty106444.11)))
    (define L.fun/error106441.9 (lambda () (call L.fun/error106442.6)))
    (define L.fun/vector106439.10 (lambda () (call L.fun/vector106440.12)))
    (define L.fun/empty106444.11 (lambda () empty))
    (define L.fun/vector106440.12 (lambda () (call make-vector 8)))
    (define L.fun/error106437.13 (lambda () (call L.fun/error106438.4)))
    (define L.fun/error106445.14 (lambda () (call L.fun/error106446.5)))
    (let ((boolean0.6 (call void? (call L.fun/any106436.7)))
          (error1.5 (call L.fun/error106437.13))
          (vector2.4 (call L.fun/vector106439.10))
          (error3.3 (call L.fun/error106441.9))
          (empty4.2 (call L.fun/empty106443.8))
          (error5.1 (call L.fun/error106445.14)))
      (call
       -
       (call
        +
        (call - (call * 82 242) (call * 134 230))
        (call + (call - 103 142) (call + 160 134)))
       (call
        *
        (call * (call + 60 148) (call + 54 77))
        (call + (call + 188 207) (call + 103 11)))))))
(check-by-interp
 '(module
    (define L.fun/vector107085.4 (lambda () (call make-vector 8)))
    (define L.fun/error107087.5 (lambda () (error 180)))
    (define L.fun/error107086.6 (lambda () (call L.fun/error107087.5)))
    (define L.fun/empty107081.7 (lambda () (call L.fun/empty107082.12)))
    (define L.fun/void107078.8 (lambda () (call L.fun/void107079.11)))
    (define L.fun/any107083.9 (lambda () #t))
    (define L.fun/vector107084.10 (lambda () (call L.fun/vector107085.4)))
    (define L.fun/void107079.11 (lambda () (void)))
    (define L.fun/empty107082.12 (lambda () empty))
    (define L.fun/any107080.13 (lambda () (call make-vector 8)))
    (let ((void0.6 (call L.fun/void107078.8))
          (boolean1.5 (call empty? (call L.fun/any107080.13)))
          (empty2.4 (call L.fun/empty107081.7))
          (boolean3.3 (call error? (call L.fun/any107083.9)))
          (vector4.2 (call L.fun/vector107084.10))
          (error5.1 (call L.fun/error107086.6)))
      void0.6)))
(check-by-interp
 '(module
    (define L.fun/void117284.4 (lambda () (call L.fun/void117285.13)))
    (define L.fun/void117286.5 (lambda () (call L.fun/void117287.8)))
    (define L.fun/empty117283.6 (lambda () empty))
    (define L.fun/vector117280.7 (lambda () (call make-vector 8)))
    (define L.fun/void117287.8 (lambda () (void)))
    (define L.fun/vector117279.9 (lambda () (call L.fun/vector117280.7)))
    (define L.fun/any117281.10 (lambda () 147))
    (define L.fun/any117288.11 (lambda () #f))
    (define L.fun/empty117282.12 (lambda () (call L.fun/empty117283.6)))
    (define L.fun/void117285.13 (lambda () (void)))
    (let ((vector0.6 (call L.fun/vector117279.9))
          (boolean1.5 (call void? (call L.fun/any117281.10)))
          (empty2.4 (call L.fun/empty117282.12))
          (void3.3 (call L.fun/void117284.4))
          (void4.2 (call L.fun/void117286.5))
          (boolean5.1 (call fixnum? (call L.fun/any117288.11))))
      (call
       -
       (call
        +
        (call * (call * 220 3) (call * 187 1))
        (call + (call * 94 48) (call + 132 223)))
       (call
        -
        (call + (call * 22 72) (call + 233 67))
        (call - (call + 212 215) (call * 233 140)))))))
(check-by-interp
 '(module
    (define L.fun/any119338.4 (lambda () (call make-vector 8)))
    (define L.fun/empty119330.5 (lambda () (call L.fun/empty119331.16)))
    (define L.fun/vector119340.6 (lambda () (call make-vector 8)))
    (define L.fun/error119329.7 (lambda () (error 26)))
    (define L.fun/error119337.8 (lambda () (error 74)))
    (define L.fun/vector119339.9 (lambda () (call L.fun/vector119340.6)))
    (define L.fun/void119332.10 (lambda () (call L.fun/void119333.12)))
    (define L.fun/void119334.11 (lambda () (call L.fun/void119335.13)))
    (define L.fun/void119333.12 (lambda () (void)))
    (define L.fun/void119335.13 (lambda () (void)))
    (define L.fun/error119328.14 (lambda () (call L.fun/error119329.7)))
    (define L.fun/error119336.15 (lambda () (call L.fun/error119337.8)))
    (define L.fun/empty119331.16 (lambda () empty))
    (let ((error0.6 (call L.fun/error119328.14))
          (empty1.5 (call L.fun/empty119330.5))
          (void2.4 (call L.fun/void119332.10))
          (void3.3 (call L.fun/void119334.11))
          (error4.2 (call L.fun/error119336.15))
          (boolean5.1 (call boolean? (call L.fun/any119338.4))))
      (call L.fun/vector119339.9))))
(check-by-interp
 '(module
    (define L.fun/empty122092.4 (lambda () (call L.fun/empty122093.11)))
    (define L.fun/vector122090.5 (lambda () (call make-vector 8)))
    (define L.fun/vector122088.6 (lambda () (call make-vector 8)))
    (define L.fun/error122085.7 (lambda () (call L.fun/error122086.12)))
    (define L.fun/any122091.8 (lambda () #t))
    (define L.fun/vector122089.9 (lambda () (call L.fun/vector122090.5)))
    (define L.fun/vector122087.10 (lambda () (call L.fun/vector122088.6)))
    (define L.fun/empty122093.11 (lambda () empty))
    (define L.fun/error122086.12 (lambda () (error 139)))
    (let ((error0.6 (call L.fun/error122085.7))
          (vector1.5 (call L.fun/vector122087.10))
          (fixnum2.4
           (call
            *
            (call
             *
             (call * (call * 54 211) (call + 215 140))
             (call - (call + 236 244) (call - 147 106)))
            (call
             *
             (call - (call + 155 252) (call + 184 184))
             (call - (call + 39 58) (call - 93 248)))))
          (vector3.3 (call L.fun/vector122089.9))
          (boolean4.2 (call ascii-char? (call L.fun/any122091.8)))
          (fixnum5.1
           (call
            -
            (call
             -
             (call - (call * 184 188) (call - 92 74))
             (call * (call - 139 155) (call * 174 245)))
            (call
             *
             (call * (call + 104 92) (call - 172 92))
             (call - (call - 63 247) (call * 226 165))))))
      (call L.fun/empty122092.4))))
(check-by-interp
 '(module
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
    (let ((boolean0.6 (call boolean? (call L.fun/any122156.11)))
          (empty1.5 (call L.fun/empty122157.12))
          (fixnum2.4
           (call
            -
            (call
             -
             (call - (call - 171 12) (call - 195 56))
             (call + (call - 119 28) (call * 232 210)))
            (call
             +
             (call + (call - 13 38) (call * 179 162))
             (call * (call + 91 145) (call - 52 58)))))
          (ascii-char3.3 (call L.fun/ascii-char122159.5))
          (ascii-char4.2 (call L.fun/ascii-char122161.14))
          (void5.1 (call L.fun/void122163.4)))
      (call L.fun/error122165.9))))
(check-by-interp
 '(module
    (define L.fun/void122175.4 (lambda () (call L.fun/void122176.10)))
    (define L.fun/vector122173.5 (lambda () (call L.fun/vector122174.11)))
    (define L.fun/vector122171.6 (lambda () (call L.fun/vector122172.8)))
    (define L.fun/error122177.7 (lambda () (call L.fun/error122178.13)))
    (define L.fun/vector122172.8 (lambda () (call make-vector 8)))
    (define L.fun/vector122169.9 (lambda () (call L.fun/vector122170.12)))
    (define L.fun/void122176.10 (lambda () (void)))
    (define L.fun/vector122174.11 (lambda () (call make-vector 8)))
    (define L.fun/vector122170.12 (lambda () (call make-vector 8)))
    (define L.fun/error122178.13 (lambda () (error 4)))
    (let ((vector0.6 (call L.fun/vector122169.9))
          (vector1.5 (call L.fun/vector122171.6))
          (vector2.4 (call L.fun/vector122173.5))
          (void3.3 (call L.fun/void122175.4))
          (error4.2 (call L.fun/error122177.7))
          (fixnum5.1
           (call
            -
            (call
             *
             (call - (call * 85 165) (call * 13 12))
             (call * (call - 109 38) (call * 89 187)))
            (call
             *
             (call * (call - 60 6) (call + 243 81))
             (call + (call + 182 65) (call + 125 168))))))
      vector0.6)))
(check-by-interp
 '(module
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
            *
            (call
             +
             (call * (call + 205 2) (call + 173 15))
             (call + (call + 89 175) (call + 117 114)))
            (call
             +
             (call * (call * 168 119) (call - 81 33))
             (call + (call - 70 194) (call + 74 119))))))
      (call L.fun/void124215.9))))
(check-by-interp
 '(module
    (define L.fun/empty131526.4 (lambda () (call L.fun/empty131527.6)))
    (define L.fun/vector131525.5 (lambda () (call make-vector 8)))
    (define L.fun/empty131527.6 (lambda () empty))
    (define L.fun/error131520.7 (lambda () (call L.fun/error131521.12)))
    (define L.fun/ascii-char131523.8 (lambda () #\c))
    (define L.fun/vector131524.9 (lambda () (call L.fun/vector131525.5)))
    (define L.fun/ascii-char131522.10
      (lambda () (call L.fun/ascii-char131523.8)))
    (define L.fun/void131529.11 (lambda () (void)))
    (define L.fun/error131521.12 (lambda () (error 185)))
    (define L.fun/void131528.13 (lambda () (call L.fun/void131529.11)))
    (let ((error0.6 (call L.fun/error131520.7))
          (fixnum1.5
           (call
            +
            (call
             -
             (call + (call * 248 90) (call * 115 156))
             (call - (call * 22 149) (call * 136 29)))
            (call
             +
             (call + (call - 33 132) (call + 69 206))
             (call * (call * 198 13) (call * 119 204)))))
          (ascii-char2.4 (call L.fun/ascii-char131522.10))
          (vector3.3 (call L.fun/vector131524.9))
          (empty4.2 (call L.fun/empty131526.4))
          (void5.1 (call L.fun/void131528.13)))
      ascii-char2.4)))
(check-by-interp
 '(module
    (define L.fun/void140296.4 (lambda () (call L.fun/void140297.12)))
    (define L.fun/error140294.5 (lambda () (call L.fun/error140295.13)))
    (define L.fun/ascii-char140301.6 (lambda () #\c))
    (define L.fun/vector140299.7 (lambda () (call make-vector 8)))
    (define L.fun/vector140303.8 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char140300.9
      (lambda () (call L.fun/ascii-char140301.6)))
    (define L.fun/vector140298.10 (lambda () (call L.fun/vector140299.7)))
    (define L.fun/vector140302.11 (lambda () (call L.fun/vector140303.8)))
    (define L.fun/void140297.12 (lambda () (void)))
    (define L.fun/error140295.13 (lambda () (error 203)))
    (let ((error0.6 (call L.fun/error140294.5))
          (void1.5 (call L.fun/void140296.4))
          (vector2.4 (call L.fun/vector140298.10))
          (ascii-char3.3 (call L.fun/ascii-char140300.9))
          (vector4.2 (call L.fun/vector140302.11))
          (fixnum5.1
           (call
            +
            (call
             *
             (call - (call + 157 202) (call - 17 109))
             (call - (call - 132 37) (call - 193 247)))
            (call
             -
             (call * (call + 181 98) (call + 239 17))
             (call + (call + 217 119) (call * 135 76))))))
      ascii-char3.3)))
(check-by-interp
 '(module
    (define L.fun/vector147263.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char147266.5
      (lambda () (call L.fun/ascii-char147267.9)))
    (define L.fun/vector147264.6 (lambda () (call L.fun/vector147265.8)))
    (define L.fun/any147268.7 (lambda () empty))
    (define L.fun/vector147265.8 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char147267.9 (lambda () #\c))
    (define L.fun/vector147262.10 (lambda () (call L.fun/vector147263.4)))
    (define L.fun/any147269.11 (lambda () (error 134)))
    (let ((vector0.6 (call L.fun/vector147262.10))
          (vector1.5 (call L.fun/vector147264.6))
          (ascii-char2.4 (call L.fun/ascii-char147266.5))
          (fixnum3.3
           (call
            -
            (call
             +
             (call - (call - 24 133) (call + 84 60))
             (call * (call * 139 122) (call + 38 89)))
            (call
             *
             (call + (call - 214 195) (call * 26 54))
             (call - (call - 244 106) (call * 162 114)))))
          (fixnum4.2
           (call
            -
            (call
             +
             (call - (call - 148 235) (call + 11 96))
             (call - (call - 178 90) (call + 251 111)))
            (call
             *
             (call * (call * 99 37) (call + 70 50))
             (call * (call * 109 120) (call + 200 232)))))
          (boolean5.1 (call boolean? (call L.fun/any147268.7))))
      (call pair? (call L.fun/any147269.11)))))
(check-by-interp
 '(module
    (define L.fun/void147282.4 (lambda () (call L.fun/void147283.11)))
    (define L.fun/error147274.5 (lambda () (call L.fun/error147275.15)))
    (define L.fun/vector147276.6 (lambda () (call L.fun/vector147277.10)))
    (define L.fun/ascii-char147281.7 (lambda () #\c))
    (define L.fun/empty147279.8 (lambda () empty))
    (define L.fun/ascii-char147280.9
      (lambda () (call L.fun/ascii-char147281.7)))
    (define L.fun/vector147277.10 (lambda () (call make-vector 8)))
    (define L.fun/void147283.11 (lambda () (void)))
    (define L.fun/void147273.12 (lambda () (void)))
    (define L.fun/empty147278.13 (lambda () (call L.fun/empty147279.8)))
    (define L.fun/void147272.14 (lambda () (call L.fun/void147273.12)))
    (define L.fun/error147275.15 (lambda () (error 201)))
    (let ((void0.6 (call L.fun/void147272.14))
          (error1.5 (call L.fun/error147274.5))
          (vector2.4 (call L.fun/vector147276.6))
          (empty3.3 (call L.fun/empty147278.13))
          (ascii-char4.2 (call L.fun/ascii-char147280.9))
          (void5.1 (call L.fun/void147282.4)))
      void5.1)))
(check-by-interp
 '(module
    (define L.fun/empty148213.4 (lambda () empty))
    (define L.fun/error148211.5 (lambda () (error 77)))
    (define L.fun/error148208.6 (lambda () (call L.fun/error148209.13)))
    (define L.fun/vector148203.7 (lambda () (call L.fun/vector148204.9)))
    (define L.fun/empty148205.8 (lambda () (call L.fun/empty148206.12)))
    (define L.fun/vector148204.9 (lambda () (call make-vector 8)))
    (define L.fun/empty148212.10 (lambda () (call L.fun/empty148213.4)))
    (define L.fun/error148210.11 (lambda () (call L.fun/error148211.5)))
    (define L.fun/empty148206.12 (lambda () empty))
    (define L.fun/error148209.13 (lambda () (error 207)))
    (define L.fun/any148207.14 (lambda () #\c))
    (let ((vector0.6 (call L.fun/vector148203.7))
          (empty1.5 (call L.fun/empty148205.8))
          (boolean2.4 (call fixnum? (call L.fun/any148207.14)))
          (error3.3 (call L.fun/error148208.6))
          (error4.2 (call L.fun/error148210.11))
          (empty5.1 (call L.fun/empty148212.10)))
      vector0.6)))
(check-by-interp
 '(module
    (define L.fun/vector148219.4 (lambda () (call make-vector 8)))
    (define L.fun/empty148216.5 (lambda () (call L.fun/empty148217.6)))
    (define L.fun/empty148217.6 (lambda () empty))
    (define L.fun/vector148218.7 (lambda () (call L.fun/vector148219.4)))
    (define L.fun/error148223.8 (lambda () (error 15)))
    (define L.fun/vector148220.9 (lambda () (call L.fun/vector148221.10)))
    (define L.fun/vector148221.10 (lambda () (call make-vector 8)))
    (define L.fun/error148222.11 (lambda () (call L.fun/error148223.8)))
    (let ((empty0.6 (call L.fun/empty148216.5))
          (vector1.5 (call L.fun/vector148218.7))
          (fixnum2.4
           (call
            *
            (call
             +
             (call * (call - 230 254) (call * 246 111))
             (call - (call - 188 49) (call + 120 113)))
            (call
             *
             (call - (call * 95 157) (call * 44 29))
             (call - (call + 41 212) (call * 56 215)))))
          (fixnum3.3
           (call
            +
            (call
             +
             (call + (call * 50 133) (call * 58 122))
             (call - (call + 167 17) (call - 180 101)))
            (call
             *
             (call * (call + 65 250) (call * 216 213))
             (call * (call * 32 46) (call + 219 71)))))
          (vector4.2 (call L.fun/vector148220.9))
          (error5.1 (call L.fun/error148222.11)))
      (call
       -
       fixnum2.4
       (call
        -
        (call - (call * fixnum3.3 65) fixnum2.4)
        (call - (call - 199 236) fixnum2.4))))))
(check-by-interp
 '(module
    (define L.fun/any153346.4 (lambda () empty))
    (define L.fun/empty153339.5 (lambda () empty))
    (define L.fun/void153340.6 (lambda () (call L.fun/void153341.13)))
    (define L.fun/ascii-char153343.7 (lambda () #\c))
    (define L.fun/empty153338.8 (lambda () (call L.fun/empty153339.5)))
    (define L.fun/error153348.9 (lambda () (error 235)))
    (define L.fun/vector153344.10 (lambda () (call L.fun/vector153345.11)))
    (define L.fun/vector153345.11 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char153342.12
      (lambda () (call L.fun/ascii-char153343.7)))
    (define L.fun/void153341.13 (lambda () (void)))
    (define L.fun/error153347.14 (lambda () (call L.fun/error153348.9)))
    (let ((empty0.6 (call L.fun/empty153338.8))
          (void1.5 (call L.fun/void153340.6))
          (ascii-char2.4 (call L.fun/ascii-char153342.12))
          (vector3.3 (call L.fun/vector153344.10))
          (boolean4.2 (call boolean? (call L.fun/any153346.4)))
          (error5.1 (call L.fun/error153347.14)))
      void1.5)))
(check-by-interp
 '(module
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
          (boolean1.5 (call pair? (call L.fun/any156381.8)))
          (fixnum2.4
           (call
            +
            (call
             -
             (call - (call - 29 252) (call - 63 38))
             (call - (call - 46 144) (call - 219 53)))
            (call
             *
             (call - (call - 217 202) (call * 40 71))
             (call + (call + 24 153) (call - 247 252)))))
          (ascii-char3.3 (call L.fun/ascii-char156382.4))
          (ascii-char4.2 (call L.fun/ascii-char156384.10))
          (void5.1 (call L.fun/void156386.9)))
      (call
       -
       fixnum2.4
       (call * fixnum2.4 (call - (call + 114 243) (call + 237 fixnum2.4)))))))
(check-by-interp
 '(module
    (define L.fun/empty158617.4 (lambda () empty))
    (define L.fun/vector158612.5 (lambda () (call L.fun/vector158613.11)))
    (define L.fun/void158610.6 (lambda () (call L.fun/void158611.8)))
    (define L.fun/vector158608.7 (lambda () (call L.fun/vector158609.13)))
    (define L.fun/void158611.8 (lambda () (void)))
    (define L.fun/empty158616.9 (lambda () (call L.fun/empty158617.4)))
    (define L.fun/void158615.10 (lambda () (void)))
    (define L.fun/vector158613.11 (lambda () (call make-vector 8)))
    (define L.fun/void158614.12 (lambda () (call L.fun/void158615.10)))
    (define L.fun/vector158609.13 (lambda () (call make-vector 8)))
    (let ((vector0.6 (call L.fun/vector158608.7))
          (void1.5 (call L.fun/void158610.6))
          (fixnum2.4
           (call
            *
            (call
             +
             (call + (call - 84 72) (call * 78 88))
             (call + (call + 216 181) (call * 143 145)))
            (call
             -
             (call + (call + 87 138) (call + 74 113))
             (call * (call + 110 234) (call + 171 133)))))
          (vector3.3 (call L.fun/vector158612.5))
          (void4.2 (call L.fun/void158614.12))
          (empty5.1 (call L.fun/empty158616.9)))
      empty5.1)))
(check-by-interp
 '(module
    (define L.fun/empty160322.4 (lambda () (call L.fun/empty160323.11)))
    (define L.fun/vector160326.5 (lambda () (call L.fun/vector160327.13)))
    (define L.fun/error160329.6 (lambda () (error 200)))
    (define L.fun/vector160324.7 (lambda () (call L.fun/vector160325.9)))
    (define L.fun/vector160320.8 (lambda () (call L.fun/vector160321.10)))
    (define L.fun/vector160325.9 (lambda () (call make-vector 8)))
    (define L.fun/vector160321.10 (lambda () (call make-vector 8)))
    (define L.fun/empty160323.11 (lambda () empty))
    (define L.fun/error160328.12 (lambda () (call L.fun/error160329.6)))
    (define L.fun/vector160327.13 (lambda () (call make-vector 8)))
    (let ((vector0.6 (call L.fun/vector160320.8))
          (fixnum1.5
           (call
            *
            (call
             *
             (call + (call + 40 237) (call + 83 44))
             (call * (call - 211 118) (call + 15 251)))
            (call
             +
             (call + (call + 173 225) (call - 204 176))
             (call * (call + 114 125) (call * 104 156)))))
          (empty2.4 (call L.fun/empty160322.4))
          (vector3.3 (call L.fun/vector160324.7))
          (vector4.2 (call L.fun/vector160326.5))
          (error5.1 (call L.fun/error160328.12)))
      vector0.6)))
(check-by-interp
 '(module
    (define L.fun/vector163238.4 (lambda () (call L.fun/vector163239.6)))
    (define L.fun/vector163240.5 (lambda () (call L.fun/vector163241.11)))
    (define L.fun/vector163239.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char163243.7 (lambda () #\c))
    (define L.fun/vector163244.8 (lambda () (call L.fun/vector163245.9)))
    (define L.fun/vector163245.9 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char163242.10
      (lambda () (call L.fun/ascii-char163243.7)))
    (define L.fun/vector163241.11 (lambda () (call make-vector 8)))
    (let ((vector0.6 (call L.fun/vector163238.4))
          (fixnum1.5
           (call
            +
            (call
             -
             (call + (call + 242 149) (call + 80 185))
             (call - (call - 138 105) (call + 142 97)))
            (call
             *
             (call + (call + 160 155) (call + 249 161))
             (call + (call + 226 43) (call + 112 109)))))
          (vector2.4 (call L.fun/vector163240.5))
          (ascii-char3.3 (call L.fun/ascii-char163242.10))
          (vector4.2 (call L.fun/vector163244.8))
          (fixnum5.1
           (call
            *
            (call
             -
             (call - (call + 111 240) (call * 41 153))
             (call + (call - 251 130) (call - 152 52)))
            (call
             -
             (call - (call * 241 76) (call * 145 218))
             (call * (call - 215 87) (call * 215 209))))))
      (call
       *
       (call * (call * fixnum5.1 (call + 52 fixnum5.1)) fixnum5.1)
       (call * fixnum5.1 (call + (call * 151 83) fixnum1.5))))))
(check-by-interp
 '(module
    (define L.fun/empty163426.4 (lambda () empty))
    (define L.fun/void163423.5 (lambda () (call L.fun/void163424.11)))
    (define L.fun/vector163419.6 (lambda () (call L.fun/vector163420.12)))
    (define L.fun/void163428.7 (lambda () (void)))
    (define L.fun/empty163422.8 (lambda () empty))
    (define L.fun/vector163430.9 (lambda () (call make-vector 8)))
    (define L.fun/void163427.10 (lambda () (call L.fun/void163428.7)))
    (define L.fun/void163424.11 (lambda () (void)))
    (define L.fun/vector163420.12 (lambda () (call make-vector 8)))
    (define L.fun/vector163429.13 (lambda () (call L.fun/vector163430.9)))
    (define L.fun/empty163421.14 (lambda () (call L.fun/empty163422.8)))
    (define L.fun/empty163425.15 (lambda () (call L.fun/empty163426.4)))
    (let ((vector0.6 (call L.fun/vector163419.6))
          (empty1.5 (call L.fun/empty163421.14))
          (void2.4 (call L.fun/void163423.5))
          (empty3.3 (call L.fun/empty163425.15))
          (void4.2 (call L.fun/void163427.10))
          (vector5.1 (call L.fun/vector163429.13)))
      vector5.1)))
(check-by-interp
 '(module
    (define L.fun/error164708.4 (lambda () (error 129)))
    (define L.fun/vector164702.5 (lambda () (call L.fun/vector164703.11)))
    (define L.fun/empty164704.6 (lambda () (call L.fun/empty164705.13)))
    (define L.fun/any164711.7 (lambda () #\c))
    (define L.fun/vector164709.8 (lambda () (call L.fun/vector164710.10)))
    (define L.fun/error164707.9 (lambda () (call L.fun/error164708.4)))
    (define L.fun/vector164710.10 (lambda () (call make-vector 8)))
    (define L.fun/vector164703.11 (lambda () (call make-vector 8)))
    (define L.fun/any164706.12 (lambda () 126))
    (define L.fun/empty164705.13 (lambda () empty))
    (let ((vector0.6 (call L.fun/vector164702.5))
          (empty1.5 (call L.fun/empty164704.6))
          (boolean2.4 (call empty? (call L.fun/any164706.12)))
          (error3.3 (call L.fun/error164707.9))
          (vector4.2 (call L.fun/vector164709.8))
          (boolean5.1 (call empty? (call L.fun/any164711.7))))
      (call
       -
       (call
        +
        (call - (call - 8 23) (call - 170 204))
        (call + (call + 233 240) (call - 13 163)))
       (call
        +
        (call + (call - 104 239) (call - 66 123))
        (call * (call - 16 164) (call + 171 164)))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char165508.4
      (lambda () (call L.fun/ascii-char165509.11)))
    (define L.fun/ascii-char165506.5
      (lambda () (call L.fun/ascii-char165507.10)))
    (define L.fun/void165513.6 (lambda () (void)))
    (define L.fun/void165502.7 (lambda () (call L.fun/void165503.13)))
    (define L.fun/empty165504.8 (lambda () (call L.fun/empty165505.15)))
    (define L.fun/void165510.9 (lambda () (call L.fun/void165511.12)))
    (define L.fun/ascii-char165507.10 (lambda () #\c))
    (define L.fun/ascii-char165509.11 (lambda () #\c))
    (define L.fun/void165511.12 (lambda () (void)))
    (define L.fun/void165503.13 (lambda () (void)))
    (define L.fun/vector165515.14 (lambda () (call make-vector 8)))
    (define L.fun/empty165505.15 (lambda () empty))
    (define L.fun/void165512.16 (lambda () (call L.fun/void165513.6)))
    (define L.fun/vector165514.17 (lambda () (call L.fun/vector165515.14)))
    (let ((void0.6 (call L.fun/void165502.7))
          (empty1.5 (call L.fun/empty165504.8))
          (ascii-char2.4 (call L.fun/ascii-char165506.5))
          (ascii-char3.3 (call L.fun/ascii-char165508.4))
          (void4.2 (call L.fun/void165510.9))
          (void5.1 (call L.fun/void165512.16)))
      (call L.fun/vector165514.17))))
(check-by-interp
 '(module
    (define L.fun/vector171323.4 (lambda () (call L.fun/vector171324.5)))
    (define L.fun/vector171324.5 (lambda () (call make-vector 8)))
    (define L.fun/empty171322.6 (lambda () empty))
    (define L.fun/error171325.7 (lambda () (call L.fun/error171326.8)))
    (define L.fun/error171326.8 (lambda () (error 12)))
    (define L.fun/empty171321.9 (lambda () (call L.fun/empty171322.6)))
    (define L.fun/ascii-char171319.10
      (lambda () (call L.fun/ascii-char171320.11)))
    (define L.fun/ascii-char171320.11 (lambda () #\c))
    (let ((ascii-char0.6 (call L.fun/ascii-char171319.10))
          (empty1.5 (call L.fun/empty171321.9))
          (vector2.4 (call L.fun/vector171323.4))
          (fixnum3.3
           (call
            -
            (call
             +
             (call - (call * 197 162) (call - 143 254))
             (call + (call * 216 110) (call + 164 148)))
            (call
             *
             (call * (call * 65 137) (call * 171 35))
             (call - (call * 200 242) (call - 50 144)))))
          (error4.2 (call L.fun/error171325.7))
          (fixnum5.1
           (call
            *
            (call
             +
             (call + (call * 62 16) (call - 103 74))
             (call * (call * 118 123) (call - 87 152)))
            (call
             -
             (call - (call - 205 62) (call * 82 75))
             (call - (call - 166 172) (call - 180 172))))))
      empty1.5)))
(check-by-interp
 '(module
    (define L.fun/vector171578.4 (lambda () (call make-vector 8)))
    (define L.fun/void171571.5 (lambda () (call L.fun/void171572.9)))
    (define L.fun/empty171582.6 (lambda () empty))
    (define L.fun/void171575.7 (lambda () (call L.fun/void171576.15)))
    (define L.fun/empty171574.8 (lambda () empty))
    (define L.fun/void171572.9 (lambda () (void)))
    (define L.fun/ascii-char171579.10
      (lambda () (call L.fun/ascii-char171580.11)))
    (define L.fun/ascii-char171580.11 (lambda () #\c))
    (define L.fun/vector171577.12 (lambda () (call L.fun/vector171578.4)))
    (define L.fun/empty171581.13 (lambda () (call L.fun/empty171582.6)))
    (define L.fun/empty171573.14 (lambda () (call L.fun/empty171574.8)))
    (define L.fun/void171576.15 (lambda () (void)))
    (let ((void0.6 (call L.fun/void171571.5))
          (empty1.5 (call L.fun/empty171573.14))
          (void2.4 (call L.fun/void171575.7))
          (vector3.3 (call L.fun/vector171577.12))
          (ascii-char4.2 (call L.fun/ascii-char171579.10))
          (empty5.1 (call L.fun/empty171581.13)))
      vector3.3)))
(check-by-interp
 '(module
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
            -
            (call
             -
             (call + (call * 251 197) (call * 136 141))
             (call + (call - 246 6) (call * 74 78)))
            (call
             +
             (call - (call * 148 84) (call + 165 198))
             (call - (call + 221 113) (call * 116 13)))))
          (fixnum1.5
           (call
            -
            (call
             -
             (call * (call * 145 30) (call - 190 32))
             (call + (call + 120 30) (call + 78 91)))
            (call
             -
             (call + (call - 235 135) (call * 55 125))
             (call - (call - 117 76) (call - 71 123)))))
          (ascii-char2.4 (call L.fun/ascii-char171684.6))
          (empty3.3 (call L.fun/empty171686.4))
          (void4.2 (call L.fun/void171688.7))
          (void5.1 (call L.fun/void171690.11)))
      fixnum1.5)))
