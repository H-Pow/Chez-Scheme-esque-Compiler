#lang racket
(require cpsc411/compiler-lib cpsc411/langs/v8 (only-in "../uniquify.rkt"))
(define (fail-if-invalid p)
  (when (not (exprs-unique-lang-v8? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "exprs-unique-lang-v8"
      " program")))
  p)
(define (check-by-interp p)
  (interp-exprs-lang-v8 p)
  (interp-exprs-unique-lang-v8 (fail-if-invalid (uniquify p))))

(check-by-interp '(module (error 97)))
(check-by-interp '(module empty))
(check-by-interp '(module (let ((boolean0 #t)) (call make-vector 8))))
(check-by-interp
 '(module
    (define fun/vector8387 (lambda () (call make-vector 8)))
    (call fun/vector8387)))
(check-by-interp
 '(module (define fun/void8390 (lambda () (void))) (call fun/void8390)))
(check-by-interp '(module (let ((empty0 empty)) (error 83))))
(check-by-interp '(module (let ((void0 (void)) (ascii-char1 #\c)) 72)))
(check-by-interp
 '(module
    (define fun/void8397 (lambda (oprand0) (void)))
    (call fun/void8397 (let ((ascii-char0 #\c) (boolean1 #f)) #t))))
(check-by-interp '(module (if #t (error 72) (error 224))))
(check-by-interp '(module (if #f #\c #\c)))
(check-by-interp '(module (if #t 30 28)))
(check-by-interp '(module (let ((empty0 empty) (ascii-char1 #\c)) (void))))
(check-by-interp
 '(module
    (define fun/error8412 (lambda (oprand0) (error 116)))
    (call fun/error8412 (let ((void0 (void)) (error1 (error 152))) error1))))
(check-by-interp
 '(module
    (define fun/ascii-char8415 (lambda (oprand0) #\c))
    (call
     fun/ascii-char8415
     (let ((ascii-char0 #\c) (error1 (error 115))) #\c))))
(check-by-interp
 '(module
    (define fun/empty8418 (lambda () empty))
    (define fun/ascii-char8419 (lambda () #\c))
    (let ((fixnum0 (call + 95 114))
          (fixnum1 (call - 48 208))
          (empty2 (call fun/empty8418)))
      (call fun/ascii-char8419))))
(check-by-interp
 '(module
    (define fun/vector8448 (lambda () (call make-vector 8)))
    (define fun/error8449 (lambda () (error 86)))
    (let ((fixnum0 (call * 100 7))
          (vector1 (call fun/vector8448))
          (fixnum2 (call - 208 27)))
      (call fun/error8449))))
(check-by-interp
 '(module
    (define fun/boolean8452 (lambda (oprand0 oprand1) oprand0))
    (define fun/ascii-char8453 (lambda (oprand0 oprand1) #\c))
    (if (call fun/boolean8452 #f #\c)
      (call fun/ascii-char8453 (error 29) (error 79))
      (let ((ascii-char0 #\c) (vector1 (call make-vector 8)) (fixnum2 144))
        ascii-char0))))
(check-by-interp
 '(module
    (define fun/boolean8459 (lambda (oprand0 oprand1) oprand1))
    (define fun/boolean8460 (lambda (oprand0 oprand1) #t))
    (if (call fun/boolean8459 (error 206) #t)
      (if #f #f #t)
      (call fun/boolean8460 (call make-vector 8) (void)))))
(check-by-interp
 '(module
    (define fun/ascii-char8467 (lambda (oprand0 oprand1) oprand0))
    (define fun/void8469 (lambda (oprand0 oprand1) (void)))
    (define fun/empty8468 (lambda (oprand0 oprand1) empty))
    (call
     fun/ascii-char8467
     (let ((ascii-char0 #\c) (empty1 empty) (error2 (error 59))) #\c)
     (call
      fun/empty8468
      (call fun/void8469 (void) #f)
      (if #f (error 170) (error 254))))))
(check-by-interp
 '(module
    (define fun/vector8490 (lambda () (call make-vector 8)))
    (define fun/vector8491 (lambda () (call make-vector 8)))
    (define fun/empty8489 (lambda () empty))
    (let ((empty0 (call fun/empty8489))
          (vector1 (call fun/vector8490))
          (vector2 (call fun/vector8491)))
      empty0)))
(check-by-interp
 '(module
    (define fun/error8496 (lambda (oprand0 oprand1) (error 97)))
    (if (if #t #f #t)
      (call fun/error8496 (call make-vector 8) 77)
      (let ((fixnum0 250) (empty1 empty) (ascii-char2 #\c)) (error 225)))))
(check-by-interp
 '(module
    (define fun/vector8505 (lambda () (call make-vector 8)))
    (define fun/empty8502 (lambda () empty))
    (define fun/ascii-char8503 (lambda () #\c))
    (define fun/ascii-char8504 (lambda () #\c))
    (let ((empty0 (call fun/empty8502))
          (ascii-char1 (call fun/ascii-char8503))
          (ascii-char2 (call fun/ascii-char8504)))
      (call fun/vector8505))))
(check-by-interp
 '(module
    (call
     *
     (call - (if #f 214 86) (if #t 185 16))
     (call
      -
      (if #f 44 33)
      (let ((ascii-char0 #\c) (error1 (error 51)) (empty2 empty)) 76)))))
(check-by-interp
 '(module
    (define fun/void8563 (lambda () (void)))
    (define fun/vector8562 (lambda () (call make-vector 8)))
    (define fun/empty8564 (lambda () empty))
    (let ((vector0 (call fun/vector8562))
          (boolean1 (call fixnum? #f))
          (void2 (call fun/void8563)))
      (call fun/empty8564))))
(check-by-interp
 '(module
    (define fun/boolean8567 (lambda (oprand0 oprand1) #f))
    (if (call fun/boolean8567 #\c #\c)
      (let ((boolean0 #t) (boolean1 #f) (error2 (error 155))) empty)
      (let ((vector0 (call make-vector 8)) (fixnum1 78) (error2 (error 4)))
        empty))))
(check-by-interp
 '(module
    (define fun/boolean8570 (lambda (oprand0 oprand1) #f))
    (define fun/void8571 (lambda (oprand0 oprand1) (void)))
    (if (call fun/boolean8570 (error 247) (error 231))
      (let ((boolean0 #f) (empty1 empty) (vector2 (call make-vector 8)))
        (call vector-set! vector2 7 #\c))
      (call fun/void8571 #\c #f))))
(check-by-interp
 '(module
    (define fun/void8575 (lambda () (void)))
    (define fun/void8576 (lambda () (void)))
    (define fun/vector8574 (lambda () (call make-vector 8)))
    (define fun/empty8577 (lambda () empty))
    (let ((vector0 (call fun/vector8574))
          (void1 (call fun/void8575))
          (void2 (call fun/void8576)))
      (call fun/empty8577))))
(check-by-interp
 '(module
    (define fun/fixnum8668 (lambda (oprand0 oprand1 oprand2) 208))
    (call
     +
     (call
      -
      (call
       -
       (call fun/fixnum8668 #\c (error 242) (call make-vector 8))
       (let ((boolean0 #f) (void1 (void)) (error2 (error 187)) (fixnum3 95))
         173))
      (call + (if #t 102 141) (call + 9 72)))
     (call
      *
      (call
       *
       (if #f 174 247)
       (let ((void0 (void)) (fixnum1 188) (boolean2 #t) (ascii-char3 #\c))
         fixnum1))
      (if #f 71 107)))))
(check-by-interp
 '(module
    (define fun/any8705
      (lambda (oprand0 oprand1 oprand2) (call make-vector 8)))
    (define fun/empty8707 (lambda (oprand0 oprand1 oprand2) empty))
    (define fun/error8706 (lambda (oprand0 oprand1 oprand2) (error 21)))
    (if (call ascii-char? (call fun/any8705 94 #t 149))
      (call
       fun/error8706
       (let ((ascii-char0 #\c)
             (boolean1 #t)
             (error2 (error 24))
             (ascii-char3 #\c))
         empty)
       (call fun/empty8707 (error 235) #\c #\c)
       (if #f (call make-vector 8) (call make-vector 8)))
      (let ((vector0 (call make-vector 8))
            (ascii-char1 #\c)
            (ascii-char2 #\c)
            (fixnum3 46))
        (error 153)))))
(check-by-interp
 '(module
    (define fun/any8734 (lambda (oprand0 oprand1 oprand2) (error 161)))
    (if (call vector? (call fun/any8734 (error 23) empty #\c))
      (call * (call - 185 66) (if #t 186 174))
      (if #t 194 172))))
(check-by-interp
 '(module
    (define fun/void8780 (lambda () (void)))
    (define fun/ascii-char8782 (lambda () #\c))
    (define fun/void8781 (lambda () (void)))
    (define fun/error8783 (lambda () (error 139)))
    (define fun/void8779 (lambda () (void)))
    (let ((void0 (call fun/void8779))
          (void1 (call fun/void8780))
          (void2 (call fun/void8781))
          (ascii-char3 (call fun/ascii-char8782)))
      (call fun/error8783))))
(check-by-interp
 '(module
    (define fun/empty8806 (lambda () empty))
    (define fun/void8807 (lambda () (void)))
    (define fun/ascii-char8808 (lambda () #\c))
    (let ((empty0 (call fun/empty8806))
          (fixnum1 (call - (call - 201 108) (call + 41 44)))
          (fixnum2 (call - (call * 40 131) (call * 137 121)))
          (void3 (call fun/void8807)))
      (call fun/ascii-char8808))))
(check-by-interp
 '(module
    (define fun/void8834 (lambda () (void)))
    (define fun/empty8833 (lambda () empty))
    (define fun/ascii-char8832 (lambda () #\c))
    (define fun/vector8835 (lambda () (call make-vector 8)))
    (let ((fixnum0 (call + (call * 228 35) (call * 172 58)))
          (ascii-char1 (call fun/ascii-char8832))
          (empty2 (call fun/empty8833))
          (void3 (call fun/void8834)))
      (call fun/vector8835))))
(check-by-interp
 '(module
    (if (let ((vector0 (call make-vector 8))
              (void1 (void))
              (fixnum2 3)
              (void3 (void)))
          #f)
      (let ((fixnum0 99) (void1 (void)) (ascii-char2 #\c) (fixnum3 125)) 228)
      (call
       *
       (let ((ascii-char0 #\c)
             (error1 (error 154))
             (fixnum2 220)
             (boolean3 #t))
         250)
       (call * 101 80)))))
(check-by-interp
 '(module
    (define fun/empty9034 (lambda (oprand0 oprand1 oprand2) empty))
    (define fun/error9036 (lambda () (error 184)))
    (define fun/error9035 (lambda () (error 142)))
    (define fun/void9037 (lambda () (void)))
    (define fun/ascii-char9032 (lambda () #\c))
    (define fun/empty9038 (lambda () empty))
    (define fun/ascii-char9031
      (lambda (oprand0 oprand1 oprand2) (call fun/ascii-char9032)))
    (define fun/boolean9033 (lambda (oprand0 oprand1 oprand2) #t))
    (call
     fun/ascii-char9031
     (if (call fun/boolean9033 #\c (error 172) #\c)
       (if #f empty empty)
       (call fun/empty9034 (error 16) (error 232) #t))
     (let ((boolean0 (call vector? #\c))
           (fixnum1 (call + 28 24))
           (error2 (call fun/error9035))
           (error3 (call fun/error9036)))
       (call fixnum? (void)))
     (let ((ascii-char0 (call fun/ascii-char9031 empty #f #t))
           (void1 (call fun/void9037))
           (ascii-char2 (call fun/ascii-char9031 empty #t #f))
           (empty3 (call fun/empty9038)))
       (call error? (void))))))
(check-by-interp
 '(module
    (define fun/void9076 (lambda () (void)))
    (define fun/ascii-char9078 (lambda () #\c))
    (define fun/error9075 (lambda () (error 225)))
    (define fun/empty9077 (lambda () empty))
    (let ((error0 (call fun/error9075))
          (void1 (call fun/void9076))
          (empty2 (call fun/empty9077))
          (ascii-char3 (call fun/ascii-char9078)))
      empty2)))
(check-by-interp
 '(module
    (if (if #f #t #t)
      (let ((fixnum0 215) (fixnum1 123) (void2 (void)) (ascii-char3 #\c))
        fixnum0)
      (if #f 181 177))))
(check-by-interp
 '(module
    (if (let ((fixnum0 159)
              (vector1 (call make-vector 8))
              (boolean2 #t)
              (fixnum3 89))
          boolean2)
      (let ((void0 (void))
            (vector1 (call make-vector 8))
            (ascii-char2 #\c)
            (empty3 empty))
        237)
      (if #f 165 107))))
(check-by-interp
 '(module
    (define fun/error9365 (lambda () (error 242)))
    (define fun/error9364 (lambda () (error 249)))
    (define fun/any9366 (lambda () #t))
    (define fun/error9363 (lambda () (error 238)))
    (define fun/empty9362 (lambda () empty))
    (let ((empty0 (call fun/empty9362))
          (error1 (call fun/error9363))
          (error2 (call fun/error9364))
          (error3 (call fun/error9365)))
      (call boolean? (call fun/any9366)))))
(check-by-interp
 '(module
    (define fun/void9414 (lambda () (void)))
    (define fun/vector9416 (lambda () (call make-vector 8)))
    (define fun/error9415 (lambda () (error 23)))
    (define fun/void9417 (lambda () (void)))
    (let ((void0 (call fun/void9414))
          (error1 (call fun/error9415))
          (vector2 (call fun/vector9416))
          (void3 (call fun/void9417)))
      void3)))
(check-by-interp
 '(module
    (define fun/vector9554 (lambda () (call make-vector 8)))
    (define fun/empty9556 (lambda () empty))
    (define fun/ascii-char9553 (lambda () #\c))
    (define fun/empty9555 (lambda () empty))
    (define fun/error9557 (lambda () (error 43)))
    (let ((ascii-char0 (call fun/ascii-char9553))
          (vector1 (call fun/vector9554))
          (empty2 (call fun/empty9555))
          (empty3 (call fun/empty9556)))
      (call fun/error9557))))
(check-by-interp
 '(module
    (define fun/ascii-char9574 (lambda () #\c))
    (define fun/void9575 (lambda () (void)))
    (define fun/void9573 (lambda () (void)))
    (define fun/empty9572 (lambda () empty))
    (let ((empty0 (call fun/empty9572))
          (void1 (call fun/void9573))
          (ascii-char2 (call fun/ascii-char9574))
          (void3 (call fun/void9575)))
      void1)))
(check-by-interp
 '(module
    (define fun/ascii-char9674 (lambda () #\c))
    (define fun/error9677 (lambda () (error 254)))
    (define fun/any9676 (lambda () #t))
    (define fun/vector9675 (lambda () (call make-vector 8)))
    (let ((ascii-char0 (call fun/ascii-char9674))
          (vector1 (call fun/vector9675))
          (boolean2 (call error? (call fun/any9676)))
          (error3 (call fun/error9677)))
      vector1)))
(check-by-interp
 '(module
    (if (let ((empty0 empty) (fixnum1 121) (void2 (void)) (fixnum3 112)) #f)
      (if #t empty empty)
      (let ((empty0 empty) (error1 (error 165)) (void2 (void)) (fixnum3 124))
        empty))))
(check-by-interp
 '(module
    (define fun/boolean9711 (lambda (oprand0 oprand1 oprand2) #f))
    (define fun/error9714 (lambda (oprand0 oprand1 oprand2) (error 137)))
    (define fun/fixnum9715 (lambda (oprand0 oprand1 oprand2) oprand1))
    (define fun/void9712 (lambda (oprand0 oprand1 oprand2) (void)))
    (define fun/boolean9716 (lambda (oprand0 oprand1 oprand2) #f))
    (define fun/ascii-char9713 (lambda (oprand0 oprand1 oprand2) #\c))
    (if (call
         fun/boolean9711
         (call fun/void9712 #f 78 #\c)
         (let ((empty0 empty)
               (ascii-char1 #\c)
               (vector2 (call make-vector 8))
               (empty3 empty))
           empty0)
         (if #t empty empty))
      (call
       fun/ascii-char9713
       (call fun/error9714 2 43 (void))
       (call fun/fixnum9715 (void) 135 229)
       (call fun/boolean9716 (error 123) (void) (call make-vector 8)))
      (let ((fixnum0 69) (void1 (void)) (boolean2 #t) (ascii-char3 #\c))
        #\c))))
(check-by-interp
 '(module
    (define fun/vector9745 (lambda () (call make-vector 8)))
    (define fun/void9746 (lambda () (void)))
    (define fun/empty9747 (lambda () empty))
    (define fun/any9744 (lambda () 166))
    (let ((boolean0 (call pair? (call fun/any9744)))
          (vector1 (call fun/vector9745))
          (void2 (call fun/void9746))
          (empty3 (call fun/empty9747)))
      vector1)))
(check-by-interp
 '(module
    (define fun/empty9750 (lambda () empty))
    (define fun/error9751 (lambda () (error 123)))
    (define fun/vector9752 (lambda () (call make-vector 8)))
    (define fun/error9753 (lambda () (error 64)))
    (define fun/ascii-char9754 (lambda () #\c))
    (let ((empty0 (call fun/empty9750))
          (error1 (call fun/error9751))
          (vector2 (call fun/vector9752))
          (error3 (call fun/error9753)))
      (call fun/ascii-char9754))))
(check-by-interp
 '(module
    (if (call vector? (if #f (void) (call make-vector 8)))
      (let ((boolean0 #f) (empty1 empty) (boolean2 #t) (boolean3 #t)) #\c)
      (let ((error0 (error 79))
            (empty1 empty)
            (ascii-char2 #\c)
            (ascii-char3 #\c))
        ascii-char2))))
(check-by-interp
 '(module
    (define fun/ascii-char9904 (lambda () #\c))
    (define fun/void9902 (lambda () (void)))
    (define fun/ascii-char9903 (lambda () #\c))
    (let ((void0 (call fun/void9902))
          (ascii-char1 (call fun/ascii-char9903))
          (fixnum2 (call - (call * 63 199) (call * 69 165)))
          (ascii-char3 (call fun/ascii-char9904)))
      void0)))
(check-by-interp
 '(module
    (define fun/void10674 (lambda () (void)))
    (define fun/error10675 (lambda () (error 251)))
    (define fun/void10672 (lambda () (void)))
    (define fun/empty10673 (lambda () empty))
    (let ((fixnum0
           (call
            -
            (call + (call + 139 195) (call - 113 88))
            (call - (call + 27 93) (call - 229 244))))
          (void1 (call fun/void10672))
          (empty2 (call fun/empty10673))
          (void3 (call fun/void10674))
          (fixnum4
           (call
            -
            (call - (call * 95 128) (call + 168 20))
            (call - (call * 142 81) (call * 92 28)))))
      (call fun/error10675))))
(check-by-interp
 '(module
    (define fun/any10855 (lambda () #\c))
    (define fun/ascii-char10854 (lambda () #\c))
    (define fun/empty10856 (lambda () empty))
    (define fun/void10857 (lambda () (void)))
    (let ((ascii-char0 (call fun/ascii-char10854))
          (boolean1 (call ascii-char? (call fun/any10855)))
          (empty2 (call fun/empty10856))
          (fixnum3
           (call
            +
            (call - (call + 169 98) (call - 1 224))
            (call + (call - 14 124) (call + 138 6))))
          (void4 (call fun/void10857)))
      empty2)))
(check-by-interp
 '(module
    (define fun/void11402 (lambda () (void)))
    (define fun/ascii-char11403 (lambda () #\c))
    (define fun/ascii-char11400 (lambda () #\c))
    (define fun/error11401 (lambda () (error 59)))
    (define fun/ascii-char11399 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char11399))
          (ascii-char1 (call fun/ascii-char11400))
          (error2 (call fun/error11401))
          (void3 (call fun/void11402))
          (ascii-char4 (call fun/ascii-char11403)))
      void3)))
(check-by-interp
 '(module
    (define fun/vector12711 (lambda () (call make-vector 8)))
    (define fun/empty12712 (lambda () empty))
    (define fun/vector12714 (lambda () (call make-vector 8)))
    (define fun/void12713 (lambda () (void)))
    (let ((vector0 (call fun/vector12711))
          (empty1 (call fun/empty12712))
          (void2 (call fun/void12713))
          (fixnum3
           (call
            -
            (call * (call * 170 154) (call - 13 71))
            (call - (call * 140 70) (call * 81 61))))
          (vector4 (call fun/vector12714)))
      vector0)))
(check-by-interp
 '(module
    (define fun/vector13203 (lambda () (call make-vector 8)))
    (define fun/error13204 (lambda () (error 157)))
    (define fun/ascii-char13205 (lambda () #\c))
    (let ((vector0 (call fun/vector13203))
          (error1 (call fun/error13204))
          (fixnum2
           (call
            +
            (call - (call - 80 223) (call - 58 99))
            (call + (call + 195 218) (call + 11 57))))
          (fixnum3
           (call
            *
            (call + (call * 62 220) (call - 250 199))
            (call * (call + 29 207) (call + 47 127))))
          (ascii-char4 (call fun/ascii-char13205)))
      vector0)))
(check-by-interp
 '(module
    (define fun/void13621 (lambda () (void)))
    (define fun/ascii-char13620 (lambda () #\c))
    (define fun/empty13623 (lambda () empty))
    (define fun/error13618 (lambda () (error 89)))
    (define fun/void13619 (lambda () (void)))
    (define fun/error13622 (lambda () (error 98)))
    (let ((error0 (call fun/error13618))
          (void1 (call fun/void13619))
          (ascii-char2 (call fun/ascii-char13620))
          (void3 (call fun/void13621))
          (error4 (call fun/error13622)))
      (call fun/empty13623))))
(check-by-interp
 '(module
    (define fun/void13657 (lambda () (void)))
    (define fun/error13660 (lambda () (error 21)))
    (define fun/ascii-char13659 (lambda () #\c))
    (define fun/vector13658 (lambda () (call make-vector 8)))
    (let ((fixnum0
           (call
            +
            (call * (call * 202 235) (call + 148 119))
            (call + (call * 149 216) (call * 253 177))))
          (fixnum1
           (call
            *
            (call - (call + 1 58) (call * 68 174))
            (call * (call - 208 139) (call * 101 233))))
          (void2 (call fun/void13657))
          (vector3 (call fun/vector13658))
          (ascii-char4 (call fun/ascii-char13659)))
      (call fun/error13660))))
(check-by-interp
 '(module
    (define fun/vector13886 (lambda () (call make-vector 8)))
    (define fun/vector13888 (lambda () (call make-vector 8)))
    (define fun/error13885 (lambda () (error 205)))
    (define fun/void13887 (lambda () (void)))
    (define fun/ascii-char13889 (lambda () #\c))
    (let ((error0 (call fun/error13885))
          (vector1 (call fun/vector13886))
          (void2 (call fun/void13887))
          (vector3 (call fun/vector13888))
          (ascii-char4 (call fun/ascii-char13889)))
      vector3)))
(check-by-interp
 '(module
    (define fun/void14228 (lambda () (void)))
    (define fun/empty14229 (lambda () empty))
    (define fun/ascii-char14227 (lambda () #\c))
    (let ((fixnum0
           (call
            +
            (call + (call * 189 166) (call * 136 137))
            (call * (call - 191 104) (call * 24 218))))
          (ascii-char1 (call fun/ascii-char14227))
          (fixnum2
           (call
            *
            (call - (call + 110 180) (call - 79 40))
            (call - (call - 211 45) (call + 225 244))))
          (void3 (call fun/void14228))
          (empty4 (call fun/empty14229)))
      empty4)))
(check-by-interp
 '(module
    (define fun/ascii-char14455 (lambda () #\c))
    (define fun/error14458 (lambda () (error 229)))
    (define fun/vector14457 (lambda () (call make-vector 8)))
    (define fun/ascii-char14456 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char14455))
          (fixnum1
           (call
            +
            (call - (call * 238 14) (call - 59 220))
            (call - (call + 138 8) (call * 78 39))))
          (ascii-char2 (call fun/ascii-char14456))
          (vector3 (call fun/vector14457))
          (error4 (call fun/error14458)))
      error4)))
(check-by-interp
 '(module
    (define fun/void14544 (lambda () (void)))
    (define fun/empty14543 (lambda () empty))
    (define fun/ascii-char14546 (lambda () #\c))
    (define fun/error14545 (lambda () (error 0)))
    (define fun/error14542 (lambda () (error 150)))
    (let ((error0 (call fun/error14542))
          (empty1 (call fun/empty14543))
          (fixnum2
           (call
            -
            (call * (call * 156 36) (call * 107 69))
            (call + (call * 103 132) (call + 76 215))))
          (void3 (call fun/void14544))
          (error4 (call fun/error14545)))
      (call fun/ascii-char14546))))
(check-by-interp
 '(module
    (define fun/error14839 (lambda () (error 109)))
    (define fun/empty14843 (lambda () empty))
    (define fun/void14842 (lambda () (void)))
    (define fun/ascii-char14840 (lambda () #\c))
    (define fun/vector14841 (lambda () (call make-vector 8)))
    (let ((error0 (call fun/error14839))
          (ascii-char1 (call fun/ascii-char14840))
          (vector2 (call fun/vector14841))
          (void3 (call fun/void14842))
          (empty4 (call fun/empty14843)))
      void3)))
(check-by-interp
 '(module
    (define fun/void14856 (lambda () (void)))
    (define fun/ascii-char14858 (lambda () #\c))
    (define fun/void14860 (lambda () (void)))
    (define fun/vector14857 (lambda () (call make-vector 8)))
    (define fun/void14859 (lambda () (void)))
    (let ((void0 (call fun/void14856))
          (vector1 (call fun/vector14857))
          (ascii-char2 (call fun/ascii-char14858))
          (void3 (call fun/void14859))
          (void4 (call fun/void14860)))
      ascii-char2)))
(check-by-interp
 '(module
    (define fun/vector15071 (lambda () (call make-vector 8)))
    (define fun/error15068 (lambda () (error 99)))
    (define fun/empty15070 (lambda () empty))
    (define fun/empty15069 (lambda () empty))
    (let ((error0 (call fun/error15068))
          (empty1 (call fun/empty15069))
          (empty2 (call fun/empty15070))
          (vector3 (call fun/vector15071))
          (fixnum4
           (call
            -
            (call + (call - 14 174) (call - 1 238))
            (call * (call - 185 184) (call * 19 199)))))
      vector3)))
(check-by-interp
 '(module
    (define fun/empty15112 (lambda () empty))
    (define fun/error15114 (lambda () (error 44)))
    (define fun/empty15111 (lambda () empty))
    (define fun/ascii-char15115 (lambda () #\c))
    (define fun/void15113 (lambda () (void)))
    (let ((fixnum0
           (call
            *
            (call - (call * 163 174) (call * 225 46))
            (call - (call * 209 243) (call - 148 233))))
          (empty1 (call fun/empty15111))
          (empty2 (call fun/empty15112))
          (void3 (call fun/void15113))
          (error4 (call fun/error15114)))
      (call fun/ascii-char15115))))
(check-by-interp
 '(module
    (define fun/vector15538 (lambda () (call make-vector 8)))
    (define fun/error15539 (lambda () (error 103)))
    (define fun/empty15540 (lambda () empty))
    (define fun/error15541 (lambda () (error 133)))
    (define fun/ascii-char15542 (lambda () #\c))
    (define fun/empty15537 (lambda () empty))
    (let ((empty0 (call fun/empty15537))
          (vector1 (call fun/vector15538))
          (error2 (call fun/error15539))
          (empty3 (call fun/empty15540))
          (error4 (call fun/error15541)))
      (call fun/ascii-char15542))))
(check-by-interp
 '(module
    (define fun/empty16025 (lambda () empty))
    (define fun/ascii-char16027 (lambda () #\c))
    (define fun/any16026 (lambda () (void)))
    (let ((empty0 (call fun/empty16025))
          (fixnum1
           (call
            -
            (call - (call * 7 28) (call + 42 48))
            (call * (call - 242 84) (call - 137 220))))
          (fixnum2
           (call
            *
            (call * (call * 7 176) (call * 1 66))
            (call * (call + 59 47) (call - 125 82))))
          (fixnum3
           (call
            +
            (call * (call * 133 58) (call * 136 188))
            (call * (call + 166 131) (call * 229 70))))
          (boolean4 (call fixnum? (call fun/any16026))))
      (call fun/ascii-char16027))))
(check-by-interp
 '(module
    (define fun/vector16217 (lambda () (call make-vector 8)))
    (define fun/error16218 (lambda () (error 168)))
    (define fun/empty16220 (lambda () empty))
    (define fun/ascii-char16216 (lambda () #\c))
    (define fun/empty16219 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char16216))
          (vector1 (call fun/vector16217))
          (error2 (call fun/error16218))
          (empty3 (call fun/empty16219))
          (empty4 (call fun/empty16220)))
      (call
       +
       (call * (call + 178 137) (call + 83 73))
       (call + (call * 214 174) (call + 28 196))))))
(check-by-interp
 '(module
    (define fun/error17051 (lambda () (error 145)))
    (define fun/error17048 (lambda () (error 110)))
    (define fun/void17050 (lambda () (void)))
    (define fun/vector17049 (lambda () (call make-vector 8)))
    (let ((fixnum0
           (call
            +
            (call + (call * 155 25) (call * 116 45))
            (call - (call * 231 87) (call - 62 219))))
          (error1 (call fun/error17048))
          (vector2 (call fun/vector17049))
          (void3 (call fun/void17050))
          (error4 (call fun/error17051)))
      error1)))
(check-by-interp
 '(module
    (define fun/error17146 (lambda () (error 64)))
    (define fun/void17144 (lambda () (void)))
    (define fun/ascii-char17142 (lambda () #\c))
    (define fun/any17145 (lambda () (call make-vector 8)))
    (define fun/empty17143 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char17142))
          (empty1 (call fun/empty17143))
          (void2 (call fun/void17144))
          (boolean3 (call pair? (call fun/any17145)))
          (error4 (call fun/error17146)))
      (call
       +
       (call + (call * 243 44) (call - 12 9))
       (call * (call - 143 63) (call - 63 206))))))
(check-by-interp
 '(module
    (define fun/any17224 (lambda () (error 63)))
    (define fun/ascii-char17222 (lambda () #\c))
    (define fun/error17225 (lambda () (error 105)))
    (define fun/vector17223 (lambda () (call make-vector 8)))
    (define fun/any17221 (lambda () #\c))
    (let ((boolean0 (call ascii-char? (call fun/any17221)))
          (ascii-char1 (call fun/ascii-char17222))
          (vector2 (call fun/vector17223))
          (boolean3 (call error? (call fun/any17224)))
          (error4 (call fun/error17225)))
      vector2)))
(check-by-interp
 '(module
    (define fun/any18171 (lambda () (void)))
    (define fun/vector18170 (lambda () (call make-vector 8)))
    (define fun/vector18172 (lambda () (call make-vector 8)))
    (define fun/ascii-char18169 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char18169))
          (vector1 (call fun/vector18170))
          (fixnum2
           (call
            +
            (call * (call * 79 254) (call - 42 87))
            (call * (call + 17 207) (call * 98 250))))
          (boolean3 (call vector? (call fun/any18171)))
          (vector4 (call fun/vector18172)))
      vector4)))
(check-by-interp
 '(module
    (define fun/error18672 (lambda () (error 201)))
    (define fun/vector18674 (lambda () (call make-vector 8)))
    (define fun/void18673 (lambda () (void)))
    (let ((error0 (call fun/error18672))
          (fixnum1
           (call
            +
            (call + (call + 83 253) (call - 52 64))
            (call + (call * 208 185) (call + 254 229))))
          (fixnum2
           (call
            -
            (call * (call * 142 225) (call - 102 137))
            (call - (call * 70 133) (call + 76 53))))
          (void3 (call fun/void18673))
          (vector4 (call fun/vector18674)))
      (call - fixnum1 (call + fixnum1 (call + 149 211))))))
(check-by-interp
 '(module
    (define fun/any18778 (lambda () (void)))
    (define fun/vector18775 (lambda () (call make-vector 8)))
    (define fun/vector18777 (lambda () (call make-vector 8)))
    (define fun/ascii-char18779 (lambda () #\c))
    (define fun/vector18774 (lambda () (call make-vector 8)))
    (define fun/void18776 (lambda () (void)))
    (let ((vector0 (call fun/vector18774))
          (vector1 (call fun/vector18775))
          (void2 (call fun/void18776))
          (vector3 (call fun/vector18777))
          (boolean4 (call error? (call fun/any18778))))
      (call fun/ascii-char18779))))
(check-by-interp
 '(module
    (define fun/ascii-char19237 (lambda () #\c))
    (define fun/ascii-char19236 (lambda () #\c))
    (define fun/error19239 (lambda () (error 216)))
    (define fun/void19235 (lambda () (void)))
    (define fun/error19238 (lambda () (error 84)))
    (let ((void0 (call fun/void19235))
          (ascii-char1 (call fun/ascii-char19236))
          (ascii-char2 (call fun/ascii-char19237))
          (error3 (call fun/error19238))
          (error4 (call fun/error19239)))
      (call
       -
       (call - (call - 219 20) (call + 57 154))
       (call * (call - 99 179) (call - 231 194))))))
(check-by-interp
 '(module
    (define fun/ascii-char19452 (lambda () #\c))
    (define fun/vector19455 (lambda () (call make-vector 8)))
    (define fun/empty19454 (lambda () empty))
    (define fun/empty19453 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char19452))
          (empty1 (call fun/empty19453))
          (empty2 (call fun/empty19454))
          (vector3 (call fun/vector19455))
          (fixnum4
           (call
            -
            (call - (call + 29 157) (call * 160 191))
            (call - (call * 70 178) (call + 176 131)))))
      vector3)))
(check-by-interp
 '(module
    (define fun/error19687 (lambda () (error 80)))
    (define fun/empty19688 (lambda () empty))
    (define fun/vector19689 (lambda () (call make-vector 8)))
    (define fun/ascii-char19684 (lambda () #\c))
    (define fun/ascii-char19685 (lambda () #\c))
    (define fun/ascii-char19686 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char19684))
          (ascii-char1 (call fun/ascii-char19685))
          (ascii-char2 (call fun/ascii-char19686))
          (error3 (call fun/error19687))
          (empty4 (call fun/empty19688)))
      (call fun/vector19689))))
(check-by-interp
 '(module
    (define fun/error19710 (lambda () (error 181)))
    (define fun/vector19707 (lambda () (call make-vector 8)))
    (define fun/ascii-char19709 (lambda () #\c))
    (define fun/error19711 (lambda () (error 151)))
    (define fun/error19708 (lambda () (error 188)))
    (let ((vector0 (call fun/vector19707))
          (error1 (call fun/error19708))
          (ascii-char2 (call fun/ascii-char19709))
          (error3 (call fun/error19710))
          (error4 (call fun/error19711)))
      error3)))
(check-by-interp
 '(module
    (define fun/vector20535 (lambda () (call make-vector 8)))
    (define fun/ascii-char20536 (lambda () #\c))
    (define fun/void20534 (lambda () (void)))
    (define fun/void20537 (lambda () (void)))
    (let ((void0 (call fun/void20534))
          (fixnum1
           (call
            +
            (call + (call - 56 162) (call + 237 2))
            (call - (call * 116 82) (call - 219 253))))
          (vector2 (call fun/vector20535))
          (ascii-char3 (call fun/ascii-char20536))
          (void4 (call fun/void20537)))
      (call * fixnum1 fixnum1))))
(check-by-interp
 '(module
    (define fun/empty20765 (lambda () empty))
    (define fun/ascii-char20767 (lambda () #\c))
    (define fun/ascii-char20768 (lambda () #\c))
    (define fun/empty20764 (lambda () empty))
    (define fun/error20766 (lambda () (error 252)))
    (let ((empty0 (call fun/empty20764))
          (empty1 (call fun/empty20765))
          (error2 (call fun/error20766))
          (ascii-char3 (call fun/ascii-char20767))
          (ascii-char4 (call fun/ascii-char20768)))
      (call
       *
       (call - (call - 188 148) (call + 202 162))
       (call * (call - 1 159) (call * 111 66))))))
(check-by-interp
 '(module
    (define fun/any21000 (lambda () #\c))
    (define fun/vector21002 (lambda () (call make-vector 8)))
    (define fun/vector21001 (lambda () (call make-vector 8)))
    (define fun/void21003 (lambda () (void)))
    (define fun/error21004 (lambda () (error 241)))
    (let ((boolean0 (call error? (call fun/any21000)))
          (vector1 (call fun/vector21001))
          (vector2 (call fun/vector21002))
          (fixnum3
           (call
            +
            (call + (call + 90 120) (call - 205 70))
            (call * (call - 249 161) (call + 81 202))))
          (void4 (call fun/void21003)))
      (call fun/error21004))))
(check-by-interp
 '(module
    (define fun/ascii-char21096 (lambda () #\c))
    (define fun/ascii-char21098 (lambda () #\c))
    (define fun/error21099 (lambda () (error 129)))
    (define fun/ascii-char21097 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char21096))
          (fixnum1
           (call
            +
            (call + (call + 151 247) (call * 179 4))
            (call + (call * 175 57) (call - 111 209))))
          (ascii-char2 (call fun/ascii-char21097))
          (ascii-char3 (call fun/ascii-char21098))
          (fixnum4
           (call
            -
            (call - (call * 129 225) (call + 69 70))
            (call - (call - 178 46) (call - 108 37)))))
      (call fun/error21099))))
(check-by-interp
 '(module
    (define fun/void21257 (lambda () (void)))
    (define fun/void21255 (lambda () (void)))
    (define fun/void21256 (lambda () (void)))
    (define fun/ascii-char21254 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char21254))
          (void1 (call fun/void21255))
          (fixnum2
           (call
            -
            (call - (call + 216 92) (call - 203 24))
            (call + (call - 20 111) (call - 246 240))))
          (void3 (call fun/void21256))
          (void4 (call fun/void21257)))
      void1)))
(check-by-interp
 '(module
    (define fun/ascii-char21338 (lambda () #\c))
    (define fun/error21339 (lambda () (error 149)))
    (define fun/any21340 (lambda () (void)))
    (define fun/vector21341 (lambda () (call make-vector 8)))
    (define fun/ascii-char21337 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char21337))
          (ascii-char1 (call fun/ascii-char21338))
          (error2 (call fun/error21339))
          (fixnum3
           (call
            -
            (call + (call + 123 146) (call + 239 49))
            (call + (call + 235 58) (call + 105 238))))
          (boolean4 (call boolean? (call fun/any21340))))
      (call fun/vector21341))))
(check-by-interp
 '(module
    (define fun/ascii-char21457 (lambda () #\c))
    (define fun/any21458 (lambda () #f))
    (define fun/ascii-char21459 (lambda () #\c))
    (define fun/vector21460 (lambda () (call make-vector 8)))
    (let ((ascii-char0 (call fun/ascii-char21457))
          (boolean1 (call ascii-char? (call fun/any21458)))
          (ascii-char2 (call fun/ascii-char21459))
          (vector3 (call fun/vector21460))
          (fixnum4
           (call
            -
            (call - (call + 29 75) (call + 131 225))
            (call - (call - 49 113) (call + 238 111)))))
      ascii-char0)))
(check-by-interp
 '(module
    (define fun/error21502 (lambda () (error 49)))
    (define fun/empty21506 (lambda () empty))
    (define fun/empty21503 (lambda () empty))
    (define fun/error21505 (lambda () (error 178)))
    (define fun/empty21504 (lambda () empty))
    (let ((error0 (call fun/error21502))
          (empty1 (call fun/empty21503))
          (empty2 (call fun/empty21504))
          (error3 (call fun/error21505))
          (empty4 (call fun/empty21506)))
      error0)))
(check-by-interp
 '(module
    (define fun/empty21523 (lambda () empty))
    (define fun/void21525 (lambda () (void)))
    (define fun/void21524 (lambda () (void)))
    (define fun/void21527 (lambda () (void)))
    (define fun/ascii-char21526 (lambda () #\c))
    (let ((empty0 (call fun/empty21523))
          (void1 (call fun/void21524))
          (void2 (call fun/void21525))
          (ascii-char3 (call fun/ascii-char21526))
          (void4 (call fun/void21527)))
      (call
       +
       (call - (call * 134 181) (call - 62 177))
       (call + (call - 10 151) (call - 111 129))))))
(check-by-interp
 '(module
    (define fun/vector21647 (lambda () (call make-vector 8)))
    (define fun/ascii-char21651 (lambda () #\c))
    (define fun/empty21650 (lambda () empty))
    (define fun/any21649 (lambda () (error 62)))
    (define fun/empty21648 (lambda () empty))
    (let ((vector0 (call fun/vector21647))
          (empty1 (call fun/empty21648))
          (boolean2 (call pair? (call fun/any21649)))
          (empty3 (call fun/empty21650))
          (fixnum4
           (call
            *
            (call * (call * 46 57) (call - 44 102))
            (call - (call - 230 56) (call * 38 159)))))
      (call fun/ascii-char21651))))
(check-by-interp
 '(module
    (define fun/void21925 (lambda () (void)))
    (define fun/error21927 (lambda () (error 161)))
    (define fun/vector21928 (lambda () (call make-vector 8)))
    (define fun/ascii-char21924 (lambda () #\c))
    (define fun/void21926 (lambda () (void)))
    (let ((ascii-char0 (call fun/ascii-char21924))
          (fixnum1
           (call
            +
            (call - (call + 33 207) (call * 159 69))
            (call - (call * 40 161) (call + 188 232))))
          (void2 (call fun/void21925))
          (void3 (call fun/void21926))
          (error4 (call fun/error21927)))
      (call fun/vector21928))))
(check-by-interp
 '(module
    (define fun/void22132 (lambda () (void)))
    (define fun/void22129 (lambda () (void)))
    (define fun/void22131 (lambda () (void)))
    (define fun/empty22130 (lambda () empty))
    (define fun/ascii-char22133 (lambda () #\c))
    (let ((void0 (call fun/void22129))
          (empty1 (call fun/empty22130))
          (void2 (call fun/void22131))
          (void3 (call fun/void22132))
          (ascii-char4 (call fun/ascii-char22133)))
      ascii-char4)))
(check-by-interp
 '(module
    (define fun/vector22195 (lambda () (call make-vector 8)))
    (define fun/void22199 (lambda () (void)))
    (define fun/empty22200 (lambda () empty))
    (define fun/error22196 (lambda () (error 86)))
    (define fun/ascii-char22198 (lambda () #\c))
    (define fun/ascii-char22197 (lambda () #\c))
    (let ((vector0 (call fun/vector22195))
          (error1 (call fun/error22196))
          (ascii-char2 (call fun/ascii-char22197))
          (ascii-char3 (call fun/ascii-char22198))
          (void4 (call fun/void22199)))
      (call fun/empty22200))))
(check-by-interp
 '(module
    (define fun/empty22498 (lambda () empty))
    (define fun/void22500 (lambda () (void)))
    (define fun/vector22501 (lambda () (call make-vector 8)))
    (define fun/error22499 (lambda () (error 208)))
    (let ((fixnum0
           (call
            -
            (call + (call - 125 166) (call + 27 37))
            (call * (call * 37 39) (call - 253 23))))
          (empty1 (call fun/empty22498))
          (error2 (call fun/error22499))
          (void3 (call fun/void22500))
          (vector4 (call fun/vector22501)))
      void3)))
(check-by-interp
 '(module
    (define fun/vector22639 (lambda () (call make-vector 8)))
    (define fun/boolean22642 (lambda (oprand0 oprand1 oprand2 oprand3) #t))
    (define fun/vector22640 (lambda () (call make-vector 8)))
    (define fun/empty22641 (lambda () empty))
    (if (call
         error?
         (let ((error0 (error 146))
               (ascii-char1 #\c)
               (ascii-char2 #\c)
               (boolean3 #t)
               (empty4 empty))
           #t))
      (let ((boolean0 (call vector? (call make-vector 8)))
            (fixnum1 (call + 223 230))
            (vector2 (call fun/vector22639))
            (fixnum3 (call + 50 33))
            (vector4 (call fun/vector22640)))
        (call fun/empty22641))
      (if (call fun/boolean22642 #f (error 63) (void) (error 117))
        (if #t empty empty)
        (if #f empty empty)))))
(check-by-interp
 '(module
    (define fun/void22688 (lambda () (call fun/void22689)))
    (define fun/empty22681 (lambda () empty))
    (define fun/ascii-char22683 (lambda () #\c))
    (define fun/ascii-char22682 (lambda () (call fun/ascii-char22683)))
    (define fun/empty22687 (lambda () empty))
    (define fun/vector22685 (lambda () (call make-vector 8)))
    (define fun/vector22678 (lambda () (call fun/vector22679)))
    (define fun/empty22680 (lambda () (call fun/empty22681)))
    (define fun/void22689 (lambda () (void)))
    (define fun/vector22679 (lambda () (call make-vector 8)))
    (define fun/empty22686 (lambda () (call fun/empty22687)))
    (define fun/vector22684 (lambda () (call fun/vector22685)))
    (let ((vector0 (call fun/vector22678))
          (empty1 (call fun/empty22680))
          (ascii-char2 (call fun/ascii-char22682))
          (vector3 (call fun/vector22684))
          (empty4 (call fun/empty22686))
          (void5 (call fun/void22688)))
      void5)))
(check-by-interp
 '(module
    (define fun/vector23398 (lambda () (call fun/vector23399)))
    (define fun/error23400 (lambda () (call fun/error23401)))
    (define fun/error23396 (lambda () (call fun/error23397)))
    (define fun/ascii-char23402 (lambda () (call fun/ascii-char23403)))
    (define fun/error23397 (lambda () (error 29)))
    (define fun/ascii-char23403 (lambda () #\c))
    (define fun/vector23399 (lambda () (call make-vector 8)))
    (define fun/error23401 (lambda () (error 159)))
    (let ((error0 (call fun/error23396))
          (fixnum1
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
          (vector2 (call fun/vector23398))
          (error3 (call fun/error23400))
          (fixnum4
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
          (ascii-char5 (call fun/ascii-char23402)))
      vector2)))
(check-by-interp
 '(module
    (define fun/empty23859 (lambda () (call fun/empty23860)))
    (define fun/empty23858 (lambda () empty))
    (define fun/void23863 (lambda () (void)))
    (define fun/void23862 (lambda () (call fun/void23863)))
    (define fun/empty23860 (lambda () empty))
    (define fun/empty23857 (lambda () (call fun/empty23858)))
    (define fun/any23861 (lambda () (call make-vector 8)))
    (let ((empty0 (call fun/empty23857))
          (fixnum1
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
          (fixnum2
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
          (empty3 (call fun/empty23859))
          (boolean4 (call vector? (call fun/any23861)))
          (void5 (call fun/void23862)))
      (call + fixnum2 fixnum2))))
(check-by-interp
 '(module
    (define fun/void30044 (lambda () (void)))
    (define fun/empty30040 (lambda () (call fun/empty30041)))
    (define fun/void30049 (lambda () (call fun/void30050)))
    (define fun/empty30047 (lambda () (call fun/empty30048)))
    (define fun/error30045 (lambda () (call fun/error30046)))
    (define fun/vector30052 (lambda () (call make-vector 8)))
    (define fun/empty30041 (lambda () empty))
    (define fun/void30043 (lambda () (call fun/void30044)))
    (define fun/void30050 (lambda () (void)))
    (define fun/vector30051 (lambda () (call fun/vector30052)))
    (define fun/any30042 (lambda () (call make-vector 8)))
    (define fun/error30046 (lambda () (error 214)))
    (define fun/empty30048 (lambda () empty))
    (let ((empty0 (call fun/empty30040))
          (boolean1 (call empty? (call fun/any30042)))
          (void2 (call fun/void30043))
          (error3 (call fun/error30045))
          (empty4 (call fun/empty30047))
          (void5 (call fun/void30049)))
      (call fun/vector30051))))
(check-by-interp
 '(module
    (define fun/vector31209 (lambda () (call make-vector 8)))
    (define fun/void31211 (lambda () (void)))
    (define fun/vector31202 (lambda () (call fun/vector31203)))
    (define fun/error31206 (lambda () (call fun/error31207)))
    (define fun/error31205 (lambda () (error 219)))
    (define fun/error31207 (lambda () (error 229)))
    (define fun/vector31203 (lambda () (call make-vector 8)))
    (define fun/void31210 (lambda () (call fun/void31211)))
    (define fun/error31204 (lambda () (call fun/error31205)))
    (define fun/vector31208 (lambda () (call fun/vector31209)))
    (let ((vector0 (call fun/vector31202))
          (error1 (call fun/error31204))
          (error2 (call fun/error31206))
          (vector3 (call fun/vector31208))
          (fixnum4
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
          (void5 (call fun/void31210)))
      void5)))
(check-by-interp
 '(module
    (define fun/ascii-char33057 (lambda () (call fun/ascii-char33058)))
    (define fun/error33066 (lambda () (error 235)))
    (define fun/empty33064 (lambda () empty))
    (define fun/ascii-char33058 (lambda () #\c))
    (define fun/empty33063 (lambda () (call fun/empty33064)))
    (define fun/vector33062 (lambda () (call make-vector 8)))
    (define fun/vector33059 (lambda () (call fun/vector33060)))
    (define fun/vector33061 (lambda () (call fun/vector33062)))
    (define fun/vector33060 (lambda () (call make-vector 8)))
    (define fun/error33065 (lambda () (call fun/error33066)))
    (let ((ascii-char0 (call fun/ascii-char33057))
          (vector1 (call fun/vector33059))
          (vector2 (call fun/vector33061))
          (empty3 (call fun/empty33063))
          (error4 (call fun/error33065))
          (fixnum5
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
      empty3)))
(check-by-interp
 '(module
    (define fun/empty35185 (lambda () empty))
    (define fun/empty35187 (lambda () empty))
    (define fun/ascii-char35182 (lambda () (call fun/ascii-char35183)))
    (define fun/empty35184 (lambda () (call fun/empty35185)))
    (define fun/vector35189 (lambda () (call make-vector 8)))
    (define fun/vector35188 (lambda () (call fun/vector35189)))
    (define fun/empty35186 (lambda () (call fun/empty35187)))
    (define fun/ascii-char35183 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char35182))
          (empty1 (call fun/empty35184))
          (empty2 (call fun/empty35186))
          (vector3 (call fun/vector35188))
          (fixnum4
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
          (fixnum5
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
      fixnum5)))
(check-by-interp
 '(module
    (define fun/ascii-char35206 (lambda () (call fun/ascii-char35207)))
    (define fun/ascii-char35208 (lambda () (call fun/ascii-char35209)))
    (define fun/empty35210 (lambda () (call fun/empty35211)))
    (define fun/error35213 (lambda () (error 142)))
    (define fun/void35214 (lambda () (call fun/void35215)))
    (define fun/ascii-char35207 (lambda () #\c))
    (define fun/ascii-char35209 (lambda () #\c))
    (define fun/void35215 (lambda () (void)))
    (define fun/error35212 (lambda () (call fun/error35213)))
    (define fun/empty35211 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char35206))
          (ascii-char1 (call fun/ascii-char35208))
          (empty2 (call fun/empty35210))
          (error3 (call fun/error35212))
          (fixnum4
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
          (void5 (call fun/void35214)))
      ascii-char1)))
(check-by-interp
 '(module
    (define fun/vector35811 (lambda () (call make-vector 8)))
    (define fun/void35805 (lambda () (void)))
    (define fun/vector35806 (lambda () (call fun/vector35807)))
    (define fun/error35808 (lambda () (call fun/error35809)))
    (define fun/vector35810 (lambda () (call fun/vector35811)))
    (define fun/void35804 (lambda () (call fun/void35805)))
    (define fun/vector35807 (lambda () (call make-vector 8)))
    (define fun/error35809 (lambda () (error 108)))
    (let ((void0 (call fun/void35804))
          (vector1 (call fun/vector35806))
          (error2 (call fun/error35808))
          (fixnum3
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
          (vector4 (call fun/vector35810))
          (fixnum5
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
      vector1)))
(check-by-interp
 '(module
    (define fun/ascii-char38887 (lambda () (call fun/ascii-char38888)))
    (define fun/error38886 (lambda () (error 110)))
    (define fun/error38884 (lambda () (error 228)))
    (define fun/empty38889 (lambda () (call fun/empty38890)))
    (define fun/empty38882 (lambda () empty))
    (define fun/empty38881 (lambda () (call fun/empty38882)))
    (define fun/error38883 (lambda () (call fun/error38884)))
    (define fun/error38885 (lambda () (call fun/error38886)))
    (define fun/empty38890 (lambda () empty))
    (define fun/vector38892 (lambda () (call make-vector 8)))
    (define fun/ascii-char38888 (lambda () #\c))
    (define fun/vector38891 (lambda () (call fun/vector38892)))
    (let ((empty0 (call fun/empty38881))
          (error1 (call fun/error38883))
          (error2 (call fun/error38885))
          (ascii-char3 (call fun/ascii-char38887))
          (empty4 (call fun/empty38889))
          (vector5 (call fun/vector38891)))
      ascii-char3)))
(check-by-interp
 '(module
    (define fun/empty42202 (lambda () (call fun/empty42203)))
    (define fun/ascii-char42195 (lambda () #\c))
    (define fun/ascii-char42193 (lambda () #\c))
    (define fun/ascii-char42200 (lambda () (call fun/ascii-char42201)))
    (define fun/vector42197 (lambda () (call make-vector 8)))
    (define fun/error42199 (lambda () (error 121)))
    (define fun/ascii-char42194 (lambda () (call fun/ascii-char42195)))
    (define fun/ascii-char42192 (lambda () (call fun/ascii-char42193)))
    (define fun/vector42196 (lambda () (call fun/vector42197)))
    (define fun/empty42203 (lambda () empty))
    (define fun/ascii-char42201 (lambda () #\c))
    (define fun/error42198 (lambda () (call fun/error42199)))
    (let ((ascii-char0 (call fun/ascii-char42192))
          (ascii-char1 (call fun/ascii-char42194))
          (vector2 (call fun/vector42196))
          (error3 (call fun/error42198))
          (ascii-char4 (call fun/ascii-char42200))
          (fixnum5
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
      (call fun/empty42202))))
(check-by-interp
 '(module
    (define fun/void43341 (lambda () (call fun/void43342)))
    (define fun/empty43339 (lambda () empty))
    (define fun/any43337 (lambda () (error 53)))
    (define fun/any43340 (lambda () 60))
    (define fun/empty43335 (lambda () (call fun/empty43336)))
    (define fun/empty43333 (lambda () (call fun/empty43334)))
    (define fun/empty43338 (lambda () (call fun/empty43339)))
    (define fun/void43342 (lambda () (void)))
    (define fun/empty43334 (lambda () empty))
    (define fun/empty43336 (lambda () empty))
    (let ((empty0 (call fun/empty43333))
          (empty1 (call fun/empty43335))
          (boolean2 (call void? (call fun/any43337)))
          (fixnum3
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
          (empty4 (call fun/empty43338))
          (boolean5 (call error? (call fun/any43340))))
      (call fun/void43341))))
(check-by-interp
 '(module
    (define fun/ascii-char44115 (lambda () (call fun/ascii-char44116)))
    (define fun/ascii-char44119 (lambda () (call fun/ascii-char44120)))
    (define fun/empty44111 (lambda () (call fun/empty44112)))
    (define fun/void44117 (lambda () (call fun/void44118)))
    (define fun/ascii-char44114 (lambda () #\c))
    (define fun/void44118 (lambda () (void)))
    (define fun/ascii-char44120 (lambda () #\c))
    (define fun/ascii-char44116 (lambda () #\c))
    (define fun/ascii-char44113 (lambda () (call fun/ascii-char44114)))
    (define fun/empty44112 (lambda () empty))
    (let ((empty0 (call fun/empty44111))
          (ascii-char1 (call fun/ascii-char44113))
          (ascii-char2 (call fun/ascii-char44115))
          (void3 (call fun/void44117))
          (fixnum4
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
          (ascii-char5 (call fun/ascii-char44119)))
      (call
       -
       (call
        +
        (call - (call + 52 92) (call - fixnum4 17))
        (call - (call + 65 24) (call * fixnum4 fixnum4)))
       (call * fixnum4 (call * fixnum4 (call * 55 fixnum4)))))))
(check-by-interp
 '(module
    (define fun/vector45779 (lambda () (call make-vector 8)))
    (define fun/any45780 (lambda () (call make-vector 8)))
    (define fun/ascii-char45783 (lambda () (call fun/ascii-char45784)))
    (define fun/error45781 (lambda () (call fun/error45782)))
    (define fun/vector45778 (lambda () (call fun/vector45779)))
    (define fun/error45782 (lambda () (error 58)))
    (define fun/ascii-char45784 (lambda () #\c))
    (let ((vector0 (call fun/vector45778))
          (fixnum1
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
          (boolean2 (call boolean? (call fun/any45780)))
          (error3 (call fun/error45781))
          (fixnum4
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
          (ascii-char5 (call fun/ascii-char45783)))
      error3)))
(check-by-interp
 '(module
    (define fun/ascii-char47094 (lambda () #\c))
    (define fun/empty47092 (lambda () empty))
    (define fun/empty47086 (lambda () empty))
    (define fun/void47084 (lambda () (void)))
    (define fun/empty47090 (lambda () empty))
    (define fun/vector47088 (lambda () (call make-vector 8)))
    (define fun/empty47089 (lambda () (call fun/empty47090)))
    (define fun/empty47091 (lambda () (call fun/empty47092)))
    (define fun/empty47085 (lambda () (call fun/empty47086)))
    (define fun/void47083 (lambda () (call fun/void47084)))
    (define fun/ascii-char47093 (lambda () (call fun/ascii-char47094)))
    (define fun/vector47087 (lambda () (call fun/vector47088)))
    (let ((void0 (call fun/void47083))
          (empty1 (call fun/empty47085))
          (vector2 (call fun/vector47087))
          (empty3 (call fun/empty47089))
          (empty4 (call fun/empty47091))
          (ascii-char5 (call fun/ascii-char47093)))
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
    (define fun/any47118 (lambda () (error 88)))
    (define fun/error47111 (lambda () (call fun/error47112)))
    (define fun/error47113 (lambda () (call fun/error47114)))
    (define fun/any47115 (lambda () empty))
    (define fun/vector47116 (lambda () (call fun/vector47117)))
    (define fun/error47112 (lambda () (error 228)))
    (define fun/error47114 (lambda () (error 240)))
    (define fun/vector47117 (lambda () (call make-vector 8)))
    (let ((error0 (call fun/error47111))
          (error1 (call fun/error47113))
          (boolean2 (call void? (call fun/any47115)))
          (vector3 (call fun/vector47116))
          (fixnum4
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
          (boolean5 (call ascii-char? (call fun/any47118))))
      vector3)))
(check-by-interp
 '(module
    (define fun/ascii-char48099 (lambda () (call fun/ascii-char48100)))
    (define fun/void48092 (lambda () (void)))
    (define fun/void48098 (lambda () (void)))
    (define fun/void48093 (lambda () (call fun/void48094)))
    (define fun/void48097 (lambda () (call fun/void48098)))
    (define fun/void48094 (lambda () (void)))
    (define fun/empty48096 (lambda () empty))
    (define fun/ascii-char48100 (lambda () #\c))
    (define fun/vector48102 (lambda () (call make-vector 8)))
    (define fun/empty48095 (lambda () (call fun/empty48096)))
    (define fun/vector48101 (lambda () (call fun/vector48102)))
    (define fun/any48103 (lambda () #\c))
    (define fun/void48091 (lambda () (call fun/void48092)))
    (let ((void0 (call fun/void48091))
          (void1 (call fun/void48093))
          (empty2 (call fun/empty48095))
          (void3 (call fun/void48097))
          (ascii-char4 (call fun/ascii-char48099))
          (vector5 (call fun/vector48101)))
      (call ascii-char? (call fun/any48103)))))
(check-by-interp
 '(module
    (define fun/vector52040 (lambda () (call fun/vector52041)))
    (define fun/error52042 (lambda () (call fun/error52043)))
    (define fun/empty52039 (lambda () empty))
    (define fun/void52044 (lambda () (call fun/void52045)))
    (define fun/void52045 (lambda () (void)))
    (define fun/empty52038 (lambda () (call fun/empty52039)))
    (define fun/empty52036 (lambda () (call fun/empty52037)))
    (define fun/empty52037 (lambda () empty))
    (define fun/error52043 (lambda () (error 159)))
    (define fun/vector52041 (lambda () (call make-vector 8)))
    (let ((fixnum0
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
          (empty1 (call fun/empty52036))
          (empty2 (call fun/empty52038))
          (vector3 (call fun/vector52040))
          (error4 (call fun/error52042))
          (void5 (call fun/void52044)))
      vector3)))
(check-by-interp
 '(module
    (define fun/error52272 (lambda () (call fun/error52273)))
    (define fun/ascii-char52269 (lambda () (call fun/ascii-char52270)))
    (define fun/vector52264 (lambda () (call make-vector 8)))
    (define fun/any52271 (lambda () (void)))
    (define fun/void52268 (lambda () (void)))
    (define fun/ascii-char52270 (lambda () #\c))
    (define fun/void52267 (lambda () (call fun/void52268)))
    (define fun/error52273 (lambda () (error 58)))
    (define fun/ascii-char52266 (lambda () #\c))
    (define fun/vector52263 (lambda () (call fun/vector52264)))
    (define fun/ascii-char52265 (lambda () (call fun/ascii-char52266)))
    (let ((vector0 (call fun/vector52263))
          (ascii-char1 (call fun/ascii-char52265))
          (void2 (call fun/void52267))
          (ascii-char3 (call fun/ascii-char52269))
          (boolean4 (call vector? (call fun/any52271)))
          (error5 (call fun/error52272)))
      void2)))
(check-by-interp
 '(module
    (define fun/vector52861 (lambda () (call make-vector 8)))
    (define fun/empty52857 (lambda () empty))
    (define fun/ascii-char52854 (lambda () (call fun/ascii-char52855)))
    (define fun/error52853 (lambda () (error 46)))
    (define fun/empty52863 (lambda () empty))
    (define fun/empty52856 (lambda () (call fun/empty52857)))
    (define fun/ascii-char52855 (lambda () #\c))
    (define fun/empty52859 (lambda () empty))
    (define fun/vector52860 (lambda () (call fun/vector52861)))
    (define fun/error52852 (lambda () (call fun/error52853)))
    (define fun/empty52862 (lambda () (call fun/empty52863)))
    (define fun/empty52858 (lambda () (call fun/empty52859)))
    (let ((error0 (call fun/error52852))
          (ascii-char1 (call fun/ascii-char52854))
          (empty2 (call fun/empty52856))
          (empty3 (call fun/empty52858))
          (vector4 (call fun/vector52860))
          (empty5 (call fun/empty52862)))
      vector4)))
(check-by-interp
 '(module
    (define fun/vector55180 (lambda () (call fun/vector55181)))
    (define fun/empty55178 (lambda () (call fun/empty55179)))
    (define fun/empty55177 (lambda () empty))
    (define fun/vector55175 (lambda () (call make-vector 8)))
    (define fun/empty55179 (lambda () empty))
    (define fun/empty55176 (lambda () (call fun/empty55177)))
    (define fun/empty55173 (lambda () empty))
    (define fun/error55182 (lambda () (call fun/error55183)))
    (define fun/error55183 (lambda () (error 81)))
    (define fun/vector55181 (lambda () (call make-vector 8)))
    (define fun/empty55172 (lambda () (call fun/empty55173)))
    (define fun/vector55174 (lambda () (call fun/vector55175)))
    (let ((empty0 (call fun/empty55172))
          (vector1 (call fun/vector55174))
          (empty2 (call fun/empty55176))
          (fixnum3
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
          (empty4 (call fun/empty55178))
          (vector5 (call fun/vector55180)))
      (call fun/error55182))))
(check-by-interp
 '(module
    (define fun/ascii-char57873 (lambda () (call fun/ascii-char57874)))
    (define fun/vector57872 (lambda () (call make-vector 8)))
    (define fun/error57869 (lambda () (call fun/error57870)))
    (define fun/empty57877 (lambda () (call fun/empty57878)))
    (define fun/error57876 (lambda () (error 173)))
    (define fun/vector57871 (lambda () (call fun/vector57872)))
    (define fun/vector57868 (lambda () (call make-vector 8)))
    (define fun/empty57878 (lambda () empty))
    (define fun/ascii-char57874 (lambda () #\c))
    (define fun/error57870 (lambda () (error 150)))
    (define fun/vector57867 (lambda () (call fun/vector57868)))
    (define fun/error57875 (lambda () (call fun/error57876)))
    (let ((vector0 (call fun/vector57867))
          (error1 (call fun/error57869))
          (vector2 (call fun/vector57871))
          (ascii-char3 (call fun/ascii-char57873))
          (fixnum4
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
          (error5 (call fun/error57875)))
      (call fun/empty57877))))
(check-by-interp
 '(module
    (define fun/empty58877 (lambda () empty))
    (define fun/error58875 (lambda () (error 150)))
    (define fun/ascii-char58879 (lambda () #\c))
    (define fun/any58880 (lambda () #f))
    (define fun/empty58876 (lambda () (call fun/empty58877)))
    (define fun/ascii-char58878 (lambda () (call fun/ascii-char58879)))
    (define fun/error58874 (lambda () (call fun/error58875)))
    (let ((fixnum0
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
          (fixnum1
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
          (error2 (call fun/error58874))
          (empty3 (call fun/empty58876))
          (ascii-char4 (call fun/ascii-char58878))
          (boolean5 (call fixnum? (call fun/any58880))))
      ascii-char4)))
(check-by-interp
 '(module
    (define fun/vector63530 (lambda () (call fun/vector63531)))
    (define fun/vector63531 (lambda () (call make-vector 8)))
    (define fun/empty63532 (lambda () (call fun/empty63533)))
    (define fun/empty63536 (lambda () (call fun/empty63537)))
    (define fun/void63534 (lambda () (call fun/void63535)))
    (define fun/void63535 (lambda () (void)))
    (define fun/empty63533 (lambda () empty))
    (define fun/empty63537 (lambda () empty))
    (let ((vector0 (call fun/vector63530))
          (fixnum1
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
          (empty2 (call fun/empty63532))
          (void3 (call fun/void63534))
          (fixnum4
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
          (empty5 (call fun/empty63536)))
      void3)))
(check-by-interp
 '(module
    (define fun/ascii-char63953 (lambda () #\c))
    (define fun/error63956 (lambda () (error 78)))
    (define fun/ascii-char63952 (lambda () (call fun/ascii-char63953)))
    (define fun/error63955 (lambda () (call fun/error63956)))
    (define fun/any63954 (lambda () 223))
    (let ((fixnum0
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
          (ascii-char1 (call fun/ascii-char63952))
          (fixnum2
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
          (fixnum3
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
          (boolean4 (call void? (call fun/any63954)))
          (error5 (call fun/error63955)))
      ascii-char1)))
(check-by-interp
 '(module
    (define fun/vector69403 (lambda () (call make-vector 8)))
    (define fun/empty69407 (lambda () empty))
    (define fun/ascii-char69397 (lambda () #\c))
    (define fun/empty69406 (lambda () (call fun/empty69407)))
    (define fun/empty69404 (lambda () (call fun/empty69405)))
    (define fun/vector69401 (lambda () (call make-vector 8)))
    (define fun/ascii-char69398 (lambda () (call fun/ascii-char69399)))
    (define fun/vector69402 (lambda () (call fun/vector69403)))
    (define fun/vector69400 (lambda () (call fun/vector69401)))
    (define fun/ascii-char69399 (lambda () #\c))
    (define fun/ascii-char69396 (lambda () (call fun/ascii-char69397)))
    (define fun/empty69405 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char69396))
          (ascii-char1 (call fun/ascii-char69398))
          (vector2 (call fun/vector69400))
          (vector3 (call fun/vector69402))
          (empty4 (call fun/empty69404))
          (empty5 (call fun/empty69406)))
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
    (define fun/ascii-char71274 (lambda () #\c))
    (define fun/void71278 (lambda () (void)))
    (define fun/ascii-char71271 (lambda () (call fun/ascii-char71272)))
    (define fun/ascii-char71273 (lambda () (call fun/ascii-char71274)))
    (define fun/empty71270 (lambda () empty))
    (define fun/ascii-char71272 (lambda () #\c))
    (define fun/ascii-char71275 (lambda () (call fun/ascii-char71276)))
    (define fun/void71277 (lambda () (call fun/void71278)))
    (define fun/empty71269 (lambda () (call fun/empty71270)))
    (define fun/ascii-char71276 (lambda () #\c))
    (let ((fixnum0
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
          (empty1 (call fun/empty71269))
          (ascii-char2 (call fun/ascii-char71271))
          (ascii-char3 (call fun/ascii-char71273))
          (ascii-char4 (call fun/ascii-char71275))
          (void5 (call fun/void71277)))
      empty1)))
(check-by-interp
 '(module
    (define fun/void72540 (lambda () (void)))
    (define fun/ascii-char72544 (lambda () #\c))
    (define fun/vector72535 (lambda () (call fun/vector72536)))
    (define fun/ascii-char72543 (lambda () (call fun/ascii-char72544)))
    (define fun/vector72541 (lambda () (call fun/vector72542)))
    (define fun/vector72533 (lambda () (call fun/vector72534)))
    (define fun/vector72538 (lambda () (call make-vector 8)))
    (define fun/void72539 (lambda () (call fun/void72540)))
    (define fun/vector72536 (lambda () (call make-vector 8)))
    (define fun/vector72537 (lambda () (call fun/vector72538)))
    (define fun/vector72534 (lambda () (call make-vector 8)))
    (define fun/vector72542 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector72533))
          (fixnum1
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
          (vector2 (call fun/vector72535))
          (vector3 (call fun/vector72537))
          (void4 (call fun/void72539))
          (vector5 (call fun/vector72541)))
      (call fun/ascii-char72543))))
(check-by-interp
 '(module
    (define fun/vector72932 (lambda () (call fun/vector72933)))
    (define fun/ascii-char72931 (lambda () #\c))
    (define fun/any72925 (lambda () 152))
    (define fun/empty72928 (lambda () (call fun/empty72929)))
    (define fun/ascii-char72930 (lambda () (call fun/ascii-char72931)))
    (define fun/error72927 (lambda () (error 138)))
    (define fun/vector72933 (lambda () (call make-vector 8)))
    (define fun/error72926 (lambda () (call fun/error72927)))
    (define fun/empty72929 (lambda () empty))
    (let ((boolean0 (call pair? (call fun/any72925)))
          (error1 (call fun/error72926))
          (empty2 (call fun/empty72928))
          (ascii-char3 (call fun/ascii-char72930))
          (fixnum4
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
          (vector5 (call fun/vector72932)))
      vector5)))
(check-by-interp
 '(module
    (define fun/empty73456 (lambda () (call fun/empty73457)))
    (define fun/ascii-char73458 (lambda () (call fun/ascii-char73459)))
    (define fun/empty73463 (lambda () empty))
    (define fun/error73460 (lambda () (call fun/error73461)))
    (define fun/empty73457 (lambda () empty))
    (define fun/error73461 (lambda () (error 80)))
    (define fun/ascii-char73459 (lambda () #\c))
    (define fun/empty73462 (lambda () (call fun/empty73463)))
    (let ((fixnum0
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
          (empty1 (call fun/empty73456))
          (ascii-char2 (call fun/ascii-char73458))
          (error3 (call fun/error73460))
          (fixnum4
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
          (empty5 (call fun/empty73462)))
      error3)))
(check-by-interp
 '(module
    (define fun/vector75268 (lambda () (call make-vector 8)))
    (define fun/error75260 (lambda () (error 129)))
    (define fun/error75264 (lambda () (error 144)))
    (define fun/ascii-char75266 (lambda () #\c))
    (define fun/vector75267 (lambda () (call fun/vector75268)))
    (define fun/error75263 (lambda () (call fun/error75264)))
    (define fun/error75259 (lambda () (call fun/error75260)))
    (define fun/any75262 (lambda () empty))
    (define fun/any75261 (lambda () 14))
    (define fun/ascii-char75265 (lambda () (call fun/ascii-char75266)))
    (let ((error0 (call fun/error75259))
          (boolean1 (call vector? (call fun/any75261)))
          (boolean2 (call vector? (call fun/any75262)))
          (error3 (call fun/error75263))
          (ascii-char4 (call fun/ascii-char75265))
          (fixnum5
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
      (call fun/vector75267))))
(check-by-interp
 '(module
    (define fun/error75926 (lambda () (call fun/error75927)))
    (define fun/vector75921 (lambda () (call make-vector 8)))
    (define fun/ascii-char75925 (lambda () #\c))
    (define fun/error75928 (lambda () (call fun/error75929)))
    (define fun/ascii-char75918 (lambda () (call fun/ascii-char75919)))
    (define fun/error75929 (lambda () (error 68)))
    (define fun/empty75923 (lambda () empty))
    (define fun/vector75920 (lambda () (call fun/vector75921)))
    (define fun/error75927 (lambda () (error 149)))
    (define fun/empty75922 (lambda () (call fun/empty75923)))
    (define fun/ascii-char75919 (lambda () #\c))
    (define fun/ascii-char75924 (lambda () (call fun/ascii-char75925)))
    (let ((ascii-char0 (call fun/ascii-char75918))
          (vector1 (call fun/vector75920))
          (empty2 (call fun/empty75922))
          (ascii-char3 (call fun/ascii-char75924))
          (error4 (call fun/error75926))
          (error5 (call fun/error75928)))
      vector1)))
(check-by-interp
 '(module
    (define fun/void77842 (lambda () (call fun/void77843)))
    (define fun/void77838 (lambda () (call fun/void77839)))
    (define fun/error77846 (lambda () (call fun/error77847)))
    (define fun/error77845 (lambda () (error 242)))
    (define fun/empty77840 (lambda () (call fun/empty77841)))
    (define fun/void77843 (lambda () (void)))
    (define fun/void77839 (lambda () (void)))
    (define fun/empty77841 (lambda () empty))
    (define fun/error77844 (lambda () (call fun/error77845)))
    (define fun/error77847 (lambda () (error 190)))
    (let ((void0 (call fun/void77838))
          (fixnum1
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
          (empty2 (call fun/empty77840))
          (void3 (call fun/void77842))
          (error4 (call fun/error77844))
          (error5 (call fun/error77846)))
      empty2)))
(check-by-interp
 '(module
    (define fun/any78095 (lambda () #f))
    (define fun/void78099 (lambda () (void)))
    (define fun/error78092 (lambda () (call fun/error78093)))
    (define fun/any78094 (lambda () #f))
    (define fun/error78097 (lambda () (error 143)))
    (define fun/error78093 (lambda () (error 94)))
    (define fun/error78096 (lambda () (call fun/error78097)))
    (define fun/void78098 (lambda () (call fun/void78099)))
    (let ((error0 (call fun/error78092))
          (fixnum1
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
          (boolean2 (call boolean? (call fun/any78094)))
          (boolean3 (call ascii-char? (call fun/any78095)))
          (fixnum4
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
          (error5 (call fun/error78096)))
      (call fun/void78098))))
(check-by-interp
 '(module
    (define fun/vector78121 (lambda () (call make-vector 8)))
    (define fun/error78128 (lambda () (error 0)))
    (define fun/error78125 (lambda () (call fun/error78126)))
    (define fun/void78130 (lambda () (void)))
    (define fun/error78126 (lambda () (error 237)))
    (define fun/empty78124 (lambda () empty))
    (define fun/any78122 (lambda () (call make-vector 8)))
    (define fun/vector78120 (lambda () (call fun/vector78121)))
    (define fun/void78129 (lambda () (call fun/void78130)))
    (define fun/error78127 (lambda () (call fun/error78128)))
    (define fun/empty78123 (lambda () (call fun/empty78124)))
    (let ((vector0 (call fun/vector78120))
          (boolean1 (call ascii-char? (call fun/any78122)))
          (empty2 (call fun/empty78123))
          (error3 (call fun/error78125))
          (error4 (call fun/error78127))
          (void5 (call fun/void78129)))
      empty2)))
(check-by-interp
 '(module
    (define fun/ascii-char80978 (lambda () (call fun/ascii-char80979)))
    (define fun/void80976 (lambda () (call fun/void80977)))
    (define fun/empty80970 (lambda () (call fun/empty80971)))
    (define fun/void80977 (lambda () (void)))
    (define fun/empty80974 (lambda () (call fun/empty80975)))
    (define fun/empty80971 (lambda () empty))
    (define fun/vector80981 (lambda () (call make-vector 8)))
    (define fun/empty80975 (lambda () empty))
    (define fun/vector80980 (lambda () (call fun/vector80981)))
    (define fun/error80973 (lambda () (error 138)))
    (define fun/error80972 (lambda () (call fun/error80973)))
    (define fun/ascii-char80979 (lambda () #\c))
    (let ((empty0 (call fun/empty80970))
          (error1 (call fun/error80972))
          (empty2 (call fun/empty80974))
          (void3 (call fun/void80976))
          (ascii-char4 (call fun/ascii-char80978))
          (vector5 (call fun/vector80980)))
      void3)))
(check-by-interp
 '(module
    (define fun/void81922 (lambda () (void)))
    (define fun/void81924 (lambda () (void)))
    (define fun/ascii-char81925 (lambda () (call fun/ascii-char81926)))
    (define fun/error81919 (lambda () (call fun/error81920)))
    (define fun/vector81917 (lambda () (call fun/vector81918)))
    (define fun/ascii-char81926 (lambda () #\c))
    (define fun/error81920 (lambda () (error 189)))
    (define fun/void81923 (lambda () (call fun/void81924)))
    (define fun/void81915 (lambda () (call fun/void81916)))
    (define fun/void81921 (lambda () (call fun/void81922)))
    (define fun/vector81918 (lambda () (call make-vector 8)))
    (define fun/void81916 (lambda () (void)))
    (let ((void0 (call fun/void81915))
          (vector1 (call fun/vector81917))
          (error2 (call fun/error81919))
          (void3 (call fun/void81921))
          (void4 (call fun/void81923))
          (fixnum5
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
      (call fun/ascii-char81925))))
(check-by-interp
 '(module
    (define fun/ascii-char84565 (lambda () #\c))
    (define fun/vector84574 (lambda () (call make-vector 8)))
    (define fun/void84570 (lambda () (void)))
    (define fun/any84566 (lambda () #\c))
    (define fun/void84572 (lambda () (void)))
    (define fun/void84569 (lambda () (call fun/void84570)))
    (define fun/ascii-char84564 (lambda () (call fun/ascii-char84565)))
    (define fun/empty84567 (lambda () (call fun/empty84568)))
    (define fun/empty84568 (lambda () empty))
    (define fun/vector84573 (lambda () (call fun/vector84574)))
    (define fun/void84571 (lambda () (call fun/void84572)))
    (let ((ascii-char0 (call fun/ascii-char84564))
          (boolean1 (call vector? (call fun/any84566)))
          (empty2 (call fun/empty84567))
          (void3 (call fun/void84569))
          (void4 (call fun/void84571))
          (vector5 (call fun/vector84573)))
      vector5)))
(check-by-interp
 '(module
    (define fun/vector84815 (lambda () (call fun/vector84816)))
    (define fun/vector84812 (lambda () (call make-vector 8)))
    (define fun/ascii-char84820 (lambda () (call fun/ascii-char84821)))
    (define fun/ascii-char84821 (lambda () #\c))
    (define fun/error84818 (lambda () (error 169)))
    (define fun/error84817 (lambda () (call fun/error84818)))
    (define fun/vector84811 (lambda () (call fun/vector84812)))
    (define fun/vector84816 (lambda () (call make-vector 8)))
    (define fun/ascii-char84813 (lambda () (call fun/ascii-char84814)))
    (define fun/any84819 (lambda () #f))
    (define fun/ascii-char84814 (lambda () #\c))
    (let ((vector0 (call fun/vector84811))
          (ascii-char1 (call fun/ascii-char84813))
          (vector2 (call fun/vector84815))
          (error3 (call fun/error84817))
          (boolean4 (call pair? (call fun/any84819)))
          (ascii-char5 (call fun/ascii-char84820)))
      ascii-char1)))
(check-by-interp
 '(module
    (define fun/void87672 (lambda () (void)))
    (define fun/empty87673 (lambda () (call fun/empty87674)))
    (define fun/void87671 (lambda () (call fun/void87672)))
    (define fun/empty87668 (lambda () empty))
    (define fun/empty87670 (lambda () empty))
    (define fun/vector87675 (lambda () (call fun/vector87676)))
    (define fun/vector87676 (lambda () (call make-vector 8)))
    (define fun/empty87669 (lambda () (call fun/empty87670)))
    (define fun/error87677 (lambda () (call fun/error87678)))
    (define fun/empty87667 (lambda () (call fun/empty87668)))
    (define fun/empty87674 (lambda () empty))
    (define fun/error87678 (lambda () (error 135)))
    (let ((fixnum0
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
          (empty1 (call fun/empty87667))
          (empty2 (call fun/empty87669))
          (void3 (call fun/void87671))
          (empty4 (call fun/empty87673))
          (vector5 (call fun/vector87675)))
      (call fun/error87677))))
(check-by-interp
 '(module
    (define fun/empty87682 (lambda () empty))
    (define fun/empty87687 (lambda () (call fun/empty87688)))
    (define fun/void87685 (lambda () (call fun/void87686)))
    (define fun/vector87684 (lambda () (call make-vector 8)))
    (define fun/error87691 (lambda () (call fun/error87692)))
    (define fun/empty87688 (lambda () empty))
    (define fun/empty87690 (lambda () empty))
    (define fun/error87692 (lambda () (error 15)))
    (define fun/void87686 (lambda () (void)))
    (define fun/empty87689 (lambda () (call fun/empty87690)))
    (define fun/vector87683 (lambda () (call fun/vector87684)))
    (define fun/empty87681 (lambda () (call fun/empty87682)))
    (let ((empty0 (call fun/empty87681))
          (vector1 (call fun/vector87683))
          (void2 (call fun/void87685))
          (empty3 (call fun/empty87687))
          (empty4 (call fun/empty87689))
          (error5 (call fun/error87691)))
      void2)))
(check-by-interp
 '(module
    (define fun/vector89241 (lambda () (call make-vector 8)))
    (define fun/empty89236 (lambda () (call fun/empty89237)))
    (define fun/empty89243 (lambda () empty))
    (define fun/empty89244 (lambda () (call fun/empty89245)))
    (define fun/vector89240 (lambda () (call fun/vector89241)))
    (define fun/void89235 (lambda () (void)))
    (define fun/empty89237 (lambda () empty))
    (define fun/empty89245 (lambda () empty))
    (define fun/empty89238 (lambda () (call fun/empty89239)))
    (define fun/empty89239 (lambda () empty))
    (define fun/empty89242 (lambda () (call fun/empty89243)))
    (define fun/void89234 (lambda () (call fun/void89235)))
    (let ((void0 (call fun/void89234))
          (empty1 (call fun/empty89236))
          (empty2 (call fun/empty89238))
          (vector3 (call fun/vector89240))
          (empty4 (call fun/empty89242))
          (empty5 (call fun/empty89244)))
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
    (define fun/empty90359 (lambda () empty))
    (define fun/error90361 (lambda () (error 126)))
    (define fun/void90365 (lambda () (void)))
    (define fun/void90362 (lambda () (call fun/void90363)))
    (define fun/vector90356 (lambda () (call fun/vector90357)))
    (define fun/void90363 (lambda () (void)))
    (define fun/empty90358 (lambda () (call fun/empty90359)))
    (define fun/void90364 (lambda () (call fun/void90365)))
    (define fun/vector90357 (lambda () (call make-vector 8)))
    (define fun/error90360 (lambda () (call fun/error90361)))
    (let ((vector0 (call fun/vector90356))
          (empty1 (call fun/empty90358))
          (error2 (call fun/error90360))
          (fixnum3
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
          (void4 (call fun/void90362))
          (void5 (call fun/void90364)))
      vector0)))
(check-by-interp
 '(module
    (define fun/ascii-char91870 (lambda () #\c))
    (define fun/error91868 (lambda () (error 156)))
    (define fun/void91866 (lambda () (void)))
    (define fun/void91863 (lambda () (call fun/void91864)))
    (define fun/void91871 (lambda () (call fun/void91872)))
    (define fun/vector91873 (lambda () (call fun/vector91874)))
    (define fun/vector91874 (lambda () (call make-vector 8)))
    (define fun/ascii-char91869 (lambda () (call fun/ascii-char91870)))
    (define fun/void91865 (lambda () (call fun/void91866)))
    (define fun/void91864 (lambda () (void)))
    (define fun/void91872 (lambda () (void)))
    (define fun/error91867 (lambda () (call fun/error91868)))
    (let ((void0 (call fun/void91863))
          (void1 (call fun/void91865))
          (fixnum2
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
          (error3 (call fun/error91867))
          (ascii-char4 (call fun/ascii-char91869))
          (void5 (call fun/void91871)))
      (call fun/vector91873))))
(check-by-interp
 '(module
    (define fun/empty95365 (lambda () empty))
    (define fun/vector95371 (lambda () (call make-vector 8)))
    (define fun/empty95364 (lambda () (call fun/empty95365)))
    (define fun/error95367 (lambda () (error 83)))
    (define fun/error95366 (lambda () (call fun/error95367)))
    (define fun/empty95369 (lambda () empty))
    (define fun/vector95370 (lambda () (call fun/vector95371)))
    (define fun/empty95368 (lambda () (call fun/empty95369)))
    (let ((fixnum0
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
          (empty1 (call fun/empty95364))
          (fixnum2
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
          (error3 (call fun/error95366))
          (empty4 (call fun/empty95368))
          (vector5 (call fun/vector95370)))
      vector5)))
(check-by-interp
 '(module
    (define fun/any100103 (lambda () 81))
    (define fun/vector100108 (lambda () (call fun/vector100109)))
    (define fun/vector100109 (lambda () (call make-vector 8)))
    (define fun/ascii-char100104 (lambda () (call fun/ascii-char100105)))
    (define fun/empty100110 (lambda () (call fun/empty100111)))
    (define fun/error100107 (lambda () (error 186)))
    (define fun/empty100111 (lambda () empty))
    (define fun/error100106 (lambda () (call fun/error100107)))
    (define fun/ascii-char100105 (lambda () #\c))
    (let ((boolean0 (call error? (call fun/any100103)))
          (ascii-char1 (call fun/ascii-char100104))
          (error2 (call fun/error100106))
          (fixnum3
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
          (vector4 (call fun/vector100108))
          (fixnum5
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
      (call fun/empty100110))))
(check-by-interp
 '(module
    (define fun/void101999 (lambda () (void)))
    (define fun/empty101997 (lambda () empty))
    (define fun/ascii-char101994 (lambda () (call fun/ascii-char101995)))
    (define fun/void101992 (lambda () (call fun/void101993)))
    (define fun/void101998 (lambda () (call fun/void101999)))
    (define fun/empty101996 (lambda () (call fun/empty101997)))
    (define fun/any101991 (lambda () (void)))
    (define fun/ascii-char101995 (lambda () #\c))
    (define fun/void101993 (lambda () (void)))
    (let ((fixnum0
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
          (boolean1 (call boolean? (call fun/any101991)))
          (void2 (call fun/void101992))
          (ascii-char3 (call fun/ascii-char101994))
          (empty4 (call fun/empty101996))
          (void5 (call fun/void101998)))
      empty4)))
(check-by-interp
 '(module
    (define fun/void102362 (lambda () (call fun/void102363)))
    (define fun/empty102356 (lambda () (call fun/empty102357)))
    (define fun/error102354 (lambda () (call fun/error102355)))
    (define fun/void102358 (lambda () (call fun/void102359)))
    (define fun/void102353 (lambda () (void)))
    (define fun/void102363 (lambda () (void)))
    (define fun/error102355 (lambda () (error 147)))
    (define fun/void102352 (lambda () (call fun/void102353)))
    (define fun/empty102357 (lambda () empty))
    (define fun/void102359 (lambda () (void)))
    (define fun/void102360 (lambda () (call fun/void102361)))
    (define fun/void102361 (lambda () (void)))
    (let ((void0 (call fun/void102352))
          (error1 (call fun/error102354))
          (empty2 (call fun/empty102356))
          (void3 (call fun/void102358))
          (void4 (call fun/void102360))
          (void5 (call fun/void102362)))
      error1)))
(check-by-interp
 '(module
    (define fun/any104329 (lambda () #f))
    (define fun/vector104330 (lambda () (call fun/vector104331)))
    (define fun/error104328 (lambda () (error 201)))
    (define fun/error104327 (lambda () (call fun/error104328)))
    (define fun/vector104331 (lambda () (call make-vector 8)))
    (define fun/empty104332 (lambda () (call fun/empty104333)))
    (define fun/empty104333 (lambda () empty))
    (let ((error0 (call fun/error104327))
          (fixnum1
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
          (boolean2 (call vector? (call fun/any104329)))
          (vector3 (call fun/vector104330))
          (fixnum4
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
          (empty5 (call fun/empty104332)))
      fixnum1)))
(check-by-interp
 '(module
    (define fun/void104914 (lambda () (call fun/void104915)))
    (define fun/ascii-char104905 (lambda () #\c))
    (define fun/empty104912 (lambda () (call fun/empty104913)))
    (define fun/vector104906 (lambda () (call fun/vector104907)))
    (define fun/ascii-char104904 (lambda () (call fun/ascii-char104905)))
    (define fun/error104911 (lambda () (error 197)))
    (define fun/void104908 (lambda () (call fun/void104909)))
    (define fun/void104915 (lambda () (void)))
    (define fun/error104910 (lambda () (call fun/error104911)))
    (define fun/vector104907 (lambda () (call make-vector 8)))
    (define fun/empty104913 (lambda () empty))
    (define fun/void104909 (lambda () (void)))
    (let ((ascii-char0 (call fun/ascii-char104904))
          (vector1 (call fun/vector104906))
          (void2 (call fun/void104908))
          (error3 (call fun/error104910))
          (empty4 (call fun/empty104912))
          (void5 (call fun/void104914)))
      empty4)))
(check-by-interp
 '(module
    (define fun/error106438 (lambda () (error 65)))
    (define fun/error106446 (lambda () (error 16)))
    (define fun/error106442 (lambda () (error 56)))
    (define fun/any106436 (lambda () #\c))
    (define fun/empty106443 (lambda () (call fun/empty106444)))
    (define fun/error106441 (lambda () (call fun/error106442)))
    (define fun/vector106439 (lambda () (call fun/vector106440)))
    (define fun/empty106444 (lambda () empty))
    (define fun/vector106440 (lambda () (call make-vector 8)))
    (define fun/error106437 (lambda () (call fun/error106438)))
    (define fun/error106445 (lambda () (call fun/error106446)))
    (let ((boolean0 (call void? (call fun/any106436)))
          (error1 (call fun/error106437))
          (vector2 (call fun/vector106439))
          (error3 (call fun/error106441))
          (empty4 (call fun/empty106443))
          (error5 (call fun/error106445)))
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
    (define fun/vector107085 (lambda () (call make-vector 8)))
    (define fun/error107087 (lambda () (error 180)))
    (define fun/error107086 (lambda () (call fun/error107087)))
    (define fun/empty107081 (lambda () (call fun/empty107082)))
    (define fun/void107078 (lambda () (call fun/void107079)))
    (define fun/any107083 (lambda () #t))
    (define fun/vector107084 (lambda () (call fun/vector107085)))
    (define fun/void107079 (lambda () (void)))
    (define fun/empty107082 (lambda () empty))
    (define fun/any107080 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void107078))
          (boolean1 (call empty? (call fun/any107080)))
          (empty2 (call fun/empty107081))
          (boolean3 (call error? (call fun/any107083)))
          (vector4 (call fun/vector107084))
          (error5 (call fun/error107086)))
      void0)))
(check-by-interp
 '(module
    (define fun/void117284 (lambda () (call fun/void117285)))
    (define fun/void117286 (lambda () (call fun/void117287)))
    (define fun/empty117283 (lambda () empty))
    (define fun/vector117280 (lambda () (call make-vector 8)))
    (define fun/void117287 (lambda () (void)))
    (define fun/vector117279 (lambda () (call fun/vector117280)))
    (define fun/any117281 (lambda () 147))
    (define fun/any117288 (lambda () #f))
    (define fun/empty117282 (lambda () (call fun/empty117283)))
    (define fun/void117285 (lambda () (void)))
    (let ((vector0 (call fun/vector117279))
          (boolean1 (call void? (call fun/any117281)))
          (empty2 (call fun/empty117282))
          (void3 (call fun/void117284))
          (void4 (call fun/void117286))
          (boolean5 (call fixnum? (call fun/any117288))))
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
    (define fun/any119338 (lambda () (call make-vector 8)))
    (define fun/empty119330 (lambda () (call fun/empty119331)))
    (define fun/vector119340 (lambda () (call make-vector 8)))
    (define fun/error119329 (lambda () (error 26)))
    (define fun/error119337 (lambda () (error 74)))
    (define fun/vector119339 (lambda () (call fun/vector119340)))
    (define fun/void119332 (lambda () (call fun/void119333)))
    (define fun/void119334 (lambda () (call fun/void119335)))
    (define fun/void119333 (lambda () (void)))
    (define fun/void119335 (lambda () (void)))
    (define fun/error119328 (lambda () (call fun/error119329)))
    (define fun/error119336 (lambda () (call fun/error119337)))
    (define fun/empty119331 (lambda () empty))
    (let ((error0 (call fun/error119328))
          (empty1 (call fun/empty119330))
          (void2 (call fun/void119332))
          (void3 (call fun/void119334))
          (error4 (call fun/error119336))
          (boolean5 (call boolean? (call fun/any119338))))
      (call fun/vector119339))))
(check-by-interp
 '(module
    (define fun/empty122092 (lambda () (call fun/empty122093)))
    (define fun/vector122090 (lambda () (call make-vector 8)))
    (define fun/vector122088 (lambda () (call make-vector 8)))
    (define fun/error122085 (lambda () (call fun/error122086)))
    (define fun/any122091 (lambda () #t))
    (define fun/vector122089 (lambda () (call fun/vector122090)))
    (define fun/vector122087 (lambda () (call fun/vector122088)))
    (define fun/empty122093 (lambda () empty))
    (define fun/error122086 (lambda () (error 139)))
    (let ((error0 (call fun/error122085))
          (vector1 (call fun/vector122087))
          (fixnum2
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
          (vector3 (call fun/vector122089))
          (boolean4 (call ascii-char? (call fun/any122091)))
          (fixnum5
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
      (call fun/empty122092))))
(check-by-interp
 '(module
    (define fun/void122163 (lambda () (call fun/void122164)))
    (define fun/ascii-char122159 (lambda () (call fun/ascii-char122160)))
    (define fun/ascii-char122160 (lambda () #\c))
    (define fun/ascii-char122162 (lambda () #\c))
    (define fun/empty122158 (lambda () empty))
    (define fun/error122165 (lambda () (call fun/error122166)))
    (define fun/error122166 (lambda () (error 183)))
    (define fun/any122156 (lambda () empty))
    (define fun/empty122157 (lambda () (call fun/empty122158)))
    (define fun/void122164 (lambda () (void)))
    (define fun/ascii-char122161 (lambda () (call fun/ascii-char122162)))
    (let ((boolean0 (call boolean? (call fun/any122156)))
          (empty1 (call fun/empty122157))
          (fixnum2
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
          (ascii-char3 (call fun/ascii-char122159))
          (ascii-char4 (call fun/ascii-char122161))
          (void5 (call fun/void122163)))
      (call fun/error122165))))
(check-by-interp
 '(module
    (define fun/void122175 (lambda () (call fun/void122176)))
    (define fun/vector122173 (lambda () (call fun/vector122174)))
    (define fun/vector122171 (lambda () (call fun/vector122172)))
    (define fun/error122177 (lambda () (call fun/error122178)))
    (define fun/vector122172 (lambda () (call make-vector 8)))
    (define fun/vector122169 (lambda () (call fun/vector122170)))
    (define fun/void122176 (lambda () (void)))
    (define fun/vector122174 (lambda () (call make-vector 8)))
    (define fun/vector122170 (lambda () (call make-vector 8)))
    (define fun/error122178 (lambda () (error 4)))
    (let ((vector0 (call fun/vector122169))
          (vector1 (call fun/vector122171))
          (vector2 (call fun/vector122173))
          (void3 (call fun/void122175))
          (error4 (call fun/error122177))
          (fixnum5
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
      vector0)))
(check-by-interp
 '(module
    (define fun/void124216 (lambda () (void)))
    (define fun/ascii-char124211 (lambda () (call fun/ascii-char124212)))
    (define fun/error124206 (lambda () (error 34)))
    (define fun/error124213 (lambda () (call fun/error124214)))
    (define fun/ascii-char124207 (lambda () (call fun/ascii-char124208)))
    (define fun/void124215 (lambda () (call fun/void124216)))
    (define fun/ascii-char124212 (lambda () #\c))
    (define fun/error124214 (lambda () (error 6)))
    (define fun/error124209 (lambda () (call fun/error124210)))
    (define fun/error124210 (lambda () (error 3)))
    (define fun/ascii-char124208 (lambda () #\c))
    (define fun/error124205 (lambda () (call fun/error124206)))
    (let ((error0 (call fun/error124205))
          (ascii-char1 (call fun/ascii-char124207))
          (error2 (call fun/error124209))
          (ascii-char3 (call fun/ascii-char124211))
          (error4 (call fun/error124213))
          (fixnum5
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
      (call fun/void124215))))
(check-by-interp
 '(module
    (define fun/empty131526 (lambda () (call fun/empty131527)))
    (define fun/vector131525 (lambda () (call make-vector 8)))
    (define fun/empty131527 (lambda () empty))
    (define fun/error131520 (lambda () (call fun/error131521)))
    (define fun/ascii-char131523 (lambda () #\c))
    (define fun/vector131524 (lambda () (call fun/vector131525)))
    (define fun/ascii-char131522 (lambda () (call fun/ascii-char131523)))
    (define fun/void131529 (lambda () (void)))
    (define fun/error131521 (lambda () (error 185)))
    (define fun/void131528 (lambda () (call fun/void131529)))
    (let ((error0 (call fun/error131520))
          (fixnum1
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
          (ascii-char2 (call fun/ascii-char131522))
          (vector3 (call fun/vector131524))
          (empty4 (call fun/empty131526))
          (void5 (call fun/void131528)))
      ascii-char2)))
(check-by-interp
 '(module
    (define fun/void140296 (lambda () (call fun/void140297)))
    (define fun/error140294 (lambda () (call fun/error140295)))
    (define fun/ascii-char140301 (lambda () #\c))
    (define fun/vector140299 (lambda () (call make-vector 8)))
    (define fun/vector140303 (lambda () (call make-vector 8)))
    (define fun/ascii-char140300 (lambda () (call fun/ascii-char140301)))
    (define fun/vector140298 (lambda () (call fun/vector140299)))
    (define fun/vector140302 (lambda () (call fun/vector140303)))
    (define fun/void140297 (lambda () (void)))
    (define fun/error140295 (lambda () (error 203)))
    (let ((error0 (call fun/error140294))
          (void1 (call fun/void140296))
          (vector2 (call fun/vector140298))
          (ascii-char3 (call fun/ascii-char140300))
          (vector4 (call fun/vector140302))
          (fixnum5
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
      ascii-char3)))
(check-by-interp
 '(module
    (define fun/vector147263 (lambda () (call make-vector 8)))
    (define fun/ascii-char147266 (lambda () (call fun/ascii-char147267)))
    (define fun/vector147264 (lambda () (call fun/vector147265)))
    (define fun/any147268 (lambda () empty))
    (define fun/vector147265 (lambda () (call make-vector 8)))
    (define fun/ascii-char147267 (lambda () #\c))
    (define fun/vector147262 (lambda () (call fun/vector147263)))
    (define fun/any147269 (lambda () (error 134)))
    (let ((vector0 (call fun/vector147262))
          (vector1 (call fun/vector147264))
          (ascii-char2 (call fun/ascii-char147266))
          (fixnum3
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
          (fixnum4
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
          (boolean5 (call boolean? (call fun/any147268))))
      (call pair? (call fun/any147269)))))
(check-by-interp
 '(module
    (define fun/void147282 (lambda () (call fun/void147283)))
    (define fun/error147274 (lambda () (call fun/error147275)))
    (define fun/vector147276 (lambda () (call fun/vector147277)))
    (define fun/ascii-char147281 (lambda () #\c))
    (define fun/empty147279 (lambda () empty))
    (define fun/ascii-char147280 (lambda () (call fun/ascii-char147281)))
    (define fun/vector147277 (lambda () (call make-vector 8)))
    (define fun/void147283 (lambda () (void)))
    (define fun/void147273 (lambda () (void)))
    (define fun/empty147278 (lambda () (call fun/empty147279)))
    (define fun/void147272 (lambda () (call fun/void147273)))
    (define fun/error147275 (lambda () (error 201)))
    (let ((void0 (call fun/void147272))
          (error1 (call fun/error147274))
          (vector2 (call fun/vector147276))
          (empty3 (call fun/empty147278))
          (ascii-char4 (call fun/ascii-char147280))
          (void5 (call fun/void147282)))
      void5)))
(check-by-interp
 '(module
    (define fun/empty148213 (lambda () empty))
    (define fun/error148211 (lambda () (error 77)))
    (define fun/error148208 (lambda () (call fun/error148209)))
    (define fun/vector148203 (lambda () (call fun/vector148204)))
    (define fun/empty148205 (lambda () (call fun/empty148206)))
    (define fun/vector148204 (lambda () (call make-vector 8)))
    (define fun/empty148212 (lambda () (call fun/empty148213)))
    (define fun/error148210 (lambda () (call fun/error148211)))
    (define fun/empty148206 (lambda () empty))
    (define fun/error148209 (lambda () (error 207)))
    (define fun/any148207 (lambda () #\c))
    (let ((vector0 (call fun/vector148203))
          (empty1 (call fun/empty148205))
          (boolean2 (call fixnum? (call fun/any148207)))
          (error3 (call fun/error148208))
          (error4 (call fun/error148210))
          (empty5 (call fun/empty148212)))
      vector0)))
(check-by-interp
 '(module
    (define fun/vector148219 (lambda () (call make-vector 8)))
    (define fun/empty148216 (lambda () (call fun/empty148217)))
    (define fun/empty148217 (lambda () empty))
    (define fun/vector148218 (lambda () (call fun/vector148219)))
    (define fun/error148223 (lambda () (error 15)))
    (define fun/vector148220 (lambda () (call fun/vector148221)))
    (define fun/vector148221 (lambda () (call make-vector 8)))
    (define fun/error148222 (lambda () (call fun/error148223)))
    (let ((empty0 (call fun/empty148216))
          (vector1 (call fun/vector148218))
          (fixnum2
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
          (fixnum3
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
          (vector4 (call fun/vector148220))
          (error5 (call fun/error148222)))
      (call
       -
       fixnum2
       (call
        -
        (call - (call * fixnum3 65) fixnum2)
        (call - (call - 199 236) fixnum2))))))
(check-by-interp
 '(module
    (define fun/any153346 (lambda () empty))
    (define fun/empty153339 (lambda () empty))
    (define fun/void153340 (lambda () (call fun/void153341)))
    (define fun/ascii-char153343 (lambda () #\c))
    (define fun/empty153338 (lambda () (call fun/empty153339)))
    (define fun/error153348 (lambda () (error 235)))
    (define fun/vector153344 (lambda () (call fun/vector153345)))
    (define fun/vector153345 (lambda () (call make-vector 8)))
    (define fun/ascii-char153342 (lambda () (call fun/ascii-char153343)))
    (define fun/void153341 (lambda () (void)))
    (define fun/error153347 (lambda () (call fun/error153348)))
    (let ((empty0 (call fun/empty153338))
          (void1 (call fun/void153340))
          (ascii-char2 (call fun/ascii-char153342))
          (vector3 (call fun/vector153344))
          (boolean4 (call boolean? (call fun/any153346)))
          (error5 (call fun/error153347)))
      void1)))
(check-by-interp
 '(module
    (define fun/ascii-char156382 (lambda () (call fun/ascii-char156383)))
    (define fun/void156379 (lambda () (call fun/void156380)))
    (define fun/void156380 (lambda () (void)))
    (define fun/void156387 (lambda () (void)))
    (define fun/any156381 (lambda () (error 44)))
    (define fun/void156386 (lambda () (call fun/void156387)))
    (define fun/ascii-char156384 (lambda () (call fun/ascii-char156385)))
    (define fun/ascii-char156383 (lambda () #\c))
    (define fun/ascii-char156385 (lambda () #\c))
    (let ((void0 (call fun/void156379))
          (boolean1 (call pair? (call fun/any156381)))
          (fixnum2
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
          (ascii-char3 (call fun/ascii-char156382))
          (ascii-char4 (call fun/ascii-char156384))
          (void5 (call fun/void156386)))
      (call
       -
       fixnum2
       (call * fixnum2 (call - (call + 114 243) (call + 237 fixnum2)))))))
(check-by-interp
 '(module
    (define fun/empty158617 (lambda () empty))
    (define fun/vector158612 (lambda () (call fun/vector158613)))
    (define fun/void158610 (lambda () (call fun/void158611)))
    (define fun/vector158608 (lambda () (call fun/vector158609)))
    (define fun/void158611 (lambda () (void)))
    (define fun/empty158616 (lambda () (call fun/empty158617)))
    (define fun/void158615 (lambda () (void)))
    (define fun/vector158613 (lambda () (call make-vector 8)))
    (define fun/void158614 (lambda () (call fun/void158615)))
    (define fun/vector158609 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector158608))
          (void1 (call fun/void158610))
          (fixnum2
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
          (vector3 (call fun/vector158612))
          (void4 (call fun/void158614))
          (empty5 (call fun/empty158616)))
      empty5)))
(check-by-interp
 '(module
    (define fun/empty160322 (lambda () (call fun/empty160323)))
    (define fun/vector160326 (lambda () (call fun/vector160327)))
    (define fun/error160329 (lambda () (error 200)))
    (define fun/vector160324 (lambda () (call fun/vector160325)))
    (define fun/vector160320 (lambda () (call fun/vector160321)))
    (define fun/vector160325 (lambda () (call make-vector 8)))
    (define fun/vector160321 (lambda () (call make-vector 8)))
    (define fun/empty160323 (lambda () empty))
    (define fun/error160328 (lambda () (call fun/error160329)))
    (define fun/vector160327 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector160320))
          (fixnum1
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
          (empty2 (call fun/empty160322))
          (vector3 (call fun/vector160324))
          (vector4 (call fun/vector160326))
          (error5 (call fun/error160328)))
      vector0)))
(check-by-interp
 '(module
    (define fun/vector163238 (lambda () (call fun/vector163239)))
    (define fun/vector163240 (lambda () (call fun/vector163241)))
    (define fun/vector163239 (lambda () (call make-vector 8)))
    (define fun/ascii-char163243 (lambda () #\c))
    (define fun/vector163244 (lambda () (call fun/vector163245)))
    (define fun/vector163245 (lambda () (call make-vector 8)))
    (define fun/ascii-char163242 (lambda () (call fun/ascii-char163243)))
    (define fun/vector163241 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector163238))
          (fixnum1
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
          (vector2 (call fun/vector163240))
          (ascii-char3 (call fun/ascii-char163242))
          (vector4 (call fun/vector163244))
          (fixnum5
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
       (call * (call * fixnum5 (call + 52 fixnum5)) fixnum5)
       (call * fixnum5 (call + (call * 151 83) fixnum1))))))
(check-by-interp
 '(module
    (define fun/empty163426 (lambda () empty))
    (define fun/void163423 (lambda () (call fun/void163424)))
    (define fun/vector163419 (lambda () (call fun/vector163420)))
    (define fun/void163428 (lambda () (void)))
    (define fun/empty163422 (lambda () empty))
    (define fun/vector163430 (lambda () (call make-vector 8)))
    (define fun/void163427 (lambda () (call fun/void163428)))
    (define fun/void163424 (lambda () (void)))
    (define fun/vector163420 (lambda () (call make-vector 8)))
    (define fun/vector163429 (lambda () (call fun/vector163430)))
    (define fun/empty163421 (lambda () (call fun/empty163422)))
    (define fun/empty163425 (lambda () (call fun/empty163426)))
    (let ((vector0 (call fun/vector163419))
          (empty1 (call fun/empty163421))
          (void2 (call fun/void163423))
          (empty3 (call fun/empty163425))
          (void4 (call fun/void163427))
          (vector5 (call fun/vector163429)))
      vector5)))
(check-by-interp
 '(module
    (define fun/error164708 (lambda () (error 129)))
    (define fun/vector164702 (lambda () (call fun/vector164703)))
    (define fun/empty164704 (lambda () (call fun/empty164705)))
    (define fun/any164711 (lambda () #\c))
    (define fun/vector164709 (lambda () (call fun/vector164710)))
    (define fun/error164707 (lambda () (call fun/error164708)))
    (define fun/vector164710 (lambda () (call make-vector 8)))
    (define fun/vector164703 (lambda () (call make-vector 8)))
    (define fun/any164706 (lambda () 126))
    (define fun/empty164705 (lambda () empty))
    (let ((vector0 (call fun/vector164702))
          (empty1 (call fun/empty164704))
          (boolean2 (call empty? (call fun/any164706)))
          (error3 (call fun/error164707))
          (vector4 (call fun/vector164709))
          (boolean5 (call empty? (call fun/any164711))))
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
    (define fun/ascii-char165508 (lambda () (call fun/ascii-char165509)))
    (define fun/ascii-char165506 (lambda () (call fun/ascii-char165507)))
    (define fun/void165513 (lambda () (void)))
    (define fun/void165502 (lambda () (call fun/void165503)))
    (define fun/empty165504 (lambda () (call fun/empty165505)))
    (define fun/void165510 (lambda () (call fun/void165511)))
    (define fun/ascii-char165507 (lambda () #\c))
    (define fun/ascii-char165509 (lambda () #\c))
    (define fun/void165511 (lambda () (void)))
    (define fun/void165503 (lambda () (void)))
    (define fun/vector165515 (lambda () (call make-vector 8)))
    (define fun/empty165505 (lambda () empty))
    (define fun/void165512 (lambda () (call fun/void165513)))
    (define fun/vector165514 (lambda () (call fun/vector165515)))
    (let ((void0 (call fun/void165502))
          (empty1 (call fun/empty165504))
          (ascii-char2 (call fun/ascii-char165506))
          (ascii-char3 (call fun/ascii-char165508))
          (void4 (call fun/void165510))
          (void5 (call fun/void165512)))
      (call fun/vector165514))))
(check-by-interp
 '(module
    (define fun/vector171323 (lambda () (call fun/vector171324)))
    (define fun/vector171324 (lambda () (call make-vector 8)))
    (define fun/empty171322 (lambda () empty))
    (define fun/error171325 (lambda () (call fun/error171326)))
    (define fun/error171326 (lambda () (error 12)))
    (define fun/empty171321 (lambda () (call fun/empty171322)))
    (define fun/ascii-char171319 (lambda () (call fun/ascii-char171320)))
    (define fun/ascii-char171320 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char171319))
          (empty1 (call fun/empty171321))
          (vector2 (call fun/vector171323))
          (fixnum3
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
          (error4 (call fun/error171325))
          (fixnum5
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
      empty1)))
(check-by-interp
 '(module
    (define fun/vector171578 (lambda () (call make-vector 8)))
    (define fun/void171571 (lambda () (call fun/void171572)))
    (define fun/empty171582 (lambda () empty))
    (define fun/void171575 (lambda () (call fun/void171576)))
    (define fun/empty171574 (lambda () empty))
    (define fun/void171572 (lambda () (void)))
    (define fun/ascii-char171579 (lambda () (call fun/ascii-char171580)))
    (define fun/ascii-char171580 (lambda () #\c))
    (define fun/vector171577 (lambda () (call fun/vector171578)))
    (define fun/empty171581 (lambda () (call fun/empty171582)))
    (define fun/empty171573 (lambda () (call fun/empty171574)))
    (define fun/void171576 (lambda () (void)))
    (let ((void0 (call fun/void171571))
          (empty1 (call fun/empty171573))
          (void2 (call fun/void171575))
          (vector3 (call fun/vector171577))
          (ascii-char4 (call fun/ascii-char171579))
          (empty5 (call fun/empty171581)))
      vector3)))
(check-by-interp
 '(module
    (define fun/empty171686 (lambda () (call fun/empty171687)))
    (define fun/void171689 (lambda () (void)))
    (define fun/ascii-char171684 (lambda () (call fun/ascii-char171685)))
    (define fun/void171688 (lambda () (call fun/void171689)))
    (define fun/void171691 (lambda () (void)))
    (define fun/ascii-char171685 (lambda () #\c))
    (define fun/empty171687 (lambda () empty))
    (define fun/void171690 (lambda () (call fun/void171691)))
    (let ((fixnum0
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
          (fixnum1
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
          (ascii-char2 (call fun/ascii-char171684))
          (empty3 (call fun/empty171686))
          (void4 (call fun/void171688))
          (void5 (call fun/void171690)))
      fixnum1)))
