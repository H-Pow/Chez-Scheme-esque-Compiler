#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
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

(check-by-interp '(module (call cons 6 501)))
(check-by-interp '(module (call cons 42 510)))
(check-by-interp
 '(module (define fun/error8439 (lambda () (error 148))) (call fun/error8439)))
(check-by-interp
 '(module (define fun/error8442 (lambda () (error 247))) (call fun/error8442)))
(check-by-interp
 '(module (define fun/error8445 (lambda () (error 141))) (call fun/error8445)))
(check-by-interp
 '(module
    (define fun/pair8448 (lambda () (call cons 183 277)))
    (call fun/pair8448)))
(check-by-interp '(module (let ((ascii-char0 #\N) (void1 (void))) #t)))
(check-by-interp
 '(module
    (let ((vector0 (call make-vector 8)) (procedure1 (lambda () 72))) empty)))
(check-by-interp
 '(module
    (define fun/empty8458 (lambda () empty))
    (define fun/empty8457 (lambda (oprand0) (call fun/empty8458)))
    (call fun/empty8457 (if #f (call cons 197 480) (call cons 47 421)))))
(check-by-interp '(module (if #f (void) (void))))
(check-by-interp '(module (if #f (call make-vector 8) (call make-vector 8))))
(check-by-interp
 '(module
    (define fun/error8467 (lambda (oprand0) (error 175)))
    (define fun/empty8465 (lambda (oprand0) (call fun/empty8466)))
    (define fun/empty8466 (lambda () empty))
    (call fun/empty8465 (call fun/error8467 (call cons 79 502)))))
(check-by-interp
 '(module
    (define fun/void8484 (lambda () (void)))
    (define fun/ascii-char8485 (lambda (oprand0 oprand1) #\B))
    (define fun/void8483 (lambda (oprand0 oprand1) (call fun/void8484)))
    (call
     fun/void8483
     (call fun/ascii-char8485 (call - 28 88) (call fun/ascii-char8485 88 #\C))
     (if #t 120 66))))
(check-by-interp
 '(module
    (if (if #t #t #f)
      (if #t (error 18) (error 103))
      (let ((ascii-char0 #\p) (fixnum1 201) (empty2 empty)) (error 21)))))
(check-by-interp
 '(module
    (define fun/error8492 (lambda () (error 77)))
    (define fun/void8490 (lambda () (void)))
    (define fun/void8491 (lambda () (void)))
    (let ((void0 (call fun/void8490))
          (void1 (call fun/void8491))
          (boolean2 (call vector? (call make-vector 8))))
      (call fun/error8492))))
(check-by-interp
 '(module
    (define fun/error8495 (lambda (oprand0 oprand1) (error 68)))
    (if (if #t #t #f)
      (if #t (error 231) (error 156))
      (call fun/error8495 #\c (call make-vector 8)))))
(check-by-interp
 '(module
    (define fun/error8528 (lambda () (error 215)))
    (define fun/ascii-char8529 (lambda () #\W))
    (let ((error0 (call fun/error8528))
          (ascii-char1 (call fun/ascii-char8529))
          (boolean2 (call empty? #\I)))
      (call - 186 245))))
(check-by-interp
 '(module
    (define fun/pair8539 (lambda (oprand0 oprand1) oprand1))
    (define fun/pair8538 (lambda (oprand0 oprand1) (call cons 5 510)))
    (if (if #t #f #f)
      (call fun/pair8538 247 #f)
      (call fun/pair8539 #f (call cons 28 345)))))
(check-by-interp
 '(module
    (define fun/ascii-char8543 (lambda (oprand0 oprand1) #\x))
    (define fun/boolean8542 (lambda (oprand0 oprand1) #t))
    (if (call fun/boolean8542 #\] (call make-vector 8))
      (call fun/ascii-char8543 (call cons 180 382) 229)
      (if #f #\^ #\i))))
(check-by-interp
 '(module
    (define fun/empty8591 (lambda () empty))
    (define fun/vector8589 (lambda () (call make-vector 8)))
    (define fun/ascii-char8590 (lambda () #\D))
    (let ((fixnum0 (call - (call - 215 72) (call - 219 173)))
          (vector1 (call fun/vector8589))
          (fixnum2 (call + (call + 93 220) (call * 170 131)))
          (ascii-char3 (call fun/ascii-char8590)))
      (call fun/empty8591))))
(check-by-interp
 '(module
    (if (if #t #t #f)
      (if #t (call cons 51 420) (call cons 40 364))
      (if #t (call cons 241 350) (call cons 112 345)))))
(check-by-interp
 '(module
    (define fun/ascii-char8689 (lambda () #\I))
    (define fun/error8691 (lambda () (error 124)))
    (define fun/empty8692 (lambda () empty))
    (define fun/ascii-char8688 (lambda () #\j))
    (define fun/void8690 (lambda () (void)))
    (let ((ascii-char0 (call fun/ascii-char8688))
          (ascii-char1 (call fun/ascii-char8689))
          (void2 (call fun/void8690))
          (procedure3 (lambda () (call fun/error8691))))
      (call fun/empty8692))))
(check-by-interp
 '(module
    (define fun/vector8765 (lambda () (call make-vector 8)))
    (define fun/ascii-char8761 (lambda () #\k))
    (define fun/any8762 (lambda () (void)))
    (define fun/void8763 (lambda () (void)))
    (define fun/any8764 (lambda () (error 55)))
    (let ((ascii-char0 (call fun/ascii-char8761))
          (boolean1 (call vector? (call fun/any8762)))
          (void2 (call fun/void8763))
          (boolean3 (call boolean? (call fun/any8764))))
      (call fun/vector8765))))
(check-by-interp
 '(module
    (define fun/fixnum8791
      (lambda (oprand0 oprand1 oprand2) (call fun/fixnum8792)))
    (define fun/pair8797
      (lambda (oprand0 oprand1 oprand2) (call fun/pair8798)))
    (define fun/error8799 (lambda (oprand0 oprand1 oprand2) (error 158)))
    (define fun/pair8789 (lambda () (call fun/pair8790)))
    (define fun/pair8788
      (lambda (oprand0 oprand1 oprand2) (call fun/pair8789)))
    (define fun/empty8793 (lambda (oprand0 oprand1 oprand2) empty))
    (define fun/pair8790 (lambda () (call cons 25 485)))
    (define fun/fixnum8796 (lambda (oprand0 oprand1 oprand2) 254))
    (define fun/ascii-char8795 (lambda () #\K))
    (define fun/fixnum8792 (lambda () 185))
    (define fun/error8800 (lambda (oprand0 oprand1 oprand2) oprand2))
    (define fun/ascii-char8794
      (lambda (oprand0 oprand1 oprand2) (call fun/ascii-char8795)))
    (define fun/pair8798 (lambda () (call cons 24 277)))
    (call
     fun/pair8788
     (call
      >
      (call
       fun/fixnum8791
       (call fun/empty8793 250 #t (error 11))
       (if #f empty empty)
       (call ascii-char? (call make-vector 8)))
      (if #t 182 209))
     (call
      fun/ascii-char8794
      (call
       *
       (let ((error0 (error 211))
             (fixnum1 224)
             (vector2 (call make-vector 8))
             (procedure3 (lambda () #\X)))
         226)
       (call fun/fixnum8796 174 (error 224) (void)))
      (call
       fun/pair8797
       (call fun/error8799 empty 6 (void))
       (if #t (void) (void))
       (call fun/ascii-char8794 79 (call cons 43 357) (call make-vector 8)))
      (if #f (call make-vector 8) (call make-vector 8)))
     (call
      fun/error8800
      (if #t (call make-vector 8) (call make-vector 8))
      (let ((vector0 (call make-vector 8))
            (vector1 (call make-vector 8))
            (ascii-char2 #\])
            (vector3 (call make-vector 8)))
        (void))
      (let ((boolean0 #t) (void1 (void)) (boolean2 #f) (boolean3 #f))
        (error 220))))))
(check-by-interp
 '(module
    (define fun/error8923 (lambda () (call fun/error8924)))
    (define fun/ascii-char8926 (lambda () #\x))
    (define fun/empty8929 (lambda () (call fun/empty8930)))
    (define fun/void8927 (lambda () (call fun/void8928)))
    (define fun/ascii-char8921 (lambda () (call fun/ascii-char8922)))
    (define fun/error8919 (lambda () (call fun/error8920)))
    (define fun/ascii-char8922 (lambda () #\k))
    (define fun/empty8930 (lambda () empty))
    (define fun/error8920 (lambda () (error 185)))
    (define fun/ascii-char8925 (lambda () (call fun/ascii-char8926)))
    (define fun/error8924 (lambda () (error 130)))
    (define fun/void8928 (lambda () (void)))
    (let ((error0 (call fun/error8919))
          (ascii-char1 (call fun/ascii-char8921))
          (error2 (call fun/error8923))
          (ascii-char3 (call fun/ascii-char8925))
          (void4 (call fun/void8927)))
      (call fun/empty8929))))
(check-by-interp
 '(module
    (define fun/empty9121 (lambda () empty))
    (define fun/ascii-char9123 (lambda () #\s))
    (define fun/empty9120 (lambda () (call fun/empty9121)))
    (define fun/void9119 (lambda () (void)))
    (define fun/ascii-char9122 (lambda () (call fun/ascii-char9123)))
    (define fun/void9118 (lambda () (call fun/void9119)))
    (let ((void0 (call fun/void9118))
          (fixnum1
           (call
            *
            (call * (call - 25 226) (call - 159 56))
            (call - (call * 192 122) (call - 47 86))))
          (empty2 (call fun/empty9120))
          (procedure3
           (lambda ()
             (call
              <=
              (call + (call + 101 114) (call + 88 54))
              (call + (call + 59 2) (call - 47 76)))))
          (ascii-char4 (call fun/ascii-char9122)))
      (call
       >=
       (call - (call + 68 167) (call + 167 157))
       (call - (call - 30 155) (call + 28 101))))))
(check-by-interp
 '(module
    (define fun/error9127 (lambda () (error 167)))
    (define fun/ascii-char9131 (lambda () #\o))
    (define fun/empty9128 (lambda () empty))
    (define fun/ascii-char9132 (lambda () #\p))
    (define fun/ascii-char9130 (lambda () #\p))
    (define fun/vector9133 (lambda () (call make-vector 8)))
    (define fun/ascii-char9129 (lambda () #\P))
    (define fun/vector9134 (lambda () (call make-vector 8)))
    (define fun/void9126 (lambda () (void)))
    (define fun/ascii-char9135 (lambda () #\u))
    (if (call vector? (if #f empty (void)))
      (let ((procedure0 (lambda () (call fun/void9126)))
            (error1 (call fun/error9127))
            (empty2 (call fun/empty9128))
            (ascii-char3 (call fun/ascii-char9129))
            (ascii-char4 (call fun/ascii-char9130)))
        (call fun/ascii-char9131))
      (let ((procedure0 (lambda () (call fun/ascii-char9132)))
            (vector1 (call fun/vector9133))
            (vector2 (call fun/vector9134))
            (ascii-char3 (call fun/ascii-char9135))
            (boolean4 (call <= 42 157)))
        (call procedure0)))))
(check-by-interp
 '(module
    (define fun/ascii-char9194 (lambda () #\f))
    (define fun/void9197 (lambda () (call fun/void9198)))
    (define fun/error9195 (lambda () (call fun/error9196)))
    (define fun/empty9199 (lambda () (call fun/empty9200)))
    (define fun/void9198 (lambda () (void)))
    (define fun/ascii-char9193 (lambda () (call fun/ascii-char9194)))
    (define fun/empty9200 (lambda () empty))
    (define fun/void9202 (lambda () (void)))
    (define fun/error9191 (lambda () (call fun/error9192)))
    (define fun/error9196 (lambda () (error 198)))
    (define fun/error9192 (lambda () (error 213)))
    (define fun/void9201 (lambda () (call fun/void9202)))
    (let ((procedure0 (lambda () (call fun/error9191)))
          (ascii-char1 (call fun/ascii-char9193))
          (error2 (call fun/error9195))
          (void3 (call fun/void9197))
          (empty4 (call fun/empty9199)))
      (call fun/void9201))))
(check-by-interp
 '(module
    (define fun/ascii-char9893 (lambda () #\Q))
    (define fun/void9890 (lambda () (call fun/void9891)))
    (define fun/ascii-char9887 (lambda () #\]))
    (define fun/ascii-char9892 (lambda () (call fun/ascii-char9893)))
    (define fun/void9884 (lambda () (call fun/void9885)))
    (define fun/void9891 (lambda () (void)))
    (define fun/vector9888 (lambda () (call fun/vector9889)))
    (define fun/ascii-char9886 (lambda () (call fun/ascii-char9887)))
    (define fun/void9885 (lambda () (void)))
    (define fun/vector9889 (lambda () (call make-vector 8)))
    (let ((void0 (call fun/void9884))
          (ascii-char1 (call fun/ascii-char9886))
          (procedure2 (lambda () (call fun/vector9888)))
          (void3 (call fun/void9890))
          (fixnum4
           (call
            *
            (call * (call + 168 24) (call * 207 124))
            (call * (call * 127 249) (call - 196 211)))))
      (call fun/ascii-char9892))))
(check-by-interp
 '(module
    (define fun/void10282 (lambda () (void)))
    (define fun/empty10284 (lambda () empty))
    (define fun/vector10278 (lambda () (call fun/vector10279)))
    (define fun/empty10283 (lambda () (call fun/empty10284)))
    (define fun/vector10279 (lambda () (call make-vector 8)))
    (define fun/any10280 (lambda () #f))
    (define fun/void10281 (lambda () (call fun/void10282)))
    (let ((vector0 (call fun/vector10278))
          (boolean1 (call void? (call fun/any10280)))
          (fixnum2
           (call
            +
            (call - (call + 119 181) (call + 72 105))
            (call - (call + 81 154) (call * 141 81))))
          (procedure3 (lambda () (call fun/void10281)))
          (boolean4
           (call
            <=
            (call * (call - 176 127) (call + 186 126))
            (call - (call * 75 253) (call - 185 207)))))
      (call fun/empty10283))))
(check-by-interp
 '(module
    (define fun/error10623 (lambda () (call fun/error10624)))
    (define fun/error10624 (lambda () (error 75)))
    (define fun/void10626 (lambda () (void)))
    (define fun/void10627 (lambda () (call fun/void10628)))
    (define fun/void10628 (lambda () (void)))
    (define fun/void10625 (lambda () (call fun/void10626)))
    (let ((error0 (call fun/error10623))
          (void1 (call fun/void10625))
          (fixnum2
           (call
            +
            (call + (call + 177 96) (call - 65 207))
            (call * (call - 170 11) (call * 52 179))))
          (fixnum3
           (call
            *
            (call + (call - 72 203) (call + 144 243))
            (call - (call - 179 253) (call * 42 49))))
          (fixnum4
           (call
            -
            (call + (call * 47 226) (call - 208 124))
            (call - (call + 230 152) (call + 214 219)))))
      (call fun/void10627))))
(check-by-interp
 '(module
    (define fun/error10718 (lambda () (error 183)))
    (define fun/any10714 (lambda () (call make-vector 8)))
    (define fun/void10715 (lambda () (call fun/void10716)))
    (define fun/vector10712 (lambda () (call fun/vector10713)))
    (define fun/ascii-char10710 (lambda () (call fun/ascii-char10711)))
    (define fun/empty10708 (lambda () (call fun/empty10709)))
    (define fun/error10717 (lambda () (call fun/error10718)))
    (define fun/vector10713 (lambda () (call make-vector 8)))
    (define fun/ascii-char10711 (lambda () #\[))
    (define fun/empty10709 (lambda () empty))
    (define fun/void10716 (lambda () (void)))
    (let ((empty0 (call fun/empty10708))
          (procedure1 (lambda () (call fun/ascii-char10710)))
          (vector2 (call fun/vector10712))
          (boolean3 (call fixnum? (call fun/any10714)))
          (void4 (call fun/void10715)))
      (call fun/error10717))))
(check-by-interp
 '(module
    (define fun/void10791 (lambda () (call fun/void10792)))
    (define fun/ascii-char10794 (lambda () #\F))
    (define fun/ascii-char10796 (lambda () #\j))
    (define fun/ascii-char10795 (lambda () (call fun/ascii-char10796)))
    (define fun/vector10789 (lambda () (call fun/vector10790)))
    (define fun/vector10790 (lambda () (call make-vector 8)))
    (define fun/void10792 (lambda () (void)))
    (define fun/ascii-char10793 (lambda () (call fun/ascii-char10794)))
    (let ((vector0 (call fun/vector10789))
          (procedure1 (lambda () (call fun/void10791)))
          (ascii-char2 (call fun/ascii-char10793))
          (procedure3 (lambda () (call fun/ascii-char10795)))
          (procedure4
           (lambda ()
             (call
              +
              (call - (call - 90 126) (call - 96 108))
              (call + (call + 101 105) (call - 163 189))))))
      (call vector-ref vector0 1))))
(check-by-interp
 '(module
    (define fun/vector11667 (lambda () (call fun/vector11668)))
    (define fun/pair11669 (lambda () (call fun/pair11670)))
    (define fun/void11665 (lambda () (call fun/void11666)))
    (define fun/empty11663 (lambda () (call fun/empty11664)))
    (define fun/error11662 (lambda () (error 142)))
    (define fun/vector11668 (lambda () (call make-vector 8)))
    (define fun/empty11660 (lambda () empty))
    (define fun/pair11670 (lambda () (call cons 150 417)))
    (define fun/error11661 (lambda () (call fun/error11662)))
    (define fun/empty11659 (lambda () (call fun/empty11660)))
    (define fun/void11666 (lambda () (void)))
    (define fun/empty11664 (lambda () empty))
    (let ((procedure0 (lambda () (call fun/empty11659)))
          (error1 (call fun/error11661))
          (empty2 (call fun/empty11663))
          (void3 (call fun/void11665))
          (vector4 (call fun/vector11667))
          (procedure5 (lambda () (call fun/pair11669))))
      (call procedure0))))
(check-by-interp
 '(module
    (define fun/empty12026 (lambda () (call fun/empty12027)))
    (define fun/error12024 (lambda () (call fun/error12025)))
    (define fun/ascii-char12030 (lambda () (call fun/ascii-char12031)))
    (define fun/error12034 (lambda () (call fun/error12035)))
    (define fun/error12028 (lambda () (call fun/error12029)))
    (define fun/error12025 (lambda () (error 190)))
    (define fun/ascii-char12033 (lambda () #\k))
    (define fun/ascii-char12032 (lambda () (call fun/ascii-char12033)))
    (define fun/empty12027 (lambda () empty))
    (define fun/error12029 (lambda () (error 244)))
    (define fun/ascii-char12031 (lambda () #\]))
    (define fun/error12035 (lambda () (error 38)))
    (let ((fixnum0
           (call
            +
            (call
             -
             (call + (call - 20 248) (call * 206 242))
             (call - (call + 165 249) (call * 245 99)))
            (call
             *
             (call - (call * 200 34) (call + 43 207))
             (call * (call - 204 93) (call * 55 91)))))
          (error1 (call fun/error12024))
          (empty2 (call fun/empty12026))
          (error3 (call fun/error12028))
          (ascii-char4 (call fun/ascii-char12030))
          (ascii-char5 (call fun/ascii-char12032)))
      (call fun/error12034))))
(check-by-interp
 '(module
    (define fun/error13992 (lambda () (error 29)))
    (define fun/ascii-char13987 (lambda () (call fun/ascii-char13988)))
    (define fun/void13994 (lambda () (void)))
    (define fun/void13996 (lambda () (void)))
    (define fun/void13990 (lambda () (void)))
    (define fun/pair13985 (lambda () (call fun/pair13986)))
    (define fun/void13993 (lambda () (call fun/void13994)))
    (define fun/ascii-char13988 (lambda () #\j))
    (define fun/pair13986 (lambda () (call cons 112 427)))
    (define fun/error13991 (lambda () (call fun/error13992)))
    (define fun/void13995 (lambda () (call fun/void13996)))
    (define fun/void13989 (lambda () (call fun/void13990)))
    (let ((procedure0 (lambda () (call fun/pair13985)))
          (ascii-char1 (call fun/ascii-char13987))
          (void2 (call fun/void13989))
          (error3 (call fun/error13991))
          (void4 (call fun/void13993))
          (void5 (call fun/void13995)))
      (call procedure0))))
(check-by-interp
 '(module
    (define fun/vector14738 (lambda () (call fun/vector14739)))
    (define fun/vector14745 (lambda () (call make-vector 8)))
    (define fun/vector14744 (lambda () (call fun/vector14745)))
    (define fun/any14740 (lambda () (call fun/any14741)))
    (define fun/ascii-char14748 (lambda () (call fun/ascii-char14749)))
    (define fun/ascii-char14742 (lambda () (call fun/ascii-char14743)))
    (define fun/any14746 (lambda () (call fun/any14747)))
    (define fun/any14747 (lambda () empty))
    (define fun/any14741 (lambda () (call make-vector 8)))
    (define fun/ascii-char14743 (lambda () #\f))
    (define fun/ascii-char14749 (lambda () #\z))
    (define fun/vector14739 (lambda () (call make-vector 8)))
    (let ((vector0 (call fun/vector14738))
          (fixnum1
           (call
            +
            (call
             *
             (call * (call - 45 247) (call - 119 239))
             (call + (call - 100 45) (call * 251 105)))
            (call
             *
             (call - (call * 114 238) (call * 230 88))
             (call - (call + 250 216) (call + 89 76)))))
          (boolean2 (call fixnum? (call fun/any14740)))
          (ascii-char3 (call fun/ascii-char14742))
          (vector4 (call fun/vector14744))
          (procedure5 (lambda () (call ascii-char? (call fun/any14746)))))
      (call fun/ascii-char14748))))
(check-by-interp
 '(module
    (define fun/ascii-char14780 (lambda () (call fun/ascii-char14781)))
    (define fun/vector14772 (lambda () (call fun/vector14773)))
    (define fun/empty14779 (lambda () empty))
    (define fun/any14775 (lambda () 147))
    (define fun/vector14773 (lambda () (call make-vector 8)))
    (define fun/vector14777 (lambda () (call make-vector 8)))
    (define fun/empty14778 (lambda () (call fun/empty14779)))
    (define fun/ascii-char14781 (lambda () #\Z))
    (define fun/vector14776 (lambda () (call fun/vector14777)))
    (define fun/any14774 (lambda () (call fun/any14775)))
    (let ((fixnum0
           (call
            *
            (call
             -
             (call + (call + 228 49) (call + 11 111))
             (call + (call - 17 94) (call * 83 228)))
            (call
             -
             (call * (call - 76 30) (call + 20 59))
             (call - (call - 248 63) (call * 59 35)))))
          (vector1 (call fun/vector14772))
          (boolean2 (call procedure? (call fun/any14774)))
          (vector3 (call fun/vector14776))
          (fixnum4
           (call
            -
            (call
             -
             (call - (call * 35 53) (call + 152 36))
             (call - (call + 147 111) (call - 250 208)))
            (call
             +
             (call + (call + 245 114) (call * 118 89))
             (call - (call * 148 242) (call - 212 75)))))
          (empty5 (call fun/empty14778)))
      (call fun/ascii-char14780))))
(check-by-interp
 '(module
    (define fun/error15417 (lambda () (error 26)))
    (define fun/any15415 (lambda () #f))
    (define fun/pair15426 (lambda () (call fun/pair15427)))
    (define fun/error15423 (lambda () (error 88)))
    (define fun/void15424 (lambda () (call fun/void15425)))
    (define fun/error15421 (lambda () (error 37)))
    (define fun/error15418 (lambda () (call fun/error15419)))
    (define fun/error15419 (lambda () (error 229)))
    (define fun/error15422 (lambda () (call fun/error15423)))
    (define fun/void15425 (lambda () (void)))
    (define fun/any15414 (lambda () (call fun/any15415)))
    (define fun/pair15427 (lambda () (call cons 247 511)))
    (define fun/error15416 (lambda () (call fun/error15417)))
    (define fun/error15420 (lambda () (call fun/error15421)))
    (let ((boolean0 (call ascii-char? (call fun/any15414)))
          (error1 (call fun/error15416))
          (error2 (call fun/error15418))
          (error3 (call fun/error15420))
          (error4 (call fun/error15422))
          (void5 (call fun/void15424)))
      (call fun/pair15426))))
(check-by-interp
 '(module
    (define fun/ascii-char16435 (lambda () (call fun/ascii-char16436)))
    (define fun/ascii-char16444 (lambda () #\e))
    (define fun/void16439 (lambda () (call fun/void16440)))
    (define fun/ascii-char16437 (lambda () (call fun/ascii-char16438)))
    (define fun/error16433 (lambda () (call fun/error16434)))
    (define fun/ascii-char16438 (lambda () #\H))
    (define fun/ascii-char16436 (lambda () #\[))
    (define fun/ascii-char16442 (lambda () #\`))
    (define fun/ascii-char16441 (lambda () (call fun/ascii-char16442)))
    (define fun/error16434 (lambda () (error 239)))
    (define fun/void16440 (lambda () (void)))
    (define fun/ascii-char16443 (lambda () (call fun/ascii-char16444)))
    (let ((error0 (call fun/error16433))
          (ascii-char1 (call fun/ascii-char16435))
          (fixnum2
           (call
            +
            (call
             *
             (call - (call * 240 46) (call - 188 112))
             (call - (call * 35 210) (call + 107 254)))
            (call
             -
             (call * (call - 80 233) (call * 108 186))
             (call - (call - 234 172) (call + 179 80)))))
          (ascii-char3 (call fun/ascii-char16437))
          (void4 (call fun/void16439))
          (ascii-char5 (call fun/ascii-char16441)))
      (call fun/ascii-char16443))))
(check-by-interp
 '(module
    (define fun/ascii-char16492 (lambda () #\h))
    (define fun/empty16491 (lambda () empty))
    (define fun/vector16484 (lambda () (call make-vector 8)))
    (define fun/empty16487 (lambda () empty))
    (define fun/any16488 (lambda () 68))
    (define fun/empty16489 (lambda () empty))
    (define fun/error16485 (lambda () (error 237)))
    (define fun/empty16490 (lambda () empty))
    (define fun/error16486 (lambda () (error 225)))
    (if (let ((fixnum0 (call - (call - 89 200) (call + 38 241)))
              (vector1 (call fun/vector16484))
              (error2 (call fun/error16485))
              (error3 (call fun/error16486))
              (empty4 (call fun/empty16487))
              (boolean5 (call <= (call - 185 172) (call + 136 173))))
          (call boolean? (call fun/any16488)))
      (if (if #t #f #f)
        (let ((ascii-char0 #\_)
              (ascii-char1 #\A)
              (boolean2 #f)
              (void3 (void))
              (boolean4 #f)
              (empty5 empty))
          #\U)
        (if #t #\v #\U))
      (let ((empty0 (call fun/empty16489))
            (fixnum1 (call - (call * 53 209) (call * 2 115)))
            (boolean2 (call > (call * 94 22) (call + 89 85)))
            (empty3 (call fun/empty16490))
            (fixnum4 (call - (call - 17 63) (call * 147 5)))
            (empty5 (call fun/empty16491)))
        (call fun/ascii-char16492)))))
(check-by-interp
 '(module
    (define fun/any16598 (lambda () (call fun/any16599)))
    (define fun/ascii-char16603 (lambda () #\]))
    (define fun/vector16592 (lambda () (call fun/vector16593)))
    (define fun/vector16605 (lambda () (call make-vector 8)))
    (define fun/vector16595 (lambda () (call make-vector 8)))
    (define fun/void16601 (lambda () (void)))
    (define fun/ascii-char16597 (lambda () #\c))
    (define fun/vector16604 (lambda () (call fun/vector16605)))
    (define fun/any16599 (lambda () (call cons 178 511)))
    (define fun/vector16593 (lambda () (call make-vector 8)))
    (define fun/ascii-char16596 (lambda () (call fun/ascii-char16597)))
    (define fun/ascii-char16602 (lambda () (call fun/ascii-char16603)))
    (define fun/void16600 (lambda () (call fun/void16601)))
    (define fun/vector16594 (lambda () (call fun/vector16595)))
    (let ((vector0 (call fun/vector16592))
          (vector1 (call fun/vector16594))
          (ascii-char2 (call fun/ascii-char16596))
          (boolean3 (call procedure? (call fun/any16598)))
          (void4 (call fun/void16600))
          (ascii-char5 (call fun/ascii-char16602)))
      (call fun/vector16604))))
(check-by-interp
 '(module
    (define fun/vector18001 (lambda () (call make-vector 8)))
    (define fun/vector17999 (lambda () (call make-vector 8)))
    (define fun/vector17998 (lambda () (call fun/vector17999)))
    (define fun/ascii-char18008 (lambda () (call fun/ascii-char18009)))
    (define fun/void18006 (lambda () (call fun/void18007)))
    (define fun/any18002 (lambda () (call fun/any18003)))
    (define fun/empty17997 (lambda () empty))
    (define fun/any18005 (lambda () (error 158)))
    (define fun/void18007 (lambda () (void)))
    (define fun/any18004 (lambda () (call fun/any18005)))
    (define fun/any18003 (lambda () (call cons 98 287)))
    (define fun/vector18000 (lambda () (call fun/vector18001)))
    (define fun/empty17996 (lambda () (call fun/empty17997)))
    (define fun/ascii-char18009 (lambda () #\G))
    (let ((procedure0 (lambda () (call fun/empty17996)))
          (vector1 (call fun/vector17998))
          (vector2 (call fun/vector18000))
          (boolean3 (call vector? (call fun/any18002)))
          (boolean4 (call void? (call fun/any18004)))
          (void5 (call fun/void18006)))
      (call fun/ascii-char18008))))
(check-by-interp
 '(module
    (define fun/error18490 (lambda () (call fun/error18491)))
    (define fun/empty18499 (lambda () empty))
    (define fun/error18497 (lambda () (error 98)))
    (define fun/ascii-char18492 (lambda () (call fun/ascii-char18493)))
    (define fun/error18491 (lambda () (error 186)))
    (define fun/void18494 (lambda () (call fun/void18495)))
    (define fun/void18489 (lambda () (void)))
    (define fun/empty18498 (lambda () (call fun/empty18499)))
    (define fun/error18496 (lambda () (call fun/error18497)))
    (define fun/ascii-char18493 (lambda () #\Q))
    (define fun/void18488 (lambda () (call fun/void18489)))
    (define fun/void18495 (lambda () (void)))
    (let ((void0 (call fun/void18488))
          (error1 (call fun/error18490))
          (fixnum2
           (call
            *
            (call
             -
             (call * (call * 88 125) (call - 220 155))
             (call - (call - 144 224) (call * 186 124)))
            (call
             -
             (call - (call - 97 190) (call * 211 147))
             (call + (call * 175 153) (call * 126 159)))))
          (ascii-char3 (call fun/ascii-char18492))
          (void4 (call fun/void18494))
          (error5 (call fun/error18496)))
      (call fun/empty18498))))
(check-by-interp
 '(module
    (define fun/empty22590 (lambda () (call fun/empty22591)))
    (define fun/ascii-char22595 (lambda () #\b))
    (define fun/pair22601 (lambda () (call cons 100 463)))
    (define fun/ascii-char22589 (lambda () #\[))
    (define fun/empty22599 (lambda () empty))
    (define fun/empty22591 (lambda () empty))
    (define fun/empty22597 (lambda () empty))
    (define fun/ascii-char22588 (lambda () (call fun/ascii-char22589)))
    (define fun/error22593 (lambda () (error 22)))
    (define fun/pair22600 (lambda () (call fun/pair22601)))
    (define fun/error22592 (lambda () (call fun/error22593)))
    (define fun/empty22598 (lambda () (call fun/empty22599)))
    (define fun/empty22596 (lambda () (call fun/empty22597)))
    (define fun/ascii-char22594 (lambda () (call fun/ascii-char22595)))
    (let ((ascii-char0 (call fun/ascii-char22588))
          (empty1 (call fun/empty22590))
          (error2 (call fun/error22592))
          (ascii-char3 (call fun/ascii-char22594))
          (empty4 (call fun/empty22596))
          (empty5 (call fun/empty22598)))
      (call fun/pair22600))))
(check-by-interp
 '(module
    (define fun/void23349 (lambda () (void)))
    (define fun/any23351 (lambda () (call cons 159 398)))
    (define fun/void23348 (lambda () (call fun/void23349)))
    (define fun/any23350 (lambda () (call fun/any23351)))
    (define fun/ascii-char23347 (lambda () #\\))
    (define fun/ascii-char23346 (lambda () (call fun/ascii-char23347)))
    (define fun/void23353 (lambda () (void)))
    (define fun/void23352 (lambda () (call fun/void23353)))
    (let ((ascii-char0 (call fun/ascii-char23346))
          (void1 (call fun/void23348))
          (boolean2 (call boolean? (call fun/any23350)))
          (procedure3
           (lambda ()
             (call
              +
              (call
               +
               (call + (call - 239 118) (call - 38 153))
               (call + (call * 128 179) (call - 208 217)))
              (call
               -
               (call + (call - 121 152) (call * 212 8))
               (call * (call * 175 82) (call - 52 179))))))
          (fixnum4
           (call
            *
            (call
             -
             (call * (call - 100 80) (call + 40 93))
             (call + (call - 163 92) (call - 230 103)))
            (call
             -
             (call - (call - 47 61) (call - 139 24))
             (call + (call * 103 132) (call + 140 95)))))
          (procedure5 (lambda () (call fun/void23352))))
      (call
       -
       (call * (call procedure3) (call procedure3))
       (call
        +
        (call * (call * 105 226) (call + 43 81))
        (call + (call * 245 145) (call * 109 196)))))))
(check-by-interp
 '(module
    (define fun/vector24625 (lambda () (call fun/vector24626)))
    (define fun/any24628 (lambda () empty))
    (define fun/error24633 (lambda () (call fun/error24634)))
    (define fun/empty24629 (lambda () (call fun/empty24630)))
    (define fun/error24636 (lambda () (error 205)))
    (define fun/void24632 (lambda () (void)))
    (define fun/void24631 (lambda () (call fun/void24632)))
    (define fun/empty24630 (lambda () empty))
    (define fun/error24634 (lambda () (error 74)))
    (define fun/error24635 (lambda () (call fun/error24636)))
    (define fun/any24627 (lambda () (call fun/any24628)))
    (define fun/vector24626 (lambda () (call make-vector 8)))
    (let ((fixnum0
           (call
            -
            (call
             *
             (call + (call * 148 145) (call * 226 44))
             (call * (call + 65 170) (call - 129 146)))
            (call
             +
             (call + (call + 24 189) (call - 110 80))
             (call + (call - 191 251) (call - 78 207)))))
          (vector1 (call fun/vector24625))
          (boolean2 (call empty? (call fun/any24627)))
          (procedure3 (lambda () (call fun/empty24629)))
          (procedure4 (lambda () (call fun/void24631)))
          (error5 (call fun/error24633)))
      (call fun/error24635))))
