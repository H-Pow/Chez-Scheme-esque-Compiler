#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         cpsc411/langs/v11
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

(check-by-interp '(module #t))
(check-by-interp '(module #t))
(check-by-interp '(module 226))
(check-by-interp '(module (void)))
(check-by-interp '(module (let () (error 209))))
(check-by-interp '(module (let () (error 221))))
(check-by-interp
 '(module
    (let ((g42027422 #\b))
      (if (call error? g42027422)
        g42027422
        (let ((g42027423 #\_))
          (if (call error? g42027423)
            g42027423
            (let ((g42027424 #\c))
              (if (call error? g42027424)
                g42027424
                (let ((g42027425 #\q))
                  (if (call error? g42027425)
                    g42027425
                    (let ((g42027426 #\V))
                      (if (call error? g42027426)
                        g42027426
                        (let ((g42027427 #\p))
                          (if (call error? g42027427)
                            g42027427
                            #\R))))))))))))))
(check-by-interp
 '(module
    (let ((g42031243 (error 172)))
      (if (call error? g42031243) g42031243 (error 172)))))
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
    (let ((g42050319
           (let ((g42050320 #\V))
             (if (call error? g42050320)
               g42050320
               (let ((g42050321 #\f))
                 (if (call error? g42050321)
                   g42050321
                   (let ((g42050322 #\E))
                     (if (call error? g42050322)
                       g42050322
                       (let ((g42050323 #\n))
                         (if (call error? g42050323) g42050323 #\\))))))))))
      (if (call error? g42050319)
        g42050319
        (let ((g42050324 (let () #\I)))
          (if (call error? g42050324)
            g42050324
            (let ((void0 (void))) #\k)))))))
(check-by-interp
 '(module
    (define fun/ascii-char8506 (lambda () #\L))
    (define fun/ascii-char8507 (lambda () #\i))
    (let ((tmp.7
           (let ((procedure0
                  (lambda ()
                    (let ((tmp.8 (call make-vector 8)))
                      (let ((g42054139 (call vector-set! tmp.8 0 1)))
                        (if (call error? g42054139)
                          g42054139
                          (let ((g42054140 (call vector-set! tmp.8 1 2)))
                            (if (call error? g42054140)
                              g42054140
                              (let ((g42054141 (call vector-set! tmp.8 2 3)))
                                (if (call error? g42054141)
                                  g42054141
                                  (let ((g42054142
                                         (call vector-set! tmp.8 3 4)))
                                    (if (call error? g42054142)
                                      g42054142
                                      (let ((g42054143
                                             (call vector-set! tmp.8 4 5)))
                                        (if (call error? g42054143)
                                          g42054143
                                          (let ((g42054144
                                                 (call vector-set! tmp.8 5 6)))
                                            (if (call error? g42054144)
                                              g42054144
                                              (let ((g42054145
                                                     (call
                                                      vector-set!
                                                      tmp.8
                                                      6
                                                      7)))
                                                (if (call error? g42054145)
                                                  g42054145
                                                  (let ((g42054146
                                                         (call
                                                          vector-set!
                                                          tmp.8
                                                          7
                                                          8)))
                                                    (if (call error? g42054146)
                                                      g42054146
                                                      tmp.8))))))))))))))))))))
             #\G)))
      (if tmp.7
        tmp.7
        (let ((tmp.9 (if #f #\[ #\\)))
          (if tmp.9
            tmp.9
            (let ((tmp.10 (call fun/ascii-char8506)))
              (if tmp.10
                tmp.10
                (let ((tmp.11 (if #t #\V #\V)))
                  (if tmp.11
                    tmp.11
                    (let ((tmp.12 (if #f #\i #\N)))
                      (if tmp.12 tmp.12 (call fun/ascii-char8507)))))))))))))
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
(check-by-interp '(module (if #t (void) (void))))
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
    (let ((g42092307 (let ((boolean0 #f)) (void))))
      (if (call error? g42092307)
        g42092307
        (let ((g42092308 (let ((empty0 empty)) (void))))
          (if (call error? g42092308)
            g42092308
            (let ((g42092309 (call fun/void8534)))
              (if (call error? g42092309)
                g42092309
                (let ((g42092310 (if #t (void) (void))))
                  (if (call error? g42092310)
                    g42092310
                    (let ((g42092311 (call fun/void8535)))
                      (if (call error? g42092311)
                        g42092311
                        (let ((g42092312
                               (if (void)
                                 (if (void)
                                   (if (void)
                                     (if (void)
                                       (if (void) (if (void) (void) #f) #f)
                                       #f)
                                     #f)
                                   #f)
                                 #f)))
                          (if (call error? g42092312)
                            g42092312
                            (void)))))))))))))))
(check-by-interp
 '(module
    (define fun/void8539 (lambda () (void)))
    (define fun/void8538 (lambda () (call fun/void8539)))
    (call fun/void8538)))
(check-by-interp '(module (if #t #\i #\t)))
(check-by-interp
 '(module
    (call
     *
     (let ((tmp.7 84))
       (if tmp.7
         tmp.7
         (let ((tmp.8 193))
           (if tmp.8
             tmp.8
             (let ((tmp.9 207))
               (if tmp.9 tmp.9 (let ((tmp.10 91)) (if tmp.10 tmp.10 149))))))))
     (let ((tmp.11 174)) (if tmp.11 tmp.11 79)))))
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
    (if (let ((error0 (error 194))) (error 152))
      (let ((g42119027 (if #f (error 108) (error 68))))
        (if (call error? g42119027)
          g42119027
          (let ((g42119028 (error 192)))
            (if (call error? g42119028)
              g42119028
              (let ((g42119029 (if #f (error 126) (error 57))))
                (if (call error? g42119029)
                  g42119029
                  (let ((g42119030
                         (let ((g42119031 (error 31)))
                           (if (call error? g42119031)
                             g42119031
                             (let ((g42119032 (error 219)))
                               (if (call error? g42119032)
                                 g42119032
                                 (error 86)))))))
                    (if (call error? g42119030)
                      g42119030
                      (let ((g42119033 (if #t (error 147) (error 181))))
                        (if (call error? g42119033)
                          g42119033
                          (let ((g42119034 (call fun/error8557)))
                            (if (call error? g42119034)
                              g42119034
                              (error 211)))))))))))))
      #f)))
(check-by-interp
 '(module
    (define fun/ascii-char8562 (lambda (oprand0) #\n))
    (define fun/ascii-char8561 (lambda (oprand0) #\l))
    (define fun/boolean8560 (lambda () #f))
    (if (call fun/boolean8560)
      (call fun/ascii-char8561 #f)
      (call fun/ascii-char8562 (call cons 31 (call cons 309 empty))))))
(check-by-interp
 '(module
    (define fun/ascii-char8565 (lambda () #\C))
    (let ((procedure0 (lambda () (call fun/ascii-char8565))))
      (let ((error0 (error 99))) (void)))))
(check-by-interp
 '(module
    (let ((ascii-char0
           (let ((tmp.7 #\A))
             (if tmp.7 tmp.7 (let ((tmp.8 #\^)) (if tmp.8 tmp.8 #\k))))))
      (if #f 249 139))))
(check-by-interp
 '(module
    (define fun/fixnum8570 (lambda () (let () 159)))
    (call fun/fixnum8570)))
(check-by-interp
 '(module
    (define fun/void8573 (lambda () (if #f (void) (void))))
    (call fun/void8573)))
(check-by-interp '(module (let () empty)))
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
    (define fun/vector8594
      (lambda ()
        (let ((tmp.7 (call make-vector 8)))
          (let ((g42161003 (call vector-set! tmp.7 0 1)))
            (if (call error? g42161003)
              g42161003
              (let ((g42161004 (call vector-set! tmp.7 1 2)))
                (if (call error? g42161004)
                  g42161004
                  (let ((g42161005 (call vector-set! tmp.7 2 3)))
                    (if (call error? g42161005)
                      g42161005
                      (let ((g42161006 (call vector-set! tmp.7 3 4)))
                        (if (call error? g42161006)
                          g42161006
                          (let ((g42161007 (call vector-set! tmp.7 4 5)))
                            (if (call error? g42161007)
                              g42161007
                              (let ((g42161008 (call vector-set! tmp.7 5 6)))
                                (if (call error? g42161008)
                                  g42161008
                                  (let ((g42161009
                                         (call vector-set! tmp.7 6 7)))
                                    (if (call error? g42161009)
                                      g42161009
                                      (let ((g42161010
                                             (call vector-set! tmp.7 7 8)))
                                        (if (call error? g42161010)
                                          g42161010
                                          tmp.7)))))))))))))))))))
    (define fun/vector8593 (lambda (oprand0) (call fun/vector8594)))
    (call fun/ascii-char8591 (call fun/vector8593 (call fun/ascii-char8595)))))
(check-by-interp '(module (let () (let () empty))))
(check-by-interp
 '(module
    (define fun/ascii-char8602 (lambda () #\J))
    (define fun/ascii-char8604 (lambda () #\_))
    (define fun/ascii-char8603 (lambda () #\N))
    (let ((g42168642
           (let ((tmp.7
                  (let ((pair0 (call cons 141 (call cons 498 empty)))
                        (boolean1 #f))
                    #\B)))
             (if tmp.7
               tmp.7
               (let ((tmp.8
                      (let ((g42168643 #\V))
                        (if (call error? g42168643) g42168643 #\B))))
                 (if tmp.8
                   tmp.8
                   (let ((tmp.9 (let ((procedure0 (lambda () (void)))) #\Z)))
                     (if tmp.9
                       tmp.9
                       (let ((tmp.10 (call fun/ascii-char8602)))
                         (if tmp.10
                           tmp.10
                           (let ((fixnum0 12) (ascii-char1 #\R)) #\e)))))))))))
      (if (call error? g42168642)
        g42168642
        (let ((g42168644 (call fun/ascii-char8603)))
          (if (call error? g42168644)
            g42168644
            (let ((g42168645
                   (let ((tmp.11 (call fun/ascii-char8604)))
                     (if tmp.11
                       tmp.11
                       (let ((tmp.12
                              (let ((fixnum0 190) (error1 (error 40))) #\])))
                         (if tmp.12
                           tmp.12
                           (let ((tmp.13
                                  (let ((tmp.14 #\L)) (if tmp.14 tmp.14 #\l))))
                             (if tmp.13
                               tmp.13
                               (let ((tmp.15
                                      (if #\I (if #\p (if #\d #\L #f) #f) #f)))
                                 (if tmp.15
                                   tmp.15
                                   (let ((tmp.16 #\T))
                                     (if tmp.16
                                       tmp.16
                                       (let ((tmp.17 #\\))
                                         (if tmp.17
                                           tmp.17
                                           (let ((tmp.18 #\Y))
                                             (if tmp.18
                                               tmp.18
                                               (let ((tmp.19 #\V))
                                                 (if tmp.19
                                                   tmp.19
                                                   (let ((tmp.20 #\y))
                                                     (if tmp.20
                                                       tmp.20
                                                       (let ((tmp.21 #\_))
                                                         (if tmp.21
                                                           tmp.21
                                                           #\F))))))))))))))))))))))
              (if (call error? g42168645)
                g42168645
                (let ((g42168646 (let ((fixnum0 45)) #\j)))
                  (if (call error? g42168646)
                    g42168646
                    (let ((g42168647 (if #f #\A #\c)))
                      (if (call error? g42168647)
                        g42168647
                        (if #f #\U #\e)))))))))))))
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
    (let ((g42183917 (let ((ascii-char0 #\r)) #\C)))
      (if (call error? g42183917)
        g42183917
        (let ((g42183918 (if #f #\G #\R)))
          (if (call error? g42183918)
            g42183918
            (let ((g42183919 (let () #\t)))
              (if (call error? g42183919) g42183919 (let () #\t)))))))))
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
    (if (let () empty)
      (if (call fun/empty8627 (let ((ascii-char0 #\B)) #t))
        (if (if #t empty empty)
          (if (if #t empty empty)
            (if (if (let ((tmp.7 empty))
                      (if tmp.7
                        tmp.7
                        (let ((tmp.8 empty))
                          (if tmp.8
                            tmp.8
                            (let ((tmp.9 empty))
                              (if tmp.9
                                tmp.9
                                (let ((tmp.10 empty))
                                  (if tmp.10
                                    tmp.10
                                    (let ((tmp.11 empty))
                                      (if tmp.11
                                        tmp.11
                                        (let ((tmp.12 empty))
                                          (if tmp.12 tmp.12 empty))))))))))))
                  (if (if #t empty empty)
                    (if (if empty
                          (if empty (if empty (if empty empty #f) #f) #f)
                          #f)
                      (if (if #f empty empty) (call fun/empty8628) #f)
                      #f)
                    #f)
                  #f)
              (let ((g42195365 (call fun/empty8629 #f)))
                (if (call error? g42195365)
                  g42195365
                  (let ((g42195366 (let ((fixnum0 174)) empty)))
                    (if (call error? g42195366)
                      g42195366
                      (let ((g42195367 (call fun/empty8630)))
                        (if (call error? g42195367)
                          g42195367
                          (let ((g42195368
                                 (let ((tmp.13 empty))
                                   (if tmp.13
                                     tmp.13
                                     (let ((tmp.14 empty))
                                       (if tmp.14
                                         tmp.14
                                         (let ((tmp.15 empty))
                                           (if tmp.15 tmp.15 empty))))))))
                            (if (call error? g42195368)
                              g42195368
                              (let ((g42195369
                                     (let ((pair0
                                            (call
                                             cons
                                             202
                                             (call cons 322 empty)))
                                           (vector1
                                            (let ((tmp.16
                                                   (call make-vector 8)))
                                              (let ((g42195370
                                                     (call
                                                      vector-set!
                                                      tmp.16
                                                      0
                                                      0)))
                                                (if (call error? g42195370)
                                                  g42195370
                                                  (let ((g42195371
                                                         (call
                                                          vector-set!
                                                          tmp.16
                                                          1
                                                          1)))
                                                    (if (call error? g42195371)
                                                      g42195371
                                                      (let ((g42195372
                                                             (call
                                                              vector-set!
                                                              tmp.16
                                                              2
                                                              2)))
                                                        (if (call
                                                             error?
                                                             g42195372)
                                                          g42195372
                                                          (let ((g42195373
                                                                 (call
                                                                  vector-set!
                                                                  tmp.16
                                                                  3
                                                                  3)))
                                                            (if (call
                                                                 error?
                                                                 g42195373)
                                                              g42195373
                                                              (let ((g42195374
                                                                     (call
                                                                      vector-set!
                                                                      tmp.16
                                                                      4
                                                                      4)))
                                                                (if (call
                                                                     error?
                                                                     g42195374)
                                                                  g42195374
                                                                  (let ((g42195375
                                                                         (call
                                                                          vector-set!
                                                                          tmp.16
                                                                          5
                                                                          5)))
                                                                    (if (call
                                                                         error?
                                                                         g42195375)
                                                                      g42195375
                                                                      (let ((g42195376
                                                                             (call
                                                                              vector-set!
                                                                              tmp.16
                                                                              6
                                                                              6)))
                                                                        (if (call
                                                                             error?
                                                                             g42195376)
                                                                          g42195376
                                                                          (let ((g42195377
                                                                                 (call
                                                                                  vector-set!
                                                                                  tmp.16
                                                                                  7
                                                                                  7)))
                                                                            (if (call
                                                                                 error?
                                                                                 g42195377)
                                                                              g42195377
                                                                              tmp.16)))))))))))))))))))
                                       empty)))
                                (if (call error? g42195369)
                                  g42195369
                                  (let ((tmp.17 empty))
                                    (if tmp.17
                                      tmp.17
                                      (let ((tmp.18 empty))
                                        (if tmp.18
                                          tmp.18
                                          (let ((tmp.19 empty))
                                            (if tmp.19
                                              tmp.19
                                              (let ((tmp.20 empty))
                                                (if tmp.20
                                                  tmp.20
                                                  (let ((tmp.21 empty))
                                                    (if tmp.21
                                                      tmp.21
                                                      (let ((tmp.22 empty))
                                                        (if tmp.22
                                                          tmp.22
                                                          empty))))))))))))))))))))))
              #f)
            #f)
          #f)
        #f)
      #f)))
(check-by-interp
 '(module
    (if (if #t #f #t)
      (if #f (error 46) (error 150))
      (let ((procedure0 (lambda () 143))) (error 251)))))
(check-by-interp
 '(module
    (let ((error0 (if #t (error 72) (error 35)))
          (fixnum1
           (let ((tmp.7 162))
             (if tmp.7
               tmp.7
               (let ((tmp.8 92))
                 (if tmp.8
                   tmp.8
                   (let ((tmp.9 198))
                     (if tmp.9
                       tmp.9
                       (let ((tmp.10 13))
                         (if tmp.10
                           tmp.10
                           (let ((tmp.11 140))
                             (if tmp.11
                               tmp.11
                               (let ((tmp.12 114))
                                 (if tmp.12 tmp.12 150))))))))))))))
      (let ((tmp.13 #f))
        (if tmp.13
          tmp.13
          (let ((tmp.14 #t))
            (if tmp.14
              tmp.14
              (let ((tmp.15 #t))
                (if tmp.15
                  tmp.15
                  (let ((tmp.16 #f))
                    (if tmp.16
                      tmp.16
                      (let ((tmp.17 #f))
                        (if tmp.17
                          tmp.17
                          (let ((tmp.18 #t))
                            (if tmp.18 tmp.18 #t)))))))))))))))
(check-by-interp '(module (if (if #f #t #f) (let () (void)) (void))))
(check-by-interp
 '(module
    (if (if #t #t #t)
      (let ((ascii-char0 #\H)) 50)
      (let ((g42210650 184))
        (if (call error? g42210650)
          g42210650
          (let ((g42210651 213))
            (if (call error? g42210651) g42210651 114)))))))
(check-by-interp
 '(module
    (if (let ((void0 (void)) (empty1 empty)) (error 173))
      (let ((tmp.7 (let ((boolean0 #t)) (error 149))))
        (if tmp.7
          tmp.7
          (let ((tmp.8
                 (let ((pair0 (call cons 227 (call cons 467 empty))))
                   (error 230))))
            (if tmp.8 tmp.8 (if #t (error 139) (error 80))))))
      #f)))
(check-by-interp
 '(module
    (define fun/empty8650 (lambda () (if #t empty empty)))
    (define fun/empty8649 (lambda () empty))
    (let ((g42218286
           (let ((tmp.7 (if #f empty empty)))
             (if tmp.7
               tmp.7
               (let ((tmp.8 (if #f empty empty)))
                 (if tmp.8
                   tmp.8
                   (let ((tmp.9 (call fun/empty8649)))
                     (if tmp.9
                       tmp.9
                       (let ((tmp.10 (if empty (if empty empty #f) #f)))
                         (if tmp.10
                           tmp.10
                           (let ((tmp.11 (if #t empty empty)))
                             (if tmp.11 tmp.11 (if #f empty empty)))))))))))))
      (if (call error? g42218286)
        g42218286
        (let ((g42218287
               (if (if #f empty empty)
                 (if (let () empty)
                   (if (let ((tmp.12 empty))
                         (if tmp.12
                           tmp.12
                           (let ((tmp.13 empty)) (if tmp.13 tmp.13 empty))))
                     (if (let ((procedure0
                                (lambda ()
                                  (call cons 98 (call cons 276 empty))))
                               (boolean1 #f))
                           empty)
                       (if #t empty empty)
                       #f)
                     #f)
                   #f)
                 #f)))
          (if (call error? g42218287)
            g42218287
            (let ((g42218288 (call fun/empty8650)))
              (if (call error? g42218288)
                g42218288
                (let ((g42218289 (if empty empty #f)))
                  (if (call error? g42218289)
                    g42218289
                    (if #t empty empty)))))))))))
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
    (let ((g42225918 (call fun/ascii-char8658)))
      (if (call error? g42225918)
        g42225918
        (let ((g42225919 (let () #\Q)))
          (if (call error? g42225919)
            g42225919
            (let ((g42225920 (call fun/ascii-char8660 empty)))
              (if (call error? g42225920)
                g42225920
                (call fun/ascii-char8662)))))))))
(check-by-interp
 '(module
    (if (if #f #t #t)
      (let ((error0 (error 214))) (void))
      (if #f (void) (void)))))
(check-by-interp
 '(module
    (define fun/any7325 (lambda (oprand0 oprand1) (error 124)))
    (if (let ((g42233549 (let () #t)))
          (if (call error? g42233549) g42233549 (let () #t)))
      (call error? (call fun/any7325 #\K (lambda () 713)))
      (if #f #f #t))))
(check-by-interp
 '(module
    (define fun/any8476 (lambda (oprand0) 169))
    (if (call void? (call fun/any8476 (lambda () 1020)))
      (let ((procedure0 (lambda () (call cons 215 (call cons 403 empty))))
            (error1 (error 137))
            (error2 (error 179)))
        #f)
      (let ((vector0
             (let ((tmp.7 (call make-vector 8)))
               (let ((g42237367 (call vector-set! tmp.7 0 0)))
                 (if (call error? g42237367)
                   g42237367
                   (let ((g42237368 (call vector-set! tmp.7 1 1)))
                     (if (call error? g42237368)
                       g42237368
                       (let ((g42237369 (call vector-set! tmp.7 2 2)))
                         (if (call error? g42237369)
                           g42237369
                           (let ((g42237370 (call vector-set! tmp.7 3 3)))
                             (if (call error? g42237370)
                               g42237370
                               (let ((g42237371 (call vector-set! tmp.7 4 4)))
                                 (if (call error? g42237371)
                                   g42237371
                                   (let ((g42237372
                                          (call vector-set! tmp.7 5 5)))
                                     (if (call error? g42237372)
                                       g42237372
                                       (let ((g42237373
                                              (call vector-set! tmp.7 6 6)))
                                         (if (call error? g42237373)
                                           g42237373
                                           (let ((g42237374
                                                  (call
                                                   vector-set!
                                                   tmp.7
                                                   7
                                                   7)))
                                             (if (call error? g42237374)
                                               g42237374
                                               tmp.7)))))))))))))))))))
        #t))))
(check-by-interp
 '(module
    (if (call
         fixnum?
         (if #t
           194
           (let ((tmp.7 (call make-vector 8)))
             (let ((g42241192 (call vector-set! tmp.7 0 1)))
               (if (call error? g42241192)
                 g42241192
                 (let ((g42241193 (call vector-set! tmp.7 1 2)))
                   (if (call error? g42241193)
                     g42241193
                     (let ((g42241194 (call vector-set! tmp.7 2 3)))
                       (if (call error? g42241194)
                         g42241194
                         (let ((g42241195 (call vector-set! tmp.7 3 4)))
                           (if (call error? g42241195)
                             g42241195
                             (let ((g42241196 (call vector-set! tmp.7 4 5)))
                               (if (call error? g42241196)
                                 g42241196
                                 (let ((g42241197
                                        (call vector-set! tmp.7 5 6)))
                                   (if (call error? g42241197)
                                     g42241197
                                     (let ((g42241198
                                            (call vector-set! tmp.7 6 7)))
                                       (if (call error? g42241198)
                                         g42241198
                                         (let ((g42241199
                                                (call vector-set! tmp.7 7 8)))
                                           (if (call error? g42241199)
                                             g42241199
                                             tmp.7)))))))))))))))))))
      (let ((pair0 (call cons 82 (call cons 500 empty)))) empty)
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
    (define fun/pair8497
      (lambda (oprand0)
        (let ((boolean0 #t)) (call cons 243 (call cons 369 empty)))))
    (define fun/void8495 (lambda (oprand0 oprand1) (call fun/void8496)))
    (define fun/void8490 (lambda () (call fun/void8491)))
    (define fun/ascii-char8494 (lambda () #\e))
    (define fun/void8496 (lambda () (void)))
    (define fun/pair8498 (lambda () (call cons 164 (call cons 306 empty))))
    (define fun/ascii-char8492
      (lambda (oprand0 oprand1) (call fun/ascii-char8493)))
    (define fun/void8491 (lambda () (void)))
    (call
     fun/void8489
     (if (call
          fun/ascii-char8492
          (if #t (error 139) (error 166))
          (let ((vector0
                 (let ((tmp.7 (call make-vector 8)))
                   (let ((g42252645 (call vector-set! tmp.7 0 1)))
                     (if (call error? g42252645)
                       g42252645
                       (let ((g42252646 (call vector-set! tmp.7 1 2)))
                         (if (call error? g42252646)
                           g42252646
                           (let ((g42252647 (call vector-set! tmp.7 2 3)))
                             (if (call error? g42252647)
                               g42252647
                               (let ((g42252648 (call vector-set! tmp.7 3 4)))
                                 (if (call error? g42252648)
                                   g42252648
                                   (let ((g42252649
                                          (call vector-set! tmp.7 4 5)))
                                     (if (call error? g42252649)
                                       g42252649
                                       (let ((g42252650
                                              (call vector-set! tmp.7 5 6)))
                                         (if (call error? g42252650)
                                           g42252650
                                           (let ((g42252651
                                                  (call
                                                   vector-set!
                                                   tmp.7
                                                   6
                                                   7)))
                                             (if (call error? g42252651)
                                               g42252651
                                               (let ((g42252652
                                                      (call
                                                       vector-set!
                                                       tmp.7
                                                       7
                                                       8)))
                                                 (if (call error? g42252652)
                                                   g42252652
                                                   tmp.7)))))))))))))))))))
            (void)))
       (if (if #t #\j #\G)
         (if (let ((g42252653 (let ((tmp.8 #\h)) (if tmp.8 tmp.8 #\H))))
               (if (call error? g42252653)
                 g42252653
                 (let ((g42252654
                        (let ((pair0 (call cons 222 (call cons 394 empty)))
                              (error1 (error 102)))
                          #\E)))
                   (if (call error? g42252654)
                     g42252654
                     (let ((g42252655
                            (let ((boolean0 #f) (void1 (void)) (boolean2 #f))
                              #\s)))
                       (if (call error? g42252655)
                         g42252655
                         (let ((g42252656
                                (let ((boolean0 #f)
                                      (pair1
                                       (call cons 165 (call cons 270 empty)))
                                      (fixnum2 165))
                                  #\k)))
                           (if (call error? g42252656)
                             g42252656
                             (let ((g42252657 (call fun/ascii-char8494)))
                               (if (call error? g42252657)
                                 g42252657
                                 (let ((pair0
                                        (call cons 123 (call cons 483 empty)))
                                       (void1 (void))
                                       (void2 (void)))
                                   #\D)))))))))))
           (let () #\\)
           #f)
         #f)
       #f)
     (call
      fun/void8495
      (call fun/pair8497 (call fun/pair8498))
      (let ((empty0 empty) (ascii-char1 #\d)) (lambda () 530))))))
(check-by-interp
 '(module
    (define fun/empty8501 (lambda (oprand0 oprand1) empty))
    (let ()
      (if (if #f empty empty)
        (if (let ((g42256477 empty))
              (if (call error? g42256477)
                g42256477
                (let ((g42256478 empty))
                  (if (call error? g42256478)
                    g42256478
                    (let ((g42256479 empty))
                      (if (call error? g42256479) g42256479 empty))))))
          (call fun/empty8501 136 (lambda () 643))
          #f)
        #f))))
(check-by-interp
 '(module
    (let ((void0 (let () (void)))
          (procedure1 (lambda () (let () #t)))
          (boolean2 (let () #f)))
      (if (if #f #\n #\v) (if #\E (if #\a #\b #f) #f) #f))))
(check-by-interp
 '(module
    (let ((void0
           (let ((pair0 (call cons 107 (call cons 481 empty))) (boolean1 #t))
             (void))))
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
       (let ((g42302032 (void)))
         (if (call error? g42302032)
           g42302032
           (let ((g42302033 (void)))
             (if (call error? g42302033)
               g42302033
               (let ((g42302034 (void)))
                 (if (call error? g42302034)
                   g42302034
                   (let ((g42302035 (void)))
                     (if (call error? g42302035) g42302035 (void)))))))))
       (let ((error0 (error 120))) (void))))))
(check-by-interp
 '(module
    (define fun/void8487 (lambda (oprand0 oprand1) oprand1))
    (define fun/void8488
      (lambda (oprand0)
        (call
         vector-set!
         oprand0
         3
         (let ((tmp.7 (call make-vector 8)))
           (let ((g42305850 (call vector-set! tmp.7 0 0)))
             (if (call error? g42305850)
               g42305850
               (let ((g42305851 (call vector-set! tmp.7 1 1)))
                 (if (call error? g42305851)
                   g42305851
                   (let ((g42305852 (call vector-set! tmp.7 2 2)))
                     (if (call error? g42305852)
                       g42305852
                       (let ((g42305853 (call vector-set! tmp.7 3 3)))
                         (if (call error? g42305853)
                           g42305853
                           (let ((g42305854 (call vector-set! tmp.7 4 4)))
                             (if (call error? g42305854)
                               g42305854
                               (let ((g42305855 (call vector-set! tmp.7 5 5)))
                                 (if (call error? g42305855)
                                   g42305855
                                   (let ((g42305856
                                          (call vector-set! tmp.7 6 6)))
                                     (if (call error? g42305856)
                                       g42305856
                                       (let ((g42305857
                                              (call vector-set! tmp.7 7 7)))
                                         (if (call error? g42305857)
                                           g42305857
                                           tmp.7))))))))))))))))))))
    (let ()
      (if (let ((ascii-char0 #\j)
                (empty1 empty)
                (pair2 (call cons 146 (call cons 308 empty))))
            (void))
        (if (call fun/void8487 148 (void))
          (if (call
               fun/void8488
               (let ((tmp.8 (call make-vector 8)))
                 (let ((g42305858 (call vector-set! tmp.8 0 1)))
                   (if (call error? g42305858)
                     g42305858
                     (let ((g42305859 (call vector-set! tmp.8 1 2)))
                       (if (call error? g42305859)
                         g42305859
                         (let ((g42305860 (call vector-set! tmp.8 2 3)))
                           (if (call error? g42305860)
                             g42305860
                             (let ((g42305861 (call vector-set! tmp.8 3 4)))
                               (if (call error? g42305861)
                                 g42305861
                                 (let ((g42305862
                                        (call vector-set! tmp.8 4 5)))
                                   (if (call error? g42305862)
                                     g42305862
                                     (let ((g42305863
                                            (call vector-set! tmp.8 5 6)))
                                       (if (call error? g42305863)
                                         g42305863
                                         (let ((g42305864
                                                (call vector-set! tmp.8 6 7)))
                                           (if (call error? g42305864)
                                             g42305864
                                             (let ((g42305865
                                                    (call
                                                     vector-set!
                                                     tmp.8
                                                     7
                                                     8)))
                                               (if (call error? g42305865)
                                                 g42305865
                                                 tmp.8))))))))))))))))))
            (if #t (void) (void))
            #f)
          #f)
        #f))))
(check-by-interp
 '(module
    (define fun/empty8491
      (lambda (oprand0 oprand1) (let () (call fun/empty8492))))
    (define fun/empty8492 (lambda () empty))
    (define fun/error8493 (lambda (oprand0 oprand1) (error 123)))
    (call
     fun/empty8491
     (let ((error0 (if #t (error 178) (error 194))))
       (if (void) (if (void) (if (void) (void) #f) #f) #f))
     (if (let () #t) (let () (error 47)) (call fun/error8493 #t #t)))))
(check-by-interp
 '(module
    (define fun/pair8504
      (lambda (oprand0 oprand1) (call cons 175 (call cons 296 empty))))
    (define fun/void8499 (lambda (oprand0) (void)))
    (define fun/void8501
      (lambda (oprand0 oprand1) (call vector-set! oprand0 5 #\I)))
    (define fun/void8498 (lambda () (void)))
    (define fun/fixnum8502 (lambda (oprand0) (let () 229)))
    (define fun/pair8503 (lambda () (call cons 187 (call cons 408 empty))))
    (define fun/void8497 (lambda (oprand0 oprand1) (let () (void))))
    (define fun/void8500 (lambda (oprand0) (void)))
    (define fun/fixnum8496 (lambda (oprand0 oprand1) (let () (if #t 39 232))))
    (call
     fun/fixnum8496
     (if (call
          fun/void8497
          (if #f 182 177)
          (if #f
            (call cons 128 (call cons 289 empty))
            (call cons 177 (call cons 385 empty))))
       (if (if #f (void) (void))
         (if (let ((procedure0 (lambda () (call cons 6 (call cons 507 empty))))
                   (ascii-char1 #\M)
                   (fixnum2 199))
               (void))
           (if (if #f (void) (void))
             (if (let ((empty0 empty)
                       (procedure1
                        (lambda ()
                          (let ((tmp.7 (call make-vector 8)))
                            (let ((g42328608 (call vector-set! tmp.7 0 1)))
                              (if (call error? g42328608)
                                g42328608
                                (let ((g42328609 (call vector-set! tmp.7 1 2)))
                                  (if (call error? g42328609)
                                    g42328609
                                    (let ((g42328610
                                           (call vector-set! tmp.7 2 3)))
                                      (if (call error? g42328610)
                                        g42328610
                                        (let ((g42328611
                                               (call vector-set! tmp.7 3 4)))
                                          (if (call error? g42328611)
                                            g42328611
                                            (let ((g42328612
                                                   (call
                                                    vector-set!
                                                    tmp.7
                                                    4
                                                    5)))
                                              (if (call error? g42328612)
                                                g42328612
                                                (let ((g42328613
                                                       (call
                                                        vector-set!
                                                        tmp.7
                                                        5
                                                        6)))
                                                  (if (call error? g42328613)
                                                    g42328613
                                                    (let ((g42328614
                                                           (call
                                                            vector-set!
                                                            tmp.7
                                                            6
                                                            7)))
                                                      (if (call
                                                           error?
                                                           g42328614)
                                                        g42328614
                                                        (let ((g42328615
                                                               (call
                                                                vector-set!
                                                                tmp.7
                                                                7
                                                                8)))
                                                          (if (call
                                                               error?
                                                               g42328615)
                                                            g42328615
                                                            tmp.7))))))))))))))))))))
                   (void))
               (let ((tmp.8 (if #t (void) (void))))
                 (if tmp.8
                   tmp.8
                   (let ((tmp.9 (void)))
                     (if tmp.9
                       tmp.9
                       (let ((tmp.10
                              (let ((boolean0 #t)
                                    (error1 (error 35))
                                    (procedure2 (lambda () empty)))
                                (void))))
                         (if tmp.10
                           tmp.10
                           (let ((tmp.11 (call fun/void8498)))
                             (if tmp.11
                               tmp.11
                               (let ((tmp.12 (call fun/void8499 (error 96))))
                                 (if tmp.12
                                   tmp.12
                                   (let ((tmp.13 (call fun/void8500 #f)))
                                     (if tmp.13
                                       tmp.13
                                       (call
                                        fun/void8501
                                        (let ((tmp.14 (call make-vector 8)))
                                          (let ((g42328616
                                                 (call
                                                  vector-set!
                                                  tmp.14
                                                  0
                                                  1)))
                                            (if (call error? g42328616)
                                              g42328616
                                              (let ((g42328617
                                                     (call
                                                      vector-set!
                                                      tmp.14
                                                      1
                                                      2)))
                                                (if (call error? g42328617)
                                                  g42328617
                                                  (let ((g42328618
                                                         (call
                                                          vector-set!
                                                          tmp.14
                                                          2
                                                          3)))
                                                    (if (call error? g42328618)
                                                      g42328618
                                                      (let ((g42328619
                                                             (call
                                                              vector-set!
                                                              tmp.14
                                                              3
                                                              4)))
                                                        (if (call
                                                             error?
                                                             g42328619)
                                                          g42328619
                                                          (let ((g42328620
                                                                 (call
                                                                  vector-set!
                                                                  tmp.14
                                                                  4
                                                                  5)))
                                                            (if (call
                                                                 error?
                                                                 g42328620)
                                                              g42328620
                                                              (let ((g42328621
                                                                     (call
                                                                      vector-set!
                                                                      tmp.14
                                                                      5
                                                                      6)))
                                                                (if (call
                                                                     error?
                                                                     g42328621)
                                                                  g42328621
                                                                  (let ((g42328622
                                                                         (call
                                                                          vector-set!
                                                                          tmp.14
                                                                          6
                                                                          7)))
                                                                    (if (call
                                                                         error?
                                                                         g42328622)
                                                                      g42328622
                                                                      (let ((g42328623
                                                                             (call
                                                                              vector-set!
                                                                              tmp.14
                                                                              7
                                                                              8)))
                                                                        (if (call
                                                                             error?
                                                                             g42328623)
                                                                          g42328623
                                                                          tmp.14)))))))))))))))))
                                        (error 127))))))))))))))
               #f)
             #f)
           #f)
         #f)
       #f)
     (call
      fun/fixnum8502
      (let ((g42328624 (call cons 234 (call cons 272 empty))))
        (if (call error? g42328624)
          g42328624
          (let ((g42328625
                 (let ((error0 (error 104))
                       (procedure1
                        (lambda ()
                          (let ((tmp.15 (call make-vector 8)))
                            (let ((g42328626 (call vector-set! tmp.15 0 0)))
                              (if (call error? g42328626)
                                g42328626
                                (let ((g42328627
                                       (call vector-set! tmp.15 1 1)))
                                  (if (call error? g42328627)
                                    g42328627
                                    (let ((g42328628
                                           (call vector-set! tmp.15 2 2)))
                                      (if (call error? g42328628)
                                        g42328628
                                        (let ((g42328629
                                               (call vector-set! tmp.15 3 3)))
                                          (if (call error? g42328629)
                                            g42328629
                                            (let ((g42328630
                                                   (call
                                                    vector-set!
                                                    tmp.15
                                                    4
                                                    4)))
                                              (if (call error? g42328630)
                                                g42328630
                                                (let ((g42328631
                                                       (call
                                                        vector-set!
                                                        tmp.15
                                                        5
                                                        5)))
                                                  (if (call error? g42328631)
                                                    g42328631
                                                    (let ((g42328632
                                                           (call
                                                            vector-set!
                                                            tmp.15
                                                            6
                                                            6)))
                                                      (if (call
                                                           error?
                                                           g42328632)
                                                        g42328632
                                                        (let ((g42328633
                                                               (call
                                                                vector-set!
                                                                tmp.15
                                                                7
                                                                7)))
                                                          (if (call
                                                               error?
                                                               g42328633)
                                                            g42328633
                                                            tmp.15)))))))))))))))))))
                       (ascii-char2 #\M))
                   (call cons 43 (call cons 459 empty)))))
            (if (call error? g42328625)
              g42328625
              (let ((g42328634 (call cons 92 (call cons 487 empty))))
                (if (call error? g42328634)
                  g42328634
                  (let ((g42328635
                         (let ((g42328636
                                (call cons 23 (call cons 399 empty))))
                           (if (call error? g42328636)
                             g42328636
                             (call cons 163 (call cons 314 empty))))))
                    (if (call error? g42328635)
                      g42328635
                      (let ((g42328637 (call fun/pair8503)))
                        (if (call error? g42328637)
                          g42328637
                          (let ((g42328638
                                 (if #t
                                   (call cons 59 (call cons 331 empty))
                                   (call cons 18 (call cons 310 empty)))))
                            (if (call error? g42328638)
                              g42328638
                              (call
                               fun/pair8504
                               (void)
                               (lambda () 998))))))))))))))))))
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
     (if (if (call
              fun/empty8510
              (error 189)
              (call cons 54 (call cons 464 empty)))
           (if (call fun/empty8511 #t 41)
             (if (if #f empty empty)
               (if (call fun/empty8512)
                 (if (let ((error0 (error 217)) (boolean1 #t)) empty)
                   (let () empty)
                   #f)
                 #f)
               #f)
             #f)
           #f)
       (call fun/empty8513 (if #t (lambda () 622) (lambda () 523)))
       #f)
     (if (call < 93 14)
       (let ((boolean0 #t)
             (vector1
              (let ((tmp.7 (call make-vector 8)))
                (let ((g42336237 (call vector-set! tmp.7 0 1)))
                  (if (call error? g42336237)
                    g42336237
                    (let ((g42336238 (call vector-set! tmp.7 1 2)))
                      (if (call error? g42336238)
                        g42336238
                        (let ((g42336239 (call vector-set! tmp.7 2 3)))
                          (if (call error? g42336239)
                            g42336239
                            (let ((g42336240 (call vector-set! tmp.7 3 4)))
                              (if (call error? g42336240)
                                g42336240
                                (let ((g42336241 (call vector-set! tmp.7 4 5)))
                                  (if (call error? g42336241)
                                    g42336241
                                    (let ((g42336242
                                           (call vector-set! tmp.7 5 6)))
                                      (if (call error? g42336242)
                                        g42336242
                                        (let ((g42336243
                                               (call vector-set! tmp.7 6 7)))
                                          (if (call error? g42336243)
                                            g42336243
                                            (let ((g42336244
                                                   (call
                                                    vector-set!
                                                    tmp.7
                                                    7
                                                    8)))
                                              (if (call error? g42336244)
                                                g42336244
                                                tmp.7))))))))))))))))))
             (boolean2 #f))
         (void))
       (let ((empty0 empty) (empty1 empty)) (void))))))
(check-by-interp
 '(module
    (define fun/boolean8517 (lambda (oprand0) #f))
    (if (call fun/boolean8517 (lambda () 918))
      #\L
      (let ((vector0
             (let ((tmp.7 (call make-vector 8)))
               (let ((g42343841 (call vector-set! tmp.7 0 1)))
                 (if (call error? g42343841)
                   g42343841
                   (let ((g42343842 (call vector-set! tmp.7 1 2)))
                     (if (call error? g42343842)
                       g42343842
                       (let ((g42343843 (call vector-set! tmp.7 2 3)))
                         (if (call error? g42343843)
                           g42343843
                           (let ((g42343844 (call vector-set! tmp.7 3 4)))
                             (if (call error? g42343844)
                               g42343844
                               (let ((g42343845 (call vector-set! tmp.7 4 5)))
                                 (if (call error? g42343845)
                                   g42343845
                                   (let ((g42343846
                                          (call vector-set! tmp.7 5 6)))
                                     (if (call error? g42343846)
                                       g42343846
                                       (let ((g42343847
                                              (call vector-set! tmp.7 6 7)))
                                         (if (call error? g42343847)
                                           g42343847
                                           (let ((g42343848
                                                  (call
                                                   vector-set!
                                                   tmp.7
                                                   7
                                                   8)))
                                             (if (call error? g42343848)
                                               g42343848
                                               tmp.7))))))))))))))))))
            (void1 (void))
            (boolean2 #f))
        #\v))))
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
       (let ()
         (let ((tmp.7 (call make-vector 8)))
           (let ((g42347666 (call vector-set! tmp.7 0 1)))
             (if (call error? g42347666)
               g42347666
               (let ((g42347667 (call vector-set! tmp.7 1 2)))
                 (if (call error? g42347667)
                   g42347667
                   (let ((g42347668 (call vector-set! tmp.7 2 3)))
                     (if (call error? g42347668)
                       g42347668
                       (let ((g42347669 (call vector-set! tmp.7 3 4)))
                         (if (call error? g42347669)
                           g42347669
                           (let ((g42347670 (call vector-set! tmp.7 4 5)))
                             (if (call error? g42347670)
                               g42347670
                               (let ((g42347671 (call vector-set! tmp.7 5 6)))
                                 (if (call error? g42347671)
                                   g42347671
                                   (let ((g42347672
                                          (call vector-set! tmp.7 6 7)))
                                     (if (call error? g42347672)
                                       g42347672
                                       (let ((g42347673
                                              (call vector-set! tmp.7 7 8)))
                                         (if (call error? g42347673)
                                           g42347673
                                           tmp.7))))))))))))))))))
       (if #f
         (call cons 25 (call cons 278 empty))
         (call cons 168 (call cons 487 empty)))))
     (if (let () #f)
       (let ((g42347674 232))
         (if (call error? g42347674)
           g42347674
           (let ((g42347675 165)) (if (call error? g42347675) g42347675 174))))
       (if #f 106 28)))))
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
       (if #f
         (let ((tmp.7 (call make-vector 8)))
           (let ((g42366676 (call vector-set! tmp.7 0 1)))
             (if (call error? g42366676)
               g42366676
               (let ((g42366677 (call vector-set! tmp.7 1 2)))
                 (if (call error? g42366677)
                   g42366677
                   (let ((g42366678 (call vector-set! tmp.7 2 3)))
                     (if (call error? g42366678)
                       g42366678
                       (let ((g42366679 (call vector-set! tmp.7 3 4)))
                         (if (call error? g42366679)
                           g42366679
                           (let ((g42366680 (call vector-set! tmp.7 4 5)))
                             (if (call error? g42366680)
                               g42366680
                               (let ((g42366681 (call vector-set! tmp.7 5 6)))
                                 (if (call error? g42366681)
                                   g42366681
                                   (let ((g42366682
                                          (call vector-set! tmp.7 6 7)))
                                     (if (call error? g42366682)
                                       g42366682
                                       (let ((g42366683
                                              (call vector-set! tmp.7 7 8)))
                                         (if (call error? g42366683)
                                           g42366683
                                           tmp.7)))))))))))))))))
         (let ((tmp.8 (call make-vector 8)))
           (let ((g42366684 (call vector-set! tmp.8 0 1)))
             (if (call error? g42366684)
               g42366684
               (let ((g42366685 (call vector-set! tmp.8 1 2)))
                 (if (call error? g42366685)
                   g42366685
                   (let ((g42366686 (call vector-set! tmp.8 2 3)))
                     (if (call error? g42366686)
                       g42366686
                       (let ((g42366687 (call vector-set! tmp.8 3 4)))
                         (if (call error? g42366687)
                           g42366687
                           (let ((g42366688 (call vector-set! tmp.8 4 5)))
                             (if (call error? g42366688)
                               g42366688
                               (let ((g42366689 (call vector-set! tmp.8 5 6)))
                                 (if (call error? g42366689)
                                   g42366689
                                   (let ((g42366690
                                          (call vector-set! tmp.8 6 7)))
                                     (if (call error? g42366690)
                                       g42366690
                                       (let ((g42366691
                                              (call vector-set! tmp.8 7 8)))
                                         (if (call error? g42366691)
                                           g42366691
                                           tmp.8))))))))))))))))))))))
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
    (let ((g42374287
           (if (call >= 2 186)
             (call fun/empty8539 #t)
             (let ((procedure0 (lambda (oprand0 oprand1) #\_))) empty))))
      (if (call error? g42374287)
        g42374287
        (let ((g42374288
               (let ((fixnum0
                      (let ((tmp.7 131))
                        (if tmp.7
                          tmp.7
                          (let ((tmp.8 147))
                            (if tmp.8
                              tmp.8
                              (let ((tmp.9 135)) (if tmp.9 tmp.9 70)))))))
                     (vector1
                      (let ((tmp.10 (call make-vector 8)))
                        (let ((g42374289
                               (call
                                vector-set!
                                tmp.10
                                0
                                (call (call make-vector 8)))))
                          (if (call error? g42374289)
                            g42374289
                            (let ((g42374290
                                   (call vector-set! tmp.10 1 (call #t))))
                              (if (call error? g42374290)
                                g42374290
                                (let ((g42374291
                                       (call vector-set! tmp.10 2 (call #t))))
                                  (if (call error? g42374291)
                                    g42374291
                                    (let ((g42374292
                                           (call
                                            vector-set!
                                            tmp.10
                                            3
                                            (call empty))))
                                      (if (call error? g42374292)
                                        g42374292
                                        (let ((g42374293
                                               (call
                                                vector-set!
                                                tmp.10
                                                4
                                                (call #\_))))
                                          (if (call error? g42374293)
                                            g42374293
                                            (let ((g42374294
                                                   (call
                                                    vector-set!
                                                    tmp.10
                                                    5
                                                    (call 111))))
                                              (if (call error? g42374294)
                                                g42374294
                                                (let ((g42374295
                                                       (call
                                                        vector-set!
                                                        tmp.10
                                                        6
                                                        (call 194))))
                                                  (if (call error? g42374295)
                                                    g42374295
                                                    (let ((g42374296
                                                           (call
                                                            vector-set!
                                                            tmp.10
                                                            7
                                                            (call
                                                             (lambda ()
                                                               699)))))
                                                      (if (call
                                                           error?
                                                           g42374296)
                                                        g42374296
                                                        tmp.10))))))))))))))))))
                     (error2
                      (let ((tmp.11 (error 173)))
                        (if tmp.11
                          tmp.11
                          (let ((tmp.12 (error 54)))
                            (if tmp.12
                              tmp.12
                              (let ((tmp.13 (error 170)))
                                (if tmp.13 tmp.13 (error 170)))))))))
                 (if empty
                   (if empty (if empty (if empty empty #f) #f) #f)
                   #f))))
          (if (call error? g42374288)
            g42374288
            (let ((g42374297
                   (let ((void0 (call fun/void8540))
                         (ascii-char1 (let () #\t))
                         (void2 (call fun/void8541)))
                     (if empty (if empty empty #f) #f))))
              (if (call error? g42374297)
                g42374297
                (let ((g42374298
                       (if (if #f empty empty)
                         (if (let ((boolean0 #t)
                                   (pair1
                                    (call cons 42 (call cons 383 empty))))
                               empty)
                           (if (if #t empty empty)
                             (if (let () empty)
                               (if (let ((vector0
                                          (let ((tmp.14 (call make-vector 8)))
                                            (let ((g42374299
                                                   (call
                                                    vector-set!
                                                    tmp.14
                                                    0
                                                    1)))
                                              (if (call error? g42374299)
                                                g42374299
                                                (let ((g42374300
                                                       (call
                                                        vector-set!
                                                        tmp.14
                                                        1
                                                        2)))
                                                  (if (call error? g42374300)
                                                    g42374300
                                                    (let ((g42374301
                                                           (call
                                                            vector-set!
                                                            tmp.14
                                                            2
                                                            3)))
                                                      (if (call
                                                           error?
                                                           g42374301)
                                                        g42374301
                                                        (let ((g42374302
                                                               (call
                                                                vector-set!
                                                                tmp.14
                                                                3
                                                                4)))
                                                          (if (call
                                                               error?
                                                               g42374302)
                                                            g42374302
                                                            (let ((g42374303
                                                                   (call
                                                                    vector-set!
                                                                    tmp.14
                                                                    4
                                                                    5)))
                                                              (if (call
                                                                   error?
                                                                   g42374303)
                                                                g42374303
                                                                (let ((g42374304
                                                                       (call
                                                                        vector-set!
                                                                        tmp.14
                                                                        5
                                                                        6)))
                                                                  (if (call
                                                                       error?
                                                                       g42374304)
                                                                    g42374304
                                                                    (let ((g42374305
                                                                           (call
                                                                            vector-set!
                                                                            tmp.14
                                                                            6
                                                                            7)))
                                                                      (if (call
                                                                           error?
                                                                           g42374305)
                                                                        g42374305
                                                                        (let ((g42374306
                                                                               (call
                                                                                vector-set!
                                                                                tmp.14
                                                                                7
                                                                                8)))
                                                                          (if (call
                                                                               error?
                                                                               g42374306)
                                                                            g42374306
                                                                            tmp.14))))))))))))))))))
                                         (procedure1 (lambda () empty))
                                         (empty2 empty))
                                     empty)
                                 (if #f empty empty)
                                 #f)
                               #f)
                             #f)
                           #f)
                         #f)))
                  (if (call error? g42374298)
                    g42374298
                    (let ((g42374307
                           (let ((g42374308 (if #f empty empty)))
                             (if (call error? g42374308)
                               g42374308
                               (let ((g42374309
                                      (let ((tmp.15 empty))
                                        (if tmp.15
                                          tmp.15
                                          (let ((tmp.16 empty))
                                            (if tmp.16
                                              tmp.16
                                              (let ((tmp.17 empty))
                                                (if tmp.17
                                                  tmp.17
                                                  (let ((tmp.18 empty))
                                                    (if tmp.18
                                                      tmp.18
                                                      empty))))))))))
                                 (if (call error? g42374309)
                                   g42374309
                                   (let ((g42374310
                                          (let ((boolean0 #f)) empty)))
                                     (if (call error? g42374310)
                                       g42374310
                                       (let ((g42374311
                                              (let ((pair0
                                                     (call
                                                      cons
                                                      205
                                                      (call cons 503 empty)))
                                                    (boolean1 #f)
                                                    (pair2
                                                     (call
                                                      cons
                                                      178
                                                      (call cons 296 empty))))
                                                empty)))
                                         (if (call error? g42374311)
                                           g42374311
                                           (let ((g42374312
                                                  (call
                                                   fun/empty8542
                                                   (error 60))))
                                             (if (call error? g42374312)
                                               g42374312
                                               (if empty empty #f)))))))))))))
                      (if (call error? g42374307)
                        g42374307
                        (let ((g42374313
                               (let ((vector0
                                      (let ((tmp.19 (call make-vector 8)))
                                        (let ((g42374314
                                               (call vector-set! tmp.19 0 0)))
                                          (if (call error? g42374314)
                                            g42374314
                                            (let ((g42374315
                                                   (call
                                                    vector-set!
                                                    tmp.19
                                                    1
                                                    1)))
                                              (if (call error? g42374315)
                                                g42374315
                                                (let ((g42374316
                                                       (call
                                                        vector-set!
                                                        tmp.19
                                                        2
                                                        2)))
                                                  (if (call error? g42374316)
                                                    g42374316
                                                    (let ((g42374317
                                                           (call
                                                            vector-set!
                                                            tmp.19
                                                            3
                                                            3)))
                                                      (if (call
                                                           error?
                                                           g42374317)
                                                        g42374317
                                                        (let ((g42374318
                                                               (call
                                                                vector-set!
                                                                tmp.19
                                                                4
                                                                4)))
                                                          (if (call
                                                               error?
                                                               g42374318)
                                                            g42374318
                                                            (let ((g42374319
                                                                   (call
                                                                    vector-set!
                                                                    tmp.19
                                                                    5
                                                                    5)))
                                                              (if (call
                                                                   error?
                                                                   g42374319)
                                                                g42374319
                                                                (let ((g42374320
                                                                       (call
                                                                        vector-set!
                                                                        tmp.19
                                                                        6
                                                                        6)))
                                                                  (if (call
                                                                       error?
                                                                       g42374320)
                                                                    g42374320
                                                                    (let ((g42374321
                                                                           (call
                                                                            vector-set!
                                                                            tmp.19
                                                                            7
                                                                            7)))
                                                                      (if (call
                                                                           error?
                                                                           g42374321)
                                                                        g42374321
                                                                        tmp.19))))))))))))))))))
                                     (pair1
                                      (call cons 168 (call cons 348 empty)))
                                     (error2 (error 250)))
                                 empty)))
                          (if (call error? g42374313)
                            g42374313
                            (let ((g42374322
                                   (let ((g42374323
                                          (let ((g42374324 empty))
                                            (if (call error? g42374324)
                                              g42374324
                                              empty))))
                                     (if (call error? g42374323)
                                       g42374323
                                       (let ((g42374325 (if #f empty empty)))
                                         (if (call error? g42374325)
                                           g42374325
                                           (let ((g42374326
                                                  (call fun/empty8543 #f #\l)))
                                             (if (call error? g42374326)
                                               g42374326
                                               (let ((g42374327
                                                      (let ((tmp.20 empty))
                                                        (if tmp.20
                                                          tmp.20
                                                          (let ((tmp.21 empty))
                                                            (if tmp.21
                                                              tmp.21
                                                              (let ((tmp.22
                                                                     empty))
                                                                (if tmp.22
                                                                  tmp.22
                                                                  (let ((tmp.23
                                                                         empty))
                                                                    (if tmp.23
                                                                      tmp.23
                                                                      empty))))))))))
                                                 (if (call error? g42374327)
                                                   g42374327
                                                   (let ((g42374328
                                                          (if #t empty empty)))
                                                     (if (call
                                                          error?
                                                          g42374328)
                                                       g42374328
                                                       (if #f
                                                         empty
                                                         empty)))))))))))))
                              (if (call error? g42374322)
                                g42374322
                                (let ((g42374329 (call fun/empty8544)))
                                  (if (call error? g42374329)
                                    g42374329
                                    (let ((g42374330
                                           (let ((tmp.24
                                                  (let ((ascii-char0 #\G)
                                                        (vector1
                                                         (let ((tmp.25
                                                                (call
                                                                 make-vector
                                                                 8)))
                                                           (let ((g42374331
                                                                  (call
                                                                   vector-set!
                                                                   tmp.25
                                                                   0
                                                                   0)))
                                                             (if (call
                                                                  error?
                                                                  g42374331)
                                                               g42374331
                                                               (let ((g42374332
                                                                      (call
                                                                       vector-set!
                                                                       tmp.25
                                                                       1
                                                                       1)))
                                                                 (if (call
                                                                      error?
                                                                      g42374332)
                                                                   g42374332
                                                                   (let ((g42374333
                                                                          (call
                                                                           vector-set!
                                                                           tmp.25
                                                                           2
                                                                           2)))
                                                                     (if (call
                                                                          error?
                                                                          g42374333)
                                                                       g42374333
                                                                       (let ((g42374334
                                                                              (call
                                                                               vector-set!
                                                                               tmp.25
                                                                               3
                                                                               3)))
                                                                         (if (call
                                                                              error?
                                                                              g42374334)
                                                                           g42374334
                                                                           (let ((g42374335
                                                                                  (call
                                                                                   vector-set!
                                                                                   tmp.25
                                                                                   4
                                                                                   4)))
                                                                             (if (call
                                                                                  error?
                                                                                  g42374335)
                                                                               g42374335
                                                                               (let ((g42374336
                                                                                      (call
                                                                                       vector-set!
                                                                                       tmp.25
                                                                                       5
                                                                                       5)))
                                                                                 (if (call
                                                                                      error?
                                                                                      g42374336)
                                                                                   g42374336
                                                                                   (let ((g42374337
                                                                                          (call
                                                                                           vector-set!
                                                                                           tmp.25
                                                                                           6
                                                                                           6)))
                                                                                     (if (call
                                                                                          error?
                                                                                          g42374337)
                                                                                       g42374337
                                                                                       (let ((g42374338
                                                                                              (call
                                                                                               vector-set!
                                                                                               tmp.25
                                                                                               7
                                                                                               7)))
                                                                                         (if (call
                                                                                              error?
                                                                                              g42374338)
                                                                                           g42374338
                                                                                           tmp.25))))))))))))))))))
                                                        (boolean2 #f))
                                                    empty)))
                                             (if tmp.24
                                               tmp.24
                                               (let ((tmp.26
                                                      (let ((fixnum0 247)
                                                            (ascii-char1 #\T))
                                                        empty)))
                                                 (if tmp.26
                                                   tmp.26
                                                   (let ((tmp.27
                                                          (call
                                                           fun/empty8546
                                                           (lambda () 652))))
                                                     (if tmp.27
                                                       tmp.27
                                                       (let ((tmp.28
                                                              (let ((vector0
                                                                     (let ((tmp.29
                                                                            (call
                                                                             make-vector
                                                                             8)))
                                                                       (let ((g42374339
                                                                              (call
                                                                               vector-set!
                                                                               tmp.29
                                                                               0
                                                                               0)))
                                                                         (if (call
                                                                              error?
                                                                              g42374339)
                                                                           g42374339
                                                                           (let ((g42374340
                                                                                  (call
                                                                                   vector-set!
                                                                                   tmp.29
                                                                                   1
                                                                                   1)))
                                                                             (if (call
                                                                                  error?
                                                                                  g42374340)
                                                                               g42374340
                                                                               (let ((g42374341
                                                                                      (call
                                                                                       vector-set!
                                                                                       tmp.29
                                                                                       2
                                                                                       2)))
                                                                                 (if (call
                                                                                      error?
                                                                                      g42374341)
                                                                                   g42374341
                                                                                   (let ((g42374342
                                                                                          (call
                                                                                           vector-set!
                                                                                           tmp.29
                                                                                           3
                                                                                           3)))
                                                                                     (if (call
                                                                                          error?
                                                                                          g42374342)
                                                                                       g42374342
                                                                                       (let ((g42374343
                                                                                              (call
                                                                                               vector-set!
                                                                                               tmp.29
                                                                                               4
                                                                                               4)))
                                                                                         (if (call
                                                                                              error?
                                                                                              g42374343)
                                                                                           g42374343
                                                                                           (let ((g42374344
                                                                                                  (call
                                                                                                   vector-set!
                                                                                                   tmp.29
                                                                                                   5
                                                                                                   5)))
                                                                                             (if (call
                                                                                                  error?
                                                                                                  g42374344)
                                                                                               g42374344
                                                                                               (let ((g42374345
                                                                                                      (call
                                                                                                       vector-set!
                                                                                                       tmp.29
                                                                                                       6
                                                                                                       6)))
                                                                                                 (if (call
                                                                                                      error?
                                                                                                      g42374345)
                                                                                                   g42374345
                                                                                                   (let ((g42374346
                                                                                                          (call
                                                                                                           vector-set!
                                                                                                           tmp.29
                                                                                                           7
                                                                                                           7)))
                                                                                                     (if (call
                                                                                                          error?
                                                                                                          g42374346)
                                                                                                       g42374346
                                                                                                       tmp.29))))))))))))))))))
                                                                    (fixnum1
                                                                     146))
                                                                empty)))
                                                         (if tmp.28
                                                           tmp.28
                                                           (let ((tmp.30
                                                                  (let ((tmp.31
                                                                         empty))
                                                                    (if tmp.31
                                                                      tmp.31
                                                                      (let ((tmp.32
                                                                             empty))
                                                                        (if tmp.32
                                                                          tmp.32
                                                                          (let ((tmp.33
                                                                                 empty))
                                                                            (if tmp.33
                                                                              tmp.33
                                                                              empty))))))))
                                                             (if tmp.30
                                                               tmp.30
                                                               (let ((fixnum0
                                                                      152)
                                                                     (error1
                                                                      (error
                                                                       182)))
                                                                 empty)))))))))))))
                                      (if (call error? g42374330)
                                        g42374330
                                        (call
                                         fun/empty8547)))))))))))))))))))))
(check-by-interp
 '(module
    (define fun/fixnum8552 (lambda () (call fun/fixnum8553 235)))
    (define fun/boolean8550 (lambda (oprand0 oprand1) (call fun/boolean8551)))
    (define fun/fixnum8553 (lambda (oprand0) oprand0))
    (define fun/boolean8551 (lambda () #f))
    (if (call
         fun/boolean8550
         (if #t #\C #\o)
         (let ((g42378163 (call cons 107 (call cons 348 empty))))
           (if (call error? g42378163)
             g42378163
             (let ((g42378164 (call cons 203 (call cons 496 empty))))
               (if (call error? g42378164)
                 g42378164
                 (let ((g42378165 (call cons 79 (call cons 267 empty))))
                   (if (call error? g42378165)
                     g42378165
                     (let ((g42378166 (call cons 239 (call cons 409 empty))))
                       (if (call error? g42378166)
                         g42378166
                         (let ((g42378167
                                (call cons 77 (call cons 484 empty))))
                           (if (call error? g42378167)
                             g42378167
                             (let ((g42378168
                                    (call cons 220 (call cons 290 empty))))
                               (if (call error? g42378168)
                                 g42378168
                                 (call
                                  cons
                                  89
                                  (call cons 469 empty)))))))))))))))
      (call fun/fixnum8552)
      (let () 134))))
(check-by-interp
 '(module
    (define fun/fixnum8556 (lambda (oprand0 oprand1) (if #t 71 190)))
    (if (let ((pair0 (call cons 177 (call cons 360 empty)))
              (empty1 empty)
              (boolean2 #f))
          #t)
      (let ((pair0 (call cons 210 (call cons 266 empty)))) 198)
      (call
       fun/fixnum8556
       (if #t empty empty)
       (let ((g42381986 (call cons 103 (call cons 399 empty))))
         (if (call error? g42381986)
           g42381986
           (call cons 19 (call cons 508 empty))))))))
(check-by-interp
 '(module
    (define fun/pair8560
      (lambda (oprand0) (call cons 5 (call cons 421 empty))))
    (define fun/procedure8559 (lambda () (lambda () 550)))
    (let ((vector0
           (let ((tmp.7 (call make-vector 8)))
             (let ((g42385801
                    (call vector-set! tmp.7 0 (call (let () (void))))))
               (if (call error? g42385801)
                 g42385801
                 (let ((g42385802
                        (call vector-set! tmp.7 1 (call (let () 84)))))
                   (if (call error? g42385802)
                     g42385802
                     (let ((g42385803
                            (call
                             vector-set!
                             tmp.7
                             2
                             (call
                              (let ((pair0
                                     (call cons 115 (call cons 428 empty)))
                                    (empty1 empty))
                                (void))))))
                       (if (call error? g42385803)
                         g42385803
                         (let ((g42385804
                                (call
                                 vector-set!
                                 tmp.7
                                 3
                                 (call
                                  (let ((tmp.8 69))
                                    (if tmp.8
                                      tmp.8
                                      (let ((tmp.9 50))
                                        (if tmp.9
                                          tmp.9
                                          (let ((tmp.10 147))
                                            (if tmp.10
                                              tmp.10
                                              (let ((tmp.11 112))
                                                (if tmp.11
                                                  tmp.11
                                                  173))))))))))))
                           (if (call error? g42385804)
                             g42385804
                             (let ((g42385805
                                    (call
                                     vector-set!
                                     tmp.7
                                     4
                                     (call (let () empty)))))
                               (if (call error? g42385805)
                                 g42385805
                                 (let ((g42385806
                                        (call
                                         vector-set!
                                         tmp.7
                                         5
                                         (call (call fun/procedure8559)))))
                                   (if (call error? g42385806)
                                     g42385806
                                     (let ((g42385807
                                            (call
                                             vector-set!
                                             tmp.7
                                             6
                                             (call (if #f empty empty)))))
                                       (if (call error? g42385807)
                                         g42385807
                                         (let ((g42385808
                                                (call
                                                 vector-set!
                                                 tmp.7
                                                 7
                                                 (call
                                                  (call fun/pair8560 #t)))))
                                           (if (call error? g42385808)
                                             g42385808
                                             tmp.7)))))))))))))))))))
      (if #f #\J #\`))))
(check-by-interp
 '(module
    (define fun/error7326 (lambda () (if #f (error 41) (error 41))))
    (define fun/any7325
      (lambda ()
        (let ((tmp.7 (call make-vector 8)))
          (let ((g42409226 (call vector-set! tmp.7 0 1)))
            (if (call error? g42409226)
              g42409226
              (let ((g42409227 (call vector-set! tmp.7 1 2)))
                (if (call error? g42409227)
                  g42409227
                  (let ((g42409228 (call vector-set! tmp.7 2 3)))
                    (if (call error? g42409228)
                      g42409228
                      (let ((g42409229 (call vector-set! tmp.7 3 4)))
                        (if (call error? g42409229)
                          g42409229
                          (let ((g42409230 (call vector-set! tmp.7 4 5)))
                            (if (call error? g42409230)
                              g42409230
                              (let ((g42409231 (call vector-set! tmp.7 5 6)))
                                (if (call error? g42409231)
                                  g42409231
                                  (let ((g42409232
                                         (call vector-set! tmp.7 6 7)))
                                    (if (call error? g42409232)
                                      g42409232
                                      (let ((g42409233
                                             (call vector-set! tmp.7 7 8)))
                                        (if (call error? g42409233)
                                          g42409233
                                          tmp.7)))))))))))))))))))
    (define fun/error7327 (lambda (oprand0 oprand1) (error 150)))
    (if (call ascii-char? (call fun/any7325))
      (call fun/error7326)
      (let ((tmp.8 (if (error 73) (if (error 249) (error 226) #f) #f)))
        (if tmp.8
          tmp.8
          (let ((tmp.9
                 (let ((g42409234 (error 136)))
                   (if (call error? g42409234)
                     g42409234
                     (let ((g42409235 (error 134)))
                       (if (call error? g42409235)
                         g42409235
                         (let ((g42409236 (error 216)))
                           (if (call error? g42409236)
                             g42409236
                             (error 132)))))))))
            (if tmp.9
              tmp.9
              (let ((tmp.10 (if #t (error 103) (error 151))))
                (if tmp.10
                  tmp.10
                  (let ((tmp.11
                         (call
                          fun/error7327
                          (void)
                          (let ((tmp.12 (call make-vector 8)))
                            (let ((g42409237 (call vector-set! tmp.12 0 1)))
                              (if (call error? g42409237)
                                g42409237
                                (let ((g42409238
                                       (call vector-set! tmp.12 1 2)))
                                  (if (call error? g42409238)
                                    g42409238
                                    (let ((g42409239
                                           (call vector-set! tmp.12 2 3)))
                                      (if (call error? g42409239)
                                        g42409239
                                        (let ((g42409240
                                               (call vector-set! tmp.12 3 4)))
                                          (if (call error? g42409240)
                                            g42409240
                                            (let ((g42409241
                                                   (call
                                                    vector-set!
                                                    tmp.12
                                                    4
                                                    5)))
                                              (if (call error? g42409241)
                                                g42409241
                                                (let ((g42409242
                                                       (call
                                                        vector-set!
                                                        tmp.12
                                                        5
                                                        6)))
                                                  (if (call error? g42409242)
                                                    g42409242
                                                    (let ((g42409243
                                                           (call
                                                            vector-set!
                                                            tmp.12
                                                            6
                                                            7)))
                                                      (if (call
                                                           error?
                                                           g42409243)
                                                        g42409243
                                                        (let ((g42409244
                                                               (call
                                                                vector-set!
                                                                tmp.12
                                                                7
                                                                8)))
                                                          (if (call
                                                               error?
                                                               g42409244)
                                                            g42409244
                                                            tmp.12))))))))))))))))))))
                    (if tmp.11
                      tmp.11
                      (let ((tmp.13 (let ((fixnum0 172)) (error 184))))
                        (if tmp.13
                          tmp.13
                          (let ((g42409245 (error 89)))
                            (if (call error? g42409245)
                              g42409245
                              (error 219))))))))))))))))
(check-by-interp
 '(module
    (define fun/ascii-char8478 (lambda () (if #t #\t #\O)))
    (if (let ((tmp.7 (if #t #t #t)))
          (if tmp.7
            tmp.7
            (let ((tmp.8 (let () #t)))
              (if tmp.8
                tmp.8
                (let ((tmp.9
                       (let ((g42413066 #t))
                         (if (call error? g42413066)
                           g42413066
                           (let ((g42413067 #t))
                             (if (call error? g42413067)
                               g42413067
                               (let ((g42413068 #f))
                                 (if (call error? g42413068)
                                   g42413068
                                   (let ((g42413069 #t))
                                     (if (call error? g42413069)
                                       g42413069
                                       (let ((g42413070 #f))
                                         (if (call error? g42413070)
                                           g42413070
                                           (let ((g42413071 #f))
                                             (if (call error? g42413071)
                                               g42413071
                                               #t))))))))))))))
                  (if tmp.9 tmp.9 (if #f (if #t (if #f #t #f) #f) #f)))))))
      (let () #\k)
      (call fun/ascii-char8478))))
(check-by-interp
 '(module
    (let ((boolean0 (call ascii-char? (if #f #\l 229)))) (let () (void)))))
(check-by-interp
 '(module
    (define fun/fixnum8485 (lambda (oprand0) oprand0))
    (define fun/boolean8483 (lambda (oprand0 oprand1) (let () #t)))
    (define fun/fixnum8484 (lambda () (call fun/fixnum8485 41)))
    (if (call
         fun/boolean8483
         (if #t (void) (void))
         (let ((tmp.7 (lambda () 845)))
           (if tmp.7
             tmp.7
             (let ((tmp.8 (lambda () 630)))
               (if tmp.8
                 tmp.8
                 (let ((tmp.9 (lambda () 689)))
                   (if tmp.9
                     tmp.9
                     (let ((tmp.10 (lambda () 943)))
                       (if tmp.10
                         tmp.10
                         (let ((tmp.11 (lambda () 1016)))
                           (if tmp.11
                             tmp.11
                             (let ((tmp.12 (lambda () 978)))
                               (if tmp.12 tmp.12 (lambda () 974))))))))))))))
      (call fun/fixnum8484)
      (if #t 109 42))))
(check-by-interp
 '(module
    (define fun/pair8489 (lambda () (call cons 183 (call cons 488 empty))))
    (define fun/pair8488 (lambda () (call cons 88 (call cons 319 empty))))
    (let ((ascii-char0 (if #t #\T #\Q))
          (vector1
           (let ((tmp.7 (call make-vector 8)))
             (let ((g42424517
                    (call vector-set! tmp.7 0 (call (let () empty)))))
               (if (call error? g42424517)
                 g42424517
                 (let ((g42424518
                        (call
                         vector-set!
                         tmp.7
                         1
                         (call (call error? (lambda () 656))))))
                   (if (call error? g42424518)
                     g42424518
                     (let ((g42424519
                            (call
                             vector-set!
                             tmp.7
                             2
                             (call (call fun/pair8488)))))
                       (if (call error? g42424519)
                         g42424519
                         (let ((g42424520
                                (call
                                 vector-set!
                                 tmp.7
                                 3
                                 (call (if #t (error 221) (error 62))))))
                           (if (call error? g42424520)
                             g42424520
                             (let ((g42424521
                                    (call
                                     vector-set!
                                     tmp.7
                                     4
                                     (call (call empty? (void))))))
                               (if (call error? g42424521)
                                 g42424521
                                 (let ((g42424522
                                        (call
                                         vector-set!
                                         tmp.7
                                         5
                                         (call (if #f empty empty)))))
                                   (if (call error? g42424522)
                                     g42424522
                                     (let ((g42424523
                                            (call
                                             vector-set!
                                             tmp.7
                                             6
                                             (call (call fun/pair8489)))))
                                       (if (call error? g42424523)
                                         g42424523
                                         (let ((g42424524
                                                (call
                                                 vector-set!
                                                 tmp.7
                                                 7
                                                 (call
                                                  (if #f
                                                    (call
                                                     cons
                                                     201
                                                     (call cons 424 empty))
                                                    (call
                                                     cons
                                                     65
                                                     (call
                                                      cons
                                                      350
                                                      empty)))))))
                                           (if (call error? g42424524)
                                             g42424524
                                             tmp.7)))))))))))))))))))
      (let () (void)))))
(check-by-interp
 '(module
    (let ((g42428345
           (let ((empty0 empty) (fixnum1 21) (ascii-char2 #\F)) (void))))
      (if (call error? g42428345)
        g42428345
        (let ((g42428346 (let () (void))))
          (if (call error? g42428346) g42428346 (if #f (void) (void))))))))
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
     (if (call
          fun/boolean8510
          (let ((tmp.7 (call make-vector 8)))
            (let ((g42439795 (call vector-set! tmp.7 0 0)))
              (if (call error? g42439795)
                g42439795
                (let ((g42439796 (call vector-set! tmp.7 1 1)))
                  (if (call error? g42439796)
                    g42439796
                    (let ((g42439797 (call vector-set! tmp.7 2 2)))
                      (if (call error? g42439797)
                        g42439797
                        (let ((g42439798 (call vector-set! tmp.7 3 3)))
                          (if (call error? g42439798)
                            g42439798
                            (let ((g42439799 (call vector-set! tmp.7 4 4)))
                              (if (call error? g42439799)
                                g42439799
                                (let ((g42439800 (call vector-set! tmp.7 5 5)))
                                  (if (call error? g42439800)
                                    g42439800
                                    (let ((g42439801
                                           (call vector-set! tmp.7 6 6)))
                                      (if (call error? g42439801)
                                        g42439801
                                        (let ((g42439802
                                               (call vector-set! tmp.7 7 7)))
                                          (if (call error? g42439802)
                                            g42439802
                                            tmp.7)))))))))))))))))
          (void))
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
    (let ((boolean0 (call <= (let () 15) (let ((void0 (void))) 193))))
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
    (if (let ((void0 (let () (void)))
              (pair1
               (call
                cons
                #\M
                (call
                 cons
                 #\\
                 (call
                  cons
                  (call cons 118 (call cons 358 empty))
                  (call
                   cons
                   (call cons 16 (call cons 483 empty))
                   (call
                    cons
                    empty
                    (call cons #t (call cons #t (call cons #t empty))))))))))
          (call fun/ascii-char8518))
      (if (if (call
               fun/ascii-char8519
               #\d
               (if #t
                 (call cons 212 (call cons 434 empty))
                 (call cons 140 (call cons 331 empty))))
            (if (let () #\T)
              (if (if #f #\_ #\J)
                (let ((procedure0 (lambda (oprand0) 53))
                      (pair1 (call cons 151 (call cons 317 empty))))
                  #\b)
                #f)
              #f)
            #f)
        (if (let ((boolean0
                   (let ((empty0 empty)
                         (procedure1
                          (lambda ()
                            (let ((tmp.7 (call make-vector 8)))
                              (let ((g42447437 (call vector-set! tmp.7 0 0)))
                                (if (call error? g42447437)
                                  g42447437
                                  (let ((g42447438
                                         (call vector-set! tmp.7 1 1)))
                                    (if (call error? g42447438)
                                      g42447438
                                      (let ((g42447439
                                             (call vector-set! tmp.7 2 2)))
                                        (if (call error? g42447439)
                                          g42447439
                                          (let ((g42447440
                                                 (call vector-set! tmp.7 3 3)))
                                            (if (call error? g42447440)
                                              g42447440
                                              (let ((g42447441
                                                     (call
                                                      vector-set!
                                                      tmp.7
                                                      4
                                                      4)))
                                                (if (call error? g42447441)
                                                  g42447441
                                                  (let ((g42447442
                                                         (call
                                                          vector-set!
                                                          tmp.7
                                                          5
                                                          5)))
                                                    (if (call error? g42447442)
                                                      g42447442
                                                      (let ((g42447443
                                                             (call
                                                              vector-set!
                                                              tmp.7
                                                              6
                                                              6)))
                                                        (if (call
                                                             error?
                                                             g42447443)
                                                          g42447443
                                                          (let ((g42447444
                                                                 (call
                                                                  vector-set!
                                                                  tmp.7
                                                                  7
                                                                  7)))
                                                            (if (call
                                                                 error?
                                                                 g42447444)
                                                              g42447444
                                                              tmp.7))))))))))))))))))))
                     #t)))
              (call fun/ascii-char8520 #\g))
          (if (call fun/ascii-char8521)
            (if (if (let () #\k)
                  (if (let ((vector0
                             (let ((tmp.8 (call make-vector 8)))
                               (let ((g42447445 (call vector-set! tmp.8 0 1)))
                                 (if (call error? g42447445)
                                   g42447445
                                   (let ((g42447446
                                          (call vector-set! tmp.8 1 2)))
                                     (if (call error? g42447446)
                                       g42447446
                                       (let ((g42447447
                                              (call vector-set! tmp.8 2 3)))
                                         (if (call error? g42447447)
                                           g42447447
                                           (let ((g42447448
                                                  (call
                                                   vector-set!
                                                   tmp.8
                                                   3
                                                   4)))
                                             (if (call error? g42447448)
                                               g42447448
                                               (let ((g42447449
                                                      (call
                                                       vector-set!
                                                       tmp.8
                                                       4
                                                       5)))
                                                 (if (call error? g42447449)
                                                   g42447449
                                                   (let ((g42447450
                                                          (call
                                                           vector-set!
                                                           tmp.8
                                                           5
                                                           6)))
                                                     (if (call
                                                          error?
                                                          g42447450)
                                                       g42447450
                                                       (let ((g42447451
                                                              (call
                                                               vector-set!
                                                               tmp.8
                                                               6
                                                               7)))
                                                         (if (call
                                                              error?
                                                              g42447451)
                                                           g42447451
                                                           (let ((g42447452
                                                                  (call
                                                                   vector-set!
                                                                   tmp.8
                                                                   7
                                                                   8)))
                                                             (if (call
                                                                  error?
                                                                  g42447452)
                                                               g42447452
                                                               tmp.8)))))))))))))))))))
                        #\\)
                    (if #t #\x #\n)
                    #f)
                  #f)
              (let ((ascii-char0 (if #t #\x #\o)) (void1 (let () (void))))
                (if #t #\C #\Z))
              #f)
            #f)
          #f)
        #f)
      #f)))
(check-by-interp
 '(module
    (define fun/ascii-char8527 (lambda () (call fun/ascii-char8528)))
    (define fun/ascii-char8528
      (lambda () (let ((pair0 (call cons 127 (call cons 352 empty)))) #\Y)))
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
    (let ((g42455084
           (call
            fun/ascii-char8534
            (if #f (lambda () 968) (lambda () 631))
            (let () empty))))
      (if (call error? g42455084)
        g42455084
        (let ((g42455085
               (if (let ((boolean0 #f) (empty1 empty)) #f)
                 (let ((error0 (error 211)) (ascii-char1 #\U)) #\b)
                 (let ((g42455086 #\f))
                   (if (call error? g42455086)
                     g42455086
                     (let ((g42455087 #\`))
                       (if (call error? g42455087)
                         g42455087
                         (let ((g42455088 #\a))
                           (if (call error? g42455088)
                             g42455088
                             (let ((g42455089 #\O))
                               (if (call error? g42455089)
                                 g42455089
                                 (let ((g42455090 #\`))
                                   (if (call error? g42455090)
                                     g42455090
                                     (let ((g42455091 #\O))
                                       (if (call error? g42455091)
                                         g42455091
                                         #\J)))))))))))))))
          (if (call error? g42455085)
            g42455085
            (let ((g42455092
                   (let ((pair0
                          (call
                           cons
                           (call cons 8 (call cons 450 empty))
                           (call
                            cons
                            (call cons 143 (call cons 368 empty))
                            (call
                             cons
                             110
                             (call
                              cons
                              empty
                              (call
                               cons
                               empty
                               (call
                                cons
                                #t
                                (call cons #\B (call cons empty empty)))))))))
                         (vector1
                          (let ((tmp.7 (call make-vector 8)))
                            (let ((g42455093
                                   (call
                                    vector-set!
                                    tmp.7
                                    0
                                    (call (lambda () 902)))))
                              (if (call error? g42455093)
                                g42455093
                                (let ((g42455094
                                       (call
                                        vector-set!
                                        tmp.7
                                        1
                                        (call (error 179)))))
                                  (if (call error? g42455094)
                                    g42455094
                                    (let ((g42455095
                                           (call
                                            vector-set!
                                            tmp.7
                                            2
                                            (call
                                             (call
                                              cons
                                              17
                                              (call cons 299 empty))))))
                                      (if (call error? g42455095)
                                        g42455095
                                        (let ((g42455096
                                               (call
                                                vector-set!
                                                tmp.7
                                                3
                                                (call #\E))))
                                          (if (call error? g42455096)
                                            g42455096
                                            (let ((g42455097
                                                   (call
                                                    vector-set!
                                                    tmp.7
                                                    4
                                                    (call (void)))))
                                              (if (call error? g42455097)
                                                g42455097
                                                (let ((g42455098
                                                       (call
                                                        vector-set!
                                                        tmp.7
                                                        5
                                                        (call
                                                         (let ((tmp.8
                                                                (call
                                                                 make-vector
                                                                 8)))
                                                           (let ((g42455099
                                                                  (call
                                                                   vector-set!
                                                                   tmp.8
                                                                   0
                                                                   1)))
                                                             (if (call
                                                                  error?
                                                                  g42455099)
                                                               g42455099
                                                               (let ((g42455100
                                                                      (call
                                                                       vector-set!
                                                                       tmp.8
                                                                       1
                                                                       2)))
                                                                 (if (call
                                                                      error?
                                                                      g42455100)
                                                                   g42455100
                                                                   (let ((g42455101
                                                                          (call
                                                                           vector-set!
                                                                           tmp.8
                                                                           2
                                                                           3)))
                                                                     (if (call
                                                                          error?
                                                                          g42455101)
                                                                       g42455101
                                                                       (let ((g42455102
                                                                              (call
                                                                               vector-set!
                                                                               tmp.8
                                                                               3
                                                                               4)))
                                                                         (if (call
                                                                              error?
                                                                              g42455102)
                                                                           g42455102
                                                                           (let ((g42455103
                                                                                  (call
                                                                                   vector-set!
                                                                                   tmp.8
                                                                                   4
                                                                                   5)))
                                                                             (if (call
                                                                                  error?
                                                                                  g42455103)
                                                                               g42455103
                                                                               (let ((g42455104
                                                                                      (call
                                                                                       vector-set!
                                                                                       tmp.8
                                                                                       5
                                                                                       6)))
                                                                                 (if (call
                                                                                      error?
                                                                                      g42455104)
                                                                                   g42455104
                                                                                   (let ((g42455105
                                                                                          (call
                                                                                           vector-set!
                                                                                           tmp.8
                                                                                           6
                                                                                           7)))
                                                                                     (if (call
                                                                                          error?
                                                                                          g42455105)
                                                                                       g42455105
                                                                                       (let ((g42455106
                                                                                              (call
                                                                                               vector-set!
                                                                                               tmp.8
                                                                                               7
                                                                                               8)))
                                                                                         (if (call
                                                                                              error?
                                                                                              g42455106)
                                                                                           g42455106
                                                                                           tmp.8)))))))))))))))))))))
                                                  (if (call error? g42455098)
                                                    g42455098
                                                    (let ((g42455107
                                                           (call
                                                            vector-set!
                                                            tmp.7
                                                            6
                                                            (call empty))))
                                                      (if (call
                                                           error?
                                                           g42455107)
                                                        g42455107
                                                        (let ((g42455108
                                                               (call
                                                                vector-set!
                                                                tmp.7
                                                                7
                                                                (call
                                                                 (lambda ()
                                                                   959)))))
                                                          (if (call
                                                               error?
                                                               g42455108)
                                                            g42455108
                                                            tmp.7))))))))))))))))))
                         (void2 (call fun/void8537)))
                     (call fun/ascii-char8538))))
              (if (call error? g42455092)
                g42455092
                (let ((g42455109
                       (call
                        fun/ascii-char8539
                        (if #f #f #t)
                        (call
                         fun/boolean8540
                         (let ((tmp.9 empty))
                           (if tmp.9
                             tmp.9
                             (let ((tmp.10 empty))
                               (if tmp.10
                                 tmp.10
                                 (let ((tmp.11 empty))
                                   (if tmp.11 tmp.11 empty))))))
                         (call fun/fixnum8541)))))
                  (if (call error? g42455109)
                    g42455109
                    (let ((g42455110
                           (if (if #t #\i #\[)
                             (if (call
                                  fun/ascii-char8542
                                  (let ((fixnum0 241) (boolean1 #f)) (void))
                                  (if #f #f #f))
                               (if (let ((boolean0 #f) (boolean1 #f)) #\m)
                                 (if #t #\Y #\W)
                                 #f)
                               #f)
                             #f)))
                      (if (call error? g42455110)
                        g42455110
                        (call
                         fun/ascii-char8544
                         (call procedure? (if #f (error 129) #\`))
                         (call fun/boolean8547))))))))))))))
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
       (call
        fun/empty8562
        (let ((tmp.7 (call make-vector 8)))
          (let ((g42462740 (call vector-set! tmp.7 0 1)))
            (if (call error? g42462740)
              g42462740
              (let ((g42462741 (call vector-set! tmp.7 1 2)))
                (if (call error? g42462741)
                  g42462741
                  (let ((g42462742 (call vector-set! tmp.7 2 3)))
                    (if (call error? g42462742)
                      g42462742
                      (let ((g42462743 (call vector-set! tmp.7 3 4)))
                        (if (call error? g42462743)
                          g42462743
                          (let ((g42462744 (call vector-set! tmp.7 4 5)))
                            (if (call error? g42462744)
                              g42462744
                              (let ((g42462745 (call vector-set! tmp.7 5 6)))
                                (if (call error? g42462745)
                                  g42462745
                                  (let ((g42462746
                                         (call vector-set! tmp.7 6 7)))
                                    (if (call error? g42462746)
                                      g42462746
                                      (let ((g42462747
                                             (call vector-set! tmp.7 7 8)))
                                        (if (call error? g42462747)
                                          g42462747
                                          tmp.7)))))))))))))))))
        (lambda () 807)))
     (if (call
          fun/boolean8563
          (let ((tmp.8 (call make-vector 8)))
            (let ((g42462748 (call vector-set! tmp.8 0 1)))
              (if (call error? g42462748)
                g42462748
                (let ((g42462749 (call vector-set! tmp.8 1 2)))
                  (if (call error? g42462749)
                    g42462749
                    (let ((g42462750 (call vector-set! tmp.8 2 3)))
                      (if (call error? g42462750)
                        g42462750
                        (let ((g42462751 (call vector-set! tmp.8 3 4)))
                          (if (call error? g42462751)
                            g42462751
                            (let ((g42462752 (call vector-set! tmp.8 4 5)))
                              (if (call error? g42462752)
                                g42462752
                                (let ((g42462753 (call vector-set! tmp.8 5 6)))
                                  (if (call error? g42462753)
                                    g42462753
                                    (let ((g42462754
                                           (call vector-set! tmp.8 6 7)))
                                      (if (call error? g42462754)
                                        g42462754
                                        (let ((g42462755
                                               (call vector-set! tmp.8 7 8)))
                                          (if (call error? g42462755)
                                            g42462755
                                            tmp.8))))))))))))))))))
       (if #t #t #f)
       (let () #f)))))
(check-by-interp
 '(module
    (define fun/fixnum8572 (lambda () (call fun/fixnum8573)))
    (define fun/fixnum8575 (lambda () 182))
    (define fun/fixnum8573 (lambda () 219))
    (define fun/fixnum8574 (lambda () (call fun/fixnum8575)))
    (let ((fixnum0 (call fun/fixnum8572))
          (error1 (let () (error 252)))
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
            (let ((g42470384 (error 207)))
              (if (call error? g42470384)
                g42470384
                (let ((g42470385 (error 104)))
                  (if (call error? g42470385)
                    g42470385
                    (let ((g42470386 (error 16)))
                      (if (call error? g42470386)
                        g42470386
                        (let ((g42470387 (error 167)))
                          (if (call error? g42470387)
                            g42470387
                            (error 61))))))))))
           (error1
            (if (error 129)
              (if (error 74)
                (if (error 177)
                  (if (error 101) (if (error 159) (error 164) #f) #f)
                  #f)
                #f)
              #f)))
       (let ((g42470388 (error 161)))
         (if (call error? g42470388)
           g42470388
           (let ((g42470389 (error 194)))
             (if (call error? g42470389) g42470389 (error 177)))))))))
(check-by-interp
 '(module
    (define fun/error8591 (lambda () (error 47)))
    (define fun/pair8592
      (lambda (oprand0)
        (if #f
          (call cons 232 (call cons 299 empty))
          (call cons 190 (call cons 484 empty)))))
    (define fun/error8589 (lambda (oprand0 oprand1) (call fun/error8590)))
    (define fun/error8590 (lambda () (call fun/error8591)))
    (call
     fun/error8589
     (call fun/pair8592 (let ((ascii-char0 #\_) (fixnum1 180)) (void)))
     (let ((vector0
            (let ((tmp.7 (call make-vector 8)))
              (let ((g42474204 (call vector-set! tmp.7 0 (call empty))))
                (if (call error? g42474204)
                  g42474204
                  (let ((g42474205
                         (call vector-set! tmp.7 1 (call (error 230)))))
                    (if (call error? g42474205)
                      g42474205
                      (let ((g42474206
                             (call vector-set! tmp.7 2 (call (void)))))
                        (if (call error? g42474206)
                          g42474206
                          (let ((g42474207
                                 (call
                                  vector-set!
                                  tmp.7
                                  3
                                  (call
                                   (call cons 167 (call cons 385 empty))))))
                            (if (call error? g42474207)
                              g42474207
                              (let ((g42474208
                                     (call vector-set! tmp.7 4 (call (void)))))
                                (if (call error? g42474208)
                                  g42474208
                                  (let ((g42474209
                                         (call
                                          vector-set!
                                          tmp.7
                                          5
                                          (call empty))))
                                    (if (call error? g42474209)
                                      g42474209
                                      (let ((g42474210
                                             (call
                                              vector-set!
                                              tmp.7
                                              6
                                              (call #\c))))
                                        (if (call error? g42474210)
                                          g42474210
                                          (let ((g42474211
                                                 (call
                                                  vector-set!
                                                  tmp.7
                                                  7
                                                  (call #\t))))
                                            (if (call error? g42474211)
                                              g42474211
                                              tmp.7))))))))))))))))))
           (vector1
            (let ((tmp.8 (call make-vector 8)))
              (let ((g42474212 (call vector-set! tmp.8 0 (call (error 207)))))
                (if (call error? g42474212)
                  g42474212
                  (let ((g42474213
                         (call vector-set! tmp.8 1 (call (lambda () 674)))))
                    (if (call error? g42474213)
                      g42474213
                      (let ((g42474214
                             (call
                              vector-set!
                              tmp.8
                              2
                              (call
                               (let ((tmp.9 (call make-vector 8)))
                                 (let ((g42474215
                                        (call vector-set! tmp.9 0 1)))
                                   (if (call error? g42474215)
                                     g42474215
                                     (let ((g42474216
                                            (call vector-set! tmp.9 1 2)))
                                       (if (call error? g42474216)
                                         g42474216
                                         (let ((g42474217
                                                (call vector-set! tmp.9 2 3)))
                                           (if (call error? g42474217)
                                             g42474217
                                             (let ((g42474218
                                                    (call
                                                     vector-set!
                                                     tmp.9
                                                     3
                                                     4)))
                                               (if (call error? g42474218)
                                                 g42474218
                                                 (let ((g42474219
                                                        (call
                                                         vector-set!
                                                         tmp.9
                                                         4
                                                         5)))
                                                   (if (call error? g42474219)
                                                     g42474219
                                                     (let ((g42474220
                                                            (call
                                                             vector-set!
                                                             tmp.9
                                                             5
                                                             6)))
                                                       (if (call
                                                            error?
                                                            g42474220)
                                                         g42474220
                                                         (let ((g42474221
                                                                (call
                                                                 vector-set!
                                                                 tmp.9
                                                                 6
                                                                 7)))
                                                           (if (call
                                                                error?
                                                                g42474221)
                                                             g42474221
                                                             (let ((g42474222
                                                                    (call
                                                                     vector-set!
                                                                     tmp.9
                                                                     7
                                                                     8)))
                                                               (if (call
                                                                    error?
                                                                    g42474222)
                                                                 g42474222
                                                                 tmp.9)))))))))))))))))))))
                        (if (call error? g42474214)
                          g42474214
                          (let ((g42474223
                                 (call
                                  vector-set!
                                  tmp.8
                                  3
                                  (call
                                   (let ((tmp.10 (call make-vector 8)))
                                     (let ((g42474224
                                            (call vector-set! tmp.10 0 0)))
                                       (if (call error? g42474224)
                                         g42474224
                                         (let ((g42474225
                                                (call vector-set! tmp.10 1 1)))
                                           (if (call error? g42474225)
                                             g42474225
                                             (let ((g42474226
                                                    (call
                                                     vector-set!
                                                     tmp.10
                                                     2
                                                     2)))
                                               (if (call error? g42474226)
                                                 g42474226
                                                 (let ((g42474227
                                                        (call
                                                         vector-set!
                                                         tmp.10
                                                         3
                                                         3)))
                                                   (if (call error? g42474227)
                                                     g42474227
                                                     (let ((g42474228
                                                            (call
                                                             vector-set!
                                                             tmp.10
                                                             4
                                                             4)))
                                                       (if (call
                                                            error?
                                                            g42474228)
                                                         g42474228
                                                         (let ((g42474229
                                                                (call
                                                                 vector-set!
                                                                 tmp.10
                                                                 5
                                                                 5)))
                                                           (if (call
                                                                error?
                                                                g42474229)
                                                             g42474229
                                                             (let ((g42474230
                                                                    (call
                                                                     vector-set!
                                                                     tmp.10
                                                                     6
                                                                     6)))
                                                               (if (call
                                                                    error?
                                                                    g42474230)
                                                                 g42474230
                                                                 (let ((g42474231
                                                                        (call
                                                                         vector-set!
                                                                         tmp.10
                                                                         7
                                                                         7)))
                                                                   (if (call
                                                                        error?
                                                                        g42474231)
                                                                     g42474231
                                                                     tmp.10)))))))))))))))))))))
                            (if (call error? g42474223)
                              g42474223
                              (let ((g42474232
                                     (call vector-set! tmp.8 4 (call #f))))
                                (if (call error? g42474232)
                                  g42474232
                                  (let ((g42474233
                                         (call
                                          vector-set!
                                          tmp.8
                                          5
                                          (call
                                           (call
                                            cons
                                            232
                                            (call cons 259 empty))))))
                                    (if (call error? g42474233)
                                      g42474233
                                      (let ((g42474234
                                             (call
                                              vector-set!
                                              tmp.8
                                              6
                                              (call #f))))
                                        (if (call error? g42474234)
                                          g42474234
                                          (let ((g42474235
                                                 (call
                                                  vector-set!
                                                  tmp.8
                                                  7
                                                  (call (void)))))
                                            (if (call error? g42474235)
                                              g42474235
                                              tmp.8)))))))))))))))))))
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
       (let ((boolean0 #f)
             (empty1 empty)
             (pair2 (call cons 41 (call cons 412 empty))))
         165)
       (let ((vector0
              (let ((tmp.7 (call make-vector 8)))
                (let ((g42478053 (call vector-set! tmp.7 0 1)))
                  (if (call error? g42478053)
                    g42478053
                    (let ((g42478054 (call vector-set! tmp.7 1 2)))
                      (if (call error? g42478054)
                        g42478054
                        (let ((g42478055 (call vector-set! tmp.7 2 3)))
                          (if (call error? g42478055)
                            g42478055
                            (let ((g42478056 (call vector-set! tmp.7 3 4)))
                              (if (call error? g42478056)
                                g42478056
                                (let ((g42478057 (call vector-set! tmp.7 4 5)))
                                  (if (call error? g42478057)
                                    g42478057
                                    (let ((g42478058
                                           (call vector-set! tmp.7 5 6)))
                                      (if (call error? g42478058)
                                        g42478058
                                        (let ((g42478059
                                               (call vector-set! tmp.7 6 7)))
                                          (if (call error? g42478059)
                                            g42478059
                                            (let ((g42478060
                                                   (call
                                                    vector-set!
                                                    tmp.7
                                                    7
                                                    8)))
                                              (if (call error? g42478060)
                                                g42478060
                                                tmp.7))))))))))))))))))
             (fixnum1 112))
         110)))))
(check-by-interp
 '(module
    (define fun/boolean8604 (lambda () (call fun/boolean8605 #f)))
    (define fun/ascii-char8607 (lambda (oprand0 oprand1) #\J))
    (define fun/boolean8605 (lambda (oprand0) oprand0))
    (define fun/ascii-char8606 (lambda (oprand0 oprand1) #\d))
    (if (call fun/boolean8604)
      (let ((empty0 empty)) #\g)
      (let ((tmp.7 #\R))
        (if tmp.7
          tmp.7
          (let ((tmp.8 (call fun/ascii-char8606 (void) #t)))
            (if tmp.8
              tmp.8
              (let ((tmp.9
                     (call
                      fun/ascii-char8607
                      (call cons 124 (call cons 438 empty))
                      (lambda () 729))))
                (if tmp.9
                  tmp.9
                  (let ((error0 (error 165)) (error1 (error 92))) #\n))))))))))
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
    (define fun/pair8619 (lambda () (call cons 87 (call cons 327 empty))))
    (define fun/boolean8617 (lambda (oprand0 oprand1) (call fun/boolean8618)))
    (define fun/boolean8618 (lambda () #f))
    (define fun/any8616 (lambda (oprand0) #f))
    (let ((tmp.7 (call fun/boolean8615 (let () #t) (if #f #f #t))))
      (if tmp.7
        tmp.7
        (let ((tmp.8 (call void? (call fun/any8616 (lambda () 764)))))
          (if tmp.8
            tmp.8
            (let ((tmp.9
                   (call
                    fun/boolean8617
                    (call fun/pair8619)
                    (if #f (error 130) (error 231)))))
              (if tmp.9 tmp.9 (call fun/boolean8620)))))))))
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
     (if (let ((tmp.7 (if #f (error 187) (error 49))))
           (if tmp.7
             tmp.7
             (let ((tmp.8
                    (let ((boolean0 #f)
                          (ascii-char1 #\K)
                          (procedure2 (lambda () 176)))
                      (error 222))))
               (if tmp.8
                 tmp.8
                 (let ((tmp.9 (let () (error 137))))
                   (if tmp.9
                     tmp.9
                     (let ((tmp.10 (let () (error 215))))
                       (if tmp.10
                         tmp.10
                         (let ((tmp.11
                                (let ((vector0
                                       (let ((tmp.12 (call make-vector 8)))
                                         (let ((g42493326
                                                (call vector-set! tmp.12 0 0)))
                                           (if (call error? g42493326)
                                             g42493326
                                             (let ((g42493327
                                                    (call
                                                     vector-set!
                                                     tmp.12
                                                     1
                                                     1)))
                                               (if (call error? g42493327)
                                                 g42493327
                                                 (let ((g42493328
                                                        (call
                                                         vector-set!
                                                         tmp.12
                                                         2
                                                         2)))
                                                   (if (call error? g42493328)
                                                     g42493328
                                                     (let ((g42493329
                                                            (call
                                                             vector-set!
                                                             tmp.12
                                                             3
                                                             3)))
                                                       (if (call
                                                            error?
                                                            g42493329)
                                                         g42493329
                                                         (let ((g42493330
                                                                (call
                                                                 vector-set!
                                                                 tmp.12
                                                                 4
                                                                 4)))
                                                           (if (call
                                                                error?
                                                                g42493330)
                                                             g42493330
                                                             (let ((g42493331
                                                                    (call
                                                                     vector-set!
                                                                     tmp.12
                                                                     5
                                                                     5)))
                                                               (if (call
                                                                    error?
                                                                    g42493331)
                                                                 g42493331
                                                                 (let ((g42493332
                                                                        (call
                                                                         vector-set!
                                                                         tmp.12
                                                                         6
                                                                         6)))
                                                                   (if (call
                                                                        error?
                                                                        g42493332)
                                                                     g42493332
                                                                     (let ((g42493333
                                                                            (call
                                                                             vector-set!
                                                                             tmp.12
                                                                             7
                                                                             7)))
                                                                       (if (call
                                                                            error?
                                                                            g42493333)
                                                                         g42493333
                                                                         tmp.12))))))))))))))))))
                                      (error1 (error 145)))
                                  (error 187))))
                           (if tmp.11
                             tmp.11
                             (let ((tmp.13 (if #t (error 104) (error 57))))
                               (if tmp.13
                                 tmp.13
                                 (let () (error 110))))))))))))))
       (if (let ((error0 (error 197)) (error1 (error 17))) (error 143))
         (if (if #t (error 11) (error 74))
           (let ((boolean0 #f) (boolean1 #f) (fixnum2 69)) (error 137))
           #f)
         #f)
       #f)
     (if (let ((tmp.14
                (call
                 fun/fixnum8625
                 (error 175)
                 (let ((tmp.15 (call make-vector 8)))
                   (let ((g42493334 (call vector-set! tmp.15 0 1)))
                     (if (call error? g42493334)
                       g42493334
                       (let ((g42493335 (call vector-set! tmp.15 1 2)))
                         (if (call error? g42493335)
                           g42493335
                           (let ((g42493336 (call vector-set! tmp.15 2 3)))
                             (if (call error? g42493336)
                               g42493336
                               (let ((g42493337 (call vector-set! tmp.15 3 4)))
                                 (if (call error? g42493337)
                                   g42493337
                                   (let ((g42493338
                                          (call vector-set! tmp.15 4 5)))
                                     (if (call error? g42493338)
                                       g42493338
                                       (let ((g42493339
                                              (call vector-set! tmp.15 5 6)))
                                         (if (call error? g42493339)
                                           g42493339
                                           (let ((g42493340
                                                  (call
                                                   vector-set!
                                                   tmp.15
                                                   6
                                                   7)))
                                             (if (call error? g42493340)
                                               g42493340
                                               (let ((g42493341
                                                      (call
                                                       vector-set!
                                                       tmp.15
                                                       7
                                                       8)))
                                                 (if (call error? g42493341)
                                                   g42493341
                                                   tmp.15))))))))))))))))))))
           (if tmp.14
             tmp.14
             (let ((tmp.16 (call fun/fixnum8626)))
               (if tmp.16
                 tmp.16
                 (let ((tmp.17 (call fun/fixnum8627)))
                   (if tmp.17
                     tmp.17
                     (let ((tmp.18 (if #f 197 59)))
                       (if tmp.18
                         tmp.18
                         (let ((empty0 empty)
                               (error1 (error 52))
                               (boolean2 #f))
                           82)))))))))
       (if (if 32
             (if (call
                  fun/fixnum8628
                  (let ((tmp.19 (call make-vector 8)))
                    (let ((g42493342 (call vector-set! tmp.19 0 0)))
                      (if (call error? g42493342)
                        g42493342
                        (let ((g42493343 (call vector-set! tmp.19 1 1)))
                          (if (call error? g42493343)
                            g42493343
                            (let ((g42493344 (call vector-set! tmp.19 2 2)))
                              (if (call error? g42493344)
                                g42493344
                                (let ((g42493345
                                       (call vector-set! tmp.19 3 3)))
                                  (if (call error? g42493345)
                                    g42493345
                                    (let ((g42493346
                                           (call vector-set! tmp.19 4 4)))
                                      (if (call error? g42493346)
                                        g42493346
                                        (let ((g42493347
                                               (call vector-set! tmp.19 5 5)))
                                          (if (call error? g42493347)
                                            g42493347
                                            (let ((g42493348
                                                   (call
                                                    vector-set!
                                                    tmp.19
                                                    6
                                                    6)))
                                              (if (call error? g42493348)
                                                g42493348
                                                (let ((g42493349
                                                       (call
                                                        vector-set!
                                                        tmp.19
                                                        7
                                                        7)))
                                                  (if (call error? g42493349)
                                                    g42493349
                                                    tmp.19)))))))))))))))))
                  empty)
               (if (let ((pair0 (call cons 182 (call cons 324 empty)))
                         (error1 (error 85)))
                     6)
                 (if 113
                   (if (let ((boolean0 #f) (error1 (error 212))) 58)
                     (if #f 124 111)
                     #f)
                   #f)
                 #f)
               #f)
             #f)
         (if (if #t 60 147)
           (if (let ((g42493350 (if #f 74 149)))
                 (if (call error? g42493350)
                   g42493350
                   (let ((g42493351
                          (if 18 (if 18 (if 233 (if 91 193 #f) #f) #f) #f)))
                     (if (call error? g42493351)
                       g42493351
                       (let ((g42493352
                              (let ((tmp.20 235)) (if tmp.20 tmp.20 137))))
                         (if (call error? g42493352)
                           g42493352
                           (let ((g42493353 (if #t 238 229)))
                             (if (call error? g42493353)
                               g42493353
                               (let ((vector0
                                      (let ((tmp.21 (call make-vector 8)))
                                        (let ((g42493354
                                               (call vector-set! tmp.21 0 1)))
                                          (if (call error? g42493354)
                                            g42493354
                                            (let ((g42493355
                                                   (call
                                                    vector-set!
                                                    tmp.21
                                                    1
                                                    2)))
                                              (if (call error? g42493355)
                                                g42493355
                                                (let ((g42493356
                                                       (call
                                                        vector-set!
                                                        tmp.21
                                                        2
                                                        3)))
                                                  (if (call error? g42493356)
                                                    g42493356
                                                    (let ((g42493357
                                                           (call
                                                            vector-set!
                                                            tmp.21
                                                            3
                                                            4)))
                                                      (if (call
                                                           error?
                                                           g42493357)
                                                        g42493357
                                                        (let ((g42493358
                                                               (call
                                                                vector-set!
                                                                tmp.21
                                                                4
                                                                5)))
                                                          (if (call
                                                               error?
                                                               g42493358)
                                                            g42493358
                                                            (let ((g42493359
                                                                   (call
                                                                    vector-set!
                                                                    tmp.21
                                                                    5
                                                                    6)))
                                                              (if (call
                                                                   error?
                                                                   g42493359)
                                                                g42493359
                                                                (let ((g42493360
                                                                       (call
                                                                        vector-set!
                                                                        tmp.21
                                                                        6
                                                                        7)))
                                                                  (if (call
                                                                       error?
                                                                       g42493360)
                                                                    g42493360
                                                                    (let ((g42493361
                                                                           (call
                                                                            vector-set!
                                                                            tmp.21
                                                                            7
                                                                            8)))
                                                                      (if (call
                                                                           error?
                                                                           g42493361)
                                                                        g42493361
                                                                        tmp.21))))))))))))))))))
                                     (empty1 empty)
                                     (vector2
                                      (let ((tmp.22 (call make-vector 8)))
                                        (let ((g42493362
                                               (call vector-set! tmp.22 0 0)))
                                          (if (call error? g42493362)
                                            g42493362
                                            (let ((g42493363
                                                   (call
                                                    vector-set!
                                                    tmp.22
                                                    1
                                                    1)))
                                              (if (call error? g42493363)
                                                g42493363
                                                (let ((g42493364
                                                       (call
                                                        vector-set!
                                                        tmp.22
                                                        2
                                                        2)))
                                                  (if (call error? g42493364)
                                                    g42493364
                                                    (let ((g42493365
                                                           (call
                                                            vector-set!
                                                            tmp.22
                                                            3
                                                            3)))
                                                      (if (call
                                                           error?
                                                           g42493365)
                                                        g42493365
                                                        (let ((g42493366
                                                               (call
                                                                vector-set!
                                                                tmp.22
                                                                4
                                                                4)))
                                                          (if (call
                                                               error?
                                                               g42493366)
                                                            g42493366
                                                            (let ((g42493367
                                                                   (call
                                                                    vector-set!
                                                                    tmp.22
                                                                    5
                                                                    5)))
                                                              (if (call
                                                                   error?
                                                                   g42493367)
                                                                g42493367
                                                                (let ((g42493368
                                                                       (call
                                                                        vector-set!
                                                                        tmp.22
                                                                        6
                                                                        6)))
                                                                  (if (call
                                                                       error?
                                                                       g42493368)
                                                                    g42493368
                                                                    (let ((g42493369
                                                                           (call
                                                                            vector-set!
                                                                            tmp.22
                                                                            7
                                                                            7)))
                                                                      (if (call
                                                                           error?
                                                                           g42493369)
                                                                        g42493369
                                                                        tmp.22)))))))))))))))))))
                                 217)))))))))
             (if (call
                  -
                  (let ((void0 (void)) (pair1 (call cons #\O #f))) 76)
                  (let ((empty0 empty)
                        (boolean1 #t)
                        (vector2
                         (let ((tmp.23 (call make-vector 8)))
                           (let ((g42493370 (call vector-set! tmp.23 0 1)))
                             (if (call error? g42493370)
                               g42493370
                               (let ((g42493371 (call vector-set! tmp.23 1 2)))
                                 (if (call error? g42493371)
                                   g42493371
                                   (let ((g42493372
                                          (call vector-set! tmp.23 2 3)))
                                     (if (call error? g42493372)
                                       g42493372
                                       (let ((g42493373
                                              (call vector-set! tmp.23 3 4)))
                                         (if (call error? g42493373)
                                           g42493373
                                           (let ((g42493374
                                                  (call
                                                   vector-set!
                                                   tmp.23
                                                   4
                                                   5)))
                                             (if (call error? g42493374)
                                               g42493374
                                               (let ((g42493375
                                                      (call
                                                       vector-set!
                                                       tmp.23
                                                       5
                                                       6)))
                                                 (if (call error? g42493375)
                                                   g42493375
                                                   (let ((g42493376
                                                          (call
                                                           vector-set!
                                                           tmp.23
                                                           6
                                                           7)))
                                                     (if (call
                                                          error?
                                                          g42493376)
                                                       g42493376
                                                       (let ((g42493377
                                                              (call
                                                               vector-set!
                                                               tmp.23
                                                               7
                                                               8)))
                                                         (if (call
                                                              error?
                                                              g42493377)
                                                           g42493377
                                                           tmp.23)))))))))))))))))))
                    153))
               (let ((tmp.24
                      (if 2
                        (if 39
                          (if 133 (if 67 (if 231 (if 24 90 #f) #f) #f) #f)
                          #f)
                        #f)))
                 (if tmp.24
                   tmp.24
                   (let ((tmp.25 (let () 98)))
                     (if tmp.25
                       tmp.25
                       (let ((tmp.26
                              (let ((tmp.27 35))
                                (if tmp.27
                                  tmp.27
                                  (let ((tmp.28 137))
                                    (if tmp.28
                                      tmp.28
                                      (let ((tmp.29 221))
                                        (if tmp.29
                                          tmp.29
                                          (let ((tmp.30 20))
                                            (if tmp.30
                                              tmp.30
                                              (let ((tmp.31 185))
                                                (if tmp.31
                                                  tmp.31
                                                  134))))))))))))
                         (if tmp.26
                           tmp.26
                           (let ((tmp.32
                                  (let ((tmp.33 208))
                                    (if tmp.33
                                      tmp.33
                                      (let ((tmp.34 29))
                                        (if tmp.34
                                          tmp.34
                                          (let ((tmp.35 116))
                                            (if tmp.35 tmp.35 147))))))))
                             (if tmp.32
                               tmp.32
                               (let ((tmp.36 (if #f 16 82)))
                                 (if tmp.36 tmp.36 (if #t 165 6)))))))))))
               #f)
             #f)
           #f)
         #f)
       #f))))
(check-by-interp
 '(module
    (define fun/boolean8631 (lambda (oprand0) #t))
    (define fun/pair8635
      (lambda (oprand0) (call cons 16 (call cons 418 empty))))
    (define fun/fixnum8634 (lambda () 33))
    (define fun/fixnum8636 (lambda () (if #f 72 52)))
    (define fun/boolean8632 (lambda () #t))
    (define fun/fixnum8633 (lambda (oprand0) (call fun/fixnum8634)))
    (if (let ((tmp.7 (call fun/boolean8631 #\f)))
          (if tmp.7
            tmp.7
            (let ((tmp.8 (call > 237 82)))
              (if tmp.8
                tmp.8
                (let ((tmp.9 (let () #t)))
                  (if tmp.9
                    tmp.9
                    (let ((tmp.10 (call <= 191 13)))
                      (if tmp.10 tmp.10 (call fun/boolean8632)))))))))
      (call fun/fixnum8633 (call fun/pair8635 #\F))
      (call fun/fixnum8636))))
(check-by-interp
 '(module
    (define fun/void8639 (lambda (oprand0) (if #t (void) (void))))
    (define fun/void8640 (lambda (oprand0 oprand1) (void)))
    (if (if #f #t #t)
      (call fun/void8639 (if #t #t #t))
      (let ((tmp.7 (call fun/void8640 #t #\I)))
        (if tmp.7
          tmp.7
          (let ((tmp.8 (if #f (void) (void))))
            (if tmp.8
              tmp.8
              (let ((tmp.9 (let () (void))))
                (if tmp.9
                  tmp.9
                  (let ((tmp.10 (if #t (void) (void))))
                    (if tmp.10
                      tmp.10
                      (let ((tmp.11
                             (let ((tmp.12 (void)))
                               (if tmp.12
                                 tmp.12
                                 (let ((tmp.13 (void)))
                                   (if tmp.13
                                     tmp.13
                                     (let ((tmp.14 (void)))
                                       (if tmp.14
                                         tmp.14
                                         (let ((tmp.15 (void)))
                                           (if tmp.15 tmp.15 (void)))))))))))
                        (if tmp.11
                          tmp.11
                          (let ((tmp.16 (void)))
                            (if tmp.16 tmp.16 (void))))))))))))))))
(check-by-interp
 '(module
    (define fun/empty8643 (lambda (oprand0 oprand1) oprand0))
    (call
     fun/empty8643
     (if #t empty empty)
     (call ascii-char? (let ((vector0 (call make-vector 8))) 146)))))
(check-by-interp
 '(module
    (define fun/fixnum8646 (lambda (oprand0) 187))
    (define fun/fixnum8647 (lambda () 188))
    (define fun/fixnum8648 (lambda (oprand0 oprand1) oprand1))
    (define fun/fixnum8649 (lambda (oprand0 oprand1) 114))
    (call
     >
     (let ((g42516139 (call fun/fixnum8646 #\q)))
       (if (call error? g42516139) g42516139 (if #f 81 95)))
     (if (call
          +
          (if 251
            (if 7 (if 101 (if 18 (if 141 (if 162 193 #f) #f) #f) #f) #f)
            #f)
          (if 104 (if 226 (if 68 (if 97 (if 159 210 #f) #f) #f) #f) #f))
       (if (let ((procedure0 (lambda (oprand0 oprand1) oprand0))) 198)
         (if (let ((tmp.7 (let () 226)))
               (if tmp.7
                 tmp.7
                 (let ((tmp.8 (call - 94 208)))
                   (if tmp.8
                     tmp.8
                     (let ((tmp.9 (if #f 33 168)))
                       (if tmp.9
                         tmp.9
                         (let ((tmp.10 (call fun/fixnum8647)))
                           (if tmp.10
                             tmp.10
                             (let ((tmp.11
                                    (let ((boolean0 #t) (ascii-char1 #\Q))
                                      98)))
                               (if tmp.11
                                 tmp.11
                                 (let ((tmp.12
                                        (let ((boolean0 #t)
                                              (boolean1 #f)
                                              (vector2
                                               (let ((tmp.13
                                                      (call make-vector 8)))
                                                 (let ((g42516140
                                                        (call
                                                         vector-set!
                                                         tmp.13
                                                         0
                                                         0)))
                                                   (if (call error? g42516140)
                                                     g42516140
                                                     (let ((g42516141
                                                            (call
                                                             vector-set!
                                                             tmp.13
                                                             1
                                                             1)))
                                                       (if (call
                                                            error?
                                                            g42516141)
                                                         g42516141
                                                         (let ((g42516142
                                                                (call
                                                                 vector-set!
                                                                 tmp.13
                                                                 2
                                                                 2)))
                                                           (if (call
                                                                error?
                                                                g42516142)
                                                             g42516142
                                                             (let ((g42516143
                                                                    (call
                                                                     vector-set!
                                                                     tmp.13
                                                                     3
                                                                     3)))
                                                               (if (call
                                                                    error?
                                                                    g42516143)
                                                                 g42516143
                                                                 (let ((g42516144
                                                                        (call
                                                                         vector-set!
                                                                         tmp.13
                                                                         4
                                                                         4)))
                                                                   (if (call
                                                                        error?
                                                                        g42516144)
                                                                     g42516144
                                                                     (let ((g42516145
                                                                            (call
                                                                             vector-set!
                                                                             tmp.13
                                                                             5
                                                                             5)))
                                                                       (if (call
                                                                            error?
                                                                            g42516145)
                                                                         g42516145
                                                                         (let ((g42516146
                                                                                (call
                                                                                 vector-set!
                                                                                 tmp.13
                                                                                 6
                                                                                 6)))
                                                                           (if (call
                                                                                error?
                                                                                g42516146)
                                                                             g42516146
                                                                             (let ((g42516147
                                                                                    (call
                                                                                     vector-set!
                                                                                     tmp.13
                                                                                     7
                                                                                     7)))
                                                                               (if (call
                                                                                    error?
                                                                                    g42516147)
                                                                                 g42516147
                                                                                 tmp.13)))))))))))))))))))
                                          58)))
                                   (if tmp.12
                                     tmp.12
                                     (let ((void0 (void))
                                           (error1 (error 253))
                                           (pair2
                                            (call
                                             cons
                                             103
                                             (call cons 494 empty))))
                                       245)))))))))))))
           (if (let ((boolean0 #t)
                     (pair1 (call cons 131 (call cons 435 empty)))
                     (procedure2 (lambda () 174)))
                 130)
             (if (if (if #t 35 220)
                   (if (if #t 36 135)
                     (if (call
                          fun/fixnum8648
                          (call cons 124 (call cons 432 empty))
                          82)
                       (if (let ((tmp.14 152))
                             (if tmp.14
                               tmp.14
                               (let ((tmp.15 68))
                                 (if tmp.15
                                   tmp.15
                                   (let ((tmp.16 140))
                                     (if tmp.16 tmp.16 42))))))
                         (if (call fun/fixnum8649 empty #\j) (if #f 143 40) #f)
                         #f)
                       #f)
                     #f)
                   #f)
               (if #t 8 110)
               #f)
             #f)
           #f)
         #f)
       #f))))
(check-by-interp
 '(module
    (define fun/void8652 (lambda (oprand0 oprand1) (void)))
    (define fun/void8656 (lambda (oprand0 oprand1) (if #t (void) (void))))
    (define fun/void8655 (lambda () (void)))
    (define fun/void8654 (lambda (oprand0) (let ((empty0 empty)) (void))))
    (define fun/void8653 (lambda (oprand0 oprand1) (let () (void))))
    (let ((g42519968
           (if (let ((boolean0 #f)
                     (pair1 (call cons 247 (call cons 312 empty)))
                     (error2 (error 55)))
                 #f)
             (call fun/void8652 #\O empty)
             (let ((g42519969 (void)))
               (if (call error? g42519969) g42519969 (void))))))
      (if (call error? g42519968)
        g42519968
        (let ((g42519970
               (if (let ((g42519971 #t))
                     (if (call error? g42519971) g42519971 #f))
                 (if #t (void) (void))
                 (let ((g42519972 (void)))
                   (if (call error? g42519972)
                     g42519972
                     (let ((g42519973 (void)))
                       (if (call error? g42519973)
                         g42519973
                         (let ((g42519974 (void)))
                           (if (call error? g42519974)
                             g42519974
                             (let ((g42519975 (void)))
                               (if (call error? g42519975)
                                 g42519975
                                 (let ((g42519976 (void)))
                                   (if (call error? g42519976)
                                     g42519976
                                     (void))))))))))))))
          (if (call error? g42519970)
            g42519970
            (let ((g42519977
                   (call
                    fun/void8653
                    (if #t
                      (call cons 38 (call cons 339 empty))
                      (call cons 84 (call cons 401 empty)))
                    (let ((error0 (error 143)) (error1 (error 119)))
                      (error 96)))))
              (if (call error? g42519977)
                g42519977
                (let ((g42519978
                       (let ((g42519979
                              (if (let ((ascii-char0 #\M)
                                        (vector1
                                         (let ((tmp.7 (call make-vector 8)))
                                           (let ((g42519980
                                                  (call
                                                   vector-set!
                                                   tmp.7
                                                   0
                                                   0)))
                                             (if (call error? g42519980)
                                               g42519980
                                               (let ((g42519981
                                                      (call
                                                       vector-set!
                                                       tmp.7
                                                       1
                                                       1)))
                                                 (if (call error? g42519981)
                                                   g42519981
                                                   (let ((g42519982
                                                          (call
                                                           vector-set!
                                                           tmp.7
                                                           2
                                                           2)))
                                                     (if (call
                                                          error?
                                                          g42519982)
                                                       g42519982
                                                       (let ((g42519983
                                                              (call
                                                               vector-set!
                                                               tmp.7
                                                               3
                                                               3)))
                                                         (if (call
                                                              error?
                                                              g42519983)
                                                           g42519983
                                                           (let ((g42519984
                                                                  (call
                                                                   vector-set!
                                                                   tmp.7
                                                                   4
                                                                   4)))
                                                             (if (call
                                                                  error?
                                                                  g42519984)
                                                               g42519984
                                                               (let ((g42519985
                                                                      (call
                                                                       vector-set!
                                                                       tmp.7
                                                                       5
                                                                       5)))
                                                                 (if (call
                                                                      error?
                                                                      g42519985)
                                                                   g42519985
                                                                   (let ((g42519986
                                                                          (call
                                                                           vector-set!
                                                                           tmp.7
                                                                           6
                                                                           6)))
                                                                     (if (call
                                                                          error?
                                                                          g42519986)
                                                                       g42519986
                                                                       (let ((g42519987
                                                                              (call
                                                                               vector-set!
                                                                               tmp.7
                                                                               7
                                                                               7)))
                                                                         (if (call
                                                                              error?
                                                                              g42519987)
                                                                           g42519987
                                                                           tmp.7)))))))))))))))))))
                                    (void))
                                (let ((g42519988 (void)))
                                  (if (call error? g42519988)
                                    g42519988
                                    (let ((g42519989 (void)))
                                      (if (call error? g42519989)
                                        g42519989
                                        (void)))))
                                #f)))
                         (if (call error? g42519979)
                           g42519979
                           (let ((g42519990
                                  (let ((vector0
                                         (let ((tmp.8 (call make-vector 8)))
                                           (let ((g42519991
                                                  (call
                                                   vector-set!
                                                   tmp.8
                                                   0
                                                   0)))
                                             (if (call error? g42519991)
                                               g42519991
                                               (let ((g42519992
                                                      (call
                                                       vector-set!
                                                       tmp.8
                                                       1
                                                       1)))
                                                 (if (call error? g42519992)
                                                   g42519992
                                                   (let ((g42519993
                                                          (call
                                                           vector-set!
                                                           tmp.8
                                                           2
                                                           2)))
                                                     (if (call
                                                          error?
                                                          g42519993)
                                                       g42519993
                                                       (let ((g42519994
                                                              (call
                                                               vector-set!
                                                               tmp.8
                                                               3
                                                               3)))
                                                         (if (call
                                                              error?
                                                              g42519994)
                                                           g42519994
                                                           (let ((g42519995
                                                                  (call
                                                                   vector-set!
                                                                   tmp.8
                                                                   4
                                                                   4)))
                                                             (if (call
                                                                  error?
                                                                  g42519995)
                                                               g42519995
                                                               (let ((g42519996
                                                                      (call
                                                                       vector-set!
                                                                       tmp.8
                                                                       5
                                                                       5)))
                                                                 (if (call
                                                                      error?
                                                                      g42519996)
                                                                   g42519996
                                                                   (let ((g42519997
                                                                          (call
                                                                           vector-set!
                                                                           tmp.8
                                                                           6
                                                                           6)))
                                                                     (if (call
                                                                          error?
                                                                          g42519997)
                                                                       g42519997
                                                                       (let ((g42519998
                                                                              (call
                                                                               vector-set!
                                                                               tmp.8
                                                                               7
                                                                               7)))
                                                                         (if (call
                                                                              error?
                                                                              g42519998)
                                                                           g42519998
                                                                           tmp.8))))))))))))))))))
                                        (error1 (error 186)))
                                    (void))))
                             (if (call error? g42519990)
                               g42519990
                               (let ((g42519999
                                      (let ((procedure0 (lambda () 121)))
                                        (void))))
                                 (if (call error? g42519999)
                                   g42519999
                                   (let ((g42520000
                                          (call fun/void8654 (if #t #\a #\r))))
                                     (if (call error? g42520000)
                                       g42520000
                                       (let ((g42520001 (if #t (void) (void))))
                                         (if (call error? g42520001)
                                           g42520001
                                           (let ((g42520002
                                                  (if #f (void) (void))))
                                             (if (call error? g42520002)
                                               g42520002
                                               (if #f
                                                 (void)
                                                 (void))))))))))))))))
                  (if (call error? g42519978)
                    g42519978
                    (let ((g42520003
                           (let ((void0 (call fun/void8655)))
                             (let ((pair0
                                    (call cons 100 (call cons 256 empty)))
                                   (pair1 (call cons 1 (call cons 424 empty))))
                               (void)))))
                      (if (call error? g42520003)
                        g42520003
                        (call
                         fun/void8656
                         (let ((ascii-char0 #\B)
                               (pair1 (call cons 147 (call cons 339 empty))))
                           #\N)
                         (let ((vector0
                                (let ((tmp.9 (call make-vector 8)))
                                  (let ((g42520004
                                         (call vector-set! tmp.9 0 1)))
                                    (if (call error? g42520004)
                                      g42520004
                                      (let ((g42520005
                                             (call vector-set! tmp.9 1 2)))
                                        (if (call error? g42520005)
                                          g42520005
                                          (let ((g42520006
                                                 (call vector-set! tmp.9 2 3)))
                                            (if (call error? g42520006)
                                              g42520006
                                              (let ((g42520007
                                                     (call
                                                      vector-set!
                                                      tmp.9
                                                      3
                                                      4)))
                                                (if (call error? g42520007)
                                                  g42520007
                                                  (let ((g42520008
                                                         (call
                                                          vector-set!
                                                          tmp.9
                                                          4
                                                          5)))
                                                    (if (call error? g42520008)
                                                      g42520008
                                                      (let ((g42520009
                                                             (call
                                                              vector-set!
                                                              tmp.9
                                                              5
                                                              6)))
                                                        (if (call
                                                             error?
                                                             g42520009)
                                                          g42520009
                                                          (let ((g42520010
                                                                 (call
                                                                  vector-set!
                                                                  tmp.9
                                                                  6
                                                                  7)))
                                                            (if (call
                                                                 error?
                                                                 g42520010)
                                                              g42520010
                                                              (let ((g42520011
                                                                     (call
                                                                      vector-set!
                                                                      tmp.9
                                                                      7
                                                                      8)))
                                                                (if (call
                                                                     error?
                                                                     g42520011)
                                                                  g42520011
                                                                  tmp.9))))))))))))))))))
                               (procedure1 (lambda () 228)))
                           (error 218)))))))))))))))
(check-by-interp
 '(module
    (define fun/void8659 (lambda (oprand0) (void)))
    (let ((void0 (let ((ascii-char0 #\s)) (void))))
      (if (if #f (void) (void))
        (if (let ((g42523829 (void)))
              (if (call error? g42523829) g42523829 (void)))
          (call fun/void8659 #f)
          #f)
        #f))))
(check-by-interp
 '(module
    (define fun/error8662
      (lambda () (let ((ascii-char0 #\N) (ascii-char1 #\R)) (error 192))))
    (if (if (let ((void0 (void)) (boolean1 #f) (vector2 (call make-vector 8)))
              #f)
          (if #f (error 241) (error 134))
          (let ((fixnum0 190) (error1 (error 76))) (error 56)))
      (if (let ((empty0
                 (let ((g42527647 empty))
                   (if (call error? g42527647)
                     g42527647
                     (let ((g42527648 empty))
                       (if (call error? g42527648)
                         g42527648
                         (let ((g42527649 empty))
                           (if (call error? g42527649) g42527649 empty)))))))
                (pair1
                 (call
                  cons
                  134
                  (call
                   cons
                   (call cons 154 (call cons 498 empty))
                   (call
                    cons
                    95
                    (call
                     cons
                     empty
                     (call
                      cons
                      #\M
                      (call
                       cons
                       (call cons 118 (call cons 510 empty))
                       (call cons #f (call cons #\] empty))))))))))
            (if #t (error 132) (error 79)))
        (call fun/error8662)
        #f)
      #f)))
(check-by-interp
 '(module
    (define fun/empty8665 (lambda (oprand0) (let ((void0 (void))) empty)))
    (if (let () #f)
      (call
       fun/empty8665
       (let ((vector0
              (let ((tmp.7 (call make-vector 8)))
                (let ((g42531467 (call vector-set! tmp.7 0 0)))
                  (if (call error? g42531467)
                    g42531467
                    (let ((g42531468 (call vector-set! tmp.7 1 1)))
                      (if (call error? g42531468)
                        g42531468
                        (let ((g42531469 (call vector-set! tmp.7 2 2)))
                          (if (call error? g42531469)
                            g42531469
                            (let ((g42531470 (call vector-set! tmp.7 3 3)))
                              (if (call error? g42531470)
                                g42531470
                                (let ((g42531471 (call vector-set! tmp.7 4 4)))
                                  (if (call error? g42531471)
                                    g42531471
                                    (let ((g42531472
                                           (call vector-set! tmp.7 5 5)))
                                      (if (call error? g42531472)
                                        g42531472
                                        (let ((g42531473
                                               (call vector-set! tmp.7 6 6)))
                                          (if (call error? g42531473)
                                            g42531473
                                            (let ((g42531474
                                                   (call
                                                    vector-set!
                                                    tmp.7
                                                    7
                                                    7)))
                                              (if (call error? g42531474)
                                                g42531474
                                                tmp.7))))))))))))))))))
             (empty1 empty))
         #\H))
      (let ((vector0
             (let ((tmp.8 (call make-vector 8)))
               (let ((g42531475 (call vector-set! tmp.8 0 1)))
                 (if (call error? g42531475)
                   g42531475
                   (let ((g42531476 (call vector-set! tmp.8 1 2)))
                     (if (call error? g42531476)
                       g42531476
                       (let ((g42531477 (call vector-set! tmp.8 2 3)))
                         (if (call error? g42531477)
                           g42531477
                           (let ((g42531478 (call vector-set! tmp.8 3 4)))
                             (if (call error? g42531478)
                               g42531478
                               (let ((g42531479 (call vector-set! tmp.8 4 5)))
                                 (if (call error? g42531479)
                                   g42531479
                                   (let ((g42531480
                                          (call vector-set! tmp.8 5 6)))
                                     (if (call error? g42531480)
                                       g42531480
                                       (let ((g42531481
                                              (call vector-set! tmp.8 6 7)))
                                         (if (call error? g42531481)
                                           g42531481
                                           (let ((g42531482
                                                  (call
                                                   vector-set!
                                                   tmp.8
                                                   7
                                                   8)))
                                             (if (call error? g42531482)
                                               g42531482
                                               tmp.8))))))))))))))))))
            (boolean1 #t))
        empty))))
(check-by-interp
 '(module
    (define fun/fixnum8668 (lambda () 84))
    (define fun/pair8669 (lambda () (call cons 33 (call cons 355 empty))))
    (define fun/fixnum8670 (lambda () 116))
    (let ((vector0
           (let ((tmp.7 (call make-vector 8)))
             (let ((g42535303
                    (call vector-set! tmp.7 0 (call (let () (error 47))))))
               (if (call error? g42535303)
                 g42535303
                 (let ((g42535304
                        (call vector-set! tmp.7 1 (call (error 83)))))
                   (if (call error? g42535304)
                     g42535304
                     (let ((g42535305
                            (call
                             vector-set!
                             tmp.7
                             2
                             (call
                              (if #t
                                (call cons 212 (call cons 273 empty))
                                (call cons 6 (call cons 506 empty)))))))
                       (if (call error? g42535305)
                         g42535305
                         (let ((g42535306
                                (call
                                 vector-set!
                                 tmp.7
                                 3
                                 (call
                                  (let ((g42535307 (call make-vector 8)))
                                    (if (call error? g42535307)
                                      g42535307
                                      (let ((g42535308
                                             (let ((tmp.8
                                                    (call make-vector 8)))
                                               (let ((g42535309
                                                      (call
                                                       vector-set!
                                                       tmp.8
                                                       0
                                                       0)))
                                                 (if (call error? g42535309)
                                                   g42535309
                                                   (let ((g42535310
                                                          (call
                                                           vector-set!
                                                           tmp.8
                                                           1
                                                           1)))
                                                     (if (call
                                                          error?
                                                          g42535310)
                                                       g42535310
                                                       (let ((g42535311
                                                              (call
                                                               vector-set!
                                                               tmp.8
                                                               2
                                                               2)))
                                                         (if (call
                                                              error?
                                                              g42535311)
                                                           g42535311
                                                           (let ((g42535312
                                                                  (call
                                                                   vector-set!
                                                                   tmp.8
                                                                   3
                                                                   3)))
                                                             (if (call
                                                                  error?
                                                                  g42535312)
                                                               g42535312
                                                               (let ((g42535313
                                                                      (call
                                                                       vector-set!
                                                                       tmp.8
                                                                       4
                                                                       4)))
                                                                 (if (call
                                                                      error?
                                                                      g42535313)
                                                                   g42535313
                                                                   (let ((g42535314
                                                                          (call
                                                                           vector-set!
                                                                           tmp.8
                                                                           5
                                                                           5)))
                                                                     (if (call
                                                                          error?
                                                                          g42535314)
                                                                       g42535314
                                                                       (let ((g42535315
                                                                              (call
                                                                               vector-set!
                                                                               tmp.8
                                                                               6
                                                                               6)))
                                                                         (if (call
                                                                              error?
                                                                              g42535315)
                                                                           g42535315
                                                                           (let ((g42535316
                                                                                  (call
                                                                                   vector-set!
                                                                                   tmp.8
                                                                                   7
                                                                                   7)))
                                                                             (if (call
                                                                                  error?
                                                                                  g42535316)
                                                                               g42535316
                                                                               tmp.8)))))))))))))))))))
                                        (if (call error? g42535308)
                                          g42535308
                                          (let ((tmp.9 (call make-vector 8)))
                                            (let ((g42535317
                                                   (call
                                                    vector-set!
                                                    tmp.9
                                                    0
                                                    0)))
                                              (if (call error? g42535317)
                                                g42535317
                                                (let ((g42535318
                                                       (call
                                                        vector-set!
                                                        tmp.9
                                                        1
                                                        1)))
                                                  (if (call error? g42535318)
                                                    g42535318
                                                    (let ((g42535319
                                                           (call
                                                            vector-set!
                                                            tmp.9
                                                            2
                                                            2)))
                                                      (if (call
                                                           error?
                                                           g42535319)
                                                        g42535319
                                                        (let ((g42535320
                                                               (call
                                                                vector-set!
                                                                tmp.9
                                                                3
                                                                3)))
                                                          (if (call
                                                               error?
                                                               g42535320)
                                                            g42535320
                                                            (let ((g42535321
                                                                   (call
                                                                    vector-set!
                                                                    tmp.9
                                                                    4
                                                                    4)))
                                                              (if (call
                                                                   error?
                                                                   g42535321)
                                                                g42535321
                                                                (let ((g42535322
                                                                       (call
                                                                        vector-set!
                                                                        tmp.9
                                                                        5
                                                                        5)))
                                                                  (if (call
                                                                       error?
                                                                       g42535322)
                                                                    g42535322
                                                                    (let ((g42535323
                                                                           (call
                                                                            vector-set!
                                                                            tmp.9
                                                                            6
                                                                            6)))
                                                                      (if (call
                                                                           error?
                                                                           g42535323)
                                                                        g42535323
                                                                        (let ((g42535324
                                                                               (call
                                                                                vector-set!
                                                                                tmp.9
                                                                                7
                                                                                7)))
                                                                          (if (call
                                                                               error?
                                                                               g42535324)
                                                                            g42535324
                                                                            tmp.9)))))))))))))))))))))))))
                           (if (call error? g42535306)
                             g42535306
                             (let ((g42535325
                                    (call
                                     vector-set!
                                     tmp.7
                                     4
                                     (call (call fun/fixnum8668)))))
                               (if (call error? g42535325)
                                 g42535325
                                 (let ((g42535326
                                        (call
                                         vector-set!
                                         tmp.7
                                         5
                                         (call (call fun/pair8669)))))
                                   (if (call error? g42535326)
                                     g42535326
                                     (let ((g42535327
                                            (call
                                             vector-set!
                                             tmp.7
                                             6
                                             (call (if #t empty empty)))))
                                       (if (call error? g42535327)
                                         g42535327
                                         (let ((g42535328
                                                (call
                                                 vector-set!
                                                 tmp.7
                                                 7
                                                 (call
                                                  (call fun/fixnum8670)))))
                                           (if (call error? g42535328)
                                             g42535328
                                             tmp.7))))))))))))))))))
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
      (if #f
        (let ((tmp.7 (call make-vector 8)))
          (let ((g42546779 (call vector-set! tmp.7 0 1)))
            (if (call error? g42546779)
              g42546779
              (let ((g42546780 (call vector-set! tmp.7 1 2)))
                (if (call error? g42546780)
                  g42546780
                  (let ((g42546781 (call vector-set! tmp.7 2 3)))
                    (if (call error? g42546781)
                      g42546781
                      (let ((g42546782 (call vector-set! tmp.7 3 4)))
                        (if (call error? g42546782)
                          g42546782
                          (let ((g42546783 (call vector-set! tmp.7 4 5)))
                            (if (call error? g42546783)
                              g42546783
                              (let ((g42546784 (call vector-set! tmp.7 5 6)))
                                (if (call error? g42546784)
                                  g42546784
                                  (let ((g42546785
                                         (call vector-set! tmp.7 6 7)))
                                    (if (call error? g42546785)
                                      g42546785
                                      (let ((g42546786
                                             (call vector-set! tmp.7 7 8)))
                                        (if (call error? g42546786)
                                          g42546786
                                          tmp.7)))))))))))))))))
        (let ((tmp.8 (call make-vector 8)))
          (let ((g42546787 (call vector-set! tmp.8 0 1)))
            (if (call error? g42546787)
              g42546787
              (let ((g42546788 (call vector-set! tmp.8 1 2)))
                (if (call error? g42546788)
                  g42546788
                  (let ((g42546789 (call vector-set! tmp.8 2 3)))
                    (if (call error? g42546789)
                      g42546789
                      (let ((g42546790 (call vector-set! tmp.8 3 4)))
                        (if (call error? g42546790)
                          g42546790
                          (let ((g42546791 (call vector-set! tmp.8 4 5)))
                            (if (call error? g42546791)
                              g42546791
                              (let ((g42546792 (call vector-set! tmp.8 5 6)))
                                (if (call error? g42546792)
                                  g42546792
                                  (let ((g42546793
                                         (call vector-set! tmp.8 6 7)))
                                    (if (call error? g42546793)
                                      g42546793
                                      (let ((g42546794
                                             (call vector-set! tmp.8 7 8)))
                                        (if (call error? g42546794)
                                          g42546794
                                          tmp.8))))))))))))))))))
      (call fun/boolean8686 (if #t (lambda () 628) (lambda () 577)))))))
(check-by-interp
 '(module
    (define fun/error8693 (lambda (oprand0) (error 130)))
    (define fun/boolean8690 (lambda () (if #f #f #f)))
    (define fun/empty8691 (lambda (oprand0 oprand1) (call fun/empty8692)))
    (define fun/empty8692 (lambda () empty))
    (if (call fun/boolean8690)
      (let ((empty0 empty)) empty)
      (call
       fun/empty8691
       (call fun/error8693 #\r)
       (let ((g42550609 #\x))
         (if (call error? g42550609)
           g42550609
           (let ((g42550610 #\U))
             (if (call error? g42550610) g42550610 #\O))))))))
(check-by-interp
 '(module
    (define fun/empty8699 (lambda () empty))
    (define fun/empty8698 (lambda () empty))
    (define fun/ascii-char8697 (lambda () #\Y))
    (define fun/procedure8696 (lambda () (lambda () 758)))
    (let ((vector0
           (let ((tmp.7 (call make-vector 8)))
             (let ((g42554425
                    (call
                     vector-set!
                     tmp.7
                     0
                     (call (call fun/procedure8696)))))
               (if (call error? g42554425)
                 g42554425
                 (let ((g42554426
                        (call vector-set! tmp.7 1 (call (let () empty)))))
                   (if (call error? g42554426)
                     g42554426
                     (let ((g42554427
                            (call
                             vector-set!
                             tmp.7
                             2
                             (call (if #t empty empty)))))
                       (if (call error? g42554427)
                         g42554427
                         (let ((g42554428
                                (call
                                 vector-set!
                                 tmp.7
                                 3
                                 (call (let () #\_)))))
                           (if (call error? g42554428)
                             g42554428
                             (let ((g42554429
                                    (call
                                     vector-set!
                                     tmp.7
                                     4
                                     (call
                                      (let ((g42554430 156))
                                        (if (call error? g42554430)
                                          g42554430
                                          (let ((g42554431 226))
                                            (if (call error? g42554431)
                                              g42554431
                                              114))))))))
                               (if (call error? g42554429)
                                 g42554429
                                 (let ((g42554432
                                        (call
                                         vector-set!
                                         tmp.7
                                         5
                                         (call (call void? 9)))))
                                   (if (call error? g42554432)
                                     g42554432
                                     (let ((g42554433
                                            (call
                                             vector-set!
                                             tmp.7
                                             6
                                             (call
                                              (let ()
                                                (call
                                                 cons
                                                 41
                                                 (call cons 429 empty)))))))
                                       (if (call error? g42554433)
                                         g42554433
                                         (let ((g42554434
                                                (call
                                                 vector-set!
                                                 tmp.7
                                                 7
                                                 (call
                                                  (call fun/ascii-char8697)))))
                                           (if (call error? g42554434)
                                             g42554434
                                             tmp.7))))))))))))))))))
          (error1
           (if (let ((tmp.8 (error 116))) (if tmp.8 tmp.8 (error 83)))
             (if (if #t (error 231) (error 0))
               (if (let () (error 12))
                 (if (if #f (error 179) (error 209)) (let () (error 198)) #f)
                 #f)
               #f)
             #f))
          (void2 (if #f (void) (void))))
      (let ((tmp.9 (if #t empty empty)))
        (if tmp.9
          tmp.9
          (let ((tmp.10 (let () empty)))
            (if tmp.10
              tmp.10
              (let ((tmp.11 (call fun/empty8698)))
                (if tmp.11
                  tmp.11
                  (let ((tmp.12
                         (let ((g42554435 empty))
                           (if (call error? g42554435)
                             g42554435
                             (let ((g42554436 empty))
                               (if (call error? g42554436)
                                 g42554436
                                 empty))))))
                    (if tmp.12
                      tmp.12
                      (let ((tmp.13 (if empty empty #f)))
                        (if tmp.13
                          tmp.13
                          (let ((tmp.14 (if #t empty empty)))
                            (if tmp.14
                              tmp.14
                              (call fun/empty8699))))))))))))))))
(check-by-interp
 '(module
    (define fun/error8703 (lambda () (error 178)))
    (define fun/error8702 (lambda (oprand0) (call fun/error8703)))
    (let () (call fun/error8702 (if #t (lambda () 781) (lambda () 718))))))
(check-by-interp
 '(module
    (define fun/ascii-char8706 (lambda () #\D))
    (let ((empty0 (if #t empty empty)))
      (let ((tmp.7 (if #f #\m #\w)))
        (if tmp.7
          tmp.7
          (let ((tmp.8 (call fun/ascii-char8706)))
            (if tmp.8
              tmp.8
              (let ((tmp.9 (let ((error0 (error 46)) (boolean1 #f)) #\N)))
                (if tmp.9
                  tmp.9
                  (let ((tmp.10 (if #t #\` #\M)))
                    (if tmp.10
                      tmp.10
                      (let ((tmp.11
                             (let ((g42562071 #\n))
                               (if (call error? g42562071)
                                 g42562071
                                 (let ((g42562072 #\L))
                                   (if (call error? g42562072)
                                     g42562072
                                     #\c))))))
                        (if tmp.11
                          tmp.11
                          (let ((tmp.12 (if #t #\L #\m)))
                            (if tmp.12
                              tmp.12
                              (if #\u
                                (if #\I (if #\S #\T #f) #f)
                                #f))))))))))))))))
(check-by-interp
 '(module
    (define fun/void8714 (lambda () (let ((void0 (void))) (void))))
    (define fun/void8713 (lambda () (call fun/void8714)))
    (call fun/void8713)))
