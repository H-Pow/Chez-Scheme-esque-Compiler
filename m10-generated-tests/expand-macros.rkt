#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         cpsc411/langs/v11
         "../expand-macros.rkt")
(define (fail-if-invalid p)
  (when (not (exprs-lang-v9? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "exprs-lang-v9"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-racketish-surface p)
  (interp-exprs-lang-v9 (fail-if-invalid (expand-macros p)))))

(check-by-interp '(module #t))
(check-by-interp '(module #t))
(check-by-interp '(module 226))
(check-by-interp '(module (void)))
(check-by-interp '(module (let () (error 209))))
(check-by-interp '(module (let () (error 221))))
(check-by-interp '(module (begin #\b #\_ #\c #\q #\V #\p #\R)))
(check-by-interp '(module (begin (error 172) (error 172))))
(check-by-interp
 '(module (define fun/void8493 (lambda () (void))) (call fun/void8493)))
(check-by-interp '(module (call * 11 130)))
(check-by-interp
 '(module
    (define fun/ascii-char8498 (lambda () #\U))
    (call fun/ascii-char8498)))
(check-by-interp
 '(module
    (define fun/ascii-char8501 (lambda () #\v))
    (call fun/ascii-char8501)))
(check-by-interp
 '(module
    (begin
      (begin #\V #\f #\E #\n #\\)
      (let () #\I)
      (let ((void0 (void))) #\k))))
(check-by-interp
 '(module
    (define fun/ascii-char8506 (lambda () #\L))
    (define fun/ascii-char8507 (lambda () #\i))
    (or (let ((procedure0 (lambda () (vector 1 2 3 4 5 6 7 8)))) #\G)
        (if #f #\[ #\\)
        (call fun/ascii-char8506)
        (if #t #\V #\V)
        (if #f #\i #\N)
        (call fun/ascii-char8507))))
(check-by-interp '(module (let () #\U)))
(check-by-interp '(module (if #f (void) (void))))
(check-by-interp '(module (let () empty)))
(check-by-interp
 '(module
    (define fun/error8516 (lambda () (call fun/error8517)))
    (define fun/error8517 (lambda () (error 112)))
    (call fun/error8516)))
(check-by-interp '(module (let () 110)))
(check-by-interp
 '(module
    (define fun/error8523 (lambda () (error 210)))
    (define fun/error8522 (lambda () (call fun/error8523)))
    (call fun/error8522)))
(check-by-interp '(module (begin (if #t (void) (void)))))
(check-by-interp '(module (if #t 46 97)))
(check-by-interp
 '(module
    (define fun/void8531 (lambda () (void)))
    (define fun/void8530 (lambda () (call fun/void8531)))
    (call fun/void8530)))
(check-by-interp
 '(module
    (define fun/void8534 (lambda () (void)))
    (define fun/void8535 (lambda () (void)))
    (begin
      (let ((boolean0 #f)) (void))
      (let ((empty0 empty)) (void))
      (call fun/void8534)
      (if #t (void) (void))
      (call fun/void8535)
      (and (void) (void) (void) (void) (void) (void) (void))
      (begin (void)))))
(check-by-interp
 '(module
    (define fun/void8539 (lambda () (void)))
    (define fun/void8538 (lambda () (call fun/void8539)))
    (call fun/void8538)))
(check-by-interp '(module (if #t #\i #\t)))
(check-by-interp '(module (call * (or 84 193 207 91 149) (or 174 79))))
(check-by-interp
 '(module
    (define fun/error8546 (lambda () (let () (error 83))))
    (call fun/error8546)))
(check-by-interp
 '(module
    (define fun/empty8549 (lambda (oprand0) (let () empty)))
    (call fun/empty8549 (let ((error0 (error 90))) (error 239)))))
(check-by-interp
 '(module
    (define fun/void8553 (lambda () (call fun/void8554)))
    (define fun/void8554 (lambda () (void)))
    (define fun/void8552 (lambda (oprand0) (call fun/void8553)))
    (call fun/void8552 (if #f 221 247))))
(check-by-interp
 '(module
    (define fun/error8557 (lambda () (error 161)))
    (and (let ((error0 (error 194))) (error 152))
         (begin
           (if #f (error 108) (error 68))
           (and (error 192))
           (if #f (error 126) (error 57))
           (begin (error 31) (error 219) (error 86))
           (if #t (error 147) (error 181))
           (call fun/error8557)
           (begin (error 211))))))
(check-by-interp
 '(module
    (define fun/ascii-char8562 (lambda (oprand0) #\n))
    (define fun/ascii-char8561 (lambda (oprand0) #\l))
    (define fun/boolean8560 (lambda () #f))
    (if (call fun/boolean8560)
      (call fun/ascii-char8561 #f)
      (call fun/ascii-char8562 '(31 309)))))
(check-by-interp
 '(module
    (define fun/ascii-char8565 (lambda () #\C))
    (let ((procedure0 (lambda () (call fun/ascii-char8565))))
      (let ((error0 (error 99))) (void)))))
(check-by-interp
 '(module (let ((ascii-char0 (or #\A #\^ #\k))) (if #f 249 139))))
(check-by-interp
 '(module
    (define fun/fixnum8570 (lambda () (let () 159)))
    (call fun/fixnum8570)))
(check-by-interp
 '(module
    (define fun/void8573 (lambda () (if #f (void) (void))))
    (call fun/void8573)))
(check-by-interp '(module (let () (or empty))))
(check-by-interp
 '(module (call pair? (let ((error0 (error 167)) (boolean1 #f)) (error 233)))))
(check-by-interp '(module (let () (let () (void)))))
(check-by-interp
 '(module
    (define fun/ascii-char8582 (lambda () #\H))
    (let ((void0 (if #t (void) (void)))) (call fun/ascii-char8582))))
(check-by-interp
 '(module
    (define fun/ascii-char8585 (lambda () (if #f #\r #\D)))
    (call fun/ascii-char8585)))
(check-by-interp
 '(module
    (define fun/ascii-char8591 (lambda (oprand0) (call fun/ascii-char8592)))
    (define fun/ascii-char8592 (lambda () #\L))
    (define fun/ascii-char8595 (lambda () #\v))
    (define fun/vector8594 (lambda () (vector 1 2 3 4 5 6 7 8)))
    (define fun/vector8593 (lambda (oprand0) (call fun/vector8594)))
    (call fun/ascii-char8591 (call fun/vector8593 (call fun/ascii-char8595)))))
(check-by-interp '(module (let () (let () empty))))
(check-by-interp
 '(module
    (define fun/ascii-char8602 (lambda () #\J))
    (define fun/ascii-char8604 (lambda () #\_))
    (define fun/ascii-char8603 (lambda () #\N))
    (begin
      (or (let ((pair0 '(141 498)) (boolean1 #f)) #\B)
          (begin #\V #\B)
          (let ((procedure0 (lambda () (void)))) #\Z)
          (call fun/ascii-char8602)
          (let ((fixnum0 12) (ascii-char1 #\R)) #\e))
      (or (call fun/ascii-char8603))
      (or (call fun/ascii-char8604)
          (let ((fixnum0 190) (error1 (error 40))) #\])
          (or #\L #\l)
          (and #\I #\p #\d #\L)
          (or #\T #\\ #\Y #\V #\y #\_ #\F))
      (let ((fixnum0 45)) #\j)
      (if #f #\A #\c)
      (if #f #\U #\e))))
(check-by-interp
 '(module
    (define fun/error8607 (lambda (oprand0) (error 187)))
    (let () (call fun/error8607 #t))))
(check-by-interp
 '(module
    (define fun/error8610 (lambda (oprand0) (error 137)))
    (if (if #f #f #t) (let () (error 47)) (call fun/error8610 6))))
(check-by-interp
 '(module
    (define fun/boolean8613 (lambda (oprand0) #t))
    (define fun/void8614 (lambda (oprand0) (void)))
    (if (call fun/boolean8613 #\I)
      (if #t (void) (void))
      (call fun/void8614 #f))))
(check-by-interp
 '(module
    (begin
      (let ((ascii-char0 #\r)) #\C)
      (if #f #\G #\R)
      (let () #\t)
      (let () #\t))))
(check-by-interp
 '(module
    (define fun/error8619 (lambda (oprand0) (error 75)))
    (if (if #f #t #f) (call fun/error8619 #f) (if #f (error 23) (error 167)))))
(check-by-interp
 '(module
    (define fun/ascii-char8622 (lambda () (call fun/ascii-char8623)))
    (define fun/ascii-char8623 (lambda () (call fun/ascii-char8624)))
    (define fun/ascii-char8624 (lambda () #\q))
    (call fun/ascii-char8622)))
(check-by-interp
 '(module
    (define fun/empty8627 (lambda (oprand0) (if #f empty empty)))
    (define fun/empty8630 (lambda () empty))
    (define fun/empty8629 (lambda (oprand0) empty))
    (define fun/empty8628 (lambda () empty))
    (and (let () empty)
         (call fun/empty8627 (let ((ascii-char0 #\B)) #t))
         (if #t empty empty)
         (if #t empty empty)
         (and (or empty empty empty empty empty empty empty)
              (if #t empty empty)
              (and empty empty empty empty empty)
              (if #f empty empty)
              (call fun/empty8628))
         (begin
           (call fun/empty8629 #f)
           (let ((fixnum0 174)) empty)
           (call fun/empty8630)
           (or empty empty empty empty)
           (let ((pair0 '(202 322)) (vector1 #(0 1 2 3 4 5 6 7))) empty)
           (or empty empty empty empty empty empty empty)))))
(check-by-interp
 '(module
    (if (if #t #f #t)
      (if #f (error 46) (error 150))
      (let ((procedure0 (lambda () 143))) (error 251)))))
(check-by-interp
 '(module
    (let ((error0 (if #t (error 72) (error 35)))
          (fixnum1 (or 162 92 198 13 140 114 150)))
      (or #f #t #t #f #f #t #t))))
(check-by-interp '(module (if (if #f #t #f) (let () (void)) (begin (void)))))
(check-by-interp
 '(module (if (if #t #t #t) (let ((ascii-char0 #\H)) 50) (begin 184 213 114))))
(check-by-interp
 '(module
    (and (let ((void0 (void)) (empty1 empty)) (error 173))
         (or (let ((boolean0 #t)) (error 149))
             (let ((pair0 '(227 467))) (error 230))
             (if #t (error 139) (error 80))))))
(check-by-interp
 '(module
    (define fun/empty8650 (lambda () (if #t empty empty)))
    (define fun/empty8649 (lambda () empty))
    (begin
      (or (if #f empty empty)
          (if #f empty empty)
          (call fun/empty8649)
          (and empty empty empty)
          (if #t empty empty)
          (if #f empty empty))
      (and (if #f empty empty)
           (let () empty)
           (or empty empty empty)
           (let ((procedure0 (lambda () '(98 276))) (boolean1 #f)) empty)
           (if #t empty empty))
      (call fun/empty8650)
      (begin (and empty empty) (if #t empty empty)))))
(check-by-interp
 '(module
    (define fun/error8653 (lambda () (call fun/error8654)))
    (define fun/error8654 (lambda () (call fun/error8655)))
    (define fun/error8655 (lambda () (error 74)))
    (call fun/error8653)))
(check-by-interp
 '(module
    (define fun/ascii-char8662 (lambda () (if #f #\i #\S)))
    (define fun/ascii-char8658 (lambda () (call fun/ascii-char8659)))
    (define fun/ascii-char8659 (lambda () #\f))
    (define fun/ascii-char8660 (lambda (oprand0) (call fun/ascii-char8661)))
    (define fun/ascii-char8661 (lambda () #\C))
    (begin
      (call fun/ascii-char8658)
      (let () #\Q)
      (call fun/ascii-char8660 (or empty))
      (call fun/ascii-char8662))))
(check-by-interp
 '(module
    (if (if #f #t #t)
      (let ((error0 (error 214))) (void))
      (if #f (void) (void)))))
(check-by-interp
 '(module
    (define fun/any7325 (lambda (oprand0 oprand1) (error 124)))
    (if (begin (let () #t) (let () #t))
      (error? (call fun/any7325 #\K (lambda () 713)))
      (if #f #f #t))))
(check-by-interp
 '(module
    (define fun/any8476 (lambda (oprand0) 169))
    (if (call void? (call fun/any8476 (lambda () 1020)))
      (let ((procedure0 (lambda () '(215 403)))
            (error1 (error 137))
            (error2 (error 179)))
        #f)
      (let ((vector0 #(0 1 2 3 4 5 6 7))) #t))))
(check-by-interp
 '(module
    (if (call fixnum? (if #t 194 (vector 1 2 3 4 5 6 7 8)))
      (let ((pair0 '(82 500))) empty)
      (let ((fixnum0 88)) empty))))
(check-by-interp
 '(module
    (define fun/empty8484 (lambda () (if #t empty empty)))
    (define fun/empty8483 (lambda () (call fun/empty8484)))
    (call fun/empty8483)))
(check-by-interp
 '(module
    (if (let ((ascii-char0 #\`)) #t)
      (if #f (void) (void))
      (if #t (void) (void)))))
(check-by-interp
 '(module
    (define fun/ascii-char8493 (lambda () #\d))
    (define fun/void8489 (lambda (oprand0 oprand1) (call fun/void8490)))
    (define fun/pair8497 (lambda (oprand0) (let ((boolean0 #t)) '(243 369))))
    (define fun/void8495 (lambda (oprand0 oprand1) (call fun/void8496)))
    (define fun/void8490 (lambda () (call fun/void8491)))
    (define fun/ascii-char8494 (lambda () #\e))
    (define fun/void8496 (lambda () (void)))
    (define fun/pair8498 (lambda () '(164 306)))
    (define fun/ascii-char8492
      (lambda (oprand0 oprand1) (call fun/ascii-char8493)))
    (define fun/void8491 (lambda () (void)))
    (call
     fun/void8489
     (and (call
           fun/ascii-char8492
           (if #t (error 139) (error 166))
           (let ((vector0 (vector 1 2 3 4 5 6 7 8))) (void)))
          (if #t #\j #\G)
          (begin
            (or #\h #\H)
            (let ((pair0 '(222 394)) (error1 (error 102))) #\E)
            (let ((boolean0 #f) (void1 (void)) (boolean2 #f)) #\s)
            (let ((boolean0 #f) (pair1 '(165 270)) (fixnum2 165)) #\k)
            (call fun/ascii-char8494)
            (let ((pair0 '(123 483)) (void1 (void)) (void2 (void))) #\D))
          (let () #\\))
     (call
      fun/void8495
      (call fun/pair8497 (call fun/pair8498))
      (let ((empty0 empty) (ascii-char1 #\d)) (lambda () 530))))))
(check-by-interp
 '(module
    (define fun/empty8501 (lambda (oprand0 oprand1) empty))
    (let ()
      (and (if #f empty empty)
           (begin empty empty empty empty)
           (call fun/empty8501 136 (lambda () 643))))))
(check-by-interp
 '(module
    (let ((void0 (let () (void)))
          (procedure1 (lambda () (let () #t)))
          (boolean2 (and (let () #f))))
      (and (if #f #\n #\v) (and #\E #\a #\b)))))
(check-by-interp
 '(module
    (let ((void0 (let ((pair0 '(107 481)) (boolean1 #t)) (void))))
      (if #f 61 215))))
(check-by-interp
 '(module
    (define fun/void8478 (lambda () (void)))
    (define fun/void8477 (lambda (oprand0) (call fun/void8478)))
    (define fun/ascii-char8479 (lambda (oprand0) #\F))
    (let () (call fun/void8477 (call fun/ascii-char8479 111)))))
(check-by-interp
 '(module
    (define fun/error8483 (lambda () (call fun/error8484)))
    (define fun/error8484 (lambda () (error 156)))
    (define fun/error8482 (lambda (oprand0) (call fun/error8483)))
    (call
     fun/error8482
     (if (call < 248 54)
       (begin (void) (void) (void) (void) (void))
       (let ((error0 (error 120))) (void))))))
(check-by-interp
 '(module
    (define fun/void8487 (lambda (oprand0 oprand1) oprand1))
    (define fun/void8488
      (lambda (oprand0) (vector-set! oprand0 3 #(0 1 2 3 4 5 6 7))))
    (let ()
      (and (let ((ascii-char0 #\j) (empty1 empty) (pair2 '(146 308))) (void))
           (call fun/void8487 148 (void))
           (call fun/void8488 (vector 1 2 3 4 5 6 7 8))
           (if #t (void) (void))))))
(check-by-interp
 '(module
    (define fun/empty8491
      (lambda (oprand0 oprand1) (let () (call fun/empty8492))))
    (define fun/empty8492 (lambda () empty))
    (define fun/error8493 (lambda (oprand0 oprand1) (error 123)))
    (call
     fun/empty8491
     (let ((error0 (if #t (error 178) (error 194))))
       (and (void) (void) (void) (void)))
     (if (let () #t) (let () (error 47)) (call fun/error8493 #t #t)))))
(check-by-interp
 '(module
    (define fun/pair8504 (lambda (oprand0 oprand1) '(175 296)))
    (define fun/void8499 (lambda (oprand0) (void)))
    (define fun/void8501
      (lambda (oprand0 oprand1) (vector-set! oprand0 5 #\I)))
    (define fun/void8498 (lambda () (void)))
    (define fun/fixnum8502 (lambda (oprand0) (let () 229)))
    (define fun/pair8503 (lambda () '(187 408)))
    (define fun/void8497 (lambda (oprand0 oprand1) (let () (void))))
    (define fun/void8500 (lambda (oprand0) (void)))
    (define fun/fixnum8496 (lambda (oprand0 oprand1) (let () (if #t 39 232))))
    (call
     fun/fixnum8496
     (and (call fun/void8497 (if #f 182 177) (if #f '(128 289) '(177 385)))
          (or (if #f (void) (void)))
          (let ((procedure0 (lambda () '(6 507)))
                (ascii-char1 #\M)
                (fixnum2 199))
            (void))
          (if #f (void) (void))
          (let ((empty0 empty)
                (procedure1 (lambda () (vector 1 2 3 4 5 6 7 8))))
            (void))
          (or (if #t (void) (void))
              (begin (void))
              (let ((boolean0 #t)
                    (error1 (error 35))
                    (procedure2 (lambda () empty)))
                (void))
              (call fun/void8498)
              (call fun/void8499 (error 96))
              (call fun/void8500 #f)
              (call fun/void8501 (vector 1 2 3 4 5 6 7 8) (error 127))))
     (call
      fun/fixnum8502
      (begin
        (and '(234 272))
        (let ((error0 (error 104))
              (procedure1 (lambda () #(0 1 2 3 4 5 6 7)))
              (ascii-char2 #\M))
          '(43 459))
        (or '(92 487))
        (begin '(23 399) '(163 314))
        (call fun/pair8503)
        (if #t '(59 331) '(18 310))
        (call fun/pair8504 (void) (lambda () 998)))))))
(check-by-interp
 '(module
    (define fun/empty8510 (lambda (oprand0 oprand1) empty))
    (define fun/empty8513 (lambda (oprand0) (call fun/empty8514)))
    (define fun/empty8514 (lambda () empty))
    (define fun/fixnum8507
      (lambda (oprand0 oprand1)
        (if (if #t #t #f) (call fun/fixnum8508) (call fun/fixnum8509))))
    (define fun/empty8511 (lambda (oprand0 oprand1) empty))
    (define fun/empty8512 (lambda () empty))
    (define fun/fixnum8509 (lambda () 4))
    (define fun/fixnum8508 (lambda () 17))
    (call
     fun/fixnum8507
     (and (and (call fun/empty8510 (error 189) '(54 464))
               (call fun/empty8511 #t 41)
               (if #f empty empty)
               (call fun/empty8512)
               (let ((error0 (error 217)) (boolean1 #t)) empty)
               (let () empty))
          (call fun/empty8513 (if #t (lambda () 622) (lambda () 523))))
     (if (< 93 14)
       (let ((boolean0 #t) (vector1 (vector 1 2 3 4 5 6 7 8)) (boolean2 #f))
         (void))
       (let ((empty0 empty) (empty1 empty)) (void))))))
(check-by-interp
 '(module
    (define fun/boolean8517 (lambda (oprand0) #f))
    (or (if (call fun/boolean8517 (lambda () 918))
          (or #\L)
          (let ((vector0 (vector 1 2 3 4 5 6 7 8))
                (void1 (void))
                (boolean2 #f))
            #\v)))))
(check-by-interp
 '(module
    (define fun/vector8521 (lambda (oprand0 oprand1) (if #f oprand0 oprand0)))
    (define fun/fixnum8520 (lambda (oprand0) (let () 69)))
    (call
     *
     (call
      fun/fixnum8520
      (call
       fun/vector8521
       (let () (vector 1 2 3 4 5 6 7 8))
       (if #f '(25 278) '(168 487))))
     (if (let () #f) (begin 232 165 174) (if #f 106 28)))))
(check-by-interp
 '(module
    (define fun/fixnum8525 (lambda () (call fun/fixnum8526)))
    (define fun/empty8524 (lambda () (if #f empty empty)))
    (define fun/fixnum8526 (lambda () 54))
    (let ((empty0 (call fun/empty8524)) (ascii-char1 (if #f #\P #\J)))
      (call fun/fixnum8525))))
(check-by-interp
 '(module
    (define fun/fixnum8529 (lambda (oprand0 oprand1) (let () 49)))
    (define fun/fixnum8530 (lambda () 148))
    (if (let () #f)
      (call
       fun/fixnum8529
       (let ((ascii-char0 #\v)) (error 22))
       (call fun/fixnum8530))
      (if #t 68 222))))
(check-by-interp
 '(module
    (define fun/void8536 (lambda () (void)))
    (define fun/empty8533 (lambda (oprand0) (call fun/empty8534)))
    (define fun/empty8534 (lambda () (if #t empty empty)))
    (define fun/ascii-char8535 (lambda () #\V))
    (call
     fun/empty8533
     (let ((ascii-char0 (call fun/ascii-char8535))
           (void1 (if #t (void) (void)))
           (void2 (call fun/void8536)))
       (if #f (vector 1 2 3 4 5 6 7 8) (vector 1 2 3 4 5 6 7 8))))))
(check-by-interp
 '(module
    (define fun/empty8542 (lambda (oprand0) empty))
    (define fun/empty8544 (lambda () (call fun/empty8545)))
    (define fun/empty8539 (lambda (oprand0) empty))
    (define fun/empty8545 (lambda () empty))
    (define fun/empty8547 (lambda () (let () empty)))
    (define fun/void8541 (lambda () (void)))
    (define fun/empty8546 (lambda (oprand0) empty))
    (define fun/void8540 (lambda () (void)))
    (define fun/empty8543 (lambda (oprand0 oprand1) empty))
    (begin
      (if (call >= 2 186)
        (call fun/empty8539 #t)
        (let ((procedure0 (lambda (oprand0 oprand1) #\_))) empty))
      (let ((fixnum0 (or 131 147 135 70))
            (vector1
             #(((make-vector 8))
               (#t)
               (#t)
               (empty)
               (#\_)
               (111)
               (194)
               ((lambda () 699))))
            (error2 (or (error 173) (error 54) (error 170) (error 170))))
        (and empty empty empty empty empty))
      (let ((void0 (call fun/void8540))
            (ascii-char1 (let () #\t))
            (void2 (call fun/void8541)))
        (and empty empty empty))
      (and (if #f empty empty)
           (let ((boolean0 #t) (pair1 '(42 383))) empty)
           (if #t empty empty)
           (let () empty)
           (let ((vector0 (vector 1 2 3 4 5 6 7 8))
                 (procedure1 (lambda () empty))
                 (empty2 empty))
             empty)
           (if #f empty empty))
      (begin
        (begin
          (if #f empty empty)
          (or empty empty empty empty empty)
          (let ((boolean0 #f)) empty)
          (let ((pair0 '(205 503)) (boolean1 #f) (pair2 '(178 296))) empty)
          (call fun/empty8542 (error 60))
          (and empty empty))
        (let ((vector0 #(0 1 2 3 4 5 6 7))
              (pair1 '(168 348))
              (error2 (error 250)))
          empty)
        (begin
          (begin empty empty)
          (if #f empty empty)
          (call fun/empty8543 #f #\l)
          (or empty empty empty empty empty)
          (if #t empty empty)
          (if #f empty empty))
        (call fun/empty8544)
        (or (let ((ascii-char0 #\G) (vector1 #(0 1 2 3 4 5 6 7)) (boolean2 #f))
              empty)
            (let ((fixnum0 247) (ascii-char1 #\T)) empty)
            (call fun/empty8546 (lambda () 652))
            (let ((vector0 #(0 1 2 3 4 5 6 7)) (fixnum1 146)) empty)
            (or empty empty empty empty)
            (let ((fixnum0 152) (error1 (error 182))) empty))
        (call fun/empty8547)))))
(check-by-interp
 '(module
    (define fun/fixnum8552 (lambda () (call fun/fixnum8553 235)))
    (define fun/boolean8550 (lambda (oprand0 oprand1) (call fun/boolean8551)))
    (define fun/fixnum8553 (lambda (oprand0) oprand0))
    (define fun/boolean8551 (lambda () #f))
    (if (call
         fun/boolean8550
         (if #t #\C #\o)
         (begin
           '(107 348)
           '(203 496)
           '(79 267)
           '(239 409)
           '(77 484)
           '(220 290)
           '(89 469)))
      (call fun/fixnum8552)
      (let () 134))))
(check-by-interp
 '(module
    (define fun/fixnum8556 (lambda (oprand0 oprand1) (if #t 71 190)))
    (if (let ((pair0 '(177 360)) (empty1 empty) (boolean2 #f)) #t)
      (let ((pair0 '(210 266))) 198)
      (call fun/fixnum8556 (if #t empty empty) (begin '(103 399) '(19 508))))))
(check-by-interp
 '(module
    (define fun/pair8560 (lambda (oprand0) '(5 421)))
    (define fun/procedure8559 (lambda () (lambda () 550)))
    (let ((vector0
           #(((let () (void)))
             ((let () 84))
             ((let ((pair0 '(115 428)) (empty1 empty)) (void)))
             ((or 69 50 147 112 173))
             ((let () empty))
             ((call fun/procedure8559))
             ((if #f empty empty))
             ((call fun/pair8560 #t)))))
      (if #f #\J #\`))))
(check-by-interp
 '(module
    (define fun/error7326 (lambda () (if #f (error 41) (error 41))))
    (define fun/any7325 (lambda () (vector 1 2 3 4 5 6 7 8)))
    (define fun/error7327 (lambda (oprand0 oprand1) (error 150)))
    (if (ascii-char? (call fun/any7325))
      (call fun/error7326)
      (or (and (error 73) (error 249) (error 226))
          (begin (error 136) (error 134) (error 216) (error 132))
          (if #t (error 103) (error 151))
          (call fun/error7327 (void) (vector 1 2 3 4 5 6 7 8))
          (let ((fixnum0 172)) (error 184))
          (begin (error 89) (error 219))))))
(check-by-interp
 '(module
    (define fun/ascii-char8478 (lambda () (if #t #\t #\O)))
    (if (or (if #t #t #t)
            (let () #t)
            (begin #t #t #f #t #f #f #t)
            (and #f #t #f #t))
      (let () #\k)
      (call fun/ascii-char8478))))
(check-by-interp
 '(module (let ((boolean0 (ascii-char? (if #f #\l 229)))) (let () (void)))))
(check-by-interp
 '(module
    (define fun/fixnum8485 (lambda (oprand0) oprand0))
    (define fun/boolean8483 (lambda (oprand0 oprand1) (let () #t)))
    (define fun/fixnum8484 (lambda () (call fun/fixnum8485 41)))
    (if (call
         fun/boolean8483
         (if #t (void) (void))
         (or (lambda () 845)
             (lambda () 630)
             (lambda () 689)
             (lambda () 943)
             (lambda () 1016)
             (lambda () 978)
             (lambda () 974)))
      (call fun/fixnum8484)
      (if #t 109 42))))
(check-by-interp
 '(module
    (define fun/pair8489 (lambda () '(183 488)))
    (define fun/pair8488 (lambda () '(88 319)))
    (let ((ascii-char0 (if #t #\T #\Q))
          (vector1
           #(((let () empty))
             ((error? (lambda () 656)))
             ((call fun/pair8488))
             ((if #t (error 221) (error 62)))
             ((empty? (void)))
             ((if #f empty empty))
             ((call fun/pair8489))
             ((if #f '(201 424) '(65 350))))))
      (let () (void)))))
(check-by-interp
 '(module
    (begin
      (begin
        (let ((empty0 empty) (fixnum1 21) (ascii-char2 #\F)) (void))
        (let () (void))
        (if #f (void) (void))))))
(check-by-interp
 '(module
    (define fun/empty8494
      (lambda ()
        (call fun/empty8495 (call fun/procedure8496 (call fun/fixnum8498)))))
    (define fun/fixnum8498 (lambda () 65))
    (define fun/procedure8496 (lambda (oprand0) (call fun/procedure8497)))
    (define fun/procedure8497 (lambda () (lambda () 609)))
    (define fun/empty8495 (lambda (oprand0) (let () empty)))
    (call fun/empty8494)))
(check-by-interp
 '(module
    (define fun/error8502 (lambda () (call fun/error8503)))
    (define fun/error8501 (lambda (oprand0) (call fun/error8502)))
    (define fun/error8503 (lambda () (error 198)))
    (define fun/ascii-char8504 (lambda () (let ((fixnum0 151)) #\v)))
    (call fun/error8501 (call fun/ascii-char8504))))
(check-by-interp
 '(module
    (define fun/fixnum8511 (lambda () 138))
    (define fun/fixnum8507 (lambda (oprand0 oprand1) (call fun/fixnum8508)))
    (define fun/fixnum8508 (lambda () (call fun/fixnum8509)))
    (define fun/fixnum8509 (lambda () 2))
    (define fun/boolean8510 (lambda (oprand0 oprand1) #t))
    (call
     fun/fixnum8507
     (if (call fun/boolean8510 #(0 1 2 3 4 5 6 7) (void))
       (let ((ascii-char0 #\f)
             (ascii-char1 #\L)
             (procedure2 (lambda () (error 84))))
         172)
       (call fun/fixnum8511))
     (let ()
       (let ((error0 (error 108)) (fixnum1 32) (void2 (void)))
         (lambda () 674))))))
(check-by-interp
 '(module
    (define fun/empty8515 (lambda () empty))
    (define fun/empty8514 (lambda () (call fun/empty8515)))
    (let ((boolean0 (<= (let () 15) (let ((void0 (void))) 193))))
      (call fun/empty8514))))
(check-by-interp
 '(module
    (define fun/ascii-char8518 (lambda () #\C))
    (define fun/ascii-char8520 (lambda (oprand0) oprand0))
    (define fun/fixnum8523 (lambda (oprand0) 219))
    (define fun/ascii-char8522 (lambda (oprand0) #\]))
    (define fun/ascii-char8521
      (lambda () (call fun/ascii-char8522 (call fun/fixnum8523 (error 113)))))
    (define fun/ascii-char8519
      (lambda (oprand0 oprand1) (if #t oprand0 oprand0)))
    (and (let ((void0 (let () (void)))
               (pair1 '(#\M #\\ (118 358) (16 483) empty #t #t #t)))
           (call fun/ascii-char8518))
         (and (call fun/ascii-char8519 (or #\d) (if #t '(212 434) '(140 331)))
              (let () #\T)
              (if #f #\_ #\J)
              (let ((procedure0 (lambda (oprand0) 53)) (pair1 '(151 317)))
                #\b))
         (let ((boolean0
                (let ((empty0 empty)
                      (procedure1 (lambda () #(0 1 2 3 4 5 6 7))))
                  #t)))
           (call fun/ascii-char8520 #\g))
         (call fun/ascii-char8521)
         (and (let () #\k)
              (let ((vector0 (vector 1 2 3 4 5 6 7 8))) #\\)
              (if #t #\x #\n))
         (let ((ascii-char0 (if #t #\x #\o)) (void1 (let () (void))))
           (if #t #\C #\Z)))))
(check-by-interp
 '(module
    (define fun/ascii-char8527 (lambda () (call fun/ascii-char8528)))
    (define fun/ascii-char8528 (lambda () (let ((pair0 '(127 352))) #\Y)))
    (define fun/ascii-char8526
      (lambda (oprand0 oprand1) (let () (let () oprand0))))
    (define fun/void8530 (lambda (oprand0) (call fun/void8531)))
    (define fun/void8531 (lambda () (void)))
    (define fun/void8529
      (lambda ()
        (call fun/void8530 (let ((fixnum0 149) (empty1 empty)) (error 140)))))
    (call fun/ascii-char8526 (call fun/ascii-char8527) (call fun/void8529))))
(check-by-interp
 '(module
    (define fun/ascii-char8545 (lambda () (call fun/ascii-char8546)))
    (define fun/ascii-char8542
      (lambda (oprand0 oprand1) (call fun/ascii-char8543)))
    (define fun/ascii-char8536 (lambda () #\b))
    (define fun/ascii-char8539 (lambda (oprand0 oprand1) (let () #\l)))
    (define fun/ascii-char8535 (lambda () (call fun/ascii-char8536)))
    (define fun/boolean8540 (lambda (oprand0 oprand1) (let () #f)))
    (define fun/void8537 (lambda () (void)))
    (define fun/ascii-char8538 (lambda () #\J))
    (define fun/ascii-char8543 (lambda () #\x))
    (define fun/ascii-char8546 (lambda () #\O))
    (define fun/boolean8548 (lambda () #t))
    (define fun/boolean8547 (lambda () (call fun/boolean8548)))
    (define fun/fixnum8541 (lambda () 67))
    (define fun/ascii-char8544
      (lambda (oprand0 oprand1) (call fun/ascii-char8545)))
    (define fun/ascii-char8534
      (lambda (oprand0 oprand1) (call fun/ascii-char8535)))
    (begin
      (call
       fun/ascii-char8534
       (if #f (lambda () 968) (lambda () 631))
       (let () empty))
      (if (let ((boolean0 #f) (empty1 empty)) #f)
        (let ((error0 (error 211)) (ascii-char1 #\U)) #\b)
        (begin #\f #\` #\a #\O #\` #\O #\J))
      (let ((pair0 '((8 450) (143 368) 110 empty empty #t #\B empty))
            (vector1
             #(((lambda () 902))
               ((error 179))
               ('(17 299))
               (#\E)
               ((void))
               ((vector 1 2 3 4 5 6 7 8))
               (empty)
               ((lambda () 959))))
            (void2 (call fun/void8537)))
        (call fun/ascii-char8538))
      (call
       fun/ascii-char8539
       (if #f #f #t)
       (call
        fun/boolean8540
        (or empty empty empty empty)
        (call fun/fixnum8541)))
      (and (if #t #\i #\[)
           (call
            fun/ascii-char8542
            (let ((fixnum0 241) (boolean1 #f)) (void))
            (if #f #f #f))
           (let ((boolean0 #f) (boolean1 #f)) #\m)
           (if #t #\Y #\W))
      (call
       fun/ascii-char8544
       (call procedure? (if #f (error 129) #\`))
       (call fun/boolean8547)))))
(check-by-interp
 '(module
    (define fun/empty8551 (lambda () (call fun/empty8552)))
    (define fun/empty8552 (lambda () empty))
    (let ((procedure0 (lambda (oprand0 oprand1) (call fun/empty8551))))
      (let () (error 218)))))
(check-by-interp
 '(module
    (define fun/empty8561 (lambda (oprand0) empty))
    (define fun/error8560
      (lambda (oprand0 oprand1) (let () (if #f (error 4) (error 184)))))
    (define fun/empty8562 (lambda (oprand0 oprand1) empty))
    (define fun/boolean8563 (lambda (oprand0) #f))
    (call
     fun/error8560
     (if (if #f #f #f)
       (call fun/empty8561 (void))
       (call fun/empty8562 (vector 1 2 3 4 5 6 7 8) (lambda () 807)))
     (if (call fun/boolean8563 (vector 1 2 3 4 5 6 7 8))
       (if #t #t #f)
       (let () #f)))))
(check-by-interp
 '(module
    (define fun/fixnum8572 (lambda () (call fun/fixnum8573)))
    (define fun/fixnum8575 (lambda () 182))
    (define fun/fixnum8573 (lambda () 219))
    (define fun/fixnum8574 (lambda () (call fun/fixnum8575)))
    (let ((fixnum0 (call fun/fixnum8572))
          (error1 (and (let () (error 252))))
          (empty2 (let () empty)))
      (call fun/fixnum8574))))
(check-by-interp
 '(module
    (define fun/empty8585 (lambda () (call fun/empty8586)))
    (define fun/empty8584 (lambda (oprand0) (call fun/empty8585)))
    (define fun/empty8586 (lambda () empty))
    (call
     fun/empty8584
     (let ((error0
            (begin (error 207) (error 104) (error 16) (error 167) (error 61)))
           (error1
            (and (error 129)
                 (error 74)
                 (error 177)
                 (error 101)
                 (error 159)
                 (error 164))))
       (begin (error 161) (error 194) (error 177))))))
(check-by-interp
 '(module
    (define fun/error8591 (lambda () (error 47)))
    (define fun/pair8592 (lambda (oprand0) (if #f '(232 299) '(190 484))))
    (define fun/error8589 (lambda (oprand0 oprand1) (call fun/error8590)))
    (define fun/error8590 (lambda () (call fun/error8591)))
    (call
     fun/error8589
     (call fun/pair8592 (let ((ascii-char0 #\_) (fixnum1 180)) (void)))
     (let ((vector0
            #((empty)
              ((error 230))
              ((void))
              ('(167 385))
              ((void))
              (empty)
              (#\c)
              (#\t)))
           (vector1
            #(((error 207))
              ((lambda () 674))
              ((vector 1 2 3 4 5 6 7 8))
              (#(0 1 2 3 4 5 6 7))
              (#f)
              ('(232 259))
              (#f)
              ((void)))))
       (let ((empty0 empty)) #\i)))))
(check-by-interp
 '(module
    (define fun/empty8599
      (lambda (oprand0)
        (if (let () #f) (call fun/empty8600) (call fun/empty8601))))
    (define fun/empty8600 (lambda () empty))
    (define fun/empty8601 (lambda () empty))
    (call
     fun/empty8599
     (if (if #t #t #f)
       (let ((boolean0 #f) (empty1 empty) (pair2 '(41 412))) 165)
       (let ((vector0 (vector 1 2 3 4 5 6 7 8)) (fixnum1 112)) 110)))))
(check-by-interp
 '(module
    (define fun/boolean8604 (lambda () (call fun/boolean8605 #f)))
    (define fun/ascii-char8607 (lambda (oprand0 oprand1) #\J))
    (define fun/boolean8605 (lambda (oprand0) oprand0))
    (define fun/ascii-char8606 (lambda (oprand0 oprand1) #\d))
    (if (call fun/boolean8604)
      (let ((empty0 empty)) #\g)
      (or (and #\R)
          (call fun/ascii-char8606 (void) #t)
          (call fun/ascii-char8607 '(124 438) (lambda () 729))
          (let ((error0 (error 165)) (error1 (error 92))) #\n)))))
(check-by-interp
 '(module
    (define fun/boolean8612 (lambda (oprand0) #f))
    (define fun/boolean8611 (lambda () (call fun/boolean8612 empty)))
    (define fun/boolean8610 (lambda () (if #f #t #f)))
    (if (call fun/boolean8610) (call fun/boolean8611) (if #t #t #t))))
(check-by-interp
 '(module
    (define fun/boolean8615 (lambda (oprand0 oprand1) oprand0))
    (define fun/boolean8620 (lambda () #t))
    (define fun/pair8619 (lambda () '(87 327)))
    (define fun/boolean8617 (lambda (oprand0 oprand1) (call fun/boolean8618)))
    (define fun/boolean8618 (lambda () #f))
    (define fun/any8616 (lambda (oprand0) #f))
    (or (call fun/boolean8615 (let () #t) (if #f #f #t))
        (or (call void? (call fun/any8616 (lambda () 764)))
            (call
             fun/boolean8617
             (call fun/pair8619)
             (if #f (error 130) (error 231)))
            (or (call fun/boolean8620))))))
(check-by-interp
 '(module
    (define fun/fixnum8628 (lambda (oprand0 oprand1) 40))
    (define fun/fixnum8625 (lambda (oprand0 oprand1) 150))
    (define fun/boolean8624 (lambda () #f))
    (define fun/fixnum8623
      (lambda (oprand0 oprand1) (if (call fun/boolean8624) oprand1 oprand1)))
    (define fun/fixnum8626 (lambda () 248))
    (define fun/fixnum8627 (lambda () 9))
    (call
     fun/fixnum8623
     (and (or (if #f (error 187) (error 49))
              (let ((boolean0 #f)
                    (ascii-char1 #\K)
                    (procedure2 (lambda () 176)))
                (error 222))
              (let () (error 137))
              (let () (error 215))
              (let ((vector0 #(0 1 2 3 4 5 6 7)) (error1 (error 145)))
                (error 187))
              (if #t (error 104) (error 57))
              (let () (error 110)))
          (let ((error0 (error 197)) (error1 (error 17))) (error 143))
          (if #t (error 11) (error 74))
          (let ((boolean0 #f) (boolean1 #f) (fixnum2 69)) (error 137)))
     (and (or (call fun/fixnum8625 (error 175) (vector 1 2 3 4 5 6 7 8))
              (call fun/fixnum8626)
              (call fun/fixnum8627)
              (if #f 197 59)
              (let ((empty0 empty) (error1 (error 52)) (boolean2 #f)) 82))
          (and (begin 32)
               (call fun/fixnum8628 #(0 1 2 3 4 5 6 7) empty)
               (let ((pair0 '(182 324)) (error1 (error 85))) 6)
               (and 113)
               (let ((boolean0 #f) (error1 (error 212))) 58)
               (if #f 124 111))
          (if #t 60 147)
          (begin
            (if #f 74 149)
            (and 18 18 233 91 193)
            (or 235 137)
            (if #t 238 229)
            (let ((vector0 (vector 1 2 3 4 5 6 7 8))
                  (empty1 empty)
                  (vector2 #(0 1 2 3 4 5 6 7)))
              217))
          (call
           -
           (let ((void0 (void)) (pair1 (cons #\O #f))) 76)
           (let ((empty0 empty)
                 (boolean1 #t)
                 (vector2 (vector 1 2 3 4 5 6 7 8)))
             153))
          (or (and 2 39 133 67 231 24 90)
              (let () 98)
              (or 35 137 221 20 185 134)
              (or 208 29 116 147)
              (if #f 16 82)
              (if #t 165 6))))))
(check-by-interp
 '(module
    (define fun/boolean8631 (lambda (oprand0) #t))
    (define fun/pair8635 (lambda (oprand0) '(16 418)))
    (define fun/fixnum8634 (lambda () 33))
    (define fun/fixnum8636 (lambda () (if #f 72 52)))
    (define fun/boolean8632 (lambda () #t))
    (define fun/fixnum8633 (lambda (oprand0) (call fun/fixnum8634)))
    (if (or (call fun/boolean8631 #\f)
            (> 237 82)
            (let () #t)
            (<= 191 13)
            (call fun/boolean8632))
      (call fun/fixnum8633 (call fun/pair8635 #\F))
      (call fun/fixnum8636))))
(check-by-interp
 '(module
    (define fun/void8639 (lambda (oprand0) (if #t (void) (void))))
    (define fun/void8640 (lambda (oprand0 oprand1) (void)))
    (if (if #f #t #t)
      (call fun/void8639 (if #t #t #t))
      (or (call fun/void8640 #t #\I)
          (if #f (void) (void))
          (let () (void))
          (if #t (void) (void))
          (or (void) (void) (void) (void) (void))
          (or (void) (void))))))
(check-by-interp
 '(module
    (define fun/empty8643 (lambda (oprand0 oprand1) oprand0))
    (call
     fun/empty8643
     (begin (if #t empty empty))
     (ascii-char? (let ((vector0 (make-vector 8))) 146)))))
(check-by-interp
 '(module
    (define fun/fixnum8646 (lambda (oprand0) 187))
    (define fun/fixnum8647 (lambda () 188))
    (define fun/fixnum8648 (lambda (oprand0 oprand1) oprand1))
    (define fun/fixnum8649 (lambda (oprand0 oprand1) 114))
    (call
     >
     (begin (begin (call fun/fixnum8646 #\q) (if #f 81 95)))
     (and (+ (and 251 7 101 18 141 162 193) (and 104 226 68 97 159 210))
          (let ((procedure0 (lambda (oprand0 oprand1) oprand0))) 198)
          (or (let () 226)
              (call - 94 208)
              (if #f 33 168)
              (call fun/fixnum8647)
              (let ((boolean0 #t) (ascii-char1 #\Q)) 98)
              (let ((boolean0 #t) (boolean1 #f) (vector2 #(0 1 2 3 4 5 6 7)))
                58)
              (let ((void0 (void)) (error1 (error 253)) (pair2 '(103 494)))
                245))
          (let ((boolean0 #t) (pair1 '(131 435)) (procedure2 (lambda () 174)))
            130)
          (and (if #t 35 220)
               (if #t 36 135)
               (call fun/fixnum8648 '(124 432) 82)
               (or 152 68 140 42)
               (call fun/fixnum8649 empty #\j)
               (if #f 143 40))
          (if #t 8 110)))))
(check-by-interp
 '(module
    (define fun/void8652 (lambda (oprand0 oprand1) (void)))
    (define fun/void8656 (lambda (oprand0 oprand1) (if #t (void) (void))))
    (define fun/void8655 (lambda () (void)))
    (define fun/void8654 (lambda (oprand0) (let ((empty0 empty)) (void))))
    (define fun/void8653 (lambda (oprand0 oprand1) (let () (void))))
    (begin
      (if (let ((boolean0 #f) (pair1 '(247 312)) (error2 (error 55))) #f)
        (call fun/void8652 #\O empty)
        (begin (void) (void)))
      (if (begin #t #f)
        (if #t (void) (void))
        (begin (void) (void) (void) (void) (void) (void)))
      (call
       fun/void8653
       (if #t '(38 339) '(84 401))
       (let ((error0 (error 143)) (error1 (error 119))) (error 96)))
      (begin
        (and (let ((ascii-char0 #\M) (vector1 #(0 1 2 3 4 5 6 7))) (void))
             (begin (void) (void) (void)))
        (let ((vector0 #(0 1 2 3 4 5 6 7)) (error1 (error 186))) (void))
        (let ((procedure0 (lambda () 121))) (void))
        (call fun/void8654 (if #t #\a #\r))
        (if #t (void) (void))
        (if #f (void) (void))
        (if #f (void) (void)))
      (let ((void0 (call fun/void8655)))
        (let ((pair0 '(100 256)) (pair1 '(1 424))) (void)))
      (call
       fun/void8656
       (let ((ascii-char0 #\B) (pair1 '(147 339))) #\N)
       (let ((vector0 (vector 1 2 3 4 5 6 7 8)) (procedure1 (lambda () 228)))
         (error 218))))))
(check-by-interp
 '(module
    (define fun/void8659 (lambda (oprand0) (void)))
    (let ((void0 (let ((ascii-char0 #\s)) (void))))
      (and (if #f (void) (void))
           (begin (void) (void))
           (call fun/void8659 #f)))))
(check-by-interp
 '(module
    (define fun/error8662
      (lambda () (let ((ascii-char0 #\N) (ascii-char1 #\R)) (error 192))))
    (and (if (let ((void0 (void)) (boolean1 #f) (vector2 (make-vector 8))) #f)
           (if #f (error 241) (error 134))
           (let ((fixnum0 190) (error1 (error 76))) (error 56)))
         (let ((empty0 (begin empty empty empty empty))
               (pair1 '(134 (154 498) 95 empty #\M (118 510) #f #\])))
           (if #t (error 132) (error 79)))
         (call fun/error8662))))
(check-by-interp
 '(module
    (define fun/empty8665 (lambda (oprand0) (let ((void0 (void))) empty)))
    (if (let () #f)
      (call
       fun/empty8665
       (let ((vector0 #(0 1 2 3 4 5 6 7)) (empty1 empty)) #\H))
      (let ((vector0 (vector 1 2 3 4 5 6 7 8)) (boolean1 #t)) empty))))
(check-by-interp
 '(module
    (define fun/fixnum8668 (lambda () 84))
    (define fun/pair8669 (lambda () '(33 355)))
    (define fun/fixnum8670 (lambda () 116))
    (let ((vector0
           #(((let () (error 47)))
             ((and (error 83)))
             ((if #t '(212 273) '(6 506)))
             ((begin (make-vector 8) #(0 1 2 3 4 5 6 7) #(0 1 2 3 4 5 6 7)))
             ((call fun/fixnum8668))
             ((call fun/pair8669))
             ((if #t empty empty))
             ((call fun/fixnum8670))))
          (empty1 (let () empty)))
      (let ((procedure0 (lambda () empty))) (void)))))
(check-by-interp
 '(module
    (define fun/error8673 (lambda () (call fun/error8674)))
    (define fun/error8674 (lambda () (error 213)))
    (define fun/error8675 (lambda () (call fun/error8676)))
    (define fun/error8676 (lambda () (error 24)))
    (let ((fixnum0 (let () 133))
          (error1 (call fun/error8673))
          (procedure2 (lambda () (call fun/error8675))))
      (if #t 142 249))))
(check-by-interp
 '(module
    (let ((void0 (if #t (void) (void))) (empty1 (if #t empty empty)))
      (if #f #\X #\M))))
(check-by-interp
 '(module
    (define fun/boolean8687 (lambda () #f))
    (define fun/boolean8686 (lambda (oprand0) (call fun/boolean8687)))
    (define fun/boolean8685 (lambda () #f))
    (define fun/void8681 (lambda (oprand0) (call fun/void8682)))
    (define fun/boolean8684 (lambda () (call fun/boolean8685)))
    (define fun/void8682 (lambda () (if #f (void) (void))))
    (define fun/boolean8683 (lambda (oprand0 oprand1) (call fun/boolean8684)))
    (call
     fun/void8681
     (call
      fun/boolean8683
      (if #f (vector 1 2 3 4 5 6 7 8) (vector 1 2 3 4 5 6 7 8))
      (call fun/boolean8686 (if #t (lambda () 628) (lambda () 577)))))))
(check-by-interp
 '(module
    (define fun/error8693 (lambda (oprand0) (error 130)))
    (define fun/boolean8690 (lambda () (if #f #f #f)))
    (define fun/empty8691 (lambda (oprand0 oprand1) (call fun/empty8692)))
    (define fun/empty8692 (lambda () empty))
    (if (call fun/boolean8690)
      (let ((empty0 empty)) empty)
      (call fun/empty8691 (call fun/error8693 #\r) (begin #\x #\U #\O)))))
(check-by-interp
 '(module
    (define fun/empty8699 (lambda () empty))
    (define fun/empty8698 (lambda () empty))
    (define fun/ascii-char8697 (lambda () #\Y))
    (define fun/procedure8696 (lambda () (lambda () 758)))
    (let ((vector0
           #(((call fun/procedure8696))
             ((let () empty))
             ((if #t empty empty))
             ((let () #\_))
             ((begin 156 226 114))
             ((void? 9))
             ((let () '(41 429)))
             ((call fun/ascii-char8697))))
          (error1
           (and (or (error 116) (error 83))
                (if #t (error 231) (error 0))
                (let () (error 12))
                (if #f (error 179) (error 209))
                (let () (error 198))))
          (void2 (if #f (void) (void))))
      (or (if #t empty empty)
          (let () empty)
          (call fun/empty8698)
          (begin empty empty empty)
          (and empty empty)
          (if #t empty empty)
          (call fun/empty8699)))))
(check-by-interp
 '(module
    (define fun/error8703 (lambda () (error 178)))
    (define fun/error8702 (lambda (oprand0) (call fun/error8703)))
    (let () (call fun/error8702 (if #t (lambda () 781) (lambda () 718))))))
(check-by-interp
 '(module
    (define fun/ascii-char8706 (lambda () #\D))
    (let ((empty0 (if #t empty empty)))
      (or (if #f #\m #\w)
          (call fun/ascii-char8706)
          (let ((error0 (error 46)) (boolean1 #f)) #\N)
          (if #t #\` #\M)
          (begin #\n #\L #\c)
          (if #t #\L #\m)
          (and #\u #\I #\S #\T)))))
(check-by-interp
 '(module
    (define fun/void8714 (lambda () (let ((void0 (void))) (void))))
    (define fun/void8713 (lambda () (call fun/void8714)))
    (call fun/void8713)))
