#lang racket
(require cpsc411/compiler-lib cpsc411/langs/v8 "../uniquify.rkt")
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

(check-by-interp '(module #\c))
(check-by-interp '(module (error 191)))
(check-by-interp
 '(module
    (define fun/ascii-char8383 (lambda () #\c))
    (call fun/ascii-char8383)))
(check-by-interp
 '(module (define fun/error8386 (lambda () (error 78))) (call fun/error8386)))
(check-by-interp '(module (let ((empty0 empty)) (void))))
(check-by-interp '(module (if #f (error 197) (error 225))))
(check-by-interp
 '(module
    (define fun/boolean8393 (lambda (oprand0) #t))
    (call fun/boolean8393 (if #t 116 182))))
(check-by-interp
 '(module
    (define fun/fixnum8396 (lambda (oprand0) 241))
    (call + (if #t 74 97) (call fun/fixnum8396 (void)))))
(check-by-interp
 '(module
    (define fun/void8399 (lambda (oprand0) (void)))
    (call fun/void8399 (call * 135 150))))
(check-by-interp
 '(module (let ((fixnum0 125) (vector1 (call make-vector 8))) fixnum0)))
(check-by-interp
 '(module
    (define fun/boolean8404 (lambda (oprand0) #t))
    (define fun/void8405
      (lambda (oprand0)
        (call vector-set! oprand0 7 (call vector-set! oprand0 7 (error 226)))))
    (call fun/boolean8404 (call fun/void8405 (call make-vector 8)))))
(check-by-interp '(module (let ((empty0 empty) (empty1 empty)) (void))))
(check-by-interp '(module (if #f 6 200)))
(check-by-interp
 '(module
    (define fun/ascii-char8412 (lambda (oprand0) #\c))
    (call
     fun/ascii-char8412
     (let ((void0 (void)) (empty1 empty)) (call make-vector 8)))))
(check-by-interp
 '(module
    (define fun/error8417 (lambda () (error 17)))
    (define fun/empty8415 (lambda () empty))
    (define fun/vector8416 (lambda () (call make-vector 8)))
    (let ((empty0 (call fun/empty8415))
          (vector1 (call fun/vector8416))
          (error2 (call fun/error8417)))
      error2)))
(check-by-interp
 '(module
    (define fun/error8429 (lambda () (error 208)))
    (define fun/vector8431 (lambda () (call make-vector 8)))
    (define fun/vector8430 (lambda () (call make-vector 8)))
    (let ((error0 (call fun/error8429))
          (vector1 (call fun/vector8430))
          (vector2 (call fun/vector8431)))
      vector2)))
(check-by-interp
 '(module
    (define fun/void8436 (lambda (oprand0 oprand1) oprand1))
    (define fun/ascii-char8434
      (lambda (oprand0 oprand1) (call fun/ascii-char8435)))
    (define fun/ascii-char8435 (lambda () #\c))
    (call
     fun/ascii-char8434
     (call
      fun/void8436
      (call fun/ascii-char8434 (void) (call make-vector 8))
      (if #t (void) (void)))
     (let ((vector0 (call make-vector 8))
           (empty1 empty)
           (vector2 (call make-vector 8)))
       vector2))))
(check-by-interp
 '(module
    (define fun/fixnum8456 (lambda (oprand0 oprand1) (call - 33 75)))
    (call
     fun/fixnum8456
     (let ((error0 (error 178)) (error1 (error 123)) (boolean2 #f)) boolean2)
     (let ((boolean0 #t) (vector1 (call make-vector 8)) (ascii-char2 #\c))
       #\c))))
(check-by-interp
 '(module
    (define fun/error8463 (lambda (oprand0 oprand1) oprand1))
    (call
     fun/error8463
     (let ((ascii-char0 #\c) (ascii-char1 #\c) (error2 (error 245))) error2)
     (call
      fun/error8463
      (let ((ascii-char0 #\c) (boolean1 #f) (void2 (void))) (error 222))
      (if #f (error 1) (error 145))))))
(check-by-interp
 '(module
    (define fun/void8466
      (lambda (oprand0 oprand1) (call vector-set! oprand1 7 oprand0)))
    (define fun/error8467 (lambda (oprand0 oprand1) (error 197)))
    (define fun/fixnum8468 (lambda (oprand0 oprand1) 230))
    (call
     fun/void8466
     (call fun/error8467 (if #t (void) (void)) (call fun/fixnum8468 #f empty))
     (let ((ascii-char0 #\c) (error1 (error 112)) (ascii-char2 #\c))
       (call make-vector 8)))))
(check-by-interp
 '(module
    (define fun/vector8472 (lambda (oprand0 oprand1) (call make-vector 8)))
    (define fun/ascii-char8473 (lambda (oprand0 oprand1) #\c))
    (define fun/fixnum8471 (lambda (oprand0 oprand1) 10))
    (call
     +
     (call
      fun/fixnum8471
      (call fun/vector8472 58 (call make-vector 8))
      (call fun/ascii-char8473 82 #t))
     (if #t 223 166))))
(check-by-interp
 '(module
    (define fun/empty8476 (lambda () empty))
    (define fun/vector8477 (lambda () (call make-vector 8)))
    (let ((fixnum0 (call * 51 120))
          (empty1 (call fun/empty8476))
          (vector2 (call fun/vector8477)))
      vector2)))
(check-by-interp
 '(module
    (define fun/fixnum8490 (lambda (oprand0 oprand1) 21))
    (define fun/boolean8489 (lambda (oprand0 oprand1) #f))
    (if (call fun/boolean8489 (error 248) 76)
      (call fun/fixnum8490 (void) #t)
      (call * 214 251))))
(check-by-interp
 '(module
    (define fun/empty8497 (lambda () empty))
    (define fun/void8496 (lambda () (void)))
    (define fun/ascii-char8498 (lambda () #\c))
    (let ((void0 (call fun/void8496))
          (empty1 (call fun/empty8497))
          (ascii-char2 (call fun/ascii-char8498)))
      void0)))
(check-by-interp
 '(module
    (define fun/fixnum8501 (lambda (oprand0 oprand1) 23))
    (if (let ((void0 (void)) (error1 (error 162)) (empty2 empty)) #t)
      (call * 26 123)
      (call fun/fixnum8501 #t (void)))))
(check-by-interp
 '(module
    (define fun/empty8545 (lambda () empty))
    (define fun/vector8546 (lambda () (call make-vector 8)))
    (define fun/ascii-char8544 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char8544))
          (empty1 (call fun/empty8545))
          (vector2 (call fun/vector8546)))
      (call + 76 15))))
(check-by-interp
 '(module
    (if (let ((void0 (void)) (ascii-char1 #\c) (fixnum2 202)) #t)
      (call + 65 205)
      (call + 3 49))))
(check-by-interp
 '(module
    (define fun/ascii-char8555 (lambda () #\c))
    (define fun/void8554 (lambda () (void)))
    (let ((boolean0 (call pair? (error 49)))
          (void1 (call fun/void8554))
          (fixnum2 (call + 92 194)))
      (call fun/ascii-char8555))))
(check-by-interp
 '(module
    (define fun/empty8590 (lambda () empty))
    (let ((empty0 (call fun/empty8590))
          (boolean1 (call error? (void)))
          (fixnum2 (call + 174 187)))
      fixnum2)))
(check-by-interp
 '(module
    (define fun/void8641 (lambda () (void)))
    (define fun/empty8642 (lambda () empty))
    (define fun/void8643 (lambda () (void)))
    (let ((void0 (call fun/void8641))
          (empty1 (call fun/empty8642))
          (fixnum2 (call - (call - 205 242) (call * 205 113)))
          (void3 (call fun/void8643)))
      void3)))
(check-by-interp
 '(module
    (define fun/ascii-char8677 (lambda (oprand0 oprand1 oprand2) oprand2))
    (define fun/fixnum8684 (lambda (oprand0 oprand1 oprand2) 119))
    (define fun/boolean8680 (lambda (oprand0 oprand1 oprand2) #t))
    (define fun/vector8679
      (lambda (oprand0 oprand1 oprand2) (call make-vector 8)))
    (define fun/vector8682
      (lambda (oprand0 oprand1 oprand2) (call make-vector 8)))
    (define fun/boolean8678 (lambda (oprand0 oprand1 oprand2) #f))
    (define fun/fixnum8681 (lambda (oprand0 oprand1 oprand2) 33))
    (define fun/empty8683 (lambda (oprand0 oprand1 oprand2) empty))
    (call
     fun/ascii-char8677
     (if (call fun/boolean8678 empty empty #\c)
       (if #f (call make-vector 8) (call make-vector 8))
       (call fun/vector8679 103 (void) (error 210)))
     (if (call fun/boolean8680 163 (call make-vector 8) (call make-vector 8))
       (call * 230 63)
       (call fun/fixnum8681 #f (call make-vector 8) (void)))
     (call
      fun/ascii-char8677
      (call
       fun/vector8682
       (call
        fun/empty8683
        (call make-vector 8)
        (error 248)
        (call make-vector 8))
       (if #f (call make-vector 8) (call make-vector 8))
       (let ((boolean0 #f) (void1 (void)) (fixnum2 171) (ascii-char3 #\c))
         void1))
      (call
       fun/fixnum8684
       (let ((void0 (void))
             (empty1 empty)
             (vector2 (call make-vector 8))
             (fixnum3 204))
         empty1)
       (call ascii-char? (error 224))
       (if #t #\c #\c))
      (if #t #\c #\c)))))
(check-by-interp
 '(module
    (if (let ((vector0 (call make-vector 8))
              (void1 (void))
              (error2 (error 137))
              (boolean3 #t))
          boolean3)
      (if #f #\c #\c)
      (let ((fixnum0 189) (void1 (void)) (void2 (void)) (ascii-char3 #\c))
        ascii-char3))))
(check-by-interp
 '(module
    (if (if #f #f #f)
      (call * (if #f 137 109) (call * 163 203))
      (let ((vector0 (call make-vector 8))
            (empty1 empty)
            (error2 (error 236))
            (boolean3 #f))
        194))))
(check-by-interp
 '(module
    (define fun/void9010 (lambda () (void)))
    (define fun/error9012 (lambda () (error 66)))
    (define fun/vector9011 (lambda () (call make-vector 8)))
    (define fun/vector9013 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void9010))
          (vector1 (call fun/vector9011))
          (error2 (call fun/error9012))
          (vector3 (call fun/vector9013)))
      void0)))
(check-by-interp
 '(module
    (define fun/empty9031 (lambda () empty))
    (define fun/vector9032 (lambda () (call make-vector 8)))
    (define fun/vector9030 (lambda () (call make-vector 8)))
    (define fun/error9033 (lambda () (error 69)))
    (let ((vector0 (call fun/vector9030))
          (empty1 (call fun/empty9031))
          (vector2 (call fun/vector9032))
          (error3 (call fun/error9033)))
      empty1)))
(check-by-interp
 '(module
    (define fun/error9302 (lambda () (error 3)))
    (define fun/vector9300 (lambda () (call make-vector 8)))
    (define fun/vector9301 (lambda () (call make-vector 8)))
    (define fun/vector9298 (lambda () (call make-vector 8)))
    (define fun/ascii-char9299 (lambda () #\c))
    (let ((vector0 (call fun/vector9298))
          (ascii-char1 (call fun/ascii-char9299))
          (vector2 (call fun/vector9300))
          (vector3 (call fun/vector9301)))
      (call fun/error9302))))
(check-by-interp
 '(module
    (define fun/error9361 (lambda () (error 55)))
    (define fun/empty9358 (lambda () empty))
    (define fun/void9360 (lambda () (void)))
    (define fun/empty9359 (lambda () empty))
    (let ((empty0 (call fun/empty9358))
          (fixnum1 (call - (call * 182 165) (call * 13 1)))
          (empty2 (call fun/empty9359))
          (void3 (call fun/void9360)))
      (call fun/error9361))))
(check-by-interp
 '(module
    (define fun/empty9583 (lambda () empty))
    (define fun/error9578 (lambda () (error 162)))
    (define fun/vector9576
      (lambda (oprand0 oprand1 oprand2) (call fun/vector9577)))
    (define fun/ascii-char9584 (lambda () #\c))
    (define fun/ascii-char9579 (lambda () #\c))
    (define fun/error9582 (lambda () (error 153)))
    (define fun/empty9580 (lambda () empty))
    (define fun/ascii-char9581 (lambda () #\c))
    (define fun/vector9577 (lambda () (call make-vector 8)))
    (call
     fun/vector9576
     (call
      +
      (if #t 74 28)
      (let ((error0 (error 192))
            (vector1 (call make-vector 8))
            (void2 (void))
            (void3 (void)))
        179))
     (let ((error0 (call fun/error9578))
           (ascii-char1 (call fun/ascii-char9579))
           (empty2 (call fun/empty9580))
           (ascii-char3 (call fun/ascii-char9581)))
       (call * 212 128))
     (let ((error0 (call fun/error9582))
           (empty1 (call fun/empty9583))
           (boolean2 (call boolean? (void)))
           (ascii-char3 (call fun/ascii-char9584)))
       empty1))))
(check-by-interp
 '(module
    (define fun/void9768 (lambda () (void)))
    (define fun/any9769 (lambda () (call make-vector 8)))
    (define fun/error9767 (lambda () (error 33)))
    (define fun/empty9770 (lambda () empty))
    (let ((error0 (call fun/error9767))
          (void1 (call fun/void9768))
          (boolean2 (call empty? (call fun/any9769)))
          (empty3 (call fun/empty9770)))
      void1)))
(check-by-interp
 '(module
    (define fun/error9957 (lambda () (error 156)))
    (define fun/vector9959 (lambda () (call make-vector 8)))
    (define fun/empty9960 (lambda () empty))
    (define fun/void9958 (lambda () (void)))
    (let ((error0 (call fun/error9957))
          (void1 (call fun/void9958))
          (vector2 (call fun/vector9959))
          (fixnum3 (call - (call * 224 128) (call - 121 68))))
      (call fun/empty9960))))
(check-by-interp
 '(module
    (define fun/vector10055
      (lambda (oprand0 oprand1 oprand2) (call make-vector 8)))
    (define fun/ascii-char10053 (lambda (oprand0 oprand1 oprand2) oprand1))
    (define fun/vector10054 (lambda (oprand0 oprand1 oprand2) oprand1))
    (define fun/error10056 (lambda (oprand0 oprand1 oprand2) oprand1))
    (call
     fun/ascii-char10053
     (call
      fun/vector10054
      (let ((boolean0 #f)
            (error1 (error 59))
            (error2 (error 140))
            (fixnum3 119))
        203)
      (if #f (call make-vector 8) (call make-vector 8))
      (let ((ascii-char0 #\c)
            (ascii-char1 #\c)
            (vector2 (call make-vector 8))
            (boolean3 #f))
        (error 37)))
     (call
      fun/ascii-char10053
      (call
       fun/vector10055
       (let ((ascii-char0 #\c)
             (vector1 (call make-vector 8))
             (boolean2 #t)
             (fixnum3 33))
         (error 99))
       (if #t #\c #\c)
       (call fun/ascii-char10053 (call make-vector 8) #\c (error 211)))
      (let ((boolean0 #f)
            (boolean1 #t)
            (ascii-char2 #\c)
            (vector3 (call make-vector 8)))
        #\c)
      (if #f (error 182) (error 55)))
     (call
      fun/error10056
      (if #t empty empty)
      (call
       fun/error10056
       (if #f empty empty)
       (call fun/error10056 empty (error 46) (void))
       (if #t (void) (void)))
      (if #f (void) (void))))))
(check-by-interp
 '(module
    (define fun/void10119 (lambda (oprand0 oprand1 oprand2) (void)))
    (define fun/fixnum10117 (lambda (oprand0 oprand1 oprand2) oprand1))
    (define fun/fixnum10118 (lambda (oprand0 oprand1 oprand2) 205))
    (call
     -
     (call
      fun/fixnum10117
      (if #t (error 108) (error 141))
      (let ((void0 (void)) (fixnum1 29) (boolean2 #t) (fixnum3 16)) fixnum1)
      (let ((empty0 empty) (boolean1 #f) (void2 (void)) (void3 (void)))
        (void)))
     (call
      +
      (if #f 95 53)
      (call
       fun/fixnum10118
       (call fun/void10119 #f #\c empty)
       (let ((boolean0 #t) (empty1 empty) (boolean2 #t) (boolean3 #t))
         (error 105))
       (call * 37 187))))))
(check-by-interp
 '(module
    (define fun/error10147 (lambda () (error 9)))
    (define fun/void10149 (lambda () (void)))
    (define fun/empty10148 (lambda () empty))
    (define fun/vector10150 (lambda () (call make-vector 8)))
    (let ((error0 (call fun/error10147))
          (empty1 (call fun/empty10148))
          (void2 (call fun/void10149))
          (vector3 (call fun/vector10150)))
      empty1)))
(check-by-interp
 '(module
    (define fun/error10153 (lambda () (error 12)))
    (define fun/error10154 (lambda () (error 19)))
    (let ((error0 (call fun/error10153))
          (fixnum1 (call * (call - 135 185) (call * 237 167)))
          (error2 (call fun/error10154))
          (fixnum3 (call + (call + 246 49) (call * 176 151))))
      error2)))
(check-by-interp
 '(module
    (define fun/error10182 (lambda () (error 160)))
    (define fun/void10183 (lambda () (void)))
    (define fun/vector10184 (lambda () (call make-vector 8)))
    (define fun/ascii-char10185 (lambda () #\c))
    (let ((error0 (call fun/error10182))
          (void1 (call fun/void10183))
          (vector2 (call fun/vector10184))
          (fixnum3 (call * (call - 27 232) (call + 223 209))))
      (call fun/ascii-char10185))))
(check-by-interp
 '(module
    (define fun/ascii-char10875 (lambda () #\c))
    (define fun/vector10878 (lambda () (call make-vector 8)))
    (define fun/void10876 (lambda () (void)))
    (define fun/vector10877 (lambda () (call make-vector 8)))
    (define fun/ascii-char10879 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char10875))
          (void1 (call fun/void10876))
          (vector2 (call fun/vector10877))
          (vector3 (call fun/vector10878))
          (ascii-char4 (call fun/ascii-char10879)))
      (call
       -
       (call * (call - 117 4) (call + 216 102))
       (call + (call * 114 249) (call * 209 177))))))
(check-by-interp
 '(module
    (define fun/vector11280 (lambda () (call make-vector 8)))
    (define fun/empty11282 (lambda () empty))
    (define fun/error11283 (lambda () (error 235)))
    (define fun/error11281 (lambda () (error 145)))
    (define fun/ascii-char11284 (lambda () #\c))
    (let ((vector0 (call fun/vector11280))
          (error1 (call fun/error11281))
          (empty2 (call fun/empty11282))
          (fixnum3
           (call
            +
            (call - (call + 120 239) (call - 127 153))
            (call - (call * 191 153) (call * 76 30))))
          (error4 (call fun/error11283)))
      (call fun/ascii-char11284))))
(check-by-interp
 '(module
    (define fun/vector11329 (lambda () (call make-vector 8)))
    (define fun/empty11330 (lambda () empty))
    (define fun/void11328 (lambda () (void)))
    (let ((fixnum0
           (call
            -
            (call + (call - 179 253) (call * 165 99))
            (call - (call * 69 45) (call - 208 233))))
          (fixnum1
           (call
            *
            (call - (call + 127 107) (call + 220 57))
            (call * (call + 243 167) (call + 167 52))))
          (void2 (call fun/void11328))
          (vector3 (call fun/vector11329))
          (empty4 (call fun/empty11330)))
      fixnum0)))
(check-by-interp
 '(module
    (define fun/ascii-char11508 (lambda () #\c))
    (define fun/void11512 (lambda () (void)))
    (define fun/ascii-char11511 (lambda () #\c))
    (define fun/empty11507 (lambda () empty))
    (define fun/empty11509 (lambda () empty))
    (define fun/error11510 (lambda () (error 122)))
    (let ((empty0 (call fun/empty11507))
          (ascii-char1 (call fun/ascii-char11508))
          (empty2 (call fun/empty11509))
          (error3 (call fun/error11510))
          (ascii-char4 (call fun/ascii-char11511)))
      (call fun/void11512))))
(check-by-interp
 '(module
    (define fun/ascii-char11665 (lambda () #\c))
    (define fun/void11663 (lambda () (void)))
    (define fun/vector11666 (lambda () (call make-vector 8)))
    (define fun/empty11664 (lambda () empty))
    (define fun/vector11667 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void11663))
          (empty1 (call fun/empty11664))
          (ascii-char2 (call fun/ascii-char11665))
          (vector3 (call fun/vector11666))
          (vector4 (call fun/vector11667)))
      empty1)))
(check-by-interp
 '(module
    (define fun/empty11788 (lambda () empty))
    (define fun/empty11787 (lambda () empty))
    (define fun/vector11789 (lambda () (call make-vector 8)))
    (define fun/vector11786 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector11786))
          (empty1 (call fun/empty11787))
          (fixnum2
           (call
            *
            (call * (call - 42 35) (call - 64 48))
            (call + (call - 122 73) (call - 203 180))))
          (empty3 (call fun/empty11788))
          (vector4 (call fun/vector11789)))
      empty3)))
(check-by-interp
 '(module
    (define fun/any11902 (lambda () #f))
    (define fun/ascii-char11900 (lambda () #\c))
    (define fun/ascii-char11901 (lambda () #\c))
    (define fun/ascii-char11903 (lambda () #\c))
    (define fun/void11904 (lambda () (void)))
    (define fun/empty11899 (lambda () empty))
    (let ((empty0 (call fun/empty11899))
          (ascii-char1 (call fun/ascii-char11900))
          (ascii-char2 (call fun/ascii-char11901))
          (boolean3 (call boolean? (call fun/any11902)))
          (ascii-char4 (call fun/ascii-char11903)))
      (call fun/void11904))))
(check-by-interp
 '(module
    (define fun/void11995 (lambda () (void)))
    (define fun/ascii-char11994 (lambda () #\c))
    (define fun/void11996 (lambda () (void)))
    (let ((ascii-char0 (call fun/ascii-char11994))
          (void1 (call fun/void11995))
          (void2 (call fun/void11996))
          (fixnum3
           (call
            -
            (call + (call + 250 5) (call * 94 16))
            (call + (call + 38 236) (call - 180 46))))
          (fixnum4
           (call
            *
            (call * (call - 173 225) (call * 12 137))
            (call + (call + 139 45) (call * 168 159)))))
      (call + fixnum4 fixnum3))))
(check-by-interp
 '(module
    (define fun/void11999 (lambda () (void)))
    (define fun/ascii-char12000 (lambda () #\c))
    (let ((fixnum0
           (call
            +
            (call * (call * 248 56) (call - 156 82))
            (call - (call + 57 175) (call + 131 140))))
          (fixnum1
           (call
            +
            (call + (call - 45 197) (call * 221 181))
            (call * (call * 140 242) (call * 177 131))))
          (void2 (call fun/void11999))
          (fixnum3
           (call
            +
            (call * (call + 85 210) (call * 98 238))
            (call - (call * 203 209) (call * 251 129))))
          (ascii-char4 (call fun/ascii-char12000)))
      ascii-char4)))
(check-by-interp
 '(module
    (define fun/empty12004 (lambda () empty))
    (define fun/void12007 (lambda () (void)))
    (define fun/empty12006 (lambda () empty))
    (define fun/ascii-char12003 (lambda () #\c))
    (define fun/void12005 (lambda () (void)))
    (let ((ascii-char0 (call fun/ascii-char12003))
          (empty1 (call fun/empty12004))
          (void2 (call fun/void12005))
          (empty3 (call fun/empty12006))
          (void4 (call fun/void12007)))
      void4)))
(check-by-interp
 '(module
    (define fun/any12082 (lambda () (call make-vector 8)))
    (define fun/error12079 (lambda () (error 59)))
    (define fun/error12080 (lambda () (error 90)))
    (define fun/any12081 (lambda () (call make-vector 8)))
    (define fun/empty12078 (lambda () empty))
    (call
     vector?
     (let ((empty0 (call fun/empty12078))
           (error1 (call fun/error12079))
           (fixnum2 (call - (call + 254 82) (call - 19 23)))
           (error3 (call fun/error12080))
           (boolean4 (call empty? (call fun/any12081))))
       (call fun/any12082)))))
(check-by-interp
 '(module
    (define fun/empty12122 (lambda () empty))
    (define fun/vector12120 (lambda () (call make-vector 8)))
    (define fun/vector12123 (lambda () (call make-vector 8)))
    (define fun/ascii-char12121 (lambda () #\c))
    (define fun/vector12124 (lambda () (call make-vector 8)))
    (define fun/any12125 (lambda () (error 150)))
    (let ((vector0 (call fun/vector12120))
          (ascii-char1 (call fun/ascii-char12121))
          (empty2 (call fun/empty12122))
          (vector3 (call fun/vector12123))
          (vector4 (call fun/vector12124)))
      (call error? (call fun/any12125)))))
(check-by-interp
 '(module
    (define fun/ascii-char12857 (lambda () #\c))
    (define fun/void12858 (lambda () (void)))
    (define fun/error12860 (lambda () (error 144)))
    (define fun/error12859 (lambda () (error 119)))
    (define fun/empty12861 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char12857))
          (void1 (call fun/void12858))
          (error2 (call fun/error12859))
          (error3 (call fun/error12860))
          (empty4 (call fun/empty12861)))
      empty4)))
(check-by-interp
 '(module
    (define fun/empty13119 (lambda () empty))
    (define fun/vector13122 (lambda () (call make-vector 8)))
    (define fun/ascii-char13121 (lambda () #\c))
    (define fun/empty13118 (lambda () empty))
    (define fun/void13120 (lambda () (void)))
    (let ((empty0 (call fun/empty13118))
          (empty1 (call fun/empty13119))
          (void2 (call fun/void13120))
          (ascii-char3 (call fun/ascii-char13121))
          (vector4 (call fun/vector13122)))
      empty0)))
(check-by-interp
 '(module
    (define fun/ascii-char13212 (lambda () #\c))
    (define fun/error13215 (lambda () (error 252)))
    (define fun/vector13211 (lambda () (call make-vector 8)))
    (define fun/empty13213 (lambda () empty))
    (define fun/ascii-char13214 (lambda () #\c))
    (let ((vector0 (call fun/vector13211))
          (ascii-char1 (call fun/ascii-char13212))
          (empty2 (call fun/empty13213))
          (ascii-char3 (call fun/ascii-char13214))
          (error4 (call fun/error13215)))
      empty2)))
(check-by-interp
 '(module
    (define fun/ascii-char14008 (lambda () #\c))
    (define fun/error14007 (lambda () (error 128)))
    (define fun/void14006 (lambda () (void)))
    (let ((fixnum0
           (call
            -
            (call + (call * 192 89) (call - 209 20))
            (call * (call - 30 228) (call * 180 215))))
          (void1 (call fun/void14006))
          (fixnum2
           (call
            *
            (call - (call + 35 74) (call * 55 67))
            (call + (call - 50 93) (call - 199 135))))
          (error3 (call fun/error14007))
          (ascii-char4 (call fun/ascii-char14008)))
      (call * fixnum0 fixnum0))))
(check-by-interp
 '(module
    (define fun/vector14141 (lambda () (call make-vector 8)))
    (define fun/error14142 (lambda () (error 87)))
    (define fun/any14139 (lambda () (call make-vector 8)))
    (define fun/empty14140 (lambda () empty))
    (let ((boolean0 (call ascii-char? (call fun/any14139)))
          (empty1 (call fun/empty14140))
          (fixnum2
           (call
            +
            (call + (call * 131 3) (call - 169 101))
            (call * (call - 141 4) (call + 223 165))))
          (fixnum3
           (call
            -
            (call - (call * 223 123) (call * 162 234))
            (call + (call + 128 165) (call * 103 193))))
          (vector4 (call fun/vector14141)))
      (call fun/error14142))))
(check-by-interp
 '(module
    (define fun/ascii-char14689 (lambda () #\c))
    (define fun/error14685 (lambda () (error 11)))
    (define fun/vector14688 (lambda () (call make-vector 8)))
    (define fun/void14686 (lambda () (void)))
    (define fun/vector14687 (lambda () (call make-vector 8)))
    (let ((error0 (call fun/error14685))
          (void1 (call fun/void14686))
          (vector2 (call fun/vector14687))
          (fixnum3
           (call
            +
            (call - (call * 196 234) (call * 145 245))
            (call * (call * 27 41) (call + 47 85))))
          (vector4 (call fun/vector14688)))
      (call fun/ascii-char14689))))
(check-by-interp
 '(module
    (define fun/vector15058 (lambda () (call make-vector 8)))
    (define fun/vector15059 (lambda () (call make-vector 8)))
    (define fun/error15060 (lambda () (error 216)))
    (let ((fixnum0
           (call
            *
            (call * (call * 28 216) (call * 161 212))
            (call + (call - 55 152) (call + 49 180))))
          (vector1 (call fun/vector15058))
          (vector2 (call fun/vector15059))
          (fixnum3
           (call
            -
            (call * (call + 105 69) (call - 70 246))
            (call - (call - 145 164) (call * 22 8))))
          (error4 (call fun/error15060)))
      fixnum3)))
(check-by-interp
 '(module
    (define fun/ascii-char15107 (lambda () #\c))
    (define fun/vector15108 (lambda () (call make-vector 8)))
    (let ((ascii-char0 (call fun/ascii-char15107))
          (fixnum1
           (call
            +
            (call * (call + 252 39) (call * 182 36))
            (call - (call * 144 253) (call * 198 34))))
          (fixnum2
           (call
            +
            (call - (call * 9 212) (call * 209 237))
            (call + (call * 176 88) (call - 76 100))))
          (fixnum3
           (call
            *
            (call - (call * 227 27) (call * 82 107))
            (call - (call * 53 63) (call + 212 202))))
          (fixnum4
           (call
            *
            (call - (call + 133 110) (call - 221 54))
            (call - (call + 245 130) (call * 56 191)))))
      (call fun/vector15108))))
(check-by-interp
 '(module
    (define fun/void15239 (lambda () (void)))
    (define fun/ascii-char15242 (lambda () #\c))
    (define fun/error15237 (lambda () (error 43)))
    (define fun/error15240 (lambda () (error 16)))
    (define fun/error15238 (lambda () (error 224)))
    (define fun/empty15241 (lambda () empty))
    (let ((error0 (call fun/error15237))
          (error1 (call fun/error15238))
          (void2 (call fun/void15239))
          (error3 (call fun/error15240))
          (empty4 (call fun/empty15241)))
      (call fun/ascii-char15242))))
(check-by-interp
 '(module
    (define fun/void15268 (lambda () (void)))
    (define fun/void15269 (lambda () (void)))
    (define fun/empty15270 (lambda () empty))
    (define fun/void15267 (lambda () (void)))
    (let ((void0 (call fun/void15267))
          (void1 (call fun/void15268))
          (void2 (call fun/void15269))
          (empty3 (call fun/empty15270))
          (fixnum4
           (call
            *
            (call + (call + 110 157) (call * 142 196))
            (call - (call - 35 147) (call + 151 154)))))
      void0)))
(check-by-interp
 '(module
    (define fun/ascii-char15482 (lambda () #\c))
    (define fun/void15483 (lambda () (void)))
    (define fun/any15480 (lambda () empty))
    (define fun/void15481 (lambda () (void)))
    (let ((boolean0 (call ascii-char? (call fun/any15480)))
          (void1 (call fun/void15481))
          (ascii-char2 (call fun/ascii-char15482))
          (fixnum3
           (call
            +
            (call + (call + 142 247) (call + 12 162))
            (call - (call * 85 149) (call + 76 79))))
          (void4 (call fun/void15483)))
      void4)))
(check-by-interp
 '(module
    (define fun/void15713 (lambda () (void)))
    (define fun/ascii-char15715 (lambda () #\c))
    (define fun/vector15714 (lambda () (call make-vector 8)))
    (define fun/any15712 (lambda () 55))
    (define fun/void15716 (lambda () (void)))
    (let ((boolean0 (call vector? (call fun/any15712)))
          (void1 (call fun/void15713))
          (vector2 (call fun/vector15714))
          (ascii-char3 (call fun/ascii-char15715))
          (void4 (call fun/void15716)))
      vector2)))
(check-by-interp
 '(module
    (define fun/empty15779 (lambda () empty))
    (define fun/vector15781 (lambda () (call make-vector 8)))
    (define fun/error15780 (lambda () (error 146)))
    (let ((empty0 (call fun/empty15779))
          (fixnum1
           (call
            +
            (call * (call - 13 233) (call + 27 254))
            (call + (call * 96 13) (call * 92 154))))
          (fixnum2
           (call
            +
            (call - (call + 31 184) (call - 156 0))
            (call * (call - 241 140) (call + 193 89))))
          (fixnum3
           (call
            *
            (call * (call - 146 110) (call * 47 107))
            (call - (call - 170 175) (call - 188 108))))
          (error4 (call fun/error15780)))
      (call fun/vector15781))))
(check-by-interp
 '(module
    (define fun/empty16392 (lambda () empty))
    (define fun/void16390 (lambda () (void)))
    (define fun/ascii-char16393 (lambda () #\c))
    (define fun/error16394 (lambda () (error 149)))
    (define fun/vector16391 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void16390))
          (vector1 (call fun/vector16391))
          (fixnum2
           (call
            *
            (call + (call + 203 3) (call - 97 129))
            (call + (call - 9 69) (call * 83 79))))
          (empty3 (call fun/empty16392))
          (ascii-char4 (call fun/ascii-char16393)))
      (call fun/error16394))))
(check-by-interp
 '(module
    (define fun/ascii-char17311 (lambda () #\c))
    (define fun/void17307 (lambda () (void)))
    (define fun/empty17309 (lambda () empty))
    (define fun/vector17310 (lambda () (call make-vector 8)))
    (define fun/empty17308 (lambda () empty))
    (let ((fixnum0
           (call
            -
            (call + (call + 45 176) (call - 223 22))
            (call - (call - 73 29) (call - 0 26))))
          (void1 (call fun/void17307))
          (empty2 (call fun/empty17308))
          (empty3 (call fun/empty17309))
          (vector4 (call fun/vector17310)))
      (call fun/ascii-char17311))))
(check-by-interp
 '(module
    (define fun/any17793 (lambda () #\c))
    (define fun/error17796 (lambda () (error 76)))
    (define fun/any17795 (lambda () (error 183)))
    (define fun/empty17794 (lambda () empty))
    (let ((boolean0 (call empty? (call fun/any17793)))
          (empty1 (call fun/empty17794))
          (fixnum2
           (call
            *
            (call * (call * 244 242) (call - 2 140))
            (call * (call - 193 190) (call - 221 196))))
          (boolean3 (call vector? (call fun/any17795)))
          (error4 (call fun/error17796)))
      error4)))
(check-by-interp
 '(module
    (define fun/ascii-char17800 (lambda () #\c))
    (define fun/vector17801 (lambda () (call make-vector 8)))
    (define fun/empty17802 (lambda () empty))
    (define fun/ascii-char17799 (lambda () #\c))
    (define fun/ascii-char17803 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char17799))
          (ascii-char1 (call fun/ascii-char17800))
          (vector2 (call fun/vector17801))
          (empty3 (call fun/empty17802))
          (ascii-char4 (call fun/ascii-char17803)))
      empty3)))
(check-by-interp
 '(module
    (define fun/vector17866 (lambda () (call make-vector 8)))
    (define fun/vector17865 (lambda () (call make-vector 8)))
    (define fun/error17868 (lambda () (error 217)))
    (define fun/any17869 (lambda () (call make-vector 8)))
    (define fun/ascii-char17867 (lambda () #\c))
    (let ((vector0 (call fun/vector17865))
          (vector1 (call fun/vector17866))
          (ascii-char2 (call fun/ascii-char17867))
          (error3 (call fun/error17868))
          (boolean4 (call error? (call fun/any17869))))
      vector0)))
(check-by-interp
 '(module
    (define fun/vector17918 (lambda () (call make-vector 8)))
    (define fun/void17920 (lambda () (void)))
    (define fun/ascii-char17917 (lambda () #\c))
    (define fun/void17916 (lambda () (void)))
    (define fun/vector17919 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void17916))
          (ascii-char1 (call fun/ascii-char17917))
          (vector2 (call fun/vector17918))
          (vector3 (call fun/vector17919))
          (void4 (call fun/void17920)))
      ascii-char1)))
(check-by-interp
 '(module
    (define fun/void19438 (lambda () (void)))
    (define fun/error19439 (lambda () (error 184)))
    (define fun/vector19440 (lambda () (call make-vector 8)))
    (define fun/any19441 (lambda () (void)))
    (define fun/ascii-char19442 (lambda () #\c))
    (let ((void0 (call fun/void19438))
          (error1 (call fun/error19439))
          (vector2 (call fun/vector19440))
          (boolean3 (call empty? (call fun/any19441)))
          (ascii-char4 (call fun/ascii-char19442)))
      void0)))
(check-by-interp
 '(module
    (define fun/error20171 (lambda () (error 229)))
    (define fun/vector20172 (lambda () (call make-vector 8)))
    (define fun/vector20170 (lambda () (call make-vector 8)))
    (define fun/error20169 (lambda () (error 2)))
    (define fun/any20173 (lambda () (error 221)))
    (let ((error0 (call fun/error20169))
          (vector1 (call fun/vector20170))
          (error2 (call fun/error20171))
          (vector3 (call fun/vector20172))
          (boolean4 (call pair? (call fun/any20173))))
      vector1)))
(check-by-interp
 '(module
    (define fun/ascii-char20264 (lambda () #\c))
    (define fun/void20262 (lambda () (void)))
    (define fun/empty20263 (lambda () empty))
    (define fun/ascii-char20266 (lambda () #\c))
    (define fun/vector20265 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void20262))
          (empty1 (call fun/empty20263))
          (ascii-char2 (call fun/ascii-char20264))
          (vector3 (call fun/vector20265))
          (ascii-char4 (call fun/ascii-char20266)))
      vector3)))
(check-by-interp
 '(module
    (define fun/vector20594 (lambda () (call make-vector 8)))
    (define fun/error20595 (lambda () (error 217)))
    (define fun/ascii-char20591 (lambda () #\c))
    (define fun/error20593 (lambda () (error 191)))
    (define fun/empty20592 (lambda () empty))
    (let ((ascii-char0 (call fun/ascii-char20591))
          (empty1 (call fun/empty20592))
          (error2 (call fun/error20593))
          (vector3 (call fun/vector20594))
          (error4 (call fun/error20595)))
      empty1)))
(check-by-interp
 '(module
    (define fun/any20781 (lambda () (void)))
    (define fun/error20783 (lambda () (error 177)))
    (define fun/empty20785 (lambda () empty))
    (define fun/error20782 (lambda () (error 164)))
    (define fun/any20784 (lambda () #t))
    (let ((boolean0 (call fixnum? (call fun/any20781)))
          (fixnum1
           (call
            -
            (call * (call - 226 247) (call * 249 138))
            (call * (call - 192 49) (call * 69 197))))
          (error2 (call fun/error20782))
          (error3 (call fun/error20783))
          (boolean4 (call boolean? (call fun/any20784))))
      (call fun/empty20785))))
(check-by-interp
 '(module
    (define fun/error20840 (lambda () (error 27)))
    (define fun/void20837 (lambda () (void)))
    (define fun/any20838 (lambda () (void)))
    (define fun/empty20839 (lambda () empty))
    (define fun/vector20841 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void20837))
          (boolean1 (call boolean? (call fun/any20838)))
          (empty2 (call fun/empty20839))
          (error3 (call fun/error20840))
          (vector4 (call fun/vector20841)))
      vector4)))
(check-by-interp
 '(module
    (define fun/ascii-char22127 (lambda () #\c))
    (define fun/error22124 (lambda () (error 160)))
    (define fun/error22126 (lambda () (error 10)))
    (define fun/void22125 (lambda () (void)))
    (let ((error0 (call fun/error22124))
          (fixnum1
           (call
            -
            (call + (call + 66 23) (call - 154 19))
            (call - (call - 56 80) (call + 93 29))))
          (void2 (call fun/void22125))
          (error3 (call fun/error22126))
          (ascii-char4 (call fun/ascii-char22127)))
      void2)))
(check-by-interp
 '(module
    (define fun/any22156 (lambda () (void)))
    (define fun/ascii-char22153 (lambda () #\c))
    (define fun/ascii-char22152 (lambda () #\c))
    (define fun/void22154 (lambda () (void)))
    (define fun/any22155 (lambda () (void)))
    (let ((ascii-char0 (call fun/ascii-char22152))
          (ascii-char1 (call fun/ascii-char22153))
          (void2 (call fun/void22154))
          (boolean3 (call void? (call fun/any22155)))
          (boolean4 (call ascii-char? (call fun/any22156))))
      ascii-char1)))
(check-by-interp
 '(module
    (define fun/error22341 (lambda () (error 156)))
    (define fun/void22343 (lambda () (void)))
    (define fun/empty22340 (lambda () empty))
    (define fun/empty22342 (lambda () empty))
    (define fun/void22344 (lambda () (void)))
    (let ((empty0 (call fun/empty22340))
          (error1 (call fun/error22341))
          (empty2 (call fun/empty22342))
          (void3 (call fun/void22343))
          (void4 (call fun/void22344)))
      (call
       +
       (call - (call + 237 212) (call + 68 144))
       (call - (call * 197 48) (call * 159 227))))))
(check-by-interp
 '(module
    (define fun/vector22361 (lambda () (call make-vector 8)))
    (define fun/ascii-char22363 (lambda () #\c))
    (define fun/ascii-char22359 (lambda () #\c))
    (define fun/any22362 (lambda () (call make-vector 8)))
    (define fun/ascii-char22360 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char22359))
          (ascii-char1 (call fun/ascii-char22360))
          (vector2 (call fun/vector22361))
          (boolean3 (call boolean? (call fun/any22362)))
          (ascii-char4 (call fun/ascii-char22363)))
      ascii-char1)))
(check-by-interp
 '(module
    (define fun/vector22406 (lambda () (call make-vector 8)))
    (define fun/vector22405 (lambda () (call make-vector 8)))
    (define fun/error22407 (lambda () (error 2)))
    (define fun/ascii-char22404 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char22404))
          (vector1 (call fun/vector22405))
          (vector2 (call fun/vector22406))
          (fixnum3
           (call
            -
            (call * (call * 45 205) (call - 236 39))
            (call - (call + 124 242) (call + 129 44))))
          (error4 (call fun/error22407)))
      vector2)))
(check-by-interp
 '(module
    (define fun/vector22557 (lambda () (call make-vector 8)))
    (define fun/void22559 (lambda () (void)))
    (define fun/vector22558 (lambda () (call make-vector 8)))
    (define fun/empty22560 (lambda () empty))
    (let ((fixnum0
           (call
            +
            (call * (call - 201 66) (call + 247 80))
            (call + (call * 148 2) (call + 187 166))))
          (vector1 (call fun/vector22557))
          (vector2 (call fun/vector22558))
          (void3 (call fun/void22559))
          (empty4 (call fun/empty22560)))
      vector1)))
(check-by-interp
 '(module
    (define fun/ascii-char22583 (lambda () #\c))
    (define fun/any22584 (lambda () empty))
    (define fun/any22585 (lambda () empty))
    (define fun/empty22581 (lambda () empty))
    (define fun/ascii-char22582 (lambda () #\c))
    (let ((empty0 (call fun/empty22581))
          (fixnum1
           (call
            *
            (call * (call + 100 46) (call + 137 22))
            (call - (call - 185 166) (call - 194 99))))
          (ascii-char2 (call fun/ascii-char22582))
          (ascii-char3 (call fun/ascii-char22583))
          (boolean4 (call empty? (call fun/any22584))))
      (call empty? (call fun/any22585)))))
(check-by-interp
 '(module
    (define fun/void22702 (lambda () (void)))
    (define fun/error22701 (lambda () (error 125)))
    (define fun/any22703 (lambda () empty))
    (let ((error0 (call fun/error22701))
          (void1 (call fun/void22702))
          (boolean2 (call empty? (call fun/any22703)))
          (fixnum3
           (call
            *
            (call + (call + 49 222) (call * 135 152))
            (call * (call + 29 139) (call - 192 210))))
          (fixnum4
           (call
            *
            (call + (call * 42 172) (call + 66 25))
            (call * (call + 16 73) (call - 81 22)))))
      void1)))
(check-by-interp
 '(module
    (define fun/ascii-char23153 (lambda () #\c))
    (define fun/error23159 (lambda () (error 175)))
    (define fun/ascii-char23157 (lambda () #\c))
    (define fun/void23154 (lambda () (call fun/void23155)))
    (define fun/error23151 (lambda () (error 89)))
    (define fun/ascii-char23156 (lambda () (call fun/ascii-char23157)))
    (define fun/void23155 (lambda () (void)))
    (define fun/error23150 (lambda () (call fun/error23151)))
    (define fun/error23158 (lambda () (call fun/error23159)))
    (define fun/ascii-char23152 (lambda () (call fun/ascii-char23153)))
    (let ((error0 (call fun/error23150))
          (ascii-char1 (call fun/ascii-char23152))
          (void2 (call fun/void23154))
          (fixnum3
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
          (ascii-char4 (call fun/ascii-char23156))
          (error5 (call fun/error23158)))
      error5)))
(check-by-interp
 '(module
    (define fun/empty24557 (lambda () empty))
    (define fun/any24558 (lambda () #t))
    (define fun/error24555 (lambda () (error 222)))
    (define fun/ascii-char24562 (lambda () (call fun/ascii-char24563)))
    (define fun/empty24560 (lambda () (call fun/empty24561)))
    (define fun/empty24561 (lambda () empty))
    (define fun/empty24556 (lambda () (call fun/empty24557)))
    (define fun/any24559 (lambda () (void)))
    (define fun/error24552 (lambda () (call fun/error24553)))
    (define fun/ascii-char24563 (lambda () #\c))
    (define fun/error24553 (lambda () (error 203)))
    (define fun/error24554 (lambda () (call fun/error24555)))
    (let ((error0 (call fun/error24552))
          (error1 (call fun/error24554))
          (empty2 (call fun/empty24556))
          (boolean3 (call ascii-char? (call fun/any24558)))
          (boolean4 (call empty? (call fun/any24559)))
          (empty5 (call fun/empty24560)))
      (call fun/ascii-char24562))))
(check-by-interp
 '(module
    (define fun/void26320 (lambda () (call fun/void26321)))
    (define fun/error26317 (lambda () (error 38)))
    (define fun/ascii-char26323 (lambda () #\c))
    (define fun/empty26318 (lambda () (call fun/empty26319)))
    (define fun/void26314 (lambda () (call fun/void26315)))
    (define fun/vector26324 (lambda () (call fun/vector26325)))
    (define fun/empty26319 (lambda () empty))
    (define fun/void26321 (lambda () (void)))
    (define fun/error26316 (lambda () (call fun/error26317)))
    (define fun/ascii-char26322 (lambda () (call fun/ascii-char26323)))
    (define fun/vector26325 (lambda () (call make-vector 8)))
    (define fun/void26315 (lambda () (void)))
    (let ((void0 (call fun/void26314))
          (error1 (call fun/error26316))
          (empty2 (call fun/empty26318))
          (void3 (call fun/void26320))
          (ascii-char4 (call fun/ascii-char26322))
          (vector5 (call fun/vector26324)))
      ascii-char4)))
(check-by-interp
 '(module
    (define fun/empty28807 (lambda () empty))
    (define fun/vector28798 (lambda () (call fun/vector28799)))
    (define fun/empty28806 (lambda () (call fun/empty28807)))
    (define fun/error28804 (lambda () (call fun/error28805)))
    (define fun/error28801 (lambda () (error 128)))
    (define fun/void28802 (lambda () (call fun/void28803)))
    (define fun/error28800 (lambda () (call fun/error28801)))
    (define fun/any28797 (lambda () 9))
    (define fun/vector28799 (lambda () (call make-vector 8)))
    (define fun/error28805 (lambda () (error 64)))
    (define fun/void28803 (lambda () (void)))
    (let ((boolean0 (call pair? (call fun/any28797)))
          (vector1 (call fun/vector28798))
          (error2 (call fun/error28800))
          (void3 (call fun/void28802))
          (error4 (call fun/error28804))
          (empty5 (call fun/empty28806)))
      void3)))
(check-by-interp
 '(module
    (define fun/ascii-char29402 (lambda () #\c))
    (define fun/empty29399 (lambda () (call fun/empty29400)))
    (define fun/ascii-char29401 (lambda () (call fun/ascii-char29402)))
    (define fun/empty29404 (lambda () empty))
    (define fun/ascii-char29406 (lambda () #\c))
    (define fun/ascii-char29405 (lambda () (call fun/ascii-char29406)))
    (define fun/empty29400 (lambda () empty))
    (define fun/empty29403 (lambda () (call fun/empty29404)))
    (let ((empty0 (call fun/empty29399))
          (ascii-char1 (call fun/ascii-char29401))
          (empty2 (call fun/empty29403))
          (fixnum3
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
          (fixnum4
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
          (ascii-char5 (call fun/ascii-char29405)))
      (call
       *
       (call * (call + (call - fixnum4 fixnum3) fixnum3) fixnum3)
       (call - fixnum4 (call - fixnum4 (call - 43 fixnum4)))))))
(check-by-interp
 '(module
    (define fun/ascii-char31474 (lambda () #\c))
    (define fun/vector31478 (lambda () (call make-vector 8)))
    (define fun/error31475 (lambda () (call fun/error31476)))
    (define fun/empty31472 (lambda () empty))
    (define fun/ascii-char31479 (lambda () (call fun/ascii-char31480)))
    (define fun/vector31477 (lambda () (call fun/vector31478)))
    (define fun/error31476 (lambda () (error 203)))
    (define fun/ascii-char31473 (lambda () (call fun/ascii-char31474)))
    (define fun/ascii-char31480 (lambda () #\c))
    (define fun/empty31481 (lambda () (call fun/empty31482)))
    (define fun/empty31471 (lambda () (call fun/empty31472)))
    (define fun/empty31482 (lambda () empty))
    (let ((empty0 (call fun/empty31471))
          (ascii-char1 (call fun/ascii-char31473))
          (error2 (call fun/error31475))
          (vector3 (call fun/vector31477))
          (ascii-char4 (call fun/ascii-char31479))
          (empty5 (call fun/empty31481)))
      vector3)))
(check-by-interp
 '(module
    (define fun/void31691 (lambda () (void)))
    (define fun/void31695 (lambda () (call fun/void31696)))
    (define fun/any31694 (lambda () #\c))
    (define fun/empty31692 (lambda () (call fun/empty31693)))
    (define fun/void31690 (lambda () (call fun/void31691)))
    (define fun/empty31693 (lambda () empty))
    (define fun/empty31688 (lambda () (call fun/empty31689)))
    (define fun/void31696 (lambda () (void)))
    (define fun/empty31689 (lambda () empty))
    (let ((empty0 (call fun/empty31688))
          (fixnum1
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
          (void2 (call fun/void31690))
          (empty3 (call fun/empty31692))
          (boolean4 (call empty? (call fun/any31694)))
          (void5 (call fun/void31695)))
      empty0)))
(check-by-interp
 '(module
    (define fun/vector33321 (lambda () (call make-vector 8)))
    (define fun/vector33317 (lambda () (call make-vector 8)))
    (define fun/ascii-char33318 (lambda () (call fun/ascii-char33319)))
    (define fun/ascii-char33325 (lambda () #\c))
    (define fun/empty33322 (lambda () (call fun/empty33323)))
    (define fun/error33326 (lambda () (call fun/error33327)))
    (define fun/vector33320 (lambda () (call fun/vector33321)))
    (define fun/ascii-char33324 (lambda () (call fun/ascii-char33325)))
    (define fun/empty33323 (lambda () empty))
    (define fun/ascii-char33319 (lambda () #\c))
    (define fun/vector33316 (lambda () (call fun/vector33317)))
    (define fun/error33327 (lambda () (error 39)))
    (let ((vector0 (call fun/vector33316))
          (ascii-char1 (call fun/ascii-char33318))
          (vector2 (call fun/vector33320))
          (empty3 (call fun/empty33322))
          (ascii-char4 (call fun/ascii-char33324))
          (error5 (call fun/error33326)))
      ascii-char1)))
(check-by-interp
 '(module
    (define fun/empty33353 (lambda () (call fun/empty33354)))
    (define fun/vector33343 (lambda () (call fun/vector33344)))
    (define fun/ascii-char33350 (lambda () #\c))
    (define fun/vector33348 (lambda () (call make-vector 8)))
    (define fun/empty33345 (lambda () (call fun/empty33346)))
    (define fun/vector33344 (lambda () (call make-vector 8)))
    (define fun/ascii-char33351 (lambda () (call fun/ascii-char33352)))
    (define fun/ascii-char33349 (lambda () (call fun/ascii-char33350)))
    (define fun/empty33346 (lambda () empty))
    (define fun/empty33354 (lambda () empty))
    (define fun/vector33347 (lambda () (call fun/vector33348)))
    (define fun/ascii-char33352 (lambda () #\c))
    (let ((vector0 (call fun/vector33343))
          (empty1 (call fun/empty33345))
          (vector2 (call fun/vector33347))
          (ascii-char3 (call fun/ascii-char33349))
          (ascii-char4 (call fun/ascii-char33351))
          (empty5 (call fun/empty33353)))
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
    (define fun/ascii-char37881 (lambda () #\c))
    (define fun/ascii-char37880 (lambda () (call fun/ascii-char37881)))
    (define fun/any37875 (lambda () #t))
    (define fun/error37883 (lambda () (error 63)))
    (define fun/empty37879 (lambda () empty))
    (define fun/vector37877 (lambda () (call make-vector 8)))
    (define fun/vector37876 (lambda () (call fun/vector37877)))
    (define fun/error37882 (lambda () (call fun/error37883)))
    (define fun/empty37878 (lambda () (call fun/empty37879)))
    (let ((boolean0 (call empty? (call fun/any37875)))
          (vector1 (call fun/vector37876))
          (empty2 (call fun/empty37878))
          (fixnum3
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
          (ascii-char4 (call fun/ascii-char37880))
          (error5 (call fun/error37882)))
      empty2)))
(check-by-interp
 '(module
    (define fun/void40451 (lambda () (call fun/void40452)))
    (define fun/vector40454 (lambda () (call make-vector 8)))
    (define fun/void40452 (lambda () (void)))
    (define fun/vector40453 (lambda () (call fun/vector40454)))
    (let ((fixnum0
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
          (void1 (call fun/void40451))
          (fixnum2
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
          (fixnum3
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
          (vector4 (call fun/vector40453))
          (fixnum5
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
      void1)))
(check-by-interp
 '(module
    (define fun/error41241 (lambda () (call fun/error41242)))
    (define fun/void41237 (lambda () (call fun/void41238)))
    (define fun/error41233 (lambda () (call fun/error41234)))
    (define fun/void41232 (lambda () (void)))
    (define fun/error41236 (lambda () (error 2)))
    (define fun/error41234 (lambda () (error 33)))
    (define fun/ascii-char41240 (lambda () #\c))
    (define fun/void41231 (lambda () (call fun/void41232)))
    (define fun/error41242 (lambda () (error 110)))
    (define fun/void41238 (lambda () (void)))
    (define fun/empty41244 (lambda () empty))
    (define fun/error41235 (lambda () (call fun/error41236)))
    (define fun/empty41243 (lambda () (call fun/empty41244)))
    (define fun/ascii-char41239 (lambda () (call fun/ascii-char41240)))
    (let ((void0 (call fun/void41231))
          (error1 (call fun/error41233))
          (error2 (call fun/error41235))
          (void3 (call fun/void41237))
          (ascii-char4 (call fun/ascii-char41239))
          (error5 (call fun/error41241)))
      (call fun/empty41243))))
(check-by-interp
 '(module
    (define fun/vector41741 (lambda () (call fun/vector41742)))
    (define fun/vector41742 (lambda () (call make-vector 8)))
    (define fun/empty41735 (lambda () (call fun/empty41736)))
    (define fun/vector41744 (lambda () (call make-vector 8)))
    (define fun/vector41740 (lambda () (call make-vector 8)))
    (define fun/ascii-char41737 (lambda () (call fun/ascii-char41738)))
    (define fun/ascii-char41738 (lambda () #\c))
    (define fun/vector41743 (lambda () (call fun/vector41744)))
    (define fun/vector41739 (lambda () (call fun/vector41740)))
    (define fun/empty41736 (lambda () empty))
    (let ((empty0 (call fun/empty41735))
          (ascii-char1 (call fun/ascii-char41737))
          (vector2 (call fun/vector41739))
          (fixnum3
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
          (vector4 (call fun/vector41741))
          (vector5 (call fun/vector41743)))
      vector2)))
(check-by-interp
 '(module
    (define fun/error43435 (lambda () (error 119)))
    (define fun/ascii-char43427 (lambda () #\c))
    (define fun/empty43433 (lambda () empty))
    (define fun/error43431 (lambda () (error 35)))
    (define fun/vector43429 (lambda () (call make-vector 8)))
    (define fun/ascii-char43426 (lambda () (call fun/ascii-char43427)))
    (define fun/error43430 (lambda () (call fun/error43431)))
    (define fun/error43434 (lambda () (call fun/error43435)))
    (define fun/empty43432 (lambda () (call fun/empty43433)))
    (define fun/vector43428 (lambda () (call fun/vector43429)))
    (let ((ascii-char0 (call fun/ascii-char43426))
          (vector1 (call fun/vector43428))
          (fixnum2
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
          (error3 (call fun/error43430))
          (empty4 (call fun/empty43432))
          (error5 (call fun/error43434)))
      vector1)))
(check-by-interp
 '(module
    (define fun/void44609 (lambda () (call fun/void44610)))
    (define fun/error44607 (lambda () (error 253)))
    (define fun/any44605 (lambda () empty))
    (define fun/error44606 (lambda () (call fun/error44607)))
    (define fun/any44608 (lambda () (void)))
    (define fun/void44610 (lambda () (void)))
    (define fun/ascii-char44603 (lambda () (call fun/ascii-char44604)))
    (define fun/ascii-char44604 (lambda () #\c))
    (let ((fixnum0
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
          (ascii-char1 (call fun/ascii-char44603))
          (boolean2 (call fixnum? (call fun/any44605)))
          (error3 (call fun/error44606))
          (boolean4 (call void? (call fun/any44608)))
          (void5 (call fun/void44609)))
      void5)))
(check-by-interp
 '(module
    (define fun/error45483 (lambda () (call fun/error45484)))
    (define fun/void45488 (lambda () (void)))
    (define fun/error45484 (lambda () (error 182)))
    (define fun/void45487 (lambda () (call fun/void45488)))
    (define fun/any45489 (lambda () (error 216)))
    (define fun/vector45485 (lambda () (call fun/vector45486)))
    (define fun/vector45486 (lambda () (call make-vector 8)))
    (let ((error0 (call fun/error45483))
          (vector1 (call fun/vector45485))
          (void2 (call fun/void45487))
          (fixnum3
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
          (fixnum4
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
          (boolean5 (call empty? (call fun/any45489))))
      vector1)))
(check-by-interp
 '(module
    (define fun/error47015 (lambda () (call fun/error47016)))
    (define fun/empty47018 (lambda () empty))
    (define fun/void47024 (lambda () (void)))
    (define fun/void47023 (lambda () (call fun/void47024)))
    (define fun/empty47020 (lambda () empty))
    (define fun/empty47017 (lambda () (call fun/empty47018)))
    (define fun/error47016 (lambda () (error 118)))
    (define fun/ascii-char47022 (lambda () #\c))
    (define fun/ascii-char47021 (lambda () (call fun/ascii-char47022)))
    (define fun/empty47019 (lambda () (call fun/empty47020)))
    (let ((error0 (call fun/error47015))
          (empty1 (call fun/empty47017))
          (empty2 (call fun/empty47019))
          (ascii-char3 (call fun/ascii-char47021))
          (fixnum4
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
          (fixnum5
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
      (call fun/void47023))))
(check-by-interp
 '(module
    (define fun/void47049 (lambda () (void)))
    (define fun/empty47040 (lambda () (call fun/empty47041)))
    (define fun/void47043 (lambda () (void)))
    (define fun/vector47038 (lambda () (call fun/vector47039)))
    (define fun/vector47039 (lambda () (call make-vector 8)))
    (define fun/vector47047 (lambda () (call make-vector 8)))
    (define fun/ascii-char47044 (lambda () (call fun/ascii-char47045)))
    (define fun/ascii-char47045 (lambda () #\c))
    (define fun/vector47046 (lambda () (call fun/vector47047)))
    (define fun/void47048 (lambda () (call fun/void47049)))
    (define fun/void47042 (lambda () (call fun/void47043)))
    (define fun/empty47041 (lambda () empty))
    (let ((vector0 (call fun/vector47038))
          (empty1 (call fun/empty47040))
          (void2 (call fun/void47042))
          (ascii-char3 (call fun/ascii-char47044))
          (vector4 (call fun/vector47046))
          (void5 (call fun/void47048)))
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
    (define fun/error47944 (lambda () (call fun/error47945)))
    (define fun/ascii-char47942 (lambda () (call fun/ascii-char47943)))
    (define fun/ascii-char47949 (lambda () #\c))
    (define fun/error47947 (lambda () (error 86)))
    (define fun/vector47950 (lambda () (call fun/vector47951)))
    (define fun/vector47951 (lambda () (call make-vector 8)))
    (define fun/ascii-char47948 (lambda () (call fun/ascii-char47949)))
    (define fun/error47945 (lambda () (error 216)))
    (define fun/ascii-char47943 (lambda () #\c))
    (define fun/error47946 (lambda () (call fun/error47947)))
    (let ((ascii-char0 (call fun/ascii-char47942))
          (fixnum1
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
          (error2 (call fun/error47944))
          (error3 (call fun/error47946))
          (ascii-char4 (call fun/ascii-char47948))
          (fixnum5
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
      (call fun/vector47950))))
(check-by-interp
 '(module
    (define fun/error48429 (lambda () (error 123)))
    (define fun/void48432 (lambda () (call fun/void48433)))
    (define fun/empty48430 (lambda () (call fun/empty48431)))
    (define fun/empty48431 (lambda () empty))
    (define fun/any48434 (lambda () empty))
    (define fun/error48428 (lambda () (call fun/error48429)))
    (define fun/void48433 (lambda () (void)))
    (let ((fixnum0
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
          (fixnum1
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
          (error2 (call fun/error48428))
          (empty3 (call fun/empty48430))
          (void4 (call fun/void48432))
          (boolean5 (call void? (call fun/any48434))))
      fixnum0)))
(check-by-interp
 '(module
    (define fun/any48767 (lambda () (call make-vector 8)))
    (define fun/error48777 (lambda () (error 193)))
    (define fun/void48775 (lambda () (void)))
    (define fun/void48774 (lambda () (call fun/void48775)))
    (define fun/error48771 (lambda () (error 135)))
    (define fun/vector48768 (lambda () (call fun/vector48769)))
    (define fun/ascii-char48773 (lambda () #\c))
    (define fun/error48770 (lambda () (call fun/error48771)))
    (define fun/ascii-char48772 (lambda () (call fun/ascii-char48773)))
    (define fun/error48776 (lambda () (call fun/error48777)))
    (define fun/vector48769 (lambda () (call make-vector 8)))
    (let ((boolean0 (call void? (call fun/any48767)))
          (vector1 (call fun/vector48768))
          (error2 (call fun/error48770))
          (ascii-char3 (call fun/ascii-char48772))
          (void4 (call fun/void48774))
          (error5 (call fun/error48776)))
      void4)))
(check-by-interp
 '(module
    (define fun/vector49002 (lambda () (call make-vector 8)))
    (define fun/vector49003 (lambda () (call fun/vector49004)))
    (define fun/error49006 (lambda () (error 187)))
    (define fun/empty49008 (lambda () empty))
    (define fun/void48999 (lambda () (call fun/void49000)))
    (define fun/error49009 (lambda () (call fun/error49010)))
    (define fun/vector49004 (lambda () (call make-vector 8)))
    (define fun/error49010 (lambda () (error 223)))
    (define fun/error49005 (lambda () (call fun/error49006)))
    (define fun/empty49007 (lambda () (call fun/empty49008)))
    (define fun/vector49001 (lambda () (call fun/vector49002)))
    (define fun/void49000 (lambda () (void)))
    (let ((void0 (call fun/void48999))
          (vector1 (call fun/vector49001))
          (vector2 (call fun/vector49003))
          (error3 (call fun/error49005))
          (empty4 (call fun/empty49007))
          (error5 (call fun/error49009)))
      vector1)))
(check-by-interp
 '(module
    (define fun/error50158 (lambda () (error 201)))
    (define fun/vector50165 (lambda () (call make-vector 8)))
    (define fun/error50162 (lambda () (error 230)))
    (define fun/any50163 (lambda () (call make-vector 8)))
    (define fun/error50161 (lambda () (call fun/error50162)))
    (define fun/ascii-char50160 (lambda () #\c))
    (define fun/void50155 (lambda () (call fun/void50156)))
    (define fun/vector50164 (lambda () (call fun/vector50165)))
    (define fun/ascii-char50159 (lambda () (call fun/ascii-char50160)))
    (define fun/error50157 (lambda () (call fun/error50158)))
    (define fun/void50156 (lambda () (void)))
    (let ((void0 (call fun/void50155))
          (error1 (call fun/error50157))
          (ascii-char2 (call fun/ascii-char50159))
          (fixnum3
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
          (error4 (call fun/error50161))
          (boolean5 (call empty? (call fun/any50163))))
      (call fun/vector50164))))
(check-by-interp
 '(module
    (define fun/error50542 (lambda () (error 147)))
    (define fun/void50544 (lambda () (void)))
    (define fun/any50545 (lambda () (void)))
    (define fun/ascii-char50537 (lambda () (call fun/ascii-char50538)))
    (define fun/vector50539 (lambda () (call fun/vector50540)))
    (define fun/error50541 (lambda () (call fun/error50542)))
    (define fun/empty50535 (lambda () (call fun/empty50536)))
    (define fun/ascii-char50538 (lambda () #\c))
    (define fun/vector50540 (lambda () (call make-vector 8)))
    (define fun/empty50536 (lambda () empty))
    (define fun/void50543 (lambda () (call fun/void50544)))
    (let ((empty0 (call fun/empty50535))
          (ascii-char1 (call fun/ascii-char50537))
          (vector2 (call fun/vector50539))
          (error3 (call fun/error50541))
          (void4 (call fun/void50543))
          (boolean5 (call ascii-char? (call fun/any50545))))
      vector2)))
(check-by-interp
 '(module
    (define fun/ascii-char52445 (lambda () #\c))
    (define fun/void52451 (lambda () (void)))
    (define fun/ascii-char52442 (lambda () (call fun/ascii-char52443)))
    (define fun/error52440 (lambda () (call fun/error52441)))
    (define fun/ascii-char52449 (lambda () #\c))
    (define fun/ascii-char52448 (lambda () (call fun/ascii-char52449)))
    (define fun/void52450 (lambda () (call fun/void52451)))
    (define fun/empty52447 (lambda () empty))
    (define fun/empty52446 (lambda () (call fun/empty52447)))
    (define fun/ascii-char52444 (lambda () (call fun/ascii-char52445)))
    (define fun/ascii-char52443 (lambda () #\c))
    (define fun/error52441 (lambda () (error 245)))
    (let ((error0 (call fun/error52440))
          (ascii-char1 (call fun/ascii-char52442))
          (ascii-char2 (call fun/ascii-char52444))
          (empty3 (call fun/empty52446))
          (ascii-char4 (call fun/ascii-char52448))
          (fixnum5
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
      (call fun/void52450))))
(check-by-interp
 '(module
    (define fun/empty53231 (lambda () empty))
    (define fun/any53225 (lambda () (call make-vector 8)))
    (define fun/ascii-char53229 (lambda () #\c))
    (define fun/ascii-char53228 (lambda () (call fun/ascii-char53229)))
    (define fun/empty53227 (lambda () empty))
    (define fun/ascii-char53232 (lambda () (call fun/ascii-char53233)))
    (define fun/empty53226 (lambda () (call fun/empty53227)))
    (define fun/empty53230 (lambda () (call fun/empty53231)))
    (define fun/ascii-char53233 (lambda () #\c))
    (define fun/error53235 (lambda () (error 55)))
    (define fun/error53234 (lambda () (call fun/error53235)))
    (let ((boolean0 (call ascii-char? (call fun/any53225)))
          (empty1 (call fun/empty53226))
          (ascii-char2 (call fun/ascii-char53228))
          (empty3 (call fun/empty53230))
          (fixnum4
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
          (ascii-char5 (call fun/ascii-char53232)))
      (call fun/error53234))))
(check-by-interp
 '(module
    (define fun/vector53786 (lambda () (call fun/vector53787)))
    (define fun/empty53785 (lambda () empty))
    (define fun/ascii-char53788 (lambda () (call fun/ascii-char53789)))
    (define fun/ascii-char53791 (lambda () #\c))
    (define fun/ascii-char53789 (lambda () #\c))
    (define fun/empty53784 (lambda () (call fun/empty53785)))
    (define fun/empty53793 (lambda () (call fun/empty53794)))
    (define fun/vector53787 (lambda () (call make-vector 8)))
    (define fun/any53792 (lambda () #\c))
    (define fun/ascii-char53790 (lambda () (call fun/ascii-char53791)))
    (define fun/empty53794 (lambda () empty))
    (let ((empty0 (call fun/empty53784))
          (vector1 (call fun/vector53786))
          (ascii-char2 (call fun/ascii-char53788))
          (ascii-char3 (call fun/ascii-char53790))
          (boolean4 (call void? (call fun/any53792)))
          (empty5 (call fun/empty53793)))
      ascii-char3)))
(check-by-interp
 '(module
    (define fun/ascii-char54522 (lambda () (call fun/ascii-char54523)))
    (define fun/error54517 (lambda () (error 95)))
    (define fun/vector54521 (lambda () (call make-vector 8)))
    (define fun/void54525 (lambda () (void)))
    (define fun/ascii-char54523 (lambda () #\c))
    (define fun/error54518 (lambda () (call fun/error54519)))
    (define fun/vector54520 (lambda () (call fun/vector54521)))
    (define fun/void54524 (lambda () (call fun/void54525)))
    (define fun/error54516 (lambda () (call fun/error54517)))
    (define fun/error54519 (lambda () (error 10)))
    (let ((error0 (call fun/error54516))
          (fixnum1
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
          (error2 (call fun/error54518))
          (vector3 (call fun/vector54520))
          (ascii-char4 (call fun/ascii-char54522))
          (void5 (call fun/void54524)))
      ascii-char4)))
(check-by-interp
 '(module
    (define fun/void54535 (lambda () (void)))
    (define fun/void54532 (lambda () (call fun/void54533)))
    (define fun/ascii-char54537 (lambda () #\c))
    (define fun/vector54530 (lambda () (call fun/vector54531)))
    (define fun/empty54539 (lambda () empty))
    (define fun/error54528 (lambda () (call fun/error54529)))
    (define fun/empty54538 (lambda () (call fun/empty54539)))
    (define fun/void54534 (lambda () (call fun/void54535)))
    (define fun/vector54531 (lambda () (call make-vector 8)))
    (define fun/error54529 (lambda () (error 217)))
    (define fun/ascii-char54536 (lambda () (call fun/ascii-char54537)))
    (define fun/void54533 (lambda () (void)))
    (let ((error0 (call fun/error54528))
          (vector1 (call fun/vector54530))
          (void2 (call fun/void54532))
          (void3 (call fun/void54534))
          (ascii-char4 (call fun/ascii-char54536))
          (fixnum5
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
      (call fun/empty54538))))
(check-by-interp
 '(module
    (define fun/vector54731 (lambda () (call make-vector 8)))
    (define fun/ascii-char54737 (lambda () #\c))
    (define fun/any54729 (lambda () #t))
    (define fun/vector54739 (lambda () (call make-vector 8)))
    (define fun/empty54734 (lambda () (call fun/empty54735)))
    (define fun/vector54730 (lambda () (call fun/vector54731)))
    (define fun/void54732 (lambda () (call fun/void54733)))
    (define fun/empty54735 (lambda () empty))
    (define fun/ascii-char54736 (lambda () (call fun/ascii-char54737)))
    (define fun/vector54738 (lambda () (call fun/vector54739)))
    (define fun/void54733 (lambda () (void)))
    (let ((boolean0 (call void? (call fun/any54729)))
          (vector1 (call fun/vector54730))
          (void2 (call fun/void54732))
          (empty3 (call fun/empty54734))
          (ascii-char4 (call fun/ascii-char54736))
          (vector5 (call fun/vector54738)))
      void2)))
(check-by-interp
 '(module
    (define fun/any55519 (lambda () #\c))
    (define fun/ascii-char55520 (lambda () (call fun/ascii-char55521)))
    (define fun/vector55523 (lambda () (call make-vector 8)))
    (define fun/any55524 (lambda () #f))
    (define fun/empty55526 (lambda () empty))
    (define fun/ascii-char55521 (lambda () #\c))
    (define fun/vector55522 (lambda () (call fun/vector55523)))
    (define fun/empty55525 (lambda () (call fun/empty55526)))
    (let ((boolean0 (call boolean? (call fun/any55519)))
          (fixnum1
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
          (ascii-char2 (call fun/ascii-char55520))
          (vector3 (call fun/vector55522))
          (boolean4 (call fixnum? (call fun/any55524)))
          (empty5 (call fun/empty55525)))
      vector3)))
(check-by-interp
 '(module
    (define fun/error56381 (lambda () (call fun/error56382)))
    (define fun/void56379 (lambda () (call fun/void56380)))
    (define fun/vector56375 (lambda () (call fun/vector56376)))
    (define fun/error56383 (lambda () (call fun/error56384)))
    (define fun/error56384 (lambda () (error 47)))
    (define fun/ascii-char56386 (lambda () #\c))
    (define fun/error56382 (lambda () (error 76)))
    (define fun/empty56377 (lambda () (call fun/empty56378)))
    (define fun/empty56378 (lambda () empty))
    (define fun/vector56376 (lambda () (call make-vector 8)))
    (define fun/void56380 (lambda () (void)))
    (define fun/ascii-char56385 (lambda () (call fun/ascii-char56386)))
    (let ((vector0 (call fun/vector56375))
          (empty1 (call fun/empty56377))
          (void2 (call fun/void56379))
          (error3 (call fun/error56381))
          (error4 (call fun/error56383))
          (ascii-char5 (call fun/ascii-char56385)))
      error3)))
(check-by-interp
 '(module
    (define fun/ascii-char59064 (lambda () (call fun/ascii-char59065)))
    (define fun/ascii-char59068 (lambda () (call fun/ascii-char59069)))
    (define fun/any59063 (lambda () (void)))
    (define fun/ascii-char59070 (lambda () (call fun/ascii-char59071)))
    (define fun/empty59066 (lambda () (call fun/empty59067)))
    (define fun/ascii-char59065 (lambda () #\c))
    (define fun/empty59067 (lambda () empty))
    (define fun/ascii-char59071 (lambda () #\c))
    (define fun/ascii-char59069 (lambda () #\c))
    (let ((boolean0 (call boolean? (call fun/any59063)))
          (fixnum1
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
          (ascii-char2 (call fun/ascii-char59064))
          (empty3 (call fun/empty59066))
          (ascii-char4 (call fun/ascii-char59068))
          (ascii-char5 (call fun/ascii-char59070)))
      fixnum1)))
(check-by-interp
 '(module
    (define fun/empty59449 (lambda () (call fun/empty59450)))
    (define fun/ascii-char59447 (lambda () (call fun/ascii-char59448)))
    (define fun/error59452 (lambda () (error 26)))
    (define fun/void59454 (lambda () (void)))
    (define fun/empty59450 (lambda () empty))
    (define fun/ascii-char59445 (lambda () (call fun/ascii-char59446)))
    (define fun/ascii-char59446 (lambda () #\c))
    (define fun/void59453 (lambda () (call fun/void59454)))
    (define fun/error59451 (lambda () (call fun/error59452)))
    (define fun/ascii-char59448 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char59445))
          (ascii-char1 (call fun/ascii-char59447))
          (empty2 (call fun/empty59449))
          (error3 (call fun/error59451))
          (fixnum4
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
          (void5 (call fun/void59453)))
      error3)))
(check-by-interp
 '(module
    (define fun/vector59746 (lambda () (call fun/vector59747)))
    (define fun/empty59754 (lambda () (call fun/empty59755)))
    (define fun/void59750 (lambda () (call fun/void59751)))
    (define fun/void59751 (lambda () (void)))
    (define fun/error59752 (lambda () (call fun/error59753)))
    (define fun/empty59749 (lambda () empty))
    (define fun/empty59748 (lambda () (call fun/empty59749)))
    (define fun/empty59755 (lambda () empty))
    (define fun/error59753 (lambda () (error 191)))
    (define fun/vector59747 (lambda () (call make-vector 8)))
    (define fun/ascii-char59756 (lambda () (call fun/ascii-char59757)))
    (define fun/ascii-char59757 (lambda () #\c))
    (let ((vector0 (call fun/vector59746))
          (empty1 (call fun/empty59748))
          (void2 (call fun/void59750))
          (error3 (call fun/error59752))
          (empty4 (call fun/empty59754))
          (ascii-char5 (call fun/ascii-char59756)))
      empty1)))
(check-by-interp
 '(module
    (define fun/empty63444 (lambda () (call fun/empty63445)))
    (define fun/error63448 (lambda () (call fun/error63449)))
    (define fun/ascii-char63446 (lambda () (call fun/ascii-char63447)))
    (define fun/ascii-char63442 (lambda () (call fun/ascii-char63443)))
    (define fun/vector63441 (lambda () (call make-vector 8)))
    (define fun/error63449 (lambda () (error 172)))
    (define fun/empty63445 (lambda () empty))
    (define fun/ascii-char63447 (lambda () #\c))
    (define fun/vector63440 (lambda () (call fun/vector63441)))
    (define fun/ascii-char63443 (lambda () #\c))
    (let ((vector0 (call fun/vector63440))
          (ascii-char1 (call fun/ascii-char63442))
          (empty2 (call fun/empty63444))
          (ascii-char3 (call fun/ascii-char63446))
          (fixnum4
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
          (error5 (call fun/error63448)))
      fixnum4)))
(check-by-interp
 '(module
    (define fun/any65187 (lambda () (call make-vector 8)))
    (define fun/ascii-char65195 (lambda () #\c))
    (define fun/empty65188 (lambda () empty))
    (define fun/empty65198 (lambda () empty))
    (define fun/ascii-char65185 (lambda () #\c))
    (define fun/any65192 (lambda () #t))
    (define fun/ascii-char65190 (lambda () #\c))
    (define fun/error65194 (lambda () (error 182)))
    (define fun/void65196 (lambda () (void)))
    (define fun/any65183 (lambda () (call make-vector 8)))
    (define fun/vector65182 (lambda () (call make-vector 8)))
    (define fun/void65186 (lambda () (void)))
    (define fun/error65197 (lambda () (error 154)))
    (define fun/error65191 (lambda () (error 44)))
    (define fun/vector65193 (lambda () (call make-vector 8)))
    (define fun/vector65184 (lambda () (call make-vector 8)))
    (define fun/ascii-char65189 (lambda () #\c))
    (if (let ((vector0 (call fun/vector65182))
              (boolean1 (call void? (call fun/any65183)))
              (fixnum2 (call - (call * 214 141) (call - 23 250)))
              (vector3 (call fun/vector65184))
              (ascii-char4 (call fun/ascii-char65185))
              (void5 (call fun/void65186)))
          (call boolean? (call fun/any65187)))
      (let ((empty0 (call fun/empty65188))
            (ascii-char1 (call fun/ascii-char65189))
            (fixnum2 (call + (call + 214 231) (call - 100 196)))
            (ascii-char3 (call fun/ascii-char65190))
            (error4 (call fun/error65191))
            (boolean5 (call vector? (call fun/any65192))))
        empty0)
      (let ((vector0 (call fun/vector65193))
            (fixnum1 (call + (call + 205 233) (call - 250 41)))
            (error2 (call fun/error65194))
            (ascii-char3 (call fun/ascii-char65195))
            (void4 (call fun/void65196))
            (error5 (call fun/error65197)))
        (call fun/empty65198)))))
(check-by-interp
 '(module
    (define fun/error65698 (lambda () (error 163)))
    (define fun/ascii-char65700 (lambda () #\c))
    (define fun/ascii-char65699 (lambda () (call fun/ascii-char65700)))
    (define fun/vector65693 (lambda () (call fun/vector65694)))
    (define fun/vector65694 (lambda () (call make-vector 8)))
    (define fun/ascii-char65695 (lambda () (call fun/ascii-char65696)))
    (define fun/ascii-char65696 (lambda () #\c))
    (define fun/error65697 (lambda () (call fun/error65698)))
    (let ((fixnum0
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
          (vector1 (call fun/vector65693))
          (fixnum2
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
          (ascii-char3 (call fun/ascii-char65695))
          (error4 (call fun/error65697))
          (ascii-char5 (call fun/ascii-char65699)))
      (call * fixnum2 fixnum2))))
(check-by-interp
 '(module
    (define fun/empty67816 (lambda () empty))
    (define fun/vector67811 (lambda () (call fun/vector67812)))
    (define fun/any67817 (lambda () empty))
    (define fun/vector67819 (lambda () (call make-vector 8)))
    (define fun/error67814 (lambda () (error 87)))
    (define fun/vector67812 (lambda () (call make-vector 8)))
    (define fun/empty67815 (lambda () (call fun/empty67816)))
    (define fun/vector67818 (lambda () (call fun/vector67819)))
    (define fun/error67813 (lambda () (call fun/error67814)))
    (let ((vector0 (call fun/vector67811))
          (error1 (call fun/error67813))
          (empty2 (call fun/empty67815))
          (boolean3 (call empty? (call fun/any67817)))
          (fixnum4
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
          (vector5 (call fun/vector67818)))
      error1)))
(check-by-interp
 '(module
    (define fun/ascii-char72180 (lambda () (call fun/ascii-char72181)))
    (define fun/ascii-char72175 (lambda () (call fun/ascii-char72176)))
    (define fun/void72177 (lambda () (call fun/void72178)))
    (define fun/ascii-char72181 (lambda () #\c))
    (define fun/void72178 (lambda () (void)))
    (define fun/any72179 (lambda () #\c))
    (define fun/any72182 (lambda () (error 77)))
    (define fun/ascii-char72176 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char72175))
          (void1 (call fun/void72177))
          (boolean2 (call void? (call fun/any72179)))
          (ascii-char3 (call fun/ascii-char72180))
          (boolean4 (call boolean? (call fun/any72182)))
          (fixnum5
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
      ascii-char3)))
(check-by-interp
 '(module
    (define fun/any73111 (lambda () #\c))
    (define fun/vector73119 (lambda () (call make-vector 8)))
    (define fun/empty73114 (lambda () (call fun/empty73115)))
    (define fun/error73113 (lambda () (error 225)))
    (define fun/vector73118 (lambda () (call fun/vector73119)))
    (define fun/empty73116 (lambda () (call fun/empty73117)))
    (define fun/empty73115 (lambda () empty))
    (define fun/empty73117 (lambda () empty))
    (define fun/error73112 (lambda () (call fun/error73113)))
    (let ((fixnum0
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
          (boolean1 (call pair? (call fun/any73111)))
          (error2 (call fun/error73112))
          (empty3 (call fun/empty73114))
          (empty4 (call fun/empty73116))
          (vector5 (call fun/vector73118)))
      empty4)))
(check-by-interp
 '(module
    (define fun/ascii-char73483 (lambda () #\c))
    (define fun/ascii-char73478 (lambda () (call fun/ascii-char73479)))
    (define fun/error73480 (lambda () (call fun/error73481)))
    (define fun/void73474 (lambda () (call fun/void73475)))
    (define fun/error73481 (lambda () (error 144)))
    (define fun/vector73476 (lambda () (call fun/vector73477)))
    (define fun/vector73477 (lambda () (call make-vector 8)))
    (define fun/void73475 (lambda () (void)))
    (define fun/ascii-char73482 (lambda () (call fun/ascii-char73483)))
    (define fun/ascii-char73479 (lambda () #\c))
    (let ((void0 (call fun/void73474))
          (vector1 (call fun/vector73476))
          (ascii-char2 (call fun/ascii-char73478))
          (fixnum3
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
          (error4 (call fun/error73480))
          (ascii-char5 (call fun/ascii-char73482)))
      (call
       *
       (call
        +
        (call - (call + fixnum3 129) (call + 233 81))
        (call + (call * fixnum3 139) (call - 152 165)))
       (call
        *
        (call + (call + fixnum3 fixnum3) (call + 243 fixnum3))
        fixnum3)))))
(check-by-interp
 '(module
    (define fun/ascii-char74214 (lambda () #\c))
    (define fun/ascii-char74212 (lambda () #\c))
    (define fun/vector74218 (lambda () (call make-vector 8)))
    (define fun/error74216 (lambda () (error 152)))
    (define fun/void74210 (lambda () (void)))
    (define fun/ascii-char74211 (lambda () (call fun/ascii-char74212)))
    (define fun/void74209 (lambda () (call fun/void74210)))
    (define fun/error74207 (lambda () (call fun/error74208)))
    (define fun/vector74217 (lambda () (call fun/vector74218)))
    (define fun/ascii-char74213 (lambda () (call fun/ascii-char74214)))
    (define fun/error74208 (lambda () (error 222)))
    (define fun/error74215 (lambda () (call fun/error74216)))
    (let ((error0 (call fun/error74207))
          (void1 (call fun/void74209))
          (ascii-char2 (call fun/ascii-char74211))
          (fixnum3
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
          (ascii-char4 (call fun/ascii-char74213))
          (error5 (call fun/error74215)))
      (call fun/vector74217))))
(check-by-interp
 '(module
    (define fun/error74460 (lambda () (error 77)))
    (define fun/vector74464 (lambda () (call fun/vector74465)))
    (define fun/void74462 (lambda () (void)))
    (define fun/ascii-char74457 (lambda () (call fun/ascii-char74458)))
    (define fun/any74463 (lambda () (void)))
    (define fun/error74459 (lambda () (call fun/error74460)))
    (define fun/void74461 (lambda () (call fun/void74462)))
    (define fun/vector74465 (lambda () (call make-vector 8)))
    (define fun/ascii-char74458 (lambda () #\c))
    (let ((fixnum0
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
          (ascii-char1 (call fun/ascii-char74457))
          (error2 (call fun/error74459))
          (void3 (call fun/void74461))
          (boolean4 (call vector? (call fun/any74463)))
          (vector5 (call fun/vector74464)))
      vector5)))
(check-by-interp
 '(module
    (define fun/empty76147 (lambda () (call fun/empty76148)))
    (define fun/empty76144 (lambda () empty))
    (define fun/ascii-char76150 (lambda () #\c))
    (define fun/void76152 (lambda () (void)))
    (define fun/void76145 (lambda () (call fun/void76146)))
    (define fun/ascii-char76149 (lambda () (call fun/ascii-char76150)))
    (define fun/empty76143 (lambda () (call fun/empty76144)))
    (define fun/void76146 (lambda () (void)))
    (define fun/empty76148 (lambda () empty))
    (define fun/void76151 (lambda () (call fun/void76152)))
    (let ((fixnum0
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
          (empty1 (call fun/empty76143))
          (void2 (call fun/void76145))
          (empty3 (call fun/empty76147))
          (ascii-char4 (call fun/ascii-char76149))
          (void5 (call fun/void76151)))
      (call
       *
       (call * fixnum0 fixnum0)
       (call
        -
        (call + (call - fixnum0 fixnum0) fixnum0)
        (call - fixnum0 (call - 86 fixnum0)))))))
(check-by-interp
 '(module
    (define fun/void77894 (lambda () (void)))
    (define fun/error77897 (lambda () (call fun/error77898)))
    (define fun/vector77892 (lambda () (call make-vector 8)))
    (define fun/empty77895 (lambda () (call fun/empty77896)))
    (define fun/void77893 (lambda () (call fun/void77894)))
    (define fun/ascii-char77890 (lambda () #\c))
    (define fun/ascii-char77888 (lambda () #\c))
    (define fun/empty77896 (lambda () empty))
    (define fun/ascii-char77889 (lambda () (call fun/ascii-char77890)))
    (define fun/ascii-char77887 (lambda () (call fun/ascii-char77888)))
    (define fun/error77898 (lambda () (error 95)))
    (define fun/vector77891 (lambda () (call fun/vector77892)))
    (let ((ascii-char0 (call fun/ascii-char77887))
          (ascii-char1 (call fun/ascii-char77889))
          (vector2 (call fun/vector77891))
          (void3 (call fun/void77893))
          (empty4 (call fun/empty77895))
          (error5 (call fun/error77897)))
      vector2)))
(check-by-interp
 '(module
    (define fun/empty78856 (lambda () empty))
    (define fun/empty78853 (lambda () (call fun/empty78854)))
    (define fun/empty78849 (lambda () (call fun/empty78850)))
    (define fun/vector78851 (lambda () (call fun/vector78852)))
    (define fun/empty78859 (lambda () (call fun/empty78860)))
    (define fun/empty78855 (lambda () (call fun/empty78856)))
    (define fun/empty78860 (lambda () empty))
    (define fun/error78857 (lambda () (call fun/error78858)))
    (define fun/empty78854 (lambda () empty))
    (define fun/vector78852 (lambda () (call make-vector 8)))
    (define fun/error78858 (lambda () (error 90)))
    (define fun/empty78850 (lambda () empty))
    (let ((empty0 (call fun/empty78849))
          (vector1 (call fun/vector78851))
          (empty2 (call fun/empty78853))
          (empty3 (call fun/empty78855))
          (error4 (call fun/error78857))
          (empty5 (call fun/empty78859)))
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
    (define fun/void80571 (lambda () (void)))
    (define fun/error80566 (lambda () (call fun/error80567)))
    (define fun/ascii-char80576 (lambda () #\c))
    (define fun/vector80574 (lambda () (call make-vector 8)))
    (define fun/void80568 (lambda () (call fun/void80569)))
    (define fun/void80570 (lambda () (call fun/void80571)))
    (define fun/void80569 (lambda () (void)))
    (define fun/ascii-char80575 (lambda () (call fun/ascii-char80576)))
    (define fun/error80567 (lambda () (error 139)))
    (define fun/any80572 (lambda () (error 41)))
    (define fun/vector80573 (lambda () (call fun/vector80574)))
    (let ((error0 (call fun/error80566))
          (void1 (call fun/void80568))
          (void2 (call fun/void80570))
          (boolean3 (call pair? (call fun/any80572)))
          (vector4 (call fun/vector80573))
          (ascii-char5 (call fun/ascii-char80575)))
      vector4)))
(check-by-interp
 '(module
    (define fun/ascii-char81022 (lambda () (call fun/ascii-char81023)))
    (define fun/ascii-char81023 (lambda () #\c))
    (define fun/void81027 (lambda () (void)))
    (define fun/error81021 (lambda () (error 17)))
    (define fun/empty81025 (lambda () empty))
    (define fun/vector81019 (lambda () (call make-vector 8)))
    (define fun/error81020 (lambda () (call fun/error81021)))
    (define fun/vector81018 (lambda () (call fun/vector81019)))
    (define fun/void81026 (lambda () (call fun/void81027)))
    (define fun/empty81024 (lambda () (call fun/empty81025)))
    (let ((vector0 (call fun/vector81018))
          (error1 (call fun/error81020))
          (fixnum2
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
          (ascii-char3 (call fun/ascii-char81022))
          (empty4 (call fun/empty81024))
          (void5 (call fun/void81026)))
      error1)))
(check-by-interp
 '(module
    (define fun/empty82623 (lambda () empty))
    (define fun/void82617 (lambda () (void)))
    (define fun/error82624 (lambda () (call fun/error82625)))
    (define fun/error82625 (lambda () (error 232)))
    (define fun/ascii-char82621 (lambda () #\c))
    (define fun/error82619 (lambda () (error 156)))
    (define fun/error82618 (lambda () (call fun/error82619)))
    (define fun/ascii-char82627 (lambda () #\c))
    (define fun/empty82622 (lambda () (call fun/empty82623)))
    (define fun/ascii-char82620 (lambda () (call fun/ascii-char82621)))
    (define fun/ascii-char82626 (lambda () (call fun/ascii-char82627)))
    (define fun/void82616 (lambda () (call fun/void82617)))
    (let ((void0 (call fun/void82616))
          (error1 (call fun/error82618))
          (ascii-char2 (call fun/ascii-char82620))
          (empty3 (call fun/empty82622))
          (error4 (call fun/error82624))
          (ascii-char5 (call fun/ascii-char82626)))
      empty3)))
(check-by-interp
 '(module
    (define fun/void83998 (lambda () (call fun/void83999)))
    (define fun/error83996 (lambda () (call fun/error83997)))
    (define fun/void83994 (lambda () (call fun/void83995)))
    (define fun/ascii-char84001 (lambda () #\c))
    (define fun/void83995 (lambda () (void)))
    (define fun/vector83993 (lambda () (call make-vector 8)))
    (define fun/error83997 (lambda () (error 70)))
    (define fun/ascii-char84000 (lambda () (call fun/ascii-char84001)))
    (define fun/void83999 (lambda () (void)))
    (define fun/vector83992 (lambda () (call fun/vector83993)))
    (let ((vector0 (call fun/vector83992))
          (void1 (call fun/void83994))
          (error2 (call fun/error83996))
          (void3 (call fun/void83998))
          (ascii-char4 (call fun/ascii-char84000))
          (fixnum5
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
        (call + fixnum5 (call + fixnum5 fixnum5))
        (call - fixnum5 (call - 104 145)))
       (call + (call - (call + 163 26) (call * 134 fixnum5)) fixnum5)))))
(check-by-interp
 '(module
    (define fun/void85079 (lambda () (void)))
    (define fun/empty85084 (lambda () (call fun/empty85085)))
    (define fun/empty85082 (lambda () (call fun/empty85083)))
    (define fun/error85087 (lambda () (error 196)))
    (define fun/empty85085 (lambda () empty))
    (define fun/error85080 (lambda () (call fun/error85081)))
    (define fun/void85078 (lambda () (call fun/void85079)))
    (define fun/any85077 (lambda () (call make-vector 8)))
    (define fun/error85086 (lambda () (call fun/error85087)))
    (define fun/empty85083 (lambda () empty))
    (define fun/error85081 (lambda () (error 171)))
    (let ((boolean0 (call void? (call fun/any85077)))
          (void1 (call fun/void85078))
          (error2 (call fun/error85080))
          (empty3 (call fun/empty85082))
          (empty4 (call fun/empty85084))
          (error5 (call fun/error85086)))
      empty4)))
(check-by-interp
 '(module
    (define fun/empty86109 (lambda () (call fun/empty86110)))
    (define fun/vector86106 (lambda () (call make-vector 8)))
    (define fun/vector86112 (lambda () (call make-vector 8)))
    (define fun/void86115 (lambda () (call fun/void86116)))
    (define fun/empty86108 (lambda () empty))
    (define fun/ascii-char86113 (lambda () (call fun/ascii-char86114)))
    (define fun/void86116 (lambda () (void)))
    (define fun/ascii-char86114 (lambda () #\c))
    (define fun/vector86111 (lambda () (call fun/vector86112)))
    (define fun/empty86110 (lambda () empty))
    (define fun/vector86105 (lambda () (call fun/vector86106)))
    (define fun/empty86107 (lambda () (call fun/empty86108)))
    (let ((vector0 (call fun/vector86105))
          (empty1 (call fun/empty86107))
          (empty2 (call fun/empty86109))
          (vector3 (call fun/vector86111))
          (ascii-char4 (call fun/ascii-char86113))
          (void5 (call fun/void86115)))
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
    (define fun/void86192 (lambda () (void)))
    (define fun/vector86197 (lambda () (call fun/vector86198)))
    (define fun/empty86194 (lambda () empty))
    (define fun/void86191 (lambda () (call fun/void86192)))
    (define fun/empty86193 (lambda () (call fun/empty86194)))
    (define fun/vector86196 (lambda () (call make-vector 8)))
    (define fun/vector86195 (lambda () (call fun/vector86196)))
    (define fun/vector86198 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void86191))
          (fixnum1
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
          (empty2 (call fun/empty86193))
          (fixnum3
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
          (vector4 (call fun/vector86195))
          (vector5 (call fun/vector86197)))
      empty2)))
(check-by-interp
 '(module
    (define fun/empty86209 (lambda () (call fun/empty86210)))
    (define fun/void86206 (lambda () (void)))
    (define fun/ascii-char86207 (lambda () (call fun/ascii-char86208)))
    (define fun/empty86211 (lambda () (call fun/empty86212)))
    (define fun/empty86201 (lambda () (call fun/empty86202)))
    (define fun/error86214 (lambda () (error 83)))
    (define fun/void86205 (lambda () (call fun/void86206)))
    (define fun/empty86203 (lambda () (call fun/empty86204)))
    (define fun/empty86202 (lambda () empty))
    (define fun/empty86210 (lambda () empty))
    (define fun/empty86204 (lambda () empty))
    (define fun/ascii-char86208 (lambda () #\c))
    (define fun/empty86212 (lambda () empty))
    (define fun/error86213 (lambda () (call fun/error86214)))
    (let ((empty0 (call fun/empty86201))
          (empty1 (call fun/empty86203))
          (void2 (call fun/void86205))
          (ascii-char3 (call fun/ascii-char86207))
          (empty4 (call fun/empty86209))
          (empty5 (call fun/empty86211)))
      (call fun/error86213))))
(check-by-interp
 '(module
    (define fun/empty87364 (lambda () (call fun/empty87365)))
    (define fun/vector87371 (lambda () (call fun/vector87372)))
    (define fun/void87367 (lambda () (call fun/void87368)))
    (define fun/vector87369 (lambda () (call fun/vector87370)))
    (define fun/any87366 (lambda () (void)))
    (define fun/empty87365 (lambda () empty))
    (define fun/empty87363 (lambda () empty))
    (define fun/empty87362 (lambda () (call fun/empty87363)))
    (define fun/vector87370 (lambda () (call make-vector 8)))
    (define fun/void87368 (lambda () (void)))
    (define fun/vector87372 (lambda () (call make-vector 8)))
    (let ((empty0 (call fun/empty87362))
          (empty1 (call fun/empty87364))
          (boolean2 (call boolean? (call fun/any87366)))
          (void3 (call fun/void87367))
          (vector4 (call fun/vector87369))
          (vector5 (call fun/vector87371)))
      empty0)))
(check-by-interp
 '(module
    (define fun/error87568 (lambda () (error 156)))
    (define fun/empty87561 (lambda () (call fun/empty87562)))
    (define fun/empty87562 (lambda () empty))
    (define fun/error87567 (lambda () (call fun/error87568)))
    (define fun/any87569 (lambda () empty))
    (define fun/void87565 (lambda () (call fun/void87566)))
    (define fun/error87571 (lambda () (error 120)))
    (define fun/ascii-char87572 (lambda () (call fun/ascii-char87573)))
    (define fun/vector87563 (lambda () (call fun/vector87564)))
    (define fun/ascii-char87573 (lambda () #\c))
    (define fun/void87566 (lambda () (void)))
    (define fun/vector87564 (lambda () (call make-vector 8)))
    (define fun/error87570 (lambda () (call fun/error87571)))
    (let ((empty0 (call fun/empty87561))
          (vector1 (call fun/vector87563))
          (void2 (call fun/void87565))
          (error3 (call fun/error87567))
          (boolean4 (call fixnum? (call fun/any87569)))
          (error5 (call fun/error87570)))
      (call fun/ascii-char87572))))
(check-by-interp
 '(module
    (define fun/any89588 (lambda () 230))
    (define fun/void89590 (lambda () (void)))
    (define fun/void89587 (lambda () (void)))
    (define fun/error89592 (lambda () (error 21)))
    (define fun/void89594 (lambda () (void)))
    (define fun/void89595 (lambda () (call fun/void89596)))
    (define fun/void89586 (lambda () (call fun/void89587)))
    (define fun/void89596 (lambda () (void)))
    (define fun/error89591 (lambda () (call fun/error89592)))
    (define fun/void89593 (lambda () (call fun/void89594)))
    (define fun/void89589 (lambda () (call fun/void89590)))
    (let ((void0 (call fun/void89586))
          (boolean1 (call empty? (call fun/any89588)))
          (void2 (call fun/void89589))
          (error3 (call fun/error89591))
          (void4 (call fun/void89593))
          (void5 (call fun/void89595)))
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
    (define fun/vector90477 (lambda () (call fun/vector90478)))
    (define fun/vector90476 (lambda () (call make-vector 8)))
    (define fun/error90481 (lambda () (error 227)))
    (define fun/vector90478 (lambda () (call make-vector 8)))
    (define fun/void90483 (lambda () (void)))
    (define fun/any90479 (lambda () empty))
    (define fun/void90482 (lambda () (call fun/void90483)))
    (define fun/vector90475 (lambda () (call fun/vector90476)))
    (define fun/ascii-char90485 (lambda () #\c))
    (define fun/ascii-char90484 (lambda () (call fun/ascii-char90485)))
    (define fun/error90480 (lambda () (call fun/error90481)))
    (let ((vector0 (call fun/vector90475))
          (vector1 (call fun/vector90477))
          (boolean2 (call empty? (call fun/any90479)))
          (error3 (call fun/error90480))
          (void4 (call fun/void90482))
          (fixnum5
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
      (call fun/ascii-char90484))))
(check-by-interp
 '(module
    (define fun/ascii-char91899 (lambda () #\c))
    (define fun/ascii-char91896 (lambda () (call fun/ascii-char91897)))
    (define fun/empty91891 (lambda () empty))
    (define fun/empty91890 (lambda () (call fun/empty91891)))
    (define fun/ascii-char91892 (lambda () (call fun/ascii-char91893)))
    (define fun/ascii-char91898 (lambda () (call fun/ascii-char91899)))
    (define fun/ascii-char91894 (lambda () (call fun/ascii-char91895)))
    (define fun/error91900 (lambda () (call fun/error91901)))
    (define fun/ascii-char91897 (lambda () #\c))
    (define fun/error91901 (lambda () (error 129)))
    (define fun/ascii-char91895 (lambda () #\c))
    (define fun/ascii-char91893 (lambda () #\c))
    (let ((empty0 (call fun/empty91890))
          (ascii-char1 (call fun/ascii-char91892))
          (ascii-char2 (call fun/ascii-char91894))
          (ascii-char3 (call fun/ascii-char91896))
          (ascii-char4 (call fun/ascii-char91898))
          (error5 (call fun/error91900)))
      empty0)))
(check-by-interp
 '(module
    (define fun/error92012 (lambda () (call fun/error92013)))
    (define fun/any92007 (lambda () (call make-vector 8)))
    (define fun/empty92016 (lambda () (call fun/empty92017)))
    (define fun/void92014 (lambda () (call fun/void92015)))
    (define fun/void92011 (lambda () (void)))
    (define fun/ascii-char92008 (lambda () (call fun/ascii-char92009)))
    (define fun/error92013 (lambda () (error 169)))
    (define fun/void92010 (lambda () (call fun/void92011)))
    (define fun/empty92017 (lambda () empty))
    (define fun/void92015 (lambda () (void)))
    (define fun/ascii-char92009 (lambda () #\c))
    (let ((fixnum0
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
          (boolean1 (call fixnum? (call fun/any92007)))
          (ascii-char2 (call fun/ascii-char92008))
          (void3 (call fun/void92010))
          (error4 (call fun/error92012))
          (void5 (call fun/void92014)))
      (call fun/empty92016))))
(check-by-interp
 '(module
    (define fun/ascii-char92849 (lambda () #\c))
    (define fun/empty92859 (lambda () empty))
    (define fun/void92853 (lambda () (void)))
    (define fun/ascii-char92857 (lambda () #\c))
    (define fun/empty92858 (lambda () (call fun/empty92859)))
    (define fun/vector92855 (lambda () (call make-vector 8)))
    (define fun/vector92854 (lambda () (call fun/vector92855)))
    (define fun/ascii-char92856 (lambda () (call fun/ascii-char92857)))
    (define fun/error92850 (lambda () (call fun/error92851)))
    (define fun/ascii-char92848 (lambda () (call fun/ascii-char92849)))
    (define fun/error92851 (lambda () (error 220)))
    (define fun/void92852 (lambda () (call fun/void92853)))
    (let ((ascii-char0 (call fun/ascii-char92848))
          (fixnum1
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
          (error2 (call fun/error92850))
          (void3 (call fun/void92852))
          (vector4 (call fun/vector92854))
          (ascii-char5 (call fun/ascii-char92856)))
      (call fun/empty92858))))
(check-by-interp
 '(module
    (define fun/empty93185 (lambda () (call fun/empty93186)))
    (define fun/void93187 (lambda () (call fun/void93188)))
    (define fun/error93189 (lambda () (call fun/error93190)))
    (define fun/error93190 (lambda () (error 38)))
    (define fun/void93193 (lambda () (call fun/void93194)))
    (define fun/empty93186 (lambda () empty))
    (define fun/error93192 (lambda () (error 77)))
    (define fun/void93188 (lambda () (void)))
    (define fun/void93194 (lambda () (void)))
    (define fun/error93191 (lambda () (call fun/error93192)))
    (let ((empty0 (call fun/empty93185))
          (void1 (call fun/void93187))
          (fixnum2
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
          (error3 (call fun/error93189))
          (error4 (call fun/error93191))
          (void5 (call fun/void93193)))
      (call
       +
       (call
        -
        (call + fixnum2 fixnum2)
        (call + (call * fixnum2 183) (call * fixnum2 219)))
       (call - fixnum2 fixnum2)))))
(check-by-interp
 '(module
    (define fun/any95251 (lambda () 92))
    (define fun/error95248 (lambda () (call fun/error95249)))
    (define fun/error95247 (lambda () (error 229)))
    (define fun/any95253 (lambda () #\c))
    (define fun/vector95254 (lambda () (call fun/vector95255)))
    (define fun/any95252 (lambda () (call make-vector 8)))
    (define fun/vector95255 (lambda () (call make-vector 8)))
    (define fun/any95250 (lambda () (call make-vector 8)))
    (define fun/error95249 (lambda () (error 61)))
    (define fun/error95246 (lambda () (call fun/error95247)))
    (let ((error0 (call fun/error95246))
          (error1 (call fun/error95248))
          (boolean2 (call vector? (call fun/any95250)))
          (boolean3 (call void? (call fun/any95251)))
          (boolean4 (call empty? (call fun/any95252)))
          (boolean5 (call empty? (call fun/any95253))))
      (call fun/vector95254))))
(check-by-interp
 '(module
    (define fun/empty98518 (lambda () (call fun/empty98519)))
    (define fun/error98520 (lambda () (call fun/error98521)))
    (define fun/error98521 (lambda () (error 37)))
    (define fun/vector98514 (lambda () (call fun/vector98515)))
    (define fun/empty98517 (lambda () empty))
    (define fun/error98522 (lambda () (call fun/error98523)))
    (define fun/empty98516 (lambda () (call fun/empty98517)))
    (define fun/vector98515 (lambda () (call make-vector 8)))
    (define fun/empty98519 (lambda () empty))
    (define fun/error98523 (lambda () (error 61)))
    (let ((fixnum0
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
          (vector1 (call fun/vector98514))
          (empty2 (call fun/empty98516))
          (empty3 (call fun/empty98518))
          (error4 (call fun/error98520))
          (error5 (call fun/error98522)))
      (call
       -
       fixnum0
       (call * fixnum0 (call - (call - 191 3) (call + 227 fixnum0)))))))
(check-by-interp
 '(module
    (define fun/vector98535 (lambda () (call make-vector 8)))
    (define fun/empty98532 (lambda () (call fun/empty98533)))
    (define fun/error98527 (lambda () (error 171)))
    (define fun/error98526 (lambda () (call fun/error98527)))
    (define fun/ascii-char98536 (lambda () (call fun/ascii-char98537)))
    (define fun/vector98530 (lambda () (call fun/vector98531)))
    (define fun/empty98529 (lambda () empty))
    (define fun/vector98534 (lambda () (call fun/vector98535)))
    (define fun/ascii-char98537 (lambda () #\c))
    (define fun/vector98531 (lambda () (call make-vector 8)))
    (define fun/empty98528 (lambda () (call fun/empty98529)))
    (define fun/empty98533 (lambda () empty))
    (let ((fixnum0
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
          (error1 (call fun/error98526))
          (empty2 (call fun/empty98528))
          (vector3 (call fun/vector98530))
          (empty4 (call fun/empty98532))
          (vector5 (call fun/vector98534)))
      (call fun/ascii-char98536))))
(check-by-interp
 '(module
    (define fun/void98954 (lambda () (call fun/void98955)))
    (define fun/error98959 (lambda () (error 156)))
    (define fun/error98952 (lambda () (call fun/error98953)))
    (define fun/vector98960 (lambda () (call fun/vector98961)))
    (define fun/vector98956 (lambda () (call fun/vector98957)))
    (define fun/error98953 (lambda () (error 220)))
    (define fun/vector98957 (lambda () (call make-vector 8)))
    (define fun/error98958 (lambda () (call fun/error98959)))
    (define fun/vector98961 (lambda () (call make-vector 8)))
    (define fun/void98955 (lambda () (void)))
    (let ((error0 (call fun/error98952))
          (fixnum1
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
          (void2 (call fun/void98954))
          (vector3 (call fun/vector98956))
          (error4 (call fun/error98958))
          (vector5 (call fun/vector98960)))
      (call
       +
       (call
        -
        (call + (call * fixnum1 243) (call - fixnum1 154))
        (call + (call * fixnum1 226) (call + 40 70)))
       (call - fixnum1 (call * (call + 6 fixnum1) fixnum1))))))
(check-by-interp
 '(module
    (define fun/empty101495 (lambda () (call fun/empty101496)))
    (define fun/ascii-char101493 (lambda () (call fun/ascii-char101494)))
    (define fun/vector101492 (lambda () (call make-vector 8)))
    (define fun/error101498 (lambda () (call fun/error101499)))
    (define fun/error101499 (lambda () (error 7)))
    (define fun/vector101491 (lambda () (call fun/vector101492)))
    (define fun/error101489 (lambda () (call fun/error101490)))
    (define fun/any101497 (lambda () empty))
    (define fun/empty101496 (lambda () empty))
    (define fun/ascii-char101494 (lambda () #\c))
    (define fun/error101490 (lambda () (error 115)))
    (let ((error0 (call fun/error101489))
          (vector1 (call fun/vector101491))
          (ascii-char2 (call fun/ascii-char101493))
          (empty3 (call fun/empty101495))
          (boolean4 (call void? (call fun/any101497)))
          (error5 (call fun/error101498)))
      error0)))
(check-by-interp
 '(module
    (define fun/vector102190 (lambda () (call fun/vector102191)))
    (define fun/any102185 (lambda () empty))
    (define fun/vector102188 (lambda () (call fun/vector102189)))
    (define fun/ascii-char102187 (lambda () #\c))
    (define fun/vector102189 (lambda () (call make-vector 8)))
    (define fun/ascii-char102186 (lambda () (call fun/ascii-char102187)))
    (define fun/vector102191 (lambda () (call make-vector 8)))
    (let ((boolean0 (call vector? (call fun/any102185)))
          (fixnum1
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
          (ascii-char2 (call fun/ascii-char102186))
          (vector3 (call fun/vector102188))
          (fixnum4
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
          (vector5 (call fun/vector102190)))
      fixnum1)))
(check-by-interp
 '(module
    (define fun/vector102621 (lambda () (call fun/vector102622)))
    (define fun/ascii-char102628 (lambda () #\c))
    (define fun/ascii-char102625 (lambda () (call fun/ascii-char102626)))
    (define fun/vector102623 (lambda () (call fun/vector102624)))
    (define fun/empty102620 (lambda () empty))
    (define fun/empty102619 (lambda () (call fun/empty102620)))
    (define fun/ascii-char102626 (lambda () #\c))
    (define fun/vector102624 (lambda () (call make-vector 8)))
    (define fun/ascii-char102627 (lambda () (call fun/ascii-char102628)))
    (define fun/vector102622 (lambda () (call make-vector 8)))
    (let ((fixnum0
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
          (empty1 (call fun/empty102619))
          (vector2 (call fun/vector102621))
          (vector3 (call fun/vector102623))
          (ascii-char4 (call fun/ascii-char102625))
          (ascii-char5 (call fun/ascii-char102627)))
      vector3)))
(check-by-interp
 '(module
    (define fun/empty102764 (lambda () empty))
    (define fun/error102771 (lambda () (call fun/error102772)))
    (define fun/vector102766 (lambda () (call make-vector 8)))
    (define fun/void102768 (lambda () (void)))
    (define fun/void102767 (lambda () (call fun/void102768)))
    (define fun/ascii-char102770 (lambda () #\c))
    (define fun/empty102763 (lambda () (call fun/empty102764)))
    (define fun/error102772 (lambda () (error 217)))
    (define fun/ascii-char102769 (lambda () (call fun/ascii-char102770)))
    (define fun/vector102765 (lambda () (call fun/vector102766)))
    (let ((empty0 (call fun/empty102763))
          (fixnum1
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
          (vector2 (call fun/vector102765))
          (void3 (call fun/void102767))
          (ascii-char4 (call fun/ascii-char102769))
          (error5 (call fun/error102771)))
      vector2)))
(check-by-interp
 '(module
    (define fun/ascii-char103343 (lambda () #\c))
    (define fun/error103339 (lambda () (call fun/error103340)))
    (define fun/ascii-char103337 (lambda () (call fun/ascii-char103338)))
    (define fun/error103340 (lambda () (error 162)))
    (define fun/ascii-char103342 (lambda () (call fun/ascii-char103343)))
    (define fun/empty103336 (lambda () empty))
    (define fun/any103341 (lambda () #t))
    (define fun/empty103335 (lambda () (call fun/empty103336)))
    (define fun/ascii-char103338 (lambda () #\c))
    (let ((empty0 (call fun/empty103335))
          (ascii-char1 (call fun/ascii-char103337))
          (fixnum2
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
          (error3 (call fun/error103339))
          (boolean4 (call vector? (call fun/any103341)))
          (ascii-char5 (call fun/ascii-char103342)))
      error3)))
(check-by-interp
 '(module
    (define fun/empty105765 (lambda () empty))
    (define fun/void105770 (lambda () (call fun/void105771)))
    (define fun/any105774 (lambda () (call make-vector 8)))
    (define fun/error105773 (lambda () (error 62)))
    (define fun/empty105766 (lambda () (call fun/empty105767)))
    (define fun/empty105764 (lambda () (call fun/empty105765)))
    (define fun/empty105767 (lambda () empty))
    (define fun/ascii-char105769 (lambda () #\c))
    (define fun/error105772 (lambda () (call fun/error105773)))
    (define fun/void105771 (lambda () (void)))
    (define fun/ascii-char105768 (lambda () (call fun/ascii-char105769)))
    (let ((empty0 (call fun/empty105764))
          (empty1 (call fun/empty105766))
          (ascii-char2 (call fun/ascii-char105768))
          (void3 (call fun/void105770))
          (error4 (call fun/error105772))
          (boolean5 (call vector? (call fun/any105774))))
      empty0)))
(check-by-interp
 '(module
    (define fun/void107063 (lambda () (void)))
    (define fun/any107059 (lambda () (call make-vector 8)))
    (define fun/ascii-char107061 (lambda () #\c))
    (define fun/void107062 (lambda () (call fun/void107063)))
    (define fun/vector107064 (lambda () (call fun/vector107065)))
    (define fun/ascii-char107060 (lambda () (call fun/ascii-char107061)))
    (define fun/vector107065 (lambda () (call make-vector 8)))
    (let ((boolean0 (call void? (call fun/any107059)))
          (fixnum1
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
          (ascii-char2 (call fun/ascii-char107060))
          (void3 (call fun/void107062))
          (vector4 (call fun/vector107064))
          (fixnum5
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
      void3)))
(check-by-interp
 '(module
    (define fun/any109024 (lambda () (void)))
    (define fun/vector109029 (lambda () (call fun/vector109030)))
    (define fun/vector109027 (lambda () (call fun/vector109028)))
    (define fun/void109025 (lambda () (call fun/void109026)))
    (define fun/void109032 (lambda () (void)))
    (define fun/vector109028 (lambda () (call make-vector 8)))
    (define fun/void109026 (lambda () (void)))
    (define fun/vector109030 (lambda () (call make-vector 8)))
    (define fun/void109031 (lambda () (call fun/void109032)))
    (let ((boolean0 (call error? (call fun/any109024)))
          (void1 (call fun/void109025))
          (vector2 (call fun/vector109027))
          (vector3 (call fun/vector109029))
          (void4 (call fun/void109031))
          (fixnum5
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
      void1)))
(check-by-interp
 '(module
    (define fun/vector111008 (lambda () (call fun/vector111009)))
    (define fun/vector111009 (lambda () (call make-vector 8)))
    (define fun/ascii-char111007 (lambda () #\c))
    (define fun/ascii-char111001 (lambda () (call fun/ascii-char111002)))
    (define fun/error111010 (lambda () (call fun/error111011)))
    (define fun/error111011 (lambda () (error 179)))
    (define fun/any111003 (lambda () (error 72)))
    (define fun/ascii-char111006 (lambda () (call fun/ascii-char111007)))
    (define fun/void111005 (lambda () (void)))
    (define fun/void111004 (lambda () (call fun/void111005)))
    (define fun/ascii-char111002 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char111001))
          (boolean1 (call empty? (call fun/any111003)))
          (void2 (call fun/void111004))
          (ascii-char3 (call fun/ascii-char111006))
          (fixnum4
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
          (vector5 (call fun/vector111008)))
      (call fun/error111010))))
(check-by-interp
 '(module
    (define fun/void111249 (lambda () (call fun/void111250)))
    (define fun/error111259 (lambda () (error 143)))
    (define fun/error111258 (lambda () (call fun/error111259)))
    (define fun/any111257 (lambda () empty))
    (define fun/ascii-char111255 (lambda () (call fun/ascii-char111256)))
    (define fun/error111254 (lambda () (error 228)))
    (define fun/error111253 (lambda () (call fun/error111254)))
    (define fun/ascii-char111251 (lambda () (call fun/ascii-char111252)))
    (define fun/ascii-char111256 (lambda () #\c))
    (define fun/ascii-char111252 (lambda () #\c))
    (define fun/void111250 (lambda () (void)))
    (let ((void0 (call fun/void111249))
          (ascii-char1 (call fun/ascii-char111251))
          (error2 (call fun/error111253))
          (ascii-char3 (call fun/ascii-char111255))
          (boolean4 (call fixnum? (call fun/any111257)))
          (error5 (call fun/error111258)))
      error2)))
(check-by-interp
 '(module
    (define fun/void112730 (lambda () (call fun/void112731)))
    (define fun/ascii-char112724 (lambda () (call fun/ascii-char112725)))
    (define fun/void112726 (lambda () (call fun/void112727)))
    (define fun/empty112733 (lambda () empty))
    (define fun/void112731 (lambda () (void)))
    (define fun/ascii-char112725 (lambda () #\c))
    (define fun/void112728 (lambda () (call fun/void112729)))
    (define fun/empty112732 (lambda () (call fun/empty112733)))
    (define fun/void112729 (lambda () (void)))
    (define fun/void112727 (lambda () (void)))
    (let ((ascii-char0 (call fun/ascii-char112724))
          (void1 (call fun/void112726))
          (void2 (call fun/void112728))
          (fixnum3
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
          (void4 (call fun/void112730))
          (empty5 (call fun/empty112732)))
      (call
       +
       (call * (call + fixnum3 (call - fixnum3 149)) fixnum3)
       (call * fixnum3 (call * (call + fixnum3 39) fixnum3))))))
(check-by-interp
 '(module
    (define fun/vector114088 (lambda () (call make-vector 8)))
    (define fun/error114092 (lambda () (call fun/error114093)))
    (define fun/ascii-char114094 (lambda () (call fun/ascii-char114095)))
    (define fun/error114091 (lambda () (error 173)))
    (define fun/ascii-char114095 (lambda () #\c))
    (define fun/error114093 (lambda () (error 116)))
    (define fun/vector114087 (lambda () (call fun/vector114088)))
    (define fun/error114090 (lambda () (call fun/error114091)))
    (define fun/any114089 (lambda () (error 188)))
    (let ((vector0 (call fun/vector114087))
          (boolean1 (call fixnum? (call fun/any114089)))
          (error2 (call fun/error114090))
          (fixnum3
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
          (error4 (call fun/error114092))
          (fixnum5
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
      (call fun/ascii-char114094))))
(check-by-interp
 '(module
    (define fun/ascii-char117132 (lambda () (call fun/ascii-char117133)))
    (define fun/ascii-char117129 (lambda () #\c))
    (define fun/ascii-char117130 (lambda () (call fun/ascii-char117131)))
    (define fun/ascii-char117128 (lambda () (call fun/ascii-char117129)))
    (define fun/ascii-char117131 (lambda () #\c))
    (define fun/ascii-char117133 (lambda () #\c))
    (let ((ascii-char0 (call fun/ascii-char117128))
          (fixnum1
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
          (ascii-char2 (call fun/ascii-char117130))
          (fixnum3
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
          (ascii-char4 (call fun/ascii-char117132))
          (fixnum5
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
      ascii-char0)))
(check-by-interp
 '(module
    (define fun/void117486 (lambda () (void)))
    (define fun/any117487 (lambda () #f))
    (define fun/void117490 (lambda () (call fun/void117491)))
    (define fun/error117483 (lambda () (call fun/error117484)))
    (define fun/empty117489 (lambda () empty))
    (define fun/void117485 (lambda () (call fun/void117486)))
    (define fun/empty117488 (lambda () (call fun/empty117489)))
    (define fun/void117491 (lambda () (void)))
    (define fun/error117484 (lambda () (error 20)))
    (let ((fixnum0
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
          (error1 (call fun/error117483))
          (void2 (call fun/void117485))
          (boolean3 (call empty? (call fun/any117487)))
          (empty4 (call fun/empty117488))
          (void5 (call fun/void117490)))
      empty4)))
(check-by-interp
 '(module
    (define fun/empty117767 (lambda () empty))
    (define fun/error117761 (lambda () (error 80)))
    (define fun/ascii-char117765 (lambda () #\c))
    (define fun/error117762 (lambda () (call fun/error117763)))
    (define fun/vector117769 (lambda () (call make-vector 8)))
    (define fun/error117763 (lambda () (error 81)))
    (define fun/error117760 (lambda () (call fun/error117761)))
    (define fun/empty117766 (lambda () (call fun/empty117767)))
    (define fun/ascii-char117764 (lambda () (call fun/ascii-char117765)))
    (define fun/vector117768 (lambda () (call fun/vector117769)))
    (let ((error0 (call fun/error117760))
          (error1 (call fun/error117762))
          (fixnum2
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
          (ascii-char3 (call fun/ascii-char117764))
          (empty4 (call fun/empty117766))
          (fixnum5
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
      (call fun/vector117768))))
(check-by-interp
 '(module
    (define fun/void118048 (lambda () (call fun/void118049)))
    (define fun/ascii-char118051 (lambda () #\c))
    (define fun/void118045 (lambda () (void)))
    (define fun/error118053 (lambda () (error 186)))
    (define fun/void118049 (lambda () (void)))
    (define fun/void118046 (lambda () (call fun/void118047)))
    (define fun/void118044 (lambda () (call fun/void118045)))
    (define fun/void118047 (lambda () (void)))
    (define fun/error118052 (lambda () (call fun/error118053)))
    (define fun/ascii-char118050 (lambda () (call fun/ascii-char118051)))
    (let ((void0 (call fun/void118044))
          (void1 (call fun/void118046))
          (void2 (call fun/void118048))
          (ascii-char3 (call fun/ascii-char118050))
          (error4 (call fun/error118052))
          (fixnum5
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
      ascii-char3)))
(check-by-interp
 '(module
    (define fun/void123827 (lambda () (call fun/void123828)))
    (define fun/empty123825 (lambda () (call fun/empty123826)))
    (define fun/empty123831 (lambda () (call fun/empty123832)))
    (define fun/error123823 (lambda () (call fun/error123824)))
    (define fun/void123828 (lambda () (void)))
    (define fun/any123822 (lambda () #\c))
    (define fun/empty123826 (lambda () empty))
    (define fun/error123830 (lambda () (error 167)))
    (define fun/error123829 (lambda () (call fun/error123830)))
    (define fun/ascii-char123833 (lambda () (call fun/ascii-char123834)))
    (define fun/empty123832 (lambda () empty))
    (define fun/error123824 (lambda () (error 125)))
    (define fun/ascii-char123834 (lambda () #\c))
    (let ((boolean0 (call pair? (call fun/any123822)))
          (error1 (call fun/error123823))
          (empty2 (call fun/empty123825))
          (void3 (call fun/void123827))
          (error4 (call fun/error123829))
          (empty5 (call fun/empty123831)))
      (call fun/ascii-char123833))))
(check-by-interp
 '(module
    (define fun/empty126710 (lambda () empty))
    (define fun/empty126709 (lambda () (call fun/empty126710)))
    (define fun/any126713 (lambda () #\c))
    (define fun/any126711 (lambda () 148))
    (define fun/any126712 (lambda () (void)))
    (let ((fixnum0
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
          (empty1 (call fun/empty126709))
          (boolean2 (call void? (call fun/any126711)))
          (fixnum3
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
          (boolean4 (call boolean? (call fun/any126712)))
          (boolean5 (call error? (call fun/any126713))))
      (call - fixnum3 (call + (call * fixnum0 fixnum3) fixnum0)))))
(check-by-interp
 '(module
    (define fun/any127352 (lambda () (void)))
    (define fun/empty127355 (lambda () (call fun/empty127356)))
    (define fun/vector127354 (lambda () (call make-vector 8)))
    (define fun/ascii-char127346 (lambda () (call fun/ascii-char127347)))
    (define fun/empty127350 (lambda () (call fun/empty127351)))
    (define fun/empty127351 (lambda () empty))
    (define fun/empty127356 (lambda () empty))
    (define fun/ascii-char127349 (lambda () #\c))
    (define fun/ascii-char127347 (lambda () #\c))
    (define fun/ascii-char127348 (lambda () (call fun/ascii-char127349)))
    (define fun/vector127353 (lambda () (call fun/vector127354)))
    (let ((ascii-char0 (call fun/ascii-char127346))
          (ascii-char1 (call fun/ascii-char127348))
          (empty2 (call fun/empty127350))
          (boolean3 (call void? (call fun/any127352)))
          (vector4 (call fun/vector127353))
          (empty5 (call fun/empty127355)))
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
    (define fun/any128526 (lambda () #t))
    (define fun/vector128521 (lambda () (call make-vector 8)))
    (define fun/error128527 (lambda () (call fun/error128528)))
    (define fun/empty128519 (lambda () empty))
    (define fun/error128525 (lambda () (error 223)))
    (define fun/empty128518 (lambda () (call fun/empty128519)))
    (define fun/error128524 (lambda () (call fun/error128525)))
    (define fun/error128528 (lambda () (error 73)))
    (define fun/ascii-char128522 (lambda () (call fun/ascii-char128523)))
    (define fun/vector128520 (lambda () (call fun/vector128521)))
    (define fun/ascii-char128523 (lambda () #\c))
    (let ((empty0 (call fun/empty128518))
          (vector1 (call fun/vector128520))
          (ascii-char2 (call fun/ascii-char128522))
          (error3 (call fun/error128524))
          (boolean4 (call empty? (call fun/any128526)))
          (error5 (call fun/error128527)))
      vector1)))
(check-by-interp
 '(module
    (define fun/ascii-char129540 (lambda () (call fun/ascii-char129541)))
    (define fun/void129535 (lambda () (call fun/void129536)))
    (define fun/vector129542 (lambda () (call fun/vector129543)))
    (define fun/any129537 (lambda () #\c))
    (define fun/void129536 (lambda () (void)))
    (define fun/any129534 (lambda () (call make-vector 8)))
    (define fun/vector129543 (lambda () (call make-vector 8)))
    (define fun/ascii-char129541 (lambda () #\c))
    (define fun/ascii-char129539 (lambda () #\c))
    (define fun/ascii-char129538 (lambda () (call fun/ascii-char129539)))
    (let ((fixnum0
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
          (boolean1 (call empty? (call fun/any129534)))
          (void2 (call fun/void129535))
          (boolean3 (call error? (call fun/any129537)))
          (ascii-char4 (call fun/ascii-char129538))
          (ascii-char5 (call fun/ascii-char129540)))
      (call fun/vector129542))))
(check-by-interp
 '(module
    (define fun/error129841 (lambda () (call fun/error129842)))
    (define fun/ascii-char129834 (lambda () #\c))
    (define fun/ascii-char129832 (lambda () #\c))
    (define fun/empty129840 (lambda () empty))
    (define fun/empty129836 (lambda () empty))
    (define fun/error129842 (lambda () (error 161)))
    (define fun/ascii-char129831 (lambda () (call fun/ascii-char129832)))
    (define fun/empty129835 (lambda () (call fun/empty129836)))
    (define fun/any129830 (lambda () (void)))
    (define fun/ascii-char129833 (lambda () (call fun/ascii-char129834)))
    (define fun/empty129837 (lambda () (call fun/empty129838)))
    (define fun/empty129838 (lambda () empty))
    (define fun/empty129839 (lambda () (call fun/empty129840)))
    (let ((boolean0 (call vector? (call fun/any129830)))
          (ascii-char1 (call fun/ascii-char129831))
          (ascii-char2 (call fun/ascii-char129833))
          (empty3 (call fun/empty129835))
          (empty4 (call fun/empty129837))
          (empty5 (call fun/empty129839)))
      (call fun/error129841))))
(check-by-interp
 '(module
    (define fun/vector130258 (lambda () (call make-vector 8)))
    (define fun/vector130260 (lambda () (call make-vector 8)))
    (define fun/ascii-char130262 (lambda () #\c))
    (define fun/void130255 (lambda () (call fun/void130256)))
    (define fun/vector130259 (lambda () (call fun/vector130260)))
    (define fun/ascii-char130261 (lambda () (call fun/ascii-char130262)))
    (define fun/void130256 (lambda () (void)))
    (define fun/vector130257 (lambda () (call fun/vector130258)))
    (let ((fixnum0
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
          (void1 (call fun/void130255))
          (fixnum2
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
          (fixnum3
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
          (vector4 (call fun/vector130257))
          (vector5 (call fun/vector130259)))
      (call fun/ascii-char130261))))
(check-by-interp
 '(module
    (define fun/vector132253 (lambda () (call fun/vector132254)))
    (define fun/vector132246 (lambda () (call make-vector 8)))
    (define fun/vector132249 (lambda () (call fun/vector132250)))
    (define fun/ascii-char132248 (lambda () #\c))
    (define fun/ascii-char132251 (lambda () (call fun/ascii-char132252)))
    (define fun/vector132254 (lambda () (call make-vector 8)))
    (define fun/ascii-char132252 (lambda () #\c))
    (define fun/vector132250 (lambda () (call make-vector 8)))
    (define fun/vector132245 (lambda () (call fun/vector132246)))
    (define fun/ascii-char132247 (lambda () (call fun/ascii-char132248)))
    (let ((vector0 (call fun/vector132245))
          (fixnum1
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
          (ascii-char2 (call fun/ascii-char132247))
          (vector3 (call fun/vector132249))
          (ascii-char4 (call fun/ascii-char132251))
          (vector5 (call fun/vector132253)))
      ascii-char4)))
(check-by-interp
 '(module
    (define fun/empty134124 (lambda () empty))
    (define fun/empty134123 (lambda () (call fun/empty134124)))
    (define fun/vector134119 (lambda () (call fun/vector134120)))
    (define fun/void134116 (lambda () (void)))
    (define fun/vector134114 (lambda () (call make-vector 8)))
    (define fun/void134115 (lambda () (call fun/void134116)))
    (define fun/void134118 (lambda () (void)))
    (define fun/vector134113 (lambda () (call fun/vector134114)))
    (define fun/void134122 (lambda () (void)))
    (define fun/void134117 (lambda () (call fun/void134118)))
    (define fun/vector134120 (lambda () (call make-vector 8)))
    (define fun/error134112 (lambda () (error 139)))
    (define fun/error134111 (lambda () (call fun/error134112)))
    (define fun/void134121 (lambda () (call fun/void134122)))
    (let ((error0 (call fun/error134111))
          (vector1 (call fun/vector134113))
          (void2 (call fun/void134115))
          (void3 (call fun/void134117))
          (vector4 (call fun/vector134119))
          (void5 (call fun/void134121)))
      (call fun/empty134123))))
