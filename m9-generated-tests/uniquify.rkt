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
(check-by-interp
 '(module
    (define fun/void8617 (lambda () (void)))
    (define fun/void8621 (lambda () (void)))
    (define fun/ascii-char8619 (lambda () #\g))
    (define fun/any8618 (lambda () #\M))
    (define fun/void8620 (lambda () (void)))
    (let ((void0 (call fun/void8617))
          (boolean1 (call pair? (call fun/any8618)))
          (ascii-char2 (call fun/ascii-char8619))
          (void3 (call fun/void8620)))
      (call fun/void8621))))
(check-by-interp
 '(module
    (define fun/vector9289 (lambda () (call fun/vector9290)))
    (define fun/error9287 (lambda () (call fun/error9288)))
    (define fun/vector9290 (lambda () (call make-vector 8)))
    (define fun/error9288 (lambda () (error 238)))
    (define fun/vector9292 (lambda () (call make-vector 8)))
    (define fun/empty9296 (lambda () empty))
    (define fun/empty9295 (lambda () (call fun/empty9296)))
    (define fun/vector9291 (lambda () (call fun/vector9292)))
    (define fun/ascii-char9294 (lambda () #\V))
    (define fun/ascii-char9293 (lambda () (call fun/ascii-char9294)))
    (let ((error0 (call fun/error9287))
          (fixnum1
           (call
            *
            (call + (call - 10 182) (call * 226 247))
            (call * (call + 35 137) (call + 166 53))))
          (vector2 (call fun/vector9289))
          (vector3 (call fun/vector9291))
          (ascii-char4 (call fun/ascii-char9293)))
      (call fun/empty9295))))
(check-by-interp
 '(module
    (define fun/void9337 (lambda () (call fun/void9338)))
    (define fun/any9339 (lambda () 1))
    (define fun/ascii-char9340 (lambda () (call fun/ascii-char9341)))
    (define fun/void9345 (lambda () (void)))
    (define fun/empty9342 (lambda () (call fun/empty9343)))
    (define fun/ascii-char9341 (lambda () #\X))
    (define fun/void9344 (lambda () (call fun/void9345)))
    (define fun/void9338 (lambda () (void)))
    (define fun/ascii-char9347 (lambda () #\g))
    (define fun/ascii-char9346 (lambda () (call fun/ascii-char9347)))
    (define fun/empty9343 (lambda () empty))
    (let ((void0 (call fun/void9337))
          (boolean1 (call vector? (call fun/any9339)))
          (ascii-char2 (call fun/ascii-char9340))
          (empty3 (call fun/empty9342))
          (void4 (call fun/void9344)))
      (call fun/ascii-char9346))))
(check-by-interp
 '(module
    (define fun/void9614 (lambda () (call fun/void9615)))
    (define fun/void9618 (lambda () (call fun/void9619)))
    (define fun/void9619 (lambda () (void)))
    (define fun/void9615 (lambda () (void)))
    (define fun/any9611 (lambda () (void)))
    (define fun/ascii-char9616 (lambda () (call fun/ascii-char9617)))
    (define fun/ascii-char9617 (lambda () #\\))
    (define fun/vector9612 (lambda () (call fun/vector9613)))
    (define fun/vector9613 (lambda () (call make-vector 8)))
    (let ((boolean0 (call fixnum? (call fun/any9611)))
          (vector1 (call fun/vector9612))
          (void2 (call fun/void9614))
          (ascii-char3 (call fun/ascii-char9616))
          (void4 (call fun/void9618)))
      (call vector-ref vector1 4))))
(check-by-interp
 '(module
    (define fun/empty10247 (lambda () empty))
    (define fun/vector10251 (lambda () (call make-vector 8)))
    (define fun/vector10250 (lambda () (call fun/vector10251)))
    (define fun/empty10246 (lambda () (call fun/empty10247)))
    (define fun/empty10248 (lambda () (call fun/empty10249)))
    (define fun/error10245 (lambda () (error 53)))
    (define fun/empty10249 (lambda () empty))
    (define fun/error10244 (lambda () (call fun/error10245)))
    (define fun/any10242 (lambda () (error 110)))
    (define fun/any10243 (lambda () #t))
    (let ((boolean0 (call void? (call fun/any10242)))
          (procedure1 (lambda () (call vector? (call fun/any10243))))
          (error2 (call fun/error10244))
          (empty3 (call fun/empty10246))
          (empty4 (call fun/empty10248)))
      (call fun/vector10250))))
(check-by-interp
 '(module
    (define fun/void10770 (lambda () (call fun/void10771)))
    (define fun/void10777 (lambda () (void)))
    (define fun/void10776 (lambda () (call fun/void10777)))
    (define fun/void10772 (lambda () (call fun/void10773)))
    (define fun/void10775 (lambda () (void)))
    (define fun/void10773 (lambda () (void)))
    (define fun/void10771 (lambda () (void)))
    (define fun/void10774 (lambda () (call fun/void10775)))
    (define fun/ascii-char10778 (lambda () (call fun/ascii-char10779)))
    (define fun/ascii-char10779 (lambda () #\c))
    (define fun/vector10781 (lambda () (call make-vector 8)))
    (define fun/vector10780 (lambda () (call fun/vector10781)))
    (let ((void0 (call fun/void10770))
          (void1 (call fun/void10772))
          (void2 (call fun/void10774))
          (void3 (call fun/void10776))
          (ascii-char4 (call fun/ascii-char10778)))
      (call fun/vector10780))))
(check-by-interp
 '(module
    (define fun/void11006 (lambda () (call fun/void11007)))
    (define fun/void11010 (lambda () (call fun/void11011)))
    (define fun/void11007 (lambda () (void)))
    (define fun/empty11017 (lambda () empty))
    (define fun/void11011 (lambda () (void)))
    (define fun/empty11016 (lambda () (call fun/empty11017)))
    (define fun/error11009 (lambda () (error 242)))
    (define fun/void11014 (lambda () (call fun/void11015)))
    (define fun/error11008 (lambda () (call fun/error11009)))
    (define fun/void11015 (lambda () (void)))
    (define fun/ascii-char11013 (lambda () #\k))
    (define fun/ascii-char11012 (lambda () (call fun/ascii-char11013)))
    (let ((fixnum0
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
          (void1 (call fun/void11006))
          (procedure2 (lambda () (call fun/error11008)))
          (void3 (call fun/void11010))
          (ascii-char4 (call fun/ascii-char11012))
          (void5 (call fun/void11014)))
      (call fun/empty11016))))
(check-by-interp
 '(module
    (define fun/error11878 (lambda () (error 64)))
    (define fun/error11879 (lambda () (call fun/error11880)))
    (define fun/ascii-char11876 (lambda () #\m))
    (define fun/error11880 (lambda () (error 168)))
    (define fun/ascii-char11873 (lambda () (call fun/ascii-char11874)))
    (define fun/ascii-char11874 (lambda () #\r))
    (define fun/error11877 (lambda () (call fun/error11878)))
    (define fun/void11872 (lambda () (void)))
    (define fun/void11871 (lambda () (call fun/void11872)))
    (define fun/ascii-char11875 (lambda () (call fun/ascii-char11876)))
    (let ((procedure0
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
          (void1 (call fun/void11871))
          (ascii-char2 (call fun/ascii-char11873))
          (ascii-char3 (call fun/ascii-char11875))
          (error4 (call fun/error11877))
          (error5 (call fun/error11879)))
      (call
       *
       (call - (call + (call - 71 30) (call procedure0)) (call procedure0))
       (call procedure0)))))
(check-by-interp
 '(module
    (define fun/ascii-char12698 (lambda () (call fun/ascii-char12699)))
    (define fun/ascii-char12699 (lambda () #\[))
    (define fun/any12703 (lambda () (call cons 139 388)))
    (define fun/empty12692 (lambda () (call fun/empty12693)))
    (define fun/error12696 (lambda () (call fun/error12697)))
    (define fun/void12701 (lambda () (void)))
    (define fun/error12697 (lambda () (error 95)))
    (define fun/any12702 (lambda () (call fun/any12703)))
    (define fun/void12700 (lambda () (call fun/void12701)))
    (define fun/empty12693 (lambda () empty))
    (define fun/ascii-char12705 (lambda () #\]))
    (define fun/empty12695 (lambda () empty))
    (define fun/ascii-char12704 (lambda () (call fun/ascii-char12705)))
    (define fun/empty12694 (lambda () (call fun/empty12695)))
    (let ((empty0 (call fun/empty12692))
          (empty1 (call fun/empty12694))
          (error2 (call fun/error12696))
          (ascii-char3 (call fun/ascii-char12698))
          (void4 (call fun/void12700))
          (boolean5 (call empty? (call fun/any12702))))
      (call fun/ascii-char12704))))
(check-by-interp
 '(module
    (define fun/ascii-char12715 (lambda () #\i))
    (define fun/ascii-char12714 (lambda () (call fun/ascii-char12715)))
    (define fun/ascii-char12713 (lambda () #\E))
    (define fun/ascii-char12710 (lambda () (call fun/ascii-char12711)))
    (define fun/error12717 (lambda () (error 129)))
    (define fun/error12716 (lambda () (call fun/error12717)))
    (define fun/error12709 (lambda () (error 67)))
    (define fun/ascii-char12719 (lambda () #\[))
    (define fun/ascii-char12718 (lambda () (call fun/ascii-char12719)))
    (define fun/ascii-char12712 (lambda () (call fun/ascii-char12713)))
    (define fun/ascii-char12711 (lambda () #\u))
    (define fun/error12708 (lambda () (call fun/error12709)))
    (let ((error0 (call fun/error12708))
          (procedure1
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
          (ascii-char2 (call fun/ascii-char12710))
          (ascii-char3 (call fun/ascii-char12712))
          (ascii-char4 (call fun/ascii-char12714))
          (error5 (call fun/error12716)))
      (call fun/ascii-char12718))))
(check-by-interp
 '(module
    (define fun/ascii-char14511 (lambda () #\E))
    (define fun/ascii-char14516 (lambda () (call fun/ascii-char14517)))
    (define fun/error14514 (lambda () (call fun/error14515)))
    (define fun/error14515 (lambda () (error 218)))
    (define fun/ascii-char14510 (lambda () (call fun/ascii-char14511)))
    (define fun/ascii-char14517 (lambda () #\c))
    (define fun/error14508 (lambda () (call fun/error14509)))
    (define fun/error14509 (lambda () (error 191)))
    (define fun/error14512 (lambda () (call fun/error14513)))
    (define fun/error14513 (lambda () (error 19)))
    (let ((error0 (call fun/error14508))
          (fixnum1
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
          (fixnum2
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
          (ascii-char3 (call fun/ascii-char14510))
          (error4 (call fun/error14512))
          (error5 (call fun/error14514)))
      (call fun/ascii-char14516))))
(check-by-interp
 '(module
    (define fun/error14883 (lambda () (error 146)))
    (define fun/error14880 (lambda () (call fun/error14881)))
    (define fun/empty14886 (lambda () (call fun/empty14887)))
    (define fun/error14882 (lambda () (call fun/error14883)))
    (define fun/error14881 (lambda () (error 44)))
    (define fun/error14879 (lambda () (error 114)))
    (define fun/empty14887 (lambda () empty))
    (define fun/ascii-char14884 (lambda () (call fun/ascii-char14885)))
    (define fun/ascii-char14885 (lambda () #\b))
    (define fun/empty14876 (lambda () (call fun/empty14877)))
    (define fun/error14878 (lambda () (call fun/error14879)))
    (define fun/empty14877 (lambda () empty))
    (let ((empty0 (call fun/empty14876))
          (error1 (call fun/error14878))
          (error2 (call fun/error14880))
          (procedure3 (lambda () (call fun/error14882)))
          (ascii-char4 (call fun/ascii-char14884))
          (empty5 (call fun/empty14886)))
      (call procedure3))))
(check-by-interp
 '(module
    (define fun/empty15196 (lambda () (call fun/empty15197)))
    (define fun/empty15206 (lambda () (call fun/empty15207)))
    (define fun/ascii-char15202 (lambda () (call fun/ascii-char15203)))
    (define fun/empty15207 (lambda () empty))
    (define fun/vector15208 (lambda () (call fun/vector15209)))
    (define fun/ascii-char15203 (lambda () #\r))
    (define fun/empty15197 (lambda () empty))
    (define fun/vector15209 (lambda () (call make-vector 8)))
    (define fun/empty15204 (lambda () (call fun/empty15205)))
    (define fun/error15200 (lambda () (call fun/error15201)))
    (define fun/any15199 (lambda () (void)))
    (define fun/error15201 (lambda () (error 204)))
    (define fun/any15198 (lambda () (call fun/any15199)))
    (define fun/empty15205 (lambda () empty))
    (let ((procedure0 (lambda () (call fun/empty15196)))
          (procedure1 (lambda () (call ascii-char? (call fun/any15198))))
          (error2 (call fun/error15200))
          (ascii-char3 (call fun/ascii-char15202))
          (empty4 (call fun/empty15204))
          (empty5 (call fun/empty15206)))
      (call fun/vector15208))))
(check-by-interp
 '(module
    (define fun/vector17408 (lambda () (call fun/vector17409)))
    (define fun/vector17418 (lambda () (call fun/vector17419)))
    (define fun/ascii-char17415 (lambda () #\e))
    (define fun/vector17419 (lambda () (call make-vector 8)))
    (define fun/error17410 (lambda () (call fun/error17411)))
    (define fun/vector17409 (lambda () (call make-vector 8)))
    (define fun/void17416 (lambda () (call fun/void17417)))
    (define fun/error17413 (lambda () (error 54)))
    (define fun/ascii-char17414 (lambda () (call fun/ascii-char17415)))
    (define fun/error17412 (lambda () (call fun/error17413)))
    (define fun/error17407 (lambda () (error 211)))
    (define fun/error17411 (lambda () (error 42)))
    (define fun/error17406 (lambda () (call fun/error17407)))
    (define fun/void17417 (lambda () (void)))
    (let ((error0 (call fun/error17406))
          (vector1 (call fun/vector17408))
          (error2 (call fun/error17410))
          (error3 (call fun/error17412))
          (ascii-char4 (call fun/ascii-char17414))
          (void5 (call fun/void17416)))
      (call fun/vector17418))))
(check-by-interp
 '(module
    (define fun/void18574 (lambda () (void)))
    (define fun/vector18571 (lambda () (call fun/vector18572)))
    (define fun/ascii-char18578 (lambda () #\Q))
    (define fun/void18573 (lambda () (call fun/void18574)))
    (define fun/error18580 (lambda () (error 208)))
    (define fun/error18579 (lambda () (call fun/error18580)))
    (define fun/vector18576 (lambda () (call make-vector 8)))
    (define fun/vector18575 (lambda () (call fun/vector18576)))
    (define fun/any18581 (lambda () (call fun/any18582)))
    (define fun/ascii-char18577 (lambda () (call fun/ascii-char18578)))
    (define fun/vector18572 (lambda () (call make-vector 8)))
    (define fun/any18582 (lambda () (call cons 219 440)))
    (let ((procedure0 (lambda () (call fun/vector18571)))
          (void1 (call fun/void18573))
          (vector2 (call fun/vector18575))
          (procedure3 (lambda () (call fun/ascii-char18577)))
          (error4 (call fun/error18579))
          (boolean5 (call pair? (call fun/any18581))))
      (call vector-ref vector2 6))))
(check-by-interp
 '(module
    (define fun/empty18594 (lambda () empty))
    (define fun/error18587 (lambda () (call fun/error18588)))
    (define fun/error18588 (lambda () (error 113)))
    (define fun/empty18593 (lambda () (call fun/empty18594)))
    (define fun/vector18596 (lambda () (call make-vector 8)))
    (define fun/vector18595 (lambda () (call fun/vector18596)))
    (define fun/empty18590 (lambda () empty))
    (define fun/error18586 (lambda () (error 31)))
    (define fun/error18585 (lambda () (call fun/error18586)))
    (define fun/empty18589 (lambda () (call fun/empty18590)))
    (define fun/ascii-char18592 (lambda () #\g))
    (define fun/ascii-char18591 (lambda () (call fun/ascii-char18592)))
    (let ((error0 (call fun/error18585))
          (error1 (call fun/error18587))
          (procedure2 (lambda () (call fun/empty18589)))
          (fixnum3
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
          (ascii-char4 (call fun/ascii-char18591))
          (empty5 (call fun/empty18593)))
      (call fun/vector18595))))
(check-by-interp
 '(module
    (define fun/empty19106 (lambda () empty))
    (define fun/vector19107 (lambda () (call fun/vector19108)))
    (define fun/void19116 (lambda () (void)))
    (define fun/empty19105 (lambda () (call fun/empty19106)))
    (define fun/void19115 (lambda () (call fun/void19116)))
    (define fun/ascii-char19110 (lambda () #\Z))
    (define fun/ascii-char19111 (lambda () (call fun/ascii-char19112)))
    (define fun/error19113 (lambda () (call fun/error19114)))
    (define fun/error19114 (lambda () (error 9)))
    (define fun/ascii-char19109 (lambda () (call fun/ascii-char19110)))
    (define fun/ascii-char19112 (lambda () #\p))
    (define fun/vector19108 (lambda () (call make-vector 8)))
    (let ((empty0 (call fun/empty19105))
          (fixnum1
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
          (procedure2 (lambda () (call fun/vector19107)))
          (ascii-char3 (call fun/ascii-char19109))
          (ascii-char4 (call fun/ascii-char19111))
          (error5 (call fun/error19113)))
      (call fun/void19115))))
(check-by-interp
 '(module
    (define fun/any20282 (lambda () (call fun/any20283)))
    (define fun/void20271 (lambda () (void)))
    (define fun/any20283 (lambda () (error 163)))
    (define fun/void20270 (lambda () (call fun/void20271)))
    (define fun/empty20278 (lambda () (call fun/empty20279)))
    (define fun/empty20273 (lambda () empty))
    (define fun/void20280 (lambda () (call fun/void20281)))
    (define fun/empty20279 (lambda () empty))
    (define fun/error20277 (lambda () (error 110)))
    (define fun/error20276 (lambda () (call fun/error20277)))
    (define fun/ascii-char20275 (lambda () #\Z))
    (define fun/empty20272 (lambda () (call fun/empty20273)))
    (define fun/ascii-char20274 (lambda () (call fun/ascii-char20275)))
    (define fun/void20281 (lambda () (void)))
    (let ((procedure0 (lambda () (call fun/void20270)))
          (empty1 (call fun/empty20272))
          (ascii-char2 (call fun/ascii-char20274))
          (error3 (call fun/error20276))
          (empty4 (call fun/empty20278))
          (void5 (call fun/void20280)))
      (call pair? (call fun/any20282)))))
(check-by-interp
 '(module
    (define fun/empty21163 (lambda () empty))
    (define fun/any21161 (lambda () 186))
    (define fun/any21165 (lambda () (call make-vector 8)))
    (define fun/any21164 (lambda () (call fun/any21165)))
    (define fun/empty21162 (lambda () (call fun/empty21163)))
    (define fun/void21166 (lambda () (call fun/void21167)))
    (define fun/error21156 (lambda () (call fun/error21157)))
    (define fun/vector21159 (lambda () (call make-vector 8)))
    (define fun/void21167 (lambda () (void)))
    (define fun/vector21158 (lambda () (call fun/vector21159)))
    (define fun/error21157 (lambda () (error 103)))
    (define fun/any21160 (lambda () (call fun/any21161)))
    (let ((error0 (call fun/error21156))
          (vector1 (call fun/vector21158))
          (boolean2 (call empty? (call fun/any21160)))
          (fixnum3
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
          (empty4 (call fun/empty21162))
          (boolean5 (call vector? (call fun/any21164))))
      (call fun/void21166))))
(check-by-interp
 '(module
    (define fun/any23222 (lambda () (call cons 40 437)))
    (define fun/error23218 (lambda () (error 182)))
    (define fun/void23223 (lambda () (call fun/void23224)))
    (define fun/void23224 (lambda () (void)))
    (define fun/void23220 (lambda () (void)))
    (define fun/any23221 (lambda () (call fun/any23222)))
    (define fun/void23219 (lambda () (call fun/void23220)))
    (define fun/any23216 (lambda () (call cons 102 340)))
    (define fun/ascii-char23225 (lambda () (call fun/ascii-char23226)))
    (define fun/error23217 (lambda () (call fun/error23218)))
    (define fun/ascii-char23226 (lambda () #\Y))
    (define fun/any23215 (lambda () (call fun/any23216)))
    (let ((boolean0 (call pair? (call fun/any23215)))
          (error1 (call fun/error23217))
          (void2 (call fun/void23219))
          (boolean3 (call boolean? (call fun/any23221)))
          (fixnum4
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
          (void5 (call fun/void23223)))
      (call fun/ascii-char23225))))
(check-by-interp
 '(module
    (define fun/empty24035 (lambda () empty))
    (define fun/empty24029 (lambda () empty))
    (define fun/empty24028 (lambda () (call fun/empty24029)))
    (define fun/pair24037 (lambda () (call cons 50 301)))
    (define fun/any24031 (lambda () #f))
    (define fun/any24030 (lambda () (call fun/any24031)))
    (define fun/any24033 (lambda () #\X))
    (define fun/pair24036 (lambda () (call fun/pair24037)))
    (define fun/any24032 (lambda () (call fun/any24033)))
    (define fun/empty24034 (lambda () (call fun/empty24035)))
    (let ((empty0 (call fun/empty24028))
          (procedure1 (lambda () (call procedure? (call fun/any24030))))
          (fixnum2
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
          (fixnum3
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
          (boolean4 (call empty? (call fun/any24032)))
          (empty5 (call fun/empty24034)))
      (call fun/pair24036))))
