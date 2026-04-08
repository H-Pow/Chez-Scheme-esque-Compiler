#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v9
         cpsc411/langs/v11
         "../optimize-direct-calls.rkt")
(define (fail-if-invalid p)
  (when (not (just-exprs-lang-v9? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "just-exprs-lang-v9"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-just-exprs-lang-v9 p)
  (interp-just-exprs-lang-v9 (fail-if-invalid (optimize-direct-calls p)))))

(check-by-interp '(module #t))
(check-by-interp '(module #t))
(check-by-interp '(module 226))
(check-by-interp '(module (void)))
(check-by-interp '(module (let () (error 209))))
(check-by-interp '(module (let () (error 221))))
(check-by-interp
 '(module
    (letrec ((error?.65 (lambda (tmp.55) (error? tmp.55))))
      (let ((g42027422.7 #\b))
        (if (unsafe-procedure-call error?.65 g42027422.7)
          g42027422.7
          (let ((g42027423.8 #\_))
            (if (unsafe-procedure-call error?.65 g42027423.8)
              g42027423.8
              (let ((g42027424.9 #\c))
                (if (unsafe-procedure-call error?.65 g42027424.9)
                  g42027424.9
                  (let ((g42027425.10 #\q))
                    (if (unsafe-procedure-call error?.65 g42027425.10)
                      g42027425.10
                      (let ((g42027426.11 #\V))
                        (if (unsafe-procedure-call error?.65 g42027426.11)
                          g42027426.11
                          (let ((g42027427.12 #\p))
                            (if (unsafe-procedure-call error?.65 g42027427.12)
                              g42027427.12
                              #\R)))))))))))))))
(check-by-interp
 '(module
    (letrec ((error?.60 (lambda (tmp.50) (error? tmp.50))))
      (let ((g42031243.7 (error 172)))
        (if (unsafe-procedure-call error?.60 g42031243.7)
          g42031243.7
          (error 172))))))
(check-by-interp
 '(module
    (letrec ((fun/void8493.7 (lambda () (void))))
      (unsafe-procedure-call fun/void8493.7))))
(check-by-interp
 '(module
    (letrec ((*.59
              (lambda (tmp.21 tmp.22)
                (if (fixnum? tmp.22)
                  (if (fixnum? tmp.21) (unsafe-fx* tmp.21 tmp.22) (error 1))
                  (error 1)))))
      (unsafe-procedure-call *.59 11 130))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8498.7 (lambda () #\U)))
      (unsafe-procedure-call fun/ascii-char8498.7))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8501.7 (lambda () #\v)))
      (unsafe-procedure-call fun/ascii-char8501.7))))
(check-by-interp
 '(module
    (letrec ((error?.66 (lambda (tmp.56) (error? tmp.56))))
      (let ((g42050319.7
             (let ((g42050320.8 #\V))
               (if (unsafe-procedure-call error?.66 g42050320.8)
                 g42050320.8
                 (let ((g42050321.9 #\f))
                   (if (unsafe-procedure-call error?.66 g42050321.9)
                     g42050321.9
                     (let ((g42050322.10 #\E))
                       (if (unsafe-procedure-call error?.66 g42050322.10)
                         g42050322.10
                         (let ((g42050323.11 #\n))
                           (if (unsafe-procedure-call error?.66 g42050323.11)
                             g42050323.11
                             #\\))))))))))
        (if (unsafe-procedure-call error?.66 g42050319.7)
          g42050319.7
          (let ((g42050324.12 (let () #\I)))
            (if (unsafe-procedure-call error?.66 g42050324.12)
              g42050324.12
              (let ((void0.13 (void))) #\k))))))))
(check-by-interp
 '(module
    (letrec ((error?.84 (lambda (tmp.72) (error? tmp.72)))
             (unsafe-vector-set!.5
              (lambda (tmp.36 tmp.37 tmp.38)
                (if (unsafe-fx< tmp.37 (unsafe-vector-length tmp.36))
                  (if (unsafe-fx>= tmp.37 0)
                    (begin (unsafe-vector-set! tmp.36 tmp.37 tmp.38) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.83
              (lambda (tmp.60 tmp.61 tmp.62)
                (if (fixnum? tmp.61)
                  (if (vector? tmp.60)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.60
                     tmp.61
                     tmp.62)
                    (error 10))
                  (error 10))))
             (vector-init-loop.32
              (lambda (len.33 i.35 vec.34)
                (if (eq? len.33 i.35)
                  vec.34
                  (begin
                    (unsafe-vector-set! vec.34 i.35 0)
                    (unsafe-procedure-call
                     vector-init-loop.32
                     len.33
                     (unsafe-fx+ i.35 1)
                     vec.34)))))
             (make-init-vector.4
              (lambda (tmp.30)
                (let ((tmp.31 (unsafe-make-vector tmp.30)))
                  (unsafe-procedure-call
                   vector-init-loop.32
                   tmp.30
                   0
                   tmp.31))))
             (make-vector.82
              (lambda (tmp.58)
                (if (fixnum? tmp.58)
                  (unsafe-procedure-call make-init-vector.4 tmp.58)
                  (error 8))))
             (fun/ascii-char8506.13 (lambda () #\L))
             (fun/ascii-char8507.14 (lambda () #\i)))
      (let ((tmp.7.15
             (let ((procedure0.16
                    (lambda ()
                      (let ((tmp.8.17
                             (unsafe-procedure-call make-vector.82 8)))
                        (let ((g42054139.18
                               (unsafe-procedure-call
                                vector-set!.83
                                tmp.8.17
                                0
                                1)))
                          (if (unsafe-procedure-call error?.84 g42054139.18)
                            g42054139.18
                            (let ((g42054140.19
                                   (unsafe-procedure-call
                                    vector-set!.83
                                    tmp.8.17
                                    1
                                    2)))
                              (if (unsafe-procedure-call
                                   error?.84
                                   g42054140.19)
                                g42054140.19
                                (let ((g42054141.20
                                       (unsafe-procedure-call
                                        vector-set!.83
                                        tmp.8.17
                                        2
                                        3)))
                                  (if (unsafe-procedure-call
                                       error?.84
                                       g42054141.20)
                                    g42054141.20
                                    (let ((g42054142.21
                                           (unsafe-procedure-call
                                            vector-set!.83
                                            tmp.8.17
                                            3
                                            4)))
                                      (if (unsafe-procedure-call
                                           error?.84
                                           g42054142.21)
                                        g42054142.21
                                        (let ((g42054143.22
                                               (unsafe-procedure-call
                                                vector-set!.83
                                                tmp.8.17
                                                4
                                                5)))
                                          (if (unsafe-procedure-call
                                               error?.84
                                               g42054143.22)
                                            g42054143.22
                                            (let ((g42054144.23
                                                   (unsafe-procedure-call
                                                    vector-set!.83
                                                    tmp.8.17
                                                    5
                                                    6)))
                                              (if (unsafe-procedure-call
                                                   error?.84
                                                   g42054144.23)
                                                g42054144.23
                                                (let ((g42054145.24
                                                       (unsafe-procedure-call
                                                        vector-set!.83
                                                        tmp.8.17
                                                        6
                                                        7)))
                                                  (if (unsafe-procedure-call
                                                       error?.84
                                                       g42054145.24)
                                                    g42054145.24
                                                    (let ((g42054146.25
                                                           (unsafe-procedure-call
                                                            vector-set!.83
                                                            tmp.8.17
                                                            7
                                                            8)))
                                                      (if (unsafe-procedure-call
                                                           error?.84
                                                           g42054146.25)
                                                        g42054146.25
                                                        tmp.8.17))))))))))))))))))))
               #\G)))
        (if tmp.7.15
          tmp.7.15
          (let ((tmp.9.26 (if #f #\[ #\\)))
            (if tmp.9.26
              tmp.9.26
              (let ((tmp.10.27 (unsafe-procedure-call fun/ascii-char8506.13)))
                (if tmp.10.27
                  tmp.10.27
                  (let ((tmp.11.28 (if #t #\V #\V)))
                    (if tmp.11.28
                      tmp.11.28
                      (let ((tmp.12.29 (if #f #\i #\N)))
                        (if tmp.12.29
                          tmp.12.29
                          (unsafe-procedure-call
                           fun/ascii-char8507.14))))))))))))))
(check-by-interp '(module (let () #\U)))
(check-by-interp '(module (if #f (void) (void))))
(check-by-interp '(module (let () empty)))
(check-by-interp
 '(module
    (letrec ((fun/error8516.7
              (lambda () (unsafe-procedure-call fun/error8517.8)))
             (fun/error8517.8 (lambda () (error 112))))
      (unsafe-procedure-call fun/error8516.7))))
(check-by-interp '(module (let () 110)))
(check-by-interp
 '(module
    (letrec ((fun/error8523.7 (lambda () (error 210)))
             (fun/error8522.8
              (lambda () (unsafe-procedure-call fun/error8523.7))))
      (unsafe-procedure-call fun/error8522.8))))
(check-by-interp '(module (if #t (void) (void))))
(check-by-interp '(module (if #t 46 97)))
(check-by-interp
 '(module
    (letrec ((fun/void8531.7 (lambda () (void)))
             (fun/void8530.8
              (lambda () (unsafe-procedure-call fun/void8531.7))))
      (unsafe-procedure-call fun/void8530.8))))
(check-by-interp
 '(module
    (letrec ((error?.69 (lambda (tmp.59) (error? tmp.59)))
             (fun/void8534.7 (lambda () (void)))
             (fun/void8535.8 (lambda () (void))))
      (let ((g42092307.9 (let ((boolean0.10 #f)) (void))))
        (if (unsafe-procedure-call error?.69 g42092307.9)
          g42092307.9
          (let ((g42092308.11 (let ((empty0.12 empty)) (void))))
            (if (unsafe-procedure-call error?.69 g42092308.11)
              g42092308.11
              (let ((g42092309.13 (unsafe-procedure-call fun/void8534.7)))
                (if (unsafe-procedure-call error?.69 g42092309.13)
                  g42092309.13
                  (let ((g42092310.14 (if #t (void) (void))))
                    (if (unsafe-procedure-call error?.69 g42092310.14)
                      g42092310.14
                      (let ((g42092311.15
                             (unsafe-procedure-call fun/void8535.8)))
                        (if (unsafe-procedure-call error?.69 g42092311.15)
                          g42092311.15
                          (let ((g42092312.16
                                 (if (void)
                                   (if (void)
                                     (if (void)
                                       (if (void)
                                         (if (void) (if (void) (void) #f) #f)
                                         #f)
                                       #f)
                                     #f)
                                   #f)))
                            (if (unsafe-procedure-call error?.69 g42092312.16)
                              g42092312.16
                              (void))))))))))))))))
(check-by-interp
 '(module
    (letrec ((fun/void8539.7 (lambda () (void)))
             (fun/void8538.8
              (lambda () (unsafe-procedure-call fun/void8539.7))))
      (unsafe-procedure-call fun/void8538.8))))
(check-by-interp '(module (if #t #\i #\t)))
(check-by-interp
 '(module
    (letrec ((*.69
              (lambda (tmp.31 tmp.32)
                (if (fixnum? tmp.32)
                  (if (fixnum? tmp.31) (unsafe-fx* tmp.31 tmp.32) (error 1))
                  (error 1)))))
      (unsafe-procedure-call
       *.69
       (let ((tmp.7.12 84))
         (if tmp.7.12
           tmp.7.12
           (let ((tmp.8.13 193))
             (if tmp.8.13
               tmp.8.13
               (let ((tmp.9.14 207))
                 (if tmp.9.14
                   tmp.9.14
                   (let ((tmp.10.15 91)) (if tmp.10.15 tmp.10.15 149))))))))
       (let ((tmp.11.16 174)) (if tmp.11.16 tmp.11.16 79))))))
(check-by-interp
 '(module
    (letrec ((fun/error8546.7 (lambda () (let () (error 83)))))
      (unsafe-procedure-call fun/error8546.7))))
(check-by-interp
 '(module
    (letrec ((fun/empty8549.7 (lambda (oprand0.8) (let () empty))))
      (unsafe-procedure-call
       fun/empty8549.7
       (let ((error0.9 (error 90))) (error 239))))))
(check-by-interp
 '(module
    (letrec ((fun/void8553.7
              (lambda () (unsafe-procedure-call fun/void8554.8)))
             (fun/void8554.8 (lambda () (void)))
             (fun/void8552.9
              (lambda (oprand0.10) (unsafe-procedure-call fun/void8553.7))))
      (unsafe-procedure-call fun/void8552.9 (if #f 221 247)))))
(check-by-interp
 '(module
    (letrec ((error?.69 (lambda (tmp.59) (error? tmp.59)))
             (fun/error8557.7 (lambda () (error 161))))
      (if (let ((error0.8 (error 194))) (error 152))
        (let ((g42119027.9 (if #f (error 108) (error 68))))
          (if (unsafe-procedure-call error?.69 g42119027.9)
            g42119027.9
            (let ((g42119028.10 (error 192)))
              (if (unsafe-procedure-call error?.69 g42119028.10)
                g42119028.10
                (let ((g42119029.11 (if #f (error 126) (error 57))))
                  (if (unsafe-procedure-call error?.69 g42119029.11)
                    g42119029.11
                    (let ((g42119030.12
                           (let ((g42119031.13 (error 31)))
                             (if (unsafe-procedure-call error?.69 g42119031.13)
                               g42119031.13
                               (let ((g42119032.14 (error 219)))
                                 (if (unsafe-procedure-call
                                      error?.69
                                      g42119032.14)
                                   g42119032.14
                                   (error 86)))))))
                      (if (unsafe-procedure-call error?.69 g42119030.12)
                        g42119030.12
                        (let ((g42119033.15 (if #t (error 147) (error 181))))
                          (if (unsafe-procedure-call error?.69 g42119033.15)
                            g42119033.15
                            (let ((g42119034.16
                                   (unsafe-procedure-call fun/error8557.7)))
                              (if (unsafe-procedure-call
                                   error?.69
                                   g42119034.16)
                                g42119034.16
                                (error 211)))))))))))))
        #f))))
(check-by-interp
 '(module
    (letrec ((cons.64 (lambda (tmp.59 tmp.60) (cons tmp.59 tmp.60)))
             (fun/ascii-char8562.7 (lambda (oprand0.10) #\n))
             (fun/ascii-char8561.8 (lambda (oprand0.11) #\l))
             (fun/boolean8560.9 (lambda () #f)))
      (if (unsafe-procedure-call fun/boolean8560.9)
        (unsafe-procedure-call fun/ascii-char8561.8 #f)
        (unsafe-procedure-call
         fun/ascii-char8562.7
         (unsafe-procedure-call
          cons.64
          31
          (unsafe-procedure-call cons.64 309 empty)))))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8565.7 (lambda () #\C)))
      (let ((procedure0.8
             (lambda () (unsafe-procedure-call fun/ascii-char8565.7))))
        (let ((error0.9 (error 99))) (void))))))
(check-by-interp
 '(module
    (let ((ascii-char0.9
           (let ((tmp.7.10 #\A))
             (if tmp.7.10
               tmp.7.10
               (let ((tmp.8.11 #\^)) (if tmp.8.11 tmp.8.11 #\k))))))
      (if #f 249 139))))
(check-by-interp
 '(module
    (letrec ((fun/fixnum8570.7 (lambda () (let () 159))))
      (unsafe-procedure-call fun/fixnum8570.7))))
(check-by-interp
 '(module
    (letrec ((fun/void8573.7 (lambda () (if #f (void) (void)))))
      (unsafe-procedure-call fun/void8573.7))))
(check-by-interp '(module (let () empty)))
(check-by-interp
 '(module
    (letrec ((pair?.61 (lambda (tmp.52) (pair? tmp.52))))
      (unsafe-procedure-call
       pair?.61
       (let ((error0.8 (error 167)) (boolean1.7 #f)) (error 233))))))
(check-by-interp '(module (let () (let () (void)))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8582.7 (lambda () #\H)))
      (let ((void0.8 (if #t (void) (void))))
        (unsafe-procedure-call fun/ascii-char8582.7)))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8585.7 (lambda () (if #f #\r #\D))))
      (unsafe-procedure-call fun/ascii-char8585.7))))
(check-by-interp
 '(module
    (letrec ((error?.78 (lambda (tmp.66) (error? tmp.66)))
             (unsafe-vector-set!.5
              (lambda (tmp.30 tmp.31 tmp.32)
                (if (unsafe-fx< tmp.31 (unsafe-vector-length tmp.30))
                  (if (unsafe-fx>= tmp.31 0)
                    (begin (unsafe-vector-set! tmp.30 tmp.31 tmp.32) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.77
              (lambda (tmp.54 tmp.55 tmp.56)
                (if (fixnum? tmp.55)
                  (if (vector? tmp.54)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.54
                     tmp.55
                     tmp.56)
                    (error 10))
                  (error 10))))
             (vector-init-loop.26
              (lambda (len.27 i.29 vec.28)
                (if (eq? len.27 i.29)
                  vec.28
                  (begin
                    (unsafe-vector-set! vec.28 i.29 0)
                    (unsafe-procedure-call
                     vector-init-loop.26
                     len.27
                     (unsafe-fx+ i.29 1)
                     vec.28)))))
             (make-init-vector.4
              (lambda (tmp.24)
                (let ((tmp.25 (unsafe-make-vector tmp.24)))
                  (unsafe-procedure-call
                   vector-init-loop.26
                   tmp.24
                   0
                   tmp.25))))
             (make-vector.76
              (lambda (tmp.52)
                (if (fixnum? tmp.52)
                  (unsafe-procedure-call make-init-vector.4 tmp.52)
                  (error 8))))
             (fun/ascii-char8591.8
              (lambda (oprand0.13)
                (unsafe-procedure-call fun/ascii-char8592.9)))
             (fun/ascii-char8592.9 (lambda () #\L))
             (fun/ascii-char8595.10 (lambda () #\v))
             (fun/vector8594.11
              (lambda ()
                (let ((tmp.7.14 (unsafe-procedure-call make-vector.76 8)))
                  (let ((g42161003.15
                         (unsafe-procedure-call vector-set!.77 tmp.7.14 0 1)))
                    (if (unsafe-procedure-call error?.78 g42161003.15)
                      g42161003.15
                      (let ((g42161004.16
                             (unsafe-procedure-call
                              vector-set!.77
                              tmp.7.14
                              1
                              2)))
                        (if (unsafe-procedure-call error?.78 g42161004.16)
                          g42161004.16
                          (let ((g42161005.17
                                 (unsafe-procedure-call
                                  vector-set!.77
                                  tmp.7.14
                                  2
                                  3)))
                            (if (unsafe-procedure-call error?.78 g42161005.17)
                              g42161005.17
                              (let ((g42161006.18
                                     (unsafe-procedure-call
                                      vector-set!.77
                                      tmp.7.14
                                      3
                                      4)))
                                (if (unsafe-procedure-call
                                     error?.78
                                     g42161006.18)
                                  g42161006.18
                                  (let ((g42161007.19
                                         (unsafe-procedure-call
                                          vector-set!.77
                                          tmp.7.14
                                          4
                                          5)))
                                    (if (unsafe-procedure-call
                                         error?.78
                                         g42161007.19)
                                      g42161007.19
                                      (let ((g42161008.20
                                             (unsafe-procedure-call
                                              vector-set!.77
                                              tmp.7.14
                                              5
                                              6)))
                                        (if (unsafe-procedure-call
                                             error?.78
                                             g42161008.20)
                                          g42161008.20
                                          (let ((g42161009.21
                                                 (unsafe-procedure-call
                                                  vector-set!.77
                                                  tmp.7.14
                                                  6
                                                  7)))
                                            (if (unsafe-procedure-call
                                                 error?.78
                                                 g42161009.21)
                                              g42161009.21
                                              (let ((g42161010.22
                                                     (unsafe-procedure-call
                                                      vector-set!.77
                                                      tmp.7.14
                                                      7
                                                      8)))
                                                (if (unsafe-procedure-call
                                                     error?.78
                                                     g42161010.22)
                                                  g42161010.22
                                                  tmp.7.14)))))))))))))))))))
             (fun/vector8593.12
              (lambda (oprand0.23) (unsafe-procedure-call fun/vector8594.11))))
      (unsafe-procedure-call
       fun/ascii-char8591.8
       (unsafe-procedure-call
        fun/vector8593.12
        (unsafe-procedure-call fun/ascii-char8595.10))))))
(check-by-interp '(module (let () (let () empty))))
(check-by-interp
 '(module
    (letrec ((error?.107 (lambda (tmp.96) (error? tmp.96)))
             (cons.106 (lambda (tmp.101 tmp.102) (cons tmp.101 tmp.102)))
             (fun/ascii-char8602.22 (lambda () #\J))
             (fun/ascii-char8604.23 (lambda () #\_))
             (fun/ascii-char8603.24 (lambda () #\N)))
      (let ((g42168642.25
             (let ((tmp.7.26
                    (let ((pair0.28
                           (unsafe-procedure-call
                            cons.106
                            141
                            (unsafe-procedure-call cons.106 498 empty)))
                          (boolean1.27 #f))
                      #\B)))
               (if tmp.7.26
                 tmp.7.26
                 (let ((tmp.8.29
                        (let ((g42168643.30 #\V))
                          (if (unsafe-procedure-call error?.107 g42168643.30)
                            g42168643.30
                            #\B))))
                   (if tmp.8.29
                     tmp.8.29
                     (let ((tmp.9.31
                            (let ((procedure0.32 (lambda () (void)))) #\Z)))
                       (if tmp.9.31
                         tmp.9.31
                         (let ((tmp.10.33
                                (unsafe-procedure-call fun/ascii-char8602.22)))
                           (if tmp.10.33
                             tmp.10.33
                             (let ((fixnum0.35 12) (ascii-char1.34 #\R))
                               #\e)))))))))))
        (if (unsafe-procedure-call error?.107 g42168642.25)
          g42168642.25
          (let ((g42168644.36 (unsafe-procedure-call fun/ascii-char8603.24)))
            (if (unsafe-procedure-call error?.107 g42168644.36)
              g42168644.36
              (let ((g42168645.37
                     (let ((tmp.11.38
                            (unsafe-procedure-call fun/ascii-char8604.23)))
                       (if tmp.11.38
                         tmp.11.38
                         (let ((tmp.12.39
                                (let ((fixnum0.41 190) (error1.40 (error 40)))
                                  #\])))
                           (if tmp.12.39
                             tmp.12.39
                             (let ((tmp.13.42
                                    (let ((tmp.14.43 #\L))
                                      (if tmp.14.43 tmp.14.43 #\l))))
                               (if tmp.13.42
                                 tmp.13.42
                                 (let ((tmp.15.44
                                        (if #\I
                                          (if #\p (if #\d #\L #f) #f)
                                          #f)))
                                   (if tmp.15.44
                                     tmp.15.44
                                     (let ((tmp.16.45 #\T))
                                       (if tmp.16.45
                                         tmp.16.45
                                         (let ((tmp.17.46 #\\))
                                           (if tmp.17.46
                                             tmp.17.46
                                             (let ((tmp.18.47 #\Y))
                                               (if tmp.18.47
                                                 tmp.18.47
                                                 (let ((tmp.19.48 #\V))
                                                   (if tmp.19.48
                                                     tmp.19.48
                                                     (let ((tmp.20.49 #\y))
                                                       (if tmp.20.49
                                                         tmp.20.49
                                                         (let ((tmp.21.50 #\_))
                                                           (if tmp.21.50
                                                             tmp.21.50
                                                             #\F))))))))))))))))))))))
                (if (unsafe-procedure-call error?.107 g42168645.37)
                  g42168645.37
                  (let ((g42168646.51 (let ((fixnum0.52 45)) #\j)))
                    (if (unsafe-procedure-call error?.107 g42168646.51)
                      g42168646.51
                      (let ((g42168647.53 (if #f #\A #\c)))
                        (if (unsafe-procedure-call error?.107 g42168647.53)
                          g42168647.53
                          (if #f #\U #\e))))))))))))))
(check-by-interp
 '(module
    (letrec ((fun/error8607.7 (lambda (oprand0.8) (error 187))))
      (let () (unsafe-procedure-call fun/error8607.7 #t)))))
(check-by-interp
 '(module
    (letrec ((fun/error8610.7 (lambda (oprand0.8) (error 137))))
      (if (if #f #f #t)
        (let () (error 47))
        (unsafe-procedure-call fun/error8610.7 6)))))
(check-by-interp
 '(module
    (letrec ((fun/boolean8613.7 (lambda (oprand0.9) #t))
             (fun/void8614.8 (lambda (oprand0.10) (void))))
      (if (unsafe-procedure-call fun/boolean8613.7 #\I)
        (if #t (void) (void))
        (unsafe-procedure-call fun/void8614.8 #f)))))
(check-by-interp
 '(module
    (letrec ((error?.63 (lambda (tmp.53) (error? tmp.53))))
      (let ((g42183917.7 (let ((ascii-char0.8 #\r)) #\C)))
        (if (unsafe-procedure-call error?.63 g42183917.7)
          g42183917.7
          (let ((g42183918.9 (if #f #\G #\R)))
            (if (unsafe-procedure-call error?.63 g42183918.9)
              g42183918.9
              (let ((g42183919.10 (let () #\t)))
                (if (unsafe-procedure-call error?.63 g42183919.10)
                  g42183919.10
                  (let () #\t))))))))))
(check-by-interp
 '(module
    (letrec ((fun/error8619.7 (lambda (oprand0.8) (error 75))))
      (if (if #f #t #f)
        (unsafe-procedure-call fun/error8619.7 #f)
        (if #f (error 23) (error 167))))))
(check-by-interp
 '(module
    (letrec ((fun/ascii-char8622.7
              (lambda () (unsafe-procedure-call fun/ascii-char8623.8)))
             (fun/ascii-char8623.8
              (lambda () (unsafe-procedure-call fun/ascii-char8624.9)))
             (fun/ascii-char8624.9 (lambda () #\q)))
      (unsafe-procedure-call fun/ascii-char8622.7))))
(check-by-interp
 '(module
    (letrec ((unsafe-vector-set!.5
              (lambda (tmp.68 tmp.69 tmp.70)
                (if (unsafe-fx< tmp.69 (unsafe-vector-length tmp.68))
                  (if (unsafe-fx>= tmp.69 0)
                    (begin (unsafe-vector-set! tmp.68 tmp.69 tmp.70) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.117
              (lambda (tmp.92 tmp.93 tmp.94)
                (if (fixnum? tmp.93)
                  (if (vector? tmp.92)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.92
                     tmp.93
                     tmp.94)
                    (error 10))
                  (error 10))))
             (vector-init-loop.64
              (lambda (len.65 i.67 vec.66)
                (if (eq? len.65 i.67)
                  vec.66
                  (begin
                    (unsafe-vector-set! vec.66 i.67 0)
                    (unsafe-procedure-call
                     vector-init-loop.64
                     len.65
                     (unsafe-fx+ i.67 1)
                     vec.66)))))
             (make-init-vector.4
              (lambda (tmp.62)
                (let ((tmp.63 (unsafe-make-vector tmp.62)))
                  (unsafe-procedure-call
                   vector-init-loop.64
                   tmp.62
                   0
                   tmp.63))))
             (make-vector.116
              (lambda (tmp.90)
                (if (fixnum? tmp.90)
                  (unsafe-procedure-call make-init-vector.4 tmp.90)
                  (error 8))))
             (cons.115 (lambda (tmp.109 tmp.110) (cons tmp.109 tmp.110)))
             (error?.114 (lambda (tmp.104) (error? tmp.104)))
             (fun/empty8627.23 (lambda (oprand0.27) (if #f empty empty)))
             (fun/empty8630.24 (lambda () empty))
             (fun/empty8629.25 (lambda (oprand0.28) empty))
             (fun/empty8628.26 (lambda () empty)))
      (if (let () empty)
        (if (unsafe-procedure-call
             fun/empty8627.23
             (let ((ascii-char0.29 #\B)) #t))
          (if (if #t empty empty)
            (if (if #t empty empty)
              (if (if (let ((tmp.7.30 empty))
                        (if tmp.7.30
                          tmp.7.30
                          (let ((tmp.8.31 empty))
                            (if tmp.8.31
                              tmp.8.31
                              (let ((tmp.9.32 empty))
                                (if tmp.9.32
                                  tmp.9.32
                                  (let ((tmp.10.33 empty))
                                    (if tmp.10.33
                                      tmp.10.33
                                      (let ((tmp.11.34 empty))
                                        (if tmp.11.34
                                          tmp.11.34
                                          (let ((tmp.12.35 empty))
                                            (if tmp.12.35
                                              tmp.12.35
                                              empty))))))))))))
                    (if (if #t empty empty)
                      (if (if empty
                            (if empty (if empty (if empty empty #f) #f) #f)
                            #f)
                        (if (if #f empty empty)
                          (unsafe-procedure-call fun/empty8628.26)
                          #f)
                        #f)
                      #f)
                    #f)
                (let ((g42195365.36
                       (unsafe-procedure-call fun/empty8629.25 #f)))
                  (if (unsafe-procedure-call error?.114 g42195365.36)
                    g42195365.36
                    (let ((g42195366.37 (let ((fixnum0.38 174)) empty)))
                      (if (unsafe-procedure-call error?.114 g42195366.37)
                        g42195366.37
                        (let ((g42195367.39
                               (unsafe-procedure-call fun/empty8630.24)))
                          (if (unsafe-procedure-call error?.114 g42195367.39)
                            g42195367.39
                            (let ((g42195368.40
                                   (let ((tmp.13.41 empty))
                                     (if tmp.13.41
                                       tmp.13.41
                                       (let ((tmp.14.42 empty))
                                         (if tmp.14.42
                                           tmp.14.42
                                           (let ((tmp.15.43 empty))
                                             (if tmp.15.43
                                               tmp.15.43
                                               empty))))))))
                              (if (unsafe-procedure-call
                                   error?.114
                                   g42195368.40)
                                g42195368.40
                                (let ((g42195369.44
                                       (let ((pair0.46
                                              (unsafe-procedure-call
                                               cons.115
                                               202
                                               (unsafe-procedure-call
                                                cons.115
                                                322
                                                empty)))
                                             (vector1.45
                                              (let ((tmp.16.47
                                                     (unsafe-procedure-call
                                                      make-vector.116
                                                      8)))
                                                (let ((g42195370.48
                                                       (unsafe-procedure-call
                                                        vector-set!.117
                                                        tmp.16.47
                                                        0
                                                        0)))
                                                  (if (unsafe-procedure-call
                                                       error?.114
                                                       g42195370.48)
                                                    g42195370.48
                                                    (let ((g42195371.49
                                                           (unsafe-procedure-call
                                                            vector-set!.117
                                                            tmp.16.47
                                                            1
                                                            1)))
                                                      (if (unsafe-procedure-call
                                                           error?.114
                                                           g42195371.49)
                                                        g42195371.49
                                                        (let ((g42195372.50
                                                               (unsafe-procedure-call
                                                                vector-set!.117
                                                                tmp.16.47
                                                                2
                                                                2)))
                                                          (if (unsafe-procedure-call
                                                               error?.114
                                                               g42195372.50)
                                                            g42195372.50
                                                            (let ((g42195373.51
                                                                   (unsafe-procedure-call
                                                                    vector-set!.117
                                                                    tmp.16.47
                                                                    3
                                                                    3)))
                                                              (if (unsafe-procedure-call
                                                                   error?.114
                                                                   g42195373.51)
                                                                g42195373.51
                                                                (let ((g42195374.52
                                                                       (unsafe-procedure-call
                                                                        vector-set!.117
                                                                        tmp.16.47
                                                                        4
                                                                        4)))
                                                                  (if (unsafe-procedure-call
                                                                       error?.114
                                                                       g42195374.52)
                                                                    g42195374.52
                                                                    (let ((g42195375.53
                                                                           (unsafe-procedure-call
                                                                            vector-set!.117
                                                                            tmp.16.47
                                                                            5
                                                                            5)))
                                                                      (if (unsafe-procedure-call
                                                                           error?.114
                                                                           g42195375.53)
                                                                        g42195375.53
                                                                        (let ((g42195376.54
                                                                               (unsafe-procedure-call
                                                                                vector-set!.117
                                                                                tmp.16.47
                                                                                6
                                                                                6)))
                                                                          (if (unsafe-procedure-call
                                                                               error?.114
                                                                               g42195376.54)
                                                                            g42195376.54
                                                                            (let ((g42195377.55
                                                                                   (unsafe-procedure-call
                                                                                    vector-set!.117
                                                                                    tmp.16.47
                                                                                    7
                                                                                    7)))
                                                                              (if (unsafe-procedure-call
                                                                                   error?.114
                                                                                   g42195377.55)
                                                                                g42195377.55
                                                                                tmp.16.47)))))))))))))))))))
                                         empty)))
                                  (if (unsafe-procedure-call
                                       error?.114
                                       g42195369.44)
                                    g42195369.44
                                    (let ((tmp.17.56 empty))
                                      (if tmp.17.56
                                        tmp.17.56
                                        (let ((tmp.18.57 empty))
                                          (if tmp.18.57
                                            tmp.18.57
                                            (let ((tmp.19.58 empty))
                                              (if tmp.19.58
                                                tmp.19.58
                                                (let ((tmp.20.59 empty))
                                                  (if tmp.20.59
                                                    tmp.20.59
                                                    (let ((tmp.21.60 empty))
                                                      (if tmp.21.60
                                                        tmp.21.60
                                                        (let ((tmp.22.61
                                                               empty))
                                                          (if tmp.22.61
                                                            tmp.22.61
                                                            empty))))))))))))))))))))))
                #f)
              #f)
            #f)
          #f)
        #f))))
(check-by-interp
 '(module
    (if (if #t #f #t)
      (if #f (error 46) (error 150))
      (let ((procedure0.7 (lambda () 143))) (error 251)))))
(check-by-interp
 '(module
    (let ((error0.20 (if #t (error 72) (error 35)))
          (fixnum1.19
           (let ((tmp.7.21 162))
             (if tmp.7.21
               tmp.7.21
               (let ((tmp.8.22 92))
                 (if tmp.8.22
                   tmp.8.22
                   (let ((tmp.9.23 198))
                     (if tmp.9.23
                       tmp.9.23
                       (let ((tmp.10.24 13))
                         (if tmp.10.24
                           tmp.10.24
                           (let ((tmp.11.25 140))
                             (if tmp.11.25
                               tmp.11.25
                               (let ((tmp.12.26 114))
                                 (if tmp.12.26 tmp.12.26 150))))))))))))))
      (let ((tmp.13.27 #f))
        (if tmp.13.27
          tmp.13.27
          (let ((tmp.14.28 #t))
            (if tmp.14.28
              tmp.14.28
              (let ((tmp.15.29 #t))
                (if tmp.15.29
                  tmp.15.29
                  (let ((tmp.16.30 #f))
                    (if tmp.16.30
                      tmp.16.30
                      (let ((tmp.17.31 #f))
                        (if tmp.17.31
                          tmp.17.31
                          (let ((tmp.18.32 #t))
                            (if tmp.18.32 tmp.18.32 #t)))))))))))))))
(check-by-interp '(module (if (if #f #t #f) (let () (void)) (void))))
(check-by-interp
 '(module
    (letrec ((error?.62 (lambda (tmp.52) (error? tmp.52))))
      (if (if #t #t #t)
        (let ((ascii-char0.7 #\H)) 50)
        (let ((g42210650.8 184))
          (if (unsafe-procedure-call error?.62 g42210650.8)
            g42210650.8
            (let ((g42210651.9 213))
              (if (unsafe-procedure-call error?.62 g42210651.9)
                g42210651.9
                114))))))))
(check-by-interp
 '(module
    (letrec ((cons.67 (lambda (tmp.62 tmp.63) (cons tmp.62 tmp.63))))
      (if (let ((void0.10 (void)) (empty1.9 empty)) (error 173))
        (let ((tmp.7.11 (let ((boolean0.12 #t)) (error 149))))
          (if tmp.7.11
            tmp.7.11
            (let ((tmp.8.13
                   (let ((pair0.14
                          (unsafe-procedure-call
                           cons.67
                           227
                           (unsafe-procedure-call cons.67 467 empty))))
                     (error 230))))
              (if tmp.8.13 tmp.8.13 (if #t (error 139) (error 80))))))
        #f))))
(check-by-interp
 '(module
    (letrec ((cons.82 (lambda (tmp.76 tmp.77) (cons tmp.76 tmp.77)))
             (error?.81 (lambda (tmp.71) (error? tmp.71)))
             (fun/empty8650.14 (lambda () (if #t empty empty)))
             (fun/empty8649.15 (lambda () empty)))
      (let ((g42218286.16
             (let ((tmp.7.17 (if #f empty empty)))
               (if tmp.7.17
                 tmp.7.17
                 (let ((tmp.8.18 (if #f empty empty)))
                   (if tmp.8.18
                     tmp.8.18
                     (let ((tmp.9.19 (unsafe-procedure-call fun/empty8649.15)))
                       (if tmp.9.19
                         tmp.9.19
                         (let ((tmp.10.20 (if empty (if empty empty #f) #f)))
                           (if tmp.10.20
                             tmp.10.20
                             (let ((tmp.11.21 (if #t empty empty)))
                               (if tmp.11.21
                                 tmp.11.21
                                 (if #f empty empty)))))))))))))
        (if (unsafe-procedure-call error?.81 g42218286.16)
          g42218286.16
          (let ((g42218287.22
                 (if (if #f empty empty)
                   (if (let () empty)
                     (if (let ((tmp.12.23 empty))
                           (if tmp.12.23
                             tmp.12.23
                             (let ((tmp.13.24 empty))
                               (if tmp.13.24 tmp.13.24 empty))))
                       (if (let ((procedure0.26
                                  (lambda ()
                                    (unsafe-procedure-call
                                     cons.82
                                     98
                                     (unsafe-procedure-call
                                      cons.82
                                      276
                                      empty))))
                                 (boolean1.25 #f))
                             empty)
                         (if #t empty empty)
                         #f)
                       #f)
                     #f)
                   #f)))
            (if (unsafe-procedure-call error?.81 g42218287.22)
              g42218287.22
              (let ((g42218288.27 (unsafe-procedure-call fun/empty8650.14)))
                (if (unsafe-procedure-call error?.81 g42218288.27)
                  g42218288.27
                  (let ((g42218289.28 (if empty empty #f)))
                    (if (unsafe-procedure-call error?.81 g42218289.28)
                      g42218289.28
                      (if #t empty empty))))))))))))
(check-by-interp
 '(module
    (letrec ((fun/error8653.7
              (lambda () (unsafe-procedure-call fun/error8654.8)))
             (fun/error8654.8
              (lambda () (unsafe-procedure-call fun/error8655.9)))
             (fun/error8655.9 (lambda () (error 74))))
      (unsafe-procedure-call fun/error8653.7))))
(check-by-interp
 '(module
    (letrec ((error?.68 (lambda (tmp.58) (error? tmp.58)))
             (fun/ascii-char8662.7 (lambda () (if #f #\i #\S)))
             (fun/ascii-char8658.8
              (lambda () (unsafe-procedure-call fun/ascii-char8659.9)))
             (fun/ascii-char8659.9 (lambda () #\f))
             (fun/ascii-char8660.10
              (lambda (oprand0.12)
                (unsafe-procedure-call fun/ascii-char8661.11)))
             (fun/ascii-char8661.11 (lambda () #\C)))
      (let ((g42225918.13 (unsafe-procedure-call fun/ascii-char8658.8)))
        (if (unsafe-procedure-call error?.68 g42225918.13)
          g42225918.13
          (let ((g42225919.14 (let () #\Q)))
            (if (unsafe-procedure-call error?.68 g42225919.14)
              g42225919.14
              (let ((g42225920.15
                     (unsafe-procedure-call fun/ascii-char8660.10 empty)))
                (if (unsafe-procedure-call error?.68 g42225920.15)
                  g42225920.15
                  (unsafe-procedure-call fun/ascii-char8662.7))))))))))
(check-by-interp
 '(module
    (if (if #f #t #t)
      (let ((error0.7 (error 214))) (void))
      (if #f (void) (void)))))
(check-by-interp
 '(module
    (letrec ((error?.63 (lambda (tmp.53) (error? tmp.53)))
             (fun/any7325.7 (lambda (oprand0.9 oprand1.8) (error 124))))
      (if (let ((g42233549.10 (let () #t)))
            (if (unsafe-procedure-call error?.63 g42233549.10)
              g42233549.10
              (let () #t)))
        (unsafe-procedure-call
         error?.63
         (unsafe-procedure-call fun/any7325.7 #\K (lambda () 713)))
        (if #f #f #t)))))
(check-by-interp
 '(module
    (letrec ((error?.79 (lambda (tmp.65) (error? tmp.65)))
             (unsafe-vector-set!.5
              (lambda (tmp.29 tmp.30 tmp.31)
                (if (unsafe-fx< tmp.30 (unsafe-vector-length tmp.29))
                  (if (unsafe-fx>= tmp.30 0)
                    (begin (unsafe-vector-set! tmp.29 tmp.30 tmp.31) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.78
              (lambda (tmp.53 tmp.54 tmp.55)
                (if (fixnum? tmp.54)
                  (if (vector? tmp.53)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.53
                     tmp.54
                     tmp.55)
                    (error 10))
                  (error 10))))
             (vector-init-loop.25
              (lambda (len.26 i.28 vec.27)
                (if (eq? len.26 i.28)
                  vec.27
                  (begin
                    (unsafe-vector-set! vec.27 i.28 0)
                    (unsafe-procedure-call
                     vector-init-loop.25
                     len.26
                     (unsafe-fx+ i.28 1)
                     vec.27)))))
             (make-init-vector.4
              (lambda (tmp.23)
                (let ((tmp.24 (unsafe-make-vector tmp.23)))
                  (unsafe-procedure-call
                   vector-init-loop.25
                   tmp.23
                   0
                   tmp.24))))
             (make-vector.77
              (lambda (tmp.51)
                (if (fixnum? tmp.51)
                  (unsafe-procedure-call make-init-vector.4 tmp.51)
                  (error 8))))
             (cons.76 (lambda (tmp.70 tmp.71) (cons tmp.70 tmp.71)))
             (void?.75 (lambda (tmp.63) (void? tmp.63)))
             (fun/any8476.8 (lambda (oprand0.9) 169)))
      (if (unsafe-procedure-call
           void?.75
           (unsafe-procedure-call fun/any8476.8 (lambda () 1020)))
        (let ((procedure0.12
               (lambda ()
                 (unsafe-procedure-call
                  cons.76
                  215
                  (unsafe-procedure-call cons.76 403 empty))))
              (error1.11 (error 137))
              (error2.10 (error 179)))
          #f)
        (let ((vector0.13
               (let ((tmp.7.14 (unsafe-procedure-call make-vector.77 8)))
                 (let ((g42237367.15
                        (unsafe-procedure-call vector-set!.78 tmp.7.14 0 0)))
                   (if (unsafe-procedure-call error?.79 g42237367.15)
                     g42237367.15
                     (let ((g42237368.16
                            (unsafe-procedure-call
                             vector-set!.78
                             tmp.7.14
                             1
                             1)))
                       (if (unsafe-procedure-call error?.79 g42237368.16)
                         g42237368.16
                         (let ((g42237369.17
                                (unsafe-procedure-call
                                 vector-set!.78
                                 tmp.7.14
                                 2
                                 2)))
                           (if (unsafe-procedure-call error?.79 g42237369.17)
                             g42237369.17
                             (let ((g42237370.18
                                    (unsafe-procedure-call
                                     vector-set!.78
                                     tmp.7.14
                                     3
                                     3)))
                               (if (unsafe-procedure-call
                                    error?.79
                                    g42237370.18)
                                 g42237370.18
                                 (let ((g42237371.19
                                        (unsafe-procedure-call
                                         vector-set!.78
                                         tmp.7.14
                                         4
                                         4)))
                                   (if (unsafe-procedure-call
                                        error?.79
                                        g42237371.19)
                                     g42237371.19
                                     (let ((g42237372.20
                                            (unsafe-procedure-call
                                             vector-set!.78
                                             tmp.7.14
                                             5
                                             5)))
                                       (if (unsafe-procedure-call
                                            error?.79
                                            g42237372.20)
                                         g42237372.20
                                         (let ((g42237373.21
                                                (unsafe-procedure-call
                                                 vector-set!.78
                                                 tmp.7.14
                                                 6
                                                 6)))
                                           (if (unsafe-procedure-call
                                                error?.79
                                                g42237373.21)
                                             g42237373.21
                                             (let ((g42237374.22
                                                    (unsafe-procedure-call
                                                     vector-set!.78
                                                     tmp.7.14
                                                     7
                                                     7)))
                                               (if (unsafe-procedure-call
                                                    error?.79
                                                    g42237374.22)
                                                 g42237374.22
                                                 tmp.7.14)))))))))))))))))))
          #t)))))
(check-by-interp
 '(module
    (letrec ((cons.75 (lambda (tmp.66 tmp.67) (cons tmp.66 tmp.67)))
             (fixnum?.74 (lambda (tmp.56) (fixnum? tmp.56)))
             (error?.73 (lambda (tmp.61) (error? tmp.61)))
             (unsafe-vector-set!.5
              (lambda (tmp.25 tmp.26 tmp.27)
                (if (unsafe-fx< tmp.26 (unsafe-vector-length tmp.25))
                  (if (unsafe-fx>= tmp.26 0)
                    (begin (unsafe-vector-set! tmp.25 tmp.26 tmp.27) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.72
              (lambda (tmp.49 tmp.50 tmp.51)
                (if (fixnum? tmp.50)
                  (if (vector? tmp.49)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.49
                     tmp.50
                     tmp.51)
                    (error 10))
                  (error 10))))
             (vector-init-loop.21
              (lambda (len.22 i.24 vec.23)
                (if (eq? len.22 i.24)
                  vec.23
                  (begin
                    (unsafe-vector-set! vec.23 i.24 0)
                    (unsafe-procedure-call
                     vector-init-loop.21
                     len.22
                     (unsafe-fx+ i.24 1)
                     vec.23)))))
             (make-init-vector.4
              (lambda (tmp.19)
                (let ((tmp.20 (unsafe-make-vector tmp.19)))
                  (unsafe-procedure-call
                   vector-init-loop.21
                   tmp.19
                   0
                   tmp.20))))
             (make-vector.71
              (lambda (tmp.47)
                (if (fixnum? tmp.47)
                  (unsafe-procedure-call make-init-vector.4 tmp.47)
                  (error 8)))))
      (if (unsafe-procedure-call
           fixnum?.74
           (if #t
             194
             (let ((tmp.7.8 (unsafe-procedure-call make-vector.71 8)))
               (let ((g42241192.9
                      (unsafe-procedure-call vector-set!.72 tmp.7.8 0 1)))
                 (if (unsafe-procedure-call error?.73 g42241192.9)
                   g42241192.9
                   (let ((g42241193.10
                          (unsafe-procedure-call vector-set!.72 tmp.7.8 1 2)))
                     (if (unsafe-procedure-call error?.73 g42241193.10)
                       g42241193.10
                       (let ((g42241194.11
                              (unsafe-procedure-call
                               vector-set!.72
                               tmp.7.8
                               2
                               3)))
                         (if (unsafe-procedure-call error?.73 g42241194.11)
                           g42241194.11
                           (let ((g42241195.12
                                  (unsafe-procedure-call
                                   vector-set!.72
                                   tmp.7.8
                                   3
                                   4)))
                             (if (unsafe-procedure-call error?.73 g42241195.12)
                               g42241195.12
                               (let ((g42241196.13
                                      (unsafe-procedure-call
                                       vector-set!.72
                                       tmp.7.8
                                       4
                                       5)))
                                 (if (unsafe-procedure-call
                                      error?.73
                                      g42241196.13)
                                   g42241196.13
                                   (let ((g42241197.14
                                          (unsafe-procedure-call
                                           vector-set!.72
                                           tmp.7.8
                                           5
                                           6)))
                                     (if (unsafe-procedure-call
                                          error?.73
                                          g42241197.14)
                                       g42241197.14
                                       (let ((g42241198.15
                                              (unsafe-procedure-call
                                               vector-set!.72
                                               tmp.7.8
                                               6
                                               7)))
                                         (if (unsafe-procedure-call
                                              error?.73
                                              g42241198.15)
                                           g42241198.15
                                           (let ((g42241199.16
                                                  (unsafe-procedure-call
                                                   vector-set!.72
                                                   tmp.7.8
                                                   7
                                                   8)))
                                             (if (unsafe-procedure-call
                                                  error?.73
                                                  g42241199.16)
                                               g42241199.16
                                               tmp.7.8)))))))))))))))))))
        (let ((pair0.17
               (unsafe-procedure-call
                cons.75
                82
                (unsafe-procedure-call cons.75 500 empty))))
          empty)
        (let ((fixnum0.18 88)) empty)))))
(check-by-interp
 '(module
    (letrec ((fun/empty8484.7 (lambda () (if #t empty empty)))
             (fun/empty8483.8
              (lambda () (unsafe-procedure-call fun/empty8484.7))))
      (unsafe-procedure-call fun/empty8483.8))))
(check-by-interp
 '(module
    (if (let ((ascii-char0.7 #\`)) #t)
      (if #f (void) (void))
      (if #t (void) (void)))))
(check-by-interp
 '(module
    (letrec ((error?.111 (lambda (tmp.98) (error? tmp.98)))
             (unsafe-vector-set!.5
              (lambda (tmp.62 tmp.63 tmp.64)
                (if (unsafe-fx< tmp.63 (unsafe-vector-length tmp.62))
                  (if (unsafe-fx>= tmp.63 0)
                    (begin (unsafe-vector-set! tmp.62 tmp.63 tmp.64) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.110
              (lambda (tmp.86 tmp.87 tmp.88)
                (if (fixnum? tmp.87)
                  (if (vector? tmp.86)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.86
                     tmp.87
                     tmp.88)
                    (error 10))
                  (error 10))))
             (vector-init-loop.58
              (lambda (len.59 i.61 vec.60)
                (if (eq? len.59 i.61)
                  vec.60
                  (begin
                    (unsafe-vector-set! vec.60 i.61 0)
                    (unsafe-procedure-call
                     vector-init-loop.58
                     len.59
                     (unsafe-fx+ i.61 1)
                     vec.60)))))
             (make-init-vector.4
              (lambda (tmp.56)
                (let ((tmp.57 (unsafe-make-vector tmp.56)))
                  (unsafe-procedure-call
                   vector-init-loop.58
                   tmp.56
                   0
                   tmp.57))))
             (make-vector.109
              (lambda (tmp.84)
                (if (fixnum? tmp.84)
                  (unsafe-procedure-call make-init-vector.4 tmp.84)
                  (error 8))))
             (cons.108 (lambda (tmp.103 tmp.104) (cons tmp.103 tmp.104)))
             (fun/ascii-char8493.9 (lambda () #\d))
             (fun/void8489.10
              (lambda (oprand0.20 oprand1.19)
                (unsafe-procedure-call fun/void8490.13)))
             (fun/pair8497.11
              (lambda (oprand0.21)
                (let ((boolean0.22 #t))
                  (unsafe-procedure-call
                   cons.108
                   243
                   (unsafe-procedure-call cons.108 369 empty)))))
             (fun/void8495.12
              (lambda (oprand0.24 oprand1.23)
                (unsafe-procedure-call fun/void8496.15)))
             (fun/void8490.13
              (lambda () (unsafe-procedure-call fun/void8491.18)))
             (fun/ascii-char8494.14 (lambda () #\e))
             (fun/void8496.15 (lambda () (void)))
             (fun/pair8498.16
              (lambda ()
                (unsafe-procedure-call
                 cons.108
                 164
                 (unsafe-procedure-call cons.108 306 empty))))
             (fun/ascii-char8492.17
              (lambda (oprand0.26 oprand1.25)
                (unsafe-procedure-call fun/ascii-char8493.9)))
             (fun/void8491.18 (lambda () (void))))
      (unsafe-procedure-call
       fun/void8489.10
       (if (unsafe-procedure-call
            fun/ascii-char8492.17
            (if #t (error 139) (error 166))
            (let ((vector0.27
                   (let ((tmp.7.28 (unsafe-procedure-call make-vector.109 8)))
                     (let ((g42252645.29
                            (unsafe-procedure-call
                             vector-set!.110
                             tmp.7.28
                             0
                             1)))
                       (if (unsafe-procedure-call error?.111 g42252645.29)
                         g42252645.29
                         (let ((g42252646.30
                                (unsafe-procedure-call
                                 vector-set!.110
                                 tmp.7.28
                                 1
                                 2)))
                           (if (unsafe-procedure-call error?.111 g42252646.30)
                             g42252646.30
                             (let ((g42252647.31
                                    (unsafe-procedure-call
                                     vector-set!.110
                                     tmp.7.28
                                     2
                                     3)))
                               (if (unsafe-procedure-call
                                    error?.111
                                    g42252647.31)
                                 g42252647.31
                                 (let ((g42252648.32
                                        (unsafe-procedure-call
                                         vector-set!.110
                                         tmp.7.28
                                         3
                                         4)))
                                   (if (unsafe-procedure-call
                                        error?.111
                                        g42252648.32)
                                     g42252648.32
                                     (let ((g42252649.33
                                            (unsafe-procedure-call
                                             vector-set!.110
                                             tmp.7.28
                                             4
                                             5)))
                                       (if (unsafe-procedure-call
                                            error?.111
                                            g42252649.33)
                                         g42252649.33
                                         (let ((g42252650.34
                                                (unsafe-procedure-call
                                                 vector-set!.110
                                                 tmp.7.28
                                                 5
                                                 6)))
                                           (if (unsafe-procedure-call
                                                error?.111
                                                g42252650.34)
                                             g42252650.34
                                             (let ((g42252651.35
                                                    (unsafe-procedure-call
                                                     vector-set!.110
                                                     tmp.7.28
                                                     6
                                                     7)))
                                               (if (unsafe-procedure-call
                                                    error?.111
                                                    g42252651.35)
                                                 g42252651.35
                                                 (let ((g42252652.36
                                                        (unsafe-procedure-call
                                                         vector-set!.110
                                                         tmp.7.28
                                                         7
                                                         8)))
                                                   (if (unsafe-procedure-call
                                                        error?.111
                                                        g42252652.36)
                                                     g42252652.36
                                                     tmp.7.28)))))))))))))))))))
              (void)))
         (if (if #t #\j #\G)
           (if (let ((g42252653.37
                      (let ((tmp.8.38 #\h)) (if tmp.8.38 tmp.8.38 #\H))))
                 (if (unsafe-procedure-call error?.111 g42252653.37)
                   g42252653.37
                   (let ((g42252654.39
                          (let ((pair0.41
                                 (unsafe-procedure-call
                                  cons.108
                                  222
                                  (unsafe-procedure-call cons.108 394 empty)))
                                (error1.40 (error 102)))
                            #\E)))
                     (if (unsafe-procedure-call error?.111 g42252654.39)
                       g42252654.39
                       (let ((g42252655.42
                              (let ((boolean0.45 #f)
                                    (void1.44 (void))
                                    (boolean2.43 #f))
                                #\s)))
                         (if (unsafe-procedure-call error?.111 g42252655.42)
                           g42252655.42
                           (let ((g42252656.46
                                  (let ((boolean0.49 #f)
                                        (pair1.48
                                         (unsafe-procedure-call
                                          cons.108
                                          165
                                          (unsafe-procedure-call
                                           cons.108
                                           270
                                           empty)))
                                        (fixnum2.47 165))
                                    #\k)))
                             (if (unsafe-procedure-call
                                  error?.111
                                  g42252656.46)
                               g42252656.46
                               (let ((g42252657.50
                                      (unsafe-procedure-call
                                       fun/ascii-char8494.14)))
                                 (if (unsafe-procedure-call
                                      error?.111
                                      g42252657.50)
                                   g42252657.50
                                   (let ((pair0.53
                                          (unsafe-procedure-call
                                           cons.108
                                           123
                                           (unsafe-procedure-call
                                            cons.108
                                            483
                                            empty)))
                                         (void1.52 (void))
                                         (void2.51 (void)))
                                     #\D)))))))))))
             (let () #\\)
             #f)
           #f)
         #f)
       (unsafe-procedure-call
        fun/void8495.12
        (unsafe-procedure-call
         fun/pair8497.11
         (unsafe-procedure-call fun/pair8498.16))
        (let ((empty0.55 empty) (ascii-char1.54 #\d)) (lambda () 530)))))))
(check-by-interp
 '(module
    (letrec ((error?.65 (lambda (tmp.55) (error? tmp.55)))
             (fun/empty8501.7 (lambda (oprand0.9 oprand1.8) empty)))
      (let ()
        (if (if #f empty empty)
          (if (let ((g42256477.10 empty))
                (if (unsafe-procedure-call error?.65 g42256477.10)
                  g42256477.10
                  (let ((g42256478.11 empty))
                    (if (unsafe-procedure-call error?.65 g42256478.11)
                      g42256478.11
                      (let ((g42256479.12 empty))
                        (if (unsafe-procedure-call error?.65 g42256479.12)
                          g42256479.12
                          empty))))))
            (unsafe-procedure-call fun/empty8501.7 136 (lambda () 643))
            #f)
          #f)))))
(check-by-interp
 '(module
    (let ((void0.9 (let () (void)))
          (procedure1.8 (lambda () (let () #t)))
          (boolean2.7 (let () #f)))
      (if (if #f #\n #\v) (if #\E (if #\a #\b #f) #f) #f))))
(check-by-interp
 '(module
    (letrec ((cons.62 (lambda (tmp.57 tmp.58) (cons tmp.57 tmp.58))))
      (let ((void0.7
             (let ((pair0.9
                    (unsafe-procedure-call
                     cons.62
                     107
                     (unsafe-procedure-call cons.62 481 empty)))
                   (boolean1.8 #t))
               (void))))
        (if #f 61 215)))))
(check-by-interp
 '(module
    (letrec ((fun/void8478.7 (lambda () (void)))
             (fun/void8477.8
              (lambda (oprand0.10) (unsafe-procedure-call fun/void8478.7)))
             (fun/ascii-char8479.9 (lambda (oprand0.11) #\F)))
      (let ()
        (unsafe-procedure-call
         fun/void8477.8
         (unsafe-procedure-call fun/ascii-char8479.9 111))))))
(check-by-interp
 '(module
    (letrec ((error?.69 (lambda (tmp.58) (error? tmp.58)))
             (<.68
              (lambda (tmp.36 tmp.37)
                (if (fixnum? tmp.37)
                  (if (fixnum? tmp.36) (unsafe-fx< tmp.36 tmp.37) (error 4))
                  (error 4))))
             (fun/error8483.7
              (lambda () (unsafe-procedure-call fun/error8484.8)))
             (fun/error8484.8 (lambda () (error 156)))
             (fun/error8482.9
              (lambda (oprand0.10) (unsafe-procedure-call fun/error8483.7))))
      (unsafe-procedure-call
       fun/error8482.9
       (if (unsafe-procedure-call <.68 248 54)
         (let ((g42302032.11 (void)))
           (if (unsafe-procedure-call error?.69 g42302032.11)
             g42302032.11
             (let ((g42302033.12 (void)))
               (if (unsafe-procedure-call error?.69 g42302033.12)
                 g42302033.12
                 (let ((g42302034.13 (void)))
                   (if (unsafe-procedure-call error?.69 g42302034.13)
                     g42302034.13
                     (let ((g42302035.14 (void)))
                       (if (unsafe-procedure-call error?.69 g42302035.14)
                         g42302035.14
                         (void)))))))))
         (let ((error0.15 (error 120))) (void)))))))
(check-by-interp
 '(module
    (letrec ((cons.90 (lambda (tmp.82 tmp.83) (cons tmp.82 tmp.83)))
             (error?.89 (lambda (tmp.77) (error? tmp.77)))
             (unsafe-vector-set!.5
              (lambda (tmp.41 tmp.42 tmp.43)
                (if (unsafe-fx< tmp.42 (unsafe-vector-length tmp.41))
                  (if (unsafe-fx>= tmp.42 0)
                    (begin (unsafe-vector-set! tmp.41 tmp.42 tmp.43) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.88
              (lambda (tmp.65 tmp.66 tmp.67)
                (if (fixnum? tmp.66)
                  (if (vector? tmp.65)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.65
                     tmp.66
                     tmp.67)
                    (error 10))
                  (error 10))))
             (vector-init-loop.37
              (lambda (len.38 i.40 vec.39)
                (if (eq? len.38 i.40)
                  vec.39
                  (begin
                    (unsafe-vector-set! vec.39 i.40 0)
                    (unsafe-procedure-call
                     vector-init-loop.37
                     len.38
                     (unsafe-fx+ i.40 1)
                     vec.39)))))
             (make-init-vector.4
              (lambda (tmp.35)
                (let ((tmp.36 (unsafe-make-vector tmp.35)))
                  (unsafe-procedure-call
                   vector-init-loop.37
                   tmp.35
                   0
                   tmp.36))))
             (make-vector.87
              (lambda (tmp.63)
                (if (fixnum? tmp.63)
                  (unsafe-procedure-call make-init-vector.4 tmp.63)
                  (error 8))))
             (fun/void8487.9 (lambda (oprand0.12 oprand1.11) oprand1.11))
             (fun/void8488.10
              (lambda (oprand0.13)
                (unsafe-procedure-call
                 vector-set!.88
                 oprand0.13
                 3
                 (let ((tmp.7.14 (unsafe-procedure-call make-vector.87 8)))
                   (let ((g42305850.15
                          (unsafe-procedure-call vector-set!.88 tmp.7.14 0 0)))
                     (if (unsafe-procedure-call error?.89 g42305850.15)
                       g42305850.15
                       (let ((g42305851.16
                              (unsafe-procedure-call
                               vector-set!.88
                               tmp.7.14
                               1
                               1)))
                         (if (unsafe-procedure-call error?.89 g42305851.16)
                           g42305851.16
                           (let ((g42305852.17
                                  (unsafe-procedure-call
                                   vector-set!.88
                                   tmp.7.14
                                   2
                                   2)))
                             (if (unsafe-procedure-call error?.89 g42305852.17)
                               g42305852.17
                               (let ((g42305853.18
                                      (unsafe-procedure-call
                                       vector-set!.88
                                       tmp.7.14
                                       3
                                       3)))
                                 (if (unsafe-procedure-call
                                      error?.89
                                      g42305853.18)
                                   g42305853.18
                                   (let ((g42305854.19
                                          (unsafe-procedure-call
                                           vector-set!.88
                                           tmp.7.14
                                           4
                                           4)))
                                     (if (unsafe-procedure-call
                                          error?.89
                                          g42305854.19)
                                       g42305854.19
                                       (let ((g42305855.20
                                              (unsafe-procedure-call
                                               vector-set!.88
                                               tmp.7.14
                                               5
                                               5)))
                                         (if (unsafe-procedure-call
                                              error?.89
                                              g42305855.20)
                                           g42305855.20
                                           (let ((g42305856.21
                                                  (unsafe-procedure-call
                                                   vector-set!.88
                                                   tmp.7.14
                                                   6
                                                   6)))
                                             (if (unsafe-procedure-call
                                                  error?.89
                                                  g42305856.21)
                                               g42305856.21
                                               (let ((g42305857.22
                                                      (unsafe-procedure-call
                                                       vector-set!.88
                                                       tmp.7.14
                                                       7
                                                       7)))
                                                 (if (unsafe-procedure-call
                                                      error?.89
                                                      g42305857.22)
                                                   g42305857.22
                                                   tmp.7.14)))))))))))))))))))))
      (let ()
        (if (let ((ascii-char0.25 #\j)
                  (empty1.24 empty)
                  (pair2.23
                   (unsafe-procedure-call
                    cons.90
                    146
                    (unsafe-procedure-call cons.90 308 empty))))
              (void))
          (if (unsafe-procedure-call fun/void8487.9 148 (void))
            (if (unsafe-procedure-call
                 fun/void8488.10
                 (let ((tmp.8.26 (unsafe-procedure-call make-vector.87 8)))
                   (let ((g42305858.27
                          (unsafe-procedure-call vector-set!.88 tmp.8.26 0 1)))
                     (if (unsafe-procedure-call error?.89 g42305858.27)
                       g42305858.27
                       (let ((g42305859.28
                              (unsafe-procedure-call
                               vector-set!.88
                               tmp.8.26
                               1
                               2)))
                         (if (unsafe-procedure-call error?.89 g42305859.28)
                           g42305859.28
                           (let ((g42305860.29
                                  (unsafe-procedure-call
                                   vector-set!.88
                                   tmp.8.26
                                   2
                                   3)))
                             (if (unsafe-procedure-call error?.89 g42305860.29)
                               g42305860.29
                               (let ((g42305861.30
                                      (unsafe-procedure-call
                                       vector-set!.88
                                       tmp.8.26
                                       3
                                       4)))
                                 (if (unsafe-procedure-call
                                      error?.89
                                      g42305861.30)
                                   g42305861.30
                                   (let ((g42305862.31
                                          (unsafe-procedure-call
                                           vector-set!.88
                                           tmp.8.26
                                           4
                                           5)))
                                     (if (unsafe-procedure-call
                                          error?.89
                                          g42305862.31)
                                       g42305862.31
                                       (let ((g42305863.32
                                              (unsafe-procedure-call
                                               vector-set!.88
                                               tmp.8.26
                                               5
                                               6)))
                                         (if (unsafe-procedure-call
                                              error?.89
                                              g42305863.32)
                                           g42305863.32
                                           (let ((g42305864.33
                                                  (unsafe-procedure-call
                                                   vector-set!.88
                                                   tmp.8.26
                                                   6
                                                   7)))
                                             (if (unsafe-procedure-call
                                                  error?.89
                                                  g42305864.33)
                                               g42305864.33
                                               (let ((g42305865.34
                                                      (unsafe-procedure-call
                                                       vector-set!.88
                                                       tmp.8.26
                                                       7
                                                       8)))
                                                 (if (unsafe-procedure-call
                                                      error?.89
                                                      g42305865.34)
                                                   g42305865.34
                                                   tmp.8.26))))))))))))))))))
              (if #t (void) (void))
              #f)
            #f)
          #f)))))
(check-by-interp
 '(module
    (letrec ((fun/empty8491.7
              (lambda (oprand0.11 oprand1.10)
                (let () (unsafe-procedure-call fun/empty8492.8))))
             (fun/empty8492.8 (lambda () empty))
             (fun/error8493.9 (lambda (oprand0.13 oprand1.12) (error 123))))
      (unsafe-procedure-call
       fun/empty8491.7
       (let ((error0.14 (if #t (error 178) (error 194))))
         (if (void) (if (void) (if (void) (void) #f) #f) #f))
       (if (let () #t)
         (let () (error 47))
         (unsafe-procedure-call fun/error8493.9 #t #t))))))
(check-by-interp
 '(module
    (letrec ((error?.142 (lambda (tmp.129) (error? tmp.129)))
             (vector-init-loop.89
              (lambda (len.90 i.92 vec.91)
                (if (eq? len.90 i.92)
                  vec.91
                  (begin
                    (unsafe-vector-set! vec.91 i.92 0)
                    (unsafe-procedure-call
                     vector-init-loop.89
                     len.90
                     (unsafe-fx+ i.92 1)
                     vec.91)))))
             (make-init-vector.4
              (lambda (tmp.87)
                (let ((tmp.88 (unsafe-make-vector tmp.87)))
                  (unsafe-procedure-call
                   vector-init-loop.89
                   tmp.87
                   0
                   tmp.88))))
             (make-vector.141
              (lambda (tmp.115)
                (if (fixnum? tmp.115)
                  (unsafe-procedure-call make-init-vector.4 tmp.115)
                  (error 8))))
             (unsafe-vector-set!.5
              (lambda (tmp.93 tmp.94 tmp.95)
                (if (unsafe-fx< tmp.94 (unsafe-vector-length tmp.93))
                  (if (unsafe-fx>= tmp.94 0)
                    (begin (unsafe-vector-set! tmp.93 tmp.94 tmp.95) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.140
              (lambda (tmp.117 tmp.118 tmp.119)
                (if (fixnum? tmp.118)
                  (if (vector? tmp.117)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.117
                     tmp.118
                     tmp.119)
                    (error 10))
                  (error 10))))
             (cons.139 (lambda (tmp.134 tmp.135) (cons tmp.134 tmp.135)))
             (fun/pair8504.16
              (lambda (oprand0.26 oprand1.25)
                (unsafe-procedure-call
                 cons.139
                 175
                 (unsafe-procedure-call cons.139 296 empty))))
             (fun/void8499.17 (lambda (oprand0.27) (void)))
             (fun/void8501.18
              (lambda (oprand0.29 oprand1.28)
                (unsafe-procedure-call vector-set!.140 oprand0.29 5 #\I)))
             (fun/void8498.19 (lambda () (void)))
             (fun/fixnum8502.20 (lambda (oprand0.30) (let () 229)))
             (fun/pair8503.21
              (lambda ()
                (unsafe-procedure-call
                 cons.139
                 187
                 (unsafe-procedure-call cons.139 408 empty))))
             (fun/void8497.22 (lambda (oprand0.32 oprand1.31) (let () (void))))
             (fun/void8500.23 (lambda (oprand0.33) (void)))
             (fun/fixnum8496.24
              (lambda (oprand0.35 oprand1.34) (let () (if #t 39 232)))))
      (unsafe-procedure-call
       fun/fixnum8496.24
       (if (unsafe-procedure-call
            fun/void8497.22
            (if #f 182 177)
            (if #f
              (unsafe-procedure-call
               cons.139
               128
               (unsafe-procedure-call cons.139 289 empty))
              (unsafe-procedure-call
               cons.139
               177
               (unsafe-procedure-call cons.139 385 empty))))
         (if (if #f (void) (void))
           (if (let ((procedure0.38
                      (lambda ()
                        (unsafe-procedure-call
                         cons.139
                         6
                         (unsafe-procedure-call cons.139 507 empty))))
                     (ascii-char1.37 #\M)
                     (fixnum2.36 199))
                 (void))
             (if (if #f (void) (void))
               (if (let ((empty0.40 empty)
                         (procedure1.39
                          (lambda ()
                            (let ((tmp.7.41
                                   (unsafe-procedure-call make-vector.141 8)))
                              (let ((g42328608.42
                                     (unsafe-procedure-call
                                      vector-set!.140
                                      tmp.7.41
                                      0
                                      1)))
                                (if (unsafe-procedure-call
                                     error?.142
                                     g42328608.42)
                                  g42328608.42
                                  (let ((g42328609.43
                                         (unsafe-procedure-call
                                          vector-set!.140
                                          tmp.7.41
                                          1
                                          2)))
                                    (if (unsafe-procedure-call
                                         error?.142
                                         g42328609.43)
                                      g42328609.43
                                      (let ((g42328610.44
                                             (unsafe-procedure-call
                                              vector-set!.140
                                              tmp.7.41
                                              2
                                              3)))
                                        (if (unsafe-procedure-call
                                             error?.142
                                             g42328610.44)
                                          g42328610.44
                                          (let ((g42328611.45
                                                 (unsafe-procedure-call
                                                  vector-set!.140
                                                  tmp.7.41
                                                  3
                                                  4)))
                                            (if (unsafe-procedure-call
                                                 error?.142
                                                 g42328611.45)
                                              g42328611.45
                                              (let ((g42328612.46
                                                     (unsafe-procedure-call
                                                      vector-set!.140
                                                      tmp.7.41
                                                      4
                                                      5)))
                                                (if (unsafe-procedure-call
                                                     error?.142
                                                     g42328612.46)
                                                  g42328612.46
                                                  (let ((g42328613.47
                                                         (unsafe-procedure-call
                                                          vector-set!.140
                                                          tmp.7.41
                                                          5
                                                          6)))
                                                    (if (unsafe-procedure-call
                                                         error?.142
                                                         g42328613.47)
                                                      g42328613.47
                                                      (let ((g42328614.48
                                                             (unsafe-procedure-call
                                                              vector-set!.140
                                                              tmp.7.41
                                                              6
                                                              7)))
                                                        (if (unsafe-procedure-call
                                                             error?.142
                                                             g42328614.48)
                                                          g42328614.48
                                                          (let ((g42328615.49
                                                                 (unsafe-procedure-call
                                                                  vector-set!.140
                                                                  tmp.7.41
                                                                  7
                                                                  8)))
                                                            (if (unsafe-procedure-call
                                                                 error?.142
                                                                 g42328615.49)
                                                              g42328615.49
                                                              tmp.7.41))))))))))))))))))))
                     (void))
                 (let ((tmp.8.50 (if #t (void) (void))))
                   (if tmp.8.50
                     tmp.8.50
                     (let ((tmp.9.51 (void)))
                       (if tmp.9.51
                         tmp.9.51
                         (let ((tmp.10.52
                                (let ((boolean0.55 #t)
                                      (error1.54 (error 35))
                                      (procedure2.53 (lambda () empty)))
                                  (void))))
                           (if tmp.10.52
                             tmp.10.52
                             (let ((tmp.11.56
                                    (unsafe-procedure-call fun/void8498.19)))
                               (if tmp.11.56
                                 tmp.11.56
                                 (let ((tmp.12.57
                                        (unsafe-procedure-call
                                         fun/void8499.17
                                         (error 96))))
                                   (if tmp.12.57
                                     tmp.12.57
                                     (let ((tmp.13.58
                                            (unsafe-procedure-call
                                             fun/void8500.23
                                             #f)))
                                       (if tmp.13.58
                                         tmp.13.58
                                         (unsafe-procedure-call
                                          fun/void8501.18
                                          (let ((tmp.14.59
                                                 (unsafe-procedure-call
                                                  make-vector.141
                                                  8)))
                                            (let ((g42328616.60
                                                   (unsafe-procedure-call
                                                    vector-set!.140
                                                    tmp.14.59
                                                    0
                                                    1)))
                                              (if (unsafe-procedure-call
                                                   error?.142
                                                   g42328616.60)
                                                g42328616.60
                                                (let ((g42328617.61
                                                       (unsafe-procedure-call
                                                        vector-set!.140
                                                        tmp.14.59
                                                        1
                                                        2)))
                                                  (if (unsafe-procedure-call
                                                       error?.142
                                                       g42328617.61)
                                                    g42328617.61
                                                    (let ((g42328618.62
                                                           (unsafe-procedure-call
                                                            vector-set!.140
                                                            tmp.14.59
                                                            2
                                                            3)))
                                                      (if (unsafe-procedure-call
                                                           error?.142
                                                           g42328618.62)
                                                        g42328618.62
                                                        (let ((g42328619.63
                                                               (unsafe-procedure-call
                                                                vector-set!.140
                                                                tmp.14.59
                                                                3
                                                                4)))
                                                          (if (unsafe-procedure-call
                                                               error?.142
                                                               g42328619.63)
                                                            g42328619.63
                                                            (let ((g42328620.64
                                                                   (unsafe-procedure-call
                                                                    vector-set!.140
                                                                    tmp.14.59
                                                                    4
                                                                    5)))
                                                              (if (unsafe-procedure-call
                                                                   error?.142
                                                                   g42328620.64)
                                                                g42328620.64
                                                                (let ((g42328621.65
                                                                       (unsafe-procedure-call
                                                                        vector-set!.140
                                                                        tmp.14.59
                                                                        5
                                                                        6)))
                                                                  (if (unsafe-procedure-call
                                                                       error?.142
                                                                       g42328621.65)
                                                                    g42328621.65
                                                                    (let ((g42328622.66
                                                                           (unsafe-procedure-call
                                                                            vector-set!.140
                                                                            tmp.14.59
                                                                            6
                                                                            7)))
                                                                      (if (unsafe-procedure-call
                                                                           error?.142
                                                                           g42328622.66)
                                                                        g42328622.66
                                                                        (let ((g42328623.67
                                                                               (unsafe-procedure-call
                                                                                vector-set!.140
                                                                                tmp.14.59
                                                                                7
                                                                                8)))
                                                                          (if (unsafe-procedure-call
                                                                               error?.142
                                                                               g42328623.67)
                                                                            g42328623.67
                                                                            tmp.14.59)))))))))))))))))
                                          (error 127))))))))))))))
                 #f)
               #f)
             #f)
           #f)
         #f)
       (unsafe-procedure-call
        fun/fixnum8502.20
        (let ((g42328624.68
               (unsafe-procedure-call
                cons.139
                234
                (unsafe-procedure-call cons.139 272 empty))))
          (if (unsafe-procedure-call error?.142 g42328624.68)
            g42328624.68
            (let ((g42328625.69
                   (let ((error0.72 (error 104))
                         (procedure1.71
                          (lambda ()
                            (let ((tmp.15.73
                                   (unsafe-procedure-call make-vector.141 8)))
                              (let ((g42328626.74
                                     (unsafe-procedure-call
                                      vector-set!.140
                                      tmp.15.73
                                      0
                                      0)))
                                (if (unsafe-procedure-call
                                     error?.142
                                     g42328626.74)
                                  g42328626.74
                                  (let ((g42328627.75
                                         (unsafe-procedure-call
                                          vector-set!.140
                                          tmp.15.73
                                          1
                                          1)))
                                    (if (unsafe-procedure-call
                                         error?.142
                                         g42328627.75)
                                      g42328627.75
                                      (let ((g42328628.76
                                             (unsafe-procedure-call
                                              vector-set!.140
                                              tmp.15.73
                                              2
                                              2)))
                                        (if (unsafe-procedure-call
                                             error?.142
                                             g42328628.76)
                                          g42328628.76
                                          (let ((g42328629.77
                                                 (unsafe-procedure-call
                                                  vector-set!.140
                                                  tmp.15.73
                                                  3
                                                  3)))
                                            (if (unsafe-procedure-call
                                                 error?.142
                                                 g42328629.77)
                                              g42328629.77
                                              (let ((g42328630.78
                                                     (unsafe-procedure-call
                                                      vector-set!.140
                                                      tmp.15.73
                                                      4
                                                      4)))
                                                (if (unsafe-procedure-call
                                                     error?.142
                                                     g42328630.78)
                                                  g42328630.78
                                                  (let ((g42328631.79
                                                         (unsafe-procedure-call
                                                          vector-set!.140
                                                          tmp.15.73
                                                          5
                                                          5)))
                                                    (if (unsafe-procedure-call
                                                         error?.142
                                                         g42328631.79)
                                                      g42328631.79
                                                      (let ((g42328632.80
                                                             (unsafe-procedure-call
                                                              vector-set!.140
                                                              tmp.15.73
                                                              6
                                                              6)))
                                                        (if (unsafe-procedure-call
                                                             error?.142
                                                             g42328632.80)
                                                          g42328632.80
                                                          (let ((g42328633.81
                                                                 (unsafe-procedure-call
                                                                  vector-set!.140
                                                                  tmp.15.73
                                                                  7
                                                                  7)))
                                                            (if (unsafe-procedure-call
                                                                 error?.142
                                                                 g42328633.81)
                                                              g42328633.81
                                                              tmp.15.73)))))))))))))))))))
                         (ascii-char2.70 #\M))
                     (unsafe-procedure-call
                      cons.139
                      43
                      (unsafe-procedure-call cons.139 459 empty)))))
              (if (unsafe-procedure-call error?.142 g42328625.69)
                g42328625.69
                (let ((g42328634.82
                       (unsafe-procedure-call
                        cons.139
                        92
                        (unsafe-procedure-call cons.139 487 empty))))
                  (if (unsafe-procedure-call error?.142 g42328634.82)
                    g42328634.82
                    (let ((g42328635.83
                           (let ((g42328636.84
                                  (unsafe-procedure-call
                                   cons.139
                                   23
                                   (unsafe-procedure-call
                                    cons.139
                                    399
                                    empty))))
                             (if (unsafe-procedure-call
                                  error?.142
                                  g42328636.84)
                               g42328636.84
                               (unsafe-procedure-call
                                cons.139
                                163
                                (unsafe-procedure-call cons.139 314 empty))))))
                      (if (unsafe-procedure-call error?.142 g42328635.83)
                        g42328635.83
                        (let ((g42328637.85
                               (unsafe-procedure-call fun/pair8503.21)))
                          (if (unsafe-procedure-call error?.142 g42328637.85)
                            g42328637.85
                            (let ((g42328638.86
                                   (if #t
                                     (unsafe-procedure-call
                                      cons.139
                                      59
                                      (unsafe-procedure-call
                                       cons.139
                                       331
                                       empty))
                                     (unsafe-procedure-call
                                      cons.139
                                      18
                                      (unsafe-procedure-call
                                       cons.139
                                       310
                                       empty)))))
                              (if (unsafe-procedure-call
                                   error?.142
                                   g42328638.86)
                                g42328638.86
                                (unsafe-procedure-call
                                 fun/pair8504.16
                                 (void)
                                 (lambda () 998)))))))))))))))))))
(check-by-interp
 '(module
    (letrec ((error?.95 (lambda (tmp.81) (error? tmp.81)))
             (unsafe-vector-set!.5
              (lambda (tmp.45 tmp.46 tmp.47)
                (if (unsafe-fx< tmp.46 (unsafe-vector-length tmp.45))
                  (if (unsafe-fx>= tmp.46 0)
                    (begin (unsafe-vector-set! tmp.45 tmp.46 tmp.47) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.94
              (lambda (tmp.69 tmp.70 tmp.71)
                (if (fixnum? tmp.70)
                  (if (vector? tmp.69)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.69
                     tmp.70
                     tmp.71)
                    (error 10))
                  (error 10))))
             (vector-init-loop.41
              (lambda (len.42 i.44 vec.43)
                (if (eq? len.42 i.44)
                  vec.43
                  (begin
                    (unsafe-vector-set! vec.43 i.44 0)
                    (unsafe-procedure-call
                     vector-init-loop.41
                     len.42
                     (unsafe-fx+ i.44 1)
                     vec.43)))))
             (make-init-vector.4
              (lambda (tmp.39)
                (let ((tmp.40 (unsafe-make-vector tmp.39)))
                  (unsafe-procedure-call
                   vector-init-loop.41
                   tmp.39
                   0
                   tmp.40))))
             (make-vector.93
              (lambda (tmp.67)
                (if (fixnum? tmp.67)
                  (unsafe-procedure-call make-init-vector.4 tmp.67)
                  (error 8))))
             (<.92
              (lambda (tmp.59 tmp.60)
                (if (fixnum? tmp.60)
                  (if (fixnum? tmp.59) (unsafe-fx< tmp.59 tmp.60) (error 4))
                  (error 4))))
             (cons.91 (lambda (tmp.86 tmp.87) (cons tmp.86 tmp.87)))
             (fun/empty8510.8 (lambda (oprand0.17 oprand1.16) empty))
             (fun/empty8513.9
              (lambda (oprand0.18) (unsafe-procedure-call fun/empty8514.10)))
             (fun/empty8514.10 (lambda () empty))
             (fun/fixnum8507.11
              (lambda (oprand0.20 oprand1.19)
                (if (if #t #t #f)
                  (unsafe-procedure-call fun/fixnum8508.15)
                  (unsafe-procedure-call fun/fixnum8509.14))))
             (fun/empty8511.12 (lambda (oprand0.22 oprand1.21) empty))
             (fun/empty8512.13 (lambda () empty))
             (fun/fixnum8509.14 (lambda () 4))
             (fun/fixnum8508.15 (lambda () 17)))
      (unsafe-procedure-call
       fun/fixnum8507.11
       (if (if (unsafe-procedure-call
                fun/empty8510.8
                (error 189)
                (unsafe-procedure-call
                 cons.91
                 54
                 (unsafe-procedure-call cons.91 464 empty)))
             (if (unsafe-procedure-call fun/empty8511.12 #t 41)
               (if (if #f empty empty)
                 (if (unsafe-procedure-call fun/empty8512.13)
                   (if (let ((error0.24 (error 217)) (boolean1.23 #t)) empty)
                     (let () empty)
                     #f)
                   #f)
                 #f)
               #f)
             #f)
         (unsafe-procedure-call
          fun/empty8513.9
          (if #t (lambda () 622) (lambda () 523)))
         #f)
       (if (unsafe-procedure-call <.92 93 14)
         (let ((boolean0.27 #t)
               (vector1.26
                (let ((tmp.7.28 (unsafe-procedure-call make-vector.93 8)))
                  (let ((g42336237.29
                         (unsafe-procedure-call vector-set!.94 tmp.7.28 0 1)))
                    (if (unsafe-procedure-call error?.95 g42336237.29)
                      g42336237.29
                      (let ((g42336238.30
                             (unsafe-procedure-call
                              vector-set!.94
                              tmp.7.28
                              1
                              2)))
                        (if (unsafe-procedure-call error?.95 g42336238.30)
                          g42336238.30
                          (let ((g42336239.31
                                 (unsafe-procedure-call
                                  vector-set!.94
                                  tmp.7.28
                                  2
                                  3)))
                            (if (unsafe-procedure-call error?.95 g42336239.31)
                              g42336239.31
                              (let ((g42336240.32
                                     (unsafe-procedure-call
                                      vector-set!.94
                                      tmp.7.28
                                      3
                                      4)))
                                (if (unsafe-procedure-call
                                     error?.95
                                     g42336240.32)
                                  g42336240.32
                                  (let ((g42336241.33
                                         (unsafe-procedure-call
                                          vector-set!.94
                                          tmp.7.28
                                          4
                                          5)))
                                    (if (unsafe-procedure-call
                                         error?.95
                                         g42336241.33)
                                      g42336241.33
                                      (let ((g42336242.34
                                             (unsafe-procedure-call
                                              vector-set!.94
                                              tmp.7.28
                                              5
                                              6)))
                                        (if (unsafe-procedure-call
                                             error?.95
                                             g42336242.34)
                                          g42336242.34
                                          (let ((g42336243.35
                                                 (unsafe-procedure-call
                                                  vector-set!.94
                                                  tmp.7.28
                                                  6
                                                  7)))
                                            (if (unsafe-procedure-call
                                                 error?.95
                                                 g42336243.35)
                                              g42336243.35
                                              (let ((g42336244.36
                                                     (unsafe-procedure-call
                                                      vector-set!.94
                                                      tmp.7.28
                                                      7
                                                      8)))
                                                (if (unsafe-procedure-call
                                                     error?.95
                                                     g42336244.36)
                                                  g42336244.36
                                                  tmp.7.28))))))))))))))))))
               (boolean2.25 #f))
           (void))
         (let ((empty0.38 empty) (empty1.37 empty)) (void)))))))
(check-by-interp
 '(module
    (letrec ((error?.76 (lambda (tmp.64) (error? tmp.64)))
             (unsafe-vector-set!.5
              (lambda (tmp.28 tmp.29 tmp.30)
                (if (unsafe-fx< tmp.29 (unsafe-vector-length tmp.28))
                  (if (unsafe-fx>= tmp.29 0)
                    (begin (unsafe-vector-set! tmp.28 tmp.29 tmp.30) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.75
              (lambda (tmp.52 tmp.53 tmp.54)
                (if (fixnum? tmp.53)
                  (if (vector? tmp.52)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.52
                     tmp.53
                     tmp.54)
                    (error 10))
                  (error 10))))
             (vector-init-loop.24
              (lambda (len.25 i.27 vec.26)
                (if (eq? len.25 i.27)
                  vec.26
                  (begin
                    (unsafe-vector-set! vec.26 i.27 0)
                    (unsafe-procedure-call
                     vector-init-loop.24
                     len.25
                     (unsafe-fx+ i.27 1)
                     vec.26)))))
             (make-init-vector.4
              (lambda (tmp.22)
                (let ((tmp.23 (unsafe-make-vector tmp.22)))
                  (unsafe-procedure-call
                   vector-init-loop.24
                   tmp.22
                   0
                   tmp.23))))
             (make-vector.74
              (lambda (tmp.50)
                (if (fixnum? tmp.50)
                  (unsafe-procedure-call make-init-vector.4 tmp.50)
                  (error 8))))
             (fun/boolean8517.8 (lambda (oprand0.9) #f)))
      (if (unsafe-procedure-call fun/boolean8517.8 (lambda () 918))
        #\L
        (let ((vector0.12
               (let ((tmp.7.13 (unsafe-procedure-call make-vector.74 8)))
                 (let ((g42343841.14
                        (unsafe-procedure-call vector-set!.75 tmp.7.13 0 1)))
                   (if (unsafe-procedure-call error?.76 g42343841.14)
                     g42343841.14
                     (let ((g42343842.15
                            (unsafe-procedure-call
                             vector-set!.75
                             tmp.7.13
                             1
                             2)))
                       (if (unsafe-procedure-call error?.76 g42343842.15)
                         g42343842.15
                         (let ((g42343843.16
                                (unsafe-procedure-call
                                 vector-set!.75
                                 tmp.7.13
                                 2
                                 3)))
                           (if (unsafe-procedure-call error?.76 g42343843.16)
                             g42343843.16
                             (let ((g42343844.17
                                    (unsafe-procedure-call
                                     vector-set!.75
                                     tmp.7.13
                                     3
                                     4)))
                               (if (unsafe-procedure-call
                                    error?.76
                                    g42343844.17)
                                 g42343844.17
                                 (let ((g42343845.18
                                        (unsafe-procedure-call
                                         vector-set!.75
                                         tmp.7.13
                                         4
                                         5)))
                                   (if (unsafe-procedure-call
                                        error?.76
                                        g42343845.18)
                                     g42343845.18
                                     (let ((g42343846.19
                                            (unsafe-procedure-call
                                             vector-set!.75
                                             tmp.7.13
                                             5
                                             6)))
                                       (if (unsafe-procedure-call
                                            error?.76
                                            g42343846.19)
                                         g42343846.19
                                         (let ((g42343847.20
                                                (unsafe-procedure-call
                                                 vector-set!.75
                                                 tmp.7.13
                                                 6
                                                 7)))
                                           (if (unsafe-procedure-call
                                                error?.76
                                                g42343847.20)
                                             g42343847.20
                                             (let ((g42343848.21
                                                    (unsafe-procedure-call
                                                     vector-set!.75
                                                     tmp.7.13
                                                     7
                                                     8)))
                                               (if (unsafe-procedure-call
                                                    error?.76
                                                    g42343848.21)
                                                 g42343848.21
                                                 tmp.7.13))))))))))))))))))
              (void1.11 (void))
              (boolean2.10 #f))
          #\v)))))
(check-by-interp
 '(module
    (letrec ((*.80
              (lambda (tmp.38 tmp.39)
                (if (fixnum? tmp.39)
                  (if (fixnum? tmp.38) (unsafe-fx* tmp.38 tmp.39) (error 1))
                  (error 1))))
             (cons.79 (lambda (tmp.71 tmp.72) (cons tmp.71 tmp.72)))
             (error?.78 (lambda (tmp.66) (error? tmp.66)))
             (unsafe-vector-set!.5
              (lambda (tmp.30 tmp.31 tmp.32)
                (if (unsafe-fx< tmp.31 (unsafe-vector-length tmp.30))
                  (if (unsafe-fx>= tmp.31 0)
                    (begin (unsafe-vector-set! tmp.30 tmp.31 tmp.32) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.77
              (lambda (tmp.54 tmp.55 tmp.56)
                (if (fixnum? tmp.55)
                  (if (vector? tmp.54)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.54
                     tmp.55
                     tmp.56)
                    (error 10))
                  (error 10))))
             (vector-init-loop.26
              (lambda (len.27 i.29 vec.28)
                (if (eq? len.27 i.29)
                  vec.28
                  (begin
                    (unsafe-vector-set! vec.28 i.29 0)
                    (unsafe-procedure-call
                     vector-init-loop.26
                     len.27
                     (unsafe-fx+ i.29 1)
                     vec.28)))))
             (make-init-vector.4
              (lambda (tmp.24)
                (let ((tmp.25 (unsafe-make-vector tmp.24)))
                  (unsafe-procedure-call
                   vector-init-loop.26
                   tmp.24
                   0
                   tmp.25))))
             (make-vector.76
              (lambda (tmp.52)
                (if (fixnum? tmp.52)
                  (unsafe-procedure-call make-init-vector.4 tmp.52)
                  (error 8))))
             (fun/vector8521.8
              (lambda (oprand0.11 oprand1.10) (if #f oprand0.11 oprand0.11)))
             (fun/fixnum8520.9 (lambda (oprand0.12) (let () 69))))
      (unsafe-procedure-call
       *.80
       (unsafe-procedure-call
        fun/fixnum8520.9
        (unsafe-procedure-call
         fun/vector8521.8
         (let ()
           (let ((tmp.7.13 (unsafe-procedure-call make-vector.76 8)))
             (let ((g42347666.14
                    (unsafe-procedure-call vector-set!.77 tmp.7.13 0 1)))
               (if (unsafe-procedure-call error?.78 g42347666.14)
                 g42347666.14
                 (let ((g42347667.15
                        (unsafe-procedure-call vector-set!.77 tmp.7.13 1 2)))
                   (if (unsafe-procedure-call error?.78 g42347667.15)
                     g42347667.15
                     (let ((g42347668.16
                            (unsafe-procedure-call
                             vector-set!.77
                             tmp.7.13
                             2
                             3)))
                       (if (unsafe-procedure-call error?.78 g42347668.16)
                         g42347668.16
                         (let ((g42347669.17
                                (unsafe-procedure-call
                                 vector-set!.77
                                 tmp.7.13
                                 3
                                 4)))
                           (if (unsafe-procedure-call error?.78 g42347669.17)
                             g42347669.17
                             (let ((g42347670.18
                                    (unsafe-procedure-call
                                     vector-set!.77
                                     tmp.7.13
                                     4
                                     5)))
                               (if (unsafe-procedure-call
                                    error?.78
                                    g42347670.18)
                                 g42347670.18
                                 (let ((g42347671.19
                                        (unsafe-procedure-call
                                         vector-set!.77
                                         tmp.7.13
                                         5
                                         6)))
                                   (if (unsafe-procedure-call
                                        error?.78
                                        g42347671.19)
                                     g42347671.19
                                     (let ((g42347672.20
                                            (unsafe-procedure-call
                                             vector-set!.77
                                             tmp.7.13
                                             6
                                             7)))
                                       (if (unsafe-procedure-call
                                            error?.78
                                            g42347672.20)
                                         g42347672.20
                                         (let ((g42347673.21
                                                (unsafe-procedure-call
                                                 vector-set!.77
                                                 tmp.7.13
                                                 7
                                                 8)))
                                           (if (unsafe-procedure-call
                                                error?.78
                                                g42347673.21)
                                             g42347673.21
                                             tmp.7.13))))))))))))))))))
         (if #f
           (unsafe-procedure-call
            cons.79
            25
            (unsafe-procedure-call cons.79 278 empty))
           (unsafe-procedure-call
            cons.79
            168
            (unsafe-procedure-call cons.79 487 empty)))))
       (if (let () #f)
         (let ((g42347674.22 232))
           (if (unsafe-procedure-call error?.78 g42347674.22)
             g42347674.22
             (let ((g42347675.23 165))
               (if (unsafe-procedure-call error?.78 g42347675.23)
                 g42347675.23
                 174))))
         (if #f 106 28))))))
(check-by-interp
 '(module
    (letrec ((fun/fixnum8525.7
              (lambda () (unsafe-procedure-call fun/fixnum8526.9)))
             (fun/empty8524.8 (lambda () (if #f empty empty)))
             (fun/fixnum8526.9 (lambda () 54)))
      (let ((empty0.11 (unsafe-procedure-call fun/empty8524.8))
            (ascii-char1.10 (if #f #\P #\J)))
        (unsafe-procedure-call fun/fixnum8525.7)))))
(check-by-interp
 '(module
    (letrec ((fun/fixnum8529.7 (lambda (oprand0.10 oprand1.9) (let () 49)))
             (fun/fixnum8530.8 (lambda () 148)))
      (if (let () #f)
        (unsafe-procedure-call
         fun/fixnum8529.7
         (let ((ascii-char0.11 #\v)) (error 22))
         (unsafe-procedure-call fun/fixnum8530.8))
        (if #t 68 222)))))
(check-by-interp
 '(module
    (letrec ((error?.89 (lambda (tmp.77) (error? tmp.77)))
             (unsafe-vector-set!.5
              (lambda (tmp.41 tmp.42 tmp.43)
                (if (unsafe-fx< tmp.42 (unsafe-vector-length tmp.41))
                  (if (unsafe-fx>= tmp.42 0)
                    (begin (unsafe-vector-set! tmp.41 tmp.42 tmp.43) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.88
              (lambda (tmp.65 tmp.66 tmp.67)
                (if (fixnum? tmp.66)
                  (if (vector? tmp.65)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.65
                     tmp.66
                     tmp.67)
                    (error 10))
                  (error 10))))
             (vector-init-loop.37
              (lambda (len.38 i.40 vec.39)
                (if (eq? len.38 i.40)
                  vec.39
                  (begin
                    (unsafe-vector-set! vec.39 i.40 0)
                    (unsafe-procedure-call
                     vector-init-loop.37
                     len.38
                     (unsafe-fx+ i.40 1)
                     vec.39)))))
             (make-init-vector.4
              (lambda (tmp.35)
                (let ((tmp.36 (unsafe-make-vector tmp.35)))
                  (unsafe-procedure-call
                   vector-init-loop.37
                   tmp.35
                   0
                   tmp.36))))
             (make-vector.87
              (lambda (tmp.63)
                (if (fixnum? tmp.63)
                  (unsafe-procedure-call make-init-vector.4 tmp.63)
                  (error 8))))
             (fun/void8536.9 (lambda () (void)))
             (fun/empty8533.10
              (lambda (oprand0.13) (unsafe-procedure-call fun/empty8534.11)))
             (fun/empty8534.11 (lambda () (if #t empty empty)))
             (fun/ascii-char8535.12 (lambda () #\V)))
      (unsafe-procedure-call
       fun/empty8533.10
       (let ((ascii-char0.16 (unsafe-procedure-call fun/ascii-char8535.12))
             (void1.15 (if #t (void) (void)))
             (void2.14 (unsafe-procedure-call fun/void8536.9)))
         (if #f
           (let ((tmp.7.17 (unsafe-procedure-call make-vector.87 8)))
             (let ((g42366676.18
                    (unsafe-procedure-call vector-set!.88 tmp.7.17 0 1)))
               (if (unsafe-procedure-call error?.89 g42366676.18)
                 g42366676.18
                 (let ((g42366677.19
                        (unsafe-procedure-call vector-set!.88 tmp.7.17 1 2)))
                   (if (unsafe-procedure-call error?.89 g42366677.19)
                     g42366677.19
                     (let ((g42366678.20
                            (unsafe-procedure-call
                             vector-set!.88
                             tmp.7.17
                             2
                             3)))
                       (if (unsafe-procedure-call error?.89 g42366678.20)
                         g42366678.20
                         (let ((g42366679.21
                                (unsafe-procedure-call
                                 vector-set!.88
                                 tmp.7.17
                                 3
                                 4)))
                           (if (unsafe-procedure-call error?.89 g42366679.21)
                             g42366679.21
                             (let ((g42366680.22
                                    (unsafe-procedure-call
                                     vector-set!.88
                                     tmp.7.17
                                     4
                                     5)))
                               (if (unsafe-procedure-call
                                    error?.89
                                    g42366680.22)
                                 g42366680.22
                                 (let ((g42366681.23
                                        (unsafe-procedure-call
                                         vector-set!.88
                                         tmp.7.17
                                         5
                                         6)))
                                   (if (unsafe-procedure-call
                                        error?.89
                                        g42366681.23)
                                     g42366681.23
                                     (let ((g42366682.24
                                            (unsafe-procedure-call
                                             vector-set!.88
                                             tmp.7.17
                                             6
                                             7)))
                                       (if (unsafe-procedure-call
                                            error?.89
                                            g42366682.24)
                                         g42366682.24
                                         (let ((g42366683.25
                                                (unsafe-procedure-call
                                                 vector-set!.88
                                                 tmp.7.17
                                                 7
                                                 8)))
                                           (if (unsafe-procedure-call
                                                error?.89
                                                g42366683.25)
                                             g42366683.25
                                             tmp.7.17)))))))))))))))))
           (let ((tmp.8.26 (unsafe-procedure-call make-vector.87 8)))
             (let ((g42366684.27
                    (unsafe-procedure-call vector-set!.88 tmp.8.26 0 1)))
               (if (unsafe-procedure-call error?.89 g42366684.27)
                 g42366684.27
                 (let ((g42366685.28
                        (unsafe-procedure-call vector-set!.88 tmp.8.26 1 2)))
                   (if (unsafe-procedure-call error?.89 g42366685.28)
                     g42366685.28
                     (let ((g42366686.29
                            (unsafe-procedure-call
                             vector-set!.88
                             tmp.8.26
                             2
                             3)))
                       (if (unsafe-procedure-call error?.89 g42366686.29)
                         g42366686.29
                         (let ((g42366687.30
                                (unsafe-procedure-call
                                 vector-set!.88
                                 tmp.8.26
                                 3
                                 4)))
                           (if (unsafe-procedure-call error?.89 g42366687.30)
                             g42366687.30
                             (let ((g42366688.31
                                    (unsafe-procedure-call
                                     vector-set!.88
                                     tmp.8.26
                                     4
                                     5)))
                               (if (unsafe-procedure-call
                                    error?.89
                                    g42366688.31)
                                 g42366688.31
                                 (let ((g42366689.32
                                        (unsafe-procedure-call
                                         vector-set!.88
                                         tmp.8.26
                                         5
                                         6)))
                                   (if (unsafe-procedure-call
                                        error?.89
                                        g42366689.32)
                                     g42366689.32
                                     (let ((g42366690.33
                                            (unsafe-procedure-call
                                             vector-set!.88
                                             tmp.8.26
                                             6
                                             7)))
                                       (if (unsafe-procedure-call
                                            error?.89
                                            g42366690.33)
                                         g42366690.33
                                         (let ((g42366691.34
                                                (unsafe-procedure-call
                                                 vector-set!.88
                                                 tmp.8.26
                                                 7
                                                 8)))
                                           (if (unsafe-procedure-call
                                                error?.89
                                                g42366691.34)
                                             g42366691.34
                                             tmp.8.26)))))))))))))))))))))))
(check-by-interp
 '(module
    (letrec ((cons.221 (lambda (tmp.212 tmp.213) (cons tmp.212 tmp.213)))
             (unsafe-vector-set!.5
              (lambda (tmp.171 tmp.172 tmp.173)
                (if (unsafe-fx< tmp.172 (unsafe-vector-length tmp.171))
                  (if (unsafe-fx>= tmp.172 0)
                    (begin (unsafe-vector-set! tmp.171 tmp.172 tmp.173) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.220
              (lambda (tmp.195 tmp.196 tmp.197)
                (if (fixnum? tmp.196)
                  (if (vector? tmp.195)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.195
                     tmp.196
                     tmp.197)
                    (error 10))
                  (error 10))))
             (vector-init-loop.167
              (lambda (len.168 i.170 vec.169)
                (if (eq? len.168 i.170)
                  vec.169
                  (begin
                    (unsafe-vector-set! vec.169 i.170 0)
                    (unsafe-procedure-call
                     vector-init-loop.167
                     len.168
                     (unsafe-fx+ i.170 1)
                     vec.169)))))
             (make-init-vector.4
              (lambda (tmp.165)
                (let ((tmp.166 (unsafe-make-vector tmp.165)))
                  (unsafe-procedure-call
                   vector-init-loop.167
                   tmp.165
                   0
                   tmp.166))))
             (make-vector.219
              (lambda (tmp.193)
                (if (fixnum? tmp.193)
                  (unsafe-procedure-call make-init-vector.4 tmp.193)
                  (error 8))))
             (error?.218 (lambda (tmp.207) (error? tmp.207)))
             (>=.217
              (lambda (tmp.191 tmp.192)
                (if (fixnum? tmp.192)
                  (if (fixnum? tmp.191)
                    (unsafe-fx>= tmp.191 tmp.192)
                    (error 7))
                  (error 7))))
             (fun/empty8542.34 (lambda (oprand0.43) empty))
             (fun/empty8544.35
              (lambda () (unsafe-procedure-call fun/empty8545.37)))
             (fun/empty8539.36 (lambda (oprand0.44) empty))
             (fun/empty8545.37 (lambda () empty))
             (fun/empty8547.38 (lambda () (let () empty)))
             (fun/void8541.39 (lambda () (void)))
             (fun/empty8546.40 (lambda (oprand0.45) empty))
             (fun/void8540.41 (lambda () (void)))
             (fun/empty8543.42 (lambda (oprand0.47 oprand1.46) empty)))
      (let ((g42374287.48
             (if (unsafe-procedure-call >=.217 2 186)
               (unsafe-procedure-call fun/empty8539.36 #t)
               (let ((procedure0.49 (lambda (oprand0.51 oprand1.50) #\_)))
                 empty))))
        (if (unsafe-procedure-call error?.218 g42374287.48)
          g42374287.48
          (let ((g42374288.52
                 (let ((fixnum0.55
                        (let ((tmp.7.56 131))
                          (if tmp.7.56
                            tmp.7.56
                            (let ((tmp.8.57 147))
                              (if tmp.8.57
                                tmp.8.57
                                (let ((tmp.9.58 135))
                                  (if tmp.9.58 tmp.9.58 70)))))))
                       (vector1.54
                        (let ((tmp.10.59
                               (unsafe-procedure-call make-vector.219 8)))
                          (let ((g42374289.60
                                 (unsafe-procedure-call
                                  vector-set!.220
                                  tmp.10.59
                                  0
                                  (let ((tmp.222
                                         (unsafe-procedure-call
                                          make-vector.219
                                          8)))
                                    (if (procedure? tmp.222)
                                      (if (eq?
                                           (unsafe-procedure-arity tmp.222)
                                           0)
                                        (unsafe-procedure-call tmp.222)
                                        (error 42))
                                      (error 43))))))
                            (if (unsafe-procedure-call error?.218 g42374289.60)
                              g42374289.60
                              (let ((g42374290.61
                                     (unsafe-procedure-call
                                      vector-set!.220
                                      tmp.10.59
                                      1
                                      (let ((tmp.223 #t))
                                        (if (procedure? tmp.223)
                                          (if (eq?
                                               (unsafe-procedure-arity tmp.223)
                                               0)
                                            (unsafe-procedure-call tmp.223)
                                            (error 42))
                                          (error 43))))))
                                (if (unsafe-procedure-call
                                     error?.218
                                     g42374290.61)
                                  g42374290.61
                                  (let ((g42374291.62
                                         (unsafe-procedure-call
                                          vector-set!.220
                                          tmp.10.59
                                          2
                                          (let ((tmp.224 #t))
                                            (if (procedure? tmp.224)
                                              (if (eq?
                                                   (unsafe-procedure-arity
                                                    tmp.224)
                                                   0)
                                                (unsafe-procedure-call tmp.224)
                                                (error 42))
                                              (error 43))))))
                                    (if (unsafe-procedure-call
                                         error?.218
                                         g42374291.62)
                                      g42374291.62
                                      (let ((g42374292.63
                                             (unsafe-procedure-call
                                              vector-set!.220
                                              tmp.10.59
                                              3
                                              (let ((tmp.225 empty))
                                                (if (procedure? tmp.225)
                                                  (if (eq?
                                                       (unsafe-procedure-arity
                                                        tmp.225)
                                                       0)
                                                    (unsafe-procedure-call
                                                     tmp.225)
                                                    (error 42))
                                                  (error 43))))))
                                        (if (unsafe-procedure-call
                                             error?.218
                                             g42374292.63)
                                          g42374292.63
                                          (let ((g42374293.64
                                                 (unsafe-procedure-call
                                                  vector-set!.220
                                                  tmp.10.59
                                                  4
                                                  (let ((tmp.226 #\_))
                                                    (if (procedure? tmp.226)
                                                      (if (eq?
                                                           (unsafe-procedure-arity
                                                            tmp.226)
                                                           0)
                                                        (unsafe-procedure-call
                                                         tmp.226)
                                                        (error 42))
                                                      (error 43))))))
                                            (if (unsafe-procedure-call
                                                 error?.218
                                                 g42374293.64)
                                              g42374293.64
                                              (let ((g42374294.65
                                                     (unsafe-procedure-call
                                                      vector-set!.220
                                                      tmp.10.59
                                                      5
                                                      (let ((tmp.227 111))
                                                        (if (procedure?
                                                             tmp.227)
                                                          (if (eq?
                                                               (unsafe-procedure-arity
                                                                tmp.227)
                                                               0)
                                                            (unsafe-procedure-call
                                                             tmp.227)
                                                            (error 42))
                                                          (error 43))))))
                                                (if (unsafe-procedure-call
                                                     error?.218
                                                     g42374294.65)
                                                  g42374294.65
                                                  (let ((g42374295.66
                                                         (unsafe-procedure-call
                                                          vector-set!.220
                                                          tmp.10.59
                                                          6
                                                          (let ((tmp.228 194))
                                                            (if (procedure?
                                                                 tmp.228)
                                                              (if (eq?
                                                                   (unsafe-procedure-arity
                                                                    tmp.228)
                                                                   0)
                                                                (unsafe-procedure-call
                                                                 tmp.228)
                                                                (error 42))
                                                              (error 43))))))
                                                    (if (unsafe-procedure-call
                                                         error?.218
                                                         g42374295.66)
                                                      g42374295.66
                                                      (let ((g42374296.67
                                                             (unsafe-procedure-call
                                                              vector-set!.220
                                                              tmp.10.59
                                                              7
                                                              (unsafe-procedure-call
                                                               (lambda ()
                                                                 699)))))
                                                        (if (unsafe-procedure-call
                                                             error?.218
                                                             g42374296.67)
                                                          g42374296.67
                                                          tmp.10.59))))))))))))))))))
                       (error2.53
                        (let ((tmp.11.68 (error 173)))
                          (if tmp.11.68
                            tmp.11.68
                            (let ((tmp.12.69 (error 54)))
                              (if tmp.12.69
                                tmp.12.69
                                (let ((tmp.13.70 (error 170)))
                                  (if tmp.13.70 tmp.13.70 (error 170)))))))))
                   (if empty
                     (if empty (if empty (if empty empty #f) #f) #f)
                     #f))))
            (if (unsafe-procedure-call error?.218 g42374288.52)
              g42374288.52
              (let ((g42374297.71
                     (let ((void0.74 (unsafe-procedure-call fun/void8540.41))
                           (ascii-char1.73 (let () #\t))
                           (void2.72 (unsafe-procedure-call fun/void8541.39)))
                       (if empty (if empty empty #f) #f))))
                (if (unsafe-procedure-call error?.218 g42374297.71)
                  g42374297.71
                  (let ((g42374298.75
                         (if (if #f empty empty)
                           (if (let ((boolean0.77 #t)
                                     (pair1.76
                                      (unsafe-procedure-call
                                       cons.221
                                       42
                                       (unsafe-procedure-call
                                        cons.221
                                        383
                                        empty))))
                                 empty)
                             (if (if #t empty empty)
                               (if (let () empty)
                                 (if (let ((vector0.80
                                            (let ((tmp.14.81
                                                   (unsafe-procedure-call
                                                    make-vector.219
                                                    8)))
                                              (let ((g42374299.82
                                                     (unsafe-procedure-call
                                                      vector-set!.220
                                                      tmp.14.81
                                                      0
                                                      1)))
                                                (if (unsafe-procedure-call
                                                     error?.218
                                                     g42374299.82)
                                                  g42374299.82
                                                  (let ((g42374300.83
                                                         (unsafe-procedure-call
                                                          vector-set!.220
                                                          tmp.14.81
                                                          1
                                                          2)))
                                                    (if (unsafe-procedure-call
                                                         error?.218
                                                         g42374300.83)
                                                      g42374300.83
                                                      (let ((g42374301.84
                                                             (unsafe-procedure-call
                                                              vector-set!.220
                                                              tmp.14.81
                                                              2
                                                              3)))
                                                        (if (unsafe-procedure-call
                                                             error?.218
                                                             g42374301.84)
                                                          g42374301.84
                                                          (let ((g42374302.85
                                                                 (unsafe-procedure-call
                                                                  vector-set!.220
                                                                  tmp.14.81
                                                                  3
                                                                  4)))
                                                            (if (unsafe-procedure-call
                                                                 error?.218
                                                                 g42374302.85)
                                                              g42374302.85
                                                              (let ((g42374303.86
                                                                     (unsafe-procedure-call
                                                                      vector-set!.220
                                                                      tmp.14.81
                                                                      4
                                                                      5)))
                                                                (if (unsafe-procedure-call
                                                                     error?.218
                                                                     g42374303.86)
                                                                  g42374303.86
                                                                  (let ((g42374304.87
                                                                         (unsafe-procedure-call
                                                                          vector-set!.220
                                                                          tmp.14.81
                                                                          5
                                                                          6)))
                                                                    (if (unsafe-procedure-call
                                                                         error?.218
                                                                         g42374304.87)
                                                                      g42374304.87
                                                                      (let ((g42374305.88
                                                                             (unsafe-procedure-call
                                                                              vector-set!.220
                                                                              tmp.14.81
                                                                              6
                                                                              7)))
                                                                        (if (unsafe-procedure-call
                                                                             error?.218
                                                                             g42374305.88)
                                                                          g42374305.88
                                                                          (let ((g42374306.89
                                                                                 (unsafe-procedure-call
                                                                                  vector-set!.220
                                                                                  tmp.14.81
                                                                                  7
                                                                                  8)))
                                                                            (if (unsafe-procedure-call
                                                                                 error?.218
                                                                                 g42374306.89)
                                                                              g42374306.89
                                                                              tmp.14.81))))))))))))))))))
                                           (procedure1.79 (lambda () empty))
                                           (empty2.78 empty))
                                       empty)
                                   (if #f empty empty)
                                   #f)
                                 #f)
                               #f)
                             #f)
                           #f)))
                    (if (unsafe-procedure-call error?.218 g42374298.75)
                      g42374298.75
                      (let ((g42374307.90
                             (let ((g42374308.91 (if #f empty empty)))
                               (if (unsafe-procedure-call
                                    error?.218
                                    g42374308.91)
                                 g42374308.91
                                 (let ((g42374309.92
                                        (let ((tmp.15.93 empty))
                                          (if tmp.15.93
                                            tmp.15.93
                                            (let ((tmp.16.94 empty))
                                              (if tmp.16.94
                                                tmp.16.94
                                                (let ((tmp.17.95 empty))
                                                  (if tmp.17.95
                                                    tmp.17.95
                                                    (let ((tmp.18.96 empty))
                                                      (if tmp.18.96
                                                        tmp.18.96
                                                        empty))))))))))
                                   (if (unsafe-procedure-call
                                        error?.218
                                        g42374309.92)
                                     g42374309.92
                                     (let ((g42374310.97
                                            (let ((boolean0.98 #f)) empty)))
                                       (if (unsafe-procedure-call
                                            error?.218
                                            g42374310.97)
                                         g42374310.97
                                         (let ((g42374311.99
                                                (let ((pair0.102
                                                       (unsafe-procedure-call
                                                        cons.221
                                                        205
                                                        (unsafe-procedure-call
                                                         cons.221
                                                         503
                                                         empty)))
                                                      (boolean1.101 #f)
                                                      (pair2.100
                                                       (unsafe-procedure-call
                                                        cons.221
                                                        178
                                                        (unsafe-procedure-call
                                                         cons.221
                                                         296
                                                         empty))))
                                                  empty)))
                                           (if (unsafe-procedure-call
                                                error?.218
                                                g42374311.99)
                                             g42374311.99
                                             (let ((g42374312.103
                                                    (unsafe-procedure-call
                                                     fun/empty8542.34
                                                     (error 60))))
                                               (if (unsafe-procedure-call
                                                    error?.218
                                                    g42374312.103)
                                                 g42374312.103
                                                 (if empty
                                                   empty
                                                   #f)))))))))))))
                        (if (unsafe-procedure-call error?.218 g42374307.90)
                          g42374307.90
                          (let ((g42374313.104
                                 (let ((vector0.107
                                        (let ((tmp.19.108
                                               (unsafe-procedure-call
                                                make-vector.219
                                                8)))
                                          (let ((g42374314.109
                                                 (unsafe-procedure-call
                                                  vector-set!.220
                                                  tmp.19.108
                                                  0
                                                  0)))
                                            (if (unsafe-procedure-call
                                                 error?.218
                                                 g42374314.109)
                                              g42374314.109
                                              (let ((g42374315.110
                                                     (unsafe-procedure-call
                                                      vector-set!.220
                                                      tmp.19.108
                                                      1
                                                      1)))
                                                (if (unsafe-procedure-call
                                                     error?.218
                                                     g42374315.110)
                                                  g42374315.110
                                                  (let ((g42374316.111
                                                         (unsafe-procedure-call
                                                          vector-set!.220
                                                          tmp.19.108
                                                          2
                                                          2)))
                                                    (if (unsafe-procedure-call
                                                         error?.218
                                                         g42374316.111)
                                                      g42374316.111
                                                      (let ((g42374317.112
                                                             (unsafe-procedure-call
                                                              vector-set!.220
                                                              tmp.19.108
                                                              3
                                                              3)))
                                                        (if (unsafe-procedure-call
                                                             error?.218
                                                             g42374317.112)
                                                          g42374317.112
                                                          (let ((g42374318.113
                                                                 (unsafe-procedure-call
                                                                  vector-set!.220
                                                                  tmp.19.108
                                                                  4
                                                                  4)))
                                                            (if (unsafe-procedure-call
                                                                 error?.218
                                                                 g42374318.113)
                                                              g42374318.113
                                                              (let ((g42374319.114
                                                                     (unsafe-procedure-call
                                                                      vector-set!.220
                                                                      tmp.19.108
                                                                      5
                                                                      5)))
                                                                (if (unsafe-procedure-call
                                                                     error?.218
                                                                     g42374319.114)
                                                                  g42374319.114
                                                                  (let ((g42374320.115
                                                                         (unsafe-procedure-call
                                                                          vector-set!.220
                                                                          tmp.19.108
                                                                          6
                                                                          6)))
                                                                    (if (unsafe-procedure-call
                                                                         error?.218
                                                                         g42374320.115)
                                                                      g42374320.115
                                                                      (let ((g42374321.116
                                                                             (unsafe-procedure-call
                                                                              vector-set!.220
                                                                              tmp.19.108
                                                                              7
                                                                              7)))
                                                                        (if (unsafe-procedure-call
                                                                             error?.218
                                                                             g42374321.116)
                                                                          g42374321.116
                                                                          tmp.19.108))))))))))))))))))
                                       (pair1.106
                                        (unsafe-procedure-call
                                         cons.221
                                         168
                                         (unsafe-procedure-call
                                          cons.221
                                          348
                                          empty)))
                                       (error2.105 (error 250)))
                                   empty)))
                            (if (unsafe-procedure-call
                                 error?.218
                                 g42374313.104)
                              g42374313.104
                              (let ((g42374322.117
                                     (let ((g42374323.118
                                            (let ((g42374324.119 empty))
                                              (if (unsafe-procedure-call
                                                   error?.218
                                                   g42374324.119)
                                                g42374324.119
                                                empty))))
                                       (if (unsafe-procedure-call
                                            error?.218
                                            g42374323.118)
                                         g42374323.118
                                         (let ((g42374325.120
                                                (if #f empty empty)))
                                           (if (unsafe-procedure-call
                                                error?.218
                                                g42374325.120)
                                             g42374325.120
                                             (let ((g42374326.121
                                                    (unsafe-procedure-call
                                                     fun/empty8543.42
                                                     #f
                                                     #\l)))
                                               (if (unsafe-procedure-call
                                                    error?.218
                                                    g42374326.121)
                                                 g42374326.121
                                                 (let ((g42374327.122
                                                        (let ((tmp.20.123
                                                               empty))
                                                          (if tmp.20.123
                                                            tmp.20.123
                                                            (let ((tmp.21.124
                                                                   empty))
                                                              (if tmp.21.124
                                                                tmp.21.124
                                                                (let ((tmp.22.125
                                                                       empty))
                                                                  (if tmp.22.125
                                                                    tmp.22.125
                                                                    (let ((tmp.23.126
                                                                           empty))
                                                                      (if tmp.23.126
                                                                        tmp.23.126
                                                                        empty))))))))))
                                                   (if (unsafe-procedure-call
                                                        error?.218
                                                        g42374327.122)
                                                     g42374327.122
                                                     (let ((g42374328.127
                                                            (if #t
                                                              empty
                                                              empty)))
                                                       (if (unsafe-procedure-call
                                                            error?.218
                                                            g42374328.127)
                                                         g42374328.127
                                                         (if #f
                                                           empty
                                                           empty)))))))))))))
                                (if (unsafe-procedure-call
                                     error?.218
                                     g42374322.117)
                                  g42374322.117
                                  (let ((g42374329.128
                                         (unsafe-procedure-call
                                          fun/empty8544.35)))
                                    (if (unsafe-procedure-call
                                         error?.218
                                         g42374329.128)
                                      g42374329.128
                                      (let ((g42374330.129
                                             (let ((tmp.24.130
                                                    (let ((ascii-char0.133 #\G)
                                                          (vector1.132
                                                           (let ((tmp.25.134
                                                                  (unsafe-procedure-call
                                                                   make-vector.219
                                                                   8)))
                                                             (let ((g42374331.135
                                                                    (unsafe-procedure-call
                                                                     vector-set!.220
                                                                     tmp.25.134
                                                                     0
                                                                     0)))
                                                               (if (unsafe-procedure-call
                                                                    error?.218
                                                                    g42374331.135)
                                                                 g42374331.135
                                                                 (let ((g42374332.136
                                                                        (unsafe-procedure-call
                                                                         vector-set!.220
                                                                         tmp.25.134
                                                                         1
                                                                         1)))
                                                                   (if (unsafe-procedure-call
                                                                        error?.218
                                                                        g42374332.136)
                                                                     g42374332.136
                                                                     (let ((g42374333.137
                                                                            (unsafe-procedure-call
                                                                             vector-set!.220
                                                                             tmp.25.134
                                                                             2
                                                                             2)))
                                                                       (if (unsafe-procedure-call
                                                                            error?.218
                                                                            g42374333.137)
                                                                         g42374333.137
                                                                         (let ((g42374334.138
                                                                                (unsafe-procedure-call
                                                                                 vector-set!.220
                                                                                 tmp.25.134
                                                                                 3
                                                                                 3)))
                                                                           (if (unsafe-procedure-call
                                                                                error?.218
                                                                                g42374334.138)
                                                                             g42374334.138
                                                                             (let ((g42374335.139
                                                                                    (unsafe-procedure-call
                                                                                     vector-set!.220
                                                                                     tmp.25.134
                                                                                     4
                                                                                     4)))
                                                                               (if (unsafe-procedure-call
                                                                                    error?.218
                                                                                    g42374335.139)
                                                                                 g42374335.139
                                                                                 (let ((g42374336.140
                                                                                        (unsafe-procedure-call
                                                                                         vector-set!.220
                                                                                         tmp.25.134
                                                                                         5
                                                                                         5)))
                                                                                   (if (unsafe-procedure-call
                                                                                        error?.218
                                                                                        g42374336.140)
                                                                                     g42374336.140
                                                                                     (let ((g42374337.141
                                                                                            (unsafe-procedure-call
                                                                                             vector-set!.220
                                                                                             tmp.25.134
                                                                                             6
                                                                                             6)))
                                                                                       (if (unsafe-procedure-call
                                                                                            error?.218
                                                                                            g42374337.141)
                                                                                         g42374337.141
                                                                                         (let ((g42374338.142
                                                                                                (unsafe-procedure-call
                                                                                                 vector-set!.220
                                                                                                 tmp.25.134
                                                                                                 7
                                                                                                 7)))
                                                                                           (if (unsafe-procedure-call
                                                                                                error?.218
                                                                                                g42374338.142)
                                                                                             g42374338.142
                                                                                             tmp.25.134))))))))))))))))))
                                                          (boolean2.131 #f))
                                                      empty)))
                                               (if tmp.24.130
                                                 tmp.24.130
                                                 (let ((tmp.26.143
                                                        (let ((fixnum0.145 247)
                                                              (ascii-char1.144
                                                               #\T))
                                                          empty)))
                                                   (if tmp.26.143
                                                     tmp.26.143
                                                     (let ((tmp.27.146
                                                            (unsafe-procedure-call
                                                             fun/empty8546.40
                                                             (lambda () 652))))
                                                       (if tmp.27.146
                                                         tmp.27.146
                                                         (let ((tmp.28.147
                                                                (let ((vector0.149
                                                                       (let ((tmp.29.150
                                                                              (unsafe-procedure-call
                                                                               make-vector.219
                                                                               8)))
                                                                         (let ((g42374339.151
                                                                                (unsafe-procedure-call
                                                                                 vector-set!.220
                                                                                 tmp.29.150
                                                                                 0
                                                                                 0)))
                                                                           (if (unsafe-procedure-call
                                                                                error?.218
                                                                                g42374339.151)
                                                                             g42374339.151
                                                                             (let ((g42374340.152
                                                                                    (unsafe-procedure-call
                                                                                     vector-set!.220
                                                                                     tmp.29.150
                                                                                     1
                                                                                     1)))
                                                                               (if (unsafe-procedure-call
                                                                                    error?.218
                                                                                    g42374340.152)
                                                                                 g42374340.152
                                                                                 (let ((g42374341.153
                                                                                        (unsafe-procedure-call
                                                                                         vector-set!.220
                                                                                         tmp.29.150
                                                                                         2
                                                                                         2)))
                                                                                   (if (unsafe-procedure-call
                                                                                        error?.218
                                                                                        g42374341.153)
                                                                                     g42374341.153
                                                                                     (let ((g42374342.154
                                                                                            (unsafe-procedure-call
                                                                                             vector-set!.220
                                                                                             tmp.29.150
                                                                                             3
                                                                                             3)))
                                                                                       (if (unsafe-procedure-call
                                                                                            error?.218
                                                                                            g42374342.154)
                                                                                         g42374342.154
                                                                                         (let ((g42374343.155
                                                                                                (unsafe-procedure-call
                                                                                                 vector-set!.220
                                                                                                 tmp.29.150
                                                                                                 4
                                                                                                 4)))
                                                                                           (if (unsafe-procedure-call
                                                                                                error?.218
                                                                                                g42374343.155)
                                                                                             g42374343.155
                                                                                             (let ((g42374344.156
                                                                                                    (unsafe-procedure-call
                                                                                                     vector-set!.220
                                                                                                     tmp.29.150
                                                                                                     5
                                                                                                     5)))
                                                                                               (if (unsafe-procedure-call
                                                                                                    error?.218
                                                                                                    g42374344.156)
                                                                                                 g42374344.156
                                                                                                 (let ((g42374345.157
                                                                                                        (unsafe-procedure-call
                                                                                                         vector-set!.220
                                                                                                         tmp.29.150
                                                                                                         6
                                                                                                         6)))
                                                                                                   (if (unsafe-procedure-call
                                                                                                        error?.218
                                                                                                        g42374345.157)
                                                                                                     g42374345.157
                                                                                                     (let ((g42374346.158
                                                                                                            (unsafe-procedure-call
                                                                                                             vector-set!.220
                                                                                                             tmp.29.150
                                                                                                             7
                                                                                                             7)))
                                                                                                       (if (unsafe-procedure-call
                                                                                                            error?.218
                                                                                                            g42374346.158)
                                                                                                         g42374346.158
                                                                                                         tmp.29.150))))))))))))))))))
                                                                      (fixnum1.148
                                                                       146))
                                                                  empty)))
                                                           (if tmp.28.147
                                                             tmp.28.147
                                                             (let ((tmp.30.159
                                                                    (let ((tmp.31.160
                                                                           empty))
                                                                      (if tmp.31.160
                                                                        tmp.31.160
                                                                        (let ((tmp.32.161
                                                                               empty))
                                                                          (if tmp.32.161
                                                                            tmp.32.161
                                                                            (let ((tmp.33.162
                                                                                   empty))
                                                                              (if tmp.33.162
                                                                                tmp.33.162
                                                                                empty))))))))
                                                               (if tmp.30.159
                                                                 tmp.30.159
                                                                 (let ((fixnum0.164
                                                                        152)
                                                                       (error1.163
                                                                        (error
                                                                         182)))
                                                                   empty)))))))))))))
                                        (if (unsafe-procedure-call
                                             error?.218
                                             g42374330.129)
                                          g42374330.129
                                          (unsafe-procedure-call
                                           fun/empty8547.38))))))))))))))))))))))
(check-by-interp
 '(module
    (letrec ((error?.73 (lambda (tmp.62) (error? tmp.62)))
             (cons.72 (lambda (tmp.67 tmp.68) (cons tmp.67 tmp.68)))
             (fun/fixnum8552.7
              (lambda () (unsafe-procedure-call fun/fixnum8553.9 235)))
             (fun/boolean8550.8
              (lambda (oprand0.12 oprand1.11)
                (unsafe-procedure-call fun/boolean8551.10)))
             (fun/fixnum8553.9 (lambda (oprand0.13) oprand0.13))
             (fun/boolean8551.10 (lambda () #f)))
      (if (unsafe-procedure-call
           fun/boolean8550.8
           (if #t #\C #\o)
           (let ((g42378163.14
                  (unsafe-procedure-call
                   cons.72
                   107
                   (unsafe-procedure-call cons.72 348 empty))))
             (if (unsafe-procedure-call error?.73 g42378163.14)
               g42378163.14
               (let ((g42378164.15
                      (unsafe-procedure-call
                       cons.72
                       203
                       (unsafe-procedure-call cons.72 496 empty))))
                 (if (unsafe-procedure-call error?.73 g42378164.15)
                   g42378164.15
                   (let ((g42378165.16
                          (unsafe-procedure-call
                           cons.72
                           79
                           (unsafe-procedure-call cons.72 267 empty))))
                     (if (unsafe-procedure-call error?.73 g42378165.16)
                       g42378165.16
                       (let ((g42378166.17
                              (unsafe-procedure-call
                               cons.72
                               239
                               (unsafe-procedure-call cons.72 409 empty))))
                         (if (unsafe-procedure-call error?.73 g42378166.17)
                           g42378166.17
                           (let ((g42378167.18
                                  (unsafe-procedure-call
                                   cons.72
                                   77
                                   (unsafe-procedure-call cons.72 484 empty))))
                             (if (unsafe-procedure-call error?.73 g42378167.18)
                               g42378167.18
                               (let ((g42378168.19
                                      (unsafe-procedure-call
                                       cons.72
                                       220
                                       (unsafe-procedure-call
                                        cons.72
                                        290
                                        empty))))
                                 (if (unsafe-procedure-call
                                      error?.73
                                      g42378168.19)
                                   g42378168.19
                                   (unsafe-procedure-call
                                    cons.72
                                    89
                                    (unsafe-procedure-call
                                     cons.72
                                     469
                                     empty)))))))))))))))
        (unsafe-procedure-call fun/fixnum8552.7)
        (let () 134)))))
(check-by-interp
 '(module
    (letrec ((error?.68 (lambda (tmp.57) (error? tmp.57)))
             (cons.67 (lambda (tmp.62 tmp.63) (cons tmp.62 tmp.63)))
             (fun/fixnum8556.7 (lambda (oprand0.9 oprand1.8) (if #t 71 190))))
      (if (let ((pair0.12
                 (unsafe-procedure-call
                  cons.67
                  177
                  (unsafe-procedure-call cons.67 360 empty)))
                (empty1.11 empty)
                (boolean2.10 #f))
            #t)
        (let ((pair0.13
               (unsafe-procedure-call
                cons.67
                210
                (unsafe-procedure-call cons.67 266 empty))))
          198)
        (unsafe-procedure-call
         fun/fixnum8556.7
         (if #t empty empty)
         (let ((g42381986.14
                (unsafe-procedure-call
                 cons.67
                 103
                 (unsafe-procedure-call cons.67 399 empty))))
           (if (unsafe-procedure-call error?.68 g42381986.14)
             g42381986.14
             (unsafe-procedure-call
              cons.67
              19
              (unsafe-procedure-call cons.67 508 empty)))))))))
(check-by-interp
 '(module
    (letrec ((error?.86 (lambda (tmp.73) (error? tmp.73)))
             (unsafe-vector-set!.5
              (lambda (tmp.37 tmp.38 tmp.39)
                (if (unsafe-fx< tmp.38 (unsafe-vector-length tmp.37))
                  (if (unsafe-fx>= tmp.38 0)
                    (begin (unsafe-vector-set! tmp.37 tmp.38 tmp.39) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.85
              (lambda (tmp.61 tmp.62 tmp.63)
                (if (fixnum? tmp.62)
                  (if (vector? tmp.61)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.61
                     tmp.62
                     tmp.63)
                    (error 10))
                  (error 10))))
             (vector-init-loop.33
              (lambda (len.34 i.36 vec.35)
                (if (eq? len.34 i.36)
                  vec.35
                  (begin
                    (unsafe-vector-set! vec.35 i.36 0)
                    (unsafe-procedure-call
                     vector-init-loop.33
                     len.34
                     (unsafe-fx+ i.36 1)
                     vec.35)))))
             (make-init-vector.4
              (lambda (tmp.31)
                (let ((tmp.32 (unsafe-make-vector tmp.31)))
                  (unsafe-procedure-call
                   vector-init-loop.33
                   tmp.31
                   0
                   tmp.32))))
             (make-vector.84
              (lambda (tmp.59)
                (if (fixnum? tmp.59)
                  (unsafe-procedure-call make-init-vector.4 tmp.59)
                  (error 8))))
             (cons.83 (lambda (tmp.78 tmp.79) (cons tmp.78 tmp.79)))
             (fun/pair8560.12
              (lambda (oprand0.14)
                (unsafe-procedure-call
                 cons.83
                 5
                 (unsafe-procedure-call cons.83 421 empty))))
             (fun/procedure8559.13 (lambda () (lambda () 550))))
      (let ((vector0.15
             (let ((tmp.7.16 (unsafe-procedure-call make-vector.84 8)))
               (let ((g42385801.17
                      (unsafe-procedure-call
                       vector-set!.85
                       tmp.7.16
                       0
                       (let ((tmp.87 (let () (void))))
                         (if (procedure? tmp.87)
                           (if (eq? (unsafe-procedure-arity tmp.87) 0)
                             (unsafe-procedure-call tmp.87)
                             (error 42))
                           (error 43))))))
                 (if (unsafe-procedure-call error?.86 g42385801.17)
                   g42385801.17
                   (let ((g42385802.18
                          (unsafe-procedure-call
                           vector-set!.85
                           tmp.7.16
                           1
                           (let ((tmp.88 (let () 84)))
                             (if (procedure? tmp.88)
                               (if (eq? (unsafe-procedure-arity tmp.88) 0)
                                 (unsafe-procedure-call tmp.88)
                                 (error 42))
                               (error 43))))))
                     (if (unsafe-procedure-call error?.86 g42385802.18)
                       g42385802.18
                       (let ((g42385803.19
                              (unsafe-procedure-call
                               vector-set!.85
                               tmp.7.16
                               2
                               (let ((tmp.89
                                      (let ((pair0.21
                                             (unsafe-procedure-call
                                              cons.83
                                              115
                                              (unsafe-procedure-call
                                               cons.83
                                               428
                                               empty)))
                                            (empty1.20 empty))
                                        (void))))
                                 (if (procedure? tmp.89)
                                   (if (eq? (unsafe-procedure-arity tmp.89) 0)
                                     (unsafe-procedure-call tmp.89)
                                     (error 42))
                                   (error 43))))))
                         (if (unsafe-procedure-call error?.86 g42385803.19)
                           g42385803.19
                           (let ((g42385804.22
                                  (unsafe-procedure-call
                                   vector-set!.85
                                   tmp.7.16
                                   3
                                   (let ((tmp.90
                                          (let ((tmp.8.23 69))
                                            (if tmp.8.23
                                              tmp.8.23
                                              (let ((tmp.9.24 50))
                                                (if tmp.9.24
                                                  tmp.9.24
                                                  (let ((tmp.10.25 147))
                                                    (if tmp.10.25
                                                      tmp.10.25
                                                      (let ((tmp.11.26 112))
                                                        (if tmp.11.26
                                                          tmp.11.26
                                                          173))))))))))
                                     (if (procedure? tmp.90)
                                       (if (eq?
                                            (unsafe-procedure-arity tmp.90)
                                            0)
                                         (unsafe-procedure-call tmp.90)
                                         (error 42))
                                       (error 43))))))
                             (if (unsafe-procedure-call error?.86 g42385804.22)
                               g42385804.22
                               (let ((g42385805.27
                                      (unsafe-procedure-call
                                       vector-set!.85
                                       tmp.7.16
                                       4
                                       (let ((tmp.91 (let () empty)))
                                         (if (procedure? tmp.91)
                                           (if (eq?
                                                (unsafe-procedure-arity tmp.91)
                                                0)
                                             (unsafe-procedure-call tmp.91)
                                             (error 42))
                                           (error 43))))))
                                 (if (unsafe-procedure-call
                                      error?.86
                                      g42385805.27)
                                   g42385805.27
                                   (let ((g42385806.28
                                          (unsafe-procedure-call
                                           vector-set!.85
                                           tmp.7.16
                                           5
                                           (let ((tmp.92
                                                  (unsafe-procedure-call
                                                   fun/procedure8559.13)))
                                             (if (procedure? tmp.92)
                                               (if (eq?
                                                    (unsafe-procedure-arity
                                                     tmp.92)
                                                    0)
                                                 (unsafe-procedure-call tmp.92)
                                                 (error 42))
                                               (error 43))))))
                                     (if (unsafe-procedure-call
                                          error?.86
                                          g42385806.28)
                                       g42385806.28
                                       (let ((g42385807.29
                                              (unsafe-procedure-call
                                               vector-set!.85
                                               tmp.7.16
                                               6
                                               (let ((tmp.93
                                                      (if #f empty empty)))
                                                 (if (procedure? tmp.93)
                                                   (if (eq?
                                                        (unsafe-procedure-arity
                                                         tmp.93)
                                                        0)
                                                     (unsafe-procedure-call
                                                      tmp.93)
                                                     (error 42))
                                                   (error 43))))))
                                         (if (unsafe-procedure-call
                                              error?.86
                                              g42385807.29)
                                           g42385807.29
                                           (let ((g42385808.30
                                                  (unsafe-procedure-call
                                                   vector-set!.85
                                                   tmp.7.16
                                                   7
                                                   (let ((tmp.94
                                                          (unsafe-procedure-call
                                                           fun/pair8560.12
                                                           #t)))
                                                     (if (procedure? tmp.94)
                                                       (if (eq?
                                                            (unsafe-procedure-arity
                                                             tmp.94)
                                                            0)
                                                         (unsafe-procedure-call
                                                          tmp.94)
                                                         (error 42))
                                                       (error 43))))))
                                             (if (unsafe-procedure-call
                                                  error?.86
                                                  g42385808.30)
                                               g42385808.30
                                               tmp.7.16)))))))))))))))))))
        (if #f #\J #\`)))))
(check-by-interp
 '(module
    (letrec ((ascii-char?.102 (lambda (tmp.88) (ascii-char? tmp.88)))
             (error?.101 (lambda (tmp.89) (error? tmp.89)))
             (unsafe-vector-set!.5
              (lambda (tmp.53 tmp.54 tmp.55)
                (if (unsafe-fx< tmp.54 (unsafe-vector-length tmp.53))
                  (if (unsafe-fx>= tmp.54 0)
                    (begin (unsafe-vector-set! tmp.53 tmp.54 tmp.55) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.100
              (lambda (tmp.77 tmp.78 tmp.79)
                (if (fixnum? tmp.78)
                  (if (vector? tmp.77)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.77
                     tmp.78
                     tmp.79)
                    (error 10))
                  (error 10))))
             (vector-init-loop.49
              (lambda (len.50 i.52 vec.51)
                (if (eq? len.50 i.52)
                  vec.51
                  (begin
                    (unsafe-vector-set! vec.51 i.52 0)
                    (unsafe-procedure-call
                     vector-init-loop.49
                     len.50
                     (unsafe-fx+ i.52 1)
                     vec.51)))))
             (make-init-vector.4
              (lambda (tmp.47)
                (let ((tmp.48 (unsafe-make-vector tmp.47)))
                  (unsafe-procedure-call
                   vector-init-loop.49
                   tmp.47
                   0
                   tmp.48))))
             (make-vector.99
              (lambda (tmp.75)
                (if (fixnum? tmp.75)
                  (unsafe-procedure-call make-init-vector.4 tmp.75)
                  (error 8))))
             (fun/error7326.14 (lambda () (if #f (error 41) (error 41))))
             (fun/any7325.15
              (lambda ()
                (let ((tmp.7.17 (unsafe-procedure-call make-vector.99 8)))
                  (let ((g42409226.18
                         (unsafe-procedure-call vector-set!.100 tmp.7.17 0 1)))
                    (if (unsafe-procedure-call error?.101 g42409226.18)
                      g42409226.18
                      (let ((g42409227.19
                             (unsafe-procedure-call
                              vector-set!.100
                              tmp.7.17
                              1
                              2)))
                        (if (unsafe-procedure-call error?.101 g42409227.19)
                          g42409227.19
                          (let ((g42409228.20
                                 (unsafe-procedure-call
                                  vector-set!.100
                                  tmp.7.17
                                  2
                                  3)))
                            (if (unsafe-procedure-call error?.101 g42409228.20)
                              g42409228.20
                              (let ((g42409229.21
                                     (unsafe-procedure-call
                                      vector-set!.100
                                      tmp.7.17
                                      3
                                      4)))
                                (if (unsafe-procedure-call
                                     error?.101
                                     g42409229.21)
                                  g42409229.21
                                  (let ((g42409230.22
                                         (unsafe-procedure-call
                                          vector-set!.100
                                          tmp.7.17
                                          4
                                          5)))
                                    (if (unsafe-procedure-call
                                         error?.101
                                         g42409230.22)
                                      g42409230.22
                                      (let ((g42409231.23
                                             (unsafe-procedure-call
                                              vector-set!.100
                                              tmp.7.17
                                              5
                                              6)))
                                        (if (unsafe-procedure-call
                                             error?.101
                                             g42409231.23)
                                          g42409231.23
                                          (let ((g42409232.24
                                                 (unsafe-procedure-call
                                                  vector-set!.100
                                                  tmp.7.17
                                                  6
                                                  7)))
                                            (if (unsafe-procedure-call
                                                 error?.101
                                                 g42409232.24)
                                              g42409232.24
                                              (let ((g42409233.25
                                                     (unsafe-procedure-call
                                                      vector-set!.100
                                                      tmp.7.17
                                                      7
                                                      8)))
                                                (if (unsafe-procedure-call
                                                     error?.101
                                                     g42409233.25)
                                                  g42409233.25
                                                  tmp.7.17)))))))))))))))))))
             (fun/error7327.16 (lambda (oprand0.27 oprand1.26) (error 150))))
      (if (unsafe-procedure-call
           ascii-char?.102
           (unsafe-procedure-call fun/any7325.15))
        (unsafe-procedure-call fun/error7326.14)
        (let ((tmp.8.28 (if (error 73) (if (error 249) (error 226) #f) #f)))
          (if tmp.8.28
            tmp.8.28
            (let ((tmp.9.29
                   (let ((g42409234.30 (error 136)))
                     (if (unsafe-procedure-call error?.101 g42409234.30)
                       g42409234.30
                       (let ((g42409235.31 (error 134)))
                         (if (unsafe-procedure-call error?.101 g42409235.31)
                           g42409235.31
                           (let ((g42409236.32 (error 216)))
                             (if (unsafe-procedure-call
                                  error?.101
                                  g42409236.32)
                               g42409236.32
                               (error 132)))))))))
              (if tmp.9.29
                tmp.9.29
                (let ((tmp.10.33 (if #t (error 103) (error 151))))
                  (if tmp.10.33
                    tmp.10.33
                    (let ((tmp.11.34
                           (unsafe-procedure-call
                            fun/error7327.16
                            (void)
                            (let ((tmp.12.35
                                   (unsafe-procedure-call make-vector.99 8)))
                              (let ((g42409237.36
                                     (unsafe-procedure-call
                                      vector-set!.100
                                      tmp.12.35
                                      0
                                      1)))
                                (if (unsafe-procedure-call
                                     error?.101
                                     g42409237.36)
                                  g42409237.36
                                  (let ((g42409238.37
                                         (unsafe-procedure-call
                                          vector-set!.100
                                          tmp.12.35
                                          1
                                          2)))
                                    (if (unsafe-procedure-call
                                         error?.101
                                         g42409238.37)
                                      g42409238.37
                                      (let ((g42409239.38
                                             (unsafe-procedure-call
                                              vector-set!.100
                                              tmp.12.35
                                              2
                                              3)))
                                        (if (unsafe-procedure-call
                                             error?.101
                                             g42409239.38)
                                          g42409239.38
                                          (let ((g42409240.39
                                                 (unsafe-procedure-call
                                                  vector-set!.100
                                                  tmp.12.35
                                                  3
                                                  4)))
                                            (if (unsafe-procedure-call
                                                 error?.101
                                                 g42409240.39)
                                              g42409240.39
                                              (let ((g42409241.40
                                                     (unsafe-procedure-call
                                                      vector-set!.100
                                                      tmp.12.35
                                                      4
                                                      5)))
                                                (if (unsafe-procedure-call
                                                     error?.101
                                                     g42409241.40)
                                                  g42409241.40
                                                  (let ((g42409242.41
                                                         (unsafe-procedure-call
                                                          vector-set!.100
                                                          tmp.12.35
                                                          5
                                                          6)))
                                                    (if (unsafe-procedure-call
                                                         error?.101
                                                         g42409242.41)
                                                      g42409242.41
                                                      (let ((g42409243.42
                                                             (unsafe-procedure-call
                                                              vector-set!.100
                                                              tmp.12.35
                                                              6
                                                              7)))
                                                        (if (unsafe-procedure-call
                                                             error?.101
                                                             g42409243.42)
                                                          g42409243.42
                                                          (let ((g42409244.43
                                                                 (unsafe-procedure-call
                                                                  vector-set!.100
                                                                  tmp.12.35
                                                                  7
                                                                  8)))
                                                            (if (unsafe-procedure-call
                                                                 error?.101
                                                                 g42409244.43)
                                                              g42409244.43
                                                              tmp.12.35))))))))))))))))))))
                      (if tmp.11.34
                        tmp.11.34
                        (let ((tmp.13.44 (let ((fixnum0.45 172)) (error 184))))
                          (if tmp.13.44
                            tmp.13.44
                            (let ((g42409245.46 (error 89)))
                              (if (unsafe-procedure-call
                                   error?.101
                                   g42409245.46)
                                g42409245.46
                                (error 219)))))))))))))))))
(check-by-interp
 '(module
    (letrec ((error?.72 (lambda (tmp.62) (error? tmp.62)))
             (fun/ascii-char8478.10 (lambda () (if #t #\t #\O))))
      (if (let ((tmp.7.11 (if #t #t #t)))
            (if tmp.7.11
              tmp.7.11
              (let ((tmp.8.12 (let () #t)))
                (if tmp.8.12
                  tmp.8.12
                  (let ((tmp.9.13
                         (let ((g42413066.14 #t))
                           (if (unsafe-procedure-call error?.72 g42413066.14)
                             g42413066.14
                             (let ((g42413067.15 #t))
                               (if (unsafe-procedure-call
                                    error?.72
                                    g42413067.15)
                                 g42413067.15
                                 (let ((g42413068.16 #f))
                                   (if (unsafe-procedure-call
                                        error?.72
                                        g42413068.16)
                                     g42413068.16
                                     (let ((g42413069.17 #t))
                                       (if (unsafe-procedure-call
                                            error?.72
                                            g42413069.17)
                                         g42413069.17
                                         (let ((g42413070.18 #f))
                                           (if (unsafe-procedure-call
                                                error?.72
                                                g42413070.18)
                                             g42413070.18
                                             (let ((g42413071.19 #f))
                                               (if (unsafe-procedure-call
                                                    error?.72
                                                    g42413071.19)
                                                 g42413071.19
                                                 #t))))))))))))))
                    (if tmp.9.13
                      tmp.9.13
                      (if #f (if #t (if #f #t #f) #f) #f)))))))
        (let () #\k)
        (unsafe-procedure-call fun/ascii-char8478.10)))))
(check-by-interp
 '(module
    (letrec ((ascii-char?.60 (lambda (tmp.49) (ascii-char? tmp.49))))
      (let ((boolean0.7
             (unsafe-procedure-call ascii-char?.60 (if #f #\l 229))))
        (let () (void))))))
(check-by-interp
 '(module
    (letrec ((fun/fixnum8485.13 (lambda (oprand0.16) oprand0.16))
             (fun/boolean8483.14 (lambda (oprand0.18 oprand1.17) (let () #t)))
             (fun/fixnum8484.15
              (lambda () (unsafe-procedure-call fun/fixnum8485.13 41))))
      (if (unsafe-procedure-call
           fun/boolean8483.14
           (if #t (void) (void))
           (let ((tmp.7.19 (lambda () 845)))
             (if tmp.7.19
               tmp.7.19
               (let ((tmp.8.20 (lambda () 630)))
                 (if tmp.8.20
                   tmp.8.20
                   (let ((tmp.9.21 (lambda () 689)))
                     (if tmp.9.21
                       tmp.9.21
                       (let ((tmp.10.22 (lambda () 943)))
                         (if tmp.10.22
                           tmp.10.22
                           (let ((tmp.11.23 (lambda () 1016)))
                             (if tmp.11.23
                               tmp.11.23
                               (let ((tmp.12.24 (lambda () 978)))
                                 (if tmp.12.24
                                   tmp.12.24
                                   (lambda () 974))))))))))))))
        (unsafe-procedure-call fun/fixnum8484.15)
        (if #t 109 42)))))
(check-by-interp
 '(module
    (letrec ((empty?.77 (lambda (tmp.60) (empty? tmp.60)))
             (error?.76 (lambda (tmp.63) (error? tmp.63)))
             (unsafe-vector-set!.5
              (lambda (tmp.27 tmp.28 tmp.29)
                (if (unsafe-fx< tmp.28 (unsafe-vector-length tmp.27))
                  (if (unsafe-fx>= tmp.28 0)
                    (begin (unsafe-vector-set! tmp.27 tmp.28 tmp.29) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.75
              (lambda (tmp.51 tmp.52 tmp.53)
                (if (fixnum? tmp.52)
                  (if (vector? tmp.51)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.51
                     tmp.52
                     tmp.53)
                    (error 10))
                  (error 10))))
             (vector-init-loop.23
              (lambda (len.24 i.26 vec.25)
                (if (eq? len.24 i.26)
                  vec.25
                  (begin
                    (unsafe-vector-set! vec.25 i.26 0)
                    (unsafe-procedure-call
                     vector-init-loop.23
                     len.24
                     (unsafe-fx+ i.26 1)
                     vec.25)))))
             (make-init-vector.4
              (lambda (tmp.21)
                (let ((tmp.22 (unsafe-make-vector tmp.21)))
                  (unsafe-procedure-call
                   vector-init-loop.23
                   tmp.21
                   0
                   tmp.22))))
             (make-vector.74
              (lambda (tmp.49)
                (if (fixnum? tmp.49)
                  (unsafe-procedure-call make-init-vector.4 tmp.49)
                  (error 8))))
             (cons.73 (lambda (tmp.68 tmp.69) (cons tmp.68 tmp.69)))
             (fun/pair8489.8
              (lambda ()
                (unsafe-procedure-call
                 cons.73
                 183
                 (unsafe-procedure-call cons.73 488 empty))))
             (fun/pair8488.9
              (lambda ()
                (unsafe-procedure-call
                 cons.73
                 88
                 (unsafe-procedure-call cons.73 319 empty)))))
      (let ((ascii-char0.11 (if #t #\T #\Q))
            (vector1.10
             (let ((tmp.7.12 (unsafe-procedure-call make-vector.74 8)))
               (let ((g42424517.13
                      (unsafe-procedure-call
                       vector-set!.75
                       tmp.7.12
                       0
                       (let ((tmp.78 (let () empty)))
                         (if (procedure? tmp.78)
                           (if (eq? (unsafe-procedure-arity tmp.78) 0)
                             (unsafe-procedure-call tmp.78)
                             (error 42))
                           (error 43))))))
                 (if (unsafe-procedure-call error?.76 g42424517.13)
                   g42424517.13
                   (let ((g42424518.14
                          (unsafe-procedure-call
                           vector-set!.75
                           tmp.7.12
                           1
                           (let ((tmp.79
                                  (unsafe-procedure-call
                                   error?.76
                                   (lambda () 656))))
                             (if (procedure? tmp.79)
                               (if (eq? (unsafe-procedure-arity tmp.79) 0)
                                 (unsafe-procedure-call tmp.79)
                                 (error 42))
                               (error 43))))))
                     (if (unsafe-procedure-call error?.76 g42424518.14)
                       g42424518.14
                       (let ((g42424519.15
                              (unsafe-procedure-call
                               vector-set!.75
                               tmp.7.12
                               2
                               (let ((tmp.80
                                      (unsafe-procedure-call fun/pair8488.9)))
                                 (if (procedure? tmp.80)
                                   (if (eq? (unsafe-procedure-arity tmp.80) 0)
                                     (unsafe-procedure-call tmp.80)
                                     (error 42))
                                   (error 43))))))
                         (if (unsafe-procedure-call error?.76 g42424519.15)
                           g42424519.15
                           (let ((g42424520.16
                                  (unsafe-procedure-call
                                   vector-set!.75
                                   tmp.7.12
                                   3
                                   (let ((tmp.81
                                          (if #t (error 221) (error 62))))
                                     (if (procedure? tmp.81)
                                       (if (eq?
                                            (unsafe-procedure-arity tmp.81)
                                            0)
                                         (unsafe-procedure-call tmp.81)
                                         (error 42))
                                       (error 43))))))
                             (if (unsafe-procedure-call error?.76 g42424520.16)
                               g42424520.16
                               (let ((g42424521.17
                                      (unsafe-procedure-call
                                       vector-set!.75
                                       tmp.7.12
                                       4
                                       (let ((tmp.82
                                              (unsafe-procedure-call
                                               empty?.77
                                               (void))))
                                         (if (procedure? tmp.82)
                                           (if (eq?
                                                (unsafe-procedure-arity tmp.82)
                                                0)
                                             (unsafe-procedure-call tmp.82)
                                             (error 42))
                                           (error 43))))))
                                 (if (unsafe-procedure-call
                                      error?.76
                                      g42424521.17)
                                   g42424521.17
                                   (let ((g42424522.18
                                          (unsafe-procedure-call
                                           vector-set!.75
                                           tmp.7.12
                                           5
                                           (let ((tmp.83 (if #f empty empty)))
                                             (if (procedure? tmp.83)
                                               (if (eq?
                                                    (unsafe-procedure-arity
                                                     tmp.83)
                                                    0)
                                                 (unsafe-procedure-call tmp.83)
                                                 (error 42))
                                               (error 43))))))
                                     (if (unsafe-procedure-call
                                          error?.76
                                          g42424522.18)
                                       g42424522.18
                                       (let ((g42424523.19
                                              (unsafe-procedure-call
                                               vector-set!.75
                                               tmp.7.12
                                               6
                                               (let ((tmp.84
                                                      (unsafe-procedure-call
                                                       fun/pair8489.8)))
                                                 (if (procedure? tmp.84)
                                                   (if (eq?
                                                        (unsafe-procedure-arity
                                                         tmp.84)
                                                        0)
                                                     (unsafe-procedure-call
                                                      tmp.84)
                                                     (error 42))
                                                   (error 43))))))
                                         (if (unsafe-procedure-call
                                              error?.76
                                              g42424523.19)
                                           g42424523.19
                                           (let ((g42424524.20
                                                  (unsafe-procedure-call
                                                   vector-set!.75
                                                   tmp.7.12
                                                   7
                                                   (let ((tmp.85
                                                          (if #f
                                                            (unsafe-procedure-call
                                                             cons.73
                                                             201
                                                             (unsafe-procedure-call
                                                              cons.73
                                                              424
                                                              empty))
                                                            (unsafe-procedure-call
                                                             cons.73
                                                             65
                                                             (unsafe-procedure-call
                                                              cons.73
                                                              350
                                                              empty)))))
                                                     (if (procedure? tmp.85)
                                                       (if (eq?
                                                            (unsafe-procedure-arity
                                                             tmp.85)
                                                            0)
                                                         (unsafe-procedure-call
                                                          tmp.85)
                                                         (error 42))
                                                       (error 43))))))
                                             (if (unsafe-procedure-call
                                                  error?.76
                                                  g42424524.20)
                                               g42424524.20
                                               tmp.7.12)))))))))))))))))))
        (let () (void))))))
(check-by-interp
 '(module
    (letrec ((error?.64 (lambda (tmp.54) (error? tmp.54))))
      (let ((g42428345.7
             (let ((empty0.10 empty) (fixnum1.9 21) (ascii-char2.8 #\F))
               (void))))
        (if (unsafe-procedure-call error?.64 g42428345.7)
          g42428345.7
          (let ((g42428346.11 (let () (void))))
            (if (unsafe-procedure-call error?.64 g42428346.11)
              g42428346.11
              (if #f (void) (void)))))))))
(check-by-interp
 '(module
    (letrec ((fun/empty8494.7
              (lambda ()
                (unsafe-procedure-call
                 fun/empty8495.11
                 (unsafe-procedure-call
                  fun/procedure8496.9
                  (unsafe-procedure-call fun/fixnum8498.8)))))
             (fun/fixnum8498.8 (lambda () 65))
             (fun/procedure8496.9
              (lambda (oprand0.12)
                (unsafe-procedure-call fun/procedure8497.10)))
             (fun/procedure8497.10 (lambda () (lambda () 609)))
             (fun/empty8495.11 (lambda (oprand0.13) (let () empty))))
      (unsafe-procedure-call fun/empty8494.7))))
(check-by-interp
 '(module
    (letrec ((fun/error8502.7
              (lambda () (unsafe-procedure-call fun/error8503.9)))
             (fun/error8501.8
              (lambda (oprand0.11) (unsafe-procedure-call fun/error8502.7)))
             (fun/error8503.9 (lambda () (error 198)))
             (fun/ascii-char8504.10 (lambda () (let ((fixnum0.12 151)) #\v))))
      (unsafe-procedure-call
       fun/error8501.8
       (unsafe-procedure-call fun/ascii-char8504.10)))))
(check-by-interp
 '(module
    (letrec ((error?.86 (lambda (tmp.74) (error? tmp.74)))
             (unsafe-vector-set!.5
              (lambda (tmp.38 tmp.39 tmp.40)
                (if (unsafe-fx< tmp.39 (unsafe-vector-length tmp.38))
                  (if (unsafe-fx>= tmp.39 0)
                    (begin (unsafe-vector-set! tmp.38 tmp.39 tmp.40) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.85
              (lambda (tmp.62 tmp.63 tmp.64)
                (if (fixnum? tmp.63)
                  (if (vector? tmp.62)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.62
                     tmp.63
                     tmp.64)
                    (error 10))
                  (error 10))))
             (vector-init-loop.34
              (lambda (len.35 i.37 vec.36)
                (if (eq? len.35 i.37)
                  vec.36
                  (begin
                    (unsafe-vector-set! vec.36 i.37 0)
                    (unsafe-procedure-call
                     vector-init-loop.34
                     len.35
                     (unsafe-fx+ i.37 1)
                     vec.36)))))
             (make-init-vector.4
              (lambda (tmp.32)
                (let ((tmp.33 (unsafe-make-vector tmp.32)))
                  (unsafe-procedure-call
                   vector-init-loop.34
                   tmp.32
                   0
                   tmp.33))))
             (make-vector.84
              (lambda (tmp.60)
                (if (fixnum? tmp.60)
                  (unsafe-procedure-call make-init-vector.4 tmp.60)
                  (error 8))))
             (fun/fixnum8511.8 (lambda () 138))
             (fun/fixnum8507.9
              (lambda (oprand0.14 oprand1.13)
                (unsafe-procedure-call fun/fixnum8508.10)))
             (fun/fixnum8508.10
              (lambda () (unsafe-procedure-call fun/fixnum8509.11)))
             (fun/fixnum8509.11 (lambda () 2))
             (fun/boolean8510.12 (lambda (oprand0.16 oprand1.15) #t)))
      (unsafe-procedure-call
       fun/fixnum8507.9
       (if (unsafe-procedure-call
            fun/boolean8510.12
            (let ((tmp.7.17 (unsafe-procedure-call make-vector.84 8)))
              (let ((g42439795.18
                     (unsafe-procedure-call vector-set!.85 tmp.7.17 0 0)))
                (if (unsafe-procedure-call error?.86 g42439795.18)
                  g42439795.18
                  (let ((g42439796.19
                         (unsafe-procedure-call vector-set!.85 tmp.7.17 1 1)))
                    (if (unsafe-procedure-call error?.86 g42439796.19)
                      g42439796.19
                      (let ((g42439797.20
                             (unsafe-procedure-call
                              vector-set!.85
                              tmp.7.17
                              2
                              2)))
                        (if (unsafe-procedure-call error?.86 g42439797.20)
                          g42439797.20
                          (let ((g42439798.21
                                 (unsafe-procedure-call
                                  vector-set!.85
                                  tmp.7.17
                                  3
                                  3)))
                            (if (unsafe-procedure-call error?.86 g42439798.21)
                              g42439798.21
                              (let ((g42439799.22
                                     (unsafe-procedure-call
                                      vector-set!.85
                                      tmp.7.17
                                      4
                                      4)))
                                (if (unsafe-procedure-call
                                     error?.86
                                     g42439799.22)
                                  g42439799.22
                                  (let ((g42439800.23
                                         (unsafe-procedure-call
                                          vector-set!.85
                                          tmp.7.17
                                          5
                                          5)))
                                    (if (unsafe-procedure-call
                                         error?.86
                                         g42439800.23)
                                      g42439800.23
                                      (let ((g42439801.24
                                             (unsafe-procedure-call
                                              vector-set!.85
                                              tmp.7.17
                                              6
                                              6)))
                                        (if (unsafe-procedure-call
                                             error?.86
                                             g42439801.24)
                                          g42439801.24
                                          (let ((g42439802.25
                                                 (unsafe-procedure-call
                                                  vector-set!.85
                                                  tmp.7.17
                                                  7
                                                  7)))
                                            (if (unsafe-procedure-call
                                                 error?.86
                                                 g42439802.25)
                                              g42439802.25
                                              tmp.7.17)))))))))))))))))
            (void))
         (let ((ascii-char0.28 #\f)
               (ascii-char1.27 #\L)
               (procedure2.26 (lambda () (error 84))))
           172)
         (unsafe-procedure-call fun/fixnum8511.8))
       (let ()
         (let ((error0.31 (error 108)) (fixnum1.30 32) (void2.29 (void)))
           (lambda () 674)))))))
(check-by-interp
 '(module
    (letrec ((<=.63
              (lambda (tmp.33 tmp.34)
                (if (fixnum? tmp.34)
                  (if (fixnum? tmp.33) (unsafe-fx<= tmp.33 tmp.34) (error 5))
                  (error 5))))
             (fun/empty8515.7 (lambda () empty))
             (fun/empty8514.8
              (lambda () (unsafe-procedure-call fun/empty8515.7))))
      (let ((boolean0.9
             (unsafe-procedure-call
              <=.63
              (let () 15)
              (let ((void0.10 (void))) 193))))
        (unsafe-procedure-call fun/empty8514.8)))))
(check-by-interp
 '(module
    (letrec ((error?.104 (lambda (tmp.91) (error? tmp.91)))
             (unsafe-vector-set!.5
              (lambda (tmp.55 tmp.56 tmp.57)
                (if (unsafe-fx< tmp.56 (unsafe-vector-length tmp.55))
                  (if (unsafe-fx>= tmp.56 0)
                    (begin (unsafe-vector-set! tmp.55 tmp.56 tmp.57) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.103
              (lambda (tmp.79 tmp.80 tmp.81)
                (if (fixnum? tmp.80)
                  (if (vector? tmp.79)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.79
                     tmp.80
                     tmp.81)
                    (error 10))
                  (error 10))))
             (vector-init-loop.51
              (lambda (len.52 i.54 vec.53)
                (if (eq? len.52 i.54)
                  vec.53
                  (begin
                    (unsafe-vector-set! vec.53 i.54 0)
                    (unsafe-procedure-call
                     vector-init-loop.51
                     len.52
                     (unsafe-fx+ i.54 1)
                     vec.53)))))
             (make-init-vector.4
              (lambda (tmp.49)
                (let ((tmp.50 (unsafe-make-vector tmp.49)))
                  (unsafe-procedure-call
                   vector-init-loop.51
                   tmp.49
                   0
                   tmp.50))))
             (make-vector.102
              (lambda (tmp.77)
                (if (fixnum? tmp.77)
                  (unsafe-procedure-call make-init-vector.4 tmp.77)
                  (error 8))))
             (cons.101 (lambda (tmp.96 tmp.97) (cons tmp.96 tmp.97)))
             (fun/ascii-char8518.9 (lambda () #\C))
             (fun/ascii-char8520.10 (lambda (oprand0.15) oprand0.15))
             (fun/fixnum8523.11 (lambda (oprand0.16) 219))
             (fun/ascii-char8522.12 (lambda (oprand0.17) #\]))
             (fun/ascii-char8521.13
              (lambda ()
                (unsafe-procedure-call
                 fun/ascii-char8522.12
                 (unsafe-procedure-call fun/fixnum8523.11 (error 113)))))
             (fun/ascii-char8519.14
              (lambda (oprand0.19 oprand1.18) (if #t oprand0.19 oprand0.19))))
      (if (let ((void0.21 (let () (void)))
                (pair1.20
                 (unsafe-procedure-call
                  cons.101
                  #\M
                  (unsafe-procedure-call
                   cons.101
                   #\\
                   (unsafe-procedure-call
                    cons.101
                    (unsafe-procedure-call
                     cons.101
                     118
                     (unsafe-procedure-call cons.101 358 empty))
                    (unsafe-procedure-call
                     cons.101
                     (unsafe-procedure-call
                      cons.101
                      16
                      (unsafe-procedure-call cons.101 483 empty))
                     (unsafe-procedure-call
                      cons.101
                      empty
                      (unsafe-procedure-call
                       cons.101
                       #t
                       (unsafe-procedure-call
                        cons.101
                        #t
                        (unsafe-procedure-call cons.101 #t empty))))))))))
            (unsafe-procedure-call fun/ascii-char8518.9))
        (if (if (unsafe-procedure-call
                 fun/ascii-char8519.14
                 #\d
                 (if #t
                   (unsafe-procedure-call
                    cons.101
                    212
                    (unsafe-procedure-call cons.101 434 empty))
                   (unsafe-procedure-call
                    cons.101
                    140
                    (unsafe-procedure-call cons.101 331 empty))))
              (if (let () #\T)
                (if (if #f #\_ #\J)
                  (let ((procedure0.23 (lambda (oprand0.24) 53))
                        (pair1.22
                         (unsafe-procedure-call
                          cons.101
                          151
                          (unsafe-procedure-call cons.101 317 empty))))
                    #\b)
                  #f)
                #f)
              #f)
          (if (let ((boolean0.25
                     (let ((empty0.27 empty)
                           (procedure1.26
                            (lambda ()
                              (let ((tmp.7.28
                                     (unsafe-procedure-call
                                      make-vector.102
                                      8)))
                                (let ((g42447437.29
                                       (unsafe-procedure-call
                                        vector-set!.103
                                        tmp.7.28
                                        0
                                        0)))
                                  (if (unsafe-procedure-call
                                       error?.104
                                       g42447437.29)
                                    g42447437.29
                                    (let ((g42447438.30
                                           (unsafe-procedure-call
                                            vector-set!.103
                                            tmp.7.28
                                            1
                                            1)))
                                      (if (unsafe-procedure-call
                                           error?.104
                                           g42447438.30)
                                        g42447438.30
                                        (let ((g42447439.31
                                               (unsafe-procedure-call
                                                vector-set!.103
                                                tmp.7.28
                                                2
                                                2)))
                                          (if (unsafe-procedure-call
                                               error?.104
                                               g42447439.31)
                                            g42447439.31
                                            (let ((g42447440.32
                                                   (unsafe-procedure-call
                                                    vector-set!.103
                                                    tmp.7.28
                                                    3
                                                    3)))
                                              (if (unsafe-procedure-call
                                                   error?.104
                                                   g42447440.32)
                                                g42447440.32
                                                (let ((g42447441.33
                                                       (unsafe-procedure-call
                                                        vector-set!.103
                                                        tmp.7.28
                                                        4
                                                        4)))
                                                  (if (unsafe-procedure-call
                                                       error?.104
                                                       g42447441.33)
                                                    g42447441.33
                                                    (let ((g42447442.34
                                                           (unsafe-procedure-call
                                                            vector-set!.103
                                                            tmp.7.28
                                                            5
                                                            5)))
                                                      (if (unsafe-procedure-call
                                                           error?.104
                                                           g42447442.34)
                                                        g42447442.34
                                                        (let ((g42447443.35
                                                               (unsafe-procedure-call
                                                                vector-set!.103
                                                                tmp.7.28
                                                                6
                                                                6)))
                                                          (if (unsafe-procedure-call
                                                               error?.104
                                                               g42447443.35)
                                                            g42447443.35
                                                            (let ((g42447444.36
                                                                   (unsafe-procedure-call
                                                                    vector-set!.103
                                                                    tmp.7.28
                                                                    7
                                                                    7)))
                                                              (if (unsafe-procedure-call
                                                                   error?.104
                                                                   g42447444.36)
                                                                g42447444.36
                                                                tmp.7.28))))))))))))))))))))
                       #t)))
                (unsafe-procedure-call fun/ascii-char8520.10 #\g))
            (if (unsafe-procedure-call fun/ascii-char8521.13)
              (if (if (let () #\k)
                    (if (let ((vector0.37
                               (let ((tmp.8.38
                                      (unsafe-procedure-call
                                       make-vector.102
                                       8)))
                                 (let ((g42447445.39
                                        (unsafe-procedure-call
                                         vector-set!.103
                                         tmp.8.38
                                         0
                                         1)))
                                   (if (unsafe-procedure-call
                                        error?.104
                                        g42447445.39)
                                     g42447445.39
                                     (let ((g42447446.40
                                            (unsafe-procedure-call
                                             vector-set!.103
                                             tmp.8.38
                                             1
                                             2)))
                                       (if (unsafe-procedure-call
                                            error?.104
                                            g42447446.40)
                                         g42447446.40
                                         (let ((g42447447.41
                                                (unsafe-procedure-call
                                                 vector-set!.103
                                                 tmp.8.38
                                                 2
                                                 3)))
                                           (if (unsafe-procedure-call
                                                error?.104
                                                g42447447.41)
                                             g42447447.41
                                             (let ((g42447448.42
                                                    (unsafe-procedure-call
                                                     vector-set!.103
                                                     tmp.8.38
                                                     3
                                                     4)))
                                               (if (unsafe-procedure-call
                                                    error?.104
                                                    g42447448.42)
                                                 g42447448.42
                                                 (let ((g42447449.43
                                                        (unsafe-procedure-call
                                                         vector-set!.103
                                                         tmp.8.38
                                                         4
                                                         5)))
                                                   (if (unsafe-procedure-call
                                                        error?.104
                                                        g42447449.43)
                                                     g42447449.43
                                                     (let ((g42447450.44
                                                            (unsafe-procedure-call
                                                             vector-set!.103
                                                             tmp.8.38
                                                             5
                                                             6)))
                                                       (if (unsafe-procedure-call
                                                            error?.104
                                                            g42447450.44)
                                                         g42447450.44
                                                         (let ((g42447451.45
                                                                (unsafe-procedure-call
                                                                 vector-set!.103
                                                                 tmp.8.38
                                                                 6
                                                                 7)))
                                                           (if (unsafe-procedure-call
                                                                error?.104
                                                                g42447451.45)
                                                             g42447451.45
                                                             (let ((g42447452.46
                                                                    (unsafe-procedure-call
                                                                     vector-set!.103
                                                                     tmp.8.38
                                                                     7
                                                                     8)))
                                                               (if (unsafe-procedure-call
                                                                    error?.104
                                                                    g42447452.46)
                                                                 g42447452.46
                                                                 tmp.8.38)))))))))))))))))))
                          #\\)
                      (if #t #\x #\n)
                      #f)
                    #f)
                (let ((ascii-char0.48 (if #t #\x #\o))
                      (void1.47 (let () (void))))
                  (if #t #\C #\Z))
                #f)
              #f)
            #f)
          #f)
        #f))))
(check-by-interp
 '(module
    (letrec ((cons.71 (lambda (tmp.66 tmp.67) (cons tmp.66 tmp.67)))
             (fun/ascii-char8527.7
              (lambda () (unsafe-procedure-call fun/ascii-char8528.8)))
             (fun/ascii-char8528.8
              (lambda ()
                (let ((pair0.13
                       (unsafe-procedure-call
                        cons.71
                        127
                        (unsafe-procedure-call cons.71 352 empty))))
                  #\Y)))
             (fun/ascii-char8526.9
              (lambda (oprand0.15 oprand1.14) (let () (let () oprand0.15))))
             (fun/void8530.10
              (lambda (oprand0.16) (unsafe-procedure-call fun/void8531.11)))
             (fun/void8531.11 (lambda () (void)))
             (fun/void8529.12
              (lambda ()
                (unsafe-procedure-call
                 fun/void8530.10
                 (let ((fixnum0.18 149) (empty1.17 empty)) (error 140))))))
      (unsafe-procedure-call
       fun/ascii-char8526.9
       (unsafe-procedure-call fun/ascii-char8527.7)
       (unsafe-procedure-call fun/void8529.12)))))
(check-by-interp
 '(module
    (letrec ((procedure?.136 (lambda (tmp.126) (procedure? tmp.126)))
             (unsafe-vector-set!.5
              (lambda (tmp.86 tmp.87 tmp.88)
                (if (unsafe-fx< tmp.87 (unsafe-vector-length tmp.86))
                  (if (unsafe-fx>= tmp.87 0)
                    (begin (unsafe-vector-set! tmp.86 tmp.87 tmp.88) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.135
              (lambda (tmp.110 tmp.111 tmp.112)
                (if (fixnum? tmp.111)
                  (if (vector? tmp.110)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.110
                     tmp.111
                     tmp.112)
                    (error 10))
                  (error 10))))
             (vector-init-loop.82
              (lambda (len.83 i.85 vec.84)
                (if (eq? len.83 i.85)
                  vec.84
                  (begin
                    (unsafe-vector-set! vec.84 i.85 0)
                    (unsafe-procedure-call
                     vector-init-loop.82
                     len.83
                     (unsafe-fx+ i.85 1)
                     vec.84)))))
             (make-init-vector.4
              (lambda (tmp.80)
                (let ((tmp.81 (unsafe-make-vector tmp.80)))
                  (unsafe-procedure-call
                   vector-init-loop.82
                   tmp.80
                   0
                   tmp.81))))
             (make-vector.134
              (lambda (tmp.108)
                (if (fixnum? tmp.108)
                  (unsafe-procedure-call make-init-vector.4 tmp.108)
                  (error 8))))
             (cons.133 (lambda (tmp.127 tmp.128) (cons tmp.127 tmp.128)))
             (error?.132 (lambda (tmp.122) (error? tmp.122)))
             (fun/ascii-char8545.12
              (lambda () (unsafe-procedure-call fun/ascii-char8546.21)))
             (fun/ascii-char8542.13
              (lambda (oprand0.28 oprand1.27)
                (unsafe-procedure-call fun/ascii-char8543.20)))
             (fun/ascii-char8536.14 (lambda () #\b))
             (fun/ascii-char8539.15
              (lambda (oprand0.30 oprand1.29) (let () #\l)))
             (fun/ascii-char8535.16
              (lambda () (unsafe-procedure-call fun/ascii-char8536.14)))
             (fun/boolean8540.17 (lambda (oprand0.32 oprand1.31) (let () #f)))
             (fun/void8537.18 (lambda () (void)))
             (fun/ascii-char8538.19 (lambda () #\J))
             (fun/ascii-char8543.20 (lambda () #\x))
             (fun/ascii-char8546.21 (lambda () #\O))
             (fun/boolean8548.22 (lambda () #t))
             (fun/boolean8547.23
              (lambda () (unsafe-procedure-call fun/boolean8548.22)))
             (fun/fixnum8541.24 (lambda () 67))
             (fun/ascii-char8544.25
              (lambda (oprand0.34 oprand1.33)
                (unsafe-procedure-call fun/ascii-char8545.12)))
             (fun/ascii-char8534.26
              (lambda (oprand0.36 oprand1.35)
                (unsafe-procedure-call fun/ascii-char8535.16))))
      (let ((g42455084.37
             (unsafe-procedure-call
              fun/ascii-char8534.26
              (if #f (lambda () 968) (lambda () 631))
              (let () empty))))
        (if (unsafe-procedure-call error?.132 g42455084.37)
          g42455084.37
          (let ((g42455085.38
                 (if (let ((boolean0.40 #f) (empty1.39 empty)) #f)
                   (let ((error0.42 (error 211)) (ascii-char1.41 #\U)) #\b)
                   (let ((g42455086.43 #\f))
                     (if (unsafe-procedure-call error?.132 g42455086.43)
                       g42455086.43
                       (let ((g42455087.44 #\`))
                         (if (unsafe-procedure-call error?.132 g42455087.44)
                           g42455087.44
                           (let ((g42455088.45 #\a))
                             (if (unsafe-procedure-call
                                  error?.132
                                  g42455088.45)
                               g42455088.45
                               (let ((g42455089.46 #\O))
                                 (if (unsafe-procedure-call
                                      error?.132
                                      g42455089.46)
                                   g42455089.46
                                   (let ((g42455090.47 #\`))
                                     (if (unsafe-procedure-call
                                          error?.132
                                          g42455090.47)
                                       g42455090.47
                                       (let ((g42455091.48 #\O))
                                         (if (unsafe-procedure-call
                                              error?.132
                                              g42455091.48)
                                           g42455091.48
                                           #\J)))))))))))))))
            (if (unsafe-procedure-call error?.132 g42455085.38)
              g42455085.38
              (let ((g42455092.49
                     (let ((pair0.52
                            (unsafe-procedure-call
                             cons.133
                             (unsafe-procedure-call
                              cons.133
                              8
                              (unsafe-procedure-call cons.133 450 empty))
                             (unsafe-procedure-call
                              cons.133
                              (unsafe-procedure-call
                               cons.133
                               143
                               (unsafe-procedure-call cons.133 368 empty))
                              (unsafe-procedure-call
                               cons.133
                               110
                               (unsafe-procedure-call
                                cons.133
                                empty
                                (unsafe-procedure-call
                                 cons.133
                                 empty
                                 (unsafe-procedure-call
                                  cons.133
                                  #t
                                  (unsafe-procedure-call
                                   cons.133
                                   #\B
                                   (unsafe-procedure-call
                                    cons.133
                                    empty
                                    empty)))))))))
                           (vector1.51
                            (let ((tmp.7.53
                                   (unsafe-procedure-call make-vector.134 8)))
                              (let ((g42455093.54
                                     (unsafe-procedure-call
                                      vector-set!.135
                                      tmp.7.53
                                      0
                                      (unsafe-procedure-call
                                       (lambda () 902)))))
                                (if (unsafe-procedure-call
                                     error?.132
                                     g42455093.54)
                                  g42455093.54
                                  (let ((g42455094.55
                                         (unsafe-procedure-call
                                          vector-set!.135
                                          tmp.7.53
                                          1
                                          (let ((tmp.137 (error 179)))
                                            (if (procedure? tmp.137)
                                              (if (eq?
                                                   (unsafe-procedure-arity
                                                    tmp.137)
                                                   0)
                                                (unsafe-procedure-call tmp.137)
                                                (error 42))
                                              (error 43))))))
                                    (if (unsafe-procedure-call
                                         error?.132
                                         g42455094.55)
                                      g42455094.55
                                      (let ((g42455095.56
                                             (unsafe-procedure-call
                                              vector-set!.135
                                              tmp.7.53
                                              2
                                              (let ((tmp.138
                                                     (unsafe-procedure-call
                                                      cons.133
                                                      17
                                                      (unsafe-procedure-call
                                                       cons.133
                                                       299
                                                       empty))))
                                                (if (procedure? tmp.138)
                                                  (if (eq?
                                                       (unsafe-procedure-arity
                                                        tmp.138)
                                                       0)
                                                    (unsafe-procedure-call
                                                     tmp.138)
                                                    (error 42))
                                                  (error 43))))))
                                        (if (unsafe-procedure-call
                                             error?.132
                                             g42455095.56)
                                          g42455095.56
                                          (let ((g42455096.57
                                                 (unsafe-procedure-call
                                                  vector-set!.135
                                                  tmp.7.53
                                                  3
                                                  (let ((tmp.139 #\E))
                                                    (if (procedure? tmp.139)
                                                      (if (eq?
                                                           (unsafe-procedure-arity
                                                            tmp.139)
                                                           0)
                                                        (unsafe-procedure-call
                                                         tmp.139)
                                                        (error 42))
                                                      (error 43))))))
                                            (if (unsafe-procedure-call
                                                 error?.132
                                                 g42455096.57)
                                              g42455096.57
                                              (let ((g42455097.58
                                                     (unsafe-procedure-call
                                                      vector-set!.135
                                                      tmp.7.53
                                                      4
                                                      (let ((tmp.140 (void)))
                                                        (if (procedure?
                                                             tmp.140)
                                                          (if (eq?
                                                               (unsafe-procedure-arity
                                                                tmp.140)
                                                               0)
                                                            (unsafe-procedure-call
                                                             tmp.140)
                                                            (error 42))
                                                          (error 43))))))
                                                (if (unsafe-procedure-call
                                                     error?.132
                                                     g42455097.58)
                                                  g42455097.58
                                                  (let ((g42455098.59
                                                         (unsafe-procedure-call
                                                          vector-set!.135
                                                          tmp.7.53
                                                          5
                                                          (let ((tmp.141
                                                                 (let ((tmp.8.60
                                                                        (unsafe-procedure-call
                                                                         make-vector.134
                                                                         8)))
                                                                   (let ((g42455099.61
                                                                          (unsafe-procedure-call
                                                                           vector-set!.135
                                                                           tmp.8.60
                                                                           0
                                                                           1)))
                                                                     (if (unsafe-procedure-call
                                                                          error?.132
                                                                          g42455099.61)
                                                                       g42455099.61
                                                                       (let ((g42455100.62
                                                                              (unsafe-procedure-call
                                                                               vector-set!.135
                                                                               tmp.8.60
                                                                               1
                                                                               2)))
                                                                         (if (unsafe-procedure-call
                                                                              error?.132
                                                                              g42455100.62)
                                                                           g42455100.62
                                                                           (let ((g42455101.63
                                                                                  (unsafe-procedure-call
                                                                                   vector-set!.135
                                                                                   tmp.8.60
                                                                                   2
                                                                                   3)))
                                                                             (if (unsafe-procedure-call
                                                                                  error?.132
                                                                                  g42455101.63)
                                                                               g42455101.63
                                                                               (let ((g42455102.64
                                                                                      (unsafe-procedure-call
                                                                                       vector-set!.135
                                                                                       tmp.8.60
                                                                                       3
                                                                                       4)))
                                                                                 (if (unsafe-procedure-call
                                                                                      error?.132
                                                                                      g42455102.64)
                                                                                   g42455102.64
                                                                                   (let ((g42455103.65
                                                                                          (unsafe-procedure-call
                                                                                           vector-set!.135
                                                                                           tmp.8.60
                                                                                           4
                                                                                           5)))
                                                                                     (if (unsafe-procedure-call
                                                                                          error?.132
                                                                                          g42455103.65)
                                                                                       g42455103.65
                                                                                       (let ((g42455104.66
                                                                                              (unsafe-procedure-call
                                                                                               vector-set!.135
                                                                                               tmp.8.60
                                                                                               5
                                                                                               6)))
                                                                                         (if (unsafe-procedure-call
                                                                                              error?.132
                                                                                              g42455104.66)
                                                                                           g42455104.66
                                                                                           (let ((g42455105.67
                                                                                                  (unsafe-procedure-call
                                                                                                   vector-set!.135
                                                                                                   tmp.8.60
                                                                                                   6
                                                                                                   7)))
                                                                                             (if (unsafe-procedure-call
                                                                                                  error?.132
                                                                                                  g42455105.67)
                                                                                               g42455105.67
                                                                                               (let ((g42455106.68
                                                                                                      (unsafe-procedure-call
                                                                                                       vector-set!.135
                                                                                                       tmp.8.60
                                                                                                       7
                                                                                                       8)))
                                                                                                 (if (unsafe-procedure-call
                                                                                                      error?.132
                                                                                                      g42455106.68)
                                                                                                   g42455106.68
                                                                                                   tmp.8.60)))))))))))))))))))
                                                            (if (procedure?
                                                                 tmp.141)
                                                              (if (eq?
                                                                   (unsafe-procedure-arity
                                                                    tmp.141)
                                                                   0)
                                                                (unsafe-procedure-call
                                                                 tmp.141)
                                                                (error 42))
                                                              (error 43))))))
                                                    (if (unsafe-procedure-call
                                                         error?.132
                                                         g42455098.59)
                                                      g42455098.59
                                                      (let ((g42455107.69
                                                             (unsafe-procedure-call
                                                              vector-set!.135
                                                              tmp.7.53
                                                              6
                                                              (let ((tmp.142
                                                                     empty))
                                                                (if (procedure?
                                                                     tmp.142)
                                                                  (if (eq?
                                                                       (unsafe-procedure-arity
                                                                        tmp.142)
                                                                       0)
                                                                    (unsafe-procedure-call
                                                                     tmp.142)
                                                                    (error 42))
                                                                  (error
                                                                   43))))))
                                                        (if (unsafe-procedure-call
                                                             error?.132
                                                             g42455107.69)
                                                          g42455107.69
                                                          (let ((g42455108.70
                                                                 (unsafe-procedure-call
                                                                  vector-set!.135
                                                                  tmp.7.53
                                                                  7
                                                                  (unsafe-procedure-call
                                                                   (lambda ()
                                                                     959)))))
                                                            (if (unsafe-procedure-call
                                                                 error?.132
                                                                 g42455108.70)
                                                              g42455108.70
                                                              tmp.7.53))))))))))))))))))
                           (void2.50 (unsafe-procedure-call fun/void8537.18)))
                       (unsafe-procedure-call fun/ascii-char8538.19))))
                (if (unsafe-procedure-call error?.132 g42455092.49)
                  g42455092.49
                  (let ((g42455109.71
                         (unsafe-procedure-call
                          fun/ascii-char8539.15
                          (if #f #f #t)
                          (unsafe-procedure-call
                           fun/boolean8540.17
                           (let ((tmp.9.72 empty))
                             (if tmp.9.72
                               tmp.9.72
                               (let ((tmp.10.73 empty))
                                 (if tmp.10.73
                                   tmp.10.73
                                   (let ((tmp.11.74 empty))
                                     (if tmp.11.74 tmp.11.74 empty))))))
                           (unsafe-procedure-call fun/fixnum8541.24)))))
                    (if (unsafe-procedure-call error?.132 g42455109.71)
                      g42455109.71
                      (let ((g42455110.75
                             (if (if #t #\i #\[)
                               (if (unsafe-procedure-call
                                    fun/ascii-char8542.13
                                    (let ((fixnum0.77 241) (boolean1.76 #f))
                                      (void))
                                    (if #f #f #f))
                                 (if (let ((boolean0.79 #f) (boolean1.78 #f))
                                       #\m)
                                   (if #t #\Y #\W)
                                   #f)
                                 #f)
                               #f)))
                        (if (unsafe-procedure-call error?.132 g42455110.75)
                          g42455110.75
                          (unsafe-procedure-call
                           fun/ascii-char8544.25
                           (unsafe-procedure-call
                            procedure?.136
                            (if #f (error 129) #\`))
                           (unsafe-procedure-call
                            fun/boolean8547.23)))))))))))))))
(check-by-interp
 '(module
    (letrec ((fun/empty8551.7
              (lambda () (unsafe-procedure-call fun/empty8552.8)))
             (fun/empty8552.8 (lambda () empty)))
      (let ((procedure0.9
             (lambda (oprand0.11 oprand1.10)
               (unsafe-procedure-call fun/empty8551.7))))
        (let () (error 218))))))
(check-by-interp
 '(module
    (letrec ((error?.91 (lambda (tmp.79) (error? tmp.79)))
             (unsafe-vector-set!.5
              (lambda (tmp.43 tmp.44 tmp.45)
                (if (unsafe-fx< tmp.44 (unsafe-vector-length tmp.43))
                  (if (unsafe-fx>= tmp.44 0)
                    (begin (unsafe-vector-set! tmp.43 tmp.44 tmp.45) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.90
              (lambda (tmp.67 tmp.68 tmp.69)
                (if (fixnum? tmp.68)
                  (if (vector? tmp.67)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.67
                     tmp.68
                     tmp.69)
                    (error 10))
                  (error 10))))
             (vector-init-loop.39
              (lambda (len.40 i.42 vec.41)
                (if (eq? len.40 i.42)
                  vec.41
                  (begin
                    (unsafe-vector-set! vec.41 i.42 0)
                    (unsafe-procedure-call
                     vector-init-loop.39
                     len.40
                     (unsafe-fx+ i.42 1)
                     vec.41)))))
             (make-init-vector.4
              (lambda (tmp.37)
                (let ((tmp.38 (unsafe-make-vector tmp.37)))
                  (unsafe-procedure-call
                   vector-init-loop.39
                   tmp.37
                   0
                   tmp.38))))
             (make-vector.89
              (lambda (tmp.65)
                (if (fixnum? tmp.65)
                  (unsafe-procedure-call make-init-vector.4 tmp.65)
                  (error 8))))
             (fun/empty8561.9 (lambda (oprand0.13) empty))
             (fun/error8560.10
              (lambda (oprand0.15 oprand1.14)
                (let () (if #f (error 4) (error 184)))))
             (fun/empty8562.11 (lambda (oprand0.17 oprand1.16) empty))
             (fun/boolean8563.12 (lambda (oprand0.18) #f)))
      (unsafe-procedure-call
       fun/error8560.10
       (if (if #f #f #f)
         (unsafe-procedure-call fun/empty8561.9 (void))
         (unsafe-procedure-call
          fun/empty8562.11
          (let ((tmp.7.19 (unsafe-procedure-call make-vector.89 8)))
            (let ((g42462740.20
                   (unsafe-procedure-call vector-set!.90 tmp.7.19 0 1)))
              (if (unsafe-procedure-call error?.91 g42462740.20)
                g42462740.20
                (let ((g42462741.21
                       (unsafe-procedure-call vector-set!.90 tmp.7.19 1 2)))
                  (if (unsafe-procedure-call error?.91 g42462741.21)
                    g42462741.21
                    (let ((g42462742.22
                           (unsafe-procedure-call
                            vector-set!.90
                            tmp.7.19
                            2
                            3)))
                      (if (unsafe-procedure-call error?.91 g42462742.22)
                        g42462742.22
                        (let ((g42462743.23
                               (unsafe-procedure-call
                                vector-set!.90
                                tmp.7.19
                                3
                                4)))
                          (if (unsafe-procedure-call error?.91 g42462743.23)
                            g42462743.23
                            (let ((g42462744.24
                                   (unsafe-procedure-call
                                    vector-set!.90
                                    tmp.7.19
                                    4
                                    5)))
                              (if (unsafe-procedure-call
                                   error?.91
                                   g42462744.24)
                                g42462744.24
                                (let ((g42462745.25
                                       (unsafe-procedure-call
                                        vector-set!.90
                                        tmp.7.19
                                        5
                                        6)))
                                  (if (unsafe-procedure-call
                                       error?.91
                                       g42462745.25)
                                    g42462745.25
                                    (let ((g42462746.26
                                           (unsafe-procedure-call
                                            vector-set!.90
                                            tmp.7.19
                                            6
                                            7)))
                                      (if (unsafe-procedure-call
                                           error?.91
                                           g42462746.26)
                                        g42462746.26
                                        (let ((g42462747.27
                                               (unsafe-procedure-call
                                                vector-set!.90
                                                tmp.7.19
                                                7
                                                8)))
                                          (if (unsafe-procedure-call
                                               error?.91
                                               g42462747.27)
                                            g42462747.27
                                            tmp.7.19)))))))))))))))))
          (lambda () 807)))
       (if (unsafe-procedure-call
            fun/boolean8563.12
            (let ((tmp.8.28 (unsafe-procedure-call make-vector.89 8)))
              (let ((g42462748.29
                     (unsafe-procedure-call vector-set!.90 tmp.8.28 0 1)))
                (if (unsafe-procedure-call error?.91 g42462748.29)
                  g42462748.29
                  (let ((g42462749.30
                         (unsafe-procedure-call vector-set!.90 tmp.8.28 1 2)))
                    (if (unsafe-procedure-call error?.91 g42462749.30)
                      g42462749.30
                      (let ((g42462750.31
                             (unsafe-procedure-call
                              vector-set!.90
                              tmp.8.28
                              2
                              3)))
                        (if (unsafe-procedure-call error?.91 g42462750.31)
                          g42462750.31
                          (let ((g42462751.32
                                 (unsafe-procedure-call
                                  vector-set!.90
                                  tmp.8.28
                                  3
                                  4)))
                            (if (unsafe-procedure-call error?.91 g42462751.32)
                              g42462751.32
                              (let ((g42462752.33
                                     (unsafe-procedure-call
                                      vector-set!.90
                                      tmp.8.28
                                      4
                                      5)))
                                (if (unsafe-procedure-call
                                     error?.91
                                     g42462752.33)
                                  g42462752.33
                                  (let ((g42462753.34
                                         (unsafe-procedure-call
                                          vector-set!.90
                                          tmp.8.28
                                          5
                                          6)))
                                    (if (unsafe-procedure-call
                                         error?.91
                                         g42462753.34)
                                      g42462753.34
                                      (let ((g42462754.35
                                             (unsafe-procedure-call
                                              vector-set!.90
                                              tmp.8.28
                                              6
                                              7)))
                                        (if (unsafe-procedure-call
                                             error?.91
                                             g42462754.35)
                                          g42462754.35
                                          (let ((g42462755.36
                                                 (unsafe-procedure-call
                                                  vector-set!.90
                                                  tmp.8.28
                                                  7
                                                  8)))
                                            (if (unsafe-procedure-call
                                                 error?.91
                                                 g42462755.36)
                                              g42462755.36
                                              tmp.8.28))))))))))))))))))
         (if #t #t #f)
         (let () #f))))))
(check-by-interp
 '(module
    (letrec ((fun/fixnum8572.7
              (lambda () (unsafe-procedure-call fun/fixnum8573.9)))
             (fun/fixnum8575.8 (lambda () 182))
             (fun/fixnum8573.9 (lambda () 219))
             (fun/fixnum8574.10
              (lambda () (unsafe-procedure-call fun/fixnum8575.8))))
      (let ((fixnum0.13 (unsafe-procedure-call fun/fixnum8572.7))
            (error1.12 (let () (error 252)))
            (empty2.11 (let () empty)))
        (unsafe-procedure-call fun/fixnum8574.10)))))
(check-by-interp
 '(module
    (letrec ((error?.71 (lambda (tmp.61) (error? tmp.61)))
             (fun/empty8585.7
              (lambda () (unsafe-procedure-call fun/empty8586.9)))
             (fun/empty8584.8
              (lambda (oprand0.10) (unsafe-procedure-call fun/empty8585.7)))
             (fun/empty8586.9 (lambda () empty)))
      (unsafe-procedure-call
       fun/empty8584.8
       (let ((error0.12
              (let ((g42470384.13 (error 207)))
                (if (unsafe-procedure-call error?.71 g42470384.13)
                  g42470384.13
                  (let ((g42470385.14 (error 104)))
                    (if (unsafe-procedure-call error?.71 g42470385.14)
                      g42470385.14
                      (let ((g42470386.15 (error 16)))
                        (if (unsafe-procedure-call error?.71 g42470386.15)
                          g42470386.15
                          (let ((g42470387.16 (error 167)))
                            (if (unsafe-procedure-call error?.71 g42470387.16)
                              g42470387.16
                              (error 61))))))))))
             (error1.11
              (if (error 129)
                (if (error 74)
                  (if (error 177)
                    (if (error 101) (if (error 159) (error 164) #f) #f)
                    #f)
                  #f)
                #f)))
         (let ((g42470388.17 (error 161)))
           (if (unsafe-procedure-call error?.71 g42470388.17)
             g42470388.17
             (let ((g42470389.18 (error 194)))
               (if (unsafe-procedure-call error?.71 g42470389.18)
                 g42470389.18
                 (error 177))))))))))
(check-by-interp
 '(module
    (letrec ((error?.114 (lambda (tmp.101) (error? tmp.101)))
             (unsafe-vector-set!.5
              (lambda (tmp.65 tmp.66 tmp.67)
                (if (unsafe-fx< tmp.66 (unsafe-vector-length tmp.65))
                  (if (unsafe-fx>= tmp.66 0)
                    (begin (unsafe-vector-set! tmp.65 tmp.66 tmp.67) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.113
              (lambda (tmp.89 tmp.90 tmp.91)
                (if (fixnum? tmp.90)
                  (if (vector? tmp.89)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.89
                     tmp.90
                     tmp.91)
                    (error 10))
                  (error 10))))
             (vector-init-loop.61
              (lambda (len.62 i.64 vec.63)
                (if (eq? len.62 i.64)
                  vec.63
                  (begin
                    (unsafe-vector-set! vec.63 i.64 0)
                    (unsafe-procedure-call
                     vector-init-loop.61
                     len.62
                     (unsafe-fx+ i.64 1)
                     vec.63)))))
             (make-init-vector.4
              (lambda (tmp.59)
                (let ((tmp.60 (unsafe-make-vector tmp.59)))
                  (unsafe-procedure-call
                   vector-init-loop.61
                   tmp.59
                   0
                   tmp.60))))
             (make-vector.112
              (lambda (tmp.87)
                (if (fixnum? tmp.87)
                  (unsafe-procedure-call make-init-vector.4 tmp.87)
                  (error 8))))
             (cons.111 (lambda (tmp.106 tmp.107) (cons tmp.106 tmp.107)))
             (fun/error8591.11 (lambda () (error 47)))
             (fun/pair8592.12
              (lambda (oprand0.15)
                (if #f
                  (unsafe-procedure-call
                   cons.111
                   232
                   (unsafe-procedure-call cons.111 299 empty))
                  (unsafe-procedure-call
                   cons.111
                   190
                   (unsafe-procedure-call cons.111 484 empty)))))
             (fun/error8589.13
              (lambda (oprand0.17 oprand1.16)
                (unsafe-procedure-call fun/error8590.14)))
             (fun/error8590.14
              (lambda () (unsafe-procedure-call fun/error8591.11))))
      (unsafe-procedure-call
       fun/error8589.13
       (unsafe-procedure-call
        fun/pair8592.12
        (let ((ascii-char0.19 #\_) (fixnum1.18 180)) (void)))
       (let ((vector0.21
              (let ((tmp.7.22 (unsafe-procedure-call make-vector.112 8)))
                (let ((g42474204.23
                       (unsafe-procedure-call
                        vector-set!.113
                        tmp.7.22
                        0
                        (let ((tmp.115 empty))
                          (if (procedure? tmp.115)
                            (if (eq? (unsafe-procedure-arity tmp.115) 0)
                              (unsafe-procedure-call tmp.115)
                              (error 42))
                            (error 43))))))
                  (if (unsafe-procedure-call error?.114 g42474204.23)
                    g42474204.23
                    (let ((g42474205.24
                           (unsafe-procedure-call
                            vector-set!.113
                            tmp.7.22
                            1
                            (let ((tmp.116 (error 230)))
                              (if (procedure? tmp.116)
                                (if (eq? (unsafe-procedure-arity tmp.116) 0)
                                  (unsafe-procedure-call tmp.116)
                                  (error 42))
                                (error 43))))))
                      (if (unsafe-procedure-call error?.114 g42474205.24)
                        g42474205.24
                        (let ((g42474206.25
                               (unsafe-procedure-call
                                vector-set!.113
                                tmp.7.22
                                2
                                (let ((tmp.117 (void)))
                                  (if (procedure? tmp.117)
                                    (if (eq?
                                         (unsafe-procedure-arity tmp.117)
                                         0)
                                      (unsafe-procedure-call tmp.117)
                                      (error 42))
                                    (error 43))))))
                          (if (unsafe-procedure-call error?.114 g42474206.25)
                            g42474206.25
                            (let ((g42474207.26
                                   (unsafe-procedure-call
                                    vector-set!.113
                                    tmp.7.22
                                    3
                                    (let ((tmp.118
                                           (unsafe-procedure-call
                                            cons.111
                                            167
                                            (unsafe-procedure-call
                                             cons.111
                                             385
                                             empty))))
                                      (if (procedure? tmp.118)
                                        (if (eq?
                                             (unsafe-procedure-arity tmp.118)
                                             0)
                                          (unsafe-procedure-call tmp.118)
                                          (error 42))
                                        (error 43))))))
                              (if (unsafe-procedure-call
                                   error?.114
                                   g42474207.26)
                                g42474207.26
                                (let ((g42474208.27
                                       (unsafe-procedure-call
                                        vector-set!.113
                                        tmp.7.22
                                        4
                                        (let ((tmp.119 (void)))
                                          (if (procedure? tmp.119)
                                            (if (eq?
                                                 (unsafe-procedure-arity
                                                  tmp.119)
                                                 0)
                                              (unsafe-procedure-call tmp.119)
                                              (error 42))
                                            (error 43))))))
                                  (if (unsafe-procedure-call
                                       error?.114
                                       g42474208.27)
                                    g42474208.27
                                    (let ((g42474209.28
                                           (unsafe-procedure-call
                                            vector-set!.113
                                            tmp.7.22
                                            5
                                            (let ((tmp.120 empty))
                                              (if (procedure? tmp.120)
                                                (if (eq?
                                                     (unsafe-procedure-arity
                                                      tmp.120)
                                                     0)
                                                  (unsafe-procedure-call
                                                   tmp.120)
                                                  (error 42))
                                                (error 43))))))
                                      (if (unsafe-procedure-call
                                           error?.114
                                           g42474209.28)
                                        g42474209.28
                                        (let ((g42474210.29
                                               (unsafe-procedure-call
                                                vector-set!.113
                                                tmp.7.22
                                                6
                                                (let ((tmp.121 #\c))
                                                  (if (procedure? tmp.121)
                                                    (if (eq?
                                                         (unsafe-procedure-arity
                                                          tmp.121)
                                                         0)
                                                      (unsafe-procedure-call
                                                       tmp.121)
                                                      (error 42))
                                                    (error 43))))))
                                          (if (unsafe-procedure-call
                                               error?.114
                                               g42474210.29)
                                            g42474210.29
                                            (let ((g42474211.30
                                                   (unsafe-procedure-call
                                                    vector-set!.113
                                                    tmp.7.22
                                                    7
                                                    (let ((tmp.122 #\t))
                                                      (if (procedure? tmp.122)
                                                        (if (eq?
                                                             (unsafe-procedure-arity
                                                              tmp.122)
                                                             0)
                                                          (unsafe-procedure-call
                                                           tmp.122)
                                                          (error 42))
                                                        (error 43))))))
                                              (if (unsafe-procedure-call
                                                   error?.114
                                                   g42474211.30)
                                                g42474211.30
                                                tmp.7.22))))))))))))))))))
             (vector1.20
              (let ((tmp.8.31 (unsafe-procedure-call make-vector.112 8)))
                (let ((g42474212.32
                       (unsafe-procedure-call
                        vector-set!.113
                        tmp.8.31
                        0
                        (let ((tmp.123 (error 207)))
                          (if (procedure? tmp.123)
                            (if (eq? (unsafe-procedure-arity tmp.123) 0)
                              (unsafe-procedure-call tmp.123)
                              (error 42))
                            (error 43))))))
                  (if (unsafe-procedure-call error?.114 g42474212.32)
                    g42474212.32
                    (let ((g42474213.33
                           (unsafe-procedure-call
                            vector-set!.113
                            tmp.8.31
                            1
                            (unsafe-procedure-call (lambda () 674)))))
                      (if (unsafe-procedure-call error?.114 g42474213.33)
                        g42474213.33
                        (let ((g42474214.34
                               (unsafe-procedure-call
                                vector-set!.113
                                tmp.8.31
                                2
                                (let ((tmp.124
                                       (let ((tmp.9.35
                                              (unsafe-procedure-call
                                               make-vector.112
                                               8)))
                                         (let ((g42474215.36
                                                (unsafe-procedure-call
                                                 vector-set!.113
                                                 tmp.9.35
                                                 0
                                                 1)))
                                           (if (unsafe-procedure-call
                                                error?.114
                                                g42474215.36)
                                             g42474215.36
                                             (let ((g42474216.37
                                                    (unsafe-procedure-call
                                                     vector-set!.113
                                                     tmp.9.35
                                                     1
                                                     2)))
                                               (if (unsafe-procedure-call
                                                    error?.114
                                                    g42474216.37)
                                                 g42474216.37
                                                 (let ((g42474217.38
                                                        (unsafe-procedure-call
                                                         vector-set!.113
                                                         tmp.9.35
                                                         2
                                                         3)))
                                                   (if (unsafe-procedure-call
                                                        error?.114
                                                        g42474217.38)
                                                     g42474217.38
                                                     (let ((g42474218.39
                                                            (unsafe-procedure-call
                                                             vector-set!.113
                                                             tmp.9.35
                                                             3
                                                             4)))
                                                       (if (unsafe-procedure-call
                                                            error?.114
                                                            g42474218.39)
                                                         g42474218.39
                                                         (let ((g42474219.40
                                                                (unsafe-procedure-call
                                                                 vector-set!.113
                                                                 tmp.9.35
                                                                 4
                                                                 5)))
                                                           (if (unsafe-procedure-call
                                                                error?.114
                                                                g42474219.40)
                                                             g42474219.40
                                                             (let ((g42474220.41
                                                                    (unsafe-procedure-call
                                                                     vector-set!.113
                                                                     tmp.9.35
                                                                     5
                                                                     6)))
                                                               (if (unsafe-procedure-call
                                                                    error?.114
                                                                    g42474220.41)
                                                                 g42474220.41
                                                                 (let ((g42474221.42
                                                                        (unsafe-procedure-call
                                                                         vector-set!.113
                                                                         tmp.9.35
                                                                         6
                                                                         7)))
                                                                   (if (unsafe-procedure-call
                                                                        error?.114
                                                                        g42474221.42)
                                                                     g42474221.42
                                                                     (let ((g42474222.43
                                                                            (unsafe-procedure-call
                                                                             vector-set!.113
                                                                             tmp.9.35
                                                                             7
                                                                             8)))
                                                                       (if (unsafe-procedure-call
                                                                            error?.114
                                                                            g42474222.43)
                                                                         g42474222.43
                                                                         tmp.9.35)))))))))))))))))))
                                  (if (procedure? tmp.124)
                                    (if (eq?
                                         (unsafe-procedure-arity tmp.124)
                                         0)
                                      (unsafe-procedure-call tmp.124)
                                      (error 42))
                                    (error 43))))))
                          (if (unsafe-procedure-call error?.114 g42474214.34)
                            g42474214.34
                            (let ((g42474223.44
                                   (unsafe-procedure-call
                                    vector-set!.113
                                    tmp.8.31
                                    3
                                    (let ((tmp.125
                                           (let ((tmp.10.45
                                                  (unsafe-procedure-call
                                                   make-vector.112
                                                   8)))
                                             (let ((g42474224.46
                                                    (unsafe-procedure-call
                                                     vector-set!.113
                                                     tmp.10.45
                                                     0
                                                     0)))
                                               (if (unsafe-procedure-call
                                                    error?.114
                                                    g42474224.46)
                                                 g42474224.46
                                                 (let ((g42474225.47
                                                        (unsafe-procedure-call
                                                         vector-set!.113
                                                         tmp.10.45
                                                         1
                                                         1)))
                                                   (if (unsafe-procedure-call
                                                        error?.114
                                                        g42474225.47)
                                                     g42474225.47
                                                     (let ((g42474226.48
                                                            (unsafe-procedure-call
                                                             vector-set!.113
                                                             tmp.10.45
                                                             2
                                                             2)))
                                                       (if (unsafe-procedure-call
                                                            error?.114
                                                            g42474226.48)
                                                         g42474226.48
                                                         (let ((g42474227.49
                                                                (unsafe-procedure-call
                                                                 vector-set!.113
                                                                 tmp.10.45
                                                                 3
                                                                 3)))
                                                           (if (unsafe-procedure-call
                                                                error?.114
                                                                g42474227.49)
                                                             g42474227.49
                                                             (let ((g42474228.50
                                                                    (unsafe-procedure-call
                                                                     vector-set!.113
                                                                     tmp.10.45
                                                                     4
                                                                     4)))
                                                               (if (unsafe-procedure-call
                                                                    error?.114
                                                                    g42474228.50)
                                                                 g42474228.50
                                                                 (let ((g42474229.51
                                                                        (unsafe-procedure-call
                                                                         vector-set!.113
                                                                         tmp.10.45
                                                                         5
                                                                         5)))
                                                                   (if (unsafe-procedure-call
                                                                        error?.114
                                                                        g42474229.51)
                                                                     g42474229.51
                                                                     (let ((g42474230.52
                                                                            (unsafe-procedure-call
                                                                             vector-set!.113
                                                                             tmp.10.45
                                                                             6
                                                                             6)))
                                                                       (if (unsafe-procedure-call
                                                                            error?.114
                                                                            g42474230.52)
                                                                         g42474230.52
                                                                         (let ((g42474231.53
                                                                                (unsafe-procedure-call
                                                                                 vector-set!.113
                                                                                 tmp.10.45
                                                                                 7
                                                                                 7)))
                                                                           (if (unsafe-procedure-call
                                                                                error?.114
                                                                                g42474231.53)
                                                                             g42474231.53
                                                                             tmp.10.45)))))))))))))))))))
                                      (if (procedure? tmp.125)
                                        (if (eq?
                                             (unsafe-procedure-arity tmp.125)
                                             0)
                                          (unsafe-procedure-call tmp.125)
                                          (error 42))
                                        (error 43))))))
                              (if (unsafe-procedure-call
                                   error?.114
                                   g42474223.44)
                                g42474223.44
                                (let ((g42474232.54
                                       (unsafe-procedure-call
                                        vector-set!.113
                                        tmp.8.31
                                        4
                                        (let ((tmp.126 #f))
                                          (if (procedure? tmp.126)
                                            (if (eq?
                                                 (unsafe-procedure-arity
                                                  tmp.126)
                                                 0)
                                              (unsafe-procedure-call tmp.126)
                                              (error 42))
                                            (error 43))))))
                                  (if (unsafe-procedure-call
                                       error?.114
                                       g42474232.54)
                                    g42474232.54
                                    (let ((g42474233.55
                                           (unsafe-procedure-call
                                            vector-set!.113
                                            tmp.8.31
                                            5
                                            (let ((tmp.127
                                                   (unsafe-procedure-call
                                                    cons.111
                                                    232
                                                    (unsafe-procedure-call
                                                     cons.111
                                                     259
                                                     empty))))
                                              (if (procedure? tmp.127)
                                                (if (eq?
                                                     (unsafe-procedure-arity
                                                      tmp.127)
                                                     0)
                                                  (unsafe-procedure-call
                                                   tmp.127)
                                                  (error 42))
                                                (error 43))))))
                                      (if (unsafe-procedure-call
                                           error?.114
                                           g42474233.55)
                                        g42474233.55
                                        (let ((g42474234.56
                                               (unsafe-procedure-call
                                                vector-set!.113
                                                tmp.8.31
                                                6
                                                (let ((tmp.128 #f))
                                                  (if (procedure? tmp.128)
                                                    (if (eq?
                                                         (unsafe-procedure-arity
                                                          tmp.128)
                                                         0)
                                                      (unsafe-procedure-call
                                                       tmp.128)
                                                      (error 42))
                                                    (error 43))))))
                                          (if (unsafe-procedure-call
                                               error?.114
                                               g42474234.56)
                                            g42474234.56
                                            (let ((g42474235.57
                                                   (unsafe-procedure-call
                                                    vector-set!.113
                                                    tmp.8.31
                                                    7
                                                    (let ((tmp.129 (void)))
                                                      (if (procedure? tmp.129)
                                                        (if (eq?
                                                             (unsafe-procedure-arity
                                                              tmp.129)
                                                             0)
                                                          (unsafe-procedure-call
                                                           tmp.129)
                                                          (error 42))
                                                        (error 43))))))
                                              (if (unsafe-procedure-call
                                                   error?.114
                                                   g42474235.57)
                                                g42474235.57
                                                tmp.8.31)))))))))))))))))))
         (let ((empty0.58 empty)) #\i))))))
(check-by-interp
 '(module
    (letrec ((error?.81 (lambda (tmp.68) (error? tmp.68)))
             (unsafe-vector-set!.5
              (lambda (tmp.32 tmp.33 tmp.34)
                (if (unsafe-fx< tmp.33 (unsafe-vector-length tmp.32))
                  (if (unsafe-fx>= tmp.33 0)
                    (begin (unsafe-vector-set! tmp.32 tmp.33 tmp.34) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.80
              (lambda (tmp.56 tmp.57 tmp.58)
                (if (fixnum? tmp.57)
                  (if (vector? tmp.56)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.56
                     tmp.57
                     tmp.58)
                    (error 10))
                  (error 10))))
             (vector-init-loop.28
              (lambda (len.29 i.31 vec.30)
                (if (eq? len.29 i.31)
                  vec.30
                  (begin
                    (unsafe-vector-set! vec.30 i.31 0)
                    (unsafe-procedure-call
                     vector-init-loop.28
                     len.29
                     (unsafe-fx+ i.31 1)
                     vec.30)))))
             (make-init-vector.4
              (lambda (tmp.26)
                (let ((tmp.27 (unsafe-make-vector tmp.26)))
                  (unsafe-procedure-call
                   vector-init-loop.28
                   tmp.26
                   0
                   tmp.27))))
             (make-vector.79
              (lambda (tmp.54)
                (if (fixnum? tmp.54)
                  (unsafe-procedure-call make-init-vector.4 tmp.54)
                  (error 8))))
             (cons.78 (lambda (tmp.73 tmp.74) (cons tmp.73 tmp.74)))
             (fun/empty8599.8
              (lambda (oprand0.11)
                (if (let () #f)
                  (unsafe-procedure-call fun/empty8600.9)
                  (unsafe-procedure-call fun/empty8601.10))))
             (fun/empty8600.9 (lambda () empty))
             (fun/empty8601.10 (lambda () empty)))
      (unsafe-procedure-call
       fun/empty8599.8
       (if (if #t #t #f)
         (let ((boolean0.14 #f)
               (empty1.13 empty)
               (pair2.12
                (unsafe-procedure-call
                 cons.78
                 41
                 (unsafe-procedure-call cons.78 412 empty))))
           165)
         (let ((vector0.16
                (let ((tmp.7.17 (unsafe-procedure-call make-vector.79 8)))
                  (let ((g42478053.18
                         (unsafe-procedure-call vector-set!.80 tmp.7.17 0 1)))
                    (if (unsafe-procedure-call error?.81 g42478053.18)
                      g42478053.18
                      (let ((g42478054.19
                             (unsafe-procedure-call
                              vector-set!.80
                              tmp.7.17
                              1
                              2)))
                        (if (unsafe-procedure-call error?.81 g42478054.19)
                          g42478054.19
                          (let ((g42478055.20
                                 (unsafe-procedure-call
                                  vector-set!.80
                                  tmp.7.17
                                  2
                                  3)))
                            (if (unsafe-procedure-call error?.81 g42478055.20)
                              g42478055.20
                              (let ((g42478056.21
                                     (unsafe-procedure-call
                                      vector-set!.80
                                      tmp.7.17
                                      3
                                      4)))
                                (if (unsafe-procedure-call
                                     error?.81
                                     g42478056.21)
                                  g42478056.21
                                  (let ((g42478057.22
                                         (unsafe-procedure-call
                                          vector-set!.80
                                          tmp.7.17
                                          4
                                          5)))
                                    (if (unsafe-procedure-call
                                         error?.81
                                         g42478057.22)
                                      g42478057.22
                                      (let ((g42478058.23
                                             (unsafe-procedure-call
                                              vector-set!.80
                                              tmp.7.17
                                              5
                                              6)))
                                        (if (unsafe-procedure-call
                                             error?.81
                                             g42478058.23)
                                          g42478058.23
                                          (let ((g42478059.24
                                                 (unsafe-procedure-call
                                                  vector-set!.80
                                                  tmp.7.17
                                                  6
                                                  7)))
                                            (if (unsafe-procedure-call
                                                 error?.81
                                                 g42478059.24)
                                              g42478059.24
                                              (let ((g42478060.25
                                                     (unsafe-procedure-call
                                                      vector-set!.80
                                                      tmp.7.17
                                                      7
                                                      8)))
                                                (if (unsafe-procedure-call
                                                     error?.81
                                                     g42478060.25)
                                                  g42478060.25
                                                  tmp.7.17))))))))))))))))))
               (fixnum1.15 112))
           110))))))
(check-by-interp
 '(module
    (letrec ((cons.77 (lambda (tmp.72 tmp.73) (cons tmp.72 tmp.73)))
             (fun/boolean8604.10
              (lambda () (unsafe-procedure-call fun/boolean8605.12 #f)))
             (fun/ascii-char8607.11 (lambda (oprand0.15 oprand1.14) #\J))
             (fun/boolean8605.12 (lambda (oprand0.16) oprand0.16))
             (fun/ascii-char8606.13 (lambda (oprand0.18 oprand1.17) #\d)))
      (if (unsafe-procedure-call fun/boolean8604.10)
        (let ((empty0.19 empty)) #\g)
        (let ((tmp.7.20 #\R))
          (if tmp.7.20
            tmp.7.20
            (let ((tmp.8.21
                   (unsafe-procedure-call fun/ascii-char8606.13 (void) #t)))
              (if tmp.8.21
                tmp.8.21
                (let ((tmp.9.22
                       (unsafe-procedure-call
                        fun/ascii-char8607.11
                        (unsafe-procedure-call
                         cons.77
                         124
                         (unsafe-procedure-call cons.77 438 empty))
                        (lambda () 729))))
                  (if tmp.9.22
                    tmp.9.22
                    (let ((error0.24 (error 165)) (error1.23 (error 92)))
                      #\n)))))))))))
(check-by-interp
 '(module
    (letrec ((fun/boolean8612.7 (lambda (oprand0.10) #f))
             (fun/boolean8611.8
              (lambda () (unsafe-procedure-call fun/boolean8612.7 empty)))
             (fun/boolean8610.9 (lambda () (if #f #t #f))))
      (if (unsafe-procedure-call fun/boolean8610.9)
        (unsafe-procedure-call fun/boolean8611.8)
        (if #t #t #t)))))
(check-by-interp
 '(module
    (letrec ((void?.77 (lambda (tmp.64) (void? tmp.64)))
             (cons.76 (lambda (tmp.71 tmp.72) (cons tmp.71 tmp.72)))
             (fun/boolean8615.10 (lambda (oprand0.17 oprand1.16) oprand0.17))
             (fun/boolean8620.11 (lambda () #t))
             (fun/pair8619.12
              (lambda ()
                (unsafe-procedure-call
                 cons.76
                 87
                 (unsafe-procedure-call cons.76 327 empty))))
             (fun/boolean8617.13
              (lambda (oprand0.19 oprand1.18)
                (unsafe-procedure-call fun/boolean8618.14)))
             (fun/boolean8618.14 (lambda () #f))
             (fun/any8616.15 (lambda (oprand0.20) #f)))
      (let ((tmp.7.21
             (unsafe-procedure-call
              fun/boolean8615.10
              (let () #t)
              (if #f #f #t))))
        (if tmp.7.21
          tmp.7.21
          (let ((tmp.8.22
                 (unsafe-procedure-call
                  void?.77
                  (unsafe-procedure-call fun/any8616.15 (lambda () 764)))))
            (if tmp.8.22
              tmp.8.22
              (let ((tmp.9.23
                     (unsafe-procedure-call
                      fun/boolean8617.13
                      (unsafe-procedure-call fun/pair8619.12)
                      (if #f (error 130) (error 231)))))
                (if tmp.9.23
                  tmp.9.23
                  (unsafe-procedure-call fun/boolean8620.11))))))))))
(check-by-interp
 '(module
    (letrec ((|-.212|
              (lambda (tmp.174 tmp.175)
                (if (fixnum? tmp.175)
                  (if (fixnum? tmp.174) (unsafe-fx- tmp.174 tmp.175) (error 3))
                  (error 3))))
             (cons.211 (lambda (tmp.203 tmp.204) (cons tmp.203 tmp.204)))
             (error?.210 (lambda (tmp.198) (error? tmp.198)))
             (unsafe-vector-set!.5
              (lambda (tmp.162 tmp.163 tmp.164)
                (if (unsafe-fx< tmp.163 (unsafe-vector-length tmp.162))
                  (if (unsafe-fx>= tmp.163 0)
                    (begin (unsafe-vector-set! tmp.162 tmp.163 tmp.164) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.209
              (lambda (tmp.186 tmp.187 tmp.188)
                (if (fixnum? tmp.187)
                  (if (vector? tmp.186)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.186
                     tmp.187
                     tmp.188)
                    (error 10))
                  (error 10))))
             (vector-init-loop.158
              (lambda (len.159 i.161 vec.160)
                (if (eq? len.159 i.161)
                  vec.160
                  (begin
                    (unsafe-vector-set! vec.160 i.161 0)
                    (unsafe-procedure-call
                     vector-init-loop.158
                     len.159
                     (unsafe-fx+ i.161 1)
                     vec.160)))))
             (make-init-vector.4
              (lambda (tmp.156)
                (let ((tmp.157 (unsafe-make-vector tmp.156)))
                  (unsafe-procedure-call
                   vector-init-loop.158
                   tmp.156
                   0
                   tmp.157))))
             (make-vector.208
              (lambda (tmp.184)
                (if (fixnum? tmp.184)
                  (unsafe-procedure-call make-init-vector.4 tmp.184)
                  (error 8))))
             (fun/fixnum8628.37 (lambda (oprand0.44 oprand1.43) 40))
             (fun/fixnum8625.38 (lambda (oprand0.46 oprand1.45) 150))
             (fun/boolean8624.39 (lambda () #f))
             (fun/fixnum8623.40
              (lambda (oprand0.48 oprand1.47)
                (if (unsafe-procedure-call fun/boolean8624.39)
                  oprand1.47
                  oprand1.47)))
             (fun/fixnum8626.41 (lambda () 248))
             (fun/fixnum8627.42 (lambda () 9)))
      (unsafe-procedure-call
       fun/fixnum8623.40
       (if (let ((tmp.7.49 (if #f (error 187) (error 49))))
             (if tmp.7.49
               tmp.7.49
               (let ((tmp.8.50
                      (let ((boolean0.53 #f)
                            (ascii-char1.52 #\K)
                            (procedure2.51 (lambda () 176)))
                        (error 222))))
                 (if tmp.8.50
                   tmp.8.50
                   (let ((tmp.9.54 (let () (error 137))))
                     (if tmp.9.54
                       tmp.9.54
                       (let ((tmp.10.55 (let () (error 215))))
                         (if tmp.10.55
                           tmp.10.55
                           (let ((tmp.11.56
                                  (let ((vector0.58
                                         (let ((tmp.12.59
                                                (unsafe-procedure-call
                                                 make-vector.208
                                                 8)))
                                           (let ((g42493326.60
                                                  (unsafe-procedure-call
                                                   vector-set!.209
                                                   tmp.12.59
                                                   0
                                                   0)))
                                             (if (unsafe-procedure-call
                                                  error?.210
                                                  g42493326.60)
                                               g42493326.60
                                               (let ((g42493327.61
                                                      (unsafe-procedure-call
                                                       vector-set!.209
                                                       tmp.12.59
                                                       1
                                                       1)))
                                                 (if (unsafe-procedure-call
                                                      error?.210
                                                      g42493327.61)
                                                   g42493327.61
                                                   (let ((g42493328.62
                                                          (unsafe-procedure-call
                                                           vector-set!.209
                                                           tmp.12.59
                                                           2
                                                           2)))
                                                     (if (unsafe-procedure-call
                                                          error?.210
                                                          g42493328.62)
                                                       g42493328.62
                                                       (let ((g42493329.63
                                                              (unsafe-procedure-call
                                                               vector-set!.209
                                                               tmp.12.59
                                                               3
                                                               3)))
                                                         (if (unsafe-procedure-call
                                                              error?.210
                                                              g42493329.63)
                                                           g42493329.63
                                                           (let ((g42493330.64
                                                                  (unsafe-procedure-call
                                                                   vector-set!.209
                                                                   tmp.12.59
                                                                   4
                                                                   4)))
                                                             (if (unsafe-procedure-call
                                                                  error?.210
                                                                  g42493330.64)
                                                               g42493330.64
                                                               (let ((g42493331.65
                                                                      (unsafe-procedure-call
                                                                       vector-set!.209
                                                                       tmp.12.59
                                                                       5
                                                                       5)))
                                                                 (if (unsafe-procedure-call
                                                                      error?.210
                                                                      g42493331.65)
                                                                   g42493331.65
                                                                   (let ((g42493332.66
                                                                          (unsafe-procedure-call
                                                                           vector-set!.209
                                                                           tmp.12.59
                                                                           6
                                                                           6)))
                                                                     (if (unsafe-procedure-call
                                                                          error?.210
                                                                          g42493332.66)
                                                                       g42493332.66
                                                                       (let ((g42493333.67
                                                                              (unsafe-procedure-call
                                                                               vector-set!.209
                                                                               tmp.12.59
                                                                               7
                                                                               7)))
                                                                         (if (unsafe-procedure-call
                                                                              error?.210
                                                                              g42493333.67)
                                                                           g42493333.67
                                                                           tmp.12.59))))))))))))))))))
                                        (error1.57 (error 145)))
                                    (error 187))))
                             (if tmp.11.56
                               tmp.11.56
                               (let ((tmp.13.68
                                      (if #t (error 104) (error 57))))
                                 (if tmp.13.68
                                   tmp.13.68
                                   (let () (error 110))))))))))))))
         (if (let ((error0.70 (error 197)) (error1.69 (error 17))) (error 143))
           (if (if #t (error 11) (error 74))
             (let ((boolean0.73 #f) (boolean1.72 #f) (fixnum2.71 69))
               (error 137))
             #f)
           #f)
         #f)
       (if (let ((tmp.14.74
                  (unsafe-procedure-call
                   fun/fixnum8625.38
                   (error 175)
                   (let ((tmp.15.75 (unsafe-procedure-call make-vector.208 8)))
                     (let ((g42493334.76
                            (unsafe-procedure-call
                             vector-set!.209
                             tmp.15.75
                             0
                             1)))
                       (if (unsafe-procedure-call error?.210 g42493334.76)
                         g42493334.76
                         (let ((g42493335.77
                                (unsafe-procedure-call
                                 vector-set!.209
                                 tmp.15.75
                                 1
                                 2)))
                           (if (unsafe-procedure-call error?.210 g42493335.77)
                             g42493335.77
                             (let ((g42493336.78
                                    (unsafe-procedure-call
                                     vector-set!.209
                                     tmp.15.75
                                     2
                                     3)))
                               (if (unsafe-procedure-call
                                    error?.210
                                    g42493336.78)
                                 g42493336.78
                                 (let ((g42493337.79
                                        (unsafe-procedure-call
                                         vector-set!.209
                                         tmp.15.75
                                         3
                                         4)))
                                   (if (unsafe-procedure-call
                                        error?.210
                                        g42493337.79)
                                     g42493337.79
                                     (let ((g42493338.80
                                            (unsafe-procedure-call
                                             vector-set!.209
                                             tmp.15.75
                                             4
                                             5)))
                                       (if (unsafe-procedure-call
                                            error?.210
                                            g42493338.80)
                                         g42493338.80
                                         (let ((g42493339.81
                                                (unsafe-procedure-call
                                                 vector-set!.209
                                                 tmp.15.75
                                                 5
                                                 6)))
                                           (if (unsafe-procedure-call
                                                error?.210
                                                g42493339.81)
                                             g42493339.81
                                             (let ((g42493340.82
                                                    (unsafe-procedure-call
                                                     vector-set!.209
                                                     tmp.15.75
                                                     6
                                                     7)))
                                               (if (unsafe-procedure-call
                                                    error?.210
                                                    g42493340.82)
                                                 g42493340.82
                                                 (let ((g42493341.83
                                                        (unsafe-procedure-call
                                                         vector-set!.209
                                                         tmp.15.75
                                                         7
                                                         8)))
                                                   (if (unsafe-procedure-call
                                                        error?.210
                                                        g42493341.83)
                                                     g42493341.83
                                                     tmp.15.75))))))))))))))))))))
             (if tmp.14.74
               tmp.14.74
               (let ((tmp.16.84 (unsafe-procedure-call fun/fixnum8626.41)))
                 (if tmp.16.84
                   tmp.16.84
                   (let ((tmp.17.85 (unsafe-procedure-call fun/fixnum8627.42)))
                     (if tmp.17.85
                       tmp.17.85
                       (let ((tmp.18.86 (if #f 197 59)))
                         (if tmp.18.86
                           tmp.18.86
                           (let ((empty0.89 empty)
                                 (error1.88 (error 52))
                                 (boolean2.87 #f))
                             82)))))))))
         (if (if 32
               (if (unsafe-procedure-call
                    fun/fixnum8628.37
                    (let ((tmp.19.90
                           (unsafe-procedure-call make-vector.208 8)))
                      (let ((g42493342.91
                             (unsafe-procedure-call
                              vector-set!.209
                              tmp.19.90
                              0
                              0)))
                        (if (unsafe-procedure-call error?.210 g42493342.91)
                          g42493342.91
                          (let ((g42493343.92
                                 (unsafe-procedure-call
                                  vector-set!.209
                                  tmp.19.90
                                  1
                                  1)))
                            (if (unsafe-procedure-call error?.210 g42493343.92)
                              g42493343.92
                              (let ((g42493344.93
                                     (unsafe-procedure-call
                                      vector-set!.209
                                      tmp.19.90
                                      2
                                      2)))
                                (if (unsafe-procedure-call
                                     error?.210
                                     g42493344.93)
                                  g42493344.93
                                  (let ((g42493345.94
                                         (unsafe-procedure-call
                                          vector-set!.209
                                          tmp.19.90
                                          3
                                          3)))
                                    (if (unsafe-procedure-call
                                         error?.210
                                         g42493345.94)
                                      g42493345.94
                                      (let ((g42493346.95
                                             (unsafe-procedure-call
                                              vector-set!.209
                                              tmp.19.90
                                              4
                                              4)))
                                        (if (unsafe-procedure-call
                                             error?.210
                                             g42493346.95)
                                          g42493346.95
                                          (let ((g42493347.96
                                                 (unsafe-procedure-call
                                                  vector-set!.209
                                                  tmp.19.90
                                                  5
                                                  5)))
                                            (if (unsafe-procedure-call
                                                 error?.210
                                                 g42493347.96)
                                              g42493347.96
                                              (let ((g42493348.97
                                                     (unsafe-procedure-call
                                                      vector-set!.209
                                                      tmp.19.90
                                                      6
                                                      6)))
                                                (if (unsafe-procedure-call
                                                     error?.210
                                                     g42493348.97)
                                                  g42493348.97
                                                  (let ((g42493349.98
                                                         (unsafe-procedure-call
                                                          vector-set!.209
                                                          tmp.19.90
                                                          7
                                                          7)))
                                                    (if (unsafe-procedure-call
                                                         error?.210
                                                         g42493349.98)
                                                      g42493349.98
                                                      tmp.19.90)))))))))))))))))
                    empty)
                 (if (let ((pair0.100
                            (unsafe-procedure-call
                             cons.211
                             182
                             (unsafe-procedure-call cons.211 324 empty)))
                           (error1.99 (error 85)))
                       6)
                   (if 113
                     (if (let ((boolean0.102 #f) (error1.101 (error 212))) 58)
                       (if #f 124 111)
                       #f)
                     #f)
                   #f)
                 #f)
               #f)
           (if (if #t 60 147)
             (if (let ((g42493350.103 (if #f 74 149)))
                   (if (unsafe-procedure-call error?.210 g42493350.103)
                     g42493350.103
                     (let ((g42493351.104
                            (if 18 (if 18 (if 233 (if 91 193 #f) #f) #f) #f)))
                       (if (unsafe-procedure-call error?.210 g42493351.104)
                         g42493351.104
                         (let ((g42493352.105
                                (let ((tmp.20.106 235))
                                  (if tmp.20.106 tmp.20.106 137))))
                           (if (unsafe-procedure-call error?.210 g42493352.105)
                             g42493352.105
                             (let ((g42493353.107 (if #t 238 229)))
                               (if (unsafe-procedure-call
                                    error?.210
                                    g42493353.107)
                                 g42493353.107
                                 (let ((vector0.110
                                        (let ((tmp.21.111
                                               (unsafe-procedure-call
                                                make-vector.208
                                                8)))
                                          (let ((g42493354.112
                                                 (unsafe-procedure-call
                                                  vector-set!.209
                                                  tmp.21.111
                                                  0
                                                  1)))
                                            (if (unsafe-procedure-call
                                                 error?.210
                                                 g42493354.112)
                                              g42493354.112
                                              (let ((g42493355.113
                                                     (unsafe-procedure-call
                                                      vector-set!.209
                                                      tmp.21.111
                                                      1
                                                      2)))
                                                (if (unsafe-procedure-call
                                                     error?.210
                                                     g42493355.113)
                                                  g42493355.113
                                                  (let ((g42493356.114
                                                         (unsafe-procedure-call
                                                          vector-set!.209
                                                          tmp.21.111
                                                          2
                                                          3)))
                                                    (if (unsafe-procedure-call
                                                         error?.210
                                                         g42493356.114)
                                                      g42493356.114
                                                      (let ((g42493357.115
                                                             (unsafe-procedure-call
                                                              vector-set!.209
                                                              tmp.21.111
                                                              3
                                                              4)))
                                                        (if (unsafe-procedure-call
                                                             error?.210
                                                             g42493357.115)
                                                          g42493357.115
                                                          (let ((g42493358.116
                                                                 (unsafe-procedure-call
                                                                  vector-set!.209
                                                                  tmp.21.111
                                                                  4
                                                                  5)))
                                                            (if (unsafe-procedure-call
                                                                 error?.210
                                                                 g42493358.116)
                                                              g42493358.116
                                                              (let ((g42493359.117
                                                                     (unsafe-procedure-call
                                                                      vector-set!.209
                                                                      tmp.21.111
                                                                      5
                                                                      6)))
                                                                (if (unsafe-procedure-call
                                                                     error?.210
                                                                     g42493359.117)
                                                                  g42493359.117
                                                                  (let ((g42493360.118
                                                                         (unsafe-procedure-call
                                                                          vector-set!.209
                                                                          tmp.21.111
                                                                          6
                                                                          7)))
                                                                    (if (unsafe-procedure-call
                                                                         error?.210
                                                                         g42493360.118)
                                                                      g42493360.118
                                                                      (let ((g42493361.119
                                                                             (unsafe-procedure-call
                                                                              vector-set!.209
                                                                              tmp.21.111
                                                                              7
                                                                              8)))
                                                                        (if (unsafe-procedure-call
                                                                             error?.210
                                                                             g42493361.119)
                                                                          g42493361.119
                                                                          tmp.21.111))))))))))))))))))
                                       (empty1.109 empty)
                                       (vector2.108
                                        (let ((tmp.22.120
                                               (unsafe-procedure-call
                                                make-vector.208
                                                8)))
                                          (let ((g42493362.121
                                                 (unsafe-procedure-call
                                                  vector-set!.209
                                                  tmp.22.120
                                                  0
                                                  0)))
                                            (if (unsafe-procedure-call
                                                 error?.210
                                                 g42493362.121)
                                              g42493362.121
                                              (let ((g42493363.122
                                                     (unsafe-procedure-call
                                                      vector-set!.209
                                                      tmp.22.120
                                                      1
                                                      1)))
                                                (if (unsafe-procedure-call
                                                     error?.210
                                                     g42493363.122)
                                                  g42493363.122
                                                  (let ((g42493364.123
                                                         (unsafe-procedure-call
                                                          vector-set!.209
                                                          tmp.22.120
                                                          2
                                                          2)))
                                                    (if (unsafe-procedure-call
                                                         error?.210
                                                         g42493364.123)
                                                      g42493364.123
                                                      (let ((g42493365.124
                                                             (unsafe-procedure-call
                                                              vector-set!.209
                                                              tmp.22.120
                                                              3
                                                              3)))
                                                        (if (unsafe-procedure-call
                                                             error?.210
                                                             g42493365.124)
                                                          g42493365.124
                                                          (let ((g42493366.125
                                                                 (unsafe-procedure-call
                                                                  vector-set!.209
                                                                  tmp.22.120
                                                                  4
                                                                  4)))
                                                            (if (unsafe-procedure-call
                                                                 error?.210
                                                                 g42493366.125)
                                                              g42493366.125
                                                              (let ((g42493367.126
                                                                     (unsafe-procedure-call
                                                                      vector-set!.209
                                                                      tmp.22.120
                                                                      5
                                                                      5)))
                                                                (if (unsafe-procedure-call
                                                                     error?.210
                                                                     g42493367.126)
                                                                  g42493367.126
                                                                  (let ((g42493368.127
                                                                         (unsafe-procedure-call
                                                                          vector-set!.209
                                                                          tmp.22.120
                                                                          6
                                                                          6)))
                                                                    (if (unsafe-procedure-call
                                                                         error?.210
                                                                         g42493368.127)
                                                                      g42493368.127
                                                                      (let ((g42493369.128
                                                                             (unsafe-procedure-call
                                                                              vector-set!.209
                                                                              tmp.22.120
                                                                              7
                                                                              7)))
                                                                        (if (unsafe-procedure-call
                                                                             error?.210
                                                                             g42493369.128)
                                                                          g42493369.128
                                                                          tmp.22.120)))))))))))))))))))
                                   217)))))))))
               (if (unsafe-procedure-call
                    |-.212|
                    (let ((void0.130 (void))
                          (pair1.129 (unsafe-procedure-call cons.211 #\O #f)))
                      76)
                    (let ((empty0.133 empty)
                          (boolean1.132 #t)
                          (vector2.131
                           (let ((tmp.23.134
                                  (unsafe-procedure-call make-vector.208 8)))
                             (let ((g42493370.135
                                    (unsafe-procedure-call
                                     vector-set!.209
                                     tmp.23.134
                                     0
                                     1)))
                               (if (unsafe-procedure-call
                                    error?.210
                                    g42493370.135)
                                 g42493370.135
                                 (let ((g42493371.136
                                        (unsafe-procedure-call
                                         vector-set!.209
                                         tmp.23.134
                                         1
                                         2)))
                                   (if (unsafe-procedure-call
                                        error?.210
                                        g42493371.136)
                                     g42493371.136
                                     (let ((g42493372.137
                                            (unsafe-procedure-call
                                             vector-set!.209
                                             tmp.23.134
                                             2
                                             3)))
                                       (if (unsafe-procedure-call
                                            error?.210
                                            g42493372.137)
                                         g42493372.137
                                         (let ((g42493373.138
                                                (unsafe-procedure-call
                                                 vector-set!.209
                                                 tmp.23.134
                                                 3
                                                 4)))
                                           (if (unsafe-procedure-call
                                                error?.210
                                                g42493373.138)
                                             g42493373.138
                                             (let ((g42493374.139
                                                    (unsafe-procedure-call
                                                     vector-set!.209
                                                     tmp.23.134
                                                     4
                                                     5)))
                                               (if (unsafe-procedure-call
                                                    error?.210
                                                    g42493374.139)
                                                 g42493374.139
                                                 (let ((g42493375.140
                                                        (unsafe-procedure-call
                                                         vector-set!.209
                                                         tmp.23.134
                                                         5
                                                         6)))
                                                   (if (unsafe-procedure-call
                                                        error?.210
                                                        g42493375.140)
                                                     g42493375.140
                                                     (let ((g42493376.141
                                                            (unsafe-procedure-call
                                                             vector-set!.209
                                                             tmp.23.134
                                                             6
                                                             7)))
                                                       (if (unsafe-procedure-call
                                                            error?.210
                                                            g42493376.141)
                                                         g42493376.141
                                                         (let ((g42493377.142
                                                                (unsafe-procedure-call
                                                                 vector-set!.209
                                                                 tmp.23.134
                                                                 7
                                                                 8)))
                                                           (if (unsafe-procedure-call
                                                                error?.210
                                                                g42493377.142)
                                                             g42493377.142
                                                             tmp.23.134)))))))))))))))))))
                      153))
                 (let ((tmp.24.143
                        (if 2
                          (if 39
                            (if 133 (if 67 (if 231 (if 24 90 #f) #f) #f) #f)
                            #f)
                          #f)))
                   (if tmp.24.143
                     tmp.24.143
                     (let ((tmp.25.144 (let () 98)))
                       (if tmp.25.144
                         tmp.25.144
                         (let ((tmp.26.145
                                (let ((tmp.27.146 35))
                                  (if tmp.27.146
                                    tmp.27.146
                                    (let ((tmp.28.147 137))
                                      (if tmp.28.147
                                        tmp.28.147
                                        (let ((tmp.29.148 221))
                                          (if tmp.29.148
                                            tmp.29.148
                                            (let ((tmp.30.149 20))
                                              (if tmp.30.149
                                                tmp.30.149
                                                (let ((tmp.31.150 185))
                                                  (if tmp.31.150
                                                    tmp.31.150
                                                    134))))))))))))
                           (if tmp.26.145
                             tmp.26.145
                             (let ((tmp.32.151
                                    (let ((tmp.33.152 208))
                                      (if tmp.33.152
                                        tmp.33.152
                                        (let ((tmp.34.153 29))
                                          (if tmp.34.153
                                            tmp.34.153
                                            (let ((tmp.35.154 116))
                                              (if tmp.35.154
                                                tmp.35.154
                                                147))))))))
                               (if tmp.32.151
                                 tmp.32.151
                                 (let ((tmp.36.155 (if #f 16 82)))
                                   (if tmp.36.155
                                     tmp.36.155
                                     (if #t 165 6)))))))))))
                 #f)
               #f)
             #f)
           #f)
         #f)))))
(check-by-interp
 '(module
    (letrec ((<=.78
              (lambda (tmp.46 tmp.47)
                (if (fixnum? tmp.47)
                  (if (fixnum? tmp.46) (unsafe-fx<= tmp.46 tmp.47) (error 5))
                  (error 5))))
             (>.77
              (lambda (tmp.48 tmp.49)
                (if (fixnum? tmp.49)
                  (if (fixnum? tmp.48) (unsafe-fx> tmp.48 tmp.49) (error 6))
                  (error 6))))
             (cons.76 (lambda (tmp.71 tmp.72) (cons tmp.71 tmp.72)))
             (fun/boolean8631.11 (lambda (oprand0.17) #t))
             (fun/pair8635.12
              (lambda (oprand0.18)
                (unsafe-procedure-call
                 cons.76
                 16
                 (unsafe-procedure-call cons.76 418 empty))))
             (fun/fixnum8634.13 (lambda () 33))
             (fun/fixnum8636.14 (lambda () (if #f 72 52)))
             (fun/boolean8632.15 (lambda () #t))
             (fun/fixnum8633.16
              (lambda (oprand0.19) (unsafe-procedure-call fun/fixnum8634.13))))
      (if (let ((tmp.7.20 (unsafe-procedure-call fun/boolean8631.11 #\f)))
            (if tmp.7.20
              tmp.7.20
              (let ((tmp.8.21 (unsafe-procedure-call >.77 237 82)))
                (if tmp.8.21
                  tmp.8.21
                  (let ((tmp.9.22 (let () #t)))
                    (if tmp.9.22
                      tmp.9.22
                      (let ((tmp.10.23 (unsafe-procedure-call <=.78 191 13)))
                        (if tmp.10.23
                          tmp.10.23
                          (unsafe-procedure-call fun/boolean8632.15)))))))))
        (unsafe-procedure-call
         fun/fixnum8633.16
         (unsafe-procedure-call fun/pair8635.12 #\F))
        (unsafe-procedure-call fun/fixnum8636.14)))))
(check-by-interp
 '(module
    (letrec ((fun/void8639.17 (lambda (oprand0.19) (if #t (void) (void))))
             (fun/void8640.18 (lambda (oprand0.21 oprand1.20) (void))))
      (if (if #f #t #t)
        (unsafe-procedure-call fun/void8639.17 (if #t #t #t))
        (let ((tmp.7.22 (unsafe-procedure-call fun/void8640.18 #t #\I)))
          (if tmp.7.22
            tmp.7.22
            (let ((tmp.8.23 (if #f (void) (void))))
              (if tmp.8.23
                tmp.8.23
                (let ((tmp.9.24 (let () (void))))
                  (if tmp.9.24
                    tmp.9.24
                    (let ((tmp.10.25 (if #t (void) (void))))
                      (if tmp.10.25
                        tmp.10.25
                        (let ((tmp.11.26
                               (let ((tmp.12.27 (void)))
                                 (if tmp.12.27
                                   tmp.12.27
                                   (let ((tmp.13.28 (void)))
                                     (if tmp.13.28
                                       tmp.13.28
                                       (let ((tmp.14.29 (void)))
                                         (if tmp.14.29
                                           tmp.14.29
                                           (let ((tmp.15.30 (void)))
                                             (if tmp.15.30
                                               tmp.15.30
                                               (void)))))))))))
                          (if tmp.11.26
                            tmp.11.26
                            (let ((tmp.16.31 (void)))
                              (if tmp.16.31 tmp.16.31 (void)))))))))))))))))
(check-by-interp
 '(module
    (letrec ((ascii-char?.64 (lambda (tmp.52) (ascii-char? tmp.52)))
             (vector-init-loop.13
              (lambda (len.14 i.16 vec.15)
                (if (eq? len.14 i.16)
                  vec.15
                  (begin
                    (unsafe-vector-set! vec.15 i.16 0)
                    (unsafe-procedure-call
                     vector-init-loop.13
                     len.14
                     (unsafe-fx+ i.16 1)
                     vec.15)))))
             (make-init-vector.4
              (lambda (tmp.11)
                (let ((tmp.12 (unsafe-make-vector tmp.11)))
                  (unsafe-procedure-call
                   vector-init-loop.13
                   tmp.11
                   0
                   tmp.12))))
             (make-vector.63
              (lambda (tmp.39)
                (if (fixnum? tmp.39)
                  (unsafe-procedure-call make-init-vector.4 tmp.39)
                  (error 8))))
             (fun/empty8643.7 (lambda (oprand0.9 oprand1.8) oprand0.9)))
      (unsafe-procedure-call
       fun/empty8643.7
       (if #t empty empty)
       (unsafe-procedure-call
        ascii-char?.64
        (let ((vector0.10 (unsafe-procedure-call make-vector.63 8))) 146))))))
(check-by-interp
 '(module
    (letrec ((>.117
              (lambda (tmp.83 tmp.84)
                (if (fixnum? tmp.84)
                  (if (fixnum? tmp.83) (unsafe-fx> tmp.83 tmp.84) (error 6))
                  (error 6))))
             (cons.116 (lambda (tmp.106 tmp.107) (cons tmp.106 tmp.107)))
             (unsafe-vector-set!.5
              (lambda (tmp.65 tmp.66 tmp.67)
                (if (unsafe-fx< tmp.66 (unsafe-vector-length tmp.65))
                  (if (unsafe-fx>= tmp.66 0)
                    (begin (unsafe-vector-set! tmp.65 tmp.66 tmp.67) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.115
              (lambda (tmp.89 tmp.90 tmp.91)
                (if (fixnum? tmp.90)
                  (if (vector? tmp.89)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.89
                     tmp.90
                     tmp.91)
                    (error 10))
                  (error 10))))
             (vector-init-loop.61
              (lambda (len.62 i.64 vec.63)
                (if (eq? len.62 i.64)
                  vec.63
                  (begin
                    (unsafe-vector-set! vec.63 i.64 0)
                    (unsafe-procedure-call
                     vector-init-loop.61
                     len.62
                     (unsafe-fx+ i.64 1)
                     vec.63)))))
             (make-init-vector.4
              (lambda (tmp.59)
                (let ((tmp.60 (unsafe-make-vector tmp.59)))
                  (unsafe-procedure-call
                   vector-init-loop.61
                   tmp.59
                   0
                   tmp.60))))
             (make-vector.114
              (lambda (tmp.87)
                (if (fixnum? tmp.87)
                  (unsafe-procedure-call make-init-vector.4 tmp.87)
                  (error 8))))
             (|-.113|
              (lambda (tmp.77 tmp.78)
                (if (fixnum? tmp.78)
                  (if (fixnum? tmp.77) (unsafe-fx- tmp.77 tmp.78) (error 3))
                  (error 3))))
             (|+.112|
              (lambda (tmp.75 tmp.76)
                (if (fixnum? tmp.76)
                  (if (fixnum? tmp.75) (unsafe-fx+ tmp.75 tmp.76) (error 2))
                  (error 2))))
             (error?.111 (lambda (tmp.101) (error? tmp.101)))
             (fun/fixnum8646.17 (lambda (oprand0.21) 187))
             (fun/fixnum8647.18 (lambda () 188))
             (fun/fixnum8648.19 (lambda (oprand0.23 oprand1.22) oprand1.22))
             (fun/fixnum8649.20 (lambda (oprand0.25 oprand1.24) 114)))
      (unsafe-procedure-call
       >.117
       (let ((g42516139.26 (unsafe-procedure-call fun/fixnum8646.17 #\q)))
         (if (unsafe-procedure-call error?.111 g42516139.26)
           g42516139.26
           (if #f 81 95)))
       (if (unsafe-procedure-call
            |+.112|
            (if 251
              (if 7 (if 101 (if 18 (if 141 (if 162 193 #f) #f) #f) #f) #f)
              #f)
            (if 104 (if 226 (if 68 (if 97 (if 159 210 #f) #f) #f) #f) #f))
         (if (let ((procedure0.27 (lambda (oprand0.29 oprand1.28) oprand0.29)))
               198)
           (if (let ((tmp.7.30 (let () 226)))
                 (if tmp.7.30
                   tmp.7.30
                   (let ((tmp.8.31 (unsafe-procedure-call |-.113| 94 208)))
                     (if tmp.8.31
                       tmp.8.31
                       (let ((tmp.9.32 (if #f 33 168)))
                         (if tmp.9.32
                           tmp.9.32
                           (let ((tmp.10.33
                                  (unsafe-procedure-call fun/fixnum8647.18)))
                             (if tmp.10.33
                               tmp.10.33
                               (let ((tmp.11.34
                                      (let ((boolean0.36 #t)
                                            (ascii-char1.35 #\Q))
                                        98)))
                                 (if tmp.11.34
                                   tmp.11.34
                                   (let ((tmp.12.37
                                          (let ((boolean0.40 #t)
                                                (boolean1.39 #f)
                                                (vector2.38
                                                 (let ((tmp.13.41
                                                        (unsafe-procedure-call
                                                         make-vector.114
                                                         8)))
                                                   (let ((g42516140.42
                                                          (unsafe-procedure-call
                                                           vector-set!.115
                                                           tmp.13.41
                                                           0
                                                           0)))
                                                     (if (unsafe-procedure-call
                                                          error?.111
                                                          g42516140.42)
                                                       g42516140.42
                                                       (let ((g42516141.43
                                                              (unsafe-procedure-call
                                                               vector-set!.115
                                                               tmp.13.41
                                                               1
                                                               1)))
                                                         (if (unsafe-procedure-call
                                                              error?.111
                                                              g42516141.43)
                                                           g42516141.43
                                                           (let ((g42516142.44
                                                                  (unsafe-procedure-call
                                                                   vector-set!.115
                                                                   tmp.13.41
                                                                   2
                                                                   2)))
                                                             (if (unsafe-procedure-call
                                                                  error?.111
                                                                  g42516142.44)
                                                               g42516142.44
                                                               (let ((g42516143.45
                                                                      (unsafe-procedure-call
                                                                       vector-set!.115
                                                                       tmp.13.41
                                                                       3
                                                                       3)))
                                                                 (if (unsafe-procedure-call
                                                                      error?.111
                                                                      g42516143.45)
                                                                   g42516143.45
                                                                   (let ((g42516144.46
                                                                          (unsafe-procedure-call
                                                                           vector-set!.115
                                                                           tmp.13.41
                                                                           4
                                                                           4)))
                                                                     (if (unsafe-procedure-call
                                                                          error?.111
                                                                          g42516144.46)
                                                                       g42516144.46
                                                                       (let ((g42516145.47
                                                                              (unsafe-procedure-call
                                                                               vector-set!.115
                                                                               tmp.13.41
                                                                               5
                                                                               5)))
                                                                         (if (unsafe-procedure-call
                                                                              error?.111
                                                                              g42516145.47)
                                                                           g42516145.47
                                                                           (let ((g42516146.48
                                                                                  (unsafe-procedure-call
                                                                                   vector-set!.115
                                                                                   tmp.13.41
                                                                                   6
                                                                                   6)))
                                                                             (if (unsafe-procedure-call
                                                                                  error?.111
                                                                                  g42516146.48)
                                                                               g42516146.48
                                                                               (let ((g42516147.49
                                                                                      (unsafe-procedure-call
                                                                                       vector-set!.115
                                                                                       tmp.13.41
                                                                                       7
                                                                                       7)))
                                                                                 (if (unsafe-procedure-call
                                                                                      error?.111
                                                                                      g42516147.49)
                                                                                   g42516147.49
                                                                                   tmp.13.41)))))))))))))))))))
                                            58)))
                                     (if tmp.12.37
                                       tmp.12.37
                                       (let ((void0.52 (void))
                                             (error1.51 (error 253))
                                             (pair2.50
                                              (unsafe-procedure-call
                                               cons.116
                                               103
                                               (unsafe-procedure-call
                                                cons.116
                                                494
                                                empty))))
                                         245)))))))))))))
             (if (let ((boolean0.55 #t)
                       (pair1.54
                        (unsafe-procedure-call
                         cons.116
                         131
                         (unsafe-procedure-call cons.116 435 empty)))
                       (procedure2.53 (lambda () 174)))
                   130)
               (if (if (if #t 35 220)
                     (if (if #t 36 135)
                       (if (unsafe-procedure-call
                            fun/fixnum8648.19
                            (unsafe-procedure-call
                             cons.116
                             124
                             (unsafe-procedure-call cons.116 432 empty))
                            82)
                         (if (let ((tmp.14.56 152))
                               (if tmp.14.56
                                 tmp.14.56
                                 (let ((tmp.15.57 68))
                                   (if tmp.15.57
                                     tmp.15.57
                                     (let ((tmp.16.58 140))
                                       (if tmp.16.58 tmp.16.58 42))))))
                           (if (unsafe-procedure-call
                                fun/fixnum8649.20
                                empty
                                #\j)
                             (if #f 143 40)
                             #f)
                           #f)
                         #f)
                       #f)
                     #f)
                 (if #t 8 110)
                 #f)
               #f)
             #f)
           #f)
         #f)))))
(check-by-interp
 '(module
    (letrec ((unsafe-vector-set!.5
              (lambda (tmp.93 tmp.94 tmp.95)
                (if (unsafe-fx< tmp.94 (unsafe-vector-length tmp.93))
                  (if (unsafe-fx>= tmp.94 0)
                    (begin (unsafe-vector-set! tmp.93 tmp.94 tmp.95) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.142
              (lambda (tmp.117 tmp.118 tmp.119)
                (if (fixnum? tmp.118)
                  (if (vector? tmp.117)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.117
                     tmp.118
                     tmp.119)
                    (error 10))
                  (error 10))))
             (vector-init-loop.89
              (lambda (len.90 i.92 vec.91)
                (if (eq? len.90 i.92)
                  vec.91
                  (begin
                    (unsafe-vector-set! vec.91 i.92 0)
                    (unsafe-procedure-call
                     vector-init-loop.89
                     len.90
                     (unsafe-fx+ i.92 1)
                     vec.91)))))
             (make-init-vector.4
              (lambda (tmp.87)
                (let ((tmp.88 (unsafe-make-vector tmp.87)))
                  (unsafe-procedure-call
                   vector-init-loop.89
                   tmp.87
                   0
                   tmp.88))))
             (make-vector.141
              (lambda (tmp.115)
                (if (fixnum? tmp.115)
                  (unsafe-procedure-call make-init-vector.4 tmp.115)
                  (error 8))))
             (error?.140 (lambda (tmp.129) (error? tmp.129)))
             (cons.139 (lambda (tmp.134 tmp.135) (cons tmp.134 tmp.135)))
             (fun/void8652.10 (lambda (oprand0.16 oprand1.15) (void)))
             (fun/void8656.11
              (lambda (oprand0.18 oprand1.17) (if #t (void) (void))))
             (fun/void8655.12 (lambda () (void)))
             (fun/void8654.13
              (lambda (oprand0.19) (let ((empty0.20 empty)) (void))))
             (fun/void8653.14
              (lambda (oprand0.22 oprand1.21) (let () (void)))))
      (let ((g42519968.23
             (if (let ((boolean0.26 #f)
                       (pair1.25
                        (unsafe-procedure-call
                         cons.139
                         247
                         (unsafe-procedure-call cons.139 312 empty)))
                       (error2.24 (error 55)))
                   #f)
               (unsafe-procedure-call fun/void8652.10 #\O empty)
               (let ((g42519969.27 (void)))
                 (if (unsafe-procedure-call error?.140 g42519969.27)
                   g42519969.27
                   (void))))))
        (if (unsafe-procedure-call error?.140 g42519968.23)
          g42519968.23
          (let ((g42519970.28
                 (if (let ((g42519971.29 #t))
                       (if (unsafe-procedure-call error?.140 g42519971.29)
                         g42519971.29
                         #f))
                   (if #t (void) (void))
                   (let ((g42519972.30 (void)))
                     (if (unsafe-procedure-call error?.140 g42519972.30)
                       g42519972.30
                       (let ((g42519973.31 (void)))
                         (if (unsafe-procedure-call error?.140 g42519973.31)
                           g42519973.31
                           (let ((g42519974.32 (void)))
                             (if (unsafe-procedure-call
                                  error?.140
                                  g42519974.32)
                               g42519974.32
                               (let ((g42519975.33 (void)))
                                 (if (unsafe-procedure-call
                                      error?.140
                                      g42519975.33)
                                   g42519975.33
                                   (let ((g42519976.34 (void)))
                                     (if (unsafe-procedure-call
                                          error?.140
                                          g42519976.34)
                                       g42519976.34
                                       (void))))))))))))))
            (if (unsafe-procedure-call error?.140 g42519970.28)
              g42519970.28
              (let ((g42519977.35
                     (unsafe-procedure-call
                      fun/void8653.14
                      (if #t
                        (unsafe-procedure-call
                         cons.139
                         38
                         (unsafe-procedure-call cons.139 339 empty))
                        (unsafe-procedure-call
                         cons.139
                         84
                         (unsafe-procedure-call cons.139 401 empty)))
                      (let ((error0.37 (error 143)) (error1.36 (error 119)))
                        (error 96)))))
                (if (unsafe-procedure-call error?.140 g42519977.35)
                  g42519977.35
                  (let ((g42519978.38
                         (let ((g42519979.39
                                (if (let ((ascii-char0.41 #\M)
                                          (vector1.40
                                           (let ((tmp.7.42
                                                  (unsafe-procedure-call
                                                   make-vector.141
                                                   8)))
                                             (let ((g42519980.43
                                                    (unsafe-procedure-call
                                                     vector-set!.142
                                                     tmp.7.42
                                                     0
                                                     0)))
                                               (if (unsafe-procedure-call
                                                    error?.140
                                                    g42519980.43)
                                                 g42519980.43
                                                 (let ((g42519981.44
                                                        (unsafe-procedure-call
                                                         vector-set!.142
                                                         tmp.7.42
                                                         1
                                                         1)))
                                                   (if (unsafe-procedure-call
                                                        error?.140
                                                        g42519981.44)
                                                     g42519981.44
                                                     (let ((g42519982.45
                                                            (unsafe-procedure-call
                                                             vector-set!.142
                                                             tmp.7.42
                                                             2
                                                             2)))
                                                       (if (unsafe-procedure-call
                                                            error?.140
                                                            g42519982.45)
                                                         g42519982.45
                                                         (let ((g42519983.46
                                                                (unsafe-procedure-call
                                                                 vector-set!.142
                                                                 tmp.7.42
                                                                 3
                                                                 3)))
                                                           (if (unsafe-procedure-call
                                                                error?.140
                                                                g42519983.46)
                                                             g42519983.46
                                                             (let ((g42519984.47
                                                                    (unsafe-procedure-call
                                                                     vector-set!.142
                                                                     tmp.7.42
                                                                     4
                                                                     4)))
                                                               (if (unsafe-procedure-call
                                                                    error?.140
                                                                    g42519984.47)
                                                                 g42519984.47
                                                                 (let ((g42519985.48
                                                                        (unsafe-procedure-call
                                                                         vector-set!.142
                                                                         tmp.7.42
                                                                         5
                                                                         5)))
                                                                   (if (unsafe-procedure-call
                                                                        error?.140
                                                                        g42519985.48)
                                                                     g42519985.48
                                                                     (let ((g42519986.49
                                                                            (unsafe-procedure-call
                                                                             vector-set!.142
                                                                             tmp.7.42
                                                                             6
                                                                             6)))
                                                                       (if (unsafe-procedure-call
                                                                            error?.140
                                                                            g42519986.49)
                                                                         g42519986.49
                                                                         (let ((g42519987.50
                                                                                (unsafe-procedure-call
                                                                                 vector-set!.142
                                                                                 tmp.7.42
                                                                                 7
                                                                                 7)))
                                                                           (if (unsafe-procedure-call
                                                                                error?.140
                                                                                g42519987.50)
                                                                             g42519987.50
                                                                             tmp.7.42)))))))))))))))))))
                                      (void))
                                  (let ((g42519988.51 (void)))
                                    (if (unsafe-procedure-call
                                         error?.140
                                         g42519988.51)
                                      g42519988.51
                                      (let ((g42519989.52 (void)))
                                        (if (unsafe-procedure-call
                                             error?.140
                                             g42519989.52)
                                          g42519989.52
                                          (void)))))
                                  #f)))
                           (if (unsafe-procedure-call error?.140 g42519979.39)
                             g42519979.39
                             (let ((g42519990.53
                                    (let ((vector0.55
                                           (let ((tmp.8.56
                                                  (unsafe-procedure-call
                                                   make-vector.141
                                                   8)))
                                             (let ((g42519991.57
                                                    (unsafe-procedure-call
                                                     vector-set!.142
                                                     tmp.8.56
                                                     0
                                                     0)))
                                               (if (unsafe-procedure-call
                                                    error?.140
                                                    g42519991.57)
                                                 g42519991.57
                                                 (let ((g42519992.58
                                                        (unsafe-procedure-call
                                                         vector-set!.142
                                                         tmp.8.56
                                                         1
                                                         1)))
                                                   (if (unsafe-procedure-call
                                                        error?.140
                                                        g42519992.58)
                                                     g42519992.58
                                                     (let ((g42519993.59
                                                            (unsafe-procedure-call
                                                             vector-set!.142
                                                             tmp.8.56
                                                             2
                                                             2)))
                                                       (if (unsafe-procedure-call
                                                            error?.140
                                                            g42519993.59)
                                                         g42519993.59
                                                         (let ((g42519994.60
                                                                (unsafe-procedure-call
                                                                 vector-set!.142
                                                                 tmp.8.56
                                                                 3
                                                                 3)))
                                                           (if (unsafe-procedure-call
                                                                error?.140
                                                                g42519994.60)
                                                             g42519994.60
                                                             (let ((g42519995.61
                                                                    (unsafe-procedure-call
                                                                     vector-set!.142
                                                                     tmp.8.56
                                                                     4
                                                                     4)))
                                                               (if (unsafe-procedure-call
                                                                    error?.140
                                                                    g42519995.61)
                                                                 g42519995.61
                                                                 (let ((g42519996.62
                                                                        (unsafe-procedure-call
                                                                         vector-set!.142
                                                                         tmp.8.56
                                                                         5
                                                                         5)))
                                                                   (if (unsafe-procedure-call
                                                                        error?.140
                                                                        g42519996.62)
                                                                     g42519996.62
                                                                     (let ((g42519997.63
                                                                            (unsafe-procedure-call
                                                                             vector-set!.142
                                                                             tmp.8.56
                                                                             6
                                                                             6)))
                                                                       (if (unsafe-procedure-call
                                                                            error?.140
                                                                            g42519997.63)
                                                                         g42519997.63
                                                                         (let ((g42519998.64
                                                                                (unsafe-procedure-call
                                                                                 vector-set!.142
                                                                                 tmp.8.56
                                                                                 7
                                                                                 7)))
                                                                           (if (unsafe-procedure-call
                                                                                error?.140
                                                                                g42519998.64)
                                                                             g42519998.64
                                                                             tmp.8.56))))))))))))))))))
                                          (error1.54 (error 186)))
                                      (void))))
                               (if (unsafe-procedure-call
                                    error?.140
                                    g42519990.53)
                                 g42519990.53
                                 (let ((g42519999.65
                                        (let ((procedure0.66 (lambda () 121)))
                                          (void))))
                                   (if (unsafe-procedure-call
                                        error?.140
                                        g42519999.65)
                                     g42519999.65
                                     (let ((g42520000.67
                                            (unsafe-procedure-call
                                             fun/void8654.13
                                             (if #t #\a #\r))))
                                       (if (unsafe-procedure-call
                                            error?.140
                                            g42520000.67)
                                         g42520000.67
                                         (let ((g42520001.68
                                                (if #t (void) (void))))
                                           (if (unsafe-procedure-call
                                                error?.140
                                                g42520001.68)
                                             g42520001.68
                                             (let ((g42520002.69
                                                    (if #f (void) (void))))
                                               (if (unsafe-procedure-call
                                                    error?.140
                                                    g42520002.69)
                                                 g42520002.69
                                                 (if #f
                                                   (void)
                                                   (void))))))))))))))))
                    (if (unsafe-procedure-call error?.140 g42519978.38)
                      g42519978.38
                      (let ((g42520003.70
                             (let ((void0.71
                                    (unsafe-procedure-call fun/void8655.12)))
                               (let ((pair0.73
                                      (unsafe-procedure-call
                                       cons.139
                                       100
                                       (unsafe-procedure-call
                                        cons.139
                                        256
                                        empty)))
                                     (pair1.72
                                      (unsafe-procedure-call
                                       cons.139
                                       1
                                       (unsafe-procedure-call
                                        cons.139
                                        424
                                        empty))))
                                 (void)))))
                        (if (unsafe-procedure-call error?.140 g42520003.70)
                          g42520003.70
                          (unsafe-procedure-call
                           fun/void8656.11
                           (let ((ascii-char0.75 #\B)
                                 (pair1.74
                                  (unsafe-procedure-call
                                   cons.139
                                   147
                                   (unsafe-procedure-call
                                    cons.139
                                    339
                                    empty))))
                             #\N)
                           (let ((vector0.77
                                  (let ((tmp.9.78
                                         (unsafe-procedure-call
                                          make-vector.141
                                          8)))
                                    (let ((g42520004.79
                                           (unsafe-procedure-call
                                            vector-set!.142
                                            tmp.9.78
                                            0
                                            1)))
                                      (if (unsafe-procedure-call
                                           error?.140
                                           g42520004.79)
                                        g42520004.79
                                        (let ((g42520005.80
                                               (unsafe-procedure-call
                                                vector-set!.142
                                                tmp.9.78
                                                1
                                                2)))
                                          (if (unsafe-procedure-call
                                               error?.140
                                               g42520005.80)
                                            g42520005.80
                                            (let ((g42520006.81
                                                   (unsafe-procedure-call
                                                    vector-set!.142
                                                    tmp.9.78
                                                    2
                                                    3)))
                                              (if (unsafe-procedure-call
                                                   error?.140
                                                   g42520006.81)
                                                g42520006.81
                                                (let ((g42520007.82
                                                       (unsafe-procedure-call
                                                        vector-set!.142
                                                        tmp.9.78
                                                        3
                                                        4)))
                                                  (if (unsafe-procedure-call
                                                       error?.140
                                                       g42520007.82)
                                                    g42520007.82
                                                    (let ((g42520008.83
                                                           (unsafe-procedure-call
                                                            vector-set!.142
                                                            tmp.9.78
                                                            4
                                                            5)))
                                                      (if (unsafe-procedure-call
                                                           error?.140
                                                           g42520008.83)
                                                        g42520008.83
                                                        (let ((g42520009.84
                                                               (unsafe-procedure-call
                                                                vector-set!.142
                                                                tmp.9.78
                                                                5
                                                                6)))
                                                          (if (unsafe-procedure-call
                                                               error?.140
                                                               g42520009.84)
                                                            g42520009.84
                                                            (let ((g42520010.85
                                                                   (unsafe-procedure-call
                                                                    vector-set!.142
                                                                    tmp.9.78
                                                                    6
                                                                    7)))
                                                              (if (unsafe-procedure-call
                                                                   error?.140
                                                                   g42520010.85)
                                                                g42520010.85
                                                                (let ((g42520011.86
                                                                       (unsafe-procedure-call
                                                                        vector-set!.142
                                                                        tmp.9.78
                                                                        7
                                                                        8)))
                                                                  (if (unsafe-procedure-call
                                                                       error?.140
                                                                       g42520011.86)
                                                                    g42520011.86
                                                                    tmp.9.78))))))))))))))))))
                                 (procedure1.76 (lambda () 228)))
                             (error 218))))))))))))))))
(check-by-interp
 '(module
    (letrec ((error?.64 (lambda (tmp.54) (error? tmp.54)))
             (fun/void8659.7 (lambda (oprand0.8) (void))))
      (let ((void0.9 (let ((ascii-char0.10 #\s)) (void))))
        (if (if #f (void) (void))
          (if (let ((g42523829.11 (void)))
                (if (unsafe-procedure-call error?.64 g42523829.11)
                  g42523829.11
                  (void)))
            (unsafe-procedure-call fun/void8659.7 #f)
            #f)
          #f)))))
(check-by-interp
 '(module
    (letrec ((cons.74 (lambda (tmp.67 tmp.68) (cons tmp.67 tmp.68)))
             (error?.73 (lambda (tmp.62) (error? tmp.62)))
             (vector-init-loop.22
              (lambda (len.23 i.25 vec.24)
                (if (eq? len.23 i.25)
                  vec.24
                  (begin
                    (unsafe-vector-set! vec.24 i.25 0)
                    (unsafe-procedure-call
                     vector-init-loop.22
                     len.23
                     (unsafe-fx+ i.25 1)
                     vec.24)))))
             (make-init-vector.4
              (lambda (tmp.20)
                (let ((tmp.21 (unsafe-make-vector tmp.20)))
                  (unsafe-procedure-call
                   vector-init-loop.22
                   tmp.20
                   0
                   tmp.21))))
             (make-vector.72
              (lambda (tmp.48)
                (if (fixnum? tmp.48)
                  (unsafe-procedure-call make-init-vector.4 tmp.48)
                  (error 8))))
             (fun/error8662.7
              (lambda ()
                (let ((ascii-char0.9 #\N) (ascii-char1.8 #\R)) (error 192)))))
      (if (if (let ((void0.12 (void))
                    (boolean1.11 #f)
                    (vector2.10 (unsafe-procedure-call make-vector.72 8)))
                #f)
            (if #f (error 241) (error 134))
            (let ((fixnum0.14 190) (error1.13 (error 76))) (error 56)))
        (if (let ((empty0.16
                   (let ((g42527647.17 empty))
                     (if (unsafe-procedure-call error?.73 g42527647.17)
                       g42527647.17
                       (let ((g42527648.18 empty))
                         (if (unsafe-procedure-call error?.73 g42527648.18)
                           g42527648.18
                           (let ((g42527649.19 empty))
                             (if (unsafe-procedure-call error?.73 g42527649.19)
                               g42527649.19
                               empty)))))))
                  (pair1.15
                   (unsafe-procedure-call
                    cons.74
                    134
                    (unsafe-procedure-call
                     cons.74
                     (unsafe-procedure-call
                      cons.74
                      154
                      (unsafe-procedure-call cons.74 498 empty))
                     (unsafe-procedure-call
                      cons.74
                      95
                      (unsafe-procedure-call
                       cons.74
                       empty
                       (unsafe-procedure-call
                        cons.74
                        #\M
                        (unsafe-procedure-call
                         cons.74
                         (unsafe-procedure-call
                          cons.74
                          118
                          (unsafe-procedure-call cons.74 510 empty))
                         (unsafe-procedure-call
                          cons.74
                          #f
                          (unsafe-procedure-call cons.74 #\] empty))))))))))
              (if #t (error 132) (error 79)))
          (unsafe-procedure-call fun/error8662.7)
          #f)
        #f))))
(check-by-interp
 '(module
    (letrec ((error?.88 (lambda (tmp.76) (error? tmp.76)))
             (unsafe-vector-set!.5
              (lambda (tmp.40 tmp.41 tmp.42)
                (if (unsafe-fx< tmp.41 (unsafe-vector-length tmp.40))
                  (if (unsafe-fx>= tmp.41 0)
                    (begin (unsafe-vector-set! tmp.40 tmp.41 tmp.42) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.87
              (lambda (tmp.64 tmp.65 tmp.66)
                (if (fixnum? tmp.65)
                  (if (vector? tmp.64)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.64
                     tmp.65
                     tmp.66)
                    (error 10))
                  (error 10))))
             (vector-init-loop.36
              (lambda (len.37 i.39 vec.38)
                (if (eq? len.37 i.39)
                  vec.38
                  (begin
                    (unsafe-vector-set! vec.38 i.39 0)
                    (unsafe-procedure-call
                     vector-init-loop.36
                     len.37
                     (unsafe-fx+ i.39 1)
                     vec.38)))))
             (make-init-vector.4
              (lambda (tmp.34)
                (let ((tmp.35 (unsafe-make-vector tmp.34)))
                  (unsafe-procedure-call
                   vector-init-loop.36
                   tmp.34
                   0
                   tmp.35))))
             (make-vector.86
              (lambda (tmp.62)
                (if (fixnum? tmp.62)
                  (unsafe-procedure-call make-init-vector.4 tmp.62)
                  (error 8))))
             (fun/empty8665.9
              (lambda (oprand0.10) (let ((void0.11 (void))) empty))))
      (if (let () #f)
        (unsafe-procedure-call
         fun/empty8665.9
         (let ((vector0.13
                (let ((tmp.7.14 (unsafe-procedure-call make-vector.86 8)))
                  (let ((g42531467.15
                         (unsafe-procedure-call vector-set!.87 tmp.7.14 0 0)))
                    (if (unsafe-procedure-call error?.88 g42531467.15)
                      g42531467.15
                      (let ((g42531468.16
                             (unsafe-procedure-call
                              vector-set!.87
                              tmp.7.14
                              1
                              1)))
                        (if (unsafe-procedure-call error?.88 g42531468.16)
                          g42531468.16
                          (let ((g42531469.17
                                 (unsafe-procedure-call
                                  vector-set!.87
                                  tmp.7.14
                                  2
                                  2)))
                            (if (unsafe-procedure-call error?.88 g42531469.17)
                              g42531469.17
                              (let ((g42531470.18
                                     (unsafe-procedure-call
                                      vector-set!.87
                                      tmp.7.14
                                      3
                                      3)))
                                (if (unsafe-procedure-call
                                     error?.88
                                     g42531470.18)
                                  g42531470.18
                                  (let ((g42531471.19
                                         (unsafe-procedure-call
                                          vector-set!.87
                                          tmp.7.14
                                          4
                                          4)))
                                    (if (unsafe-procedure-call
                                         error?.88
                                         g42531471.19)
                                      g42531471.19
                                      (let ((g42531472.20
                                             (unsafe-procedure-call
                                              vector-set!.87
                                              tmp.7.14
                                              5
                                              5)))
                                        (if (unsafe-procedure-call
                                             error?.88
                                             g42531472.20)
                                          g42531472.20
                                          (let ((g42531473.21
                                                 (unsafe-procedure-call
                                                  vector-set!.87
                                                  tmp.7.14
                                                  6
                                                  6)))
                                            (if (unsafe-procedure-call
                                                 error?.88
                                                 g42531473.21)
                                              g42531473.21
                                              (let ((g42531474.22
                                                     (unsafe-procedure-call
                                                      vector-set!.87
                                                      tmp.7.14
                                                      7
                                                      7)))
                                                (if (unsafe-procedure-call
                                                     error?.88
                                                     g42531474.22)
                                                  g42531474.22
                                                  tmp.7.14))))))))))))))))))
               (empty1.12 empty))
           #\H))
        (let ((vector0.24
               (let ((tmp.8.25 (unsafe-procedure-call make-vector.86 8)))
                 (let ((g42531475.26
                        (unsafe-procedure-call vector-set!.87 tmp.8.25 0 1)))
                   (if (unsafe-procedure-call error?.88 g42531475.26)
                     g42531475.26
                     (let ((g42531476.27
                            (unsafe-procedure-call
                             vector-set!.87
                             tmp.8.25
                             1
                             2)))
                       (if (unsafe-procedure-call error?.88 g42531476.27)
                         g42531476.27
                         (let ((g42531477.28
                                (unsafe-procedure-call
                                 vector-set!.87
                                 tmp.8.25
                                 2
                                 3)))
                           (if (unsafe-procedure-call error?.88 g42531477.28)
                             g42531477.28
                             (let ((g42531478.29
                                    (unsafe-procedure-call
                                     vector-set!.87
                                     tmp.8.25
                                     3
                                     4)))
                               (if (unsafe-procedure-call
                                    error?.88
                                    g42531478.29)
                                 g42531478.29
                                 (let ((g42531479.30
                                        (unsafe-procedure-call
                                         vector-set!.87
                                         tmp.8.25
                                         4
                                         5)))
                                   (if (unsafe-procedure-call
                                        error?.88
                                        g42531479.30)
                                     g42531479.30
                                     (let ((g42531480.31
                                            (unsafe-procedure-call
                                             vector-set!.87
                                             tmp.8.25
                                             5
                                             6)))
                                       (if (unsafe-procedure-call
                                            error?.88
                                            g42531480.31)
                                         g42531480.31
                                         (let ((g42531481.32
                                                (unsafe-procedure-call
                                                 vector-set!.87
                                                 tmp.8.25
                                                 6
                                                 7)))
                                           (if (unsafe-procedure-call
                                                error?.88
                                                g42531481.32)
                                             g42531481.32
                                             (let ((g42531482.33
                                                    (unsafe-procedure-call
                                                     vector-set!.87
                                                     tmp.8.25
                                                     7
                                                     8)))
                                               (if (unsafe-procedure-call
                                                    error?.88
                                                    g42531482.33)
                                                 g42531482.33
                                                 tmp.8.25))))))))))))))))))
              (boolean1.23 #t))
          empty)))))
(check-by-interp
 '(module
    (letrec ((error?.100 (lambda (tmp.87) (error? tmp.87)))
             (unsafe-vector-set!.5
              (lambda (tmp.51 tmp.52 tmp.53)
                (if (unsafe-fx< tmp.52 (unsafe-vector-length tmp.51))
                  (if (unsafe-fx>= tmp.52 0)
                    (begin (unsafe-vector-set! tmp.51 tmp.52 tmp.53) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.99
              (lambda (tmp.75 tmp.76 tmp.77)
                (if (fixnum? tmp.76)
                  (if (vector? tmp.75)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.75
                     tmp.76
                     tmp.77)
                    (error 10))
                  (error 10))))
             (vector-init-loop.47
              (lambda (len.48 i.50 vec.49)
                (if (eq? len.48 i.50)
                  vec.49
                  (begin
                    (unsafe-vector-set! vec.49 i.50 0)
                    (unsafe-procedure-call
                     vector-init-loop.47
                     len.48
                     (unsafe-fx+ i.50 1)
                     vec.49)))))
             (make-init-vector.4
              (lambda (tmp.45)
                (let ((tmp.46 (unsafe-make-vector tmp.45)))
                  (unsafe-procedure-call
                   vector-init-loop.47
                   tmp.45
                   0
                   tmp.46))))
             (make-vector.98
              (lambda (tmp.73)
                (if (fixnum? tmp.73)
                  (unsafe-procedure-call make-init-vector.4 tmp.73)
                  (error 8))))
             (cons.97 (lambda (tmp.92 tmp.93) (cons tmp.92 tmp.93)))
             (fun/fixnum8668.10 (lambda () 84))
             (fun/pair8669.11
              (lambda ()
                (unsafe-procedure-call
                 cons.97
                 33
                 (unsafe-procedure-call cons.97 355 empty))))
             (fun/fixnum8670.12 (lambda () 116)))
      (let ((vector0.14
             (let ((tmp.7.15 (unsafe-procedure-call make-vector.98 8)))
               (let ((g42535303.16
                      (unsafe-procedure-call
                       vector-set!.99
                       tmp.7.15
                       0
                       (let ((tmp.101 (let () (error 47))))
                         (if (procedure? tmp.101)
                           (if (eq? (unsafe-procedure-arity tmp.101) 0)
                             (unsafe-procedure-call tmp.101)
                             (error 42))
                           (error 43))))))
                 (if (unsafe-procedure-call error?.100 g42535303.16)
                   g42535303.16
                   (let ((g42535304.17
                          (unsafe-procedure-call
                           vector-set!.99
                           tmp.7.15
                           1
                           (let ((tmp.102 (error 83)))
                             (if (procedure? tmp.102)
                               (if (eq? (unsafe-procedure-arity tmp.102) 0)
                                 (unsafe-procedure-call tmp.102)
                                 (error 42))
                               (error 43))))))
                     (if (unsafe-procedure-call error?.100 g42535304.17)
                       g42535304.17
                       (let ((g42535305.18
                              (unsafe-procedure-call
                               vector-set!.99
                               tmp.7.15
                               2
                               (let ((tmp.103
                                      (if #t
                                        (unsafe-procedure-call
                                         cons.97
                                         212
                                         (unsafe-procedure-call
                                          cons.97
                                          273
                                          empty))
                                        (unsafe-procedure-call
                                         cons.97
                                         6
                                         (unsafe-procedure-call
                                          cons.97
                                          506
                                          empty)))))
                                 (if (procedure? tmp.103)
                                   (if (eq? (unsafe-procedure-arity tmp.103) 0)
                                     (unsafe-procedure-call tmp.103)
                                     (error 42))
                                   (error 43))))))
                         (if (unsafe-procedure-call error?.100 g42535305.18)
                           g42535305.18
                           (let ((g42535306.19
                                  (unsafe-procedure-call
                                   vector-set!.99
                                   tmp.7.15
                                   3
                                   (let ((tmp.104
                                          (let ((g42535307.20
                                                 (unsafe-procedure-call
                                                  make-vector.98
                                                  8)))
                                            (if (unsafe-procedure-call
                                                 error?.100
                                                 g42535307.20)
                                              g42535307.20
                                              (let ((g42535308.21
                                                     (let ((tmp.8.22
                                                            (unsafe-procedure-call
                                                             make-vector.98
                                                             8)))
                                                       (let ((g42535309.23
                                                              (unsafe-procedure-call
                                                               vector-set!.99
                                                               tmp.8.22
                                                               0
                                                               0)))
                                                         (if (unsafe-procedure-call
                                                              error?.100
                                                              g42535309.23)
                                                           g42535309.23
                                                           (let ((g42535310.24
                                                                  (unsafe-procedure-call
                                                                   vector-set!.99
                                                                   tmp.8.22
                                                                   1
                                                                   1)))
                                                             (if (unsafe-procedure-call
                                                                  error?.100
                                                                  g42535310.24)
                                                               g42535310.24
                                                               (let ((g42535311.25
                                                                      (unsafe-procedure-call
                                                                       vector-set!.99
                                                                       tmp.8.22
                                                                       2
                                                                       2)))
                                                                 (if (unsafe-procedure-call
                                                                      error?.100
                                                                      g42535311.25)
                                                                   g42535311.25
                                                                   (let ((g42535312.26
                                                                          (unsafe-procedure-call
                                                                           vector-set!.99
                                                                           tmp.8.22
                                                                           3
                                                                           3)))
                                                                     (if (unsafe-procedure-call
                                                                          error?.100
                                                                          g42535312.26)
                                                                       g42535312.26
                                                                       (let ((g42535313.27
                                                                              (unsafe-procedure-call
                                                                               vector-set!.99
                                                                               tmp.8.22
                                                                               4
                                                                               4)))
                                                                         (if (unsafe-procedure-call
                                                                              error?.100
                                                                              g42535313.27)
                                                                           g42535313.27
                                                                           (let ((g42535314.28
                                                                                  (unsafe-procedure-call
                                                                                   vector-set!.99
                                                                                   tmp.8.22
                                                                                   5
                                                                                   5)))
                                                                             (if (unsafe-procedure-call
                                                                                  error?.100
                                                                                  g42535314.28)
                                                                               g42535314.28
                                                                               (let ((g42535315.29
                                                                                      (unsafe-procedure-call
                                                                                       vector-set!.99
                                                                                       tmp.8.22
                                                                                       6
                                                                                       6)))
                                                                                 (if (unsafe-procedure-call
                                                                                      error?.100
                                                                                      g42535315.29)
                                                                                   g42535315.29
                                                                                   (let ((g42535316.30
                                                                                          (unsafe-procedure-call
                                                                                           vector-set!.99
                                                                                           tmp.8.22
                                                                                           7
                                                                                           7)))
                                                                                     (if (unsafe-procedure-call
                                                                                          error?.100
                                                                                          g42535316.30)
                                                                                       g42535316.30
                                                                                       tmp.8.22)))))))))))))))))))
                                                (if (unsafe-procedure-call
                                                     error?.100
                                                     g42535308.21)
                                                  g42535308.21
                                                  (let ((tmp.9.31
                                                         (unsafe-procedure-call
                                                          make-vector.98
                                                          8)))
                                                    (let ((g42535317.32
                                                           (unsafe-procedure-call
                                                            vector-set!.99
                                                            tmp.9.31
                                                            0
                                                            0)))
                                                      (if (unsafe-procedure-call
                                                           error?.100
                                                           g42535317.32)
                                                        g42535317.32
                                                        (let ((g42535318.33
                                                               (unsafe-procedure-call
                                                                vector-set!.99
                                                                tmp.9.31
                                                                1
                                                                1)))
                                                          (if (unsafe-procedure-call
                                                               error?.100
                                                               g42535318.33)
                                                            g42535318.33
                                                            (let ((g42535319.34
                                                                   (unsafe-procedure-call
                                                                    vector-set!.99
                                                                    tmp.9.31
                                                                    2
                                                                    2)))
                                                              (if (unsafe-procedure-call
                                                                   error?.100
                                                                   g42535319.34)
                                                                g42535319.34
                                                                (let ((g42535320.35
                                                                       (unsafe-procedure-call
                                                                        vector-set!.99
                                                                        tmp.9.31
                                                                        3
                                                                        3)))
                                                                  (if (unsafe-procedure-call
                                                                       error?.100
                                                                       g42535320.35)
                                                                    g42535320.35
                                                                    (let ((g42535321.36
                                                                           (unsafe-procedure-call
                                                                            vector-set!.99
                                                                            tmp.9.31
                                                                            4
                                                                            4)))
                                                                      (if (unsafe-procedure-call
                                                                           error?.100
                                                                           g42535321.36)
                                                                        g42535321.36
                                                                        (let ((g42535322.37
                                                                               (unsafe-procedure-call
                                                                                vector-set!.99
                                                                                tmp.9.31
                                                                                5
                                                                                5)))
                                                                          (if (unsafe-procedure-call
                                                                               error?.100
                                                                               g42535322.37)
                                                                            g42535322.37
                                                                            (let ((g42535323.38
                                                                                   (unsafe-procedure-call
                                                                                    vector-set!.99
                                                                                    tmp.9.31
                                                                                    6
                                                                                    6)))
                                                                              (if (unsafe-procedure-call
                                                                                   error?.100
                                                                                   g42535323.38)
                                                                                g42535323.38
                                                                                (let ((g42535324.39
                                                                                       (unsafe-procedure-call
                                                                                        vector-set!.99
                                                                                        tmp.9.31
                                                                                        7
                                                                                        7)))
                                                                                  (if (unsafe-procedure-call
                                                                                       error?.100
                                                                                       g42535324.39)
                                                                                    g42535324.39
                                                                                    tmp.9.31)))))))))))))))))))))))
                                     (if (procedure? tmp.104)
                                       (if (eq?
                                            (unsafe-procedure-arity tmp.104)
                                            0)
                                         (unsafe-procedure-call tmp.104)
                                         (error 42))
                                       (error 43))))))
                             (if (unsafe-procedure-call
                                  error?.100
                                  g42535306.19)
                               g42535306.19
                               (let ((g42535325.40
                                      (unsafe-procedure-call
                                       vector-set!.99
                                       tmp.7.15
                                       4
                                       (let ((tmp.105
                                              (unsafe-procedure-call
                                               fun/fixnum8668.10)))
                                         (if (procedure? tmp.105)
                                           (if (eq?
                                                (unsafe-procedure-arity
                                                 tmp.105)
                                                0)
                                             (unsafe-procedure-call tmp.105)
                                             (error 42))
                                           (error 43))))))
                                 (if (unsafe-procedure-call
                                      error?.100
                                      g42535325.40)
                                   g42535325.40
                                   (let ((g42535326.41
                                          (unsafe-procedure-call
                                           vector-set!.99
                                           tmp.7.15
                                           5
                                           (let ((tmp.106
                                                  (unsafe-procedure-call
                                                   fun/pair8669.11)))
                                             (if (procedure? tmp.106)
                                               (if (eq?
                                                    (unsafe-procedure-arity
                                                     tmp.106)
                                                    0)
                                                 (unsafe-procedure-call
                                                  tmp.106)
                                                 (error 42))
                                               (error 43))))))
                                     (if (unsafe-procedure-call
                                          error?.100
                                          g42535326.41)
                                       g42535326.41
                                       (let ((g42535327.42
                                              (unsafe-procedure-call
                                               vector-set!.99
                                               tmp.7.15
                                               6
                                               (let ((tmp.107
                                                      (if #t empty empty)))
                                                 (if (procedure? tmp.107)
                                                   (if (eq?
                                                        (unsafe-procedure-arity
                                                         tmp.107)
                                                        0)
                                                     (unsafe-procedure-call
                                                      tmp.107)
                                                     (error 42))
                                                   (error 43))))))
                                         (if (unsafe-procedure-call
                                              error?.100
                                              g42535327.42)
                                           g42535327.42
                                           (let ((g42535328.43
                                                  (unsafe-procedure-call
                                                   vector-set!.99
                                                   tmp.7.15
                                                   7
                                                   (let ((tmp.108
                                                          (unsafe-procedure-call
                                                           fun/fixnum8670.12)))
                                                     (if (procedure? tmp.108)
                                                       (if (eq?
                                                            (unsafe-procedure-arity
                                                             tmp.108)
                                                            0)
                                                         (unsafe-procedure-call
                                                          tmp.108)
                                                         (error 42))
                                                       (error 43))))))
                                             (if (unsafe-procedure-call
                                                  error?.100
                                                  g42535328.43)
                                               g42535328.43
                                               tmp.7.15))))))))))))))))))
            (empty1.13 (let () empty)))
        (let ((procedure0.44 (lambda () empty))) (void))))))
(check-by-interp
 '(module
    (letrec ((fun/error8673.7
              (lambda () (unsafe-procedure-call fun/error8674.8)))
             (fun/error8674.8 (lambda () (error 213)))
             (fun/error8675.9
              (lambda () (unsafe-procedure-call fun/error8676.10)))
             (fun/error8676.10 (lambda () (error 24))))
      (let ((fixnum0.13 (let () 133))
            (error1.12 (unsafe-procedure-call fun/error8673.7))
            (procedure2.11
             (lambda () (unsafe-procedure-call fun/error8675.9))))
        (if #t 142 249)))))
(check-by-interp
 '(module
    (let ((void0.8 (if #t (void) (void))) (empty1.7 (if #t empty empty)))
      (if #f #\X #\M))))
(check-by-interp
 '(module
    (letrec ((error?.92 (lambda (tmp.80) (error? tmp.80)))
             (unsafe-vector-set!.5
              (lambda (tmp.44 tmp.45 tmp.46)
                (if (unsafe-fx< tmp.45 (unsafe-vector-length tmp.44))
                  (if (unsafe-fx>= tmp.45 0)
                    (begin (unsafe-vector-set! tmp.44 tmp.45 tmp.46) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.91
              (lambda (tmp.68 tmp.69 tmp.70)
                (if (fixnum? tmp.69)
                  (if (vector? tmp.68)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.68
                     tmp.69
                     tmp.70)
                    (error 10))
                  (error 10))))
             (vector-init-loop.40
              (lambda (len.41 i.43 vec.42)
                (if (eq? len.41 i.43)
                  vec.42
                  (begin
                    (unsafe-vector-set! vec.42 i.43 0)
                    (unsafe-procedure-call
                     vector-init-loop.40
                     len.41
                     (unsafe-fx+ i.43 1)
                     vec.42)))))
             (make-init-vector.4
              (lambda (tmp.38)
                (let ((tmp.39 (unsafe-make-vector tmp.38)))
                  (unsafe-procedure-call
                   vector-init-loop.40
                   tmp.38
                   0
                   tmp.39))))
             (make-vector.90
              (lambda (tmp.66)
                (if (fixnum? tmp.66)
                  (unsafe-procedure-call make-init-vector.4 tmp.66)
                  (error 8))))
             (fun/boolean8687.9 (lambda () #f))
             (fun/boolean8686.10
              (lambda (oprand0.16) (unsafe-procedure-call fun/boolean8687.9)))
             (fun/boolean8685.11 (lambda () #f))
             (fun/void8681.12
              (lambda (oprand0.17) (unsafe-procedure-call fun/void8682.14)))
             (fun/boolean8684.13
              (lambda () (unsafe-procedure-call fun/boolean8685.11)))
             (fun/void8682.14 (lambda () (if #f (void) (void))))
             (fun/boolean8683.15
              (lambda (oprand0.19 oprand1.18)
                (unsafe-procedure-call fun/boolean8684.13))))
      (unsafe-procedure-call
       fun/void8681.12
       (unsafe-procedure-call
        fun/boolean8683.15
        (if #f
          (let ((tmp.7.20 (unsafe-procedure-call make-vector.90 8)))
            (let ((g42546779.21
                   (unsafe-procedure-call vector-set!.91 tmp.7.20 0 1)))
              (if (unsafe-procedure-call error?.92 g42546779.21)
                g42546779.21
                (let ((g42546780.22
                       (unsafe-procedure-call vector-set!.91 tmp.7.20 1 2)))
                  (if (unsafe-procedure-call error?.92 g42546780.22)
                    g42546780.22
                    (let ((g42546781.23
                           (unsafe-procedure-call
                            vector-set!.91
                            tmp.7.20
                            2
                            3)))
                      (if (unsafe-procedure-call error?.92 g42546781.23)
                        g42546781.23
                        (let ((g42546782.24
                               (unsafe-procedure-call
                                vector-set!.91
                                tmp.7.20
                                3
                                4)))
                          (if (unsafe-procedure-call error?.92 g42546782.24)
                            g42546782.24
                            (let ((g42546783.25
                                   (unsafe-procedure-call
                                    vector-set!.91
                                    tmp.7.20
                                    4
                                    5)))
                              (if (unsafe-procedure-call
                                   error?.92
                                   g42546783.25)
                                g42546783.25
                                (let ((g42546784.26
                                       (unsafe-procedure-call
                                        vector-set!.91
                                        tmp.7.20
                                        5
                                        6)))
                                  (if (unsafe-procedure-call
                                       error?.92
                                       g42546784.26)
                                    g42546784.26
                                    (let ((g42546785.27
                                           (unsafe-procedure-call
                                            vector-set!.91
                                            tmp.7.20
                                            6
                                            7)))
                                      (if (unsafe-procedure-call
                                           error?.92
                                           g42546785.27)
                                        g42546785.27
                                        (let ((g42546786.28
                                               (unsafe-procedure-call
                                                vector-set!.91
                                                tmp.7.20
                                                7
                                                8)))
                                          (if (unsafe-procedure-call
                                               error?.92
                                               g42546786.28)
                                            g42546786.28
                                            tmp.7.20)))))))))))))))))
          (let ((tmp.8.29 (unsafe-procedure-call make-vector.90 8)))
            (let ((g42546787.30
                   (unsafe-procedure-call vector-set!.91 tmp.8.29 0 1)))
              (if (unsafe-procedure-call error?.92 g42546787.30)
                g42546787.30
                (let ((g42546788.31
                       (unsafe-procedure-call vector-set!.91 tmp.8.29 1 2)))
                  (if (unsafe-procedure-call error?.92 g42546788.31)
                    g42546788.31
                    (let ((g42546789.32
                           (unsafe-procedure-call
                            vector-set!.91
                            tmp.8.29
                            2
                            3)))
                      (if (unsafe-procedure-call error?.92 g42546789.32)
                        g42546789.32
                        (let ((g42546790.33
                               (unsafe-procedure-call
                                vector-set!.91
                                tmp.8.29
                                3
                                4)))
                          (if (unsafe-procedure-call error?.92 g42546790.33)
                            g42546790.33
                            (let ((g42546791.34
                                   (unsafe-procedure-call
                                    vector-set!.91
                                    tmp.8.29
                                    4
                                    5)))
                              (if (unsafe-procedure-call
                                   error?.92
                                   g42546791.34)
                                g42546791.34
                                (let ((g42546792.35
                                       (unsafe-procedure-call
                                        vector-set!.91
                                        tmp.8.29
                                        5
                                        6)))
                                  (if (unsafe-procedure-call
                                       error?.92
                                       g42546792.35)
                                    g42546792.35
                                    (let ((g42546793.36
                                           (unsafe-procedure-call
                                            vector-set!.91
                                            tmp.8.29
                                            6
                                            7)))
                                      (if (unsafe-procedure-call
                                           error?.92
                                           g42546793.36)
                                        g42546793.36
                                        (let ((g42546794.37
                                               (unsafe-procedure-call
                                                vector-set!.91
                                                tmp.8.29
                                                7
                                                8)))
                                          (if (unsafe-procedure-call
                                               error?.92
                                               g42546794.37)
                                            g42546794.37
                                            tmp.8.29))))))))))))))))))
        (unsafe-procedure-call
         fun/boolean8686.10
         (if #t (lambda () 628) (lambda () 577))))))))
(check-by-interp
 '(module
    (letrec ((error?.69 (lambda (tmp.59) (error? tmp.59)))
             (fun/error8693.7 (lambda (oprand0.11) (error 130)))
             (fun/boolean8690.8 (lambda () (if #f #f #f)))
             (fun/empty8691.9
              (lambda (oprand0.13 oprand1.12)
                (unsafe-procedure-call fun/empty8692.10)))
             (fun/empty8692.10 (lambda () empty)))
      (if (unsafe-procedure-call fun/boolean8690.8)
        (let ((empty0.14 empty)) empty)
        (unsafe-procedure-call
         fun/empty8691.9
         (unsafe-procedure-call fun/error8693.7 #\r)
         (let ((g42550609.15 #\x))
           (if (unsafe-procedure-call error?.69 g42550609.15)
             g42550609.15
             (let ((g42550610.16 #\U))
               (if (unsafe-procedure-call error?.69 g42550610.16)
                 g42550610.16
                 #\O)))))))))
(check-by-interp
 '(module
    (letrec ((cons.98 (lambda (tmp.89 tmp.90) (cons tmp.89 tmp.90)))
             (void?.97 (lambda (tmp.82) (void? tmp.82)))
             (error?.96 (lambda (tmp.84) (error? tmp.84)))
             (unsafe-vector-set!.5
              (lambda (tmp.48 tmp.49 tmp.50)
                (if (unsafe-fx< tmp.49 (unsafe-vector-length tmp.48))
                  (if (unsafe-fx>= tmp.49 0)
                    (begin (unsafe-vector-set! tmp.48 tmp.49 tmp.50) (void))
                    (error 10))
                  (error 10))))
             (vector-set!.95
              (lambda (tmp.72 tmp.73 tmp.74)
                (if (fixnum? tmp.73)
                  (if (vector? tmp.72)
                    (unsafe-procedure-call
                     unsafe-vector-set!.5
                     tmp.72
                     tmp.73
                     tmp.74)
                    (error 10))
                  (error 10))))
             (vector-init-loop.44
              (lambda (len.45 i.47 vec.46)
                (if (eq? len.45 i.47)
                  vec.46
                  (begin
                    (unsafe-vector-set! vec.46 i.47 0)
                    (unsafe-procedure-call
                     vector-init-loop.44
                     len.45
                     (unsafe-fx+ i.47 1)
                     vec.46)))))
             (make-init-vector.4
              (lambda (tmp.42)
                (let ((tmp.43 (unsafe-make-vector tmp.42)))
                  (unsafe-procedure-call
                   vector-init-loop.44
                   tmp.42
                   0
                   tmp.43))))
             (make-vector.94
              (lambda (tmp.70)
                (if (fixnum? tmp.70)
                  (unsafe-procedure-call make-init-vector.4 tmp.70)
                  (error 8))))
             (fun/empty8699.15 (lambda () empty))
             (fun/empty8698.16 (lambda () empty))
             (fun/ascii-char8697.17 (lambda () #\Y))
             (fun/procedure8696.18 (lambda () (lambda () 758))))
      (let ((vector0.21
             (let ((tmp.7.22 (unsafe-procedure-call make-vector.94 8)))
               (let ((g42554425.23
                      (unsafe-procedure-call
                       vector-set!.95
                       tmp.7.22
                       0
                       (let ((tmp.99
                              (unsafe-procedure-call fun/procedure8696.18)))
                         (if (procedure? tmp.99)
                           (if (eq? (unsafe-procedure-arity tmp.99) 0)
                             (unsafe-procedure-call tmp.99)
                             (error 42))
                           (error 43))))))
                 (if (unsafe-procedure-call error?.96 g42554425.23)
                   g42554425.23
                   (let ((g42554426.24
                          (unsafe-procedure-call
                           vector-set!.95
                           tmp.7.22
                           1
                           (let ((tmp.100 (let () empty)))
                             (if (procedure? tmp.100)
                               (if (eq? (unsafe-procedure-arity tmp.100) 0)
                                 (unsafe-procedure-call tmp.100)
                                 (error 42))
                               (error 43))))))
                     (if (unsafe-procedure-call error?.96 g42554426.24)
                       g42554426.24
                       (let ((g42554427.25
                              (unsafe-procedure-call
                               vector-set!.95
                               tmp.7.22
                               2
                               (let ((tmp.101 (if #t empty empty)))
                                 (if (procedure? tmp.101)
                                   (if (eq? (unsafe-procedure-arity tmp.101) 0)
                                     (unsafe-procedure-call tmp.101)
                                     (error 42))
                                   (error 43))))))
                         (if (unsafe-procedure-call error?.96 g42554427.25)
                           g42554427.25
                           (let ((g42554428.26
                                  (unsafe-procedure-call
                                   vector-set!.95
                                   tmp.7.22
                                   3
                                   (let ((tmp.102 (let () #\_)))
                                     (if (procedure? tmp.102)
                                       (if (eq?
                                            (unsafe-procedure-arity tmp.102)
                                            0)
                                         (unsafe-procedure-call tmp.102)
                                         (error 42))
                                       (error 43))))))
                             (if (unsafe-procedure-call error?.96 g42554428.26)
                               g42554428.26
                               (let ((g42554429.27
                                      (unsafe-procedure-call
                                       vector-set!.95
                                       tmp.7.22
                                       4
                                       (let ((tmp.103
                                              (let ((g42554430.28 156))
                                                (if (unsafe-procedure-call
                                                     error?.96
                                                     g42554430.28)
                                                  g42554430.28
                                                  (let ((g42554431.29 226))
                                                    (if (unsafe-procedure-call
                                                         error?.96
                                                         g42554431.29)
                                                      g42554431.29
                                                      114))))))
                                         (if (procedure? tmp.103)
                                           (if (eq?
                                                (unsafe-procedure-arity
                                                 tmp.103)
                                                0)
                                             (unsafe-procedure-call tmp.103)
                                             (error 42))
                                           (error 43))))))
                                 (if (unsafe-procedure-call
                                      error?.96
                                      g42554429.27)
                                   g42554429.27
                                   (let ((g42554432.30
                                          (unsafe-procedure-call
                                           vector-set!.95
                                           tmp.7.22
                                           5
                                           (let ((tmp.104
                                                  (unsafe-procedure-call
                                                   void?.97
                                                   9)))
                                             (if (procedure? tmp.104)
                                               (if (eq?
                                                    (unsafe-procedure-arity
                                                     tmp.104)
                                                    0)
                                                 (unsafe-procedure-call
                                                  tmp.104)
                                                 (error 42))
                                               (error 43))))))
                                     (if (unsafe-procedure-call
                                          error?.96
                                          g42554432.30)
                                       g42554432.30
                                       (let ((g42554433.31
                                              (unsafe-procedure-call
                                               vector-set!.95
                                               tmp.7.22
                                               6
                                               (let ((tmp.105
                                                      (let ()
                                                        (unsafe-procedure-call
                                                         cons.98
                                                         41
                                                         (unsafe-procedure-call
                                                          cons.98
                                                          429
                                                          empty)))))
                                                 (if (procedure? tmp.105)
                                                   (if (eq?
                                                        (unsafe-procedure-arity
                                                         tmp.105)
                                                        0)
                                                     (unsafe-procedure-call
                                                      tmp.105)
                                                     (error 42))
                                                   (error 43))))))
                                         (if (unsafe-procedure-call
                                              error?.96
                                              g42554433.31)
                                           g42554433.31
                                           (let ((g42554434.32
                                                  (unsafe-procedure-call
                                                   vector-set!.95
                                                   tmp.7.22
                                                   7
                                                   (let ((tmp.106
                                                          (unsafe-procedure-call
                                                           fun/ascii-char8697.17)))
                                                     (if (procedure? tmp.106)
                                                       (if (eq?
                                                            (unsafe-procedure-arity
                                                             tmp.106)
                                                            0)
                                                         (unsafe-procedure-call
                                                          tmp.106)
                                                         (error 42))
                                                       (error 43))))))
                                             (if (unsafe-procedure-call
                                                  error?.96
                                                  g42554434.32)
                                               g42554434.32
                                               tmp.7.22))))))))))))))))))
            (error1.20
             (if (let ((tmp.8.33 (error 116)))
                   (if tmp.8.33 tmp.8.33 (error 83)))
               (if (if #t (error 231) (error 0))
                 (if (let () (error 12))
                   (if (if #f (error 179) (error 209)) (let () (error 198)) #f)
                   #f)
                 #f)
               #f))
            (void2.19 (if #f (void) (void))))
        (let ((tmp.9.34 (if #t empty empty)))
          (if tmp.9.34
            tmp.9.34
            (let ((tmp.10.35 (let () empty)))
              (if tmp.10.35
                tmp.10.35
                (let ((tmp.11.36 (unsafe-procedure-call fun/empty8698.16)))
                  (if tmp.11.36
                    tmp.11.36
                    (let ((tmp.12.37
                           (let ((g42554435.38 empty))
                             (if (unsafe-procedure-call error?.96 g42554435.38)
                               g42554435.38
                               (let ((g42554436.39 empty))
                                 (if (unsafe-procedure-call
                                      error?.96
                                      g42554436.39)
                                   g42554436.39
                                   empty))))))
                      (if tmp.12.37
                        tmp.12.37
                        (let ((tmp.13.40 (if empty empty #f)))
                          (if tmp.13.40
                            tmp.13.40
                            (let ((tmp.14.41 (if #t empty empty)))
                              (if tmp.14.41
                                tmp.14.41
                                (unsafe-procedure-call
                                 fun/empty8699.15)))))))))))))))))
(check-by-interp
 '(module
    (letrec ((fun/error8703.7 (lambda () (error 178)))
             (fun/error8702.8
              (lambda (oprand0.9) (unsafe-procedure-call fun/error8703.7))))
      (let ()
        (unsafe-procedure-call
         fun/error8702.8
         (if #t (lambda () 781) (lambda () 718)))))))
(check-by-interp
 '(module
    (letrec ((error?.77 (lambda (tmp.67) (error? tmp.67)))
             (fun/ascii-char8706.13 (lambda () #\D)))
      (let ((empty0.14 (if #t empty empty)))
        (let ((tmp.7.15 (if #f #\m #\w)))
          (if tmp.7.15
            tmp.7.15
            (let ((tmp.8.16 (unsafe-procedure-call fun/ascii-char8706.13)))
              (if tmp.8.16
                tmp.8.16
                (let ((tmp.9.17
                       (let ((error0.19 (error 46)) (boolean1.18 #f)) #\N)))
                  (if tmp.9.17
                    tmp.9.17
                    (let ((tmp.10.20 (if #t #\` #\M)))
                      (if tmp.10.20
                        tmp.10.20
                        (let ((tmp.11.21
                               (let ((g42562071.22 #\n))
                                 (if (unsafe-procedure-call
                                      error?.77
                                      g42562071.22)
                                   g42562071.22
                                   (let ((g42562072.23 #\L))
                                     (if (unsafe-procedure-call
                                          error?.77
                                          g42562072.23)
                                       g42562072.23
                                       #\c))))))
                          (if tmp.11.21
                            tmp.11.21
                            (let ((tmp.12.24 (if #t #\L #\m)))
                              (if tmp.12.24
                                tmp.12.24
                                (if #\u
                                  (if #\I (if #\S #\T #f) #f)
                                  #f)))))))))))))))))
(check-by-interp
 '(module
    (letrec ((fun/void8714.7 (lambda () (let ((void0.9 (void))) (void))))
             (fun/void8713.8
              (lambda () (unsafe-procedure-call fun/void8714.7))))
      (unsafe-procedure-call fun/void8713.8))))
