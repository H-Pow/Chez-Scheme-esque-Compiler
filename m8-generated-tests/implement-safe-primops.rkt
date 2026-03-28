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
    (define L.fun/vector8392.4 (lambda (oprand0.1) (call make-vector 8)))
    (call L.fun/vector8392.4 (call + 186 30))))
(check-by-interp
 '(module
    (define L.fun/vector8395.4 (lambda (oprand0.1) (call make-vector 8)))
    (call L.fun/vector8395.4 (if #f (void) (void)))))
(check-by-interp
 '(module (let ((error0.2 (error 3)) (vector1.1 (call make-vector 8))) #\c)))
(check-by-interp
 '(module
    (define L.fun/fixnum8420.4 (lambda (oprand0.1) 50))
    (call - (call L.fun/fixnum8420.4 #\c) (call - 21 253))))
(check-by-interp '(module (if #t (error 240) (error 51))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8428.4 (lambda (oprand0.1) #\c))
    (define L.fun/empty8427.5 (lambda (oprand0.2) empty))
    (call L.fun/empty8427.5 (call L.fun/ascii-char8428.4 empty))))
(check-by-interp
 '(module
    (define L.fun/vector8431.4 (lambda (oprand0.1) (call make-vector 8)))
    (call
     L.fun/vector8431.4
     (let ((error0.3 (error 83)) (fixnum1.2 232)) empty))))
(check-by-interp
 '(module
    (define L.fun/vector8436.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char8434.5 (lambda () #\c))
    (define L.fun/ascii-char8435.6 (lambda () #\c))
    (let ((ascii-char0.3 (call L.fun/ascii-char8434.5))
          (ascii-char1.2 (call L.fun/ascii-char8435.6))
          (vector2.1 (call L.fun/vector8436.4)))
      vector2.1)))
(check-by-interp
 '(module
    (define L.fun/vector8439.4
      (lambda (oprand0.2 oprand1.1) (call make-vector 8)))
    (call
     L.fun/vector8439.4
     (if #t empty empty)
     (let ((fixnum0.5 115) (vector1.4 (call make-vector 8)) (empty2.3 empty))
       (error 158)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8442.4 (lambda (oprand0.2 oprand1.1) #\c))
    (if (if #t #t #t)
      (call L.fun/ascii-char8442.4 #\c empty)
      (let ((fixnum0.5 104) (fixnum1.4 76) (void2.3 (void))) #\c))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8460.4 (lambda (oprand0.2 oprand1.1) #\c))
    (call
     L.fun/ascii-char8460.4
     (if #t (call make-vector 8) (call make-vector 8))
     (if #f empty empty))))
(check-by-interp
 '(module
    (define L.fun/vector8489.4
      (lambda (oprand0.2 oprand1.1) (call make-vector 8)))
    (call
     L.fun/vector8489.4
     (if #t #f #f)
     (if #f (call make-vector 8) (call make-vector 8)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8498.4 (lambda () #\c))
    (define L.fun/void8499.5 (lambda () (void)))
    (define L.fun/empty8500.6 (lambda () empty))
    (let ((fixnum0.3 (call * 232 34))
          (ascii-char1.2 (call L.fun/ascii-char8498.4))
          (void2.1 (call L.fun/void8499.5)))
      (call L.fun/empty8500.6))))
(check-by-interp
 '(module
    (define L.fun/void8519.4 (lambda () (void)))
    (define L.fun/empty8521.5 (lambda () empty))
    (define L.fun/void8518.6 (lambda () (void)))
    (define L.fun/vector8520.7 (lambda () (call make-vector 8)))
    (let ((void0.3 (call L.fun/void8518.6))
          (void1.2 (call L.fun/void8519.4))
          (vector2.1 (call L.fun/vector8520.7)))
      (call L.fun/empty8521.5))))
(check-by-interp
 '(module
    (if (if #f #t #t)
      (let ((void0.3 (void))
            (vector1.2 (call make-vector 8))
            (ascii-char2.1 #\c))
        #t)
      (if #t #t #t))))
(check-by-interp
 '(module
    (define L.fun/empty8540.4 (lambda (oprand0.2 oprand1.1) empty))
    (if (call empty? 158)
      (call L.fun/empty8540.4 #\c (call make-vector 8))
      (if #t empty empty))))
(check-by-interp
 '(module
    (define L.fun/error8549.4 (lambda () (error 10)))
    (define L.fun/ascii-char8548.5 (lambda () #\c))
    (define L.fun/vector8550.6 (lambda () (call make-vector 8)))
    (let ((ascii-char0.3 (call L.fun/ascii-char8548.5))
          (error1.2 (call L.fun/error8549.4))
          (fixnum2.1 (call + 100 64)))
      (call L.fun/vector8550.6))))
(check-by-interp
 '(module
    (define L.fun/empty8553.4 (lambda () empty))
    (define L.fun/error8554.5 (lambda () (error 169)))
    (let ((empty0.3 (call L.fun/empty8553.4))
          (error1.2 (call L.fun/error8554.5))
          (fixnum2.1 (call - 221 18)))
      error1.2)))
(check-by-interp
 '(module
    (define L.fun/void8581.4 (lambda () (void)))
    (define L.fun/empty8582.5 (lambda () empty))
    (define L.fun/vector8580.6 (lambda () (call make-vector 8)))
    (let ((vector0.3 (call L.fun/vector8580.6))
          (void1.2 (call L.fun/void8581.4))
          (empty2.1 (call L.fun/empty8582.5)))
      empty2.1)))
(check-by-interp
 '(module
    (define L.fun/error8585.4 (lambda (oprand0.2 oprand1.1) (error 160)))
    (call
     L.fun/error8585.4
     (if #f (call make-vector 8) (call make-vector 8))
     (let ((fixnum0.5 168) (void1.4 (void)) (boolean2.3 #t)) void1.4))))
(check-by-interp
 '(module
    (define L.fun/vector8594.4 (lambda (oprand0.2 oprand1.1) oprand1.1))
    (call
     L.fun/vector8594.4
     (let ((fixnum0.5 5) (fixnum1.4 225) (empty2.3 empty)) fixnum0.5)
     (call
      L.fun/vector8594.4
      (call - 32 206)
      (if #t (call make-vector 8) (call make-vector 8))))))
(check-by-interp
 '(module
    (define L.fun/boolean8597.4 (lambda (oprand0.2 oprand1.1) #f))
    (define L.fun/ascii-char8598.5 (lambda (oprand0.4 oprand1.3) #\c))
    (if (call L.fun/boolean8597.4 empty #\c)
      (if #f #\c #\c)
      (call L.fun/ascii-char8598.5 78 empty))))
(check-by-interp
 '(module
    (define L.fun/error8603.4 (lambda () (error 248)))
    (define L.fun/vector8602.5 (lambda () (call make-vector 8)))
    (define L.fun/empty8601.6 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty8601.6))
          (vector1.3 (call L.fun/vector8602.5))
          (error2.2 (call L.fun/error8603.4))
          (fixnum3.1 (call * (call + 66 225) (call - 154 20))))
      empty0.4)))
(check-by-interp
 '(module
    (define L.fun/ascii-char8617.4 (lambda () #\c))
    (define L.fun/ascii-char8618.5 (lambda () #\c))
    (define L.fun/error8620.6 (lambda () (error 122)))
    (define L.fun/vector8616.7 (lambda () (call make-vector 8)))
    (define L.fun/vector8619.8 (lambda () (call make-vector 8)))
    (let ((vector0.4 (call L.fun/vector8616.7))
          (ascii-char1.3 (call L.fun/ascii-char8617.4))
          (ascii-char2.2 (call L.fun/ascii-char8618.5))
          (vector3.1 (call L.fun/vector8619.8)))
      (call L.fun/error8620.6))))
(check-by-interp
 '(module
    (define L.fun/vector8794.4 (lambda () (call make-vector 8)))
    (define L.fun/void8793.5 (lambda () (void)))
    (define L.fun/any8795.6 (lambda () (void)))
    (define L.fun/empty8792.7 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty8792.7))
          (void1.3 (call L.fun/void8793.5))
          (vector2.2 (call L.fun/vector8794.4))
          (boolean3.1 (call void? (call L.fun/any8795.6))))
      empty0.4)))
(check-by-interp
 '(module
    (define L.fun/ascii-char8857.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) oprand0.3))
    (define L.fun/ascii-char8858.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) oprand1.5))
    (if (if #t #t #t)
      (call
       L.fun/ascii-char8857.4
       (call L.fun/ascii-char8858.5 (call make-vector 8) #\c (void))
       (if #f #\c #\c)
       (let ((empty0.10 empty)
             (void1.9 (void))
             (error2.8 (error 101))
             (error3.7 (error 93)))
         167))
      (let ((ascii-char0.14 #\c)
            (vector1.13 (call make-vector 8))
            (boolean2.12 #f)
            (error3.11 (error 218)))
        #\c))))
(check-by-interp
 '(module
    (define L.fun/any8922.4 (lambda (oprand0.3 oprand1.2 oprand2.1) 170))
    (define L.fun/error8924.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) (error 202)))
    (define L.fun/empty8923.6 (lambda (oprand0.9 oprand1.8 oprand2.7) empty))
    (define L.fun/empty8925.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) empty))
    (if (call
         vector?
         (call L.fun/any8922.4 (error 187) (error 144) (error 55)))
      (let ((error0.16 (error 93))
            (ascii-char1.15 #\c)
            (void2.14 (void))
            (boolean3.13 #f))
        empty)
      (call
       L.fun/empty8923.6
       (if #f 234 114)
       (call L.fun/error8924.5 empty (void) #f)
       (call L.fun/empty8925.7 239 (call make-vector 8) (void))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char8995.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) #\c))
    (if (call ascii-char? (if #t (call make-vector 8) (void)))
      (call
       L.fun/ascii-char8995.4
       (if #t #\c #\c)
       (let ((error0.7 (error 152))
             (fixnum1.6 146)
             (vector2.5 (call make-vector 8))
             (void3.4 (void)))
         77)
       (call pair? #\c))
      (if #f #\c #\c))))
(check-by-interp
 '(module
    (define L.fun/empty9097.4 (lambda () empty))
    (define L.fun/error9096.5 (lambda () (error 229)))
    (define L.fun/any9094.6 (lambda () (call make-vector 8)))
    (define L.fun/void9095.7 (lambda () (void)))
    (let ((fixnum0.4 (call - (call + 135 91) (call - 139 228)))
          (boolean1.3 (call ascii-char? (call L.fun/any9094.6)))
          (void2.2 (call L.fun/void9095.7))
          (error3.1 (call L.fun/error9096.5)))
      (call L.fun/empty9097.4))))
(check-by-interp
 '(module
    (define L.fun/error9196.4 (lambda () (error 145)))
    (define L.fun/empty9197.5 (lambda () empty))
    (define L.fun/vector9198.6 (lambda () (call make-vector 8)))
    (define L.fun/empty9195.7 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty9195.7))
          (error1.3 (call L.fun/error9196.4))
          (fixnum2.2 (call - (call + 220 180) (call + 230 28)))
          (empty3.1 (call L.fun/empty9197.5)))
      (call L.fun/vector9198.6))))
(check-by-interp
 '(module
    (define L.fun/fixnum9203.4 (lambda (oprand0.3 oprand1.2 oprand2.1) 171))
    (define L.fun/fixnum9202.5 (lambda (oprand0.6 oprand1.5 oprand2.4) 71))
    (define L.fun/fixnum9204.6
      (lambda (oprand0.9 oprand1.8 oprand2.7) oprand2.7))
    (define L.fun/boolean9201.7 (lambda (oprand0.12 oprand1.11 oprand2.10) #t))
    (call
     +
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
    (if (let ((boolean0.4 #f)
              (ascii-char1.3 #\c)
              (empty2.2 empty)
              (empty3.1 empty))
          #f)
      (let ((void0.8 (void))
            (vector1.7 (call make-vector 8))
            (boolean2.6 #t)
            (boolean3.5 #f))
        (error 26))
      (if #t (error 181) (error 214)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char9328.4 (lambda () #\c))
    (define L.fun/void9330.5 (lambda () (void)))
    (define L.fun/error9331.6 (lambda () (error 106)))
    (define L.fun/ascii-char9329.7 (lambda () #\c))
    (let ((fixnum0.4 (call - (call * 55 225) (call + 52 28)))
          (ascii-char1.3 (call L.fun/ascii-char9328.4))
          (ascii-char2.2 (call L.fun/ascii-char9329.7))
          (void3.1 (call L.fun/void9330.5)))
      (call L.fun/error9331.6))))
(check-by-interp
 '(module
    (define L.fun/ascii-char9350.4 (lambda () #\c))
    (define L.fun/error9349.5 (lambda () (error 136)))
    (let ((fixnum0.4 (call - (call - 150 201) (call - 95 117)))
          (fixnum1.3 (call - (call * 128 107) (call * 89 97)))
          (error2.2 (call L.fun/error9349.5))
          (fixnum3.1 (call * (call - 133 4) (call - 136 150))))
      (call L.fun/ascii-char9350.4))))
(check-by-interp
 '(module
    (define L.fun/any9400.4 (lambda () (void)))
    (define L.fun/error9399.5 (lambda () (error 95)))
    (define L.fun/ascii-char9401.6 (lambda () #\c))
    (define L.fun/vector9402.7 (lambda () (call make-vector 8)))
    (let ((error0.4 (call L.fun/error9399.5))
          (boolean1.3 (call void? (call L.fun/any9400.4)))
          (fixnum2.2 (call * (call + 2 163) (call - 227 100)))
          (ascii-char3.1 (call L.fun/ascii-char9401.6)))
      (call L.fun/vector9402.7))))
(check-by-interp
 '(module
    (define L.fun/empty9463.4 (lambda () empty))
    (define L.fun/empty9462.5 (lambda () empty))
    (define L.fun/void9461.6 (lambda () (void)))
    (let ((void0.4 (call L.fun/void9461.6))
          (fixnum1.3 (call - (call + 183 180) (call * 238 118)))
          (empty2.2 (call L.fun/empty9462.5))
          (empty3.1 (call L.fun/empty9463.4)))
      void0.4)))
(check-by-interp
 '(module
    (define L.fun/empty9493.4 (lambda () empty))
    (define L.fun/vector9494.5 (lambda () (call make-vector 8)))
    (define L.fun/error9491.6 (lambda () (error 154)))
    (define L.fun/error9492.7 (lambda () (error 158)))
    (let ((error0.4 (call L.fun/error9491.6))
          (error1.3 (call L.fun/error9492.7))
          (empty2.2 (call L.fun/empty9493.4))
          (vector3.1 (call L.fun/vector9494.5)))
      (call * (call * 24 10) (call - 185 187)))))
(check-by-interp
 '(module
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
       (call - 161 4)
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
    (if (call empty? (if #t #\c 105))
      (let ((fixnum0.4 149) (fixnum1.3 116) (boolean2.2 #f) (boolean3.1 #t))
        (call make-vector 8))
      (let ((error0.8 (error 207))
            (ascii-char1.7 #\c)
            (error2.6 (error 125))
            (vector3.5 (call make-vector 8)))
        vector3.5))))
(check-by-interp
 '(module
    (define L.fun/error9595.4 (lambda () (error 35)))
    (define L.fun/void9594.5 (lambda () (void)))
    (define L.fun/empty9593.6 (lambda () empty))
    (let ((empty0.4 (call L.fun/empty9593.6))
          (void1.3 (call L.fun/void9594.5))
          (error2.2 (call L.fun/error9595.4))
          (fixnum3.1 (call * (call - 171 174) (call * 161 50))))
      void1.3)))
(check-by-interp
 '(module
    (define L.fun/error9648.4 (lambda () (error 10)))
    (define L.fun/error9646.5 (lambda () (error 228)))
    (define L.fun/any9647.6 (lambda () #f))
    (define L.fun/error9649.7 (lambda () (error 110)))
    (define L.fun/void9650.8 (lambda () (void)))
    (let ((error0.4 (call L.fun/error9646.5))
          (boolean1.3 (call void? (call L.fun/any9647.6)))
          (error2.2 (call L.fun/error9648.4))
          (error3.1 (call L.fun/error9649.7)))
      (call L.fun/void9650.8))))
(check-by-interp
 '(module
    (define L.fun/error9674.4 (lambda () (error 5)))
    (define L.fun/any9670.5 (lambda () empty))
    (define L.fun/void9671.6 (lambda () (void)))
    (define L.fun/vector9672.7 (lambda () (call make-vector 8)))
    (define L.fun/empty9673.8 (lambda () empty))
    (let ((boolean0.4 (call empty? (call L.fun/any9670.5)))
          (void1.3 (call L.fun/void9671.6))
          (vector2.2 (call L.fun/vector9672.7))
          (empty3.1 (call L.fun/empty9673.8)))
      (call L.fun/error9674.4))))
(check-by-interp
 '(module
    (define L.fun/void9689.4 (lambda () (void)))
    (define L.fun/vector9690.5 (lambda () (call make-vector 8)))
    (define L.fun/vector9691.6 (lambda () (call make-vector 8)))
    (define L.fun/error9692.7 (lambda () (error 60)))
    (let ((void0.4 (call L.fun/void9689.4))
          (vector1.3 (call L.fun/vector9690.5))
          (vector2.2 (call L.fun/vector9691.6))
          (error3.1 (call L.fun/error9692.7)))
      (call + (call + 39 206) (call * 133 61)))))
(check-by-interp
 '(module
    (define L.fun/empty9739.4 (lambda (oprand0.3 oprand1.2 oprand2.1) empty))
    (define L.fun/ascii-char9738.5
      (lambda (oprand0.6 oprand1.5 oprand2.4) #\c))
    (define L.fun/void9736.6 (lambda (oprand0.9 oprand1.8 oprand2.7) (void)))
    (define L.fun/error9737.7
      (lambda (oprand0.12 oprand1.11 oprand2.10) (error 137)))
    (if (if #t #f #f)
      (if #f (void) (void))
      (call
       L.fun/void9736.6
       (call L.fun/error9737.7 #f #\c 247)
       (call L.fun/ascii-char9738.5 45 (error 199) (call make-vector 8))
       (call L.fun/empty9739.4 #f 178 #\c)))))
(check-by-interp
 '(module
    (define L.fun/any9842.4
      (lambda (oprand0.3 oprand1.2 oprand2.1) (call make-vector 8)))
    (if (call void? (call L.fun/any9842.4 214 (void) 160))
      (if #t (error 253) (error 171))
      (let ((boolean0.7 #f) (void1.6 (void)) (fixnum2.5 97) (empty3.4 empty))
        (error 93)))))
(check-by-interp
 '(module
    (define L.fun/void9900.4 (lambda () (void)))
    (define L.fun/void9899.5 (lambda () (void)))
    (define L.fun/fixnum9902.6
      (lambda (oprand0.3 oprand1.2 oprand2.1) (call * 102 183)))
    (define L.fun/empty9901.7 (lambda () empty))
    (define L.fun/ascii-char9904.8
      (lambda (oprand0.6 oprand1.5 oprand2.4) oprand0.6))
    (define L.fun/ascii-char9903.9
      (lambda (oprand0.9 oprand1.8 oprand2.7) #\c))
    (call
     +
     (let ((fixnum0.13 (call + 84 131))
           (void1.12 (call L.fun/void9899.5))
           (void2.11 (call L.fun/void9900.4))
           (empty3.10 (call L.fun/empty9901.7)))
       (call + fixnum0.13 25))
     (call
      L.fun/fixnum9902.6
      (call
       L.fun/ascii-char9903.9
       (call L.fun/ascii-char9904.8 #\c #f 179)
       (let ((empty0.17 empty)
             (fixnum1.16 26)
             (void2.15 (void))
             (empty3.14 empty))
         fixnum1.16)
       (if #t #f #f))
      (let ((empty0.21 empty)
            (fixnum1.20 25)
            (vector2.19 (call make-vector 8))
            (error3.18 (error 9)))
        vector2.19)
      (if #t empty empty)))))
(check-by-interp
 '(module
    (define L.fun/empty10029.4 (lambda () empty))
    (define L.fun/void10030.5 (lambda () (void)))
    (define L.fun/ascii-char10031.6 (lambda () #\c))
    (define L.fun/vector10028.7 (lambda () (call make-vector 8)))
    (define L.fun/error10032.8 (lambda () (error 197)))
    (let ((vector0.5 (call L.fun/vector10028.7))
          (empty1.4 (call L.fun/empty10029.4))
          (void2.3 (call L.fun/void10030.5))
          (fixnum3.2
           (call
            -
            (call - (call * 130 201) (call - 23 50))
            (call * (call - 89 229) (call + 222 95))))
          (ascii-char4.1 (call L.fun/ascii-char10031.6)))
      (call L.fun/error10032.8))))
(check-by-interp
 '(module
    (define L.fun/error10696.4 (lambda () (error 215)))
    (define L.fun/ascii-char10693.5 (lambda () #\c))
    (define L.fun/void10697.6 (lambda () (void)))
    (define L.fun/any10694.7 (lambda () empty))
    (define L.fun/void10695.8 (lambda () (void)))
    (let ((ascii-char0.5 (call L.fun/ascii-char10693.5))
          (boolean1.4 (call ascii-char? (call L.fun/any10694.7)))
          (void2.3 (call L.fun/void10695.8))
          (error3.2 (call L.fun/error10696.4))
          (void4.1 (call L.fun/void10697.6)))
      void4.1)))
(check-by-interp
 '(module
    (define L.fun/vector10982.4 (lambda () (call make-vector 8)))
    (define L.fun/error10981.5 (lambda () (error 69)))
    (define L.fun/vector10978.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char10980.7 (lambda () #\c))
    (define L.fun/empty10979.8 (lambda () empty))
    (let ((vector0.5 (call L.fun/vector10978.6))
          (empty1.4 (call L.fun/empty10979.8))
          (ascii-char2.3 (call L.fun/ascii-char10980.7))
          (error3.2 (call L.fun/error10981.5))
          (vector4.1 (call L.fun/vector10982.4)))
      error3.2)))
(check-by-interp
 '(module
    (define L.fun/any11523.4 (lambda () (error 153)))
    (define L.fun/vector11521.5 (lambda () (call make-vector 8)))
    (define L.fun/vector11520.6 (lambda () (call make-vector 8)))
    (define L.fun/void11524.7 (lambda () (void)))
    (define L.fun/any11522.8 (lambda () (call make-vector 8)))
    (let ((vector0.5 (call L.fun/vector11520.6))
          (vector1.4 (call L.fun/vector11521.5))
          (boolean2.3 (call error? (call L.fun/any11522.8)))
          (boolean3.2 (call boolean? (call L.fun/any11523.4)))
          (void4.1 (call L.fun/void11524.7)))
      void4.1)))
(check-by-interp
 '(module
    (define L.fun/any11781.4 (lambda () (call make-vector 8)))
    (define L.fun/empty11787.5 (lambda () empty))
    (define L.fun/any11786.6 (lambda () (error 119)))
    (define L.fun/ascii-char11784.7 (lambda () #\c))
    (define L.fun/ascii-char11782.8 (lambda () #\c))
    (define L.fun/error11785.9 (lambda () (error 140)))
    (define L.fun/empty11780.10 (lambda () empty))
    (define L.fun/void11783.11 (lambda () (void)))
    (call
     *
     (let ((empty0.5 (call L.fun/empty11780.10))
           (fixnum1.4 (call + (call + 28 7) (call + 44 46)))
           (fixnum2.3 (call + (call + 133 130) (call - 171 132)))
           (boolean3.2 (call void? (call L.fun/any11781.4)))
           (ascii-char4.1 (call L.fun/ascii-char11782.8)))
       (call + (call - 136 187) (call + fixnum1.4 45)))
     (let ((void0.10 (call L.fun/void11783.11))
           (ascii-char1.9 (call L.fun/ascii-char11784.7))
           (error2.8 (call L.fun/error11785.9))
           (boolean3.7 (call pair? (call L.fun/any11786.6)))
           (empty4.6 (call L.fun/empty11787.5)))
       (call - (call - 240 199) (call - 154 192))))))
(check-by-interp
 '(module
    (define L.fun/vector11791.4 (lambda () (call make-vector 8)))
    (define L.fun/any11794.5 (lambda () #\c))
    (define L.fun/ascii-char11795.6 (lambda () #\c))
    (define L.fun/empty11790.7 (lambda () empty))
    (define L.fun/vector11793.8 (lambda () (call make-vector 8)))
    (define L.fun/vector11792.9 (lambda () (call make-vector 8)))
    (let ((empty0.5 (call L.fun/empty11790.7))
          (vector1.4 (call L.fun/vector11791.4))
          (vector2.3 (call L.fun/vector11792.9))
          (vector3.2 (call L.fun/vector11793.8))
          (boolean4.1 (call boolean? (call L.fun/any11794.5))))
      (call L.fun/ascii-char11795.6))))
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
    (define L.fun/void12536.4 (lambda () (void)))
    (define L.fun/any12537.5 (lambda () empty))
    (define L.fun/error12539.6 (lambda () (error 115)))
    (define L.fun/error12538.7 (lambda () (error 97)))
    (let ((void0.5 (call L.fun/void12536.4))
          (boolean1.4 (call empty? (call L.fun/any12537.5)))
          (fixnum2.3
           (call
            -
            (call + (call * 98 48) (call + 13 114))
            (call - (call - 222 161) (call * 99 95))))
          (error3.2 (call L.fun/error12538.7))
          (error4.1 (call L.fun/error12539.6)))
      error4.1)))
(check-by-interp
 '(module
    (define L.fun/any13289.4 (lambda () #f))
    (define L.fun/empty13290.5 (lambda () empty))
    (define L.fun/error13288.6 (lambda () (error 191)))
    (define L.fun/ascii-char13291.7 (lambda () #\c))
    (let ((fixnum0.5
           (call
            +
            (call - (call * 170 197) (call - 236 37))
            (call - (call - 235 226) (call * 251 88))))
          (error1.4 (call L.fun/error13288.6))
          (fixnum2.3
           (call
            -
            (call - (call - 186 149) (call - 145 185))
            (call * (call * 3 155) (call + 226 219))))
          (boolean3.2 (call pair? (call L.fun/any13289.4)))
          (empty4.1 (call L.fun/empty13290.5)))
      (call L.fun/ascii-char13291.7))))
(check-by-interp
 '(module
    (define L.fun/ascii-char13294.4 (lambda () #\c))
    (define L.fun/any13295.5 (lambda () #f))
    (define L.fun/error13297.6 (lambda () (error 183)))
    (define L.fun/ascii-char13296.7 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char13294.4))
          (fixnum1.4
           (call
            +
            (call - (call - 34 115) (call * 164 191))
            (call + (call + 116 76) (call - 28 161))))
          (boolean2.3 (call fixnum? (call L.fun/any13295.5)))
          (ascii-char3.2 (call L.fun/ascii-char13296.7))
          (error4.1 (call L.fun/error13297.6)))
      ascii-char0.5)))
(check-by-interp
 '(module
    (define L.fun/void13818.4 (lambda () (void)))
    (define L.fun/vector13820.5 (lambda () (call make-vector 8)))
    (define L.fun/empty13817.6 (lambda () empty))
    (define L.fun/error13821.7 (lambda () (error 147)))
    (define L.fun/vector13819.8 (lambda () (call make-vector 8)))
    (let ((fixnum0.5
           (call
            +
            (call - (call * 133 168) (call + 18 172))
            (call * (call + 1 63) (call - 108 115))))
          (empty1.4 (call L.fun/empty13817.6))
          (void2.3 (call L.fun/void13818.4))
          (vector3.2 (call L.fun/vector13819.8))
          (vector4.1 (call L.fun/vector13820.5)))
      (call L.fun/error13821.7))))
(check-by-interp
 '(module
    (define L.fun/vector13874.4 (lambda () (call make-vector 8)))
    (define L.fun/void13876.5 (lambda () (void)))
    (define L.fun/ascii-char13875.6 (lambda () #\c))
    (let ((vector0.5 (call L.fun/vector13874.4))
          (ascii-char1.4 (call L.fun/ascii-char13875.6))
          (fixnum2.3
           (call
            -
            (call + (call - 133 204) (call - 198 76))
            (call - (call - 121 198) (call - 15 62))))
          (fixnum3.2
           (call
            +
            (call + (call - 146 6) (call + 195 45))
            (call - (call * 202 238) (call - 205 166))))
          (void4.1 (call L.fun/void13876.5)))
      (call
       -
       (call * (call - 68 78) fixnum2.3)
       (call + fixnum2.3 (call * 150 14))))))
(check-by-interp
 '(module
    (define L.fun/empty13902.4 (lambda () empty))
    (define L.fun/vector13904.5 (lambda () (call make-vector 8)))
    (define L.fun/void13905.6 (lambda () (void)))
    (define L.fun/error13903.7 (lambda () (error 66)))
    (let ((empty0.5 (call L.fun/empty13902.4))
          (error1.4 (call L.fun/error13903.7))
          (vector2.3 (call L.fun/vector13904.5))
          (fixnum3.2
           (call
            +
            (call - (call - 179 164) (call * 82 68))
            (call * (call - 252 27) (call + 140 60))))
          (void4.1 (call L.fun/void13905.6)))
      empty0.5)))
(check-by-interp
 '(module
    (define L.fun/ascii-char13919.4 (lambda () #\c))
    (define L.fun/error13917.5 (lambda () (error 136)))
    (define L.fun/any13918.6 (lambda () #t))
    (define L.fun/void13916.7 (lambda () (void)))
    (define L.fun/ascii-char13915.8 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char13915.8))
          (void1.4 (call L.fun/void13916.7))
          (error2.3 (call L.fun/error13917.5))
          (boolean3.2 (call ascii-char? (call L.fun/any13918.6)))
          (ascii-char4.1 (call L.fun/ascii-char13919.4)))
      void1.4)))
(check-by-interp
 '(module
    (define L.fun/empty14259.4 (lambda () empty))
    (define L.fun/ascii-char14257.5 (lambda () #\c))
    (define L.fun/error14258.6 (lambda () (error 83)))
    (let ((ascii-char0.5 (call L.fun/ascii-char14257.5))
          (fixnum1.4
           (call
            *
            (call - (call * 206 222) (call * 226 166))
            (call - (call - 182 234) (call + 54 78))))
          (error2.3 (call L.fun/error14258.6))
          (empty3.2 (call L.fun/empty14259.4))
          (fixnum4.1
           (call
            -
            (call - (call + 181 68) (call + 63 242))
            (call + (call * 104 78) (call * 102 32)))))
      empty3.2)))
(check-by-interp
 '(module
    (define L.fun/vector14564.4 (lambda () (call make-vector 8)))
    (define L.fun/error14567.5 (lambda () (error 17)))
    (define L.fun/empty14565.6 (lambda () empty))
    (define L.fun/error14566.7 (lambda () (error 233)))
    (define L.fun/ascii-char14563.8 (lambda () #\c))
    (let ((ascii-char0.5 (call L.fun/ascii-char14563.8))
          (vector1.4 (call L.fun/vector14564.4))
          (empty2.3 (call L.fun/empty14565.6))
          (error3.2 (call L.fun/error14566.7))
          (error4.1 (call L.fun/error14567.5)))
      vector1.4)))
(check-by-interp
 '(module
    (define L.fun/void15185.4 (lambda () (void)))
    (define L.fun/void15186.5 (lambda () (void)))
    (define L.fun/vector15187.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char15189.7 (lambda () #\c))
    (define L.fun/ascii-char15188.8 (lambda () #\c))
    (let ((void0.5 (call L.fun/void15185.4))
          (void1.4 (call L.fun/void15186.5))
          (vector2.3 (call L.fun/vector15187.6))
          (ascii-char3.2 (call L.fun/ascii-char15188.8))
          (ascii-char4.1 (call L.fun/ascii-char15189.7)))
      void1.4)))
(check-by-interp
 '(module
    (define L.fun/error15445.4 (lambda () (error 139)))
    (define L.fun/ascii-char15442.5 (lambda () #\c))
    (define L.fun/empty15443.6 (lambda () empty))
    (define L.fun/vector15444.7 (lambda () (call make-vector 8)))
    (let ((fixnum0.5
           (call
            -
            (call * (call - 230 208) (call * 23 35))
            (call * (call - 28 8) (call + 0 101))))
          (ascii-char1.4 (call L.fun/ascii-char15442.5))
          (empty2.3 (call L.fun/empty15443.6))
          (vector3.2 (call L.fun/vector15444.7))
          (error4.1 (call L.fun/error15445.4)))
      ascii-char1.4)))
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
    (define L.fun/error15698.4 (lambda () (error 232)))
    (define L.fun/vector15697.5 (lambda () (call make-vector 8)))
    (define L.fun/empty15699.6 (lambda () empty))
    (define L.fun/ascii-char15700.7 (lambda () #\c))
    (define L.fun/ascii-char15701.8 (lambda () #\c))
    (let ((vector0.5 (call L.fun/vector15697.5))
          (error1.4 (call L.fun/error15698.4))
          (empty2.3 (call L.fun/empty15699.6))
          (ascii-char3.2 (call L.fun/ascii-char15700.7))
          (ascii-char4.1 (call L.fun/ascii-char15701.8)))
      empty2.3)))
(check-by-interp
 '(module
    (define L.fun/ascii-char15704.4 (lambda () #\c))
    (define L.fun/void15705.5 (lambda () (void)))
    (define L.fun/ascii-char15707.6 (lambda () #\c))
    (define L.fun/error15708.7 (lambda () (error 141)))
    (define L.fun/empty15706.8 (lambda () empty))
    (let ((ascii-char0.5 (call L.fun/ascii-char15704.4))
          (void1.4 (call L.fun/void15705.5))
          (fixnum2.3
           (call
            *
            (call * (call * 149 53) (call - 200 171))
            (call * (call + 242 67) (call * 14 213))))
          (empty3.2 (call L.fun/empty15706.8))
          (ascii-char4.1 (call L.fun/ascii-char15707.6)))
      (call L.fun/error15708.7))))
(check-by-interp
 '(module
    (define L.fun/void15911.4 (lambda () (void)))
    (define L.fun/any15910.5 (lambda () #\c))
    (define L.fun/any15908.6 (lambda () #\c))
    (define L.fun/ascii-char15909.7 (lambda () #\c))
    (let ((fixnum0.5
           (call
            *
            (call + (call + 201 19) (call + 133 32))
            (call - (call - 254 127) (call - 68 187))))
          (boolean1.4 (call ascii-char? (call L.fun/any15908.6)))
          (ascii-char2.3 (call L.fun/ascii-char15909.7))
          (boolean3.2 (call empty? (call L.fun/any15910.5)))
          (void4.1 (call L.fun/void15911.4)))
      void4.1)))
(check-by-interp
 '(module
    (define L.fun/void15914.4 (lambda () (void)))
    (define L.fun/vector15915.5 (lambda () (call make-vector 8)))
    (define L.fun/empty15916.6 (lambda () empty))
    (define L.fun/empty15918.7 (lambda () empty))
    (define L.fun/vector15917.8 (lambda () (call make-vector 8)))
    (let ((void0.5 (call L.fun/void15914.4))
          (vector1.4 (call L.fun/vector15915.5))
          (empty2.3 (call L.fun/empty15916.6))
          (vector3.2 (call L.fun/vector15917.8))
          (empty4.1 (call L.fun/empty15918.7)))
      empty2.3)))
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
    (define L.fun/vector16263.4 (lambda () (call make-vector 8)))
    (define L.fun/empty16266.5 (lambda () empty))
    (define L.fun/any16262.6 (lambda () (void)))
    (define L.fun/void16265.7 (lambda () (void)))
    (define L.fun/error16264.8 (lambda () (error 76)))
    (let ((boolean0.5 (call vector? (call L.fun/any16262.6)))
          (vector1.4 (call L.fun/vector16263.4))
          (fixnum2.3
           (call
            -
            (call + (call - 23 62) (call - 137 178))
            (call + (call * 168 80) (call + 82 118))))
          (error3.2 (call L.fun/error16264.8))
          (void4.1 (call L.fun/void16265.7)))
      (call L.fun/empty16266.5))))
(check-by-interp
 '(module
    (define L.fun/empty16271.4 (lambda () empty))
    (define L.fun/vector16269.5 (lambda () (call make-vector 8)))
    (define L.fun/void16270.6 (lambda () (void)))
    (define L.fun/void16272.7 (lambda () (void)))
    (let ((fixnum0.5
           (call
            *
            (call * (call * 129 130) (call - 151 108))
            (call - (call - 247 154) (call + 176 124))))
          (vector1.4 (call L.fun/vector16269.5))
          (void2.3 (call L.fun/void16270.6))
          (empty3.2 (call L.fun/empty16271.4))
          (void4.1 (call L.fun/void16272.7)))
      empty3.2)))
(check-by-interp
 '(module
    (define L.fun/ascii-char16283.4 (lambda () #\c))
    (define L.fun/void16282.5 (lambda () (void)))
    (define L.fun/ascii-char16286.6 (lambda () #\c))
    (define L.fun/error16285.7 (lambda () (error 183)))
    (define L.fun/vector16284.8 (lambda () (call make-vector 8)))
    (let ((void0.5 (call L.fun/void16282.5))
          (ascii-char1.4 (call L.fun/ascii-char16283.4))
          (vector2.3 (call L.fun/vector16284.8))
          (error3.2 (call L.fun/error16285.7))
          (ascii-char4.1 (call L.fun/ascii-char16286.6)))
      (call
       *
       (call + (call * 52 143) (call - 136 177))
       (call - (call - 239 199) (call - 28 66))))))
(check-by-interp
 '(module
    (define L.fun/error16296.4 (lambda () (error 38)))
    (define L.fun/vector16298.5 (lambda () (call make-vector 8)))
    (define L.fun/empty16297.6 (lambda () empty))
    (define L.fun/void16299.7 (lambda () (void)))
    (define L.fun/vector16300.8 (lambda () (call make-vector 8)))
    (let ((error0.5 (call L.fun/error16296.4))
          (empty1.4 (call L.fun/empty16297.6))
          (vector2.3 (call L.fun/vector16298.5))
          (void3.2 (call L.fun/void16299.7))
          (vector4.1 (call L.fun/vector16300.8)))
      empty1.4)))
(check-by-interp
 '(module
    (define L.fun/vector16443.4 (lambda () (call make-vector 8)))
    (define L.fun/error16445.5 (lambda () (error 87)))
    (define L.fun/void16446.6 (lambda () (void)))
    (define L.fun/ascii-char16444.7 (lambda () #\c))
    (define L.fun/empty16447.8 (lambda () empty))
    (let ((vector0.5 (call L.fun/vector16443.4))
          (ascii-char1.4 (call L.fun/ascii-char16444.7))
          (error2.3 (call L.fun/error16445.5))
          (void3.2 (call L.fun/void16446.6))
          (empty4.1 (call L.fun/empty16447.8)))
      (call
       -
       (call * (call - 1 200) (call + 14 75))
       (call * (call * 233 50) (call * 76 140))))))
(check-by-interp
 '(module
    (define L.fun/any17146.4 (lambda () 230))
    (define L.fun/void17148.5 (lambda () (void)))
    (define L.fun/vector17145.6 (lambda () (call make-vector 8)))
    (define L.fun/error17147.7 (lambda () (error 244)))
    (let ((vector0.5 (call L.fun/vector17145.6))
          (boolean1.4 (call vector? (call L.fun/any17146.4)))
          (fixnum2.3
           (call
            +
            (call * (call - 131 248) (call * 129 109))
            (call + (call + 179 106) (call + 84 39))))
          (error3.2 (call L.fun/error17147.7))
          (void4.1 (call L.fun/void17148.5)))
      vector0.5)))
(check-by-interp
 '(module
    (define L.fun/void17748.4 (lambda () (void)))
    (define L.fun/ascii-char17750.5 (lambda () #\c))
    (define L.fun/error17749.6 (lambda () (error 141)))
    (let ((void0.5 (call L.fun/void17748.4))
          (fixnum1.4
           (call
            +
            (call + (call * 250 187) (call + 177 58))
            (call + (call * 114 169) (call + 147 148))))
          (error2.3 (call L.fun/error17749.6))
          (ascii-char3.2 (call L.fun/ascii-char17750.5))
          (fixnum4.1
           (call
            -
            (call - (call * 240 76) (call + 175 182))
            (call + (call * 185 50) (call - 106 165)))))
      void0.5)))
(check-by-interp
 '(module
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
            -
            (call * (call - 117 124) (call * 99 52))
            (call * (call + 242 99) (call * 59 238)))))
      (call L.fun/error17806.5))))
(check-by-interp
 '(module
    (define L.fun/error18259.4 (lambda () (error 81)))
    (define L.fun/vector18258.5 (lambda () (call make-vector 8)))
    (define L.fun/void18256.6 (lambda () (void)))
    (define L.fun/ascii-char18257.7 (lambda () #\c))
    (let ((fixnum0.5
           (call
            +
            (call - (call + 71 87) (call - 188 128))
            (call + (call * 160 201) (call + 136 9))))
          (void1.4 (call L.fun/void18256.6))
          (ascii-char2.3 (call L.fun/ascii-char18257.7))
          (vector3.2 (call L.fun/vector18258.5))
          (error4.1 (call L.fun/error18259.4)))
      fixnum0.5)))
(check-by-interp
 '(module
    (define L.fun/ascii-char19043.4 (lambda () #\c))
    (define L.fun/ascii-char19044.5 (lambda () #\c))
    (define L.fun/error19045.6 (lambda () (error 96)))
    (define L.fun/vector19042.7 (lambda () (call make-vector 8)))
    (let ((vector0.5 (call L.fun/vector19042.7))
          (fixnum1.4
           (call
            *
            (call * (call + 30 246) (call * 135 38))
            (call + (call * 149 48) (call * 17 53))))
          (ascii-char2.3 (call L.fun/ascii-char19043.4))
          (ascii-char3.2 (call L.fun/ascii-char19044.5))
          (error4.1 (call L.fun/error19045.6)))
      ascii-char3.2)))
(check-by-interp
 '(module
    (define L.fun/vector19309.4 (lambda () (call make-vector 8)))
    (define L.fun/vector19308.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char19306.6 (lambda () #\c))
    (define L.fun/empty19307.7 (lambda () empty))
    (let ((ascii-char0.5 (call L.fun/ascii-char19306.6))
          (fixnum1.4
           (call
            -
            (call * (call - 204 243) (call * 36 41))
            (call - (call * 63 177) (call * 158 98))))
          (empty2.3 (call L.fun/empty19307.7))
          (vector3.2 (call L.fun/vector19308.5))
          (vector4.1 (call L.fun/vector19309.4)))
      empty2.3)))
(check-by-interp
 '(module
    (if (call
         void?
         (let ((boolean0.5 #t)
               (error1.4 (error 3))
               (void2.3 (void))
               (fixnum3.2 189)
               (fixnum4.1 11))
           (void)))
      (call * (if #t 50 150) (if #t 125 157))
      (call * (if #f 183 45) (if #t 9 102)))))
(check-by-interp
 '(module
    (define L.fun/error19878.4 (lambda () (error 23)))
    (define L.fun/empty19877.5 (lambda () empty))
    (define L.fun/ascii-char19880.6 (lambda () #\c))
    (define L.fun/vector19876.7 (lambda () (call make-vector 8)))
    (define L.fun/empty19879.8 (lambda () empty))
    (let ((vector0.5 (call L.fun/vector19876.7))
          (empty1.4 (call L.fun/empty19877.5))
          (error2.3 (call L.fun/error19878.4))
          (empty3.2 (call L.fun/empty19879.8))
          (fixnum4.1
           (call
            *
            (call + (call * 229 40) (call - 231 149))
            (call * (call - 94 252) (call * 10 202)))))
      (call L.fun/ascii-char19880.6))))
(check-by-interp
 '(module
    (define L.fun/vector20028.4 (lambda () (call make-vector 8)))
    (define L.fun/vector20025.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char20024.6 (lambda () #\c))
    (define L.fun/void20026.7 (lambda () (void)))
    (define L.fun/error20027.8 (lambda () (error 122)))
    (let ((ascii-char0.5 (call L.fun/ascii-char20024.6))
          (vector1.4 (call L.fun/vector20025.5))
          (void2.3 (call L.fun/void20026.7))
          (error3.2 (call L.fun/error20027.8))
          (vector4.1 (call L.fun/vector20028.4)))
      vector4.1)))
(check-by-interp
 '(module
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
            *
            (call - (call * 18 125) (call * 156 230))
            (call * (call * 11 152) (call + 64 98)))))
      ascii-char3.2)))
(check-by-interp
 '(module
    (define L.fun/void22593.4 (lambda () (void)))
    (define L.fun/ascii-char22584.5
      (lambda () (call L.fun/ascii-char22585.13)))
    (define L.fun/error22587.6 (lambda () (error 189)))
    (define L.fun/void22588.7 (lambda () (call L.fun/void22589.10)))
    (define L.fun/vector22590.8 (lambda () (call L.fun/vector22591.9)))
    (define L.fun/vector22591.9 (lambda () (call make-vector 8)))
    (define L.fun/void22589.10 (lambda () (void)))
    (define L.fun/error22586.11 (lambda () (call L.fun/error22587.6)))
    (define L.fun/void22592.12 (lambda () (call L.fun/void22593.4)))
    (define L.fun/ascii-char22585.13 (lambda () #\c))
    (let ((ascii-char0.6 (call L.fun/ascii-char22584.5))
          (error1.5 (call L.fun/error22586.11))
          (fixnum2.4
           (call
            -
            (call
             +
             (call - (call * 222 198) (call - 20 199))
             (call * (call + 121 88) (call + 3 209)))
            (call
             +
             (call - (call * 89 40) (call + 216 190))
             (call + (call * 7 45) (call - 39 97)))))
          (void3.3 (call L.fun/void22588.7))
          (vector4.2 (call L.fun/vector22590.8))
          (void5.1 (call L.fun/void22592.12)))
      error1.5)))
(check-by-interp
 '(module
    (define L.fun/vector22813.4 (lambda () (call L.fun/vector22814.12)))
    (define L.fun/vector22811.5 (lambda () (call L.fun/vector22812.13)))
    (define L.fun/empty22815.6 (lambda () (call L.fun/empty22816.14)))
    (define L.fun/error22818.7 (lambda () (error 129)))
    (define L.fun/ascii-char22821.8 (lambda () #\c))
    (define L.fun/ascii-char22820.9 (lambda () (call L.fun/ascii-char22821.8)))
    (define L.fun/any22819.10 (lambda () (call make-vector 8)))
    (define L.fun/error22817.11 (lambda () (call L.fun/error22818.7)))
    (define L.fun/vector22814.12 (lambda () (call make-vector 8)))
    (define L.fun/vector22812.13 (lambda () (call make-vector 8)))
    (define L.fun/empty22816.14 (lambda () empty))
    (let ((vector0.6 (call L.fun/vector22811.5))
          (vector1.5 (call L.fun/vector22813.4))
          (empty2.4 (call L.fun/empty22815.6))
          (error3.3 (call L.fun/error22817.11))
          (boolean4.2 (call ascii-char? (call L.fun/any22819.10)))
          (ascii-char5.1 (call L.fun/ascii-char22820.9)))
      ascii-char5.1)))
(check-by-interp
 '(module
    (define L.fun/void23821.4 (lambda () (call L.fun/void23822.11)))
    (define L.fun/void23820.5 (lambda () (void)))
    (define L.fun/void23813.6 (lambda () (call L.fun/void23814.12)))
    (define L.fun/vector23817.7 (lambda () (call L.fun/vector23818.13)))
    (define L.fun/empty23816.8 (lambda () empty))
    (define L.fun/void23819.9 (lambda () (call L.fun/void23820.5)))
    (define L.fun/empty23815.10 (lambda () (call L.fun/empty23816.8)))
    (define L.fun/void23822.11 (lambda () (void)))
    (define L.fun/void23814.12 (lambda () (void)))
    (define L.fun/vector23818.13 (lambda () (call make-vector 8)))
    (let ((void0.6 (call L.fun/void23813.6))
          (empty1.5 (call L.fun/empty23815.10))
          (vector2.4 (call L.fun/vector23817.7))
          (void3.3 (call L.fun/void23819.9))
          (void4.2 (call L.fun/void23821.4))
          (fixnum5.1
           (call
            *
            (call
             -
             (call * (call + 189 105) (call - 46 215))
             (call * (call - 138 85) (call + 173 17)))
            (call
             *
             (call * (call + 232 122) (call + 200 136))
             (call - (call - 154 17) (call + 59 219))))))
      empty1.5)))
(check-by-interp
 '(module
    (define L.fun/empty27868.4 (lambda () (call L.fun/empty27869.13)))
    (define L.fun/vector27865.5 (lambda () (call make-vector 8)))
    (define L.fun/vector27860.6 (lambda () (call L.fun/vector27861.11)))
    (define L.fun/vector27864.7 (lambda () (call L.fun/vector27865.5)))
    (define L.fun/void27862.8 (lambda () (call L.fun/void27863.10)))
    (define L.fun/ascii-char27867.9 (lambda () #\c))
    (define L.fun/void27863.10 (lambda () (void)))
    (define L.fun/vector27861.11 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char27866.12
      (lambda () (call L.fun/ascii-char27867.9)))
    (define L.fun/empty27869.13 (lambda () empty))
    (let ((vector0.6 (call L.fun/vector27860.6))
          (void1.5 (call L.fun/void27862.8))
          (vector2.4 (call L.fun/vector27864.7))
          (ascii-char3.3 (call L.fun/ascii-char27866.12))
          (fixnum4.2
           (call
            *
            (call
             -
             (call * (call + 248 106) (call * 80 130))
             (call * (call - 5 134) (call * 223 102)))
            (call
             -
             (call * (call - 254 178) (call - 44 163))
             (call * (call * 64 227) (call * 231 138)))))
          (empty5.1 (call L.fun/empty27868.4)))
      ascii-char3.3)))
(check-by-interp
 '(module
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
            -
            (call
             +
             (call - (call * 57 202) (call + 114 18))
             (call - (call * 131 116) (call * 159 28)))
            (call
             -
             (call * (call * 234 28) (call + 114 191))
             (call + (call + 209 40) (call - 169 160)))))
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
    (define L.fun/void29441.4 (lambda () (void)))
    (define L.fun/vector29438.5 (lambda () (call L.fun/vector29439.9)))
    (define L.fun/empty29442.6 (lambda () (call L.fun/empty29443.7)))
    (define L.fun/empty29443.7 (lambda () empty))
    (define L.fun/void29440.8 (lambda () (call L.fun/void29441.4)))
    (define L.fun/vector29439.9 (lambda () (call make-vector 8)))
    (define L.fun/error29444.10 (lambda () (call L.fun/error29445.11)))
    (define L.fun/error29445.11 (lambda () (error 15)))
    (let ((fixnum0.6
           (call
            *
            (call
             *
             (call + (call * 84 220) (call + 5 195))
             (call * (call - 145 81) (call - 171 5)))
            (call
             -
             (call - (call - 232 101) (call - 34 12))
             (call - (call - 157 180) (call + 127 206)))))
          (vector1.5 (call L.fun/vector29438.5))
          (fixnum2.4
           (call
            +
            (call
             *
             (call + (call * 25 244) (call - 108 134))
             (call - (call + 63 230) (call - 196 182)))
            (call
             -
             (call - (call - 134 28) (call * 53 222))
             (call - (call - 117 251) (call * 94 170)))))
          (void3.3 (call L.fun/void29440.8))
          (empty4.2 (call L.fun/empty29442.6))
          (error5.1 (call L.fun/error29444.10)))
      void3.3)))
(check-by-interp
 '(module
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
            -
            (call
             +
             (call * (call - 195 178) (call - 61 180))
             (call * (call + 126 54) (call + 95 83)))
            (call
             +
             (call + (call + 171 51) (call * 69 252))
             (call + (call * 66 146) (call + 234 178)))))
          (void5.1 (call L.fun/void30829.6)))
      void5.1)))
(check-by-interp
 '(module
    (define L.fun/void31698.4 (lambda () (call L.fun/void31699.8)))
    (define L.fun/void31701.5 (lambda () (void)))
    (define L.fun/void31700.6 (lambda () (call L.fun/void31701.5)))
    (define L.fun/empty31697.7 (lambda () empty))
    (define L.fun/void31699.8 (lambda () (void)))
    (define L.fun/empty31696.9 (lambda () (call L.fun/empty31697.7)))
    (let ((fixnum0.6
           (call
            *
            (call
             *
             (call + (call + 76 158) (call * 100 178))
             (call * (call - 174 45) (call * 177 242)))
            (call
             +
             (call * (call + 95 230) (call * 202 246))
             (call + (call + 45 224) (call * 112 185)))))
          (fixnum1.5
           (call
            +
            (call
             *
             (call * (call * 198 121) (call + 116 203))
             (call - (call * 82 179) (call + 98 26)))
            (call
             *
             (call - (call - 24 149) (call - 178 234))
             (call - (call * 22 11) (call * 114 140)))))
          (empty2.4 (call L.fun/empty31696.9))
          (void3.3 (call L.fun/void31698.4))
          (void4.2 (call L.fun/void31700.6))
          (fixnum5.1
           (call
            *
            (call
             +
             (call + (call - 80 112) (call - 139 11))
             (call + (call + 244 241) (call * 194 173)))
            (call
             *
             (call + (call - 34 120) (call * 152 174))
             (call + (call * 144 179) (call - 152 104))))))
      void3.3)))
(check-by-interp
 '(module
    (define L.fun/empty36308.4 (lambda () (call L.fun/empty36309.9)))
    (define L.fun/empty36303.5 (lambda () empty))
    (define L.fun/void36307.6 (lambda () (void)))
    (define L.fun/void36312.7 (lambda () (call L.fun/void36313.12)))
    (define L.fun/error36311.8 (lambda () (error 123)))
    (define L.fun/empty36309.9 (lambda () empty))
    (define L.fun/vector36305.10 (lambda () (call make-vector 8)))
    (define L.fun/void36306.11 (lambda () (call L.fun/void36307.6)))
    (define L.fun/void36313.12 (lambda () (void)))
    (define L.fun/vector36304.13 (lambda () (call L.fun/vector36305.10)))
    (define L.fun/error36310.14 (lambda () (call L.fun/error36311.8)))
    (define L.fun/empty36302.15 (lambda () (call L.fun/empty36303.5)))
    (let ((empty0.6 (call L.fun/empty36302.15))
          (vector1.5 (call L.fun/vector36304.13))
          (void2.4 (call L.fun/void36306.11))
          (empty3.3 (call L.fun/empty36308.4))
          (error4.2 (call L.fun/error36310.14))
          (void5.1 (call L.fun/void36312.7)))
      (call
       -
       (call
        *
        (call - (call * 199 193) (call - 248 56))
        (call + (call - 85 152) (call - 47 5)))
       (call
        +
        (call - (call + 106 174) (call * 93 90))
        (call + (call * 240 54) (call + 128 184)))))))
(check-by-interp
 '(module
    (define L.fun/error36349.4 (lambda () (error 64)))
    (define L.fun/void36353.5 (lambda () (void)))
    (define L.fun/empty36356.6 (lambda () (call L.fun/empty36357.12)))
    (define L.fun/any36358.7 (lambda () (void)))
    (define L.fun/vector36359.8 (lambda () (call L.fun/vector36360.13)))
    (define L.fun/error36348.9 (lambda () (call L.fun/error36349.4)))
    (define L.fun/error36350.10 (lambda () (call L.fun/error36351.16)))
    (define L.fun/empty36355.11 (lambda () empty))
    (define L.fun/empty36357.12 (lambda () empty))
    (define L.fun/vector36360.13 (lambda () (call make-vector 8)))
    (define L.fun/empty36354.14 (lambda () (call L.fun/empty36355.11)))
    (define L.fun/void36352.15 (lambda () (call L.fun/void36353.5)))
    (define L.fun/error36351.16 (lambda () (error 1)))
    (let ((error0.6 (call L.fun/error36348.9))
          (error1.5 (call L.fun/error36350.10))
          (void2.4 (call L.fun/void36352.15))
          (empty3.3 (call L.fun/empty36354.14))
          (empty4.2 (call L.fun/empty36356.6))
          (boolean5.1 (call pair? (call L.fun/any36358.7))))
      (call L.fun/vector36359.8))))
(check-by-interp
 '(module
    (define L.fun/vector38038.4 (lambda () (call L.fun/vector38039.11)))
    (define L.fun/ascii-char38035.5
      (lambda () (call L.fun/ascii-char38036.12)))
    (define L.fun/ascii-char38034.6 (lambda () #\c))
    (define L.fun/any38037.7 (lambda () (error 238)))
    (define L.fun/void38041.8 (lambda () (void)))
    (define L.fun/empty38042.9 (lambda () (call L.fun/empty38043.14)))
    (define L.fun/void38040.10 (lambda () (call L.fun/void38041.8)))
    (define L.fun/vector38039.11 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char38036.12 (lambda () #\c))
    (define L.fun/ascii-char38033.13
      (lambda () (call L.fun/ascii-char38034.6)))
    (define L.fun/empty38043.14 (lambda () empty))
    (let ((ascii-char0.6 (call L.fun/ascii-char38033.13))
          (ascii-char1.5 (call L.fun/ascii-char38035.5))
          (boolean2.4 (call fixnum? (call L.fun/any38037.7)))
          (vector3.3 (call L.fun/vector38038.4))
          (void4.2 (call L.fun/void38040.10))
          (empty5.1 (call L.fun/empty38042.9)))
      empty5.1)))
(check-by-interp
 '(module
    (define L.fun/any39304.4 (lambda () (call make-vector 8)))
    (define L.fun/void39302.5 (lambda () (call L.fun/void39303.6)))
    (define L.fun/void39303.6 (lambda () (void)))
    (define L.fun/ascii-char39301.7 (lambda () #\c))
    (define L.fun/void39306.8 (lambda () (void)))
    (define L.fun/void39307.9 (lambda () (call L.fun/void39308.11)))
    (define L.fun/void39305.10 (lambda () (call L.fun/void39306.8)))
    (define L.fun/void39308.11 (lambda () (void)))
    (define L.fun/empty39309.12 (lambda () (call L.fun/empty39310.14)))
    (define L.fun/ascii-char39300.13
      (lambda () (call L.fun/ascii-char39301.7)))
    (define L.fun/empty39310.14 (lambda () empty))
    (let ((ascii-char0.6 (call L.fun/ascii-char39300.13))
          (void1.5 (call L.fun/void39302.5))
          (boolean2.4 (call boolean? (call L.fun/any39304.4)))
          (fixnum3.3
           (call
            +
            (call
             *
             (call - (call + 232 50) (call * 119 66))
             (call - (call * 245 11) (call + 122 63)))
            (call
             +
             (call * (call + 8 187) (call + 251 18))
             (call - (call + 230 117) (call * 6 15)))))
          (void4.2 (call L.fun/void39305.10))
          (void5.1 (call L.fun/void39307.9)))
      (call L.fun/empty39309.12))))
(check-by-interp
 '(module
    (define L.fun/error39534.4 (lambda () (call L.fun/error39535.10)))
    (define L.fun/empty39523.5 (lambda () (call L.fun/empty39524.14)))
    (define L.fun/void39533.6 (lambda () (void)))
    (define L.fun/vector39527.7 (lambda () (call L.fun/vector39528.13)))
    (define L.fun/ascii-char39526.8 (lambda () #\c))
    (define L.fun/empty39529.9 (lambda () (call L.fun/empty39530.12)))
    (define L.fun/error39535.10 (lambda () (error 105)))
    (define L.fun/ascii-char39525.11
      (lambda () (call L.fun/ascii-char39526.8)))
    (define L.fun/empty39530.12 (lambda () empty))
    (define L.fun/vector39528.13 (lambda () (call make-vector 8)))
    (define L.fun/empty39524.14 (lambda () empty))
    (define L.fun/void39532.15 (lambda () (call L.fun/void39533.6)))
    (define L.fun/any39531.16 (lambda () 39))
    (let ((empty0.6 (call L.fun/empty39523.5))
          (ascii-char1.5 (call L.fun/ascii-char39525.11))
          (vector2.4 (call L.fun/vector39527.7))
          (empty3.3 (call L.fun/empty39529.9))
          (boolean4.2 (call ascii-char? (call L.fun/any39531.16)))
          (void5.1 (call L.fun/void39532.15)))
      (call L.fun/error39534.4))))
(check-by-interp
 '(module
    (define L.fun/error40731.4 (lambda () (error 190)))
    (define L.fun/void40737.5 (lambda () (void)))
    (define L.fun/vector40738.6 (lambda () (call L.fun/vector40739.7)))
    (define L.fun/vector40739.7 (lambda () (call make-vector 8)))
    (define L.fun/void40736.8 (lambda () (call L.fun/void40737.5)))
    (define L.fun/void40733.9 (lambda () (void)))
    (define L.fun/error40735.10 (lambda () (error 189)))
    (define L.fun/error40730.11 (lambda () (call L.fun/error40731.4)))
    (define L.fun/error40734.12 (lambda () (call L.fun/error40735.10)))
    (define L.fun/void40732.13 (lambda () (call L.fun/void40733.9)))
    (let ((error0.6 (call L.fun/error40730.11))
          (fixnum1.5
           (call
            +
            (call
             -
             (call + (call * 17 211) (call - 103 59))
             (call + (call - 155 59) (call - 157 72)))
            (call
             *
             (call + (call - 228 234) (call - 224 168))
             (call - (call * 172 1) (call + 211 184)))))
          (void2.4 (call L.fun/void40732.13))
          (error3.3 (call L.fun/error40734.12))
          (void4.2 (call L.fun/void40736.8))
          (vector5.1 (call L.fun/vector40738.6)))
      error3.3)))
(check-by-interp
 '(module
    (define L.fun/void41928.4 (lambda () (call L.fun/void41929.11)))
    (define L.fun/vector41931.5 (lambda () (call make-vector 8)))
    (define L.fun/void41924.6 (lambda () (call L.fun/void41925.8)))
    (define L.fun/empty41926.7 (lambda () (call L.fun/empty41927.9)))
    (define L.fun/void41925.8 (lambda () (void)))
    (define L.fun/empty41927.9 (lambda () empty))
    (define L.fun/vector41930.10 (lambda () (call L.fun/vector41931.5)))
    (define L.fun/void41929.11 (lambda () (void)))
    (let ((void0.6 (call L.fun/void41924.6))
          (fixnum1.5
           (call
            *
            (call
             +
             (call - (call - 31 228) (call * 42 193))
             (call - (call - 87 41) (call + 121 215)))
            (call
             *
             (call + (call * 243 57) (call - 45 164))
             (call + (call - 21 74) (call + 100 112)))))
          (empty2.4 (call L.fun/empty41926.7))
          (void3.3 (call L.fun/void41928.4))
          (fixnum4.2
           (call
            *
            (call
             *
             (call * (call - 114 63) (call + 175 86))
             (call * (call - 178 63) (call + 33 190)))
            (call
             +
             (call * (call - 13 67) (call + 108 230))
             (call + (call * 28 77) (call - 11 81)))))
          (vector5.1 (call L.fun/vector41930.10)))
      fixnum1.5)))
(check-by-interp
 '(module
    (define L.fun/void45314.4 (lambda () (void)))
    (define L.fun/empty45311.5 (lambda () (call L.fun/empty45312.11)))
    (define L.fun/void45313.6 (lambda () (call L.fun/void45314.4)))
    (define L.fun/vector45308.7 (lambda () (call make-vector 8)))
    (define L.fun/vector45307.8 (lambda () (call L.fun/vector45308.7)))
    (define L.fun/void45309.9 (lambda () (call L.fun/void45310.10)))
    (define L.fun/void45310.10 (lambda () (void)))
    (define L.fun/empty45312.11 (lambda () empty))
    (let ((vector0.6 (call L.fun/vector45307.8))
          (fixnum1.5
           (call
            +
            (call
             -
             (call * (call * 229 172) (call - 243 142))
             (call * (call * 31 51) (call + 198 147)))
            (call
             -
             (call - (call * 208 202) (call - 51 176))
             (call - (call - 19 76) (call - 40 16)))))
          (void2.4 (call L.fun/void45309.9))
          (empty3.3 (call L.fun/empty45311.5))
          (fixnum4.2
           (call
            *
            (call
             -
             (call * (call - 237 224) (call + 65 65))
             (call + (call * 7 221) (call - 106 200)))
            (call
             *
             (call - (call - 27 94) (call - 136 242))
             (call * (call + 33 230) (call - 139 51)))))
          (void5.1 (call L.fun/void45313.6)))
      vector0.6)))
(check-by-interp
 '(module
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
            *
            (call
             -
             (call + (call * 19 179) (call + 80 36))
             (call * (call - 76 53) (call * 207 127)))
            (call
             +
             (call - (call * 174 75) (call - 35 107))
             (call + (call - 95 43) (call + 88 187)))))
          (void3.3 (call L.fun/void46565.4))
          (fixnum4.2
           (call
            *
            (call
             -
             (call - (call * 223 68) (call - 225 44))
             (call - (call + 74 49) (call - 193 65)))
            (call
             *
             (call - (call * 161 112) (call * 114 48))
             (call - (call * 85 50) (call + 83 60)))))
          (boolean5.1 (call pair? (call L.fun/any46567.10))))
      void3.3)))
(check-by-interp
 '(module
    (define L.fun/ascii-char48487.4 (lambda () #\c))
    (define L.fun/vector48483.5 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char48486.6 (lambda () (call L.fun/ascii-char48487.4)))
    (define L.fun/error48480.7 (lambda () (call L.fun/error48481.13)))
    (define L.fun/empty48485.8 (lambda () empty))
    (define L.fun/error48476.9 (lambda () (call L.fun/error48477.15)))
    (define L.fun/empty48478.10 (lambda () (call L.fun/empty48479.14)))
    (define L.fun/vector48482.11 (lambda () (call L.fun/vector48483.5)))
    (define L.fun/empty48484.12 (lambda () (call L.fun/empty48485.8)))
    (define L.fun/error48481.13 (lambda () (error 184)))
    (define L.fun/empty48479.14 (lambda () empty))
    (define L.fun/error48477.15 (lambda () (error 238)))
    (let ((error0.6 (call L.fun/error48476.9))
          (empty1.5 (call L.fun/empty48478.10))
          (error2.4 (call L.fun/error48480.7))
          (vector3.3 (call L.fun/vector48482.11))
          (empty4.2 (call L.fun/empty48484.12))
          (ascii-char5.1 (call L.fun/ascii-char48486.6)))
      ascii-char5.1)))
(check-by-interp
 '(module
    (define L.fun/void49751.4 (lambda () (call L.fun/void49752.13)))
    (define L.fun/vector49754.5 (lambda () (call L.fun/vector49755.16)))
    (define L.fun/error49746.6 (lambda () (error 124)))
    (define L.fun/empty49756.7 (lambda () (call L.fun/empty49757.8)))
    (define L.fun/empty49757.8 (lambda () empty))
    (define L.fun/error49745.9 (lambda () (call L.fun/error49746.6)))
    (define L.fun/vector49749.10 (lambda () (call L.fun/vector49750.15)))
    (define L.fun/any49753.11 (lambda () #t))
    (define L.fun/error49747.12 (lambda () (call L.fun/error49748.14)))
    (define L.fun/void49752.13 (lambda () (void)))
    (define L.fun/error49748.14 (lambda () (error 24)))
    (define L.fun/vector49750.15 (lambda () (call make-vector 8)))
    (define L.fun/vector49755.16 (lambda () (call make-vector 8)))
    (let ((error0.6 (call L.fun/error49745.9))
          (error1.5 (call L.fun/error49747.12))
          (vector2.4 (call L.fun/vector49749.10))
          (void3.3 (call L.fun/void49751.4))
          (boolean4.2 (call pair? (call L.fun/any49753.11)))
          (vector5.1 (call L.fun/vector49754.5)))
      (call L.fun/empty49756.7))))
(check-by-interp
 '(module
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
            +
            (call
             *
             (call - (call * 77 140) (call - 182 24))
             (call - (call + 175 53) (call + 177 174)))
            (call
             -
             (call - (call - 245 178) (call - 42 16))
             (call - (call + 144 205) (call + 136 39)))))
          (void3.3 (call L.fun/void50282.11))
          (fixnum4.2
           (call
            *
            (call
             -
             (call - (call - 209 76) (call + 217 50))
             (call - (call + 187 190) (call - 38 142)))
            (call
             +
             (call - (call - 205 24) (call - 227 153))
             (call - (call - 65 164) (call * 15 147)))))
          (ascii-char5.1 (call L.fun/ascii-char50284.7)))
      fixnum2.4)))
(check-by-interp
 '(module
    (define L.fun/ascii-char51646.4
      (lambda () (call L.fun/ascii-char51647.10)))
    (define L.fun/ascii-char51645.5 (lambda () #\c))
    (define L.fun/ascii-char51644.6 (lambda () (call L.fun/ascii-char51645.5)))
    (define L.fun/error51648.7 (lambda () (call L.fun/error51649.8)))
    (define L.fun/error51649.8 (lambda () (error 31)))
    (define L.fun/vector51642.9 (lambda () (call L.fun/vector51643.13)))
    (define L.fun/ascii-char51647.10 (lambda () #\c))
    (define L.fun/void51640.11 (lambda () (call L.fun/void51641.12)))
    (define L.fun/void51641.12 (lambda () (void)))
    (define L.fun/vector51643.13 (lambda () (call make-vector 8)))
    (let ((void0.6 (call L.fun/void51640.11))
          (vector1.5 (call L.fun/vector51642.9))
          (ascii-char2.4 (call L.fun/ascii-char51644.6))
          (ascii-char3.3 (call L.fun/ascii-char51646.4))
          (fixnum4.2
           (call
            +
            (call
             -
             (call - (call + 190 217) (call - 6 135))
             (call - (call + 226 97) (call - 101 153)))
            (call
             +
             (call * (call * 22 69) (call * 173 32))
             (call + (call * 253 17) (call + 187 43)))))
          (error5.1 (call L.fun/error51648.7)))
      void0.6)))
(check-by-interp
 '(module
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
            *
            (call
             *
             (call - (call - 87 4) (call * 197 221))
             (call - (call + 204 51) (call - 79 122)))
            (call
             *
             (call + (call + 21 76) (call + 239 50))
             (call + (call * 124 157) (call * 143 53)))))
          (error1.5 (call L.fun/error51652.10))
          (void2.4 (call L.fun/void51654.7))
          (fixnum3.3
           (call
            *
            (call
             -
             (call * (call * 184 195) (call * 74 203))
             (call * (call * 67 169) (call * 111 106)))
            (call
             -
             (call - (call * 140 7) (call + 103 127))
             (call + (call * 2 132) (call + 113 18)))))
          (ascii-char4.2 (call L.fun/ascii-char51656.4))
          (error5.1 (call L.fun/error51658.6)))
      void2.4)))
(check-by-interp
 '(module
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
          (boolean1.5 (call vector? (call L.fun/any54323.11)))
          (error2.4 (call L.fun/error54324.13))
          (error3.3 (call L.fun/error54326.4))
          (void4.2 (call L.fun/void54328.12))
          (empty5.1 (call L.fun/empty54330.14)))
      void4.2)))
(check-by-interp
 '(module
    (define L.fun/vector55635.4 (lambda () (call L.fun/vector55636.11)))
    (define L.fun/error55638.5 (lambda () (error 40)))
    (define L.fun/error55631.6 (lambda () (call L.fun/error55632.13)))
    (define L.fun/void55630.7 (lambda () (void)))
    (define L.fun/void55634.8 (lambda () (void)))
    (define L.fun/void55629.9 (lambda () (call L.fun/void55630.7)))
    (define L.fun/void55633.10 (lambda () (call L.fun/void55634.8)))
    (define L.fun/vector55636.11 (lambda () (call make-vector 8)))
    (define L.fun/error55637.12 (lambda () (call L.fun/error55638.5)))
    (define L.fun/error55632.13 (lambda () (error 246)))
    (let ((void0.6 (call L.fun/void55629.9))
          (error1.5 (call L.fun/error55631.6))
          (void2.4 (call L.fun/void55633.10))
          (fixnum3.3
           (call
            -
            (call
             -
             (call * (call + 245 248) (call - 253 172))
             (call + (call * 171 11) (call * 242 52)))
            (call
             *
             (call * (call - 180 251) (call * 252 83))
             (call - (call + 29 53) (call - 180 87)))))
          (vector4.2 (call L.fun/vector55635.4))
          (error5.1 (call L.fun/error55637.12)))
      void2.4)))
(check-by-interp
 '(module
    (define L.fun/empty57254.4 (lambda () (call L.fun/empty57255.11)))
    (define L.fun/error57260.5 (lambda () (call L.fun/error57261.10)))
    (define L.fun/vector57256.6 (lambda () (call L.fun/vector57257.15)))
    (define L.fun/vector57263.7 (lambda () (call make-vector 8)))
    (define L.fun/void57252.8 (lambda () (call L.fun/void57253.13)))
    (define L.fun/vector57262.9 (lambda () (call L.fun/vector57263.7)))
    (define L.fun/error57261.10 (lambda () (error 37)))
    (define L.fun/empty57255.11 (lambda () empty))
    (define L.fun/ascii-char57258.12
      (lambda () (call L.fun/ascii-char57259.14)))
    (define L.fun/void57253.13 (lambda () (void)))
    (define L.fun/ascii-char57259.14 (lambda () #\c))
    (define L.fun/vector57257.15 (lambda () (call make-vector 8)))
    (let ((void0.6 (call L.fun/void57252.8))
          (empty1.5 (call L.fun/empty57254.4))
          (vector2.4 (call L.fun/vector57256.6))
          (ascii-char3.3 (call L.fun/ascii-char57258.12))
          (error4.2 (call L.fun/error57260.5))
          (vector5.1 (call L.fun/vector57262.9)))
      empty1.5)))
(check-by-interp
 '(module
    (define L.fun/empty58674.4 (lambda () empty))
    (define L.fun/vector58667.5 (lambda () (call L.fun/vector58668.13)))
    (define L.fun/vector58670.6 (lambda () (call make-vector 8)))
    (define L.fun/vector58669.7 (lambda () (call L.fun/vector58670.6)))
    (define L.fun/void58671.8 (lambda () (call L.fun/void58672.10)))
    (define L.fun/void58678.9 (lambda () (void)))
    (define L.fun/void58672.10 (lambda () (void)))
    (define L.fun/empty58673.11 (lambda () (call L.fun/empty58674.4)))
    (define L.fun/vector58676.12 (lambda () (call make-vector 8)))
    (define L.fun/vector58668.13 (lambda () (call make-vector 8)))
    (define L.fun/void58677.14 (lambda () (call L.fun/void58678.9)))
    (define L.fun/vector58675.15 (lambda () (call L.fun/vector58676.12)))
    (let ((vector0.6 (call L.fun/vector58667.5))
          (vector1.5 (call L.fun/vector58669.7))
          (void2.4 (call L.fun/void58671.8))
          (empty3.3 (call L.fun/empty58673.11))
          (vector4.2 (call L.fun/vector58675.15))
          (void5.1 (call L.fun/void58677.14)))
      (call
       +
       (call
        -
        (call * (call - 245 118) (call * 74 49))
        (call - (call + 123 225) (call * 180 160)))
       (call
        -
        (call * (call * 163 159) (call - 179 126))
        (call * (call * 245 222) (call + 61 43)))))))
(check-by-interp
 '(module
    (define L.fun/vector62053.4 (lambda () (call make-vector 8)))
    (define L.fun/vector62051.5 (lambda () (call make-vector 8)))
    (define L.fun/vector62049.6 (lambda () (call make-vector 8)))
    (define L.fun/error62058.7 (lambda () (call L.fun/error62059.9)))
    (define L.fun/ascii-char62054.8
      (lambda () (call L.fun/ascii-char62055.15)))
    (define L.fun/error62059.9 (lambda () (error 5)))
    (define L.fun/void62057.10 (lambda () (void)))
    (define L.fun/vector62052.11 (lambda () (call L.fun/vector62053.4)))
    (define L.fun/vector62050.12 (lambda () (call L.fun/vector62051.5)))
    (define L.fun/void62046.13 (lambda () (call L.fun/void62047.16)))
    (define L.fun/void62056.14 (lambda () (call L.fun/void62057.10)))
    (define L.fun/ascii-char62055.15 (lambda () #\c))
    (define L.fun/void62047.16 (lambda () (void)))
    (define L.fun/vector62048.17 (lambda () (call L.fun/vector62049.6)))
    (let ((void0.6 (call L.fun/void62046.13))
          (vector1.5 (call L.fun/vector62048.17))
          (vector2.4 (call L.fun/vector62050.12))
          (vector3.3 (call L.fun/vector62052.11))
          (ascii-char4.2 (call L.fun/ascii-char62054.8))
          (void5.1 (call L.fun/void62056.14)))
      (call L.fun/error62058.7))))
(check-by-interp
 '(module
    (define L.fun/vector63648.4 (lambda () (call L.fun/vector63649.7)))
    (define L.fun/ascii-char63654.5
      (lambda () (call L.fun/ascii-char63655.10)))
    (define L.fun/void63653.6 (lambda () (void)))
    (define L.fun/vector63649.7 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char63650.8
      (lambda () (call L.fun/ascii-char63651.11)))
    (define L.fun/void63652.9 (lambda () (call L.fun/void63653.6)))
    (define L.fun/ascii-char63655.10 (lambda () #\c))
    (define L.fun/ascii-char63651.11 (lambda () #\c))
    (let ((fixnum0.6
           (call
            +
            (call
             *
             (call + (call * 226 249) (call - 47 63))
             (call * (call + 191 108) (call * 167 27)))
            (call
             *
             (call - (call * 34 152) (call * 150 141))
             (call + (call * 172 231) (call + 248 83)))))
          (vector1.5 (call L.fun/vector63648.4))
          (ascii-char2.4 (call L.fun/ascii-char63650.8))
          (void3.3 (call L.fun/void63652.9))
          (ascii-char4.2 (call L.fun/ascii-char63654.5))
          (fixnum5.1
           (call
            *
            (call
             *
             (call + (call - 207 41) (call + 45 23))
             (call * (call * 42 92) (call + 1 81)))
            (call
             +
             (call * (call * 137 203) (call * 203 0))
             (call * (call + 246 210) (call * 242 64))))))
      (call * fixnum5.1 fixnum0.6))))
(check-by-interp
 '(module
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
          (boolean1.5 (call boolean? (call L.fun/any64311.10)))
          (error2.4 (call L.fun/error64312.11))
          (empty3.3 (call L.fun/empty64314.13))
          (empty4.2 (call L.fun/empty64316.12))
          (fixnum5.1
           (call
            +
            (call
             -
             (call + (call - 145 190) (call + 138 64))
             (call - (call * 180 226) (call - 87 199)))
            (call
             *
             (call * (call - 23 122) (call * 1 110))
             (call - (call * 139 138) (call + 124 191))))))
      (call L.fun/ascii-char64318.7))))
(check-by-interp
 '(module
    (define L.fun/vector64576.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char64582.5 (lambda () #\c))
    (define L.fun/vector64578.6 (lambda () (call make-vector 8)))
    (define L.fun/any64574.7 (lambda () (void)))
    (define L.fun/vector64579.8 (lambda () (call L.fun/vector64580.12)))
    (define L.fun/empty64584.9 (lambda () empty))
    (define L.fun/empty64583.10 (lambda () (call L.fun/empty64584.9)))
    (define L.fun/ascii-char64581.11
      (lambda () (call L.fun/ascii-char64582.5)))
    (define L.fun/vector64580.12 (lambda () (call make-vector 8)))
    (define L.fun/vector64577.13 (lambda () (call L.fun/vector64578.6)))
    (define L.fun/vector64575.14 (lambda () (call L.fun/vector64576.4)))
    (let ((boolean0.6 (call boolean? (call L.fun/any64574.7)))
          (vector1.5 (call L.fun/vector64575.14))
          (vector2.4 (call L.fun/vector64577.13))
          (vector3.3 (call L.fun/vector64579.8))
          (ascii-char4.2 (call L.fun/ascii-char64581.11))
          (fixnum5.1
           (call
            +
            (call
             -
             (call * (call + 68 91) (call + 210 2))
             (call - (call * 158 20) (call * 202 204)))
            (call
             +
             (call * (call - 21 4) (call - 92 32))
             (call * (call - 179 143) (call * 41 1))))))
      (call L.fun/empty64583.10))))
(check-by-interp
 '(module
    (define L.fun/ascii-char68259.4 (lambda () #\c))
    (define L.fun/error68263.5 (lambda () (error 228)))
    (define L.fun/vector68261.6 (lambda () (call make-vector 8)))
    (define L.fun/void68267.7 (lambda () (void)))
    (define L.fun/ascii-char68258.8 (lambda () (call L.fun/ascii-char68259.4)))
    (define L.fun/error68264.9 (lambda () (call L.fun/error68265.13)))
    (define L.fun/empty68268.10 (lambda () (call L.fun/empty68269.11)))
    (define L.fun/empty68269.11 (lambda () empty))
    (define L.fun/vector68260.12 (lambda () (call L.fun/vector68261.6)))
    (define L.fun/error68265.13 (lambda () (error 141)))
    (define L.fun/void68266.14 (lambda () (call L.fun/void68267.7)))
    (define L.fun/error68262.15 (lambda () (call L.fun/error68263.5)))
    (let ((ascii-char0.6 (call L.fun/ascii-char68258.8))
          (vector1.5 (call L.fun/vector68260.12))
          (fixnum2.4
           (call
            +
            (call
             *
             (call + (call + 232 203) (call * 111 47))
             (call * (call * 67 71) (call * 15 139)))
            (call
             *
             (call * (call * 108 112) (call - 63 168))
             (call - (call - 204 12) (call - 66 21)))))
          (error3.3 (call L.fun/error68262.15))
          (error4.2 (call L.fun/error68264.9))
          (void5.1 (call L.fun/void68266.14)))
      (call L.fun/empty68268.10))))
(check-by-interp
 '(module
    (define L.fun/ascii-char72253.4 (lambda () (call L.fun/ascii-char72254.8)))
    (define L.fun/error72257.5 (lambda () (call L.fun/error72258.12)))
    (define L.fun/void72255.6 (lambda () (call L.fun/void72256.13)))
    (define L.fun/vector72259.7 (lambda () (call L.fun/vector72260.9)))
    (define L.fun/ascii-char72254.8 (lambda () #\c))
    (define L.fun/vector72260.9 (lambda () (call make-vector 8)))
    (define L.fun/error72251.10 (lambda () (call L.fun/error72252.11)))
    (define L.fun/error72252.11 (lambda () (error 225)))
    (define L.fun/error72258.12 (lambda () (error 56)))
    (define L.fun/void72256.13 (lambda () (void)))
    (let ((error0.6 (call L.fun/error72251.10))
          (ascii-char1.5 (call L.fun/ascii-char72253.4))
          (fixnum2.4
           (call
            +
            (call
             +
             (call * (call * 99 39) (call * 238 101))
             (call - (call * 214 188) (call + 78 26)))
            (call
             *
             (call * (call + 104 31) (call - 247 88))
             (call * (call * 219 60) (call - 109 85)))))
          (void3.3 (call L.fun/void72255.6))
          (error4.2 (call L.fun/error72257.5))
          (vector5.1 (call L.fun/vector72259.7)))
      error4.2)))
(check-by-interp
 '(module
    (define L.fun/void73796.4 (lambda () (call L.fun/void73797.12)))
    (define L.fun/ascii-char73795.5 (lambda () #\c))
    (define L.fun/error73801.6 (lambda () (call L.fun/error73802.8)))
    (define L.fun/vector73799.7 (lambda () (call L.fun/vector73800.9)))
    (define L.fun/error73802.8 (lambda () (error 201)))
    (define L.fun/vector73800.9 (lambda () (call make-vector 8)))
    (define L.fun/any73798.10 (lambda () (error 149)))
    (define L.fun/ascii-char73794.11
      (lambda () (call L.fun/ascii-char73795.5)))
    (define L.fun/void73797.12 (lambda () (void)))
    (let ((fixnum0.6
           (call
            +
            (call
             *
             (call - (call * 181 102) (call * 236 96))
             (call + (call * 43 69) (call * 207 37)))
            (call
             -
             (call - (call - 121 160) (call + 28 176))
             (call - (call - 40 151) (call - 94 77)))))
          (ascii-char1.5 (call L.fun/ascii-char73794.11))
          (void2.4 (call L.fun/void73796.4))
          (fixnum3.3
           (call
            +
            (call
             -
             (call * (call - 150 177) (call - 143 104))
             (call - (call + 61 249) (call + 224 141)))
            (call
             *
             (call * (call + 246 127) (call + 189 31))
             (call * (call + 42 81) (call * 45 200)))))
          (boolean4.2 (call void? (call L.fun/any73798.10)))
          (vector5.1 (call L.fun/vector73799.7)))
      (call L.fun/error73801.6))))
(check-by-interp
 '(module
    (define L.fun/void74475.4 (lambda () (call L.fun/void74476.7)))
    (define L.fun/empty74480.5 (lambda () empty))
    (define L.fun/vector74482.6 (lambda () (call make-vector 8)))
    (define L.fun/void74476.7 (lambda () (void)))
    (define L.fun/empty74477.8 (lambda () (call L.fun/empty74478.11)))
    (define L.fun/error74474.9 (lambda () (error 213)))
    (define L.fun/empty74479.10 (lambda () (call L.fun/empty74480.5)))
    (define L.fun/empty74478.11 (lambda () empty))
    (define L.fun/error74473.12 (lambda () (call L.fun/error74474.9)))
    (define L.fun/vector74484.13 (lambda () (call make-vector 8)))
    (define L.fun/vector74483.14 (lambda () (call L.fun/vector74484.13)))
    (define L.fun/vector74481.15 (lambda () (call L.fun/vector74482.6)))
    (let ((error0.6 (call L.fun/error74473.12))
          (void1.5 (call L.fun/void74475.4))
          (empty2.4 (call L.fun/empty74477.8))
          (empty3.3 (call L.fun/empty74479.10))
          (vector4.2 (call L.fun/vector74481.15))
          (vector5.1 (call L.fun/vector74483.14)))
      (call
       *
       (call
        +
        (call * (call - 86 164) (call * 90 252))
        (call * (call + 29 248) (call - 226 99)))
       (call
        -
        (call + (call * 66 253) (call * 191 202))
        (call * (call + 123 10) (call - 81 116)))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char75589.4
      (lambda () (call L.fun/ascii-char75590.14)))
    (define L.fun/void75587.5 (lambda () (call L.fun/void75588.10)))
    (define L.fun/ascii-char75592.6
      (lambda () (call L.fun/ascii-char75593.11)))
    (define L.fun/any75591.7 (lambda () (call make-vector 8)))
    (define L.fun/void75597.8 (lambda () (void)))
    (define L.fun/error75595.9 (lambda () (error 219)))
    (define L.fun/void75588.10 (lambda () (void)))
    (define L.fun/ascii-char75593.11 (lambda () #\c))
    (define L.fun/vector75598.12 (lambda () (call L.fun/vector75599.15)))
    (define L.fun/error75594.13 (lambda () (call L.fun/error75595.9)))
    (define L.fun/ascii-char75590.14 (lambda () #\c))
    (define L.fun/vector75599.15 (lambda () (call make-vector 8)))
    (define L.fun/void75596.16 (lambda () (call L.fun/void75597.8)))
    (let ((void0.6 (call L.fun/void75587.5))
          (ascii-char1.5 (call L.fun/ascii-char75589.4))
          (boolean2.4 (call empty? (call L.fun/any75591.7)))
          (ascii-char3.3 (call L.fun/ascii-char75592.6))
          (error4.2 (call L.fun/error75594.13))
          (void5.1 (call L.fun/void75596.16)))
      (call L.fun/vector75598.12))))
(check-by-interp
 '(module
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
            -
            (call
             +
             (call + (call - 204 1) (call - 103 56))
             (call + (call - 210 1) (call * 239 154)))
            (call
             *
             (call + (call + 69 165) (call - 218 230))
             (call - (call - 218 137) (call * 210 51)))))
          (void1.5 (call L.fun/void75653.12))
          (empty2.4 (call L.fun/empty75655.11))
          (empty3.3 (call L.fun/empty75657.5))
          (ascii-char4.2 (call L.fun/ascii-char75659.13))
          (ascii-char5.1 (call L.fun/ascii-char75661.9)))
      ascii-char5.1)))
(check-by-interp
 '(module
    (define L.fun/error77430.4 (lambda () (call L.fun/error77431.12)))
    (define L.fun/void77433.5 (lambda () (void)))
    (define L.fun/ascii-char77434.6 (lambda () (call L.fun/ascii-char77435.8)))
    (define L.fun/void77427.7 (lambda () (call L.fun/void77428.9)))
    (define L.fun/ascii-char77435.8 (lambda () #\c))
    (define L.fun/void77428.9 (lambda () (void)))
    (define L.fun/any77429.10 (lambda () (call make-vector 8)))
    (define L.fun/void77432.11 (lambda () (call L.fun/void77433.5)))
    (define L.fun/error77431.12 (lambda () (error 166)))
    (let ((void0.6 (call L.fun/void77427.7))
          (boolean1.5 (call boolean? (call L.fun/any77429.10)))
          (error2.4 (call L.fun/error77430.4))
          (void3.3 (call L.fun/void77432.11))
          (fixnum4.2
           (call
            +
            (call
             *
             (call * (call * 39 195) (call * 163 111))
             (call * (call + 41 188) (call * 145 160)))
            (call
             +
             (call * (call * 86 83) (call - 90 133))
             (call * (call - 19 70) (call * 40 86)))))
          (ascii-char5.1 (call L.fun/ascii-char77434.6)))
      void0.6)))
(check-by-interp
 '(module
    (define L.fun/ascii-char79513.4 (lambda () (call L.fun/ascii-char79514.9)))
    (define L.fun/vector79512.5 (lambda () (call make-vector 8)))
    (define L.fun/empty79507.6 (lambda () (call L.fun/empty79508.7)))
    (define L.fun/empty79508.7 (lambda () empty))
    (define L.fun/vector79518.8 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char79514.9 (lambda () #\c))
    (define L.fun/vector79510.10 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char79516.11 (lambda () #\c))
    (define L.fun/vector79509.12 (lambda () (call L.fun/vector79510.10)))
    (define L.fun/ascii-char79515.13
      (lambda () (call L.fun/ascii-char79516.11)))
    (define L.fun/vector79517.14 (lambda () (call L.fun/vector79518.8)))
    (define L.fun/vector79511.15 (lambda () (call L.fun/vector79512.5)))
    (let ((empty0.6 (call L.fun/empty79507.6))
          (vector1.5 (call L.fun/vector79509.12))
          (vector2.4 (call L.fun/vector79511.15))
          (ascii-char3.3 (call L.fun/ascii-char79513.4))
          (ascii-char4.2 (call L.fun/ascii-char79515.13))
          (vector5.1 (call L.fun/vector79517.14)))
      (call
       *
       (call
        +
        (call - (call * 185 193) (call * 145 59))
        (call - (call * 184 67) (call - 86 23)))
       (call
        -
        (call + (call + 42 211) (call - 52 240))
        (call - (call - 85 26) (call - 177 134)))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char79834.4 (lambda () #\c))
    (define L.fun/error79839.5 (lambda () (error 220)))
    (define L.fun/error79838.6 (lambda () (call L.fun/error79839.5)))
    (define L.fun/any79832.7 (lambda () 99))
    (define L.fun/any79836.8 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char79831.9 (lambda () #\c))
    (define L.fun/any79835.10 (lambda () 182))
    (define L.fun/ascii-char79833.11
      (lambda () (call L.fun/ascii-char79834.4)))
    (define L.fun/ascii-char79830.12
      (lambda () (call L.fun/ascii-char79831.9)))
    (define L.fun/any79837.13 (lambda () empty))
    (let ((ascii-char0.6 (call L.fun/ascii-char79830.12))
          (boolean1.5 (call void? (call L.fun/any79832.7)))
          (ascii-char2.4 (call L.fun/ascii-char79833.11))
          (boolean3.3 (call empty? (call L.fun/any79835.10)))
          (boolean4.2 (call void? (call L.fun/any79836.8)))
          (boolean5.1 (call pair? (call L.fun/any79837.13))))
      (call L.fun/error79838.6))))
(check-by-interp
 '(module
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
          (boolean2.4 (call error? (call L.fun/any83232.11)))
          (empty3.3 (call L.fun/empty83233.5))
          (void4.2 (call L.fun/void83235.8))
          (fixnum5.1
           (call
            -
            (call
             *
             (call + (call - 9 227) (call * 168 55))
             (call * (call - 114 24) (call - 76 11)))
            (call
             +
             (call + (call + 179 17) (call + 103 123))
             (call * (call + 26 63) (call + 141 90))))))
      void4.2)))
(check-by-interp
 '(module
    (define L.fun/empty84384.4 (lambda () empty))
    (define L.fun/error84388.5 (lambda () (error 90)))
    (define L.fun/ascii-char84389.6
      (lambda () (call L.fun/ascii-char84390.10)))
    (define L.fun/empty84383.7 (lambda () (call L.fun/empty84384.4)))
    (define L.fun/any84380.8 (lambda () (call make-vector 8)))
    (define L.fun/empty84381.9 (lambda () (call L.fun/empty84382.12)))
    (define L.fun/ascii-char84390.10 (lambda () #\c))
    (define L.fun/error84386.11 (lambda () (error 86)))
    (define L.fun/empty84382.12 (lambda () empty))
    (define L.fun/error84387.13 (lambda () (call L.fun/error84388.5)))
    (define L.fun/error84385.14 (lambda () (call L.fun/error84386.11)))
    (let ((boolean0.6 (call boolean? (call L.fun/any84380.8)))
          (empty1.5 (call L.fun/empty84381.9))
          (empty2.4 (call L.fun/empty84383.7))
          (error3.3 (call L.fun/error84385.14))
          (fixnum4.2
           (call
            *
            (call
             *
             (call * (call * 44 103) (call - 70 90))
             (call + (call * 203 120) (call + 139 153)))
            (call
             -
             (call + (call - 225 26) (call - 242 76))
             (call - (call + 42 188) (call * 220 170)))))
          (error5.1 (call L.fun/error84387.13)))
      (call L.fun/ascii-char84389.6))))
(check-by-interp
 '(module
    (define L.fun/void86969.4 (lambda () (void)))
    (define L.fun/ascii-char86962.5
      (lambda () (call L.fun/ascii-char86963.11)))
    (define L.fun/empty86965.6 (lambda () empty))
    (define L.fun/void86968.7 (lambda () (call L.fun/void86969.4)))
    (define L.fun/empty86964.8 (lambda () (call L.fun/empty86965.6)))
    (define L.fun/vector86966.9 (lambda () (call L.fun/vector86967.10)))
    (define L.fun/vector86967.10 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char86963.11 (lambda () #\c))
    (let ((fixnum0.6
           (call
            -
            (call
             +
             (call + (call * 169 49) (call + 25 173))
             (call - (call * 176 103) (call + 239 118)))
            (call
             +
             (call * (call + 39 204) (call + 190 79))
             (call + (call * 251 119) (call * 53 97)))))
          (fixnum1.5
           (call
            *
            (call
             +
             (call - (call * 236 245) (call - 47 57))
             (call - (call + 182 205) (call + 101 102)))
            (call
             *
             (call - (call * 128 248) (call - 250 180))
             (call * (call - 113 243) (call * 251 222)))))
          (ascii-char2.4 (call L.fun/ascii-char86962.5))
          (empty3.3 (call L.fun/empty86964.8))
          (vector4.2 (call L.fun/vector86966.9))
          (void5.1 (call L.fun/void86968.7)))
      ascii-char2.4)))
(check-by-interp
 '(module
    (define L.fun/empty87544.4 (lambda () (call L.fun/empty87545.14)))
    (define L.fun/void87552.5 (lambda () (void)))
    (define L.fun/empty87549.6 (lambda () (call L.fun/empty87550.10)))
    (define L.fun/empty87546.7 (lambda () (call L.fun/empty87547.8)))
    (define L.fun/empty87547.8 (lambda () empty))
    (define L.fun/empty87553.9 (lambda () (call L.fun/empty87554.12)))
    (define L.fun/empty87550.10 (lambda () empty))
    (define L.fun/any87548.11 (lambda () (call make-vector 8)))
    (define L.fun/empty87554.12 (lambda () empty))
    (define L.fun/void87551.13 (lambda () (call L.fun/void87552.5)))
    (define L.fun/empty87545.14 (lambda () empty))
    (let ((empty0.6 (call L.fun/empty87544.4))
          (empty1.5 (call L.fun/empty87546.7))
          (boolean2.4 (call boolean? (call L.fun/any87548.11)))
          (empty3.3 (call L.fun/empty87549.6))
          (void4.2 (call L.fun/void87551.13))
          (empty5.1 (call L.fun/empty87553.9)))
      (call
       *
       (call
        *
        (call + (call - 27 102) (call + 69 23))
        (call * (call + 91 193) (call + 153 228)))
       (call
        +
        (call + (call - 42 164) (call + 23 220))
        (call * (call + 192 70) (call - 225 155)))))))
(check-by-interp
 '(module
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
          (boolean3.3 (call error? (call L.fun/any87927.11)))
          (ascii-char4.2 (call L.fun/ascii-char87928.6))
          (empty5.1 (call L.fun/empty87930.9)))
      empty5.1)))
(check-by-interp
 '(module
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
            +
            (call
             -
             (call - (call + 55 76) (call + 23 0))
             (call * (call + 18 21) (call + 153 181)))
            (call
             -
             (call - (call - 4 108) (call + 94 109))
             (call + (call - 239 239) (call * 213 98)))))
          (empty4.2 (call L.fun/empty88026.8))
          (error5.1 (call L.fun/error88028.13)))
      error0.6)))
(check-by-interp
 '(module
    (define L.fun/empty93911.4 (lambda () (call L.fun/empty93912.10)))
    (define L.fun/ascii-char93914.5 (lambda () #\c))
    (define L.fun/vector93909.6 (lambda () (call L.fun/vector93910.9)))
    (define L.fun/error93916.7 (lambda () (error 235)))
    (define L.fun/void93907.8 (lambda () (call L.fun/void93908.11)))
    (define L.fun/vector93910.9 (lambda () (call make-vector 8)))
    (define L.fun/empty93912.10 (lambda () empty))
    (define L.fun/void93908.11 (lambda () (void)))
    (define L.fun/ascii-char93913.12
      (lambda () (call L.fun/ascii-char93914.5)))
    (define L.fun/error93915.13 (lambda () (call L.fun/error93916.7)))
    (let ((void0.6 (call L.fun/void93907.8))
          (fixnum1.5
           (call
            -
            (call
             +
             (call * (call - 66 212) (call * 204 195))
             (call - (call + 22 227) (call * 138 73)))
            (call
             +
             (call + (call * 252 232) (call + 113 73))
             (call - (call * 186 15) (call + 74 53)))))
          (vector2.4 (call L.fun/vector93909.6))
          (empty3.3 (call L.fun/empty93911.4))
          (ascii-char4.2 (call L.fun/ascii-char93913.12))
          (fixnum5.1
           (call
            *
            (call
             +
             (call * (call - 198 170) (call * 76 157))
             (call - (call * 168 34) (call - 198 205)))
            (call
             +
             (call - (call * 160 27) (call - 67 125))
             (call - (call * 114 203) (call * 181 159))))))
      (call L.fun/error93915.13))))
(check-by-interp
 '(module
    (define L.fun/vector95234.4 (lambda () (call make-vector 8)))
    (define L.fun/vector95231.5 (lambda () (call L.fun/vector95232.9)))
    (define L.fun/vector95236.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char95237.7 (lambda () (call L.fun/ascii-char95238.8)))
    (define L.fun/ascii-char95238.8 (lambda () #\c))
    (define L.fun/vector95232.9 (lambda () (call make-vector 8)))
    (define L.fun/vector95233.10 (lambda () (call L.fun/vector95234.4)))
    (define L.fun/vector95235.11 (lambda () (call L.fun/vector95236.6)))
    (let ((vector0.6 (call L.fun/vector95231.5))
          (vector1.5 (call L.fun/vector95233.10))
          (vector2.4 (call L.fun/vector95235.11))
          (ascii-char3.3 (call L.fun/ascii-char95237.7))
          (fixnum4.2
           (call
            +
            (call
             +
             (call + (call * 155 194) (call * 34 231))
             (call - (call - 241 3) (call - 0 115)))
            (call
             +
             (call - (call + 38 231) (call - 80 215))
             (call * (call * 102 25) (call + 200 254)))))
          (fixnum5.1
           (call
            *
            (call
             *
             (call - (call + 39 190) (call * 29 254))
             (call - (call - 184 109) (call + 241 136)))
            (call
             *
             (call - (call * 238 178) (call * 253 125))
             (call + (call * 75 103) (call * 154 185))))))
      fixnum5.1)))
(check-by-interp
 '(module
    (define L.fun/ascii-char95245.4 (lambda () #\c))
    (define L.fun/empty95247.5 (lambda () empty))
    (define L.fun/void95242.6 (lambda () (void)))
    (define L.fun/void95241.7 (lambda () (call L.fun/void95242.6)))
    (define L.fun/any95243.8 (lambda () (void)))
    (define L.fun/ascii-char95244.9 (lambda () (call L.fun/ascii-char95245.4)))
    (define L.fun/empty95246.10 (lambda () (call L.fun/empty95247.5)))
    (let ((void0.6 (call L.fun/void95241.7))
          (boolean1.5 (call pair? (call L.fun/any95243.8)))
          (ascii-char2.4 (call L.fun/ascii-char95244.9))
          (fixnum3.3
           (call
            *
            (call
             -
             (call - (call - 42 241) (call * 97 238))
             (call - (call * 215 47) (call * 114 32)))
            (call
             *
             (call * (call - 17 175) (call - 184 206))
             (call + (call - 155 66) (call + 150 91)))))
          (empty4.2 (call L.fun/empty95246.10))
          (fixnum5.1
           (call
            -
            (call
             +
             (call * (call - 21 171) (call + 171 175))
             (call * (call * 87 9) (call * 202 16)))
            (call
             -
             (call * (call + 45 112) (call * 246 184))
             (call * (call + 170 142) (call * 137 91))))))
      ascii-char2.4)))
(check-by-interp
 '(module
    (define L.fun/vector99282.4 (lambda () (call L.fun/vector99283.13)))
    (define L.fun/ascii-char99281.5 (lambda () #\c))
    (define L.fun/ascii-char99280.6 (lambda () (call L.fun/ascii-char99281.5)))
    (define L.fun/vector99275.7 (lambda () (call make-vector 8)))
    (define L.fun/error99284.8 (lambda () (call L.fun/error99285.15)))
    (define L.fun/empty99277.9 (lambda () empty))
    (define L.fun/empty99276.10 (lambda () (call L.fun/empty99277.9)))
    (define L.fun/empty99278.11 (lambda () (call L.fun/empty99279.12)))
    (define L.fun/empty99279.12 (lambda () empty))
    (define L.fun/vector99283.13 (lambda () (call make-vector 8)))
    (define L.fun/vector99274.14 (lambda () (call L.fun/vector99275.7)))
    (define L.fun/error99285.15 (lambda () (error 160)))
    (let ((vector0.6 (call L.fun/vector99274.14))
          (empty1.5 (call L.fun/empty99276.10))
          (empty2.4 (call L.fun/empty99278.11))
          (ascii-char3.3 (call L.fun/ascii-char99280.6))
          (vector4.2 (call L.fun/vector99282.4))
          (error5.1 (call L.fun/error99284.8)))
      ascii-char3.3)))
(check-by-interp
 '(module
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
            +
            (call
             +
             (call + (call - 129 90) (call - 171 196))
             (call - (call * 72 119) (call * 14 122)))
            (call
             +
             (call * (call * 213 131) (call + 91 2))
             (call * (call + 98 134) (call * 207 144)))))
          (ascii-char2.4 (call L.fun/ascii-char101001.13))
          (void3.3 (call L.fun/void101003.11))
          (void4.2 (call L.fun/void101005.5))
          (ascii-char5.1 (call L.fun/ascii-char101007.6)))
      ascii-char5.1)))
(check-by-interp
 '(module
    (define L.fun/void102209.4 (lambda () (void)))
    (define L.fun/any102211.5 (lambda () #t))
    (define L.fun/empty102210.6 (lambda () empty))
    (define L.fun/error102205.7 (lambda () (error 4)))
    (define L.fun/ascii-char102208.8 (lambda () #\c))
    (define L.fun/ascii-char102207.9 (lambda () #\c))
    (define L.fun/vector102206.10 (lambda () (call make-vector 8)))
    (call
     boolean?
     (let ((error0.6 (call L.fun/error102205.7))
           (vector1.5 (call L.fun/vector102206.10))
           (ascii-char2.4 (call L.fun/ascii-char102207.9))
           (ascii-char3.3 (call L.fun/ascii-char102208.8))
           (void4.2 (call L.fun/void102209.4))
           (empty5.1 (call L.fun/empty102210.6)))
       (call L.fun/any102211.5)))))
(check-by-interp
 '(module
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
            -
            (call
             +
             (call * (call * 211 23) (call * 149 117))
             (call * (call * 158 242) (call * 82 246)))
            (call
             -
             (call * (call * 79 157) (call + 182 65))
             (call + (call * 71 229) (call - 209 3)))))
          (ascii-char5.1 (call L.fun/ascii-char102222.12)))
      error3.3)))
(check-by-interp
 '(module
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
          (boolean2.4 (call vector? (call L.fun/any102238.5)))
          (ascii-char3.3 (call L.fun/ascii-char102239.8))
          (void4.2 (call L.fun/void102241.7))
          (void5.1 (call L.fun/void102243.4)))
      (call
       *
       (call
        *
        (call * (call + 231 129) (call + 61 136))
        (call * (call - 180 33) (call + 247 156)))
       (call
        -
        (call - (call + 238 202) (call + 72 39))
        (call - (call + 98 175) (call * 74 242)))))))
(check-by-interp
 '(module
    (define L.fun/error102248.4 (lambda () (error 56)))
    (define L.fun/empty102249.5 (lambda () (call L.fun/empty102250.10)))
    (define L.fun/void102254.6 (lambda () (void)))
    (define L.fun/void102253.7 (lambda () (call L.fun/void102254.6)))
    (define L.fun/error102247.8 (lambda () (call L.fun/error102248.4)))
    (define L.fun/vector102252.9 (lambda () (call make-vector 8)))
    (define L.fun/empty102250.10 (lambda () empty))
    (define L.fun/vector102251.11 (lambda () (call L.fun/vector102252.9)))
    (let ((error0.6 (call L.fun/error102247.8))
          (empty1.5 (call L.fun/empty102249.5))
          (vector2.4 (call L.fun/vector102251.11))
          (void3.3 (call L.fun/void102253.7))
          (fixnum4.2
           (call
            *
            (call
             *
             (call * (call - 36 132) (call * 82 113))
             (call - (call + 15 106) (call - 143 195)))
            (call
             *
             (call - (call + 17 74) (call + 187 26))
             (call - (call - 63 26) (call + 26 114)))))
          (fixnum5.1
           (call
            -
            (call
             *
             (call - (call - 180 103) (call + 244 55))
             (call + (call + 152 100) (call + 169 55)))
            (call
             +
             (call - (call + 58 132) (call + 241 8))
             (call + (call * 98 168) (call - 132 132))))))
      (call
       -
       (call + (call + (call - 238 43) (call * 221 81)) fixnum4.2)
       (call - (call * (call - 214 78) fixnum5.1) fixnum5.1)))))
(check-by-interp
 '(module
    (define L.fun/ascii-char102449.4
      (lambda () (call L.fun/ascii-char102450.5)))
    (define L.fun/ascii-char102450.5 (lambda () #\c))
    (define L.fun/ascii-char102444.6 (lambda () #\c))
    (define L.fun/vector102446.7 (lambda () (call make-vector 8)))
    (define L.fun/void102447.8 (lambda () (call L.fun/void102448.11)))
    (define L.fun/ascii-char102443.9
      (lambda () (call L.fun/ascii-char102444.6)))
    (define L.fun/vector102445.10 (lambda () (call L.fun/vector102446.7)))
    (define L.fun/void102448.11 (lambda () (void)))
    (let ((fixnum0.6
           (call
            *
            (call
             +
             (call - (call - 104 92) (call * 1 181))
             (call - (call + 23 154) (call - 51 198)))
            (call
             -
             (call - (call - 178 89) (call * 231 204))
             (call * (call - 108 6) (call - 107 84)))))
          (ascii-char1.5 (call L.fun/ascii-char102443.9))
          (vector2.4 (call L.fun/vector102445.10))
          (void3.3 (call L.fun/void102447.8))
          (fixnum4.2
           (call
            -
            (call
             +
             (call * (call + 76 147) (call * 120 83))
             (call * (call * 126 195) (call * 44 78)))
            (call
             +
             (call * (call + 55 220) (call - 30 22))
             (call - (call - 211 86) (call - 174 50)))))
          (ascii-char5.1 (call L.fun/ascii-char102449.4)))
      ascii-char5.1)))
(check-by-interp
 '(module
    (define L.fun/void102461.4 (lambda () (call L.fun/void102462.11)))
    (define L.fun/void102455.5 (lambda () (call L.fun/void102456.9)))
    (define L.fun/ascii-char102454.6 (lambda () #\c))
    (define L.fun/void102460.7 (lambda () (void)))
    (define L.fun/ascii-char102453.8
      (lambda () (call L.fun/ascii-char102454.6)))
    (define L.fun/void102456.9 (lambda () (void)))
    (define L.fun/vector102464.10 (lambda () (call make-vector 8)))
    (define L.fun/void102462.11 (lambda () (void)))
    (define L.fun/void102459.12 (lambda () (call L.fun/void102460.7)))
    (define L.fun/error102457.13 (lambda () (call L.fun/error102458.14)))
    (define L.fun/error102458.14 (lambda () (error 23)))
    (define L.fun/vector102463.15 (lambda () (call L.fun/vector102464.10)))
    (let ((ascii-char0.6 (call L.fun/ascii-char102453.8))
          (fixnum1.5
           (call
            +
            (call
             +
             (call * (call - 221 25) (call - 199 50))
             (call + (call + 196 206) (call - 226 147)))
            (call
             *
             (call - (call + 14 42) (call * 252 166))
             (call * (call * 133 247) (call - 216 194)))))
          (void2.4 (call L.fun/void102455.5))
          (error3.3 (call L.fun/error102457.13))
          (void4.2 (call L.fun/void102459.12))
          (void5.1 (call L.fun/void102461.4)))
      (call L.fun/vector102463.15))))
(check-by-interp
 '(module
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
            *
            (call
             *
             (call - (call * 135 123) (call * 16 197))
             (call * (call - 168 72) (call * 104 70)))
            (call
             *
             (call - (call + 178 71) (call + 189 97))
             (call + (call * 26 168) (call - 76 162)))))
          (empty5.1 (call L.fun/empty104403.15)))
      (call L.fun/error104405.9))))
(check-by-interp
 '(module
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
          (boolean3.3 (call boolean? (call L.fun/any105578.4)))
          (error4.2 (call L.fun/error105579.5))
          (void5.1 (call L.fun/void105581.10)))
      void5.1)))
(check-by-interp
 '(module
    (define L.fun/void106112.4 (lambda () (void)))
    (define L.fun/empty106104.5 (lambda () (call L.fun/empty106105.8)))
    (define L.fun/any106110.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char106108.7
      (lambda () (call L.fun/ascii-char106109.10)))
    (define L.fun/empty106105.8 (lambda () empty))
    (define L.fun/error106115.9 (lambda () (error 39)))
    (define L.fun/ascii-char106109.10 (lambda () #\c))
    (define L.fun/empty106107.11 (lambda () empty))
    (define L.fun/void106111.12 (lambda () (call L.fun/void106112.4)))
    (define L.fun/empty106106.13 (lambda () (call L.fun/empty106107.11)))
    (define L.fun/error106114.14 (lambda () (call L.fun/error106115.9)))
    (define L.fun/any106113.15 (lambda () #\c))
    (let ((empty0.6 (call L.fun/empty106104.5))
          (empty1.5 (call L.fun/empty106106.13))
          (ascii-char2.4 (call L.fun/ascii-char106108.7))
          (boolean3.3 (call vector? (call L.fun/any106110.6)))
          (void4.2 (call L.fun/void106111.12))
          (boolean5.1 (call empty? (call L.fun/any106113.15))))
      (call L.fun/error106114.14))))
(check-by-interp
 '(module
    (define L.fun/empty106693.4 (lambda () empty))
    (define L.fun/vector106699.5 (lambda () (call make-vector 8)))
    (define L.fun/error106696.6 (lambda () (call L.fun/error106697.11)))
    (define L.fun/void106690.7 (lambda () (call L.fun/void106691.13)))
    (define L.fun/empty106694.8 (lambda () (call L.fun/empty106695.14)))
    (define L.fun/error106688.9 (lambda () (call L.fun/error106689.10)))
    (define L.fun/error106689.10 (lambda () (error 170)))
    (define L.fun/error106697.11 (lambda () (error 2)))
    (define L.fun/empty106692.12 (lambda () (call L.fun/empty106693.4)))
    (define L.fun/void106691.13 (lambda () (void)))
    (define L.fun/empty106695.14 (lambda () empty))
    (define L.fun/vector106698.15 (lambda () (call L.fun/vector106699.5)))
    (let ((error0.6 (call L.fun/error106688.9))
          (void1.5 (call L.fun/void106690.7))
          (empty2.4 (call L.fun/empty106692.12))
          (empty3.3 (call L.fun/empty106694.8))
          (error4.2 (call L.fun/error106696.6))
          (vector5.1 (call L.fun/vector106698.15)))
      empty3.3)))
(check-by-interp
 '(module
    (define L.fun/void111190.4 (lambda () (call L.fun/void111191.11)))
    (define L.fun/empty111194.5 (lambda () (call L.fun/empty111195.8)))
    (define L.fun/vector111192.6 (lambda () (call L.fun/vector111193.9)))
    (define L.fun/ascii-char111196.7
      (lambda () (call L.fun/ascii-char111197.12)))
    (define L.fun/empty111195.8 (lambda () empty))
    (define L.fun/vector111193.9 (lambda () (call make-vector 8)))
    (define L.fun/void111188.10 (lambda () (call L.fun/void111189.14)))
    (define L.fun/void111191.11 (lambda () (void)))
    (define L.fun/ascii-char111197.12 (lambda () #\c))
    (define L.fun/any111187.13 (lambda () 181))
    (define L.fun/void111189.14 (lambda () (void)))
    (let ((boolean0.6 (call boolean? (call L.fun/any111187.13)))
          (void1.5 (call L.fun/void111188.10))
          (void2.4 (call L.fun/void111190.4))
          (vector3.3 (call L.fun/vector111192.6))
          (empty4.2 (call L.fun/empty111194.5))
          (ascii-char5.1 (call L.fun/ascii-char111196.7)))
      void2.4)))
(check-by-interp
 '(module
    (define L.fun/empty114056.4 (lambda () (call L.fun/empty114057.10)))
    (define L.fun/vector114061.5 (lambda () (call make-vector 8)))
    (define L.fun/error114058.6 (lambda () (call L.fun/error114059.9)))
    (define L.fun/vector114060.7 (lambda () (call L.fun/vector114061.5)))
    (define L.fun/void114055.8 (lambda () (void)))
    (define L.fun/error114059.9 (lambda () (error 240)))
    (define L.fun/empty114057.10 (lambda () empty))
    (define L.fun/any114062.11 (lambda () (error 13)))
    (define L.fun/ascii-char114064.12 (lambda () #\c))
    (define L.fun/ascii-char114063.13
      (lambda () (call L.fun/ascii-char114064.12)))
    (define L.fun/void114054.14 (lambda () (call L.fun/void114055.8)))
    (let ((void0.6 (call L.fun/void114054.14))
          (empty1.5 (call L.fun/empty114056.4))
          (fixnum2.4
           (call
            +
            (call
             +
             (call * (call + 20 152) (call + 87 56))
             (call * (call + 37 69) (call * 82 15)))
            (call
             +
             (call + (call - 141 18) (call * 112 127))
             (call + (call + 100 212) (call + 101 145)))))
          (error3.3 (call L.fun/error114058.6))
          (vector4.2 (call L.fun/vector114060.7))
          (boolean5.1 (call void? (call L.fun/any114062.11))))
      (call L.fun/ascii-char114063.13))))
(check-by-interp
 '(module
    (define L.fun/empty114977.4 (lambda () empty))
    (define L.fun/error114968.5 (lambda () (call L.fun/error114969.12)))
    (define L.fun/ascii-char114974.6
      (lambda () (call L.fun/ascii-char114975.7)))
    (define L.fun/ascii-char114975.7 (lambda () #\c))
    (define L.fun/void114971.8 (lambda () (void)))
    (define L.fun/void114970.9 (lambda () (call L.fun/void114971.8)))
    (define L.fun/vector114973.10 (lambda () (call make-vector 8)))
    (define L.fun/vector114972.11 (lambda () (call L.fun/vector114973.10)))
    (define L.fun/error114969.12 (lambda () (error 15)))
    (define L.fun/empty114976.13 (lambda () (call L.fun/empty114977.4)))
    (let ((error0.6 (call L.fun/error114968.5))
          (void1.5 (call L.fun/void114970.9))
          (vector2.4 (call L.fun/vector114972.11))
          (fixnum3.3
           (call
            -
            (call
             *
             (call - (call * 79 208) (call + 214 9))
             (call - (call + 160 2) (call + 9 241)))
            (call
             -
             (call + (call - 71 14) (call * 74 96))
             (call * (call - 115 51) (call + 4 100)))))
          (ascii-char4.2 (call L.fun/ascii-char114974.6))
          (empty5.1 (call L.fun/empty114976.13)))
      (call
       +
       (call
        +
        (call + (call + fixnum3.3 103) (call - 185 fixnum3.3))
        (call - (call - 194 8) (call * 162 95)))
       fixnum3.3))))
(check-by-interp
 '(module
    (define L.fun/empty115317.4 (lambda () empty))
    (define L.fun/ascii-char115313.5
      (lambda () (call L.fun/ascii-char115314.7)))
    (define L.fun/vector115319.6 (lambda () (call L.fun/vector115320.8)))
    (define L.fun/ascii-char115314.7 (lambda () #\c))
    (define L.fun/vector115320.8 (lambda () (call make-vector 8)))
    (define L.fun/any115318.9 (lambda () (call make-vector 8)))
    (define L.fun/any115315.10 (lambda () (void)))
    (define L.fun/empty115316.11 (lambda () (call L.fun/empty115317.4)))
    (let ((fixnum0.6
           (call
            *
            (call
             +
             (call - (call * 160 241) (call + 112 155))
             (call + (call + 117 81) (call * 187 118)))
            (call
             +
             (call - (call + 146 115) (call * 82 81))
             (call + (call + 235 36) (call - 129 72)))))
          (ascii-char1.5 (call L.fun/ascii-char115313.5))
          (fixnum2.4
           (call
            -
            (call
             -
             (call * (call + 152 173) (call - 199 182))
             (call - (call - 169 197) (call + 247 220)))
            (call
             -
             (call + (call * 185 70) (call + 17 210))
             (call * (call + 175 15) (call - 195 44)))))
          (boolean3.3 (call fixnum? (call L.fun/any115315.10)))
          (empty4.2 (call L.fun/empty115316.11))
          (boolean5.1 (call ascii-char? (call L.fun/any115318.9))))
      (call L.fun/vector115319.6))))
(check-by-interp
 '(module
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
    (let ((boolean0.6 (call ascii-char? (call L.fun/any121809.14)))
          (ascii-char1.5 (call L.fun/ascii-char121810.13))
          (void2.4 (call L.fun/void121812.8))
          (void3.3 (call L.fun/void121814.6))
          (ascii-char4.2 (call L.fun/ascii-char121816.7))
          (ascii-char5.1 (call L.fun/ascii-char121818.5)))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.fun/empty122991.4 (lambda () (call L.fun/empty122992.11)))
    (define L.fun/error122990.5 (lambda () (error 197)))
    (define L.fun/vector122986.6 (lambda () (call make-vector 8)))
    (define L.fun/void122983.7 (lambda () (call L.fun/void122984.12)))
    (define L.fun/empty122987.8 (lambda () (call L.fun/empty122988.13)))
    (define L.fun/vector122985.9 (lambda () (call L.fun/vector122986.6)))
    (define L.fun/error122989.10 (lambda () (call L.fun/error122990.5)))
    (define L.fun/empty122992.11 (lambda () empty))
    (define L.fun/void122984.12 (lambda () (void)))
    (define L.fun/empty122988.13 (lambda () empty))
    (let ((void0.6 (call L.fun/void122983.7))
          (vector1.5 (call L.fun/vector122985.9))
          (empty2.4 (call L.fun/empty122987.8))
          (error3.3 (call L.fun/error122989.10))
          (empty4.2 (call L.fun/empty122991.4))
          (fixnum5.1
           (call
            -
            (call
             +
             (call - (call * 215 176) (call * 168 192))
             (call - (call - 54 209) (call + 70 157)))
            (call
             -
             (call + (call - 169 165) (call + 117 156))
             (call + (call * 108 112) (call * 197 55))))))
      void0.6)))
(check-by-interp
 '(module
    (define L.fun/vector123184.4 (lambda () (call make-vector 8)))
    (define L.fun/vector123183.5 (lambda () (call L.fun/vector123184.4)))
    (define L.fun/ascii-char123186.6 (lambda () #\c))
    (define L.fun/void123179.7 (lambda () (call L.fun/void123180.10)))
    (define L.fun/void123182.8 (lambda () (void)))
    (define L.fun/ascii-char123185.9
      (lambda () (call L.fun/ascii-char123186.6)))
    (define L.fun/void123180.10 (lambda () (void)))
    (define L.fun/void123181.11 (lambda () (call L.fun/void123182.8)))
    (let ((void0.6 (call L.fun/void123179.7))
          (void1.5 (call L.fun/void123181.11))
          (fixnum2.4
           (call
            -
            (call
             +
             (call + (call + 183 95) (call + 212 140))
             (call - (call + 84 213) (call - 109 229)))
            (call
             *
             (call * (call * 133 28) (call + 80 26))
             (call * (call * 38 207) (call - 151 9)))))
          (vector3.3 (call L.fun/vector123183.5))
          (ascii-char4.2 (call L.fun/ascii-char123185.9))
          (fixnum5.1
           (call
            -
            (call
             -
             (call * (call * 79 42) (call + 32 173))
             (call - (call + 36 205) (call * 20 171)))
            (call
             +
             (call * (call + 237 64) (call - 83 231))
             (call + (call - 22 56) (call - 34 254))))))
      (call
       -
       fixnum5.1
       (call
        *
        (call + (call * 53 46) (call * 95 fixnum5.1))
        (call * (call * fixnum5.1 111) (call - fixnum5.1 147)))))))
(check-by-interp
 '(module
    (define L.fun/ascii-char124852.4
      (lambda () (call L.fun/ascii-char124853.11)))
    (define L.fun/vector124858.5 (lambda () (call L.fun/vector124859.10)))
    (define L.fun/error124850.6 (lambda () (call L.fun/error124851.9)))
    (define L.fun/void124857.7 (lambda () (void)))
    (define L.fun/empty124854.8 (lambda () (call L.fun/empty124855.12)))
    (define L.fun/error124851.9 (lambda () (error 183)))
    (define L.fun/vector124859.10 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char124853.11 (lambda () #\c))
    (define L.fun/empty124855.12 (lambda () empty))
    (define L.fun/void124856.13 (lambda () (call L.fun/void124857.7)))
    (let ((error0.6 (call L.fun/error124850.6))
          (ascii-char1.5 (call L.fun/ascii-char124852.4))
          (fixnum2.4
           (call
            +
            (call
             +
             (call * (call + 15 183) (call + 254 4))
             (call * (call * 137 109) (call + 112 6)))
            (call
             +
             (call - (call * 113 86) (call + 246 47))
             (call + (call + 182 136) (call + 240 41)))))
          (empty3.3 (call L.fun/empty124854.8))
          (void4.2 (call L.fun/void124856.13))
          (vector5.1 (call L.fun/vector124858.5)))
      (call - fixnum2.4 fixnum2.4))))
(check-by-interp
 '(module
    (define L.fun/empty126141.4 (lambda () empty))
    (define L.fun/vector126136.5 (lambda () (call L.fun/vector126137.9)))
    (define L.fun/ascii-char126144.6
      (lambda () (call L.fun/ascii-char126145.11)))
    (define L.fun/vector126138.7 (lambda () (call L.fun/vector126139.15)))
    (define L.fun/ascii-char126147.8 (lambda () #\c))
    (define L.fun/vector126137.9 (lambda () (call make-vector 8)))
    (define L.fun/empty126140.10 (lambda () (call L.fun/empty126141.4)))
    (define L.fun/ascii-char126145.11 (lambda () #\c))
    (define L.fun/void126142.12 (lambda () (call L.fun/void126143.13)))
    (define L.fun/void126143.13 (lambda () (void)))
    (define L.fun/ascii-char126146.14
      (lambda () (call L.fun/ascii-char126147.8)))
    (define L.fun/vector126139.15 (lambda () (call make-vector 8)))
    (let ((vector0.6 (call L.fun/vector126136.5))
          (vector1.5 (call L.fun/vector126138.7))
          (empty2.4 (call L.fun/empty126140.10))
          (void3.3 (call L.fun/void126142.12))
          (ascii-char4.2 (call L.fun/ascii-char126144.6))
          (ascii-char5.1 (call L.fun/ascii-char126146.14)))
      vector1.5)))
(check-by-interp
 '(module
    (define L.fun/empty127626.4 (lambda () empty))
    (define L.fun/ascii-char127627.5
      (lambda () (call L.fun/ascii-char127628.7)))
    (define L.fun/vector127623.6 (lambda () (call L.fun/vector127624.8)))
    (define L.fun/ascii-char127628.7 (lambda () #\c))
    (define L.fun/vector127624.8 (lambda () (call make-vector 8)))
    (define L.fun/empty127625.9 (lambda () (call L.fun/empty127626.4)))
    (define L.fun/any127629.10 (lambda () 22))
    (let ((vector0.6 (call L.fun/vector127623.6))
          (empty1.5 (call L.fun/empty127625.9))
          (ascii-char2.4 (call L.fun/ascii-char127627.5))
          (fixnum3.3
           (call
            -
            (call
             +
             (call + (call + 46 234) (call + 220 110))
             (call + (call * 228 184) (call - 198 220)))
            (call
             +
             (call + (call + 118 36) (call + 45 51))
             (call + (call + 140 183) (call - 107 188)))))
          (fixnum4.2
           (call
            *
            (call
             -
             (call - (call - 95 144) (call - 128 32))
             (call - (call + 8 174) (call + 192 174)))
            (call
             *
             (call + (call * 248 135) (call * 225 210))
             (call + (call - 28 213) (call - 159 154)))))
          (boolean5.1 (call void? (call L.fun/any127629.10))))
      empty1.5)))
(check-by-interp
 '(module
    (define L.fun/error127697.4 (lambda () (error 97)))
    (define L.fun/empty127695.5 (lambda () empty))
    (define L.fun/vector127702.6 (lambda () (call L.fun/vector127703.12)))
    (define L.fun/empty127699.7 (lambda () empty))
    (define L.fun/vector127701.8 (lambda () (call make-vector 8)))
    (define L.fun/empty127698.9 (lambda () (call L.fun/empty127699.7)))
    (define L.fun/empty127694.10 (lambda () (call L.fun/empty127695.5)))
    (define L.fun/any127693.11 (lambda () (void)))
    (define L.fun/vector127703.12 (lambda () (call make-vector 8)))
    (define L.fun/vector127700.13 (lambda () (call L.fun/vector127701.8)))
    (define L.fun/error127696.14 (lambda () (call L.fun/error127697.4)))
    (let ((boolean0.6 (call boolean? (call L.fun/any127693.11)))
          (empty1.5 (call L.fun/empty127694.10))
          (error2.4 (call L.fun/error127696.14))
          (empty3.3 (call L.fun/empty127698.9))
          (vector4.2 (call L.fun/vector127700.13))
          (vector5.1 (call L.fun/vector127702.6)))
      empty3.3)))
(check-by-interp
 '(module
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
            -
            (call
             *
             (call * (call - 164 143) (call * 135 252))
             (call * (call + 5 173) (call * 234 229)))
            (call
             *
             (call * (call - 126 33) (call - 172 119))
             (call * (call - 172 58) (call - 97 82)))))
          (empty1.5 (call L.fun/empty128001.7))
          (void2.4 (call L.fun/void128003.11))
          (error3.3 (call L.fun/error128005.4))
          (fixnum4.2
           (call
            -
            (call
             +
             (call * (call * 102 116) (call + 216 103))
             (call * (call + 185 217) (call * 227 97)))
            (call
             -
             (call - (call + 159 138) (call - 239 158))
             (call * (call - 246 106) (call - 195 1)))))
          (empty5.1 (call L.fun/empty128007.10)))
      empty5.1)))
(check-by-interp
 '(module
    (define L.fun/vector129065.4 (lambda () (call L.fun/vector129066.10)))
    (define L.fun/void129062.5 (lambda () (void)))
    (define L.fun/error129060.6 (lambda () (error 246)))
    (define L.fun/ascii-char129058.7 (lambda () #\c))
    (define L.fun/empty129067.8 (lambda () (call L.fun/empty129068.12)))
    (define L.fun/void129061.9 (lambda () (call L.fun/void129062.5)))
    (define L.fun/vector129066.10 (lambda () (call make-vector 8)))
    (define L.fun/empty129063.11 (lambda () (call L.fun/empty129064.13)))
    (define L.fun/empty129068.12 (lambda () empty))
    (define L.fun/empty129064.13 (lambda () empty))
    (define L.fun/error129059.14 (lambda () (call L.fun/error129060.6)))
    (define L.fun/ascii-char129057.15
      (lambda () (call L.fun/ascii-char129058.7)))
    (let ((ascii-char0.6 (call L.fun/ascii-char129057.15))
          (error1.5 (call L.fun/error129059.14))
          (void2.4 (call L.fun/void129061.9))
          (empty3.3 (call L.fun/empty129063.11))
          (vector4.2 (call L.fun/vector129065.4))
          (empty5.1 (call L.fun/empty129067.8)))
      ascii-char0.6)))
(check-by-interp
 '(module
    (define L.fun/ascii-char129307.4 (lambda () #\c))
    (define L.fun/vector129308.5 (lambda () (call L.fun/vector129309.9)))
    (define L.fun/empty129300.6 (lambda () (call L.fun/empty129301.12)))
    (define L.fun/ascii-char129302.7
      (lambda () (call L.fun/ascii-char129303.13)))
    (define L.fun/void129305.8 (lambda () (void)))
    (define L.fun/vector129309.9 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char129306.10
      (lambda () (call L.fun/ascii-char129307.4)))
    (define L.fun/void129304.11 (lambda () (call L.fun/void129305.8)))
    (define L.fun/empty129301.12 (lambda () empty))
    (define L.fun/ascii-char129303.13 (lambda () #\c))
    (let ((fixnum0.6
           (call
            -
            (call
             -
             (call * (call + 139 125) (call * 7 144))
             (call - (call * 225 67) (call * 21 252)))
            (call
             +
             (call * (call + 29 246) (call * 88 21))
             (call + (call * 81 119) (call - 243 116)))))
          (empty1.5 (call L.fun/empty129300.6))
          (ascii-char2.4 (call L.fun/ascii-char129302.7))
          (void3.3 (call L.fun/void129304.11))
          (ascii-char4.2 (call L.fun/ascii-char129306.10))
          (fixnum5.1
           (call
            *
            (call
             -
             (call - (call * 95 128) (call - 3 138))
             (call - (call - 69 85) (call + 18 28)))
            (call
             -
             (call - (call - 62 108) (call * 51 71))
             (call + (call * 60 96) (call + 74 119))))))
      (call L.fun/vector129308.5))))
(check-by-interp
 '(module
    (define L.fun/ascii-char129869.4
      (lambda () (call L.fun/ascii-char129870.13)))
    (define L.fun/void129872.5 (lambda () (void)))
    (define L.fun/vector129866.6 (lambda () (call make-vector 8)))
    (define L.fun/void129868.7 (lambda () (void)))
    (define L.fun/empty129864.8 (lambda () empty))
    (define L.fun/error129874.9 (lambda () (error 213)))
    (define L.fun/void129871.10 (lambda () (call L.fun/void129872.5)))
    (define L.fun/error129873.11 (lambda () (call L.fun/error129874.9)))
    (define L.fun/void129867.12 (lambda () (call L.fun/void129868.7)))
    (define L.fun/ascii-char129870.13 (lambda () #\c))
    (define L.fun/empty129863.14 (lambda () (call L.fun/empty129864.8)))
    (define L.fun/vector129865.15 (lambda () (call L.fun/vector129866.6)))
    (let ((fixnum0.6
           (call
            *
            (call
             +
             (call + (call - 65 131) (call * 42 115))
             (call * (call - 211 252) (call + 30 130)))
            (call
             +
             (call * (call + 60 132) (call * 239 99))
             (call * (call + 160 150) (call + 217 164)))))
          (empty1.5 (call L.fun/empty129863.14))
          (vector2.4 (call L.fun/vector129865.15))
          (void3.3 (call L.fun/void129867.12))
          (ascii-char4.2 (call L.fun/ascii-char129869.4))
          (void5.1 (call L.fun/void129871.10)))
      (call L.fun/error129873.11))))
(check-by-interp
 '(module
    (define L.fun/vector136061.4 (lambda () (call make-vector 8)))
    (define L.fun/vector136057.5 (lambda () (call L.fun/vector136058.13)))
    (define L.fun/vector136053.6 (lambda () (call L.fun/vector136054.9)))
    (define L.fun/empty136063.7 (lambda () empty))
    (define L.fun/void136055.8 (lambda () (call L.fun/void136056.12)))
    (define L.fun/vector136054.9 (lambda () (call make-vector 8)))
    (define L.fun/empty136062.10 (lambda () (call L.fun/empty136063.7)))
    (define L.fun/vector136060.11 (lambda () (call L.fun/vector136061.4)))
    (define L.fun/void136056.12 (lambda () (void)))
    (define L.fun/vector136058.13 (lambda () (call make-vector 8)))
    (define L.fun/any136059.14 (lambda () (call make-vector 8)))
    (let ((vector0.6 (call L.fun/vector136053.6))
          (void1.5 (call L.fun/void136055.8))
          (vector2.4 (call L.fun/vector136057.5))
          (boolean3.3 (call boolean? (call L.fun/any136059.14)))
          (fixnum4.2
           (call
            +
            (call
             +
             (call * (call - 130 188) (call - 140 177))
             (call + (call * 183 136) (call + 81 250)))
            (call
             *
             (call - (call + 63 21) (call - 38 190))
             (call - (call + 53 132) (call - 200 218)))))
          (vector5.1 (call L.fun/vector136060.11)))
      (call L.fun/empty136062.10))))
(check-by-interp
 '(module
    (define L.fun/ascii-char136498.4 (lambda () #\c))
    (define L.fun/vector136499.5 (lambda () (call L.fun/vector136500.6)))
    (define L.fun/vector136500.6 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char136497.7
      (lambda () (call L.fun/ascii-char136498.4)))
    (let ((fixnum0.6
           (call
            -
            (call
             -
             (call - (call - 57 173) (call + 80 26))
             (call - (call - 165 150) (call - 59 202)))
            (call
             *
             (call - (call + 99 44) (call + 160 209))
             (call * (call * 110 24) (call * 43 58)))))
          (fixnum1.5
           (call
            *
            (call
             *
             (call * (call * 83 125) (call - 106 186))
             (call * (call * 127 49) (call - 38 162)))
            (call
             *
             (call + (call + 54 164) (call * 109 64))
             (call - (call * 92 246) (call + 16 228)))))
          (fixnum2.4
           (call
            -
            (call
             +
             (call - (call * 71 188) (call + 214 21))
             (call + (call + 207 126) (call - 46 138)))
            (call
             *
             (call * (call - 1 111) (call + 208 145))
             (call * (call + 179 98) (call * 146 14)))))
          (fixnum3.3
           (call
            *
            (call
             *
             (call - (call * 136 149) (call + 41 136))
             (call + (call * 93 30) (call * 139 186)))
            (call
             -
             (call - (call - 95 69) (call * 35 215))
             (call + (call + 202 233) (call + 151 206)))))
          (ascii-char4.2 (call L.fun/ascii-char136497.7))
          (vector5.1 (call L.fun/vector136499.5)))
      vector5.1)))
(check-by-interp
 '(module
    (define L.fun/vector136507.4 (lambda () (call make-vector 8)))
    (define L.fun/any136503.5 (lambda () empty))
    (define L.fun/void136504.6 (lambda () (call L.fun/void136505.10)))
    (define L.fun/vector136506.7 (lambda () (call L.fun/vector136507.4)))
    (define L.fun/empty136512.8 (lambda () (call L.fun/empty136513.12)))
    (define L.fun/empty136508.9 (lambda () (call L.fun/empty136509.13)))
    (define L.fun/void136505.10 (lambda () (void)))
    (define L.fun/error136510.11 (lambda () (call L.fun/error136511.14)))
    (define L.fun/empty136513.12 (lambda () empty))
    (define L.fun/empty136509.13 (lambda () empty))
    (define L.fun/error136511.14 (lambda () (error 63)))
    (let ((boolean0.6 (call ascii-char? (call L.fun/any136503.5)))
          (void1.5 (call L.fun/void136504.6))
          (vector2.4 (call L.fun/vector136506.7))
          (empty3.3 (call L.fun/empty136508.9))
          (error4.2 (call L.fun/error136510.11))
          (empty5.1 (call L.fun/empty136512.8)))
      empty5.1)))
(check-by-interp
 '(module
    (define L.fun/vector136833.4 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char136836.5
      (lambda () (call L.fun/ascii-char136837.9)))
    (define L.fun/void136830.6 (lambda () (call L.fun/void136831.12)))
    (define L.fun/error136841.7 (lambda () (error 173)))
    (define L.fun/error136840.8 (lambda () (call L.fun/error136841.7)))
    (define L.fun/ascii-char136837.9 (lambda () #\c))
    (define L.fun/ascii-char136834.10
      (lambda () (call L.fun/ascii-char136835.14)))
    (define L.fun/vector136832.11 (lambda () (call L.fun/vector136833.4)))
    (define L.fun/void136831.12 (lambda () (void)))
    (define L.fun/empty136839.13 (lambda () empty))
    (define L.fun/ascii-char136835.14 (lambda () #\c))
    (define L.fun/empty136838.15 (lambda () (call L.fun/empty136839.13)))
    (let ((void0.6 (call L.fun/void136830.6))
          (vector1.5 (call L.fun/vector136832.11))
          (ascii-char2.4 (call L.fun/ascii-char136834.10))
          (ascii-char3.3 (call L.fun/ascii-char136836.5))
          (empty4.2 (call L.fun/empty136838.15))
          (error5.1 (call L.fun/error136840.8)))
      empty4.2)))
(check-by-interp
 '(module
    (define L.fun/void137024.4 (lambda () (void)))
    (define L.fun/error137026.5 (lambda () (error 45)))
    (define L.fun/any137022.6 (lambda () (void)))
    (define L.fun/error137025.7 (lambda () (call L.fun/error137026.5)))
    (define L.fun/void137023.8 (lambda () (call L.fun/void137024.4)))
    (define L.fun/empty137020.9 (lambda () (call L.fun/empty137021.11)))
    (define L.fun/vector137029.10 (lambda () (call L.fun/vector137030.13)))
    (define L.fun/empty137021.11 (lambda () empty))
    (define L.fun/empty137027.12 (lambda () (call L.fun/empty137028.14)))
    (define L.fun/vector137030.13 (lambda () (call make-vector 8)))
    (define L.fun/empty137028.14 (lambda () empty))
    (define L.fun/any137019.15 (lambda () 177))
    (let ((boolean0.6 (call empty? (call L.fun/any137019.15)))
          (empty1.5 (call L.fun/empty137020.9))
          (boolean2.4 (call boolean? (call L.fun/any137022.6)))
          (void3.3 (call L.fun/void137023.8))
          (error4.2 (call L.fun/error137025.7))
          (empty5.1 (call L.fun/empty137027.12)))
      (call L.fun/vector137029.10))))
(check-by-interp
 '(module
    (define L.fun/empty137626.4 (lambda () (call L.fun/empty137627.11)))
    (define L.fun/any137625.5 (lambda () (error 77)))
    (define L.fun/ascii-char137633.6 (lambda () #\c))
    (define L.fun/ascii-char137631.7 (lambda () #\c))
    (define L.fun/vector137628.8 (lambda () (call L.fun/vector137629.13)))
    (define L.fun/ascii-char137632.9
      (lambda () (call L.fun/ascii-char137633.6)))
    (define L.fun/ascii-char137630.10
      (lambda () (call L.fun/ascii-char137631.7)))
    (define L.fun/empty137627.11 (lambda () empty))
    (define L.fun/ascii-char137634.12
      (lambda () (call L.fun/ascii-char137635.14)))
    (define L.fun/vector137629.13 (lambda () (call make-vector 8)))
    (define L.fun/ascii-char137635.14 (lambda () #\c))
    (let ((boolean0.6 (call boolean? (call L.fun/any137625.5)))
          (empty1.5 (call L.fun/empty137626.4))
          (vector2.4 (call L.fun/vector137628.8))
          (ascii-char3.3 (call L.fun/ascii-char137630.10))
          (ascii-char4.2 (call L.fun/ascii-char137632.9))
          (ascii-char5.1 (call L.fun/ascii-char137634.12)))
      (call
       +
       (call
        *
        (call * (call * 34 60) (call * 186 96))
        (call * (call + 198 52) (call + 57 165)))
       (call
        -
        (call + (call - 61 195) (call - 242 162))
        (call - (call * 28 125) (call - 228 16)))))))
(check-by-interp
 '(module
    (define L.fun/empty138255.4 (lambda () empty))
    (define L.fun/error138252.5 (lambda () (call L.fun/error138253.14)))
    (define L.fun/vector138260.6 (lambda () (call L.fun/vector138261.11)))
    (define L.fun/error138259.7 (lambda () (error 211)))
    (define L.fun/vector138262.8 (lambda () (call L.fun/vector138263.15)))
    (define L.fun/empty138256.9 (lambda () (call L.fun/empty138257.12)))
    (define L.fun/error138258.10 (lambda () (call L.fun/error138259.7)))
    (define L.fun/vector138261.11 (lambda () (call make-vector 8)))
    (define L.fun/empty138257.12 (lambda () empty))
    (define L.fun/empty138254.13 (lambda () (call L.fun/empty138255.4)))
    (define L.fun/error138253.14 (lambda () (error 15)))
    (define L.fun/vector138263.15 (lambda () (call make-vector 8)))
    (let ((error0.6 (call L.fun/error138252.5))
          (empty1.5 (call L.fun/empty138254.13))
          (empty2.4 (call L.fun/empty138256.9))
          (error3.3 (call L.fun/error138258.10))
          (vector4.2 (call L.fun/vector138260.6))
          (vector5.1 (call L.fun/vector138262.8)))
      vector4.2)))
(check-by-interp
 '(module
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
            *
            (call
             *
             (call + (call - 253 200) (call * 216 47))
             (call - (call * 188 34) (call * 45 9)))
            (call
             +
             (call * (call - 248 181) (call * 249 3))
             (call * (call + 107 197) (call - 178 32)))))
          (ascii-char5.1 (call L.fun/ascii-char138308.10)))
      (call L.fun/error138310.11))))
(check-by-interp
 '(module
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
          (boolean2.4 (call fixnum? (call L.fun/any139285.11)))
          (empty3.3 (call L.fun/empty139286.13))
          (fixnum4.2
           (call
            +
            (call
             +
             (call - (call * 245 229) (call - 210 96))
             (call - (call - 107 190) (call * 158 137)))
            (call
             +
             (call * (call + 20 12) (call - 87 30))
             (call - (call * 110 213) (call * 212 205)))))
          (boolean5.1 (call boolean? (call L.fun/any139288.8))))
      (call L.fun/void139289.12))))
(check-by-interp
 '(module
    (define L.fun/void140574.4 (lambda () (void)))
    (define L.fun/empty140576.5 (lambda () empty))
    (define L.fun/empty140575.6 (lambda () (call L.fun/empty140576.5)))
    (define L.fun/void140573.7 (lambda () (call L.fun/void140574.4)))
    (let ((fixnum0.6
           (call
            *
            (call
             -
             (call * (call * 222 42) (call + 91 91))
             (call * (call + 147 158) (call - 62 123)))
            (call
             -
             (call + (call + 190 202) (call + 3 174))
             (call - (call + 103 182) (call + 244 30)))))
          (fixnum1.5
           (call
            +
            (call
             *
             (call + (call * 178 102) (call - 98 190))
             (call + (call - 254 210) (call * 222 41)))
            (call
             +
             (call - (call + 250 152) (call + 241 160))
             (call - (call - 15 61) (call - 129 35)))))
          (fixnum2.4
           (call
            *
            (call
             -
             (call * (call + 111 248) (call - 128 111))
             (call + (call + 63 1) (call * 64 193)))
            (call
             -
             (call + (call * 36 95) (call - 110 120))
             (call * (call + 125 161) (call + 218 6)))))
          (void3.3 (call L.fun/void140573.7))
          (fixnum4.2
           (call
            -
            (call
             -
             (call - (call - 159 245) (call - 204 81))
             (call - (call - 89 204) (call * 27 69)))
            (call
             -
             (call + (call - 243 162) (call + 234 234))
             (call - (call + 141 218) (call * 118 60)))))
          (empty5.1 (call L.fun/empty140575.6)))
      void3.3)))
(check-by-interp
 '(module
    (define L.fun/empty141807.4 (lambda () empty))
    (define L.fun/void141798.5 (lambda () (call L.fun/void141799.8)))
    (define L.fun/empty141806.6 (lambda () (call L.fun/empty141807.4)))
    (define L.fun/error141804.7 (lambda () (call L.fun/error141805.12)))
    (define L.fun/void141799.8 (lambda () (void)))
    (define L.fun/ascii-char141800.9
      (lambda () (call L.fun/ascii-char141801.14)))
    (define L.fun/vector141808.10 (lambda () (call L.fun/vector141809.15)))
    (define L.fun/void141803.11 (lambda () (void)))
    (define L.fun/error141805.12 (lambda () (error 14)))
    (define L.fun/void141802.13 (lambda () (call L.fun/void141803.11)))
    (define L.fun/ascii-char141801.14 (lambda () #\c))
    (define L.fun/vector141809.15 (lambda () (call make-vector 8)))
    (let ((void0.6 (call L.fun/void141798.5))
          (ascii-char1.5 (call L.fun/ascii-char141800.9))
          (fixnum2.4
           (call
            -
            (call
             *
             (call - (call - 147 55) (call + 248 243))
             (call + (call * 123 185) (call - 251 168)))
            (call
             +
             (call * (call + 45 233) (call + 162 50))
             (call - (call + 72 78) (call + 37 94)))))
          (void3.3 (call L.fun/void141802.13))
          (error4.2 (call L.fun/error141804.7))
          (empty5.1 (call L.fun/empty141806.6)))
      (call L.fun/vector141808.10))))
(check-by-interp
 '(module
    (define L.fun/vector143565.4 (lambda () (call make-vector 8)))
    (define L.fun/error143561.5 (lambda () (error 242)))
    (define L.fun/error143558.6 (lambda () (call L.fun/error143559.8)))
    (define L.fun/ascii-char143563.7 (lambda () #\c))
    (define L.fun/error143559.8 (lambda () (error 14)))
    (define L.fun/void143554.9 (lambda () (call L.fun/void143555.14)))
    (define L.fun/ascii-char143562.10
      (lambda () (call L.fun/ascii-char143563.7)))
    (define L.fun/error143560.11 (lambda () (call L.fun/error143561.5)))
    (define L.fun/error143556.12 (lambda () (call L.fun/error143557.13)))
    (define L.fun/error143557.13 (lambda () (error 171)))
    (define L.fun/void143555.14 (lambda () (void)))
    (define L.fun/vector143564.15 (lambda () (call L.fun/vector143565.4)))
    (let ((void0.6 (call L.fun/void143554.9))
          (error1.5 (call L.fun/error143556.12))
          (error2.4 (call L.fun/error143558.6))
          (error3.3 (call L.fun/error143560.11))
          (ascii-char4.2 (call L.fun/ascii-char143562.10))
          (vector5.1 (call L.fun/vector143564.15)))
      ascii-char4.2)))
(check-by-interp
 '(module
    (define L.fun/ascii-char143653.4 (lambda () #\c))
    (define L.fun/vector143650.5 (lambda () (call L.fun/vector143651.12)))
    (define L.fun/empty143648.6 (lambda () (call L.fun/empty143649.13)))
    (define L.fun/error143658.7 (lambda () (call L.fun/error143659.10)))
    (define L.fun/empty143656.8 (lambda () (call L.fun/empty143657.9)))
    (define L.fun/empty143657.9 (lambda () empty))
    (define L.fun/error143659.10 (lambda () (error 8)))
    (define L.fun/ascii-char143655.11 (lambda () #\c))
    (define L.fun/vector143651.12 (lambda () (call make-vector 8)))
    (define L.fun/empty143649.13 (lambda () empty))
    (define L.fun/ascii-char143654.14
      (lambda () (call L.fun/ascii-char143655.11)))
    (define L.fun/ascii-char143652.15
      (lambda () (call L.fun/ascii-char143653.4)))
    (let ((empty0.6 (call L.fun/empty143648.6))
          (vector1.5 (call L.fun/vector143650.5))
          (ascii-char2.4 (call L.fun/ascii-char143652.15))
          (ascii-char3.3 (call L.fun/ascii-char143654.14))
          (empty4.2 (call L.fun/empty143656.8))
          (error5.1 (call L.fun/error143658.7)))
      vector1.5)))
(check-by-interp
 '(module
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
            *
            (call
             *
             (call - (call + 68 174) (call * 45 168))
             (call * (call - 236 36) (call - 121 100)))
            (call
             +
             (call - (call * 4 114) (call + 86 218))
             (call * (call - 38 71) (call * 168 32)))))
          (fixnum1.5
           (call
            *
            (call
             +
             (call * (call + 206 173) (call * 208 61))
             (call + (call + 203 24) (call * 135 52)))
            (call
             +
             (call - (call + 242 187) (call + 43 10))
             (call - (call * 216 207) (call * 130 176)))))
          (void2.4 (call L.fun/void143923.9))
          (void3.3 (call L.fun/void143925.10))
          (error4.2 (call L.fun/error143927.4))
          (fixnum5.1
           (call
            +
            (call
             -
             (call - (call - 58 133) (call * 83 150))
             (call + (call * 144 106) (call * 56 247)))
            (call
             +
             (call - (call + 2 16) (call + 213 11))
             (call - (call * 160 59) (call + 59 94))))))
      (call L.fun/ascii-char143929.5))))
