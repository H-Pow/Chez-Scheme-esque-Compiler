#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         "../implement-safe-primops.rkt")
(define (fail-if-invalid p)
  (when (not (exprs-unsafe-data-lang-v9? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "exprs-unsafe-data-lang-v9"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-exprs-unique-lang-v9 p)
  (interp-exprs-unsafe-data-lang-v9
   (fail-if-invalid (implement-safe-primops p)))))

(check-by-interp '(module 173))
(check-by-interp '(module 239))
(check-by-interp
 '(module
    (define fun/error8447.4 (lambda () (error 233)))
    (call fun/error8447.4)))
(check-by-interp
 '(module (define fun/fixnum8450.4 (lambda () 36)) (call fun/fixnum8450.4)))
(check-by-interp
 '(module
    (define fun/vector8453.4 (lambda () (call make-vector 8)))
    (call fun/vector8453.4)))
(check-by-interp
 '(module
    (define fun/error8456.4 (lambda () (error 240)))
    (call fun/error8456.4)))
(check-by-interp '(module (if #t (error 111) (error 246))))
(check-by-interp
 '(module
    (define fun/error8470.4 (lambda (oprand0.6) (call fun/error8471.5)))
    (define fun/error8471.5 (lambda () (error 217)))
    (call
     fun/error8470.4
     (let ((fixnum0.8 250) (vector1.7 (call make-vector 8))) 136))))
(check-by-interp
 '(module
    (define fun/ascii-char8474.4 (lambda (oprand0.6) #\V))
    (define fun/void8475.5 (lambda (oprand0.7) (void)))
    (call fun/ascii-char8474.4 (call fun/void8475.5 #t))))
(check-by-interp
 '(module
    (define fun/empty8478.4 (lambda (oprand0.5) empty))
    (call
     fun/empty8478.4
     (let ((error0.7 (error 53)) (error1.6 (error 196))) empty))))
(check-by-interp
 '(module
    (define fun/ascii-char8481.4 (lambda (oprand0.5) #\\))
    (call fun/ascii-char8481.4 (if #f empty empty))))
(check-by-interp
 '(module
    (define fun/pair8495.4
      (lambda (oprand0.7 oprand1.6) (call fun/pair8496.5)))
    (define fun/pair8496.5 (lambda () (call cons 33 428)))
    (call
     fun/pair8495.4
     (call
      *
      (call * 120 100)
      (let ((ascii-char0.10 #\M) (boolean1.9 #t) (boolean2.8 #t)) 196))
     (call ascii-char? (if #t #\^ (void))))))
(check-by-interp
 '(module
    (define fun/pair8508.4
      (lambda (oprand0.11 oprand1.10) (call fun/pair8509.5)))
    (define fun/pair8509.5 (lambda () (call cons 105 344)))
    (define fun/empty8511.6 (lambda (oprand0.13 oprand1.12) empty))
    (define fun/void8507.7 (lambda () (void)))
    (define fun/error8510.8 (lambda (oprand0.15 oprand1.14) (error 153)))
    (define fun/void8506.9
      (lambda (oprand0.17 oprand1.16) (call fun/void8507.7)))
    (call
     fun/void8506.9
     (let ((ascii-char0.20 #\j)
           (vector1.19 (call make-vector 8))
           (boolean2.18 #t))
       (error 147))
     (call
      fun/pair8508.4
      (call fun/error8510.8 (void) (void))
      (call fun/empty8511.6 (error 142) #\C)))))
(check-by-interp
 '(module
    (define fun/void8532.4
      (lambda (oprand0.10 oprand1.9) (call vector-set! oprand1.9 7 30)))
    (define fun/boolean8529.5 (lambda () #t))
    (define fun/ascii-char8530.6
      (lambda (oprand0.12 oprand1.11) (call fun/ascii-char8531.8)))
    (define fun/boolean8528.7
      (lambda (oprand0.14 oprand1.13) (call fun/boolean8529.5)))
    (define fun/ascii-char8531.8 (lambda () #\V))
    (call
     fun/boolean8528.7
     (call
      fun/ascii-char8530.6
      (if #t empty empty)
      (call fun/void8532.4 #\t (call make-vector 8)))
     (if #t empty empty))))
(check-by-interp
 '(module
    (define fun/empty8535.4 (lambda () empty))
    (define fun/empty8537.5 (lambda () empty))
    (define fun/vector8536.6 (lambda () (call make-vector 8)))
    (let ((empty0.9 (call fun/empty8535.4))
          (boolean1.8 (call boolean? (call cons 80 414)))
          (vector2.7 (call fun/vector8536.6)))
      (call fun/empty8537.5))))
(check-by-interp
 '(module
    (define fun/pair8561.4 (lambda () (call cons 251 399)))
    (define fun/ascii-char8562.5
      (lambda (oprand0.10 oprand1.9) (call fun/ascii-char8563.7)))
    (define fun/pair8560.6
      (lambda (oprand0.12 oprand1.11) (call fun/pair8561.4)))
    (define fun/ascii-char8563.7 (lambda () #\s))
    (define fun/empty8564.8 (lambda (oprand0.14 oprand1.13) empty))
    (call
     fun/pair8560.6
     (if #f 61 74)
     (call
      fun/ascii-char8562.5
      (call fun/empty8564.8 empty #\r)
      (if #t #t #f)))))
(check-by-interp
 '(module
    (define fun/ascii-char8613.4 (lambda () #\B))
    (define fun/vector8612.5 (lambda () (call make-vector 8)))
    (define fun/ascii-char8614.6 (lambda () #\S))
    (define fun/void8611.7 (lambda () (void)))
    (let ((fixnum0.11 (call + (call * 77 201) (call - 53 40)))
          (void1.10 (call fun/void8611.7))
          (vector2.9 (call fun/vector8612.5))
          (ascii-char3.8 (call fun/ascii-char8613.4)))
      (call fun/ascii-char8614.6))))
(check-by-interp
 '(module
    (define fun/ascii-char8617.4 (lambda () #\X))
    (define fun/vector8619.5 (lambda () (call make-vector 8)))
    (define fun/void8618.6 (lambda () (void)))
    (let ((fixnum0.10 (call * (call + 178 122) (call + 57 87)))
          (ascii-char1.9 (call fun/ascii-char8617.4))
          (fixnum2.8 (call + (call - 27 2) (call * 32 157)))
          (void3.7 (call fun/void8618.6)))
      (call fun/vector8619.5))))
(check-by-interp
 '(module
    (define fun/any8771.4 (lambda () (call make-vector 8)))
    (define fun/empty8774.5 (lambda () empty))
    (define fun/void8770.6 (lambda () (void)))
    (define fun/any8773.7 (lambda () empty))
    (define fun/vector8772.8 (lambda () (call make-vector 8)))
    (let ((void0.12 (call fun/void8770.6))
          (boolean1.11 (call error? (call fun/any8771.4)))
          (vector2.10 (call fun/vector8772.8))
          (procedure3.9 (lambda () (call vector? (call fun/any8773.7)))))
      (call fun/empty8774.5))))
(check-by-interp
 '(module
    (define fun/vector9390.4 (lambda () (call fun/vector9391.11)))
    (define fun/error9387.5 (lambda () (error 4)))
    (define fun/ascii-char9394.6 (lambda () (call fun/ascii-char9395.7)))
    (define fun/ascii-char9395.7 (lambda () #\r))
    (define fun/vector9389.8 (lambda () (call make-vector 8)))
    (define fun/error9386.9 (lambda () (call fun/error9387.5)))
    (define fun/vector9393.10 (lambda () (call make-vector 8)))
    (define fun/vector9391.11 (lambda () (call make-vector 8)))
    (define fun/vector9392.12 (lambda () (call fun/vector9393.10)))
    (define fun/vector9388.13 (lambda () (call fun/vector9389.8)))
    (let ((error0.18 (call fun/error9386.9))
          (vector1.17 (call fun/vector9388.13))
          (vector2.16 (call fun/vector9390.4))
          (vector3.15 (call fun/vector9392.12))
          (ascii-char4.14 (call fun/ascii-char9394.6)))
      (call vector-ref vector2.16 6))))
(check-by-interp
 '(module
    (define fun/void9398.4 (lambda () (call fun/void9399.9)))
    (define fun/empty9407.5 (lambda () empty))
    (define fun/ascii-char9403.6 (lambda () #\d))
    (define fun/pair9400.7 (lambda () (call fun/pair9401.12)))
    (define fun/vector9404.8 (lambda () (call fun/vector9405.11)))
    (define fun/void9399.9 (lambda () (void)))
    (define fun/empty9406.10 (lambda () (call fun/empty9407.5)))
    (define fun/vector9405.11 (lambda () (call make-vector 8)))
    (define fun/pair9401.12 (lambda () (call cons 242 377)))
    (define fun/ascii-char9402.13 (lambda () (call fun/ascii-char9403.6)))
    (let ((void0.18 (call fun/void9398.4))
          (fixnum1.17
           (call
            -
            (call * (call * 245 94) (call - 94 201))
            (call + (call - 225 16) (call + 46 174))))
          (procedure2.16 (lambda () (call fun/pair9400.7)))
          (ascii-char3.15 (call fun/ascii-char9402.13))
          (procedure4.14 (lambda () (call fun/vector9404.8))))
      (call fun/empty9406.10))))
(check-by-interp
 '(module
    (define fun/ascii-char10601.4 (lambda () #\z))
    (define fun/empty10599.5 (lambda () empty))
    (define fun/vector10595.6 (lambda () (call make-vector 8)))
    (define fun/ascii-char10597.7 (lambda () #\e))
    (define fun/empty10602.8 (lambda () empty))
    (define fun/boolean10598.9
      (lambda (oprand0.17 oprand1.16 oprand2.15 oprand3.14) #t))
    (define fun/void10594.10 (lambda () (void)))
    (define fun/empty10603.11 (lambda () empty))
    (define fun/void10600.12 (lambda () (void)))
    (define fun/void10596.13 (lambda () (void)))
    (call
     +
     (let ((void0.22 (call fun/void10594.10))
           (vector1.21 (call fun/vector10595.6))
           (void2.20 (call fun/void10596.13))
           (ascii-char3.19 (call fun/ascii-char10597.7))
           (fixnum4.18 (call - (call - 106 114) (call + 237 60))))
       (call - (call vector-ref vector1.21 0) (call * 24 223)))
     (call
      +
      (if (call
           fun/boolean10598.9
           (call cons 171 353)
           #f
           (call cons 5 286)
           (call cons 160 305))
        (let ((void0.27 (void))
              (vector1.26 (call make-vector 8))
              (ascii-char2.25 #\s)
              (boolean3.24 #f)
              (void4.23 (void)))
          87)
        (call * 43 99))
      (let ((empty0.32 (call fun/empty10599.5))
            (void1.31 (call fun/void10600.12))
            (ascii-char2.30 (call fun/ascii-char10601.4))
            (empty3.29 (call fun/empty10602.8))
            (empty4.28 (call fun/empty10603.11)))
        (call + 83 196))))))
(check-by-interp
 '(module
    (define fun/empty12824.4 (lambda () (call fun/empty12825.10)))
    (define fun/vector12814.5 (lambda () (call fun/vector12815.15)))
    (define fun/vector12823.6 (lambda () (call make-vector 8)))
    (define fun/error12816.7 (lambda () (call fun/error12817.12)))
    (define fun/vector12821.8 (lambda () (call make-vector 8)))
    (define fun/ascii-char12819.9 (lambda () #\T))
    (define fun/empty12825.10 (lambda () empty))
    (define fun/ascii-char12818.11 (lambda () (call fun/ascii-char12819.9)))
    (define fun/error12817.12 (lambda () (error 104)))
    (define fun/vector12822.13 (lambda () (call fun/vector12823.6)))
    (define fun/vector12820.14 (lambda () (call fun/vector12821.8)))
    (define fun/vector12815.15 (lambda () (call make-vector 8)))
    (let ((vector0.21 (call fun/vector12814.5))
          (error1.20 (call fun/error12816.7))
          (ascii-char2.19 (call fun/ascii-char12818.11))
          (vector3.18 (call fun/vector12820.14))
          (vector4.17 (call fun/vector12822.13))
          (empty5.16 (call fun/empty12824.4)))
      (call vector-ref vector4.17 1))))
(check-by-interp
 '(module
    (define fun/empty13316.4 (lambda () (call fun/empty13317.11)))
    (define fun/ascii-char13315.5 (lambda () #\d))
    (define fun/error13313.6 (lambda () (error 61)))
    (define fun/error13308.7 (lambda () (call fun/error13309.12)))
    (define fun/error13312.8 (lambda () (call fun/error13313.6)))
    (define fun/pair13319.9 (lambda () (call cons 243 439)))
    (define fun/void13310.10 (lambda () (call fun/void13311.14)))
    (define fun/empty13317.11 (lambda () empty))
    (define fun/error13309.12 (lambda () (error 248)))
    (define fun/ascii-char13314.13 (lambda () (call fun/ascii-char13315.5)))
    (define fun/void13311.14 (lambda () (void)))
    (define fun/pair13318.15 (lambda () (call fun/pair13319.9)))
    (let ((error0.21 (call fun/error13308.7))
          (void1.20 (call fun/void13310.10))
          (error2.19 (call fun/error13312.8))
          (fixnum3.18
           (call
            -
            (call
             -
             (call + (call + 109 250) (call * 227 148))
             (call * (call - 215 130) (call * 223 30)))
            (call
             *
             (call - (call * 247 1) (call * 63 60))
             (call + (call * 208 208) (call - 184 128)))))
          (ascii-char4.17 (call fun/ascii-char13314.13))
          (empty5.16 (call fun/empty13316.4)))
      (call fun/pair13318.15))))
(check-by-interp
 '(module
    (define fun/error13358.4 (lambda () (call fun/error13359.10)))
    (define fun/vector13357.5 (lambda () (call make-vector 8)))
    (define fun/vector13355.6 (lambda () (call make-vector 8)))
    (define fun/ascii-char13352.7 (lambda () (call fun/ascii-char13353.11)))
    (define fun/vector13354.8 (lambda () (call fun/vector13355.6)))
    (define fun/vector13356.9 (lambda () (call fun/vector13357.5)))
    (define fun/error13359.10 (lambda () (error 4)))
    (define fun/ascii-char13353.11 (lambda () #\H))
    (let ((fixnum0.17
           (call
            *
            (call
             +
             (call + (call * 61 201) (call * 11 18))
             (call + (call - 92 27) (call + 99 227)))
            (call
             +
             (call * (call - 78 219) (call + 231 79))
             (call + (call - 40 93) (call * 114 8)))))
          (ascii-char1.16 (call fun/ascii-char13352.7))
          (procedure2.15 (lambda () (call fun/vector13354.8)))
          (fixnum3.14
           (call
            -
            (call
             *
             (call - (call - 184 187) (call - 249 83))
             (call - (call * 248 208) (call + 199 131)))
            (call
             -
             (call * (call * 16 237) (call * 184 137))
             (call * (call - 76 191) (call - 185 90)))))
          (vector4.13 (call fun/vector13356.9))
          (error5.12 (call fun/error13358.4)))
      (call procedure2.15))))
(check-by-interp
 '(module
    (define fun/void14593.4 (lambda () (void)))
    (define fun/void14591.5 (lambda () (void)))
    (define fun/void14590.6 (lambda () (call fun/void14591.5)))
    (define fun/ascii-char14586.7 (lambda () (call fun/ascii-char14587.10)))
    (define fun/void14588.8 (lambda () (call fun/void14589.12)))
    (define fun/void14592.9 (lambda () (call fun/void14593.4)))
    (define fun/ascii-char14587.10 (lambda () #\T))
    (define fun/empty14585.11 (lambda () empty))
    (define fun/void14589.12 (lambda () (void)))
    (define fun/empty14584.13 (lambda () (call fun/empty14585.11)))
    (let ((empty0.19 (call fun/empty14584.13))
          (ascii-char1.18 (call fun/ascii-char14586.7))
          (void2.17 (call fun/void14588.8))
          (fixnum3.16
           (call
            +
            (call
             +
             (call - (call - 194 113) (call - 185 241))
             (call * (call + 162 91) (call - 164 197)))
            (call
             +
             (call * (call - 249 224) (call - 250 187))
             (call * (call * 214 94) (call * 206 191)))))
          (void4.15 (call fun/void14590.6))
          (fixnum5.14
           (call
            +
            (call
             -
             (call + (call - 148 37) (call * 110 11))
             (call * (call * 5 77) (call - 53 223)))
            (call
             +
             (call - (call * 64 86) (call - 202 121))
             (call * (call * 76 26) (call * 37 229))))))
      (call fun/void14592.9))))
(check-by-interp
 '(module
    (define fun/empty15140.4 (lambda () empty))
    (define fun/void15145.5 (lambda () (call fun/void15146.12)))
    (define fun/vector15138.6 (lambda () (call make-vector 8)))
    (define fun/ascii-char15135.7 (lambda () (call fun/ascii-char15136.15)))
    (define fun/void15142.8 (lambda () (void)))
    (define fun/any15144.9 (lambda () (call cons 90 455)))
    (define fun/any15143.10 (lambda () (call fun/any15144.9)))
    (define fun/vector15137.11 (lambda () (call fun/vector15138.6)))
    (define fun/void15146.12 (lambda () (void)))
    (define fun/empty15139.13 (lambda () (call fun/empty15140.4)))
    (define fun/void15141.14 (lambda () (call fun/void15142.8)))
    (define fun/ascii-char15136.15 (lambda () #\N))
    (let ((ascii-char0.21 (call fun/ascii-char15135.7))
          (vector1.20 (call fun/vector15137.11))
          (empty2.19 (call fun/empty15139.13))
          (fixnum3.18
           (call
            +
            (call
             -
             (call + (call - 172 24) (call - 248 201))
             (call + (call + 37 230) (call - 61 215)))
            (call
             -
             (call + (call * 171 97) (call - 108 8))
             (call - (call - 49 73) (call + 180 234)))))
          (void4.17 (call fun/void15141.14))
          (boolean5.16 (call empty? (call fun/any15143.10))))
      (call fun/void15145.5))))
(check-by-interp
 '(module
    (define fun/vector15770.4 (lambda () (call fun/vector15771.9)))
    (define fun/empty15765.5 (lambda () empty))
    (define fun/void15774.6 (lambda () (call fun/void15775.15)))
    (define fun/error15773.7 (lambda () (error 17)))
    (define fun/error15772.8 (lambda () (call fun/error15773.7)))
    (define fun/vector15771.9 (lambda () (call make-vector 8)))
    (define fun/ascii-char15769.10 (lambda () #\_))
    (define fun/empty15767.11 (lambda () empty))
    (define fun/ascii-char15776.12 (lambda () (call fun/ascii-char15777.16)))
    (define fun/empty15766.13 (lambda () (call fun/empty15767.11)))
    (define fun/empty15764.14 (lambda () (call fun/empty15765.5)))
    (define fun/void15775.15 (lambda () (void)))
    (define fun/ascii-char15777.16 (lambda () #\L))
    (define fun/ascii-char15768.17 (lambda () (call fun/ascii-char15769.10)))
    (let ((procedure0.23 (lambda () (call fun/empty15764.14)))
          (empty1.22 (call fun/empty15766.13))
          (ascii-char2.21 (call fun/ascii-char15768.17))
          (vector3.20 (call fun/vector15770.4))
          (error4.19 (call fun/error15772.8))
          (void5.18 (call fun/void15774.6)))
      (call fun/ascii-char15776.12))))
(check-by-interp
 '(module
    (define fun/void21848.4 (lambda () (void)))
    (define fun/ascii-char21854.5 (lambda () #\h))
    (define fun/vector21856.6 (lambda () (call make-vector 8)))
    (define fun/pair21851.7 (lambda () (call fun/pair21852.12)))
    (define fun/vector21849.8 (lambda () (call fun/vector21850.9)))
    (define fun/vector21850.9 (lambda () (call make-vector 8)))
    (define fun/error21846.10 (lambda () (error 231)))
    (define fun/vector21855.11 (lambda () (call fun/vector21856.6)))
    (define fun/pair21852.12 (lambda () (call cons 78 279)))
    (define fun/error21845.13 (lambda () (call fun/error21846.10)))
    (define fun/ascii-char21853.14 (lambda () (call fun/ascii-char21854.5)))
    (define fun/void21847.15 (lambda () (call fun/void21848.4)))
    (let ((error0.21 (call fun/error21845.13))
          (void1.20 (call fun/void21847.15))
          (vector2.19 (call fun/vector21849.8))
          (procedure3.18 (lambda () (call fun/pair21851.7)))
          (ascii-char4.17 (call fun/ascii-char21853.14))
          (fixnum5.16
           (call
            *
            (call
             *
             (call * (call - 82 66) (call - 146 83))
             (call + (call + 80 86) (call - 83 43)))
            (call
             *
             (call - (call * 176 39) (call - 237 12))
             (call - (call * 137 222) (call - 128 107))))))
      (call fun/vector21855.11))))
(check-by-interp
 '(module
    (define fun/empty10026.4 (lambda () (call fun/empty10027.11)))
    (define fun/void10033.5 (lambda () (void)))
    (define fun/vector10030.6 (lambda () (call fun/vector10031.9)))
    (define fun/empty10023.7 (lambda () empty))
    (define fun/void10029.8 (lambda () (void)))
    (define fun/vector10031.9 (lambda () (call make-vector 8)))
    (define fun/void10028.10 (lambda () (call fun/void10029.8)))
    (define fun/empty10027.11 (lambda () empty))
    (define fun/vector10025.12 (lambda () (call make-vector 8)))
    (define fun/empty10022.13 (lambda () (call fun/empty10023.7)))
    (define fun/vector10024.14 (lambda () (call fun/vector10025.12)))
    (define fun/void10032.15 (lambda () (call fun/void10033.5)))
    (let ((empty0.21 (call fun/empty10022.13))
          (procedure1.20 (lambda () (call fun/vector10024.14)))
          (empty2.19 (call fun/empty10026.4))
          (void3.18 (call fun/void10028.10))
          (vector4.17 (call fun/vector10030.6))
          (void5.16 (call fun/void10032.15)))
      (call procedure1.20))))
(check-by-interp
 '(module
    (define fun/any12092.4 (lambda () (call fun/any12093.9)))
    (define fun/empty12090.5 (lambda () (call fun/empty12091.8)))
    (define fun/error12095.6 (lambda () (error 45)))
    (define fun/empty12096.7 (lambda () (call fun/empty12097.12)))
    (define fun/empty12091.8 (lambda () empty))
    (define fun/any12093.9 (lambda () (void)))
    (define fun/void12099.10 (lambda () (void)))
    (define fun/error12088.11 (lambda () (call fun/error12089.13)))
    (define fun/empty12097.12 (lambda () empty))
    (define fun/error12089.13 (lambda () (error 114)))
    (define fun/error12094.14 (lambda () (call fun/error12095.6)))
    (define fun/void12098.15 (lambda () (call fun/void12099.10)))
    (let ((procedure0.21 (lambda () (call fun/error12088.11)))
          (fixnum1.20
           (call
            -
            (call
             *
             (call - (call - 54 166) (call + 146 119))
             (call - (call - 184 21) (call * 8 253)))
            (call
             -
             (call + (call - 209 95) (call + 30 246))
             (call * (call + 68 87) (call - 191 238)))))
          (empty2.19 (call fun/empty12090.5))
          (boolean3.18 (call fixnum? (call fun/any12092.4)))
          (error4.17 (call fun/error12094.14))
          (empty5.16 (call fun/empty12096.7)))
      (call fun/void12098.15))))
