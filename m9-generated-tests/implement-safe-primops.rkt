#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
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

(check-by-interp '(module (call cons 6 501)))
(check-by-interp '(module (call cons 42 510)))
(check-by-interp
 '(module
    (define fun/error8439.4 (lambda () (error 148)))
    (call fun/error8439.4)))
(check-by-interp
 '(module
    (define fun/error8442.4 (lambda () (error 247)))
    (call fun/error8442.4)))
(check-by-interp
 '(module
    (define fun/error8445.4 (lambda () (error 141)))
    (call fun/error8445.4)))
(check-by-interp
 '(module
    (define fun/pair8448.4 (lambda () (call cons 183 277)))
    (call fun/pair8448.4)))
(check-by-interp '(module (let ((ascii-char0.5 #\N) (void1.4 (void))) #t)))
(check-by-interp
 '(module
    (let ((vector0.5 (call make-vector 8)) (procedure1.4 (lambda () 72)))
      empty)))
(check-by-interp
 '(module
    (define fun/empty8458.4 (lambda () empty))
    (define fun/empty8457.5 (lambda (oprand0.6) (call fun/empty8458.4)))
    (call fun/empty8457.5 (if #f (call cons 197 480) (call cons 47 421)))))
(check-by-interp '(module (if #f (void) (void))))
(check-by-interp '(module (if #f (call make-vector 8) (call make-vector 8))))
(check-by-interp
 '(module
    (define fun/error8467.4 (lambda (oprand0.7) (error 175)))
    (define fun/empty8465.5 (lambda (oprand0.8) (call fun/empty8466.6)))
    (define fun/empty8466.6 (lambda () empty))
    (call fun/empty8465.5 (call fun/error8467.4 (call cons 79 502)))))
(check-by-interp
 '(module
    (define fun/void8484.4 (lambda () (void)))
    (define fun/ascii-char8485.5 (lambda (oprand0.8 oprand1.7) #\B))
    (define fun/void8483.6
      (lambda (oprand0.10 oprand1.9) (call fun/void8484.4)))
    (call
     fun/void8483.6
     (call
      fun/ascii-char8485.5
      (call - 28 88)
      (call fun/ascii-char8485.5 88 #\C))
     (if #t 120 66))))
(check-by-interp
 '(module
    (if (if #t #t #f)
      (if #t (error 18) (error 103))
      (let ((ascii-char0.6 #\p) (fixnum1.5 201) (empty2.4 empty))
        (error 21)))))
(check-by-interp
 '(module
    (define fun/error8492.4 (lambda () (error 77)))
    (define fun/void8490.5 (lambda () (void)))
    (define fun/void8491.6 (lambda () (void)))
    (let ((void0.9 (call fun/void8490.5))
          (void1.8 (call fun/void8491.6))
          (boolean2.7 (call vector? (call make-vector 8))))
      (call fun/error8492.4))))
(check-by-interp
 '(module
    (define fun/error8495.4 (lambda (oprand0.6 oprand1.5) (error 68)))
    (if (if #t #t #f)
      (if #t (error 231) (error 156))
      (call fun/error8495.4 #\c (call make-vector 8)))))
(check-by-interp
 '(module
    (define fun/error8528.4 (lambda () (error 215)))
    (define fun/ascii-char8529.5 (lambda () #\W))
    (let ((error0.8 (call fun/error8528.4))
          (ascii-char1.7 (call fun/ascii-char8529.5))
          (boolean2.6 (call empty? #\I)))
      (call - 186 245))))
(check-by-interp
 '(module
    (define fun/pair8539.4 (lambda (oprand0.7 oprand1.6) oprand1.6))
    (define fun/pair8538.5 (lambda (oprand0.9 oprand1.8) (call cons 5 510)))
    (if (if #t #f #f)
      (call fun/pair8538.5 247 #f)
      (call fun/pair8539.4 #f (call cons 28 345)))))
(check-by-interp
 '(module
    (define fun/ascii-char8543.4 (lambda (oprand0.7 oprand1.6) #\x))
    (define fun/boolean8542.5 (lambda (oprand0.9 oprand1.8) #t))
    (if (call fun/boolean8542.5 #\] (call make-vector 8))
      (call fun/ascii-char8543.4 (call cons 180 382) 229)
      (if #f #\^ #\i))))
(check-by-interp
 '(module
    (define fun/empty8591.4 (lambda () empty))
    (define fun/vector8589.5 (lambda () (call make-vector 8)))
    (define fun/ascii-char8590.6 (lambda () #\D))
    (let ((fixnum0.10 (call - (call - 215 72) (call - 219 173)))
          (vector1.9 (call fun/vector8589.5))
          (fixnum2.8 (call + (call + 93 220) (call * 170 131)))
          (ascii-char3.7 (call fun/ascii-char8590.6)))
      (call fun/empty8591.4))))
(check-by-interp
 '(module
    (if (if #t #t #f)
      (if #t (call cons 51 420) (call cons 40 364))
      (if #t (call cons 241 350) (call cons 112 345)))))
(check-by-interp
 '(module
    (define fun/ascii-char8689.4 (lambda () #\I))
    (define fun/error8691.5 (lambda () (error 124)))
    (define fun/empty8692.6 (lambda () empty))
    (define fun/ascii-char8688.7 (lambda () #\j))
    (define fun/void8690.8 (lambda () (void)))
    (let ((ascii-char0.12 (call fun/ascii-char8688.7))
          (ascii-char1.11 (call fun/ascii-char8689.4))
          (void2.10 (call fun/void8690.8))
          (procedure3.9 (lambda () (call fun/error8691.5))))
      (call fun/empty8692.6))))
(check-by-interp
 '(module
    (define fun/vector8765.4 (lambda () (call make-vector 8)))
    (define fun/ascii-char8761.5 (lambda () #\k))
    (define fun/any8762.6 (lambda () (void)))
    (define fun/void8763.7 (lambda () (void)))
    (define fun/any8764.8 (lambda () (error 55)))
    (let ((ascii-char0.12 (call fun/ascii-char8761.5))
          (boolean1.11 (call vector? (call fun/any8762.6)))
          (void2.10 (call fun/void8763.7))
          (boolean3.9 (call boolean? (call fun/any8764.8))))
      (call fun/vector8765.4))))
(check-by-interp
 '(module
    (define fun/fixnum8791.4
      (lambda (oprand0.19 oprand1.18 oprand2.17) (call fun/fixnum8792.13)))
    (define fun/pair8797.5
      (lambda (oprand0.22 oprand1.21 oprand2.20) (call fun/pair8798.16)))
    (define fun/error8799.6
      (lambda (oprand0.25 oprand1.24 oprand2.23) (error 158)))
    (define fun/pair8789.7 (lambda () (call fun/pair8790.10)))
    (define fun/pair8788.8
      (lambda (oprand0.28 oprand1.27 oprand2.26) (call fun/pair8789.7)))
    (define fun/empty8793.9 (lambda (oprand0.31 oprand1.30 oprand2.29) empty))
    (define fun/pair8790.10 (lambda () (call cons 25 485)))
    (define fun/fixnum8796.11 (lambda (oprand0.34 oprand1.33 oprand2.32) 254))
    (define fun/ascii-char8795.12 (lambda () #\K))
    (define fun/fixnum8792.13 (lambda () 185))
    (define fun/error8800.14
      (lambda (oprand0.37 oprand1.36 oprand2.35) oprand2.35))
    (define fun/ascii-char8794.15
      (lambda (oprand0.40 oprand1.39 oprand2.38) (call fun/ascii-char8795.12)))
    (define fun/pair8798.16 (lambda () (call cons 24 277)))
    (call
     fun/pair8788.8
     (call
      >
      (call
       fun/fixnum8791.4
       (call fun/empty8793.9 250 #t (error 11))
       (if #f empty empty)
       (call ascii-char? (call make-vector 8)))
      (if #t 182 209))
     (call
      fun/ascii-char8794.15
      (call
       *
       (let ((error0.44 (error 211))
             (fixnum1.43 224)
             (vector2.42 (call make-vector 8))
             (procedure3.41 (lambda () #\X)))
         226)
       (call fun/fixnum8796.11 174 (error 224) (void)))
      (call
       fun/pair8797.5
       (call fun/error8799.6 empty 6 (void))
       (if #t (void) (void))
       (call fun/ascii-char8794.15 79 (call cons 43 357) (call make-vector 8)))
      (if #f (call make-vector 8) (call make-vector 8)))
     (call
      fun/error8800.14
      (if #t (call make-vector 8) (call make-vector 8))
      (let ((vector0.48 (call make-vector 8))
            (vector1.47 (call make-vector 8))
            (ascii-char2.46 #\])
            (vector3.45 (call make-vector 8)))
        (void))
      (let ((boolean0.52 #t)
            (void1.51 (void))
            (boolean2.50 #f)
            (boolean3.49 #f))
        (error 220))))))
(check-by-interp
 '(module
    (define fun/error8923.4 (lambda () (call fun/error8924.14)))
    (define fun/ascii-char8926.5 (lambda () #\x))
    (define fun/empty8929.6 (lambda () (call fun/empty8930.11)))
    (define fun/void8927.7 (lambda () (call fun/void8928.15)))
    (define fun/ascii-char8921.8 (lambda () (call fun/ascii-char8922.10)))
    (define fun/error8919.9 (lambda () (call fun/error8920.12)))
    (define fun/ascii-char8922.10 (lambda () #\k))
    (define fun/empty8930.11 (lambda () empty))
    (define fun/error8920.12 (lambda () (error 185)))
    (define fun/ascii-char8925.13 (lambda () (call fun/ascii-char8926.5)))
    (define fun/error8924.14 (lambda () (error 130)))
    (define fun/void8928.15 (lambda () (void)))
    (let ((error0.20 (call fun/error8919.9))
          (ascii-char1.19 (call fun/ascii-char8921.8))
          (error2.18 (call fun/error8923.4))
          (ascii-char3.17 (call fun/ascii-char8925.13))
          (void4.16 (call fun/void8927.7)))
      (call fun/empty8929.6))))
(check-by-interp
 '(module
    (define fun/empty9121.4 (lambda () empty))
    (define fun/ascii-char9123.5 (lambda () #\s))
    (define fun/empty9120.6 (lambda () (call fun/empty9121.4)))
    (define fun/void9119.7 (lambda () (void)))
    (define fun/ascii-char9122.8 (lambda () (call fun/ascii-char9123.5)))
    (define fun/void9118.9 (lambda () (call fun/void9119.7)))
    (let ((void0.14 (call fun/void9118.9))
          (fixnum1.13
           (call
            *
            (call * (call - 25 226) (call - 159 56))
            (call - (call * 192 122) (call - 47 86))))
          (empty2.12 (call fun/empty9120.6))
          (procedure3.11
           (lambda ()
             (call
              <=
              (call + (call + 101 114) (call + 88 54))
              (call + (call + 59 2) (call - 47 76)))))
          (ascii-char4.10 (call fun/ascii-char9122.8)))
      (call
       >=
       (call - (call + 68 167) (call + 167 157))
       (call - (call - 30 155) (call + 28 101))))))
(check-by-interp
 '(module
    (define fun/error9127.4 (lambda () (error 167)))
    (define fun/ascii-char9131.5 (lambda () #\o))
    (define fun/empty9128.6 (lambda () empty))
    (define fun/ascii-char9132.7 (lambda () #\p))
    (define fun/ascii-char9130.8 (lambda () #\p))
    (define fun/vector9133.9 (lambda () (call make-vector 8)))
    (define fun/ascii-char9129.10 (lambda () #\P))
    (define fun/vector9134.11 (lambda () (call make-vector 8)))
    (define fun/void9126.12 (lambda () (void)))
    (define fun/ascii-char9135.13 (lambda () #\u))
    (if (call vector? (if #f empty (void)))
      (let ((procedure0.18 (lambda () (call fun/void9126.12)))
            (error1.17 (call fun/error9127.4))
            (empty2.16 (call fun/empty9128.6))
            (ascii-char3.15 (call fun/ascii-char9129.10))
            (ascii-char4.14 (call fun/ascii-char9130.8)))
        (call fun/ascii-char9131.5))
      (let ((procedure0.23 (lambda () (call fun/ascii-char9132.7)))
            (vector1.22 (call fun/vector9133.9))
            (vector2.21 (call fun/vector9134.11))
            (ascii-char3.20 (call fun/ascii-char9135.13))
            (boolean4.19 (call <= 42 157)))
        (call procedure0.23)))))
(check-by-interp
 '(module
    (define fun/ascii-char9194.4 (lambda () #\f))
    (define fun/void9197.5 (lambda () (call fun/void9198.8)))
    (define fun/error9195.6 (lambda () (call fun/error9196.13)))
    (define fun/empty9199.7 (lambda () (call fun/empty9200.10)))
    (define fun/void9198.8 (lambda () (void)))
    (define fun/ascii-char9193.9 (lambda () (call fun/ascii-char9194.4)))
    (define fun/empty9200.10 (lambda () empty))
    (define fun/void9202.11 (lambda () (void)))
    (define fun/error9191.12 (lambda () (call fun/error9192.14)))
    (define fun/error9196.13 (lambda () (error 198)))
    (define fun/error9192.14 (lambda () (error 213)))
    (define fun/void9201.15 (lambda () (call fun/void9202.11)))
    (let ((procedure0.20 (lambda () (call fun/error9191.12)))
          (ascii-char1.19 (call fun/ascii-char9193.9))
          (error2.18 (call fun/error9195.6))
          (void3.17 (call fun/void9197.5))
          (empty4.16 (call fun/empty9199.7)))
      (call fun/void9201.15))))
(check-by-interp
 '(module
    (define fun/ascii-char9893.4 (lambda () #\Q))
    (define fun/void9890.5 (lambda () (call fun/void9891.9)))
    (define fun/ascii-char9887.6 (lambda () #\]))
    (define fun/ascii-char9892.7 (lambda () (call fun/ascii-char9893.4)))
    (define fun/void9884.8 (lambda () (call fun/void9885.12)))
    (define fun/void9891.9 (lambda () (void)))
    (define fun/vector9888.10 (lambda () (call fun/vector9889.13)))
    (define fun/ascii-char9886.11 (lambda () (call fun/ascii-char9887.6)))
    (define fun/void9885.12 (lambda () (void)))
    (define fun/vector9889.13 (lambda () (call make-vector 8)))
    (let ((void0.18 (call fun/void9884.8))
          (ascii-char1.17 (call fun/ascii-char9886.11))
          (procedure2.16 (lambda () (call fun/vector9888.10)))
          (void3.15 (call fun/void9890.5))
          (fixnum4.14
           (call
            *
            (call * (call + 168 24) (call * 207 124))
            (call * (call * 127 249) (call - 196 211)))))
      (call fun/ascii-char9892.7))))
(check-by-interp
 '(module
    (define fun/void10282.4 (lambda () (void)))
    (define fun/empty10284.5 (lambda () empty))
    (define fun/vector10278.6 (lambda () (call fun/vector10279.8)))
    (define fun/empty10283.7 (lambda () (call fun/empty10284.5)))
    (define fun/vector10279.8 (lambda () (call make-vector 8)))
    (define fun/any10280.9 (lambda () #f))
    (define fun/void10281.10 (lambda () (call fun/void10282.4)))
    (let ((vector0.15 (call fun/vector10278.6))
          (boolean1.14 (call void? (call fun/any10280.9)))
          (fixnum2.13
           (call
            +
            (call - (call + 119 181) (call + 72 105))
            (call - (call + 81 154) (call * 141 81))))
          (procedure3.12 (lambda () (call fun/void10281.10)))
          (boolean4.11
           (call
            <=
            (call * (call - 176 127) (call + 186 126))
            (call - (call * 75 253) (call - 185 207)))))
      (call fun/empty10283.7))))
(check-by-interp
 '(module
    (define fun/error10623.4 (lambda () (call fun/error10624.5)))
    (define fun/error10624.5 (lambda () (error 75)))
    (define fun/void10626.6 (lambda () (void)))
    (define fun/void10627.7 (lambda () (call fun/void10628.8)))
    (define fun/void10628.8 (lambda () (void)))
    (define fun/void10625.9 (lambda () (call fun/void10626.6)))
    (let ((error0.14 (call fun/error10623.4))
          (void1.13 (call fun/void10625.9))
          (fixnum2.12
           (call
            +
            (call + (call + 177 96) (call - 65 207))
            (call * (call - 170 11) (call * 52 179))))
          (fixnum3.11
           (call
            *
            (call + (call - 72 203) (call + 144 243))
            (call - (call - 179 253) (call * 42 49))))
          (fixnum4.10
           (call
            -
            (call + (call * 47 226) (call - 208 124))
            (call - (call + 230 152) (call + 214 219)))))
      (call fun/void10627.7))))
(check-by-interp
 '(module
    (define fun/error10718.4 (lambda () (error 183)))
    (define fun/any10714.5 (lambda () (call make-vector 8)))
    (define fun/void10715.6 (lambda () (call fun/void10716.14)))
    (define fun/vector10712.7 (lambda () (call fun/vector10713.11)))
    (define fun/ascii-char10710.8 (lambda () (call fun/ascii-char10711.12)))
    (define fun/empty10708.9 (lambda () (call fun/empty10709.13)))
    (define fun/error10717.10 (lambda () (call fun/error10718.4)))
    (define fun/vector10713.11 (lambda () (call make-vector 8)))
    (define fun/ascii-char10711.12 (lambda () #\[))
    (define fun/empty10709.13 (lambda () empty))
    (define fun/void10716.14 (lambda () (void)))
    (let ((empty0.19 (call fun/empty10708.9))
          (procedure1.18 (lambda () (call fun/ascii-char10710.8)))
          (vector2.17 (call fun/vector10712.7))
          (boolean3.16 (call fixnum? (call fun/any10714.5)))
          (void4.15 (call fun/void10715.6)))
      (call fun/error10717.10))))
(check-by-interp
 '(module
    (define fun/void10791.4 (lambda () (call fun/void10792.10)))
    (define fun/ascii-char10794.5 (lambda () #\F))
    (define fun/ascii-char10796.6 (lambda () #\j))
    (define fun/ascii-char10795.7 (lambda () (call fun/ascii-char10796.6)))
    (define fun/vector10789.8 (lambda () (call fun/vector10790.9)))
    (define fun/vector10790.9 (lambda () (call make-vector 8)))
    (define fun/void10792.10 (lambda () (void)))
    (define fun/ascii-char10793.11 (lambda () (call fun/ascii-char10794.5)))
    (let ((vector0.16 (call fun/vector10789.8))
          (procedure1.15 (lambda () (call fun/void10791.4)))
          (ascii-char2.14 (call fun/ascii-char10793.11))
          (procedure3.13 (lambda () (call fun/ascii-char10795.7)))
          (procedure4.12
           (lambda ()
             (call
              +
              (call - (call - 90 126) (call - 96 108))
              (call + (call + 101 105) (call - 163 189))))))
      (call vector-ref vector0.16 1))))
(check-by-interp
 '(module
    (define fun/vector11667.4 (lambda () (call fun/vector11668.9)))
    (define fun/pair11669.5 (lambda () (call fun/pair11670.11)))
    (define fun/void11665.6 (lambda () (call fun/void11666.14)))
    (define fun/empty11663.7 (lambda () (call fun/empty11664.15)))
    (define fun/error11662.8 (lambda () (error 142)))
    (define fun/vector11668.9 (lambda () (call make-vector 8)))
    (define fun/empty11660.10 (lambda () empty))
    (define fun/pair11670.11 (lambda () (call cons 150 417)))
    (define fun/error11661.12 (lambda () (call fun/error11662.8)))
    (define fun/empty11659.13 (lambda () (call fun/empty11660.10)))
    (define fun/void11666.14 (lambda () (void)))
    (define fun/empty11664.15 (lambda () empty))
    (let ((procedure0.21 (lambda () (call fun/empty11659.13)))
          (error1.20 (call fun/error11661.12))
          (empty2.19 (call fun/empty11663.7))
          (void3.18 (call fun/void11665.6))
          (vector4.17 (call fun/vector11667.4))
          (procedure5.16 (lambda () (call fun/pair11669.5))))
      (call procedure0.21))))
(check-by-interp
 '(module
    (define fun/empty12026.4 (lambda () (call fun/empty12027.12)))
    (define fun/error12024.5 (lambda () (call fun/error12025.9)))
    (define fun/ascii-char12030.6 (lambda () (call fun/ascii-char12031.14)))
    (define fun/error12034.7 (lambda () (call fun/error12035.15)))
    (define fun/error12028.8 (lambda () (call fun/error12029.13)))
    (define fun/error12025.9 (lambda () (error 190)))
    (define fun/ascii-char12033.10 (lambda () #\k))
    (define fun/ascii-char12032.11 (lambda () (call fun/ascii-char12033.10)))
    (define fun/empty12027.12 (lambda () empty))
    (define fun/error12029.13 (lambda () (error 244)))
    (define fun/ascii-char12031.14 (lambda () #\]))
    (define fun/error12035.15 (lambda () (error 38)))
    (let ((fixnum0.21
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
          (error1.20 (call fun/error12024.5))
          (empty2.19 (call fun/empty12026.4))
          (error3.18 (call fun/error12028.8))
          (ascii-char4.17 (call fun/ascii-char12030.6))
          (ascii-char5.16 (call fun/ascii-char12032.11)))
      (call fun/error12034.7))))
(check-by-interp
 '(module
    (define fun/error13992.4 (lambda () (error 29)))
    (define fun/ascii-char13987.5 (lambda () (call fun/ascii-char13988.11)))
    (define fun/void13994.6 (lambda () (void)))
    (define fun/void13996.7 (lambda () (void)))
    (define fun/void13990.8 (lambda () (void)))
    (define fun/pair13985.9 (lambda () (call fun/pair13986.12)))
    (define fun/void13993.10 (lambda () (call fun/void13994.6)))
    (define fun/ascii-char13988.11 (lambda () #\j))
    (define fun/pair13986.12 (lambda () (call cons 112 427)))
    (define fun/error13991.13 (lambda () (call fun/error13992.4)))
    (define fun/void13995.14 (lambda () (call fun/void13996.7)))
    (define fun/void13989.15 (lambda () (call fun/void13990.8)))
    (let ((procedure0.21 (lambda () (call fun/pair13985.9)))
          (ascii-char1.20 (call fun/ascii-char13987.5))
          (void2.19 (call fun/void13989.15))
          (error3.18 (call fun/error13991.13))
          (void4.17 (call fun/void13993.10))
          (void5.16 (call fun/void13995.14)))
      (call procedure0.21))))
(check-by-interp
 '(module
    (define fun/vector14738.4 (lambda () (call fun/vector14739.15)))
    (define fun/vector14745.5 (lambda () (call make-vector 8)))
    (define fun/vector14744.6 (lambda () (call fun/vector14745.5)))
    (define fun/any14740.7 (lambda () (call fun/any14741.12)))
    (define fun/ascii-char14748.8 (lambda () (call fun/ascii-char14749.14)))
    (define fun/ascii-char14742.9 (lambda () (call fun/ascii-char14743.13)))
    (define fun/any14746.10 (lambda () (call fun/any14747.11)))
    (define fun/any14747.11 (lambda () empty))
    (define fun/any14741.12 (lambda () (call make-vector 8)))
    (define fun/ascii-char14743.13 (lambda () #\f))
    (define fun/ascii-char14749.14 (lambda () #\z))
    (define fun/vector14739.15 (lambda () (call make-vector 8)))
    (let ((vector0.21 (call fun/vector14738.4))
          (fixnum1.20
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
          (boolean2.19 (call fixnum? (call fun/any14740.7)))
          (ascii-char3.18 (call fun/ascii-char14742.9))
          (vector4.17 (call fun/vector14744.6))
          (procedure5.16
           (lambda () (call ascii-char? (call fun/any14746.10)))))
      (call fun/ascii-char14748.8))))
(check-by-interp
 '(module
    (define fun/ascii-char14780.4 (lambda () (call fun/ascii-char14781.11)))
    (define fun/vector14772.5 (lambda () (call fun/vector14773.8)))
    (define fun/empty14779.6 (lambda () empty))
    (define fun/any14775.7 (lambda () 147))
    (define fun/vector14773.8 (lambda () (call make-vector 8)))
    (define fun/vector14777.9 (lambda () (call make-vector 8)))
    (define fun/empty14778.10 (lambda () (call fun/empty14779.6)))
    (define fun/ascii-char14781.11 (lambda () #\Z))
    (define fun/vector14776.12 (lambda () (call fun/vector14777.9)))
    (define fun/any14774.13 (lambda () (call fun/any14775.7)))
    (let ((fixnum0.19
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
          (vector1.18 (call fun/vector14772.5))
          (boolean2.17 (call procedure? (call fun/any14774.13)))
          (vector3.16 (call fun/vector14776.12))
          (fixnum4.15
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
          (empty5.14 (call fun/empty14778.10)))
      (call fun/ascii-char14780.4))))
(check-by-interp
 '(module
    (define fun/error15417.4 (lambda () (error 26)))
    (define fun/any15415.5 (lambda () #f))
    (define fun/pair15426.6 (lambda () (call fun/pair15427.15)))
    (define fun/error15423.7 (lambda () (error 88)))
    (define fun/void15424.8 (lambda () (call fun/void15425.13)))
    (define fun/error15421.9 (lambda () (error 37)))
    (define fun/error15418.10 (lambda () (call fun/error15419.11)))
    (define fun/error15419.11 (lambda () (error 229)))
    (define fun/error15422.12 (lambda () (call fun/error15423.7)))
    (define fun/void15425.13 (lambda () (void)))
    (define fun/any15414.14 (lambda () (call fun/any15415.5)))
    (define fun/pair15427.15 (lambda () (call cons 247 511)))
    (define fun/error15416.16 (lambda () (call fun/error15417.4)))
    (define fun/error15420.17 (lambda () (call fun/error15421.9)))
    (let ((boolean0.23 (call ascii-char? (call fun/any15414.14)))
          (error1.22 (call fun/error15416.16))
          (error2.21 (call fun/error15418.10))
          (error3.20 (call fun/error15420.17))
          (error4.19 (call fun/error15422.12))
          (void5.18 (call fun/void15424.8)))
      (call fun/pair15426.6))))
(check-by-interp
 '(module
    (define fun/ascii-char16435.4 (lambda () (call fun/ascii-char16436.10)))
    (define fun/ascii-char16444.5 (lambda () #\e))
    (define fun/void16439.6 (lambda () (call fun/void16440.14)))
    (define fun/ascii-char16437.7 (lambda () (call fun/ascii-char16438.9)))
    (define fun/error16433.8 (lambda () (call fun/error16434.13)))
    (define fun/ascii-char16438.9 (lambda () #\H))
    (define fun/ascii-char16436.10 (lambda () #\[))
    (define fun/ascii-char16442.11 (lambda () #\`))
    (define fun/ascii-char16441.12 (lambda () (call fun/ascii-char16442.11)))
    (define fun/error16434.13 (lambda () (error 239)))
    (define fun/void16440.14 (lambda () (void)))
    (define fun/ascii-char16443.15 (lambda () (call fun/ascii-char16444.5)))
    (let ((error0.21 (call fun/error16433.8))
          (ascii-char1.20 (call fun/ascii-char16435.4))
          (fixnum2.19
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
          (ascii-char3.18 (call fun/ascii-char16437.7))
          (void4.17 (call fun/void16439.6))
          (ascii-char5.16 (call fun/ascii-char16441.12)))
      (call fun/ascii-char16443.15))))
(check-by-interp
 '(module
    (define fun/ascii-char16492.4 (lambda () #\h))
    (define fun/empty16491.5 (lambda () empty))
    (define fun/vector16484.6 (lambda () (call make-vector 8)))
    (define fun/empty16487.7 (lambda () empty))
    (define fun/any16488.8 (lambda () 68))
    (define fun/empty16489.9 (lambda () empty))
    (define fun/error16485.10 (lambda () (error 237)))
    (define fun/empty16490.11 (lambda () empty))
    (define fun/error16486.12 (lambda () (error 225)))
    (if (let ((fixnum0.18 (call - (call - 89 200) (call + 38 241)))
              (vector1.17 (call fun/vector16484.6))
              (error2.16 (call fun/error16485.10))
              (error3.15 (call fun/error16486.12))
              (empty4.14 (call fun/empty16487.7))
              (boolean5.13 (call <= (call - 185 172) (call + 136 173))))
          (call boolean? (call fun/any16488.8)))
      (if (if #t #f #f)
        (let ((ascii-char0.24 #\_)
              (ascii-char1.23 #\A)
              (boolean2.22 #f)
              (void3.21 (void))
              (boolean4.20 #f)
              (empty5.19 empty))
          #\U)
        (if #t #\v #\U))
      (let ((empty0.30 (call fun/empty16489.9))
            (fixnum1.29 (call - (call * 53 209) (call * 2 115)))
            (boolean2.28 (call > (call * 94 22) (call + 89 85)))
            (empty3.27 (call fun/empty16490.11))
            (fixnum4.26 (call - (call - 17 63) (call * 147 5)))
            (empty5.25 (call fun/empty16491.5)))
        (call fun/ascii-char16492.4)))))
(check-by-interp
 '(module
    (define fun/any16598.4 (lambda () (call fun/any16599.12)))
    (define fun/ascii-char16603.5 (lambda () #\]))
    (define fun/vector16592.6 (lambda () (call fun/vector16593.13)))
    (define fun/vector16605.7 (lambda () (call make-vector 8)))
    (define fun/vector16595.8 (lambda () (call make-vector 8)))
    (define fun/void16601.9 (lambda () (void)))
    (define fun/ascii-char16597.10 (lambda () #\c))
    (define fun/vector16604.11 (lambda () (call fun/vector16605.7)))
    (define fun/any16599.12 (lambda () (call cons 178 511)))
    (define fun/vector16593.13 (lambda () (call make-vector 8)))
    (define fun/ascii-char16596.14 (lambda () (call fun/ascii-char16597.10)))
    (define fun/ascii-char16602.15 (lambda () (call fun/ascii-char16603.5)))
    (define fun/void16600.16 (lambda () (call fun/void16601.9)))
    (define fun/vector16594.17 (lambda () (call fun/vector16595.8)))
    (let ((vector0.23 (call fun/vector16592.6))
          (vector1.22 (call fun/vector16594.17))
          (ascii-char2.21 (call fun/ascii-char16596.14))
          (boolean3.20 (call procedure? (call fun/any16598.4)))
          (void4.19 (call fun/void16600.16))
          (ascii-char5.18 (call fun/ascii-char16602.15)))
      (call fun/vector16604.11))))
(check-by-interp
 '(module
    (define fun/vector18001.4 (lambda () (call make-vector 8)))
    (define fun/vector17999.5 (lambda () (call make-vector 8)))
    (define fun/vector17998.6 (lambda () (call fun/vector17999.5)))
    (define fun/ascii-char18008.7 (lambda () (call fun/ascii-char18009.17)))
    (define fun/void18006.8 (lambda () (call fun/void18007.12)))
    (define fun/any18002.9 (lambda () (call fun/any18003.14)))
    (define fun/empty17997.10 (lambda () empty))
    (define fun/any18005.11 (lambda () (error 158)))
    (define fun/void18007.12 (lambda () (void)))
    (define fun/any18004.13 (lambda () (call fun/any18005.11)))
    (define fun/any18003.14 (lambda () (call cons 98 287)))
    (define fun/vector18000.15 (lambda () (call fun/vector18001.4)))
    (define fun/empty17996.16 (lambda () (call fun/empty17997.10)))
    (define fun/ascii-char18009.17 (lambda () #\G))
    (let ((procedure0.23 (lambda () (call fun/empty17996.16)))
          (vector1.22 (call fun/vector17998.6))
          (vector2.21 (call fun/vector18000.15))
          (boolean3.20 (call vector? (call fun/any18002.9)))
          (boolean4.19 (call void? (call fun/any18004.13)))
          (void5.18 (call fun/void18006.8)))
      (call fun/ascii-char18008.7))))
(check-by-interp
 '(module
    (define fun/error18490.4 (lambda () (call fun/error18491.8)))
    (define fun/empty18499.5 (lambda () empty))
    (define fun/error18497.6 (lambda () (error 98)))
    (define fun/ascii-char18492.7 (lambda () (call fun/ascii-char18493.13)))
    (define fun/error18491.8 (lambda () (error 186)))
    (define fun/void18494.9 (lambda () (call fun/void18495.15)))
    (define fun/void18489.10 (lambda () (void)))
    (define fun/empty18498.11 (lambda () (call fun/empty18499.5)))
    (define fun/error18496.12 (lambda () (call fun/error18497.6)))
    (define fun/ascii-char18493.13 (lambda () #\Q))
    (define fun/void18488.14 (lambda () (call fun/void18489.10)))
    (define fun/void18495.15 (lambda () (void)))
    (let ((void0.21 (call fun/void18488.14))
          (error1.20 (call fun/error18490.4))
          (fixnum2.19
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
          (ascii-char3.18 (call fun/ascii-char18492.7))
          (void4.17 (call fun/void18494.9))
          (error5.16 (call fun/error18496.12)))
      (call fun/empty18498.11))))
(check-by-interp
 '(module
    (define fun/empty22590.4 (lambda () (call fun/empty22591.9)))
    (define fun/ascii-char22595.5 (lambda () #\b))
    (define fun/pair22601.6 (lambda () (call cons 100 463)))
    (define fun/ascii-char22589.7 (lambda () #\[))
    (define fun/empty22599.8 (lambda () empty))
    (define fun/empty22591.9 (lambda () empty))
    (define fun/empty22597.10 (lambda () empty))
    (define fun/ascii-char22588.11 (lambda () (call fun/ascii-char22589.7)))
    (define fun/error22593.12 (lambda () (error 22)))
    (define fun/pair22600.13 (lambda () (call fun/pair22601.6)))
    (define fun/error22592.14 (lambda () (call fun/error22593.12)))
    (define fun/empty22598.15 (lambda () (call fun/empty22599.8)))
    (define fun/empty22596.16 (lambda () (call fun/empty22597.10)))
    (define fun/ascii-char22594.17 (lambda () (call fun/ascii-char22595.5)))
    (let ((ascii-char0.23 (call fun/ascii-char22588.11))
          (empty1.22 (call fun/empty22590.4))
          (error2.21 (call fun/error22592.14))
          (ascii-char3.20 (call fun/ascii-char22594.17))
          (empty4.19 (call fun/empty22596.16))
          (empty5.18 (call fun/empty22598.15)))
      (call fun/pair22600.13))))
(check-by-interp
 '(module
    (define fun/void23349.4 (lambda () (void)))
    (define fun/any23351.5 (lambda () (call cons 159 398)))
    (define fun/void23348.6 (lambda () (call fun/void23349.4)))
    (define fun/any23350.7 (lambda () (call fun/any23351.5)))
    (define fun/ascii-char23347.8 (lambda () #\\))
    (define fun/ascii-char23346.9 (lambda () (call fun/ascii-char23347.8)))
    (define fun/void23353.10 (lambda () (void)))
    (define fun/void23352.11 (lambda () (call fun/void23353.10)))
    (let ((ascii-char0.17 (call fun/ascii-char23346.9))
          (void1.16 (call fun/void23348.6))
          (boolean2.15 (call boolean? (call fun/any23350.7)))
          (procedure3.14
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
          (fixnum4.13
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
          (procedure5.12 (lambda () (call fun/void23352.11))))
      (call
       -
       (call * (call procedure3.14) (call procedure3.14))
       (call
        +
        (call * (call * 105 226) (call + 43 81))
        (call + (call * 245 145) (call * 109 196)))))))
(check-by-interp
 '(module
    (define fun/vector24625.4 (lambda () (call fun/vector24626.15)))
    (define fun/any24628.5 (lambda () empty))
    (define fun/error24633.6 (lambda () (call fun/error24634.12)))
    (define fun/empty24629.7 (lambda () (call fun/empty24630.11)))
    (define fun/error24636.8 (lambda () (error 205)))
    (define fun/void24632.9 (lambda () (void)))
    (define fun/void24631.10 (lambda () (call fun/void24632.9)))
    (define fun/empty24630.11 (lambda () empty))
    (define fun/error24634.12 (lambda () (error 74)))
    (define fun/error24635.13 (lambda () (call fun/error24636.8)))
    (define fun/any24627.14 (lambda () (call fun/any24628.5)))
    (define fun/vector24626.15 (lambda () (call make-vector 8)))
    (let ((fixnum0.21
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
          (vector1.20 (call fun/vector24625.4))
          (boolean2.19 (call empty? (call fun/any24627.14)))
          (procedure3.18 (lambda () (call fun/empty24629.7)))
          (procedure4.17 (lambda () (call fun/void24631.10)))
          (error5.16 (call fun/error24633.6)))
      (call fun/error24635.13))))
