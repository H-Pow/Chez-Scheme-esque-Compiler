#lang racket
(require rackunit
         cpsc411/compiler-lib
         cpsc411/ptr-run-time
         cpsc411/langs/v8
         cpsc411/langs/v9
         cpsc411/langs/v11
         "../optimize-known-calls.rkt")
(define (fail-if-invalid p)
  (when (not (closure-lang-v9? p))
    (error
     (~a
      (pretty-format p)
      "\n is not a semantically valid "
      "closure-lang-v9"
      " program")))
  p)
(define-syntax-rule
 (check-by-interp p)
 (check-equal?
  (interp-closure-lang-v9 p)
  (interp-closure-lang-v9 (fail-if-invalid (optimize-known-calls p)))))

(check-by-interp '(module empty))
(check-by-interp '(module (error 240)))
(check-by-interp '(module empty))
(check-by-interp '(module #\x))
(check-by-interp '(module (if empty empty #f)))
(check-by-interp '(module (let () 212)))
(check-by-interp
 '(module
    (letrec ((L.fun/fixnum8485.7.10 (lambda (c.60) (let () 60))))
      (cletrec
       ((fun/fixnum8485.7 (make-closure L.fun/fixnum8485.7.10 0)))
       (closure-call fun/fixnum8485.7 fun/fixnum8485.7)))))
(check-by-interp
 '(module
    (letrec ((L.fun/ascii-char8488.7.10 (lambda (c.60) (let () #\A))))
      (cletrec
       ((fun/ascii-char8488.7 (make-closure L.fun/ascii-char8488.7.10 0)))
       (closure-call fun/ascii-char8488.7 fun/ascii-char8488.7)))))
(check-by-interp
 '(module
    (letrec ((L.fun/ascii-char8491.7.10 (lambda (c.60) (let () #\Z))))
      (cletrec
       ((fun/ascii-char8491.7 (make-closure L.fun/ascii-char8491.7.10 0)))
       (closure-call fun/ascii-char8491.7 fun/ascii-char8491.7)))))
(check-by-interp
 '(module
    (let ((tmp.7.12 #\h))
      (if tmp.7.12
        tmp.7.12
        (let ((tmp.8.13 #\l))
          (if tmp.8.13
            tmp.8.13
            (let ((tmp.9.14 #\K))
              (if tmp.9.14
                tmp.9.14
                (let ((tmp.10.15 #\i))
                  (if tmp.10.15
                    tmp.10.15
                    (let ((tmp.11.16 #\m))
                      (if tmp.11.16 tmp.11.16 #\y))))))))))))
(check-by-interp '(module (if #t 219 101)))
(check-by-interp
 '(module
    (letrec ((L.fun/empty8500.7.10 (lambda (c.60) (let () empty))))
      (cletrec
       ((fun/empty8500.7 (make-closure L.fun/empty8500.7.10 0)))
       (closure-call fun/empty8500.7 fun/empty8500.7)))))
(check-by-interp
 '(module
    (if (let () empty)
      (if (if empty
            (if empty (if empty (if empty (if empty empty #f) #f) #f) #f)
            #f)
        (if #t empty empty)
        #f)
      #f)))
(check-by-interp
 '(module
    (letrec ((L.unsafe-vector-set!.5.10
              (lambda (c.84 tmp.35 tmp.36 tmp.37)
                (let ()
                  (if (unsafe-fx< tmp.36 (unsafe-vector-length tmp.35))
                    (if (unsafe-fx>= tmp.36 0)
                      (begin (unsafe-vector-set! tmp.35 tmp.36 tmp.37) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.83.11
              (lambda (c.85 tmp.59 tmp.60 tmp.61)
                (let ((unsafe-vector-set!.5 (closure-ref c.85 0)))
                  (if (fixnum? tmp.60)
                    (if (vector? tmp.59)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.59
                       tmp.60
                       tmp.61)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.31.12
              (lambda (c.86 len.32 i.34 vec.33)
                (let ((vector-init-loop.31 (closure-ref c.86 0)))
                  (if (eq? len.32 i.34)
                    vec.33
                    (begin
                      (unsafe-vector-set! vec.33 i.34 0)
                      (closure-call
                       vector-init-loop.31
                       vector-init-loop.31
                       len.32
                       (unsafe-fx+ i.34 1)
                       vec.33))))))
             (L.make-init-vector.4.13
              (lambda (c.87 tmp.29)
                (let ((vector-init-loop.31 (closure-ref c.87 0)))
                  (let ((tmp.30 (unsafe-make-vector tmp.29)))
                    (closure-call
                     vector-init-loop.31
                     vector-init-loop.31
                     tmp.29
                     0
                     tmp.30)))))
             (L.make-vector.82.14
              (lambda (c.88 tmp.57)
                (let ((make-init-vector.4 (closure-ref c.88 0)))
                  (if (fixnum? tmp.57)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.57)
                    (error 8)))))
             (L.error?.81.15 (lambda (c.89 tmp.71) (let () (error? tmp.71))))
             (L.fun/void8514.8.16 (lambda (c.90) (let () (void))))
             (L.fun/void8513.9.17 (lambda (c.91) (let () (void)))))
      (cletrec
       ((unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.10 3))
        (vector-set!.83
         (make-closure L.vector-set!.83.11 3 unsafe-vector-set!.5))
        (vector-init-loop.31
         (make-closure L.vector-init-loop.31.12 3 vector-init-loop.31))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.13 1 vector-init-loop.31))
        (make-vector.82
         (make-closure L.make-vector.82.14 1 make-init-vector.4))
        (error?.81 (make-closure L.error?.81.15 1))
        (fun/void8514.8 (make-closure L.fun/void8514.8.16 0))
        (fun/void8513.9 (make-closure L.fun/void8513.9.17 0)))
       (let ((g42771912.10 (if #f (void) (void))))
         (if (closure-call error?.81 error?.81 g42771912.10)
           g42771912.10
           (let ((g42771913.11 (closure-call fun/void8513.9 fun/void8513.9)))
             (if (closure-call error?.81 error?.81 g42771913.11)
               g42771913.11
               (let ((g42771914.12
                      (let ((vector0.13
                             (let ((tmp.7.14
                                    (closure-call
                                     make-vector.82
                                     make-vector.82
                                     8)))
                               (let ((g42771915.15
                                      (closure-call
                                       vector-set!.83
                                       vector-set!.83
                                       tmp.7.14
                                       0
                                       0)))
                                 (if (closure-call
                                      error?.81
                                      error?.81
                                      g42771915.15)
                                   g42771915.15
                                   (let ((g42771916.16
                                          (closure-call
                                           vector-set!.83
                                           vector-set!.83
                                           tmp.7.14
                                           1
                                           1)))
                                     (if (closure-call
                                          error?.81
                                          error?.81
                                          g42771916.16)
                                       g42771916.16
                                       (let ((g42771917.17
                                              (closure-call
                                               vector-set!.83
                                               vector-set!.83
                                               tmp.7.14
                                               2
                                               2)))
                                         (if (closure-call
                                              error?.81
                                              error?.81
                                              g42771917.17)
                                           g42771917.17
                                           (let ((g42771918.18
                                                  (closure-call
                                                   vector-set!.83
                                                   vector-set!.83
                                                   tmp.7.14
                                                   3
                                                   3)))
                                             (if (closure-call
                                                  error?.81
                                                  error?.81
                                                  g42771918.18)
                                               g42771918.18
                                               (let ((g42771919.19
                                                      (closure-call
                                                       vector-set!.83
                                                       vector-set!.83
                                                       tmp.7.14
                                                       4
                                                       4)))
                                                 (if (closure-call
                                                      error?.81
                                                      error?.81
                                                      g42771919.19)
                                                   g42771919.19
                                                   (let ((g42771920.20
                                                          (closure-call
                                                           vector-set!.83
                                                           vector-set!.83
                                                           tmp.7.14
                                                           5
                                                           5)))
                                                     (if (closure-call
                                                          error?.81
                                                          error?.81
                                                          g42771920.20)
                                                       g42771920.20
                                                       (let ((g42771921.21
                                                              (closure-call
                                                               vector-set!.83
                                                               vector-set!.83
                                                               tmp.7.14
                                                               6
                                                               6)))
                                                         (if (closure-call
                                                              error?.81
                                                              error?.81
                                                              g42771921.21)
                                                           g42771921.21
                                                           (let ((g42771922.22
                                                                  (closure-call
                                                                   vector-set!.83
                                                                   vector-set!.83
                                                                   tmp.7.14
                                                                   7
                                                                   7)))
                                                             (if (closure-call
                                                                  error?.81
                                                                  error?.81
                                                                  g42771922.22)
                                                               g42771922.22
                                                               tmp.7.14)))))))))))))))))))
                        (void))))
                 (if (closure-call error?.81 error?.81 g42771914.12)
                   g42771914.12
                   (let ((g42771923.23
                          (let ((g42771924.24 (void)))
                            (if (closure-call error?.81 error?.81 g42771924.24)
                              g42771924.24
                              (let ((g42771925.25 (void)))
                                (if (closure-call
                                     error?.81
                                     error?.81
                                     g42771925.25)
                                  g42771925.25
                                  (let ((g42771926.26 (void)))
                                    (if (closure-call
                                         error?.81
                                         error?.81
                                         g42771926.26)
                                      g42771926.26
                                      (void)))))))))
                     (if (closure-call error?.81 error?.81 g42771923.23)
                       g42771923.23
                       (let ((g42771927.27 (let () (void))))
                         (if (closure-call error?.81 error?.81 g42771927.27)
                           g42771927.27
                           (let ((g42771928.28 (let () (void))))
                             (if (closure-call
                                  error?.81
                                  error?.81
                                  g42771928.28)
                               g42771928.28
                               (closure-call
                                fun/void8514.8
                                fun/void8514.8)))))))))))))))))
(check-by-interp '(module (let () empty)))
(check-by-interp '(module (let () #\Y)))
(check-by-interp
 '(module
    (letrec ((L.fun/empty8524.7.10
              (lambda (c.60) (let () (if #f empty empty)))))
      (cletrec
       ((fun/empty8524.7 (make-closure L.fun/empty8524.7.10 0)))
       (closure-call fun/empty8524.7 fun/empty8524.7)))))
(check-by-interp '(module (if #t empty empty)))
(check-by-interp '(module (let ((fixnum0.7 33)) #t)))
(check-by-interp
 '(module
    (letrec ((L.fun/void8531.7.10
              (lambda (c.60) (let () (if #f (void) (void))))))
      (cletrec
       ((fun/void8531.7 (make-closure L.fun/void8531.7.10 0)))
       (closure-call fun/void8531.7 fun/void8531.7)))))
(check-by-interp
 '(module
    (letrec ((L.error?.72.10 (lambda (c.74 tmp.62) (let () (error? tmp.62))))
             (L.fun/error8534.11.11 (lambda (c.75) (let () (error 82))))
             (L.fun/error8535.12.12 (lambda (c.76) (let () (error 60)))))
      (cletrec
       ((error?.72 (make-closure L.error?.72.10 1))
        (fun/error8534.11 (make-closure L.fun/error8534.11.11 0))
        (fun/error8535.12 (make-closure L.fun/error8535.12.12 0)))
       (if (let ((tmp.7.13 (error 39)))
             (if tmp.7.13
               tmp.7.13
               (let ((tmp.8.14 (error 193)))
                 (if tmp.8.14
                   tmp.8.14
                   (let ((tmp.9.15 (error 124)))
                     (if tmp.9.15
                       tmp.9.15
                       (let ((tmp.10.16 (error 73)))
                         (if tmp.10.16 tmp.10.16 (error 75)))))))))
         (if (if #f (error 124) (error 124))
           (if (closure-call fun/error8534.11 fun/error8534.11)
             (if (closure-call fun/error8535.12 fun/error8535.12)
               (if (if #f (error 148) (error 136))
                 (if (let ((procedure0.17
                            (letrec ((L.lam.73.13
                                      (lambda (c.77) (let () (error 109)))))
                              (cletrec
                               ((lam.73 (make-closure L.lam.73.13 0)))
                               lam.73))))
                       (error 64))
                   (let ((g42798643.18 (error 54)))
                     (if (closure-call error?.72 error?.72 g42798643.18)
                       g42798643.18
                       (let ((g42798644.19 (error 109)))
                         (if (closure-call error?.72 error?.72 g42798644.19)
                           g42798644.19
                           (error 200)))))
                   #f)
                 #f)
               #f)
             #f)
           #f)
         #f)))))
(check-by-interp
 '(module
    (letrec ((L.fun/void8538.7.10 (lambda (c.60) (let () (void)))))
      (cletrec
       ((fun/void8538.7 (make-closure L.fun/void8538.7.10 0)))
       (if (if (void) (void) #f)
         (closure-call fun/void8538.7 fun/void8538.7)
         #f)))))
(check-by-interp '(module (if #f #\_ #\i)))
(check-by-interp
 '(module
    (letrec ((L.fun/fixnum8543.7.10
              (lambda (c.61)
                (let ((fun/fixnum8544.8 (closure-ref c.61 0)))
                  (closure-call fun/fixnum8544.8 fun/fixnum8544.8))))
             (L.fun/fixnum8544.8.11 (lambda (c.62) (let () 117))))
      (cletrec
       ((fun/fixnum8543.7
         (make-closure L.fun/fixnum8543.7.10 0 fun/fixnum8544.8))
        (fun/fixnum8544.8 (make-closure L.fun/fixnum8544.8.11 0)))
       (closure-call fun/fixnum8543.7 fun/fixnum8543.7)))))
(check-by-interp '(module (if #f (error 164) (error 184))))
(check-by-interp '(module (let () #\Z)))
(check-by-interp
 '(module
    (letrec ((L.fun/fixnum8551.7.10 (lambda (c.60) (let () (if #t 67 129)))))
      (cletrec
       ((fun/fixnum8551.7 (make-closure L.fun/fixnum8551.7.10 0)))
       (closure-call fun/fixnum8551.7 fun/fixnum8551.7)))))
(check-by-interp
 '(module
    (letrec ((L.fun/error8558.7.10
              (lambda (c.61)
                (let ((fun/error8559.8 (closure-ref c.61 0)))
                  (closure-call fun/error8559.8 fun/error8559.8))))
             (L.fun/error8559.8.11 (lambda (c.62) (let () (error 186)))))
      (cletrec
       ((fun/error8558.7 (make-closure L.fun/error8558.7.10 0 fun/error8559.8))
        (fun/error8559.8 (make-closure L.fun/error8559.8.11 0)))
       (closure-call fun/error8558.7 fun/error8558.7)))))
(check-by-interp
 '(module
    (letrec ((L.fun/void8562.7.10
              (lambda (c.65)
                (let ((fun/void8563.10 (closure-ref c.65 0)))
                  (closure-call fun/void8563.10 fun/void8563.10))))
             (L.fun/void8565.8.11 (lambda (c.66) (let () (void))))
             (L.fun/void8564.9.12
              (lambda (c.67)
                (let ((fun/void8565.8 (closure-ref c.67 0)))
                  (closure-call fun/void8565.8 fun/void8565.8))))
             (L.fun/void8563.10.13 (lambda (c.68) (let () (void)))))
      (cletrec
       ((fun/void8562.7 (make-closure L.fun/void8562.7.10 0 fun/void8563.10))
        (fun/void8565.8 (make-closure L.fun/void8565.8.11 0))
        (fun/void8564.9 (make-closure L.fun/void8564.9.12 0 fun/void8565.8))
        (fun/void8563.10 (make-closure L.fun/void8563.10.13 0)))
       (if (closure-call fun/void8562.7 fun/void8562.7)
         (if (let ((void0.12 (void)) (error1.11 (error 196))) (void))
           (closure-call fun/void8564.9 fun/void8564.9)
           #f)
         #f)))))
(check-by-interp
 '(module
    (letrec ((L.fun/ascii-char8568.7.10
              (lambda (c.62 oprand0.9)
                (let ((fun/ascii-char8569.8 (closure-ref c.62 0)))
                  (closure-call fun/ascii-char8569.8 fun/ascii-char8569.8))))
             (L.fun/ascii-char8569.8.11 (lambda (c.63) (let () #\X))))
      (cletrec
       ((fun/ascii-char8568.7
         (make-closure L.fun/ascii-char8568.7.10 1 fun/ascii-char8569.8))
        (fun/ascii-char8569.8 (make-closure L.fun/ascii-char8569.8.11 0)))
       (closure-call
        fun/ascii-char8568.7
        fun/ascii-char8568.7
        (if #t 65 125))))))
(check-by-interp
 '(module
    (letrec ((L.cons.78.10
              (lambda (c.80 tmp.70 tmp.71) (let () (cons tmp.70 tmp.71))))
             (L.error?.77.11 (lambda (c.81 tmp.65) (let () (error? tmp.65))))
             (L.unsafe-vector-set!.5.12
              (lambda (c.82 tmp.29 tmp.30 tmp.31)
                (let ()
                  (if (unsafe-fx< tmp.30 (unsafe-vector-length tmp.29))
                    (if (unsafe-fx>= tmp.30 0)
                      (begin (unsafe-vector-set! tmp.29 tmp.30 tmp.31) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.76.13
              (lambda (c.83 tmp.53 tmp.54 tmp.55)
                (let ((unsafe-vector-set!.5 (closure-ref c.83 0)))
                  (if (fixnum? tmp.54)
                    (if (vector? tmp.53)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.53
                       tmp.54
                       tmp.55)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.25.14
              (lambda (c.84 len.26 i.28 vec.27)
                (let ((vector-init-loop.25 (closure-ref c.84 0)))
                  (if (eq? len.26 i.28)
                    vec.27
                    (begin
                      (unsafe-vector-set! vec.27 i.28 0)
                      (closure-call
                       vector-init-loop.25
                       vector-init-loop.25
                       len.26
                       (unsafe-fx+ i.28 1)
                       vec.27))))))
             (L.make-init-vector.4.15
              (lambda (c.85 tmp.23)
                (let ((vector-init-loop.25 (closure-ref c.85 0)))
                  (let ((tmp.24 (unsafe-make-vector tmp.23)))
                    (closure-call
                     vector-init-loop.25
                     vector-init-loop.25
                     tmp.23
                     0
                     tmp.24)))))
             (L.make-vector.75.16
              (lambda (c.86 tmp.51)
                (let ((make-init-vector.4 (closure-ref c.86 0)))
                  (if (fixnum? tmp.51)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.51)
                    (error 8))))))
      (cletrec
       ((cons.78 (make-closure L.cons.78.10 2))
        (error?.77 (make-closure L.error?.77.11 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.12 3))
        (vector-set!.76
         (make-closure L.vector-set!.76.13 3 unsafe-vector-set!.5))
        (vector-init-loop.25
         (make-closure L.vector-init-loop.25.14 3 vector-init-loop.25))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.15 1 vector-init-loop.25))
        (make-vector.75
         (make-closure L.make-vector.75.16 1 make-init-vector.4)))
       (let ((vector0.9
              (let ((tmp.7.10 (closure-call make-vector.75 make-vector.75 8)))
                (let ((g42836815.11
                       (closure-call
                        vector-set!.76
                        vector-set!.76
                        tmp.7.10
                        0
                        (closure-call make-vector.75 make-vector.75 8))))
                  (if (closure-call error?.77 error?.77 g42836815.11)
                    g42836815.11
                    (let ((g42836816.12
                           (closure-call
                            vector-set!.76
                            vector-set!.76
                            tmp.7.10
                            1
                            (closure-call
                             cons.78
                             cons.78
                             206
                             (closure-call cons.78 cons.78 384 empty)))))
                      (if (closure-call error?.77 error?.77 g42836816.12)
                        g42836816.12
                        (let ((g42836817.13
                               (closure-call
                                vector-set!.76
                                vector-set!.76
                                tmp.7.10
                                2
                                (closure-call
                                 cons.78
                                 cons.78
                                 188
                                 (closure-call cons.78 cons.78 505 empty)))))
                          (if (closure-call error?.77 error?.77 g42836817.13)
                            g42836817.13
                            (let ((g42836818.14
                                   (closure-call
                                    vector-set!.76
                                    vector-set!.76
                                    tmp.7.10
                                    3
                                    #\l)))
                              (if (closure-call
                                   error?.77
                                   error?.77
                                   g42836818.14)
                                g42836818.14
                                (let ((g42836819.15
                                       (closure-call
                                        vector-set!.76
                                        vector-set!.76
                                        tmp.7.10
                                        4
                                        (closure-call
                                         cons.78
                                         cons.78
                                         154
                                         (closure-call
                                          cons.78
                                          cons.78
                                          282
                                          empty)))))
                                  (if (closure-call
                                       error?.77
                                       error?.77
                                       g42836819.15)
                                    g42836819.15
                                    (let ((g42836820.16
                                           (closure-call
                                            vector-set!.76
                                            vector-set!.76
                                            tmp.7.10
                                            5
                                            (void))))
                                      (if (closure-call
                                           error?.77
                                           error?.77
                                           g42836820.16)
                                        g42836820.16
                                        (let ((g42836821.17
                                               (closure-call
                                                vector-set!.76
                                                vector-set!.76
                                                tmp.7.10
                                                6
                                                (letrec ((L.lam.79.17
                                                          (lambda (c.87)
                                                            (let () 892))))
                                                  (cletrec
                                                   ((lam.79
                                                     (make-closure
                                                      L.lam.79.17
                                                      0)))
                                                   lam.79)))))
                                          (if (closure-call
                                               error?.77
                                               error?.77
                                               g42836821.17)
                                            g42836821.17
                                            (let ((g42836822.18
                                                   (closure-call
                                                    vector-set!.76
                                                    vector-set!.76
                                                    tmp.7.10
                                                    7
                                                    #f)))
                                              (if (closure-call
                                                   error?.77
                                                   error?.77
                                                   g42836822.18)
                                                g42836822.18
                                                tmp.7.10))))))))))))))))))
             (void1.8
              (let ((g42836823.19 (void)))
                (if (closure-call error?.77 error?.77 g42836823.19)
                  g42836823.19
                  (let ((g42836824.20 (void)))
                    (if (closure-call error?.77 error?.77 g42836824.20)
                      g42836824.20
                      (let ((g42836825.21 (void)))
                        (if (closure-call error?.77 error?.77 g42836825.21)
                          g42836825.21
                          (let ((g42836826.22 (void)))
                            (if (closure-call error?.77 error?.77 g42836826.22)
                              g42836826.22
                              (void)))))))))))
         (let () 170))))))
(check-by-interp
 '(module
    (letrec ((L.cons.64.10
              (lambda (c.65 tmp.58 tmp.59) (let () (cons tmp.58 tmp.59))))
             (L.vector-init-loop.13.11
              (lambda (c.66 len.14 i.16 vec.15)
                (let ((vector-init-loop.13 (closure-ref c.66 0)))
                  (if (eq? len.14 i.16)
                    vec.15
                    (begin
                      (unsafe-vector-set! vec.15 i.16 0)
                      (closure-call
                       vector-init-loop.13
                       vector-init-loop.13
                       len.14
                       (unsafe-fx+ i.16 1)
                       vec.15))))))
             (L.make-init-vector.4.12
              (lambda (c.67 tmp.11)
                (let ((vector-init-loop.13 (closure-ref c.67 0)))
                  (let ((tmp.12 (unsafe-make-vector tmp.11)))
                    (closure-call
                     vector-init-loop.13
                     vector-init-loop.13
                     tmp.11
                     0
                     tmp.12)))))
             (L.make-vector.63.13
              (lambda (c.68 tmp.39)
                (let ((make-init-vector.4 (closure-ref c.68 0)))
                  (if (fixnum? tmp.39)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.39)
                    (error 8)))))
             (L.fun/boolean8574.7.14 (lambda (c.69 oprand0.8) (let () #f))))
      (cletrec
       ((cons.64 (make-closure L.cons.64.10 2))
        (vector-init-loop.13
         (make-closure L.vector-init-loop.13.11 3 vector-init-loop.13))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.12 1 vector-init-loop.13))
        (make-vector.63
         (make-closure L.make-vector.63.13 1 make-init-vector.4))
        (fun/boolean8574.7 (make-closure L.fun/boolean8574.7.14 1)))
       (if (closure-call
            fun/boolean8574.7
            fun/boolean8574.7
            (closure-call make-vector.63 make-vector.63 8))
         (if #t #\C #\])
         (let ((void0.10 (void))
               (pair1.9
                (closure-call
                 cons.64
                 cons.64
                 184
                 (closure-call cons.64 cons.64 385 empty))))
           #\Y))))))
(check-by-interp
 '(module
    (letrec ((L.fun/empty8578.7.10
              (lambda (c.67)
                (let ((fun/empty8579.8 (closure-ref c.67 0)))
                  (closure-call fun/empty8579.8 fun/empty8579.8))))
             (L.fun/empty8579.8.11 (lambda (c.68) (let () empty)))
             (L.fun/empty8577.9.12
              (lambda (c.69 oprand0.10) (let () (if #f empty empty)))))
      (cletrec
       ((fun/empty8578.7 (make-closure L.fun/empty8578.7.10 0 fun/empty8579.8))
        (fun/empty8579.8 (make-closure L.fun/empty8579.8.11 0))
        (fun/empty8577.9 (make-closure L.fun/empty8577.9.12 1)))
       (if (let ((ascii-char0.11 #\^)) empty)
         (if (closure-call
              fun/empty8577.9
              fun/empty8577.9
              (if empty (if empty (if empty empty #f) #f) #f))
           (if (let () empty)
             (if (let ((procedure0.13
                        (letrec ((L.lam.66.13 (lambda (c.70) (let () #f))))
                          (cletrec
                           ((lam.66 (make-closure L.lam.66.13 0)))
                           lam.66)))
                       (fixnum1.12 204))
                   empty)
               (closure-call fun/empty8578.7 fun/empty8578.7)
               #f)
             #f)
           #f)
         #f)))))
(check-by-interp
 '(module
    (letrec ((L.>=.77.10
              (lambda (c.78 tmp.47 tmp.48)
                (let ()
                  (if (fixnum? tmp.48)
                    (if (fixnum? tmp.47) (unsafe-fx>= tmp.47 tmp.48) (error 7))
                    (error 7)))))
             (L.*.76.11
              (lambda (c.79 tmp.35 tmp.36)
                (let ()
                  (if (fixnum? tmp.36)
                    (if (fixnum? tmp.35) (unsafe-fx* tmp.35 tmp.36) (error 1))
                    (error 1)))))
             (L.error?.75.12 (lambda (c.80 tmp.63) (let () (error? tmp.63))))
             (L.unsafe-vector-set!.5.13
              (lambda (c.81 tmp.27 tmp.28 tmp.29)
                (let ()
                  (if (unsafe-fx< tmp.28 (unsafe-vector-length tmp.27))
                    (if (unsafe-fx>= tmp.28 0)
                      (begin (unsafe-vector-set! tmp.27 tmp.28 tmp.29) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.74.14
              (lambda (c.82 tmp.51 tmp.52 tmp.53)
                (let ((unsafe-vector-set!.5 (closure-ref c.82 0)))
                  (if (fixnum? tmp.52)
                    (if (vector? tmp.51)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.51
                       tmp.52
                       tmp.53)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.23.15
              (lambda (c.83 len.24 i.26 vec.25)
                (let ((vector-init-loop.23 (closure-ref c.83 0)))
                  (if (eq? len.24 i.26)
                    vec.25
                    (begin
                      (unsafe-vector-set! vec.25 i.26 0)
                      (closure-call
                       vector-init-loop.23
                       vector-init-loop.23
                       len.24
                       (unsafe-fx+ i.26 1)
                       vec.25))))))
             (L.make-init-vector.4.16
              (lambda (c.84 tmp.21)
                (let ((vector-init-loop.23 (closure-ref c.84 0)))
                  (let ((tmp.22 (unsafe-make-vector tmp.21)))
                    (closure-call
                     vector-init-loop.23
                     vector-init-loop.23
                     tmp.21
                     0
                     tmp.22)))))
             (L.make-vector.73.17
              (lambda (c.85 tmp.49)
                (let ((make-init-vector.4 (closure-ref c.85 0)))
                  (if (fixnum? tmp.49)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.49)
                    (error 8)))))
             (L.fun/vector8584.8.18
              (lambda (c.86)
                (let ((vector-set!.74 (closure-ref c.86 0))
                      (error?.75 (closure-ref c.86 1))
                      (make-vector.73 (closure-ref c.86 2)))
                  (let ((tmp.7.11
                         (closure-call make-vector.73 make-vector.73 8)))
                    (let ((g42848275.12
                           (closure-call
                            vector-set!.74
                            vector-set!.74
                            tmp.7.11
                            0
                            1)))
                      (if (closure-call error?.75 error?.75 g42848275.12)
                        g42848275.12
                        (let ((g42848276.13
                               (closure-call
                                vector-set!.74
                                vector-set!.74
                                tmp.7.11
                                1
                                2)))
                          (if (closure-call error?.75 error?.75 g42848276.13)
                            g42848276.13
                            (let ((g42848277.14
                                   (closure-call
                                    vector-set!.74
                                    vector-set!.74
                                    tmp.7.11
                                    2
                                    3)))
                              (if (closure-call
                                   error?.75
                                   error?.75
                                   g42848277.14)
                                g42848277.14
                                (let ((g42848278.15
                                       (closure-call
                                        vector-set!.74
                                        vector-set!.74
                                        tmp.7.11
                                        3
                                        4)))
                                  (if (closure-call
                                       error?.75
                                       error?.75
                                       g42848278.15)
                                    g42848278.15
                                    (let ((g42848279.16
                                           (closure-call
                                            vector-set!.74
                                            vector-set!.74
                                            tmp.7.11
                                            4
                                            5)))
                                      (if (closure-call
                                           error?.75
                                           error?.75
                                           g42848279.16)
                                        g42848279.16
                                        (let ((g42848280.17
                                               (closure-call
                                                vector-set!.74
                                                vector-set!.74
                                                tmp.7.11
                                                5
                                                6)))
                                          (if (closure-call
                                               error?.75
                                               error?.75
                                               g42848280.17)
                                            g42848280.17
                                            (let ((g42848281.18
                                                   (closure-call
                                                    vector-set!.74
                                                    vector-set!.74
                                                    tmp.7.11
                                                    6
                                                    7)))
                                              (if (closure-call
                                                   error?.75
                                                   error?.75
                                                   g42848281.18)
                                                g42848281.18
                                                (let ((g42848282.19
                                                       (closure-call
                                                        vector-set!.74
                                                        vector-set!.74
                                                        tmp.7.11
                                                        7
                                                        8)))
                                                  (if (closure-call
                                                       error?.75
                                                       error?.75
                                                       g42848282.19)
                                                    g42848282.19
                                                    tmp.7.11))))))))))))))))))))
             (L.fun/fixnum8582.9.19 (lambda (c.87) (let () 234)))
             (L.fun/fixnum8583.10.20
              (lambda (c.88 oprand0.20) (let () (if #f 70 77)))))
      (cletrec
       ((>=.77 (make-closure L.>=.77.10 2))
        (*.76 (make-closure L.*.76.11 2))
        (error?.75 (make-closure L.error?.75.12 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.13 3))
        (vector-set!.74
         (make-closure L.vector-set!.74.14 3 unsafe-vector-set!.5))
        (vector-init-loop.23
         (make-closure L.vector-init-loop.23.15 3 vector-init-loop.23))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.16 1 vector-init-loop.23))
        (make-vector.73
         (make-closure L.make-vector.73.17 1 make-init-vector.4))
        (fun/vector8584.8
         (make-closure
          L.fun/vector8584.8.18
          0
          vector-set!.74
          error?.75
          make-vector.73))
        (fun/fixnum8582.9 (make-closure L.fun/fixnum8582.9.19 0))
        (fun/fixnum8583.10 (make-closure L.fun/fixnum8583.10.20 1)))
       (closure-call
        >=.77
        >=.77
        (closure-call
         *.76
         *.76
         (let () 78)
         (closure-call fun/fixnum8582.9 fun/fixnum8582.9))
        (closure-call
         fun/fixnum8583.10
         fun/fixnum8583.10
         (closure-call fun/vector8584.8 fun/vector8584.8)))))))
(check-by-interp
 '(module
    (letrec ((L.error?.92.10 (lambda (c.93 tmp.82) (let () (error? tmp.82))))
             (L.fun/empty8588.19.11
              (lambda (c.94 oprand0.21) (let () (let () empty))))
             (L.fun/empty8587.20.12 (lambda (c.95) (let () empty))))
      (cletrec
       ((error?.92 (make-closure L.error?.92.10 1))
        (fun/empty8588.19 (make-closure L.fun/empty8588.19.11 1))
        (fun/empty8587.20 (make-closure L.fun/empty8587.20.12 0)))
       (let ((tmp.7.22 (if #f empty empty)))
         (if tmp.7.22
           tmp.7.22
           (let ((tmp.8.23 (if #f empty empty)))
             (if tmp.8.23
               tmp.8.23
               (let ((tmp.9.24 (let () empty)))
                 (if tmp.9.24
                   tmp.9.24
                   (let ((tmp.10.25 (if #f empty empty)))
                     (if tmp.10.25
                       tmp.10.25
                       (let ((tmp.11.26
                              (if (if #t empty empty)
                                (if (let ((fixnum0.27 114)) empty)
                                  (if (if #t empty empty)
                                    (if (let ((tmp.12.28 empty))
                                          (if tmp.12.28
                                            tmp.12.28
                                            (let ((tmp.13.29 empty))
                                              (if tmp.13.29
                                                tmp.13.29
                                                (let ((tmp.14.30 empty))
                                                  (if tmp.14.30
                                                    tmp.14.30
                                                    (let ((tmp.15.31 empty))
                                                      (if tmp.15.31
                                                        tmp.15.31
                                                        (let ((tmp.16.32
                                                               empty))
                                                          (if tmp.16.32
                                                            tmp.16.32
                                                            (let ((tmp.17.33
                                                                   empty))
                                                              (if tmp.17.33
                                                                tmp.17.33
                                                                empty))))))))))))
                                      (if (let () empty)
                                        (if (closure-call
                                             fun/empty8587.20
                                             fun/empty8587.20)
                                          (let ((fixnum0.34 110)) empty)
                                          #f)
                                        #f)
                                      #f)
                                    #f)
                                  #f)
                                #f)))
                         (if tmp.11.26
                           tmp.11.26
                           (let ((tmp.18.35 (let () empty)))
                             (if tmp.18.35
                               tmp.18.35
                               (closure-call
                                fun/empty8588.19
                                fun/empty8588.19
                                (let ((g42852100.36 203))
                                  (if (closure-call
                                       error?.92
                                       error?.92
                                       g42852100.36)
                                    g42852100.36
                                    (let ((g42852101.37 29))
                                      (if (closure-call
                                           error?.92
                                           error?.92
                                           g42852101.37)
                                        g42852101.37
                                        (let ((g42852102.38 74))
                                          (if (closure-call
                                               error?.92
                                               error?.92
                                               g42852102.38)
                                            g42852102.38
                                            (let ((g42852103.39 228))
                                              (if (closure-call
                                                   error?.92
                                                   error?.92
                                                   g42852103.39)
                                                g42852103.39
                                                185)))))))))))))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.error?.90.10 (lambda (c.91 tmp.79) (let () (error? tmp.79))))
             (L.cons.89.11
              (lambda (c.92 tmp.84 tmp.85) (let () (cons tmp.84 tmp.85))))
             (L.fun/empty8592.11.12
              (lambda (c.93) (let () (if #t empty empty))))
             (L.fun/empty8594.12.13
              (lambda (c.94 oprand0.16) (let () (if #f empty empty))))
             (L.fun/empty8593.13.14
              (lambda (c.95 oprand0.17) (let () (let () empty))))
             (L.fun/empty8591.14.15 (lambda (c.96 oprand0.18) (let () empty)))
             (L.fun/empty8595.15.16 (lambda (c.97) (let () empty))))
      (cletrec
       ((error?.90 (make-closure L.error?.90.10 1))
        (cons.89 (make-closure L.cons.89.11 2))
        (fun/empty8592.11 (make-closure L.fun/empty8592.11.12 0))
        (fun/empty8594.12 (make-closure L.fun/empty8594.12.13 1))
        (fun/empty8593.13 (make-closure L.fun/empty8593.13.14 1))
        (fun/empty8591.14 (make-closure L.fun/empty8591.14.15 1))
        (fun/empty8595.15 (make-closure L.fun/empty8595.15.16 0)))
       (let ((g42855921.19
              (let ((pair0.21
                     (closure-call
                      cons.89
                      cons.89
                      253
                      (closure-call cons.89 cons.89 358 empty)))
                    (pair1.20
                     (closure-call
                      cons.89
                      cons.89
                      169
                      (closure-call cons.89 cons.89 295 empty))))
                empty)))
         (if (closure-call error?.90 error?.90 g42855921.19)
           g42855921.19
           (let ((g42855922.22
                  (let ((tmp.7.23 (if #f empty empty)))
                    (if tmp.7.23
                      tmp.7.23
                      (let ((tmp.8.24 (if #f empty empty)))
                        (if tmp.8.24
                          tmp.8.24
                          (let ((tmp.9.25
                                 (let ((g42855923.26 empty))
                                   (if (closure-call
                                        error?.90
                                        error?.90
                                        g42855923.26)
                                     g42855923.26
                                     (let ((g42855924.27 empty))
                                       (if (closure-call
                                            error?.90
                                            error?.90
                                            g42855924.27)
                                         g42855924.27
                                         (let ((g42855925.28 empty))
                                           (if (closure-call
                                                error?.90
                                                error?.90
                                                g42855925.28)
                                             g42855925.28
                                             (let ((g42855926.29 empty))
                                               (if (closure-call
                                                    error?.90
                                                    error?.90
                                                    g42855926.29)
                                                 g42855926.29
                                                 (let ((g42855927.30 empty))
                                                   (if (closure-call
                                                        error?.90
                                                        error?.90
                                                        g42855927.30)
                                                     g42855927.30
                                                     empty))))))))))))
                            (if tmp.9.25
                              tmp.9.25
                              (let ((tmp.10.31 (let () empty)))
                                (if tmp.10.31
                                  tmp.10.31
                                  (closure-call
                                   fun/empty8591.14
                                   fun/empty8591.14
                                   139)))))))))))
             (if (closure-call error?.90 error?.90 g42855922.22)
               g42855922.22
               (let ((g42855928.32
                      (closure-call fun/empty8592.11 fun/empty8592.11)))
                 (if (closure-call error?.90 error?.90 g42855928.32)
                   g42855928.32
                   (let ((g42855929.33
                          (closure-call
                           fun/empty8593.13
                           fun/empty8593.13
                           (let ((pair0.34
                                  (closure-call
                                   cons.89
                                   cons.89
                                   112
                                   (closure-call cons.89 cons.89 452 empty))))
                             (error 248)))))
                     (if (closure-call error?.90 error?.90 g42855929.33)
                       g42855929.33
                       (let ((g42855930.35
                              (closure-call
                               fun/empty8594.12
                               fun/empty8594.12
                               (error 149))))
                         (if (closure-call error?.90 error?.90 g42855930.35)
                           g42855930.35
                           (let ((g42855931.36 (let () empty)))
                             (if (closure-call
                                  error?.90
                                  error?.90
                                  g42855931.36)
                               g42855931.36
                               (if (closure-call
                                    fun/empty8595.15
                                    fun/empty8595.15)
                                 (if #t empty empty)
                                 #f)))))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.error?.64.10 (lambda (c.65 tmp.54) (let () (error? tmp.54))))
             (L.fun/fixnum8598.7.11 (lambda (c.66) (let () 203)))
             (L.fun/fixnum8599.8.12 (lambda (c.67) (let () 64))))
      (cletrec
       ((error?.64 (make-closure L.error?.64.10 1))
        (fun/fixnum8598.7 (make-closure L.fun/fixnum8598.7.11 0))
        (fun/fixnum8599.8 (make-closure L.fun/fixnum8599.8.12 0)))
       (let ((g42859749.9 (closure-call fun/fixnum8598.7 fun/fixnum8598.7)))
         (if (closure-call error?.64 error?.64 g42859749.9)
           g42859749.9
           (let ((g42859750.10 (let () 107)))
             (if (closure-call error?.64 error?.64 g42859750.10)
               g42859750.10
               (let ((g42859751.11
                      (closure-call fun/fixnum8599.8 fun/fixnum8599.8)))
                 (if (closure-call error?.64 error?.64 g42859751.11)
                   g42859751.11
                   (if #t 192 15)))))))))))
(check-by-interp
 '(module
    (letrec ((L.cons.63.10
              (lambda (c.64 tmp.58 tmp.59) (let () (cons tmp.58 tmp.59))))
             (L.fun/fixnum8602.7.11
              (lambda (c.65 oprand0.10)
                (let ((fun/fixnum8603.9 (closure-ref c.65 0)))
                  (closure-call fun/fixnum8603.9 fun/fixnum8603.9))))
             (L.fun/fixnum8604.8.12 (lambda (c.66) (let () 49)))
             (L.fun/fixnum8603.9.13
              (lambda (c.67)
                (let ((fun/fixnum8604.8 (closure-ref c.67 0)))
                  (closure-call fun/fixnum8604.8 fun/fixnum8604.8)))))
      (cletrec
       ((cons.63 (make-closure L.cons.63.10 2))
        (fun/fixnum8602.7
         (make-closure L.fun/fixnum8602.7.11 1 fun/fixnum8603.9))
        (fun/fixnum8604.8 (make-closure L.fun/fixnum8604.8.12 0))
        (fun/fixnum8603.9
         (make-closure L.fun/fixnum8603.9.13 0 fun/fixnum8604.8)))
       (closure-call
        fun/fixnum8602.7
        fun/fixnum8602.7
        (if #t
          (closure-call
           cons.63
           cons.63
           141
           (closure-call cons.63 cons.63 350 empty))
          (closure-call
           cons.63
           cons.63
           232
           (closure-call cons.63 cons.63 266 empty))))))))
(check-by-interp
 '(module
    (letrec ((L.error?.81.10 (lambda (c.82 tmp.71) (let () (error? tmp.71))))
             (L.fun/error8609.14.11 (lambda (c.83) (let () (error 43))))
             (L.fun/error8608.15.12 (lambda (c.84) (let () (error 155))))
             (L.fun/error8607.16.13
              (lambda (c.85 oprand0.17) (let () oprand0.17))))
      (cletrec
       ((error?.81 (make-closure L.error?.81.10 1))
        (fun/error8609.14 (make-closure L.fun/error8609.14.11 0))
        (fun/error8608.15 (make-closure L.fun/error8608.15.12 0))
        (fun/error8607.16 (make-closure L.fun/error8607.16.13 1)))
       (let ((tmp.7.18
              (let ((tmp.8.19
                     (closure-call
                      fun/error8607.16
                      fun/error8607.16
                      (error 221))))
                (if tmp.8.19
                  tmp.8.19
                  (let ((tmp.9.20
                         (closure-call fun/error8608.15 fun/error8608.15)))
                    (if tmp.9.20
                      tmp.9.20
                      (let ((tmp.10.21
                             (if (error 37)
                               (if (error 42)
                                 (if (error 98)
                                   (if (error 1)
                                     (if (error 165) (error 150) #f)
                                     #f)
                                   #f)
                                 #f)
                               #f)))
                        (if tmp.10.21
                          tmp.10.21
                          (let ((tmp.11.22 (if #f (error 91) (error 43))))
                            (if tmp.11.22
                              tmp.11.22
                              (let ((tmp.12.23
                                     (let ((g42867385.24 (error 171)))
                                       (if (closure-call
                                            error?.81
                                            error?.81
                                            g42867385.24)
                                         g42867385.24
                                         (let ((g42867386.25 (error 153)))
                                           (if (closure-call
                                                error?.81
                                                error?.81
                                                g42867386.25)
                                             g42867386.25
                                             (let ((g42867387.26 (error 111)))
                                               (if (closure-call
                                                    error?.81
                                                    error?.81
                                                    g42867387.26)
                                                 g42867387.26
                                                 (let ((g42867388.27
                                                        (error 206)))
                                                   (if (closure-call
                                                        error?.81
                                                        error?.81
                                                        g42867388.27)
                                                     g42867388.27
                                                     (error 173)))))))))))
                                (if tmp.12.23
                                  tmp.12.23
                                  (closure-call
                                   fun/error8609.14
                                   fun/error8609.14)))))))))))))
         (if tmp.7.18
           tmp.7.18
           (let ((tmp.13.28 (if #t (error 249) (error 66))))
             (if tmp.13.28 tmp.13.28 (let () (error 165))))))))))
(check-by-interp
 '(module
    (letrec ((L.fun/fixnum8612.7.10
              (lambda (c.62)
                (let ((fun/fixnum8613.9 (closure-ref c.62 0)))
                  (closure-call fun/fixnum8613.9 fun/fixnum8613.9))))
             (L.fun/fixnum8614.8.11 (lambda (c.63) (let () 46)))
             (L.fun/fixnum8613.9.12
              (lambda (c.64)
                (let ((fun/fixnum8614.8 (closure-ref c.64 0)))
                  (closure-call fun/fixnum8614.8 fun/fixnum8614.8)))))
      (cletrec
       ((fun/fixnum8612.7
         (make-closure L.fun/fixnum8612.7.10 0 fun/fixnum8613.9))
        (fun/fixnum8614.8 (make-closure L.fun/fixnum8614.8.11 0))
        (fun/fixnum8613.9
         (make-closure L.fun/fixnum8613.9.12 0 fun/fixnum8614.8)))
       (closure-call fun/fixnum8612.7 fun/fixnum8612.7)))))
(check-by-interp '(module (if #f 144 165)))
(check-by-interp
 '(module
    (if (if #t #f #f)
      (if #t (void) (void))
      (let ((tmp.7.8 (void))) (if tmp.7.8 tmp.7.8 (void))))))
(check-by-interp
 '(module
    (if (if #f #t #t)
      (let ((tmp.7.8 #\[)) (if tmp.7.8 tmp.7.8 #\F))
      (if #f #\H #\B))))
(check-by-interp '(module (let () (if #t empty empty))))
(check-by-interp
 '(module
    (letrec ((L.error?.107.10 (lambda (c.110 tmp.95) (let () (error? tmp.95))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.111 tmp.59 tmp.60 tmp.61)
                (let ()
                  (if (unsafe-fx< tmp.60 (unsafe-vector-length tmp.59))
                    (if (unsafe-fx>= tmp.60 0)
                      (begin (unsafe-vector-set! tmp.59 tmp.60 tmp.61) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.106.12
              (lambda (c.112 tmp.83 tmp.84 tmp.85)
                (let ((unsafe-vector-set!.5 (closure-ref c.112 0)))
                  (if (fixnum? tmp.84)
                    (if (vector? tmp.83)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.83
                       tmp.84
                       tmp.85)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.55.13
              (lambda (c.113 len.56 i.58 vec.57)
                (let ((vector-init-loop.55 (closure-ref c.113 0)))
                  (if (eq? len.56 i.58)
                    vec.57
                    (begin
                      (unsafe-vector-set! vec.57 i.58 0)
                      (closure-call
                       vector-init-loop.55
                       vector-init-loop.55
                       len.56
                       (unsafe-fx+ i.58 1)
                       vec.57))))))
             (L.make-init-vector.4.14
              (lambda (c.114 tmp.53)
                (let ((vector-init-loop.55 (closure-ref c.114 0)))
                  (let ((tmp.54 (unsafe-make-vector tmp.53)))
                    (closure-call
                     vector-init-loop.55
                     vector-init-loop.55
                     tmp.53
                     0
                     tmp.54)))))
             (L.make-vector.105.15
              (lambda (c.115 tmp.81)
                (let ((make-init-vector.4 (closure-ref c.115 0)))
                  (if (fixnum? tmp.81)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.81)
                    (error 8)))))
             (L.fun/boolean8626.14.16 (lambda (c.116 oprand0.16) (let () #f)))
             (L.fun/boolean8625.15.17
              (lambda (c.117 oprand0.17) (let () (if #t #t #f)))))
      (cletrec
       ((error?.107 (make-closure L.error?.107.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.106
         (make-closure L.vector-set!.106.12 3 unsafe-vector-set!.5))
        (vector-init-loop.55
         (make-closure L.vector-init-loop.55.13 3 vector-init-loop.55))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.55))
        (make-vector.105
         (make-closure L.make-vector.105.15 1 make-init-vector.4))
        (fun/boolean8626.14 (make-closure L.fun/boolean8626.14.16 1))
        (fun/boolean8625.15 (make-closure L.fun/boolean8625.15.17 1)))
       (closure-call
        fun/boolean8625.15
        fun/boolean8625.15
        (let ((tmp.7.18 (if #f #f #f)))
          (if tmp.7.18
            tmp.7.18
            (let ((tmp.8.19 (if #f #f #t)))
              (if tmp.8.19
                tmp.8.19
                (let ((tmp.9.20
                       (closure-call
                        fun/boolean8626.14
                        fun/boolean8626.14
                        (let ((tmp.10.21
                               (closure-call
                                make-vector.105
                                make-vector.105
                                8)))
                          (let ((g42890275.22
                                 (closure-call
                                  vector-set!.106
                                  vector-set!.106
                                  tmp.10.21
                                  0
                                  0)))
                            (if (closure-call
                                 error?.107
                                 error?.107
                                 g42890275.22)
                              g42890275.22
                              (let ((g42890276.23
                                     (closure-call
                                      vector-set!.106
                                      vector-set!.106
                                      tmp.10.21
                                      1
                                      1)))
                                (if (closure-call
                                     error?.107
                                     error?.107
                                     g42890276.23)
                                  g42890276.23
                                  (let ((g42890277.24
                                         (closure-call
                                          vector-set!.106
                                          vector-set!.106
                                          tmp.10.21
                                          2
                                          2)))
                                    (if (closure-call
                                         error?.107
                                         error?.107
                                         g42890277.24)
                                      g42890277.24
                                      (let ((g42890278.25
                                             (closure-call
                                              vector-set!.106
                                              vector-set!.106
                                              tmp.10.21
                                              3
                                              3)))
                                        (if (closure-call
                                             error?.107
                                             error?.107
                                             g42890278.25)
                                          g42890278.25
                                          (let ((g42890279.26
                                                 (closure-call
                                                  vector-set!.106
                                                  vector-set!.106
                                                  tmp.10.21
                                                  4
                                                  4)))
                                            (if (closure-call
                                                 error?.107
                                                 error?.107
                                                 g42890279.26)
                                              g42890279.26
                                              (let ((g42890280.27
                                                     (closure-call
                                                      vector-set!.106
                                                      vector-set!.106
                                                      tmp.10.21
                                                      5
                                                      5)))
                                                (if (closure-call
                                                     error?.107
                                                     error?.107
                                                     g42890280.27)
                                                  g42890280.27
                                                  (let ((g42890281.28
                                                         (closure-call
                                                          vector-set!.106
                                                          vector-set!.106
                                                          tmp.10.21
                                                          6
                                                          6)))
                                                    (if (closure-call
                                                         error?.107
                                                         error?.107
                                                         g42890281.28)
                                                      g42890281.28
                                                      (let ((g42890282.29
                                                             (closure-call
                                                              vector-set!.106
                                                              vector-set!.106
                                                              tmp.10.21
                                                              7
                                                              7)))
                                                        (if (closure-call
                                                             error?.107
                                                             error?.107
                                                             g42890282.29)
                                                          g42890282.29
                                                          tmp.10.21))))))))))))))))))))
                  (if tmp.9.20
                    tmp.9.20
                    (let ((tmp.11.30
                           (let ((procedure0.32
                                  (letrec ((L.lam.108.18
                                            (lambda (c.118)
                                              (let ((vector-set!.106
                                                     (closure-ref c.118 0))
                                                    (error?.107
                                                     (closure-ref c.118 1))
                                                    (make-vector.105
                                                     (closure-ref c.118 2)))
                                                (let ((tmp.12.33
                                                       (closure-call
                                                        make-vector.105
                                                        make-vector.105
                                                        8)))
                                                  (let ((g42890283.34
                                                         (closure-call
                                                          vector-set!.106
                                                          vector-set!.106
                                                          tmp.12.33
                                                          0
                                                          0)))
                                                    (if (closure-call
                                                         error?.107
                                                         error?.107
                                                         g42890283.34)
                                                      g42890283.34
                                                      (let ((g42890284.35
                                                             (closure-call
                                                              vector-set!.106
                                                              vector-set!.106
                                                              tmp.12.33
                                                              1
                                                              1)))
                                                        (if (closure-call
                                                             error?.107
                                                             error?.107
                                                             g42890284.35)
                                                          g42890284.35
                                                          (let ((g42890285.36
                                                                 (closure-call
                                                                  vector-set!.106
                                                                  vector-set!.106
                                                                  tmp.12.33
                                                                  2
                                                                  2)))
                                                            (if (closure-call
                                                                 error?.107
                                                                 error?.107
                                                                 g42890285.36)
                                                              g42890285.36
                                                              (let ((g42890286.37
                                                                     (closure-call
                                                                      vector-set!.106
                                                                      vector-set!.106
                                                                      tmp.12.33
                                                                      3
                                                                      3)))
                                                                (if (closure-call
                                                                     error?.107
                                                                     error?.107
                                                                     g42890286.37)
                                                                  g42890286.37
                                                                  (let ((g42890287.38
                                                                         (closure-call
                                                                          vector-set!.106
                                                                          vector-set!.106
                                                                          tmp.12.33
                                                                          4
                                                                          4)))
                                                                    (if (closure-call
                                                                         error?.107
                                                                         error?.107
                                                                         g42890287.38)
                                                                      g42890287.38
                                                                      (let ((g42890288.39
                                                                             (closure-call
                                                                              vector-set!.106
                                                                              vector-set!.106
                                                                              tmp.12.33
                                                                              5
                                                                              5)))
                                                                        (if (closure-call
                                                                             error?.107
                                                                             error?.107
                                                                             g42890288.39)
                                                                          g42890288.39
                                                                          (let ((g42890289.40
                                                                                 (closure-call
                                                                                  vector-set!.106
                                                                                  vector-set!.106
                                                                                  tmp.12.33
                                                                                  6
                                                                                  6)))
                                                                            (if (closure-call
                                                                                 error?.107
                                                                                 error?.107
                                                                                 g42890289.40)
                                                                              g42890289.40
                                                                              (let ((g42890290.41
                                                                                     (closure-call
                                                                                      vector-set!.106
                                                                                      vector-set!.106
                                                                                      tmp.12.33
                                                                                      7
                                                                                      7)))
                                                                                (if (closure-call
                                                                                     error?.107
                                                                                     error?.107
                                                                                     g42890290.41)
                                                                                  g42890290.41
                                                                                  tmp.12.33)))))))))))))))))))))
                                    (cletrec
                                     ((lam.108
                                       (make-closure
                                        L.lam.108.18
                                        0
                                        vector-set!.106
                                        error?.107
                                        make-vector.105)))
                                     lam.108)))
                                 (vector1.31
                                  (closure-call
                                   make-vector.105
                                   make-vector.105
                                   8)))
                             #t)))
                      (if tmp.11.30
                        tmp.11.30
                        (let ((ascii-char0.43 #\B)
                              (procedure1.42
                               (letrec ((L.lam.109.19
                                         (lambda (c.119)
                                           (let ((vector-set!.106
                                                  (closure-ref c.119 0))
                                                 (error?.107
                                                  (closure-ref c.119 1))
                                                 (make-vector.105
                                                  (closure-ref c.119 2)))
                                             (let ((tmp.13.44
                                                    (closure-call
                                                     make-vector.105
                                                     make-vector.105
                                                     8)))
                                               (let ((g42890291.45
                                                      (closure-call
                                                       vector-set!.106
                                                       vector-set!.106
                                                       tmp.13.44
                                                       0
                                                       1)))
                                                 (if (closure-call
                                                      error?.107
                                                      error?.107
                                                      g42890291.45)
                                                   g42890291.45
                                                   (let ((g42890292.46
                                                          (closure-call
                                                           vector-set!.106
                                                           vector-set!.106
                                                           tmp.13.44
                                                           1
                                                           2)))
                                                     (if (closure-call
                                                          error?.107
                                                          error?.107
                                                          g42890292.46)
                                                       g42890292.46
                                                       (let ((g42890293.47
                                                              (closure-call
                                                               vector-set!.106
                                                               vector-set!.106
                                                               tmp.13.44
                                                               2
                                                               3)))
                                                         (if (closure-call
                                                              error?.107
                                                              error?.107
                                                              g42890293.47)
                                                           g42890293.47
                                                           (let ((g42890294.48
                                                                  (closure-call
                                                                   vector-set!.106
                                                                   vector-set!.106
                                                                   tmp.13.44
                                                                   3
                                                                   4)))
                                                             (if (closure-call
                                                                  error?.107
                                                                  error?.107
                                                                  g42890294.48)
                                                               g42890294.48
                                                               (let ((g42890295.49
                                                                      (closure-call
                                                                       vector-set!.106
                                                                       vector-set!.106
                                                                       tmp.13.44
                                                                       4
                                                                       5)))
                                                                 (if (closure-call
                                                                      error?.107
                                                                      error?.107
                                                                      g42890295.49)
                                                                   g42890295.49
                                                                   (let ((g42890296.50
                                                                          (closure-call
                                                                           vector-set!.106
                                                                           vector-set!.106
                                                                           tmp.13.44
                                                                           5
                                                                           6)))
                                                                     (if (closure-call
                                                                          error?.107
                                                                          error?.107
                                                                          g42890296.50)
                                                                       g42890296.50
                                                                       (let ((g42890297.51
                                                                              (closure-call
                                                                               vector-set!.106
                                                                               vector-set!.106
                                                                               tmp.13.44
                                                                               6
                                                                               7)))
                                                                         (if (closure-call
                                                                              error?.107
                                                                              error?.107
                                                                              g42890297.51)
                                                                           g42890297.51
                                                                           (let ((g42890298.52
                                                                                  (closure-call
                                                                                   vector-set!.106
                                                                                   vector-set!.106
                                                                                   tmp.13.44
                                                                                   7
                                                                                   8)))
                                                                             (if (closure-call
                                                                                  error?.107
                                                                                  error?.107
                                                                                  g42890298.52)
                                                                               g42890298.52
                                                                               tmp.13.44)))))))))))))))))))))
                                 (cletrec
                                  ((lam.109
                                    (make-closure
                                     L.lam.109.19
                                     0
                                     vector-set!.106
                                     error?.107
                                     make-vector.105)))
                                  lam.109))))
                          #t))))))))))))))
(check-by-interp '(module (let () (let ((void0.7 (void))) (void)))))
(check-by-interp
 '(module
    (letrec ((L.cons.62.10
              (lambda (c.63 tmp.57 tmp.58) (let () (cons tmp.57 tmp.58))))
             (L.fun/empty8631.7.11
              (lambda (c.64 oprand0.8) (let () (if #t empty empty)))))
      (cletrec
       ((cons.62 (make-closure L.cons.62.10 2))
        (fun/empty8631.7 (make-closure L.fun/empty8631.7.11 1)))
       (closure-call
        fun/empty8631.7
        fun/empty8631.7
        (let ((error0.9 (error 175)))
          (closure-call
           cons.62
           cons.62
           187
           (closure-call cons.62 cons.62 430 empty))))))))
(check-by-interp
 '(module
    (letrec ((L.fun/empty8634.7.10
              (lambda (c.60) (let () (if #t empty empty)))))
      (cletrec
       ((fun/empty8634.7 (make-closure L.fun/empty8634.7.10 0)))
       (closure-call fun/empty8634.7 fun/empty8634.7)))))
(check-by-interp
 '(module
    (letrec ((L.error?.76.10 (lambda (c.78 tmp.64) (let () (error? tmp.64))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.79 tmp.28 tmp.29 tmp.30)
                (let ()
                  (if (unsafe-fx< tmp.29 (unsafe-vector-length tmp.28))
                    (if (unsafe-fx>= tmp.29 0)
                      (begin (unsafe-vector-set! tmp.28 tmp.29 tmp.30) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.75.12
              (lambda (c.80 tmp.52 tmp.53 tmp.54)
                (let ((unsafe-vector-set!.5 (closure-ref c.80 0)))
                  (if (fixnum? tmp.53)
                    (if (vector? tmp.52)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.52
                       tmp.53
                       tmp.54)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.24.13
              (lambda (c.81 len.25 i.27 vec.26)
                (let ((vector-init-loop.24 (closure-ref c.81 0)))
                  (if (eq? len.25 i.27)
                    vec.26
                    (begin
                      (unsafe-vector-set! vec.26 i.27 0)
                      (closure-call
                       vector-init-loop.24
                       vector-init-loop.24
                       len.25
                       (unsafe-fx+ i.27 1)
                       vec.26))))))
             (L.make-init-vector.4.14
              (lambda (c.82 tmp.22)
                (let ((vector-init-loop.24 (closure-ref c.82 0)))
                  (let ((tmp.23 (unsafe-make-vector tmp.22)))
                    (closure-call
                     vector-init-loop.24
                     vector-init-loop.24
                     tmp.22
                     0
                     tmp.23)))))
             (L.make-vector.74.15
              (lambda (c.83 tmp.50)
                (let ((make-init-vector.4 (closure-ref c.83 0)))
                  (if (fixnum? tmp.50)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.50)
                    (error 8)))))
             (L.fun/vector8638.8.16
              (lambda (c.84)
                (let ((vector-set!.75 (closure-ref c.84 0))
                      (error?.76 (closure-ref c.84 1))
                      (make-vector.74 (closure-ref c.84 2)))
                  (let ((tmp.7.11
                         (closure-call make-vector.74 make-vector.74 8)))
                    (let ((g42905563.12
                           (closure-call
                            vector-set!.75
                            vector-set!.75
                            tmp.7.11
                            0
                            0)))
                      (if (closure-call error?.76 error?.76 g42905563.12)
                        g42905563.12
                        (let ((g42905564.13
                               (closure-call
                                vector-set!.75
                                vector-set!.75
                                tmp.7.11
                                1
                                1)))
                          (if (closure-call error?.76 error?.76 g42905564.13)
                            g42905564.13
                            (let ((g42905565.14
                                   (closure-call
                                    vector-set!.75
                                    vector-set!.75
                                    tmp.7.11
                                    2
                                    2)))
                              (if (closure-call
                                   error?.76
                                   error?.76
                                   g42905565.14)
                                g42905565.14
                                (let ((g42905566.15
                                       (closure-call
                                        vector-set!.75
                                        vector-set!.75
                                        tmp.7.11
                                        3
                                        3)))
                                  (if (closure-call
                                       error?.76
                                       error?.76
                                       g42905566.15)
                                    g42905566.15
                                    (let ((g42905567.16
                                           (closure-call
                                            vector-set!.75
                                            vector-set!.75
                                            tmp.7.11
                                            4
                                            4)))
                                      (if (closure-call
                                           error?.76
                                           error?.76
                                           g42905567.16)
                                        g42905567.16
                                        (let ((g42905568.17
                                               (closure-call
                                                vector-set!.75
                                                vector-set!.75
                                                tmp.7.11
                                                5
                                                5)))
                                          (if (closure-call
                                               error?.76
                                               error?.76
                                               g42905568.17)
                                            g42905568.17
                                            (let ((g42905569.18
                                                   (closure-call
                                                    vector-set!.75
                                                    vector-set!.75
                                                    tmp.7.11
                                                    6
                                                    6)))
                                              (if (closure-call
                                                   error?.76
                                                   error?.76
                                                   g42905569.18)
                                                g42905569.18
                                                (let ((g42905570.19
                                                       (closure-call
                                                        vector-set!.75
                                                        vector-set!.75
                                                        tmp.7.11
                                                        7
                                                        7)))
                                                  (if (closure-call
                                                       error?.76
                                                       error?.76
                                                       g42905570.19)
                                                    g42905570.19
                                                    tmp.7.11))))))))))))))))))))
             (L.fun/void8637.9.17 (lambda (c.85) (let () (void))))
             (L.fun/fixnum8639.10.18 (lambda (c.86) (let () 23))))
      (cletrec
       ((error?.76 (make-closure L.error?.76.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.75
         (make-closure L.vector-set!.75.12 3 unsafe-vector-set!.5))
        (vector-init-loop.24
         (make-closure L.vector-init-loop.24.13 3 vector-init-loop.24))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.24))
        (make-vector.74
         (make-closure L.make-vector.74.15 1 make-init-vector.4))
        (fun/vector8638.8
         (make-closure
          L.fun/vector8638.8.16
          0
          vector-set!.75
          error?.76
          make-vector.74))
        (fun/void8637.9 (make-closure L.fun/void8637.9.17 0))
        (fun/fixnum8639.10 (make-closure L.fun/fixnum8639.10.18 0)))
       (let ((void0.21 (closure-call fun/void8637.9 fun/void8637.9))
             (procedure1.20
              (letrec ((L.lam.77.19
                        (lambda (c.87)
                          (let ((fun/vector8638.8 (closure-ref c.87 0)))
                            (closure-call
                             fun/vector8638.8
                             fun/vector8638.8)))))
                (cletrec
                 ((lam.77 (make-closure L.lam.77.19 0 fun/vector8638.8)))
                 lam.77))))
         (closure-call fun/fixnum8639.10 fun/fixnum8639.10))))))
(check-by-interp
 '(module
    (letrec ((L.fun/fixnum8642.7.10 (lambda (c.60) (let () 171))))
      (cletrec
       ((fun/fixnum8642.7 (make-closure L.fun/fixnum8642.7.10 0)))
       (if (let () #f)
         (if #f 157 104)
         (closure-call fun/fixnum8642.7 fun/fixnum8642.7))))))
(check-by-interp
 '(module
    (letrec ((L.error?.73.10 (lambda (c.75 tmp.61) (let () (error? tmp.61))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.76 tmp.25 tmp.26 tmp.27)
                (let ()
                  (if (unsafe-fx< tmp.26 (unsafe-vector-length tmp.25))
                    (if (unsafe-fx>= tmp.26 0)
                      (begin (unsafe-vector-set! tmp.25 tmp.26 tmp.27) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.72.12
              (lambda (c.77 tmp.49 tmp.50 tmp.51)
                (let ((unsafe-vector-set!.5 (closure-ref c.77 0)))
                  (if (fixnum? tmp.50)
                    (if (vector? tmp.49)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.49
                       tmp.50
                       tmp.51)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.21.13
              (lambda (c.78 len.22 i.24 vec.23)
                (let ((vector-init-loop.21 (closure-ref c.78 0)))
                  (if (eq? len.22 i.24)
                    vec.23
                    (begin
                      (unsafe-vector-set! vec.23 i.24 0)
                      (closure-call
                       vector-init-loop.21
                       vector-init-loop.21
                       len.22
                       (unsafe-fx+ i.24 1)
                       vec.23))))))
             (L.make-init-vector.4.14
              (lambda (c.79 tmp.19)
                (let ((vector-init-loop.21 (closure-ref c.79 0)))
                  (let ((tmp.20 (unsafe-make-vector tmp.19)))
                    (closure-call
                     vector-init-loop.21
                     vector-init-loop.21
                     tmp.19
                     0
                     tmp.20)))))
             (L.make-vector.71.15
              (lambda (c.80 tmp.47)
                (let ((make-init-vector.4 (closure-ref c.80 0)))
                  (if (fixnum? tmp.47)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.47)
                    (error 8))))))
      (cletrec
       ((error?.73 (make-closure L.error?.73.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.72
         (make-closure L.vector-set!.72.12 3 unsafe-vector-set!.5))
        (vector-init-loop.21
         (make-closure L.vector-init-loop.21.13 3 vector-init-loop.21))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.21))
        (make-vector.71
         (make-closure L.make-vector.71.15 1 make-init-vector.4)))
       (let ((vector0.8
              (let ((tmp.7.9 (closure-call make-vector.71 make-vector.71 8)))
                (let ((g42913205.10
                       (closure-call
                        vector-set!.72
                        vector-set!.72
                        tmp.7.9
                        0
                        112)))
                  (if (closure-call error?.73 error?.73 g42913205.10)
                    g42913205.10
                    (let ((g42913206.11
                           (closure-call
                            vector-set!.72
                            vector-set!.72
                            tmp.7.9
                            1
                            (letrec ((L.lam.74.16
                                      (lambda (c.81) (let () 928))))
                              (cletrec
                               ((lam.74 (make-closure L.lam.74.16 0)))
                               lam.74)))))
                      (if (closure-call error?.73 error?.73 g42913206.11)
                        g42913206.11
                        (let ((g42913207.12
                               (closure-call
                                vector-set!.72
                                vector-set!.72
                                tmp.7.9
                                2
                                empty)))
                          (if (closure-call error?.73 error?.73 g42913207.12)
                            g42913207.12
                            (let ((g42913208.13
                                   (closure-call
                                    vector-set!.72
                                    vector-set!.72
                                    tmp.7.9
                                    3
                                    #f)))
                              (if (closure-call
                                   error?.73
                                   error?.73
                                   g42913208.13)
                                g42913208.13
                                (let ((g42913209.14
                                       (closure-call
                                        vector-set!.72
                                        vector-set!.72
                                        tmp.7.9
                                        4
                                        (void))))
                                  (if (closure-call
                                       error?.73
                                       error?.73
                                       g42913209.14)
                                    g42913209.14
                                    (let ((g42913210.15
                                           (closure-call
                                            vector-set!.72
                                            vector-set!.72
                                            tmp.7.9
                                            5
                                            #\t)))
                                      (if (closure-call
                                           error?.73
                                           error?.73
                                           g42913210.15)
                                        g42913210.15
                                        (let ((g42913211.16
                                               (closure-call
                                                vector-set!.72
                                                vector-set!.72
                                                tmp.7.9
                                                6
                                                empty)))
                                          (if (closure-call
                                               error?.73
                                               error?.73
                                               g42913211.16)
                                            g42913211.16
                                            (let ((g42913212.17
                                                   (closure-call
                                                    vector-set!.72
                                                    vector-set!.72
                                                    tmp.7.9
                                                    7
                                                    empty)))
                                              (if (closure-call
                                                   error?.73
                                                   error?.73
                                                   g42913212.17)
                                                g42913212.17
                                                tmp.7.9)))))))))))))))))))
         (let ((ascii-char0.18 #\P)) (void)))))))
(check-by-interp
 '(module
    (letrec ((L.error?.92.10 (lambda (c.96 tmp.80) (let () (error? tmp.80))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.97 tmp.44 tmp.45 tmp.46)
                (let ()
                  (if (unsafe-fx< tmp.45 (unsafe-vector-length tmp.44))
                    (if (unsafe-fx>= tmp.45 0)
                      (begin (unsafe-vector-set! tmp.44 tmp.45 tmp.46) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.91.12
              (lambda (c.98 tmp.68 tmp.69 tmp.70)
                (let ((unsafe-vector-set!.5 (closure-ref c.98 0)))
                  (if (fixnum? tmp.69)
                    (if (vector? tmp.68)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.68
                       tmp.69
                       tmp.70)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.40.13
              (lambda (c.99 len.41 i.43 vec.42)
                (let ((vector-init-loop.40 (closure-ref c.99 0)))
                  (if (eq? len.41 i.43)
                    vec.42
                    (begin
                      (unsafe-vector-set! vec.42 i.43 0)
                      (closure-call
                       vector-init-loop.40
                       vector-init-loop.40
                       len.41
                       (unsafe-fx+ i.43 1)
                       vec.42))))))
             (L.make-init-vector.4.14
              (lambda (c.100 tmp.38)
                (let ((vector-init-loop.40 (closure-ref c.100 0)))
                  (let ((tmp.39 (unsafe-make-vector tmp.38)))
                    (closure-call
                     vector-init-loop.40
                     vector-init-loop.40
                     tmp.38
                     0
                     tmp.39)))))
             (L.make-vector.90.15
              (lambda (c.101 tmp.66)
                (let ((make-init-vector.4 (closure-ref c.101 0)))
                  (if (fixnum? tmp.66)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.66)
                    (error 8)))))
             (L.fun/ascii-char8647.14.16
              (lambda (c.102)
                (let ((make-vector.90 (closure-ref c.102 0))
                      (error?.92 (closure-ref c.102 1))
                      (vector-set!.91 (closure-ref c.102 2)))
                  (let ((vector0.16
                         (let ((tmp.7.17
                                (closure-call
                                 make-vector.90
                                 make-vector.90
                                 8)))
                           (let ((g42917032.18
                                  (closure-call
                                   vector-set!.91
                                   vector-set!.91
                                   tmp.7.17
                                   0
                                   0)))
                             (if (closure-call
                                  error?.92
                                  error?.92
                                  g42917032.18)
                               g42917032.18
                               (let ((g42917033.19
                                      (closure-call
                                       vector-set!.91
                                       vector-set!.91
                                       tmp.7.17
                                       1
                                       1)))
                                 (if (closure-call
                                      error?.92
                                      error?.92
                                      g42917033.19)
                                   g42917033.19
                                   (let ((g42917034.20
                                          (closure-call
                                           vector-set!.91
                                           vector-set!.91
                                           tmp.7.17
                                           2
                                           2)))
                                     (if (closure-call
                                          error?.92
                                          error?.92
                                          g42917034.20)
                                       g42917034.20
                                       (let ((g42917035.21
                                              (closure-call
                                               vector-set!.91
                                               vector-set!.91
                                               tmp.7.17
                                               3
                                               3)))
                                         (if (closure-call
                                              error?.92
                                              error?.92
                                              g42917035.21)
                                           g42917035.21
                                           (let ((g42917036.22
                                                  (closure-call
                                                   vector-set!.91
                                                   vector-set!.91
                                                   tmp.7.17
                                                   4
                                                   4)))
                                             (if (closure-call
                                                  error?.92
                                                  error?.92
                                                  g42917036.22)
                                               g42917036.22
                                               (let ((g42917037.23
                                                      (closure-call
                                                       vector-set!.91
                                                       vector-set!.91
                                                       tmp.7.17
                                                       5
                                                       5)))
                                                 (if (closure-call
                                                      error?.92
                                                      error?.92
                                                      g42917037.23)
                                                   g42917037.23
                                                   (let ((g42917038.24
                                                          (closure-call
                                                           vector-set!.91
                                                           vector-set!.91
                                                           tmp.7.17
                                                           6
                                                           6)))
                                                     (if (closure-call
                                                          error?.92
                                                          error?.92
                                                          g42917038.24)
                                                       g42917038.24
                                                       (let ((g42917039.25
                                                              (closure-call
                                                               vector-set!.91
                                                               vector-set!.91
                                                               tmp.7.17
                                                               7
                                                               7)))
                                                         (if (closure-call
                                                              error?.92
                                                              error?.92
                                                              g42917039.25)
                                                           g42917039.25
                                                           tmp.7.17)))))))))))))))))))
                    #\]))))
             (L.fun/ascii-char8648.15.17
              (lambda (c.103 oprand0.26) (let () #\u))))
      (cletrec
       ((error?.92 (make-closure L.error?.92.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.91
         (make-closure L.vector-set!.91.12 3 unsafe-vector-set!.5))
        (vector-init-loop.40
         (make-closure L.vector-init-loop.40.13 3 vector-init-loop.40))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.40))
        (make-vector.90
         (make-closure L.make-vector.90.15 1 make-init-vector.4))
        (fun/ascii-char8647.14
         (make-closure
          L.fun/ascii-char8647.14.16
          0
          make-vector.90
          error?.92
          vector-set!.91))
        (fun/ascii-char8648.15 (make-closure L.fun/ascii-char8648.15.17 1)))
       (let ((tmp.8.27
              (closure-call fun/ascii-char8647.14 fun/ascii-char8647.14)))
         (if tmp.8.27
           tmp.8.27
           (let ((tmp.9.28
                  (let ((procedure0.29
                         (letrec ((L.lam.93.18
                                   (lambda (c.104)
                                     (let ()
                                       (letrec ((L.lam.94.19
                                                 (lambda (c.105)
                                                   (let () 813))))
                                         (cletrec
                                          ((lam.94
                                            (make-closure L.lam.94.19 0)))
                                          lam.94))))))
                           (cletrec
                            ((lam.93 (make-closure L.lam.93.18 0)))
                            lam.93))))
                    #\r)))
             (if tmp.9.28
               tmp.9.28
               (let ((tmp.10.30
                      (let ((tmp.11.31
                             (closure-call
                              fun/ascii-char8648.15
                              fun/ascii-char8648.15
                              220)))
                        (if tmp.11.31
                          tmp.11.31
                          (let ((tmp.12.32
                                 (let ((procedure0.34
                                        (letrec ((L.lam.95.20
                                                  (lambda (c.106)
                                                    (let () (error 180)))))
                                          (cletrec
                                           ((lam.95
                                             (make-closure L.lam.95.20 0)))
                                           lam.95)))
                                       (error1.33 (error 170)))
                                   #\C)))
                            (if tmp.12.32
                              tmp.12.32
                              (let ((g42917040.35 #\\))
                                (if (closure-call
                                     error?.92
                                     error?.92
                                     g42917040.35)
                                  g42917040.35
                                  #\^))))))))
                 (if tmp.10.30
                   tmp.10.30
                   (let ((tmp.13.36 (let ((error0.37 (error 253))) #\R)))
                     (if tmp.13.36 tmp.13.36 (if #f #\K #\m)))))))))))))
(check-by-interp
 '(module
    (letrec ((L.error?.83.10 (lambda (c.84 tmp.71) (let () (error? tmp.71))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.85 tmp.35 tmp.36 tmp.37)
                (let ()
                  (if (unsafe-fx< tmp.36 (unsafe-vector-length tmp.35))
                    (if (unsafe-fx>= tmp.36 0)
                      (begin (unsafe-vector-set! tmp.35 tmp.36 tmp.37) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.82.12
              (lambda (c.86 tmp.59 tmp.60 tmp.61)
                (let ((unsafe-vector-set!.5 (closure-ref c.86 0)))
                  (if (fixnum? tmp.60)
                    (if (vector? tmp.59)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.59
                       tmp.60
                       tmp.61)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.31.13
              (lambda (c.87 len.32 i.34 vec.33)
                (let ((vector-init-loop.31 (closure-ref c.87 0)))
                  (if (eq? len.32 i.34)
                    vec.33
                    (begin
                      (unsafe-vector-set! vec.33 i.34 0)
                      (closure-call
                       vector-init-loop.31
                       vector-init-loop.31
                       len.32
                       (unsafe-fx+ i.34 1)
                       vec.33))))))
             (L.make-init-vector.4.14
              (lambda (c.88 tmp.29)
                (let ((vector-init-loop.31 (closure-ref c.88 0)))
                  (let ((tmp.30 (unsafe-make-vector tmp.29)))
                    (closure-call
                     vector-init-loop.31
                     vector-init-loop.31
                     tmp.29
                     0
                     tmp.30)))))
             (L.make-vector.81.15
              (lambda (c.89 tmp.57)
                (let ((make-init-vector.4 (closure-ref c.89 0)))
                  (if (fixnum? tmp.57)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.57)
                    (error 8)))))
             (L.fun/void8651.9.16 (lambda (c.90) (let () (void)))))
      (cletrec
       ((error?.83 (make-closure L.error?.83.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.82
         (make-closure L.vector-set!.82.12 3 unsafe-vector-set!.5))
        (vector-init-loop.31
         (make-closure L.vector-init-loop.31.13 3 vector-init-loop.31))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.31))
        (make-vector.81
         (make-closure L.make-vector.81.15 1 make-init-vector.4))
        (fun/void8651.9 (make-closure L.fun/void8651.9.16 0)))
       (let ((vector0.10
              (let ((tmp.7.11 (closure-call make-vector.81 make-vector.81 8)))
                (let ((g42920858.12
                       (closure-call
                        vector-set!.82
                        vector-set!.82
                        tmp.7.11
                        0
                        empty)))
                  (if (closure-call error?.83 error?.83 g42920858.12)
                    g42920858.12
                    (let ((g42920859.13
                           (closure-call
                            vector-set!.82
                            vector-set!.82
                            tmp.7.11
                            1
                            (let ((tmp.8.14
                                   (closure-call
                                    make-vector.81
                                    make-vector.81
                                    8)))
                              (let ((g42920860.15
                                     (closure-call
                                      vector-set!.82
                                      vector-set!.82
                                      tmp.8.14
                                      0
                                      1)))
                                (if (closure-call
                                     error?.83
                                     error?.83
                                     g42920860.15)
                                  g42920860.15
                                  (let ((g42920861.16
                                         (closure-call
                                          vector-set!.82
                                          vector-set!.82
                                          tmp.8.14
                                          1
                                          2)))
                                    (if (closure-call
                                         error?.83
                                         error?.83
                                         g42920861.16)
                                      g42920861.16
                                      (let ((g42920862.17
                                             (closure-call
                                              vector-set!.82
                                              vector-set!.82
                                              tmp.8.14
                                              2
                                              3)))
                                        (if (closure-call
                                             error?.83
                                             error?.83
                                             g42920862.17)
                                          g42920862.17
                                          (let ((g42920863.18
                                                 (closure-call
                                                  vector-set!.82
                                                  vector-set!.82
                                                  tmp.8.14
                                                  3
                                                  4)))
                                            (if (closure-call
                                                 error?.83
                                                 error?.83
                                                 g42920863.18)
                                              g42920863.18
                                              (let ((g42920864.19
                                                     (closure-call
                                                      vector-set!.82
                                                      vector-set!.82
                                                      tmp.8.14
                                                      4
                                                      5)))
                                                (if (closure-call
                                                     error?.83
                                                     error?.83
                                                     g42920864.19)
                                                  g42920864.19
                                                  (let ((g42920865.20
                                                         (closure-call
                                                          vector-set!.82
                                                          vector-set!.82
                                                          tmp.8.14
                                                          5
                                                          6)))
                                                    (if (closure-call
                                                         error?.83
                                                         error?.83
                                                         g42920865.20)
                                                      g42920865.20
                                                      (let ((g42920866.21
                                                             (closure-call
                                                              vector-set!.82
                                                              vector-set!.82
                                                              tmp.8.14
                                                              6
                                                              7)))
                                                        (if (closure-call
                                                             error?.83
                                                             error?.83
                                                             g42920866.21)
                                                          g42920866.21
                                                          (let ((g42920867.22
                                                                 (closure-call
                                                                  vector-set!.82
                                                                  vector-set!.82
                                                                  tmp.8.14
                                                                  7
                                                                  8)))
                                                            (if (closure-call
                                                                 error?.83
                                                                 error?.83
                                                                 g42920867.22)
                                                              g42920867.22
                                                              tmp.8.14))))))))))))))))))))
                      (if (closure-call error?.83 error?.83 g42920859.13)
                        g42920859.13
                        (let ((g42920868.23
                               (closure-call
                                vector-set!.82
                                vector-set!.82
                                tmp.7.11
                                2
                                (void))))
                          (if (closure-call error?.83 error?.83 g42920868.23)
                            g42920868.23
                            (let ((g42920869.24
                                   (closure-call
                                    vector-set!.82
                                    vector-set!.82
                                    tmp.7.11
                                    3
                                    (error 187))))
                              (if (closure-call
                                   error?.83
                                   error?.83
                                   g42920869.24)
                                g42920869.24
                                (let ((g42920870.25
                                       (closure-call
                                        vector-set!.82
                                        vector-set!.82
                                        tmp.7.11
                                        4
                                        #t)))
                                  (if (closure-call
                                       error?.83
                                       error?.83
                                       g42920870.25)
                                    g42920870.25
                                    (let ((g42920871.26
                                           (closure-call
                                            vector-set!.82
                                            vector-set!.82
                                            tmp.7.11
                                            5
                                            (error 0))))
                                      (if (closure-call
                                           error?.83
                                           error?.83
                                           g42920871.26)
                                        g42920871.26
                                        (let ((g42920872.27
                                               (closure-call
                                                vector-set!.82
                                                vector-set!.82
                                                tmp.7.11
                                                6
                                                #\A)))
                                          (if (closure-call
                                               error?.83
                                               error?.83
                                               g42920872.27)
                                            g42920872.27
                                            (let ((g42920873.28
                                                   (closure-call
                                                    vector-set!.82
                                                    vector-set!.82
                                                    tmp.7.11
                                                    7
                                                    110)))
                                              (if (closure-call
                                                   error?.83
                                                   error?.83
                                                   g42920873.28)
                                                g42920873.28
                                                tmp.7.11)))))))))))))))))))
         (closure-call fun/void8651.9 fun/void8651.9))))))
(check-by-interp
 '(module
    (letrec ((L.fun/void8654.7.10
              (lambda (c.65 oprand0.8) (let () (if #f (void) (void))))))
      (cletrec
       ((fun/void8654.7 (make-closure L.fun/void8654.7.10 1)))
       (closure-call
        fun/void8654.7
        fun/void8654.7
        (let ((procedure0.9
               (letrec ((L.lam.63.11 (lambda (c.66 oprand0.10) (let () #t))))
                 (cletrec ((lam.63 (make-closure L.lam.63.11 1))) lam.63))))
          (letrec ((L.lam.64.12 (lambda (c.67) (let () 908))))
            (cletrec ((lam.64 (make-closure L.lam.64.12 0))) lam.64))))))))
(check-by-interp
 '(module
    (letrec ((L.fun/ascii-char8657.7.10
              (lambda (c.61 oprand0.8) (let () #\^))))
      (cletrec
       ((fun/ascii-char8657.7 (make-closure L.fun/ascii-char8657.7.10 1)))
       (let ()
         (closure-call fun/ascii-char8657.7 fun/ascii-char8657.7 (void)))))))
(check-by-interp
 '(module
    (letrec ((L.fun/fixnum8661.7.10 (lambda (c.63) (let () 122)))
             (L.fun/empty8660.8.11 (lambda (c.64) (let () empty))))
      (cletrec
       ((fun/fixnum8661.7 (make-closure L.fun/fixnum8661.7.10 0))
        (fun/empty8660.8 (make-closure L.fun/empty8660.8.11 0)))
       (let ((empty0.10 (closure-call fun/empty8660.8 fun/empty8660.8))
             (boolean1.9 #f))
         (closure-call fun/fixnum8661.7 fun/fixnum8661.7))))))
(check-by-interp
 '(module
    (letrec ((L.cons.66.10
              (lambda (c.67 tmp.60 tmp.61) (let () (cons tmp.60 tmp.61))))
             (L.error?.65.11 (lambda (c.68 tmp.55) (let () (error? tmp.55))))
             (L.fun/fixnum8664.7.12 (lambda (c.69 oprand0.8) (let () 40))))
      (cletrec
       ((cons.66 (make-closure L.cons.66.10 2))
        (error?.65 (make-closure L.error?.65.11 1))
        (fun/fixnum8664.7 (make-closure L.fun/fixnum8664.7.12 1)))
       (if (if #t 75 131)
         (if (let ((g42936134.9 219))
               (if (closure-call error?.65 error?.65 g42936134.9)
                 g42936134.9
                 (let ((g42936135.10 29))
                   (if (closure-call error?.65 error?.65 g42936135.10)
                     g42936135.10
                     (let ((g42936136.11 199))
                       (if (closure-call error?.65 error?.65 g42936136.11)
                         g42936136.11
                         (let ((g42936137.12 203))
                           (if (closure-call error?.65 error?.65 g42936137.12)
                             g42936137.12
                             163))))))))
           (closure-call
            fun/fixnum8664.7
            fun/fixnum8664.7
            (closure-call
             cons.66
             cons.66
             205
             (closure-call cons.66 cons.66 453 empty)))
           #f)
         #f)))))
(check-by-interp
 '(module
    (letrec ((L.fun/error8667.7.10
              (lambda (c.61 oprand0.8)
                (let () (if #t (error 243) (error 182))))))
      (cletrec
       ((fun/error8667.7 (make-closure L.fun/error8667.7.10 1)))
       (closure-call fun/error8667.7 fun/error8667.7 (if #f #\k #\l))))))
(check-by-interp
 '(module
    (letrec ((L.error?.66.10 (lambda (c.67 tmp.56) (let () (error? tmp.56))))
             (L.fun/empty8670.9.11 (lambda (c.68) (let () empty)))
             (L.fun/empty8671.10.12
              (lambda (c.69) (let () (if #f empty empty)))))
      (cletrec
       ((error?.66 (make-closure L.error?.66.10 1))
        (fun/empty8670.9 (make-closure L.fun/empty8670.9.11 0))
        (fun/empty8671.10 (make-closure L.fun/empty8671.10.12 0)))
       (let ((g42943766.11
              (let ((tmp.7.12 (closure-call fun/empty8670.9 fun/empty8670.9)))
                (if tmp.7.12
                  tmp.7.12
                  (let ((tmp.8.13 (if #f empty empty)))
                    (if tmp.8.13 tmp.8.13 empty))))))
         (if (closure-call error?.66 error?.66 g42943766.11)
           g42943766.11
           (closure-call fun/empty8671.10 fun/empty8671.10)))))))
(check-by-interp
 '(module
    (letrec ((L.fun/void8674.7.10 (lambda (c.60) (let () (void)))))
      (cletrec
       ((fun/void8674.7 (make-closure L.fun/void8674.7.10 0)))
       (let () (closure-call fun/void8674.7 fun/void8674.7))))))
(check-by-interp
 '(module
    (letrec ((L.error?.78.10 (lambda (c.82 tmp.64) (let () (error? tmp.64))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.83 tmp.28 tmp.29 tmp.30)
                (let ()
                  (if (unsafe-fx< tmp.29 (unsafe-vector-length tmp.28))
                    (if (unsafe-fx>= tmp.29 0)
                      (begin (unsafe-vector-set! tmp.28 tmp.29 tmp.30) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.77.12
              (lambda (c.84 tmp.52 tmp.53 tmp.54)
                (let ((unsafe-vector-set!.5 (closure-ref c.84 0)))
                  (if (fixnum? tmp.53)
                    (if (vector? tmp.52)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.52
                       tmp.53
                       tmp.54)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.24.13
              (lambda (c.85 len.25 i.27 vec.26)
                (let ((vector-init-loop.24 (closure-ref c.85 0)))
                  (if (eq? len.25 i.27)
                    vec.26
                    (begin
                      (unsafe-vector-set! vec.26 i.27 0)
                      (closure-call
                       vector-init-loop.24
                       vector-init-loop.24
                       len.25
                       (unsafe-fx+ i.27 1)
                       vec.26))))))
             (L.make-init-vector.4.14
              (lambda (c.86 tmp.22)
                (let ((vector-init-loop.24 (closure-ref c.86 0)))
                  (let ((tmp.23 (unsafe-make-vector tmp.22)))
                    (closure-call
                     vector-init-loop.24
                     vector-init-loop.24
                     tmp.22
                     0
                     tmp.23)))))
             (L.make-vector.76.15
              (lambda (c.87 tmp.50)
                (let ((make-init-vector.4 (closure-ref c.87 0)))
                  (if (fixnum? tmp.50)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.50)
                    (error 8)))))
             (L.cons.75.16
              (lambda (c.88 tmp.69 tmp.70) (let () (cons tmp.69 tmp.70))))
             (L.fixnum?.74.17 (lambda (c.89 tmp.59) (let () (fixnum? tmp.59))))
             (L.fun/void8678.8.18 (lambda (c.90) (let () (void))))
             (L.fun/any8677.9.19 (lambda (c.91) (let () 207))))
      (cletrec
       ((error?.78 (make-closure L.error?.78.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.77
         (make-closure L.vector-set!.77.12 3 unsafe-vector-set!.5))
        (vector-init-loop.24
         (make-closure L.vector-init-loop.24.13 3 vector-init-loop.24))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.24))
        (make-vector.76
         (make-closure L.make-vector.76.15 1 make-init-vector.4))
        (cons.75 (make-closure L.cons.75.16 2))
        (fixnum?.74 (make-closure L.fixnum?.74.17 1))
        (fun/void8678.8 (make-closure L.fun/void8678.8.18 0))
        (fun/any8677.9 (make-closure L.fun/any8677.9.19 0)))
       (let ((boolean0.12
              (closure-call
               fixnum?.74
               fixnum?.74
               (closure-call fun/any8677.9 fun/any8677.9)))
             (pair1.11
              (closure-call
               cons.75
               cons.75
               #t
               (closure-call
                cons.75
                cons.75
                (closure-call
                 cons.75
                 cons.75
                 60
                 (closure-call cons.75 cons.75 352 empty))
                (closure-call
                 cons.75
                 cons.75
                 #\U
                 (closure-call
                  cons.75
                  cons.75
                  #f
                  (closure-call
                   cons.75
                   cons.75
                   #\h
                   (closure-call
                    cons.75
                    cons.75
                    (closure-call
                     cons.75
                     cons.75
                     183
                     (closure-call cons.75 cons.75 445 empty))
                    (closure-call
                     cons.75
                     cons.75
                     #f
                     (closure-call cons.75 cons.75 #t empty)))))))))
             (vector2.10
              (let ((tmp.7.13 (closure-call make-vector.76 make-vector.76 8)))
                (let ((g42951404.14
                       (closure-call
                        vector-set!.77
                        vector-set!.77
                        tmp.7.13
                        0
                        (closure-call
                         cons.75
                         cons.75
                         210
                         (closure-call cons.75 cons.75 265 empty)))))
                  (if (closure-call error?.78 error?.78 g42951404.14)
                    g42951404.14
                    (let ((g42951405.15
                           (closure-call
                            vector-set!.77
                            vector-set!.77
                            tmp.7.13
                            1
                            (let () (error 49)))))
                      (if (closure-call error?.78 error?.78 g42951405.15)
                        g42951405.15
                        (let ((g42951406.16
                               (closure-call
                                vector-set!.77
                                vector-set!.77
                                tmp.7.13
                                2
                                (let ()
                                  (letrec ((L.lam.79.20
                                            (lambda (c.92) (let () 607))))
                                    (cletrec
                                     ((lam.79 (make-closure L.lam.79.20 0)))
                                     lam.79))))))
                          (if (closure-call error?.78 error?.78 g42951406.16)
                            g42951406.16
                            (let ((g42951407.17
                                   (closure-call
                                    vector-set!.77
                                    vector-set!.77
                                    tmp.7.13
                                    3
                                    (closure-call
                                     fun/void8678.8
                                     fun/void8678.8))))
                              (if (closure-call
                                   error?.78
                                   error?.78
                                   g42951407.17)
                                g42951407.17
                                (let ((g42951408.18
                                       (closure-call
                                        vector-set!.77
                                        vector-set!.77
                                        tmp.7.13
                                        4
                                        (if #f (void) (void)))))
                                  (if (closure-call
                                       error?.78
                                       error?.78
                                       g42951408.18)
                                    g42951408.18
                                    (let ((g42951409.19
                                           (closure-call
                                            vector-set!.77
                                            vector-set!.77
                                            tmp.7.13
                                            5
                                            (let () 179))))
                                      (if (closure-call
                                           error?.78
                                           error?.78
                                           g42951409.19)
                                        g42951409.19
                                        (let ((g42951410.20
                                               (closure-call
                                                vector-set!.77
                                                vector-set!.77
                                                tmp.7.13
                                                6
                                                (if #t
                                                  (letrec ((L.lam.80.21
                                                            (lambda (c.93)
                                                              (let () 687))))
                                                    (cletrec
                                                     ((lam.80
                                                       (make-closure
                                                        L.lam.80.21
                                                        0)))
                                                     lam.80))
                                                  (letrec ((L.lam.81.22
                                                            (lambda (c.94)
                                                              (let () 691))))
                                                    (cletrec
                                                     ((lam.81
                                                       (make-closure
                                                        L.lam.81.22
                                                        0)))
                                                     lam.81))))))
                                          (if (closure-call
                                               error?.78
                                               error?.78
                                               g42951410.20)
                                            g42951410.20
                                            (let ((g42951411.21
                                                   (closure-call
                                                    vector-set!.77
                                                    vector-set!.77
                                                    tmp.7.13
                                                    7
                                                    (if 216
                                                      (if 101
                                                        (if 8
                                                          (if 78 234 #f)
                                                          #f)
                                                        #f)
                                                      #f))))
                                              (if (closure-call
                                                   error?.78
                                                   error?.78
                                                   g42951411.21)
                                                g42951411.21
                                                tmp.7.13)))))))))))))))))))
         (let () (void)))))))
(check-by-interp
 '(module
    (letrec ((L.procedure?.98.10
              (lambda (c.100 tmp.88) (let () (procedure? tmp.88))))
             (L.error?.97.11 (lambda (c.101 tmp.84) (let () (error? tmp.84))))
             (L.unsafe-vector-set!.5.12
              (lambda (c.102 tmp.48 tmp.49 tmp.50)
                (let ()
                  (if (unsafe-fx< tmp.49 (unsafe-vector-length tmp.48))
                    (if (unsafe-fx>= tmp.49 0)
                      (begin (unsafe-vector-set! tmp.48 tmp.49 tmp.50) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.96.13
              (lambda (c.103 tmp.72 tmp.73 tmp.74)
                (let ((unsafe-vector-set!.5 (closure-ref c.103 0)))
                  (if (fixnum? tmp.73)
                    (if (vector? tmp.72)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.72
                       tmp.73
                       tmp.74)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.44.14
              (lambda (c.104 len.45 i.47 vec.46)
                (let ((vector-init-loop.44 (closure-ref c.104 0)))
                  (if (eq? len.45 i.47)
                    vec.46
                    (begin
                      (unsafe-vector-set! vec.46 i.47 0)
                      (closure-call
                       vector-init-loop.44
                       vector-init-loop.44
                       len.45
                       (unsafe-fx+ i.47 1)
                       vec.46))))))
             (L.make-init-vector.4.15
              (lambda (c.105 tmp.42)
                (let ((vector-init-loop.44 (closure-ref c.105 0)))
                  (let ((tmp.43 (unsafe-make-vector tmp.42)))
                    (closure-call
                     vector-init-loop.44
                     vector-init-loop.44
                     tmp.42
                     0
                     tmp.43)))))
             (L.make-vector.95.16
              (lambda (c.106 tmp.70)
                (let ((make-init-vector.4 (closure-ref c.106 0)))
                  (if (fixnum? tmp.70)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.70)
                    (error 8)))))
             (L.cons.94.17
              (lambda (c.107 tmp.89 tmp.90) (let () (cons tmp.89 tmp.90))))
             (L.fun/error8682.16.18 (lambda (c.108) (let () (error 7))))
             (L.fun/boolean8683.17.19 (lambda (c.109) (let () #f)))
             (L.fun/error8681.18.20
              (lambda (c.110)
                (let ((fun/error8682.16 (closure-ref c.110 0)))
                  (closure-call fun/error8682.16 fun/error8682.16))))
             (L.fun/boolean8684.19.21 (lambda (c.111) (let () #t))))
      (cletrec
       ((procedure?.98 (make-closure L.procedure?.98.10 1))
        (error?.97 (make-closure L.error?.97.11 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.12 3))
        (vector-set!.96
         (make-closure L.vector-set!.96.13 3 unsafe-vector-set!.5))
        (vector-init-loop.44
         (make-closure L.vector-init-loop.44.14 3 vector-init-loop.44))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.15 1 vector-init-loop.44))
        (make-vector.95
         (make-closure L.make-vector.95.16 1 make-init-vector.4))
        (cons.94 (make-closure L.cons.94.17 2))
        (fun/error8682.16 (make-closure L.fun/error8682.16.18 0))
        (fun/boolean8683.17 (make-closure L.fun/boolean8683.17.19 0))
        (fun/error8681.18
         (make-closure L.fun/error8681.18.20 0 fun/error8682.16))
        (fun/boolean8684.19 (make-closure L.fun/boolean8684.19.21 0)))
       (let ((pair0.22
              (closure-call
               cons.94
               cons.94
               (closure-call
                cons.94
                cons.94
                218
                (closure-call cons.94 cons.94 271 empty))
               (closure-call
                cons.94
                cons.94
                #t
                (closure-call
                 cons.94
                 cons.94
                 (closure-call
                  cons.94
                  cons.94
                  220
                  (closure-call cons.94 cons.94 505 empty))
                 (closure-call
                  cons.94
                  cons.94
                  (closure-call
                   cons.94
                   cons.94
                   246
                   (closure-call cons.94 cons.94 281 empty))
                  (closure-call
                   cons.94
                   cons.94
                   #t
                   (closure-call
                    cons.94
                    cons.94
                    empty
                    (closure-call
                     cons.94
                     cons.94
                     (closure-call
                      cons.94
                      cons.94
                      148
                      (closure-call cons.94 cons.94 289 empty))
                     (closure-call cons.94 cons.94 #\e empty)))))))))
             (error1.21 (closure-call fun/error8681.18 fun/error8681.18))
             (procedure2.20
              (letrec ((L.lam.99.22
                        (lambda (c.112)
                          (let ((make-vector.95 (closure-ref c.112 0))
                                (error?.97 (closure-ref c.112 1))
                                (vector-set!.96 (closure-ref c.112 2)))
                            (let ()
                              (let ((tmp.7.23
                                     (closure-call
                                      make-vector.95
                                      make-vector.95
                                      8)))
                                (let ((g42955226.24
                                       (closure-call
                                        vector-set!.96
                                        vector-set!.96
                                        tmp.7.23
                                        0
                                        0)))
                                  (if (closure-call
                                       error?.97
                                       error?.97
                                       g42955226.24)
                                    g42955226.24
                                    (let ((g42955227.25
                                           (closure-call
                                            vector-set!.96
                                            vector-set!.96
                                            tmp.7.23
                                            1
                                            1)))
                                      (if (closure-call
                                           error?.97
                                           error?.97
                                           g42955227.25)
                                        g42955227.25
                                        (let ((g42955228.26
                                               (closure-call
                                                vector-set!.96
                                                vector-set!.96
                                                tmp.7.23
                                                2
                                                2)))
                                          (if (closure-call
                                               error?.97
                                               error?.97
                                               g42955228.26)
                                            g42955228.26
                                            (let ((g42955229.27
                                                   (closure-call
                                                    vector-set!.96
                                                    vector-set!.96
                                                    tmp.7.23
                                                    3
                                                    3)))
                                              (if (closure-call
                                                   error?.97
                                                   error?.97
                                                   g42955229.27)
                                                g42955229.27
                                                (let ((g42955230.28
                                                       (closure-call
                                                        vector-set!.96
                                                        vector-set!.96
                                                        tmp.7.23
                                                        4
                                                        4)))
                                                  (if (closure-call
                                                       error?.97
                                                       error?.97
                                                       g42955230.28)
                                                    g42955230.28
                                                    (let ((g42955231.29
                                                           (closure-call
                                                            vector-set!.96
                                                            vector-set!.96
                                                            tmp.7.23
                                                            5
                                                            5)))
                                                      (if (closure-call
                                                           error?.97
                                                           error?.97
                                                           g42955231.29)
                                                        g42955231.29
                                                        (let ((g42955232.30
                                                               (closure-call
                                                                vector-set!.96
                                                                vector-set!.96
                                                                tmp.7.23
                                                                6
                                                                6)))
                                                          (if (closure-call
                                                               error?.97
                                                               error?.97
                                                               g42955232.30)
                                                            g42955232.30
                                                            (let ((g42955233.31
                                                                   (closure-call
                                                                    vector-set!.96
                                                                    vector-set!.96
                                                                    tmp.7.23
                                                                    7
                                                                    7)))
                                                              (if (closure-call
                                                                   error?.97
                                                                   error?.97
                                                                   g42955233.31)
                                                                g42955233.31
                                                                tmp.7.23))))))))))))))))))))))
                (cletrec
                 ((lam.99
                   (make-closure
                    L.lam.99.22
                    0
                    make-vector.95
                    error?.97
                    vector-set!.96)))
                 lam.99))))
         (let ((tmp.8.32 (if #f #f #t)))
           (if tmp.8.32
             tmp.8.32
             (let ((tmp.9.33
                    (closure-call procedure?.98 procedure?.98 (error 58))))
               (if tmp.9.33
                 tmp.9.33
                 (let ((tmp.10.34
                        (closure-call fun/boolean8683.17 fun/boolean8683.17)))
                   (if tmp.10.34
                     tmp.10.34
                     (let ((tmp.11.35
                            (closure-call
                             fun/boolean8684.19
                             fun/boolean8684.19)))
                       (if tmp.11.35
                         tmp.11.35
                         (let ((tmp.12.36
                                (let ((g42955234.37 #f))
                                  (if (closure-call
                                       error?.97
                                       error?.97
                                       g42955234.37)
                                    g42955234.37
                                    (let ((g42955235.38 #t))
                                      (if (closure-call
                                           error?.97
                                           error?.97
                                           g42955235.38)
                                        g42955235.38
                                        #t))))))
                           (if tmp.12.36
                             tmp.12.36
                             (let ((tmp.13.39 #f))
                               (if tmp.13.39
                                 tmp.13.39
                                 (let ((tmp.14.40 #f))
                                   (if tmp.14.40
                                     tmp.14.40
                                     (let ((tmp.15.41 #t))
                                       (if tmp.15.41
                                         tmp.15.41
                                         #f)))))))))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.error?.93.10 (lambda (c.94 tmp.80) (let () (error? tmp.80))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.95 tmp.44 tmp.45 tmp.46)
                (let ()
                  (if (unsafe-fx< tmp.45 (unsafe-vector-length tmp.44))
                    (if (unsafe-fx>= tmp.45 0)
                      (begin (unsafe-vector-set! tmp.44 tmp.45 tmp.46) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.92.12
              (lambda (c.96 tmp.68 tmp.69 tmp.70)
                (let ((unsafe-vector-set!.5 (closure-ref c.96 0)))
                  (if (fixnum? tmp.69)
                    (if (vector? tmp.68)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.68
                       tmp.69
                       tmp.70)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.40.13
              (lambda (c.97 len.41 i.43 vec.42)
                (let ((vector-init-loop.40 (closure-ref c.97 0)))
                  (if (eq? len.41 i.43)
                    vec.42
                    (begin
                      (unsafe-vector-set! vec.42 i.43 0)
                      (closure-call
                       vector-init-loop.40
                       vector-init-loop.40
                       len.41
                       (unsafe-fx+ i.43 1)
                       vec.42))))))
             (L.make-init-vector.4.14
              (lambda (c.98 tmp.38)
                (let ((vector-init-loop.40 (closure-ref c.98 0)))
                  (let ((tmp.39 (unsafe-make-vector tmp.38)))
                    (closure-call
                     vector-init-loop.40
                     vector-init-loop.40
                     tmp.38
                     0
                     tmp.39)))))
             (L.make-vector.91.15
              (lambda (c.99 tmp.66)
                (let ((make-init-vector.4 (closure-ref c.99 0)))
                  (if (fixnum? tmp.66)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.66)
                    (error 8)))))
             (L.cons.90.16
              (lambda (c.100 tmp.85 tmp.86) (let () (cons tmp.85 tmp.86))))
             (L.fun/error8688.15.17 (lambda (c.101) (let () (error 156))))
             (L.fun/error8687.16.18
              (lambda (c.102 oprand0.18 oprand1.17)
                (let ((fun/error8688.15 (closure-ref c.102 0)))
                  (closure-call fun/error8688.15 fun/error8688.15)))))
      (cletrec
       ((error?.93 (make-closure L.error?.93.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.92
         (make-closure L.vector-set!.92.12 3 unsafe-vector-set!.5))
        (vector-init-loop.40
         (make-closure L.vector-init-loop.40.13 3 vector-init-loop.40))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.40))
        (make-vector.91
         (make-closure L.make-vector.91.15 1 make-init-vector.4))
        (cons.90 (make-closure L.cons.90.16 2))
        (fun/error8688.15 (make-closure L.fun/error8688.15.17 0))
        (fun/error8687.16
         (make-closure L.fun/error8687.16.18 2 fun/error8688.15)))
       (let ((tmp.7.19
              (let ((tmp.8.20 (let ((error0.21 (error 234))) (error 178))))
                (if tmp.8.20
                  tmp.8.20
                  (let ((tmp.9.22 (if #t (error 31) (error 214))))
                    (if tmp.9.22 tmp.9.22 (if #f (error 168) (error 132))))))))
         (if tmp.7.19
           tmp.7.19
           (let ((tmp.10.23
                  (let ((pair0.24
                         (closure-call
                          cons.90
                          cons.90
                          29
                          (closure-call cons.90 cons.90 492 empty))))
                    (error 235))))
             (if tmp.10.23
               tmp.10.23
               (let ((tmp.11.25 (if #f (error 222) (error 127))))
                 (if tmp.11.25
                   tmp.11.25
                   (let ((tmp.12.26
                          (let ((vector0.27
                                 (let ((tmp.13.28
                                        (closure-call
                                         make-vector.91
                                         make-vector.91
                                         8)))
                                   (let ((g42959050.29
                                          (closure-call
                                           vector-set!.92
                                           vector-set!.92
                                           tmp.13.28
                                           0
                                           1)))
                                     (if (closure-call
                                          error?.93
                                          error?.93
                                          g42959050.29)
                                       g42959050.29
                                       (let ((g42959051.30
                                              (closure-call
                                               vector-set!.92
                                               vector-set!.92
                                               tmp.13.28
                                               1
                                               2)))
                                         (if (closure-call
                                              error?.93
                                              error?.93
                                              g42959051.30)
                                           g42959051.30
                                           (let ((g42959052.31
                                                  (closure-call
                                                   vector-set!.92
                                                   vector-set!.92
                                                   tmp.13.28
                                                   2
                                                   3)))
                                             (if (closure-call
                                                  error?.93
                                                  error?.93
                                                  g42959052.31)
                                               g42959052.31
                                               (let ((g42959053.32
                                                      (closure-call
                                                       vector-set!.92
                                                       vector-set!.92
                                                       tmp.13.28
                                                       3
                                                       4)))
                                                 (if (closure-call
                                                      error?.93
                                                      error?.93
                                                      g42959053.32)
                                                   g42959053.32
                                                   (let ((g42959054.33
                                                          (closure-call
                                                           vector-set!.92
                                                           vector-set!.92
                                                           tmp.13.28
                                                           4
                                                           5)))
                                                     (if (closure-call
                                                          error?.93
                                                          error?.93
                                                          g42959054.33)
                                                       g42959054.33
                                                       (let ((g42959055.34
                                                              (closure-call
                                                               vector-set!.92
                                                               vector-set!.92
                                                               tmp.13.28
                                                               5
                                                               6)))
                                                         (if (closure-call
                                                              error?.93
                                                              error?.93
                                                              g42959055.34)
                                                           g42959055.34
                                                           (let ((g42959056.35
                                                                  (closure-call
                                                                   vector-set!.92
                                                                   vector-set!.92
                                                                   tmp.13.28
                                                                   6
                                                                   7)))
                                                             (if (closure-call
                                                                  error?.93
                                                                  error?.93
                                                                  g42959056.35)
                                                               g42959056.35
                                                               (let ((g42959057.36
                                                                      (closure-call
                                                                       vector-set!.92
                                                                       vector-set!.92
                                                                       tmp.13.28
                                                                       7
                                                                       8)))
                                                                 (if (closure-call
                                                                      error?.93
                                                                      error?.93
                                                                      g42959057.36)
                                                                   g42959057.36
                                                                   tmp.13.28)))))))))))))))))))
                            (error 216))))
                     (if tmp.12.26
                       tmp.12.26
                       (let ((tmp.14.37 (let () (error 117))))
                         (if tmp.14.37
                           tmp.14.37
                           (closure-call
                            fun/error8687.16
                            fun/error8687.16
                            (if #f (void) (void))
                            (if #f empty empty))))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.error?.86.10 (lambda (c.88 tmp.74) (let () (error? tmp.74))))
             (L.boolean?.85.11
              (lambda (c.89 tmp.70) (let () (boolean? tmp.70))))
             (L.cons.84.12
              (lambda (c.90 tmp.79 tmp.80) (let () (cons tmp.79 tmp.80))))
             (L.fun/void8692.11.13
              (lambda (c.91 oprand0.16 oprand1.15) (let () (void))))
             (L.fun/void8693.12.14
              (lambda (c.92 oprand0.18 oprand1.17) (let () (let () (void)))))
             (L.fun/boolean8691.13.15 (lambda (c.93) (let () #f)))
             (L.fun/void8694.14.16 (lambda (c.94) (let () (void)))))
      (cletrec
       ((error?.86 (make-closure L.error?.86.10 1))
        (boolean?.85 (make-closure L.boolean?.85.11 1))
        (cons.84 (make-closure L.cons.84.12 2))
        (fun/void8692.11 (make-closure L.fun/void8692.11.13 2))
        (fun/void8693.12 (make-closure L.fun/void8693.12.14 2))
        (fun/boolean8691.13 (make-closure L.fun/boolean8691.13.15 0))
        (fun/void8694.14 (make-closure L.fun/void8694.14.16 0)))
       (if (let ((tmp.7.19
                  (let ((pair0.21
                         (closure-call
                          cons.84
                          cons.84
                          214
                          (closure-call cons.84 cons.84 273 empty)))
                        (error1.20 (error 15)))
                    #t)))
             (if tmp.7.19
               tmp.7.19
               (let ((tmp.8.22 (closure-call boolean?.85 boolean?.85 #\^)))
                 (if tmp.8.22
                   tmp.8.22
                   (let ((tmp.9.23
                          (closure-call
                           fun/boolean8691.13
                           fun/boolean8691.13)))
                     (if tmp.9.23
                       tmp.9.23
                       (let ((tmp.10.24 (closure-call error?.86 error?.86 #f)))
                         (if tmp.10.24 tmp.10.24 (if #t #f #f)))))))))
         (if (let ((procedure0.27
                    (letrec ((L.lam.87.17 (lambda (c.95) (let () (error 38)))))
                      (cletrec
                       ((lam.87 (make-closure L.lam.87.17 0)))
                       lam.87)))
                   (error1.26 (error 99))
                   (empty2.25 empty))
               (void))
           (if (let () (void))
             (if (if #t (void) (void))
               (if (closure-call
                    fun/void8692.11
                    fun/void8692.11
                    #\t
                    (error 161))
                 (if (if (void) (if (void) (void) #f) #f)
                   (if (void) (if (void) (if (void) (void) #f) #f) #f)
                   #f)
                 #f)
               #f)
             #f)
           #f)
         (closure-call
          fun/void8693.12
          fun/void8693.12
          (let ((g42962877.28 26))
            (if (closure-call error?.86 error?.86 g42962877.28)
              g42962877.28
              (let ((g42962878.29 21))
                (if (closure-call error?.86 error?.86 g42962878.29)
                  g42962878.29
                  (let ((g42962879.30 162))
                    (if (closure-call error?.86 error?.86 g42962879.30)
                      g42962879.30
                      (let ((g42962880.31 104))
                        (if (closure-call error?.86 error?.86 g42962880.31)
                          g42962880.31
                          106))))))))
          (closure-call fun/void8694.14 fun/void8694.14)))))))
(check-by-interp
 '(module
    (letrec ((L.fun/error8697.7.10
              (lambda (c.62) (let () (let () (error 156))))))
      (cletrec
       ((fun/error8697.7 (make-closure L.fun/error8697.7.10 0)))
       (let ((error0.9 (closure-call fun/error8697.7 fun/error8697.7))
             (error1.8 (let () (error 2))))
         (if #t (error 191) (error 77)))))))
(check-by-interp
 '(module
    (letrec ((L.fun/void8702.13.10 (lambda (c.77) (let () (void))))
             (L.fun/void8701.14.11
              (lambda (c.78)
                (let ((fun/void8702.13 (closure-ref c.78 0)))
                  (closure-call fun/void8702.13 fun/void8702.13))))
             (L.fun/empty8700.15.12 (lambda (c.79) (let () empty))))
      (cletrec
       ((fun/void8702.13 (make-closure L.fun/void8702.13.10 0))
        (fun/void8701.14 (make-closure L.fun/void8701.14.11 0 fun/void8702.13))
        (fun/empty8700.15 (make-closure L.fun/empty8700.15.12 0)))
       (let ((empty0.18
              (let ((tmp.7.19 (let () empty)))
                (if tmp.7.19
                  tmp.7.19
                  (let ((tmp.8.20 (if #t empty empty)))
                    (if tmp.8.20
                      tmp.8.20
                      (let ((tmp.9.21 (let () empty)))
                        (if tmp.9.21
                          tmp.9.21
                          (let ((tmp.10.22 (if empty (if empty empty #f) #f)))
                            (if tmp.10.22
                              tmp.10.22
                              (let ((tmp.11.23 (let () empty)))
                                (if tmp.11.23
                                  tmp.11.23
                                  (let ((tmp.12.24
                                         (closure-call
                                          fun/empty8700.15
                                          fun/empty8700.15)))
                                    (if tmp.12.24
                                      tmp.12.24
                                      (if #t empty empty))))))))))))))
             (ascii-char1.17 (if #f #\m #\F))
             (void2.16 (closure-call fun/void8701.14 fun/void8701.14)))
         (if #f #t #t))))))
(check-by-interp
 '(module
    (letrec ((L.cons.150.10
              (lambda (c.152 tmp.142 tmp.143) (let () (cons tmp.142 tmp.143))))
             (L.vector-init-loop.97.11
              (lambda (c.153 len.98 i.100 vec.99)
                (let ((vector-init-loop.97 (closure-ref c.153 0)))
                  (if (eq? len.98 i.100)
                    vec.99
                    (begin
                      (unsafe-vector-set! vec.99 i.100 0)
                      (closure-call
                       vector-init-loop.97
                       vector-init-loop.97
                       len.98
                       (unsafe-fx+ i.100 1)
                       vec.99))))))
             (L.make-init-vector.4.12
              (lambda (c.154 tmp.95)
                (let ((vector-init-loop.97 (closure-ref c.154 0)))
                  (let ((tmp.96 (unsafe-make-vector tmp.95)))
                    (closure-call
                     vector-init-loop.97
                     vector-init-loop.97
                     tmp.95
                     0
                     tmp.96)))))
             (L.make-vector.149.13
              (lambda (c.155 tmp.123)
                (let ((make-init-vector.4 (closure-ref c.155 0)))
                  (if (fixnum? tmp.123)
                    (closure-call
                     make-init-vector.4
                     make-init-vector.4
                     tmp.123)
                    (error 8)))))
             (L.error?.148.14
              (lambda (c.156 tmp.137) (let () (error? tmp.137))))
             (L.unsafe-vector-set!.5.15
              (lambda (c.157 tmp.101 tmp.102 tmp.103)
                (let ()
                  (if (unsafe-fx< tmp.102 (unsafe-vector-length tmp.101))
                    (if (unsafe-fx>= tmp.102 0)
                      (begin
                        (unsafe-vector-set! tmp.101 tmp.102 tmp.103)
                        (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.147.16
              (lambda (c.158 tmp.125 tmp.126 tmp.127)
                (let ((unsafe-vector-set!.5 (closure-ref c.158 0)))
                  (if (fixnum? tmp.126)
                    (if (vector? tmp.125)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.125
                       tmp.126
                       tmp.127)
                      (error 10))
                    (error 10)))))
             (L.fun/void8706.20.17
              (lambda (c.159 oprand0.32 oprand1.31)
                (let () (let () oprand1.31))))
             (L.fun/void8714.21.18
              (lambda (c.160)
                (let ((fun/void8715.28 (closure-ref c.160 0)))
                  (closure-call fun/void8715.28 fun/void8715.28))))
             (L.fun/void8713.22.19 (lambda (c.161) (let () (void))))
             (L.fun/void8705.23.20 (lambda (c.162) (let () (void))))
             (L.fun/void8708.24.21 (lambda (c.163 oprand0.33) (let () (void))))
             (L.fun/void8709.25.22 (lambda (c.164) (let () (void))))
             (L.fun/void8710.26.23 (lambda (c.165 oprand0.34) (let () (void))))
             (L.fun/boolean8712.27.24 (lambda (c.166) (let () #f)))
             (L.fun/void8715.28.25 (lambda (c.167) (let () (void))))
             (L.fun/void8711.29.26
              (lambda (c.168 oprand0.36 oprand1.35)
                (let ((vector-set!.147 (closure-ref c.168 0)))
                  (closure-call
                   vector-set!.147
                   vector-set!.147
                   oprand1.35
                   5
                   oprand0.36))))
             (L.fun/void8707.30.27
              (lambda (c.169 oprand0.37) (let () oprand0.37))))
      (cletrec
       ((cons.150 (make-closure L.cons.150.10 2))
        (vector-init-loop.97
         (make-closure L.vector-init-loop.97.11 3 vector-init-loop.97))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.12 1 vector-init-loop.97))
        (make-vector.149
         (make-closure L.make-vector.149.13 1 make-init-vector.4))
        (error?.148 (make-closure L.error?.148.14 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.15 3))
        (vector-set!.147
         (make-closure L.vector-set!.147.16 3 unsafe-vector-set!.5))
        (fun/void8706.20 (make-closure L.fun/void8706.20.17 2))
        (fun/void8714.21 (make-closure L.fun/void8714.21.18 0 fun/void8715.28))
        (fun/void8713.22 (make-closure L.fun/void8713.22.19 0))
        (fun/void8705.23 (make-closure L.fun/void8705.23.20 0))
        (fun/void8708.24 (make-closure L.fun/void8708.24.21 1))
        (fun/void8709.25 (make-closure L.fun/void8709.25.22 0))
        (fun/void8710.26 (make-closure L.fun/void8710.26.23 1))
        (fun/boolean8712.27 (make-closure L.fun/boolean8712.27.24 0))
        (fun/void8715.28 (make-closure L.fun/void8715.28.25 0))
        (fun/void8711.29 (make-closure L.fun/void8711.29.26 2 vector-set!.147))
        (fun/void8707.30 (make-closure L.fun/void8707.30.27 1)))
       (if (let ((empty0.38 (if #f empty empty)))
             (if (void)
               (if (void) (if (void) (if (void) (void) #f) #f) #f)
               #f))
         (if (if (if #f (void) (void))
               (if (let ((tmp.7.39 (if (void) (void) #f)))
                     (if tmp.7.39
                       tmp.7.39
                       (let ((tmp.8.40 (if #t (void) (void))))
                         (if tmp.8.40
                           tmp.8.40
                           (let ((tmp.9.41
                                  (closure-call
                                   fun/void8705.23
                                   fun/void8705.23)))
                             (if tmp.9.41
                               tmp.9.41
                               (let ((tmp.10.42 (if #f (void) (void))))
                                 (if tmp.10.42
                                   tmp.10.42
                                   (let ((tmp.11.43 (if #f (void) (void))))
                                     (if tmp.11.43
                                       tmp.11.43
                                       (let ((tmp.12.44 (let () (void))))
                                         (if tmp.12.44
                                           tmp.12.44
                                           (let ((g42974326.45 (void)))
                                             (if (closure-call
                                                  error?.148
                                                  error?.148
                                                  g42974326.45)
                                               g42974326.45
                                               (void)))))))))))))))
                 (if (closure-call
                      fun/void8706.20
                      fun/void8706.20
                      (if #t (void) (void))
                      (if #f (void) (void)))
                   (if (let ((vector0.48
                              (let ((tmp.13.49
                                     (closure-call
                                      make-vector.149
                                      make-vector.149
                                      8)))
                                (let ((g42974327.50
                                       (closure-call
                                        vector-set!.147
                                        vector-set!.147
                                        tmp.13.49
                                        0
                                        0)))
                                  (if (closure-call
                                       error?.148
                                       error?.148
                                       g42974327.50)
                                    g42974327.50
                                    (let ((g42974328.51
                                           (closure-call
                                            vector-set!.147
                                            vector-set!.147
                                            tmp.13.49
                                            1
                                            1)))
                                      (if (closure-call
                                           error?.148
                                           error?.148
                                           g42974328.51)
                                        g42974328.51
                                        (let ((g42974329.52
                                               (closure-call
                                                vector-set!.147
                                                vector-set!.147
                                                tmp.13.49
                                                2
                                                2)))
                                          (if (closure-call
                                               error?.148
                                               error?.148
                                               g42974329.52)
                                            g42974329.52
                                            (let ((g42974330.53
                                                   (closure-call
                                                    vector-set!.147
                                                    vector-set!.147
                                                    tmp.13.49
                                                    3
                                                    3)))
                                              (if (closure-call
                                                   error?.148
                                                   error?.148
                                                   g42974330.53)
                                                g42974330.53
                                                (let ((g42974331.54
                                                       (closure-call
                                                        vector-set!.147
                                                        vector-set!.147
                                                        tmp.13.49
                                                        4
                                                        4)))
                                                  (if (closure-call
                                                       error?.148
                                                       error?.148
                                                       g42974331.54)
                                                    g42974331.54
                                                    (let ((g42974332.55
                                                           (closure-call
                                                            vector-set!.147
                                                            vector-set!.147
                                                            tmp.13.49
                                                            5
                                                            5)))
                                                      (if (closure-call
                                                           error?.148
                                                           error?.148
                                                           g42974332.55)
                                                        g42974332.55
                                                        (let ((g42974333.56
                                                               (closure-call
                                                                vector-set!.147
                                                                vector-set!.147
                                                                tmp.13.49
                                                                6
                                                                6)))
                                                          (if (closure-call
                                                               error?.148
                                                               error?.148
                                                               g42974333.56)
                                                            g42974333.56
                                                            (let ((g42974334.57
                                                                   (closure-call
                                                                    vector-set!.147
                                                                    vector-set!.147
                                                                    tmp.13.49
                                                                    7
                                                                    7)))
                                                              (if (closure-call
                                                                   error?.148
                                                                   error?.148
                                                                   g42974334.57)
                                                                g42974334.57
                                                                tmp.13.49))))))))))))))))))
                             (ascii-char1.47 #\n)
                             (vector2.46
                              (let ((tmp.14.58
                                     (closure-call
                                      make-vector.149
                                      make-vector.149
                                      8)))
                                (let ((g42974335.59
                                       (closure-call
                                        vector-set!.147
                                        vector-set!.147
                                        tmp.14.58
                                        0
                                        0)))
                                  (if (closure-call
                                       error?.148
                                       error?.148
                                       g42974335.59)
                                    g42974335.59
                                    (let ((g42974336.60
                                           (closure-call
                                            vector-set!.147
                                            vector-set!.147
                                            tmp.14.58
                                            1
                                            1)))
                                      (if (closure-call
                                           error?.148
                                           error?.148
                                           g42974336.60)
                                        g42974336.60
                                        (let ((g42974337.61
                                               (closure-call
                                                vector-set!.147
                                                vector-set!.147
                                                tmp.14.58
                                                2
                                                2)))
                                          (if (closure-call
                                               error?.148
                                               error?.148
                                               g42974337.61)
                                            g42974337.61
                                            (let ((g42974338.62
                                                   (closure-call
                                                    vector-set!.147
                                                    vector-set!.147
                                                    tmp.14.58
                                                    3
                                                    3)))
                                              (if (closure-call
                                                   error?.148
                                                   error?.148
                                                   g42974338.62)
                                                g42974338.62
                                                (let ((g42974339.63
                                                       (closure-call
                                                        vector-set!.147
                                                        vector-set!.147
                                                        tmp.14.58
                                                        4
                                                        4)))
                                                  (if (closure-call
                                                       error?.148
                                                       error?.148
                                                       g42974339.63)
                                                    g42974339.63
                                                    (let ((g42974340.64
                                                           (closure-call
                                                            vector-set!.147
                                                            vector-set!.147
                                                            tmp.14.58
                                                            5
                                                            5)))
                                                      (if (closure-call
                                                           error?.148
                                                           error?.148
                                                           g42974340.64)
                                                        g42974340.64
                                                        (let ((g42974341.65
                                                               (closure-call
                                                                vector-set!.147
                                                                vector-set!.147
                                                                tmp.14.58
                                                                6
                                                                6)))
                                                          (if (closure-call
                                                               error?.148
                                                               error?.148
                                                               g42974341.65)
                                                            g42974341.65
                                                            (let ((g42974342.66
                                                                   (closure-call
                                                                    vector-set!.147
                                                                    vector-set!.147
                                                                    tmp.14.58
                                                                    7
                                                                    7)))
                                                              (if (closure-call
                                                                   error?.148
                                                                   error?.148
                                                                   g42974342.66)
                                                                g42974342.66
                                                                tmp.14.58)))))))))))))))))))
                         (void))
                     (if (let ((tmp.15.67 (void)))
                           (if tmp.15.67 tmp.15.67 (void)))
                       (if (closure-call
                            fun/void8707.30
                            fun/void8707.30
                            (void))
                         (if (if #t (void) (void))
                           (if (if #t (void) (void))
                             (if (closure-call
                                  fun/void8708.24
                                  fun/void8708.24
                                  #\d)
                               (let ((error0.68 (error 213))) (void))
                               #f)
                             #f)
                           #f)
                         #f)
                       #f)
                     #f)
                   #f)
                 #f)
               #f)
           (if (if (let ((boolean0.69 #f)) #t)
                 (closure-call fun/void8709.25 fun/void8709.25)
                 (closure-call fun/void8710.26 fun/void8710.26 empty))
             (if (let ()
                   (closure-call
                    fun/void8711.29
                    fun/void8711.29
                    (letrec ((L.lam.151.28 (lambda (c.170) (let () 1012))))
                      (cletrec
                       ((lam.151 (make-closure L.lam.151.28 0)))
                       lam.151))
                    (let ((tmp.16.70
                           (closure-call make-vector.149 make-vector.149 8)))
                      (let ((g42974343.71
                             (closure-call
                              vector-set!.147
                              vector-set!.147
                              tmp.16.70
                              0
                              1)))
                        (if (closure-call error?.148 error?.148 g42974343.71)
                          g42974343.71
                          (let ((g42974344.72
                                 (closure-call
                                  vector-set!.147
                                  vector-set!.147
                                  tmp.16.70
                                  1
                                  2)))
                            (if (closure-call
                                 error?.148
                                 error?.148
                                 g42974344.72)
                              g42974344.72
                              (let ((g42974345.73
                                     (closure-call
                                      vector-set!.147
                                      vector-set!.147
                                      tmp.16.70
                                      2
                                      3)))
                                (if (closure-call
                                     error?.148
                                     error?.148
                                     g42974345.73)
                                  g42974345.73
                                  (let ((g42974346.74
                                         (closure-call
                                          vector-set!.147
                                          vector-set!.147
                                          tmp.16.70
                                          3
                                          4)))
                                    (if (closure-call
                                         error?.148
                                         error?.148
                                         g42974346.74)
                                      g42974346.74
                                      (let ((g42974347.75
                                             (closure-call
                                              vector-set!.147
                                              vector-set!.147
                                              tmp.16.70
                                              4
                                              5)))
                                        (if (closure-call
                                             error?.148
                                             error?.148
                                             g42974347.75)
                                          g42974347.75
                                          (let ((g42974348.76
                                                 (closure-call
                                                  vector-set!.147
                                                  vector-set!.147
                                                  tmp.16.70
                                                  5
                                                  6)))
                                            (if (closure-call
                                                 error?.148
                                                 error?.148
                                                 g42974348.76)
                                              g42974348.76
                                              (let ((g42974349.77
                                                     (closure-call
                                                      vector-set!.147
                                                      vector-set!.147
                                                      tmp.16.70
                                                      6
                                                      7)))
                                                (if (closure-call
                                                     error?.148
                                                     error?.148
                                                     g42974349.77)
                                                  g42974349.77
                                                  (let ((g42974350.78
                                                         (closure-call
                                                          vector-set!.147
                                                          vector-set!.147
                                                          tmp.16.70
                                                          7
                                                          8)))
                                                    (if (closure-call
                                                         error?.148
                                                         error?.148
                                                         g42974350.78)
                                                      g42974350.78
                                                      tmp.16.70)))))))))))))))))))
               (if (if (closure-call fun/boolean8712.27 fun/boolean8712.27)
                     (let ((pair0.81
                            (closure-call
                             cons.150
                             cons.150
                             164
                             (closure-call cons.150 cons.150 281 empty)))
                           (vector1.80
                            (let ((tmp.17.82
                                   (closure-call
                                    make-vector.149
                                    make-vector.149
                                    8)))
                              (let ((g42974351.83
                                     (closure-call
                                      vector-set!.147
                                      vector-set!.147
                                      tmp.17.82
                                      0
                                      1)))
                                (if (closure-call
                                     error?.148
                                     error?.148
                                     g42974351.83)
                                  g42974351.83
                                  (let ((g42974352.84
                                         (closure-call
                                          vector-set!.147
                                          vector-set!.147
                                          tmp.17.82
                                          1
                                          2)))
                                    (if (closure-call
                                         error?.148
                                         error?.148
                                         g42974352.84)
                                      g42974352.84
                                      (let ((g42974353.85
                                             (closure-call
                                              vector-set!.147
                                              vector-set!.147
                                              tmp.17.82
                                              2
                                              3)))
                                        (if (closure-call
                                             error?.148
                                             error?.148
                                             g42974353.85)
                                          g42974353.85
                                          (let ((g42974354.86
                                                 (closure-call
                                                  vector-set!.147
                                                  vector-set!.147
                                                  tmp.17.82
                                                  3
                                                  4)))
                                            (if (closure-call
                                                 error?.148
                                                 error?.148
                                                 g42974354.86)
                                              g42974354.86
                                              (let ((g42974355.87
                                                     (closure-call
                                                      vector-set!.147
                                                      vector-set!.147
                                                      tmp.17.82
                                                      4
                                                      5)))
                                                (if (closure-call
                                                     error?.148
                                                     error?.148
                                                     g42974355.87)
                                                  g42974355.87
                                                  (let ((g42974356.88
                                                         (closure-call
                                                          vector-set!.147
                                                          vector-set!.147
                                                          tmp.17.82
                                                          5
                                                          6)))
                                                    (if (closure-call
                                                         error?.148
                                                         error?.148
                                                         g42974356.88)
                                                      g42974356.88
                                                      (let ((g42974357.89
                                                             (closure-call
                                                              vector-set!.147
                                                              vector-set!.147
                                                              tmp.17.82
                                                              6
                                                              7)))
                                                        (if (closure-call
                                                             error?.148
                                                             error?.148
                                                             g42974357.89)
                                                          g42974357.89
                                                          (let ((g42974358.90
                                                                 (closure-call
                                                                  vector-set!.147
                                                                  vector-set!.147
                                                                  tmp.17.82
                                                                  7
                                                                  8)))
                                                            (if (closure-call
                                                                 error?.148
                                                                 error?.148
                                                                 g42974358.90)
                                                              g42974358.90
                                                              tmp.17.82))))))))))))))))))
                           (error2.79 (error 86)))
                       (void))
                     (closure-call fun/void8713.22 fun/void8713.22))
                 (let ((tmp.18.91 (if #f (void) (void))))
                   (if tmp.18.91
                     tmp.18.91
                     (let ((tmp.19.92
                            (closure-call fun/void8714.21 fun/void8714.21)))
                       (if tmp.19.92
                         tmp.19.92
                         (let ((fixnum0.94 202) (error1.93 (error 86)))
                           (void))))))
                 #f)
               #f)
             #f)
           #f)
         #f)))))
(check-by-interp
 '(module
    (letrec ((L.cons.64.10
              (lambda (c.65 tmp.59 tmp.60) (let () (cons tmp.59 tmp.60))))
             (L.fun/boolean8722.7.11 (lambda (c.66) (let () #t)))
             (L.fun/fixnum8721.8.12
              (lambda (c.67)
                (let ((cons.64 (closure-ref c.67 0))
                      (fun/boolean8722.7 (closure-ref c.67 1)))
                  (if (closure-call fun/boolean8722.7 fun/boolean8722.7)
                    (let ((empty0.9 empty)) 242)
                    (let ((pair0.11
                           (closure-call
                            cons.64
                            cons.64
                            87
                            (closure-call cons.64 cons.64 424 empty)))
                          (fixnum1.10 124))
                      132))))))
      (cletrec
       ((cons.64 (make-closure L.cons.64.10 2))
        (fun/boolean8722.7 (make-closure L.fun/boolean8722.7.11 0))
        (fun/fixnum8721.8
         (make-closure L.fun/fixnum8721.8.12 0 cons.64 fun/boolean8722.7)))
       (closure-call fun/fixnum8721.8 fun/fixnum8721.8)))))
(check-by-interp
 '(module
    (letrec ((L.unsafe-vector-ref.6.10
              (lambda (c.81 tmp.35 tmp.36)
                (let ()
                  (if (unsafe-fx< tmp.36 (unsafe-vector-length tmp.35))
                    (if (unsafe-fx>= tmp.36 0)
                      (unsafe-vector-ref tmp.35 tmp.36)
                      (error 11))
                    (error 11)))))
             (L.vector-ref.79.11
              (lambda (c.82 tmp.57 tmp.58)
                (let ((unsafe-vector-ref.6 (closure-ref c.82 0)))
                  (if (fixnum? tmp.58)
                    (if (vector? tmp.57)
                      (closure-call
                       unsafe-vector-ref.6
                       unsafe-vector-ref.6
                       tmp.57
                       tmp.58)
                      (error 11))
                    (error 11)))))
             (L.unsafe-vector-set!.5.12
              (lambda (c.83 tmp.30 tmp.31 tmp.32)
                (let ()
                  (if (unsafe-fx< tmp.31 (unsafe-vector-length tmp.30))
                    (if (unsafe-fx>= tmp.31 0)
                      (begin (unsafe-vector-set! tmp.30 tmp.31 tmp.32) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.78.13
              (lambda (c.84 tmp.54 tmp.55 tmp.56)
                (let ((unsafe-vector-set!.5 (closure-ref c.84 0)))
                  (if (fixnum? tmp.55)
                    (if (vector? tmp.54)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.54
                       tmp.55
                       tmp.56)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.26.14
              (lambda (c.85 len.27 i.29 vec.28)
                (let ((vector-init-loop.26 (closure-ref c.85 0)))
                  (if (eq? len.27 i.29)
                    vec.28
                    (begin
                      (unsafe-vector-set! vec.28 i.29 0)
                      (closure-call
                       vector-init-loop.26
                       vector-init-loop.26
                       len.27
                       (unsafe-fx+ i.29 1)
                       vec.28))))))
             (L.make-init-vector.4.15
              (lambda (c.86 tmp.24)
                (let ((vector-init-loop.26 (closure-ref c.86 0)))
                  (let ((tmp.25 (unsafe-make-vector tmp.24)))
                    (closure-call
                     vector-init-loop.26
                     vector-init-loop.26
                     tmp.24
                     0
                     tmp.25)))))
             (L.make-vector.77.16
              (lambda (c.87 tmp.52)
                (let ((make-init-vector.4 (closure-ref c.87 0)))
                  (if (fixnum? tmp.52)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.52)
                    (error 8)))))
             (L.error?.76.17 (lambda (c.88 tmp.66) (let () (error? tmp.66))))
             (L.fun/ascii-char8726.8.18
              (lambda (c.89) (let () (if #t #\H #\a))))
             (L.fun/ascii-char8725.9.19 (lambda (c.90) (let () #\s))))
      (cletrec
       ((unsafe-vector-ref.6 (make-closure L.unsafe-vector-ref.6.10 2))
        (vector-ref.79 (make-closure L.vector-ref.79.11 2 unsafe-vector-ref.6))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.12 3))
        (vector-set!.78
         (make-closure L.vector-set!.78.13 3 unsafe-vector-set!.5))
        (vector-init-loop.26
         (make-closure L.vector-init-loop.26.14 3 vector-init-loop.26))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.15 1 vector-init-loop.26))
        (make-vector.77
         (make-closure L.make-vector.77.16 1 make-init-vector.4))
        (error?.76 (make-closure L.error?.76.17 1))
        (fun/ascii-char8726.8 (make-closure L.fun/ascii-char8726.8.18 0))
        (fun/ascii-char8725.9 (make-closure L.fun/ascii-char8725.9.19 0)))
       (let ((g42981987.10
              (let ((g42981988.11
                     (closure-call fun/ascii-char8725.9 fun/ascii-char8725.9)))
                (if (closure-call error?.76 error?.76 g42981988.11)
                  g42981988.11
                  (let ((g42981989.12 (if #f #\k #\i)))
                    (if (closure-call error?.76 error?.76 g42981989.12)
                      g42981989.12
                      (if #t #\C #\E)))))))
         (if (closure-call error?.76 error?.76 g42981987.10)
           g42981987.10
           (let ((g42981990.13
                  (closure-call fun/ascii-char8726.8 fun/ascii-char8726.8)))
             (if (closure-call error?.76 error?.76 g42981990.13)
               g42981990.13
               (let ((vector0.14
                      (let ((tmp.7.15
                             (closure-call make-vector.77 make-vector.77 8)))
                        (let ((g42981991.16
                               (closure-call
                                vector-set!.78
                                vector-set!.78
                                tmp.7.15
                                0
                                (closure-call
                                 make-vector.77
                                 make-vector.77
                                 8))))
                          (if (closure-call error?.76 error?.76 g42981991.16)
                            g42981991.16
                            (let ((g42981992.17
                                   (closure-call
                                    vector-set!.78
                                    vector-set!.78
                                    tmp.7.15
                                    1
                                    #\\)))
                              (if (closure-call
                                   error?.76
                                   error?.76
                                   g42981992.17)
                                g42981992.17
                                (let ((g42981993.18
                                       (closure-call
                                        vector-set!.78
                                        vector-set!.78
                                        tmp.7.15
                                        2
                                        (letrec ((L.lam.80.20
                                                  (lambda (c.91)
                                                    (let () 1020))))
                                          (cletrec
                                           ((lam.80
                                             (make-closure L.lam.80.20 0)))
                                           lam.80)))))
                                  (if (closure-call
                                       error?.76
                                       error?.76
                                       g42981993.18)
                                    g42981993.18
                                    (let ((g42981994.19
                                           (closure-call
                                            vector-set!.78
                                            vector-set!.78
                                            tmp.7.15
                                            3
                                            231)))
                                      (if (closure-call
                                           error?.76
                                           error?.76
                                           g42981994.19)
                                        g42981994.19
                                        (let ((g42981995.20
                                               (closure-call
                                                vector-set!.78
                                                vector-set!.78
                                                tmp.7.15
                                                4
                                                (void))))
                                          (if (closure-call
                                               error?.76
                                               error?.76
                                               g42981995.20)
                                            g42981995.20
                                            (let ((g42981996.21
                                                   (closure-call
                                                    vector-set!.78
                                                    vector-set!.78
                                                    tmp.7.15
                                                    5
                                                    #\o)))
                                              (if (closure-call
                                                   error?.76
                                                   error?.76
                                                   g42981996.21)
                                                g42981996.21
                                                (let ((g42981997.22
                                                       (closure-call
                                                        vector-set!.78
                                                        vector-set!.78
                                                        tmp.7.15
                                                        6
                                                        212)))
                                                  (if (closure-call
                                                       error?.76
                                                       error?.76
                                                       g42981997.22)
                                                    g42981997.22
                                                    (let ((g42981998.23
                                                           (closure-call
                                                            vector-set!.78
                                                            vector-set!.78
                                                            tmp.7.15
                                                            7
                                                            (error 79))))
                                                      (if (closure-call
                                                           error?.76
                                                           error?.76
                                                           g42981998.23)
                                                        g42981998.23
                                                        tmp.7.15)))))))))))))))))))
                 (closure-call
                  vector-ref.79
                  vector-ref.79
                  vector0.14
                  5))))))))))
(check-by-interp
 '(module
    (letrec ((L.pair?.129.10 (lambda (c.132 tmp.116) (let () (pair? tmp.116))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.133 tmp.79 tmp.80 tmp.81)
                (let ()
                  (if (unsafe-fx< tmp.80 (unsafe-vector-length tmp.79))
                    (if (unsafe-fx>= tmp.80 0)
                      (begin (unsafe-vector-set! tmp.79 tmp.80 tmp.81) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.128.12
              (lambda (c.134 tmp.103 tmp.104 tmp.105)
                (let ((unsafe-vector-set!.5 (closure-ref c.134 0)))
                  (if (fixnum? tmp.104)
                    (if (vector? tmp.103)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.103
                       tmp.104
                       tmp.105)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.75.13
              (lambda (c.135 len.76 i.78 vec.77)
                (let ((vector-init-loop.75 (closure-ref c.135 0)))
                  (if (eq? len.76 i.78)
                    vec.77
                    (begin
                      (unsafe-vector-set! vec.77 i.78 0)
                      (closure-call
                       vector-init-loop.75
                       vector-init-loop.75
                       len.76
                       (unsafe-fx+ i.78 1)
                       vec.77))))))
             (L.make-init-vector.4.14
              (lambda (c.136 tmp.73)
                (let ((vector-init-loop.75 (closure-ref c.136 0)))
                  (let ((tmp.74 (unsafe-make-vector tmp.73)))
                    (closure-call
                     vector-init-loop.75
                     vector-init-loop.75
                     tmp.73
                     0
                     tmp.74)))))
             (L.make-vector.127.15
              (lambda (c.137 tmp.101)
                (let ((make-init-vector.4 (closure-ref c.137 0)))
                  (if (fixnum? tmp.101)
                    (closure-call
                     make-init-vector.4
                     make-init-vector.4
                     tmp.101)
                    (error 8)))))
             (L.error?.126.16
              (lambda (c.138 tmp.115) (let () (error? tmp.115))))
             (L.cons.125.17
              (lambda (c.139 tmp.120 tmp.121) (let () (cons tmp.120 tmp.121))))
             (L.fun/empty8731.21.18 (lambda (c.140) (let () empty)))
             (L.fun/pair8730.22.19
              (lambda (c.141)
                (let ((cons.125 (closure-ref c.141 0)))
                  (if #t
                    (closure-call
                     cons.125
                     cons.125
                     220
                     (closure-call cons.125 cons.125 397 empty))
                    (closure-call
                     cons.125
                     cons.125
                     228
                     (closure-call cons.125 cons.125 458 empty))))))
             (L.fun/empty8729.23.20
              (lambda (c.142 oprand0.25 oprand1.24)
                (let () (if #f empty empty)))))
      (cletrec
       ((pair?.129 (make-closure L.pair?.129.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.128
         (make-closure L.vector-set!.128.12 3 unsafe-vector-set!.5))
        (vector-init-loop.75
         (make-closure L.vector-init-loop.75.13 3 vector-init-loop.75))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.75))
        (make-vector.127
         (make-closure L.make-vector.127.15 1 make-init-vector.4))
        (error?.126 (make-closure L.error?.126.16 1))
        (cons.125 (make-closure L.cons.125.17 2))
        (fun/empty8731.21 (make-closure L.fun/empty8731.21.18 0))
        (fun/pair8730.22 (make-closure L.fun/pair8730.22.19 0 cons.125))
        (fun/empty8729.23 (make-closure L.fun/empty8729.23.20 2)))
       (let ((tmp.7.26
              (let ()
                (let ((g42985819.27 empty))
                  (if (closure-call error?.126 error?.126 g42985819.27)
                    g42985819.27
                    empty)))))
         (if tmp.7.26
           tmp.7.26
           (let ((tmp.8.28
                  (closure-call
                   fun/empty8729.23
                   fun/empty8729.23
                   (closure-call fun/pair8730.22 fun/pair8730.22)
                   (let () (error 128)))))
             (if tmp.8.28
               tmp.8.28
               (let ((tmp.9.29
                      (let ((vector0.32
                             (let ((tmp.10.33
                                    (closure-call
                                     make-vector.127
                                     make-vector.127
                                     8)))
                               (let ((g42985820.34
                                      (closure-call
                                       vector-set!.128
                                       vector-set!.128
                                       tmp.10.33
                                       0
                                       (let ((tmp.11.35
                                              (closure-call
                                               make-vector.127
                                               make-vector.127
                                               8)))
                                         (let ((g42985821.36
                                                (closure-call
                                                 vector-set!.128
                                                 vector-set!.128
                                                 tmp.11.35
                                                 0
                                                 1)))
                                           (if (closure-call
                                                error?.126
                                                error?.126
                                                g42985821.36)
                                             g42985821.36
                                             (let ((g42985822.37
                                                    (closure-call
                                                     vector-set!.128
                                                     vector-set!.128
                                                     tmp.11.35
                                                     1
                                                     2)))
                                               (if (closure-call
                                                    error?.126
                                                    error?.126
                                                    g42985822.37)
                                                 g42985822.37
                                                 (let ((g42985823.38
                                                        (closure-call
                                                         vector-set!.128
                                                         vector-set!.128
                                                         tmp.11.35
                                                         2
                                                         3)))
                                                   (if (closure-call
                                                        error?.126
                                                        error?.126
                                                        g42985823.38)
                                                     g42985823.38
                                                     (let ((g42985824.39
                                                            (closure-call
                                                             vector-set!.128
                                                             vector-set!.128
                                                             tmp.11.35
                                                             3
                                                             4)))
                                                       (if (closure-call
                                                            error?.126
                                                            error?.126
                                                            g42985824.39)
                                                         g42985824.39
                                                         (let ((g42985825.40
                                                                (closure-call
                                                                 vector-set!.128
                                                                 vector-set!.128
                                                                 tmp.11.35
                                                                 4
                                                                 5)))
                                                           (if (closure-call
                                                                error?.126
                                                                error?.126
                                                                g42985825.40)
                                                             g42985825.40
                                                             (let ((g42985826.41
                                                                    (closure-call
                                                                     vector-set!.128
                                                                     vector-set!.128
                                                                     tmp.11.35
                                                                     5
                                                                     6)))
                                                               (if (closure-call
                                                                    error?.126
                                                                    error?.126
                                                                    g42985826.41)
                                                                 g42985826.41
                                                                 (let ((g42985827.42
                                                                        (closure-call
                                                                         vector-set!.128
                                                                         vector-set!.128
                                                                         tmp.11.35
                                                                         6
                                                                         7)))
                                                                   (if (closure-call
                                                                        error?.126
                                                                        error?.126
                                                                        g42985827.42)
                                                                     g42985827.42
                                                                     (let ((g42985828.43
                                                                            (closure-call
                                                                             vector-set!.128
                                                                             vector-set!.128
                                                                             tmp.11.35
                                                                             7
                                                                             8)))
                                                                       (if (closure-call
                                                                            error?.126
                                                                            error?.126
                                                                            g42985828.43)
                                                                         g42985828.43
                                                                         tmp.11.35))))))))))))))))))))
                                 (if (closure-call
                                      error?.126
                                      error?.126
                                      g42985820.34)
                                   g42985820.34
                                   (let ((g42985829.44
                                          (closure-call
                                           vector-set!.128
                                           vector-set!.128
                                           tmp.10.33
                                           1
                                           #t)))
                                     (if (closure-call
                                          error?.126
                                          error?.126
                                          g42985829.44)
                                       g42985829.44
                                       (let ((g42985830.45
                                              (closure-call
                                               vector-set!.128
                                               vector-set!.128
                                               tmp.10.33
                                               2
                                               (error 169))))
                                         (if (closure-call
                                              error?.126
                                              error?.126
                                              g42985830.45)
                                           g42985830.45
                                           (let ((g42985831.46
                                                  (closure-call
                                                   vector-set!.128
                                                   vector-set!.128
                                                   tmp.10.33
                                                   3
                                                   (void))))
                                             (if (closure-call
                                                  error?.126
                                                  error?.126
                                                  g42985831.46)
                                               g42985831.46
                                               (let ((g42985832.47
                                                      (closure-call
                                                       vector-set!.128
                                                       vector-set!.128
                                                       tmp.10.33
                                                       4
                                                       31)))
                                                 (if (closure-call
                                                      error?.126
                                                      error?.126
                                                      g42985832.47)
                                                   g42985832.47
                                                   (let ((g42985833.48
                                                          (closure-call
                                                           vector-set!.128
                                                           vector-set!.128
                                                           tmp.10.33
                                                           5
                                                           (error 119))))
                                                     (if (closure-call
                                                          error?.126
                                                          error?.126
                                                          g42985833.48)
                                                       g42985833.48
                                                       (let ((g42985834.49
                                                              (closure-call
                                                               vector-set!.128
                                                               vector-set!.128
                                                               tmp.10.33
                                                               6
                                                               (letrec ((L.lam.130.21
                                                                         (lambda (c.143)
                                                                           (let ()
                                                                             773))))
                                                                 (cletrec
                                                                  ((lam.130
                                                                    (make-closure
                                                                     L.lam.130.21
                                                                     0)))
                                                                  lam.130)))))
                                                         (if (closure-call
                                                              error?.126
                                                              error?.126
                                                              g42985834.49)
                                                           g42985834.49
                                                           (let ((g42985835.50
                                                                  (closure-call
                                                                   vector-set!.128
                                                                   vector-set!.128
                                                                   tmp.10.33
                                                                   7
                                                                   (void))))
                                                             (if (closure-call
                                                                  error?.126
                                                                  error?.126
                                                                  g42985835.50)
                                                               g42985835.50
                                                               tmp.10.33))))))))))))))))))
                            (procedure1.31
                             (letrec ((L.lam.131.22
                                       (lambda (c.144)
                                         (let () (let () empty)))))
                               (cletrec
                                ((lam.131 (make-closure L.lam.131.22 0)))
                                lam.131)))
                            (empty2.30 (let () empty)))
                        (closure-call fun/empty8731.21 fun/empty8731.21))))
                 (if tmp.9.29
                   tmp.9.29
                   (let ((tmp.12.51
                          (if (let ((error0.54 (error 40))
                                    (vector1.53
                                     (let ((tmp.13.55
                                            (closure-call
                                             make-vector.127
                                             make-vector.127
                                             8)))
                                       (let ((g42985836.56
                                              (closure-call
                                               vector-set!.128
                                               vector-set!.128
                                               tmp.13.55
                                               0
                                               1)))
                                         (if (closure-call
                                              error?.126
                                              error?.126
                                              g42985836.56)
                                           g42985836.56
                                           (let ((g42985837.57
                                                  (closure-call
                                                   vector-set!.128
                                                   vector-set!.128
                                                   tmp.13.55
                                                   1
                                                   2)))
                                             (if (closure-call
                                                  error?.126
                                                  error?.126
                                                  g42985837.57)
                                               g42985837.57
                                               (let ((g42985838.58
                                                      (closure-call
                                                       vector-set!.128
                                                       vector-set!.128
                                                       tmp.13.55
                                                       2
                                                       3)))
                                                 (if (closure-call
                                                      error?.126
                                                      error?.126
                                                      g42985838.58)
                                                   g42985838.58
                                                   (let ((g42985839.59
                                                          (closure-call
                                                           vector-set!.128
                                                           vector-set!.128
                                                           tmp.13.55
                                                           3
                                                           4)))
                                                     (if (closure-call
                                                          error?.126
                                                          error?.126
                                                          g42985839.59)
                                                       g42985839.59
                                                       (let ((g42985840.60
                                                              (closure-call
                                                               vector-set!.128
                                                               vector-set!.128
                                                               tmp.13.55
                                                               4
                                                               5)))
                                                         (if (closure-call
                                                              error?.126
                                                              error?.126
                                                              g42985840.60)
                                                           g42985840.60
                                                           (let ((g42985841.61
                                                                  (closure-call
                                                                   vector-set!.128
                                                                   vector-set!.128
                                                                   tmp.13.55
                                                                   5
                                                                   6)))
                                                             (if (closure-call
                                                                  error?.126
                                                                  error?.126
                                                                  g42985841.61)
                                                               g42985841.61
                                                               (let ((g42985842.62
                                                                      (closure-call
                                                                       vector-set!.128
                                                                       vector-set!.128
                                                                       tmp.13.55
                                                                       6
                                                                       7)))
                                                                 (if (closure-call
                                                                      error?.126
                                                                      error?.126
                                                                      g42985842.62)
                                                                   g42985842.62
                                                                   (let ((g42985843.63
                                                                          (closure-call
                                                                           vector-set!.128
                                                                           vector-set!.128
                                                                           tmp.13.55
                                                                           7
                                                                           8)))
                                                                     (if (closure-call
                                                                          error?.126
                                                                          error?.126
                                                                          g42985843.63)
                                                                       g42985843.63
                                                                       tmp.13.55))))))))))))))))))
                                    (boolean2.52 #t))
                                #t)
                            (let ((tmp.14.64 empty))
                              (if tmp.14.64
                                tmp.14.64
                                (let ((tmp.15.65 empty))
                                  (if tmp.15.65
                                    tmp.15.65
                                    (let ((tmp.16.66 empty))
                                      (if tmp.16.66
                                        tmp.16.66
                                        (let ((tmp.17.67 empty))
                                          (if tmp.17.67
                                            tmp.17.67
                                            (let ((tmp.18.68 empty))
                                              (if tmp.18.68
                                                tmp.18.68
                                                (let ((tmp.19.69 empty))
                                                  (if tmp.19.69
                                                    tmp.19.69
                                                    empty))))))))))))
                            (let ((g42985844.70 empty))
                              (if (closure-call
                                   error?.126
                                   error?.126
                                   g42985844.70)
                                g42985844.70
                                (let ((g42985845.71 empty))
                                  (if (closure-call
                                       error?.126
                                       error?.126
                                       g42985845.71)
                                    g42985845.71
                                    empty)))))))
                     (if tmp.12.51
                       tmp.12.51
                       (let ((tmp.20.72
                              (if (closure-call
                                   pair?.129
                                   pair?.129
                                   (closure-call
                                    cons.125
                                    cons.125
                                    61
                                    (closure-call
                                     cons.125
                                     cons.125
                                     385
                                     empty)))
                                (if #t empty empty)
                                empty)))
                         (if tmp.20.72
                           tmp.20.72
                           (let () (if #f empty empty))))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.fun/error8736.7.10
              (lambda (c.67)
                (let ((fun/error8737.9 (closure-ref c.67 0)))
                  (closure-call fun/error8737.9 fun/error8737.9))))
             (L.fun/boolean8735.8.11 (lambda (c.68) (let () #f)))
             (L.fun/error8737.9.12 (lambda (c.69) (let () (error 242))))
             (L.fun/boolean8734.10.13
              (lambda (c.70)
                (let ((fun/boolean8735.8 (closure-ref c.70 0)))
                  (closure-call fun/boolean8735.8 fun/boolean8735.8)))))
      (cletrec
       ((fun/error8736.7 (make-closure L.fun/error8736.7.10 0 fun/error8737.9))
        (fun/boolean8735.8 (make-closure L.fun/boolean8735.8.11 0))
        (fun/error8737.9 (make-closure L.fun/error8737.9.12 0))
        (fun/boolean8734.10
         (make-closure L.fun/boolean8734.10.13 0 fun/boolean8735.8)))
       (let ((procedure0.13
              (letrec ((L.lam.66.14 (lambda (c.71) (let () (let () #t)))))
                (cletrec ((lam.66 (make-closure L.lam.66.14 0))) lam.66)))
             (boolean1.12 (closure-call fun/boolean8734.10 fun/boolean8734.10))
             (ascii-char2.11 (if #t #\z #\u)))
         (closure-call fun/error8736.7 fun/error8736.7))))))
(check-by-interp
 '(module
    (letrec ((L.error?.82.10 (lambda (c.83 tmp.72) (let () (error? tmp.72))))
             (L.fun/void8741.11.11 (lambda (c.84) (let () (void))))
             (L.fun/void8740.12.12
              (lambda (c.85 oprand0.14 oprand1.13) (let () (void)))))
      (cletrec
       ((error?.82 (make-closure L.error?.82.10 1))
        (fun/void8741.11 (make-closure L.fun/void8741.11.11 0))
        (fun/void8740.12 (make-closure L.fun/void8740.12.12 2)))
       (let ()
         (let ((g42993474.15
                (closure-call fun/void8740.12 fun/void8740.12 191 72)))
           (if (closure-call error?.82 error?.82 g42993474.15)
             g42993474.15
             (let ((g42993475.16
                    (let ((g42993476.17 (void)))
                      (if (closure-call error?.82 error?.82 g42993476.17)
                        g42993476.17
                        (let ((g42993477.18 (void)))
                          (if (closure-call error?.82 error?.82 g42993477.18)
                            g42993477.18
                            (let ((g42993478.19 (void)))
                              (if (closure-call
                                   error?.82
                                   error?.82
                                   g42993478.19)
                                g42993478.19
                                (let ((g42993479.20 (void)))
                                  (if (closure-call
                                       error?.82
                                       error?.82
                                       g42993479.20)
                                    g42993479.20
                                    (let ((g42993480.21 (void)))
                                      (if (closure-call
                                           error?.82
                                           error?.82
                                           g42993480.21)
                                        g42993480.21
                                        (void)))))))))))))
               (if (closure-call error?.82 error?.82 g42993475.16)
                 g42993475.16
                 (let ((g42993481.22
                        (closure-call fun/void8741.11 fun/void8741.11)))
                   (if (closure-call error?.82 error?.82 g42993481.22)
                     g42993481.22
                     (let ((g42993482.23 (let () (void))))
                       (if (closure-call error?.82 error?.82 g42993482.23)
                         g42993482.23
                         (let ((g42993483.24
                                (let ((tmp.7.25 (void)))
                                  (if tmp.7.25
                                    tmp.7.25
                                    (let ((tmp.8.26 (void)))
                                      (if tmp.8.26
                                        tmp.8.26
                                        (let ((tmp.9.27 (void)))
                                          (if tmp.9.27
                                            tmp.9.27
                                            (let ((tmp.10.28 (void)))
                                              (if tmp.10.28
                                                tmp.10.28
                                                (void)))))))))))
                           (if (closure-call error?.82 error?.82 g42993483.24)
                             g42993483.24
                             (let ((fixnum0.29 189)) (void)))))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.+.80.10
              (lambda (c.81 tmp.41 tmp.42)
                (let ()
                  (if (fixnum? tmp.42)
                    (if (fixnum? tmp.41) (unsafe-fx+ tmp.41 tmp.42) (error 2))
                    (error 2)))))
             (L.error?.79.11 (lambda (c.82 tmp.67) (let () (error? tmp.67))))
             (L.unsafe-vector-set!.5.12
              (lambda (c.83 tmp.31 tmp.32 tmp.33)
                (let ()
                  (if (unsafe-fx< tmp.32 (unsafe-vector-length tmp.31))
                    (if (unsafe-fx>= tmp.32 0)
                      (begin (unsafe-vector-set! tmp.31 tmp.32 tmp.33) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.78.13
              (lambda (c.84 tmp.55 tmp.56 tmp.57)
                (let ((unsafe-vector-set!.5 (closure-ref c.84 0)))
                  (if (fixnum? tmp.56)
                    (if (vector? tmp.55)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.55
                       tmp.56
                       tmp.57)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.27.14
              (lambda (c.85 len.28 i.30 vec.29)
                (let ((vector-init-loop.27 (closure-ref c.85 0)))
                  (if (eq? len.28 i.30)
                    vec.29
                    (begin
                      (unsafe-vector-set! vec.29 i.30 0)
                      (closure-call
                       vector-init-loop.27
                       vector-init-loop.27
                       len.28
                       (unsafe-fx+ i.30 1)
                       vec.29))))))
             (L.make-init-vector.4.15
              (lambda (c.86 tmp.25)
                (let ((vector-init-loop.27 (closure-ref c.86 0)))
                  (let ((tmp.26 (unsafe-make-vector tmp.25)))
                    (closure-call
                     vector-init-loop.27
                     vector-init-loop.27
                     tmp.25
                     0
                     tmp.26)))))
             (L.make-vector.77.16
              (lambda (c.87 tmp.53)
                (let ((make-init-vector.4 (closure-ref c.87 0)))
                  (if (fixnum? tmp.53)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.53)
                    (error 8)))))
             (L.fun/empty8745.8.17
              (lambda (c.88)
                (let ((fun/empty8746.11 (closure-ref c.88 0)))
                  (closure-call fun/empty8746.11 fun/empty8746.11))))
             (L.fun/empty8744.9.18
              (lambda (c.89 oprand0.13)
                (let ((fun/empty8745.8 (closure-ref c.89 0)))
                  (closure-call fun/empty8745.8 fun/empty8745.8))))
             (L.fun/vector8748.10.19
              (lambda (c.90)
                (let ((vector-set!.78 (closure-ref c.90 0))
                      (error?.79 (closure-ref c.90 1))
                      (make-vector.77 (closure-ref c.90 2)))
                  (let ((tmp.7.14
                         (closure-call make-vector.77 make-vector.77 8)))
                    (let ((g42997298.15
                           (closure-call
                            vector-set!.78
                            vector-set!.78
                            tmp.7.14
                            0
                            0)))
                      (if (closure-call error?.79 error?.79 g42997298.15)
                        g42997298.15
                        (let ((g42997299.16
                               (closure-call
                                vector-set!.78
                                vector-set!.78
                                tmp.7.14
                                1
                                1)))
                          (if (closure-call error?.79 error?.79 g42997299.16)
                            g42997299.16
                            (let ((g42997300.17
                                   (closure-call
                                    vector-set!.78
                                    vector-set!.78
                                    tmp.7.14
                                    2
                                    2)))
                              (if (closure-call
                                   error?.79
                                   error?.79
                                   g42997300.17)
                                g42997300.17
                                (let ((g42997301.18
                                       (closure-call
                                        vector-set!.78
                                        vector-set!.78
                                        tmp.7.14
                                        3
                                        3)))
                                  (if (closure-call
                                       error?.79
                                       error?.79
                                       g42997301.18)
                                    g42997301.18
                                    (let ((g42997302.19
                                           (closure-call
                                            vector-set!.78
                                            vector-set!.78
                                            tmp.7.14
                                            4
                                            4)))
                                      (if (closure-call
                                           error?.79
                                           error?.79
                                           g42997302.19)
                                        g42997302.19
                                        (let ((g42997303.20
                                               (closure-call
                                                vector-set!.78
                                                vector-set!.78
                                                tmp.7.14
                                                5
                                                5)))
                                          (if (closure-call
                                               error?.79
                                               error?.79
                                               g42997303.20)
                                            g42997303.20
                                            (let ((g42997304.21
                                                   (closure-call
                                                    vector-set!.78
                                                    vector-set!.78
                                                    tmp.7.14
                                                    6
                                                    6)))
                                              (if (closure-call
                                                   error?.79
                                                   error?.79
                                                   g42997304.21)
                                                g42997304.21
                                                (let ((g42997305.22
                                                       (closure-call
                                                        vector-set!.78
                                                        vector-set!.78
                                                        tmp.7.14
                                                        7
                                                        7)))
                                                  (if (closure-call
                                                       error?.79
                                                       error?.79
                                                       g42997305.22)
                                                    g42997305.22
                                                    tmp.7.14))))))))))))))))))))
             (L.fun/empty8746.11.20
              (lambda (c.91)
                (let ((fun/empty8747.12 (closure-ref c.91 0)))
                  (closure-call fun/empty8747.12 fun/empty8747.12))))
             (L.fun/empty8747.12.21 (lambda (c.92) (let () empty))))
      (cletrec
       ((|+.80| (make-closure L.+.80.10 2))
        (error?.79 (make-closure L.error?.79.11 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.12 3))
        (vector-set!.78
         (make-closure L.vector-set!.78.13 3 unsafe-vector-set!.5))
        (vector-init-loop.27
         (make-closure L.vector-init-loop.27.14 3 vector-init-loop.27))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.15 1 vector-init-loop.27))
        (make-vector.77
         (make-closure L.make-vector.77.16 1 make-init-vector.4))
        (fun/empty8745.8
         (make-closure L.fun/empty8745.8.17 0 fun/empty8746.11))
        (fun/empty8744.9 (make-closure L.fun/empty8744.9.18 1 fun/empty8745.8))
        (fun/vector8748.10
         (make-closure
          L.fun/vector8748.10.19
          0
          vector-set!.78
          error?.79
          make-vector.77))
        (fun/empty8746.11
         (make-closure L.fun/empty8746.11.20 0 fun/empty8747.12))
        (fun/empty8747.12 (make-closure L.fun/empty8747.12.21 0)))
       (closure-call
        fun/empty8744.9
        fun/empty8744.9
        (let ((fixnum0.24 (closure-call |+.80| |+.80| 209 230))
              (fixnum1.23 (let () 196)))
          (closure-call fun/vector8748.10 fun/vector8748.10)))))))
(check-by-interp '(module (let () (if #f (void) (void)))))
(check-by-interp
 '(module
    (letrec ((L.error?.80.10 (lambda (c.82 tmp.69) (let () (error? tmp.69))))
             (L.ascii-char?.79.11
              (lambda (c.83 tmp.68) (let () (ascii-char? tmp.68))))
             (L.fun/boolean8753.10.12 (lambda (c.84 oprand0.11) (let () #t))))
      (cletrec
       ((error?.80 (make-closure L.error?.80.10 1))
        (ascii-char?.79 (make-closure L.ascii-char?.79.11 1))
        (fun/boolean8753.10 (make-closure L.fun/boolean8753.10.12 1)))
       (if (let ((ascii-char0.14 #\q) (void1.13 (void)) (boolean2.12 #t)) #t)
         (let ((empty0.17 empty) (fixnum1.16 19) (boolean2.15 #f)) #t)
         (let ((tmp.7.18
                (closure-call
                 ascii-char?.79
                 ascii-char?.79
                 (letrec ((L.lam.81.13 (lambda (c.85) (let () 526))))
                   (cletrec ((lam.81 (make-closure L.lam.81.13 0))) lam.81)))))
           (if tmp.7.18
             tmp.7.18
             (let ((tmp.8.19 (if #f #t #t)))
               (if tmp.8.19
                 tmp.8.19
                 (let ((tmp.9.20
                        (closure-call
                         fun/boolean8753.10
                         fun/boolean8753.10
                         195)))
                   (if tmp.9.20
                     tmp.9.20
                     (let ((g43004938.21 #f))
                       (if (closure-call error?.80 error?.80 g43004938.21)
                         g43004938.21
                         (let ((g43004939.22 #f))
                           (if (closure-call error?.80 error?.80 g43004939.22)
                             g43004939.22
                             (let ((g43004940.23 #t))
                               (if (closure-call
                                    error?.80
                                    error?.80
                                    g43004940.23)
                                 g43004940.23
                                 (let ((g43004941.24 #t))
                                   (if (closure-call
                                        error?.80
                                        error?.80
                                        g43004941.24)
                                     g43004941.24
                                     (let ((g43004942.25 #t))
                                       (if (closure-call
                                            error?.80
                                            error?.80
                                            g43004942.25)
                                         g43004942.25
                                         (let ((g43004943.26 #t))
                                           (if (closure-call
                                                error?.80
                                                error?.80
                                                g43004943.26)
                                             g43004943.26
                                             #f)))))))))))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.>=.79.10
              (lambda (c.80 tmp.50 tmp.51)
                (let ()
                  (if (fixnum? tmp.51)
                    (if (fixnum? tmp.50) (unsafe-fx>= tmp.50 tmp.51) (error 7))
                    (error 7)))))
             (L.error?.78.11 (lambda (c.81 tmp.66) (let () (error? tmp.66))))
             (L.unsafe-vector-set!.5.12
              (lambda (c.82 tmp.30 tmp.31 tmp.32)
                (let ()
                  (if (unsafe-fx< tmp.31 (unsafe-vector-length tmp.30))
                    (if (unsafe-fx>= tmp.31 0)
                      (begin (unsafe-vector-set! tmp.30 tmp.31 tmp.32) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.77.13
              (lambda (c.83 tmp.54 tmp.55 tmp.56)
                (let ((unsafe-vector-set!.5 (closure-ref c.83 0)))
                  (if (fixnum? tmp.55)
                    (if (vector? tmp.54)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.54
                       tmp.55
                       tmp.56)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.26.14
              (lambda (c.84 len.27 i.29 vec.28)
                (let ((vector-init-loop.26 (closure-ref c.84 0)))
                  (if (eq? len.27 i.29)
                    vec.28
                    (begin
                      (unsafe-vector-set! vec.28 i.29 0)
                      (closure-call
                       vector-init-loop.26
                       vector-init-loop.26
                       len.27
                       (unsafe-fx+ i.29 1)
                       vec.28))))))
             (L.make-init-vector.4.15
              (lambda (c.85 tmp.24)
                (let ((vector-init-loop.26 (closure-ref c.85 0)))
                  (let ((tmp.25 (unsafe-make-vector tmp.24)))
                    (closure-call
                     vector-init-loop.26
                     vector-init-loop.26
                     tmp.24
                     0
                     tmp.25)))))
             (L.make-vector.76.16
              (lambda (c.86 tmp.52)
                (let ((make-init-vector.4 (closure-ref c.86 0)))
                  (if (fixnum? tmp.52)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.52)
                    (error 8)))))
             (L.fun/boolean8757.8.17 (lambda (c.87) (let () #f)))
             (L.fun/boolean8756.9.18
              (lambda (c.88 oprand0.11 oprand1.10)
                (let ((fun/boolean8757.8 (closure-ref c.88 0)))
                  (closure-call fun/boolean8757.8 fun/boolean8757.8)))))
      (cletrec
       ((>=.79 (make-closure L.>=.79.10 2))
        (error?.78 (make-closure L.error?.78.11 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.12 3))
        (vector-set!.77
         (make-closure L.vector-set!.77.13 3 unsafe-vector-set!.5))
        (vector-init-loop.26
         (make-closure L.vector-init-loop.26.14 3 vector-init-loop.26))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.15 1 vector-init-loop.26))
        (make-vector.76
         (make-closure L.make-vector.76.16 1 make-init-vector.4))
        (fun/boolean8757.8 (make-closure L.fun/boolean8757.8.17 0))
        (fun/boolean8756.9
         (make-closure L.fun/boolean8756.9.18 2 fun/boolean8757.8)))
       (if (closure-call
            fun/boolean8756.9
            fun/boolean8756.9
            (let ((void0.12 (void)))
              (let ((tmp.7.13 (closure-call make-vector.76 make-vector.76 8)))
                (let ((g43008758.14
                       (closure-call
                        vector-set!.77
                        vector-set!.77
                        tmp.7.13
                        0
                        1)))
                  (if (closure-call error?.78 error?.78 g43008758.14)
                    g43008758.14
                    (let ((g43008759.15
                           (closure-call
                            vector-set!.77
                            vector-set!.77
                            tmp.7.13
                            1
                            2)))
                      (if (closure-call error?.78 error?.78 g43008759.15)
                        g43008759.15
                        (let ((g43008760.16
                               (closure-call
                                vector-set!.77
                                vector-set!.77
                                tmp.7.13
                                2
                                3)))
                          (if (closure-call error?.78 error?.78 g43008760.16)
                            g43008760.16
                            (let ((g43008761.17
                                   (closure-call
                                    vector-set!.77
                                    vector-set!.77
                                    tmp.7.13
                                    3
                                    4)))
                              (if (closure-call
                                   error?.78
                                   error?.78
                                   g43008761.17)
                                g43008761.17
                                (let ((g43008762.18
                                       (closure-call
                                        vector-set!.77
                                        vector-set!.77
                                        tmp.7.13
                                        4
                                        5)))
                                  (if (closure-call
                                       error?.78
                                       error?.78
                                       g43008762.18)
                                    g43008762.18
                                    (let ((g43008763.19
                                           (closure-call
                                            vector-set!.77
                                            vector-set!.77
                                            tmp.7.13
                                            5
                                            6)))
                                      (if (closure-call
                                           error?.78
                                           error?.78
                                           g43008763.19)
                                        g43008763.19
                                        (let ((g43008764.20
                                               (closure-call
                                                vector-set!.77
                                                vector-set!.77
                                                tmp.7.13
                                                6
                                                7)))
                                          (if (closure-call
                                               error?.78
                                               error?.78
                                               g43008764.20)
                                            g43008764.20
                                            (let ((g43008765.21
                                                   (closure-call
                                                    vector-set!.77
                                                    vector-set!.77
                                                    tmp.7.13
                                                    7
                                                    8)))
                                              (if (closure-call
                                                   error?.78
                                                   error?.78
                                                   g43008765.21)
                                                g43008765.21
                                                tmp.7.13))))))))))))))))))
            (closure-call >=.79 >=.79 111 213))
         (if #t #\Q #\p)
         (let ((empty0.23 empty) (fixnum1.22 94)) #\l))))))
(check-by-interp
 '(module
    (letrec ((L.cons.69.10
              (lambda (c.70 tmp.64 tmp.65) (let () (cons tmp.64 tmp.65))))
             (L.fun/empty8761.9.11 (lambda (c.71) (let () empty)))
             (L.fun/empty8760.10.12 (lambda (c.72) (let () empty))))
      (cletrec
       ((cons.69 (make-closure L.cons.69.10 2))
        (fun/empty8761.9 (make-closure L.fun/empty8761.9.11 0))
        (fun/empty8760.10 (make-closure L.fun/empty8760.10.12 0)))
       (let ((empty0.12
              (let ((tmp.7.13
                     (closure-call fun/empty8760.10 fun/empty8760.10)))
                (if tmp.7.13
                  tmp.7.13
                  (let ((tmp.8.14 (if #t empty empty)))
                    (if tmp.8.14
                      tmp.8.14
                      (closure-call fun/empty8761.9 fun/empty8761.9))))))
             (empty1.11 (let () empty)))
         (if (let ((pair0.15
                    (closure-call
                     cons.69
                     cons.69
                     164
                     (closure-call cons.69 cons.69 328 empty))))
               #\Z)
           (if (if #\r (if #\Z (if #\j (if #\j #\^ #f) #f) #f) #f)
             (if (if #t #\V #\R) (let ((fixnum0.16 98)) #\X) #f)
             #f)
           #f))))))
(check-by-interp
 '(module
    (letrec ((L.error?.82.10 (lambda (c.85 tmp.70) (let () (error? tmp.70))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.86 tmp.34 tmp.35 tmp.36)
                (let ()
                  (if (unsafe-fx< tmp.35 (unsafe-vector-length tmp.34))
                    (if (unsafe-fx>= tmp.35 0)
                      (begin (unsafe-vector-set! tmp.34 tmp.35 tmp.36) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.81.12
              (lambda (c.87 tmp.58 tmp.59 tmp.60)
                (let ((unsafe-vector-set!.5 (closure-ref c.87 0)))
                  (if (fixnum? tmp.59)
                    (if (vector? tmp.58)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.58
                       tmp.59
                       tmp.60)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.30.13
              (lambda (c.88 len.31 i.33 vec.32)
                (let ((vector-init-loop.30 (closure-ref c.88 0)))
                  (if (eq? len.31 i.33)
                    vec.32
                    (begin
                      (unsafe-vector-set! vec.32 i.33 0)
                      (closure-call
                       vector-init-loop.30
                       vector-init-loop.30
                       len.31
                       (unsafe-fx+ i.33 1)
                       vec.32))))))
             (L.make-init-vector.4.14
              (lambda (c.89 tmp.28)
                (let ((vector-init-loop.30 (closure-ref c.89 0)))
                  (let ((tmp.29 (unsafe-make-vector tmp.28)))
                    (closure-call
                     vector-init-loop.30
                     vector-init-loop.30
                     tmp.28
                     0
                     tmp.29)))))
             (L.make-vector.80.15
              (lambda (c.90 tmp.56)
                (let ((make-init-vector.4 (closure-ref c.90 0)))
                  (if (fixnum? tmp.56)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.56)
                    (error 8)))))
             (L.fun/fixnum8766.9.16 (lambda (c.91 oprand0.12) (let () 66)))
             (L.fun/fixnum8765.10.17
              (lambda (c.92)
                (let ((fun/fixnum8766.9 (closure-ref c.92 0)))
                  (closure-call fun/fixnum8766.9 fun/fixnum8766.9 empty))))
             (L.fun/boolean8764.11.18
              (lambda (c.93 oprand0.14 oprand1.13) (let () (let () #f)))))
      (cletrec
       ((error?.82 (make-closure L.error?.82.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.81
         (make-closure L.vector-set!.81.12 3 unsafe-vector-set!.5))
        (vector-init-loop.30
         (make-closure L.vector-init-loop.30.13 3 vector-init-loop.30))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.30))
        (make-vector.80
         (make-closure L.make-vector.80.15 1 make-init-vector.4))
        (fun/fixnum8766.9 (make-closure L.fun/fixnum8766.9.16 1))
        (fun/fixnum8765.10
         (make-closure L.fun/fixnum8765.10.17 0 fun/fixnum8766.9))
        (fun/boolean8764.11 (make-closure L.fun/boolean8764.11.18 2)))
       (if (closure-call
            fun/boolean8764.11
            fun/boolean8764.11
            (let ((tmp.7.15
                   (letrec ((L.lam.83.19 (lambda (c.94) (let () 522))))
                     (cletrec
                      ((lam.83 (make-closure L.lam.83.19 0)))
                      lam.83))))
              (if tmp.7.15
                tmp.7.15
                (letrec ((L.lam.84.20 (lambda (c.95) (let () 662))))
                  (cletrec ((lam.84 (make-closure L.lam.84.20 0))) lam.84))))
            (let ((ascii-char0.16 #\z)) (void)))
         (let ((vector0.18
                (let ((tmp.8.19
                       (closure-call make-vector.80 make-vector.80 8)))
                  (let ((g43016397.20
                         (closure-call
                          vector-set!.81
                          vector-set!.81
                          tmp.8.19
                          0
                          1)))
                    (if (closure-call error?.82 error?.82 g43016397.20)
                      g43016397.20
                      (let ((g43016398.21
                             (closure-call
                              vector-set!.81
                              vector-set!.81
                              tmp.8.19
                              1
                              2)))
                        (if (closure-call error?.82 error?.82 g43016398.21)
                          g43016398.21
                          (let ((g43016399.22
                                 (closure-call
                                  vector-set!.81
                                  vector-set!.81
                                  tmp.8.19
                                  2
                                  3)))
                            (if (closure-call error?.82 error?.82 g43016399.22)
                              g43016399.22
                              (let ((g43016400.23
                                     (closure-call
                                      vector-set!.81
                                      vector-set!.81
                                      tmp.8.19
                                      3
                                      4)))
                                (if (closure-call
                                     error?.82
                                     error?.82
                                     g43016400.23)
                                  g43016400.23
                                  (let ((g43016401.24
                                         (closure-call
                                          vector-set!.81
                                          vector-set!.81
                                          tmp.8.19
                                          4
                                          5)))
                                    (if (closure-call
                                         error?.82
                                         error?.82
                                         g43016401.24)
                                      g43016401.24
                                      (let ((g43016402.25
                                             (closure-call
                                              vector-set!.81
                                              vector-set!.81
                                              tmp.8.19
                                              5
                                              6)))
                                        (if (closure-call
                                             error?.82
                                             error?.82
                                             g43016402.25)
                                          g43016402.25
                                          (let ((g43016403.26
                                                 (closure-call
                                                  vector-set!.81
                                                  vector-set!.81
                                                  tmp.8.19
                                                  6
                                                  7)))
                                            (if (closure-call
                                                 error?.82
                                                 error?.82
                                                 g43016403.26)
                                              g43016403.26
                                              (let ((g43016404.27
                                                     (closure-call
                                                      vector-set!.81
                                                      vector-set!.81
                                                      tmp.8.19
                                                      7
                                                      8)))
                                                (if (closure-call
                                                     error?.82
                                                     error?.82
                                                     g43016404.27)
                                                  g43016404.27
                                                  tmp.8.19))))))))))))))))))
               (fixnum1.17 211))
           23)
         (closure-call fun/fixnum8765.10 fun/fixnum8765.10))))))
(check-by-interp
 '(module (let ((boolean0.7 (let ((fixnum0.8 179)) #t))) (if #f empty empty))))
(check-by-interp
 '(module
    (letrec ((L.+.72.10
              (lambda (c.73 tmp.34 tmp.35)
                (let ()
                  (if (fixnum? tmp.35)
                    (if (fixnum? tmp.34) (unsafe-fx+ tmp.34 tmp.35) (error 2))
                    (error 2)))))
             (L.cons.71.11
              (lambda (c.74 tmp.65 tmp.66) (let () (cons tmp.65 tmp.66))))
             (L.*.70.12
              (lambda (c.75 tmp.32 tmp.33)
                (let ()
                  (if (fixnum? tmp.33)
                    (if (fixnum? tmp.32) (unsafe-fx* tmp.32 tmp.33) (error 1))
                    (error 1)))))
             (L.fun/fixnum8773.7.13
              (lambda (c.76 oprand0.12)
                (let ((fun/fixnum8774.10 (closure-ref c.76 0)))
                  (closure-call fun/fixnum8774.10 fun/fixnum8774.10))))
             (L.fun/fixnum8771.8.14
              (lambda (c.77)
                (let ((fun/fixnum8772.11 (closure-ref c.77 0)))
                  (closure-call fun/fixnum8772.11 fun/fixnum8772.11 #f))))
             (L.fun/fixnum8775.9.15 (lambda (c.78 oprand0.13) (let () 117)))
             (L.fun/fixnum8774.10.16 (lambda (c.79) (let () 126)))
             (L.fun/fixnum8772.11.17 (lambda (c.80 oprand0.14) (let () 87))))
      (cletrec
       ((|+.72| (make-closure L.+.72.10 2))
        (cons.71 (make-closure L.cons.71.11 2))
        (*.70 (make-closure L.*.70.12 2))
        (fun/fixnum8773.7
         (make-closure L.fun/fixnum8773.7.13 1 fun/fixnum8774.10))
        (fun/fixnum8771.8
         (make-closure L.fun/fixnum8771.8.14 0 fun/fixnum8772.11))
        (fun/fixnum8775.9 (make-closure L.fun/fixnum8775.9.15 1))
        (fun/fixnum8774.10 (make-closure L.fun/fixnum8774.10.16 0))
        (fun/fixnum8772.11 (make-closure L.fun/fixnum8772.11.17 1)))
       (closure-call
        |+.72|
        |+.72|
        (if (let () 213)
          (if (closure-call fun/fixnum8771.8 fun/fixnum8771.8)
            (if (if #t 219 12)
              (if (if #f 137 140)
                (if (closure-call
                     fun/fixnum8773.7
                     fun/fixnum8773.7
                     (closure-call *.70 *.70 130 63))
                  (let () 156)
                  #f)
                #f)
              #f)
            #f)
          #f)
        (if (let ((fixnum0.17 100)
                  (pair1.16
                   (closure-call
                    cons.71
                    cons.71
                    19
                    (closure-call cons.71 cons.71 454 empty)))
                  (pair2.15
                   (closure-call
                    cons.71
                    cons.71
                    5
                    (closure-call cons.71 cons.71 453 empty))))
              #f)
          (closure-call |+.72| |+.72| 124 32)
          (closure-call
           fun/fixnum8775.9
           fun/fixnum8775.9
           (closure-call
            cons.71
            cons.71
            111
            (closure-call cons.71 cons.71 440 empty)))))))))
(check-by-interp '(module (let () (if #t #t #t))))
(check-by-interp
 '(module
    (letrec ((L.unsafe-vector-set!.5.10
              (lambda (c.77 tmp.27 tmp.28 tmp.29)
                (let ()
                  (if (unsafe-fx< tmp.28 (unsafe-vector-length tmp.27))
                    (if (unsafe-fx>= tmp.28 0)
                      (begin (unsafe-vector-set! tmp.27 tmp.28 tmp.29) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.76.11
              (lambda (c.78 tmp.51 tmp.52 tmp.53)
                (let ((unsafe-vector-set!.5 (closure-ref c.78 0)))
                  (if (fixnum? tmp.52)
                    (if (vector? tmp.51)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.51
                       tmp.52
                       tmp.53)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.23.12
              (lambda (c.79 len.24 i.26 vec.25)
                (let ((vector-init-loop.23 (closure-ref c.79 0)))
                  (if (eq? len.24 i.26)
                    vec.25
                    (begin
                      (unsafe-vector-set! vec.25 i.26 0)
                      (closure-call
                       vector-init-loop.23
                       vector-init-loop.23
                       len.24
                       (unsafe-fx+ i.26 1)
                       vec.25))))))
             (L.make-init-vector.4.13
              (lambda (c.80 tmp.21)
                (let ((vector-init-loop.23 (closure-ref c.80 0)))
                  (let ((tmp.22 (unsafe-make-vector tmp.21)))
                    (closure-call
                     vector-init-loop.23
                     vector-init-loop.23
                     tmp.21
                     0
                     tmp.22)))))
             (L.make-vector.75.14
              (lambda (c.81 tmp.49)
                (let ((make-init-vector.4 (closure-ref c.81 0)))
                  (if (fixnum? tmp.49)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.49)
                    (error 8)))))
             (L.cons.74.15
              (lambda (c.82 tmp.68 tmp.69) (let () (cons tmp.68 tmp.69))))
             (L.error?.73.16 (lambda (c.83 tmp.63) (let () (error? tmp.63))))
             (L.fun/empty8780.8.17 (lambda (c.84) (let () empty))))
      (cletrec
       ((unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.10 3))
        (vector-set!.76
         (make-closure L.vector-set!.76.11 3 unsafe-vector-set!.5))
        (vector-init-loop.23
         (make-closure L.vector-init-loop.23.12 3 vector-init-loop.23))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.13 1 vector-init-loop.23))
        (make-vector.75
         (make-closure L.make-vector.75.14 1 make-init-vector.4))
        (cons.74 (make-closure L.cons.74.15 2))
        (error?.73 (make-closure L.error?.73.16 1))
        (fun/empty8780.8 (make-closure L.fun/empty8780.8.17 0)))
       (if (closure-call error?.73 error?.73 (if #t #t #\e))
         (if (if empty (if empty (if empty (if empty empty #f) #f) #f) #f)
           (if (if #t empty empty)
             (if (if #t empty empty)
               (if (closure-call fun/empty8780.8 fun/empty8780.8)
                 (if (let ((pair0.11
                            (closure-call
                             cons.74
                             cons.74
                             18
                             (closure-call cons.74 cons.74 445 empty)))
                           (vector1.10
                            (let ((tmp.7.12
                                   (closure-call
                                    make-vector.75
                                    make-vector.75
                                    8)))
                              (let ((g43031664.13
                                     (closure-call
                                      vector-set!.76
                                      vector-set!.76
                                      tmp.7.12
                                      0
                                      1)))
                                (if (closure-call
                                     error?.73
                                     error?.73
                                     g43031664.13)
                                  g43031664.13
                                  (let ((g43031665.14
                                         (closure-call
                                          vector-set!.76
                                          vector-set!.76
                                          tmp.7.12
                                          1
                                          2)))
                                    (if (closure-call
                                         error?.73
                                         error?.73
                                         g43031665.14)
                                      g43031665.14
                                      (let ((g43031666.15
                                             (closure-call
                                              vector-set!.76
                                              vector-set!.76
                                              tmp.7.12
                                              2
                                              3)))
                                        (if (closure-call
                                             error?.73
                                             error?.73
                                             g43031666.15)
                                          g43031666.15
                                          (let ((g43031667.16
                                                 (closure-call
                                                  vector-set!.76
                                                  vector-set!.76
                                                  tmp.7.12
                                                  3
                                                  4)))
                                            (if (closure-call
                                                 error?.73
                                                 error?.73
                                                 g43031667.16)
                                              g43031667.16
                                              (let ((g43031668.17
                                                     (closure-call
                                                      vector-set!.76
                                                      vector-set!.76
                                                      tmp.7.12
                                                      4
                                                      5)))
                                                (if (closure-call
                                                     error?.73
                                                     error?.73
                                                     g43031668.17)
                                                  g43031668.17
                                                  (let ((g43031669.18
                                                         (closure-call
                                                          vector-set!.76
                                                          vector-set!.76
                                                          tmp.7.12
                                                          5
                                                          6)))
                                                    (if (closure-call
                                                         error?.73
                                                         error?.73
                                                         g43031669.18)
                                                      g43031669.18
                                                      (let ((g43031670.19
                                                             (closure-call
                                                              vector-set!.76
                                                              vector-set!.76
                                                              tmp.7.12
                                                              6
                                                              7)))
                                                        (if (closure-call
                                                             error?.73
                                                             error?.73
                                                             g43031670.19)
                                                          g43031670.19
                                                          (let ((g43031671.20
                                                                 (closure-call
                                                                  vector-set!.76
                                                                  vector-set!.76
                                                                  tmp.7.12
                                                                  7
                                                                  8)))
                                                            (if (closure-call
                                                                 error?.73
                                                                 error?.73
                                                                 g43031671.20)
                                                              g43031671.20
                                                              tmp.7.12))))))))))))))))))
                           (pair2.9
                            (closure-call
                             cons.74
                             cons.74
                             194
                             (closure-call cons.74 cons.74 316 empty))))
                       empty)
                   (if #t empty empty)
                   #f)
                 #f)
               #f)
             #f)
           #f)
         (if #f empty empty))))))
(check-by-interp
 '(module
    (letrec ((L.vector-init-loop.110.10
              (lambda (c.165 len.111 i.113 vec.112)
                (let ((vector-init-loop.110 (closure-ref c.165 0)))
                  (if (eq? len.111 i.113)
                    vec.112
                    (begin
                      (unsafe-vector-set! vec.112 i.113 0)
                      (closure-call
                       vector-init-loop.110
                       vector-init-loop.110
                       len.111
                       (unsafe-fx+ i.113 1)
                       vec.112))))))
             (L.make-init-vector.4.11
              (lambda (c.166 tmp.108)
                (let ((vector-init-loop.110 (closure-ref c.166 0)))
                  (let ((tmp.109 (unsafe-make-vector tmp.108)))
                    (closure-call
                     vector-init-loop.110
                     vector-init-loop.110
                     tmp.108
                     0
                     tmp.109)))))
             (L.make-vector.163.12
              (lambda (c.167 tmp.136)
                (let ((make-init-vector.4 (closure-ref c.167 0)))
                  (if (fixnum? tmp.136)
                    (closure-call
                     make-init-vector.4
                     make-init-vector.4
                     tmp.136)
                    (error 8)))))
             (L.error?.162.13
              (lambda (c.168 tmp.150) (let () (error? tmp.150))))
             (L.unsafe-vector-set!.5.14
              (lambda (c.169 tmp.114 tmp.115 tmp.116)
                (let ()
                  (if (unsafe-fx< tmp.115 (unsafe-vector-length tmp.114))
                    (if (unsafe-fx>= tmp.115 0)
                      (begin
                        (unsafe-vector-set! tmp.114 tmp.115 tmp.116)
                        (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.161.15
              (lambda (c.170 tmp.138 tmp.139 tmp.140)
                (let ((unsafe-vector-set!.5 (closure-ref c.170 0)))
                  (if (fixnum? tmp.139)
                    (if (vector? tmp.138)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.138
                       tmp.139
                       tmp.140)
                      (error 10))
                    (error 10)))))
             (L.cons.160.16
              (lambda (c.171 tmp.155 tmp.156) (let () (cons tmp.155 tmp.156))))
             (L.fun/boolean8789.21.17 (lambda (c.172 oprand0.30) (let () #t)))
             (L.fun/boolean8790.22.18
              (lambda (c.173 oprand0.32 oprand1.31) (let () #t)))
             (L.fun/ascii-char8791.23.19
              (lambda (c.174 oprand0.33) (let () (if #t #\m #\`))))
             (L.fun/void8788.24.20 (lambda (c.175) (let () (void))))
             (L.fun/void8786.25.21 (lambda (c.176) (let () (void))))
             (L.fun/ascii-char8785.26.22 (lambda (c.177) (let () #\k)))
             (L.fun/ascii-char8783.27.23
              (lambda (c.178 oprand0.35 oprand1.34)
                (let ((fun/ascii-char8784.29 (closure-ref c.178 0)))
                  (closure-call fun/ascii-char8784.29 fun/ascii-char8784.29))))
             (L.fun/void8787.28.24
              (lambda (c.179 oprand0.36)
                (let ((cons.160 (closure-ref c.179 0))
                      (vector-set!.161 (closure-ref c.179 1)))
                  (closure-call
                   vector-set!.161
                   vector-set!.161
                   oprand0.36
                   1
                   (closure-call
                    cons.160
                    cons.160
                    56
                    (closure-call cons.160 cons.160 441 empty))))))
             (L.fun/ascii-char8784.29.25
              (lambda (c.180)
                (let ((fun/ascii-char8785.26 (closure-ref c.180 0)))
                  (closure-call
                   fun/ascii-char8785.26
                   fun/ascii-char8785.26)))))
      (cletrec
       ((vector-init-loop.110
         (make-closure L.vector-init-loop.110.10 3 vector-init-loop.110))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.11 1 vector-init-loop.110))
        (make-vector.163
         (make-closure L.make-vector.163.12 1 make-init-vector.4))
        (error?.162 (make-closure L.error?.162.13 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.14 3))
        (vector-set!.161
         (make-closure L.vector-set!.161.15 3 unsafe-vector-set!.5))
        (cons.160 (make-closure L.cons.160.16 2))
        (fun/boolean8789.21 (make-closure L.fun/boolean8789.21.17 1))
        (fun/boolean8790.22 (make-closure L.fun/boolean8790.22.18 2))
        (fun/ascii-char8791.23 (make-closure L.fun/ascii-char8791.23.19 1))
        (fun/void8788.24 (make-closure L.fun/void8788.24.20 0))
        (fun/void8786.25 (make-closure L.fun/void8786.25.21 0))
        (fun/ascii-char8785.26 (make-closure L.fun/ascii-char8785.26.22 0))
        (fun/ascii-char8783.27
         (make-closure L.fun/ascii-char8783.27.23 2 fun/ascii-char8784.29))
        (fun/void8787.28
         (make-closure L.fun/void8787.28.24 1 cons.160 vector-set!.161))
        (fun/ascii-char8784.29
         (make-closure L.fun/ascii-char8784.29.25 0 fun/ascii-char8785.26)))
       (let ((tmp.7.37
              (closure-call
               fun/ascii-char8783.27
               fun/ascii-char8783.27
               (let ((g43035489.38 (let () (void))))
                 (if (closure-call error?.162 error?.162 g43035489.38)
                   g43035489.38
                   (let ((g43035490.39
                          (if (void)
                            (if (void)
                              (if (void)
                                (if (void) (if (void) (void) #f) #f)
                                #f)
                              #f)
                            #f)))
                     (if (closure-call error?.162 error?.162 g43035490.39)
                       g43035490.39
                       (let ((g43035491.40 (void)))
                         (if (closure-call error?.162 error?.162 g43035491.40)
                           g43035491.40
                           (let ((g43035492.41
                                  (let ((g43035493.42 (void)))
                                    (if (closure-call
                                         error?.162
                                         error?.162
                                         g43035493.42)
                                      g43035493.42
                                      (void)))))
                             (if (closure-call
                                  error?.162
                                  error?.162
                                  g43035492.41)
                               g43035492.41
                               (let ((g43035494.43
                                      (closure-call
                                       fun/void8786.25
                                       fun/void8786.25)))
                                 (if (closure-call
                                      error?.162
                                      error?.162
                                      g43035494.43)
                                   g43035494.43
                                   (let ((g43035495.44
                                          (closure-call
                                           fun/void8787.28
                                           fun/void8787.28
                                           (let ((tmp.8.45
                                                  (closure-call
                                                   make-vector.163
                                                   make-vector.163
                                                   8)))
                                             (let ((g43035496.46
                                                    (closure-call
                                                     vector-set!.161
                                                     vector-set!.161
                                                     tmp.8.45
                                                     0
                                                     1)))
                                               (if (closure-call
                                                    error?.162
                                                    error?.162
                                                    g43035496.46)
                                                 g43035496.46
                                                 (let ((g43035497.47
                                                        (closure-call
                                                         vector-set!.161
                                                         vector-set!.161
                                                         tmp.8.45
                                                         1
                                                         2)))
                                                   (if (closure-call
                                                        error?.162
                                                        error?.162
                                                        g43035497.47)
                                                     g43035497.47
                                                     (let ((g43035498.48
                                                            (closure-call
                                                             vector-set!.161
                                                             vector-set!.161
                                                             tmp.8.45
                                                             2
                                                             3)))
                                                       (if (closure-call
                                                            error?.162
                                                            error?.162
                                                            g43035498.48)
                                                         g43035498.48
                                                         (let ((g43035499.49
                                                                (closure-call
                                                                 vector-set!.161
                                                                 vector-set!.161
                                                                 tmp.8.45
                                                                 3
                                                                 4)))
                                                           (if (closure-call
                                                                error?.162
                                                                error?.162
                                                                g43035499.49)
                                                             g43035499.49
                                                             (let ((g43035500.50
                                                                    (closure-call
                                                                     vector-set!.161
                                                                     vector-set!.161
                                                                     tmp.8.45
                                                                     4
                                                                     5)))
                                                               (if (closure-call
                                                                    error?.162
                                                                    error?.162
                                                                    g43035500.50)
                                                                 g43035500.50
                                                                 (let ((g43035501.51
                                                                        (closure-call
                                                                         vector-set!.161
                                                                         vector-set!.161
                                                                         tmp.8.45
                                                                         5
                                                                         6)))
                                                                   (if (closure-call
                                                                        error?.162
                                                                        error?.162
                                                                        g43035501.51)
                                                                     g43035501.51
                                                                     (let ((g43035502.52
                                                                            (closure-call
                                                                             vector-set!.161
                                                                             vector-set!.161
                                                                             tmp.8.45
                                                                             6
                                                                             7)))
                                                                       (if (closure-call
                                                                            error?.162
                                                                            error?.162
                                                                            g43035502.52)
                                                                         g43035502.52
                                                                         (let ((g43035503.53
                                                                                (closure-call
                                                                                 vector-set!.161
                                                                                 vector-set!.161
                                                                                 tmp.8.45
                                                                                 7
                                                                                 8)))
                                                                           (if (closure-call
                                                                                error?.162
                                                                                error?.162
                                                                                g43035503.53)
                                                                             g43035503.53
                                                                             tmp.8.45))))))))))))))))))))
                                     (if (closure-call
                                          error?.162
                                          error?.162
                                          g43035495.44)
                                       g43035495.44
                                       (closure-call
                                        fun/void8788.24
                                        fun/void8788.24)))))))))))))
               (let ((error0.54 (error 149))) (error 198)))))
         (if tmp.7.37
           tmp.7.37
           (let ((tmp.9.55
                  (let ((vector0.56
                         (let ((tmp.10.57
                                (closure-call
                                 make-vector.163
                                 make-vector.163
                                 8)))
                           (let ((g43035504.58
                                  (closure-call
                                   vector-set!.161
                                   vector-set!.161
                                   tmp.10.57
                                   0
                                   empty)))
                             (if (closure-call
                                  error?.162
                                  error?.162
                                  g43035504.58)
                               g43035504.58
                               (let ((g43035505.59
                                      (closure-call
                                       vector-set!.161
                                       vector-set!.161
                                       tmp.10.57
                                       1
                                       #\Y)))
                                 (if (closure-call
                                      error?.162
                                      error?.162
                                      g43035505.59)
                                   g43035505.59
                                   (let ((g43035506.60
                                          (closure-call
                                           vector-set!.161
                                           vector-set!.161
                                           tmp.10.57
                                           2
                                           211)))
                                     (if (closure-call
                                          error?.162
                                          error?.162
                                          g43035506.60)
                                       g43035506.60
                                       (let ((g43035507.61
                                              (closure-call
                                               vector-set!.161
                                               vector-set!.161
                                               tmp.10.57
                                               3
                                               (closure-call
                                                cons.160
                                                cons.160
                                                19
                                                (closure-call
                                                 cons.160
                                                 cons.160
                                                 491
                                                 empty)))))
                                         (if (closure-call
                                              error?.162
                                              error?.162
                                              g43035507.61)
                                           g43035507.61
                                           (let ((g43035508.62
                                                  (closure-call
                                                   vector-set!.161
                                                   vector-set!.161
                                                   tmp.10.57
                                                   4
                                                   #\U)))
                                             (if (closure-call
                                                  error?.162
                                                  error?.162
                                                  g43035508.62)
                                               g43035508.62
                                               (let ((g43035509.63
                                                      (closure-call
                                                       vector-set!.161
                                                       vector-set!.161
                                                       tmp.10.57
                                                       5
                                                       (closure-call
                                                        cons.160
                                                        cons.160
                                                        239
                                                        (closure-call
                                                         cons.160
                                                         cons.160
                                                         358
                                                         empty)))))
                                                 (if (closure-call
                                                      error?.162
                                                      error?.162
                                                      g43035509.63)
                                                   g43035509.63
                                                   (let ((g43035510.64
                                                          (closure-call
                                                           vector-set!.161
                                                           vector-set!.161
                                                           tmp.10.57
                                                           6
                                                           70)))
                                                     (if (closure-call
                                                          error?.162
                                                          error?.162
                                                          g43035510.64)
                                                       g43035510.64
                                                       (let ((g43035511.65
                                                              (closure-call
                                                               vector-set!.161
                                                               vector-set!.161
                                                               tmp.10.57
                                                               7
                                                               (error 150))))
                                                         (if (closure-call
                                                              error?.162
                                                              error?.162
                                                              g43035511.65)
                                                           g43035511.65
                                                           tmp.10.57)))))))))))))))))))
                    (if #f #\^ #\W))))
             (if tmp.9.55
               tmp.9.55
               (let ((tmp.11.66
                      (if (closure-call
                           fun/boolean8789.21
                           fun/boolean8789.21
                           (letrec ((L.lam.164.26
                                     (lambda (c.181) (let () 792))))
                             (cletrec
                              ((lam.164 (make-closure L.lam.164.26 0)))
                              lam.164)))
                        (let ((tmp.12.67 #\[))
                          (if tmp.12.67
                            tmp.12.67
                            (let ((tmp.13.68 #\W))
                              (if tmp.13.68
                                tmp.13.68
                                (let ((tmp.14.69 #\R))
                                  (if tmp.14.69 tmp.14.69 #\Y))))))
                        (if #t #\a #\^))))
                 (if tmp.11.66
                   tmp.11.66
                   (let ((tmp.15.70
                          (if (closure-call
                               fun/boolean8790.22
                               fun/boolean8790.22
                               empty
                               240)
                            (if #t #\v #\d)
                            (if #\j
                              (if #\H
                                (if #\a (if #\E (if #\h #\K #f) #f) #f)
                                #f)
                              #f))))
                     (if tmp.15.70
                       tmp.15.70
                       (closure-call
                        fun/ascii-char8791.23
                        fun/ascii-char8791.23
                        (let ((tmp.16.71
                               (if #t
                                 (closure-call
                                  make-vector.163
                                  make-vector.163
                                  8)
                                 (let ((tmp.17.72
                                        (closure-call
                                         make-vector.163
                                         make-vector.163
                                         8)))
                                   (let ((g43035512.73
                                          (closure-call
                                           vector-set!.161
                                           vector-set!.161
                                           tmp.17.72
                                           0
                                           1)))
                                     (if (closure-call
                                          error?.162
                                          error?.162
                                          g43035512.73)
                                       g43035512.73
                                       (let ((g43035513.74
                                              (closure-call
                                               vector-set!.161
                                               vector-set!.161
                                               tmp.17.72
                                               1
                                               2)))
                                         (if (closure-call
                                              error?.162
                                              error?.162
                                              g43035513.74)
                                           g43035513.74
                                           (let ((g43035514.75
                                                  (closure-call
                                                   vector-set!.161
                                                   vector-set!.161
                                                   tmp.17.72
                                                   2
                                                   3)))
                                             (if (closure-call
                                                  error?.162
                                                  error?.162
                                                  g43035514.75)
                                               g43035514.75
                                               (let ((g43035515.76
                                                      (closure-call
                                                       vector-set!.161
                                                       vector-set!.161
                                                       tmp.17.72
                                                       3
                                                       4)))
                                                 (if (closure-call
                                                      error?.162
                                                      error?.162
                                                      g43035515.76)
                                                   g43035515.76
                                                   (let ((g43035516.77
                                                          (closure-call
                                                           vector-set!.161
                                                           vector-set!.161
                                                           tmp.17.72
                                                           4
                                                           5)))
                                                     (if (closure-call
                                                          error?.162
                                                          error?.162
                                                          g43035516.77)
                                                       g43035516.77
                                                       (let ((g43035517.78
                                                              (closure-call
                                                               vector-set!.161
                                                               vector-set!.161
                                                               tmp.17.72
                                                               5
                                                               6)))
                                                         (if (closure-call
                                                              error?.162
                                                              error?.162
                                                              g43035517.78)
                                                           g43035517.78
                                                           (let ((g43035518.79
                                                                  (closure-call
                                                                   vector-set!.161
                                                                   vector-set!.161
                                                                   tmp.17.72
                                                                   6
                                                                   7)))
                                                             (if (closure-call
                                                                  error?.162
                                                                  error?.162
                                                                  g43035518.79)
                                                               g43035518.79
                                                               (let ((g43035519.80
                                                                      (closure-call
                                                                       vector-set!.161
                                                                       vector-set!.161
                                                                       tmp.17.72
                                                                       7
                                                                       8)))
                                                                 (if (closure-call
                                                                      error?.162
                                                                      error?.162
                                                                      g43035519.80)
                                                                   g43035519.80
                                                                   tmp.17.72))))))))))))))))))))
                          (if tmp.16.71
                            tmp.16.71
                            (if (let ((tmp.18.81
                                       (closure-call
                                        make-vector.163
                                        make-vector.163
                                        8)))
                                  (let ((g43035520.82
                                         (closure-call
                                          vector-set!.161
                                          vector-set!.161
                                          tmp.18.81
                                          0
                                          1)))
                                    (if (closure-call
                                         error?.162
                                         error?.162
                                         g43035520.82)
                                      g43035520.82
                                      (let ((g43035521.83
                                             (closure-call
                                              vector-set!.161
                                              vector-set!.161
                                              tmp.18.81
                                              1
                                              2)))
                                        (if (closure-call
                                             error?.162
                                             error?.162
                                             g43035521.83)
                                          g43035521.83
                                          (let ((g43035522.84
                                                 (closure-call
                                                  vector-set!.161
                                                  vector-set!.161
                                                  tmp.18.81
                                                  2
                                                  3)))
                                            (if (closure-call
                                                 error?.162
                                                 error?.162
                                                 g43035522.84)
                                              g43035522.84
                                              (let ((g43035523.85
                                                     (closure-call
                                                      vector-set!.161
                                                      vector-set!.161
                                                      tmp.18.81
                                                      3
                                                      4)))
                                                (if (closure-call
                                                     error?.162
                                                     error?.162
                                                     g43035523.85)
                                                  g43035523.85
                                                  (let ((g43035524.86
                                                         (closure-call
                                                          vector-set!.161
                                                          vector-set!.161
                                                          tmp.18.81
                                                          4
                                                          5)))
                                                    (if (closure-call
                                                         error?.162
                                                         error?.162
                                                         g43035524.86)
                                                      g43035524.86
                                                      (let ((g43035525.87
                                                             (closure-call
                                                              vector-set!.161
                                                              vector-set!.161
                                                              tmp.18.81
                                                              5
                                                              6)))
                                                        (if (closure-call
                                                             error?.162
                                                             error?.162
                                                             g43035525.87)
                                                          g43035525.87
                                                          (let ((g43035526.88
                                                                 (closure-call
                                                                  vector-set!.161
                                                                  vector-set!.161
                                                                  tmp.18.81
                                                                  6
                                                                  7)))
                                                            (if (closure-call
                                                                 error?.162
                                                                 error?.162
                                                                 g43035526.88)
                                                              g43035526.88
                                                              (let ((g43035527.89
                                                                     (closure-call
                                                                      vector-set!.161
                                                                      vector-set!.161
                                                                      tmp.18.81
                                                                      7
                                                                      8)))
                                                                (if (closure-call
                                                                     error?.162
                                                                     error?.162
                                                                     g43035527.89)
                                                                  g43035527.89
                                                                  tmp.18.81)))))))))))))))))
                              (if (let ((tmp.19.90
                                         (closure-call
                                          make-vector.163
                                          make-vector.163
                                          8)))
                                    (let ((g43035528.91
                                           (closure-call
                                            vector-set!.161
                                            vector-set!.161
                                            tmp.19.90
                                            0
                                            1)))
                                      (if (closure-call
                                           error?.162
                                           error?.162
                                           g43035528.91)
                                        g43035528.91
                                        (let ((g43035529.92
                                               (closure-call
                                                vector-set!.161
                                                vector-set!.161
                                                tmp.19.90
                                                1
                                                2)))
                                          (if (closure-call
                                               error?.162
                                               error?.162
                                               g43035529.92)
                                            g43035529.92
                                            (let ((g43035530.93
                                                   (closure-call
                                                    vector-set!.161
                                                    vector-set!.161
                                                    tmp.19.90
                                                    2
                                                    3)))
                                              (if (closure-call
                                                   error?.162
                                                   error?.162
                                                   g43035530.93)
                                                g43035530.93
                                                (let ((g43035531.94
                                                       (closure-call
                                                        vector-set!.161
                                                        vector-set!.161
                                                        tmp.19.90
                                                        3
                                                        4)))
                                                  (if (closure-call
                                                       error?.162
                                                       error?.162
                                                       g43035531.94)
                                                    g43035531.94
                                                    (let ((g43035532.95
                                                           (closure-call
                                                            vector-set!.161
                                                            vector-set!.161
                                                            tmp.19.90
                                                            4
                                                            5)))
                                                      (if (closure-call
                                                           error?.162
                                                           error?.162
                                                           g43035532.95)
                                                        g43035532.95
                                                        (let ((g43035533.96
                                                               (closure-call
                                                                vector-set!.161
                                                                vector-set!.161
                                                                tmp.19.90
                                                                5
                                                                6)))
                                                          (if (closure-call
                                                               error?.162
                                                               error?.162
                                                               g43035533.96)
                                                            g43035533.96
                                                            (let ((g43035534.97
                                                                   (closure-call
                                                                    vector-set!.161
                                                                    vector-set!.161
                                                                    tmp.19.90
                                                                    6
                                                                    7)))
                                                              (if (closure-call
                                                                   error?.162
                                                                   error?.162
                                                                   g43035534.97)
                                                                g43035534.97
                                                                (let ((g43035535.98
                                                                       (closure-call
                                                                        vector-set!.161
                                                                        vector-set!.161
                                                                        tmp.19.90
                                                                        7
                                                                        8)))
                                                                  (if (closure-call
                                                                       error?.162
                                                                       error?.162
                                                                       g43035535.98)
                                                                    g43035535.98
                                                                    tmp.19.90)))))))))))))))))
                                (let ((tmp.20.99
                                       (closure-call
                                        make-vector.163
                                        make-vector.163
                                        8)))
                                  (let ((g43035536.100
                                         (closure-call
                                          vector-set!.161
                                          vector-set!.161
                                          tmp.20.99
                                          0
                                          1)))
                                    (if (closure-call
                                         error?.162
                                         error?.162
                                         g43035536.100)
                                      g43035536.100
                                      (let ((g43035537.101
                                             (closure-call
                                              vector-set!.161
                                              vector-set!.161
                                              tmp.20.99
                                              1
                                              2)))
                                        (if (closure-call
                                             error?.162
                                             error?.162
                                             g43035537.101)
                                          g43035537.101
                                          (let ((g43035538.102
                                                 (closure-call
                                                  vector-set!.161
                                                  vector-set!.161
                                                  tmp.20.99
                                                  2
                                                  3)))
                                            (if (closure-call
                                                 error?.162
                                                 error?.162
                                                 g43035538.102)
                                              g43035538.102
                                              (let ((g43035539.103
                                                     (closure-call
                                                      vector-set!.161
                                                      vector-set!.161
                                                      tmp.20.99
                                                      3
                                                      4)))
                                                (if (closure-call
                                                     error?.162
                                                     error?.162
                                                     g43035539.103)
                                                  g43035539.103
                                                  (let ((g43035540.104
                                                         (closure-call
                                                          vector-set!.161
                                                          vector-set!.161
                                                          tmp.20.99
                                                          4
                                                          5)))
                                                    (if (closure-call
                                                         error?.162
                                                         error?.162
                                                         g43035540.104)
                                                      g43035540.104
                                                      (let ((g43035541.105
                                                             (closure-call
                                                              vector-set!.161
                                                              vector-set!.161
                                                              tmp.20.99
                                                              5
                                                              6)))
                                                        (if (closure-call
                                                             error?.162
                                                             error?.162
                                                             g43035541.105)
                                                          g43035541.105
                                                          (let ((g43035542.106
                                                                 (closure-call
                                                                  vector-set!.161
                                                                  vector-set!.161
                                                                  tmp.20.99
                                                                  6
                                                                  7)))
                                                            (if (closure-call
                                                                 error?.162
                                                                 error?.162
                                                                 g43035542.106)
                                                              g43035542.106
                                                              (let ((g43035543.107
                                                                     (closure-call
                                                                      vector-set!.161
                                                                      vector-set!.161
                                                                      tmp.20.99
                                                                      7
                                                                      8)))
                                                                (if (closure-call
                                                                     error?.162
                                                                     error?.162
                                                                     g43035543.107)
                                                                  g43035543.107
                                                                  tmp.20.99)))))))))))))))))
                                #f)
                              #f))))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.cons.97.10
              (lambda (c.101 tmp.89 tmp.90) (let () (cons tmp.89 tmp.90))))
             (L.error?.96.11 (lambda (c.102 tmp.84) (let () (error? tmp.84))))
             (L.unsafe-vector-set!.5.12
              (lambda (c.103 tmp.48 tmp.49 tmp.50)
                (let ()
                  (if (unsafe-fx< tmp.49 (unsafe-vector-length tmp.48))
                    (if (unsafe-fx>= tmp.49 0)
                      (begin (unsafe-vector-set! tmp.48 tmp.49 tmp.50) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.95.13
              (lambda (c.104 tmp.72 tmp.73 tmp.74)
                (let ((unsafe-vector-set!.5 (closure-ref c.104 0)))
                  (if (fixnum? tmp.73)
                    (if (vector? tmp.72)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.72
                       tmp.73
                       tmp.74)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.44.14
              (lambda (c.105 len.45 i.47 vec.46)
                (let ((vector-init-loop.44 (closure-ref c.105 0)))
                  (if (eq? len.45 i.47)
                    vec.46
                    (begin
                      (unsafe-vector-set! vec.46 i.47 0)
                      (closure-call
                       vector-init-loop.44
                       vector-init-loop.44
                       len.45
                       (unsafe-fx+ i.47 1)
                       vec.46))))))
             (L.make-init-vector.4.15
              (lambda (c.106 tmp.42)
                (let ((vector-init-loop.44 (closure-ref c.106 0)))
                  (let ((tmp.43 (unsafe-make-vector tmp.42)))
                    (closure-call
                     vector-init-loop.44
                     vector-init-loop.44
                     tmp.42
                     0
                     tmp.43)))))
             (L.make-vector.94.16
              (lambda (c.107 tmp.70)
                (let ((make-init-vector.4 (closure-ref c.107 0)))
                  (if (fixnum? tmp.70)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.70)
                    (error 8)))))
             (L.fun/empty8795.13.17
              (lambda (c.108 oprand0.17 oprand1.16) (let () (let () empty))))
             (L.fun/boolean8796.14.18 (lambda (c.109 oprand0.18) (let () #t)))
             (L.fun/empty8794.15.19
              (lambda (c.110 oprand0.19) (let () empty))))
      (cletrec
       ((cons.97 (make-closure L.cons.97.10 2))
        (error?.96 (make-closure L.error?.96.11 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.12 3))
        (vector-set!.95
         (make-closure L.vector-set!.95.13 3 unsafe-vector-set!.5))
        (vector-init-loop.44
         (make-closure L.vector-init-loop.44.14 3 vector-init-loop.44))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.15 1 vector-init-loop.44))
        (make-vector.94
         (make-closure L.make-vector.94.16 1 make-init-vector.4))
        (fun/empty8795.13 (make-closure L.fun/empty8795.13.17 2))
        (fun/boolean8796.14 (make-closure L.fun/boolean8796.14.18 1))
        (fun/empty8794.15 (make-closure L.fun/empty8794.15.19 1)))
       (let ((tmp.7.20
              (let ((boolean0.23 #f) (boolean1.22 #f) (empty2.21 empty))
                empty)))
         (if tmp.7.20
           tmp.7.20
           (let ((tmp.8.24
                  (if (let ((empty0.25 empty)) empty)
                    (if (closure-call
                         fun/empty8794.15
                         fun/empty8794.15
                         (letrec ((L.lam.98.20 (lambda (c.111) (let () 949))))
                           (cletrec
                            ((lam.98 (make-closure L.lam.98.20 0)))
                            lam.98)))
                      (let () empty)
                      #f)
                    #f)))
             (if tmp.8.24
               tmp.8.24
               (let ((tmp.9.26
                      (closure-call
                       fun/empty8795.13
                       fun/empty8795.13
                       (closure-call
                        fun/boolean8796.14
                        fun/boolean8796.14
                        (let ((tmp.10.27
                               (closure-call make-vector.94 make-vector.94 8)))
                          (let ((g43039358.28
                                 (closure-call
                                  vector-set!.95
                                  vector-set!.95
                                  tmp.10.27
                                  0
                                  0)))
                            (if (closure-call error?.96 error?.96 g43039358.28)
                              g43039358.28
                              (let ((g43039359.29
                                     (closure-call
                                      vector-set!.95
                                      vector-set!.95
                                      tmp.10.27
                                      1
                                      1)))
                                (if (closure-call
                                     error?.96
                                     error?.96
                                     g43039359.29)
                                  g43039359.29
                                  (let ((g43039360.30
                                         (closure-call
                                          vector-set!.95
                                          vector-set!.95
                                          tmp.10.27
                                          2
                                          2)))
                                    (if (closure-call
                                         error?.96
                                         error?.96
                                         g43039360.30)
                                      g43039360.30
                                      (let ((g43039361.31
                                             (closure-call
                                              vector-set!.95
                                              vector-set!.95
                                              tmp.10.27
                                              3
                                              3)))
                                        (if (closure-call
                                             error?.96
                                             error?.96
                                             g43039361.31)
                                          g43039361.31
                                          (let ((g43039362.32
                                                 (closure-call
                                                  vector-set!.95
                                                  vector-set!.95
                                                  tmp.10.27
                                                  4
                                                  4)))
                                            (if (closure-call
                                                 error?.96
                                                 error?.96
                                                 g43039362.32)
                                              g43039362.32
                                              (let ((g43039363.33
                                                     (closure-call
                                                      vector-set!.95
                                                      vector-set!.95
                                                      tmp.10.27
                                                      5
                                                      5)))
                                                (if (closure-call
                                                     error?.96
                                                     error?.96
                                                     g43039363.33)
                                                  g43039363.33
                                                  (let ((g43039364.34
                                                         (closure-call
                                                          vector-set!.95
                                                          vector-set!.95
                                                          tmp.10.27
                                                          6
                                                          6)))
                                                    (if (closure-call
                                                         error?.96
                                                         error?.96
                                                         g43039364.34)
                                                      g43039364.34
                                                      (let ((g43039365.35
                                                             (closure-call
                                                              vector-set!.95
                                                              vector-set!.95
                                                              tmp.10.27
                                                              7
                                                              7)))
                                                        (if (closure-call
                                                             error?.96
                                                             error?.96
                                                             g43039365.35)
                                                          g43039365.35
                                                          tmp.10.27))))))))))))))))))
                       (if #t
                         (letrec ((L.lam.99.21 (lambda (c.112) (let () 556))))
                           (cletrec
                            ((lam.99 (make-closure L.lam.99.21 0)))
                            lam.99))
                         (letrec ((L.lam.100.22 (lambda (c.113) (let () 797))))
                           (cletrec
                            ((lam.100 (make-closure L.lam.100.22 0)))
                            lam.100))))))
                 (if tmp.9.26
                   tmp.9.26
                   (let ((tmp.11.36 (if #t empty empty)))
                     (if tmp.11.36
                       tmp.11.36
                       (let ((tmp.12.37 (if #f empty empty)))
                         (if tmp.12.37
                           tmp.12.37
                           (let ((g43039366.38
                                  (let ((error0.41 (error 163))
                                        (pair1.40
                                         (closure-call
                                          cons.97
                                          cons.97
                                          164
                                          (closure-call
                                           cons.97
                                           cons.97
                                           444
                                           empty)))
                                        (ascii-char2.39 #\d))
                                    empty)))
                             (if (closure-call
                                  error?.96
                                  error?.96
                                  g43039366.38)
                               g43039366.38
                               (if #t empty empty)))))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.fun/void8801.7.10 (lambda (c.62) (let () (void))))
             (L.fun/void8800.8.11
              (lambda (c.63)
                (let ((fun/void8801.7 (closure-ref c.63 0)))
                  (closure-call fun/void8801.7 fun/void8801.7))))
             (L.fun/void8799.9.12
              (lambda (c.64)
                (let ((fun/void8800.8 (closure-ref c.64 0)))
                  (closure-call fun/void8800.8 fun/void8800.8)))))
      (cletrec
       ((fun/void8801.7 (make-closure L.fun/void8801.7.10 0))
        (fun/void8800.8 (make-closure L.fun/void8800.8.11 0 fun/void8801.7))
        (fun/void8799.9 (make-closure L.fun/void8799.9.12 0 fun/void8800.8)))
       (closure-call fun/void8799.9 fun/void8799.9)))))
(check-by-interp
 '(module
    (letrec ((L.<.81.10
              (lambda (c.82 tmp.45 tmp.46)
                (let ()
                  (if (fixnum? tmp.46)
                    (if (fixnum? tmp.45) (unsafe-fx< tmp.45 tmp.46) (error 4))
                    (error 4)))))
             (L.error?.80.11 (lambda (c.83 tmp.67) (let () (error? tmp.67))))
             (L.unsafe-vector-set!.5.12
              (lambda (c.84 tmp.31 tmp.32 tmp.33)
                (let ()
                  (if (unsafe-fx< tmp.32 (unsafe-vector-length tmp.31))
                    (if (unsafe-fx>= tmp.32 0)
                      (begin (unsafe-vector-set! tmp.31 tmp.32 tmp.33) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.79.13
              (lambda (c.85 tmp.55 tmp.56 tmp.57)
                (let ((unsafe-vector-set!.5 (closure-ref c.85 0)))
                  (if (fixnum? tmp.56)
                    (if (vector? tmp.55)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.55
                       tmp.56
                       tmp.57)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.27.14
              (lambda (c.86 len.28 i.30 vec.29)
                (let ((vector-init-loop.27 (closure-ref c.86 0)))
                  (if (eq? len.28 i.30)
                    vec.29
                    (begin
                      (unsafe-vector-set! vec.29 i.30 0)
                      (closure-call
                       vector-init-loop.27
                       vector-init-loop.27
                       len.28
                       (unsafe-fx+ i.30 1)
                       vec.29))))))
             (L.make-init-vector.4.15
              (lambda (c.87 tmp.25)
                (let ((vector-init-loop.27 (closure-ref c.87 0)))
                  (let ((tmp.26 (unsafe-make-vector tmp.25)))
                    (closure-call
                     vector-init-loop.27
                     vector-init-loop.27
                     tmp.25
                     0
                     tmp.26)))))
             (L.make-vector.78.16
              (lambda (c.88 tmp.53)
                (let ((make-init-vector.4 (closure-ref c.88 0)))
                  (if (fixnum? tmp.53)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.53)
                    (error 8)))))
             (L.fixnum?.77.17 (lambda (c.89 tmp.62) (let () (fixnum? tmp.62))))
             (L.fun/any8804.8.18
              (lambda (c.90 oprand0.10 oprand1.9) (let () (error 108)))))
      (cletrec
       ((<.81 (make-closure L.<.81.10 2))
        (error?.80 (make-closure L.error?.80.11 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.12 3))
        (vector-set!.79
         (make-closure L.vector-set!.79.13 3 unsafe-vector-set!.5))
        (vector-init-loop.27
         (make-closure L.vector-init-loop.27.14 3 vector-init-loop.27))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.15 1 vector-init-loop.27))
        (make-vector.78
         (make-closure L.make-vector.78.16 1 make-init-vector.4))
        (fixnum?.77 (make-closure L.fixnum?.77.17 1))
        (fun/any8804.8 (make-closure L.fun/any8804.8.18 2)))
       (if (closure-call
            fixnum?.77
            fixnum?.77
            (closure-call fun/any8804.8 fun/any8804.8 empty (void)))
         (let ((boolean0.12 #f) (boolean1.11 #t)) #t)
         (closure-call
          <.81
          <.81
          (if 154 (if 56 (if 94 (if 97 (if 119 21 #f) #f) #f) #f) #f)
          (let ((void0.15 (void))
                (vector1.14
                 (let ((tmp.7.16
                        (closure-call make-vector.78 make-vector.78 8)))
                   (let ((g43047001.17
                          (closure-call
                           vector-set!.79
                           vector-set!.79
                           tmp.7.16
                           0
                           1)))
                     (if (closure-call error?.80 error?.80 g43047001.17)
                       g43047001.17
                       (let ((g43047002.18
                              (closure-call
                               vector-set!.79
                               vector-set!.79
                               tmp.7.16
                               1
                               2)))
                         (if (closure-call error?.80 error?.80 g43047002.18)
                           g43047002.18
                           (let ((g43047003.19
                                  (closure-call
                                   vector-set!.79
                                   vector-set!.79
                                   tmp.7.16
                                   2
                                   3)))
                             (if (closure-call
                                  error?.80
                                  error?.80
                                  g43047003.19)
                               g43047003.19
                               (let ((g43047004.20
                                      (closure-call
                                       vector-set!.79
                                       vector-set!.79
                                       tmp.7.16
                                       3
                                       4)))
                                 (if (closure-call
                                      error?.80
                                      error?.80
                                      g43047004.20)
                                   g43047004.20
                                   (let ((g43047005.21
                                          (closure-call
                                           vector-set!.79
                                           vector-set!.79
                                           tmp.7.16
                                           4
                                           5)))
                                     (if (closure-call
                                          error?.80
                                          error?.80
                                          g43047005.21)
                                       g43047005.21
                                       (let ((g43047006.22
                                              (closure-call
                                               vector-set!.79
                                               vector-set!.79
                                               tmp.7.16
                                               5
                                               6)))
                                         (if (closure-call
                                              error?.80
                                              error?.80
                                              g43047006.22)
                                           g43047006.22
                                           (let ((g43047007.23
                                                  (closure-call
                                                   vector-set!.79
                                                   vector-set!.79
                                                   tmp.7.16
                                                   6
                                                   7)))
                                             (if (closure-call
                                                  error?.80
                                                  error?.80
                                                  g43047007.23)
                                               g43047007.23
                                               (let ((g43047008.24
                                                      (closure-call
                                                       vector-set!.79
                                                       vector-set!.79
                                                       tmp.7.16
                                                       7
                                                       8)))
                                                 (if (closure-call
                                                      error?.80
                                                      error?.80
                                                      g43047008.24)
                                                   g43047008.24
                                                   tmp.7.16))))))))))))))))))
                (void2.13 (void)))
            92)))))))
(check-by-interp
 '(module
    (letrec ((L.cons.61.10
              (lambda (c.62 tmp.56 tmp.57) (let () (cons tmp.56 tmp.57))))
             (L.fun/fixnum8807.7.11
              (lambda (c.63)
                (let ((cons.61 (closure-ref c.63 0)))
                  (let ((pair0.8
                         (closure-call cons.61 cons.61 #\j (error 63))))
                    37)))))
      (cletrec
       ((cons.61 (make-closure L.cons.61.10 2))
        (fun/fixnum8807.7 (make-closure L.fun/fixnum8807.7.11 0 cons.61)))
       (let () (closure-call fun/fixnum8807.7 fun/fixnum8807.7))))))
(check-by-interp
 '(module
    (let ((void0.7 (if #t (void) (void))))
      (let ((void0.9 (void)) (empty1.8 empty)) (void)))))
(check-by-interp
 '(module
    (let ((empty0.7 (let ((fixnum0.9 108) (error1.8 (error 116))) empty)))
      (if #f empty empty))))
(check-by-interp
 '(module
    (letrec ((L.error?.70.10 (lambda (c.71 tmp.60) (let () (error? tmp.60)))))
      (cletrec
       ((error?.70 (make-closure L.error?.70.10 1)))
       (let ((empty0.10 (let ((tmp.7.11 empty)) (if tmp.7.11 tmp.7.11 empty)))
             (ascii-char1.9
              (let ((g43062278.12
                     (let ((g43062279.13 #\_))
                       (if (closure-call error?.70 error?.70 g43062279.13)
                         g43062279.13
                         (let ((g43062280.14 #\Z))
                           (if (closure-call error?.70 error?.70 g43062280.14)
                             g43062280.14
                             (let ((g43062281.15 #\u))
                               (if (closure-call
                                    error?.70
                                    error?.70
                                    g43062281.15)
                                 g43062281.15
                                 #\Q))))))))
                (if (closure-call error?.70 error?.70 g43062278.12)
                  g43062278.12
                  (let ((g43062282.16 (let () #\^)))
                    (if (closure-call error?.70 error?.70 g43062282.16)
                      g43062282.16
                      (let ((g43062283.17 (let () #\l)))
                        (if (closure-call error?.70 error?.70 g43062283.17)
                          g43062283.17
                          (let () #\m))))))))
             (error2.8 (let () (error 52))))
         (let () 18))))))
(check-by-interp
 '(module
    (letrec ((L.+.61.10
              (lambda (c.62 tmp.24 tmp.25)
                (let ()
                  (if (fixnum? tmp.25)
                    (if (fixnum? tmp.24) (unsafe-fx+ tmp.24 tmp.25) (error 2))
                    (error 2)))))
             (L.cons.60.11
              (lambda (c.63 tmp.55 tmp.56) (let () (cons tmp.55 tmp.56)))))
      (cletrec
       ((|+.61| (make-closure L.+.61.10 2))
        (cons.60 (make-closure L.cons.60.11 2)))
       (closure-call
        |+.61|
        |+.61|
        (if #t 94 161)
        (let ((pair0.7
               (closure-call
                cons.60
                cons.60
                empty
                (closure-call
                 cons.60
                 cons.60
                 205
                 (closure-call
                  cons.60
                  cons.60
                  #f
                  (closure-call
                   cons.60
                   cons.60
                   (closure-call
                    cons.60
                    cons.60
                    34
                    (closure-call cons.60 cons.60 258 empty))
                   (closure-call
                    cons.60
                    cons.60
                    #\L
                    (closure-call
                     cons.60
                     cons.60
                     empty
                     (closure-call
                      cons.60
                      cons.60
                      #f
                      (closure-call cons.60 cons.60 84 empty))))))))))
          (if #f 39 166)))))))
(check-by-interp
 '(module
    (letrec ((L.cons.64.10
              (lambda (c.65 tmp.59 tmp.60) (let () (cons tmp.59 tmp.60))))
             (L.fun/ascii-char8826.7.11 (lambda (c.66) (let () #\k)))
             (L.fun/ascii-char8823.8.12
              (lambda (c.67)
                (let ((fun/ascii-char8826.7 (closure-ref c.67 0))
                      (fun/ascii-char8825.9 (closure-ref c.67 1))
                      (cons.64 (closure-ref c.67 2))
                      (fun/boolean8824.10 (closure-ref c.67 3)))
                  (if (closure-call
                       fun/boolean8824.10
                       fun/boolean8824.10
                       (closure-call
                        cons.64
                        cons.64
                        112
                        (closure-call cons.64 cons.64 300 empty)))
                    (closure-call fun/ascii-char8825.9 fun/ascii-char8825.9)
                    (closure-call
                     fun/ascii-char8826.7
                     fun/ascii-char8826.7)))))
             (L.fun/ascii-char8825.9.13 (lambda (c.68) (let () #\r)))
             (L.fun/boolean8824.10.14 (lambda (c.69 oprand0.11) (let () #f))))
      (cletrec
       ((cons.64 (make-closure L.cons.64.10 2))
        (fun/ascii-char8826.7 (make-closure L.fun/ascii-char8826.7.11 0))
        (fun/ascii-char8823.8
         (make-closure
          L.fun/ascii-char8823.8.12
          0
          fun/ascii-char8826.7
          fun/ascii-char8825.9
          cons.64
          fun/boolean8824.10))
        (fun/ascii-char8825.9 (make-closure L.fun/ascii-char8825.9.13 0))
        (fun/boolean8824.10 (make-closure L.fun/boolean8824.10.14 1)))
       (closure-call fun/ascii-char8823.8 fun/ascii-char8823.8)))))
(check-by-interp
 '(module
    (letrec ((L.fun/boolean8831.7.10
              (lambda (c.66)
                (let ((fun/boolean8832.9 (closure-ref c.66 0)))
                  (closure-call fun/boolean8832.9 fun/boolean8832.9))))
             (L.fun/boolean8829.8.11
              (lambda (c.67 oprand0.11)
                (let ((fun/boolean8830.10 (closure-ref c.67 0)))
                  (closure-call fun/boolean8830.10 fun/boolean8830.10))))
             (L.fun/boolean8832.9.12 (lambda (c.68) (let () #t)))
             (L.fun/boolean8830.10.13
              (lambda (c.69)
                (let ((fun/boolean8831.7 (closure-ref c.69 0)))
                  (closure-call fun/boolean8831.7 fun/boolean8831.7)))))
      (cletrec
       ((fun/boolean8831.7
         (make-closure L.fun/boolean8831.7.10 0 fun/boolean8832.9))
        (fun/boolean8829.8
         (make-closure L.fun/boolean8829.8.11 1 fun/boolean8830.10))
        (fun/boolean8832.9 (make-closure L.fun/boolean8832.9.12 0))
        (fun/boolean8830.10
         (make-closure L.fun/boolean8830.10.13 0 fun/boolean8831.7)))
       (closure-call
        fun/boolean8829.8
        fun/boolean8829.8
        (if (let ((void0.12 (void))) #f)
          (if #f empty empty)
          (let ((void0.13 (void))) empty)))))))
(check-by-interp
 '(module
    (letrec ((L.unsafe-vector-set!.5.10
              (lambda (c.82 tmp.33 tmp.34 tmp.35)
                (let ()
                  (if (unsafe-fx< tmp.34 (unsafe-vector-length tmp.33))
                    (if (unsafe-fx>= tmp.34 0)
                      (begin (unsafe-vector-set! tmp.33 tmp.34 tmp.35) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.81.11
              (lambda (c.83 tmp.57 tmp.58 tmp.59)
                (let ((unsafe-vector-set!.5 (closure-ref c.83 0)))
                  (if (fixnum? tmp.58)
                    (if (vector? tmp.57)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.57
                       tmp.58
                       tmp.59)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.29.12
              (lambda (c.84 len.30 i.32 vec.31)
                (let ((vector-init-loop.29 (closure-ref c.84 0)))
                  (if (eq? len.30 i.32)
                    vec.31
                    (begin
                      (unsafe-vector-set! vec.31 i.32 0)
                      (closure-call
                       vector-init-loop.29
                       vector-init-loop.29
                       len.30
                       (unsafe-fx+ i.32 1)
                       vec.31))))))
             (L.make-init-vector.4.13
              (lambda (c.85 tmp.27)
                (let ((vector-init-loop.29 (closure-ref c.85 0)))
                  (let ((tmp.28 (unsafe-make-vector tmp.27)))
                    (closure-call
                     vector-init-loop.29
                     vector-init-loop.29
                     tmp.27
                     0
                     tmp.28)))))
             (L.make-vector.80.14
              (lambda (c.86 tmp.55)
                (let ((make-init-vector.4 (closure-ref c.86 0)))
                  (if (fixnum? tmp.55)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.55)
                    (error 8)))))
             (L.error?.79.15 (lambda (c.87 tmp.69) (let () (error? tmp.69)))))
      (cletrec
       ((unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.10 3))
        (vector-set!.81
         (make-closure L.vector-set!.81.11 3 unsafe-vector-set!.5))
        (vector-init-loop.29
         (make-closure L.vector-init-loop.29.12 3 vector-init-loop.29))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.13 1 vector-init-loop.29))
        (make-vector.80
         (make-closure L.make-vector.80.14 1 make-init-vector.4))
        (error?.79 (make-closure L.error?.79.15 1)))
       (if (let ((g43077547.8 (let () #t)))
             (if (closure-call error?.79 error?.79 g43077547.8)
               g43077547.8
               (let ((g43077548.9
                      (if #t
                        (if #f
                          (if #f (if #t (if #t (if #t #t #f) #f) #f) #f)
                          #f)
                        #f)))
                 (if (closure-call error?.79 error?.79 g43077548.9)
                   g43077548.9
                   (let ((g43077549.10 (if #t #f #f)))
                     (if (closure-call error?.79 error?.79 g43077549.10)
                       g43077549.10
                       (let ((g43077550.11 (if #f #f #t)))
                         (if (closure-call error?.79 error?.79 g43077550.11)
                           g43077550.11
                           (let () #f)))))))))
         (let ((error0.14 (error 211)) (boolean1.13 #f) (boolean2.12 #t))
           (void))
         (let ((ascii-char0.17 #\F)
               (vector1.16
                (let ((tmp.7.18
                       (closure-call make-vector.80 make-vector.80 8)))
                  (let ((g43077551.19
                         (closure-call
                          vector-set!.81
                          vector-set!.81
                          tmp.7.18
                          0
                          1)))
                    (if (closure-call error?.79 error?.79 g43077551.19)
                      g43077551.19
                      (let ((g43077552.20
                             (closure-call
                              vector-set!.81
                              vector-set!.81
                              tmp.7.18
                              1
                              2)))
                        (if (closure-call error?.79 error?.79 g43077552.20)
                          g43077552.20
                          (let ((g43077553.21
                                 (closure-call
                                  vector-set!.81
                                  vector-set!.81
                                  tmp.7.18
                                  2
                                  3)))
                            (if (closure-call error?.79 error?.79 g43077553.21)
                              g43077553.21
                              (let ((g43077554.22
                                     (closure-call
                                      vector-set!.81
                                      vector-set!.81
                                      tmp.7.18
                                      3
                                      4)))
                                (if (closure-call
                                     error?.79
                                     error?.79
                                     g43077554.22)
                                  g43077554.22
                                  (let ((g43077555.23
                                         (closure-call
                                          vector-set!.81
                                          vector-set!.81
                                          tmp.7.18
                                          4
                                          5)))
                                    (if (closure-call
                                         error?.79
                                         error?.79
                                         g43077555.23)
                                      g43077555.23
                                      (let ((g43077556.24
                                             (closure-call
                                              vector-set!.81
                                              vector-set!.81
                                              tmp.7.18
                                              5
                                              6)))
                                        (if (closure-call
                                             error?.79
                                             error?.79
                                             g43077556.24)
                                          g43077556.24
                                          (let ((g43077557.25
                                                 (closure-call
                                                  vector-set!.81
                                                  vector-set!.81
                                                  tmp.7.18
                                                  6
                                                  7)))
                                            (if (closure-call
                                                 error?.79
                                                 error?.79
                                                 g43077557.25)
                                              g43077557.25
                                              (let ((g43077558.26
                                                     (closure-call
                                                      vector-set!.81
                                                      vector-set!.81
                                                      tmp.7.18
                                                      7
                                                      8)))
                                                (if (closure-call
                                                     error?.79
                                                     error?.79
                                                     g43077558.26)
                                                  g43077558.26
                                                  tmp.7.18))))))))))))))))))
               (ascii-char2.15 #\L))
           (void)))))))
(check-by-interp
 '(module
    (letrec ((L.cons.138.10
              (lambda (c.140 tmp.130 tmp.131) (let () (cons tmp.130 tmp.131))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.141 tmp.89 tmp.90 tmp.91)
                (let ()
                  (if (unsafe-fx< tmp.90 (unsafe-vector-length tmp.89))
                    (if (unsafe-fx>= tmp.90 0)
                      (begin (unsafe-vector-set! tmp.89 tmp.90 tmp.91) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.137.12
              (lambda (c.142 tmp.113 tmp.114 tmp.115)
                (let ((unsafe-vector-set!.5 (closure-ref c.142 0)))
                  (if (fixnum? tmp.114)
                    (if (vector? tmp.113)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.113
                       tmp.114
                       tmp.115)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.85.13
              (lambda (c.143 len.86 i.88 vec.87)
                (let ((vector-init-loop.85 (closure-ref c.143 0)))
                  (if (eq? len.86 i.88)
                    vec.87
                    (begin
                      (unsafe-vector-set! vec.87 i.88 0)
                      (closure-call
                       vector-init-loop.85
                       vector-init-loop.85
                       len.86
                       (unsafe-fx+ i.88 1)
                       vec.87))))))
             (L.make-init-vector.4.14
              (lambda (c.144 tmp.83)
                (let ((vector-init-loop.85 (closure-ref c.144 0)))
                  (let ((tmp.84 (unsafe-make-vector tmp.83)))
                    (closure-call
                     vector-init-loop.85
                     vector-init-loop.85
                     tmp.83
                     0
                     tmp.84)))))
             (L.make-vector.136.15
              (lambda (c.145 tmp.111)
                (let ((make-init-vector.4 (closure-ref c.145 0)))
                  (if (fixnum? tmp.111)
                    (closure-call
                     make-init-vector.4
                     make-init-vector.4
                     tmp.111)
                    (error 8)))))
             (L.error?.135.16
              (lambda (c.146 tmp.125) (let () (error? tmp.125))))
             (L.fun/ascii-char8840.13.17
              (lambda (c.147 oprand0.19 oprand1.18) (let () #\M)))
             (L.fun/ascii-char8839.14.18
              (lambda (c.148 oprand0.21 oprand1.20) (let () #\q)))
             (L.fun/ascii-char8841.15.19
              (lambda (c.149 oprand0.23 oprand1.22) (let () #\p)))
             (L.fun/boolean8837.16.20
              (lambda (c.150 oprand0.25 oprand1.24)
                (let ((fun/boolean8838.17 (closure-ref c.150 0)))
                  (closure-call fun/boolean8838.17 fun/boolean8838.17))))
             (L.fun/boolean8838.17.21 (lambda (c.151) (let () #f))))
      (cletrec
       ((cons.138 (make-closure L.cons.138.10 2))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.137
         (make-closure L.vector-set!.137.12 3 unsafe-vector-set!.5))
        (vector-init-loop.85
         (make-closure L.vector-init-loop.85.13 3 vector-init-loop.85))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.85))
        (make-vector.136
         (make-closure L.make-vector.136.15 1 make-init-vector.4))
        (error?.135 (make-closure L.error?.135.16 1))
        (fun/ascii-char8840.13 (make-closure L.fun/ascii-char8840.13.17 2))
        (fun/ascii-char8839.14 (make-closure L.fun/ascii-char8839.14.18 2))
        (fun/ascii-char8841.15 (make-closure L.fun/ascii-char8841.15.19 2))
        (fun/boolean8837.16
         (make-closure L.fun/boolean8837.16.20 2 fun/boolean8838.17))
        (fun/boolean8838.17 (make-closure L.fun/boolean8838.17.21 0)))
       (if (closure-call
            fun/boolean8837.16
            fun/boolean8837.16
            (let ((g43081376.26 (error 9)))
              (if (closure-call error?.135 error?.135 g43081376.26)
                g43081376.26
                (let ((g43081377.27 (error 98)))
                  (if (closure-call error?.135 error?.135 g43081377.27)
                    g43081377.27
                    (let ((g43081378.28 (error 17)))
                      (if (closure-call error?.135 error?.135 g43081378.28)
                        g43081378.28
                        (error 22)))))))
            (let ((g43081379.29
                   (let ((tmp.7.30
                          (closure-call make-vector.136 make-vector.136 8)))
                     (let ((g43081380.31
                            (closure-call
                             vector-set!.137
                             vector-set!.137
                             tmp.7.30
                             0
                             0)))
                       (if (closure-call error?.135 error?.135 g43081380.31)
                         g43081380.31
                         (let ((g43081381.32
                                (closure-call
                                 vector-set!.137
                                 vector-set!.137
                                 tmp.7.30
                                 1
                                 1)))
                           (if (closure-call
                                error?.135
                                error?.135
                                g43081381.32)
                             g43081381.32
                             (let ((g43081382.33
                                    (closure-call
                                     vector-set!.137
                                     vector-set!.137
                                     tmp.7.30
                                     2
                                     2)))
                               (if (closure-call
                                    error?.135
                                    error?.135
                                    g43081382.33)
                                 g43081382.33
                                 (let ((g43081383.34
                                        (closure-call
                                         vector-set!.137
                                         vector-set!.137
                                         tmp.7.30
                                         3
                                         3)))
                                   (if (closure-call
                                        error?.135
                                        error?.135
                                        g43081383.34)
                                     g43081383.34
                                     (let ((g43081384.35
                                            (closure-call
                                             vector-set!.137
                                             vector-set!.137
                                             tmp.7.30
                                             4
                                             4)))
                                       (if (closure-call
                                            error?.135
                                            error?.135
                                            g43081384.35)
                                         g43081384.35
                                         (let ((g43081385.36
                                                (closure-call
                                                 vector-set!.137
                                                 vector-set!.137
                                                 tmp.7.30
                                                 5
                                                 5)))
                                           (if (closure-call
                                                error?.135
                                                error?.135
                                                g43081385.36)
                                             g43081385.36
                                             (let ((g43081386.37
                                                    (closure-call
                                                     vector-set!.137
                                                     vector-set!.137
                                                     tmp.7.30
                                                     6
                                                     6)))
                                               (if (closure-call
                                                    error?.135
                                                    error?.135
                                                    g43081386.37)
                                                 g43081386.37
                                                 (let ((g43081387.38
                                                        (closure-call
                                                         vector-set!.137
                                                         vector-set!.137
                                                         tmp.7.30
                                                         7
                                                         7)))
                                                   (if (closure-call
                                                        error?.135
                                                        error?.135
                                                        g43081387.38)
                                                     g43081387.38
                                                     tmp.7.30)))))))))))))))))))
              (if (closure-call error?.135 error?.135 g43081379.29)
                g43081379.29
                (let ((g43081388.39
                       (let ((tmp.8.40
                              (closure-call
                               make-vector.136
                               make-vector.136
                               8)))
                         (let ((g43081389.41
                                (closure-call
                                 vector-set!.137
                                 vector-set!.137
                                 tmp.8.40
                                 0
                                 1)))
                           (if (closure-call
                                error?.135
                                error?.135
                                g43081389.41)
                             g43081389.41
                             (let ((g43081390.42
                                    (closure-call
                                     vector-set!.137
                                     vector-set!.137
                                     tmp.8.40
                                     1
                                     2)))
                               (if (closure-call
                                    error?.135
                                    error?.135
                                    g43081390.42)
                                 g43081390.42
                                 (let ((g43081391.43
                                        (closure-call
                                         vector-set!.137
                                         vector-set!.137
                                         tmp.8.40
                                         2
                                         3)))
                                   (if (closure-call
                                        error?.135
                                        error?.135
                                        g43081391.43)
                                     g43081391.43
                                     (let ((g43081392.44
                                            (closure-call
                                             vector-set!.137
                                             vector-set!.137
                                             tmp.8.40
                                             3
                                             4)))
                                       (if (closure-call
                                            error?.135
                                            error?.135
                                            g43081392.44)
                                         g43081392.44
                                         (let ((g43081393.45
                                                (closure-call
                                                 vector-set!.137
                                                 vector-set!.137
                                                 tmp.8.40
                                                 4
                                                 5)))
                                           (if (closure-call
                                                error?.135
                                                error?.135
                                                g43081393.45)
                                             g43081393.45
                                             (let ((g43081394.46
                                                    (closure-call
                                                     vector-set!.137
                                                     vector-set!.137
                                                     tmp.8.40
                                                     5
                                                     6)))
                                               (if (closure-call
                                                    error?.135
                                                    error?.135
                                                    g43081394.46)
                                                 g43081394.46
                                                 (let ((g43081395.47
                                                        (closure-call
                                                         vector-set!.137
                                                         vector-set!.137
                                                         tmp.8.40
                                                         6
                                                         7)))
                                                   (if (closure-call
                                                        error?.135
                                                        error?.135
                                                        g43081395.47)
                                                     g43081395.47
                                                     (let ((g43081396.48
                                                            (closure-call
                                                             vector-set!.137
                                                             vector-set!.137
                                                             tmp.8.40
                                                             7
                                                             8)))
                                                       (if (closure-call
                                                            error?.135
                                                            error?.135
                                                            g43081396.48)
                                                         g43081396.48
                                                         tmp.8.40)))))))))))))))))))
                  (if (closure-call error?.135 error?.135 g43081388.39)
                    g43081388.39
                    (let ((tmp.9.49
                           (closure-call make-vector.136 make-vector.136 8)))
                      (let ((g43081397.50
                             (closure-call
                              vector-set!.137
                              vector-set!.137
                              tmp.9.49
                              0
                              1)))
                        (if (closure-call error?.135 error?.135 g43081397.50)
                          g43081397.50
                          (let ((g43081398.51
                                 (closure-call
                                  vector-set!.137
                                  vector-set!.137
                                  tmp.9.49
                                  1
                                  2)))
                            (if (closure-call
                                 error?.135
                                 error?.135
                                 g43081398.51)
                              g43081398.51
                              (let ((g43081399.52
                                     (closure-call
                                      vector-set!.137
                                      vector-set!.137
                                      tmp.9.49
                                      2
                                      3)))
                                (if (closure-call
                                     error?.135
                                     error?.135
                                     g43081399.52)
                                  g43081399.52
                                  (let ((g43081400.53
                                         (closure-call
                                          vector-set!.137
                                          vector-set!.137
                                          tmp.9.49
                                          3
                                          4)))
                                    (if (closure-call
                                         error?.135
                                         error?.135
                                         g43081400.53)
                                      g43081400.53
                                      (let ((g43081401.54
                                             (closure-call
                                              vector-set!.137
                                              vector-set!.137
                                              tmp.9.49
                                              4
                                              5)))
                                        (if (closure-call
                                             error?.135
                                             error?.135
                                             g43081401.54)
                                          g43081401.54
                                          (let ((g43081402.55
                                                 (closure-call
                                                  vector-set!.137
                                                  vector-set!.137
                                                  tmp.9.49
                                                  5
                                                  6)))
                                            (if (closure-call
                                                 error?.135
                                                 error?.135
                                                 g43081402.55)
                                              g43081402.55
                                              (let ((g43081403.56
                                                     (closure-call
                                                      vector-set!.137
                                                      vector-set!.137
                                                      tmp.9.49
                                                      6
                                                      7)))
                                                (if (closure-call
                                                     error?.135
                                                     error?.135
                                                     g43081403.56)
                                                  g43081403.56
                                                  (let ((g43081404.57
                                                         (closure-call
                                                          vector-set!.137
                                                          vector-set!.137
                                                          tmp.9.49
                                                          7
                                                          8)))
                                                    (if (closure-call
                                                         error?.135
                                                         error?.135
                                                         g43081404.57)
                                                      g43081404.57
                                                      tmp.9.49))))))))))))))))))))))
         (if (if #t #\D #\R)
           (if (let ((g43081405.58 #\X))
                 (if (closure-call error?.135 error?.135 g43081405.58)
                   g43081405.58
                   (let ((g43081406.59 #\b))
                     (if (closure-call error?.135 error?.135 g43081406.59)
                       g43081406.59
                       (let ((g43081407.60 #\B))
                         (if (closure-call error?.135 error?.135 g43081407.60)
                           g43081407.60
                           (let ((g43081408.61 #\o))
                             (if (closure-call
                                  error?.135
                                  error?.135
                                  g43081408.61)
                               g43081408.61
                               #\t))))))))
             (if (closure-call
                  fun/ascii-char8839.14
                  fun/ascii-char8839.14
                  empty
                  (closure-call make-vector.136 make-vector.136 8))
               (if (if #f #\B #\R)
                 (if (closure-call
                      fun/ascii-char8840.13
                      fun/ascii-char8840.13
                      (void)
                      #f)
                   (let ((pair0.63
                          (closure-call
                           cons.138
                           cons.138
                           60
                           (closure-call cons.138 cons.138 439 empty)))
                         (empty1.62 empty))
                     #\F)
                   #f)
                 #f)
               #f)
             #f)
           #f)
         (let ((g43081409.64 (if #\N (if #\V (if #\y #\d #f) #f) #f)))
           (if (closure-call error?.135 error?.135 g43081409.64)
             g43081409.64
             (let ((g43081410.65 (if #f #\M #\T)))
               (if (closure-call error?.135 error?.135 g43081410.65)
                 g43081410.65
                 (let ((g43081411.66
                        (let ((g43081412.67 #\s))
                          (if (closure-call error?.135 error?.135 g43081412.67)
                            g43081412.67
                            (let ((g43081413.68 #\t))
                              (if (closure-call
                                   error?.135
                                   error?.135
                                   g43081413.68)
                                g43081413.68
                                (let ((g43081414.69 #\r))
                                  (if (closure-call
                                       error?.135
                                       error?.135
                                       g43081414.69)
                                    g43081414.69
                                    #\W))))))))
                   (if (closure-call error?.135 error?.135 g43081411.66)
                     g43081411.66
                     (let ((g43081415.70
                            (let ((procedure0.73
                                   (letrec ((L.lam.139.22
                                             (lambda (c.152) (let () (void)))))
                                     (cletrec
                                      ((lam.139 (make-closure L.lam.139.22 0)))
                                      lam.139)))
                                  (empty1.72 empty)
                                  (error2.71 (error 52)))
                              #\T)))
                       (if (closure-call error?.135 error?.135 g43081415.70)
                         g43081415.70
                         (let ((g43081416.74
                                (let ((tmp.10.75 #\d))
                                  (if tmp.10.75
                                    tmp.10.75
                                    (let ((tmp.11.76 #\w))
                                      (if tmp.11.76
                                        tmp.11.76
                                        (let ((tmp.12.77 #\l))
                                          (if tmp.12.77 tmp.12.77 #\W))))))))
                           (if (closure-call
                                error?.135
                                error?.135
                                g43081416.74)
                             g43081416.74
                             (let ((g43081417.78
                                    (let ((g43081418.79 #\L))
                                      (if (closure-call
                                           error?.135
                                           error?.135
                                           g43081418.79)
                                        g43081418.79
                                        (let ((g43081419.80 #\K))
                                          (if (closure-call
                                               error?.135
                                               error?.135
                                               g43081419.80)
                                            g43081419.80
                                            (let ((g43081420.81 #\S))
                                              (if (closure-call
                                                   error?.135
                                                   error?.135
                                                   g43081420.81)
                                                g43081420.81
                                                (let ((g43081421.82 #\W))
                                                  (if (closure-call
                                                       error?.135
                                                       error?.135
                                                       g43081421.82)
                                                    g43081421.82
                                                    #\W))))))))))
                               (if (closure-call
                                    error?.135
                                    error?.135
                                    g43081417.78)
                                 g43081417.78
                                 (closure-call
                                  fun/ascii-char8841.15
                                  fun/ascii-char8841.15
                                  empty
                                  118))))))))))))))))))
(check-by-interp
 '(module
    (let ((boolean0.7 (let ((ascii-char0.9 #\U) (error1.8 (error 199))) #f)))
      (let ((boolean0.10 #f)) #\K))))
(check-by-interp
 '(module
    (letrec ((L.unsafe-vector-set!.5.10
              (lambda (c.130 tmp.76 tmp.77 tmp.78)
                (let ()
                  (if (unsafe-fx< tmp.77 (unsafe-vector-length tmp.76))
                    (if (unsafe-fx>= tmp.77 0)
                      (begin (unsafe-vector-set! tmp.76 tmp.77 tmp.78) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.126.11
              (lambda (c.131 tmp.100 tmp.101 tmp.102)
                (let ((unsafe-vector-set!.5 (closure-ref c.131 0)))
                  (if (fixnum? tmp.101)
                    (if (vector? tmp.100)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.100
                       tmp.101
                       tmp.102)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.72.12
              (lambda (c.132 len.73 i.75 vec.74)
                (let ((vector-init-loop.72 (closure-ref c.132 0)))
                  (if (eq? len.73 i.75)
                    vec.74
                    (begin
                      (unsafe-vector-set! vec.74 i.75 0)
                      (closure-call
                       vector-init-loop.72
                       vector-init-loop.72
                       len.73
                       (unsafe-fx+ i.75 1)
                       vec.74))))))
             (L.make-init-vector.4.13
              (lambda (c.133 tmp.70)
                (let ((vector-init-loop.72 (closure-ref c.133 0)))
                  (let ((tmp.71 (unsafe-make-vector tmp.70)))
                    (closure-call
                     vector-init-loop.72
                     vector-init-loop.72
                     tmp.70
                     0
                     tmp.71)))))
             (L.make-vector.125.14
              (lambda (c.134 tmp.98)
                (let ((make-init-vector.4 (closure-ref c.134 0)))
                  (if (fixnum? tmp.98)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.98)
                    (error 8)))))
             (L.*.124.15
              (lambda (c.135 tmp.84 tmp.85)
                (let ()
                  (if (fixnum? tmp.85)
                    (if (fixnum? tmp.84) (unsafe-fx* tmp.84 tmp.85) (error 1))
                    (error 1)))))
             (L.error?.123.16
              (lambda (c.136 tmp.112) (let () (error? tmp.112))))
             (L.cons.122.17
              (lambda (c.137 tmp.117 tmp.118) (let () (cons tmp.117 tmp.118))))
             (L.fun/error8847.16.18
              (lambda (c.138)
                (let ((fun/error8848.22 (closure-ref c.138 0)))
                  (closure-call fun/error8848.22 fun/error8848.22))))
             (L.fun/error8846.17.19
              (lambda (c.139 oprand0.27 oprand1.26)
                (let ((fun/error8847.16 (closure-ref c.139 0)))
                  (closure-call fun/error8847.16 fun/error8847.16))))
             (L.fun/pair8849.18.20
              (lambda (c.140 oprand0.28)
                (let ((cons.122 (closure-ref c.140 0)))
                  (closure-call
                   cons.122
                   cons.122
                   200
                   (closure-call cons.122 cons.122 421 empty)))))
             (L.fun/fixnum8851.19.21 (lambda (c.141 oprand0.29) (let () 236)))
             (L.fun/fixnum8850.20.22 (lambda (c.142 oprand0.30) (let () 31)))
             (L.fun/error8852.21.23
              (lambda (c.143)
                (let ((fun/error8853.23 (closure-ref c.143 0)))
                  (closure-call fun/error8853.23 fun/error8853.23))))
             (L.fun/error8848.22.24 (lambda (c.144) (let () (error 200))))
             (L.fun/error8853.23.25 (lambda (c.145) (let () (error 51))))
             (L.fun/error8854.24.26
              (lambda (c.146) (let () (if #f (error 82) (error 144)))))
             (L.fun/error8855.25.27 (lambda (c.147) (let () (error 63)))))
      (cletrec
       ((unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.10 3))
        (vector-set!.126
         (make-closure L.vector-set!.126.11 3 unsafe-vector-set!.5))
        (vector-init-loop.72
         (make-closure L.vector-init-loop.72.12 3 vector-init-loop.72))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.13 1 vector-init-loop.72))
        (make-vector.125
         (make-closure L.make-vector.125.14 1 make-init-vector.4))
        (*.124 (make-closure L.*.124.15 2))
        (error?.123 (make-closure L.error?.123.16 1))
        (cons.122 (make-closure L.cons.122.17 2))
        (fun/error8847.16
         (make-closure L.fun/error8847.16.18 0 fun/error8848.22))
        (fun/error8846.17
         (make-closure L.fun/error8846.17.19 2 fun/error8847.16))
        (fun/pair8849.18 (make-closure L.fun/pair8849.18.20 1 cons.122))
        (fun/fixnum8851.19 (make-closure L.fun/fixnum8851.19.21 1))
        (fun/fixnum8850.20 (make-closure L.fun/fixnum8850.20.22 1))
        (fun/error8852.21
         (make-closure L.fun/error8852.21.23 0 fun/error8853.23))
        (fun/error8848.22 (make-closure L.fun/error8848.22.24 0))
        (fun/error8853.23 (make-closure L.fun/error8853.23.25 0))
        (fun/error8854.24 (make-closure L.fun/error8854.24.26 0))
        (fun/error8855.25 (make-closure L.fun/error8855.25.27 0)))
       (let ((tmp.7.31
              (closure-call
               fun/error8846.17
               fun/error8846.17
               (let ((g43089053.32
                      (let ((g43089054.33
                             (closure-call
                              cons.122
                              cons.122
                              116
                              (closure-call cons.122 cons.122 426 empty))))
                        (if (closure-call error?.123 error?.123 g43089054.33)
                          g43089054.33
                          (closure-call
                           cons.122
                           cons.122
                           249
                           (closure-call cons.122 cons.122 432 empty))))))
                 (if (closure-call error?.123 error?.123 g43089053.32)
                   g43089053.32
                   (closure-call fun/pair8849.18 fun/pair8849.18 #f)))
               (closure-call
                *.124
                *.124
                (closure-call
                 fun/fixnum8850.20
                 fun/fixnum8850.20
                 (closure-call
                  cons.122
                  cons.122
                  106
                  (closure-call cons.122 cons.122 289 empty)))
                (closure-call fun/fixnum8851.19 fun/fixnum8851.19 (void))))))
         (if tmp.7.31
           tmp.7.31
           (let ((tmp.8.34
                  (let ((tmp.9.35 (if #f (error 28) (error 67))))
                    (if tmp.9.35
                      tmp.9.35
                      (let ((tmp.10.36
                             (closure-call fun/error8852.21 fun/error8852.21)))
                        (if tmp.10.36
                          tmp.10.36
                          (if (let ((boolean0.39 #f)
                                    (vector1.38
                                     (let ((tmp.11.40
                                            (closure-call
                                             make-vector.125
                                             make-vector.125
                                             8)))
                                       (let ((g43089055.41
                                              (closure-call
                                               vector-set!.126
                                               vector-set!.126
                                               tmp.11.40
                                               0
                                               0)))
                                         (if (closure-call
                                              error?.123
                                              error?.123
                                              g43089055.41)
                                           g43089055.41
                                           (let ((g43089056.42
                                                  (closure-call
                                                   vector-set!.126
                                                   vector-set!.126
                                                   tmp.11.40
                                                   1
                                                   1)))
                                             (if (closure-call
                                                  error?.123
                                                  error?.123
                                                  g43089056.42)
                                               g43089056.42
                                               (let ((g43089057.43
                                                      (closure-call
                                                       vector-set!.126
                                                       vector-set!.126
                                                       tmp.11.40
                                                       2
                                                       2)))
                                                 (if (closure-call
                                                      error?.123
                                                      error?.123
                                                      g43089057.43)
                                                   g43089057.43
                                                   (let ((g43089058.44
                                                          (closure-call
                                                           vector-set!.126
                                                           vector-set!.126
                                                           tmp.11.40
                                                           3
                                                           3)))
                                                     (if (closure-call
                                                          error?.123
                                                          error?.123
                                                          g43089058.44)
                                                       g43089058.44
                                                       (let ((g43089059.45
                                                              (closure-call
                                                               vector-set!.126
                                                               vector-set!.126
                                                               tmp.11.40
                                                               4
                                                               4)))
                                                         (if (closure-call
                                                              error?.123
                                                              error?.123
                                                              g43089059.45)
                                                           g43089059.45
                                                           (let ((g43089060.46
                                                                  (closure-call
                                                                   vector-set!.126
                                                                   vector-set!.126
                                                                   tmp.11.40
                                                                   5
                                                                   5)))
                                                             (if (closure-call
                                                                  error?.123
                                                                  error?.123
                                                                  g43089060.46)
                                                               g43089060.46
                                                               (let ((g43089061.47
                                                                      (closure-call
                                                                       vector-set!.126
                                                                       vector-set!.126
                                                                       tmp.11.40
                                                                       6
                                                                       6)))
                                                                 (if (closure-call
                                                                      error?.123
                                                                      error?.123
                                                                      g43089061.47)
                                                                   g43089061.47
                                                                   (let ((g43089062.48
                                                                          (closure-call
                                                                           vector-set!.126
                                                                           vector-set!.126
                                                                           tmp.11.40
                                                                           7
                                                                           7)))
                                                                     (if (closure-call
                                                                          error?.123
                                                                          error?.123
                                                                          g43089062.48)
                                                                       g43089062.48
                                                                       tmp.11.40))))))))))))))))))
                                    (pair2.37
                                     (closure-call
                                      cons.122
                                      cons.122
                                      223
                                      (closure-call
                                       cons.122
                                       cons.122
                                       355
                                       empty))))
                                (error 185))
                            (if (let ((ascii-char0.49 #\R)) (error 120))
                              (if (if #f (error 82) (error 203))
                                (if (if #t (error 72) (error 18))
                                  (if (let ((fixnum0.52 211)
                                            (ascii-char1.51 #\O)
                                            (void2.50 (void)))
                                        (error 201))
                                    (if #t (error 204) (error 149))
                                    #f)
                                  #f)
                                #f)
                              #f)
                            #f)))))))
             (if tmp.8.34
               tmp.8.34
               (let ((tmp.12.53
                      (closure-call fun/error8854.24 fun/error8854.24)))
                 (if tmp.12.53
                   tmp.12.53
                   (let ((tmp.13.54
                          (let ((error0.57
                                 (closure-call
                                  fun/error8855.25
                                  fun/error8855.25))
                                (vector1.56
                                 (let ((tmp.14.58
                                        (closure-call
                                         make-vector.125
                                         make-vector.125
                                         8)))
                                   (let ((g43089063.59
                                          (closure-call
                                           vector-set!.126
                                           vector-set!.126
                                           tmp.14.58
                                           0
                                           #\P)))
                                     (if (closure-call
                                          error?.123
                                          error?.123
                                          g43089063.59)
                                       g43089063.59
                                       (let ((g43089064.60
                                              (closure-call
                                               vector-set!.126
                                               vector-set!.126
                                               tmp.14.58
                                               1
                                               #t)))
                                         (if (closure-call
                                              error?.123
                                              error?.123
                                              g43089064.60)
                                           g43089064.60
                                           (let ((g43089065.61
                                                  (closure-call
                                                   vector-set!.126
                                                   vector-set!.126
                                                   tmp.14.58
                                                   2
                                                   #t)))
                                             (if (closure-call
                                                  error?.123
                                                  error?.123
                                                  g43089065.61)
                                               g43089065.61
                                               (let ((g43089066.62
                                                      (closure-call
                                                       vector-set!.126
                                                       vector-set!.126
                                                       tmp.14.58
                                                       3
                                                       (letrec ((L.lam.127.28
                                                                 (lambda (c.148)
                                                                   (let ()
                                                                     731))))
                                                         (cletrec
                                                          ((lam.127
                                                            (make-closure
                                                             L.lam.127.28
                                                             0)))
                                                          lam.127)))))
                                                 (if (closure-call
                                                      error?.123
                                                      error?.123
                                                      g43089066.62)
                                                   g43089066.62
                                                   (let ((g43089067.63
                                                          (closure-call
                                                           vector-set!.126
                                                           vector-set!.126
                                                           tmp.14.58
                                                           4
                                                           (error 110))))
                                                     (if (closure-call
                                                          error?.123
                                                          error?.123
                                                          g43089067.63)
                                                       g43089067.63
                                                       (let ((g43089068.64
                                                              (closure-call
                                                               vector-set!.126
                                                               vector-set!.126
                                                               tmp.14.58
                                                               5
                                                               (error 120))))
                                                         (if (closure-call
                                                              error?.123
                                                              error?.123
                                                              g43089068.64)
                                                           g43089068.64
                                                           (let ((g43089069.65
                                                                  (closure-call
                                                                   vector-set!.126
                                                                   vector-set!.126
                                                                   tmp.14.58
                                                                   6
                                                                   (error
                                                                    249))))
                                                             (if (closure-call
                                                                  error?.123
                                                                  error?.123
                                                                  g43089069.65)
                                                               g43089069.65
                                                               (let ((g43089070.66
                                                                      (closure-call
                                                                       vector-set!.126
                                                                       vector-set!.126
                                                                       tmp.14.58
                                                                       7
                                                                       (letrec ((L.lam.128.29
                                                                                 (lambda (c.149)
                                                                                   (let ()
                                                                                     807))))
                                                                         (cletrec
                                                                          ((lam.128
                                                                            (make-closure
                                                                             L.lam.128.29
                                                                             0)))
                                                                          lam.128)))))
                                                                 (if (closure-call
                                                                      error?.123
                                                                      error?.123
                                                                      g43089070.66)
                                                                   g43089070.66
                                                                   tmp.14.58))))))))))))))))))
                                (void2.55 (let () (void))))
                            (let () (error 11)))))
                     (if tmp.13.54
                       tmp.13.54
                       (let ((procedure0.67
                              (letrec ((L.lam.129.30
                                        (lambda (c.150 oprand0.68)
                                          (let ()
                                            (let ((tmp.15.69 #f))
                                              (if tmp.15.69 tmp.15.69 #t))))))
                                (cletrec
                                 ((lam.129 (make-closure L.lam.129.30 1)))
                                 lam.129))))
                         (let () (error 252)))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.-.114.10
              (lambda (c.117 tmp.76 tmp.77)
                (let ()
                  (if (fixnum? tmp.77)
                    (if (fixnum? tmp.76) (unsafe-fx- tmp.76 tmp.77) (error 3))
                    (error 3)))))
             (L.vector-init-loop.60.11
              (lambda (c.118 len.61 i.63 vec.62)
                (let ((vector-init-loop.60 (closure-ref c.118 0)))
                  (if (eq? len.61 i.63)
                    vec.62
                    (begin
                      (unsafe-vector-set! vec.62 i.63 0)
                      (closure-call
                       vector-init-loop.60
                       vector-init-loop.60
                       len.61
                       (unsafe-fx+ i.63 1)
                       vec.62))))))
             (L.make-init-vector.4.12
              (lambda (c.119 tmp.58)
                (let ((vector-init-loop.60 (closure-ref c.119 0)))
                  (let ((tmp.59 (unsafe-make-vector tmp.58)))
                    (closure-call
                     vector-init-loop.60
                     vector-init-loop.60
                     tmp.58
                     0
                     tmp.59)))))
             (L.make-vector.113.13
              (lambda (c.120 tmp.86)
                (let ((make-init-vector.4 (closure-ref c.120 0)))
                  (if (fixnum? tmp.86)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.86)
                    (error 8)))))
             (L.cons.112.14
              (lambda (c.121 tmp.105 tmp.106) (let () (cons tmp.105 tmp.106))))
             (L.error?.111.15
              (lambda (c.122 tmp.100) (let () (error? tmp.100))))
             (L.unsafe-vector-set!.5.16
              (lambda (c.123 tmp.64 tmp.65 tmp.66)
                (let ()
                  (if (unsafe-fx< tmp.65 (unsafe-vector-length tmp.64))
                    (if (unsafe-fx>= tmp.65 0)
                      (begin (unsafe-vector-set! tmp.64 tmp.65 tmp.66) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.110.17
              (lambda (c.124 tmp.88 tmp.89 tmp.90)
                (let ((unsafe-vector-set!.5 (closure-ref c.124 0)))
                  (if (fixnum? tmp.89)
                    (if (vector? tmp.88)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.88
                       tmp.89
                       tmp.90)
                      (error 10))
                    (error 10)))))
             (L.fun/fixnum8859.11.18 (lambda (c.125) (let () 240)))
             (L.fun/fixnum8863.12.19 (lambda (c.126) (let () 189)))
             (L.fun/fixnum8864.13.20
              (lambda (c.127 oprand0.19) (let () (let () 246))))
             (L.fun/void8861.14.21
              (lambda (c.128 oprand0.21 oprand1.20)
                (let ((vector-set!.110 (closure-ref c.128 0)))
                  (closure-call
                   vector-set!.110
                   vector-set!.110
                   oprand1.20
                   5
                   (closure-call
                    vector-set!.110
                    vector-set!.110
                    oprand1.20
                    3
                    oprand0.21)))))
             (L.fun/error8865.15.22
              (lambda (c.129 oprand0.22) (let () (error 210))))
             (L.fun/fixnum8858.16.23 (lambda (c.130) (let () (if #f 223 114))))
             (L.fun/fixnum8860.17.24
              (lambda (c.131 oprand0.24 oprand1.23) (let () (let () 190))))
             (L.fun/empty8862.18.25
              (lambda (c.132 oprand0.25) (let () empty))))
      (cletrec
       ((|-.114| (make-closure L.-.114.10 2))
        (vector-init-loop.60
         (make-closure L.vector-init-loop.60.11 3 vector-init-loop.60))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.12 1 vector-init-loop.60))
        (make-vector.113
         (make-closure L.make-vector.113.13 1 make-init-vector.4))
        (cons.112 (make-closure L.cons.112.14 2))
        (error?.111 (make-closure L.error?.111.15 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.16 3))
        (vector-set!.110
         (make-closure L.vector-set!.110.17 3 unsafe-vector-set!.5))
        (fun/fixnum8859.11 (make-closure L.fun/fixnum8859.11.18 0))
        (fun/fixnum8863.12 (make-closure L.fun/fixnum8863.12.19 0))
        (fun/fixnum8864.13 (make-closure L.fun/fixnum8864.13.20 1))
        (fun/void8861.14 (make-closure L.fun/void8861.14.21 2 vector-set!.110))
        (fun/error8865.15 (make-closure L.fun/error8865.15.22 1))
        (fun/fixnum8858.16 (make-closure L.fun/fixnum8858.16.23 0))
        (fun/fixnum8860.17 (make-closure L.fun/fixnum8860.17.24 2))
        (fun/empty8862.18 (make-closure L.fun/empty8862.18.25 1)))
       (let ((g43092885.26
              (let ((tmp.7.27 (if #t 73 215)))
                (if tmp.7.27
                  tmp.7.27
                  (let ((tmp.8.28
                         (closure-call fun/fixnum8858.16 fun/fixnum8858.16)))
                    (if tmp.8.28
                      tmp.8.28
                      (let ((procedure0.31
                             (letrec ((L.lam.115.26
                                       (lambda (c.133) (let () #\V))))
                               (cletrec
                                ((lam.115 (make-closure L.lam.115.26 0)))
                                lam.115)))
                            (error1.30 (error 143))
                            (void2.29 (void)))
                        166)))))))
         (if (closure-call error?.111 error?.111 g43092885.26)
           g43092885.26
           (let ((g43092886.32
                  (let ((pair0.34
                         (closure-call
                          cons.112
                          cons.112
                          empty
                          (closure-call
                           cons.112
                           cons.112
                           #\t
                           (closure-call
                            cons.112
                            cons.112
                            164
                            (closure-call
                             cons.112
                             cons.112
                             empty
                             (closure-call
                              cons.112
                              cons.112
                              177
                              (closure-call
                               cons.112
                               cons.112
                               #\o
                               (closure-call
                                cons.112
                                cons.112
                                (closure-call
                                 cons.112
                                 cons.112
                                 44
                                 (closure-call cons.112 cons.112 451 empty))
                                (closure-call
                                 cons.112
                                 cons.112
                                 #\H
                                 empty)))))))))
                        (fixnum1.33
                         (closure-call fun/fixnum8859.11 fun/fixnum8859.11)))
                    (if #t 42 198))))
             (if (closure-call error?.111 error?.111 g43092886.32)
               g43092886.32
               (let ((g43092887.35
                      (let ((g43092888.36
                             (closure-call
                              fun/fixnum8860.17
                              fun/fixnum8860.17
                              (closure-call
                               fun/void8861.14
                               fun/void8861.14
                               #\J
                               (let ((tmp.9.37
                                      (closure-call
                                       make-vector.113
                                       make-vector.113
                                       8)))
                                 (let ((g43092889.38
                                        (closure-call
                                         vector-set!.110
                                         vector-set!.110
                                         tmp.9.37
                                         0
                                         1)))
                                   (if (closure-call
                                        error?.111
                                        error?.111
                                        g43092889.38)
                                     g43092889.38
                                     (let ((g43092890.39
                                            (closure-call
                                             vector-set!.110
                                             vector-set!.110
                                             tmp.9.37
                                             1
                                             2)))
                                       (if (closure-call
                                            error?.111
                                            error?.111
                                            g43092890.39)
                                         g43092890.39
                                         (let ((g43092891.40
                                                (closure-call
                                                 vector-set!.110
                                                 vector-set!.110
                                                 tmp.9.37
                                                 2
                                                 3)))
                                           (if (closure-call
                                                error?.111
                                                error?.111
                                                g43092891.40)
                                             g43092891.40
                                             (let ((g43092892.41
                                                    (closure-call
                                                     vector-set!.110
                                                     vector-set!.110
                                                     tmp.9.37
                                                     3
                                                     4)))
                                               (if (closure-call
                                                    error?.111
                                                    error?.111
                                                    g43092892.41)
                                                 g43092892.41
                                                 (let ((g43092893.42
                                                        (closure-call
                                                         vector-set!.110
                                                         vector-set!.110
                                                         tmp.9.37
                                                         4
                                                         5)))
                                                   (if (closure-call
                                                        error?.111
                                                        error?.111
                                                        g43092893.42)
                                                     g43092893.42
                                                     (let ((g43092894.43
                                                            (closure-call
                                                             vector-set!.110
                                                             vector-set!.110
                                                             tmp.9.37
                                                             5
                                                             6)))
                                                       (if (closure-call
                                                            error?.111
                                                            error?.111
                                                            g43092894.43)
                                                         g43092894.43
                                                         (let ((g43092895.44
                                                                (closure-call
                                                                 vector-set!.110
                                                                 vector-set!.110
                                                                 tmp.9.37
                                                                 6
                                                                 7)))
                                                           (if (closure-call
                                                                error?.111
                                                                error?.111
                                                                g43092895.44)
                                                             g43092895.44
                                                             (let ((g43092896.45
                                                                    (closure-call
                                                                     vector-set!.110
                                                                     vector-set!.110
                                                                     tmp.9.37
                                                                     7
                                                                     8)))
                                                               (if (closure-call
                                                                    error?.111
                                                                    error?.111
                                                                    g43092896.45)
                                                                 g43092896.45
                                                                 tmp.9.37))))))))))))))))))
                              (closure-call
                               fun/empty8862.18
                               fun/empty8862.18
                               186))))
                        (if (closure-call error?.111 error?.111 g43092888.36)
                          g43092888.36
                          (let ((g43092897.46
                                 (closure-call
                                  |-.114|
                                  |-.114|
                                  (if #f 32 170)
                                  (closure-call
                                   fun/fixnum8863.12
                                   fun/fixnum8863.12))))
                            (if (closure-call
                                 error?.111
                                 error?.111
                                 g43092897.46)
                              g43092897.46
                              (let ((g43092898.47
                                     (let ((fixnum0.49 208) (fixnum1.48 116))
                                       46)))
                                (if (closure-call
                                     error?.111
                                     error?.111
                                     g43092898.47)
                                  g43092898.47
                                  (let ((g43092899.50
                                         (let ((empty0.52 empty)
                                               (boolean1.51 #f))
                                           65)))
                                    (if (closure-call
                                         error?.111
                                         error?.111
                                         g43092899.50)
                                      g43092899.50
                                      (let ((g43092900.53 (if #f 71 196)))
                                        (if (closure-call
                                             error?.111
                                             error?.111
                                             g43092900.53)
                                          g43092900.53
                                          (let ((void0.56 (void))
                                                (error1.55 (error 115))
                                                (pair2.54
                                                 (closure-call
                                                  cons.112
                                                  cons.112
                                                  253
                                                  (closure-call
                                                   cons.112
                                                   cons.112
                                                   276
                                                   empty))))
                                            7)))))))))))))
                 (if (closure-call error?.111 error?.111 g43092887.35)
                   g43092887.35
                   (closure-call
                    fun/fixnum8864.13
                    fun/fixnum8864.13
                    (let ((tmp.10.57 (error 62)))
                      (if tmp.10.57
                        tmp.10.57
                        (closure-call
                         fun/error8865.15
                         fun/error8865.15
                         (letrec ((L.lam.116.27 (lambda (c.134) (let () 976))))
                           (cletrec
                            ((lam.116 (make-closure L.lam.116.27 0)))
                            lam.116))))))))))))))))
(check-by-interp
 '(module
    (letrec ((L.cons.92.10
              (lambda (c.94 tmp.84 tmp.85) (let () (cons tmp.84 tmp.85))))
             (L.error?.91.11 (lambda (c.95 tmp.79) (let () (error? tmp.79))))
             (L.unsafe-vector-set!.5.12
              (lambda (c.96 tmp.43 tmp.44 tmp.45)
                (let ()
                  (if (unsafe-fx< tmp.44 (unsafe-vector-length tmp.43))
                    (if (unsafe-fx>= tmp.44 0)
                      (begin (unsafe-vector-set! tmp.43 tmp.44 tmp.45) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.90.13
              (lambda (c.97 tmp.67 tmp.68 tmp.69)
                (let ((unsafe-vector-set!.5 (closure-ref c.97 0)))
                  (if (fixnum? tmp.68)
                    (if (vector? tmp.67)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.67
                       tmp.68
                       tmp.69)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.39.14
              (lambda (c.98 len.40 i.42 vec.41)
                (let ((vector-init-loop.39 (closure-ref c.98 0)))
                  (if (eq? len.40 i.42)
                    vec.41
                    (begin
                      (unsafe-vector-set! vec.41 i.42 0)
                      (closure-call
                       vector-init-loop.39
                       vector-init-loop.39
                       len.40
                       (unsafe-fx+ i.42 1)
                       vec.41))))))
             (L.make-init-vector.4.15
              (lambda (c.99 tmp.37)
                (let ((vector-init-loop.39 (closure-ref c.99 0)))
                  (let ((tmp.38 (unsafe-make-vector tmp.37)))
                    (closure-call
                     vector-init-loop.39
                     vector-init-loop.39
                     tmp.37
                     0
                     tmp.38)))))
             (L.make-vector.89.16
              (lambda (c.100 tmp.65)
                (let ((make-init-vector.4 (closure-ref c.100 0)))
                  (if (fixnum? tmp.65)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.65)
                    (error 8)))))
             (L.fun/fixnum8869.14.17 (lambda (c.101) (let () 144)))
             (L.fun/fixnum8868.15.18
              (lambda (c.102 oprand0.17 oprand1.16)
                (let ((fun/fixnum8869.14 (closure-ref c.102 0)))
                  (closure-call fun/fixnum8869.14 fun/fixnum8869.14)))))
      (cletrec
       ((cons.92 (make-closure L.cons.92.10 2))
        (error?.91 (make-closure L.error?.91.11 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.12 3))
        (vector-set!.90
         (make-closure L.vector-set!.90.13 3 unsafe-vector-set!.5))
        (vector-init-loop.39
         (make-closure L.vector-init-loop.39.14 3 vector-init-loop.39))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.15 1 vector-init-loop.39))
        (make-vector.89
         (make-closure L.make-vector.89.16 1 make-init-vector.4))
        (fun/fixnum8869.14 (make-closure L.fun/fixnum8869.14.17 0))
        (fun/fixnum8868.15
         (make-closure L.fun/fixnum8868.15.18 2 fun/fixnum8869.14)))
       (if (let ((empty0.20 empty)
                 (vector1.19
                  (let ((tmp.7.21
                         (closure-call make-vector.89 make-vector.89 8)))
                    (let ((g43096720.22
                           (closure-call
                            vector-set!.90
                            vector-set!.90
                            tmp.7.21
                            0
                            1)))
                      (if (closure-call error?.91 error?.91 g43096720.22)
                        g43096720.22
                        (let ((g43096721.23
                               (closure-call
                                vector-set!.90
                                vector-set!.90
                                tmp.7.21
                                1
                                2)))
                          (if (closure-call error?.91 error?.91 g43096721.23)
                            g43096721.23
                            (let ((g43096722.24
                                   (closure-call
                                    vector-set!.90
                                    vector-set!.90
                                    tmp.7.21
                                    2
                                    3)))
                              (if (closure-call
                                   error?.91
                                   error?.91
                                   g43096722.24)
                                g43096722.24
                                (let ((g43096723.25
                                       (closure-call
                                        vector-set!.90
                                        vector-set!.90
                                        tmp.7.21
                                        3
                                        4)))
                                  (if (closure-call
                                       error?.91
                                       error?.91
                                       g43096723.25)
                                    g43096723.25
                                    (let ((g43096724.26
                                           (closure-call
                                            vector-set!.90
                                            vector-set!.90
                                            tmp.7.21
                                            4
                                            5)))
                                      (if (closure-call
                                           error?.91
                                           error?.91
                                           g43096724.26)
                                        g43096724.26
                                        (let ((g43096725.27
                                               (closure-call
                                                vector-set!.90
                                                vector-set!.90
                                                tmp.7.21
                                                5
                                                6)))
                                          (if (closure-call
                                               error?.91
                                               error?.91
                                               g43096725.27)
                                            g43096725.27
                                            (let ((g43096726.28
                                                   (closure-call
                                                    vector-set!.90
                                                    vector-set!.90
                                                    tmp.7.21
                                                    6
                                                    7)))
                                              (if (closure-call
                                                   error?.91
                                                   error?.91
                                                   g43096726.28)
                                                g43096726.28
                                                (let ((g43096727.29
                                                       (closure-call
                                                        vector-set!.90
                                                        vector-set!.90
                                                        tmp.7.21
                                                        7
                                                        8)))
                                                  (if (closure-call
                                                       error?.91
                                                       error?.91
                                                       g43096727.29)
                                                    g43096727.29
                                                    tmp.7.21))))))))))))))))))
                 (procedure2.18
                  (letrec ((L.lam.93.19
                            (lambda (c.103)
                              (let ((cons.92 (closure-ref c.103 0)))
                                (closure-call
                                 cons.92
                                 cons.92
                                 148
                                 (closure-call cons.92 cons.92 308 empty))))))
                    (cletrec
                     ((lam.93 (make-closure L.lam.93.19 0 cons.92)))
                     lam.93))))
             #f)
         (if #f 51 196)
         (closure-call
          fun/fixnum8868.15
          fun/fixnum8868.15
          (let ((tmp.8.30 (void)))
            (if tmp.8.30
              tmp.8.30
              (let ((tmp.9.31 (void)))
                (if tmp.9.31
                  tmp.9.31
                  (let ((tmp.10.32 (void)))
                    (if tmp.10.32
                      tmp.10.32
                      (let ((tmp.11.33 (void)))
                        (if tmp.11.33
                          tmp.11.33
                          (let ((tmp.12.34 (void)))
                            (if tmp.12.34
                              tmp.12.34
                              (let ((tmp.13.35 (void)))
                                (if tmp.13.35 tmp.13.35 (void)))))))))))))
          (let ((g43096728.36 #f))
            (if (closure-call error?.91 error?.91 g43096728.36)
              g43096728.36
              #t))))))))
(check-by-interp
 '(module
    (letrec ((L.cons.68.10
              (lambda (c.69 tmp.63 tmp.64) (let () (cons tmp.63 tmp.64))))
             (L.fun/fixnum8875.7.11
              (lambda (c.70 oprand0.13)
                (let ((fun/fixnum8876.11 (closure-ref c.70 0)))
                  (closure-call fun/fixnum8876.11 fun/fixnum8876.11))))
             (L.fun/fixnum8873.8.12 (lambda (c.71) (let () (let () 155))))
             (L.fun/fixnum8874.9.13
              (lambda (c.72)
                (let ((fun/pair8877.12 (closure-ref c.72 0))
                      (fun/fixnum8875.7 (closure-ref c.72 1)))
                  (closure-call
                   fun/fixnum8875.7
                   fun/fixnum8875.7
                   (closure-call fun/pair8877.12 fun/pair8877.12 #\N)))))
             (L.fun/fixnum8872.10.14
              (lambda (c.73 oprand0.14)
                (let ((fun/fixnum8873.8 (closure-ref c.73 0)))
                  (closure-call fun/fixnum8873.8 fun/fixnum8873.8))))
             (L.fun/fixnum8876.11.15 (lambda (c.74) (let () 203)))
             (L.fun/pair8877.12.16
              (lambda (c.75 oprand0.15)
                (let ((cons.68 (closure-ref c.75 0)))
                  (closure-call
                   cons.68
                   cons.68
                   28
                   (closure-call cons.68 cons.68 385 empty))))))
      (cletrec
       ((cons.68 (make-closure L.cons.68.10 2))
        (fun/fixnum8875.7
         (make-closure L.fun/fixnum8875.7.11 1 fun/fixnum8876.11))
        (fun/fixnum8873.8 (make-closure L.fun/fixnum8873.8.12 0))
        (fun/fixnum8874.9
         (make-closure
          L.fun/fixnum8874.9.13
          0
          fun/pair8877.12
          fun/fixnum8875.7))
        (fun/fixnum8872.10
         (make-closure L.fun/fixnum8872.10.14 1 fun/fixnum8873.8))
        (fun/fixnum8876.11 (make-closure L.fun/fixnum8876.11.15 0))
        (fun/pair8877.12 (make-closure L.fun/pair8877.12.16 1 cons.68)))
       (closure-call
        fun/fixnum8872.10
        fun/fixnum8872.10
        (closure-call fun/fixnum8874.9 fun/fixnum8874.9))))))
(check-by-interp
 '(module
    (if (let ((void0.7 (void))) #t)
      (let ((empty0.10 empty) (empty1.9 empty) (boolean2.8 #t)) #\w)
      (if #t #\F #\w))))
(check-by-interp
 '(module
    (letrec ((L.error?.98.10 (lambda (c.100 tmp.85) (let () (error? tmp.85))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.101 tmp.49 tmp.50 tmp.51)
                (let ()
                  (if (unsafe-fx< tmp.50 (unsafe-vector-length tmp.49))
                    (if (unsafe-fx>= tmp.50 0)
                      (begin (unsafe-vector-set! tmp.49 tmp.50 tmp.51) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.97.12
              (lambda (c.102 tmp.73 tmp.74 tmp.75)
                (let ((unsafe-vector-set!.5 (closure-ref c.102 0)))
                  (if (fixnum? tmp.74)
                    (if (vector? tmp.73)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.73
                       tmp.74
                       tmp.75)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.45.13
              (lambda (c.103 len.46 i.48 vec.47)
                (let ((vector-init-loop.45 (closure-ref c.103 0)))
                  (if (eq? len.46 i.48)
                    vec.47
                    (begin
                      (unsafe-vector-set! vec.47 i.48 0)
                      (closure-call
                       vector-init-loop.45
                       vector-init-loop.45
                       len.46
                       (unsafe-fx+ i.48 1)
                       vec.47))))))
             (L.make-init-vector.4.14
              (lambda (c.104 tmp.43)
                (let ((vector-init-loop.45 (closure-ref c.104 0)))
                  (let ((tmp.44 (unsafe-make-vector tmp.43)))
                    (closure-call
                     vector-init-loop.45
                     vector-init-loop.45
                     tmp.43
                     0
                     tmp.44)))))
             (L.make-vector.96.15
              (lambda (c.105 tmp.71)
                (let ((make-init-vector.4 (closure-ref c.105 0)))
                  (if (fixnum? tmp.71)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.71)
                    (error 8)))))
             (L.cons.95.16
              (lambda (c.106 tmp.90 tmp.91) (let () (cons tmp.90 tmp.91))))
             (L.fun/empty8882.14.17
              (lambda (c.107)
                (let ((fun/empty8883.16 (closure-ref c.107 0)))
                  (closure-call fun/empty8883.16 fun/empty8883.16 (void)))))
             (L.fun/empty8885.15.18
              (lambda (c.108 oprand0.19 oprand1.18) (let () empty)))
             (L.fun/empty8883.16.19 (lambda (c.109 oprand0.20) (let () empty)))
             (L.fun/empty8884.17.20 (lambda (c.110) (let () empty))))
      (cletrec
       ((error?.98 (make-closure L.error?.98.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.97
         (make-closure L.vector-set!.97.12 3 unsafe-vector-set!.5))
        (vector-init-loop.45
         (make-closure L.vector-init-loop.45.13 3 vector-init-loop.45))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.45))
        (make-vector.96
         (make-closure L.make-vector.96.15 1 make-init-vector.4))
        (cons.95 (make-closure L.cons.95.16 2))
        (fun/empty8882.14
         (make-closure L.fun/empty8882.14.17 0 fun/empty8883.16))
        (fun/empty8885.15 (make-closure L.fun/empty8885.15.18 2))
        (fun/empty8883.16 (make-closure L.fun/empty8883.16.19 1))
        (fun/empty8884.17 (make-closure L.fun/empty8884.17.20 0)))
       (if (if #t #t #t)
         (closure-call fun/empty8882.14 fun/empty8882.14)
         (if (closure-call fun/empty8884.17 fun/empty8884.17)
           (if empty
             (if (closure-call
                  fun/empty8885.15
                  fun/empty8885.15
                  (error 63)
                  (closure-call
                   cons.95
                   cons.95
                   99
                   (closure-call cons.95 cons.95 348 empty)))
               (if (let ((pair0.22
                          (closure-call
                           cons.95
                           cons.95
                           87
                           (closure-call cons.95 cons.95 285 empty)))
                         (procedure1.21
                          (letrec ((L.lam.99.21
                                    (lambda (c.111)
                                      (let ((vector-set!.97
                                             (closure-ref c.111 0))
                                            (error?.98 (closure-ref c.111 1))
                                            (make-vector.96
                                             (closure-ref c.111 2)))
                                        (let ((tmp.7.23
                                               (closure-call
                                                make-vector.96
                                                make-vector.96
                                                8)))
                                          (let ((g43108180.24
                                                 (closure-call
                                                  vector-set!.97
                                                  vector-set!.97
                                                  tmp.7.23
                                                  0
                                                  0)))
                                            (if (closure-call
                                                 error?.98
                                                 error?.98
                                                 g43108180.24)
                                              g43108180.24
                                              (let ((g43108181.25
                                                     (closure-call
                                                      vector-set!.97
                                                      vector-set!.97
                                                      tmp.7.23
                                                      1
                                                      1)))
                                                (if (closure-call
                                                     error?.98
                                                     error?.98
                                                     g43108181.25)
                                                  g43108181.25
                                                  (let ((g43108182.26
                                                         (closure-call
                                                          vector-set!.97
                                                          vector-set!.97
                                                          tmp.7.23
                                                          2
                                                          2)))
                                                    (if (closure-call
                                                         error?.98
                                                         error?.98
                                                         g43108182.26)
                                                      g43108182.26
                                                      (let ((g43108183.27
                                                             (closure-call
                                                              vector-set!.97
                                                              vector-set!.97
                                                              tmp.7.23
                                                              3
                                                              3)))
                                                        (if (closure-call
                                                             error?.98
                                                             error?.98
                                                             g43108183.27)
                                                          g43108183.27
                                                          (let ((g43108184.28
                                                                 (closure-call
                                                                  vector-set!.97
                                                                  vector-set!.97
                                                                  tmp.7.23
                                                                  4
                                                                  4)))
                                                            (if (closure-call
                                                                 error?.98
                                                                 error?.98
                                                                 g43108184.28)
                                                              g43108184.28
                                                              (let ((g43108185.29
                                                                     (closure-call
                                                                      vector-set!.97
                                                                      vector-set!.97
                                                                      tmp.7.23
                                                                      5
                                                                      5)))
                                                                (if (closure-call
                                                                     error?.98
                                                                     error?.98
                                                                     g43108185.29)
                                                                  g43108185.29
                                                                  (let ((g43108186.30
                                                                         (closure-call
                                                                          vector-set!.97
                                                                          vector-set!.97
                                                                          tmp.7.23
                                                                          6
                                                                          6)))
                                                                    (if (closure-call
                                                                         error?.98
                                                                         error?.98
                                                                         g43108186.30)
                                                                      g43108186.30
                                                                      (let ((g43108187.31
                                                                             (closure-call
                                                                              vector-set!.97
                                                                              vector-set!.97
                                                                              tmp.7.23
                                                                              7
                                                                              7)))
                                                                        (if (closure-call
                                                                             error?.98
                                                                             error?.98
                                                                             g43108187.31)
                                                                          g43108187.31
                                                                          tmp.7.23)))))))))))))))))))))
                            (cletrec
                             ((lam.99
                               (make-closure
                                L.lam.99.21
                                0
                                vector-set!.97
                                error?.98
                                make-vector.96)))
                             lam.99))))
                     empty)
                 (if (let ((tmp.8.32 empty))
                       (if tmp.8.32
                         tmp.8.32
                         (let ((tmp.9.33 empty))
                           (if tmp.9.33
                             tmp.9.33
                             (let ((tmp.10.34 empty))
                               (if tmp.10.34
                                 tmp.10.34
                                 (let ((tmp.11.35 empty))
                                   (if tmp.11.35
                                     tmp.11.35
                                     (let ((tmp.12.36 empty))
                                       (if tmp.12.36
                                         tmp.12.36
                                         (let ((tmp.13.37 empty))
                                           (if tmp.13.37
                                             tmp.13.37
                                             empty))))))))))))
                   (if (let ((error0.38 (error 188))) empty)
                     (let ((g43108188.39 empty))
                       (if (closure-call error?.98 error?.98 g43108188.39)
                         g43108188.39
                         (let ((g43108189.40 empty))
                           (if (closure-call error?.98 error?.98 g43108189.40)
                             g43108189.40
                             (let ((g43108190.41 empty))
                               (if (closure-call
                                    error?.98
                                    error?.98
                                    g43108190.41)
                                 g43108190.41
                                 (let ((g43108191.42 empty))
                                   (if (closure-call
                                        error?.98
                                        error?.98
                                        g43108191.42)
                                     g43108191.42
                                     empty))))))))
                     #f)
                   #f)
                 #f)
               #f)
             #f)
           #f))))))
(check-by-interp
 '(module
    (letrec ((L.cons.61.10
              (lambda (c.62 tmp.56 tmp.57) (let () (cons tmp.56 tmp.57)))))
      (cletrec
       ((cons.61 (make-closure L.cons.61.10 2)))
       (let ((pair0.7
              (closure-call
               cons.61
               cons.61
               #\j
               (closure-call
                cons.61
                cons.61
                #t
                (closure-call
                 cons.61
                 cons.61
                 #\z
                 (closure-call
                  cons.61
                  cons.61
                  (closure-call
                   cons.61
                   cons.61
                   42
                   (closure-call cons.61 cons.61 508 empty))
                  (closure-call
                   cons.61
                   cons.61
                   140
                   (closure-call
                    cons.61
                    cons.61
                    (closure-call
                     cons.61
                     cons.61
                     214
                     (closure-call cons.61 cons.61 430 empty))
                    (closure-call
                     cons.61
                     cons.61
                     #\L
                     (closure-call
                      cons.61
                      cons.61
                      (closure-call
                       cons.61
                       cons.61
                       23
                       (closure-call cons.61 cons.61 329 empty))
                      empty))))))))))
         (let ((error0.8 (error 125))) (error 135)))))))
(check-by-interp
 '(module
    (letrec ((L.fun/ascii-char8895.7.10 (lambda (c.65) (let () #\I)))
             (L.fun/boolean8892.8.11
              (lambda (c.66 oprand0.12 oprand1.11)
                (let ((fun/boolean8893.9 (closure-ref c.66 0)))
                  (closure-call fun/boolean8893.9 fun/boolean8893.9))))
             (L.fun/boolean8893.9.12 (lambda (c.67) (let () #f)))
             (L.fun/ascii-char8894.10.13
              (lambda (c.68)
                (let ((fun/ascii-char8895.7 (closure-ref c.68 0)))
                  (closure-call fun/ascii-char8895.7 fun/ascii-char8895.7)))))
      (cletrec
       ((fun/ascii-char8895.7 (make-closure L.fun/ascii-char8895.7.10 0))
        (fun/boolean8892.8
         (make-closure L.fun/boolean8892.8.11 2 fun/boolean8893.9))
        (fun/boolean8893.9 (make-closure L.fun/boolean8893.9.12 0))
        (fun/ascii-char8894.10
         (make-closure L.fun/ascii-char8894.10.13 0 fun/ascii-char8895.7)))
       (if (closure-call
            fun/boolean8892.8
            fun/boolean8892.8
            (if 186 (if 17 (if 70 (if 72 (if 191 38 #f) #f) #f) #f) #f)
            (if (void) (void) #f))
         (closure-call fun/ascii-char8894.10 fun/ascii-char8894.10)
         (if #t #\u #\M))))))
(check-by-interp
 '(module
    (letrec ((L.fun/empty8899.7.10
              (lambda (c.66 oprand0.12)
                (let ((fun/empty8900.9 (closure-ref c.66 0)))
                  (closure-call fun/empty8900.9 fun/empty8900.9))))
             (L.fun/error8902.8.11
              (lambda (c.67 oprand0.13) (let () (let () (error 138)))))
             (L.fun/empty8900.9.12
              (lambda (c.68)
                (let ((fun/empty8901.11 (closure-ref c.68 0)))
                  (closure-call fun/empty8901.11 fun/empty8901.11))))
             (L.fun/empty8898.10.13
              (lambda (c.69)
                (let ((fun/error8902.8 (closure-ref c.69 0))
                      (fun/empty8899.7 (closure-ref c.69 1)))
                  (closure-call
                   fun/empty8899.7
                   fun/empty8899.7
                   (closure-call
                    fun/error8902.8
                    fun/error8902.8
                    (if #t #\C #\I))))))
             (L.fun/empty8901.11.14 (lambda (c.70) (let () empty))))
      (cletrec
       ((fun/empty8899.7 (make-closure L.fun/empty8899.7.10 1 fun/empty8900.9))
        (fun/error8902.8 (make-closure L.fun/error8902.8.11 1))
        (fun/empty8900.9
         (make-closure L.fun/empty8900.9.12 0 fun/empty8901.11))
        (fun/empty8898.10
         (make-closure
          L.fun/empty8898.10.13
          0
          fun/error8902.8
          fun/empty8899.7))
        (fun/empty8901.11 (make-closure L.fun/empty8901.11.14 0)))
       (closure-call fun/empty8898.10 fun/empty8898.10)))))
(check-by-interp
 '(module
    (letrec ((L.cons.64.10
              (lambda (c.66 tmp.59 tmp.60) (let () (cons tmp.59 tmp.60))))
             (L.fun/empty8905.7.11
              (lambda (c.67 oprand0.8) (let () (let () empty)))))
      (cletrec
       ((cons.64 (make-closure L.cons.64.10 2))
        (fun/empty8905.7 (make-closure L.fun/empty8905.7.11 1)))
       (let ()
         (closure-call
          fun/empty8905.7
          fun/empty8905.7
          (let ((void0.11 (void))
                (procedure1.10
                 (letrec ((L.lam.65.12 (lambda (c.68) (let () #\W))))
                   (cletrec ((lam.65 (make-closure L.lam.65.12 0))) lam.65)))
                (fixnum2.9 220))
            (closure-call
             cons.64
             cons.64
             141
             (closure-call cons.64 cons.64 422 empty)))))))))
(check-by-interp
 '(module
    (letrec ((L.error?.71.10 (lambda (c.72 tmp.61) (let () (error? tmp.61))))
             (L.fun/fixnum8912.7.11
              (lambda (c.73 oprand0.13 oprand1.12) (let () oprand0.13)))
             (L.fun/error8911.8.12
              (lambda (c.74 oprand0.15 oprand1.14)
                (let () (if #f (error 227) (error 92)))))
             (L.fun/empty8908.9.13
              (lambda (c.75 oprand0.16)
                (let ((fun/empty8910.11 (closure-ref c.75 0))
                      (fun/boolean8909.10 (closure-ref c.75 1)))
                  (if (closure-call fun/boolean8909.10 fun/boolean8909.10)
                    (let () empty)
                    (closure-call fun/empty8910.11 fun/empty8910.11)))))
             (L.fun/boolean8909.10.14 (lambda (c.76) (let () #f)))
             (L.fun/empty8910.11.15 (lambda (c.77) (let () empty))))
      (cletrec
       ((error?.71 (make-closure L.error?.71.10 1))
        (fun/fixnum8912.7 (make-closure L.fun/fixnum8912.7.11 2))
        (fun/error8911.8 (make-closure L.fun/error8911.8.12 2))
        (fun/empty8908.9
         (make-closure
          L.fun/empty8908.9.13
          1
          fun/empty8910.11
          fun/boolean8909.10))
        (fun/boolean8909.10 (make-closure L.fun/boolean8909.10.14 0))
        (fun/empty8910.11 (make-closure L.fun/empty8910.11.15 0)))
       (closure-call
        fun/empty8908.9
        fun/empty8908.9
        (closure-call
         fun/error8911.8
         fun/error8911.8
         (closure-call
          fun/fixnum8912.7
          fun/fixnum8912.7
          (let ((g43127270.17 193))
            (if (closure-call error?.71 error?.71 g43127270.17)
              g43127270.17
              (let ((g43127271.18 248))
                (if (closure-call error?.71 error?.71 g43127271.18)
                  g43127271.18
                  139))))
          (if #f #f #t))
         (if #f 172 187)))))))
(check-by-interp
 '(module
    (letrec ((L.fun/empty8915.7.10
              (lambda (c.64)
                (let ((fun/ascii-char8917.9 (closure-ref c.64 0))
                      (fun/empty8916.8 (closure-ref c.64 1)))
                  (closure-call
                   fun/empty8916.8
                   fun/empty8916.8
                   (closure-call
                    fun/ascii-char8917.9
                    fun/ascii-char8917.9
                    (if #t #t #f))))))
             (L.fun/empty8916.8.11
              (lambda (c.65 oprand0.10) (let () (if #t empty empty))))
             (L.fun/ascii-char8917.9.12
              (lambda (c.66 oprand0.11) (let () #\t))))
      (cletrec
       ((fun/empty8915.7
         (make-closure
          L.fun/empty8915.7.10
          0
          fun/ascii-char8917.9
          fun/empty8916.8))
        (fun/empty8916.8 (make-closure L.fun/empty8916.8.11 1))
        (fun/ascii-char8917.9 (make-closure L.fun/ascii-char8917.9.12 1)))
       (closure-call fun/empty8915.7 fun/empty8915.7)))))
(check-by-interp
 '(module
    (letrec ((L.error?.138.10
              (lambda (c.141 tmp.125) (let () (error? tmp.125))))
             (L.vector-init-loop.85.11
              (lambda (c.142 len.86 i.88 vec.87)
                (let ((vector-init-loop.85 (closure-ref c.142 0)))
                  (if (eq? len.86 i.88)
                    vec.87
                    (begin
                      (unsafe-vector-set! vec.87 i.88 0)
                      (closure-call
                       vector-init-loop.85
                       vector-init-loop.85
                       len.86
                       (unsafe-fx+ i.88 1)
                       vec.87))))))
             (L.make-init-vector.4.12
              (lambda (c.143 tmp.83)
                (let ((vector-init-loop.85 (closure-ref c.143 0)))
                  (let ((tmp.84 (unsafe-make-vector tmp.83)))
                    (closure-call
                     vector-init-loop.85
                     vector-init-loop.85
                     tmp.83
                     0
                     tmp.84)))))
             (L.make-vector.137.13
              (lambda (c.144 tmp.111)
                (let ((make-init-vector.4 (closure-ref c.144 0)))
                  (if (fixnum? tmp.111)
                    (closure-call
                     make-init-vector.4
                     make-init-vector.4
                     tmp.111)
                    (error 8)))))
             (L.unsafe-vector-set!.5.14
              (lambda (c.145 tmp.89 tmp.90 tmp.91)
                (let ()
                  (if (unsafe-fx< tmp.90 (unsafe-vector-length tmp.89))
                    (if (unsafe-fx>= tmp.90 0)
                      (begin (unsafe-vector-set! tmp.89 tmp.90 tmp.91) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.136.15
              (lambda (c.146 tmp.113 tmp.114 tmp.115)
                (let ((unsafe-vector-set!.5 (closure-ref c.146 0)))
                  (if (fixnum? tmp.114)
                    (if (vector? tmp.113)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.113
                       tmp.114
                       tmp.115)
                      (error 10))
                    (error 10)))))
             (L.cons.135.16
              (lambda (c.147 tmp.130 tmp.131) (let () (cons tmp.130 tmp.131))))
             (L.fun/void8925.14.17
              (lambda (c.148 oprand0.24 oprand1.23) (let () oprand0.24)))
             (L.fun/fixnum8922.15.18 (lambda (c.149) (let () 32)))
             (L.fun/void8928.16.19
              (lambda (c.150 oprand0.26 oprand1.25) (let () (let () (void)))))
             (L.fun/fixnum8921.17.20
              (lambda (c.151)
                (let ((fun/fixnum8922.15 (closure-ref c.151 0)))
                  (closure-call fun/fixnum8922.15 fun/fixnum8922.15))))
             (L.fun/fixnum8920.18.21
              (lambda (c.152 oprand0.28 oprand1.27)
                (let ((fun/fixnum8921.17 (closure-ref c.152 0)))
                  (closure-call fun/fixnum8921.17 fun/fixnum8921.17))))
             (L.fun/void8924.19.22 (lambda (c.153) (let () (void))))
             (L.fun/void8923.20.23
              (lambda (c.154 oprand0.29)
                (let ((vector-set!.136 (closure-ref c.154 0))
                      (cons.135 (closure-ref c.154 1)))
                  (let ()
                    (closure-call
                     vector-set!.136
                     vector-set!.136
                     oprand0.29
                     3
                     (closure-call
                      vector-set!.136
                      vector-set!.136
                      oprand0.29
                      4
                      (closure-call
                       cons.135
                       cons.135
                       148
                       (closure-call cons.135 cons.135 417 empty))))))))
             (L.fun/void8926.21.24 (lambda (c.155) (let () (void))))
             (L.fun/void8927.22.25
              (lambda (c.156)
                (let ((make-vector.137 (closure-ref c.156 0))
                      (error?.138 (closure-ref c.156 1))
                      (vector-set!.136 (closure-ref c.156 2)))
                  (let ((vector0.30
                         (let ((tmp.7.31
                                (closure-call
                                 make-vector.137
                                 make-vector.137
                                 8)))
                           (let ((g43134900.32
                                  (closure-call
                                   vector-set!.136
                                   vector-set!.136
                                   tmp.7.31
                                   0
                                   1)))
                             (if (closure-call
                                  error?.138
                                  error?.138
                                  g43134900.32)
                               g43134900.32
                               (let ((g43134901.33
                                      (closure-call
                                       vector-set!.136
                                       vector-set!.136
                                       tmp.7.31
                                       1
                                       2)))
                                 (if (closure-call
                                      error?.138
                                      error?.138
                                      g43134901.33)
                                   g43134901.33
                                   (let ((g43134902.34
                                          (closure-call
                                           vector-set!.136
                                           vector-set!.136
                                           tmp.7.31
                                           2
                                           3)))
                                     (if (closure-call
                                          error?.138
                                          error?.138
                                          g43134902.34)
                                       g43134902.34
                                       (let ((g43134903.35
                                              (closure-call
                                               vector-set!.136
                                               vector-set!.136
                                               tmp.7.31
                                               3
                                               4)))
                                         (if (closure-call
                                              error?.138
                                              error?.138
                                              g43134903.35)
                                           g43134903.35
                                           (let ((g43134904.36
                                                  (closure-call
                                                   vector-set!.136
                                                   vector-set!.136
                                                   tmp.7.31
                                                   4
                                                   5)))
                                             (if (closure-call
                                                  error?.138
                                                  error?.138
                                                  g43134904.36)
                                               g43134904.36
                                               (let ((g43134905.37
                                                      (closure-call
                                                       vector-set!.136
                                                       vector-set!.136
                                                       tmp.7.31
                                                       5
                                                       6)))
                                                 (if (closure-call
                                                      error?.138
                                                      error?.138
                                                      g43134905.37)
                                                   g43134905.37
                                                   (let ((g43134906.38
                                                          (closure-call
                                                           vector-set!.136
                                                           vector-set!.136
                                                           tmp.7.31
                                                           6
                                                           7)))
                                                     (if (closure-call
                                                          error?.138
                                                          error?.138
                                                          g43134906.38)
                                                       g43134906.38
                                                       (let ((g43134907.39
                                                              (closure-call
                                                               vector-set!.136
                                                               vector-set!.136
                                                               tmp.7.31
                                                               7
                                                               8)))
                                                         (if (closure-call
                                                              error?.138
                                                              error?.138
                                                              g43134907.39)
                                                           g43134907.39
                                                           tmp.7.31)))))))))))))))))))
                    (void))))))
      (cletrec
       ((error?.138 (make-closure L.error?.138.10 1))
        (vector-init-loop.85
         (make-closure L.vector-init-loop.85.11 3 vector-init-loop.85))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.12 1 vector-init-loop.85))
        (make-vector.137
         (make-closure L.make-vector.137.13 1 make-init-vector.4))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.14 3))
        (vector-set!.136
         (make-closure L.vector-set!.136.15 3 unsafe-vector-set!.5))
        (cons.135 (make-closure L.cons.135.16 2))
        (fun/void8925.14 (make-closure L.fun/void8925.14.17 2))
        (fun/fixnum8922.15 (make-closure L.fun/fixnum8922.15.18 0))
        (fun/void8928.16 (make-closure L.fun/void8928.16.19 2))
        (fun/fixnum8921.17
         (make-closure L.fun/fixnum8921.17.20 0 fun/fixnum8922.15))
        (fun/fixnum8920.18
         (make-closure L.fun/fixnum8920.18.21 2 fun/fixnum8921.17))
        (fun/void8924.19 (make-closure L.fun/void8924.19.22 0))
        (fun/void8923.20
         (make-closure L.fun/void8923.20.23 1 vector-set!.136 cons.135))
        (fun/void8926.21 (make-closure L.fun/void8926.21.24 0))
        (fun/void8927.22
         (make-closure
          L.fun/void8927.22.25
          0
          make-vector.137
          error?.138
          vector-set!.136)))
       (closure-call
        fun/fixnum8920.18
        fun/fixnum8920.18
        (closure-call
         fun/void8923.20
         fun/void8923.20
         (if #t
           (let ((tmp.8.40 (closure-call make-vector.137 make-vector.137 8)))
             (let ((g43134908.41
                    (closure-call
                     vector-set!.136
                     vector-set!.136
                     tmp.8.40
                     0
                     1)))
               (if (closure-call error?.138 error?.138 g43134908.41)
                 g43134908.41
                 (let ((g43134909.42
                        (closure-call
                         vector-set!.136
                         vector-set!.136
                         tmp.8.40
                         1
                         2)))
                   (if (closure-call error?.138 error?.138 g43134909.42)
                     g43134909.42
                     (let ((g43134910.43
                            (closure-call
                             vector-set!.136
                             vector-set!.136
                             tmp.8.40
                             2
                             3)))
                       (if (closure-call error?.138 error?.138 g43134910.43)
                         g43134910.43
                         (let ((g43134911.44
                                (closure-call
                                 vector-set!.136
                                 vector-set!.136
                                 tmp.8.40
                                 3
                                 4)))
                           (if (closure-call
                                error?.138
                                error?.138
                                g43134911.44)
                             g43134911.44
                             (let ((g43134912.45
                                    (closure-call
                                     vector-set!.136
                                     vector-set!.136
                                     tmp.8.40
                                     4
                                     5)))
                               (if (closure-call
                                    error?.138
                                    error?.138
                                    g43134912.45)
                                 g43134912.45
                                 (let ((g43134913.46
                                        (closure-call
                                         vector-set!.136
                                         vector-set!.136
                                         tmp.8.40
                                         5
                                         6)))
                                   (if (closure-call
                                        error?.138
                                        error?.138
                                        g43134913.46)
                                     g43134913.46
                                     (let ((g43134914.47
                                            (closure-call
                                             vector-set!.136
                                             vector-set!.136
                                             tmp.8.40
                                             6
                                             7)))
                                       (if (closure-call
                                            error?.138
                                            error?.138
                                            g43134914.47)
                                         g43134914.47
                                         (let ((g43134915.48
                                                (closure-call
                                                 vector-set!.136
                                                 vector-set!.136
                                                 tmp.8.40
                                                 7
                                                 8)))
                                           (if (closure-call
                                                error?.138
                                                error?.138
                                                g43134915.48)
                                             g43134915.48
                                             tmp.8.40)))))))))))))))))
           (let ((tmp.9.49 (closure-call make-vector.137 make-vector.137 8)))
             (let ((g43134916.50
                    (closure-call
                     vector-set!.136
                     vector-set!.136
                     tmp.9.49
                     0
                     0)))
               (if (closure-call error?.138 error?.138 g43134916.50)
                 g43134916.50
                 (let ((g43134917.51
                        (closure-call
                         vector-set!.136
                         vector-set!.136
                         tmp.9.49
                         1
                         1)))
                   (if (closure-call error?.138 error?.138 g43134917.51)
                     g43134917.51
                     (let ((g43134918.52
                            (closure-call
                             vector-set!.136
                             vector-set!.136
                             tmp.9.49
                             2
                             2)))
                       (if (closure-call error?.138 error?.138 g43134918.52)
                         g43134918.52
                         (let ((g43134919.53
                                (closure-call
                                 vector-set!.136
                                 vector-set!.136
                                 tmp.9.49
                                 3
                                 3)))
                           (if (closure-call
                                error?.138
                                error?.138
                                g43134919.53)
                             g43134919.53
                             (let ((g43134920.54
                                    (closure-call
                                     vector-set!.136
                                     vector-set!.136
                                     tmp.9.49
                                     4
                                     4)))
                               (if (closure-call
                                    error?.138
                                    error?.138
                                    g43134920.54)
                                 g43134920.54
                                 (let ((g43134921.55
                                        (closure-call
                                         vector-set!.136
                                         vector-set!.136
                                         tmp.9.49
                                         5
                                         5)))
                                   (if (closure-call
                                        error?.138
                                        error?.138
                                        g43134921.55)
                                     g43134921.55
                                     (let ((g43134922.56
                                            (closure-call
                                             vector-set!.136
                                             vector-set!.136
                                             tmp.9.49
                                             6
                                             6)))
                                       (if (closure-call
                                            error?.138
                                            error?.138
                                            g43134922.56)
                                         g43134922.56
                                         (let ((g43134923.57
                                                (closure-call
                                                 vector-set!.136
                                                 vector-set!.136
                                                 tmp.9.49
                                                 7
                                                 7)))
                                           (if (closure-call
                                                error?.138
                                                error?.138
                                                g43134923.57)
                                             g43134923.57
                                             tmp.9.49)))))))))))))))))))
        (let ((tmp.10.58
               (let ((g43134924.59
                      (closure-call fun/void8924.19 fun/void8924.19)))
                 (if (closure-call error?.138 error?.138 g43134924.59)
                   g43134924.59
                   (let ((g43134925.60
                          (if (void)
                            (if (void)
                              (if (void)
                                (if (void) (if (void) (void) #f) #f)
                                #f)
                              #f)
                            #f)))
                     (if (closure-call error?.138 error?.138 g43134925.60)
                       g43134925.60
                       (let ((g43134926.61
                              (let ((pair0.64
                                     (closure-call
                                      cons.135
                                      cons.135
                                      23
                                      (closure-call
                                       cons.135
                                       cons.135
                                       408
                                       empty)))
                                    (vector1.63
                                     (let ((tmp.11.65
                                            (closure-call
                                             make-vector.137
                                             make-vector.137
                                             8)))
                                       (let ((g43134927.66
                                              (closure-call
                                               vector-set!.136
                                               vector-set!.136
                                               tmp.11.65
                                               0
                                               1)))
                                         (if (closure-call
                                              error?.138
                                              error?.138
                                              g43134927.66)
                                           g43134927.66
                                           (let ((g43134928.67
                                                  (closure-call
                                                   vector-set!.136
                                                   vector-set!.136
                                                   tmp.11.65
                                                   1
                                                   2)))
                                             (if (closure-call
                                                  error?.138
                                                  error?.138
                                                  g43134928.67)
                                               g43134928.67
                                               (let ((g43134929.68
                                                      (closure-call
                                                       vector-set!.136
                                                       vector-set!.136
                                                       tmp.11.65
                                                       2
                                                       3)))
                                                 (if (closure-call
                                                      error?.138
                                                      error?.138
                                                      g43134929.68)
                                                   g43134929.68
                                                   (let ((g43134930.69
                                                          (closure-call
                                                           vector-set!.136
                                                           vector-set!.136
                                                           tmp.11.65
                                                           3
                                                           4)))
                                                     (if (closure-call
                                                          error?.138
                                                          error?.138
                                                          g43134930.69)
                                                       g43134930.69
                                                       (let ((g43134931.70
                                                              (closure-call
                                                               vector-set!.136
                                                               vector-set!.136
                                                               tmp.11.65
                                                               4
                                                               5)))
                                                         (if (closure-call
                                                              error?.138
                                                              error?.138
                                                              g43134931.70)
                                                           g43134931.70
                                                           (let ((g43134932.71
                                                                  (closure-call
                                                                   vector-set!.136
                                                                   vector-set!.136
                                                                   tmp.11.65
                                                                   5
                                                                   6)))
                                                             (if (closure-call
                                                                  error?.138
                                                                  error?.138
                                                                  g43134932.71)
                                                               g43134932.71
                                                               (let ((g43134933.72
                                                                      (closure-call
                                                                       vector-set!.136
                                                                       vector-set!.136
                                                                       tmp.11.65
                                                                       6
                                                                       7)))
                                                                 (if (closure-call
                                                                      error?.138
                                                                      error?.138
                                                                      g43134933.72)
                                                                   g43134933.72
                                                                   (let ((g43134934.73
                                                                          (closure-call
                                                                           vector-set!.136
                                                                           vector-set!.136
                                                                           tmp.11.65
                                                                           7
                                                                           8)))
                                                                     (if (closure-call
                                                                          error?.138
                                                                          error?.138
                                                                          g43134934.73)
                                                                       g43134934.73
                                                                       tmp.11.65))))))))))))))))))
                                    (procedure2.62
                                     (letrec ((L.lam.139.26
                                               (lambda (c.157)
                                                 (let ()
                                                   (letrec ((L.lam.140.27
                                                             (lambda (c.158)
                                                               (let () 738))))
                                                     (cletrec
                                                      ((lam.140
                                                        (make-closure
                                                         L.lam.140.27
                                                         0)))
                                                      lam.140))))))
                                       (cletrec
                                        ((lam.139
                                          (make-closure L.lam.139.26 0)))
                                        lam.139))))
                                (void))))
                         (if (closure-call error?.138 error?.138 g43134926.61)
                           g43134926.61
                           (let ((g43134935.74
                                  (closure-call
                                   fun/void8925.14
                                   fun/void8925.14
                                   (void)
                                   empty)))
                             (if (closure-call
                                  error?.138
                                  error?.138
                                  g43134935.74)
                               g43134935.74
                               (let ((g43134936.75
                                      (let ((ascii-char0.77 #\p)
                                            (error1.76 (error 127)))
                                        (void))))
                                 (if (closure-call
                                      error?.138
                                      error?.138
                                      g43134936.75)
                                   g43134936.75
                                   (closure-call
                                    fun/void8926.21
                                    fun/void8926.21)))))))))))))
          (if tmp.10.58
            tmp.10.58
            (let ((tmp.12.78 (closure-call fun/void8927.22 fun/void8927.22)))
              (if tmp.12.78
                tmp.12.78
                (let ((tmp.13.79
                       (closure-call
                        fun/void8928.16
                        fun/void8928.16
                        (let ((error0.82 (error 214))
                              (fixnum1.81 220)
                              (fixnum2.80 214))
                          (closure-call
                           cons.135
                           cons.135
                           245
                           (closure-call cons.135 cons.135 379 empty)))
                        (if #t
                          (closure-call
                           cons.135
                           cons.135
                           229
                           (closure-call cons.135 cons.135 508 empty))
                          (closure-call
                           cons.135
                           cons.135
                           135
                           (closure-call cons.135 cons.135 424 empty))))))
                  (if tmp.13.79 tmp.13.79 (if #t (void) (void)))))))))))))
(check-by-interp
 '(module
    (letrec ((L.error?.63.10 (lambda (c.64 tmp.53) (let () (error? tmp.53)))))
      (cletrec
       ((error?.63 (make-closure L.error?.63.10 1)))
       (if (let ((g43138756.7 #f))
             (if (closure-call error?.63 error?.63 g43138756.7)
               g43138756.7
               (let ((g43138757.8 #f))
                 (if (closure-call error?.63 error?.63 g43138757.8)
                   g43138757.8
                   (let ((g43138758.9 #f))
                     (if (closure-call error?.63 error?.63 g43138758.9)
                       g43138758.9
                       (let ((g43138759.10 #f))
                         (if (closure-call error?.63 error?.63 g43138759.10)
                           g43138759.10
                           #t))))))))
         (void)
         (if #t (void) (void)))))))
(check-by-interp
 '(module
    (letrec ((L.fun/boolean8934.7.10 (lambda (c.61) (let () #t)))
             (L.fun/fixnum8933.8.11
              (lambda (c.62)
                (let ((fun/boolean8934.7 (closure-ref c.62 0)))
                  (if (closure-call fun/boolean8934.7 fun/boolean8934.7)
                    (if #t 180 142)
                    (let () 34))))))
      (cletrec
       ((fun/boolean8934.7 (make-closure L.fun/boolean8934.7.10 0))
        (fun/fixnum8933.8
         (make-closure L.fun/fixnum8933.8.11 0 fun/boolean8934.7)))
       (closure-call fun/fixnum8933.8 fun/fixnum8933.8)))))
(check-by-interp '(module (let () (let () (error 250)))))
(check-by-interp
 '(module
    (letrec ((L.error?.87.10 (lambda (c.90 tmp.75) (let () (error? tmp.75))))
             (L.ascii-char?.86.11
              (lambda (c.91 tmp.74) (let () (ascii-char? tmp.74))))
             (L.cons.85.12
              (lambda (c.92 tmp.80 tmp.81) (let () (cons tmp.80 tmp.81))))
             (L.fun/void8949.12.13
              (lambda (c.93 oprand0.16 oprand1.15) (let () (let () (void)))))
             (L.fun/void8950.13.14 (lambda (c.94) (let () (void))))
             (L.fun/void8951.14.15 (lambda (c.95) (let () (void)))))
      (cletrec
       ((error?.87 (make-closure L.error?.87.10 1))
        (ascii-char?.86 (make-closure L.ascii-char?.86.11 1))
        (cons.85 (make-closure L.cons.85.12 2))
        (fun/void8949.12 (make-closure L.fun/void8949.12.13 2))
        (fun/void8950.13 (make-closure L.fun/void8950.13.14 0))
        (fun/void8951.14 (make-closure L.fun/void8951.14.15 0)))
       (if (closure-call
            ascii-char?.86
            ascii-char?.86
            (let ((procedure0.18
                   (letrec ((L.lam.88.16
                             (lambda (c.96 oprand0.19)
                               (let ()
                                 (letrec ((L.lam.89.17
                                           (lambda (c.97) (let () 1019))))
                                   (cletrec
                                    ((lam.89 (make-closure L.lam.89.17 0)))
                                    lam.89))))))
                     (cletrec ((lam.88 (make-closure L.lam.88.16 1))) lam.88)))
                  (pair1.17
                   (closure-call
                    cons.85
                    cons.85
                    69
                    (closure-call cons.85 cons.85 333 empty))))
              (error 189)))
         (closure-call
          fun/void8949.12
          fun/void8949.12
          (if #t 226 18)
          (let ((g43150205.20 #\Y))
            (if (closure-call error?.87 error?.87 g43150205.20)
              g43150205.20
              (let ((g43150206.21 #\t))
                (if (closure-call error?.87 error?.87 g43150206.21)
                  g43150206.21
                  (let ((g43150207.22 #\l))
                    (if (closure-call error?.87 error?.87 g43150207.22)
                      g43150207.22
                      (let ((g43150208.23 #\s))
                        (if (closure-call error?.87 error?.87 g43150208.23)
                          g43150208.23
                          (let ((g43150209.24 #\g))
                            (if (closure-call error?.87 error?.87 g43150209.24)
                              g43150209.24
                              (let ((g43150210.25 #\V))
                                (if (closure-call
                                     error?.87
                                     error?.87
                                     g43150210.25)
                                  g43150210.25
                                  #\A)))))))))))))
         (let ((tmp.7.26
                (let ((pair0.28
                       (closure-call
                        cons.85
                        cons.85
                        202
                        (closure-call cons.85 cons.85 321 empty)))
                      (pair1.27
                       (closure-call
                        cons.85
                        cons.85
                        143
                        (closure-call cons.85 cons.85 414 empty))))
                  (void))))
           (if tmp.7.26
             tmp.7.26
             (let ((tmp.8.29 (if #t (void) (void))))
               (if tmp.8.29
                 tmp.8.29
                 (let ((tmp.9.30
                        (closure-call fun/void8950.13 fun/void8950.13)))
                   (if tmp.9.30
                     tmp.9.30
                     (let ((tmp.10.31 (if #t (void) (void))))
                       (if tmp.10.31
                         tmp.10.31
                         (let ((tmp.11.32 (void)))
                           (if tmp.11.32
                             tmp.11.32
                             (closure-call
                              fun/void8951.14
                              fun/void8951.14))))))))))))))))
(check-by-interp '(module (let ((boolean0.8 #f) (empty1.7 empty)) (void))))
(check-by-interp
 '(module
    (letrec ((L.fun/error8958.7.10
              (lambda (c.62) (let () (if #t (error 216) (error 110)))))
             (L.fun/error8956.8.11
              (lambda (c.63)
                (let ((fun/error8957.9 (closure-ref c.63 0)))
                  (closure-call fun/error8957.9 fun/error8957.9))))
             (L.fun/error8957.9.12
              (lambda (c.64)
                (let ((fun/error8958.7 (closure-ref c.64 0)))
                  (closure-call fun/error8958.7 fun/error8958.7)))))
      (cletrec
       ((fun/error8958.7 (make-closure L.fun/error8958.7.10 0))
        (fun/error8956.8 (make-closure L.fun/error8956.8.11 0 fun/error8957.9))
        (fun/error8957.9
         (make-closure L.fun/error8957.9.12 0 fun/error8958.7)))
       (closure-call fun/error8956.8 fun/error8956.8)))))
(check-by-interp
 '(module
    (letrec ((L.cons.63.10
              (lambda (c.64 tmp.58 tmp.59) (let () (cons tmp.58 tmp.59))))
             (L.fun/error8961.7.11
              (lambda (c.65)
                (let ((fun/error8962.8 (closure-ref c.65 0)))
                  (closure-call fun/error8962.8 fun/error8962.8))))
             (L.fun/error8962.8.12 (lambda (c.66) (let () (error 73)))))
      (cletrec
       ((cons.63 (make-closure L.cons.63.10 2))
        (fun/error8961.7 (make-closure L.fun/error8961.7.11 0 fun/error8962.8))
        (fun/error8962.8 (make-closure L.fun/error8962.8.12 0)))
       (let ((pair0.10
              (closure-call
               cons.63
               cons.63
               (closure-call
                cons.63
                cons.63
                104
                (closure-call cons.63 cons.63 475 empty))
               (closure-call
                cons.63
                cons.63
                0
                (closure-call
                 cons.63
                 cons.63
                 #f
                 (closure-call
                  cons.63
                  cons.63
                  empty
                  (closure-call
                   cons.63
                   cons.63
                   169
                   (closure-call
                    cons.63
                    cons.63
                    #t
                    (closure-call
                     cons.63
                     cons.63
                     empty
                     (closure-call cons.63 cons.63 empty empty)))))))))
             (boolean1.9 (let () #f)))
         (closure-call fun/error8961.7 fun/error8961.7))))))
(check-by-interp
 '(module
    (letrec ((L.error?.93.10 (lambda (c.94 tmp.81) (let () (error? tmp.81))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.95 tmp.45 tmp.46 tmp.47)
                (let ()
                  (if (unsafe-fx< tmp.46 (unsafe-vector-length tmp.45))
                    (if (unsafe-fx>= tmp.46 0)
                      (begin (unsafe-vector-set! tmp.45 tmp.46 tmp.47) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.92.12
              (lambda (c.96 tmp.69 tmp.70 tmp.71)
                (let ((unsafe-vector-set!.5 (closure-ref c.96 0)))
                  (if (fixnum? tmp.70)
                    (if (vector? tmp.69)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.69
                       tmp.70
                       tmp.71)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.41.13
              (lambda (c.97 len.42 i.44 vec.43)
                (let ((vector-init-loop.41 (closure-ref c.97 0)))
                  (if (eq? len.42 i.44)
                    vec.43
                    (begin
                      (unsafe-vector-set! vec.43 i.44 0)
                      (closure-call
                       vector-init-loop.41
                       vector-init-loop.41
                       len.42
                       (unsafe-fx+ i.44 1)
                       vec.43))))))
             (L.make-init-vector.4.14
              (lambda (c.98 tmp.39)
                (let ((vector-init-loop.41 (closure-ref c.98 0)))
                  (let ((tmp.40 (unsafe-make-vector tmp.39)))
                    (closure-call
                     vector-init-loop.41
                     vector-init-loop.41
                     tmp.39
                     0
                     tmp.40)))))
             (L.make-vector.91.15
              (lambda (c.99 tmp.67)
                (let ((make-init-vector.4 (closure-ref c.99 0)))
                  (if (fixnum? tmp.67)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.67)
                    (error 8)))))
             (L.fun/ascii-char8966.15.16
              (lambda (c.100 oprand0.18 oprand1.17) (let () #\j)))
             (L.fun/ascii-char8965.16.17
              (lambda (c.101 oprand0.20 oprand1.19) (let () #\g))))
      (cletrec
       ((error?.93 (make-closure L.error?.93.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.92
         (make-closure L.vector-set!.92.12 3 unsafe-vector-set!.5))
        (vector-init-loop.41
         (make-closure L.vector-init-loop.41.13 3 vector-init-loop.41))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.41))
        (make-vector.91
         (make-closure L.make-vector.91.15 1 make-init-vector.4))
        (fun/ascii-char8966.15 (make-closure L.fun/ascii-char8966.15.16 2))
        (fun/ascii-char8965.16 (make-closure L.fun/ascii-char8965.16.17 2)))
       (if (if #t #t #f)
         (let ((tmp.7.21 (if #t #\r #\`)))
           (if tmp.7.21
             tmp.7.21
             (let ((tmp.8.22
                    (let ((tmp.9.23 #\Q))
                      (if tmp.9.23
                        tmp.9.23
                        (let ((tmp.10.24 #\E))
                          (if tmp.10.24 tmp.10.24 #\E))))))
               (if tmp.8.22
                 tmp.8.22
                 (let ((tmp.11.25 (if #f #\k #\J)))
                   (if tmp.11.25
                     tmp.11.25
                     (let ((tmp.12.26 (if #f #\M #\v)))
                       (if tmp.12.26
                         tmp.12.26
                         (let ((tmp.13.27
                                (closure-call
                                 fun/ascii-char8965.16
                                 fun/ascii-char8965.16
                                 #f
                                 (closure-call
                                  make-vector.91
                                  make-vector.91
                                  8))))
                           (if tmp.13.27
                             tmp.13.27
                             (closure-call
                              fun/ascii-char8966.15
                              fun/ascii-char8966.15
                              (let ((tmp.14.28
                                     (closure-call
                                      make-vector.91
                                      make-vector.91
                                      8)))
                                (let ((g43165470.29
                                       (closure-call
                                        vector-set!.92
                                        vector-set!.92
                                        tmp.14.28
                                        0
                                        0)))
                                  (if (closure-call
                                       error?.93
                                       error?.93
                                       g43165470.29)
                                    g43165470.29
                                    (let ((g43165471.30
                                           (closure-call
                                            vector-set!.92
                                            vector-set!.92
                                            tmp.14.28
                                            1
                                            1)))
                                      (if (closure-call
                                           error?.93
                                           error?.93
                                           g43165471.30)
                                        g43165471.30
                                        (let ((g43165472.31
                                               (closure-call
                                                vector-set!.92
                                                vector-set!.92
                                                tmp.14.28
                                                2
                                                2)))
                                          (if (closure-call
                                               error?.93
                                               error?.93
                                               g43165472.31)
                                            g43165472.31
                                            (let ((g43165473.32
                                                   (closure-call
                                                    vector-set!.92
                                                    vector-set!.92
                                                    tmp.14.28
                                                    3
                                                    3)))
                                              (if (closure-call
                                                   error?.93
                                                   error?.93
                                                   g43165473.32)
                                                g43165473.32
                                                (let ((g43165474.33
                                                       (closure-call
                                                        vector-set!.92
                                                        vector-set!.92
                                                        tmp.14.28
                                                        4
                                                        4)))
                                                  (if (closure-call
                                                       error?.93
                                                       error?.93
                                                       g43165474.33)
                                                    g43165474.33
                                                    (let ((g43165475.34
                                                           (closure-call
                                                            vector-set!.92
                                                            vector-set!.92
                                                            tmp.14.28
                                                            5
                                                            5)))
                                                      (if (closure-call
                                                           error?.93
                                                           error?.93
                                                           g43165475.34)
                                                        g43165475.34
                                                        (let ((g43165476.35
                                                               (closure-call
                                                                vector-set!.92
                                                                vector-set!.92
                                                                tmp.14.28
                                                                6
                                                                6)))
                                                          (if (closure-call
                                                               error?.93
                                                               error?.93
                                                               g43165476.35)
                                                            g43165476.35
                                                            (let ((g43165477.36
                                                                   (closure-call
                                                                    vector-set!.92
                                                                    vector-set!.92
                                                                    tmp.14.28
                                                                    7
                                                                    7)))
                                                              (if (closure-call
                                                                   error?.93
                                                                   error?.93
                                                                   g43165477.36)
                                                                g43165477.36
                                                                tmp.14.28)))))))))))))))))
                              235)))))))))))
         (let ((ascii-char0.38 #\n) (ascii-char1.37 #\B)) #\O))))))
(check-by-interp
 '(module
    (letrec ((L.fun/void8969.13.10 (lambda (c.77) (let () (void)))))
      (cletrec
       ((fun/void8969.13 (make-closure L.fun/void8969.13.10 0)))
       (let ((ascii-char0.16 (if #f #\a #\S))
             (procedure1.15
              (letrec ((L.lam.75.11
                        (lambda (c.78)
                          (let ((fun/void8969.13 (closure-ref c.78 0)))
                            (let ((tmp.7.17 (void)))
                              (if tmp.7.17
                                tmp.7.17
                                (let ((tmp.8.18
                                       (closure-call
                                        fun/void8969.13
                                        fun/void8969.13)))
                                  (if tmp.8.18
                                    tmp.8.18
                                    (let ((tmp.9.19 (if #f (void) (void))))
                                      (if tmp.9.19
                                        tmp.9.19
                                        (let ((tmp.10.20 (let () (void))))
                                          (if tmp.10.20
                                            tmp.10.20
                                            (let ((tmp.11.21 (let () (void))))
                                              (if tmp.11.21
                                                tmp.11.21
                                                (let ((tmp.12.22
                                                       (if #f (void) (void))))
                                                  (if tmp.12.22
                                                    tmp.12.22
                                                    (let ()
                                                      (void))))))))))))))))))
                (cletrec
                 ((lam.75 (make-closure L.lam.75.11 0 fun/void8969.13)))
                 lam.75)))
             (procedure2.14
              (letrec ((L.lam.76.12 (lambda (c.79) (let () (let () #f)))))
                (cletrec ((lam.76 (make-closure L.lam.76.12 0))) lam.76))))
         (if #t (error 237) (error 2)))))))
(check-by-interp
 '(module
    (letrec ((L.fun/boolean8974.7.10 (lambda (c.65) (let () #t)))
             (L.fun/boolean8973.8.11
              (lambda (c.66 oprand0.10)
                (let ((fun/boolean8974.7 (closure-ref c.66 0)))
                  (closure-call fun/boolean8974.7 fun/boolean8974.7))))
             (L.fun/boolean8972.9.12
              (lambda (c.67)
                (let ((fun/boolean8973.8 (closure-ref c.67 0)))
                  (closure-call
                   fun/boolean8973.8
                   fun/boolean8973.8
                   (if #f
                     (letrec ((L.lam.63.13 (lambda (c.68) (let () 569))))
                       (cletrec
                        ((lam.63 (make-closure L.lam.63.13 0)))
                        lam.63))
                     (letrec ((L.lam.64.14 (lambda (c.69) (let () 967))))
                       (cletrec
                        ((lam.64 (make-closure L.lam.64.14 0)))
                        lam.64))))))))
      (cletrec
       ((fun/boolean8974.7 (make-closure L.fun/boolean8974.7.10 0))
        (fun/boolean8973.8
         (make-closure L.fun/boolean8973.8.11 1 fun/boolean8974.7))
        (fun/boolean8972.9
         (make-closure L.fun/boolean8972.9.12 0 fun/boolean8973.8)))
       (closure-call fun/boolean8972.9 fun/boolean8972.9)))))
(check-by-interp
 '(module
    (letrec ((L.error?.89.10 (lambda (c.91 tmp.75) (let () (error? tmp.75))))
             (L.unsafe-vector-set!.5.11
              (lambda (c.92 tmp.39 tmp.40 tmp.41)
                (let ()
                  (if (unsafe-fx< tmp.40 (unsafe-vector-length tmp.39))
                    (if (unsafe-fx>= tmp.40 0)
                      (begin (unsafe-vector-set! tmp.39 tmp.40 tmp.41) (void))
                      (error 10))
                    (error 10)))))
             (L.vector-set!.88.12
              (lambda (c.93 tmp.63 tmp.64 tmp.65)
                (let ((unsafe-vector-set!.5 (closure-ref c.93 0)))
                  (if (fixnum? tmp.64)
                    (if (vector? tmp.63)
                      (closure-call
                       unsafe-vector-set!.5
                       unsafe-vector-set!.5
                       tmp.63
                       tmp.64
                       tmp.65)
                      (error 10))
                    (error 10)))))
             (L.vector-init-loop.35.13
              (lambda (c.94 len.36 i.38 vec.37)
                (let ((vector-init-loop.35 (closure-ref c.94 0)))
                  (if (eq? len.36 i.38)
                    vec.37
                    (begin
                      (unsafe-vector-set! vec.37 i.38 0)
                      (closure-call
                       vector-init-loop.35
                       vector-init-loop.35
                       len.36
                       (unsafe-fx+ i.38 1)
                       vec.37))))))
             (L.make-init-vector.4.14
              (lambda (c.95 tmp.33)
                (let ((vector-init-loop.35 (closure-ref c.95 0)))
                  (let ((tmp.34 (unsafe-make-vector tmp.33)))
                    (closure-call
                     vector-init-loop.35
                     vector-init-loop.35
                     tmp.33
                     0
                     tmp.34)))))
             (L.make-vector.87.15
              (lambda (c.96 tmp.61)
                (let ((make-init-vector.4 (closure-ref c.96 0)))
                  (if (fixnum? tmp.61)
                    (closure-call make-init-vector.4 make-init-vector.4 tmp.61)
                    (error 8)))))
             (L.pair?.86.16 (lambda (c.97 tmp.76) (let () (pair? tmp.76))))
             (L.cons.85.17
              (lambda (c.98 tmp.80 tmp.81) (let () (cons tmp.80 tmp.81))))
             (L.fun/boolean8978.9.18 (lambda (c.99 oprand0.15) (let () #t)))
             (L.fun/procedure8982.10.19
              (lambda (c.100)
                (let ()
                  (let ()
                    (letrec ((L.lam.90.24 (lambda (c.101) (let () 845))))
                      (cletrec
                       ((lam.90 (make-closure L.lam.90.24 0)))
                       lam.90))))))
             (L.fun/void8979.11.20
              (lambda (c.102 oprand0.17 oprand1.16)
                (let ((fun/void8980.13 (closure-ref c.102 0)))
                  (closure-call fun/void8980.13 fun/void8980.13))))
             (L.fun/void8977.12.21 (lambda (c.103) (let () (void))))
             (L.fun/void8980.13.22
              (lambda (c.104)
                (let ((fun/void8981.14 (closure-ref c.104 0)))
                  (closure-call fun/void8981.14 fun/void8981.14))))
             (L.fun/void8981.14.23 (lambda (c.105) (let () (void)))))
      (cletrec
       ((error?.89 (make-closure L.error?.89.10 1))
        (unsafe-vector-set!.5 (make-closure L.unsafe-vector-set!.5.11 3))
        (vector-set!.88
         (make-closure L.vector-set!.88.12 3 unsafe-vector-set!.5))
        (vector-init-loop.35
         (make-closure L.vector-init-loop.35.13 3 vector-init-loop.35))
        (make-init-vector.4
         (make-closure L.make-init-vector.4.14 1 vector-init-loop.35))
        (make-vector.87
         (make-closure L.make-vector.87.15 1 make-init-vector.4))
        (pair?.86 (make-closure L.pair?.86.16 1))
        (cons.85 (make-closure L.cons.85.17 2))
        (fun/boolean8978.9 (make-closure L.fun/boolean8978.9.18 1))
        (fun/procedure8982.10 (make-closure L.fun/procedure8982.10.19 0))
        (fun/void8979.11 (make-closure L.fun/void8979.11.20 2 fun/void8980.13))
        (fun/void8977.12 (make-closure L.fun/void8977.12.21 0))
        (fun/void8980.13 (make-closure L.fun/void8980.13.22 0 fun/void8981.14))
        (fun/void8981.14 (make-closure L.fun/void8981.14.23 0)))
       (if (let ((void0.20 (closure-call fun/void8977.12 fun/void8977.12))
                 (boolean1.19
                  (closure-call
                   pair?.86
                   pair?.86
                   (closure-call
                    cons.85
                    cons.85
                    70
                    (closure-call cons.85 cons.85 501 empty))))
                 (empty2.18 (if #t empty empty)))
             (if #t (void) (void)))
         (if (if (closure-call fun/boolean8978.9 fun/boolean8978.9 #\P)
               (if #f (void) (void))
               (let ((tmp.7.21 (void))) (if tmp.7.21 tmp.7.21 (void))))
           (closure-call
            fun/void8979.11
            fun/void8979.11
            (let ((fixnum0.23 64) (empty1.22 empty))
              (let ((tmp.8.24 (closure-call make-vector.87 make-vector.87 8)))
                (let ((g43176926.25
                       (closure-call
                        vector-set!.88
                        vector-set!.88
                        tmp.8.24
                        0
                        1)))
                  (if (closure-call error?.89 error?.89 g43176926.25)
                    g43176926.25
                    (let ((g43176927.26
                           (closure-call
                            vector-set!.88
                            vector-set!.88
                            tmp.8.24
                            1
                            2)))
                      (if (closure-call error?.89 error?.89 g43176927.26)
                        g43176927.26
                        (let ((g43176928.27
                               (closure-call
                                vector-set!.88
                                vector-set!.88
                                tmp.8.24
                                2
                                3)))
                          (if (closure-call error?.89 error?.89 g43176928.27)
                            g43176928.27
                            (let ((g43176929.28
                                   (closure-call
                                    vector-set!.88
                                    vector-set!.88
                                    tmp.8.24
                                    3
                                    4)))
                              (if (closure-call
                                   error?.89
                                   error?.89
                                   g43176929.28)
                                g43176929.28
                                (let ((g43176930.29
                                       (closure-call
                                        vector-set!.88
                                        vector-set!.88
                                        tmp.8.24
                                        4
                                        5)))
                                  (if (closure-call
                                       error?.89
                                       error?.89
                                       g43176930.29)
                                    g43176930.29
                                    (let ((g43176931.30
                                           (closure-call
                                            vector-set!.88
                                            vector-set!.88
                                            tmp.8.24
                                            5
                                            6)))
                                      (if (closure-call
                                           error?.89
                                           error?.89
                                           g43176931.30)
                                        g43176931.30
                                        (let ((g43176932.31
                                               (closure-call
                                                vector-set!.88
                                                vector-set!.88
                                                tmp.8.24
                                                6
                                                7)))
                                          (if (closure-call
                                               error?.89
                                               error?.89
                                               g43176932.31)
                                            g43176932.31
                                            (let ((g43176933.32
                                                   (closure-call
                                                    vector-set!.88
                                                    vector-set!.88
                                                    tmp.8.24
                                                    7
                                                    8)))
                                              (if (closure-call
                                                   error?.89
                                                   error?.89
                                                   g43176933.32)
                                                g43176933.32
                                                tmp.8.24))))))))))))))))))
            (closure-call fun/procedure8982.10 fun/procedure8982.10))
           #f)
         #f)))))
(check-by-interp
 '(module
    (letrec ((L.>.73.10
              (lambda (c.75 tmp.43 tmp.44)
                (let ()
                  (if (fixnum? tmp.44)
                    (if (fixnum? tmp.43) (unsafe-fx> tmp.43 tmp.44) (error 6))
                    (error 6)))))
             (L.error?.72.11 (lambda (c.76 tmp.61) (let () (error? tmp.61))))
             (L.cons.71.12
              (lambda (c.77 tmp.66 tmp.67) (let () (cons tmp.66 tmp.67))))
             (L.fun/fixnum8985.7.13 (lambda (c.78 oprand0.8) (let () 23))))
      (cletrec
       ((>.73 (make-closure L.>.73.10 2))
        (error?.72 (make-closure L.error?.72.11 1))
        (cons.71 (make-closure L.cons.71.12 2))
        (fun/fixnum8985.7 (make-closure L.fun/fixnum8985.7.13 1)))
       (if (closure-call
            >.73
            >.73
            (closure-call
             fun/fixnum8985.7
             fun/fixnum8985.7
             (closure-call
              cons.71
              cons.71
              175
              (closure-call cons.71 cons.71 398 empty)))
            (let ((g43180749.9 21))
              (if (closure-call error?.72 error?.72 g43180749.9)
                g43180749.9
                (let ((g43180750.10 243))
                  (if (closure-call error?.72 error?.72 g43180750.10)
                    g43180750.10
                    (let ((g43180751.11 246))
                      (if (closure-call error?.72 error?.72 g43180751.11)
                        g43180751.11
                        (let ((g43180752.12 134))
                          (if (closure-call error?.72 error?.72 g43180752.12)
                            g43180752.12
                            (let ((g43180753.13 143))
                              (if (closure-call
                                   error?.72
                                   error?.72
                                   g43180753.13)
                                g43180753.13
                                (let ((g43180754.14 161))
                                  (if (closure-call
                                       error?.72
                                       error?.72
                                       g43180754.14)
                                    g43180754.14
                                    37)))))))))))))
         (let ((pair0.15
                (closure-call
                 cons.71
                 cons.71
                 131
                 (closure-call cons.71 cons.71 509 empty))))
           (void))
         (let ((procedure0.18
                (letrec ((L.lam.74.14 (lambda (c.79) (let () #\v))))
                  (cletrec ((lam.74 (make-closure L.lam.74.14 0))) lam.74)))
               (fixnum1.17 181)
               (pair2.16
                (closure-call
                 cons.71
                 cons.71
                 38
                 (closure-call cons.71 cons.71 400 empty))))
           (void)))))))
(check-by-interp
 '(module
    (letrec ((L.cons.64.10
              (lambda (c.65 tmp.59 tmp.60) (let () (cons tmp.59 tmp.60))))
             (L.fun/void8988.7.11
              (lambda (c.66)
                (let ((fun/void8990.9 (closure-ref c.66 0))
                      (cons.64 (closure-ref c.66 1))
                      (fun/boolean8989.8 (closure-ref c.66 2)))
                  (if (closure-call
                       fun/boolean8989.8
                       fun/boolean8989.8
                       (closure-call
                        cons.64
                        cons.64
                        233
                        (closure-call cons.64 cons.64 346 empty)))
                    (closure-call fun/void8990.9 fun/void8990.9 74)
                    (if #f (void) (void))))))
             (L.fun/boolean8989.8.12 (lambda (c.67 oprand0.10) (let () #f)))
             (L.fun/void8990.9.13 (lambda (c.68 oprand0.11) (let () (void)))))
      (cletrec
       ((cons.64 (make-closure L.cons.64.10 2))
        (fun/void8988.7
         (make-closure
          L.fun/void8988.7.11
          0
          fun/void8990.9
          cons.64
          fun/boolean8989.8))
        (fun/boolean8989.8 (make-closure L.fun/boolean8989.8.12 1))
        (fun/void8990.9 (make-closure L.fun/void8990.9.13 1)))
       (closure-call fun/void8988.7 fun/void8988.7)))))
(check-by-interp
 '(module
    (letrec ((L.fun/fixnum8993.7.10
              (lambda (c.64 oprand0.9)
                (let ((fun/fixnum8994.8 (closure-ref c.64 0)))
                  (closure-call fun/fixnum8994.8 fun/fixnum8994.8))))
             (L.fun/fixnum8994.8.11 (lambda (c.65) (let () (if #f 82 210)))))
      (cletrec
       ((fun/fixnum8993.7
         (make-closure L.fun/fixnum8993.7.10 1 fun/fixnum8994.8))
        (fun/fixnum8994.8 (make-closure L.fun/fixnum8994.8.11 0)))
       (closure-call
        fun/fixnum8993.7
        fun/fixnum8993.7
        (let ()
          (let ((empty0.10 empty))
            (letrec ((L.lam.63.12 (lambda (c.66) (let () 562))))
              (cletrec ((lam.63 (make-closure L.lam.63.12 0))) lam.63)))))))))
(check-by-interp
 '(module
    (letrec ((L.fun/error8998.7.10
              (lambda (c.69)
                (let ((fun/error8999.8 (closure-ref c.69 0)))
                  (closure-call fun/error8999.8 fun/error8999.8))))
             (L.fun/error8999.8.11 (lambda (c.70) (let () (error 87))))
             (L.fun/boolean9002.9.12 (lambda (c.71) (let () #t)))
             (L.fun/error8997.10.13
              (lambda (c.72 oprand0.13)
                (let ((fun/error8998.7 (closure-ref c.72 0)))
                  (closure-call fun/error8998.7 fun/error8998.7))))
             (L.fun/boolean9001.11.14
              (lambda (c.73)
                (let ((fun/boolean9002.9 (closure-ref c.73 0)))
                  (closure-call fun/boolean9002.9 fun/boolean9002.9))))
             (L.fun/procedure9000.12.15
              (lambda (c.74 oprand0.14)
                (let ()
                  (if oprand0.14
                    (letrec ((L.lam.67.16 (lambda (c.75) (let () 608))))
                      (cletrec ((lam.67 (make-closure L.lam.67.16 0))) lam.67))
                    (letrec ((L.lam.68.17 (lambda (c.76) (let () 525))))
                      (cletrec
                       ((lam.68 (make-closure L.lam.68.17 0)))
                       lam.68)))))))
      (cletrec
       ((fun/error8998.7 (make-closure L.fun/error8998.7.10 0 fun/error8999.8))
        (fun/error8999.8 (make-closure L.fun/error8999.8.11 0))
        (fun/boolean9002.9 (make-closure L.fun/boolean9002.9.12 0))
        (fun/error8997.10
         (make-closure L.fun/error8997.10.13 1 fun/error8998.7))
        (fun/boolean9001.11
         (make-closure L.fun/boolean9001.11.14 0 fun/boolean9002.9))
        (fun/procedure9000.12 (make-closure L.fun/procedure9000.12.15 1)))
       (closure-call
        fun/error8997.10
        fun/error8997.10
        (closure-call
         fun/procedure9000.12
         fun/procedure9000.12
         (closure-call fun/boolean9001.11 fun/boolean9001.11)))))))
