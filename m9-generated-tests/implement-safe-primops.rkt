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
(check-by-interp
 '(module
    (define fun/void8617.4 (lambda () (void)))
    (define fun/void8621.5 (lambda () (void)))
    (define fun/ascii-char8619.6 (lambda () #\g))
    (define fun/any8618.7 (lambda () #\M))
    (define fun/void8620.8 (lambda () (void)))
    (let ((void0.12 (call fun/void8617.4))
          (boolean1.11 (call pair? (call fun/any8618.7)))
          (ascii-char2.10 (call fun/ascii-char8619.6))
          (void3.9 (call fun/void8620.8)))
      (call fun/void8621.5))))
(check-by-interp
 '(module
    (define fun/vector9289.4 (lambda () (call fun/vector9290.6)))
    (define fun/error9287.5 (lambda () (call fun/error9288.7)))
    (define fun/vector9290.6 (lambda () (call make-vector 8)))
    (define fun/error9288.7 (lambda () (error 238)))
    (define fun/vector9292.8 (lambda () (call make-vector 8)))
    (define fun/empty9296.9 (lambda () empty))
    (define fun/empty9295.10 (lambda () (call fun/empty9296.9)))
    (define fun/vector9291.11 (lambda () (call fun/vector9292.8)))
    (define fun/ascii-char9294.12 (lambda () #\V))
    (define fun/ascii-char9293.13 (lambda () (call fun/ascii-char9294.12)))
    (let ((error0.18 (call fun/error9287.5))
          (fixnum1.17
           (call
            *
            (call + (call - 10 182) (call * 226 247))
            (call * (call + 35 137) (call + 166 53))))
          (vector2.16 (call fun/vector9289.4))
          (vector3.15 (call fun/vector9291.11))
          (ascii-char4.14 (call fun/ascii-char9293.13)))
      (call fun/empty9295.10))))
(check-by-interp
 '(module
    (define fun/void9337.4 (lambda () (call fun/void9338.11)))
    (define fun/any9339.5 (lambda () 1))
    (define fun/ascii-char9340.6 (lambda () (call fun/ascii-char9341.9)))
    (define fun/void9345.7 (lambda () (void)))
    (define fun/empty9342.8 (lambda () (call fun/empty9343.14)))
    (define fun/ascii-char9341.9 (lambda () #\X))
    (define fun/void9344.10 (lambda () (call fun/void9345.7)))
    (define fun/void9338.11 (lambda () (void)))
    (define fun/ascii-char9347.12 (lambda () #\g))
    (define fun/ascii-char9346.13 (lambda () (call fun/ascii-char9347.12)))
    (define fun/empty9343.14 (lambda () empty))
    (let ((void0.19 (call fun/void9337.4))
          (boolean1.18 (call vector? (call fun/any9339.5)))
          (ascii-char2.17 (call fun/ascii-char9340.6))
          (empty3.16 (call fun/empty9342.8))
          (void4.15 (call fun/void9344.10)))
      (call fun/ascii-char9346.13))))
(check-by-interp
 '(module
    (define fun/void9614.4 (lambda () (call fun/void9615.7)))
    (define fun/void9618.5 (lambda () (call fun/void9619.6)))
    (define fun/void9619.6 (lambda () (void)))
    (define fun/void9615.7 (lambda () (void)))
    (define fun/any9611.8 (lambda () (void)))
    (define fun/ascii-char9616.9 (lambda () (call fun/ascii-char9617.10)))
    (define fun/ascii-char9617.10 (lambda () #\\))
    (define fun/vector9612.11 (lambda () (call fun/vector9613.12)))
    (define fun/vector9613.12 (lambda () (call make-vector 8)))
    (let ((boolean0.17 (call fixnum? (call fun/any9611.8)))
          (vector1.16 (call fun/vector9612.11))
          (void2.15 (call fun/void9614.4))
          (ascii-char3.14 (call fun/ascii-char9616.9))
          (void4.13 (call fun/void9618.5)))
      (call vector-ref vector1.16 4))))
(check-by-interp
 '(module
    (define fun/empty10247.4 (lambda () empty))
    (define fun/vector10251.5 (lambda () (call make-vector 8)))
    (define fun/vector10250.6 (lambda () (call fun/vector10251.5)))
    (define fun/empty10246.7 (lambda () (call fun/empty10247.4)))
    (define fun/empty10248.8 (lambda () (call fun/empty10249.10)))
    (define fun/error10245.9 (lambda () (error 53)))
    (define fun/empty10249.10 (lambda () empty))
    (define fun/error10244.11 (lambda () (call fun/error10245.9)))
    (define fun/any10242.12 (lambda () (error 110)))
    (define fun/any10243.13 (lambda () #t))
    (let ((boolean0.18 (call void? (call fun/any10242.12)))
          (procedure1.17 (lambda () (call vector? (call fun/any10243.13))))
          (error2.16 (call fun/error10244.11))
          (empty3.15 (call fun/empty10246.7))
          (empty4.14 (call fun/empty10248.8)))
      (call fun/vector10250.6))))
(check-by-interp
 '(module
    (define fun/void10770.4 (lambda () (call fun/void10771.10)))
    (define fun/void10777.5 (lambda () (void)))
    (define fun/void10776.6 (lambda () (call fun/void10777.5)))
    (define fun/void10772.7 (lambda () (call fun/void10773.9)))
    (define fun/void10775.8 (lambda () (void)))
    (define fun/void10773.9 (lambda () (void)))
    (define fun/void10771.10 (lambda () (void)))
    (define fun/void10774.11 (lambda () (call fun/void10775.8)))
    (define fun/ascii-char10778.12 (lambda () (call fun/ascii-char10779.13)))
    (define fun/ascii-char10779.13 (lambda () #\c))
    (define fun/vector10781.14 (lambda () (call make-vector 8)))
    (define fun/vector10780.15 (lambda () (call fun/vector10781.14)))
    (let ((void0.20 (call fun/void10770.4))
          (void1.19 (call fun/void10772.7))
          (void2.18 (call fun/void10774.11))
          (void3.17 (call fun/void10776.6))
          (ascii-char4.16 (call fun/ascii-char10778.12)))
      (call fun/vector10780.15))))
(check-by-interp
 '(module
    (define fun/void11006.4 (lambda () (call fun/void11007.6)))
    (define fun/void11010.5 (lambda () (call fun/void11011.8)))
    (define fun/void11007.6 (lambda () (void)))
    (define fun/empty11017.7 (lambda () empty))
    (define fun/void11011.8 (lambda () (void)))
    (define fun/empty11016.9 (lambda () (call fun/empty11017.7)))
    (define fun/error11009.10 (lambda () (error 242)))
    (define fun/void11014.11 (lambda () (call fun/void11015.13)))
    (define fun/error11008.12 (lambda () (call fun/error11009.10)))
    (define fun/void11015.13 (lambda () (void)))
    (define fun/ascii-char11013.14 (lambda () #\k))
    (define fun/ascii-char11012.15 (lambda () (call fun/ascii-char11013.14)))
    (let ((fixnum0.21
           (call
            +
            (call
             -
             (call - (call - 169 4) (call + 213 92))
             (call - (call * 180 13) (call * 208 214)))
            (call
             +
             (call - (call * 0 191) (call + 206 116))
             (call * (call - 199 135) (call - 16 95)))))
          (void1.20 (call fun/void11006.4))
          (procedure2.19 (lambda () (call fun/error11008.12)))
          (void3.18 (call fun/void11010.5))
          (ascii-char4.17 (call fun/ascii-char11012.15))
          (void5.16 (call fun/void11014.11)))
      (call fun/empty11016.9))))
(check-by-interp
 '(module
    (define fun/error11878.4 (lambda () (error 64)))
    (define fun/error11879.5 (lambda () (call fun/error11880.7)))
    (define fun/ascii-char11876.6 (lambda () #\m))
    (define fun/error11880.7 (lambda () (error 168)))
    (define fun/ascii-char11873.8 (lambda () (call fun/ascii-char11874.9)))
    (define fun/ascii-char11874.9 (lambda () #\r))
    (define fun/error11877.10 (lambda () (call fun/error11878.4)))
    (define fun/void11872.11 (lambda () (void)))
    (define fun/void11871.12 (lambda () (call fun/void11872.11)))
    (define fun/ascii-char11875.13 (lambda () (call fun/ascii-char11876.6)))
    (let ((procedure0.19
           (lambda ()
             (call
              *
              (call
               +
               (call * (call - 150 41) (call - 173 100))
               (call + (call + 213 92) (call + 41 60)))
              (call
               *
               (call + (call + 2 4) (call + 78 239))
               (call - (call * 228 169) (call + 198 43))))))
          (void1.18 (call fun/void11871.12))
          (ascii-char2.17 (call fun/ascii-char11873.8))
          (ascii-char3.16 (call fun/ascii-char11875.13))
          (error4.15 (call fun/error11877.10))
          (error5.14 (call fun/error11879.5)))
      (call
       *
       (call
        -
        (call + (call - 71 30) (call procedure0.19))
        (call procedure0.19))
       (call procedure0.19)))))
(check-by-interp
 '(module
    (define fun/ascii-char12698.4 (lambda () (call fun/ascii-char12699.5)))
    (define fun/ascii-char12699.5 (lambda () #\[))
    (define fun/any12703.6 (lambda () (call cons 139 388)))
    (define fun/empty12692.7 (lambda () (call fun/empty12693.13)))
    (define fun/error12696.8 (lambda () (call fun/error12697.10)))
    (define fun/void12701.9 (lambda () (void)))
    (define fun/error12697.10 (lambda () (error 95)))
    (define fun/any12702.11 (lambda () (call fun/any12703.6)))
    (define fun/void12700.12 (lambda () (call fun/void12701.9)))
    (define fun/empty12693.13 (lambda () empty))
    (define fun/ascii-char12705.14 (lambda () #\]))
    (define fun/empty12695.15 (lambda () empty))
    (define fun/ascii-char12704.16 (lambda () (call fun/ascii-char12705.14)))
    (define fun/empty12694.17 (lambda () (call fun/empty12695.15)))
    (let ((empty0.23 (call fun/empty12692.7))
          (empty1.22 (call fun/empty12694.17))
          (error2.21 (call fun/error12696.8))
          (ascii-char3.20 (call fun/ascii-char12698.4))
          (void4.19 (call fun/void12700.12))
          (boolean5.18 (call empty? (call fun/any12702.11))))
      (call fun/ascii-char12704.16))))
(check-by-interp
 '(module
    (define fun/ascii-char12715.4 (lambda () #\i))
    (define fun/ascii-char12714.5 (lambda () (call fun/ascii-char12715.4)))
    (define fun/ascii-char12713.6 (lambda () #\E))
    (define fun/ascii-char12710.7 (lambda () (call fun/ascii-char12711.14)))
    (define fun/error12717.8 (lambda () (error 129)))
    (define fun/error12716.9 (lambda () (call fun/error12717.8)))
    (define fun/error12709.10 (lambda () (error 67)))
    (define fun/ascii-char12719.11 (lambda () #\[))
    (define fun/ascii-char12718.12 (lambda () (call fun/ascii-char12719.11)))
    (define fun/ascii-char12712.13 (lambda () (call fun/ascii-char12713.6)))
    (define fun/ascii-char12711.14 (lambda () #\u))
    (define fun/error12708.15 (lambda () (call fun/error12709.10)))
    (let ((error0.21 (call fun/error12708.15))
          (procedure1.20
           (lambda ()
             (call
              -
              (call
               +
               (call * (call - 170 108) (call * 124 91))
               (call - (call + 196 124) (call - 29 207)))
              (call
               *
               (call + (call - 74 25) (call * 40 225))
               (call - (call + 92 174) (call * 221 197))))))
          (ascii-char2.19 (call fun/ascii-char12710.7))
          (ascii-char3.18 (call fun/ascii-char12712.13))
          (ascii-char4.17 (call fun/ascii-char12714.5))
          (error5.16 (call fun/error12716.9)))
      (call fun/ascii-char12718.12))))
(check-by-interp
 '(module
    (define fun/ascii-char14511.4 (lambda () #\E))
    (define fun/ascii-char14516.5 (lambda () (call fun/ascii-char14517.9)))
    (define fun/error14514.6 (lambda () (call fun/error14515.7)))
    (define fun/error14515.7 (lambda () (error 218)))
    (define fun/ascii-char14510.8 (lambda () (call fun/ascii-char14511.4)))
    (define fun/ascii-char14517.9 (lambda () #\c))
    (define fun/error14508.10 (lambda () (call fun/error14509.11)))
    (define fun/error14509.11 (lambda () (error 191)))
    (define fun/error14512.12 (lambda () (call fun/error14513.13)))
    (define fun/error14513.13 (lambda () (error 19)))
    (let ((error0.19 (call fun/error14508.10))
          (fixnum1.18
           (call
            +
            (call
             +
             (call + (call * 245 103) (call - 14 91))
             (call * (call * 122 65) (call * 59 49)))
            (call
             -
             (call * (call + 170 243) (call + 227 62))
             (call - (call * 165 152) (call * 34 234)))))
          (fixnum2.17
           (call
            -
            (call
             -
             (call * (call - 28 218) (call + 219 163))
             (call * (call - 33 43) (call * 234 231)))
            (call
             +
             (call - (call - 62 212) (call - 164 217))
             (call - (call * 209 38) (call - 224 233)))))
          (ascii-char3.16 (call fun/ascii-char14510.8))
          (error4.15 (call fun/error14512.12))
          (error5.14 (call fun/error14514.6)))
      (call fun/ascii-char14516.5))))
(check-by-interp
 '(module
    (define fun/error14883.4 (lambda () (error 146)))
    (define fun/error14880.5 (lambda () (call fun/error14881.8)))
    (define fun/empty14886.6 (lambda () (call fun/empty14887.10)))
    (define fun/error14882.7 (lambda () (call fun/error14883.4)))
    (define fun/error14881.8 (lambda () (error 44)))
    (define fun/error14879.9 (lambda () (error 114)))
    (define fun/empty14887.10 (lambda () empty))
    (define fun/ascii-char14884.11 (lambda () (call fun/ascii-char14885.12)))
    (define fun/ascii-char14885.12 (lambda () #\b))
    (define fun/empty14876.13 (lambda () (call fun/empty14877.15)))
    (define fun/error14878.14 (lambda () (call fun/error14879.9)))
    (define fun/empty14877.15 (lambda () empty))
    (let ((empty0.21 (call fun/empty14876.13))
          (error1.20 (call fun/error14878.14))
          (error2.19 (call fun/error14880.5))
          (procedure3.18 (lambda () (call fun/error14882.7)))
          (ascii-char4.17 (call fun/ascii-char14884.11))
          (empty5.16 (call fun/empty14886.6)))
      (call procedure3.18))))
(check-by-interp
 '(module
    (define fun/empty15196.4 (lambda () (call fun/empty15197.10)))
    (define fun/empty15206.5 (lambda () (call fun/empty15207.7)))
    (define fun/ascii-char15202.6 (lambda () (call fun/ascii-char15203.9)))
    (define fun/empty15207.7 (lambda () empty))
    (define fun/vector15208.8 (lambda () (call fun/vector15209.11)))
    (define fun/ascii-char15203.9 (lambda () #\r))
    (define fun/empty15197.10 (lambda () empty))
    (define fun/vector15209.11 (lambda () (call make-vector 8)))
    (define fun/empty15204.12 (lambda () (call fun/empty15205.17)))
    (define fun/error15200.13 (lambda () (call fun/error15201.15)))
    (define fun/any15199.14 (lambda () (void)))
    (define fun/error15201.15 (lambda () (error 204)))
    (define fun/any15198.16 (lambda () (call fun/any15199.14)))
    (define fun/empty15205.17 (lambda () empty))
    (let ((procedure0.23 (lambda () (call fun/empty15196.4)))
          (procedure1.22 (lambda () (call ascii-char? (call fun/any15198.16))))
          (error2.21 (call fun/error15200.13))
          (ascii-char3.20 (call fun/ascii-char15202.6))
          (empty4.19 (call fun/empty15204.12))
          (empty5.18 (call fun/empty15206.5)))
      (call fun/vector15208.8))))
(check-by-interp
 '(module
    (define fun/vector17408.4 (lambda () (call fun/vector17409.9)))
    (define fun/vector17418.5 (lambda () (call fun/vector17419.7)))
    (define fun/ascii-char17415.6 (lambda () #\e))
    (define fun/vector17419.7 (lambda () (call make-vector 8)))
    (define fun/error17410.8 (lambda () (call fun/error17411.15)))
    (define fun/vector17409.9 (lambda () (call make-vector 8)))
    (define fun/void17416.10 (lambda () (call fun/void17417.17)))
    (define fun/error17413.11 (lambda () (error 54)))
    (define fun/ascii-char17414.12 (lambda () (call fun/ascii-char17415.6)))
    (define fun/error17412.13 (lambda () (call fun/error17413.11)))
    (define fun/error17407.14 (lambda () (error 211)))
    (define fun/error17411.15 (lambda () (error 42)))
    (define fun/error17406.16 (lambda () (call fun/error17407.14)))
    (define fun/void17417.17 (lambda () (void)))
    (let ((error0.23 (call fun/error17406.16))
          (vector1.22 (call fun/vector17408.4))
          (error2.21 (call fun/error17410.8))
          (error3.20 (call fun/error17412.13))
          (ascii-char4.19 (call fun/ascii-char17414.12))
          (void5.18 (call fun/void17416.10)))
      (call fun/vector17418.5))))
(check-by-interp
 '(module
    (define fun/void18574.4 (lambda () (void)))
    (define fun/vector18571.5 (lambda () (call fun/vector18572.14)))
    (define fun/ascii-char18578.6 (lambda () #\Q))
    (define fun/void18573.7 (lambda () (call fun/void18574.4)))
    (define fun/error18580.8 (lambda () (error 208)))
    (define fun/error18579.9 (lambda () (call fun/error18580.8)))
    (define fun/vector18576.10 (lambda () (call make-vector 8)))
    (define fun/vector18575.11 (lambda () (call fun/vector18576.10)))
    (define fun/any18581.12 (lambda () (call fun/any18582.15)))
    (define fun/ascii-char18577.13 (lambda () (call fun/ascii-char18578.6)))
    (define fun/vector18572.14 (lambda () (call make-vector 8)))
    (define fun/any18582.15 (lambda () (call cons 219 440)))
    (let ((procedure0.21 (lambda () (call fun/vector18571.5)))
          (void1.20 (call fun/void18573.7))
          (vector2.19 (call fun/vector18575.11))
          (procedure3.18 (lambda () (call fun/ascii-char18577.13)))
          (error4.17 (call fun/error18579.9))
          (boolean5.16 (call pair? (call fun/any18581.12))))
      (call vector-ref vector2.19 6))))
(check-by-interp
 '(module
    (define fun/empty18594.4 (lambda () empty))
    (define fun/error18587.5 (lambda () (call fun/error18588.6)))
    (define fun/error18588.6 (lambda () (error 113)))
    (define fun/empty18593.7 (lambda () (call fun/empty18594.4)))
    (define fun/vector18596.8 (lambda () (call make-vector 8)))
    (define fun/vector18595.9 (lambda () (call fun/vector18596.8)))
    (define fun/empty18590.10 (lambda () empty))
    (define fun/error18586.11 (lambda () (error 31)))
    (define fun/error18585.12 (lambda () (call fun/error18586.11)))
    (define fun/empty18589.13 (lambda () (call fun/empty18590.10)))
    (define fun/ascii-char18592.14 (lambda () #\g))
    (define fun/ascii-char18591.15 (lambda () (call fun/ascii-char18592.14)))
    (let ((error0.21 (call fun/error18585.12))
          (error1.20 (call fun/error18587.5))
          (procedure2.19 (lambda () (call fun/empty18589.13)))
          (fixnum3.18
           (call
            *
            (call
             -
             (call + (call - 129 28) (call - 120 104))
             (call - (call * 177 151) (call + 2 114)))
            (call
             +
             (call - (call - 158 176) (call - 38 134))
             (call + (call + 119 101) (call + 52 154)))))
          (ascii-char4.17 (call fun/ascii-char18591.15))
          (empty5.16 (call fun/empty18593.7)))
      (call fun/vector18595.9))))
(check-by-interp
 '(module
    (define fun/empty19106.4 (lambda () empty))
    (define fun/vector19107.5 (lambda () (call fun/vector19108.15)))
    (define fun/void19116.6 (lambda () (void)))
    (define fun/empty19105.7 (lambda () (call fun/empty19106.4)))
    (define fun/void19115.8 (lambda () (call fun/void19116.6)))
    (define fun/ascii-char19110.9 (lambda () #\Z))
    (define fun/ascii-char19111.10 (lambda () (call fun/ascii-char19112.14)))
    (define fun/error19113.11 (lambda () (call fun/error19114.12)))
    (define fun/error19114.12 (lambda () (error 9)))
    (define fun/ascii-char19109.13 (lambda () (call fun/ascii-char19110.9)))
    (define fun/ascii-char19112.14 (lambda () #\p))
    (define fun/vector19108.15 (lambda () (call make-vector 8)))
    (let ((empty0.21 (call fun/empty19105.7))
          (fixnum1.20
           (call
            *
            (call
             +
             (call - (call - 1 111) (call - 118 140))
             (call * (call - 158 77) (call + 222 154)))
            (call
             +
             (call - (call + 64 198) (call * 197 213))
             (call * (call * 206 230) (call + 117 189)))))
          (procedure2.19 (lambda () (call fun/vector19107.5)))
          (ascii-char3.18 (call fun/ascii-char19109.13))
          (ascii-char4.17 (call fun/ascii-char19111.10))
          (error5.16 (call fun/error19113.11)))
      (call fun/void19115.8))))
(check-by-interp
 '(module
    (define fun/any20282.4 (lambda () (call fun/any20283.6)))
    (define fun/void20271.5 (lambda () (void)))
    (define fun/any20283.6 (lambda () (error 163)))
    (define fun/void20270.7 (lambda () (call fun/void20271.5)))
    (define fun/empty20278.8 (lambda () (call fun/empty20279.11)))
    (define fun/empty20273.9 (lambda () empty))
    (define fun/void20280.10 (lambda () (call fun/void20281.17)))
    (define fun/empty20279.11 (lambda () empty))
    (define fun/error20277.12 (lambda () (error 110)))
    (define fun/error20276.13 (lambda () (call fun/error20277.12)))
    (define fun/ascii-char20275.14 (lambda () #\Z))
    (define fun/empty20272.15 (lambda () (call fun/empty20273.9)))
    (define fun/ascii-char20274.16 (lambda () (call fun/ascii-char20275.14)))
    (define fun/void20281.17 (lambda () (void)))
    (let ((procedure0.23 (lambda () (call fun/void20270.7)))
          (empty1.22 (call fun/empty20272.15))
          (ascii-char2.21 (call fun/ascii-char20274.16))
          (error3.20 (call fun/error20276.13))
          (empty4.19 (call fun/empty20278.8))
          (void5.18 (call fun/void20280.10)))
      (call pair? (call fun/any20282.4)))))
(check-by-interp
 '(module
    (define fun/empty21163.4 (lambda () empty))
    (define fun/any21161.5 (lambda () 186))
    (define fun/any21165.6 (lambda () (call make-vector 8)))
    (define fun/any21164.7 (lambda () (call fun/any21165.6)))
    (define fun/empty21162.8 (lambda () (call fun/empty21163.4)))
    (define fun/void21166.9 (lambda () (call fun/void21167.12)))
    (define fun/error21156.10 (lambda () (call fun/error21157.14)))
    (define fun/vector21159.11 (lambda () (call make-vector 8)))
    (define fun/void21167.12 (lambda () (void)))
    (define fun/vector21158.13 (lambda () (call fun/vector21159.11)))
    (define fun/error21157.14 (lambda () (error 103)))
    (define fun/any21160.15 (lambda () (call fun/any21161.5)))
    (let ((error0.21 (call fun/error21156.10))
          (vector1.20 (call fun/vector21158.13))
          (boolean2.19 (call empty? (call fun/any21160.15)))
          (fixnum3.18
           (call
            *
            (call
             +
             (call * (call - 26 52) (call - 136 64))
             (call * (call - 37 135) (call * 21 177)))
            (call
             +
             (call - (call - 56 11) (call * 177 202))
             (call + (call - 123 25) (call - 222 131)))))
          (empty4.17 (call fun/empty21162.8))
          (boolean5.16 (call vector? (call fun/any21164.7))))
      (call fun/void21166.9))))
(check-by-interp
 '(module
    (define fun/any23222.4 (lambda () (call cons 40 437)))
    (define fun/error23218.5 (lambda () (error 182)))
    (define fun/void23223.6 (lambda () (call fun/void23224.7)))
    (define fun/void23224.7 (lambda () (void)))
    (define fun/void23220.8 (lambda () (void)))
    (define fun/any23221.9 (lambda () (call fun/any23222.4)))
    (define fun/void23219.10 (lambda () (call fun/void23220.8)))
    (define fun/any23216.11 (lambda () (call cons 102 340)))
    (define fun/ascii-char23225.12 (lambda () (call fun/ascii-char23226.14)))
    (define fun/error23217.13 (lambda () (call fun/error23218.5)))
    (define fun/ascii-char23226.14 (lambda () #\Y))
    (define fun/any23215.15 (lambda () (call fun/any23216.11)))
    (let ((boolean0.21 (call pair? (call fun/any23215.15)))
          (error1.20 (call fun/error23217.13))
          (void2.19 (call fun/void23219.10))
          (boolean3.18 (call boolean? (call fun/any23221.9)))
          (fixnum4.17
           (call
            *
            (call
             *
             (call * (call + 215 43) (call * 163 91))
             (call + (call + 43 216) (call + 12 113)))
            (call
             -
             (call - (call * 184 4) (call + 164 45))
             (call - (call + 162 116) (call - 205 220)))))
          (void5.16 (call fun/void23223.6)))
      (call fun/ascii-char23225.12))))
(check-by-interp
 '(module
    (define fun/empty24035.4 (lambda () empty))
    (define fun/empty24029.5 (lambda () empty))
    (define fun/empty24028.6 (lambda () (call fun/empty24029.5)))
    (define fun/pair24037.7 (lambda () (call cons 50 301)))
    (define fun/any24031.8 (lambda () #f))
    (define fun/any24030.9 (lambda () (call fun/any24031.8)))
    (define fun/any24033.10 (lambda () #\X))
    (define fun/pair24036.11 (lambda () (call fun/pair24037.7)))
    (define fun/any24032.12 (lambda () (call fun/any24033.10)))
    (define fun/empty24034.13 (lambda () (call fun/empty24035.4)))
    (let ((empty0.19 (call fun/empty24028.6))
          (procedure1.18 (lambda () (call procedure? (call fun/any24030.9))))
          (fixnum2.17
           (call
            *
            (call
             +
             (call * (call - 139 114) (call * 226 88))
             (call + (call + 94 45) (call * 34 204)))
            (call
             -
             (call + (call - 40 48) (call + 67 44))
             (call * (call - 121 46) (call + 5 152)))))
          (fixnum3.16
           (call
            *
            (call
             -
             (call + (call * 250 42) (call + 40 186))
             (call - (call + 44 155) (call * 123 40)))
            (call
             *
             (call + (call - 203 106) (call * 38 6))
             (call * (call + 77 100) (call - 66 58)))))
          (boolean4.15 (call empty? (call fun/any24032.12)))
          (empty5.14 (call fun/empty24034.13)))
      (call fun/pair24036.11))))
