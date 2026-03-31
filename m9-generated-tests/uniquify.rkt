#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         "../uniquify.rkt")
(define (fail-if-invalid p)
  (when (not (exprs-unique-lang-v9? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "exprs-unique-lang-v9"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-exprs-lang-v9 p)
  (interp-exprs-unique-lang-v9 (fail-if-invalid (uniquify p)))))

(check-by-interp '(module 173))
(check-by-interp '(module 239))
(check-by-interp
 '(module (define fun/error8447 (lambda () (error 233))) (call fun/error8447)))
(check-by-interp
 '(module (define fun/fixnum8450 (lambda () 36)) (call fun/fixnum8450)))
(check-by-interp
 '(module
    (define fun/vector8453 (lambda () (call make-vector 8)))
    (call fun/vector8453)))
(check-by-interp
 '(module (define fun/error8456 (lambda () (error 240))) (call fun/error8456)))
(check-by-interp '(module (if #t (error 111) (error 246))))
(check-by-interp
 '(module
    (define fun/error8470 (lambda (oprand0) (call fun/error8471)))
    (define fun/error8471 (lambda () (error 217)))
    (call
     fun/error8470
     (let ((fixnum0 250) (vector1 (call make-vector 8))) 136))))
(check-by-interp
 '(module
    (define fun/ascii-char8474 (lambda (oprand0) #\V))
    (define fun/void8475 (lambda (oprand0) (void)))
    (call fun/ascii-char8474 (call fun/void8475 #t))))
(check-by-interp
 '(module
    (define fun/empty8478 (lambda (oprand0) empty))
    (call
     fun/empty8478
     (let ((error0 (error 53)) (error1 (error 196))) empty))))
(check-by-interp
 '(module
    (define fun/ascii-char8481 (lambda (oprand0) #\\))
    (call fun/ascii-char8481 (if #f empty empty))))
(check-by-interp
 '(module
    (define fun/pair8495 (lambda (oprand0 oprand1) (call fun/pair8496)))
    (define fun/pair8496 (lambda () (call cons 33 428)))
    (call
     fun/pair8495
     (call
      *
      (call * 120 100)
      (let ((ascii-char0 #\M) (boolean1 #t) (boolean2 #t)) 196))
     (call ascii-char? (if #t #\^ (void))))))
(check-by-interp
 '(module
    (define fun/pair8508 (lambda (oprand0 oprand1) (call fun/pair8509)))
    (define fun/pair8509 (lambda () (call cons 105 344)))
    (define fun/empty8511 (lambda (oprand0 oprand1) empty))
    (define fun/void8507 (lambda () (void)))
    (define fun/error8510 (lambda (oprand0 oprand1) (error 153)))
    (define fun/void8506 (lambda (oprand0 oprand1) (call fun/void8507)))
    (call
     fun/void8506
     (let ((ascii-char0 #\j) (vector1 (call make-vector 8)) (boolean2 #t))
       (error 147))
     (call
      fun/pair8508
      (call fun/error8510 (void) (void))
      (call fun/empty8511 (error 142) #\C)))))
(check-by-interp
 '(module
    (define fun/void8532
      (lambda (oprand0 oprand1) (call vector-set! oprand1 7 30)))
    (define fun/boolean8529 (lambda () #t))
    (define fun/ascii-char8530
      (lambda (oprand0 oprand1) (call fun/ascii-char8531)))
    (define fun/boolean8528 (lambda (oprand0 oprand1) (call fun/boolean8529)))
    (define fun/ascii-char8531 (lambda () #\V))
    (call
     fun/boolean8528
     (call
      fun/ascii-char8530
      (if #t empty empty)
      (call fun/void8532 #\t (call make-vector 8)))
     (if #t empty empty))))
(check-by-interp
 '(module
    (define fun/empty8535 (lambda () empty))
    (define fun/empty8537 (lambda () empty))
    (define fun/vector8536 (lambda () (call make-vector 8)))
    (let ((empty0 (call fun/empty8535))
          (boolean1 (call boolean? (call cons 80 414)))
          (vector2 (call fun/vector8536)))
      (call fun/empty8537))))
(check-by-interp
 '(module
    (define fun/pair8561 (lambda () (call cons 251 399)))
    (define fun/ascii-char8562
      (lambda (oprand0 oprand1) (call fun/ascii-char8563)))
    (define fun/pair8560 (lambda (oprand0 oprand1) (call fun/pair8561)))
    (define fun/ascii-char8563 (lambda () #\s))
    (define fun/empty8564 (lambda (oprand0 oprand1) empty))
    (call
     fun/pair8560
     (if #f 61 74)
     (call fun/ascii-char8562 (call fun/empty8564 empty #\r) (if #t #t #f)))))
(check-by-interp
 '(module
    (define fun/ascii-char8613 (lambda () #\B))
    (define fun/vector8612 (lambda () (call make-vector 8)))
    (define fun/ascii-char8614 (lambda () #\S))
    (define fun/void8611 (lambda () (void)))
    (let ((fixnum0 (call + (call * 77 201) (call - 53 40)))
          (void1 (call fun/void8611))
          (vector2 (call fun/vector8612))
          (ascii-char3 (call fun/ascii-char8613)))
      (call fun/ascii-char8614))))
(check-by-interp
 '(module
    (define fun/ascii-char8617 (lambda () #\X))
    (define fun/vector8619 (lambda () (call make-vector 8)))
    (define fun/void8618 (lambda () (void)))
    (let ((fixnum0 (call * (call + 178 122) (call + 57 87)))
          (ascii-char1 (call fun/ascii-char8617))
          (fixnum2 (call + (call - 27 2) (call * 32 157)))
          (void3 (call fun/void8618)))
      (call fun/vector8619))))
(check-by-interp
 '(module
    (define fun/any8771 (lambda () (call make-vector 8)))
    (define fun/empty8774 (lambda () empty))
    (define fun/void8770 (lambda () (void)))
    (define fun/any8773 (lambda () empty))
    (define fun/vector8772 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void8770))
          (boolean1 (call error? (call fun/any8771)))
          (vector2 (call fun/vector8772))
          (procedure3 (lambda () (call vector? (call fun/any8773)))))
      (call fun/empty8774))))
(check-by-interp
 '(module
    (define fun/vector9390 (lambda () (call fun/vector9391)))
    (define fun/error9387 (lambda () (error 4)))
    (define fun/ascii-char9394 (lambda () (call fun/ascii-char9395)))
    (define fun/ascii-char9395 (lambda () #\r))
    (define fun/vector9389 (lambda () (call make-vector 8)))
    (define fun/error9386 (lambda () (call fun/error9387)))
    (define fun/vector9393 (lambda () (call make-vector 8)))
    (define fun/vector9391 (lambda () (call make-vector 8)))
    (define fun/vector9392 (lambda () (call fun/vector9393)))
    (define fun/vector9388 (lambda () (call fun/vector9389)))
    (let ((error0 (call fun/error9386))
          (vector1 (call fun/vector9388))
          (vector2 (call fun/vector9390))
          (vector3 (call fun/vector9392))
          (ascii-char4 (call fun/ascii-char9394)))
      (call vector-ref vector2 6))))
(check-by-interp
 '(module
    (define fun/void9398 (lambda () (call fun/void9399)))
    (define fun/empty9407 (lambda () empty))
    (define fun/ascii-char9403 (lambda () #\d))
    (define fun/pair9400 (lambda () (call fun/pair9401)))
    (define fun/vector9404 (lambda () (call fun/vector9405)))
    (define fun/void9399 (lambda () (void)))
    (define fun/empty9406 (lambda () (call fun/empty9407)))
    (define fun/vector9405 (lambda () (call make-vector 8)))
    (define fun/pair9401 (lambda () (call cons 242 377)))
    (define fun/ascii-char9402 (lambda () (call fun/ascii-char9403)))
    (let ((void0 (call fun/void9398))
          (fixnum1
           (call
            -
            (call * (call * 245 94) (call - 94 201))
            (call + (call - 225 16) (call + 46 174))))
          (procedure2 (lambda () (call fun/pair9400)))
          (ascii-char3 (call fun/ascii-char9402))
          (procedure4 (lambda () (call fun/vector9404))))
      (call fun/empty9406))))
(check-by-interp
 '(module
    (define fun/ascii-char10601 (lambda () #\z))
    (define fun/empty10599 (lambda () empty))
    (define fun/vector10595 (lambda () (call make-vector 8)))
    (define fun/ascii-char10597 (lambda () #\e))
    (define fun/empty10602 (lambda () empty))
    (define fun/boolean10598 (lambda (oprand0 oprand1 oprand2 oprand3) #t))
    (define fun/void10594 (lambda () (void)))
    (define fun/empty10603 (lambda () empty))
    (define fun/void10600 (lambda () (void)))
    (define fun/void10596 (lambda () (void)))
    (call
     +
     (let ((void0 (call fun/void10594))
           (vector1 (call fun/vector10595))
           (void2 (call fun/void10596))
           (ascii-char3 (call fun/ascii-char10597))
           (fixnum4 (call - (call - 106 114) (call + 237 60))))
       (call - (call vector-ref vector1 0) (call * 24 223)))
     (call
      +
      (if (call
           fun/boolean10598
           (call cons 171 353)
           #f
           (call cons 5 286)
           (call cons 160 305))
        (let ((void0 (void))
              (vector1 (call make-vector 8))
              (ascii-char2 #\s)
              (boolean3 #f)
              (void4 (void)))
          87)
        (call * 43 99))
      (let ((empty0 (call fun/empty10599))
            (void1 (call fun/void10600))
            (ascii-char2 (call fun/ascii-char10601))
            (empty3 (call fun/empty10602))
            (empty4 (call fun/empty10603)))
        (call + 83 196))))))
(check-by-interp
 '(module
    (define fun/empty12824 (lambda () (call fun/empty12825)))
    (define fun/vector12814 (lambda () (call fun/vector12815)))
    (define fun/vector12823 (lambda () (call make-vector 8)))
    (define fun/error12816 (lambda () (call fun/error12817)))
    (define fun/vector12821 (lambda () (call make-vector 8)))
    (define fun/ascii-char12819 (lambda () #\T))
    (define fun/empty12825 (lambda () empty))
    (define fun/ascii-char12818 (lambda () (call fun/ascii-char12819)))
    (define fun/error12817 (lambda () (error 104)))
    (define fun/vector12822 (lambda () (call fun/vector12823)))
    (define fun/vector12820 (lambda () (call fun/vector12821)))
    (define fun/vector12815 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector12814))
          (error1 (call fun/error12816))
          (ascii-char2 (call fun/ascii-char12818))
          (vector3 (call fun/vector12820))
          (vector4 (call fun/vector12822))
          (empty5 (call fun/empty12824)))
      (call vector-ref vector4 1))))
(check-by-interp
 '(module
    (define fun/empty13316 (lambda () (call fun/empty13317)))
    (define fun/ascii-char13315 (lambda () #\d))
    (define fun/error13313 (lambda () (error 61)))
    (define fun/error13308 (lambda () (call fun/error13309)))
    (define fun/error13312 (lambda () (call fun/error13313)))
    (define fun/pair13319 (lambda () (call cons 243 439)))
    (define fun/void13310 (lambda () (call fun/void13311)))
    (define fun/empty13317 (lambda () empty))
    (define fun/error13309 (lambda () (error 248)))
    (define fun/ascii-char13314 (lambda () (call fun/ascii-char13315)))
    (define fun/void13311 (lambda () (void)))
    (define fun/pair13318 (lambda () (call fun/pair13319)))
    (let ((error0 (call fun/error13308))
          (void1 (call fun/void13310))
          (error2 (call fun/error13312))
          (fixnum3
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
          (ascii-char4 (call fun/ascii-char13314))
          (empty5 (call fun/empty13316)))
      (call fun/pair13318))))
(check-by-interp
 '(module
    (define fun/error13358 (lambda () (call fun/error13359)))
    (define fun/vector13357 (lambda () (call make-vector 8)))
    (define fun/vector13355 (lambda () (call make-vector 8)))
    (define fun/ascii-char13352 (lambda () (call fun/ascii-char13353)))
    (define fun/vector13354 (lambda () (call fun/vector13355)))
    (define fun/vector13356 (lambda () (call fun/vector13357)))
    (define fun/error13359 (lambda () (error 4)))
    (define fun/ascii-char13353 (lambda () #\H))
    (let ((fixnum0
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
          (ascii-char1 (call fun/ascii-char13352))
          (procedure2 (lambda () (call fun/vector13354)))
          (fixnum3
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
          (vector4 (call fun/vector13356))
          (error5 (call fun/error13358)))
      (call procedure2))))
(check-by-interp
 '(module
    (define fun/void14593 (lambda () (void)))
    (define fun/void14591 (lambda () (void)))
    (define fun/void14590 (lambda () (call fun/void14591)))
    (define fun/ascii-char14586 (lambda () (call fun/ascii-char14587)))
    (define fun/void14588 (lambda () (call fun/void14589)))
    (define fun/void14592 (lambda () (call fun/void14593)))
    (define fun/ascii-char14587 (lambda () #\T))
    (define fun/empty14585 (lambda () empty))
    (define fun/void14589 (lambda () (void)))
    (define fun/empty14584 (lambda () (call fun/empty14585)))
    (let ((empty0 (call fun/empty14584))
          (ascii-char1 (call fun/ascii-char14586))
          (void2 (call fun/void14588))
          (fixnum3
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
          (void4 (call fun/void14590))
          (fixnum5
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
      (call fun/void14592))))
(check-by-interp
 '(module
    (define fun/empty15140 (lambda () empty))
    (define fun/void15145 (lambda () (call fun/void15146)))
    (define fun/vector15138 (lambda () (call make-vector 8)))
    (define fun/ascii-char15135 (lambda () (call fun/ascii-char15136)))
    (define fun/void15142 (lambda () (void)))
    (define fun/any15144 (lambda () (call cons 90 455)))
    (define fun/any15143 (lambda () (call fun/any15144)))
    (define fun/vector15137 (lambda () (call fun/vector15138)))
    (define fun/void15146 (lambda () (void)))
    (define fun/empty15139 (lambda () (call fun/empty15140)))
    (define fun/void15141 (lambda () (call fun/void15142)))
    (define fun/ascii-char15136 (lambda () #\N))
    (let ((ascii-char0 (call fun/ascii-char15135))
          (vector1 (call fun/vector15137))
          (empty2 (call fun/empty15139))
          (fixnum3
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
          (void4 (call fun/void15141))
          (boolean5 (call empty? (call fun/any15143))))
      (call fun/void15145))))
(check-by-interp
 '(module
    (define fun/vector15770 (lambda () (call fun/vector15771)))
    (define fun/empty15765 (lambda () empty))
    (define fun/void15774 (lambda () (call fun/void15775)))
    (define fun/error15773 (lambda () (error 17)))
    (define fun/error15772 (lambda () (call fun/error15773)))
    (define fun/vector15771 (lambda () (call make-vector 8)))
    (define fun/ascii-char15769 (lambda () #\_))
    (define fun/empty15767 (lambda () empty))
    (define fun/ascii-char15776 (lambda () (call fun/ascii-char15777)))
    (define fun/empty15766 (lambda () (call fun/empty15767)))
    (define fun/empty15764 (lambda () (call fun/empty15765)))
    (define fun/void15775 (lambda () (void)))
    (define fun/ascii-char15777 (lambda () #\L))
    (define fun/ascii-char15768 (lambda () (call fun/ascii-char15769)))
    (let ((procedure0 (lambda () (call fun/empty15764)))
          (empty1 (call fun/empty15766))
          (ascii-char2 (call fun/ascii-char15768))
          (vector3 (call fun/vector15770))
          (error4 (call fun/error15772))
          (void5 (call fun/void15774)))
      (call fun/ascii-char15776))))
(check-by-interp
 '(module
    (define fun/void21848 (lambda () (void)))
    (define fun/ascii-char21854 (lambda () #\h))
    (define fun/vector21856 (lambda () (call make-vector 8)))
    (define fun/pair21851 (lambda () (call fun/pair21852)))
    (define fun/vector21849 (lambda () (call fun/vector21850)))
    (define fun/vector21850 (lambda () (call make-vector 8)))
    (define fun/error21846 (lambda () (error 231)))
    (define fun/vector21855 (lambda () (call fun/vector21856)))
    (define fun/pair21852 (lambda () (call cons 78 279)))
    (define fun/error21845 (lambda () (call fun/error21846)))
    (define fun/ascii-char21853 (lambda () (call fun/ascii-char21854)))
    (define fun/void21847 (lambda () (call fun/void21848)))
    (let ((error0 (call fun/error21845))
          (void1 (call fun/void21847))
          (vector2 (call fun/vector21849))
          (procedure3 (lambda () (call fun/pair21851)))
          (ascii-char4 (call fun/ascii-char21853))
          (fixnum5
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
      (call fun/vector21855))))
(check-by-interp
 '(module
    (define fun/empty10026 (lambda () (call fun/empty10027)))
    (define fun/void10033 (lambda () (void)))
    (define fun/vector10030 (lambda () (call fun/vector10031)))
    (define fun/empty10023 (lambda () empty))
    (define fun/void10029 (lambda () (void)))
    (define fun/vector10031 (lambda () (call make-vector 8)))
    (define fun/void10028 (lambda () (call fun/void10029)))
    (define fun/empty10027 (lambda () empty))
    (define fun/vector10025 (lambda () (call make-vector 8)))
    (define fun/empty10022 (lambda () (call fun/empty10023)))
    (define fun/vector10024 (lambda () (call fun/vector10025)))
    (define fun/void10032 (lambda () (call fun/void10033)))
    (let ((empty0 (call fun/empty10022))
          (procedure1 (lambda () (call fun/vector10024)))
          (empty2 (call fun/empty10026))
          (void3 (call fun/void10028))
          (vector4 (call fun/vector10030))
          (void5 (call fun/void10032)))
      (call procedure1))))
(check-by-interp
 '(module
    (define fun/any12092 (lambda () (call fun/any12093)))
    (define fun/empty12090 (lambda () (call fun/empty12091)))
    (define fun/error12095 (lambda () (error 45)))
    (define fun/empty12096 (lambda () (call fun/empty12097)))
    (define fun/empty12091 (lambda () empty))
    (define fun/any12093 (lambda () (void)))
    (define fun/void12099 (lambda () (void)))
    (define fun/error12088 (lambda () (call fun/error12089)))
    (define fun/empty12097 (lambda () empty))
    (define fun/error12089 (lambda () (error 114)))
    (define fun/error12094 (lambda () (call fun/error12095)))
    (define fun/void12098 (lambda () (call fun/void12099)))
    (let ((procedure0 (lambda () (call fun/error12088)))
          (fixnum1
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
          (empty2 (call fun/empty12090))
          (boolean3 (call fixnum? (call fun/any12092)))
          (error4 (call fun/error12094))
          (empty5 (call fun/empty12096)))
      (call fun/void12098))))
