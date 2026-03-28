#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         "../uniquify.rkt")
(define (fail-if-invalid p)
  (when (not (exprs-unique-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "exprs-unique-lang-v8"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-exprs-lang-v8 p)
  (interp-exprs-unique-lang-v8 (fail-if-invalid (uniquify p)))))

(check-by-interp '(module 105))
(check-by-interp '(module (error 105)))
(check-by-interp '(module (if #t (error 67) (error 38))))
(check-by-interp '(module (let ((error0 (error 111))) 141)))
(check-by-interp
 '(module (define fun/empty8385 (lambda () empty)) (call fun/empty8385)))
(check-by-interp '(module (if #t #\c #\c)))
(check-by-interp '(module (if #t (error 196) (error 56))))
(check-by-interp
 '(module
    (define fun/vector8392 (lambda (oprand0) (call make-vector 8)))
    (call fun/vector8392 (call + 186 30))))
(check-by-interp
 '(module
    (define fun/vector8395 (lambda (oprand0) (call make-vector 8)))
    (call fun/vector8395 (if #f (void) (void)))))
(check-by-interp
 '(module (let ((error0 (error 3)) (vector1 (call make-vector 8))) #\c)))
(check-by-interp
 '(module
    (define fun/fixnum8420 (lambda (oprand0) 50))
    (call - (call fun/fixnum8420 #\c) (call - 21 253))))
(check-by-interp '(module (if #t (error 240) (error 51))))
(check-by-interp
 '(module
    (define fun/ascii-char8428 (lambda (oprand0) #\c))
    (define fun/empty8427 (lambda (oprand0) empty))
    (call fun/empty8427 (call fun/ascii-char8428 empty))))
(check-by-interp
 '(module
    (define fun/vector8431 (lambda (oprand0) (call make-vector 8)))
    (call fun/vector8431 (let ((error0 (error 83)) (fixnum1 232)) empty))))
(check-by-interp
 '(module
    (define fun/vector8436 (lambda () (call make-vector 8)))
    (define fun/ascii-char8434 (lambda () #\c))
    (define fun/ascii-char8435 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char8434))
          (ascii-char1 (call fun/ascii-char8435))
          (vector2 (call fun/vector8436)))
      vector2)))
(check-by-interp
 '(module
    (define fun/vector8439 (lambda (oprand0 oprand1) (call make-vector 8)))
    (call
     fun/vector8439
     (if #t empty empty)
     (let ((fixnum0 115) (vector1 (call make-vector 8)) (empty2 empty))
       (error 158)))))
(check-by-interp
 '(module
    (define fun/ascii-char8442 (lambda (oprand0 oprand1) #\c))
    (if (if #t #t #t)
      (call fun/ascii-char8442 #\c empty)
      (let ((fixnum0 104) (fixnum1 76) (void2 (void))) #\c))))
(check-by-interp
 '(module
    (define fun/ascii-char8460 (lambda (oprand0 oprand1) #\c))
    (call
     fun/ascii-char8460
     (if #t (call make-vector 8) (call make-vector 8))
     (if #f empty empty))))
(check-by-interp
 '(module
    (define fun/vector8489 (lambda (oprand0 oprand1) (call make-vector 8)))
    (call
     fun/vector8489
     (if #t #f #f)
     (if #f (call make-vector 8) (call make-vector 8)))))
(check-by-interp
 '(module
    (define fun/ascii-char8498 (lambda () #\c))
    (define fun/void8499 (lambda () (void)))
    (define fun/empty8500 (lambda () empty))
    (let ((fixnum0 (call * 232 34))
          (ascii-char1 (call fun/ascii-char8498))
          (void2 (call fun/void8499)))
      (call fun/empty8500))))
(check-by-interp
 '(module
    (define fun/void8519 (lambda () (void)))
    (define fun/empty8521 (lambda () empty))
    (define fun/void8518 (lambda () (void)))
    (define fun/vector8520 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void8518))
          (void1 (call fun/void8519))
          (vector2 (call fun/vector8520)))
      (call fun/empty8521))))
(check-by-interp
 '(module
    (if (if #f #t #t)
      (let ((void0 (void)) (vector1 (call make-vector 8)) (ascii-char2 #\c))
        #t)
      (if #t #t #t))))
(check-by-interp
 '(module
    (define fun/empty8540 (lambda (oprand0 oprand1) empty))
    (if (call empty? 158)
      (call fun/empty8540 #\c (call make-vector 8))
      (if #t empty empty))))
(check-by-interp
 '(module
    (define fun/error8549 (lambda () (error 10)))
    (define fun/ascii-char8548 (lambda () #\c))
    (define fun/vector8550 (lambda () (call make-vector 8)))
    (let ((ascii-char0 (call fun/ascii-char8548))
          (error1 (call fun/error8549))
          (fixnum2 (call + 100 64)))
      (call fun/vector8550))))
(check-by-interp
 '(module
    (define fun/empty8553 (lambda () empty))
    (define fun/error8554 (lambda () (error 169)))
    (let ((empty0 (call fun/empty8553))
          (error1 (call fun/error8554))
          (fixnum2 (call - 221 18)))
      error1)))
(check-by-interp
 '(module
    (define fun/void8581 (lambda () (void)))
    (define fun/empty8582 (lambda () empty))
    (define fun/vector8580 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector8580))
          (void1 (call fun/void8581))
          (empty2 (call fun/empty8582)))
      empty2)))
(check-by-interp
 '(module
    (define fun/error8585 (lambda (oprand0 oprand1) (error 160)))
    (call
     fun/error8585
     (if #f (call make-vector 8) (call make-vector 8))
     (let ((fixnum0 168) (void1 (void)) (boolean2 #t)) void1))))
(check-by-interp
 '(module
    (define fun/vector8594 (lambda (oprand0 oprand1) oprand1))
    (call
     fun/vector8594
     (let ((fixnum0 5) (fixnum1 225) (empty2 empty)) fixnum0)
     (call
      fun/vector8594
      (call - 32 206)
      (if #t (call make-vector 8) (call make-vector 8))))))
(check-by-interp
 '(module
    (define fun/boolean8597 (lambda (oprand0 oprand1) #f))
    (define fun/ascii-char8598 (lambda (oprand0 oprand1) #\c))
    (if (call fun/boolean8597 empty #\c)
      (if #f #\c #\c)
      (call fun/ascii-char8598 78 empty))))
(check-by-interp
 '(module
    (define fun/error8603 (lambda () (error 248)))
    (define fun/vector8602 (lambda () (call make-vector 8)))
    (define fun/empty8601 (lambda () empty))
    (let ((empty0 (call fun/empty8601))
          (vector1 (call fun/vector8602))
          (error2 (call fun/error8603))
          (fixnum3 (call * (call + 66 225) (call - 154 20))))
      empty0)))
(check-by-interp
 '(module
    (define fun/ascii-char8617 (lambda () #\c))
    (define fun/ascii-char8618 (lambda () #\c))
    (define fun/error8620 (lambda () (error 122)))
    (define fun/vector8616 (lambda () (call make-vector 8)))
    (define fun/vector8619 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector8616))
          (ascii-char1 (call fun/ascii-char8617))
          (ascii-char2 (call fun/ascii-char8618))
          (vector3 (call fun/vector8619)))
      (call fun/error8620))))
(check-by-interp
 '(module
    (define fun/vector8794 (lambda () (call make-vector 8)))
    (define fun/void8793 (lambda () (void)))
    (define fun/any8795 (lambda () (void)))
    (define fun/empty8792 (lambda () empty))
    (let ((empty0 (call fun/empty8792))
          (void1 (call fun/void8793))
          (vector2 (call fun/vector8794))
          (boolean3 (call void? (call fun/any8795))))
      empty0)))
(check-by-interp
 '(module
    (define fun/ascii-char8857 (lambda (oprand0 oprand1 oprand2) oprand0))
    (define fun/ascii-char8858 (lambda (oprand0 oprand1 oprand2) oprand1))
    (if (if #t #t #t)
      (call
       fun/ascii-char8857
       (call fun/ascii-char8858 (call make-vector 8) #\c (void))
       (if #f #\c #\c)
       (let ((empty0 empty)
             (void1 (void))
             (error2 (error 101))
             (error3 (error 93)))
         167))
      (let ((ascii-char0 #\c)
            (vector1 (call make-vector 8))
            (boolean2 #f)
            (error3 (error 218)))
        #\c))))
(check-by-interp
 '(module
    (define fun/any8922 (lambda (oprand0 oprand1 oprand2) 170))
    (define fun/error8924 (lambda (oprand0 oprand1 oprand2) (error 202)))
    (define fun/empty8923 (lambda (oprand0 oprand1 oprand2) empty))
    (define fun/empty8925 (lambda (oprand0 oprand1 oprand2) empty))
    (if (call vector? (call fun/any8922 (error 187) (error 144) (error 55)))
      (let ((error0 (error 93)) (ascii-char1 #\c) (void2 (void)) (boolean3 #f))
        empty)
      (call
       fun/empty8923
       (if #f 234 114)
       (call fun/error8924 empty (void) #f)
       (call fun/empty8925 239 (call make-vector 8) (void))))))
(check-by-interp
 '(module
    (define fun/ascii-char8995 (lambda (oprand0 oprand1 oprand2) #\c))
    (if (call ascii-char? (if #t (call make-vector 8) (void)))
      (call
       fun/ascii-char8995
       (if #t #\c #\c)
       (let ((error0 (error 152))
             (fixnum1 146)
             (vector2 (call make-vector 8))
             (void3 (void)))
         77)
       (call pair? #\c))
      (if #f #\c #\c))))
(check-by-interp
 '(module
    (define fun/empty9097 (lambda () empty))
    (define fun/error9096 (lambda () (error 229)))
    (define fun/any9094 (lambda () (call make-vector 8)))
    (define fun/void9095 (lambda () (void)))
    (let ((fixnum0 (call - (call + 135 91) (call - 139 228)))
          (boolean1 (call ascii-char? (call fun/any9094)))
          (void2 (call fun/void9095))
          (error3 (call fun/error9096)))
      (call fun/empty9097))))
(check-by-interp
 '(module
    (define fun/error9196 (lambda () (error 145)))
    (define fun/empty9197 (lambda () empty))
    (define fun/vector9198 (lambda () (call make-vector 8)))
    (define fun/empty9195 (lambda () empty))
    (let ((empty0 (call fun/empty9195))
          (error1 (call fun/error9196))
          (fixnum2 (call - (call + 220 180) (call + 230 28)))
          (empty3 (call fun/empty9197)))
      (call fun/vector9198))))
(check-by-interp
 '(module
    (define fun/fixnum9203 (lambda (oprand0 oprand1 oprand2) 171))
    (define fun/fixnum9202 (lambda (oprand0 oprand1 oprand2) 71))
    (define fun/fixnum9204 (lambda (oprand0 oprand1 oprand2) oprand2))
    (define fun/boolean9201 (lambda (oprand0 oprand1 oprand2) #t))
    (call
     +
     (if (call fun/boolean9201 (error 11) #\c empty)
       (call fun/fixnum9202 (void) empty (void))
       (call fun/fixnum9203 empty #f #f))
     (if (if #t #f #f)
       (let ((boolean0 #f) (error1 (error 231)) (fixnum2 27) (void3 (void)))
         fixnum2)
       (call fun/fixnum9204 (void) #\c 222)))))
(check-by-interp
 '(module
    (if (let ((boolean0 #f) (ascii-char1 #\c) (empty2 empty) (empty3 empty))
          #f)
      (let ((void0 (void))
            (vector1 (call make-vector 8))
            (boolean2 #t)
            (boolean3 #f))
        (error 26))
      (if #t (error 181) (error 214)))))
(check-by-interp
 '(module
    (define fun/ascii-char9328 (lambda () #\c))
    (define fun/void9330 (lambda () (void)))
    (define fun/error9331 (lambda () (error 106)))
    (define fun/ascii-char9329 (lambda () #\c))
    (let ((fixnum0 (call - (call * 55 225) (call + 52 28)))
          (ascii-char1 (call fun/ascii-char9328))
          (ascii-char2 (call fun/ascii-char9329))
          (void3 (call fun/void9330)))
      (call fun/error9331))))
(check-by-interp
 '(module
    (define fun/ascii-char9350 (lambda () #\c))
    (define fun/error9349 (lambda () (error 136)))
    (let ((fixnum0 (call - (call - 150 201) (call - 95 117)))
          (fixnum1 (call - (call * 128 107) (call * 89 97)))
          (error2 (call fun/error9349))
          (fixnum3 (call * (call - 133 4) (call - 136 150))))
      (call fun/ascii-char9350))))
(check-by-interp
 '(module
    (define fun/any9400 (lambda () (void)))
    (define fun/error9399 (lambda () (error 95)))
    (define fun/ascii-char9401 (lambda () #\c))
    (define fun/vector9402 (lambda () (call make-vector 8)))
    (let ((error0 (call fun/error9399))
          (boolean1 (call void? (call fun/any9400)))
          (fixnum2 (call * (call + 2 163) (call - 227 100)))
          (ascii-char3 (call fun/ascii-char9401)))
      (call fun/vector9402))))
(check-by-interp
 '(module
    (define fun/empty9463 (lambda () empty))
    (define fun/empty9462 (lambda () empty))
    (define fun/void9461 (lambda () (void)))
    (let ((void0 (call fun/void9461))
          (fixnum1 (call - (call + 183 180) (call * 238 118)))
          (empty2 (call fun/empty9462))
          (empty3 (call fun/empty9463)))
      void0)))
(check-by-interp
 '(module
    (define fun/empty9493 (lambda () empty))
    (define fun/vector9494 (lambda () (call make-vector 8)))
    (define fun/error9491 (lambda () (error 154)))
    (define fun/error9492 (lambda () (error 158)))
    (let ((error0 (call fun/error9491))
          (error1 (call fun/error9492))
          (empty2 (call fun/empty9493))
          (vector3 (call fun/vector9494)))
      (call * (call * 24 10) (call - 185 187)))))
(check-by-interp
 '(module
    (define fun/ascii-char9530 (lambda (oprand0 oprand1 oprand2) #\c))
    (if (let ((fixnum0 133) (empty1 empty) (fixnum2 85) (error3 (error 110)))
          #f)
      (call
       fun/ascii-char9530
       (let ((void0 (void)) (error1 (error 158)) (void2 (void)) (boolean3 #f))
         180)
       (call - 161 4)
       (if #t (void) (void)))
      (let ((ascii-char0 #\c) (fixnum1 195) (empty2 empty) (void3 (void)))
        #\c))))
(check-by-interp
 '(module
    (if (if #t #f #t)
      (if #f (error 182) (error 164))
      (if #t (error 131) (error 227)))))
(check-by-interp
 '(module
    (if (call empty? (if #t #\c 105))
      (let ((fixnum0 149) (fixnum1 116) (boolean2 #f) (boolean3 #t))
        (call make-vector 8))
      (let ((error0 (error 207))
            (ascii-char1 #\c)
            (error2 (error 125))
            (vector3 (call make-vector 8)))
        vector3))))
(check-by-interp
 '(module
    (define fun/error9595 (lambda () (error 35)))
    (define fun/void9594 (lambda () (void)))
    (define fun/empty9593 (lambda () empty))
    (let ((empty0 (call fun/empty9593))
          (void1 (call fun/void9594))
          (error2 (call fun/error9595))
          (fixnum3 (call * (call - 171 174) (call * 161 50))))
      void1)))
(check-by-interp
 '(module
    (define fun/error9648 (lambda () (error 10)))
    (define fun/error9646 (lambda () (error 228)))
    (define fun/any9647 (lambda () #f))
    (define fun/error9649 (lambda () (error 110)))
    (define fun/void9650 (lambda () (void)))
    (let ((error0 (call fun/error9646))
          (boolean1 (call void? (call fun/any9647)))
          (error2 (call fun/error9648))
          (error3 (call fun/error9649)))
      (call fun/void9650))))
(check-by-interp
 '(module
    (define fun/error9674 (lambda () (error 5)))
    (define fun/any9670 (lambda () empty))
    (define fun/void9671 (lambda () (void)))
    (define fun/vector9672 (lambda () (call make-vector 8)))
    (define fun/empty9673 (lambda () empty))
    (let ((boolean0 (call empty? (call fun/any9670)))
          (void1 (call fun/void9671))
          (vector2 (call fun/vector9672))
          (empty3 (call fun/empty9673)))
      (call fun/error9674))))
(check-by-interp
 '(module
    (define fun/void9689 (lambda () (void)))
    (define fun/vector9690 (lambda () (call make-vector 8)))
    (define fun/vector9691 (lambda () (call make-vector 8)))
    (define fun/error9692 (lambda () (error 60)))
    (let ((void0 (call fun/void9689))
          (vector1 (call fun/vector9690))
          (vector2 (call fun/vector9691))
          (error3 (call fun/error9692)))
      (call + (call + 39 206) (call * 133 61)))))
(check-by-interp
 '(module
    (define fun/empty9739 (lambda (oprand0 oprand1 oprand2) empty))
    (define fun/ascii-char9738 (lambda (oprand0 oprand1 oprand2) #\c))
    (define fun/void9736 (lambda (oprand0 oprand1 oprand2) (void)))
    (define fun/error9737 (lambda (oprand0 oprand1 oprand2) (error 137)))
    (if (if #t #f #f)
      (if #f (void) (void))
      (call
       fun/void9736
       (call fun/error9737 #f #\c 247)
       (call fun/ascii-char9738 45 (error 199) (call make-vector 8))
       (call fun/empty9739 #f 178 #\c)))))
(check-by-interp
 '(module
    (define fun/any9842
      (lambda (oprand0 oprand1 oprand2) (call make-vector 8)))
    (if (call void? (call fun/any9842 214 (void) 160))
      (if #t (error 253) (error 171))
      (let ((boolean0 #f) (void1 (void)) (fixnum2 97) (empty3 empty))
        (error 93)))))
(check-by-interp
 '(module
    (define fun/void9900 (lambda () (void)))
    (define fun/void9899 (lambda () (void)))
    (define fun/fixnum9902 (lambda (oprand0 oprand1 oprand2) (call * 102 183)))
    (define fun/empty9901 (lambda () empty))
    (define fun/ascii-char9904 (lambda (oprand0 oprand1 oprand2) oprand0))
    (define fun/ascii-char9903 (lambda (oprand0 oprand1 oprand2) #\c))
    (call
     +
     (let ((fixnum0 (call + 84 131))
           (void1 (call fun/void9899))
           (void2 (call fun/void9900))
           (empty3 (call fun/empty9901)))
       (call + fixnum0 25))
     (call
      fun/fixnum9902
      (call
       fun/ascii-char9903
       (call fun/ascii-char9904 #\c #f 179)
       (let ((empty0 empty) (fixnum1 26) (void2 (void)) (empty3 empty))
         fixnum1)
       (if #t #f #f))
      (let ((empty0 empty)
            (fixnum1 25)
            (vector2 (call make-vector 8))
            (error3 (error 9)))
        vector2)
      (if #t empty empty)))))
(check-by-interp
 '(module
    (define fun/empty10029 (lambda () empty))
    (define fun/void10030 (lambda () (void)))
    (define fun/ascii-char10031 (lambda () #\c))
    (define fun/vector10028 (lambda () (call make-vector 8)))
    (define fun/error10032 (lambda () (error 197)))
    (let ((vector0 (call fun/vector10028))
          (empty1 (call fun/empty10029))
          (void2 (call fun/void10030))
          (fixnum3
           (call
            -
            (call - (call * 130 201) (call - 23 50))
            (call * (call - 89 229) (call + 222 95))))
          (ascii-char4 (call fun/ascii-char10031)))
      (call fun/error10032))))
(check-by-interp
 '(module
    (define fun/error10696 (lambda () (error 215)))
    (define fun/ascii-char10693 (lambda () #\c))
    (define fun/void10697 (lambda () (void)))
    (define fun/any10694 (lambda () empty))
    (define fun/void10695 (lambda () (void)))
    (let ((ascii-char0 (call fun/ascii-char10693))
          (boolean1 (call ascii-char? (call fun/any10694)))
          (void2 (call fun/void10695))
          (error3 (call fun/error10696))
          (void4 (call fun/void10697)))
      void4)))
(check-by-interp
 '(module
    (define fun/vector10982 (lambda () (call make-vector 8)))
    (define fun/error10981 (lambda () (error 69)))
    (define fun/vector10978 (lambda () (call make-vector 8)))
    (define fun/ascii-char10980 (lambda () #\c))
    (define fun/empty10979 (lambda () empty))
    (let ((vector0 (call fun/vector10978))
          (empty1 (call fun/empty10979))
          (ascii-char2 (call fun/ascii-char10980))
          (error3 (call fun/error10981))
          (vector4 (call fun/vector10982)))
      error3)))
(check-by-interp
 '(module
    (define fun/any11523 (lambda () (error 153)))
    (define fun/vector11521 (lambda () (call make-vector 8)))
    (define fun/vector11520 (lambda () (call make-vector 8)))
    (define fun/void11524 (lambda () (void)))
    (define fun/any11522 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector11520))
          (vector1 (call fun/vector11521))
          (boolean2 (call error? (call fun/any11522)))
          (boolean3 (call boolean? (call fun/any11523)))
          (void4 (call fun/void11524)))
      void4)))
(check-by-interp
 '(module
    (define fun/any11781 (lambda () (call make-vector 8)))
    (define fun/empty11787 (lambda () empty))
    (define fun/any11786 (lambda () (error 119)))
    (define fun/ascii-char11784 (lambda () #\c))
    (define fun/ascii-char11782 (lambda () #\c))
    (define fun/error11785 (lambda () (error 140)))
    (define fun/empty11780 (lambda () empty))
    (define fun/void11783 (lambda () (void)))
    (call
     *
     (let ((empty0 (call fun/empty11780))
           (fixnum1 (call + (call + 28 7) (call + 44 46)))
           (fixnum2 (call + (call + 133 130) (call - 171 132)))
           (boolean3 (call void? (call fun/any11781)))
           (ascii-char4 (call fun/ascii-char11782)))
       (call + (call - 136 187) (call + fixnum1 45)))
     (let ((void0 (call fun/void11783))
           (ascii-char1 (call fun/ascii-char11784))
           (error2 (call fun/error11785))
           (boolean3 (call pair? (call fun/any11786)))
           (empty4 (call fun/empty11787)))
       (call - (call - 240 199) (call - 154 192))))))
(check-by-interp
 '(module
    (define fun/vector11791 (lambda () (call make-vector 8)))
    (define fun/any11794 (lambda () #\c))
    (define fun/ascii-char11795 (lambda () #\c))
    (define fun/empty11790 (lambda () empty))
    (define fun/vector11793 (lambda () (call make-vector 8)))
    (define fun/vector11792 (lambda () (call make-vector 8)))
    (let ((empty0 (call fun/empty11790))
          (vector1 (call fun/vector11791))
          (vector2 (call fun/vector11792))
          (vector3 (call fun/vector11793))
          (boolean4 (call boolean? (call fun/any11794))))
      (call fun/ascii-char11795))))
(check-by-interp
 '(module
    (define fun/empty12161 (lambda () empty))
    (define fun/error12159 (lambda () (error 7)))
    (define fun/ascii-char12162 (lambda () #\c))
    (define fun/error12163 (lambda () (error 42)))
    (define fun/error12160 (lambda () (error 106)))
    (let ((error0 (call fun/error12159))
          (error1 (call fun/error12160))
          (empty2 (call fun/empty12161))
          (ascii-char3 (call fun/ascii-char12162))
          (error4 (call fun/error12163)))
      empty2)))
(check-by-interp
 '(module
    (define fun/void12536 (lambda () (void)))
    (define fun/any12537 (lambda () empty))
    (define fun/error12539 (lambda () (error 115)))
    (define fun/error12538 (lambda () (error 97)))
    (let ((void0 (call fun/void12536))
          (boolean1 (call empty? (call fun/any12537)))
          (fixnum2
           (call
            -
            (call + (call * 98 48) (call + 13 114))
            (call - (call - 222 161) (call * 99 95))))
          (error3 (call fun/error12538))
          (error4 (call fun/error12539)))
      error4)))
(check-by-interp
 '(module
    (define fun/any13289 (lambda () #f))
    (define fun/empty13290 (lambda () empty))
    (define fun/error13288 (lambda () (error 191)))
    (define fun/ascii-char13291 (lambda () #\c))
    (let ((fixnum0
           (call
            +
            (call - (call * 170 197) (call - 236 37))
            (call - (call - 235 226) (call * 251 88))))
          (error1 (call fun/error13288))
          (fixnum2
           (call
            -
            (call - (call - 186 149) (call - 145 185))
            (call * (call * 3 155) (call + 226 219))))
          (boolean3 (call pair? (call fun/any13289)))
          (empty4 (call fun/empty13290)))
      (call fun/ascii-char13291))))
(check-by-interp
 '(module
    (define fun/ascii-char13294 (lambda () #\c))
    (define fun/any13295 (lambda () #f))
    (define fun/error13297 (lambda () (error 183)))
    (define fun/ascii-char13296 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char13294))
          (fixnum1
           (call
            +
            (call - (call - 34 115) (call * 164 191))
            (call + (call + 116 76) (call - 28 161))))
          (boolean2 (call fixnum? (call fun/any13295)))
          (ascii-char3 (call fun/ascii-char13296))
          (error4 (call fun/error13297)))
      ascii-char0)))
(check-by-interp
 '(module
    (define fun/void13818 (lambda () (void)))
    (define fun/vector13820 (lambda () (call make-vector 8)))
    (define fun/empty13817 (lambda () empty))
    (define fun/error13821 (lambda () (error 147)))
    (define fun/vector13819 (lambda () (call make-vector 8)))
    (let ((fixnum0
           (call
            +
            (call - (call * 133 168) (call + 18 172))
            (call * (call + 1 63) (call - 108 115))))
          (empty1 (call fun/empty13817))
          (void2 (call fun/void13818))
          (vector3 (call fun/vector13819))
          (vector4 (call fun/vector13820)))
      (call fun/error13821))))
(check-by-interp
 '(module
    (define fun/vector13874 (lambda () (call make-vector 8)))
    (define fun/void13876 (lambda () (void)))
    (define fun/ascii-char13875 (lambda () #\c))
    (let ((vector0 (call fun/vector13874))
          (ascii-char1 (call fun/ascii-char13875))
          (fixnum2
           (call
            -
            (call + (call - 133 204) (call - 198 76))
            (call - (call - 121 198) (call - 15 62))))
          (fixnum3
           (call
            +
            (call + (call - 146 6) (call + 195 45))
            (call - (call * 202 238) (call - 205 166))))
          (void4 (call fun/void13876)))
      (call
       -
       (call * (call - 68 78) fixnum2)
       (call + fixnum2 (call * 150 14))))))
(check-by-interp
 '(module
    (define fun/empty13902 (lambda () empty))
    (define fun/vector13904 (lambda () (call make-vector 8)))
    (define fun/void13905 (lambda () (void)))
    (define fun/error13903 (lambda () (error 66)))
    (let ((empty0 (call fun/empty13902))
          (error1 (call fun/error13903))
          (vector2 (call fun/vector13904))
          (fixnum3
           (call
            +
            (call - (call - 179 164) (call * 82 68))
            (call * (call - 252 27) (call + 140 60))))
          (void4 (call fun/void13905)))
      empty0)))
(check-by-interp
 '(module
    (define fun/ascii-char13919 (lambda () #\c))
    (define fun/error13917 (lambda () (error 136)))
    (define fun/any13918 (lambda () #t))
    (define fun/void13916 (lambda () (void)))
    (define fun/ascii-char13915 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char13915))
          (void1 (call fun/void13916))
          (error2 (call fun/error13917))
          (boolean3 (call ascii-char? (call fun/any13918)))
          (ascii-char4 (call fun/ascii-char13919)))
      void1)))
(check-by-interp
 '(module
    (define fun/empty14259 (lambda () empty))
    (define fun/ascii-char14257 (lambda () #\c))
    (define fun/error14258 (lambda () (error 83)))
    (let ((ascii-char0 (call fun/ascii-char14257))
          (fixnum1
           (call
            *
            (call - (call * 206 222) (call * 226 166))
            (call - (call - 182 234) (call + 54 78))))
          (error2 (call fun/error14258))
          (empty3 (call fun/empty14259))
          (fixnum4
           (call
            -
            (call - (call + 181 68) (call + 63 242))
            (call + (call * 104 78) (call * 102 32)))))
      empty3)))
(check-by-interp
 '(module
    (define fun/vector14564 (lambda () (call make-vector 8)))
    (define fun/error14567 (lambda () (error 17)))
    (define fun/empty14565 (lambda () empty))
    (define fun/error14566 (lambda () (error 233)))
    (define fun/ascii-char14563 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char14563))
          (vector1 (call fun/vector14564))
          (empty2 (call fun/empty14565))
          (error3 (call fun/error14566))
          (error4 (call fun/error14567)))
      vector1)))
(check-by-interp
 '(module
    (define fun/void15185 (lambda () (void)))
    (define fun/void15186 (lambda () (void)))
    (define fun/vector15187 (lambda () (call make-vector 8)))
    (define fun/ascii-char15189 (lambda () #\c))
    (define fun/ascii-char15188 (lambda () #\c))
    (let ((void0 (call fun/void15185))
          (void1 (call fun/void15186))
          (vector2 (call fun/vector15187))
          (ascii-char3 (call fun/ascii-char15188))
          (ascii-char4 (call fun/ascii-char15189)))
      void1)))
(check-by-interp
 '(module
    (define fun/error15445 (lambda () (error 139)))
    (define fun/ascii-char15442 (lambda () #\c))
    (define fun/empty15443 (lambda () empty))
    (define fun/vector15444 (lambda () (call make-vector 8)))
    (let ((fixnum0
           (call
            -
            (call * (call - 230 208) (call * 23 35))
            (call * (call - 28 8) (call + 0 101))))
          (ascii-char1 (call fun/ascii-char15442))
          (empty2 (call fun/empty15443))
          (vector3 (call fun/vector15444))
          (error4 (call fun/error15445)))
      ascii-char1)))
(check-by-interp
 '(module
    (define fun/empty15571 (lambda () empty))
    (define fun/ascii-char15572 (lambda () #\c))
    (define fun/ascii-char15569 (lambda () #\c))
    (define fun/empty15570 (lambda () empty))
    (define fun/void15568 (lambda () (void)))
    (let ((void0 (call fun/void15568))
          (ascii-char1 (call fun/ascii-char15569))
          (empty2 (call fun/empty15570))
          (empty3 (call fun/empty15571))
          (ascii-char4 (call fun/ascii-char15572)))
      empty3)))
(check-by-interp
 '(module
    (define fun/error15698 (lambda () (error 232)))
    (define fun/vector15697 (lambda () (call make-vector 8)))
    (define fun/empty15699 (lambda () empty))
    (define fun/ascii-char15700 (lambda () #\c))
    (define fun/ascii-char15701 (lambda () #\c))
    (let ((vector0 (call fun/vector15697))
          (error1 (call fun/error15698))
          (empty2 (call fun/empty15699))
          (ascii-char3 (call fun/ascii-char15700))
          (ascii-char4 (call fun/ascii-char15701)))
      empty2)))
(check-by-interp
 '(module
    (define fun/ascii-char15704 (lambda () #\c))
    (define fun/void15705 (lambda () (void)))
    (define fun/ascii-char15707 (lambda () #\c))
    (define fun/error15708 (lambda () (error 141)))
    (define fun/empty15706 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char15704))
          (void1 (call fun/void15705))
          (fixnum2
           (call
            *
            (call * (call * 149 53) (call - 200 171))
            (call * (call + 242 67) (call * 14 213))))
          (empty3 (call fun/empty15706))
          (ascii-char4 (call fun/ascii-char15707)))
      (call fun/error15708))))
(check-by-interp
 '(module
    (define fun/void15911 (lambda () (void)))
    (define fun/any15910 (lambda () #\c))
    (define fun/any15908 (lambda () #\c))
    (define fun/ascii-char15909 (lambda () #\c))
    (let ((fixnum0
           (call
            *
            (call + (call + 201 19) (call + 133 32))
            (call - (call - 254 127) (call - 68 187))))
          (boolean1 (call ascii-char? (call fun/any15908)))
          (ascii-char2 (call fun/ascii-char15909))
          (boolean3 (call empty? (call fun/any15910)))
          (void4 (call fun/void15911)))
      void4)))
(check-by-interp
 '(module
    (define fun/void15914 (lambda () (void)))
    (define fun/vector15915 (lambda () (call make-vector 8)))
    (define fun/empty15916 (lambda () empty))
    (define fun/empty15918 (lambda () empty))
    (define fun/vector15917 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void15914))
          (vector1 (call fun/vector15915))
          (empty2 (call fun/empty15916))
          (vector3 (call fun/vector15917))
          (empty4 (call fun/empty15918)))
      empty2)))
(check-by-interp
 '(module
    (define fun/error16257 (lambda () (error 223)))
    (define fun/ascii-char16255 (lambda () #\c))
    (define fun/empty16258 (lambda () empty))
    (define fun/empty16256 (lambda () empty))
    (define fun/ascii-char16259 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char16255))
          (empty1 (call fun/empty16256))
          (error2 (call fun/error16257))
          (empty3 (call fun/empty16258))
          (ascii-char4 (call fun/ascii-char16259)))
      error2)))
(check-by-interp
 '(module
    (define fun/vector16263 (lambda () (call make-vector 8)))
    (define fun/empty16266 (lambda () empty))
    (define fun/any16262 (lambda () (void)))
    (define fun/void16265 (lambda () (void)))
    (define fun/error16264 (lambda () (error 76)))
    (let ((boolean0 (call vector? (call fun/any16262)))
          (vector1 (call fun/vector16263))
          (fixnum2
           (call
            -
            (call + (call - 23 62) (call - 137 178))
            (call + (call * 168 80) (call + 82 118))))
          (error3 (call fun/error16264))
          (void4 (call fun/void16265)))
      (call fun/empty16266))))
(check-by-interp
 '(module
    (define fun/empty16271 (lambda () empty))
    (define fun/vector16269 (lambda () (call make-vector 8)))
    (define fun/void16270 (lambda () (void)))
    (define fun/void16272 (lambda () (void)))
    (let ((fixnum0
           (call
            *
            (call * (call * 129 130) (call - 151 108))
            (call - (call - 247 154) (call + 176 124))))
          (vector1 (call fun/vector16269))
          (void2 (call fun/void16270))
          (empty3 (call fun/empty16271))
          (void4 (call fun/void16272)))
      empty3)))
(check-by-interp
 '(module
    (define fun/ascii-char16283 (lambda () #\c))
    (define fun/void16282 (lambda () (void)))
    (define fun/ascii-char16286 (lambda () #\c))
    (define fun/error16285 (lambda () (error 183)))
    (define fun/vector16284 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void16282))
          (ascii-char1 (call fun/ascii-char16283))
          (vector2 (call fun/vector16284))
          (error3 (call fun/error16285))
          (ascii-char4 (call fun/ascii-char16286)))
      (call
       *
       (call + (call * 52 143) (call - 136 177))
       (call - (call - 239 199) (call - 28 66))))))
(check-by-interp
 '(module
    (define fun/error16296 (lambda () (error 38)))
    (define fun/vector16298 (lambda () (call make-vector 8)))
    (define fun/empty16297 (lambda () empty))
    (define fun/void16299 (lambda () (void)))
    (define fun/vector16300 (lambda () (call make-vector 8)))
    (let ((error0 (call fun/error16296))
          (empty1 (call fun/empty16297))
          (vector2 (call fun/vector16298))
          (void3 (call fun/void16299))
          (vector4 (call fun/vector16300)))
      empty1)))
(check-by-interp
 '(module
    (define fun/vector16443 (lambda () (call make-vector 8)))
    (define fun/error16445 (lambda () (error 87)))
    (define fun/void16446 (lambda () (void)))
    (define fun/ascii-char16444 (lambda () #\c))
    (define fun/empty16447 (lambda () empty))
    (let ((vector0 (call fun/vector16443))
          (ascii-char1 (call fun/ascii-char16444))
          (error2 (call fun/error16445))
          (void3 (call fun/void16446))
          (empty4 (call fun/empty16447)))
      (call
       -
       (call * (call - 1 200) (call + 14 75))
       (call * (call * 233 50) (call * 76 140))))))
(check-by-interp
 '(module
    (define fun/any17146 (lambda () 230))
    (define fun/void17148 (lambda () (void)))
    (define fun/vector17145 (lambda () (call make-vector 8)))
    (define fun/error17147 (lambda () (error 244)))
    (let ((vector0 (call fun/vector17145))
          (boolean1 (call vector? (call fun/any17146)))
          (fixnum2
           (call
            +
            (call * (call - 131 248) (call * 129 109))
            (call + (call + 179 106) (call + 84 39))))
          (error3 (call fun/error17147))
          (void4 (call fun/void17148)))
      vector0)))
(check-by-interp
 '(module
    (define fun/void17748 (lambda () (void)))
    (define fun/ascii-char17750 (lambda () #\c))
    (define fun/error17749 (lambda () (error 141)))
    (let ((void0 (call fun/void17748))
          (fixnum1
           (call
            +
            (call + (call * 250 187) (call + 177 58))
            (call + (call * 114 169) (call + 147 148))))
          (error2 (call fun/error17749))
          (ascii-char3 (call fun/ascii-char17750))
          (fixnum4
           (call
            -
            (call - (call * 240 76) (call + 175 182))
            (call + (call * 185 50) (call - 106 165)))))
      void0)))
(check-by-interp
 '(module
    (define fun/empty17803 (lambda () empty))
    (define fun/error17806 (lambda () (error 150)))
    (define fun/void17802 (lambda () (void)))
    (define fun/void17805 (lambda () (void)))
    (define fun/empty17804 (lambda () empty))
    (let ((void0 (call fun/void17802))
          (empty1 (call fun/empty17803))
          (empty2 (call fun/empty17804))
          (void3 (call fun/void17805))
          (fixnum4
           (call
            -
            (call * (call - 117 124) (call * 99 52))
            (call * (call + 242 99) (call * 59 238)))))
      (call fun/error17806))))
(check-by-interp
 '(module
    (define fun/error18259 (lambda () (error 81)))
    (define fun/vector18258 (lambda () (call make-vector 8)))
    (define fun/void18256 (lambda () (void)))
    (define fun/ascii-char18257 (lambda () #\c))
    (let ((fixnum0
           (call
            +
            (call - (call + 71 87) (call - 188 128))
            (call + (call * 160 201) (call + 136 9))))
          (void1 (call fun/void18256))
          (ascii-char2 (call fun/ascii-char18257))
          (vector3 (call fun/vector18258))
          (error4 (call fun/error18259)))
      fixnum0)))
(check-by-interp
 '(module
    (define fun/ascii-char19043 (lambda () #\c))
    (define fun/ascii-char19044 (lambda () #\c))
    (define fun/error19045 (lambda () (error 96)))
    (define fun/vector19042 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector19042))
          (fixnum1
           (call
            *
            (call * (call + 30 246) (call * 135 38))
            (call + (call * 149 48) (call * 17 53))))
          (ascii-char2 (call fun/ascii-char19043))
          (ascii-char3 (call fun/ascii-char19044))
          (error4 (call fun/error19045)))
      ascii-char3)))
(check-by-interp
 '(module
    (define fun/vector19309 (lambda () (call make-vector 8)))
    (define fun/vector19308 (lambda () (call make-vector 8)))
    (define fun/ascii-char19306 (lambda () #\c))
    (define fun/empty19307 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char19306))
          (fixnum1
           (call
            -
            (call * (call - 204 243) (call * 36 41))
            (call - (call * 63 177) (call * 158 98))))
          (empty2 (call fun/empty19307))
          (vector3 (call fun/vector19308))
          (vector4 (call fun/vector19309)))
      empty2)))
(check-by-interp
 '(module
    (if (call
         void?
         (let ((boolean0 #t)
               (error1 (error 3))
               (void2 (void))
               (fixnum3 189)
               (fixnum4 11))
           (void)))
      (call * (if #t 50 150) (if #t 125 157))
      (call * (if #f 183 45) (if #t 9 102)))))
(check-by-interp
 '(module
    (define fun/error19878 (lambda () (error 23)))
    (define fun/empty19877 (lambda () empty))
    (define fun/ascii-char19880 (lambda () #\c))
    (define fun/vector19876 (lambda () (call make-vector 8)))
    (define fun/empty19879 (lambda () empty))
    (let ((vector0 (call fun/vector19876))
          (empty1 (call fun/empty19877))
          (error2 (call fun/error19878))
          (empty3 (call fun/empty19879))
          (fixnum4
           (call
            *
            (call + (call * 229 40) (call - 231 149))
            (call * (call - 94 252) (call * 10 202)))))
      (call fun/ascii-char19880))))
(check-by-interp
 '(module
    (define fun/vector20028 (lambda () (call make-vector 8)))
    (define fun/vector20025 (lambda () (call make-vector 8)))
    (define fun/ascii-char20024 (lambda () #\c))
    (define fun/void20026 (lambda () (void)))
    (define fun/error20027 (lambda () (error 122)))
    (let ((ascii-char0 (call fun/ascii-char20024))
          (vector1 (call fun/vector20025))
          (void2 (call fun/void20026))
          (error3 (call fun/error20027))
          (vector4 (call fun/vector20028)))
      vector4)))
(check-by-interp
 '(module
    (define fun/void20503 (lambda () (void)))
    (define fun/empty20501 (lambda () empty))
    (define fun/ascii-char20504 (lambda () #\c))
    (define fun/void20502 (lambda () (void)))
    (let ((empty0 (call fun/empty20501))
          (void1 (call fun/void20502))
          (void2 (call fun/void20503))
          (ascii-char3 (call fun/ascii-char20504))
          (fixnum4
           (call
            *
            (call - (call * 18 125) (call * 156 230))
            (call * (call * 11 152) (call + 64 98)))))
      ascii-char3)))
(check-by-interp
 '(module
    (define fun/void22593 (lambda () (void)))
    (define fun/ascii-char22584 (lambda () (call fun/ascii-char22585)))
    (define fun/error22587 (lambda () (error 189)))
    (define fun/void22588 (lambda () (call fun/void22589)))
    (define fun/vector22590 (lambda () (call fun/vector22591)))
    (define fun/vector22591 (lambda () (call make-vector 8)))
    (define fun/void22589 (lambda () (void)))
    (define fun/error22586 (lambda () (call fun/error22587)))
    (define fun/void22592 (lambda () (call fun/void22593)))
    (define fun/ascii-char22585 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char22584))
          (error1 (call fun/error22586))
          (fixnum2
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
          (void3 (call fun/void22588))
          (vector4 (call fun/vector22590))
          (void5 (call fun/void22592)))
      error1)))
(check-by-interp
 '(module
    (define fun/vector22813 (lambda () (call fun/vector22814)))
    (define fun/vector22811 (lambda () (call fun/vector22812)))
    (define fun/empty22815 (lambda () (call fun/empty22816)))
    (define fun/error22818 (lambda () (error 129)))
    (define fun/ascii-char22821 (lambda () #\c))
    (define fun/ascii-char22820 (lambda () (call fun/ascii-char22821)))
    (define fun/any22819 (lambda () (call make-vector 8)))
    (define fun/error22817 (lambda () (call fun/error22818)))
    (define fun/vector22814 (lambda () (call make-vector 8)))
    (define fun/vector22812 (lambda () (call make-vector 8)))
    (define fun/empty22816 (lambda () empty))
    (let ((vector0 (call fun/vector22811))
          (vector1 (call fun/vector22813))
          (empty2 (call fun/empty22815))
          (error3 (call fun/error22817))
          (boolean4 (call ascii-char? (call fun/any22819)))
          (ascii-char5 (call fun/ascii-char22820)))
      ascii-char5)))
(check-by-interp
 '(module
    (define fun/void23821 (lambda () (call fun/void23822)))
    (define fun/void23820 (lambda () (void)))
    (define fun/void23813 (lambda () (call fun/void23814)))
    (define fun/vector23817 (lambda () (call fun/vector23818)))
    (define fun/empty23816 (lambda () empty))
    (define fun/void23819 (lambda () (call fun/void23820)))
    (define fun/empty23815 (lambda () (call fun/empty23816)))
    (define fun/void23822 (lambda () (void)))
    (define fun/void23814 (lambda () (void)))
    (define fun/vector23818 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void23813))
          (empty1 (call fun/empty23815))
          (vector2 (call fun/vector23817))
          (void3 (call fun/void23819))
          (void4 (call fun/void23821))
          (fixnum5
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
      empty1)))
(check-by-interp
 '(module
    (define fun/empty27868 (lambda () (call fun/empty27869)))
    (define fun/vector27865 (lambda () (call make-vector 8)))
    (define fun/vector27860 (lambda () (call fun/vector27861)))
    (define fun/vector27864 (lambda () (call fun/vector27865)))
    (define fun/void27862 (lambda () (call fun/void27863)))
    (define fun/ascii-char27867 (lambda () #\c))
    (define fun/void27863 (lambda () (void)))
    (define fun/vector27861 (lambda () (call make-vector 8)))
    (define fun/ascii-char27866 (lambda () (call fun/ascii-char27867)))
    (define fun/empty27869 (lambda () empty))
    (let ((vector0 (call fun/vector27860))
          (void1 (call fun/void27862))
          (vector2 (call fun/vector27864))
          (ascii-char3 (call fun/ascii-char27866))
          (fixnum4
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
          (empty5 (call fun/empty27868)))
      ascii-char3)))
(check-by-interp
 '(module
    (define fun/error28491 (lambda () (error 176)))
    (define fun/empty28492 (lambda () (call fun/empty28493)))
    (define fun/empty28493 (lambda () empty))
    (define fun/empty28494 (lambda () (call fun/empty28495)))
    (define fun/ascii-char28488 (lambda () (call fun/ascii-char28489)))
    (define fun/error28490 (lambda () (call fun/error28491)))
    (define fun/void28497 (lambda () (void)))
    (define fun/void28496 (lambda () (call fun/void28497)))
    (define fun/empty28495 (lambda () empty))
    (define fun/ascii-char28489 (lambda () #\c))
    (let ((fixnum0
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
          (ascii-char1 (call fun/ascii-char28488))
          (error2 (call fun/error28490))
          (empty3 (call fun/empty28492))
          (empty4 (call fun/empty28494))
          (void5 (call fun/void28496)))
      error2)))
(check-by-interp
 '(module
    (define fun/ascii-char28930 (lambda () (call fun/ascii-char28931)))
    (define fun/error28940 (lambda () (call fun/error28941)))
    (define fun/ascii-char28935 (lambda () #\c))
    (define fun/void28936 (lambda () (call fun/void28937)))
    (define fun/void28938 (lambda () (call fun/void28939)))
    (define fun/error28933 (lambda () (error 174)))
    (define fun/ascii-char28931 (lambda () #\c))
    (define fun/void28937 (lambda () (void)))
    (define fun/ascii-char28934 (lambda () (call fun/ascii-char28935)))
    (define fun/error28932 (lambda () (call fun/error28933)))
    (define fun/void28939 (lambda () (void)))
    (define fun/error28941 (lambda () (error 244)))
    (let ((ascii-char0 (call fun/ascii-char28930))
          (error1 (call fun/error28932))
          (ascii-char2 (call fun/ascii-char28934))
          (void3 (call fun/void28936))
          (void4 (call fun/void28938))
          (error5 (call fun/error28940)))
      void4)))
(check-by-interp
 '(module
    (define fun/void29441 (lambda () (void)))
    (define fun/vector29438 (lambda () (call fun/vector29439)))
    (define fun/empty29442 (lambda () (call fun/empty29443)))
    (define fun/empty29443 (lambda () empty))
    (define fun/void29440 (lambda () (call fun/void29441)))
    (define fun/vector29439 (lambda () (call make-vector 8)))
    (define fun/error29444 (lambda () (call fun/error29445)))
    (define fun/error29445 (lambda () (error 15)))
    (let ((fixnum0
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
          (vector1 (call fun/vector29438))
          (fixnum2
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
          (void3 (call fun/void29440))
          (empty4 (call fun/empty29442))
          (error5 (call fun/error29444)))
      void3)))
(check-by-interp
 '(module
    (define fun/empty30828 (lambda () empty))
    (define fun/empty30827 (lambda () (call fun/empty30828)))
    (define fun/void30829 (lambda () (call fun/void30830)))
    (define fun/error30825 (lambda () (call fun/error30826)))
    (define fun/error30824 (lambda () (error 122)))
    (define fun/empty30822 (lambda () empty))
    (define fun/error30823 (lambda () (call fun/error30824)))
    (define fun/error30826 (lambda () (error 112)))
    (define fun/void30830 (lambda () (void)))
    (define fun/empty30821 (lambda () (call fun/empty30822)))
    (let ((empty0 (call fun/empty30821))
          (error1 (call fun/error30823))
          (error2 (call fun/error30825))
          (empty3 (call fun/empty30827))
          (fixnum4
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
          (void5 (call fun/void30829)))
      void5)))
(check-by-interp
 '(module
    (define fun/void31698 (lambda () (call fun/void31699)))
    (define fun/void31701 (lambda () (void)))
    (define fun/void31700 (lambda () (call fun/void31701)))
    (define fun/empty31697 (lambda () empty))
    (define fun/void31699 (lambda () (void)))
    (define fun/empty31696 (lambda () (call fun/empty31697)))
    (let ((fixnum0
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
          (fixnum1
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
          (empty2 (call fun/empty31696))
          (void3 (call fun/void31698))
          (void4 (call fun/void31700))
          (fixnum5
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
      void3)))
(check-by-interp
 '(module
    (define fun/empty36308 (lambda () (call fun/empty36309)))
    (define fun/empty36303 (lambda () empty))
    (define fun/void36307 (lambda () (void)))
    (define fun/void36312 (lambda () (call fun/void36313)))
    (define fun/error36311 (lambda () (error 123)))
    (define fun/empty36309 (lambda () empty))
    (define fun/vector36305 (lambda () (call make-vector 8)))
    (define fun/void36306 (lambda () (call fun/void36307)))
    (define fun/void36313 (lambda () (void)))
    (define fun/vector36304 (lambda () (call fun/vector36305)))
    (define fun/error36310 (lambda () (call fun/error36311)))
    (define fun/empty36302 (lambda () (call fun/empty36303)))
    (let ((empty0 (call fun/empty36302))
          (vector1 (call fun/vector36304))
          (void2 (call fun/void36306))
          (empty3 (call fun/empty36308))
          (error4 (call fun/error36310))
          (void5 (call fun/void36312)))
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
    (define fun/error36349 (lambda () (error 64)))
    (define fun/void36353 (lambda () (void)))
    (define fun/empty36356 (lambda () (call fun/empty36357)))
    (define fun/any36358 (lambda () (void)))
    (define fun/vector36359 (lambda () (call fun/vector36360)))
    (define fun/error36348 (lambda () (call fun/error36349)))
    (define fun/error36350 (lambda () (call fun/error36351)))
    (define fun/empty36355 (lambda () empty))
    (define fun/empty36357 (lambda () empty))
    (define fun/vector36360 (lambda () (call make-vector 8)))
    (define fun/empty36354 (lambda () (call fun/empty36355)))
    (define fun/void36352 (lambda () (call fun/void36353)))
    (define fun/error36351 (lambda () (error 1)))
    (let ((error0 (call fun/error36348))
          (error1 (call fun/error36350))
          (void2 (call fun/void36352))
          (empty3 (call fun/empty36354))
          (empty4 (call fun/empty36356))
          (boolean5 (call pair? (call fun/any36358))))
      (call fun/vector36359))))
(check-by-interp
 '(module
    (define fun/vector38038 (lambda () (call fun/vector38039)))
    (define fun/ascii-char38035 (lambda () (call fun/ascii-char38036)))
    (define fun/ascii-char38034 (lambda () #\c))
    (define fun/any38037 (lambda () (error 238)))
    (define fun/void38041 (lambda () (void)))
    (define fun/empty38042 (lambda () (call fun/empty38043)))
    (define fun/void38040 (lambda () (call fun/void38041)))
    (define fun/vector38039 (lambda () (call make-vector 8)))
    (define fun/ascii-char38036 (lambda () #\c))
    (define fun/ascii-char38033 (lambda () (call fun/ascii-char38034)))
    (define fun/empty38043 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char38033))
          (ascii-char1 (call fun/ascii-char38035))
          (boolean2 (call fixnum? (call fun/any38037)))
          (vector3 (call fun/vector38038))
          (void4 (call fun/void38040))
          (empty5 (call fun/empty38042)))
      empty5)))
(check-by-interp
 '(module
    (define fun/any39304 (lambda () (call make-vector 8)))
    (define fun/void39302 (lambda () (call fun/void39303)))
    (define fun/void39303 (lambda () (void)))
    (define fun/ascii-char39301 (lambda () #\c))
    (define fun/void39306 (lambda () (void)))
    (define fun/void39307 (lambda () (call fun/void39308)))
    (define fun/void39305 (lambda () (call fun/void39306)))
    (define fun/void39308 (lambda () (void)))
    (define fun/empty39309 (lambda () (call fun/empty39310)))
    (define fun/ascii-char39300 (lambda () (call fun/ascii-char39301)))
    (define fun/empty39310 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char39300))
          (void1 (call fun/void39302))
          (boolean2 (call boolean? (call fun/any39304)))
          (fixnum3
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
          (void4 (call fun/void39305))
          (void5 (call fun/void39307)))
      (call fun/empty39309))))
(check-by-interp
 '(module
    (define fun/error39534 (lambda () (call fun/error39535)))
    (define fun/empty39523 (lambda () (call fun/empty39524)))
    (define fun/void39533 (lambda () (void)))
    (define fun/vector39527 (lambda () (call fun/vector39528)))
    (define fun/ascii-char39526 (lambda () #\c))
    (define fun/empty39529 (lambda () (call fun/empty39530)))
    (define fun/error39535 (lambda () (error 105)))
    (define fun/ascii-char39525 (lambda () (call fun/ascii-char39526)))
    (define fun/empty39530 (lambda () empty))
    (define fun/vector39528 (lambda () (call make-vector 8)))
    (define fun/empty39524 (lambda () empty))
    (define fun/void39532 (lambda () (call fun/void39533)))
    (define fun/any39531 (lambda () 39))
    (let ((empty0 (call fun/empty39523))
          (ascii-char1 (call fun/ascii-char39525))
          (vector2 (call fun/vector39527))
          (empty3 (call fun/empty39529))
          (boolean4 (call ascii-char? (call fun/any39531)))
          (void5 (call fun/void39532)))
      (call fun/error39534))))
(check-by-interp
 '(module
    (define fun/error40731 (lambda () (error 190)))
    (define fun/void40737 (lambda () (void)))
    (define fun/vector40738 (lambda () (call fun/vector40739)))
    (define fun/vector40739 (lambda () (call make-vector 8)))
    (define fun/void40736 (lambda () (call fun/void40737)))
    (define fun/void40733 (lambda () (void)))
    (define fun/error40735 (lambda () (error 189)))
    (define fun/error40730 (lambda () (call fun/error40731)))
    (define fun/error40734 (lambda () (call fun/error40735)))
    (define fun/void40732 (lambda () (call fun/void40733)))
    (let ((error0 (call fun/error40730))
          (fixnum1
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
          (void2 (call fun/void40732))
          (error3 (call fun/error40734))
          (void4 (call fun/void40736))
          (vector5 (call fun/vector40738)))
      error3)))
(check-by-interp
 '(module
    (define fun/void41928 (lambda () (call fun/void41929)))
    (define fun/vector41931 (lambda () (call make-vector 8)))
    (define fun/void41924 (lambda () (call fun/void41925)))
    (define fun/empty41926 (lambda () (call fun/empty41927)))
    (define fun/void41925 (lambda () (void)))
    (define fun/empty41927 (lambda () empty))
    (define fun/vector41930 (lambda () (call fun/vector41931)))
    (define fun/void41929 (lambda () (void)))
    (let ((void0 (call fun/void41924))
          (fixnum1
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
          (empty2 (call fun/empty41926))
          (void3 (call fun/void41928))
          (fixnum4
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
          (vector5 (call fun/vector41930)))
      fixnum1)))
(check-by-interp
 '(module
    (define fun/void45314 (lambda () (void)))
    (define fun/empty45311 (lambda () (call fun/empty45312)))
    (define fun/void45313 (lambda () (call fun/void45314)))
    (define fun/vector45308 (lambda () (call make-vector 8)))
    (define fun/vector45307 (lambda () (call fun/vector45308)))
    (define fun/void45309 (lambda () (call fun/void45310)))
    (define fun/void45310 (lambda () (void)))
    (define fun/empty45312 (lambda () empty))
    (let ((vector0 (call fun/vector45307))
          (fixnum1
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
          (void2 (call fun/void45309))
          (empty3 (call fun/empty45311))
          (fixnum4
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
          (void5 (call fun/void45313)))
      vector0)))
(check-by-interp
 '(module
    (define fun/void46565 (lambda () (call fun/void46566)))
    (define fun/error46563 (lambda () (call fun/error46564)))
    (define fun/void46566 (lambda () (void)))
    (define fun/empty46562 (lambda () empty))
    (define fun/error46564 (lambda () (error 195)))
    (define fun/empty46561 (lambda () (call fun/empty46562)))
    (define fun/any46567 (lambda () 212))
    (let ((empty0 (call fun/empty46561))
          (error1 (call fun/error46563))
          (fixnum2
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
          (void3 (call fun/void46565))
          (fixnum4
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
          (boolean5 (call pair? (call fun/any46567))))
      void3)))
(check-by-interp
 '(module
    (define fun/ascii-char48487 (lambda () #\c))
    (define fun/vector48483 (lambda () (call make-vector 8)))
    (define fun/ascii-char48486 (lambda () (call fun/ascii-char48487)))
    (define fun/error48480 (lambda () (call fun/error48481)))
    (define fun/empty48485 (lambda () empty))
    (define fun/error48476 (lambda () (call fun/error48477)))
    (define fun/empty48478 (lambda () (call fun/empty48479)))
    (define fun/vector48482 (lambda () (call fun/vector48483)))
    (define fun/empty48484 (lambda () (call fun/empty48485)))
    (define fun/error48481 (lambda () (error 184)))
    (define fun/empty48479 (lambda () empty))
    (define fun/error48477 (lambda () (error 238)))
    (let ((error0 (call fun/error48476))
          (empty1 (call fun/empty48478))
          (error2 (call fun/error48480))
          (vector3 (call fun/vector48482))
          (empty4 (call fun/empty48484))
          (ascii-char5 (call fun/ascii-char48486)))
      ascii-char5)))
(check-by-interp
 '(module
    (define fun/void49751 (lambda () (call fun/void49752)))
    (define fun/vector49754 (lambda () (call fun/vector49755)))
    (define fun/error49746 (lambda () (error 124)))
    (define fun/empty49756 (lambda () (call fun/empty49757)))
    (define fun/empty49757 (lambda () empty))
    (define fun/error49745 (lambda () (call fun/error49746)))
    (define fun/vector49749 (lambda () (call fun/vector49750)))
    (define fun/any49753 (lambda () #t))
    (define fun/error49747 (lambda () (call fun/error49748)))
    (define fun/void49752 (lambda () (void)))
    (define fun/error49748 (lambda () (error 24)))
    (define fun/vector49750 (lambda () (call make-vector 8)))
    (define fun/vector49755 (lambda () (call make-vector 8)))
    (let ((error0 (call fun/error49745))
          (error1 (call fun/error49747))
          (vector2 (call fun/vector49749))
          (void3 (call fun/void49751))
          (boolean4 (call pair? (call fun/any49753)))
          (vector5 (call fun/vector49754)))
      (call fun/empty49756))))
(check-by-interp
 '(module
    (define fun/error50281 (lambda () (error 64)))
    (define fun/error50280 (lambda () (call fun/error50281)))
    (define fun/void50283 (lambda () (void)))
    (define fun/ascii-char50284 (lambda () (call fun/ascii-char50285)))
    (define fun/void50278 (lambda () (call fun/void50279)))
    (define fun/ascii-char50285 (lambda () #\c))
    (define fun/void50279 (lambda () (void)))
    (define fun/void50282 (lambda () (call fun/void50283)))
    (let ((void0 (call fun/void50278))
          (error1 (call fun/error50280))
          (fixnum2
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
          (void3 (call fun/void50282))
          (fixnum4
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
          (ascii-char5 (call fun/ascii-char50284)))
      fixnum2)))
(check-by-interp
 '(module
    (define fun/ascii-char51646 (lambda () (call fun/ascii-char51647)))
    (define fun/ascii-char51645 (lambda () #\c))
    (define fun/ascii-char51644 (lambda () (call fun/ascii-char51645)))
    (define fun/error51648 (lambda () (call fun/error51649)))
    (define fun/error51649 (lambda () (error 31)))
    (define fun/vector51642 (lambda () (call fun/vector51643)))
    (define fun/ascii-char51647 (lambda () #\c))
    (define fun/void51640 (lambda () (call fun/void51641)))
    (define fun/void51641 (lambda () (void)))
    (define fun/vector51643 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void51640))
          (vector1 (call fun/vector51642))
          (ascii-char2 (call fun/ascii-char51644))
          (ascii-char3 (call fun/ascii-char51646))
          (fixnum4
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
          (error5 (call fun/error51648)))
      void0)))
(check-by-interp
 '(module
    (define fun/ascii-char51656 (lambda () (call fun/ascii-char51657)))
    (define fun/ascii-char51657 (lambda () #\c))
    (define fun/error51658 (lambda () (call fun/error51659)))
    (define fun/void51654 (lambda () (call fun/void51655)))
    (define fun/error51653 (lambda () (error 78)))
    (define fun/void51655 (lambda () (void)))
    (define fun/error51652 (lambda () (call fun/error51653)))
    (define fun/error51659 (lambda () (error 177)))
    (let ((fixnum0
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
          (error1 (call fun/error51652))
          (void2 (call fun/void51654))
          (fixnum3
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
          (ascii-char4 (call fun/ascii-char51656))
          (error5 (call fun/error51658)))
      void2)))
(check-by-interp
 '(module
    (define fun/error54326 (lambda () (call fun/error54327)))
    (define fun/error54322 (lambda () (error 71)))
    (define fun/empty54331 (lambda () empty))
    (define fun/void54329 (lambda () (void)))
    (define fun/error54327 (lambda () (error 67)))
    (define fun/error54325 (lambda () (error 34)))
    (define fun/error54321 (lambda () (call fun/error54322)))
    (define fun/any54323 (lambda () #\c))
    (define fun/void54328 (lambda () (call fun/void54329)))
    (define fun/error54324 (lambda () (call fun/error54325)))
    (define fun/empty54330 (lambda () (call fun/empty54331)))
    (let ((error0 (call fun/error54321))
          (boolean1 (call vector? (call fun/any54323)))
          (error2 (call fun/error54324))
          (error3 (call fun/error54326))
          (void4 (call fun/void54328))
          (empty5 (call fun/empty54330)))
      void4)))
(check-by-interp
 '(module
    (define fun/vector55635 (lambda () (call fun/vector55636)))
    (define fun/error55638 (lambda () (error 40)))
    (define fun/error55631 (lambda () (call fun/error55632)))
    (define fun/void55630 (lambda () (void)))
    (define fun/void55634 (lambda () (void)))
    (define fun/void55629 (lambda () (call fun/void55630)))
    (define fun/void55633 (lambda () (call fun/void55634)))
    (define fun/vector55636 (lambda () (call make-vector 8)))
    (define fun/error55637 (lambda () (call fun/error55638)))
    (define fun/error55632 (lambda () (error 246)))
    (let ((void0 (call fun/void55629))
          (error1 (call fun/error55631))
          (void2 (call fun/void55633))
          (fixnum3
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
          (vector4 (call fun/vector55635))
          (error5 (call fun/error55637)))
      void2)))
(check-by-interp
 '(module
    (define fun/empty57254 (lambda () (call fun/empty57255)))
    (define fun/error57260 (lambda () (call fun/error57261)))
    (define fun/vector57256 (lambda () (call fun/vector57257)))
    (define fun/vector57263 (lambda () (call make-vector 8)))
    (define fun/void57252 (lambda () (call fun/void57253)))
    (define fun/vector57262 (lambda () (call fun/vector57263)))
    (define fun/error57261 (lambda () (error 37)))
    (define fun/empty57255 (lambda () empty))
    (define fun/ascii-char57258 (lambda () (call fun/ascii-char57259)))
    (define fun/void57253 (lambda () (void)))
    (define fun/ascii-char57259 (lambda () #\c))
    (define fun/vector57257 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void57252))
          (empty1 (call fun/empty57254))
          (vector2 (call fun/vector57256))
          (ascii-char3 (call fun/ascii-char57258))
          (error4 (call fun/error57260))
          (vector5 (call fun/vector57262)))
      empty1)))
(check-by-interp
 '(module
    (define fun/empty58674 (lambda () empty))
    (define fun/vector58667 (lambda () (call fun/vector58668)))
    (define fun/vector58670 (lambda () (call make-vector 8)))
    (define fun/vector58669 (lambda () (call fun/vector58670)))
    (define fun/void58671 (lambda () (call fun/void58672)))
    (define fun/void58678 (lambda () (void)))
    (define fun/void58672 (lambda () (void)))
    (define fun/empty58673 (lambda () (call fun/empty58674)))
    (define fun/vector58676 (lambda () (call make-vector 8)))
    (define fun/vector58668 (lambda () (call make-vector 8)))
    (define fun/void58677 (lambda () (call fun/void58678)))
    (define fun/vector58675 (lambda () (call fun/vector58676)))
    (let ((vector0 (call fun/vector58667))
          (vector1 (call fun/vector58669))
          (void2 (call fun/void58671))
          (empty3 (call fun/empty58673))
          (vector4 (call fun/vector58675))
          (void5 (call fun/void58677)))
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
    (define fun/vector62053 (lambda () (call make-vector 8)))
    (define fun/vector62051 (lambda () (call make-vector 8)))
    (define fun/vector62049 (lambda () (call make-vector 8)))
    (define fun/error62058 (lambda () (call fun/error62059)))
    (define fun/ascii-char62054 (lambda () (call fun/ascii-char62055)))
    (define fun/error62059 (lambda () (error 5)))
    (define fun/void62057 (lambda () (void)))
    (define fun/vector62052 (lambda () (call fun/vector62053)))
    (define fun/vector62050 (lambda () (call fun/vector62051)))
    (define fun/void62046 (lambda () (call fun/void62047)))
    (define fun/void62056 (lambda () (call fun/void62057)))
    (define fun/ascii-char62055 (lambda () #\c))
    (define fun/void62047 (lambda () (void)))
    (define fun/vector62048 (lambda () (call fun/vector62049)))
    (let ((void0 (call fun/void62046))
          (vector1 (call fun/vector62048))
          (vector2 (call fun/vector62050))
          (vector3 (call fun/vector62052))
          (ascii-char4 (call fun/ascii-char62054))
          (void5 (call fun/void62056)))
      (call fun/error62058))))
(check-by-interp
 '(module
    (define fun/vector63648 (lambda () (call fun/vector63649)))
    (define fun/ascii-char63654 (lambda () (call fun/ascii-char63655)))
    (define fun/void63653 (lambda () (void)))
    (define fun/vector63649 (lambda () (call make-vector 8)))
    (define fun/ascii-char63650 (lambda () (call fun/ascii-char63651)))
    (define fun/void63652 (lambda () (call fun/void63653)))
    (define fun/ascii-char63655 (lambda () #\c))
    (define fun/ascii-char63651 (lambda () #\c))
    (let ((fixnum0
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
          (vector1 (call fun/vector63648))
          (ascii-char2 (call fun/ascii-char63650))
          (void3 (call fun/void63652))
          (ascii-char4 (call fun/ascii-char63654))
          (fixnum5
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
      (call * fixnum5 fixnum0))))
(check-by-interp
 '(module
    (define fun/ascii-char64319 (lambda () #\c))
    (define fun/error64313 (lambda () (error 103)))
    (define fun/empty64317 (lambda () empty))
    (define fun/ascii-char64318 (lambda () (call fun/ascii-char64319)))
    (define fun/void64310 (lambda () (void)))
    (define fun/empty64315 (lambda () empty))
    (define fun/any64311 (lambda () (error 159)))
    (define fun/error64312 (lambda () (call fun/error64313)))
    (define fun/empty64316 (lambda () (call fun/empty64317)))
    (define fun/empty64314 (lambda () (call fun/empty64315)))
    (define fun/void64309 (lambda () (call fun/void64310)))
    (let ((void0 (call fun/void64309))
          (boolean1 (call boolean? (call fun/any64311)))
          (error2 (call fun/error64312))
          (empty3 (call fun/empty64314))
          (empty4 (call fun/empty64316))
          (fixnum5
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
      (call fun/ascii-char64318))))
(check-by-interp
 '(module
    (define fun/vector64576 (lambda () (call make-vector 8)))
    (define fun/ascii-char64582 (lambda () #\c))
    (define fun/vector64578 (lambda () (call make-vector 8)))
    (define fun/any64574 (lambda () (void)))
    (define fun/vector64579 (lambda () (call fun/vector64580)))
    (define fun/empty64584 (lambda () empty))
    (define fun/empty64583 (lambda () (call fun/empty64584)))
    (define fun/ascii-char64581 (lambda () (call fun/ascii-char64582)))
    (define fun/vector64580 (lambda () (call make-vector 8)))
    (define fun/vector64577 (lambda () (call fun/vector64578)))
    (define fun/vector64575 (lambda () (call fun/vector64576)))
    (let ((boolean0 (call boolean? (call fun/any64574)))
          (vector1 (call fun/vector64575))
          (vector2 (call fun/vector64577))
          (vector3 (call fun/vector64579))
          (ascii-char4 (call fun/ascii-char64581))
          (fixnum5
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
      (call fun/empty64583))))
(check-by-interp
 '(module
    (define fun/ascii-char68259 (lambda () #\c))
    (define fun/error68263 (lambda () (error 228)))
    (define fun/vector68261 (lambda () (call make-vector 8)))
    (define fun/void68267 (lambda () (void)))
    (define fun/ascii-char68258 (lambda () (call fun/ascii-char68259)))
    (define fun/error68264 (lambda () (call fun/error68265)))
    (define fun/empty68268 (lambda () (call fun/empty68269)))
    (define fun/empty68269 (lambda () empty))
    (define fun/vector68260 (lambda () (call fun/vector68261)))
    (define fun/error68265 (lambda () (error 141)))
    (define fun/void68266 (lambda () (call fun/void68267)))
    (define fun/error68262 (lambda () (call fun/error68263)))
    (let ((ascii-char0 (call fun/ascii-char68258))
          (vector1 (call fun/vector68260))
          (fixnum2
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
          (error3 (call fun/error68262))
          (error4 (call fun/error68264))
          (void5 (call fun/void68266)))
      (call fun/empty68268))))
(check-by-interp
 '(module
    (define fun/ascii-char72253 (lambda () (call fun/ascii-char72254)))
    (define fun/error72257 (lambda () (call fun/error72258)))
    (define fun/void72255 (lambda () (call fun/void72256)))
    (define fun/vector72259 (lambda () (call fun/vector72260)))
    (define fun/ascii-char72254 (lambda () #\c))
    (define fun/vector72260 (lambda () (call make-vector 8)))
    (define fun/error72251 (lambda () (call fun/error72252)))
    (define fun/error72252 (lambda () (error 225)))
    (define fun/error72258 (lambda () (error 56)))
    (define fun/void72256 (lambda () (void)))
    (let ((error0 (call fun/error72251))
          (ascii-char1 (call fun/ascii-char72253))
          (fixnum2
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
          (void3 (call fun/void72255))
          (error4 (call fun/error72257))
          (vector5 (call fun/vector72259)))
      error4)))
(check-by-interp
 '(module
    (define fun/void73796 (lambda () (call fun/void73797)))
    (define fun/ascii-char73795 (lambda () #\c))
    (define fun/error73801 (lambda () (call fun/error73802)))
    (define fun/vector73799 (lambda () (call fun/vector73800)))
    (define fun/error73802 (lambda () (error 201)))
    (define fun/vector73800 (lambda () (call make-vector 8)))
    (define fun/any73798 (lambda () (error 149)))
    (define fun/ascii-char73794 (lambda () (call fun/ascii-char73795)))
    (define fun/void73797 (lambda () (void)))
    (let ((fixnum0
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
          (ascii-char1 (call fun/ascii-char73794))
          (void2 (call fun/void73796))
          (fixnum3
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
          (boolean4 (call void? (call fun/any73798)))
          (vector5 (call fun/vector73799)))
      (call fun/error73801))))
(check-by-interp
 '(module
    (define fun/void74475 (lambda () (call fun/void74476)))
    (define fun/empty74480 (lambda () empty))
    (define fun/vector74482 (lambda () (call make-vector 8)))
    (define fun/void74476 (lambda () (void)))
    (define fun/empty74477 (lambda () (call fun/empty74478)))
    (define fun/error74474 (lambda () (error 213)))
    (define fun/empty74479 (lambda () (call fun/empty74480)))
    (define fun/empty74478 (lambda () empty))
    (define fun/error74473 (lambda () (call fun/error74474)))
    (define fun/vector74484 (lambda () (call make-vector 8)))
    (define fun/vector74483 (lambda () (call fun/vector74484)))
    (define fun/vector74481 (lambda () (call fun/vector74482)))
    (let ((error0 (call fun/error74473))
          (void1 (call fun/void74475))
          (empty2 (call fun/empty74477))
          (empty3 (call fun/empty74479))
          (vector4 (call fun/vector74481))
          (vector5 (call fun/vector74483)))
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
    (define fun/ascii-char75589 (lambda () (call fun/ascii-char75590)))
    (define fun/void75587 (lambda () (call fun/void75588)))
    (define fun/ascii-char75592 (lambda () (call fun/ascii-char75593)))
    (define fun/any75591 (lambda () (call make-vector 8)))
    (define fun/void75597 (lambda () (void)))
    (define fun/error75595 (lambda () (error 219)))
    (define fun/void75588 (lambda () (void)))
    (define fun/ascii-char75593 (lambda () #\c))
    (define fun/vector75598 (lambda () (call fun/vector75599)))
    (define fun/error75594 (lambda () (call fun/error75595)))
    (define fun/ascii-char75590 (lambda () #\c))
    (define fun/vector75599 (lambda () (call make-vector 8)))
    (define fun/void75596 (lambda () (call fun/void75597)))
    (let ((void0 (call fun/void75587))
          (ascii-char1 (call fun/ascii-char75589))
          (boolean2 (call empty? (call fun/any75591)))
          (ascii-char3 (call fun/ascii-char75592))
          (error4 (call fun/error75594))
          (void5 (call fun/void75596)))
      (call fun/vector75598))))
(check-by-interp
 '(module
    (define fun/void75654 (lambda () (void)))
    (define fun/empty75657 (lambda () (call fun/empty75658)))
    (define fun/ascii-char75662 (lambda () #\c))
    (define fun/ascii-char75660 (lambda () #\c))
    (define fun/empty75656 (lambda () empty))
    (define fun/ascii-char75661 (lambda () (call fun/ascii-char75662)))
    (define fun/empty75658 (lambda () empty))
    (define fun/empty75655 (lambda () (call fun/empty75656)))
    (define fun/void75653 (lambda () (call fun/void75654)))
    (define fun/ascii-char75659 (lambda () (call fun/ascii-char75660)))
    (let ((fixnum0
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
          (void1 (call fun/void75653))
          (empty2 (call fun/empty75655))
          (empty3 (call fun/empty75657))
          (ascii-char4 (call fun/ascii-char75659))
          (ascii-char5 (call fun/ascii-char75661)))
      ascii-char5)))
(check-by-interp
 '(module
    (define fun/error77430 (lambda () (call fun/error77431)))
    (define fun/void77433 (lambda () (void)))
    (define fun/ascii-char77434 (lambda () (call fun/ascii-char77435)))
    (define fun/void77427 (lambda () (call fun/void77428)))
    (define fun/ascii-char77435 (lambda () #\c))
    (define fun/void77428 (lambda () (void)))
    (define fun/any77429 (lambda () (call make-vector 8)))
    (define fun/void77432 (lambda () (call fun/void77433)))
    (define fun/error77431 (lambda () (error 166)))
    (let ((void0 (call fun/void77427))
          (boolean1 (call boolean? (call fun/any77429)))
          (error2 (call fun/error77430))
          (void3 (call fun/void77432))
          (fixnum4
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
          (ascii-char5 (call fun/ascii-char77434)))
      void0)))
(check-by-interp
 '(module
    (define fun/ascii-char79513 (lambda () (call fun/ascii-char79514)))
    (define fun/vector79512 (lambda () (call make-vector 8)))
    (define fun/empty79507 (lambda () (call fun/empty79508)))
    (define fun/empty79508 (lambda () empty))
    (define fun/vector79518 (lambda () (call make-vector 8)))
    (define fun/ascii-char79514 (lambda () #\c))
    (define fun/vector79510 (lambda () (call make-vector 8)))
    (define fun/ascii-char79516 (lambda () #\c))
    (define fun/vector79509 (lambda () (call fun/vector79510)))
    (define fun/ascii-char79515 (lambda () (call fun/ascii-char79516)))
    (define fun/vector79517 (lambda () (call fun/vector79518)))
    (define fun/vector79511 (lambda () (call fun/vector79512)))
    (let ((empty0 (call fun/empty79507))
          (vector1 (call fun/vector79509))
          (vector2 (call fun/vector79511))
          (ascii-char3 (call fun/ascii-char79513))
          (ascii-char4 (call fun/ascii-char79515))
          (vector5 (call fun/vector79517)))
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
    (define fun/ascii-char79834 (lambda () #\c))
    (define fun/error79839 (lambda () (error 220)))
    (define fun/error79838 (lambda () (call fun/error79839)))
    (define fun/any79832 (lambda () 99))
    (define fun/any79836 (lambda () (call make-vector 8)))
    (define fun/ascii-char79831 (lambda () #\c))
    (define fun/any79835 (lambda () 182))
    (define fun/ascii-char79833 (lambda () (call fun/ascii-char79834)))
    (define fun/ascii-char79830 (lambda () (call fun/ascii-char79831)))
    (define fun/any79837 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char79830))
          (boolean1 (call void? (call fun/any79832)))
          (ascii-char2 (call fun/ascii-char79833))
          (boolean3 (call empty? (call fun/any79835)))
          (boolean4 (call void? (call fun/any79836)))
          (boolean5 (call pair? (call fun/any79837))))
      (call fun/error79838))))
(check-by-interp
 '(module
    (define fun/error83230 (lambda () (call fun/error83231)))
    (define fun/empty83233 (lambda () (call fun/empty83234)))
    (define fun/void83236 (lambda () (void)))
    (define fun/ascii-char83229 (lambda () #\c))
    (define fun/void83235 (lambda () (call fun/void83236)))
    (define fun/empty83234 (lambda () empty))
    (define fun/error83231 (lambda () (error 27)))
    (define fun/any83232 (lambda () #\c))
    (define fun/ascii-char83228 (lambda () (call fun/ascii-char83229)))
    (let ((ascii-char0 (call fun/ascii-char83228))
          (error1 (call fun/error83230))
          (boolean2 (call error? (call fun/any83232)))
          (empty3 (call fun/empty83233))
          (void4 (call fun/void83235))
          (fixnum5
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
      void4)))
(check-by-interp
 '(module
    (define fun/empty84384 (lambda () empty))
    (define fun/error84388 (lambda () (error 90)))
    (define fun/ascii-char84389 (lambda () (call fun/ascii-char84390)))
    (define fun/empty84383 (lambda () (call fun/empty84384)))
    (define fun/any84380 (lambda () (call make-vector 8)))
    (define fun/empty84381 (lambda () (call fun/empty84382)))
    (define fun/ascii-char84390 (lambda () #\c))
    (define fun/error84386 (lambda () (error 86)))
    (define fun/empty84382 (lambda () empty))
    (define fun/error84387 (lambda () (call fun/error84388)))
    (define fun/error84385 (lambda () (call fun/error84386)))
    (let ((boolean0 (call boolean? (call fun/any84380)))
          (empty1 (call fun/empty84381))
          (empty2 (call fun/empty84383))
          (error3 (call fun/error84385))
          (fixnum4
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
          (error5 (call fun/error84387)))
      (call fun/ascii-char84389))))
(check-by-interp
 '(module
    (define fun/void86969 (lambda () (void)))
    (define fun/ascii-char86962 (lambda () (call fun/ascii-char86963)))
    (define fun/empty86965 (lambda () empty))
    (define fun/void86968 (lambda () (call fun/void86969)))
    (define fun/empty86964 (lambda () (call fun/empty86965)))
    (define fun/vector86966 (lambda () (call fun/vector86967)))
    (define fun/vector86967 (lambda () (call make-vector 8)))
    (define fun/ascii-char86963 (lambda () #\c))
    (let ((fixnum0
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
          (fixnum1
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
          (ascii-char2 (call fun/ascii-char86962))
          (empty3 (call fun/empty86964))
          (vector4 (call fun/vector86966))
          (void5 (call fun/void86968)))
      ascii-char2)))
(check-by-interp
 '(module
    (define fun/empty87544 (lambda () (call fun/empty87545)))
    (define fun/void87552 (lambda () (void)))
    (define fun/empty87549 (lambda () (call fun/empty87550)))
    (define fun/empty87546 (lambda () (call fun/empty87547)))
    (define fun/empty87547 (lambda () empty))
    (define fun/empty87553 (lambda () (call fun/empty87554)))
    (define fun/empty87550 (lambda () empty))
    (define fun/any87548 (lambda () (call make-vector 8)))
    (define fun/empty87554 (lambda () empty))
    (define fun/void87551 (lambda () (call fun/void87552)))
    (define fun/empty87545 (lambda () empty))
    (let ((empty0 (call fun/empty87544))
          (empty1 (call fun/empty87546))
          (boolean2 (call boolean? (call fun/any87548)))
          (empty3 (call fun/empty87549))
          (void4 (call fun/void87551))
          (empty5 (call fun/empty87553)))
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
    (define fun/ascii-char87923 (lambda () (call fun/ascii-char87924)))
    (define fun/empty87931 (lambda () empty))
    (define fun/ascii-char87928 (lambda () (call fun/ascii-char87929)))
    (define fun/ascii-char87929 (lambda () #\c))
    (define fun/ascii-char87926 (lambda () #\c))
    (define fun/empty87930 (lambda () (call fun/empty87931)))
    (define fun/void87922 (lambda () (void)))
    (define fun/any87927 (lambda () (void)))
    (define fun/ascii-char87925 (lambda () (call fun/ascii-char87926)))
    (define fun/ascii-char87924 (lambda () #\c))
    (define fun/void87921 (lambda () (call fun/void87922)))
    (let ((void0 (call fun/void87921))
          (ascii-char1 (call fun/ascii-char87923))
          (ascii-char2 (call fun/ascii-char87925))
          (boolean3 (call error? (call fun/any87927)))
          (ascii-char4 (call fun/ascii-char87928))
          (empty5 (call fun/empty87930)))
      empty5)))
(check-by-interp
 '(module
    (define fun/void88023 (lambda () (void)))
    (define fun/empty88027 (lambda () empty))
    (define fun/error88024 (lambda () (call fun/error88025)))
    (define fun/error88021 (lambda () (error 222)))
    (define fun/empty88026 (lambda () (call fun/empty88027)))
    (define fun/error88029 (lambda () (error 197)))
    (define fun/error88020 (lambda () (call fun/error88021)))
    (define fun/error88025 (lambda () (error 212)))
    (define fun/void88022 (lambda () (call fun/void88023)))
    (define fun/error88028 (lambda () (call fun/error88029)))
    (let ((error0 (call fun/error88020))
          (void1 (call fun/void88022))
          (error2 (call fun/error88024))
          (fixnum3
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
          (empty4 (call fun/empty88026))
          (error5 (call fun/error88028)))
      error0)))
(check-by-interp
 '(module
    (define fun/empty93911 (lambda () (call fun/empty93912)))
    (define fun/ascii-char93914 (lambda () #\c))
    (define fun/vector93909 (lambda () (call fun/vector93910)))
    (define fun/error93916 (lambda () (error 235)))
    (define fun/void93907 (lambda () (call fun/void93908)))
    (define fun/vector93910 (lambda () (call make-vector 8)))
    (define fun/empty93912 (lambda () empty))
    (define fun/void93908 (lambda () (void)))
    (define fun/ascii-char93913 (lambda () (call fun/ascii-char93914)))
    (define fun/error93915 (lambda () (call fun/error93916)))
    (let ((void0 (call fun/void93907))
          (fixnum1
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
          (vector2 (call fun/vector93909))
          (empty3 (call fun/empty93911))
          (ascii-char4 (call fun/ascii-char93913))
          (fixnum5
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
      (call fun/error93915))))
(check-by-interp
 '(module
    (define fun/vector95234 (lambda () (call make-vector 8)))
    (define fun/vector95231 (lambda () (call fun/vector95232)))
    (define fun/vector95236 (lambda () (call make-vector 8)))
    (define fun/ascii-char95237 (lambda () (call fun/ascii-char95238)))
    (define fun/ascii-char95238 (lambda () #\c))
    (define fun/vector95232 (lambda () (call make-vector 8)))
    (define fun/vector95233 (lambda () (call fun/vector95234)))
    (define fun/vector95235 (lambda () (call fun/vector95236)))
    (let ((vector0 (call fun/vector95231))
          (vector1 (call fun/vector95233))
          (vector2 (call fun/vector95235))
          (ascii-char3 (call fun/ascii-char95237))
          (fixnum4
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
          (fixnum5
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
      fixnum5)))
(check-by-interp
 '(module
    (define fun/ascii-char95245 (lambda () #\c))
    (define fun/empty95247 (lambda () empty))
    (define fun/void95242 (lambda () (void)))
    (define fun/void95241 (lambda () (call fun/void95242)))
    (define fun/any95243 (lambda () (void)))
    (define fun/ascii-char95244 (lambda () (call fun/ascii-char95245)))
    (define fun/empty95246 (lambda () (call fun/empty95247)))
    (let ((void0 (call fun/void95241))
          (boolean1 (call pair? (call fun/any95243)))
          (ascii-char2 (call fun/ascii-char95244))
          (fixnum3
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
          (empty4 (call fun/empty95246))
          (fixnum5
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
      ascii-char2)))
(check-by-interp
 '(module
    (define fun/vector99282 (lambda () (call fun/vector99283)))
    (define fun/ascii-char99281 (lambda () #\c))
    (define fun/ascii-char99280 (lambda () (call fun/ascii-char99281)))
    (define fun/vector99275 (lambda () (call make-vector 8)))
    (define fun/error99284 (lambda () (call fun/error99285)))
    (define fun/empty99277 (lambda () empty))
    (define fun/empty99276 (lambda () (call fun/empty99277)))
    (define fun/empty99278 (lambda () (call fun/empty99279)))
    (define fun/empty99279 (lambda () empty))
    (define fun/vector99283 (lambda () (call make-vector 8)))
    (define fun/vector99274 (lambda () (call fun/vector99275)))
    (define fun/error99285 (lambda () (error 160)))
    (let ((vector0 (call fun/vector99274))
          (empty1 (call fun/empty99276))
          (empty2 (call fun/empty99278))
          (ascii-char3 (call fun/ascii-char99280))
          (vector4 (call fun/vector99282))
          (error5 (call fun/error99284)))
      ascii-char3)))
(check-by-interp
 '(module
    (define fun/ascii-char101002 (lambda () #\c))
    (define fun/void101005 (lambda () (call fun/void101006)))
    (define fun/ascii-char101007 (lambda () (call fun/ascii-char101008)))
    (define fun/ascii-char101000 (lambda () #\c))
    (define fun/void101004 (lambda () (void)))
    (define fun/ascii-char100999 (lambda () (call fun/ascii-char101000)))
    (define fun/ascii-char101008 (lambda () #\c))
    (define fun/void101003 (lambda () (call fun/void101004)))
    (define fun/void101006 (lambda () (void)))
    (define fun/ascii-char101001 (lambda () (call fun/ascii-char101002)))
    (let ((ascii-char0 (call fun/ascii-char100999))
          (fixnum1
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
          (ascii-char2 (call fun/ascii-char101001))
          (void3 (call fun/void101003))
          (void4 (call fun/void101005))
          (ascii-char5 (call fun/ascii-char101007)))
      ascii-char5)))
(check-by-interp
 '(module
    (define fun/void102209 (lambda () (void)))
    (define fun/any102211 (lambda () #t))
    (define fun/empty102210 (lambda () empty))
    (define fun/error102205 (lambda () (error 4)))
    (define fun/ascii-char102208 (lambda () #\c))
    (define fun/ascii-char102207 (lambda () #\c))
    (define fun/vector102206 (lambda () (call make-vector 8)))
    (call
     boolean?
     (let ((error0 (call fun/error102205))
           (vector1 (call fun/vector102206))
           (ascii-char2 (call fun/ascii-char102207))
           (ascii-char3 (call fun/ascii-char102208))
           (void4 (call fun/void102209))
           (empty5 (call fun/empty102210)))
       (call fun/any102211)))))
(check-by-interp
 '(module
    (define fun/error102221 (lambda () (error 8)))
    (define fun/void102218 (lambda () (call fun/void102219)))
    (define fun/empty102216 (lambda () (call fun/empty102217)))
    (define fun/ascii-char102223 (lambda () #\c))
    (define fun/void102214 (lambda () (call fun/void102215)))
    (define fun/empty102217 (lambda () empty))
    (define fun/error102220 (lambda () (call fun/error102221)))
    (define fun/void102219 (lambda () (void)))
    (define fun/ascii-char102222 (lambda () (call fun/ascii-char102223)))
    (define fun/void102215 (lambda () (void)))
    (let ((void0 (call fun/void102214))
          (empty1 (call fun/empty102216))
          (void2 (call fun/void102218))
          (error3 (call fun/error102220))
          (fixnum4
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
          (ascii-char5 (call fun/ascii-char102222)))
      error3)))
(check-by-interp
 '(module
    (define fun/void102243 (lambda () (call fun/void102244)))
    (define fun/any102238 (lambda () #f))
    (define fun/ascii-char102236 (lambda () (call fun/ascii-char102237)))
    (define fun/void102241 (lambda () (call fun/void102242)))
    (define fun/ascii-char102239 (lambda () (call fun/ascii-char102240)))
    (define fun/ascii-char102234 (lambda () (call fun/ascii-char102235)))
    (define fun/void102244 (lambda () (void)))
    (define fun/void102242 (lambda () (void)))
    (define fun/ascii-char102240 (lambda () #\c))
    (define fun/ascii-char102237 (lambda () #\c))
    (define fun/ascii-char102235 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char102234))
          (ascii-char1 (call fun/ascii-char102236))
          (boolean2 (call vector? (call fun/any102238)))
          (ascii-char3 (call fun/ascii-char102239))
          (void4 (call fun/void102241))
          (void5 (call fun/void102243)))
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
    (define fun/error102248 (lambda () (error 56)))
    (define fun/empty102249 (lambda () (call fun/empty102250)))
    (define fun/void102254 (lambda () (void)))
    (define fun/void102253 (lambda () (call fun/void102254)))
    (define fun/error102247 (lambda () (call fun/error102248)))
    (define fun/vector102252 (lambda () (call make-vector 8)))
    (define fun/empty102250 (lambda () empty))
    (define fun/vector102251 (lambda () (call fun/vector102252)))
    (let ((error0 (call fun/error102247))
          (empty1 (call fun/empty102249))
          (vector2 (call fun/vector102251))
          (void3 (call fun/void102253))
          (fixnum4
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
          (fixnum5
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
       (call + (call + (call - 238 43) (call * 221 81)) fixnum4)
       (call - (call * (call - 214 78) fixnum5) fixnum5)))))
(check-by-interp
 '(module
    (define fun/ascii-char102449 (lambda () (call fun/ascii-char102450)))
    (define fun/ascii-char102450 (lambda () #\c))
    (define fun/ascii-char102444 (lambda () #\c))
    (define fun/vector102446 (lambda () (call make-vector 8)))
    (define fun/void102447 (lambda () (call fun/void102448)))
    (define fun/ascii-char102443 (lambda () (call fun/ascii-char102444)))
    (define fun/vector102445 (lambda () (call fun/vector102446)))
    (define fun/void102448 (lambda () (void)))
    (let ((fixnum0
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
          (ascii-char1 (call fun/ascii-char102443))
          (vector2 (call fun/vector102445))
          (void3 (call fun/void102447))
          (fixnum4
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
          (ascii-char5 (call fun/ascii-char102449)))
      ascii-char5)))
(check-by-interp
 '(module
    (define fun/void102461 (lambda () (call fun/void102462)))
    (define fun/void102455 (lambda () (call fun/void102456)))
    (define fun/ascii-char102454 (lambda () #\c))
    (define fun/void102460 (lambda () (void)))
    (define fun/ascii-char102453 (lambda () (call fun/ascii-char102454)))
    (define fun/void102456 (lambda () (void)))
    (define fun/vector102464 (lambda () (call make-vector 8)))
    (define fun/void102462 (lambda () (void)))
    (define fun/void102459 (lambda () (call fun/void102460)))
    (define fun/error102457 (lambda () (call fun/error102458)))
    (define fun/error102458 (lambda () (error 23)))
    (define fun/vector102463 (lambda () (call fun/vector102464)))
    (let ((ascii-char0 (call fun/ascii-char102453))
          (fixnum1
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
          (void2 (call fun/void102455))
          (error3 (call fun/error102457))
          (void4 (call fun/void102459))
          (void5 (call fun/void102461)))
      (call fun/vector102463))))
(check-by-interp
 '(module
    (define fun/empty104399 (lambda () (call fun/empty104400)))
    (define fun/void104397 (lambda () (call fun/void104398)))
    (define fun/error104406 (lambda () (error 206)))
    (define fun/empty104404 (lambda () empty))
    (define fun/empty104400 (lambda () empty))
    (define fun/error104405 (lambda () (call fun/error104406)))
    (define fun/empty104395 (lambda () (call fun/empty104396)))
    (define fun/void104401 (lambda () (call fun/void104402)))
    (define fun/void104398 (lambda () (void)))
    (define fun/void104402 (lambda () (void)))
    (define fun/empty104396 (lambda () empty))
    (define fun/empty104403 (lambda () (call fun/empty104404)))
    (let ((empty0 (call fun/empty104395))
          (void1 (call fun/void104397))
          (empty2 (call fun/empty104399))
          (void3 (call fun/void104401))
          (fixnum4
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
          (empty5 (call fun/empty104403)))
      (call fun/error104405))))
(check-by-interp
 '(module
    (define fun/any105578 (lambda () 188))
    (define fun/error105579 (lambda () (call fun/error105580)))
    (define fun/error105575 (lambda () (error 72)))
    (define fun/ascii-char105573 (lambda () #\c))
    (define fun/error105576 (lambda () (call fun/error105577)))
    (define fun/ascii-char105572 (lambda () (call fun/ascii-char105573)))
    (define fun/void105581 (lambda () (call fun/void105582)))
    (define fun/error105580 (lambda () (error 121)))
    (define fun/error105574 (lambda () (call fun/error105575)))
    (define fun/error105577 (lambda () (error 216)))
    (define fun/void105582 (lambda () (void)))
    (let ((ascii-char0 (call fun/ascii-char105572))
          (error1 (call fun/error105574))
          (error2 (call fun/error105576))
          (boolean3 (call boolean? (call fun/any105578)))
          (error4 (call fun/error105579))
          (void5 (call fun/void105581)))
      void5)))
(check-by-interp
 '(module
    (define fun/void106112 (lambda () (void)))
    (define fun/empty106104 (lambda () (call fun/empty106105)))
    (define fun/any106110 (lambda () (call make-vector 8)))
    (define fun/ascii-char106108 (lambda () (call fun/ascii-char106109)))
    (define fun/empty106105 (lambda () empty))
    (define fun/error106115 (lambda () (error 39)))
    (define fun/ascii-char106109 (lambda () #\c))
    (define fun/empty106107 (lambda () empty))
    (define fun/void106111 (lambda () (call fun/void106112)))
    (define fun/empty106106 (lambda () (call fun/empty106107)))
    (define fun/error106114 (lambda () (call fun/error106115)))
    (define fun/any106113 (lambda () #\c))
    (let ((empty0 (call fun/empty106104))
          (empty1 (call fun/empty106106))
          (ascii-char2 (call fun/ascii-char106108))
          (boolean3 (call vector? (call fun/any106110)))
          (void4 (call fun/void106111))
          (boolean5 (call empty? (call fun/any106113))))
      (call fun/error106114))))
(check-by-interp
 '(module
    (define fun/empty106693 (lambda () empty))
    (define fun/vector106699 (lambda () (call make-vector 8)))
    (define fun/error106696 (lambda () (call fun/error106697)))
    (define fun/void106690 (lambda () (call fun/void106691)))
    (define fun/empty106694 (lambda () (call fun/empty106695)))
    (define fun/error106688 (lambda () (call fun/error106689)))
    (define fun/error106689 (lambda () (error 170)))
    (define fun/error106697 (lambda () (error 2)))
    (define fun/empty106692 (lambda () (call fun/empty106693)))
    (define fun/void106691 (lambda () (void)))
    (define fun/empty106695 (lambda () empty))
    (define fun/vector106698 (lambda () (call fun/vector106699)))
    (let ((error0 (call fun/error106688))
          (void1 (call fun/void106690))
          (empty2 (call fun/empty106692))
          (empty3 (call fun/empty106694))
          (error4 (call fun/error106696))
          (vector5 (call fun/vector106698)))
      empty3)))
(check-by-interp
 '(module
    (define fun/void111190 (lambda () (call fun/void111191)))
    (define fun/empty111194 (lambda () (call fun/empty111195)))
    (define fun/vector111192 (lambda () (call fun/vector111193)))
    (define fun/ascii-char111196 (lambda () (call fun/ascii-char111197)))
    (define fun/empty111195 (lambda () empty))
    (define fun/vector111193 (lambda () (call make-vector 8)))
    (define fun/void111188 (lambda () (call fun/void111189)))
    (define fun/void111191 (lambda () (void)))
    (define fun/ascii-char111197 (lambda () #\c))
    (define fun/any111187 (lambda () 181))
    (define fun/void111189 (lambda () (void)))
    (let ((boolean0 (call boolean? (call fun/any111187)))
          (void1 (call fun/void111188))
          (void2 (call fun/void111190))
          (vector3 (call fun/vector111192))
          (empty4 (call fun/empty111194))
          (ascii-char5 (call fun/ascii-char111196)))
      void2)))
(check-by-interp
 '(module
    (define fun/empty114056 (lambda () (call fun/empty114057)))
    (define fun/vector114061 (lambda () (call make-vector 8)))
    (define fun/error114058 (lambda () (call fun/error114059)))
    (define fun/vector114060 (lambda () (call fun/vector114061)))
    (define fun/void114055 (lambda () (void)))
    (define fun/error114059 (lambda () (error 240)))
    (define fun/empty114057 (lambda () empty))
    (define fun/any114062 (lambda () (error 13)))
    (define fun/ascii-char114064 (lambda () #\c))
    (define fun/ascii-char114063 (lambda () (call fun/ascii-char114064)))
    (define fun/void114054 (lambda () (call fun/void114055)))
    (let ((void0 (call fun/void114054))
          (empty1 (call fun/empty114056))
          (fixnum2
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
          (error3 (call fun/error114058))
          (vector4 (call fun/vector114060))
          (boolean5 (call void? (call fun/any114062))))
      (call fun/ascii-char114063))))
(check-by-interp
 '(module
    (define fun/empty114977 (lambda () empty))
    (define fun/error114968 (lambda () (call fun/error114969)))
    (define fun/ascii-char114974 (lambda () (call fun/ascii-char114975)))
    (define fun/ascii-char114975 (lambda () #\c))
    (define fun/void114971 (lambda () (void)))
    (define fun/void114970 (lambda () (call fun/void114971)))
    (define fun/vector114973 (lambda () (call make-vector 8)))
    (define fun/vector114972 (lambda () (call fun/vector114973)))
    (define fun/error114969 (lambda () (error 15)))
    (define fun/empty114976 (lambda () (call fun/empty114977)))
    (let ((error0 (call fun/error114968))
          (void1 (call fun/void114970))
          (vector2 (call fun/vector114972))
          (fixnum3
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
          (ascii-char4 (call fun/ascii-char114974))
          (empty5 (call fun/empty114976)))
      (call
       +
       (call
        +
        (call + (call + fixnum3 103) (call - 185 fixnum3))
        (call - (call - 194 8) (call * 162 95)))
       fixnum3))))
(check-by-interp
 '(module
    (define fun/empty115317 (lambda () empty))
    (define fun/ascii-char115313 (lambda () (call fun/ascii-char115314)))
    (define fun/vector115319 (lambda () (call fun/vector115320)))
    (define fun/ascii-char115314 (lambda () #\c))
    (define fun/vector115320 (lambda () (call make-vector 8)))
    (define fun/any115318 (lambda () (call make-vector 8)))
    (define fun/any115315 (lambda () (void)))
    (define fun/empty115316 (lambda () (call fun/empty115317)))
    (let ((fixnum0
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
          (ascii-char1 (call fun/ascii-char115313))
          (fixnum2
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
          (boolean3 (call fixnum? (call fun/any115315)))
          (empty4 (call fun/empty115316))
          (boolean5 (call ascii-char? (call fun/any115318))))
      (call fun/vector115319))))
(check-by-interp
 '(module
    (define fun/void121813 (lambda () (void)))
    (define fun/ascii-char121818 (lambda () (call fun/ascii-char121819)))
    (define fun/void121814 (lambda () (call fun/void121815)))
    (define fun/ascii-char121816 (lambda () (call fun/ascii-char121817)))
    (define fun/void121812 (lambda () (call fun/void121813)))
    (define fun/ascii-char121817 (lambda () #\c))
    (define fun/ascii-char121811 (lambda () #\c))
    (define fun/ascii-char121819 (lambda () #\c))
    (define fun/void121815 (lambda () (void)))
    (define fun/ascii-char121810 (lambda () (call fun/ascii-char121811)))
    (define fun/any121809 (lambda () #f))
    (let ((boolean0 (call ascii-char? (call fun/any121809)))
          (ascii-char1 (call fun/ascii-char121810))
          (void2 (call fun/void121812))
          (void3 (call fun/void121814))
          (ascii-char4 (call fun/ascii-char121816))
          (ascii-char5 (call fun/ascii-char121818)))
      ascii-char4)))
(check-by-interp
 '(module
    (define fun/empty122991 (lambda () (call fun/empty122992)))
    (define fun/error122990 (lambda () (error 197)))
    (define fun/vector122986 (lambda () (call make-vector 8)))
    (define fun/void122983 (lambda () (call fun/void122984)))
    (define fun/empty122987 (lambda () (call fun/empty122988)))
    (define fun/vector122985 (lambda () (call fun/vector122986)))
    (define fun/error122989 (lambda () (call fun/error122990)))
    (define fun/empty122992 (lambda () empty))
    (define fun/void122984 (lambda () (void)))
    (define fun/empty122988 (lambda () empty))
    (let ((void0 (call fun/void122983))
          (vector1 (call fun/vector122985))
          (empty2 (call fun/empty122987))
          (error3 (call fun/error122989))
          (empty4 (call fun/empty122991))
          (fixnum5
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
      void0)))
(check-by-interp
 '(module
    (define fun/vector123184 (lambda () (call make-vector 8)))
    (define fun/vector123183 (lambda () (call fun/vector123184)))
    (define fun/ascii-char123186 (lambda () #\c))
    (define fun/void123179 (lambda () (call fun/void123180)))
    (define fun/void123182 (lambda () (void)))
    (define fun/ascii-char123185 (lambda () (call fun/ascii-char123186)))
    (define fun/void123180 (lambda () (void)))
    (define fun/void123181 (lambda () (call fun/void123182)))
    (let ((void0 (call fun/void123179))
          (void1 (call fun/void123181))
          (fixnum2
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
          (vector3 (call fun/vector123183))
          (ascii-char4 (call fun/ascii-char123185))
          (fixnum5
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
       fixnum5
       (call
        *
        (call + (call * 53 46) (call * 95 fixnum5))
        (call * (call * fixnum5 111) (call - fixnum5 147)))))))
(check-by-interp
 '(module
    (define fun/ascii-char124852 (lambda () (call fun/ascii-char124853)))
    (define fun/vector124858 (lambda () (call fun/vector124859)))
    (define fun/error124850 (lambda () (call fun/error124851)))
    (define fun/void124857 (lambda () (void)))
    (define fun/empty124854 (lambda () (call fun/empty124855)))
    (define fun/error124851 (lambda () (error 183)))
    (define fun/vector124859 (lambda () (call make-vector 8)))
    (define fun/ascii-char124853 (lambda () #\c))
    (define fun/empty124855 (lambda () empty))
    (define fun/void124856 (lambda () (call fun/void124857)))
    (let ((error0 (call fun/error124850))
          (ascii-char1 (call fun/ascii-char124852))
          (fixnum2
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
          (empty3 (call fun/empty124854))
          (void4 (call fun/void124856))
          (vector5 (call fun/vector124858)))
      (call - fixnum2 fixnum2))))
(check-by-interp
 '(module
    (define fun/empty126141 (lambda () empty))
    (define fun/vector126136 (lambda () (call fun/vector126137)))
    (define fun/ascii-char126144 (lambda () (call fun/ascii-char126145)))
    (define fun/vector126138 (lambda () (call fun/vector126139)))
    (define fun/ascii-char126147 (lambda () #\c))
    (define fun/vector126137 (lambda () (call make-vector 8)))
    (define fun/empty126140 (lambda () (call fun/empty126141)))
    (define fun/ascii-char126145 (lambda () #\c))
    (define fun/void126142 (lambda () (call fun/void126143)))
    (define fun/void126143 (lambda () (void)))
    (define fun/ascii-char126146 (lambda () (call fun/ascii-char126147)))
    (define fun/vector126139 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector126136))
          (vector1 (call fun/vector126138))
          (empty2 (call fun/empty126140))
          (void3 (call fun/void126142))
          (ascii-char4 (call fun/ascii-char126144))
          (ascii-char5 (call fun/ascii-char126146)))
      vector1)))
(check-by-interp
 '(module
    (define fun/empty127626 (lambda () empty))
    (define fun/ascii-char127627 (lambda () (call fun/ascii-char127628)))
    (define fun/vector127623 (lambda () (call fun/vector127624)))
    (define fun/ascii-char127628 (lambda () #\c))
    (define fun/vector127624 (lambda () (call make-vector 8)))
    (define fun/empty127625 (lambda () (call fun/empty127626)))
    (define fun/any127629 (lambda () 22))
    (let ((vector0 (call fun/vector127623))
          (empty1 (call fun/empty127625))
          (ascii-char2 (call fun/ascii-char127627))
          (fixnum3
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
          (fixnum4
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
          (boolean5 (call void? (call fun/any127629))))
      empty1)))
(check-by-interp
 '(module
    (define fun/error127697 (lambda () (error 97)))
    (define fun/empty127695 (lambda () empty))
    (define fun/vector127702 (lambda () (call fun/vector127703)))
    (define fun/empty127699 (lambda () empty))
    (define fun/vector127701 (lambda () (call make-vector 8)))
    (define fun/empty127698 (lambda () (call fun/empty127699)))
    (define fun/empty127694 (lambda () (call fun/empty127695)))
    (define fun/any127693 (lambda () (void)))
    (define fun/vector127703 (lambda () (call make-vector 8)))
    (define fun/vector127700 (lambda () (call fun/vector127701)))
    (define fun/error127696 (lambda () (call fun/error127697)))
    (let ((boolean0 (call boolean? (call fun/any127693)))
          (empty1 (call fun/empty127694))
          (error2 (call fun/error127696))
          (empty3 (call fun/empty127698))
          (vector4 (call fun/vector127700))
          (vector5 (call fun/vector127702)))
      empty3)))
(check-by-interp
 '(module
    (define fun/error128005 (lambda () (call fun/error128006)))
    (define fun/empty128002 (lambda () empty))
    (define fun/void128004 (lambda () (void)))
    (define fun/empty128001 (lambda () (call fun/empty128002)))
    (define fun/empty128008 (lambda () empty))
    (define fun/error128006 (lambda () (error 36)))
    (define fun/empty128007 (lambda () (call fun/empty128008)))
    (define fun/void128003 (lambda () (call fun/void128004)))
    (let ((fixnum0
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
          (empty1 (call fun/empty128001))
          (void2 (call fun/void128003))
          (error3 (call fun/error128005))
          (fixnum4
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
          (empty5 (call fun/empty128007)))
      empty5)))
(check-by-interp
 '(module
    (define fun/vector129065 (lambda () (call fun/vector129066)))
    (define fun/void129062 (lambda () (void)))
    (define fun/error129060 (lambda () (error 246)))
    (define fun/ascii-char129058 (lambda () #\c))
    (define fun/empty129067 (lambda () (call fun/empty129068)))
    (define fun/void129061 (lambda () (call fun/void129062)))
    (define fun/vector129066 (lambda () (call make-vector 8)))
    (define fun/empty129063 (lambda () (call fun/empty129064)))
    (define fun/empty129068 (lambda () empty))
    (define fun/empty129064 (lambda () empty))
    (define fun/error129059 (lambda () (call fun/error129060)))
    (define fun/ascii-char129057 (lambda () (call fun/ascii-char129058)))
    (let ((ascii-char0 (call fun/ascii-char129057))
          (error1 (call fun/error129059))
          (void2 (call fun/void129061))
          (empty3 (call fun/empty129063))
          (vector4 (call fun/vector129065))
          (empty5 (call fun/empty129067)))
      ascii-char0)))
(check-by-interp
 '(module
    (define fun/ascii-char129307 (lambda () #\c))
    (define fun/vector129308 (lambda () (call fun/vector129309)))
    (define fun/empty129300 (lambda () (call fun/empty129301)))
    (define fun/ascii-char129302 (lambda () (call fun/ascii-char129303)))
    (define fun/void129305 (lambda () (void)))
    (define fun/vector129309 (lambda () (call make-vector 8)))
    (define fun/ascii-char129306 (lambda () (call fun/ascii-char129307)))
    (define fun/void129304 (lambda () (call fun/void129305)))
    (define fun/empty129301 (lambda () empty))
    (define fun/ascii-char129303 (lambda () #\c))
    (let ((fixnum0
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
          (empty1 (call fun/empty129300))
          (ascii-char2 (call fun/ascii-char129302))
          (void3 (call fun/void129304))
          (ascii-char4 (call fun/ascii-char129306))
          (fixnum5
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
      (call fun/vector129308))))
(check-by-interp
 '(module
    (define fun/ascii-char129869 (lambda () (call fun/ascii-char129870)))
    (define fun/void129872 (lambda () (void)))
    (define fun/vector129866 (lambda () (call make-vector 8)))
    (define fun/void129868 (lambda () (void)))
    (define fun/empty129864 (lambda () empty))
    (define fun/error129874 (lambda () (error 213)))
    (define fun/void129871 (lambda () (call fun/void129872)))
    (define fun/error129873 (lambda () (call fun/error129874)))
    (define fun/void129867 (lambda () (call fun/void129868)))
    (define fun/ascii-char129870 (lambda () #\c))
    (define fun/empty129863 (lambda () (call fun/empty129864)))
    (define fun/vector129865 (lambda () (call fun/vector129866)))
    (let ((fixnum0
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
          (empty1 (call fun/empty129863))
          (vector2 (call fun/vector129865))
          (void3 (call fun/void129867))
          (ascii-char4 (call fun/ascii-char129869))
          (void5 (call fun/void129871)))
      (call fun/error129873))))
(check-by-interp
 '(module
    (define fun/vector136061 (lambda () (call make-vector 8)))
    (define fun/vector136057 (lambda () (call fun/vector136058)))
    (define fun/vector136053 (lambda () (call fun/vector136054)))
    (define fun/empty136063 (lambda () empty))
    (define fun/void136055 (lambda () (call fun/void136056)))
    (define fun/vector136054 (lambda () (call make-vector 8)))
    (define fun/empty136062 (lambda () (call fun/empty136063)))
    (define fun/vector136060 (lambda () (call fun/vector136061)))
    (define fun/void136056 (lambda () (void)))
    (define fun/vector136058 (lambda () (call make-vector 8)))
    (define fun/any136059 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector136053))
          (void1 (call fun/void136055))
          (vector2 (call fun/vector136057))
          (boolean3 (call boolean? (call fun/any136059)))
          (fixnum4
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
          (vector5 (call fun/vector136060)))
      (call fun/empty136062))))
(check-by-interp
 '(module
    (define fun/ascii-char136498 (lambda () #\c))
    (define fun/vector136499 (lambda () (call fun/vector136500)))
    (define fun/vector136500 (lambda () (call make-vector 8)))
    (define fun/ascii-char136497 (lambda () (call fun/ascii-char136498)))
    (let ((fixnum0
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
          (fixnum1
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
          (fixnum2
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
          (fixnum3
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
          (ascii-char4 (call fun/ascii-char136497))
          (vector5 (call fun/vector136499)))
      vector5)))
(check-by-interp
 '(module
    (define fun/vector136507 (lambda () (call make-vector 8)))
    (define fun/any136503 (lambda () empty))
    (define fun/void136504 (lambda () (call fun/void136505)))
    (define fun/vector136506 (lambda () (call fun/vector136507)))
    (define fun/empty136512 (lambda () (call fun/empty136513)))
    (define fun/empty136508 (lambda () (call fun/empty136509)))
    (define fun/void136505 (lambda () (void)))
    (define fun/error136510 (lambda () (call fun/error136511)))
    (define fun/empty136513 (lambda () empty))
    (define fun/empty136509 (lambda () empty))
    (define fun/error136511 (lambda () (error 63)))
    (let ((boolean0 (call ascii-char? (call fun/any136503)))
          (void1 (call fun/void136504))
          (vector2 (call fun/vector136506))
          (empty3 (call fun/empty136508))
          (error4 (call fun/error136510))
          (empty5 (call fun/empty136512)))
      empty5)))
(check-by-interp
 '(module
    (define fun/vector136833 (lambda () (call make-vector 8)))
    (define fun/ascii-char136836 (lambda () (call fun/ascii-char136837)))
    (define fun/void136830 (lambda () (call fun/void136831)))
    (define fun/error136841 (lambda () (error 173)))
    (define fun/error136840 (lambda () (call fun/error136841)))
    (define fun/ascii-char136837 (lambda () #\c))
    (define fun/ascii-char136834 (lambda () (call fun/ascii-char136835)))
    (define fun/vector136832 (lambda () (call fun/vector136833)))
    (define fun/void136831 (lambda () (void)))
    (define fun/empty136839 (lambda () empty))
    (define fun/ascii-char136835 (lambda () #\c))
    (define fun/empty136838 (lambda () (call fun/empty136839)))
    (let ((void0 (call fun/void136830))
          (vector1 (call fun/vector136832))
          (ascii-char2 (call fun/ascii-char136834))
          (ascii-char3 (call fun/ascii-char136836))
          (empty4 (call fun/empty136838))
          (error5 (call fun/error136840)))
      empty4)))
(check-by-interp
 '(module
    (define fun/void137024 (lambda () (void)))
    (define fun/error137026 (lambda () (error 45)))
    (define fun/any137022 (lambda () (void)))
    (define fun/error137025 (lambda () (call fun/error137026)))
    (define fun/void137023 (lambda () (call fun/void137024)))
    (define fun/empty137020 (lambda () (call fun/empty137021)))
    (define fun/vector137029 (lambda () (call fun/vector137030)))
    (define fun/empty137021 (lambda () empty))
    (define fun/empty137027 (lambda () (call fun/empty137028)))
    (define fun/vector137030 (lambda () (call make-vector 8)))
    (define fun/empty137028 (lambda () empty))
    (define fun/any137019 (lambda () 177))
    (let ((boolean0 (call empty? (call fun/any137019)))
          (empty1 (call fun/empty137020))
          (boolean2 (call boolean? (call fun/any137022)))
          (void3 (call fun/void137023))
          (error4 (call fun/error137025))
          (empty5 (call fun/empty137027)))
      (call fun/vector137029))))
(check-by-interp
 '(module
    (define fun/empty137626 (lambda () (call fun/empty137627)))
    (define fun/any137625 (lambda () (error 77)))
    (define fun/ascii-char137633 (lambda () #\c))
    (define fun/ascii-char137631 (lambda () #\c))
    (define fun/vector137628 (lambda () (call fun/vector137629)))
    (define fun/ascii-char137632 (lambda () (call fun/ascii-char137633)))
    (define fun/ascii-char137630 (lambda () (call fun/ascii-char137631)))
    (define fun/empty137627 (lambda () empty))
    (define fun/ascii-char137634 (lambda () (call fun/ascii-char137635)))
    (define fun/vector137629 (lambda () (call make-vector 8)))
    (define fun/ascii-char137635 (lambda () #\c))
    (let ((boolean0 (call boolean? (call fun/any137625)))
          (empty1 (call fun/empty137626))
          (vector2 (call fun/vector137628))
          (ascii-char3 (call fun/ascii-char137630))
          (ascii-char4 (call fun/ascii-char137632))
          (ascii-char5 (call fun/ascii-char137634)))
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
    (define fun/empty138255 (lambda () empty))
    (define fun/error138252 (lambda () (call fun/error138253)))
    (define fun/vector138260 (lambda () (call fun/vector138261)))
    (define fun/error138259 (lambda () (error 211)))
    (define fun/vector138262 (lambda () (call fun/vector138263)))
    (define fun/empty138256 (lambda () (call fun/empty138257)))
    (define fun/error138258 (lambda () (call fun/error138259)))
    (define fun/vector138261 (lambda () (call make-vector 8)))
    (define fun/empty138257 (lambda () empty))
    (define fun/empty138254 (lambda () (call fun/empty138255)))
    (define fun/error138253 (lambda () (error 15)))
    (define fun/vector138263 (lambda () (call make-vector 8)))
    (let ((error0 (call fun/error138252))
          (empty1 (call fun/empty138254))
          (empty2 (call fun/empty138256))
          (error3 (call fun/error138258))
          (vector4 (call fun/vector138260))
          (vector5 (call fun/vector138262)))
      vector4)))
(check-by-interp
 '(module
    (define fun/ascii-char138303 (lambda () #\c))
    (define fun/empty138301 (lambda () empty))
    (define fun/empty138304 (lambda () (call fun/empty138305)))
    (define fun/empty138307 (lambda () empty))
    (define fun/empty138306 (lambda () (call fun/empty138307)))
    (define fun/ascii-char138302 (lambda () (call fun/ascii-char138303)))
    (define fun/ascii-char138308 (lambda () (call fun/ascii-char138309)))
    (define fun/error138310 (lambda () (call fun/error138311)))
    (define fun/ascii-char138309 (lambda () #\c))
    (define fun/empty138305 (lambda () empty))
    (define fun/empty138300 (lambda () (call fun/empty138301)))
    (define fun/error138311 (lambda () (error 113)))
    (let ((empty0 (call fun/empty138300))
          (ascii-char1 (call fun/ascii-char138302))
          (empty2 (call fun/empty138304))
          (empty3 (call fun/empty138306))
          (fixnum4
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
          (ascii-char5 (call fun/ascii-char138308)))
      (call fun/error138310))))
(check-by-interp
 '(module
    (define fun/error139284 (lambda () (error 62)))
    (define fun/ascii-char139281 (lambda () (call fun/ascii-char139282)))
    (define fun/error139283 (lambda () (call fun/error139284)))
    (define fun/void139290 (lambda () (void)))
    (define fun/any139288 (lambda () (error 54)))
    (define fun/empty139287 (lambda () empty))
    (define fun/ascii-char139282 (lambda () #\c))
    (define fun/any139285 (lambda () empty))
    (define fun/void139289 (lambda () (call fun/void139290)))
    (define fun/empty139286 (lambda () (call fun/empty139287)))
    (let ((ascii-char0 (call fun/ascii-char139281))
          (error1 (call fun/error139283))
          (boolean2 (call fixnum? (call fun/any139285)))
          (empty3 (call fun/empty139286))
          (fixnum4
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
          (boolean5 (call boolean? (call fun/any139288))))
      (call fun/void139289))))
(check-by-interp
 '(module
    (define fun/void140574 (lambda () (void)))
    (define fun/empty140576 (lambda () empty))
    (define fun/empty140575 (lambda () (call fun/empty140576)))
    (define fun/void140573 (lambda () (call fun/void140574)))
    (let ((fixnum0
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
          (fixnum1
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
          (fixnum2
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
          (void3 (call fun/void140573))
          (fixnum4
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
          (empty5 (call fun/empty140575)))
      void3)))
(check-by-interp
 '(module
    (define fun/empty141807 (lambda () empty))
    (define fun/void141798 (lambda () (call fun/void141799)))
    (define fun/empty141806 (lambda () (call fun/empty141807)))
    (define fun/error141804 (lambda () (call fun/error141805)))
    (define fun/void141799 (lambda () (void)))
    (define fun/ascii-char141800 (lambda () (call fun/ascii-char141801)))
    (define fun/vector141808 (lambda () (call fun/vector141809)))
    (define fun/void141803 (lambda () (void)))
    (define fun/error141805 (lambda () (error 14)))
    (define fun/void141802 (lambda () (call fun/void141803)))
    (define fun/ascii-char141801 (lambda () #\c))
    (define fun/vector141809 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void141798))
          (ascii-char1 (call fun/ascii-char141800))
          (fixnum2
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
          (void3 (call fun/void141802))
          (error4 (call fun/error141804))
          (empty5 (call fun/empty141806)))
      (call fun/vector141808))))
(check-by-interp
 '(module
    (define fun/vector143565 (lambda () (call make-vector 8)))
    (define fun/error143561 (lambda () (error 242)))
    (define fun/error143558 (lambda () (call fun/error143559)))
    (define fun/ascii-char143563 (lambda () #\c))
    (define fun/error143559 (lambda () (error 14)))
    (define fun/void143554 (lambda () (call fun/void143555)))
    (define fun/ascii-char143562 (lambda () (call fun/ascii-char143563)))
    (define fun/error143560 (lambda () (call fun/error143561)))
    (define fun/error143556 (lambda () (call fun/error143557)))
    (define fun/error143557 (lambda () (error 171)))
    (define fun/void143555 (lambda () (void)))
    (define fun/vector143564 (lambda () (call fun/vector143565)))
    (let ((void0 (call fun/void143554))
          (error1 (call fun/error143556))
          (error2 (call fun/error143558))
          (error3 (call fun/error143560))
          (ascii-char4 (call fun/ascii-char143562))
          (vector5 (call fun/vector143564)))
      ascii-char4)))
(check-by-interp
 '(module
    (define fun/ascii-char143653 (lambda () #\c))
    (define fun/vector143650 (lambda () (call fun/vector143651)))
    (define fun/empty143648 (lambda () (call fun/empty143649)))
    (define fun/error143658 (lambda () (call fun/error143659)))
    (define fun/empty143656 (lambda () (call fun/empty143657)))
    (define fun/empty143657 (lambda () empty))
    (define fun/error143659 (lambda () (error 8)))
    (define fun/ascii-char143655 (lambda () #\c))
    (define fun/vector143651 (lambda () (call make-vector 8)))
    (define fun/empty143649 (lambda () empty))
    (define fun/ascii-char143654 (lambda () (call fun/ascii-char143655)))
    (define fun/ascii-char143652 (lambda () (call fun/ascii-char143653)))
    (let ((empty0 (call fun/empty143648))
          (vector1 (call fun/vector143650))
          (ascii-char2 (call fun/ascii-char143652))
          (ascii-char3 (call fun/ascii-char143654))
          (empty4 (call fun/empty143656))
          (error5 (call fun/error143658)))
      vector1)))
(check-by-interp
 '(module
    (define fun/error143927 (lambda () (call fun/error143928)))
    (define fun/ascii-char143929 (lambda () (call fun/ascii-char143930)))
    (define fun/error143928 (lambda () (error 42)))
    (define fun/void143926 (lambda () (void)))
    (define fun/void143924 (lambda () (void)))
    (define fun/void143923 (lambda () (call fun/void143924)))
    (define fun/void143925 (lambda () (call fun/void143926)))
    (define fun/ascii-char143930 (lambda () #\c))
    (let ((fixnum0
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
          (fixnum1
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
          (void2 (call fun/void143923))
          (void3 (call fun/void143925))
          (error4 (call fun/error143927))
          (fixnum5
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
      (call fun/ascii-char143929))))
